# Examen Práctico Final - Red Empresarial "La Vaca Lola"

**Conmutación y Enrutamiento en Redes de Datos**
**Unidad 4 - Examen Práctico por Equipos**

---

## Instrucciones Generales

La empresa **La Vaca Lola S.A. de C.V.** requiere el diseño e implementación completo de su red empresarial en Packet Tracer. Usted y su equipo de trabajo son los ingenieros de red contratados para este proyecto.

**Dinámica de trabajo:**
- Equipos de 4 integrantes
- El profesor asignará a cada equipo el protocolo de ruteo dinámico y el protocolo de EtherChannel a implementar
- Cada equipo debe realizar el diseño de subneteo antes de iniciar la implementación
- El archivo `.pkt` y el documento de diseño se entregan al finalizar el tiempo asignado

**Recursos permitidos:**
- Packet Tracer (versión 8.x o superior)
- Calculadora de subneteo (o herramienta equivalente)
- Notas personales y apuntes del curso (libro abierto)
- No se permite comunicación entre equipos

---

## Contexto del Negocio

**La Vaca Lola S.A. de C.V.** es una empresa mexicana dedicada a la producción, procesamiento y comercialización de carne bovina. Cuenta con:

- **4 plantas de producción:** ubicadas en los estados de Sinaloa, Jalisco, Chihuahua y Durango
- **Sede corporativa:** en la planta de Sinaloa (Culiacán)
- **Puntos de Venta (tiendas):** 3 tiendas en Culiacán, Sinaloa (misma red metropolitana que la sede)
- **Personal:** operarios, veterinarios, cuidadores, administrativos y personal de ventas

### Descripción de Operaciones Relevantes para la Red

Las plantas operan con los siguientes sistemas que deben contemplarse en el diseño, **aunque no requieren configuración en Packet Tracer:**

- **Sistemas RFID:** chips en el ganado para seguimiento de ubicación en corrales y registro de consumo en comederos inteligentes. Se conectan vía Ethernet a la red local.
- **Sensores de temperatura:** monitoreo de cámaras de refrigeración. Conectados a la red.
- **Controles de acceso biométricos:** checadores de asistencia en oficinas, mataderos, refrigeración y embarque. Conectados a la red.
- **CCTV:** cámaras IP para vigilancia en toda la planta.
- **Servidores centrales** (en sede Sinaloa): DNS, Web, Base de Datos, Archivos.

> NOTE: Los sistemas RFID, sensores, controles de acceso y CCTV comparten la VLAN de Producción. Para fines del examen, basta con representarlos con un PC genérico o switch conectado a esa VLAN.

---

## Topología General

La red de La Vaca Lola tiene la siguiente estructura:

```
[Tiendas x3] ──┐
               ├──> [SW-SIN-DIST1] ══ EtherChannel ══ [SW-SIN-DIST2]
                         |                                      |
                    [Router SIN - Sede]  ←── WAN ───┬─── [Router JAL]
                                                    ├─── [Router CHI]
                                                    └─── [Router DGO]
                                              (Hub-and-Spoke)
```

> El diagrama exacto queda a criterio del equipo. Deben documentarlo en su archivo de diseño.
> La sede en Sinaloa actúa como hub WAN. Las plantas de Jalisco, Chihuahua y Durango son spokes con infraestructura equivalente entre sí.

---

## Parámetros de Red

### Espacio de Direccionamiento

- **Red IPv4 base:** `172.16.0.0/16`  
- **Red IPv6 base:** `2026:BACA::/32`  
- El equipo debe realizar el subnetting necesario para todas las VLANs y enlaces WAN/punto a punto.

### Dual Stack

- **Toda la red** debe implementarse en **Dual Stack (IPv4 e IPv6)**
- Cada subred IPv4 debe tener su equivalente en IPv6

### VLANs Requeridas (Globales)

Cada planta implementa las siguientes VLANs según corresponda a sus áreas funcionales:

