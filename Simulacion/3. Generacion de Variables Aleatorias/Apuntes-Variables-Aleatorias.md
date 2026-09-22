# Unidad 3: Generación de Variables Aleatorias

**Asignatura**: Simulación (SCD-1022) — ISC — TecNM  
**Prerrequisito**: Archivo `generador_config.json` de la Práctica 4 (generador LCG validado)

---

## 3.1 Conceptos Básicos

Una **variable aleatoria** es una función que asigna un número real a cada resultado posible de un experimento aleatorio. En simulación, las variables aleatorias modelan las entradas estocásticas del sistema (tiempos entre llegadas, tiempos de servicio, demanda, etc.).

**Función de distribución acumulada (FDA)**: $F(x) = P(X \leq x)$

Propiedades:
- $F(-\infty) = 0$, $F(+\infty) = 1$
- $F(x)$ es no decreciente
- $F(x)$ es continua por la derecha

**Función de densidad de probabilidad (FDP)**: para variables continuas, $f(x) = F'(x)$

---

## 3.2 Variables Aleatorias Discretas

| Distribución | Parámetros | Media | Varianza | Aplicación en simulación |
|-------------|-----------|-------|----------|--------------------------|
| Bernoulli | $p$ | $p$ | $p(1-p)$ | ¿Un evento ocurre o no? |
| Binomial | $n, p$ | $np$ | $np(1-p)$ | Número de éxitos en n ensayos |
| **Poisson** | $\lambda$ | $\lambda$ | $\lambda$ | Número de llegadas en intervalo fijo |
| Geométrica | $p$ | $1/p$ | $(1-p)/p^2$ | Número de intentos hasta el primer éxito |
| Uniforme discreta | $a, b$ | $(a+b)/2$ | $(b-a+1)^2/12$ | Elección equiprobable entre alternativas |

### Generación por transformada inversa — Distribución Poisson

```python
def generar_poisson(lam: float, u: float) -> int:
    """
    Genera X ~ Poisson(λ) a partir de U ~ Uniforme(0,1)
    usando la FDA acumulada.
    """
    x = 0
    p = float('e')**(-lam)  # P(X=0) = e^(-λ)
    F = p                    # F(0) = P(X ≤ 0)

    while u > F:
        x += 1
        p = p * lam / x     # P(X=k) = P(X=k-1) * λ/k
        F += p

    return x
```

---

## 3.3 Variables Aleatorias Continuas

| Distribución | FDP | FDA | Media | Varianza |
|-------------|-----|-----|-------|----------|
| **Uniforme** $(a,b)$ | $\frac{1}{b-a}$ | $\frac{x-a}{b-a}$ | $\frac{a+b}{2}$ | $\frac{(b-a)^2}{12}$ |
| **Exponencial** $(\lambda)$ | $\lambda e^{-\lambda x}$ | $1-e^{-\lambda x}$ | $\frac{1}{\lambda}$ | $\frac{1}{\lambda^2}$ |
| **Normal** $(\mu,\sigma)$ | $\frac{1}{\sigma\sqrt{2\pi}}e^{-\frac{(x-\mu)^2}{2\sigma^2}}$ | — (no cerrada) | $\mu$ | $\sigma^2$ |
| **Erlang** $(k,\lambda)$ | — | — | $\frac{k}{\lambda}$ | $\frac{k}{\lambda^2}$ |
| **Triangular** $(a,b,c)$ | trapezoidal | — | $\frac{a+b+c}{3}$ | — |
| **Weibull** $(\alpha,\beta)$ | — | $1-e^{-(x/\beta)^\alpha}$ | $\beta\Gamma(1+1/\alpha)$ | — |

---

## 3.4 Métodos para Generar Variables Aleatorias

### 3.4.1 Método de la Transformada Inversa

**Principio**: si $F$ es la FDA de $X$ y $U \sim U(0,1)$, entonces $X = F^{-1}(U)$ tiene distribución $F$.

**Demostración**: $P(F^{-1}(U) \leq x) = P(U \leq F(x)) = F(x)$ ✓

**Aplicaciones directas** (tienen inversa en forma cerrada):

```python
import math

class GeneradorVariables:
    """
    Clase que encapsula la generación de variables aleatorias.
    Usa el generador LCG de la Unidad 2 como fuente de U ~ U(0,1).
    """

    def __init__(self, generador_lcg):
        """generador_lcg: instancia de GeneradorLCG de Práctica 2."""
        self.gen = generador_lcg

    def uniforme(self, a: float, b: float) -> float:
        """X = a + (b-a)*U"""
        U = self.gen.siguiente()
        return a + (b - a) * U

    def exponencial(self, media: float) -> float:
        """X = -(media)*ln(U)  [o equivalente: -ln(U)/λ]"""
        U = self.gen.siguiente()
        return -media * math.log(U)

    def triangular(self, a: float, b: float, c: float) -> float:
        """Método de transformada inversa para distribución Triangular."""
        U = self.gen.siguiente()
        Fc = (c - a) / (b - a)  # FDA en la moda c
        if U < Fc:
            return a + math.sqrt(U * (b - a) * (c - a))
        else:
            return b - math.sqrt((1 - U) * (b - a) * (b - c))

    def weibull(self, alpha: float, beta: float) -> float:
        """X = β·(-ln(U))^(1/α)"""
        U = self.gen.siguiente()
        return beta * (-math.log(U)) ** (1 / alpha)
```

### 3.4.2 Método de Convolución

Para distribuciones que son suma de variables independientes.

