# Práctica de Laboratorio 2: DDL Avanzado y Constraints

## Objetivo
**Duración estimada**: 4 horas

Crear esquemas de bases de datos complejos aplicando DDL avanzado, implementando constraints de integridad referencial y validando reglas de negocio mediante restricciones técnicas en diferentes SGBD.

## Competencias a Desarrollar
- Crea esquemas de bases de datos normalizados y optimizados
- Implementa constraints complejos para garantizar integridad de datos
- Aplica técnicas avanzadas de DDL específicas por SGBD
- Valida y documenta reglas de negocio mediante constraints técnicos

## Introducción

En entornos empresariales, los esquemas de bases de datos deben garantizar la integridad, consistencia y calidad de los datos mediante constraints apropiados. Esta práctica te permitirá implementar un sistema complejo que simula requerimientos reales de negocio.

### Contexto Empresarial
Una cadena de restaurantes multinacional requiere un sistema de gestión integral que maneje:
- **Múltiples sucursales** en diferentes países
- **Gestión de personal** con roles y permisos específicos  
- **Control de inventario** con proveedores múltiples
- **Sistema de ventas** con diferentes métodos de pago
- **Programa de lealtad** para clientes frecuentes

## Equipo de Protección e Higiene
- Backup de bases de datos existentes antes de crear nuevos esquemas
- Documentar todos los cambios realizados
- Verificar permisos de usuario antes de ejecutar DDL

## Material y Equipo Necesario

### Materiales e Insumos
- Los 3 SGBD instalados en la práctica anterior (MySQL, PostgreSQL, SQL Server)
- Scripts de datos de prueba proporcionados
- Diagramas ER del sistema de restaurantes
- Templates de constraints por SGBD

### Equipo de Laboratorio
- Herramientas de administración configuradas (Workbench, pgAdmin, SSMS)
- Editor de código con syntax highlighting para SQL
- Herramienta de modelado ER (draw.io o Lucidchart)

### Herramientas
- Cliente de línea de comandos para cada SGBD
- Scripts de validación de integridad
- Generador de datos de prueba

## Instrucciones

### Fase 1: Análisis y Diseño del Esquema (45 minutos)

#### Paso 1.1: Análisis de Requerimientos
**Lee cuidadosamente estos requerimientos funcionales:**

**RF-1: Gestión de Sucursales**
- Cada sucursal tiene código único, nombre, dirección completa
- Sucursales operan en diferentes países con monedas locales
- Horarios de operación variables por sucursal
- Capacidad de asientos y área en m² por sucursal

**RF-2: Gestión de Personal**  
- Empleados con información personal completa
- Roles: Gerente, Chef, Mesero, Cajero, Limpieza
- Salarios en moneda local de la sucursal
- Horarios de trabajo y días laborales
- Historial laboral (sucursal anterior, fechas)

**RF-3: Gestión de Proveedores e Inventario**
- Proveedores con información de contacto completa
- Productos con códigos internacionales únicos
- Categorías de productos (Carnes, Verduras, Bebidas, etc.)
- Precios por proveedor y sucursal
- Stock mínimo y máximo por producto/sucursal
- Fechas de vencimiento para productos perecederos

**RF-4: Sistema de Ventas**
- Mesas numeradas por sucursal
- Órdenes con múltiples productos
- Métodos de pago: Efectivo, Tarjeta, Digital
- Propinas y descuentos aplicables
- Facturación con datos fiscales

**RF-5: Programa de Lealtad**
- Clientes con membresía de lealtad
- Niveles: Bronce, Plata, Oro, Platinum
- Puntos acumulables por compra
- Descuentos por nivel de membresía
- Historial de visitas por sucursal

#### Paso 1.2: Diseño del Modelo ER
Crea un diagrama ER que incluya **mínimo estas entidades**:

```
ENTIDADES PRINCIPALES:
- Países (pais_id, nombre, codigo_iso, moneda)
- Sucursales (sucursal_id, codigo, nombre, pais_id, direccion, capacidad_asientos)
- Empleados (empleado_id, cedula, nombre, apellidos, email, telefono, sucursal_id, rol)
- Proveedores (proveedor_id, nombre_empresa, contacto, email, telefono, pais_id)
- Categorias_Producto (categoria_id, nombre, descripcion)
- Productos (producto_id, codigo_internacional, nombre, categoria_id, es_perecedero)
- Clientes (cliente_id, cedula, nombre, apellidos, email, telefono, nivel_lealtad)
- Mesas (mesa_id, numero, sucursal_id, capacidad_personas)
- Ordenes (orden_id, mesa_id, cliente_id, empleado_mesero_id, fecha_hora, subtotal, impuestos, propina, total)
- Detalle_Orden (detalle_id, orden_id, producto_id, cantidad, precio_unitario)
```

**Relaciones principales a modelar:**
- Sucursales pertenecen a países (1:N)
- Empleados trabajan en sucursales (N:1)  
- Productos pertenecen a categorías (N:1)
- Órdenes se realizan en mesas (N:1)
- Clientes realizan órdenes (1:N)
- Órdenes contienen múltiples productos (M:N a través de Detalle_Orden)

