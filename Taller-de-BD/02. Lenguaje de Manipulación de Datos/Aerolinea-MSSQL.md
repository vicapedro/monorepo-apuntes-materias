# Ejercicio Guiado: Aerolínea con Fechas en Zona Horaria Local - MS SQL Server

## Objetivo
Comprender el manejo de fechas y zonas horarias en Microsoft SQL Server mediante un sistema de aerolínea donde cada vuelo almacena horarios en las zonas horarias locales de origen y destino.

## Contexto del Problema

**AeroGlobal** es una aerolínea internacional que debe:

1. **Almacenar** horarios de salida en la zona horaria de la ciudad de origen
2. **Almacenar** horarios de llegada en la zona horaria de la ciudad de destino  
3. **Convertir** a zona horaria de la sede (México UTC-6) para reportes centralizados
4. **Calcular** tiempos reales de vuelo considerando diferencias horarias

---

## Paso 1: Estructura de la Base de Datos para SQL Server

### Tabla: `ciudades`
```sql
-- Crear base de datos
CREATE DATABASE AeroGlobal;
GO
USE AeroGlobal;
GO

-- Tabla de ciudades con información de zona horaria
CREATE TABLE ciudades (
    ciudad_id INT IDENTITY(1,1) PRIMARY KEY,
    nombre NVARCHAR(50) NOT NULL,
    codigo_iata CHAR(3) UNIQUE NOT NULL,
    zona_horaria NVARCHAR(50) NOT NULL,
    offset_utc DECIMAL(3,1) NOT NULL
);

-- Datos de ejemplo
INSERT INTO ciudades (nombre, codigo_iata, zona_horaria, offset_utc) VALUES 
('Ciudad de México', 'MEX', 'Central Standard Time', -6.0),
('Nueva York', 'JFK', 'Eastern Standard Time', -5.0),
('Londres', 'LHR', 'GMT Standard Time', 0.0),
('Tokio', 'NRT', 'Tokyo Standard Time', 9.0),
('Los Ángeles', 'LAX', 'Pacific Standard Time', -8.0);
```

### Tabla: `vuelos`
```sql
CREATE TABLE vuelos (
    vuelo_id INT IDENTITY(1,1) PRIMARY KEY,
    numero_vuelo NVARCHAR(10) NOT NULL,
    ciudad_origen_id INT NOT NULL,
    ciudad_destino_id INT NOT NULL,
    
    -- Horarios almacenados en zona horaria LOCAL de cada ciudad
    salida_local DATETIME2 NOT NULL,        -- En zona horaria de origen
    llegada_local DATETIME2 NOT NULL,       -- En zona horaria de destino
    
    -- Estado del vuelo
    estado NVARCHAR(20) CHECK (estado IN ('programado', 'en_vuelo', 'completado', 'cancelado')) 
           DEFAULT 'programado',
    
    CONSTRAINT FK_vuelos_origen FOREIGN KEY (ciudad_origen_id) REFERENCES ciudades(ciudad_id),
    CONSTRAINT FK_vuelos_destino FOREIGN KEY (ciudad_destino_id) REFERENCES ciudades(ciudad_id)
);

-- Datos de ejemplo (horarios en zona local de cada ciudad)
INSERT INTO vuelos (numero_vuelo, ciudad_origen_id, ciudad_destino_id, salida_local, llegada_local, estado) VALUES
('AG101', 1, 2, '2025-10-15 08:00:00', '2025-10-15 17:30:00', 'programado'),  -- MEX 8:00 → JFK 17:30
('AG201', 1, 3, '2025-10-15 22:00:00', '2025-10-16 15:45:00', 'programado'),  -- MEX 22:00 → LHR 15:45
('AG301', 2, 4, '2025-10-16 10:00:00', '2025-10-17 12:20:00', 'programado');  -- JFK 10:00 → NRT 12:20
```

### Tabla: `reservas`
```sql
CREATE TABLE reservas (
    reserva_id INT IDENTITY(1,1) PRIMARY KEY,
    vuelo_id INT NOT NULL,
    pasajero_nombre NVARCHAR(100) NOT NULL,
    fecha_reserva DATETIME2 DEFAULT GETDATE(),
    
    CONSTRAINT FK_reservas_vuelo FOREIGN KEY (vuelo_id) REFERENCES vuelos(vuelo_id)
);

INSERT INTO reservas (vuelo_id, pasajero_nombre, fecha_reserva) VALUES
(1, 'Juan Pérez García', '2025-10-13 14:30:00'),
(2, 'María López Silva', '2025-10-13 16:45:00'),
(3, 'Robert Johnson', '2025-10-14 09:15:00');
```

