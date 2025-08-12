# Actividad 4: Migración y Versionado de Esquemas

## 🎯 Objetivo de la Actividad
**Aplicar técnicas de migración y versionado de esquemas para gestionar la evolución de bases de datos en entornos de desarrollo, testing y producción de manera segura y controlada.**

**Duración estimada**: 3 horas  
**Modalidad**: Equipos de 2 personas (pair programming)

## 🎓 Competencias a Desarrollar
- Gestiona cambios de esquema en entornos productivos
- Implementa estrategias de migración sin downtime
- Controla versiones de esquemas de base de datos
- Planifica y ejecuta rollbacks seguros
- Documenta y automatiza procesos de migración

## 📚 Introducción

En entornos empresariales reales, los esquemas de bases de datos evolucionan constantemente. Esta actividad simula un escenario real donde debes migrar un sistema legacy a una nueva versión mientras mantienes operativa la aplicación 24/7.

### Principios de Migración de BD
1. **Zero Downtime Deployment** - Cambios sin interrumpir servicio
2. **Backward Compatibility** - Nueva versión compatible con código anterior
3. **Rollback Strategy** - Plan B para cada cambio
4. **Incremental Changes** - Cambios pequeños y frecuentes vs cambios masivos
5. **Testing in Production-like Environment** - Validación previa en staging

## 🏪 Caso de Estudio: Modernización de Sistema de Retail

### Contexto Empresarial
Una cadena de retail con 500 tiendas necesita modernizar su sistema de punto de venta (POS) de la versión 1.0 a 2.0, manteniendo operaciones continuas durante la migración.

### Esquema Legacy (v1.0) - Estado Actual
```sql
-- Sistema actual funcionando en producción
CREATE TABLE customers (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    email VARCHAR(100),
    created_at DATETIME DEFAULT NOW()
);

CREATE TABLE products (
    id INT PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    price DECIMAL(8,2) NOT NULL,
    stock INT DEFAULT 0,
    category VARCHAR(50)
);

CREATE TABLE sales (
    id INT PRIMARY KEY,
    customer_id INT,
    sale_date DATETIME DEFAULT NOW(),
    total DECIMAL(10,2) NOT NULL,
    payment_method ENUM('CASH', 'CARD') DEFAULT 'CASH',
    FOREIGN KEY (customer_id) REFERENCES customers(id)
);

CREATE TABLE sale_items (
    id INT PRIMARY KEY,
    sale_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(8,2) NOT NULL,
    FOREIGN KEY (sale_id) REFERENCES sales(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);
```

### Requerimientos de Modernización (v2.0)

**REQ-1: Separación de Nombres de Clientes**:
- Campo `name` → `first_name` + `last_name`
- Mantener compatibilidad con aplicaciones que usan `name`

**REQ-2: Categorías como Entidad Separada**:
- Crear tabla `categories` independiente
- Migrar categorías existentes sin duplicados
- Mantener referencia desde `products`

**REQ-3: Sistema de Auditoría**:
- Agregar campos `created_at`, `updated_at` a todas las tablas
- Implementar triggers para actualización automática
- Migrar fechas existentes

**REQ-4: Soporte Multi-moneda**:
- Agregar campo `currency` a productos y ventas
- Convertir precios existentes a estructura multi-moneda
- Default 'USD' para registros legacy

**REQ-5: Métodos de Pago Extendidos**:
- Expandir ENUM de payment_method
- Agregar tabla `payments` para métodos múltiples por venta
- Migrar datos existentes

## 🔧 Metodología de Trabajo

### Fase 1: Análisis y Planificación (45 minutos)

#### Paso 1A: Análisis de Impacto (20 minutos)

**Completa esta matriz de impacto para cada cambio**:

| Cambio | Tablas Afectadas | Apps Afectadas | Risk Level | Downtime Required | Rollback Complexity |
|--------|------------------|----------------|------------|-------------------|-------------------|
| Separación de nombres | `customers` | POS, CRM, Reports | MEDIUM | NO | LOW |
| Categorías separadas | `products`, new `categories` | Inventory, POS | HIGH | NO | MEDIUM |
| Campos de auditoría | ALL | Minimal | LOW | NO | LOW |
| Multi-moneda | `products`, `sales` | POS, Accounting | HIGH | NO | HIGH |
| Pagos extendidos | `sales`, new `payments` | POS | HIGH | NO | HIGH |

#### Paso 1B: Estrategia de Migración (25 minutos)

**Define la estrategia por fases**:

