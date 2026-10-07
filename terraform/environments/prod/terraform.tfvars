project_name = "financial-transaction-processor"
environment = "prod"
aws_region = "us-east-1"

# Configuración de red
vpc_cidr           = "10.0.0.0/16"
private_subnets    = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
public_subnets     = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

# Configuración de EKS
kubernetes_version = "1.28"
node_instance_type = "m6i.xlarge"
node_group_min_size     = 3
node_group_max_size     = 10
node_group_desired_size = 5

# Configuración del ALB
alb_deletion_protection = true
health_check_path       = "/health"

# Dominio y DNS
domain_name = "transactions.financialcorp.com"

# Namespaces
production_namespace = "production"
monitoring_namespace = "monitoring"

# Versiones para Blue-Green
blue_version  = "v1.0.0"
green_version = "v1.1.0"
auto_swap_on_test       = true
test_duration_minutes   = 30

# Configuración A/B Testing
version_a = "v1.0.0"
version_b = "v1.1.0"
ab_traffic_split_percentage = 20
ab_cookie_name      = "ab_version"
ab_cookie_ttl_hours = 24

# Configuración Canary
canary_version               = "v1.1.0"
canary_traffic_percentage    = 10
canary_auto_promote_after_minutes = 60
canary_rollback_on_failure   = true

# Configuración de monitoreo
prometheus_version      = "25.8.0"
prometheus_storage_size = "50Gi"
prometheus_retention_days = 30

grafana_version      = "8.0.0"
grafana_storage_size = "10Gi"
grafana_admin_password = "CHANGE_ME_IN_SECRETS_MANAGER"

# Alertas
alert_email         = "devops-alerts@financialcorp.com"
error_rate_threshold = 100
latency_threshold_ms = 500

# Configuración de auto-scaling
autoscaling_min_replicas = 3
autoscaling_max_replicas = 15
autoscaling_target_cpu_percentage = 70
autoscaling_target_memory_percentage = 80

# Configuración de base de datos
db_instance_class    = "db.r6g.2xlarge"
db_allocated_storage = 500
db_multi_az          = true
db_backup_retention_days = 30

# Configuración de caché
redis_node_type           = "cache.r6g.xlarge"
redis_num_cache_clusters  = 2
redis_port                = 6379
redis_at_rest_encryption  = true
redis_transit_encryption  = true

# Configuración de seguridad
enable_waf           = true
waf_rules_file       = "waf-rules.json"
enable_guardduty     = true
enable_security_hub  = true

# Configuración de logging
log_retention_days   = 90
enable_cloudtrail    = true
enable_vpc_flow_logs = true

# Configuración de backups
enable_rds_backup         = true
enable_efs_backup         = true
backup_schedule          = "cron(0 5 ? * * *)"

# Configuración de red avanzada
enable_private_link          = false
enable_nat_gateway_per_az    = true
enable_flow_logs             = true
flow_log_destination_type    = "cloud-watch-logs"

# Configuración de estrategias de despliegue avanzadas
blue_green_rollback_enabled     = true
blue_green_pre_deployment_tests = true
blue_green_smoke_test_timeout   = 600

canary_analysis_window_minutes  = 30
canary_success_threshold        = 99.5
canary_failure_threshold        = 99.0
canary_increase_step_percentage = 10
canary_max_traffic_percentage   = 50

ab_testing_min_sample_size      = 1000
ab_testing_confidence_level     = 95
ab_testing_duration_hours       = 72

# Configuración de métricas personalizadas
custom_metrics_namespace = "FinancialTransactionProcessor"
metrics_enabled = {
  transaction_count    = true
  transaction_latency  = true
  fraud_check_latency  = true
  error_rate           = true
  success_rate         = true
}

# Configuración de escalado basado en métricas personalizadas
enable_custom_metric_scaling = true
scaling_metric_name          = "TransactionsPerSecond"
target_value_for_scaling     = 3500

# Configuración de Circuit Breaker
circuit_breaker_threshold   = 50
circuit_breaker_timeout     = 30
circuit_breaker_retry_count = 3

# Configuración de rate limiting
rate_limit_requests_per_minute = 240000
rate_limit_burst              = 1000

# Configuración de caché de aplicación
app_cache_ttl_seconds = 300
app_cache_max_size_mb = 512

# Configuración de timeouts
http_timeout_seconds        = 30
db_connection_timeout_seconds = 60
db_idle_timeout_seconds     = 600
db_connection_pool_max_size = 50