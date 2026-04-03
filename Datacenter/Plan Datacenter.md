# Plan de Diseño de Datacenter

## Información del Proyecto

**Nombre del Proyecto:** Datacenter Corporativo - TecnoSoft S.A.  
**Ubicación Propuesta:** Monterrey, Nuevo León, México  
**Fecha de Elaboración:** 30 de Marzo de 2026  
**Responsable:** Departamento de Infraestructura de TI  
**Versión:** 1.0

---

## Resumen Ejecutivo

Este documento presenta el plan maestro para el diseño, construcción e implementación de un datacenter corporativo Tier III que soportará las operaciones críticas de TecnoSoft S.A. El proyecto contempla una inversión de **$2.5 millones USD** con un ROI proyectado de 5 años y disponibilidad objetivo de **99.982%**.

### **Justificación del Proyecto**

```
Situación Actual (Problemas):
- Infraestructura distribuida en 3 ubicaciones no controladas
- Sin redundancia de energía (23 incidentes en 2025)
- Refrigeración insuficiente (temperaturas >28°C en verano)
- Sin tier certificado (disponibilidad real: 98.5%)
- Costos de colocation: $45,000/mes ($540k/año)
- Sin escalabilidad (95% de capacidad utilizada)
- Compliance limitado (no cumple ISO 27001 físico)

Solución Propuesta (Datacenter Tier III):
+ Instalación única de 200m² en propiedad corporativa
+ Redundancia N+1 en energía y refrigeración
+ Tier III certificado (99.982% disponibilidad)
+ Control total de seguridad física y ambiental
+ Reducción de costos a $180k/año (ahorro $360k/año)
+ Capacidad para 10 años de crecimiento (40 racks)
+ Compliance completo (ISO 27001, PCI-DSS, SOC 2)
```

### **Indicadores Clave del Proyecto**

| **Métrica** | **Valor** | **Beneficio** |
|-------------|-----------|---------------|
| **Inversión inicial** | $2.5M USD | Amortizable en 5 años |
| **Ahorro anual** | $360k USD | vs colocation actual |
| **Disponibilidad objetivo** | 99.982% | 1.6 horas downtime/año |
| **Capacidad** | 40 racks (42U) | 10 años crecimiento |
| **Potencia instalada** | 400 kW | 10 kW/rack promedio |
| **PUE objetivo** | 1.4 | Eficiencia energética |
| **Tiempo de implementación** | 12 meses | Fases escalonadas |
| **Tier certificado** | Tier III | Uptime Institute |

---

## FASE 1: Análisis de Requisitos

### **1.1 Requisitos de Negocio**

#### **Servicios Críticos a Soportar**

```
┌─────────────────────────────────────────────────────────┐
│ SERVICIOS POR NIVEL DE CRITICIDAD                      │
├─────────────────────────────────────────────────────────┤
│                                                         │
│ TIER 1 - CRÍTICOS (RTO: 1h, RPO: 15min)               │
│ ├─ ERP (SAP) - 500 usuarios concurrentes               │
│ ├─ CRM (Salesforce on-premise) - 200 usuarios          │
│ ├─ Core Banking (Finanzas) - 24/7                      │
│ ├─ Active Directory / LDAP                             │
│ ├─ DNS/DHCP corporativo                                │
│ └─ Servidores de correo (Exchange)                     │
│                                                         │
│ TIER 2 - IMPORTANTES (RTO: 4h, RPO: 1h)               │
│ ├─ Servidores de archivos (SMB/NFS)                    │
│ ├─ Bases de datos desarrollo/QA                        │
│ ├─ Aplicaciones web internas                           │
│ ├─ Servidores de monitoreo (Zabbix, Grafana)          │
│ └─ Repositorios de código (GitLab)                     │
│                                                         │
│ TIER 3 - NORMALES (RTO: 24h, RPO: 4h)                 │
│ ├─ Servidores de desarrollo                            │
│ ├─ Ambientes de prueba                                 │
│ ├─ Backups en línea                                    │
│ └─ Servicios no críticos                               │
└─────────────────────────────────────────────────────────┘
```

#### **Proyección de Crecimiento**

```
Año 1 (2027): 15 racks utilizados
  ├─ Servidores físicos: 45 (3 por rack)
  ├─ VMs/Contenedores: ~500
  ├─ Almacenamiento: 200 TB
  ├─ Potencia requerida: 150 kW
  └─ Usuarios soportados: 800

Año 5 (2031): 25 racks utilizados
  ├─ Servidores físicos: 75
  ├─ VMs/Contenedores: ~1,200
  ├─ Almacenamiento: 500 TB
  ├─ Potencia requerida: 250 kW
  └─ Usuarios soportados: 1,500

Año 10 (2036): 35-40 racks utilizados
  ├─ Servidores físicos: 120
  ├─ VMs/Contenedores: ~2,000
  ├─ Almacenamiento: 1 PB
  ├─ Potencia requerida: 350-400 kW
  └─ Usuarios soportados: 2,500
```

---

### **1.2 Requisitos Técnicos**

#### **Disponibilidad y Tier**

**Objetivo:** Tier III según Uptime Institute

| **Tier** | **Disponibilidad** | **Downtime Anual** | **Características** |
|----------|-------------------|-------------------|---------------------|
| Tier I | 99.671% | 28.8 horas | Sin redundancia |
| Tier II | 99.741% | 22 horas | Componentes redundantes |
| **Tier III** | **99.982%** | **1.6 horas** | **Mantenimiento sin downtime** |
| Tier IV | 99.995% | 0.4 horas | Tolerante a fallos |

**Justificación de Tier III:**
```
+ Balance costo-beneficio óptimo
+ Cumple requisitos de negocio (RTO/RPO)
+ Mantenimiento sin afectar servicios críticos
+ Costo ~40% menor que Tier IV
- Tier IV sería sobredimensionado (no justificable)
```

**Requisitos Tier III:**
- Redundancia N+1 en UPS y generadores
- Redundancia N+1 en refrigeración
- Múltiples rutas de energía y refrigeración
- Mantenimiento concurrente (sin shutdown)
- 72 horas autonomía con generadores

---

#### **Requisitos de Energía**

**Cálculo de Potencia Requerida:**

```
Consumo por Rack (promedio):
├─ Servidores: 6-8 kW/rack
├─ Networking: 1 kW/rack
├─ Almacenamiento: 1-2 kW/rack
└─ Total por rack: ~10 kW

Capacidad Total (40 racks):
├─ Potencia IT (servidores): 400 kW
├─ Infraestructura (refrigeración, iluminación): 280 kW
├─ Total instalada: 680 kW
└─ Con N+1 redundancia: 900 kW

UPS Dimensionamiento:
├─ Capacidad UPS: 450 kW × 2 (redundancia)
├─ Autonomía: 15 minutos (hasta arranque generadores)
└─ Tecnología: Double conversion online

Generadores:
├─ Capacidad: 500 kW × 2 (redundancia N+1)
├─ Combustible: Diésel
├─ Autonomía: 72 horas (tanque 10,000 litros)
└─ Arranque automático: <10 segundos
```

**PUE (Power Usage Effectiveness):**

```
PUE = Potencia Total / Potencia IT

Objetivo: PUE ≤ 1.4

PUE 1.4 significa:
  Por cada 1 kW consumido por servidores,
  se consumen 0.4 kW adicionales en infraestructura
  
Desglose típico:
  - Refrigeración: 30% del overhead
  - UPS (pérdidas): 5%
  - PDUs y cableado: 3%
  - Iluminación y otros: 2%
```

---

#### **Requisitos de Refrigeración**

**Cálculo de Capacidad de Enfriamiento:**

```
Calor generado por IT: 400 kW (1,365,000 BTU/h)

Sistemas de refrigeración:
├─ CRAC (Computer Room Air Conditioning) Units
├─ Configuración: 4 unidades × 120 kW c/u (N+1)
├─ Tecnología: Precision air conditioning
├─ Control: Temperatura 22°C ± 2°C, Humedad 45-55%
└─ Distribución: Hot aisle / Cold aisle containment

Opciones de refrigeración:
┌────────────────┬──────────┬──────────┬────────────┐
│ Tecnología     │ PUE      │ Costo    │ Recomendado│
├────────────────┼──────────┼──────────┼────────────┤
│ CRAC tradicional│ 1.5-1.8 │ Bajo     │ No         │
│ CRAC + containment│ 1.3-1.5│ Medio  │ SÍ         │
│ Free cooling   │ 1.2-1.3  │ Alto     │ Futuro     │
│ Liquid cooling │ 1.1-1.2  │ Muy alto │ No         │
└────────────────┴──────────┴──────────┴────────────┘

Selección: CRAC + Hot/Cold Aisle Containment
  Razón: Balance costo-eficiencia, mantenimiento conocido
```

**Diseño de Contención:**

```
COLD AISLE CONTAINMENT (Recomendado para Tier III)

Vista Superior del Datacenter:
════════════════════════════════════════════════════════
║                                                      ║
║  ┌────┐  ┌────┐  ┌────┐  ┌────┐  ┌────┐  ┌────┐  ║
║  │ R1 │  │ R3 │  │ R5 │  │ R7 │  │ R9 │  │R11 │  ║ Back
║  └─┬──┘  └─┬──┘  └─┬──┘  └─┬──┘  └─┬──┘  └─┬──┘  ║ (Hot)
║    │ HOT  │ HOT  │ HOT  │ HOT  │ HOT  │ HOT   ║
║  ┌─┴──┐  ┌─┴──┐  ┌─┴──┐  ┌─┴──┐  ┌─┴──┐  ┌─┴──┐  ║
║  │ R2 │  │ R4 │  │ R6 │  │ R8 │  │R10 │  │R12 │  ║ Front
║  └────┘  └────┘  └────┘  └────┘  └────┘  └────┘  ║ (Cold)
║    ▲       ▲       ▲       ▲       ▲       ▲      ║
║    └───────┴───────┴───────┴───────┴───────┘      ║
║              COLD AISLE (Contenida)                ║
║        [Aire frío distribuido por piso falso]      ║
════════════════════════════════════════════════════════

Beneficios:
+ Separación aire caliente/frío (mayor eficiencia)
+ Reducción PUE en 15-20%
+ Temperaturas más estables
+ Menor carga en unidades CRAC
```