```
FASE 1 (Preparación): 
- Crear nuevas columnas como NULLABLE
- Crear nuevas tablas
- Implementar triggers de sincronización

FASE 2 (Migración de Datos):
- Migrar datos históricos en batches
- Validar integridad después de cada batch
- Monitorear rendimiento durante migración

FASE 3 (Transición):
- Actualizar aplicaciones para usar nuevas columnas/tablas
- Mantener sincronización bidireccional temporalmente
- Validar funcionalidad completa

FASE 4 (Limpieza):
- Remover columnas/tablas obsoletas
- Optimizar índices para nueva estructura
- Finalizar documentación
```

### Fase 2: Implementación de Migraciones (90 minutos)

#### Paso 2A: Migración 001 - Separación de Nombres (20 minutos)

**Archivo: `migration_001_split_customer_names.sql`**

```sql
-- =====================================================
-- MIGRACIÓN 001: Separación de nombres de clientes
-- TIPO: Estructura de tabla (SAFE - Sin downtime)
-- ROLLBACK: migration_001_rollback.sql
-- =====================================================

-- Paso 1: Agregar nuevas columnas
ALTER TABLE customers 
ADD COLUMN first_name VARCHAR(50),
ADD COLUMN last_name VARCHAR(50);

-- Paso 2: Migrar datos existentes
UPDATE customers 
SET 
    first_name = SUBSTRING_INDEX(name, ' ', 1),
    last_name = CASE 
        WHEN LOCATE(' ', name) > 0 
        THEN SUBSTRING(name, LOCATE(' ', name) + 1)
        ELSE ''
    END
WHERE first_name IS NULL;

-- Paso 3: Crear vista de compatibilidad
CREATE VIEW customers_v1 AS
SELECT 
    id,
    CONCAT(first_name, ' ', last_name) AS name,
    phone,
    email,
    created_at
FROM customers;

-- Paso 4: Validación
SELECT 
    COUNT(*) as total,
    COUNT(first_name) as with_first_name,
    COUNT(CASE WHEN first_name != name THEN 1 END) as processed
FROM customers;
```

**Archivo: `migration_001_rollback.sql`**

```sql
-- ROLLBACK para migración 001
DROP VIEW IF EXISTS customers_v1;
ALTER TABLE customers 
DROP COLUMN first_name,
DROP COLUMN last_name;
```

#### Paso 2B: Migración 002 - Categorías como Entidad (25 minutos)

**Archivo: `migration_002_categories_table.sql`**

```sql
-- =====================================================
-- MIGRACIÓN 002: Categorías como tabla separada
-- TIPO: Nueva entidad + migración de datos
-- ROLLBACK: migration_002_rollback.sql
-- =====================================================

-- Paso 1: Crear tabla de categorías
CREATE TABLE categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME DEFAULT NOW() ON UPDATE NOW()
);

-- Paso 2: Insertar categorías únicas desde productos
INSERT INTO categories (name) 
SELECT DISTINCT category 
FROM products 
WHERE category IS NOT NULL AND category != '';

-- Paso 3: Agregar nueva columna category_id
ALTER TABLE products 
ADD COLUMN category_id INT,
ADD INDEX idx_category_id (category_id);

-- Paso 4: Actualizar productos con category_id
UPDATE products p
INNER JOIN categories c ON p.category = c.name
SET p.category_id = c.id;

-- Paso 5: Crear categoría "Sin Categoría" para productos sin categoría
INSERT INTO categories (name, description) 
VALUES ('Sin Categoría', 'Productos sin categoría asignada');

UPDATE products 
SET category_id = LAST_INSERT_ID() 
WHERE category_id IS NULL;

-- Paso 6: Hacer category_id NOT NULL
ALTER TABLE products 
MODIFY COLUMN category_id INT NOT NULL;

-- Paso 7: Agregar foreign key
ALTER TABLE products 
ADD CONSTRAINT fk_products_category 
FOREIGN KEY (category_id) REFERENCES categories(id);

-- Paso 8: Validación
SELECT 
    'Productos sin category_id' as check_name,
    COUNT(*) as count
FROM products 
WHERE category_id IS NULL

UNION ALL

SELECT 
    'Categorías huérfanas' as check_name,
    COUNT(*) as count
FROM categories c
LEFT JOIN products p ON c.id = p.category_id
WHERE p.category_id IS NULL;
```

#### Paso 2C: Migración 003 - Sistema de Auditoría (20 minutos)

**Archivo: `migration_003_audit_fields.sql`**

