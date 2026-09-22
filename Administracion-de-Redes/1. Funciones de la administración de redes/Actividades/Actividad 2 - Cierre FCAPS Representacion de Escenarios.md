# Actividad 2: FCAPS en acción: personas, procesos y herramientas

**Asignatura:** Administración de Redes (SCA-1002) | **Unidad 1:** Funciones de la administración de redes  
**Tema:** Cierre integrador del framework FCAPS  
**Competencia de unidad:** Aplica las funciones de la administración de redes para la optimización del desempeño y el aseguramiento de las mismas.  
**Tipo:** Sumativa, evidencia de desempeño y producto  
**Modalidad:** Equipos de 4 a 6 estudiantes, presencial con trabajo autónomo  
**Metodología:** Aprendizaje Basado en Problemas, dramatización y aprendizaje colaborativo  
**Duración:** Trabajo autónomo durante el fin de semana y una sesión presencial de presentaciones  
**Tiempo de presentación:** 5 minutos por equipo

## Propósito

Analizar una situación auténtica de administración de redes y demostrar que **FCAPS funciona como un sistema integrado**, no como cinco funciones aisladas. El equipo deberá mostrar que una herramienta tecnológica solo produce valor cuando existen personas responsables, procesos definidos, comunicación, documentación y criterios para tomar decisiones.

La representación debe integrar, según corresponda, las cinco funciones:

- **Fallas:** detección, registro, diagnóstico, escalamiento y resolución.
- **Configuración:** cambios controlados, respaldos, autorización y reversión.
- **Contabilidad:** identificación del uso de recursos, costos, cuotas o responsabilidad.
- **Desempeño:** métricas, capacidad, disponibilidad, latencia y tendencias.
- **Seguridad:** prevención, control de acceso, confidencialidad, integridad y respuesta.

No es necesario que todas las funciones tengan la misma duración dentro de la historia. Lo importante es explicar cómo se relacionan para resolver el problema o justificar la decisión presentada.

## Resultado esperado

Cada equipo presentará una representación de cinco minutos que incluya:

1. Un problema o decisión reconocible en una organización.
2. Personajes o roles con intereses y responsabilidades diferentes.
3. La relación entre personas, procesos y herramientas.
4. Al menos tres funciones de FCAPS explícitamente identificables y una conexión con las funciones restantes.
5. Una conclusión o decisión sustentada técnicamente.

El equipo entregará además un **guion breve**, una ficha de integración FCAPS y una relación de participantes en la elaboración de vestuario, utilería y producción.

## Organización de la actividad

### Antes del fin de semana: asignación y sorteo

1. La persona docente forma equipos de 4 a 6 integrantes.
2. Cada equipo selecciona o sortea un escenario de la sección **Escenarios**.
3. Cada equipo sortea una modalidad de representación de la sección **Modalidades**.
4. El equipo registra su escenario, modalidad y roles en la ficha de trabajo.
5. La persona docente aclara dudas sobre el alcance técnico sin resolver la historia por el equipo.

### Trabajo autónomo durante el fin de semana

El equipo deberá:

1. Investigar o recuperar los conceptos de FCAPS necesarios para su escenario.
2. Construir la historia con inicio, conflicto, análisis y decisión.
3. Elaborar un guion con duración máxima de cinco minutos.
4. Diseñar vestuario y utilería sencilla. No se requiere comprar materiales.
5. Ensayar y cronometrar la representación.
6. Preparar una ficha donde se identifique la función FCAPS representada en cada momento.
7. Distribuir tareas de actuación, escritura, investigación, dirección, utilería, audio, edición o presentación.

### Sesión de presentaciones

1. Cada equipo dispone de un máximo de cinco minutos.
2. La persona docente puede detener la presentación al cumplirse el tiempo para asegurar la participación de todos los equipos.
3. Después de cada representación, el público identifica verbalmente:
   - El problema central.
   - Las funciones FCAPS observadas.
   - Una herramienta utilizada o propuesta.
   - Un proceso o responsabilidad humana indispensable.
4. El equipo responde una pregunta breve de retroalimentación formulada por la persona docente o por otro equipo.

## Escenarios

### Escenario 1. "Ahora sí me harté": el usuario que reportó demasiado tarde

