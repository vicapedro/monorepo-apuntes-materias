# Transacciones en SQL Server

**Taller de Base de Datos - Control de Concurrencia**

---

## 1. ¿Qué es una Transacción de Mantenimiento (TM)?

### Transacciones Autocommit vs Transacciones Explícitas

Consideremos las siguientes sentencias SQL:

```sql
SELECT * FROM ci_uso_aulas;
INSERT INTO ci_uso_aulas VALUES(100, 20, 10);
UPDATE Control SET Atr1 = 0 WHERE Codigo = 10;
DELETE FROM Movtos WHERE Fecha > @Fecha_Dada;
```

**¿Es esto una transacción de mantenimiento?**

**No.** Aunque parecen formar una unidad lógica, en realidad representan **4 transacciones autocommit** (autocompletadas) independientes:

1. Transacción autocommit - SELECT
2. Transacción autocommit - INSERT
3. Transacción autocommit - UPDATE
4. Transacción autocommit - DELETE

Cada una de estas transacciones no requiere de nuestra intervención, el sistema se encarga de todo automáticamente.

### Definición de Transacción de Mantenimiento

**Una TM es un conjunto de operaciones (solicitudes) que van a ser tratadas como una única unidad indivisible.**

Para lograr esto, las operaciones deben agruparse en una **transacción explícita**.

---

## 2. Transacciones Explícitas

### Sintaxis Básica

Una transacción explícita se inicia con `BEGIN TRAN` y se termina explícitamente con `COMMIT` o `ROLLBACK TRAN`.

```sql
BEGIN TRAN
    SELECT * FROM ci_uso_aulas;
    INSERT INTO ci_uso_aulas VALUES(100, 20, 10);
    UPDATE Control SET Atr1 = 0 WHERE Codigo = 10;
    DELETE FROM Movtos WHERE Fecha > @Fecha_Dada;
COMMIT TRAN;
```

### Pregunta Crítica

**¿Qué sucede con la TM si una de las sentencias falla?**

**Opciones:**
1. La TM se aborta en su totalidad
2. La TM continúa con la ejecución de la siguiente sentencia

Mucha gente asume la opción 1, pero **nada más alejado de la realidad**.

---

## 3. Control de Errores en Transacciones

### Comportamiento por Defecto (Sin Control de Errores)

**SQL Server NO aborta automáticamente una transacción cuando una sentencia falla.** El control de atomicidad lo debe implementar el usuario.

**Ejemplo:**

```sql
BEGIN TRAN 
    UPDATE authors SET state = 'FL' WHERE state = 'KS';  -- ✓ Se ejecuta con éxito
    UPDATE jobs SET min_lvl = min_lvl - 10;              -- ✗ Falla (violación de CHECK constraint)
COMMIT TRAN;  -- ¡La transacción se compromete de todas formas!
```

**Resultado:**
- La primera actualización en `authors` **se realiza con éxito**
- La segunda actualización en `jobs` **fracasa** (por ejemplo, por un CHECK constraint)
- La transacción **se compromete** (COMMIT ejecuta)
- El cambio en `authors` queda permanente, aunque `jobs` falló

**Esto viola el principio de atomicidad.**

### Control Explícito de Errores con @@ERROR

Para garantizar atomicidad, debemos verificar errores manualmente:

```sql
BEGIN TRAN 
    UPDATE authors SET state = 'FL' WHERE state = 'KS';
    
    IF @@ERROR <> 0
    BEGIN 
        ROLLBACK TRAN;
        RETURN;
    END
    
    UPDATE jobs SET min_lvl = min_lvl - 10;
    
    IF @@ERROR <> 0
    BEGIN 
        ROLLBACK TRAN;
        RETURN;
    END
    
COMMIT TRAN;
```

**Funcionamiento:**
- Cuando SQL Server completa con éxito una instrucción T-SQL, establece `@@ERROR = 0`
- Si hay un error, `@@ERROR` contiene el código de error
- Verificamos después de cada operación crítica
- Si hay error, ejecutamos ROLLBACK y terminamos

---

## 4. Variables Globales en SQL Server

SQL Server proporciona variables globales que son muy efectivas para programación T-SQL.

### Características de Variables Globales

- **Nombres:** Comienzan con prefijo `@@`
- **Mantenimiento:** El servidor las mantiene constantemente
- **Declaración:** No necesitan ser declaradas (son funciones del sistema)
- **Alcance:** Representan información del servidor o de la sesión actual

### Variables Globales Importantes para Transacciones

#### @@TRANCOUNT
Regresa el nivel de anidamiento de las transacciones.
- Incrementa en 1 con cada `BEGIN TRAN`
- Decrementa en 1 con cada `COMMIT TRAN`
- Se establece en 0 con `ROLLBACK TRAN`

```sql
SELECT @@TRANCOUNT;  -- 0 (sin transacción activa)

BEGIN TRAN;
SELECT @@TRANCOUNT;  -- 1

    BEGIN TRAN;  -- Transacción anidada
    SELECT @@TRANCOUNT;  -- 2
    COMMIT TRAN;
    
SELECT @@TRANCOUNT;  -- 1
COMMIT TRAN;
SELECT @@TRANCOUNT;  -- 0
```

#### @@ROWCOUNT
Regresa el número de filas afectadas por el último comando.

```sql
UPDATE Productos SET Precio = Precio * 1.10 WHERE Categoria = 'A';
SELECT @@ROWCOUNT;  -- Número de productos actualizados
```

#### @@ERROR
Código de error del último comando ejecutado (0 si fue exitoso).

