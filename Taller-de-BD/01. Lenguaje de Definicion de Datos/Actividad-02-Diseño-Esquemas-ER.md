# Actividad 2: Diseño de Esquemas con Modelado ER

## 🎯 Objetivo de la Actividad
**Diseñar esquemas de bases de datos aplicando técnicas de modelado Entidad-Relación y transformando modelos conceptuales a implementaciones DDL funcionales.**

**Duración estimada**: 3 horas  
**Modalidad**: Equipos de 2-3 personas

## 🎓 Competencias a Desarrollar
- Aplica técnicas de modelado Entidad-Relación (ER)
- Transforma modelos conceptuales a esquemas lógicos
- Implementa constraints de integridad referencial
- Normaliza esquemas de bases de datos
- Documenta decisiones de diseño técnico

## 📚 Introducción

El modelado de datos es fundamental para crear bases de datos eficientes, mantenibles y escalables. Esta actividad te guiará a través del proceso completo desde el análisis de requerimientos hasta la implementación de esquemas DDL.

### Metodología de Diseño de BD
1. **Análisis de requerimientos** → Identificación de entidades y relaciones
2. **Modelo conceptual (ER)** → Diagrama de entidades y relaciones
3. **Modelo lógico** → Normalización y optimización
4. **Modelo físico** → Implementación DDL con constraints

## 🏥 Caso de Estudio: Sistema de Biblioteca Digital

### Descripción del Dominio
Una biblioteca universitaria quiere modernizar su sistema de gestión para incluir recursos digitales y servicios en línea.

### Requerimientos Funcionales Detallados

**R1 - Gestión de Usuarios**:
- Estudiantes, profesores, personal administrativo y visitantes externos
- Diferentes privilegios de préstamo según tipo de usuario
- Historial de sanciones y restricciones
- Información de contacto y afiliación académica

**R2 - Catálogo de Recursos**:
- Libros físicos y digitales
- Revistas, tesis, documentos multimedia
- Metadatos: ISBN, autor, editorial, categorías temáticas
- Disponibilidad en tiempo real

**R3 - Sistema de Préstamos**:
- Préstamos físicos con fechas de entrega
- Acceso temporal a recursos digitales
- Renovaciones y reservas
- Multas por retrasos

**R4 - Servicios Digitales**:
- Descargas de documentos digitales
- Salas de estudio virtual con reservas
- Notificaciones automáticas por email/SMS

## 🔧 Metodología de Trabajo

### Fase 1: Análisis y Modelado Conceptual (60 minutos)

#### Paso 1A: Identificación de Entidades (20 minutos)
**Instrucciones**:
1. Lee cuidadosamente los requerimientos
2. Identifica **entidades principales** y sus **atributos**
3. Clasifica atributos: simples/compuestos, derivados, clave primaria
4. Usa la plantilla proporcionada

**Plantilla de Entidades**:
```
ENTIDAD: [Nombre]
Descripción: [Propósito en el sistema]
Atributos:
- [atributo] (clave primaria/simple/compuesto/derivado) - [descripción]
- ...
```

#### Paso 1B: Identificación de Relaciones (20 minutos)
**Instrucciones**:
1. Identifica **relaciones** entre entidades
2. Determina **cardinalidades** (1:1, 1:N, M:N)
3. Identifica **atributos de relaciones**
4. Documenta **restricciones de participación**

**Plantilla de Relaciones**:
```
RELACIÓN: [Entidad1] — [nombre_relación] — [Entidad2]
Cardinalidad: [1:1 / 1:N / M:N]
Participación: [total/parcial] — [total/parcial]
Atributos de relación: [si aplica]
Reglas de negocio: [restricciones especiales]
```

#### Paso 1C: Modelo ER Completo (20 minutos)
**Herramientas recomendadas**: draw.io, Lucidchart, o papel
**Elementos a incluir**:
- Entidades (rectángulos)
- Relaciones (rombos)
- Atributos (óvalos)
- Cardinalidades claramente marcadas
- Claves primarias subrayadas

