# Práctica: Traducción de Direcciones de Red (NAT)

## Objetivo

Configurar y analizar los diferentes tipos de NAT (Network Address Translation) en un router empresarial, implementando DHCP para asignación dinámica de direcciones IP en la red local y verificando el comportamiento de las traducciones mediante el análisis de logs del servidor web y la tabla de traducciones NAT.

**Duración estimada:** 3 horas

## Competencias a desarrollar

- Configura servicios de NAT estático, dinámico y PAT en routers para permitir la conectividad entre redes privadas y públicas
- Implementa servicios DHCP en dispositivos de red para la asignación automática de direcciones IP
- Analiza el comportamiento de las traducciones NAT mediante herramientas de diagnóstico y logs de servidor
- Interpreta la tabla de traducciones NAT para comprender el mapeo entre direcciones privadas y públicas
- Evalúa las ventacias y limitaciones de cada tipo de NAT en escenarios empresariales reales

## Introducción

La Traducción de Direcciones de Red (NAT) es una tecnología fundamental en redes modernas que permite a múltiples dispositivos en una red privada compartir una o más direcciones IP públicas para acceder a Internet. NAT fue desarrollado inicialmente para abordar el agotamiento del espacio de direcciones IPv4, pero también proporciona una capa adicional de seguridad al ocultar la estructura interna de la red.

### Tipos de NAT

**1. NAT Estático (Static NAT)**
- Mapeo uno a uno entre dirección privada y pública
- La misma dirección pública se asigna siempre a la misma dirección privada
- Ideal para servidores que necesitan ser accesibles desde Internet
- No proporciona conservación de direcciones IP

**2. NAT Dinámico (Dynamic NAT)**
- Mapeo de direcciones privadas a un pool de direcciones públicas
- Las asignaciones son temporales y se liberan cuando la conexión termina
- Proporciona cierta conservación de direcciones IP
- Requiere tantas direcciones públicas como conexiones simultáneas

**3. PAT - Port Address Translation (NAT Overload)**
- Múltiples direcciones privadas comparten una única dirección pública
- Diferencia las conexiones mediante números de puerto
- Máxima conservación de direcciones IP
- El tipo más común en redes empresariales y domésticas

### Funcionamiento de NAT

NAT opera en la capa 3 (Red) del modelo OSI y modifica las direcciones IP en los encabezados de los paquetes. El router mantiene una tabla de traducciones que registra:
- Dirección IP local interna (inside local)
- Dirección IP global interna (inside global)
- Puerto de origen y destino (en caso de PAT)
- Protocolo utilizado (TCP/UDP/ICMP)

### Terminología NAT

- **Inside Local**: Dirección IP asignada a un host en la red interna (dirección privada)
- **Inside Global**: Dirección IP pública que representa una o más direcciones inside local
- **Outside Local**: Dirección IP de un host externo tal como aparece en la red interna
- **Outside Global**: Dirección IP pública asignada a un host en la red externa

### Integración con DHCP

La combinación de NAT y DHCP es común en redes empresariales. El router actúa como:
- **Servidor DHCP**: Asigna automáticamente direcciones IP privadas a los hosts internos
- **Gateway NAT**: Traduce las direcciones privadas a públicas para acceso a Internet

## Equipo de protección e higiene

No aplica para esta práctica de simulación en laboratorio de cómputo.

## Material y equipo necesario

### Materiales e insumos
- Computadora con acceso a Cisco Packet Tracer 8.0 o superior
- Acceso a Internet para consulta de documentación
- Libreta técnica para registro de observaciones

### Equipo de laboratorio
- Software: Cisco Packet Tracer (simulación)
- Mínimo 4 GB de RAM
- 500 MB de espacio disponible en disco

### Herramientas
- Cisco Packet Tracer 8.0+
- Navegador web simulado en Packet Tracer
- Terminal de comandos IOS de Cisco

### Nota importante sobre la realización de la práctica

**Esta práctica puede realizarse en dos modalidades:**

1. **Simulación en Packet Tracer** (recomendado para inicio)
   - Todas las instrucciones detalladas en este documento están orientadas a Cisco Packet Tracer
   - Permite realizar la práctica sin riesgo de afectar equipos reales
   - Ideal para familiarizarse con los conceptos antes de implementar en equipos físicos

