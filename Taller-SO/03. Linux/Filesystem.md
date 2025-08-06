# Sistema de Archivos en Linux

## Objetivos de Aprendizaje
- Comprender la estructura jerárquica del sistema de archivos Linux
- Identificar la función de cada directorio principal del FHS
- Analizar diferentes tipos de sistemas de archivos y sus características
- Gestionar permisos y propiedades de archivos y directorios
- Implementar comandos de administración del sistema de archivos

## 1. Introducción al Sistema de Archivos Linux

### 1.1 Filosofía "Todo es un Archivo"
En Linux, prácticamente todo se representa como un archivo:
- **Archivos regulares**: Documentos, programas, datos
- **Directorios**: Contenedores de archivos y otros directorios
- **Dispositivos**: Hardware representado como archivos especiales
- **Procesos**: Información accesible a través de `/proc`
- **Enlaces**: Referencias a otros archivos o directorios

### 1.2 Estructura Jerárquica
- **Árbol invertido**: Inicia desde la raíz `/`
- **Rutas absolutas**: Comienzan desde `/` (ej: `/home/user/documento.txt`)
- **Rutas relativas**: Relativas al directorio actual (ej: `../carpeta/archivo`)
- **Separador**: Barra inclinada `/` (no backslash como Windows)

## 2. Filesystem Hierarchy Standard (FHS)

El FHS define la estructura estándar de directorios en sistemas Unix/Linux.

### 2.1 Directorios del Nivel Raíz

#### **/bin** (Binaries)
**Propósito**: Comandos esenciales disponibles para todos los usuarios
**Contenido típico**:
```bash
ls, cp, mv, rm, mkdir, cat, grep, ps, bash, sh
```
**Características**:
- Disponible desde el arranque
- Requerido para operación básica del sistema
- Accesible por todos los usuarios

#### **/sbin** (System Binaries)
**Propósito**: Comandos de administración del sistema
**Contenido típico**:
```bash
mount, umount, fdisk, fsck, iptables, systemctl
```
**Características**:
- Principalmente para root
- Herramientas de administración y mantenimiento

#### **/boot** (Boot Loader Files)
**Propósito**: Archivos necesarios para el arranque del sistema
**Contenido típico**:
- **vmlinuz**: Kernel comprimido
- **initrd**: RAM disk inicial
- **grub/**: Configuración del bootloader
- **System.map**: Tabla de símbolos del kernel

#### **/dev** (Device Files)
**Propósito**: Archivos de dispositivo
**Tipos de dispositivos**:
- **Dispositivos de bloque** (`/dev/sda`, `/dev/nvme0n1`): Almacenamiento
- **Dispositivos de carácter** (`/dev/tty`, `/dev/random`): Entrada/salida secuencial
- **Dispositivos especiales**:
  - `/dev/null`: "Agujero negro" para descartar salida
  - `/dev/zero`: Fuente infinita de bytes nulos
  - `/dev/random`: Generador de números aleatorios

#### **/etc** (Etcetera - Configuration)
**Propósito**: Archivos de configuración del sistema
**Archivos importantes**:
- `/etc/passwd`: Información de usuarios
- `/etc/group`: Información de grupos
- `/etc/fstab`: Sistemas de archivos a montar
- `/etc/hosts`: Mapeo de nombres a IPs
- `/etc/crontab`: Tareas programadas del sistema
- `/etc/ssh/`: Configuración SSH

#### **/home** (Home Directories)
**Propósito**: Directorios personales de usuarios
**Estructura típica**:
```
/home/
├── usuario1/
│   ├── Documents/
│   ├── Downloads/
│   ├── Desktop/
│   └── .bashrc (archivos ocultos de configuración)
└── usuario2/
```

#### **/lib** y **/lib64** (Libraries)
**Propósito**: Bibliotecas compartidas esenciales
**Contenido**:
- Bibliotecas dinámicas (.so files)
- Módulos del kernel en `/lib/modules/`
- `/lib64`: Bibliotecas de 64 bits en sistemas mixtos

#### **/media** (Removable Media)
**Propósito**: Puntos de montaje para dispositivos extraíbles
**Uso típico**:
```
/media/
├── cdrom/
├── usb/
└── usuario/
    └── USB_DRIVE/
```

#### **/mnt** (Mount)
**Propósito**: Punto de montaje temporal para administradores
**Uso**: Montaje manual de sistemas de archivos

#### **/opt** (Optional)
**Propósito**: Software adicional y paquetes de terceros
**Estructura**:
```
/opt/
├── google/
│   └── chrome/
├── vmware/
└── custom-app/
```