### Fase 2: Normalización y Modelo Lógico (45 minutos)

#### Paso 2A: Primera Forma Normal (1FN) (15 minutos)
**Objetivo**: Eliminar grupos repetitivos y valores multivaluados

**Preguntas guía**:
1. ¿Hay atributos con múltiples valores en una sola celda?
2. ¿Existen grupos de atributos que se repiten?
3. ¿Cada intersección fila-columna contiene exactamente un valor?

#### Paso 2B: Segunda Forma Normal (2FN) (15 minutos)
**Objetivo**: Eliminar dependencias parciales

**Preguntas guía**:
1. ¿Hay atributos que dependen solo de parte de la clave primaria compuesta?
2. ¿Qué entidades nuevas surgen de separar estas dependencias?
3. ¿Cómo se conectan las nuevas entidades con las originales?

#### Paso 2C: Tercera Forma Normal (3FN) (15 minutos)
**Objetivo**: Eliminar dependencias transitivas

**Preguntas guía**:
1. ¿Hay atributos que dependen de otros atributos no-clave?
2. ¿Qué información se puede inferir indirectamente?
3. ¿El esquema está libre de redundancias innecesarias?

### Fase 3: Implementación DDL (60 minutos)

#### Paso 3A: Creación de Tablas Base (30 minutos)
**Instrucciones**:
1. Transforma cada entidad a una tabla
2. Define tipos de datos apropiados
3. Establece claves primarias
4. Documenta cada decisión de diseño

**Template DDL**:
```sql
-- ============================================
-- TABLA: [nombre_tabla]
-- PROPÓSITO: [descripción]
-- ============================================
CREATE TABLE [nombre_tabla] (
    [campo1] [tipo_dato] [constraints] COMMENT '[descripción]',
    [campo2] [tipo_dato] [constraints] COMMENT '[descripción]',
    -- ... más campos
    
    PRIMARY KEY ([campo_pk]),
    
    -- Índices adicionales
    INDEX idx_[nombre] ([campos])
);
```

#### Paso 3B: Implementación de Constraints (30 minutos)

**Constraints a implementar**:

1. **Foreign Keys**:
```sql
ALTER TABLE [tabla_hija] 
ADD CONSTRAINT fk_[nombre]
FOREIGN KEY ([campo_local]) REFERENCES [tabla_padre]([campo_referencia])
ON UPDATE CASCADE ON DELETE RESTRICT;
```

2. **Check Constraints**:
```sql
ALTER TABLE [tabla]
ADD CONSTRAINT chk_[nombre] 
CHECK ([condición]);
```

3. **Unique Constraints**:
```sql
ALTER TABLE [tabla]
ADD CONSTRAINT uk_[nombre]
UNIQUE ([campos]);
```

### Fase 4: Validación y Pruebas (30 minutos)

#### Paso 4A: Inserción de Datos de Prueba (15 minutos)
**Objetivo**: Validar que el esquema funciona correctamente

**Datos mínimos requeridos**:
- 3 tipos diferentes de usuarios
- 10 recursos variados (libros, revistas, multimedia)
- 5 préstamos activos con diferentes estados
- 2 reservas pendientes

#### Paso 4B: Consultas de Validación (15 minutos)
**Ejecuta estas consultas para verificar integridad**:

```sql
-- 1. Verificar integridad referencial
SELECT 'Préstamos órfanos' as verificacion, COUNT(*) as errores
FROM prestamos p 
LEFT JOIN usuarios u ON p.usuario_id = u.id 
WHERE u.id IS NULL;

-- 2. Verificar restricciones de negocio
SELECT 'Fechas inconsistentes' as verificacion, COUNT(*) as errores
FROM prestamos 
WHERE fecha_prestamo > fecha_devolucion_esperada;

-- 3. Verificar normalización
SELECT 'Datos redundantes' as verificacion, 
       COUNT(*) - COUNT(DISTINCT CONCAT(campo1, campo2)) as redundancias
FROM [tabla_verificar];
```

