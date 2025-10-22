# Práctica de Laboratorio 1: Instalación Comparativa de SGBD

## Objetivo
**Duración estimada**: 4 horas

Instalar y configurar tres diferentes Sistemas Gestores de Base de Datos (MySQL, PostgreSQL y SQL Server) en diferentes plataformas, comparando sus características técnicas, rendimiento inicial y facilidad de administración.

## Competencias a Desarrollar
- Instala y configura SGBD en diferentes sistemas operativos
- Compara características técnicas de diferentes motores de BD
- Evalúa criterios de selección para contextos empresariales específicos
- Documenta procedimientos técnicos de instalación

## Introducción

En el entorno empresarial actual, la selección del SGBD apropiado es una decisión estratégica que impacta el rendimiento, escalabilidad y costos operacionales de los sistemas de información. Esta práctica te permitirá experimentar directamente con los tres SGBD más utilizados en la industria.

### Contexto Empresarial
Una consultora de TI ha sido contratada para evaluar opciones de SGBD para tres clientes diferentes:
- **Startup tecnológica** con presupuesto limitado
- **Hospital regional** con datos críticos y alta disponibilidad
- **Empresa de retail** con transacciones masivas

## Equipo de Protección e Higiene
- Respaldo de información importante antes de instalar software
- Verificar espacio en disco suficiente (mínimo 10 GB disponibles)
- Conexión a internet estable para descargas

## Material y Equipo Necesario

### Materiales e Insumos
- Archivos de instalación descargados (se proporcionan enlaces)
- Documentación oficial de cada SGBD
- Dataset de prueba (northwind, sakila)
- Templates de configuración básica

### Equipo de Laboratorio
- **Opción 1 - Instalación Local**:
  - Computadora con Windows 10/11 o Linux Ubuntu 20.04+
  - RAM mínima: 8 GB (recomendado: 16 GB)
  - Procesador: Core i5 o equivalente
  - Espacio en disco: 15 GB libres

- **Opción 2 - Virtualización**:
  - VirtualBox o VMware Workstation
  - 3 VMs con 2 GB RAM cada una
  - Ubuntu Server 20.04 LTS (imagen ISO)

- **Opción 3 - Contenedores Docker** (Avanzada):
  - Docker Desktop instalado
  - Conocimiento básico de comandos Docker

### Herramientas
- Navegador web actualizado
- Editor de texto avanzado (VS Code, Sublime Text)
- Cliente SSH (para acceso remoto si aplica)
- Herramienta de medición de tiempo (cronómetro)

## Instrucciones

### Fase 1: Preparación del Ambiente (30 minutos)

#### Paso 1.1: Verificación de Prerrequisitos
Ejecuta estos comandos para verificar tu sistema:

**En Windows:**
```cmd
systeminfo | findstr "Total Physical Memory"
wmic logicaldisk get size,freespace,caption
```

**En Linux:**
```bash
free -h
df -h
lscpu | grep "Model name"
```

#### Paso 1.2: Creación de Directorios de Trabajo
```bash
# Linux/Mac
mkdir -p ~/sgbd-lab/{mysql,postgresql,sqlserver}/{config,data,logs,scripts}

# Windows (PowerShell)
New-Item -ItemType Directory -Path "C:\SGBD-Lab\MySQL\Config" -Force
New-Item -ItemType Directory -Path "C:\SGBD-Lab\PostgreSQL\Config" -Force  
New-Item -ItemType Directory -Path "C:\SGBD-Lab\SQLServer\Config" -Force
```

#### Paso 1.3: Descarga de Instaladores
| SGBD | Fuente | Versión | Tamaño Aprox. |
|------|--------|---------|---------------|
| MySQL | https://dev.mysql.com/downloads/mysql/ | 8.0.35 | 300 MB |
| PostgreSQL | https://www.postgresql.org/download/ | 15.4 | 250 MB |
| SQL Server | https://www.microsoft.com/sql-server/sql-server-downloads | 2022 Express | 1.5 GB |

⏱️ **Tiempo estimado de descarga**: 20-45 minutos según conexión

### Fase 2: Instalación de MySQL (45 minutos)

#### Paso 2.1: Instalación en Windows
```cmd
# Ejecutar instalador MySQL-installer-community-8.0.35.0.msi
# Configuración recomendada:
# - Setup Type: Developer Default
# - Root Password: MySQLRoot2025!
# - Usuario adicional: dbuser / DbUser2025!
```

