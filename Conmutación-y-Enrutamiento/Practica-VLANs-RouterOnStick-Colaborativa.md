# Práctica: Configuración de VLANs y Enrutamiento Inter-VLAN - Fusión Empresarial

## Objetivo

Configurar y administrar múltiples VLANs en un entorno colaborativo de laboratorio, implementando enrutamiento inter-VLAN mediante Router-on-a-Stick, y estableciendo comunicación entre redes independientes mediante enrutamiento estático para simular la integración de redes en una fusión empresarial.

**Duración estimada:** 4 horas

## Competencias a desarrollar

- Configura VLANs en switches Cisco para segmentación lógica de redes
- Asigna puertos de acceso a VLANs específicas y configura enlaces troncales (trunk)
- Implementa enrutamiento inter-VLAN mediante Router-on-a-Stick con subinterfaces
- Configura enrutamiento estático para interconexión de redes autónomas
- Verifica conectividad de capa 2 y capa 3 mediante herramientas de diagnóstico
- Trabaja colaborativamente en equipos compartiendo recursos de red
- Documenta y troubleshooting configuraciones de VLAN y enrutamiento

## Introducción

### Escenario: Fusión de dos empresas

**TechCorp** y **DataNet** son dos empresas de tecnología que han decidido fusionarse. Cada empresa tiene su propia infraestructura de red que debe integrarse progresivamente. En esta práctica, simularemos este proceso de integración en tres fases:

**Fase 1 - Redes Aisladas:** Cada empresa opera de forma independiente con sus propias VLANs
**Fase 2 - Enrutamiento Interno:** Cada empresa habilita comunicación entre sus VLANs internas
**Fase 3 - Integración:** Las dos empresas conectan sus redes para compartir recursos

### Organización del trabajo en equipo

Cada rack de laboratorio representa el entorno completo de la fusión:
- **Alumno 1** representa a **TechCorp** (VLANs 33 y 34)
- **Alumno 2** representa a **DataNet** (VLANs 65 y 66)

**Recursos por alumno:**
- 1 Router
- 1 Switch
- 2 PCs

**Trabajo colaborativo:**
- Ambos alumnos deben coordinarse para las pruebas de conectividad
- Compartirán información de direccionamiento IP
- Colaborarán en la integración final de las redes

### Conceptos clave

**VLAN (Virtual LAN):**
- Segmentación lógica de una red física en múltiples dominios de broadcast
- Los dispositivos en la misma VLAN pueden comunicarse directamente (capa 2)
- Los dispositivos en diferentes VLANs requieren un router (capa 3)

**Puerto de Acceso (Access Port):**
- Conecta dispositivos finales (PCs, impresoras, servidores)
- Pertenece a una sola VLAN
- No etiqueta tramas (untagged)

**Puerto Troncal (Trunk Port):**
- Conecta switches entre sí o switches con routers
- Transporta tráfico de múltiples VLANs
- Etiqueta tramas con 802.1Q (tagged)

**Enrutamiento Inter-VLAN:**

1. **Router-on-a-Stick:**
   - Una sola interfaz física del router conectada al switch
   - Múltiples subinterfaces lógicas (una por VLAN)
   - Enlace troncal entre switch y router
   - Eficiente en uso de puertos
   - Puede ser cuello de botella en alto tráfico

### Plan de direccionamiento IP

**TechCorp (Alumno 1):**
| VLAN | Nombre | Red | Gateway | Rango Hosts |
|------|--------|-----|---------|-------------|
| 33 | Ventas-Tech | 192.168.33.0/24 | .1 | .10 - .254 |
| 34 | TI-Tech | 192.168.34.0/24 | .1 | .10 - .254 |

**DataNet (Alumno 2):**
| VLAN | Nombre | Red | Gateway | Rango Hosts |
|------|--------|-----|---------|-------------|
| 65 | Produccion-Data | 192.168.65.0/24 | .1 | .10 - .254 |
| 66 | Admin-Data | 192.168.66.0/24 | .1 | .10 - .254 |

**Enlace entre empresas (WAN):**
| Segmento | Router | IP |
|----------|--------|-----|
| Interconexión | R-TechCorp | 10.0.0.1/30 |
| Interconexión | R-DataNet | 10.0.0.2/30 |

