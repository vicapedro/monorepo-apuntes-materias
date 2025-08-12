# Actividad 3: Implementación Práctica de Constraints Avanzados

## 🎯 Objetivo de la Actividad
**Implementar y validar constraints avanzados de integridad de datos utilizando características específicas de diferentes SGBD para garantizar la consistencia y calidad de la información.**

**Duración estimada**: 2.5 horas  
**Modalidad**: Individual con consultas colaborativas

## 🎓 Competencias a Desarrollar
- Implementa constraints de integridad complejos
- Utiliza características específicas de diferentes SGBD
- Valida reglas de negocio mediante constraints
- Documenta y prueba mecanismos de integridad
- Analiza el impacto de constraints en rendimiento

## 📚 Introducción

Los constraints son fundamentales para mantener la integridad de los datos en bases de datos empresariales. Esta actividad explora constraints avanzados que van más allá de PRIMARY KEY y FOREIGN KEY, incluyendo validaciones complejas y triggers automáticos.

### Tipos de Constraints Avanzados
1. **CHECK Constraints complejos** - Validaciones de lógica de negocio
2. **UNIQUE Constraints compuestos** - Combinaciones únicas de campos
3. **Constraints condicionales** - Validaciones dependientes del contexto
4. **Custom constraints** - Validaciones mediante funciones personalizadas

## 🏢 Caso de Estudio: Sistema de E-commerce Global

### Contexto Empresarial
Una plataforma de e-commerce maneja productos de múltiples vendedores, con diferentes monedas, promociones y políticas de envío complejas.

### Reglas de Negocio a Implementar

**RN1 - Gestión de Precios**:
- Precio base siempre > 0
- Precio con descuento nunca puede ser mayor al precio base
- Descuentos máximos del 80% sobre precio base
- Precios en USD, EUR, MXN con conversiones automáticas

**RN2 - Gestión de Inventario**:
- Stock disponible >= 0
- Stock reservado <= stock total
- Productos discontinuados no pueden tener stock nuevo
- Alerta automática cuando stock < stock_minimo

**RN3 - Gestión de Pedidos**:
- Fecha de entrega > fecha de pedido
- Pedidos solo pueden ser cancelados en estado 'Pendiente' o 'Confirmado'
- Monto total debe coincidir con suma de productos + impuestos + envío
- Un cliente no puede tener más de 3 pedidos pendientes simultáneos

**RN4 - Gestión de Promociones**:
- Fecha inicio < fecha fin para promociones
- Una promoción no puede aplicar a productos ya discontinuados
- Códigos de cupón deben ser únicos globalmente
- Límite de uso por cupón debe ser respetado

## 🔧 Metodología de Trabajo

### Fase 1: Diseño de Esquema Base (30 minutos)

#### Paso 1A: Creación de Tablas Fundamentales
**Implementa estas tablas con constraints básicos**:

```sql
-- Tabla de categorías de productos
CREATE TABLE categorias (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    categoria_padre_id INT,
    activa BOOLEAN DEFAULT TRUE,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (categoria_padre_id) REFERENCES categorias(id)
);

-- Tabla de productos
CREATE TABLE productos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    sku VARCHAR(50) NOT NULL UNIQUE,
    nombre VARCHAR(255) NOT NULL,
    descripcion TEXT,
    categoria_id INT NOT NULL,
    precio_base DECIMAL(10,2) NOT NULL,
    precio_descuento DECIMAL(10,2),
    moneda ENUM('USD', 'EUR', 'MXN') DEFAULT 'USD',
    stock_total INT NOT NULL DEFAULT 0,
    stock_disponible INT NOT NULL DEFAULT 0,
    stock_reservado INT NOT NULL DEFAULT 0,
    stock_minimo INT DEFAULT 10,
    estado ENUM('Activo', 'Discontinuado', 'Agotado') DEFAULT 'Activo',
    peso_kg DECIMAL(8,3),
    dimensiones_cm VARCHAR(50), -- formato: "LxWxH"
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (categoria_id) REFERENCES categorias(id)
);

-- Tabla de clientes
CREATE TABLE clientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    fecha_nacimiento DATE,
    telefono VARCHAR(20),
    pais VARCHAR(3), -- código ISO
    estado_cuenta ENUM('Activo', 'Suspendido', 'Cerrado') DEFAULT 'Activo',
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabla de pedidos
CREATE TABLE pedidos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT NOT NULL,
    numero_orden VARCHAR(20) NOT NULL UNIQUE,
    estado ENUM('Pendiente', 'Confirmado', 'Enviado', 'Entregado', 'Cancelado') DEFAULT 'Pendiente',
    fecha_pedido TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_entrega_estimada DATE,
    fecha_entrega_real DATE,
    subtotal DECIMAL(12,2) NOT NULL,
    impuestos DECIMAL(12,2) NOT NULL DEFAULT 0,
    costo_envio DECIMAL(10,2) NOT NULL DEFAULT 0,
    descuento_aplicado DECIMAL(10,2) DEFAULT 0,
    monto_total DECIMAL(12,2) NOT NULL,
    moneda ENUM('USD', 'EUR', 'MXN') DEFAULT 'USD',
    direccion_envio TEXT NOT NULL,
    
    FOREIGN KEY (cliente_id) REFERENCES clientes(id)
);

-- Tabla de promociones/cupones
CREATE TABLE promociones (
    id INT AUTO_INCREMENT PRIMARY KEY,
    codigo VARCHAR(50) NOT NULL UNIQUE,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    tipo_descuento ENUM('Porcentaje', 'Monto_Fijo') NOT NULL,
    valor_descuento DECIMAL(10,2) NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    limite_uso INT DEFAULT NULL, -- NULL = ilimitado
    uso_actual INT DEFAULT 0,
    activa BOOLEAN DEFAULT TRUE,
    aplica_envio_gratis BOOLEAN DEFAULT FALSE
);
```

### Fase 2: Implementación de Constraints Avanzados (60 minutos)

#### Paso 2A: CHECK Constraints Complejos (20 minutos)

**Implementa estos constraints de validación**:

```sql
-- RN1: Constraints de precios
ALTER TABLE productos 
ADD CONSTRAINT chk_precio_base_positivo 
CHECK (precio_base > 0);

ALTER TABLE productos 
ADD CONSTRAINT chk_precio_descuento_valido 
CHECK (precio_descuento IS NULL OR (precio_descuento > 0 AND precio_descuento <= precio_base));

ALTER TABLE productos 
ADD CONSTRAINT chk_descuento_maximo_80 
CHECK (precio_descuento IS NULL OR precio_descuento >= (precio_base * 0.20));

-- RN2: Constraints de inventario
ALTER TABLE productos 
ADD CONSTRAINT chk_stock_disponible_positivo 
CHECK (stock_disponible >= 0);

ALTER TABLE productos 
ADD CONSTRAINT chk_stock_reservado_valido 
CHECK (stock_reservado >= 0 AND stock_reservado <= stock_total);

ALTER TABLE productos 
ADD CONSTRAINT chk_stock_coherencia 
CHECK (stock_disponible + stock_reservado <= stock_total);

-- RN3: Constraints de pedidos
ALTER TABLE pedidos 
ADD CONSTRAINT chk_fecha_entrega_posterior 
CHECK (fecha_entrega_estimada > DATE(fecha_pedido));

ALTER TABLE pedidos 
ADD CONSTRAINT chk_monto_total_coherente 
CHECK (monto_total = subtotal + impuestos + costo_envio - descuento_aplicado);

-- RN4: Constraints de promociones
ALTER TABLE promociones 
ADD CONSTRAINT chk_fechas_promocion_validas 
CHECK (fecha_inicio < fecha_fin);

ALTER TABLE promociones 
ADD CONSTRAINT chk_valor_descuento_positivo 
CHECK (valor_descuento > 0);

ALTER TABLE promociones 
ADD CONSTRAINT chk_porcentaje_descuento_maximo 
CHECK (tipo_descuento != 'Porcentaje' OR valor_descuento <= 100);
```