#### Paso 1.3: Normalización a 3FN
Verifica que tu diseño esté normalizado:

**1FN**: ¿Todos los campos contienen valores atómicos?
**2FN**: ¿Campos no-clave dependen completamente de la clave primaria?
**3FN**: ¿No existen dependencias transitivas?

**Documenta cualquier decisión de desnormalización justificada.**

### Fase 2: Implementación en MySQL (60 minutos)

#### Paso 2.1: Creación de Base de Datos y Configuración
```sql
-- Crear base de datos con configuración específica
CREATE DATABASE restaurantes_mysql 
CHARACTER SET utf8mb4 
COLLATE utf8mb4_unicode_ci;

USE restaurantes_mysql;

-- Configurar variables de sesión
SET sql_mode = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
SET foreign_key_checks = 1;
```

#### Paso 2.2: Creación de Tablas Base con Constraints Básicos
```sql
-- =====================================================
-- TABLA: paises - Información de países operativos
-- =====================================================
CREATE TABLE paises (
    pais_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL UNIQUE,
    codigo_iso CHAR(3) NOT NULL UNIQUE COMMENT 'Código ISO 3166-1 alpha-3',
    moneda VARCHAR(3) NOT NULL COMMENT 'Código de moneda ISO 4217',
    prefijo_telefonico VARCHAR(5),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    -- Constraints de validación
    CONSTRAINT chk_paises_codigo_iso CHECK (LENGTH(codigo_iso) = 3),
    CONSTRAINT chk_paises_moneda CHECK (LENGTH(moneda) = 3)
) ENGINE=InnoDB COMMENT='Países donde operan las sucursales';

-- =====================================================
-- TABLA: sucursales - Información de cada restaurante
-- =====================================================
CREATE TABLE sucursales (
    sucursal_id INT AUTO_INCREMENT PRIMARY KEY,
    codigo VARCHAR(20) NOT NULL UNIQUE COMMENT 'Código interno de sucursal',
    nombre VARCHAR(150) NOT NULL,
    pais_id INT NOT NULL,
    direccion_completa TEXT NOT NULL,
    ciudad VARCHAR(100) NOT NULL,
    codigo_postal VARCHAR(20),
    telefono VARCHAR(20),
    email VARCHAR(150),
    capacidad_asientos INT NOT NULL DEFAULT 0,
    area_m2 DECIMAL(8,2),
    fecha_apertura DATE,
    activa BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    -- Foreign Keys
    FOREIGN KEY (pais_id) REFERENCES paises(pais_id) ON UPDATE CASCADE ON DELETE RESTRICT,
    
    -- Constraints de validación
    CONSTRAINT chk_sucursales_capacidad CHECK (capacidad_asientos > 0),
    CONSTRAINT chk_sucursales_area CHECK (area_m2 IS NULL OR area_m2 > 0),
    CONSTRAINT chk_sucursales_fecha_apertura CHECK (fecha_apertura <= CURDATE()),
    
    -- Índices para optimización
    INDEX idx_sucursales_pais (pais_id),
    INDEX idx_sucursales_activa (activa),
    INDEX idx_sucursales_ciudad (ciudad)
) ENGINE=InnoDB COMMENT='Sucursales de restaurantes por país';

-- =====================================================
-- TABLA: empleados - Personal de todas las sucursales
-- =====================================================
CREATE TABLE empleados (
    empleado_id INT AUTO_INCREMENT PRIMARY KEY,
    cedula VARCHAR(20) NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    apellidos VARCHAR(150) NOT NULL,
    email VARCHAR(200) UNIQUE,
    telefono VARCHAR(20),
    fecha_nacimiento DATE,
    sucursal_id INT NOT NULL,
    rol ENUM('Gerente', 'Chef', 'Sous_Chef', 'Mesero', 'Cajero', 'Limpieza', 'Seguridad') NOT NULL,
    salario_mensual DECIMAL(10,2) NOT NULL,
    fecha_ingreso DATE NOT NULL DEFAULT (CURDATE()),
    fecha_salida DATE NULL,
    activo BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    -- Foreign Keys
    FOREIGN KEY (sucursal_id) REFERENCES sucursales(sucursal_id) ON UPDATE CASCADE ON DELETE RESTRICT,
    
    -- Constraints de validación
    CONSTRAINT chk_empleados_salario CHECK (salario_mensual > 0),
    CONSTRAINT chk_empleados_fecha_nacimiento CHECK (fecha_nacimiento < CURDATE() - INTERVAL 16 YEAR),
    CONSTRAINT chk_empleados_fechas_laborales CHECK (fecha_salida IS NULL OR fecha_salida >= fecha_ingreso),
    CONSTRAINT chk_empleados_email CHECK (email REGEXP '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$'),
    
    -- Unique constraints compuestos
    UNIQUE KEY uk_empleados_cedula_sucursal (cedula, sucursal_id),
    
    -- Índices para optimización  
    INDEX idx_empleados_sucursal_rol (sucursal_id, rol),
    INDEX idx_empleados_activo (activo),
    INDEX idx_empleados_fecha_ingreso (fecha_ingreso)
) ENGINE=InnoDB COMMENT='Empleados de todas las sucursales';
```