## Equipo de protección e higiene

No aplica para esta práctica de laboratorio de redes.

## Material y equipo necesario

### Materiales e insumos (por rack/equipo)
- 2 Routers Cisco (modelos 1841, 2811, 2901, 2911 o superiores)
- 2 Switches Cisco con capacidad de VLANs (modelos 2950, 2960 o superiores)
- 4 PCs (pueden ser virtuales o físicas)
- Cables de red: 6 straight-through, 2 crossover (o usar puertos auto-MDIX)
- Cables de consola para acceso a routers y switches

### Software
- Cisco Packet Tracer 8.0+ (simulación) O
- Equipos físicos en laboratorio de redes
- Terminal de consola (PuTTY, Tera Term, o Packet Tracer)

### Herramientas
- Libreta para documentar configuraciones
- Calculadora para verificar subredes
- Esquema de topología impreso

## Instrucciones

### Parte 1: Preparación y Organización del Equipo

**1.1 Identificación de roles**

El instructor asignará los roles:
- **Alumno 1 (TechCorp):** VLANs 33 y 34, Router-on-a-Stick
- **Alumno 2 (DataNet):** VLANs 65 y 66, Router-on-a-Stick 

**1.2 Inventario de equipo**

Cada alumno debe identificar sus dispositivos:

**Alumno 1 (TechCorp):**
- Router: R-TechCorp
- Switch: SW-TechCorp
- PCs: PC-Ventas1, PC-TI1

**Alumno 2 (DataNet):**
- Router: R-DataNet
- Switch: SW-DataNet
- PCs: PC-Prod1, PC-Admin1

**1.3 Dibujar topología inicial**

Cada alumno debe dibujar su parte de la topología:

```
ALUMNO 1 - TechCorp                    ALUMNO 2 - DataNet

[PC-Ventas1] VLAN 33                   [PC-Prod1] VLAN 65
     |                                       |
[PC-TI1] VLAN 34                       [PC-Admin1] VLAN 66
     |                                       |
  [SW-TechCorp]                          [SW-DataNet]
     | Trunk                                | Trunk
  [R-TechCorp]                           [R-DataNet]
  Gi0/0 (Router-on-Stick)                Gi0/0 (VLAN 65)
                                         Gi0/1 (VLAN 66)
```

**1.4** Capturar foto o escanear el diagrama de topología dibujado por ambos alumnos.

### Parte 2: Cableado Físico de la Red

**2.1 Conexiones del Alumno 1 (TechCorp)**

| Dispositivo Origen | Puerto | Dispositivo Destino | Puerto | Tipo Cable |
|-------------------|--------|---------------------|--------|------------|
| PC-Ventas1 | NIC | SW-TechCorp | Fa0/1 | Straight-Through |
| PC-TI1 | NIC | SW-TechCorp | Fa0/20 | Straight-Through |
| SW-TechCorp | Fa0/24 | R-TechCorp | Gi0/0 | Straight-Through |

**2.2 Conexiones del Alumno 2 (DataNet)**

| Dispositivo Origen | Puerto | Dispositivo Destino | Puerto | Tipo Cable |
|-------------------|--------|---------------------|--------|------------|
| PC-Prod1 | NIC | SW-DataNet | Fa0/1 | Straight-Through |
| PC-Admin1 | NIC | SW-DataNet | Fa0/20 | Straight-Through |
| SW-DataNet | Fa0/24 | R-DataNet | Gi0/0 | Straight-Through |

**Nota:** La interconexión entre routers se realizará en la Fase 3.

**2.3** Verificar que todos los cables estén correctamente conectados.

**2.4** Capturar foto de la topología física cableada.

### FASE 1: CONFIGURACIÓN DE VLANs (SIN ENRUTAMIENTO)

**Objetivo:** Configurar VLANs en los switches y verificar conectividad de capa 2 entre dispositivos de la misma VLAN.

### Parte 3: Configuración del Switch - Alumno 1 (TechCorp)

**3.1 Configuración básica del switch**

