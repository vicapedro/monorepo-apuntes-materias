# Guía de Conexión del Equipamiento Donado

**Instituto:** TecNM  
**Equipamiento:** HP BladeSystem c7000 + Storage SAN  
**Fecha:** Noviembre 2025

---

## ⚠️ IMPORTANTE: Equipamiento Pre-Configurado

**Este equipamiento ya viene con VMware ESXi instalado y configurado.** No es necesario instalar sistemas operativos desde cero.

## Resumen del Equipamiento

### HP BladeSystem c7000 Enclosure

**Componentes del Enclosure:**
- **14 Server Blades** (todos con VMware ESXi instalado):
  - **8x HP ProLiant BL465c Gen8** (Bays 1-4, 9-12) - **Producción**
    - AMD Opteron 6348 (2x CPU, 12 cores cada uno = 24 cores total)
    - 64GB RAM
    - VMware ESXi 6.5.0 (ya instalado)
    - HBA FC: HP LPe1205A 8Gb (2 puertos) o HP LPe1605 16Gb
  - **6x Blades Antiguos** (Bays 5-8, 13-14) - **Laboratorio/Repuestos**
    - VMware ESXi 5.0 o 6.0 (ya instalado)
    - Menor RAM (4-24GB)
  
- **Switches de Red:**
  - **2x GbE2c Layer 2/3 Ethernet** (red LAN)
    - Switch 1: `192.168.43.12` (admin/admin)
    - Switch 2: `192.168.43.13` (admin/admin)
  - **2x Brocade 4/12 SAN Switch** (red SAN Fibre Channel)
    - SAN Switch 1: `192.168.43.14` (admin/password)
    - SAN Switch 2: `192.168.43.15` (admin/password)

- **Gestión del Enclosure:**
  - **2x Onboard Administrator** (OA)
    - OA1: `192.168.43.11` (Administrator: `29FP9QVC` o Admin2: `TEC$sin$600`)
  - 10x Active Cool 200 Fan (ventiladores redundantes)
  - 6x Fuentes de poder redundantes

- **Virtualización Centralizada:**
  - **vCenter 6.5**: `https://192.168.42.20` (Administrator@vsphere.local / `TEC$sin$600`)
    - Corre en VM en Blade 1 (192.168.42.1)
  - **vCenter 5.5**: `192.168.42.30` (root / vmware)
    - Corre en VM en Blade 12 (192.168.42.12)

### Almacenamiento SAN

**Storage 1: HP P2000G3 FC/iSCSI Dual Controller**
- Serial Number: 2S6035C135
- **Ya configurado y accesible:** `http://10.0.0.3` (manage / !manage)
- Configuración actual: 6x discos SATA 1TB + 6x discos SAS 600GB
- Capacidad total: ~9.6TB
- **Estado:** Ya conectado y funcionando con los blades vía FC
- **Destino:** Storage compartido para laboratorios y prácticas

**Storage 2: HP MSA (70 discos de 1TB)**
- Serial Number: USE408S2MM
- Capacidad total: ~70TB
- **Estado:** Pendiente de conexión física al BladeSystem c7000
- **Destino:** Storage principal para VMs de producción y bases de datos

### Servidor Standalone

**HP ProLiant DL360p Gen8**
- Serial Number: USE408S2MB
- Disco local: 1x 600GB SAS
- **Uso sugerido:** Servidor Proxmox independiente o nodo adicional de laboratorio
- **Nota:** Puede conectarse al P2000G3 si se requiere storage adicional (ver Parte 2)

---

## Inventario Detallado de Blades con VMware ESXi

### Credenciales Generales

**Onboard Administrator (OA):**
- URL: `https://192.168.43.11`
- Usuario: `Administrator` / Contraseña: `29FP9QVC`
- Usuario alternativo: `Admin2` / Contraseña: `TEC$sin$600`

**Switches Ethernet:**
- Switch 1: `192.168.43.12` (admin/admin)
- Switch 2: `192.168.43.13` (admin/admin)

**Switches SAN (Brocade FC):**
- SAN Switch 1: `192.168.43.14` (admin/password)
- SAN Switch 2: `192.168.43.15` (admin/password)

**vCenter:**
- vCenter 6.5: `https://192.168.42.20` (Administrator@vsphere.local / `TEC$sin$600`)
- vCenter 5.5: `192.168.42.30` (root / vmware)

**Storage P2000G3:**
- Web UI: `http://10.0.0.3`
- Usuario: `manage` / Contraseña: `!manage`

---

### Blades de Producción (Gen8) - VMware ESXi 6.5

#### Bay 1 - ProLiant BL465c Gen8
```
Serial Number: USE521R4MS
ILO: https://192.168.43.16 (Admin2 / TEC$sin$600)
ESXi: https://192.168.42.1 (root / TEC$sin$600)
vCenter: https://192.168.42.20 (corre en VM en este blade)

Hardware:
  CPU: 2x AMD Opteron 6348 (12 cores) = 24 cores
  RAM: 64GB
  HBA FC: HP LPe1205A 8Gb
    Port 1 WWN: 10:00:00:90:fa:88:5f:f2
    Port 2 WWN: 10:00:00:90:fa:88:5f:f3

VMware: ESXi 6.5.0 Update 3
```

#### Bay 2 - ProLiant BL465c Gen8
```
Serial Number: MXQ433028M
ILO: https://192.168.43.17 (Admin2 / TEC$sin$600)
ESXi: https://192.168.42.2 (root / TEC$sin$600)

Hardware:
  CPU: 2x AMD Opteron 6348 (12 cores) = 24 cores
  RAM: 64GB
  HBA FC: HP LPe1605 16Gb
    Port 1 WWN: 10:00:a0:d3:c1:c6:4f:5c
    Port 2 WWN: 10:00:a0:d3:c1:c6:4f:5d

VMware: ESXi 6.5.0 Update 2 (Build 8294253)
```

#### Bay 3 - ProLiant BL465c Gen8
```
Serial Number: MXQ433028L
ILO: https://192.168.43.18 (Admin2 / TEC$sin$600)
ESXi: https://192.168.42.3 (root / TEC$sin$600)

Hardware:
  CPU: 2x AMD Opteron 6348 (12 cores) = 24 cores
  RAM: 64GB
  HBA FC: HP LPe1605 16Gb
    Port 1 WWN: 10:00:a0:b3:cc:1c:c9:76
    Port 2 WWN: 10:00:a0:b3:cc:1c:c9:77

VMware: ESXi 6.5.0
```

