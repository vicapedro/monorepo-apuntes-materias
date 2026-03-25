# Práctica: Análisis de Mensajes del Protocolo OSPF con Wireshark

## 🎯 Objetivo

Capturar y analizar los diferentes tipos de mensajes del protocolo OSPF (Open Shortest Path First) utilizando Wireshark, comprendiendo el proceso de establecimiento de adyacencias, intercambio de información de estado de enlace y convergencia de la red.

**Duración estimada:** 2-3 horas

---

## 💡 Competencias a Desarrollar

- Configurar el protocolo de enrutamiento dinámico OSPF en routers Cisco
- Capturar tráfico de red utilizando puerto monitor (SPAN) en switches
- Analizar paquetes OSPF utilizando Wireshark
- Identificar y diferenciar los 5 tipos de mensajes OSPF
- Comprender el proceso de establecimiento de adyacencias OSPF
- Interpretar el intercambio de información de estado de enlace (LSA)
- Diagnosticar problemas de convergencia en redes OSPF

---

## 📚 Introducción Teórica

### **Protocolo OSPF**

OSPF (Open Shortest Path First) es un protocolo de enrutamiento dinámico de estado de enlace que utiliza el algoritmo de Dijkstra (SPF - Shortest Path First) para calcular la mejor ruta hacia cada destino. Opera dentro de sistemas autónomos y es ampliamente utilizado en redes empresariales.

### **Tipos de Mensajes OSPF**

OSPF utiliza 5 tipos de paquetes para establecer y mantener adyacencias, así como para intercambiar información de enrutamiento:

| **Tipo** | **Nombre** | **Función** | **Multicast** |
|----------|------------|-------------|---------------|
| **Tipo 1** | **Hello** | Descubrimiento de vecinos y mantenimiento de adyacencias | 224.0.0.5 |
| **Tipo 2** | **DBD** (Database Description) | Resumen de la base de datos de estado de enlace | Unicast |
| **Tipo 3** | **LSR** (Link State Request) | Solicitud de información específica de estado de enlace | Unicast |
| **Tipo 4** | **LSU** (Link State Update) | Envío de LSAs (actualizaciones de estado de enlace) | Unicast/Multicast |
| **Tipo 5** | **LSAck** (Link State Acknowledgment) | Confirmación de recepción de LSAs | Unicast/Multicast |

### **Proceso de Establecimiento de Adyacencia OSPF**

1. **Down**: Estado inicial, no se han enviado paquetes Hello
2. **Init**: Se ha recibido un Hello de un vecino, pero no se ha establecido comunicación bidireccional
3. **2-Way**: Comunicación bidireccional establecida, se elige DR/BDR si es necesario
4. **ExStart**: Se negocia la relación maestro/esclavo para intercambio de DBD
5. **Exchange**: Intercambio de paquetes DBD (Database Description)
6. **Loading**: Solicitud de LSAs faltantes mediante LSR y recepción de LSU
7. **Full**: Base de datos LSDB completamente sincronizada

### **Puerto Monitor (SPAN)**

El puerto monitor o SPAN (Switched Port Analyzer) permite replicar el tráfico de uno o varios puertos hacia un puerto de monitoreo, facilitando la captura de paquetes sin interrumpir el flujo de datos.

---

## 🔌 Topología de Red

```
                          ┌─────────────────┐
                          │   PC-Wireshark  │
                          │   192.168.1.10  │
                          │   Fa0: SPAN     │
                          └────────┬────────┘
                                   │
                                   │ Fa0/1 (SPAN Destination)
                          ┌────────▼────────┐
                          │    Switch-1     │
                          │   Fa0/2: SPAN   │
                          │   Fa0/3: SPAN   │
                          └─────────────────┘
                                   │
                    ┌──────────────┼──────────────┐
                    │                             │
               Fa0/1│                             │Fa0/1
            ┌───────▼───────┐             ┌──────▼────────┐
            │   Router-1    │             │   Router-2    │
            │  (R1)         │             │  (R2)         │
            ├───────────────┤             ├───────────────┤
            │ Fa0/0: Net-A  │             │ Fa0/0: Net-B  │
            └───────┬───────┘             └───────┬───────┘
                    │                             │
            192.168.10.0/24             192.168.20.0/24
```

### **Tabla de Direccionamiento**

