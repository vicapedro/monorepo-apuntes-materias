# Práctica 1.2: Gestión de Snapshots

## Objetivo

Crear, identificar, restaurar y eliminar snapshots de una máquina virtual en VirtualBox, comprobando cómo cada snapshot conserva un estado de referencia y cómo la restauración devuelve la máquina a ese estado.

**Duración estimada:** 1 hora (1 sesión)

## Competencias a desarrollar

- Explica la función de un snapshot como punto de recuperación de una máquina virtual.
- Crea snapshots con nombres y descripciones que permitan identificar el estado guardado.
- Comprueba los efectos de una modificación antes y después de restaurar un snapshot.
- Gestiona snapshots de forma responsable, considerando el consumo de almacenamiento y el riesgo de perder cambios posteriores.
- Documenta estados, acciones y resultados mediante evidencias visuales.

## Introducción

Un **snapshot** o instantánea es un punto de recuperación que registra el estado de una máquina virtual en un momento determinado. En VirtualBox, el disco virtual original sirve como referencia y los cambios posteriores pueden almacenarse en archivos diferenciales. Al restaurar un snapshot, la máquina vuelve al estado que tenía cuando se creó ese punto, por lo que los cambios realizados después pueden dejar de estar disponibles.

Los snapshots son útiles para probar configuraciones, aplicaciones o cambios de sistema sin tener que reconstruir la máquina virtual. No sustituyen un respaldo independiente: dependen de los archivos de la máquina virtual y una cadena extensa de snapshots puede consumir espacio y complicar la administración.

Esta práctica utiliza la máquina virtual creada en la **Práctica 1.1: Creación de una máquina virtual**. La máquina debe conservarse para la **Práctica 1.3: Configuración de Red** y la **Práctica 1.5: Snapshots y desempeño**.

## Equipo de protección e higiene

- Cierra correctamente el sistema operativo invitado antes de crear o eliminar snapshots, salvo que el docente indique una prueba con la máquina encendida.
- No apagues forzosamente el equipo anfitrión mientras VirtualBox esté creando, restaurando o eliminando un snapshot.
- Verifica el nombre de la máquina virtual antes de ejecutar una restauración o eliminación.
- No elimines el snapshot base hasta haber confirmado que la práctica fue documentada.
- No incluyas contraseñas, claves de producto ni información personal en las capturas.

## Material y equipo necesario

### Equipo de laboratorio

- Computadora con VirtualBox instalado.
- Máquina virtual creada en la Práctica 1.1 y con el sistema operativo invitado funcionando.
- Espacio libre suficiente para conservar los discos diferenciales generados por VirtualBox.

### Herramientas y archivos

- Documento de reporte para integrar las capturas y sus descripciones.
- Una cuenta de laboratorio dentro del sistema invitado.
- Un archivo de texto de prueba y, opcionalmente, una aplicación pequeña autorizada por el docente.

## Instrucciones

### 1. Verificación de la máquina virtual

1. Abre VirtualBox y selecciona la máquina virtual creada en la Práctica 1.1.
2. Confirma que el nombre de la máquina sea el correcto y que el sistema invitado esté apagado.
3. Comprueba que existe espacio libre suficiente en el equipo anfitrión.
4. Abre el administrador de snapshots de VirtualBox.

**Punto de evidencia E1:** captura la máquina virtual seleccionada y el administrador de snapshots antes de crear el primer snapshot. Debe observarse el nombre correcto de la VM y el estado inicial del árbol de snapshots.

### 2. Creación del snapshot base

1. Con la máquina virtual apagada, selecciona **Tomar snapshot**.
2. Utiliza el nombre `S1-Estado-inicial`.
3. En la descripción registra el sistema operativo instalado y la fecha de creación.
4. Confirma la operación y espera a que VirtualBox termine.

**Punto de evidencia E2:** captura el árbol de snapshots donde aparezca `S1-Estado-inicial` y la descripción registrada. La captura debe mostrar que el snapshot corresponde a la máquina virtual de esta práctica.

### 3. Crear un cambio verificable

1. Inicia la máquina virtual desde el snapshot base.
2. Dentro del sistema invitado, crea en el escritorio un archivo llamado `evidencia-snapshot.txt`.
3. Escribe dentro del archivo la fecha y la leyenda `Cambio posterior a S1`.
4. Guarda el archivo y toma una captura dentro del sistema invitado donde se observe el archivo y su contenido.
5. Apaga correctamente la máquina virtual.

**Punto de evidencia E3:** captura el archivo `evidencia-snapshot.txt` abierto o visible en el escritorio, con su contenido legible. Esta captura demuestra el cambio realizado después de crear `S1-Estado-inicial`.

### 4. Crear un segundo snapshot

1. En VirtualBox, selecciona la máquina virtual y abre el administrador de snapshots.
2. Crea un snapshot con el nombre `S2-Archivo-creado`.
3. En la descripción indica que el archivo `evidencia-snapshot.txt` ya existe y que este es el estado de recuperación esperado.
4. Espera a que concluya la operación.

**Punto de evidencia E4:** captura el árbol de snapshots donde se observen `S1-Estado-inicial` y `S2-Archivo-creado`, junto con la descripción del segundo snapshot.

