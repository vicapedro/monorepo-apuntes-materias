# Práctica: Constraints en Guardería Infantil "Los Pequeños"

## Objetivo
**Duración estimada:** 2 horas

Aplicar los diferentes tipos de constraints (restricciones) en el diseño de una base de datos para una guardería infantil, garantizando la integridad de dominio, entidad y referencial de los datos.

## Competencias a desarrollar
- Aplica constraints apropiados según las reglas de negocio
- Implementa integridad de dominio mediante tipos de datos y restricciones CHECK
- Establece integridad de entidad con claves primarias y únicas
- Configura integridad referencial con claves foráneas
- Utiliza valores por defecto y restricciones NOT NULL adecuadamente

## Introducción

La Guardería Infantil "Los Pequeños" atiende niños desde recién nacidos hasta los 5 años de edad. Es fundamental mantener información precisa y confiable sobre los niños, sus padres/tutores, y cualquier necesidad especial que requieran. La integridad de estos datos es crítica para la seguridad y el cuidado apropiado de los menores.

## Equipo de protección e higiene
- Mantener el área de trabajo limpia y ordenada
- Verificar que los cables de alimentación estén en buen estado
- No consumir alimentos cerca del equipo

## Material y equipo necesario

### Materiales e insumos
- Documentación sobre constraints en SQL
- Libreta para anotar reglas de negocio
- USB para respaldo de scripts

### Equipo de laboratorio
- Computadora con Windows 10/11
- SQL Server Management Studio
- SQL Server 2019/2022 (Developer o Express)
- Mínimo 4 GB RAM

### Herramientas
- Editor de texto para documentación
- Navegador web para consultas

## Instrucciones

### Preparación inicial

```sql
-- Crear la base de datos
CREATE DATABASE Guarderia_LosPequenos;
GO

USE Guarderia_LosPequenos;
GO
```

---

## Parte 1: Análisis de Reglas de Negocio (20 minutos)

Antes de implementar, identifica las reglas de negocio del escenario:

### 📋 **Reglas identificadas:**
1. **Niños**: Edad entre 0 y 5 años (0 = recién nacidos)
2. **Padres/Tutores**: Deben ser mayores de edad (18+ años)
3. **Teléfonos**: Formato específico para México (10 dígitos)
4. **Emails**: Deben contener @ y tener formato válido
5. **Relaciones**: Cada niño debe tener al menos un tutor responsable
6. **Alergias/Dietas**: Información crucial para seguridad del niño

**📝 Actividad:** Anota 3 reglas adicionales que consideres importantes para una guardería.

---

## Parte 2: Implementación de Tablas con Constraints (90 minutos)

### 2.1 Tabla Tutores (Padres/Responsables)

```sql
-- Crear tabla Tutores con constraints apropiados
CREATE TABLE Tutores (
    TutorID INT IDENTITY(1,1) PRIMARY KEY,
    
    -- Información personal básica
    Nombre NVARCHAR(100) NOT NULL,
    ApellidoPaterno NVARCHAR(50) NOT NULL,
    ApellidoMaterno NVARCHAR(50),
    
    -- Validación de edad (18-80 años)
    FechaNacimiento DATE NOT NULL 
        CONSTRAINT CK_Tutor_EdadValida 
        CHECK (FechaNacimiento <= DATEADD(YEAR, -18, GETDATE()) 
               AND FechaNacimiento >= DATEADD(YEAR, -80, GETDATE())),
    
    -- Contacto con validaciones
    Telefono CHAR(10) NOT NULL
        CONSTRAINT CK_Tutor_TelefonoFormato 
        CHECK (Telefono LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
    
    Email NVARCHAR(100) NOT NULL
        CONSTRAINT CK_Tutor_EmailFormato
        CHECK (Email LIKE '%_@_%.__%'),
    
    -- Dirección
    Direccion NVARCHAR(200) NOT NULL,
    CodigoPostal CHAR(5) NOT NULL
        CONSTRAINT CK_Tutor_CPFormato
        CHECK (CodigoPostal LIKE '[0-9][0-9][0-9][0-9][0-9]'),
    
    -- Información laboral
    Ocupacion NVARCHAR(100),
    TelefonoTrabajo CHAR(10)
        CONSTRAINT CK_Tutor_TelTrabajoFormato
        CHECK (TelefonoTrabajo IS NULL OR 
               TelefonoTrabajo LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
    
    -- Control de registro
    FechaRegistro DATETIME2 DEFAULT GETDATE(),
    Activo BIT DEFAULT 1,
    
    -- Restricciones únicas
    CONSTRAINT UK_Tutor_Email UNIQUE (Email),
    CONSTRAINT UK_Tutor_Telefono UNIQUE (Telefono)
);
```

