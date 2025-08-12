# 4. Control de Concurrencia

## 🎯 Competencia de la Unidad
**Implementar mecanismos de control de concurrencia y gestión de transacciones para garantizar la consistencia e integridad de los datos en entornos multiusuario.**

## 📋 Objetivos de Aprendizaje
Al finalizar esta unidad, el estudiante será capaz de:
- ✅ Implementar transacciones ACID en diferentes SGBD
- ✅ Configurar niveles de aislamiento apropiados según el contexto
- ✅ Identificar y resolver problemas de concurrencia (deadlocks, dirty reads)
- ✅ Diseñar estrategias de bloqueo y control de concurrencia
- ✅ Optimizar rendimiento en entornos de alta concurrencia

## 🔧 Contenido Temático

### 4.1 Fundamentos de Transacciones
- **Propiedades ACID**
  - **Atomicity (Atomicidad)**: Todo o nada en una transacción
  - **Consistency (Consistencia)**: Mantener integridad referencial
  - **Isolation (Aislamiento)**: Transacciones independientes
  - **Durability (Durabilidad)**: Persistencia ante fallos

- **Control de transacciones**
  - BEGIN TRANSACTION / START TRANSACTION
  - COMMIT para confirmar cambios
  - ROLLBACK para deshacer operaciones
  - SAVEPOINT para puntos de recuperación parcial

- **Logs de transacciones**
  - Write-Ahead Logging (WAL)
  - Recovery y rollback automático
  - Checkpoint y flush de datos

### 4.2 Niveles de Aislamiento
- **READ UNCOMMITTED**
  - Permite dirty reads
  - Máximo rendimiento, mínima consistencia
  - Uso en reportes donde la precisión no es crítica

- **READ COMMITTED**
  - Previene dirty reads
  - Nivel por defecto en muchos SGBD
  - Balance entre rendimiento y consistencia

- **REPEATABLE READ**
  - Previene dirty y non-repeatable reads
  - Puede permitir phantom reads
  - Uso en análisis que requieren consistencia

- **SERIALIZABLE**
  - Máximo nivel de aislamiento
  - Previene todos los problemas de lectura
  - Impacto en rendimiento por serialización

### 4.3 Problemas de Concurrencia
- **Dirty Read**: Leer datos no confirmados
  - Ejemplo: Transacción lee datos que otra transacción puede deshacer
  - Solución: READ COMMITTED o superior

- **Non-Repeatable Read**: Lecturas inconsistentes
  - Ejemplo: Misma consulta retorna resultados diferentes
  - Solución: REPEATABLE READ o superior

- **Phantom Read**: Aparición de nuevos registros
  - Ejemplo: COUNT(*) cambia durante la transacción
  - Solución: SERIALIZABLE

- **Lost Update**: Pérdida de actualizaciones
  - Ejemplo: Dos transacciones modifican el mismo dato
  - Solución: Optimistic/Pessimistic locking

### 4.4 Estrategias de Bloqueo
- **Bloqueo Pesimista (Pessimistic Locking)**
  - SELECT... FOR UPDATE
  - Bloquea registros antes de modificar
  - Previene conflictos pero reduce concurrencia

- **Bloqueo Optimista (Optimistic Locking)**
  - Version control con timestamps o version numbers
  - Permite alta concurrencia
  - Requiere manejo de conflictos en aplicación

- **Deadlock Detection y Resolution**
  - Detección automática de interbloqueos
  - Algoritmos de selección de víctima
  - Strategies de prevención de deadlocks

## 📝 Actividades y Prácticas

### 🔬 Laboratorio 7: Transacciones ACID
**Duración**: 4 horas  
**Modalidad**: Individual

**Objetivo**: Implementar y probar transacciones complejas con manejo de errores.

**Scenario**: Sistema bancario con transferencias entre cuentas que debe garantizar:
- Atomicidad: Transferencia completa o rollback total
- Consistencia: Saldos siempre válidos
- Aislamiento: Transferencias concurrentes independientes
- Durabilidad: Persistencia ante fallos del sistema

**Entregables**:
- Scripts de transacciones bancarias con manejo de errores
- Pruebas de rollback y recovery
- Simulación de fallos del sistema
- Documentación de casos de prueba y resultados

