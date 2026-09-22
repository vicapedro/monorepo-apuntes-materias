# Actividad 5 / Proyecto Integrador: Simulador de Sistema Real

**Asignatura**: Simulación (SCD-1022) | Unidad 5  
**Modalidad**: Equipo (3-4 personas)  
**Duración**: Unidad completa — 30 horas (10 clase + 20 autónomas)  
**Metodología**: Aprendizaje Orientado a Proyectos (AOP)

---

## Descripción del Proyecto

Diseñar, implementar y analizar un **simulador de eventos discretos** completo para el sistema real identificado en la Práctica 1 (Unidad 1), integrando todos los componentes desarrollados a lo largo del curso:

- **GeneradorLCG** (Unidad 2) — fuente de números pseudoaleatorios
- **GeneradorVariables** (Unidad 3) — distribuciones de probabilidad
- **Motor DES** en SimPy (Unidad 4) — lógica de la simulación
- **Análisis estadístico** con Python — interpretación de resultados

---

## Fases del Proyecto

### Fase 1 — Modelo conceptual (Sesión 1 en clase)

**Producto**: Documento de modelo conceptual (1-2 páginas + diagrama)

Documentar formalmente:
1. Objetivo del estudio de simulación
2. Límites del sistema (qué incluir, qué excluir)
3. Diagrama de flujo del sistema (Mermaid)
4. Componentes: entidades, recursos, colas, eventos
5. Variables de entrada con distribuciones (de la Actividad 3)
6. Métricas de desempeño a estimar
7. Preguntas que el simulador debe responder

**Validación**: el modelo conceptual debe ser aprobado por el docente antes de proceder.

### Fase 2 — Implementación del núcleo (Semana 1-2 autónoma)

**Producto**: `simulador_proyecto.py` funcional

1. Adaptar la estructura base del `Apuntes-Proyecto-Integrador.md` al sistema específico
2. Integrar `GeneradorVariables` importado de `../3. Generacion de Variables Aleatorias/`
3. Implementar los procesos SimPy del sistema (mínimo: generador de llegadas + proceso de entidad + recurso)
4. Verificar con al menos 3 casos límite:
   - ρ → 0: Wq debe ser ≈ 0
   - ρ → 1: Wq debe ser muy grande
   - Carga media: comparar con valor teórico (si existe)

### Fase 3 — Análisis estadístico (Sesión 2 en clase)

**Producto**: Notebook o script `analisis_resultados.py`

1. Ejecutar 30 réplicas con diferentes semillas
2. Calcular IC al 95% para cada métrica
3. Determinar si el simulador está validado (error < 10% vs. teoría o datos históricos)
4. Graficar: histograma de Wq entre réplicas, serie temporal del inventario (si aplica), gráfica de utilización

### Fase 4 — Análisis de escenarios (Semana 3 autónoma)

**Producto**: Tabla comparativa de escenarios

Evaluar mínimo 3 escenarios:
| Escenario | Variable modificada | Hipótesis |
|-----------|---------------------|-----------|
| Base | — | Situación actual |
| A | Reducción 20% en tiempo de servicio | Mejora Wq |
| B | +1 servidor | Reduce Lq |
| C | [propuesto por el equipo] | [a definir] |

Para cada escenario: reportar Wq, W, Lq, ρ con IC al 95% y prueba t para comparar con el escenario base.

### Fase 5 — Presentación final (Sesiones 3-4 en clase)

**Producto**: Presentación de 15 minutos + demo del simulador en ejecución

Estructura de la presentación:
1. Descripción del sistema y objetivo del estudio (2 min)
2. Modelo conceptual y diagrama de flujo (2 min)
3. Demo en vivo del simulador corriendo (3 min)
4. Resultados y validación (3 min)
5. Análisis de escenarios y recomendaciones (3 min)
6. Preguntas (2 min)

---

## Referencia

Para el caso de la **Clínica de Diálisis** (ejemplo proporcionado en el archivo `../Ejercicios.md`):
- 8 máquinas (recursos)
- Tiempo de sesión: Normal(240, 30) minutos
- El análisis de ese sistema puede usarse como referencia de implementación

---

## Entregables

| # | Entregable | Fecha | Ponderación |
|---|-----------|-------|-------------|
| 1 | Modelo conceptual aprobado | Semana 1 | (requisito de avance) |
| 2 | `simulador_proyecto.py` funcional + verificación | Semana 3 | 50% (Rúbrica A5) |
| 3 | `analisis_resultados.py` + gráficas | Semana 4 | 30% (Lista cotejo) |
| 4 | Presentación oral + demo | Semana 5 | 20% (Guía observación) |

**NOTA**: el código del simulador debe estar en un repositorio Git con commits regulares que evidencien el trabajo progresivo del equipo.
