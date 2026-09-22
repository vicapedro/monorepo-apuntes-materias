# Unidad 2: Números Pseudoaleatorios

**Asignatura**: Simulación (SCD-1022) — Ingeniería en Sistemas Computacionales — TecNM  
**Prerrequisito**: Unidad 1 completada; Python 3.x instalado con `numpy`, `scipy`, `matplotlib`

---

## 2.1 Métodos de Generación de Números Pseudoaleatorios

### ¿Por qué "pseudoaleatorios"?

Un computador es una máquina determinista: dado el mismo estado inicial (semilla), produce exactamente la misma secuencia. Por eso se llaman **números pseudoaleatorios**: parecen aleatorios estadísticamente pero son perfectamente reproducibles. Esta reproducibilidad es, de hecho, una ventaja en simulación porque permite replicar experimentos.

Un **generador de números pseudoaleatorios (GNPA)** debe producir una secuencia que parezca una muestra independiente de la distribución Uniforme[0,1]. El entero $U_i \in [0,1]$ se usa como materia prima para generar variables con otras distribuciones.

### Propiedades deseables de un GNPA

- **Uniformidad**: los números deben distribuirse uniformemente en [0,1]
- **Independencia**: no debe haber correlación entre $U_i$ y $U_{i+k}$ para ningún $k$
- **Periodo largo**: la secuencia no debe repetirse rápidamente (periodo $\geq 2^{31}$ mínimo)
- **Reproducibilidad**: dada la misma semilla, produce la misma secuencia
- **Velocidad**: generación rápida (importante en simulaciones de grandes sistemas)

### Método Congruencial Lineal (LCG)

El método más estudiado históricamente. La recurrencia es:

$$X_{n+1} = (a \cdot X_n + c) \mod m$$
$$U_n = X_n / m$$

Donde:
- $X_0$ = semilla (valor inicial)
- $a$ = multiplicador
- $c$ = incremento (si $c = 0$: congruencial multiplicativo)
- $m$ = módulo (determina el periodo máximo)

**Teorema de Hull-Dobell**: el LCG tiene periodo máximo $m$ si y solo si:
1. $m$ y $c$ son coprimos (MCD$(m, c) = 1$)
2. $a - 1$ es divisible por todos los factores primos de $m$
3. Si $m$ es múltiplo de 4, entonces $a - 1$ también lo es

**Parámetros recomendados** (MINSTD, Lewis et al. 1969):

| Parámetro | Valor | Descripción |
|-----------|-------|-------------|
| $a$ | 16807 | Multiplicador |
| $c$ | 0 | Incremento (congruencial multiplicativo) |
| $m$ | $2^{31} - 1 = 2{,}147{,}483{,}647$ | Módulo (primo de Mersenne) |

Implementación Python:

```python
class GeneradorLCG:
    """Generador congruencial lineal (multiplicativo)."""

    def __init__(self, semilla: int, a: int = 16807, m: int = 2**31 - 1):
        self.X = semilla
        self.a = a
        self.m = m

    def siguiente(self) -> float:
        """Genera el siguiente número U ~ Uniforme(0,1)."""
        self.X = (self.a * self.X) % self.m
        return self.X / self.m

    def generar(self, n: int) -> list:
        """Genera una lista de n números pseudoaleatorios."""
        return [self.siguiente() for _ in range(n)]


# Ejemplo de uso
if __name__ == "__main__":
    gen = GeneradorLCG(semilla=12345)
    numeros = gen.generar(4096)
    print(f"Primeros 5 números: {numeros[:5]}")
    print(f"Media muestral: {sum(numeros)/len(numeros):.4f} (esperada: 0.5)")
```

### Método de Cuadrados Medios (Von Neumann)

El primer método propuesto (Von Neumann, 1946). Históricamente importante pero **no se recomienda en la práctica** por su periodo corto e impredecible:

$$X_{n+1} = \text{dígitos centrales de } X_n^2$$

```python
def cuadrados_medios(semilla: int, n: int, digitos: int = 4) -> list:
    """Generador de cuadrados medios. Solo para fines didácticos."""
    resultados = []
    x = semilla
    for _ in range(n):
        x2 = str(x ** 2).zfill(2 * digitos)
        inicio = len(x2) // 2 - digitos // 2
        x = int(x2[inicio:inicio + digitos])
        resultados.append(x / (10 ** digitos))
        if x == 0:
            print("ADVERTENCIA: ciclo degenerado a 0")
            break
    return resultados
```

### Mersenne Twister (MT19937)

El estándar de facto en la industria y en Python (`random.random()`). Desarrollado por Matsumoto y Nishimura (1998).

- Periodo: $2^{19937} - 1$ (astronomicamente grande)
- Dimensión de equidistribución: 623 dimensiones
- Pasa todas las pruebas estadísticas estándar
- Rápido: ~10 millones de números/segundo en hardware moderno