---

#### **Requisitos de Conectividad**

**Enlaces a Internet:**

```
Diseño Redundante Multi-Carrier

Carrier 1 (Primario): Fibra óptica dedicada 10 Gbps
  ├─ Proveedor: Telmex Empresarial
  ├─ Tipo: Fibra monomodo dedicada
  ├─ SLA: 99.95% disponibilidad
  ├─ Latencia: <5ms a CDN principales
  └─ Costo: $15,000/mes

Carrier 2 (Secundario): Fibra óptica dedicada 10 Gbps
  ├─ Proveedor: TotalPlay Empresarial
  ├─ Tipo: Fibra monomodo dedicada (ruta diversa)
  ├─ SLA: 99.95% disponibilidad
  ├─ Entrada física diferente (diversidad geográfica)
  └─ Costo: $15,000/mes

Carrier 3 (Backup): Enlace inalámbrico 1 Gbps
  ├─ Proveedor: Axtel Wireless
  ├─ Tipo: Microondas punto a punto
  ├─ Uso: Failover automático vía SD-WAN
  └─ Costo: $5,000/mes

Topología:
  Internet ━━━ Carrier 1 (10G) ━━━┐
                                   ├──► Router Core 1 (BGP)
  Internet ━━━ Carrier 2 (10G) ━━━┤         ↕
                                   ├──► Router Core 2 (BGP)
  Internet ━━━ Carrier 3 (1G) ━━━┘

BGP Configuration:
  - AS propio (ASN privado: 65000)
  - Balanceo de carga activo-activo (Carrier 1 + 2)
  - Failover automático (<30 segundos)
  - Anuncio de prefijos propios
```

**Red Interna:**

```
Core Network: 100 Gbps (preparado para 400G)
├─ Switches Core: Cisco Nexus 9300 (2 unidades, redundancia)
├─ Switches Aggregation: Cisco Catalyst 9500 (4 unidades)
├─ Switches ToR (Top of Rack): Cisco 9300 (40 unidades)
├─ Protocolos: OSPF, BGP, VXLAN, EVPN
└─ Redundancia: Sin punto único de falla

Storage Network: 100 Gbps FC + iSCSI
├─ SAN Switches: Brocade G620 (2 unidades)
├─ Conectividad: Fiber Channel 32G + 100GbE iSCSI
└─ Topología: Fabric redundante A/B

Management Network: 10 Gbps
├─ Red OOB (Out-of-Band) dedicada
├─ Acceso a iLO/iDRAC/IPMI
└─ Segmentada de red productiva
```

---

### **1.3 Requisitos de Seguridad**

#### **Seguridad Física**

```
Perímetros de Seguridad:

NIVEL 1 - PERÍMETRO EXTERNO
├─ Muro perimetral 3m altura
├─ Cámaras CCTV (cobertura 100%)
├─ Iluminación nocturna
├─ Detección de intrusión perimetral
└─ Guardias de seguridad 24/7

NIVEL 2 - ACCESO AL EDIFICIO
├─ Torniquetes con tarjeta de proximidad
├─ Recepción con guardia
├─ Registro de visitas
├─ Sistema de detección de metales
└─ Videovigilancia en lobbies

NIVEL 3 - ACCESO AL DATACENTER
├─ Puerta blindada con doble factor:
│   └─ Tarjeta de proximidad + Biometría (huella)
├─ Esclusa de seguridad (mantrap)
├─ Cámaras dentro del datacenter
├─ Sensores de apertura de racks
└─ Log de accesos (quien, cuando, duración)

NIVEL 4 - ACCESO A JAULAS/RACKS
├─ Jaulas cerradas para clientes/departamentos
├─ Cerraduras electrónicas en racks críticos
├─ Alarma de apertura de puerta de rack
└─ Video analytics (detección de comportamiento anómalo)
```

**Matriz de Accesos:**

| **Rol** | **Nivel de Acceso** | **Autenticación** | **Restricciones** |
|---------|---------------------|-------------------|-------------------|
| Personal operativo datacenter | Nivel 3 (sala completa) | Tarjeta + Biometría | 24/7 |
| Técnicos de sistemas | Nivel 4 (racks asignados) | Tarjeta + Biometría | Horario laboral |
| Gerencia TI | Nivel 3 (supervisión) | Tarjeta + Biometría | 24/7 |
| Proveedores/Contratistas | Nivel 3 (escoltado) | Visita registrada | Horario coordinado |
| Personal no autorizado | Nivel 0 (sin acceso) | N/A | Prohibido |

---

#### **Seguridad Lógica**

```
Segmentación de Red (VLANs):

VLAN 10 - Management (192.168.10.0/24)
  ├─ Acceso a consolas de servidores
  ├─ Red OOB (iLO, iDRAC, IPMI)
  ├─ Sin acceso a Internet
  └─ ACL estrictas (solo desde jump servers)

VLAN 20 - Producción (10.20.0.0/16)
  ├─ Servidores productivos
  ├─ Aplicaciones críticas
  ├─ Segmentada por función (web, DB, app)
  └─ Firewall entre segmentos

VLAN 30 - Desarrollo/QA (10.30.0.0/16)
  ├─ Ambientes de desarrollo
  ├─ Aislado de producción
  └─ Acceso controlado

VLAN 40 - DMZ (203.0.113.0/24)
  ├─ Servidores públicos
  ├─ Doble firewall (front + back)
  └─ Hardening extremo

VLAN 99 - Administración (192.168.99.0/24)
  ├─ Equipos de red
  ├─ Jump servers
  └─ Red de gestión
```

**Controles de Seguridad:**

| **Control** | **Tecnología** | **Propósito** |
|-------------|----------------|---------------|
| **Firewalls** | Palo Alto PA-5220 (2 unidades HA) | Segmentación, IPS/IDS, App control |
| **NAC** | Cisco ISE | Control de acceso a la red |
| **SIEM** | Splunk Enterprise | Correlación de eventos, compliance |
| **Antimalware** | CrowdStrike Falcon | Protección endpoints |
| **Vulnerability Scanner** | Tenable Nessus | Escaneo de vulnerabilidades |
| **Backup Encryption** | Veeam + AES-256 | Protección de backups |
| **Secrets Management** | HashiCorp Vault | Gestión de credenciales |

---

## FASE 2: Diseño de Infraestructura Física

### **2.1 Selección de Ubicación**

**Criterios de Evaluación:**

```
Ubicación Seleccionada: Parque Industrial Monterrey

VENTAJAS:
├─ Zona sísmica de bajo riesgo (Zona B)
├─ Sin historial de inundaciones
├─ Acceso a múltiples carriers de telecomunicaciones
├─ Suministro eléctrico estable (CFE Subestación dedicada)
├─ Costo de terreno competitivo ($350/m²)
├─ Cerca de aeropuerto (15 km) para soporte remoto
├─ Seguridad industrial 24/7 en parque
└─ Zonificación permite uso como datacenter

RIESGOS MITIGADOS:
├─ Clima cálido (verano >40°C) → Sobre-dimensionar refrigeración
├─ Tormentas eléctricas → Protección contra rayos, UPS robustos
└─ Crecimiento urbano → Asegurar terreno para expansión futura

Área Total del Terreno: 1,000 m²
├─ Edificio datacenter: 500 m²
├─ Área de expansión futura: 300 m²
├─ Estacionamiento y accesos: 200 m²
```

**Evaluación de Riesgos Ambientales:**

| **Riesgo** | **Probabilidad** | **Impacto** | **Mitigación** |
|------------|------------------|-------------|----------------|
| Sismo (>7.0) | Muy Baja | Alto | Diseño antisísmico, anclaje de racks |
| Inundación | Muy Baja | Crítico | Piso elevado 50cm, bombas de achique |
| Incendio | Baja | Crítico | FM-200 / Novec 1230, detección temprana |
| Corte eléctrico | Media | Crítico | UPS + generadores 72h autonomía |
| Sobrecalentamiento | Alta (verano) | Alto | CRAC N+1, monitoreo 24/7 |
| Intrusión física | Media | Alto | Seguridad multi-nivel, vigilancia |

---

### **2.2 Diseño Arquitectónico**

**Plano de Planta (500 m²):**

