-- =====================================================
-- EJERCICIO: SEGURIDAD DE BASE DE DATOS CON RBAC Y SCHEMAS
-- Sistema Multi-Aplicación (Mobile App, Web App, WinForms)
-- =====================================================

-- Este ejercicio demuestra:
-- 1. Separación de datos por schemas
-- 2. Control de acceso basado en roles (RBAC)
-- 3. Usuarios específicos por aplicación
-- 4. Permisos granulares por rol y schema
-- 5. Arquitectura de seguridad con Backend API (Mobile App)

-- =====================================================
-- ARQUITECTURA DE LA SOLUCIÓN
-- =====================================================
--
-- [Mobile App] ← HTTP/HTTPS → [Backend API (.NET/Node.js/Python)]
--                                      ↓
--                              SQL Connection
--                              User: BackendMobileApp
--                              Role: RolVendedor
--                                      ↓
--                              [SQL Server Database]
--                              └── SistemaVentas
--                                  ├── Clientes
--                                  ├── Ventas
--                                  ├── Produccion
--                                  └── Reportes
--
-- FLUJO DE AUTENTICACIÓN:
-- 1. Vendedor inicia sesión en Mobile App (usuario: juan.perez, password: ***)
-- 2. Mobile App envía credenciales al Backend API
-- 3. Backend valida credenciales contra tabla Clientes.UsuariosApp
-- 4. Si válido, Backend genera token JWT/Session
-- 5. Mobile App usa token para solicitudes subsecuentes
-- 6. Backend ejecuta operaciones en BD usando usuario BackendMobileApp
-- 7. Backend aplica lógica de negocio y filtros de seguridad adicionales
--
-- VENTAJAS DE ESTA ARQUITECTURA:
-- ✓ Mobile App no tiene credenciales de base de datos
-- ✓ Un solo usuario de BD para todas las conexiones desde mobile
-- ✓ Backend puede implementar rate limiting, caching, validaciones
-- ✓ Centralización de lógica de negocio
-- ✓ Más fácil auditar y monitorear accesos
-- ✓ Cambios en BD no requieren actualizar mobile app

-- =====================================================
-- PASO 1: CREAR LA BASE DE DATOS
-- =====================================================

CREATE DATABASE SistemaVentas;
GO

USE SistemaVentas;
GO

-- =====================================================
-- PASO 2: CREAR SCHEMAS PARA SEPARACIÓN LÓGICA
-- =====================================================

-- Schema para datos de ventas (acceso desde apps móvil y web)
CREATE SCHEMA Ventas;
GO

-- Schema para datos de producción (acceso restringido desde WinForms)
CREATE SCHEMA Produccion;
GO

-- Schema para datos de clientes (acceso compartido)
CREATE SCHEMA Clientes;
GO

-- Schema para reportes y estadísticas (solo lectura para gerentes)
CREATE SCHEMA Reportes;
GO

-- =====================================================
-- PASO 3: CREAR TABLAS EN CADA SCHEMA
-- =====================================================

-- ----------------
-- Schema: Clientes
-- ----------------
CREATE TABLE Clientes.Clientes (
    ClienteID INT PRIMARY KEY IDENTITY(1,1),
    Nombre NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) UNIQUE NOT NULL,
    Telefono NVARCHAR(20),
    Direccion NVARCHAR(200),
    Ciudad NVARCHAR(50),
    FechaRegistro DATETIME DEFAULT GETDATE(),
    Estado BIT DEFAULT 1 -- 1=Activo, 0=Inactivo
);
GO

CREATE TABLE Clientes.UsuariosApp (
    UsuarioAppID INT PRIMARY KEY IDENTITY(1,1),
    ClienteID INT FOREIGN KEY REFERENCES Clientes.Clientes(ClienteID),
    Username NVARCHAR(50) UNIQUE NOT NULL,
    PasswordHash NVARCHAR(255) NOT NULL,
    TipoApp NVARCHAR(20) CHECK (TipoApp IN ('Mobile', 'Web')),
    UltimoAcceso DATETIME,
    Estado BIT DEFAULT 1
);
GO

-- ----------------
-- Schema: Ventas
-- ----------------
CREATE TABLE Ventas.Vendedores (
    VendedorID INT PRIMARY KEY IDENTITY(1,1),
    Nombre NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) UNIQUE NOT NULL,
    Telefono NVARCHAR(20),
    FechaContratacion DATE DEFAULT CAST(GETDATE() AS DATE),
    SupervisorID INT NULL,
    Comision DECIMAL(5,2) DEFAULT 0.05, -- 5% por defecto
    Estado BIT DEFAULT 1,
    CONSTRAINT FK_Vendedor_Supervisor FOREIGN KEY (SupervisorID) 
        REFERENCES Ventas.Vendedores(VendedorID)
);
GO

CREATE TABLE Ventas.Pedidos (
    PedidoID INT PRIMARY KEY IDENTITY(1,1),
    ClienteID INT NOT NULL FOREIGN KEY REFERENCES Clientes.Clientes(ClienteID),
    VendedorID INT NOT NULL FOREIGN KEY REFERENCES Ventas.Vendedores(VendedorID),
    FechaPedido DATETIME DEFAULT GETDATE(),
    FechaEntrega DATE,
    Estado NVARCHAR(20) CHECK (Estado IN ('Pendiente', 'Procesando', 'Enviado', 'Entregado', 'Cancelado')),
    Total DECIMAL(12,2) DEFAULT 0,
    Observaciones NVARCHAR(500)
);
GO

