# Práctica 3: Pruebas Estadísticas de Uniformidad

**Asignatura**: Simulación (SCD-1022)  
**Unidad**: 2 — Números Pseudoaleatorios  
**Modalidad**: Individual o pareja  
**Duración estimada**: 3 horas de laboratorio + 2 horas autónomas  
**Entrega**: Código Python (.py) + Reporte PDF en Moodle  
**Prerrequisito**: Práctica 2 completada — se requiere el archivo `generador_config.json`

---

## Objetivo

Implementar y aplicar las pruebas estadísticas de **uniformidad** (chi-cuadrada de bondad de ajuste, prueba de medias y prueba de varianza) al generador de números pseudoaleatorios desarrollado en la Práctica 2, y guardar el archivo con la configuración validada.

---

## Material y Equipo Necesario

### Software
- Python 3.x con: `numpy`, `scipy.stats`, `matplotlib`, `json`
- Archivo `generador_config.json` de la Práctica 2

---

## Instrucciones

### Parte 1 — Cargar el generador validado

```python
import json
import numpy as np
from scipy import stats
import matplotlib.pyplot as plt

def cargar_generador(ruta: str):
    """Carga la configuración del generador desde el archivo JSON."""
    with open(ruta) as f:
        config = json.load(f)
    return config

# Reconstruir el generador con la configuración de P2
# (Importar la clase GeneradorLCG desde practica2.py)
from practica2 import GeneradorLCG

config = cargar_generador("generador_config.json")
gen = GeneradorLCG(
    semilla=config["semilla_original"],
    a=config["a"],
    c=config["c"],
    m=config["m"]
)
numeros = gen.generar(4096)
```

---

### Parte 2 — Prueba Chi-Cuadrada de Bondad de Ajuste

**Hipótesis:**
- $H_0$: Los números siguen distribución Uniforme[0,1]
- $H_1$: Los números NO siguen distribución Uniforme[0,1]
- Nivel de significancia: $\alpha = 0.05$

```python
def prueba_chi_cuadrada_uniformidad(numeros: list, k: int = 10,
                                     alpha: float = 0.05) -> bool:
    """
    Prueba chi-cuadrada de bondad de ajuste para uniformidad.

    Parámetros:
        numeros: lista de números pseudoaleatorios en [0,1]
        k: número de intervalos (subintervalos de [0,1])
        alpha: nivel de significancia

    Retorna:
        True si NO se rechaza H0 (el generador pasa la prueba)
    """
    n = len(numeros)
    frecuencias_obs, bordes = np.histogram(numeros, bins=k, range=(0, 1))
    frecuencia_esp = n / k

    # Estadístico chi-cuadrada
    chi2_stat = np.sum((frecuencias_obs - frecuencia_esp)**2 / frecuencia_esp)

    # Valor crítico y p-valor
    gl = k - 1  # grados de libertad
    valor_critico = stats.chi2.ppf(1 - alpha, df=gl)
    p_valor = 1 - stats.chi2.cdf(chi2_stat, df=gl)

    # Mostrar tabla de frecuencias
    print(f"\n{'='*50}")
    print(f"PRUEBA CHI-CUADRADA DE UNIFORMIDAD")
    print(f"{'='*50}")
    print(f"n = {n}, k = {k}, α = {alpha}, gl = {gl}")
    print(f"\nIntervalo      O_i    E_i    (O-E)²/E")
    print("-" * 40)
    for i in range(k):
        oi = frecuencias_obs[i]
        ei = frecuencia_esp
        contrib = (oi - ei)**2 / ei
        print(f"[{bordes[i]:.1f}, {bordes[i+1]:.1f})  {oi:5}  {ei:5.1f}  {contrib:8.4f}")

    print(f"\nEstadístico χ²: {chi2_stat:.4f}")
    print(f"Valor crítico χ²({alpha},{gl}): {valor_critico:.4f}")
    print(f"p-valor: {p_valor:.4f}")

    if chi2_stat <= valor_critico:
        print(f"DECISIÓN: NO SE RECHAZA H0 (el generador pasa la prueba)")
        return True
    else:
        print(f"DECISIÓN: SE RECHAZA H0 (el generador FALLA la prueba)")
        return False
```

---

### Parte 3 — Prueba de Medias

**Hipótesis:** $H_0: \mu = 0.5$ vs $H_1: \mu \neq 0.5$

Para $U \sim \text{Uniforme}(0,1)$: $\mu = 0.5$, $\sigma^2 = 1/12$

$$Z = \frac{\bar{X} - 0.5}{\sqrt{1/12}/\sqrt{n}}$$

