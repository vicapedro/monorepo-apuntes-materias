# Práctica 9: Mantenimiento e integridad — Backups y mantenimiento de índices — Zaboo Mazoo

## Objetivo
**Duración estimada:** 4-6 horas

Diseñar y probar planes de backup/restore y tareas de mantenimiento de índices y estadísticas.

## Competencias a desarrollar
- Crear scripts de backup y restore (full, differential, log si aplica).
- Planear tareas de mantenimiento (REBUILD/REORGANIZE, actualización de estadísticas).
- Verificar integridad y preparar playbook de recuperación.

## Instrucciones
1. Escribir `maintenance.sql` con:
   - BACKUP DATABASE / RESTORE examples (ajustar a SGBD).
   - Scripts para REBUILD/REORGANIZE por índice según fragmentación.
2. Simular un escenario de recuperación: eliminar datos y restaurar desde backup en una base temporal.
3. Documentar SLA y frecuencia recomendada.

## Entregables
- `maintenance.sql` y `recovery_playbook.md`.

## Evaluación
- Completitud del playbook (50%)
- Scripts y simulación de restauración (50%)
