# Práctica 2: Generador de Números Pseudoaleatorios en Python

**Asignatura**: Simulación (SCD-1022)  
**Unidad**: 2 — Números Pseudoaleatorios  
**Modalidad**: Individual o pareja  
**Duración estimada**: 3 horas de laboratorio + 2 horas autónomas  
**Entrega**: Código Python (.py) + Reporte PDF en Moodle

---

## Objetivo

Implementar un generador de números pseudoaleatorios usando el **método congruencial lineal (LCG)** en Python, generar al menos 4096 números y guardar en un archivo la semilla, las constantes y el módulo utilizados, como insumo para las Prácticas 3 y 4.

## Competencias a Desarrollar

Desarrolla programas en Python para generar números pseudoaleatorios utilizando el método congruencial lineal y verifica visualmente su distribución mediante histogramas.

---

## Material y Equipo Necesario

### Software
- Python 3.x
- Bibliotecas: `numpy`, `matplotlib`, `json`
- Editor: VS Code, PyCharm o Jupyter Notebook

---

## Instrucciones

### Parte 1 — Investigación previa (fuera del laboratorio)

Antes de la sesión de laboratorio, responde en tu cuaderno:

1. ¿Cuál es la diferencia entre un número aleatorio y un número pseudoaleatorio?
2. ¿Qué significa el "periodo" de un generador pseudoaleatorio?
3. Enuncia el Teorema de Hull-Dobell para el LCG completo (c ≠ 0)
4. ¿Por qué se usa $m = 2^{31} - 1$ como módulo en el MINSTD?

---

### Parte 2 — Implementación del Generador LCG

Implementa la clase `GeneradorLCG` con los siguientes requerimientos:

```python
class GeneradorLCG:
    """
    Generador congruencial lineal.
    Fórmula: X_{n+1} = (a * X_n + c) mod m
             U_n = X_n / m
    """

    def __init__(self, semilla: int, a: int = 16807, c: int = 0,
                 m: int = 2**31 - 1):
        """
        Inicializa el generador.
        Parámetros predeterminados: MINSTD (Lewis et al., 1969)
        """
        # TODO: validar que semilla > 0 y que a, m son válidos
        pass

    def siguiente(self) -> float:
        """Genera el siguiente número U ~ U(0,1)."""
        # TODO: implementar la recurrencia X_{n+1} = (a*X + c) mod m
        pass

    def generar(self, n: int) -> list:
        """Genera una lista de n números pseudoaleatorios."""
        # TODO: usar list comprehension
        pass

    def guardar_estado(self, ruta_archivo: str) -> None:
        """
        Guarda en un archivo JSON la semilla original, constantes
        y el estado actual (X_n), para ser usado por prácticas posteriores.
        """
        import json
        estado = {
            "semilla_original": self._semilla_original,
            "X_actual": self.X,
            "a": self.a,
            "c": self.c,
            "m": self.m,
            "numeros_generados": self._contador
        }
        with open(ruta_archivo, 'w') as f:
            json.dump(estado, f, indent=2)
        print(f"Estado guardado en: {ruta_archivo}")
```

**Requerimientos de implementación:**
1. El constructor debe validar que `semilla > 0`, `a > 0` y `m > 0`
2. El método `guardar_estado()` debe generar un archivo `generador_config.json` con todos los parámetros
3. El atributo `_semilla_original` debe preservar la semilla original (el estado X cambia en cada llamada)
4. Agregar un contador `_contador` que registre cuántos números han sido generados

---

### Parte 3 — Generación y Visualización

```python
if __name__ == "__main__":
    # 1. Crear el generador con los parámetros MINSTD
    gen = GeneradorLCG(semilla=12345)

    # 2. Generar 4096 números pseudoaleatorios
    N = 4096
    numeros = gen.generar(N)

    # 3. Guardar configuración (insumo para Práctica 3)
    gen.guardar_estado("generador_config.json")

    # 4. Verificación visual: histograma
    import matplotlib.pyplot as plt
    import numpy as np

    fig, axes = plt.subplots(1, 2, figsize=(12, 4))

    # Histograma
    axes[0].hist(numeros, bins=20, edgecolor='black', density=True)
    axes[0].axhline(y=1.0, color='red', linestyle='--', label='Uniforme teórica')
    axes[0].set_title(f'Histograma de {N} números LCG')
    axes[0].set_xlabel('Valor')
    axes[0].set_ylabel('Densidad')
    axes[0].legend()

    # Gráfica de dispersión U_i vs U_{i+1} (prueba visual de correlación)
    axes[1].scatter(numeros[:-1], numeros[1:], alpha=0.1, s=1)
    axes[1].set_title('Diagrama U_i vs U_{i+1}')
    axes[1].set_xlabel('U_i')
    axes[1].set_ylabel('U_{i+1}')

    plt.tight_layout()
    plt.savefig('verificacion_visual_lcg.png', dpi=150)
    plt.show()

    # 5. Estadísticas básicas
    print(f"\n--- Estadísticas de los {N} números generados ---")
    print(f"Media:    {np.mean(numeros):.4f} (esperada: 0.5000)")
    print(f"Varianza: {np.var(numeros):.4f} (esperada: {1/12:.4f})")
    print(f"Mínimo:   {min(numeros):.4f}")
    print(f"Máximo:   {max(numeros):.4f}")
```

---

### Parte 4 — Experimentación con parámetros

Repetir la generación y visualización con los siguientes conjuntos de parámetros y reportar cuál produce la mejor apariencia de uniformidad:

| Experimento | a | c | m | Semilla |
|------------|---|---|---|---------|
| 1 (MINSTD) | 16807 | 0 | 2,147,483,647 | 12345 |
| 2 | 1664525 | 1013904223 | 2^32 | 12345 |
| 3 (malo) | 65539 | 0 | 2^31 | 12345 |
| 4 | Tu elección | Tu elección | Tu elección | 12345 |

Para el Experimento 3 (conocido como RANDU), identificar visualmente el problema con el diagrama U_i vs U_{i+1}.

---

## Contenido del Reporte

```
1. Portada
2. Objetivo
3. Investigación previa (respuestas Parte 1)
4. Descripción de la implementación (diagrama de clase)
5. Código completo comentado
6. Resultados de los 4 experimentos:
   - Histograma y diagrama de dispersión de cada uno
   - Tabla comparativa de medias y varianzas
7. Análisis: ¿por qué RANDU es un generador deficiente?
8. Archivo generador_config.json (incluir como apéndice)
9. Conclusiones
```

---

## Notas Importantes

- El archivo `generador_config.json` generado en esta práctica es la **entrada** de la Práctica 3. Conservarlo.
- La semilla predeterminada es 12345, pero documentar cualquier cambio en el reporte.
- No usar `random.random()` ni `numpy.random` como implementación principal. Se pueden usar para comparar visualmente.

## Criterios de Evaluación

Ver rúbrica: [A2-Rubrica-Programa-Generador.md](A2-Rubrica-Programa-Generador.md)

**Ponderación**: Esta práctica forma parte del 50% correspondiente a Prácticas 2, 3 y 4 en la Unidad 2.
