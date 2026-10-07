locals {
  blue_green_tags = merge(var.common_tags, {
    Strategy = "blue-green"
    Environment = var.environment
  })
}

# ============================================================================
#blue_green/main.tf - Módulo de Despliegue Blue-Green para AWS
#Este módulo implementa una estrategia de despliegue Blue-Green que permite
#tener dos entornos idénticos y realizar transiciones controladas de tráfico.
#============================================================================

data "aws_availability_zones" "available" {
  state = "available"
}

# --------------------------------------------------------------------------
# Security Groups para los entornos Blue y Green
# --------------------------------------------------------------------------
resource "aws_security_group" "blue" {
  name        = "${var.prefix}-blue-sg"
  description = "Security group para el entorno Blue"
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
    description = "Egreso permitido a Internet"
  }

  tags = local.blue_green_tags
}

resource "aws_security_group" "green" {
  name        = "${var.prefix}-green-sg"
  description = "Security group para el entorno Green"
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
    description = "Egreso permitido a Internet"
  }

  tags = local.blue_green_tags
}

# --------------------------------------------------------------------------
# Target Groups para Blue y Green
# --------------------------------------------------------------------------
resource "aws_lb_target_group" "blue" {
  name     = "${var.prefix}-blue-tg"
  port     = var.app_port
  protocol = var.app_protocol
  vpc_id   = var.vpc_id

  health_check {
    enabled             = true
    healthy_threshold   = 2
    unhealthy_threshold = 5
    timeout             = 30
    interval            = 60
    path                = var.health_check_path
    matcher             = "200"
  }

  tags = local.blue_green_tags
}

resource "aws_lb_target_group" "green" {
  name     = "${var.prefix}-green-tg"
  port     = var.app_port
  protocol = var.app_protocol
  vpc_id   = var.vpc_id

  health_check {
    enabled             = true
    healthy_threshold   = 2
    unhealthy_threshold = 5
    timeout             = 30
    interval            = 60
    path                = var.health_check_path
    matcher             = "200"
  }

  tags = local.blue_green_tags
}

# --------------------------------------------------------------------------
# Application Load Balancer con listeners para Blue-Green
# --------------------------------------------------------------------------
resource "aws_lb" "blue_green" {
  name               = "${var.prefix}-bg-alb"
  internal           = var.internal_alb
  load_balancer_type = "application"
  security_groups    = [aws_security_group.blue.id]
  subnets            = var.subnet_ids

  enable_deletion_protection = var.enable_deletion_protection

  tags = local.blue_green_tags
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.blue_green.arn
  port              = var.alb_port
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.acm_certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = var.active_environment == "blue" ? aws_lb_target_group.blue.arn : aws_lb_target_group.green.arn
  }
}

# --------------------------------------------------------------------------
# Reglas de listener para routing condicional
# --------------------------------------------------------------------------
resource "aws_lb_listener_rule" "blue_traffic" {
  listener_arn = aws_lb_listener.https.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.blue.arn
  }

  condition {
    http_header {
      http_header_name = "X-Blue-Deploy"
      values           = ["true"]
    }
  }
}

resource "aws_lb_listener_rule" "green_traffic" {
  listener_arn = aws_lb_listener.https.arn
  priority     = 101

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.green.arn
  }

  condition {
    http_header {
      http_header_name = "X-Green-Deploy"
      values           = ["true"]
    }
  }
}

# --------------------------------------------------------------------------
# DNS Route53 para Blue-Green
# --------------------------------------------------------------------------
resource "aws_route53_record" "blue" {
  zone_id = var.hosted_zone_id
  name    = var.blue_domain
  type    = "A"

  alias {
    name                   = aws_lb.blue_green.dns_name
    zone_id                = aws_lb.blue_green.zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "green" {
  zone_id = var.hosted_zone_id
  name    = var.green_domain
  type    = "A"

  alias {
    name                   = aws_lb.blue_green.dns_name
    zone_id                = aws_lb.blue_green.zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "primary" {
  zone_id = var.hosted_zone_id
  name    = var.primary_domain
  type    = "A"

  alias {
    name                   = aws_lb.blue_green.dns_name
    zone_id                = aws_lb.blue_green.zone_id
    evaluate_target_health = true
  }
}

# --------------------------------------------------------------------------
# Lambda para orquestación de transición Blue-Green
# --------------------------------------------------------------------------
resource "aws_iam_role" "lambda_role" {
  name = "${var.prefix}-bg-lambda-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_basic" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_lambda_function" "traffic_switch" {
  filename         = var.lambda_zip_path
  function_name    = "${var.prefix}-bg-traffic-switch"
  role            = aws_iam_role.lambda_role.arn
  handler         = "index.handler"
  source_code_hash = var.lambda_source_hash
  runtime         = "python3.11"
  timeout         = 300
  memory_size     = 256

  environment {
    variables = {
      ACTIVE_ENVIRONMENT = var.active_environment
      BLUE_TG_ARN        = aws_lb_target_group.blue.arn
      GREEN_TG_ARN       = aws_lb_target_group.green.arn
      LISTENER_ARN       = aws_lb_listener.https.arn
    }
  }

  tags = local.blue_green_tags
}

# --------------------------------------------------------------------------
# SNS Topic para notificaciones de despliegue
# --------------------------------------------------------------------------
resource "aws_sns_topic" "deployments" {
  name = "${var.prefix}-bg-deployments"

  tags = local.blue_green_tags
}

resource "aws_sns_topic_subscription" "deploy_notify" {
  topic_arn = aws_sns_topic.deployments.arn
  protocol  = "email"
  endpoint  = var.notification_email
}

# --------------------------------------------------------------------------
# CloudWatch Logs para auditoría de despliegues
# --------------------------------------------------------------------------
resource "aws_cloudwatch_log_group" "deployment_audit" {
  name              = "/aws/${var.prefix}/blue-green/deployments"
  retention_in_days = 30

  tags = local.blue_green_tags
}