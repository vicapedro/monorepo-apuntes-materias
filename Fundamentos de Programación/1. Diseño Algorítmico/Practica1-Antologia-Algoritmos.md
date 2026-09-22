# Práctica 1: Antología de Algoritmos con DFD y Pseudocódigo

## Objetivo

Elaborar una antología personal con los diagramas de flujo (DFD) y pseudocódigos de 10 problemas de creciente complejidad, aplicando la metodología EPP (Entrada-Proceso-Salida) y contextos socioculturales diversos.

**Duración estimada**: 4 horas (2 en clase + 2 autónomas)

---

## Competencias a desarrollar

- Diseña algoritmos mediante pseudocódigo y diagramas de flujo para resolver problemas secuenciales, selectivos y repetitivos del entorno
- Aplica la metodología EPP para identificar datos de entrada, proceso y salida antes de diseñar un algoritmo
- Usa la simbología ISO 5807 para la representación gráfica de algoritmos

---

## Introducción

Antes de escribir código en una computadora, los programadores diseñan la solución en papel usando pseudocódigo o diagramas de flujo. Esta práctica simula ese proceso professional: analizarás problemas reales de comunidades mexicanas diversas y diseñarás los algoritmos que los resuelvan, sin usar una computadora.

Los problemas están organizados en tres niveles de dificultad:

- **Nivel 1 (Básico)**: Secuencias lineales, sin decisiones ni ciclos
- **Nivel 2 (Intermedio)**: Con estructuras de decisión (Si-Entonces-SiNo)
- **Nivel 3 (Avanzado)**: Con decisiones y ciclos, o con funciones

---

## Equipo de protección e higiene

No aplica (práctica en papel y lápiz). Se recomienda espacio de trabajo limpio y ordenado.

---

## Material y equipo necesario

### Materiales e insumos

- Cuaderno cuadriculado o papel cuadriculado (mínimo 20 hojas)
- Lápiz y borrador
- Regla para trazado de símbolos DFD
- Colores o marcadores (opcional, para diferenciar tipos de símbolos)
- Plantillas de símbolos DFD (disponibles en Moodle para imprimir)

### Herramientas

- PSeInt (opcional, para verificar lógica del pseudocódigo antes de dibujarlo a mano)
- Moodle: acceso para descargar plantillas y subir el trabajo

---

## Instrucciones generales

Para **cada uno de los 10 problemas**, desarrollar en el cuaderno o las hojas entregables:

1. **Encabezado del problema**: número, título y contexto
2. **Análisis EPP**: tabla de 3 columnas (Entrada | Proceso | Salida)
3. **Pseudocódigo**: usando las convenciones del curso (ver Apuntes)
4. **Diagrama de flujo**: dibujado a mano usando regla y simbología ISO
5. **Prueba de escritorio**: tabla de seguimiento con al menos 2 valores de prueba

---

## Nivel 1 — Secuencias lineales (Problemas 1 al 3)

### Problema 1: Receta de atole de guayaba

**Contexto**: La abuela Dolores, de la comunidad de Xico, Veracruz, prepara atole de guayaba en su cocina. La receta base es: 2 guayabas y 200 mL de agua por persona.

**Tarea**: Diseña un algoritmo que, dado el número de personas que asistirán a la reunión comunitaria, calcule cuántas guayabas y cuántos mililitros de agua se necesitan.

**Entradas**: número de personas  
**Salidas**: cantidad de guayabas, mililitros de agua  
**Restricción**: sin decisiones, sin ciclos

---

### Problema 2: Cambio de vuelto en el tianguis

**Contexto**: Citlali vende artesanías zapotecas en el mercado de Tlacolula, Oaxaca. Un cliente le paga con un billete y ella necesita calcular el cambio.

**Tarea**: Diseña un algoritmo que lea el precio del artículo y el monto del pago, y calcule el cambio a devolver.

**Entradas**: precio del artículo (pesos), monto pagado por el cliente (pesos)  
**Salidas**: cambio a devolver (pesos)  
**Restricción**: asumir que el pago siempre es suficiente; sin decisiones en este nivel

---

### Problema 3: Ingreso bruto de la cooperativa pesquera

**Contexto**: La cooperativa "Mar Oaxaqueño" de Puerto Ángel vende su pesca al día. Para calcular el ingreso del día, multiplica los kilogramos capturados por el precio actual del kilo de mojarra.

**Tarea**: Diseña un algoritmo que calcule el ingreso bruto del día.

**Entradas**: kilogramos capturados, precio por kilo (pesos)  
**Salidas**: ingreso total del día (pesos)  
**Restricción**: sin decisiones ni ciclos

---

## Nivel 2 — Estructuras de decisión (Problemas 4 al 7)

### Problema 4: Distribución de cosecha de maíz

**Contexto**: Una familia de San Andrés Cholula, Puebla, cosechó una cantidad de kilogramos de maíz y quiere repartirlos en partes iguales entre las familias de la comunidad.

**Tarea**: Diseña un algoritmo que lea los kilogramos cosechados y el número de familias, valide que el número de familias sea mayor que cero, y calcule la porción por familia. Si el número de familias es cero o negativo, muestra un mensaje de error.

