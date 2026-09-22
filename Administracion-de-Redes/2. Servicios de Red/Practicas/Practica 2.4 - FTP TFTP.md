# Práctica 2.4: Transferencia de archivos con FTP y TFTP

## Objetivo
Comparar FTP y TFTP mediante la transferencia controlada de un archivo de laboratorio, identificando sus diferencias de autenticación, seguridad y uso administrativo.

**Duración estimada:** 1.5 horas

## Competencias a desarrollar
- Configura un servicio de transferencia de archivos.
- Distingue usos apropiados y riesgos de FTP y TFTP.
- Documenta permisos, usuarios y resultados de una transferencia.

## Introducción
FTP permite transferir archivos mediante cuentas y permisos; TFTP es más simple y suele utilizarse para imágenes o respaldos de dispositivos en redes controladas. El caso representa una organización que comparte materiales digitales y necesita evitar la exposición de información sensible.

## Equipo de protección e higiene
- Utiliza archivos de prueba sin datos personales.
- No habilites FTP anónimo fuera de la red aislada.
- No almacenes contraseñas reales en el reporte.
- Elige SFTP o SCP para una propuesta de producción.

## Material y equipo necesario
- Servidor Debian/Ubuntu o equipo físico.
- Cliente Linux/Windows o router en PNetLab/GNS3.
- `vsftpd`, `tftpd-hpa`, `ftp`, `tftp` y `scp` opcional.

## Instrucciones
1. Instala el servicio elegido; de forma opcional, compara ambos:
   ```bash
   sudo apt update
   sudo apt install -y vsftpd tftpd-hpa ftp tftp
   ```
2. Crea `/srv/transferencia` y un archivo de prueba que no contenga datos reales.
3. Configura FTP con una cuenta local sin permitir escritura fuera del directorio asignado.
4. Configura TFTP con un directorio específico y permisos mínimos.
5. Transfiere el archivo desde el cliente y verifica su existencia:
   ```bash
   ls -l /srv/transferencia
   sha256sum archivo-prueba.txt
   ```
6. Cambia un permiso de forma controlada y documenta si la transferencia se permite o se rechaza.
7. Compara FTP/TFTP con SFTP o SCP y formula una recomendación para producción.

## Evidencias
- E1: configuración del directorio y permisos.
- E2: transferencia FTP o TFTP exitosa.
- E3: verificación de integridad con hash.
- E4: tabla comparativa y recomendación de seguridad.

## Preguntas de análisis
1. ¿Por qué TFTP no es adecuado para transferir información confidencial?
2. ¿Qué control evita que una cuenta escriba en cualquier ubicación?
3. ¿Cómo ofrecerías una alternativa de transferencia para una persona con conectividad limitada?

## Evaluación
Lista de cotejo: servicio funcional, transferencia, permisos, integridad, comparación y recomendación.

## Notas
Si no se puede instalar el servicio, el equipo puede simular el flujo con un router en GNS3/PNetLab y documentar los comandos de respaldo sin utilizar configuraciones reales.
