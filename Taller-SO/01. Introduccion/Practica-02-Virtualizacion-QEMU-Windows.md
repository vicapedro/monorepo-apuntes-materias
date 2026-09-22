# Práctica 2: Virtualización con QEMU — Instalación de Windows 10 como sistema invitado

## Objetivo
Instalar y configurar un entorno de virtualización con QEMU/KVM en un sistema anfitrión Linux, y utilizarlo para instalar Windows 10 como sistema operativo invitado, comprendiendo las diferencias entre esta herramienta y un hipervisor de tipo II como VirtualBox.

**Duración estimada:** 2 horas (2 sesiones de 1 hora)

## Competencias a desarrollar
- Verifica el soporte de virtualización por hardware (Intel VT-x / AMD-V) requerido para la aceleración KVM.
- Instala y configura QEMU/KVM como herramienta de virtualización en un sistema anfitrión Linux.
- Crea un disco virtual en formato `qcow2` y una máquina virtual con firmware UEFI (OVMF) mediante línea de comandos.
- Instala un sistema operativo Windows como sistema invitado dentro de un entorno virtualizado creado con QEMU.
- Compara las características de QEMU/KVM frente a hipervisores de tipo II como VirtualBox.

## Introducción
QEMU es un emulador y virtualizador de código abierto capaz de ejecutar sistemas operativos completos como invitados. Cuando se combina con **KVM** (Kernel-based Virtual Machine, integrado en el kernel de Linux desde 2007), QEMU puede aprovechar la aceleración por hardware del procesador (Intel VT-x / AMD-V) para ofrecer un rendimiento cercano al nativo, en lugar de emular completamente el hardware por software.

A diferencia de VirtualBox —un hipervisor de tipo II con interfaz gráfica orientado a facilidad de uso—, QEMU se administra tradicionalmente por línea de comandos, lo que permite comprender con mayor profundidad los componentes que conforman una máquina virtual: el firmware de arranque (BIOS o UEFI), el formato del disco virtual, la memoria asignada, el procesador virtual y los dispositivos emulados. Esta práctica retoma los conceptos vistos en [1.3 Virtualizacion.md](../1.3%20Virtualizacion.md) sobre tipos de hipervisor y virtualización nativa, aplicándolos con una herramienta distinta a la usada en la práctica de VirtualBox.

## Equipo de protección e higiene
- Mantener el espacio de trabajo ordenado y libre de objetos innecesarios.
- Usar el equipo de cómputo con cuidado, sin forzar conexiones ni dispositivos externos.
- No interrumpir procesos de instalación de forma abrupta (apagado forzado) salvo indicación explícita, para evitar corrupción del disco virtual.
- Trabajar con responsabilidad, respetando las indicaciones del instructor y el uso compartido del laboratorio.

## Material y equipo necesario

### Materiales e insumos
- Bitácora o documento de reporte técnico para registrar capturas y observaciones.
- Conexión a internet para descargar los paquetes de QEMU y la imagen ISO oficial de evaluación de Windows 10.

### Equipo de laboratorio
- Computadora con una distribución Linux instalada como sistema anfitrión (por ejemplo, Ubuntu, Debian o Fedora).
- Procesador con soporte de virtualización por hardware (Intel VT-x / AMD-V) **habilitado en el BIOS/UEFI** del equipo físico.
- Mínimo 8 GB de RAM (4 GB para el anfitrión y 4 GB para la máquina virtual).
- Mínimo 40 GB de espacio libre en disco para el disco virtual y la imagen ISO.

### Herramientas
- Paquete `qemu-system-x86` (o `qemu-kvm`, según la distribución) y `qemu-utils`.
- Paquete de firmware **OVMF** (UEFI para máquinas virtuales).
- Herramienta `cpu-checker` (comando `kvm-ok`) o verificación manual con `/proc/cpuinfo`.
- Terminal y editor de texto.
- Imagen ISO de evaluación de **Windows 10 Enterprise** (90 días), obtenida de forma legal desde el Centro de Evaluación de Microsoft.

## Instrucciones

### Parte 1: Verificación del soporte de virtualización por hardware (10 min)
1. Abre una terminal en el sistema anfitrión Linux.
2. Verifica que el procesador soporte virtualización por hardware:
   ```bash
   egrep -c '(vmx|svm)' /proc/cpuinfo
   ```
   Un resultado mayor a `0` indica soporte (vmx = Intel VT-x, svm = AMD-V).
3. Instala y ejecuta `kvm-ok` para confirmar que KVM puede utilizarse:
   ```bash
   sudo apt install cpu-checker   # En distribuciones basadas en Debian/Ubuntu
   kvm-ok
   ```
4. Si el resultado indica que la aceleración KVM no está disponible, verifica que la virtualización esté habilitada en el BIOS/UEFI del equipo físico antes de continuar.

### Parte 2: Instalación de QEMU/KVM y OVMF (10 min)
1. Instala los paquetes necesarios según tu distribución:
   ```bash
   # Debian/Ubuntu
   sudo apt update
   sudo apt install qemu-system-x86 qemu-utils ovmf

   # Fedora
   sudo dnf install qemu-kvm qemu-img edk2-ovmf
   ```
2. Verifica que tu usuario pertenezca al grupo `kvm` (o `libvirt`, según distribución) para poder usar la aceleración sin privilegios de superusuario:
   ```bash
   groups $USER
   sudo usermod -aG kvm $USER
   ```
   Cierra sesión y vuelve a iniciarla para que el cambio de grupo surta efecto.
3. Localiza los archivos de firmware OVMF instalados (normalmente en `/usr/share/OVMF/` o `/usr/share/edk2/ovmf/`):
   ```bash
   ls /usr/share/OVMF/
   ```