```sql
INSERT INTO Clientes(ClienteID, Nombre) VALUES(1, 'Juan');
IF @@ERROR <> 0
    PRINT 'Error al insertar cliente';
```

---

## 5. Propiedades ACID

Cada transacción debe garantizar cuatro propiedades fundamentales conocidas como **ACID**:

```
┌─────────────────────────┐
│   BD en estado          │
│   consistente           │
└───────────┬─────────────┘
            │
            ▼
     ┌──────────────┐
     │  Inicia TM   │
     └──────┬───────┘
            │
            ▼
  ┌──────────────────────┐
  │  Ejecución de TM     │
  │  (operaciones)       │
  └──────────┬───────────┘
            │
            ▼
     ┌──────────────┐
     │ Finaliza TM  │
     └──────┬───────┘
            │
            ▼
┌─────────────────────────┐
│   BD en nuevo estado    │
│   consistente           │
└─────────────────────────┘
```

### A - Atomicidad (Atomicity)

**Una transacción es indivisible: todas las operaciones se ejecutan o ninguna.**

- Si falla una operación, todas deben deshacerse (ROLLBACK)
- No puede quedar en estado intermedio

**Ejemplo:**
```sql
BEGIN TRAN
    -- Transferencia bancaria: debe ser atómica
    UPDATE Cuentas SET Saldo = Saldo - 1000 WHERE CuentaID = 101;  -- Débito
    UPDATE Cuentas SET Saldo = Saldo + 1000 WHERE CuentaID = 202;  -- Crédito
    
    IF @@ERROR <> 0
        ROLLBACK TRAN;  -- Ambas operaciones se deshacen
    ELSE
        COMMIT TRAN;    -- Ambas operaciones se confirman
```

### C - Consistencia (Consistency)

**Una transacción mantiene la consistencia de la base de datos.**

Si la BD está en estado consistente antes de la transacción, debe permanecer consistente después.

**Consistencia incluye:**
- Todos los valores de PRIMARY KEY son únicos
- Integridad referencial (FOREIGN KEYS válidas)
- Restricciones CHECK satisfechas
- Predicados de negocio cumplidos (ej: suma de gastos ≤ presupuesto)

**Ejemplo:**
```sql
BEGIN TRAN
    -- Insertar pedido y actualizar inventario
    INSERT INTO Pedidos(ClienteID, ProductoID, Cantidad) 
    VALUES(10, 5, 100);
    
    UPDATE Inventario 
    SET Existencias = Existencias - 100 
    WHERE ProductoID = 5;
    
    -- Validar que no quede inventario negativo
    IF EXISTS (SELECT 1 FROM Inventario WHERE Existencias < 0)
    BEGIN
        ROLLBACK TRAN;  -- Violación de regla de negocio
        RAISERROR('Inventario insuficiente', 16, 1);
    END
    ELSE
        COMMIT TRAN;
```

### I - Aislamiento (Isolation)

**Durante la ejecución, una transacción no debe revelar sus resultados a otras transacciones concurrentes antes de su compromiso.**

- Si varias transacciones se ejecutan concurrentemente, el resultado debe ser el mismo que si se hubieran ejecutado en forma secuencial (**Seriabilidad**)
- La seriabilidad asegura que los cambios siguen un orden adecuado

**Ejemplo de problema de aislamiento:**
```sql
-- Conexión 1
BEGIN TRAN
    UPDATE Productos SET Precio = Precio * 1.10 WHERE ProductoID = 5;
    -- Transacción AÚN NO terminada
    
-- Conexión 2 (sin aislamiento apropiado)
SELECT Precio FROM Productos WHERE ProductoID = 5;  
-- ¿Lee el precio antiguo o el nuevo (no confirmado)?
```

### D - Durabilidad (Durability)

**Una vez que una transacción realiza su compromiso (COMMIT), sus resultados son permanentes.**

- Los cambios sobrevivirán a fallas del sistema
- No pueden ser borrados de la base de datos (excepto por nuevas transacciones)

**Implementación:**
- SQL Server escribe al **transaction log** antes de confirmar
- El log garantiza recuperación ante fallos (crash recovery)

```sql
BEGIN TRAN
    UPDATE Clientes SET Estatus = 'Activo' WHERE ClienteID = 100;
COMMIT TRAN;  -- Los cambios ahora son PERMANENTES

-- Incluso si el servidor se cae aquí, el cambio se recuperará del log
```

---

## 6. Concurrencia y Bloqueos (Locks)

### Escenario: Tabla de Control de Folios

**Esquema de la tabla:**
```sql
CREATE TABLE Pag_Folios (
    Folio    INT,
    Usuario  INT,
    Estado   CHAR(1)
);

-- Datos iniciales
INSERT INTO Pag_Folios VALUES(0, 0, 'D');  -- Disponible
INSERT INTO Pag_Folios VALUES(0, 0, 'E');  -- En uso
```

### Ejemplo 1: Bloqueo por Scan de Tabla

**Conexión 1:**
```sql
BEGIN TRAN
    UPDATE Pag_Folios SET Usuario = 4918 WHERE Estado = 'D';
    -- Transacción NO terminada (sin COMMIT)
```

**Conexión 2:**
```sql
BEGIN TRAN
    SELECT * FROM Pag_Folios WHERE Estado = 'E';
```

**¿Qué sucede?**

El SELECT en Conexión 2 realiza un **table scan** (escaneo completo) para validar la condición. Al encontrar una tupla con **bloqueo exclusivo** (de Conexión 1), no puede poner candado compartido y **se bloquea indefinidamente**.

### Ejemplo 2: Uso de Índices para Evitar Bloqueos

