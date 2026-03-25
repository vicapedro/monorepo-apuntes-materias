# Práctica: Implementación de Túneles GRE (Generic Routing Encapsulation)

## Objetivo

Implementar y configurar túneles GRE entre dos sitios remotos (matriz y sucursal) conectados a través de Internet utilizando diferentes ISPs, verificando la conectividad punto a punto y analizando el comportamiento del tráfico encapsulado mediante herramientas de diagnóstico y trazado de rutas.

**Duración estimada:** 3 horas

## Competencias a desarrollar

- Implementa túneles GRE para establecer conectividad segura entre sitios remotos a través de redes públicas
- Configura interfaces virtuales de túnel en routers Cisco con direccionamiento IP apropiado
- Analiza el comportamiento del encapsulamiento GRE y su impacto en el enrutamiento
- Utiliza herramientas de diagnóstico (ping, traceroute, show commands) para verificar la operación del túnel
- Evalúa las diferencias en el camino de los paquetes con y sin túnel GRE
- Documenta configuraciones de red empresarial con múltiples sitios y conectividad WAN

## Introducción

### ¿Qué es GRE?

**Generic Routing Encapsulation (GRE)** es un protocolo de tunelización desarrollado por Cisco que permite encapsular una amplia variedad de protocolos de capa de red dentro de túneles punto a punto sobre redes IP. GRE crea un enlace virtual directo entre dos puntos de una red que pueden estar separados por múltiples routers y redes intermedias.

### Características principales de GRE

1. **Protocolo simple y liviano**: Overhead mínimo comparado con otras tecnologías de túnel
2. **Multiprotocolo**: Soporta IPv4, IPv6, IPX, AppleTalk y otros protocolos
3. **Soporte de multicast**: Permite el paso de tráfico de enrutamiento dinámico (OSPF, EIGRP, etc.)
4. **Sin cifrado nativo**: GRE por sí solo NO proporciona seguridad (puede combinarse con IPSec)
5. **Stateless**: No mantiene información de estado de la conexión

### ⚠️ ADVERTENCIA CRÍTICA DE SEGURIDAD

**GRE estándar NO proporciona autenticación ni cifrado:**

| Característica de Seguridad | GRE Estándar | GRE + IPSec |
|------------------------------|--------------|-------------|
| **Autenticación de peers** | ❌ No | ✅ Sí |
| **Cifrado de datos** | ❌ No | ✅ Sí |
| **Integridad de datos** | ❌ No | ✅ Sí |
| **Protección anti-replay** | ❌ No | ✅ Sí |
| **Verificación de origen** | ❌ No | ✅ Sí |

**Implicaciones en esta práctica:**
- El tráfico viaja en **TEXTO PLANO** a través de Internet
- **NO hay verificación** de identidad de los routers remotos
- Vulnerable a ataques de **spoofing** y **man-in-the-middle**
- Cualquier dispositivo que conozca las IPs puede inyectar tráfico en el túnel

**Para entornos de producción:** Esta práctica incluye una Parte 14 que demuestra cómo implementar **GRE over IPSec** para agregar autenticación y cifrado. En redes reales que atraviesan Internet, SIEMPRE se debe usar GRE con IPSec.

### Estructura del encabezado GRE

```
+--------------------------------------+
|     Encabezado IP externo            |  20 bytes
|  (IPs públicas src/dst del túnel)    |
+--------------------------------------+
|     Encabezado GRE                   |  4-16 bytes (típicamente 4)
|  (Protocol Type, Flags, etc.)        |
+--------------------------------------+
|     Encabezado IP interno            |  20 bytes
|  (IPs privadas src/dst originales)   |
+--------------------------------------+
|     Datos (payload)                  |
+--------------------------------------+
```

### Casos de uso de GRE

1. **Conectividad entre sitios remotos**: Unir redes privadas a través de Internet
2. **Transporte de protocolos de enrutamiento**: Permitir OSPF, EIGRP sobre redes que no los soportan nativamente
3. **Multicast sobre Internet**: Transportar tráfico multicast a través de redes que solo soportan unicast
4. **Backup de enlaces WAN**: Proveer conectividad redundante usando Internet como backup
5. **Base para VPNs**: Combinado con IPSec proporciona túneles VPN seguros

### Ventajas de GRE

- ✅ Configuración simple y directa
- ✅ Bajo overhead de procesamiento
- ✅ Soporta protocolos de enrutamiento dinámico
- ✅ Compatible con NAT
- ✅ No requiere infraestructura PKI

### Desventajas de GRE

- ❌ Sin cifrado (requiere IPSec para seguridad)
- ❌ Sin autenticación de peers
- ❌ Sin protección contra replay attacks
- ❌ Aumenta el tamaño de los paquetes (overhead)
- ❌ Puede causar problemas con MTU

### GRE vs otras tecnologías

| Característica | GRE | IPSec | MPLS | DMVPN |
|----------------|-----|-------|------|-------|
| Cifrado | ❌ | ✅ | ❌ | ✅ (con IPSec) |
| Multiprotocolo | ✅ | ⚠️ | ✅ | ✅ |
| Complejidad | Baja | Alta | Media | Alta |
| Overhead | Bajo | Alto | Bajo | Medio |
| Escalabilidad | Baja | Media | Alta | Alta |
| Costo | Bajo | Bajo | Alto | Medio |

### Terminología importante

- **Tunnel Source**: Interfaz o IP de origen del túnel (IP pública del router local)
- **Tunnel Destination**: IP de destino del túnel (IP pública del router remoto)
- **Tunnel IP**: Dirección IP asignada a la interfaz virtual del túnel (red privada del túnel)
- **Passenger Protocol**: Protocolo que se transporta dentro del túnel (ej. IPv4, IPv6)
- **Transport Protocol**: Protocolo usado para transportar el túnel (GRE/IP)
- **Encapsulation**: Protocolo de encapsulamiento (GRE)

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
- Terminal de comandos IOS de Cisco
- Wireshark (opcional, para análisis de captura en equipos reales)

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
     - Servidor web real o máquina virtual con servicios HTTP
     - Posibilidad de capturar tráfico con Wireshark
   - Consulte con el instructor la disponibilidad de equipamiento y topología adaptada

**Si realiza la práctica en laboratorio físico, adapte los nombres de interfaces y direcciones IP según los equipos disponibles.**

## Instrucciones

### Parte 1: Construcción de la Topología

**1.1** Abra Cisco Packet Tracer y cree la siguiente topología:

**Dispositivos necesarios:**
- 6 Routers (Router-PT o modelo 2911)
- 2 Switches (Switch-PT-Empty o modelo 2960)
- 4 PCs (PC-PT)
- 1 Servidor (Server-PT)

**Esquema lógico de la red:**