```
════════════════════════════════════════════════════════════
║                    DATACENTER TIER III                   ║
║                      Planta Principal                    ║
════════════════════════════════════════════════════════════
║                                                          ║
║  ┌─────────────────────────────────────────────────┐    ║
║  │          SALA DE SERVIDORES (200 m²)            │    ║
║  │                                                  │    ║
║  │  [Racks] [Racks] [Racks] [Racks] [Racks]       │    ║
║  │    R1-8    R9-16  R17-24  R25-32  R33-40        │    ║
║  │                                                  │    ║
║  │  Cold Aisle ←→ Hot Aisle ←→ Cold Aisle          │    ║
║  │                                                  │    ║
║  └──────────────────────────┬───────────────────────┘    ║
║                             │                            ║
║  ┌──────────────┐  ┌────────┴────────┐  ┌──────────┐   ║
║  │ SALA         │  │  NOC/SOC        │  │ OFICINA  │   ║
║  │ ELÉCTRICA    │  │  (30 m²)        │  │ GERENCIA │   ║
║  │ (UPS+PDU)    │  │                 │  │ (20 m²)  │   ║
║  │ (60 m²)      │  │ [Monitores]     │  │          │   ║
║  │              │  │ [Estaciones]    │  └──────────┘   ║
║  │ [UPS 1]      │  │                 │                  ║
║  │ [UPS 2]      │  └─────────────────┘                  ║
║  │ [PDU Main]   │                                        ║
║  └──────────────┘  ┌─────────────────┐                  ║
║                    │ SALA CRAC       │                  ║
║  ┌──────────────┐  │ (40 m²)         │  ┌──────────┐   ║
║  │ SALA         │  │                 │  │ ÁREA     │   ║
║  │ GENERADORES  │  │ [CRAC 1] [CRAC 2]│ │ BATERÍAS │   ║
║  │ EXTERIOR     │  │ [CRAC 3] [CRAC 4]│ │ UPS      │   ║
║  │ (50 m²)      │  │                 │  │ (30 m²)  │   ║
║  │              │  └─────────────────┘  │          │   ║
║  │ [GEN 1]      │                       │ [Batt 1] │   ║
║  │ [GEN 2]      │  ┌─────────────────┐  │ [Batt 2] │   ║
║  │              │  │ RECEPCIÓN /     │  └──────────┘   ║
║  │ [Tanque      │  │ SEGURIDAD       │                  ║
║  │  Diésel]     │  │ (30 m²)         │  ┌──────────┐   ║
║  └──────────────┘  │                 │  │ BODEGA   │   ║
║                    │ [Torniquete]    │  │ EQUIPOS  │   ║
║  ┌──────────────┐  │ [Recepción]     │  │ (20 m²)  │   ║
║  │ BAÑOS /      │  │                 │  │          │   ║
║  │ VESTIDORES   │  └─────────────────┘  │ [Spare   │   ║
║  │ (20 m²)      │                       │  Parts]  │   ║
║  └──────────────┘                       └──────────┘   ║
║                                                          ║
║  Leyenda:                                                ║
║  ═══════  Muro estructural                              ║
║  ───────  Partición                                     ║
║  [    ]   Equipamiento                                  ║
════════════════════════════════════════════════════════════
```

**Especificaciones Constructivas:**

```
ESTRUCTURA:
├─ Losa de concreto reforzada: 30 cm espesor
├─ Capacidad de carga: 1,200 kg/m² (racks llenos)
├─ Muros perimetrales: Block de concreto 20 cm + aislamiento
├─ Techo: Losa aligerada con impermeabilización multicapa
├─ Altura libre: 3.5 metros (sala servidores)
└─ Diseño antisísmico: Cumple NTC-2017 (Zona B)

PISO FALSO:
├─ Altura: 60 cm (distribución aire frío + cableado)
├─ Paneles: Acero con recubrimiento antiestático
├─ Capacidad de carga: 600 kg/m²
├─ Sistema modular desmontable
└─ Rejillas perforadas en cold aisles (30% apertura)

ACABADOS:
├─ Pintura: Antiestática, ignífuga
├─ Iluminación: LED 500 lux, con respaldo en UPS
├─ Puertas: Blindadas RF-60 (resistencia fuego 60 min)
└─ Ventanas: NINGUNA (seguridad y control térmico)
```

---

### **2.3 Sistema Eléctrico**

**Diagrama Unifilar Simplificado:**

```
                    CFE Subestación
                          │
                    ┌─────┴─────┐
                    │ TABLERO   │
                    │ GENERAL   │
                    │ 1000A     │
                    └─────┬─────┘
                          │
            ┌─────────────┼─────────────┐
            │                           │
    ┌───────▼────────┐         ┌───────▼────────┐
    │ UPS 1          │         │ UPS 2          │
    │ 450 kVA        │         │ 450 kVA        │
    │ (Redundancia)  │         │ (Redundancia)  │
    └───────┬────────┘         └───────┬────────┘
            │                           │
            └─────────────┬─────────────┘
                          │
                  ┌───────▼────────┐
                  │ STS (Static    │
                  │ Transfer Switch)│
                  └───────┬────────┘
                          │
        ┌─────────────────┼─────────────────┐
        │                 │                 │
  ┌─────▼─────┐     ┌─────▼─────┐    ┌─────▼─────┐
  │ PDU A1    │     │ PDU A2    │    │ PDU B     │
  │ (Racks    │     │ (Racks    │    │ (CRAC +   │
  │  1-20)    │     │  21-40)   │    │  Ilum.)   │
  └───────────┘     └───────────┘    └───────────┘

Respaldo:
┌─────────────┐
│ GENERADOR 1 │────┐
│ 500 kW      │    │
└─────────────┘    ├──► ATS ──► Tablero General
                   │    (Automatic Transfer Switch)
┌─────────────┐    │
│ GENERADOR 2 │────┘
│ 500 kW      │
└─────────────┘

Tiempo de respuesta:
  1. Corte CFE detectado: < 2 ms (UPS)
  2. UPS alimenta carga: 15 minutos
  3. Generador arranca: < 10 segundos
  4. ATS transfiere a generador: < 5 segundos
  5. Autonomía generador: 72 horas (tanque lleno)
```

**Especificaciones UPS:**

```
Marca: APC Schneider Electric Symmetra PX 450 kVA
Cantidad: 2 unidades (configuración redundante N+1)

Características:
├─ Potencia: 450 kVA / 450 kW (factor potencia 1.0)
├─ Topología: Double conversion online
├─ Eficiencia: 97% (modo normal), 99% (modo eco)
├─ Tiempo autonomía: 15 minutos a plena carga
├─ Banco de baterías: 40 módulos de 12V 200Ah
├─ Vida útil baterías: 5 años (reemplazo hot-swap)
├─ THD entrada/salida: <5% (power quality)
├─ Bypass: Automático y manual
├─ Interfaz: SNMP, Modbus, contactos secos
├─ Monitoreo: PowerChute Network Shutdown
└─ Pantalla: LCD táctil con métricas en tiempo real

Configuración:
  Redundancia N+1:
    - UPS 1 capacidad: 450 kVA
    - UPS 2 capacidad: 450 kVA
    - Carga total: 400 kVA
    - Si UPS 1 falla, UPS 2 soporta 100% carga
```

**Especificaciones Generadores:**

```
Marca: Caterpillar C15 ACERT
Cantidad: 2 unidades (configuración N+1)

Características:
├─ Potencia: 500 kW @ 480V / 60Hz
├─ Combustible: Diésel (bajo azufre)
├─ Arranque: Automático <10 segundos
├─ Tanque integrado: 200 litros (2 horas)
├─ Tanque principal: 10,000 litros (72 horas)
├─ Nivel de ruido: 75 dBA @ 7m (cabina insonorizada)
├─ Sistema de escape: Filtro de partículas
├─ Enfriamiento: Radiador con ventilador
├─ Panel de control: Deep Sea DSE8610 MKII
├─ Prueba automática: Semanal 30 minutos sin carga
└─ Mantenimiento: Cada 500 horas o 6 meses

Cálculo de Autonomía:
  Consumo: 110 litros/hora @ 70% carga (350 kW)
  Tanque: 10,000 litros
  Autonomía: 10,000 / 110 = 90 horas
  
  Considerando margen de seguridad:
    → Autonomía garantizada: 72 horas
```

---

### **2.4 Sistema de Refrigeración**

**Especificaciones CRAC:**

```
Marca: Vertiv Liebert CRV
Cantidad: 4 unidades (configuración 3+1 redundancia)

Características por Unidad:
├─ Capacidad: 120 kW (35 toneladas refrigeración)
├─ Tipo: Aire-agua (chiller externo)
├─ Flujo de aire: 20,000 CFM
├─ Control: Microprocesador con setpoints precisos
├─ Rango temperatura: 18-27°C (setpoint: 22°C)
├─ Rango humedad: 40-60% RH (setpoint: 50%)
├─ Precisión: ±1°C, ±5% RH
├─ Sensores: 8 por unidad (temperatura + humedad)
├─ Distribución: Piso falso (underfloor plenum)
├─ Redundancia: N+1 (3 activas, 1 standby)
├─ Failover: Automático <2 minutos
└─ Monitoreo: SNMP, BACnet, alarmas por email/SMS

Configuración:
  - CRAC 1, 2, 3: Operación normal (33% carga c/u)
  - CRAC 4: Standby (activación automática si falla alguna)
  - Rotación semanal (balanceo de horas de operación)
```

**Chiller Exterior:**

```
Marca: Trane RTAC 400
Capacidad: 400 toneladas (1,400 kW enfriamiento)

Características:
├─ Tecnología: Enfriado por aire (air-cooled)
├─ Refrigerante: R-134a (ecológico)
├─ Compresor: Scroll hermético (alta eficiencia)
├─ Condensador: Microchannel (menor footprint)
├─ COP (Coefficient of Performance): 3.2
├─ Control: Adaptive frequency drive
├─ Ubicación: Azotea con protección contra intemperie
└─ Redundancia: Múltiples circuitos independientes

Conexión con CRACs:
  Chiller → Tuberías agua fría (7°C) → CRACs
          ← Tuberías agua retorno (12°C) ←
```

**Monitoreo Ambiental:**

```
Sistema: APC NetBotz 570 (Schneider Electric)

Sensores Distribuidos:
├─ Temperatura: 20 sensores (2 por cold aisle, 1 por rack crítico)
├─ Humedad: 10 sensores (distribuidos uniformemente)
├─ Fugas de agua: 8 sensores (bajo piso falso, cerca CRAC)
├─ Humo: 12 detectores (aspiración temprana VESDA)
├─ Vibración: 4 sensores (detección sísmica)
└─ Intrusión: Cámaras + sensores de movimiento

Umbrales de Alarma:
┌──────────────┬──────────┬──────────┬──────────┐
│ Parámetro    │ Normal   │ Warning  │ Critical │
├──────────────┼──────────┼──────────┼──────────┤
│ Temperatura  │ 20-24°C  │ 18/26°C  │ <16/28°C │
│ Humedad      │ 45-55%   │ 40/60%   │ <35/65%  │
│ Agua (leak)  │ Seco     │ Humedad  │ Agua     │
│ Humo         │ 0 ppm    │ >5 ppm   │ >10 ppm  │
└──────────────┴──────────┴──────────┴──────────┘

Acciones Automáticas:
  Warning: Email a equipo de operaciones
  Critical: Email + SMS + llamada telefónica
           + Activación de CRAC de respaldo
           + Log en SIEM
           + Notificación a NOC
```