```
Switch>enable
Switch#configure terminal
Switch(config)#hostname SW-TechCorp
SW-TechCorp(config)#no ip domain-lookup

! Banner de identificación
SW-TechCorp(config)#banner motd #
*************************************************
*        TechCorp - Switch Principal            *
*    Acceso no autorizado esta prohibido        *
*************************************************
#
```

**3.2 Crear VLANs**

```
! Crear VLAN 33 - Ventas



! Crear VLAN 34 - TI


```

**3.3 Asignar puertos a VLANs (modo acceso)**

```
! Puertos para VLAN 33

! Puertos para PC-TI1 VLAN 34

```

**3.4 Configurar puerto troncal hacia el router**

```



```

**3.5 Verificar configuración de VLANs**

```
SW-TechCorp#show vlan brief
SW-TechCorp#show interfaces trunk
SW-TechCorp#show running-config
```

**3.6** Capturar pantalla de los comandos `show vlan brief` y `show interfaces trunk`.


### Parte 4: Configuración del Switch - Alumno 2 (DataNet)

**4.1 Configuración básica del switch**

```
Switch>enable
Switch#configure terminal
Switch(config)#hostname SW-DataNet
SW-DataNet(config)#no ip domain-lookup
SW-DataNet(config)# !enable secret cisco123

! Banner de identificación
SW-DataNet(config)#banner motd #
*************************************************
*         DataNet - Switch Principal            *
*    Acceso no autorizado esta prohibido        *
*************************************************
#
```

**4.2 Crear VLANs**

```
! Crear VLAN 65 - Producción





! Crear VLAN 66 - Administración




```

**4.3 Asignar puertos a VLANs (modo acceso)**

```
! Puertos para VLAN 65



! Puertos para VLAN 66



```

**4.4 Configurar puerto troncal hacia el router**

```



```


**4.5 Verificar configuración de VLANs**

```
SW-DataNet#show vlan brief
SW-DataNet#show interfaces trunk
SW-DataNet#show interfaces fastEthernet 0/24 switchport
```

**4.6** Capturar pantalla de los comandos de verificación.



### Parte 5: Configuración de PCs para Pruebas de VLAN (SIN ROUTER AÚN)

**IMPORTANTE:** En esta fase NO configuraremos los routers. Queremos verificar que las VLANs funcionan correctamente a nivel de capa 2.

**5.1 Configuración de PCs - Alumno 1 (TechCorp)**

**PC-Ventas1 (en VLAN 33):**
- IP Address: 192.168.33.10
- Subnet Mask: 255.255.255.0
- Default Gateway: 192.168.33.1 (configurarlo aunque el router no esté activo aún)

**PC-TI1 (en VLAN 34):**
- IP Address: 192.168.34.10
- Subnet Mask: 255.255.255.0
- Default Gateway: 192.168.34.1

**5.2 Configuración de PCs - Alumno 2 (DataNet)**

**PC-Prod1 (en VLAN 65):**
- IP Address: 192.168.65.10
- Subnet Mask: 255.255.255.0
- Default Gateway: 192.168.65.1

**PC-Admin1 (en VLAN 66):**
- IP Address: 192.168.66.10
- Subnet Mask: 255.255.255.0
- Default Gateway: 192.168.66.1

**5.3** Capturar pantalla de la configuración IP de cada PC.

**Pregunta 1 (ambos alumnos):** ¿Por qué es importante que las PCs en la misma VLAN tengan direcciones IP en la misma subred? ¿Qué pasaría si una PC en VLAN 33 tuviera una IP de la red 192.168.34.0/24?

### Parte 6: Pruebas de Conectividad de Capa 2 (Misma VLAN)

**6.1 Preparación para pruebas colaborativas**

Para probar conectividad dentro de la misma VLAN, necesitamos otro dispositivo en esa VLAN. Los alumnos deben coordinarse para reconfigurar temporalmente una PC.

**Estrategia de prueba para Alumno 1:**

**Paso 1:** Cambiar temporalmente PC-TI1 a VLAN 33

Cambiar IP de PC-TI1 temporalmente:
- IP: 192.168.33.20
- Mask: 255.255.255.0
- Gateway: 192.168.33.1

Desde PC-Ventas1, hacer ping:
```
C:\> ping 192.168.33.20
```

**Paso 2:** Regresar PC-TI1 a VLAN 34 y restaurar su IP original

