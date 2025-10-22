-- indices_sqlserver_examples.sql
-- Ejemplos y pruebas de índices para SQL Server
-- Genera tablas de prueba, crea índices (heap, clustered, nonclustered), inserta datos,
-- mide fragmentación y muestra REORGANIZE / REBUILD.
-- Ejecutar en SSMS o con sqlcmd. Requiere permisos para crear bases de datos.

SET NOCOUNT ON;
GO

-- 1) Crear base de pruebas (cambiar nombre si existe)
IF DB_ID('IndiceTestDB') IS NOT NULL
BEGIN
    ALTER DATABASE IndiceTestDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE IndiceTestDB;
END
GO

CREATE DATABASE IndiceTestDB;
GO
USE IndiceTestDB;
GO

-- 2) Crear tabla de ejemplo (heap inicialmente)
CREATE SCHEMA dbo;
GO

CREATE TABLE dbo.producto_test (
  id INT IDENTITY(1,1) PRIMARY KEY CLUSTERED, -- inicialmente clustered para algunas secciones
  codigo VARCHAR(20) NOT NULL,
  nombre NVARCHAR(200) NOT NULL,
  categoria INT NOT NULL,
  precio DECIMAL(10,2) NULL,
  fecha_creacion DATETIME2 NOT NULL DEFAULT (SYSUTCDATETIME())
);
GO

-- Poblado masivo: generamos ~200000 filas con técnica de tally
SET NOCOUNT ON;
DECLARE @i INT = 0;
;WITH
E1(N) AS (SELECT 1 UNION ALL SELECT 1 UNION ALL SELECT 1 UNION ALL SELECT 1 UNION ALL SELECT 1
           UNION ALL SELECT 1 UNION ALL SELECT 1 UNION ALL SELECT 1 UNION ALL SELECT 1 UNION ALL SELECT 1), --10
E2(N) AS (SELECT 1 FROM E1 a CROSS JOIN E1 b), -- 100
E4(N) AS (SELECT ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) FROM E2 CROSS JOIN E2) -- 10k
INSERT INTO dbo.producto_test (codigo, nombre, categoria, precio)
SELECT
  'P' + RIGHT('0000000' + CAST(n AS VARCHAR(10)), 7) AS codigo,
  CONCAT('Producto ', n) AS nombre,
  (ABS(CHECKSUM(NEWID())) % 50) + 1 AS categoria,
  CAST((ABS(CHECKSUM(NEWID())) % 10000) / 100.0 AS DECIMAL(10,2)) AS precio
FROM E4; -- 10k

-- Insertar 10x para llegar a ~100k
DECLARE @round INT = 1;
WHILE @round <= 10
BEGIN
    INSERT INTO dbo.producto_test (codigo, nombre, categoria, precio)
    SELECT
      'P' + RIGHT('0000000' + CAST((n + (@round*10000)) AS VARCHAR(10)), 7) AS codigo,
      CONCAT('Producto_', @round, '_', n) AS nombre,
      (ABS(CHECKSUM(NEWID())) % 50) + 1 AS categoria,
      CAST((ABS(CHECKSUM(NEWID())) % 10000) / 100.0 AS DECIMAL(10,2)) AS precio
    FROM E4;
    SET @round += 1;
END
GO

-- 3) Medir estado inicial de índices
PRINT '--- Estado inicial de índices y fragmentación ---';
SELECT
  DB_NAME() AS database_name,
  OBJECT_NAME(i.object_id) AS table_name,
  i.name AS index_name,
  ips.index_type_desc,
  ips.avg_fragmentation_in_percent,
  ips.page_count
FROM sys.dm_db_index_physical_stats(DB_ID(), NULL, NULL, NULL, 'LIMITED') ips
JOIN sys.indexes i ON ips.object_id = i.object_id AND ips.index_id = i.index_id
WHERE ips.database_id = DB_ID();
GO

-- 4) Crear un índice nonclustered sobre 'codigo' sin INCLUDE
CREATE NONCLUSTERED INDEX ix_producto_codigo ON dbo.producto_test(codigo);
GO

-- 5) Crear un índice nonclustered cubriente (INCLUDE)
CREATE NONCLUSTERED INDEX ix_producto_categoria_nombre
ON dbo.producto_test (categoria)
INCLUDE (nombre, precio);
GO

