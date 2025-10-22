# Práctica 11: Transacciones y Concurrencia — Zaboo Mazoo

## Objetivo
**Duración estimada:** 4-6 horas

Comprender y controlar el comportamiento transaccional y de concurrencia en la base de datos: ACID, niveles de aislamiento, bloqueos, deadlocks, recuperación y patrones de diseño para aplicaciones concurrentes.

## Competencias a desarrollar
- Aplicar transacciones y manejar ACID en operaciones críticas.
- Probar y comparar niveles de aislamiento (READ UNCOMMITTED, READ COMMITTED, REPEATABLE READ, SERIALIZABLE, SNAPSHOT).
- Detectar y resolver bloqueos y deadlocks; diseñar retry logic y técnicas de reducción de contención.
- Usar savepoints, rollbacks parciales y estrategias de compensación.

## Introducción
En entornos multiusuario las operaciones concurrentes pueden causar lecturas sucias, no repetibles o fantasmas, además de bloqueos y deadlocks. Esta práctica guía al alumno a experimentar con transacciones reales sobre tablas del proyecto (p. ej. `store.producto`, `zoo.animal`, `zoo.entrada`) y a diseñar soluciones robustas.

## Material y equipo necesario
- Base de datos de las prácticas anteriores con datos de prueba.
- Cliente SQL que permita abrir dos sesiones simultáneas (SSMS, sqlcmd, DBeaver).
- Permisos para ejecutar paquetes de diagnóstico (sys.dm_* en SQL Server) si se desea análisis avanzado.

## Instrucciones
1. Repaso teórico breve (anotar en `notes.md`): ACID, qué protege cada letra; definición de niveles de aislamiento y efecto esperado.

2. Ejercicio A — Transacción básica y rollback
   - En sesión A: iniciar transacción, actualizar `store.producto.stock` (restar cantidad), no hacer commit.
   - En sesión B: intentar leer/actualizar la misma fila con distintos niveles de aislamiento y observar comportamientos.
   - Documentar resultados y explicar por qué.

3. Ejercicio B — Lecturas sucias, no repetibles y fantasmas
   - Reproducir cada anomalía cambiando el orden de operaciones y el nivel de aislamiento.
   - Tomar capturas del plan/resultado y explicar cómo cada nivel previene (o no) la anomalía.

4. Ejercicio C — Deadlock y diagnóstico
   - Crear un escenario de deadlock con dos transacciones que adquieren los locks en distinto orden (ejemplo: T1 bloquea fila A luego intenta bloquear B; T2 bloquea B luego intenta bloquear A).
   - Usar `sys.dm_tran_locks`, `sys.dm_os_waiting_tasks` y el log de deadlock (o la captura gráfica) para identificar el victim.
   - Implementar una política de retry/backoff para la aplicación cliente y probar que la operación se completa eventual.

5. Ejercicio D — Isolation Snapshot y ventajas
   - Habilitar y probar `READ_COMMITTED_SNAPSHOT` (si el SGBD lo soporta) y comparar con snapshot isolation.
   - Documentar overhead y escenarios donde conviene usarlo.

6. Ejercicio E — Savepoints y rollbacks parciales
   - Diseñar una transacción que inserte en 3 tablas; usar savepoint antes de la segunda inserción y hacer rollback a savepoint si falla la segunda, manteniendo la primera.

7. Entregable práctico
   - `transacciones_pruebas.sql` con scripts (comentados) para reproducir los ejercicios A–E. Cada script debe indicar pasos 1..N y qué hacer en la otra sesión.
   - `transacciones_notas.md` con resultados, capturas y decisiones sobre la estrategia de concurrencia para el proyecto Zaboo Mazoo.

## Pistas y consultas útiles (SQL Server)
- Ver locks activos:

```sql
SELECT * FROM sys.dm_tran_locks WHERE resource_database_id = DB_ID() ORDER BY request_session_id;
```

- Ver tareas en espera:

```sql
SELECT * FROM sys.dm_os_waiting_tasks WHERE session_id > 50;
```

- Habilitar READ_COMMITTED_SNAPSHOT (requiere exclusividad de DB):

```sql
ALTER DATABASE IndiceTestDB SET READ_COMMITTED_SNAPSHOT ON;
```

- Ejemplo de transacción con savepoint:

```sql
BEGIN TRAN;
INSERT INTO store.producto (sku, nombre, precio) VALUES ('TEST-1','Prueba',10.0);
SAVE TRAN sv1;
BEGIN TRY
  INSERT INTO store.venta (producto_id, cantidad) VALUES (SCOPE_IDENTITY(), 5);
  COMMIT TRAN;
END TRY
BEGIN CATCH
  ROLLBACK TRAN TO sv1; -- retrocede solo a savepoint
  ROLLBACK TRAN; -- si es necesario
END CATCH;
```

## Criterios de evaluación
- `transacciones_pruebas.sql` reproduce correctamente los escenarios (50%).
- Diagnóstico de deadlocks y plan de mitigación (25%).
- Documentación y justificación de la estrategia de concurrencia para Zaboo Mazoo (25%).

## Entregable
- Carpeta `practica11_<apellidos>_<grupo>` con `transacciones_pruebas.sql` y `transacciones_notas.md`.