Restaurar IP de PC-TI1:
- IP: 192.168.34.10
- Mask: 255.255.255.0
- Gateway: 192.168.34.1

**Paso 3:** Cambiar temporalmente PC-Ventas1 a VLAN 34

Cambiar IP de PC-Ventas1 temporalmente:
- IP: 192.168.34.20
- Mask: 255.255.255.0
- Gateway: 192.168.34.1

Desde PC-TI1, hacer ping:
```
C:\> ping 192.168.34.20
```

**Paso 4:** Regresar PC-Ventas1 a VLAN 33 y restaurar configuración original

**6.2 Pruebas para Alumno 2 (DataNet)**

Repetir el mismo proceso que el Alumno 1, pero con VLANs 65 y 66.

**6.3** Capturar pantalla de los pings exitosos dentro de cada VLAN.

**Pregunta 2 (ambos alumnos):** ¿Por qué es necesario cambiar la IP de la PC cuando la movemos de una VLAN a otra, aunque esté en el mismo switch?

**6.4 Prueba de aislamiento entre VLANs (sin router)**

Restaurar configuración original de todos los dispositivos.

Desde PC-Ventas1, intentar ping a PC-TI1:
```
C:\> ping 192.168.34.10
```

Desde PC-Prod1, intentar ping a PC-Admin1:
```
C:\> ping 192.168.66.10
```

**Pregunta 3 (ambos alumnos):** ¿Funciona el ping entre VLANs diferentes sin tener configurado el router? ¿Por qué?

**6.5** Capturar pantalla de los pings fallidos entre VLANs.

### FASE 2: ENRUTAMIENTO INTER-VLAN

**Objetivo:** Configurar los routers para permitir comunicación entre VLANs diferentes dentro de cada empresa.

### Parte 7: Router-on-a-Stick - Alumno 1 (TechCorp)

**7.1 Configuración básica del router**

```
Router>enable
Router#configure terminal
Router(config)#hostname R-TechCorp
R-TechCorp(config)#no ip domain-lookup
R-TechCorp(config)# !enable secret cisco123

! Banner
R-TechCorp(config)#banner motd #
*************************************************
*         TechCorp - Router Principal           *
*    Acceso no autorizado esta prohibido        *
*************************************************
#
```

**7.2 Configuración de Router-on-a-Stick**

```
! Habilitar la interfaz física principal



! Subinterfaz para VLAN 33 - Ventas





! Subinterfaz para VLAN 34 - TI




```

**7.3 Verificar configuración del router**

```
R-TechCorp#show ip interface brief
R-TechCorp#show running-config interface gigabitEthernet 0/0
R-TechCorp#show vlans
```

**7.4** Capturar pantalla de los comandos de verificación.

**Pregunta 4 (ambos alumnos):** ¿Cuántos cables físicos conectan el router al switch? ¿Cuántas "interfaces lógicas" (subinterfaces) tiene configuradas el router?

### Parte 8: Router-on-a-Stick - Alumno 2 (DataNet)

**8.1 Configuración básica del router**

```
Router>enable
Router#configure terminal
Router(config)#hostname R-DataNet
R-DataNet(config)#no ip domain-lookup
R-DataNet(config)# !enable secret cisco123

! Banner
R-DataNet(config)#banner motd #
*************************************************
*          DataNet - Router Principal           *
*    Acceso no autorizado esta prohibido        *
*************************************************
#
```

**8.2 Configuración de Router-on-a-Stick**

```
! Habilitar la interfaz física principal



! Subinterfaz para VLAN 65 - Producción






! Subinterfaz para VLAN 66 - Administración





```

**8.3 Verificar configuración del router**

```
R-DataNet#show ip interface brief
R-DataNet#show running-config interface gigabitEthernet 0/0
R-DataNet#show vlans
```

**8.4** Capturar pantalla de los comandos de verificación.

**Pregunta 5 (Alumno 2):** Compare su configuración con la del Alumno 1. ¿Son idénticas las subinterfaces excepto por los números de VLAN y las direcciones IP? ¿Qué importancia tiene esta consistencia en la configuración?

### Parte 9: Pruebas de Conectividad Inter-VLAN (Dentro de cada empresa)

