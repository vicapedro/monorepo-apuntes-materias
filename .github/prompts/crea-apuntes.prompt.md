---
agent: 'agent'
description: 'Crea apuntes teóricos concisos y rigurosos alineados al programa oficial de la materia'
---

## Tarea

Crea o actualiza apuntes teóricos para una materia de este repositorio.

## Entradas

- Materia o ruta base: ${input:materia_ruta:Ruta de la materia o nombre de la asignatura}
- Tema o subtema: ${input:tema:Tema, subtema o sección a desarrollar}
- Archivo de salida: ${input:archivo_salida:Ruta del archivo a crear o actualizar}
- Nivel de profundidad: ${input:profundidad:Básico, intermedio o avanzado}
- Contexto adicional: ${input:contexto:Conceptos clave, software, versión o enfoque deseado}

## Flujo obligatorio

1. Consulta el programa oficial de la materia (`[Materia].txt` o `[Materia].md`).
2. Revisa apuntes cercanos de la misma unidad para respetar tono y granularidad.
3. Si aplica, alinea el contenido con prácticas, actividades o evaluaciones ya presentes.

## Requisitos de contenido

- Explica conceptos con precisión académica y ejemplos útiles.
- Prioriza documentación oficial y bibliografía reconocida.
- Mantén un texto conciso, evitando redundancias.
- Usa terminología técnica en inglés solo cuando sea estándar y explíquela en español.
- Cierra con una sección de referencias cuando el contenido la requiera.

## Criterios de salida

- El resultado debe sentirse consistente con los apuntes ya existentes del repositorio.
- Evita convertir los apuntes en una práctica o actividad paso a paso.
- Si detectas archivos de código o ejemplos cercanos, aprovéchalos para ilustrar el tema sin duplicarlos innecesariamente.