#### Paso 2.3: Implementación de Constraints Avanzados
```sql
-- =====================================================
-- CONSTRAINTS AVANZADOS Y TRIGGERS
-- =====================================================

-- Trigger para validar solo un gerente por sucursal
DELIMITER //
CREATE TRIGGER trg_empleados_un_gerente_por_sucursal
BEFORE INSERT ON empleados
FOR EACH ROW
BEGIN
    DECLARE gerentes_existentes INT;
    
    IF NEW.rol = 'Gerente' AND NEW.activo = TRUE THEN
        SELECT COUNT(*) INTO gerentes_existentes
        FROM empleados 
        WHERE sucursal_id = NEW.sucursal_id 
          AND rol = 'Gerente' 
          AND activo = TRUE;
          
        IF gerentes_existentes > 0 THEN
            SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = 'Ya existe un gerente activo en esta sucursal';
        END IF;
    END IF;
END//

-- Trigger para validar horarios de empleados
CREATE TRIGGER trg_empleados_validar_horarios
BEFORE UPDATE ON empleados  
FOR EACH ROW
BEGIN
    -- Si se está reactivando un gerente, validar unicidad
    IF OLD.rol = 'Gerente' AND NEW.rol = 'Gerente' AND OLD.activo = FALSE AND NEW.activo = TRUE THEN
        IF (SELECT COUNT(*) FROM empleados WHERE sucursal_id = NEW.sucursal_id AND rol = 'Gerente' AND activo = TRUE) > 0 THEN
            SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = 'Ya existe un gerente activo en esta sucursal';
        END IF;
    END IF;
END//
DELIMITER ;

-- =====================================================
-- TABLAS ADICIONALES CON CONSTRAINTS COMPLEJOS
-- =====================================================

-- Tabla de categorías de productos
CREATE TABLE categorias_producto (
    categoria_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL UNIQUE,
    descripcion TEXT,
    requiere_refrigeracion BOOLEAN DEFAULT FALSE,
    vida_util_dias INT COMMENT 'Días de vida útil promedio',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    CONSTRAINT chk_categorias_vida_util CHECK (vida_util_dias IS NULL OR vida_util_dias > 0)
) ENGINE=InnoDB;

-- Tabla de productos con constraints complejos
CREATE TABLE productos (
    producto_id INT AUTO_INCREMENT PRIMARY KEY,
    codigo_internacional VARCHAR(50) NOT NULL UNIQUE COMMENT 'Código de barras o SKU internacional',
    nombre VARCHAR(200) NOT NULL,
    descripcion TEXT,
    categoria_id INT NOT NULL,
    es_perecedero BOOLEAN NOT NULL DEFAULT FALSE,
    requiere_preparacion BOOLEAN NOT NULL DEFAULT TRUE,
    tiempo_preparacion_min INT COMMENT 'Tiempo de preparación en minutos',
    calorias_por_porcion INT,
    precio_sugerido DECIMAL(8,2),
    activo BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (categoria_id) REFERENCES categorias_producto(categoria_id) ON UPDATE CASCADE ON DELETE RESTRICT,
    
    -- Constraints de validación complejos
    CONSTRAINT chk_productos_tiempo_preparacion CHECK (
        (requiere_preparacion = FALSE AND tiempo_preparacion_min IS NULL) OR
        (requiere_preparacion = TRUE AND tiempo_preparacion_min > 0)
    ),
    CONSTRAINT chk_productos_calorias CHECK (calorias_por_porcion IS NULL OR calorias_por_porcion >= 0),
    CONSTRAINT chk_productos_precio CHECK (precio_sugerido IS NULL OR precio_sugerido > 0),
    
    INDEX idx_productos_categoria_activo (categoria_id, activo),
    INDEX idx_productos_perecedero (es_perecedero)
) ENGINE=InnoDB;
```

### Fase 3: Implementación en PostgreSQL (60 minutos)

