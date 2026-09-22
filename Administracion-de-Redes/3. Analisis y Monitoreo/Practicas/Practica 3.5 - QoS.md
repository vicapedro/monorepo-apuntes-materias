# Práctica 3.5: Introducción a QoS y priorización de tráfico

## Objetivo
Comparar una red sin priorización con una red que aplica una regla básica de QoS, observando el efecto sobre tráfico sensible al tiempo y tráfico de transferencia.

**Duración estimada:** 2 horas

## Competencia
Analiza y monitorea la red para medir su desempeño y fiabilidad con herramientas de software.

## Introducción
QoS permite administrar recursos cuando varias aplicaciones compiten por el mismo enlace. El objetivo no es hacer que todo el tráfico sea más rápido, sino proteger servicios críticos y definir criterios transparentes de priorización.

## Equipo de protección e higiene
- Realiza la práctica en una red aislada.
- No generes saturación intencional en redes institucionales.
- Documenta quién decide la prioridad y con qué criterio.
- No priorices tráfico por identidad personal; prioriza servicios y necesidades justificadas.

## Material y equipo necesario
- Linux con `tc` en dos VM de VirtualBox/VMware o nodos Linux de GNS3/PNetLab.
- Alternativamente, router Cisco con soporte de QoS o equipo físico autorizado.
- `iperf3`, `ping`, `mtr` o un servicio web local.
- Opcional: Wireshark para observar colas y pérdida.

## Instrucciones
1. Define dos clases de tráfico: servicio sensible al tiempo, como voz simulada o ping periódico, y transferencia de datos, como `iperf3` o descarga local.
2. Mide latencia, pérdida y capacidad sin QoS.
3. Aplica una configuración sencilla de clasificación y limitación o priorización. En Linux puede emplearse `tc`; en Cisco, una policy-map equivalente.
4. Repite las mediciones bajo carga moderada y compara resultados.
5. Registra qué tráfico fue priorizado, qué límite se aplicó y qué efecto tuvo sobre el resto.
6. Verifica que la configuración pueda retirarse mediante un procedimiento de rollback.
7. Elabora una política breve que explique quién puede solicitar prioridad y cómo se revisará.

## Evidencias
- E1: definición de clases, necesidades y criterios.
- E2: medición sin QoS.
- E3: configuración aplicada y método de reversión.
- E4: medición con QoS.
- E5: comparación y política breve.

## Preguntas de análisis
1. ¿Qué métrica mejoró y cuál pudo empeorar?
2. ¿Por qué priorizar un servicio implica tomar una decisión administrativa?
3. ¿Cómo evitarías que una política de QoS perjudique a personas o servicios legítimos?

## Evaluación
Lista de cotejo: clases justificadas, mediciones comparables, QoS funcional, rollback, interpretación y política.

## Notas
Si el equipo no dispone de un router con QoS, puede realizarse con `tc` en Linux o con datos comparativos preparados. No es necesario simular una llamada real para estudiar latencia y pérdida.