### 🔬 Laboratorio 8: Niveles de Aislamiento
**Duración**: 4 horas  
**Modalidad**: Individual

**Objetivo**: Experimentar con diferentes niveles de aislamiento y sus efectos.

**Entregables**:
- Demostración práctica de cada problema de concurrencia
- Comparación de rendimiento entre niveles de aislamiento
- Recomendaciones de uso según el contexto de aplicación
- Scripts que reproducen dirty reads, phantom reads, etc.

### ⚡ Reto de Concurrencia: Sistema de Reservas
**Duración**: 8 horas  
**Modalidad**: Equipos de 3-4 personas

**Problema**: Sistema de reservas de vuelos con alta concurrencia donde:
- Múltiples usuarios reservan simultáneamente
- Inventory limitado debe mantenerse consistente
- Reservas tienen timeout (liberación automática)
- Se requiere alta disponibilidad y rendimiento

**Challenges específicos**:
- Overbooking controlado (overselling del 105%)
- Reservas en espera (waiting list)
- Cancelaciones y liberación de asientos
- Reporting en tiempo real de disponibilidad

**Entregables**:
- Diseño de base de datos optimizado para concurrencia
- Implementación de lógica de reservas con transacciones
- Simulador de carga con múltiples usuarios concurrentes
- Análisis de rendimiento y bottlenecks
- Estrategias de optimización implementadas

### 🏢 Proyecto Integrador: E-commerce de Alta Concurrencia
**Duración**: 16 horas  
**Modalidad**: Equipos de 4-5 personas

**Problema**: Diseñar la base de datos y lógica de transacciones para un e-commerce que maneja:
- Inventario en tiempo real con múltiples warehouses
- Carritos de compra con reserva temporal de productos
- Procesamiento de pagos con validaciones complejas
- Sistema de puntos de lealtad y descuentos
- Analytics en tiempo real sin afectar transacciones

**Requerimientos técnicos**:
- Soporte para 1000+ usuarios concurrentes
- Tiempo de respuesta < 200ms para transacciones críticas
- 99.9% de disponibilidad
- Consistencia eventual aceptable para analytics

**Entregables**:
- Arquitectura completa de base de datos multi-schema
- Implementación de transacciones críticas (checkout, payment)
- Sistema de monitoreo de concurrencia y deadlocks
- Benchmark de rendimiento bajo carga
- Plan de escalabilidad horizontal
- Documentación técnica completa

## 📊 Evaluación

### Criterios de Evaluación
- **Implementación técnica** (35%): Transacciones correctas, manejo de errores
- **Análisis de concurrencia** (25%): Identificación y solución de problemas
- **Optimización** (20%): Estrategias de rendimiento y escalabilidad
- **Testing** (15%): Pruebas exhaustivas bajo carga
- **Documentación** (5%): Claridad en explicaciones técnicas

### Rúbrica de Evaluación
| Criterio | Excelente (3) | Bueno (2) | Aceptable (1) | Insuficiente (0) |
|----------|---------------|-----------|---------------|------------------|
| **Manejo de Transacciones** | ACID completo, manejo robusto de errores | Transacciones funcionales con ACID básico | Transacciones simples que funcionan | Transacciones incorrectas o sin ACID |
| **Control de Concurrencia** | Implementa múltiples estrategias de bloqueo | Maneja niveles de aislamiento correctamente | Control básico de concurrencia | No controla concurrencia o incorrectamente |
| **Resolución de Deadlocks** | Prevención y resolución automática | Detección y manejo manual de deadlocks | Identifica deadlocks básicos | No detecta o resuelve deadlocks |
| **Testing de Carga** | Simulaciones realistas con análisis detallado | Pruebas de concurrencia funcionales | Testing básico con pocos usuarios | Sin testing de concurrencia |
| **Optimización** | Múltiples técnicas de optimización implementadas | Algunas optimizaciones efectivas | Optimizaciones básicas | Sin optimización o inefectiva |

## 🔗 Recursos Adicionales

### 📚 Lecturas Recomendadas
- "Transaction Processing" - Jim Gray & Andreas Reuter (Capítulos 1-4)
- "Database System Concepts" - Silberschatz (Capítulo 15: Concurrency Control)
- "High Performance MySQL" - Baron Schwartz (Capítulos sobre InnoDB y transacciones)

