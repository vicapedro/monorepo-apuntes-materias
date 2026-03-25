-- =====================================================
-- EJEMPLO COMPLETO: Procedimiento Almacenado con Northwind
-- Ilustra: OUTPUT, RETURN, RAISERROR, TRY...CATCH, Record Set
-- =====================================================

USE Northwind;
GO

-- =====================================================
-- PROCEDIMIENTO: usp_ProcessCustomerOrder
-- 
-- Descripción: Procesa un pedido para un cliente, validando
--              stock, calculando totales y aplicando descuentos.
--
-- Ilustra:
--   1. Parámetros OUTPUT (total calculado, productos procesados)
--   2. RETURN (código de estado de éxito/error)
--   3. RAISERROR (errores personalizados)
--   4. TRY...CATCH (manejo estructurado de excepciones)
--   5. Record Set (resultado de la operación)
--
-- Retorna:
--   0 = Operación exitosa
--  -1 = Error: Cliente no encontrado
--  -2 = Error: Empleado no encontrado
--  -3 = Error: Producto no disponible o sin stock
--  -4 = Error: Error en la transacción
--
-- Autor: Taller de Base de Datos
-- Fecha: 2025-11-10
-- =====================================================

CREATE PROCEDURE dbo.usp_ProcessCustomerOrder
    -- Parámetros de entrada
    @CustomerID NCHAR(5),
    @EmployeeID INT,
    @ShipVia INT = 1,                    -- Transportista por defecto
    @RequiredDays INT = 7,               -- Días para entrega
    @ApplyDiscount BIT = 0,              -- Aplicar descuento especial
    
    -- Parámetros de salida (OUTPUT)
    @OrderID INT OUTPUT,                 -- ID del pedido generado
    @TotalAmount MONEY OUTPUT,           -- Total del pedido
    @ProductsProcessed INT OUTPUT,       -- Cantidad de productos procesados
    @DiscountApplied MONEY OUTPUT        -- Descuento aplicado
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Variables locales
    DECLARE @ErrorMessage NVARCHAR(4000);
    DECLARE @ErrorSeverity INT;
    DECLARE @ErrorState INT;
    DECLARE @CurrentDate DATETIME = GETDATE();
    DECLARE @RequiredDate DATETIME;
    DECLARE @CustomerCompany NVARCHAR(40);
    DECLARE @EmployeeName NVARCHAR(60);
    DECLARE @ProductCount INT;
    
    -- Inicializar parámetros OUTPUT
    SET @OrderID = NULL;
    SET @TotalAmount = 0;
    SET @ProductsProcessed = 0;
    SET @DiscountApplied = 0;
    
    -- =====================================================
    -- BLOQUE TRY: Lógica principal del procedimiento
    -- =====================================================
    BEGIN TRY
        
        -- =====================================================
        -- VALIDACIÓN 1: Verificar que el cliente existe
        -- =====================================================
        IF NOT EXISTS (SELECT 1 FROM Customers WHERE CustomerID = @CustomerID)
        BEGIN
            -- Usar RAISERROR para generar excepción personalizada
            RAISERROR (
                'Error: El cliente con ID "%s" no existe en la base de datos.',
                16,  -- Severidad: Error que el usuario puede corregir
                1,   -- Estado: Primera ocurrencia
                @CustomerID
            );
            RETURN -1;  -- Código de retorno: Cliente no encontrado
        END
        
        -- Obtener nombre del cliente para mensajes
        SELECT @CustomerCompany = CompanyName 
        FROM Customers 
        WHERE CustomerID = @CustomerID;
        
        PRINT '✓ Cliente validado: ' + @CustomerCompany;
        
        -- =====================================================
        -- VALIDACIÓN 2: Verificar que el empleado existe
        -- =====================================================
        IF NOT EXISTS (SELECT 1 FROM Employees WHERE EmployeeID = @EmployeeID)
        BEGIN
            RAISERROR (
                'Error: El empleado con ID %d no existe en el sistema.',
                16,
                1,
                @EmployeeID
            );
            RETURN -2;  -- Código de retorno: Empleado no encontrado
        END
        
        -- Obtener nombre del empleado
        SELECT @EmployeeName = FirstName + ' ' + LastName
        FROM Employees
        WHERE EmployeeID = @EmployeeID;
        
        PRINT '✓ Empleado asignado: ' + @EmployeeName;
        
        -- =====================================================
        -- VALIDACIÓN 3: Verificar que el transportista existe
        -- =====================================================
        IF NOT EXISTS (SELECT 1 FROM Shippers WHERE ShipperID = @ShipVia)
        BEGIN
            RAISERROR (
                'Error: El transportista con ID %d no está registrado.',
                16,
                1,
                @ShipVia
            );
            RETURN -3;
        END
        
        -- =====================================================
        -- INICIAR TRANSACCIÓN
        -- =====================================================
        BEGIN TRANSACTION;
        
        PRINT '';
        PRINT '--- Iniciando procesamiento del pedido ---';
        
        -- Calcular fecha requerida
        SET @RequiredDate = DATEADD(DAY, @RequiredDays, @CurrentDate);
        
        -- =====================================================
        -- PASO 1: Crear el encabezado del pedido (Orders)
        -- =====================================================
        INSERT INTO Orders (
            CustomerID, 
            EmployeeID, 
            OrderDate, 
            RequiredDate,
            ShipVia,
            Freight
        )
        VALUES (
            @CustomerID,
            @EmployeeID,
            @CurrentDate,
            @RequiredDate,
            @ShipVia,
            0  -- Freight se calculará después
        );
        
        -- Obtener el ID del pedido recién creado
        SET @OrderID = SCOPE_IDENTITY();
        
        PRINT 'Pedido creado con ID: ' + CAST(@OrderID AS VARCHAR);
        
        -- =====================================================
        -- PASO 2: Crear tabla temporal para productos del pedido
        -- Simulamos que tenemos productos a ordenar
        -- En un caso real, esto vendría como parámetro de tabla o XML
        -- =====================================================
        CREATE TABLE #OrderItems (
            ProductID INT,
            Quantity SMALLINT,
            UnitPrice MONEY,
            Discount REAL
        );
        
        -- Insertar productos de ejemplo (en producción vendrían como parámetro)
        -- Seleccionamos productos disponibles del cliente
        INSERT INTO #OrderItems (ProductID, Quantity, UnitPrice, Discount)
        SELECT TOP 5
            p.ProductID,
            CASE 
                WHEN p.UnitsInStock >= 10 THEN 10
                WHEN p.UnitsInStock >= 5 THEN 5
                ELSE 1
            END AS Quantity,
            p.UnitPrice,
            CASE 
                WHEN @ApplyDiscount = 1 THEN 0.10  -- 10% descuento
                ELSE 0.00
            END AS Discount
        FROM Products p
        WHERE p.Discontinued = 0
          AND p.UnitsInStock > 0
        ORDER BY NEWID();  -- Orden aleatorio para el ejemplo
        
        -- =====================================================
        -- PASO 3: Validar stock disponible
        -- =====================================================
        IF EXISTS (
            SELECT 1 
            FROM #OrderItems oi
            INNER JOIN Products p ON oi.ProductID = p.ProductID
            WHERE p.UnitsInStock < oi.Quantity
        )
        BEGIN
            -- Identificar productos sin stock suficiente
            DECLARE @ProductsOutOfStock NVARCHAR(MAX);
            
            SELECT @ProductsOutOfStock = STRING_AGG(
                p.ProductName + ' (Stock: ' + CAST(p.UnitsInStock AS VARCHAR) + 
                ', Solicitado: ' + CAST(oi.Quantity AS VARCHAR) + ')',
                ', '
            )
            FROM #OrderItems oi
            INNER JOIN Products p ON oi.ProductID = p.ProductID
            WHERE p.UnitsInStock < oi.Quantity;
            
            -- Lanzar error con detalles
            RAISERROR (
                'Error: Stock insuficiente para los siguientes productos: %s',
                16,
                1,
                @ProductsOutOfStock
            );
            
            -- Nota: El CATCH manejará el ROLLBACK
            RETURN -3;
        END
        
        PRINT '✓ Stock validado para todos los productos';
        
        -- =====================================================
        -- PASO 4: Insertar detalles del pedido (Order Details)
        -- =====================================================
        INSERT INTO [Order Details] (
            OrderID,
            ProductID,
            UnitPrice,
            Quantity,
            Discount
        )
        SELECT 
            @OrderID,
            ProductID,
            UnitPrice,
            Quantity,
            Discount
        FROM #OrderItems;
        
        SET @ProductsProcessed = @@ROWCOUNT;
        
        PRINT 'Productos procesados: ' + CAST(@ProductsProcessed AS VARCHAR);
        
        -- =====================================================
        -- PASO 5: Actualizar inventario (reducir stock)
        -- =====================================================
        UPDATE p
        SET 
            p.UnitsInStock = p.UnitsInStock - oi.Quantity,
            p.UnitsOnOrder = p.UnitsOnOrder + oi.Quantity
        FROM Products p
        INNER JOIN #OrderItems oi ON p.ProductID = oi.ProductID;
        
        PRINT '✓ Inventario actualizado';
        
        -- =====================================================
        -- PASO 6: Calcular totales
        -- =====================================================
        SELECT 
            @TotalAmount = SUM(UnitPrice * Quantity * (1 - Discount)),
            @DiscountApplied = SUM(UnitPrice * Quantity * Discount)
        FROM #OrderItems;
        
        -- =====================================================
        -- PASO 7: Actualizar Freight estimado (5% del total)
        -- =====================================================
        UPDATE Orders
        SET Freight = @TotalAmount * 0.05
        WHERE OrderID = @OrderID;
        
        -- =====================================================
        -- CONFIRMAR TRANSACCIÓN
        -- =====================================================
        COMMIT TRANSACTION;
        
        PRINT '';
        PRINT '==============================================';
        PRINT 'PEDIDO PROCESADO EXITOSAMENTE';
        PRINT '==============================================';
        PRINT 'Order ID: ' + CAST(@OrderID AS VARCHAR);
        PRINT 'Cliente: ' + @CustomerCompany;
        PRINT 'Empleado: ' + @EmployeeName;
        PRINT 'Productos: ' + CAST(@ProductsProcessed AS VARCHAR);
        PRINT 'Subtotal: $' + CAST(@TotalAmount AS VARCHAR(20));
        PRINT 'Descuento: $' + CAST(@DiscountApplied AS VARCHAR(20));
        PRINT 'Freight: $' + CAST(@TotalAmount * 0.05 AS VARCHAR(20));
        PRINT 'TOTAL: $' + CAST(@TotalAmount * 1.05 AS VARCHAR(20));
        PRINT '==============================================';
        PRINT '';
        
        -- =====================================================
        -- RECORD SET: Devolver detalles del pedido creado
        -- =====================================================
        SELECT 
            o.OrderID,
            o.CustomerID,
            c.CompanyName AS CustomerName,
            o.EmployeeID,
            e.FirstName + ' ' + e.LastName AS EmployeeName,
            o.OrderDate,
            o.RequiredDate,
            o.Freight,
            @ProductsProcessed AS TotalProducts,
            @TotalAmount AS Subtotal,
            @DiscountApplied AS TotalDiscount,
            @TotalAmount * 1.05 AS GrandTotal,
            s.CompanyName AS ShipperName
        FROM Orders o
        INNER JOIN Customers c ON o.CustomerID = c.CustomerID
        INNER JOIN Employees e ON o.EmployeeID = e.EmployeeID
        INNER JOIN Shippers s ON o.ShipVia = s.ShipperID
        WHERE o.OrderID = @OrderID;
        
        -- Devolver detalle de productos
        SELECT 
            od.OrderID,
            od.ProductID,
            p.ProductName,
            od.UnitPrice,
            od.Quantity,
            od.Discount,
            od.UnitPrice * od.Quantity AS Subtotal,
            od.UnitPrice * od.Quantity * od.Discount AS DiscountAmount,
            od.UnitPrice * od.Quantity * (1 - od.Discount) AS Total,
            p.UnitsInStock AS CurrentStock
        FROM [Order Details] od
        INNER JOIN Products p ON od.ProductID = p.ProductID
        WHERE od.OrderID = @OrderID
        ORDER BY od.ProductID;
        
        -- Limpiar tabla temporal
        DROP TABLE #OrderItems;
        
        -- RETURN con código de éxito
        RETURN 0;
        
    END TRY
    
    -- =====================================================
    -- BLOQUE CATCH: Manejo de excepciones
    -- =====================================================
    BEGIN CATCH
        
        -- Si hay una transacción activa, hacer ROLLBACK
        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION;
            PRINT '';
            PRINT '✗ Transacción revertida debido a un error';
        END
        
        -- Capturar información del error
        SET @ErrorMessage = ERROR_MESSAGE();
        SET @ErrorSeverity = ERROR_SEVERITY();
        SET @ErrorState = ERROR_STATE();
        
        -- Limpiar tabla temporal si existe
        IF OBJECT_ID('tempdb..#OrderItems') IS NOT NULL
            DROP TABLE #OrderItems;
        
        -- Mostrar información detallada del error
        PRINT '';
        PRINT '==============================================';
        PRINT 'ERROR EN EL PROCESAMIENTO DEL PEDIDO';
        PRINT '==============================================';
        PRINT 'Error Number: ' + CAST(ERROR_NUMBER() AS VARCHAR);
        PRINT 'Error Severity: ' + CAST(@ErrorSeverity AS VARCHAR);
        PRINT 'Error State: ' + CAST(@ErrorState AS VARCHAR);
        PRINT 'Error Line: ' + CAST(ERROR_LINE() AS VARCHAR);
        PRINT 'Error Message: ' + @ErrorMessage;
        PRINT '==============================================';
        PRINT '';
        
        -- Re-lanzar el error al cliente
        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
        
        -- RETURN con código de error general
        RETURN -4;
        
    END CATCH
    
