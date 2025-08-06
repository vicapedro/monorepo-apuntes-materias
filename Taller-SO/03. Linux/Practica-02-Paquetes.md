# Práctica 2: Instalación y actualización de paquetes 

## Objetivo
Familiarizarse con la instalación y actualización de paquetes.

## Competencias:

- Conocer y utilizar los comandos para gestionar paquetes en Linux.
- Instalar, actualizar y eliminar paquetes utilizando el gestor de paquetes `apt`.
- Mantener el sistema actualizado y limpio de paquetes innecesarios.
- Desarrollar habilidades prácticas para la gestión de software en un entorno Linux.

## Introducción
La gestión de paquetes es una tarea fundamental en la administración de sistemas Linux. Los paquetes son colecciones de archivos que contienen software y sus dependencias, y el gestor de paquetes `apt` facilita la instalación, actualización y eliminación de estos paquetes. A través de esta práctica, los estudiantes aprenderán a utilizar `apt` para mantener su sistema actualizado, instalar nuevas aplicaciones y eliminar software innecesario, asegurando así un entorno de trabajo eficiente y seguro.

## Instrucciones
1. Abre una terminal.
2. Ejecuta los siguientes comandos y observa los resultados:
    - `sudo apt update`: Actualiza la lista de paquetes disponibles.
    - `sudo apt upgrade`: Actualiza los paquetes instalados a sus últimas versiones.
    - `sudo apt install <paquete>`: Instala un nuevo paquete.
    - `sudo apt remove <paquete>`: Elimina un paquete instalado.
    - `sudo apt autoremove`: Elimina los paquetes que ya no son necesarios.

## Ejercicio
1. Actualiza la lista de paquetes disponibles.
2. Instala el paquete `htop`.
3. Ejecuta `htop` para verificar su instalación.
4. Elimina el paquete `htop`.
5. Ejecuta `sudo apt autoremove` para limpiar los paquetes innecesarios.

## Notas
- Usa `man apt` para obtener más información sobre el comando `apt`.
- Practica estos comandos hasta sentirte cómodo con ellos.
