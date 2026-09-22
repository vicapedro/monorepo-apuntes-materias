# Práctica 2.5: Servicio web HTTP y HTTPS

## Objetivo
Publicar una página web sencilla, comprobar el acceso HTTP y documentar la función de HTTPS para proteger la comunicación.

**Duración estimada:** 1.5 horas

## Competencias a desarrollar
- Instala y configura un servicio web.
- Verifica disponibilidad y acceso desde diferentes clientes.
- Reconoce la importancia del cifrado y los certificados.

## Introducción
HTTP permite entregar contenido web y HTTPS agrega protección mediante TLS. El caso representa un centro comunitario que publica información en formatos accesibles para personas con distintas capacidades y dispositivos.

## Equipo de protección e higiene
- Publica únicamente contenido de prueba.
- No uses certificados ni claves privadas de producción.
- Mantén el servidor en una red aislada.
- No recolectes información personal mediante la página.

## Material y equipo necesario
- VM o servidor Debian/Ubuntu.
- Cliente web en Linux, Windows, teléfono o navegador de laboratorio.
- Apache o Nginx.
- OpenSSL para certificado local.
- VirtualBox, VMware, GNS3, PNetLab o laboratorio físico.

## Instrucciones
1. Instala Apache:
   ```bash
   sudo apt update
   sudo apt install -y apache2 openssl
   sudo systemctl enable --now apache2
   ```
2. Crea una página sencilla con título, texto alternativo en imágenes si las utilizas y contraste legible.
3. Comprueba el acceso HTTP:
   ```bash
   curl -I http://127.0.0.1
   ```
4. Genera un certificado autofirmado solo para el laboratorio, habilita SSL y redirige HTTP a HTTPS si el tiempo lo permite.
5. Verifica el certificado desde el navegador y con:
   ```bash
   curl -k -I https://127.0.0.1
   ```
6. Revisa los registros de acceso y error de Apache.
7. Explica qué se necesitaría para un certificado confiable en producción.

## Evidencias
- E1: servicio Apache activo.
- E2: página accesible por HTTP.
- E3: certificado local y acceso HTTPS.
- E4: evidencia de accesibilidad básica y revisión de logs.

## Preguntas de análisis
1. ¿Qué protege HTTPS y qué no protege?
2. ¿Por qué un certificado autofirmado produce una advertencia?
3. ¿Qué ajustes harías para personas con baja visión o conexión lenta?

## Evaluación
Lista de cotejo: instalación, página funcional, HTTPS, evidencias, accesibilidad y análisis.

## Notas
Si el entorno no permite instalar Apache, puede utilizarse un servidor web simple de Python o un nodo Linux en GNS3/PNetLab, siempre que se documente la diferencia.