END
GO

-- =====================================================
-- EJEMPLOS DE USO
-- =====================================================

PRINT '';
PRINT '╔══════════════════════════════════════════════════════════╗';
PRINT '║  EJEMPLO 1: Ejecución exitosa con todos los parámetros  ║';
PRINT '╚══════════════════════════════════════════════════════════╝';
PRINT '';

-- Declarar variables para capturar OUTPUT
DECLARE @OrderID INT;
DECLARE @TotalAmount MONEY;
DECLARE @ProductsProcessed INT;
DECLARE @DiscountApplied MONEY;
DECLARE @ReturnCode INT;

-- Ejecutar el procedimiento
EXEC @ReturnCode = dbo.usp_ProcessCustomerOrder
    @CustomerID = 'ALFKI',           -- Cliente: Alfreds Futterkiste
    @EmployeeID = 5,                 -- Empleado: Steven Buchanan
    @ShipVia = 1,                    -- Transportista: Speedy Express
    @RequiredDays = 7,               -- Entrega en 7 días
    @ApplyDiscount = 1,              -- Aplicar descuento del 10%
    @OrderID = @OrderID OUTPUT,
    @TotalAmount = @TotalAmount OUTPUT,
    @ProductsProcessed = @ProductsProcessed OUTPUT,
    @DiscountApplied = @DiscountApplied OUTPUT;

