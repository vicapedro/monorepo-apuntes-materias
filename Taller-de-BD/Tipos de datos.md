# Tipos de Datos en Bases de Datos Relacionales

## 🎯 Introducción

La selección adecuada de tipos de datos es una decisión arquitectónica fundamental en el diseño de bases de datos. Esta elección impacta directamente en el **rendimiento**, **integridad**, **almacenamiento** y **mantenibilidad** del sistema. Un diseño correcto desde el inicio puede prevenir problemas críticos de escalabilidad y consistencia de datos.

---

## 📊 Importancia de la Selección Adecuada de Tipos de Datos

### **1. Integridad de Datos**

La elección correcta del tipo de dato actúa como la **primera línea de defensa** contra datos inválidos:

#### ✅ **Beneficios de Tipos de Datos Correctos:**

```sql
-- ✅ CORRECTO: Garantiza solo valores numéricos válidos
CREATE TABLE Productos (
    producto_id INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    precio DECIMAL(10,2) CHECK (precio > 0),
    cantidad_stock INT CHECK (cantidad_stock >= 0),
    fecha_registro DATE DEFAULT GETDATE(),
    activo BIT DEFAULT 1
);
```

**Ventajas demostradas:**
- `DECIMAL(10,2)` evita problemas de redondeo en cálculos financieros
- `INT` para cantidades previene valores decimales o negativos no deseados
- `DATE` garantiza formato consistente de fechas
- `BIT` restringe valores booleanos a 0 o 1

#### ❌ **Problemas con Tipos Incorrectos:**

```sql
-- ❌ INCORRECTO: Permite datos inconsistentes
CREATE TABLE Productos_Mal (
    producto_id VARCHAR(50), -- Debería ser INT
    nombre VARCHAR(MAX),     -- Excesivo para un nombre
    precio VARCHAR(20),      -- ¡Permite texto en lugar de números!
    cantidad_stock VARCHAR(10), -- Permite valores no numéricos
    fecha_registro VARCHAR(30), -- Permite fechas inválidas
    activo VARCHAR(10)       -- Permite cualquier texto
);

-- Consecuencias desastrosas:
INSERT INTO Productos_Mal VALUES 
    ('ABC123', 'Laptop', 'mil pesos', 'muchos', '32/13/2025', 'tal vez');
-- ¡Esta inserción es VÁLIDA pero COMPLETAMENTE INCORRECTA!
```

### **2. Rendimiento y Optimización**

Los tipos de datos influyen directamente en la velocidad de consultas y operaciones:

#### **Comparación de Rendimiento:**

```sql
-- Tabla con tipos optimizados (8 bytes por registro para IDs)
CREATE TABLE Clientes_Optimizado (
    cliente_id INT PRIMARY KEY, -- 4 bytes
    fecha_registro DATE,        -- 3 bytes
    activo BIT                  -- 1 bit
);

-- Tabla con tipos NO optimizados (78+ bytes por registro para IDs)
CREATE TABLE Clientes_Ineficiente (
    cliente_id VARCHAR(50) PRIMARY KEY, -- 50+ bytes
    fecha_registro VARCHAR(30),         -- 30+ bytes
    activo VARCHAR(10)                  -- 10+ bytes
);

-- Impacto en índices:
CREATE INDEX IX_Cliente_ID_Opt ON Clientes_Optimizado(cliente_id);
-- Índice compacto y eficiente

CREATE INDEX IX_Cliente_ID_Inef ON Clientes_Ineficiente(cliente_id);
-- Índice 6-10 veces más grande y lento
```

**Resultados medibles:**
- **Consultas con INT**: 5-10x más rápidas que VARCHAR para búsquedas
- **Joins con tipos numéricos**: 3-8x más eficientes que cadenas
- **Consumo de RAM**: Índices de INT ocupan fracción del espacio vs VARCHAR

### **3. Almacenamiento y Escalabilidad**

La eficiencia en almacenamiento se multiplica con millones de registros:

#### **Análisis de Consumo de Espacio:**

