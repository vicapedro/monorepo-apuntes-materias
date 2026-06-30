---
agent: 'agent'
description: 'Crea instrumentación didáctica TecNM coherente con programa oficial, diseño e indicadores'
---

## Tarea

Crea o actualiza una instrumentación didáctica para una materia o unidad de este repositorio.

## Entradas

- Materia o ruta base: ${input:materia_ruta:Ruta de la materia o nombre de la asignatura}
- Alcance: ${input:alcance:Materia completa, unidad o bloque específico}
- Archivo de salida: ${input:archivo_salida:Ruta del archivo a crear o actualizar}
- Contexto docente: ${input:contexto_docente:Nombre del docente, semestre, grupo o modalidad si aplica}
- Contexto adicional: ${input:contexto:Restricciones institucionales o enfoque requerido}

## Flujo obligatorio

1. Consulta primero el programa oficial de la materia (`[Materia].txt` o `[Materia].md`).
2. Revisa el diseño instruccional existente de la materia o unidad.
3. Revisa `shared/Evaluacion_Enfoque_Competencias.md`.
4. Revisa `shared/correspondencia_evidencia_indicadores.md`.
5. Usa `shared/plantilla-instrumentacion-didactica.md` y ejemplos cercanos como patrón principal.

## Requisitos de contenido

- Extrae competencias, temas y bibliografía del programa oficial.
- Mantén coherencia entre metodología, evidencias, instrumentos e indicadores A-F, validando la asignación con `shared/correspondencia_evidencia_indicadores.md`.
- Haz que cada matriz de evidencias sume 100% por unidad.
- Usa descripciones de actividades a alto nivel dentro del diseño.
- Propón instrumentos pertinentes según el tipo de evidencia: conocimiento con sus indicadores aplicables, producto con rúbrica o lista de cotejo, y desempeño o actitud con guía de observación.
- Si falta información administrativa, usa marcadores claros para completarla sin inventar datos sensibles.

## Estructura mínima esperada

- Información general de la asignatura
- Caracterización de la asignatura
- Intención didáctica
- Indicadores de alcance
- Análisis por competencias específicas
- Desarrollo por unidad
- Evidencias e instrumentos
- Fuentes de información

## Criterios de salida

- No conviertas la instrumentación en una práctica detallada.
- Conserva el estilo TecNM y la trazabilidad con los documentos base del repositorio.
