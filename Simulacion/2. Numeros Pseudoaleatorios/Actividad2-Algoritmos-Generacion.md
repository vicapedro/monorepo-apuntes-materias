# Actividad 2: Investigación y Algoritmos de Generación de Números Pseudoaleatorios

**Asignatura**: Simulación (SCD-1022)  
**Unidad**: 2 — Números Pseudoaleatorios  
**Modalidad**: Equipo (3-4 integrantes)  
**Duración estimada**: 1 sesión de 1 hora + 2 horas autónomas  
**Entrega**: Presentación (PDF/Slides) + cuadro comparativo en Moodle

---

## Objetivo

Investigar las características de los principales métodos de generación de números pseudoaleatorios, elaborar un cuadro comparativo y seleccionar el método que se implementará en las Prácticas 2-5, justificando la elección.

---

## Competencia a Desarrollar

Desarrolla programas en Python para generar números pseudoaleatorios utilizando diferentes métodos, y aplica pruebas estadísticas para garantizar que sean uniformemente distribuidos e independientes.

---

## Instrucciones

### Parte A — Investigación de Métodos (fuera del aula)

Cada integrante del equipo investiga un método diferente:

| Integrante | Método asignado |
|-----------|----------------|
| 1 | Método de cuadrados medios (Von Neumann, 1946) |
| 2 | Método congruencial lineal — LCG (Lehmer, 1951) |
| 3 | Mersenne Twister MT19937 (Matsumoto & Nishimura, 1998) |
| 4 (si aplica) | Xorshift / PCG (métodos modernos post-2014) |

Para cada método, investigar:
1. Autor(es) y año de desarrollo
2. Fórmula o algoritmo central
3. Longitud del periodo
4. Parámetros clave y cómo afectan la calidad
5. Ventajas y desventajas
6. ¿Se usa en producción actualmente? ¿En qué contextos?

---

### Parte B — Cuadro Comparativo (en clase)

Reunir la investigación individual y construir el siguiente cuadro:

| Característica | Cuadrados Medios | LCG | Mersenne Twister | Método moderno |
|----------------|-----------------|-----|-----------------|----------------|
| Año | | | | |
| Fórmula central | | | | |
| Periodo | | | | |
| Pasa pruebas estadísticas | | | | |
| Velocidad (relativa) | | | | |
| Complejidad de implementación | | | | |
| Uso en Python estándar | | | | |
| Recomendado para simulación | | | | |
| ¿Por qué sí / no? | | | | |

---

### Parte C — Selección y Justificación

Con base en el cuadro comparativo, el equipo debe seleccionar el método que implementará en las Prácticas 2-5 y justificar la elección en 1 párrafo. Considerar:

- Facilidad de implementación (curso de Simulación, no de Criptografía)
- Calidad estadística comprobada
- Disponibilidad de parámetros documentados (no reinventar)
- Que se pueda "ver" el algoritmo funcionando (transparencia didáctica)

**Decisión recomendada por el programa**: LCG con parámetros MINSTD ($a=16807$, $c=0$, $m=2^{31}-1$), por su simplicidad de implementación, periodo aceptable ($m-1 \approx 2 \times 10^9$) y parámetros bien documentados en literatura.

---

### Parte D — Ejercicio Manual (en clase)

Aplicar manualmente el LCG con $a=5$, $c=3$, $m=16$, $X_0=7$ para generar 8 números:

| $n$ | $X_n$ | $U_n = X_n/m$ |
|----|--------|--------------|
| 0 | 7 | — |
| 1 | | |
| 2 | | |
| ... | | |

¿Cuándo se repite la secuencia? ¿Cuál es el periodo? ¿Cumplen los parámetros con el Teorema de Hull-Dobell?

---

## Entregables

| Entregable | Formato |
|-----------|---------|
| Cuadro comparativo | Tabla en PDF o Markdown |
| Justificación de la selección | Párrafo de 5-8 oraciones |
| Ejercicio manual del LCG | Tabla completa con análisis del periodo |

**Ponderación**: Esta actividad es formativa (no calificada de forma independiente). Su contenido es prerrequisito para las Prácticas 2-5.
