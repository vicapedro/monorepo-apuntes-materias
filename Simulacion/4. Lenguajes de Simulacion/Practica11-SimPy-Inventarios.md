# Práctica 11: Simulación con SimPy — Sistema de Inventarios

**Asignatura**: Simulación (SCD-1022) | Unidad 4  
**Prerrequisito**: `variables_aleatorias.py` completo de la Práctica 8  
**Duración**: 3 horas

---

## Objetivo

Implementar en Python con SimPy un simulador de sistema de inventarios con política (s, Q) — punto de reorden s, cantidad de reorden Q — integrando el generador de variables aleatorias propio (Unidades 2 y 3), y comparar los resultados con el modelo equivalente en AnyLogic (Práctica 10).

---

## Fundamento Teórico

### Política de inventario (s, Q)

- **s** (punto de reorden): cuando el inventario cae a nivel s, se emite una orden de Q unidades
- **Q** (cantidad de reorden): cantidad fija a pedir cada vez
- **Lead time** (L): tiempo entre emitir la orden y recibirla (sigue una distribución)
- **Demanda** (D): variable aleatoria por período

**Costo total** = Costo de mantenimiento + Costo de pedido + Costo por agotamiento

---

## Instrucciones

### Parte 1 — Instalación de SimPy

```bash
pip install simpy
```

Verificar: `python -c "import simpy; print(simpy.__version__)"`

### Parte 2 — Implementación del simulador

```python
import simpy
import sys
sys.path.insert(0, '../3. Generacion de Variables Aleatorias')
from variables_aleatorias import GeneradorVariables

gen = GeneradorVariables()

# Parámetros del sistema de inventario
S_REORDEN  = 20      # punto de reorden s
Q_PEDIDO   = 40      # cantidad de reorden Q
INV_INICIAL = 60     # inventario inicial
DEMANDA_MEDIA = 5    # unidades/día (Poisson)
LEAD_TIME_MIN = 3    # días (Uniforme)
LEAD_TIME_MAX = 7    # días
COSTO_MANT   = 2.0   # $/unidad/día
COSTO_PEDIDO = 50.0  # $/orden
COSTO_AGOT   = 10.0  # $/unidad faltante/día

class SistemaInventario:
    def __init__(self, env, gen_var):
        self.env = env
        self.gen = gen_var
        self.inventario = INV_INICIAL
        self.pedido_pendiente = False

        # Métricas
        self.costo_total = 0.0
        self.dias_agotado = 0
        self.num_pedidos = 0
        self.historico_inv = []

    def proceso_demanda(self):
        """Genera demanda diaria y actualiza inventario."""
        while True:
            yield self.env.timeout(1)  # un día
            demanda = self.gen.poisson(DEMANDA_MEDIA)
            if demanda > self.inventario:
                faltante = demanda - self.inventario
                self.dias_agotado += 1
                self.costo_total += faltante * COSTO_AGOT
                self.inventario = 0
            else:
                self.inventario -= demanda

            # Costo de mantenimiento diario
            self.costo_total += self.inventario * COSTO_MANT
            self.historico_inv.append((self.env.now, self.inventario))

            # Revisar política (s, Q)
            if self.inventario <= S_REORDEN and not self.pedido_pendiente:
                self.pedido_pendiente = True
                self.env.process(self.proceso_pedido())

    def proceso_pedido(self):
        """Simula el lead time y la llegada del pedido."""
        self.num_pedidos += 1
        self.costo_total += COSTO_PEDIDO

        lead_time = self.gen.uniforme_discreta(LEAD_TIME_MIN, LEAD_TIME_MAX)
        yield self.env.timeout(lead_time)

        self.inventario += Q_PEDIDO
        self.pedido_pendiente = False

# Ejecutar simulación
env = simpy.Environment()
sistema = SistemaInventario(env, gen)
env.process(sistema.proceso_demanda())

DIAS_SIMULACION = 365
env.run(until=DIAS_SIMULACION)

# Reportar resultados
print(f"\n{'='*50}")
print(f"RESULTADOS: Sistema de Inventario (s={S_REORDEN}, Q={Q_PEDIDO})")
print(f"{'='*50}")
print(f"Días simulados:        {DIAS_SIMULACION}")
print(f"Número de pedidos:     {sistema.num_pedidos}")
print(f"Días con agotamiento:  {sistema.dias_agotado}")
print(f"Inventario final:      {sistema.inventario:.0f} unidades")
print(f"Costo total:           ${sistema.costo_total:,.2f}")
print(f"Costo diario promedio: ${sistema.costo_total/DIAS_SIMULACION:.2f}")
```

### Parte 3 — Optimización de parámetros

Evaluar todas las combinaciones de s ∈ {10, 15, 20, 25} y Q ∈ {30, 40, 50, 60}:

```python
import itertools
import numpy as np

resultados = []
for s, Q in itertools.product([10, 15, 20, 25], [30, 40, 50, 60]):
    costos = []
    for semilla in range(10):  # 10 réplicas
        gen_r = GeneradorVariables()
        # ... ajustar S_REORDEN=s, Q_PEDIDO=Q
        # ... ejecutar simulación y registrar costo diario promedio
        pass

    resultados.append({
        's': s, 'Q': Q,
        'costo_medio': np.mean(costos),
        'costo_std': np.std(costos)
    })

# Encontrar combinación óptima
mejor = min(resultados, key=lambda r: r['costo_medio'])
print(f"Política óptima: s={mejor['s']}, Q={mejor['Q']}, "
      f"costo={mejor['costo_medio']:.2f} ± {mejor['costo_std']:.2f} $/día")
```

### Parte 4 — Comparación con AnyLogic

Implementar el mismo sistema de inventario en AnyLogic usando la librería de Agentes o bloques personalizados, y comparar:

| Métrica | SimPy | AnyLogic | Diferencia (%) |
|---------|-------|---------|---------------|
| Costo total 365 días | | | |
| Número de pedidos | | | |
| Días con agotamiento | | | |
| Política óptima (s,Q) | | | |

---

## Entregables

- `practica11_inventario.py` con el código completo (Partes 2 y 3)
- Tabla de optimización (todas las combinaciones s,Q)
- Tabla comparativa SimPy vs AnyLogic (Parte 4)
- Reporte PDF con análisis y recomendación de política óptima

**Ponderación**: 35% de la Unidad 4