#### Paso 3.1: Adaptación de Esquema para PostgreSQL
```sql
-- Conectar a PostgreSQL
\c postgres
DROP DATABASE IF EXISTS restaurantes_postgresql;
CREATE DATABASE restaurantes_postgresql WITH ENCODING 'UTF8';
\c restaurantes_postgresql

-- Crear esquemas para organización
CREATE SCHEMA configuracion;
CREATE SCHEMA operaciones;
CREATE SCHEMA ventas;

-- =====================================================
-- TABLAS BASE CON FEATURES ESPECÍFICOS DE POSTGRESQL
-- =====================================================

-- Tabla de países con validaciones avanzadas
CREATE TABLE configuracion.paises (
    pais_id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL UNIQUE,
    codigo_iso CHAR(3) NOT NULL UNIQUE,
    moneda VARCHAR(3) NOT NULL,
    prefijo_telefonico VARCHAR(5),
    timezone VARCHAR(50) DEFAULT 'UTC',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    
    -- Constraints con expresiones regulares de PostgreSQL
    CONSTRAINT chk_paises_codigo_iso CHECK (codigo_iso ~ '^[A-Z]{3}$'),
    CONSTRAINT chk_paises_moneda CHECK (moneda ~ '^[A-Z]{3}$'),
    CONSTRAINT chk_paises_prefijo CHECK (prefijo_telefonico IS NULL OR prefijo_telefonico ~ '^\+[0-9]{1,4}$')
);

-- Trigger function para actualizar updated_at
CREATE OR REPLACE FUNCTION actualizar_timestamp()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Aplicar trigger a paises
CREATE TRIGGER trg_paises_updated_at
    BEFORE UPDATE ON configuracion.paises
    FOR EACH ROW
    EXECUTE FUNCTION actualizar_timestamp();

-- Tabla de sucursales con tipos de datos específicos de PostgreSQL
CREATE TABLE configuracion.sucursales (
    sucursal_id SERIAL PRIMARY KEY,
    codigo VARCHAR(20) NOT NULL UNIQUE,
    nombre VARCHAR(150) NOT NULL,
    pais_id INTEGER NOT NULL REFERENCES configuracion.paises(pais_id),
    direccion_completa TEXT NOT NULL,
    coordenadas POINT, -- Tipo geométrico de PostgreSQL
    ciudad VARCHAR(100) NOT NULL,
    codigo_postal VARCHAR(20),
    telefono VARCHAR(20),
    email VARCHAR(150),
    capacidad_asientos INTEGER NOT NULL DEFAULT 0 CHECK (capacidad_asientos > 0),
    area_m2 DECIMAL(8,2) CHECK (area_m2 IS NULL OR area_m2 > 0),
    horario_operacion JSONB, -- Almacenar horarios como JSON
    fecha_apertura DATE CHECK (fecha_apertura <= CURRENT_DATE),
    activa BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE TRIGGER trg_sucursales_updated_at
    BEFORE UPDATE ON configuracion.sucursales
    FOR EACH ROW
    EXECUTE FUNCTION actualizar_timestamp();

-- Índice GIN para búsquedas JSON en horarios
CREATE INDEX idx_sucursales_horario ON configuracion.sucursales USING GIN (horario_operacion);

-- Tabla de empleados con arrays y ENUMs personalizados
CREATE TYPE tipo_rol AS ENUM ('Gerente', 'Chef', 'Sous_Chef', 'Mesero', 'Cajero', 'Limpieza', 'Seguridad');
CREATE TYPE nivel_lealtad AS ENUM ('Bronce', 'Plata', 'Oro', 'Platinum');

CREATE TABLE operaciones.empleados (
    empleado_id SERIAL PRIMARY KEY,
    cedula VARCHAR(20) NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    apellidos VARCHAR(150) NOT NULL,
    nombre_completo VARCHAR(300) GENERATED ALWAYS AS (nombre || ' ' || apellidos) STORED,
    email VARCHAR(200) UNIQUE,
    telefono VARCHAR(20),
    fecha_nacimiento DATE,
    sucursal_id INTEGER NOT NULL REFERENCES configuracion.sucursales(sucursal_id),
    rol tipo_rol NOT NULL,
    habilidades TEXT[], -- Array de habilidades
    idiomas VARCHAR(10)[] DEFAULT ARRAY['ES'], -- Array de códigos de idioma
    salario_mensual DECIMAL(10,2) NOT NULL CHECK (salario_mensual > 0),
    fecha_ingreso DATE NOT NULL DEFAULT CURRENT_DATE,
    fecha_salida DATE,
    activo BOOLEAN NOT NULL DEFAULT TRUE,
    notas_adicionales JSONB,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    
    -- Constraints complejos
    CONSTRAINT chk_empleados_edad CHECK (fecha_nacimiento < CURRENT_DATE - INTERVAL '16 years'),
    CONSTRAINT chk_empleados_fechas CHECK (fecha_salida IS NULL OR fecha_salida >= fecha_ingreso),
    CONSTRAINT chk_empleados_email CHECK (email ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'),
    
    -- Constraint de exclusión: solo un gerente activo por sucursal
    EXCLUDE USING btree (sucursal_id WITH =) WHERE (rol = 'Gerente' AND activo = TRUE)
);

CREATE TRIGGER trg_empleados_updated_at
    BEFORE UPDATE ON operaciones.empleados
    FOR EACH ROW
    EXECUTE FUNCTION actualizar_timestamp();
```

