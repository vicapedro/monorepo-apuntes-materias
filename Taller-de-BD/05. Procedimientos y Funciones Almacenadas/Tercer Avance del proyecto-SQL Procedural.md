# Tercer Avance del Proyecto: SQL Procedural

## Objetivo

Implementar lógica de negocio compleja mediante procedimientos almacenados y triggers en SQL Server, aplicando los conceptos de SQL procedural para automatizar procesos y garantizar la integridad del sistema de base de datos del proyecto.

**Duración estimada:** 3 semanas

---

## Competencias a desarrollar

- Diseña e implementa procedimientos almacenados no triviales que automatizan procesos de negocio complejos
- Utiliza transacciones para garantizar la atomicidad de operaciones críticas
- Aplica cursores para procesamiento iterativo cuando sea necesario
- Implementa triggers para enforcing de reglas de negocio que no pueden resolverse con DDL
- Maneja excepciones y errores de forma robusta en código T-SQL

---

## Contexto

En los avances anteriores del proyecto:

1. **Primer avance**: Diseñaron el modelo Entidad-Relación y lo transformaron al modelo relacional
2. **Segundo avance**: Implementaron consultas SQL para resolver las necesidades de información del sistema
3. **Análisis de reglas de negocio**: Identificaron y documentaron en lenguaje natural las reglas de negocio y propusieron 7 triggers candidatos

En este tercer avance, implementarán la **lógica procedural** que automatiza procesos y garantiza el cumplimiento de las reglas de negocio mediante:
- **Procedimientos almacenados** que encapsulan operaciones complejas
- **Triggers** que validan y mantienen la integridad de datos

---

## Parte A: Procedimientos Almacenados (60%)

### Análisis de casos de uso

Analice su proyecto e identifique los **casos de uso más relevantes** que se benefician de encapsulación mediante procedimientos almacenados.

**Nota importante**: ¡Se podría diseñar una aplicación completa usando solamente stored procedures como capa de acceso a datos! Los procedimientos almacenados modernos reemplazan consultas ad-hoc y proveen una interfaz estable entre la aplicación y la base de datos.

### Requisitos

Diseñe e implemente **al menos 3 procedimientos almacenados** que cumplan con:

#### 1. Complejidad y valor agregado
- **No triviales**: Un SP que solo inserta una fila con valores directos es trivial
- **Agregan valor real**: Deben resolver procesos de negocio complejos que involucran:
  - Validaciones de múltiples reglas de negocio
  - Operaciones sobre múltiples tablas relacionadas
  - Cálculos o transformaciones de datos
  - Generación de reportes complejos
  - Ejecución de flujos de trabajo (workflows)

**Ejemplos de procedimientos valiosos**:
- Procesar una venta completa (actualizar inventario, registrar pago, generar factura, aplicar descuentos)
- Cerrar período contable (validaciones, cálculos, generación de reportes, bloqueos)
- Generar nómina (cálculo de prestaciones, deducciones, timbrado)
- Registrar préstamo de biblioteca (validar disponibilidad, cuotas, sanciones, fechas)

**Ejemplos de procedimientos triviales (evitar)**:
```sql
-- ❌ TRIVIAL - Solo inserta valores directos
CREATE PROCEDURE usp_InsertarCliente
    @Nombre NVARCHAR(100),
    @Email NVARCHAR(100)
AS
BEGIN
    INSERT INTO Clientes (Nombre, Email)
    VALUES (@Nombre, @Email);
END;
```

#### 2. Uso de transacciones
- **Obligatorio**: Al menos 2 de los 3 procedimientos deben incluir transacciones explícitas
- Garanticen atomicidad de operaciones relacionadas (todo o nada)
- Implementen manejo de errores con TRY...CATCH
- Ejecuten ROLLBACK en caso de error y COMMIT en caso de éxito

**Ejemplo de estructura requerida**:
```sql
CREATE PROCEDURE usp_ProcesarVenta
    @ClienteID INT,
    @ProductosXML XML,
    @TotalVenta DECIMAL(10,2) OUTPUT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Validaciones de negocio
        -- Operaciones sobre múltiples tablas
        -- Cálculos y actualizaciones
        
        COMMIT TRANSACTION;
        RETURN 0; -- Éxito
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        
        -- Manejo de error
        THROW;
        RETURN -1; -- Error
    END CATCH
END;
```