| **Dispositivo** | **Interfaz** | **Dirección IP** | **Máscara** | **Gateway** |
|-----------------|--------------|------------------|-------------|-------------|
| Router-1 | Fa0/0 | 192.168.10.1 | 255.255.255.0 | N/A |
| Router-1 | Fa0/1 | 10.1.1.1 | 255.255.255.252 | N/A |
| Router-2 | Fa0/0 | 192.168.20.1 | 255.255.255.0 | N/A |
| Router-2 | Fa0/1 | 10.1.1.2 | 255.255.255.252 | N/A |
| PC-Wireshark | Fa0 | 192.168.1.10 | 255.255.255.0 | 192.168.1.1 |

---

## 🛠️ Material y Equipo Necesario

### **Hardware**
- 2 routers Cisco (2911, 2901 o similares con soporte OSPF)
- 1 switch Cisco con capacidad de puerto monitor (2960, 3560 o superior)
- 1 PC con Wireshark instalado
- 3 cables de consola (rollover)
- 5 cables Ethernet directos (straight-through)

### **Software**
- Wireshark (versión 3.0 o superior)
- Packet Tracer 8.x o GNS3 (alternativa de simulación)
- Tera Term o PuTTY (para acceso por consola)

### **Conocimientos Previos**
- Configuración básica de routers y switches Cisco
- Comandos IOS básicos
- Conceptos de enrutamiento dinámico
- Uso básico de Wireshark

---

## 📝 Instrucciones

### **Parte 1: Configuración Inicial de Dispositivos**

#### **Paso 1.1: Configurar Direcciones IP en los Routers**

**En Router-1:**
```cisco
Router> enable
Router# configure terminal
Router(config)# hostname R1
R1(config)# interface FastEthernet0/0
R1(config-if)# description Red LAN A
R1(config-if)# ip address 192.168.10.1 255.255.255.0
R1(config-if)# no shutdown
R1(config-if)# exit
R1(config)# interface FastEthernet0/1
R1(config-if)# description Enlace a R2
R1(config-if)# ip address 10.1.1.1 255.255.255.252
R1(config-if)# no shutdown
R1(config-if)# exit
R1(config)# exit
R1# write memory
```

**En Router-2:**
```cisco
Router> enable
Router# configure terminal
Router(config)# hostname R2
R2(config)# interface FastEthernet0/0
R2(config-if)# description Red LAN B
R2(config-if)# ip address 192.168.20.1 255.255.255.0
R2(config-if)# no shutdown
R2(config-if)# exit
R2(config)# interface FastEthernet0/1
R2(config-if)# description Enlace a R1
R2(config-if)# ip address 10.1.1.2 255.255.255.252
R2(config-if)# no shutdown
R2(config-if)# exit
R2(config)# exit
R2# write memory
```

#### **Paso 1.2: Verificar Conectividad Básica**

```cisco
R1# ping 10.1.1.2
Type escape sequence to abort.
Sending 5, 100-byte ICMP Echos to 10.1.1.2, timeout is 2 seconds:
!!!!!
Success rate is 100 percent (5/5), round-trip min/avg/max = 1/2/4 ms
```

📸 **Captura requerida:** Resultado del comando `ping` exitoso

#### **Paso 1.3: Configurar Puerto Monitor en el Switch**

```cisco
Switch> enable
Switch# configure terminal
Switch(config)# hostname SW1
SW1(config)# monitor session 1 source interface Fa0/2 - 3 both
SW1(config)# monitor session 1 destination interface Fa0/1
SW1(config)# exit
SW1# show monitor session 1
```

**Explicación:**
- `source interface Fa0/2 - 3 both`: Monitorea los puertos Fa0/2 y Fa0/3 (conectados a R1 y R2) en ambas direcciones
- `destination interface Fa0/1`: Puerto donde se conecta la PC con Wireshark
- `both`: Captura tráfico de entrada y salida

📸 **Captura requerida:** Salida del comando `show monitor session 1`

---

### **Parte 2: Captura de Tráfico OSPF Inicial**

#### **Paso 2.1: Iniciar Captura en Wireshark**

1. Conectar la PC al puerto Fa0/1 del switch (puerto SPAN)
2. Abrir Wireshark en la PC
3. Seleccionar la interfaz de red conectada al switch
4. Aplicar el filtro de captura: `ospf` o `ip.proto == 89`
5. Iniciar la captura (botón verde "Start")