```sql
-- =====================================================
-- MIGRACIÓN 003: Sistema de auditoría
-- TIPO: Agregado de columnas + triggers
-- ROLLBACK: migration_003_rollback.sql
-- =====================================================

-- Agregar campos de auditoría donde falten
ALTER TABLE products 
ADD COLUMN created_at DATETIME DEFAULT NOW(),
ADD COLUMN updated_at DATETIME DEFAULT NOW() ON UPDATE NOW();

ALTER TABLE sales 
ADD COLUMN updated_at DATETIME DEFAULT NOW() ON UPDATE NOW();

-- Inicializar created_at para registros existentes
UPDATE products SET created_at = NOW() WHERE created_at IS NULL;
UPDATE customers SET created_at = NOW() WHERE created_at IS NULL;

-- Crear triggers para updated_at (para SGBD que no soporten ON UPDATE)
DELIMITER //

CREATE TRIGGER trg_customers_updated_at
BEFORE UPDATE ON customers
FOR EACH ROW
BEGIN
    SET NEW.updated_at = NOW();
END;//

CREATE TRIGGER trg_products_updated_at  
BEFORE UPDATE ON products
FOR EACH ROW
BEGIN
    SET NEW.updated_at = NOW();
END;//

DELIMITER ;

-- Validación
SELECT TABLE_NAME, COLUMN_NAME 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_SCHEMA = DATABASE() 
  AND COLUMN_NAME IN ('created_at', 'updated_at')
ORDER BY TABLE_NAME, COLUMN_NAME;
```

#### Paso 2D: Migración 004 - Multi-moneda (25 minutos)

**Archivo: `migration_004_multi_currency.sql`**

```sql
-- =====================================================
-- MIGRACIÓN 004: Soporte multi-moneda
-- TIPO: Agregado de columnas + migración de datos
-- ROLLBACK: migration_004_rollback.sql
-- =====================================================

-- Paso 1: Agregar campos de moneda
ALTER TABLE products 
ADD COLUMN currency VARCHAR(3) DEFAULT 'USD' NOT NULL;

ALTER TABLE sales 
ADD COLUMN currency VARCHAR(3) DEFAULT 'USD' NOT NULL;

-- Paso 2: Crear tabla de tipos de cambio
CREATE TABLE exchange_rates (
    id INT AUTO_INCREMENT PRIMARY KEY,
    from_currency VARCHAR(3) NOT NULL,
    to_currency VARCHAR(3) NOT NULL,
    rate DECIMAL(10,6) NOT NULL,
    date_effective DATE NOT NULL,
    created_at DATETIME DEFAULT NOW(),
    
    UNIQUE KEY uk_currencies_date (from_currency, to_currency, date_effective),
    INDEX idx_date_effective (date_effective)
);

-- Insertar tipos de cambio base
INSERT INTO exchange_rates (from_currency, to_currency, rate, date_effective) VALUES
('USD', 'USD', 1.000000, '2025-01-01'),
('EUR', 'USD', 1.100000, '2025-01-01'),
('MXN', 'USD', 0.055000, '2025-01-01');

-- Paso 3: Función para conversión de moneda
DELIMITER //

CREATE FUNCTION convert_currency(
    amount DECIMAL(10,2),
    from_curr VARCHAR(3),
    to_curr VARCHAR(3),
    conversion_date DATE
) RETURNS DECIMAL(10,2)
READS SQL DATA
DETERMINISTIC
BEGIN
    DECLARE rate DECIMAL(10,6) DEFAULT 1.0;
    
    IF from_curr = to_curr THEN
        RETURN amount;
    END IF;
    
    SELECT er.rate INTO rate
    FROM exchange_rates er
    WHERE er.from_currency = from_curr 
      AND er.to_currency = to_curr
      AND er.date_effective <= conversion_date
    ORDER BY er.date_effective DESC
    LIMIT 1;
    
    RETURN amount * rate;
END;//

DELIMITER ;

-- Validación
SELECT 
    'Productos sin moneda' as check_name,
    COUNT(*) as count
FROM products 
WHERE currency IS NULL OR currency = '';
```

### Fase 3: Testing y Validación (60 minutos)

#### Paso 3A: Suite de Testing de Migración (30 minutos)

**Archivo: `migration_tests.sql`**