---

## Paso 2: Conversiones de Zona Horaria con DATETIMEOFFSET

### 2.1 Funciones auxiliares para conversión de zonas horarias

```sql
-- Función para convertir datetime a DATETIMEOFFSET según offset UTC
CREATE FUNCTION dbo.ConvertirAUTC(
    @fecha DATETIME2,
    @offset_utc DECIMAL(3,1)
)
RETURNS DATETIMEOFFSET
AS
BEGIN
    DECLARE @offset_horas INT = CAST(@offset_utc AS INT);
    DECLARE @offset_minutos INT = CAST((@offset_utc - @offset_horas) * 60 AS INT);
    
    RETURN TODATETIMEOFFSET(@fecha, @offset_horas * 60 + @offset_minutos);
END;
GO
```

### 2.2 Consulta para mostrar horarios con conversiones

```sql
-- Consulta para boleto: mostrar horarios locales y convertidos
SELECT 
    v.numero_vuelo,
    co.nombre AS ciudad_origen,
    co.codigo_iata AS codigo_origen,
    cd.nombre AS ciudad_destino,
    cd.codigo_iata AS codigo_destino,
    
    -- Horarios almacenados (ya están en zona local)
    v.salida_local AS salida_hora_local,
    v.llegada_local AS llegada_hora_local,
    
    -- Conversión a UTC para cálculos
    DATEADD(HOUR, -co.offset_utc, v.salida_local) AS salida_utc,
    DATEADD(HOUR, -cd.offset_utc, v.llegada_local) AS llegada_utc,
    
    -- Conversión a zona horaria de la sede (México UTC-6)
    DATEADD(HOUR, -co.offset_utc + (-6), v.salida_local) AS salida_sede_mexico,
    DATEADD(HOUR, -cd.offset_utc + (-6), v.llegada_local) AS llegada_sede_mexico,
    
    -- Tiempo de vuelo real (en UTC)
    DATEDIFF(MINUTE, 
        DATEADD(HOUR, -co.offset_utc, v.salida_local),
        DATEADD(HOUR, -cd.offset_utc, v.llegada_local)
    ) / 60.0 AS tiempo_vuelo_horas
    
FROM vuelos v
INNER JOIN ciudades co ON v.ciudad_origen_id = co.ciudad_id
INNER JOIN ciudades cd ON v.ciudad_destino_id = cd.ciudad_id
WHERE v.vuelo_id = 1;
```

**Resultado esperado para vuelo AG101 (MEX → JFK):**
```
numero_vuelo: AG101
ciudad_origen: Ciudad de México (MEX)
ciudad_destino: Nueva York (JFK)
salida_hora_local: 2025-10-15 08:00:00    (hora de México)
llegada_hora_local: 2025-10-15 17:30:00   (hora de Nueva York)
tiempo_vuelo_horas: 4.5                   (tiempo real considerando zonas)
```

---

## Paso 3: Vista para Generar Boletos

```sql
-- Vista completa para generar boletos
CREATE VIEW vista_boletos AS
SELECT 
    r.reserva_id,
    r.pasajero_nombre,
    v.numero_vuelo,
    
    -- Información de origen
    co.nombre AS origen_ciudad,
    co.codigo_iata AS origen_codigo,
    FORMAT(v.salida_local, 'dd/MM/yyyy HH:mm') AS salida_local_formato,
    
    -- Información de destino
    cd.nombre AS destino_ciudad,
    cd.codigo_iata AS destino_codigo,
    FORMAT(v.llegada_local, 'dd/MM/yyyy HH:mm') AS llegada_local_formato,
    
    -- Tiempo de vuelo calculado correctamente
    CONCAT(
        DATEDIFF(MINUTE, 
            DATEADD(HOUR, -co.offset_utc, v.salida_local),
            DATEADD(HOUR, -cd.offset_utc, v.llegada_local)
        ) / 60, 'h ',
        DATEDIFF(MINUTE, 
            DATEADD(HOUR, -co.offset_utc, v.salida_local),
            DATEADD(HOUR, -cd.offset_utc, v.llegada_local)
        ) % 60, 'm'
    ) AS duracion_vuelo,
    
    -- Diferencia de zona horaria (jet lag)
    CAST(cd.offset_utc - co.offset_utc AS NVARCHAR(10)) + ' horas' AS diferencia_horaria,
    
    -- Fecha de reserva
    FORMAT(r.fecha_reserva, 'dd/MM/yyyy HH:mm') AS fecha_reserva_formato
    
FROM reservas r
INNER JOIN vuelos v ON r.vuelo_id = v.vuelo_id
INNER JOIN ciudades co ON v.ciudad_origen_id = co.ciudad_id
INNER JOIN ciudades cd ON v.ciudad_destino_id = cd.ciudad_id;
GO

-- Consultar boleto específico
SELECT * FROM vista_boletos WHERE reserva_id = 1;
```