#### Paso 2.2: Instalación en Linux (Ubuntu)
```bash
# Actualizar repositorios
sudo apt update && sudo apt upgrade -y

# Instalar MySQL Server
sudo apt install mysql-server -y

# Verificar instalación
sudo systemctl status mysql

# Configuración segura
sudo mysql_secure_installation
# Root password: MySQLRoot2025!
# Remove anonymous users: Y
# Disallow root login remotely: N
# Remove test database: Y
# Reload privilege tables: Y
```

#### Paso 2.3: Configuración Inicial
```sql
-- Conectar como root
mysql -u root -p

-- Crear usuario de trabajo
CREATE USER 'labuser'@'localhost' IDENTIFIED BY 'LabUser2025!';
CREATE USER 'labuser'@'%' IDENTIFIED BY 'LabUser2025!';

-- Otorgar privilegios
GRANT ALL PRIVILEGES ON *.* TO 'labuser'@'localhost' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON *.* TO 'labuser'@'%' WITH GRANT OPTION;

-- Crear base de datos de prueba
CREATE DATABASE laboratorio_mysql;
FLUSH PRIVILEGES;

-- Verificar configuración
SHOW VARIABLES LIKE 'version';
SHOW VARIABLES LIKE 'port';
SHOW VARIABLES LIKE 'socket';
```

#### Paso 2.4: Instalación de MySQL Workbench
- Descargar desde: https://dev.mysql.com/downloads/workbench/
- Crear conexión de prueba
- Verificar conectividad

⏱️ **Checkpoint**: Documentar tiempo total de instalación MySQL: _____ minutos

### Fase 3: Instalación de PostgreSQL (45 minutos)

#### Paso 3.1: Instalación en Windows
```cmd
# Ejecutar postgresql-15.4-1-windows-x64.exe
# Configuración recomendada:
# - Installation Directory: C:\Program Files\PostgreSQL\15
# - Data Directory: C:\Program Files\PostgreSQL\15\data
# - Password for superuser (postgres): PostgresRoot2025!
# - Port: 5432
# - Locale: Spanish, Mexico
```

#### Paso 3.2: Instalación en Linux
```bash
# Instalar PostgreSQL
sudo apt install postgresql postgresql-contrib -y

# Verificar instalación
sudo systemctl status postgresql

# Configurar password para postgres
sudo -u postgres psql -c "ALTER USER postgres PASSWORD 'PostgresRoot2025!';"

# Habilitar conexiones externas (si es necesario)
sudo nano /etc/postgresql/15/main/postgresql.conf
# Descomentar y cambiar: listen_addresses = '*'

sudo nano /etc/postgresql/15/main/pg_hba.conf
# Agregar línea: host all all 0.0.0.0/0 md5

sudo systemctl restart postgresql
```

#### Paso 3.3: Configuración Inicial
```sql
-- Conectar como postgres
psql -U postgres -h localhost

-- Crear usuario de trabajo
CREATE USER labuser WITH PASSWORD 'LabUser2025!';
ALTER USER labuser CREATEDB;

-- Crear base de datos de prueba
CREATE DATABASE laboratorio_postgresql OWNER labuser;

-- Verificar configuración
SELECT version();
SHOW port;
\l  -- Listar bases de datos
\du -- Listar usuarios
```

#### Paso 3.4: Instalación de pgAdmin
- Descargar desde: https://www.pgadmin.org/download/
- Configurar servidor local
- Probar conexión

⏱️ **Checkpoint**: Documentar tiempo total de instalación PostgreSQL: _____ minutos

### Fase 4: Instalación de SQL Server (60 minutos)

#### Paso 4.1: Instalación en Windows
```cmd
# Ejecutar SQL2022-SSEI-Expr.exe
# Seleccionar: Custom Installation
# Configuración recomendada:
# - Instance: SQLEXPRESS
# - Authentication: Mixed Mode
# - SA Password: SqlServerRoot2025!
# - Add Current User as Administrator: Yes
```

#### Paso 4.2: Instalación en Linux (Ubuntu)
```bash
# Importar clave pública del repositorio
curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -

# Agregar repositorio
sudo add-apt-repository "$(curl -fsSL https://packages.microsoft.com/config/ubuntu/20.04/mssql-server-2022.list)"

# Instalar SQL Server
sudo apt update
sudo apt install -y mssql-server

# Configurar SQL Server
sudo /opt/mssql/bin/mssql-conf setup
# Choose edition: 2 (Express)
# Accept license: Yes
# SA password: SqlServerRoot2025!

# Verificar instalación
sudo systemctl status mssql-server
```

