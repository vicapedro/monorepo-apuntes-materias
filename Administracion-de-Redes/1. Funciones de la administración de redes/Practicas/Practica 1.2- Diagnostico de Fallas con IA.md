# Práctica 2: Diagnóstico de Fallas de Red con Asistencia de IA (Simulador NOC)

## Objetivo
Aplicar una metodología de análisis de causa raíz (Árbol de Fallas/Decisión, Ishikawa, 5 Porqués, Análisis de Cambios, Follow the Path o Divide y Vencerás) para diagnosticar una falla de red simulada mediante interacción con una IA generativa, documentando el proceso completo de preguntas y respuestas como evidencia, y registrando el tiempo total de reparación (MTTR simulado) que arroje el ejercicio.

**Duración estimada:** 1 hora (trabajo individual, en laboratorio o de forma autónoma)

## Competencias a desarrollar
- Aplica una metodología de análisis de causa raíz para diagnosticar una falla de red.
- Selecciona y ajusta su estrategia de diagnóstico según la evidencia obtenida, pudiendo cambiar de metodología de forma justificada.
- Interpreta evidencia técnica simulada (alertas, logs, salidas de comandos) para llegar a una conclusión fundamentada.
- Documenta de forma clara y trazable un proceso completo de diagnóstico.
- Relaciona el proceso de diagnóstico con la métrica de **MTTR** (Mean Time To Repair).

## Introducción
En la actividad [A1.1-D Diagnostico RCA en Redes.md](../A1.1-D%20Diagnostico%20RCA%20en%20Redes.md) se practicaron seis metodologías de análisis de causa raíz sobre casos ya resueltos. Esta práctica lleva ese conocimiento a un escenario abierto: usando un prompt especializado, una IA conversacional actuará como el Sistema de Gestión de Red (NMS) de una empresa, generando una alerta de falla con una causa raíz oculta. El estudiante deberá elegir una metodología de diagnóstico (ver [1.1 Fallas.md](../1.1%20Fallas.md)), aplicarla mediante preguntas dirigidas a la IA, y llegar a un diagnóstico final. A diferencia de un caso ya resuelto en papel, aquí el estudiante experimenta la incertidumbre real de no saber cuántas preguntas necesitará ni si su metodología elegida es la más eficiente, pudiendo cambiar de estrategia sobre la marcha.

## Equipo de protección e higiene
- Usar la IA conversacional de forma responsable: no compartir datos personales, institucionales o sensibles reales durante la práctica.
- Verificar de forma crítica las respuestas de la IA; no asumir automáticamente que toda salida es correcta o técnicamente precisa.
- Tomar descansos visuales periódicos si la sesión frente a la pantalla se extiende.
- Evitar depender por completo de la IA para razonar: el objetivo es que el estudiante decida qué preguntar y cómo interpretar la evidencia, no que la IA resuelva el caso por sí sola.

## Material y equipo necesario

### Materiales e insumos
- El "Prompt de Simulador de Diagnóstico" (ver Anexo de esta práctica).
- Formato de "Bitácora del Incidente" (ver Anexo de esta práctica) para registrar la información del ticket, la metodología elegida, los cambios de estrategia y la reflexión final.

### Equipo de laboratorio
- Computadora o dispositivo con acceso a internet.

### Herramientas
- Una IA conversacional de preferencia del estudiante (por ejemplo, ChatGPT, Claude, Gemini o Microsoft Copilot Chat), capaz de mantener una conversación con contexto a lo largo de varios turnos.
- Herramienta para capturar la conversación completa (capturas de pantalla o copiar/pegar el texto de la conversación a un documento).

## Instrucciones

### Parte 1: Selección de metodología (5 min)
1. Antes de iniciar la conversación con la IA, elige **una** de las seis metodologías de diagnóstico vistas en clase: Árbol de Fallas/Decisión, Ishikawa, 5 Porqués, Análisis de Cambios, Follow the Path o Divide y Vencerás.
2. Registra en tu bitácora la metodología elegida y una breve justificación de por qué la elegiste primero.

