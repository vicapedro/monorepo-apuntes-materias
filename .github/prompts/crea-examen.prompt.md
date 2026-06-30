---
agent: 'agent'
description: 'Crea un examen alineado a Bloom, Moodle y al programa oficial de la materia'
---

## Tarea

Crea o actualiza un examen para este repositorio.

## Entradas

- Materia o ruta base: ${input:materia_ruta:Ruta de la materia o nombre de la asignatura}
- Cobertura: ${input:cobertura:Unidad, conjunto de temas o examen diagnóstico/formativo/sumativo}
- Formato: ${input:formato:Moodle XML o GIFT}
- Archivo de salida: ${input:archivo_salida:Ruta del archivo a crear o actualizar}
- Número de reactivos: ${input:reactivos:Cantidad aproximada de preguntas}
- Contexto adicional: ${input:contexto:Distribución deseada, prerequisitos o restricciones}

## Flujo obligatorio

1. Consulta el programa oficial de la materia.
2. Revisa exámenes existentes de la asignatura.
3. Si el examen se alinea con una unidad específica, consulta también el diseño instruccional correspondiente.

## Requisitos de contenido

- Alinea la evaluación con competencias, temas y prerrequisitos oficiales.
- Usa la distribución de Bloom del repositorio como rango de referencia y ajústala para que el total del examen sume 100%:
  - 20-30% recordar/comprender
  - 40-50% aplicar/analizar
  - 20-30% evaluar/crear
- Si necesitas una distribución concreta, usa una válida como 25%, 45% y 30%, respectivamente.
- Incluye retroalimentación útil por reactivo cuando el formato lo soporte.
- Favorece contextos auténticos y casos aplicados en niveles medios y altos.

## Tipos de examen

- Diagnóstico: conocimientos previos y prerrequisitos
- Formativo: seguimiento de una unidad o bloque
- Sumativo: integración de competencias y transferencia

## Criterios de salida

- Mantén la sintaxis estricta del formato elegido.
- Un examen debe mostrar cobertura y progresión cognitiva más amplia que un quiz.