### 🎥 Videos de Apoyo
- "ACID Properties Explained" (25 min)
- "Database Concurrency Control Mechanisms" (40 min)
- "Deadlock Detection and Prevention" (30 min)
- "Optimistic vs Pessimistic Locking" (35 min)

### 🛠️ Herramientas de Testing
- Apache JMeter: Testing de carga para bases de datos
- pgbench: Benchmark específico para PostgreSQL
- MySQL stress testing tools
- Monitoring: Percona Monitoring, pg_stat_statements

### 📊 Datasets de Prueba
- TPC-C: Benchmark de procesamiento de transacciones
- TPC-H: Benchmark de consultas analíticas
- Sakila: Base de datos de ejemplo con concurrencia

## 🎯 Conexión con Siguientes Unidades
- **Unidad 5 (Procedimientos)**: Transacciones en procedimientos almacenados
- **Unidad 6 (Administración)**: Monitoreo de concurrencia en producción

---

## 📈 Indicadores de Desempeño

### Conocimientos
- Comprende propiedades ACID y su importancia
- Conoce diferentes niveles de aislamiento y su aplicación
- Entiende problemas de concurrencia y sus soluciones

### Habilidades
- Implementa transacciones robustas con manejo de errores
- Configura niveles de aislamiento apropiados
- Detecta y resuelve problemas de concurrencia

### Actitudes
- Considera concurrencia desde el diseño inicial
- Balancea consistencia con rendimiento
- Aplica testing riguroso en entornos concurrentes

## 🧪 Evaluaciones GIFT

### Ejemplo de Reactivos
```gift
::CONC-ACID-01:: ¿Cuál propiedad ACID garantiza que una transacción se ejecute completamente o no se ejecute en absoluto? {
=Atomicidad # Correcto, atomicidad significa "todo o nada"
~Consistencia # Incorrecto, consistencia mantiene reglas de integridad
~Aislamiento # Incorrecto, aislamiento previene interferencia entre transacciones
~Durabilidad # Incorrecto, durabilidad garantiza persistencia
}

::CONC-ISOLATION-02:: ¿Qué nivel de aislamiento previene dirty reads pero permite phantom reads? {
=READ COMMITTED # Correcto, READ COMMITTED previene dirty reads pero no phantom reads
~READ UNCOMMITTED # Incorrecto, permite dirty reads
~REPEATABLE READ # Incorrecto, previene dirty, non-repeatable y puede prevenir phantom reads
~SERIALIZABLE # Incorrecto, previene todos los problemas incluyendo phantom reads
}

::CONC-DEADLOCK-03:: ¿Cuál es una estrategia efectiva para prevenir deadlocks? {
=Adquirir bloqueos siempre en el mismo orden # Correcto, orden consistente previene ciclos de espera
~Usar solo bloqueos de tabla completa # Incorrecto, reduce concurrencia excesivamente
~Nunca usar transacciones largas # Incorrecto, no previene deadlocks necesariamente
~Usar solo SELECT sin bloqueos # Incorrecto, evita el problema pero no es una solución práctica
}
```

## ⚡ Simuladores de Concurrencia

### Script de Prueba: Race Condition
```sql
-- Terminal 1
BEGIN;
SELECT balance FROM accounts WHERE id = 1; -- balance = 1000
UPDATE accounts SET balance = balance - 500 WHERE id = 1;
-- DELAY (no hacer COMMIT aún)

-- Terminal 2 (ejecutar mientras Terminal 1 está en DELAY)
BEGIN;
SELECT balance FROM accounts WHERE id = 1; -- ¿Qué balance lee?
UPDATE accounts SET balance = balance - 300 WHERE id = 1;
COMMIT;

-- Terminal 1 (continuar)
COMMIT;
```

### Laboratorio Virtual: Deadlock Simulation
```sql
-- Session A
BEGIN;
UPDATE table1 SET value = 'A' WHERE id = 1;
-- Esperar 5 segundos
UPDATE table2 SET value = 'A' WHERE id = 1;
COMMIT;

-- Session B (ejecutar en paralelo)
BEGIN;
UPDATE table2 SET value = 'B' WHERE id = 1;
-- Esperar 5 segundos
UPDATE table1 SET value = 'B' WHERE id = 1; -- DEADLOCK!
COMMIT;
```
