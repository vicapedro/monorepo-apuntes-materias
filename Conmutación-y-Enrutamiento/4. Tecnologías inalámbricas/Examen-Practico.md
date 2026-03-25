# Examen Práctico - Red Nacional JuanMark

## Instrucciones Generales

La compañía **JuanMark** le ha pedido hacer cambios en diferentes regiones de su red Nacional. Los cambios son en las siguientes áreas.

### Información de la Red

- **Dominio:** JuanMark.com
- **Número de Red IPv4:** 148.60.0.0/16
- **Red IPv6 (Dual Stack - Región Noroeste):** 2006:AFEA:B0CA::/48
- **Topología:** Ver diagrama JuanMark.drawio

#### Regiones de la Red:
1. **Noroeste** (NW) - Sitio: Yum Kaax
2. **Noreste** (NE) - Sitios: LaSilla, ElCabrito
3. **Sureste** - Sitio: LaVaca
4. **Centro**

#### Enlaces WAN:
- 1 Mbps
- 512 Kbps
- 1.5 Mbps

---

## Rúbrica de Evaluación

| Área | Valor | Obtenido |
|------|-------|----------|
| SSH en todos los dispositivos de comunicaciones | 5 | |
| Subnetting IPv4 | 8 | |
| IPv6 en algunas regiones (DualStack) | 5 | |
| Ruteo Estático sólo donde convenga | 5 | |
| RIP para toda la red | 8 | |
| VLAN acorde a la segmentación de red | 8 | |
| VTP al menos donde se indique | 5 | |
| Truncales que solo permitan las VLAN de la región. No DTP | 5 | |
| STP que minimice los enlaces subutilizados | 5 | |
| EtherChannel donde se indique. PAgP | 8 | |
| DHCP en todos los sitios (DHCPv6 donde haya IPv6) | 8 | |
| HSRP donde se indique | 8 | |
| WLAN donde se indique | 5 | |
| WLC donde se indique | 8 | |
| Seguridad en todos los puertos de todos los switches | 4 | |
| RADIUS para la autenticación en todos los Routers/Switches | 5 | |
| **TOTAL** | **100** | |

---

## Segmentación de VLANs

### Región Noroeste
- **VLAN 5:** Marketing
- **VLAN 6:** Ventas
- **VLAN 7:** Compras
- **VLAN 9:** Gestión de TI

### Región Noreste
- **VLAN 97:** Gestión de TI
- **VLAN 98:** Ventas
- **VLAN 99:** Compras
- **VLAN 100:** Servicios

### Región Centro
- **VLAN 33:** Gestión de TI
- **VLAN 34:** Gestión de WLAN
- **VLAN 35:** Ventas
- **VLAN 36:** Compras
- **VLAN 37:** Practicantes

### Región Sureste
- **VLAN 65:** Ventas
- **VLAN 66:** Gestión TI
- **VLAN 67:** Compras
- **VLAN 68:** MKT

---

## Requerimientos por Región

### Región Noreste (NE)

#### Tareas específicas:
1. **Configure HSRP** para que no se pierda conectividad con el resto de la red empresarial
   - Implementar redundancia de gateway 
   
2. **Configure el Access Point autónomo**
   - WLAN operativa
   
3. **Configure STP** para que no queden enlaces desactivados
   - Optimizar topología STP
   - Minimizar enlaces bloqueados
   
4. **Obtenga el árbol de expansión** para cada VLAN
   - Documentar topología STP por VLAN

#### Ruteadores:
- LaSilla
- ElCabrito
- LaVaca

---

### Región Noroeste (NW)

#### Tareas específicas:
1. **Implemente IPv4 e IPv6 (Dual Stack)**
   - Network ID IPv6: 2006:AFEA:B0CA::/48
   - Configurar direccionamiento dual stack
   
2. **Configure VTP Server**
   - Propagar VLANs a switches de la región
  
3. **Configure DHCP** 
   - En el router

4. **Ruteo inter VLAN**
   -  Router-on-a-stick
---

### Región Sureste
#### Tareas Específicas
1. **Configure HSRP** para que no se pierda conectividad con el resto de la red empresarial
   - Implementar redundancia de gateway 
2. **Configure VTP Server**
   - Propagar VLANs a switches de la región
3. **Configure STP** para que no queden enlaces desactivados
   - Minimizar enlaces bloqueados   
4. **EtherChannel**
   - Configure la agregación de enlaces donde se indique 
5. **WLAN**
   - Los diferentes departamentos tienen acceso a la red por WiFi y por cable. Configure la controladora.
---

### Región Centro

#### Características:
- Punto central de interconexión

#### Tareas especificas

- **Controladora de WLAN** 
  -  a las WLAN en los dos edificios.
- **VTP**
  - Propagar las VLAN a todos los switches
- **Seguridad de puertos** 
  - para prevenir ataques a la Tabla MAC
- **DAI** para evitar un servidor DHCP no autorizado

---

## Metodología de Trabajo