CREATE TABLE Ventas.DetallePedido (
    DetalleID INT PRIMARY KEY IDENTITY(1,1),
    PedidoID INT NOT NULL FOREIGN KEY REFERENCES Ventas.Pedidos(PedidoID) ON DELETE CASCADE,
    ProductoID INT NOT NULL,
    Cantidad INT NOT NULL CHECK (Cantidad > 0),
    PrecioUnitario DECIMAL(10,2) NOT NULL,
    Descuento DECIMAL(5,2) DEFAULT 0,
    Subtotal AS (Cantidad * PrecioUnitario * (1 - Descuento/100)) PERSISTED
);
GO

-- ----------------
-- Schema: Produccion
-- ----------------
CREATE TABLE Produccion.Productos (
    ProductoID INT PRIMARY KEY IDENTITY(1,1),
    CodigoProducto NVARCHAR(50) UNIQUE NOT NULL,
    NombreProducto NVARCHAR(100) NOT NULL,
    Descripcion NVARCHAR(500),
    CategoriaID INT,
    PrecioCosto DECIMAL(10,2) NOT NULL,
    PrecioVenta DECIMAL(10,2) NOT NULL,
    Stock INT DEFAULT 0,
    StockMinimo INT DEFAULT 10,
    Estado BIT DEFAULT 1
);
GO

CREATE TABLE Produccion.Categorias (
    CategoriaID INT PRIMARY KEY IDENTITY(1,1),
    NombreCategoria NVARCHAR(50) UNIQUE NOT NULL,
    Descripcion NVARCHAR(200),
    Estado BIT DEFAULT 1
);
GO

-- Agregar FK después de crear ambas tablas
ALTER TABLE Produccion.Productos
ADD CONSTRAINT FK_Producto_Categoria 
    FOREIGN KEY (CategoriaID) REFERENCES Produccion.Categorias(CategoriaID);
GO

CREATE TABLE Produccion.Inventario (
    InventarioID INT PRIMARY KEY IDENTITY(1,1),
    ProductoID INT NOT NULL FOREIGN KEY REFERENCES Produccion.Productos(ProductoID),
    TipoMovimiento NVARCHAR(20) CHECK (TipoMovimiento IN ('Entrada', 'Salida', 'Ajuste')),
    Cantidad INT NOT NULL,
    FechaMovimiento DATETIME DEFAULT GETDATE(),
    UsuarioRegistro NVARCHAR(50) DEFAULT SYSTEM_USER,
    Observaciones NVARCHAR(200)
);
GO

CREATE TABLE Produccion.OrdenesProduccion (
    OrdenID INT PRIMARY KEY IDENTITY(1,1),
    ProductoID INT NOT NULL FOREIGN KEY REFERENCES Produccion.Productos(ProductoID),
    CantidadOrdenada INT NOT NULL,
    FechaOrden DATE DEFAULT CAST(GETDATE() AS DATE),
    FechaEstimadaTermino DATE,
    Estado NVARCHAR(20) CHECK (Estado IN ('Planificada', 'EnProceso', 'Completada', 'Cancelada')),
    Prioridad NVARCHAR(20) CHECK (Prioridad IN ('Baja', 'Media', 'Alta', 'Urgente'))
);
GO

-- ----------------
-- Schema: Reportes (Vistas para análisis)
-- ----------------
CREATE VIEW Reportes.VentasPorVendedor AS
SELECT 
    v.VendedorID,
    v.Nombre AS Vendedor,
    COUNT(p.PedidoID) AS TotalPedidos,
    SUM(p.Total) AS VentaTotal,
    AVG(p.Total) AS PromedioVenta,
    MAX(p.FechaPedido) AS UltimaVenta
FROM Ventas.Vendedores v
LEFT JOIN Ventas.Pedidos p ON v.VendedorID = p.VendedorID
WHERE v.Estado = 1
GROUP BY v.VendedorID, v.Nombre;
GO

CREATE VIEW Reportes.ProductosBajoStock AS
SELECT 
    p.ProductoID,
    p.CodigoProducto,
    p.NombreProducto,
    c.NombreCategoria,
    p.Stock,
    p.StockMinimo,
    (p.StockMinimo - p.Stock) AS UnidadesFaltantes
FROM Produccion.Productos p
INNER JOIN Produccion.Categorias c ON p.CategoriaID = c.CategoriaID
WHERE p.Stock < p.StockMinimo AND p.Estado = 1;
GO

CREATE VIEW Reportes.VentasPorMes AS
SELECT 
    YEAR(FechaPedido) AS Anio,
    MONTH(FechaPedido) AS Mes,
    COUNT(PedidoID) AS TotalPedidos,
    SUM(Total) AS VentaTotal,
    AVG(Total) AS PromedioVenta
FROM Ventas.Pedidos
WHERE Estado != 'Cancelado'
GROUP BY YEAR(FechaPedido), MONTH(FechaPedido);
GO

-- =====================================================
-- PASO 4: INSERTAR DATOS DE DEMOSTRACIÓN
-- =====================================================

-- Insertar Categorías
INSERT INTO Produccion.Categorias (NombreCategoria, Descripcion) VALUES
('Electrónica', 'Dispositivos y componentes electrónicos'),
('Ropa', 'Vestimenta y accesorios'),
('Alimentos', 'Productos alimenticios'),
('Hogar', 'Artículos para el hogar'),
('Deportes', 'Equipamiento deportivo');
GO