```python
import random

# Python usa Mersenne Twister internamente
random.seed(42)
numeros = [random.random() for _ in range(4096)]

# Con numpy (también MT19937)
import numpy as np
rng = np.random.default_rng(42)  # nuevo API recomendado
numeros_np = rng.random(4096)
```

**Desventaja**: su estado interno es de 624 enteros de 32 bits. Si un adversario observa suficientes salidas, puede predecir el estado completo. **No usar para criptografía**.

---

## 2.2 Pruebas Estadísticas

Antes de usar un GNPA en una simulación, se debe verificar estadísticamente que la secuencia generada cumple con las propiedades de uniformidad e independencia.

### 2.2.1 Pruebas de Uniformidad

**Hipótesis**: $H_0$: la secuencia sigue distribución Uniforme[0,1]

#### Prueba Chi-Cuadrada de Bondad de Ajuste

Divide [0,1] en $k$ intervalos iguales y compara frecuencias observadas vs. esperadas:

$$\chi^2 = \sum_{i=1}^{k} \frac{(O_i - E_i)^2}{E_i}$$

Donde $O_i$ = frecuencia observada en intervalo $i$, $E_i = n/k$ = frecuencia esperada.

Se rechaza $H_0$ si $\chi^2 > \chi^2_{\alpha, k-1}$.

```python
import numpy as np
from scipy import stats

def prueba_chi_cuadrada(numeros: list, k: int = 10, alpha: float = 0.05):
    """
    Prueba chi-cuadrada de uniformidad.
    H0: la secuencia sigue U(0,1)
    """
    n = len(numeros)
    # Contar frecuencias en k intervalos iguales
    frecuencias_obs, _ = np.histogram(numeros, bins=k, range=(0, 1))
    frecuencia_esp = n / k

    chi2_stat = np.sum((frecuencias_obs - frecuencia_esp)**2 / frecuencia_esp)
    valor_critico = stats.chi2.ppf(1 - alpha, df=k - 1)
    p_valor = 1 - stats.chi2.cdf(chi2_stat, df=k - 1)

    print(f"Chi² calculada: {chi2_stat:.4f}")
    print(f"Chi² crítica (α={alpha}, gl={k-1}): {valor_critico:.4f}")
    print(f"p-valor: {p_valor:.4f}")
    print(f"Resultado: {'RECHAZAR H0' if chi2_stat > valor_critico else 'NO RECHAZAR H0'}")

    return chi2_stat <= valor_critico
```

#### Prueba de Kolmogorov-Smirnov (KS)

Compara la FDA empírica con la FDA teórica Uniforme:

$$D = \max_{i} \left| F_n(X_{(i)}) - U(X_{(i)}) \right|$$

```python
def prueba_ks_uniformidad(numeros: list, alpha: float = 0.05):
    """Prueba KS de uniformidad."""
    estadistico, p_valor = stats.kstest(numeros, 'uniform')
    print(f"Estadístico KS: {estadistico:.4f}")
    print(f"p-valor: {p_valor:.4f}")
    print(f"Resultado: {'RECHAZAR H0' if p_valor < alpha else 'NO RECHAZAR H0'}")
    return p_valor >= alpha
```

#### Prueba de Medias

$$H_0: \mu = 0.5 \quad \text{vs} \quad H_1: \mu \neq 0.5$$

$$Z = \frac{\bar{X} - 0.5}{\sigma / \sqrt{n}} = \frac{\bar{X} - 0.5}{\sqrt{1/12} / \sqrt{n}}$$

Se rechaza $H_0$ si $|Z| > Z_{\alpha/2}$.

#### Prueba de Varianza

$$H_0: \sigma^2 = 1/12 \approx 0.0833$$

$$\chi^2 = \frac{(n-1) S^2}{\sigma_0^2}$$

### 2.2.2 Pruebas de Aleatoriedad (corridas)

**Prueba de corridas arriba y abajo**: cuenta el número de corridas (secuencias monótonas):

```python
def prueba_corridas(numeros: list, alpha: float = 0.05):
    """
    Prueba de corridas arriba y abajo.
    Una corrida es una secuencia máxima de valores consecutivos
    en la misma dirección (subiendo o bajando).
    """
    n = len(numeros)
    # Calcular número de corridas
    corridas = 1
    for i in range(1, n - 1):
        if (numeros[i] >= numeros[i-1]) != (numeros[i+1] >= numeros[i]):
            corridas += 1

    # Media y varianza esperadas
    mu = (2*n - 1) / 3
    sigma2 = (16*n - 29) / 90

    z = (corridas - mu) / (sigma2 ** 0.5)
    z_critico = stats.norm.ppf(1 - alpha/2)

    print(f"Número de corridas: {corridas}")
    print(f"Z calculado: {z:.4f}")
    print(f"Z crítico (±{z_critico:.4f})")
    print(f"Resultado: {'RECHAZAR H0' if abs(z) > z_critico else 'NO RECHAZAR H0'}")

    return abs(z) <= z_critico
```

### 2.2.3 Pruebas de Independencia