```
   SITIO MATRIZ                       INTERNET                    SITIO SUCURSAL
   
[PC1] [PC2]                                                          [PC3] [PC4]
     \   /                                                               \   /
   [Switch1]                                                          [Switch2]
       |                                                                  |
  192.168.1.0/24                                                   192.168.2.0/24
       |                                                                  |
   [R-Matriz]---[ISP1]---[Internet-R1]---[Internet-R2]---[ISP2]---[R-Sucursal]
       .1         .1  .2      .1  .2  .5      .6  .1  .2      .2   .1
                 203.0.113.0/30  |  198.51.100.0/30      203.0.113.4/30
                                 |
                          200.100.50.0/29
                                 |
                            [WebServer]
                            200.100.50.10
```

**Direccionamiento IP:**

| Segmento | Red | Propósito |
|----------|-----|-----------|
| LAN Matriz | 192.168.1.0/24 | Red interna de oficina matriz |
| LAN Sucursal | 192.168.2.0/24 | Red interna de oficina sucursal |
| WAN Matriz-ISP1 | 203.0.113.0/30 | Enlace entre R-Matriz y ISP1 |
| WAN ISP1-Internet | 203.0.113.8/30 | Enlace entre ISP1 e Internet-R1 |
| WAN Internet-R1 a R2 | 198.51.100.0/30 | Backbone de Internet simulado |
| WAN Internet-R2 a ISP2 | 203.0.113.12/30 | Enlace entre Internet-R2 e ISP2 |
| WAN ISP2-Sucursal | 203.0.113.4/30 | Enlace entre ISP2 y R-Sucursal |
| Servidores Internet | 200.100.50.0/29 | Red de servidores públicos |
| **Túnel GRE** | **10.0.0.0/30** | **Red virtual del túnel** |

**1.2** Realice las siguientes conexiones físicas:

| Dispositivo Origen | Interfaz | Dispositivo Destino | Interfaz | Tipo Cable |
|-------------------|----------|---------------------|----------|------------|
| PC1 | FastEthernet0 | Switch1 | FastEthernet0/1 | Straight-Through |
| PC2 | FastEthernet0 | Switch1 | FastEthernet0/2 | Straight-Through |
| Switch1 | FastEthernet0/24 | R-Matriz | GigabitEthernet0/0 | Straight-Through |
| R-Matriz | Serial0/0/0 | ISP1 | Serial0/0/0 | Serial DCE |
| ISP1 | Serial0/0/1 | Internet-R1 | Serial0/0/0 | Serial DCE |
| Internet-R1 | Serial0/0/1 | Internet-R2 | Serial0/0/0 | Serial DCE |
| Internet-R1 | GigabitEthernet0/0 | WebServer | FastEthernet0 | Straight-Through |
| Internet-R2 | Serial0/0/1 | ISP2 | Serial0/0/0 | Serial DCE |
| ISP2 | Serial0/0/1 | R-Sucursal | Serial0/0/0 | Serial DCE |
| R-Sucursal | GigabitEthernet0/0 | Switch2 | FastEthernet0/24 | Straight-Through |
| PC3 | FastEthernet0 | Switch2 | FastEthernet0/1 | Straight-Through |
| PC4 | FastEthernet0 | Switch2 | FastEthernet0/2 | Straight-Through |

**1.3** Capture de pantalla de la topología completa con todos los dispositivos conectados y etiquetados.

### Parte 2: Configuración del Sitio Matriz

**2.1 Configuración del Router de la Matriz**

```
Router>enable
Router#configure terminal
Router(config)#hostname R-Matriz
R-Matriz(config)#no ip domain-lookup
R-Matriz(config)#enable secret cisco123

! Configurar interfaz LAN
R-Matriz(config)#interface gigabitEthernet 0/0
R-Matriz(config-if)#description LAN Oficina Matriz
R-Matriz(config-if)#ip address 192.168.1.1 255.255.255.0
R-Matriz(config-if)#no shutdown
R-Matriz(config-if)#exit

! Configurar interfaz WAN hacia ISP1
R-Matriz(config)#interface serial 0/0/0
R-Matriz(config-if)#description Enlace WAN a ISP1
R-Matriz(config-if)#ip address 203.0.113.2 255.255.255.252
R-Matriz(config-if)#clock rate 128000
R-Matriz(config-if)#no shutdown
R-Matriz(config-if)#exit

! Configurar ruta por defecto
R-Matriz(config)#ip route 0.0.0.0 0.0.0.0 203.0.113.1

! Guardar configuración
R-Matriz(config)#exit
R-Matriz#copy running-config startup-config
```

**2.2 Configuración de las PCs del sitio Matriz**

- **PC1:** IP: 192.168.1.10, Máscara: 255.255.255.0, Gateway: 192.168.1.1
- **PC2:** IP: 192.168.1.20, Máscara: 255.255.255.0, Gateway: 192.168.1.1

**2.3** Verifique la configuración:
```
R-Matriz#show ip interface brief
R-Matriz#show ip route
```

**2.4** Desde PC1 y PC2, verifique conectividad al gateway:
```
C:\> ping 192.168.1.1
```

**2.5** Capture de pantalla mostrando la configuración de interfaces del R-Matriz.

### Parte 3: Configuración del Sitio Sucursal

**3.1 Configuración del Router de la Sucursal**

```
Router>enable
Router#configure terminal
Router(config)#hostname R-Sucursal
R-Sucursal(config)#no ip domain-lookup
R-Sucursal(config)#enable secret cisco123

! Configurar interfaz LAN
R-Sucursal(config)#interface gigabitEthernet 0/0
R-Sucursal(config-if)#description LAN Oficina Sucursal
R-Sucursal(config-if)#ip address 192.168.2.1 255.255.255.0
R-Sucursal(config-if)#no shutdown
R-Sucursal(config-if)#exit

! Configurar interfaz WAN hacia ISP2
R-Sucursal(config)#interface serial 0/0/0
R-Sucursal(config-if)#description Enlace WAN a ISP2
R-Sucursal(config-if)#ip address 203.0.113.6 255.255.255.252
R-Sucursal(config-if)#clock rate 128000
R-Sucursal(config-if)#no shutdown
R-Sucursal(config-if)#exit

! Configurar ruta por defecto
R-Sucursal(config)#ip route 0.0.0.0 0.0.0.0 203.0.113.5

! Guardar configuración
R-Sucursal(config)#exit
R-Sucursal#copy running-config startup-config
```

**3.2 Configuración de las PCs del sitio Sucursal**

- **PC3:** IP: 192.168.2.10, Máscara: 255.255.255.0, Gateway: 192.168.2.1
- **PC4:** IP: 192.168.2.20, Máscara: 255.255.255.0, Gateway: 192.168.2.1

**3.3** Verifique la configuración:
```
R-Sucursal#show ip interface brief
R-Sucursal#show ip route
```

**3.4** Capture de pantalla mostrando la configuración de interfaces del R-Sucursal.

### Parte 4: Configuración de los Routers ISP e Internet

