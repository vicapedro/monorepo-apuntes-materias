# Crear una red Windows con máquinas virtuales
## Práctica 1: Instalación de Windows Server 2022

### Objetivo: 
Instalar los pre requisitos para implementar una red Corporativa utilizando Windows Server

### Competencias
Comprender los conceptos básicos de la instalación y configuración de sistemas operativos en entornos virtualizados

### Introducción
La instalación de Windows Server 2022 es un paso fundamental para implementar una red corporativa utilizando este sistema operativo. En esta práctica, los estudiantes aprenderán a descargar e instalar Windows Server 2022 en un entorno virtualizado utilizando VirtualBox. La práctica incluye la configuración inicial del sistema operativo, la asignación de recursos y la configuración de red, proporcionando una base sólida para las siguientes prácticas que se centrarán en la configuración y gestión de servicios de red. A través de esta práctica, los estudiantes desarrollarán competencias esenciales en la instalación y configuración de sistemas operativos en entornos virtualizados.


### Instrucciones:

1. **Descargar Windows Server 2022**:
    - Accede a [Azure for Education](https://azureforeducation.microsoft.com/).
    - Inicia sesión con tu cuenta educativa.
    - Busca y descarga la imagen ISO de Windows Server 2022.
    - Obtén un número de serie de prueba para la instalación.

2. **Instalar VirtualBox**:
    - Descarga e instala [VirtualBox](https://www.virtualbox.org/).

3. **Crear una nueva máquina virtual en VirtualBox**:
    - Abre VirtualBox y haz clic en "Nueva".
    - Asigna un nombre a la máquina virtual, por ejemplo, "Windows Server 2022".
    - Selecciona "Microsoft Windows" como tipo y "Windows 2022 (64-bit)" como versión.
    - Asigna al menos 4 GB de RAM.
    - Crea un disco duro virtual de al menos 50 GB.

4. **Configurar la máquina virtual**:
    - Selecciona la máquina virtual creada y haz clic en "Configuración".
    - En la sección "Almacenamiento", selecciona el controlador vacío y carga la imagen ISO de Windows Server 2022 descargada.
    - En la sección "Red", asegúrate de que la máquina virtual esté configurada para usar el adaptador en modo puente para tener acceso a la red.

5. **Instalar Windows Server 2022**:
    - Inicia la máquina virtual.
    - Sigue las instrucciones en pantalla para instalar Windows Server 2022 con la Experiencia de Escritorio
    - Introduce el número de serie de prueba cuando se te solicite.
    - Completa la instalación configurando los ajustes básicos como el nombre del servidor y la contraseña del administrador.

6. **Finalizar la instalación**:
    - Una vez completada la instalación, asegúrate de que el servidor esté actualizado instalando las últimas actualizaciones de Windows.
    - Configura la red y verifica la conectividad.

### Resultado esperado:
El alumno debe tener una máquina virtual con Windows Server 2022 instalada y configurada, lista para ser utilizada en las siguientes prácticas.

-+-+-+-+-

## Práctica 2: Instalación de los servicios de DHCP

### Objetivo: 
Instalar el servicio de DHCP como pre requisito para implementar una red Corporativa utilizando Windows Server

### Competencias

- Desarrollar habilidades prácticas en la configuración y gestión de servicios de DHCP en Windows Server.
- Aprender a solucionar problemas comunes relacionados con la configuración de red y servicios de DHCP.
- Adquirir experiencia en la administración de redes corporativas utilizando Windows Server.

### Introducción
La instalación y configuración del servicio de DHCP (Dynamic Host Configuration Protocol) es esencial para la gestión eficiente de redes corporativas. DHCP permite asignar automáticamente direcciones IP y otros parámetros de configuración de red a los dispositivos en la red, simplificando la administración y reduciendo errores de configuración manual. En esta práctica, los estudiantes aprenderán a instalar y configurar el servicio de DHCP en Windows Server 2022 utilizando VirtualBox. La práctica incluye la creación de una red NAT interna, la configuración de una IP fija en el servidor y la verificación de la asignación de direcciones IP a través de DHCP. A través de esta práctica, los estudiantes desarrollarán competencias clave en la administración de servicios de red en entornos virtualizados.

### Instrucciones:

1. **Crear una nueva red NAT interna**:
    - Abre una terminal y ejecuta el siguiente comando para crear una red NAT interna llamada `RedPollitoPio` con número de red `172.24.27.0/24` y DHCP deshabilitado:
      ```sh
      vboxmanage natnetwork add --netname RedPollitoPio --network 172.24.27.0/24 --dhcp off
      ```

2. **Cambiar la configuración del adaptador de red de la máquina virtual**:
    - Abre VirtualBox y selecciona la máquina virtual con Windows Server 2022.
    - Haz clic en "Configuración" y luego en "Red".
    - Cambia el "Modo de red" del adaptador a "NAT Interna" y selecciona la red `RedPollitoPio` creada anteriormente.

3. **Configurar Windows Server con IP fija**:
    - Inicia la máquina virtual con Windows Server 2022.
    - Configura la IP fija `172.24.27.5/24` en la configuración de red de Windows Server.

4. **Instalar el servicio de DHCP en Windows Server**:
    - Abre el "Administrador del Servidor" en Windows Server.
    - Haz clic en "Agregar roles y características".
    - Selecciona "Instalación basada en características o en roles".
    - Selecciona el servidor y luego marca la casilla "Servidor DHCP".
    - Completa el asistente para instalar el servicio de DHCP.

5. **Configurar el servicio de DHCP**:
    - Abre la consola de "Administración de DHCP".
        - Configura un nuevo ámbito con el rango de direcciones IP desde `172.24.27.10` hasta `172.24.27.50`.
        - Asigna la dirección `172.24.27.5` como servidor DNS para este ámbito, aunque aún no esté configurado.

6. **Verificar la configuración con una máquina virtual con Windows 10**:
    - Conecta una máquina virtual con Windows 10 a la red interna `RedPollitoPio`.
    - Verifica que la máquina virtual con Windows 10 obtenga una dirección IP automáticamente del servidor DHCP.

### Resultado esperado:
El alumno debe tener el servicio de DHCP instalado y configurado en Windows Server 2022, y una máquina virtual con Windows 10 debe obtener una dirección IP automáticamente de este servidor DHCP.


## Práctica 3: Creación de un dominio de Windows Server 2022

### Objetivo: 
Instalar los servicios de Active Directory y DNS como pre requisitos para implementar una red Corporativa utilizando Windows Server.

### Competencias

- Desarrollar habilidades prácticas en la instalación y configuración de servicios de Active Directory y DNS en Windows Server.
- Comprender los conceptos fundamentales de la administración de dominios y servicios de red en entornos corporativos.
- Aprender a solucionar problemas comunes relacionados con la configuración y gestión de dominios y servicios de DNS.
- Adquirir experiencia en la administración de redes corporativas utilizando Windows Server.

### Introducción
La creación de un dominio en Windows Server 2022 es un paso crucial para la administración centralizada de usuarios, equipos y recursos en una red corporativa. En esta práctica, los estudiantes aprenderán a instalar y configurar los servicios de Active Directory y DNS en Windows Server 2022 utilizando VirtualBox. La práctica incluye la promoción del servidor a controlador de dominio y la configuración de un dominio nuevo. A través de esta práctica, los estudiantes desarrollarán competencias esenciales en la administración de dominios y servicios de red, mejorando su capacidad para gestionar entornos corporativos de manera eficiente.

### Instrucciones:

1. **Preparar el servidor**:
    - Asegúrate de que el servidor con Windows Server 2022 esté actualizado con las últimas actualizaciones de Windows.
    - Verifica que el servidor tenga una IP fija configurada.

2. **Instalar los servicios de Active Directory y DNS**:
    - Abre el "Administrador del Servidor" en Windows Server.
    - Haz clic en "Agregar roles y características".
    - Selecciona "Instalación basada en características o en roles".
    - Selecciona el servidor y luego marca las casillas "Servicios de dominio de Active Directory" y "Servidor DNS".
    - Completa el asistente para instalar los servicios.

3. **Promover el servidor a controlador de dominio**:
    - Después de la instalación, haz clic en la notificación que aparece en el "Administrador del Servidor" y selecciona "Promover este servidor a controlador de dominio".
    - Selecciona "Agregar un nuevo bosque" ya que este es el primer dominio de la red.
    - Introduce el nombre del dominio raíz, por ejemplo, `PollitoPio.com`.
    - Configura las opciones de dominio y bosque según las necesidades de tu red.
    - Completa el asistente y reinicia el servidor cuando se te solicite.

4. **Configurar el servicio de DNS**:
    - Abre la consola de "Administrador de DNS".
    - Verifica que se haya creado una zona de búsqueda directa para el dominio `PollitoPio.com`.
    - Configura cualquier zona adicional o registros DNS necesarios para tu red.

5. **Verificar la configuración del dominio**:
    - Inicia sesión en el servidor con una cuenta de administrador del dominio.
    - Abre la consola de "Usuarios y equipos de Active Directory" y verifica que el dominio `PollitoPio.com` esté presente.
    - Crea algunos usuarios de prueba para asegurarte de que el dominio esté funcionando correctamente.

### Resultado esperado:
El alumno debe tener un servidor con Windows Server 2022 configurado como controlador de dominio y servidor DNS para el dominio `PollitoPio.com`, listo para ser utilizado en las siguientes prácticas.


## Práctica 4: Unión de computadoras al dominio

### Objetivo:
Unir una computadora con Windows 10 al dominio `PollitoPio.com` y verificar la autenticación con uno de los usuarios creados en la práctica anterior.

### Competencias

- Desarrollar habilidades prácticas en la unión de computadoras a un dominio de Windows Server.
- Aprender a verificar la autenticación de usuarios en un dominio.
- Adquirir experiencia en la administración de redes corporativas utilizando Windows Server.
- Comprender los conceptos fundamentales de la gestión de usuarios y equipos en un entorno de dominio.
- Solucionar problemas comunes relacionados con la unión de equipos a un dominio y la autenticación de usuarios.
- Mejorar la capacidad para gestionar entornos corporativos de manera eficiente.

### Introducción
La unión de computadoras a un dominio es un proceso fundamental en la administración de redes corporativas, ya que permite la gestión centralizada de usuarios, equipos y recursos. En esta práctica, los estudiantes aprenderán a unir una computadora con Windows 10 al dominio creado previamente en Windows Server 2022. La práctica incluye la verificación de la autenticación de usuarios en el dominio, lo que asegura que las políticas y configuraciones del dominio se apliquen correctamente a los equipos unidos. A través de esta práctica, los estudiantes desarrollarán competencias esenciales en la gestión de usuarios y equipos en un entorno de dominio, mejorando su capacidad para administrar redes corporativas de manera eficiente.

### Instrucciones:

1. **Preparar la máquina virtual con Windows 10**:
    - Asegúrate de que la máquina virtual con Windows 10 esté conectada a la red interna `RedPollitoPio`.
    - Verifica que la máquina virtual obtenga una dirección IP automáticamente del servidor DHCP configurado en la práctica anterior.

2. **Unir la máquina virtual con Windows 10 al dominio**:
    - Inicia sesión en la máquina virtual con una cuenta de administrador local.
    - Abre la configuración de "Sistema" y navega a "Información".
    - Haz clic en "Cambiar configuración" en la sección "Nombre del equipo, dominio y grupo de trabajo".
    - En la ventana "Propiedades del sistema", haz clic en "Cambiar".
    - Selecciona "Dominio" e introduce `PollitoPio.com`.
    - Cuando se te solicite, introduce las credenciales de una cuenta de administrador del dominio.

3. **Verificar la unión al dominio**:
    - Reinicia la máquina virtual con Windows 10.
    - En la pantalla de inicio de sesión, selecciona "Otro usuario" e introduce las credenciales de uno de los usuarios creados en la práctica anterior.
    - Verifica que puedas iniciar sesión correctamente en el dominio `PollitoPio.com`.


### Resultado esperado:
El alumno debe tener una máquina virtual con Windows 10 unida al dominio `PollitoPio.com` y debe poder iniciar sesión con uno de los usuarios creados en la práctica anterior.

## Práctica 5: Creación de Grupos, Unidades organizacionales y Grupos de Seguridad

### Objetivo:

Familiarizarse con los procedimientos de creación de objetos en un dominio de Active Directory 

### Competencias

- Desarrollar habilidades prácticas en la creación y gestión de objetos en Active Directory.
- Aprender a organizar usuarios y equipos en unidades organizacionales.
- Comprender los conceptos fundamentales de la administración de grupos de seguridad en un entorno de dominio.
- Mejorar la capacidad para gestionar permisos y políticas de seguridad en redes corporativas.
- Adquirir experiencia en la administración de Active Directory utilizando Windows Server.

### Introducción

La administración de objetos en Active Directory es esencial para mantener una estructura organizada y segura en una red corporativa. En esta práctica, los estudiantes aprenderán a crear y gestionar unidades organizacionales, grupos de seguridad y otros objetos en un dominio de Active Directory. La práctica incluye la creación de unidades organizacionales para organizar usuarios y equipos, así como la configuración de grupos de seguridad para gestionar permisos y políticas de acceso. A través de esta práctica, los estudiantes desarrollarán competencias clave en la administración de Active Directory, mejorando su capacidad para gestionar redes corporativas de manera eficiente y segura.

### Instrucciones

Utilice la siguiente estructura para esta y practicas posteriores de la Unidad

```yaml
TechCorp.local
│
├── OU: Usuarios
│   ├── OU: Zona_Norte
│   │   ├── OU: Ciudad_Monterrey
│   │   │   ├── OU: Ventas
│   │   │   ├── OU: Soporte
│   │   │   ├── OU: Administración
│   │   ├── OU: Ciudad_Tijuana
│   │       ├── OU: Ventas
│   │       ├── OU: Soporte
│   │       ├── OU: Administración
│   ├── OU: Zona_Centro
│   │   ├── OU: Ciudad_CDMX
│   │   │   ├── OU: Ventas
│   │   │   ├── OU: Soporte
│   │   │   ├── OU: Administración
│   │   ├── OU: Ciudad_Guadalajara
│   │       ├── OU: Ventas
│   │       ├── OU: Soporte
│   │       ├── OU: Administración
│   ├── OU: Zona_Sur
│       ├── OU: Ciudad_Mérida
│           ├── OU: Ventas
│           ├── OU: Soporte
│           ├── OU: Administración
│
├── OU: Equipos
│   ├── OU: Zona_Norte
│   │   ├── OU: Ciudad_Monterrey
│   │       ├── OU: PCs
│   │       ├── OU: Servidores
│   │       ├── OU: Impresoras
│   │   ├── OU: Ciudad_Tijuana
│   │       ├── OU: PCs
│   │       ├── OU: Servidores
│   │       ├── OU: Impresoras
│   ├── OU: Zona_Centro
│   │   ├── OU: Ciudad_CDMX
│   │       ├── OU: PCs
│   │       ├── OU: Servidores
│   │       ├── OU: Impresoras
│   ├── OU: Zona_Sur
│       ├── OU: Ciudad_Mérida
│           ├── OU: PCs
│           ├── OU: Servidores
│           ├── OU: Impresoras
│
├── OU: Grupos
│   ├── OU: Zona_Norte
│   ├── OU: Zona_Centro
│   ├── OU: Zona_Sur
│
├── OU: Políticas
│   ├── GPO_Ventas
│   ├── GPO_Soporte
│   ├── GPO_Administración
│
└── OU: Seguridad
    ├── OU: Cuentas_Privilegiadas
    ├── OU: Cuentas_de_Servicio
    ├── OU: Bloqueo_ExEmpleados
```


1. **Abrir la consola de "Usuarios y equipos de Active Directory"**:
    - Inicia sesión en el servidor con Windows Server 2022 con una cuenta de administrador del dominio.
    - Abre la consola de "Usuarios y equipos de Active Directory" desde el "Administrador del Servidor" o ejecutando `dsa.msc`.

2. **Crear Unidades Organizacionales (OU)**:
    - En la consola de "Usuarios y equipos de Active Directory", haz clic derecho en el nombre del dominio (`PollitoPio.com`) y selecciona "Nuevo" > "Unidad organizativa".
    - Introduce un nombre para la nueva OU, por ejemplo, "Zona Noroeste" o "Equipos".
    - Repite el proceso para crear las OUs necesarias según la estructura de tu organización.

3. **Crear Grupos de Seguridad**:
    - Dentro de la OU correspondiente, haz clic derecho y selecciona "Nuevo" > "Grupo".
    - Introduce un nombre para el grupo de seguridad, por ejemplo, "Administradores" o "Usuarios".
    - Selecciona el tipo de grupo (Seguridad) y el ámbito (Global o Dominio local) según las necesidades de tu red.
    - Haz clic en "Aceptar" para crear el grupo.

4. **Agregar usuarios a las Unidades Organizacionales**:
    - En la OU "Usuarios", haz clic derecho y selecciona "Nuevo" > "Usuario".
    - Introduce la información requerida para el nuevo usuario, como nombre, apellido y nombre de inicio de sesión.
    - Establece una contraseña para el usuario y configura las opciones de contraseña según las políticas de tu organización.
    - Haz clic en "Finalizar" para crear el usuario.
    - Repite el proceso para crear todos los usuarios necesarios.

5. **Asignar usuarios a Grupos de Seguridad**:
    - Selecciona el grupo de seguridad creado anteriormente y haz clic derecho en él.
    - Selecciona "Propiedades" y luego la pestaña "Miembros".
    - Haz clic en "Agregar" y busca los usuarios que deseas agregar al grupo.
    - Selecciona los usuarios y haz clic en "Aceptar" para agregarlos al grupo.


### Resultado esperado:
El alumno debe tener una estructura organizada en Active Directory con unidades organizacionales, grupos de seguridad y usuarios creados y configurados correctamente. Los permisos y políticas de seguridad deben estar aplicados según las necesidades de la red corporativa.


## Práctica 6: Seguridad y acceso a recursos

### Objetivo: 
Aprender a limitar el acceso a los recursos utilizando los permisos del sistema de archivos y la pertenencia a grupos

### Requisitos:
- Servidor con Windows Server
- Computadora cliente con Windows 10
- Usuarios y grupos de la práctica anterior

### Competencias

- Desarrollar habilidades prácticas en la configuración de permisos de acceso a recursos en Windows Server.
- Aprender a utilizar grupos de seguridad para gestionar el acceso a archivos y carpetas.
- Comprender los conceptos fundamentales de la administración de permisos en sistemas de archivos.
- Mejorar la capacidad para implementar políticas de seguridad en redes corporativas.
- Adquirir experiencia en la gestión de recursos compartidos y la protección de datos en entornos corporativos.
- Solucionar problemas comunes relacionados con la configuración de permisos y el acceso a recursos.

### Introducción:
La seguridad y el acceso a recursos son aspectos fundamentales en la administración de redes corporativas. En esta práctica, los estudiantes aprenderán a configurar permisos de acceso a archivos y carpetas en Windows Server utilizando grupos de seguridad. La práctica incluye la creación de recursos compartidos, la asignación de permisos específicos a diferentes grupos y la verificación del acceso desde una computadora cliente con Windows 10. A través de esta práctica, los estudiantes desarrollarán competencias clave en la administración de permisos y la implementación de políticas de seguridad, mejorando su capacidad para proteger datos y gestionar recursos en entornos corporativos de manera eficiente.



Instrucciones:
1. Crear el directorio C:\DatosCorporativos:

    - Inicia sesión en el servidor con Windows Server 2022 con una cuenta de administrador.
    - Abre el Explorador de archivos y navega a la unidad C:.
    - Crea una nueva carpeta llamada DatosCorporativos.

2. Crear subdirectorios para Ventas y Soporte:

    - Dentro de C:\DatosCorporativos, crea dos subdirectorios llamados Ventas y Soporte.

3. Configurar permisos para el directorio Ventas:

    - Haz clic derecho en la carpeta Ventas y selecciona "Propiedades".
    - Ve a la pestaña "Seguridad" y haz clic en "Editar".
    - Haz clic en "Agregar" y escribe Ventas, luego haz clic en "Aceptar".
    - Selecciona el grupo Ventas y marca las casillas para permitir "Control total".
    - Haz clic en "Aceptar" para aplicar los cambios.

4. Configurar permisos para el directorio Soporte:

    - Haz clic derecho en la carpeta Soporte y selecciona "Propiedades".
    - Ve a la pestaña "Seguridad" y haz clic en "Editar".
    - Haz clic en "Agregar" y escribe Soporte, luego haz clic en "Aceptar".
    - Selecciona el grupo Soporte y marca las casillas para permitir "Control total".
    - Haz clic en "Aceptar" para aplicar los cambios.

5. Compartir el directorio C:\DatosCorporativos:

    - Haz clic derecho en la carpeta DatosCorporativos y selecciona "Propiedades".
    - Ve a la pestaña "Compartir" y haz clic en "Uso compartido avanzado".
    - Marca la casilla "Compartir esta carpeta" y asegúrate de que el nombre del recurso compartido sea DatosCorporativos.
    - Haz clic en "Permisos" y asegúrate de que los grupos Ventas y Soporte tengan permisos de "Lectura".
    - Haz clic en "Aceptar" para aplicar los cambios.

6. Verificar desde la máquina cliente:

    - Inicia sesión en la máquina cliente con Windows 10 con una cuenta de usuario del grupo Ventas.
    - Abre el Explorador de archivos y navega a \\<nombre_del_servidor>\DatosCorporativos.
    - Verifica que el usuario pueda acceder y modificar el contenido de la carpeta Ventas, pero no el contenido de la carpeta Soporte.
    - Cierra sesión y repite el proceso iniciando sesión con una cuenta de usuario del grupo Soporte.
    - Verifica que el usuario pueda acceder y modificar el contenido de la carpeta Soporte, pero no el contenido de la carpeta Ventas.


### Resultado esperado:
El alumno debe tener configurados los permisos de acceso a los directorios Ventas y Soporte en C:\DatosCorporativos de manera que los usuarios de cada grupo puedan acceder y modificar solo su respectivo directorio, mientras que pueden listar el contenido del directorio del otro grupo. Los usuarios deben poder acceder a estos directorios desde una máquina cliente con Windows 10.


## Práctica 7: Políticas de grupo

### Objetivo:
Familiarizarse con la creación y aplicación de políticas de grupo

### Competencias:

- Desarrollar habilidades prácticas en la creación y aplicación de políticas de grupo en Active Directory.
- Aprender a gestionar configuraciones y restricciones en equipos y usuarios mediante políticas de grupo.
- Comprender los conceptos fundamentales de la administración de políticas de grupo en entornos corporativos.
- Mejorar la capacidad para implementar y gestionar políticas de seguridad y configuración en redes corporativas.
- Adquirir experiencia en la resolución de problemas comunes relacionados con la aplicación de políticas de grupo.
- Optimizar la administración de recursos y la seguridad en entornos de dominio utilizando políticas de grupo.

### Introducción:
Las políticas de grupo son una herramienta esencial en la administración de redes corporativas, ya que permiten gestionar configuraciones y restricciones en equipos y usuarios de manera centralizada. En esta práctica, los estudiantes aprenderán a crear y aplicar políticas de grupo en Active Directory utilizando Windows Server 2022. La práctica incluye la configuración de políticas para controlar aspectos como la seguridad, el acceso a recursos y la configuración del sistema. A través de esta práctica, los estudiantes desarrollarán competencias clave en la administración de políticas de grupo, mejorando su capacidad para implementar y gestionar políticas de seguridad y configuración en redes corporativas de manera eficiente.

### Instrucciones:

1. **Abrir la consola de "Administración de directivas de grupo"**:
    - Inicia sesión en el servidor con Windows Server 2022 con una cuenta de administrador del dominio.
    - Abre la consola de "Administración de directivas de grupo" desde el "Administrador del Servidor" o ejecutando `gpmc.msc`.

2. **Crear una nueva GPO para GPO_Ventas**:
    - En la consola de "Administración de directivas de grupo", haz clic derecho en "Objetos de directiva de grupo" y selecciona "Nuevo".
    - Introduce un nombre para la nueva GPO, por ejemplo, "GPO_Ventas".
    - Haz clic derecho en la nueva GPO y selecciona "Editar".
    - Navega a "Configuración de usuario" > "Políticas" > "Plantillas administrativas" > "Sistema" > "Acceso de almacenamiento extraíble".
    - Configura la política "Denegar acceso a todas las clases de almacenamiento extraíble" como "Habilitada".

3. **Vincular la GPO_Ventas a la OU correspondiente**:
    - En la consola de "Administración de directivas de grupo", haz clic derecho en la OU "GPO_Ventas" y selecciona "Vincular un GPO existente".
    - Selecciona "GPO_Ventas" y haz clic en "Aceptar".

4. **Crear una nueva GPO para GPO_Soporte**:
    - En la consola de "Administración de directivas de grupo", haz clic derecho en "Objetos de directiva de grupo" y selecciona "Nuevo".
    - Introduce un nombre para la nueva GPO, por ejemplo, "GPO_Soporte".
    - Haz clic derecho en la nueva GPO y selecciona "Editar".
    - Navega a "Configuración del equipo" > "Políticas" > "Plantillas administrativas" > "Panel de control" > "Personalización".
    - Configura la política "Tiempo de espera de la pantalla de bloqueo" como "Habilitada" y establece el tiempo en "2 minutos".

5. **Vincular la GPO_Soporte a la OU correspondiente**:
    - En la consola de "Administración de directivas de grupo", haz clic derecho en la OU "GPO_Soporte" y selecciona "Vincular un GPO existente".
    - Selecciona "GPO_Soporte" y haz clic en "Aceptar".

6. **Crear una nueva GPO para el fondo de escritorio**:
    - En la consola de "Administración de directivas de grupo", haz clic derecho en "Objetos de directiva de grupo" y selecciona "Nuevo".
    - Introduce un nombre para la nueva GPO, por ejemplo, "GPO_FondoEscritorio".
    - Haz clic derecho en la nueva GPO y selecciona "Editar".
    - Navega a "Configuración del equipo" > "Políticas" > "Plantillas administrativas" > "Escritorio" > "Active Desktop".
    - Configura la política "Fondo de escritorio" como "Habilitada" y establece la ruta del fondo de escritorio en `\\<nombre_del_servidor>\DatosCorporativos\logo_empresa.jpg`.

7. **Vincular la GPO_FondoEscritorio a la raíz del dominio**:
    - En la consola de "Administración de directivas de grupo", haz clic derecho en el nombre del dominio y selecciona "Vincular un GPO existente".
    - Selecciona "GPO_FondoEscritorio" y haz clic en "Aceptar".
8. **Forzar la aplicación inmediata de las políticas definidas**:
    - En el servidor con Windows Server 2022, abre una terminal de comandos con privilegios de administrador.
    - Ejecuta el siguiente comando para actualizar las políticas de grupo en el servidor:
      ```sh
      gpupdate /force
      ```

9. **Verificar que se aplicaron las políticas**:
    - Inicia sesión en la máquina cliente con Windows 10 con una cuenta de usuario del grupo Ventas.
    - Intenta conectar un dispositivo de almacenamiento extraíble y verifica que el acceso esté denegado.
    - Inicia sesión en la máquina cliente con Windows 10 con una cuenta de usuario del grupo Soporte.
    - Deja la máquina inactiva durante 2 minutos y verifica que la pantalla se bloquee automáticamente.
    - Verifica que el fondo de escritorio de todas las máquinas clientes esté configurado con el logo de la empresa especificado en la política.

### Resultado esperado:
El alumno debe tener configuradas las políticas de grupo de manera que los usuarios de la OU GPO_Ventas no puedan conectar dispositivos de almacenamiento extraíble, los equipos de la OU GPO_Soporte bloqueen la pantalla después de 2 minutos de inactividad, y todos los equipos tengan el fondo de escritorio configurado con el logo de la empresa.


### Resultado esperado:
El alumno debe tener configuradas las políticas de grupo de manera que los usuarios de la OU GPO_Ventas no puedan conectar dispositivos de almacenamiento extraíble, los equipos de la OU GPO_Soporte bloqueen la pantalla después de 2 minutos de inactividad, y todos los equipos tengan el fondo de escritorio configurado con el logo de la empresa.


## Práctica 8: Administración y monitorización de procesos, red, memoria, sistemas de archivos, servicios

### Objetivo: 

Familiarizarse con las herramientas de administración nativas de Windows Server

### Competencias:

- Desarrollar habilidades prácticas en el uso de herramientas de administración y monitorización de Windows Server.
- Aprender a supervisar y analizar el rendimiento de procesos, red, memoria, sistemas de archivos y servicios.
- Comprender los conceptos fundamentales de la administración y optimización de recursos en entornos corporativos.
- Mejorar la capacidad para identificar y solucionar problemas relacionados con el rendimiento del sistema.
- Adquirir experiencia en la gestión proactiva de servidores para garantizar la disponibilidad y eficiencia de los servicios.
- Optimizar el uso de recursos del sistema mediante la implementación de buenas prácticas de administración.

### Introducción:

La administración y monitorización de recursos en Windows Server es esencial para garantizar el rendimiento, la estabilidad y la disponibilidad de los servicios en un entorno corporativo. En esta práctica, los estudiantes aprenderán a utilizar herramientas nativas de Windows Server para supervisar procesos, red, memoria, sistemas de archivos y servicios. Estas habilidades son fundamentales para identificar y resolver problemas de rendimiento, optimizar el uso de recursos y garantizar la continuidad operativa de los sistemas. A través de esta práctica, los estudiantes desarrollarán competencias clave en la gestión proactiva de servidores, mejorando su capacidad para administrar entornos corporativos de manera eficiente.

### Instrucciones:

1. **Supervisar procesos en el servidor**:
    - Inicia sesión en el servidor con Windows Server 2022 con una cuenta de administrador.
    - Abre el "Administrador de tareas" presionando `Ctrl + Shift + Esc`.
    - Ve a la pestaña "Procesos" y analiza los procesos en ejecución.
    - Identifica los procesos que consumen más CPU y memoria.
    - Haz clic derecho en un proceso y selecciona "Finalizar tarea" para detener un proceso no esencial.

2. **Monitorizar el uso de la red**:
    - Abre el "Monitor de recursos" desde el "Administrador del Servidor" o ejecutando `resmon` en la terminal.
    - Ve a la pestaña "Red" y analiza las aplicaciones que están utilizando la red.
    - Identifica las conexiones activas y verifica si hay tráfico inusual o no autorizado.

3. **Supervisar el uso de la memoria**:
    - En el "Monitor de recursos", ve a la pestaña "Memoria".
    - Analiza el uso de memoria por proceso y verifica si hay procesos que consumen demasiada memoria.
    - Identifica si hay memoria disponible suficiente para las operaciones del servidor.

4. **Monitorizar el sistema de archivos**:
    - Abre el "Administrador del Servidor" y navega a "Almacenamiento" > "Administración de discos".
    - Verifica el estado de los discos y analiza el espacio disponible en cada unidad.
    - Identifica si hay particiones con poco espacio libre y considera expandirlas si es necesario.

5. **Supervisar servicios en ejecución**:
    - Abre la consola de "Servicios" ejecutando `services.msc`.
    - Revisa el estado de los servicios críticos, como "Active Directory", "Servidor DNS" y "Servidor DHCP".
    - Asegúrate de que los servicios necesarios estén en estado "En ejecución".
    - Reinicia cualquier servicio que no esté funcionando correctamente.

6. **Configurar alertas de rendimiento**:
    - Abre el "Monitor de rendimiento" desde el "Administrador del Servidor" o ejecutando `perfmon`.
    - Haz clic en "Conjuntos de recopiladores de datos" > "Definido por el usuario" > "Nuevo conjunto de recopiladores de datos".
    - Configura un conjunto de recopiladores para supervisar el uso de CPU, memoria y red.
    - Establece alertas para notificarte si los valores superan los umbrales definidos.

7. **Generar un informe de rendimiento**:
    - En el "Monitor de rendimiento", haz clic en "Informes" > "Definido por el usuario".
    - Selecciona el conjunto de recopiladores de datos creado anteriormente y genera un informe.
    - Analiza el informe para identificar posibles problemas de rendimiento.

8. **Documentar y solucionar problemas**:
    - Documenta cualquier problema identificado durante la monitorización.
    - Aplica soluciones para optimizar el rendimiento, como detener procesos innecesarios, liberar espacio en disco o ajustar configuraciones de red.
    - Verifica que las soluciones implementadas hayan mejorado el rendimiento del servidor.

### Resultado esperado:
El alumno debe ser capaz de utilizar las herramientas nativas de Windows Server para supervisar y analizar el rendimiento del sistema, identificar problemas y aplicar soluciones para optimizar el uso de recursos y garantizar la estabilidad del servidor.

## Práctica 10: Administración de Discos

### Objetivo:
Familiarizarse con los conceptos y herramientas para la administración de discos, así como los diferentes Sistemas de Archivos soportados por Windows Server

### Competencias:

- Desarrollar habilidades prácticas en la administración de discos y sistemas de archivos en Windows Server.
- Comprender los conceptos fundamentales de particionamiento, formateo y configuración de discos.
- Aprender a utilizar herramientas nativas de Windows Server para gestionar discos y volúmenes.
- Mejorar la capacidad para solucionar problemas relacionados con el almacenamiento y la integridad de datos.
- Adquirir experiencia en la implementación de sistemas de archivos y configuraciones de almacenamiento en entornos corporativos.
- Optimizar el uso de recursos de almacenamiento mediante la aplicación de buenas prácticas de administración.

### Introducción

La administración de discos es una tarea esencial en la gestión de servidores, ya que permite optimizar el uso del almacenamiento y garantizar la integridad de los datos. En esta práctica, los estudiantes aprenderán a utilizar las herramientas nativas de Windows Server para realizar tareas como particionamiento, formateo y configuración de discos. Además, explorarán los diferentes sistemas de archivos soportados por Windows Server, adquiriendo competencias clave para implementar y gestionar soluciones de almacenamiento en entornos corporativos de manera eficiente y segura.

### Instrucciones

1. **Abrir la herramienta de Administración de discos**:
    - Inicia sesión en el servidor con Windows Server 2022 con una cuenta de administrador.
    - Abre el "Administrador del Servidor" y navega a "Herramientas" > "Administración de discos".
    - Alternativamente, ejecuta `diskmgmt.msc` en la terminal para abrir la herramienta de administración de discos.

2. **Crear un volumen simple**:
    - Haz clic derecho en un espacio no asignado en uno de los discos disponibles y selecciona "Nuevo volumen simple".
    - Sigue el asistente para asignar un tamaño al volumen, una letra de unidad y un sistema de archivos (por ejemplo, NTFS).
    - Completa el asistente y verifica que el volumen se haya creado correctamente.

3. **Convertir un disco básico en dinámico**:
    - Haz clic derecho en un disco básico en la herramienta de administración de discos y selecciona "Convertir a disco dinámico".
    - Sigue el asistente para completar la conversión.
    - Nota: Este proceso puede afectar los datos existentes, por lo que se recomienda realizar una copia de seguridad antes de proceder.

4. **Crear un volumen distribuido**:
    - Asegúrate de tener al menos dos discos dinámicos disponibles.
    - Haz clic derecho en un espacio no asignado en uno de los discos y selecciona "Nuevo volumen distribuido".
    - Sigue el asistente para seleccionar los discos adicionales que formarán parte del volumen distribuido.
    - Asigna una letra de unidad y un sistema de archivos, y completa el asistente.

5. **Crear un volumen reflejado**:
    - Convierte dos discos básicos en discos dinámicos si aún no lo están.
    - Haz clic derecho en un espacio no asignado en uno de los discos y selecciona "Nuevo volumen reflejado".
    - Selecciona el segundo disco para reflejar los datos y sigue el asistente para completar la configuración.
    - Verifica que el volumen reflejado esté configurado correctamente.

6. **Crear un volumen RAID-5**:
    - Asegúrate de tener al menos tres discos dinámicos disponibles.
    - Haz clic derecho en un espacio no asignado en uno de los discos y selecciona "Nuevo volumen RAID-5".
    - Selecciona los discos adicionales que formarán parte del volumen RAID-5 y sigue el asistente.
    - Asigna una letra de unidad y un sistema de archivos, y completa el asistente.

7. **Montar un volumen en una carpeta en lugar de asignar una letra de unidad**:
    - Crea un volumen simple o utiliza un volumen existente.
    - Haz clic derecho en el volumen y selecciona "Cambiar letra y rutas de acceso de unidad".
    - Haz clic en "Agregar" y selecciona "Montar en la siguiente carpeta NTFS".
    - Especifica una carpeta vacía en un volumen existente donde se montará el nuevo volumen y haz clic en "Aceptar".


8. **Configurar un volumen como solo lectura**:
    - Abre una terminal de comandos con privilegios de administrador y ejecuta `diskpart`.
    - En la consola de `diskpart`, ejecuta los siguientes comandos:
      ```sh
      list volume
      select volume <número_del_volumen>
      attributes volume set readonly
      ```
    - Verifica que el volumen ahora esté configurado como solo lectura.

9. **Eliminar un volumen**:
    - Haz clic derecho en un volumen existente en la herramienta de administración de discos y selecciona "Eliminar volumen".
    - Confirma la eliminación del volumen. Nota: Esto eliminará todos los datos en el volumen.

10. **Documentar y verificar la configuración**:
    - Documenta los pasos realizados para cada tipo de volumen y partición.
    - Verifica que los volúmenes creados estén accesibles y funcionando correctamente desde el Explorador de archivos o la terminal.

### Resultado esperado:
El alumno debe ser capaz de crear y gestionar diferentes tipos de volúmenes y particiones, incluyendo volúmenes simples, distribuidos, reflejados y RAID-5. Además, debe comprender cómo montar volúmenes en carpetas, configurar volúmenes como solo lectura y eliminar volúmenes de manera segura. Los volúmenes creados deben estar configurados correctamente y accesibles desde el sistema operativo.

## Práctica 11: Uso de WinRM para la administración remota

### Objetivo:
Familiarizarse con el uso de Windows Remote Management (WinRM) para la administración remota de servidores y equipos en un dominio, incluyendo la ejecución de comandos en un servidor SQL.

### Competencias:

- Configurar y habilitar WinRM en servidores y equipos del dominio.
- Ejecutar comandos remotos utilizando `PowerShell` y `WinRM`.
- Administrar servicios y recursos de manera remota en un entorno corporativo.
- Ejecutar consultas y tareas administrativas en un servidor SQL de forma remota.
- Mejorar la capacidad para gestionar redes y servidores de manera eficiente utilizando herramientas modernas.

### Introducción:
Windows Remote Management (WinRM) es una herramienta poderosa que permite la administración remota de servidores y equipos en un entorno Windows. Basado en el protocolo WS-Management, WinRM permite ejecutar comandos, administrar servicios y realizar tareas administrativas de manera remota. En esta práctica, los estudiantes aprenderán a configurar y utilizar WinRM para administrar servidores y equipos en un dominio, incluyendo la ejecución de comandos en un servidor SQL. Estas habilidades son esenciales para la gestión eficiente de redes corporativas.

### Instrucciones:

1. **Habilitar WinRM en el servidor y equipos del dominio**:
    - Inicia sesión en el servidor con Windows Server 2022 con una cuenta de administrador del dominio.
    - Abre una terminal de PowerShell con privilegios de administrador y ejecuta el siguiente comando para habilitar WinRM:
      ```powershell
      Enable-PSRemoting -Force
      ```
    - Repite este paso en los equipos cliente del dominio.

2. **Configurar las reglas del firewall para WinRM**:
    - En el servidor y los equipos cliente, ejecuta el siguiente comando en PowerShell para habilitar las reglas necesarias en el firewall:
      ```powershell
      Set-NetFirewallRule -Name "WINRM-HTTP-In-TCP" -Enabled True
      ```

3. **Verificar la conectividad de WinRM**:
    - Desde el servidor, ejecuta el siguiente comando en PowerShell para probar la conectividad con un equipo cliente:
      ```powershell
      Test-WsMan -ComputerName <nombre_del_equipo_cliente>
      ```
    - Asegúrate de que el comando devuelva una respuesta exitosa.

4. **Ejecutar comandos remotos en un equipo cliente**:
    - Desde el servidor, utiliza el siguiente comando en PowerShell para ejecutar un comando remoto en un equipo cliente:
      ```powershell
      Invoke-Command -ComputerName <nombre_del_equipo_cliente> -ScriptBlock { Get-Service }
      ```
    - Verifica que se muestren los servicios en ejecución en el equipo cliente.

5. **Administrar un servicio en un equipo cliente**:
    - Desde el servidor, utiliza el siguiente comando en PowerShell para detener un servicio en un equipo cliente (por ejemplo, el servicio "Spooler"):
      ```powershell
      Invoke-Command -ComputerName <nombre_del_equipo_cliente> -ScriptBlock { Stop-Service -Name Spooler }
      ```
    - Verifica que el servicio se haya detenido correctamente.

6. **Ejecutar consultas en el servidor SQL de forma remota**:
    - Desde el servidor, utiliza el siguiente comando en PowerShell para ejecutar una consulta en el servidor SQL:
      ```powershell
      Invoke-Sqlcmd -ServerInstance "<nombre_del_servidor_SQL>" -Database "<nombre_de_la_base_de_datos>" -Query "SELECT TOP 10 * FROM <nombre_de_la_tabla>"
      ```
    - Asegúrate de que el comando devuelva los resultados esperados.

7. **Crear un script para tareas administrativas remotas**:
    - Crea un archivo de PowerShell llamado `AdministracionRemota.ps1` con el siguiente contenido:
      ```powershell
      $equipos = @("<nombre_del_equipo_cliente1>", "<nombre_del_equipo_cliente2>")
      foreach ($equipo in $equipos) {
          Invoke-Command -ComputerName $equipo -ScriptBlock {
              Get-Service | Where-Object { $_.Status -eq "Running" }
          }
      }
      ```
    - Ejecuta el script desde el servidor y verifica que se muestren los servicios en ejecución en los equipos especificados.

8. **Documentar y verificar la configuración**:
    - Documenta los pasos realizados para habilitar y utilizar WinRM.
    - Verifica que las tareas administrativas remotas se hayan ejecutado correctamente en los equipos y el servidor SQL.

### Resultado esperado:
El alumno debe ser capaz de habilitar y utilizar WinRM para administrar servidores y equipos en un dominio de manera remota. Además, debe ser capaz de ejecutar comandos en un servidor SQL y realizar tareas administrativas en equipos cliente utilizando PowerShell.





