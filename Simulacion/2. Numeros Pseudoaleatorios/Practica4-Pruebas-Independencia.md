# Práctica 4: Pruebas Estadísticas de Independencia

**Asignatura**: Simulación (SCD-1022)  
**Unidad**: 2 — Números Pseudoaleatorios  
**Modalidad**: Individual o pareja  
**Duración estimada**: 3 horas de laboratorio + 2 horas autónomas  
**Entrega**: Código Python (.py) + Reporte PDF en Moodle  
**Prerrequisito**: Práctica 3 completada — se requiere el archivo `generador_config.json` con pruebas de uniformidad aprobadas

---

## Objetivo

Implementar y aplicar las pruebas estadísticas de **independencia** (prueba de corridas, prueba de póquer y prueba de series) al generador validado en la Práctica 3, y guardar la configuración final que pasó todas las pruebas.

---

## Instrucciones

### Parte 1 — Prueba de Corridas Arriba y Abajo

Una **corrida** es una secuencia máxima de números consecutivos que van solo en una dirección (todos subiendo o todos bajando). Si la secuencia es independiente, el número de corridas debe ser aproximadamente $(2n-1)/3$.

**Hipótesis:** $H_0$: la secuencia es aleatoria (corridas esperadas para datos independientes)

```python
import json
import numpy as np
from scipy import stats

def prueba_corridas(numeros: list, alpha: float = 0.05) -> bool:
    """
    Prueba de corridas arriba y abajo.
    Cuenta corridas: secuencias máximas de valores en la misma dirección.
    """
    n = len(numeros)
    # Señal de dirección: +1 si sube, -1 si baja
    direcciones = [1 if numeros[i] >= numeros[i-1] else -1
                   for i in range(1, n)]

    # Contar corridas (cambios de dirección + 1)
    num_corridas = 1
    for i in range(1, len(direcciones)):
        if direcciones[i] != direcciones[i-1]:
            num_corridas += 1

    # Media y varianza teóricas para n datos
    mu_R = (2 * n - 1) / 3
    sigma2_R = (16 * n - 29) / 90

    Z = (num_corridas - mu_R) / np.sqrt(sigma2_R)
    z_critico = stats.norm.ppf(1 - alpha / 2)
    p_valor = 2 * (1 - stats.norm.cdf(abs(Z)))

    print(f"\n{'='*55}")
    print(f"PRUEBA DE CORRIDAS (ARRIBA Y ABAJO)")
    print(f"{'='*55}")
    print(f"n = {n}")
    print(f"Número de corridas observadas: {num_corridas}")
    print(f"Número de corridas esperado:   {mu_R:.2f}")
    print(f"Desviación estándar:           {np.sqrt(sigma2_R):.4f}")
    print(f"Estadístico Z: {Z:.4f}")
    print(f"Z crítico (±{z_critico:.4f})")
    print(f"p-valor: {p_valor:.4f}")

    pasa = abs(Z) <= z_critico
    print(f"DECISIÓN: {'NO SE RECHAZA H0' if pasa else 'SE RECHAZA H0'}")
    return pasa
```

---

### Parte 2 — Prueba de Corridas Sobre y Bajo la Media

Convierte cada número en 1 (si $U_i \geq 0.5$) o 0 (si $U_i < 0.5$) y cuenta corridas en esta secuencia binaria:

```python
def prueba_corridas_media(numeros: list, alpha: float = 0.05) -> bool:
    """
    Prueba de corridas sobre y bajo la media (0.5).
    """
    n = len(numeros)
    # Convertir a secuencia binaria
    binaria = [1 if u >= 0.5 else 0 for u in numeros]

    n1 = sum(binaria)     # cantidad de 1s (sobre la media)
    n2 = n - n1           # cantidad de 0s (bajo la media)

    # Contar corridas
    corridas = 1
    for i in range(1, n):
        if binaria[i] != binaria[i-1]:
            corridas += 1

    # Media y varianza teóricas
    mu_R = (2 * n1 * n2) / n + 1
    sigma2_R = (2 * n1 * n2 * (2 * n1 * n2 - n)) / (n**2 * (n - 1))

    Z = (corridas - mu_R) / np.sqrt(sigma2_R)
    z_critico = stats.norm.ppf(1 - alpha / 2)
    p_valor = 2 * (1 - stats.norm.cdf(abs(Z)))

    print(f"\n{'='*55}")
    print(f"PRUEBA DE CORRIDAS SOBRE/BAJO LA MEDIA")
    print(f"{'='*55}")
    print(f"n1 (sobre media): {n1}, n2 (bajo media): {n2}")
    print(f"Corridas observadas: {corridas}")
    print(f"Corridas esperadas:  {mu_R:.2f}")
    print(f"Estadístico Z: {Z:.4f}, Z crítico (±{z_critico:.4f})")
    print(f"p-valor: {p_valor:.4f}")

    pasa = abs(Z) <= z_critico
    print(f"DECISIÓN: {'NO SE RECHAZA H0' if pasa else 'SE RECHAZA H0'}")
    return pasa
```

---

### Parte 3 — Prueba de Póquer

Agrupa los números en grupos de 5 y clasifica el patrón:

| Categoría | Descripción | Probabilidad teórica |
|-----------|-------------|---------------------|
| Todos diferentes | d d d d d | 0.3024 |
| Un par | a a b c d | 0.5040 |
| Dos pares | a a b b c | 0.1080 |
| Tercia | a a a b c | 0.0720 |
| Full house | a a a b b | 0.0090 |
| Póker (cuatro iguales) | a a a a b | 0.0045 |
| Quintilla | a a a a a | 0.0001 |

Para clasificar, multiplica cada $U_i$ por 10 (o el número de clases $d$) y toma la parte entera:

```python
def prueba_poker(numeros: list, d: int = 10, alpha: float = 0.05) -> bool:
    """
    Prueba de póquer para independencia.
    Agrupa en grupos de 5, clasifica el patrón y aplica chi-cuadrada.

    Parámetros:
        d: número de dígitos (clases). Para d=10, cada U_i se convierte
           en dígito 0-9 tomando la parte entera de 10*U_i
    """
    n = len(numeros)
    grupos = 5
    m = n // grupos  # número de grupos completos

    # Probabilidades teóricas para grupos de 5 con d clases
    # (solo categorías con frecuencias esperadas >= 5)
    probs = {
        'todos_diferentes': 1 - (1/d)**0 * (d-1)/d * (d-2)/d * (d-3)/d * (d-4)/d,
        # Se calculan según la fórmula combinatoria
    }
    # Para simplificar: usar categorías según número de valores únicos en el grupo
    categorias = {5: 0, 4: 0, 3: 0, 2: 0, 1: 0}
    # 5 únicos: todos diferentes
    # 4 únicos: un par
    # 3 únicos: dos pares o tercia
    # 2 únicos: full o póker
    # 1 único: quintilla

    for i in range(m):
        grupo = [int(numeros[i*5 + j] * d) for j in range(5)]
        num_unicos = len(set(grupo))
        categorias[num_unicos] += 1

    # Probabilidades teóricas para d=10, grupos de 5
    probs_teo = {
        5: 0.3024,   # todos diferentes
        4: 0.5040,   # un par
        3: 0.1080 + 0.0720,  # dos pares + tercia
        2: 0.0090 + 0.0045,  # full + póker
        1: 0.0001    # quintilla
    }

    print(f"\n{'='*55}")
    print(f"PRUEBA DE PÓQUER (d={d}, grupos de {grupos})")
    print(f"{'='*55}")
    print(f"m = {m} grupos\n")
    print(f"{'Categoría':20} {'Obs':>6} {'Esp':>8} {'(O-E)²/E':>10}")
    print("-" * 48)

    chi2_stat = 0
    for cat, obs in categorias.items():
        esp = m * probs_teo.get(cat, 0)
        if esp > 0:
            contrib = (obs - esp)**2 / esp
            chi2_stat += contrib
            etiqueta = {5:'Todos diff', 4:'Un par', 3:'2P/Tercia',
                        2:'Full/Póker', 1:'Quintilla'}[cat]
            print(f"{etiqueta:20} {obs:>6} {esp:>8.2f} {contrib:>10.4f}")

    gl = len(categorias) - 1
    valor_critico = stats.chi2.ppf(1 - alpha, df=gl)
    p_valor = 1 - stats.chi2.cdf(chi2_stat, df=gl)

    print(f"\nEstadístico χ²: {chi2_stat:.4f}")
    print(f"Valor crítico χ²({alpha},{gl}): {valor_critico:.4f}")
    print(f"p-valor: {p_valor:.4f}")

    pasa = chi2_stat <= valor_critico
    print(f"DECISIÓN: {'NO SE RECHAZA H0' if pasa else 'SE RECHAZA H0'}")
    return pasa
```

---

### Parte 4 — Programa Principal y Guardado

```python
if __name__ == "__main__":
    from practica2 import GeneradorLCG

    # Cargar configuración de P3
    with open("generador_config.json") as f:
        config = json.load(f)

    gen = GeneradorLCG(semilla=config["semilla_original"],
                       a=config["a"], c=config["c"], m=config["m"])
    numeros = gen.generar(4096)

    # Aplicar pruebas de independencia
    pasa_corridas     = prueba_corridas(numeros)
    pasa_corridas_med = prueba_corridas_media(numeros)
    pasa_poker        = prueba_poker(numeros)

    print(f"\n{'='*55}")
    print("RESUMEN — PRUEBAS DE INDEPENDENCIA")
    print(f"{'='*55}")
    print(f"Corridas arriba/abajo:  {'PASA' if pasa_corridas else 'FALLA'}")
    print(f"Corridas sobre/bajo med:{'PASA' if pasa_corridas_med else 'FALLA'}")
    print(f"Póquer:                 {'PASA' if pasa_poker else 'FALLA'}")

    todas_pasan = pasa_corridas and pasa_corridas_med and pasa_poker

    if todas_pasan:
        # Actualizar archivo para Práctica 5
        config["pruebas_independencia"] = {
            "corridas": pasa_corridas,
            "corridas_media": pasa_corridas_med,
            "poker": pasa_poker
        }
        with open("generador_config.json", 'w') as f:
            json.dump(config, f, indent=2)
        print("\nGenerador VALIDADO. Archivo listo para Práctica 5.")
    else:
        print("\nADVERTENCIA: El generador falla independencia. Revisar Práctica 2.")
```

---

## Contenido del Reporte

```
1. Portada
2. Objetivo
3. Fundamento teórico de cada prueba
4. Código completo comentado
5. Resultados de las 3 pruebas (tablas y decisiones)
6. Resumen combinado (uniformidad + independencia)
7. Archivo generador_config.json final
8. Conclusiones: ¿el generador es confiable para usar en simulación?
```

---

## Notas

- El archivo `generador_config.json` finalizado en esta práctica es la **entrada** de la Práctica 5 (Monte Carlo), la Práctica 6 (transformada inversa) y todas las prácticas de la Unidad 3.
- Si el generador falla alguna prueba de independencia, intentar con otra semilla antes de cambiar los parámetros $a$, $c$, $m$.

**Ponderación**: Esta práctica forma parte del 50% correspondiente a Prácticas 2, 3 y 4 en la Unidad 2.
