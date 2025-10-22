# Práctica 06: Administración de Volúmenes Lógicos (LVM) en Linux

## Objetivo
**Duración estimada:** 2.5 horas

Desarrollar habilidades en la administración de almacenamiento flexible usando LVM (Logical Volume Manager) en Debian, desde la creación de volúmenes físicos y lógicos hasta la extensión dinámica de espacio en caliente.

## Competencias a desarrollar
- Instala y configura el soporte para LVM en sistemas Linux
- Administra discos, particiones y volúmenes físicos
- Crea y gestiona grupos de volúmenes y volúmenes lógicos
- Realiza montajes permanentes y extensiones de sistemas de archivos
- Documenta procesos técnicos con evidencia visual y explicaciones detalladas

## Introducción

LVM (Logical Volume Manager) es una tecnología de virtualización de almacenamiento que proporciona flexibilidad en la gestión de discos. Permite crear, redimensionar y gestionar volúmenes lógicos de manera dinámica, facilitando la administración del almacenamiento en entornos empresariales. Esta práctica simula escenarios reales de crecimiento de datos y administración eficiente de almacenamiento.

## Equipo de protección e higiene
- Mantener el área de trabajo limpia y ordenada
- No consumir alimentos cerca del equipo
- Verificar que los cables de alimentación estén en buen estado

## Material y equipo necesario

### Materiales e insumos
- Manual de referencia de LVM para Linux
- Libreta para anotaciones y diagramas
- USB para respaldo de evidencias

### Equipo de laboratorio
- Computadora con software de virtualización (VirtualBox, VMware)
- Máquina virtual con Debian 12 (mínimo 2GB RAM, 20GB disco principal)
- Capacidad para agregar 3 discos virtuales adicionales de 1GB cada uno

### Herramientas
- Terminal Bash
- Editor de texto (nano/vim)
- Capturador de pantalla
- Calculadora para conversiones de tamaños

## Instrucciones

### Parte 1: Preparación del entorno (20 minutos)

#### 1.1 Configuración inicial de la máquina virtual
**Tarea:** Crear una VM con Debian y agregar dos discos nuevos de 1GB cada uno

**Pasos a seguir:**
- Configurar la VM con los nuevos discos
- Iniciar la máquina virtual
- Verificar que los discos están disponibles

**Comandos a utilizar:** `lsblk`, `fdisk`

**Evidencia requerida:** 
- Captura mostrando los discos detectados
- Explicación de cómo se agregaron los discos a la VM

#### 1.2 Particionado de disco
**Tarea:** En uno de los discos nuevos, crear una partición que use solo la mitad del espacio (500MB)

**Pasos a seguir:**
- Identificar el disco a particionar
- Crear una partición de 500MB
- Verificar la partición creada

**Comandos a utilizar:** `fdisk`, `parted`, `lsblk`

**Evidencia requerida:**
- Captura del proceso de particionado
- Verificación de la partición creada
- Explicación de por qué solo se usa la mitad del disco

### Parte 2: Instalación y configuración de LVM (25 minutos)

#### 2.1 Instalación del soporte LVM
**Tarea:** Instalar el paquete necesario para usar LVM en Debian

**Pasos a seguir:**
- Actualizar repositorios
- Instalar el paquete LVM2
- Verificar la instalación

**Comandos a utilizar:** `apt`, `dpkg`

**Evidencia requerida:**
- Captura del proceso de instalación
- Verificación de que LVM2 está instalado

#### 2.2 Verificación de servicios LVM
**Tarea:** Comprobar que el device mapper y el monitor de LVM están funcionando

**Pasos a seguir:**
- Verificar el estado del device mapper
- Comprobar el servicio de monitoreo LVM
- Cargar módulos si es necesario

**Comandos a utilizar:** `systemctl`, `modprobe`, `lsmod`

**Evidencia requerida:**
- Captura mostrando servicios activos
- Explicación de la función de cada servicio

### Parte 3: Creación de volúmenes físicos y grupos (30 minutos)

#### 3.1 Creación de volúmenes físicos
**Tarea:** Designar un disco completo y la partición creada como volúmenes físicos

**Pasos a seguir:**
- Crear volumen físico en el disco completo
- Crear volumen físico en la partición de 500MB
- Verificar los volúmenes físicos creados

**Comandos a utilizar:** `pvcreate`, `pvdisplay`, `pvscan`

