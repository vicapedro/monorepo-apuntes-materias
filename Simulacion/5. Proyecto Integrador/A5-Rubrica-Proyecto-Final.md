# A5 — Instrumentos de Evaluación: Proyecto Integrador

**Asignatura**: Simulación (SCD-1022) | Unidad 5  
**Ponderación total**: 100% de la Unidad 5

---

## Rúbrica — Simulador Python (50% de Unidad 5)

| Criterio | Excelente (3) | Bueno (2) | Aceptable (1) | Insuficiente (0) | Peso |
|----------|--------------|-----------|---------------|------------------|------|
| **Integración del generador propio** | El simulador usa exclusivamente `GeneradorVariables` (de P8) para todas las variables aleatorias; se verifica con la ruta de importación correcta | Usa el generador para las variables principales; algunas secundarias usan `random` | Solo usa el generador para una variable | No integra el `GeneradorVariables` del curso | 20% |
| **Fidelidad al modelo conceptual** | El código implementa fielmente todos los componentes del modelo conceptual aprobado (entidades, recursos, colas, eventos) | Implementa los componentes principales con omisiones menores | Implementa solo parte del modelo conceptual | El código no corresponde al modelo conceptual | 25% |
| **Correctitud del motor DES** | Los procesos SimPy modelan correctamente la lógica del sistema: llegadas, espera en cola, servicio y salida; sin condiciones de carrera ni recursos no liberados | Lógica correcta con errores menores que no afectan los resultados principales | Funciona pero con errores de lógica que sesgan las métricas | No ejecuta o los resultados son claramente incorrectos | 30% |
| **Warm-up y réplicas** | Se implementa warm-up period; se ejecutan ≥ 20 réplicas con diferentes semillas; las métricas son calculadas solo sobre el período de estado estacionario | Warm-up implementado pero sin múltiples réplicas | Múltiples réplicas sin warm-up | Una sola ejecución sin consideración del período transitorio | 15% |
| **Calidad del código** | Código organizado en clase(s), con docstrings y nombres descriptivos; sin código duplicado; se puede ejecutar con `python simulador_proyecto.py` sin errores | Código funcional con documentación básica | Código funcional pero difícil de leer | Código incompleto o no ejecutable | 10% |

---

## Lista de Cotejo — Análisis Estadístico (30% de Unidad 5)

| # | Criterio | Cumple | No cumple |
|---|---------|--------|-----------|
| 1 | Se presentan resultados de al menos 20 réplicas | | |
| 2 | Se calcula el intervalo de confianza al 95% para Wq (o la métrica principal) | | |
| 3 | Se incluye histograma de la distribución de Wq entre réplicas | | |
| 4 | Se compara el valor simulado con el valor teórico o histórico (cuando existe) | | |
| 5 | El error relativo es < 15% (o se justifica si es mayor) | | |
| 6 | Se analizan al menos 3 escenarios distintos con sus IC al 95% | | |
| 7 | Se incluye prueba estadística (t de Student) para comparar escenarios con el base | | |
| 8 | Las gráficas tienen títulos, etiquetas de ejes y leyendas | | |
| 9 | Se interpreta el significado práctico de los resultados (no solo los números) | | |
| 10 | El reporte concluye con recomendaciones concretas para el sistema real | | |

**Calificación**: (cumplidos / 10) × 100

---

## Guía de Observación — Presentación Oral (20% de Unidad 5)

| Dimensión | Excelente (3) | Bueno (2) | Aceptable (1) | Insuficiente (0) |
|-----------|--------------|-----------|---------------|------------------|
| **Dominio del contenido** | Responde preguntas con precisión técnica; demuestra comprensión profunda de todos los componentes del simulador | Responde la mayoría de preguntas correctamente | Responde preguntas básicas pero con dificultad en los aspectos técnicos | No puede explicar los componentes del simulador | 
| **Demo funcional** | El simulador corre en vivo, produce resultados coherentes y el equipo los interpreta en tiempo real | El simulador corre pero con errores menores; los resultados se interpretan correctamente | El simulador corre pero los resultados no se interpretan correctamente | El simulador no corre en la presentación |
| **Claridad de la exposición** | La presentación tiene una narrativa coherente: problema → modelo → implementación → resultados → recomendaciones | Estructura clara con algunas digresiones | Estructura básica pero sin hilo conductor | Sin estructura visible |
| **Participación del equipo** | Todos los integrantes exponen una parte y pueden explicar el trabajo completo | La mayoría expone; hay uno o dos que solo presentan su parte | Un integrante domina; el resto no puede explicar el trabajo | Solo un integrante presenta y conoce el trabajo |
| **Recomendaciones prácticas** | Las recomendaciones son específicas, cuantificadas y respaldadas por los resultados del simulador | Recomendaciones válidas sin cuantificar | Recomendaciones genéricas no respaldadas por los datos | Sin recomendaciones o contradictorias con los resultados |

**Escala**: Excelente=3, Bueno=2, Aceptable=1, Insuficiente=0  
**Calificación**: (suma de puntos / 15) × 100

---

## Indicadores de Alcance (Unidad 5)

| Indicador | Evidencia esperada en el Proyecto Integrador |
|-----------|---------------------------------------------|
| **A** — Adapta a contextos complejos | El simulador modela un sistema con múltiples tipos de entidades, colas con prioridad, o variabilidad de parámetros según hora del día |
| **B** — Aportaciones | El equipo propone y evalúa un escenario de mejora propio, no solo los sugeridos en el enunciado |
| **C** — Soluciones no vistas | Implementa una extensión no cubierta en clase: balking, reneging, redes de colas, múltiples clases de clientes |
| **D** — Pensamiento crítico | Analiza las limitaciones del modelo y propone qué datos adicionales mejorarían la validación |
| **E** — Interdisciplinario | Conecta los resultados con conceptos de administración (costo-beneficio), estadística (diseño de experimentos) o IOC (teoría de colas) |
| **F** — Autónomo | El equipo investigó fuentes bibliográficas adicionales no mencionadas en el curso para fundamentar el modelo |
