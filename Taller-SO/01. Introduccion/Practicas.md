# Prácticas de virtualización
## Práctica 1: Creación de una máquina virtual
### Objetivo: Familiarizarse con la creación de máquinas virtuales
### Competencias:

- Comprender los conceptos básicos de virtualización.
- Configurar y gestionar máquinas virtuales utilizando VirtualBox.
- 
- Configurar diferentes opciones de red y entender sus implicaciones.
- Instalar y configurar servicios en máquinas virtuales y probar su conectividad.


### Requisitos:
- VirtualBox instalado en tu sistema
- Archivo ISO de Windows 10 descargado de la página oficial de Microsoft.

### Introucción:

La virtualización es una tecnología que permite crear versiones virtuales de recursos físicos, como servidores, sistemas operativos y dispositivos de almacenamiento. En el contexto de la creación de máquinas virtuales, esta práctica se enfoca en utilizar VirtualBox, una herramienta de virtualización de código abierto, para crear y gestionar máquinas virtuales. A través de esta práctica, los estudiantes aprenderán a configurar y operar máquinas virtuales, lo que les permitirá experimentar con diferentes sistemas operativos y configuraciones sin necesidad de hardware adicional.
### Pasos:

1. **Abrir VirtualBox**:
    - Inicia VirtualBox desde tu menú de aplicaciones.

2. **Crear una nueva máquina virtual**:
    - Haz clic en el botón "Nueva" para crear una nueva máquina virtual.
    - Asigna un nombre a la máquina virtual y selecciona el tipo y versión del sistema operativo (Windows).

3. **Configurar la memoria**:
    - Asigna la cantidad de memoria RAM que deseas dedicar a la máquina virtual. VirtualBox sugiere las especificaciones recomendadas para el Sistema Operativo y versión seleccionadas.

4. **Crear un disco duro virtual**:
    - Selecciona "Crear un disco duro virtual ahora" y haz clic en "Crear".
    - Elige el tipo de archivo de disco duro (VDI es una buena opción).
    - Decide si deseas un disco de tamaño fijo o dinámico (dinámico es más flexible).
    - Asigna el tamaño del disco duro virtual (al menos 20 GB es recomendable).

5. **Configurar el almacenamiento**:
    - Selecciona la máquina virtual recién creada y haz clic en "Configuración".
    - Ve a la sección "Almacenamiento" y selecciona el controlador IDE vacío.
    - Haz clic en el icono del disco y selecciona "Elegir un archivo de disco óptico virtual".
    - Navega hasta el archivo ISO de la distribución de Linux y selecciónalo.

6. **Iniciar la máquina virtual**:
    - Haz clic en "Iniciar" para arrancar la máquina virtual.
    - Sigue las instrucciones en pantalla para instalar el sistema operativo desde el archivo ISO.

7. **Finalizar la instalación**:
    - Una vez completada la instalación, reinicia la máquina virtual.
    - Retira el archivo ISO del almacenamiento óptico virtual para evitar reiniciar la instalación.

### Conclusión:
Al finalizar esta práctica, habrás creado y configurado una máquina virtual utilizando VirtualBox, y habrás instalado un sistema operativo Windows en ella.


## Práctica 2: Gestión de Snapshots
### Objetivo: Familiarizarse con el uso y gestión de snapshots. Comprender las ventajas de su utilización


### Comnpetencias
    Crear y gestionar snapshots para mantener estados específicos de las máquinas virtuales.

### Requisitos:
- VirtualBox instalado en tu sistema
- Máquina virtual con Windows instalada

### Introducción

La gestión de snapshots es una funcionalidad esencial en la virtualización que permite capturar el estado exacto de una máquina virtual en un momento específico. Los snapshots son útiles para realizar pruebas, actualizaciones y cambios en el sistema sin riesgo, ya que permiten revertir la máquina virtual a un estado anterior en caso de errores o problemas. En esta práctica, se utilizará VirtualBox para crear, gestionar y eliminar snapshots, proporcionando a los estudiantes una herramienta poderosa para mantener y recuperar estados específicos de sus máquinas virtuales de manera eficiente.

