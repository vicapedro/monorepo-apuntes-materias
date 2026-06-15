# Examen Práctico Final - Red Empresarial "La Vaca Lola"

**Conmutación y Enrutamiento en Redes de Datos**
**Unidad 4 - Examen Práctico por Equipos (Multiusuario)**

---

## Instrucciones Generales

La empresa **La Vaca Lola S.A. de C.V.** requiere el diseño e implementación de su red empresarial distribuida en Packet Tracer. Cada equipo es responsable de una región completa; al final, todas las regiones se interconectan usando el **componente de Conexión Multiusuario** de Packet Tracer.

**Dinámica de trabajo:**
- Equipos de 4 integrantes
- Cada equipo diseña e implementa su región de forma independiente
- Al concluir la implementación individual, se conectan todas las regiones mediante el componente Multiusuario
- Se requiere que **todas las regiones funcionen** al mismo tiempo en la sesión de integración
- El equipo de la Región Centro (Equipo 1) aloja el servidor de conexión Multiusuario

**Entregables:**
- Un archivo `.pkt` por equipo con la topología completa de su región
- Un documento de diseño regional por equipo (ver sección Documentación)
- Un informe global de arquitectura y topología general, elaborado en conjunto por todos los equipos

**Recursos permitidos:**
- Packet Tracer 8.x o superior
- Calculadora de subnetting o herramienta equivalente
- Notas personales y sitio de NetAcad (*libro abierto*)
- Cada equipo realiza su propio diseño: no se aceptarán regiones con topologías idénticas entre sí

---

## Contexto del Negocio

**La Vaca Lola S.A. de C.V.** es una empresa mexicana dedicada a la producción, procesamiento y comercialización de carne bovina. Con presencia en los principales estados ganaderos del país —Sinaloa, Chihuahua, Sonora, Jalisco y Durango—, su operación está distribuida en **5 regiones** a nivel nacional, con una **Matriz corporativa en Culiacán, Sinaloa**.

### Modelo Operativo de Red

| Tipo de sitio | Conectividad | Servidores | Observaciones |
|---------------|-------------|-----------|---------------|
| **Matriz (Culiacán)** | WAN hub central | DNS, Web POS, BD Central, Archivos | Concentra servicios globales |
| **Planta de producción** | WAN spoke hacia su región; puede operar sin la Matriz | BD local, Archivos locales (replican a Matriz) | Autonomía operativa completa |
| **Tienda** | WAN hacia Matriz (vía región) | Ninguno | Depende de la Matriz para el Punto de Venta Web |

> WARNING: Si la WAN a la Matriz cae, las **plantas** continúan operando con sus servidores locales. Las **tiendas** pierden el acceso al Punto de Venta hasta que se restaure la conectividad.

### Sistemas Operativos en Red (No configurar en PT; representar con PCs genéricos)

- **RFID en corrales:** seguimiento de ganado, registro de consumo en comederos inteligentes
- **Sensores de temperatura:** monitoreo de cámaras de refrigeración en almacenes
- **Control de acceso biométrico:** checadores en oficinas, mataderos y almacenes
- **CCTV IP:** vigilancia en toda la planta
- **Báscula conectada:** pesaje automático en matadero y embarque
- **Punto de Venta Web:** alojado en la Matriz, accedido desde tiendas vía HTTP/HTTPS

---

## Estructura Organizacional

### Mapa de Regiones, Plantas y Tiendas

```
La Vaca Lola S.A. DE C.V.
│
├── MATRIZ CORPORATIVA — Culiacán, Sinaloa
│   └── Servicios centrales: DNS, Web POS, BD Central, Archivos, Replicación
│
├── REGIÓN 1 - NOROESTE (Sinaloa)                  [Equipo 1]
│   ├── Planta Culiacán  (HQ + Matriz corporativa)
│   ├── Planta Navolato
│   ├── Tienda Culiacán-01
│   ├── Tienda Culiacán-02
│   └── Tienda Navolato-01
│
├── REGIÓN 2 - NORTE (Chihuahua)                   [Equipo 2]
│   ├── Planta Chihuahua  (HQ regional)
│   ├── Planta Cuauhtémoc
│   ├── Planta Hidalgo del Parral
│   ├── Tienda Chihuahua-01
│   ├── Tienda Chihuahua-02
│   └── Tienda Cuauhtémoc-01
│
├── REGIÓN 3 - NOROESTE-PACÍFICO (Sonora)          [Equipo 3]
│   ├── Planta Hermosillo  (HQ regional)
│   ├── Planta Ciudad Obregón
│   ├── Planta Nogales
│   ├── Tienda Hermosillo-01
│   ├── Tienda Hermosillo-02
│   └── Tienda Obregón-01
│
├── REGIÓN 4 - OCCIDENTE (Jalisco)                 [Equipo 4]
│   ├── Planta Tepatitlán de Morelos  (HQ regional)
│   ├── Planta Lagos de Moreno
│   ├── Tienda Guadalajara-01
│   └── Tienda Guadalajara-02
│
└── REGIÓN 5 - NORTE-CENTRO (Durango)              [Equipo 5]
    ├── Planta Durango  (HQ regional)
    ├── Planta Gómez Palacio
    ├── Planta Santiago Papasquiaro
    ├── Tienda Durango-01
    ├── Tienda Durango-02
    └── Tienda Gómez Palacio-01
```