#### Paso 2B: Triggers para Validaciones Complejas (25 minutos)

**Implementa estos triggers para reglas de negocio avanzadas**:

```sql
DELIMITER //

-- Trigger: Validar límite de pedidos pendientes por cliente
CREATE TRIGGER trg_limite_pedidos_pendientes
BEFORE INSERT ON pedidos
FOR EACH ROW
BEGIN
    DECLARE pedidos_pendientes INT;
    
    SELECT COUNT(*) INTO pedidos_pendientes
    FROM pedidos 
    WHERE cliente_id = NEW.cliente_id 
      AND estado IN ('Pendiente', 'Confirmado');
    
    IF pedidos_pendientes >= 3 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Cliente tiene demasiados pedidos pendientes (máximo 3)';
    END IF;
END;//

-- Trigger: Actualizar stock al confirmar pedido
CREATE TRIGGER trg_actualizar_stock_confirmacion
AFTER UPDATE ON pedidos
FOR EACH ROW
BEGIN
    -- Solo cuando el estado cambia a 'Confirmado'
    IF OLD.estado != 'Confirmado' AND NEW.estado = 'Confirmado' THEN
        -- Actualizar stock de productos en el pedido
        UPDATE productos p
        INNER JOIN detalle_pedidos dp ON p.id = dp.producto_id
        SET p.stock_disponible = p.stock_disponible - dp.cantidad,
            p.stock_reservado = p.stock_reservado + dp.cantidad
        WHERE dp.pedido_id = NEW.id;
    END IF;
END;//

-- Trigger: Validar uso de cupones
CREATE TRIGGER trg_validar_uso_cupon
BEFORE UPDATE ON promociones
FOR EACH ROW
BEGIN
    IF NEW.uso_actual > OLD.uso_actual THEN
        IF NEW.limite_uso IS NOT NULL AND NEW.uso_actual > NEW.limite_uso THEN
            SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = 'Cupón ha excedido su límite de uso';
        END IF;
    END IF;
END;//

-- Trigger: Alerta de stock bajo
CREATE TRIGGER trg_alerta_stock_bajo
AFTER UPDATE ON productos
FOR EACH ROW
BEGIN
    IF NEW.stock_disponible < NEW.stock_minimo AND OLD.stock_disponible >= OLD.stock_minimo THEN
        INSERT INTO alertas_sistema (tipo, mensaje, fecha_creacion)
        VALUES ('STOCK_BAJO', 
                CONCAT('Producto ', NEW.nombre, ' (SKU: ', NEW.sku, ') tiene stock bajo: ', NEW.stock_disponible),
                NOW());
    END IF;
END;//

DELIMITER ;
```

#### Paso 2C: Índices y Constraints de Rendimiento (15 minutos)

**Implementa índices para soportar constraints eficientemente**:

```sql
-- Índices para constraints frecuentes
CREATE INDEX idx_productos_categoria_estado ON productos(categoria_id, estado);
CREATE INDEX idx_pedidos_cliente_estado ON pedidos(cliente_id, estado);
CREATE INDEX idx_productos_stock_minimo ON productos(stock_disponible, stock_minimo);

-- Índices compuestos únicos
CREATE UNIQUE INDEX uk_cliente_email_activo ON clientes(email) 
WHERE estado_cuenta = 'Activo';

-- Índice para promociones activas
CREATE INDEX idx_promociones_activas ON promociones(activa, fecha_inicio, fecha_fin)
WHERE activa = TRUE;
```

### Fase 3: Testing y Validación (45 minutos)

#### Paso 3A: Datos de Prueba (15 minutos)

**Inserta estos datos base para testing**:

```sql
-- Categorías de ejemplo
INSERT INTO categorias (nombre, descripcion) VALUES 
('Electrónicos', 'Dispositivos electrónicos'),
('Ropa', 'Vestimenta y accesorios'),
('Hogar', 'Artículos para el hogar');

-- Productos de ejemplo
INSERT INTO productos (sku, nombre, categoria_id, precio_base, precio_descuento, stock_total, stock_disponible) VALUES
('LAPTOP-001', 'Laptop Gaming', 1, 1500.00, 1200.00, 50, 45),
('SHIRT-001', 'Camisa Casual', 2, 35.00, NULL, 100, 90),
('LAMP-001', 'Lámpara LED', 3, 80.00, 60.00, 25, 20);

-- Clientes de ejemplo
INSERT INTO clientes (email, password_hash, nombre, apellidos, pais) VALUES
('john.doe@email.com', 'hash123', 'John', 'Doe', 'USA'),
('maria.garcia@email.com', 'hash456', 'María', 'García', 'MEX');

-- Promociones de ejemplo
INSERT INTO promociones (codigo, nombre, tipo_descuento, valor_descuento, fecha_inicio, fecha_fin, limite_uso) VALUES
('SAVE20', '20% de descuento', 'Porcentaje', 20.00, '2025-08-01', '2025-08-31', 100),
('FREE50', '$50 de descuento', 'Monto_Fijo', 50.00, '2025-08-15', '2025-09-15', 50);
```

#### Paso 3B: Casos de Prueba de Validación (30 minutos)

**Ejecuta estos casos de prueba y documenta resultados**:

```sql
-- CASO 1: Intentar insertar precio negativo (DEBE FALLAR)
INSERT INTO productos (sku, nombre, categoria_id, precio_base, stock_total, stock_disponible) 
VALUES ('TEST-001', 'Producto Prueba', 1, -10.00, 10, 10);

-- CASO 2: Intentar precio descuento mayor al base (DEBE FALLAR)
INSERT INTO productos (sku, nombre, categoria_id, precio_base, precio_descuento, stock_total, stock_disponible) 
VALUES ('TEST-002', 'Producto Prueba', 1, 100.00, 150.00, 10, 10);

-- CASO 3: Intentar descuento mayor al 80% (DEBE FALLAR)
INSERT INTO productos (sku, nombre, categoria_id, precio_base, precio_descuento, stock_total, stock_disponible) 
VALUES ('TEST-003', 'Producto Prueba', 1, 100.00, 15.00, 10, 10);

-- CASO 4: Intentar stock inconsistente (DEBE FALLAR)
INSERT INTO productos (sku, nombre, categoria_id, precio_base, stock_total, stock_disponible, stock_reservado) 
VALUES ('TEST-004', 'Producto Prueba', 1, 50.00, 10, 8, 5);

-- CASO 5: Promoción con fechas incorrectas (DEBE FALLAR)
INSERT INTO promociones (codigo, nombre, tipo_descuento, valor_descuento, fecha_inicio, fecha_fin)
VALUES ('INVALID', 'Promoción Inválida', 'Porcentaje', 25.00, '2025-12-31', '2025-01-01');

-- CASO 6: Pedido con más de 3 pendientes por cliente (DEBE FALLAR)
INSERT INTO pedidos (cliente_id, numero_orden, subtotal, monto_total, direccion_envio) VALUES
(1, 'ORD-001', 100.00, 100.00, 'Dirección 1'),
(1, 'ORD-002', 150.00, 150.00, 'Dirección 1'),
(1, 'ORD-003', 200.00, 200.00, 'Dirección 1'),
(1, 'ORD-004', 75.00, 75.00, 'Dirección 1'); -- Esta debe fallar
```

### Fase 4: Análisis de Rendimiento (30 minutos)

#### Paso 4A: Análisis de Impacto en INSERT/UPDATE (15 minutos)

**Ejecuta estas pruebas de rendimiento**:

```sql
-- Crear tabla temporal para testing de volumen
CREATE TABLE productos_temp LIKE productos;

-- Insertar 1000 productos sin constraints
SET foreign_key_checks = 0;
-- Inserta datos masivos y mide tiempo
-- [Implement batch insert logic]

SET foreign_key_checks = 1;
-- Repite con constraints activos y compara tiempos
```