**9.1 Pruebas para TechCorp (Alumno 1)**

Desde PC-Ventas1 (VLAN 33):
```
C:\> ping 192.168.33.1      (Gateway - debe funcionar)
C:\> ping 192.168.34.1      (Gateway de otra VLAN - debe funcionar)
C:\> ping 192.168.34.10     (PC-TI1 en VLAN 34 - debe funcionar)
```

Desde PC-TI1 (VLAN 34):
```
C:\> ping 192.168.34.1      (Gateway - debe funcionar)
C:\> ping 192.168.33.1      (Gateway de otra VLAN - debe funcionar)
C:\> ping 192.168.33.10     (PC-Ventas1 en VLAN 33 - debe funcionar)
```

**9.2 Pruebas para DataNet (Alumno 2)**

Desde PC-Prod1 (VLAN 65):
```
C:\> ping 192.168.65.1      (Gateway - debe funcionar)
C:\> ping 192.168.66.1      (Gateway de otra VLAN - debe funcionar)
C:\> ping 192.168.66.10     (PC-Admin1 en VLAN 66 - debe funcionar)
```

Desde PC-Admin1 (VLAN 66):
```
C:\> ping 192.168.66.1      (Gateway - debe funcionar)
C:\> ping 192.168.65.1      (Gateway de otra VLAN - debe funcionar)
C:\> ping 192.168.65.10     (PC-Prod1 en VLAN 65 - debe funcionar)
```

**9.3** Capturar pantalla de los pings exitosos entre VLANs dentro de cada empresa.

**Pregunta 6 (ambos alumnos):** Describa el proceso que sigue un paquete ICMP cuando va de VLAN 33 a VLAN 34 usando Router-on-a-Stick. ¿Qué rol juegan las etiquetas 802.1Q en este proceso?

**9.4 Verificar tablas de enrutamiento**

En R-TechCorp:
```
R-TechCorp#show ip route
```

En R-DataNet:
```
R-DataNet#show ip route
```

**Pregunta 7 (ambos alumnos):** ¿Qué tipo de rutas aparecen en la tabla de enrutamiento de su router? ¿Qué significa la letra "C" en la tabla?

### FASE 3: FUSIÓN EMPRESARIAL - INTEGRACIÓN DE REDES (Opcional por limitaciones del laboratorio)

**Objetivo:** Conectar las redes de TechCorp y DataNet mediante enrutamiento estático para permitir comunicación completa.

### Parte 10: Interconexión de los Routers (WAN Link)

**10.1 Cableado de la interconexión**

Conectar físicamente ambos routers:

| Dispositivo | Interfaz | Dispositivo | Interfaz | Cable |
|-------------|----------|-------------|----------|-------|
| R-TechCorp | Serial0/0/0 o Gi0/1 | R-DataNet | Serial0/0/0 o Gi0/2 | Crossover o serial DCE |

**Nota:** Si usan interfaces seriales, uno de los routers debe configurarse como DCE con clock rate.

**10.2** Capturar foto del cable de interconexión entre routers.

### Parte 11: Configuración del Enlace WAN - Alumno 1 (TechCorp)

**11.1 Configuración de la interfaz WAN**

```




```

**11.2** Verificar la interfaz:
```
R-TechCorp#show ip interface brief
```

### Parte 12: Configuración del Enlace WAN - Alumno 2 (DataNet)

**12.1 Configuración de la interfaz WAN**

```






```


**12.2** Verificar la interfaz:
```
R-DataNet#show ip interface brief
```

**12.3 Prueba de conectividad entre routers**

Desde R-TechCorp:
```
R-TechCorp#ping 10.0.0.2
```

Desde R-DataNet:
```
R-DataNet#ping 10.0.0.1
```

**12.4** Capturar pantalla de los pings exitosos entre routers.

**Pregunta 8 (ambos alumnos):** ¿Por qué usamos una red /30 (255.255.255.252) para el enlace entre routers?

### Parte 13: Configuración de Enrutamiento Estático - Alumno 1 (TechCorp)

**13.1 Análisis de rutas necesarias**

R-TechCorp necesita conocer las redes de DataNet:
- 192.168.65.0/24 (Producción)
- 192.168.66.0/24 (Administración)

