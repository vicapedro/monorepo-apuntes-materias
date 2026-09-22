# Índice de prácticas: Unidad 2, Servicios de Red

## Competencia de la unidad

**Instala, configura y administra diferentes servicios de red para satisfacer las necesidades específicas de las organizaciones.**

## Enfoque de trabajo

Esta serie permite que cada equipo seleccione el entorno que tenga disponible:

- VirtualBox.
- VMware.
- PNetLab.
- GNS3.
- Laboratorio físico.

La plataforma no sustituye la competencia: se evaluará la capacidad de explicar el servicio, configurarlo o reproducir su funcionamiento, verificarlo, documentarlo y relacionarlo con una necesidad organizacional.

## Secuencia sugerida

| No. | Servicio | Práctica | Duración | Evidencia principal |
|---:|---|---|---:|---|
| 1 | DHCP | [Práctica 1 - DHCP](Practica%201%20-%20DHCP.md) | 1.5 h | Concesión automática y verificación TCP/IP |
| 2 | DNS | [Práctica 2 - DNS](Practica%202%20-%20DNS.md) | 1.5 h | Resolución directa e inversa |
| 3 | SSH | [Práctica 3 - SSH](Practica%203%20-%20SSH.md) | 1.5 h | Administración remota con cuenta individual |
| 4 | FTP/TFTP | [Práctica 4 - FTP TFTP](Practica%204%20-%20FTP%20TFTP.md) | 1.5 h | Transferencia, permisos e integridad |
| 5 | HTTP/HTTPS | [Práctica 5 - HTTP HTTPS](Practica%205%20-%20HTTP%20HTTPS.md) | 1.5 h | Página web y certificado de laboratorio |
| 6 | NFS | [Práctica 6 - NFS](Practica%206%20-%20NFS.md) | 1.5 h | Directorio compartido y permisos |
| 7 | LDAP | [Práctica 7 - LDAP](Practica%207%20-%20LDAP.md) | 2 h | Directorio de usuarios y grupos |
| 8 | SMTP/IMAP/POP | [Práctica 8 - Correo SMTP IMAP POP](Practica%208%20-%20Correo%20SMTP%20IMAP%20POP.md) | 1.5 h | Flujo de correo local |
| 9 | Proxy | [Práctica 9 - Proxy](Practica%209%20-%20Proxy.md) | 1.5 h | Solicitud permitida y rechazada |

## Organización de equipos

Se recomienda formar equipos de 2 a 4 estudiantes y asignar roles rotativos:

- **Responsable de implementación:** ejecuta o coordina la configuración.
- **Responsable de verificación:** diseña y realiza las pruebas.
- **Responsable de documentación:** registra comandos, resultados y evidencias.
- **Responsable de accesibilidad y contexto:** revisa que el servicio sea comprensible y útil para las personas del caso.

Una misma persona puede asumir más de un rol. La calificación no depende de quién escribe más comandos, sino de la evidencia y la comprensión compartida.

## Opciones de implementación

| Entorno | Uso recomendado | Evidencia alternativa |
|---|---|---|
| VirtualBox | Dos o más servidores y clientes Linux | Capturas, terminal y diagrama de red virtual |
| VMware | Prácticas equivalentes a VirtualBox | Capturas y configuración de adaptadores |
| PNetLab | Routers, firewalls y nodos Linux | Topología, consola y pruebas de conectividad |
| GNS3 | Servicios Linux y dispositivos de red | Proyecto, consola y capturas |
| Laboratorio físico | Servidores, switches, routers y clientes reales | Fotografías autorizadas, consola y resultados |

## Evidencia mínima común

Cada reporte debe incluir:

1. Nombre de la práctica y plataforma utilizada.
2. Objetivo y contexto organizacional.
3. Diagrama o descripción de la topología.
4. Direccionamiento IP y nombres de equipos.
5. Comandos o pantallas de configuración relevantes.
6. Prueba de funcionamiento y resultado esperado.
7. Una prueba de error, restricción o permiso cuando la práctica la solicite.
8. Problemas encontrados y solución aplicada.
9. Reflexión sobre personas usuarias, accesibilidad, seguridad y operación.

## Enfoque inclusivo y DUA

- Los equipos pueden entregar evidencias escritas, capturas anotadas, audio explicativo o video breve, de acuerdo con los recursos disponibles y las indicaciones docentes.
- Las instrucciones deben escribirse con lenguaje claro y evitar suponer experiencia previa con una plataforma específica.
- Se permiten lectores de pantalla, ampliación de texto, subtítulos, transcripciones y teclados alternativos.
- Cuando no exista hardware suficiente, se acepta una VM, un nodo de simulación o una demostración guiada documentada.
- Los casos utilizan organizaciones diversas: biblioteca, cooperativa, centro comunitario, organización educativa y equipo de soporte.
- Las personas integrantes pueden distribuir tareas de acuerdo con sus fortalezas: configuración, pruebas, documentación, comunicación o diseño.

## Seguridad del laboratorio

- Usar redes aisladas o VLAN de prácticas.
- No publicar servicios ni credenciales en Internet.
- Utilizar datos ficticios.
- Guardar instantáneas o respaldos antes de cambios importantes.
- Evitar escaneos, relay abierto, DHCP no autorizado y pruebas contra redes externas.
- Restaurar las configuraciones al terminar cada práctica.

## Instrumento común sugerido

Lista de cotejo por práctica:

- [ ] Define el propósito del servicio.
- [ ] Documenta la plataforma utilizada.
- [ ] Configura el servicio o presenta una alternativa reproducible.
- [ ] Verifica el funcionamiento con una prueba observable.
- [ ] Documenta una limitación o falla controlada.
- [ ] Aplica controles básicos de seguridad.
- [ ] Considera accesibilidad y diversidad de personas usuarias.
- [ ] Entrega evidencias claras y respuestas de análisis.

## Referencia oficial

Las prácticas se alinean con el programa oficial de **Administración de Redes (SCA-1002)**, Unidad 2: Servicios de Red, y con los subtemas DHCP, DNS, SSH, FTP/TFTP, HTTP/HTTPS, NFS, LDAP, SMTP/POP/IMAP/SASL y Proxy.
