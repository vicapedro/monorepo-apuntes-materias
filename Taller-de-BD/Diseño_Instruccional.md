# Diseño Instruccional - Taller de Base de Datos

## Datos de la Asignatura
- **Nombre**: Taller de Base de Datos
- **Carrera**: Ingeniería en Sistemas Computacionales  
- **Clave**: SCA-1025
- **SATCA**: 0-4-4
- **Modalidad**: Presencial
- **Duración**: Un semestre

## Competencia General
Implementa bases de datos para apoyar la toma de decisiones considerando las reglas de negocio.

## Objetivos Específicos por Competencia
1. **Utilizar procedimientos de instalación** de SGBD para diversas plataformas
2. **Construir esquemas de base de datos** basándose en las reglas sintácticas del DDL
3. **Construir expresiones en SQL** para resolver necesidades de recuperación de información
4. **Implementar mecanismos de seguridad básicos** mediante privilegios y roles
5. **Controlar la concurrencia** para disminuir problemas de desempeño y consistencia
6. **Aplicar SQL procedural** para automatizar reglas de negocio mediante stored procedures, functions y triggers
7. **Establecer conexiones** entre SGBD y lenguajes de programación

## Matriz de Evidencias

| Actividad | Evidencia | Ponderación | A | B | C | D | E | F | Instrumento |
|-----------|-----------|-------------|---|---|---|---|---|---|-------------|
| Laboratorios Prácticos (6 unidades) | Reportes técnicos con capturas y código SQL | 40% | 12% | 10% | 6% | 6% | 3% | 3% | Rúbrica |
| Proyecto Integrador de BD | Base de datos empresarial completa + documentación | 35% | 10% | 8% | 7% | 5% | 3% | 2% | Rúbrica |
| Exámenes Prácticos | Resolución de casos con SGBD en tiempo real | 25% | 8% | 7% | 4% | 2% | 1% | 3% | Lista de cotejo |
| **TOTAL** |  | **100%** | **30%** | **25%** | **17%** | **13%** | **7%** | **8%** |  |

**Indicadores de Impacto:**
- **A**: Adapta a situaciones complejas y contextos
- **B**: Hace contribuciones a las actividades académicas desarrolladas  
- **C**: Propone soluciones/procedimientos no vistos en clase
- **D**: Introduce recursos que promueven pensamiento crítico
- **E**: Incorpora conocimiento interdisciplinario
- **F**: Realiza trabajo autónomo y autorregulado

---

## UNIDAD 1: LENGUAJE DE DEFINICIÓN DE DATOS
**Duración**: 2 semanas | **Horas**: 16 horas

### Competencia Específica
Utilizar procedimientos de instalación de SGBD para diversas plataformas y construir esquemas de base de datos basándose en las reglas sintácticas del DDL.

### Objetivos de Aprendizaje
Al finalizar esta unidad, el estudiante será capaz de:
- Instalar y configurar diferentes SGBD (MySQL, PostgreSQL, SQL Server)
- Crear y modificar esquemas de base de datos
- Aplicar constraints e integridad referencial

### Matriz de Evidencias - Unidad 1

| Actividad | Evidencia | Ponderación | A | B | C | D | E | F | Instrumento |
|-----------|-----------|-------------|---|---|---|---|---|---|-------------|
| Laboratorio 1: Instalación SGBD | Reporte de instalación con capturas de pantalla | 30% | 10% | 5% | 5% | 5% | 2% | 3% | Lista de cotejo |
| Laboratorio 2: DDL y Constraints | Scripts SQL + esquemas creados | 40% | 12% | 8% | 6% | 4% | 2% | 8% | Rúbrica |
| Caso de Estudio Empresarial | Diseño de BD para empresa local | 30% | 8% | 12% | 6% | 4% | 1% | 4% | Rúbrica |
| **TOTAL UNIDAD 1** |  | **100%** | **30%** | **25%** | **17%** | **13%** | **5%** | **15%** |  |

### Aplicación del Modelo de Gagné

#### 1. Ganar la Atención
**Estrategia**: Caso real de migración de datos
- Mostrar el caso de una empresa que perdió información por mal diseño de BD
- Video: "Cuando las bases de datos fallan: casos reales" (5 min)
- Pregunta detonante: ¿Por qué es crítico un buen diseño de base de datos?

