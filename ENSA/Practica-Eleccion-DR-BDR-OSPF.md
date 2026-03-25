# Práctica: Elección de DR/BDR en OSPF para Redes Multiacceso

## 🎯 Objetivo

Comprender y analizar el proceso de elección de roles DR (Designated Router) y BDR (Backup Designated Router) en redes OSPF multiacceso, manipulando los criterios de selección mediante modificación de prioridades, Router-ID y observando el comportamiento ante fallas del DR.

**Duración estimada:** 3-4 horas

---

## 💡 Competencias a Desarrollar

- Configurar el protocolo OSPF en topologías multiacceso
- Comprender el algoritmo de elección DR/BDR en OSPF
- Manipular los criterios de selección (Prioridad y Router-ID)
- Analizar el impacto del Router-ID en la elección de roles
- Modificar Router-ID mediante interfaces loopback y comandos explícitos
- Predecir y verificar el comportamiento ante falla del DR
- Capturar y analizar mensajes OSPF relacionados con la elección DR/BDR
- Diagnosticar problemas de adyacencia en redes multiacceso

---

## 📚 Introducción

### **¿Qué es una Red Multiacceso?**

Una red multiacceso es un segmento de red donde **múltiples dispositivos comparten el mismo medio de transmisión** (como Ethernet). En este tipo de redes, OSPF implementa un mecanismo de optimización mediante la elección de un **Designated Router (DR)** y un **Backup Designated Router (BDR)**.

### **¿Por qué se necesita un DR/BDR?**

**Problema sin DR/BDR:**
```
En una red con N routers, cada router necesitaría formar adyacencia 
con todos los demás: N × (N-1) / 2 adyacencias

Ejemplo: 4 routers = 6 adyacencias
         10 routers = 45 adyacencias ❌ Ineficiente
```

**Solución con DR/BDR:**
```
- Todos los routers forman adyacencia SOLO con DR y BDR
- DR intercambia información con todos y distribuye actualizaciones
- Reduce adyacencias de N×(N-1)/2 a 2×(N-1)

Ejemplo: 10 routers = 18 adyacencias ✅ Eficiente
```

### **Roles en Redes Multiacceso**

| **Rol** | **Función** | **Adyacencias** |
|---------|-------------|-----------------|
| **DR** (Designated Router) | Coordina el intercambio de LSAs en el segmento | FULL con todos |
| **BDR** (Backup DR) | Respaldo del DR, toma control si DR falla | FULL con todos |
| **DROTHER** | Routers que no son DR ni BDR | FULL solo con DR y BDR |

### **Algoritmo de Elección DR/BDR**

El proceso de elección sigue estos criterios **en orden de prioridad**:

#### **1️⃣ Prioridad de Interfaz (0-255)**
```cisco
Default = 1
Prioridad 0 = Nunca puede ser DR/BDR (DROTHER permanente)
Mayor prioridad = Mayor probabilidad de ser DR
```

#### **2️⃣ Router-ID (Desempate)**
```
Router-ID = Identificador único de 32 bits en formato IPv4

Selección automática del Router-ID (orden de preferencia):
1. Router-ID configurado manualmente (comando router-id)
2. Dirección IP más alta de interfaz loopback activa
3. Dirección IP más alta de interfaz física activa
```

#### **3️⃣ Reglas Especiales**
- ⚠️ **NO HAY PREEMPTION**: Un router con mayor prioridad/Router-ID que se une DESPUÉS no forzará nueva elección
- ✅ **Se elige BDR primero**, luego DR
- 🔄 **Solo se reelige cuando DR falla**

### **Estados de Adyacencia**

| **Estado** | **Descripción** |
|------------|-----------------|
| **2-Way** | Comunicación bidireccional (DROTHER ↔ DROTHER) ✅ Normal |
| **Full** | Sincronización completa de LSDB (DR/BDR con todos) |

### **Direcciones Multicast OSPF**

- **224.0.0.5 (AllSPFRouters)**: Todos los routers OSPF
- **224.0.0.6 (AllDRouters)**: Solo DR y BDR

---

## 🔌 Topología de Red

```
                         Red Multiacceso
                         10.1.1.0/24
                    ┌─────────────────┐
                    │    Switch-1     │
                    │  (192.168.1.0)  │
                    └─────────────────┘
                             │
         ┌───────────────────┼───────────────────┐
         │Fa0/1              │Fa0/1              │Fa0/1
         │.1                 │.2                 │.3
  ┌──────▼──────┐     ┌──────▼──────┐     ┌──────▼──────┐
  │  Router-1   │     │  Router-2   │     │  Router-3   │
  │   (R1)      │     │   (R2)      │     │   (R3)      │
  └──────┬──────┘     └──────┬──────┘     └──────┬──────┘
         │Fa0/0              │Fa0/0              │Fa0/0
         │.1                 │.1                 │.1
         │                   │                   │
  ┌──────▼──────┐     ┌──────▼──────┐     ┌─────▼──────┐
  │   LAN-A     │     │   LAN-B     │     │  Router-4  │
  │192.168.10.0 │     │192.168.20.0 │     │   (R4)     │
  └─────────────┘     └─────────────┘     └─────┬──────┘
                                                 │Fa0/1 .1
                                                 │
                                          ┌──────▼──────┐
                                          │   LAN-C     │
                                          │192.168.30.0 │
                                          └─────────────┘
```

### **Tabla de Direccionamiento**

