# Práctica 2.8: Servicio de correo SMTP e IMAP/POP

## Objetivo
Reconocer el flujo básico de correo electrónico y realizar una prueba controlada de envío y recepción en un servidor de laboratorio.

**Duración estimada:** 1.5 horas

## Competencias a desarrollar
- Identifica los componentes de un servicio de correo.
- Diferencia envío SMTP de consulta IMAP o POP.
- Analiza controles de autenticación, privacidad y disponibilidad.

## Introducción
SMTP se utiliza principalmente para enviar mensajes, mientras que IMAP y POP permiten consultarlos. El caso representa una organización comunitaria que necesita comunicación interna y debe considerar accesibilidad, privacidad y prevención del uso no autorizado.

## Equipo de protección e higiene
- No envíes mensajes a Internet desde el laboratorio.
- Usa cuentas ficticias y contenido de prueba.
- Desactiva el relay abierto.
- No incluyas mensajes reales en las evidencias.

## Material y equipo necesario
- VM Debian/Ubuntu o servidor físico.
- Cliente de correo o comandos `mail`, `swaks` o `telnet` en red aislada.
- Postfix y, si se desea, Dovecot para IMAP/POP.
- VirtualBox, VMware, GNS3, PNetLab o laboratorio físico.

## Instrucciones
1. Instala Postfix y selecciona configuración de sitio de Internet o sistema local según la guía docente.
2. Crea dos cuentas ficticias para el laboratorio.
3. Verifica que el servicio SMTP esté activo y revisa su configuración para evitar relay abierto.
4. Envía un mensaje local de prueba y revisa los registros:
   ```bash
   sudo systemctl status postfix --no-pager
   sudo journalctl -u postfix --since today
   ```
5. Si se instala Dovecot, configura una cuenta para consultar el buzón mediante IMAP o POP desde un cliente.
6. Comprueba que un usuario no autorizado no pueda enviar mensajes utilizando la identidad de otra persona.
7. Elabora un flujo sencillo: remitente, SMTP, buzón, IMAP/POP y destinatario.

## Evidencias
- E1: diagrama del flujo de correo.
- E2: servicio activo y cuentas ficticias.
- E3: mensaje local de prueba y registro asociado.
- E4: comparación SMTP, IMAP y POP con controles de seguridad.

## Preguntas de análisis
1. ¿Por qué un servidor SMTP no debe funcionar como relay abierto?
2. ¿Qué diferencia existe entre descargar mensajes con POP y sincronizarlos con IMAP?
3. ¿Qué alternativas inclusivas ofrecerías a personas con conexión intermitente o lector de pantalla?

## Evaluación
Lista de cotejo: flujo, servicio, prueba local, registros, seguridad y análisis.

## Notas
Si no se puede configurar un servidor completo, puede realizarse una simulación de flujo con registros preparados y una demostración local. No se requiere integrar un proveedor externo.