### Parte 2: Inicio del simulador (5 min)
1. Copia el "Prompt de Simulador de Diagnóstico" (Anexo) completo en la IA conversacional de tu elección.
2. Espera a que la IA te presente la alerta inicial de falla.
3. Abre el formato de "Bitácora del Incidente" (Anexo) y llena los datos del ticket (número de ticket, fecha/hora de apertura, reportante, sistema/servicio afectado, prioridad, descripción de la alerta) con la información que te dé la IA.

### Parte 3: Diagnóstico guiado por tu metodología (30 min)
1. Formula preguntas o solicita evidencia a la IA (por ejemplo, salidas de comandos, logs, resultados de `ping`/`traceroute`, historial de cambios) **siguiendo la lógica de la metodología elegida**.
2. Si en algún punto consideras que otra metodología sería más eficiente para el tipo de evidencia que estás encontrando, **puedes cambiar de metodología**, pero debes:
   - Anotar en tu bitácora en qué momento cambiaste, cuál era la metodología anterior, a cuál cambiaste y por qué.
3. Continúa la interacción hasta que tengas una hipótesis sólida de causa raíz.
4. Si te atoras, puedes pedir una pista a la IA (según las reglas del prompt); registra si usaste pistas y cuántas.

### Parte 4: Diagnóstico final y cierre (10 min)
1. Declara tu diagnóstico final a la IA usando el formato indicado en el prompt: `Mi diagnóstico final es: [tu hipótesis]`.
2. Registra en tu bitácora:
   - Si tu diagnóstico fue correcto o no.
   - La causa raíz real revelada por la IA.
   - El **Tiempo Total de Reparación de Falla (MTTR simulado)** reportado por la IA.
   - La evaluación de tu proceso que la IA proporcione (metodología(s) usada(s), número de preguntas, si hubo confusión entre síntoma y causa raíz, y si existía una metodología más eficiente).

### Parte 5: Reflexión final (10 min)
Responde brevemente en tu bitácora:
- ¿La metodología que elegiste al inicio fue la más adecuada? ¿Por qué sí o por qué no?
- Si cambiaste de metodología, ¿qué evidencia te hizo decidir el cambio?
- ¿Cómo se relaciona el número de preguntas/tiempo que usaste con el concepto de MTTR visto en clase?
- ¿Qué harías diferente si repitieras el ejercicio con otra falla?

### Producto esperado (evidencia a entregar)
- **Transcripción completa** de la interacción con la IA, desde la alerta inicial hasta el cierre con el MTTR simulado (capturas de pantalla o texto copiado, sin cortes ni omisiones).
- **Bitácora del Incidente** (formato del Anexo) llena con: datos del ticket, metodología inicial y justificación, registro de cualquier cambio de metodología con su razón, resultado final (acierto o no), causa raíz real, MTTR simulado, y la reflexión final de la Parte 5.

Esta evidencia se evaluará con la [Rúbrica de la Práctica 2](Rubrica%20Practica%202-%20Diagnostico%20de%20Fallas%20con%20IA.md).

## Notas
- Cada ejecución del prompt genera un escenario distinto; si se repite la práctica, la IA debe generar una falla nueva, no reutilizar la anterior.
- Si la IA "rompe personaje" y revela la causa raíz antes de tiempo, o da información contradictoria entre turnos, recuérdale las reglas del prompt (puedes copiar nuevamente la regla correspondiente) y documenta el incidente en tu bitácora; esto no invalida la práctica.
- El MTTR simulado es una aproximación pedagógica y no corresponde a tiempos reales de una red en producción; su propósito es que el estudiante relacione la cantidad y calidad de sus preguntas de diagnóstico con el tiempo de resolución.
- Evita compartir con compañeros la causa raíz de tu escenario antes de que ellos completen su propia práctica, ya que cada quien debe generar y diagnosticar su propio caso.

---

## Anexo: Prompt de Simulador de Diagnóstico (versión con MTTR)