#### Bay 4 - ProLiant BL465c Gen8
```
Serial Number: MXQ54708VL
ILO: https://192.168.43.19 (Admin2 / TEC$sin$600)
ESXi: https://192.168.42.4 (root / TEC$sin$600)

Hardware:
  CPU: 2x AMD Opteron 6348 (12 cores) = 24 cores
  RAM: 64GB
  HBA FC: HP LPe1205A 8Gb
    Port 1 WWN: 10:00:00:90:fa:ab:83:f2
    Port 2 WWN: 10:00:00:90:fa:ab:83:f3

VMware: ESXi 6.5.0
```

#### Bay 9 - ProLiant BL465c Gen8
```
Serial Number: USE3203YE1
ILO: https://192.168.43.24 (Admin2 / TEC$sin$600)
ESXi: https://192.168.42.9 (root / TEC$sin$600)

Hardware:
  CPU: 2x AMD Opteron 6348 (12 cores) = 24 cores
  RAM: 64GB
  HBA FC: HP LPe1205A 8Gb
    Port 1 WWN: 10:00:6c:3b:e5:c1:b6:9e
    Port 2 WWN: 10:00:6c:3b:e5:c1:b6:9f

VMware: ESXi 6.5.0
```

#### Bay 10 - ProLiant BL465c Gen8
```
Serial Number: USE3203YE2
ILO: https://192.168.43.25 (Admin2 / TEC$sin$600)
ESXi: https://192.168.42.10 (root / TEC$sin$600)

Hardware:
  CPU: 2x AMD Opteron 6348 (12 cores) = 24 cores
  RAM: 64GB
  HBA FC: HP LPe1205A 8Gb
    Port 1 WWN: 10:00:38:ea:a7:d3:e4:6a
    Port 2 WWN: 10:00:38:ea:a7:d3:e4:6b

VMware: ESXi 6.5.0
```

#### Bay 11 - ProLiant BL465c Gen8
```
Serial Number: USE3203YE0
ILO: https://192.168.43.26 (Admin2 / TEC$sin$600)
ESXi: https://192.168.42.11 (root / TEC$sin$600)

Hardware:
  CPU: 2x AMD Opteron 6348 (12 cores) = 24 cores
  RAM: 64GB
  HBA FC: HP LPe1205A 8Gb
    Port 1 WWN: 10:00:38:ea:a7:d3:e5:42
    Port 2 WWN: 10:00:38:ea:a7:d3:e5:43

VMware: ESXi 6.5.0
```

#### Bay 12 - ProLiant BL465c Gen8
```
Serial Number: USE3203YDY
ILO: https://192.168.43.27 (Admin2 / TEC$sin$600)
ESXi: https://192.168.42.12 (root / TEC$sin$600)
vCenter 5.5: https://192.168.42.30 (corre en VM en este blade)

Hardware:
  CPU: 2x AMD Opteron 6348 (12 cores) = 24 cores
  RAM: 64GB
  HBA FC: HP LPe1205A 8Gb
    Port 1 WWN: 10:00:38:ea:a7:d3:e5:ac
    Port 2 WWN: 10:00:38:ea:a7:d3:e5:ad

VMware: ESXi 6.5.0
```

---

### Blades de Laboratorio (Generaciones Antiguas)

**⚠️ Nota:** Estos blades requieren **Internet Explorer** para acceder al ILO (incompatibilidad con navegadores modernos)

#### Bay 5 - ProLiant BL260c G5
```
Serial Number: USM73800N2
ILO: https://192.168.43.20 (Admin2 / TEC$sin$600) - REQUIERE IE
ESXi: http://192.168.42.5 (root / TEC$sin$600)

Hardware:
  CPU: 2x Quad-Core Intel Xeon, 2000 MHz = 8 cores
  RAM: 16GB
  HBA FC: QLogic QMH2562 8Gb
    Port 1 WWN: 50:01:43:80:14:0d:95:74
    Port 2 WWN: 50:01:43:80:14:0d:95:76

VMware: ESXi 5.0.0
```

#### Bay 6 - ProLiant BL465c G1
```
Serial Number: ^SM73800N2
ILO: https://192.168.43.21 (Admin2 / TEC$sin$600) - REQUIERE IE
ESXi: http://192.168.42.6 (root / TEC$sin$600)

Hardware:
  CPU: 2x Dual-Core AMD Opteron, 2400 MHz = 4 cores
  RAM: 6GB
  HBA FC: QLogic QMH2462 4Gb
    Port 1 WWN: 50:01:43:80:02:9f:a3:10
    Port 2 WWN: 50:01:43:80:02:9f:a3:12

VMware: ESXi 5.0
```

#### Bay 7 - ProLiant BL685c G1
```
Serial Number: USM738014E
ILO: https://192.168.43.22 (Admin2 / TEC$sin$600) - REQUIERE IE
ESXi: http://192.168.42.7 (root / TEC$sin$600)

Hardware:
  CPU: 2x Dual-Core AMD Opteron, 2400 MHz = 4 cores
  RAM: 24GB
  HBA FC: QLogic QMH2462 4Gb
    Port 1 WWN: 50:01:43:80:00:bd:ed:48
    Port 2 WWN: 50:01:43:80:00:bd:ed:4a

VMware: ESXi 6.0.0
```

#### Bay 8 - ProLiant BL680c G5
```
Serial Number: USE11699S4
ILO: https://192.168.43.23 (Admin2 / TEC$sin$600) - REQUIERE IE
ESXi: http://192.168.42.8 (root / TEC$sin$600)

Hardware:
  CPU: 4x Six-Core Intel Xeon MP, 2400 MHz = 24 cores
  RAM: 48GB
  HBA FC: QLogic QMH2462 4Gb
    Port 1 WWN: 50:01:43:80:02:9f:a3:14
    Port 2 WWN: 50:01:43:80:02:9f:a3:16

VMware: ESXi 6.0.0
```

#### Bay 13 - ProLiant BL460c G1
```
Serial Number: 2UX742072N
ILO: https://192.168.43.28 (Admin2 / TEC$sin$600) - REQUIERE IE
ESXi: http://192.168.42.13 (root / TEC$sin$600)

Hardware:
  CPU: 1x Quad-Core Intel Xeon, 2333 MHz = 4 cores
  RAM: 4GB
  HBA FC: QLogic QMH2462 4Gb
    Port 1 WWN: 50:01:10:a0:00:19:b3:10
    Port 2 WWN: 50:01:10:a0:00:19:b3:12

VMware: ESXi 5.0
```

