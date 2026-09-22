# Práctica 5: Método de Monte Carlo

**Asignatura**: Simulación (SCD-1022)  
**Unidad**: 2 — Números Pseudoaleatorios  
**Modalidad**: Individual o pareja  
**Duración estimada**: 3 horas de laboratorio + 2 horas autónomas  
**Entrega**: Código Python (.py) + Reporte PDF en Moodle  
**Prerrequisito**: Práctica 4 completada — se requiere `generador_config.json` con todas las pruebas aprobadas

---

## Objetivo

Aplicar el método de Monte Carlo a un problema matemático real usando el generador pseudoaleatorio validado en las Prácticas 2-4, y analizar la convergencia del estimador con respecto al tamaño de muestra.

---

## Introducción

Monte Carlo usa muestreo aleatorio repetido para estimar cantidades que serían difíciles de calcular analíticamente. Para una integral $I = \int_a^b f(x)dx$, la estimación de Monte Carlo es:

$$\hat{I} = (b - a) \cdot \frac{1}{n} \sum_{i=1}^{n} f(U_i), \quad U_i \sim U(a, b)$$

El **error estándar** de la estimación es:

$$\text{SE} = \frac{(b-a) \cdot \hat{\sigma}}{\sqrt{n}}$$

donde $\hat{\sigma}$ es la desviación estándar muestral de $f(U_i)$.

**Consultar el archivo [../../Ejercicios.md](../../Ejercicios.md)** para ver un ejemplo de aplicación de Monte Carlo en un sistema de diálisis (simulación de tiempos de servicio), que ilustra cómo los conceptos de esta práctica se aplican a sistemas reales.

---

## Material y Equipo Necesario

- Python 3.x con: `numpy`, `scipy`, `matplotlib`
- Archivo `generador_config.json` de la Práctica 4

---

## Instrucciones

### Problema 1: Estimación de π (obligatorio)

Usar el generador de Práctica 2 para estimar π:

```python
import json
import numpy as np
import matplotlib.pyplot as plt
from practica2 import GeneradorLCG

def estimar_pi_con_generador_propio(n: int, config: dict) -> float:
    """
    Estima π usando Monte Carlo con el generador LCG propio.
    Genera n pares de puntos (x, y) en [-1, 1]×[-1, 1]
    y cuenta cuántos caen dentro del círculo unitario.
    """
    gen = GeneradorLCG(semilla=config["semilla_original"],
                       a=config["a"], c=config["c"], m=config["m"])

    dentro = 0
    for _ in range(n):
        x = 2 * gen.siguiente() - 1  # transforma U(0,1) → U(-1,1)
        y = 2 * gen.siguiente() - 1
        if x**2 + y**2 <= 1:
            dentro += 1

    return 4 * dentro / n


# Análisis de convergencia
with open("generador_config.json") as f:
    config = json.load(f)

tamanos = [100, 500, 1000, 5000, 10000, 50000, 100000]
estimaciones = []
errores = []

print(f"\n{'n':>10}  {'π estimado':>12}  {'Error abs':>10}  {'Error rel %':>11}")
print("-" * 50)
for n in tamanos:
    pi_est = estimar_pi_con_generador_propio(n, config)
    error = abs(pi_est - np.pi)
    estimaciones.append(pi_est)
    errores.append(error)
    print(f"{n:>10}  {pi_est:>12.6f}  {error:>10.6f}  {100*error/np.pi:>10.4f}%")

# Gráfica de convergencia
fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(12, 4))

ax1.semilogx(tamanos, estimaciones, 'b-o', label='Estimación Monte Carlo')
ax1.axhline(y=np.pi, color='r', linestyle='--', label=f'π real = {np.pi:.6f}')
ax1.set_xlabel('Número de muestras (n)')
ax1.set_ylabel('Estimación de π')
ax1.set_title('Convergencia del estimador de π')
ax1.legend()
ax1.grid(True, alpha=0.3)

ax2.loglog(tamanos, errores, 'r-o', label='Error absoluto')
n_ref = np.array(tamanos, dtype=float)
ax2.loglog(tamanos, 1/np.sqrt(n_ref), 'g--', label='O(1/√n) teórico')
ax2.set_xlabel('Número de muestras (n)')
ax2.set_ylabel('Error absoluto |π_est - π|')
ax2.set_title('Tasa de convergencia (escala log-log)')
ax2.legend()
ax2.grid(True, alpha=0.3)

plt.tight_layout()
plt.savefig('convergencia_pi.png', dpi=150)
plt.show()
```

---

### Problema 2: Integración de Monte Carlo (elegir uno)

**Opción A** — Integral definida con solución analítica conocida:

$$I = \int_0^1 e^{-x^2} dx \approx 0.746824$$

```python
def integrar_mc(f, a, b, n, config):
    """Integración de Monte Carlo en [a, b]."""
    gen = GeneradorLCG(semilla=config["semilla_original"],
                       a=config["a"], c=config["c"], m=config["m"])
    # Transformar U(0,1) → U(a,b)
    valores = [(b - a) * gen.siguiente() + a for _ in range(n)]
    fx = [f(u) for u in valores]
    estimacion = (b - a) * sum(fx) / n
    error_est = (b - a) * np.std(fx, ddof=1) / np.sqrt(n)
    ic_95 = (estimacion - 1.96 * error_est, estimacion + 1.96 * error_est)
    return estimacion, error_est, ic_95

f = lambda x: np.exp(-x**2)
for n in [1000, 10000, 100000]:
    est, err, ic = integrar_mc(f, 0, 1, n, config)
    print(f"n={n}: I≈{est:.6f} ± {err:.6f}, IC95%: ({ic[0]:.6f}, {ic[1]:.6f})")
```

**Opción B** — Problema de inventario estocástico:

Una tienda vende entre 0 y 10 unidades por día (distribución Uniforme discreta). El costo de mantener inventario es $2/unidad/día y el costo de faltante es $5/unidad. Si el inventario inicial es 5 unidades, estimar el costo esperado en 30 días.

**Opción C** — Problema de confiabilidad de sistema:

Un sistema tiene 3 componentes en serie. Cada componente falla de forma independiente con probabilidad 0.1. Estimar la probabilidad de que el sistema falle en un período dado.

---

### Problema 3: Problema de elección propia

Diseñar y resolver un problema de Monte Carlo de un sistema diferente al de los anteriores. Justificar la elección y documentar el valor exacto de referencia (si existe) o comparar con literatura.

---

## Contenido del Reporte

```
1. Portada
2. Objetivo
3. Fundamento teórico del método de Monte Carlo
4. Problema 1 (π): código, gráficas de convergencia, tabla de resultados
5. Problema 2 (integral/inventario/confiabilidad): planteamiento, código, resultados
6. Problema 3 (propio): planteamiento, justificación, código, resultados
7. Análisis comparativo: ¿qué diferencias hay al usar el generador LCG propio
   vs. numpy.random? (ejecutar el mismo problema con ambos y comparar)
8. Conclusiones sobre el Método de Monte Carlo y su relación con la simulación
```

---

## Notas

- Esta práctica es la culminación de la Unidad 2. El generador LCG desarrollado en P2 y validado en P3-P4 debe usarse como fuente principal de aleatoriedad.
- La comparación con `numpy.random` (Mersenne Twister) debe mostrar resultados muy similares para $n$ grande, confirmando que el LCG implementado es estadísticamente adecuado.

**Ponderación en la Unidad 2**: 30% (evaluado con Rúbrica A2)
