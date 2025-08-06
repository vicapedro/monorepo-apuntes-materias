### 1. ~~**IoT (100 puntos)**~~
Implementar una casa inteligente con un Smart Hub y tres tipos de dispositivos conectados. Incluye una interfaz web para la gestión de dispositivos y eventos.**

- **Requisitos:**
  - Smart Hub (puede ser un Raspberry Pi).
  - Con ESP32 o Arduino diseñar tres tipos de dispositivos IoT  (por ejemplo, sensores de temperatura, luces inteligentes, ventiladores).
  - Interfaz web para gestionar dispositivos y eventos.

- **Pasos:**
    1. Desarrollar el Smart Hub en un Raspberry Pi o dispositivo similar, evitando soluciones preexistentes. Crear e implementar un protocolo propio para la comunicación entre dispositivos utilizando sockets UDP y TCP.
    2. Conectar los dispositivos IoT al Smart Hub. Estos dispositivos deben buscar y conectarse al Smart Hub, informándole de sus capacidades. Los dispositivos deben ser capaces de recibir comandos del Smart Hub y enviar eventos. Por ejemplo, un sensor de temperatura enviará eventos de temperatura al Smart Hub, y el Smart Hub podrá enviar comandos para encender o apagar una luz.
    3. Para facilitar las conexiones, se recomienda utilizar una red Ethernet y no Wi-Fi.
    4. Desarrollar una interfaz web utilizando el framework de su preferencia para gestionar los dispositivos y eventos.
    5. Documentar el proceso de instalación, configuración y demostración del sistema.

### 2. **Ansible (100 puntos)**
Configurar un laboratorio automatizado con Ansible.**

- **Requisitos:**
  - Máquinas virtuales o físicas para actuar como nodos.
  - Ansible instalado en el nodo de control.

- **Pasos:**
  1. Instalar Ansible en el nodo de control.
  2. Configurar el inventario de nodos.
  3. Crear playbooks para automatizar tareas como la instalación de software, configuración de servicios, etc.
  4. Documentar el proceso y demostrar la automatización.

### 3. **LTSP (90 puntos)**
Configurar un servidor LTSP para administrar clientes ligeros en un laboratorio.**

- **Requisitos:**
  - Servidor con LTSP instalado.
  - Clientes ligeros (pueden ser máquinas virtuales).

- **Pasos:**
  1. Instalar y configurar LTSP en el servidor.
  2. Configurar los clientes ligeros para que arranquen desde la red.
  3. Personalizar el entorno de escritorio y las aplicaciones disponibles para los clientes.
  4. Configurar la autenticación de usuarios y la gestión de perfiles.
  5. Los usuarios podrán conectarse desde cualquier cliente ligero y acceder a su escritorio personalizado.
  6. Configurar un entorno de desarrollo con VSCode, Python y Node.js. Los usuarios deberán poder instalar paquetes y extensiones para desarrollar aplicaciones.
  7. Documentar el proceso y demostrar el funcionamiento.

### 4. **Canvas LMS (90 puntos)**
Implementar el sistema de gestión de aprendizaje Canvas LMS en Debian con usuarios, cursos y contenido mínimo.**

- **Requisitos:**
  - Servidor Debian.
  - Canvas LMS instalado y configurado.

- **Pasos:**
  1. Instalar las dependencias necesarias en Debian.
  2. Configurar Canvas LMS.
  3. Crear usuarios, cursos y agregar contenido mínimo.
  4. Documentar el proceso y demostrar el funcionamiento.

### 5. **MagicMirror2 (90 puntos)**
Instalar y configurar MagicMirror2 en Debian o Raspberry Pi con módulos adicionales.

- **Requisitos:**
  - Raspberry Pi o servidor Debian.
  - MagicMirror2 instalado.
  - Que se active la pantalla al detectar a alguien

- **Pasos:**
  1. Instalar MagicMirror2.
  2. Configurar módulos adicionales (por ejemplo, reloj, clima, noticias).
  3. Documentar el proceso y demostrar el funcionamiento.

### 6. **TrueNAS Core (90 puntos)
Configurar un servidor NAS con iSCSI y almacenamiento en ZFS.

- **Requisitos:**
  - Servidor con TrueNAS Core instalado.
  - Configuración de ZFS y iSCSI.

- **Pasos:**
  1. Instalar TrueNAS Core.
  2. Configurar ZFS y iSCSI.
  3. Documentar el proceso y demostrar el funcionamiento.

### 7. **Active Directory en Linux (90 puntos)**
Implementar un dominio con Linux, integrando clientes Linux y Windows. (100 puntos si se integra con TrueNAS o LTSP).

- **Requisitos:**
  - Servidor Linux con Samba AD.
  - Clientes Linux y Windows.

