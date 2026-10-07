# Prompt para Mejorar el Codigo Base

Copia y pega el contenido del bloque de abajo en un asistente de IA (Claude, ChatGPT)
para obtener un ZIP con el proyecto completo y arrancable.

Si preferis trabajar en tu editor con un agente local (Claude Code, Cursor, Copilot), usa `AGENTS.md` en vez de este archivo: dice lo mismo pero para que escriba los archivos en disco.

## Las dos reglas que no se negocian

1. **Completa el boilerplate.** Todo lo que el proyecto necesita para compilar y arrancar: manifiesto de dependencias, punto de entrada, configuracion, capa de interfaz, y las capas del patron arquitectonico declarado. Eso es andamiaje y es tu trabajo.
2. **NO resuelvas el reto.** Los entregables de las fases son el trabajo de la persona. El hueco pedagogico se deja como esta: el proyecto arranca, pero lo que el reto pide implementar NO esta implementado.

Dicho de otra forma: si algo impide compilar, arreglalo. Si algo es logica de negocio incompleta, validaciones ausentes, un secreto hardcodeado o un patron mejorable, dejalo exactamente como esta — es lo que la persona tiene que encontrar.

## Superficie de practica — NO resuelvas

Estos archivos SON el ejercicio de la persona. No los implementes; deja stubs.

- `Dockerfile` — El topic pide contenedores/orquestacion: este archivo es el ejercicio, no scaffolding.
- `k8s/deployment.yaml` — El topic pide contenedores/orquestacion: este archivo es el ejercicio, no scaffolding.
- `k8s/service.yaml` — El topic pide contenedores/orquestacion: este archivo es el ejercicio, no scaffolding.
- `k8s/ingress.yaml` — El topic pide contenedores/orquestacion: este archivo es el ejercicio, no scaffolding.

## Lo que le falta a este proyecto

Esto NO lo tenes que adivinar: salio de comparar el proyecto contra la arquitectura declarada del reto y de un analisis estatico del codigo. Completalo TODO.

### Archivos que la arquitectura del reto declara y no estan

Creálos con implementacion real, en la capa que les corresponde:

- `.github/workflows/deploy_blue_green.yml`
- `.github/workflows/deploy_ab.yml`
- `.github/workflows/deploy_canary.yml`
- `terraform/modules/canary/main.tf`
- `scripts/build.sh`
- `scripts/healthcheck.sh`

## Como saber que terminaste

```bash
docker build -t reto:local . && terraform -chdir=terraform init -backend=false && terraform -chdir=terraform validate
```

Ese comando corriendo sin errores es la definicion de "listo".

---