-- Verificar código de retorno
PRINT '';
PRINT '--- RESULTADOS DE LA EJECUCIÓN ---';
PRINT 'Código de retorno (RETURN): ' + CAST(@ReturnCode AS VARCHAR);

IF @ReturnCode = 0
BEGIN
    PRINT 'Estado: ÉXITO';
    PRINT '';
    PRINT 'Valores OUTPUT recibidos:';
    PRINT '  - Order ID: ' + CAST(@OrderID AS VARCHAR);
    PRINT '  - Total Amount: $' + CAST(@TotalAmount AS VARCHAR(20));
    PRINT '  - Products Processed: ' + CAST(@ProductsProcessed AS VARCHAR);
    PRINT '  - Discount Applied: $' + CAST(@DiscountApplied AS VARCHAR(20));
END
ELSE
BEGIN
    PRINT 'Estado: ERROR';
    PRINT 'Código de error: ' + CAST(@ReturnCode AS VARCHAR);
END

GO

PRINT '';
PRINT '╔══════════════════════════════════════════════════════════╗';
PRINT '║  EJEMPLO 2: Error - Cliente no existe                   ║';
PRINT '╚══════════════════════════════════════════════════════════╝';
PRINT '';

DECLARE @OrderID2 INT;
DECLARE @TotalAmount2 MONEY;
DECLARE @ProductsProcessed2 INT;
DECLARE @DiscountApplied2 MONEY;
DECLARE @ReturnCode2 INT;

