environment_name     = "staging"
region               = "us-east-1"

# Configuración del clúster EKS
cluster_name         = "financial-transaction-eks-staging"
cluster_version      = "1.28"
instance_types       = ["t3.large", "t3.xlarge"]
min_capacity         = 2
max_capacity         = 8
desired_capacity     = 3

# Configuración de redes
vpc_cidr             = "10.2.0.0/16"
private_subnets      = ["10.2.1.0/24", "10.2.2.0/24", "10.2.3.0/24"]
public_subnets       = ["10.2.101.0/24", "10.2.102.0/24", "10.2.103.0/24"]
availability_zones   = ["us-east-1a", "us-east-1b", "us-east-1c"]

# Configuración de Base de Datos
db_instance_class    = "db.r6g.xlarge"
db_allocated_storage = 500
db_multi_az          = true
db_name              = "fintransactions_staging"

# Configuración de Application Load Balancer
alb_name             = "financial-tx-alb-staging"
alb_type             = "application"
alb_scheme           = "internet-facing"

# Configuración de Blue-Green Deployment
blue_green_enabled   = true
blue_green_domains   = {
  blue  = "blue.staging.financial-tx.internal"
  green = "green.staging.financial-tx.internal"
}
traffic_shift_percentage = 10

# Configuración de A/B Testing
ab_testing_enabled   = true
ab_versions          = {
  version_a = { weight = 80, image_tag = "v1.0.0-stable" }
  version_b = { weight = 20, image_tag = "v1.1.0-beta" }
}

# Configuración de Canary Deployment
canary_enabled       = true
canary_steps         = [
  { percentage = 10, duration = 300 },
  { percentage = 25, duration = 600 },
  { percentage = 50, duration = 900 },
  { percentage = 100, duration = 1200 }
]

# Configuración de seguridad
enable_vpc_flow_logs = true
enable_deletion_protection = false
enable_waf              = true
waf_rules = [
  "AWSManagedRulesCommonRuleSet",
  "AWSManagedRulesKnownBadInputsRuleSet"
]

# Configuración de Observabilidad
enable_prometheus     = true
enable_grafana        = true
grafana_admin_password = "@STAGING_CHANGE_ME_IN_SECRETS_MANAGER@"

alert_email           = "devops-staging@financial-tx.com"
slack_webhook_url     = "@STAGING_SLACK_WEBHOOK_IN_SECRETS_MANAGER@"

# Configuración de escalado
autoscaling_enabled   = true
scaling_metrics       = "cpu"
target_cpu_utilization = 70
scale_up_cooldown     = 300
scale_down_cooldown   = 600

# Configuración de secretos (referencias a AWS Secrets Manager)
secrets_manager_prefix = "financial-tx/staging"
db_credentials_secret = "${secrets_manager_prefix}/database"
api_keys_secret       = "${secrets_manager_prefix}/api-keys"

# Configuración de backends y state
state_bucket_name     = "financial-tx-terraform-state-staging"
state_dynamodb_table  = "financial-tx-terraform-locks-staging"