### Tabla Resumen de Sitios

| Región | Código | Equipo | Plantas | Tiendas | Estado / Ciudades principales |
|--------|--------|--------|---------|---------|------------------------------|
| Noroeste | CUL | 1 | 2 | 3 | Sinaloa: Culiacán, Navolato |
| Norte | CHI | 2 | 3 | 3 | Chihuahua: Chih., Cuauhtémoc, Parral |
| Noroeste-Pacífico | SON | 3 | 3 | 3 | Sonora: Hermosillo, Cd. Obregón, Nogales |
| Occidente | JAL | 4 | 2 | 2 | Jalisco: Tepatitlán, Lagos de Moreno, Guadalajara |
| Norte-Centro | DGO | 5 | 3 | 3 | Durango: Durango, Gómez Palacio, Stgo. Papasquiaro |

---

## Topología General de Red

```
                     ┌─────────────────────────────────┐
                     │     MATRIZ CORPORATIVA (CUL)     │
                     │  SRV-DNS / SRV-WEB / SRV-BD /    │
                     │  SRV-ARCH / SRV-REPL             │
                     │  R-MATRIZ ── [Core L3]            │
                     └──────────────┬──────────────────┘
                    WAN Hub-and-Spoke │ (EIGRP)
          ┌──────────────────────────┼─────────────────────────┐
          │                          │                         │
    ┌─────┴────┐               ┌─────┴────┐             ┌─────┴────┐
    │ R-CHI    │               │ R-SON    │             │ R-JAL    │
    │ Región 2 │               │ Región 3 │             │ Región 4 │
    └──────────┘               └──────────┘             └──────────┘
          │
    ┌─────┴────┐
    │ R-DGO    │
    │ Región 5 │
    └──────────┘

Nota: El diagrama detallado (con plantas y tiendas) queda a criterio de cada equipo.
      Documentarlo en el informe de diseño.
```

Cada región tiene internamente:

```
    R-[REGIÓN]  (Router regional / conexión a Matriz)
         │
    [SW-HQ-DIST1] ══ EtherChannel ══ [SW-HQ-DIST2]
         │                                │
    [SW-HQ-ACC1]  [SW-HQ-ACC2]     [SW-HQ-ACC3]
         │
    WAN spoke ──> R-[PLANTA-B] ──> R-[PLANTA-C]
                      │                  │
                 Planta satélite    Planta satélite
```

---

## Parámetros de Red

### Espacio de Direccionamiento IPv4 (VLSM sobre 10.0.0.0/8)

Cada equipo recibe un bloque /16 para su región. El bloque WAN inter-región es administrado por el Equipo 1.

| Región | Equipo | Bloque IPv4 asignado |
|--------|--------|----------------------|
| Noroeste (Culiacán, Sinaloa) | 1 | `10.1.0.0/16` |
| Norte (Chihuahua) | 2 | `10.2.0.0/16` |
| Noroeste-Pacífico (Sonora) | 3 | `10.3.0.0/16` |
| Occidente (Jalisco) | 4 | `10.4.0.0/16` |
| Norte-Centro (Durango) | 5 | `10.5.0.0/16` |
| WAN inter-región (Multiusuario) | 1 (administra) | `10.0.0.0/24` |

> El equipo debe realizar VLSM dentro de su bloque /16 para asignar subredes a cada VLAN de cada planta y a cada enlace punto a punto (WAN intra-región y WAN inter-región).

### Espacio de Direccionamiento IPv6

- **Prefijo global asignado:** `2026:6060:600D::/48`
- Cada región recibe un bloque /52 para subnetting interno, las subredes deberán quedar /64:

| Región | Equipo | Bloque IPv6 asignado |
|--------|--------|----------------------|
| Noroeste (Sinaloa) | 1 | `2026:6060:600D:1000::/52` |
| Norte (Chihuahua) | 2 | `2026:6060:600D:2000::/52` |
| Noroeste-Pacífico (Sonora) | 3 | `2026:6060:600D:3000::/52` |
| Occidente (Jalisco) | 4 | `2026:6060:600D:4000::/52` |
| Norte-Centro (Durango) | 5 | `2026:6060:600D:5000::/52` |
| WAN inter-región | 1 (administra) | `2026:6060:600D::/52` |

### Dual Stack

Toda la red debe implementarse en **Dual Stack (IPv4 + IPv6)**. Cada subred IPv4 debe tener su equivalente IPv6 configurado.

### VLANs Globales (Estandarizadas en Todas las Regiones)

El mismo esquema de VLANs se usa en todas las plantas para facilitar la interoperabilidad y administración centralizada.

| VLAN ID | Nombre | Descripción | Dónde aplica |
|---------|--------|-------------|--------------|
| **10** | MGMT | Administración de switches y routers | Todos los sitios |
| **20** | TI | Tecnologías de Información | Plantas |
| **30** | ADMIN | Administrativo (RR.HH., Finanzas) | Plantas |
| **40** | CORRALES | Corrales: RFID, comederos inteligentes, sensores | Plantas |
| **50** | MATADERO | Matadero: pesaje, control de acceso biométrico | Plantas |
| **60** | ALMACEN | Almacén y cámaras de refrigeración (sensores) | Plantas |
| **70** | VENTAS | Ventas locales (tiendas de planta) | Plantas |
| **80** | SERVIDORES | Servidores locales de planta (BD + archivos) | Plantas (no tiendas) |
| **90** | WIFI | WiFi corporativo de planta | Plantas |
| **100** | CAMARAS | CCTV IP y seguridad física | Plantas |
| **110** | SERV_CENTRAL | Servidores centrales de la Matriz | Solo Matriz (Región 1) |
| **120** | REPLICACION | Canal de replicación datos planta → Matriz | Solo Matriz (Región 1) |

> Las VLANs 110 y 120 son exclusivas de la Región 1 (Matriz). Las plantas satélite solo implementan las VLANs que correspondan a sus áreas físicas.

---

## Requerimientos por Tipo de Sitio

### A. Planta HQ Regional (Planta Principal de cada Región)

Es la planta con mayor infraestructura de cada región. Aloja el router regional que conecta con la Matriz. Aplica a: **Culiacán (R1), Chihuahua (R2), Hermosillo (R3), Tepatitlán de Morelos (R4) y Durango (R5).**

**NOTA para Equipo 1:** La Planta HQ de la Región Centro es también la **Matriz corporativa**. Debe incluir adicionalmente las VLANs 110 y 120, y los servidores centrales (SRV-DNS, SRV-WEB, SRV-BD, SRV-ARCH, SRV-REPL).

**Infraestructura de conmutación:**
- **2 switches de distribución** (Capa 3) interconectados con **EtherChannel** (LACP)
- **3 switches de acceso** distribuidos por área física (TI/Admin, Producción, Ventas/Almacén)
- VLANs: MGMT, TI, ADMIN, CORRALES, MATADERO, ALMACEN, VENTAS, SERVIDORES, WIFI, CAMARAS
- **VTP modo Server:** propaga VLANs a todos los switches de la región
- Troncales configurados manualmente (`switchport nonegotiate`, sin DTP)
- **STP:** root bridge en DIST1 y root secundario en DIST2, configurados explícitamente para VLANs críticas (TI, CORRALES, MATADERO)

**Redundancia (FHRP):**
- **HSRP** en VLANs TI, CORRALES y SERVIDORES:
  - DIST1: activo (priority 110, preempt habilitado)
  - DIST2: standby (priority 100)

**Ruteo:**
- Router `R-[REGIÓN]` como punto de conexión WAN hacia la Matriz y hacia plantas satélite
- **EIGRP** como protocolo de ruteo dinámico en toda la región e inter-región
- **Dual Stack** en todas las interfaces
- Rutas estáticas flotantes donde se justifique (enlace de respaldo)

**DHCP:**
- Pools DHCPv4 locales para cada VLAN operativa (excepto MGMT y SERVIDORES con IP estática)
- DHCPv6 Stateless (SLAAC + O-flag) en VLANs de usuario