| **Tipo de Dato** | **Bytes por Registro** | **1M Registros** | **100M Registros** |
|------------------|------------------------|------------------|---------------------|
| `INT` | 4 bytes | 3.8 MB | 381 MB |
| `VARCHAR(50)` | 50+ bytes | 47.7 MB | 4.7 GB |
| `DATE` | 3 bytes | 2.9 MB | 286 MB |
| `VARCHAR(30)` | 30+ bytes | 28.6 MB | 2.8 GB |
| `BIT` | 1 bit | 122 KB | 11.9 MB |
| `VARCHAR(10)` | 10+ bytes | 9.5 MB | 953 MB |

**Ejemplo real con 10 millones de clientes:**

```sql
-- Diseño OPTIMIZADO: ~100 MB de datos
CREATE TABLE Ventas_Opt (
    venta_id INT PRIMARY KEY,           -- 4 bytes
    cliente_id INT,                     -- 4 bytes
    producto_id INT,                    -- 4 bytes
    cantidad SMALLINT,                  -- 2 bytes
    precio_unitario DECIMAL(10,2),     -- 5 bytes
    fecha_venta DATE,                   -- 3 bytes
    entregado BIT                       -- 1 bit
); -- Total: ~22 bytes/registro × 10M = 210 MB

-- Diseño INEFICIENTE: ~1.5 GB de datos
CREATE TABLE Ventas_Inef (
    venta_id VARCHAR(50),               -- 50+ bytes
    cliente_id VARCHAR(50),             -- 50+ bytes
    producto_id VARCHAR(50),            -- 50+ bytes
    cantidad VARCHAR(10),               -- 10+ bytes
    precio_unitario VARCHAR(20),       -- 20+ bytes
    fecha_venta VARCHAR(30),            -- 30+ bytes
    entregado VARCHAR(10)               -- 10+ bytes
); -- Total: ~220 bytes/registro × 10M = 2.1 GB

-- ¡Diferencia de 10X en almacenamiento!
```

### **4. Validación Automática y Seguridad**

Los tipos de datos correctos previenen vulnerabilidades y errores lógicos:

```sql
-- ✅ Protección contra inyección SQL y datos inválidos
CREATE PROCEDURE usp_ActualizarPrecio
    @ProductoID INT,              -- Solo acepta números enteros
    @NuevoPrecio DECIMAL(10,2)   -- Solo acepta valores monetarios válidos
AS
BEGIN
    -- SQL Server valida automáticamente los tipos
    UPDATE Productos 
    SET precio = @NuevoPrecio 
    WHERE producto_id = @ProductoID;
END;

-- Intento de ataque fallido:
EXEC usp_ActualizarPrecio 
    @ProductoID = '1; DROP TABLE Productos;--',  -- ❌ ERROR: Conversión inválida
    @NuevoPrecio = 'precio_malicioso';            -- ❌ ERROR: No es DECIMAL
```

### **5. Operaciones Matemáticas y Lógicas**

Los tipos numéricos permiten operaciones directas sin conversiones costosas:

```sql
-- ✅ CORRECTO: Operaciones directas y eficientes
SELECT 
    producto_id,
    nombre,
    precio * cantidad_stock AS valor_inventario,
    precio * 1.16 AS precio_con_iva,
    DATEDIFF(DAY, fecha_registro, GETDATE()) AS dias_desde_registro
FROM Productos
WHERE precio BETWEEN 100 AND 1000
  AND cantidad_stock > 10
  AND fecha_registro >= DATEADD(MONTH, -6, GETDATE());

-- ❌ INCORRECTO: Requiere conversiones costosas en cada fila
SELECT 
    producto_id,
    nombre,
    CAST(precio AS DECIMAL(10,2)) * CAST(cantidad_stock AS INT) AS valor_inventario,
    CAST(precio AS DECIMAL(10,2)) * 1.16 AS precio_con_iva,
    DATEDIFF(DAY, CAST(fecha_registro AS DATE), GETDATE()) AS dias_desde_registro
FROM Productos_Mal
WHERE CAST(precio AS DECIMAL(10,2)) BETWEEN 100 AND 1000
  AND CAST(cantidad_stock AS INT) > 10
  AND CAST(fecha_registro AS DATE) >= DATEADD(MONTH, -6, GETDATE());
-- ¡Conversiones en CADA fila = rendimiento desastroso!
```

---

## ⚠️ Peligros de una Selección Inadecuada