```
## Briefing del reto (autoridad)
Este bloque manda sobre los archivos adjuntos. El stack y el rol salen de AQUÍ, no de un topic genérico ni de markdown placeholder.

### Perfil
Chapter DevSecOps, Especialidad Ingeniería, Seniority Senior

### Brecha de conocimiento
Conoce y aplica las estrategias de deployment (Blue-Green, A/B, Canary). Candidato con experiencia en arquitectura de infraestructura

### Misión / candidato
enfoque en la implementación segura y confiable de estrategias de despliegue en entornos empresariales.

### Reto
- Tema: implementacion estrategias de despliegue
- Seniority: senior-l2
- Tipo: practical
- Título: Implementación de Estrategias de Despliegue en Entorno Empresarial
- Tiempo estimado: 2 semanas

### Fases (trabajo del HUMANO — PROHIBIDO completarlas)
No implementes estos entregables. Dejalos como hueco pedagógico. El asistente solo materializa el proyecto arrancable para que el participante pueda trabajar.
- Fase 1: Exploración del Sistema y Definición de Requisitos — objetivo: Identificar las restricciones y ambigüedades del sistema actual para definir los requisitos de las estrategias de despliegue. — entregable (NO resolver): Documento de requisitos para las estrategias de despliegue.
- Fase 2: Implementación de la Estrategia Blue-Green — objetivo: Implementar la estrategia Blue-Green para asegurar una transición sin interrupciones en el despliegue del servicio. — entregable (NO resolver): Implementación y documentación de la estrategia Blue-Green.
- Fase 3: Implementación de la Estrategia A/B — objetivo: Implementar la estrategia A/B para probar nuevas funcionalidades en un subconjunto de usuarios. — entregable (NO resolver): Implementación y documentación de la estrategia A/B.
- Fase 4: Implementación de la Estrategia Canary — objetivo: Implementar la estrategia Canary para desplegar nuevas versiones del servicio en un subconjunto de usuarios. — entregable (NO resolver): Implementación y documentación de la estrategia Canary.

Eres un asistente experto en análisis, corrección y generación de archivos de cualquier tipo:
código fuente, documentación, hojas de cálculo, documentos Word, configuraciones, entre otros.
Voy a enviarte una cadena de texto que contiene uno o más archivos. Cada archivo está delimitado por un marcador con el siguiente formato:
// === ARCHIVO: ruta/del/archivo.extension ===
o también puede aparecer como:
## === ARCHIVO: ruta/del/archivo.extension ===
Lo que sigue al marcador puede ser:

El contenido real del archivo (código, texto, YAML, etc.)
Una descripción en lenguaje natural de lo que debe contener el archivo


TU TAREA
PASO 0 — ¿Esto es un proyecto o una carcasa?
Antes de extraer archivos, leé el Briefing (si está) y diagnosticá el adjunto.

Es CARCASA si ocurre CUALQUIERA de estas:
- No hay manifiesto de dependencias del stack del briefing (manifest.json de VTEX IO / package.json / pom.xml / build.gradle / requirements.txt / go.mod / *.tf / *.csproj, según corresponda)
- Hay un "binario" que en realidad es un comentario ("no puede ser mostrado como texto plano", placeholder .fig/.docx vacío)
- Los markdowns ya completan entregables de fases posteriores ("se implementó fade-in", lista de áreas ya resuelta)

Si es CARCASA:
- MATERIALIZÁ un proyecto que arranca en el stack del briefing (VTEX IO Store Framework, Angular, Terraform, pytest, Nest, etc.). Incluí manifiesto, punto de entrada y capa de interfaz reales.
- NO copies los markdowns de "solución" como si fueran el producto. Son ruido de generación.
- NO resuelvas las fases del briefing (están marcadas PROHIBIDO). Dejá el hueco pedagógico: el flujo existe, las microinteracciones/calidad/infra que el reto pide NO están hechas.
- Después seguí al PASO 5 (ZIP).

Si es un proyecto REAL (manifiesto + código que compila o arranca):
- Seguí PASO 1 en adelante. 🔴 compilación sí. 🟡 pedagógico no.

PASO 1 — Detección y extracción
Identifica todos los archivos presentes en la cadena. Para cada archivo extrae:

Su ruta completa (ej: src/main/java/com/pragma/Service.java)
Su contenido o descripción

PASO 2 — Clasificación por tipo
Clasifica cada archivo en una de estas categorías:
A) Código fuente (Java, Python, TypeScript, JavaScript, Kotlin, etc.)
B) Configuración / documentación (YAML, properties, Markdown, JSON, txt, etc.)
C) Excel (.xlsx, .xls, .csv)
D) Word (.docx, .doc)
E) Otro tipo de archivo binario o especial
PASO 3 — Clasificación de errores en código fuente

Objetivo prioritario: que el proyecto compile. No corrijas flujo de negocio ni lógica funcional.

Antes de modificar cualquier archivo de código fuente, clasifica cada problema encontrado en una de estas dos categorías:
🔴 ERROR DE COMPILACIÓN — corregir siempre
Son errores que impiden que el proyecto arranque, sin valor pedagógico:

Import faltante o incorrecto
Clase, método o variable referenciada que no existe en ningún archivo del proyecto
Error de sintaxis
Anotación con atributos inválidos
Dependencia ausente en pom.xml, package.json, etc.
Archivo referenciado que no existe y debe ser creado con implementación mínima

→ CORREGIR estos errores.
🟡 PROBLEMA FUNCIONAL O DE CALIDAD — preservar siempre
Son problemas que no impiden compilar. Pueden ser intencionales para el aprendizaje:

Clave secreta hardcodeada ("secret", "password123")
API deprecada que funciona pero tiene reemplazo moderno
Lógica de negocio incorrecta o incompleta
Código redundante o de baja legibilidad
Falta de validaciones en flujo de negocio
Patrones de diseño incorrectos pero funcionales
Concurrencia no segura
Configuración funcional pero no óptima

→ PRESERVAR tal cual. No corregir, no mejorar, no comentar.
PASO 4 — Procesamiento según tipo de archivo
Tipo A — Código fuente
Aplica únicamente las correcciones clasificadas como 🔴 ERROR DE COMPILACIÓN.
No alteres ningún elemento clasificado como 🟡 PROBLEMA FUNCIONAL O DE CALIDAD.
Si falta un archivo referenciado, créalo con la implementación mínima necesaria para compilar.
Tipo B — Configuración / documentación
Extrae el contenido tal cual, sin modificaciones salvo errores evidentes de sintaxis
(ej: YAML mal indentado).
Tipo C — Excel (.xlsx)
Si viene con contenido real, genera el archivo respetando ese contenido.
Si viene con descripción en lenguaje natural, genera un archivo Excel funcional con:

Fila de encabezados en negrita con color de fondo distintivo
Columnas con ancho ajustado al contenido
Tipos de dato correctos por columna
Validaciones si la descripción lo indica
Hojas nombradas descriptivamente si hay más de una
Filas de ejemplo si no hay datos reales

Tipo D — Word (.docx)
Si viene con contenido real, genera el archivo respetando ese contenido.
Si viene con descripción en lenguaje natural, genera un documento Word funcional con:

Estilos de título (Título 1, Título 2) para jerarquía de secciones
Fuente legible (Calibri o equivalente), tamaño 11-12pt para cuerpo
Márgenes estándar
Tabla de contenido si tiene múltiples secciones
Tablas con encabezados en negrita si aplica

Tipo E — Otro
Genera el archivo con el contenido o estructura más apropiada según la descripción.
PASO 5 — Exportación en ZIP
Empaqueta todos los archivos en un único archivo ZIP descargable respetando exactamente
la estructura de rutas indicada por los marcadores.
El ZIP debe incluir:

Archivos de código con únicamente los errores de compilación corregidos
Archivos de configuración y documentación sin cambios
Archivos nuevos creados para resolver dependencias de compilación faltantes
Archivos Excel y Word generados desde descripción

IMPORTANTE: El ZIP debe estar listo para descargar al finalizar. No preguntes si el usuario
quiere generarlo. Simplemente genera el archivo y proporciona el enlace de descarga; No debes desplegar en el chat el resumen de lo que arreglaste al Zip, solo entregalo.

REGLAS IMPORTANTES

No omitas ningún archivo aunque no tenga errores ni modificaciones
Respeta los nombres y rutas exactas indicadas por los marcadores
Si un archivo no tiene marcador claro, infiere el nombre desde su contenido
Si la cadena contiene solo documentación, placeholders o binarios fake, NO la reproduzcas:
aplicá PASO 0 (materializar el proyecto del briefing). Reproducir la carcasa es un fallo.
No agregues texto después del enlace de descarga del ZIP
No preguntes si el usuario quiere el ZIP: simplemente generalo siempre
Si detectas que falta un archivo de configuración necesario para compilar
(pom.xml, package.json, requirements.txt, build.gradle, etc.), créalo e inclúyelo
inferiendo su contenido desde los imports y frameworks detectados en el código
Nunca corrijas problemas 🟡 aunque parezcan obvios o fáciles de mejorar.
El participante que recibirá este proyecto los debe encontrar y resolver él mismo.


INPUT
Aquí está la cadena con los archivos:

// === ARCHIVO: terraform/variables.tf ===
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

// === ARCHIVO: terraform/providers.tf ===
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
}

provider "aws" {
  region = var.aws_region
}

provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", module.eks.cluster_name]
    command     = "aws"
  }
}

provider "helm" {
  kubernetes {
    host                   = module.eks.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", module.eks.cluster_name]
      command     = "aws"
    }
  }
}


// === ARCHIVO: terraform/main.tf ===
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

// === ARCHIVO: terraform/outputs.tf ===
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

// === ARCHIVO: terraform/environments/prod/terraform.tfvars ===
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


// === ARCHIVO: terraform/environments/staging/terraform.tfvars ===
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

// === ARCHIVO: terraform/modules/blue_green/main.tf ===
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

// === ARCHIVO: terraform/modules/ab_testing/main.tf ===
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


// === ARCHIVO: Dockerfile ===
# Syntax=docker/dockerfile:1

# Stage 1: Build stage
FROM node:20-alpine AS builder

WORKDIR /app

# Copy package files and install dependencies
COPY package*.json ./
RUN npm ci --only=production

# Copy source code
COPY . .

# Build the application
RUN npm run build

# Stage 2: Production stage
FROM node:20-alpine AS production

WORKDIR /app

# Create non-root user for security
RUN addgroup -g 1001 -S nodejs && \
    adduser -S nodejs -u 1001

# Set ownership for nodejs user
RUN chown -R nodejs:nodejs /app

# Switch to non-root user
USER nodejs

# Copy built artifacts from builder stage
COPY --from=builder --chown=nodejs:nodejs /app/dist ./dist
COPY --from=builder --chown=nodejs:nodejs /app/node_modules ./node_modules
COPY --from=builder --chown=nodejs:nodejs /app/package*.json ./

# Expose application port
EXPOSE 3000

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD wget --no-verbose --tries=1 --spider http://localhost:3000/health || exit 1

# Set environment variables for production
ENV NODE_ENV=production
ENV PORT=3000

# Start the application
CMD ["node", "dist/main.js"]

// === ARCHIVO: .dockerignore ===
# Version control
.git
.gitignore
.svn
.hg

# IDE and editor files
.idea
.vscode
*.swp
*.swo
*~
.DS_Store

# Build artifacts and compiled files
dist/
build/
out/
target/
*.class
*.o
*.obj
*.exe

# Dependencies
node_modules/
vendor/
__pycache__/
*.pyc
.env.local
.env.*.local

# Test files and coverage
coverage/
.nyc_output/
test/
tests/
*.test.js
*.spec.js
__tests__/

# Documentation
docs/
*.md
!README.md
LICENSE

# CI/CD configurations
.github/
.gitlab-ci.yml
.azure-pipelines/
Jenkinsfile

# Terraform and infrastructure
terraform/
*.tf
*.tfstate
*.tfstate.backup
.terraform/

# Kubernetes
k8s/
*.yaml
!k8s/deployment.yaml
!k8s/service.yaml

# Logs and temporary files
*.log
npm-debug.log*
yarn-debug.log*
yarn-error.log*
tmp/
temp/

# Security and secrets
.env
.env.production
*.pem
*.key
secrets/
credentials/

# Docker files (avoid recursive inclusion)
Dockerfile
docker-compose*.yml
.docker/

// === ARCHIVO: sonar-project.properties ===
# Configuration for SonarCloud static analysis
# Project identification
sonar.projectKey=financial-transaction-service
sonar.organization=enterprise-devops

# Project metadata
sonar.projectName=Financial Transaction Processing Service
sonar.projectVersion=1.0.0

# Source code configuration
sonar.sources=src
sonar.tests=test
sonar.test.inclusions=**/*.test.ts,**/*.spec.ts
sonar.sourceEncoding=UTF-8

# Language and quality profiles
sonar.language=ts
sonar.typescript.lcov.reportPaths=coverage/lcov.info
sonar.typescript.coveragePlugin=lcov

# Quality gates and thresholds
sonar.qualitygate.wait=true
sonar.sq.coveragePlugin=lcov

# Quality profiles for financial services
sonar.issues.console.locations.start=0
sonar.issues.console.locations.end=1000

# Code security and reliability rules
# Ensure high reliability for financial transaction processing
sonar.security.reliability.exclusions=**/node_modules/**,**/dist/**
sonar.security.exclusions=**/node_modules/**,**/dist/**

# Technical debt configuration
sonar.sq.dryRun=false
sonar.technicalDebt.onNewCode=true

# Duplicate code detection
sonar.duplications.exclusions=**/node_modules/**,**/dist/**,**/*.generated.*

# Complexity thresholds for maintainability
sonar.complexity.threshold=15
sonar.functionComplexity.threshold=10
sonar.ncloc.threshold=1000

# Coverage requirements - financial services require high coverage
sonar.coverage.exclusions=**/node_modules/**,**/dist/**,**/*.config.*,**/*.d.ts
sonar.test.exclusions=**/node_modules/**,**/dist/**

# Minimum coverage thresholds
sonar.coverage.line.minimum=80
sonar.coverage.branch.minimum=75
sonar.coverage.line.higherThresholds=85
sonar.coverage.branch.higherThresholds=80

# Quality gate status checks
# Block deployment if quality gate fails
sonar.qualitygate.timeout=300
sonar.qualitygate.criticalThreshold=1

# Badges and reporting
sonar.badges.enabled=true
sonar.links.homepage=https://github.com/enterprise/financial-transaction-service
sonar.links.ci=https://github.com/enterprise/financial-transaction-service/actions
sonar.links.scm=github.com/enterprise/financial-transaction-service

# Additional analysis parameters
sonar.typescript.tsconfigPath=tsconfig.json
sonar.eslint.enable=true
sonar.tsql.enable=false
sonar.rust.clippy.enable=false

# Performance and execution
sonar.scanner.metadataFilePath=scanner-report/metadata
sonar.analysisCache.enabled=true
sonar.analysisCache.maxSize=500

# Custom rules for financial services compliance
# PCI-DSS compliance checks
sonar.pci-dss.enabled=true
sonar.pci-dss.exclusions=**/node_modules/**

# OWASP Top 10 detection
sonar.owasp.enable=true
sonar.owasp.reportFormat=json


// === ARCHIVO: README.md ===
# Implementación de Estrategias de Despliegue en Entorno Empresarial

## Descripción del Proyecto

Este proyecto implementa un sistema completo de CI/CD con estrategias de despliegue avanzadas para un servicio de procesamiento de transacciones financieras. El sistema soporta un throughput de 4.000 transacciones por segundo con un SLA del 99.9%.

## Arquitectura General

El proyecto está estructurado en varias capas que permiten la implementación modular y mantenible de las estrategias de despliegue:

- **Terraform**: Infraestructura como código para AWS EKS, ALB y recursos de red
- **Kubernetes**: Manifiestos para el despliegue de aplicaciones en clúster
- **GitHub Actions**: Pipelines de CI/CD con análisis de seguridad
- **Scripts**: Automatización de build y healthcheck

## Estructura de Directorios

```
├── .github/workflows/      # Pipelines de CI/CD
├── docker/                 # Configuraciones de contenedores
├── k8s/                    # Manifiestos de Kubernetes
├── scripts/                # Scripts de automatización
├── terraform/              # Infraestructura como código
│   ├── environments/       # Configuraciones por entorno
│   └── modules/            # Módulos reutilizables
├── docs/                   # Documentación técnica
└── tests/                  # Pruebas de integración
```

## Estrategias de Despliegue Implementadas

### Blue-Green Deployment

La estrategia Blue-Green mantiene dos entornos idénticos (blue = producción actual, green = nueva versión). El tráfico se redirige mediante el Application Load Balancer una vez que la nueva versión pasa las verificaciones de salud.

**Componentes relacionados:**
- `.github/workflows/deploy_blue_green.yml`
- `terraform/modules/blue_green/`

### A/B Testing

La estrategia A/B permite distribuir el tráfico entre dos versiones del servicio para validar nuevas funcionalidades con un subconjunto de usuarios antes de un despliegue completo.

**Componentes relacionados:**
- `.github/workflows/deploy_ab.yml`
- `terraform/modules/ab_testing/`

### Canary Deployment

La estrategia Canary despliega gradualmente la nueva versión, comenzando con un porcentaje mínimo de tráfico y aumentando progresivamente según las métricas de salud del sistema.

**Componentes relacionados:**
- `.github/workflows/deploy_canary.yml`
- `terraform/modules/canary/`

## Requisitos Previos

Para trabajar con este proyecto necesitas:

- Terraform >= 1.5 instalado
- AWS CLI configurado con credenciales apropiadas
- kubectl configurado para el clúster EKS
- Docker para construir imágenes
- GitHub CLI para gestionar secrets

## Configuración Inicial

### 1. Configuración de AWS

Asegúrate de tener las credenciales de AWS configuradas:

```bash
aws configure
```

### 2. Inicialización de Terraform

```bash
cd terraform
terraform init -backend=false
terraform validate
```

### 3. Variables de Entorno

Crea el archivo `terraform/environments/{entorno}/terraform.tfvars` con los valores apropiados para tu entorno.

## Construcción de la Imagen Docker

```bash
docker build -t reto:local .
```

O usa el script de build:

```bash
./scripts/build.sh
```

## Despliegue en Kubernetes

### Aplicar manifiestos

```bash
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml
kubectl apply -f k8s/ingress.yaml
```

### Verificar estado

```bash
./scripts/healthcheck.sh
```

## Pipelines de CI/CD

Los pipelines se ejecutan automáticamente al hacer push a las ramas principales. Cada estrategia de despliegue tiene su propio workflow:

- **Blue-Green**: Despliegue atómico con rollback automático
- **A/B Testing**: Distribución de tráfico configurable
- **Canary**: Despliegue progresivo con métricas

### Ejecutar pipeline manualmente

```bash
# Blue-Green
gh workflow run deploy_blue_green.yml -f environment=prod

