# A4 — Lista de Cotejo y Rúbrica: Prácticas de Lenguajes de Simulación

**Asignatura**: Simulación (SCD-1022) | Unidad 4  
**Instrumentos**: Lista de cotejo (Actividad 4) + Rúbrica (Prácticas 10 y 11)

---

## Lista de Cotejo — Actividad 4: Cuadro Comparativo (15%)

| # | Criterio | Cumple | No cumple |
|---|---------|--------|-----------|
| 1 | El cuadro comparativo incluye al menos 4 herramientas distintas | | |
| 2 | Se comparan al menos 6 criterios relevantes | | |
| 3 | Cada criterio tiene información específica, no genérica | | |
| 4 | Se cita al menos un caso de uso real por herramienta | | |
| 5 | Se justifica la selección de herramienta para el proyecto final | | |
| 6 | La justificación conecta la herramienta con el sistema real de su proyecto | | |
| 7 | La presentación fue coherente y respondió las preguntas planteadas | | |

**Calificación**: (cumplidos / 7) × 100

---

## Rúbrica — Práctica 10: AnyLogic (35%)

| Criterio | Excelente (3) | Bueno (2) | Aceptable (1) | Insuficiente (0) | Peso |
|----------|--------------|-----------|---------------|------------------|------|
| **Construcción del modelo** | Diagrama de flujo correcto con todos los bloques configurados y parámetros del modelo definidos | Diagrama correcto con configuración básica | Diagrama incompleto o con errores menores | Modelo no ejecutable o incorrecto | 35% |
| **Estadísticas AnyLogic** | Se activan y reportan todas las estadísticas requeridas (tiempo en cola, longitud, tiempo en sistema) | Reporta la mayoría de estadísticas | Reporta solo tiempo en cola | No hay estadísticas configuradas | 25% |
| **Comparación teórica** | Tabla completa con valores simulados, teóricos y error%; todos los errores < 10% | Errores < 15% en las métricas principales | Tabla incompleta o errores > 15% | Sin comparación teórica | 25% |
| **Experimento de variación** | Gráfica generada con Python, etiquetada, con curva teórica superpuesta | Gráfica generada sin curva teórica | Solo tabla de resultados sin gráfica | Sin experimento de variación | 15% |

---

## Rúbrica — Práctica 11: SimPy (35%)

| Criterio | Excelente (3) | Bueno (2) | Aceptable (1) | Insuficiente (0) | Peso |
|----------|--------------|-----------|---------------|------------------|------|
| **Uso de GeneradorVariables** | El simulador importa y usa exclusivamente el GeneradorVariables de la Práctica 8 (sin random de Python) | Usa el generador para la mayoría de variables | Lo usa para alguna variable, usa random para otras | No usa el generador propio | 25% |
| **Implementación SimPy** | Procesos bien definidos (demanda, pedido), política (s,Q) correctamente implementada, sin errores de concurrencia | Implementación funcional con errores menores | Funciona pero con lógica de la política incorrecta | No ejecuta o la política no está implementada | 35% |
| **Optimización (s,Q)** | Búsqueda exhaustiva de la política óptima con al menos 3 réplicas por combinación; política óptima claramente identificada | Evaluación de varias combinaciones sin réplicas | Evaluación solo de la combinación inicial | Sin optimización | 25% |
| **Comparación SimPy vs AnyLogic** | Tabla completa con al menos 4 métricas comparadas, con análisis de discrepancias | 3 métricas comparadas | Solo 1-2 métricas sin análisis | Sin comparación | 15% |

---

## Indicadores de Alcance (Prácticas 10 y 11)

| Indicador | Evidencia esperada |
|-----------|-------------------|
| **A** — Adapta a contextos | Aplica el modelo a su sistema real, no solo al ejemplo del enunciado |
| **B** — Aportaciones | Propone mejoras al modelo o métricas adicionales |
| **C** — Soluciones no vistas | Implementa una variante de la política (s,S) en lugar de (s,Q) |
| **D** — Pensamiento crítico | Analiza el impacto de usar GeneradorVariables vs random de Python |
| **E** — Interdisciplinario | Conecta con teoría de colas, administración de inventarios, estadística |
| **F** — Autónomo | Investiga y aplica bibliografía adicional no cubierta en clase |