Durante una semana, una persona usuaria ha experimentado videollamadas interrumpidas, lentitud para acceder al sistema institucional y pérdida de archivos compartidos. No reportó el problema porque pensó que se resolvería solo. Hoy llama muy molesta justo cuando debe entregar un informe importante.

El equipo representa la atención del incidente desde la llamada inicial hasta la solución y el seguimiento. Debe mostrar la diferencia entre síntoma, incidente y causa raíz, así como las consecuencias de no reportar oportunamente.

**Elementos que pueden integrar:** ticket, prioridad, SLA, monitoreo de desempeño, revisión de configuración Wi-Fi, seguridad de credenciales, consumo de ancho de banda y comunicación con la persona usuaria.

**Decisión final:** resolver solo el caso individual o establecer un proceso para detectar y atender problemas similares antes de que se acumulen.

### Escenario 2. "La herramienta no arregla la red": propuesta de gestión de configuración

El equipo de infraestructura realiza cambios manuales en routers y switches. Un cambio no documentado provoca una interrupción y nadie sabe quién lo realizó ni cómo regresar a la configuración anterior. Se propone adoptar una herramienta como Oxidized, RANCID, Ansible o un sistema de control de cambios.

El equipo debe presentar la situación antes y después de adoptar la herramienta, sin caer en la idea de que el software resuelve todo automáticamente.

**Elementos que pueden integrar:** respaldo de configuraciones, control de versiones, autorización, pruebas, plan de rollback, control de acceso, capacitación, responsables y revisión de cambios.

**Decisión final:** aprobar, rechazar o condicionar la adopción de la herramienta con un proceso de implementación.

### Escenario 3. "La red funciona, pero nadie sabe cuánto cuesta"

La gerencia observa que aumentaron los costos de conectividad y servicios de nube. Cada área afirma que consume poco y responsabiliza a las demás. Los registros están incompletos, no hay una unidad de medida común y no se distingue entre consumo institucional, invitados y servicios críticos.

El equipo representa una reunión de análisis para decidir si se implementa un sistema de contabilidad, showback o chargeback.

**Elementos que pueden integrar:** medición por departamento, identidad del consumidor, volumen de datos, cuotas, tarifas, capacidad, privacidad, calidad de registros y reglas de asignación.

**Decisión final:** qué se medirá, quién será responsable del dato y cómo se utilizará la información sin convertir una estimación en una factura injustificada.

### Escenario 4. "El dashboard está en verde": disponibilidad aparente y experiencia real

El sistema de monitoreo indica que todos los dispositivos están activos, pero las personas usuarias reportan que las aplicaciones tardan demasiado. El equipo de soporte insiste en que no existe una falla porque los routers responden a ping.

La representación debe contrastar la disponibilidad técnica con el desempeño percibido por las personas usuarias y mostrar cómo se construye una investigación integral.

**Elementos que pueden integrar:** latencia, pérdida de paquetes, utilización de enlaces, tiempos de respuesta, registros de aplicación, priorización de tráfico, escalamiento y comunicación del incidente.

**Decisión final:** qué métricas adicionales se incorporarán y cómo se evitará cerrar el incidente únicamente porque el ping responde.

### Escenario 5. "Un clic cambió todo": seguridad, configuración y respuesta

Una cuenta con permisos excesivos modifica una regla del firewall. El cambio bloquea un servicio institucional y también deja una puerta abierta que nadie detecta durante varias horas. El personal discute si debe restaurar la configuración, investigar el evento o mantener el servicio disponible a cualquier costo.

El equipo debe escenificar la respuesta coordinada y mostrar que seguridad no es responsabilidad exclusiva del firewall.

**Elementos que pueden integrar:** control de acceso, principio de mínimo privilegio, bitácoras, respaldo, rollback, análisis de impacto, continuidad del servicio, escalamiento y documentación posterior.

**Decisión final:** cómo restaurar el servicio sin destruir evidencias y qué cambio de proceso evitará que la situación se repita.

### Escenario 6. "Cinco áreas, cinco explicaciones": crisis de la red institucional

Una organización pierde conectividad de manera intermitente durante varias horas. Fallas atribuye el problema al proveedor, Configuración señala una modificación reciente, Desempeño muestra saturación, Seguridad detecta tráfico anómalo y Contabilidad advierte que el consumo se duplicó. La gerencia exige una respuesta clara en diez minutos.