| **Dispositivo** | **Interfaz** | **Dirección IP** | **Máscara** | **Gateway** |
|-----------------|--------------|------------------|-------------|-------------|
| **R1** | Fa0/0 | 192.168.10.1 | /24 | - |
| **R1** | Fa0/1 | 10.1.1.1 | /24 | - |
| **R2** | Fa0/0 | 192.168.20.1 | /24 | - |
| **R2** | Fa0/1 | 10.1.1.2 | /24 | - |
| **R3** | Fa0/1 | 10.1.1.3 | /24 | - |
| **R3** | Fa0/0 | 172.16.1.1 | /30 | - |
| **R4** | Fa0/0 | 172.16.1.2 | /30 | - |
| **R4** | Fa0/1 | 192.168.30.1 | /24 | - |
| **PC-A** | NIC | 192.168.10.10 | /24 | 192.168.10.1 |
| **PC-B** | NIC | 192.168.20.10 | /24 | 192.168.20.1 |
| **PC-C** | NIC | 192.168.30.10 | /24 | 192.168.30.1 |

---

## 🛡️ Equipo de Protección e Higiene

- Pulsera antiestática al manipular equipos de red
- Área de trabajo limpia y organizada
- Respaldo de configuraciones antes de modificaciones
- Documentación de cambios realizados

---

## 🛠️ Material y Equipo Necesario

### **Materiales e Insumos**
- 4 routers Cisco (2911, 2901 o similares con soporte OSPF)
- 1 switch Cisco (cualquier modelo)
- 3 PCs para simular LANs (opcional)
- 8 cables Ethernet directos (straight-through)
- 4 cables de consola (rollover)

### **Equipo de Laboratorio**
- Simulador: Packet Tracer 8.x o GNS3 (alternativa)
- Wireshark (para análisis avanzado - opcional)

### **Herramientas**
- Tera Term o PuTTY (acceso por consola)
- Bloc de notas para documentar resultados
- Calculadora para Router-ID

---

## 📝 Instrucciones

### **Parte 1: Configuración Inicial de la Topología (30 min)**

#### **Paso 1.1: Configurar Router-1 (R1)**

```cisco
Router> enable
Router# configure terminal
Router(config)# hostname R1
R1(config)# no ip domain-lookup
R1(config)# line console 0
R1(config-line)# logging synchronous
R1(config-line)# exit

! Configurar interfaz LAN-A
R1(config)# interface FastEthernet0/0
R1(config-if)# description LAN-A Usuarios
R1(config-if)# ip address 192.168.10.1 255.255.255.0
R1(config-if)# no shutdown
R1(config-if)# exit

! Configurar interfaz red multiacceso
R1(config)# interface FastEthernet0/1
R1(config-if)# description Red Multiacceso OSPF
R1(config-if)# ip address 10.1.1.1 255.255.255.0
R1(config-if)# no shutdown
R1(config-if)# exit
```

#### **Paso 1.2: Configurar Router-2 (R2)**

```cisco
Router> enable
Router# configure terminal
Router(config)# hostname R2
R2(config)# no ip domain-lookup
R2(config)# line console 0
R2(config-line)# logging synchronous
R2(config-line)# exit

! Configurar interfaz LAN-B
R2(config)# interface FastEthernet0/0
R2(config-if)# description LAN-B Servidores
R2(config-if)# ip address 192.168.20.1 255.255.255.0
R2(config-if)# no shutdown
R2(config-if)# exit

! Configurar interfaz red multiacceso
R2(config)# interface FastEthernet0/1
R2(config-if)# description Red Multiacceso OSPF
R2(config-if)# ip address 10.1.1.2 255.255.255.0
R2(config-if)# no shutdown
R2(config-if)# exit
```

#### **Paso 1.3: Configurar Router-3 (R3)**

```cisco
Router> enable
Router# configure terminal
Router(config)# hostname R3
R3(config)# no ip domain-lookup
R3(config)# line console 0
R3(config-line)# logging synchronous
R3(config-line)# exit

! Configurar interfaz red multiacceso
R3(config)# interface FastEthernet0/1
R3(config-if)# description Red Multiacceso OSPF
R3(config-if)# ip address 10.1.1.3 255.255.255.0
R3(config-if)# no shutdown
R3(config-if)# exit

! Configurar enlace a R4
R3(config)# interface FastEthernet0/0
R3(config-if)# description Enlace a R4
R3(config-if)# ip address 172.16.1.1 255.255.255.252
R3(config-if)# no shutdown
R3(config-if)# exit
```

#### **Paso 1.4: Configurar Router-4 (R4)**

```cisco
Router> enable
Router# configure terminal
Router(config)# hostname R4
R4(config)# no ip domain-lookup
R4(config)# line console 0
R4(config-line)# logging synchronous
R4(config-line)# exit

! Configurar enlace a R3
R4(config)# interface FastEthernet0/0
R4(config-if)# description Enlace a R3
R4(config-if)# ip address 172.16.1.2 255.255.255.252
R4(config-if)# no shutdown
R4(config-if)# exit

! Configurar interfaz LAN-C
R4(config)# interface FastEthernet0/1
R4(config-if)# description LAN-C Invitados
R4(config-if)# ip address 192.168.30.1 255.255.255.0
R4(config-if)# no shutdown
R4(config-if)# exit
```

#### **Paso 1.5: Verificar Conectividad Básica**

```cisco
! En R1
R1# ping 10.1.1.2
R1# ping 10.1.1.3

! En R3
R3# ping 172.16.1.2

! En R4
R4# ping 172.16.1.1
```

