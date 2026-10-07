# AGENTS.md

Instrucciones para el agente de IA que abra este repositorio (Claude Code, Cursor, Codex, Copilot, Gemini). Se cargan solas: no hay que pegar nada en ningun chat.

## Que es este repositorio

Es el codigo base de un reto de aprendizaje de Pragma: **Implementación de Estrategias de Despliegue en Entorno Empresarial**.

| | |
|---|---|
| Tema | implementacion estrategias de despliegue |
| Nivel | senior-l2 |
| Chapter | DevSecOps |
| Especialidad | DevSecOps |
| Stack | YAML / Terraform 1.5 |
| Patron arquitectonico | Infraestructura como Código con pipelines de CI/CD modulares y estrategias de despliegue avanzadas (Blue-Green, A/B, Canary) |
| Tiempo estimado | 2 semanas |

## Receta del stack

Esqueleto obligatorio:

- `azure-pipelines.yml o .github/workflows/*.yml con stages reales`
- `Dockerfile multi-stage`
- `.dockerignore`
- `terraform/ con main.tf, variables.tf y outputs.tf`
- `terraform/environments/{env}/terraform.tfvars`
- `scripts/ con los scripts de build y healthcheck`
- `sonar-project.properties`

Trampas conocidas:

- `required_version` de Terraform va como RANGO (`>= 1.5`), nunca exacto: pineado, el proyecto no corre con otra version instalada.
- Los providers tambien con restriccion flexible (`~> 5.0`).
- El Dockerfile multi-stage necesita que la etapa final copie el artefacto de la etapa de build, no el codigo fuente.

Dependencias:

- hashicorp/aws ~> 5.0
- hashicorp/kubernetes ~> 2.23
- hashicorp/helm ~> 2.11
- terraform-aws-modules/alb/aws ~> 8.0
- terraform-aws-modules/eks/aws ~> 19.0
- SonarCloud n/a
- Trivy n/a
- Checkov n/a
- Prometheus n/a
- Grafana n/a

## Tu tarea

Dejar este proyecto en estado **verificable**: que el comando de verificacion corra sin errores. Escribi los archivos en disco, en este repositorio. No generes ZIPs ni archivos adjuntos.

En orden:

1. Corre `docker build -t reto:local . && terraform -chdir=terraform init -backend=false && terraform -chdir=terraform validate` y mira que falla.
2. Completa lo que falte de la lista de abajo: manifiesto de dependencias, punto de entrada, capa de interfaz y las capas del patron declarado.
3. Arregla SOLO los errores que impiden compilar o arrancar.
4. Volve a correr `docker build -t reto:local . && terraform -chdir=terraform init -backend=false && terraform -chdir=terraform validate` hasta que pase.
5. Pará ahí.

## Regla dura: las fases son trabajo del humano

**PROHIBIDO implementar los entregables de las fases.** El valor del reto esta en que la persona los resuelva. Tu trabajo es que tenga un proyecto que arranca; el hueco pedagogico se queda como esta.

No resuelvas nada de esto:

- **Fase 1 — Exploración del Sistema y Definición de Requisitos**: Documento de requisitos para las estrategias de despliegue.
- **Fase 2 — Implementación de la Estrategia Blue-Green**: Implementación y documentación de la estrategia Blue-Green.
- **Fase 3 — Implementación de la Estrategia A/B**: Implementación y documentación de la estrategia A/B.
- **Fase 4 — Implementación de la Estrategia Canary**: Implementación y documentación de la estrategia Canary.

Distincion operativa:

- **Arreglar** (si): import faltante, tipo que no existe, dependencia sin declarar, error de sintaxis, archivo referenciado que no existe.
- **No tocar** (no): logica de negocio incompleta, validaciones ausentes, secretos hardcodeados, APIs deprecadas que funcionan, concurrencia insegura, patrones mejorables. Eso es lo que la persona tiene que encontrar.

