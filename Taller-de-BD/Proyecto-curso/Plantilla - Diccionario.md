# Diccionario de Datos - [Nombre del Proyecto]

## Información del Proyecto
- **Proyecto:** [Nombre del proyecto]
- **Estudiante(s):** [Nombre(s) del/los estudiante(s)]
- **Fecha de creación:** [Fecha]
- **Última actualización:** [Fecha]
- **Versión:** [Número de versión]

---

## Introducción

El diccionario de datos es un documento que describe la estructura, características y restricciones de todos los elementos de datos utilizados en el sistema de base de datos. Este documento sirve como referencia técnica para desarrolladores, administradores de base de datos y usuarios finales.

### Propósito
- Documentar la estructura completa de la base de datos
- Establecer estándares para nombres y tipos de datos
- Facilitar el mantenimiento y evolución del sistema
- Servir como referencia para nuevos desarrolladores

### Alcance
Este diccionario cubre todas las tablas, vistas, procedimientos almacenados, funciones y demás objetos de la base de datos [Nombre del proyecto].

---

## Convenciones de Nomenclatura

### Estándares Utilizados
- **Tablas:** PascalCase (ej. `Clientes`, `DetallesPedido`)
- **Columnas:** PascalCase (ej. `ClienteID`, `FechaNacimiento`)
- **Claves primarias:** `[NombreTabla]ID` (ej. `ClienteID`, `ProductoID`)
- **Claves foráneas:** `[TablaReferenciada]ID` (ej. `ClienteID` en tabla Pedidos)
- **Índices:** `IX_[NombreTabla]_[Columna(s)]`
- **Procedimientos:** `sp_[Acción]_[Entidad]` (ej. `sp_Insertar_Cliente`)

### Prefijos y Sufijos
- **sp_:** Procedimientos almacenados
- **fn_:** Funciones
- **vw_:** Vistas
- **IX_:** Índices
- **UK_:** Restricciones únicas
- **FK_:** Claves foráneas
- **CK_:** Restricciones de verificación

---

## Base de Datos

### Información General
- **Nombre de la base de datos:** [NombreBaseDatos]
- **Servidor:** [Nombre del servidor]
- **SGBD:** [SQL Server/MySQL/PostgreSQL] versión [X.X]
- **Collation:** [SQL_Latin1_General_CP1_CI_AS / utf8mb4_unicode_ci / etc.]
- **Tamaño inicial:** [XX MB]
- **Crecimiento automático:** [XX% / XX MB]

### Configuración de Archivos
| **Archivo** | **Tipo** | **Ubicación** | **Tamaño Inicial** | **Crecimiento** |
|-------------|----------|---------------|-------------------|-----------------|
| [NombreDB].mdf | Datos | [Ruta] | [XX MB] | [XX MB] |
| [NombreDB].ldf | Log | [Ruta] | [XX MB] | [XX%] |

---

## Catálogo de Tablas

### Resumen de Tablas

| **#** | **Nombre Tabla** | **Descripción** | **Registros Estimados** | **Relaciones** |
|-------|------------------|-----------------|-------------------------|----------------|
| 1 | [NombreTabla1] | [Descripción breve] | [Cantidad] | [Cantidad FK] |
| 2 | [NombreTabla2] | [Descripción breve] | [Cantidad] | [Cantidad FK] |
| ... | ... | ... | ... | ... |

---

## Definición de Tablas

### Plantilla de Tabla (Copiar para cada tabla)

## Tabla: [NombreTabla]

### Descripción
[Descripción detallada del propósito y contenido de la tabla]

### Información Técnica
- **Esquema:** [dbo/esquema personalizado]
- **Tipo:** [Tabla base/Temporal/Particionada]
- **Registros estimados:** [Cantidad]
- **Tamaño estimado:** [XX KB/MB]

### Estructura de Campos

| **Campo** | **Tipo de Dato** | **Longitud** | **Nulos** | **Clave** | **Default** | **Descripción** |
|-----------|------------------|--------------|-----------|-----------|-------------|-----------------|
| [NombreCampo1] | [INT/VARCHAR/etc.] | [Longitud] | [Sí/No] | [PK/FK/UK] | [Valor] | [Descripción del campo] |
| [NombreCampo2] | [NVARCHAR] | [50] | [No] | | | [Descripción del campo] |
| [NombreCampo3] | [DATETIME2] | [7] | [Sí] | | [GETDATE()] | [Descripción del campo] |

### Restricciones

#### Clave Primaria
- **Nombre:** `PK_[NombreTabla]`
- **Campos:** `[Campo1], [Campo2]`
- **Descripción:** [Descripción de la clave primaria]

#### Claves Foráneas
| **Nombre** | **Campo Local** | **Tabla Referenciada** | **Campo Referenciado** | **Acción** |
|------------|----------------|------------------------|------------------------|------------|
| FK_[Nombre] | [Campo] | [Tabla] | [Campo] | [CASCADE/RESTRICT/etc.] |

#### Restricciones Únicas
| **Nombre** | **Campos** | **Descripción** |
|------------|------------|-----------------|
| UK_[Nombre] | [Campo1, Campo2] | [Descripción] |

#### Restricciones de Verificación
| **Nombre** | **Condición** | **Descripción** |
|------------|---------------|-----------------|
| CK_[Nombre] | [Condición SQL] | [Descripción] |

#### Valores Predeterminados
| **Campo** | **Valor** | **Descripción** |
|-----------|-----------|-----------------|
| [Campo] | [Valor/Función] | [Descripción] |

### Índices