**13.2 Configuración de rutas estáticas**

```




```



**13.3 Verificar tabla de enrutamiento**

```
R-TechCorp#show ip route
```

Buscar las rutas estáticas (marcadas con "S"):
```
S    192.168.65.0/24 [1/0] via 10.0.0.2
S    192.168.66.0/24 [1/0] via 10.0.0.2
```

**13.4** Capturar pantalla de la tabla de enrutamiento con las rutas estáticas.

### Parte 14: Configuración de Enrutamiento Estático - Alumno 2 (DataNet)

**14.1 Análisis de rutas necesarias**

R-DataNet necesita conocer las redes de TechCorp:
- 192.168.33.0/24 (Ventas)
- 192.168.34.0/24 (TI)

**14.2 Configuración de rutas estáticas**

```






```

**14.3 Verificar tabla de enrutamiento**

```
R-DataNet#show ip route
```

**14.4** Capturar pantalla de la tabla de enrutamiento con las rutas estáticas.

**Pregunta 9 (ambos alumnos):** ¿Qué significa [1/0] en las rutas estáticas? ¿Qué representan estos dos números?

### Parte 15: Pruebas de Conectividad Completa (Post-Fusión)

**15.1 Pruebas desde TechCorp hacia DataNet**

Desde PC-Ventas1 (TechCorp VLAN 33):
```
C:\> ping 192.168.65.10     (PC-Prod1 en DataNet)
C:\> ping 192.168.66.10     (PC-Admin1 en DataNet)
C:\> tracert 192.168.65.10
```

Desde PC-TI1 (TechCorp VLAN 34):
```
C:\> ping 192.168.65.10     (PC-Prod1 en DataNet)
C:\> ping 192.168.66.10     (PC-Admin1 en DataNet)
C:\> tracert 192.168.66.10
```

**15.2 Pruebas desde DataNet hacia TechCorp**

Desde PC-Prod1 (DataNet VLAN 65):
```
C:\> ping 192.168.33.10     (PC-Ventas1 en TechCorp)
C:\> ping 192.168.34.10     (PC-TI1 en TechCorp)
C:\> tracert 192.168.33.10
```

Desde PC-Admin1 (DataNet VLAN 66):
```
C:\> ping 192.168.33.10     (PC-Ventas1 en TechCorp)
C:\> ping 192.168.34.10     (PC-TI1 en TechCorp)
C:\> tracert 192.168.34.10
```

**15.3** Capturar pantalla de los pings y traceroutes exitosos entre empresas.

**Pregunta 10 (ambos alumnos):** ¿Cuántos saltos (hops) muestra el traceroute desde PC-Ventas1 hasta PC-Prod1? Liste las IPs de cada salto.

**15.4 Matriz de conectividad completa**

Complete la siguiente tabla verificando todas las conexiones (✅ exitoso, ❌ fallido):

| Origen | Destino | Mismo Switch | Misma VLAN | Mismo Router | Resultado |
|--------|---------|--------------|------------|--------------|-----------|
| PC-Ventas1 (.33.10) | PC-TI1 (.34.10) | ✅ | ❌ | ✅ | |
| PC-Ventas1 (.33.10) | PC-Prod1 (.65.10) | ❌ | ❌ | ❌ | |
| PC-Ventas1 (.33.10) | PC-Admin1 (.66.10) | ❌ | ❌ | ❌ | |
| PC-TI1 (.34.10) | PC-Prod1 (.65.10) | ❌ | ❌ | ❌ | |
| PC-TI1 (.34.10) | PC-Admin1 (.66.10) | ❌ | ❌ | ❌ | |
| PC-Prod1 (.65.10) | PC-Admin1 (.66.10) | ✅ | ❌ | ✅ | |



### Parte 16: Documentación Final y Conclusiones

**17.1 Diagrama de topología completo**

Ambos alumnos deben crear un diagrama final que incluya:
- Todos los dispositivos
- VLANs con sus números y nombres
- Todas las direcciones IP
- Tipo de puertos (access/trunk)
- Rutas estáticas configuradas
- Método de enrutamiento inter-VLAN (Router-on-a-Stick)

**17.2 Tabla de direccionamiento completa**