#### Paso 3.2: Funciones Avanzadas de PostgreSQL
```sql
-- =====================================================
-- FUNCIONES PERSONALIZADAS
-- =====================================================

-- Función para validar códigos internacionales de productos
CREATE OR REPLACE FUNCTION validar_codigo_internacional(codigo TEXT)
RETURNS BOOLEAN AS $$
BEGIN
    -- Validar formato de código de barras EAN-13 o UPC
    RETURN (
        LENGTH(codigo) = 13 AND codigo ~ '^[0-9]{13}$' OR
        LENGTH(codigo) = 12 AND codigo ~ '^[0-9]{12}$' OR
        codigo ~ '^[A-Z0-9]{6,20}$' -- SKU personalizado
    );
END;
$$ LANGUAGE plpgsql;

-- Función para calcular descuento por nivel de lealtad
CREATE OR REPLACE FUNCTION calcular_descuento_lealtad(nivel nivel_lealtad, monto DECIMAL)
RETURNS DECIMAL AS $$
BEGIN
    RETURN CASE nivel
        WHEN 'Bronce' THEN monto * 0.05    -- 5%
        WHEN 'Plata' THEN monto * 0.10     -- 10%
        WHEN 'Oro' THEN monto * 0.15       -- 15%
        WHEN 'Platinum' THEN monto * 0.20  -- 20%
        ELSE 0
    END;
END;
$$ LANGUAGE plpgsql;

-- =====================================================
-- TABLAS CON FEATURES AVANZADOS
-- =====================================================

CREATE TABLE operaciones.productos (
    producto_id SERIAL PRIMARY KEY,
    codigo_internacional VARCHAR(50) NOT NULL UNIQUE,
    nombre VARCHAR(200) NOT NULL,
    descripcion TEXT,
    categoria_id INTEGER NOT NULL,
    es_perecedero BOOLEAN NOT NULL DEFAULT FALSE,
    requiere_preparacion BOOLEAN NOT NULL DEFAULT TRUE,
    tiempo_preparacion_min INTEGER,
    informacion_nutricional JSONB, -- JSON con información nutricional completa
    precio_sugerido DECIMAL(8,2),
    tags TEXT[] DEFAULT ARRAY[]::TEXT[], -- Tags para búsqueda
    activo BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    
    -- Usar función personalizada para validación
    CONSTRAINT chk_productos_codigo CHECK (validar_codigo_internacional(codigo_internacional)),
    CONSTRAINT chk_productos_tiempo_preparacion CHECK (
        (requiere_preparacion = FALSE AND tiempo_preparacion_min IS NULL) OR
        (requiere_preparacion = TRUE AND tiempo_preparacion_min > 0)
    ),
    CONSTRAINT chk_productos_precio CHECK (precio_sugerido IS NULL OR precio_sugerido > 0)
);

-- Índice para búsqueda de texto completo en nombres y tags
CREATE INDEX idx_productos_busqueda ON operaciones.productos USING GIN (
    to_tsvector('spanish', nombre || ' ' || COALESCE(descripcion, '') || ' ' || array_to_string(tags, ' '))
);

-- Índice GIN para información nutricional JSON
CREATE INDEX idx_productos_nutricion ON operaciones.productos USING GIN (informacion_nutricional);
```

### Fase 4: Implementación en SQL Server (60 minutos)

