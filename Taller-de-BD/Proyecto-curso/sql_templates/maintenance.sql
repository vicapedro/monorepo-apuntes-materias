-- maintenance.sql
-- Planes de mantenimiento: índices y backups (ejemplos SQL Server)
USE IndiceTestDB;
GO

-- Ejemplo: rutina de chequeo de fragmentación y acciones
SELECT
  OBJECT_NAME(ips.object_id) AS table_name,
  i.name AS index_name,
  ips.avg_fragmentation_in_percent,
  ips.page_count
FROM sys.dm_db_index_physical_stats(DB_ID(), NULL, NULL, NULL, 'LIMITED') ips
JOIN sys.indexes i ON ips.object_id = i.object_id AND ips.index_id = i.index_id
WHERE ips.database_id = DB_ID()
AND ips.index_id > 0;
GO

-- Reorganize para fragmentación moderada (ejemplo)
ALTER INDEX ALL ON zoo.animal REORGANIZE;
GO

-- Rebuild para fragmentación alta (ejemplo)
ALTER INDEX ALL ON store.producto REBUILD WITH (FILLFACTOR = 80);
GO

-- Backup example (full)
BACKUP DATABASE IndiceTestDB TO DISK = 'C:\backups\IndiceTestDB_full.bak' WITH INIT;
GO

PRINT 'Maintenance scripts generated. Adapta rutas y permisos de backup.';