**Entradas**: kilogramos de maíz cosechado, número de familias  
**Salidas**: kilogramos por familia o mensaje de error  
**Restricción**: usar estructura Si-Entonces-SiNo para validar

---

### Problema 5: Clasificación de calificaciones en telesecundaria

**Contexto**: La maestra Rosalinda de la telesecundaria de Atlapexco, Hidalgo, quiere un algoritmo que clasifique la calificación de un estudiante.

**Escala**: 9-10 = Excelente; 7-8 = Bien; 6 = Suficiente; menor a 6 = Reprobado

**Tarea**: Diseña el algoritmo que lea la calificación y muestre la categoría correspondiente.

**Entradas**: calificación numérica (0 a 10)  
**Salidas**: categoría de desempeño  
**Restricción**: usar Si anidado o Si-SiNo encadenado

---

### Problema 6: Costo de medicamento con descuento

**Contexto**: La clínica comunitaria de San Pablo Etla, Oaxaca, aplica un descuento del 15% en medicamentos herbolarios para personas mayores de 60 años y del 10% para estudiantes. Cualquier otra persona paga precio completo.

**Tarea**: Diseña un algoritmo que lea el precio del medicamento y el tipo de cliente (mayor/estudiante/general) y calcule el costo final.

**Entradas**: precio del medicamento (pesos), tipo de cliente (cadena)  
**Salidas**: precio con descuento aplicado  
**Restricción**: al menos dos condiciones con Si-Entonces-SiNo

---

### Problema 7: Turno de pago en la cooperativa cafetalera

**Contexto**: En una cooperativa cafetalera de Tapachula, Chiapas, los jornaleros cobran según el número de kilos de café que cortaron. Si cortaron 50 kg o más, cobran $180 por kg; si cortaron menos, cobran $150 por kg.

**Tarea**: Diseña un algoritmo que calcule el pago de un jornalero según los kilos cortados.

**Entradas**: kilogramos de café cortados por el jornalero  
**Salidas**: pago total (pesos)  
**Restricción**: usar estructura Si-Entonces-SiNo con condición de umbral

---

## Nivel 3 — Ciclos y funciones (Problemas 8 al 10)

### Problema 8: Inventario de medicamentos herbolarios

**Contexto**: La herbolaria de doña Esperanza en Pátzcuaro, Michoacán, lleva un inventario de sus plantas medicinales. Quiere saber cuántos tipos de planta tiene en total y cuál es el valor total de su inventario (nombre, cantidad y precio por gramo de cada una).

**Tarea**: Diseña un algoritmo que permita ingresar datos de `n` tipos de plantas (el número lo decide la usuaria al inicio) y calcule el total de tipos de planta y el valor total del inventario.

**Entradas**: número de tipos de planta, y para cada una: nombre, cantidad (gramos), precio por gramo  
**Salidas**: total de tipos de planta, valor total del inventario  
**Restricción**: usar ciclo Para o Mientras para leer los n registros

---

### Problema 9: Promedio de calificaciones de un grupo

**Contexto**: La maestra Tláloc Hernández, docente de una escuela primaria comunitaria en Cuetzalán del Progreso, Puebla, quiere calcular el promedio de calificaciones de su grupo de `n` estudiantes.

**Tarea**: Diseña un algoritmo que lea las calificaciones de los estudiantes una por una (hasta que el usuario indique que terminó o ingrese `n` calificaciones) y calcule el promedio del grupo.

**Entradas**: número de estudiantes, calificación de cada uno  
**Salidas**: promedio del grupo  
**Restricción**: usar ciclo Para para recorrer las calificaciones; calcular el promedio como función separada

---

### Problema 10: Registro de ventas del día en el tianguis purépecha

**Contexto**: Don Francisco vende artesanías de madera en el tianguis de Uruapan, Michoacán. Al finalizar el día, quiere conocer: el total recaudado, el número de ventas realizadas, y cuántas ventas superaron los $500.

**Tarea**: Diseña un algoritmo que permita registrar ventas hasta que el usuario indique "terminar" (ingresando 0 como monto), y al final muestre los tres datos solicitados.

**Entradas**: montos de venta (hasta que se ingrese 0)  
**Salidas**: total recaudado, número de ventas, ventas mayores a $500  
**Restricción**: usar ciclo Mientras con condición de salida; usar al menos una función para calcular el total

---

## Notas

**Variantes DUA para estudiantes con necesidades específicas**:
- Si la escritura a mano es una barrera, es aceptable diseñar el pseudocódigo en PSeInt y exportarlo a texto para incluir en el trabajo.
- Si el dibujo del DFD a mano dificulta la entrega, se puede usar la función "Diagrama" de PSeInt y adjuntar la captura de pantalla.
- Para la prueba de escritorio, se puede hacer una grabación de voz describiendo la traza del algoritmo en lugar de la tabla escrita (coordinar con el/la docente).

**Para verificar tu pseudocódigo antes de entregarlo**:
1. Abre PSeInt
2. Escribe tu pseudocódigo en la ventana principal
3. Presiona F9 para ejecutar con los valores de tu prueba de escritorio
4. Si hay errores, PSeInt los señalará con rojo
5. Corrige y repite hasta que ejecute sin errores

**Entrega**: La antología completa (portada + índice + 10 problemas) se sube en PDF a la tarea correspondiente en Moodle antes de la fecha indicada.
