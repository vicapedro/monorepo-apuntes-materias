# Planeación de Prácticas de Laboratorio - Taller de Base de Datos

**Fecha:** Celaya, Guanajuato a 12 de agosto de 2025

**Para:** C. [Nombre del Jefe de Laboratorio]  
**Jefe(a) de Laboratorio de:** Laboratorio de Sistemas Computacionales  
**Presente**

Con base a lo establecido por el Departamento de Sistemas y Computación con base a la planeación del curso, anexo la relación de prácticas de Laboratorio, así como las fechas tentativas a efectuarse durante el semestre Agosto - Diciembre 2025.

---

## 📋 Información General

| **Campo** | **Información** |
|-----------|-----------------|
| **Materia** | Taller de Base de Datos |
| **Carrera** | Ingeniería en Sistemas Computacionales |
| **Clave** | SCA-1025 |
| **Horario** | [A definir según grupo] |
| **Grupo** | [A definir] |
| **Semestre** | Agosto - Diciembre 2025 |
| **SATCA** | 0-4-4 (4 horas de laboratorio semanales) |

---

## 🔬 Relación de Prácticas Programadas

| **No.** | **Nombre de la Práctica** | **Fecha Tentativa** | **Unidad** | **Necesidades/Recursos** |
|---------|---------------------------|---------------------|------------|---------------------------|
| 1 | Instalación y Configuración de SGBD | Semana 1 (19-23 ago) | Unidad 1 | MySQL Server 8.0, PostgreSQL 15, SQL Server Express, equipos con 8GB RAM mínimo |
| 2 | Creación de Esquemas con DDL | Semana 2 (26-30 ago) | Unidad 1 | SGBD instalados, MySQL Workbench, pgAdmin 4, SSMS |
| 3 | Aplicación de Constraints e Integridad Referencial | Semana 3 (2-6 sep) | Unidad 1 | Herramientas de administración de BD, datasets empresariales |
| 4 | Operaciones DML Básicas (INSERT, UPDATE, DELETE) | Semana 4 (9-13 sep) | Unidad 2 | SGBD configurados, scripts de datos de prueba |
| 5 | Consultas SQL Básicas e Intermedias | Semana 5 (16-20 sep) | Unidad 2 | Base de datos con datos empresariales, problemario de consultas |
| 6 | Joins, Subconsultas y Operadores SET | Semana 6 (23-27 sep) | Unidad 2 | BD relacionales complejas, casos de estudio |
| 7 | Creación y Gestión de Vistas | Semana 7 (30 sep-4 oct) | Unidad 2 | SGBD con permisos de administración |
| 8 | Gestión de Usuarios y Roles | Semana 8 (7-11 oct) | Unidad 3 | SGBD con privilegios administrativos, documentación de políticas |
| 9 | Implementación de Políticas de Seguridad | Semana 9 (14-18 oct) | Unidad 3 | Herramientas de auditoría, certificados SSL |
| 10 | Transacciones y Propiedades ACID | Semana 10 (21-25 oct) | Unidad 4 | SGBD con soporte transaccional, scripts de prueba de concurrencia |
| 11 | Niveles de Aislamiento y Control de Concurrencia | Semana 11 (28 oct-1 nov) | Unidad 4 | Múltiples sesiones de BD, herramientas de monitoreo |
| 12 | Desarrollo de Stored Procedures | Semana 12 (4-8 nov) | Unidad 5 | SGBD con soporte PL/SQL o T-SQL, IDEs especializados |
| 13 | Creación de Functions (UDF) | Semana 13 (11-15 nov) | Unidad 5 | Herramientas de desarrollo SQL, librerías de funciones |
| 14 | Implementación de Triggers y Automatización | Semana 14 (18-22 nov) | Unidad 5 | SGBD con soporte completo de triggers, casos de auditoría |
| 15 | Conectividad ODBC/JDBC/ADO.NET | Semana 15 (25-29 nov) | Unidad 6 | JDK 11+, Visual Studio/VS Code, drivers de conectividad |
| 16 | Desarrollo de Aplicaciones con BD | Semana 16 (2-6 dic) | Unidad 6 | Entornos de desarrollo (Java/C#/Python), frameworks web |

---

## 🎯 Competencias a Desarrollar por Unidad

### **Unidad 1: Lenguaje de Definición de Datos**
- Utilizar procedimientos de instalación de SGBD para diversas plataformas
- Construir esquemas de base de datos basándose en las reglas sintácticas del DDL
- Aplicar constraints e integridad referencial en el diseño de bases de datos

### **Unidad 2: Lenguaje de Manipulación de Datos**
- Construir expresiones en SQL para resolver necesidades de recuperación de información
- Dominar técnicas de consulta avanzadas (joins, subconsultas, operadores SET)
- Crear y gestionar vistas para optimizar el acceso a datos

### **Unidad 3: Control de Acceso**
- Implementar mecanismos de seguridad básicos mediante privilegios y roles
- Establecer políticas de seguridad integral en sistemas de base de datos
- Gestionar usuarios y permisos según principios de menor privilegio

### **Unidad 4: Concurrencia**
- Controlar la concurrencia para disminuir problemas de desempeño y consistencia
- Aplicar propiedades ACID en transacciones complejas
- Configurar niveles de aislamiento apropiados según el contexto empresarial

### **Unidad 5: SQL Procedural**
- Aplicar SQL procedural para automatizar reglas de negocio
- Desarrollar stored procedures, functions y triggers eficientes
- Implementar lógica empresarial directamente en el SGBD

### **Unidad 6: Conectividad de Bases de Datos**
- Establecer conexiones entre SGBD y lenguajes de programación
- Desarrollar aplicaciones que integren bases de datos de manera efectiva
- Implementar patrones de acceso a datos seguros y eficientes

---

## 💻 Especificaciones Técnicas Detalladas

### **Requerimientos de Hardware por Estación:**
- **Procesador**: Intel Core i5 o AMD equivalente (mínimo)
- **Memoria RAM**: 8 GB mínimo, 16 GB recomendado
- **Almacenamiento**: 50 GB de espacio libre en disco
- **Sistema Operativo**: Windows 10/11 o Ubuntu 20.04 LTS
- **Conectividad**: Red Ethernet o Wi-Fi estable

### **Software Base Requerido:**
- **MySQL Server 8.0** con MySQL Workbench
- **PostgreSQL 15** con pgAdmin 4
- **Microsoft SQL Server Express 2022** con SQL Server Management Studio
- **DBeaver Community** (cliente universal de BD)
- **Visual Studio Code** con extensiones SQL

### **Herramientas de Desarrollo (Unidad 6):**
- **Java Development Kit (JDK) 11+**
- **Python 3.9+** con pip package manager
- **Microsoft Visual Studio Community** o **Visual Studio Code**
- **Node.js LTS** (para desarrollo web opcional)

### **Librerías de Conectividad:**
- **JDBC drivers** para MySQL, PostgreSQL, SQL Server
- **Python**: psycopg2, mysql-connector-python, pyodbc
- **C#**: ADO.NET Entity Framework Core
- **Java**: JDBC, Hibernate (opcional)

### **Datasets y Materiales:**
- **Base de datos empresarial** simulada (hospital, universidad, empresa)
- **Scripts de inicialización** con datos de prueba
- **Problemarios** con casos de estudio reales
- **Plantillas de documentación** técnica

---

## 🕐 Distribución Horaria por Práctica

| **Práctica** | **Duración** | **Distribución** |
|--------------|--------------|------------------|
| **Prácticas 1-3, 12-14** | **4 horas** | Instalación/Configuración complejas |
| **Prácticas 4-11, 15-16** | **4 horas** | Desarrollo y programación |
| **Evaluaciones parciales** | **Integradas** | Durante semanas 6, 10 y 14 |
| **Proyecto final** | **Presentación** | Semana 16 (2 horas adicionales) |

### **Estructura Típica de Sesión (4 horas):**
1. **Introducción teórica** (30 min)
2. **Demostración del instructor** (30 min)
3. **Práctica guiada** (90 min)
4. **Trabajo independiente** (90 min)
5. **Evaluación y cierre** (30 min)

---

## 📊 Sistema de Evaluación y Seguimiento

### **Modalidades de Evaluación:**
- **Práctica individual**: 70% de las prácticas
- **Trabajo en equipos**: 30% de las prácticas (máximo 3 personas)
- **Proyecto integrador final**: Individual obligatorio

### **Criterios de Calificación:**
- **Funcionalidad técnica** (40%)
- **Calidad del código/diseño** (25%)
- **Documentación y reportes** (20%)
- **Innovación y creatividad** (15%)

### **Instrumentos de Evaluación:**
- **Rúbricas analíticas** para proyectos complejos
- **Listas de cotejo** para verificación funcional
- **Portafolio digital** con evidencias y reflexiones
- **Exámenes prácticos** en laboratorio

---

En espera de haber cumplido con las expectativas propuestas, quedo de usted.

**ATENTAMENTE**

**[Nombre del Docente]**  
**NOMBRE Y FIRMA**