#### Paso 4.1: Creación de Esquema con Features de SQL Server
```sql
-- Crear base de datos con configuración específica
CREATE DATABASE restaurantes_sqlserver
ON (
    NAME = 'restaurantes_data',
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\restaurantes.mdf',
    SIZE = 100MB,
    MAXSIZE = 1GB,
    FILEGROWTH = 10MB
)
LOG ON (
    NAME = 'restaurantes_log',
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\restaurantes.ldf',
    SIZE = 10MB,
    FILEGROWTH = 5MB
);

USE restaurantes_sqlserver;

-- Crear esquemas para organización
CREATE SCHEMA configuracion;
CREATE SCHEMA operaciones;
CREATE SCHEMA ventas;
CREATE SCHEMA reportes;

-- =====================================================
-- TABLAS CON FEATURES ESPECÍFICOS DE SQL SERVER
-- =====================================================

-- Tabla de países con columnas calculadas
CREATE TABLE configuracion.paises (
    pais_id INT IDENTITY(1,1) PRIMARY KEY,
    nombre NVARCHAR(100) NOT NULL UNIQUE,
    codigo_iso CHAR(3) NOT NULL UNIQUE,
    moneda VARCHAR(3) NOT NULL,
    prefijo_telefonico VARCHAR(5),
    -- Columna calculada que combina código y nombre
    codigo_nombre AS (codigo_iso + ' - ' + nombre) PERSISTED,
    created_at DATETIME2 DEFAULT SYSDATETIME(),
    updated_at DATETIME2 DEFAULT SYSDATETIME(),
    
    -- Constraints con funciones de SQL Server
    CONSTRAINT chk_paises_codigo_iso CHECK (LEN(codigo_iso) = 3 AND codigo_iso NOT LIKE '%[^A-Z]%'),
    CONSTRAINT chk_paises_moneda CHECK (LEN(moneda) = 3 AND moneda NOT LIKE '%[^A-Z]%')
);

-- Trigger para actualizar updated_at
CREATE TRIGGER trg_paises_updated_at
ON configuracion.paises
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE configuracion.paises
    SET updated_at = SYSDATETIME()
    FROM configuracion.paises p
    INNER JOIN inserted i ON p.pais_id = i.pais_id;
END;

-- Tabla de sucursales con tipos de datos espaciales
CREATE TABLE configuracion.sucursales (
    sucursal_id INT IDENTITY(1,1) PRIMARY KEY,
    codigo VARCHAR(20) NOT NULL UNIQUE,
    nombre NVARCHAR(150) NOT NULL,
    pais_id INT NOT NULL REFERENCES configuracion.paises(pais_id),
    direccion_completa NVARCHAR(MAX) NOT NULL,
    ubicacion GEOGRAPHY, -- Tipo espacial de SQL Server
    ciudad NVARCHAR(100) NOT NULL,
    codigo_postal VARCHAR(20),
    telefono VARCHAR(20),
    email VARCHAR(150),
    capacidad_asientos INT NOT NULL DEFAULT 0,
    area_m2 DECIMAL(8,2),
    -- Columna XML para horarios estructurados
    horario_operacion XML,
    fecha_apertura DATE,
    activa BIT NOT NULL DEFAULT 1,
    -- Columnas de auditoría automática
    created_at DATETIME2 DEFAULT SYSDATETIME(),
    updated_at DATETIME2 DEFAULT SYSDATETIME(),
    created_by NVARCHAR(128) DEFAULT SUSER_SNAME(),
    
    CONSTRAINT chk_sucursales_capacidad CHECK (capacidad_asientos > 0),
    CONSTRAINT chk_sucursales_area CHECK (area_m2 IS NULL OR area_m2 > 0),
    CONSTRAINT chk_sucursales_fecha_apertura CHECK (fecha_apertura <= GETDATE())
);

-- Índice espacial para búsquedas geográficas
CREATE SPATIAL INDEX idx_sucursales_ubicacion ON configuracion.sucursales(ubicacion);

-- Trigger para updated_at
CREATE TRIGGER trg_sucursales_updated_at
ON configuracion.sucursales
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE configuracion.sucursales
    SET updated_at = SYSDATETIME()
    FROM configuracion.sucursales s
    INNER JOIN inserted i ON s.sucursal_id = i.sucursal_id;
END;

-- =====================================================
-- TABLA DE EMPLEADOS CON CHECK CONSTRAINTS COMPLEJOS
-- =====================================================

CREATE TABLE operaciones.empleados (
    empleado_id INT IDENTITY(1,1) PRIMARY KEY,
    cedula VARCHAR(20) NOT NULL,
    nombre NVARCHAR(100) NOT NULL,
    apellidos NVARCHAR(150) NOT NULL,
    -- Columna calculada para nombre completo
    nombre_completo AS (nombre + ' ' + apellidos) PERSISTED,
    email VARCHAR(200) UNIQUE,
    telefono VARCHAR(20),
    fecha_nacimiento DATE,
    sucursal_id INT NOT NULL REFERENCES configuracion.sucursales(sucursal_id),
    rol VARCHAR(20) NOT NULL,
    salario_mensual MONEY NOT NULL,
    fecha_ingreso DATE NOT NULL DEFAULT GETDATE(),
    fecha_salida DATE NULL,
    activo BIT NOT NULL DEFAULT 1,
    -- Columna para almacenar configuraciones personales como JSON
    configuracion_personal NVARCHAR(MAX) CHECK (ISJSON(configuracion_personal) > 0),
    created_at DATETIME2 DEFAULT SYSDATETIME(),
    updated_at DATETIME2 DEFAULT SYSDATETIME(),
    
    -- Constraints complejos específicos de SQL Server
    CONSTRAINT chk_empleados_rol CHECK (rol IN ('Gerente', 'Chef', 'Sous_Chef', 'Mesero', 'Cajero', 'Limpieza', 'Seguridad')),
    CONSTRAINT chk_empleados_salario CHECK (salario_mensual > 0),
    CONSTRAINT chk_empleados_edad CHECK (DATEDIFF(YEAR, fecha_nacimiento, GETDATE()) >= 16),
    CONSTRAINT chk_empleados_fechas CHECK (fecha_salida IS NULL OR fecha_salida >= fecha_ingreso),
    CONSTRAINT chk_empleados_email CHECK (email LIKE '%@%.%' AND LEN(email) > 5),
    
    -- Constraint único compuesto
    CONSTRAINT uk_empleados_cedula_sucursal UNIQUE (cedula, sucursal_id)
);

-- Índice filtrado para gerentes activos (feature específico de SQL Server)
CREATE UNIQUE INDEX idx_empleados_un_gerente_por_sucursal 
ON operaciones.empleados(sucursal_id) 
WHERE rol = 'Gerente' AND activo = 1;
```

