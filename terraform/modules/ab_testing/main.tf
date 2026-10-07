locals {
  ab_tags = merge(var.common_tags, {
    Strategy = "ab-testing"
    Environment = var.environment
  })
}

# ============================================================================
#ab_testing/main.tf - Módulo de Despliegue A/B Testing para AWS
#Este módulo implementa una estrategia de despliegue A/B que permite probar
#nuevas funcionalidades en un subconjunto de usuarios con routing basado en
#percentuales de tráfico configurables.
#============================================================================

# --------------------------------------------------------------------------
# Security Groups para versiones A y B
# --------------------------------------------------------------------------
resource "aws_security_group" "version_a" {
  name        = "${var.prefix}-version-a-sg"
  description = "Security group para versión A del servicio"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr_blocks
    description = "HTTPS desde ALB"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = local.ab_tags
}

resource "aws_security_group" "version_b" {
  name        = "${var.prefix}-version-b-sg"
  description = "Security group para versión B del servicio"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr_blocks
    description = "HTTPS desde ALB"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = local.ab_tags
}

# --------------------------------------------------------------------------
# Target Groups para versiones A y B con weighted routing
# --------------------------------------------------------------------------
resource "aws_lb_target_group" "version_a" {
  name     = "${var.prefix}-version-a-tg"
  port     = var.app_port
  protocol = var.app_protocol
  vpc_id   = var.vpc_id
  target_type = "ip"

  health_check {
    enabled             = true
    healthy_threshold   = 2
    unhealthy_threshold = 5
    timeout             = 30
    interval            = 60
    path                = var.health_check_path
    matcher             = "200"
  }

  tags = local.ab_tags
}

resource "aws_lb_target_group" "version_b" {
  name     = "${var.prefix}-version-b-tg"
  port     = var.app_port
  protocol = var.app_protocol
  vpc_id   = var.vpc_id
  target_type = "ip"

  health_check {
    enabled             = true
    healthy_threshold   = 2
    unhealthy_threshold = 5
    timeout             = 30
    interval            = 60
    path                = var.health_check_path
    matcher             = "200"
  }

  tags = local.ab_tags
}

# --------------------------------------------------------------------------
# Application Load Balancer para A/B Testing
# --------------------------------------------------------------------------
resource "aws_lb" "ab_testing" {
  name               = "${var.prefix}-ab-alb"
  internal           = var.internal_alb
  load_balancer_type = "application"
  security_groups    = [aws_security_group.version_a.id]
  subnets            = var.subnet_ids

  enable_deletion_protection = var.enable_deletion_protection

  tags = local.ab_tags
}

resource "aws_lb_listener" "ab_https" {
  load_balancer_arn = aws_lb.ab_testing.arn
  port              = var.alb_port
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.acm_certificate_arn

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.version_a.arn
  }
}

# --------------------------------------------------------------------------
# Reglas de weighted routing basadas en cookies y headers
# --------------------------------------------------------------------------
resource "aws_lb_listener_rule" "version_a_cookie" {
  listener_arn = aws_lb_listener.ab_https.arn
  priority     = 200

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.version_a.arn
  }

  condition {
    cookie {
      name = "ABVersion"
      values = ["A"]
    }
  }
}

resource "aws_lb_listener_rule" "version_b_cookie" {
  listener_arn = aws_lb_listener.ab_https.arn
  priority     = 201

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.version_b.arn
  }

  condition {
    cookie {
      name = "ABVersion"
      values = ["B"]
    }
  }
}

resource "aws_lb_listener_rule" "version_a_header" {
  listener_arn = aws_lb_listener.ab_https.arn
  priority     = 202

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.version_a.arn
  }

  condition {
    http_header {
      http_header_name = "X-App-Version"
      values           = ["v1", "v1.0", "v1.0.0"]
    }
  }
}

resource "aws_lb_listener_rule" "version_b_header" {
  listener_arn = aws_lb_listener.ab_https.arn
  priority     = 203

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.version_b.arn
  }

  condition {
    http_header {
      http_header_name = "X-App-Version"
      values           = ["v2", "v2.0", "v2.0.0"]
    }
  }
}