✅ **Punto de verificación**: Todos los pings deben ser exitosos antes de continuar.

---

### **Parte 2: Configuración OSPF Básica y Primera Elección DR/BDR (40 min)**

#### **Paso 2.1: Configurar OSPF en R1**

```cisco
R1(config)# router ospf 1
R1(config-router)# network 192.168.10.0 0.0.0.255 area 0
R1(config-router)# network 10.1.1.0 0.0.0.255 area 0
R1(config-router)# end
R1# write memory
```

#### **Paso 2.2: Configurar OSPF en R2**

```cisco
R2(config)# router ospf 1
R2(config-router)# network 192.168.20.0 0.0.0.255 area 0
R2(config-router)# network 10.1.1.0 0.0.0.255 area 0
R2(config-router)# end
R2# write memory
```

#### **Paso 2.3: Configurar OSPF en R3**

```cisco
R3(config)# router ospf 1
R3(config-router)# network 10.1.1.0 0.0.0.255 area 0
R3(config-router)# network 172.16.1.0 0.0.0.3 area 0
R3(config-router)# end
R3# write memory
```

#### **Paso 2.4: Configurar OSPF en R4**

```cisco
R4(config)# router ospf 1
R4(config-router)# network 172.16.1.0 0.0.0.3 area 0
R4(config-router)# network 192.168.30.0 0.0.0.255 area 0
R4(config-router)# end
R4# write memory
```

#### **Paso 2.5: Verificar Router-ID Automático**

**IMPORTANTE**: Antes de verificar roles, espere 40 segundos (Dead Timer) para que se complete la elección.

```cisco
! En R1
R1# show ip protocols
! Buscar la línea: "Router ID X.X.X.X"

! En R2
R2# show ip protocols

! En R3
R3# show ip protocols

! En R4
R4# show ip protocols
```

📋 **Tabla 1: Registre los Router-ID automáticos**

| Router | Router-ID Automático | IP Más Alta | Razón |
|--------|---------------------|-------------|-------|
| R1 | | | |
| R2 | | | |
| R3 | | | |
| R4 | | | |

💡 **Pregunta 1**: ¿Por qué R1 tiene el Router-ID que observaste? ¿Qué interfaz determinó ese valor?

---

#### **Paso 2.6: Verificar Roles DR/BDR en la Red Multiacceso**

```cisco
! En R1
R1# show ip ospf neighbor
R1# show ip ospf interface fastEthernet 0/1

! En R2
R2# show ip ospf neighbor
R2# show ip ospf interface fastEthernet 0/1

! En R3
R3# show ip ospf neighbor
R3# show ip ospf interface fastEthernet 0/1
```

📋 **Tabla 2: Registre los roles en la red multiacceso (10.1.1.0/24)**

| Router | Router-ID | Prioridad | Rol Asignado | Estado con Vecinos |
|--------|-----------|-----------|--------------|-------------------|
| R1 | | 1 (default) | | |
| R2 | | 1 (default) | | |
| R3 | | 1 (default) | | |

💡 **Preguntas de Análisis**:

**Pregunta 2**: ¿Qué router fue elegido como DR? ¿Por qué?

**Pregunta 3**: ¿Qué router fue elegido como BDR? ¿Por qué?

**Pregunta 4**: ¿Qué router quedó como DROTHER? ¿Cuál es la diferencia en sus adyacencias?

**Pregunta 5**: Observa el estado de las adyacencias:
- ¿En qué estado están las adyacencias entre DR y DROTHER?
- ¿En qué estado están las adyacencias entre BDR y DROTHER?
- ¿En qué estado están las adyacencias entre dos DROTHER? (si aplica)

#### **Paso 2.7: Análisis Detallado de la Red Multiacceso**

```cisco
! En el router que es DR, ejecutar:
R#(DR)# show ip ospf interface fastEthernet 0/1
```

Busca y registra:
- **Designated Router (ID)**: _______________
- **Designated Router Interface Address**: _______________
- **Backup Designated Router (ID)**: _______________
- **Backup Designated Router Interface Address**: _______________

---

### **Parte 3: Modificar Router-ID con Interface Loopback (30 min)**

#### **Objetivo**: Cambiar el Router-ID de R1 agregando una interfaz loopback con IP más alta.

#### **Paso 3.1: Agregar Loopback en R1**

```cisco
R1# configure terminal
R1(config)# interface loopback 0
R1(config-if)# description Loopback para Router-ID
R1(config-if)# ip address 200.1.1.1 255.255.255.255
R1(config-if)# end
```

#### **Paso 3.2: Verificar Router-ID Actual (No ha cambiado todavía)**

```cisco
R1# show ip protocols
```

💡 **Pregunta 6**: ¿Cambió el Router-ID de R1 inmediatamente después de crear el loopback?

#### **Paso 3.3: Reiniciar el Proceso OSPF**

```cisco
R1# clear ip ospf process
Reset ALL OSPF processes? [no]: yes
```

⏱️ **ESPERAR 40 segundos** para que se complete la reelección.

#### **Paso 3.4: Verificar Nuevo Router-ID**

```cisco
R1# show ip protocols
! Buscar: Router ID 200.1.1.1

R1# show ip ospf neighbor
R1# show ip ospf interface fastEthernet 0/1
```

📋 **Tabla 3: Registre los cambios después del reinicio OSPF en R1**