#### Bay 14 - ProLiant BL465c G1
```
Serial Number: USM71501L0
ILO: https://192.168.43.29 (Admin2 / TEC$sin$600) - REQUIERE IE
ESXi: http://192.168.42.14 (root / TEC$sin$600)

Hardware:
  CPU: 1x Dual-Core AMD Opteron, 2400 MHz = 2 cores
  RAM: 4GB
  HBA FC: QLogic QMH2462 4Gb
    Port 1 WWN: 50:01:43:80:00:bd:ed:70
    Port 2 WWN: 50:01:43:80:00:bd:ed:72

VMware: ESXi 5.0
```

---

## Arquitectura de Red Actual

### Red de Gestión (192.168.43.0/24)
```
OA1:          192.168.43.11
Switch LAN 1: 192.168.43.12
Switch LAN 2: 192.168.43.13
SAN Switch 1: 192.168.43.14
SAN Switch 2: 192.168.43.15
ILO Blades:   192.168.43.16-29 (Bay 1-14)
```

### Red de Producción ESXi (192.168.42.0/24)
```
ESXi Hosts:   192.168.42.1-14 (Bay 1-14)
vCenter 6.5:  192.168.42.20
vCenter 5.5:  192.168.42.30
```

### Red de Storage (10.0.0.0/24)
```
P2000 G3:     10.0.0.3 (ya conectado y operativo)
MSA (70TB):   Pendiente de asignar (sugerido: 10.0.0.10)
```

---

## Acceso Rápido al Sistema VMware

### Gestión Centralizada con vCenter

**Opción Recomendada: vCenter 6.5**
```
URL: https://192.168.42.20
Usuario: Administrator@vsphere.local
Contraseña: TEC$sin$600

Características:
✓ Gestiona los 8 blades Gen8 (ESXi 6.5)
✓ Interfaz web moderna (vSphere Client HTML5)
✓ Alta disponibilidad, vMotion, DRS
✓ Corre como VM en Blade 1 (192.168.42.1)
```

**Opción Alternativa: vCenter 5.5 (Legacy)**
```
URL: https://192.168.42.30
Usuario: root
Contraseña: vmware

Características:
✓ Gestiona blades antiguos (ESXi 5.0/6.0)
✓ Requiere vSphere Client (cliente de escritorio)
✓ Corre como VM en Blade 12 (192.168.42.12)
```

### Acceso Directo a ESXi Hosts (sin vCenter)

Si vCenter está inaccesible, puedes acceder directamente a cada blade:

**Hosts de Producción (Gen8):**
```bash
# Bay 1-4, 9-12 (ESXi 6.5 con interfaz web HTML5)
https://192.168.42.1   # Bay 1 (también tiene vCenter 6.5 como VM)
https://192.168.42.2   # Bay 2
https://192.168.42.3   # Bay 3
https://192.168.42.4   # Bay 4
https://192.168.42.9   # Bay 9
https://192.168.42.10  # Bay 10
https://192.168.42.11  # Bay 11
https://192.168.42.12  # Bay 12 (también tiene vCenter 5.5 como VM)

Usuario: root
Contraseña: TEC$sin$600
```

**Hosts de Laboratorio (Antiguos):**
```bash
# Bay 5-8, 13-14 (ESXi 5.0/6.0 con interfaz antigua)
http://192.168.42.5    # Bay 5 (ESXi 5.0)
http://192.168.42.6    # Bay 6 (ESXi 5.0)
http://192.168.42.7    # Bay 7 (ESXi 6.0)
http://192.168.42.8    # Bay 8 (ESXi 6.0)
http://192.168.42.13   # Bay 13 (ESXi 5.0)
http://192.168.42.14   # Bay 14 (ESXi 5.0)

Usuario: root
Contraseña: TEC$sin$600

⚠️ Nota: ESXi 5.0/6.0 requieren vSphere Client (aplicación de escritorio)
```

### Gestión de Hardware con iLO

Cada blade tiene su propia interfaz iLO (Integrated Lights-Out) para gestión remota:

```bash
# Bays 1-4, 9-12 (iLO moderna, navegadores actuales)
https://192.168.43.16  # Bay 1
https://192.168.43.17  # Bay 2
https://192.168.43.18  # Bay 3
https://192.168.43.19  # Bay 4
https://192.168.43.24  # Bay 9
https://192.168.43.25  # Bay 10
https://192.168.43.26  # Bay 11
https://192.168.43.27  # Bay 12

# Bays 5-8, 13-14 (iLO antigua, REQUIERE Internet Explorer)
https://192.168.43.20  # Bay 5 - ⚠️ REQUIERE IE
https://192.168.43.21  # Bay 6 - ⚠️ REQUIERE IE
https://192.168.43.22  # Bay 7 - ⚠️ REQUIERE IE
https://192.168.43.23  # Bay 8 - ⚠️ REQUIERE IE
https://192.168.43.28  # Bay 13 - ⚠️ REQUIERE IE
https://192.168.43.29  # Bay 14 - ⚠️ REQUIERE IE

Usuario: Admin2
Contraseña: TEC$sin$600

Funciones de iLO:
✓ Consola virtual (teclado/video/mouse remoto)
✓ Encendido/apagado remoto
✓ Monitoreo de hardware (temperatura, ventiladores, fuentes)
✓ Logs de eventos del sistema
✓ Montaje de ISOs remotas
```

### Verificar Conectividad Inicial

**Paso 1: Acceder al Onboard Administrator**
```bash
URL: https://192.168.43.11
Usuario: Admin2
Contraseña: TEC$sin$600

Verificar:
✓ Todos los blades están encendidos (Server Status: OK)
✓ Switches Ethernet están activos (Interconnect Bays 1-2)
✓ Switches SAN están activos (Interconnect Bays 3-4)
✓ Temperaturas normales (Thermal Status)
✓ Fuentes de poder OK (Power Supplies)
```

**Paso 2: Acceder a vCenter 6.5**
```bash
URL: https://192.168.42.20
Usuario: Administrator@vsphere.local
Contraseña: TEC$sin$600

Verificar:
✓ Los 8 hosts ESXi 6.5 están conectados (verde)
✓ VMs están corriendo (especialmente vCenter VM)
✓ Datastores visibles (P2000 storage)
```

**Paso 3: Verificar Acceso al Storage P2000**
```bash
URL: http://10.0.0.3
Usuario: manage
Contraseña: !manage

Verificar:
✓ Ambos controladores online (Controller A y B)
✓ Discos en estado OK
✓ Virtual Disks (LUNs) creados y mapeados
✓ Conexiones FC activas a los blades
```

---

## Tareas Prioritarias con el Sistema Actual

### Opción A: Usar el Sistema VMware Existente

**Si deseas continuar con VMware ESXi 6.5:**

