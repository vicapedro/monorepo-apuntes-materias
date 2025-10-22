# Proyecto Zaboo Mazoo — Guía rápida

Repositorio de prácticas para el proyecto de curso "Zaboo Mazoo" (Zoológico). Contiene prácticas guiadas, scripts y plantillas para que los alumnos construyan una base de datos completa.

Estructura principal

- `Proyecto-curso/` — prácticas (MD) por número.
- `Proyecto-curso/sql_templates/` — scripts base: `create_schema.sql`, `indices.sql`, `security.sql`, `procedures.sql`, `maintenance.sql`.

Cómo empezar (SQL Server - ejemplo)

1. Abrir `create_schema.sql` y ajustar el nombre de la base de datos o esquema si es necesario.
2. Ejecutar `indices.sql` para crear índices iniciales.
3. Ejecutar `security.sql` para crear roles de ejemplo (ajustar usuarios).
4. Usar `procedures.sql` para cargar procedimientos y triggers.
5. Simular carga con `seed_data` (ver práctica 5).

Sugerencias
- Revisa y adapta tipos de datos según SGBD objetivo.
- No ejecutes los scripts de backup en entornos productivos sin validar rutas y permisos.

¿Quieres que genere datos de ejemplo (CSV) o un generador en Python para `seed_data` ahora?