### 5. Realizar un cambio adicional

1. Inicia la máquina virtual desde el estado actual.
2. Instala una aplicación pequeña autorizada por el docente o crea una segunda modificación visible, como una carpeta llamada `cambio-posterior-S2`.
3. Comprueba que el cambio esté presente dentro del sistema invitado.
4. Apaga correctamente la máquina virtual.

**Punto de evidencia E5:** captura el sistema invitado mostrando claramente el cambio posterior a `S2-Archivo-creado`. Si instalaste una aplicación, muestra su ventana o su presencia en la lista de aplicaciones.

### 6. Restaurar el snapshot anterior

1. Abre el administrador de snapshots.
2. Selecciona `S2-Archivo-creado` y revisa cuidadosamente que sea el punto que deseas restaurar.
3. Selecciona **Restaurar** y confirma la operación.
4. Inicia la máquina virtual.
5. Comprueba que `evidencia-snapshot.txt` continúe presente.
6. Comprueba que el cambio realizado después de `S2` ya no esté presente o explica cualquier diferencia observada.

**Punto de evidencia E6:** captura el administrador de snapshots después de la restauración y otra vista del sistema invitado donde se compruebe que el archivo de `S2` está presente y que el cambio posterior ya no aparece. Si incluyes dos imágenes, identifícalas como `E6a` y `E6b`.

### 7. Eliminar un snapshot

1. Apaga la máquina virtual y abre el administrador de snapshots.
2. Selecciona únicamente el snapshot que el docente indique para eliminar. No elimines `S2-Archivo-creado` antes de completar la verificación.
3. Lee la advertencia de VirtualBox: eliminar un snapshot no necesariamente elimina el estado actual de la máquina, pero puede consolidar archivos y borrar la posibilidad de volver a ese punto específico.
4. Confirma la eliminación y espera a que VirtualBox termine.
5. Verifica que la máquina virtual conserve el estado esperado y que el árbol de snapshots esté actualizado.

**Punto de evidencia E7:** captura el árbol de snapshots después de la eliminación y la máquina virtual seleccionada. Debe ser posible identificar qué snapshot permaneció y cuál fue eliminado.

## Reglas para las capturas de pantalla

- Cada captura debe mostrar con claridad la ventana, menú, snapshot, archivo, aplicación o resultado que se está comprobando.
- No se aceptan capturas borrosas, repetidas, recortadas de forma que oculten el contexto o tomadas de otra máquina virtual.
- Numera las evidencias como `E1` a `E7`; cuando una evidencia requiera dos imágenes, utiliza `E6a` y `E6b`.
- Debajo de cada imagen escribe una descripción de dos a cuatro líneas.
- La descripción debe explicar qué se observa, qué acción se realizó y por qué la imagen demuestra el resultado del paso.
- Si un dato no se distingue en la captura, agrega una transcripción breve; no sustituyas la captura por una explicación escrita.

### Formato obligatorio de descripción

**E#: [Nombre de la evidencia]**  
**Descripción:** [Indica qué ventana o resultado se observa, qué acción demuestra y cómo se relaciona con el objetivo de la práctica.]  
**Resultado:** [Escribe el estado verificado: snapshot creado, archivo presente, cambio revertido, snapshot eliminado, etcétera.]

## Evidencias y producto esperado

Entrega un reporte en PDF o en el formato indicado por el docente que incluya:

1. Portada con nombre, grupo, fecha y título de la práctica.
2. Nombre de la máquina virtual y sistema operativo invitado.
3. Una breve tabla con los snapshots creados, su propósito y su estado final.
4. Las evidencias `E1` a `E7`, cada una con su captura y descripción obligatoria.
5. Una respuesta breve a estas preguntas:
	- ¿Qué estado quedó guardado en `S1-Estado-inicial`?
	- ¿Qué diferencia existe entre `S1-Estado-inicial` y `S2-Archivo-creado`?
	- ¿Qué ocurrió con el cambio realizado después de `S2` al restaurar ese snapshot?
	- ¿Por qué un snapshot no debe considerarse un respaldo independiente?
	- ¿Qué riesgos existen al acumular muchos snapshots?
6. Una conclusión de cinco a ocho líneas sobre la utilidad y las limitaciones de los snapshots.

## Criterios de evaluación

| Criterio | Ponderación |
|---|---:|
| Creación y nomenclatura correcta de snapshots | 20% |
| Comprobación de cambios antes y después de la restauración | 25% |
| Administración responsable del snapshot eliminado | 15% |
| Evidencias visuales completas, legibles y ordenadas | 20% |
| Descripción técnica de cada captura | 10% |
| Respuestas y conclusión | 10% |
| **Total** | **100%** |

## Notas

- Los nombres y descripciones son parte de la evidencia; no utilices nombres genéricos como `Snapshot 1`.
- La restauración puede descartar cambios posteriores. Verifica siempre el snapshot seleccionado antes de confirmar.
- Conserva la máquina virtual y el snapshot que indique el docente para continuar con la Práctica 1.3 y la Práctica 1.5.
- La ubicación exacta de los botones puede cambiar entre versiones de VirtualBox; identifica la función equivalente sin modificar el objetivo de la práctica.
