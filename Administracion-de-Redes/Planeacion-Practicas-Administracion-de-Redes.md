# Planeación de Prácticas de Laboratorio - Administración de Redes

**Fecha:** [Ciudad], [Estado], a [día] de [mes] de [año]

**Para:** C. [Nombre de la jefatura de laboratorio]  
**Jefe(a) de Laboratorio de:** [Nombre del laboratorio]  
**Presente**

Con base en la planeación del curso de **Administración de Redes**, clave **SCA-1002**, se presenta la relación de prácticas de laboratorio y actividades técnicas previstas para el semestre **[periodo escolar]**. Las fechas son tentativas y podrán ajustarse al calendario institucional, disponibilidad de equipos y avance del grupo.

## Información general

| Campo | Información |
|---|---|
| Materia | Administración de Redes |
| Clave | SCA-1002 |
| Carrera | Ingeniería en Sistemas Computacionales |
| SATCA | 0-0-4 |
| Docente | [Nombre de la persona docente] |
| Grupo | [Grupo] |
| Horario | [Día y horario] |
| Periodo | [Semestre y año] |
| Duración de referencia | 16 semanas |
| Modalidades autorizadas | VirtualBox, VMware, PNetLab, GNS3 o laboratorio físico |

## Competencia de la asignatura

**Configura y administra servicios de red para el uso eficiente y confiable de la infraestructura tecnológica de la organización.**

## Criterios generales de operación

- Las prácticas se realizarán en equipos de 2 a 4 estudiantes, con roles rotativos de implementación, verificación, documentación y accesibilidad.
- Cada equipo podrá elegir VirtualBox, VMware, PNetLab, GNS3 o el laboratorio físico, según los recursos disponibles.
- La plataforma utilizada deberá registrarse en cada reporte.
- Las redes virtuales y físicas deberán permanecer aisladas de la infraestructura institucional, salvo autorización expresa.
- Antes de los cambios se deberán realizar respaldos o instantáneas cuando sea posible.
- Se aceptarán capturas anotadas, tablas, transcripciones, audio con texto o video breve como evidencias equivalentes.
- Las prácticas que no puedan ejecutarse por falta de hardware podrán realizarse con una VM, un nodo de simulación o un escenario preparado por la persona docente.

## Relación de prácticas programadas

