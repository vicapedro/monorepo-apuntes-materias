# 2. Lenguaje de Manipulación de Datos (DML)

## 🎯 Competencia de la Unidad
**Aplicar las reglas del lenguaje de manipulación de datos en un SGBD para generar consultas simples y complejas que apoyen la toma de decisiones.**

## 📋 Objetivos de Aprendizaje
Al finalizar esta unidad, el estudiante será capaz de:
- ✅ Crear consultas SELECT con filtros, ordenamiento y agrupación
- ✅ Realizar operaciones de inserción, actualización y eliminación de datos
- ✅ Construir consultas con múltiples tablas usando JOINS
- ✅ Implementar subconsultas y consultas anidadas
- ✅ Aplicar funciones de agregación y ventana para análisis de datos

## 🔧 Contenido Temático

### 2.1 Consultas Básicas con SELECT
- **Estructura fundamental del SELECT**
  - Sintaxis básica: SELECT, FROM, WHERE
  - Alias para columnas y tablas
  - Ordenamiento con ORDER BY
  - Limitación de resultados: LIMIT/TOP

- **Filtros y condiciones**
  - Operadores de comparación (=, <>, <, >, <=, >=)
  - Operadores lógicos (AND, OR, NOT)
  - Operadores especiales: LIKE, IN, BETWEEN, IS NULL
  - Expresiones regulares (REGEXP/RLIKE)

- **Funciones de cadena y fecha**
  - Manipulación de texto: CONCAT, SUBSTRING, UPPER, LOWER
  - Funciones de fecha: NOW(), DATE_ADD, DATEDIFF
  - Funciones de conversión: CAST, CONVERT

### 2.2 Agrupación y Funciones de Agregación
- **GROUP BY y funciones agregadas**
  - COUNT, SUM, AVG, MIN, MAX
  - Agrupación por múltiples columnas
  - HAVING para filtros en grupos

- **Funciones de ventana (Window Functions)**
  - ROW_NUMBER(), RANK(), DENSE_RANK()
  - PARTITION BY para análisis sectorial
  - Funciones acumulativas: SUM() OVER, AVG() OVER

### 2.3 Consultas con Múltiples Tablas
- **Tipos de JOIN**
  - INNER JOIN: Registros coincidentes
  - LEFT/RIGHT JOIN: Inclusión de no coincidentes
  - FULL OUTER JOIN: Todos los registros
  - CROSS JOIN: Producto cartesiano

- **Subconsultas**
  - Subconsultas escalares
  - Subconsultas en WHERE (EXISTS, IN)
  - Subconsultas correlacionadas
  - Common Table Expressions (CTE)

### 2.4 Operaciones de Modificación de Datos
- **INSERT: Inserción de datos**
  - INSERT INTO con valores específicos
  - INSERT INTO... SELECT para carga masiva
  - ON DUPLICATE KEY UPDATE (MySQL)

- **UPDATE: Actualización de registros**
  - UPDATE con condiciones simples
  - UPDATE con JOINS
  - Actualizaciones masivas con subconsultas

- **DELETE: Eliminación de registros**
  - DELETE con condiciones
  - DELETE con JOINS
  - TRUNCATE vs DELETE

## 📝 Actividades y Prácticas

### 🔬 Laboratorio 3: Consultas SELECT Avanzadas
**Duración**: 4 horas  
**Modalidad**: Individual

**Objetivo**: Dominar consultas complejas con filtros, ordenamiento y funciones.

**Entregables**:
- 20 consultas SQL progresivas en complejidad
- Reporte de resultados con análisis
- Optimización de consultas lentas

### 🔬 Laboratorio 4: JOINS y Subconsultas
**Duración**: 4 horas  
**Modalidad**: Individual

**Objetivo**: Realizar consultas complejas uniendo múltiples tablas.

**Entregables**:
- Consultas con todos los tipos de JOIN
- Subconsultas correlacionadas y no correlacionadas
- Comparación de rendimiento JOIN vs subconsultas

### 🏢 Proyecto Integrador: Sistema de Análisis de Ventas
**Duración**: 12 horas  
**Modalidad**: Equipos de 3-4 personas

**Problema**: Desarrollar un sistema de consultas para análisis de ventas que incluya:
- Reportes de ventas por período, producto y vendedor
- Análisis de tendencias y patrones de compra
- Identificación de clientes VIP y productos estrella
- Dashboard con indicadores clave de desempeño (KPIs)

**Entregables**:
- Base de datos poblada con datos realistas (mínimo 10,000 registros)
- 30+ consultas SQL categorizadas por tipo de análisis
- Vistas para consultas frecuentes
- Documentación de procedimientos de análisis
- Presentación ejecutiva con insights obtenidos