📸 **Captura requerida:** Ventana de Wireshark con filtro aplicado

#### **Paso 2.2: Configurar OSPF en Router-1**

```cisco
R1# configure terminal
R1(config)# router ospf 1
R1(config-router)# router-id 1.1.1.1
R1(config-router)# network 10.1.1.0 0.0.0.3 area 0
R1(config-router)# network 192.168.10.0 0.0.0.255 area 0
R1(config-router)# exit
R1(config)# exit
```

**¿Qué observas en Wireshark?**
- Deberías ver paquetes **Hello** (Tipo 1) siendo enviados a 224.0.0.5 cada 10 segundos por defecto

📸 **Captura requerida:** Paquetes Hello de R1 en Wireshark

#### **Paso 2.3: Configurar OSPF en Router-2**

```cisco
R2# configure terminal
R2(config)# router ospf 1
R2(config-router)# router-id 2.2.2.2
R2(config-router)# network 10.1.1.0 0.0.0.3 area 0
R2(config-router)# network 192.168.20.0 0.0.0.255 area 0
R2(config-router)# exit
R2(config)# exit
```

**¿Qué observas ahora en Wireshark?**
Al activar OSPF en ambos routers, deberías observar la secuencia completa de mensajes:

1. **Hello (Tipo 1)**: Intercambio bidireccional
2. **DBD (Tipo 2)**: Intercambio de información de base de datos
3. **LSR (Tipo 3)**: Solicitudes de información específica
4. **LSU (Tipo 4)**: Actualizaciones de estado de enlace
5. **LSAck (Tipo 5)**: Confirmaciones

📸 **Captura requerida:** Secuencia completa de mensajes OSPF en Wireshark

---

### **Parte 3: Análisis Detallado de Mensajes OSPF**

#### **Paso 3.1: Analizar Paquetes Hello**

En Wireshark, seleccionar un paquete **Hello** y expandir la sección "Open Shortest Path First":

**Campos importantes a identificar:**
- **OSPF Version**: 2
- **Message Type**: Hello Packet (1)
- **Router ID**: Identificador único del router
- **Area ID**: 0.0.0.0 (backbone)
- **Network Mask**: Máscara de la interfaz
- **Hello Interval**: 10 segundos
- **Dead Interval**: 40 segundos
- **Designated Router (DR)**: 0.0.0.0 (no DR en enlaces punto a punto)
- **Backup Designated Router (BDR)**: 0.0.0.0
- **Active Neighbor**: Lista de vecinos conocidos

📋 **Tarea:** Completa la siguiente tabla con información de los paquetes Hello:

| **Campo** | **Valor R1** | **Valor R2** |
|-----------|--------------|--------------|
| Router ID | | |
| Area ID | | |
| Hello Interval | | |
| Dead Interval | | |
| Network Mask | | |
| Priority | | |

📸 **Captura requerida:** Detalles de un paquete Hello expandido en Wireshark

#### **Paso 3.2: Analizar Paquetes DBD (Database Description)**

**Características de los paquetes DBD:**
- Contienen resúmenes (headers) de LSAs, no la información completa
- Utilizan números de secuencia para garantizar orden
- Establecen relación maestro/esclavo entre routers

**En Wireshark, identificar:**
- **Message Type**: DB Description (2)
- **Interface MTU**: Tamaño máximo de paquete
- **Options**: Capacidades OSPF
- **DD Sequence**: Número de secuencia
- **LSA Headers**: Resúmenes de LSAs en la base de datos

📋 **Preguntas:**
1. ¿Cuál router actúa como maestro y cuál como esclavo?
2. ¿Cuántos LSA headers se intercambian en el primer paquete DBD?
3. ¿Qué flags están activos en los paquetes DBD? (I, M, MS)

📸 **Captura requerida:** Detalles de paquete DBD con LSA headers visibles

#### **Paso 3.3: Analizar Paquetes LSR (Link State Request)**

Si un router descubre que le falta información de algún LSA después del intercambio DBD, enviará un **LSR** solicitando esos LSAs específicos.

**En Wireshark, buscar:**
- **Message Type**: LS Request (3)
- **LS Type**: Tipo de LSA solicitado
- **Link State ID**: Identificador del LSA
- **Advertising Router**: Router que originó el LSA

📸 **Captura requerida:** Paquete LSR (si existe en la captura)

#### **Paso 3.4: Analizar Paquetes LSU (Link State Update)**