#### 2. Informar Objetivos
**Actividades del docente**:
- Presentar competencias específicas de la unidad
- Explicar criterios de evaluación de laboratorios
- Mostrar ejemplos de esquemas bien diseñados

**Actividades del estudiante**:
- Autoevaluación de conocimientos previos en SQL
- Establecer metas personales para el manejo de SGBD

#### 3. Estimular Conocimientos Previos
**Estrategia**: Repaso interactivo
- Quiz diagnóstico sobre fundamentos de BD
- Revisión de conceptos clave: entidades, atributos, relaciones
- Activación de conocimientos de modelado ER

#### 4. Presentar Contenido
**Metodología Activa**: Aprendizaje Basado en Problemas (ABP)
- **Problema central**: "Diseñar la BD para un sistema de gestión hospitalaria"
- **Subproblemas**:
  - ¿Qué SGBD seleccionar según el contexto?
  - ¿Cómo garantizar integridad de datos críticos?
  - ¿Cómo manejar la concurrencia en un hospital?

**Temas y subtemas**:
- 1.1 Instalación de SGBD
  - Criterios de selección de SGBD
  - Instalación en diferentes plataformas
  - Configuración inicial y herramientas
- 1.2 Creación de esquemas
  - DDL: CREATE, ALTER, DROP
  - Tipos de datos y dominios
  - Constraints e integridad referencial

#### 5. Proporcionar Orientación
**Estrategias**:
- Tutoriales paso a paso para instalación
- Plantillas de scripts SQL reutilizables
- Sesiones de resolución de problemas en grupo
- Mentoring individual durante laboratorios

#### 6. Provocar Desempeño
**Actividades formativas**:
- **Laboratorio 1**: Instalación comparativa de 3 SGBD
- **Laboratorio 2**: Creación de esquemas complejos
- **Proyecto ABP**: Diseño incremental de BD hospitalaria

#### 7. Proporcionar Retroalimentación
**Estrategias**:
- Revisión de scripts SQL con comentarios específicos
- Validación automática de constraints
- Peer review de diseños de BD
- Feedback inmediato en laboratorios

#### 8. Evaluar Desempeño
**Instrumentos**:
- **Formativa**: Checkpoints en laboratorios
- **Sumativa**: Proyecto de diseño completo (30% de calificación final)
- **Criterios**: Correctitud técnica, documentación, justificación de decisiones

#### 9. Mejorar Retención y Transferencia
**Estrategias**:
- Biblioteca de scripts reutilizables
- Conexiones con proyectos de otras materias
- Reflexión sobre aplicaciones profesionales
- Preparación para manipulación de datos

---

## UNIDAD 2: LENGUAJE DE MANIPULACIÓN DE DATOS
**Duración**: 3 semanas | **Horas**: 24 horas

### Competencia Específica
Construir expresiones en SQL para resolver necesidades de recuperación de información con las reglas sintácticas del DML.

### Objetivos de Aprendizaje
Al finalizar esta unidad, el estudiante será capaz de:
- Realizar operaciones CRUD en bases de datos
- Construir consultas complejas con joins y subconsultas
- Crear y manipular vistas

### Matriz de Evidencias - Unidad 2

| Actividad | Evidencia | Ponderación | A | B | C | D | E | F | Instrumento |
|-----------|-----------|-------------|---|---|---|---|---|---|-------------|
| Problemario SQL (50 consultas) | Scripts SQL documentados y probados | 35% | 10% | 8% | 6% | 6% | 2% | 3% | Rúbrica |
| Caso de Análisis de Ventas | Dashboard de consultas empresariales | 40% | 12% | 12% | 8% | 4% | 2% | 2% | Rúbrica |
| Examen Práctico DML | Resolución en tiempo real con SGBD | 25% | 8% | 5% | 3% | 3% | 1% | 5% | Lista de cotejo |
| **TOTAL UNIDAD 2** |  | **100%** | **30%** | **25%** | **17%** | **13%** | **5%** | **10%** |  |

### Aplicación del Modelo de Gagné

#### 1. Ganar la Atención
**Estrategia**: Desafío de análisis de datos
- Presentar dataset real de una empresa con millones de registros
- Pregunta: "¿Cómo extraer insights valiosos de esta información?"
- Demostración de consulta compleja que resuelve problema empresarial