---

## FASE 3: Diseño de Infraestructura de Red

### **3.1 Arquitectura de Red**

**Topología Spine-Leaf (Clos Network):**

```
                    INTERNET
                       │
        ┌──────────────┼──────────────┐
        │              │              │
   ┌────▼────┐    ┌────▼────┐    ┌────▼────┐
   │ FW-1    │    │ FW-2    │    │ Router  │
   │ (Active)│    │(Standby)│    │ BGP-3   │
   └────┬────┘    └────┬────┘    └────┬────┘
        │              │              │
        └──────────────┴──────────────┘
                       │
        ┌──────────────┴──────────────┐
        │                             │
   ┌────▼─────┐                  ┌────▼─────┐
   │ SPINE-1  │══════════════════│ SPINE-2  │
   │(Core SW) │   100Gbps ×4     │(Core SW) │
   └────┬─────┘                  └────┬─────┘
        │                             │
   ┌────┴─────┬─────┬─────┬──────────┴────┐
   │          │     │     │               │
┌──▼──┐   ┌──▼──┐ ┌▼──┐ ┌▼──┐         ┌──▼──┐
│LEAF1│   │LEAF2│ │...│ │...│         │LEAF8│
│ AGG │   │ AGG │     │     │         │ AGG │
└──┬──┘   └──┬──┘     │     │         └──┬──┘
   │         │                             │
 ┌─┴─┐     ┌─┴─┐                         ┌─┴─┐
 │ToR│     │ToR│       ...               │ToR│
 │SW │     │SW │                         │SW │
 └─┬─┘     └─┬─┘                         └─┬─┘
   │         │                             │
 [R1-5]   [R6-10]      ...             [R36-40]

Características:
- Sin bloqueo (non-blocking fabric)
- Escalable horizontalmente (agregar Leafs)
- Latencia predecible (<1 ms intra-DC)
- Múltiples rutas ECMP (Equal-Cost Multi-Path)
- Falla de cualquier Spine: Tráfico continúa
```

**Equipamiento de Red:**

| **Capa** | **Equipo** | **Cantidad** | **Puertos** | **Velocidad** | **Función** |
|----------|------------|--------------|-------------|---------------|-------------|
| **Internet Edge** | Cisco ASR 1006-X | 2 | 6×10G SFP+ | 10 Gbps | BGP, routing WAN |
| **Firewall** | Palo Alto PA-5220 | 2 (HA) | 16×10G SFP+ | 10 Gbps | Seguridad perímetro |
| **Spine (Core)** | Cisco Nexus 9336C-FX2 | 2 | 36×100G QSFP28 | 100 Gbps | Core switching |
| **Leaf (Aggregation)** | Cisco Nexus 9348GC-FXP | 8 | 48×10G + 4×100G | 10/100 Gbps | Agregación |
| **ToR (Access)** | Cisco Catalyst 9300-48UXM | 40 | 48×mGig + 4×10G | 1/2.5/5/10G | Acceso servidores |
| **Storage (SAN)** | Brocade G620 | 2 | 64 puertos FC | 32 Gbps FC | Fabric SAN |
| **Management** | Cisco Catalyst 9200L | 2 | 48×1G | 1 Gbps | OOB management |

---

### **3.2 Cableado Estructurado**

**Estándares Aplicables:**
- TIA-942: Telecommunications Infrastructure Standard for Data Centers
- ISO/IEC 11801: Generic Cabling for Customer Premises
- TIA-568: Commercial Building Telecommunications Cabling Standard

**Tipo de Cableado por Aplicación:**

```
FIBRA ÓPTICA MONOMODO (OS2):
├─ Spine ↔ Leaf: LC Duplex, 100GBASE-SR4 (MPO/MTP-12)
├─ Leaf ↔ ToR: LC Duplex, 10GBASE-LR
├─ Longitud máxima: 10 km (no relevante en DC, <100m)
├─ Core diámetro: 9 micrones
└─ Color chaqueta: Amarillo

FIBRA ÓPTICA MULTIMODO OM4:
├─ Conexiones 10G/40G corta distancia (<150m)
├─ SAN Fabric: 32G FC
├─ Core diámetro: 50 micrones
├─ Ancho de banda: 4700 MHz·km
└─ Color chaqueta: Aqua

COBRE CAT6A:
├─ Servidores → ToR (10GBASE-T)
├─ Management network (1GBASE-T)
├─ Longitud máxima: 100 metros
├─ Ancho de banda: 500 MHz
└─ Blindaje: F/UTP (menor interferencia)

Código de Colores:
┌──────────────┬───────────┬─────────────────┐
│ Función      │ Color     │ Etiqueta        │
├──────────────┼───────────┼─────────────────┤
│ Producción   │ Azul      │ PROD-xxx        │
│ Management   │ Verde     │ MGMT-xxx        │
│ Storage      │ Rojo      │ SAN-xxx         │
│ Backup       │ Naranja   │ BACKUP-xxx      │
│ OOB          │ Amarillo  │ OOB-xxx         │
└──────────────┴───────────┴─────────────────┘
```

**Organización de Cableado:**

```
Bandeja de Cables (Cable Tray):
├─ Material: Aluminio perforado (ventilación)
├─ Ancho: 30 cm (soporte hasta 200 cables)
├─ Instalación: Overhead (sobre racks) + Underfloor
├─ Separación: 15 cm entre bandejas de datos y eléctrico
└─ Soportes cada 1.5 metros

Gestión por Rack:
├─ Panel de parcheo: 48 puertos (1U)
├─ Organizadores horizontales: Cada 2U
├─ Organizadores verticales: Laterales de rack
├─ Radio de curvatura mínimo: 4× diámetro cable
├─ Velcro (no amarres de plástico que dañan)
└─ Etiquetado en ambos extremos (origen y destino)

Documentación:
  - Esquema de cableado en Visio
  - Base de datos de parcheo (NetBox)
  - Etiquetas QR code en cada cable
  - Testing certificado (TIA/EIA-568)
  - As-built drawings actualizados
```

---

### **3.3 Almacenamiento (SAN/NAS)**

**Arquitectura de Storage:**

```
SAN (Storage Area Network) - Bloque
├─ Dell EMC PowerStore 5200T
├─ Capacidad raw: 500 TB (flash NVMe + SAS)
├─ Protocolo: Fiber Channel 32G + iSCSI 25G
├─ Redundancia: Dual controllers active-active
├─ RAID: RAID 6 (doble paridad)
├─ Snapshots: Cada 4 horas, retención 7 días
├─ Replicación: Síncrona a sitio DR (RPO=0)
└─ Uso: Bases de datos, VMs críticas

NAS (Network Attached Storage) - Archivos
├─ NetApp FAS8300
├─ Capacidad: 200 TB (SSD + HDD tiering)
├─ Protocolo: NFS v4, SMB 3.1.1
├─ Redundancia: HA pair
├─ Deduplicación: Hasta 70% ahorro
├─ Snapshots: Cada 1 hora, retención 30 días
└─ Uso: Shares de archivos, home directories

Object Storage - S3 Compatible
├─ MinIO Cluster (software-defined)
├─ Capacidad: 1 PB (discos SATA)
├─ Protocolo: S3 API
├─ Redundancia: Erasure coding 8+4
├─ Uso: Backups, archivos históricos, logs
└─ Costo: $0.02/GB/mes (vs $0.10 AWS S3)
```

**Backup Strategy (3-2-1 Rule):**

```
3 Copias de los Datos:
  1. Datos en producción (SAN/NAS)
  2. Backup local (disco)
  3. Backup offsite (cinta/nube)

2 Tipos de Medios:
  - Disco (Veeam Backup Repository local)
  - Cinta LTO-8 (offsite vault)

1 Copia Offsite:
  - Replicación a sitio DR (300 km distancia)
  - Cintas en bóveda externa (Iron Mountain)

Esquema de Backups:
├─ Incremental diario: 23:00 (L-V)
├─ Diferencial semanal: Sábado 02:00
├─ Full mensual: Primer domingo 00:00
├─ Retención:
│   ├─ Diarios: 7 días
│   ├─ Semanales: 4 semanas
│   ├─ Mensuales: 12 meses
│   └─ Anuales: 7 años (compliance)
└─ Testing: Restore test mensual (random sample)

Herramienta: Veeam Backup & Replication v12
├─ Backup servers: 2× VM (HA)
├─ Repositories: 
│   ├─ Local: 100 TB disk (Dell ME4024)
│   └─ Tape: LTO-8 library (16 drives, 200 slots)
├─ WAN accelerator: Para replicación a DR
└─ Instant VM Recovery: <15 minutos RTO
```

---

## FASE 4: Seguridad y Compliance

### **4.1 Controles de Seguridad por Capa**

```
CAPA FÍSICA:
- Perímetro con muro 3m + cámaras
- Acceso biométrico + tarjeta (dual factor)
- Mantrap (esclusa de seguridad)
- Detección de intrusión (PIR + contactos magnéticos)
- Guardias 24/7
- Video retention: 90 días

CAPA DE RED:
- Firewalls NG (Palo Alto) con IPS/IDS
- Segmentación VLANs (micro-segmentation)
- NAC (Cisco ISE) - Control de acceso 802.1X
- DDOS protection (scrubbing externo + local)
- Encrypted tunnels (IPsec/TLS) para management
- SIEM (Splunk) - Correlación de eventos

CAPA DE SISTEMA:
- Hardening según CIS Benchmarks
- Antimalware enterprise (CrowdStrike)
- Patch management (WSUS/Satellite)
- Vulnerability scanning (Nessus semanal)
- File Integrity Monitoring (Tripwire)
- Privileged Access Management (CyberArk)

CAPA DE DATOS:
- Encryption at rest (AES-256)
- Encryption in transit (TLS 1.3)
- Database encryption (TDE - Transparent Data Encryption)
- Backup encryption
- Key management (HSM - Hardware Security Module)
- DLP (Data Loss Prevention)

CAPA DE APLICACIÓN:
- WAF (Web Application Firewall)
- API Gateway con rate limiting
- Authentication (MFA obligatorio)
- Authorization (RBAC - Role-Based Access Control)
- Session management
- Input validation / Output encoding
```