```sql
-- =====================================================
-- SUITE DE TESTING PARA MIGRACIONES
-- Validar integridad después de cada migración
-- =====================================================

-- Test 1: Integridad referencial
SELECT 'FAIL: Productos sin categoría' as test_result
FROM products p 
LEFT JOIN categories c ON p.category_id = c.id 
WHERE c.id IS NULL
HAVING COUNT(*) > 0

UNION ALL

SELECT 'PASS: Integridad referencial productos-categorías' as test_result
WHERE NOT EXISTS (
    SELECT 1 FROM products p 
    LEFT JOIN categories c ON p.category_id = c.id 
    WHERE c.id IS NULL
);

-- Test 2: Migración de nombres
SELECT 
    CASE 
        WHEN COUNT(*) = 0 THEN 'PASS: Todos los clientes tienen nombres separados'
        ELSE CONCAT('FAIL: ', COUNT(*), ' clientes sin nombres separados')
    END as test_result
FROM customers 
WHERE first_name IS NULL OR first_name = '';

-- Test 3: Campos de auditoría
SELECT 
    CASE 
        WHEN COUNT(*) = 0 THEN 'PASS: Todos los registros tienen created_at'
        ELSE CONCAT('FAIL: ', COUNT(*), ' registros sin created_at')
    END as test_result
FROM (
    SELECT id FROM customers WHERE created_at IS NULL
    UNION ALL
    SELECT id FROM products WHERE created_at IS NULL
) missing_dates;

-- Test 4: Consistencia de datos
SELECT 
    'Data consistency check' as test_name,
    COUNT(*) as total_sales,
    SUM(total) as total_amount,
    COUNT(DISTINCT customer_id) as unique_customers,
    COUNT(DISTINCT DATE(sale_date)) as days_with_sales
FROM sales;
```

#### Paso 3B: Testing de Rendimiento (30 minutos)

**Evalúa el impacto de las migraciones en consultas frecuentes**:

```sql
-- Benchmark: Consultas antes y después de migración
-- Ejecutar ANTES de migraciones
CREATE TABLE benchmark_before AS
SELECT 
    'pre_migration' as phase,
    NOW() as timestamp,
    (
        SELECT BENCHMARK(10000, (
            SELECT COUNT(*) FROM products WHERE category = 'Electronics'
        ))
    ) as query_1_time,
    (
        SELECT BENCHMARK(5000, (
            SELECT c.name, COUNT(s.id) as sales_count 
            FROM customers c 
            LEFT JOIN sales s ON c.id = s.customer_id 
            GROUP BY c.id 
            LIMIT 100
        ))
    ) as query_2_time;

-- Ejecutar DESPUÉS de migraciones
INSERT INTO benchmark_before
SELECT 
    'post_migration' as phase,
    NOW() as timestamp,
    (
        SELECT BENCHMARK(10000, (
            SELECT COUNT(*) FROM products p 
            JOIN categories cat ON p.category_id = cat.id 
            WHERE cat.name = 'Electronics'
        ))
    ) as query_1_time,
    (
        SELECT BENCHMARK(5000, (
            SELECT CONCAT(c.first_name, ' ', c.last_name) as name, COUNT(s.id) as sales_count 
            FROM customers c 
            LEFT JOIN sales s ON c.id = s.customer_id 
            GROUP BY c.id 
            LIMIT 100
        ))
    ) as query_2_time;

-- Comparar rendimiento
SELECT * FROM benchmark_before ORDER BY timestamp;
```

### Fase 4: Automatización y Documentación (45 minutos)

#### Paso 4A: Script de Migración Completa (25 minutos)

**Archivo: `run_migrations.sh`**

```bash
#!/bin/bash

# =====================================================
# SCRIPT MAESTRO DE MIGRACIÓN
# Ejecuta todas las migraciones en orden seguro
# =====================================================

DB_HOST="localhost"
DB_USER="migration_user"
DB_NAME="retail_pos"
BACKUP_DIR="./backups"
LOG_FILE="./migration.log"

echo "=== INICIANDO PROCESO DE MIGRACIÓN ===" | tee -a $LOG_FILE
echo "Fecha: $(date)" | tee -a $LOG_FILE

# Función para ejecutar SQL con logging
execute_sql() {
    local sql_file=$1
    local description=$2
    
    echo "Ejecutando: $description" | tee -a $LOG_FILE
    
    if mysql -h $DB_HOST -u $DB_USER -p $DB_NAME < $sql_file 2>> $LOG_FILE; then
        echo "✓ ÉXITO: $description" | tee -a $LOG_FILE
    else
        echo "✗ ERROR: $description" | tee -a $LOG_FILE
        exit 1
    fi
}

# Pre-migración: Backup completo
echo "Creando backup pre-migración..." | tee -a $LOG_FILE
mysqldump -h $DB_HOST -u $DB_USER -p $DB_NAME > "$BACKUP_DIR/pre_migration_$(date +%Y%m%d_%H%M%S).sql"

# Ejecutar migraciones en orden
execute_sql "migration_001_split_customer_names.sql" "001: Separación de nombres"
execute_sql "migration_002_categories_table.sql" "002: Tabla de categorías"
execute_sql "migration_003_audit_fields.sql" "003: Campos de auditoría"
execute_sql "migration_004_multi_currency.sql" "004: Multi-moneda"

# Post-migración: Testing
execute_sql "migration_tests.sql" "Testing de validación"

echo "=== MIGRACIÓN COMPLETADA EXITOSAMENTE ===" | tee -a $LOG_FILE
```