| **Nombre** | **Tipo** | **Campos** | **Único** | **Propósito** |
|------------|----------|------------|-----------|---------------|
| IX_[Nombre] | [CLUSTERED/NONCLUSTERED] | [Campo1, Campo2] | [Sí/No] | [Descripción] |

### Reglas de Negocio
1. [Regla de negocio 1]
2. [Regla de negocio 2]
3. [Regla de negocio 3]

### Ejemplos de Datos
```sql
-- Ejemplos de registros típicos
INSERT INTO [NombreTabla] ([Campo1], [Campo2], [Campo3]) VALUES
('[Valor1]', '[Valor2]', '[Valor3]'),
('[Valor1]', '[Valor2]', '[Valor3]');
```

---

## Vistas

### [NombreVista]

#### Descripción
[Descripción del propósito de la vista]

#### Definición
```sql
CREATE VIEW [NombreVista] AS
SELECT 
    [Campos]
FROM [Tablas]
WHERE [Condiciones];
```

#### Campos Expuestos
| **Campo** | **Origen** | **Tipo** | **Descripción** |
|-----------|------------|----------|-----------------|
| [Campo] | [Tabla.Campo] | [Tipo] | [Descripción] |

---

## Procedimientos Almacenados

### [NombreProcedimiento]

#### Descripción
[Descripción del propósito del procedimiento]

#### Parámetros
| **Parámetro** | **Tipo** | **Dirección** | **Descripción** |
|---------------|----------|---------------|-----------------|
| @[Parametro1] | [Tipo] | [IN/OUT/INOUT] | [Descripción] |

#### Ejemplo de Uso
```sql
EXEC [NombreProcedimiento] @[Parametro1] = '[Valor]';
```

---

## Funciones

### [NombreFuncion]

#### Descripción
[Descripción del propósito de la función]

#### Parámetros
| **Parámetro** | **Tipo** | **Descripción** |
|---------------|----------|-----------------|
| @[Parametro1] | [Tipo] | [Descripción] |

#### Valor de Retorno
- **Tipo:** [Tipo de dato]
- **Descripción:** [Descripción del valor retornado]

#### Ejemplo de Uso
```sql
SELECT dbo.[NombreFuncion]('[Parametro]') AS Resultado;
```

---

## Triggers

### [NombreTrigger]

#### Descripción
[Descripción del propósito del trigger]

#### Información Técnica
- **Tabla:** [NombreTabla]
- **Evento:** [INSERT/UPDATE/DELETE]
- **Momento:** [AFTER/INSTEAD OF]

#### Lógica
[Descripción de la lógica implementada]

---

## Diagramas de Relaciones

### Diagrama Entidad-Relación
[Insertar aquí el diagrama ER o referencia al archivo]

### Modelo Físico
[Insertar aquí el modelo físico o referencia al archivo]

---

## Dominios de Datos

### Catálogos de Valores

#### [NombreCatalogo]
| **Código** | **Descripción** | **Activo** |
|------------|-----------------|------------|
| [Codigo1] | [Descripción1] | [Sí/No] |
| [Codigo2] | [Descripción2] | [Sí/No] |

---

## Seguridad

### Usuarios y Roles
| **Usuario/Rol** | **Tipo** | **Permisos** | **Descripción** |
|-----------------|----------|--------------|-----------------|
| [Usuario1] | [Usuario/Rol] | [SELECT/INSERT/etc.] | [Descripción] |

### Políticas de Acceso
1. [Política 1]
2. [Política 2]
3. [Política 3]

---

## Mantenimiento

### Estrategia de Respaldos
- **Tipo:** [Completo/Diferencial/Transaccional]
- **Frecuencia:** [Diaria/Semanal/etc.]
- **Retención:** [XX días/meses]

### Índices y Estadísticas
- **Reorganización:** [Frecuencia]
- **Reconstrucción:** [Frecuencia]
- **Actualización de estadísticas:** [Frecuencia]

### Trabajos Programados
| **Trabajo** | **Frecuencia** | **Descripción** |
|-------------|----------------|-----------------|
| [NombreTrabajo] | [Frecuencia] | [Descripción] |

---

## Versionado

### Historial de Cambios

| **Versión** | **Fecha** | **Autor** | **Descripción** |
|-------------|-----------|-----------|-----------------|
| 1.0 | [Fecha] | [Nombre] | Versión inicial |
| 1.1 | [Fecha] | [Nombre] | [Descripción de cambios] |

### Scripts de Migración
- **v1.0 → v1.1:** [Nombre del script o descripción]

---

## Glosario de Términos

| **Término** | **Definición** |
|-------------|----------------|
| [Término1] | [Definición clara y concisa] |
| [Término2] | [Definición clara y concisa] |

---

## Anexos

### A. Scripts de Creación
[Referencia a los archivos de scripts DDL]

### B. Datos de Prueba
[Referencia a los archivos de datos de prueba]

### C. Documentación Adicional
[Referencias a documentos relacionados]

---

## Contacto y Soporte

### Responsables del Proyecto
- **Desarrollador:** [Nombre del estudiante]
- **Email:** [email@ejemplo.com]
- **Instructor:** [Nombre del instructor]

### Información de Soporte
- **Documentación técnica:** [Ubicación]
- **Repositorio de código:** [URL si aplica]
- **Base de conocimiento:** [Ubicación]

---

**Nota:** Este documento debe mantenerse actualizado con cada cambio en la estructura de la base de datos. Se recomienda revisar y actualizar mensualmente o después de cada implementación de cambios significativos.

---

*Documento generado el [Fecha] - Versión [X.X]*
*© [Año] - [Nombre del estudiante/institución]*
