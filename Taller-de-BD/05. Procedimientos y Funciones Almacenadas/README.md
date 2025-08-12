# 5. Procedimientos y Funciones Almacenadas

## 🎯 Competencia de la Unidad
**Desarrollar procedimientos almacenados, funciones y triggers para automatizar procesos de negocio, mejorar el rendimiento y mantener la integridad de los datos de forma centralizada.**

## 📋 Objetivos de Aprendizaje
Al finalizar esta unidad, el estudiante será capaz de:
- ✅ Diseñar y desarrollar procedimientos almacenados complejos
- ✅ Crear funciones personalizadas para lógica de negocio reutilizable
- ✅ Implementar triggers para automatización y validación
- ✅ Gestionar errores y excepciones en código de base de datos
- ✅ Optimizar rendimiento de procedimientos almacenados

## 🔧 Contenido Temático

### 5.1 Procedimientos Almacenados (Stored Procedures)
- **Fundamentos de procedimientos**
  - CREATE PROCEDURE sintaxis por SGBD
  - Parámetros de entrada (IN), salida (OUT) e INOUT
  - Variables locales y su scope
  - Estructuras de control: IF, CASE, LOOP, WHILE

- **Manejo de transacciones en procedimientos**
  - START TRANSACTION dentro de procedimientos
  - Control de COMMIT/ROLLBACK condicional
  - Manejo de savepoints
  - Transacciones anidadas y su comportamiento

- **Cursores para procesamiento de resultsets**
  - DECLARE CURSOR para consultas complejas
  - OPEN, FETCH, CLOSE cursors
  - Cursores READ ONLY vs FOR UPDATE
  - Optimización de cursors vs set-based operations

- **Manejo avanzado de errores**
  - DECLARE HANDLER para excepciones
  - SIGNAL/RESIGNAL para errores personalizados
  - Logging de errores personalizado
  - Rollback inteligente por tipo de error

### 5.2 Funciones Definidas por Usuario (UDF)
- **Funciones escalares**
  - RETURN tipo de dato simple
  - Funciones determinísticas vs no determinísticas
  - Funciones matemáticas, de string y fecha personalizadas
  - Performance considerations para funciones

- **Funciones de tabla (Table-Valued Functions)**
  - Inline table functions
  - Multi-statement table functions
  - Uso en JOINs y subconsultas
  - Comparación con vistas y procedimientos

- **Funciones agregadas personalizadas** (donde aplique)
  - Implementación de agregaciones complejas
  - Funciones de ventana personalizadas

### 5.3 Triggers y Automatización
- **Tipos de triggers**
  - BEFORE vs AFTER triggers
  - INSERT, UPDATE, DELETE triggers
  - INSTEAD OF triggers (para vistas)
  - DDL triggers para cambios de esquema

- **Casos de uso para triggers**
  - Auditoría automática de cambios
  - Validación de datos complejas
  - Sincronización entre tablas
  - Cálculos derivados automáticos
  - Logging y notificaciones

- **Triggers avanzados**
  - Acceso a OLD y NEW values
  - Triggers que modifican otros datos
  - Prevención de recursión infinita
  - Triggers condicionales con WHEN clause

### 5.4 Optimización y Mejores Prácticas
- **Performance tuning**
  - Análisis de planes de ejecución
  - Índices para procedimientos
  - Evitar cursores cuando sea posible
  - Recompilación y cache de planes

- **Mejores prácticas de desarrollo**
  - Nomenclatura estándar (sp_, fn_, tr_)
  - Documentación inline con comentarios
  - Versionado de procedimientos
  - Testing unitario de procedimientos
  - Code review checklist

## 📝 Actividades y Prácticas

### 🔬 Laboratorio 9: Procedimientos Almacenados Básicos
**Duración**: 4 horas  
**Modalidad**: Individual

**Objetivo**: Desarrollar procedimientos básicos con parámetros y control de flujo.

**Ejercicios Progresivos**:
1. **Calculadora Financiera**: Procedimientos para cálculo de interés compuesto, amortización, valor presente
2. **Gestión de Inventario**: Procedimientos para entrada, salida, reorden automático de productos
3. **Procesamiento de Nómina**: Cálculo de salarios con deducciones, bonificaciones y impuestos

**Entregables**:
- 10+ procedimientos almacenados con diferente complejidad
- Casos de prueba documentados para cada procedimiento
- Manejo de errores y validaciones implementado
- Documentación de parámetros y funcionamiento

### 🔬 Laboratorio 10: Funciones y Triggers
**Duración**: 4 horas  
**Modalidad**: Individual