**Servidores locales de planta:**
- `SRV-[PLANTA]-BD`: Base de datos local (operaciones de planta)
- `SRV-[PLANTA]-ARCH`: Archivos locales
- Ambos en VLAN 80 (SERVIDORES); deben tener conectividad con la Matriz para replicación

**Servidores centrales (solo Matriz - Equipo 1):**
- `SRV-DNS`, `SRV-WEB` (Web POS), `SRV-BD` (central), `SRV-ARCH` (central), `SRV-REPL` (replicación)
- En VLAN 110 (SERV_CENTRAL) con IP estática

**WiFi:**
- 1 AP autónomo con SSID `LVL-[REGION]-Corp` (WPA2-PSK, corporativo)
- Conectado a VLAN 90 (WIFI)
- OPCIONAL: Si el equipo implementa WLC, usar 2 APs Lightweight y 2 SSIDs (`LVL-[REGION]-Corp` y `LVL-[REGION]-Prod`)

**Seguridad:**
- SSH v2 en todos los dispositivos administrables
- Port Security en todos los puertos de acceso (máx. 1 MAC, violación: restrict)
- DHCP Snooping en todas las VLANs de usuario
- DAI en todas las VLANs de usuario
- Contraseñas encriptadas (`service password-encryption`) y banner MOTD en todos los dispositivos

---

### B. Plantas Satélite (Plantas Secundarias de cada Región)

Son las plantas de producción de menor tamaño dentro de cada región. Cuentan con infraestructura propia pero se conectan a la Planta HQ Regional vía WAN simulada. Pueden operar **sin conectividad con la Matriz**.

Aplica a las plantas que no son HQ:

| Región | Plantas satélite |
|--------|-----------------|
| 1 - Noroeste | Navolato |
| 2 - Norte | Cuauhtémoc, Hidalgo del Parral |
| 3 - Noroeste-Pacífico | Ciudad Obregón, Nogales |
| 4 - Occidente | Lagos de Moreno |
| 5 - Norte-Centro | Gómez Palacio, Santiago Papasquiaro |

**Infraestructura de conmutación:**
- **1 switch de distribución** (o L3 switch) como núcleo de planta
- **2 switches de acceso** (por área: Producción y Administración)
- VLANs activas: MGMT, TI, CORRALES, MATADERO, ALMACEN, VENTAS, SERVIDORES, WIFI, CAMARAS
- **VTP modo Client** (recibe VLANs del VTP Server de su HQ regional)
- Troncales sin DTP, configurados manualmente
- STP: configurar `spanning-tree portfast` en puertos de acceso a usuarios finales

**Ruteo:**
- Router `R-[PLANTA]` con enlace WAN punto a punto hacia `R-[REGIÓN]` (HQ regional)
- EIGRP habilitado; el router de planta redistribuye las redes locales hacia la región
- Dual Stack en todas las interfaces
- **Ruta estática de respaldo** (flotante, AD 200) si se justifica en el diseño

**DHCP:**
- Pools DHCPv4 locales para CORRALES, MATADERO, ALMACEN, VENTAS, WIFI
- DHCPv6 Stateless en VLANs de usuario
- MGMT y SERVIDORES usan IP estática

**Servidores locales:**
- `SRV-[PLANTA]-BD`: operaciones de planta (VLAN 80, IP estática)
- `SRV-[PLANTA]-ARCH`: archivos locales (VLAN 80, IP estática)

**WiFi:**
- 1 AP autónomo, SSID `LVL-[PLANTA]-Prod` (WPA2-PSK)
- Conectado a VLAN 90 (WIFI)

**Seguridad:**
- SSH v2, Port Security (máx. 1 MAC, restrict), DHCP Snooping, DAI
- Contraseñas encriptadas y banner

---

### C. Tiendas

Puntos de venta al público. No cuentan con servidores locales ni con infraestructura de red administrada por los equipos; acceden al **Punto de Venta Web (SRV-WEB)** alojado en la Matriz a través de un **ISP regional**.

> NOTE: La infraestructura del ISP (routers y enlaces) será proporcionada por el profesor como un archivo `.pkt` de referencia adjunto a esta tarea en el LMS (Moodle). Los equipos **no configuran el ISP**; únicamente configuran el AP de cada tienda.

> NOTE: El uso de VPN está fuera del alcance de este curso. La conectividad de las tiendas hacia la Matriz se da a través del ISP simulado en Packet Tracer.

**Infraestructura (por tienda):**
- **1 Access Point** (en modo router/gateway) conectado al enlace del ISP regional
- SSID: `LVL-Tienda-[CÓDIGO]` (WPA2-PSK)
- DHCP para clientes WiFi: habilitado en el propio AP