-- Insertar Productos
INSERT INTO Produccion.Productos (CodigoProducto, NombreProducto, Descripcion, CategoriaID, PrecioCosto, PrecioVenta, Stock, StockMinimo) VALUES
('ELEC001', 'Laptop Dell XPS 13', 'Laptop ultraligera 13 pulgadas', 1, 8000.00, 12000.00, 15, 5),
('ELEC002', 'Mouse Inalámbrico Logitech', 'Mouse ergonómico inalámbrico', 1, 200.00, 350.00, 50, 20),
('ROPA001', 'Camisa Polo Nike', 'Camisa deportiva polo', 2, 250.00, 450.00, 30, 10),
('ROPA002', 'Pantalón Jeans Levi''s', 'Pantalón mezclilla azul', 2, 400.00, 750.00, 25, 8),
('ALIM001', 'Caja Chocolates Ferrero', 'Chocolates finos 24 piezas', 3, 180.00, 300.00, 100, 30),
('HOGAR001', 'Juego de Sartenes Tefal', 'Set 3 sartenes antiadherentes', 4, 600.00, 1100.00, 20, 5),
('DEPORT001', 'Balón Fútbol Adidas', 'Balón profesional tamaño 5', 5, 300.00, 550.00, 40, 15);
GO

-- Insertar Clientes
INSERT INTO Clientes.Clientes (Nombre, Email, Telefono, Direccion, Ciudad) VALUES
('Juan Pérez', 'juan.perez@email.com', '555-1001', 'Av. Principal 123', 'Ciudad de México'),
('María García', 'maria.garcia@email.com', '555-1002', 'Calle Reforma 456', 'Guadalajara'),
('Carlos López', 'carlos.lopez@email.com', '555-1003', 'Blvd. Independencia 789', 'Monterrey'),
('Ana Martínez', 'ana.martinez@email.com', '555-1004', 'Av. Juárez 321', 'Puebla'),
('Luis Rodríguez', 'luis.rodriguez@email.com', '555-1005', 'Calle Hidalgo 654', 'Querétaro');
GO

-- Insertar Usuarios de Apps (Mobile y Web)
INSERT INTO Clientes.UsuariosApp (ClienteID, Username, PasswordHash, TipoApp) VALUES
(1, 'jperez_mobile', 'HASH_PASSWORD_1', 'Mobile'),
(2, 'mgarcia_web', 'HASH_PASSWORD_2', 'Web'),
(3, 'clopez_mobile', 'HASH_PASSWORD_3', 'Mobile'),
(4, 'amartinez_web', 'HASH_PASSWORD_4', 'Web'),
(5, 'lrodriguez_mobile', 'HASH_PASSWORD_5', 'Mobile');
GO

-- Insertar Vendedores (con jerarquía)
INSERT INTO Ventas.Vendedores (Nombre, Email, Telefono, SupervisorID, Comision) VALUES
('Roberto Supervisor', 'roberto.super@empresa.com', '555-2001', NULL, 0.08), -- Supervisor
('Elena Vendedor', 'elena.v@empresa.com', '555-2002', 1, 0.05),
('Miguel Vendedor', 'miguel.v@empresa.com', '555-2003', 1, 0.05),
('Patricia Supervisor', 'patricia.super@empresa.com', '555-2004', NULL, 0.08), -- Supervisor
('Fernando Vendedor', 'fernando.v@empresa.com', '555-2005', 4, 0.05);
GO

-- Insertar Pedidos
INSERT INTO Ventas.Pedidos (ClienteID, VendedorID, FechaEntrega, Estado, Total) VALUES
(1, 2, '2024-11-01', 'Entregado', 12350.00),
(2, 3, '2024-11-05', 'Procesando', 1100.00),
(3, 5, '2024-11-10', 'Pendiente', 1300.00),
(4, 2, '2024-11-15', 'Enviado', 750.00),
(5, 3, '2024-11-20', 'Entregado', 550.00);
GO

-- Insertar Detalle de Pedidos
INSERT INTO Ventas.DetallePedido (PedidoID, ProductoID, Cantidad, PrecioUnitario, Descuento) VALUES
(1, 1, 1, 12000.00, 0),    -- Laptop
(1, 2, 1, 350.00, 0),       -- Mouse
(2, 6, 1, 1100.00, 0),      -- Sartenes
(3, 3, 2, 450.00, 0),       -- 2 Camisas
(3, 5, 1, 300.00, 5),       -- Chocolates con 5% descuento
(4, 4, 1, 750.00, 0),       -- Pantalón
(5, 7, 1, 550.00, 0);       -- Balón
GO

-- =====================================================
-- PASO 5: CREAR ROLES DE BASE DE DATOS
-- =====================================================

-- Roles para aplicaciones móvil y web (vendedores)
CREATE ROLE RolVendedor;
GO

-- Roles para supervisores (web app con más permisos)
CREATE ROLE RolSupervisor;
GO

-- Roles para gerentes (WinForms - acceso completo)
CREATE ROLE RolGerenteVentas;
GO

CREATE ROLE RolGerenteMarketing;
GO

CREATE ROLE RolGerenteProduccion;
GO

-- =====================================================
-- PASO 6: ASIGNAR PERMISOS A ROLES
-- =====================================================

-- =====================================================
-- PERMISOS PARA ROL VENDEDOR (Mobile/Web App)
-- =====================================================
-- Acceso LIMITADO a ventas y clientes

-- Schema Clientes: Solo lectura de clientes activos
GRANT SELECT ON SCHEMA::Clientes TO RolVendedor;
GO

-- Schema Ventas: Puede ver y crear pedidos, ver vendedores
GRANT SELECT ON Ventas.Vendedores TO RolVendedor;
GRANT SELECT, INSERT ON Ventas.Pedidos TO RolVendedor;
GRANT SELECT, INSERT ON Ventas.DetallePedido TO RolVendedor;
GO

-- Schema Produccion: Solo lectura de productos para consultar catálogo
GRANT SELECT ON Produccion.Productos TO RolVendedor;
GRANT SELECT ON Produccion.Categorias TO RolVendedor;
GO

-- NO tiene acceso a Reportes ni a datos de producción sensibles
-- NO puede modificar inventario ni órdenes de producción

