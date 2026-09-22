# Práctica 2 (versión Windows): Virtualización con QEMU — Instalación de Windows 10 como sistema invitado (anfitrión Windows)

> Esta es una adaptación de [Practica-02-Virtualizacion-QEMU-Windows.md](Practica-02-Virtualizacion-QEMU-Windows.md) para estudiantes cuyo equipo tiene **Windows como sistema anfitrión** en lugar de Linux. Los objetivos, competencias y producto esperado son los mismos; cambian las herramientas de instalación y el mecanismo de aceleración por hardware.

## Objetivo
Instalar y configurar un entorno de virtualización con QEMU en un sistema anfitrión Windows, utilizando la aceleración por hardware **WHPX (Windows Hypervisor Platform)**, y usarlo para instalar Windows 10 como sistema operativo invitado, comprendiendo las diferencias entre esta herramienta y un hipervisor de tipo II como VirtualBox.

**Duración estimada:** 2 horas (2 sesiones de 1 hora)

## Competencias a desarrollar
- Verifica el soporte de virtualización por hardware (Intel VT-x / AMD-V) y la disponibilidad de la Plataforma de Hipervisor de Windows (WHPX).
- Instala y configura QEMU para Windows como herramienta de virtualización.
- Crea un disco virtual en formato `qcow2` y una máquina virtual con firmware UEFI (OVMF) mediante línea de comandos.
- Instala un sistema operativo Windows como sistema invitado dentro de un entorno virtualizado creado con QEMU.
- Compara las características de QEMU/WHPX frente a hipervisores de tipo II como VirtualBox.

## Introducción
QEMU es un emulador y virtualizador de código abierto capaz de ejecutar sistemas operativos completos como invitados. En Linux, QEMU se acelera típicamente con **KVM**; en Windows, el mecanismo equivalente de aceleración por hardware es **WHPX (Windows Hypervisor Platform)**, una característica opcional de Windows que permite a QEMU aprovechar las extensiones de virtualización del procesador (Intel VT-x / AMD-V) de forma similar a como lo hace Hyper-V.

A diferencia de VirtualBox —un hipervisor de tipo II con interfaz gráfica orientado a facilidad de uso—, QEMU se administra tradicionalmente por línea de comandos, lo que permite comprender con mayor profundidad los componentes que conforman una máquina virtual: el firmware de arranque (BIOS o UEFI), el formato del disco virtual, la memoria asignada, el procesador virtual y los dispositivos emulados. Esta práctica retoma los conceptos vistos en [1.3 Virtualizacion.md](../1.3%20Virtualizacion.md) sobre tipos de hipervisor y virtualización nativa, aplicándolos con una herramienta distinta a la usada en la práctica de VirtualBox.

**Nota importante sobre compatibilidad:** WHPX requiere que la infraestructura de virtualización de Windows (la misma que usa Hyper-V) esté activa. Si en el equipo ya está instalado VirtualBox y se usó anteriormente con su propio motor de virtualización, es posible que sea necesario habilitar la opción "Usar Hyper-V" en VirtualBox, o reiniciar el equipo después de activar las características de Windows, para que ambas herramientas convivan sin conflicto.

## Equipo de protección e higiene
- Mantener el espacio de trabajo ordenado y libre de objetos innecesarios.
- Usar el equipo de cómputo con cuidado, sin forzar conexiones ni dispositivos externos.
- No interrumpir procesos de instalación de forma abrupta (apagado forzado) salvo indicación explícita, para evitar corrupción del disco virtual.
- Trabajar con responsabilidad, respetando las indicaciones del instructor y el uso compartido del laboratorio.

## Material y equipo necesario

### Materiales e insumos
- Bitácora o documento de reporte técnico para registrar capturas y observaciones.
- Conexión a internet para descargar el instalador de QEMU y la imagen ISO oficial de evaluación de Windows 10.

### Equipo de laboratorio
- Computadora con **Windows 10 o Windows 11** instalado como sistema anfitrión, con permisos de administrador.
- Procesador con soporte de virtualización por hardware (Intel VT-x / AMD-V) **habilitado en el BIOS/UEFI** del equipo físico.
- Mínimo 8 GB de RAM (4 GB para el anfitrión y 4 GB para la máquina virtual).
- Mínimo 40 GB de espacio libre en disco para el disco virtual y la imagen ISO.

### Herramientas
- Instalador de **QEMU para Windows** (descarga oficial desde `qemu.org`, sección de descargas para Windows).
- Firmware **OVMF/EDK2** (se incluye dentro del instalador de QEMU para Windows, en la subcarpeta `share` de la instalación).
- PowerShell (incluido en Windows) para habilitar características opcionales y ejecutar QEMU.
- Imagen ISO de evaluación de **Windows 10 Enterprise** (90 días), obtenida de forma legal desde el Centro de Evaluación de Microsoft.