**Conectividad:**
- El AP de la tienda se conecta al router ISP provisto por el profesor
- Los clientes en tienda acceden al Web POS (`SRV-WEB`) y resuelven nombres a través del `SRV-DNS` de la Matriz mediante el ISP
- Si el ISP no está disponible, la tienda pierde acceso al sistema de ventas

**Seguridad:**
- Contraseña WPA2-PSK en el SSID de la tienda

---

## Requerimientos de Ruteo

### EIGRP (Protocolo Principal)

EIGRP se implementa en **toda la red**: dentro de cada región y entre regiones (a través de los enlaces multiusuario hacia la Matriz).

| Ámbito | AS EIGRP | Observaciones |
|--------|----------|---------------|
| Toda la red | **100** | Un solo AS para todas las regiones y la Matriz |

- Habilitar también **EIGRPv6** (o `address-family ipv6`) para Dual Stack
- Sumarizar rutas por región donde sea posible (CIDR)
- La Matriz (R-MATRIZ) debe redistribuir la ruta por defecto hacia todas las regiones

### Ruteo Estático

Implementar rutas estáticas **solo** donde el protocolo dinámico no sea suficiente:

- **Ruta estática por defecto** en R-MATRIZ hacia el ISP (internet), si se incluye ISP en la topología
- **Rutas flotantes** en plantas satélite si tienen enlace de respaldo hacia la HQ regional
- Documentar y justificar cada ruta estática en el informe de diseño

---

## EtherChannel

Implementar **EtherChannel LACP** entre los 2 switches de distribución de la **Planta HQ Regional** de cada región.

**Requisitos:**
- Mínimo 2 interfaces físicas agrupadas (Port-Channel)
- El Port-Channel debe transportar todas las VLANs como troncal
- Verificar con `show etherchannel summary`

---

## Conexión Multiusuario (Integración de Regiones)

Cada región implementada en un archivo `.pkt` independiente se conecta a la Matriz usando el componente **Packet Tracer Multiuser**.

**Procedimiento de integración:**
1. El Equipo 1 configura y publica el servidor Multiusuario en Packet Tracer
2. Cada equipo (2 al 5) conecta su router regional (`R-CHI`, `R-SON`, `R-JAL`, `R-DGO`) al router de la Matriz (`R-MATRIZ`) a través del componente Multiusuario
3. Los vecinos EIGRP deben establecerse entre `R-MATRIZ` y cada router regional
4. Verificar conectividad extremo a extremo entre regiones (ping entre VLANs de distintas regiones)
5. Verificar que las tiendas acceden al servidor Web POS de la Matriz

**Validación de integración:**
- Ping desde PC en VLAN CORRALES de Región 2 (Chihuahua) hacia SRV-WEB en Región 1 (Matriz)
- Ping desde una tienda de Región 5 (Durango) hacia SRV-DNS en Región 1
- `show ip eigrp neighbors` en R-MATRIZ muestra los 4 vecinos regionales (R-CHI, R-SON, R-JAL, R-DGO)
- `show ip route` en R-MATRIZ muestra todas las subredes de todas las regiones

---

## Planos Físicos de las Plantas en Packet Tracer

Cada equipo debe elaborar un **plano ficticio** para cada una de sus plantas de producción usando la **Vista Física (Physical Workspace)** de Packet Tracer.

**Instrucciones:**
1. En la vista Physical de Packet Tracer, crear un edificio o área por planta
2. Dentro de cada planta, crear al menos **3 habitaciones o zonas** que representen:
   - Corrales y área de ganado
   - Matadero y área de proceso
   - Almacén y cámaras de refrigeración
   - Oficinas administrativas
3. Colocar los dispositivos de red en la zona física correspondiente:
   - Switches de acceso en el área que sirven
   - Router/L3 switch en el cuarto de telecomunicaciones
   - Servidores en la sala de servidores
   - APs en áreas con cobertura WiFi requerida
4. Incluir **capturas de pantalla** de la vista física en el documento de diseño

> Los planos son ficticios; no es necesario que repliquen instalaciones reales. Lo importante es que la ubicación de los dispositivos sea coherente con las áreas de la planta.

---

## Resumen de Requerimientos Técnicos