Los paquetes **LSU** contienen los LSAs completos con toda la información de estado de enlace.

**Tipos de LSA comunes:**
- **Type 1 (Router LSA)**: Describe los enlaces del router dentro del área
- **Type 2 (Network LSA)**: Describe la red generada por el DR
- **Type 3 (Summary LSA)**: Rutas entre áreas (ABR)
- **Type 5 (External LSA)**: Rutas externas al AS (ASBR)

**En Wireshark, expandir un paquete LSU:**
- **Message Type**: LS Update (4)
- **Number of LSAs**: Cantidad de LSAs en el paquete
- **LSA Information**: Detalles completos de cada LSA

📋 **Analizar un Type 1 Router LSA:**
- **Link State ID**: Router ID del originador
- **Advertising Router**: Mismo que Link State ID
- **LS Age**: Edad del LSA
- **LS Sequence Number**: Número de secuencia
- **Number of Links**: Enlaces descritos
- **Link Information**: Detalles de cada enlace

📸 **Captura requerida:** Paquete LSU expandido mostrando contenido de LSA Type 1

#### **Paso 3.5: Analizar Paquetes LSAck (Link State Acknowledgment)**

Los paquetes **LSAck** confirman la recepción de LSUs, garantizando entrega confiable.

**En Wireshark:**
- **Message Type**: LS Acknowledge (5)
- **LSA Headers**: Headers de los LSAs confirmados

📸 **Captura requerida:** Paquete LSAck

---

### **Parte 4: Verificación de Adyacencia OSPF**

#### **Paso 4.1: Verificar Vecinos OSPF**

```cisco
R1# show ip ospf neighbor

Neighbor ID     Pri   State           Dead Time   Address         Interface
2.2.2.2           0   FULL/  -        00:00:35    10.1.1.2        FastEthernet0/1
```

**Interpretación:**
- **Neighbor ID**: Router ID del vecino (2.2.2.2)
- **State**: **FULL** indica adyacencia completa
- **Dead Time**: Tiempo antes de declarar vecino muerto
- **Address**: Dirección IP del vecino
- **Interface**: Interfaz local de conexión

📸 **Captura requerida:** Salida de `show ip ospf neighbor` en ambos routers

#### **Paso 4.2: Verificar Base de Datos OSPF**

```cisco
R1# show ip ospf database

            OSPF Router with ID (1.1.1.1) (Process ID 1)

                Router Link States (Area 0)

Link ID         ADV Router      Age         Seq#       Checksum Link count
1.1.1.1         1.1.1.1         45          0x80000003 0x00B5A1 2
2.2.2.2         2.2.2.2         48          0x80000003 0x00A2C5 2
```

**Análisis:**
- Cada router tiene un Router LSA (Type 1)
- Link count indica número de enlaces descritos
- Age muestra antigüedad del LSA

📸 **Captura requerida:** Salida de `show ip ospf database` en ambos routers

#### **Paso 4.3: Verificar Tabla de Enrutamiento**

```cisco
R1# show ip route ospf
Codes: O - OSPF, IA - OSPF inter area

O    192.168.20.0/24 [110/2] via 10.1.1.2, 00:02:15, FastEthernet0/1
```

**Interpretación:**
- **O**: Ruta aprendida por OSPF
- **[110/2]**: Distancia administrativa 110, métrica 2
- **via 10.1.1.2**: Next-hop hacia la red destino

📸 **Captura requerida:** Salida de `show ip route ospf` en ambos routers

---

### **Parte 5: Agregar Nueva Red y Analizar Cambios**

#### **Paso 5.1: Preparar Wireshark para Nueva Captura**

1. Detener la captura actual en Wireshark
2. Guardar la captura como `OSPF_Initial.pcapng`
3. Aplicar filtro de visualización: `ospf`
4. Iniciar nueva captura para observar cambios

#### **Paso 5.2: Configurar Nueva Red en Router-1**

Simularemos una nueva red agregando una interfaz loopback:

```cisco
R1# configure terminal
R1(config)# interface loopback 0
R1(config-if)# description Red Nueva - Datacenter
R1(config-if)# ip address 172.16.1.1 255.255.255.0
R1(config-if)# exit
R1(config)# router ospf 1
R1(config-router)# network 172.16.1.0 0.0.0.255 area 0
R1(config-router)# exit
R1(config)# exit
```