| Dispositivo | Interfaz | VLAN | Dirección IP | Descripción |
|-------------|----------|------|--------------|-------------|
| R-TechCorp | Gi0/0.33 | 33 | 192.168.33.1/24 | Gateway Ventas |
| R-TechCorp | Gi0/0.34 | 34 | 192.168.34.1/24 | Gateway TI |
| R-TechCorp | Serial0/0/0 | - | 10.0.0.1/30 | WAN Link |
| PC-Ventas1 | NIC | 33 | 192.168.33.10/24 | Host Ventas |
| ... | ... | ... | ... | ... |

**17.3 Configuraciones finales**

Exportar las configuraciones de todos los dispositivos:
```
Router#show running-config
Switch#show running-config
```

**17.4** Capturar o copiar las configuraciones completas de todos los dispositivos.

**Pregunta 13 (colaborativa):** ¿Qué ventajas tiene dividir una red en VLANs en lugar de usar switches separados físicamente?

**Pregunta 14 (colaborativa):** En un escenario real de fusión empresarial, ¿qué otros aspectos de red deberían considerarse además de la conectividad física?

**Pregunta 15 (colaborativa):** ¿Qué ventajas y desventajas tiene el método Router-on-a-Stick comparado con switches multicapa (Layer 3)?

## Notas

### Consideraciones importantes:

**Sobre VLANs:**
- Las VLANs segmentan dominios de broadcast
- Cada VLAN es una subred IP diferente
- Los puertos de acceso solo transportan tráfico de una VLAN
- Los puertos trunk transportan tráfico de múltiples VLANs etiquetadas con 802.1Q
- La VLAN 1 es la VLAN nativa por defecto (no etiquetada en trunk)

**Sobre enrutamiento inter-VLAN:**
- **Router-on-a-Stick:**
  - Ventajas: Ahorra puertos, escalable, una sola conexión física, fácil de configurar
  - Desventajas: Posible cuello de botella si hay alto tráfico inter-VLAN, todo el tráfico por una interfaz
  - Ideal para: Redes pequeñas/medianas, configuraciones con múltiples VLANs
  - Requiere: Enlace trunk 802.1Q, configuración de subinterfaces en router

- **Alternativa moderna: Switch multicapa (Layer 3 Switch):**
  - El switch mismo realiza el routing entre VLANs (no cubierto en esta práctica)
  - Mayor rendimiento que Router-on-a-Stick
  - Elimina necesidad de router externo para inter-VLAN routing

**Sobre enrutamiento estático:**
- Debe configurarse manualmente en cada router
- No se adapta automáticamente a cambios de topología
- Apropiado para redes pequeñas y estables
- Para redes grandes: usar protocolos dinámicos (OSPF, EIGRP)

**Trabajo colaborativo:**
- Comunicación constante entre ambos alumnos es esencial
- Coordinar cambios antes de implementarlos
- Verificar conectividad después de cada cambio importante
- Compartir resultados de pruebas

### Mejores prácticas:

**Numeración de VLANs:**
1. Usar números descriptivos cuando sea posible
2. Documentar el propósito de cada VLAN
3. Evitar VLAN 1 para hosts (usarla solo para gestión)
4. Mantener consistencia en toda la red

**Configuración de switches:**
5. Siempre usar `switchport mode access` explícitamente en puertos de host
6. Especificar VLANs permitidas en trunks
7. Deshabilitar puertos no usados
8. Configurar port-security en puertos de acceso

**Configuración de routers:**
9. Usar nombres descriptivos en subinterfaces
10. Documentar con `description` en cada interfaz
11. Hacer backup de configuraciones antes de cambios importantes
12. Usar `do show` dentro del modo de configuración para verificar sin salir

**Documentación:**
13. Mantener diagramas actualizados
14. Documentar todos los cambios
15. Crear tabla de direccionamiento IP
16. Registrar decisiones de diseño

### Comandos de verificación rápida:

**Switches:**
```
show vlan brief                    # Ver VLANs configuradas
show interfaces trunk              # Ver enlaces troncales
show interfaces [int] switchport   # Ver configuración de puerto específico
show mac address-table             # Ver tabla MAC
show spanning-tree                 # Ver estado STP
```