---

## Paso 4: Casos Complejos - Vuelos Transpacíficos

### 4.1 Vuelo que cruza la línea internacional de cambio de fecha

```sql
-- Insertar vuelo transpacífico
INSERT INTO vuelos (numero_vuelo, ciudad_origen_id, ciudad_destino_id, salida_local, llegada_local, estado) VALUES
('AG501', 5, 4, '2025-10-15 23:30:00', '2025-10-17 05:15:00', 'programado');  -- LAX → NRT

-- Consulta para analizar el cruce de fecha
SELECT 
    v.numero_vuelo,
    co.nombre AS origen,
    cd.nombre AS destino,
    
    -- Horarios locales almacenados
    v.salida_local AS salida_local_origen,
    v.llegada_local AS llegada_local_destino,
    
    -- Conversión a UTC para entender el vuelo real
    DATEADD(HOUR, -co.offset_utc, v.salida_local) AS salida_utc,
    DATEADD(HOUR, -cd.offset_utc, v.llegada_local) AS llegada_utc,
    
    -- Tiempo de vuelo real
    DATEDIFF(MINUTE, 
        DATEADD(HOUR, -co.offset_utc, v.salida_local),
        DATEADD(HOUR, -cd.offset_utc, v.llegada_local)
    ) / 60.0 AS horas_vuelo_real,
    
    -- Análisis de fechas
    CASE 
        WHEN DATEDIFF(DAY, v.salida_local, v.llegada_local) > 1
        THEN 'Cruza 2+ días por zona horaria'
        WHEN DATEDIFF(DAY, v.salida_local, v.llegada_local) = 1
        THEN 'Cruza 1 día por zona horaria'
        ELSE 'Mismo día en ambas zonas'
    END AS analisis_fechas
    
FROM vuelos v
INNER JOIN ciudades co ON v.ciudad_origen_id = co.ciudad_id
INNER JOIN ciudades cd ON v.ciudad_destino_id = cd.ciudad_id
WHERE v.numero_vuelo = 'AG501';
```

---

## Paso 5: Reportes Centralizados en Zona Horaria de la Sede

### 5.1 Reporte diario en zona horaria de México

```sql
-- Procedimiento para reporte de vuelos convertidos a zona de la sede
SELECT 
    v.numero_vuelo,
    CONCAT(co.codigo_iata, ' → ', cd.codigo_iata) AS ruta,
    
    -- Horarios convertidos a zona de México (UTC-6)
    DATEADD(HOUR, -co.offset_utc + (-6), v.salida_local) AS salida_mexico,
    DATEADD(HOUR, -cd.offset_utc + (-6), v.llegada_local) AS llegada_mexico,
    
    -- Horarios originales en zona local
    FORMAT(v.salida_local, 'HH:mm') + ' (' + co.codigo_iata + ')' AS salida_local_info,
    FORMAT(v.llegada_local, 'HH:mm') + ' (' + cd.codigo_iata + ')' AS llegada_local_info,
    
    -- Número de pasajeros
    COUNT(r.reserva_id) AS total_pasajeros,
    
    v.estado
    
FROM vuelos v
INNER JOIN ciudades co ON v.ciudad_origen_id = co.ciudad_id
INNER JOIN ciudades cd ON v.ciudad_destino_id = cd.ciudad_id
LEFT JOIN reservas r ON v.vuelo_id = r.vuelo_id
WHERE CAST(DATEADD(HOUR, -co.offset_utc + (-6), v.salida_local) AS DATE) = '2025-10-15'
GROUP BY v.vuelo_id, v.numero_vuelo, co.codigo_iata, cd.codigo_iata, 
         v.salida_local, v.llegada_local, co.offset_utc, cd.offset_utc, v.estado
ORDER BY DATEADD(HOUR, -co.offset_utc + (-6), v.salida_local);
```