| Tecnología | Dónde se implementa | Notas |
|------------|---------------------|-------|
| VLANs | Todos los sitios | Según tabla de VLANs estandarizada |
| VTP Server | HQ de cada región | Propaga a switches de la región |
| VTP Client | Plantas satélite | Recibe del Server regional |
| Trunks (sin DTP) | Todos los uplinks | `switchport nonegotiate` |
| STP | HQ regional (explícito); satélites (portfast) | Root/secundario definidos en HQ |
| EtherChannel LACP | Entre DIST1 y DIST2 en cada HQ | Port-Channel con todas las VLANs |
| HSRP (FHRP) | HQ regional (VLANs TI, CORRALES, SERVIDORES) | Priority 110 activo, 100 standby, preempt |
| EIGRP AS 100 | Toda la red (intra e inter-región) | + EIGRPv6 para IPv6 |
| Ruteo estático | Donde se justifique | Default route, flotantes |
| Dual Stack | Todas las interfaces | IPv4 + IPv6 |
| VLSM | Dentro del /16 de cada región | Subredes por VLAN y por enlace |
| DHCP local | HQ y plantas satélite | Pools por VLAN; tiendas usan ip helper |
| DHCPv6 Stateless | VLANs de usuario | SLAAC + O-flag |
| Port Security | Todos los puertos de acceso | Máx. 1 MAC (tiendas: 2), restrict |
| DHCP Snooping | VLANs de usuario en todos los sitios | Trusted port en uplinks |
| DAI | VLANs de usuario en todos los sitios | Trusted port en uplinks |
| SSH v2 | Todos los dispositivos administrables | Deshabilitar Telnet |
| Contraseñas cifradas + banner | Todos los dispositivos | `service password-encryption` |
| Servidores locales de planta | VLAN 80 de cada planta | BD y Archivos locales; replican a Matriz |
| Servidores centrales | Matriz (Región 1) | DNS, Web POS, BD Central, Archivos, Replicación |
| AP autónomo (planta) | Todas las plantas | WPA2-PSK, conectado a VLAN 90 |
| AP gateway (tienda) | Todas las tiendas | WPA2-PSK, conectado al ISP regional (provisto por profesor) |
| WLC + AP Lightweight | OPCIONAL (HQ que lo elija) | 2 APs, 2 SSIDs |
| Planos físicos PT | Cada planta de producción | Con zonas: corrales, matadero, almacén, oficinas |
| Conexión Multiusuario | Entre R-MATRIZ y R-[REGIÓN] x4 | EIGRP entre regiones |

---

## Documentación Requerida

### Documento Regional (uno por equipo)

**Portada:**
- Nombre de la empresa: La Vaca Lola S.A. de C.V.
- Región asignada y nombre de las plantas y tiendas
- Nombre y matrícula de cada integrante
- Fecha

**1. Tabla de Subneteo IPv4**

| Subred | Sitio | VLAN / Enlace | Dir. de Red | Máscara | Gateway | Rango usable | Broadcast |
|--------|-------|---------------|-------------|---------|---------|-------------|-----------|
| ... | ... | ... | ... | ... | ... | ... | ... |

**2. Tabla de Subneteo IPv6**

| Subred | Sitio | VLAN / Enlace | Prefijo IPv6 | Long. de prefijo |
|--------|-------|---------------|--------------|-----------------|
| ... | ... | ... | ... | ... |

**3. Tabla de Dispositivos**

| Hostname | Tipo | Sitio | IP Mgmt (IPv4) | IP Mgmt (IPv6) | Función |
|----------|------|-------|---------------|----------------|---------|
| ... | ... | ... | ... | ... | ... |

**4. Diagrama de Topología Lógica**
- Topología lógica con VLANs, IPs en interfaces y vecinos EIGRP
- Incluir el enlace WAN hacia la Matriz y enlaces WAN intra-región (planta-a-planta)

**5. Diagrama de Topología Física (Planos de Planta)**
- Capturas de la Vista Física de Packet Tracer de cada planta
- Identificar zonas: corrales, matadero, almacén, oficinas, sala de servidores

**6. Justificaciones de Diseño**
- ¿Cómo se realizó el VLSM y por qué se eligieron esos tamaños de subred?
- ¿Dónde se decidió usar ruta estática flotante y por qué?
- ¿Cómo se configuró STP para evitar loops y optimizar el uso de enlaces?
- ¿Cómo garantiza la planta su autonomía operativa si cae la WAN hacia la Matriz?
- ¿Qué impacto tiene la caída de WAN en las tiendas y cómo se mitiga?

**7. Evidencias de Funcionamiento**
- Capturas de `show` commands representativos (ver sección Comandos de Verificación)
- Ping exitoso entre VLANs de distintas plantas dentro de la región
- Ping exitoso desde una tienda hacia el servidor Web POS (Matriz)

---