| Router | Router-ID Anterior | Router-ID Nuevo | Rol Anterior | Rol Nuevo |
|--------|-------------------|-----------------|--------------|-----------|
| R1 | | 200.1.1.1 | | |
| R2 | | | | |
| R3 | | | | |

💡 **Preguntas de Análisis**:

**Pregunta 7**: ¿Cambió el rol de R1 después de reiniciar el proceso OSPF?

**Pregunta 8**: ¿Qué router es ahora el DR? ¿Por qué?

**Pregunta 9**: ¿Se respetó la regla de "no preemption"? Explica.

**Pregunta 10**: Si R1 ahora tiene el Router-ID más alto (200.1.1.1), ¿por qué no es automáticamente el DR?

---

### **Parte 4: Forzar Nueva Elección Reiniciando Todos los Routers (20 min)**

#### **Objetivo**: Provocar una nueva elección limpia para ver el efecto del nuevo Router-ID de R1.

#### **Paso 4.1: Reiniciar OSPF en TODOS los Routers de la Red Multiacceso**

```cisco
! En R1
R1# clear ip ospf process
Reset ALL OSPF processes? [no]: yes

! En R2
R2# clear ip ospf process
Reset ALL OSPF processes? [no]: yes

! En R3
R3# clear ip ospf process
Reset ALL OSPF processes? [no]: yes
```

⏱️ **ESPERAR 40 segundos** para la convergencia completa.

#### **Paso 4.2: Verificar Nuevos Roles**

```cisco
! En cada router
R1# show ip ospf neighbor
R1# show ip ospf interface fastEthernet 0/1

R2# show ip ospf neighbor
R2# show ip ospf interface fastEthernet 0/1

R3# show ip ospf neighbor
R3# show ip ospf interface fastEthernet 0/1
```

📋 **Tabla 4: Registre los roles después de reinicio completo**

| Router | Router-ID | Prioridad | Rol Nuevo | Explicación |
|--------|-----------|-----------|-----------|-------------|
| R1 | 200.1.1.1 | 1 | | |
| R2 | | 1 | | |
| R3 | | 1 | | |

💡 **Preguntas de Análisis**:

**Pregunta 11**: ¿Qué router es ahora el DR? ¿Por qué?

**Pregunta 12**: ¿Cambió el orden de elección comparado con la Parte 2? Explica las diferencias.

**Pregunta 13**: ¿Qué ventaja tiene usar interfaces loopback para el Router-ID?

---

### **Parte 5: Modificar Router-ID con Comando Explícito (30 min)**

#### **Objetivo**: Cambiar el Router-ID de R2 usando el comando `router-id`.

#### **Paso 5.1: Configurar Router-ID Manualmente en R2**

```cisco
R2# configure terminal
R2(config)# router ospf 1
R2(config-router)# router-id 250.2.2.2
R2(config-router)# end
```

💡 **Observa el mensaje del sistema**: `Reload or use "clear ip ospf process" command, for this to take effect`

#### **Paso 5.2: Verificar que el Router-ID NO Cambió Todavía**

```cisco
R2# show ip protocols
! El Router-ID debe seguir siendo el anterior
```

#### **Paso 5.3: Reiniciar Proceso OSPF en R2**

```cisco
R2# clear ip ospf process
Reset ALL OSPF processes? [no]: yes
```

⏱️ **ESPERAR 40 segundos**.

#### **Paso 5.4: Verificar Nuevo Router-ID y Roles**

```cisco
R2# show ip protocols
! Buscar: Router ID 250.2.2.2

R2# show ip ospf neighbor
R2# show ip ospf interface fastEthernet 0/1

! Verificar también en R1 y R3
R1# show ip ospf neighbor
R3# show ip ospf neighbor
```

📋 **Tabla 5: Registre los roles después de cambiar Router-ID en R2**

| Router | Router-ID | Prioridad | Rol Anterior | Rol Actual | ¿Cambió? |
|--------|-----------|-----------|--------------|------------|----------|
| R1 | 200.1.1.1 | 1 | | | |
| R2 | 250.2.2.2 | 1 | | | |
| R3 | | 1 | | | |

💡 **Preguntas de Análisis**:

**Pregunta 14**: ¿Cambió el rol de R2 después de modificar su Router-ID?

**Pregunta 15**: ¿Por qué R2 con Router-ID 250.2.2.2 (el más alto) no se convirtió automáticamente en DR?

**Pregunta 16**: ¿Qué necesitarías hacer para que R2 se convierta en DR?

---

### **Parte 6: Forzar Elección con Router-ID Explícito (20 min)**

#### **Paso 6.1: Reiniciar OSPF en Todos los Routers Nuevamente**

```cisco
! En R1
R1# clear ip ospf process
Reset ALL OSPF processes? [no]: yes

! En R2
R2# clear ip ospf process
Reset ALL OSPF processes? [no]: yes

! En R3
R3# clear ip ospf process
Reset ALL OSPF processes? [no]: yes
```

⏱️ **ESPERAR 40 segundos**.

#### **Paso 6.2: Verificar Roles Finales**

```cisco
! En cada router
R1# show ip ospf neighbor
R2# show ip ospf neighbor
R3# show ip ospf neighbor

! Ver detalles en R2 (debería ser DR ahora)
R2# show ip ospf interface fastEthernet 0/1
```

📋 **Tabla 6: Roles finales con Router-IDs personalizados**

