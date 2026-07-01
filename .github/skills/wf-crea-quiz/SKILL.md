---
name: wf-crea-quiz
description: 'Genera quizzes en Moodle XML o GIFT para evaluacion rapida por tema, con claves, retroalimentacion y distribucion por Bloom. Usar para cuestionarios formativos o sumativos breves.'
argument-hint: 'tema, cantidad de reactivos, formato (xml o gift), dificultad'
user-invocable: true
---

# Crea Quiz

## Cuando usar
- Crear cuestionarios por tema o subtema.
- Generar evaluacion formativa automatizable en LMS.
- Reforzar conceptos previos antes de practica o examen.

## Entradas minimas
- Tema y objetivo de evaluacion.
- Numero de reactivos.
- Formato de salida: Moodle XML o GIFT.
- Nivel cognitivo objetivo.

## Procedimiento
1. Definir blueprint de reactivos por Bloom.
2. Construir preguntas con enunciado claro y distractores plausibles.
3. Incluir retroalimentacion por opcion cuando aplique.
4. Validar sintaxis del formato seleccionado.
5. Revisar coherencia con competencias y vocabulario tecnico del curso.

## Salida esperada
- Archivo `Quiz-XX-Tema.xml` o `Quiz-XX-Tema.gift` listo para importar.

## Verificacion
- Balance de dificultad y cobertura del tema.
- Sintaxis valida y reactivos sin ambiguedad.
- Retroalimentacion util para aprendizaje.
