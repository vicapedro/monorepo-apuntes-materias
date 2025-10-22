# Práctica 7: Seguridad — Roles y permisos — Zaboo Mazoo

## Objetivo
**Duración estimada:** 3-4 horas

Diseñar roles de seguridad y aplicar el principio de privilegio mínimo sobre el esquema de Zaboo Mazoo.

## Competencias a desarrollar
- Crear roles y cuentas con permisos acotados.
- Configurar esquemas y ownership chaining cuando proceda.
- Documentar políticas de acceso para perfiles: admin, veterinario, taquilla, tienda, auditor.

## Instrucciones
1. Definir al menos 5 roles con responsabilidades y permisos.
2. Implementar scripts `security.sql` que:
   - Creen roles y usuarios de ejemplo.
   - Asignen permisos de SELECT/INSERT/UPDATE/DELETE en objetos concretos.
   - Revoken permisos sensibles.
3. Incluir consideraciones de auditoría (schema `audit`) y cuentas de servicio.

## Entregables
- `security.sql` con scripts de creación de roles y asignaciones.
- `security_plan.md` con justificación y mapa de permisos.

## Evaluación
- Corrección de permisos y principio de mínimo privilegio (50%)
- Documentación y pruebas (50%)