---

### **4.2 Compliance y Certificaciones**

**Normativas Objetivo:**

| **Estándar** | **Alcance** | **Requisitos Clave** | **Auditoría** |
|--------------|-------------|----------------------|---------------|
| **ISO 27001** | Seguridad de la información | SGSI completo, controles físicos/lógicos | Anual |
| **PCI-DSS v4.0** | Protección datos de tarjetas | Segmentación red, encriptación, logs | Trimestral |
| **SOC 2 Type II** | Controles operacionales | Disponibilidad, integridad, confidencialidad | Anual |
| **TIA-942** | Infraestructura datacenter | Diseño físico, redundancia, monitoreo | N/A (diseño) |
| **Tier III** | Disponibilidad Uptime Institute | N+1, mantenimiento concurrente | Certificación |

**Evidencias de Compliance:**

```
ISO 27001 - Controles Físicos (A.11):
- A.11.1.1 Perímetro de seguridad física
- A.11.1.2 Controles de entrada física
- A.11.1.3 Seguridad de oficinas, despachos
- A.11.1.4 Protección contra amenazas externas
- A.11.1.5 Trabajo en áreas seguras
- A.11.1.6 Áreas de carga y descarga

Evidencia Generada:
├─ Logs de acceso biométrico
├─ Grabaciones de video (90 días)
├─ Reportes de sensores ambientales
├─ Bitácora de visitas
├─ Inventario de activos (CMDB)
└─ Reportes de auditorías internas mensuales

PCI-DSS - Requisito 9 (Acceso Físico):
- 9.1 Uso de controles de acceso apropiados
- 9.2 Procedimientos para distinguir personal
- 9.3 Controlar acceso físico a personal
- 9.4 Implementar procedimientos de visitantes
- 9.5 Proteger físicamente todos los medios

Evidencia:
├─ Badge system con roles diferenciados
├─ Escoltas obligatorias para visitantes
├─ Destrucción certificada de medios (Shred-it)
├─ Inventario de cintas fuera de sitio
└─ Logs de transferencia de medios
```

---

## FASE 5: Monitoreo y Gestión

### **5.1 NOC/SOC (Network/Security Operations Center)**

**Diseño del NOC:**

```
Espacio: 30 m² (sala dedicada con visibilidad a datacenter)

Equipamiento:
├─ Video wall: 3×3 pantallas 55" (monitores de alertas)
├─ Estaciones de trabajo: 4× dual-monitor
├─ Puestos: 6 (operadores 24/7 en turnos)
├─ UPS dedicado: 10 kVA (autonomía 30 min)
├─ Iluminación: Regulable (24/7 operations)
└─ CCTV con vista a sala servidores

Turnos de Operación:
├─ Turno 1: 07:00 - 15:00 (2 operadores)
├─ Turno 2: 15:00 - 23:00 (2 operadores)
├─ Turno 3: 23:00 - 07:00 (1 operador)
└─ On-call: Ingeniero senior (escalamiento L3)

Herramientas en Pantallas:
┌──────────────┬──────────────┬──────────────┐
│ Dashboard 1  │ Dashboard 2  │ Dashboard 3  │
│ Zabbix       │ Grafana      │ SIEM Splunk  │
│ (Infra)      │ (Metrics)    │ (Security)   │
├──────────────┼──────────────┼──────────────┤
│ Dashboard 4  │ Dashboard 5  │ Dashboard 6  │
│ NetBox DCIM  │ Veeam Backup │ Ticket System│
│ (Inventory)  │ (Backup Jobs)│ (Jira)       │
├──────────────┼──────────────┼──────────────┤
│ Dashboard 7  │ Dashboard 8  │ Dashboard 9  │
│ CCTV         │ Environmental│ Power/Cooling│
│ (Seguridad)  │ (Temp/Humid) │ (DCIM)       │
└──────────────┴──────────────┴──────────────┘
```

---

### **5.2 Herramientas de Monitoreo**

| **Categoría** | **Herramienta** | **Función** | **Métricas Clave** |
|---------------|-----------------|-------------|-------------------|
| **Infraestructura** | Zabbix Enterprise | Monitoreo servers, red, servicios | CPU, RAM, Disco, Red, Uptime |
| **Métricas/Visualización** | Grafana + Prometheus | Dashboards personalizados | Time-series, tendencias |
| **APM** | New Relic | Monitoreo aplicaciones | Response time, errors, throughput |
| **Logs** | ELK Stack (Elasticsearch, Logstash, Kibana) | Centralización logs | Syslog, app logs, correlation |
| **SIEM** | Splunk Enterprise Security | Seguridad, compliance | Events, threats, anomalies |
| **DCIM** | Schneider EcoStruxure IT | Infraestructura física | Power, cooling, capacity |
| **NetFlow** | SolarWinds NTA | Análisis tráfico | Top talkers, applications, bandwidth |
| **Backup** | Veeam ONE | Monitoreo backups | Job status, capacity, compliance |
| **Ticketing** | Jira Service Management | Gestión incidentes | SLA, resolution time, backlog |

**Integraciones:**

```
Flujo de Alertas Automatizado:

1. Detección de Anomalía:
   Zabbix detecta: CPU >90% en servidor crítico (DB-PROD-01)
   
2. Correlación:
   ├─ Prometheus confirma: Queries lentas aumentaron 300%
   ├─ ELK muestra: Errores de conexión en logs de app
   └─ NetFlow identifica: Tráfico anómalo desde IP externa
   
3. Creación Automática de Ticket:
   Jira crea: INC-2026-0345 (Prioridad: Alta)
   Asignado a: Equipo de Bases de Datos
   
4. Notificación Multi-Canal:
   ├─ Dashboard NOC: Alerta visual + sonora
   ├─ Email: Equipo de DB + Gerencia
   ├─ SMS: Ingeniero on-call
   └─ Slack: Canal #alerts-critical
   
5. Investigación y Respuesta:
   NOC Tier 1: Valida problema real (no falso positivo)
   NOC Tier 2: Inicia troubleshooting
   Si necesario → Escalamiento Tier 3 (senior engineer)
   
6. Resolución:
   Causa raíz: Consulta mal optimizada en nueva release
   Acción: Rollback de release + optimización query
   Tiempo total: 45 minutos (dentro de SLA <2h)
   
7. Post-Mortem Automático:
   ├─ Splunk genera reporte de evento
   ├─ Grafana exporta gráficas del incidente
   ├─ Jira documenta RCA (Root Cause Analysis)
   └─ KB actualizado con solución para futuros casos
```

---

### **5.3 Runbooks Operacionales**

**Ejemplo de Runbook: Falla de UPS**

