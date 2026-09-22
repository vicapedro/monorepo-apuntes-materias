# Práctica 1.1: Creación de una máquina virtual

## Objetivo

Crear y configurar una máquina virtual en VirtualBox, instalar un sistema operativo invitado desde una imagen ISO y comprobar que el sistema inicia correctamente con los recursos virtuales asignados.

**Duración estimada:** 2 horas (2 sesiones de 1 hora)

## Competencias a desarrollar

- Identifica los componentes básicos de una solución de virtualización: anfitrión, invitado, hipervisor, memoria, procesador, almacenamiento y red.
- Configura una máquina virtual de acuerdo con los requerimientos mínimos del sistema operativo invitado.
- Instala un sistema operativo en un entorno virtual y documenta el procedimiento mediante evidencias verificables.
- Reconoce la importancia de conservar una configuración reproducible para las prácticas posteriores de snapshots y red.

## Introducción

Una máquina virtual es un entorno de software que emula los componentes principales de una computadora física y permite ejecutar un sistema operativo invitado sobre un sistema operativo anfitrión. VirtualBox funciona como hipervisor y administra los recursos asignados a la máquina virtual, como memoria RAM, procesadores virtuales, disco y adaptador de red.

Esta práctica es la primera de la serie de virtualización. La máquina creada y el sistema operativo instalado se reutilizarán en las prácticas siguientes:

- **Práctica 1.2:** Gestión de Snapshots.
- **Práctica 1.3:** Configuración de Red.
- **Práctica 1.5:** Snapshots y desempeño.

## Equipo de protección e higiene

- Mantén ordenada el área de trabajo y evita desconectar el equipo durante la instalación.
- No apagues forzosamente el sistema anfitrión mientras la máquina virtual esté escribiendo en el disco.
- Utiliza únicamente imágenes ISO obtenidas de fuentes oficiales o autorizadas por el docente.
- No incluyas contraseñas, claves de producto ni datos personales en las capturas del reporte.

## Material y equipo necesario

### Equipo de laboratorio

- Computadora con VirtualBox instalado y permisos para crear máquinas virtuales.
- Procesador con virtualización por hardware habilitada en BIOS/UEFI cuando sea necesario.
- Mínimo recomendado: 8 GB de RAM y 40 GB de espacio libre en disco.
- Conexión a internet, si se requiere descargar VirtualBox, la ISO o actualizaciones.

### Herramientas y archivos

- VirtualBox, preferentemente en una versión vigente disponible en el laboratorio.
- Imagen ISO legal del sistema operativo invitado. Se puede utilizar Windows 10, una distribución Linux u otra imagen autorizada por el docente.
- Documento de reporte para integrar capturas, descripciones y respuestas de verificación.

## Instrucciones

### 1. Verificación inicial

1. Abre VirtualBox y confirma la versión instalada.
2. Verifica que el equipo tenga habilitada la virtualización por hardware cuando VirtualBox lo indique.
3. Crea una carpeta de trabajo para conservar la máquina virtual y el reporte de la serie.

**Punto de evidencia E1:** captura la ventana principal de VirtualBox donde se observe la versión o la interfaz de administración. No captures otras máquinas virtuales si contienen información ajena.

### 2. Creación de la máquina virtual

1. Selecciona **Nueva**.
2. Asigna un nombre con el formato `Apellido_Nombre_SO`, sin espacios ni datos sensibles.
3. Selecciona el tipo y la versión que correspondan al sistema operativo invitado.
4. Asigna memoria RAM suficiente para el invitado sin comprometer la estabilidad del anfitrión. Como referencia, utiliza entre 2 y 4 GB para un sistema operativo de escritorio, según los recursos disponibles.
5. Asigna uno o dos procesadores virtuales, de acuerdo con la capacidad del equipo anfitrión.
6. Selecciona **Crear un disco duro virtual ahora**.
7. Utiliza el formato VDI, almacenamiento dinámico y una capacidad mínima de 20 GB, o la recomendada por el sistema operativo invitado.

**Punto de evidencia E2:** captura el resumen de configuración o la pantalla final de creación donde se observen claramente el nombre de la máquina, el tipo de sistema, la memoria, los procesadores y el tamaño/formato del disco.

### 3. Configuración de la imagen ISO

1. Selecciona la máquina virtual y abre **Configuración**.
2. En **Almacenamiento**, selecciona la unidad óptica vacía.
3. Monta la imagen ISO autorizada por el docente.
4. En **Sistema**, revisa el orden de arranque y confirma que la máquina pueda iniciar desde la unidad óptica.
5. En **Red**, conserva inicialmente la configuración predeterminada de NAT. La configuración de red detallada se realizará en la Práctica 1.3.