#### Paso 4B: Documentación de Migración (20 minutos)

**Archivo: `MIGRATION_GUIDE.md`**

```markdown
# Guía de Migración - Sistema POS v1.0 → v2.0

## Resumen Ejecutivo
- **Duración estimada**: 2 horas
- **Downtime requerido**: 0 minutos
- **Rollback disponible**: Sí, para cada migración
- **Impacto en aplicaciones**: Mínimo (compatibilidad mantenida)

## Pre-requisitos
- [ ] Backup completo de base de datos
- [ ] Permisos de administrador de BD
- [ ] Validación en ambiente de staging
- [ ] Notificación a equipos de desarrollo

## Orden de Ejecución
1. `migration_001` - Separación de nombres (SAFE)
2. `migration_002` - Categorías separadas (MEDIUM RISK)
3. `migration_003` - Campos de auditoría (SAFE)
4. `migration_004` - Multi-moneda (HIGH RISK)

## Puntos de Validación
Después de cada migración, verificar:
- Integridad referencial mantenida
- Aplicaciones funcionando normalmente
- Métricas de rendimiento estables
- Logs sin errores críticos

## Plan de Rollback
Cada migración tiene su script de rollback correspondiente.
Ejecutar en orden inverso si es necesario.

## Monitoreo Post-Migración
- Revisar logs de aplicación por 24 horas
- Monitorear métricas de rendimiento
- Validar reportes críticos de negocio
```

## 📋 Entregables

### 1. Plan de Migración Completo
- [ ] Análisis de impacto detallado
- [ ] Estrategia por fases documentada
- [ ] Cronograma con dependencias
- [ ] Plan de comunicación a stakeholders

### 2. Scripts de Migración
- [ ] 4+ archivos de migración numerados secuencialmente
- [ ] Scripts de rollback para cada migración
- [ ] Script maestro de ejecución automatizada
- [ ] Suite de testing y validación

### 3. Documentación Técnica
- [ ] Guía paso a paso para DBA
- [ ] Documentación de cambios de API
- [ ] Plan de monitoreo post-migración
- [ ] Troubleshooting guide

### 4. Reporte de Testing
- [ ] Resultados de testing en staging
- [ ] Benchmarks de rendimiento antes/después
- [ ] Validación de integridad de datos
- [ ] Casos edge identificados y resueltos

## 🎯 Criterios de Evaluación

| Aspecto | Excelente (4) | Proficiente (3) | Básico (2) | Insuficiente (1) |
|---------|---------------|-----------------|------------|------------------|
| **Planificación de Migración** | Plan detallado con análisis de riesgos completo | Plan sólido con consideraciones principales | Plan básico funcional | Plan incompleto o poco realista |
| **Implementación de Scripts** | Scripts robustos con manejo de errores y logging | Scripts funcionales bien estructurados | Scripts básicos que funcionan | Scripts con errores o mal estructurados |
| **Estrategia de Rollback** | Rollback completo probado para todos los cambios | Rollback funcional para cambios principales | Rollback básico implementado | Sin estrategia de rollback o deficiente |
| **Testing y Validación** | Testing exhaustivo con automatización | Testing adecuado con validaciones clave | Testing básico funcional | Testing insuficiente o sin validaciones |
| **Documentación** | Documentación completa para todos los stakeholders | Documentación clara y funcional | Documentación básica presente | Documentación deficiente o ausente |

## 🧠 Preguntas Reflexivas Post-Actividad

1. **Gestión de riesgos**: ¿Cómo priorizaste las migraciones según su nivel de riesgo?

2. **Zero downtime**: ¿Qué estrategias usaste para evitar interrupciones del servicio?

3. **Backward compatibility**: ¿Cómo aseguraste que las aplicaciones existentes siguieran funcionando?

4. **Monitoreo**: ¿Qué métricas considerarías críticas para monitorear después de la migración?

5. **Automatización**: ¿Cómo mejorarías el proceso de migración para futuras versiones?

## 📈 Indicadores de Impacto Desarrollados

- **A - Adaptación a contextos complejos**: Gestión de migración en ambiente productivo simulado
- **C - Soluciones innovadoras**: Estrategias creativas para zero-downtime deployment
- **D - Pensamiento crítico**: Análisis de riesgos y toma de decisiones bajo incertidumbre
- **F - Trabajo autónomo**: Planificación y ejecución independiente de proceso complejo