**Routers:**
```
show ip interface brief            # Resumen de interfaces
show ip route                      # Tabla de enrutamiento
show running-config                # Configuración activa
show interfaces [int]              # Detalles de interfaz específica
show vlans                         # VLANs conocidas (router-on-stick)
```

**PCs:**
```
ipconfig                           # Ver configuración IP (Windows)
ipconfig /all                      # Configuración detallada
ping [ip]                          # Probar conectividad
tracert [ip]                       # Trazar ruta (Windows)
arp -a                             # Ver tabla ARP
```

### Errores comunes y troubleshooting:

**Problema: No hay comunicación dentro de una VLAN**
- Verificar que el puerto esté en la VLAN correcta: `show vlan brief`
- Verificar que el puerto esté en modo access: `show interfaces switchport`
- Verificar que las PCs tengan IPs en la misma subred
- Verificar que el puerto no esté shutdown

**Problema: No hay comunicación entre VLANs**
- Verificar que el trunk esté configurado correctamente
- Verificar que las VLANs estén permitidas en el trunk
- Verificar que el router tenga las subinterfaces/interfaces configuradas
- Verificar que los gateways en las PCs sean correctos
- Verificar tabla de enrutamiento del router

**Problema: No hay comunicación entre routers**
- Verificar conectividad física (cable, puertos)
- Verificar que las interfaces estén up/up
- Verificar que las IPs estén en la misma subred
- Probar ping entre routers primero

**Problema: No hay comunicación entre empresas**
- Verificar rutas estáticas en ambos routers
- Verificar que las rutas apunten al next-hop correcto
- Usar `traceroute` para ver dónde falla la ruta
- Verificar tabla de enrutamiento: `show ip route`

### Entrega de la práctica:

**Formato de entrega:** Reporte en PDF individual por alumno con las siguientes secciones:

1. **Portada** con datos del alumno y su compañero de equipo
2. **Introducción** al escenario de fusión empresarial
3. **Desarrollo:**
   - Diagramas de topología (inicial, por fases, y final)
   - Capturas de pantalla de cada configuración (mínimo 20)
   - Tablas de direccionamiento completas
   - Resultados de todas las pruebas de conectividad
4. **Respuestas a las 15 preguntas** planteadas
5. **Matriz de conectividad** completa
6. **Troubleshooting:** Documentación de escenarios de falla
7. **Configuraciones finales** de router y switch
8. **Reflexión personal:**
   - Qué aprendió en cada fase
   - Desafíos encontrados y cómo los resolvió
   - Importancia del trabajo en equipo
10. **Conclusiones** sobre VLANs y enrutamiento
11. **Referencias** bibliográficas

**Puntos clave a incluir:**
- Evidencia fotográfica del cableado físico
- Configuración completa de VLANs en switches
- Configuración detallada de Router-on-a-Stick (subinterfaces, encapsulación 802.1Q)
- Configuración de rutas estáticas para interconexión empresarial
- Pruebas de conectividad completa (incluyendo traceroute)
- Análisis del funcionamiento de trunking y etiquetas VLAN
- Trabajo colaborativo documentado

### Referencias:

**Documentación Cisco:**
- Cisco. (2023). *Configuring VLANs*. Cisco IOS LAN Switching Configuration Guide.
- Cisco. (2023). *Configuring 802.1Q Trunking*. Cisco Documentation.
- Cisco. (2023). *Configuring Inter-VLAN Routing*. Cisco IOS IP Routing Configuration Guide.
- Cisco. (2023). *Configuring Static Routes*. Cisco IOS IP Routing Configuration Guide.

**Estándares:**
- IEEE 802.1Q: *Virtual LANs (VLANs)*
- RFC 1918: *Address Allocation for Private Internets*

**Certificaciones y libros:**
- CCNA 200-301: *Implementing and Administering Cisco Solutions*
- Odom, W. (2023). *CCNA 200-301 Official Cert Guide Library*. Cisco Press.
- Lammle, T. (2023). *CCNA Routing and Switching Study Guide*. Sybex.

---

**Fecha de elaboración:** Marzo 2026  
**Versión:** 1.0  
**Nivel:** CCNA - Conmutación y Enrutamiento