### Informe Global de Arquitectura (un documento por todos los equipos)

Elaborado en conjunto al finalizar la sesión de integración multiusuario.

**Contenido:**
1. Diagrama de topología WAN completo (todas las regiones + Matriz)
2. Tabla de prefijos/bloques por región y tabla de bloques WAN inter-región
3. Tabla de vecinos EIGRP de R-MATRIZ
4. Evidencia de conectividad extremo a extremo (pings entre regiones diferentes)
5. Análisis breve: ¿Qué ocurre con las tiendas si cae el enlace de su región a la Matriz?
6. Conclusiones del equipo sobre el diseño jerárquico y distribuido

---

## Convención de Nombres de Dispositivos

| Tipo | Formato | Ejemplos |
|------|---------|---------|
| Router Matriz | `R-MATRIZ` | `R-MATRIZ` |
| Router Regional (HQ) | `R-[REGIÓN]` | `R-CUL`, `R-CHI`, `R-SON`, `R-JAL`, `R-DGO` |
| Router Planta Satélite | `R-[PLANTA]` | `R-NAV`, `R-CUH`, `R-PAR`, `R-OBR`, `R-NOG`, `R-LAG`, `R-GOP`, `R-SPA` |
| SW Distribución HQ | `SW-[REGIÓN]-DIST[N]` | `SW-CUL-DIST1`, `SW-CHI-DIST2` |
| SW Acceso Planta | `SW-[PLANTA]-ACC[N]` | `SW-NAV-ACC1`, `SW-OBR-ACC2` |
| WLC (opcional) | `WLC-[PLANTA]` | `WLC-CUL`, `WLC-CHI` |
| AP Lightweight (opcional) | `AP-[PLANTA]-[N]` | `AP-CUL-1`, `AP-CHI-2` |
| AP Autónomo Planta | `AP-[PLANTA]` | `AP-NAV`, `AP-OBR`, `AP-LAG` |
| AP Tienda (gateway) | `AP-T-[CÓDIGO][N]` | `AP-T-CUL01`, `AP-T-CHI01` |
| Servidor Planta | `SRV-[PLANTA]-[FUNC]` | `SRV-NAV-BD`, `SRV-OBR-ARCH` |
| Servidor Matriz | `SRV-[FUNC]` | `SRV-DNS`, `SRV-WEB`, `SRV-BD`, `SRV-REPL` |

---

## Rúbrica de Evaluación

### Documento Regional (por equipo)

| Criterio | Puntos | Obtenido |
|----------|--------|----------|
| **Diseño y Documentación** | | |
| Tabla de subneteo IPv4 completa y correcta para toda la región | 5 | |
| Tabla de subneteo IPv6 completa y correcta | 4 | |
| Tabla de dispositivos completa | 2 | |
| Diagrama de topología lógica claro y correcto | 4 | |
| Planos físicos de plantas en PT (captura por planta) | 5 | |
| Justificaciones de diseño coherentes y bien argumentadas | 5 | |
| **Conmutación** | | |
| VLANs creadas correctamente en todos los sitios de la región | 4 | |
| VTP (Server en HQ, Client en satélites y tiendas) | 3 | |
| Troncales sin DTP (`nonegotiate`) en todos los uplinks | 3 | |
| STP: root y root secundario definidos en HQ | 3 | |
| EtherChannel LACP funcional entre DIST1 y DIST2 | 6 | |
| HSRP en VLANs indicadas (preempt habilitado) | 5 | |
| **Ruteo y Direccionamiento** | | |
| EIGRP AS 100 funcional dentro de la región | 6 | |
| EIGRPv6 funcional (o EIGRP AF IPv6) | 4 | |
| Dual Stack configurado en todas las interfaces | 4 | |
| Ruteo estático justificado y documentado | 3 | |
| **Servicios** | | |
| DHCPv4 en HQ y plantas satélite; ip helper en tiendas | 5 | |
| DHCPv6 Stateless funcional | 3 | |
| Servidores locales de planta (BD y Archivos) con IP estática | 3 | |
| **Seguridad** | | |
| SSH v2 en todos los dispositivos administrables | 3 | |
| Port Security en todos los puertos de acceso | 3 | |
| DHCP Snooping configurado correctamente | 3 | |
| DAI configurado correctamente | 3 | |
| Contraseñas encriptadas y banner en todos los dispositivos | 2 | |
| **WiFi** | | |
| AP autónomo funcional en cada planta | 3 | |
| AP gateway funcional en cada tienda (conecta al ISP) | 2 | |
| **Organización del archivo .pkt** | | |
| Hostnames correctos según convención | 2 | |
| Archivo .pkt limpio y organizado | 2 | |
| **TOTAL DOCUMENTO REGIONAL** | **100** | |