#### **/proc** (Process Information)
**Propósito**: Sistema de archivos virtual con información de procesos
**Archivos importantes**:
- `/proc/cpuinfo`: Información del procesador
- `/proc/meminfo`: Información de memoria
- `/proc/version`: Versión del kernel
- `/proc/[PID]/`: Información específica de proceso

#### **/root** (Root Home Directory)
**Propósito**: Directorio personal del usuario root
**Ubicación**: Separado de `/home` por seguridad

#### **/run** (Runtime Data)
**Propósito**: Datos de tiempo de ejecución desde el último arranque
**Contenido**: PIDs, sockets, archivos de bloqueo

#### **/sys** (System)
**Propósito**: Interfaz al kernel y subsistemas
**Información disponible**: Dispositivos, controladores, configuración del kernel

#### **/tmp** (Temporary)
**Propósito**: Archivos temporales
**Características**:
- Limpieza automática al reiniciar
- Acceso de escritura para todos los usuarios
- Sticky bit activado para seguridad

#### **/usr** (Unix System Resources)
**Propósito**: Datos de solo lectura del sistema
**Subdirectorios importantes**:
- `/usr/bin`: Comandos de usuario
- `/usr/sbin`: Comandos de administración no esenciales
- `/usr/lib`: Bibliotecas no esenciales
- `/usr/local`: Software instalado localmente
- `/usr/share`: Datos compartidos independientes de arquitectura

#### **/var** (Variable)
**Propósito**: Datos variables del sistema
**Subdirectorios importantes**:
- `/var/log`: Archivos de registro del sistema
- `/var/cache`: Datos de cache de aplicaciones
- `/var/spool`: Colas de impresión, correo, etc.
- `/var/tmp`: Archivos temporales preservados entre reinicios

## 3. Tipos de Sistemas de Archivos

### 3.1 Sistemas de Archivos Nativos de Linux

#### **ext4 (Fourth Extended Filesystem)**
**Características**:
- Journaling para recuperación rápida
- Soporte para archivos de hasta 16 TB
- Volúmenes de hasta 1 EB
- Checksums para integridad de datos

#### **XFS**
**Características**:
- Desarrollado por SGI
- Excelente rendimiento para archivos grandes
- Soporte para sistemas de archivos masivos
- Desfragmentación en línea

#### **Btrfs (B-tree File System)**
**Características**:
- Copy-on-write (CoW)
- Snapshots y subvolúmenes
- Compresión transparente
- RAID integrado
- Self-healing con checksums

#### **ZFS**
**Características**:
- Combinación de sistema de archivos y gestor de volúmenes
- Integridad de datos garantizada
- Snapshots y clones eficientes
- Deduplicación automática

### 3.2 Sistemas de Archivos de Red

#### **NFS (Network File System)**
- Compartición transparente de archivos en red
- Protocolo distribuido
- Soporte para diferentes versiones (NFSv2, v3, v4)

#### **CIFS/SMB**
- Common Internet File System
- Interoperabilidad con sistemas Windows
- Autenticación integrada

#### **SSHFS**
- Montaje de directorios remotos via SSH
- Cifrado automático
- Fácil configuración

### 3.3 Sistemas de Archivos Especiales

#### **tmpfs**
- Sistema de archivos en RAM
- Extremadamente rápido
- Perdida de datos al apagar

#### **devtmpfs**
- Gestión automática de `/dev`
- Creación dinámica de dispositivos

#### **procfs** y **sysfs**
- Sistemas de archivos virtuales
- Interfaz kernel-espacio de usuario

## 4. Permisos y Propiedades

### 4.1 Permisos Básicos (rwx)

#### **Representación Octal**:
- **4**: Read (r)
- **2**: Write (w)
- **1**: Execute (x)

#### **Ejemplos**:
```bash
755 = rwxr-xr-x  # Usuario: todos, Grupo: r+x, Otros: r+x
644 = rw-r--r--  # Usuario: r+w, Grupo: r, Otros: r
600 = rw-------  # Solo usuario: r+w
```

### 4.2 Permisos Especiales

#### **Sticky Bit (t)**
- Solo en directorios
- Solo el propietario puede eliminar archivos
- Ejemplo: `/tmp` (1777)

#### **SUID (Set User ID)**
- Ejecutar con permisos del propietario
- Ejemplo: `/usr/bin/passwd` (4755)

#### **SGID (Set Group ID)**
- Ejecutar con permisos del grupo
- En directorios: archivos heredan grupo

### 4.3 Comandos de Gestión

#### **Cambio de Permisos**:
```bash
chmod 755 archivo               # Modo octal
chmod u+x,g-w archivo          # Modo simbólico
chmod -R 644 directorio/       # Recursivo
```