```python
def prueba_medias(numeros: list, alpha: float = 0.05) -> bool:
    """
    Prueba Z de medias para uniformidad.
    H0: μ = 0.5
    """
    n = len(numeros)
    media = np.mean(numeros)
    sigma = np.sqrt(1/12)  # desviación estándar teórica de U(0,1)

    Z = (media - 0.5) / (sigma / np.sqrt(n))
    z_critico = stats.norm.ppf(1 - alpha/2)
    p_valor = 2 * (1 - stats.norm.cdf(abs(Z)))

    print(f"\n{'='*50}")
    print(f"PRUEBA DE MEDIAS")
    print(f"{'='*50}")
    print(f"Media muestral: {media:.6f} (esperada: 0.5)")
    print(f"Estadístico Z: {Z:.4f}")
    print(f"Z crítico (±{z_critico:.4f})")
    print(f"p-valor: {p_valor:.4f}")

    pasa = abs(Z) <= z_critico
    print(f"DECISIÓN: {'NO SE RECHAZA H0' if pasa else 'SE RECHAZA H0'}")
    return pasa
```

---

### Parte 4 — Prueba de Varianza

**Hipótesis:** $H_0: \sigma^2 = 1/12$ vs $H_1: \sigma^2 \neq 1/12$

$$\chi^2 = \frac{(n-1)S^2}{\sigma_0^2}$$

```python
def prueba_varianza(numeros: list, alpha: float = 0.05) -> bool:
    """
    Prueba chi-cuadrada de varianza.
    H0: σ² = 1/12
    """
    n = len(numeros)
    varianza_muestral = np.var(numeros, ddof=1)
    sigma0_cuadrada = 1/12

    chi2_stat = (n - 1) * varianza_muestral / sigma0_cuadrada
    gl = n - 1
    chi2_lower = stats.chi2.ppf(alpha/2, df=gl)
    chi2_upper = stats.chi2.ppf(1 - alpha/2, df=gl)

    print(f"\n{'='*50}")
    print(f"PRUEBA DE VARIANZA")
    print(f"{'='*50}")
    print(f"Varianza muestral: {varianza_muestral:.6f} (esperada: {sigma0_cuadrada:.6f})")
    print(f"Estadístico χ²: {chi2_stat:.4f}")
    print(f"Región de no rechazo: [{chi2_lower:.4f}, {chi2_upper:.4f}]")

    pasa = chi2_lower <= chi2_stat <= chi2_upper
    print(f"DECISIÓN: {'NO SE RECHAZA H0' if pasa else 'SE RECHAZA H0'}")
    return pasa
```

---

### Parte 5 — Programa principal y guardado del archivo validado

```python
if __name__ == "__main__":
    # Cargar y regenerar números
    config = cargar_generador("generador_config.json")
    gen = GeneradorLCG(**{k: config[k] for k in ['semilla_original','a','c','m']},
                       semilla=config['semilla_original'])
    numeros = gen.generar(4096)

    # Aplicar las tres pruebas
    pasa_chi2 = prueba_chi_cuadrada_uniformidad(numeros, k=10)
    pasa_medias = prueba_medias(numeros)
    pasa_varianza = prueba_varianza(numeros)

    print(f"\n{'='*50}")
    print(f"RESUMEN DE PRUEBAS DE UNIFORMIDAD")
    print(f"{'='*50}")
    print(f"Chi-cuadrada:  {'PASA' if pasa_chi2 else 'FALLA'}")
    print(f"Medias:        {'PASA' if pasa_medias else 'FALLA'}")
    print(f"Varianza:      {'PASA' if pasa_varianza else 'FALLA'}")

    todas_pasan = pasa_chi2 and pasa_medias and pasa_varianza

    if todas_pasan:
        print("\nEl generador PASA todas las pruebas de uniformidad.")
        print("Guardando configuración validada...")
        # Guardar archivo para Práctica 4
        config_validada = config.copy()
        config_validada["pruebas_uniformidad"] = {
            "chi_cuadrada": pasa_chi2,
            "medias": pasa_medias,
            "varianza": pasa_varianza,
            "n_numeros_probados": 4096
        }
        with open("generador_config.json", 'w') as f:
            json.dump(config_validada, f, indent=2)
        print("Archivo generador_config.json actualizado.")
    else:
        print("\nADVERTENCIA: El generador falla al menos una prueba.")
        print("Revisar parámetros en la Práctica 2.")
```

---

## Contenido del Reporte

```
1. Portada
2. Objetivo
3. Fundamento teórico de cada prueba (fórmulas y decisión)
4. Código completo comentado
5. Resultados:
   - Tabla de frecuencias observadas vs. esperadas (chi-cuadrada)
   - Valores calculados, críticos y p-valores de las 3 pruebas
   - Decisión estadística con justificación
6. Experimento adicional: aplicar las mismas pruebas al generador RANDU
   (parámetros: a=65539, c=0, m=2^31, semilla=12345)
   ¿Falla alguna prueba? ¿Por qué?
7. Conclusiones
```

---

## Notas

- El archivo `generador_config.json` actualizado en esta práctica es la **entrada** de la Práctica 4.
- Si el generador falla alguna prueba, documentar el problema y proponer alternativa (cambiar semilla o parámetros) antes de continuar.
- Se recomienda probar con diferentes valores de $k$ (5, 10, 20 intervalos) y reportar la sensibilidad de la prueba chi-cuadrada.

**Ponderación**: Esta práctica forma parte del 50% correspondiente a Prácticas 2, 3 y 4 en la Unidad 2.