**Punto de evidencia E3:** captura la pantalla de almacenamiento donde se vea la unidad óptica y el nombre de la ISO montada. Si la ruta contiene información personal, recórtala sin ocultar el nombre del archivo.

### 4. Instalación del sistema operativo invitado

1. Inicia la máquina virtual y sigue el instalador del sistema operativo.
2. Selecciona idioma, región y teclado según las indicaciones del docente.
3. Elige el disco virtual creado en el paso anterior como destino de instalación.
4. Espera a que concluya la copia de archivos y los reinicios automáticos.
5. Completa la configuración inicial con una cuenta de laboratorio. No utilices cuentas personales.

**Punto de evidencia E4:** captura una pantalla del instalador donde se observe el disco virtual seleccionado o una etapa clara de la instalación.

**Punto de evidencia E5:** captura el primer escritorio o pantalla de inicio del sistema invitado ya instalado. Debe ser visible la interfaz del sistema y, cuando sea posible, el nombre de la máquina virtual.

### 5. Verificación y preparación para la serie

1. Apaga el sistema invitado desde su menú de apagado; no cierres VirtualBox de forma forzada.
2. Retira la ISO de la unidad óptica virtual o configura el arranque desde el disco duro virtual.
3. Inicia nuevamente la máquina virtual y confirma que arranque sin utilizar el instalador.
4. Registra en el reporte la memoria, los procesadores, el tamaño del disco y el sistema operativo instalado.
5. Conserva la máquina virtual con el mismo nombre para utilizarla en las prácticas siguientes.

**Punto de evidencia E6:** captura el sistema invitado funcionando después del segundo arranque, sin la pantalla del instalador. Incluye una ventana o herramienta del sistema que permita comprobar el nombre del equipo y los recursos asignados.

## Reglas para las capturas de pantalla

- Cada captura debe mostrar con claridad qué se está haciendo: ventana, menú, parámetro, comando o resultado relevante.
- No se aceptan capturas borrosas, recortadas de manera que oculten el contexto, repetidas o tomadas de otra práctica.
- Numera las imágenes como `E1`, `E2`, `E3`, `E4`, `E5` y `E6`, en el mismo orden en que aparecen en el reporte.
- Debajo de cada imagen escribe una descripción de dos a cuatro líneas que indique: qué se observa, qué acción se realizó y por qué esa evidencia demuestra el cumplimiento del paso.
- Cuando una captura no sea legible, agrega una transcripción breve de los valores visibles.

### Formato obligatorio de descripción

**E#: [Nombre de la evidencia]**  
**Descripción:** [Indica qué ventana o resultado se observa, qué configuración o acción demuestra y cuál es su relación con el objetivo de la práctica.]  
**Resultado:** [Escribe el valor o condición que se verificó.]

## Evidencias y producto esperado

Entrega un reporte en PDF o en el formato indicado por el docente que incluya, en este orden:

1. Portada con nombre, grupo, fecha y nombre de la práctica.
2. Tabla breve con las características del equipo anfitrión y de la máquina virtual: sistema anfitrión, sistema invitado, RAM, procesadores, disco y versión de VirtualBox.
3. Las seis evidencias visuales `E1` a `E6`, cada una con su descripción obligatoria.
4. Respuestas de verificación:
	- ¿Qué función cumple el hipervisor en esta práctica?
	- ¿Qué diferencia existe entre el sistema anfitrión y el sistema invitado?
	- ¿Por qué no se debe asignar toda la memoria RAM del equipo anfitrión a la máquina virtual?
	- ¿Qué configuración deberá conservarse para que las prácticas posteriores trabajen sobre la misma máquina?
5. Conclusión de cinco a ocho líneas sobre los problemas encontrados, las soluciones aplicadas y la utilidad de la virtualización para administrar sistemas operativos.

## Criterios de evaluación

| Criterio | Ponderación |
|---|---:|
| Creación y configuración funcional de la máquina virtual | 25% |
| Instalación y verificación del sistema operativo invitado | 20% |
| Evidencias visuales completas, legibles y ordenadas | 25% |
| Descripción técnica de cada captura | 15% |
| Respuestas de verificación y conclusión | 15% |
| **Total** | **100%** |

## Notas

- Si se utiliza otro sistema operativo invitado, conserva los mismos objetivos y documenta cualquier diferencia en el reporte.
- No elimines la máquina virtual al terminar: será la base de las prácticas de snapshots, configuración de red y desempeño.
- Si VirtualBox muestra un error de virtualización, registra el mensaje y solicita autorización antes de cambiar opciones del BIOS/UEFI.
- Las capturas deben corresponder al trabajo realizado por quien entrega el reporte.