- **Pasos:**
  1. Configurar Samba AD en el servidor Linux.
  2. Unir clientes Linux y Windows al dominio.
  3. Documentar el proceso y demostrar la integración.

### 8. **Servidor Web con Alta Disponibilidad (90 puntos)**
 Configurar un servidor Apache/Nginx con réplica en múltiples nodos. Usar GlusterFS o NFS para sincronizar archivos entre servidores

- **Requisitos:**
  - Múltiples servidores con Apache/Nginx.
  - Instalar una aplicación Web en los servidores, puede ser un CMS como WordPress o Joomla o un LMS como Moodle.
  - GlusterFS o NFS para sincronización.

- **Pasos:**
  1. Configurar Apache/Nginx en múltiples nodos.
  2. Configurar GlusterFS o NFS para sincronizar archivos.
  3. Documentar el proceso y demostrar la alta disponibilidad.

### 9. **Cluster de Kubernetes con K3s (100 puntos)**
Implementar un cluster ligero de Kubernetes con K3s. Desplegar contenedores con Docker y gestionarlos con kubectl. Configurar Ingress y volúmenes persistentes.

- **Requisitos:**
  - Múltiples nodos (pueden ser máquinas virtuales).
  - K3s instalado.

- **Pasos:**
  1. Instalar K3s en los nodos.
  2. Desplegar contenedores con Docker.
  3. Configurar Ingress y volúmenes persistentes.
  4. Documentar el proceso y demostrar la gestión del cluster.

### 10. ~~**Instalar Arch Linux (100): en su Laptop y usarlo durante el resto del semestre**~~

- **Requisitos:**
    - Arch Linux instalado
    - No cuenta si ya lo usa

- **Pasos:**
    1. Descargar la imagen ISO de Arch Linux desde el sitio oficial.
    2. Crear un medio de instalación (USB/DVD) con la imagen ISO descargada.
    3. Arrancar la laptop desde el medio de instalación.
    4. Configurar la red para tener acceso a Internet.
    5. Particionar el disco duro según sus necesidades.
    6. Formatear las particiones creadas con los sistemas de archivos elegidos.
    7. Montar las particiones en los puntos de montaje adecuados.
    8. Instalar el sistema base de Arch Linux utilizando el comando `pacstrap`.
    9.  Generar el archivo `fstab` para definir las particiones y puntos de montaje.
    10. Chroot en el nuevo sistema instalado.
    11. Configurar el sistema (zona horaria, localización, hostname, etc.).
    12. Instalar y configurar el gestor de arranque (GRUB, por ejemplo).
    13. Reiniciar el sistema y arrancar desde el disco duro.
    14. Instalar un entorno de escritorio o gestor de ventanas de su preferencia.
    15. Instalar y configurar las aplicaciones necesarias para su uso diario.
    16. Utilizarlo durante el resto del semestre para sus materias
    17. Documentar todo el proceso de instalación y configuración.
 
 ### 11. ~~**Entorno de Desarrollo en Linux (90 puntos)**~~
 Implementar un entorno de desarrollo con VS Code, Git, GitHub, Docker, Docker Compose, Node.js y un servidor de base de datos.

Este proyecto consiste en configurar un entorno de desarrollo completo en un sistema Linux, utilizando herramientas esenciales para el desarrollo de software moderno. El entorno incluirá un editor de código (VS Code), control de versiones (Git y GitHub), contenedores (Docker y Docker Compose), un entorno de ejecución para JavaScript (Node.js) y un servidor de base de datos (por ejemplo, MySQL o PostgreSQL).

- **Requisitos:**
  - Sistema Operativo: Linux (Ubuntu, Debian, o similar).
  - Herramientas a instalar:
    - VS Code: Editor de código.
    - Git y GitHub: Control de versiones y repositorio remoto.
    - Docker y Docker Compose: Para crear y gestionar contenedores.
    - Node.js: Entorno de ejecución para aplicaciones JavaScript.
    - Servidor de base de datos: MySQL, PostgreSQL, o similar.
  - Proyecto de ejemplo: Una aplicación Node.js simple que se conecte a la base de datos y se ejecute en contenedores Docker.

### 12. **Linux Multiseat (90 puntos)**
Configurar un sistema Linux para soportar múltiples usuarios simultáneamente en una sola máquina, utilizando la funcionalidad de multiseat.

- **Requisitos:**
  - Una máquina con Linux instalado (Ubuntu, Debian, o similar).
  - Múltiples monitores, teclados y ratones.
  - Software de gestión de multiseat (por ejemplo, `loginctl`).