#### 3. Uso de cursores
- **Obligatorio**: Al menos 1 de los 3 procedimientos debe incluir un cursor
- Justifique técnicamente por qué el cursor es necesario (procesamiento iterativo no replicable con operaciones basadas en conjuntos)
- Implemente el cursor de forma eficiente (FAST_FORWARD cuando sea posible)
- Cierre y desasigne correctamente el cursor

**Casos válidos para cursores**:
- Procesamiento fila por fila con lógica condicional compleja que varía por registro
- Ejecución de comandos dinámicos basados en datos de cada fila
- Generación de reportes con formato específico línea por línea
- Actualización de registros con cálculos que dependen del resultado de filas anteriores

**Nota**: Si puede resolver el problema con operaciones de conjunto (JOIN, GROUP BY, CTEs, etc.), **no use cursor**. Los cursores son el último recurso.

---

## Parte B: Triggers (40%)

### Contexto previo

En el análisis anterior, usted identificó y documentó en lenguaje natural **7 reglas de negocio** candidatas para implementarse mediante triggers. También diseñó la estructura de cada trigger propuesto.

### Requisitos

De los 7 triggers propuestos anteriormente, **seleccione e implemente 3** que cumplan con:

#### 1. Implementación de reglas de negocio complejas
- Deben implementar reglas que **no pueden resolverse con DDL estándar** (constraints, defaults, checks)
- Deben agregar valor real al sistema mediante validaciones o automatizaciones complejas

**Ejemplos de triggers válidos**:
- Validar stock disponible considerando reservas y pedidos pendientes
- Aplicar descuentos automáticos basados en reglas de temporada y volumen acumulado
- Registrar auditoría completa con usuario, fecha, valores anteriores y nuevos
- Actualizar estadísticas agregadas en tablas denormalizadas
- Enforcing de reglas de negocio con lógica condicional compleja

**Ejemplos de triggers triviales o inválidos (evitar)**:
```sql
-- ❌ TRIVIAL - Esto debería ser un CHECK constraint
CREATE TRIGGER trg_ValidarPrecio
ON Productos
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS (SELECT 1 FROM inserted WHERE Precio < 0)
    BEGIN
        RAISERROR('El precio no puede ser negativo', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;

-- ❌ INVÁLIDO - Esto debería ser un FOREIGN KEY constraint
CREATE TRIGGER trg_ValidarCliente
ON Ventas
AFTER INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1 FROM inserted i
        WHERE NOT EXISTS (SELECT 1 FROM Clientes WHERE ClienteID = i.ClienteID)
    )
    BEGIN
        RAISERROR('Cliente no existe', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;
```

#### 2. No duplicar funcionalidad de constraints o permisos
- **Un trigger NO debe hacer el trabajo de**:
  - CHECK constraints (validaciones simples de valores)
  - FOREIGN KEY constraints (integridad referencial básica)
  - UNIQUE constraints (unicidad de valores)
  - NOT NULL constraints (valores requeridos)
  - DEFAULT constraints (valores por defecto)
  - Permisos GRANT/DENY (seguridad de acceso)

#### 3. Justificación técnica
Para cada uno de los 3 triggers implementados, documente:
- **Regla de negocio** que implementa (breve, puede referenciar el análisis previo)
- **Por qué no puede resolverse con DDL**: Justificación técnica de por qué requiere un trigger
- **Tipo de trigger**: AFTER/INSTEAD OF, INSERT/UPDATE/DELETE
- **Tablas affected**: Cuáles tablas se modifican o consultan

---

## Entregables

### 1. Script SQL completo (`3er-Avance-Proyecto-[NombreProyecto].sql`)

Archivo SQL ejecutable que contenga:

```sql
-- =====================================================
-- TERCER AVANCE DEL PROYECTO: SQL PROCEDURAL
-- Proyecto: [Nombre del Proyecto]
-- Integrantes: [Nombres]
-- Fecha: [Fecha]
-- =====================================================

USE [NombreBaseDatos];
GO

-- =====================================================
-- PARTE A: PROCEDIMIENTOS ALMACENADOS
-- =====================================================

-- -----------------------------------------------------
-- Procedimiento 1: [Nombre descriptivo]
-- Descripción: [Qué hace y por qué es valioso]
-- Usa transacciones: [Sí/No]
-- Usa cursores: [Sí/No]
-- -----------------------------------------------------
CREATE OR ALTER PROCEDURE [Nombre]
    @Param1 TIPO,
    @ParamOutput TIPO OUTPUT
AS
BEGIN
    -- Documentar lógica compleja con comentarios
    -- Implementación completa
END;
GO

-- Ejemplo de uso del Procedimiento 1
-- [Incluir ejemplo de ejecución con datos realistas]
EXEC [Nombre] @Param1 = valor, @ParamOutput = @variable OUTPUT;
GO

-- [Repetir para Procedimientos 2 y 3]

-- =====================================================
-- PARTE B: TRIGGERS
-- =====================================================

-- -----------------------------------------------------
-- Trigger 1: [Nombre descriptivo]
-- Regla de negocio: [Breve descripción o referencia al análisis previo]
-- Justificación: [Por qué requiere trigger y no DDL]
-- Tipo: [AFTER/INSTEAD OF] [INSERT/UPDATE/DELETE]
-- -----------------------------------------------------
CREATE OR ALTER TRIGGER [Nombre]
ON [Tabla]
[AFTER/INSTEAD OF] [INSERT/UPDATE/DELETE]
AS
BEGIN
    SET NOCOUNT ON;
    -- Implementación completa
END;
GO

-- [Repetir para Triggers 2 y 3]

-- =====================================================
-- PRUEBAS Y VALIDACIÓN
-- =====================================================

-- Incluir casos de prueba que demuestren:
-- 1. Funcionamiento exitoso de cada procedimiento
-- 2. Manejo de errores y rollback en transacciones
-- 3. Activación correcta de triggers
-- 4. Validación de reglas de negocio
```

### 2. Documento de análisis (`3er-Avance-Analisis-[NombreProyecto].md`)

Documento Markdown con:

#### Para cada procedimiento almacenado:
1. **Nombre y descripción funcional**
2. **Caso de uso que resuelve** (qué proceso de negocio automatiza)
3. **Justificación de complejidad** (por qué no es trivial)
4. **Diagrama de flujo** (opcional pero recomendado)
5. **Tablas involucradas**
6. **Parámetros de entrada y salida** con descripción
7. **Códigos de retorno** y su significado
8. **Manejo de errores** implementado

#### Para cada trigger (de los 3 seleccionados):
1. **Nombre y tipo**
2. **Regla de negocio** que implementa (referencia al análisis previo donde propuso los 7 triggers)
3. **Justificación técnica**: Por qué requiere trigger y no puede resolverse con:
   - CHECK constraint
   - FOREIGN KEY constraint
   - UNIQUE constraint
   - DEFAULT constraint
   - Permisos (GRANT/DENY)
4. **Tablas affected** (cuáles se consultan/modifican)
5. **Escenarios de activación** con ejemplos

#### Casos de prueba documentados:
- **Pruebas exitosas**: Demostrar funcionamiento correcto
- **Pruebas de error**: Demostrar manejo de excepciones y rollback
- **Pruebas de triggers**: Demostrar activación y validación de reglas

---

## Criterios de evaluación

### Procedimientos Almacenados (60 puntos)

| Criterio | Excelente (3) | Bueno (2) | Aceptable (1) | Insuficiente (0) |
|----------|---------------|-----------|---------------|------------------|
| **Complejidad y valor** (15 pts) | 3 SPs no triviales que resuelven procesos complejos multi-tabla con validaciones | 3 SPs con complejidad media, algunos aspectos triviales | 3 SPs con complejidad básica, mayormente triviales | SPs triviales (inserciones/actualizaciones simples) |
| **Uso de transacciones** (15 pts) | 2+ SPs con transacciones, TRY-CATCH completo, rollback/commit correctos | 2 SPs con transacciones básicas, manejo de errores incompleto | 1 SP con transacciones o manejo de errores deficiente | Sin transacciones o implementación incorrecta |
| **Uso de cursores** (10 pts) | 1+ cursor justificado técnicamente, implementado eficientemente (FAST_FORWARD), cerrado correctamente | Cursor funcional pero no optimizado o justificación débil | Cursor con problemas de implementación (no cerrado, no justificado) | Sin cursor o cursor innecesario (debería ser operación de conjunto) |
| **Código limpio y documentación** (10 pts) | Código bien estructurado, comentarios claros, nombres descriptivos | Código funcional con documentación básica | Código funcional pero mal documentado o nombres confusos | Código difícil de entender, sin comentarios |
| **Manejo de errores** (10 pts) | Validaciones completas, mensajes de error descriptivos, códigos de retorno | Manejo básico de errores principales | Manejo mínimo de errores, mensajes genéricos | Sin manejo de errores o inadecuado |

### Triggers (40 puntos)

