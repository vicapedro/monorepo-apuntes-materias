# Segundo Avance del Proyecto - Consultas SQL

## Objetivo
Desarrollar consultas SQL de diferentes niveles de complejidad para resolver necesidades de información específicas del proyecto de base de datos.

## Descripción
En este avance, deberá implementar consultas SQL que resuelvan problemas reales de su proyecto. Las consultas están organizadas por niveles de dificultad para asegurar una progresión adecuada en el aprendizaje.

> **⚠️ IMPORTANTE - Datos de Prueba:**  
> Para que las consultas muestren resultados significativos y puedan ser evaluadas correctamente, **es indispensable que su base de datos contenga datos suficientes**. Asegúrese de:
> - Insertar **al menos 50-100 registros** en las tablas principales
> - Incluir **datos variados** que permitan obtener resultados diversos en agregaciones, agrupaciones y filtros
> - Mantener **relaciones consistentes** entre tablas (claves foráneas válidas)
> - Agregar datos para **diferentes períodos de tiempo** si trabaja con fechas
> - Incluir **casos especiales** (valores nulos, extremos, etc.) para probar la robustez de las consultas
>
> **Consultas sin datos = Sin resultados para evaluar**. Si sus consultas devuelven conjuntos vacíos o con 1-2 registros, será difícil validar su corrección.

---

## Requisitos de Entrega por Nivel de Dificultad

Deberá resolver un total de consultas distribuidas según los siguientes criterios:

### 📊 Distribución de Consultas Requeridas

| Nivel | Descripción | Cantidad Requerida |
|-------|-------------|-------------------|
| **🟢 Básico** | Consultas simples con SELECT, WHERE, ORDER BY | **TODAS las consultas básicas** |
| **🟡 Intermedio** | Consultas con JOINS, GROUP BY, subconsultas simples | **2/3 de las consultas intermedias** |
| **🟠 Avanzado** | Consultas complejas con múltiples JOINS, subconsultas anidadas, CTEs | **1/2 de las consultas avanzadas** |
| **🔴 Experto** | Consultas con CTEs recursivos, PIVOT, funciones de ventana | **5 consultas del nivel experto** |

### Ejemplo de Cálculo:
Si el banco de consultas tiene:
- 20 consultas básicas → Resolver **20** (todas)
- 30 consultas intermedias → Resolver **20** (2/3 de 30)
- 20 consultas avanzadas → Resolver **10** (1/2 de 20)
- 10 consultas experto → Resolver **5** (5 fijas)

**Total aproximado: 55 consultas**

---

## Estructura de Cada Consulta

Cada consulta entregada debe incluir:

### 1. **Identificador y Nivel**
```
-- Consulta B-05: Básico
-- Nivel: 🟢 Básico
```

### 2. **Planteamiento del Problema**
Descripción en **lenguaje de negocio** (evite términos técnicos de bases de datos):
```
-- Problema: ¿Cuántos productos tenemos disponibles en cada categoría?
```

### 3. **Consulta SQL**
Código SQL completo, probado y funcional:
```sql
SELECT 
    c.nombre_categoria,
    COUNT(p.producto_id) AS total_productos
FROM categorias c
LEFT JOIN productos p ON c.categoria_id = p.categoria_id
GROUP BY c.categoria_id, c.nombre_categoria
ORDER BY total_productos DESC;
```

### 4. **Comentarios Técnicos (Opcional pero Recomendado)**
```
-- Técnicas utilizadas: LEFT JOIN, COUNT, GROUP BY
-- Complejidad: Básico
-- Tiempo estimado de ejecución: < 100ms
```

---

## Conceptos SQL a Aplicar

Asegúrese de utilizar los siguientes conceptos a lo largo de sus consultas:

### 🟢 Nivel Básico
- ✅ SELECT con filtros WHERE
- ✅ ORDER BY (ordenamiento)
- ✅ DISTINCT (valores únicos)
- ✅ Funciones básicas (UPPER, LOWER, LEN)

### 🟡 Nivel Intermedio
- ✅ INNER JOIN, LEFT JOIN, RIGHT JOIN
- ✅ Subconsultas simples (en WHERE o SELECT)
- ✅ Funciones de agregación (SUM, COUNT, AVG, MIN, MAX)
- ✅ GROUP BY con HAVING
- ✅ Operadores de conjuntos (UNION, INTERSECT, EXCEPT)

### 🟠 Nivel Avanzado
- ✅ Múltiples JOINS (3+ tablas)
- ✅ Subconsultas correlacionadas
- ✅ CTE (Common Table Expressions)
- ✅ Variables en SQL (@variable)
- ✅ Funciones de cadena avanzadas (CONCAT, SUBSTRING, REPLACE)
- ✅ Funciones de fecha (DATEDIFF, DATEADD, FORMAT)
- ✅ CASE y COALESCE para lógica condicional

