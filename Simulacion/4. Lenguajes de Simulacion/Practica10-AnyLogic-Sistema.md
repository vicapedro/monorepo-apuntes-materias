# Práctica 10: Simulación en AnyLogic — Sistema de Colas

**Asignatura**: Simulación (SCD-1022) | Unidad 4  
**Duración**: 3 horas  
**Software**: AnyLogic Personal Learning Edition (gratuito)

---

## Objetivo

Construir y ejecutar un modelo de simulación de eventos discretos usando AnyLogic PLE para un sistema de colas M/M/c, interpretar las métricas de desempeño generadas automáticamente y comparar los resultados con los valores teóricos.

---

## Instrucciones

### Parte 1 — Instalación y verificación

1. Descargar AnyLogic PLE de https://www.anylogic.com/downloads/ (requiere registro gratuito)
2. Instalar y crear un nuevo modelo: **Discrete Event** → **Process Modeling Library**
3. Verificar que el workspace carga sin errores

### Parte 2 — Construcción del modelo M/M/2

Construir el diagrama de flujo en el canvas arrastrando bloques de la paleta:

```
Source → Queue → Delay → Sink
```

**Configuración de cada bloque:**

| Bloque | Parámetro | Valor |
|--------|----------|-------|
| Source | Arrival rate type | Rate |
| Source | Rate | `exponential(5)` (clientes/hora) |
| Queue | Maximum capacity | `MAX_VALUE` (infinito) |
| Delay | Delay time | `exponential(1.0/8)` horas |
| Delay | Number of servers | `2` (para M/M/2) |
| Sink | (ninguno) | — |

### Parte 3 — Estadísticas de desempeño

En la ventana de propiedades de **Queue**, activar:
- Statistics / Time in queue: habilitado
- Statistics / Queue length: habilitado

Agregar al canvas un bloque **Time Measurement** y conectarlo para medir el tiempo en sistema.

Agregar objetos **HistogramData** para:
- Distribución del tiempo en cola
- Distribución del tiempo en sistema

### Parte 4 — Parámetros del experimento

Crear parámetros del modelo (pestaña General):
- `TASA_LLEGADA = 5.0` (clientes/hora)
- `TASA_SERVICIO = 8.0` (clientes/hora)
- `NUM_SERVIDORES = 2`
- `TIEMPO_SIMULACION = 1000` (horas)

### Parte 5 — Ejecución y análisis

1. Ejecutar la simulación hasta `TIEMPO_SIMULACION = 1000` horas
2. Registrar en la tabla de resultados:

| Métrica | Valor simulado | Valor teórico M/M/2 | Error (%) |
|---------|---------------|---------------------|-----------|
| Utilización ρ = λ/(c·μ) | | 0.3125 | |
| Tiempo promedio en cola Wq | | 0.0068 hr | |
| Longitud promedio cola Lq | | 0.0342 clientes | |
| Tiempo promedio en sistema W | | 0.132 hr | |

**Fórmulas M/M/c para verificación manual:**
- ρ = λ/(c·μ) = 5/(2·8) = 0.3125
- P₀ (prob. sistema vacío) se calcula con la fórmula Erlang-C

3. ¿Qué pasa si `NUM_SERVIDORES = 1`? Comparar resultados.

### Parte 6 — Experimento de diseño

Usar el **Experiment Wizard → Parameter Variation** para evaluar el efecto de variar `TASA_LLEGADA` de 1 a 7.5 clientes/hora (paso 0.5) sobre la métrica `queue.statsTimeInQueue.mean()`.

Exportar los resultados como CSV y graficar en Python:

```python
import pandas as pd
import matplotlib.pyplot as plt

df = pd.read_csv('anylogic_results.csv')
plt.figure(figsize=(8, 5))
plt.plot(df['TASA_LLEGADA'], df['Wq_simulado'], 'b-o', label='Simulado')
# Agregar curva teórica M/M/2
plt.xlabel('Tasa de llegada λ (clientes/hora)')
plt.ylabel('Tiempo en cola Wq (horas)')
plt.title('Efecto de λ sobre Wq — Simulación vs Teoría M/M/2')
plt.legend()
plt.grid(True, alpha=0.3)
plt.savefig('anylogic_variacion_lambda.png', dpi=150)
plt.show()
```

---

## Entregables

- Captura de pantalla del modelo en AnyLogic con el diagrama de flujo construido
- Tabla de resultados comparando simulado vs. teórico (Parte 5)
- Gráfica de variación de λ (Parte 6)
- Reporte PDF con análisis e interpretación de los resultados

**Ponderación**: 35% de la Unidad 4