-- Intentar con cliente inexistente
EXEC @ReturnCode2 = dbo.usp_ProcessCustomerOrder
    @CustomerID = 'XXXXX',           -- Cliente que NO existe
    @EmployeeID = 5,
    @ShipVia = 1,
    @RequiredDays = 7,
    @ApplyDiscount = 0,
    @OrderID = @OrderID2 OUTPUT,
    @TotalAmount = @TotalAmount2 OUTPUT,
    @ProductsProcessed = @ProductsProcessed2 OUTPUT,
    @DiscountApplied = @DiscountApplied2 OUTPUT;

PRINT '';
PRINT 'Código de retorno: ' + CAST(@ReturnCode2 AS VARCHAR);
PRINT 'Interpretación: -1 = Cliente no encontrado';

GO

PRINT '';
PRINT '╔══════════════════════════════════════════════════════════╗';
PRINT '║  EJEMPLO 3: Error - Empleado no existe                  ║';
PRINT '╚══════════════════════════════════════════════════════════╝';
PRINT '';

DECLARE @OrderID3 INT;
DECLARE @TotalAmount3 MONEY;
DECLARE @ProductsProcessed3 INT;
DECLARE @DiscountApplied3 MONEY;
DECLARE @ReturnCode3 INT;

-- Intentar con empleado inexistente
EXEC @ReturnCode3 = dbo.usp_ProcessCustomerOrder
    @CustomerID = 'ALFKI',
    @EmployeeID = 9999,              -- Empleado que NO existe
    @ShipVia = 1,
    @RequiredDays = 7,
    @ApplyDiscount = 0,
    @OrderID = @OrderID3 OUTPUT,
    @TotalAmount = @TotalAmount3 OUTPUT,
    @ProductsProcessed = @ProductsProcessed3 OUTPUT,
    @DiscountApplied = @DiscountApplied3 OUTPUT;

