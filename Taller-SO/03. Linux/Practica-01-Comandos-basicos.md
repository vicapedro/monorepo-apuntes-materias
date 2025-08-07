# Práctica 1: Comandos básicos de Linux

## Objetivo
Familiarizarse con los comandos básicos de Linux.

## Competencias:

- Conocer y utilizar los comandos básicos de Linux.
- Navegar por el sistema de archivos utilizando la terminal.
- Crear, copiar, mover y eliminar archivos y directorios.
- Consultar la documentación de los comandos mediante `man`.
- Desarrollar habilidades prácticas para la gestión de archivos y directorios en un entorno Linux.

## Introducción
El dominio de los comandos básicos de Linux es esencial para cualquier usuario que desee trabajar eficientemente en un entorno de línea de comandos. Estos comandos permiten realizar tareas fundamentales como navegar por el sistema de archivos, gestionar archivos y directorios, y consultar la documentación del sistema. A través de esta práctica, los estudiantes aprenderán a utilizar comandos esenciales que son la base para tareas más avanzadas en la administración y uso de sistemas Linux.

## Instrucciones
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

## Parte 1
1. Crea un directorio llamado `practica1`.
2. Navega dentro del directorio `practica1`.
3. Crea un archivo llamado `archivo1.txt`.
4. Copia `archivo1.txt` a `archivo2.txt`.
5. Muestra el contenido de `archivo2.txt` usando `cat`.
6. Elimina `archivo2.txt`.
7. Regresa al directorio anterior y elimina `practica1`.

## Parte 2
1. Crea un directorio llamado `M̀i carrera`
2. Dentro de el, crea un directorio llamado `base`.
3. Dentro del directorio base crea un archivo llamado `README.md`. Contenido:
   ```
   # Materia: <Materia>
   **Periodo:** <Periodo>
   **Docente**: <Docente>
   Contiene apuntes, proyectos y tareas de las materias que llevo en el período actual.
   ```
4. Dentro de `base`, crea tres subdirectorios llamados `apuntes`, `proyectos` y `tareas`.
5. Crea un archivo llamado `notas.txt` dentro del directorio `apuntes`.
6. En el directorio `Mi carrera`, crea un directorio llamado `Semestre <semestreactual>`.
7. Dentro, copia el directorio `base` (y su contenido) a un nuevo directorio con el nombre de una de las materias que llevas en el período actual. Modifica el contenido del archivo `README.md` para reflejar la materia correspondiente y sus datos.
8. Haz lo mismo para cada una de las otras materias que llevas en el período actual.
9. Muestra el contenido del directorio `Semestre <semestreactual>` para verificar que los directorios de las materias se han creado correctamente.
10. Muestra el tamaño total del directorio `Mi carrera` utilizando el comando `du -sh`.

## Notas
- Usa `man <comando>` para obtener más información sobre cada comando.
- Practica estos comandos hasta sentirte cómodo con ellos.
