# A3 — Lista de Cotejo: Prácticas de Variables Aleatorias (P6-P9)

**Asignatura**: Simulación (SCD-1022) | Unidad 3  
**Instrumento**: Lista de cotejo  
**Ponderación**: 30% (Práctica 9) de la Unidad 3

---

## Lista de Cotejo — Práctica 9: Validación Estadística

| # | Criterio | Cumple | No cumple | Observación |
|---|---------|--------|-----------|-------------|
| 1 | La clase `GeneradorVariables` importa y usa el `GeneradorLCG` de la Práctica 2 | | | |
| 2 | Están implementados los métodos de variables **discretas**: Bernoulli, Binomial, Geométrica, Poisson, Uniforme discreta | | | |
| 3 | Están implementados los métodos de variables **continuas**: Uniforme, Exponencial, Normal (Box-Muller o polar), Erlang, Triangular | | | |
| 4 | La prueba KS se aplica correctamente a todas las variables continuas (con `scipy.stats.kstest`) | | | |
| 5 | La prueba chi-cuadrada se aplica correctamente a todas las variables discretas | | | |
| 6 | Las frecuencias esperadas en la chi-cuadrada se agrupan cuando $E_k < 5$ | | | |
| 7 | Todas las distribuciones implementadas **pasan** sus respectivas pruebas (NO SE RECHAZA H₀) | | | |
| 8 | El archivo `validacion_variables.json` existe y contiene resultados de todas las distribuciones | | | |
| 9 | Se incluyen gráficas Q-Q para al menos 3 distribuciones continuas | | | |
| 10 | El reporte documenta el diagnóstico y corrección de cualquier distribución que haya fallado | | | |
| 11 | Se incluye comparación de medias y varianzas observadas vs. teóricas en tabla | | | |
| 12 | El código está organizado con funciones/métodos, sin bloques de código repetidos | | | |
| 13 | El reporte tiene conclusiones que conectan el trabajo con su uso en el simulador de la Unidad 4 | | | |

**Total de criterios cumplidos**: ___ / 13  
**Calificación**: (cumplidos / 13) × 100

---

## Rúbrica Complementaria — Prácticas 6, 7 y 8 (50% de Unidad 3)

| Criterio | Excelente (3) | Bueno (2) | Aceptable (1) | Insuficiente (0) | Peso |
|----------|--------------|-----------|---------------|------------------|------|
| **Correctitud matemática** | Todas las fórmulas de transformada inversa son matemáticamente correctas; la derivación se presenta en el reporte | Fórmulas correctas sin derivación | Alguna fórmula con error menor que no afecta los resultados | Errores que producen muestras fuera del rango o con distribución incorrecta | 30% |
| **Encapsulamiento en clase** | Clase bien diseñada: constructor inyecta el generador, métodos con docstrings, sin variables globales | Clase funcional con documentación básica | Los métodos están en la clase pero con acoplamiento alto o variables globales | Funciones sueltas sin estructura de clase | 25% |
| **Verificación visual** | Histograma vs PDF teórica + Q-Q plot para cada distribución; gráficas etiquetadas y con leyenda | Histogramas para todas las distribuciones; Q-Q plots para algunas | Histogramas para la mayoría; sin Q-Q plots | Solo una gráfica o gráficas sin etiquetas | 25% |
| **Análisis e interpretación** | Interpreta los resultados estadísticos; conecta la precisión del generador con la calidad de la simulación | Análisis básico de los resultados | Resultados presentados sin interpretación | Solo datos numéricos sin contexto | 20% |

---

## Indicadores de Alcance Evaluados

| Indicador | Evidencia |
|-----------|----------|
| **A** — Adapta a contextos complejos | Implementación de distribuciones avanzadas (Gamma, Lognormal) |
| **B** — Aportaciones | Propuesta de método de validación adicional |
| **C** — Soluciones no vistas | Método alternativo de generación o validación |
| **D** — Pensamiento crítico | Diagnóstico y corrección cuando la distribución falla |
| **E** — Interdisciplinario | Conexión con estadística, álgebra y probabilidad |
| **F** — Autónomo | Investigación de métodos no cubiertos explícitamente en clase |