### **1. Problemas de Integridad de Datos**

#### **Escenario Real: Sistema de Nómina**

```sql
-- ❌ DISEÑO PELIGROSO
CREATE TABLE Empleados_Mal (
    empleado_id VARCHAR(20),
    nombre VARCHAR(MAX),
    salario VARCHAR(20),        -- ¡CRÍTICO!
    fecha_contratacion VARCHAR(30),
    horas_trabajadas VARCHAR(10)
);

-- Datos VÁLIDOS pero INCORRECTOS insertados:
INSERT INTO Empleados_Mal VALUES 
    ('E001', 'Juan Pérez', '15,000.50', '01-Marzo-2024', '40'),
    ('E002', 'María López', '$20000', '2024/03/15', 'Cuarenta'),
    ('E003', 'Pedro Gómez', '18.500,00', '15-03-2024', '45.5 horas');

-- Intentar calcular nómina:
SELECT 
    empleado_id,
    nombre,
    CAST(salario AS DECIMAL(10,2)) AS salario_numerico
FROM Empleados_Mal;
-- ❌ ERROR: No se puede convertir '$20000' ni '18.500,00' a DECIMAL
-- Resultado: Pérdida de datos, cálculos incorrectos, nómina fallida
```

#### **Consecuencias:**
- ❌ Cálculos financieros erróneos
- ❌ Reportes fiscales inválidos
- ❌ Auditorías fallidas
- ❌ Demandas laborales por pagos incorrectos

### **2. Degradación Crítica de Rendimiento**

#### **Caso de Estudio: Sistema de Ventas con 50 Millones de Registros**

```sql
-- ❌ Tabla ineficiente
CREATE TABLE Ventas_Ineficiente (
    venta_id VARCHAR(50),
    fecha_venta VARCHAR(30),
    monto VARCHAR(20)
);

-- Consulta que tarda MINUTOS:
SELECT 
    CAST(fecha_venta AS DATE) AS fecha,
    SUM(CAST(monto AS DECIMAL(10,2))) AS total_ventas
FROM Ventas_Ineficiente
WHERE CAST(fecha_venta AS DATE) BETWEEN '2024-01-01' AND '2024-12-31'
GROUP BY CAST(fecha_venta AS DATE);
-- Tiempo: 15-30 minutos (sin índices efectivos)

-- ✅ Tabla optimizada
CREATE TABLE Ventas_Optimizada (
    venta_id INT PRIMARY KEY,
    fecha_venta DATE,
    monto DECIMAL(10,2)
);
CREATE INDEX IX_Ventas_Fecha ON Ventas_Optimizada(fecha_venta);

-- Misma consulta, diseño correcto:
SELECT 
    fecha_venta,
    SUM(monto) AS total_ventas
FROM Ventas_Optimizada
WHERE fecha_venta BETWEEN '2024-01-01' AND '2024-12-31'
GROUP BY fecha_venta;
-- Tiempo: 2-5 segundos
-- ¡Mejora de 200-900X en rendimiento!
```

### **3. Desperdicio de Recursos y Costos Operativos**

#### **Análisis Financiero Real:**

```sql
-- Sistema con 100M de registros, diseño ineficiente
CREATE TABLE Clientes_Ineficiente (
    cliente_id VARCHAR(50),      -- 50 bytes vs 4 bytes (INT)
    nombre VARCHAR(MAX),         -- Variable vs VARCHAR(100)
    telefono VARCHAR(50),        -- 50 bytes vs VARCHAR(15)
    email VARCHAR(200)           -- 200 bytes vs VARCHAR(100)
);
-- Almacenamiento desperdiciado: ~300 bytes/registro × 100M = 28 GB extra

-- Costos anuales estimados (AWS/Azure):
-- - Almacenamiento adicional: 28 GB × $0.10/GB/mes = $33.60/año
-- - Backup adicional: 28 GB × $0.05/GB/mes = $16.80/año
-- - Transferencia de datos: 28 GB × consultas frecuentes = $50+/año
-- TOTAL: ~$100-200/año por tabla mal diseñada
-- Sistema con 50 tablas: $5,000-10,000/año en costos evitables
```

### **4. Mantenimiento Complejo y Propenso a Errores**

