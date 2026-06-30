---
agent: 'agent'
description: 'Crea un quiz en formato Moodle XML o GIFT alineado a competencias e indicadores'
---

## Tarea

Crea o actualiza un quiz para Moodle a partir de los patrones del repositorio.

## Entradas

- Materia o ruta base: ${input:materia_ruta:Ruta de la materia o nombre de la asignatura}
- Tema evaluado: ${input:tema:Tema, subtema o unidad}
- Formato: ${input:formato:XML o GIFT}
- Archivo de salida: ${input:archivo_salida:Ruta del archivo a crear o actualizar}
- Número de reactivos: ${input:reactivos:Cantidad aproximada de preguntas}
- Contexto adicional: ${input:contexto:Nivel de dificultad, tipo de curso o restricciones}

## Flujo obligatorio

1. Consulta el programa oficial de la materia.
2. Revisa quizzes, bancos de preguntas o exámenes cercanos de la misma asignatura.
3. Usa el cuadro `shared/correspondencia_evidencia_indicadores.md` para mapear correctamente la evidencia de conocimiento del quiz a sus indicadores aplicables.

## Requisitos de contenido

- Redacta preguntas claras, sin ambigüedades innecesarias.
- Prioriza tipos autocalificables del repositorio.
- Distribuye dificultad de forma gradual.
- Incluye retroalimentación útil para cada reactivo cuando el formato lo permita.
- Para quizzes de conocimiento, usa solo los indicadores que correspondan al instrumento según la tabla compartida; por ejemplo, opción múltiple y falso/verdadero usan A y F, y análisis de casos usa A, B, D y F.
- Si el formato es XML, genera un `<quiz>` válido con preguntas completas.
- Si el formato es GIFT, usa categorías y sintaxis correctas.

## Tipos sugeridos

- Opción múltiple de respuesta única
- Verdadero/Falso
- Opción múltiple de respuestas múltiples
- Relación o arrastrar y soltar

## Criterios de salida

- Un quiz es breve y focalizado; no lo conviertas en examen integral.
- Mantén consistencia con los nombres de preguntas y convenciones ya usadas en la materia.
