# Práctica 1.3: Configuración de Red

## Objetivo

Configurar y comparar los modos de red **NAT**, **adaptador puente** y **solo-anfitrión** en VirtualBox, comprobando mediante pruebas funcionales qué dispositivos y servicios puede alcanzar la máquina virtual en cada modo.

**Duración estimada:** 2 horas (2 sesiones de 1 hora)

## Competencias a desarrollar

- Identifica las características y el propósito de los principales modos de red de VirtualBox.
- Configura el adaptador de red de una máquina virtual sin alterar la configuración del equipo anfitrión.
- Comprueba conectividad, direccionamiento IP, resolución de nombres y alcance entre dispositivos.
- Interpreta las diferencias entre acceso a Internet, comunicación con el anfitrión y pertenencia a la red física.
- Documenta configuraciones y resultados mediante capturas de pantalla legibles y descripciones técnicas.

## Introducción

VirtualBox permite conectar una máquina virtual mediante distintos modos de red. Cada modo determina cómo obtiene su dirección IP y con qué sistemas puede comunicarse:

| Modo | Característica principal | Alcance esperado |
|---|---|---|
| **NAT** | VirtualBox traduce las conexiones de la VM hacia la red del anfitrión. | Acceso a Internet; normalmente no permite conexiones entrantes directas desde la red física hacia la VM. |
| **Adaptador puente** | La VM aparece como otro equipo dentro de la red física del anfitrión. | Comunicación con el anfitrión, otros equipos de la LAN e Internet, según la política de la red. |
| **Solo-anfitrión** | La VM se conecta a una red virtual privada entre el anfitrión y las máquinas virtuales asociadas. | Comunicación con el anfitrión y otras VMs de esa red; por sí sola no proporciona acceso a Internet. |

Esta práctica utiliza la máquina virtual creada en la **Práctica 1.1: Creación de una máquina virtual**. Los snapshots de la **Práctica 1.2: Gestión de Snapshots** pueden utilizarse para regresar a un estado conocido si una configuración queda incorrecta. Al finalizar, se dejará NAT como configuración base para la **Práctica 1.5: Snapshots y desempeño**.

## Equipo de protección e higiene

- Realiza los cambios de red con la máquina virtual apagada, salvo que el docente indique lo contrario.
- No modifiques la configuración de red del sistema anfitrión más allá de crear el adaptador solo-anfitrión solicitado.
- No captures ni publiques contraseñas, claves de red, direcciones públicas u otros datos sensibles.
- Si utilizas una red institucional, respeta sus políticas y evita realizar escaneos o pruebas no autorizadas.
- Devuelve la configuración de la máquina virtual a NAT al finalizar.

## Material y equipo necesario

### Equipo de laboratorio

- Computadora con VirtualBox instalado.
- Máquina virtual creada en la Práctica 1.1 y sistema operativo invitado funcionando.
- Conexión a una red con acceso a Internet para las pruebas de NAT y, si está permitido, de adaptador puente.
- Permisos para crear un adaptador de red solo-anfitrión en VirtualBox.

### Herramientas

- Panel **Configuración > Red** de VirtualBox.
- Terminal o símbolo del sistema dentro de la máquina virtual.
- Herramientas `ipconfig` en Windows o `ip addr` en Linux.
- Herramientas `ping`, `nslookup` o `dig`, según el sistema operativo invitado.
- Navegador web para comprobar acceso HTTP/HTTPS.
- Documento de reporte para capturas, descripciones y tabla comparativa.

## Preparación de las pruebas

1. Inicia la máquina virtual y abre una terminal.
2. Identifica el comando disponible para consultar la configuración IP:
	- Windows: `ipconfig /all`
	- Linux: `ip addr` y `ip route`
3. Identifica la dirección IP del anfitrión. En Windows puede consultarse con `ipconfig`; en Linux, con `ip addr`.
4. En cada modo registra: dirección IP de la VM, máscara, puerta de enlace, servidores DNS, resultado de las pruebas y alcance observado.
5. Si el sistema invitado conserva una configuración anterior, renueva la dirección DHCP antes de probar:
	- Windows: `ipconfig /release` y `ipconfig /renew`
	- Linux: utiliza el mecanismo DHCP disponible en la distribución o reinicia la interfaz de red.

## Instrucciones

### 1. Configuración y prueba del modo NAT

