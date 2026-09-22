# Actividad 1: Juegos de Pensamiento Lógico-Matemático

**Asignatura**: Fundamentos de Programación (AED-1285) | Unidad 1  
**Modalidad**: Equipo (3-5 personas) e individual  
**Duración total**: 2 sesiones de clase (2 horas) + 1 hora autónoma  
**Metodología**: Gamificación + Aula Invertida

---

## Objetivo

Desarrollar el pensamiento algorítmico y la capacidad de diseño lógico-matemático mediante juegos que simulan los principios fundamentales de la programación, antes de interactuar con una computadora.

---

## Preparación previa (tarea antes de la primera sesión — 30 min)

Revisar en Moodle:
- Video: "¿Qué es un algoritmo?" (8 min)
- Infografía: simbología del diagrama de flujo
- Lectura: ejemplos de algoritmos cotidianos (Cairo, Cap. 1 — resumen en Moodle)

Traer a clase: cuaderno, lápiz, regla, colores (opcionales).

---

## Juego 1 — Robot Humano (25 min)

**Concepto que desarrolla**: precisión, finitud y ausencia de ambigüedad en las instrucciones

**Material**: ninguno (solo espacio libre o un objeto en el salón como destino)

**Instrucciones**:

1. Un/a voluntario/a sale al frente: es el **robot** — solo puede ejecutar instrucciones exactas, literales.
2. El resto del equipo escribe en papel una secuencia de instrucciones para que el robot realice una tarea simple (tomar un libro del escritorio, abrir la puerta, llegar a la ventana).
3. El/la robot ejecuta **literalmente** cada instrucción. Si dice "ve hacia adelante", avanza sin detenerse. Si dice "toma el libro", lo intenta aunque esté fuera de alcance.
4. El grupo observa qué instrucciones son ambiguas, cuáles faltan y cuáles son innecesarias.

**Variante DUA (accesibilidad)**:
- Opción oral: el robot ejecuta instrucciones dictadas en voz alta
- Opción visual: el robot sigue una secuencia de tarjetas con dibujos de acciones
- Opción escrita: las instrucciones se escriben en el cuaderno y se intercambian entre equipos

**Preguntas de reflexión**:
- ¿Qué pasó cuando la instrucción era ambigua?
- ¿Cuántas instrucciones necesitaron? ¿Podrían reducirse?
- ¿Qué tiene en común esto con darle instrucciones a una computadora?

---

## Juego 2 — Reto del Laberinto (30 min)

**Concepto que desarrolla**: secuencialidad, condiciones de parada, estructuras de repetición

**Material**: hoja con laberinto en cuadrícula (el docente distribuye 3 laberintos de dificultad creciente)

**Instrucciones**:

1. Cada equipo recibe un laberinto en papel cuadriculado.
2. Deben escribir el **pseudocódigo** que le permitiría a un robot salir del laberinto desde la entrada hasta la salida, usando solo estas instrucciones válidas:
   - `Avanzar(n)` — avanzar n celdas en la dirección actual
   - `Girar_derecha` / `Girar_izquierda`
   - `Si hay_pared_adelante Entonces ... FinSi`
   - `Mientras no_llegué_a_salida Hacer ... FinMientras`
3. Un/a integrante traza el camino con lápiz siguiendo el pseudocódigo escrito por el equipo.
4. Si el robot "choca" con una pared, el equipo debe depurar su pseudocódigo.

**Niveles**:
- Nivel 1 (5×5 celdas): camino único, solo avances y giros
- Nivel 2 (8×8 celdas): con bifurcaciones, requiere condicionales
- Nivel 3 (10×10 celdas): laberinto complejo, requiere ciclo mientras

**Variante DUA**: en el nivel 1, el laberinto puede resolverse con instrucciones dibujadas (flechas) en lugar de pseudocódigo escrito.

**Reflexión**:
- ¿Qué instrucción resultó más difícil de escribir?
- ¿Usaron un ciclo? ¿Cuándo es conveniente usarlo en lugar de repetir la misma instrucción?

---

## Juego 3 — Veinte Preguntas Lógicas (20 min)

**Concepto que desarrolla**: árboles de decisión binaria → estructuras selectivas (`Si-Entonces-SiNo`)

**Material**: tarjetas con nombres de objetos/personas/lugares (o el docente piensa un concepto)

**Instrucciones**:

1. El/la docente (o un/a voluntario/a) piensa en un concepto del tema: algoritmo, variable, constante, diagrama de flujo, pseudocódigo, tipo de dato, etc.
2. El grupo hace preguntas de respuesta **solo Sí o No** para adivinar el concepto.
3. Cada pregunta representa un nodo de decisión en un árbol lógico.
4. Después de adivinar (o agotar 20 preguntas), el grupo dibuja el árbol de decisiones en el pizarrón.

**Conexión con programación**:
```
Si es_tangible Entonces
    Si tiene_pantalla Entonces
        // ¿computadora?
    SiNo
        // ¿cuaderno?
    FinSi
SiNo
    Si es_concepto_matemático Entonces
        // ¿variable?
    FinSi
FinSi
```

**Reflexión**:
- ¿El árbol de decisiones que construyeron es un algoritmo? ¿Por qué?
- ¿Qué propiedad de los algoritmos demuestra el juego de 20 preguntas?

---

## Juego 4 — Tarjetas de Flujo (30 min)

**Concepto que desarrolla**: simbología del DFD, estructura y ensamble de diagramas de flujo