```sql
-- ❌ Código frágil por tipos incorrectos
CREATE PROCEDURE usp_GenerarReporte_Mal
AS
BEGIN
    -- Conversiones manuales en cada consulta
    SELECT 
        CAST(cliente_id AS INT) AS id,
        CAST(fecha_registro AS DATE) AS fecha,
        CAST(monto_total AS DECIMAL(10,2)) AS monto,
        CASE WHEN LOWER(activo) = 'true' OR activo = '1' THEN 1 ELSE 0 END AS activo
    FROM Clientes_Mal
    WHERE CAST(fecha_registro AS DATE) >= '2024-01-01'
      AND CAST(monto_total AS DECIMAL(10,2)) > 1000;
    
    -- Si cambia el formato de datos, el procedimiento FALLA
END;

-- ✅ Código robusto con tipos correctos
CREATE PROCEDURE usp_GenerarReporte_Correcto
AS
BEGIN
    -- Sin conversiones necesarias, código limpio
    SELECT 
        cliente_id,
        fecha_registro,
        monto_total,
        activo
    FROM Clientes_Optimizado
    WHERE fecha_registro >= '2024-01-01'
      AND monto_total > 1000;
    -- Funciona consistentemente sin importar cambios de datos
END;
```

### **5. Vulnerabilidades de Seguridad**

#### **Inyección SQL y Explotación de Tipos Débiles:**

```sql
-- ❌ VULNERABLE: Tipos VARCHAR permiten bypass de validación
CREATE TABLE Usuarios_Vulnerable (
    usuario_id VARCHAR(50),
    intentos_login VARCHAR(10),  -- Debería ser INT
    bloqueado VARCHAR(10)        -- Debería ser BIT
);

-- Código vulnerable:
INSERT INTO Usuarios_Vulnerable VALUES 
    ('admin', '999999999', 'false; DROP TABLE Usuarios;--');
-- Dependiendo de la implementación, podría ejecutar código malicioso

-- ✅ SEGURO: Tipos estrictos previenen manipulación
CREATE TABLE Usuarios_Seguro (
    usuario_id INT PRIMARY KEY,
    intentos_login TINYINT DEFAULT 0 CHECK (intentos_login <= 5),
    bloqueado BIT DEFAULT 0
);

-- Intento de ataque bloqueado por validación de tipo:
INSERT INTO Usuarios_Seguro VALUES 
    (1, '999999999', 'false; DROP TABLE Usuarios;--');
-- ❌ ERROR: Conversión inválida de VARCHAR a TINYINT
-- ❌ ERROR: Conversión inválida de VARCHAR a BIT
-- Sistema protegido automáticamente
```

### **6. Problemas de Migración y Escalabilidad**

```sql
-- Escenario: Sistema legacy con tipos incorrectos a migrar
CREATE TABLE Pedidos_Legacy (
    pedido_id VARCHAR(50),
    cliente_id VARCHAR(50),
    monto_total VARCHAR(20),
    fecha_pedido VARCHAR(30)
);
-- 10 millones de registros con formatos inconsistentes

-- Migración COMPLEJA y PROPENSA A ERRORES:
CREATE TABLE Pedidos_Nuevo (
    pedido_id INT PRIMARY KEY,
    cliente_id INT,
    monto_total DECIMAL(10,2),
    fecha_pedido DATE
);

-- Script de migración con validación exhaustiva necesaria:
INSERT INTO Pedidos_Nuevo (pedido_id, cliente_id, monto_total, fecha_pedido)
SELECT 
    TRY_CAST(pedido_id AS INT),
    TRY_CAST(cliente_id AS INT),
    TRY_CAST(REPLACE(REPLACE(monto_total, '$', ''), ',', '') AS DECIMAL(10,2)),
    TRY_CAST(fecha_pedido AS DATE)
FROM Pedidos_Legacy
WHERE TRY_CAST(pedido_id AS INT) IS NOT NULL
  AND TRY_CAST(cliente_id AS INT) IS NOT NULL
  AND TRY_CAST(REPLACE(REPLACE(monto_total, '$', ''), ',', '') AS DECIMAL(10,2)) IS NOT NULL
  AND TRY_CAST(fecha_pedido AS DATE) IS NOT NULL;

-- Registros perdidos o requeridos limpieza manual:
-- - Pedidos con IDs alfanuméricos: 15,000 registros
-- - Fechas en formato inválido: 8,500 registros
-- - Montos con caracteres especiales: 12,300 registros
-- Total: 35,800 registros (0.358%) requieren intervención manual
-- Costo estimado: 80-120 horas de trabajo de limpieza
```

