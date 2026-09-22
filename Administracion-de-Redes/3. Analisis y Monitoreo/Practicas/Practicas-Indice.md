# Índice de prácticas: Unidad 3, Análisis y Monitoreo

## Competencia de la unidad

**Analiza y monitorea la red para medir su desempeño y fiabilidad con herramientas de software.**

## Opciones de plataforma

El equipo puede realizar cada práctica en:

- VirtualBox.
- VMware.
- PNetLab.
- GNS3.
- Laboratorio físico.

La plataforma debe registrarse en el reporte. Se evaluará la comprensión del protocolo, la calidad de las mediciones, la verificación, la documentación y la interpretación; no se penalizará elegir una plataforma diferente si la evidencia es equivalente.

## Secuencia de prácticas

| Número | Tema | Práctica | Duración | Evidencia principal |
|---:|---|---|---:|---|
| 3.1 | Protocolos de administración de red | [Práctica 3.1 - Protocolos de Administración de Red](Practica%203.1%20-%20Protocolos%20de%20Administracion%20de%20Red.md) | 1.5 h | Consultas SNMP y contadores |
| 3.2 | Bitácoras | [Práctica 3.2 - Bitácoras y Tareas Programadas](Practica%203.2%20-%20Bitacoras%20y%20Tareas%20Programadas.md) | 1.5 h | Evento registrado y reporte automático |
| 3.3 | Analizadores de protocolos | [Práctica 3.3 - Análisis de Protocolos](Practica%203.3%20-%20Analisis%20de%20Protocolos.md) | 1.5 h | Captura filtrada e interpretación |
| 3.4 | Análisis de desempeño | [Práctica 3.4 - Análisis de Desempeño](Practica%203.4%20-%20Analisis%20de%20Desempeno.md) | 1.5 h | Métricas, comparación y recomendación |
| 3.4B | Gestión del desempeño con monitoreo y carga | [Práctica 3.4B - Gestión del Desempeño con Monitoreo y Carga](Practica%203.4B%20-%20Gestion%20del%20Desempeno%20con%20Monitoreo%20y%20Carga.md) | 3 h | Dashboard con baseline y carga incremental por switch |
| 3.5 | QoS | [Práctica 3.5 - QoS](Practica%203.5%20-%20QoS.md) | 2 h | Comparación con y sin priorización |

## Roles colaborativos sugeridos

- **Implementación:** configura el agente, servicio o política.
- **Medición:** ejecuta pruebas y registra datos.
- **Análisis:** interpreta resultados y límites de las métricas.
- **Documentación:** integra capturas, comandos y conclusiones.
- **Accesibilidad:** revisa que el reporte y la explicación sean comprensibles y utilizables por personas con diferentes necesidades.

Los roles pueden rotarse. No es necesario que todas las personas ejecuten comandos; todas deben comprender y poder explicar la evidencia entregada.

## Evidencia mínima común

Cada reporte debe incluir:

1. Nombre de la práctica y plataforma utilizada.
2. Objetivo, contexto y topología.
3. Direccionamiento o identificación de origen y destino.
4. Configuración o método de medición.
5. Resultado observable y evidencia de verificación.
6. Limitaciones, errores encontrados y solución aplicada.
7. Consideraciones de privacidad y seguridad.
8. Respuestas a las preguntas de análisis.

## Enfoque inclusivo y DUA

- Se aceptan capturas anotadas, tablas, explicación oral grabada o transcripción, según los recursos disponibles y los acuerdos docentes.
- Las instrucciones pueden consultarse en formato digital accesible; se permiten lectores de pantalla, ampliación, contraste alto, subtítulos y transcripciones.
- Si no se cuenta con hardware, puede utilizarse una VM, un nodo Linux en GNS3/PNetLab o un archivo de datos preparado por la persona docente.
- Los contextos propuestos incluyen biblioteca, centro comunitario, cooperativa y equipo de soporte, sin asumir una única realidad económica o cultural.
- Las pruebas deben ser reproducibles y explicarse con lenguaje claro, evitando depender de una interfaz gráfica específica.

## Seguridad y ética del monitoreo

- Capturar únicamente tráfico autorizado y de laboratorio.
- No exponer community strings, claves, tokens ni datos personales.
- No generar saturación en redes institucionales.
- No interpretar una captura como prueba suficiente de una causa sin evidencia adicional.
- Eliminar archivos de captura que contengan datos sensibles.
- Restaurar las configuraciones al terminar.

## Lista de cotejo común

- [ ] Declara la plataforma y el alcance de la práctica.
- [ ] Define qué se medirá y durante qué intervalo.
- [ ] Configura o reproduce el servicio de forma documentada.
- [ ] Presenta evidencia verificable.
- [ ] Interpreta las métricas sin confundir síntoma y causa.
- [ ] Incluye una limitación o prueba controlada.
- [ ] Aplica medidas de privacidad y seguridad.
- [ ] Considera accesibilidad y diversidad de personas usuarias.
- [ ] Entrega conclusiones y respuestas de análisis.

## Relación con el programa oficial

Las prácticas se alinean con la Unidad 3 del programa de **Administración de Redes (SCA-1002)**: protocolos de administración de red, bitácoras, analizadores de protocolos, análisis de desempeño y QoS.