### 2.2 Tabla Niños

```sql
-- Crear tabla Niños con constraints específicos
CREATE TABLE Ninos (
    NinoID INT IDENTITY(1,1) PRIMARY KEY,
    
    -- Información personal
    Nombre NVARCHAR(100) NOT NULL,
    ApellidoPaterno NVARCHAR(50) NOT NULL,
    ApellidoMaterno NVARCHAR(50),
    
    -- Validación de edad específica para guardería (0-5 años)
    FechaNacimiento DATE NOT NULL
        CONSTRAINT CK_Nino_EdadGuarderia
        CHECK (FechaNacimiento >= DATEADD(YEAR, -5, GETDATE())
               AND FechaNacimiento <= GETDATE()),
    
    -- Género con valores específicos
    Genero CHAR(1) NOT NULL DEFAULT 'M'
        CONSTRAINT CK_Nino_GeneroValido
        CHECK (Genero IN ('M', 'F')),
    
    -- Información médica importante
    GrupoSanguineo VARCHAR(5)
        CONSTRAINT CK_Nino_GrupoSanguineoValido
        CHECK (GrupoSanguineo IS NULL OR 
               GrupoSanguineo IN ('A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-')),
    
    -- Necesidades especiales
    TieneAlergias BIT DEFAULT 0,
    DescripcionAlergias NVARCHAR(500),
    
    DietaEspecial BIT DEFAULT 0,
    DescripcionDieta NVARCHAR(500),
    
    MedicamentosCronicos BIT DEFAULT 0,
    DescripcionMedicamentos NVARCHAR(500),
    
    -- Información de emergencia
    ContactoEmergencia NVARCHAR(100),
    TelefonoEmergencia CHAR(10)
        CONSTRAINT CK_Nino_TelEmergenciaFormato
        CHECK (TelefonoEmergencia IS NULL OR
               TelefonoEmergencia LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
    
    -- Control de registro
    FechaIngreso DATE DEFAULT CAST(GETDATE() AS DATE),
    Activo BIT DEFAULT 1,
    
    -- Restricciones lógicas entre campos
    CONSTRAINT CK_Nino_AlergiasDescripcion
        CHECK (TieneAlergias = 0 OR DescripcionAlergias IS NOT NULL),
    
    CONSTRAINT CK_Nino_DietaDescripcion
        CHECK (DietaEspecial = 0 OR DescripcionDieta IS NOT NULL),
        
    CONSTRAINT CK_Nino_MedicamentosDescripcion
        CHECK (MedicamentosCronicos = 0 OR DescripcionMedicamentos IS NOT NULL)
);
```

### 2.3 Tabla de Relación Tutor-Niño

```sql
-- Tabla para relacionar tutores con niños (muchos a muchos)
CREATE TABLE TutorNino (
    TutorNinoID INT IDENTITY(1,1) PRIMARY KEY,
    
    -- Claves foráneas
    TutorID INT NOT NULL,
    NinoID INT NOT NULL,
    
    -- Tipo de relación
    TipoRelacion NVARCHAR(20) NOT NULL DEFAULT 'Padre/Madre'
        CONSTRAINT CK_TutorNino_TipoRelacionValida
        CHECK (TipoRelacion IN ('Padre/Madre', 'Abuelo/Abuela', 'Tio/Tia', 
                               'Tutor Legal', 'Hermano/Hermana', 'Otro')),
    
    -- Permisos
    PuedeRecoger BIT DEFAULT 1,
    ContactoEmergencia BIT DEFAULT 0,
    
    -- Control
    FechaRegistro DATETIME2 DEFAULT GETDATE(),
    Activo BIT DEFAULT 1,
    
    -- Claves foráneas con integridad referencial
    CONSTRAINT FK_TutorNino_Tutor 
        FOREIGN KEY (TutorID) REFERENCES Tutores(TutorID)
        ON DELETE CASCADE ON UPDATE CASCADE,
        
    CONSTRAINT FK_TutorNino_Nino 
        FOREIGN KEY (NinoID) REFERENCES Ninos(NinoID)
        ON DELETE CASCADE ON UPDATE CASCADE,
    
    -- Evitar duplicados
    CONSTRAINT UK_TutorNino_Relacion UNIQUE (TutorID, NinoID)
);
```

### 2.4 Tabla de Grupos (Salones)

