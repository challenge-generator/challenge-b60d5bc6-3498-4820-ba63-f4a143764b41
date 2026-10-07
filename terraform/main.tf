terraform {
  required_version = ">= 1.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.23"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.11"
    }
  }

  backend "s3" {
    bucket = "${var.project_name}-terraform-state"
    key    = "prod/terraform.tfstate"
    region = var.aws_region
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "Terraform"
    }
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = "${var.project_name}-vpc"
  cidr = var.vpc_cidr

  azs             = data.aws_availability_zones.available.names
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  enable_nat_gateway   = true
  single_nat_gateway   = false
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Type = "VPC for ${var.project_name} - ${var.environment}"
  }
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.0"

  cluster_name    = "${var.project_name}-${var.environment}"
  cluster_version = var.kubernetes_version

  vpc_id                         = module.vpc.vpc_id
  subnet_ids                     = concat(module.vpc.private_subnets, module.vpc.public_subnets)
  cluster_endpoint_public_access = true

  eks_managed_node_group_defaults = {
    ami_type       = "AL2_x86_64"
    instance_types = ["t3.medium"]
  }

  eks_managed_node_groups = {
    primary = {
      name = "primary-node-group"

      instance_types = [var.node_instance_type]
      capacity_type  = "ON_DEMAND"

      min_size     = var.node_group_min_size
      max_size     = var.node_group_max_size
      desired_size = var.node_group_desired_size

      vpc_subnet_ids = module.vpc.private_subnets

      labels = {
        Environment = var.environment
        NodeGroup   = "primary"
      }
    }
  }

  tags = {
    Environment = var.environment
    Type        = "EKS Cluster for ${var.project_name}"
  }
}

module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 8.0"

  name = "${var.project_name}-alb"

  load_balancer_type = "application"
  vpc_id             = module.vpc.vpc_id
  subnets            = module.vpc.public_subnets
  security_groups    = [module.alb_security_group.security_group_id]

  enable_deletion_protection = var.alb_deletion_protection

  target_groups = [
    {
      name_prefix      = "blue"
      backend_protocol = "HTTP"
      backend_port     = 80
      target_type      = "ip"
      health_check = {
        enabled             = true
        healthy_threshold   = 2
        unhealthy_threshold = 2
        timeout             = 5
        interval            = 30
        path                = var.health_check_path
        matcher             = "200"
      }
    },
    {
      name_prefix      = "green"
      backend_protocol = "HTTP"
      backend_port     = 80
      target_type      = "ip"
      health_check = {
        enabled             = true
        healthy_threshold   = 2
        unhealthy_threshold = 2
        timeout             = 5
        interval            = 30
        path                = var.health_check_path
        matcher             = "200"
      }
    },
    {
      name_prefix      = "canary"
      backend_protocol = "HTTP"
      backend_port     = 80
      target_type      = "ip"
      health_check = {
        enabled             = true
        healthy_threshold   = 2
        unhealthy_threshold = 2
        timeout             = 5
        interval            = 30
        path                = var.health_check_path
        matcher             = "200"
      }
    }
  ]

  tags = {
    Environment = var.environment
    Type        = "Application Load Balancer for ${var.project_name}"
  }
}

module "alb_security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 5.0"

  name        = "${var.project_name}-alb-sg"
  description = "Security group for ALB"
  vpc_id      = module.vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
      description = "HTTP traffic"
    },
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
      description = "HTTPS traffic"
    }
  ]

  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = "0.0.0.0/0"
      description = "Allow all outbound"
    }
  ]

  tags = {
    Environment = var.environment
  }
}

module "eks_security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 5.0"

  name        = "${var.project_name}-eks-sg"
  description = "Security group for EKS nodes"
  vpc_id      = module.vpc.vpc_id

  ingress_with_source_security_group_id = [
    {
      from_port       = 80
      to_port         = 80
      protocol        = "tcp"
      description     = "HTTP from ALB"
      source_security_group_id = module.alb_security_group.security_group_id
    },
    {
      from_port       = 443
      to_port         = 443
      protocol        = "tcp"
      description     = "HTTPS from ALB"
      source_security_group_id = module.alb_security_group.security_group_id
    }
  ]

  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = "0.0.0.0/0"
      description = "Allow all outbound"
    }
  ]

  tags = {
    Environment = var.environment
  }
}