```
Actúa como el Sistema de Gestión de Red (NMS) de una empresa mediana. Vas a simular UNA
alerta de falla de red; yo actuaré como el analista de NOC que debe diagnosticar la
causa raíz haciéndote preguntas.

Reglas del simulador:

1. Antes de empezar, genera internamente (sin mostrármelo) un escenario de falla con una
   causa raíz específica y realista, coherente con una topología típica de empresa
   (switches de acceso/distribución/core, router de borde, firewall, enlace WAN, servidor
   DHCP/DNS, controlador WiFi). No reveles la causa raíz bajo ninguna circunstancia hasta
   que yo la declare como mi diagnóstico final.

2. Define también, de forma interna, una "hora de inicio" del incidente (por ejemplo,
   09:00 am) y llévala como un reloj simulado a lo largo de toda la conversación.

3. Preséntame solo la alerta inicial: un mensaje breve y realista (trap SNMP, ticket de
   usuario, log de syslog, alerta de monitoreo) tal como lo vería un analista al iniciar
   su turno, incluyendo la hora simulada en que se generó. No des más información de la
   que un sistema de monitoreo mostraría de forma espontánea.

4. A partir de ahí, yo te pediré revisar evidencia o ejecutar comandos de diagnóstico
   (ej. "muéstrame el show interfaces del switch X", "quiero hacer ping al gateway",
   "revisa el log de cambios recientes", "haz un traceroute al servidor"). Responde
   ÚNICAMENTE con la salida/información consistente con el escenario que definiste, ni
   más ni menos. Nunca me digas directamente cuál es la causa; deja que yo la infiera de
   la evidencia que solicito.

5. Cada vez que pida revisar evidencia o ejecutar un comando, avanza el reloj simulado
   una cantidad de tiempo razonable según la acción (por ejemplo, 1-3 minutos para un
   comando rápido, 5-10 minutos para revisar logs extensos o esperar una respuesta de
   otro equipo), e indícame la hora simulada actual junto con tu respuesta.

6. Si pido revisar algo que no tiene sentido dado el escenario, responde de forma
   realista (ej. "sin cambios relevantes", "no aplica", "sin hallazgos"), y aun así avanza
   el reloj simulado un poco (esto representa el costo de tiempo de investigar pistas
   falsas).

7. Si pido explícitamente una pista, da UNA pista indirecta (por ejemplo, orientándome a
   qué capa OSI mirar, o qué metodología de diagnóstico podría ser útil: Divide y
   Vencerás, 5 Porqués, Ishikawa, Árbol de Fallas, Análisis de Cambios, Follow the Path),
   sin revelar la causa raíz, y avanza el reloj simulado un poco también.

8. El ejercicio termina cuando yo escriba exactamente: "Mi diagnóstico final es: [mi
   hipótesis]". En ese momento:
   - Dime si acerté o no.
   - Revela la causa raíz real y explica la cadena completa síntoma → causa raíz.
   - Calcula y muestra el **Tiempo Total de Reparación de Falla (MTTR simulado)**: la
     diferencia entre la hora de inicio del incidente y la hora simulada actual.
   - Evalúa mi proceso: ¿cuántas preguntas usé?, ¿qué metodología de diagnóstico apliqué
     implícitamente (o metodologías, si cambié de estrategia)?, ¿había una metodología
     más eficiente para este caso?, ¿confundí algún síntoma con la causa raíz en el
     camino?

9. Mantente dentro del temario de Administración de Redes (FCAPS, gestión de fallas,
   capas OSI, herramientas como SNMP, syslog, traceroute, NetFlow). No inventes
   tecnologías, comandos o salidas que no sean técnicamente plausibles.

Para empezar: genera la alerta inicial con su hora simulada. Si no indico lo contrario,
usa dificultad "intermedio" y no me des número de preguntas límite. Espera mi primera
pregunta antes de continuar.
```

---

## Anexo: Formato de Bitácora del Incidente

Copia esta tabla a tu documento de entrega y complétala conforme avances en la práctica.

### Datos del ticket

| Campo | Información |
|---|---|
| Número de ticket | |
| Fecha y hora de apertura (simulada) | |
| Reportado por | |
| Sistema/servicio afectado | |
| Ubicación / segmento de red | |
| Prioridad / severidad | |
| Descripción de la alerta inicial | |
| Analista asignado (tu nombre) | |