| Router | Router-ID | Prioridad | Rol Final | Orden de Elección |
|--------|-----------|-----------|-----------|-------------------|
| R1 | 200.1.1.1 | 1 | | |
| R2 | 250.2.2.2 | 1 | DR | ✅ Más alto |
| R3 | | 1 | | |

💡 **Pregunta 17**: ¿Qué router es DR ahora? ¿Coincide con tus predicciones?

**Pregunta 18**: ¿Cuál es el orden de prioridad para determinar el Router-ID?
1. _________________________
2. _________________________
3. _________________________

---

### **Parte 7: Simular Falla del DR y Predecir Comportamiento (40 min)**

#### **Objetivo**: Desactivar el DR actual y observar cómo el BDR asume el rol.

#### **Paso 7.1: Predicción ANTES de Desactivar**

📋 **Tabla 7: Haz tu predicción**

| Evento | Router Actual | Predicción: Nuevo Router | Justificación |
|--------|---------------|--------------------------|---------------|
| **DR falla** | R2 (250.2.2.2) | | |
| **Nuevo BDR** | | | |

💡 **Pregunta 19 (Predicción)**: Si desactivamos la interfaz Fa0/1 del DR (R2):
- ¿Qué router se convertirá en el nuevo DR?
- ¿Qué router se convertirá en el nuevo BDR?
- ¿Se realizará una nueva elección completa o simplemente habrá una promoción?

#### **Paso 7.2: Desactivar la Interfaz Multiacceso del DR**

```cisco
! En R2 (actual DR)
R2# configure terminal
R2(config)# interface fastEthernet 0/1
R2(config-if)# shutdown
R2(config-if)# end
```

⏱️ **ESPERAR 40 segundos** (Dead Timer) para que los vecinos detecten la falla.

#### **Paso 7.3: Observar Cambios en R1 y R3**

```cisco
! En R1
R1# show ip ospf neighbor
R1# show ip ospf interface fastEthernet 0/1

! En R3
R3# show ip ospf neighbor
R3# show ip ospf interface fastEthernet 0/1
```

📋 **Tabla 8: Registre los cambios después de falla del DR**

| Router | Router-ID | Rol Antes de Falla | Rol Después de Falla | Tiempo de Convergencia |
|--------|-----------|-------------------|---------------------|------------------------|
| R1 | 200.1.1.1 | | | |
| R2 | 250.2.2.2 | DR | DOWN | N/A |
| R3 | | | | ~40 segundos |

💡 **Preguntas de Análisis**:

**Pregunta 20**: ¿Qué router se convirtió en el nuevo DR?

**Pregunta 21**: ¿Qué router se convirtió en el nuevo BDR?

**Pregunta 22**: ¿Se realizó una nueva elección completa o el BDR simplemente fue promovido a DR?

**Pregunta 23**: ¿Cuánto tiempo tardó la red en converger después de la falla del DR?

#### **Paso 7.4: Reactivar R2 y Observar Comportamiento**

```cisco
! En R2
R2# configure terminal
R2(config)# interface fastEthernet 0/1
R2(config-if)# no shutdown
R2(config-if)# end
```

⏱️ **ESPERAR 40 segundos**.

```cisco
! Verificar en R2
R2# show ip ospf neighbor
R2# show ip ospf interface fastEthernet 0/1
```

📋 **Tabla 9: Roles después de recuperar R2**

| Router | Router-ID | Rol Después de Recuperación | ¿Recuperó su rol de DR? |
|--------|-----------|----------------------------|-------------------------|
| R1 | 200.1.1.1 | | |
| R2 | 250.2.2.2 | | |
| R3 | | | |

💡 **Preguntas de Análisis**:

**Pregunta 24**: Cuando R2 volvió en línea, ¿recuperó inmediatamente su rol de DR?

**Pregunta 25**: ¿Por qué crees que OSPF implementó la característica de "no preemption"?

**Pregunta 26**: ¿Qué ventajas y desventajas tiene este comportamiento?

---

### **Parte 8: Manipular Elección con Prioridades (AVANZADO - 30 min)**

#### **Objetivo**: Usar prioridades para controlar la elección DR/BDR de manera determinística.

#### **Paso 8.1: Configurar Prioridades Específicas**

```cisco
! En R3 - Forzarlo a ser siempre DROTHER
R3# configure terminal
R3(config)# interface fastEthernet 0/1
R3(config-if)# ip ospf priority 0
R3(config-if)# exit

! En R1 - Prioridad media-alta
R1(config)# interface fastEthernet 0/1
R1(config-if)# ip ospf priority 100
R1(config-if)# exit

! En R2 - Prioridad más alta
R2(config)# interface fastEthernet 0/1
R2(config-if)# ip ospf priority 200
R2(config-if)# end
```

#### **Paso 8.2: Reiniciar OSPF para Aplicar Cambios**

```cisco
R1# clear ip ospf process
R2# clear ip ospf process
R3# clear ip ospf process
```

⏱️ **ESPERAR 40 segundos**.

#### **Paso 8.3: Verificar Roles con Prioridades**

```cisco
R1# show ip ospf interface fastEthernet 0/1
R2# show ip ospf interface fastEthernet 0/1
R3# show ip ospf interface fastEthernet 0/1
```

📋 **Tabla 10: Roles con prioridades configuradas**

| Router | Router-ID | Prioridad | Rol Final | Explicación |
|--------|-----------|-----------|-----------|-------------|
| R1 | 200.1.1.1 | 100 | | |
| R2 | 250.2.2.2 | 200 | | |
| R3 | | 0 | DROTHER | Prioridad 0 = Nunca DR/BDR |