| Criterio | Excelente (3) | Bueno (2) | Aceptable (1) | Insuficiente (0) |
|----------|---------------|-----------|---------------|------------------|
| **Validez técnica** (12 pts) | 3 triggers que implementan reglas NO replicables con DDL, bien justificados | 3 triggers válidos con justificación aceptable | Algunos triggers podrían ser constraints, justificación débil | Triggers triviales (deberían ser constraints o permisos) |
| **Implementación de reglas de negocio** (12 pts) | Reglas complejas correctamente implementadas, lógica robusta | Reglas implementadas con lógica funcional | Reglas básicas con implementación simple | Reglas triviales o implementación incorrecta |
| **Correctitud funcional** (8 pts) | Triggers funcionan correctamente en todos los escenarios (INSERT/UPDATE/DELETE según aplique) | Triggers funcionan en escenarios principales | Triggers con bugs menores o casos no cubiertos | Triggers con errores graves o no funcionan |
| **Documentación y justificación** (8 pts) | Justificación técnica clara de por qué no puede ser DDL, casos de uso bien documentados | Justificación aceptable, documentación básica | Justificación débil, documentación mínima | Sin justificación o documentación inadecuada |

---

## Notas importantes

### Sobre procedimientos almacenados:
- **No es válido** presentar 3 procedimientos que solo hacen INSERT/UPDATE/DELETE simples de una tabla
- **Es válido** un procedimiento de INSERT complejo si:
  - Valida múltiples reglas de negocio antes de insertar
  - Inserta en múltiples tablas relacionadas (transacción)
  - Realiza cálculos o transformaciones
  - Genera datos derivados automáticamente

### Sobre triggers:
- **Pregúntese siempre**: ¿Esto puede resolverse con un constraint CHECK, FOREIGN KEY, UNIQUE, DEFAULT o permiso?
- Si la respuesta es **SÍ** → **NO use trigger**
- Si la respuesta es **NO** porque requiere lógica compleja, consultas a otras tablas, o validaciones condicionales → **SÍ use trigger**
- **Recuerde**: Ya diseñó 7 triggers candidatos en el análisis previo. Ahora solo implemente en SQL los 3 más relevantes.

### Sobre cursores:
- **Úselos solo cuando sea estrictamente necesario**
- SQL Server está optimizado para operaciones basadas en conjuntos (SET-based)
- Si puede resolver con JOIN, GROUP BY, CTE, APPLY, etc. → **NO use cursor**
- Justifique técnicamente por qué el procesamiento fila por fila es inevitable

---

## Recursos de apoyo

- **Documentación de triggers**: Ver `Triggers.md` en esta carpeta (si existe)
- **Documentación de procedimientos**: Ver `Procedimientos-Almacenados.md`
- **Documentación de cursores**: Ver `Cursores.md`
- **Ejemplo completo**: Ver `Ejemplo-SP-Northwind-Completo.sql` (ilustra todos los mecanismos)
- **Análisis previo de reglas de negocio**: Revise su documentación del segundo avance sobre las 7 reglas propuestas

---

## Fechas importantes

- **Fecha de entrega**: [Definir según calendario del curso]
- **Formato de entrega**: Archivos en Moodle (carpeta comprimida .zip)
  - `3er-Avance-Proyecto-[NombreProyecto].sql`
  - `3er-Avance-Analisis-[NombreProyecto].md` o `.pdf`
- **Presentación**: [Si aplica] Demostración en vivo de los procedimientos y triggers funcionando

---

## Preguntas frecuentes

**P: ¿Puedo usar más de 3 procedimientos almacenados?**  
R: Sí, el mínimo son 3, pero puede entregar más si lo desea.

**P: ¿Todos los procedimientos deben tener transacciones?**  
R: Mínimo 2 de los 3. El tercero puede no requerirla si su naturaleza no involucra operaciones críticas multi-tabla.

**P: ¿Puedo implementar los 7 triggers en lugar de solo 3?**  
R: Sí, puede entregar los 7 si lo desea, pero solo se evaluarán 3 según los criterios de la rúbrica.

**P: ¿Los triggers deben ser exactamente los que propuse en el análisis anterior?**  
R: Puede modificarlos si descubre que algunos no son técnicamente válidos o si identifica mejores candidatos durante la implementación.

**P: ¿Qué pasa si no usé cursores en ningún procedimiento?**  
R: Perderá los 10 puntos correspondientes a ese criterio. Asegúrese de incluir al menos 1 cursor justificado.

**P: ¿Puedo usar SQL dinámico (EXEC, sp_executesql)?**  
R: Sí, pero con precaución. Documente por qué es necesario y tome medidas contra SQL injection.