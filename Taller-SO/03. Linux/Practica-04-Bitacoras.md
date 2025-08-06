# Práctica 4: Bitácora del sistema y servicios

## Objetivo
Familiarizarse con la bitácora del sistema y de los servicios.

## Competencias

- Conocer y utilizar los comandos para visualizar y analizar las bitácoras del sistema y de los servicios.
- Monitorear en tiempo real los registros de acceso y error de servicios específicos.
- Desarrollar habilidades prácticas para la gestión y resolución de problemas en un entorno Linux.

## Introducción
La bitácora del sistema y de los servicios es una herramienta esencial para la administración y el diagnóstico de sistemas Linux. Las bitácoras registran eventos importantes, errores y accesos, proporcionando información valiosa para la resolución de problemas y el mantenimiento del sistema. A través de esta práctica, los estudiantes aprenderán a utilizar `journalctl` y `tail` para visualizar y analizar las bitácoras del sistema y de servicios específicos, como `apache2`, mejorando su capacidad para gestionar y solucionar problemas en un entorno Linux.

## Instrucciones
1. Abre una terminal.
2. Ejecuta los siguientes comandos y observa los resultados:
    - `sudo journalctl`: Muestra la bitácora del sistema.
    - `sudo journalctl -u apache2`: Muestra la bitácora del servicio `apache2`.
    - `sudo tail -f /var/log/apache2/access.log`: Muestra en tiempo real el archivo de bitácora de accesos de `apache2`.
    - `sudo tail -f /var/log/apache2/error.log`: Muestra en tiempo real el archivo de bitácora de errores de `apache2`.

## Ejercicio
1. Inicia el servicio de `apache2` si no está iniciado: `sudo systemctl start apache2`.
2. Verifica el estado del servicio de `apache2` y observa la bitácora: `sudo journalctl -u apache2`.
3. Abre tu navegador y navega a la dirección IP de tu máquina para generar accesos.
4. Observa el archivo de bitácora de accesos en tiempo real: `sudo tail -f /var/log/apache2/access.log`.
5. Genera un error intencional (por ejemplo, accediendo a una página inexistente) y observa el archivo de bitácora de errores en tiempo real: `sudo tail -f /var/log/apache2/error.log`.
6. Detén el servicio de `apache2`: `sudo systemctl stop apache2`.
7. Verifica nuevamente la bitácora del servicio `apache2` para observar los registros de detención: `sudo journalctl -u apache2`.

## Notas
- Usa `man journalctl` para obtener más información sobre el comando `journalctl`.
- Practica estos comandos hasta sentirte cómodo con ellos.
