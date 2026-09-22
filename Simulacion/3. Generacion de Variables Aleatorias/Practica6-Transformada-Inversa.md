# Práctica 6: Método de la Transformada Inversa

**Asignatura**: Simulación (SCD-1022)  
**Unidad**: 3 — Generación de Variables Aleatorias  
**Prerrequisito**: Archivo `generador_config.json` de la Práctica 4

---

## Objetivo

Implementar el método de la transformada inversa para generar variables aleatorias continuas y discretas con distribuciones específicas, usando el generador LCG validado en la Unidad 2.

---

## Instrucciones

### Parte 1 — Investigación previa

1. Derivar la inversa de la FDA para: Uniforme(a,b), Exponencial(λ), Weibull(α,β), Triangular(a,b,c)
2. Explicar por qué la distribución Normal no tiene inversa analítica cerrada
3. Investigar el método de Box-Muller para la Normal

### Parte 2 — Implementación de la clase base

Crear el archivo `variables_aleatorias.py` con la clase `GeneradorVariables`:

```python
import math
import json
import sys
sys.path.insert(0, '../2. Numeros Pseudoaleatorios')
from practica2 import GeneradorLCG

class GeneradorVariables:
    """Motor de generación de variables aleatorias para el simulador."""

    def __init__(self, ruta_config: str = '../2. Numeros Pseudoaleatorios/generador_config.json'):
        with open(ruta_config) as f:
            config = json.load(f)
        self.gen = GeneradorLCG(
            semilla=config['semilla_original'],
            a=config['a'], c=config['c'], m=config['m']
        )

    # TODO: implementar los métodos del Apuntes-Variables-Aleatorias.md
    # Mínimo requerido para esta práctica:
    # - uniforme(a, b)
    # - exponencial(media)
    # - triangular(a, b, c)
    # - weibull(alpha, beta)
    # - poisson(lam)  ← discreta por transformada inversa
```

### Parte 3 — Verificación gráfica y estadística

Para cada distribución implementada:

```python
import numpy as np
import matplotlib.pyplot as plt
from scipy import stats

def verificar_distribucion(nombre: str, muestras: list,
                            dist_teo, params_teo: dict):
    """
    Genera histograma vs PDF teórica + prueba KS.
    """
    fig, axes = plt.subplots(1, 2, figsize=(12, 4))

    # Histograma vs PDF teórica
    axes[0].hist(muestras, bins=30, density=True, alpha=0.7,
                  label='Generada')
    x = np.linspace(min(muestras), max(muestras), 200)
    axes[0].plot(x, dist_teo.pdf(x, **params_teo), 'r-', lw=2,
                  label='Teórica')
    axes[0].set_title(f'Histograma vs PDF — {nombre}')
    axes[0].legend()

    # Q-Q plot
    (osm, osr), (slope, intercept, r) = stats.probplot(muestras,
                                                         dist=dist_teo,
                                                         sparams=list(params_teo.values()))
    axes[1].plot(osm, osr, 'b.', alpha=0.3)
    axes[1].plot(osm, slope*np.array(osm)+intercept, 'r-')
    axes[1].set_title(f'Q-Q Plot — {nombre} (R²={r**2:.4f})')

    plt.tight_layout()
    plt.savefig(f'verificacion_{nombre.lower()}.png', dpi=150)
    plt.show()

    # Prueba KS
    stat, pval = stats.kstest(muestras, dist_teo.name,
                               args=list(params_teo.values()))
    print(f"{nombre}: KS={stat:.4f}, p={pval:.4f} — "
          f"{'PASA' if pval >= 0.05 else 'FALLA'}")
    return pval >= 0.05


# Verificar cada distribución con n=1000 muestras
gen = GeneradorVariables()
n = 1000

# Exponencial media=5
muestras_exp = [gen.exponencial(5) for _ in range(n)]
verificar_distribucion('Exponencial(media=5)', muestras_exp,
                        stats.expon, {'loc': 0, 'scale': 5})

# Triangular a=2, b=8, c=5
muestras_tri = [gen.triangular(2, 8, 5) for _ in range(n)]
verificar_distribucion('Triangular(2,8,5)', muestras_tri,
                        stats.triang, {'c': 0.5, 'loc': 2, 'scale': 6})
```

### Parte 4 — Aplicación a sistema real

Usando el sistema identificado en la Práctica 1, identificar qué distribución modela cada variable de entrada y generar muestras de prueba. Presentar histogramas con parámetros justificados.

---

## Entregables

- `variables_aleatorias.py` con la clase `GeneradorVariables` (Parte 2)
- Gráficas de verificación para cada distribución implementada (Parte 3)
- Tabla resumen con estadísticas de cada variable generada vs. teórica (Parte 4)
- Reporte PDF

**Ponderación**: Parte de las Prácticas 6-8 que representan el 50% de la Unidad 3.
