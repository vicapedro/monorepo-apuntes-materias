---
name: wf-crea-practica
description: 'Genera y mejora practicas de laboratorio en formato Markdown para asignaturas tecnicas. Usar cuando se requiera crear Practica*.md alineada a competencias, evidencias, seguridad, recursos y rubrica.'
argument-hint: 'asignatura, unidad, tema, competencia, duracion estimada'
user-invocable: true
---

# Crea Practica

## Cuando usar
- Crear una practica nueva para una unidad.
- Reestructurar una practica existente al formato institucional.
- Alinear una practica con competencias y evidencia evaluable.

## Entradas minimas
- Asignatura y unidad.
- Tema o subtema.
- Competencia especifica.
- Duracion estimada.
- Contexto de laboratorio o simulador.

## Procedimiento
1. Verificar programa oficial de la asignatura en la carpeta raiz de la materia.
2. Extraer competencia y relacionarla con la unidad.
3. Generar el archivo con esta estructura:
   - Titulo de practica.
   - Objetivo.
   - Duracion estimada.
   - Competencias a desarrollar.
   - Introduccion.
   - Equipo de proteccion e higiene.
   - Material y equipo necesario.
   - Instrucciones.
   - Notas.
4. Incluir evidencia esperada y criterios de evaluacion.
5. Agregar instrumento sugerido (rubrica o lista de cotejo) segun evidencia.

## Salida esperada
- Archivo `Practica-XX-Tema.md` o `Practica-Tema.md` en la unidad correspondiente.
- Redaccion en espanol tecnico, clara y accionable.

## Verificacion
- Estructura completa sin secciones faltantes.
- Coherencia entre objetivo, instrucciones y evidencia.
- Alineacion con el programa oficial y criterios institucionales.