1. ✅ **Ya tienes vCenter funcionando** - Gestiona VMs centralizadamente
2. ✅ **Ya tienes storage P2000 conectado** - Crea datastores adicionales si necesitas
3. ⏳ **Conectar MSA de 70TB** (sigue Parte 1 de esta guía)
4. ⏳ **Crear datastores en MSA** desde vCenter
5. ⏳ **Migrar/crear VMs** para laboratorios académicos

**Ventajas:**
- Sistema pre-configurado y probado
- vCenter 6.5 es estable y funcional
- Storage P2000 ya integrado
- Conocimiento de VMware es transferible a la industria

### Opción B: Migrar a Proxmox VE

**Si deseas migrar a Proxmox (recomendado para educación):**

1. ⏳ **Backup de VMs críticas** (vCenter, servicios)
2. ⏳ **Instalar Proxmox en 1-2 blades** como prueba piloto
3. ⏳ **Configurar cluster Proxmox** entre blades
4. ⏳ **Conectar MSA al cluster Proxmox**
5. ⏳ **Migrar VMs desde VMware** (convertir VMDK a qcow2)
6. ⏳ **Expandir cluster progresivamente**

**Ventajas:**
- Open source (sin licencias)
- Soporta KVM y LXC (contenedores)
- Interfaz web moderna
- API REST completa (automatización)
- Mejor para enseñanza (código abierto, documentación)

### Opción C: Entorno Híbrido

**Mantener ambos sistemas:**

1. **Blades 1-4 (Gen8):** VMware ESXi 6.5 + vCenter (producción)
2. **Blades 9-12 (Gen8):** Proxmox VE cluster (laboratorio/desarrollo)
3. **Blades 5-8, 13-14 (antiguos):** Laboratorio de estudiantes (Docker, K8s)

**Ventajas:**
- Flexibilidad para diferentes cursos
- Comparativa VMware vs Proxmox
- No pierdes inversión en configuración VMware actual

---

## Arquitectura de Conexión Propuesta

```
┌─────────────────────────────────────────────────────────────┐
│              HP BladeSystem c7000 Enclosure                 │
│                                                             │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐  ┌──────────┐   │
│  │ Blade 1  │  │ Blade 2  │  │ Blade 3  │  │ Blade 8  │   │
│  │ BL465c   │  │ BL465c   │  │ BL465c   │  │ BL465c   │   │
│  │ Gen8     │  │ Gen8     │  │ Gen8     │  │ Gen8     │   │
│  │ (HBA FC) │  │ (HBA FC) │  │ (HBA FC) │  │ (HBA FC) │   │
│  └────┬─────┘  └────┬─────┘  └────┬─────┘  └────┬─────┘   │
│       │             │              │              │         │
│  [Conexión interna mediante backplane del enclosure]       │
│       │             │              │              │         │
│  ┌────▼─────────────▼──────────────▼──────────────▼─────┐  │
│  │  Brocade FC Switch 1 (Bay 1 o 2)                     │  │
│  │  - 4 puertos internos (a blades)                     │  │
│  │  - 12 puertos externos (a storage)                   │  │
│  └────────────────────┬──────────────────────────────────┘  │
│                       │                                     │
│  ┌────────────────────▼──────────────────────────────────┐  │
│  │  Brocade FC Switch 2 (Bay 1 o 2) - REDUNDANCIA       │  │
│  │  - 4 puertos internos (a blades)                     │  │
│  │  - 12 puertos externos (a storage)                   │  │
│  └────────────────────┬──────────────────────────────────┘  │
└────────────────────────┼──────────────────────────────────────┘
                        │
          Cables FC externos (LC duplex, 8Gb)
                        │
         ┌──────────────┴─────────────┐
         │                            │
         │                            │
    ┌────▼─────┐               ┌──────▼─────┐
    │ Storage  │               │  Servidor  │
    │ HP MSA   │               │  DL360p    │
    │ 70 discos│               │  Gen8      │
    │ 70TB     │               │            │
    └──────────┘               └──────┬─────┘
                                      │
                          Cable FC o iSCSI
                                      │
                               ┌──────▼────────┐
                               │  Storage      │
                               │  HP P2000G3   │
                               │  12 discos    │
                               │  9.6TB        │
                               └───────────────┘
```

---

## Parte 1: Conectar HP MSA (70TB) al BladeSystem c7000

### Estado Actual del Storage

**✅ P2000G3 (9.6TB):** Ya está conectado y funcionando
- Accesible en `http://10.0.0.3`
- Los blades ya tienen acceso vía Fibre Channel
- Zoning ya configurado en switches Brocade

**⏳ MSA (70TB):** Pendiente de conexión física
- **Esta guía cubre la conexión del MSA al BladeSystem**

---

### 1.1 Materiales Necesarios

**Cables Fibre Channel:**
- Mínimo 4 cables LC-LC duplex, 8Gbps, longitud 1-3m
- Recomendado: 6-8 cables para redundancia completa
- Color típico: naranja (multimode) o amarillo (single-mode)

**Transceptores SFP+ (si no vienen en el equipo):**
- 8Gb FC SFP+ para puertos Brocade
- 8Gb FC SFP+ para puertos MSA

### 1.2 Identificar Componentes Físicos

#### En el HP BladeSystem c7000:

**Parte trasera del enclosure:**
- Localiza los **Interconnect Bays** (slots verticales para switches)
- Los Brocade FC Switch están en 2 de estos bays (probablemente bay 1 y 2, o bay 3 y 4)
- Cada Brocade tiene puertos SFP+ externos en la parte trasera (pequeños, con tapas protectoras naranjas)

**Identificar puertos externos:**
```
Brocade 4/12 SAN Switch:
┌─────────────────────────────┐
│ Puertos Externos (arriba)   │
│ [1] [2] [3] [4] [5] [6]     │
│ [7] [8] [9] [10] [11] [12]  │
└─────────────────────────────┘
```

#### En el HP MSA Storage:

**Parte trasera del storage:**
- Localiza los 2 **controladores** (Controller A y Controller B)
- Cada controlador tiene puertos FC etiquetados como **"Host"** o **"FC"**
- NO confundir con puertos **"Drive"** o **"Expansion"** (esos son para expansion shelves)

**Distribución típica:**
```
Controller A (izquierda):
  Host Port 1: [FC]
  Host Port 2: [FC]
  Host Port 3: [FC]
  Host Port 4: [FC]
  
Controller B (derecha):
  Host Port 1: [FC]
  Host Port 2: [FC]
  Host Port 3: [FC]
  Host Port 4: [FC]
```

### 1.3 Conexión Física (Configuración Redundante)