#### Paso 4.3: Instalación de SQL Server Management Studio (Windows)
- Descargar SSMS desde: https://docs.microsoft.com/en-us/sql/ssms/download-sql-server-management-studio-ssms
- Instalar y configurar conexión

#### Paso 4.4: Instalación de sqlcmd (Linux)
```bash
# Instalar herramientas de línea de comandos
sudo apt install mssql-tools unixodbc-dev -y

# Agregar al PATH
echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc
source ~/.bashrc
```

#### Paso 4.5: Configuración Inicial
```sql
-- Conectar usando sqlcmd
sqlcmd -S localhost -U sa -P 'SqlServerRoot2025!'

-- Crear usuario de trabajo
CREATE LOGIN labuser WITH PASSWORD = 'LabUser2025!';
CREATE USER labuser FOR LOGIN labuser;
ALTER SERVER ROLE sysadmin ADD MEMBER labuser;

-- Crear base de datos de prueba
CREATE DATABASE laboratorio_sqlserver;
GO

-- Verificar configuración
SELECT @@VERSION;
SELECT @@SERVERNAME;
SELECT name FROM sys.databases;
```

⏱️ **Checkpoint**: Documentar tiempo total de instalación SQL Server: _____ minutos

### Fase 5: Testing y Comparación (60 minutos)

#### Paso 5.1: Benchmark de Rendimiento Inicial
Ejecuta este script en cada SGBD para medir rendimiento básico:

**MySQL:**
```sql
-- Test de inserción masiva
USE laboratorio_mysql;
CREATE TABLE test_performance (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    fecha DATETIME,
    valor DECIMAL(10,2)
);

SET @start_time = NOW(6);
INSERT INTO test_performance (nombre, fecha, valor)
SELECT 
    CONCAT('Usuario_', n),
    NOW(),
    RAND() * 1000
FROM (
    SELECT a.N + b.N * 10 + c.N * 100 + d.N * 1000 + 1 n
    FROM 
    (SELECT 0 N UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) a,
    (SELECT 0 N UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) b,
    (SELECT 0 N UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) c,
    (SELECT 0 N UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) d
) t
LIMIT 10000;

SET @end_time = NOW(6);
SELECT TIMESTAMPDIFF(MICROSECOND, @start_time, @end_time) as tiempo_microsegundos;
SELECT COUNT(*) as registros_insertados FROM test_performance;
```

**PostgreSQL:**
```sql
-- Test equivalente para PostgreSQL
\c laboratorio_postgresql;

CREATE TABLE test_performance (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100),
    fecha TIMESTAMP,
    valor DECIMAL(10,2)
);

\timing on

INSERT INTO test_performance (nombre, fecha, valor)
SELECT 
    'Usuario_' || generate_series,
    NOW(),
    RANDOM() * 1000
FROM generate_series(1, 10000);

SELECT COUNT(*) as registros_insertados FROM test_performance;
```

**SQL Server:**
```sql
-- Test equivalente para SQL Server
USE laboratorio_sqlserver;

CREATE TABLE test_performance (
    id INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(100),
    fecha DATETIME2,
    valor DECIMAL(10,2)
);

DECLARE @start_time DATETIME2 = SYSDATETIME();

WITH Numbers AS (
    SELECT ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) as n
    FROM master.dbo.spt_values s1
    CROSS JOIN master.dbo.spt_values s2
)
INSERT INTO test_performance (nombre, fecha, valor)
SELECT 
    'Usuario_' + CAST(n AS VARCHAR(10)),
    SYSDATETIME(),
    RAND(CHECKSUM(NEWID())) * 1000
FROM Numbers
WHERE n <= 10000;

DECLARE @end_time DATETIME2 = SYSDATETIME();
SELECT DATEDIFF(MICROSECOND, @start_time, @end_time) as tiempo_microsegundos;
SELECT COUNT(*) as registros_insertados FROM test_performance;
```

#### Paso 5.2: Comparación de Características
Completa esta tabla basándote en tu experiencia de instalación:

| Aspecto | MySQL | PostgreSQL | SQL Server |
|---------|--------|------------|------------|
| **Tiempo de instalación** | _____ min | _____ min | _____ min |
| **Tamaño de instalación** | _____ MB | _____ MB | _____ MB |
| **Dificultad de instalación (1-5)** | _____ | _____ | _____ |
| **Tiempo inserción 10k registros** | _____ ms | _____ ms | _____ ms |
| **Consumo de memoria inicial** | _____ MB | _____ MB | _____ MB |
| **Puertos por defecto** | 3306 | 5432 | 1433 |
| **Herramienta administrativa** | Workbench | pgAdmin | SSMS |
| **Soporte de JSON nativo** | ✓/✗ | ✓/✗ | ✓/✗ |
| **Licenciamiento** | GPL | PostgreSQL | Propietario |

#### Paso 5.3: Evaluación de Herramientas de Administración
Para cada herramienta, evalúa estos aspectos (escala 1-5):

**MySQL Workbench:**
- Facilidad de uso: ___/5
- Funcionalidades disponibles: ___/5
- Diseño visual de esquemas: ___/5
- Rendimiento: ___/5

**pgAdmin:**
- Facilidad de uso: ___/5
- Funcionalidades disponibles: ___/5
- Interface web: ___/5
- Rendimiento: ___/5

**SQL Server Management Studio:**
- Facilidad de uso: ___/5
- Funcionalidades disponibles: ___/5
- Integración con Windows: ___/5
- Rendimiento: ___/5

### Fase 6: Casos de Uso Empresarial (30 minutos)

#### Caso 1: Startup Tecnológica
**Contexto**: Empresa nueva, presupuesto limitado, equipo técnico joven, crecimiento rápido esperado.

**Pregunta**: ¿Qué SGBD recomendarías y por qué?

**Tu recomendación**: ________________
**Justificación** (3 puntos principales):
1. ________________________________
2. ________________________________
3. ________________________________

#### Caso 2: Hospital Regional
**Contexto**: Datos críticos de pacientes, disponibilidad 24/7, regulaciones estrictas, presupuesto establecido.

**Pregunta**: ¿Qué SGBD recomendarías y por qué?

**Tu recomendación**: ________________
**Justificación** (3 puntos principales):
1. ________________________________
2. ________________________________
3. ________________________________

#### Caso 3: Empresa de Retail
**Contexto**: Alto volumen de transacciones, múltiples sucursales, integración con sistemas existentes.

**Pregunta**: ¿Qué SGBD recomendarías y por qué?

**Tu recomendación**: ________________
**Justificación** (3 puntos principales):
1. ________________________________
2. ________________________________
3. ________________________________

## Notas

### Troubleshooting Común

**MySQL:**
- Error 1045: Verificar usuario y contraseña
- Error 2003: Verificar que el servicio esté ejecutándose
- Error 1130: Verificar permisos de host

**PostgreSQL:**
- Error de autenticación: Revisar pg_hba.conf
- Conexión rechazada: Verificar postgresql.conf
- Encoding issues: Verificar configuración de locale

**SQL Server:**
- Login failed: Verificar modo de autenticación
- Puerto ocupado: Cambiar puerto o verificar firewall
- Servicios no iniciados: Verificar SQL Server Configuration Manager

### Comandos Útiles de Verificación

```bash
# Verificar servicios activos (Linux)
sudo systemctl status mysql
sudo systemctl status postgresql  
sudo systemctl status mssql-server

# Verificar puertos abiertos
netstat -tulnp | grep :3306   # MySQL
netstat -tulnp | grep :5432   # PostgreSQL  
netstat -tulnp | grep :1433   # SQL Server

# Verificar procesos
ps aux | grep mysql
ps aux | grep postgres
ps aux | grep sqlservr
```

### Recursos Adicionales

**Documentación Oficial:**
- MySQL: https://dev.mysql.com/doc/refman/8.0/en/
- PostgreSQL: https://www.postgresql.org/docs/15/
- SQL Server: https://docs.microsoft.com/en-us/sql/

**Comunidades y Foros:**
- Stack Overflow (tags: mysql, postgresql, sql-server)
- Reddit: r/MySQL, r/PostgreSQL, r/SQLServer
- Discord: Comunidades de desarrolladores de BD

**Herramientas Adicionales:**
- DBeaver: Cliente universal para múltiples SGBD
- DataGrip: IDE comercial de JetBrains
- Adminer: Herramienta web ligera para administración

### Entregables

1. **Reporte de Instalación** (2 páginas):
   - Procedimiento seguido para cada SGBD
   - Problemas encontrados y soluciones aplicadas
   - Capturas de pantalla de cada instalación exitosa
   - Tabla comparativa completa