**Evidencia requerida:**
- Captura de la creación de cada volumen físico
- Verificación con `pvdisplay`
- Explicación de la diferencia entre usar disco completo vs partición

#### 3.2 Creación del grupo de volúmenes
**Tarea:** Crear un grupo de volúmenes usando los dos volúmenes físicos

**Pasos a seguir:**
- Crear grupo de volúmenes con nombre descriptivo
- Verificar que ambos volúmenes físicos están incluidos
- Mostrar información del grupo

**Comandos a utilizar:** `vgcreate`, `vgdisplay`, `vgscan`

**Evidencia requerida:**
- Captura de la creación del grupo
- Información detallada del grupo creado
- Explicación del concepto de grupo de volúmenes

### Parte 4: Volúmenes lógicos y sistemas de archivos (35 minutos)

#### 4.1 Creación de volúmenes lógicos
**Tarea:** Crear dos volúmenes lógicos en el grupo y formatearlos con ext4

**Pasos a seguir:**
- Crear volumen lógico para "peliculas" (usar 40% del espacio disponible)
- Crear volumen lógico para "libros" (usar 50% del espacio disponible)
- Formatear ambos volúmenes con ext4
- Verificar los volúmenes creados

**Comandos a utilizar:** `lvcreate`, `lvdisplay`, `mkfs.ext4`, `lvscan`

**Evidencia requerida:**
- Captura de creación de cada volumen lógico
- Proceso de formateo con ext4
- Verificación con `lvdisplay`
- Explicación de la distribución de espacio elegida

#### 4.2 Montaje de volúmenes
**Tarea:** Montar los volúmenes lógicos en /mnt/peliculas y /mnt/libros

**Pasos a seguir:**
- Crear los directorios de montaje
- Montar cada volumen lógico
- Verificar que están montados correctamente

**Comandos a utilizar:** `mkdir`, `mount`, `df`, `lsblk`

**Evidencia requerida:**
- Captura de la creación de directorios
- Verificación de montajes con `df -h`
- Explicación de la estructura de directorios elegida

#### 4.3 Montaje permanente
**Tarea:** Configurar el montaje permanente en el sistema

**Pasos a seguir:**
- Obtener los UUID de los volúmenes lógicos
- Editar el archivo de configuración correspondiente
- Verificar la configuración

**Comandos a utilizar:** `blkid`, `nano`, `cat`

**Evidencia requerida:**
- Captura del archivo de configuración editado
- Verificación de que los montajes persisten después de reinicio
- Explicación de por qué es importante el montaje permanente

### Parte 5: Pruebas de llenado de espacio (20 minutos)

#### 5.1 Llenado del volumen de libros
**Tarea:** Llenar completamente el espacio de /mnt/libros

**Pasos a seguir:**
- Verificar espacio disponible inicial
- Crear archivos para llenar el espacio
- Comprobar que el volumen está lleno
- Intentar crear más archivos para verificar error

**Comandos a utilizar:** `df`, `dd`, `fallocate`, `touch`

**Evidencia requerida:**
- Captura del espacio antes y después de llenarlo
- Error al intentar crear más archivos
- Explicación del método utilizado para llenar el espacio

### Parte 6: Extensión dinámica de almacenamiento (40 minutos)

#### 6.1 Adición de nuevo disco
**Tarea:** Agregar un tercer disco duro de 1GB a la máquina virtual

**Pasos a seguir:**
- Agregar disco a la configuración de VM
- Detectar el nuevo disco en el sistema
- Verificar que está disponible

**Comandos a utilizar:** `lsblk`, `fdisk`, `dmesg`

**Evidencia requerida:**
- Captura mostrando el nuevo disco detectado
- Explicación del proceso de agregar discos en caliente

#### 6.2 Incorporación al grupo de volúmenes
**Tarea:** Designar el nuevo disco como volumen físico y agregarlo al grupo existente

**Pasos a seguir:**
- Crear volumen físico en el nuevo disco
- Agregar el volumen físico al grupo existente
- Verificar que el grupo tiene más espacio disponible

**Comandos a utilizar:** `pvcreate`, `vgextend`, `vgdisplay`

**Evidencia requerida:**
- Captura de la creación del nuevo volumen físico
- Adición al grupo de volúmenes
- Verificación del espacio total aumentado

#### 6.3 Extensión del volumen lógico
**Tarea:** Extender el volumen lógico de "libros" para usar el nuevo espacio

