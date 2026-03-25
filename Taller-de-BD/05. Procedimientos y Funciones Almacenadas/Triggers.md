# Triggers en SQL Server

**Taller de Base de Datos**

---

## Tabla de Contenidos

1. [Introducción a los Triggers](#1-introducción-a-los-triggers)
2. [Tipos de Triggers](#2-tipos-de-triggers)
3. [Sintaxis y Creación](#3-sintaxis-y-creación)
4. [Tablas Especiales: INSERTED y DELETED](#4-tablas-especiales-inserted-y-deleted)
5. [Trigger FOR INSERT](#5-trigger-for-insert)
6. [Trigger FOR DELETE](#6-trigger-for-delete)
7. [Trigger FOR UPDATE](#7-trigger-for-update)
8. [Triggers INSTEAD OF](#8-triggers-instead-of)
9. [Ejemplos Prácticos](#9-ejemplos-prácticos)
10. [Consideraciones de Performance](#10-consideraciones-de-performance)
11. [Modificación y Eliminación](#11-modificación-y-eliminación)
12. [Mejores Prácticas](#12-mejores-prácticas)
13. [Ejercicios](#13-ejercicios)

---

## 1. Introducción a los Triggers

### ¿Qué es un Trigger?

Un **trigger** (disparador) es un tipo especial de procedimiento almacenado que se ejecuta automáticamente en respuesta a eventos específicos en una tabla o vista.

**Características principales:**

- Se invoca automáticamente cuando se ejecuta un `INSERT`, `UPDATE` o `DELETE` sobre la tabla con la cual está asociado
- **No puede ser llamado directamente** (a diferencia de los procedimientos almacenados normales)
- El código del trigger y la instrucción que lo invocó forman parte de la **misma transacción**
- Se ejecuta de forma transparente para el usuario o aplicación que ejecuta la operación DML

### Para qué sirven los Triggers

#### 1. Realizar Cambios en Cascada

Los triggers pueden realizar cambios en cascada a través de tablas relacionadas. Sin embargo, estos cambios pueden ser realizados de forma más eficiente utilizando **integridad referencial** (FOREIGN KEY con opciones CASCADE).

**Ejemplo:** Cuando se elimina un cliente, automáticamente eliminar sus pedidos asociados.

#### 2. Garantizar la Consistencia de los Datos

Se usan para garantizar la **integridad referencial** en casos donde un constraint `CHECK` no puede realizar la validación.

**Ejemplo:** Validar que un empleado no puede ser asignado a más de 3 proyectos simultáneamente.

#### 3. Auditoría y Registro de Cambios

Los triggers pueden registrar automáticamente quién, cuándo y qué cambios se realizaron en los datos.

**Ejemplo:** Crear una tabla de auditoría que registre todas las modificaciones a datos sensibles.

#### 4. Validaciones Complejas

Implementar lógica de negocio compleja que involucra múltiples tablas o condiciones.

**Ejemplo:** Prevenir la eliminación de un cliente si tiene préstamos activos.

### Consideraciones para Usar Triggers

| Consideración | Descripción |
|---------------|-------------|
| **Constraints primero** | Los constraints (PRIMARY KEY, FOREIGN KEY, CHECK, UNIQUE) se verifican **antes** que los triggers |
| **Múltiples triggers** | Una tabla puede tener varios triggers (uno por cada tipo de evento) |
| **Permisos** | El propietario de la tabla debe tener permisos suficientes para crear triggers |
| **Tablas temporales** | **NO** se pueden crear triggers sobre tablas temporales (#temp, ##temp) |
| **No retornan valores** | Los triggers no pueden retornar valores como los procedimientos almacenados |
| **Transacciones implícitas** | Las acciones del trigger son parte implícita de la transacción que lo invocó |

---

## 2. Tipos de Triggers

SQL Server soporta dos tipos principales de triggers según el momento de ejecución:

### 2.1 AFTER Triggers (o FOR Triggers)

**Características:**

- Se ejecutan **después** de que la acción `INSERT`, `UPDATE` o `DELETE` se ha realizado
- Solo se pueden definir sobre **tablas** (no sobre vistas)
- Se ejecutan después de que los constraints se han verificado
- La operación DML ya modificó la tabla cuando el trigger se ejecuta

**Sintaxis:**

```sql
CREATE TRIGGER trigger_name
ON table_name
FOR INSERT | UPDATE | DELETE  -- o AFTER INSERT | UPDATE | DELETE
AS
BEGIN
    -- Código T-SQL
END
```

**Cuándo usar:**

- Auditoría de cambios
- Actualizaciones en cascada a tablas relacionadas
- Cálculos derivados que dependen de los datos ya insertados/actualizados

### 2.2 INSTEAD OF Triggers

**Características:**

- Se ejecutan **en lugar de** la instrucción `INSERT`, `UPDATE` o `DELETE`
- Pueden definirse sobre **tablas o vistas**
- La operación DML original **NO se ejecuta**; el trigger debe implementar la lógica completa
- Especialmente útiles para **vistas no actualizables**

**Sintaxis:**

```sql
CREATE TRIGGER trigger_name
ON table_or_view_name
INSTEAD OF INSERT | UPDATE | DELETE
AS
BEGIN
    -- Código T-SQL que reemplaza la operación original
END
```

**Restricciones de INSTEAD OF:**

- Solo puede haber **un trigger INSTEAD OF** por cada acción (INSERT, UPDATE, DELETE) en una tabla/vista
- **No se pueden combinar** con claves foráneas definidas con `CASCADE`
- No pueden ser recursivos directos

**Cuándo usar:**

- Actualizar datos a través de vistas que unen múltiples tablas
- Implementar lógica personalizada completa antes de modificar datos
- Prevenir operaciones bajo ciertas condiciones

---

## 3. Sintaxis y Creación

### Sintaxis Completa

```sql
CREATE TRIGGER trigger_name 
ON { table_name | view_name } 
[ WITH ENCRYPTION ] 
{ 
    { FOR | AFTER | INSTEAD OF } 
    { [ INSERT ] [ , ] [ UPDATE ] [ , ] [ DELETE ] } 
    AS 
    BEGIN
        [ IF UPDATE (column_name) 
            [ { AND | OR } UPDATE (column_name) ] 
        ]
        
        [ IF (COLUMNS_UPDATED() { bitwise_operator } updated_bitmask) 
            { comparison_operator } column_bitmask 
        ]
        
        -- Instrucciones T-SQL
        sql_statement [ ...n ]
    END
}
```

### Componentes Principales

| Componente | Descripción |
|------------|-------------|
| `trigger_name` | Nombre único del trigger (máximo 128 caracteres) |
| `ON table_name` | Tabla o vista sobre la cual se define el trigger |
| `WITH ENCRYPTION` | Encripta el texto del trigger en sys.syscomments |
| `FOR / AFTER` | Trigger se ejecuta después de la operación |
| `INSTEAD OF` | Trigger se ejecuta en lugar de la operación |
| `INSERT / UPDATE / DELETE` | Eventos que disparan el trigger |
| `IF UPDATE(column)` | Verifica si una columna específica fue modificada (solo UPDATE) |
| `COLUMNS_UPDATED()` | Función que retorna bitmask de columnas actualizadas |

### Ejemplo Básico de Creación

```sql
-- Trigger que se ejecuta después de INSERT en la tabla 'loan'
CREATE TRIGGER loan_insert
ON loan
FOR INSERT
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Marcar libro como prestado cuando se registra un préstamo
    UPDATE c 
    SET on_loan = 'Y'
    FROM copy c 
    INNER JOIN inserted i
        ON c.isbn = i.isbn 
        AND c.copy_no = i.copy_no;
END
GO
```

### Creación con Opciones Avanzadas

```sql
-- Trigger con encriptación que se ejecuta en múltiples eventos
CREATE TRIGGER member_audit
ON member
WITH ENCRYPTION
FOR INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Registrar cambios en tabla de auditoría
    INSERT INTO member_audit_log (member_no, action_type, action_date, username)
    SELECT 
        COALESCE(i.member_no, d.member_no),
        CASE 
            WHEN i.member_no IS NOT NULL AND d.member_no IS NOT NULL THEN 'UPDATE'
            WHEN i.member_no IS NOT NULL THEN 'INSERT'
            ELSE 'DELETE'
        END,
        GETDATE(),
        SYSTEM_USER
    FROM inserted i
    FULL OUTER JOIN deleted d ON i.member_no = d.member_no;
END
GO
```

---

## 4. Tablas Especiales: INSERTED y DELETED

Los triggers tienen acceso a dos **tablas temporales especiales** que contienen las filas afectadas por la operación:

### Tabla INSERTED

- Contiene las **nuevas filas** que se están insertando o los **nuevos valores** después de un UPDATE
- Disponible en triggers `INSERT` y `UPDATE`
- Estructura idéntica a la tabla sobre la cual se define el trigger

### Tabla DELETED

- Contiene las **filas que se están eliminando** o los **valores antiguos** antes de un UPDATE
- Disponible en triggers `DELETE` y `UPDATE`
- Estructura idéntica a la tabla sobre la cual se define el trigger

### Resumen de Disponibilidad

| Operación | Tabla INSERTED | Tabla DELETED |
|-----------|----------------|---------------|
| **INSERT** | ✅ Contiene nuevas filas | ❌ Vacía |
| **UPDATE** | ✅ Contiene valores nuevos | ✅ Contiene valores antiguos |
| **DELETE** | ❌ Vacía | ✅ Contiene filas eliminadas |

### Ejemplo de Uso

```sql
CREATE TRIGGER employee_salary_audit
ON employees
FOR UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Comparar salario antiguo vs nuevo
    INSERT INTO salary_changes (employee_id, old_salary, new_salary, change_date)
    SELECT 
        i.employee_id,
        d.salary AS old_salary,
        i.salary AS new_salary,
        GETDATE()
    FROM inserted i
    INNER JOIN deleted d ON i.employee_id = d.employee_id
    WHERE i.salary <> d.salary;  -- Solo cuando el salario cambió
END
GO
```

**Importante:** Las tablas `inserted` y `deleted` están en **memoria caché**, lo que hace que los triggers sean muy rápidos al accederlas.

---

## 5. Trigger FOR INSERT

### Funcionamiento

Cuando se ejecuta una instrucción `INSERT` en una tabla con un trigger `FOR INSERT` definido:

```
┌─────────────────────────────────────┐
│ 1. Se ejecuta la instrucción INSERT │
├─────────────────────────────────────┤
│ 2. Filas insertadas se copian a     │
│    tabla INSERTED                   │
├─────────────────────────────────────┤
│ 3. El trigger se ejecuta y puede    │
│    acceder a la tabla INSERTED      │
└─────────────────────────────────────┘
```

### Ejemplo: Sistema de Biblioteca - Préstamo de Libros

**Escenario:** Cuando se registra un préstamo, automáticamente marcar el libro como "prestado" en la tabla de copias.

**Tablas involucradas:**

```sql
-- Tabla de préstamos
CREATE TABLE loan (
    loan_id INT IDENTITY PRIMARY KEY,
    isbn VARCHAR(20),
    copy_no INT,
    title_no INT,
    member_no INT,
    out_date DATE,
    due_date DATE
);

-- Tabla de copias de libros
CREATE TABLE copy (
    isbn VARCHAR(20),
    copy_no INT,
    title_no INT,
    on_loan CHAR(1) DEFAULT 'N',  -- 'Y' = prestado, 'N' = disponible
    PRIMARY KEY (isbn, copy_no)
);
```

**Trigger:**

```sql
USE library;
GO

CREATE TRIGGER loan_insert
ON loan
FOR INSERT
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Actualizar estado de la copia a "prestada"
    UPDATE c 
    SET on_loan = 'Y'
    FROM copy c 
    INNER JOIN inserted i
        ON c.isbn = i.isbn 
        AND c.copy_no = i.copy_no;
    
    PRINT 'Libro marcado como prestado';
END
GO
```

**Ejecución:**

```sql
-- Registrar un préstamo
INSERT INTO loan (isbn, copy_no, title_no, member_no, out_date, due_date)
VALUES ('603', 4, 11, 123, GETDATE(), DATEADD(DAY, 30, GETDATE()));

-- Resultado:
-- La tabla loan tiene la nueva fila
-- La tabla copy ahora muestra on_loan = 'Y' para isbn='603', copy_no=4
-- El trigger se ejecutó automáticamente
```

**Visualización del proceso:**

**ANTES del INSERT:**

| loan (vacía inicialmente) |
|---------------------------|

| copy |
|------|
| isbn | copy_no | title_no | on_loan |
|------|---------|----------|---------|
| 603  | 4       | 11       | **N**   |

**DESPUÉS del INSERT (trigger ejecutado):**

| loan |
|------|
| isbn | copy_no | title_no | member_no | out_date   | due_date   |
|------|---------|----------|-----------|------------|------------|
| 603  | 4       | 11       | 123       | 2025-12-01 | 2025-12-31 |

| copy |
|------|
| isbn | copy_no | title_no | on_loan |
|------|---------|----------|---------|
| 603  | 4       | 11       | **Y**   |

| inserted (tabla temporal del trigger) |
|----------------------------------------|
| isbn | copy_no | title_no | member_no | out_date   | due_date   |
|------|---------|----------|-----------|------------|------------|
| 603  | 4       | 11       | 123       | 2025-12-01 | 2025-12-31 |

### Ejemplo: Auditoría de Inserciones

```sql
CREATE TRIGGER customer_insert_audit
ON customers
FOR INSERT
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Registrar quién insertó el cliente y cuándo
    INSERT INTO customers_audit (customer_id, action, username, action_date)
    SELECT 
        customer_id, 
        'INSERT', 
        SYSTEM_USER, 
        GETDATE()
    FROM inserted;
END
GO
```

---

## 6. Trigger FOR DELETE

### Funcionamiento

Cuando se ejecuta una instrucción `DELETE` en una tabla con un trigger `FOR DELETE` definido:

```
┌─────────────────────────────────────┐
│ 1. Se ejecuta la instrucción DELETE │
├─────────────────────────────────────┤
│ 2. Filas eliminadas se copian a     │
│    tabla DELETED                    │
├─────────────────────────────────────┤
│ 3. El trigger se ejecuta y puede    │
│    acceder a la tabla DELETED       │
└─────────────────────────────────────┘
```

### Ejemplo: Sistema de Biblioteca - Devolución de Libros

**Escenario:** Cuando se elimina un préstamo (libro devuelto), automáticamente marcar el libro como "disponible" en la tabla de copias.

**Trigger:**

```sql
USE library;
GO

CREATE TRIGGER loan_delete
ON loan
FOR DELETE
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Actualizar estado de la copia a "disponible"
    UPDATE c 
    SET on_loan = 'N'
    FROM copy c 
    INNER JOIN deleted d
        ON c.isbn = d.isbn 
        AND c.copy_no = d.copy_no;
    
    PRINT 'Libro marcado como disponible';
END
GO
```

**Ejecución:**

```sql
-- Devolver un libro (eliminar el préstamo)
DELETE FROM loan
WHERE isbn = '4' AND copy_no = 1;

-- Resultado:
-- La fila se eliminó de loan
-- La tabla copy ahora muestra on_loan = 'N' para isbn='4', copy_no=1
-- El trigger se ejecutó automáticamente
```

**Visualización del proceso:**

**ANTES del DELETE:**

| loan |
|------|
| isbn | copy_no | title_no | member_no | out_date   | due_date   |
|------|---------|----------|-----------|------------|------------|
| 1    | 1       | 1001     | 1         | 2091-02-13 | 2091-02-27 |
| **4**| **1**   | **1004** | **1**     | **2091-02-13** | **2091-02-27** |
| 4    | 4       | 1004     | 3         | 2091-02-14 | 2091-02-28 |

| copy |
|------|
| isbn | copy_no | title_no | on_loan |
|------|---------|----------|---------|
| 1    | 1       | 1001     | Y       |
| **4**| **1**   | **1004** | **Y**   |
| 4    | 4       | 1004     | Y       |

**DESPUÉS del DELETE (trigger ejecutado):**

| loan |
|------|
| isbn | copy_no | title_no | member_no | out_date   | due_date   |
|------|---------|----------|-----------|------------|------------|
| 1    | 1       | 1001     | 1         | 2091-02-13 | 2091-02-27 |
| 4    | 4       | 1004     | 3         | 2091-02-14 | 2091-02-28 |

| copy |
|------|
| isbn | copy_no | title_no | on_loan |
|------|---------|----------|---------|
| 1    | 1       | 1001     | Y       |
| **4**| **1**   | **1004** | **N**   |
| 4    | 4       | 1004     | Y       |

| deleted (tabla temporal del trigger) |
|--------------------------------------|
| isbn | copy_no | title_no | member_no | out_date   | due_date   |
|------|---------|----------|-----------|------------|------------|
| 4    | 1       | 1004     | 1         | 2091-02-13 | 2091-02-27 |

### Ejemplo: Validar Eliminación

**Escenario:** Prevenir la eliminación de un miembro que aún tiene libros prestados.

```sql
CREATE TRIGGER member_delete
ON member
FOR DELETE
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Verificar si el miembro eliminado tiene préstamos activos
    IF EXISTS (
        SELECT 1 
        FROM loan l
        INNER JOIN deleted d ON l.member_no = d.member_no
    )
    BEGIN
        RAISERROR ('Transaction cannot be processed. This member still has books on loan.', 16, 1);
        ROLLBACK TRANSACTION;
    END
    ELSE
    BEGIN
        PRINT 'Member deleted successfully';
    END
END
GO
```

**Ejecución:**

```sql
-- Intentar eliminar un miembro con préstamos activos
DELETE FROM member WHERE member_no = 2;

-- Resultado:
-- ERROR: Transaction cannot be processed. This member still has books on loan.
-- La transacción se revierte (ROLLBACK)
-- El miembro NO se elimina

-- Eliminar un miembro sin préstamos
DELETE FROM member WHERE member_no = 5;

-- Resultado:
-- Member deleted successfully
-- El miembro se elimina correctamente
```

---

## 7. Trigger FOR UPDATE

### Funcionamiento

Cuando se ejecuta una instrucción `UPDATE` en una tabla con un trigger `FOR UPDATE` definido:

```
┌─────────────────────────────────────────┐
│ 1. Se ejecuta la instrucción UPDATE    │
├─────────────────────────────────────────┤
│ 2. Valores ANTIGUOS se copian a        │
│    tabla DELETED                        │
├─────────────────────────────────────────┤
│ 3. Valores NUEVOS se copian a          │
│    tabla INSERTED                       │
├─────────────────────────────────────────┤
│ 4. El trigger se ejecuta con acceso a  │
│    ambas tablas (INSERTED y DELETED)    │
└─────────────────────────────────────────┘
```

**Importante:** Un `UPDATE` internamente se registra como un `DELETE` (valores antiguos) + `INSERT` (valores nuevos).

### Ejemplo: Prevenir Actualización de Columna Clave

**Escenario:** Impedir que se modifique el número de miembro (clave primaria lógica) en la tabla `member`.

**Trigger:**

```sql
USE library;
GO

CREATE TRIGGER member_update
ON member
FOR UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Verificar si la columna member_no fue actualizada
    IF UPDATE(member_no)
    BEGIN
        RAISERROR ('Transaction cannot be processed. Member number cannot be modified.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END
GO
```

**Ejecución:**

```sql
-- Intentar cambiar el número de miembro
UPDATE member
SET member_no = 10021
WHERE member_no = 1234;

-- Resultado:
-- ERROR: Transaction cannot be processed. Member number cannot be modified.
-- La transacción se revierte
-- El member_no NO se actualiza
```

**Visualización del proceso:**

**ANTES del UPDATE:**

| member |
|--------|
| member_no | lastname | firstname | middleinitial |
|-----------|----------|-----------|---------------|
| 10020     | Anderson | Andrew    | A             |
| 10021     | Barr     | Andrew    | R             |
| **1234**  | **Barr** | **Andrew**| **R**         |
| 10023     | Anderson | Bill      | B             |

**INTENTO de UPDATE (rechazado por trigger):**

| inserted (valores nuevos que se intentan insertar) |
|-----------------------------------------------------|
| member_no | lastname | firstname | middleinitial |
|-----------|----------|-----------|---------------|
| **10021** | Barr     | Andrew    | R             |

| deleted (valores antiguos que se intentan eliminar) |
|------------------------------------------------------|
| member_no | lastname | firstname | middleinitial |
|-----------|----------|-----------|---------------|
| **1234**  | Barr     | Andrew    | R             |

**Resultado:** Transaction rolled back (revertida)

**DESPUÉS del UPDATE (sin cambios - trigger bloqueó la operación):**

| member |
|--------|
| member_no | lastname | firstname | middleinitial |
|-----------|----------|-----------|---------------|
| 10020     | Anderson | Andrew    | A             |
| 10021     | Barr     | Andrew    | R             |
| **1234**  | **Barr** | **Andrew**| **R**         |
| 10023     | Anderson | Bill      | B             |

### Función UPDATE()

La función `UPDATE(column_name)` retorna `TRUE` si la columna especificada fue incluida en la instrucción UPDATE (aunque el valor no haya cambiado realmente).

**Sintaxis:**

```sql
IF UPDATE(column_name)
    -- Lógica del trigger
```

**Ejemplo con múltiples columnas:**

```sql
CREATE TRIGGER employee_sensitive_update
ON employees
FOR UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Registrar cambios en columnas sensibles
    IF UPDATE(salary) OR UPDATE(ssn)
    BEGIN
        INSERT INTO employee_audit (employee_id, column_changed, old_value, new_value, changed_by, changed_date)
        SELECT 
            i.employee_id,
            CASE 
                WHEN i.salary <> d.salary THEN 'salary'
                WHEN i.ssn <> d.ssn THEN 'ssn'
            END,
            CASE 
                WHEN i.salary <> d.salary THEN CAST(d.salary AS VARCHAR)
                WHEN i.ssn <> d.ssn THEN d.ssn
            END,
            CASE 
                WHEN i.salary <> d.salary THEN CAST(i.salary AS VARCHAR)
                WHEN i.ssn <> d.ssn THEN i.ssn
            END,
            SYSTEM_USER,
            GETDATE()
        FROM inserted i
        INNER JOIN deleted d ON i.employee_id = d.employee_id
        WHERE i.salary <> d.salary OR i.ssn <> d.ssn;
    END
END
GO
```

### Función COLUMNS_UPDATED()

`COLUMNS_UPDATED()` retorna un patrón de bits (bitmask) que indica qué columnas fueron actualizadas.

**Uso avanzado para múltiples columnas:**

```sql
CREATE TRIGGER product_update
ON products
FOR UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Verificar si columnas de precio o inventario fueron actualizadas
    -- Bitmask: price es columna 3, stock es columna 5
    IF (COLUMNS_UPDATED() & 20) > 0  -- 20 = 10100 en binario (columnas 3 y 5)
    BEGIN
        -- Registrar cambio de precio o inventario
        INSERT INTO price_history (product_id, old_price, new_price, change_date)
        SELECT i.product_id, d.price, i.price, GETDATE()
        FROM inserted i
        INNER JOIN deleted d ON i.product_id = d.product_id
        WHERE i.price <> d.price;
    END
END
GO
```

---

## 8. Triggers INSTEAD OF

### Características

Los triggers `INSTEAD OF` se ejecutan **en lugar de** la operación DML original. La instrucción `INSERT`, `UPDATE` o `DELETE` **no se ejecuta**; el trigger debe implementar toda la lógica.

**Diferencias con AFTER:**

| Característica | AFTER Trigger | INSTEAD OF Trigger |
|----------------|---------------|--------------------|
| **Momento de ejecución** | Después de la operación DML | En lugar de la operación DML |
| **Operación original** | Se ejecuta | NO se ejecuta |
| **Aplicable a** | Solo tablas | Tablas y vistas |
| **Cantidad por evento** | Múltiples permitidos | Solo uno por evento |
| **Uso principal** | Auditoría, cascadas | Vistas actualizables, lógica personalizada |

### Restricciones de INSTEAD OF

1. Solo puede haber **un trigger INSTEAD OF** por cada acción (INSERT, UPDATE, DELETE) en una tabla o vista
2. **No se pueden combinar** con claves foráneas definidas con `CASCADE`
3. **No pueden ser recursivos** directos
4. Fueron diseñados principalmente para trabajar con **vistas**

### Ejemplo: Vista que Une Múltiples Tablas

**Escenario:** Permitir eliminar datos de una vista que une dos tablas, y que el DELETE afecte ambas tablas base.

**Tablas base:**

```sql
CREATE TABLE tabla_1 (
    a INT PRIMARY KEY,
    b VARCHAR(50),
    c VARCHAR(50)
);

CREATE TABLE tabla_2 (
    a INT PRIMARY KEY,
    message VARCHAR(100)
);
```

**Vista que une ambas tablas:**

```sql
CREATE VIEW vista_union AS
SELECT 
    tabla_1.a AS a1, 
    b, 
    c,
    tabla_2.a AS a2, 
    message
FROM tabla_1 
INNER JOIN tabla_2 ON tabla_1.a = tabla_2.a;
```

**Problema:** Las vistas que unen múltiples tablas **no son actualizables directamente**. Un `DELETE` sobre la vista generaría error.

**Solución:** Crear un trigger `INSTEAD OF DELETE`

```sql
CREATE TRIGGER DEL_union
ON vista_union
INSTEAD OF DELETE
AS 
BEGIN
    SET NOCOUNT ON;
    
    -- Eliminar de tabla_1
    DELETE FROM tabla_1 
    WHERE tabla_1.a IN (SELECT a1 FROM deleted);
    
    -- Eliminar de tabla_2
    DELETE FROM tabla_2 
    WHERE tabla_2.a IN (SELECT a2 FROM deleted);
    
    PRINT 'Filas eliminadas de ambas tablas base';
END
GO
```

**Ejecución:**

```sql
-- Ahora se puede eliminar desde la vista
DELETE FROM vista_union WHERE a1 = 100;

-- El trigger se ejecuta INSTEAD OF (en lugar de) el DELETE
-- Elimina de tabla_1 y tabla_2 automáticamente
```

### Ejemplo: Validación Compleja Antes de INSERT

```sql
CREATE TRIGGER customer_instead_insert
ON customers
INSTEAD OF INSERT
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Validar que el email no esté duplicado (case-insensitive)
    IF EXISTS (
        SELECT 1 
        FROM customers c
        INNER JOIN inserted i ON LOWER(c.email) = LOWER(i.email)
    )
    BEGIN
        RAISERROR ('Email already exists in the system.', 16, 1);
        RETURN;
    END
    
    -- Validar formato de teléfono
    IF EXISTS (
        SELECT 1 FROM inserted 
        WHERE phone NOT LIKE '[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]'
    )
    BEGIN
        RAISERROR ('Phone format must be XXX-XXXX', 16, 1);
        RETURN;
    END
    
    -- Si todas las validaciones pasan, ejecutar el INSERT
    INSERT INTO customers (customer_id, name, email, phone, created_date)
    SELECT customer_id, name, email, phone, GETDATE()
    FROM inserted;
    
    PRINT 'Customer inserted successfully';
END
GO
```

---

## 9. Ejemplos Prácticos

### Ejemplo 1: Forzar Integridad de Datos - Eliminar Reservas al Prestar

**Escenario:** En un sistema de biblioteca, cuando un libro es prestado, eliminar automáticamente las reservas de ese libro para ese miembro.

**Tablas:**

```sql
CREATE TABLE reservation (
    isbn VARCHAR(20),
    member_no INT,
    log_date DATE,
    remarks VARCHAR(200),
    PRIMARY KEY (isbn, member_no)
);

CREATE TABLE loan (
    loan_id INT IDENTITY PRIMARY KEY,
    isbn VARCHAR(20),
    copy_no INT,
    member_no INT,
    out_date DATE,
    due_date DATE
);
```

**Trigger:**

```sql
CREATE TRIGGER reservation_delete
ON loan 
FOR INSERT
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Verificar si hay reservas del miembro para el libro prestado
    IF EXISTS (
        SELECT 1 
        FROM reservation r 
        INNER JOIN inserted i 
            ON r.member_no = i.member_no 
            AND r.isbn = i.isbn
    )
    BEGIN
        -- Eliminar la reserva automáticamente
        DELETE r 
        FROM reservation r 
        INNER JOIN inserted i 
            ON r.member_no = i.member_no 
            AND r.isbn = i.isbn;
        
        PRINT 'Reservation deleted automatically';
    END
END
GO
```

**Prueba:**

```sql
-- Estado inicial
SELECT * FROM reservation;
-- Resultado:
-- isbn | member_no | log_date   | remarks
-- 1    | 1         | 2025-07-14 | ~~~
-- 1    | 2         | 2025-07-12 | ~~~
-- 4    | 7         | 2025-07-14 | ~~~

-- Prestar un libro que tiene reserva
INSERT INTO loan (isbn, copy_no, member_no, out_date, due_date)
VALUES ('1', 1, 1, GETDATE(), DATEADD(DAY, 14, GETDATE()));

-- Resultado del trigger: Reservation deleted automatically

-- Verificar reservas después del préstamo
SELECT * FROM reservation;
-- Resultado:
-- isbn | member_no | log_date   | remarks
-- 1    | 2         | 2025-07-12 | ~~~ (la reserva de member_no=1 se eliminó)
-- 4    | 7         | 2025-07-14 | ~~~
```

### Ejemplo 2: Auditoría Completa de Cambios

```sql
CREATE TABLE employees_audit (
    audit_id INT IDENTITY PRIMARY KEY,
    employee_id INT,
    action_type VARCHAR(10),  -- INSERT, UPDATE, DELETE
    old_data NVARCHAR(MAX),
    new_data NVARCHAR(MAX),
    changed_by VARCHAR(100),
    changed_date DATETIME
);
GO

CREATE TRIGGER employees_audit_trigger
ON employees
FOR INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;
    
    -- INSERT
    IF EXISTS (SELECT 1 FROM inserted) AND NOT EXISTS (SELECT 1 FROM deleted)
    BEGIN
        INSERT INTO employees_audit (employee_id, action_type, new_data, changed_by, changed_date)
        SELECT 
            employee_id,
            'INSERT',
            (SELECT i.* FOR JSON PATH, WITHOUT_ARRAY_WRAPPER) AS new_data,
            SYSTEM_USER,
            GETDATE()
        FROM inserted i;
    END
    
    -- UPDATE
    IF EXISTS (SELECT 1 FROM inserted) AND EXISTS (SELECT 1 FROM deleted)
    BEGIN
        INSERT INTO employees_audit (employee_id, action_type, old_data, new_data, changed_by, changed_date)
        SELECT 
            i.employee_id,
            'UPDATE',
            (SELECT d.* FOR JSON PATH, WITHOUT_ARRAY_WRAPPER) AS old_data,
            (SELECT i.* FOR JSON PATH, WITHOUT_ARRAY_WRAPPER) AS new_data,
            SYSTEM_USER,
            GETDATE()
        FROM inserted i
        INNER JOIN deleted d ON i.employee_id = d.employee_id;
    END
    
    -- DELETE
    IF NOT EXISTS (SELECT 1 FROM inserted) AND EXISTS (SELECT 1 FROM deleted)
    BEGIN
        INSERT INTO employees_audit (employee_id, action_type, old_data, changed_by, changed_date)
        SELECT 
            employee_id,
            'DELETE',
            (SELECT d.* FOR JSON PATH, WITHOUT_ARRAY_WRAPPER) AS old_data,
            SYSTEM_USER,
            GETDATE()
        FROM deleted d;
    END
END
GO
```

### Ejemplo 3: Validar Reglas de Negocio Complejas

**Escenario:** Un empleado no puede tener más de 3 proyectos asignados simultáneamente.

```sql
CREATE TRIGGER project_assignment_limit
ON employee_projects
FOR INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Contar proyectos activos por empleado
    IF EXISTS (
        SELECT employee_id
        FROM (
            SELECT employee_id, COUNT(*) AS project_count
            FROM employee_projects ep
            WHERE ep.status = 'Active'
            GROUP BY employee_id
        ) AS counts
        WHERE project_count > 3
    )
    BEGIN
        RAISERROR ('An employee cannot be assigned to more than 3 active projects.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END
GO
```

### Ejemplo 4: Actualización en Cascada de Totales

**Escenario:** Actualizar automáticamente el total de una orden cuando se insertan, actualizan o eliminan detalles.

```sql
CREATE TRIGGER order_details_update_total
ON order_details
FOR INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Actualizar total de órdenes afectadas
    UPDATE o
    SET total_amount = (
        SELECT ISNULL(SUM(quantity * unit_price), 0)
        FROM order_details
        WHERE order_id = o.order_id
    )
    FROM orders o
    WHERE o.order_id IN (
        SELECT DISTINCT order_id FROM inserted
        UNION
        SELECT DISTINCT order_id FROM deleted
    );
END
GO
```

---

## 10. Consideraciones de Performance

### Factores que Afectan el Rendimiento

Los triggers trabajan rápidamente porque las tablas `inserted` y `deleted` están en **caché de memoria**.

**El tiempo de ejecución está determinado por:**

1. **Número de tablas referenciadas**
   - Más JOINs = mayor tiempo de ejecución
   - Preferir índices en columnas usadas en JOINs

2. **Número de filas afectadas**
   - Los triggers se ejecutan una vez por **transacción**, no por fila
   - Deben estar diseñados para procesar **conjuntos de filas**, no fila por fila

3. **Complejidad de la lógica**
   - Evitar lógica innecesariamente compleja
   - Usar EXISTS en lugar de COUNT(*) cuando sea posible

4. **Transacciones implícitas**
   - Las acciones del trigger son parte de la transacción que lo invocó
   - Un ROLLBACK en el trigger deshace todo (incluida la operación original)

### Mejores Prácticas de Performance

#### 1. Procesar Conjuntos, No Filas Individuales

**❌ Incorrecto (cursor fila por fila):**

```sql
CREATE TRIGGER slow_trigger
ON sales
FOR INSERT
AS
BEGIN
    DECLARE @sale_id INT;
    
    DECLARE cur CURSOR FOR 
    SELECT sale_id FROM inserted;
    
    OPEN cur;
    FETCH NEXT FROM cur INTO @sale_id;
    
    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- Procesar una fila a la vez (LENTO)
        UPDATE inventory SET stock = stock - 1 WHERE product_id = (SELECT product_id FROM inserted WHERE sale_id = @sale_id);
        
        FETCH NEXT FROM cur INTO @sale_id;
    END
    
    CLOSE cur;
    DEALLOCATE cur;
END
GO
```

**✅ Correcto (operación de conjunto):**

```sql
CREATE TRIGGER fast_trigger
ON sales
FOR INSERT
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Procesar todas las filas en una operación (RÁPIDO)
    UPDATE inv
    SET stock = stock - i.quantity
    FROM inventory inv
    INNER JOIN inserted i ON inv.product_id = i.product_id;
END
GO
```

#### 2. Usar Índices Apropiados

```sql
-- Crear índices en columnas usadas frecuentemente en JOINs de triggers
CREATE INDEX IX_copy_isbn_copyno ON copy (isbn, copy_no);
CREATE INDEX IX_loan_memberno ON loan (member_no);
```

#### 3. Minimizar Lógica Compleja

```sql
-- ✅ Bueno: Lógica simple y directa
CREATE TRIGGER simple_trigger
ON orders
FOR INSERT
AS
BEGIN
    SET NOCOUNT ON;
    
    UPDATE customers
    SET last_order_date = GETDATE()
    FROM customers c
    INNER JOIN inserted i ON c.customer_id = i.customer_id;
END
GO

-- ❌ Evitar: Lógica compleja innecesaria
CREATE TRIGGER complex_trigger
ON orders
FOR INSERT
AS
BEGIN
    -- Evitar subconsultas complejas, múltiples CTEs, etc.
    -- cuando se puede lograr con operaciones simples
END
GO
```

#### 4. Usar EXISTS en Lugar de COUNT

```sql
-- ❌ Menos eficiente
IF (SELECT COUNT(*) FROM loan WHERE member_no IN (SELECT member_no FROM deleted)) > 0

-- ✅ Más eficiente
IF EXISTS (SELECT 1 FROM loan l INNER JOIN deleted d ON l.member_no = d.member_no)
```

### Monitoreo de Performance

```sql
-- Ver triggers en una tabla
SELECT 
    t.name AS trigger_name,
    OBJECT_NAME(t.parent_id) AS table_name,
    t.is_disabled,
    t.is_instead_of_trigger
FROM sys.triggers t
WHERE OBJECT_NAME(t.parent_id) = 'table_name';

-- Ver texto del trigger
EXEC sp_helptext 'trigger_name';

-- Estadísticas de ejecución de triggers
SELECT 
    OBJECT_NAME(object_id) AS trigger_name,
    execution_count,
    total_elapsed_time / 1000000.0 AS total_seconds,
    (total_elapsed_time / execution_count) / 1000000.0 AS avg_seconds
FROM sys.dm_exec_trigger_stats
ORDER BY total_elapsed_time DESC;
```

---

## 11. Modificación y Eliminación

### Alterar un Trigger (ALTER TRIGGER)

`ALTER TRIGGER` cambia la definición de un trigger sin eliminarlo, lo que **preserva los permisos**.

**Sintaxis:**

```sql
ALTER TRIGGER trigger_name
ON table_name
FOR INSERT | UPDATE | DELETE
AS
BEGIN
    -- Nueva definición del trigger
END
GO
```

**Ejemplo:**

```sql
-- Modificar el trigger loan_insert para agregar validación
ALTER TRIGGER loan_insert
ON loan
FOR INSERT
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Nueva validación: verificar que la copia esté disponible
    IF EXISTS (
        SELECT 1 
        FROM copy c
        INNER JOIN inserted i ON c.isbn = i.isbn AND c.copy_no = i.copy_no
        WHERE c.on_loan = 'Y'
    )
    BEGIN
        RAISERROR ('This copy is already on loan.', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END
    
    -- Código original: marcar como prestado
    UPDATE c 
    SET on_loan = 'Y'
    FROM copy c 
    INNER JOIN inserted i
        ON c.isbn = i.isbn 
        AND c.copy_no = i.copy_no;
END
GO
```

### Deshabilitar y Habilitar Triggers

A veces es necesario deshabilitar temporalmente un trigger (por ejemplo, durante una carga masiva de datos).

**Deshabilitar un trigger específico:**

```sql
DISABLE TRIGGER loan_insert ON loan;
```

**Deshabilitar todos los triggers de una tabla:**

```sql
DISABLE TRIGGER ALL ON loan;
```

**Habilitar un trigger:**

```sql
ENABLE TRIGGER loan_insert ON loan;
```

**Habilitar todos los triggers:**

```sql
ENABLE TRIGGER ALL ON loan;
```

**Verificar estado:**

```sql
SELECT 
    name AS trigger_name,
    is_disabled
FROM sys.triggers
WHERE parent_id = OBJECT_ID('loan');
```

### Eliminar un Trigger (DROP TRIGGER)

**Sintaxis:**

```sql
DROP TRIGGER trigger_name;
```

**Eliminar múltiples triggers:**

```sql
DROP TRIGGER trigger1, trigger2, trigger3;
```

**Eliminar solo si existe:**

```sql
DROP TRIGGER IF EXISTS loan_insert;  -- SQL Server 2016+
```

**Patrón compatible con versiones anteriores:**

```sql
IF OBJECT_ID('loan_insert', 'TR') IS NOT NULL
    DROP TRIGGER loan_insert;
GO
```

---

## 12. Mejores Prácticas

### 1. Usar Triggers Solo Cuando Sea Necesario

**Preferir alternativas cuando sea posible:**

- **Constraints** para integridad referencial simple (PRIMARY KEY, FOREIGN KEY, CHECK, UNIQUE)
- **Valores por defecto** (DEFAULT) para asignar valores automáticos
- **Columnas calculadas** para derivaciones simples
- **Procedimientos almacenados** para lógica de negocio compleja que no necesita ser automática

**Usar triggers cuando:**

- Se requiere auditoría automática
- Se necesitan cascadas complejas no soportadas por FOREIGN KEY CASCADE
- Se deben validar reglas de negocio que involucran múltiples tablas
- Se requiere lógica que debe ejecutarse siempre, sin importar cómo se modifiquen los datos

### 2. Diseñar para Conjuntos, No para Filas

```sql
-- ❌ Incorrecto: Asumir una sola fila
CREATE TRIGGER bad_trigger
ON sales
FOR INSERT
AS
BEGIN
    DECLARE @product_id INT;
    SELECT @product_id = product_id FROM inserted;  -- ¡Solo toma una fila!
    
    UPDATE inventory SET stock = stock - 1 WHERE product_id = @product_id;
END
GO

-- ✅ Correcto: Procesar conjunto completo
CREATE TRIGGER good_trigger
ON sales
FOR INSERT
AS
BEGIN
    SET NOCOUNT ON;
    
    UPDATE inv
    SET stock = stock - i.quantity
    FROM inventory inv
    INNER JOIN inserted i ON inv.product_id = i.product_id;
END
GO
```

### 3. Usar SET NOCOUNT ON

```sql
CREATE TRIGGER efficient_trigger
ON table_name
FOR INSERT
AS
BEGIN
    SET NOCOUNT ON;  -- Evita mensajes de "X rows affected"
    
    -- Código del trigger
END
GO
```

### 4. Manejar Errores Apropiadamente

```sql
CREATE TRIGGER safe_trigger
ON critical_table
FOR UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        -- Lógica del trigger
        
        IF (condición_error)
        BEGIN
            RAISERROR ('Error message', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END
        
    END TRY
    BEGIN CATCH
        -- Registrar error
        INSERT INTO error_log (error_message, error_date)
        VALUES (ERROR_MESSAGE(), GETDATE());
        
        ROLLBACK TRANSACTION;
        THROW;  -- Re-lanzar el error
    END CATCH
END
GO
```

### 5. Documentar los Triggers

```sql
/*
===========================================================================
Trigger:      loan_insert
Tabla:        loan
Evento:       FOR INSERT
Descripción:  Marca automáticamente una copia de libro como "prestada" 
              cuando se registra un nuevo préstamo.
Tablas afectadas: copy
Autor:        [Nombre]
Fecha:        2025-12-01
Modificado:   2025-12-05 - Agregada validación de disponibilidad
===========================================================================
*/
CREATE TRIGGER loan_insert
ON loan
FOR INSERT
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Código del trigger
END
GO
```

### 6. Evitar Triggers Recursivos

**Problema:** Un trigger puede activarse a sí mismo indirectamente.

```sql
-- Configuración a nivel de base de datos
ALTER DATABASE library SET RECURSIVE_TRIGGERS OFF;

-- Verificar configuración
SELECT is_recursive_triggers_on 
FROM sys.databases 
WHERE name = 'library';
```

### 7. Validar Existencia de Datos en INSERTED/DELETED

```sql
CREATE TRIGGER comprehensive_audit
ON employees
FOR INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Detectar tipo de operación verificando contenido de tablas especiales
    DECLARE @action VARCHAR(10);
    
    IF EXISTS (SELECT 1 FROM inserted) AND EXISTS (SELECT 1 FROM deleted)
        SET @action = 'UPDATE';
    ELSE IF EXISTS (SELECT 1 FROM inserted)
        SET @action = 'INSERT';
    ELSE IF EXISTS (SELECT 1 FROM deleted)
        SET @action = 'DELETE';
    ELSE
        RETURN;  -- No hay cambios (no debería ocurrir)
    
    -- Procesar según el tipo de acción
    -- ...
END
GO
```

### 8. Limitar Uso de WITH ENCRYPTION

**Ventajas:**
- Protege código propietario

**Desventajas:**
- Dificulta mantenimiento y debugging
- No se puede recuperar el código una vez encriptado

```sql
-- Solo usar cuando sea estrictamente necesario
CREATE TRIGGER sensitive_trigger
ON financial_data
WITH ENCRYPTION
FOR UPDATE
AS
BEGIN
    -- Código propietario sensible
END
GO
```

---

## 13. Ejercicios

### Ejercicio 1: Trigger de Auditoría Básica

**Objetivo:** Crear un trigger que registre todas las eliminaciones de la tabla `products`.

**Instrucciones:**

1. Crear tabla de auditoría:
```sql
CREATE TABLE products_audit (
    audit_id INT IDENTITY PRIMARY KEY,
    product_id INT,
    product_name VARCHAR(100),
    deleted_by VARCHAR(100),
    deleted_date DATETIME
);
```

2. Crear trigger que registre eliminaciones en `products_audit`.

**Solución:**

```sql
CREATE TRIGGER products_delete_audit
ON products
FOR DELETE
AS
BEGIN
    SET NOCOUNT ON;
    
    INSERT INTO products_audit (product_id, product_name, deleted_by, deleted_date)
    SELECT 
        product_id, 
        product_name, 
        SYSTEM_USER, 
        GETDATE()
    FROM deleted;
END
GO
```

### Ejercicio 2: Validar Stock Antes de Venta

**Objetivo:** Crear un trigger que impida ventas si el producto no tiene stock suficiente.

**Tablas:**

```sql
CREATE TABLE sales (
    sale_id INT IDENTITY PRIMARY KEY,
    product_id INT,
    quantity INT,
    sale_date DATE
);

CREATE TABLE inventory (
    product_id INT PRIMARY KEY,
    stock INT
);
```

**Instrucciones:** Crear trigger que valide stock y revierta transacción si es insuficiente.

**Solución:**

```sql
CREATE TRIGGER sales_stock_validation
ON sales
FOR INSERT
AS
BEGIN
    SET NOCOUNT ON;
    
    IF EXISTS (
        SELECT 1
        FROM inserted i
        INNER JOIN inventory inv ON i.product_id = inv.product_id
        WHERE inv.stock < i.quantity
    )
    BEGIN
        RAISERROR ('Insufficient stock for one or more products.', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END
    
    -- Actualizar stock
    UPDATE inv
    SET stock = stock - i.quantity
    FROM inventory inv
    INNER JOIN inserted i ON inv.product_id = i.product_id;
END
GO
```

### Ejercicio 3: Trigger INSTEAD OF para Vista

**Objetivo:** Crear una vista que une `customers` y `orders`, y un trigger INSTEAD OF que permita eliminar desde la vista.

**Solución:**

```sql
-- Vista
CREATE VIEW customer_orders AS
SELECT 
    c.customer_id,
    c.customer_name,
    o.order_id,
    o.order_date,
    o.total
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id;
GO

-- Trigger INSTEAD OF DELETE
CREATE TRIGGER delete_customer_orders
ON customer_orders
INSTEAD OF DELETE
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Eliminar órdenes asociadas
    DELETE FROM orders
    WHERE customer_id IN (SELECT customer_id FROM deleted);
    
    -- Eliminar clientes
    DELETE FROM customers
    WHERE customer_id IN (SELECT customer_id FROM deleted);
    
    PRINT 'Customer and associated orders deleted';
END
GO
```

---

## Resumen

Los **triggers** son herramientas poderosas para:

- ✅ Garantizar integridad de datos compleja
- ✅ Auditoría automática de cambios
- ✅ Actualizar datos relacionados en cascada
- ✅ Validar reglas de negocio que involucran múltiples tablas
- ✅ Hacer vistas actualizables mediante INSTEAD OF

**Recordar:**

- Preferir constraints cuando sea posible
- Diseñar para conjuntos de filas, no filas individuales
- Usar SET NOCOUNT ON
- Documentar claramente
- Monitorear performance
- Probar exhaustivamente antes de implementar en producción

---

## Referencias

- [Microsoft Docs: CREATE TRIGGER](https://learn.microsoft.com/en-us/sql/t-sql/statements/create-trigger-transact-sql)
- [Microsoft Docs: Triggers DML](https://learn.microsoft.com/en-us/sql/relational-databases/triggers/dml-triggers)
- [Microsoft Docs: INSTEAD OF Triggers](https://learn.microsoft.com/en-us/sql/relational-databases/triggers/use-the-inserted-and-deleted-tables)