## 📋 Entregables

### 1. Documentación de Análisis (1 página)
- Lista de entidades con justificación
- Lista de relaciones con cardinalidades
- Reglas de negocio identificadas

### 2. Diagrama ER Completo
- Modelo conceptual inicial
- Modelo lógico normalizado (3FN)
- Anotaciones de decisiones de diseño

### 3. Scripts DDL Comentados
- Creación de todas las tablas
- Implementación de todos los constraints
- Índices básicos para consultas frecuentes

### 4. Reporte de Validación (1 página)
- Datos de prueba insertados exitosamente
- Resultados de consultas de validación
- Identificación de posibles mejoras

## 🎯 Criterios de Evaluación

| Aspecto | Excelente (4) | Proficiente (3) | Básico (2) | Insuficiente (1) |
|---------|---------------|-----------------|------------|------------------|
| **Modelado ER** | Modelo completo, cardinalidades correctas, decisiones bien justificadas | Modelo adecuado con relaciones correctas | Modelo básico funcional | Modelo incompleto o con errores conceptuales |
| **Normalización** | Esquema en 3FN sin redundancias, decisiones de desnormalización justificadas | Esquema normalizado correctamente | Normalización básica aplicada | Sin normalización o aplicada incorrectamente |
| **Implementación DDL** | Código limpio, tipos de datos óptimos, constraints completos | Implementación funcional con buenas prácticas | Implementación básica que funciona | Código con errores o mal estructurado |
| **Documentación** | Documentación completa, decisiones justificadas, código comentado | Documentación adecuada y clara | Documentación básica presente | Documentación insuficiente o ausente |

## 🔗 Recursos de Apoyo

### 📚 Material de Consulta
- "Fundamentals of Database Systems" - Elmasri & Navathe (Capítulos 3-4)
- "Database Design for Mere Mortals" - Michael Hernandez
- Guías de normalización de bases de datos

### 🛠️ Herramientas Recomendadas
- **Modelado**: draw.io, Lucidchart, MySQL Workbench
- **Implementación**: MySQL Workbench, phpMyAdmin, DBeaver
- **Validación**: Cualquier cliente SQL con capacidades de scripting

### 🎯 Checklist de Calidad
- [ ] Todas las entidades tienen clave primaria definida
- [ ] Cardinalidades están claramente especificadas
- [ ] Foreign keys implementadas con acciones referencial apropiadas
- [ ] Tipos de datos son apropiados para cada dominio
- [ ] Nombres de tablas y campos siguen convenciones consistentes
- [ ] Código DDL está documentado y es ejecutable
- [ ] Datos de prueba validan el diseño correctamente

## 🧠 Preguntas Reflexivas Post-Actividad

1. **Análisis de decisiones**: ¿Qué decisiones de diseño fueron las más difíciles y cómo las resolviste?

2. **Trade-offs identificados**: ¿En qué casos consideraste desnormalizar y cuál fue tu razonamiento?

3. **Escalabilidad**: ¿Cómo crees que tu diseño se comportará con millones de registros?

4. **Evolución**: Si el sistema necesitara soporte para préstamos inter-bibliotecarios, ¿cómo modificarías tu diseño?

## 🔄 Conexión con Siguientes Actividades

Esta actividad sirve como base para:
- **Actividad 3**: Optimización de consultas sobre estos esquemas
- **Laboratorio 2**: Implementación física con diferentes SGBD
- **Unidad 2**: Poblado masivo de datos y consultas analíticas

## 📈 Indicadores de Impacto Desarrollados

- **A - Adaptación a contextos complejos**: Análisis de requerimientos ambiguos y traducción a modelos técnicos
- **B - Contribuciones académicas**: Documentación sistemática de decisiones de diseño
- **C - Soluciones innovadoras**: Decisiones creativas para resolver conflictos de modelado
- **D - Pensamiento crítico**: Evaluación de alternativas de diseño y sus implicaciones