```sql
-- Tabla para organizar niños por grupos de edad
CREATE TABLE Grupos (
    GrupoID INT IDENTITY(1,1) PRIMARY KEY,
    
    NombreGrupo NVARCHAR(50) NOT NULL,
    
    -- Rango de edades para el grupo
    EdadMinimaAnos TINYINT NOT NULL
        CONSTRAINT CK_Grupo_EdadMinima
        CHECK (EdadMinimaAnos >= 0 AND EdadMinimaAnos <= 5),
        
    EdadMaximaAnos TINYINT NOT NULL
        CONSTRAINT CK_Grupo_EdadMaxima
        CHECK (EdadMaximaAnos >= 0 AND EdadMaximaAnos <= 5),
    
    -- Capacidad del grupo
    CapacidadMaxima TINYINT NOT NULL DEFAULT 15
        CONSTRAINT CK_Grupo_CapacidadValida
        CHECK (CapacidadMaxima BETWEEN 5 AND 25),
    
    -- Educadora responsable
    EducadoraResponsable NVARCHAR(100) NOT NULL,
    
    Activo BIT DEFAULT 1,
    
    -- Restricción lógica de edades
    CONSTRAINT CK_Grupo_RangoEdadLogico
        CHECK (EdadMinimaAnos <= EdadMaximaAnos),
    
    -- Nombre único del grupo
    CONSTRAINT UK_Grupo_Nombre UNIQUE (NombreGrupo)
);
```

### 2.5 Asignación de Niños a Grupos

```sql
-- Tabla para asignar niños a grupos
CREATE TABLE NinoGrupo (
    NinoGrupoID INT IDENTITY(1,1) PRIMARY KEY,
    
    NinoID INT NOT NULL,
    GrupoID INT NOT NULL,
    
    FechaAsignacion DATE DEFAULT CAST(GETDATE() AS DATE),
    FechaFin DATE,
    
    Activo BIT DEFAULT 1,
    
    -- Claves foráneas
    CONSTRAINT FK_NinoGrupo_Nino
        FOREIGN KEY (NinoID) REFERENCES Ninos(NinoID)
        ON DELETE CASCADE ON UPDATE CASCADE,
        
    CONSTRAINT FK_NinoGrupo_Grupo
        FOREIGN KEY (GrupoID) REFERENCES Grupos(GrupoID)
        ON DELETE CASCADE ON UPDATE CASCADE,
    
    -- Un niño solo puede estar en un grupo activo a la vez
    CONSTRAINT UK_NinoGrupo_NinoActivo 
        UNIQUE (NinoID, Activo),
    
    -- La fecha de fin debe ser posterior a la de asignación
    CONSTRAINT CK_NinoGrupo_FechasLogicas
        CHECK (FechaFin IS NULL OR FechaFin > FechaAsignacion)
);
```

---

## Parte 3: Inserción de Datos de Prueba (30 minutos)

### 3.1 Insertar Grupos

```sql
-- Insertar grupos típicos de una guardería
INSERT INTO Grupos (NombreGrupo, EdadMinimaAnos, EdadMaximaAnos, CapacidadMaxima, EducadoraResponsable)
VALUES 
('Bebés', 0, 1, 8, 'María González'),
('Maternales', 1, 2, 12, 'Ana Rodríguez'),
('Preescolares A', 3, 4, 15, 'Carmen López'),
('Preescolares B', 4, 5, 15, 'Sofía Martínez');
```

### 3.2 Insertar Tutores

```sql
-- Insertar tutores de ejemplo
INSERT INTO Tutores (Nombre, ApellidoPaterno, ApellidoMaterno, FechaNacimiento, 
                    Telefono, Email, Direccion, CodigoPostal, Ocupacion)
VALUES 
('Juan Carlos', 'Pérez', 'García', '1985-03-15', '9981234567', 
 'juan.perez@email.com', 'Av. Insurgentes 123, Col. Centro', '77000', 'Ingeniero'),
 
('María Elena', 'López', 'Hernández', '1990-07-22', '9987654321',
 'maria.lopez@email.com', 'Calle Reforma 456, Col. Norte', '77010', 'Doctora'),
 
('Roberto', 'Martínez', 'Sánchez', '1988-11-08', '9985556789',
 'roberto.martinez@email.com', 'Blvd. Kukulkán 789, Col. Sur', '77020', 'Contador');
```

### 3.3 Insertar Niños

```sql
-- Insertar niños de ejemplo
INSERT INTO Ninos (Nombre, ApellidoPaterno, ApellidoMaterno, FechaNacimiento, 
                  Genero, GrupoSanguineo, TieneAlergias, DescripcionAlergias,
                  DietaEspecial, DescripcionDieta)
VALUES 
('Sofía', 'Pérez', 'López', '2022-05-10', 'F', 'O+', 1, 'Alérgica a los frutos secos', 0, NULL),
('Diego', 'Martínez', 'García', '2021-09-15', 'M', 'A+', 0, NULL, 1, 'Dieta libre de gluten'),
('Isabella', 'López', 'Hernández', '2020-12-03', 'F', 'B+', 0, NULL, 0, NULL);
```