### Pasos:

1. **Crear un snapshot inicial**:
    - Abre VirtualBox y selecciona la máquina virtual con Windows.
    - Haz clic en el botón "Snapshots" en la parte superior derecha.
    - Haz clic en el icono de la cámara para tomar un snapshot y así guardar el estado actual de la máquina virtual. Asigna un nombre descriptivo al snapshot (por ejemplo, "Estado inicial").

2. **Crear un archivo y tomar un snapshot**:
    - Inicia la máquina virtual con Windows.
    - Crea un archivo de texto en el escritorio de Windows (por ejemplo, "archivo_prueba.txt").
    - Vuelve a VirtualBox y toma un nuevo snapshot, nombrándolo (por ejemplo, "Archivo creado").

3. **Instalar una aplicación sencilla**:
    - Dentro de la máquina virtual, descarga e instala una aplicación sencilla (por ejemplo, Notepad++).
    - Una vez instalada, vuelve a VirtualBox y toma otro snapshot, nombrándolo (por ejemplo, "Aplicación instalada").

4. **Revertir a un snapshot anterior**:
    - En VirtualBox, selecciona el snapshot "Archivo creado" y haz clic en "Restaurar".
    - La máquina virtual volverá al estado en el que solo el archivo de texto estaba presente, sin la aplicación instalada.

5. **Eliminar un snapshot**:
    - Para eliminar un snapshot, selecciona el snapshot que deseas eliminar y haz clic en el icono de la papelera.
    - Confirma la eliminación del snapshot.

### Conclusión:
Al finalizar esta práctica, habrás aprendido a crear, gestionar y eliminar snapshots en VirtualBox. Esto te permitirá guardar y restaurar estados específicos de tu máquina virtual, facilitando la gestión y recuperación de entornos de trabajo.

## Práctica 3: Configuración de Red
### Objetivo: Familiarizarse con diferentes opciones de conexión de red.

### Competencias:

Configurar diferentes opciones de red y entender sus implicaciones.

### Requisitos:
- VirtualBox instalado en tu sistema
- Máquina virtual con Windows instalada

### Introduccion
La configuración de red en máquinas virtuales es un aspecto crucial de la virtualización, ya que determina cómo las máquinas virtuales se comunican entre sí y con otros dispositivos en la red. En esta práctica, se explorarán diferentes opciones de conexión de red en VirtualBox, como NAT, Bridge y Host-only. Cada configuración tiene sus propias características y usos específicos, permitiendo a los estudiantes comprender las implicaciones de cada opción y cómo afectan la conectividad de las máquinas virtuales. A través de esta práctica, los estudiantes aprenderán a configurar y probar estas opciones de red, mejorando su capacidad para gestionar entornos virtualizados de manera efectiva.

### Pasos:

1. **Configurar red en modo NAT**:
    - Abre VirtualBox y selecciona la máquina virtual con Windows.
    - Haz clic en "Configuración" y luego en "Red".
    - En "Conectado a:", selecciona "NAT".
    - Inicia la máquina virtual y verifica la conexión a Internet abriendo un navegador web.

2. **Configurar red en modo Bridge**:
    - Con la máquina virtual apagada, vuelve a la configuración de red.
    - En "Conectado a:", selecciona "Adaptador puente".
    - Elige el adaptador de red físico de tu sistema host.
    - Inicia la máquina virtual y verifica la conexión a Internet. La máquina virtual debería obtener una dirección IP de la misma red que tu sistema host.