### 🔴 Nivel Experto
- ✅ CTE recursivos (jerarquías, series)
- ✅ Funciones de ventana (ROW_NUMBER, RANK, LEAD, LAG)
- ✅ PIVOT y UNPIVOT (transformación de datos)
- ✅ Consultas dinámicas
- ✅ Optimización de consultas complejas

---

## Formato de Entrega

### Opción 1: Archivo SQL (.sql)
```sql
/*
=====================================================
PROYECTO: [Nombre del Proyecto]
ESTUDIANTE: [Tu Nombre]
FECHA: [Fecha de Entrega]
DESCRIPCIÓN: Segundo Avance - Consultas SQL
=====================================================
*/

USE [nombre_base_datos];
GO

-- ========================================
-- CONSULTAS NIVEL BÁSICO (20/20)
-- ========================================

-- Consulta B-01: Listar todos los clientes
-- Problema: ¿Quiénes son todos nuestros clientes registrados?
SELECT cliente_id, nombre, email, telefono
FROM clientes
ORDER BY nombre;
GO

-- Consulta B-02: ...
-- [Continuar...]

-- ========================================
-- CONSULTAS NIVEL INTERMEDIO (20/30)
-- ========================================

-- Consulta I-01: Total de ventas por mes
-- Problema: ¿Cuánto hemos vendido cada mes del año actual?
SELECT 
    FORMAT(fecha_venta, 'yyyy-MM') AS mes,
    SUM(total) AS total_ventas
FROM ventas
WHERE YEAR(fecha_venta) = YEAR(GETDATE())
GROUP BY FORMAT(fecha_venta, 'yyyy-MM')
ORDER BY mes;
GO

-- [Continuar...]

-- ========================================
-- CONSULTAS NIVEL AVANZADO (10/20)
-- ========================================

-- Consulta A-01: Clientes con compras recurrentes
WITH clientes_frecuentes AS (
    SELECT 
        c.cliente_id,
        c.nombre,
        COUNT(v.venta_id) AS total_compras,
        SUM(v.total) AS total_gastado
    FROM clientes c
    INNER JOIN ventas v ON c.cliente_id = v.cliente_id
    WHERE v.fecha_venta >= DATEADD(MONTH, -6, GETDATE())
    GROUP BY c.cliente_id, c.nombre
    HAVING COUNT(v.venta_id) >= 3
)
SELECT * FROM clientes_frecuentes
ORDER BY total_gastado DESC;
GO

-- [Continuar...]

-- ========================================
-- CONSULTAS NIVEL EXPERTO (5/10)
-- ========================================

-- Consulta E-01: Jerarquía de categorías (CTE Recursivo)
-- Problema: ¿Cómo están organizadas nuestras categorías de productos en forma jerárquica?
WITH jerarquia_categorias AS (
    -- Nivel raíz (categorías sin padre)
    SELECT 
        categoria_id,
        nombre,
        categoria_padre_id,
        0 AS nivel,
        CAST(nombre AS NVARCHAR(500)) AS ruta
    FROM categorias
    WHERE categoria_padre_id IS NULL
    
    UNION ALL
    
    -- Niveles hijos (recursivo)
    SELECT 
        c.categoria_id,
        c.nombre,
        c.categoria_padre_id,
        h.nivel + 1,
        CAST(h.ruta + ' > ' + c.nombre AS NVARCHAR(500))
    FROM categorias c
    INNER JOIN jerarquia_categorias h ON c.categoria_padre_id = h.categoria_id
)
SELECT 
    REPLICATE('  ', nivel) + nombre AS categoria_jerarquia,
    nivel,
    ruta
FROM jerarquia_categorias
ORDER BY ruta;
GO

-- [Continuar...]
```

### Opción 2: Notebook Jupyter (.ipynb)
Si utiliza **Azure Data Studio** con notebooks interactivos:

```python
# Celda 1: Conexión a la base de datos
import pyodbc
conn = pyodbc.connect('Driver={SQL Server};Server=...;Database=...;')

# Celda 2: Consulta B-01
# Problema: ¿Quiénes son todos nuestros clientes?
query = """
SELECT cliente_id, nombre, email, telefono
FROM clientes
ORDER BY nombre;
"""
import pandas as pd
df = pd.read_sql(query, conn)
display(df)
```

---

## Criterios de Evaluación

### Evaluación por Nivel de Dificultad

| Criterio | Peso | Descripción |
|----------|------|-------------|
| **Consultas Básicas** | 20% | Completitud y corrección de todas las consultas básicas |
| **Consultas Intermedias** | 30% | Calidad y complejidad de 2/3 de las intermedias |
| **Consultas Avanzadas** | 30% | Dominio técnico en 1/2 de las avanzadas |
| **Consultas Experto** | 20% | Creatividad y optimización en 5 consultas expertas |