### Parte 3: Obtención de la imagen ISO de Windows 10 (10 min)
1. Descarga la imagen ISO de **Windows 10 Enterprise (evaluación de 90 días)** desde el Centro de Evaluación de Microsoft (buscar "Windows 10 Enterprise evaluation" en el sitio oficial `microsoft.com`). Este método es legal y no requiere clave de producto durante el periodo de evaluación.
2. Guarda el archivo descargado como `win10.iso` en tu directorio de trabajo de la práctica.

### Parte 4: Creación del disco virtual (10 min)
1. Crea un directorio de trabajo para la práctica y colócate dentro de él:
   ```bash
   mkdir -p ~/practica-qemu-win10
   cd ~/practica-qemu-win10
   ```
2. Crea el disco virtual en formato `qcow2` con 60 GB de capacidad (el espacio se asigna dinámicamente, no se reserva todo de inmediato):
   ```bash
   qemu-img create -f qcow2 win10.qcow2 60G
   ```
3. Verifica la información del disco creado:
   ```bash
   qemu-img info win10.qcow2
   ```

### Parte 5: Preparación del firmware UEFI (5 min)
1. Copia el archivo de variables de OVMF a tu directorio de trabajo (para no modificar el archivo compartido del sistema):
   ```bash
   cp /usr/share/OVMF/OVMF_VARS.fd ./OVMF_VARS.fd
   ```

### Parte 6: Arranque de la máquina virtual e instalación de Windows 10 (30 min)
1. Inicia la máquina virtual apuntando al disco virtual, la imagen ISO y el firmware UEFI:
   ```bash
   qemu-system-x86_64 \
     -enable-kvm \
     -m 4096 \
     -smp 2 \
     -cpu host \
     -drive if=pflash,format=raw,readonly=on,file=/usr/share/OVMF/OVMF_CODE.fd \
     -drive if=pflash,format=raw,file=OVMF_VARS.fd \
     -drive file=win10.qcow2,format=qcow2 \
     -cdrom win10.iso \
     -boot d \
     -vga std \
     -display gtk
   ```
   **Nota sobre los parámetros:** `-enable-kvm` activa la aceleración por hardware; `-m` asigna la RAM en MB; `-smp` asigna núcleos virtuales; `-cpu host` expone las características del procesador físico a la VM; `-boot d` indica arrancar primero desde el CD-ROM (la ISO).
2. Sigue el asistente de instalación de Windows 10: idioma y región, "Instalar ahora", omitir clave de producto (modo evaluación), aceptar términos de licencia, seleccionar instalación personalizada, y elegir el disco virtual de 60 GB como destino.
3. Espera a que el instalador copie archivos y reinicie automáticamente (QEMU continuará ejecutándose; no cierres la ventana).
4. Completa la configuración inicial de Windows: región, distribución de teclado, cuenta local (evita iniciar sesión con cuenta Microsoft para simplificar la práctica).

### Parte 7: Primer arranque y verificación (10 min)
1. Una vez dentro de Windows, abre el **Administrador de dispositivos** y verifica si existe algún dispositivo sin controlador (ícono de advertencia). Documenta cuáles.
2. Abre una terminal de comandos (`cmd`) dentro de Windows y ejecuta:
   ```
   systeminfo
   ```
   Toma una captura de pantalla de la salida, prestando atención a la RAM y el procesador detectados.
3. Apaga Windows correctamente desde el menú de inicio (Apagar), permitiendo que QEMU finalice la ejecución.

### Parte 8: Reutilización de la máquina virtual sin la ISO (10 min)
1. Vuelve a iniciar la máquina virtual, esta vez sin montar la ISO de instalación, para arrancar directamente desde el disco virtual:
   ```bash
   qemu-system-x86_64 \
     -enable-kvm \
     -m 4096 \
     -smp 2 \
     -cpu host \
     -drive if=pflash,format=raw,readonly=on,file=/usr/share/OVMF/OVMF_CODE.fd \
     -drive if=pflash,format=raw,file=OVMF_VARS.fd \
     -drive file=win10.qcow2,format=qcow2 \
     -vga std \
     -display gtk
   ```
2. Confirma que Windows arranca directamente sin pasar por el instalador.

### Producto esperado
Reporte técnico que incluya:
- Capturas de la verificación de soporte KVM (`kvm-ok` o `/proc/cpuinfo`).
- Capturas del comando `qemu-img info` mostrando el disco virtual creado.
- Capturas del proceso de instalación de Windows 10 (al menos 3 pasos clave).
- Captura de la salida de `systeminfo` dentro de la VM.
- Breve comparación (5-8 líneas) entre la experiencia de usar QEMU por línea de comandos frente a VirtualBox: ventajas, desventajas y qué tipo de usuario usaría cada uno.

## Notas
- Si la VM no logra iniciar por falta de aceleración KVM, es posible continuar la práctica sin `-enable-kvm`, pero la instalación de Windows será considerablemente más lenta.
- El archivo `win10.qcow2` creado en esta práctica puede reutilizarse en actividades posteriores relacionadas con el tema de snapshots (ver [1.3.3 Snapshots.md](../1.3.3%20Snapshots.md)), ya que el formato `qcow2` soporta instantáneas internas mediante `qemu-img snapshot`.
- Conserva la imagen ISO de Windows 10 y el archivo `win10.qcow2`; no los elimines al finalizar, salvo que el docente indique lo contrario.
- Recuerda que el uso de la ISO de evaluación de Windows 10 tiene una vigencia de 90 días y debe obtenerse únicamente desde el sitio oficial de Microsoft.