#### 4. Presentar Contenido
**Metodología Activa**: Aprendizaje Orientado a Proyectos (AOP)
- **Proyecto central**: "Sistema de Business Intelligence para retail"
- **Entregables progresivos**:
  - Módulo de consultas básicas
  - Módulo de reportes gerenciales
  - Dashboard ejecutivo con vistas

---

## UNIDAD 3: CONTROL DE ACCESO
**Duración**: 2 semanas | **Horas**: 16 horas

### Competencia Específica
Implementar mecanismos de seguridad básicos para el acceso a datos mediante otorgamiento o denegación de privilegios.

### Matriz de Evidencias - Unidad 3

| Actividad | Evidencia | Ponderación | A | B | C | D | E | F | Instrumento |
|-----------|-----------|-------------|---|---|---|---|---|---|-------------|
| Laboratorio de Seguridad | Configuración de usuarios, roles y privilegios | 40% | 12% | 8% | 6% | 8% | 3% | 3% | Rúbrica |
| Simulacro de Auditoría | Reporte de seguridad y vulnerabilidades | 35% | 10% | 12% | 6% | 3% | 2% | 2% | Lista de cotejo |
| Políticas de Seguridad | Documento de políticas empresariales | 25% | 8% | 5% | 5% | 2% | 0% | 5% | Rúbrica |
| **TOTAL UNIDAD 3** |  | **100%** | **30%** | **25%** | **17%** | **13%** | **5%** | **10%** |  |

**Metodología Activa**: Aprendizaje Basado en Retos (ABR)
- **Reto central**: "Hackear y proteger una base de datos empresarial"
- **Fases**:
  - Identificar vulnerabilidades comunes
  - Implementar contramedidas
  - Certificar seguridad del sistema

---

## UNIDAD 4: CONCURRENCIA
**Duración**: 2 semanas | **Horas**: 16 horas

### Competencia Específica
Controlar la concurrencia de la base de datos para disminuir problemas de desempeño y/o consistencia.

### Matriz de Evidencias - Unidad 4

| Actividad | Evidencia | Ponderación | A | B | C | D | E | F | Instrumento |
|-----------|-----------|-------------|---|---|---|---|---|---|-------------|
| Simulación de Concurrencia | Scripts de transacciones y análisis de problemas | 45% | 15% | 10% | 8% | 7% | 2% | 3% | Rúbrica |
| Caso de Estudio: E-commerce | Solución a problemas de inventario concurrente | 35% | 10% | 10% | 6% | 4% | 2% | 3% | Rúbrica |
| Benchmarking de Rendimiento | Reporte comparativo de niveles de aislamiento | 20% | 5% | 5% | 3% | 2% | 1% | 4% | Lista de cotejo |
| **TOTAL UNIDAD 4** |  | **100%** | **30%** | **25%** | **17%** | **13%** | **5%** | **10%** |  |

**Metodología Activa**: Estudio de Casos
- **Casos reales**:
  - Black Friday en Amazon: manejo de inventario
  - Transferencias bancarias: consistencia crítica
  - Sistema de reservas: overbooking controlado

---

## UNIDAD 5: SQL PROCEDURAL
**Duración**: 3 semanas | **Horas**: 24 horas

### Competencia Específica
Aplicar SQL procedural para automatizar reglas de negocio y garantizar integridad, consistencia y seguridad mediante stored procedures, functions y triggers.

### Matriz de Evidencias - Unidad 5

| Actividad | Evidencia | Ponderación | A | B | C | D | E | F | Instrumento |
|-----------|-----------|-------------|---|---|---|---|---|---|-------------|
| Biblioteca de Procedimientos | Colección de SP, functions y triggers documentados | 40% | 12% | 10% | 8% | 5% | 2% | 3% | Rúbrica |
| Sistema de Auditoría | Implementación completa con triggers automáticos | 35% | 10% | 8% | 6% | 6% | 2% | 3% | Rúbrica |
| Optimización de Consultas | Análisis de performance y mejoras | 25% | 8% | 7% | 3% | 2% | 1% | 4% | Lista de cotejo |
| **TOTAL UNIDAD 5** |  | **100%** | **30%** | **25%** | **17%** | **13%** | **5%** | **10%** |  |

**Metodología Activa**: Aula Invertida
- **Pre-clase**: Videos de sintaxis y ejemplos básicos
- **En clase**: Resolución colaborativa de casos complejos
- **Post-clase**: Implementación de soluciones personalizadas

---