2. **Scripts de Configuración**:
   - Scripts SQL de configuración inicial
   - Archivos de configuración modificados
   - Scripts de testing ejecutados

3. **Recomendaciones por Caso**:
   - Análisis detallado para cada escenario empresarial
   - Justificación técnica y económica
   - Consideraciones de escalabilidad

4. **Reflexión Personal** (1 párrafo):
   - ¿Cuál SGBD te pareció más fácil de instalar y por qué?
   - ¿Qué aspectos considerarías más importantes en una selección real?
   - ¿Qué recursos adicionales consultarías para una evaluación más profunda?

### Rúbrica de Evaluación

| Criterio | Excelente (3) | Bueno (2) | Aceptable (1) | Insuficiente (0) | Ponderación |
|----------|---------------|-----------|---------------|------------------|-------------|
| **Procedimientos de Instalación** | Documenta procedimientos completos y detallados para los 3 SGBD con pasos claros y secuenciales | Documenta procedimientos adecuados para los 3 SGBD con la mayoría de pasos necesarios | Documenta procedimientos básicos para 2-3 SGBD con algunos pasos faltantes | Documentación incompleta o procedimientos para menos de 2 SGBD | 25% |
| **Evidencias Visuales** | Incluye capturas de pantalla claras y relevantes de todas las instalaciones exitosas y configuraciones | Incluye capturas adecuadas de la mayoría de instalaciones y configuraciones importantes | Incluye capturas básicas de algunas instalaciones con calidad aceptable | Capturas insuficientes, borrosas o no representativas del proceso | 20% |
| **Análisis Comparativo** | Completa tabla comparativa con datos precisos, análisis técnico profundo y métricas de rendimiento documentadas | Completa tabla comparativa con datos adecuados y análisis técnico satisfactorio | Completa tabla comparativa con datos básicos y análisis técnico elemental | Tabla incompleta o análisis superficial sin sustento técnico | 20% |
| **Resolución de Problemas** | Documenta problemas encontrados con soluciones detalladas, análisis de causas y alternativas evaluadas | Documenta problemas con soluciones apropiadas y explicación del proceso seguido | Documenta algunos problemas con soluciones básicas aplicadas | No documenta problemas o soluciones aplicadas insuficientes | 15% |
| **Recomendaciones Empresariales** | Proporciona recomendaciones fundamentadas para los 3 casos con justificación técnica sólida y consideraciones de contexto | Proporciona recomendaciones apropiadas para los casos con justificación técnica adecuada | Proporciona recomendaciones básicas con justificación técnica elemental | Recomendaciones genéricas sin justificación técnica o contextual | 10% |
| **Organización y Presentación** | Documento bien estructurado, formato profesional, redacción clara y sin errores ortográficos | Documento adecuadamente organizado con formato apropiado y redacción satisfactoria | Documento básicamente organizado con formato aceptable y redacción comprensible | Documento desorganizado, formato deficiente o múltiples errores de redacción | 5% |
| **Reflexión y Aprendizaje** | Reflexión profunda sobre el proceso, identificación clara de aprendizajes y propuestas de mejora | Reflexión adecuada sobre el proceso con identificación de aprendizajes principales | Reflexión básica sobre el proceso con algunos aprendizajes identificados | Reflexión superficial o ausente, sin evidencia de aprendizaje significativo | 5% |

**Puntaje Total: ___/21 puntos**

#### Escala de Calificación:
- **19-21 puntos**: Excelente (9-10)
- **16-18 puntos**: Bueno (8-8.9)
- **13-15 puntos**: Aceptable (7-7.9)
- **0-12 puntos**: Insuficiente (0-6.9)

#### Criterios Específicos de Evaluación:

**Para Procedimientos de Instalación:**
- Debe incluir comandos exactos ejecutados
- Configuraciones específicas aplicadas
- Pasos de verificación realizados
- Tiempo de instalación documentado

**Para Evidencias Visuales:**
- Capturas de instaladores en ejecución
- Pantallas de configuración completadas
- Interfaces de administración funcionando
- Resultados de scripts de testing

**Para Análisis Comparativo:**
- Métricas de rendimiento con valores numéricos
- Comparación de recursos del sistema utilizados
- Evaluación objetiva de facilidad de uso
- Identificación de ventajas y desventajas específicas

**Para Recomendaciones Empresariales:**
- Consideración del contexto específico de cada caso
- Justificación basada en criterios técnicos y económicos
- Evaluación de escalabilidad y mantenimiento
- Identificación de riesgos y mitigaciones
