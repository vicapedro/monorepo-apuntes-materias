# Práctica 8: Variables Aleatorias Continuas

**Asignatura**: Simulación (SCD-1022) | Unidad 3  
**Prerrequisito**: Práctica 7 completada — clase `GeneradorVariables` con variables discretas

---

## Objetivo

Completar la clase `GeneradorVariables` con métodos para todas las distribuciones continuas requeridas en simulación (Normal, Erlang, Gamma, Lognormal), usando métodos de convolución y composición. Esta clase constituye el **motor estocástico del simulador final**.

---

## Instrucciones

### Parte 1 — Ampliar con distribuciones continuas

Agregar al archivo `variables_aleatorias.py`:

```python
# Agregar dentro de la clase GeneradorVariables:

def normal_box_muller(self, mu: float = 0, sigma: float = 1) -> float:
    """
    X ~ N(μ, σ²) por método de Box-Muller (convolución de dos U).
    NOTA: genera dos normales pero retorna solo una.
    """
    U1 = self.gen.siguiente()
    U2 = self.gen.siguiente()
    Z = math.sqrt(-2 * math.log(U1)) * math.cos(2 * math.pi * U2)
    return mu + sigma * Z

def normal_polar(self, mu: float = 0, sigma: float = 1) -> float:
    """
    X ~ N(μ, σ²) por método polar (Marsaglia 1964).
    Evita cálculos trigonométricos; más eficiente que Box-Muller.
    """
    while True:
        U1 = 2 * self.gen.siguiente() - 1  # U(-1, 1)
        U2 = 2 * self.gen.siguiente() - 1
        S = U1**2 + U2**2
        if 0 < S < 1:
            factor = math.sqrt(-2 * math.log(S) / S)
            return mu + sigma * U1 * factor

def erlang(self, k: int, lam: float) -> float:
    """
    X ~ Erlang(k, λ): convolución de k Exponenciales(λ).
    Fórmula eficiente: X = -ln(∏ᵢ Uᵢ) / λ
    """
    prod_u = 1.0
    for _ in range(k):
        prod_u *= self.gen.siguiente()
    return -math.log(prod_u) / lam

def lognormal(self, mu_log: float, sigma_log: float) -> float:
    """
    X ~ Lognormal(μ_log, σ_log): X = e^(Normal(μ_log, σ_log))
    Útil para tiempos de servicio con sesgo positivo.
    """
    Z = self.normal_polar(mu_log, sigma_log)
    return math.exp(Z)

def gamma_ahrens_dieter(self, alpha: float, beta: float) -> float:
    """
    X ~ Gamma(α, β) por método de Ahrens-Dieter.
    Para α >= 1: método de Marsaglia & Tsang (2000).
    Para α < 1: usa Gamma(1+α) * U^(1/α).
    """
    # Caso α < 1: reducción a α+1
    if alpha < 1:
        U = self.gen.siguiente()
        return self.gamma_ahrens_dieter(alpha + 1, beta) * U ** (1 / alpha)

    # Método de Marsaglia & Tsang para α >= 1
    d = alpha - 1/3
    c = 1 / math.sqrt(9 * d)
    while True:
        Z = self.normal_polar()
        V = (1 + c * Z) ** 3
        if V > 0:
            U = self.gen.siguiente()
            if U < 1 - 0.0331 * (Z**2)**2:
                return d * V / beta
            if math.log(U) < 0.5 * Z**2 + d * (1 - V + math.log(V)):
                return d * V / beta

def composicion_normal(self, mu: float, sigma: float,
                        p_cola_pesada: float = 0.0) -> float:
    """
    Ejemplo de composición: mezcla de Normal con colas pesadas.
    Con probabilidad (1-p): Normal(μ,σ)
    Con probabilidad p: Normal(μ, 3σ) — modela outliers ocasionales.
    """
    U = self.gen.siguiente()
    if U <= 1 - p_cola_pesada:
        return self.normal_polar(mu, sigma)
    else:
        return self.normal_polar(mu, 3 * sigma)
```

### Parte 2 — Verificación de la clase completa

Ejecutar verificación KS para todas las distribuciones implementadas:

```python
from scipy import stats
import numpy as np

gen = GeneradorVariables()
n = 2000

pruebas = [
    ("Normal(5,2)",      [gen.normal_polar(5, 2) for _ in range(n)],
     stats.norm, (5, 2)),
    ("Erlang(3,0.5)",    [gen.erlang(3, 0.5) for _ in range(n)],
     stats.erlang, (3, 0, 1/0.5)),
    ("Lognormal(0,0.5)", [gen.lognormal(0, 0.5) for _ in range(n)],
     stats.lognorm, (0.5, 0, 1)),
]

print(f"\n{'Distribución':25} {'KS Stat':>10} {'p-valor':>10} {'Resultado':>12}")
print("-" * 60)
for nombre, muestras, dist, params in pruebas:
    stat, pval = stats.kstest(muestras, dist.name, args=params)
    resultado = "PASA" if pval >= 0.05 else "FALLA"
    print(f"{nombre:25} {stat:>10.4f} {pval:>10.4f} {resultado:>12}")
```

### Parte 3 — Benchmarking: LCG vs numpy

Comparar estadísticas de 10,000 muestras de `normal_polar()` vs `numpy.random.normal()`:

```python
import numpy as np
from scipy import stats

n = 10000
mu, sigma = 5.0, 2.0

# Generador propio
muestras_lcg = [gen.normal_polar(mu, sigma) for _ in range(n)]

# numpy (Mersenne Twister)
muestras_np = np.random.normal(mu, sigma, n).tolist()

for nombre, muestras in [("LCG+BoxMuller", muestras_lcg), ("NumPy", muestras_np)]:
    print(f"\n{nombre}:")
    print(f"  Media: {np.mean(muestras):.4f} (esperada: {mu})")
    print(f"  Std:   {np.std(muestras):.4f} (esperada: {sigma})")
    stat, pval = stats.kstest(muestras, 'norm', args=(mu, sigma))
    print(f"  KS:    {stat:.4f}, p={pval:.4f} — {'PASA' if pval>=0.05 else 'FALLA'}")
```

### Parte 4 — Aplicación al sistema real

Para el sistema de la Práctica 1, generar 500 muestras de cada variable de entrada continua usando `GeneradorVariables` y verificar que se ajustan a la distribución propuesta.

---

## Entregables

- `variables_aleatorias.py` **completo** con todos los métodos (discretos de P7 + continuos de P8)
- Tabla de resultados KS para todas las distribuciones
- Gráficas Q-Q para Normal, Erlang y Lognormal
- Comparación LCG vs numpy para la distribución Normal
- Reporte PDF

**NOTA**: este archivo `variables_aleatorias.py` es el **insumo principal** de las Prácticas 10 y 11 (Unidad 4) y del Proyecto Integrador (Unidad 5).

**Ponderación**: Parte de las Prácticas 6-8 que representan el 50% de la Unidad 3.
