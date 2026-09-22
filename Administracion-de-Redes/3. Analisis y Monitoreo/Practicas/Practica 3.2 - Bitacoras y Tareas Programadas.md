# Práctica 3.2: Bitácoras y tareas programadas

## Objetivo
Configurar la generación, consulta y conservación básica de bitácoras de un servicio de red, y programar una tarea que produzca una alerta o un reporte periódico.

**Duración estimada:** 1.5 horas

## Competencia
Analiza y monitorea la red para medir su desempeño y fiabilidad con herramientas de software.

## Introducción
Las bitácoras permiten reconstruir qué ocurrió, cuándo ocurrió y qué componente participó. Una tarea programada puede revisar un servicio o generar un reporte sin depender de una revisión manual constante. El caso se plantea para un centro comunitario que necesita evidencias comprensibles y accesibles de sus servicios.

## Equipo de protección e higiene
- Usa solo servicios de laboratorio y datos ficticios.
- No borres logs del sistema ni alteres registros institucionales.
- Evita almacenar contraseñas o información personal en archivos de prueba.

## Material y equipo necesario
- Servidor Debian/Ubuntu en VirtualBox, VMware o equipo físico.
- Opcional: router o switch con Syslog en PNetLab, GNS3 o laboratorio físico.
- `rsyslog`, `journalctl`, `cron` o `systemd timers`.
- Un servicio sencillo como SSH, Apache o DHCP.

## Instrucciones
1. Instala y activa el servicio elegido, por ejemplo Apache o SSH.
2. Identifica sus registros y observa eventos normales:
   ```bash
   systemctl status apache2 --no-pager
   sudo journalctl -u apache2 --since today
   ```
3. Genera un evento controlado: acceso exitoso, acceso rechazado en el laboratorio o solicitud web.
4. Localiza el evento por fecha, servicio y severidad.
5. Crea un script sencillo que compruebe si el servicio está activo y escriba el resultado en un archivo de reporte.
6. Programa su ejecución cada cinco minutos con cron o un temporizador de systemd.
7. Verifica que el reporte se actualice y registra cómo se evitarían duplicados o archivos excesivamente grandes.
8. Como extensión, configura un dispositivo de red para enviar Syslog al servidor.

## Evidencias
- E1: servicio monitoreado y ubicación de sus logs.
- E2: evento controlado encontrado en la bitácora.
- E3: script o tarea programada.
- E4: reporte generado automáticamente.
- E5: propuesta de retención, permisos y privacidad.

## Preguntas de análisis
1. ¿Qué información mínima debe tener una bitácora para ser útil?
2. ¿Por qué la hora sincronizada es importante?
3. ¿Cómo facilitarías la lectura del reporte a una persona con discapacidad visual o baja visión?

## Evaluación
Lista de cotejo: evento registrado, consulta correcta, tarea funcional, permisos, retención y análisis.

## Notas
Si no se puede programar una tarea, se acepta ejecutarla manualmente y documentar el calendario que se implementaría. La práctica puede realizarse completamente en una VM o con logs de un dispositivo simulado.