### 3.4 Establecer Relaciones

```sql
-- Relacionar tutores con niños
INSERT INTO TutorNino (TutorID, NinoID, TipoRelacion, PuedeRecoger, ContactoEmergencia)
VALUES 
(1, 1, 'Padre/Madre', 1, 1),  -- Juan Carlos es padre de Sofía
(2, 1, 'Padre/Madre', 1, 0),  -- María Elena es madre de Sofía
(3, 2, 'Padre/Madre', 1, 1),  -- Roberto es padre de Diego
(2, 3, 'Padre/Madre', 1, 1);  -- María Elena es madre de Isabella
```

### 3.5 Asignar Niños a Grupos

```sql
-- Asignar niños a grupos apropiados por edad
INSERT INTO NinoGrupo (NinoID, GrupoID, FechaAsignacion)
VALUES 
(1, 2, '2024-08-15'),  -- Sofía (2 años) al grupo Maternales
(2, 3, '2024-08-15'),  -- Diego (3 años) al grupo Preescolares A
(3, 4, '2024-08-15');  -- Isabella (4 años) al grupo Preescolares B
```

---

## Parte 4: Pruebas de Constraints (20 minutos)

### 4.1 Probar Violaciones de Dominio

```sql
-- 🔥 Intentar insertar un niño mayor de 5 años (DEBE FALLAR)
INSERT INTO Ninos (Nombre, ApellidoPaterno, FechaNacimiento, Genero)
VALUES ('Carlos', 'Viejo', '2010-01-01', 'M');

-- 🔥 Intentar insertar un tutor menor de edad (DEBE FALLAR)
INSERT INTO Tutores (Nombre, ApellidoPaterno, FechaNacimiento, Telefono, Email, Direccion, CodigoPostal)
VALUES ('Pedro', 'Joven', '2010-01-01', '9987654321', 'pedro@email.com', 'Calle 123', '77000');

-- 🔥 Intentar insertar email duplicado (DEBE FALLAR)
INSERT INTO Tutores (Nombre, ApellidoPaterno, FechaNacimiento, Telefono, Email, Direccion, CodigoPostal)
VALUES ('Ana', 'Duplicada', '1985-01-01', '9981111111', 'juan.perez@email.com', 'Calle 456', '77000');
```

### 4.2 Probar Integridad Referencial

```sql
-- 🔥 Intentar asignar un niño a un grupo inexistente (DEBE FALLAR)
INSERT INTO NinoGrupo (NinoID, GrupoID)
VALUES (1, 999);

-- 🔥 Intentar relacionar con tutor inexistente (DEBE FALLAR)
INSERT INTO TutorNino (TutorID, NinoID, TipoRelacion)
VALUES (999, 1, 'Padre/Madre');
```

### 4.3 Probar Restricciones Lógicas

```sql
-- 🔥 Intentar crear un grupo con rango de edad inválido (DEBE FALLAR)
INSERT INTO Grupos (NombreGrupo, EdadMinimaAnos, EdadMaximaAnos, CapacidadMaxima, EducadoraResponsable)
VALUES ('Grupo Inválido', 4, 2, 15, 'Educadora Prueba');

-- 🔥 Intentar marcar alergias sin descripción (DEBE FALLAR)
INSERT INTO Ninos (Nombre, ApellidoPaterno, FechaNacimiento, Genero, TieneAlergias, DescripcionAlergias)
VALUES ('Test', 'Alergia', '2022-01-01', 'M', 1, NULL);
```

---

## Parte 5: Consultas de Verificación (20 minutos)

### 5.1 Verificar Datos Insertados

```sql
-- Ver todos los niños con sus tutores
SELECT 
    n.Nombre + ' ' + n.ApellidoPaterno AS NombreNino,
    DATEDIFF(YEAR, n.FechaNacimiento, GETDATE()) AS Edad,
    t.Nombre + ' ' + t.ApellidoPaterno AS NombreTutor,
    tn.TipoRelacion,
    CASE WHEN n.TieneAlergias = 1 THEN 'SÍ' ELSE 'NO' END AS TieneAlergias,
    CASE WHEN n.DietaEspecial = 1 THEN 'SÍ' ELSE 'NO' END AS DietaEspecial
FROM Ninos n
INNER JOIN TutorNino tn ON n.NinoID = tn.NinoID
INNER JOIN Tutores t ON tn.TutorID = t.TutorID
WHERE tn.Activo = 1
ORDER BY n.Nombre;
```

