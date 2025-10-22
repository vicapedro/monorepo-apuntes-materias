# Práctica 1: Conociendo MS Management Studio

## Objetivo
**Duración estimada:** 2 horas

Familiarizar al estudiante con Microsoft SQL Server Management Studio (SSMS), explorando su interfaz, estableciendo conexiones a bases de datos y ejecutando scripts básicos de DDL.

## Competencias a desarrollar
- Identifica y utiliza los elementos principales de la interfaz de SSMS
- Establece conexiones a instancias locales de SQL Server
- Explora y comprende el propósito de las bases de datos del sistema
- Ejecuta scripts básicos para crear bases de datos y tablas

## Introducción

Microsoft SQL Server Management Studio (SSMS) es una herramienta gráfica integral que permite gestionar y administrar instancias de SQL Server. Proporciona una interfaz intuitiva para ejecutar consultas, administrar bases de datos, configurar seguridad y realizar tareas de mantenimiento.

SSMS es fundamental para cualquier administrador de bases de datos o desarrollador que trabaje con SQL Server, ya que centraliza todas las operaciones necesarias para el manejo eficiente de datos empresariales.

## Equipo de protección e higiene
- Mantener el área de trabajo limpia y ordenada
- Verificar que los cables de alimentación estén en buen estado
- No consumir alimentos cerca del equipo

## Material y equipo necesario

### Materiales e insumos
- Manual de usuario de SSMS (digital)
- Libreta para anotaciones
- USB para respaldo de scripts

### Equipo de laboratorio
- Computadora con Windows 10/11
- SQL Server 2019/2022 (Developer o Express Edition)
- SQL Server Management Studio 19.x o superior
- Mínimo 4 GB RAM, 8 GB recomendado

### Herramientas
- Editor de texto alternativo (Notepad++)
- Navegador web para consulta de documentación

## Instrucciones

### Parte 1: Explorando la interfaz de SSMS (30 minutos)

#### 1.1 Iniciando SSMS
1. **Abrir SSMS**: Busca "SQL Server Management Studio" en el menú inicio y ábrelo
2. **Conexión inicial**: Se mostrará el diálogo "Connect to Server"
   - **Server type**: Database Engine
   - **Server name**: `(local)` o `localhost` o `.\SQLEXPRESS`
   - **Authentication**: Windows Authentication (por defecto)
   - Haz clic en **Connect**

#### 1.2 Identificando elementos de la interfaz
Una vez conectado, identifica y anota la función de cada elemento:

**📊 Explorar componentes principales:**
- **Object Explorer** (panel izquierdo): Navegación jerárquica de objetos
- **Query Editor** (panel central): Editor de consultas SQL
- **Results panel** (panel inferior): Resultados de consultas
- **Properties Window** (panel derecho): Propiedades del objeto seleccionado
- **Solution Explorer**: Gestión de proyectos y scripts

**🔍 Barras de herramientas:**
- **Standard toolbar**: Operaciones básicas (New Query, Open, Save, Execute)
- **SQL Editor toolbar**: Herramientas específicas para consultas
- **Menu Bar**: Acceso completo a todas las funcionalidades

**📝 Actividad:** Toma una captura de pantalla de la interfaz completa y etiqueta cada componente mencionado.

### Parte 2: Explorando las bases de datos del sistema (30 minutos)

#### 2.1 Navegando en Object Explorer
1. **Expandir el servidor**: En Object Explorer, expande tu instancia de servidor
2. **Explorar Databases**: Expande la carpeta "Databases"

#### 2.2 Bases de datos del sistema
Explora cada una de las siguientes bases de datos del sistema y anota su propósito:

**🗄️ System Databases:**
- **master**: Base de datos principal del sistema
  - Contiene información de configuración del servidor
  - Almacena metadatos de todas las bases de datos
  - **Ubicación**: C:\Program Files\Microsoft SQL Server\...\DATA\master.mdf

- **model**: Plantilla para nuevas bases de datos
  - Cualquier objeto creado aquí se replica en nuevas BD
  - Define configuraciones predeterminadas
  - **Uso**: Personalización de nuevas bases de datos