**Pasos a seguir:**
- Verificar espacio disponible en el grupo
- Extender el volumen lógico de libros
- Verificar que el volumen lógico es más grande

**Comandos a utilizar:** `lvextend`, `lvdisplay`

**Evidencia requerida:**
- Captura del proceso de extensión
- Comparación del tamaño antes y después
- Explicación de las opciones de extensión utilizadas

#### 6.4 Extensión del sistema de archivos
**Tarea:** Extender el sistema de archivos ext4 para aprovechar el nuevo espacio

**Pasos a seguir:**
- Extender el sistema de archivos en línea
- Verificar que el espacio está disponible
- Comprobar integridad del sistema de archivos

**Comandos a utilizar:** `resize2fs`, `df`, `fsck`

**Evidencia requerida:**
- Captura del proceso de extensión del filesystem
- Verificación con `df -h` del nuevo espacio
- Explicación de la diferencia entre extender LV y filesystem

### Parte 7: Verificación final (15 minutos)

#### 7.1 Prueba de funcionalidad
**Tarea:** Verificar que se pueden agregar más archivos a /mnt/libros

**Pasos a seguir:**
- Crear nuevos archivos en /mnt/libros
- Verificar que el espacio se usa correctamente
- Documentar el espacio total disponible

**Comandos a utilizar:** `touch`, `dd`, `df`, `ls`

**Evidencia requerida:**
- Captura creando archivos en el espacio extendido
- Verificación del espacio total disponible
- Comparación con el espacio inicial

#### 7.2 Resumen de la configuración final
**Tarea:** Documentar la configuración completa de LVM

**Pasos a seguir:**
- Mostrar todos los volúmenes físicos
- Mostrar información del grupo de volúmenes
- Mostrar todos los volúmenes lógicos
- Verificar montajes activos

**Comandos a utilizar:** `pvs`, `vgs`, `lvs`, `mount`

**Evidencia requerida:**
- Captura con resumen completo de LVM
- Diagrama explicativo de la configuración final


## Entregables

### 📋 Evidencias requeridas:
1. **Documento técnico** con explicación detallada de cada paso
2. **Capturas de pantalla** de todas las etapas del proceso
3. **Diagrama** de la configuración final de LVM
4. **Reflexión** sobre ventajas de LVM frente a particionado tradicional


### Ejemplo de formato para documentar:
```
Paso X: [Descripción de la tarea]
Comando utilizado: nombre_comando
Explicación: [Tu explicación de qué hiciste y por qué]
Resultado: [Qué obtuviste]
[CAPTURA DE PANTALLA]
```

### 📊 Preguntas de análisis:
1. ¿Qué ventajas ofrece LVM sobre el particionado tradicional?
2. ¿En qué situaciones recomendarías usar LVM en producción?
3. ¿Qué riesgos existen al usar LVM y cómo los mitigarías?
4. ¿Cómo afecta LVM al rendimiento del sistema?

## Criterios de evaluación

| **Criterio** | **Excelente (3)** | **Bueno (2)** | **Aceptable (1)** | **Insuficiente (0)** |
|--------------|-------------------|----------------|-------------------|----------------------|
| **Explicación técnica** | Detallada y precisa en todos los pasos | Clara en la mayoría de pasos | Básica pero comprensible | Incompleta o incorrecta |
| **Evidencia visual** | Capturas de todas las etapas con claridad | Capturas de etapas principales | Capturas básicas | Sin capturas o poco claras |
| **Funcionalidad** | LVM completamente funcional y extendido | Funcional con extensión | Funcional básico | No funcional |
| **Documentación** | Completa con diagramas y reflexión | Adecuada con análisis | Básica | Insuficiente |

## Notas

### 🚨 Consideraciones importantes:
- **Respaldos**: Siempre respalda datos importantes antes de trabajar con LVM
- **Planificación**: Diseña la estructura de volúmenes antes de implementar
- **Monitoreo**: Vigila el espacio disponible en producción

### 💡 Extensiones opcionales:
- Configurar snapshots de LVM para respaldos
- Implementar mirroring entre volúmenes físicos
- Explorar thin provisioning
- Configurar alertas de espacio bajo

### 🔧 Troubleshooting común:
- **Servicios no iniciados**: Verificar que lvm2 esté instalado y activo
- **Permisos**: Usar sudo para comandos de administración
- **Espacio insuficiente**: Verificar espacio disponible antes de crear volúmenes

**¿Listo para dominar la administración flexible de almacenamiento en Linux?**