**Crear índice:**
```sql
CREATE NONCLUSTERED INDEX Idx_Estado ON Pag_Folios(Estado);
```

**Conexión 1:**
```sql
BEGIN TRAN
    UPDATE Pag_Folios SET Usuario = 4918 WHERE Estado = 'D';
```

**Conexión 2:**
```sql
BEGIN TRAN
    SELECT * FROM Pag_Folios WITH (INDEX=Idx_Estado) WHERE Estado = 'E';
```

**¿Qué sucede?**

El SELECT en Conexión 2 **NO realiza table scan**. Usa el índice especificado y va directo a las tuplas con `Estado='E'`, que **no tienen candados exclusivos** y puede accederlas sin problema.

---

## 7. Deadlock (Abrazo Mortal)

### Definición

Un **deadlock** se presenta cuando 2 o más transacciones requieren de un recurso que se encuentra bloqueado por otra transacción y ésta nunca libera el recurso.

### Ejemplo de Deadlock

**Conexión 1:**
```sql
BEGIN TRAN
    -- Obtiene bloqueo exclusivo en Pag_Folios
    UPDATE Pag_Folios SET Folio = Folio + 1 WHERE Estado = 'E';
    
    -- Intenta leer Pag_Folios2 (requiere bloqueo compartido)
    SELECT * FROM Pag_Folios2 WHERE Estado = 'E';  -- ⏸ SE BLOQUEA
    
    -- Aún no ejecuta el COMMIT
COMMIT TRAN;
```

**Conexión 2:**
```sql
BEGIN TRAN
    -- Obtiene bloqueo exclusivo en Pag_Folios2
    UPDATE Pag_Folios2 SET Folio = Folio + 1 WHERE Estado = 'E';
    
    -- Intenta leer Pag_Folios (requiere bloqueo compartido)
    SELECT * FROM Pag_Folios WHERE Estado = 'E';  -- ⏸ SE BLOQUEA
    
    -- Aún no ejecuta el COMMIT
COMMIT TRAN;
```

### ¿Por qué ocurre el Deadlock?

1. Conexión 1 obtiene **bloqueo exclusivo** en `Pag_Folios`
2. Conexión 2 obtiene **bloqueo exclusivo** en `Pag_Folios2`
3. Conexión 1 intenta **bloqueo compartido** en `Pag_Folios2` → bloqueada por Conexión 2
4. Conexión 2 intenta **bloqueo compartido** en `Pag_Folios` → bloqueada por Conexión 1

**¡Cada una espera por la otra!**

### Resolución de Deadlocks

SQL Server **detecta automáticamente** los deadlocks y cancela la transacción "más débil" (la que ha consumido menos recursos), generando el error **1205**.

```sql
-- Error generado en la víctima del deadlock:
-- Msg 1205, Level 13, State 51
-- Transaction (Process ID 52) was deadlocked on lock resources with 
-- another process and has been chosen as the deadlock victim. 
-- Rerun the transaction.
```

---

## 8. Control de Timeout de Bloqueos

### SET LOCK_TIMEOUT

Por defecto, las sentencias SELECT esperan **indefinidamente** a que se libere un recurso bloqueado.

Podemos establecer un **límite de tiempo** de espera:

```sql
SET LOCK_TIMEOUT <milisegundos>;
```

**Valores:**
- `valor > 0`: Tiempo máximo de espera en milisegundos
- `-1`: Espera indefinida (default)
- `0`: No espera (retorna error inmediatamente si hay bloqueo)

### Ejemplo de Uso

```sql
SET LOCK_TIMEOUT 1000;  -- Esperar máximo 1 segundo

DECLARE @Error INT;

SELECT * FROM CTL_Folios WHERE Estado = 'VERACRUZ';

SET @Error = @@ERROR;

IF @Error = 1222  -- Error de timeout
    PRINT 'No logró recuperar la tupla (timeout)';
ELSE
    PRINT 'Recuperó la tupla exitosamente';

SET LOCK_TIMEOUT -1;  -- Restaurar valor por defecto
```

### Procedimiento Almacenado con Timeout

```sql
CREATE PROCEDURE dbo.Recurso AS
BEGIN
    SET LOCK_TIMEOUT 5000;  -- 5 segundos
    
    DECLARE @Error INT, @Folio INT;
    
    SELECT @Folio = Folio 
    FROM Ctl_Folios  
    WHERE Estado = 'Veracruz';
    
    SET @Error = @@ERROR;
    
    SET LOCK_TIMEOUT -1;  -- Restaurar
    
    RETURN @Error;
END;
GO

-- Ejecutar el procedimiento
DECLARE @Resultado INT;
EXEC @Resultado = Recurso;
PRINT @Resultado;  -- 0 = éxito, 1222 = timeout
```

---

## 9. Problemas de Aislamiento: Ejemplo Práctico

### Escenario: Control de Folios Consecutivos

**Crear tabla de folios usados:**
```sql
CREATE TABLE dbo.Folios_Usados ( 
    Folio INT PRIMARY KEY
);

-- Tabla de control
UPDATE CTL_Folios SET Folio = 0;
```

### Problema: Race Condition sin Bloqueo Adecuado

**Conexión 1:**
```sql
BEGIN TRAN
    DECLARE @Folio INT;
    
    -- Lee el folio actual
    SELECT @Folio = Folio FROM CTL_Folios WHERE Estado = 'Sinaloa';
    
    -- Incrementa
    SET @Folio = @Folio + 1;
    
    -- Registra el folio usado
    INSERT INTO Folios_Usados VALUES(@Folio);
    
    -- Actualiza el control
    UPDATE CTL_Folios SET Folio = @Folio WHERE Estado = 'Sinaloa';
    
COMMIT TRAN;
```

