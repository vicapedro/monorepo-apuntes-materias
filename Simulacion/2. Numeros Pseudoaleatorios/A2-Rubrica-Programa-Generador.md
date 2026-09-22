# A2 — Rúbrica: Programa Generador de Números Pseudoaleatorios (Prácticas 2-5)

**Asignatura**: Simulación (SCD-1022)  
**Instrumento**: Rúbrica analítica (4 niveles)  
**Ponderación en la Unidad 2**: 80% (Prácticas 2-4: 50% + Práctica 5 Monte Carlo: 30%)

---

## Rúbrica — Prácticas 2, 3 y 4 (50% de la Unidad 2)

| Criterio | Excelente (3) | Bueno (2) | Aceptable (1) | Insuficiente (0) | Peso |
|----------|--------------|-----------|---------------|------------------|------|
| **Correctitud del generador LCG** | Implementación correcta de la recurrencia; validación de parámetros; el generador produce exactamente la misma secuencia dada la misma semilla | Implementación correcta con mínimas imprecisiones (sin validación de parámetros) | Implementación parcialmente correcta; produce números pero con errores en la recurrencia o en la normalización | Implementación incorrecta o usa `random.random()` sin implementar LCG propio | 25% |
| **Pruebas de uniformidad (P3)** | Las 3 pruebas implementadas correctamente (chi², medias, varianza); interpreta el p-valor y la decisión estadística con precisión | Dos pruebas correctamente implementadas; interpretación adecuada | Una prueba correctamente implementada; interpretación básica | Pruebas presentes pero con errores de cálculo o sin interpretación | 25% |
| **Pruebas de independencia (P4)** | Las 3 pruebas implementadas (corridas, corridas/media, póquer); decisiones estadísticas correctas; archivo JSON actualizado correctamente | Dos pruebas correctas; decisiones adecuadas | Una prueba correcta; archivo JSON generado con datos parciales | Pruebas intentadas con errores significativos; archivo JSON incompleto | 25% |
| **Encadenamiento de prácticas** | El archivo generador_config.json fluye correctamente entre P2→P3→P4→P5; cada práctica carga y usa la configuración de la anterior | El encadenamiento funciona con intervención manual menor | El encadenamiento requiere modificaciones para funcionar | Las prácticas son independientes entre sí; no hay encadenamiento | 15% |
| **Calidad del reporte y código** | Código documentado con docstrings; reporte con análisis crítico de resultados; conclusiones propias; gráficas legibles | Código con comentarios básicos; reporte con resultados y análisis básico | Código sin documentar; reporte con resultados sin análisis | Reporte incompleto o código sin ejecutar | 10% |

---

## Rúbrica — Práctica 5: Monte Carlo (30% de la Unidad 2)

| Criterio | Excelente (3) | Bueno (2) | Aceptable (1) | Insuficiente (0) | Peso |
|----------|--------------|-----------|---------------|------------------|------|
| **Uso del generador LCG propio** | Monte Carlo implementado usando exclusivamente el generador LCG de P2; correcta transformación U(0,1)→U(a,b) | Generador LCG usado en los problemas principales con algún uso auxiliar de numpy | Generador LCG usado en al menos un problema | Monte Carlo implementado con `random.random()` sin usar el generador propio | 30% |
| **Análisis de convergencia** | Gráfica de convergencia con al menos 6 puntos; comparación visual con O(1/√n); tabla de errores; correcta interpretación | Gráfica de convergencia con 4-5 puntos; análisis básico | Gráfica de convergencia con 2-3 puntos | Sin análisis de convergencia | 25% |
| **Problemas resueltos** | Los 3 problemas resueltos correctamente (π, integral/inventario, propio) con resultados verificables | Dos problemas correctamente resueltos | Un problema resuelto | Solo el problema de π con código copiado | 25% |
| **Comparación LCG vs numpy** | Comparación cuantitativa clara; análisis de por qué convergen al mismo resultado para n grande | Comparación presente con resultados; análisis superficial | Comparación mencionada sin resultados numéricos | Sin comparación | 20% |

---

## Lista de Cotejo Mínima (verificación rápida)

- [ ] El archivo `generador_config.json` existe y contiene: semilla, a, c, m, resultados de las 6 pruebas
- [ ] El generador LCG implementa correctamente: $X_{n+1} = (a \cdot X_n + c) \mod m$, $U_n = X_n/m$
- [ ] Las 3 pruebas de uniformidad producen resultado NO RECHAZAR H0 para el generador
- [ ] Las 3 pruebas de independencia producen resultado NO RECHAZAR H0
- [ ] El código de Monte Carlo importa y usa el generador LCG de P2
- [ ] La gráfica de convergencia está incluida en el reporte
- [ ] Las conclusiones conectan el trabajo de la Unidad 2 con su uso futuro en simulación

---

## Indicadores de Alcance Evaluados

| Indicador | Criterios donde se evalúa |
|-----------|--------------------------|
| **A** — Adapta a contextos complejos | Implementación del generador en distintos escenarios de Monte Carlo |
| **B** — Aportaciones académicas | Análisis crítico en reportes; comparación de métodos |
| **C** — Propone soluciones no vistas | Problema 3 de elección propia; experimentos adicionales |
| **D** — Pensamiento crítico | Análisis de por qué RANDU falla; interpretación de las pruebas |
| **E** — Conocimiento interdisciplinario | Conexión con estadística, matemáticas y programación orientada a objetos |
| **F** — Trabajo autónomo | Investigación previa; encadenamiento de prácticas sin guía explícita |
