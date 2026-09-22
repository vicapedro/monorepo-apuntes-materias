# Práctica 3.1: Consulta básica de protocolos de administración de red

## Objetivo
Configurar y utilizar SNMP para consultar información básica de un dispositivo de red, identificando el estado, nombre, tiempo de actividad y contadores de una interfaz.

**Duración estimada:** 1.5 horas

## Competencia
Analiza y monitorea la red para medir su desempeño y fiabilidad con herramientas de software.

## Introducción
Los protocolos de administración permiten recopilar información sin conectarse manualmente a cada dispositivo. En esta práctica se utilizará SNMPv2c en una red aislada y se comparará la consulta desde un MIB Browser, `snmpget` o una herramienta disponible.

## Equipo de protección e higiene
- Usa una red aislada y una community string exclusiva del laboratorio.
- No habilites SNMP con community pública en producción.
- Utiliza SNMPv3 cuando el equipo lo soporte en un entorno real.

## Material y equipo necesario
- Router o switch Cisco, nodo de PNetLab/GNS3 o dispositivo físico.
- Alternativamente, servidor Linux con `snmpd` en VirtualBox o VMware.
- MIB Browser, `snmpget`, `snmpwalk` o una herramienta gráfica equivalente.
- Cliente de administración en la misma red.

## Instrucciones
1. Diseña una red aislada y registra IP, dispositivo, versión SNMP y responsable de la consulta.
2. Habilita un agente SNMP de solo lectura. En Cisco, utiliza una community de laboratorio; en Linux, configura `snmpd` limitado a la red de práctica.
3. Consulta al menos:
   - `sysName`.
   - `sysUpTime`.
   - `ifDescr`.
   - `ifOperStatus`.
   - `ifInOctets` e `ifOutOctets`.
4. Repite la consulta antes y después de generar tráfico con `ping` o una página web local.
5. Compara los contadores y explica qué información proporciona cada herramienta.
6. Documenta el riesgo de SNMPv1/v2c y una propuesta de SNMPv3.

## Evidencias
- E1: topología, direccionamiento y versión SNMP.
- E2: configuración de agente de solo lectura.
- E3: consultas exitosas de OID.
- E4: comparación de contadores antes y después del tráfico.
- E5: recomendación de seguridad.

## Preguntas de análisis
1. ¿Qué diferencia existe entre un agente y un administrador SNMP?
2. ¿Por qué un contador debe asociarse con interfaz, dirección y momento de medición?
3. ¿Qué alternativa ofrecerías a quien no tiene MIB Browser pero sí una terminal?

## Evaluación
Lista de cotejo: agente configurado, consultas verificables, mediciones comparables, interpretación y seguridad.

## Notas
En Packet Tracer puede utilizarse MIB Browser; en GNS3/PNetLab o hardware se puede usar `snmpget` y `snmpwalk`. La evidencia se evalúa por el resultado, no por la plataforma.