**Conexión 2 (ejecutando concurrentemente):**
```sql
BEGIN TRAN
    DECLARE @Folio INT;
    
    -- Lee el MISMO folio (antes de que Conexión 1 actualice)
    SELECT @Folio = Folio FROM CTL_Folios WHERE Estado = 'Sinaloa';
    
    SET @Folio = @Folio + 1;
    
    -- Intenta insertar el MISMO folio → ERROR (PRIMARY KEY duplicada)
    INSERT INTO Folios_Usados VALUES(@Folio);
    
    UPDATE CTL_Folios SET Folio = @Folio WHERE Estado = 'Sinaloa';
    
COMMIT TRAN;
```

**Problema:** Ambas conexiones leen el mismo valor de folio porque el SELECT no bloquea el registro.

---

## 10. Solución: Hint UPDLOCK

### Uso de WITH (UPDLOCK)

Para evitar que dos o más transacciones accedan al mismo recurso concurrentemente, aplicamos un **bloqueo de actualización** desde el SELECT:

```sql
SELECT ... FROM tabla WITH (UPDLOCK) WHERE ...
```

**Características de UPDLOCK:**
- Adquiere un **bloqueo de actualización** (update lock) en lugar de compartido
- Es compatible con otros lectores (shared locks)
- **NO es compatible** con otros UPDLOCK ni con bloqueos exclusivos
- Previene deadlocks en el patrón SELECT → UPDATE

### Solución Correcta

**Conexión 1:**
```sql
BEGIN TRAN
    DECLARE @Folio INT;
    
    -- Bloqueo de actualización desde el SELECT
    SELECT @Folio = Folio 
    FROM CTL_Folios WITH (UPDLOCK) 
    WHERE Estado = 'Sinaloa';
    
    SET @Folio = @Folio + 1;
    
    INSERT INTO Folios_Usados VALUES(@Folio);
    
    UPDATE CTL_Folios SET Folio = @Folio WHERE Estado = 'Sinaloa';
    
COMMIT TRAN;
```

**Conexión 2:**
```sql
BEGIN TRAN
    DECLARE @Folio INT;
    
    -- Intenta obtener UPDLOCK, pero se BLOQUEA porque Conexión 1 lo tiene
    SELECT @Folio = Folio 
    FROM CTL_Folios WITH (UPDLOCK) 
    WHERE Estado = 'Sinaloa';  -- ⏸ Espera aquí
    
    SET @Folio = @Folio + 1;
    
    INSERT INTO Folios_Usados VALUES(@Folio);
    
    UPDATE CTL_Folios SET Folio = @Folio WHERE Estado = 'Sinaloa';
    
COMMIT TRAN;
```

**Resultado:** Conexión 2 espera hasta que Conexión 1 termine, garantizando folios consecutivos únicos.

---

## 11. Transacciones Anidadas

### Concepto

SQL Server permite **transacciones anidadas** (transacciones dentro de transacciones).

### Variable @@TRANCOUNT

Indica el **nivel de anidamiento actual**:
- `0`: No hay transacción activa
- `1`: Una transacción activa
- `2`: Una transacción anidada (2 niveles)
- `n`: n transacciones anidadas

### Ejemplo de Anidamiento

```sql
SELECT @@TRANCOUNT;  -- 0

BEGIN TRAN;
    SELECT @@TRANCOUNT;  -- 1
    
    UPDATE Titles SET Price = Price * 1.10;
    
    BEGIN TRAN;  -- Transacción anidada
        SELECT @@TRANCOUNT;  -- 2
        
        UPDATE Titles SET Royalty = Royalty + 5;
        
    COMMIT TRAN;  -- Decrementa @@TRANCOUNT
    
    SELECT @@TRANCOUNT;  -- 1
    
COMMIT TRAN;

SELECT @@TRANCOUNT;  -- 0
```

### Importante: Las Transacciones Anidadas Son Sintácticas

**El COMMIT tiene impacto real SOLO al final de la transacción más externa.**

```sql
BEGIN TRAN;  -- @@TRANCOUNT = 1
    UPDATE Tabla1 SET Campo = 'A';
    
    BEGIN TRAN;  -- @@TRANCOUNT = 2
        UPDATE Tabla2 SET Campo = 'B';
    COMMIT TRAN;  -- @@TRANCOUNT = 1, PERO los cambios NO se confirman aún
    
    -- Si hacemos ROLLBACK aquí, se deshacen AMBOS updates
    ROLLBACK TRAN;  -- @@TRANCOUNT = 0
```

**Nota:** Un `ROLLBACK TRAN` deshace **todas las transacciones anidadas**, sin importar cuántos `COMMIT` internos se hayan ejecutado.

---

## 12. Monitoreo de Bloqueos

### sp_lock (Deprecado, pero ilustrativo)

```sql
EXEC sp_lock;
```

Muestra información sobre bloqueos activos en el servidor.

### Vista Moderna: sys.dm_tran_locks

```sql
SELECT 
    resource_type,
    resource_database_id,
    resource_associated_entity_id,
    request_mode,
    request_type,
    request_status,
    request_session_id
FROM sys.dm_tran_locks
WHERE resource_database_id = DB_ID();
```

### Ejemplo Completo de Monitoreo