#### **Paso 5.3: Observar Tráfico OSPF Generado**

**¿Qué ocurre en Wireshark al agregar la nueva red?**

Deberías observar:

1. **LSU (Type 4)** de R1 → R2:
   - Contiene un nuevo Router LSA (Type 1) actualizado
   - Incluye información sobre la nueva red 172.16.1.0/24
   - Número de secuencia incrementado

2. **LSAck (Type 5)** de R2 → R1:
   - Confirma recepción del LSU

3. **Hello Packets (Type 1)** continúan cada 10 segundos
   - Mantienen la adyacencia activa

📋 **Análisis:**
1. ¿Cuánto tiempo transcurrió desde agregar la red hasta que R2 la conoce?
2. ¿Cambió el número de enlaces (Link Count) en el Router LSA de R1?
3. ¿Observaste algún mensaje DBD después del cambio?

📸 **Capturas requeridas:**
- Paquete LSU con la nueva red en Wireshark
- Salida de `show ip ospf database` en R2 después del cambio
- Salida de `show ip route ospf` en R2 mostrando la nueva ruta

#### **Paso 5.4: Verificar Propagación de la Nueva Ruta**

**En Router-2:**
```cisco
R2# show ip route ospf
O    172.16.1.0/24 [110/2] via 10.1.1.1, 00:00:45, FastEthernet0/1
O    192.168.10.0/24 [110/2] via 10.1.1.1, 00:15:23, FastEthernet0/1
```

**Verificar conectividad:**
```cisco
R2# ping 172.16.1.1
Type escape sequence to abort.
Sending 5, 100-byte ICMP Echos to 172.16.1.1, timeout is 2 seconds:
!!!!!
Success rate is 100 percent (5/5), round-trip min/avg/max = 1/2/4 ms
```

📸 **Captura requerida:** Resultado del ping exitoso

---

### **Parte 6: Análisis de Temporizadores OSPF**

#### **Paso 6.1: Modificar Temporizadores Hello y Dead**

```cisco
R1# configure terminal
R1(config)# interface FastEthernet0/1
R1(config-if)# ip ospf hello-interval 5
R1(config-if)# ip ospf dead-interval 20
R1(config-if)# exit
R1(config)# exit
```

**¿Qué sucede con la adyacencia?**

```cisco
R1# show ip ospf neighbor
%OSPF-5-ADJCHG: Process 1, Nbr 2.2.2.2 on FastEthernet0/1 from FULL to DOWN, Neighbor Down: Dead timer expired
```

**Razón:** Los temporizadores no coinciden entre R1 y R2

#### **Paso 6.2: Ajustar Temporizadores en R2**

```cisco
R2# configure terminal
R2(config)# interface FastEthernet0/1
R2(config-if)# ip ospf hello-interval 5
R2(config-if)# ip ospf dead-interval 20
R2(config-if)# exit
R2(config)# exit
```

**Observar en Wireshark:**
- Nuevos paquetes Hello cada 5 segundos (en lugar de 10)
- Re-establecimiento de adyacencia (secuencia DBD, LSR, LSU, LSAck)

📸 **Captura requerida:** Paquetes Hello con nuevo intervalo de 5 segundos

---

## 📊 Análisis de Resultados

### **Tabla Resumen de Mensajes OSPF Capturados**

Completa la siguiente tabla con los mensajes observados:

| **Tipo** | **Nombre** | **Cantidad Observada** | **Dirección** | **Momento de Aparición** |
|----------|------------|------------------------|---------------|--------------------------|
| 1 | Hello | | Bidireccional | Durante toda la sesión |
| 2 | DBD | | Bidireccional | Establecimiento inicial |
| 3 | LSR | | Bidireccional | Si faltan LSAs |
| 4 | LSU | | Bidireccional | Actualizaciones de red |
| 5 | LSAck | | Bidireccional | Confirmación de LSUs |

### **Análisis de Convergencia**

📋 **Responde:**

1. **Tiempo de convergencia inicial**:
   - ¿Cuánto tiempo transcurrió desde configurar OSPF hasta que la adyacencia llegó a estado FULL?
   - ¿Cuántos paquetes Hello se intercambiaron antes del primer DBD?

2. **Tiempo de convergencia después del cambio**:
   - ¿Cuánto tiempo tardó R2 en conocer la nueva red 172.16.1.0/24?
   - ¿Fue más rápido que la convergencia inicial? ¿Por qué?

