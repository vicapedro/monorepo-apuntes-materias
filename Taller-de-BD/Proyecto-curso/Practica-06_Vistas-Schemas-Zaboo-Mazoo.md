# Práctica 6: Vistas, Schemas y separación lógica — Zaboo Mazoo

## Objetivo
**Duración estimada:** 3-4 horas

Crear vistas útiles para reportes y separar objetos en schemas lógicos (p. ej. `zoo`, `audit`, `store`) para organizar permisos y mantenimiento.

## Competencias a desarrollar
- Diseñar vistas (simples y con agregación) que simplifiquen consultas de usuario.
- Crear schemas y mover objetos entre schemas.
- Evaluar cuándo usar vistas materializadas (o índices sobre vistas) según el SGBD.

## Material y equipo necesario
- Base de datos con datos de Práctica 5.

## Instrucciones
1. Diseñar al menos 6 vistas que cubran necesidades del sistema (ejemplos):
   - `v_animales_disponibles` (info de animales por hábitat y especie)
   - `v_visitas_por_dia` (agregación de entradas por fecha)
   - `v_inventario_bajo_stock` (productos con stock bajo)
   - `v_historial_veterinario` (registros médicos por animal)
   - `v_eventos_proximos` (eventos con cupo disponible)
   - `v_resumen_financiero` (entradas + ventas por día)
2. Crear schemas: `zoo`, `audit`, `store`, `reports`.
3. Implementar una vista materializada o indexed view si el SGBD lo soporta y documentar el porqué.

## Entregables
- `views_and_schemas.sql` con CREATE SCHEMA y CREATE VIEW/CREATE MATERIALIZED VIEW.
- `views_report.md` con justificación de cada vista.

## Evaluación
- Utilidad y cobertura de vistas (40%)
- Organización en schemas y claridad (30%)
- Documentación (30%)