- **msdb**: Base de datos del SQL Server Agent
  - Almacena trabajos programados (jobs)
  - Historial de respaldos y restauraciones
  - **Función**: Automatización y mantenimiento

- **tempdb**: Base de datos temporal
  - Almacena objetos temporales y resultados intermedios
  - Se recrea cada vez que se inicia SQL Server
  - **Característica**: Volátil, no persistente

#### 2.3 Explorando contenido de las bases de datos
1. **Expandir master**: 
   - Ve a Tables → System Tables
   - Observa tablas como `sys.databases`, `sys.tables`
2. **Expandir msdb**:
   - Ve a Tables → dbo.backupset (historial de respaldos)
   - Observa la estructura de trabajos programados

**📝 Actividad:** Documenta el propósito de cada base de datos del sistema y toma capturas de pantalla mostrando su contenido.

### Parte 3: Creando scripts básicos (45 minutos)

#### 3.1 Preparando el Query Editor
1. **Nuevo Query**: Haz clic en "New Query" o presiona Ctrl+N
2. **Verificar conexión**: Confirma que estás conectado a tu instancia local
3. **Configurar editor**: Habilita numeración de líneas (Tools → Options → Text Editor → Transact-SQL → General → Line numbers)

#### 3.2 Script completo para la práctica
Copia y ejecuta el siguiente script paso a paso:

```sql
-- =============================================
-- Práctica 1: Conociendo SSMS
-- Creación de base de datos y tabla básica
-- Fecha: [Tu nombre y fecha]
-- =============================================

-- Paso 1: Crear la base de datos
USE master;
GO

-- Verificar si la base de datos existe y eliminarla si es necesario
IF EXISTS (SELECT name FROM sys.databases WHERE name = 'PracticaSSMS')
BEGIN
    DROP DATABASE PracticaSSMS;
    PRINT 'Base de datos PracticaSSMS eliminada';
END
GO

-- Crear nueva base de datos
CREATE DATABASE PracticaSSMS
ON 
( 
    NAME = 'PracticaSSMS_Data',
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\PracticaSSMS.mdf',
    SIZE = 100MB,
    MAXSIZE = 500MB,
    FILEGROWTH = 10MB 
)
LOG ON 
( 
    NAME = 'PracticaSSMS_Log',
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\PracticaSSMS.ldf',
    SIZE = 10MB,
    MAXSIZE = 100MB,
    FILEGROWTH = 5MB 
);
GO

PRINT 'Base de datos PracticaSSMS creada exitosamente';
GO

-- Paso 2: Cambiar a la nueva base de datos
USE PracticaSSMS;
GO

PRINT 'Conectado a la base de datos PracticaSSMS';
GO

-- Paso 3: Crear la tabla Persona
CREATE TABLE Persona (
    PersonaID INT IDENTITY(1,1) PRIMARY KEY,
    Nombre NVARCHAR(100) NOT NULL,
    Direccion NVARCHAR(200),
    Telefono NVARCHAR(15)
);
GO

PRINT 'Tabla Persona creada exitosamente';
GO

-- Paso 4: Insertar datos de prueba
INSERT INTO Persona (Nombre, Direccion, Telefono) VALUES
('Juan Pérez', 'Av. Principal 123, Col. Centro', '555-0101'),
('María García', 'Calle Secundaria 456, Col. Norte', '555-0102'),
('Carlos López', 'Blvd. Universidad 789, Col. Sur', '555-0103');
GO

PRINT 'Datos de prueba insertados';
GO

-- Paso 5: Verificar la creación
SELECT * FROM Persona;
GO

-- Paso 6: Mostrar información de la tabla
SELECT 
    COLUMN_NAME,
    DATA_TYPE,
    IS_NULLABLE,
    CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'Persona';
GO
```