# --------------------------------------------------------------------------
# Lambda@Edge para asignación de usuarios a versiones
# --------------------------------------------------------------------------
resource "aws_iam_role" "lambda_edge_role" {
  name = "${var.prefix}-ab-lambda-edge-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = ["lambda.amazonaws.com", "edgelambda.amazonaws.com"]
      }
    }]
  })
}

resource "aws_lambda_function" "ab_router" {
  filename         = var.lambda_zip_path
  function_name    = "${var.prefix}-ab-router"
  role            = aws_iam_role.lambda_edge_role.arn
  handler         = "router.handler"
  source_code_hash = var.lambda_source_hash
  runtime         = "python3.11"
  timeout         = 30
  memory_size     = 128

  environment {
    variables = {
      VERSION_A_WEIGHT = var.version_a_weight
      VERSION_B_WEIGHT = var.version_b_weight
      COOKIE_NAME      = "ABVersion"
      COOKIE_MAX_AGE   = "86400"
    }
  }

  tags = local.ab_tags
}

# --------------------------------------------------------------------------
# CloudFront Distribution para A/B Testing global
# --------------------------------------------------------------------------
resource "aws_cloudfront_distribution" "ab_distribution" {
  enabled = true
  comment = "A/B Testing para ${var.service_name}"

  origin {
    domain_name = aws_lb.ab_testing.dns_name
    origin_id   = "alb-origin"
    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "match-viewer"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }

  default_cache_behavior {
    allowed_methods        = ["GET", "POST", "PUT", "DELETE", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = "alb-origin"
    viewer_protocol_policy = "redirect-to-https"
    compress               = true

    forwarded_values {
      query_string = true
      cookies {
        forward = "all"
      }
    }
  }

  price_class = var.price_class

  viewer_certificate {
    acm_certificate_arn = var.acm_certificate_arn
    ssl_support_method  = "sni-only"
  }

  tags = local.ab_tags
}

# --------------------------------------------------------------------------
# DNS Route53 para dominios A/B
# --------------------------------------------------------------------------
resource "aws_route53_record" "version_a" {
  zone_id = var.hosted_zone_id
  name    = var.version_a_domain
  type    = "CNAME"
  ttl     = 300
  records = [aws_lb.ab_testing.dns_name]
}

resource "aws_route53_record" "version_b" {
  zone_id = var.hosted_zone_id
  name    = var.version_b_domain
  type    = "CNAME"
  ttl     = 300
  records = [aws_lb.ab_testing.dns_name]
}

resource "aws_route53_record" "ab_primary" {
  zone_id = var.hosted_zone_id
  name    = var.primary_domain
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.ab_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.ab_distribution.hosted_zone_id
    evaluate_target_health = true
  }
}

# --------------------------------------------------------------------------
# DynamoDB para tracking de conversiones A/B
# --------------------------------------------------------------------------
resource "aws_dynamodb_table" "ab_metrics" {
  name           = "${var.prefix}-ab-metrics"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "session_id"
  range_key      = "timestamp"

  attribute {
    name = "session_id"
    type = "S"
  }

  attribute {
    name = "timestamp"
    type = "N"
  }

  attribute {
    name = "version"
    type = "S"
  }

  global_secondary_index {
    name            = "version-index"
    hash_key        = "version"
    range_key       = "timestamp"
    projection_type = "ALL"
  }

  server_side_encryption {
    enabled = true
  }

  tags = local.ab_tags
}

# --------------------------------------------------------------------------
# SNS Topic para métricas A/B
# --------------------------------------------------------------------------
resource "aws_sns_topic" "ab_metrics" {
  name = "${var.prefix}-ab-metrics"

  tags = local.ab_tags
}

resource "aws_sns_topic_subscription" "ab_alerts" {
  topic_arn = aws_sns_topic.ab_metrics.arn
  protocol  = "email"
  endpoint  = var.notification_email
}