-- =====================================================
-- PERMISOS PARA ROL SUPERVISOR (Web App)
-- =====================================================
-- Acceso ampliado sobre ventas de su equipo

-- Todos los permisos de vendedor
GRANT SELECT ON SCHEMA::Clientes TO RolSupervisor;
GRANT SELECT, INSERT, UPDATE ON Ventas.Pedidos TO RolSupervisor;
GRANT SELECT, INSERT, UPDATE, DELETE ON Ventas.DetallePedido TO RolSupervisor;
GRANT SELECT ON Ventas.Vendedores TO RolSupervisor;
GO

-- Acceso a productos (lectura completa)
GRANT SELECT ON SCHEMA::Produccion TO RolSupervisor;
GO

-- Acceso a reportes de ventas
GRANT SELECT ON Reportes.VentasPorVendedor TO RolSupervisor;
GRANT SELECT ON Reportes.VentasPorMes TO RolSupervisor;
GO

-- =====================================================
-- PERMISOS PARA ROL GERENTE DE VENTAS (WinForms)
-- =====================================================
-- Control total sobre ventas y reportes

-- Acceso completo a Clientes y Ventas
GRANT SELECT, INSERT, UPDATE, DELETE ON SCHEMA::Clientes TO RolGerenteVentas;
GRANT SELECT, INSERT, UPDATE, DELETE ON SCHEMA::Ventas TO RolGerenteVentas;
GO

-- Lectura completa de Producción
GRANT SELECT ON SCHEMA::Produccion TO RolGerenteVentas;
GO

-- Acceso total a Reportes
GRANT SELECT ON SCHEMA::Reportes TO RolGerenteVentas;
GO

-- =====================================================
-- PERMISOS PARA ROL GERENTE DE MARKETING (WinForms)
-- =====================================================
-- Enfoque en clientes y análisis de ventas

-- Acceso completo a Clientes
GRANT SELECT, INSERT, UPDATE ON SCHEMA::Clientes TO RolGerenteMarketing;
GO

-- Lectura de Ventas (para análisis de mercado)
GRANT SELECT ON SCHEMA::Ventas TO RolGerenteMarketing;
GO

-- Lectura de Productos (para campañas)
GRANT SELECT ON Produccion.Productos TO RolGerenteMarketing;
GRANT SELECT ON Produccion.Categorias TO RolGerenteMarketing;
GO

-- Acceso a reportes de ventas
GRANT SELECT ON SCHEMA::Reportes TO RolGerenteMarketing;
GO

-- =====================================================
-- PERMISOS PARA ROL GERENTE DE PRODUCCIÓN (WinForms)
-- =====================================================
-- Control total sobre producción e inventario

-- Acceso completo a Producción
GRANT SELECT, INSERT, UPDATE, DELETE ON SCHEMA::Produccion TO RolGerenteProduccion;
GO

-- Lectura de Ventas (para planificar producción)
GRANT SELECT ON Ventas.Pedidos TO RolGerenteProduccion;
GRANT SELECT ON Ventas.DetallePedido TO RolGerenteProduccion;
GO

-- Acceso a reportes de inventario
GRANT SELECT ON Reportes.ProductosBajoStock TO RolGerenteProduccion;
GO

-- =====================================================
-- PASO 7: CREAR USUARIOS DE BASE DE DATOS
-- =====================================================

-- =====================================================
-- Usuario para Backend de Mobile App
-- =====================================================
-- La Mobile App NO se conecta directamente a la base de datos
-- Se conecta a un Backend API que actúa como intermediario
-- El Backend se autentica con SQL Server usando este usuario

-- Opción 1: Usuario con login de SQL Server (Autenticación SQL)
CREATE LOGIN BackendMobileApp WITH PASSWORD = 'P@ssw0rd_Backend_2024!', 
    CHECK_POLICY = ON,
    CHECK_EXPIRATION = ON;
GO

CREATE USER BackendMobileApp FOR LOGIN BackendMobileApp;
ALTER ROLE RolVendedor ADD MEMBER BackendMobileApp;
GO

-- Opción 2 (Comentada): Si se usa Autenticación de Windows/Azure AD
-- CREATE LOGIN [DOMAIN\BackendAppService] FROM WINDOWS;
-- CREATE USER BackendMobileApp FOR LOGIN [DOMAIN\BackendAppService];
-- ALTER ROLE RolVendedor ADD MEMBER BackendMobileApp;
-- GO

-- =====================================================
-- Usuarios de Demostración (para pruebas sin login)
-- =====================================================
-- Estos usuarios son solo para pruebas de contexto de seguridad
-- En producción, la Mobile App usa BackendMobileApp

CREATE USER VendedorMobile1 WITHOUT LOGIN;
ALTER ROLE RolVendedor ADD MEMBER VendedorMobile1;
GO

CREATE USER VendedorMobile2 WITHOUT LOGIN;
ALTER ROLE RolVendedor ADD MEMBER VendedorMobile2;
GO

-- =====================================================
-- Usuarios para Web App (Vendedores y Supervisores)
-- =====================================================
CREATE USER VendedorWeb1 WITHOUT LOGIN;
ALTER ROLE RolVendedor ADD MEMBER VendedorWeb1;
GO

CREATE USER SupervisorWeb1 WITHOUT LOGIN;
ALTER ROLE RolSupervisor ADD MEMBER SupervisorWeb1;
GO

CREATE USER SupervisorWeb2 WITHOUT LOGIN;
ALTER ROLE RolSupervisor ADD MEMBER SupervisorWeb2;
GO

-- =====================================================
-- Usuarios para WinForms (Gerentes)
-- =====================================================
CREATE USER GerenteVentas WITHOUT LOGIN;
ALTER ROLE RolGerenteVentas ADD MEMBER GerenteVentas;
GO