3. **Eficiencia del protocolo**:
   - ¿Cuántos bytes consume un paquete Hello típico?
   - ¿Cuántos bytes consume un paquete LSU con un Router LSA?
   - ¿Es eficiente el overhead del protocolo?

---

## 🔍 Preguntas de Reflexión

### **Conceptuales**

1. ¿Por qué OSPF utiliza el protocolo IP directamente (protocolo 89) en lugar de TCP o UDP?

2. ¿Cuál es la ventaja de usar direcciones multicast (224.0.0.5 y 224.0.0.6) para los paquetes Hello en lugar de unicast?

3. Explica la diferencia entre un paquete DBD y un paquete LSU. ¿Por qué OSPF no envía directamente los LSUs completos?

4. ¿Qué sucedería si no existieran los paquetes LSAck? ¿Cómo afectaría la confiabilidad de OSPF?

5. En una red con múltiples routers conectados a un mismo segmento Ethernet, ¿por qué es importante elegir un DR (Designated Router)?

### **Prácticas**

6. Si desconectaras físicamente el cable entre R1 y R2, ¿cuánto tiempo tardaría OSPF en detectar la falla con los temporizadores por defecto (Hello=10s, Dead=40s)?

7. ¿Qué ventajas tiene usar números de secuencia en los LSAs?

8. Describe el contenido de un Router LSA (Type 1). ¿Qué información contiene sobre cada enlace?

9. Si agregaras una tercera red en R2, ¿observarías el mismo comportamiento en Wireshark que cuando agregaste la red en R1?

10. ¿Qué implicaciones tiene modificar los temporizadores Hello y Dead en una red de producción?

---

## 📦 Entregables

### **Documento de Reporte (PDF)**

Tu reporte debe incluir las siguientes secciones:

#### **1. Portada**
- Nombre del estudiante
- Matrícula
- Fecha de realización
- Título de la práctica

#### **2. Objetivos de Aprendizaje**
- Breve descripción de los objetivos alcanzados

#### **3. Marco Teórico**
- Resumen de los 5 tipos de mensajes OSPF
- Descripción del proceso de establecimiento de adyacencia
- Explicación de LSAs y LSDB

#### **4. Desarrollo de la Práctica**
Para cada parte, incluir:
- Comandos utilizados
- Capturas de pantalla de Wireshark
- Capturas de pantalla de configuraciones en routers
- Observaciones y análisis

**Capturas mínimas requeridas (15 total):**
- [ ] Resultado de ping entre R1 y R2 (Paso 1.2)
- [ ] Configuración de puerto monitor (Paso 1.3)
- [ ] Wireshark con filtro OSPF aplicado (Paso 2.1)
- [ ] Paquetes Hello de R1 en Wireshark (Paso 2.2)
- [ ] Secuencia completa de mensajes OSPF inicial (Paso 2.3)
- [ ] Detalles de paquete Hello expandido (Paso 3.1)
- [ ] Detalles de paquete DBD con LSA headers (Paso 3.2)
- [ ] Paquete LSR si existe (Paso 3.3)
- [ ] Paquete LSU expandido con LSA Type 1 (Paso 3.4)
- [ ] Paquete LSAck (Paso 3.5)
- [ ] Salida de `show ip ospf neighbor` en ambos routers (Paso 4.1)
- [ ] Salida de `show ip ospf database` en ambos routers (Paso 4.2)
- [ ] Salida de `show ip route ospf` inicial en ambos routers (Paso 4.3)
- [ ] Paquete LSU con nueva red 172.16.1.0/24 (Paso 5.3)
- [ ] Paquetes Hello con intervalo modificado a 5 segundos (Paso 6.2)

#### **5. Análisis de Resultados**
- Tabla resumen de mensajes capturados
- Análisis de tiempos de convergencia
- Comparación de tamaños de paquetes
- Gráficas o diagramas de secuencia (opcional)

#### **6. Respuestas a Preguntas de Reflexión**
- Responder las 10 preguntas de manera clara y fundamentada

#### **7. Conclusiones**
- Aprendizajes obtenidos
- Dificultades encontradas y cómo se resolvieron
- Aplicaciones prácticas en redes reales

#### **8. Referencias Bibliográficas**
- RFC 2328 - OSPF Version 2
- Cisco CCNA/CCNP Documentation
- Otras fuentes consultadas