PRINT '';
PRINT 'Código de retorno: ' + CAST(@ReturnCode3 AS VARCHAR);
PRINT 'Interpretación: -2 = Empleado no encontrado';

GO

-- =====================================================
-- DOCUMENTACIÓN DE CÓDIGOS DE RETORNO
-- =====================================================

PRINT '';
PRINT '╔══════════════════════════════════════════════════════════╗';
PRINT '║           CÓDIGOS DE RETORNO DEL PROCEDIMIENTO          ║';
PRINT '╚══════════════════════════════════════════════════════════╝';
PRINT '';
PRINT 'Código  Significado';
PRINT '------  --------------------------------------------------';
PRINT '  0     Operación exitosa';
PRINT ' -1     Error: Cliente no encontrado';
PRINT ' -2     Error: Empleado no encontrado';
PRINT ' -3     Error: Producto no disponible o sin stock';
PRINT ' -4     Error: Error general en la transacción';
PRINT '';
PRINT '╔══════════════════════════════════════════════════════════╗';
PRINT '║              PARÁMETROS OUTPUT DISPONIBLES               ║';
PRINT '╚══════════════════════════════════════════════════════════╝';
PRINT '';
PRINT 'Parámetro              Tipo      Descripción';
PRINT '---------------------  --------  ---------------------------';
PRINT '@OrderID               INT       ID del pedido generado';
PRINT '@TotalAmount           MONEY     Total del pedido';
PRINT '@ProductsProcessed     INT       Productos procesados';
PRINT '@DiscountApplied       MONEY     Descuento total aplicado';
PRINT '';

-- =====================================================
-- CONSULTAS DE VERIFICACIÓN
-- =====================================================

PRINT '';
PRINT '╔══════════════════════════════════════════════════════════╗';
PRINT '║            CONSULTAS PARA VERIFICAR RESULTADOS           ║';
PRINT '╚══════════════════════════════════════════════════════════╝';
PRINT '';
PRINT '-- Ver últimos pedidos creados:';
PRINT 'SELECT TOP 5 * FROM Orders ORDER BY OrderID DESC;';
PRINT '';
PRINT '-- Ver detalles de un pedido específico:';
PRINT 'SELECT * FROM [Order Details] WHERE OrderID = @OrderID;';
PRINT '';
PRINT '-- Ver productos con su stock actual:';
PRINT 'SELECT ProductID, ProductName, UnitsInStock, UnitsOnOrder';
PRINT 'FROM Products WHERE ProductID IN (SELECT ProductID FROM [Order Details] WHERE OrderID = @OrderID);';
PRINT '';