CREATE USER GerenteMarketing WITHOUT LOGIN;
ALTER ROLE RolGerenteMarketing ADD MEMBER GerenteMarketing;
GO

CREATE USER GerenteProduccion WITHOUT LOGIN;
ALTER ROLE RolGerenteProduccion ADD MEMBER GerenteProduccion;
GO

-- =====================================================
-- PASO 8: PROCEDIMIENTOS ALMACENADOS CON SEGURIDAD
-- =====================================================

-- Procedimiento para que vendedores registren pedidos
CREATE PROCEDURE Ventas.sp_RegistrarPedido
    @ClienteID INT,
    @VendedorID INT,
    @FechaEntrega DATE,
    @Observaciones NVARCHAR(500) = NULL,
    @Productos XML -- XML con ProductoID, Cantidad, PrecioUnitario, Descuento
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Insertar pedido
        DECLARE @PedidoID INT;
        INSERT INTO Ventas.Pedidos (ClienteID, VendedorID, FechaEntrega, Estado, Observaciones)
        VALUES (@ClienteID, @VendedorID, @FechaEntrega, 'Pendiente', @Observaciones);
        
        SET @PedidoID = SCOPE_IDENTITY();
        
        -- Insertar detalles desde XML
        INSERT INTO Ventas.DetallePedido (PedidoID, ProductoID, Cantidad, PrecioUnitario, Descuento)
        SELECT 
            @PedidoID,
            Item.value('ProductoID[1]', 'INT'),
            Item.value('Cantidad[1]', 'INT'),
            Item.value('PrecioUnitario[1]', 'DECIMAL(10,2)'),
            Item.value('Descuento[1]', 'DECIMAL(5,2)')
        FROM @Productos.nodes('/Productos/Producto') AS X(Item);
        
        -- Actualizar total del pedido
        UPDATE Ventas.Pedidos
        SET Total = (SELECT SUM(Subtotal) FROM Ventas.DetallePedido WHERE PedidoID = @PedidoID)
        WHERE PedidoID = @PedidoID;
        
        COMMIT TRANSACTION;
        SELECT @PedidoID AS PedidoID;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;
GO

-- Dar permiso de ejecución a vendedores
GRANT EXECUTE ON Ventas.sp_RegistrarPedido TO RolVendedor;
GO

-- Procedimiento para actualizar inventario (solo gerente de producción)
CREATE PROCEDURE Produccion.sp_ActualizarInventario
    @ProductoID INT,
    @TipoMovimiento NVARCHAR(20),
    @Cantidad INT,
    @Observaciones NVARCHAR(200) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Registrar movimiento
        INSERT INTO Produccion.Inventario (ProductoID, TipoMovimiento, Cantidad, Observaciones)
        VALUES (@ProductoID, @TipoMovimiento, @Cantidad, @Observaciones);
        
        -- Actualizar stock
        IF @TipoMovimiento IN ('Entrada', 'Ajuste')
            UPDATE Produccion.Productos SET Stock = Stock + @Cantidad WHERE ProductoID = @ProductoID;
        ELSE IF @TipoMovimiento = 'Salida'
            UPDATE Produccion.Productos SET Stock = Stock - @Cantidad WHERE ProductoID = @ProductoID;
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;
GO

-- Solo gerente de producción puede ejecutarlo
GRANT EXECUTE ON Produccion.sp_ActualizarInventario TO RolGerenteProduccion;
GO

-- =====================================================
-- PASO 9: CONSULTAS DE VERIFICACIÓN
-- =====================================================

-- Ver todos los schemas
SELECT * FROM sys.schemas WHERE name IN ('Ventas', 'Produccion', 'Clientes', 'Reportes');
GO

-- Ver todos los roles creados
SELECT 
    dp.name AS RoleName,
    dp.type_desc AS RoleType
FROM sys.database_principals dp
WHERE dp.type = 'R' 
    AND dp.name LIKE 'Rol%'
ORDER BY dp.name;
GO

-- Ver usuarios y sus roles
SELECT 
    dp.name AS UserName,
    r.name AS RoleName
FROM sys.database_principals dp
LEFT JOIN sys.database_role_members drm ON dp.principal_id = drm.member_principal_id
LEFT JOIN sys.database_principals r ON drm.role_principal_id = r.principal_id
WHERE dp.type = 'S' -- S = SQL User
    AND dp.name NOT IN ('dbo', 'guest', 'INFORMATION_SCHEMA', 'sys')
ORDER BY dp.name, r.name;
GO

-- Ver permisos por rol
SELECT 
    USER_NAME(grantee_principal_id) AS Grantee,
    OBJECT_SCHEMA_NAME(major_id) AS SchemaName,
    OBJECT_NAME(major_id) AS ObjectName,
    permission_name,
    state_desc
FROM sys.database_permissions
WHERE USER_NAME(grantee_principal_id) LIKE 'Rol%'
ORDER BY Grantee, SchemaName, ObjectName;
GO

-- =====================================================
-- PASO 10: PRUEBAS DE SEGURIDAD
-- =====================================================

-- Cambiar contexto de ejecución para simular diferentes usuarios
PRINT '========================================';
PRINT 'PRUEBA 1: Vendedor intentando consultar productos';
PRINT '========================================';
EXECUTE AS USER = 'VendedorMobile1';
    SELECT TOP 3 ProductoID, NombreProducto, PrecioVenta, Stock 
    FROM Produccion.Productos;
REVERT;
GO