1. Apaga la máquina virtual correctamente.
2. En VirtualBox, abre **Configuración > Red > Adaptador 1**.
3. Activa el adaptador y selecciona **NAT** en **Conectado a**.
4. Inicia la máquina virtual y consulta su configuración IP.
5. Abre un sitio web autorizado por el docente para comprobar el acceso a Internet.

**Prueba extra NAT: resolución DNS y puerta de enlace**

6. Ejecuta una prueba contra la puerta de enlace que aparezca en la configuración IP:
	- Windows: `ping <puerta_de_enlace>`
	- Linux: `ping -c 4 <puerta_de_enlace>`
7. Comprueba la resolución de nombres:
	- Windows: `nslookup example.com`
	- Linux: `dig example.com` o `nslookup example.com`
8. Registra si la puerta de enlace responde y qué servidor DNS resolvió el nombre. No continúes hasta tener una captura de la configuración y de los resultados.

**Evidencias NAT**

- **E1:** captura la configuración de VirtualBox donde se observe el modo NAT.
- **E2:** captura la terminal o herramienta de red con la IP, la puerta de enlace y el DNS, junto con el resultado de `ping` y `nslookup`/`dig`. La captura debe permitir relacionar los resultados con la VM.
- **E3:** captura el navegador mostrando que el sitio autorizado cargó correctamente.

### 2. Configuración y prueba del adaptador puente

1. Apaga la máquina virtual.
2. En **Configuración > Red > Adaptador 1**, selecciona **Adaptador puente**.
3. En **Nombre**, elige el adaptador físico que utiliza el anfitrión: Wi-Fi o Ethernet, según corresponda.
4. Inicia la máquina virtual y consulta nuevamente su configuración IP.
5. Compara la dirección de red de la VM con la del anfitrión. En condiciones normales, ambas pertenecen a la misma red, aunque sus direcciones IP deben ser distintas.
6. Comprueba el acceso a Internet desde el navegador.

**Prueba extra de adaptador puente: comunicación dentro de la LAN**

7. Ejecuta un `ping` desde la VM hacia la dirección IP del anfitrión:
	- Windows: `ping <IP-del-anfitrión>`
	- Linux: `ping -c 4 <IP-del-anfitrión>`
8. Ejecuta un `ping` desde la VM hacia la puerta de enlace de la red física.
9. Registra si la VM es identificada como un equipo independiente de la LAN y explica cualquier bloqueo del firewall que impida responder al ping.

**Evidencias de adaptador puente**

- **E4:** captura la configuración de VirtualBox donde se observe **Adaptador puente** y el adaptador físico seleccionado.
- **E5:** captura la configuración IP de la VM y del anfitrión, o una tabla del reporte donde se comparen ambas, junto con el `ping` al anfitrión y a la puerta de enlace.
- **E6:** captura el navegador mostrando el acceso a Internet desde la VM en modo puente.

### 3. Configuración y prueba del modo solo-anfitrión

1. Apaga la máquina virtual.
2. En VirtualBox, abre **Archivo > Herramientas > Administrador de red del anfitrión**. En versiones anteriores puede aparecer como **Archivo > Preferencias > Red**.
3. Crea un adaptador solo-anfitrión si no existe uno y conserva la configuración DHCP predeterminada, salvo indicación del docente.
4. En la configuración de la VM, selecciona **Adaptador solo-anfitrión** y elige el adaptador creado.
5. Inicia la máquina virtual y consulta su dirección IP. Debe pertenecer a la red privada del adaptador solo-anfitrión.

**Prueba extra de solo-anfitrión: comunicación con el anfitrión y aislamiento de Internet**

6. Ejecuta un `ping` desde la VM hacia la dirección IP del anfitrión en la red solo-anfitrión.
7. Intenta resolver un nombre y acceder a un sitio web. Registra que el acceso a Internet no está disponible por este adaptador aislado, si esa es la configuración observada.
8. Si existe una segunda VM conectada al mismo adaptador solo-anfitrión, ejecuta un `ping` hacia su dirección IP. No crees una segunda VM únicamente para esta prueba.
9. Explica en el reporte la diferencia entre que la VM tenga comunicación con el anfitrión y que tenga acceso a Internet.

**Evidencias de solo-anfitrión**

