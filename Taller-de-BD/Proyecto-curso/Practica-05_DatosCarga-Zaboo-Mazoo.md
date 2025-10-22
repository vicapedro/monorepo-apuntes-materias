# Práctica 5: Datos de prueba y carga inicial — Zaboo Mazoo

## Objetivo
**Duración estimada:** 4-6 horas

Generar y cargar datasets realistas para poblar el esquema de Zaboo Mazoo y crear scripts de carga reproducibles.

## Competencias a desarrollar
- Diseñar datos de prueba que cubran casos comunes y bordes.
- Escribir scripts de carga eficientes (bulk insert / LOAD DATA / COPY según SGBD).
- Validar integridad y generar reportes de errores de carga.

## Material y equipo necesario
- `create_schema.sql` de la Práctica 3.
- Herramientas para generación de datos (Python, CSV, Mockaroo).

## Instrucciones
1. Generar datasets (CSV o INSERTs) para al menos las siguientes entidades: Especies, Animales (mín. 2k registros), Empleados, Visitantes (mín. 5k registros), Entradas, Tienda/Productos.
2. Implementar script de carga `seed_data.sql` o `load_data.sh` que:
   - Desactive constraints temporalmente si es necesario.
   - Inserte datos en orden respetando FKs.
   - Registre filas rechazadas en un log.
3. Validar la carga mediante consultas de conteo y checksums simples.

## Entregable
- Carpeta con datasets (`*.csv`) y `seed_data.sql` o `load_data.sh`.

## Evaluación
- Completitud de los datos (30%)
- Calidad del script de carga y manejo de errores (40%)
- Documentación y reproducibilidad (30%)