```markdown
# RUNBOOK: Respuesta a Falla de UPS

## Información
- ID: RB-POWER-001
- Última actualización: 2026-03-30
- Responsable: Equipo de Infraestructura
- Severidad: CRÍTICA

## Escenario
Alarma: "UPS 1 - Batería en modo bypass"
Impacto: Pérdida de redundancia, riesgo si CFE falla

## Detección
- Alerta Zabbix: "UPS1 - Operating on Bypass"
- Email/SMS automático a NOC
- Dashboard DCIM muestra UPS1 en amarillo

## Acciones Inmediatas (5 minutos)

1. VERIFICAR ESTADO UPS
   ```bash
   # Conectar a interfaz UPS via SNMP
   snmpwalk -v2c -c public 192.168.99.10 .1.3.6.1.4.1.318
   
   # Revisar en PowerChute Network Shutdown
   https://192.168.99.10 (usuario/password en vault)
   ```

2. VALIDAR CARGA TRANSFERIDA
   - UPS2 debe estar soportando 100% de carga
   - Verificar STS (Static Transfer Switch) operó correctamente
   - Confirmar servidores NO tuvieron downtime (check Zabbix)

3. INSPECCIÓN VISUAL
   - Revisar panel LCD de UPS1
   - Buscar códigos de error
   - Documentar lecturas: voltaje input/output, temperatura

4. NOTIFICACIÓN ESCALADA
   - Si carga >80% en UPS2: Alerta a Gerencia (riesgo alto)
   - Abrir ticket P1: "Pérdida de redundancia UPS"
   - Contactar vendor (APC) para soporte: 800-XXX-XXXX

## Análisis (30 minutos)

5. DIAGNÓSTICO REMOTO
   - Revisar event log de UPS1 (últimas 48 horas)
   - Posibles causas:
     ├─ Batería degradada (>5 años uso)
     ├─ Falla en inversor
     ├─ Sobrecarga momentánea
     └─ Falla en rectificador

6. PRUEBAS
   - Test de batería vía software (si UPS lo permite)
   - Revisar temperatura de sala baterías
   - Validar ventiladores funcionando

## Resolución (variable)

7. ESCENARIO A: Batería Degradada
   ```
   Acción:
   - Programar reemplazo de banco de baterías
   - Ventana de mantenimiento: Siguiente domingo 02:00
   - Procedimiento: Reemplazo hot-swap módulos
   - Proveedor: APC Channel Partner
   - Tiempo estimado: 2 horas
   - Costo: $15,000 USD
   ```

8. ESCENARIO B: Falla de Inversor
   ```
   Acción URGENTE:
   - Técnico APC on-site: <4 horas (contrato)
   - Reparación o reemplazo de módulo
   - Considerar bypass manual si >24h downtime
   - Escalar a Gerencia: Decisión de compra emergency
   ```

9. ESCENARIO C: Falsa Alarma / Reset
   ```
   Si diagnóstico indica: Alarma espuria
   - Reset de UPS (procedimiento en manual)
   - Monitoreo intensivo próximas 48 horas
   - Agendar mantenimiento preventivo
   ```

## Restauración

10. VALIDACIÓN POST-REPARACIÓN
    - Test completo de UPS (bajo carga)
    - Simular transferencia UPS1 ↔ UPS2
    - Confirmar autonomía (tiempo en baterías)
    - Actualizar CMDB con información de mantenimiento

11. DOCUMENTACIÓN
    - Cerrar ticket con RCA completo
    - Actualizar log de mantenimiento
    - Si fue incidente: Post-mortem formal
    - Lecciones aprendidas → Actualizar runbook

## Contactos
- NOC 24/7: Ext. 9999
- Soporte APC: 800-XXX-XXXX (Contrato: #12345)
- Gerente Infraestructura: 555-XXX-XXXX
- Técnico On-Call: Ver calendario PagerDuty

## Anexos
- Manual de usuario UPS: /docs/APC_Symmetra_Manual.pdf
- Diagrama eléctrico: /docs/Electrical_Diagram.vsd
- Historial de mantenimiento: /tickets/UPS-maintenance-log.xlsx


---

## FASE 6: Presupuesto e Inversión

### **6.1 CAPEX (Capital Expenditure) - Inversión Inicial**


| **Concepto** | **Costo USD** | **% del Total** | **Descripción** |
|---|---|---|---|
| **1. OBRA CIVIL Y CONSTRUCCIÓN** | **$450,000** | **18.0%** | |
| Estructura y cimientos | $150,000 | 6.0% | Losa de concreto 30cm, muros reforzados |
| Piso falso | $40,000 | 1.6% | Altura 60cm, paneles antiestáticos |
| Acabados (pintura, puertas) | $30,000 | 1.2% | Puertas blindadas RF-60, pintura ignífuga |
| Detección/Supresión incendios | $80,000 | 3.2% | Sistema VESDA + FM-200 / Novec 1230 |
| Seguridad física (cámaras, biométrico) | $70,000 | 2.8% | CCTV, torniquetes, lectores biométricos |
| Contingencia (10%) | $80,000 | 3.2% | Buffer para imprevistos construcción |
| **2. SISTEMA ELÉCTRICO** | **$650,000** | **26.0%** | |
| UPS (2× 450 kVA) | $300,000 | 12.0% | APC Symmetra PX, redundancia N+1 |
| Baterías UPS | $80,000 | 3.2% | 40 módulos 12V 200Ah por unidad |
| Generadores (2× 500 kW) | $180,000 | 7.2% | Caterpillar C15 ACERT diesel |
| Tanque diésel 10,000 litros | $25,000 | 1.0% | Autonomía 72 horas a carga promedio |
| ATS/STS y tableros | $40,000 | 1.6% | Deep Sea controllers, tableros principales |
| Instalación y comisionamiento | $25,000 | 1.0% | Mano de obra especializada, pruebas |
| **3. SISTEMA DE REFRIGERACIÓN** | **$380,000** | **15.2%** | |
| CRAC units (4× 120 kW) | $280,000 | 11.2% | Vertiv Liebert CRV, precisión ±1°C |
| Chiller exterior (400 toneladas) | $70,000 | 2.8% | Trane RTAC 400, air-cooled R-134a |
| Tuberías y accesorios | $20,000 | 0.8% | Cobre aislado, válvulas, reguladores |
| Instalación | $10,000 | 0.4% | Mano de obra conexiones HVAC |
| **4. INFRAESTRUCTURA DE RED** | **$520,000** | **20.8%** | |
| Switches Core (2× Nexus 9336) | $180,000 | 7.2% | 36 puertos 100G, Clos topology |
| Switches Aggregation (8× Nexus 9348) | $240,000 | 9.6% | 48 puertos 10G + 4 puertos 100G c/u |
| Switches ToR (40× Catalyst 9300) | $80,000 | 3.2% | 48 puertos mGig + 4 puertos 10G |
| Firewalls (2× Palo Alto PA-5220) | $60,000 | 2.4% | HA configuration, 10Gbps throughput |
| Routers BGP (2× Cisco ASR 1006) | $40,000 | 1.6% | Internet edge, multi-carrier |
| SAN switches (2× Brocade G620) | $20,000 | 0.8% | 32G Fiber Channel fabric redundante |
| **5. CABLEADO ESTRUCTURADO** | **$120,000** | **4.8%** | |
| Fibra óptica (OS2 + OM4) | $40,000 | 1.6% | Monomodo + Multimodo, LC duplex |
| Cobre Cat6A | $25,000 | 1.0% | F/UTP, para 10GBASE-T |
| Cable trays y organización | $20,000 | 0.8% | Aluminio perforado, bandeja overhead |
| Patch panels | $15,000 | 0.6% | 48 puertos por panel, distribución |
| Mano de obra certificada | $20,000 | 0.8% | Instalación + testing TIA-568 |
| **6. RACKS Y GABINETES** | **$160,000** | **6.4%** | |
| Racks 42U (40 unidades) | $80,000 | 3.2% | Montables en piso, 600kg carga |
| PDUs inteligentes (80 unidades) | $40,000 | 1.6% | Monitoreadas, outlets individuales |
| KVM over IP | $15,000 | 0.6% | Acceso remoto a consolas servidores |
| Accesorios (bandejas, ventiladores) | $25,000 | 1.0% | Organizadores, soportes, cables |
| **7. MONITOREO Y DCIM** | **$150,000** | **6.0%** | |
| Software DCIM (EcoStruxure IT) | $50,000 | 2.0% | Gestión infraestructura física |
| Sensores ambientales | $30,000 | 1.2% | Temperatura, humedad, fugas agua |
| Zabbix Enterprise license | $20,000 | 0.8% | Monitoreo infraestructura IT |
| Splunk Enterprise (3-year) | $40,000 | 1.6% | SIEM, análisis logs, compliance |
| Hardware NOC (workstations, displays) | $10,000 | 0.4% | Estaciones operadores + video wall |
| **8. ENLACES DE INTERNET** | **$50,000** | **2.0%** | |
| Instalación fibra Carrier 1 | $20,000 | 0.8% | 10Gbps dedicada, works inside |
| Instalación fibra Carrier 2 | $20,000 | 0.8% | 10Gbps redundancia, ruta diversa |
| Instalación enlace wireless backup | $10,000 | 0.4% | 1Gbps microondas failover |
| **9. SERVIDORES INICIALES** | **$200,000** | **8.0%** | |
| Servidores físicos (15× Dell R750) | $150,000 | 6.0% | 2×16 cores, 512GB RAM, redundancia |
| Licencias VMware vSphere | $50,000 | 2.0% | Enterprise Plus, 5 años soporte |
| **10. ALMACENAMIENTO** | **$250,000** | **10.0%** | |
| SAN (Dell PowerStore 5200T) | $180,000 | 7.2% | 500TB raw, NVMe + SAS, replicación |
| NAS (NetApp FAS8300) | $50,000 | 2.0% | 200TB, deduplicación, HA pair |
| Backup (Veeam + repository disk) | $20,000 | 0.8% | Repositorio local 100TB |
| **11. CONTINGENCIA Y VARIOS** | **$170,000** | **6.8%** | |
| Imprevistos (5% total) | $120,000 | 4.8% | Buffer para cambios de alcance |
| Herramientas y equipamiento | $20,000 | 0.8% | Equipos de testing, multímetros |
| Capacitación personal | $15,000 | 0.6% | Entrenamiento operadores e ingenieros |
| Certificaciones (Tier III, ISO) | $15,000 | 0.6% | Auditoría Uptime + ISO 27001 |
| **TOTAL CAPEX** | **$2,500,000** | **100%** | **Inversión inicial total** |



### **6.2 OPEX (Operational Expenditure) - Costos Anuales**


## 6.2 OPEX (Operational Expenditure) - Costos Anuales

| **Concepto** | **Costo Anual USD** | **% del OPEX** | **Detalles** |
|---|---|---|---|
| **1. ENERGÍA ELÉCTRICA** | **$72,000** | **40.0%** | Consumo: 2,628,000 kWh/año @ $0.027/kWh (CFE DIST) |
| **2. INTERNET (3 ENLACES)** | **$420,000** | **233.3%** | Carrier 1: $180k + Carrier 2: $180k + Backup: $60k |
| **3. MANTENIMIENTO PREVENTIVO** | **$45,000** | **25.0%** | UPS ($12k) + Generadores ($8k) + CRAC ($10k) + Otros ($15k) |
| **4. SEGUROS** | **$18,000** | **10.0%** | Equipo ($12k) + Responsabilidad civil ($4k) + Interrupción ($2k) |
| **5. PERSONAL 24/7** | **$120,000** | **66.7%** | Operadores NOC ($90k) + Guardias ($25k) + Limpieza ($5k) |
| **6. LICENCIAS SOFTWARE** | **$30,000** | **16.7%** | Monitoreo ($15k) + Backup ($8k) + Seguridad ($7k) |
| **7. SOPORTE HARDWARE** | **$25,000** | **13.9%** | Cisco SmartNet ($15k) + Dell ProSupport ($8k) + Storage ($2k) |
| **8. COMBUSTIBLE GENERADORES** | **$3,000** | **1.7%** | Pruebas semanales: 260 litros/año |
| **9. CONSUMIBLES** | **$8,000** | **4.4%** | Baterías amortizadas ($5k) + Filtros/Accesorios ($3k) |
| **10. IMPUESTOS PREDIAL** | **$4,000** | **2.2%** | Tributación anual de inmueble |
| **TOTAL OPEX (sin Internet)** | **$180,000** | **100.0%** | **Operación básica datacenter** |
| **TOTAL OPEX (con Internet)** | **$600,000** | **N/A** | **Incluye conectividad WAN** |

**Comparativa vs Colocation:**

| **Aspecto** | **Colocation Actual** | **Datacenter Propio** | **Ahorro Anual** |
|---|---|---|---|
| **Costo mensual** | $45,000 | $15,000 (sin Internet) | $30,000 |
| **Costo anual** | $540,000 | $180,000 (sin Internet) | **$360,000** |
| **Costo anual (con Internet)** | $540,000 | $600,000 | -$60,000 |
| **Control de infraestructura** | Limitado | Total | ✓ |
| **Compliance y seguridad física** | Compartido | Propio | ✓ |
| **Escalabilidad** | Limitada (vendido) | 10 años capacidad | ✓ |

**Notas sobre OPEX:**
- El costo de **Internet ($420k/año)** es comparable entre colocation y datacenter propio
- El **ahorro real de $360k/año** proviene de eliminar los gastos de colocation
- A partir del **Año 2**, el OPEX se estabiliza (sin reemplazo de baterías)
- La **rotación de personal** y ajustes salariales pueden adicionar 3-5% anual


---

### **6.3 ROI (Return on Investment)**

ANÁLISIS DE RETORNO DE INVERSIÓN

Inversión Inicial (CAPEX): $2,500,000
Ahorro Anual (vs Colocation): $360,000

ROI Simple:
  Payback Period = CAPEX / Ahorro Anual
  = $2,500,000 / $360,000
  = 6.9 años

ROI Ajustado (considerando valor de activos):

Año 0: Inversión -$2,500,000
Año 1: Ahorro +$360,000 | Acumulado: -$2,140,000
Año 2: Ahorro +$360,000 | Acumulado: -$1,780,000
Año 3: Ahorro +$360,000 | Acumulado: -$1,420,000
Año 4: Ahorro +$360,000 | Acumulado: -$1,060,000
Año 5: Ahorro +$360,000 | Acumulado: -$700,000
Año 6: Ahorro +$360,000 | Acumulado: -$340,000
Año 7: Ahorro +$360,000 | Acumulado: +$20,000 [BREAK-EVEN]

Año 10: Acumulado +$1,100,000 (ganancia neta)

Beneficios Intangibles (NO cuantificados):
- Control total de infraestructura
- Cumplimiento compliance más fácil
- Flexibilidad para cambios sin depender de terceros
- Latencia reducida (on-premise)
- Capacidad de crecimiento sin negociaciones
- Valor del inmueble (terreno + construcción)
- Imagen corporativa (datacenter propio)

Valor Residual (Año 10):
├─ Valor de terreno: $350,000 (aprecia 5%/año)
├─ Edificio depreciado: $200,000
├─ Equipos con valor: $500,000 (20% valor inicial)
└─ TOTAL ACTIVOS: $1,050,000

ROI Total a 10 años:
  (Ahorro acumulado + Valor activos - Inversión) / Inversión
  = ($3,600,000 + $1,050,000 - $2,500,000) / $2,500,000
  = $2,150,000 / $2,500,000
  = 86% ROI

Conclusión: Proyecto viable financieramente
```