#### Paso 4B: Optimización de Constraints (15 minutos)

**Analiza y optimiza constraints problemáticos**:

```sql
-- Verifica qué constraints consumen más recursos
SHOW ENGINE INNODB STATUS;

-- Analiza planes de ejecución para operaciones con constraints
EXPLAIN INSERT INTO productos (...);
EXPLAIN UPDATE productos SET stock_disponible = ... WHERE ...;
```

## 📋 Entregables

### 1. Scripts DDL Completos
- [ ] Creación de todas las tablas con constraints básicos
- [ ] Implementación de todos los CHECK constraints
- [ ] Código de todos los triggers con comentarios explicativos
- [ ] Creación de índices de soporte

### 2. Reporte de Testing (2 páginas)
- [ ] Resultados de todos los casos de prueba
- [ ] Explicación de por qué cada caso debe fallar o pasar
- [ ] Capturas de pantalla de mensajes de error
- [ ] Análisis de cobertura de validaciones

### 3. Análisis de Rendimiento (1 página)
- [ ] Comparación de tiempos con/sin constraints
- [ ] Identificación de constraints más costosos
- [ ] Recomendaciones de optimización
- [ ] Trade-offs entre integridad y rendimiento

### 4. Documentación de Constraints (1 página)
- [ ] Catálogo completo de constraints implementados
- [ ] Mapeo constraint → regla de negocio
- [ ] Instrucciones de mantenimiento
- [ ] Casos de uso para cada tipo de constraint

## 🎯 Criterios de Evaluación

| Aspecto | Excelente (4) | Proficiente (3) | Básico (2) | Insuficiente (1) |
|---------|---------------|-----------------|------------|------------------|
| **Implementación de Constraints** | Todos los constraints implementados correctamente, funcionan según especificación | Mayoría de constraints funcionan, algunos errores menores | Constraints básicos funcionan, algunos complejos fallan | Muchos constraints no funcionan o están mal implementados |
| **Triggers y Validaciones** | Triggers complejos funcionan perfectamente, manejan todos los casos edge | Triggers funcionan para casos principales | Triggers básicos funcionan | Triggers no funcionan o causan errores |
| **Testing y Validación** | Testing exhaustivo con casos edge, documentación completa de resultados | Testing adecuado con documentación clara | Testing básico con algunos resultados documentados | Testing insuficiente o mal documentado |
| **Análisis de Rendimiento** | Análisis profundo con métricas precisas y recomendaciones | Análisis correcto con conclusiones apropiadas | Análisis básico con algunas métricas | Análisis superficial o incorrecto |

## 🔗 Recursos de Apoyo

### 📚 Referencias Técnicas
- Manual de MySQL sobre Constraints: https://dev.mysql.com/doc/refman/8.0/en/constraints.html
- PostgreSQL Constraint Documentation
- SQL Server Check Constraints Best Practices

### 🛠️ Herramientas de Testing
- MySQL Workbench para desarrollo visual
- JMeter para testing de carga
- Herramientas de profiling específicas del SGBD

## 🧠 Preguntas Reflexivas Post-Actividad

1. **Balance integridad-rendimiento**: ¿Cuándo elegirías validar datos en la aplicación vs en la base de datos?

2. **Mantenimiento**: ¿Cómo cambiarías un constraint en producción sin causar downtime?

3. **Escalabilidad**: ¿Qué constraints serían problemáticos con millones de registros y cómo los optimizarías?

4. **Debugging**: ¿Qué estrategias usarías para debuggear un trigger complejo que causa errores esporádicos?

## 📈 Indicadores de Impacto Desarrollados

- **A - Adaptación a contextos complejos**: Implementación de validaciones empresariales complejas
- **C - Soluciones innovadoras**: Uso creativo de triggers y constraints para resolver problemas
- **D - Pensamiento crítico**: Análisis de trade-offs entre integridad, rendimiento y mantenibilidad
- **F - Trabajo autónomo**: Investigación independiente de características específicas del SGBD