**4.1 Configuración de ISP1**

```
Router>enable
Router#configure terminal
Router(config)#hostname ISP1
ISP1(config)#no ip domain-lookup
ISP1(config)#enable secret cisco123

! Interfaz hacia R-Matriz
ISP1(config)#interface serial 0/0/0
ISP1(config-if)#description Cliente Matriz
ISP1(config-if)#ip address 203.0.113.1 255.255.255.252
ISP1(config-if)#no shutdown
ISP1(config-if)#exit

! Interfaz hacia Internet
ISP1(config)#interface serial 0/0/1
ISP1(config-if)#description Enlace a Internet
ISP1(config-if)#ip address 203.0.113.9 255.255.255.252
ISP1(config-if)#clock rate 128000
ISP1(config-if)#no shutdown
ISP1(config-if)#exit

! Enrutamiento estático
ISP1(config)#ip route 192.168.1.0 255.255.255.0 203.0.113.2
ISP1(config)#ip route 0.0.0.0 0.0.0.0 203.0.113.10

ISP1(config)#exit
ISP1#copy running-config startup-config
```

**4.2 Configuración de ISP2**

```
Router>enable
Router#configure terminal
Router(config)#hostname ISP2
ISP2(config)#no ip domain-lookup
ISP2(config)#enable secret cisco123

! Interfaz hacia R-Sucursal
ISP2(config)#interface serial 0/0/1
ISP2(config-if)#description Cliente Sucursal
ISP2(config-if)#ip address 203.0.113.5 255.255.255.252
ISP2(config-if)#no shutdown
ISP2(config-if)#exit

! Interfaz hacia Internet
ISP2(config)#interface serial 0/0/0
ISP2(config-if)#description Enlace a Internet
ISP2(config-if)#ip address 203.0.113.14 255.255.255.252
ISP2(config-if)#no shutdown
ISP2(config-if)#exit

! Enrutamiento estático
ISP2(config)#ip route 192.168.2.0 255.255.255.0 203.0.113.6
ISP2(config)#ip route 0.0.0.0 0.0.0.0 203.0.113.13

ISP2(config)#exit
ISP2#copy running-config startup-config
```

**4.3 Configuración de Internet-R1**

```
Router>enable
Router#configure terminal
Router(config)#hostname Internet-R1
Internet-R1(config)#no ip domain-lookup
Internet-R1(config)#enable secret cisco123

! Interfaz hacia ISP1
Internet-R1(config)#interface serial 0/0/0
Internet-R1(config-if)#description Enlace desde ISP1
Internet-R1(config-if)#ip address 203.0.113.10 255.255.255.252
Internet-R1(config-if)#no shutdown
Internet-R1(config-if)#exit

! Interfaz hacia Internet-R2
Internet-R1(config)#interface serial 0/0/1
Internet-R1(config-if)#description Backbone Internet
Internet-R1(config-if)#ip address 198.51.100.1 255.255.255.252
Internet-R1(config-if)#clock rate 128000
Internet-R1(config-if)#no shutdown
Internet-R1(config-if)#exit

! Interfaz LAN con servidor web
Internet-R1(config)#interface gigabitEthernet 0/0
Internet-R1(config-if)#description Red de Servidores
Internet-R1(config-if)#ip address 200.100.50.1 255.255.255.248
Internet-R1(config-if)#no shutdown
Internet-R1(config-if)#exit

! Enrutamiento estático
Internet-R1(config)#ip route 192.168.1.0 255.255.255.0 203.0.113.9
Internet-R1(config)#ip route 192.168.2.0 255.255.255.0 198.51.100.2
Internet-R1(config)#ip route 203.0.113.4 255.255.255.252 198.51.100.2
Internet-R1(config)#ip route 203.0.113.12 255.255.255.252 198.51.100.2

Internet-R1(config)#exit
Internet-R1#copy running-config startup-config
```

**4.4 Configuración de Internet-R2**

```
Router>enable
Router#configure terminal
Router(config)#hostname Internet-R2
Internet-R2(config)#no ip domain-lookup
Internet-R2(config)#enable secret cisco123

! Interfaz hacia Internet-R1
Internet-R2(config)#interface serial 0/0/0
Internet-R2(config-if)#description Backbone Internet
Internet-R2(config-if)#ip address 198.51.100.2 255.255.255.252
Internet-R2(config-if)#no shutdown
Internet-R2(config-if)#exit

! Interfaz hacia ISP2
Internet-R2(config)#interface serial 0/0/1
Internet-R2(config-if)#description Enlace a ISP2
Internet-R2(config-if)#ip address 203.0.113.13 255.255.255.252
Internet-R2(config-if)#clock rate 128000
Internet-R2(config-if)#no shutdown
Internet-R2(config-if)#exit

! Enrutamiento estático
Internet-R2(config)#ip route 192.168.2.0 255.255.255.0 203.0.113.14
Internet-R2(config)#ip route 192.168.1.0 255.255.255.0 198.51.100.1
Internet-R2(config)#ip route 203.0.113.0 255.255.255.252 198.51.100.1
Internet-R2(config)#ip route 203.0.113.8 255.255.255.252 198.51.100.1
Internet-R2(config)#ip route 200.100.50.0 255.255.255.248 198.51.100.1

Internet-R2(config)#exit
Internet-R2#copy running-config startup-config
```

### Parte 5: Configuración del Servidor Web

**5.1** Configure el servidor web con dirección IP estática:
- **IP Address:** 200.100.50.10
- **Subnet Mask:** 255.255.255.248
- **Default Gateway:** 200.100.50.1
- **DNS Server:** 8.8.8.8

**5.2** Active el servicio HTTP:
- Desktop → Services → HTTP
- Verifique que el servicio esté activo (ON)

**5.3** Personalice la página web:
```html
<html>
<head><title>Servidor Web Internet - GRE Practice</title></head>
<body>
<h1>Servidor Web en Internet</h1>
<h2>Practica de Tuneles GRE</h2>
<p>IP del Servidor: 200.100.50.10</p>
<p>Este servidor verifica la conectividad a Internet desde ambos sitios.</p>
</body>
</html>
```

**5.4** Capture de pantalla del servidor web configurado.

### Parte 6: Verificación de Conectividad Base (Sin Túnel GRE)

**6.1** Desde PC1 (Matriz), verifique conectividad básica:
```
C:\> ping 192.168.1.1          (Gateway local)
C:\> ping 203.0.113.1          (ISP1)
C:\> ping 200.100.50.10        (Servidor Web)
```

**6.2** Desde PC3 (Sucursal), verifique conectividad básica:
```
C:\> ping 192.168.2.1          (Gateway local)
C:\> ping 203.0.113.5          (ISP2)
C:\> ping 200.100.50.10        (Servidor Web)
```

**6.3** Intente hacer ping entre las LANs (SIN túnel GRE todavía):
```
PC1> ping 192.168.2.10         (PC3 en Sucursal)
```