💡 **Preguntas de Análisis**:

**Pregunta 27**: ¿Qué router es DR ahora? ¿Por qué?

**Pregunta 28**: ¿Puede R3 convertirse en DR o BDR con prioridad 0?

**Pregunta 29**: ¿Cuál es el criterio de desempate cuando dos routers tienen la misma prioridad?

**Pregunta 30**: ¿En qué escenarios sería útil configurar prioridad 0 en un router?

---

### **Parte 9: Análisis de Estados de Adyacencia (20 min)**

#### **Paso 9.1: Examinar Estados Detallados**

```cisco
! En el router DR (R2)
R2# show ip ospf neighbor detail

! En un router DROTHER (R3)
R3# show ip ospf neighbor detail
```

📋 **Tabla 11: Estados de adyacencia según roles**

| Desde Router | Rol Local | Hacia Router | Rol Remoto | Estado | Explicación |
|--------------|-----------|--------------|------------|--------|-------------|
| R2 (DR) | DR | R1 | | FULL | |
| R2 (DR) | DR | R3 | DROTHER | FULL | |
| R1 | | R2 (DR) | DR | FULL | |
| R1 | | R3 | DROTHER | | |
| R3 (DROTHER) | DROTHER | R2 (DR) | DR | FULL | |
| R3 (DROTHER) | DROTHER | R1 | | | |

💡 **Pregunta 31**: ¿Por qué las adyacencias entre dos DROTHER están en estado 2-WAY y no FULL?

**Pregunta 32**: ¿Es esto un problema o comportamiento normal de OSPF?

#### **Paso 9.2: Ver Información Detallada de la Interfaz Multiacceso**

```cisco
! En cualquier router
R2# show ip ospf interface fastEthernet 0/1 | include Timer|Dead|Hello|Wait
```

Registra:
- **Timer intervals**: Hello _____ , Dead _____ , Wait _____ , Retransmit _____
- **Hello due in**: _______________

💡 **Pregunta 33**: ¿Cada cuánto tiempo se envían paquetes Hello en redes tipo broadcast?

**Pregunta 34**: ¿Cuál es el Dead Interval? ¿Qué sucede si no se reciben Hellos en ese tiempo?

---

### **Parte 10: Verificación de Tabla de Enrutamiento (15 min)**

#### **Paso 10.1: Verificar Rutas OSPF**

```cisco
! En cada router
R1# show ip route ospf
R2# show ip route ospf
R3# show ip route ospf
R4# show ip route ospf
```

📋 **Tabla 12: Verificar alcance de rutas**

| Desde Router | Puede alcanzar | Vía | Next-Hop | Métrica |
|--------------|----------------|-----|----------|---------|
| R1 | 192.168.20.0/24 | | | |
| R1 | 192.168.30.0/24 | | | |
| R4 | 192.168.10.0/24 | | | |
| R4 | 192.168.20.0/24 | | | |

#### **Paso 10.2: Pruebas de Conectividad End-to-End**

```cisco
! Desde R1
R1# ping 192.168.20.1
R1# ping 192.168.30.1

! Desde R4
R4# ping 192.168.10.1
R4# ping 192.168.20.1
```

✅ **Todas las pruebas deben ser exitosas**.

---

## 📊 Resultados Esperados

Al finalizar esta práctica, deberás haber observado:

### **Comportamientos Clave de OSPF DR/BDR**

1. ✅ **Elección basada en prioridad**: El router con mayor prioridad se convierte en DR
2. ✅ **Desempate por Router-ID**: Con prioridades iguales, gana el Router-ID más alto
3. ✅ **No preemption**: Un router con mayor prioridad/Router-ID que se une después NO fuerza nueva elección
4. ✅ **Promoción automática**: Cuando el DR falla, el BDR se promueve a DR inmediatamente
5. ✅ **Estados de adyacencia**: DR/BDR forman FULL con todos; DROTHER solo 2-WAY entre sí

### **Jerarquía de Selección de Router-ID**

```
1️⃣ Comando router-id (manual) ← MAYOR PRIORIDAD
2️⃣ IP más alta de loopback activa
3️⃣ IP más alta de interfaz física activa ← MENOR PRIORIDAD
```

### **Escenarios de Reelección**

| Evento | ¿Hay Reelección? | Resultado |
|--------|------------------|-----------|
| Router con mayor prioridad se une | ❌ NO | Mantiene DR/BDR actual |
| DR falla (shutdown/apagado) | ✅ SÍ (parcial) | BDR → DR, se elige nuevo BDR |
| Reinicio de proceso OSPF en todos | ✅ SÍ (completa) | Nueva elección desde cero |
| Cambio de prioridad en interfaz | ❌ NO (hasta reinicio) | Cambio aplica en próxima elección |

---

## 🔍 Actividades de Análisis

### **Cuestionario Final**

**1. Conceptos Fundamentales**

a) Explica con tus propias palabras por qué OSPF utiliza DR/BDR en redes multiacceso.

b) ¿Qué problemas se evitan con este mecanismo?

c) ¿En qué tipo de redes NO se necesita DR/BDR? (Pista: enlaces punto a punto)

**2. Comparación de Escenarios**

Completa la siguiente tabla comparativa:

| Escenario | ¿Se Reelige DR/BDR? | Tiempo Aproximado | Impacto en Tráfico |
|-----------|---------------------|-------------------|--------------------|
| Agregar router nuevo con RID más alto | | | |
| Shutdown interfaz del DR | | | |
| Cambiar prioridad sin reiniciar | | | |
| Clear ip ospf process en DR | | | |

