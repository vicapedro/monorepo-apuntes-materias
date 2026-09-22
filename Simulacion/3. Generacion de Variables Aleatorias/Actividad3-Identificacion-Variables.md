# Actividad 3: Identificación de Variables Aleatorias en Sistemas Reales

**Asignatura**: Simulación (SCD-1022) | Unidad 3  
**Modalidad**: Equipo (3-4 personas)  
**Duración**: 1.5 horas clase + 3 horas autónomas  
**Metodología**: Aprendizaje Basado en Problemas (ABP)

---

## Objetivo

Identificar las variables aleatorias presentes en el sistema real elegido en la Práctica 1 y justificar la distribución de probabilidad apropiada para modelarlas, fundamentándose en datos empíricos o en la naturaleza del fenómeno.

---

## Instrucciones

### Parte 1 — Individual (30 min)

Cada integrante investiga y resume uno de los siguientes criterios de selección de distribuciones:

| Integrante | Criterio a investigar |
|-----------|----------------------|
| A | ¿Cuándo usar distribución Exponencial para tiempos de llegada? |
| B | ¿Cuándo usar distribución Normal vs Lognormal para tiempos de servicio? |
| C | ¿Cuándo usar Erlang? Relación con sumas de Exponenciales |
| D | ¿Cuándo usar Poisson para conteo de eventos? Relación con proceso de llegadas Markoviano |

Cada resumen debe incluir:
- Condiciones que deben cumplirse en el sistema real
- Un ejemplo de aplicación distinto al de las notas del curso
- La FDA y el parámetro(s) de la distribución

### Parte 2 — Equipo (45 min)

1. Regresar al sistema real descrito en la Práctica 1 (aeropuerto, farmacia, hospital, etc.)
2. Completar la siguiente tabla de variables:

| Variable | Tipo | Distribución propuesta | Parámetros estimados | Fuente/justificación |
|---------|------|----------------------|---------------------|---------------------|
| Tiempo entre llegadas | Continua | | | |
| Tiempo de servicio | Continua | | | |
| Número de llegadas/hora | Discreta | | | |
| [Variable propia 1] | | | | |
| [Variable propia 2] | | | | |

3. Para cada variable, justificar el por qué de la distribución elegida, usando al menos uno de los criterios investigados en la Parte 1.

4. Si existen datos históricos (reales o hipotéticos), proponer cómo estimarían los parámetros.

### Parte 3 — Presentación (15 min)

Cada equipo presenta durante 5 minutos:
- Sistema elegido y variables identificadas
- Distribución elegida para la variable más importante (tiempo entre llegadas o tiempo de servicio) con su justificación
- Pregunta de cierre: ¿qué pasaría si modelaran esa variable con una distribución incorrecta?

---

## Entregables

- Tabla de variables completada (entregar en formato PDF o Markdown)
- Resúmenes individuales de la Parte 1 (una página por integrante)

**Nota**: la información de esta actividad es el **diseño de entrada del simulador** — será usada directamente en las Prácticas 6-9 y en el Proyecto Integrador de la Unidad 5.