# A/B Testing
gh workflow run deploy_ab.yml -f environment=prod

# Canary
gh workflow run deploy_canary.yml -f environment=prod
```

## Monitoreo y Observabilidad

El proyecto incluye integración con Prometheus y Grafana para monitoreo de métricas y alertas.

### Métricas Clave

- Latencia de respuesta
- Tasa de errores
- Throughput de transacciones
- Uso de recursos (CPU, memoria)

### Alertas Configuradas

- SLA del 99.9% con umbrales de alerta
- Notificaciones por violación de métricas

## Seguridad

### Escaneo de Seguridad

El pipeline incluye múltiples capas de seguridad:

- **Trivy**: Escaneo de vulnerabilidades en imágenes Docker
- **Checkov**: Análisis estático de IaC
- **SonarCloud**: Análisis de código
- **OWASP**: Escaneo de dependencias

### Gestión de Secretos

Los secretos se gestionan mediante AWS Secrets Manager. Nunca se almacenan en texto plano en el repositorio.

## Verificación del Entorno

Para verificar que el entorno está correctamente configurado:

```bash
docker build -t reto:local . && terraform -chdir=terraform init -backend=false && terraform -chdir=terraform validate
```

Este comando verifica:
1. La construcción de la imagen Docker
2. La inicialización de Terraform
3. La validación de la configuración de IaC

## Entornos Disponibles

- **staging**: Entorno de pruebas y validación
- **prod**: Entorno de producción con alta disponibilidad

## Contribución

Para contribuir al proyecto:

1. Crea una rama feature
2. Implementa los cambios
3. Ejecuta los tests localmente
4. Envía un pull request

## Recursos Adicionales

- [Documentación de AWS EKS](https://docs.aws.amazon.com/eks/)
- [Documentación de Terraform](https://www.terraform.io/docs/)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Kubernetes Documentation](https://kubernetes.io/docs/)


// === ARCHIVO: k8s/deployment.yaml ===
apiVersion: apps/v1
kind: Deployment
metadata:
  name: transaction-processor
  namespace: production
  labels:
    app: transaction-processor
    tier: backend
    environment: production
spec:
  replicas: 3
  revisionHistoryLimit: 5
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxSurge: 1
      maxUnavailable: 0
  selector:
    matchLabels:
      app: transaction-processor
  template:
    metadata:
      labels:
        app: transaction-processor
        version: v1
        tier: backend
      annotations:
        prometheus.io/scrape: "true"
        prometheus.io/port: "8080"
        prometheus.io/path: "/metrics"
    spec:
      serviceAccountName: transaction-processor-sa
      securityContext:
        runAsNonRoot: true
        runAsUser: 1000
        fsGroup: 1000
      containers:
        - name: transaction-processor
          image: transaction-processor:latest
          imagePullPolicy: Always
          ports:
            - containerPort: 8080
              name: http
              protocol: TCP
            - containerPort: 9090
              name: grpc
              protocol: TCP
          env:
            - name: JAVA_OPTS
              value: "-Xms2g -Xmx4g -XX:+UseG1GC"
            - name: SPRING_PROFILES_ACTIVE
              value: "production"
            - name: DATABASE_POOL_SIZE
              value: "20"
            - name: KAFKA_CONSUMER_THREADS
              value: "4"
          resources:
            requests:
              memory: "2Gi"
              cpu: "1000m"
            limits:
              memory: "4Gi"
              cpu: "2000m"
          livenessProbe:
            httpGet:
              path: /actuator/health/liveness
              port: 8080
            initialDelaySeconds: 60
            periodSeconds: 10
            timeoutSeconds: 5
            failureThreshold: 3
          readinessProbe:
            httpGet:
              path: /actuator/health/readiness
              port: 8080
            initialDelaySeconds: 30
            periodSeconds: 5
            timeoutSeconds: 3
            failureThreshold: 3
          volumeMounts:
            - name: app-config
              mountPath: /config
              readOnly: true
            - name: logs
              mountPath: /var/log/application
      volumes:
        - name: app-config
          configMap:
            name: transaction-processor-config
        - name: logs
          emptyDir: {}
      affinity:
        podAntiAffinity:
          preferredDuringSchedulingIgnoredDuringExecution:
            - weight: 100
              podAffinityTerm:
                labelSelector:
                  matchExpressions:
                    - key: app
                      operator: In
                      values:
                        - transaction-processor
                topologyKey: kubernetes.io/hostname
---
# Canary Deployment - se activa cuando se requiere estrategia canary
apiVersion: apps/v1
kind: Deployment
metadata:
  name: transaction-processor-canary
  namespace: production
  labels:
    app: transaction-processor
    tier: backend
    deployment-type: canary
spec:
  replicas: 1
  revisionHistoryLimit: 3
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxSurge: 1
      maxUnavailable: 0
  selector:
    matchLabels:
      app: transaction-processor
      version: canary
  template:
    metadata:
      labels:
        app: transaction-processor
        version: canary
        tier: backend
      annotations:
        prometheus.io/scrape: "true"
        prometheus.io/port: "8080"
    spec:
      serviceAccountName: transaction-processor-sa
      containers:
        - name: transaction-processor
          image: transaction-processor:canary
          imagePullPolicy: Always
          ports:
            - containerPort: 8080
              name: http
          resources:
            requests:
              memory: "2Gi"
              cpu: "1000m"
            limits:
              memory: "4Gi"
              cpu: "2000m"
---
# Blue-Green Deployment - ambiente verde (nueva versión)
apiVersion: apps/v1
kind: Deployment
metadata:
  name: transaction-processor-green
  namespace: production
  labels:
    app: transaction-processor
    tier: backend
    deployment-type: green
spec:
  replicas: 3
  revisionHistoryLimit: 5
  selector:
    matchLabels:
      app: transaction-processor
      version: green
  template:
    metadata:
      labels:
        app: transaction-processor
        version: green
        tier: backend
    spec:
      serviceAccountName: transaction-processor-sa
      containers:
        - name: transaction-processor
          image: transaction-processor:green
          imagePullPolicy: Always
          ports:
            - containerPort: 8080
---
# HorizontalPodAutoscaler para escalado automático
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: transaction-processor-hpa
  namespace: production
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: transaction-processor
  minReplicas: 3
  maxReplicas: 20
  metrics:
    - type: Resource
      resource:
        name: cpu
        target:
          type: Utilization
          averageUtilization: 70
    - type: Resource
      resource:
        name: memory
        target:
          type: Utilization
          averageUtilization: 80
  behavior:
    scaleUp:
      stabilizationWindowSeconds: 60
      policies:
        - type: Percent
          value: 100
          periodSeconds: 15
    scaleDown:
      stabilizationWindowSeconds: 300
      policies:
        - type: Percent
          value: 10
          periodSeconds: 60

// === ARCHIVO: k8s/service.yaml ===
apiVersion: v1
kind: Service
metadata:
  name: transaction-processor
  namespace: production
  labels:
    app: transaction-processor
    tier: backend
  annotations:
    service.beta.kubernetes.io/aws-load-balancer-type: "nlb"
    service.beta.kubernetes.io/aws-load-balancer-backend-protocol: "http"
    service.beta.kubernetes.io/aws-load-balancer-ssl-cert: "arn:aws:acm:us-east-1:123456789:certificate/cert-id"
    service.beta.kubernetes.io/aws-load-balancer-ssl-ports: "443"
    service.beta.kubernetes.io/aws-load-balancer-cross-zone-load-balancing-enabled: "true"
spec:
  type: LoadBalancer
  sessionAffinity: ClientIP
  sessionAffinityConfig:
    clientIP:
      timeoutSeconds: 10800
  selector:
    app: transaction-processor
  ports:
    - name: http
      protocol: TCP
      port: 80
      targetPort: 8080
    - name: https
      protocol: TCP
      port: 443
      targetPort: 8080
    - name: grpc
      protocol: TCP
      port: 9090
      targetPort: 9090
---
# Service para versión canary
apiVersion: v1
kind: Service
metadata:
  name: transaction-processor-canary
  namespace: production
  labels:
    app: transaction-processor
    tier: backend
    deployment-type: canary
spec:
  type: ClusterIP
  selector:
    app: transaction-processor
    version: canary
  ports:
    - name: http
      protocol: TCP
      port: 8080
      targetPort: 8080
---
# Service para versión green (Blue-Green)
apiVersion: v1
kind: Service
metadata:
  name: transaction-processor-green
  namespace: production
  labels:
    app: transaction-processor
    tier: backend
    deployment-type: green
spec:
  type: ClusterIP
  selector:
    app: transaction-processor
    version: green
  ports:
    - name: http
      protocol: TCP
      port: 8080
      targetPort: 8080
---
# Service para versión blue (Blue-Green)
apiVersion: v1
kind: Service
metadata:
  name: transaction-processor-blue
  namespace: production
  labels:
    app: transaction-processor
    tier: backend
    deployment-type: blue
spec:
  type: ClusterIP
  selector:
    app: transaction-processor
    version: blue
  ports:
    - name: http
      protocol: TCP
      port: 8080
      targetPort: 8080
---
# ServiceMonitor para Prometheus
apiVersion: monitoring.coreos.com/v1
kind: ServiceMonitor
metadata:
  name: transaction-processor-monitor
  namespace: production
  labels:
    app: transaction-processor
spec:
  selector:
    matchLabels:
      app: transaction-processor
  endpoints:
    - port: http
      path: /metrics
      interval: 30s
      scheme: http
  namespaceSelector:
    matchNames:
      - production

// === ARCHIVO: k8s/ingress.yaml ===
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: transaction-processor-ingress
  namespace: production
  labels:
    app: transaction-processor
    tier: backend
  annotations:
    kubernetes.io/ingress.class: nginx
    nginx.ingress.kubernetes.io/ssl-redirect: "true"
    nginx.ingress.kubernetes.io/proxy-body-size: "50m"
    nginx.ingress.kubernetes.io/proxy-connect-timeout: "30"
    nginx.ingress.kubernetes.io/proxy-read-timeout: "60"
    nginx.ingress.kubernetes.io/proxy-send-timeout: "60"
    nginx.ingress.kubernetes.io/affinity: "cookie"
    nginx.ingress.kubernetes.io/session-cookie-name: "transaction_session"
    nginx.ingress.kubernetes.io/session-cookie-hash: "sha1"
    # Configuración para A/B Testing
    nginx.ingress.kubernetes.io(canary: "true"): "true"
    nginx.ingress.kubernetes.io(canary-weight: "10"): "true"
spec:
  ingressClassName: nginx
  tls:
    - hosts:
        - api.transactions.example.com
      secretName: transaction-processor-tls
  rules:
    - host: api.transactions.example.com
      http:
        paths:
          - path: /api/v1/transactions
            pathType: Prefix
            backend:
              service:
                name: transaction-processor
                port:
                  number: 80
          - path: /api/v1/credits
            pathType: Prefix
            backend:
              service:
                name: transaction-processor
                port:
                  number: 80
          - path: /health
            pathType: Exact
            backend:
              service:
                name: transaction-processor
                port:
                  number: 80
---
# Ingress para Canary - routing condicional basado en headers
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: transaction-processor-canary-ingress
  namespace: production
  labels:
    app: transaction-processor
    deployment-type: canary
  annotations:
    kubernetes.io/ingress.class: nginx
    nginx.ingress.kubernetes.io/canary: "true"
    nginx.ingress.kubernetes.io/canary-by-header: "X-Canary"
    nginx.ingress.kubernetes.io/canary-by-header-value: "enable"
    nginx.ingress.kubernetes.io/canary-weight: "20"
spec:
  ingressClassName: nginx
  rules:
    - host: api.transactions.example.com
      http:
        paths:
          - path: /api/v1
            pathType: Prefix
            backend:
              service:
                name: transaction-processor-canary
                port:
                  number: 8080
---
# Ingress para versión A - usuarios del grupo A
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: transaction-processor-group-a-ingress
  namespace: production
  labels:
    app: transaction-processor
    deployment-type: ab
    variant: a
  annotations:
    kubernetes.io/ingress.class: nginx
    nginx.ingress.kubernetes.io/canary: "true"
    nginx.ingress.kubernetes.io/canary-weight: "50"
spec:
  ingressClassName: nginx
  rules:
    - host: api.transactions.example.com
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: transaction-processor
                port:
                  number: 80
---
# Ingress para versión B - usuarios del grupo B
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: transaction-processor-group-b-ingress
  namespace: production
  labels:
    app: transaction-processor
    deployment-type: ab
    variant: b
  annotations:
    kubernetes.io/ingress.class: nginx
    nginx.ingress.kubernetes.io/canary: "true"
    nginx.ingress.kubernetes.io/canary-weight: "50"
spec:
  ingressClassName: nginx
  rules:
    - host: api.transactions-v2.example.com
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: transaction-processor-green
                port:
                  number: 8080
---
# Ingress para Blue (producción actual)
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: transaction-processor-blue-ingress
  namespace: production
  labels:
    app: transaction-processor
    deployment-type: blue-green
    variant: blue
  annotations:
    kubernetes.io/ingress.class: nginx
spec:
  ingressClassName: nginx
  rules:
    - host: api.transactions.example.com
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: transaction-processor-blue
                port:
                  number: 8080
---
# Ingress para Green (nueva versión - Blue-Green)
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: transaction-processor-green-ingress
  namespace: production
  labels:
    app: transaction-processor
    deployment-type: blue-green
    variant: green
  annotations:
    kubernetes.io/ingress.class: nginx
    nginx.ingress.kubernetes.io/canary: "true"
    nginx.ingress.kubernetes.io/canary-weight: "0"
spec:
  ingressClassName: nginx
  rules:
    - host: api.transactions.example.com
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: transaction-processor-green
                port:
                  number: 8080

```