PRINT '========================================';
PRINT 'PRUEBA 2: Vendedor intentando modificar inventario (debe fallar)';
PRINT '========================================';
EXECUTE AS USER = 'VendedorMobile1';
    BEGIN TRY
        UPDATE Produccion.Inventario SET Cantidad = 100 WHERE InventarioID = 1;
        PRINT 'ERROR: Vendedor pudo modificar inventario (no debería)';
    END TRY
    BEGIN CATCH
        PRINT 'CORRECTO: Vendedor NO puede modificar inventario';
        PRINT 'Error: ' + ERROR_MESSAGE();
    END CATCH
REVERT;
GO

PRINT '========================================';
PRINT 'PRUEBA 3: Supervisor consultando reportes de ventas';
PRINT '========================================';
EXECUTE AS USER = 'SupervisorWeb1';
    SELECT TOP 3 * FROM Reportes.VentasPorVendedor;
REVERT;
GO

PRINT '========================================';
PRINT 'PRUEBA 4: Gerente de Producción actualizando stock';
PRINT '========================================';
EXECUTE AS USER = 'GerenteProduccion';
    EXEC Produccion.sp_ActualizarInventario 
        @ProductoID = 1, 
        @TipoMovimiento = 'Entrada', 
        @Cantidad = 10,
        @Observaciones = 'Reposición de inventario';
    
    SELECT ProductoID, NombreProducto, Stock 
    FROM Produccion.Productos 
    WHERE ProductoID = 1;
REVERT;
GO

PRINT '========================================';
PRINT 'PRUEBA 5: Gerente de Marketing consultando clientes';
PRINT '========================================';
EXECUTE AS USER = 'GerenteMarketing';
    SELECT TOP 3 ClienteID, Nombre, Email, Ciudad 
    FROM Clientes.Clientes;
REVERT;
GO

-- =====================================================
-- PASO 11: DOCUMENTACIÓN DE ARQUITECTURA
-- =====================================================

/*
RESUMEN DE ARQUITECTURA DE SEGURIDAD
=====================================

SCHEMAS:
--------
1. Clientes  - Datos de clientes y usuarios de apps
2. Ventas    - Pedidos, vendedores y transacciones
3. Produccion - Productos, inventario y órdenes de producción
4. Reportes  - Vistas para análisis (solo lectura)

ROLES Y PERMISOS:
-----------------

RolVendedor (Mobile/Web App):
  ✓ SELECT en Clientes (todos)
  ✓ SELECT, INSERT en Ventas.Pedidos y DetallePedido
  ✓ SELECT en Produccion.Productos y Categorias (catálogo)
  ✗ NO puede modificar inventario
  ✗ NO tiene acceso a reportes

RolSupervisor (Web App):
  ✓ Todos los permisos de Vendedor
  ✓ UPDATE en Ventas.Pedidos
  ✓ UPDATE, DELETE en DetallePedido
  ✓ SELECT en todo el schema Produccion
  ✓ SELECT en Reportes de ventas
  ✗ NO puede modificar inventario ni producción

RolGerenteVentas (WinForms):
  ✓ Control total (CRUD) en Clientes y Ventas
  ✓ SELECT completo en Produccion
  ✓ SELECT completo en Reportes

RolGerenteMarketing (WinForms):
  ✓ SELECT, INSERT, UPDATE en Clientes
  ✓ SELECT en Ventas (análisis)
  ✓ SELECT en Productos y Categorías
  ✓ SELECT completo en Reportes

RolGerenteProduccion (WinForms):
  ✓ Control total (CRUD) en Produccion
  ✓ SELECT en Ventas (planificación)
  ✓ SELECT en Reportes de inventario

APLICACIONES:
-------------
1. Mobile App    → Backend API → Base de Datos (usuario: BackendMobileApp con RolVendedor)
                 ↳ Autenticación de vendedores manejada en el Backend
                 ↳ Backend valida credenciales y ejecuta operaciones con permisos de RolVendedor
                 ↳ Connection String en Backend: Server=...; Database=SistemaVentas; User Id=BackendMobileApp; Password=...
   
2. Web App       → Vendedores y Supervisores (RolVendedor, RolSupervisor)
                 ↳ Puede conectarse directamente o a través de backend
   
3. WinForms      → Gerentes (RolGerenteVentas, RolGerenteMarketing, RolGerenteProduccion)
                 ↳ Conexión directa con autenticación Windows/SQL

SEGURIDAD IMPLEMENTADA:
-----------------------
✓ Separación de datos por schemas
✓ Control de acceso basado en roles (RBAC)
✓ Principio de mínimo privilegio
✓ Procedimientos almacenados con permisos específicos
✓ Usuarios sin login (autenticación delegada a la aplicación)
✓ Vistas para reportes (abstracción de complejidad)
✓ Restricciones por CHECK constraints
✓ Claves foráneas para integridad referencial
✓ Arquitectura con Backend API para Mobile App (separación de capas)
✓ Usuario dedicado para Backend con permisos limitados
✓ Auditoría centralizada a través del Backend

CONEXIÓN DESDE BACKEND (Ejemplo en .NET):
------------------------------------------
string connectionString = "Server=servidor.database.windows.net;" +
                         "Database=SistemaVentas;" +
                         "User Id=BackendMobileApp;" +
                         "Password=P@ssw0rd_Backend_2024!;" +
                         "Encrypt=True;" +
                         "TrustServerCertificate=False;";

BUENAS PRÁCTICAS BACKEND:
-------------------------
1. Almacenar connection string en variables de entorno o Azure Key Vault
2. Usar connection pooling para optimizar rendimiento
3. Implementar retry logic para transient failures
4. Validar y sanitizar inputs antes de ejecutar queries
5. Usar parámetros en queries (evitar SQL injection)
6. Implementar logging de todas las operaciones de BD
7. Rotar contraseñas periódicamente
8. Usar HTTPS/TLS para comunicación Mobile App ↔ Backend
*/

-- =====================================================
-- FIN DEL EJERCICIO
-- =====================================================