module "blue_green_deployment" {
  source = "./modules/blue_green"

  providers = {
    aws = aws
  }

  project_name        = var.project_name
  environment         = var.environment
  eks_cluster_name    = module.eks.cluster_name
  alb_arn_suffix      = module.alb.arn_suffix
  target_group_blue   = module.alb.target_group_arns[0]
  target_group_green  = module.alb.target_group_arns[1]
  vpc_id              = module.vpc.vpc_id
  eks_security_group  = module.eks_security_group.security_group_id

  blue_version = var.blue_version
  green_version = var.green_version

  canary_traffic_percentage = 0
  auto_swap_on_test = var.auto_swap_on_test
  test_duration_minutes = var.test_duration_minutes
}

module "ab_testing" {
  source = "./modules/ab_testing"

  providers = {
    aws = aws
  }

  project_name       = var.project_name
  environment        = var.environment
  eks_cluster_name   = module.eks.cluster_name
  alb_arn_suffix     = module.alb.arn_suffix
  target_group_blue  = module.alb.target_group_arns[0]
  target_group_green = module.alb.target_group_arns[1]
  vpc_id             = module.vpc.vpc_id

  version_a = var.version_a
  version_b = var.version_b
  traffic_split_percentage = var.ab_traffic_split_percentage
  cookie_name = var.ab_cookie_name
  cookie_ttl_hours = var.ab_cookie_ttl_hours
}

module "canary_deployment" {
  source = "./modules/canary"

  providers = {
    aws = aws
  }

  project_name        = var.project_name
  environment         = var.environment
  eks_cluster_name    = module.eks.cluster_name
  alb_arn_suffix      = module.alb.arn_suffix
  target_group_canary = module.alb.target_group_arns[2]
  vpc_id              = module.vpc.vpc_id
  eks_security_group  = module.eks_security_group.security_group_id

  canary_version = var.canary_version
  canary_traffic_percentage = var.canary_traffic_percentage
  auto_promote_after_minutes = var.canary_auto_promote_after_minutes
  rollback_on_failure = var.canary_rollback_on_failure
}

resource "kubernetes_namespace" "production" {
  metadata {
    name = var.production_namespace

    labels = {
      environment = var.environment
      project     = var.project_name
    }
  }
}

resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = var.monitoring_namespace

    labels = {
      environment = var.environment
      project     = var.project_name
    }
  }
}

resource "helm_release" "prometheus" {
  name       = "prometheus"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "prometheus"
  version    = var.prometheus_version
  namespace  = var.monitoring_namespace

  set {
    name  = "server.persistentVolume.enabled"
    value = "true"
  }

  set {
    name  = "server.persistentVolume.size"
    value = var.prometheus_storage_size
  }

  set {
    name  = "alertmanager.enabled"
    value = "true"
  }

  set {
    name  = "pushgateway.enabled"
    value = "true"
  }

  set {
    name  = "prometheus.retention"
    value = var.prometheus_retention_days
  }

  depends_on = [kubernetes_namespace.monitoring]
}

resource "helm_release" "grafana" {
  name       = "grafana"
  repository = "https://grafana.github.io/helm-charts"
  chart      = "grafana"
  version    = var.grafana_version
  namespace  = var.monitoring_namespace

  set {
    name  = "persistence.enabled"
    value = "true"
  }

  set {
    name  = "persistence.size"
    value = var.grafana_storage_size
  }

  set {
    name  = "adminPassword"
    value = var.grafana_admin_password
  }

  set {
    name  = "datasources.datasources\"[0]\" .type"
    value = "prometheus"
  }

  set {
    name  = "datasources.datasources\"[0]\" .uid"
    value = "prometheus"
  }

  depends_on = [kubernetes_namespace.monitoring, helm_release.prometheus]
}