**⚠ IMPORTANTE: Apaga TODO antes de conectar cables FC**

```bash
# Orden de apagado:
1. Apagar todos los blades desde Onboard Administrator
2. Apagar el enclosure c7000 (interruptores de las fuentes)
3. Apagar el storage MSA (interruptores en la parte trasera)
```

**Conexión de Cables FC:**

```
Configuración mínima (4 cables):
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Cable 1: Brocade Switch 1, puerto externo 1  →  MSA Controller A, Host Port 1
Cable 2: Brocade Switch 1, puerto externo 2  →  MSA Controller A, Host Port 2
Cable 3: Brocade Switch 2, puerto externo 1  →  MSA Controller B, Host Port 1
Cable 4: Brocade Switch 2, puerto externo 2  →  MSA Controller B, Host Port 2

Configuración completa redundante (8 cables):
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Cable 1: Brocade Switch 1, puerto externo 1  →  MSA Controller A, Host Port 1
Cable 2: Brocade Switch 1, puerto externo 2  →  MSA Controller A, Host Port 2
Cable 3: Brocade Switch 1, puerto externo 3  →  MSA Controller A, Host Port 3
Cable 4: Brocade Switch 1, puerto externo 4  →  MSA Controller A, Host Port 4

Cable 5: Brocade Switch 2, puerto externo 1  →  MSA Controller B, Host Port 1
Cable 6: Brocade Switch 2, puerto externo 2  →  MSA Controller B, Host Port 2
Cable 7: Brocade Switch 2, puerto externo 3  →  MSA Controller B, Host Port 3
Cable 8: Brocade Switch 2, puerto externo 4  →  MSA Controller B, Host Port 4
```

**Diagrama de Redundancia:**
```
Switch 1 ──┬──> Controller A, Port 1
           └──> Controller A, Port 2

Switch 2 ──┬──> Controller B, Port 1
           └──> Controller B, Port 2

Beneficio: Si falla Switch 1 o Controller A, 
           los blades acceden por Switch 2 → Controller B
```

### 1.4 Conexión de Red de Gestión

**Conectar cable Ethernet al puerto de Management:**

```
MSA Controller A, puerto "Management" o "Mgmt" → Switch Ethernet de gestión

IP por defecto del MSA:
  Controller A: 192.168.1.100
  Controller B: 192.168.1.101
  
Tu PC de configuración debe estar en la misma red: 192.168.1.x
```

### 1.5 Encendido Ordenado

```bash
# Orden de encendido:
1. Enciende el storage MSA (espera 2-3 minutos hasta que los LEDs estabilicen)
2. Enciende el enclosure c7000 (interruptores de fuentes)
3. Espera 5 minutos (los Onboard Administrators y switches Brocade deben iniciar)
4. Desde el navegador, accede al OA: https://<IP-OA>
5. Enciende los blades uno por uno desde el OA
```

### 1.6 Configuración Inicial del MSA Storage

#### Acceder a la Interfaz Web:

```bash
# Desde tu PC conectado al switch de gestión:
https://192.168.1.100

# Credenciales por defecto:
Usuario: manage
Contraseña: !manage
```

#### Tareas Iniciales en el MSA:

**1. Cambiar IP de gestión (opcional pero recomendado):**
```
Network Settings → Management IP
  Controller A: 10.10.10.10 (tu red de gestión)
  Controller B: 10.10.10.11
  Gateway: 10.10.10.1
```

**2. Verificar discos detectados:**
```
Navigation → Disks
  Debes ver los 70 discos de 1TB listados
  Estado: "OK" o "Uninitialized"
```

**3. Crear Disk Groups (RAID):**

**Opción A: Un solo RAID Group grande**
```
Configuration → Disk Groups → Create
  Nombre: DG01_RAID6_70TB
  RAID Level: RAID 6 (tolerancia a 2 fallos)
  Discos: Seleccionar los 70 discos
  Capacidad usable: ~60TB (considerando paridad y overhead)
```

**Opción B: Múltiples RAID Groups (recomendado para laboratorio)**
```
DG01_RAID6_Databases: 20 discos, RAID 6 (~17TB) - Para bases de datos
DG02_RAID6_VMs: 30 discos, RAID 6 (~26TB) - Para VMs
DG03_RAID5_Lab: 20 discos, RAID 5 (~19TB) - Para prácticas de laboratorio
```

**4. Crear Virtual Disks (LUNs):**
```
Configuration → Virtual Disks → Create
  Nombre: LUN01_Databases
  Disk Group: DG01_RAID6_Databases
  Tamaño: 17TB (todo el disk group)
  Opciones avanzadas:
    - Sector Size: 512 bytes (compatibilidad) o 4096 (performance)
    - Cache: Write-Back with Mirroring (mejor performance)
```

**Repetir para cada LUN que necesites exponer a los blades.**

### 1.7 Configuración de Zoning en Brocade FC Switches

El **zoning** define qué blades pueden acceder a qué LUNs del storage.

#### Acceder al Brocade Switch:

**Opción 1: Desde el Onboard Administrator**
```
1. Navega a: https://<IP-OA>
2. Login: Administrator / (en blanco o "password")
3. Menu: Interconnect Bays
4. Selecciona el Brocade FC Switch (bay 1 o 2)
5. Click en "Launch" → Abre la interfaz web del Brocade
```

**Opción 2: Acceso directo SSH/Web**
```
# El switch Brocade obtiene IP del OA
# Consulta la IP en el OA: Interconnect Bays → Info

ssh admin@<IP-Brocade>
Contraseña: password (por defecto)
```

#### Obtener WWNs (World Wide Names):

**WWNs de los Blades (ya los tienes en el inventario):**
```
Blade 1 (USE521R4MS):
  HBA Port 1: 10:00:00:90:fa:88:5f:f2
  HBA Port 2: 10:00:00:90:fa:88:5f:f3

Blade 2 (MXQ433028M):
  HBA Port 1: 10:00:38:ea:a7:d3:d5:ea
  HBA Port 2: 10:00:38:ea:a7:d3:d5:eb

Blade 3 (MXQ433028L):
  HBA Port 1: 10:00:00:90:fa:88:60:72
  HBA Port 2: 10:00:00:90:fa:88:60:73

... (continuar para todos los blades que uses)
```

**WWNs del MSA Storage (obtener desde la interfaz web del MSA):**
```
MSA Interface → Configuration → FC Ports
  Controller A, Port 1: 50:00:00:xx:xx:xx:xx:xx (ejemplo)
  Controller A, Port 2: 50:00:00:xx:xx:xx:xx:xx
  Controller B, Port 1: 50:00:00:xx:xx:xx:xx:xx
  Controller B, Port 2: 50:00:00:xx:xx:xx:xx:xx
```