**Prueba de Poker**: clasifica grupos de 5 números consecutivos en patrones (todos diferentes, un par, dos pares, etc.) y compara con frecuencias esperadas mediante chi-cuadrada.

**Prueba de Series**: divide cada $U_i$ en $d$ clases y verifica que todos los pares $(U_i, U_{i+1})$ sean equiprobables.

**Prueba de Autocorrelación**: verifica que $U_i$ y $U_{i+k}$ no estén correlacionados para diferentes retardos $k$.

---

## 2.3 Método de Monte Carlo

### 2.3.1 Características

El método de Monte Carlo usa muestreo aleatorio repetido para estimar cantidades deterministas o resolver problemas que serían intratables analíticamente.

**Principio fundamental**: si $X$ es una variable aleatoria con distribución $f(x)$, entonces:

$$E[g(X)] = \int g(x) f(x) dx \approx \frac{1}{n} \sum_{i=1}^{n} g(X_i)$$

donde $X_1, X_2, \ldots, X_n$ son muestras aleatorias de $f(x)$.

**Error estándar de la estimación**: $\sigma_{\bar{g}} = \sigma_g / \sqrt{n}$

Para reducir el error a la mitad, se necesita **cuadruplicar** el número de muestras.

### 2.3.2 Aplicaciones

- **Integración numérica**: estimar $\int_a^b f(x) dx$ generando puntos aleatorios
- **Estimación de π**: relación área círculo / área cuadrado
- **Valoración de opciones financieras**: movimiento Browniano
- **Física de partículas**: transporte de neutrones
- **Simulación de riesgo**: análisis What-If en proyectos

### 2.3.3 Implementación: Estimación de π

```python
import numpy as np
import matplotlib.pyplot as plt

def estimar_pi(n: int, semilla: int = 42) -> float:
    """
    Estima π usando el método de Monte Carlo.
    Genera n puntos aleatorios en el cuadrado [-1,1]×[-1,1]
    y cuenta cuántos caen dentro del círculo unitario.
    π/4 ≈ (puntos dentro del círculo) / n
    """
    rng = np.random.default_rng(semilla)
    puntos = rng.uniform(-1, 1, size=(n, 2))
    dentro = np.sum(puntos[:, 0]**2 + puntos[:, 1]**2 <= 1)
    pi_estimado = 4 * dentro / n
    return pi_estimado

# Convergencia del estimador
tamanos = [100, 1000, 10000, 100000, 1000000]
for n in tamanos:
    pi_est = estimar_pi(n)
    error = abs(pi_est - np.pi)
    print(f"n={n:>8}: π ≈ {pi_est:.6f}  (error = {error:.6f})")
```

**Implementación: Integración de Monte Carlo**

$$\int_0^1 e^{-x^2} dx \approx \frac{1}{n} \sum_{i=1}^{n} e^{-U_i^2}, \quad U_i \sim U(0,1)$$

```python
def integrar_monte_carlo(f, a: float, b: float, n: int = 100000,
                          semilla: int = 42) -> tuple:
    """
    Estima ∫_a^b f(x)dx usando Monte Carlo.
    Retorna (estimación, error_estándar, intervalo_confianza_95%)
    """
    rng = np.random.default_rng(semilla)
    U = rng.uniform(a, b, n)
    valores = f(U)
    estimacion = (b - a) * np.mean(valores)
    error_std = (b - a) * np.std(valores) / np.sqrt(n)
    ic = (estimacion - 1.96 * error_std, estimacion + 1.96 * error_std)
    return estimacion, error_std, ic

# Ejemplo
f = lambda x: np.exp(-x**2)
est, err, ic = integrar_monte_carlo(f, 0, 1)
print(f"Estimación: {est:.6f}")
print(f"Error estándar: {err:.6f}")
print(f"IC 95%: ({ic[0]:.6f}, {ic[1]:.6f})")
# Valor exacto: 0.746824
```

---

## Referencias

### Bibliografía Principal
1. Law, A. M. (2015). *Simulation Modeling and Analysis* (5th ed.). McGraw-Hill. — Cap. 7 (Random-Number Generators)
2. Banks, J. et al. (2014). *Discrete-Event System Simulation* (5th ed.). Pearson. — Cap. 7 (Random-Number Generation) y Cap. 8 (Random-Variate Generation)
3. Coss Bu, R. (1992). *Simulación: un enfoque práctico*. LIMUSA. — Cap. 2-3

### Documentación Python
4. Python Software Foundation. (2025). *random — Generate pseudo-random numbers*. https://docs.python.org/3/library/random.html
5. NumPy Community. (2025). *Random sampling (numpy.random)*. https://numpy.org/doc/stable/reference/random/
6. SciPy Community. (2025). *scipy.stats.kstest*. https://docs.scipy.org/doc/scipy/reference/generated/scipy.stats.kstest.html

### Artículo fundacional
7. Matsumoto, M., & Nishimura, T. (1998). Mersenne twister: a 623-dimensionally equidistributed uniform pseudo-random number generator. *ACM Transactions on Modeling and Computer Simulation*, 8(1), 3-30.