| VLAN ID | Nombre | Descripción |
|---------|--------|-------------|
| **10** | MGMT | Administración de switches y routers |
| **20** | TI | Tecnologías de Información |
| **30** | RH | Recursos Humanos |
| **40** | MKTG | Mercadotecnia |
| **50** | VENTAS | Ventas |
| **60** | PRODUCCION | Producción, RFID, sensores, CCTV, biométricos |
| **70** | WIFI_CORP | Gestión de controladora WLC y APs |
| **80** | WIFI_PROD | SSID de personal en corrales y planta |
| **90** | SERVIDORES | Servidores (solo en sede Sinaloa) |

> Las plantas regulares (Jalisco, Chihuahua, Durango) tienen las VLANs operativas: MGMT, TI, PRODUCCION, VENTAS y WIFI_PROD. Las VLANs administrativas RH, MKTG, WIFI_CORP y SERVIDORES son exclusivas de la sede en Sinaloa.

---

## Requerimientos por Sitio

### Sede Corporativa - Sinaloa (Culiacán)

Es la planta principal. Concentra los servicios centrales y tiene mayor infraestructura que las demás.

**Infraestructura de conmutación:**
- **2 switches de distribución** interconectados con **EtherChannel** (protocolo asignado por el profesor: PAgP o LACP)
- **4 switches de acceso** conectados a los switches de distribución (2 por cada switch de distribución)
- Todas las VLANs definidas (VLAN 10 al 90)
- **VTP:** modo **Server**. Propaga VLANs a todos los switches de la red
- Todos los troncales configurados manualmente (**DTP deshabilitado**, `switchport nonegotiate`)
- **STP:** root bridge en SW-SIN-DIST1 y root secundario en SW-SIN-DIST2, definidos explícitamente para las VLANs críticas

**Redundancia y disponibilidad:**
- **HSRP** en las VLANs de TI, Producción y Ventas:
  - SW-SIN-DIST1: activo (priority 110, preempt)
  - SW-SIN-DIST2: standby (priority 100)

**Ruteo:**
- Router `R-SIN` como hub WAN: conectado a los routers de las 3 plantas
- **Dual Stack** en todas las interfaces
- Protocolo de ruteo dinámico asignado por el profesor

**Servicios:**
- **DHCPv4:** pools locales para todas las VLANs (excepto MGMT y SERVIDORES con IP estática)
- **DHCPv6 Stateless:** SLAAC habilitado + flag O en las VLANs de usuario
- Servidores a contemplar (no configurar internamente): DNS, Web, Base de Datos, Archivos

**WiFi:**
- **WLC (Wireless LAN Controller)** en VLAN 70 (WIFI_CORP)
- 2 Access Points Lightweight asociados a la WLC
- **2 SSIDs:**
  - `VacaLola-Corp`: empleados administrativos, WPA2-Enterprise (RADIUS)
  - `VacaLola-Prod`: personal en corrales/planta, WPA2-PSK, mapeado a VLAN 80

**Seguridad:**
- SSH v2 en todos los switches y routers
- Port Security en todos los puertos de acceso (máx. 1 MAC, violación: restrict)
- DHCP Snooping en todas las VLANs de usuario
- DAI en todas las VLANs de usuario
- Contraseñas encriptadas y banner en todos los dispositivos

---

### Plantas Regulares: Jalisco, Chihuahua y Durango

Las tres plantas tienen **infraestructura equivalente**. Son principalmente plantas de producción con oficinas administrativas reducidas comparado con la sede.

> Aplicar los mismos requerimientos a las tres plantas, sustituyendo el código de sitio correspondiente (JAL, CHI, DGO).

**Infraestructura de conmutación:**
- **1 switch de distribución**
- **2 switches de acceso** conectados al switch de distribución
- VLANs presentes: **MGMT, TI, PRODUCCION, VENTAS, WIFI_PROD**
- **VTP:** modo **Client** (recibe la base de datos de VLANs desde la sede Sinaloa)
- Troncales configurados manualmente, sin DTP
- STP: configurar puertos edge (`spanning-tree portfast`) en puertos de acceso a usuarios

**Ruteo:**
- Router con enlace WAN punto a punto hacia `R-SIN` (sede)
- **Dual Stack** en todas las interfaces
- Protocolo de ruteo dinámico asignado
- Ruta estática flotante de respaldo si el equipo lo considera necesario

