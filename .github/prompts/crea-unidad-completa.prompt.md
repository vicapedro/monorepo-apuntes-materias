---
agent: 'agent'
description: 'Orquesta la creacion integral de una unidad: instrumentacion, actividades, practica, apuntes, quiz y examen'
---

## Tarea

Crea o actualiza el paquete completo de una unidad academica para este repositorio.

## Entradas

- Materia o ruta base: ${input:materia_ruta:Ruta de la materia o nombre de la asignatura}
- Unidad o tema macro: ${input:unidad_tema:Unidad y alcance tematico}
- Competencia principal: ${input:competencia:Competencia especifica de la unidad}
- Semanas disponibles: ${input:semanas:Numero de semanas para la unidad}
- Contexto adicional: ${input:contexto:Restricciones, recursos, modalidad, LMS}

## Flujo obligatorio

1. Consultar programa oficial de la materia.
2. Generar o actualizar instrumentacion de la unidad.
3. Diseñar actividades de aprendizaje y ensenanza.
4. Diseñar al menos una practica principal.
5. Preparar apuntes de soporte por tema.
6. Generar quiz formativo.
7. Generar examen de cierre segun alcance.

## Requisitos de alineacion

- Mantener coherencia competencia-evidencia-instrumento.
- Cerrar ponderaciones al 100% en la unidad cuando aplique.
- Distribuir indicadores A-F segun correspondencia oficial.
- En evaluacion escrita, respetar distribucion Bloom del repositorio.

## Criterios de salida

- Crear o actualizar un conjunto coherente de archivos por unidad.
- Evitar contradicciones entre instrumentacion, actividades y evaluacion.
- Priorizar plantillas guiadas y contenido reutilizable por docentes.
