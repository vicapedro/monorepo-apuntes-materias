# Práctica 7: Variables Aleatorias Discretas

**Asignatura**: Simulación (SCD-1022) | Unidad 3  
**Prerrequisito**: Práctica 6 completada — `variables_aleatorias.py` con clase base

---

## Objetivo

Ampliar la clase `GeneradorVariables` con métodos para generar variables aleatorias **discretas** (Bernoulli, Binomial, Poisson, Geométrica, Uniforme discreta), encapsuladas de forma que sean reutilizables en el simulador de la Unidad 4-5.

---

## Instrucciones

### Parte 1 — Ampliar la clase `GeneradorVariables`

Agregar los siguientes métodos al archivo `variables_aleatorias.py` de la Práctica 6:

```python
# Agregar dentro de la clase GeneradorVariables:

def bernoulli(self, p: float) -> int:
    """
    X ~ Bernoulli(p). Retorna 1 con probabilidad p, 0 con probabilidad 1-p.
    Transformada inversa: X = 1 si U ≤ p, X = 0 si U > p.
    """
    return 1 if self.gen.siguiente() <= p else 0

def binomial(self, n: int, p: float) -> int:
    """
    X ~ Binomial(n, p).
    Convolución: suma de n variables Bernoulli(p) independientes.
    """
    return sum(self.bernoulli(p) for _ in range(n))

def geometrica(self, p: float) -> int:
    """
    X ~ Geométrica(p): número de ensayos hasta el primer éxito.
    Transformada inversa: X = ceil(ln(U) / ln(1-p))
    """
    U = self.gen.siguiente()
    return math.ceil(math.log(U) / math.log(1 - p))

def uniforme_discreta(self, a: int, b: int) -> int:
    """
    X ~ Uniforme discreta en {a, a+1, ..., b}.
    X = a + floor((b - a + 1) * U)
    """
    U = self.gen.siguiente()
    return a + int((b - a + 1) * U)

def poisson(self, lam: float) -> int:
    """
    X ~ Poisson(λ).
    Algoritmo de FDA acumulada (eficiente para λ pequeño).
    Para λ grande, usar el método de composición (ver Práctica 8).
    """
    x = 0
    p = math.exp(-lam)   # P(X=0)
    F = p                 # F(0)
    U = self.gen.siguiente()
    while U > F:
        x += 1
        p = p * lam / x
        F += p
    return x
```

### Parte 2 — Verificación de distribuciones discretas

```python
import numpy as np
import matplotlib.pyplot as plt
from scipy import stats

gen = GeneradorVariables()
n = 5000

# Poisson(λ=3): comparar frecuencias observadas vs. teóricas
muestras_p = [gen.poisson(lam=3) for _ in range(n)]
k_max = max(muestras_p)
obs = [muestras_p.count(k) for k in range(k_max + 1)]
esp = [n * stats.poisson.pmf(k, mu=3) for k in range(k_max + 1)]

plt.figure(figsize=(8, 4))
x = range(k_max + 1)
plt.bar([i - 0.2 for i in x], obs, width=0.4, label='Generada', alpha=0.7)
plt.bar([i + 0.2 for i in x], esp, width=0.4, label='Teórica', alpha=0.7)
plt.xlabel('k')
plt.ylabel('Frecuencia')
plt.title('Poisson(λ=3): Observada vs Teórica')
plt.legend()
plt.savefig('verificacion_poisson.png', dpi=150)
plt.show()

# Chi-cuadrada para comparar
chi2, pval = stats.chisquare(f_obs=obs, f_exp=esp)
print(f"Chi² = {chi2:.3f}, p = {pval:.4f} — {'PASA' if pval >= 0.05 else 'FALLA'}")
```

### Parte 3 — Experimento con el sistema de la Práctica 1

Identificar las variables discretas en el sistema real elegido. Por ejemplo:
- Número de clientes que llegan en un intervalo: Poisson
- ¿El cliente solicita servicio especial?: Bernoulli
- Número de artículos en la orden: Uniforme discreta

Para cada variable, generar 1000 muestras y verificar con chi-cuadrada.

---

## Entregables

- `variables_aleatorias.py` actualizado con métodos de variables discretas
- Gráficas de frecuencias observadas vs. teóricas para cada variable
- Tabla de resultados de la prueba chi-cuadrada
- Reporte PDF con análisis

**Ponderación**: Parte de las Prácticas 6-8 que representan el 50% de la Unidad 3.
