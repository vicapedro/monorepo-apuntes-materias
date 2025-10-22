-- create_schema.sql
-- Plantilla DDL para el proyecto Zaboo Mazoo (ajustar tipos y opciones según SGBD: SQL Server / MariaDB / PostgreSQL)

-- Ejemplo para SQL Server
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'zoo')
  EXEC('CREATE SCHEMA zoo');
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'store')
  EXEC('CREATE SCHEMA store');
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'audit')
  EXEC('CREATE SCHEMA audit');

USE [IndiceTestDB]; -- Cambiar por la DB objetivo
GO

-- Tabla Especies
CREATE TABLE zoo.especie (
  especie_id INT IDENTITY(1,1) PRIMARY KEY,
  nombre_comun NVARCHAR(200) NOT NULL,
  nombre_cientifico NVARCHAR(200),
  estado_conservacion VARCHAR(50)
);

-- Tabla Habitat
CREATE TABLE zoo.habitat (
  habitat_id INT IDENTITY(1,1) PRIMARY KEY,
  nombre NVARCHAR(200) NOT NULL,
  capacidad INT NOT NULL,
  tipo VARCHAR(50)
);

-- Tabla Animal
CREATE TABLE zoo.animal (
  animal_id INT IDENTITY(1,1) PRIMARY KEY,
  nombre NVARCHAR(200),
  especie_id INT NOT NULL,
  fecha_nacimiento DATE NULL,
  sexo CHAR(1),
  peso DECIMAL(6,2),
  habitat_id INT NULL,
  CONSTRAINT fk_animal_especie FOREIGN KEY (especie_id) REFERENCES zoo.especie(especie_id),
  CONSTRAINT fk_animal_habitat FOREIGN KEY (habitat_id) REFERENCES zoo.habitat(habitat_id)
);

-- Tabla Empleado
CREATE TABLE zoo.empleado (
  empleado_id INT IDENTITY(1,1) PRIMARY KEY,
  nombre NVARCHAR(200) NOT NULL,
  puesto VARCHAR(100),
  fecha_ingreso DATE,
  salario DECIMAL(10,2)
);

-- Tabla Veterinaria (registro de atención)
CREATE TABLE zoo.registro_vet (
  registro_id INT IDENTITY(1,1) PRIMARY KEY,
  animal_id INT NOT NULL,
  empleado_id INT NULL,
  fecha DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
  nota NVARCHAR(2000),
  CONSTRAINT fk_registro_animal FOREIGN KEY (animal_id) REFERENCES zoo.animal(animal_id),
  CONSTRAINT fk_registro_empleado FOREIGN KEY (empleado_id) REFERENCES zoo.empleado(empleado_id)
);

-- Tabla Visitante
CREATE TABLE zoo.visitante (
  visitante_id INT IDENTITY(1,1) PRIMARY KEY,
  nombre NVARCHAR(200),
  email VARCHAR(200),
  telefono VARCHAR(50)
);

-- Tabla Entrada
CREATE TABLE zoo.entrada (
  entrada_id INT IDENTITY(1,1) PRIMARY KEY,
  visitante_id INT NOT NULL,
  fecha DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
  tipo VARCHAR(50),
  precio DECIMAL(10,2),
  CONSTRAINT fk_entrada_visitante FOREIGN KEY (visitante_id) REFERENCES zoo.visitante(visitante_id)
);

-- Tabla Producto (tienda)
CREATE TABLE store.producto (
  producto_id INT IDENTITY(1,1) PRIMARY KEY,
  sku VARCHAR(50) NOT NULL,
  nombre NVARCHAR(200),
  precio DECIMAL(10,2),
  stock INT DEFAULT 0
);

-- Tabla Venta
CREATE TABLE store.venta (
  venta_id INT IDENTITY(1,1) PRIMARY KEY,
  producto_id INT NOT NULL,
  cantidad INT NOT NULL,
  fecha DATETIME2 DEFAULT SYSUTCDATETIME(),
  CONSTRAINT fk_venta_producto FOREIGN KEY (producto_id) REFERENCES store.producto(producto_id)
);

-- Audits: tabla base
CREATE TABLE audit.auditoria (
  audit_id INT IDENTITY(1,1) PRIMARY KEY,
  schema_name SYSNAME,
  table_name SYSNAME,
  operacion VARCHAR(20),
  usuario SYSNAME,
  fecha DATETIME2 DEFAULT SYSUTCDATETIME(),
  detalle NVARCHAR(4000)
);

PRINT 'DDL base creado. Ajusta tipos y constraints adicionales según tu diseño.';