#### Crear Zoning (Ejemplo para Blade 1):

**Desde CLI del Brocade:**

```bash
# Conectar por SSH
ssh admin@<IP-Brocade>

# Ver dispositivos conectados y sus WWNs
switchshow

# Crear alias para facilitar gestión
alicreate "blade1_hba_port1", "10:00:00:90:fa:88:5f:f2"
alicreate "blade1_hba_port2", "10:00:00:90:fa:88:5f:f3"
alicreate "msa_ctrlA_port1", "50:00:00:xx:xx:xx:xx:xx"  # Reemplaza con WWN real
alicreate "msa_ctrlA_port2", "50:00:00:xx:xx:xx:xx:xx"
alicreate "msa_ctrlB_port1", "50:00:00:xx:xx:xx:xx:xx"
alicreate "msa_ctrlB_port2", "50:00:00:xx:xx:xx:xx:xx"

# Crear zonas (1 blade puede ver 1 controller)
zonecreate "zone_blade1_to_msaA", "blade1_hba_port1;msa_ctrlA_port1"
zonecreate "zone_blade1_to_msaB", "blade1_hba_port2;msa_ctrlB_port1"

# Crear configuración de zona
cfgcreate "lab_config", "zone_blade1_to_msaA;zone_blade1_to_msaB"

# Activar configuración
cfgenable "lab_config"

# Guardar cambios permanentemente
cfgsave

# Salir
exit
```

**Repetir el proceso de zoning para cada blade que necesite acceso al storage.**

#### Configuración Simplificada (Todos los Blades Ven Todo):

```bash
# Crear zona amplia (menos seguro pero más simple para laboratorio)
zonecreate "zone_all_blades_to_msa", "blade1_hba_port1;blade2_hba_port1;blade3_hba_port1;msa_ctrlA_port1;msa_ctrlB_port1"

cfgcreate "lab_simple_config", "zone_all_blades_to_msa"
cfgenable "lab_simple_config"
cfgsave
```

### 1.8 Mapeo de LUNs a Hosts (desde el MSA)

Desde la interfaz web del MSA:

```
Configuration → Virtual Disks → LUN01_Databases → Actions → Map to Host

Host Group: Crear nuevo grupo "BladeCluster"
  Agregar WWNs de los blades que accederán a este LUN
  
LUN ID: 0 (automático, o especifica)

Apply
```

### 1.9 Verificación desde un Blade

**Enciende un blade y accede por consola (desde OA) o SSH:**

#### En Linux:

```bash
# Ver HBAs Fibre Channel detectados
ls /sys/class/fc_host/
# Salida esperada: host0  host1

# Ver información de los HBAs
cat /sys/class/fc_host/host0/port_name
cat /sys/class/fc_host/host1/port_name

# Escanear bus SCSI para detectar nuevos LUNs
echo "- - -" > /sys/class/scsi_host/host0/scan
echo "- - -" > /sys/class/scsi_host/host1/scan

# Listar discos detectados
lsblk
# Debes ver dispositivos nuevos como sdb, sdc, etc.

fdisk -l
# Muestra los LUNs del MSA como discos

# Verificar multipath (si está configurado)
multipath -ll
```

#### En Windows Server:

```powershell
# Abrir Disk Management
diskmgmt.msc

# O desde PowerShell:
Get-Disk
Get-PhysicalDisk

# Debes ver discos nuevos (offline) correspondientes a los LUNs del MSA
```

#### Instalar Multipathing (Recomendado):

**Linux:**
```bash
# Instalar device-mapper-multipath
yum install device-mapper-multipath  # RHEL/CentOS
apt install multipath-tools           # Debian/Ubuntu

# Configurar multipath
mpathconf --enable --with_multipathd y

# Editar /etc/multipath.conf
vi /etc/multipath.conf

# Agregar configuración para HP MSA:
devices {
    device {
        vendor "HP"
        product "MSA"
        path_grouping_policy group_by_prio
        path_selector "round-robin 0"
        failback immediate
        rr_weight priorities
        no_path_retry 18
    }
}

# Reiniciar servicio
systemctl restart multipathd

# Ver paths
multipath -ll
```

**Windows Server:**
```powershell
# Instalar MPIO
Install-WindowsFeature Multipath-IO

# Reiniciar servidor
Restart-Computer

# Configurar MPIO (GUI)
# Server Manager → Tools → MPIO
# Agregar soporte para "HP MSA" devices
```

---

## Parte 2: Conectar HP P2000G3 (9.6TB) al Servidor DL360p Gen8

### 2.1 Arquitectura Propuesta

El HP DL360p Gen8 será un **servidor standalone** con storage dedicado P2000G3.

**Opción A: Conexión Fibre Channel (recomendado para performance)**
**Opción B: Conexión iSCSI (más simple, sin necesidad de HBA FC)**

### 2.2 Opción A: Conexión por Fibre Channel

#### Materiales Necesarios:

- **HBA Fibre Channel** para el DL360p (si no tiene):
  - Tarjeta PCI-E FC 8Gb (ejemplo: HP LPe1205, QLogic QLE2562)
  - 2 cables FC LC-LC duplex, 8Gbps

#### Pasos:

**1. Instalar HBA FC en el DL360p:**
```
- Apagar el servidor
- Insertar la tarjeta HBA en un slot PCI-E libre
- Conectar los cables internos (si aplica)
- Encender servidor y verificar detección en BIOS/UEFI
```

**2. Conectar cables FC:**
```
Cable 1: DL360p HBA, Puerto 1 → P2000 Controller A, Host Port 1
Cable 2: DL360p HBA, Puerto 2 → P2000 Controller B, Host Port 1
```

**3. Configurar el P2000G3:**

```bash
# Acceder a la interfaz web del P2000
https://10.0.0.2  # Controller A (IP por defecto)

# Credenciales:
Usuario: manage
Contraseña: !manage

# Tareas:
1. Network Settings → Cambiar IPs de gestión a tu red
2. Configuration → Disks → Verificar 6 SATA 1TB + 6 SAS 600GB
3. Configuration → Disk Groups → Crear RAID Groups:
   - DG01_RAID5_SATA: 6 discos SATA 1TB, RAID 5 (~5TB usable)
   - DG02_RAID5_SAS: 6 discos SAS 600GB, RAID 5 (~3TB usable)
4. Configuration → Virtual Disks → Crear LUNs
5. Configuration → Host Groups → Crear grupo "DL360p"
   - Agregar WWN del HBA del DL360p
6. Map LUNs → Mapear LUNs al host group "DL360p"
```

