# 1. Lenguaje de Definición de Datos (DDL)

## 🎯 Competencia de la Unidad
**Utilizar procedimientos de instalación de SGBD para diversas plataformas y construir esquemas de base de datos basándose en las reglas sintácticas del DDL.**

## 📋 Objetivos de Aprendizaje
Al finalizar esta unidad, el estudiante será capaz de:
- ✅ Instalar y configurar diferentes SGBD (MySQL, PostgreSQL, SQL Server)
- ✅ Crear y modificar esquemas de base de datos
- ✅ Aplicar constraints e integridad referencial
- ✅ Documentar el diseño de bases de datos

## 🔧 Contenido Temático

### 1.1 Instalación de SGBD
- **Criterios de selección de SGBD**
  - Factores técnicos y empresariales
  - Comparativa MySQL vs PostgreSQL vs SQL Server
  - Licenciamiento y costos

- **Instalación en diferentes plataformas**
  - Windows: SQL Server, MySQL, PostgreSQL
  - Linux: MySQL, PostgreSQL, MariaDB
  - Docker: Contenedores para desarrollo

- **Configuración inicial y herramientas**
  - Configuración de memoria y rendimiento
  - Herramientas de administración (Workbench, pgAdmin, SSMS)
  - Configuración de seguridad básica

### 1.2 Creación de Esquemas de Base de Datos
- **Lenguaje DDL fundamental**
  - CREATE DATABASE/SCHEMA
  - CREATE TABLE con tipos de datos
  - ALTER TABLE para modificaciones
  - DROP statements

- **Tipos de datos y dominios**
  - Numéricos: INT, DECIMAL, FLOAT
  - Cadenas: VARCHAR, CHAR, TEXT
  - Fechas: DATE, DATETIME, TIMESTAMP
  - Especiales: BOOLEAN, JSON, BLOB

- **Constraints e integridad referencial**
  - PRIMARY KEY y UNIQUE
  - FOREIGN KEY y relaciones
  - CHECK constraints
  - NOT NULL y DEFAULT
  - Índices básicos

## 📝 Actividades y Prácticas

### 🔬 Laboratorio 1: Instalación Comparativa de SGBD
**Duración**: 4 horas  
**Modalidad**: Individual

**Objetivo**: Instalar y comparar 3 SGBD diferentes evaluando sus características.

**Entregables**:
- Reporte de instalación con capturas de pantalla
- Tabla comparativa de características
- Configuración básica documentada

### 🔬 Laboratorio 2: DDL y Constraints
**Duración**: 4 horas  
**Modalidad**: Individual

**Objetivo**: Crear esquemas complejos aplicando constraints e integridad referencial.

**Entregables**:
- Scripts SQL completos y comentados
- Diagramas ER de los esquemas creados
- Validación de constraints con datos de prueba

### 🏢 Caso de Estudio Empresarial: Sistema Hospitalario
**Duración**: 8 horas  
**Modalidad**: Equipos de 3-4 personas

**Problema**: Diseñar la base de datos para un sistema de gestión hospitalaria que incluya:
- Gestión de pacientes y expedientes médicos
- Programación de citas y consultas
- Control de inventario de medicamentos
- Administración de personal médico

**Entregables**:
- Modelo ER completo
- Scripts DDL para toda la base de datos
- Documentación técnica del diseño
- Diccionario de datos

## 📊 Evaluación

### Criterios de Evaluación
- **Correctitud técnica** (40%): Scripts sin errores, constraints funcionando
- **Documentación** (25%): Comentarios claros, diagramas precisos
- **Diseño** (20%): Normalización, eficiencia, escalabilidad
- **Innovación** (15%): Soluciones creativas, uso de características avanzadas

### Rúbrica de Evaluación
| Criterio | Excelente (3) | Bueno (2) | Aceptable (1) | Insuficiente (0) |
|----------|---------------|-----------|---------------|------------------|
| **Scripts DDL** | Scripts perfectos, sin errores, bien estructurados | Scripts funcionales con errores menores | Scripts básicos que funcionan parcialmente | Scripts con errores graves o no funcionales |
| **Constraints** | Todas las restricciones implementadas correctamente | Mayoría de restricciones correctas | Algunas restricciones básicas | Sin restricciones o incorrectas |
| **Documentación** | Documentación completa y profesional | Documentación adecuada | Documentación básica | Sin documentación o deficiente |
| **Diseño ER** | Modelo ER completo, normalizado y eficiente | Modelo correcto con aspectos menores | Modelo básico funcional | Modelo incorrecto o incompleto |

## 🔗 Recursos Adicionales

### 📚 Lecturas Recomendadas
- Capítulo 3: "DDL y Esquemas" - Elmasri & Navathe
- Documentación oficial de MySQL: CREATE TABLE
- Guía de mejores prácticas de PostgreSQL

### 🎥 Videos de Apoyo
- "Instalación de MySQL en diferentes SO" (15 min)
- "Constraints avanzados en SQL Server" (20 min)
- "Modelado ER para principiantes" (30 min)

### 🛠️ Herramientas Útiles
- MySQL Workbench: Diseño visual de esquemas
- draw.io: Creación de diagramas ER
- DBeaver: Cliente universal para BD

## 🎯 Conexión con Siguientes Unidades
- **Unidad 2 (DML)**: Los esquemas creados serán poblados con datos
- **Unidad 3 (Seguridad)**: Se aplicarán permisos sobre los objetos creados
- **Unidad 4 (Concurrencia)**: Se probarán transacciones sobre estas estructuras

---

## 📈 Indicadores de Desempeño

### Conocimientos
- Identifica diferentes tipos de SGBD y sus características
- Comprende la sintaxis DDL de diferentes motores
- Conoce los tipos de datos y su uso apropiado

### Habilidades
- Instala y configura SGBD en diferentes plataformas
- Crea esquemas de BD siguiendo mejores prácticas
- Implementa constraints e integridad referencial

### Actitudes
- Documenta sistemáticamente su trabajo
- Busca soluciones innovadoras a problemas de diseño
- Trabaja colaborativamente en equipos técnicos