**3. Troubleshooting**

Dado el siguiente escenario:
```
R1: Router-ID 10.1.1.1, Prioridad 1
R2: Router-ID 10.2.2.2, Prioridad 50
R3: Router-ID 10.3.3.3, Prioridad 0
R4: Router-ID 10.4.4.4, Prioridad 100
```

a) ¿Qué router será DR? _____________

b) ¿Qué router será BDR? _____________

c) ¿Qué routers serán DROTHER? _____________

d) Si R4 se apaga, ¿quién será el nuevo DR? _____________

e) Si después R4 vuelve, ¿recuperará el rol de DR inmediatamente? _____________

**4. Caso Práctico**

En una empresa tienes 8 routers conectados a un mismo switch (red 10.0.0.0/24). El router principal (core) debe ser siempre el DR. ¿Qué configurarías para garantizar esto?

---

## 📸 Evidencias a Entregar

### **Capturas de Pantalla Obligatorias**

1. ✅ **Tabla de direccionamiento**: Output de `show ip interface brief` en cada router
2. ✅ **Router-IDs iniciales**: Output de `show ip protocols` antes de modificaciones
3. ✅ **Primera elección DR/BDR**: Output de `show ip ospf neighbor` en los 3 routers de la red multiacceso
4. ✅ **Cambio con loopback**: Output de `show ip protocols` en R1 después de agregar loopback
5. ✅ **Roles después de loopback**: Output de `show ip ospf interface Fa0/1` en R1
6. ✅ **Cambio con router-id**: Output mostrando router-id 250.2.2.2 en R2
7. ✅ **Elección final con RIDs personalizados**: Output de `show ip ospf neighbor` mostrando R2 como DR
8. ✅ **Falla del DR**: Output de `show ip ospf neighbor` durante y después de shutdown de R2
9. ✅ **Configuración de prioridades**: Output de `show ip ospf interface Fa0/1` mostrando prioridades 0, 100 y 200
10. ✅ **Estados de adyacencia**: Output de `show ip ospf neighbor` desde un DROTHER mostrando estados 2-WAY y FULL

### **Documento Técnico**

Elabora un informe que incluya:

**Portada**
- Nombre de la práctica
- Tus datos (nombre, matrícula, grupo)
- Fecha de realización

**Introducción (1 párrafo)**
- Objetivo de la práctica

**Desarrollo**
- Todas las tablas completadas (Tablas 1-12)
- Respuestas a las 34 preguntas de análisis
- Capturas de pantalla con explicaciones breves

**Conclusiones (1-2 páginas)**
- Reflexión sobre el mecanismo DR/BDR
- Importancia en redes reales
- Diferencias entre usar Router-ID manual vs automático
- Ventajas de la característica "no preemption"
- Aplicaciones prácticas en entornos empresariales

**Referencias**
- Material consultado
- RFCs relacionados (RFC 2328 - OSPF Version 2)

---

## 📚 Notas Adicionales

### **Comandos de Verificación Útiles**

```cisco
! Ver resumen de OSPF
show ip ospf

! Ver solo vecinos en estado FULL
show ip ospf neighbor | include FULL

! Ver información detallada de la base de datos
show ip ospf database

! Ver estadísticas de interfaz
show ip ospf interface brief

! Ver timers configurados
show ip ospf interface fastEthernet 0/1 | include Timer

! Verificar prioridades
show ip ospf interface fastEthernet 0/1 | include Priority

! Debug (usar con precaución)
debug ip ospf events
debug ip ospf adj
! Para desactivar:
undebug all
```

### **Troubleshooting Común**

| Problema | Causa Probable | Solución |
|----------|----------------|----------|
| Vecinos en 2-WAY pero debería ser FULL | Roles DROTHER normales | Verificar si son DR/BDR o DROTHER |
| No se forma adyacencia | Hello/Dead timer mismatch | Verificar `show ip ospf interface` |
| DR incorrecto después de cambios | No se reinició proceso OSPF | `clear ip ospf process` |
| Router-ID no cambia | Proceso OSPF no reiniciado | Reiniciar o recargar router |

### **Recomendaciones para Redes Reales**

1. ⚡ **Siempre usar Router-ID manual** en producción para evitar cambios inesperados
2. 🔧 **Configurar prioridades** en routers críticos (core = alta, edge = baja)
3. 💾 **Usar interfaces loopback** para Router-ID (nunca caen)
4. ⏰ **Ajustar timers** si es necesario: `ip ospf hello-interval` y `ip ospf dead-interval`
5. 📊 **Monitorear cambios de DR/BDR** con syslog para detectar problemas de red

### **Diferencias por Tipo de Red OSPF**

| Tipo de Red | DR/BDR | Ejemplo |
|-------------|--------|---------|
| **Broadcast** | ✅ SÍ | Ethernet, FastEthernet |
| **Non-Broadcast** | ✅ SÍ | Frame Relay, X.25 |
| **Point-to-Point** | ❌ NO | Serial, PPP, HDLC |
| **Point-to-Multipoint** | ❌ NO | Frame Relay point-to-multipoint |

### **Impacto del DR/BDR en Escalabilidad**