---

## 📋 Guía de Selección de Tipos de Datos

### **Tipos de Datos Numéricos**

| **Tipo** | **Rango** | **Bytes** | **Uso Recomendado** |
|----------|-----------|-----------|---------------------|
| `TINYINT` | 0 a 255 | 1 | Estados, flags, edades |
| `SMALLINT` | -32,768 a 32,767 | 2 | Cantidades pequeñas, códigos postales |
| `INT` | -2,147,483,648 a 2,147,483,647 | 4 | IDs, cantidades generales |
| `BIGINT` | ±9.2 quintillones | 8 | IDs grandes, timestamps |
| `DECIMAL(p,s)` | Precisión definida | 5-17 | Valores monetarios, porcentajes |
| `MONEY` | ±922,337,203,685,477.5808 | 8 | Valores monetarios (alternativa) |
| `FLOAT(n)` | Aproximado | 4-8 | Cálculos científicos (no finanzas) |

### **Tipos de Datos de Cadena**

| **Tipo** | **Longitud Máxima** | **Uso Recomendado** |
|----------|---------------------|---------------------|
| `CHAR(n)` | 8,000 caracteres fijos | Códigos de longitud fija (país, estado) |
| `VARCHAR(n)` | 8,000 caracteres variables | Nombres, descripciones cortas |
| `VARCHAR(MAX)` | 2 GB | Textos largos, descripciones extensas |
| `NCHAR(n)` | 4,000 caracteres Unicode | Textos multilingües fijos |
| `NVARCHAR(n)` | 4,000 caracteres Unicode | Nombres internacionales |
| `TEXT` | 2 GB (deprecated) | **NO USAR** - usar VARCHAR(MAX) |

### **Tipos de Datos de Fecha y Hora**

| **Tipo** | **Rango** | **Precisión** | **Bytes** | **Uso Recomendado** |
|----------|-----------|---------------|-----------|---------------------|
| `DATE` | 0001-01-01 a 9999-12-31 | Día | 3 | Fechas de nacimiento, vencimientos |
| `TIME` | 00:00:00 a 23:59:59.9999999 | 100 nanosegundos | 3-5 | Horarios, duraciones |
| `DATETIME` | 1753-01-01 a 9999-12-31 | 3.33 ms | 8 | Registros históricos |
| `DATETIME2` | 0001-01-01 a 9999-12-31 | 100 nanosegundos | 6-8 | **PREFERIDO** para nuevos diseños |
| `DATETIMEOFFSET` | Con zona horaria | 100 nanosegundos | 8-10 | Sistemas distribuidos globalmente |

### **Otros Tipos Importantes**

| **Tipo** | **Descripción** | **Uso Recomendado** |
|----------|-----------------|---------------------|
| `BIT` | 0, 1 o NULL | Flags booleanos (activo, eliminado) |
| `UNIQUEIDENTIFIER` | GUID (128 bits) | IDs distribuidos, replicación |
| `XML` | Documentos XML | Configuraciones, datos jerárquicos |
| `JSON` (SQL 2016+) | Documentos JSON | APIs, datos semi-estructurados |
| `VARBINARY(n)` | Datos binarios | Archivos pequeños, hashes |

---

## 🎯 Mejores Prácticas y Recomendaciones

### **1. Principios de Selección de Tipos**

#### ✅ **Regla de Oro: "Usa el tipo más restrictivo que cumpla tus requisitos"**

