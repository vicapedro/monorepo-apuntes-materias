# Linux - Prácticas 

## Practica 1: Comandos básicos de Linux

### Objetivo
Familiarizarse con los comandos básicos de Linux.

### Competencias:

- Conocer y utilizar los comandos básicos de Linux.
- Navegar por el sistema de archivos utilizando la terminal.
- Crear, copiar, mover y eliminar archivos y directorios.
- Consultar la documentación de los comandos mediante `man`.
- Desarrollar habilidades prácticas para la gestión de archivos y directorios en un entorno Linux.

### Introducción
El dominio de los comandos básicos de Linux es esencial para cualquier usuario que desee trabajar eficientemente en un entorno de línea de comandos. Estos comandos permiten realizar tareas fundamentales como navegar por el sistema de archivos, gestionar archivos y directorios, y consultar la documentación del sistema. A través de esta práctica, los estudiantes aprenderán a utilizar comandos esenciales que son la base para tareas más avanzadas en la administración y uso de sistemas Linux.

### Instrucciones
1. Abre una terminal.
2. Ejecuta los siguientes comandos y observa los resultados:
    - `pwd`: Muestra el directorio actual.
    - `ls`: Lista los archivos y directorios en el directorio actual.
    - `cd`: Cambia de directorio.
    - `mkdir`: Crea un nuevo directorio.
    - `rmdir`: Elimina un directorio vacío.
    - `touch`: Crea un archivo vacío.
    - `rm`: Elimina un archivo.
    - `cp`: Copia archivos o directorios.
    - `mv`: Mueve o renombra archivos o directorios.
    - `cat`: Muestra el contenido de un archivo.

### Ejercicio
1. Crea un directorio llamado `practica1`.
2. Navega dentro del directorio `practica1`.
3. Crea un archivo llamado `archivo1.txt`.
4. Copia `archivo1.txt` a `archivo2.txt`.
5. Muestra el contenido de `archivo2.txt` usando `cat`.
6. Elimina `archivo2.txt`.
7. Regresa al directorio anterior y elimina `practica1`.

### Notas
- Usa `man <comando>` para obtener más información sobre cada comando.
- Practica estos comandos hasta sentirte cómodo con ellos. 

## Practica 2: Instalación y actualización de paquetes 

### Objetivo
Familiarizarse con la instalación y actualización de paquetes.

### Competencias:

- Conocer y utilizar los comandos para gestionar paquetes en Linux.
- Instalar, actualizar y eliminar paquetes utilizando el gestor de paquetes `apt`.
- Mantener el sistema actualizado y limpio de paquetes innecesarios.
- Desarrollar habilidades prácticas para la gestión de software en un entorno Linux.

### Introducción
La gestión de paquetes es una tarea fundamental en la administración de sistemas Linux. Los paquetes son colecciones de archivos que contienen software y sus dependencias, y el gestor de paquetes `apt` facilita la instalación, actualización y eliminación de estos paquetes. A través de esta práctica, los estudiantes aprenderán a utilizar `apt` para mantener su sistema actualizado, instalar nuevas aplicaciones y eliminar software innecesario, asegurando así un entorno de trabajo eficiente y seguro.

### Instrucciones
1. Abre una terminal.
2. Ejecuta los siguientes comandos y observa los resultados:
    - `sudo apt update`: Actualiza la lista de paquetes disponibles.
    - `sudo apt upgrade`: Actualiza los paquetes instalados a sus últimas versiones.
    - `sudo apt install <paquete>`: Instala un nuevo paquete.
    - `sudo apt remove <paquete>`: Elimina un paquete instalado.
    - `sudo apt autoremove`: Elimina los paquetes que ya no son necesarios.

### Ejercicio
1. Actualiza la lista de paquetes disponibles.
2. Instala el paquete `htop`.
3. Ejecuta `htop` para verificar su instalación.
4. Elimina el paquete `htop`.
5. Ejecuta `sudo apt autoremove` para limpiar los paquetes innecesarios.

### Notas
- Usa `man apt` para obtener más información sobre el comando `apt`.
- Practica estos comandos hasta sentirte cómodo con ellos.

## Practica 3: Administración de servicios

### Objetivo
Familiarizarse con la administración de servicios utilizando `systemctl`.