```
Ejemplo: Red con 20 routers en el mismo segmento

SIN DR/BDR:
- Adyacencias: 20 × 19 / 2 = 190 adyacencias
- LSAs flooding: Cada router envía a 19 vecinos
- Complejidad: O(n²)

CON DR/BDR:
- Adyacencias FULL: 2 × 19 = 38 adyacencias
- LSAs flooding: Solo DR/BDR procesan y distribuyen
- Complejidad: O(n)

Reducción: ~80% menos adyacencias ✅
```

---

## ✅ Criterios de Evaluación

### **Rúbrica de Evaluación**

| Criterio | Excelente (3) | Bueno (2) | Aceptable (1) | Insuficiente (0) |
|----------|---------------|-----------|---------------|------------------|
| **Configuración OSPF** | Configuración completa y funcional en 4 routers | Configuración funcional con errores menores | Configuración parcial | Sin configuración correcta |
| **Comprensión DR/BDR** | Identifica y explica correctamente roles en todos los escenarios | Identifica roles con explicaciones básicas | Identifica algunos roles | No identifica roles correctamente |
| **Manipulación Router-ID** | Implementa exitosamente loopback y comando router-id | Implementa una de las dos técnicas | Intenta implementar pero con errores | No logra cambiar Router-ID |
| **Análisis de falla DR** | Predice y verifica correctamente comportamiento ante falla | Predice o verifica correctamente | Observa cambios sin predicción | No completa esta sección |
| **Uso de prioridades** | Configura prioridades y entiende su impacto | Configura prioridades básicas | Intenta configurar prioridades | No usa prioridades |
| **Evidencias** | 10 capturas claras y bien documentadas | 7-9 capturas adecuadas | 4-6 capturas | Menos de 4 capturas |
| **Respuestas a preguntas** | Responde 30+ preguntas con análisis profundo | Responde 20-29 preguntas correctamente | Responde 10-19 preguntas | Menos de 10 respuestas |
| **Documento técnico** | Informe profesional completo con conclusiones sólidas | Informe adecuado con conclusiones básicas | Informe incompleto | Sin informe o muy deficiente |

**Puntuación total**: _____ / 24 puntos

---

## 🎓 Referencias y Material Complementario

### **Documentación Oficial**

1. **RFC 2328** - OSPF Version 2 (Especificación completa)
   - Sección 9: The Interface Data Structure (Prioridades y DR/BDR)
   - Sección 9.1: Interface states
   - Sección 9.2: Events causing interface state changes

2. **Cisco CCNA Routing and Switching**
   - Capítulo: OSPF Configuration
   - Sección: DR/BDR election process

### **Videos Recomendados**

- "OSPF DR and BDR Election Process Explained" - Cisco Learning Network
- "OSPF Multi-Access Networks" - Keith Barker (CBT Nuggets)

### **Simuladores Online**

- **Cisco Packet Tracer** - Descarga gratuita con Cisco Networking Academy
- **GNS3** - Simulador avanzado con IOS reales
- **EVE-NG** - Plataforma de emulación de redes

### **Comandos Quick Reference**

```cisco
! Configuración básica OSPF
router ospf [process-id]
network [ip] [wildcard] area [area-id]

! Router-ID manual
router-id [A.B.C.D]

! Prioridad de interfaz
interface [type] [number]
ip ospf priority [0-255]

! Modificar timers (opcional)
ip ospf hello-interval [segundos]
ip ospf dead-interval [segundos]

! Verificación
show ip protocols
show ip ospf neighbor
show ip ospf interface [type] [number]
show ip ospf database

! Reiniciar proceso
clear ip ospf process
```

---

## 📝 Lista de Verificación Final

Antes de entregar tu práctica, verifica:

- [ ] Configuración OSPF funcional en los 4 routers
- [ ] Conectividad end-to-end verificada (pings exitosos)
- [ ] Identificaste correctamente DR, BDR y DROTHER en cada escenario
- [ ] Cambiaste Router-ID usando loopback
- [ ] Cambiaste Router-ID usando comando explícito
- [ ] Simulaste falla de DR y documentaste resultados
- [ ] Configuraste prioridades (0, 100, 200)
- [ ] Respondiste las 34 preguntas de análisis
- [ ] Capturaste las 10 evidencias requeridas
- [ ] Elaboraste documento técnico con conclusiones
- [ ] Guardaste configuraciones: `write memory` en todos los routers

---

**Fecha de entrega**: _______________

**Calificación obtenida**: _____ / 100

**Retroalimentación del instructor**:

---

## 🔄 Extensiones Opcionales (Para Estudiantes Avanzados)

### **Extensión 1: Captura con Wireshark**

Si tienes acceso a Wireshark:
1. Configura port mirroring en el switch (puerto SPAN)
2. Captura tráfico durante la elección DR/BDR
3. Identifica paquetes OSPF Hello con información de DR/BDR
4. Analiza cambios en los mensajes durante reinicio de proceso

### **Extensión 2: Múltiples Áreas OSPF**

Expande la topología:
- Configura R4 en Area 1
- Convierte R3 en ABR (Area Border Router)
- Observa si hay elección DR/BDR en el enlace punto a punto R3-R4

### **Extensión 3: Automatización con Python**

Crea un script Python usando Netmiko que:
- Se conecte a los 3 routers
- Ejecute `show ip ospf neighbor`
- Identifique automáticamente quién es DR/BDR
- Genere un reporte en HTML

---

**Elaborado por**: [Nombre del Instructor]  
**Institución**: Tecnológico Nacional de México  
**Versión**: 1.0  
**Fecha**: Marzo 2026