### Informe Global (todos los equipos)

| Criterio | Puntos | Obtenido |
|----------|--------|----------|
| Diagrama WAN completo con todas las regiones | 20 | |
| Tabla de bloques de direccionamiento por región | 10 | |
| Evidencia de vecinos EIGRP en R-MATRIZ (4 vecinos) | 20 | |
| Evidencia de ping exitoso entre regiones distintas | 20 | |
| Evidencia de tienda accediendo a SRV-WEB (Matriz) | 15 | |
| Análisis de impacto de caída WAN y mitigación | 15 | |
| **TOTAL INFORME GLOBAL** | **100** | |

### Penalizaciones (aplican a ambas calificaciones)

- Dispositivo sin hostname o con hostname incorrecto: **-1 punto** por dispositivo
- VLAN nativa sin cambiar (VLAN 1 activa en troncales): **-3 puntos** por interfaz
- Contraseñas en texto plano visibles: **-2 puntos** por dispositivo
- DTP habilitado en algún troncal: **-2 puntos** por interfaz
- Tienda con servidor local (no permitido): **-5 puntos**
- Planta sin servidor local (VLAN 80 vacía): **-3 puntos** por planta

### Bonificación

| Concepto | Puntos extra |
|----------|-------------|
| WLC con 2 APs Lightweight y 2 SSIDs (corp + producción) | +5 puntos |
| RADIUS configurado para SSID corporativo en WLC | +3 puntos adicionales |
| Ruta flotante funcional y demostrada en la integración | +3 puntos |

---

## Asignaciones por Equipo

| Equipo | Región | Código | Plantas | Tiendas | Integrantes |
|--------|--------|--------|---------|---------|-------------|
| 1 | Noroeste (Culiacán + Matriz) | CUL | Culiacán, Navolato | CUL-01, CUL-02, NAV-01 | |
| 2 | Norte (Chihuahua) | CHI | Chihuahua, Cuauhtémoc, H. del Parral | CHI-01, CHI-02, CUH-01 | |
| 3 | Noroeste-Pacífico (Sonora) | SON | Hermosillo, Cd. Obregón, Nogales | HMO-01, HMO-02, OBR-01 | |
| 4 | Occidente (Jalisco) | JAL | Tepatitlán, Lagos de Moreno | GDL-01, GDL-02 | |
| 5 | Norte-Centro (Durango) | DGO | Durango, Gómez Palacio, Stgo. Papasquiaro | DGO-01, DGO-02, GOP-01 | |

*El profesor completará los integrantes al inicio del examen.*

---

## Comandos de Verificación Sugeridos

```
! === CONMUTACIÓN ===
show vlan brief
show interfaces trunk
show spanning-tree summary
show spanning-tree vlan [ID] detail
show etherchannel summary
show standby brief
show port-security interface [int]

! === VTP ===
show vtp status
show vtp password

! === RUTEO ===
show ip route
show ipv6 route
show ip eigrp neighbors
show ip eigrp topology
show ipv6 eigrp neighbors
show ip protocols

! === DHCP ===
show ip dhcp pool
show ip dhcp binding
show ip dhcp snooping binding
show ipv6 dhcp pool

! === SEGURIDAD ===
show ip arp inspection statistics
show ip ssh
show run | include username
show run | include banner

! === WiFi (AP autónomo) ===
show dot11 associations

! === WiFi (AP Lightweight con WLC - opcional) ===
show capwap client rcb

! === MULTIUSUARIO (Integración) ===
! Verificar en R-MATRIZ:
show ip eigrp neighbors
show ip route eigrp
ping [IP en región remota]
```

---

## Condiciones de Entrega

| Campo | Valor |
|-------|-------|
| **Fecha del examen (fase individual)** | |
| **Fecha de integración multiusuario** | |
| **Duración fase individual** | 3 horas |
| **Duración sesión de integración** | 1 hora |
| **Modalidad** | Equipos de 4 integrantes |
| **Entrega documento regional** | Al finalizar la fase individual |
| **Entrega informe global** | Al finalizar la sesión de integración |
| **Nombre archivo .pkt** | `CdP_Region[N]_Equipo[N].pkt` |
| **Nombre informe regional** | `CdP_Region[N]_Equipo[N]_Diseño.pdf` |
| **Nombre informe global** | `CdP_InformeGlobal.pdf` |