```sql
SET NOCOUNT OFF;

-- Ver objetos involucrados
SELECT * FROM escuelas;
SELECT * FROM sysobjects WHERE id IN (1794821456, 85575343);
SELECT * FROM Pag_Folios;

-- Iniciar transacción y ver bloqueos
BEGIN TRAN
    UPDATE Pag_Folios SET Usuario = 4913;
    
    -- Ver bloqueos activos
    EXEC sp_lock;
    
    -- O con DMV
    SELECT * FROM sys.dm_tran_locks
    WHERE request_session_id = @@SPID;
    
COMMIT TRAN;
```

---

## 13. Niveles de Aislamiento

Los **niveles de aislamiento** permiten controlar el nivel de consistencia al manipular datos cuando varios procesos se ejecutan concurrentemente.

### Niveles Disponibles en SQL Server

1. **READ UNCOMMITTED**
2. **READ COMMITTED** (default)
3. **REPEATABLE READ**
4. **SERIALIZABLE**
5. **SNAPSHOT**

### Sintaxis

```sql
SET TRANSACTION ISOLATION LEVEL <nivel>;
```

---

## 14. Problemas de Consistencia en Concurrencia

### 1. Lecturas Sucias (Dirty Reads)

Una transacción lee datos modificados por otra transacción que **aún no ha confirmado** (COMMIT).

**Ejemplo:**
```sql
-- Conexión 1
BEGIN TRAN
    UPDATE Productos SET Precio = 100 WHERE ProductoID = 1;
    -- NO hace COMMIT aún

-- Conexión 2
SELECT Precio FROM Productos WHERE ProductoID = 1;  
-- ¿Lee 100 (valor no confirmado) o el valor original?
```

### 2. Actualizaciones Perdidas (Lost Updates)

Una transacción sobrescribe cambios realizados por otra transacción.

**Ejemplo:**
```sql
-- Conexión 1: Lee saldo = 1000
BEGIN TRAN
    DECLARE @Saldo INT;
    SELECT @Saldo = Saldo FROM Cuentas WHERE CuentaID = 1;  -- 1000
    SET @Saldo = @Saldo - 100;  -- 900
    -- ... espera ...

-- Conexión 2: Lee saldo = 1000 (antes de que C1 actualice)
BEGIN TRAN
    DECLARE @Saldo INT;
    SELECT @Saldo = Saldo FROM Cuentas WHERE CuentaID = 1;  -- 1000
    SET @Saldo = @Saldo + 200;  -- 1200
    UPDATE Cuentas SET Saldo = @Saldo WHERE CuentaID = 1;  -- Escribe 1200
COMMIT TRAN;

-- Conexión 1: Continúa
    UPDATE Cuentas SET Saldo = @Saldo WHERE CuentaID = 1;  -- Escribe 900
COMMIT TRAN;

-- ¡El depósito de 200 se perdió!
```

### 3. Lecturas No Repetibles (Non-Repeatable Reads)

Dentro de la misma transacción, dos lecturas del mismo dato obtienen **valores diferentes**.

**Ejemplo:**
```sql
-- Conexión 1
BEGIN TRAN
    SELECT Precio FROM Productos WHERE ProductoID = 1;  -- Lee 100
    
    -- ... otra transacción modifica el precio ...
    
    SELECT Precio FROM Productos WHERE ProductoID = 1;  -- Lee 150
COMMIT TRAN;
```

### 4. Lecturas Fantasma (Phantom Reads)

Una transacción ejecuta la misma consulta dos veces y obtiene **conjuntos de filas diferentes** porque otra transacción insertó o eliminó filas que cumplen la condición.

**Ejemplo:**
```sql
-- Conexión 1
BEGIN TRAN
    SELECT COUNT(*) FROM Ventas WHERE Fecha = '2025-11-20';  -- 10 filas
    
    -- Conexión 2 inserta una nueva venta con esa fecha
    
    SELECT COUNT(*) FROM Ventas WHERE Fecha = '2025-11-20';  -- 11 filas (fantasma)
COMMIT TRAN;
```

---

## 15. READ UNCOMMITTED

### Sintaxis

```sql
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
```

### Características

- **Nivel más bajo de aislamiento**
- Los lectores **NO solicitan bloqueos compartidos**
- Los lectores **nunca están en conflicto** con modificadores
- Puede leer datos con **bloqueo exclusivo**
- **Permite lecturas sucias** (dirty reads)
- **Mejor concurrencia**, peor consistencia

### Ejemplo

**Conexión 1:**
```sql
BEGIN TRAN
    UPDATE Ctl_Folios SET Usuario = 4918;
    
    SELECT * FROM Ctl_Folios;  -- Muestra Usuario = 4918
    
    -- NO ejecuta COMMIT aún
```

**Conexión 2:**
```sql
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

SELECT * FROM Ctl_Folios;  -- ✓ Lee Usuario = 4918 (dato NO confirmado)
```

**Resultado:** Conexión 2 puede acceder a los datos modificados aunque Conexión 1 no haya terminado.

### Cuándo Usarlo

- Reportes que no requieren precisión exacta
- Consultas de solo lectura donde la consistencia no es crítica
- Monitoreo y estadísticas aproximadas

**⚠ ADVERTENCIA:** Puede leer datos que luego sean revertidos (ROLLBACK).

---

## 16. READ COMMITTED (Default)

### Sintaxis

```sql
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
```

### Características

- **Nivel de aislamiento por defecto** en SQL Server
- Los lectores **requieren bloqueos compartidos**
- Los bloqueos compartidos se **liberan tan pronto** como el dato ha sido leído (no cuando la transacción termina)
- **NO permite lecturas sucias**
- Puede tener lecturas no repetibles

### Ejemplo

**Conexión 1:**
```sql
BEGIN TRAN
    UPDATE Ctl_Folios SET Usuario = 4918;
    
    SELECT * FROM Ctl_Folios;
    
    -- NO ejecuta COMMIT
```

