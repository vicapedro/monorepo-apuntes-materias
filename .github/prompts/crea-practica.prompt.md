---
agent: 'agent'
description: 'Crea una práctica de laboratorio alineada al programa oficial y a los patrones del repositorio'
---

## Tarea

Crea o actualiza una práctica de laboratorio para este repositorio.

## Entradas

- Materia o ruta base: ${input:materia_ruta:Ruta de la materia o nombre de la asignatura}
- Unidad o tema: ${input:unidad_tema:Unidad, tema o subtema a cubrir}
- Competencia o propósito: ${input:competencia:Competencia específica, propósito o resultado esperado}
- Archivo de salida: ${input:archivo_salida:Ruta del archivo a crear o actualizar}
- Contexto adicional: ${input:contexto:Restricciones, software, equipo o escenario deseado}

## Flujo obligatorio

1. Consulta primero el programa oficial de la materia (`[Materia].txt` o `[Materia].md`).
2. Revisa el diseño instruccional de la materia si existe (`Diseño_Instruccional*.md`).
3. Busca prácticas vecinas de la misma unidad para reutilizar tono, profundidad y estructura.
4. Si falta contexto, pide únicamente la información indispensable.

## Requisitos de contenido

- Redacta en español técnico claro.
- Mantén coherencia con competencias, prerequisitos y bibliografía oficial.
- Usa un contexto profesional o caso aplicado cuando aporte valor.
- Incluye recursos, herramientas y entregables realistas.
- Si propones evaluación, sugiere instrumentos que el repositorio ya usa, por ejemplo rúbrica de 4 niveles o lista de cotejo.

## Estructura obligatoria

```markdown
# Práctica [número]: [título]
## Objetivo
**Duración estimada:** [X horas]
## Competencias a desarrollar
- ...
## Introducción
## Equipo de protección e higiene
## Material y equipo necesario
### Materiales e insumos
### Equipo de laboratorio
### Herramientas
## Instrucciones
## Notas
```

## Criterios de salida

- Sigue el patrón de nombres y nivel de detalle de las prácticas ya existentes.
- No agregues secciones ajenas al formato salvo que el contexto de la materia ya las use.
- Si actualizas una práctica existente, conserva el contenido útil y modifica solo lo necesario.
