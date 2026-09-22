# Práctica 3.4: Análisis básico de desempeño de red

## Objetivo
Medir latencia, pérdida de paquetes, disponibilidad y uso de un servicio, y elaborar una recomendación basada en datos obtenidos en un intervalo definido.

**Duración estimada:** 1.5 horas

## Competencia
Analiza y monitorea la red para medir su desempeño y fiabilidad con herramientas de software.

## Introducción
El desempeño no se explica con una sola métrica. Una red puede estar disponible y, sin embargo, presentar latencia, pérdida o saturación que afecten una aplicación. El análisis debe considerar el contexto de las personas usuarias y del servicio.

## Equipo de protección e higiene
- Realiza las mediciones en una red aislada o con autorización.
- Usa cargas pequeñas y evita saturar enlaces reales.
- No publiques direcciones internas ni datos de usuarios.

## Material y equipo necesario
- Dos equipos o nodos Linux/Windows en VirtualBox, VMware, GNS3, PNetLab o laboratorio físico.
- `ping`, `mtr` o `traceroute`.
- Opcional: `iperf3`, SNMP, Zabbix, LibreNMS o Grafana.
- Un servicio web o SSH de laboratorio.

## Instrucciones
1. Define el servicio, origen, destino, intervalo de medición y umbral de aceptación.
2. Ejecuta al menos 20 mediciones de latencia y pérdida:
   ```bash
   ping -c 20 192.168.50.10
   ```
3. Si está disponible, utiliza `mtr` o `iperf3` en una red aislada para observar ruta y capacidad.
4. Registra mínimo, máximo, promedio, pérdida y hora de cada medición.
5. Repite la prueba en otro momento o después de generar tráfico moderado.
6. Elabora una gráfica o tabla comparativa.
7. Clasifica el resultado como normal, degradado o crítico y justifica una acción: observar, optimizar, aplicar QoS o ampliar capacidad.
8. Propón una forma de comunicar el resultado a una persona no técnica.

## Evidencias
- E1: definición de servicio, umbral y periodo.
- E2: resultados de mediciones.
- E3: comparación de dos condiciones.
- E4: gráfica o tabla interpretada.
- E5: recomendación técnica y comunicación accesible.

## Preguntas de análisis
1. ¿Por qué el promedio puede ocultar problemas?
2. ¿Qué diferencia hay entre disponibilidad y buen desempeño?
3. ¿Qué dato adicional pedirías antes de recomendar ampliar un enlace?

## Evaluación
Lista de cotejo: método, datos suficientes, métricas, comparación, interpretación y recomendación.

## Notas
Si no se puede generar tráfico con `iperf3`, utiliza solicitudes web repetidas y documenta esa alternativa. También se acepta analizar una serie de mediciones preparada por la persona docente.