2. **Implementación en laboratorio con equipos físicos**
   - La práctica puede adaptarse para ejecutarse con routers Cisco reales (modelos 1841, 2811, 2901, 2911 o superiores)
   - Se requiere acceso al laboratorio de redes con equipos físicos
   - Las configuraciones IOS son las mismas, pero deberá considerar:
     - Disponibilidad de interfaces físicas en los equipos
     - Cableado estructurado adecuado
     - Acceso por consola o SSH a los dispositivos
     - Configuración de PCs cliente con adaptadores de red
     - Servidor web real (puede usar Apache, Nginx o IIS)
   - Consulte con el instructor la disponibilidad de equipamiento y topología adaptada

**Si realiza la práctica en laboratorio físico, adapte los nombres de interfaces y direcciones IP según los equipos disponibles.**

## Instrucciones

### Parte 1: Construcción de la Topología

**1.1** Abra Cisco Packet Tracer y cree la siguiente topología:

**Dispositivos necesarios:**
- 4 Routers (Router-PT o modelo 2911)
- 1 Switch (Switch-PT-Empty o modelo 2960)
- 3 PCs (PC-PT)
- 1 Servidor (Server-PT)

**Conexiones:**

```
[PC1]      192.168.1.0/24          ISP                Internet
[PC2]---[Switch]---[RouterEmpresa]---[RouterISP]---[RouterInternet]---[WebServer]
[PC3]                    |              |               |              200.34.149.100
                    Fa0/0 .1        S0/0/0          S0/0/0
                                   200.1.1.0/30    200.34.149.0/29
```

**1.2** Realice las siguientes conexiones físicas:

| Dispositivo Origen | Interfaz | Dispositivo Destino | Interfaz | Tipo Cable |
|-------------------|----------|---------------------|----------|------------|
| PC1 | FastEthernet0 | Switch0 | FastEthernet0/1 | Straight-Through |
| PC2 | FastEthernet0 | Switch0 | FastEthernet0/2 | Straight-Through |
| PC3 | FastEthernet0 | Switch0 | FastEthernet0/3 | Straight-Through |
| Switch0 | FastEthernet0/24 | RouterEmpresa | FastEthernet0/0 | Straight-Through |
| RouterEmpresa | Serial0/0/0 | RouterISP | Serial0/0/0 | Serial DCE |
| RouterISP | Serial0/0/1 | RouterInternet | Serial0/0/0 | Serial DCE |
| RouterInternet | FastEthernet0/0 | WebServer | FastEthernet0 | Straight-Through |

**1.3** Capture de pantalla de la topología completa con todos los dispositivos conectados.

### Parte 2: Configuración Básica de los Routers

**2.1 Configuración del Router de la Empresa**

```
Router>enable
Router#configure terminal
Router(config)#hostname RouterEmpresa
RouterEmpresa(config)#no ip domain-lookup
RouterEmpresa(config)#enable secret cisco123

! Configurar interfaz LAN
RouterEmpresa(config)#interface fastEthernet 0/0
RouterEmpresa(config-if)#description Red LAN Empresa
RouterEmpresa(config-if)#ip address 192.168.1.1 255.255.255.0
RouterEmpresa(config-if)#no shutdown
RouterEmpresa(config-if)#exit

! Configurar interfaz WAN hacia ISP
RouterEmpresa(config)#interface serial 0/0/0
RouterEmpresa(config-if)#description Enlace al ISP
RouterEmpresa(config-if)#ip address 200.1.1.2 255.255.255.252
RouterEmpresa(config-if)#clock rate 64000
RouterEmpresa(config-if)#no shutdown
RouterEmpresa(config-if)#exit

! Configurar ruta por defecto
RouterEmpresa(config)#ip route 0.0.0.0 0.0.0.0 200.1.1.1

! Guardar configuración
RouterEmpresa(config)#exit
RouterEmpresa#copy running-config startup-config
```

**2.2 Configuración del Router del ISP**