#### Paso 4.2: Stored Procedures para Validaciones Complejas
```sql
-- =====================================================
-- STORED PROCEDURES PARA BUSINESS LOGIC
-- =====================================================

-- Procedure para crear empleado con validaciones
CREATE PROCEDURE operaciones.sp_crear_empleado
    @cedula VARCHAR(20),
    @nombre NVARCHAR(100),
    @apellidos NVARCHAR(150),
    @email VARCHAR(200) = NULL,
    @telefono VARCHAR(20) = NULL,
    @fecha_nacimiento DATE,
    @sucursal_id INT,
    @rol VARCHAR(20),
    @salario_mensual MONEY,
    @empleado_id INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Validar que la sucursal existe y está activa
        IF NOT EXISTS (SELECT 1 FROM configuracion.sucursales WHERE sucursal_id = @sucursal_id AND activa = 1)
        BEGIN
            THROW 50001, 'La sucursal especificada no existe o no está activa', 1;
        END
        
        -- Validar edad mínima
        IF DATEDIFF(YEAR, @fecha_nacimiento, GETDATE()) < 16
        BEGIN
            THROW 50002, 'El empleado debe ser mayor de 16 años', 1;
        END
        
        -- Validar que no existe otro gerente activo si el rol es Gerente
        IF @rol = 'Gerente'
        BEGIN
            IF EXISTS (SELECT 1 FROM operaciones.empleados WHERE sucursal_id = @sucursal_id AND rol = 'Gerente' AND activo = 1)
            BEGIN
                THROW 50003, 'Ya existe un gerente activo en esta sucursal', 1;
            END
        END
        
        -- Insertar empleado
        INSERT INTO operaciones.empleados (
            cedula, nombre, apellidos, email, telefono, fecha_nacimiento, 
            sucursal_id, rol, salario_mensual
        )
        VALUES (
            @cedula, @nombre, @apellidos, @email, @telefono, @fecha_nacimiento,
            @sucursal_id, @rol, @salario_mensual
        );
        
        SET @empleado_id = SCOPE_IDENTITY();
        
        COMMIT TRANSACTION;
        
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;
```

### Fase 5: Testing y Validación (45 minutos)

#### Paso 5.1: Carga de Datos de Prueba
**Ejecuta estos scripts en los 3 SGBD:**

```sql
-- Datos base para testing
INSERT INTO paises (nombre, codigo_iso, moneda) VALUES
('México', 'MEX', 'MXN'),
('Estados Unidos', 'USA', 'USD'),  
('Colombia', 'COL', 'COP'),
('España', 'ESP', 'EUR');

-- Sucursales de prueba
INSERT INTO sucursales (codigo, nombre, pais_id, direccion_completa, ciudad, capacidad_asientos, area_m2, fecha_apertura) VALUES
('MEX001', 'Restaurante Centro Histórico', 1, 'Av. Juárez 123, Col. Centro', 'Ciudad de México', 80, 150.50, '2020-01-15'),
('USA001', 'Downtown Restaurant', 2, '456 Main St, Downtown', 'New York', 120, 200.00, '2019-06-20'),
('COL001', 'Restaurante Zona Rosa', 3, 'Carrera 15 #85-32, Zona Rosa', 'Bogotá', 60, 120.75, '2021-03-10');

-- Categorías de productos
INSERT INTO categorias_producto (nombre, descripcion, requiere_refrigeracion, vida_util_dias) VALUES
('Carnes', 'Productos cárnicos frescos', TRUE, 3),
('Mariscos', 'Pescados y mariscos frescos', TRUE, 2),
('Verduras', 'Vegetales y hortalizas frescas', TRUE, 7),
('Bebidas', 'Bebidas alcohólicas y no alcohólicas', FALSE, NULL),
('Postres', 'Postres y dulces', TRUE, 5);
```

#### Paso 5.2: Testing de Constraints
**Ejecuta estos casos de prueba y documenta resultados:**

```sql
-- TEST 1: Intentar insertar país con código ISO inválido (DEBE FALLAR)
INSERT INTO paises (nombre, codigo_iso, moneda) VALUES ('Test País', 'XX', 'USD');
-- Resultado esperado: ERROR por constraint de código ISO

-- TEST 2: Intentar crear dos gerentes en la misma sucursal (DEBE FALLAR)
INSERT INTO empleados (cedula, nombre, apellidos, sucursal_id, rol, salario_mensual) VALUES 
('12345678', 'Juan', 'Pérez', 1, 'Gerente', 15000);

INSERT INTO empleados (cedula, nombre, apellidos, sucursal_id, rol, salario_mensual) VALUES 
('87654321', 'María', 'González', 1, 'Gerente', 16000);
-- Resultado esperado: ERROR por constraint de un solo gerente por sucursal

-- TEST 3: Insertar empleado menor de edad (DEBE FALLAR)
INSERT INTO empleados (cedula, nombre, apellidos, fecha_nacimiento, sucursal_id, rol, salario_mensual) VALUES 
('11111111', 'Pedro', 'Menor', '2010-01-01', 1, 'Mesero', 8000);
-- Resultado esperado: ERROR por constraint de edad mínima

-- TEST 4: Insertar producto con código internacional inválido (DEBE FALLAR en PostgreSQL)
INSERT INTO productos (codigo_internacional, nombre, categoria_id, precio_sugerido) VALUES 
('CÓDIGO_INVÁLIDO_123', 'Producto Prueba', 1, 25.50);
-- Resultado esperado: ERROR en PostgreSQL por validación personalizada

-- TEST 5: Validar funcionamiento de triggers de timestamp
UPDATE sucursales SET capacidad_asientos = 85 WHERE sucursal_id = 1;
SELECT updated_at FROM sucursales WHERE sucursal_id = 1;
-- Resultado esperado: updated_at debe cambiar automáticamente
```

#### Paso 5.3: Comparación de Features por SGBD
**Completa esta tabla basándote en tu implementación:**

