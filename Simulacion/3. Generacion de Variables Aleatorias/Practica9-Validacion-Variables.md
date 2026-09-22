# Práctica 9: Validación Estadística de Variables Aleatorias

**Asignatura**: Simulación (SCD-1022) | Unidad 3  
**Prerrequisito**: Práctica 8 completada — `variables_aleatorias.py` con todas las distribuciones

---

## Objetivo

Aplicar pruebas estadísticas formales (Kolmogorov-Smirnov y chi-cuadrada) para validar que cada variable aleatoria generada por la clase `GeneradorVariables` sigue su distribución teórica. Si alguna hipótesis es rechazada, diagnosticar y corregir el método correspondiente.

---

## Fundamento Teórico

### Prueba de Kolmogorov-Smirnov (KS) para variables continuas

Compara la FDA empírica $F_n(x)$ con la FDA teórica $F(x)$:

$$D_n = \sup_x |F_n(x) - F(x)|$$

Se rechaza $H_0$ si $D_n > D_{n,\alpha}$ (valor crítico tabulado o por scipy).

**Ventaja sobre chi-cuadrada**: no requiere agrupar datos en intervalos; usa todos los datos directamente.

### Prueba chi-cuadrada de bondad de ajuste para variables discretas

$$\chi^2 = \sum_{k} \frac{(O_k - E_k)^2}{E_k}$$

Donde $O_k$ = frecuencia observada del valor $k$, $E_k = n \cdot P(X=k)$ = frecuencia esperada.

---

## Instrucciones

### Parte 1 — Suite de validación automática

```python
from scipy import stats
import numpy as np
import json

gen = GeneradorVariables()

def validar_continua(nombre: str, muestras: list, dist_scipy,
                      params: tuple, alpha: float = 0.05) -> dict:
    """Ejecuta prueba KS para variable continua."""
    n = len(muestras)
    D, p_valor = stats.kstest(muestras, dist_scipy.name, args=params)
    pasa = p_valor >= alpha
    resultado = {
        "nombre": nombre,
        "n": n,
        "media_obs": np.mean(muestras),
        "std_obs": np.std(muestras),
        "KS_D": D,
        "p_valor": p_valor,
        "pasa": pasa
    }
    estado = "PASA" if pasa else "RECHAZA H0"
    print(f"{nombre:30} n={n:5}  D={D:.4f}  p={p_valor:.4f}  {estado}")
    return resultado

def validar_discreta(nombre: str, muestras: list, dist_scipy,
                      params: tuple, k_max: int, alpha: float = 0.05) -> dict:
    """Ejecuta prueba chi-cuadrada para variable discreta."""
    n = len(muestras)
    obs = [muestras.count(k) for k in range(k_max + 1)]
    esp = [n * dist_scipy.pmf(k, *params) for k in range(k_max + 1)]

    # Agrupar celdas con esperados < 5
    obs_agrup, esp_agrup = [], []
    acum_o, acum_e = 0, 0
    for o, e in zip(obs, esp):
        acum_o += o; acum_e += e
        if acum_e >= 5:
            obs_agrup.append(acum_o)
            esp_agrup.append(acum_e)
            acum_o, acum_e = 0, 0
    if acum_e > 0:
        obs_agrup[-1] += acum_o
        esp_agrup[-1] += acum_e

    chi2, p_valor = stats.chisquare(f_obs=obs_agrup, f_exp=esp_agrup)
    pasa = p_valor >= alpha
    estado = "PASA" if pasa else "RECHAZA H0"
    print(f"{nombre:30} n={n:5}  χ²={chi2:.4f}  p={p_valor:.4f}  {estado}")
    return {"nombre": nombre, "chi2": chi2, "p_valor": p_valor, "pasa": pasa}

# Ejecutar validación completa
N = 5000
print(f"\n{'='*65}")
print("VALIDACIÓN ESTADÍSTICA — CLASE GeneradorVariables")
print(f"{'='*65}\n")
print("VARIABLES CONTINUAS (Prueba KS):")
print("-" * 65)

resultados = {}
resultados['uniforme'] = validar_continua(
    "Uniforme(2, 8)", [gen.uniforme(2, 8) for _ in range(N)],
    stats.uniform, (2, 6))  # loc=2, scale=b-a=6

resultados['exponencial'] = validar_continua(
    "Exponencial(media=5)", [gen.exponencial(5) for _ in range(N)],
    stats.expon, (0, 5))

resultados['normal'] = validar_continua(
    "Normal(10, 3)", [gen.normal_polar(10, 3) for _ in range(N)],
    stats.norm, (10, 3))

resultados['erlang'] = validar_continua(
    "Erlang(3, lam=0.5)", [gen.erlang(3, 0.5) for _ in range(N)],
    stats.erlang, (3, 0, 2.0))  # k=3, loc=0, scale=1/λ=2

resultados['triangular'] = validar_continua(
    "Triangular(1, 5, 3)", [gen.triangular(1, 5, 3) for _ in range(N)],
    stats.triang, (0.5, 1, 4))  # c=(moda-a)/(b-a), loc=a, scale=b-a

print("\nVARIABLES DISCRETAS (Prueba Chi-cuadrada):")
print("-" * 65)
resultados['poisson'] = validar_discreta(
    "Poisson(lambda=4)", [gen.poisson(4) for _ in range(N)],
    stats.poisson, (4,), k_max=15)

resultados['geometrica'] = validar_discreta(
    "Geométrica(p=0.3)", [gen.geometrica(0.3) for _ in range(N)],
    stats.geom, (0.3,), k_max=20)

# Guardar resultados
all_pass = all(r['pasa'] for r in resultados.values())
print(f"\n{'='*65}")
print(f"RESULTADO GLOBAL: {'TODAS LAS DISTRIBUCIONES PASAN' if all_pass else 'HAY DISTRIBUCIONES CON PROBLEMAS'}")
with open("validacion_variables.json", 'w') as f:
    json.dump(resultados, f, indent=2)
print(f"Resultados guardados en: validacion_variables.json")
```

### Parte 2 — Diagnóstico y corrección

Si alguna distribución rechaza $H_0$:

1. Identificar el método con problema en `variables_aleatorias.py`
2. Revisar la derivación matemática de la transformada inversa
3. Corregir y regenerar hasta pasar la prueba
4. Documentar la corrección en el reporte

### Parte 3 — Análisis de sensibilidad de parámetros

Para la distribución Exponencial, generar muestras con diferentes medias (1, 5, 10, 50) y verificar que la media muestral converge a la media teórica. Graficar el error relativo vs. n.

---

## Entregables

- `validacion_variables.json` con los resultados de todas las pruebas
- Gráficas de validación (histogramas + Q-Q plots)
- Reporte PDF con diagnóstico de cualquier distribución que haya fallado y la corrección aplicada

**Ponderación**: 30% de la Unidad 3 (evaluado con Lista de Cotejo A3)