**4. Verificar en DL360p:**

```bash
# Linux:
lsblk
fdisk -l

# Windows:
Get-Disk
```

### 2.3 Opción B: Conexión por iSCSI (Más Simple)

El P2000G3 soporta **FC/iSCSI**, así que podemos usar Ethernet estándar.

#### Materiales Necesarios:

- 2 cables Ethernet Cat6 (para redundancia)
- Switch Ethernet dedicado para storage (recomendado) o switch existente

#### Pasos:

**1. Configurar IPs en el P2000G3:**

```
Acceder a: https://10.0.0.2

Network Settings → iSCSI Configuration
  Controller A, iSCSI Port 1:
    IP: 192.168.100.10
    Netmask: 255.255.255.0
    
  Controller B, iSCSI Port 1:
    IP: 192.168.100.11
    Netmask: 255.255.255.0
```

**2. Conectar cables Ethernet:**

```
Cable 1: DL360p, NIC 3 → Switch Storage → P2000 Controller A, iSCSI Port 1
Cable 2: DL360p, NIC 4 → Switch Storage → P2000 Controller B, iSCSI Port 1
```

**3. Configurar NICs en el DL360p:**

**Linux:**
```bash
# Configurar IP en la NIC dedicada a iSCSI
ip addr add 192.168.100.20/24 dev eth2
ip addr add 192.168.100.21/24 dev eth3

# Instalar iSCSI initiator
yum install iscsi-initiator-utils  # RHEL/CentOS
apt install open-iscsi              # Debian/Ubuntu

# Descubrir targets iSCSI
iscsiadm -m discovery -t st -p 192.168.100.10
iscsiadm -m discovery -t st -p 192.168.100.11

# Conectar a los targets
iscsiadm -m node --login

# Ver sesiones iSCSI
iscsiadm -m session

# Ver discos
lsblk
```

**Windows Server:**
```powershell
# Configurar IPs en las NICs
New-NetIPAddress -InterfaceAlias "Ethernet 3" -IPAddress 192.168.100.20 -PrefixLength 24
New-NetIPAddress -InterfaceAlias "Ethernet 4" -IPAddress 192.168.100.21 -PrefixLength 24

# Abrir iSCSI Initiator
# Server Manager → Tools → iSCSI Initiator

# Discovery tab → Discover Portal
Target: 192.168.100.10
Port: 3260
Click OK

# Repetir para 192.168.100.11

# Targets tab → Seleccionar target → Connect
  ✓ Enable multi-path
  ✓ Add this connection to Favorite Targets
  
# Ver discos en Disk Management
diskmgmt.msc
```

**4. Crear y mapear LUNs en P2000 (igual que FC):**

```
Configuration → Virtual Disks → Create
Configuration → Host Groups → Create "DL360p_iSCSI"
  Agregar IQN del initiator del DL360p
  
Map LUNs al host group
```

---

## Parte 3: Configuración de Red de Gestión

### 3.1 Topología de Red Recomendada

```
┌─────────────────┐
│  Switch Core    │  Red institucional (192.168.1.0/24)
└────────┬────────┘
         │
    ┌────┴────┐
    │         │
┌───▼───┐  ┌──▼────────┐
│ OA #1 │  │ OA #2     │  (Onboard Administrators del c7000)
│ .10   │  │ .11       │
└───────┘  └───────────┘

┌──────────────────────────────────────┐
│  Switch Storage Management (aislado) │  (10.10.10.0/24)
└────┬──────┬──────┬──────┬────────────┘
     │      │      │      │
   ┌─▼──┐ ┌─▼──┐ ┌─▼──┐ ┌─▼──┐
   │MSA │ │P2K │ │OA1 │ │OA2 │
   │.10 │ │.20 │ │.30 │ │.31 │
   └────┘ └────┘ └────┘ └────┘
```

### 3.2 Configurar IPs de Gestión

#### Onboard Administrators:

```
Conectar cable Ethernet al puerto "Mgmt" de cada OA

Acceder por serial o IP por defecto (192.168.1.1)

OA CLI:
  SET ENCLOSURE IPADDRESS 10.10.10.30
  SET ENCLOSURE NETMASK 255.255.255.0
  SET ENCLOSURE GATEWAY 10.10.10.1
  
OA Web:
  https://10.10.10.30
  Network → IPv4 Settings
```

#### Storage MSA:

```
https://192.168.1.100 (acceso inicial)

Network Settings:
  Controller A: 10.10.10.10
  Controller B: 10.10.10.11
  Gateway: 10.10.10.1
```

#### Storage P2000:

```
https://10.0.0.2 (acceso inicial)

Network Settings:
  Controller A: 10.10.10.20
  Controller B: 10.10.10.21
  Gateway: 10.10.10.1
```

---

## Parte 4: Checklist de Puesta en Marcha

### ✅ Ya Completado (Sistema Pre-Configurado)

- [x] VMware ESXi 6.5 instalado en 8 blades Gen8
- [x] VMware ESXi 5.0/6.0 instalado en 6 blades antiguos
- [x] vCenter 6.5 instalado y accesible (192.168.42.20)
- [x] vCenter 5.5 instalado y accesible (192.168.42.30)
- [x] Red de gestión configurada (192.168.43.0/24)
- [x] Red de producción ESXi configurada (192.168.42.0/24)
- [x] Switches Ethernet operativos
- [x] Switches Brocade FC operativos
- [x] Storage P2000G3 conectado y accesible
- [x] Zoning FC básico configurado para P2000

### Verificación Inicial del Sistema Actual:

- [ ] Acceder al OA (https://192.168.43.11)
- [ ] Verificar que todos los blades necesarios están encendidos
- [ ] Acceder a vCenter 6.5 (https://192.168.42.20)
- [ ] Verificar conectividad de los 8 hosts ESXi 6.5
- [ ] Acceder al P2000 (http://10.0.0.3)
- [ ] Verificar estado de discos y controllers en P2000
- [ ] Revisar datastores existentes en vCenter
- [ ] Documentar VMs críticas en ejecución

### Pre-instalación del MSA (70TB):

- [ ] Verificar energía trifásica disponible
- [ ] Espacio en rack (MSA requiere 2-4U)
- [ ] Cables FC LC-LC 8Gb (mínimo 4, recomendado 8)
- [ ] Cables Ethernet Cat6 para gestión
- [ ] Confirmar que switches Brocade tienen puertos FC libres

### Instalación Física del MSA:

- [ ] Instalar storage MSA en rack (2-4U según modelo)
- [ ] Conectar fuentes de poder redundantes del MSA
- [ ] Conectar cable Ethernet de gestión al Controller A

### Configuración Storage MSA + vCenter:

- [ ] Encender storage MSA, esperar 3 minutos
- [ ] Acceder al MSA web (IP por defecto: 192.168.1.100)
- [ ] Cambiar IPs de gestión del MSA (sugerido: 10.0.0.10-11)
- [ ] Verificar que los 70 discos están detectados
- [ ] ⚠️ **APAGAR** todo antes de conectar cables FC
- [ ] Conectar cables FC: Brocade Switch 1 → MSA Controller A (2-4 cables)
- [ ] Conectar cables FC: Brocade Switch 2 → MSA Controller B (2-4 cables)
- [ ] Encender MSA nuevamente
- [ ] Crear Disk Groups en MSA (RAID 5 o RAID 6)
- [ ] Crear Virtual Disks (LUNs) en el MSA
- [ ] Acceder a Brocade switches desde OA
- [ ] Obtener WWNs del MSA desde su interfaz web
- [ ] Configurar zoning en Brocade para MSA
- [ ] Mapear LUNs a hosts en el MSA
- [ ] **Desde vCenter:** Rescan storage en cada host ESXi
- [ ] **Desde vCenter:** Crear datastores VMFS en los nuevos LUNs
- [ ] Verificar que todos los hosts ven los datastores del MSA
- [ ] Migrar VMs de prueba al nuevo storage MSA

### Post-configuración del Sistema Completo:

- [ ] Documentar todos los WWNs de HBAs (ya proporcionados arriba)
- [ ] Documentar configuración de zoning actualizada
- [ ] Documentar mapeo de LUNs (P2000 y MSA)
- [ ] Crear tabla de asignación de datastores por curso/laboratorio
- [ ] Configurar alertas SNMP en vCenter
- [ ] Configurar alertas en storage (P2000 y MSA)
- [ ] Probar failover de controladores de storage
- [ ] Probar vMotion entre hosts
- [ ] Documentar procedimientos de backup de VMs
- [ ] Crear plantillas de VM para laboratorios
- [ ] Documentar procedimiento de recovery ante desastres

### Opcional: Migración a Proxmox

Si decides migrar de VMware a Proxmox:

- [ ] Seleccionar blades para Proxmox (ej: bays 9-12)
- [ ] Backup de VMs en esos blades
- [ ] Descargar ISO de Proxmox VE 8.x
- [ ] Crear USB booteable o montar ISO vía iLO
- [ ] Instalar Proxmox en primer blade
- [ ] Configurar red de gestión y cluster
- [ ] Instalar Proxmox en blades restantes
- [ ] Unir blades al cluster Proxmox
- [ ] Configurar storage MSA en Proxmox (vía iSCSI o FC)
- [ ] Importar VMs desde VMware (convertir VMDK)
- [ ] Validar funcionalidad de VMs migradas

---

## Parte 5: Comandos de Diagnóstico

### Desde el Onboard Administrator (OA):

```bash
# Conectar por SSH
ssh Administrator@<IP-OA>

# Ver estado de blades
SHOW SERVER STATUS

# Ver estado de switches
SHOW INTERCONNECT STATUS

# Ver consumo eléctrico
SHOW POWER

# Ver temperaturas
SHOW THERMAL

# Encender blade
POWERON SERVER <bay_number>

# Apagar blade
POWEROFF SERVER <bay_number> FORCE
```

### Desde el Brocade FC Switch:

```bash
ssh admin@<IP-Brocade>

# Ver topología
switchshow

# Ver WWNs conectados
nsshow

# Ver zonas configuradas
cfgshow

# Ver aliases
alishow

# Ver estadísticas de puertos
portstatsshow
```

### Desde un Blade (Linux):

```bash
# Ver HBAs FC
ls /sys/class/fc_host/

# Ver WWN del HBA local
cat /sys/class/fc_host/host0/port_name

# Escanear nuevos LUNs
echo "- - -" > /sys/class/scsi_host/host0/scan

# Ver paths multipath
multipath -ll

# Ver discos
lsblk
fdisk -l

# Ver sesiones iSCSI (si aplica)
iscsiadm -m session
```

---

## Parte 6: Troubleshooting Común

### Problema: Los blades no ven los LUNs del storage

**Posibles causas:**
1. Cables FC no conectados correctamente
2. Zoning no configurado en Brocade
3. LUNs no mapeados en el storage
4. HBA FC del blade no detectado

**Diagnóstico:**
```bash
# En el Brocade:
switchshow  # ¿Ves los WWNs del storage y de los blades?

# En el blade (Linux):
ls /sys/class/fc_host/  # ¿Detecta el HBA?
dmesg | grep -i fc      # ¿Hay errores de FC?
```

### Problema: Performance bajo en acceso a storage

**Posibles causas:**
1. No está configurado multipathing
2. Cache write-back deshabilitado en storage
3. Usar RAID 5 en lugar de RAID 6 o RAID 10

**Solución:**
```bash
# Verificar multipath
multipath -ll  # Debes ver múltiples paths por LUN

# Verificar políticas de I/O en el storage (desde web UI)
# Habilitar write-back cache con mirroring
```

### Problema: No puedo acceder a la interfaz web del storage

**Posibles causas:**
1. IP incorrecta o red diferente
2. Firewall bloqueando puerto 443
3. Controlador en failover

**Diagnóstico:**
```bash
# Ping al storage
ping 10.10.10.10

# Ver si el puerto web está abierto
telnet 10.10.10.10 443

# Intentar con el otro controlador
https://10.10.10.11
```

---

## Recursos Adicionales

### Documentación HP:

- **BladeSystem c7000 User Guide:** [HP Support](https://support.hpe.com)
- **HP MSA Storage Management Guide:** Buscar por modelo específico
- **HP P2000 G3 Configuration Guide**
- **Brocade FC Switch Administration Guide**

### Herramientas Útiles:

- **HP Onboard Administrator CLI Reference**
- **HP Smart Storage Administrator (SSA)** - Para gestión de arrays locales
- **multipath-tools** (Linux) / **MPIO** (Windows) - Para redundancia de paths

### Videos y Tutoriales:

- YouTube: "HP BladeSystem c7000 Overview"
- YouTube: "Brocade FC Zoning Configuration"
- HP Learning Center: Cursos de HP Storage

---

## Contacto y Soporte

**Para soporte del proyecto:**
- Responsable: [Nombre]
- Email: [email]
- Ubicación del equipo: [Datacenter/Lab]

**Última actualización:** 20 de noviembre de 2025