Cada integrante puede representar una función FCAPS diferente. El reto es construir una explicación común y un plan coordinado, en lugar de presentar cinco diagnósticos aislados.

**Elementos que pueden integrar:** correlación de eventos, análisis de causa raíz, prioridades, métricas, consumo, controles de seguridad, cambio reciente, comunicación ejecutiva y plan de seguimiento.

**Decisión final:** cuál es la hipótesis más sustentada, qué datos faltan y qué acciones se ejecutarán primero.

### Escenario 7. "Tres horas sin cobrar": la crisis de los puntos de venta

Las personas operadoras de las cajas de cobro han reportado durante varios días fallas intermitentes en las terminales POS: algunas transacciones se quedan procesando, otras se rechazan y en ocasiones el sistema vuelve a funcionar sin intervención. El personal de soporte ha reiniciado equipos de manera aislada, pero no ha abierto un incidente general ni ha correlacionado los reportes.

En un día de alta afluencia, todas las cajas quedan sin acceso durante tres horas. Las filas crecen, las personas clientes publican quejas en redes sociales y la gerencia se entera del incidente por esas publicaciones, antes de recibir un reporte formal del área de TI.

**Elementos que pueden integrar:** registro y correlación de incidentes, disponibilidad del servicio POS, latencia y pérdida de paquetes, revisión de cambios en switches o firewall, segmentación y seguridad de la red de cobro, registros de transacciones fallidas, impacto económico, plan de contingencia, escalamiento y comunicación de crisis.

**Conexiones FCAPS esperadas:** Fallas identifica y escala el incidente; Desempeño analiza latencia, disponibilidad y capacidad; Configuración revisa cambios y aplica rollback si corresponde; Seguridad protege la red y los datos de pago; Contabilidad estima transacciones afectadas, pérdidas o uso de recursos.

**Decisión final:** cómo restaurar el servicio, cómo comunicar la situación a la gerencia y a las personas usuarias, y qué proceso permanente evitará que una falla intermitente vuelva a convertirse en una crisis conocida primero por redes sociales.

## Modalidades para sortear

El equipo sorteará una modalidad. Puede adaptar el escenario, pero debe conservar el problema técnico y la integración de FCAPS.

1. **Sketch de mesa de ayuda:** llamada, ticket, escalamiento y cierre del incidente.
2. **Podcast o programa de radio:** entrevista, llamadas de audiencia y análisis de una situación de red.
3. **Comercial de una herramienta o proceso:** anuncio que presenta el problema, la propuesta y sus condiciones reales de éxito.
4. **Contraste antes y después:** dos escenas breves que comparan una organización sin procesos con otra que adopta herramientas, roles y procedimientos.
5. **Novela mexicana:** dramatización exagerada de conflictos, secretos, culpables aparentes y revelación de la causa raíz. El humor no debe sustituir la explicación técnica.
6. **Noticiero o rueda de prensa:** reportero, área técnica, gerencia y persona usuaria explican una crisis y responden preguntas.
7. **Audiencia de comité de cambios:** el equipo representa una reunión CAB en la que se decide aprobar, rechazar o modificar una propuesta técnica.

La modalidad no se evalúa por calidad artística profesional, sino por la claridad con que comunica el problema, la solución y la relación entre FCAPS, personas y procesos.

## Roles sugeridos

No todas las personas deben actuar frente al grupo. Sin embargo, todas deben participar en la elaboración y conocer el contenido técnico.

- **Coordinación:** organiza reuniones, fechas y tareas.
- **Investigación FCAPS:** verifica conceptos, herramientas y relaciones entre funciones.
- **Guion:** estructura la historia, diálogos y duración.
- **Dirección:** coordina ensayos y transiciones.
- **Actuación o conducción:** interpreta personajes, entrevistas o narración.
- **Vestuario y utilería:** prepara elementos visuales sencillos y pertinentes.
- **Producción técnica:** controla audio, presentación, grabación o materiales.
- **Relatoría:** prepara la ficha de integración FCAPS y el reporte final.

En equipos pequeños, una persona puede asumir más de un rol. La distribución debe aparecer en la entrega.

## Requisitos del guion

El guion debe incluir:

- Título del escenario y modalidad sorteada.
- Contexto de la organización.
- Personajes y responsabilidades.
- Problema o decisión central.
- Al menos tres funciones FCAPS identificadas explícitamente.
- Herramientas utilizadas o propuestas.
- Procesos, responsabilidades y decisiones humanas.
- Evidencia o dato que sustente el diagnóstico.
- Solución, acuerdo o plan de seguimiento.
- Duración estimada por escena.