## Instrucciones

### Parte 1: Verificación del soporte de virtualización por hardware (10 min)
1. Abre el **Administrador de tareas** (`Ctrl + Shift + Esc`), ve a la pestaña **Rendimiento** → **CPU**, y verifica que el campo **Virtualización** indique **Habilitado**. Si indica "Deshabilitado", debe activarse desde el BIOS/UEFI del equipo antes de continuar.
2. Como verificación adicional, abre una terminal de **PowerShell** y ejecuta:
   ```powershell
   systeminfo | Select-String "Hyper-V"
   ```
   Revisa que los requisitos de Hyper-V (extensión de monitor de VM, virtualización habilitada en firmware, traducción de direcciones de segundo nivel) aparezcan como "Sí" o "Yes".

### Parte 2: Habilitación de la Plataforma de Hipervisor de Windows (WHPX) (10 min)
1. Abre PowerShell **como administrador** y habilita las características necesarias:
   ```powershell
   Enable-WindowsOptionalFeature -Online -FeatureName HypervisorPlatform -All -NoRestart
   Enable-WindowsOptionalFeature -Online -FeatureName VirtualMachinePlatform -All -NoRestart
   ```
2. Reinicia el equipo para que los cambios surtan efecto.
3. Después de reiniciar, confirma que las características quedaron habilitadas:
   ```powershell
   Get-WindowsOptionalFeature -Online -FeatureName HypervisorPlatform
   ```
   El campo `State` debe mostrar `Enabled`.