#### 3.3 Ejecutando el script paso a paso
1. **Seleccionar secciones**: Selecciona cada bloque de código (separado por GO) y ejecuta con F5
2. **Verificar resultados**: Observa los mensajes en la ventana "Messages"
3. **Revisar Object Explorer**: Actualiza (F5) y verifica que aparezca la nueva base de datos

#### 3.4 Explorando los resultados
1. **En Object Explorer**: 
   - Expande "PracticaSSMS" → "Tables" → "dbo.Persona"
   - Haz clic derecho → "Select Top 1000 Rows"
2. **Verificar estructura**:
   - Expande "Columns" bajo la tabla Persona
   - Observa los tipos de datos y restricciones

### Parte 4: Documentación y análisis (15 minutos)

#### 4.1 Generando script de la base de datos
1. **Generate Scripts Wizard**:
   - Clic derecho en "PracticaSSMS" → Tasks → Generate Scripts
   - Sigue el asistente para generar el script DDL completo
   - Guarda el script como "PracticaSSMS_DDL.sql"

#### 4.2 Verificación final
Ejecuta las siguientes consultas para documentar tu trabajo:

```sql
-- Información de la base de datos
SELECT 
    name AS 'Database Name',
    database_id,
    create_date,
    collation_name
FROM sys.databases 
WHERE name = 'PracticaSSMS';

-- Información de la tabla
SELECT 
    TABLE_NAME,
    TABLE_TYPE,
    TABLE_CATALOG
FROM INFORMATION_SCHEMA.TABLES 
WHERE TABLE_CATALOG = 'PracticaSSMS';

-- Conteo de registros
SELECT COUNT(*) AS 'Total Personas' FROM Persona;
```

## Entregables

### 📋 Evidencias requeridas:
1. **Capturas de pantalla**:
   - Interfaz completa de SSMS con componentes etiquetados
   - Object Explorer mostrando bases de datos del sistema
   - Resultado de la consulta SELECT * FROM Persona
   - Ventana de propiedades de la tabla Persona

2. **Archivos de script**:
   - Script completo ejecutado (con comentarios personalizados)
   - Script DDL generado por el wizard
   - Archivo de texto con observaciones sobre las bases de datos del sistema

3. **Documento de análisis**:
   - Comparación entre las bases de datos del sistema
   - Reflexión sobre la utilidad de SSMS vs. línea de comandos
   - Propuesta de mejoras a la tabla Persona

## Criterios de evaluación

| **Criterio** | **Excelente (3)** | **Bueno (2)** | **Aceptable (1)** | **Insuficiente (0)** |
|--------------|-------------------|----------------|-------------------|----------------------|
| **Identificación de interfaz** | Identifica y explica todos los componentes | Identifica la mayoría de componentes | Identifica componentes básicos | No identifica componentes |
| **Exploración de BD sistema** | Explica propósito y uso de todas las BD | Explica la mayoría correctamente | Explica algunas BD del sistema | No explica las BD del sistema |
| **Ejecución de scripts** | Script ejecuta sin errores, resultados correctos | Script ejecuta con errores menores | Script ejecuta parcialmente | Script no ejecuta |
| **Documentación** | Documentación completa y reflexiva | Documentación adecuada | Documentación básica | Sin documentación |

## Notas

### 🚨 Consideraciones importantes:
- **Rutas de archivos**: Ajusta las rutas según tu instalación de SQL Server
- **Permisos**: Asegúrate de tener permisos de administrador para crear bases de datos
- **Versiones**: Los comandos pueden variar ligeramente entre versiones de SQL Server

### 💡 Extensiones opcionales:
- Explora las opciones de configuración en Tools → Options
- Prueba diferentes temas de color para el editor
- Configura atajos de teclado personalizados
- Investiga las plantillas de código disponibles

### 🔧 Troubleshooting común:
- **Error de conexión**: Verificar que SQL Server esté ejecutándose en Services
- **Permisos insuficientes**: Ejecutar SSMS como administrador
- **Ruta de archivos**: Verificar la ruta de instalación de SQL Server

**¿Problemas con la práctica?** Consulta con el instructor o revisa la documentación oficial de Microsoft SQL Server.

