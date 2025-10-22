# Práctica 3: DDL y Constraints — Zaboo Mazoo

## Objetivo
**Duración estimada:** 6-8 horas

Implementar el esquema relacional en DDL (CREATE TABLE) y aplicar constraints: PRIMARY KEY, FOREIGN KEY, UNIQUE, CHECK, DEFAULT y NOT NULL. También practicar ALTER TABLE para añadir constraints a tablas existentes.

## Competencias a desarrollar
- Escribir scripts DDL claros y portables para el SGBD objetivo.
- Definir correctamente PK, FK, CHECK, UNIQUE y DEFAULT.
- Hacer modificaciones con `ALTER TABLE` y usar `WITH NOCHECK`/`WITH CHECK` (cuando aplique).

## Material y equipo necesario
- Resultado de la Práctica 2 (esquema relacional).
- Acceso a SGBD (opcional: SQL Server, MariaDB, PostgreSQL).

## Instrucciones
1. Preparar `create_schema.sql` que contenga:
   - Creación de schemas (por ejemplo `dbo`, `zoo`, `audit`).
   - CREATE TABLE para todas las tablas del esquema relacional con tipos de datos recomendados.
   - Constraints principales inline y/o como constraints nombradas.
2. Tareas adicionales (ejercicios obligatorios):
   - Añadir un CHECK complejo (p. ej. `peso > 0` y `fecha_nacimiento <= GETDATE()`).
   - Añadir un DEFAULT y documentar el efecto en filas existentes (`WITH VALUES` en SQL Server).
   - Usar `ALTER TABLE` para añadir un FK a una tabla ya poblada y describir cómo manejar violaciones.
3. Entregables:
   - `create_schema.sql` funcional.
   - `alter_constraints_examples.sql` con ejemplos de ALTER y notas.
   - `notes.md` que explique decisiones de tipos de datos y tradeoffs.

## Evaluación
- Correctitud del DDL (40%)
- Uso correcto de constraints y manejo de datos existentes (30%)
- Calidad de documentación y scripts de ALTER (30%)