### **Archivos de Captura Wireshark**

- `OSPF_Initial.pcapng` - Captura del establecimiento inicial de OSPF
- `OSPF_NewNetwork.pcapng` - Captura al agregar la nueva red
- `OSPF_TimerChange.pcapng` - Captura con temporizadores modificados

### **Archivos de Configuración**

- `R1_config.txt` - Configuración completa de Router-1
- `R2_config.txt` - Configuración completa de Router-2
- `SW1_config.txt` - Configuración del switch con puerto monitor

---

## 📌 Criterios de Evaluación

| **Criterio** | **Excelente (100%)** | **Bueno (80%)** | **Aceptable (60%)** | **Insuficiente (<60%)** |
|--------------|----------------------|-----------------|---------------------|-------------------------|
| **Configuración OSPF** | Configura OSPF correctamente sin errores, optimiza parámetros | Configura OSPF con errores menores que no afectan funcionalidad | Configura OSPF con errores que requieren corrección | No logra establecer adyacencia OSPF |
| **Captura con Wireshark** | Captura todos los tipos de mensajes OSPF con filtros correctos | Captura mayoría de mensajes, faltan algunos detalles | Captura básica sin análisis profundo | Capturas incompletas o incorrectas |
| **Análisis de mensajes** | Identifica y explica detalladamente los 5 tipos de mensajes | Identifica tipos de mensajes con explicaciones básicas | Identifica tipos pero con comprensión limitada | No identifica tipos de mensajes correctamente |
| **Evidencias visuales** | Capturas claras, completas y relevantes de todos los pasos | Capturas adecuadas, algunas carecen de claridad | Capturas básicas, faltan evidencias importantes | Capturas insuficientes o ilegibles |
| **Documentación** | Reporte completo, bien estructurado con análisis crítico | Reporte adecuado con análisis básico | Reporte básico con documentación superficial | Reporte incompleto sin análisis |

**Ponderación:**
- Configuración técnica: 25%
- Captura y filtrado: 20%
- Análisis de mensajes: 30%
- Evidencias visuales: 15%
- Documentación y reflexión: 10%

---

## 🎓 Notas Adicionales

### **Troubleshooting Común**

**Problema:** No se establecen vecinos OSPF
- Verificar que las interfaces estén activas (`no shutdown`)
- Verificar que OSPF esté configurado en la red correcta
- Comprobar que los temporizadores coincidan
- Verificar que no haya ACLs bloqueando el tráfico

**Problema:** No se captura tráfico en Wireshark
- Verificar configuración del puerto monitor
- Comprobar que la PC esté conectada al puerto correcto
- Verificar que el filtro de captura sea correcto

**Problema:** Adyacencia cae constantemente
- Verificar temporizadores Hello y Dead
- Comprobar estabilidad de enlaces físicos
- Verificar compatibilidad de parámetros OSPF

### **Comandos Útiles de Verificación**

```cisco
show ip ospf interface         # Detalles de interfaces OSPF
show ip ospf interface brief   # Resumen de interfaces OSPF
show ip protocols              # Protocolos de enrutamiento activos
show ip ospf border-routers    # ABRs y ASBRs conocidos
debug ip ospf adj              # Debug de adyacencias (usar con precaución)
debug ip ospf events           # Debug de eventos OSPF
```

### **Recursos Adicionales**

- **RFC 2328**: Especificación oficial de OSPFv2
- **Cisco IOS Documentation**: Guías de configuración OSPF
- **Wireshark User Guide**: Análisis de protocolos de enrutamiento
- **GNS3 Academy**: Tutoriales de configuración OSPF avanzada

---

## 📚 Referencias

1. **Moy, J.** (1998). OSPF: Anatomy of an Internet Routing Protocol. Addison-Wesley.

2. **RFC 2328** - OSPF Version 2. IETF. Disponible en: https://www.ietf.org/rfc/rfc2328.txt

3. **Cisco Systems**. (2023). OSPF Configuration Guide. Cisco Press.

4. **Chappell, L.** (2017). Wireshark Network Analysis: The Official Wireshark Certified Network Analyst Study Guide. Protocol Analysis Institute.

5. **Doyle, J., & Carroll, J.** (2005). Routing TCP/IP, Volume I (2nd Edition). Cisco Press.

---

**¡Buena suerte con tu práctica de análisis de OSPF!** 🚀
