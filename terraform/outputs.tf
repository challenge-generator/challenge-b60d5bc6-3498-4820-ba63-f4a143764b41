output "vpc_id" {
  description = "ID de la VPC creada"
  value       = module.vpc.vpc_id
}

output "vpc_cidr" {
  description = "CIDR de la VPC"
  value       = module.vpc.vpc_cidr_block
}

output "private_subnet_ids" {
  description = "IDs de las subnets privadas"
  value       = module.vpc.private_subnet_ids
}

output "public_subnet_ids" {
  description = "IDs de las subnets públicas"
  value       = module.vpc.public_subnet_ids
}

output "eks_cluster_name" {
  description = "Nombre del cluster EKS"
  value       = module.eks.cluster_name
}

output "eks_cluster_endpoint" {
  description = "Endpoint del cluster EKS"
  value       = module.eks.cluster_endpoint
}

output "eks_cluster_arn" {
  description = "ARN del cluster EKS"
  value       = module.eks.cluster_arn
}

output "eks_oidc_provider" {
  description = "OIDC Provider del cluster EKS"
  value       = module.eks.cluster_oidc_issuer_url
}

output "alb_arn" {
  description = "ARN del Application Load Balancer"
  value       = module.alb.arn
}

output "alb_dns_name" {
  description = "DNS name del ALB"
  value       = module.alb.dns_name
}

output "alb_zone_id" {
  description = "Zone ID del ALB para Route53"
  value       = module.alb.zone_id
}

output "alb_target_group_blue_arn" {
  description = "ARN del target group blue"
  value       = module.alb.target_group_arns[0]
}

output "alb_target_group_green_arn" {
  description = "ARN del target group green"
  value       = module.alb.target_group_arns[1]
}

output "alb_target_group_canary_arn" {
  description = "ARN del target group canary"
  value       = module.alb.target_group_arns[2]
}

output "blue_green_outputs" {
  description = "Outputs del módulo de despliegue Blue-Green"
  value = {
    listener_arn         = module.blue_green_deployment.listener_arn
    blue_target_group    = module.blue_green_deployment.blue_target_group_arn
    green_target_group   = module.blue_green_deployment.green_target_group_arn
    active_version       = module.blue_green_deployment.active_version
    inactive_version     = module.blue_green_deployment.inactive_version
  }
}

output "ab_testing_outputs" {
  description = "Outputs del módulo de A/B Testing"
  value = {
    listener_arn            = module.ab_testing.listener_arn
    target_group_a_arn      = module.ab_testing.target_group_a_arn
    target_group_b_arn      = module.ab_testing.target_group_b_arn
    version_a_active        = module.ab_testing.version_a_active
    version_b_active        = module.ab_testing.version_b_active
    traffic_split_percentage = module.ab_testing.active_traffic_split
  }
}

output "canary_outputs" {
  description = "Outputs del módulo de despliegue Canary"
  value = {
    listener_arn                 = module.canary_deployment.listener_arn
    canary_target_group_arn      = module.canary_deployment.canary_target_group_arn
    canary_version               = module.canary_deployment.canary_version
    active_traffic_percentage    = module.canary_deployment.active_traffic_percentage
    is_promoted                  = module.canary_deployment.is_promoted
  }
}

output "prometheus_endpoint" {
  description = "Endpoint de Prometheus"
  value       = "http://prometheus.${var.monitoring_namespace}.svc.cluster.local:9090"
}

output "grafana_endpoint" {
  description = "Endpoint de Grafana"
  value       = "http://grafana.${var.monitoring_namespace}.svc.cluster.local:3000"
}

output "grafana_admin_user" {
  description = "Usuario admin de Grafana"
  value       = "admin"
  sensitive   = false
}

output "monitoring_namespace" {
  description = "Namespace de Kubernetes para monitoreo"
  value       = var.monitoring_namespace
}

output "production_namespace" {
  description = "Namespace de Kubernetes para producción"
  value       = var.production_namespace
}

output "alert_sns_topic_arn" {
  description = "ARN del topic SNS para alertas"
  value       = aws_sns_topic.alerts.arn
}

output "alert_email" {
  description = "Email配置ado para recibir alertas"
  value       = var.alert_email
}

output "error_rate_alarm" {
  description = "Nombre del alarm para tasa de errores"
  value       = aws_cloudwatch_metric_alarm.high_error_rate.alarm_name
}

output "latency_alarm" {
  description = "Nombre del alarm para latencia"
  value       = aws_cloudwatch_metric_alarm.high_latency.alarm_name
}

output "github_actions_role_arn" {
  description = "ARN del rol IAM para GitHub Actions"
  value       = aws_iam_role.github_actions.arn
}

output "sla_target" {
  description = "Objetivo de SLA"
  value       = "99.9%"
}

output "service_url" {
  description = "URL pública del servicio desplegado"
  value       = "https://${var.domain_name}"
}

output "health_check_url" {
  description = "URL para health check del servicio"
  value       = "https://${var.domain_name}${var.health_check_path}"
}