```sql
-- ❌ INCORRECTO: Tipo demasiado permisivo
CREATE TABLE Pedidos_Mal (
    pedido_id BIGINT,              -- INT sería suficiente para millones
    cantidad VARCHAR(50),          -- SMALLINT sería apropiado
    precio VARCHAR(100),           -- DECIMAL(10,2) correcto
    descuento VARCHAR(20),         -- DECIMAL(5,2) entre 0-100
    fecha_pedido VARCHAR(50)       -- DATE suficiente
);

-- ✅ CORRECTO: Tipos precisos y restrictivos
CREATE TABLE Pedidos_Correcto (
    pedido_id INT PRIMARY KEY IDENTITY(1,1),
    cantidad SMALLINT CHECK (cantidad > 0 AND cantidad <= 10000),
    precio DECIMAL(10,2) CHECK (precio >= 0),
    descuento DECIMAL(5,2) CHECK (descuento >= 0 AND descuento <= 100),
    fecha_pedido DATE DEFAULT GETDATE()
);
```

### **2. Validación Combinada: Tipos + Constraints**

```sql
CREATE TABLE Productos (
    producto_id INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    categoria VARCHAR(50) NOT NULL,
    
    -- Tipo DECIMAL + CHECK para validación robusta
    precio DECIMAL(10,2) NOT NULL 
        CHECK (precio BETWEEN 0.01 AND 999999.99),
    
    -- TINYINT suficiente + CHECK para porcentajes
    descuento TINYINT DEFAULT 0 
        CHECK (descuento BETWEEN 0 AND 100),
    
    -- SMALLINT + CHECK para inventario
    stock SMALLINT NOT NULL 
        CHECK (stock >= 0 AND stock <= 50000),
    
    -- DATE + CHECK para fechas válidas
    fecha_lanzamiento DATE 
        CHECK (fecha_lanzamiento <= GETDATE()),
    
    -- BIT para estados simples
    activo BIT DEFAULT 1,
    
    -- CONSTRAINT de tabla para validación compleja
    CONSTRAINT CHK_Producto_Descuento_Stock 
        CHECK (
            (descuento > 0 AND stock > 0) OR  -- Descuento solo si hay stock
            (descuento = 0)                    -- O sin descuento
        )
);
```

### **3. Migración de Tipos de Datos Incorrectos**

#### **Estrategia Segura para Corrección de Tipos:**

```sql
-- Paso 1: Crear tabla temporal con tipos correctos
CREATE TABLE Clientes_Nuevo (
    cliente_id INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    telefono VARCHAR(15),
    fecha_registro DATE DEFAULT GETDATE(),
    activo BIT DEFAULT 1
);

-- Paso 2: Migrar datos con validación
INSERT INTO Clientes_Nuevo (cliente_id, nombre, email, telefono, fecha_registro, activo)
SELECT 
    TRY_CAST(cliente_id AS INT),
    LEFT(nombre, 100),
    LEFT(email, 100),
    LEFT(telefono, 15),
    TRY_CAST(fecha_registro AS DATE),
    CASE 
        WHEN LOWER(LTRIM(RTRIM(activo))) IN ('1', 'true', 'yes', 'si') THEN 1
        ELSE 0
    END
FROM Clientes_Viejo
WHERE TRY_CAST(cliente_id AS INT) IS NOT NULL  -- Filtrar IDs inválidos
  AND LEN(LTRIM(RTRIM(nombre))) > 0;           -- Filtrar nombres vacíos

-- Paso 3: Validar integridad
SELECT 
    COUNT(*) AS total_origen,
    (SELECT COUNT(*) FROM Clientes_Nuevo) AS total_migrado,
    COUNT(*) - (SELECT COUNT(*) FROM Clientes_Nuevo) AS registros_perdidos
FROM Clientes_Viejo;

-- Paso 4: Analizar registros perdidos
SELECT 
    cliente_id,
    nombre,
    'ID no numérico' AS motivo_rechazo
FROM Clientes_Viejo
WHERE TRY_CAST(cliente_id AS INT) IS NULL

UNION ALL

SELECT 
    cliente_id,
    nombre,
    'Nombre vacío' AS motivo_rechazo
FROM Clientes_Viejo
WHERE LEN(LTRIM(RTRIM(nombre))) = 0;

-- Paso 5: Reemplazar tabla (en ventana de mantenimiento)
BEGIN TRANSACTION;
    EXEC sp_rename 'Clientes_Viejo', 'Clientes_Backup';
    EXEC sp_rename 'Clientes_Nuevo', 'Clientes';
COMMIT TRANSACTION;
```

