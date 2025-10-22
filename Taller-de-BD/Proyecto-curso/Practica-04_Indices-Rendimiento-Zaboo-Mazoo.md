# Práctica 4: Índices y rendimiento — Zaboo Mazoo

## Objetivo
**Duración estimada:** 4-6 horas

Diseñar y crear índices iniciales (clustered, nonclustered, cubrientes, filtrados) para las tablas críticas del proyecto, y evaluar el impacto en consultas representativas.

## Competencias a desarrollar
- Seleccionar columnas para índices según selectividad y patrones de consulta.
- Crear índices con `INCLUDE` y filtros.
- Medir impacto con `EXPLAIN/SHOW PLAN` o `SET STATISTICS IO/TIME` según SGBD.

## Material y equipo necesario
- Base de datos con datos de prueba (Práctica 5 prepara datos de semilla).
- Script de consultas representativas (SELECTs frecuentes).

## Instrucciones
1. Identificar 5 consultas críticas del sistema (por ejemplo: búsqueda de animales por especie; reporte de visitas por fecha; ventas en tienda por SKU).
2. Crear índices propuestos; documentar la razón para cada índice.
3. Medir tiempos/plan de consulta antes y después de crear índices y redactar un informe corto (máx. 2 páginas) con recomendaciones.
4. Realizar limpieza: si un índice no aporta mejora significativa, justificar su eliminación.

## Entregables
- `indices.sql` con CREATE INDEX.
- `benchmark.md` con resultados de mediciones y captura del plan de ejecución.

## Evaluación
- Calidad de elección de índices (40%)
- Evidencia de medición y justificación (40%)
- Documentación clara (20%)
