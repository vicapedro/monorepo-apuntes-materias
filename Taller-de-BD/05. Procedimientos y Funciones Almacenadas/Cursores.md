# Cursores en SQL Server (T-SQL)

**Taller de Base de Datos**

---

## 📋 Tabla de Contenidos

1. [Concepto de Cursores](#concepto-de-cursores)
2. [Sintaxis de Declaración](#sintaxis-de-declaración)
3. [Tipos de Cursores](#tipos-de-cursores)
4. [Ciclo de Vida de un Cursor](#ciclo-de-vida-de-un-cursor)
5. [Operaciones FETCH](#operaciones-fetch)
6. [Modificación de Datos con Cursores](#modificación-de-datos-con-cursores)
7. [Variables y Funciones del Sistema](#variables-y-funciones-del-sistema)
8. [Cursores Globales vs Locales](#cursores-globales-vs-locales)
9. [Mejores Prácticas y Alternativas](#mejores-prácticas-y-alternativas)
10. [Ejemplos Completos](#ejemplos-completos)

---

## 1. Concepto de Cursores

### ¿Qué es un Cursor?

Un **cursor** es una entidad que se relaciona con un conjunto de resultados y establece una posición sobre un **único renglón** dentro de ese conjunto.

- El conjunto de renglones que retorna un `SELECT` es conocido como **result set**.
- El cursor es un mecanismo que permite **interactuar sobre un subconjunto** del result set, **fila por fila**.

### ¿Para qué sirve un Cursor?

Un cursor permite:

- ✅ **Posicionarse** en un renglón específico del result set
- ✅ **Recuperar** un renglón a partir de una posición del result set
- ✅ **Modificar** renglones del result set
- ✅ **Establecer niveles de visibilidad** para cambios hechos por otros usuarios sobre los datos del result set

### Tipos de Cursores en SQL Server

SQL Server ofrece diferentes implementaciones de cursores:

1. **API Server Cursors** - Implementados en la API de cliente (ADO.NET, ODBC, JDBC)
2. **Transact-SQL Server Cursors** - Implementados en T-SQL (enfoque de esta guía)
3. **Client Cursors** - Implementados completamente en el cliente

---

## 2. Sintaxis de Declaración

### Sintaxis Completa

```sql
DECLARE cursor_name CURSOR 
    [ LOCAL | GLOBAL ] 
    [ FORWARD_ONLY | SCROLL ] 
    [ STATIC | KEYSET | DYNAMIC | FAST_FORWARD ] 
    [ READ_ONLY | SCROLL_LOCKS | OPTIMISTIC ] 
    [ TYPE_WARNING ] 
FOR select_statement 
[ FOR UPDATE [ OF column_name [ ,...n ] ] ]
```

### Parámetros Principales

| Parámetro | Descripción |
|-----------|-------------|
| **LOCAL / GLOBAL** | Define el ámbito del cursor (procedimiento vs conexión) |
| **FORWARD_ONLY** | Solo permite avanzar hacia adelante (NEXT) |
| **SCROLL** | Permite navegación completa (FIRST, LAST, PRIOR, NEXT, RELATIVE, ABSOLUTE) |
| **STATIC** | Cursor de solo lectura, datos copiados a TempDB |
| **KEYSET** | El conjunto de filas está fijo, pero los valores pueden cambiar |
| **DYNAMIC** | Refleja todos los cambios en tiempo real |
| **FAST_FORWARD** | Optimizado para FORWARD_ONLY + READ_ONLY |
| **READ_ONLY** | No permite modificaciones a través del cursor |
| **SCROLL_LOCKS** | Bloquea filas al leerlas para garantizar actualizaciones |
| **OPTIMISTIC** | No bloquea filas, detecta cambios en el momento de actualizar |
| **TYPE_WARNING** | Muestra advertencia si el tipo de cursor se convierte implícitamente |

---

## 3. Tipos de Cursores

### 3.1 Cursor STATIC (Estático)

```sql
DECLARE cursor_estatico CURSOR STATIC
FOR SELECT * FROM Empleados;
```

**Características:**
- ✅ Solo lectura
- ✅ Las filas y valores **no cambian** después de abrir el cursor
- ✅ Los datos se almacenan en una **copia temporal en TempDB**
- ❌ Las modificaciones en las tablas base **NO se reflejan** en el cursor
- ❌ No admite modificaciones con `WHERE CURRENT OF`

**Ventajas:**
- Resultados consistentes durante toda la navegación
- No afecta ni es afectado por otras transacciones

**Desventajas:**
- Consume memoria/disco en TempDB
- Datos pueden estar desactualizados

---

### 3.2 Cursor DYNAMIC (Dinámico)

```sql
DECLARE cursor_dinamico CURSOR DYNAMIC
FOR SELECT * FROM Empleados;
```

**Características:**
- ✅ Refleja **todos los cambios** realizados en las tablas base
- ✅ Los valores, orden y pertenencia de filas pueden cambiar en cada FETCH
- ❌ La opción `FETCH ABSOLUTE` **NO** está disponible
- ⚠️ Mayor impacto en rendimiento

**Ventajas:**
- Datos siempre actualizados
- Refleja INSERTS, UPDATES, DELETES de otros usuarios

**Desventajas:**
- Más lento que otros tipos
- Resultados inconsistentes si hay cambios concurrentes
- No soporta navegación absoluta

---

### 3.3 Cursor KEYSET

```sql
DECLARE cursor_keyset CURSOR KEYSET
FOR SELECT * FROM Empleados;
```

**Características:**
- ✅ El **conjunto de filas está fijo** al abrir el cursor
- ✅ Los **valores de las columnas se actualizan** dinámicamente
- ❌ No detecta nuevas filas insertadas
- ❌ Las filas eliminadas se detectan como `@@FETCH_STATUS = -2`

**Ventajas:**
- Balance entre consistencia y actualización de datos
- Mejor rendimiento que DYNAMIC

**Desventajas:**
- Requiere columna única (clave) para identificar filas

---

### 3.4 Cursor FAST_FORWARD

```sql
DECLARE cursor_rapido CURSOR FAST_FORWARD
FOR SELECT * FROM Empleados;
```

**Características:**
- ✅ Optimización de `FORWARD_ONLY` + `READ_ONLY`
- ✅ **Máximo rendimiento**
- ✅ Recomendado para procesamiento secuencial sin modificaciones

---

## 4. Ciclo de Vida de un Cursor

### Pasos para Usar un Cursor

```sql
-- PASO 1: DECLARAR el cursor
DECLARE cursor_autores CURSOR FOR 
    SELECT au_id, au_lname, au_fname, phone 
    FROM autores
    ORDER BY au_lname;

-- PASO 2: ABRIR el cursor (ejecuta el SELECT)
OPEN cursor_autores;

-- PASO 3: RECUPERAR datos (FETCH)
DECLARE @au_id VARCHAR(11), @apellido VARCHAR(40), @nombre VARCHAR(20), @telefono CHAR(12);

FETCH NEXT FROM cursor_autores INTO @au_id, @apellido, @nombre, @telefono;

-- PASO 4: PROCESAR datos en un bucle
WHILE @@FETCH_STATUS = 0
BEGIN
    -- Procesar la fila actual
    PRINT @apellido + ', ' + @nombre + ' - ' + @telefono;
    
    -- Avanzar a la siguiente fila
    FETCH NEXT FROM cursor_autores INTO @au_id, @apellido, @nombre, @telefono;
END

-- PASO 5: CERRAR el cursor (libera el result set)
CLOSE cursor_autores;

-- PASO 6: LIBERAR el cursor (elimina la definición)
DEALLOCATE cursor_autores;
```

### Diagrama de Estados

```
┌─────────────┐
│  DECLARE    │  Define el cursor
└──────┬──────┘
       │
       v
┌─────────────┐
│    OPEN     │  Ejecuta SELECT y llena result set
└──────┬──────┘
       │
       v
┌─────────────┐
│    FETCH    │  Recupera filas una por una
└──────┬──────┘
       │
       v
┌─────────────┐
│   CLOSE     │  Cierra cursor (libera result set)
└──────┬──────┘
       │
       v
┌─────────────┐
│ DEALLOCATE  │  Elimina cursor de memoria
└─────────────┘
```

---

## 5. Operaciones FETCH

### Sintaxis Completa de FETCH

```sql
FETCH 
    [ [ NEXT | PRIOR | FIRST | LAST 
        | ABSOLUTE { n | @nvar } 
        | RELATIVE { n | @nvar } 
      ] 
      FROM 
    ] 
    { cursor_name }  
    [ INTO @variable_name [ ,...n ] ]
```

### Opciones de FETCH

| Opción | Descripción | Requiere SCROLL |
|--------|-------------|-----------------|
| **NEXT** | Siguiente fila (por defecto) | No |
| **PRIOR** | Fila anterior | Sí |
| **FIRST** | Primera fila del cursor | Sí |
| **LAST** | Última fila del cursor | Sí |
| **ABSOLUTE n** | Fila en la posición absoluta `n` | Sí |
| **RELATIVE n** | Fila `n` posiciones relativas a la actual | Sí |

### Ejemplos de FETCH

```sql
-- Declarar cursor con SCROLL para navegación completa
DECLARE mi_cursor CURSOR SCROLL
FOR SELECT EmployeeID, FirstName, LastName FROM Employees;

OPEN mi_cursor;

-- Variables para almacenar datos
DECLARE @id INT, @nombre NVARCHAR(50), @apellido NVARCHAR(50);

-- Primera fila
FETCH FIRST FROM mi_cursor INTO @id, @nombre, @apellido;
PRINT 'Primera: ' + @nombre + ' ' + @apellido;

-- Última fila
FETCH LAST FROM mi_cursor INTO @id, @nombre, @apellido;
PRINT 'Última: ' + @nombre + ' ' + @apellido;

-- Fila anterior
FETCH PRIOR FROM mi_cursor INTO @id, @nombre, @apellido;
PRINT 'Anterior: ' + @nombre + ' ' + @apellido;

-- Fila absoluta (posición 5)
FETCH ABSOLUTE 5 FROM mi_cursor INTO @id, @nombre, @apellido;
PRINT 'Posición 5: ' + @nombre + ' ' + @apellido;

-- Fila relativa (3 posiciones adelante)
FETCH RELATIVE 3 FROM mi_cursor INTO @id, @nombre, @apellido;
PRINT 'Relativa +3: ' + @nombre + ' ' + @apellido;

-- Fila relativa (2 posiciones atrás)
FETCH RELATIVE -2 FROM mi_cursor INTO @id, @nombre, @apellido;
PRINT 'Relativa -2: ' + @nombre + ' ' + @apellido;

CLOSE mi_cursor;
DEALLOCATE mi_cursor;
```

---

## 6. Variable @@FETCH_STATUS

### Valores de @@FETCH_STATUS

| Valor | Significado |
|-------|-------------|
| **0** | La operación FETCH tuvo **éxito** |
| **-1** | La operación FETCH falló o la fila está **fuera del conjunto de resultados** (no hay más filas) |
| **-2** | La fila recuperada **no existe** en el cursor (KEYSET o DYNAMIC) |

### Ejemplo de Uso

```sql
DECLARE cursor_productos CURSOR FOR
    SELECT ProductID, ProductName, UnitPrice 
    FROM Products 
    WHERE Discontinued = 0;

OPEN cursor_productos;

DECLARE @id INT, @nombre NVARCHAR(100), @precio MONEY;

FETCH NEXT FROM cursor_productos INTO @id, @nombre, @precio;

-- Bucle mientras haya filas disponibles
WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT CAST(@id AS VARCHAR) + ' - ' + @nombre + ' - $' + CAST(@precio AS VARCHAR);
    
    FETCH NEXT FROM cursor_productos INTO @id, @nombre, @precio;
END

-- Verificar el estado final
IF @@FETCH_STATUS = -1
    PRINT 'No hay más filas en el cursor';
ELSE IF @@FETCH_STATUS = -2
    PRINT 'La fila solicitada no existe';

CLOSE cursor_productos;
DEALLOCATE cursor_productos;
```

---

## 7. Modificación de Datos con Cursores

### Sintaxis UPDATE/DELETE con WHERE CURRENT OF

Cuando un cursor **no es READ_ONLY**, se puede usar la cláusula `WHERE CURRENT OF` para modificar o eliminar la fila actual del cursor.

```sql
UPDATE tabla
SET columna = valor
WHERE CURRENT OF cursor_name;

DELETE FROM tabla
WHERE CURRENT OF cursor_name;
```

### Ejemplo Completo: Actualización con Cursor

```sql
-- Crear cursor con FOR UPDATE
DECLARE cursor_loan CURSOR FOR 
    SELECT isbn, copy_no, title_no, member_no, out_date, due_date
    FROM loan 
    FOR UPDATE OF out_date;  -- Especifica columnas actualizables

OPEN cursor_loan;

DECLARE @isbn INT, @copy_no INT, @title_no INT, @member_no INT;
DECLARE @out_date DATE, @due_date DATE;

FETCH NEXT FROM cursor_loan INTO @isbn, @copy_no, @title_no, @member_no, @out_date, @due_date;

WHILE @@FETCH_STATUS = 0
BEGIN
    -- Verificar si la fecha de salida es antigua
    IF @out_date < '2000-01-01'
    BEGIN
        -- Actualizar la fila ACTUAL del cursor
        UPDATE loan 
        SET out_date = '2007-10-02'
        WHERE CURRENT OF cursor_loan;
        
        PRINT 'Actualizado préstamo: ISBN=' + CAST(@isbn AS VARCHAR) + 
              ', Fecha anterior: ' + CAST(@out_date AS VARCHAR);
    END
    
    FETCH NEXT FROM cursor_loan INTO @isbn, @copy_no, @title_no, @member_no, @out_date, @due_date;
END

CLOSE cursor_loan;
DEALLOCATE cursor_loan;
```

### Ejemplo: Eliminación con Cursor

```sql
DECLARE cursor_empleados CURSOR FOR 
    SELECT EmployeeID, HireDate, Salary
    FROM Employees 
    FOR UPDATE;

OPEN cursor_empleados;

DECLARE @emp_id INT, @fecha_contrato DATE, @salario MONEY;

FETCH NEXT FROM cursor_empleados INTO @emp_id, @fecha_contrato, @salario;

WHILE @@FETCH_STATUS = 0
BEGIN
    -- Eliminar empleados con más de 20 años y salario bajo
    IF DATEDIFF(YEAR, @fecha_contrato, GETDATE()) > 20 AND @salario < 30000
    BEGIN
        DELETE FROM Employees
        WHERE CURRENT OF cursor_empleados;
        
        PRINT 'Empleado eliminado: ' + CAST(@emp_id AS VARCHAR);
    END
    
    FETCH NEXT FROM cursor_empleados INTO @emp_id, @fecha_contrato, @salario;
END

CLOSE cursor_empleados;
DEALLOCATE cursor_empleados;
```

### Restricciones con READ_ONLY

```sql
-- Cursor de solo lectura
DECLARE cursor_readonly CURSOR READ_ONLY
FOR SELECT * FROM Productos;

OPEN cursor_readonly;

-- Esto FALLARÁ con error
UPDATE Productos
SET Price = 100
WHERE CURRENT OF cursor_readonly;  -- ERROR: Cursor is READ_ONLY

CLOSE cursor_readonly;
DEALLOCATE cursor_readonly;
```

---

## 8. Cursores Globales vs Locales

### LOCAL (Por Defecto en Configuración)

Un cursor **LOCAL** es visible solo dentro del ámbito donde se declaró:

- Dentro de un procedimiento almacenado
- Dentro de un trigger
- Dentro de un batch

```sql
CREATE PROCEDURE sp_ProcesarVentas
AS
BEGIN
    -- Cursor LOCAL: solo visible dentro de este procedimiento
    DECLARE cursor_ventas CURSOR LOCAL
    FOR SELECT SaleID, SaleDate, Amount FROM Sales;
    
    OPEN cursor_ventas;
    
    -- ... procesamiento ...
    
    CLOSE cursor_ventas;
    DEALLOCATE cursor_ventas;
END;
GO

-- Después de ejecutar el procedimiento, el cursor NO existe
EXEC sp_ProcesarVentas;

-- Esto FALLA:
FETCH NEXT FROM cursor_ventas;  -- ERROR: cursor_ventas no existe
```

### GLOBAL

Un cursor **GLOBAL** es visible para **toda la conexión** (session):

```sql
-- Declarar cursor global
DECLARE cursor_global CURSOR GLOBAL
FOR SELECT * FROM Customers;

OPEN cursor_global;

-- Puede usarse en cualquier parte de la sesión
-- Incluso después de salir del procedimiento que lo creó
```

### Cambiar el Comportamiento por Defecto

```sql
-- Establecer cursores locales por defecto para toda la base de datos
ALTER DATABASE MiBaseDatos SET CURSOR_DEFAULT LOCAL;

-- Establecer cursores globales por defecto
ALTER DATABASE MiBaseDatos SET CURSOR_DEFAULT GLOBAL;
```

### Ejemplo: Cursor Global Usado Fuera de Procedimiento

```sql
CREATE PROCEDURE sp_AbrirCursor
AS
BEGIN
    DECLARE cursor_productos CURSOR GLOBAL
    FOR SELECT ProductID, ProductName FROM Products;
    
    OPEN cursor_productos;
END;
GO

-- Ejecutar procedimiento (declara y abre cursor global)
EXEC sp_AbrirCursor;

-- Ahora el cursor está disponible en la sesión
DECLARE @id INT, @nombre NVARCHAR(50);

FETCH NEXT FROM cursor_productos INTO @id, @nombre;
WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT @nombre;
    FETCH NEXT FROM cursor_productos INTO @id, @nombre;
END

-- Cerrar cursor desde fuera del procedimiento
CLOSE cursor_productos;
DEALLOCATE cursor_productos;
```

---

## 9. SCROLL y FORWARD_ONLY

### FORWARD_ONLY (Predeterminado)

- ✅ Solo permite avanzar hacia adelante con `FETCH NEXT`
- ✅ **Mejor rendimiento**
- ✅ Consume menos recursos
- ❌ No permite navegación hacia atrás ni posicionamiento absoluto

```sql
DECLARE cursor_forward CURSOR FORWARD_ONLY
FOR SELECT * FROM Employees;

OPEN cursor_forward;

-- Solo FETCH NEXT está permitido
FETCH NEXT FROM cursor_forward;

-- Esto FALLA:
FETCH PRIOR FROM cursor_forward;  -- ERROR
FETCH FIRST FROM cursor_forward;  -- ERROR

CLOSE cursor_forward;
DEALLOCATE cursor_forward;
```

### SCROLL

- ✅ Permite **todas las opciones de navegación**:
  - FIRST, LAST, PRIOR, NEXT
  - ABSOLUTE n (posición absoluta)
  - RELATIVE n (posición relativa)
- ⚠️ Mayor consumo de recursos
- ⚠️ Puede requerir almacenamiento temporal

```sql
DECLARE cursor_scroll CURSOR SCROLL
FOR SELECT * FROM Employees ORDER BY EmployeeID;

OPEN cursor_scroll;

DECLARE @id INT, @nombre NVARCHAR(50);

-- Navegación completa disponible
FETCH FIRST FROM cursor_scroll INTO @id, @nombre;
FETCH LAST FROM cursor_scroll INTO @id, @nombre;
FETCH ABSOLUTE 10 FROM cursor_scroll INTO @id, @nombre;
FETCH RELATIVE -3 FROM cursor_scroll INTO @id, @nombre;

CLOSE cursor_scroll;
DEALLOCATE cursor_scroll;
```

### Comportamiento por Defecto

| Tipo de Cursor | Valor Predeterminado |
|----------------|----------------------|
| Sin especificar | FORWARD_ONLY |
| STATIC | SCROLL |
| KEYSET | SCROLL |
| DYNAMIC | SCROLL |

---

## 10. Variables y Funciones del Sistema

### @@CURSOR_ROWS

Devuelve el **número de filas** en el último cursor abierto.

```sql
DECLARE cursor_test CURSOR FOR SELECT * FROM Employees;

OPEN cursor_test;

-- Ver cuántas filas tiene el cursor
SELECT @@CURSOR_ROWS AS TotalFilas;

CLOSE cursor_test;
DEALLOCATE cursor_test;
```

**Valores de @@CURSOR_ROWS:**

| Valor | Significado |
|-------|-------------|
| **-1** | Cursor DYNAMIC (número de filas desconocido o variable) |
| **0** | No hay cursores abiertos o el último cursor no tiene filas |
| **n** | Número de filas en el cursor |

---

### CURSOR_STATUS()

Función que permite verificar el estado de un cursor, especialmente útil cuando se pasan cursores como parámetros.

```sql
CURSOR_STATUS(
    { 'local' , 'cursor_name' }   
    | { 'global' , 'cursor_name' } 
    | { 'variable' , 'cursor_variable' }   
)
```

**Valores de retorno:**

| Valor | Significado |
|-------|-------------|
| **1** | El cursor está **abierto** y tiene al menos una fila |
| **0** | El cursor está **abierto** pero **no tiene filas** |
| **-1** | El cursor está **cerrado** |
| **-2** | No aplicable o cursor no existe |
| **-3** | El cursor especificado **no existe** |

### Ejemplo de CURSOR_STATUS

```sql
DECLARE @status INT;
DECLARE cursor_ejemplo CURSOR LOCAL
FOR SELECT * FROM Employees;

-- Antes de abrir
SET @status = CURSOR_STATUS('local', 'cursor_ejemplo');
PRINT 'Estado antes de OPEN: ' + CAST(@status AS VARCHAR);  -- -1 (cerrado)

OPEN cursor_ejemplo;

-- Después de abrir
SET @status = CURSOR_STATUS('local', 'cursor_ejemplo');
PRINT 'Estado después de OPEN: ' + CAST(@status AS VARCHAR);  -- 1 (abierto con filas)

CLOSE cursor_ejemplo;

-- Después de cerrar
SET @status = CURSOR_STATUS('local', 'cursor_ejemplo');
PRINT 'Estado después de CLOSE: ' + CAST(@status AS VARCHAR);  -- -1 (cerrado)

DEALLOCATE cursor_ejemplo;

-- Después de deallocate
SET @status = CURSOR_STATUS('local', 'cursor_ejemplo');
PRINT 'Estado después de DEALLOCATE: ' + CAST(@status AS VARCHAR);  -- -3 (no existe)
```

---

### Cursores como Variables OUTPUT

Los cursores pueden pasarse como parámetros entre procedimientos almacenados:

```sql
-- Procedimiento que DEVUELVE un cursor
CREATE PROCEDURE sp_ObtenerCursor
    @cursor_out CURSOR VARYING OUTPUT
AS
BEGIN
    SET @cursor_out = CURSOR FORWARD_ONLY STATIC
    FOR SELECT EmployeeID, FirstName, LastName FROM Employees;
    
    OPEN @cursor_out;
END;
GO

-- Procedimiento que USA el cursor
DECLARE @mi_cursor CURSOR;

EXEC sp_ObtenerCursor @cursor_out = @mi_cursor OUTPUT;

-- Ahora @mi_cursor está abierto y listo para usar
DECLARE @id INT, @nombre NVARCHAR(50), @apellido NVARCHAR(50);

FETCH NEXT FROM @mi_cursor INTO @id, @nombre, @apellido;

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT @nombre + ' ' + @apellido;
    FETCH NEXT FROM @mi_cursor INTO @id, @nombre, @apellido;
END

CLOSE @mi_cursor;
DEALLOCATE @mi_cursor;
```

---

## 11. SET CURSOR_CLOSE_ON_COMMIT

Determina si un cursor se **cierra automáticamente** al confirmar una transacción.

```sql
-- Activar cierre automático de cursores al hacer COMMIT
SET CURSOR_CLOSE_ON_COMMIT ON;

BEGIN TRANSACTION;

    DECLARE cursor_transaccion CURSOR FOR SELECT * FROM Products;
    OPEN cursor_transaccion;
    
    -- Trabajar con el cursor...
    
COMMIT TRANSACTION;

-- El cursor se CIERRA automáticamente después del COMMIT
-- Esto FALLA:
FETCH NEXT FROM cursor_transaccion;  -- ERROR: cursor cerrado
```

```sql
-- Desactivar cierre automático (comportamiento predeterminado)
SET CURSOR_CLOSE_ON_COMMIT OFF;

BEGIN TRANSACTION;

    DECLARE cursor_persistente CURSOR FOR SELECT * FROM Products;
    OPEN cursor_persistente;
    
COMMIT TRANSACTION;

-- El cursor SIGUE ABIERTO después del COMMIT
FETCH NEXT FROM cursor_persistente;  -- ÉXITO

CLOSE cursor_persistente;
DEALLOCATE cursor_persistente;
```

---

## 12. Mejores Prácticas y Alternativas

### ⚠️ Desventajas de los Cursores

1. **Bajo rendimiento**: Procesamiento fila por fila en lugar de operaciones basadas en conjuntos
2. **Bloqueos**: Pueden mantener bloqueos por más tiempo
3. **Consumo de memoria**: Especialmente cursores STATIC
4. **Complejidad**: Código más largo y difícil de mantener

### ✅ Cuándo USAR Cursores

- ✅ Operaciones administrativas complejas (mantenimiento, auditoría)
- ✅ Lógica que requiere procesamiento secuencial específico
- ✅ Interacción con APIs externas fila por fila
- ✅ Generación de reportes complejos con formato especial

### ❌ Cuándo NO Usar Cursores

- ❌ Operaciones de actualización masiva (usar UPDATE)
- ❌ Cálculos agregados (usar funciones de agregación)
- ❌ Transformaciones de datos (usar JOINs, CTEs, subconsultas)
- ❌ Inserción de datos (usar INSERT INTO ... SELECT)

### 🚀 Alternativas Recomendadas

#### Alternativa 1: Operaciones Basadas en Conjuntos

```sql
-- ❌ MAL: Usando cursor
DECLARE cursor_actualizar CURSOR FOR SELECT ProductID FROM Products;
OPEN cursor_actualizar;
DECLARE @id INT;
FETCH NEXT FROM cursor_actualizar INTO @id;
WHILE @@FETCH_STATUS = 0
BEGIN
    UPDATE Products SET Price = Price * 1.1 WHERE ProductID = @id;
    FETCH NEXT FROM cursor_actualizar INTO @id;
END
CLOSE cursor_actualizar;
DEALLOCATE cursor_actualizar;

-- ✅ BIEN: Operación de conjunto
UPDATE Products
SET Price = Price * 1.1;
```

#### Alternativa 2: CTEs y Funciones de Ventana

```sql
-- ❌ MAL: Cursor para calcular totales acumulados
DECLARE cursor_total CURSOR FOR SELECT OrderID, Amount FROM Orders ORDER BY OrderDate;
DECLARE @acumulado DECIMAL(10,2) = 0;
-- ... código complejo con cursor ...

-- ✅ BIEN: Función de ventana
SELECT 
    OrderID,
    Amount,
    SUM(Amount) OVER (ORDER BY OrderDate) AS TotalAcumulado
FROM Orders;
```

#### Alternativa 3: Tablas Temporales y WHILE

```sql
-- ✅ Mejor que cursor: Tabla temporal con procesamiento por lotes
CREATE TABLE #ProcesarLotes (
    ID INT IDENTITY(1,1),
    ProductID INT,
    Procesado BIT DEFAULT 0
);

INSERT INTO #ProcesarLotes (ProductID)
SELECT ProductID FROM Products WHERE Stock < 10;

WHILE EXISTS (SELECT 1 FROM #ProcesarLotes WHERE Procesado = 0)
BEGIN
    DECLARE @lote_id INT;
    
    SELECT TOP 1 @lote_id = ID FROM #ProcesarLotes WHERE Procesado = 0;
    
    -- Procesar el registro
    -- ...
    
    UPDATE #ProcesarLotes SET Procesado = 1 WHERE ID = @lote_id;
END

DROP TABLE #ProcesarLotes;
```

---

## 13. Ejemplos Completos

### Ejemplo 1: Procesamiento de Préstamos (Biblioteca)

```sql
-- Escenario: Actualizar fechas de devolución vencidas y enviar notificaciones

USE Biblioteca;
GO

-- Crear tabla de ejemplo
CREATE TABLE Prestamos (
    PrestamoID INT PRIMARY KEY IDENTITY,
    ISBN VARCHAR(20),
    NumCopia INT,
    NumMiembro INT,
    FechaPrestamo DATE,
    FechaVencimiento DATE,
    FechaDevolucion DATE NULL,
    Estado VARCHAR(20) DEFAULT 'Activo'
);

-- Insertar datos de prueba
INSERT INTO Prestamos (ISBN, NumCopia, NumMiembro, FechaPrestamo, FechaVencimiento)
VALUES 
    ('978-0134685991', 1, 1001, '2024-10-01', '2024-10-15'),
    ('978-0134685991', 2, 1002, '2024-10-05', '2024-10-19'),
    ('978-1449355739', 1, 1003, '2024-10-10', '2024-10-24'),
    ('978-0596007126', 1, 1004, '2024-09-15', '2024-09-29'),  -- Vencido
    ('978-0321573513', 1, 1005, '2024-09-20', '2024-10-04');  -- Vencido
GO

-- Procedimiento con cursor para procesar préstamos vencidos
CREATE PROCEDURE sp_ProcesarPrestamosVencidos
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @prestamo_id INT, @isbn VARCHAR(20), @num_miembro INT;
    DECLARE @fecha_venc DATE, @dias_retraso INT;
    DECLARE @multa DECIMAL(10,2);
    DECLARE @total_procesados INT = 0;
    
    -- Declarar cursor para préstamos vencidos activos
    DECLARE cursor_vencidos CURSOR FOR
        SELECT PrestamoID, ISBN, NumMiembro, FechaVencimiento
        FROM Prestamos
        WHERE Estado = 'Activo' 
          AND FechaVencimiento < GETDATE()
          AND FechaDevolucion IS NULL
        ORDER BY FechaVencimiento;
    
    OPEN cursor_vencidos;
    
    FETCH NEXT FROM cursor_vencidos 
    INTO @prestamo_id, @isbn, @num_miembro, @fecha_venc;
    
    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- Calcular días de retraso
        SET @dias_retraso = DATEDIFF(DAY, @fecha_venc, GETDATE());
        SET @multa = @dias_retraso * 2.50;  -- $2.50 por día
        
        -- Actualizar estado del préstamo
        UPDATE Prestamos
        SET Estado = 'Vencido'
        WHERE CURRENT OF cursor_vencidos;
        
        -- Registrar multa (tabla ficticia)
        -- INSERT INTO Multas (PrestamoID, Monto, FechaGeneracion) 
        -- VALUES (@prestamo_id, @multa, GETDATE());
        
        -- Enviar notificación (simulado)
        PRINT 'NOTIFICACIÓN - Miembro: ' + CAST(@num_miembro AS VARCHAR) + 
              ' | ISBN: ' + @isbn + 
              ' | Días retraso: ' + CAST(@dias_retraso AS VARCHAR) + 
              ' | Multa: $' + CAST(@multa AS VARCHAR(10));
        
        SET @total_procesados = @total_procesados + 1;
        
        FETCH NEXT FROM cursor_vencidos 
        INTO @prestamo_id, @isbn, @num_miembro, @fecha_venc;
    END
    
    CLOSE cursor_vencidos;
    DEALLOCATE cursor_vencidos;
    
    PRINT '';
    PRINT 'Total de préstamos procesados: ' + CAST(@total_procesados AS VARCHAR);
END;
GO

-- Ejecutar el procedimiento
EXEC sp_ProcesarPrestamosVencidos;
GO

-- Verificar resultados
SELECT * FROM Prestamos;
GO
```

---

### Ejemplo 2: Generación de Reporte con Formato

```sql
-- Escenario: Generar reporte de ventas por vendedor con formato especial

USE AdventureWorks;
GO

CREATE PROCEDURE sp_ReporteVentasPorVendedor
    @Anio INT
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @vendedor_id INT, @nombre_vendedor NVARCHAR(100);
    DECLARE @total_ventas MONEY, @num_ordenes INT;
    DECLARE @ranking INT = 0;
    
    PRINT '═══════════════════════════════════════════════════════════════';
    PRINT '     REPORTE ANUAL DE VENTAS - AÑO ' + CAST(@Anio AS VARCHAR);
    PRINT '═══════════════════════════════════════════════════════════════';
    PRINT '';
    
    -- Cursor para vendedores ordenados por total de ventas
    DECLARE cursor_vendedores CURSOR FOR
        SELECT 
            v.VendedorID,
            v.Nombre,
            COUNT(o.OrderID) AS NumOrdenes,
            ISNULL(SUM(o.Total), 0) AS TotalVentas
        FROM Vendedores v
        LEFT JOIN Orders o ON v.VendedorID = o.VendedorID 
            AND YEAR(o.OrderDate) = @Anio
        GROUP BY v.VendedorID, v.Nombre
        HAVING ISNULL(SUM(o.Total), 0) > 0
        ORDER BY TotalVentas DESC;
    
    OPEN cursor_vendedores;
    
    FETCH NEXT FROM cursor_vendedores 
    INTO @vendedor_id, @nombre_vendedor, @num_ordenes, @total_ventas;
    
    WHILE @@FETCH_STATUS = 0
    BEGIN
        SET @ranking = @ranking + 1;
        
        -- Imprimir con formato
        PRINT REPLICATE(' ', 3 - LEN(CAST(@ranking AS VARCHAR))) + 
              CAST(@ranking AS VARCHAR) + '. ' + 
              @nombre_vendedor + 
              REPLICATE(' ', 40 - LEN(@nombre_vendedor)) +
              ' Órdenes: ' + CAST(@num_ordenes AS VARCHAR) +
              ' | Total: $' + CAST(@total_ventas AS VARCHAR);
        
        -- Asteriscos por cada $10,000
        DECLARE @estrellas INT = FLOOR(@total_ventas / 10000);
        IF @estrellas > 0
            PRINT '     ' + REPLICATE('★', @estrellas);
        
        PRINT '';
        
        FETCH NEXT FROM cursor_vendedores 
        INTO @vendedor_id, @nombre_vendedor, @num_ordenes, @total_ventas;
    END
    
    CLOSE cursor_vendedores;
    DEALLOCATE cursor_vendedores;
    
    PRINT '═══════════════════════════════════════════════════════════════';
END;
GO
```

---

### Ejemplo 3: Procesamiento Complejo con Múltiples Cursores (Anidados)

```sql
-- Escenario: Generar órdenes de compra automáticas para productos con stock bajo

CREATE PROCEDURE sp_GenerarOrdenesCompra
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @producto_id INT, @nombre_producto NVARCHAR(100);
    DECLARE @stock_actual INT, @stock_minimo INT, @cantidad_ordenar INT;
    DECLARE @proveedor_id INT, @nombre_proveedor NVARCHAR(100);
    DECLARE @precio_compra MONEY;
    DECLARE @num_ordenes_generadas INT = 0;
    
    -- Cursor externo: Productos con stock bajo
    DECLARE cursor_productos CURSOR FOR
        SELECT ProductID, ProductName, Stock, StockMinimo
        FROM Products
        WHERE Stock < StockMinimo
          AND Discontinued = 0;
    
    OPEN cursor_productos;
    
    FETCH NEXT FROM cursor_productos 
    INTO @producto_id, @nombre_producto, @stock_actual, @stock_minimo;
    
    WHILE @@FETCH_STATUS = 0
    BEGIN
        SET @cantidad_ordenar = (@stock_minimo * 2) - @stock_actual;
        
        PRINT 'Producto: ' + @nombre_producto + 
              ' | Stock: ' + CAST(@stock_actual AS VARCHAR) + 
              ' | Cantidad a ordenar: ' + CAST(@cantidad_ordenar AS VARCHAR);
        
        -- Cursor interno: Proveedores del producto
        DECLARE cursor_proveedores CURSOR FOR
            SELECT s.SupplierID, s.CompanyName, ps.UnitPrice
            FROM ProductSuppliers ps
            INNER JOIN Suppliers s ON ps.SupplierID = s.SupplierID
            WHERE ps.ProductID = @producto_id
            ORDER BY ps.UnitPrice ASC;  -- Ordenar por precio
        
        OPEN cursor_proveedores;
        
        FETCH NEXT FROM cursor_proveedores 
        INTO @proveedor_id, @nombre_proveedor, @precio_compra;
        
        IF @@FETCH_STATUS = 0
        BEGIN
            -- Generar orden de compra con el proveedor más barato
            INSERT INTO PurchaseOrders (SupplierID, OrderDate, Status)
            VALUES (@proveedor_id, GETDATE(), 'Pendiente');
            
            DECLARE @orden_id INT = SCOPE_IDENTITY();
            
            INSERT INTO PurchaseOrderDetails (PurchaseOrderID, ProductID, Quantity, UnitPrice)
            VALUES (@orden_id, @producto_id, @cantidad_ordenar, @precio_compra);
            
            PRINT '  → Orden generada con proveedor: ' + @nombre_proveedor + 
                  ' | Precio unitario: $' + CAST(@precio_compra AS VARCHAR) +
                  ' | Total: $' + CAST(@cantidad_ordenar * @precio_compra AS VARCHAR(10));
            
            SET @num_ordenes_generadas = @num_ordenes_generadas + 1;
        END
        ELSE
        BEGIN
            PRINT '  → ERROR: No hay proveedores disponibles para este producto';
        END
        
        CLOSE cursor_proveedores;
        DEALLOCATE cursor_proveedores;
        
        PRINT '';
        
        FETCH NEXT FROM cursor_productos 
        INTO @producto_id, @nombre_producto, @stock_actual, @stock_minimo;
    END
    
    CLOSE cursor_productos;
    DEALLOCATE cursor_productos;
    
    PRINT '═══════════════════════════════════════════════════════════════';
    PRINT 'Total de órdenes de compra generadas: ' + CAST(@num_ordenes_generadas AS VARCHAR);
END;
GO
```

---

## 14. Ejercicios Prácticos

### Ejercicio 1: Básico - Listar Empleados

Crear un cursor que recorra la tabla `Employees` y muestre el nombre completo de cada empleado.

```sql
-- Tu código aquí
```

### Ejercicio 2: Intermedio - Actualización Condicional

Crear un cursor que aumente el salario de empleados según su antigüedad:
- Menos de 5 años: +5%
- 5-10 años: +10%
- Más de 10 años: +15%

```sql
-- Tu código aquí
```

### Ejercicio 3: Avanzado - Cursor con Navegación

Crear un cursor SCROLL que:
1. Muestre los primeros 3 empleados
2. Muestre los últimos 3 empleados
3. Muestre el empleado en la posición 10
4. Retroceda 5 posiciones y muestre ese empleado

```sql
-- Tu código aquí
```

### Ejercicio 4: Experto - Cursores Anidados

Crear un procedimiento que genere un reporte de ventas:
- Cursor externo: Recorre categorías de productos
- Cursor interno: Recorre productos de cada categoría
- Calcular totales por categoría y gran total

```sql
-- Tu código aquí
```

---

## 15. Resumen y Conclusiones

### 📌 Puntos Clave

1. **Los cursores permiten procesamiento fila por fila** en SQL Server
2. **Tipos principales**: STATIC, DYNAMIC, KEYSET, FAST_FORWARD
3. **Ciclo de vida**: DECLARE → OPEN → FETCH → CLOSE → DEALLOCATE
4. **@@FETCH_STATUS** indica el resultado de la operación FETCH
5. **WHERE CURRENT OF** permite UPDATE/DELETE de la fila actual
6. **SCROLL vs FORWARD_ONLY**: navegación completa vs solo adelante
7. **LOCAL vs GLOBAL**: ámbito del cursor
8. **Alternativas basadas en conjuntos** suelen ser más eficientes

### ⚠️ Advertencias Finales

- ❌ **Evitar cursores cuando sea posible** (operaciones basadas en conjuntos son más rápidas)
- ❌ **No olvidar CLOSE y DEALLOCATE** (evitar memory leaks)
- ❌ **Cuidado con cursores anidados** (pueden ser muy lentos)
- ✅ **Usar FAST_FORWARD cuando solo se necesite lectura secuencial**
- ✅ **Considerar CTEs, funciones de ventana y tablas temporales** como alternativas

### 📚 Recursos Adicionales

- [Documentación oficial de Microsoft: Cursores](https://learn.microsoft.com/en-us/sql/t-sql/language-elements/cursors-transact-sql)
- [Best Practices for Using Cursors](https://learn.microsoft.com/en-us/previous-versions/sql/sql-server-2008-r2/ms180169(v=sql.105))
- [Alternatives to Cursors](https://www.sqlshack.com/sql-server-cursor-overview-and-alternatives/)

---

**Última actualización**: Noviembre 2024  
**Materia**: Taller de Base de Datos  
**Sistema de Base de Datos**: Microsoft SQL Server (T-SQL)