### Parte 3: Instalación de QEMU para Windows (10 min)
1. Descarga el instalador de QEMU para Windows (arquitectura de 64 bits) desde la página oficial de QEMU (`qemu.org` → Download → Windows).
2. Ejecuta el instalador con permisos de administrador y completa la instalación con las opciones por defecto, anotando la carpeta de instalación (por ejemplo, `C:\Program Files\qemu\`).
3. Verifica la instalación abriendo PowerShell y ejecutando:
   ```powershell
   & "C:\Program Files\qemu\qemu-system-x86_64.exe" --version
   ```
4. Localiza los archivos de firmware UEFI dentro de la carpeta `share` de la instalación (los nombres pueden variar según la versión, por ejemplo `edk2-x86_64-code.fd` o `OVMF_CODE.fd`):
   ```powershell
   dir "C:\Program Files\qemu\share\" | Select-String "edk2|OVMF"
   ```

### Parte 4: Obtención de la imagen ISO de Windows 10 (10 min)
1. Descarga la imagen ISO de **Windows 10 Enterprise (evaluación de 90 días)** desde el Centro de Evaluación de Microsoft (buscar "Windows 10 Enterprise evaluation" en el sitio oficial `microsoft.com`). Este método es legal y no requiere clave de producto durante el periodo de evaluación.
2. Crea una carpeta de trabajo para la práctica y guarda ahí el archivo descargado como `win10.iso`:
   ```powershell
   New-Item -ItemType Directory -Path "C:\practica-qemu-win10"
   ```

### Parte 5: Creación del disco virtual y preparación del firmware (10 min)
1. Colócate en la carpeta de trabajo:
   ```powershell
   cd C:\practica-qemu-win10
   ```
2. Crea el disco virtual en formato `qcow2` con 60 GB de capacidad (el espacio se asigna dinámicamente):
   ```powershell
   & "C:\Program Files\qemu\qemu-img.exe" create -f qcow2 win10.qcow2 60G
   ```
3. Verifica la información del disco creado:
   ```powershell
   & "C:\Program Files\qemu\qemu-img.exe" info win10.qcow2
   ```
4. Copia el archivo de variables de UEFI a la carpeta de trabajo (para no modificar el archivo compartido de la instalación), ajustando el nombre según lo encontrado en la Parte 3:
   ```powershell
   Copy-Item "C:\Program Files\qemu\share\edk2-i386-vars.fd" ".\OVMF_VARS.fd"
   ```

### Parte 6: Arranque de la máquina virtual e instalación de Windows 10 (30 min)
1. Desde la carpeta de trabajo, inicia la máquina virtual apuntando al disco virtual, la imagen ISO y el firmware UEFI:
   ```powershell
   & "C:\Program Files\qemu\qemu-system-x86_64.exe" `
     -accel whpx `
     -m 4096 `
     -smp 2 `
     -cpu max `
     -drive if=pflash,format=raw,readonly=on,file="C:\Program Files\qemu\share\edk2-x86_64-code.fd" `
     -drive if=pflash,format=raw,file=".\OVMF_VARS.fd" `
     -drive file=win10.qcow2,format=qcow2 `
     -cdrom win10.iso `
     -boot d `
     -vga std `
     -display sdl
   ```
   **Nota sobre los parámetros:** `-accel whpx` activa la aceleración por hardware mediante la Plataforma de Hipervisor de Windows; `-cpu max` expone el mayor conjunto de características de CPU compatible con WHPX; el resto de parámetros (`-m`, `-smp`, `-boot d`) cumplen la misma función que en la versión Linux de la práctica.
   
   **Si la ventana no abre o aparece un error de "no display"**, prueba cambiando `-display sdl` por `-display gtk`, o elimínalo para usar el valor por defecto de tu instalación de QEMU.
2. Sigue el asistente de instalación de Windows 10: idioma y región, "Instalar ahora", omitir clave de producto (modo evaluación), aceptar términos de licencia, seleccionar instalación personalizada, y elegir el disco virtual de 60 GB como destino.
3. Espera a que el instalador copie archivos y reinicie automáticamente (QEMU continuará ejecutándose; no cierres la ventana).
4. Completa la configuración inicial de Windows: región, distribución de teclado, cuenta local (evita iniciar sesión con cuenta Microsoft para simplificar la práctica).

### Parte 7: Primer arranque y verificación (10 min)
1. Una vez dentro de Windows (invitado), abre el **Administrador de dispositivos** y verifica si existe algún dispositivo sin controlador (ícono de advertencia). Documenta cuáles.
2. Abre una terminal de comandos (`cmd`) dentro de la VM y ejecuta:
   ```
   systeminfo
   ```
   Toma una captura de pantalla de la salida, prestando atención a la RAM y el procesador detectados.
3. Apaga Windows correctamente desde el menú de inicio (Apagar), permitiendo que QEMU finalice la ejecución.

### Parte 8: Reutilización de la máquina virtual sin la ISO (10 min)
1. Vuelve a iniciar la máquina virtual, esta vez sin montar la ISO de instalación, para arrancar directamente desde el disco virtual:
   ```powershell
   & "C:\Program Files\qemu\qemu-system-x86_64.exe" `
     -accel whpx `
     -m 4096 `
     -smp 2 `
     -cpu max `
     -drive if=pflash,format=raw,readonly=on,file="C:\Program Files\qemu\share\edk2-x86_64-code.fd" `
     -drive if=pflash,format=raw,file=".\OVMF_VARS.fd" `
     -drive file=win10.qcow2,format=qcow2 `
     -vga std `
     -display sdl
   ```
2. Confirma que Windows arranca directamente sin pasar por el instalador.

### Producto esperado
Reporte técnico que incluya:
- Captura de la verificación de virtualización en el Administrador de tareas y/o `systeminfo`.
- Captura de la confirmación de WHPX habilitado (`Get-WindowsOptionalFeature`).
- Capturas del comando `qemu-img info` mostrando el disco virtual creado.
- Capturas del proceso de instalación de Windows 10 (al menos 3 pasos clave).
- Captura de la salida de `systeminfo` dentro de la VM invitada.
- Breve comparación (5-8 líneas) entre la experiencia de usar QEMU por línea de comandos frente a VirtualBox: ventajas, desventajas y qué tipo de usuario usaría cada uno.

## Notas
- Si WHPX no está disponible (por ejemplo, en Windows Home o equipos sin virtualización habilitada en firmware), es posible continuar la práctica omitiendo `-accel whpx`, pero la instalación de Windows será considerablemente más lenta al usar emulación por software (TCG).
- Los nombres de los archivos de firmware UEFI incluidos con QEMU para Windows han variado entre versiones (`OVMF_CODE.fd`/`OVMF_VARS.fd` en versiones antiguas, `edk2-x86_64-code.fd`/`edk2-i386-vars.fd` en versiones recientes). Verifica siempre el contenido real de la carpeta `share` de tu instalación antes de ejecutar los comandos.
- El archivo `win10.qcow2` creado en esta práctica puede reutilizarse en actividades posteriores relacionadas con el tema de snapshots (ver [1.3.3 Snapshots.md](../1.3.3%20Snapshots.md)), ya que el formato `qcow2` soporta instantáneas internas mediante `qemu-img snapshot`.
- Conserva la imagen ISO de Windows 10 y el archivo `win10.qcow2`; no los elimines al finalizar, salvo que el docente indique lo contrario.
- Recuerda que el uso de la ISO de evaluación de Windows 10 tiene una vigencia de 90 días y debe obtenerse únicamente desde el sitio oficial de Microsoft.
