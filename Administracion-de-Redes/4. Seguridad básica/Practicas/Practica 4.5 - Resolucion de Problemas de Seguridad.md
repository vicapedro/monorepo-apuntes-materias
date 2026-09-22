# Práctica 4.5: Resolución de problemas de seguridad

## Objetivo
Resolver un incidente de seguridad controlado mediante identificación, contención, diagnóstico, recuperación y prevención, documentando cada decisión.

**Duración estimada:** 2 horas

## Competencia
Aplica mecanismos de seguridad para proporcionar niveles de confiabilidad en una red.

## Introducción
La resolución de problemas de seguridad requiere distinguir entre un síntoma y una causa, conservar evidencias, contener el riesgo y recuperar el servicio. El caso puede ser una cuenta bloqueada, una regla de firewall incorrecta, un servicio expuesto o un archivo modificado.

## Equipo de protección e higiene
- Trabaja solo con un incidente preparado en una VM, simulador o red física aislada.
- No borres evidencias ni ejecutes malware real.
- No bloquees redes externas ni cuentas institucionales.
- Toma una instantánea o respaldo antes de modificar el escenario.

## Material y equipo necesario
- Dos VM o nodos en VirtualBox, VMware, GNS3 o PNetLab, o equipos físicos autorizados.
- Logs del sistema, configuración de firewall o ACL y respaldo conocido.
- Herramientas `journalctl`, `ss`, `ip`, `sha256sum`, Wireshark o equivalente.

## Escenarios controlados posibles

Elige uno:

- Una regla de firewall bloquea SSH de una red autorizada.
- Un servicio de prueba está expuesto innecesariamente.
- Una cuenta de laboratorio realiza varios intentos fallidos.
- Un archivo de configuración fue modificado y su huella no coincide.
- Una interfaz presenta tráfico anómalo en una captura preparada.

## Instrucciones
1. Recibe el reporte del incidente y registra hora, alcance, servicio afectado y persona que lo comunicó.
2. Clasifica el impacto y la urgencia.
3. Formula dos hipótesis y define una prueba segura para cada una.
4. Revisa logs, puertos, reglas, configuración o captura disponible.
5. Aplica una medida de contención reversible.
6. Recupera el servicio desde la configuración válida o el respaldo, si corresponde.
7. Verifica el funcionamiento y confirma que el control de seguridad no generó otro problema.
8. Realiza un análisis de causa raíz con los cinco porqués.
9. Propón una acción preventiva, una mejora de monitoreo y una actualización de procedimiento.
10. Cierra el ticket con evidencia, tiempos y responsables.

## Evidencias
- E1: ticket inicial y matriz de impacto/urgencia.
- E2: hipótesis y pruebas realizadas.
- E3: evidencia técnica del diagnóstico.
- E4: contención, recuperación y validación.
- E5: análisis de causa raíz y plan preventivo.

## Preguntas de análisis
1. ¿Por qué conviene contener antes de modificar muchas variables?
2. ¿Qué evidencia debe conservarse para explicar el incidente?
3. ¿Cómo comunicarías la situación a una persona usuaria sin tecnicismos innecesarios?
4. ¿Qué diferencia hay entre resolver el síntoma y eliminar la causa raíz?

## Evaluación
Lista de cotejo: registro, priorización, hipótesis, evidencia, contención, recuperación, RCA y prevención.

## Notas
La persona docente puede entregar un escenario y archivos de configuración preparados. Se permite realizar la práctica como simulación de mesa de ayuda cuando no haya dos equipos disponibles; el procedimiento y las decisiones deben quedar documentados.