**Conexión 2:**
```sql
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

SELECT * FROM Ctl_Folios;  -- ⏸ SE BLOQUEA hasta que C1 haga COMMIT o ROLLBACK
```

**Resultado:** Conexión 2 queda bloqueada hasta que Conexión 1 termine.

### Comparación de Problemas

| Problema | READ UNCOMMITTED | READ COMMITTED |
|----------|------------------|----------------|
| Lecturas sucias | ✗ Sí ocurren | ✓ No ocurren |
| Lecturas no repetibles | ✗ Sí ocurren | ✗ Sí ocurren |
| Lecturas fantasma | ✗ Sí ocurren | ✗ Sí ocurren |

---

## 17. REPEATABLE READ

### Sintaxis

```sql
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
```

### Características

- Requiere **bloqueos compartidos** al leer datos
- Los bloqueos compartidos se **mantienen hasta el final de la transacción**
- **Garantiza lecturas repetibles** (mismo valor en múltiples lecturas)
- Previene lecturas sucias y lecturas no repetibles
- **Puede causar deadlocks** en patrón SELECT → UPDATE
- Permite lecturas fantasma

### Ejemplo

**Conexión 1:**
```sql
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;

BEGIN TRAN
    -- Primera lectura
    SELECT Folio FROM Pag_Folios WHERE Estado = 'E';  -- Lee Folio = 100
    
    -- ... más instrucciones ...
    
    -- Segunda lectura
    SELECT Folio FROM Pag_Folios WHERE Estado = 'E';  -- Lee Folio = 100 (MISMO valor)
    
COMMIT TRAN;
```

**Conexión 2:**
```sql
-- Intenta modificar el dato que Conexión 1 está leyendo
UPDATE Pag_Folios SET Folio = 0 WHERE Estado = 'E';  -- ⏸ SE BLOQUEA
```

**Resultado:** Conexión 2 se bloquea. Conexión 1 garantiza leer el mismo valor en ambos SELECT.

### Problema Potencial: Deadlock

```sql
-- Conexión 1
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
BEGIN TRAN
    SELECT * FROM Tabla1;  -- Adquiere bloqueo compartido
    UPDATE Tabla1 SET Campo = 'A';  -- ⏸ Intenta bloqueo exclusivo

-- Conexión 2
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
BEGIN TRAN
    SELECT * FROM Tabla1;  -- Adquiere bloqueo compartido
    UPDATE Tabla1 SET Campo = 'B';  -- ⏸ Intenta bloqueo exclusivo

-- ¡DEADLOCK! Cada una tiene bloqueo compartido y requiere exclusivo
```

### Comparación de Problemas

| Problema | READ COMMITTED | REPEATABLE READ |
|----------|----------------|-----------------|
| Lecturas sucias | ✓ No ocurren | ✓ No ocurren |
| Lecturas no repetibles | ✗ Sí ocurren | ✓ No ocurren |
| Lecturas fantasma | ✗ Sí ocurren | ✗ Sí ocurren |

---

## 18. SERIALIZABLE

### Sintaxis

```sql
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
```

### Características

- **Nivel más alto de aislamiento**
- Similar a REPEATABLE READ con característica adicional
- Pone **bloqueos de rango de claves** (key-range locks) sobre índices
- El rango incluye claves que **existen físicamente y claves fantasma** (que aún no existen)
- **Previene lecturas fantasma**
- **Peor concurrencia**, mejor consistencia

### Ejemplo: Prevención de Fantasmas

**Preparación:**
```sql
CREATE NONCLUSTERED INDEX IdxFolios ON Folios(Folio);
```

**Conexión 1:**
```sql
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

BEGIN TRAN
    -- Actualiza rango de folios [1-50]
    -- Bloquea TODAS las claves en ese rango (existentes y futuras)
    UPDATE dbo.Folios 
    SET Usuario = 10 
    WHERE Folio BETWEEN 1 AND 50;
    
    -- Transacción continúa abierta
COMMIT TRAN;
```

**Conexión 2:**
```sql
-- Intenta insertar Folio = 20 (dentro del rango bloqueado)
INSERT INTO Folios(Folio, Usuario, Estatus) 
VALUES(20, 0, 'D');  -- ⏸ SE BLOQUEA
```

**Resultado:** El INSERT se bloquea porque Folio=20 está en el rango [1-50] bloqueado por Conexión 1, **aunque la fila con Folio=20 no exista aún**.

### Comparación de Problemas

| Problema | REPEATABLE READ | SERIALIZABLE |
|----------|-----------------|--------------|
| Lecturas sucias | ✓ No ocurren | ✓ No ocurren |
| Lecturas no repetibles | ✓ No ocurren | ✓ No ocurren |
| Lecturas fantasma | ✗ Sí ocurren | ✓ No ocurren |

---

## 19. SNAPSHOT Isolation

### Sintaxis

```sql
-- Habilitar en la base de datos (requerido)
ALTER DATABASE NombreDB SET ALLOW_SNAPSHOT_ISOLATION ON;

-- Establecer nivel de aislamiento
SET TRANSACTION ISOLATION LEVEL SNAPSHOT;
```

### Características

- Basado en **versionamiento de filas** (row versioning)
- Cada transacción ve una **versión consistente** de los datos al inicio de la transacción
- **No usa bloqueos de lectura** (readers no bloquean writers, writers no bloquean readers)
- Las versiones anteriores se almacenan en **tempdb** (sys.dm_tran_version_store)
- **Excelente concurrencia**, buena consistencia

### Funcionamiento