### Criterios de Calidad

| Aspecto | Puntos |
|---------|--------|
| **Funcionalidad** | 40% |
| - Consultas ejecutables sin errores | 20% |
| - Resultados correctos y coherentes | 20% |
| **Complejidad Técnica** | 30% |
| - Uso apropiado de técnicas SQL | 15% |
| - Optimización y eficiencia | 15% |
| **Documentación** | 20% |
| - Planteamiento claro del problema | 10% |
| - Comentarios técnicos útiles | 10% |
| **Relevancia** | 10% |
| - Consultas útiles para el proyecto | 10% |

---

## Recomendaciones

### ✅ Buenas Prácticas
- **Pruebe cada consulta** antes de entregarla
- **Use nombres descriptivos** en alias y CTEs
- **Comente su código** especialmente en consultas complejas
- **Optimice las consultas** que tarden más de 1 segundo
- **Mantenga consistencia** en el estilo de código

### ⚠️ Errores Comunes a Evitar
- ❌ Consultas que devuelven datasets muy grandes sin filtros
- ❌ Falta de índices en columnas frecuentemente consultadas
- ❌ Subconsultas que se pueden reemplazar con JOINs más eficientes
- ❌ No validar resultados con datos de prueba
- ❌ Consultas triviales que no agregan valor al proyecto

### 💡 Consejos de Organización
1. **Agrupe consultas** por módulo funcional del proyecto
2. **Numere secuencialmente** para fácil referencia
3. **Incluya comentarios** sobre el propósito de negocio
4. **Documente dependencias** entre consultas relacionadas
5. **Versione su archivo** SQL por fecha

### 🗄️ Generación de Datos de Prueba

Para poblar su base de datos con datos suficientes, puede utilizar las siguientes estrategias:

#### **Opción 1: Scripts SQL con INSERT**
```sql
-- Ejemplo: Insertar múltiples clientes
INSERT INTO clientes (nombre, email, telefono, ciudad) VALUES
('Juan Pérez', 'juan.perez@email.com', '555-0101', 'Monterrey'),
('María García', 'maria.garcia@email.com', '555-0102', 'Guadalajara'),
('Carlos López', 'carlos.lopez@email.com', '555-0103', 'CDMX'),
-- ... continuar con al menos 50 registros
;
```

#### **Opción 2: Generadores de Datos**
- **[Mockaroo](https://www.mockaroo.com/)**: Genera datos en formato SQL/CSV
- **[Generatedata.com](https://generatedata.com/)**: Configuración personalizada de datasets
- **ChatGPT/Copilot**: Solicite generación de INSERT statements

#### **Opción 3: Procedimientos de Generación Automática**
```sql
-- Ejemplo: Generar 100 productos aleatorios
DECLARE @i INT = 1;
WHILE @i <= 100
BEGIN
    INSERT INTO productos (nombre, precio, categoria_id)
    VALUES (
        'Producto ' + CAST(@i AS VARCHAR),
        ROUND(RAND() * 1000, 2),
        (ABS(CHECKSUM(NEWID())) % 10) + 1
    );
    SET @i = @i + 1;
END;
```

#### **Verificación de Datos**
Antes de entregar, ejecute estas consultas para validar:
```sql
-- Contar registros por tabla
SELECT 'Clientes' AS tabla, COUNT(*) AS total FROM clientes
UNION ALL
SELECT 'Productos', COUNT(*) FROM productos
UNION ALL
SELECT 'Ventas', COUNT(*) FROM ventas;

-- Verificar integridad referencial
SELECT 
    COUNT(*) AS ventas_sin_cliente
FROM ventas v
WHERE NOT EXISTS (SELECT 1 FROM clientes c WHERE c.cliente_id = v.cliente_id);
```

---

## Fecha de Entrega

**Fecha límite:** [Especificar fecha según calendario académico]

**Plataforma de entrega:** [Moodle/Teams/Classroom]

**Formato de archivo:** 
- `Apellido_Nombre_2doAvance.sql`
- `Apellido_Nombre_2doAvance.ipynb`

---

## Recursos de Apoyo

### Documentación Oficial
- [Documentación T-SQL de Microsoft](https://docs.microsoft.com/sql/t-sql/)
- [CTEs en SQL Server](https://docs.microsoft.com/sql/t-sql/queries/with-common-table-expression-transact-sql)
- [Funciones de Ventana](https://docs.microsoft.com/sql/t-sql/queries/select-over-clause-transact-sql)

### Ejemplos de Consultas
- Revise los ejercicios resueltos en clase
- Consulte el banco de preguntas del curso
- Practique con la base de datos Northwind

---

*Este avance representa el 25-30% de la calificación total del proyecto. Asegúrese de cumplir con todos los requisitos especificados.*