**Pregunta 1:** ¿Funciona el ping entre PC1 y PC3? ¿Por qué sí o por qué no? Explique qué falta en la configuración.

**6.4** Desde PC1, trace la ruta hacia el servidor web:
```
C:\> tracert 200.100.50.10
```

**6.5** Capture de pantalla del traceroute mostrando los saltos a través de Internet.

**Pregunta 2:** ¿Cuántos saltos hay entre PC1 y el servidor web? Liste las IPs de cada salto.

### Parte 7: Configuración del Túnel GRE

**7.1 Configurar interfaz de túnel en R-Matriz**

```
R-Matriz#configure terminal

! Crear interfaz de túnel
R-Matriz(config)#interface tunnel 0
R-Matriz(config-if)#description Tunel GRE a Sucursal
R-Matriz(config-if)#ip address 10.0.0.1 255.255.255.252
R-Matriz(config-if)#tunnel source serial 0/0/0
R-Matriz(config-if)#tunnel destination 203.0.113.6
R-Matriz(config-if)#tunnel mode gre ip
R-Matriz(config-if)#no shutdown
R-Matriz(config-if)#exit

! Agregar ruta estática para la red remota a través del túnel
R-Matriz(config)#ip route 192.168.2.0 255.255.255.0 10.0.0.2

R-Matriz(config)#exit
R-Matriz#copy running-config startup-config
```

**Explicación de los comandos del túnel:**
- `interface tunnel 0`: Crea una interfaz virtual de túnel
- `ip address 10.0.0.1 255.255.255.252`: Asigna IP a la interfaz del túnel (/30 = punto a punto)
- `tunnel source serial 0/0/0`: Define la interfaz de origen (puede usar IP en lugar de interfaz)
- `tunnel destination 203.0.113.6`: IP pública del router remoto (R-Sucursal)
- `tunnel mode gre ip`: Especifica el modo de encapsulamiento (GRE sobre IP)

**7.2 Configurar interfaz de túnel en R-Sucursal**

```
R-Sucursal#configure terminal

! Crear interfaz de túnel
R-Sucursal(config)#interface tunnel 0
R-Sucursal(config-if)#description Tunel GRE a Matriz
R-Sucursal(config-if)#ip address 10.0.0.2 255.255.255.252
R-Sucursal(config-if)#tunnel source serial 0/0/0
R-Sucursal(config-if)#tunnel destination 203.0.113.2
R-Sucursal(config-if)#tunnel mode gre ip
R-Sucursal(config-if)#no shutdown
R-Sucursal(config-if)#exit

! Agregar ruta estática para la red remota a través del túnel
R-Sucursal(config)#ip route 192.168.1.0 255.255.255.0 10.0.0.1

R-Sucursal(config)#exit
R-Sucursal#copy running-config startup-config
```

**7.3** Verifique el estado de las interfaces de túnel:

En R-Matriz:
```
R-Matriz#show ip interface brief
R-Matriz#show interfaces tunnel 0
```

En R-Sucursal:
```
R-Sucursal#show ip interface brief
R-Sucursal#show interfaces tunnel 0
```

**7.4** Capture de pantalla mostrando las interfaces de túnel activas (up/up) en ambos routers.

**Pregunta 3:** ¿Qué protocolo de capa de enlace de datos muestra la interfaz Tunnel0? ¿Por qué?

**7.5** Verifique las tablas de enrutamiento:
```
R-Matriz#show ip route
R-Sucursal#show ip route
```

**7.6** Capture de pantalla de las tablas de enrutamiento mostrando las rutas a través del túnel.

### Parte 8: Pruebas de Conectividad a través del Túnel GRE

**8.1** Desde R-Matriz, haga ping a la IP del túnel remoto:
```
R-Matriz#ping 10.0.0.2
```

**8.2** Desde R-Sucursal, haga ping a la IP del túnel remoto:
```
R-Sucursal#ping 10.0.0.1
```

**8.3** Capture de pantalla de los pings exitosos entre las interfaces de túnel.

**8.4** Desde PC1 (Matriz), haga ping a PC3 (Sucursal):
```
C:\> ping 192.168.2.10
```

**8.5** Desde PC3 (Sucursal), haga ping a PC1 (Matriz):
```
C:\> ping 192.168.1.10
```

**8.6** Capture de pantalla de los pings exitosos entre las PCs de diferentes sitios.

**Pregunta 4:** Compare esta situación con la del Parte 6. ¿Qué cambió? ¿Por qué ahora funciona la conectividad entre los sitios?

**8.7** Acceda al servidor web desde ambas PCs:
- Desde PC1: Abrir navegador → http://200.100.50.10
- Desde PC3: Abrir navegador → http://200.100.50.10

**8.8** Capture de pantalla del acceso web exitoso desde ambas PCs.

### Parte 9: Análisis de Rutas con Traceroute

**9.1 Traceroute de Matriz a Sucursal (a través del túnel)**

Desde PC1:
```
C:\> tracert 192.168.2.10
```

**Pregunta 5:** ¿Cuántos saltos aparecen en el traceroute de PC1 a PC3? ¿Puede ver los routers intermedios de Internet (ISP1, Internet-R1, etc.)?

**9.2** Capture de pantalla del traceroute de Matriz a Sucursal.

**9.3 Traceroute de Matriz al Servidor Web (sin túnel)**

Desde PC1:
```
C:\> tracert 200.100.50.10
```

**Pregunta 6:** ¿Cuántos saltos aparecen ahora? ¿Puede ver los routers intermedios? ¿Por qué la diferencia con el traceroute anterior?

**9.4** Capture de pantalla del traceroute de Matriz al Servidor Web.

**9.5 Traceroute de Sucursal al Servidor Web (sin túnel)**

Desde PC3:
```
C:\> tracert 200.100.50.10
```

**9.6** Capture de pantalla del traceroute de Sucursal al Servidor Web.

**9.7** Complete la siguiente tabla comparativa:

| Origen | Destino | Usa Túnel GRE | Saltos Visibles | Ruta Observada |
|--------|---------|---------------|-----------------|----------------|
| PC1 (Matriz) | PC3 (Sucursal) | ✅ Sí | | |
| PC1 (Matriz) | WebServer | ❌ No | | |
| PC3 (Sucursal) | WebServer | ❌ No | | |

**Pregunta 7:** Explique por qué el tráfico entre Matriz y Sucursal "oculta" los saltos intermedios en el traceroute.

### Parte 10: Análisis Detallado de la Interfaz Túnel

**10.1** En R-Matriz, ejecute los siguientes comandos de análisis:

```
R-Matriz#show interface tunnel 0
R-Matriz#show ip interface tunnel 0
```

**10.2** Identifique en la salida:
- Estado de la interfaz (up/down)
- Tipo de encapsulamiento
- MTU del túnel
- Dirección IP del túnel
- Origen y destino del túnel
- Contadores de tráfico (paquetes enviados/recibidos)