-- 6) Medir fragmentación después de creación
PRINT '--- Fragmentación después de crear índices ---';
SELECT
  OBJECT_NAME(ips.object_id) AS table_name,
  i.name AS index_name,
  ips.index_type_desc,
  ips.avg_fragmentation_in_percent,
  ips.page_count
FROM sys.dm_db_index_physical_stats(DB_ID(), NULL, NULL, NULL, 'LIMITED') ips
JOIN sys.indexes i ON ips.object_id = i.object_id AND ips.index_id = i.index_id
WHERE ips.database_id = DB_ID();
GO

-- 7) Insertar más datos para forzar splits y observar FILLFACTOR
PRINT '--- Insertar filas adicionales (para fragmentar) ---';
INSERT INTO dbo.producto_test (codigo, nombre, categoria, precio)
SELECT
  'P' + RIGHT('0000000' + CAST(ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS VARCHAR(10)),7),
  'Extra_' + CAST(ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS VARCHAR(20)),
  (ABS(CHECKSUM(NEWID())) % 50) + 1,
  CAST((ABS(CHECKSUM(NEWID())) % 10000) / 100.0 AS DECIMAL(10,2))
FROM (SELECT TOP (50000) ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) n FROM sys.objects a CROSS JOIN sys.columns b) x;
GO

-- 8) Volver a medir fragmentación
PRINT '--- Fragmentación después de inserciones adicionales ---';
SELECT
  OBJECT_NAME(ips.object_id) AS table_name,
  i.name AS index_name,
  ips.index_type_desc,
  ips.avg_fragmentation_in_percent,
  ips.page_count
FROM sys.dm_db_index_physical_stats(DB_ID(), NULL, NULL, NULL, 'LIMITED') ips
JOIN sys.indexes i ON ips.object_id = i.object_id AND ips.index_id = i.index_id
WHERE ips.database_id = DB_ID();
GO

-- 9) Ajustar FILLFACTOR (rebuild) y comparar
PRINT '--- REBUILD con FILLFACTOR = 80 ---';
ALTER INDEX ix_producto_codigo ON dbo.producto_test REBUILD WITH (FILLFACTOR = 80);
ALTER INDEX ix_producto_categoria_nombre ON dbo.producto_test REBUILD WITH (FILLFACTOR = 80);
GO

SELECT
  OBJECT_NAME(ips.object_id) AS table_name,
  i.name AS index_name,
  ips.index_type_desc,
  ips.avg_fragmentation_in_percent,
  ips.page_count
FROM sys.dm_db_index_physical_stats(DB_ID(), NULL, NULL, NULL, 'LIMITED') ips
JOIN sys.indexes i ON ips.object_id = i.object_id AND ips.index_id = i.index_id
WHERE ips.database_id = DB_ID();
GO

-- 10) REORGANIZE ejemplo (si no quieres un rebuild completo)
PRINT '--- REORGANIZE de índices ---';
ALTER INDEX ix_producto_codigo ON dbo.producto_test REORGANIZE;
ALTER INDEX ix_producto_categoria_nombre ON dbo.producto_test REORGANIZE;
GO

-- 11) Prueba de índice único y comportamiento con duplicados
PRINT '--- Prueba índice UNIQUE ---';
-- crear tabla de prueba para UNIQUE
CREATE TABLE dbo.usuario_test (
  id INT IDENTITY(1,1) PRIMARY KEY,
  email VARCHAR(200) NULL
);
GO

INSERT INTO dbo.usuario_test (email)
VALUES ('a@example.com'), (NULL), (NULL), ('b@example.com');
GO
-- intenta crear índice único (fallará si hay duplicados no-nulos repetidos)
BEGIN TRY
  CREATE UNIQUE INDEX ux_usuario_email ON dbo.usuario_test(email);
  PRINT 'Índice único creado correctamente.';
END TRY
BEGIN CATCH
  PRINT 'Error creando índice único:';
  PRINT ERROR_MESSAGE();
END CATCH
GO

-- 12) Ejemplos de consultas para analizar índices y uso
PRINT '--- Uso e información de índices ---';
SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID('dbo.producto_test');
SELECT * FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND object_id = OBJECT_ID('dbo.producto_test');
GO

-- 13) Limpieza opcional (descomentar para eliminar la DB al final)
--USE master; DROP DATABASE IndiceTestDB;
--GO

PRINT 'Script finalizado.';
GO
