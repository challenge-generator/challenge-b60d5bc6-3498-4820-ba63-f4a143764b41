variable "aws_region" {
  description = "La región de AWS donde se desplegará la infraestructura."
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "El entorno de despliegue (staging, prod)."
  type        = string
}

variable "cluster_name" {
  description = "Nombre del cluster de EKS."
  type        = string
  default     = "transaction-processor-cluster"
}

variable "vpc_cidr" {
  description = "Rango CIDR para la VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "private_subnets" {
  description = "Lista de CIDRs para subnets privadas."
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "public_subnets" {
  description = "Lista de CIDRs para subnets públicas."
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}

variable "blue_green_enabled" {
  description = "Habilita la estrategia Blue-Green."
  type        = bool
  default     = true
}

variable "ab_testing_enabled" {
  description = "Habilita la estrategia A/B Testing."
  type        = bool
  default     = false
}

variable "canary_enabled" {
  description = "Habilita la estrategia Canary."
  type        = bool
  default     = false
}

variable "blue_target_group_arn" {
  description = "ARN del Target Group para la versión Blue."
  type        = string
  default     = ""
}

variable "green_target_group_arn" {
  description = "ARN del Target Group para la versión Green."
  type        = string
  default     = ""
}

variable "ab_target_group_arn_a" {
  description = "ARN del Target Group para la versión A en A/B Testing."
  type        = string
  default     = ""
}

variable "ab_target_group_arn_b" {
  description = "ARN del Target Group para la versión B en A/B Testing."
  type        = string
  default     = ""
}

variable "canary_target_group_arn" {
  description = "ARN del Target Group para la versión Canary."
  type        = string
  default     = ""
}

variable "canary_weight" {
  description = "Porcentaje de tráfico dirigido a la versión Canary (0-100)."
  type        = number
  default     = 10
}

variable "alb_name" {
  description = "Nombre del Application Load Balancer."
  type        = string
  default     = "transaction-processor-alb"
}

variable "listener_port" {
  description = "Puerto del listener del ALB."
  type        = number
  default     = 80
}

variable "listener_protocol" {
  description = "Protocolo del listener del ALB."
  type        = string
  default     = "HTTP"
}

variable "health_check_path" {
  description = "Ruta para el health check del ALB."
  type        = string
  default     = "/health"
}

variable "health_check_port" {
  description = "Puerto para el health check del ALB."
  type        = number
  default     = 80
}

variable "health_check_protocol" {
  description = "Protocolo para el health check del ALB."
  type        = string
  default     = "HTTP"
}

variable "health_check_interval" {
  description = "Intervalo entre health checks en segundos."
  type        = number
  default     = 30
}

variable "health_check_timeout" {
  description = "Timeout para el health check en segundos."
  type        = number
  default     = 5
}

variable "healthy_threshold" {
  description = "Número de health checks exitosos para considerar un target como saludable."
  type        = number
  default     = 2
}

variable "unhealthy_threshold" {
  description = "Número de health checks fallidos para considerar un target como no saludable."
  type        = number
  default     = 2
}

variable "deployment_strategy" {
  description = "Estrategia de despliegue a utilizar (blue_green, ab_testing, canary)."
  type        = string
  default     = "blue_green"
}

variable "prometheus_enabled" {
  description = "Habilita la integración con Prometheus para monitoreo."
  type        = bool
  default     = true
}

variable "grafana_enabled" {
  description = "Habilita la integración con Grafana para visualización."
  type        = bool
  default     = true
}

variable "sonarcloud_enabled" {
  description = "Habilita el escaneo con SonarCloud en el pipeline."
  type        = bool
  default     = true
}

variable "trivy_enabled" {
  description = "Habilita el escaneo de vulnerabilidades con Trivy."
  type        = bool
  default     = true
}

variable "checkov_enabled" {
  description = "Habilita el análisis de IaC con Checkov."
  type        = bool
  default     = true
}

variable "sla_target" {
  description = "SLA objetivo en porcentaje (ej. 99.9)."
  type        = number
  default     = 99.9
}