**Servicios:**
- **DHCPv4:** pools locales para PRODUCCION, VENTAS y WIFI_PROD
- **DHCPv6 Stateless** en las VLANs de usuario
- MGMT usa direccionamiento estático

**WiFi:**
- **1 AP autónomo** (no lightweight, sin WLC)
- SSID: `VacaLola-[SITIO]-Prod` (ej: `VacaLola-JAL-Prod`), WPA2-PSK
- Conectado a la VLAN WIFI_PROD (80)

**Seguridad:**
- SSH v2 en router y switches
- Port Security en todos los puertos de acceso (máx. 1 MAC, violación: restrict)
- DHCP Snooping en VLANs de usuario
- DAI en VLANs de usuario
- Contraseñas encriptadas y banner

---

### Puntos de Venta (Tiendas) - 3 Sucursales

Las 3 tiendas están en Culiacán, Sinaloa, conectadas directamente a la red de la sede.

**Infraestructura:**
- Cada tienda: **1 switch de acceso**
- VLANs presentes: MGMT, VENTAS, WIFI_PROD
- **VTP:** modo Client
- Troncal hacia switch de distribución de la sede (SW-SIN-DIST)

**Conectividad:**
- Las 3 tiendas se conectan al switch de distribución de Sinaloa (misma LAN que la sede)
- Cada tienda tiene **1 AP autónomo** con SSID `VacaLola-Tienda-X` (X = 1, 2, 3), WPA2-PSK

**Servicios:**
- Obtienen DHCP del servidor centralizado de Sinaloa mediante **`ip helper-address`**
- No tienen servidor DHCP local

**Seguridad:**
- SSH v2, Port Security en todos los puertos

---

## Requerimientos de Ruteo

### Protocolo Dinámico (Asignado por el Profesor)

El equipo implementará **uno** de los siguientes protocolos en **toda la red**:

| Opción | Protocolo | Observaciones |
|--------|-----------|---------------|
| A | **RIPv2** | Habilitar también RIPng para IPv6 |
| B | **EIGRP** | Habilitar también EIGRPv6 |
| C | **OSPF Single Area** | OSPFv2 + OSPFv3 |

El protocolo asignado al equipo es: _________________________

### Ruteo Estático

Implementar rutas estáticas **solo** donde el protocolo dinámico no sea suficiente o conveniente:

- Ruta estática por defecto en cada planta hacia el ISP (internet) si aplica
- Rutas de respaldo (flotantes) donde haya redundancia de enlace

---

## EtherChannel

Implementar **EtherChannel** entre los 2 switches de distribución de la sede **Sinaloa** (SW-SIN-DIST1 y SW-SIN-DIST2).

El protocolo asignado al equipo es: _________________________

| Opción | Protocolo |
|--------|-----------|
| A | **PAgP** (Cisco propietario) |
| B | **LACP** (IEEE 802.3ad) |

**Requisitos del EtherChannel:**
- Mínimo 2 interfaces físicas agrupadas
- El Port-Channel debe transportar todas las VLANs de la sede como troncal
- Verificar con `show etherchannel summary`

---

## Resumen de Requerimientos Técnicos

| Tecnología | Dónde se implementa | Notas |
|------------|---------------------|-------|
| VLANs | Todos los sitios | Según tabla de VLANs |
| VTP Server/Client | Todos los switches | Server en Sinaloa (sede) |
| VTP Transparent | - | No aplica en este escenario |
| Trunks (sin DTP) | Todos los uplinks | `switchport nonegotiate` |
| STP | Sinaloa (explícito) | Root bridge y secundario definidos |
| EtherChannel | Distribución Sinaloa | PAgP o LACP (asignado) |
| HSRP | Sinaloa (TI, Ventas, Producción) | Con preemption |
| DHCPv4 | Todos los sitios | IP helper en tiendas |
| DHCPv6 Stateless | Todos los sitios | SLAAC + O-flag |
| Dual Stack | Toda la red | IPv4 + IPv6 en todas interfaces |
| Ruteo dinámico | Toda la red | RIP / EIGRP / OSPF (asignado) |
| Ruteo estático | Donde convenga | Default route, rutas flotantes |
| WLC + AP Lightweight | Sinaloa (sede) | 2 APs, 2 SSIDs |
| AP Autónomo | JAL, CHI, DGO y 3 tiendas | WPA2-PSK |
| SSH v2 | Todos los dispositivos | Solo SSHv2 |
| Port Security | Todos los puertos de acceso | Máx 1 MAC, restrict |
| DHCP Snooping | Todos los sitios | En VLANs de usuario |
| DAI | Todos los sitios | En VLANs de usuario |
| Servidores (contemplar) | Sinaloa (sede) | DNS, Web, BD, Archivos |