```
Router>enable
Router#configure terminal
Router(config)#hostname RouterISP
RouterISP(config)#no ip domain-lookup
RouterISP(config)#enable secret cisco123

! Configurar interfaz hacia empresa
RouterISP(config)#interface serial 0/0/0
RouterISP(config-if)#description Enlace Cliente Empresa
RouterISP(config-if)#ip address 200.1.1.1 255.255.255.252
RouterISP(config-if)#no shutdown
RouterISP(config-if)#exit

! Configurar interfaz hacia Internet
RouterISP(config)#interface serial 0/0/1
RouterISP(config-if)#description Enlace a Internet
RouterISP(config-if)#ip address 200.34.149.1 255.255.255.248
RouterISP(config-if)#clock rate 64000
RouterISP(config-if)#no shutdown
RouterISP(config-if)#exit

! Configurar enrutamiento
RouterISP(config)#ip route 192.168.1.0 255.255.255.0 200.1.1.2
RouterISP(config)#ip route 0.0.0.0 0.0.0.0 200.34.149.2

RouterISP(config)#exit
RouterISP#copy running-config startup-config
```

**2.3 Configuración del Router de Internet**

```
Router>enable
Router#configure terminal
Router(config)#hostname RouterInternet
RouterInternet(config)#no ip domain-lookup
RouterInternet(config)#enable secret cisco123

! Configurar interfaz hacia ISP
RouterInternet(config)#interface serial 0/0/0
RouterInternet(config-if)#description Enlace desde ISP
RouterInternet(config-if)#ip address 200.34.149.2 255.255.255.248
RouterInternet(config-if)#no shutdown
RouterInternet(config-if)#exit

! Configurar interfaz LAN con servidor web
RouterInternet(config)#interface fastEthernet 0/0
RouterInternet(config-if)#description Red de Servicios Internet
RouterInternet(config-if)#ip address 200.34.149.97 255.255.255.240
RouterInternet(config-if)#no shutdown
RouterInternet(config-if)#exit

! Configurar ruta por defecto
RouterInternet(config)#ip route 0.0.0.0 0.0.0.0 200.34.149.1

RouterInternet(config)#exit
RouterInternet#copy running-config startup-config
```

**2.4** Capture de pantalla mostrando la configuración de interfaces con el comando:
```
RouterEmpresa#show ip interface brief
```

### Parte 3: Configuración del Servidor DHCP en el Router de la Empresa

**3.1** Configure el servicio DHCP en el RouterEmpresa:

```
RouterEmpresa#configure terminal

! Excluir direcciones reservadas
RouterEmpresa(config)#ip dhcp excluded-address 192.168.1.1 192.168.1.10

! Crear pool DHCP
RouterEmpresa(config)#ip dhcp pool LAN-EMPRESA
RouterEmpresa(dhcp-config)#network 192.168.1.0 255.255.255.0
RouterEmpresa(dhcp-config)#default-router 192.168.1.1
RouterEmpresa(dhcp-config)#dns-server 8.8.8.8
RouterEmpresa(dhcp-config)#domain-name empresa.local
RouterEmpresa(dhcp-config)#lease 7
RouterEmpresa(dhcp-config)#exit

RouterEmpresa(config)#exit
RouterEmpresa#copy running-config startup-config
```

**3.2** Configure las PCs para obtener direcciones por DHCP:
- En cada PC, vaya a Desktop → IP Configuration
- Seleccione DHCP en lugar de Static
- Espere a que la PC obtenga una dirección IP

**3.3** Verifique las asignaciones DHCP:
```
RouterEmpresa#show ip dhcp binding
```

**3.4** Capture de pantalla mostrando:
- Las direcciones IP asignadas a las 3 PCs
- El resultado del comando `show ip dhcp binding`

**3.5** Desde cada PC, verifique la conectividad al gateway:
```
C:\> ping 192.168.1.1
```

### Parte 4: Configuración del Servidor Web

**4.1** Configure el servidor web con dirección IP estática:
- IP Address: 200.34.149.100
- Subnet Mask: 255.255.255.240
- Default Gateway: 200.34.149.97

**4.2** Active el servicio HTTP:
- Desktop → Services → HTTP
- Verifique que el servicio esté activo (ON)

**4.3** Personalice la página web:
- Edite el archivo index.html con el siguiente contenido:
```html
<html>
<head><title>Servidor Web - Practica NAT</title></head>
<body>
<h1>Bienvenido al Servidor Web</h1>
<h2>Practica de NAT</h2>
<p>Este servidor registra las direcciones IP de los clientes que acceden.</p>
<p>Servidor: 200.34.149.100</p>
</body>
</html>
```

**4.4** Capture de pantalla del servidor web configurado.

### Parte 5: Configuración de NAT Estático

**5.1** Configure NAT estático para la PC1 en el RouterEmpresa:

```
RouterEmpresa#configure terminal

! Definir interfaz inside (interna)
RouterEmpresa(config)#interface fastEthernet 0/0
RouterEmpresa(config-if)#ip nat inside
RouterEmpresa(config-if)#exit

! Definir interfaz outside (externa)
RouterEmpresa(config)#interface serial 0/0/0
RouterEmpresa(config-if)#ip nat outside
RouterEmpresa(config-if)#exit

! Configurar NAT estático para PC1
! Asumiendo que PC1 obtuvo 192.168.1.11
RouterEmpresa(config)#ip nat inside source static 192.168.1.11 200.1.1.2

RouterEmpresa(config)#exit
```

**5.2** Verifique la configuración NAT:
```
RouterEmpresa#show ip nat translations
RouterEmpresa#show ip nat statistics
```

**5.3** Pruebe la conectividad desde PC1 al servidor web:
- Abra el navegador web en PC1
- Acceda a http://200.34.149.100
- Capture de pantalla del navegador mostrando la página web

**5.4** En el servidor web, verifique los logs de acceso:
- Desktop → Services → HTTP
- Revise la sección de logs

**5.5** Capture de pantalla mostrando:
- La tabla de traducciones NAT (`show ip nat translations`)
- Los logs del servidor web con la dirección IP registrada

**Pregunta 1:** ¿Qué dirección IP aparece en los logs del servidor web? ¿Es la dirección privada de PC1 o la dirección pública del router? Explique por qué.

### Parte 6: Configuración de NAT Dinámico con Pool

**6.1** Elimine la configuración de NAT estático:

```
RouterEmpresa#configure terminal
RouterEmpresa(config)#no ip nat inside source static 192.168.1.11 200.1.1.2
```

**6.2** Para esta práctica, necesitamos simular que el ISP nos asignó un rango de direcciones públicas. Modificaremos la configuración:

```
! Configurar un pool de direcciones NAT
! Usaremos un rango simulado: 200.1.1.10 - 200.1.1.13
RouterEmpresa(config)#ip nat pool POOL-PUBLICO 200.1.1.10 200.1.1.13 netmask 255.255.255.240

! Crear una ACL para definir qué direcciones privadas se traducirán
RouterEmpresa(config)#access-list 1 permit 192.168.1.0 0.0.0.255

! Asociar la ACL con el pool NAT
RouterEmpresa(config)#ip nat inside source list 1 pool POOL-PUBLICO

RouterEmpresa(config)#exit
```

**Nota:** En Packet Tracer, esta configuración funcionará para propósitos educativos. En un entorno real, las direcciones del pool deben ser enrutables en Internet.

**6.3** Ajuste las rutas en RouterISP para el rango NAT:

```
RouterISP#configure terminal
RouterISP(config)#ip route 200.1.1.8 255.255.255.240 200.1.1.2
RouterISP(config)#exit
```

**6.4** Desde las 3 PCs, acceda simultáneamente al servidor web:
- PC1: http://200.34.149.100
- PC2: http://200.34.149.100
- PC3: http://200.34.149.100

**6.5** En RouterEmpresa, verifique las traducciones activas:
```
RouterEmpresa#show ip nat translations
RouterEmpresa#show ip nat statistics
```

**6.6** Capture de pantalla mostrando:
- La tabla de traducciones NAT con las 3 PCs
- Las estadísticas NAT

**Pregunta 2:** ¿Cuántas direcciones públicas se están utilizando? ¿Qué pasaría si tuviéramos 5 PCs pero solo 4 direcciones en el pool?

**6.7** Limpie las traducciones NAT:
```
RouterEmpresa#clear ip nat translation *
```

### Parte 7: Configuración de PAT (NAT Overload)

**7.1** Elimine la configuración de NAT dinámico:

```
RouterEmpresa#configure terminal
RouterEmpresa(config)#no ip nat inside source list 1 pool POOL-PUBLICO
RouterEmpresa(config)#no ip nat pool POOL-PUBLICO
```

**7.2** Configure PAT usando la interfaz serial:

```
! La ACL 1 ya existe, si no crearla nuevamente
RouterEmpresa(config)#access-list 1 permit 192.168.1.0 0.0.0.255

! Configurar PAT usando overload
RouterEmpresa(config)#ip nat inside source list 1 interface serial 0/0/0 overload

RouterEmpresa(config)#exit
RouterEmpresa#copy running-config startup-config
```