### Competencias

- Conocer y utilizar los comandos para gestionar servicios en Linux.
- Iniciar, detener, reiniciar y verificar el estado de servicios utilizando `systemctl`.
- Habilitar y deshabilitar servicios para que se inicien automáticamente al arrancar el sistema.
- Desarrollar habilidades prácticas para la administración de servicios en un entorno Linux.

### Introducción
La administración de servicios es una tarea crucial en la gestión de sistemas Linux. Los servicios son programas que se ejecutan en segundo plano y proporcionan diversas funcionalidades, como servidores web, bases de datos y más. El comando `systemctl` es una herramienta poderosa que permite a los administradores de sistemas gestionar estos servicios de manera eficiente. A través de esta práctica, los estudiantes aprenderán a utilizar `systemctl` para controlar servicios, asegurando que los sistemas funcionen de manera óptima y segura.

### Instrucciones
1. Abre una terminal.
2. Ejecuta los siguientes comandos y observa los resultados:
    - `sudo systemctl start apache2`: Inicia el servicio de `apache2`.
    - `sudo systemctl stop apache2`: Detiene el servicio de `apache2`.
    - `sudo systemctl restart apache2`: Reinicia el servicio de `apache2`.
    - `sudo systemctl status apache2`: Muestra el estado del servicio de `apache2`.
    - `sudo systemctl enable apache2`: Habilita el servicio de `apache2` para que inicie automáticamente al arrancar el sistema.
    - `sudo systemctl disable apache2`: Deshabilita el servicio de `apache2` para que no inicie automáticamente al arrancar el sistema.

### Ejercicio
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

### Notas
- Usa `man systemctl` para obtener más información sobre el comando `systemctl`.
- Practica estos comandos hasta sentirte cómodo con ellos.

## Practica 4: Bitácora del sistema y servicios

### Objetivo
Familiarizarse con la bitácora del sistema y de los servicios.

### Competencias

- Conocer y utilizar los comandos para visualizar y analizar las bitácoras del sistema y de los servicios.
- Monitorear en tiempo real los registros de acceso y error de servicios específicos.
- Desarrollar habilidades prácticas para la gestión y resolución de problemas en un entorno Linux.

### Introducción
La bitácora del sistema y de los servicios es una herramienta esencial para la administración y el diagnóstico de sistemas Linux. Las bitácoras registran eventos importantes, errores y accesos, proporcionando información valiosa para la resolución de problemas y el mantenimiento del sistema. A través de esta práctica, los estudiantes aprenderán a utilizar `journalctl` y `tail` para visualizar y analizar las bitácoras del sistema y de servicios específicos, como `apache2`, mejorando su capacidad para gestionar y solucionar problemas en un entorno Linux.

### Instrucciones
1. Abre una terminal.
2. Ejecuta los siguientes comandos y observa los resultados:
    - `sudo journalctl`: Muestra la bitácora del sistema.
    - `sudo journalctl -u apache2`: Muestra la bitácora del servicio `apache2`.
    - `sudo tail -f /var/log/apache2/access.log`: Muestra en tiempo real el archivo de bitácora de accesos de `apache2`.
    - `sudo tail -f /var/log/apache2/error.log`: Muestra en tiempo real el archivo de bitácora de errores de `apache2`.

### Ejercicio
1. Inicia el servicio de `apache2` si no está iniciado: `sudo systemctl start apache2`.
2. Verifica el estado del servicio de `apache2` y observa la bitácora: `sudo journalctl -u apache2`.
3. Abre tu navegador y navega a la dirección IP de tu máquina para generar accesos.
4. Observa el archivo de bitácora de accesos en tiempo real: `sudo tail -f /var/log/apache2/access.log`.
5. Genera un error intencional (por ejemplo, accediendo a una página inexistente) y observa el archivo de bitácora de errores en tiempo real: `sudo tail -f /var/log/apache2/error.log`.
6. Detén el servicio de `apache2`: `sudo systemctl stop apache2`.
7. Verifica nuevamente la bitácora del servicio `apache2` para observar los registros de detención: `sudo journalctl -u apache2`.

### Notas
- Usa `man journalctl` para obtener más información sobre el comando `journalctl`.
- Practica estos comandos hasta sentirte cómodo con ellos.