## Superficie de practica (NO completes)

Estos archivos SON el ejercicio de la persona. No los implementes; deja stubs. No toques la logica que el reto pide completar.

- [ ] `Dockerfile` — El topic pide contenedores/orquestacion: este archivo es el ejercicio, no scaffolding.
- [ ] `k8s/deployment.yaml` — El topic pide contenedores/orquestacion: este archivo es el ejercicio, no scaffolding.
- [ ] `k8s/service.yaml` — El topic pide contenedores/orquestacion: este archivo es el ejercicio, no scaffolding.
- [ ] `k8s/ingress.yaml` — El topic pide contenedores/orquestacion: este archivo es el ejercicio, no scaffolding.

## Lo que falta y tenes que completar

### 1. Archivos que la arquitectura declara (6 de 21)

La propuesta arquitectonica del reto los lista y no llegaron al repo. Crealos con implementacion real, respetando la capa en la que viven:

- [ ] `.github/workflows/deploy_blue_green.yml`
- [ ] `.github/workflows/deploy_ab.yml`
- [ ] `.github/workflows/deploy_canary.yml`
- [ ] `terraform/modules/canary/main.tf`
- [ ] `scripts/build.sh`
- [ ] `scripts/healthcheck.sh`

### Presentes (15)

- `terraform/variables.tf`
- `terraform/providers.tf`
- `terraform/main.tf`
- `terraform/outputs.tf`
- `terraform/environments/prod/terraform.tfvars`
- `terraform/environments/staging/terraform.tfvars`
- `terraform/modules/blue_green/main.tf`
- `terraform/modules/ab_testing/main.tf`
- `Dockerfile`
- `.dockerignore`
- `sonar-project.properties`
- `README.md`
- `k8s/deployment.yaml`
- `k8s/service.yaml`
- `k8s/ingress.yaml`

### Capas del patron declarado

Cada una tiene que existir como directorio real con al menos un archivo. Codigo plano en la raiz no satisface el patron.

- `.github/workflows`
- `terraform`
- `terraform/environments/prod`
- `terraform/environments/staging`
- `terraform/modules/blue_green`
- `terraform/modules/ab_testing`
- `terraform/modules/canary`
- `scripts`
- `k8s`

## Verificacion

```bash
docker build -t reto:local . && terraform -chdir=terraform init -backend=false && terraform -chdir=terraform validate
```

El comando tiene que pasar SIN implementar los archivos de la superficie de practica: solo andamiaje.

Ese comando pasando es la definicion de "terminado" para vos.

## Convenciones que tenes que respetar

- Un solo ecosistema: no declares librerias de otro lenguaje ni mezcles gestores de paquetes.
- Toda libreria que uses tiene que estar declarada en el manifiesto de dependencias.
- Todo import declarado tiene que usarse; todo tipo usado tiene que existir o venir de una dependencia declarada.
- El patron es **Infraestructura como Código con pipelines de CI/CD modulares y estrategias de despliegue avanzadas (Blue-Green, A/B, Canary)**: los contratos (interfaces, puertos) los define la capa interna y los implementa la externa, nunca al revés.
- Los archivos que crees llevan implementacion real, no stubs: sin `TODO`, sin cuerpos vacios, sin `// getters y setters`.

## Contexto del candidato

Sirve para calibrar el nivel del codigo, no para resolver las fases.

- Perfil: Chapter DevSecOps, Especialidad Ingeniería, Seniority Senior
- Brecha que el reto ataca: Conoce y aplica las estrategias de deployment (Blue-Green, A/B, Canary). Candidato con experiencia en arquitectura de infraestructura
- Mision: enfoque en la implementación segura y confiable de estrategias de despliegue en entornos empresariales.

---

*Generado por Challenge Generator — Pragma. `README.md` tiene el enunciado completo del reto para la persona. `PROMPT_MEJORA.md` es la variante para pegar en un chat, si se prefiere ese flujo.*