- **Pasos:**
  1. Instalar y configurar el sistema operativo Linux en la máquina.
  2. Conectar los monitores, teclados y ratones a la máquina.
  3. Configurar el sistema para reconocer y asignar los dispositivos de entrada y salida a diferentes usuarios utilizando `loginctl`.
  4. Crear usuarios adicionales en el sistema.
  5. Configurar el entorno de escritorio para cada usuario.
  6. Probar la configuración asegurándose de que cada usuario pueda iniciar sesión y utilizar su propio monitor, teclado y ratón de manera independiente.
  7. Documentar el proceso de instalación, configuración y pruebas.


### 13. **Servidor de Nube Privada con Nextcloud (90 puntos)**
Implementar un servidor Nextcloud para compartir archivos, calendarios y contactos en una red local o a través de Internet.

- **Requisitos:**
  - Servidor Linux (Debian, Ubuntu, etc.).
  - Nextcloud instalado y configurado.
  - Certificado SSL (puede ser autofirmado para pruebas).

- **Pasos:**
  1. Instalar Nextcloud y sus dependencias (Apache/Nginx, PHP, base de datos).
  2. Configurar usuarios y grupos.
  3. Habilitar sincronización de archivos, calendarios y contactos.
  4. Configurar acceso seguro (HTTPS).
  5. Documentar el proceso y demostrar el funcionamiento.

### 14. **Instalar y Configurar Endian Firewall (90 puntos)**
Implementar un firewall de red utilizando Endian Firewall Community, configurando reglas de acceso, zonas de red y servicios de seguridad.

- **Requisitos:**
  - Máquina física o virtual para instalar Endian Firewall Community.
  - Al menos dos interfaces de red (para zonas verde y roja).
  - Acceso a la red interna y externa.

- **Pasos:**
  1. Descargar la imagen ISO de Endian Firewall Community.
  2. Instalar Endian Firewall en una máquina física o virtual.
  3. Configurar las interfaces de red para las zonas verde (LAN), roja (WAN) y, opcionalmente, azul (WiFi) y naranja (DMZ).
  4. Definir y aplicar reglas de firewall para controlar el tráfico entre zonas.
  5. Configurar servicios adicionales como VPN, proxy, filtrado de contenido o detección de intrusos según sea necesario.
  6. Documentar el proceso de instalación, configuración y pruebas de acceso y bloqueo.

### **Consejos Generales:**
- **Documentación:** Asegúrate de documentar cada paso del proceso, incluyendo capturas de pantalla y explicaciones detalladas.
- **Pruebas:** Realiza pruebas exhaustivas para asegurarte de que todo funciona correctamente antes de la presentación.
- **Presentación:** Prepara una presentación clara y concisa, y practica responder preguntas o realizar modificaciones en vivo.

¡Buena suerte con tu proyecto!
### Rubrica de Evaluación

| Criterio                | Excelente (90-100)                                                                 | Bueno (70-89)                                                                 | Regular (50-69)                                                              | Insuficiente (0-49)                                                         |
|-------------------------|------------------------------------------------------------------------------------|-------------------------------------------------------------------------------|------------------------------------------------------------------------------|------------------------------------------------------------------------------|
| **Documentación**       | Documentación completa y detallada, incluye capturas de pantalla y explicaciones claras. | Documentación adecuada, pero le faltan algunos detalles o capturas de pantalla. | Documentación incompleta o poco clara, faltan muchos detalles importantes.   | No hay documentación o es muy deficiente.                                    |
| **Funcionalidad**       | Todas las funcionalidades requeridas están implementadas y funcionan correctamente. | La mayoría de las funcionalidades están implementadas y funcionan correctamente. | Algunas funcionalidades están implementadas, pero hay errores o faltan partes. | La mayoría de las funcionalidades no están implementadas o no funcionan.     |
| **Innovación**          | Solución innovadora y creativa, va más allá de los requisitos básicos.              | Solución adecuada, cumple con los requisitos básicos.                         | Solución poco creativa, cumple con los requisitos mínimos.                   | Solución no cumple con los requisitos mínimos.                               |
| **Presentación**        | Presentación clara y concisa, el estudiante puede responder preguntas y hacer modificaciones en vivo. | Presentación adecuada, pero con algunas áreas de mejora en claridad o concisión. | Presentación poco clara, el estudiante tiene dificultades para responder preguntas. | Presentación deficiente, el estudiante no puede responder preguntas o hacer modificaciones. |
| **Pruebas**             | Pruebas exhaustivas realizadas, todos los casos de uso están cubiertos.             | Pruebas adecuadas, pero faltan algunos casos de uso.                          | Pruebas insuficientes, muchos casos de uso no están cubiertos.               | No se realizaron pruebas o son muy deficientes.                              |

# Rubrica de evaluacion