| No. | Semana tentativa | Unidad / tema | Nombre de la práctica o sesión | Duración | Necesidades y recursos |
|---:|---:|---|---|---:|---|
| 1 | 1 | Unidad 1: FCAPS | Práctica 1: Administración y marco FCAPS | 2 h | Computadoras; material teórico; diagrama de red; papel o herramienta digital accesible |
| 2 | 2 | Unidad 1: Fallas | Práctica 2: Diagnóstico de fallas con IA | 2 h | VM, simulador o equipo físico; registros preparados; herramienta de análisis autorizada |
| 3 | 3 | Unidad 1: Fallas | Práctica 3: Detección de fallas con monitoreo activo y pasivo | 2 h | Router, switch, cliente y servidor; Syslog o simulador; `ping`; evidencias de eventos |
| 4 | 4 | Unidad 1: Configuración | Práctica 4: Respaldo y versionado con Oxidized | 2 h | VM o servidor; router/switch simulado o físico; Git; Oxidized; acceso SSH |
| 5 | 5 | Unidad 1: Contabilidad y Seguridad | Prácticas 5 y 6: Showback de consumo y controles básicos de seguridad | 2 h | Hoja de cálculo; registros simulados; VM Linux; UFW; `sha256sum`; datos ficticios |
| 6 | 6 | Unidad 2: DHCP y DNS | Prácticas 1 y 2: Asignación automática y resolución de nombres | 2 h | Dos VM o nodos Linux; cliente; `isc-dhcp-server`; BIND9; alternativa con router simulado |
| 7 | 7 | Unidad 2: SSH y FTP/TFTP | Prácticas 3 y 4: Administración remota y transferencia de archivos | 2 h | Servidor y cliente; OpenSSH; FTP/TFTP; archivos de prueba; red aislada |
| 8 | 8 | Unidad 2: HTTP/HTTPS | Práctica 5: Servicio web y certificado de laboratorio | 2 h | Apache o Nginx; OpenSSL; navegador; VM, simulador o servidor físico |
| 9 | 9 | Unidad 2: NFS y LDAP | Prácticas 6 y 7: Archivos compartidos e identidad centralizada | 2 h | Dos VM o nodos Linux; NFS; OpenLDAP; cuentas ficticias; cliente de prueba |
| 10 | 10 | Unidad 2: Correo y Proxy | Prácticas 8 y 9: Flujo de correo y control de acceso web | 2 h | Postfix/Dovecot; Squid; cliente de correo o navegador; red aislada |
| 11 | 11 | Unidad 3: Protocolos de administración | Práctica 3.1: SNMP, MIB y consulta de dispositivos | 2 h | Router/switch o nodo Linux; MIB Browser, `snmpget` o `snmpwalk`; alternativa Packet Tracer |
| 12 | 12 | Unidad 3: Bitácoras y protocolos | Práctica 3.2: Bitácoras y tareas programadas | 2 h | Linux; `journalctl`; rsyslog; cron o systemd timers; servicios de prueba |
| 13 | 13 | Unidad 3: Análisis y desempeño | Prácticas 3.3 y 3.4: Wireshark/tcpdump y medición de desempeño | 2 h | Wireshark o `tcpdump`; `ping`, `mtr`, `iperf3`; tráfico autorizado; tablas de resultados |
| 14 | 14 | Unidad 3: QoS | Práctica 3.5: Priorización y gestión de tráfico | 2 h | Linux con `tc`, router con QoS o simulador; `iperf3`; mediciones antes/después |
| 15 | 15 | Unidad 4: Seguridad básica | Prácticas 4.1–4.4: activos, riesgos, políticas y mecanismos de seguridad | 2 h | VM, simulador o hardware; matriz de riesgos; firewall; cuentas; respaldos; hash |
| 16 | 16 | Unidad 4: Resolución de problemas | Práctica 4.5 y cierre integrador de seguridad | 2 h | Escenario de incidente; logs; configuración de respaldo; guía de observación; portafolio |

## Competencias y evidencias por unidad

### Unidad 1: Funciones de la administración de redes

**Competencia:** Aplica las funciones de la administración de redes para la optimización del desempeño y el aseguramiento de las mismas.

**Evidencias principales:**

- Diagnóstico y clasificación de fallas.
- Registro, detección y resolución de incidentes.
- Respaldo y versionado de configuraciones.
- Reporte de showback con datos de consumo.
- Aplicación de controles básicos de seguridad.

**Instrumentos:** lista de cotejo, rúbrica de reporte técnico y guía de observación.

### Unidad 2: Servicios de red

**Competencia:** Instala, configura y administra diferentes servicios de red para satisfacer las necesidades específicas de las organizaciones.

**Evidencias principales:**

- Servicios DHCP, DNS, SSH, FTP/TFTP, HTTP/HTTPS, NFS, LDAP, correo y Proxy configurados o reproducidos.
- Pruebas de funcionamiento y restricciones.
- Documentación de usuarios, permisos, seguridad y accesibilidad.

**Instrumentos:** lista de cotejo por servicio, reporte técnico y coevaluación de equipo.

### Unidad 3: Análisis y monitoreo

**Competencia:** Analiza y monitorea la red para medir su desempeño y fiabilidad con herramientas de software.

**Evidencias principales:**

- Consultas SNMP y MIB.
- Bitácoras y tareas programadas.
- Capturas filtradas de protocolos.
- Mediciones de latencia, pérdida, disponibilidad y capacidad.
- Comparación de tráfico con y sin QoS.

**Instrumentos:** guía de observación, tabla de mediciones y rúbrica de análisis.

### Unidad 4: Seguridad básica

**Competencia:** Aplica mecanismos de seguridad para proporcionar niveles de confiabilidad en una red.

