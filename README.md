# Implementación de Estrategias de Despliegue en Entorno Empresarial

El equipo de DevOps necesita implementar estrategias de despliegue seguras y confiables para un servicio de procesamiento de transacciones financieras. Los actores involucrados son el 'originador de créditos', el'motor antifraude' y el 'core bancario'. El sistema debe manejar un throughput de 4 000 transacciones por segundo con un SLA de 99.9%. Se deben implementar las estrategias Blue-Green, A/B y Canary para asegurar una transición sin interrupciones y minimizar el riesgo de fallos.

## Informacion General

| Campo | Valor |
|-------|-------|
| **Tema** | implementacion estrategias de despliegue |
| **Nivel** | senior-l2 |
| **Tipo** | practical |
| **Tiempo estimado** | 2 semanas |

## Fases del Reto

### Fase 0: Configuración del Proyecto

**Objetivo:** Obtener el proyecto base funcional enviando el Código Base a un asistente de IA, que lo analizará, corregirá errores y generará un ZIP listo para usar.

**Tiempo estimado:** 15-30 minutos

**Instrucciones:**

- Asegúrate de tener instalado para ejecutar el proyecto: Un IDE o editor de código.
- Copia todo el contenido del campo **Código Base** de este reto — incluyendo el texto de instrucciones que aparece al inicio.
- Abre un asistente de IA (Claude en claude.ai, ChatGPT o Gemini — se recomienda Claude), pega el contenido copiado en el chat y envíalo.
- El asistente analizará los archivos, corregirá errores y generará un archivo ZIP descargable. Descárgalo y extráelo en la carpeta donde quieras trabajar.
- Verifica que el proyecto arranca sin errores.

**Entregable:** El proyecto compila/arranca sin errores.

<details>
<summary>Pistas de conocimiento</summary>

- Copia el Código Base completo incluyendo el texto de instrucciones al inicio — esas instrucciones le indican al asistente exactamente qué hacer con los archivos.
- Si el asistente no genera el ZIP automáticamente al terminar el análisis, escríbele: "genera el ZIP ahora".
- Si el proyecto tiene errores al arrancar, comparte el mensaje de error con el mismo asistente para que lo corrija.

</details>

### Fase 1: Exploración del Sistema y Definición de Requisitos

**Objetivo:** Identificar las restricciones y ambigüedades del sistema actual para definir los requisitos de las estrategias de despliegue.

**Tiempo estimado:** 3 días

**Instrucciones:**

- Analiza el sistema de procesamiento de transacciones financieras y documenta las restricciones actuales.
- Identifica las ambigüedades que podrían afectar la implementación de las estrategias de despliegue.
- Define los requisitos para las estrategias Blue-Green, A/B y Canary.

**Entregable:** Documento de requisitos para las estrategias de despliegue.

<details>
<summary>Pistas de conocimiento</summary>

- Considera el impacto de las restricciones en la latencia y disponibilidad del sistema.
- Evalúa cómo las ambigüedades podrían afectar la consistencia de los datos durante el despliegue.

</details>

### Fase 2: Implementación de la Estrategia Blue-Green

**Objetivo:** Implementar la estrategia Blue-Green para asegurar una transición sin interrupciones en el despliegue del servicio.

**Tiempo estimado:** 5 días

**Instrucciones:**

- Diseña la arquitectura para la estrategia Blue-Green, considerando la latencia y disponibilidad del sistema.
- Implementa la estrategia y realiza pruebas para validar su funcionamiento.
- Documenta los resultados y las decisiones tomadas.

**Entregable:** Implementación y documentación de la estrategia Blue-Green.

<details>
<summary>Pistas de conocimiento</summary>

- Considera el impacto de la estrategia en la latencia y disponibilidad del sistema.
- Evalúa los posibles puntos de falla y cómo mitigarlos.

</details>

### Fase 3: Implementación de la Estrategia A/B

**Objetivo:** Implementar la estrategia A/B para probar nuevas funcionalidades en un subconjunto de usuarios.

**Tiempo estimado:** 5 días

**Instrucciones:**

- Diseña la arquitectura para la estrategia A/B, considerando la consistencia y la latencia del sistema.
- Implementa la estrategia y realiza pruebas para validar su funcionamiento.
- Documenta los resultados y las decisiones tomadas.

**Entregable:** Implementación y documentación de la estrategia A/B.

<details>
<summary>Pistas de conocimiento</summary>

- Considera el impacto de la estrategia en la consistencia y la latencia del sistema.
- Evalúa los posibles puntos de falla y cómo mitigarlos.

</details>

### Fase 4: Implementación de la Estrategia Canary

**Objetivo:** Implementar la estrategia Canary para desplegar nuevas versiones del servicio en un subconjunto de usuarios.

**Tiempo estimado:** 5 días

**Instrucciones:**

- Diseña la arquitectura para la estrategia Canary, considerando la latencia y la disponibilidad del sistema.
- Implementa la estrategia y realiza pruebas para validar su funcionamiento.
- Documenta los resultados y las decisiones tomadas.

**Entregable:** Implementación y documentación de la estrategia Canary.

<details>
<summary>Pistas de conocimiento</summary>

- Considera el impacto de la estrategia en la latencia y la disponibilidad del sistema.
- Evalúa los posibles puntos de falla y cómo mitigarlos.

</details>

## Dimensiones Evaluadas

- **queEs**: ¿Qué es la estrategia Blue-Green y cómo se aplica en el contexto del despliegue de servicios?
- **paraQueSirve**: ¿Para qué sirve la estrategia A/B en el despliegue de nuevas funcionalidades?
- **comoSeUsa**: ¿Cómo se usa la estrategia Canary para minimizar el riesgo de fallos en el despliegue de nuevas versiones?
- **erroresComunes**: ¿Cuáles son los errores comunes al implementar estrategias de despliegue y cómo se pueden mitigar?
- **queDecisionesImplica**: ¿Qué decisiones implica la elección de una estrategia de despliegue sobre otra en un entorno empresarial?

## Criterios de Evaluacion

- Identificación correcta de las restricciones y ambigüedades del sistema.
- Implementación efectiva de la estrategia Blue-Green.
- Implementación efectiva de la estrategia A/B.
- Implementación efectiva de la estrategia Canary.
- Documentación clara y completa de los resultados y decisiones tomadas.

## Como trabajar con un asistente de IA

Hay dos caminos, elegi uno:

- **AGENTS.md** (recomendado) — instrucciones nativas del repo. Abri esta carpeta con tu agente local (Claude Code, Cursor, Codex, Copilot, Gemini) y las carga solo. Sabe que archivos faltan y con que comando se verifica, y completa el scaffold escribiendo en disco.
- **PROMPT_MEJORA.md** — para copiar y pegar en un chat (claude.ai, ChatGPT). Devuelve un ZIP con el proyecto. Sirve si no tenes un agente en el IDE.

Ninguno de los dos resuelve las fases del reto: eso es tu trabajo.

## Verificacion

El proyecto esta listo para trabajar cuando este comando corre sin errores:

```bash
docker build -t reto:local . && terraform -chdir=terraform init -backend=false && terraform -chdir=terraform validate
```

---

*Reto generado automaticamente por Challenge Generator - Pragma*
