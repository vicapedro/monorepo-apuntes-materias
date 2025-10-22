-- security.sql
-- Roles y permisos sugeridos para Zaboo Mazoo (SQL Server sintaxis)
USE IndiceTestDB;
GO

-- Crear roles (db roles)
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = 'zoo_admin')
  EXEC sp_addrole 'zoo_admin';
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = 'zoo_vet')
  EXEC sp_addrole 'zoo_vet';
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = 'zoo_taquilla')
  EXEC sp_addrole 'zoo_taquilla';
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = 'zoo_store')
  EXEC sp_addrole 'zoo_store';
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = 'zoo_auditor')
  EXEC sp_addrole 'zoo_auditor';
GO

-- Ejemplos de asignación de permisos (ajustar según usuario)
-- db_owner para administradores (usar con cautela)
EXEC sp_addrolemember 'zoo_admin','sa';
GO

-- Veterinarios: SELECT/INSERT en registros vet y SELECT en tablas de animales
GRANT SELECT, INSERT, UPDATE ON zoo.registro_vet TO zoo_vet;
GRANT SELECT ON zoo.animal TO zoo_vet;
GO

-- Taquilla: INSERT en entradas, SELECT en visitantes
GRANT INSERT ON zoo.entrada TO zoo_taquilla;
GRANT SELECT ON zoo.visitante TO zoo_taquilla;
GO

-- Tienda: CRUD limitado sobre productos y ventas
GRANT SELECT, INSERT, UPDATE ON store.producto TO zoo_store;
GRANT INSERT ON store.venta TO zoo_store;
GO

-- Auditor: solo SELECT en schema audit
GRANT SELECT ON SCHEMA::audit TO zoo_auditor;
GO

PRINT 'Roles y permisos sugeridos creados. Ajusta según políticas institucionales.';