Se recomienda distribuir el tiempo así:

| Momento | Tiempo orientativo | Propósito |
|---|---:|---|
| Contexto y presentación del conflicto | 1 min | Ubicar a la audiencia |
| Desarrollo y tensión | 2 min | Mostrar síntomas, decisiones y desacuerdos |
| Integración FCAPS | 1 min | Relacionar funciones, herramientas y procesos |
| Resolución y mensaje final | 1 min | Presentar decisión, aprendizaje y prevención |

## Entregables

Cada equipo entregará, al inicio de la presentación:

1. **Guion** de una a tres cuartillas.
2. **Ficha de integración FCAPS** con la siguiente tabla:

| Momento de la historia | Función FCAPS | Herramienta o evidencia | Persona responsable | Proceso o decisión |
|---|---|---|---|---|
| | | | | |
| | | | | |
| | | | | |
| | | | | |

3. **Distribución de roles y tareas**, incluyendo actuación, guion, investigación, vestuario, utilería y producción.
4. **Lista de materiales** utilizados, indicando cuáles fueron reutilizados o elaborados por el equipo.
5. **Reflexión individual breve**: ¿qué función FCAPS comprendí mejor y qué aprendí sobre la importancia de las personas y los procesos?

## Pregunta de cierre para el equipo

Completen la siguiente frase y utilícenla como conclusión de su representación:

> Una herramienta de administración de redes solo genera valor cuando...

## Evaluación

La actividad se evaluará con la siguiente rúbrica de tres niveles. Cada criterio tiene un valor máximo de 3 puntos, para un total de 24 puntos.

| Criterio | Nivel 3: Logrado | Nivel 2: En desarrollo | Nivel 1: Inicial |
|---|---|---|---|
| **1. Comprensión integral de FCAPS** | Integra de manera coherente al menos tres funciones y establece conexiones justificadas con las funciones restantes cuando corresponde. | Menciona varias funciones, pero las relaciones entre ellas son parciales o poco justificadas. | Presenta FCAPS como funciones aisladas o contiene confusiones importantes. |
| **2. Análisis técnico del problema** | Distingue síntomas, causas, impacto, evidencia y decisión; la solución es técnicamente razonable. | Identifica el problema y propone una solución, pero omite evidencia o confunde parcialmente causa e impacto. | La historia se limita a describir el problema o propone una solución sin fundamento técnico. |
| **3. Relación entre herramientas, personas y procesos** | Explica claramente qué puede hacer la herramienta, qué no puede resolver y qué roles o procesos son necesarios. | Reconoce la importancia de personas o procesos, pero la relación con la herramienta es superficial. | Presenta la herramienta como solución automática o ignora responsabilidades y procedimientos. |
| **4. Aplicación de gestión y toma de decisiones** | Incluye priorización, comunicación, responsabilidades, seguimiento o prevención de recurrencia de forma pertinente. | Incluye alguna acción de gestión, pero sin secuencia o sin criterios suficientes. | No muestra cómo se decide, escala, documenta o previene el problema. |
| **5. Claridad y estructura de la representación** | La historia tiene contexto, conflicto, desarrollo y cierre; se comprende dentro de los cinco minutos. | La historia se comprende, aunque presenta saltos, exceso de información o un cierre débil. | La representación es difícil de seguir, excede significativamente el tiempo o no tiene cierre. |
| **6. Comunicación y habilidades blandas** | Comunica con escucha, coordinación, lenguaje profesional, empatía y manejo respetuoso del conflicto. | Comunica la idea principal, aunque muestra poca coordinación, escucha o adaptación al público. | La comunicación es confusa, desorganizada o reproduce conflictos sin manejo respetuoso. |
| **7. Creatividad y pertinencia de la modalidad** | Usa la modalidad sorteada de forma original y pertinente, sin perder el contenido técnico. | Utiliza la modalidad de manera reconocible, aunque con recursos limitados o poco integrados. | La modalidad es irreconocible, decorativa o distrae del propósito técnico. |
| **8. Participación y producción colaborativa** | Todas las personas tienen una responsabilidad verificable; el guion, vestuario, utilería y producción muestran trabajo colaborativo. | La mayoría participa, pero la distribución de tareas o la evidencia de colaboración es incompleta. | La participación se concentra en pocas personas o no se entrega evidencia de colaboración. |