---

## Entregables

### 1. Documento de Diseño (PDF o Word)

Debe incluir:

**Portada**
- Nombre del proyecto: Red Empresarial La Vaca Lola
- Nombre y matrícula de cada integrante
- Protocolo de ruteo asignado y protocolo de EtherChannel asignado
- Fecha

**Tabla de Subneteo IPv4**

| Subred | Descripción (VLAN / Enlace) | Dirección de red | Máscara | Gateway | Rango usable | Broadcast |
|--------|------------------------------|-----------------|---------|---------|-------------|-----------|
| ... | ... | ... | ... | ... | ... | ... |

**Tabla de Subneteo IPv6**

| Subred | Descripción | Prefijo IPv6 | Longitud de prefijo |
|--------|-------------|--------------|---------------------|
| ... | ... | ... | ... |

**Diagrama de Topología** (captura de Packet Tracer o diagrama propio)
- Topología lógica con VLANs y direcciones IP de cada interfaz
- Topología WAN con protocolos y tipos de enlace

**Tabla de Dispositivos**

| Hostname | Tipo | Sitio | IP Mgmt | Función |
|----------|------|-------|---------|---------|
| ... | ... | ... | ... | ... |

**Justificaciones de Diseño:**
- ¿Por qué esa distribución de VLANs por sitio?
- ¿Dónde se decidió usar ruta estática y por qué?
- ¿Cómo se configuró STP para optimizar el uso de enlaces?

### 2. Archivo Packet Tracer (`.pkt`)

- Nombre de archivo: `LaVacaLola_EquipoX.pkt` (X = número de equipo)
- Todos los dispositivos deben tener hostnames apropiados (ej: `SW-SIN-DIST1`, `R-JAL`, `AP-TIENDA1`)
- Todos los dispositivos administrables deben tener **contraseña enable** y **acceso SSH configurado**
- Verificaciones visibles: usar `show` commands en la ventana de simulación donde sea posible

---

## Convención de Nombres de Dispositivos

| Tipo | Formato | Ejemplos |
|------|---------|---------|
| Router | `R-[SITIO]` | `R-SIN`, `R-JAL`, `R-CHI`, `R-DGO` |
| Switch Distribución | `SW-[SITIO]-DIST[N]` | `SW-SIN-DIST1`, `SW-SIN-DIST2` |
| Switch Acceso | `SW-[SITIO]-ACC[N]` | `SW-SIN-ACC1`, `SW-JAL-ACC1` |
| Switch Tienda | `SW-TIENDA[N]` | `SW-TIENDA1`, `SW-TIENDA2` |
| WLC | `WLC-SIN` | Solo en sede Sinaloa |
| AP Lightweight | `AP-SIN-[N]` | `AP-SIN-1`, `AP-SIN-2` |
| AP Autónomo | `AP-[SITIO]` / `AP-TIENDA[N]` | `AP-JAL`, `AP-CHI`, `AP-DGO`, `AP-TIENDA1` |
| Servidores | `SRV-[FUNCION]` | `SRV-DNS`, `SRV-WEB`, `SRV-BD` |

---

## Rúbrica de Evaluación