Cuando una transacción modifica datos:
1. SQL Server guarda la **versión anterior** de la fila en tempdb
2. Otras transacciones SNAPSHOT leen la versión anterior
3. Al hacer COMMIT, la nueva versión se convierte en la actual

### Ejemplo Completo

**Preparación:**
```sql
ALTER DATABASE Sales SET ALLOW_SNAPSHOT_ISOLATION ON;

-- Tabla de control
CREATE TABLE Ctl_Folios (
    Estado VARCHAR(50),
    Usuario INT
);

INSERT INTO Ctl_Folios VALUES('SINALOA', 10);
```

**Conexión 1:**
```sql
BEGIN TRAN
    -- Modifica el usuario de 10 a 9999
    UPDATE dbo.Ctl_Folios 
    SET Usuario = 9999 
    WHERE Estado = 'SINALOA';
    
    -- Ver versión almacenada en tempdb
    SELECT * FROM sys.dm_tran_version_store;
    
    -- Transacción NO terminada (sin COMMIT)
```

**Resultado en Conexión 1:**
- Usuario cambió de `10` a `9999`
- La versión anterior (Usuario=10) se guardó en tempdb

**Conexión 2:**
```sql
SET TRANSACTION ISOLATION LEVEL SNAPSHOT;

BEGIN TRAN
    -- Lee el estado más reciente AL INICIO de esta transacción
    SELECT Usuario FROM Ctl_Folios WHERE Estado = 'SINALOA';  -- Muestra 10
    
    -- ... más operaciones ...
```

**Resultado en Conexión 2:**
- Lee Usuario = `10` (versión anterior)
- **NO se bloquea** aunque Conexión 1 tenga bloqueo exclusivo

**Ahora en Conexión 1:**
```sql
COMMIT TRAN;  -- Confirma el cambio a 9999

SELECT Usuario FROM Ctl_Folios WHERE Estado = 'SINALOA';  -- Muestra 9999
```

**Y en Conexión 2:**
```sql
    -- Segunda lectura dentro de la MISMA transacción
    SELECT Usuario FROM Ctl_Folios WHERE Estado = 'SINALOA';  -- Sigue mostrando 10
    
COMMIT TRAN;

-- Nueva transacción
BEGIN TRAN
    SELECT Usuario FROM Ctl_Folios WHERE Estado = 'SINALOA';  -- Ahora muestra 9999
COMMIT TRAN;
```

**Explicación:**
- Conexión 2 mantiene la **versión consistente** (Usuario=10) durante toda su transacción
- Solo cuando inicia una **nueva transacción** ve el nuevo valor (9999)

### Ventajas de SNAPSHOT

✅ **No hay bloqueos de lectura** (excelente concurrencia)
✅ **Consistencia de lectura** dentro de la transacción
✅ **Previene lecturas sucias, no repetibles y fantasmas**

### Desventajas de SNAPSHOT

❌ **Consume espacio en tempdb** (almacena versiones)
❌ **Overhead de performance** al mantener versiones
❌ **Conflictos de actualización** (update conflicts) si dos transacciones modifican el mismo dato

---

## 20. Comparación de Niveles de Aislamiento

| Nivel | Lecturas Sucias | Lecturas No Repetibles | Fantasmas | Bloqueos | Concurrencia |
|-------|-----------------|------------------------|-----------|----------|--------------|
| **READ UNCOMMITTED** | ✗ Permite | ✗ Permite | ✗ Permite | Ninguno | ⭐⭐⭐⭐⭐ |
| **READ COMMITTED** | ✓ Previene | ✗ Permite | ✗ Permite | Compartidos (cortos) | ⭐⭐⭐⭐ |
| **REPEATABLE READ** | ✓ Previene | ✓ Previene | ✗ Permite | Compartidos (largos) | ⭐⭐⭐ |
| **SERIALIZABLE** | ✓ Previene | ✓ Previene | ✓ Previene | Rango | ⭐⭐ |
| **SNAPSHOT** | ✓ Previene | ✓ Previene | ✓ Previene | Sin bloqueos de lectura | ⭐⭐⭐⭐ |

---

## 21. Mejores Prácticas con Transacciones

### 1. Mantener Transacciones Cortas

```sql
-- ✗ MAL: Transacción larga con lógica de negocio
BEGIN TRAN
    DECLARE @Total DECIMAL(10,2) = 0;
    DECLARE @i INT = 1;
    
    -- Procesamiento largo
    WHILE @i <= 10000
    BEGIN
        SET @Total = @Total + @i * 0.5;
        SET @i = @i + 1;
    END
    
    UPDATE Resumen SET Total = @Total;
COMMIT TRAN;

-- ✓ BIEN: Procesamiento fuera, transacción corta
DECLARE @Total DECIMAL(10,2) = 0;
DECLARE @i INT = 1;

WHILE @i <= 10000
BEGIN
    SET @Total = @Total + @i * 0.5;
    SET @i = @i + 1;
END

BEGIN TRAN
    UPDATE Resumen SET Total = @Total;
COMMIT TRAN;
```

### 2. Siempre Usar TRY...CATCH

```sql
BEGIN TRY
    BEGIN TRAN;
        
        -- Operaciones
        
    COMMIT TRAN;
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0
        ROLLBACK TRAN;
    
    -- Registrar error
    DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
    RAISERROR(@ErrorMessage, 16, 1);
END CATCH;
```

### 3. Verificar @@TRANCOUNT