## 📊 Evaluación

### Criterios de Evaluación
- **Correctitud SQL** (35%): Sintaxis correcta, resultados precisos
- **Complejidad** (25%): Uso de técnicas avanzadas (JOINS, subconsultas, funciones)
- **Optimización** (20%): Consultas eficientes, uso apropiado de índices
- **Análisis** (20%): Interpretación de resultados, insights de negocio

### Rúbrica de Evaluación
| Criterio | Excelente (3) | Bueno (2) | Aceptable (1) | Insuficiente (0) |
|----------|---------------|-----------|---------------|------------------|
| **Sintaxis SQL** | Sintaxis perfecta, sin errores | Sintaxis correcta con errores menores | Sintaxis básica con algunos errores | Errores graves de sintaxis |
| **Joins Complejos** | Domina todos los tipos de JOIN y subconsultas | Maneja la mayoría de JOINs correctamente | JOINs básicos funcionales | No maneja JOINs o incorrectos |
| **Funciones Agregadas** | Uso avanzado de GROUP BY, HAVING, funciones ventana | Uso correcto de funciones básicas | Funciones agregadas simples | No usa o usa incorrectamente |
| **Optimización** | Consultas optimizadas, explica planes de ejecución | Consultas eficientes | Consultas funcionales pero lentas | Consultas ineficientes o incorrectas |
| **Análisis de Datos** | Insights profundos, recomendaciones de negocio | Análisis correcto de resultados | Interpretación básica | Sin análisis o incorrecto |

## 🔗 Recursos Adicionales

### 📚 Lecturas Recomendadas
- Capítulo 4-6: "SQL Básico y Avanzado" - Elmasri & Navathe
- "SQL Cookbook" - Anthony Molinaro (Capítulos 1-8)
- Documentación oficial: MySQL Query Optimization

### 🎥 Videos de Apoyo
- "Mastering SQL JOINs" - Serie completa (60 min)
- "Window Functions Explained" (30 min)
- "Query Optimization Techniques" (45 min)

### 🛠️ Herramientas y Datasets
- SQLiteStudio: Para práctica offline
- DB Fiddle: Entorno online para práctica
- Dataset "Northwind": Base de datos de ejemplo
- Dataset "Sakila": Para consultas avanzadas

### 🎯 Ejercicios Adicionales
- HackerRank SQL: Challenges progresivos
- LeetCode Database: Problemas de entrevista
- SQLZoo: Tutorial interactivo

## 🎯 Conexión con Siguientes Unidades
- **Unidad 3 (Seguridad)**: Consultas considerando permisos de usuario
- **Unidad 4 (Concurrencia)**: Impacto de consultas en transacciones
- **Unidad 5 (Procedimientos)**: Incorporar consultas en procedimientos almacenados

---

## 📈 Indicadores de Desempeño

### Conocimientos
- Comprende la sintaxis completa del lenguaje SQL
- Conoce diferentes tipos de JOIN y su aplicación
- Entiende el funcionamiento de subconsultas y CTEs

### Habilidades
- Construye consultas SQL complejas y eficientes
- Analiza e interpreta resultados de consultas
- Optimiza consultas para mejorar rendimiento

### Actitudes
- Aplica pensamiento analítico para resolver problemas de negocio
- Busca soluciones eficientes y elegantes
- Documenta y explica claramente sus consultas

## 🧪 Evaluaciones GIFT

### Ejemplo de Reactivos
```gift
::DML-JOIN-01:: ¿Cuál es la diferencia principal entre INNER JOIN y LEFT JOIN? {
=LEFT JOIN incluye todos los registros de la tabla izquierda, aunque no tengan correspondencia en la derecha # Correcto, LEFT JOIN preserva todos los registros de la tabla izquierda
~INNER JOIN incluye todos los registros de ambas tablas # Incorrecto, INNER JOIN solo incluye registros con correspondencia
~LEFT JOIN es más rápido que INNER JOIN # Incorrecto, la velocidad depende de los datos e índices
~No hay diferencia, son sinónimos # Incorrecto, tienen comportamientos diferentes
}

::DML-GROUP-02:: En una consulta con GROUP BY, ¿dónde se deben colocar las condiciones que filtran grupos? {
=En la cláusula HAVING # Correcto, HAVING filtra grupos después de la agrupación
~En la cláusula WHERE # Incorrecto, WHERE filtra registros antes de agrupar
~En la cláusula ORDER BY # Incorrecto, ORDER BY solo ordena resultados
~No se pueden filtrar grupos # Incorrecto, HAVING permite filtrar grupos
}
```