## UNIDAD 6: CONECTIVIDAD DE BASES DE DATOS
**Duración**: 2 semanas | **Horas**: 16 horas

### Competencia Específica
Establecer conexiones entre SGBD y lenguajes de programación mediante cadenas de conexión y protocolos de comunicación.

### Matriz de Evidencias - Unidad 6

| Actividad | Evidencia | Ponderación | A | B | C | D | E | F | Instrumento |
|-----------|-----------|-------------|---|---|---|---|---|---|-------------|
| Aplicación Web con BD | Sistema web completo con CRUD | 45% | 15% | 12% | 8% | 5% | 2% | 3% | Rúbrica |
| App Móvil con BD | Aplicación móvil conectada a BD | 35% | 10% | 8% | 6% | 5% | 2% | 4% | Rúbrica |
| API REST con BD | Servicios web para integración | 20% | 5% | 5% | 3% | 3% | 1% | 3% | Lista de cotejo |
| **TOTAL UNIDAD 6** |  | **100%** | **30%** | **25%** | **17%** | **13%** | **5%** | **10%** |  |

**Metodología Activa**: Aprendizaje Cooperativo
- **Equipos especializados**:
  - Backend Team (Python/Java)
  - Frontend Team (React/Vue)
  - Mobile Team (React Native/Flutter)
  - DevOps Team (Docker/Cloud)

---

## PROYECTO INTEGRADOR

### Objetivo
Desarrollar un sistema completo de gestión empresarial que integre todos los temas del curso.

### Características del Proyecto
- **Duración**: Todo el semestre (desarrollo incremental)
- **Modalidad**: Equipos de 4-5 estudiantes
- **Entregables**: 6 iteraciones (una por unidad)
- **Tecnologías**: Libre elección con justificación técnica

### Opciones de Proyectos (Aprendizaje Basado en Problemas)

1. **Sistema de Gestión Hospitalaria**
   - Pacientes, médicos, citas, historial médico
   - Módulos de farmacia e inventario
   - Dashboard gerencial y reportes

2. **Plataforma de E-learning**
   - Gestión de cursos, estudiantes, instructores
   - Sistema de calificaciones y progreso
   - Analytics de aprendizaje

3. **Sistema de Gestión Hotelera**
   - Reservas, huéspedes, habitaciones
   - Facturación y punto de venta
   - CRM y marketing

4. **Plataforma de E-commerce**
   - Catálogo de productos, inventario
   - Carrito de compras y pagos
   - Sistema de recomendaciones

### Evaluación del Proyecto Integrador

| Criterio | Peso | Descripción |
|----------|------|-------------|
| **Diseño de BD** | 25% | Normalización, integridad, eficiencia |
| **Implementación SQL** | 25% | Calidad de scripts, procedimientos, triggers |
| **Seguridad y Concurrencia** | 20% | Manejo de usuarios, transacciones |
| **Conectividad** | 15% | Integración con aplicaciones |
| **Documentación** | 10% | Manual técnico y de usuario |
| **Presentación** | 5% | Demo del sistema funcionando |

---

## EVALUACIÓN GENERAL DEL CURSO

### Distribución de Calificaciones

| Componente | Peso | Descripción |
|------------|------|-------------|
| **Laboratorios** | 40% | 6 laboratorios prácticos |
| **Proyecto Integrador** | 35% | Desarrollo incremental |
| **Exámenes Prácticos** | 25% | 3 exámenes con SGBD |

### Criterios de Aprobación
- **Calificación mínima**: 70/100
- **Asistencia mínima**: 85%
- **Laboratorios**: Todos deben ser aprobados
- **Proyecto**: Presentación obligatoria

---

## RECURSOS Y HERRAMIENTAS

### Software Requerido
- **SGBD**: MySQL, PostgreSQL, SQL Server
- **Herramientas**: MySQL Workbench, pgAdmin, SSMS
- **Desarrollo**: VS Code, Git, Docker
- **Lenguajes**: Python, PHP, Java, JavaScript

### Infraestructura
- **Servidor BD**: Para prácticas colaborativas
- **Laboratorio**: 30 equipos con software instalado
- **Plataforma LMS**: Moodle para entrega de trabajos
- **Repositorio**: GitHub para versionado de código

### Bibliografía Digital
- Documentación oficial de cada SGBD
- Tutoriales interactivos online
- Datasets empresariales reales para práctica
- Videos técnicos y conferencias especializadas