- **E7:** captura la configuración de VirtualBox donde se observe **Adaptador solo-anfitrión** y el nombre del adaptador virtual.
- **E8:** captura la configuración IP de la VM y el `ping` exitoso al anfitrión en la red privada.
- **E9:** captura el resultado de la prueba de aislamiento: el intento de acceso a Internet o resolución de nombres sin conectividad, acompañado de una explicación en el reporte. Si se utilizó una segunda VM, incluye también el `ping` entre VMs.

### 4. Restauración de la configuración base

1. Apaga la máquina virtual.
2. Configura nuevamente el **Adaptador 1** en modo **NAT**.
3. Inicia la VM y verifica que tenga conectividad a Internet.
4. Conserva esta configuración para la Práctica 1.5.

**Evidencia E10:** captura la configuración final en NAT y una prueba breve de conectividad. Esta evidencia confirma que la VM quedó preparada para la siguiente práctica.

## Reglas para las capturas de pantalla

- Cada captura debe mostrar claramente qué se está configurando o comprobando: ventana de VirtualBox, adaptador seleccionado, dirección IP, comando y resultado.
- No se aceptan capturas borrosas, repetidas, recortadas de manera que oculten el contexto o tomadas de otra máquina virtual.
- Numera las evidencias como `E1` a `E10` en el mismo orden en que aparecen en el reporte.
- Una captura puede mostrar varios datos únicamente si todos son legibles; no reduzcas la imagen hasta ocultar direcciones, comandos o resultados.
- Debajo de cada imagen escribe una descripción de dos a cuatro líneas.
- Si el resultado esperado no se obtiene, conserva la captura, describe el error y explica la causa o la acción correctiva.

### Formato obligatorio de descripción

**E#: [Nombre de la evidencia]**  
**Descripción:** [Indica qué ventana, configuración, comando o resultado se observa y qué acción se realizó.]  
**Interpretación:** [Explica qué demuestra la evidencia sobre el modo de red probado.]  
**Resultado:** [Escribe el valor o condición verificada, incluyendo la IP o el mensaje relevante cuando corresponda.]

## Tabla de resultados

Completa esta tabla después de realizar las pruebas:

| Modo de red | IP de la VM | Puerta de enlace | DNS | Acceso a Internet | Ping al anfitrión | Prueba extra y resultado |
|---|---|---|---|---|---|---|
| NAT | | | | | | DNS y puerta de enlace |
| Adaptador puente | | | | | | Comunicación con anfitrión y LAN |
| Solo-anfitrión | | | | | | Aislamiento de Internet y comunicación privada |

## Evidencias y producto esperado

Entrega un reporte en PDF o en el formato indicado por el docente que incluya:

1. Portada con nombre, grupo, fecha y título de la práctica.
2. Nombre de la máquina virtual y sistema operativo invitado.
3. La tabla de resultados completa.
4. Las evidencias `E1` a `E10`, cada una con su captura y descripción obligatoria.
5. Respuestas breves:
	- ¿Por qué NAT permite normalmente salir a Internet sin exponer directamente la VM en la red física?
	- ¿Qué diferencia observaste entre la dirección IP de la VM en NAT y en adaptador puente?
	- ¿Por qué el modo solo-anfitrión puede comunicarse con el anfitrión, pero no necesariamente con Internet?
	- ¿Qué modo elegirías para una VM que necesita ser visible como un equipo más de la red local? Justifica.
	- ¿Qué configuración debe conservarse para continuar con la Práctica 1.5?
6. Una conclusión de ocho a diez líneas que compare los tres modos y explique qué prueba fue más útil para distinguirlos.

## Criterios de evaluación

| Criterio | Ponderación |
|---|---:|
| Configuración correcta de NAT, puente y solo-anfitrión | 25% |
| Ejecución e interpretación de la prueba extra de cada modo | 25% |
| Tabla comparativa y respuestas de análisis | 15% |
| Evidencias visuales completas, legibles y ordenadas | 20% |
| Descripción técnica de cada captura | 10% |
| Conclusión y recuperación de la configuración base | 5% |
| **Total** | **100%** |

## Notas

- Los nombres de los menús pueden variar entre versiones de VirtualBox; utiliza la función equivalente.
- Un `ping` bloqueado por firewall no demuestra por sí solo que no exista conectividad. Considera también la dirección IP, la puerta de enlace, DNS y el acceso web.
- En una red institucional, el adaptador puente puede no recibir dirección IP o puede tener restricciones; documenta el resultado sin modificar la red.
- No elimines la máquina virtual ni los snapshots de la serie. Deja el adaptador en NAT para la Práctica 1.5.