-- =====================================================
-- ANEXO: EJEMPLOS DE IMPLEMENTACIÓN EN BACKEND
-- =====================================================

/*
EJEMPLO 1: CONFIGURACIÓN DE CONEXIÓN EN BACKEND (.NET Core)
============================================================

// appsettings.json
{
  "ConnectionStrings": {
    "SistemaVentas": "Server=servidor.database.windows.net;Database=SistemaVentas;User Id=BackendMobileApp;Password=P@ssw0rd_Backend_2024!;Encrypt=True;TrustServerCertificate=False;MultipleActiveResultSets=true;"
  }
}

// Startup.cs o Program.cs
services.AddDbContext<SistemaVentasContext>(options =>
    options.UseSqlServer(Configuration.GetConnectionString("SistemaVentas")));


EJEMPLO 2: ENDPOINT API PARA REGISTRAR PEDIDO
==============================================

// PedidosController.cs
[ApiController]
[Route("api/[controller]")]
[Authorize] // Requiere token JWT válido
public class PedidosController : ControllerBase
{
    private readonly SistemaVentasContext _context;
    
    public PedidosController(SistemaVentasContext context)
    {
        _context = context;
    }
    
    [HttpPost]
    public async Task<IActionResult> CrearPedido([FromBody] CrearPedidoDto pedidoDto)
    {
        // Validar que el usuario autenticado sea vendedor
        var vendedorId = User.FindFirst("VendedorId")?.Value;
        if (string.IsNullOrEmpty(vendedorId))
            return Unauthorized("Usuario no autorizado");
        
        // Construir XML para procedimiento almacenado
        var productosXml = new StringBuilder("<Productos>");
        foreach (var item in pedidoDto.Productos)
        {
            productosXml.Append($@"
                <Producto>
                    <ProductoID>{item.ProductoID}</ProductoID>
                    <Cantidad>{item.Cantidad}</Cantidad>
                    <PrecioUnitario>{item.PrecioUnitario}</PrecioUnitario>
                    <Descuento>{item.Descuento}</Descuento>
                </Producto>");
        }
        productosXml.Append("</Productos>");
        
        // Ejecutar procedimiento almacenado
        var parameters = new[]
        {
            new SqlParameter("@ClienteID", pedidoDto.ClienteID),
            new SqlParameter("@VendedorID", int.Parse(vendedorId)),
            new SqlParameter("@FechaEntrega", pedidoDto.FechaEntrega),
            new SqlParameter("@Observaciones", pedidoDto.Observaciones ?? (object)DBNull.Value),
            new SqlParameter("@Productos", SqlDbType.Xml) { Value = productosXml.ToString() }
        };
        
        try
        {
            var result = await _context.Database
                .ExecuteSqlRawAsync("EXEC Ventas.sp_RegistrarPedido @ClienteID, @VendedorID, @FechaEntrega, @Observaciones, @Productos", 
                                   parameters);
            
            return Ok(new { Success = true, Message = "Pedido registrado exitosamente" });
        }
        catch (SqlException ex)
        {
            return BadRequest(new { Success = false, Error = ex.Message });
        }
    }
}


EJEMPLO 3: AUTENTICACIÓN DE VENDEDORES
=======================================

// AuthController.cs
[ApiController]
[Route("api/[controller]")]
public class AuthController : ControllerBase
{
    private readonly SistemaVentasContext _context;
    private readonly IConfiguration _configuration;
    
    [HttpPost("login")]
    public async Task<IActionResult> Login([FromBody] LoginDto loginDto)
    {
        // Buscar usuario en tabla UsuariosApp
        var usuario = await _context.UsuariosApp
            .Include(u => u.Cliente)
            .FirstOrDefaultAsync(u => u.Username == loginDto.Username 
                                   && u.TipoApp == "Mobile"
                                   && u.Estado == true);
        
        if (usuario == null)
            return Unauthorized("Usuario no encontrado");
        
        // Verificar password (usar BCrypt o similar en producción)
        if (!VerificarPassword(loginDto.Password, usuario.PasswordHash))
            return Unauthorized("Contraseña incorrecta");
        
        // Actualizar último acceso
        usuario.UltimoAcceso = DateTime.Now;
        await _context.SaveChangesAsync();
        
        // Generar token JWT
        var token = GenerarTokenJWT(usuario);
        
        return Ok(new 
        { 
            Token = token,
            Usuario = new 
            {
                usuario.UsuarioAppID,
                usuario.Username,
                usuario.Cliente.Nombre,
                usuario.TipoApp
            }
        });
    }
    
    private string GenerarTokenJWT(UsuariosApp usuario)
    {
        var claims = new[]
        {
            new Claim(JwtRegisteredClaimNames.Sub, usuario.Username),
            new Claim("UsuarioAppID", usuario.UsuarioAppID.ToString()),
            new Claim("ClienteID", usuario.ClienteID.ToString()),
            new Claim(JwtRegisteredClaimNames.Jti, Guid.NewGuid().ToString())
        };
        
        var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_configuration["Jwt:Key"]));
        var creds = new SigningCredentials(key, SecurityAlgorithms.HmacSha256);
        
        var token = new JwtSecurityToken(
            issuer: _configuration["Jwt:Issuer"],
            audience: _configuration["Jwt:Audience"],
            claims: claims,
            expires: DateTime.Now.AddHours(8),
            signingCredentials: creds);
        
        return new JwtSecurityTokenHandler().WriteToken(token);
    }
}


EJEMPLO 4: CONSULTA SEGURA DE PRODUCTOS
========================================

// ProductosController.cs
[ApiController]
[Route("api/[controller]")]
[Authorize]
public class ProductosController : ControllerBase
{
    private readonly SistemaVentasContext _context;
    
    [HttpGet]
    public async Task<IActionResult> ObtenerProductos(
        [FromQuery] int? categoriaId,
        [FromQuery] string busqueda,
        [FromQuery] int page = 1,
        [FromQuery] int pageSize = 20)
    {
        // Vendedores solo pueden ver productos activos
        var query = _context.Productos
            .Where(p => p.Estado == true)
            .Include(p => p.Categoria)
            .AsQueryable();
        
        if (categoriaId.HasValue)
            query = query.Where(p => p.CategoriaID == categoriaId.Value);
        
        if (!string.IsNullOrEmpty(busqueda))
            query = query.Where(p => p.NombreProducto.Contains(busqueda) 
                                  || p.CodigoProducto.Contains(busqueda));
        
        var total = await query.CountAsync();
        var productos = await query
            .Skip((page - 1) * pageSize)
            .Take(pageSize)
            .Select(p => new 
            {
                p.ProductoID,
                p.CodigoProducto,
                p.NombreProducto,
                p.Descripcion,
                Categoria = p.Categoria.NombreCategoria,
                p.PrecioVenta, // Solo precio venta, NO costo
                p.Stock,
                Disponible = p.Stock > 0
            })
            .ToListAsync();
        
        return Ok(new 
        {
            Total = total,
            Page = page,
            PageSize = pageSize,
            TotalPages = (int)Math.Ceiling(total / (double)pageSize),
            Productos = productos
        });
    }
}


EJEMPLO 5: LOGGING Y AUDITORÍA
===============================

// AuditLoggerMiddleware.cs
public class AuditLoggerMiddleware
{
    private readonly RequestDelegate _next;
    
    public async Task InvokeAsync(HttpContext context, SistemaVentasContext dbContext)
    {
        var request = context.Request;
        var username = context.User?.Identity?.Name ?? "Anonymous";
        
        // Registrar operación
        var auditLog = new AuditLog
        {
            Usuario = username,
            Endpoint = $"{request.Method} {request.Path}",
            FechaHora = DateTime.Now,
            IPAddress = context.Connection.RemoteIpAddress?.ToString()
        };
        
        await _next(context);
        
        // Registrar resultado
        auditLog.StatusCode = context.Response.StatusCode;
        dbContext.AuditLogs.Add(auditLog);
        await dbContext.SaveChangesAsync();
    }
}


EJEMPLO 6: IMPLEMENTACIÓN EN NODE.JS/EXPRESS
=============================================

// db.js - Configuración de conexión
const sql = require('mssql');

const config = {
    user: 'BackendMobileApp',
    password: 'P@ssw0rd_Backend_2024!',
    server: 'servidor.database.windows.net',
    database: 'SistemaVentas',
    options: {
        encrypt: true,
        trustServerCertificate: false,
        enableArithAbort: true
    },
    pool: {
        max: 10,
        min: 0,
        idleTimeoutMillis: 30000
    }
};

const poolPromise = new sql.ConnectionPool(config)
    .connect()
    .then(pool => {
        console.log('Conectado a SQL Server');
        return pool;
    })
    .catch(err => console.log('Error de conexión BD:', err));

module.exports = { sql, poolPromise };

// pedidos.routes.js
const express = require('express');
const router = express.Router();
const { sql, poolPromise } = require('../db');
const authenticateToken = require('../middleware/auth');

router.post('/crear', authenticateToken, async (req, res) => {
    try {
        const pool = await poolPromise;
        const { clienteId, fechaEntrega, productos, observaciones } = req.body;
        const vendedorId = req.user.vendedorId;
        
        // Construir XML de productos
        let productosXml = '<Productos>';
        productos.forEach(prod => {
            productosXml += `
                <Producto>
                    <ProductoID>${prod.productoId}</ProductoID>
                    <Cantidad>${prod.cantidad}</Cantidad>
                    <PrecioUnitario>${prod.precioUnitario}</PrecioUnitario>
                    <Descuento>${prod.descuento || 0}</Descuento>
                </Producto>`;
        });
        productosXml += '</Productos>';
        
        // Ejecutar procedimiento almacenado
        const result = await pool.request()
            .input('ClienteID', sql.Int, clienteId)
            .input('VendedorID', sql.Int, vendedorId)
            .input('FechaEntrega', sql.Date, fechaEntrega)
            .input('Observaciones', sql.NVarChar, observaciones)
            .input('Productos', sql.Xml, productosXml)
            .execute('Ventas.sp_RegistrarPedido');
        
        res.json({ 
            success: true, 
            pedidoId: result.recordset[0].PedidoID,
            message: 'Pedido creado exitosamente' 
        });
        
    } catch (err) {
        console.error('Error al crear pedido:', err);
        res.status(500).json({ 
            success: false, 
            error: 'Error al procesar el pedido' 
        });
    }
});

module.exports = router;


SEGURIDAD EN BACKEND - CHECKLIST:
==================================
☑ Usar HTTPS/TLS para todas las comunicaciones
☑ Validar y sanitizar todos los inputs del cliente
☑ Usar parámetros en queries (evitar concatenación de strings)
☑ Implementar rate limiting para prevenir ataques DDoS
☑ Usar tokens JWT con expiración corta
☑ Almacenar passwords con bcrypt/argon2 (nunca en texto plano)
☑ Implementar logging de todas las operaciones
☑ Validar permisos del usuario en cada endpoint
☑ Usar variables de entorno para credenciales
☑ Implementar CORS restrictivo
☑ Manejar errores sin exponer detalles internos
☑ Implementar health checks y monitoring
☑ Rotar credenciales periódicamente
☑ Usar connection pooling para optimizar rendimiento
☑ Implementar circuit breaker para fallos de BD
*/