---

## FASE 7: Plan de Implementación

### **7.1 Cronograma del Proyecto (12 Meses)**

```
FASE 1: PLANIFICACIÓN Y DISEÑO (Meses 1-2)
├─ Semana 1-2: Aprobación presupuesto y kick-off
├─ Semana 3-4: Diseño detallado (eléctrico, HVAC, red)
├─ Semana 5-6: Selección de proveedores (licitación)
├─ Semana 7-8: Contratación y adquisición de equipos
└─ Entregable: Diseño aprobado, contratos firmados

FASE 2: OBRA CIVIL (Meses 3-5)
├─ Semana 9-10: Preparación de terreno
├─ Semana 11-14: Construcción de estructura
├─ Semana 15-18: Instalación de piso falso
├─ Semana 19-20: Acabados y puertas blindadas
└─ Entregable: Edificio terminado, listo para equipamiento

FASE 3: INFRAESTRUCTURA ELÉCTRICA (Meses 5-7)
├─ Semana 19-21: Instalación de UPS y baterías
├─ Semana 22-24: Instalación de generadores y tanque
├─ Semana 25-26: Tableros, PDUs y cableado eléctrico
├─ Semana 27-28: Pruebas de carga y certificación
└─ Entregable: Sistema eléctrico operativo y certificado

FASE 4: INFRAESTRUCTURA HVAC (Meses 6-7)
├─ Semana 23-25: Instalación CRAC units
├─ Semana 26-27: Instalación chiller y tuberías
├─ Semana 28: Comisionamiento y balanceo
└─ Entregable: Sistema de refrigeración operativo

FASE 5: INFRAESTRUCTURA RED (Meses 8-9)
├─ Semana 29-31: Instalación de racks
├─ Semana 32-33: Cableado estructurado
├─ Semana 34-35: Instalación de switches/routers
├─ Semana 36: Configuración y pruebas de red
└─ Entregable: Red datacenter funcional

FASE 6: SEGURIDAD Y MONITOREO (Mes 9-10)
├─ Semana 35-36: Sistema de detección incendios
├─ Semana 37-38: Seguridad física (biométrico, CCTV)
├─ Semana 39: Instalación de sensores ambientales
├─ Semana 40: Configuración DCIM y NOC
└─ Entregable: Sistemas de seguridad operativos

FASE 7: MIGRACIÓN DE SERVICIOS (Meses 11-12)
├─ Semana 41-42: Migración de servicios Tier 3 (dev/test)
├─ Semana 43-44: Migración de servicios Tier 2 (no críticos)
├─ Semana 45-47: Migración de servicios Tier 1 (críticos)
├─ Semana 48: Validación final y cierre de colocation
└─ Entregable: Servicios 100% en datacenter nuevo

FASE 8: CERTIFICACIÓN Y CIERRE (Mes 12)
├─ Semana 49: Auditoría Tier III (Uptime Institute)
├─ Semana 50: Auditoría ISO 27001 (controles físicos)
├─ Semana 51: Documentación as-built
├─ Semana 52: Capacitación personal, cierre proyecto
└─ Entregable: Datacenter certificado y operativo

HITOS CLAVE:
- Mes 2: Diseños aprobados
- Mes 5: Edificio terminado
- Mes 7: Energía y refrigeración operativos
- Mes 9: Red datacenter funcional
- Mes 12: Datacenter 100% operativo y certificado
```

---

### **7.2 Plan de Migración de Servicios**

**Estrategia:** Migración por oleadas según criticidad (menor a mayor riesgo)

```
OLEADA 1: SERVICIOS TIER 3 (Semanas 41-42)
├─ Servidores de desarrollo
├─ Ambientes de QA/Staging
├─ Aplicaciones no críticas
└─ Riesgo: BAJO (pueden tener downtime planificado)

Procedimiento:
  1. Backup completo en colocation
  2. Apagado ordenado de VMs
  3. Transporte de servidores físicos O
     Restauración de backups en nuevo DC
  4. Validación funcional
  5. Monitoreo intensivo 48 horas

OLEADA 2: SERVICIOS TIER 2 (Semanas 43-44)
├─ File servers
├─ Aplicaciones web internas
├─ Bases de datos no críticas
└─ Riesgo: MEDIO (ventana de mantenimiento nocturna)

Procedimiento:
  1. Sincronización de datos (rsync/robocopy)
  2. Ventana de mantenimiento: Sábado 00:00-06:00
  3. Sincronización final (delta)
  4. Cambio de DNS/IP
  5. Pruebas de aceptación usuarios
  6. Rollback plan: 24 horas

OLEADA 3: SERVICIOS TIER 1 CRÍTICOS (Semanas 45-47)
├─ Active Directory / LDAP
├─ Bases de datos productivas (ERP, CRM)
├─ Correo electrónico
└─ Riesgo: ALTO (downtime mínimo, <2 horas)

Procedimiento (por servicio):
  1. Implementar cluster/replicación entre DCs
  2. Sincronización continua
  3. Failover controlado (pruebas previas)
  4. Validación exhaustiva
  5. Desmantelamiento gradual de colocation
  6. Rollback plan: Instantáneo

Ejemplo: Migración de SQL Server Always-On
  ┌──────────────────┐         ┌──────────────────┐
  │ COLOCATION       │         │ DATACENTER NUEVO │
  │                  │         │                  │
  │ SQL Primary ●────┼────────►│ SQL Secondary ○  │
  │ (Active)         │ Replica │ (Standby)        │
  └──────────────────┘         └──────────────────┘
  
  Durante migración:
    1. Secondary sincronizado (lag <1 segundo)
    2. Failover manual (o automático si confident)
    3. Secondary se vuelve Primary
    4. Aplicaciones apuntan a nuevo DC
    5. Downtime: ~30 segundos (DNS TTL + failover)

VALIDACIÓN POST-MIGRACIÓN:
├─ Pruebas funcionales de todas las aplicaciones
├─ Validación de backups en nuevo datacenter
├─ Monitoreo 24/7 por 2 semanas
├─ Usuarios key validan funcionalidad
└─ Sign-off formal de gerencia antes de desmantelar colocation
```

---

## FASE 8: Documentación y Entrenamiento

### **8.1 Documentación Requerida**