resource "aws_iam_role" "github_actions" {
  name = "${var.project_name}-github-actions-${var.environment}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRoleWithWebIdentity"
        Effect = "Allow"
        Principal = {
          Federated = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/${replace(module.eks.cluster_oidc_issuer_url, "https://", "")}"
        }
        Condition = {
          StringEquals = {
            "${replace(module.eks.cluster_oidc_issuer_url, "https://", "")}:sub" = "system:serviceaccount:github-actions:github-actions"
          }
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "github_actions_eks" {
  role       = aws_iam_role.github_actions.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_iam_role_policy_attachment" "github_actions_cw" {
  role       = aws_iam_role.github_actions.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
}

resource "aws_iam_role_policy_attachment" "github_actions_s3" {
  role       = aws_iam_role.github_actions.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_role_policy_attachment" "github_actions_ecr" {
  role       = aws_iam_role.github_actions.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess"
}

resource "aws_iam_role" "eks_fargate_profile" {
  name = "${var.project_name}-eks-fargate-${var.environment}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "eks-fargate-pods.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "eks_fargate_cw" {
  role       = aws_iam_role.eks_fargate_profile.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
}

resource "aws_eks_fargate_profile" "monitoring" {
  cluster_name = module.eks.cluster_name
  fargate_profile_name = "monitoring"

  pod_execution_role_arn = aws_iam_role.eks_fargate_profile.arn

  subnet_ids = module.vpc.private_subnets

  selector {
    namespace = var.monitoring_namespace
    labels = {
      "monitoring" = "enabled"
    }
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_fargate_cw
  ]
}

resource "aws_cloudwatch_metric_alarm" "high_error_rate" {
  alarm_name          = "${var.project_name}-high-error-rate-${var.environment}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "HTTPCode_Target_5XX_Count"
  namespace           = "AWS/ApplicationELB"
  period              = "60"
  statistic           = "Sum"
  threshold           = var.error_rate_threshold
  alarm_description   = "This metric monitors high error rate"
  treat_missing_data  = "notBreaching"

  dimensions = {
    LoadBalancer = module.alb.arn_suffix
  }
}

resource "aws_cloudwatch_metric_alarm" "high_latency" {
  alarm_name          = "${var.project_name}-high-latency-${var.environment}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "TargetResponseTime"
  namespace           = "AWS/ApplicationELB"
  period              = "60"
  statistic           = "Average"
  threshold           = var.latency_threshold_ms
  alarm_description   = "This metric monitors high latency"
  treat_missing_data  = "notBreaching"

  dimensions = {
    LoadBalancer = module.alb.arn_suffix
  }
}

resource "aws_cloudwatch_metric_alarm" "target_group_unhealthy" {
  for_each = toset(["blue", "green", "canary"])

  alarm_name          = "${var.project_name}-${each.value}-unhealthy-hosts-${var.environment}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "UnhealthyHostCount"
  namespace           = "AWS/ApplicationELB"
  period              = "60"
  statistic           = "Maximum"
  threshold           = "1"
  alarm_description   = "This metric monitors unhealthy hosts in ${each.value} target group"
  treat_missing_data  = "notBreaching"

  dimensions = {
    LoadBalancer = module.alb.arn_suffix
    TargetGroup  = module.alb.target_group_arns[0]
  }
}

resource "aws_sns_topic" "alerts" {
  name = "${var.project_name}-alerts-${var.environment}"

  tags = {
    Environment = var.environment
    Project     = var.project_name
  }
}

resource "aws_sns_topic_subscription" "alerts_email" {
  topic_arn = aws_sns_topic.alerts.arn
  protocol  = "email"
  endpoint  = var.alert_email
}

resource "aws_cloudwatch_metric_alarm" "sns_alarm" {
  alarm_name          = "${var.project_name}-alert-${var.environment}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "Errors"
  namespace           = "AWS/Lambda"
  period              = "60"
  statistic           = "Sum"
  threshold           = "0"
  alarm_description   = "Trigger SNS for all alarms"

  alarm_actions = [aws_sns_topic.alerts.arn]
  ok_actions    = [aws_sns_topic.alerts.arn]
}

data "aws_caller_identity" "current" {}