3. **Configurar red en modo Host-only**:
    - En VirtualBox, ve a "Archivo" > "Preferencias" > "Red" y añade un nuevo adaptador Host-only.
    - Vuelve a la configuración de red de la máquina virtual.
    - En "Conectado a:", selecciona "Adaptador solo-anfitrión".
    - Selecciona el adaptador Host-only que creaste.
    - Inicia la máquina virtual y verifica la conexión. La máquina virtual solo podrá comunicarse con el host y otras máquinas virtuales en la red Host-only.

### Conclusión:
Al finalizar esta práctica, habrás configurado y probado las diferentes opciones de conexión de red en VirtualBox: NAT, Bridge y Host-only. Esto te permitirá comprender cómo cada configuración afecta la conectividad de tu máquina virtual.

## Práctica 4: Comunicación al interior
### Objetivo: Conocer la diferencia entre los modos de conexión de red al instalar y configurar SQL Server

### Requisitos:
- VirtualBox instalado en tu sistema
- Máquina virtual con Windows instalada
- Instalador de SQL Server descargado

### Introducción

La comunicación al interior de una red virtual es fundamental para la configuración y gestión de servicios en máquinas virtuales. En esta práctica, se explorará cómo configurar y probar diferentes modos de conexión de red en VirtualBox al instalar y configurar SQL Server. Los modos de red como Bridge y NAT tienen implicaciones distintas en la conectividad y accesibilidad de los servicios. A través de esta práctica, los estudiantes aprenderán a configurar estos modos de red y a entender cómo afectan la comunicación entre el sistema host y las máquinas virtuales, mejorando su capacidad para gestionar entornos virtualizados de manera efectiva.

### Pasos:

1. **Instalar SQL Server**:
    - Inicia la máquina virtual con Windows.
    - Descarga e instala SQL Server en la máquina virtual siguiendo las instrucciones del instalador.

2. **Configurar red en modo Bridge**:
    - Apaga la máquina virtual.
    - Abre VirtualBox y selecciona la máquina virtual con Windows.
    - Haz clic en "Configuración" y luego en "Red".
    - En "Conectado a:", selecciona "Adaptador puente".
    - Elige el adaptador de red físico de tu sistema host.
    - Inicia la máquina virtual y verifica la conexión a Internet.
    - Anota la dirección IP asignada a la máquina virtual.

3. **Probar conexión a SQL Server en modo Bridge**:
    - Desde el sistema host, intenta conectarte al SQL Server usando la dirección IP de la máquina virtual.
    - Verifica que puedes establecer una conexión exitosa.

4. **Configurar red en modo NAT**:
    - Apaga la máquina virtual.
    - Vuelve a la configuración de red de la máquina virtual.
    - En "Conectado a:", selecciona "NAT".
    - Inicia la máquina virtual y verifica la conexión a Internet.
    - Anota la dirección IP asignada a la máquina virtual.

5. **Probar conexión a SQL Server en modo NAT sin reenvío de puertos**:
    - Desde el sistema host, intenta conectarte al SQL Server usando la dirección IP de la máquina virtual.
    - Verifica que la conexión fallará debido a la falta de reenvío de puertos.

6. **Configurar red en modo NAT con reenvío de puertos**:
    - Apaga la máquina virtual.
    - Vuelve a la configuración de red de la máquina virtual.
    - En "Conectado a:", selecciona "NAT".
    - Haz clic en "Avanzado" y luego en "Reenvío de puertos".
    - Añade una nueva regla de reenvío de puertos:
        - Nombre: SQLServer
        - Protocolo: TCP
        - Puerto host: 1433
        - Dirección IP invitado: (la dirección IP de la máquina virtual en modo NAT)
        - Puerto invitado: 1433
    - Inicia la máquina virtual y verifica la conexión a Internet.

7. **Probar conexión a SQL Server en modo NAT con reenvío de puertos**:
    - Desde el sistema host, intenta conectarte al SQL Server usando `localhost` y el puerto configurado (1433).
    - Verifica que puedes establecer una conexión exitosa.

### Conclusión:

Al finalizar esta práctica, habrás instalado y configurado SQL Server en una máquina virtual y habrás alternado entre los modos de red Bridge y NAT con reenvío de puertos. Notarás que el modo NAT no permite conexiones entrantes por defecto y requiere configuración adicional para permitir el acceso a servicios como SQL Server.


## Practica 5: Snapshots y desempeño
### Objetivo: Comprender el impacto de los snapshots en el desempeño de las máquinas virtuales.
### Requisitos:
- VirtualBox instalado en tu sistema
- Máquina virtual con Windows instalada
### Introducción
Los snapshots son una herramienta poderosa en la virtualización que permite capturar el estado de una máquina virtual en un momento específico. Sin embargo, el uso excesivo o inadecuado de snapshots puede afectar el desempeño de las máquinas virtuales. En esta práctica, se explorará cómo los snapshots impactan el rendimiento y la gestión de recursos en VirtualBox. Los estudiantes aprenderán a crear, gestionar y eliminar snapshots, así como a evaluar su efecto en el desempeño general de las máquinas virtuales.

### Pasos:
1. **Medir el desempeño inicial**:
    - Inicia la máquina virtual con Windows.
    - Abre el Administrador de tareas y anota el uso de CPU, memoria y disco.
    - Realiza algunas tareas básicas (por ejemplo, abrir aplicaciones, navegar por Internet) y anota nuevamente el uso de recursos.
    - Apaga la máquina virtual.
2. **Crear un snapshot inicial**:
    - Abre VirtualBox y selecciona la máquina virtual con Windows.
    - Haz clic en el botón "Snapshots" en la parte superior derecha.
    - Haz clic en el icono de la cámara para tomar un snapshot y así guardar el estado actual de la máquina virtual. Asigna un nombre descriptivo al snapshot (por ejemplo, "Estado inicial").
    - Inicia la máquina virtual y realiza algunas tareas básicas (por ejemplo, abrir aplicaciones, navegar por Internet).
    - Verifica el uso de recursos nuevamente en el Administrador de tareas y anota los valores.
3. **Crear múltiples snapshots**:
    - Realiza algunas tareas adicionales en la máquina virtual (por ejemplo, instalar una aplicación).
    - Toma un nuevo snapshot y nómbralo (por ejemplo, "Aplicación instalada").
    - Repite este proceso varias veces, creando al menos 3-4 snapshots en diferentes momentos.
    - En cada paso, verifica el uso de recursos en el Administrador de tareas y anota los valores.
4. **Evaluar el impacto de los snapshots**:
    - Después de crear varios snapshots, apaga la máquina virtual.
    - Inicia la máquina virtual y verifica el uso de recursos en el Administrador de tareas.
    - Compara el uso de recursos antes y después de crear los snapshots.
5. **Eliminar snapshots**:
    - En VirtualBox, selecciona uno de los snapshots que has creado y haz clic en el icono de la papelera para eliminarlo.
    - Confirma la eliminación del snapshot.
    - Repite este proceso para eliminar todos los snapshots que has creado.
6. **Medir el desempeño final**:
    - Inicia la máquina virtual y verifica el uso de recursos en el Administrador de tareas.
    - Compara el uso de recursos final con el uso inicial antes de crear los snapshots. 
7. **Medición con herramientas de estres**:
    - Repite los pasos 1 al 6 pero esta vez utilizando las herramienta de estrés `fio`, `sysbench` y `stress-ng` para medir el desempeño bajo carga, teniendo un snapshot y luego varios snapshots.
    - Compara los resultados obtenidos con y sin snapshots, analizando el impacto en el rendimiento de la máquina virtual.
### Resultados esperados:
- Comprender cómo los snapshots afectan el rendimiento de las máquinas virtuales.
- Evaluar el uso de recursos antes y después de crear snapshots.
- Aprender a gestionar snapshots de manera efectiva para minimizar el impacto en el desempeño.
