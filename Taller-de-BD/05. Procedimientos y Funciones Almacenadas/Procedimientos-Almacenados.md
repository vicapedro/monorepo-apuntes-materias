# Procedimientos Almacenados en SQL Server

**Taller de Base de Datos**

---

## Tabla de Contenidos

1. [Introducción a los Procedimientos Almacenados](#1-introducción-a-los-procedimientos-almacenados)
2. [Sintaxis y Creación](#2-sintaxis-y-creación)
3. [Parámetros de Entrada y Salida](#3-parámetros-de-entrada-y-salida)
4. [Ejecución de Procedimientos](#4-ejecución-de-procedimientos)
5. [Modificación y Eliminación](#5-modificación-y-eliminación)
6. [Manejo de Errores](#6-manejo-de-errores)
7. [Funciones Definidas por el Usuario](#7-funciones-definidas-por-el-usuario)
8. [Mejores Prácticas](#8-mejores-prácticas)
9. [Ejemplos Completos](#9-ejemplos-completos)
10. [Ejercicios Prácticos](#10-ejercicios-prácticos)
11. [Referencia Rápida](#11-referencia-rápida)

---

## 1. Introducción a los Procedimientos Almacenados

### ¿Qué es un Procedimiento Almacenado?

Un **procedimiento almacenado** (Stored Procedure o SP) es un grupo de instrucciones del lenguaje Transact-SQL que se compilan en un solo plan de ejecución y se almacenan en la base de datos.

**Características principales:**

- Grupo de instrucciones T-SQL compiladas
- Plan de ejecución único almacenado en cache
- Acepta parámetros de entrada
- Regresa valores mediante `RETURN` o parámetros de salida
- Puede modificar tablas de la base de datos
- Regresa múltiples valores mediante parámetros `OUTPUT`

### Ventajas de los Procedimientos Almacenados

#### 1. Encapsulación de Lógica de Negocio

- Las reglas de negocio encapsuladas en procedimientos almacenados pueden cambiarse en un solo lugar
- Todos los clientes usan los mismos procedimientos para garantizar acceso y modificación consistente de datos
- Promueve la reutilización de código

#### 2. Seguridad

- Los usuarios pueden ejecutar un procedimiento almacenado sin tener permisos directos sobre las tablas subyacentes
- Se pueden otorgar permisos específicos solo para ejecutar procedimientos
- Los usuarios nunca necesitan acceder directamente a las tablas si los procedimientos cubren todas sus necesidades

#### 3. Mejora del Rendimiento

- Las instrucciones se compilan en un plan de ejecución que se almacena en cache
- Lógica condicional aplicada a los resultados para determinar qué instrucciones ejecutar
- El plan de ejecución se reutiliza en llamadas subsecuentes
- Reduce el overhead de compilación

#### 4. Reducción del Tráfico de Red

- En lugar de enviar cientos de instrucciones T-SQL por la red, se ejecuta un solo procedimiento
- Reduce el número de peticiones entre cliente y servidor
- Solo se envían parámetros y resultados, no el código SQL completo

### Proceso de Ejecución

```
┌──────────────┐
│   CREACIÓN   │  → Parsing sintáctico
└──────┬───────┘
       │
       v
┌──────────────┐
│ COMPILACIÓN  │  → Optimización del plan de ejecución
└──────┬───────┘
       │
       v
┌──────────────┐
│ ALMACENAMIENTO│ → Entrada en sysobjects y syscomments
└──────┬───────┘     Plan compilado almacenado en cache
       │
       v
┌──────────────┐
│  EJECUCIÓN   │  → Reutilización del plan en cache
└──────────────┘     (o recompilación si es necesario)
```

---

## 2. Sintaxis y Creación

### Sintaxis Básica

```sql
CREATE PROC[EDURE] nombre_procedimiento [ ; numero ]
    [ { @parametro tipo_dato } [ = valor_default ] [ OUTPUT ] 
    ] [ ,...n ]

[ WITH 
    { RECOMPILE | ENCRYPTION | RECOMPILE, ENCRYPTION } ]

AS
BEGIN
    -- Instrucciones T-SQL
END
```

### Parámetros de CREATE PROCEDURE

| Parámetro | Descripción |
|-----------|-------------|
| `nombre_procedimiento` | Nombre único del procedimiento (máx. 128 caracteres) |
| `; numero` | Número opcional para agrupar procedimientos relacionados |
| `@parametro` | Nombre del parámetro (debe iniciar con @) |
| `tipo_dato` | Tipo de dato del parámetro |
| `valor_default` | Valor predeterminado opcional |
| `OUTPUT` | Indica que el parámetro es de salida |
| `WITH RECOMPILE` | Fuerza recompilación en cada ejecución |
| `WITH ENCRYPTION` | Encripta el texto del procedimiento |

### Ejemplo Básico

```sql
USE pubs;
GO

CREATE PROC dbo.overdue_books
AS
BEGIN
    SELECT * 
    FROM dbo.loan
    WHERE due_date < GETDATE();
END
GO
```

### Ejemplo con Opciones

```sql
-- Procedimiento con encriptación y recompilación
CREATE PROCEDURE dbo.sp_SensitiveData
WITH ENCRYPTION, RECOMPILE
AS
BEGIN
    SELECT * FROM ConfidentialTable;
END
GO
```

### Consultar Información de Procedimientos

```sql
-- Usar sp_help para ver información del procedimiento
EXEC sp_help 'dbo.overdue_books';

-- Ver definición del procedimiento
EXEC sp_helptext 'dbo.overdue_books';

-- Listar todos los procedimientos de la base de datos
SELECT name, create_date, modify_date
FROM sys.objects
WHERE type = 'P'  -- P = Stored Procedure
ORDER BY name;

-- Ver parámetros de un procedimiento
SELECT 
    p.name AS ParameterName,
    t.name AS DataType,
    p.max_length AS Length,
    p.is_output AS IsOutput
FROM sys.parameters p
INNER JOIN sys.types t ON p.user_type_id = t.user_type_id
WHERE p.object_id = OBJECT_ID('dbo.overdue_books')
ORDER BY p.parameter_id;
```

---

## 3. Parámetros de Entrada y Salida

### 3.1 Parámetros de Entrada (INPUT)

Los parámetros de entrada permiten pasar valores al procedimiento almacenado.

#### Parámetros con Valores por Defecto

```sql
CREATE PROC dbo.find_isbn 
    @title VARCHAR(100) = NULL, 
    @translation CHAR(8) = 'English'
AS
BEGIN
    IF @title IS NULL 
    BEGIN
        PRINT 'Please provide a title (or partial title) and the translation';
        PRINT 'Example: EXEC find_isbn ''Oliver%'', ''Japanese''';
        RETURN;
    END
    
    SELECT isbn, title, translation
    FROM books
    WHERE title LIKE @title
      AND translation = @translation;
END
GO
```

#### Ejecución con Parámetros

**Opción 1: Paso de valores por posición**

```sql
EXEC find_isbn 'Oliver%', 'Japanese';
```

**Opción 2: Paso de valores por referencia (nombres de parámetros)**

```sql
EXEC find_isbn 
    @title = 'Oliver%',
    @translation = 'Japanese';
```

**Opción 3: Usando valores por defecto**

```sql
-- Usa el valor por defecto de @translation ('English')
EXEC find_isbn @title = 'Oliver%';

-- Usa ambos valores por defecto
EXEC find_isbn;  -- Mostrará el mensaje de error
```

#### Ejemplo Completo: Procedimiento con Múltiples Parámetros

```sql
CREATE PROCEDURE dbo.altas
    @lastname VARCHAR(50),
    @firstname VARCHAR(50),
    @middlename VARCHAR(50) = NULL,
    @street VARCHAR(100),
    @city VARCHAR(50),
    @state CHAR(2),
    @zip VARCHAR(10),
    @phone VARCHAR(20) = NULL
AS
BEGIN
    INSERT INTO customers (lastname, firstname, middlename, street, city, state, zip, phone)
    VALUES (@lastname, @firstname, @middlename, @street, @city, @state, @zip, @phone);
    
    PRINT 'Cliente agregado: ' + @firstname + ' ' + @lastname;
END
GO
```

**Ejecución por posición:**

```sql
EXEC altas 'LaBrie', 'Linda', NULL, 
    'Dogwood Drive', 'Sacramento', 'CA', '94203', NULL;
```

**Ejecución por referencia:**

```sql
EXEC altas
    @firstname = 'Linda',
    @lastname = 'LaBrie',
    @street = 'Dogwood Drive',
    @city = 'Sacramento',
    @state = 'CA',
    @zip = '94203';
```

### 3.2 Parámetros de Salida (OUTPUT)

Los parámetros `OUTPUT` permiten que el procedimiento devuelva valores al programa que lo invoca.

#### Sintaxis Básica

```sql
CREATE PROCEDURE dbo.mathtutor
    @m1 SMALLINT,
    @m2 SMALLINT,
    @result SMALLINT OUTPUT
AS
BEGIN
    SET @result = @m1 * @m2;
END
GO
```

#### Ejecución con Parámetro OUTPUT

```sql
DECLARE @answer SMALLINT;

EXECUTE mathtutor 5, 6, @answer OUTPUT;

SELECT 'The result is: ', @answer;
```

**Resultado:**
```
The result is:  30
```

#### Ejemplo con Múltiples Parámetros OUTPUT

```sql
CREATE PROCEDURE dbo.CalcularEstadisticas
    @producto_id INT,
    @total_vendido INT OUTPUT,
    @ingresos_total MONEY OUTPUT,
    @precio_promedio MONEY OUTPUT
AS
BEGIN
    SELECT 
        @total_vendido = SUM(cantidad),
        @ingresos_total = SUM(cantidad * precio),
        @precio_promedio = AVG(precio)
    FROM ventas
    WHERE producto_id = @producto_id;
END
GO
```

**Uso:**

```sql
DECLARE @total INT, @ingresos MONEY, @promedio MONEY;

EXEC CalcularEstadisticas 
    @producto_id = 101,
    @total_vendido = @total OUTPUT,
    @ingresos_total = @ingresos OUTPUT,
    @precio_promedio = @promedio OUTPUT;

SELECT 
    'Total Vendido' = @total,
    'Ingresos' = @ingresos,
    'Precio Promedio' = @promedio;
```

---

## 4. Ejecución de Procedimientos

### Ejecutar un Procedimiento Independiente

```sql
-- Forma básica
EXEC overdue_books;

-- Forma alternativa
EXECUTE overdue_books;

-- Sin EXEC (solo si es la primera instrucción del batch)
overdue_books;
```

### Ejecutar un Procedimiento dentro de INSERT

```sql
-- Insertar resultados de un procedimiento en una tabla
INSERT INTO customers
EXEC employee_customer;
```

### Ejecutar con Captura de Valor de Retorno

```sql
DECLARE @return_status INT;

EXEC @return_status = checkstate '648-92-1872';

SELECT 'Return Status' = @return_status;
```

### Ejecutar en Otro Servidor (Linked Server)

```sql
-- Ejecutar procedimiento en servidor remoto
EXEC ServerRemoto.BaseDatos.dbo.NombreProcedimiento @param1, @param2;
```

---

## 5. Modificación y Eliminación

### Modificar un Procedimiento (ALTER PROCEDURE)

```sql
ALTER PROC overdue_books
AS
BEGIN
    SELECT 
        CONVERT(CHAR(8), due_date, 1) AS date_due, 
        isbn, 
        copy_no, 
        SUBSTRING(title, 1, 30) AS title, 
        member_no, 
        lastname
    FROM OverdueView
    ORDER BY due_date;
END
GO
```

**Ventajas de ALTER vs DROP/CREATE:**

- Preserva permisos
- Mantiene dependencias
- No requiere volver a otorgar permisos a usuarios

### Eliminar un Procedimiento (DROP PROCEDURE)

```sql
-- Eliminar un solo procedimiento
DROP PROC overdue_books;

-- Eliminar múltiples procedimientos
DROP PROCEDURE proc1, proc2, proc3;

-- Eliminar solo si existe (SQL Server 2016+)
DROP PROCEDURE IF EXISTS overdue_books;
```

### Verificar Existencia Antes de Crear

```sql
-- Patrón común para CREATE OR ALTER
IF OBJECT_ID('dbo.overdue_books', 'P') IS NOT NULL
    DROP PROCEDURE dbo.overdue_books;
GO

CREATE PROCEDURE dbo.overdue_books
AS
BEGIN
    -- Código del procedimiento
END
GO

-- SQL Server 2016+ soporta CREATE OR ALTER directamente
CREATE OR ALTER PROCEDURE dbo.overdue_books
AS
BEGIN
    -- Código del procedimiento
END
GO
```

---

## 6. Manejo de Errores

### 6.1 RETURN

La instrucción `RETURN` se utiliza para:

- Salir inmediatamente del procedimiento
- Devolver un código de estado (entero)
- Manejo de errores

**Sintaxis:**

```sql
RETURN [ integer_expression ]
```

**Ejemplo:**

```sql
CREATE PROCEDURE dbo.checkstate
    @ssn CHAR(11)
AS
BEGIN
    IF NOT EXISTS (SELECT * FROM employees WHERE ssn = @ssn)
    BEGIN
        PRINT 'Employee not found';
        RETURN -1;  -- Código de error
    END
    
    -- Lógica del procedimiento
    
    RETURN 0;  -- Éxito
END
GO
```

**Captura del valor de retorno:**

```sql
DECLARE @return_status INT;

EXEC @return_status = checkstate '648-92-1872';

SELECT 'Return Status' = @return_status;

IF @return_status = -1
    PRINT 'Error: Empleado no encontrado';
ELSE
    PRINT 'Operación exitosa';
```

### 6.2 @@ERROR

Devuelve el número de error de la última instrucción T-SQL ejecutada.

- `@@ERROR = 0`: No hay error
- `@@ERROR <> 0`: Existe un error

**Importante:** `@@ERROR` se resetea después de cada instrucción, por lo que debe capturarse inmediatamente.

**Ejemplo:**

```sql
UPDATE authors 
SET au_id = '172-32-1176' 
WHERE au_id = '172-32-1176';

IF @@ERROR = 547  -- Violación de restricción
    PRINT 'Violación del constraint';
ELSE IF @@ERROR = 0
    PRINT 'Actualización exitosa';
ELSE
    PRINT 'Error: ' + CAST(@@ERROR AS VARCHAR);
```

**Ejemplo con Captura Inmediata:**

```sql
CREATE PROCEDURE dbo.ActualizarInventario
    @producto_id INT,
    @cantidad INT
AS
BEGIN
    DECLARE @error_num INT;
    
    UPDATE productos
    SET stock = stock + @cantidad
    WHERE producto_id = @producto_id;
    
    SET @error_num = @@ERROR;  -- Capturar inmediatamente
    
    IF @error_num <> 0
    BEGIN
        PRINT 'Error al actualizar inventario: ' + CAST(@error_num AS VARCHAR);
        RETURN -1;
    END
    
    PRINT 'Inventario actualizado correctamente';
    RETURN 0;
END
GO
```

### 6.3 RAISERROR

Devuelve un mensaje de error definido por el usuario y establece un indicador del sistema para registrar que se ha producido un error.

**Sintaxis:**

```sql
RAISERROR ( 
    { msg_id | msg_str } , 
    severity , 
    state 
    [ , argument [ ,...n ] ]
) 
[ WITH option [ ,...n ] ]
```

**Componentes:**

| Componente | Descripción |
|------------|-------------|
| **msg_id** | Número de error (50001 - 2,147,483,647) |
| **msg_str** | Mensaje de error (cadena de hasta 2,047 caracteres) |
| **severity** | Nivel de severidad (0-25) |
| **state** | Indicador de estado (1-127) para ubicar el error |
| **argument** | Parámetros para formatear el mensaje |
| **WITH LOG** | Registra el error en el log de eventos |
| **WITH NOWAIT** | Envía el mensaje inmediatamente al cliente |

#### Niveles de Severidad

| Nivel | Descripción |
|-------|-------------|
| **0-10** | Mensajes informativos |
| **11-16** | Errores que el usuario puede corregir |
| **17-19** | Problemas de hardware o del sistema |
| **20-25** | Errores graves del sistema (solo sysadmin) |

#### Ejemplos de RAISERROR

**Ejemplo 1: Mensaje simple**

```sql
RAISERROR ('Este es un mensaje de error.', 10, 1);
```

**Ejemplo 2: Mensaje con parámetros**

```sql
RAISERROR ('El empleado %s no existe.', 10, 1, 'A1');
```

**Marcadores de formato:**

- `%d` o `%i`: Enteros con signo
- `%s`: Cadenas de caracteres
- `%u`: Enteros sin signo
- `%f`: Números de punto flotante

**Ejemplo 3: Error con severidad alta**

```sql
CREATE PROCEDURE dbo.ValidarCliente
    @cliente_id INT
AS
BEGIN
    IF NOT EXISTS (SELECT * FROM clientes WHERE cliente_id = @cliente_id)
    BEGIN
        RAISERROR ('Cliente %d no encontrado en la base de datos.', 16, 1, @cliente_id);
        RETURN -1;
    END
    
    PRINT 'Cliente válido';
    RETURN 0;
END
GO
```

**Ejemplo 4: Error con opción LOG**

```sql
-- Registrar error en el log de eventos de Windows
RAISERROR ('Error crítico en el sistema.', 16, 1) WITH LOG;
```

### 6.4 sp_addmessage

Permite agregar mensajes de error personalizados a la tabla del sistema `sys.messages`.

**Sintaxis:**

```sql
sp_addmessage 
    [ @msgnum = ] msg_id , 
    [ @severity = ] severity , 
    [ @msgtext = ] 'msg' 
    [ , [ @lang = ] 'language' ]  
    [ , [ @with_log = ] { 'true' | 'false' } ]
```

**Ejemplo:**

```sql
-- Agregar mensaje personalizado
EXEC sp_addmessage 
    @msgnum = 52001, 
    @severity = 16, 
    @msgtext = 'Cliente inválido';

-- Usar el mensaje
RAISERROR (52001, 16, 1);
```

**Ejemplo con parámetros:**

```sql
-- Agregar mensaje con marcadores
EXEC sp_addmessage 
    @msgnum = 52002, 
    @severity = 16, 
    @msgtext = 'Cliente %s inválido';

-- Usar con parámetro
RAISERROR (52002, 16, 1, 'juan');
```

**Ver mensajes personalizados:**

```sql
SELECT message_id, severity, text
FROM sys.messages
WHERE message_id >= 50000  -- Mensajes personalizados
ORDER BY message_id;
```

**Eliminar mensaje personalizado:**

```sql
EXEC sp_dropmessage @msgnum = 52001;
```

### 6.5 TRY...CATCH (Recomendado para SQL Server 2005+)

El manejo estructurado de excepciones es la forma moderna y recomendada.

```sql
CREATE PROCEDURE dbo.TransferirFondos
    @cuenta_origen INT,
    @cuenta_destino INT,
    @monto MONEY
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Retirar de cuenta origen
        UPDATE cuentas
        SET saldo = saldo - @monto
        WHERE cuenta_id = @cuenta_origen;
        
        -- Verificar saldo suficiente
        IF (SELECT saldo FROM cuentas WHERE cuenta_id = @cuenta_origen) < 0
        BEGIN
            RAISERROR ('Saldo insuficiente', 16, 1);
        END
        
        -- Depositar en cuenta destino
        UPDATE cuentas
        SET saldo = saldo + @monto
        WHERE cuenta_id = @cuenta_destino;
        
        COMMIT TRANSACTION;
        
        PRINT 'Transferencia exitosa';
        RETURN 0;
        
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();
        
        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
        
        RETURN -1;
    END CATCH
END
GO
```

**Funciones de error en CATCH:**

| Función | Descripción |
|---------|-------------|
| `ERROR_NUMBER()` | Número del error |
| `ERROR_MESSAGE()` | Texto del mensaje de error |
| `ERROR_SEVERITY()` | Severidad del error |
| `ERROR_STATE()` | Estado del error |
| `ERROR_LINE()` | Número de línea donde ocurrió |
| `ERROR_PROCEDURE()` | Nombre del procedimiento |

---

## 7. Funciones Definidas por el Usuario

Las funciones definidas por el usuario (UDF) complementan los procedimientos almacenados con características especiales.

### Características de las Funciones

- Siempre regresan un valor (escalar o tabla)
- Pueden ser llamadas desde un `SELECT`
- Pueden utilizarse como constraints o valores por defecto
- No pueden modificar datos (INSERT, UPDATE, DELETE)
- No pueden usar TRY...CATCH

### 7.1 Funciones Escalares

Regresan un solo valor de un tipo de dato específico.

**Sintaxis:**

```sql
CREATE FUNCTION nombre_funcion 
    ( [ @parametro tipo_dato [ ,...n ] ] )
RETURNS tipo_dato_retorno
AS
BEGIN
    -- Lógica de la función
    RETURN valor;
END
```

**Ejemplo 1: Concatenar órdenes de un cliente**

```sql
CREATE FUNCTION dbo.fn_ConcatOrders
    (@cid AS NCHAR(5)) 
RETURNS VARCHAR(8000)
AS
BEGIN
    DECLARE @orders AS VARCHAR(8000);
    SET @orders = '';
    
    SELECT @orders = @orders + CAST(OrderID AS VARCHAR(10)) + ';'
    FROM dbo.Orders
    WHERE CustomerID = @cid;

    RETURN @orders;
END
GO

-- Uso en SELECT
SELECT 
    CustomerID, 
    dbo.fn_ConcatOrders(CustomerID) AS Orders
FROM dbo.Customers;
```

**Ejemplo 2: Obtener siguiente clave**

```sql
CREATE FUNCTION dbo.fn_T1_getkey() 
RETURNS INT
AS
BEGIN
    RETURN
        CASE
            WHEN NOT EXISTS (SELECT * FROM dbo.T1 WHERE keycol = 1)   
                THEN 1
            ELSE (SELECT MAX(keycol) + 1 FROM dbo.T1)   
        END;
END
GO
```

### 7.2 Funciones de Tabla

Regresan una tabla como resultado.

**Funciones de Tabla Inline (recomendadas):**

```sql
CREATE FUNCTION dbo.fn_GetCustOrders
    (@cid AS NCHAR(5)) 
RETURNS TABLE
AS
RETURN
    SELECT 
        OrderID, CustomerID, EmployeeID, OrderDate, 
        RequiredDate, ShippedDate, ShipVia, Freight
    FROM dbo.Orders
    WHERE CustomerID = @cid;
GO

-- Uso
SELECT * FROM dbo.fn_GetCustOrders('ALFKI');

-- Uso en JOIN
SELECT c.CustomerName, o.*
FROM Customers c
CROSS APPLY dbo.fn_GetCustOrders(c.CustomerID) o;
```

**Funciones de Tabla Multi-Statement:**

```sql
CREATE FUNCTION dbo.fn_GetEmployeeHierarchy
    (@manager_id INT)
RETURNS @result TABLE
(
    EmployeeID INT,
    EmployeeName NVARCHAR(100),
    Level INT
)
AS
BEGIN
    -- Insertar manager
    INSERT INTO @result
    SELECT EmployeeID, Name, 0
    FROM Employees
    WHERE EmployeeID = @manager_id;
    
    -- Insertar subordinados directos
    INSERT INTO @result
    SELECT EmployeeID, Name, 1
    FROM Employees
    WHERE ManagerID = @manager_id;
    
    RETURN;
END
GO
```

### 7.3 Funciones como Constraints

```sql
-- Crear tabla con función como DEFAULT
CREATE TABLE dbo.T1
(
    keycol INT NOT NULL 
        CONSTRAINT PK_T1 PRIMARY KEY 
        CHECK (keycol > 0),
    datacol VARCHAR(10) NOT NULL
);

-- Agregar DEFAULT usando función
ALTER TABLE dbo.T1 
ADD DEFAULT (dbo.fn_T1_getkey()) FOR keycol;

-- Ahora los INSERT no requieren especificar keycol
INSERT INTO dbo.T1 (datacol) VALUES ('a');
INSERT INTO dbo.T1 (datacol) VALUES ('b');

SELECT * FROM dbo.T1;
```

### 7.4 Diferencias: Procedimientos vs Funciones

| Característica | Procedimientos | Funciones |
|----------------|----------------|-----------|
| **Valor de retorno** | Opcional (RETURN, OUTPUT) | Obligatorio |
| **Tipo de retorno** | Solo entero (RETURN) | Escalar o tabla |
| **Uso en SELECT** | No | Sí |
| **Modificación de datos** | Sí (INSERT, UPDATE, DELETE) | No |
| **Transacciones** | Sí | Limitado |
| **TRY...CATCH** | Sí | No |
| **OUTPUT parameters** | Sí | No |

---

## 8. Mejores Prácticas

### Guía para Crear Procedimientos Almacenados

1. **Propietario dbo**: El usuario `dbo` debe ser el propietario de todos los procedimientos almacenados para evitar problemas de permisos.

   ```sql
   -- Correcto
   CREATE PROCEDURE dbo.MiProcedimiento
   AS
   BEGIN
       -- Código
   END
   
   -- Incorrecto (sin esquema)
   CREATE PROCEDURE MiProcedimiento  -- Se crea en el esquema del usuario actual
   AS
   BEGIN
       -- Código
   END
   ```

2. **Un procedimiento, una tarea**: Cada procedimiento debe realizar una tarea específica y bien definida.

3. **Evitar prefijo "sp_"**: Los procedimientos que comienzan con `sp_` se buscan primero en la base de datos `master`, lo que afecta el rendimiento.

   ```sql
   -- Evitar
   CREATE PROCEDURE sp_GetCustomers  -- SQL Server busca primero en master
   
   -- Mejor
   CREATE PROCEDURE usp_GetCustomers  -- usp = User Stored Procedure
   ```

4. **Minimizar procedimientos temporales**: Los procedimientos temporales (`#temp`, `##temp`) consumen recursos en `tempdb`.

5. **Usar SET NOCOUNT ON**: Reduce el tráfico de red al eliminar mensajes de "n filas afectadas".

   ```sql
   CREATE PROCEDURE dbo.usp_InsertCustomer
       @name VARCHAR(100)
   AS
   BEGIN
       SET NOCOUNT ON;  -- Buena práctica
       
       INSERT INTO Customers (Name) VALUES (@name);
   END
   ```

6. **Validar parámetros**: Siempre validar los parámetros de entrada.

   ```sql
   CREATE PROCEDURE dbo.usp_UpdatePrice
       @product_id INT,
       @new_price MONEY
   AS
   BEGIN
       SET NOCOUNT ON;
       
       -- Validaciones
       IF @product_id IS NULL OR @product_id <= 0
       BEGIN
           RAISERROR ('ID de producto inválido', 16, 1);
           RETURN -1;
       END
       
       IF @new_price IS NULL OR @new_price < 0
       BEGIN
           RAISERROR ('Precio inválido', 16, 1);
           RETURN -1;
       END
       
       -- Lógica principal
       UPDATE Products
       SET Price = @new_price
       WHERE ProductID = @product_id;
   END
   ```

7. **Usar transacciones cuando sea necesario**:

   ```sql
   CREATE PROCEDURE dbo.usp_ProcessOrder
       @order_id INT
   AS
   BEGIN
       SET NOCOUNT ON;
       
       BEGIN TRY
           BEGIN TRANSACTION;
           
           -- Múltiples operaciones que deben ser atómicas
           UPDATE Orders SET Status = 'Processing' WHERE OrderID = @order_id;
           INSERT INTO OrderLog (OrderID, Action) VALUES (@order_id, 'Started');
           
           COMMIT TRANSACTION;
       END TRY
       BEGIN CATCH
           IF @@TRANCOUNT > 0
               ROLLBACK TRANSACTION;
           
           THROW;  -- Re-lanzar el error
       END CATCH
   END
   ```

8. **Documentar el código**:

   ```sql
   /*
   ===========================================================================
   Procedimiento: dbo.usp_GetCustomerOrders
   Descripción:   Obtiene las órdenes de un cliente específico
   Parámetros:    @customer_id - ID del cliente
                  @date_from - Fecha inicial (opcional)
                  @date_to - Fecha final (opcional)
   Retorna:       0 = Éxito, -1 = Error
   Autor:         [Nombre]
   Fecha:         2025-11-10
   Ejemplo:       EXEC dbo.usp_GetCustomerOrders @customer_id = 123;
   ===========================================================================
   */
   CREATE PROCEDURE dbo.usp_GetCustomerOrders
       @customer_id INT,
       @date_from DATE = NULL,
       @date_to DATE = NULL
   AS
   BEGIN
       SET NOCOUNT ON;
       
       -- Código del procedimiento
   END
   ```

9. **Evitar SELECT * en producción**:

   ```sql
   -- Evitar
   SELECT * FROM Customers;
   
   -- Mejor
   SELECT CustomerID, Name, Email, Phone FROM Customers;
   ```

10. **Considerar recompilación selectiva**: Usar `WITH RECOMPILE` solo cuando sea necesario (datos muy cambiantes).

---

## 9. Ejemplos Completos

### Ejemplo 1: Sistema de Biblioteca - Préstamos Vencidos

```sql
-- Procedimiento para obtener libros con préstamos vencidos
CREATE PROCEDURE dbo.usp_GetOverdueBooks
    @days_overdue INT = 0
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT 
        l.loan_id,
        l.isbn,
        b.title,
        l.member_no,
        m.lastname + ', ' + m.firstname AS member_name,
        l.due_date,
        DATEDIFF(DAY, l.due_date, GETDATE()) AS days_late,
        DATEDIFF(DAY, l.due_date, GETDATE()) * 2.50 AS fine_amount
    FROM loan l
    INNER JOIN books b ON l.isbn = b.isbn
    INNER JOIN members m ON l.member_no = m.member_no
    WHERE l.return_date IS NULL
      AND l.due_date < GETDATE()
      AND DATEDIFF(DAY, l.due_date, GETDATE()) >= @days_overdue
    ORDER BY l.due_date;
END
GO

-- Ejecución
EXEC dbo.usp_GetOverdueBooks;  -- Todos los vencidos
EXEC dbo.usp_GetOverdueBooks @days_overdue = 7;  -- Vencidos por más de 7 días
```

### Ejemplo 2: Gestión de Inventario

```sql
-- Procedimiento para actualizar inventario con validaciones
CREATE PROCEDURE dbo.usp_UpdateInventory
    @product_id INT,
    @quantity_change INT,
    @movement_type VARCHAR(20),  -- 'SALE', 'PURCHASE', 'ADJUSTMENT'
    @notes VARCHAR(200) = NULL,
    @new_stock INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @current_stock INT;
    DECLARE @min_stock INT;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Obtener stock actual
        SELECT @current_stock = stock, @min_stock = min_stock
        FROM products
        WHERE product_id = @product_id;
        
        -- Validar que el producto existe
        IF @current_stock IS NULL
        BEGIN
            RAISERROR ('Producto %d no encontrado', 16, 1, @product_id);
            RETURN -1;
        END
        
        -- Validar que no resulte en stock negativo
        IF @current_stock + @quantity_change < 0
        BEGIN
            RAISERROR ('Stock insuficiente. Stock actual: %d, Cambio solicitado: %d', 
                       16, 1, @current_stock, @quantity_change);
            RETURN -1;
        END
        
        -- Actualizar stock
        UPDATE products
        SET stock = stock + @quantity_change,
            last_updated = GETDATE()
        WHERE product_id = @product_id;
        
        SET @new_stock = @current_stock + @quantity_change;
        
        -- Registrar movimiento en tabla de auditoría
        INSERT INTO inventory_movements 
            (product_id, movement_type, quantity, stock_before, stock_after, notes, created_at)
        VALUES 
            (@product_id, @movement_type, @quantity_change, @current_stock, @new_stock, @notes, GETDATE());
        
        -- Alertar si está por debajo del stock mínimo
        IF @new_stock < @min_stock
        BEGIN
            PRINT 'ADVERTENCIA: El producto ' + CAST(@product_id AS VARCHAR) + 
                  ' está por debajo del stock mínimo (' + CAST(@min_stock AS VARCHAR) + ')';
        END
        
        COMMIT TRANSACTION;
        
        RETURN 0;
        
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR (@ErrorMessage, 16, 1);
        
        RETURN -1;
    END CATCH
END
GO

-- Uso del procedimiento
DECLARE @stock_resultante INT;
DECLARE @resultado INT;

EXEC @resultado = dbo.usp_UpdateInventory
    @product_id = 101,
    @quantity_change = -5,
    @movement_type = 'SALE',
    @notes = 'Venta en mostrador',
    @new_stock = @stock_resultante OUTPUT;

IF @resultado = 0
    PRINT 'Stock actualizado. Nuevo stock: ' + CAST(@stock_resultante AS VARCHAR);
ELSE
    PRINT 'Error al actualizar inventario';
```

### Ejemplo 3: Procedimiento con Cursor (Procesamiento por Lotes)

```sql
-- Procedimiento para aplicar aumentos de precio por categoría
CREATE PROCEDURE dbo.usp_ApplyPriceIncrease
    @category_id INT,
    @increase_percent DECIMAL(5,2),
    @affected_products INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @product_id INT;
    DECLARE @old_price MONEY;
    DECLARE @new_price MONEY;
    
    SET @affected_products = 0;
    
    -- Cursor para recorrer productos de la categoría
    DECLARE product_cursor CURSOR FOR
        SELECT product_id, price
        FROM products
        WHERE category_id = @category_id
          AND discontinued = 0;
    
    OPEN product_cursor;
    
    FETCH NEXT FROM product_cursor INTO @product_id, @old_price;
    
    BEGIN TRY
        WHILE @@FETCH_STATUS = 0
        BEGIN
            -- Calcular nuevo precio
            SET @new_price = @old_price * (1 + @increase_percent / 100.0);
            
            -- Actualizar precio
            UPDATE products
            SET price = @new_price,
                last_updated = GETDATE()
            WHERE product_id = @product_id;
            
            -- Registrar cambio en auditoría
            INSERT INTO price_changes (product_id, old_price, new_price, change_date, reason)
            VALUES (@product_id, @old_price, @new_price, GETDATE(), 
                    'Aumento por categoría: ' + CAST(@increase_percent AS VARCHAR) + '%');
            
            SET @affected_products = @affected_products + 1;
            
            FETCH NEXT FROM product_cursor INTO @product_id, @old_price;
        END
    END TRY
    BEGIN CATCH
        CLOSE product_cursor;
        DEALLOCATE product_cursor;
        
        RAISERROR ('Error al aplicar aumentos de precio', 16, 1);
        RETURN -1;
    END CATCH
    
    CLOSE product_cursor;
    DEALLOCATE product_cursor;
    
    PRINT CAST(@affected_products AS VARCHAR) + ' productos actualizados';
    
    RETURN 0;
END
GO

-- Uso
DECLARE @productos_afectados INT;

EXEC dbo.usp_ApplyPriceIncrease
    @category_id = 5,
    @increase_percent = 10.0,
    @affected_products = @productos_afectados OUTPUT;

PRINT 'Total de productos actualizados: ' + CAST(@productos_afectados AS VARCHAR);
```

### Ejemplo 4: Procedimiento con Tabla Temporal

```sql
-- Procedimiento para generar reporte de ventas con subtotales
CREATE PROCEDURE dbo.usp_SalesReport
    @start_date DATE,
    @end_date DATE
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Crear tabla temporal para resultados
    CREATE TABLE #SalesReport
    (
        category_name VARCHAR(50),
        product_name VARCHAR(100),
        quantity_sold INT,
        total_revenue MONEY,
        avg_price MONEY
    );
    
    -- Insertar datos del reporte
    INSERT INTO #SalesReport
    SELECT 
        c.category_name,
        p.product_name,
        SUM(od.quantity) AS quantity_sold,
        SUM(od.quantity * od.unit_price) AS total_revenue,
        AVG(od.unit_price) AS avg_price
    FROM order_details od
    INNER JOIN products p ON od.product_id = p.product_id
    INNER JOIN categories c ON p.category_id = c.category_id
    INNER JOIN orders o ON od.order_id = o.order_id
    WHERE o.order_date BETWEEN @start_date AND @end_date
    GROUP BY c.category_name, p.product_name;
    
    -- Mostrar reporte
    SELECT * FROM #SalesReport
    ORDER BY category_name, total_revenue DESC;
    
    -- Mostrar totales por categoría
    SELECT 
        category_name,
        SUM(quantity_sold) AS total_quantity,
        SUM(total_revenue) AS total_revenue
    FROM #SalesReport
    GROUP BY category_name
    ORDER BY total_revenue DESC;
    
    -- Mostrar gran total
    SELECT 
        'TOTAL GENERAL' AS category_name,
        SUM(quantity_sold) AS total_quantity,
        SUM(total_revenue) AS total_revenue
    FROM #SalesReport;
    
    -- Limpiar tabla temporal
    DROP TABLE #SalesReport;
END
GO

-- Ejecución
EXEC dbo.usp_SalesReport 
    @start_date = '2025-01-01',
    @end_date = '2025-01-31';
```

---

## 10. Ejercicios Prácticos

### Ejercicio 1: Procedimiento Básico

**Objetivo:** Crear un procedimiento que liste todos los empleados de un departamento específico.

**Requisitos:**
- Parámetro de entrada: `@department_id`
- Mostrar: ID, nombre completo, puesto, salario
- Ordenar por salario descendente

```sql
-- Escriba su solución aquí
CREATE PROCEDURE dbo.usp_ListEmployeesByDepartment
    @department_id INT
AS
BEGIN
    -- Su código
END
GO
```

### Ejercicio 2: Parámetros de Entrada con Valores por Defecto

**Objetivo:** Crear un procedimiento para buscar productos.

**Requisitos:**
- Parámetro `@product_name` (opcional, busca por nombre parcial)
- Parámetro `@category_id` (opcional)
- Parámetro `@min_price` (opcional, por defecto 0)
- Parámetro `@max_price` (opcional, por defecto 999999)
- Si no se proporciona ningún parámetro, mostrar mensaje de ayuda

```sql
-- Escriba su solución aquí
```

### Ejercicio 3: Parámetros OUTPUT

**Objetivo:** Crear un procedimiento que registre una venta y devuelva información.

**Requisitos:**
- Parámetros de entrada: `@customer_id`, `@product_id`, `@quantity`
- Parámetros OUTPUT: `@order_id`, `@total_amount`, `@new_stock`
- Validar stock disponible
- Actualizar inventario
- Insertar orden en tabla de ventas
- Manejar errores con TRY...CATCH

```sql
-- Escriba su solución aquí
```

### Ejercicio 4: Manejo de Errores Completo

**Objetivo:** Crear un procedimiento para transferir stock entre almacenes.

**Requisitos:**
- Parámetros: `@product_id`, `@from_warehouse`, `@to_warehouse`, `@quantity`
- Validar que ambos almacenes existan
- Validar stock suficiente en almacén origen
- Usar transacciones
- Registrar movimiento en tabla de auditoría
- Retornar código de estado apropiado
- Usar RAISERROR para errores descriptivos

```sql
-- Escriba su solución aquí
```

### Ejercicio 5: Función Escalar

**Objetivo:** Crear una función que calcule el total de ventas de un empleado en un período.

**Requisitos:**
- Parámetros: `@employee_id`, `@start_date`, `@end_date`
- Retornar: Total de ventas (MONEY)
- Usar en un SELECT para mostrar ranking de vendedores

```sql
-- Escriba su solución aquí
```

### Ejercicio 6: Función de Tabla

**Objetivo:** Crear una función que devuelva el historial de precios de un producto.

**Requisitos:**
- Parámetro: `@product_id`
- Retornar tabla con: fecha, precio_anterior, precio_nuevo, porcentaje_cambio
- Ordenar por fecha descendente
- Usar la función en un query con JOIN

```sql
-- Escriba su solución aquí
```

---

## 11. Referencia Rápida

### Comandos Principales

```sql
-- CREAR procedimiento
CREATE PROCEDURE dbo.nombre_proc (@param1 tipo, @param2 tipo OUTPUT)
AS
BEGIN
    -- código
END

-- MODIFICAR procedimiento
ALTER PROCEDURE dbo.nombre_proc (@param1 tipo)
AS
BEGIN
    -- código modificado
END

-- ELIMINAR procedimiento
DROP PROCEDURE dbo.nombre_proc;

-- EJECUTAR procedimiento
EXEC dbo.nombre_proc @param1 = valor;

-- EJECUTAR con OUTPUT
DECLARE @resultado INT;
EXEC dbo.nombre_proc @param1 = valor, @param2 = @resultado OUTPUT;

-- CREAR función escalar
CREATE FUNCTION dbo.nombre_func (@param tipo)
RETURNS tipo_retorno
AS
BEGIN
    RETURN valor;
END

-- CREAR función de tabla
CREATE FUNCTION dbo.nombre_func (@param tipo)
RETURNS TABLE
AS
RETURN
    SELECT columnas FROM tabla WHERE condicion;
```

### Consultas de Administración

```sql
-- Listar todos los procedimientos
SELECT name, create_date, modify_date
FROM sys.objects
WHERE type = 'P'
ORDER BY name;

-- Ver definición de un procedimiento
EXEC sp_helptext 'dbo.nombre_proc';

-- Ver información detallada
EXEC sp_help 'dbo.nombre_proc';

-- Ver parámetros
SELECT 
    p.name AS ParameterName,
    t.name AS DataType,
    p.max_length,
    p.is_output
FROM sys.parameters p
INNER JOIN sys.types t ON p.user_type_id = t.user_type_id
WHERE p.object_id = OBJECT_ID('dbo.nombre_proc')
ORDER BY p.parameter_id;

-- Ver dependencias
EXEC sp_depends 'dbo.nombre_proc';

-- Buscar procedimientos que contienen texto específico
SELECT DISTINCT o.name
FROM sys.sql_modules m
INNER JOIN sys.objects o ON m.object_id = o.object_id
WHERE m.definition LIKE '%texto_buscado%'
  AND o.type = 'P';
```

### Variables del Sistema

| Variable | Descripción |
|----------|-------------|
| `@@ERROR` | Número del último error |
| `@@ROWCOUNT` | Número de filas afectadas |
| `@@IDENTITY` | Último valor de identidad insertado |
| `@@TRANCOUNT` | Número de transacciones activas |
| `@@FETCH_STATUS` | Estado del último FETCH (cursores) |

### Funciones de Error (en CATCH)

| Función | Descripción |
|---------|-------------|
| `ERROR_NUMBER()` | Número del error |
| `ERROR_MESSAGE()` | Mensaje del error |
| `ERROR_SEVERITY()` | Severidad del error |
| `ERROR_STATE()` | Estado del error |
| `ERROR_LINE()` | Línea donde ocurrió |
| `ERROR_PROCEDURE()` | Nombre del procedimiento |

### Niveles de Severidad RAISERROR

| Nivel | Tipo | Descripción |
|-------|------|-------------|
| 0-10 | Informativo | Mensajes informativos |
| 11-16 | Usuario | Errores que el usuario puede corregir |
| 17-19 | Sistema | Problemas de recursos o hardware |
| 20-25 | Fatal | Errores graves del sistema |

---

## Recursos Adicionales

### Documentación Oficial

- [CREATE PROCEDURE (Transact-SQL)](https://learn.microsoft.com/en-us/sql/t-sql/statements/create-procedure-transact-sql)
- [CREATE FUNCTION (Transact-SQL)](https://learn.microsoft.com/en-us/sql/t-sql/statements/create-function-transact-sql)
- [TRY...CATCH (Transact-SQL)](https://learn.microsoft.com/en-us/sql/t-sql/language-elements/try-catch-transact-sql)
- [RAISERROR (Transact-SQL)](https://learn.microsoft.com/en-us/sql/t-sql/language-elements/raiserror-transact-sql)

### Mejores Prácticas

- [Stored Procedure Best Practices](https://learn.microsoft.com/en-us/previous-versions/sql/sql-server-2008-r2/dd283094(v=sql.105))
- [Error Handling in SQL Server](https://www.sqlshack.com/sql-server-error-handling/)
- [User-Defined Functions](https://learn.microsoft.com/en-us/sql/relational-databases/user-defined-functions/user-defined-functions)

---

**Última actualización:** Noviembre 2025  
**Materia:** Taller de Base de Datos  
**Sistema de Base de Datos:** Microsoft SQL Server (T-SQL)