**7.3** Limpie las traducciones anteriores:
```
RouterEmpresa#clear ip nat translation *
```

**7.4** Desde cada PC, realice múltiples conexiones al servidor web:
- Abra el navegador y acceda a http://200.34.149.100
- Luego, desde Command Prompt, ejecute:
```
C:\> ping 200.34.149.100
```

**7.5** En RouterEmpresa, observe las traducciones PAT:
```
RouterEmpresa#show ip nat translations
RouterEmpresa#show ip nat translations verbose
```

**7.6** Capture de pantalla mostrando la tabla de traducciones NAT con PAT.

**Pregunta 3:** ¿Cómo diferencia el router las conexiones de las diferentes PCs si todas usan la misma dirección IP pública? Identifique en la tabla de traducciones los números de puerto.

**7.7** Analice las estadísticas detalladas:
```
RouterEmpresa#show ip nat statistics
```

**7.8** Capture de pantalla de las estadísticas NAT.

### Parte 8: Análisis de la Tabla de Traducciones NAT

**8.1** Desde PC1, genere tráfico hacia el servidor web:
```
C:\> ping -n 20 200.34.149.100
```

**8.2** Mientras el ping está activo, en RouterEmpresa ejecute:
```
RouterEmpresa#show ip nat translations
```

**8.3** Identifique en la salida del comando:
- Inside local (dirección privada origen)
- Inside global (dirección pública asignada)
- Outside local (dirección destino)
- Outside global (dirección destino pública)
- Protocolo utilizado (ICMP, TCP, UDP)
- Puertos involucrados

**8.4** Complete la siguiente tabla con base en sus observaciones:

| PC | Inside Local | Inside Global | Outside Global | Protocolo | Puerto Local | Puerto Global |
|----|--------------|---------------|----------------|-----------|--------------|---------------|
| PC1 | | | 200.34.149.100 | | | |
| PC2 | | | 200.34.149.100 | | | |
| PC3 | | | 200.34.149.100 | | | |

**Pregunta 4:** ¿Cuánto tiempo permanecen activas las traducciones NAT? ¿Qué sucede cuando finaliza el timeout?

### Parte 9: Verificación en el Servidor Web

**9.1** En el servidor web, acceda a los logs HTTP:
- Desktop → Services → HTTP
- Revise la sección de Access Log

**9.2** Observe las direcciones IP registradas en el log del servidor.

**9.3** Capture de pantalla del log del servidor web.

**Pregunta 5:** ¿Puede el servidor web distinguir entre las diferentes PCs que están detrás del NAT? ¿Por qué?

**Pregunta 6:** Desde la perspectiva de seguridad, ¿qué ventajas ofrece NAT a la red interna?

### Parte 10: Análisis Comparativo de los Tipos de NAT

**10.1** Complete la siguiente tabla comparativa basándose en su experiencia en la práctica:

| Característica | NAT Estático | NAT Dinámico | PAT (Overload) |
|----------------|--------------|--------------|----------------|
| Direcciones públicas requeridas | | | |
| Conservación de IPs | | | |
| Mapeo | | | |
| Uso típico | | | |
| Visibilidad desde Internet | | | |
| Escalabilidad | | | |

**10.2** Responda las siguientes preguntas de análisis:

**Pregunta 7:** ¿En qué escenario sería preferible usar NAT estático en lugar de PAT?

**Pregunta 8:** Si una empresa tiene 200 empleados pero solo 10 direcciones IP públicas, ¿qué tipo de NAT debería implementar y por qué?

**Pregunta 9:** ¿Cuál es la principal desventaja de NAT desde el punto de vista del modelo de extremo a extremo de Internet?

### Parte 11: Comandos de Diagnóstico y Troubleshooting

**11.1** Practique los siguientes comandos de diagnóstico NAT:

```
! Ver traducciones activas
RouterEmpresa#show ip nat translations

! Ver estadísticas generales
RouterEmpresa#show ip nat statistics

! Limpiar traducciones dinámicas
RouterEmpresa#clear ip nat translation *

! Limpiar una traducción específica
RouterEmpresa#clear ip nat translation inside 192.168.1.11

! Habilitar debug de NAT (usar con precaución)
RouterEmpresa#debug ip nat
RouterEmpresa#debug ip nat detailed

! Deshabilitar debug
RouterEmpresa#undebug all
```