**Material**: set de tarjetas de colores (preparar en casa o imprimir de Moodle):
- Tarjetas ovaladas amarillas: INICIO / FIN
- Tarjetas rectangulares azules: PROCESO
- Tarjetas de rombo verdes: DECISIÓN (Sí/No)
- Tarjetas de paralelogramo naranja: ENTRADA / SALIDA
- Flechas de papel

**Instrucciones**:

1. El docente describe un problema verbal: *"Ángel trabaja en un puesto de agua fresca en el tianguis. Quiere saber si le alcanza para cubrir los $200 de su puesto. Cobra $15 por vaso y lleva un registro de cuántos vendió."*
2. Cada equipo ensambla físicamente el diagrama de flujo sobre la mesa o en el pizarrón usando las tarjetas.
3. Un/a representante del equipo "ejecuta" el diagrama en voz alta para el grupo.
4. El grupo compara los diagramas y discute diferencias.

**Variante DUA**:
- Para estudiantes con dificultad visual: tarjetas con texto en fuente grande y símbolos táctiles en relieve (si disponible)
- Para trabajo individual: recortar y pegar en el cuaderno

**Reflexión**:
- ¿Dónde pusieron la condición? ¿Qué pasa en cada rama?
- ¿El diagrama podría ejecutarse en un orden diferente sin errores? ¿Por qué no?

---

## Juego 5 — Bingo de Conceptos (20 min)

**Concepto que desarrolla**: vocabulario de la Unidad 1 (repaso y consolidación)

**Material**: cartones de bingo con conceptos (el docente prepara 5 versiones diferentes):
- Cada cartón tiene 9 celdas (3×3) con términos como: algoritmo, variable, constante, tipo de dato, diagrama de flujo, pseudocódigo, entrada, proceso, salida, función, operador, identificador

**Instrucciones**:

1. El docente lee la **definición** (no el término):
   - *"Espacio en memoria cuyo valor puede cambiar durante la ejecución del programa"* → Variable
   - *"Conjunto finito y ordenado de instrucciones que resuelven un problema"* → Algoritmo
2. Quien escuche la definición y tenga el término en su cartón lo marca.
3. Gana quien complete una línea (horizontal, vertical o diagonal) primero.
4. El/la ganador/a debe explicar con sus propias palabras los 3 términos de la línea ganadora.

**Variante DUA**: 
- Modalidad oral: en lugar de leer, el docente describe con gestos o imágenes
- Modalidad táctil: fichas físicas en lugar de cartón impreso

---

## Juego 6 — Relevo de Algoritmos (20 min)

**Concepto que desarrolla**: diseño colaborativo, estructura secuencial y corrección de errores

**Material**: pizarrón o papel bond grande, marcadores

**Instrucciones**:

1. El docente plantea un problema: *"Rosalinda quiere calcular el promedio de calificaciones de sus 5 estudiantes de la telesecundaria de Atlapexco."*
2. El primer/a estudiante del equipo pasa al pizarrón y escribe **solo la primera instrucción** del pseudocódigo.
3. El segundo/a pasa y agrega **solo la siguiente instrucción lógica**.
4. Así sucesivamente hasta completar el algoritmo.
5. Si alguien escribe una instrucción incorrecta, el equipo contrario puede "desafiar" y proponer la corrección (gana un punto extra).

**Ejemplo de relevo esperado**:
```
// Turno 1: Algoritmo promedio_calificaciones
// Turno 2: Definir cal1, cal2, cal3, cal4, cal5, suma, promedio Como Real
// Turno 3: Leer cal1, cal2, cal3, cal4, cal5
// Turno 4: suma <- cal1 + cal2 + cal3 + cal4 + cal5
// Turno 5: promedio <- suma / 5
// Turno 6: Escribir "Promedio: ", promedio
// Turno 7: FinAlgoritmo
```

**Reflexión**:
- ¿En qué turno cometieron el primer error? ¿Por qué?
- ¿Qué fue lo más difícil de escribir en orden?

---

## Entregable de la Actividad 1

Después de los juegos, cada estudiante elabora de forma **individual** en su cuaderno:

1. **Glosario** de los 12 términos de la Unidad 1 con definición propia y un ejemplo del contexto de su comunidad o cotidiano (no copiar de la fuente, sino reformular con sus palabras)

2. **Tabla de tipos de datos**: completar la tabla del Apuntes-Diseño-Algoritmico.md con 2 ejemplos adicionales de su contexto para cada tipo

| Tipo | Definición breve | Ejemplo del tema | Mi ejemplo personal |
|------|-----------------|-----------------|---------------------|
| Entero | | 42 | |
| Real | | 3.14 | |
| Cadena | | "Hola" | |
| Lógico | | Verdadero | |

3. **Reflexión escrita** (5-8 oraciones): ¿Cuál de los juegos te pareció más útil para entender cómo piensa una computadora? ¿Por qué? ¿Qué conexión encontraste entre el juego y la programación?

---

## Criterios de Evaluación

Evaluado con **Lista de Cotejo A1** (ponderación: 20% de la Unidad 1).

| Criterio | Cumple | No cumple |
|---------|--------|-----------|
| El glosario contiene los 12 términos mínimos | | |
| Cada definición está expresada con palabras propias (no copiada literalmente) | | |
| Cada término tiene al menos un ejemplo propio del contexto | | |
| La tabla de tipos de datos está completa con ejemplos adicionales | | |
| La reflexión supera las 5 oraciones y conecta el juego con la programación | | |
