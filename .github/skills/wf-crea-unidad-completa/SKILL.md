---
name: wf-crea-unidad-completa
description: 'Orquesta la creacion integral de una unidad academica: instrumentacion, actividades, practicas, apuntes, quiz y examen. Usar cuando se requiera construir un paquete completo y coherente por unidad.'
argument-hint: 'asignatura, unidad, competencia, semanas disponibles'
user-invocable: true
---

# Crea Unidad Completa

## Cuando usar
- Construir todos los entregables de una unidad en secuencia.
- Estandarizar productos entre varios docentes.
- Preparar implementacion de curso con trazabilidad completa.

## Entradas minimas
- Asignatura y unidad.
- Competencia especifica de la unidad.
- Tiempo disponible y modalidad de imparticion.

## Flujo orquestado
1. Ejecutar `wf-crea-instrumentacion` para fijar marco y matriz.
2. Ejecutar `wf-crea-actividad` para actividades clave.
3. Ejecutar `wf-crea-practica` para laboratorio o simulacion.
4. Ejecutar `wf-crea-apuntes` para soporte teorico.
5. Ejecutar `wf-crea-quiz` para evaluacion formativa.
6. Ejecutar `wf-crea-examen` para evaluacion sumativa.

## Salidas esperadas
- Conjunto de archivos de unidad listos para uso docente.
- Coherencia entre competencias, actividades, evidencias y evaluacion.

## Verificacion
- Ningun archivo contradice la instrumentacion base.
- Carga de trabajo y evaluacion son viables en calendario.
- Evidencias y rubricas corresponden a los productos solicitados.