### 5.2 Ver Niños por Grupo

```sql
-- Ver distribución de niños por grupo
SELECT 
    g.NombreGrupo,
    g.EdadMinimaAnos,
    g.EdadMaximaAnos,
    COUNT(ng.NinoID) AS NinosInscritos,
    g.CapacidadMaxima,
    g.EducadoraResponsable
FROM Grupos g
LEFT JOIN NinoGrupo ng ON g.GrupoID = ng.GrupoID AND ng.Activo = 1
GROUP BY g.GrupoID, g.NombreGrupo, g.EdadMinimaAnos, g.EdadMaximaAnos, 
         g.CapacidadMaxima, g.EducadoraResponsable
ORDER BY g.EdadMinimaAnos;
```

### 5.3 Niños con Necesidades Especiales

```sql
-- Identificar niños que requieren atención especial
SELECT 
    n.Nombre + ' ' + n.ApellidoPaterno AS NombreNino,
    DATEDIFF(YEAR, n.FechaNacimiento, GETDATE()) AS Edad,
    CASE WHEN n.TieneAlergias = 1 THEN n.DescripcionAlergias ELSE 'Sin alergias' END AS Alergias,
    CASE WHEN n.DietaEspecial = 1 THEN n.DescripcionDieta ELSE 'Dieta normal' END AS Dieta,
    CASE WHEN n.MedicamentosCronicos = 1 THEN n.DescripcionMedicamentos ELSE 'Sin medicamentos' END AS Medicamentos
FROM Ninos n
WHERE n.TieneAlergias = 1 OR n.DietaEspecial = 1 OR n.MedicamentosCronicos = 1;
```

## Entregables

### 📋 Evidencias requeridas:
1. **Scripts SQL completos**:
   - Creación de base de datos y tablas con todos los constraints
   - Scripts de inserción de datos de prueba
   - Consultas de verificación

2. **Capturas de pantalla**:
   - Mensajes de error al violar constraints
   - Resultados de las consultas de verificación
   - Vista de las tablas creadas en Object Explorer

3. **Documento de análisis**:
   - Identificación de reglas de negocio adicionales
   - Justificación de cada constraint implementado
   - Propuestas de mejora al diseño

### 📊 Preguntas de reflexión:
1. ¿Qué ventajas tiene definir constraints en la base de datos vs. validar solo en la aplicación?
2. ¿Cómo impactan los constraints en el rendimiento de la base de datos?
3. ¿Qué otros constraints podrían ser útiles para este escenario?
4. ¿Cómo manejarías cambios en las reglas de negocio que afecten constraints existentes?

## Criterios de evaluación

| **Criterio** | **Excelente (3)** | **Bueno (2)** | **Aceptable (1)** | **Insuficiente (0)** |
|--------------|-------------------|----------------|-------------------|----------------------|
| **Implementación de constraints** | Todos los constraints apropiados implementados | La mayoría de constraints correctos | Constraints básicos implementados | Pocos o ningún constraint |
| **Integridad de datos** | Comprende y aplica los 3 tipos de integridad | Aplica 2 tipos de integridad correctamente | Aplica 1 tipo de integridad | No demuestra comprensión |
| **Validación de reglas** | Identifica y valida todas las reglas de negocio | Identifica la mayoría de reglas | Identifica reglas básicas | No identifica reglas claras |
| **Pruebas y verificación** | Prueba exhaustivamente todos los constraints | Prueba la mayoría de constraints | Prueba algunos constraints | No realiza pruebas |

## Notas

### 🚨 Consideraciones importantes:
- **Backup**: Respalda la base de datos antes de hacer cambios
- **Nombres**: Usa nombres descriptivos para constraints
- **Documentación**: Comenta cada constraint explicando su propósito

### 💡 Extensiones opcionales:
- Agregar tabla de asistencia diaria
- Implementar tabla de actividades realizadas
- Crear tabla de pagos y mensualidades
- Añadir registro de incidentes o accidentes

### 🔧 Troubleshooting:
- **Errores de constraint**: Son esperados en las pruebas, documentarlos
- **Datos de prueba**: Ajusta fechas si es necesario para que sean válidas
- **Formatos**: Verifica que los formatos de teléfono y email sean correctos para tu región

**¿La práctica te ayudó a comprender la importancia de los constraints?** Reflexiona sobre cómo estos protegen la integridad en sistemas reales donde la información incorrecta puede tener consecuencias serias.