#### **Cambio de Propietario**:
```bash
chown usuario:grupo archivo    # Cambiar usuario y grupo
chown usuario archivo          # Solo usuario
chgrp grupo archivo           # Solo grupo
```

## 5. Comandos Esenciales del Sistema de Archivos

### 5.1 Navegación y Exploración

```bash
ls -la                    # Listar con detalles y ocultos
pwd                       # Directorio actual
cd /ruta/destino         # Cambiar directorio
find /ruta -name "*.txt" # Buscar archivos
locate archivo           # Búsqueda rápida (requiere updatedb)
which comando            # Ubicación de comandos
```

### 5.2 Gestión de Archivos y Directorios

```bash
mkdir -p /ruta/nueva     # Crear directorios padres
rmdir directorio         # Eliminar directorio vacío
rm -rf directorio        # Eliminar recursivamente
cp -r origen destino     # Copiar recursivamente
mv origen destino        # Mover/renombrar
ln -s destino enlace     # Crear enlace simbólico
```

### 5.3 Visualización de Contenido

```bash
cat archivo              # Mostrar contenido completo
less archivo             # Paginación
head -n 20 archivo       # Primeras 20 líneas
tail -f archivo          # Últimas líneas + seguimiento
grep patrón archivo      # Búsqueda de patrones
```

### 5.4 Información del Sistema de Archivos

```bash
df -h                    # Uso de espacio en disco
du -sh directorio        # Tamaño de directorio
lsblk                    # Dispositivos de bloque
mount                    # Sistemas de archivos montados
findmnt                  # Árbol de montaje
```

## 6. Gestión Avanzada

### 6.1 Montaje de Sistemas de Archivos

#### **Montaje Manual**:
```bash
mount /dev/sdb1 /mnt/usb           # Montar dispositivo
mount -t nfs server:/path /mnt/nfs # Montar NFS
umount /mnt/usb                    # Desmontar
```

#### **Montaje Automático (/etc/fstab)**:
```bash
# dispositivo    punto_montaje    tipo    opciones         dump fsck
/dev/sda1       /               ext4    defaults         1    1
/dev/sda2       /home           ext4    defaults         1    2
tmpfs           /tmp            tmpfs   defaults,size=2G 0    0
```

### 6.2 LVM (Logical Volume Manager)

#### **Conceptos**:
- **PV (Physical Volume)**: Disco físico o partición
- **VG (Volume Group)**: Grupo de PVs
- **LV (Logical Volume)**: Volumen lógico dentro del VG

#### **Comandos Básicos**:
```bash
pvcreate /dev/sdb              # Crear PV
vgcreate mivg /dev/sdb         # Crear VG
lvcreate -L 10G -n milv mivg   # Crear LV
```

### 6.3 RAID Software

#### **Niveles Comunes**:
- **RAID 0**: Striping (rendimiento)
- **RAID 1**: Mirroring (redundancia)
- **RAID 5**: Striping con paridad
- **RAID 10**: Combinación 1+0

#### **Gestión con mdadm**:
```bash
mdadm --create /dev/md0 --level=1 --raid-devices=2 /dev/sdb /dev/sdc
```

## 7. Monitoreo y Mantenimiento

### 7.1 Herramientas de Monitoreo

```bash
iostat -x 1              # Estadísticas de I/O
iotop                    # Procesos por uso de I/O
lsof                     # Archivos abiertos
fuser /path/file         # Procesos usando archivo
```

### 7.2 Verificación y Reparación

```bash
fsck /dev/sda1           # Verificar sistema de archivos
e2fsck -f /dev/sda1      # Verificación forzada ext4
badblocks /dev/sda1      # Verificar bloques defectuosos
```

### 7.3 Optimización

```bash
tune2fs -l /dev/sda1     # Información del sistema de archivos
tune2fs -c 30 /dev/sda1  # Configurar verificación cada 30 montajes
e4defrag /home           # Desfragmentar ext4
```

## Referencias

1. Kerrisk, M. (2010). The Linux Programming Interface: A Linux and UNIX System Programming Handbook. No Starch Press.
2. Love, R. (2013). Linux System Programming: Talking Directly to the Kernel and C Library. O'Reilly Media.
3. Nemeth, E., Snyder, G., Hein, T. R., & Whaley, B. (2017). UNIX and Linux System Administration Handbook. Addison-Wesley.
4. The Linux Documentation Project. (2021). Linux Filesystem Hierarchy Standard. tldp.org.
5. Red Hat. (2022). System Administrator's Guide. access.redhat.com.

