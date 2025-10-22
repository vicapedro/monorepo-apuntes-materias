# Ejercicio Guiado: Almacenamiento de Fechas con Zona Horaria en Aerolíneas

## Objetivo
Comprender el manejo de fechas y zonas horarias en bases de datos mediante un sistema de reservas de aerolínea que registra vuelos internacionales.

## Contexto del Problema

**AeroGlobal** es una aerolínea con sede en **Ciudad de México (UTC-6)** que opera vuelos internacionales. El sistema debe:

1. **Registrar** horarios de salida y llegada en la zona horaria de la sede (México)
2. **Mostrar** en boletos la hora local de cada ciudad (origen y destino)
3. **Calcular** el tiempo real de vuelo
4. **Manejar** cambios de horario de verano/invierno

---

## Paso 1: Estructura de la Base de Datos

### Tabla: `ciudades`
```sql
CREATE TABLE ciudades (
    ciudad_id INT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    codigo_iata CHAR(3) UNIQUE NOT NULL,
    zona_horaria VARCHAR(50) NOT NULL,
    offset_utc DECIMAL(3,1) NOT NULL
);

-- Datos de ejemplo
INSERT INTO ciudades VALUES 
(1, 'Ciudad de México', 'MEX', 'America/Mexico_City', -6.0),
(2, 'Nueva York', 'JFK', 'America/New_York', -5.0),
(3, 'Londres', 'LHR', 'Europe/London', 0.0),
(4, 'Tokio', 'NRT', 'Asia/Tokyo', 9.0),
(5, 'Los Ángeles', 'LAX', 'America/Los_Angeles', -8.0);
```

### Tabla: `vuelos`
```sql
CREATE TABLE vuelos (
    vuelo_id INT PRIMARY KEY,
    numero_vuelo VARCHAR(10) NOT NULL,
    ciudad_origen_id INT,
    ciudad_destino_id INT,
    -- Horarios en zona horaria de la sede (México UTC-6)
    salida_programada_sede DATETIME NOT NULL,
    llegada_programada_sede DATETIME NOT NULL,
    -- Estado del vuelo
    estado ENUM('programado', 'en_vuelo', 'completado', 'cancelado') DEFAULT 'programado',
    
    FOREIGN KEY (ciudad_origen_id) REFERENCES ciudades(ciudad_id),
    FOREIGN KEY (ciudad_destino_id) REFERENCES ciudades(ciudad_id)
);

-- Datos de ejemplo
INSERT INTO vuelos VALUES
(1, 'AG101', 1, 2, '2025-10-15 08:00:00', '2025-10-15 16:30:00', 'programado'),
(2, 'AG201', 1, 3, '2025-10-15 22:00:00', '2025-10-16 16:45:00', 'programado'),
(3, 'AG301', 2, 4, '2025-10-16 10:00:00', '2025-10-17 15:20:00', 'programado');
```

### Tabla: `reservas`
```sql
CREATE TABLE reservas (
    reserva_id INT PRIMARY KEY,
    vuelo_id INT,
    pasajero_nombre VARCHAR(100) NOT NULL,
    fecha_reserva DATETIME DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (vuelo_id) REFERENCES vuelos(vuelo_id)
);

INSERT INTO reservas VALUES
(1, 1, 'Juan Pérez García', '2025-10-13 14:30:00'),
(2, 2, 'María López Silva', '2025-10-13 16:45:00'),
(3, 3, 'Robert Johnson', '2025-10-14 09:15:00');
```

---

## Paso 2: Consultas de Conversión de Zona Horaria

### 2.1 Mostrar horarios en zona local de cada ciudad

```sql
-- Consulta para boleto: horarios en zona local
SELECT 
    v.numero_vuelo,
    co.nombre AS ciudad_origen,
    co.codigo_iata AS codigo_origen,
    cd.nombre AS ciudad_destino,
    cd.codigo_iata AS codigo_destino,
    
    -- Hora de salida en zona local del origen
    CONVERT_TZ(v.salida_programada_sede, 'America/Mexico_City', co.zona_horaria) 
        AS salida_local,
    
    -- Hora de llegada en zona local del destino
    CONVERT_TZ(v.llegada_programada_sede, 'America/Mexico_City', cd.zona_horaria) 
        AS llegada_local,
        
    -- Tiempo de vuelo calculado
    TIMEDIFF(v.llegada_programada_sede, v.salida_programada_sede) 
        AS tiempo_vuelo
        
FROM vuelos v
JOIN ciudades co ON v.ciudad_origen_id = co.ciudad_id
JOIN ciudades cd ON v.ciudad_destino_id = cd.ciudad_id
WHERE v.vuelo_id = 1;
```

**Resultado esperado:**
```
numero_vuelo: AG101
ciudad_origen: Ciudad de México (MEX)
ciudad_destino: Nueva York (JFK)
salida_local: 2025-10-15 08:00:00
llegada_local: 2025-10-15 17:30:00
tiempo_vuelo: 08:30:00
```

### 2.2 Generar boleto completo

