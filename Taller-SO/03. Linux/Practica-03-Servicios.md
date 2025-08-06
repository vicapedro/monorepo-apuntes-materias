# Práctica 3: Administración de servicios

## Objetivo
Familiarizarse con la administración de servicios utilizando `systemctl`.

## Competencias

- Conocer y utilizar los comandos para gestionar servicios en Linux.
- Iniciar, detener, reiniciar y verificar el estado de servicios utilizando `systemctl`.
- Habilitar y deshabilitar servicios para que se inicien automáticamente al arrancar el sistema.
- Desarrollar habilidades prácticas para la administración de servicios en un entorno Linux.

## Introducción
La administración de servicios es una tarea crucial en la gestión de sistemas Linux. Los servicios son programas que se ejecutan en segundo plano y proporcionan diversas funcionalidades, como servidores web, bases de datos y más. El comando `systemctl` es una herramienta poderosa que permite a los administradores de sistemas gestionar estos servicios de manera eficiente. A través de esta práctica, los estudiantes aprenderán a utilizar `systemctl` para controlar servicios, asegurando que los sistemas funcionen de manera óptima y segura.

## Instrucciones
1. Abre una terminal.
2. Ejecuta los siguientes comandos y observa los resultados:
    - `sudo systemctl start apache2`: Inicia el servicio de `apache2`.
    - `sudo systemctl stop apache2`: Detiene el servicio de `apache2`.
    - `sudo systemctl restart apache2`: Reinicia el servicio de `apache2`.
    - `sudo systemctl status apache2`: Muestra el estado del servicio de `apache2`.
    - `sudo systemctl enable apache2`: Habilita el servicio de `apache2` para que inicie automáticamente al arrancar el sistema.
    - `sudo systemctl disable apache2`: Deshabilita el servicio de `apache2` para que no inicie automáticamente al arrancar el sistema.

## Ejercicio
1. Instala el paquete `apache2` si no está instalado: `sudo apt install apache2`.
2. Inicia el servicio de `apache2`.
3. Verifica el estado del servicio de `apache2`.
4. Utilizando tu navegador navega a la dirección ip de tu maquina y verifica que se carga la pagina default de apache
5. Detén el servicio de `apache2`.
6. Verifica que al refrescar la pagina del navegador, no se carga la pagina 
7. Reinicia el servicio de `apache2`.
8. Verifica que al refrescar la página nuevamente se muestra el sitio web
9. Habilita el servicio de `apache2` para que inicie automáticamente al arrancar el sistema.
10. Deshabilita el servicio de `apache2`.

## Notas
- Usa `man systemctl` para obtener más información sobre el comando `systemctl`.
- Practica estos comandos hasta sentirte cómodo con ellos.