**Objetivo**: Crear funciones reutilizables y triggers para automatización.

**Funciones a desarrollar**:
- Funciones de validación (email, teléfono, RFC/SSN)
- Funciones de cálculo de distancia geográfica
- Funciones de formato de texto personalizado
- Funciones de conversión de unidades

**Triggers a implementar**:
- Auditoría automática de cambios críticos
- Actualización de totales en tiempo real
- Validación de reglas de negocio complejas
- Sincronización con tablas relacionadas

**Entregables**:
- Librería de 15+ funciones categorizadas por tipo
- 8+ triggers para diferentes casos de uso
- Pruebas de funcionamiento con casos edge
- Documentación técnica de cada función/trigger

### ⚙️ Reto de Automatización: Sistema de Facturación
**Duración**: 12 horas  
**Modalidad**: Equipos de 3-4 personas

**Problema**: Desarrollar un sistema completo de facturación automatizada que incluya:

**Requerimientos Funcionales**:
- Generación automática de facturas mensuales
- Cálculo de impuestos por región/país
- Aplicación de descuentos por volumen y lealtad
- Generación de reportes ejecutivos automáticos
- Notificaciones por vencimiento de pagos
- Conciliación bancaria automatizada

**Requerimientos Técnicos**:
- Procedimientos modulares y reutilizables
- Manejo robusto de errores con logging detallado
- Transacciones atómicas para operaciones críticas
- Triggers para mantener consistencia de datos
- Funciones para cálculos complejos reutilizables

**Entregables**:
- Suite completa de procedimientos almacenados (20+)
- Funciones de cálculo y validación (15+)
- Triggers para automatización (10+)
- Sistema de logging y auditoría integrado
- Batería de pruebas unitarias automatizadas
- Manual de usuario técnico
- Diagrama de flujo de procesos automatizados

### 🏢 Proyecto Empresarial: ERP Modular
**Duración**: 16 horas  
**Modalidad**: Equipos de 4-5 personas

**Problema**: Diseñar el backend de base de datos para un sistema ERP que integre múltiples módulos:

**Módulos a desarrollar**:
1. **Recursos Humanos**: Gestión de empleados, nómina, evaluaciones
2. **Inventario**: Control de stock, órdenes de compra, proveedores
3. **Ventas**: CRM, cotizaciones, órdenes, facturación
4. **Contabilidad**: Asientos contables, reportes financieros, presupuestos
5. **Producción**: Órdenes de trabajo, materiales, control de calidad

**Características Técnicas Requeridas**:
- API de procedimientos almacenados para cada módulo
- Integración entre módulos mediante triggers y funciones
- Sistema de workflows automatizados
- Reportes ejecutivos generados automáticamente
- Sistema de notificaciones y alertas
- Backup y recovery procedures automatizados

**Entregables**:
- Arquitectura completa de procedimientos por módulo
- Sistema de integración entre módulos
- Documentación técnica completa (API documentation)
- Suite de testing automatizada
- Performance benchmarks
- Plan de deployment y mantenimiento
- Capacitación para desarrolladores

## 📊 Evaluación

### Criterios de Evaluación
- **Funcionalidad** (30%): Procedimientos/funciones funcionan correctamente
- **Complejidad técnica** (25%): Uso de características avanzadas del SGBD
- **Optimización** (20%): Rendimiento y eficiencia del código
- **Manejo de errores** (15%): Robustez ante excepciones
- **Documentación** (10%): Claridad y completitud de la documentación

### Rúbrica de Evaluación
| Criterio | Excelente (3) | Bueno (2) | Aceptable (1) | Insuficiente (0) |
|----------|---------------|-----------|---------------|------------------|
| **Lógica de Negocio** | Implementa reglas complejas correctamente | Lógica correcta para casos principales | Lógica básica funcional | Lógica incorrecta o incompleta |
| **Parámetros y Variables** | Uso avanzado de parámetros IN/OUT/INOUT | Manejo correcto de parámetros básicos | Parámetros simples funcionales | Mal uso de parámetros |
| **Control de Flujo** | Estructuras complejas (loops, cursors, case) | Uso correcto de IF/ELSE y estructuras básicas | Control de flujo simple | Sin control de flujo o incorrecto |
| **Manejo de Transacciones** | Transacciones complejas con savepoints | Transacciones básicas con COMMIT/ROLLBACK | Transacciones simples | Sin manejo de transacciones |
| **Triggers** | Triggers complejos sin efectos colaterales | Triggers funcionales para casos principales | Triggers básicos | Triggers incorrectos o problemáticos |
| **Performance** | Código optimizado, sin cursores innecesarios | Rendimiento aceptable | Funciona pero lento | Problemas graves de rendimiento |