```sql
-- Vista para generar boletos
CREATE VIEW vista_boletos AS
SELECT 
    r.reserva_id,
    r.pasajero_nombre,
    v.numero_vuelo,
    
    -- Información de origen
    co.nombre AS origen_ciudad,
    co.codigo_iata AS origen_codigo,
    DATE_FORMAT(
        CONVERT_TZ(v.salida_programada_sede, 'America/Mexico_City', co.zona_horaria),
        '%d/%m/%Y %H:%i'
    ) AS salida_local_formato,
    
    -- Información de destino
    cd.nombre AS destino_ciudad,
    cd.codigo_iata AS destino_codigo,
    DATE_FORMAT(
        CONVERT_TZ(v.llegada_programada_sede, 'America/Mexico_City', cd.zona_horaria),
        '%d/%m/%Y %H:%i'
    ) AS llegada_local_formato,
    
    -- Duración del vuelo
    SEC_TO_TIME(
        TIMESTAMPDIFF(SECOND, v.salida_programada_sede, v.llegada_programada_sede)
    ) AS duracion_vuelo,
    
    -- Fecha de reserva
    DATE_FORMAT(r.fecha_reserva, '%d/%m/%Y %H:%i') AS fecha_reserva_formato
    
FROM reservas r
JOIN vuelos v ON r.vuelo_id = v.vuelo_id
JOIN ciudades co ON v.ciudad_origen_id = co.ciudad_id
JOIN ciudades cd ON v.ciudad_destino_id = cd.ciudad_id;

-- Consultar boleto específico
SELECT * FROM vista_boletos WHERE reserva_id = 1;
```

---

## Paso 3: Casos Complejos - Vuelos que Cruzan Fechas

### 3.1 Vuelo nocturno México-Londres

```sql
-- Insertar vuelo nocturno que llega al día siguiente
INSERT INTO vuelos VALUES
(4, 'AG401', 1, 3, '2025-10-15 23:30:00', '2025-10-16 17:15:00', 'programado');

-- Consulta para mostrar la diferencia de fechas
SELECT 
    v.numero_vuelo,
    co.nombre AS origen,
    cd.nombre AS destino,
    
    -- En zona horaria de México (sede)
    v.salida_programada_sede AS salida_sede,
    v.llegada_programada_sede AS llegada_sede,
    
    -- En zona horaria local de cada ciudad
    CONVERT_TZ(v.salida_programada_sede, 'America/Mexico_City', co.zona_horaria) 
        AS salida_local,
    CONVERT_TZ(v.llegada_programada_sede, 'America/Mexico_City', cd.zona_horaria) 
        AS llegada_local,
        
    -- Tiempo de vuelo real
    TIMEDIFF(v.llegada_programada_sede, v.salida_programada_sede) AS duracion,
    
    -- ¿Cruza medianoche en origen?
    CASE 
        WHEN DATE(CONVERT_TZ(v.salida_programada_sede, 'America/Mexico_City', co.zona_horaria)) 
             != DATE(CONVERT_TZ(v.llegada_programada_sede, 'America/Mexico_City', co.zona_horaria))
        THEN 'Sí' 
        ELSE 'No' 
    END AS cruza_fecha_origen
    
FROM vuelos v
JOIN ciudades co ON v.ciudad_origen_id = co.ciudad_id
JOIN ciudades cd ON v.ciudad_destino_id = cd.ciudad_id
WHERE v.vuelo_id = 4;
```

---

## Paso 4: Ejercicios Prácticos

### Ejercicio 1: Cálculo de Jet Lag
Crear una consulta que calcule la diferencia horaria que experimentará un pasajero:

```sql
-- Tu consulta aquí
-- Pista: Usa la diferencia de offset_utc entre ciudades
```

### Ejercicio 2: Vuelos Más Largos
Encontrar los 3 vuelos con mayor duración:

```sql
-- Tu consulta aquí
-- Incluye: número de vuelo, ruta, duración en horas y minutos
```

### Ejercicio 3: Horarios de Conexión
Simular una conexión en JFK (Nueva York):
- Vuelo 1: MEX → JFK (llega 17:30 hora local)  
- Vuelo 2: JFK → NRT (sale 20:00 hora local)

Calcular el tiempo de conexión disponible.

---

## Paso 5: Consideraciones de Implementación Real

### Horario de Verano/Invierno

```sql
-- Tabla para manejar cambios de horario de verano
CREATE TABLE cambios_horario (
    ciudad_id INT,
    fecha_inicio DATE,
    fecha_fin DATE,
    offset_utc_verano DECIMAL(3,1),
    offset_utc_invierno DECIMAL(3,1),
    FOREIGN KEY (ciudad_id) REFERENCES ciudades(ciudad_id)
);

-- Ejemplo: Estados Unidos cambia horario primer domingo de noviembre
INSERT INTO cambios_horario VALUES
(2, '2025-03-09', '2025-11-02', -4.0, -5.0); -- Nueva York
```

**Nota:** Para validaciones de integridad más complejas (como verificar que la llegada sea posterior a la salida), se pueden usar constraints CHECK o implementar validaciones en la aplicación.

---

## Resumen de Conceptos Aplicados

1. **Almacenamiento centralizado**: Todas las fechas en zona horaria de la sede
2. **Conversión dinámica**: `CONVERT_TZ()` para mostrar horarios locales
3. **Cálculo de duraciones**: `TIMEDIFF()` y `TIMESTAMPDIFF()`
4. **Formateo de fechas**: `DATE_FORMAT()` para presentación
5. **Joins complejos**: Relacionar múltiples tablas para obtener información completa
6. **Vistas**: Simplificar consultas complejas y reutilizar lógica

## Entregables

1. Script SQL completo con todas las tablas y datos
2. Consultas para generar boletos con horarios locales
3. Reporte de vuelos con análisis de zonas horarias
4. Documentación de las decisiones de diseño tomadas

*Este ejercicio demuestra la importancia del manejo correcto de fechas y zonas horarias en sistemas distribuidos globalmente.*