**Evidencias principales:**

- Inventario de activos y matriz de riesgos.
- Política de seguridad verificable.
- Controles de acceso, firewall, integridad y respaldo.
- Resolución documentada de un incidente controlado.

**Instrumentos:** lista de cotejo, matriz de riesgos, reporte de incidente y rúbrica.

## Recursos generales

### Plataformas y software

- VirtualBox o VMware.
- GNS3 o PNetLab.
- Debian o Ubuntu Server.
- Cisco Packet Tracer cuando sea suficiente para el objetivo.
- Wireshark, tcpdump, iperf3, OpenSSH, rsyslog, Apache, BIND9, UFW y herramientas equivalentes.
- LibreOffice, hojas de cálculo o alternativas accesibles.

### Hardware de laboratorio físico

- Computadoras o servidores.
- Routers y switches administrables.
- Cables Ethernet y consola.
- Punto de acceso, firewall o equipo equivalente, cuando esté disponible.
- Red aislada o VLAN de prácticas.

### Recursos de accesibilidad

- Lectores de pantalla.
- Ampliación y contraste alto.
- Subtítulos y transcripciones.
- Instrucciones en formato digital y texto plano.
- Alternativas de entrega escrita, oral o audiovisual.
- Roles no dependientes exclusivamente de la digitación o actuación.

## Organización y responsabilidades

| Responsable | Funciones |
|---|---|
| Docente | Autoriza escenarios, verifica seguridad, orienta la implementación y evalúa evidencias |
| Jefatura de laboratorio | Coordina disponibilidad, mantenimiento y acceso a equipos |
| Equipo de estudiantes | Planifica, configura, mide, documenta y restaura el entorno |
| Responsable de seguridad del equipo | Verifica aislamiento, respaldos y uso ético de herramientas |
| Responsable de documentación | Conserva bitácora, capturas, comandos y resultados |

## Consideraciones de seguridad y continuidad

- Separar la red de prácticas de la red institucional.
- Utilizar datos, cuentas y certificados ficticios.
- No publicar servicios de laboratorio en Internet.
- No ejecutar pruebas de ataque, escaneo o saturación fuera del alcance autorizado.
- Mantener respaldos e instantáneas antes de cambios importantes.
- Verificar el procedimiento de rollback antes de aplicar una configuración.
- Restaurar equipos y servicios al estado acordado al finalizar.
- Reportar inmediatamente la pérdida de conectividad, credenciales o información sensible.

## Evaluación global sugerida

La ponderación deberá ajustarse al diseño instruccional y al acuerdo del curso. Como referencia:

| Evidencia | Ponderación sugerida |
|---|---:|
| Reportes de prácticas de Unidad 1 | 20% |
| Reportes de prácticas de Unidad 2 | 25% |
| Análisis y monitoreo de Unidad 3 | 25% |
| Seguridad y resolución de incidentes de Unidad 4 | 20% |
| Portafolio, participación y reflexión final | 10% |
| **Total** | **100%** |

## Calendario de recuperación

- **Semana 6:** recuperación de prácticas de Unidad 1 y ajuste de plataformas.
- **Semana 10:** recuperación de servicios de Unidad 2 o entrega de evidencias equivalentes.
- **Semana 14:** revisión de mediciones y corrección de reportes de Unidad 3.
- **Semana 16:** cierre de Unidad 4, integración del portafolio y autoevaluación.

## Criterios de reprogramación

Las fechas podrán modificarse cuando exista:

- Suspensión de actividades institucionales.
- Indisponibilidad o mantenimiento de hardware.
- Falta temporal de conectividad.
- Necesidad de una adaptación razonable o accesible.
- Incidente de seguridad o riesgo para la infraestructura.

En todos los casos se conservará el objetivo de aprendizaje y se acordará una evidencia alternativa.

**En espera de haber cumplido con las expectativas propuestas, quedo de usted.**

**ATENTAMENTE**

**[Nombre de la persona docente]**  
**NOMBRE Y FIRMA**