```sql
-- En procedimientos almacenados anidados
CREATE PROCEDURE usp_Proceso AS
BEGIN
    DECLARE @TranIniciada BIT = 0;
    
    IF @@TRANCOUNT = 0
    BEGIN
        BEGIN TRAN;
        SET @TranIniciada = 1;
    END
    
    BEGIN TRY
        -- Lógica del procedimiento
        
        IF @TranIniciada = 1
            COMMIT TRAN;
    END TRY
    BEGIN CATCH
        IF @TranIniciada = 1
            ROLLBACK TRAN;
        THROW;
    END CATCH
END;
```

### 4. Usar SET XACT_ABORT ON

```sql
SET XACT_ABORT ON;  -- Automáticamente hace ROLLBACK ante cualquier error

BEGIN TRAN
    UPDATE Tabla1 SET Campo = 'A';
    UPDATE Tabla2 SET Campo = 'B';  -- Si falla, automáticamente ROLLBACK
COMMIT TRAN;
```

### 5. Evitar Transacciones en Triggers

```sql
-- ✗ MAL: Transacción explícita en trigger
CREATE TRIGGER trg_Validar ON Productos
AFTER INSERT
AS
BEGIN
    BEGIN TRAN  -- ¡NO HACER ESTO!
        -- Validaciones
    COMMIT TRAN
END;

-- ✓ BIEN: El trigger ya está dentro de la transacción del comando que lo activó
CREATE TRIGGER trg_Validar ON Productos
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Validaciones
    IF EXISTS (SELECT 1 FROM inserted WHERE Precio < 0)
    BEGIN
        ROLLBACK TRAN;  -- Revierte la transacción del INSERT
        RAISERROR('Precio inválido', 16, 1);
    END
END;
```

---

## 22. Ejercicios Prácticos

### Ejercicio 1: Control de Inventario con Transacciones

Implemente un procedimiento almacenado que procese una venta:
1. Valide que el cliente exista
2. Valide que haya suficiente inventario
3. Registre la venta
4. Actualice el inventario
5. Registre el pago

**Requisitos:**
- Use transacciones explícitas
- Maneje errores con TRY...CATCH
- Retorne código de estado (0 = éxito, -1 = error)
- Use parámetros OUTPUT para mensajes

### Ejercicio 2: Análisis de Niveles de Aislamiento

Con dos conexiones abiertas, reproduzca:
1. Una lectura sucia con READ UNCOMMITTED
2. Una lectura no repetible con READ COMMITTED
3. Una lectura fantasma con REPEATABLE READ
4. Prevención de fantasma con SERIALIZABLE

### Ejercicio 3: Deadlock Detection

Cree un escenario de deadlock intencional y:
1. Capture el error 1205
2. Identifique cuál transacción fue la víctima
3. Implemente reintentos automáticos

### Ejercicio 4: Generador de Folios Concurrente

Implemente un sistema de folios consecutivos que:
- Permita múltiples usuarios generando folios concurrentemente
- Garantice que no haya duplicados
- Use UPDLOCK correctamente
- Maneje timeout de bloqueos

---

## 23. Resumen de Comandos

### Control de Transacciones

```sql
BEGIN TRAN [nombre]                    -- Iniciar transacción
COMMIT TRAN [nombre]                   -- Confirmar transacción
ROLLBACK TRAN [nombre]                 -- Revertir transacción
SAVE TRAN nombre_savepoint             -- Crear punto de guardado
ROLLBACK TRAN nombre_savepoint         -- Revertir a punto de guardado
```

### Variables Globales

```sql
@@TRANCOUNT    -- Nivel de anidamiento de transacciones
@@ERROR        -- Código de error del último comando
@@ROWCOUNT     -- Filas afectadas por el último comando
```

### Configuración de Sesión

```sql
SET TRANSACTION ISOLATION LEVEL <nivel>  -- Establecer nivel de aislamiento
SET LOCK_TIMEOUT <ms>                    -- Timeout de bloqueos
SET XACT_ABORT ON/OFF                    -- Auto-rollback en errores
SET NOCOUNT ON/OFF                       -- Suprimir mensajes de filas afectadas
```

### Hints de Bloqueo

```sql
SELECT * FROM tabla WITH (NOLOCK)        -- = READ UNCOMMITTED
SELECT * FROM tabla WITH (UPDLOCK)       -- Bloqueo de actualización
SELECT * FROM tabla WITH (HOLDLOCK)      -- = SERIALIZABLE
SELECT * FROM tabla WITH (READPAST)      -- Saltar filas bloqueadas
SELECT * FROM tabla WITH (ROWLOCK)       -- Forzar bloqueo a nivel fila
SELECT * FROM tabla WITH (TABLOCKX)      -- Bloqueo exclusivo de tabla
```

### DMVs Útiles

```sql
-- Ver bloqueos activos
SELECT * FROM sys.dm_tran_locks;

-- Ver transacciones activas
SELECT * FROM sys.dm_tran_active_transactions;

-- Ver versiones SNAPSHOT
SELECT * FROM sys.dm_tran_version_store;

-- Ver sesiones bloqueadas
SELECT * FROM sys.dm_exec_requests WHERE blocking_session_id <> 0;
```

---

## Recursos Adicionales

- [Microsoft Docs: Transacciones](https://learn.microsoft.com/en-us/sql/t-sql/language-elements/transactions-transact-sql)
- [Isolation Levels](https://learn.microsoft.com/en-us/sql/t-sql/statements/set-transaction-isolation-level-transact-sql)
- [Lock Compatibility](https://learn.microsoft.com/en-us/previous-versions/sql/sql-server-2008-r2/ms186396(v=sql.105))

---

**Última actualización:** Noviembre 2025  
**Materia:** Taller de Base de Datos  
**Tema:** Control de Concurrencia - Transacciones
