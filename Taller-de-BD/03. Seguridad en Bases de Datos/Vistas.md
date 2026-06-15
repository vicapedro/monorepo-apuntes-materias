# Vistas en SQL Server

**Taller de Base de Datos - Seguridad en Bases de Datos**

---

## Índice

1. [¿Qué es una Vista?](#1-qué-es-una-vista)
2. [Ventajas de las Vistas](#2-ventajas-de-las-vistas)
3. [Tipos de Vistas](#3-tipos-de-vistas)
4. [Creación de Vistas](#4-creación-de-vistas)
5. [Modificación de Datos a través de Vistas](#5-modificación-de-datos-a-través-de-vistas)
6. [Opciones de las Vistas](#6-opciones-de-las-vistas)
7. [Vistas Indexadas (Materializadas)](#7-vistas-indexadas-materializadas)
8. [Vistas Particionadas](#8-vistas-particionadas)
9. [Fuentes de Información sobre Vistas](#9-fuentes-de-información-sobre-vistas)
10. [Consideraciones de Desempeño](#10-consideraciones-de-desempeño)
11. [Vistas Modernas: Temporal Tables y Azure SQL](#11-vistas-modernas-temporal-tables-y-azure-sql)

---

## 1. ¿Qué es una Vista?

### Definición

Una **vista** es una tabla virtual que:

- Es una **instrucción SELECT con nombre** que produce dinámicamente un conjunto de resultados
- **No almacena datos físicamente** (excepto las vistas indexadas)
- Sirve como **filtro de las tablas base** que guardan los datos reales
- Permite operar sobre el conjunto de resultados como si fuera una tabla

**Versiones soportadas:** SQL Server 2016+, SQL Server 2019, SQL Server 2022, Azure SQL Database

### Representación Conceptual

```
┌─────────────────────────────────────────────────────┐
│  TABLA BASE: title                                  │
├──────────┬─────────────────────┬──────────┬─────────┤
│ title_no │ title               │ author   │synopsis │
├──────────┼─────────────────────┼──────────┼─────────┤
│    1     │ Last of the Mohicans│ J.F.Cooper│ ~~~   │
│    2     │ The Village Watch   │ K.D.Wiggin│ ~~~   │
│    3     │ Poems               │ W. Owen   │ ~~~   │
└──────────┴─────────────────────┴──────────┴─────────┘
                        │
                        │ Filtro (SELECT)
                        ▼
┌───────────────────────────────────────────┐
│  VISTA: TitleView (Vista del usuario)    │
├─────────────────────┬─────────────────────┤
│ title               │ author              │
├─────────────────────┼─────────────────────┤
│ Last of the Mohicans│ James F. Cooper     │
│ The Village Watch   │ Kate Douglas Wiggin │
│ Poems               │ Wilfred Owen        │
└─────────────────────┴─────────────────────┘
```

### Ejemplo de Creación

```sql
USE library;
GO

CREATE VIEW dbo.TitleView
AS 
SELECT title, author
FROM title;
GO
```

---

## 2. Ventajas de las Vistas

### Beneficios Principales

#### 1. **Enfoque en Datos Específicos**
Permite a los usuarios concentrarse en datos específicos utilizados para tareas particulares. Los datos innecesarios no se incluyen en la vista.

#### 2. **Simplificación del Trabajo**
Pueden definirse consultas complejas y frecuentes (UNION, JOINs) como vistas, de tal forma que el usuario no tiene que especificar todas las condiciones cada vez.

#### 3. **Mejora de Seguridad**
Permite al usuario acceder a los datos a través de la vista, sin tener que otorgar permisos directos sobre las tablas base.

**🔒 Integración moderna con Row-Level Security (RLS):**

```sql
-- Tabla con RLS (SQL Server 2016+)
CREATE TABLE Ventas (
    VentaID INT PRIMARY KEY,
    Vendedor NVARCHAR(100),
    Monto DECIMAL(10,2),
    Fecha DATE
);
GO

-- Función de predicado de seguridad
CREATE FUNCTION dbo.fn_SeguridadVentas(@Vendedor NVARCHAR(100))
RETURNS TABLE
WITH SCHEMABINDING
AS
RETURN SELECT 1 AS result
WHERE @Vendedor = USER_NAME() OR IS_MEMBER('Gerentes') = 1;
GO

-- Política de seguridad
CREATE SECURITY POLICY VentasPolicy
ADD FILTER PREDICATE dbo.fn_SeguridadVentas(Vendedor) ON dbo.Ventas
WITH (STATE = ON);
GO

-- Vista que respeta automáticamente RLS
CREATE VIEW VentasActuales
AS
SELECT VentaID, Vendedor, Monto, Fecha
FROM Ventas
WHERE Fecha >= DATEADD(MONTH, -3, GETDATE());
GO
```

#### 4. **Ocultamiento de Complejidad**
Oculta la complejidad de la estructura de la base de datos al usuario final.

#### 5. **Gestión Simplificada de Permisos**
Simplifica el manejo de los permisos al nivel de vista en lugar de múltiples tablas.

**🆕 Integración con Azure Active Directory (Azure SQL):**

```sql
-- Crear usuario de Azure AD
CREATE USER [usuario@empresa.com] FROM EXTERNAL PROVIDER;
GO

-- Otorgar permisos solo a la vista
GRANT SELECT ON dbo.EmpleadosPublico TO [usuario@empresa.com];
GO
```

### Ejemplos Típicos de Vistas

1. **Subconjunto de renglones o columnas** de una tabla base
2. **La unión (UNION)** de dos o más tablas base
3. **Un JOIN** de dos o más tablas base
4. **Sumatoria o agregación** de los datos de una tabla base
5. **🆕 Vistas sobre JSON/XML** para normalización de datos semi-estructurados

---

## 3. Tipos de Vistas

### 1. Vistas Estándar
Combinan datos de una o más tablas mediante consultas SELECT normales.

```sql
CREATE VIEW ProductosActivos
AS
SELECT ProductoID, Nombre, Precio
FROM Productos
WHERE Activo = 1;
```

### 2. Vistas Indexadas (Materializadas)
Materializan la vista mediante la construcción de un **índice clustered**. Almacenan físicamente los datos.

```sql
CREATE VIEW ProductTotals
WITH SCHEMABINDING
AS
SELECT ProductID, 
       SUM(Quantity) AS TotalQty,
       COUNT_BIG(*) AS NumOrders
FROM dbo.OrderDetails
GROUP BY ProductID;
GO

CREATE UNIQUE CLUSTERED INDEX idx_ProductTotals 
ON ProductTotals(ProductID);
```

**🆕 Mejoras en SQL Server 2019+:**
- Soporte mejorado para Intelligent Query Processing
- Automatic plan correction para vistas indexadas
- Adaptive joins en consultas sobre vistas indexadas

### 3. Vistas Particionadas (Distribuidas)
La información proviene de una o más tablas en uno o más servidores. Útil para dividir datos horizontalmente.

```sql
CREATE VIEW VentasGlobales
AS
SELECT * FROM VentasNorte
UNION ALL
SELECT * FROM VentasSur
UNION ALL
SELECT * FROM VentasEste;
```

**🆕 Alternativa moderna: Partitioned Tables (SQL Server 2016+)**

```sql
-- Función de partición (mejor que vistas particionadas)
CREATE PARTITION FUNCTION pf_Regiones (VARCHAR(10))
AS RANGE LEFT FOR VALUES ('Este', 'Norte', 'Sur');
GO

CREATE PARTITION SCHEME ps_Regiones
AS PARTITION pf_Regiones
ALL TO ([PRIMARY]);
GO

CREATE TABLE Ventas (
    OrderID INT PRIMARY KEY NONCLUSTERED,
    Fecha DATE,
    Total DECIMAL(10,2),
    Region VARCHAR(10)
) ON ps_Regiones(Region);
GO

-- Crear índice clustered en la columna de partición
CREATE CLUSTERED INDEX idx_Ventas_Region 
ON Ventas(Region);
GO
```

### 4. 🆕 Vistas sobre Datos Semi-Estructurados (JSON/XML)

**SQL Server 2016+ soporta vistas sobre columnas JSON:**

```sql
-- Tabla con columna JSON
CREATE TABLE Productos (
    ProductoID INT PRIMARY KEY,
    Nombre NVARCHAR(100),
    Atributos NVARCHAR(MAX) -- JSON: {"color": "rojo", "peso": 5.2}
);
GO

-- Vista que normaliza JSON
CREATE VIEW ProductosNormalizados
AS
SELECT 
    ProductoID,
    Nombre,
    JSON_VALUE(Atributos, '$.color') AS Color,
    CAST(JSON_VALUE(Atributos, '$.peso') AS DECIMAL(10,2)) AS Peso,
    JSON_QUERY(Atributos, '$.dimensiones') AS Dimensiones
FROM Productos
WHERE ISJSON(Atributos) = 1;
GO

-- Consultar como tabla normalizada
SELECT * FROM ProductosNormalizados WHERE Color = 'rojo';
```

**Vistas sobre XML (SQL Server 2005+, aún relevante):**

```sql
CREATE VIEW ProductosXML
AS
SELECT 
    ProductoID,
    Atributos.value('(/producto/color)[1]', 'NVARCHAR(50)') AS Color,
    Atributos.value('(/producto/peso)[1]', 'DECIMAL(10,2)') AS Peso
FROM ProductosConXML;
GO
```

---

## 4. Creación de Vistas

### Sintaxis Completa (SQL Server 2022)

```sql
CREATE [ OR ALTER ] VIEW 
    [database_name.][schema_name.]view_name [(column [,...n])] 
    [WITH <view_attribute> [,...n]] 
AS 
    select_statement 
    [WITH CHECK OPTION]

<view_attribute> ::= 
    {
        ENCRYPTION 
        | SCHEMABINDING 
        | VIEW_METADATA
        | DISTRIBUTION = { HASH (distribution_column_name) | ROUND_ROBIN }  -- Azure Synapse Analytics
    }
GO
```

**🆕 Novedad SQL Server 2016+: CREATE OR ALTER**

```sql
-- Crea la vista si no existe, o la modifica si ya existe
CREATE OR ALTER VIEW ProductosActivos
AS
SELECT ProductoID, Nombre, Precio, Stock
FROM Productos
WHERE Activo = 1;
GO

-- Beneficio: No hay que hacer DROP IF EXISTS primero
```

### Parámetros

- **view_name**: Nombre de la vista
- **column**: Nombres opcionales de columnas (se usan si las columnas de la SELECT son expresiones)
- **ENCRYPTION**: Cifra la definición de la vista
- **SCHEMABINDING**: Vincula la vista al esquema de las tablas base
- **VIEW_METADATA**: Retorna metadatos de la vista en lugar de las tablas base
- **WITH CHECK OPTION**: Valida que las modificaciones cumplan con el WHERE de la vista
- **🆕 DISTRIBUTION**: Solo para Azure Synapse Analytics (distribución de datos)

### Ejemplo 1: Vista Simple

```sql
USE pubs;
GO

-- SQL Server 2016+: Sintaxis moderna
DROP VIEW IF EXISTS titles_view;
GO

CREATE VIEW titles_view 
AS 
SELECT title, type, price, pubdate 
FROM titles;
GO

-- Usar la vista
SELECT * FROM titles_view
WHERE type = 'business';
```

### Ejemplo 2: Vista con JOIN

```sql
USE library;
GO

CREATE OR ALTER VIEW dbo.BirthdayView (Lastname, Firstname, [Birth Date])
AS
SELECT m.lastname, 
       m.firstname,
       FORMAT(j.birth_date, 'dd/MM/yyyy') AS birth_date  -- FORMAT (SQL 2012+)
FROM member m 
JOIN juvenile j ON m.member_no = j.member_no;
GO

-- Consultar la vista
SELECT * FROM BirthdayView
WHERE Lastname = 'Thomas';
```

**Explicación:**
- La vista combina datos de las tablas `member` y `juvenile`
- Renombra columnas para mayor claridad
- **🆕 Usa FORMAT()** en lugar de CONVERT (más legible, SQL Server 2012+)
- El usuario no necesita conocer la estructura de las tablas subyacentes

### Ejemplo 3: Vista con Agregación y Funciones Modernas

```sql
-- SQL Server 2012+: Funciones de ventana en vistas
CREATE VIEW VentasPorCategoriaDetallado
AS
SELECT 
    c.Categoria, 
    COUNT(p.ProductoID) AS TotalProductos,
    SUM(p.Stock) AS StockTotal,
    AVG(p.Precio) AS PrecioPromedio,
    -- 🆕 Funciones de ventana (SQL 2012+)
    PERCENT_RANK() OVER (ORDER BY SUM(p.Stock)) AS PercentilStock,
    LAG(SUM(p.Stock)) OVER (ORDER BY c.Categoria) AS StockCategoriaAnterior
FROM Categorias c
LEFT JOIN Productos p ON c.CategoriaID = p.CategoriaID
GROUP BY c.Categoria;
GO

-- Consultar
SELECT * FROM VentasPorCategoriaDetallado
WHERE PercentilStock > 0.5;  -- Top 50%
```

### 🆕 Ejemplo 4: Vistas con STRING_AGG (SQL Server 2017+)

```sql
-- Agrupar múltiples valores en una cadena
CREATE VIEW ProductosPorCategoria
AS
SELECT 
    c.Categoria,
    STRING_AGG(p.Nombre, ', ') WITHIN GROUP (ORDER BY p.Nombre) AS Productos,
    COUNT(p.ProductoID) AS TotalProductos
FROM Categorias c
LEFT JOIN Productos p ON c.CategoriaID = p.CategoriaID
GROUP BY c.Categoria;
GO

-- Resultado:
-- Categoria     | Productos                    | TotalProductos
-- Electrónica   | Laptop, Mouse, Teclado       | 3
-- Ropa          | Camisa, Pantalón, Zapatos    | 3
```

### 🆕 Ejemplo 5: Vistas con OPENJSON (SQL Server 2016+)

```sql
-- Vista que normaliza datos JSON almacenados
CREATE VIEW PedidosNormalizados
AS
SELECT 
    p.PedidoID,
    p.Fecha,
    item.ProductoID,
    item.Cantidad,
    item.Precio
FROM Pedidos p
CROSS APPLY OPENJSON(p.Items)
WITH (
    ProductoID INT '$.producto_id',
    Cantidad INT '$.cantidad',
    Precio DECIMAL(10,2) '$.precio'
) AS item;
GO
```

---

## 5. Modificación de Datos a través de Vistas

### Principios Fundamentales

- Las vistas **no mantienen una copia separada de los datos** (excepto vistas indexadas)
- Los cambios realizados sobre las vistas **modifican directamente la tabla base**
- Existen restricciones importantes para garantizar la integridad

### Restricciones para Modificación

#### 1. Restricción de Tabla Única
**No puede afectar más de una tabla base en una sola operación.**

```sql
-- ❌ INCORRECTO: No se puede actualizar en vista con JOIN
CREATE VIEW EmpleadoDepartamento
AS
SELECT e.EmpleadoID, e.Nombre, d.Departamento
FROM Empleados e
JOIN Departamentos d ON e.DepartamentoID = d.DepartamentoID;
GO

-- Esto causará error:
UPDATE EmpleadoDepartamento
SET Nombre = 'Juan', Departamento = 'Ventas'
WHERE EmpleadoID = 1;

-- ✓ CORRECTO: Actualizar solo una tabla
UPDATE EmpleadoDepartamento
SET Nombre = 'Juan'
WHERE EmpleadoID = 1;
```

**🆕 Alternativa moderna: INSTEAD OF Triggers (SQL Server 2000+)**

```sql
-- Permitir UPDATE en vistas multi-tabla con trigger
CREATE TRIGGER trg_UpdateEmpleadoDepartamento
ON EmpleadoDepartamento
INSTEAD OF UPDATE
AS
BEGIN
    -- Actualizar Empleados
    UPDATE e
    SET e.Nombre = i.Nombre
    FROM Empleados e
    INNER JOIN inserted i ON e.EmpleadoID = i.EmpleadoID;
    
    -- Actualizar Departamentos
    UPDATE d
    SET d.Departamento = i.Departamento
    FROM Departamentos d
    INNER JOIN Empleados e ON d.DepartamentoID = e.DepartamentoID
    INNER JOIN inserted i ON e.EmpleadoID = i.EmpleadoID;
END;
GO

-- Ahora funciona el UPDATE multi-tabla
UPDATE EmpleadoDepartamento
SET Nombre = 'Juan', Departamento = 'Ventas'
WHERE EmpleadoID = 1;
```

#### 2. Restricción de Columnas Calculadas
**No puede modificarse columnas derivadas de cálculos.**

```sql
CREATE VIEW ProductosConIVA
AS
SELECT ProductoID, 
       Nombre, 
       Precio,
       Precio * 1.16 AS PrecioConIVA
FROM Productos;
GO

-- ❌ Error: No se puede actualizar columna calculada
UPDATE ProductosConIVA
SET PrecioConIVA = 150
WHERE ProductoID = 1;

-- ✓ Correcto: Actualizar columna base
UPDATE ProductosConIVA
SET Precio = 129.31  -- Equivale a 150 con IVA
WHERE ProductoID = 1;
```

#### 3. Restricción de Agregaciones
**No puede modificar columnas afectadas por GROUP BY, HAVING o DISTINCT.**

```sql
CREATE VIEW VentasPorCliente
AS
SELECT ClienteID, COUNT(*) AS NumVentas, SUM(Total) AS TotalVentas
FROM Ventas
GROUP BY ClienteID;
GO

-- ❌ Error: No se puede modificar vista con GROUP BY
UPDATE VentasPorCliente
SET TotalVentas = 5000
WHERE ClienteID = 1;
```

### Restricciones para INSERT

**No se permiten INSERT a menos que:**
- La vista incluya **todas las columnas NOT NULL** de la tabla base
- No contenga columnas calculadas
- No use GROUP BY, DISTINCT, TOP, UNION

```sql
-- Tabla base
CREATE TABLE Empleados (
    EmpleadoID INT PRIMARY KEY,
    Nombre NVARCHAR(100) NOT NULL,
    Departamento NVARCHAR(50) NOT NULL,
    Salario DECIMAL(10,2) NULL
);

-- Vista que excluye columna NOT NULL
CREATE VIEW EmpleadosSalarios
AS
SELECT EmpleadoID, Salario
FROM Empleados;
GO

-- ❌ Error: Falta columna NOT NULL (Nombre)
INSERT INTO EmpleadosSalarios 
VALUES (1, 50000);

-- ✓ Correcto: Incluir todas las columnas NOT NULL
CREATE VIEW EmpleadosCompleto
AS
SELECT EmpleadoID, Nombre, Departamento, Salario
FROM Empleados;
GO

INSERT INTO EmpleadosCompleto
VALUES (1, 'Juan Pérez', 'Ventas', 50000);
```

**🆕 SQL Server 2008+: Columnas con DEFAULT pueden omitirse**

```sql
ALTER TABLE Empleados 
ADD FechaCreacion DATETIME2 NOT NULL DEFAULT GETDATE();
GO

-- Ahora se permite INSERT sin incluir FechaCreacion
INSERT INTO EmpleadosCompleto (EmpleadoID, Nombre, Departamento)
VALUES (2, 'María López', 'Finanzas');
-- FechaCreacion se llena automáticamente con el DEFAULT
```

### Restricciones para DELETE

**No se permiten DELETE en vistas formadas por varias tablas.** Solo se permite en vistas de tabla única.

```sql
-- ❌ Error: No se puede eliminar de vista con JOIN
DELETE FROM EmpleadoDepartamento
WHERE EmpleadoID = 1;
```

**🆕 Solución con INSTEAD OF Trigger:**

```sql
CREATE TRIGGER trg_DeleteEmpleadoDepartamento
ON EmpleadoDepartamento
INSTEAD OF DELETE
AS
BEGIN
    DELETE FROM Empleados
    WHERE EmpleadoID IN (SELECT EmpleadoID FROM deleted);
END;
GO

-- Ahora funciona
DELETE FROM EmpleadoDepartamento WHERE EmpleadoID = 1;
```

### Restricciones para UPDATE

Solo se permiten UPDATE en vistas que sean **actualizables**:
- No contienen GROUP BY, HAVING, DISTINCT, TOP, UNION
- Todas las columnas modificadas cumplen con las restricciones de la tabla base
- No se intenta modificar más de una tabla base simultáneamente

---

## 6. Opciones de las Vistas

### 1. ENCRYPTION

Cifra la definición SQL de la vista en el catálogo del sistema.

#### Ventajas
- **Protege la lógica de negocio** contenida en la vista
- Impide que usuarios no autorizados vean la definición
- Se aplica también a procedimientos, triggers y funciones

#### Sintaxis

```sql
CREATE VIEW dbo.UnpaidFinesView (Member, TotalUnpaidFines)
WITH ENCRYPTION
AS
SELECT member_no, 
       SUM(fine_assessed - fine_paid) AS TotalUnpaid
FROM loanhist
GROUP BY member_no
HAVING SUM(fine_assessed - fine_paid) > 0;
GO
```

#### Verificación

```sql
-- Intentar ver la definición
EXEC sp_helptext 'UnpaidFinesView';
-- Resultado: "The text for object 'UnpaidFinesView' is encrypted."

-- La vista funciona normalmente
SELECT * FROM UnpaidFinesView;
```

**⚠️ ADVERTENCIA:** Una vez cifrada, **no se puede descifrar**. Mantener siempre un respaldo del código fuente.

**🆕 SQL Server 2016+: Alternativa con Dynamic Data Masking**

```sql
-- Alternativa moderna: Ofuscar datos en lugar de cifrar definición
CREATE TABLE Empleados (
    EmpleadoID INT PRIMARY KEY,
    Nombre NVARCHAR(100),
    Email NVARCHAR(100) MASKED WITH (FUNCTION = 'email()'),
    Salario DECIMAL(10,2) MASKED WITH (FUNCTION = 'default()')
);
GO

-- Vista simple (sin necesidad de excluir columnas)
CREATE VIEW EmpleadosTodos
AS
SELECT EmpleadoID, Nombre, Email, Salario
FROM Empleados;
GO

-- Usuarios sin UNMASK ven datos enmascarados
-- Sin necesidad de cifrar la vista
CREATE VIEW EmpleadosPublico
AS
SELECT EmpleadoID, Nombre, Email, Salario
FROM Empleados;
GO

-- Usuario regular ve:
-- EmpleadoID | Nombre      | Email          | Salario
-- 1          | Juan Pérez  | Jxxx@xxxx.com  | 0.00

-- Usuario con UNMASK ve valores reales
GRANT UNMASK TO [Gerente];
```

---

### 2. SCHEMABINDING

Vincula la vista al esquema de las tablas subyacentes.

#### Características
- **Protege la estructura** de las tablas base
- Impide cambios en el esquema que afectarían la vista
- **Obligatorio** para crear vistas indexadas
- Las referencias a objetos deben incluir el esquema (dbo.tabla)
- No se puede usar `SELECT *`

#### Sintaxis

```sql
CREATE VIEW dbo.ProductDetails
WITH SCHEMABINDING
AS
SELECT p.ProductID, 
       p.ProductName, 
       p.UnitPrice,
       c.CategoryName
FROM dbo.Products p
JOIN dbo.Categories c ON p.CategoryID = c.CategoryID;
GO
```

#### Protección que Ofrece

```sql
-- ❌ Error: No se puede eliminar tabla referenciada por vista con SCHEMABINDING
DROP TABLE dbo.Products;
-- Msg 3729: Cannot DROP TABLE 'Products' because it is being referenced by object 'ProductDetails'

-- ❌ Error: No se puede eliminar columna usada en la vista
ALTER TABLE dbo.Products
DROP COLUMN ProductName;
-- Msg 5074: The object 'ProductDetails' is dependent on column 'ProductName'
```

#### Ventajas
- Garantiza que la vista siempre sea consistente
- Necesario para vistas indexadas (materializadas)
- Mejora el rendimiento del optimizador de consultas

**🆕 SQL Server 2016+: sys.dm_sql_referenced_entities**

```sql
-- Ver dependencias de la vista con SCHEMABINDING
SELECT 
    referencing_schema_name,
    referencing_entity_name,
    referenced_schema_name,
    referenced_entity_name,
    is_caller_dependent
FROM sys.dm_sql_referenced_entities('dbo.ProductDetails', 'OBJECT');
```

---

### 3. WITH CHECK OPTION

Previene que se realicen inserciones o actualizaciones que violen la cláusula WHERE de la vista.

#### Sin CHECK OPTION

```sql
CREATE VIEW TitleView
AS 
SELECT title, year
FROM titles
WHERE year < 2000;
GO

-- Se permite insertar filas que NO aparecerán en la vista
INSERT INTO TitleView VALUES ('BD Avanzada', 2003);
-- ✓ Éxito: La fila se inserta en la tabla base

SELECT * FROM TitleView;
-- La fila insertada NO aparece (year >= 2000)

SELECT * FROM titles WHERE title = 'BD Avanzada';
-- title          year
-- BD Avanzada    2003  ← Existe en la tabla pero no en la vista
```

**Problema:** Se pueden insertar datos "fantasma" que existen en la tabla base pero no son visibles en la vista.

#### Con CHECK OPTION

```sql
CREATE VIEW TitleView
AS 
SELECT title, year
FROM titles
WHERE year < 2000
WITH CHECK OPTION;
GO

-- Intento de insertar fila que viola el WHERE
INSERT INTO TitleView VALUES ('BD Avanzada', 2003);
-- ❌ Error: The attempted insert or update failed because the target view 
--           either specifies WITH CHECK OPTION or spans a view that specifies 
--           WITH CHECK OPTION and one or more rows resulting from the operation 
--           did not qualify under the CHECK OPTION constraint.

-- ✓ Correcto: Insertar fila que cumple la condición
INSERT INTO TitleView VALUES ('Redes Clásicas', 1998);
-- Éxito: La fila cumple con year < 2000
```

#### Diagrama Comparativo

```
┌─────────────────────────────────────────────────┐
│  SIN CHECK OPTION                               │
├─────────────────────────────────────────────────┤
│  Vista: WHERE año < 2000                        │
│  ┌──────────────┬──────┐                        │
│  │ Title        │ Año  │                        │
│  ├──────────────┼──────┤                        │
│  │ Mohicans     │ 1997 │  ✓ Visible            │
│  │ Poems        │ 1998 │  ✓ Visible            │
│  └──────────────┴──────┘                        │
│                                                 │
│  INSERT ('BD', 2003) → ✓ PERMITIDO             │
│                                                 │
│  Tabla Base:                                    │
│  ┌──────────────┬──────┐                        │
│  │ Mohicans     │ 1997 │                        │
│  │ Poems        │ 1998 │                        │
│  │ BD           │ 2003 │  ✗ NO visible en vista│
│  └──────────────┴──────┘                        │
└─────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────┐
│  CON CHECK OPTION                               │
├─────────────────────────────────────────────────┤
│  Vista: WHERE año < 2000                        │
│  ┌──────────────┬──────┐                        │
│  │ Title        │ Año  │                        │
│  ├──────────────┼──────┤                        │
│  │ Mohicans     │ 1997 │  ✓ Visible            │
│  │ Poems        │ 1998 │  ✓ Visible            │
│  └──────────────┴──────┘                        │
│                                                 │
│  INSERT ('BD', 2003) → ❌ ERROR                 │
│  (Viola la condición año < 2000)               │
└─────────────────────────────────────────────────┘
```

#### Cuándo Usar CHECK OPTION

✅ **Usar cuando:**
- La vista representa un subconjunto lógico (ej: solo clientes activos)
- Se quiere garantizar integridad semántica
- Los usuarios modifican datos a través de la vista

❌ **No usar cuando:**
- La vista es solo de consulta (read-only)
- Se requiere flexibilidad para insertar datos fuera del filtro

---

### Ejemplo Combinando Opciones

```sql
CREATE VIEW EmpleadosActivos
WITH ENCRYPTION, SCHEMABINDING
AS
SELECT e.EmpleadoID, 
       e.Nombre, 
       e.Email,
       d.Departamento
FROM dbo.Empleados e
JOIN dbo.Departamentos d ON e.DepartamentoID = d.DepartamentoID
WHERE e.Activo = 1
WITH CHECK OPTION;
GO
```

Esta vista:
- **ENCRYPTION**: Oculta la definición SQL
- **SCHEMABINDING**: Protege las tablas de cambios de esquema
- **CHECK OPTION**: Solo permite modificar empleados activos

---

## 7. Vistas Indexadas (Materializadas)

### ¿Qué es una Vista Indexada?

Una vista indexada (también llamada **vista materializada**) es una vista que:
- Tiene un **índice único clustered** creado sobre ella
- **Almacena físicamente** los datos de la vista en disco
- Se **actualiza automáticamente** cuando cambian las tablas base
- Mejora significativamente el **rendimiento de consultas**

**🆕 SQL Server 2019+: Mejoras de rendimiento**
- Soporte mejorado para Intelligent Query Processing
- Automatic plan correction para vistas indexadas
- Adaptive joins en consultas sobre vistas indexadas

### Cuándo Usar Vistas Indexadas

✅ **Usar cuando:**
- Los datos son **modificados con poca frecuencia**
- Las consultas involucran **muchos JOINs y agregaciones**
- Las consultas se ejecutan **frecuentemente** sobre los mismos datos
- El conjunto de datos es **grande** y las agregaciones son costosas

❌ **No usar cuando:**
- Los datos cambian **muy frecuentemente** (muchos INSERT/UPDATE/DELETE)
- El espacio en disco es limitado
- La vista es simple sin agregaciones

**🆕 SQL Server 2016+: Alternativa con Columnstore Indexes**

```sql
-- Alternativa moderna: Índice columnstore en tabla base
-- Mejor rendimiento para agregaciones sin overhead de vistas indexadas
CREATE NONCLUSTERED COLUMNSTORE INDEX idx_OrderDetails_CS
ON [Order Details] (ProductID, UnitPrice, Quantity);
GO

-- Las consultas de agregación son automáticamente más rápidas
SELECT ProductID, SUM(UnitPrice * Quantity) AS TotalRevenue
FROM [Order Details]
GROUP BY ProductID;
-- SQL Server usa el columnstore automáticamente
```

### Restricciones para Vistas Indexadas

#### 1. Debe usar SCHEMABINDING

```sql
-- ❌ Error: Falta SCHEMABINDING
CREATE VIEW ProductTotals
AS
SELECT ProductID, SUM(Quantity) AS TotalQty
FROM OrderDetails
GROUP BY ProductID;
GO

CREATE UNIQUE CLUSTERED INDEX idx_ProductTotals ON ProductTotals(ProductID);
GO

-- Error: Cannot create index on view 'ProductTotals' because it is not schema bound
```

#### 2. Solo puede referenciar tablas base (no otras vistas)

```sql
-- ❌ No puede referenciar otra vista
CREATE VIEW OrderSummary
WITH SCHEMABINDING
AS
SELECT * FROM OrderDetailsView;  -- Error si OrderDetailsView es una vista
```

#### 3. Debe incluir COUNT_BIG(*) si usa GROUP BY

```sql
-- ✓ Correcto: Incluye COUNT_BIG(*)
CREATE VIEW ProductTotals
WITH SCHEMABINDING
AS
SELECT ProductID, 
       SUM(UnitPrice * Quantity) AS TotalRevenue,
       SUM(Quantity) AS TotalQty,
       COUNT_BIG(*) AS OrderCount  -- Obligatorio
FROM dbo.[Order Details]
GROUP BY ProductID;
GO
```

#### 4. No puede usar:
- `SELECT *`
- Funciones no deterministas (GETDATE(), RAND())
- Subconsultas
- OUTER JOINs (solo INNER JOIN)
- TOP, DISTINCT (en el primer SELECT)
- UNION

**🆕 SQL Server 2014+: Excepción para funciones deterministas**

```sql
-- ✓ Ahora permitido: DATEFROMPARTS es determinista
CREATE VIEW VentasPorMes
WITH SCHEMABINDING
AS
SELECT 
    DATEFROMPARTS(YEAR(OrderDate), MONTH(OrderDate), 1) AS Mes,
    SUM(Total) AS TotalVentas,
    COUNT_BIG(*) AS NumVentas
FROM dbo.Orders
GROUP BY YEAR(OrderDate), MONTH(OrderDate);
GO

CREATE UNIQUE CLUSTERED INDEX idx_VentasPorMes ON VentasPorMes(Mes);
GO
```

### Ejemplo Completo de Vista Indexada

```sql
USE Northwind;
GO

-- Paso 1: Crear vista con SCHEMABINDING
CREATE VIEW dbo.ProductTotals
WITH SCHEMABINDING
AS
SELECT 
    ProductID, 
    SUM(UnitPrice * Quantity) AS TotalVolume,
    SUM(Quantity) AS TotalQty,
    COUNT_BIG(*) AS OrderCount
FROM dbo.[Order Details]
GROUP BY ProductID;
GO

-- Paso 2: Crear índice CLUSTERED UNIQUE
CREATE UNIQUE CLUSTERED INDEX idx_ProductTotals 
ON dbo.ProductTotals(ProductID);
GO

-- Paso 3: Opcionalmente, agregar índices no clustered
CREATE NONCLUSTERED INDEX idx_TotalVolume
ON dbo.ProductTotals(TotalVolume);
GO
```

### Consultar Vista Indexada

```sql
-- La vista se comporta como una tabla normal
SELECT ProductID, TotalVolume, TotalQty
FROM ProductTotals
WHERE TotalVolume > 10000
ORDER BY TotalVolume DESC;

-- El optimizador puede usar la vista indexada automáticamente
-- incluso si consultas la tabla base directamente (en Enterprise Edition)
SELECT ProductID, SUM(UnitPrice * Quantity) AS Revenue
FROM [Order Details]
GROUP BY ProductID;
-- SQL Server puede usar ProductTotals en lugar de calcular desde cero
```

**🆕 SQL Server 2016+: Query Store para monitorear uso**

```sql
-- Identificar vistas con planes de ejecución subóptimos
SELECT TOP 10
    q.query_id,
    OBJECT_NAME(q.object_id) AS ViewName,
    qt.query_sql_text,
    rs.avg_duration / 1000.0 AS avg_duration_ms,
    rs.count_executions
FROM sys.query_store_query q
JOIN sys.query_store_query_text qt ON q.query_text_id = qt.query_text_id
JOIN sys.query_store_plan p ON q.query_id = p.query_id
JOIN sys.query_store_runtime_stats rs ON p.plan_id = rs.plan_id
WHERE qt.query_sql_text LIKE '%VIEW%'
ORDER BY rs.avg_duration DESC;
```

#### Analizar plan de ejecución

```sql
SET STATISTICS IO ON;
SET STATISTICS TIME ON;

SELECT * FROM VentasActuales WHERE Region = 'Norte';

SET STATISTICS IO OFF;
SET STATISTICS TIME OFF;
```

**🆕 SQL Server 2016+: Live Query Statistics (SSMS)**

```sql
-- Habilitar en SSMS: Query → Include Live Query Statistics
-- O con Transact-SQL:
SET STATISTICS XML ON;
GO

SELECT * FROM VentasActuales WHERE Region = 'Norte';
GO

SET STATISTICS XML OFF;
GO
-- Ver plan de ejecución en tiempo real en SSMS
```

**🆕 SQL Server 2019+: Lightweight Query Profiling**

```sql
-- Habilitar profiling ligero (menos overhead)
ALTER DATABASE SCOPED CONFIGURATION SET LIGHTWEIGHT_QUERY_PROFILING = ON;
GO

-- Consultar ejecuciones en vivo
SELECT 
    session_id,
    request_id,
    start_time,
    status,
    command,
    sql_handle,
    plan_handle,
    database_id,
    blocking_session_id,
    wait_type,
    wait_time,
    cpu_time,
    logical_reads,
    reads,
    writes
FROM sys.dm_exec_requests
WHERE session_id > 50  -- Excluir sesiones del sistema
ORDER BY cpu_time DESC;
```

---

## 11. 🆕 Vistas Modernas: Temporal Tables y Azure SQL

### Temporal Tables (SQL Server 2016+)

**System-Versioned Temporal Tables** permiten consultar datos históricos automáticamente:

```sql
-- Crear tabla temporal
CREATE TABLE Productos (
    ProductoID INT PRIMARY KEY,
    Nombre NVARCHAR(100),
    Precio DECIMAL(10,2),
    -- Columnas de sistema (automáticas)
    SysStartTime DATETIME2 GENERATED ALWAYS AS ROW START NOT NULL,
    SysEndTime DATETIME2 GENERATED ALWAYS AS ROW END NOT NULL,
    PERIOD FOR SYSTEM_TIME (SysStartTime, SysEndTime)
)
WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.ProductosHistory));
GO

-- Vista que muestra estado actual
CREATE VIEW ProductosActuales
AS
SELECT ProductoID, Nombre, Precio
FROM Productos;
GO

-- Vista que muestra historial completo
CREATE VIEW ProductosHistorico
AS
SELECT 
    ProductoID, 
    Nombre, 
    Precio,
    SysStartTime AS ValidoDesde,
    SysEndTime AS ValidoHasta
FROM Productos FOR SYSTEM_TIME ALL;
GO

-- Consultar precio de un producto en fecha específica
SELECT * 
FROM Productos FOR SYSTEM_TIME AS OF '2024-01-01'
WHERE ProductoID = 1;

-- Ver todos los cambios de precio
SELECT * 
FROM ProductosHistorico
WHERE ProductoID = 1
ORDER BY ValidoDesde;
```

### Azure SQL Database: Serverless y Elastic Pools

**🆕 Azure SQL: Vistas con escalado automático**

```sql
-- Crear vista en Azure SQL Database Serverless
-- La base de datos escala automáticamente según demanda

CREATE VIEW VentasGlobalesCloud
AS
SELECT 
    v.VentaID,
    v.Fecha,
    v.Total,
    c.Pais,
    p.Nombre AS Producto
FROM Ventas v
JOIN Clientes c ON v.ClienteID = c.ClienteID
JOIN Productos p ON v.ProductoID = p.ProductoID;
GO

-- Azure SQL gestiona automáticamente:
-- - Escalado de compute (vCores)
-- - Almacenamiento
-- - Backups automáticos
-- - Alta disponibilidad
```

### Azure Synapse Analytics: Vistas Distribuidas

**🆕 Vistas sobre tablas distribuidas con hash**

```sql
-- En Azure Synapse Analytics
CREATE TABLE Ventas (
    VentaID BIGINT,
    ClienteID INT,
    Total DECIMAL(18,2),
    Fecha DATE
)
WITH (
    DISTRIBUTION = HASH(ClienteID),  -- Distribución por hash
    CLUSTERED COLUMNSTORE INDEX
);
GO

-- Vista que aprovecha distribución hash
CREATE VIEW VentasPorCliente
AS
SELECT 
    ClienteID,
    COUNT(*) AS NumVentas,
    SUM(Total) AS TotalVentas,
    AVG(Total) AS PromedioVenta
FROM Ventas
GROUP BY ClienteID;
GO

-- Consultas automáticamente paralelas en múltiples nodos
SELECT * FROM VentasPorCliente WHERE ClienteID = 12345;
```

### Graph Databases (SQL Server 2017+)

**🆕 Vistas sobre tablas de grafos**

```sql
-- Crear tablas de nodos y aristas
CREATE TABLE Personas (
    PersonaID INT PRIMARY KEY,
    Nombre NVARCHAR(100)
) AS NODE;
GO

CREATE TABLE Conoce AS EDGE;
GO

-- Vista que simplifica consultas de grafos
CREATE VIEW RelacionesPersonas
AS
SELECT 
    p1.Nombre AS Persona1,
    p2.Nombre AS Persona2,
    c.$edge_id AS RelacionID
FROM Personas p1, Conoce c, Personas p2
WHERE MATCH(p1-(c)->p2);
GO

-- Consultar relaciones
SELECT * FROM RelacionesPersonas
WHERE Persona1 = 'Juan';
```

---

## Resumen de Mejores Prácticas

### ✅ Hacer

1. **Usar vistas para seguridad:** Limitar acceso a columnas/filas sensibles
2. **Usar vistas para simplificar:** Encapsular JOINs complejos frecuentes
3. **Nombrar vistas claramente:** Usar sufijos como `_View` o prefijos como `v_`
4. **Documentar vistas:** Agregar comentarios sobre propósito y uso
5. **Usar CHECK OPTION:** Cuando la vista representa un subconjunto lógico modificable
6. **Considerar vistas indexadas:** Para agregaciones costosas con datos estables
7. **Mantener definiciones en control de versiones:** Especialmente si usan ENCRYPTION
8. **🆕 Usar CREATE OR ALTER:** Simplifica deployment de cambios (SQL 2016+)
9. **🆕 Aprovechar Intelligent Query Processing:** Habilitar nivel de compatibilidad 150+ (SQL 2019)
10. **🆕 Monitorear con Query Store:** Identificar vistas lentas proactivamente

### ❌ Evitar

1. **No abusar de vistas anidadas:** Máximo 2-3 niveles
2. **No usar SELECT \*:** Especificar columnas explícitamente
3. **No crear vistas sin propósito:** Cada vista debe tener una razón clara
4. **No ignorar impacto de vistas indexadas:** Considerar impacto en escrituras
5. **No olvidar WITH ENCRYPTION sin respaldo:** Mantener código fuente separado
6. **No usar funciones no deterministas:** En vistas que puedan ser indexadas
7. **🆕 No usar vistas particionadas legacy:** Preferir Partitioned Tables
8. **🆕 No ignorar Row-Level Security:** Mejor alternativa que vistas filtradas manualmente
9. **🆕 No usar vistas para ETL:** Considerar Azure Data Factory o SSIS
10. **🆕 No crear vistas indexadas en tablas con escrituras frecuentes:** Evaluar columnstore index en su lugar

---

## Casos de Uso Comunes

### 1. Seguridad: Limitar Acceso a Datos Sensibles

```sql
-- Tabla con datos sensibles
CREATE TABLE Empleados (
    EmpleadoID INT PRIMARY KEY,
    Nombre NVARCHAR(100),
    Salario DECIMAL(10,2),  -- Sensible
    SSN VARCHAR(11),         -- Sensible
    Departamento NVARCHAR(50)
);

-- Vista pública sin datos sensibles
CREATE VIEW EmpleadosPublico
AS
SELECT EmpleadoID, Nombre, Departamento
FROM Empleados;
GO

-- Otorgar permisos solo a la vista
GRANT SELECT ON EmpleadosPublico TO [Usuarios];
-- No otorgar permisos directos a la tabla Empleados
```

**🆕 Alternativa moderna: Dynamic Data Masking (SQL Server 2016+)**

```sql
-- Crear tabla con enmascaramiento automático
CREATE TABLE Empleados (
    EmpleadoID INT PRIMARY KEY,
    Nombre NVARCHAR(100),
    Salario DECIMAL(10,2) MASKED WITH (FUNCTION = 'default()'),
    SSN VARCHAR(11) MASKED WITH (FUNCTION = 'partial(0,"XXX-XX-",4)'),
    Departamento NVARCHAR(50)
);
GO

-- Vista simple (sin necesidad de excluir columnas)
CREATE VIEW EmpleadosTodos
AS
SELECT EmpleadoID, Nombre, Salario, SSN, Departamento
FROM Empleados;
GO

-- Usuarios sin UNMASK ven datos enmascarados
-- Sin necesidad de cifrar la vista
CREATE VIEW EmpleadosPublico
AS
SELECT EmpleadoID, Nombre, Salario, SSN, Departamento
FROM Empleados;
GO

-- Usuario regular ve:
-- EmpleadoID | Nombre      | Email          | Salario
-- 1          | Juan Pérez  | Jxxx@xxxx.com  | 0.00

-- Usuario con UNMASK ve valores reales
GRANT UNMASK TO [Gerente];
```

### 2. Simplificación: JOIN Complejo Repetitivo

```sql
-- Vista que simplifica consulta compleja frecuente
CREATE VIEW PedidosCompletos
AS
SELECT 
    o.OrderID,
    o.OrderDate,
    c.CustomerName,
    c.Email,
    p.ProductName,
    od.Quantity,
    od.UnitPrice,
    od.Quantity * od.UnitPrice AS LineTotal,
    e.EmployeeName AS SalesRep
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
JOIN Employees e ON o.EmployeeID = e.EmployeeID;
GO

-- Consulta simplificada para usuarios
SELECT * FROM PedidosCompletos
WHERE CustomerName = 'Acme Corp'
ORDER BY OrderDate DESC;
```

**🆕 SQL Server 2017+: Con STRING_AGG para consolidar detalles**

```sql
CREATE VIEW PedidosConsolidados
AS
SELECT 
    o.OrderID,
    o.OrderDate,
    c.CustomerName,
    c.Email,
    STRING_AGG(p.ProductName, ', ') WITHIN GROUP (ORDER BY p.ProductName) AS Productos,
    SUM(od.Quantity * od.UnitPrice) AS Total
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductoID
GROUP BY o.OrderID, o.OrderDate, c.CustomerName, c.Email;
GO

-- Resultado más compacto
SELECT * FROM PedidosConsolidados WHERE CustomerName = 'Acme Corp';
-- OrderID | OrderDate  | CustomerName | Productos                | Total
-- 1001    | 2024-01-15 | Acme Corp    | Laptop, Mouse, Teclado   | 1500.00
```

### 3. Agregaciones Pre-calculadas

```sql
CREATE VIEW VentasMensuales
AS
SELECT 
    YEAR(OrderDate) AS Año,
    MONTH(OrderDate) AS Mes,
    COUNT(*) AS TotalOrdenes,
    SUM(Total) AS TotalVentas,
    AVG(Total) AS PromedioVenta
FROM Orders
GROUP BY YEAR(OrderDate), MONTH(OrderDate);
GO

-- Consulta rápida
SELECT * FROM VentasMensuales
WHERE Año = 2024
ORDER BY Mes;
```

**🆕 SQL Server 2019+: Con Approximate Query Processing**

```sql
-- Vista con agregación aproximada (mucho más rápida en datasets grandes)
CREATE VIEW VentasMensualesAprox
AS
SELECT 
    YEAR(OrderDate) AS Año,
    MONTH(OrderDate) AS Mes,
    APPROX_COUNT_DISTINCT(CustomerID) AS ClientesUnicos,  -- 🆕 SQL 2019
    SUM(Total) AS TotalVentas
FROM Orders
GROUP BY YEAR(OrderDate), MONTH(OrderDate);
GO

-- 10-100x más rápida en tablas con millones de filas
-- Precisión: ~2% de error (aceptable para dashboards)
```

### 4. 🆕 Auditoría con Temporal Tables

```sql
-- Tabla con system-versioning
CREATE TABLE ProductosCatalogo (
    ProductoID INT PRIMARY KEY,
    Nombre NVARCHAR(100),
    Precio DECIMAL(10,2),
    SysStartTime DATETIME2 GENERATED ALWAYS AS ROW START NOT NULL DEFAULT SYSUTCDATETIME(),
    SysEndTime DATETIME2 GENERATED ALWAYS AS ROW END NOT NULL DEFAULT CONVERT(DATETIME2, '9999-12-31 23:59:59.9999999'),
    PERIOD FOR SYSTEM_TIME (SysStartTime, SysEndTime)
)
WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.ProductosCatalogoHistory));
GO

-- Vista que muestra cambios de precio
CREATE VIEW ProductosCambiosPrecio
AS
SELECT 
    ProductoID,
    Nombre,
    Precio AS PrecioAnterior,
    LEAD(Precio) OVER (PARTITION BY ProductoID ORDER BY SysStartTime) AS PrecioNuevo,
    SysStartTime AS FechaCambio,
    DATEDIFF(DAY, SysStartTime, SysEndTime) AS DiasVigencia
FROM ProductosCatalogo FOR SYSTEM_TIME ALL;
GO

-- Auditar cambios de precio
SELECT * FROM ProductosCambiosPrecio
WHERE ProductoID = 123
ORDER BY FechaCambio;
```

---

## Ejemplo Completo Integrador

```sql
-- ========================================
-- EJEMPLO INTEGRADOR: Sistema de Biblioteca Moderno
-- ========================================

USE Library;
GO

-- 1. Vista simple con seguridad y CHECK OPTION
CREATE OR ALTER VIEW LibrosDisponibles
AS
SELECT 
    ISBN,
    Titulo,
    Autor,
    Editorial,
    AñoPublicacion
FROM Libros
WHERE Disponible = 1
WITH CHECK OPTION;
GO

-- 2. Vista con JOIN para consultas frecuentes (con ENCRYPTION)
CREATE OR ALTER VIEW PrestamoActuales
WITH ENCRYPTION  -- Proteger lógica de negocio
AS
SELECT 
    p.PrestamoID,
    m.Nombre + ' ' + m.Apellido AS Miembro,
    m.Email,
    l.Titulo,
    l.Autor,
    p.FechaPrestamo,
    p.FechaDevolucionEsperada,
    DATEDIFF(DAY, p.FechaDevolucionEsperada, GETDATE()) AS DiasRetraso
FROM Prestamos p
JOIN Miembros m ON p.MiembroID = m.MiembroID
JOIN Libros l ON p.ISBN = l.ISBN
WHERE p.FechaDevolucionReal IS NULL;  -- Solo préstamos activos
GO

-- 3. Vista indexada para reportes (SQL Server 2016+)
CREATE OR ALTER VIEW EstadisticasLibros
WITH SCHEMABINDING
AS
SELECT 
    l.ISBN,
    l.Titulo,
    COUNT_BIG(*) AS TotalPrestamos,
    SUM(CASE WHEN p.FechaDevolucionReal IS NOT NULL THEN 1 ELSE 0 END) AS Devueltos,
    SUM(CASE WHEN p.FechaDevolucionReal IS NULL THEN 1 ELSE 0 END) AS Activos
FROM dbo.Libros l
LEFT JOIN dbo.Prestamos p ON l.ISBN = p.ISBN
GROUP BY l.ISBN, l.Titulo;
GO

CREATE UNIQUE CLUSTERED INDEX idx_EstadisticasLibros
ON EstadisticasLibros(ISBN);
GO

-- 4. 🆕 Vista sobre datos JSON (SQL Server 2016+)
CREATE OR ALTER VIEW LibrosMetadatos
AS
SELECT 
    ISBN,
    Titulo,
    JSON_VALUE(MetadatosJSON, '$.genero') AS Genero,
    JSON_VALUE(MetadatosJSON, '$.idioma') AS Idioma,
    CAST(JSON_VALUE(MetadatosJSON, '$.paginas') AS INT) AS Paginas
FROM Libros
WHERE ISJSON(MetadatosJSON) = 1;
GO

-- 5. 🆕 Vista con Row-Level Security (SQL Server 2016+)
CREATE FUNCTION dbo.fn_SeguridadPrestamos(@MiembroID INT)
RETURNS TABLE
WITH SCHEMABINDING
AS
RETURN SELECT 1 AS result
WHERE @MiembroID = CAST(SESSION_CONTEXT(N'MiembroID') AS INT)
   OR IS_MEMBER('Bibliotecarios') = 1;
GO

CREATE SECURITY POLICY PrestamosPolicy
ADD FILTER PREDICATE dbo.fn_SeguridadPrestamos(MiembroID) ON dbo.Prestamos
WITH (STATE = ON);
GO

-- Vista que respeta automáticamente RLS
CREATE OR ALTER VIEW MisPrestamos
AS
SELECT 
    PrestamoID,
    ISBN,
    FechaPrestamo,
    FechaDevolucionEsperada,
    FechaDevolucionReal
FROM Prestamos;
GO

-- 6. 🆕 Vista con Temporal Table (SQL Server 2016+)
ALTER TABLE Libros ADD
    SysStartTime DATETIME2 GENERATED ALWAYS AS ROW START NOT NULL DEFAULT SYSUTCDATETIME(),
    SysEndTime DATETIME2 GENERATED ALWAYS AS ROW END NOT NULL DEFAULT CONVERT(DATETIME2, '9999-12-31 23:59:59.9999999'),
    PERIOD FOR SYSTEM_TIME (SysStartTime, SysEndTime);
GO

ALTER TABLE Libros 
SET (SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.LibrosHistory));
GO

CREATE OR ALTER VIEW LibrosHistorialCambios
AS
SELECT 
    ISBN,
    Titulo,
    Autor,
    SysStartTime AS ValidoDesde,
    SysEndTime AS ValidoHasta
FROM Libros FOR SYSTEM_TIME ALL;
GO

-- Uso de las vistas
SELECT * FROM LibrosDisponibles WHERE Autor LIKE '%García%';
SELECT * FROM PrestamoActuales WHERE DiasRetraso > 0;
SELECT * FROM EstadisticasLibros ORDER BY TotalPrestamos DESC;
SELECT * FROM LibrosMetadatos WHERE Genero = 'Ciencia Ficción';

-- Usuario establece contexto de sesión para RLS
EXEC sp_set_session_context @key = N'MiembroID', @value = 123;
SELECT * FROM MisPrestamos;  -- Solo ve sus propios préstamos

-- Auditar cambios históricos
SELECT * FROM LibrosHistorialCambios 
WHERE ISBN = '978-0-123456-78-9'
ORDER BY ValidoDesde DESC;
```

---

## Conclusión

Las **vistas** son una herramienta fundamental en SQL Server que:

- ✅ Mejoran la **seguridad** al controlar acceso a datos
- ✅ **Simplifican** consultas complejas para usuarios finales  
- ✅ Permiten **encapsular lógica** de negocio
- ✅ Pueden mejorar **rendimiento** mediante indexación
- ✅ Facilitan **mantenimiento** al centralizar consultas frecuentes
- ✅ **🆕 Se integran con tecnologías modernas:** RLS, Dynamic Data Masking, Temporal Tables, JSON, Grafos
- ✅ **🆕 Escalan en la nube:** Azure SQL Database, Azure Synapse Analytics
- ✅ **🆕 Aprovechan IA:** Intelligent Query Processing, Adaptive Query Processing

**Usar vistas apropiadamente** es señal de un diseño de base de datos maduro y bien pensado.

### Roadmap de Aprendizaje Sugerido

**Nivel Básico (2-3 semanas):**
1. Crear vistas simples con SELECT
2. Usar vistas para seguridad (ocultar columnas)
3. WITH CHECK OPTION
4. Modificar datos a través de vistas

**Nivel Intermedio (3-4 semanas):**
5. Vistas con JOINs complejos
6. SCHEMABINDING para protección de esquema
7. Vistas indexadas para performance
8. Consultar catálogo del sistema (sys.views)

**Nivel Avanzado (4-6 semanas):**
9. 🆕 Row-Level Security con vistas
10. 🆕 Dynamic Data Masking
11. 🆕 Temporal Tables para auditoría
12. 🆕 Vistas sobre JSON/XML
13. 🆕 Azure SQL Database vistas distribuidas
14. 🆕 Query Store para optimización

---

## Ejercicios Propuestos

### Ejercicio 1: Vistas Básicas
Crear vistas para el esquema Northwind:
1. Vista de productos activos con su categoría
2. Vista de clientes con su total de órdenes
3. Vista de empleados con sus ventas totales

### Ejercicio 2: Vistas con Seguridad
Crear vistas que:
1. Oculten salarios de empleados pero muestren otros datos
2. Muestren solo pedidos del último año
3. Usen CHECK OPTION para validar inserciones

### Ejercicio 3: Vista Indexada
Crear una vista indexada que:
1. Calcule ventas totales por producto
2. Incluya cantidad total vendida
3. Tenga índice clustered apropiado

### 🆕 Ejercicio 4: Vistas Modernas (SQL Server 2016+)
1. Implementar Row-Level Security en tabla Ventas (filtrar por vendedor)
2. Crear vista sobre columna JSON en tabla Productos
3. Usar Temporal Table para auditar cambios de precio
4. Implementar Dynamic Data Masking en tabla Empleados

### 🆕 Ejercicio 5: Azure SQL (Nivel Avanzado)
1. Migrar vista local a Azure SQL Database
2. Crear vista en Azure Synapse Analytics sobre tabla distribuida
3. Implementar vista con Auto-Failover Groups

---

**Referencias Actualizadas:**
- Microsoft Docs: [CREATE VIEW (Transact-SQL)](https://learn.microsoft.com/en-us/sql/t-sql/statements/create-view-transact-sql)
- Microsoft Docs: [Indexed Views](https://learn.microsoft.com/en-us/sql/relational-databases/views/create-indexed-views)
- Microsoft Docs: [Temporal Tables](https://learn.microsoft.com/en-us/sql/relational-databases/tables/temporal-tables)
- Microsoft Docs: [Row-Level Security](https://learn.microsoft.com/en-us/sql/relational-databases/security/row-level-security)
- Microsoft Docs: [Dynamic Data Masking](https://learn.microsoft.com/en-us/sql/relational-databases/security/dynamic-data-masking)
- Microsoft Docs: [Query Store](https://learn.microsoft.com/en-us/sql/relational-databases/performance/monitoring-performance-by-using-the-query-store)
- Microsoft Docs: [Intelligent Query Processing](https://learn.microsoft.com/en-us/sql/relational-databases/performance/intelligent-query-processing)
- SQL Server Books Online: View Design Guidelines