**Distribución Erlang(k, λ)**: suma de k variables Exponenciales(λ):

$$X_{Erlang} = -\frac{1}{\lambda} \sum_{i=1}^{k} \ln(U_i) = -\frac{1}{\lambda} \ln\left(\prod_{i=1}^{k} U_i\right)$$

```python
def erlang(self, k: int, lam: float) -> float:
    """
    X ~ Erlang(k, λ) = suma de k Exponenciales(λ).
    Media = k/λ, Varianza = k/λ²
    """
    producto = 1.0
    for _ in range(k):
        producto *= self.gen.siguiente()
    return -math.log(producto) / lam
```

**Distribución Normal por Box-Muller** (convolución de dos U):

$$Z_1 = \sqrt{-2\ln(U_1)} \cos(2\pi U_2), \quad Z_2 = \sqrt{-2\ln(U_1)} \sin(2\pi U_2)$$

```python
def normal(self, mu: float, sigma: float) -> float:
    """
    X ~ N(μ, σ) usando el método de Box-Muller.
    Genera dos variables normales estándar a partir de dos U(0,1).
    """
    import math
    U1 = self.gen.siguiente()
    U2 = self.gen.siguiente()
    Z = math.sqrt(-2 * math.log(U1)) * math.cos(2 * math.pi * U2)
    return mu + sigma * Z
```

### 3.4.3 Método de Composición

Para distribuciones que son mezcla (combinación lineal convexa) de otras distribuciones:

$$F(x) = \sum_{i=1}^{n} p_i F_i(x), \quad \sum p_i = 1$$

**Algoritmo**:
1. Generar $U_1 \sim U(0,1)$
2. Seleccionar componente $j$ tal que $\sum_{i=1}^{j-1} p_i < U_1 \leq \sum_{i=1}^{j} p_i$
3. Generar $X$ de la distribución $F_j$ usando transformada inversa

```python
def composicion(self, distribuciones: list, pesos: list):
    """
    Genera X de una mezcla de distribuciones.
    distribuciones: lista de funciones generadoras
    pesos: lista de probabilidades (deben sumar 1)
    """
    U = self.gen.siguiente()
    acum = 0
    for i, (f, p) in enumerate(zip(distribuciones, pesos)):
        acum += p
        if U <= acum:
            return f()
    return distribuciones[-1]()  # último componente
```

---

## 3.5 Procedimientos Especiales

### Método de Aceptación-Rechazo

Para distribuciones sin forma cerrada de la inversa. Requiere una distribución instrumental $g(x)$ tal que $f(x) \leq c \cdot g(x)$.

```python
def aceptacion_rechazo(self, f_objetivo, g_gen, c: float) -> float:
    """
    Método de aceptación-rechazo.
    f_objetivo: función de densidad objetivo f(x)
    g_gen: generador de la distribución instrumental
    c: constante tal que f(x) ≤ c·g(x) para todo x
    """
    while True:
        Y = g_gen()                     # muestra de g
        U = self.gen.siguiente()        # U ~ U(0,1)
        if U <= f_objetivo(Y) / (c * g_Y):  # g(Y) necesario
            return Y
```

### Método Polar para Distribución Normal

Alternativa al Box-Muller que evita funciones trigonométricas:

```python
def normal_polar(self, mu: float = 0, sigma: float = 1) -> float:
    """Método polar (Marsaglia) para generar N(μ,σ)."""
    while True:
        U1 = 2 * self.gen.siguiente() - 1  # U(-1,1)
        U2 = 2 * self.gen.siguiente() - 1
        S = U1**2 + U2**2
        if 0 < S < 1:
            factor = math.sqrt(-2 * math.log(S) / S)
            Z = U1 * factor
            return mu + sigma * Z
```

---

## 3.6 Pruebas Estadísticas de Variables Aleatorias

### Prueba Chi-Cuadrada de Bondad de Ajuste

Compara la distribución empírica de los valores generados con la distribución teórica esperada, dividiendo el rango en $k$ intervalos:

```python
from scipy import stats
import numpy as np

def validar_variable(muestras: list, distribucion_teorica: str,
                      params: dict, alpha: float = 0.05) -> bool:
    """
    Valida que las muestras siguen la distribución teórica.
    distribucion_teorica: 'exponential', 'norm', 'uniform', etc.
    params: parámetros de la distribución (loc, scale, etc.)
    """
    estadistico, p_valor = stats.kstest(muestras, distribucion_teorica,
                                         args=list(params.values()))
    print(f"KS Test — Distribución: {distribucion_teorica}")
    print(f"Estadístico: {estadistico:.4f}, p-valor: {p_valor:.4f}")
    resultado = p_valor >= alpha
    print(f"Decisión: {'NO RECHAZAR H0' if resultado else 'RECHAZAR H0'}")
    return resultado

# Ejemplo: validar Exponencial con media=5
muestras_exp = [gen_var.exponencial(media=5) for _ in range(1000)]
validar_variable(muestras_exp, 'expon', {'loc': 0, 'scale': 5})
```

---

## Referencias

1. Law, A. M. (2015). *Simulation Modeling and Analysis* (5th ed.). McGraw-Hill. — Cap. 8
2. Banks, J. et al. (2014). *Discrete-Event System Simulation* (5th ed.). Pearson. — Cap. 8
3. Devroye, L. (1986). *Non-Uniform Random Variate Generation*. Springer-Verlag. http://luc.devroye.org/rnbookindex.html
4. SciPy Community. (2025). *scipy.stats — Statistical functions*. https://docs.scipy.org/doc/scipy/reference/stats.html