## 🔗 Recursos Adicionales

### 📚 Lecturas Recomendadas
- "T-SQL Fundamentals" - Itzik Ben-Gan (Capítulos 11-13)
- "MySQL Stored Procedure Programming" - Guy Harrison
- "PostgreSQL Server Programming" - Hannu Krosing
- "Oracle PL/SQL Programming" - Steven Feuerstein

### 🎥 Videos de Apoyo
- "Stored Procedures Best Practices" (45 min)
- "Advanced Trigger Programming" (35 min)
- "Error Handling in Database Code" (30 min)
- "Performance Tuning Stored Procedures" (40 min)

### 🛠️ Herramientas de Desarrollo
- **IDEs especializados**:
  - MySQL Workbench: Editor de procedimientos MySQL
  - pgAdmin: Editor para PostgreSQL
  - SQL Server Management Studio: Para SQL Server
  - DBeaver: Multi-platform con debugging

- **Testing y Debugging**:
  - tSQLt: Framework de testing para SQL Server
  - pgTAP: Testing para PostgreSQL
  - MySQLUnit: Unit testing para MySQL

### 📋 Templates y Patrones
- Template para procedimientos con manejo de errores
- Patrón para funciones de validación
- Template para triggers de auditoría
- Patrón para procedimientos de reportes

## 🎯 Conexión con Siguientes Unidades
- **Unidad 6 (Administración)**: Deployment y mantenimiento de procedimientos

---

## 📈 Indicadores de Desempeño

### Conocimientos
- Comprende sintaxis específica de cada SGBD
- Conoce patrones de diseño para procedimientos almacenados
- Entiende optimización y tuning de código de BD

### Habilidades
- Desarrolla procedimientos modulares y reutilizables
- Implementa manejo robusto de errores
- Crea automatizaciones complejas con triggers

### Actitudes
- Aplica principios de desarrollo de software limpio
- Considera mantenibilidad y escalabilidad
- Documenta exhaustivamente el código

## 🧪 Evaluaciones GIFT

### Ejemplo de Reactivos
```gift
::PROC-PARAM-01:: ¿Cuál es la diferencia entre parámetros IN, OUT e INOUT en procedimientos almacenados? {
=IN solo recibe valores, OUT solo retorna valores, INOUT puede recibir y retornar # Correcto, define correctamente cada tipo
~Todos son sinónimos, no hay diferencia # Incorrecto, tienen comportamientos diferentes
~IN es para strings, OUT para números, INOUT para fechas # Incorrecto, no depende del tipo de dato
~Solo SQL Server soporta estos tipos de parámetros # Incorrecto, la mayoría de SGBD los soportan
}

::TRIG-TIMING-02:: ¿Cuándo se ejecuta un trigger BEFORE INSERT? {
=Antes de que la fila sea insertada en la tabla # Correcto, BEFORE significa antes de la operación
~Después de que la fila sea insertada # Incorrecto, eso sería AFTER
~Solo cuando hay errores en la inserción # Incorrecto, se ejecuta en todas las inserciones
~Una vez al día antes de cualquier INSERT # Incorrecto, se ejecuta por cada operación INSERT
}

::FUNC-DETERMINISTIC-03:: ¿Qué característica debe tener una función para ser considerada determinística? {
=Debe retornar el mismo resultado para los mismos parámetros de entrada # Correcto, define determinismo
~Debe ejecutarse rápidamente # Incorrecto, velocidad no define determinismo
~Debe usar solo operaciones matemáticas # Incorrecto, puede usar cualquier operación consistente
~Debe tener parámetros de salida # Incorrecto, determinismo no depende de parámetros de salida
}
```

## 💡 Casos de Estudio Avanzados

### Caso 1: Sistema de Reservas de Aerolínea
**Challenge**: Implementar lógica de overbooking inteligente
- Procedimiento que calcula probabilidad de no-show por ruta
- Función que determina nivel óptimo de overbooking
- Triggers que manejan lista de espera automáticamente

### Caso 2: Trading System en Tiempo Real
**Challenge**: Procesamiento de órdenes de compra/venta
- Procedimientos para matching de órdenes
- Funciones de cálculo de precios en tiempo real
- Triggers para stop-loss automático

### Caso 3: Sistema de Recomendaciones
**Challenge**: E-commerce con recomendaciones personalizadas
- Funciones de scoring basadas en comportamiento
- Procedimientos de actualización de perfiles en batch
- Triggers para captura de eventos de usuario