| Criterio | Puntos | Obtenido |
|----------|--------|----------|
| **Diseño** | | |
| Tabla de subneteo IPv4 completa y correcta | 6 | |
| Tabla de subneteo IPv6 completa y correcta | 4 | |
| Diagrama de topología claro y completo | 5 | |
| **Conmutación** | | |
| VLANs creadas correctamente en todos los sitios | 5 | |
| VTP configurado (Server en SIN, Client en demás) | 4 | |
| Troncales sin DTP (`nonegotiate`) | 3 | |
| STP: root bridge y secundario definidos explícitamente | 4 | |
| EtherChannel funcional (PAgP o LACP según asignado) | 6 | |
| HSRP en VLANs indicadas (con preemption) | 5 | |
| **Ruteo** | | |
| Protocolo dinámico asignado funcional en toda la red | 8 | |
| Dual Stack: IPv6 configurado en todas las interfaces | 5 | |
| Ruteo estático donde corresponde | 3 | |
| **Servicios** | | |
| DHCPv4 en todos los sitios (con helper en tiendas) | 5 | |
| DHCPv6 Stateless funcional | 4 | |
| **WiFi** | | |
| WLC con 2 APs lightweight y 2 SSIDs en Sinaloa | 6 | |
| APs autónomos en JAL, CHI, DGO y tiendas | 3 | |
| **Seguridad** | | |
| SSH v2 en todos los dispositivos administrables | 4 | |
| Port Security en todos los puertos de acceso | 4 | |
| DHCP Snooping configurado correctamente | 4 | |
| DAI configurado correctamente | 4 | |
| Contraseñas encriptadas y banner en todos los dispositivos | 3 | |
| **Presentación** | | |
| Hostnames correctos según convención | 2 | |
| Archivo .pkt organizado y limpio | 2 | |
| Justificaciones de diseño coherentes | 2 | |
| **TOTAL** | **100** | |

---

## Criterios de Evaluación por Equipo

**Se evalúa el archivo `.pkt` entregado al finalizar el tiempo.** Los puntos se otorgan si la funcionalidad está operativa (se verificará con comandos `show` y pruebas de ping entre VLANs).

**Penalizaciones:**
- Dispositivo sin hostname: -1 punto por dispositivo
- VLAN nativa sin cambiar (VLAN 1 activa en troncales): -3 puntos
- Contraseñas en texto plano: -2 puntos
- DTP habilitado en algún troncal: -2 puntos por interfaz

**Bonificación (+5 puntos, máximo 105):**
- Implementar correctamente **RADIUS** para autenticación del SSID corporativo en la WLC

---

## Asignaciones por Equipo

| Equipo | Protocolo de Ruteo | EtherChannel | Integrantes |
|--------|-------------------|--------------|-------------|
| 1 | | | |
| 2 | | | |
| 3 | | | |
| 4 | | | |
| 5 | | | |

*El profesor completará esta tabla al inicio del examen.*

---

## Comandos de Verificación Sugeridos

Al terminar, verificar el correcto funcionamiento con:

```
! Conmutación
show vlan brief
show interfaces trunk
show spanning-tree summary
show etherchannel summary
show standby brief

! Ruteo
show ip route
show ipv6 route
show ip protocols
show ip ospf neighbor    (si OSPF)
show ip eigrp neighbors  (si EIGRP)
show ip rip database     (si RIP)

! DHCP
show ip dhcp pool
show ip dhcp binding
show ipv6 dhcp pool

! Seguridad
show ip dhcp snooping binding
show ip arp inspection statistics
show port-security interface [int]
show ip ssh

! WiFi
show dot11 associations   (AP autónomo)
show capwap client rcb    (AP lightweight)
```

---

## Fecha y Condiciones de Entrega

| Campo | Valor |
|-------|-------|
| **Fecha del examen** | |
| **Duración** | 3 horas |
| **Modalidad** | Equipos de 4 integrantes |
| **Entrega** | Archivo `.pkt` + Documento de diseño |
| **Medio de entrega** | Moodle / correo institucional |
| **Penalización por retraso** | -10 puntos por cada 15 minutos |

---

*Documento elaborado para la materia Conmutación y Enrutamiento en Redes de Datos*
*Tecnológico Nacional de México*