### Interpretación de resultados

- **21-24 puntos:** desempeño sobresaliente; comprende FCAPS como un sistema sociotécnico.
- **16-20 puntos:** desempeño satisfactorio; requiere profundizar en algunas relaciones o procesos.
- **8-15 puntos:** desempeño inicial; necesita retroalimentación y recuperación de conceptos fundamentales.

## Retroalimentación entre equipos

Después de cada presentación, un equipo observador responderá brevemente:

- ¿Qué función FCAPS estuvo mejor representada?
- ¿Qué herramienta apareció y qué proceso humano la hizo útil?
- ¿Qué aspecto de la solución habría que mejorar?

La retroalimentación debe ser específica, respetuosa y basada en lo observado.

## DUA y participación inclusiva

- La representación puede ser presencial, narrada, grabada o conducida como programa, siempre que respete el límite de cinco minutos y sea autorizada previamente.
- Las personas que no deseen actuar pueden participar en guion, investigación, dirección, diseño, vestuario, utilería, audio, edición, narración o relatoría.
- Se permite utilizar texto de apoyo, tarjetas, imágenes, sonidos o subtítulos para facilitar la comunicación.
- El humor y el dramatismo deben dirigirse a la situación o al proceso, nunca a características personales, culturales, físicas o lingüísticas de alguien.

## Fuentes de consulta

- [1.0 Framework FCAPS.md](../1.0%20Framework%20FCAPS.md)
- [1.1 Fallas.md](../1.1%20Fallas.md)
- [1.2 Configuracion.md](../1.2%20Configuracion.md)
- [1.3 Contabilidad - Enfoque ITU-T.md](../1.3%20Contabilidad%20-%20Enfoque%20ITU-T.md)
- [1.4 Desempeño.md](../1.4%20Desempe%C3%B1o.md)
- [1.5 Seguridad.md](../1.5%20Seguridad.md)
- ITU-T. (1996). *M.3010: Principles for a Telecommunications Management Network*.
- ISO/IEC. (2018). *ISO/IEC 20000-1:2018: Information technology — Service management*.

## Anexo: rúbrica de coevaluación para el formulario

### Propósito

Cada estudiante evaluará individualmente a **cada equipo**, utilizando el escenario asignado como nombre del equipo. La coevaluación debe centrarse en la representación observada, no en la simpatía personal ni en la calidad artística profesional.

La persona docente puede promediar las respuestas recibidas por cada equipo y utilizar el resultado como retroalimentación o como un componente de la evaluación. Se recomienda conservar también la evaluación docente para equilibrar posibles diferencias entre observadores.

### Configuración sugerida del formulario

**Título:** Coevaluación: Cierre integrador de FCAPS  
**Descripción:** Evalúa de manera respetuosa, específica y honesta la presentación del equipo seleccionado. No evalúes a tu propio equipo. La escala es: 3 = logrado, 2 = en desarrollo, 1 = inicial.

#### Sección 1. Identificación

1. **Nombre o identificador de quien responde**  
   Tipo: respuesta corta. Puede configurarse como opcional si se desea una coevaluación anónima.

2. **Equipo evaluado**  
   Tipo: opción múltiple o lista desplegable. Utiliza exactamente los nombres de los escenarios:

   - Escenario 1: Ahora sí me harté
   - Escenario 2: La herramienta no arregla la red
   - Escenario 3: La red funciona, pero nadie sabe cuánto cuesta
   - Escenario 4: El dashboard está en verde
   - Escenario 5: Un clic cambió todo
   - Escenario 6: Cinco áreas, cinco explicaciones
   - Escenario 7: Tres horas sin cobrar

3. **Modalidad observada**  
   Tipo: opción múltiple.

   - Standup
   - Podcast o programa de radio
   - Comercial de una herramienta o proceso
   - Contraste Antes y Después
   - Novela mexicana
   - Noticiero o rueda de prensa

#### Sección 2. Evaluación de la presentación

Tipo recomendado para los criterios 1 al 8: **cuadrícula de opción múltiple** o una pregunta independiente por criterio.

**Columnas de respuesta:**