**10.3** Capture de pantalla de la información detallada del túnel.

**10.4** Verifique el overhead de GRE ejecutando:
```
R-Matriz#show ip interface tunnel 0 | include MTU
```

**Pregunta 8:** ¿Cuál es el MTU de la interfaz del túnel? ¿Por qué es menor que el MTU estándar de Ethernet (1500 bytes)?

**10.5** Genere tráfico a través del túnel y verifique las estadísticas:

Desde PC1:
```
C:\> ping -n 100 192.168.2.10
```

En R-Matriz:
```
R-Matriz#show interface tunnel 0 | include packets
```

**10.6** Capture de pantalla de las estadísticas de tráfico del túnel.

### Parte 11: Troubleshooting del Túnel GRE

**11.1 Escenario 1: Túnel caído por destino incorrecto**

En R-Matriz, configure intencionalmente un destino incorrecto:
```
R-Matriz(config)#interface tunnel 0
R-Matriz(config-if)#tunnel destination 203.0.113.99
R-Matriz(config-if)#exit
```

Verifique el estado:
```
R-Matriz#show ip interface brief | include Tunnel
```

Intente hacer ping:
```
R-Matriz#ping 10.0.0.2
```

**Pregunta 9:** ¿Qué estado muestra la interfaz Tunnel0? ¿Por qué falla la conectividad?

**11.2** Corrija la configuración:
```
R-Matriz(config)#interface tunnel 0
R-Matriz(config-if)#tunnel destination 203.0.113.6
R-Matriz(config-if)#exit
```

Verifique que el túnel vuelva a estado up/up.

**11.3 Escenario 2: Ruta estática faltante**

En R-Sucursal, elimine la ruta estática:
```
R-Sucursal(config)#no ip route 192.168.1.0 255.255.255.0 10.0.0.1
```

Desde PC3, intente ping a PC1:
```
C:\> ping 192.168.1.10
```

**Pregunta 10:** ¿Funciona el ping? ¿Por qué no, si el túnel está activo?

**11.4** Corrija eliminando y restaurando la ruta:
```
R-Sucursal(config)#ip route 192.168.1.0 255.255.255.0 10.0.0.1
```

**11.5** Capture de pantalla del proceso de troubleshooting.

**11.6 Comandos útiles para diagnóstico de túneles GRE:**

```
! Verificar estado del túnel
show interface tunnel 0
show ip interface brief

! Verificar configuración del túnel
show running-config interface tunnel 0

! Ver rutas a través del túnel
show ip route | include 10.0.0

! Verificar conectividad de las IPs del túnel
ping [tunnel-destination-ip]

! Verificar que las IPs de origen/destino sean alcanzables
ping 203.0.113.6 source 203.0.113.2

! Debug de túneles (usar con precaución)
debug tunnel
debug ip packet

! Deshabilitar debug
undebug all
```

### Parte 12: Configuración de Enrutamiento Dinámico sobre GRE (Opcional)

**12.1** Como ejercicio avanzado, configure OSPF sobre el túnel GRE para intercambiar rutas dinámicamente.

En R-Matriz:
```
R-Matriz(config)#router ospf 1
R-Matriz(config-router)#network 192.168.1.0 0.0.0.255 area 0
R-Matriz(config-router)#network 10.0.0.0 0.0.0.3 area 0
R-Matriz(config-router)#exit

! Eliminar la ruta estática previa
R-Matriz(config)#no ip route 192.168.2.0 255.255.255.0 10.0.0.2
```

En R-Sucursal:
```
R-Sucursal(config)#router ospf 1
R-Sucursal(config-router)#network 192.168.2.0 0.0.0.255 area 0
R-Sucursal(config-router)#network 10.0.0.0 0.0.0.3 area 0
R-Sucursal(config-router)#exit

! Eliminar la ruta estática previa
R-Sucursal(config)#no ip route 192.168.1.0 255.255.255.0 10.0.0.1
```

**12.2** Verifique las adyacencias OSPF:
```
R-Matriz#show ip ospf neighbor
R-Sucursal#show ip ospf neighbor
```

**12.3** Verifique que las rutas se aprendan dinámicamente:
```
R-Matriz#show ip route ospf
R-Sucursal#show ip route ospf
```

**12.4** Pruebe la conectividad:
```
PC1> ping 192.168.2.10
```

**12.5** Capture de pantalla mostrando las adyacencias OSPF y las rutas dinámicas.

**Pregunta 11 (Opcional):** ¿Cuáles son las ventajas de usar un protocolo de enrutamiento dinámico sobre GRE en lugar de rutas estáticas?

### Parte 13: Implementación de Autenticación y Cifrado con GRE over IPSec

**⚠️ IMPORTANTE:** Esta sección es FUNDAMENTAL para entender cómo proteger túneles GRE en entornos de producción.

**13.1 Conceptos de GRE over IPSec**

GRE over IPSec combina:
- **GRE**: Proporciona encapsulamiento multiprotocolo y soporte de multicast
- **IPSec**: Agrega autenticación, cifrado e integridad

**Modos de operación:**

1. **Transport Mode** (Recomendado para GRE):
   ```
   [IP Original][IPSec][GRE][IP Inner][Datos]
   ```
   - Solo cifra el payload GRE
   - Menor overhead
   - Más eficiente

2. **Tunnel Mode**:
   ```
   [IP Nuevo][IPSec][IP Original][GRE][IP Inner][Datos]
   ```
   - Cifra todo el paquete GRE completo
   - Mayor overhead
   - Usado cuando GRE no es opción

**13.2 Configuración de IPSec en R-Matriz**

Primero, configure la política ISAKMP (Fase 1):

```
R-Matriz#configure terminal

! Definir política ISAKMP para autenticación de peers
R-Matriz(config)#crypto isakmp policy 10
R-Matriz(config-isakmp)#encryption aes 256
R-Matriz(config-isakmp)#authentication pre-share
R-Matriz(config-isakmp)#group 14
R-Matriz(config-isakmp)#hash sha256
R-Matriz(config-isakmp)#lifetime 86400
R-Matriz(config-isakmp)#exit

! Definir pre-shared key para el peer remoto
R-Matriz(config)#crypto isakmp key SecureGRE2026! address 203.0.113.6
```

**Explicación de parámetros ISAKMP:**
- `encryption aes 256`: Algoritmo de cifrado (AES 256 bits)
- `authentication pre-share`: Usa clave compartida (PSK)
- `group 14`: Diffie-Hellman group 14 (2048 bits)
- `hash sha256`: Función hash para integridad
- `lifetime 86400`: Duración de la SA (24 horas)

Ahora configure el transform set (Fase 2):