### Metodología de diagnóstico

| Campo | Información |
|---|---|
| Metodología inicial elegida | |
| Justificación de la elección | |
| ¿Hubo cambio de metodología? (Sí/No) | |
| Momento del cambio (n.º de pregunta u hora simulada) | |
| Metodología anterior → nueva metodología | |
| Razón del cambio | |
| Número de pistas solicitadas a la IA | |

### Registro de interacción (resumen)

| # | Pregunta / evidencia solicitada | Hallazgo relevante | Hora simulada |
|---|---|---|---|
| 1 | | | |
| 2 | | | |
| 3 | | | |
| ... | | | |

### Cierre del incidente

| Campo | Información |
|---|---|
| Diagnóstico final declarado | |
| ¿Diagnóstico correcto? (Sí/No) | |
| Causa raíz real (revelada por la IA) | |
| Cadena causal síntoma → causa raíz | |
| Tiempo Total de Reparación de Falla (MTTR simulado) | |
| Evaluación de la IA sobre tu proceso | |

### Reflexión final

Responde aquí las preguntas de la Parte 5 de la práctica (adecuación de la metodología elegida, evidencia que motivó cambios, relación con el MTTR, y qué harías diferente).


## Rúbrica: Práctica 2 — Diagnóstico de Fallas de Red con Asistencia de IA

**Asignatura**: Administración de Redes (SCA-1002) | Unidad 1 — Funciones de la administración de redes
**Instrumento**: Rúbrica (evidencia de desempeño/producto)
**Evidencia evaluada**: Transcripción de la interacción con la IA + Bitácora del Incidente (ver [Practica 2- Diagnostico de Fallas con IA.md](Practica%202-%20Diagnostico%20de%20Fallas%20con%20IA.md))

| Criterio | Excelente (2) | Aceptable (1) | Insuficiente (0) |
|---|---|---|---|
| **1. Aplicación de la metodología de diagnóstico** | Aplica de forma consistente la metodología elegida; si cambia de metodología, el cambio está bien justificado con evidencia. | Aplica la metodología elegida de forma parcial o irregular; si cambia de metodología, la justificación es vaga. | No sigue una metodología clara o el cambio de metodología no tiene justificación. |
| **2. Calidad de las preguntas y evidencia solicitada a la IA** | Las preguntas son pertinentes, progresivas y permiten acotar la causa raíz de forma eficiente. | Las preguntas son en general pertinentes, aunque incluyen algunas redundantes o poco enfocadas. | Las preguntas son dispersas, redundantes o no se relacionan con el diagnóstico. |
| **3. Diagnóstico final y uso de la evidencia** | El diagnóstico final es correcto (o, si no lo es, está bien fundamentado en la evidencia obtenida) y no confunde síntoma con causa raíz. | El diagnóstico presenta una fundamentación parcial o confunde en algún punto síntoma con causa raíz. | El diagnóstico carece de fundamento en la evidencia recabada o es una conjetura sin sustento. |
| **4. Bitácora del Incidente** | Completa todos los campos del formato (datos del ticket, metodología, registro de interacción, cierre con MTTR) de forma clara y trazable. | Completa la mayoría de los campos, con algunas omisiones menores o falta de claridad. | Bitácora incompleta, con campos clave faltantes (p. ej. MTTR, causa raíz o metodología). |
| **5. Reflexión final** | Relaciona explícitamente su proceso de diagnóstico con el concepto de MTTR y propone mejoras concretas para un futuro diagnóstico. | Responde las preguntas de reflexión de forma general, con poca profundidad o vínculo parcial con el MTTR. | Reflexión ausente, superficial o sin relación con el ejercicio realizado. |

## Escala de valoración

| Puntaje total | Valoración |
|---|---|
| 9 - 10 puntos | Excelente |
| 5 - 8 puntos | Aceptable |
| 0 - 4 puntos | Insuficiente |

**Puntaje máximo**: 10 puntos (5 criterios × 2 puntos)
