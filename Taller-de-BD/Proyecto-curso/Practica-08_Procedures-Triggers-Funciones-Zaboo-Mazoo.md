# Práctica 8: Procedimientos, funciones y triggers — Zaboo Mazoo

## Objetivo
**Duración estimada:** 6-8 horas

Encapsular lógica de negocio en procedimientos almacenados, funciones y triggers con manejo de errores y auditoría.

## Competencias a desarrollar
- Escribir stored procedures para operaciones comunes (registro de entrada, alta de animal, venta en tienda).
- Definir funciones para cálculos reutilizables (edad de animal, disponibilidad de cupo).
- Crear triggers de auditoría y validación (por ejemplo, impedir eliminar especie con animales activos).

## Instrucciones
1. Implementar al menos 5 stored procedures y 3 funciones. Ejemplos:
   - `sp_registrar_entrada(cliente_id, tipo_entrada, fecha)`
   - `sp_alta_animal(datos...)`
   - `fn_calcula_edad(fecha_nacimiento)`
2. Crear triggers de auditoría que registren cambios (INSERT/UPDATE/DELETE) en tablas críticas en schema `audit`.
3. Incluir manejo de transacciones y control de errores.

## Entregables
- `procedures.sql` con los procedimientos, funciones y triggers.
- `tests_procedures.sql` con casos de prueba mínimos.

## Evaluación
- Correctitud y robustez del código (40%)
- Manejo de errores y transacciones (30%)
- Tests y documentación (30%)
