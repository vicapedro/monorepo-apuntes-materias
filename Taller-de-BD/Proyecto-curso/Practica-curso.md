
# Proyecto de prácticas de bases de datos — diseño, implementación y mantenimiento

**Objetivo general**:

Que el alumno construya una BD completa: diseño Chen → modelo relacional → DDL físico → constraints → índices → vistas → esquemas/roles/permisos → triggers, funciones y procedimientos.
Usar un caso real (Zaboo Mazoo) enriquecido con subdominios (visitantes, personal, hábitats, veterinaria, entradas, donaciones, eventos, inventario).
Propuesta de secuencia de prácticas (incremental, de baja a alta complejidad)

Las siguientes prácticas están diseñadas para ser realizadas en un entorno de desarrollo, con un enfoque práctico y progresivo. Cada práctica se basa en la anterior, permitiendo al alumno construir sobre lo aprendido. Para esto utilizaremos un caso de estudio ficticio llamado "Zaboo Mazoo", que simula un zoológico con diversas entidades y relaciones.


## Práctica 1 — Levantamiento y modelado conceptual (ER Chen)

Objetivo: capturar requisitos y diagramar ER (Chen).
Entradas: enunciado del zoo, casos de uso básicos.
Entregable: Diagrama ER + lista de entidades/atributos y cardinalidades.
Duración: 4–6 h.


## Práctica 2 — Mapeo a modelo relacional y normalización

Objetivo: transformar ER a tablas; aplicar 1FN/2FN/3FN.
Tareas: proponer claves, dependencias funcionales, identificar anomalías y normalizar.
Entregable: Esquema relacional + justificación de normalización.
Duración: 6–8 h.

## Práctica 3 — DDL inicial y constraints

Objetivo: crear scripts CREATE TABLE con PK, FK, UNIQUE, CHECK, DEFAULT.
Tareas: script DDL, manejo de NULLs, ejemplos de ALTER para añadir constraints.
Entregable: scripts .sql y plan de migración.
Duración: 6–8 h.

## Práctica 4 — Índices y rendimiento básico

Objetivo: elegir índices clustered/nonclustered, índices compuestos e índices incluidos.
Tareas: crear índices, medir (EXPLAIN/SET STATISTICS), justificar decisiones.
Entregable: script de índices y breve informe de impacto.
Duración: 4–6 h.

## Práctica 5 — Datos de prueba y carga inicial

Objetivo: poblar la BD con datos semilla realistas (CSV/INSERTs).
Tareas: generación de datos, scripts de carga, transacciones y checkpoints.
Entregable: datasets y script de carga.
Duración: 4–6 h.
## Práctica 6 — Vistas, esquemas y separación lógica

Objetivo: crear vistas para reportes y usar schemas/namespaces.
Tareas: vistas materializadas vs no materializadas (según SGBD), migración de objetos a schemas.
Entregable: scripts de creación de vistas y esquema.
Duración: 3–4 h.
## Práctica 7 — Seguridad: roles, permisos y políticas

Objetivo: diseñar roles (admin, vet, taquilla, lector), asignar permisos mínimos.
Tareas: GRANT/REVOKE, esquemas y cuentas de servicio.
Entregable: plan de seguridad y scripts.
Duración: 3–4 h.
## Práctica 8 — Procedimientos, funciones y triggers

Objetivo: encapsular lógica (ingreso de animales, control stock, registro veterinario).
Tareas: crear stored procedures, funciones, triggers con manejo de errores y auditoría.
Entregable: biblioteca de SP/funciones/triggers y tests.
Duración: 6–8 h.

## Práctica 9 - Transacciones y concurrencia

Objetivo: 
Tareas: 
Entregable: 
Duración: 6–8 h.


## Práctica 10 — Tests, mantenimiento y backups

Objetivo: tests unitarios SQL, planes de backup/restore, mantenimiento de índices.
Tareas: scripts de backup, restore, rebuild/reorganize índices y comprobación de integridad.
Entregable: playbook de mantenimiento y scripts.
Duración: 4–6 h.

## Práctica 11 — Proyecto integrador

Objetivo: integrar todo en un mini-sistema: diagrama, DDL, datos, seguridad, SPs y documentación.
Entregable: repositorio con todo, README, script de despliegue y demostración.
Duración: 8–16 h (fase proyecto).
Niveles de dificultad

Básico: 1–3
Intermedio: 4–7
Avanzado/Integrador: 8–10

# Formatos y artefactos entregables

Diagrama ER (draw.io / PNG + XML)
Esquema relacional (Markdown)
Scripts: create_schema.sql, seed_data.sql, indices.sql, security.sql, procedures.sql
Tests SQL (scripts que validan constraints y reglas de negocio)
README de despliegue + guía de evaluación
Criterios de evaluación (resumen)

Correctitud del modelo ER y transformaciones (30%)
Calidad del DDL y constraints (20%)
Justificación de índices y pruebas de rendimiento (15%)
Seguridad y roles (10%)
Procedimientos y triggers (15%)
Documentación y reproducibilidad (10%)
Plantillas y apoyo didáctico

Template de práctica (usar patrón requerido en repo).
Checklist para revisión de pares.
Banco de pruebas SQL con casos de borde (N+1, FK faltantes, violaciones CHECK).
Sugerencias técnicas y herramientas

SGBD recomendado: MariaDB/PostgreSQL para prácticas; SQL Server para ejercicios avanzados (ya tienes scripts para SQL Server).
Control de versiones: Git (cada entrega como commit)
Migraciones: Flyway o scripts versionados (opcional)
Datos: generar con scripts Python/CSV o Mockaroo
Entorno: contenedores Docker para uniformidad (docker-compose con mariadb/postgres)
Adaptación del proyecto “Zaboo Mazoo” — ideas para enriquecerlo

Módulos: Animales, Especies, Habitats, Empleados, Veterinaria, Visitantes, Entradas, Eventos, Tienda (inventario/donaciones), Conservación
Reglas de negocio: límites por hábitat, historial médico, turnos del personal, reservas de eventos, reportes diarios de visitantes.