**11.2** Active el debug de NAT brevemente y genere tráfico desde una PC:
```
RouterEmpresa#debug ip nat detailed
```

**11.3** Desde PC1, ejecute un ping al servidor web.

**11.4** Observe la salida del debug y luego desactívelo:
```
RouterEmpresa#undebug all
```

**11.5** Capture de pantalla de la salida del debug NAT.

**Pregunta 10:** ¿Qué información adicional proporciona el debug de NAT que no se ve en `show ip nat translations`?

### Parte 12: Escenarios de Troubleshooting

**12.1 Escenario 1: NAT no funciona**

Simule un problema eliminando la configuración `ip nat outside`:
```
RouterEmpresa(config)#interface serial 0/0/0
RouterEmpresa(config-if)#no ip nat outside
RouterEmpresa(config-if)#exit
```

Intente acceder al servidor web desde una PC. ¿Funciona?

Verifique con:
```
RouterEmpresa#show ip interface brief
```

Identifique y corrija el problema. Capture de pantalla del proceso de corrección.

**12.2 Escenario 2: Agotamiento del pool NAT**

Configure un pool con solo 1 dirección:
```
RouterEmpresa(config)#no ip nat inside source list 1 interface serial 0/0/0 overload
RouterEmpresa(config)#ip nat pool POOL-PEQUENO 200.1.1.10 200.1.1.10 netmask 255.255.255.252
RouterEmpresa(config)#ip nat inside source list 1 pool POOL-PEQUENO
```

Intente acceder al servidor web desde las 3 PCs simultáneamente.

¿Qué sucede? Verifique con `show ip nat statistics`.

Capture de pantalla y explique el comportamiento observado.

## Notas

### Consideraciones importantes:

1. **Timeouts de NAT:**
   - Traducciones TCP: típicamente 24 horas de inactividad
   - Traducciones UDP: típicamente 5 minutos de inactividad
   - Traducciones ICMP: típicamente 60 segundos

2. **Limitaciones de NAT:**
   - Rompe el modelo de extremo a extremo de Internet
   - Puede causar problemas con aplicaciones que embeben direcciones IP en los datos (FTP, SIP, IPSec)
   - Dificulta el hosting de servidores detrás de NAT
   - Complica el troubleshooting de red

3. **Mejores prácticas:**
   - Use PAT para conservar direcciones IP públicas
   - Reserve NAT estático para servidores que deben ser accesibles desde Internet
   - Implemente logging de NAT para auditoría de seguridad
   - Planifique cuidadosamente el tamaño del pool NAT según el número de usuarios concurrentes

4. **Comandos útiles para troubleshooting:**
   ```
   show ip nat translations
   show ip nat statistics
   clear ip nat translation *
   debug ip nat
   show access-lists
   ```

5. **Alternativas a NAT:**
   - IPv6 elimina la necesidad de NAT al proporcionar un espacio de direcciones masivo
   - NAT66 (NAT para IPv6) existe pero es controversial y raramente usado

### Entrega de la práctica:

**Formato de entrega:** Reporte en PDF con las siguientes secciones:

1. **Portada** con datos del alumno
2. **Introducción** explicando los conceptos de NAT
3. **Desarrollo** con capturas de pantalla de cada paso
4. **Tablas completas** de traducciones y análisis comparativo
5. **Respuestas** a las 10 preguntas planteadas
6. **Conclusiones** sobre la importancia y aplicación de NAT
7. **Referencias** bibliográficas consultadas

**Puntos clave a incluir:**
- Mínimo 15 capturas de pantalla de evidencias
- Todas las tablas completadas
- Respuestas fundamentadas a las preguntas
- Análisis de los diferentes tipos de NAT
- Reflexión sobre escenarios reales de aplicación

### Referencias:

- Cisco. (2023). *Configuring Network Address Translation*. Cisco IOS IP Configuration Guide.
- RFC 1631: *The IP Network Address Translator (NAT)*
- RFC 3022: *Traditional IP Network Address Translator (Traditional NAT)*
- CCNA Routing and Switching: *Connecting Networks Companion Guide*
- Odom, W. (2023). *CCNA 200-301 Official Cert Guide Library*. Cisco Press.

---

**Fecha de elaboración:** Marzo 2026  
**Versión:** 1.0