### **4. Documentación de Decisiones de Tipos**

```sql
-- Documentar justificación de tipos en comentarios
EXEC sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'DECIMAL(10,2) usado para precisión financiera. Rango: $0.01 a $99,999,999.99',
    @level0type = N'SCHEMA', @level0name = 'dbo',
    @level1type = N'TABLE',  @level1name = 'Productos',
    @level2type = N'COLUMN', @level2name = 'precio';

EXEC sp_addextendedproperty 
    @name = N'MS_Description',
    @value = N'SMALLINT suficiente para inventario máximo de 50,000 unidades por SKU',
    @level0type = N'SCHEMA', @level0name = 'dbo',
    @level1type = N'TABLE',  @level1name = 'Productos',
    @level2type = N'COLUMN', @level2name = 'stock';
```

---

## 🔍 Lista de Verificación para Selección de Tipos

### **Checklist de Validación:**

- [ ] **¿El tipo refleja la naturaleza real de los datos?**
  - Números → Tipos numéricos (INT, DECIMAL)
  - Fechas → DATE/DATETIME2
  - Texto → VARCHAR con longitud apropiada
  - Booleanos → BIT

- [ ] **¿Se usa el tamaño mínimo necesario?**
  - TINYINT (0-255) en lugar de INT cuando sea posible
  - SMALLINT (-32K a 32K) en lugar de INT
  - VARCHAR(n) en lugar de VARCHAR(MAX)

- [ ] **¿Se previenen valores inválidos?**
  - CHECK constraints para rangos
  - NOT NULL donde sea obligatorio
  - DEFAULT para valores iniciales

- [ ] **¿El rendimiento está optimizado?**
  - Tipos numéricos para IDs y claves foráneas
  - DATE/DATETIME2 para fechas (no VARCHAR)
  - Índices en columnas de búsqueda frecuente

- [ ] **¿La integridad referencial está garantizada?**
  - Foreign keys con tipos coincidentes
  - Tipos consistentes entre tablas relacionadas

- [ ] **¿Se considera la escalabilidad futura?**
  - INT vs BIGINT para IDs de alto crecimiento
  - VARCHAR(n) con margen para expansión razonable

- [ ] **¿La documentación es clara?**
  - Comentarios sobre decisiones de tipos
  - Justificación de límites y restricciones

---

## 📚 Conclusión

La **selección adecuada de tipos de datos** es una inversión inicial que:

### ✅ **Beneficios Inmediatos:**
- **Integridad automática** de datos desde el primer INSERT
- **Validación sin código adicional** mediante el motor de BD
- **Rendimiento óptimo** en consultas y operaciones
- **Ahorro de espacio** en almacenamiento e índices

### ✅ **Beneficios a Largo Plazo:**
- **Mantenibilidad** del sistema sin conversiones constantes
- **Escalabilidad** sin necesidad de refactorización masiva
- **Seguridad** contra inyección SQL y manipulación de datos
- **Costos reducidos** en infraestructura y operación

### ⚠️ **Costos de Corrección:**
- **Migración de datos** puede tomar semanas o meses en sistemas grandes
- **Pérdida potencial de datos** inconsistentes durante conversión
- **Downtime** para aplicar cambios estructurales
- **Reescritura de código** que depende de tipos incorrectos

**Recomendación final:** Invierte tiempo en el diseño inicial de la base de datos. Una hora de planificación puede ahorrar cientos de horas de corrección futura y miles de dólares en costos operativos.

---

## 🎓 Reflexión para el Estudiante

**Preguntas de autoevaluación:**

1. ¿Puedes identificar 3 tipos de datos incorrectos en tus proyectos actuales?
2. ¿Cuál sería el impacto en rendimiento si tu sistema tuviera 100 millones de registros?
3. ¿Qué tipo de validaciones estás haciendo en código que podrían delegarse al motor de BD?
4. ¿Has calculado el espacio de almacenamiento y costos asociados a tus diseños actuales?

**Ejercicio práctico:**
Analiza una tabla de tu proyecto actual y rediseña sus tipos de datos aplicando las mejores prácticas de este documento. Documenta las mejoras esperadas en rendimiento, almacenamiento e integridad.
