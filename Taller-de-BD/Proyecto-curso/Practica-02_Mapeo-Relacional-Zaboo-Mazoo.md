# Práctica 2: Mapeo a modelo relacional y normalización — Zaboo Mazoo

## Objetivo
**Duración estimada:** 6-8 horas

Transformar el MER Chen de Zaboo Mazoo al modelo relacional aplicando el algoritmo de mapeo y normalizar hasta 3FN. (Esta práctica sustituye la plantilla genérica y aplica directamente al proyecto Zaboo Mazoo.)

## Competencias a desarrollar
- Aplicar el algoritmo MER→Relacional en un caso real.
- Identificar dependencias funcionales y normalizar hasta 3FN.
- Justificar decisiones de mapeo (1:1, 1:N, N:M y estrategias de generalización).

## Introducción
Utilizando el MER generado en la Práctica 1, mapea todas las entidades y relaciones a tablas relacionales. Documenta las claves, dependencias funcionales y la racional para cualquier desnormalización deliberada.

## Material y equipo necesario
- MER Chen de Práctica 1.
- Editor de texto / SQL para pruebas.

## Instrucciones
1. Parte A — Mapeo directo
   - Aplica los pasos estándar del algoritmo MER→Relacional y produce un esquema relacional inicial (tabla por entidad, tabla intermedia para N:M, tablas para atributos multivaluados, etc.).
2. Parte B — Verificación de dependencias
   - Lista las dependencias funcionales (por ejemplo: animal_id → especie_id, nombre_cientifico).
3. Parte C — Normalización
   - Demuestra la aplicación de 1FN, 2FN y 3FN con ejemplos concretos y muestra las tablas resultantes.
4. Parte D — Entregables
   - `esquema_relacional.md` (tabla por tabla con columnas, PK y FKs propuestas).
   - `justificacion.md` (máx. 1 página) con las decisiones clave.
   - Opcional: `create_tables.sql` con CREATE TABLE sin FKs obligatorias (pueden añadirse en Práctica 3).

## Criterios de evaluación
- Correctitud y completitud del mapeo (40%)
- Justificación de normalización y dependencias (30%)
- Calidad de la documentación entregada (30%)

## Entregable
- Carpeta `practica2_<apellidos>_<grupo>` con los archivos solicitados.