```
DOCUMENTACIÓN TÉCNICA:
├─ As-Built Drawings
│   ├─ Planos arquitectónicos finales
│   ├─ Diagramas eléctricos unilineares
│   ├─ Planos de HVAC (ductos, tuberías)
│   └─ Layout de racks con numeración
│
├─ Diagramas de Red
│   ├─ Topología física (L1)
│   ├─ Topología lógica (L2/L3)
│   ├─ VLANs y subnetting
│   ├─ Firewall policies
│   └─ Connectivity matrix
│
├─ Inventario de Activos
│   ├─ CMDB completo (NetBox)
│   ├─ Servidores con specs
│   ├─ Equipos de red con configs
│   ├─ Licencias de software
│   └─ Garantías y contratos
│
├─ Configuraciones
│   ├─ Baseline configs de todos los equipos
│   ├─ Versionadas en Git
│   ├─ Respaldadas en repositorio seguro
│   └─ Change log histórico
│
└─ Procedimientos Operativos (SOPs)
    ├─ Runbooks de incidentes comunes
    ├─ Procedimientos de mantenimiento
    ├─ Disaster Recovery Plan
    ├─ Business Continuity Plan
    └─ Emergency contacts

DOCUMENTACIÓN ADMINISTRATIVA:
├─ Contratos de proveedores
├─ Pólizas de seguro
├─ Certificaciones (Tier III, ISO)
├─ Auditorías y compliance reports
└─ Manuales de equipos (PDF library)

DOCUMENTACIÓN DE USUARIO:
├─ Guía de acceso al datacenter
├─ Procedimiento de solicitud de recursos
├─ Escalamiento de incidentes
└─ FAQs para usuarios finales
```

---

### **8.2 Plan de Capacitación**

```
CAPACITACIÓN NIVEL 1 - OPERADORES NOC (40 horas)

Módulo 1: Fundamentos Datacenter (8 horas)
├─ Conceptos de Tier I-IV
├─ Tour físico del datacenter
├─ Seguridad física y procedimientos de acceso
└─ Evaluación: Examen teórico

Módulo 2: Monitoreo y Alertas (12 horas)
├─ Uso de dashboards (Zabbix, Grafana, DCIM)
├─ Interpretación de alertas
├─ Procedimientos de escalamiento
├─ Práctica: Respuesta a alertas simuladas
└─ Evaluación: Simulacro de incidente

Módulo 3: Infraestructura Física (8 horas)
├─ Sistema eléctrico (UPS, generadores, PDUs)
├─ Sistema de refrigeración (CRAC, monitoreo)
├─ Detección y supresión de incendios
├─ Práctica: Procedimientos de emergencia
└─ Evaluación: Drill de evacuación

Módulo 4: Gestión de Incidentes (12 horas)
├─ Uso de sistema de tickets (Jira)
├─ Runbooks y SOPs
├─ Comunicación con stakeholders
├─ Documentación post-incidente
└─ Evaluación: Caso práctico completo

CAPACITACIÓN NIVEL 2 - INGENIEROS (80 horas)

Módulo 1: Infraestructura de Red (24 horas)
├─ Arquitectura Spine-Leaf
├─ Configuración de switches Cisco/Nexus
├─ Routing (OSPF, BGP)
├─ VLANs, VXLANs, EVPN
├─ Troubleshooting avanzado
└─ Laboratorio: Configuración completa

Módulo 2: Servidores y Virtualización (20 horas)
├─ Administración VMware vSphere
├─ Troubleshooting de VMs
├─ Storage (SAN/NAS)
├─ Backup y restore con Veeam
└─ Laboratorio: Migración de VMs

Módulo 3: Seguridad (16 horas)
├─ Configuración de firewalls Palo Alto
├─ Análisis de logs en Splunk
├─ Respuesta a incidentes de seguridad
├─ Hardening de servidores
└─ Laboratorio: Simulación de ataque

Módulo 4: Sistemas Críticos (20 horas)
├─ Operación de UPS (bypass, mantenimiento)
├─ Operación de generadores
├─ Gestión de CRAC
├─ Monitoreo ambiental
└─ Práctica: Mantenimiento preventivo

CERTIFICACIONES RECOMENDADAS:
├─ CDCP (Certified Data Centre Professional) - Uptime Institute
├─ CCNA Data Center - Cisco
├─ VCP-DCV (VMware Certified Professional)
├─ Palo Alto PCNSA (Network Security Admin)
└─ ITIL Foundation v4
```

---

## Conclusiones y Próximos Pasos

### **Resumen Ejecutivo del Plan**

```
VIABILIDAD TÉCNICA: Demostrada
   - Diseño Tier III certificable
   - Redundancia N+1 en todos los sistemas críticos
   - Arquitectura escalable (10 años crecimiento)
   - Compliance con normativas (ISO 27001, PCI-DSS)

VIABILIDAD FINANCIERA: Positiva
   - Inversión: $2.5M USD
   - Ahorro anual: $360k USD
   - ROI: 86% a 10 años
   - Break-even: 7 años

VIABILIDAD OPERATIVA: Alta
   - Personal capacitado (plan de entrenamiento)
   - Proveedores de soporte contratados
   - Runbooks y SOPs documentados
   - Monitoreo 24/7 con escalamiento

RIESGOS IDENTIFICADOS Y MITIGADOS:
   ├─ Riesgo: Retraso en construcción
   │  └─ Mitigación: Buffer 15% en timeline, penalizaciones contrato
   ├─ Riesgo: Sobrecostos
   │  └─ Mitigación: Contingencia 10%, aprobaciones escalonadas
   ├─ Riesgo: Falla en migración
   │  └─ Mitigación: Migración por fases, rollback plans
   └─ Riesgo: Personal insuficiente
      └─ Mitigación: Contratación anticipada, overlap con vendor
```

---

### **Próximos Pasos (Semana 1-4)**

```
SEMANA 1: Aprobación Formal
├─ Presentación a Comité Directivo
├─ Aprobación de presupuesto CAPEX $2.5M
├─ Firma de autorización de proyecto
└─ Kick-off meeting con stakeholders

SEMANA 2: Contratación de Consultores
├─ RFP (Request for Proposal) a firmas de diseño
├─ Selección de arquitecto/ingeniero estructural
├─ Contratación de consultor Tier III
└─ Firma de contratos de diseño detallado

SEMANA 3: Diseño Detallado
├─ Levantamiento de sitio
├─ Validación de especificaciones técnicas
├─ Ajustes al diseño según sitio real
└─ Generación de planos ejecutivos

SEMANA 4: Licitación de Proveedores
├─ RFQ (Request for Quotation) a proveedores
├─ Equipos eléctricos (UPS, generadores)
├─ Equipos HVAC (CRAC, chillers)
├─ Equipos de red (switches, firewalls)
└─ Análisis de propuestas y adjudicación

MES 2 EN ADELANTE:
└─ Seguir cronograma de 12 meses presentado
```

---

### **Criterios de Éxito del Proyecto**

```
TÉCNICOS:
- Disponibilidad: ≥99.982% (Tier III)
- PUE: ≤1.4
- Tiempo de migración sin incidentes mayores
- Certificación Tier III obtenida
- 0 violaciones de seguridad en primer año

FINANCIEROS:
- Presupuesto cumplido (±5%)
- Timeline cumplido (±10%)
- Ahorro vs colocation confirmado

OPERACIONALES:
- Personal capacitado y certificado
- Documentación completa y actualizada
- Procedimientos operativos funcionando
- NOC operando 24/7 sin incidentes

NEGOCIO:
- Sin impacto a operaciones durante migración
- Satisfacción de usuarios >90%
- Compliance demostrable ante auditorías
- Capacidad para soportar crecimiento proyectado
```

---

## Anexos

### **A. Glosario de Términos**

```
ATS: Automatic Transfer Switch - Conmutador automático entre fuentes
CRAC: Computer Room Air Conditioning - Aire acondicionado de precisión
CMDB: Configuration Management Database
DCIM: Data Center Infrastructure Management
PDU: Power Distribution Unit - Unidad de distribución de energía
PUE: Power Usage Effectiveness - Métrica de eficiencia energética
RTO: Recovery Time Objective - Tiempo objetivo de recuperación
RPO: Recovery Point Objective - Punto objetivo de recuperación
SAN: Storage Area Network - Red de área de almacenamiento
SLA: Service Level Agreement - Acuerdo de nivel de servicio
STS: Static Transfer Switch - Conmutador estático de transferencia
ToR: Top of Rack - Switch en la parte superior del rack
UPS: Uninterruptible Power Supply - Sistema de alimentación ininterrumpida
```

### **B. Referencias y Estándares**

```
- TIA-942: Telecommunications Infrastructure Standard for Data Centers
- Uptime Institute Tier Standard: Topology
- ISO/IEC 27001: Information Security Management
- ISO/IEC 11801: Generic Cabling for Customer Premises
- NFPA 75: Standard for Protection of IT Equipment
- ASHRAE TC 9.9: Thermal Guidelines for Data Centers
- IEC 62305: Protection Against Lightning
```

### **C. Contactos del Proyecto**

```
SPONSOR:
  Nombre: [Director General]
  Email: director@tecnosoft.com
  Teléfono: Ext. 1000

PROJECT MANAGER:
  Nombre: [Gerente de Infraestructura]
  Email: infraestructura@tecnosoft.com
  Teléfono: Ext. 1234

LEADS TÉCNICOS:
  Eléctrico: [Nombre] - Ext. XXXX
  HVAC: [Nombre] - Ext. XXXX
  Redes: [Nombre] - Ext. XXXX
  Servidores: [Nombre] - Ext. XXXX

PROVEEDORES CLAVE:
  UPS: APC by Schneider - 800-XXX-XXXX
  Generadores: Caterpillar - 800-XXX-XXXX
  CRAC: Vertiv - 800-XXX-XXXX
  Networking: Cisco Systems - Account Manager
```

---

**FIN DEL DOCUMENTO**

**Aprobaciones:**

_______________________  
Director General  
Fecha: ___________

_______________________  
Director Financiero  
Fecha: ___________

_______________________  
Director de TI  
Fecha: ___________

---

**Historial de Revisiones:**

| Versión | Fecha | Autor | Cambios |
|---------|-------|-------|---------|
| 1.0 | 2026-03-30 | Equipo Infraestructura | Versión inicial |