- **3 - Logrado:** se observa de manera clara y suficiente.
- **2 - En desarrollo:** se observa parcialmente o requiere mayor claridad.
- **1 - Inicial:** no se observa o presenta confusiones importantes.

| Criterio para el formulario | 3 - Logrado | 2 - En desarrollo | 1 - Inicial |
|---|---|---|---|
| **1. Integración de FCAPS** | Relaciona claramente al menos tres funciones FCAPS y muestra conexiones entre ellas. | Menciona varias funciones, pero las conexiones son parciales. | Presenta las funciones como temas aislados o las confunde. |
| **2. Análisis del problema** | Distingue síntomas, causa, impacto, evidencia y decisión. | Identifica el problema, pero omite alguna parte del análisis. | Describe el problema sin análisis técnico suficiente. |
| **3. Herramientas, personas y procesos** | Explica qué aporta la herramienta y qué responsabilidades humanas y procesos se necesitan. | Menciona herramientas y personas, pero sin explicar bien su relación. | Presenta la herramienta como solución automática o ignora los procesos. |
| **4. Toma de decisiones** | Muestra priorización, comunicación, responsables, seguimiento o prevención. | Presenta alguna decisión, pero sin criterios o secuencia claros. | No muestra cómo se decide, escala o previene. |
| **5. Claridad de la historia** | Tiene contexto, conflicto, desarrollo y cierre; se comprende dentro del tiempo asignado. | Se comprende, aunque tiene saltos, exceso de información o cierre débil. | Es difícil de seguir, no tiene cierre o excede claramente el tiempo. |
| **6. Comunicación y habilidades blandas** | Se observa coordinación, escucha, empatía, lenguaje respetuoso y manejo constructivo del conflicto. | Comunica la idea principal, pero con coordinación o escucha limitada. | La comunicación es confusa, desorganizada o poco respetuosa. |
| **7. Uso de la modalidad** | La modalidad sorteada comunica el contenido técnico de manera pertinente y creativa. | La modalidad es reconocible, pero está poco integrada. | La modalidad distrae o no se identifica. |
| **8. Participación colaborativa** | Se percibe participación equilibrada en actuación, guion, investigación, producción o utilería. | Participa la mayoría, pero se percibe concentración de tareas. | La participación se concentra en pocas personas o no se evidencia colaboración. |

#### Sección 3. Retroalimentación cualitativa

4. **¿Qué fue lo mejor logrado por el equipo?**  
   Tipo: párrafo. Solicitar una observación concreta relacionada con FCAPS, la historia o la comunicación.

5. **¿Qué podría mejorar el equipo?**  
   Tipo: párrafo. Solicitar una sugerencia respetuosa, específica y aplicable.

6. **¿Qué relación entre personas, procesos y herramientas te pareció más importante?**  
   Tipo: párrafo.

### Cálculo sugerido

- Puntaje máximo por equipo y estudiante: **24 puntos**.
- Puntaje de coevaluación del equipo: promedio de las respuestas válidas recibidas.
- Convertir a porcentaje, si se requiere:

  $$
  Porcentaje = \frac{Puntaje\ promedio}{24} \times 100
  $$

- No considerar respuestas que evalúen al propio equipo, estén incompletas o contengan comentarios ofensivos.

### Indicaciones para el estudiantado

- Evalúa a cada equipo con atención y honestidad.
- Usa únicamente la evidencia observada durante la presentación.
- No otorgues una calificación por simpatía, vestuario o actuación profesional.
- Reconoce fortalezas y formula sugerencias respetuosas.
- Si no comprendiste un aspecto técnico, indícalo en la retroalimentación en lugar de asumir una intención.

### Nota sobre Google Forms y Microsoft Forms

No puedo crear directamente el formulario dentro de tu cuenta de Google Workspace o Microsoft 365 porque no tengo acceso autenticado a tus cuentas ni permisos para publicar formularios externos. El contenido anterior está preparado para copiarse en cualquiera de las dos plataformas.

En ambas opciones puedes utilizar:

- Lista desplegable para el equipo evaluado.
- Cuadrícula de opción múltiple para los ocho criterios.
- Preguntas de párrafo para la retroalimentación.
- Exportación de respuestas a Google Sheets o Excel.

Google Forms suele ser conveniente si trabajas con Google Sheets; Microsoft Forms resulta práctico si tu institución utiliza Microsoft 365 y Excel. 