| Feature | MySQL | PostgreSQL | SQL Server |
|---------|--------|------------|------------|
| **Auto-increment** | AUTO_INCREMENT | SERIAL | IDENTITY |
| **Constraints con regex** | ✓ (REGEXP) | ✓ (~ operator) | ✓ (LIKE patterns) |
| **Triggers para timestamps** | ✓ (ON UPDATE) | ✓ (trigger functions) | ✓ (AFTER triggers) |
| **JSON/XML soporte** | JSON | JSONB | XML + JSON |
| **Arrays nativos** | ✗ | ✓ | ✗ |
| **Tipos geográficos** | ✗ | PostGIS extension | GEOGRAPHY |
| **Columnas calculadas** | ✗ | Generated columns | Computed columns |
| **Exclusion constraints** | ✗ | ✓ | Unique filtered index |
| **Esquemas/namespaces** | Databases only | ✓ | ✓ |
| **Custom data types** | ✗ | ✓ (ENUMs, etc.) | ✓ (user types) |

### Fase 6: Optimización y Análisis (30 minutos)

#### Paso 6.1: Análisis de Planes de Ejecución
**Ejecuta estas consultas y analiza los planes:**

```sql
-- MySQL
EXPLAIN FORMAT=JSON 
SELECT e.nombre_completo, s.nombre as sucursal, p.nombre as pais
FROM empleados e 
JOIN sucursales s ON e.sucursal_id = s.sucursal_id
JOIN paises p ON s.pais_id = p.pais_id
WHERE e.activo = 1 AND e.rol = 'Gerente';

-- PostgreSQL  
EXPLAIN (ANALYZE, BUFFERS, FORMAT JSON)
SELECT e.nombre_completo, s.nombre as sucursal, p.nombre as pais
FROM operaciones.empleados e 
JOIN configuracion.sucursales s ON e.sucursal_id = s.sucursal_id
JOIN configuracion.paises p ON s.pais_id = p.pais_id
WHERE e.activo = TRUE AND e.rol = 'Gerente';

-- SQL Server
SET STATISTICS IO ON;
SELECT e.nombre_completo, s.nombre as sucursal, p.nombre as pais
FROM operaciones.empleados e 
JOIN configuracion.sucursales s ON e.sucursal_id = s.sucursal_id
JOIN configuracion.paises p ON s.pais_id = p.pais_id
WHERE e.activo = 1 AND e.rol = 'Gerente';
```

#### Paso 6.2: Identificación de Mejoras
**Documenta:**
1. ¿Qué índices adicionales recomendarías?
2. ¿Qué constraints podrían afectar el rendimiento?
3. ¿Qué features específicos de cada SGBD aprovechaste mejor?

## Notas

### Mejores Prácticas Aplicadas

**Nomenclatura Consistente:**
- Prefijos claros (chk_, idx_, fk_, uk_)
- Nombres descriptivos en español para business logic
- Esquemas organizacionales por funcionalidad

**Integridad de Datos:**
- Constraints a nivel de base de datos, no solo aplicación
- Validaciones complejas con triggers cuando necesario
- Foreign keys con acciones específicas (CASCADE/RESTRICT)

**Rendimiento:**
- Índices estratégicos en columnas de búsqueda frecuente
- Índices compuestos para queries específicas  
- Índices filtrados donde aplique (SQL Server)

**Mantenibilidad:**
- Documentación inline en DDL
- Separación lógica con esquemas
- Triggers simples y específicos

### Troubleshooting por SGBD

**MySQL:**
- Error 1364: Campo no-nulo sin default - agregar DEFAULT o permitir NULL
- Error 3819: Check constraint failed - revisar sintaxis de validación
- Error 1062: Duplicate entry - verificar constraints únicos

**PostgreSQL:**
- ERROR 23514: Check constraint violation - revisar lógica de constraint
- ERROR 23505: Unique violation - verificar constraint de exclusión  
- ERROR 42P01: Relation does not exist - verificar esquemas y nombres

**SQL Server:**
- Error 547: FOREIGN KEY constraint conflict - verificar integridad referencial
- Error 2627: Unique constraint violation - revisar índices únicos filtrados
- Error 8134: Divide by zero - revisar constraints con operaciones matemáticas

### Entregables

1. **Scripts DDL Completos** (archivos separados por SGBD):
   - `mysql_restaurantes_ddl.sql`
   - `postgresql_restaurantes_ddl.sql` 
   - `sqlserver_restaurantes_ddl.sql`

2. **Reporte de Implementación** (3 páginas):
   - Decisiones de diseño justificadas
   - Comparación de features utilizados por SGBD
   - Análisis de constraints implementados
   - Recomendaciones de optimización

3. **Casos de Prueba Ejecutados**:
   - Scripts de testing con resultados esperados vs obtenidos
   - Capturas de pantalla de errores controlados
   - Evidencia de funcionamiento de triggers y constraints

4. **Diagrama ER Final**:
   - Modelo conceptual completo
   - Documentación de relaciones y cardinalidades
   - Mapeo a implementación física por SGBD

5. **Análisis Comparativo**:
   - Tabla de features por SGBD completada
   - Recomendaciones de uso por escenario
   - Identificación de limitaciones y ventajas