```
! Crear transform set para IPSec
R-Matriz(config)#crypto ipsec transform-set GRE-TRANSFORM esp-aes 256 esp-sha256-hmac
R-Matriz(cfg-crypto-trans)#mode transport
R-Matriz(cfg-crypto-trans)#exit
```

**Explicación del transform set:**
- `esp-aes 256`: Cifrado ESP con AES 256 bits
- `esp-sha256-hmac`: HMAC-SHA256 para integridad
- `mode transport`: Modo transport (solo cifra payload)

Cree el perfil IPSec:

```
! Crear perfil IPSec para aplicar al túnel
R-Matriz(config)#crypto ipsec profile GRE-PROFILE
R-Matriz(ipsec-profile)#set transform-set GRE-TRANSFORM
R-Matriz(ipsec-profile)#set pfs group14
R-Matriz(ipsec-profile)#exit
```

Finalmente, aplique el perfil IPSec al túnel GRE:

```
! Aplicar protección IPSec a la interfaz del túnel
R-Matriz(config)#interface tunnel 0
R-Matriz(config-if)#tunnel protection ipsec profile GRE-PROFILE
R-Matriz(config-if)#exit

R-Matriz(config)#exit
R-Matriz#copy running-config startup-config
```

**13.3 Configuración de IPSec en R-Sucursal**

```
R-Sucursal#configure terminal

! Política ISAKMP idéntica a R-Matriz
R-Sucursal(config)#crypto isakmp policy 10
R-Sucursal(config-isakmp)#encryption aes 256
R-Sucursal(config-isakmp)#authentication pre-share
R-Sucursal(config-isakmp)#group 14
R-Sucursal(config-isakmp)#hash sha256
R-Sucursal(config-isakmp)#lifetime 86400
R-Sucursal(config-isakmp)#exit

! Pre-shared key apuntando a R-Matriz
R-Sucursal(config)#crypto isakmp key SecureGRE2026! address 203.0.113.2

! Transform set idéntico
R-Sucursal(config)#crypto ipsec transform-set GRE-TRANSFORM esp-aes 256 esp-sha256-hmac
R-Sucursal(cfg-crypto-trans)#mode transport
R-Sucursal(cfg-crypto-trans)#exit

! Perfil IPSec
R-Sucursal(config)#crypto ipsec profile GRE-PROFILE
R-Sucursal(ipsec-profile)#set transform-set GRE-TRANSFORM
R-Sucursal(ipsec-profile)#set pfs group14
R-Sucursal(ipsec-profile)#exit

! Aplicar al túnel
R-Sucursal(config)#interface tunnel 0
R-Sucursal(config-if)#tunnel protection ipsec profile GRE-PROFILE
R-Sucursal(config-if)#exit

R-Sucursal(config)#exit
R-Sucursal#copy running-config startup-config
```

**13.4 Verificación de la Sesión IPSec**

**Importante:** Genere tráfico interesante para establecer la SA IPSec:

```
R-Matriz#ping 10.0.0.2 source 10.0.0.1
```

Verifique las Security Associations (SAs) ISAKMP (Fase 1):

```
R-Matriz#show crypto isakmp sa
```

**Salida esperada:**
```
dst             src             state          conn-id status
203.0.113.6     203.0.113.2     QM_IDLE           1001 ACTIVE
```

**Estados ISAKMP:**
- `MM_NO_STATE`: No hay negociación
- `MM_SA_SETUP`: Negociando parámetros
- `MM_KEY_EXCH`: Intercambio de claves DH
- `MM_KEY_AUTH`: Autenticación de peers
- `QM_IDLE`: **Activo y listo** (estado deseado)

Verifique las SAs IPSec (Fase 2):

```
R-Matriz#show crypto ipsec sa
```

**Busque información como:**
- `local ident`: 203.0.113.2 (R-Matriz)
- `remote ident`: 203.0.113.6 (R-Sucursal)
- `encaps`: ESP (Encapsulating Security Payload)
- `#pkts encaps`: Paquetes cifrados enviados
- `#pkts decrypt`: Paquetes descifrados recibidos

**13.5** Capture de pantalla mostrando:
- `show crypto isakmp sa` con estado QM_IDLE
- `show crypto ipsec sa` mostrando tráfico cifrado

**13.6 Verificar contadores de paquetes cifrados**

Genere tráfico desde las PCs:

```
PC1> ping 192.168.2.10
```

En R-Matriz, verifique las estadísticas:

```
R-Matriz#show crypto ipsec sa | include pkts
```

Debe ver incremento en:
- `#pkts encaps`: Paquetes salientes cifrados
- `#pkts encrypt`: Total cifrado
- `#pkts decrypt`: Paquetes entrantes descifrados

**13.7** Capture de pantalla de las estadísticas IPSec mostrando tráfico activo.

**Pregunta 12:** ¿Qué ventajas de seguridad proporciona IPSec que GRE solo no tiene?

**13.8 Verificar información detallada del túnel protegido**

```
R-Matriz#show interface tunnel 0
```

Busque la línea:
```
Tunnel protection via IPSec (profile "GRE-PROFILE")
```

Esto confirma que el túnel está protegido con IPSec.

**13.9 Comandos de troubleshooting IPSec**

```
! Ver estado general de IPSec
show crypto isakmp sa
show crypto ipsec sa

! Ver configuración de políticas
show crypto isakmp policy
show crypto ipsec transform-set

! Ver perfiles IPSec
show crypto ipsec profile

! Debug de IPSec (usar con precaución)
debug crypto isakmp
debug crypto ipsec

! Limpiar SAs (forzar renegociación)
clear crypto sa
clear crypto isakmp

! Deshabilitar debugs
undebug all
```

**13.10 Escenario de troubleshooting: Pre-shared key incorrecta**

Simule un error de autenticación en R-Sucursal:

```
R-Sucursal(config)#crypto isakmp key WrongKey! address 203.0.113.2
R-Sucursal(config)#exit
```

Limpie las SAs y genere tráfico:

```
R-Sucursal#clear crypto sa
R-Sucursal#ping 10.0.0.1
```

Verifique el estado:

```
R-Sucursal#show crypto isakmp sa
```

**Pregunta 13:** ¿Qué estado muestra la SA ISAKMP cuando la clave no coincide? ¿Funciona la conectividad del túnel?

Corrija el error:

```
R-Sucursal(config)#crypto isakmp key SecureGRE2026! address 203.0.113.2
```

**13.11 Análisis del overhead adicional de IPSec**

Compare el MTU antes y después de IPSec:

```
R-Matriz#show interface tunnel 0 | include MTU
```

**Overhead total con GRE over IPSec (modo transport):**
- IP externo: 20 bytes
- ESP header: 8-12 bytes
- GRE header: 4 bytes
- IP interno: 20 bytes
- ESP trailer + auth: 12-20 bytes
- **Total overhead: ~54-76 bytes**

MTU recomendado para el túnel: 1400 bytes

**13.12** Complete la siguiente tabla comparativa:

| Característica | GRE Solo | GRE + IPSec |
|----------------|----------|-------------|
| Overhead (bytes) | 24 | 54-76 |
| MTU típico | 1476 | 1400 |
| CPU usage | Bajo | Medio-Alto |
| Autenticación | ❌ No | ✅ Sí |
| Cifrado | ❌ No | ✅ Sí |
| Integridad | ❌ No | ✅ Sí |
| Complejidad config | Baja | Media |
| Latencia adicional | Mínima | +1-5ms |
| Uso en producción | ⚠️ Solo lab | ✅ Recomendado |

**Pregunta 14:** Si un atacante captura el tráfico del túnel con Wireshark, ¿qué puede ver con GRE solo vs GRE+IPSec?

**13.13 Mejores prácticas de seguridad para GRE over IPSec**

✅ **Recomendaciones:**

1. **Cifrado fuerte:**
   - Usar AES-256 mínimo (nunca DES o 3DES)
   - SHA-256 o superior para hashing

2. **Diffie-Hellman groups:**
   - Group 14 (2048-bit) como mínimo
   - Group 19-21 (ECDH) para mayor seguridad

3. **Lifetimes apropiados:**
   - ISAKMP SA: 24 horas (86400 segundos)
   - IPSec SA: 1 hora (3600 segundos) o menos
   - Forzar rekeying frecuente

4. **Perfect Forward Secrecy (PFS):**
   - Siempre habilitar PFS
   - Usar `set pfs group14` o superior

5. **Gestión de claves:**
   - Pre-shared keys: mínimo 20 caracteres, alfanuméricos + símbolos
   - Mejor: usar certificados digitales (PKI)
   - Rotar claves periódicamente

6. **Monitoreo:**
   - Alertas de fallos de autenticación
   - Log de establecimiento/caída de SAs
   - Monitorear expiración de certificados

**13.14 Alternativa: Usar certificados digitales en lugar de PSK**

**Ventajas de certificados sobre pre-shared keys:**
- ✅ Escalabilidad (no necesita configurar keys por cada peer)
- ✅ No repudio
- ✅ Revocación centralizada (CRL/OCSP)
- ✅ Identidad verificable
- ✅ Cumplimiento normativo

**Configuración básica con certificados (ejemplo conceptual):**

```
! Configurar servidor de certificados
crypto pki trustpoint EMPRESA-CA
 enrollment url http://ca.empresa.com
 subject-name CN=R-Matriz,OU=IT,O=Empresa
 revocation-check crl
 rsakeypair EMPRESA-KEYS 2048

! Obtener certificado
crypto pki authenticate EMPRESA-CA
crypto pki enroll EMPRESA-CA

! Modificar política ISAKMP para usar certificados
crypto isakmp policy 10
 authentication rsa-sig
```

**Nota:** Esta configuración requiere infraestructura PKI (CA server), que está fuera del alcance de Packet Tracer básico.

**13.15** Capture de pantalla final mostrando:
- Túnel GRE activo con protección IPSec
- SAs ISAKMP e IPSec en estado activo
- Conectividad exitosa entre sitios con tráfico cifrado
- Contadores de paquetes encrypt/decrypt incrementando

### Parte 14: Análisis Comparativo y Conclusiones

**14.1** Complete la siguiente tabla de análisis del túnel GRE:

| Característica | Sin Túnel GRE | Con Túnel GRE | GRE + IPSec |
|----------------|---------------|---------------|-------------|
| Conectividad Matriz-Sucursal | | | |
| Visibilidad de saltos intermedios | | | |
| Complejidad de configuración | | | |
| Overhead de red (bytes extra) | 0 | 24 | 54-76 |
| Soporte para multicast/enrutamiento dinámico | | | |
| Autenticación de peers | ❌ | ❌ | ✅ |
| Cifrado del tráfico | ❌ | ❌ | ✅ |
| Seguridad del tráfico | Baja | Baja | Alta |

**14.2** Responda las siguientes preguntas de reflexión:

**Pregunta 15:** Si su empresa tiene 5 sucursales, ¿cuántos túneles GRE necesitaría para conectividad total entre todos los sitios (topología full-mesh)? Calcule y explique.

**Pregunta 16:** Explique las diferencias de seguridad entre GRE solo, GRE con tunnel key, y GRE over IPSec. ¿Cuál usaría en producción y por qué?

**Pregunta 17:** ¿Qué información puede ver un atacante si captura el tráfico de un túnel GRE sin IPSec vs uno con IPSec?

**Pregunta 18:** Mencione al menos 3 alternativas tecnológicas a GRE para conectar sitios remotos y compare brevemente (considere seguridad, complejidad, costos).

**Pregunta 19:** ¿Por qué es importante usar Perfect Forward Secrecy (PFS) en túneles IPSec? ¿Qué protege?

**14.3** Elabore un diagrama que muestre:
- La estructura del paquete encapsulado en GRE
- Los encabezados IP externo e interno
- El overhead agregado por GRE

## Notas

### Consideraciones importantes:

1. **MTU y Fragmentación:**
   - GRE agrega 24 bytes de overhead (20 bytes IP + 4 bytes GRE mínimo)
   - MTU predeterminado del túnel: 1476 bytes (1500 - 24)
   - Puede causar fragmentación si no se ajusta correctamente
   - Comando para ajustar: `ip mtu 1400` en la interfaz túnel

2. **Seguridad de GRE:**
   - **GRE estándar NO tiene autenticación:** Cualquier dispositivo puede inyectar tráfico
   - **Sin cifrado:** Todo el tráfico viaja en texto plano a través de Internet
   - **Sin integridad:** Los paquetes pueden ser modificados sin detección
   - **Vulnerabilidades críticas:**
     * Spoofing de túneles
     * Man-in-the-middle attacks
     * Sniffing de credenciales y datos sensibles
     * Suplantación de identidad de peers
   - **Solución obligatoria para producción:** GRE over IPSec
     * Autenticación mutua (PSK o certificados)
     * Cifrado AES-256 mínimo
     * Integridad con HMAC-SHA256
     * Perfect Forward Secrecy (PFS)
   - **NUNCA usar GRE sin IPSec en Internet público**

3. **Escalabilidad:**
   - Configuración punto a punto requiere múltiples túneles para muchos sitios
   - Para topologías hub-and-spoke con muchas sucursales, considerar DMVPN
   - Cada túnel consume recursos del router (CPU, memoria)

4. **Recursión de rutas:**
   - Problema: cuando la ruta al destino del túnel pasa por el túnel mismo
   - Causa que el túnel caiga (flapping)
   - Solución: asegurar que la ruta al tunnel destination use la tabla de enrutamiento principal

5. **Keep-alives:**
   - Por defecto, GRE no usa keep-alives
   - El túnel puede mostrar up/up aunque el destino sea inalcanzable
   - Configurar keep-alives: `keepalive [seconds] [retries]`