---

## Paso 6: Ejercicios Prácticos

### Ejercicio 1: Cálculo de Jet Lag
Crear una consulta que calcule la diferencia horaria que experimentará un pasajero:

```sql
-- Tu consulta aquí
-- Pista: Usa cd.offset_utc - co.offset_utc para la diferencia
SELECT 
    v.numero_vuelo,
    co.nombre AS origen,
    cd.nombre AS destino,
    cd.offset_utc - co.offset_utc AS diferencia_horaria_horas
FROM vuelos v
INNER JOIN ciudades co ON v.ciudad_origen_id = co.ciudad_id
INNER JOIN ciudades cd ON v.ciudad_destino_id = cd.ciudad_id;
```

### Ejercicio 2: Vuelos Más Largos por Tiempo Real
Encontrar los 3 vuelos con mayor duración real (considerando zonas horarias):

```sql
-- Tu consulta aquí
-- Incluye: número de vuelo, ruta, duración real en horas y minutos
```

### Ejercicio 3: Horarios de Conexión Internacional
Calcular tiempo de conexión disponible considerando zonas horarias locales.

---

## Paso 7: Consideraciones Especiales de SQL Server

### 7.1 Uso de DATETIMEOFFSET para mayor precisión

```sql
-- Versión alternativa usando DATETIMEOFFSET (más robusta)
ALTER TABLE vuelos ADD 
    salida_con_offset DATETIMEOFFSET,
    llegada_con_offset DATETIMEOFFSET;

-- Actualizar con offsets correctos
UPDATE v SET 
    salida_con_offset = TODATETIMEOFFSET(v.salida_local, co.offset_utc * 60),
    llegada_con_offset = TODATETIMEOFFSET(v.llegada_local, cd.offset_utc * 60)
FROM vuelos v
INNER JOIN ciudades co ON v.ciudad_origen_id = co.ciudad_id
INNER JOIN ciudades cd ON v.ciudad_destino_id = cd.ciudad_id;

-- Consulta usando DATETIMEOFFSET
SELECT 
    numero_vuelo,
    salida_con_offset AT TIME ZONE 'Central Standard Time' AS salida_mexico,
    llegada_con_offset AT TIME ZONE 'Central Standard Time' AS llegada_mexico,
    DATEDIFF(MINUTE, salida_con_offset, llegada_con_offset) / 60.0 AS duracion_horas
FROM vuelos;
```

### 7.2 Manejo de horario de verano con SQL Server

```sql
-- Tabla para cambios de horario de verano
CREATE TABLE cambios_horario_verano (
    ciudad_id INT,
    año INT,
    inicio_verano DATETIME2,
    fin_verano DATETIME2,
    offset_invierno DECIMAL(3,1),
    offset_verano DECIMAL(3,1),
    CONSTRAINT FK_cambios_ciudad FOREIGN KEY (ciudad_id) REFERENCES ciudades(ciudad_id)
);

-- Ejemplo para Estados Unidos 2025
INSERT INTO cambios_horario_verano VALUES
(2, 2025, '2025-03-09 02:00:00', '2025-11-02 02:00:00', -5.0, -4.0); -- Nueva York
```

---

## Resumen de Conceptos Aplicados

1. **Almacenamiento local**: Fechas en zona horaria de cada ciudad
2. **Conversiones dinámicas**: DATEADD para cambiar zonas horarias
3. **Cálculos precisos**: Tiempo real de vuelo considerando offsets
4. **Formateo de fechas**: FORMAT() para presentación
5. **Joins complejos**: Relacionar múltiples tablas
6. **Funciones de fecha/hora**: DATEDIFF, DATEADD específicas de SQL Server
7. **Tipos de datos avanzados**: DATETIMEOFFSET para manejo robusto de zonas

## Entregables

1. Script T-SQL completo ejecutable en SQL Server
2. Consultas para boletos con horarios locales correctos
3. Reportes centralizados en zona horaria de la sede
4. Análisis de vuelos transpacíficos y cambios de fecha
5. Documentación de decisiones de diseño para SQL Server

*Este ejercicio demuestra el manejo avanzado de fechas y zonas horarias específico para Microsoft SQL Server en sistemas de aerolíneas internacionales.*