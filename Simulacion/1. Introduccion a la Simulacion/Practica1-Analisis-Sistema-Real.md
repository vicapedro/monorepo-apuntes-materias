# Práctica 1: Análisis de un Sistema Real para Simulación

**Asignatura**: Simulación (SCD-1022)  
**Unidad**: 1 — Introducción a la Simulación  
**Modalidad**: Equipo (3-4 integrantes)  
**Duración estimada**: 3 horas de laboratorio + 3 horas autónomas  
**Entrega**: Reporte PDF en Moodle

---

## Objetivo

Analizar un sistema productivo o de servicios real o hipotético para identificar sus componentes, variables clave y distribuciones estadísticas candidatas, como punto de partida del proyecto integrador del curso.

## Competencias a Desarrollar

- Interpreta el uso y limitaciones de la simulación computacional en el ámbito de una empresa real para apoyar la toma de decisiones de forma eficaz
- Identifica entidades, recursos, colas, eventos y variables de estado de un sistema candidato a simulación

---

## Introducción

Antes de implementar cualquier simulador, es necesario comprender profundamente el sistema que se va a modelar. Esta práctica establece las bases del **proyecto integrador** que se desarrollará a lo largo del curso. El sistema seleccionado aquí será el mismo que se simulará en la Unidad 5.

El archivo [../../Ejercicios.md](../../Ejercicios.md) contiene un ejemplo de análisis ya realizado para una **Clínica de Diálisis con 8 máquinas**, que puede consultarse como referencia de la profundidad esperada en el análisis.

---

## Material Necesario

### Herramientas
- Procesador de texto (Word, LibreOffice, o Markdown)
- Python 3.x con las bibliotecas: `matplotlib`, `numpy`, `scipy` (para histogramas opcionales)
- Acceso a internet para investigación del sistema

### Sistemas candidatos sugeridos (elegir uno o proponer otro)
- Aeropuerto (área de check-in o seguridad)
- Bodega de distribución de productos
- Sistema de control de tránsito vehicular (intersección)
- Servicio de recepción de hotel
- Sistema de cobranza / caja de supermercado
- Sistema de inspección de calidad en manufactura
- Centro de atención telefónica (call center)
- Farmacia o clínica de consulta externa
- Servidor web bajo carga (simulación de sistema de cómputo)
- Sistema de mantenimiento de equipos industriales

---

## Instrucciones

### Sección 1 — Descripción General del Sistema (20 pts)

1. Nombre y descripción del sistema elegido
2. Contexto organizacional: ¿en qué tipo de empresa u organización opera?
3. Objetivo del estudio de simulación: ¿qué pregunta de toma de decisiones se quiere responder?
4. Justificación: ¿por qué la simulación es la herramienta adecuada para este sistema? ¿Existe solución analítica?

### Sección 2 — Identificación de Componentes (30 pts)

Completar las siguientes tablas:

**Entidades del sistema:**

| Entidad | Descripción | Atributos relevantes |
|---------|-------------|---------------------|
| | | |

**Recursos del sistema:**

| Recurso | Capacidad | Descripción |
|---------|-----------|-------------|
| | | |

**Colas del sistema:**

| Cola | Recurso asociado | Disciplina (FIFO/LIFO/Prioridad) |
|------|-----------------|----------------------------------|
| | | |

**Tipos de eventos:**

| Evento | Descripción | ¿Qué cambia en el estado del sistema? |
|--------|-------------|--------------------------------------|
| | | |

### Sección 3 — Variables de Entrada y Salida (25 pts)

**Variables de entrada (inputs estocásticos):**

| Variable | Descripción | Distribución candidata | Justificación |
|----------|-------------|----------------------|---------------|
| Tiempo entre llegadas | | ¿Exponencial? ¿Poisson? | |
| Tiempo de servicio | | ¿Normal? ¿Erlang? | |
| | | | |

**Variables de salida (métricas de desempeño):**

| Métrica | Descripción | Unidad de medida |
|---------|-------------|-----------------|
| Tiempo promedio en el sistema | | minutos |
| Utilización del recurso | | porcentaje (%) |
| Longitud promedio de cola | | número de entidades |
| | | |

### Sección 4 — Diagrama de Flujo del Sistema (15 pts)

Construir un diagrama de flujo que muestre el recorrido de una entidad típica a través del sistema, desde su llegada hasta su salida. Incluir:
- Punto de llegada
- Decisiones (¿hay recursos disponibles?)
- Colas
- Actividades de servicio
- Punto de salida
- Posibles rutas alternativas

Usar draw.io, Lucidchart, o cualquier herramienta de diagramas. Exportar como imagen e incluir en el reporte.

### Sección 5 — Hipótesis de Modelado (10 pts)

Listar los supuestos y simplificaciones que se adoptarán en el modelo:

| Supuesto | Justificación |
|---------|--------------|
| | |

Ejemplo: "Se asume que los tiempos de llegada siguen una distribución Exponencial" — justificar con teoría o datos observados.

---

## Formato del Reporte

```
Portada: nombre de la práctica, asignatura, equipo, fecha
Sección 1: Descripción general (1 página)
Sección 2: Componentes del sistema (tablas)
Sección 3: Variables de entrada y salida (tablas)
Sección 4: Diagrama de flujo (imagen + descripción)
Sección 5: Hipótesis de modelado
Conclusiones: reflexión sobre la complejidad del sistema y retos esperados para la simulación
Referencias: mínimo 2 fuentes sobre el sistema real elegido
```

---

## Notas

- El sistema elegido en esta práctica será el **mismo sistema** que se simulará en la Unidad 5 (Proyecto Integrador). Elegir un sistema de complejidad adecuada: suficientemente complejo para requerir simulación, pero manejable en el tiempo del curso.
- Se recomienda elegir un sistema del que pueda obtenerse información real (visita, entrevista, datos históricos) para la validación posterior.
- Consultar el ejemplo de la Clínica de Diálisis en [../../Ejercicios.md](../../Ejercicios.md) para calibrar el nivel de detalle esperado.

---

## Criterios de Evaluación

| Sección | Puntos |
|---------|--------|
| Sección 1: Descripción general | 20 |
| Sección 2: Componentes | 30 |
| Sección 3: Variables | 25 |
| Sección 4: Diagrama de flujo | 15 |
| Sección 5: Hipótesis | 10 |
| **Total** | **100** |

**Ponderación dentro de la Unidad 1**: 40%