6. **Multiprotocolo:**
   - GRE soporta IPv4, IPv6, IPX, AppleTalk, etc.
   - Un solo túnel puede transportar múltiples protocolos simultáneamente
   - Útil para migraciones de IPv4 a IPv6 (túneles 6to4)

7. **QoS sobre GRE:**
   - Puede aplicarse QoS al tráfico del túnel
   - Configurar en la interfaz física (transport QoS) o en la interfaz túnel (passenger QoS)
   - Importante para aplicaciones sensibles al retardo (VoIP, video)

### Mejores prácticas:

**Configuración básica:**
1. **Usar IPs estáticas o DNS dinámico** para los endpoints del túnel
2. **Ajustar MTU** apropiadamente para evitar fragmentación (1400-1420 bytes con IPSec)
3. **Configurar keep-alives** para detección rápida de fallos
4. **Planificar** el direccionamiento IP del túnel cuidadosamente
5. **Documentar** todos los túneles, propósitos y claves utilizadas

**Seguridad (CRÍTICO):**
6. **SIEMPRE implementar IPSec** con GRE en redes públicas:
   - Cifrado AES-256 mínimo
   - Hash SHA-256 o superior
   - Diffie-Hellman Group 14+ (2048-bit)
   - Perfect Forward Secrecy (PFS) habilitado
7. **Gestión de claves robusta:**
   - Pre-shared keys: mínimo 20 caracteres aleatorios
   - Mejor opción: certificados digitales con PKI
   - Rotación periódica de claves (cada 90-180 días)
8. **Autenticación fuerte:**
   - Nunca usar tunnel key solo (inseguro)
   - Implementar autenticación mutua (mutual authentication)
   - Validar identidad de peers antes de establecer SAs
9. **Monitoreo de seguridad:**
   - Logs de fallos de autenticación
   - Alertas de caídas inesperadas de SAs
   - Detección de intentos de spoofing
   - Auditoría de accesos al túnel

**Operación y mantenimiento:**
10. **Monitorear** estado del túnel y estadísticas de tráfico continuamente
11. **Implementar redundancia** con túneles backup para sitios críticos
12. **Definir lifetimes apropiados:**
    - ISAKMP SA: 24 horas
    - IPSec SA: 1-4 horas (forzar rekeying)
13. **Probar regularmente** la conmutación a túneles backup
14. **Actualizar IOS** regularmente para parches de seguridad IPSec

### Comandos de verificación rápida:

**Verificación de túnel GRE:**
```
show interface tunnel 0                      # Estado general del túnel
show ip interface brief                      # Estado de todas las interfaces
show ip route                                # Tabla de enrutamiento
show running-config interface tunnel 0       # Configuración del túnel
ping [destination] source [tunnel-ip]        # Ping desde el túnel
traceroute [destination]                     # Trazar ruta
debug tunnel                                 # Debug de eventos del túnel
```

**Verificación de IPSec (GRE over IPSec):**
```
show crypto isakmp sa                        # Estado de SAs ISAKMP (Fase 1)
show crypto ipsec sa                         # Estado de SAs IPSec (Fase 2)
show crypto ipsec sa | include pkts          # Contadores de paquetes cifrados
show crypto isakmp policy                    # Políticas ISAKMP configuradas
show crypto ipsec transform-set              # Transform sets disponibles
show crypto ipsec profile                    # Perfiles IPSec configurados
show crypto session                          # Sesiones criptográficas activas
clear crypto sa                              # Limpiar SAs (forzar renegociación)
debug crypto isakmp                          # Debug de ISAKMP
debug crypto ipsec                           # Debug de IPSec
```

### Alternativas a GRE:

- **IPSec VPN**: Proporciona cifrado pero no soporta multicast nativamente
- **MPLS VPN**: Solución de proveedores de servicios, escalable pero costosa
- **DMVPN**: Extensión de GRE para topologías hub-and-spoke escalables
- **VXLAN**: Overlay de capa 2 sobre capa 3 para data centers
- **WireGuard**: VPN moderna, ligera y rápida (alternativa open source)

### Entrega de la práctica:

**Formato de entrega:** Reporte en PDF con las siguientes secciones:

1. **Portada** con datos del alumno
2. **Introducción** explicando los conceptos de túneles GRE
3. **Desarrollo** con capturas de pantalla de cada paso (mínimo 20)
4. **Tablas completas** de análisis de rutas y comparación
5. **Respuestas** a las 14 preguntas planteadas
6. **Diagramas** del encapsulamiento GRE
7. **Conclusiones** sobre la utilidad y aplicaciones de GRE
8. **Referencias** bibliográficas consultadas

**Puntos clave a incluir:**
- Evidencia de configuración de ambos routers con túnel GRE
- **Configuración completa de GRE over IPSec** (Parte 13)
- Traceroutes mostrando la diferencia entre tráfico con y sin túnel
- **Capturas de pantalla de SAs IPSec activas**
- Análisis del overhead y MTU (GRE solo vs GRE+IPSec)
- **Comparación de seguridad:** GRE solo vs GRE+IPSec
- Escenarios de troubleshooting resueltos (incluyendo IPSec)
- **Respuestas a las 19 preguntas** planteadas
- Reflexión sobre casos de uso reales y consideraciones de seguridad
- Comparación con otras tecnologías de túnel (seguridad, overhead, complejidad)
- **Recomendaciones de seguridad para producción**

### Referencias:

**GRE y Túneles:**
- Cisco. (2023). *Configuring GRE Tunnels*. Cisco IOS IP Configuration Guide.
- RFC 2784: *Generic Routing Encapsulation (GRE)*
- RFC 2890: *Key and Sequence Number Extensions to GRE*

**IPSec y Seguridad:**
- Cisco. (2023). *Configuring Security for VPNs with IPSec*. Cisco IOS Security Configuration Guide.
- RFC 4301: *Security Architecture for the Internet Protocol*
- RFC 4303: *IP Encapsulating Security Payload (ESP)*
- RFC 5996: *Internet Key Exchange Protocol Version 2 (IKEv2)*
- NIST SP 800-77: *Guide to IPsec VPNs*

**Certificaciones y libros:**
- CCNP ENCOR 350-401: *Implementing Cisco Enterprise Network Core Technologies*
- CCNP ENARSI 300-410: *Implementing Cisco Enterprise Advanced Routing and Services*
- Odom, W., Healy, R. (2023). *CCNP Enterprise Core ENCOR 350-401 Official Cert Guide*. Cisco Press.
- White, R. (2023). *Optimal Routing Design*. Cisco Press.
- Frankel, S., Krishnan, S. (2011). *IP Security (IPsec) and Internet Key Exchange (IKE) Document Roadmap*. RFC 6071.

---

**Fecha de elaboración:** Marzo 2026  
**Versión:** 1.0  
**Nivel:** CCNA/CCNP