### Organización del Proyecto:
- El **diseño de la red** será por equipos
- La **configuración de cada dispositivo** de comunicaciones se hará en un **script**
- Todos los archivos del proyecto estarán en un **repositorio en GitHub**
- Para facilitar el trabajo colaborativo:
  - Cada región será un **archivo de Packet Tracer diferente**
  - Se comunicarán con el elemento "**Multiusuario**"
  
---

## Topología Inicial Proporcionada

Para facilitarle el trabajo se proporciona una topología inicial que contiene:

- **Cluster representando Internet**
- **Red inicial de JuanMark**
  - Un router con configuración mínima
  - Un servidor DNS configurado para resolver el dominio **juanmark.com**

---

## Requerimientos Técnicos Generales

### 1. SSH (5 puntos)
- Configurar acceso SSH en **todos los dispositivos de comunicaciones**
- Routers y Switches

### 2. Direccionamiento IP (13 puntos)

#### Subnetting IPv4 (8 puntos)
- Red base: **148.60.0.0/16**
- Diseñar subnetting apropiado por región/sitio
- Documentar plan de direccionamiento

#### IPv6 - Dual Stack (5 puntos)
- **Región Noroeste:** 2006:AFEA:B0CA::/48
- Implementar IPv4 e IPv6 simultáneamente
- DHCPv6 donde aplique

### 3. Enrutamiento (13 puntos)

#### Ruteo Estático (5 puntos)
- Implementar **sólo donde convenga**
- Optimizar rutas específicas

#### RIP (8 puntos)
- Configurar **RIP para toda la red**
- Versión 2
- Propagación automática de rutas

### 4. Conmutación y VLANs (26 puntos)

#### VLANs (8 puntos)
- Segmentación acorde a departamentos
- VLANs definidas por región

#### VTP (5 puntos)
- Configurar **al menos donde se indique**
- VTP Server en Región Noroeste
- VTP Client/Transparent en otras regiones

#### Truncales (5 puntos)
- Solo permitir las **VLAN de la región**
- **No DTP** (desactivar negociación automática)

#### STP (5 puntos)
- **Minimizar los enlaces subutilizados**
- Optimizar árbol de expansión
- Documentar topología resultante (Draw.io o mermaid.live)

#### EtherChannel (3 puntos)
- Configurar **donde se indique**
- Protocolo: **PAgP** (Cisco propietario)

### 5. Servicios de Red (16 puntos)

#### DHCP (8 puntos)
- DHCP en **todos los sitios**
- **DHCPv6** donde haya IPv6
- Configuración de pools apropiados

#### HSRP (8 puntos)
- Configurar **donde se indique**
- Alta disponibilidad de gateway
- Prioridades y preemption

### 6. Tecnologías Inalámbricas (13 puntos)

#### WLAN (5 puntos)
- Configurar **donde se indique**
- Access Point autónomo (Región Noreste)

#### WLC (8 puntos)
- Wireless LAN Controller **donde se indique**
- Lightweight APs
- Configuración centralizada

### 7. Seguridad (9 puntos)

#### Port Security (4 puntos)
- Seguridad en **todos los puertos de todos los switches**
- Límite de MACs
- Violation mode

#### RADIUS (5 puntos)
- Autenticación en **todos los Routers/Switches**
- Servidor AAA
- Configuración AAA en dispositivos

---

## Entregables

### Archivos de Packet Tracer:
- [ ] `JuanMark-Noroeste.pkt`
- [ ] `JuanMark-Noreste.pkt`
- [ ] `JuanMark-Sureste.pkt`
- [ ] `JuanMark-Centro.pkt`

### Scripts de Configuración:
- [ ] Scripts por cada router
- [ ] Scripts por cada switch

### Documentación:
- [ ] Plan de direccionamiento IPv4
- [ ] Plan de direccionamiento IPv6 (Noroeste)
- [ ] Topología STP por VLAN (Noroeste y Sureste)
- [ ] Configuración HSRP (Noreste y Sureste)
- [ ] Manual de usuario para acceso inalámbrico

### Repositorio GitHub:
- [ ] README.md con instrucciones
- [ ] Estructura de carpetas organizada
- [ ] Commits descriptivos por región/funcionalidad

---

## Notas Importantes

**Verificar:**
- Conectividad end-to-end
- Redundancia de enlaces críticos
- Seguridad en todos los puertos
- Autenticación centralizada
- Funcionamiento de servicios DHCP
- Resolución DNS para juanmark.com
- Acceso inalámbrico funcional

**Documentar:**
- Decisiones de diseño
- Justificación de rutas estáticas vs. RIP
- Distribución de VLANs
- Configuración HSRP y prioridades
- Troubleshooting realizado

**Validar:**
- Ping entre todas las regiones
- Traceroute para verificar rutas
- Failover de HSRP
- Balanceo de carga en EtherChannel
- Conectividad inalámbrica

---

## Referencias

- Diagrama de topología: `JuanMark.drawio`
- Configuración inicial: Router y DNS proporcionados
- Dominio: `juanmark.com`

