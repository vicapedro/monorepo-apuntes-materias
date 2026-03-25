# Práctica: Listas de Control de Acceso (ACLs) y Máscaras Wildcard

## Objetivo

Implementar y configurar listas de control de acceso estándar y extendidas en un entorno empresarial con múltiples VLANs, utilizando máscaras wildcard avanzadas para filtrado granular de tráfico y aplicando políticas de seguridad específicas por departamento mediante router-on-a-stick.

**Duración estimada:** 4 horas

## Competencias a desarrollar

- Implementa listas de control de acceso (ACLs) estándar y extendidas para control de tráfico en redes empresariales
- Utiliza máscaras wildcard para crear reglas de filtrado complejas y granulares
- Configura router-on-a-stick para enrutamiento inter-VLAN con políticas de seguridad
- Aplica ACLs en las direcciones correctas (inbound/outbound) de las interfaces
- Diagnostica y corrige errores comunes en la configuración de ACLs mediante troubleshooting sistemático
- Implementa políticas de seguridad por capa de aplicación utilizando ACLs extendidas
- Verifica el funcionamiento de ACLs mediante pruebas de conectividad y análisis de logs

## Introducción

### ¿Qué son las ACLs?

**Las Listas de Control de Acceso (Access Control Lists - ACLs)** son conjuntos de reglas secuenciales que permiten o deniegan el paso de tráfico a través de las interfaces de un router. Las ACLs son una de las herramientas fundamentales de seguridad en redes Cisco, funcionando como un firewall básico.

### Tipos de ACLs

**1. ACLs Estándar (Standard ACLs)**
- Números: 1-99 y 1300-1999
- Filtran **solo por dirección IP de origen**
- Menos granulares pero más simples
- Se aplican **lo más cerca posible del destino**
- No pueden distinguir protocolos o puertos

**2. ACLs Extendidas (Extended ACLs)**
- Números: 100-199 y 2000-2699
- Filtran por:
  - Dirección IP de origen
  - Dirección IP de destino
  - Protocolo (TCP, UDP, ICMP, etc.)
  - Número de puerto (HTTP=80, FTP=21, SSH=22, etc.)
- Mayor control granular
- Se aplican **lo más cerca posible del origen**

**3. ACLs con Nombre (Named ACLs)**
- Usan nombres descriptivos en lugar de números
- Pueden ser estándar o extendidas
- Permiten edición más flexible (inserción, eliminación de líneas específicas)
- Recomendadas para configuraciones complejas

### Máscaras Wildcard

**Las máscaras wildcard (máscaras inversas)** son el opuesto de las máscaras de subred:
- **0**: Bit debe coincidir exactamente (check)
- **1**: Bit puede ser cualquier valor (don't care)

**Comparación con máscaras de subred:**

| Máscara de Subred | Wildcard Mask | Significado |
|------------------|---------------|-------------|
| 255.255.255.255 | 0.0.0.0 | Host exacto |
| 255.255.255.0 | 0.0.0.255 | Red /24 completa |
| 255.255.255.252 | 0.0.0.3 | Subred /30 (4 hosts) |
| 255.255.255.240 | 0.0.0.15 | Subred /28 (16 hosts) |

**Cálculo de wildcard:**
```
Wildcard = 255.255.255.255 - Máscara de Subred

Ejemplo para /28:
255.255.255.255
- 255.255.255.240
= 0.0.0.15
```

### Wildcards Avanzadas (Patrones Binarios)

Las wildcards pueden crear patrones complejos más allá de subredes estándar:

**Ejemplo: Permitir solo hosts pares**
```
Dirección: 192.168.10.0
Wildcard: 0.0.0.254

Binario del wildcard: 11111110
Esto coincide con hosts que terminan en 0: .0, .2, .4, .6, etc.
```

**Ejemplo: Coincidencia de múltiples subredes**
```
Dirección: 192.168.10.0
Wildcard: 0.0.1.255

Coincide con: 192.168.10.0/24 Y 192.168.11.0/24
```

### Reglas de Procesamiento de ACLs

1. **Procesamiento secuencial**: Las reglas se evalúan de arriba hacia abajo
2. **Primera coincidencia gana**: Al encontrar coincidencia, se ejecuta la acción y se detiene el procesamiento
3. **Deny implícito al final**: Si no coincide ninguna regla, se deniega (implicit deny any)
4. **No hay vuelta atrás**: Una vez que coincide una regla, las siguientes se ignoran

### Buenas Prácticas de ACLs

✅ **Ubicación:**
- ACLs estándar: cerca del **destino**
- ACLs extendidas: cerca del **origen**

✅ **Orden de reglas:**
- Reglas más específicas **primero**
- Reglas más generales **después**
- Permit final si es necesario

✅ **Nomenclatura:**
- Usar ACLs con nombre para facilitar gestión
- Nombres descriptivos (ej: BLOCK-CCTV-WEB, ALLOW-IT-FTP)

✅ **Documentación:**
- Agregar comentarios con `remark`
- Documentar propósito de cada ACL

❌ **Errores comunes:**
- Aplicar ACL en interfaz/dirección incorrecta
- Orden incorrecto de reglas
- Wildcard mal calculada
- Olvidar el deny implícito
- No incluir regla permit para tráfico legítimo

### Direcciones y Puertos Comunes

| Servicio | Protocolo | Puerto | Descripción |
|----------|-----------|--------|-------------|
| HTTP | TCP | 80 | Web sin cifrado |
| HTTPS | TCP | 443 | Web cifrado |
| FTP (datos) | TCP | 20 | Transferencia de archivos (datos) |
| FTP (control) | TCP | 21 | Transferencia de archivos (control) |
| SSH | TCP | 22 | Shell remoto seguro |
| Telnet | TCP | 23 | Shell remoto (inseguro) |
| DNS | UDP | 53 | Resolución de nombres |
| DHCP | UDP | 67/68 | Asignación de IPs |
| TFTP | UDP | 69 | Transferencia trivial |
| ICMP | - | - | Ping, traceroute |

## Equipo de protección e higiene

No aplica para esta práctica de simulación en laboratorio de cómputo.

## Material y equipo necesario

### Materiales e insumos
- Computadora con acceso a Cisco Packet Tracer 8.0 o superior
- Acceso a Internet para consulta de documentación
- Libreta técnica para registro de observaciones y cálculos de wildcards

### Equipo de laboratorio
- Software: Cisco Packet Tracer (simulación)
- Mínimo 4 GB de RAM
- 500 MB de espacio disponible en disco
- Calculadora binaria/hexadecimal (puede usar calc.exe en modo programador)

### Herramientas
- Cisco Packet Tracer 8.0+
- Terminal de comandos IOS de Cisco
- Calculadora para conversiones binarias

### Nota importante sobre la realización de la práctica

**Esta práctica puede realizarse en dos modalidades:**

1. **Simulación en Packet Tracer** (recomendado para inicio)
   - Todas las instrucciones detalladas en este documento están orientadas a Cisco Packet Tracer
   - Permite realizar la práctica sin riesgo de afectar equipos reales
   - Ideal para familiarizarse con los conceptos antes de implementar en equipos físicos

2. **Implementación en laboratorio con equipos físicos**
   - La práctica puede adaptarse para ejecutarse con routers y switches Cisco reales
   - Se requiere acceso al laboratorio de redes con equipos físicos
   - Las configuraciones IOS son las mismas, pero deberá considerar:
     - Disponibilidad de interfaces físicas en los equipos
     - Switch con capacidades de VLANs (switches L2 gestionables)
     - Cableado estructurado adecuado
     - Acceso por consola o SSH a los dispositivos
     - Configuración de PCs cliente en cada VLAN
     - Servidores con servicios HTTP y FTP configurados
   - Consulte con el instructor la disponibilidad de equipamiento y topología adaptada

**Si realiza la práctica en laboratorio físico, adapte los nombres de interfaces y direcciones IP según los equipos disponibles.**

## Instrucciones

### Parte 1: Construcción de la Topología

**1.1** Abra Cisco Packet Tracer y cree la siguiente topología:

**Dispositivos necesarios:**
- 1 Router (modelo 2911 o superior con módulo HWIC-4ESW o usar subinterfaces)
- 1 Switch multicapa o switch con capacidad de VLANs (Switch 2960)
- 12 PCs (PC-PT)
- 2 Servidores (Server-PT)

**Esquema lógico de la red:**

```
                         ROUTER (Router-on-a-Stick)
                              Gi0/0
                                |
                         Trunk 802.1Q
                                |
                            [SWITCH]
                    ____________|____________
                   |      |      |     |     |
                 VLAN10 VLAN20 VLAN30 VLAN40 VLAN50
                   |      |      |     |     |
              Servidores Ventas Prod CCTV   TI
```

**Plan de direccionamiento IP:**

| VLAN | Nombre | Red | Gateway | Rango Hosts | Dispositivos |
|------|--------|-----|---------|-------------|--------------|
| 10 | Servidores | 192.168.10.0/28 | .1 | .2 - .14 | WebServer (.10), FTPServer (.11) |
| 20 | Ventas | 192.168.10.16/28 | .17 | .18 - .30 | PC-Ventas1 (.18), PC-Ventas2 (.19) |
| 30 | Producción | 192.168.10.32/28 | .33 | .34 - .46 | PC-Prod1 (.34), PC-Prod2 (.35), PC-Prod3 (.36) |
| 40 | CCTV | 192.168.10.48/28 | .49 | .50 - .62 | Cam-CCTV1 (.50), Cam-CCTV2 (.51) |
| 50 | TI | 192.168.10.64/28 | .65 | .66 - .78 | PC-TI1 (.66), PC-TI2 (.67), PC-TI3 (.68) |

**1.2** Realice las siguientes conexiones:

| Dispositivo Origen | Interfaz | Dispositivo Destino | Interfaz | Tipo Cable |
|-------------------|----------|---------------------|----------|------------|
| Router | GigabitEthernet0/0 | Switch | FastEthernet0/24 | Straight-Through |
| WebServer | FastEthernet0 | Switch | FastEthernet0/1 | Straight-Through |
| FTPServer | FastEthernet0 | Switch | FastEthernet0/2 | Straight-Through |
| PC-Ventas1 | FastEthernet0 | Switch | FastEthernet0/3 | Straight-Through |
| PC-Ventas2 | FastEthernet0 | Switch | FastEthernet0/4 | Straight-Through |
| PC-Prod1 | FastEthernet0 | Switch | FastEthernet0/5 | Straight-Through |
| PC-Prod2 | FastEthernet0 | Switch | FastEthernet0/6 | Straight-Through |
| PC-Prod3 | FastEthernet0 | Switch | FastEthernet0/7 | Straight-Through |
| Cam-CCTV1 | FastEthernet0 | Switch | FastEthernet0/8 | Straight-Through |
| Cam-CCTV2 | FastEthernet0 | Switch | FastEthernet0/9 | Straight-Through |
| PC-TI1 | FastEthernet0 | Switch | FastEthernet0/10 | Straight-Through |
| PC-TI2 | FastEthernet0 | Switch | FastEthernet0/11 | Straight-Through |
| PC-TI3 | FastEthernet0 | Switch | FastEthernet0/12 | Straight-Through |

**1.3** Capture de pantalla de la topología completa con todos los dispositivos conectados y etiquetados.

### Parte 2: Configuración del Switch con VLANs

**2.1 Configuración básica del switch**

```
Switch>enable
Switch#configure terminal
Switch(config)#hostname SW-Principal
SW-Principal(config)#no ip domain-lookup
SW-Principal(config)#enable secret cisco123

! Crear VLANs
SW-Principal(config)#vlan 10
SW-Principal(config-vlan)#name Servidores
SW-Principal(config-vlan)#exit

SW-Principal(config)#vlan 20
SW-Principal(config-vlan)#name Ventas
SW-Principal(config-vlan)#exit

SW-Principal(config)#vlan 30
SW-Principal(config-vlan)#name Produccion
SW-Principal(config-vlan)#exit

SW-Principal(config)#vlan 40
SW-Principal(config-vlan)#name CCTV
SW-Principal(config-vlan)#exit

SW-Principal(config)#vlan 50
SW-Principal(config-vlan)#name TI
SW-Principal(config-vlan)#exit
```

**2.2 Asignar puertos a VLANs**

```
! VLAN 10 - Servidores (puertos 1-2)
SW-Principal(config)#interface range fastEthernet 0/1-2
SW-Principal(config-if-range)#switchport mode access
SW-Principal(config-if-range)#switchport access vlan 10
SW-Principal(config-if-range)#exit

! VLAN 20 - Ventas (puertos 3-4)
SW-Principal(config)#interface range fastEthernet 0/3-4
SW-Principal(config-if-range)#switchport mode access
SW-Principal(config-if-range)#switchport access vlan 20
SW-Principal(config-if-range)#exit

! VLAN 30 - Producción (puertos 5-7)
SW-Principal(config)#interface range fastEthernet 0/5-7
SW-Principal(config-if-range)#switchport mode access
SW-Principal(config-if-range)#switchport access vlan 30
SW-Principal(config-if-range)#exit

! VLAN 40 - CCTV (puertos 8-9)
SW-Principal(config)#interface range fastEthernet 0/8-9
SW-Principal(config-if-range)#switchport mode access
SW-Principal(config-if-range)#switchport access vlan 40
SW-Principal(config-if-range)#exit

! VLAN 50 - TI (puertos 10-12)
SW-Principal(config)#interface range fastEthernet 0/10-12
SW-Principal(config-if-range)#switchport mode access
SW-Principal(config-if-range)#switchport access vlan 50
SW-Principal(config-if-range)#exit

! Configurar puerto trunk hacia el router (puerto 24)
SW-Principal(config)#interface fastEthernet 0/24
SW-Principal(config-if)#description Trunk to Router
SW-Principal(config-if)#switchport mode trunk
SW-Principal(config-if)#switchport trunk allowed vlan 10,20,30,40,50
SW-Principal(config-if)#exit

SW-Principal(config)#exit
SW-Principal#copy running-config startup-config
```

**2.3** Verifique la configuración de VLANs:
```
SW-Principal#show vlan brief
SW-Principal#show interfaces trunk
```

**2.4** Capture de pantalla mostrando las VLANs configuradas y el trunk.

### Parte 3: Configuración del Router (Router-on-a-Stick)

**3.1 Configuración básica del router**

```
Router>enable
Router#configure terminal
Router(config)#hostname R-Central
R-Central(config)#no ip domain-lookup
R-Central(config)#enable secret cisco123

! Habilitar la interfaz principal
R-Central(config)#interface gigabitEthernet 0/0
R-Central(config-if)#description Trunk to Switch
R-Central(config-if)#no shutdown
R-Central(config-if)#exit
```

**3.2 Configurar subinterfaces para cada VLAN**

```
! Subinterfaz para VLAN 10 - Servidores
R-Central(config)#interface gigabitEthernet 0/0.10
R-Central(config-subif)#description Gateway VLAN 10 Servidores
R-Central(config-subif)#encapsulation dot1Q 10
R-Central(config-subif)#ip address 192.168.10.1 255.255.255.240
R-Central(config-subif)#exit

! Subinterfaz para VLAN 20 - Ventas
R-Central(config)#interface gigabitEthernet 0/0.20
R-Central(config-subif)#description Gateway VLAN 20 Ventas
R-Central(config-subif)#encapsulation dot1Q 20
R-Central(config-subif)#ip address 192.168.10.17 255.255.255.240
R-Central(config-subif)#exit

! Subinterfaz para VLAN 30 - Produccion
R-Central(config)#interface gigabitEthernet 0/0.30
R-Central(config-subif)#description Gateway VLAN 30 Produccion
R-Central(config-subif)#encapsulation dot1Q 30
R-Central(config-subif)#ip address 192.168.10.33 255.255.255.240
R-Central(config-subif)#exit

! Subinterfaz para VLAN 40 - CCTV
R-Central(config)#interface gigabitEthernet 0/0.40
R-Central(config-subif)#description Gateway VLAN 40 CCTV
R-Central(config-subif)#encapsulation dot1Q 40
R-Central(config-subif)#ip address 192.168.10.49 255.255.255.240
R-Central(config-subif)#exit

! Subinterfaz para VLAN 50 - TI
R-Central(config)#interface gigabitEthernet 0/0.50
R-Central(config-subif)#description Gateway VLAN 50 TI
R-Central(config-subif)#encapsulation dot1Q 50
R-Central(config-subif)#ip address 192.168.10.65 255.255.255.240
R-Central(config-subif)#exit

R-Central(config)#exit
R-Central#copy running-config startup-config
```

**3.3** Verifique la configuración de subinterfaces:
```
R-Central#show ip interface brief
R-Central#show running-config interface gigabitEthernet 0/0
```

**3.4** Capture de pantalla de las subinterfaces configuradas.

### Parte 4: Configuración de Servidores y PCs

**4.1 Configuración del Servidor Web (VLAN 10)**

- **IP Address:** 192.168.10.10
- **Subnet Mask:** 255.255.255.240
- **Default Gateway:** 192.168.10.1
- **DNS Server:** 8.8.8.8

Activar servicio HTTP:
- Desktop → Services → HTTP → ON
- Editar index.html:
```html
<html>
<head><title>Servidor Web Corporativo</title></head>
<body>
<h1>Portal Web Corporativo</h1>
<p>Servidor Web - VLAN Servidores</p>
<p>IP: 192.168.10.10</p>
<p>Acceso restringido segun politicas de seguridad</p>
</body>
</html>
```

**4.2 Configuración del Servidor FTP (VLAN 10)**

- **IP Address:** 192.168.10.11
- **Subnet Mask:** 255.255.255.240
- **Default Gateway:** 192.168.10.1
- **DNS Server:** 8.8.8.8

Activar servicio FTP:
- Desktop → Services → FTP → ON
- Crear usuario de prueba:
  - Username: admin
  - Password: admin123
  - Permissions: RWDNL (todos)

**4.3 Configuración de PCs - VLAN 20 Ventas**

**PC-Ventas1:**
- IP: 192.168.10.18
- Mask: 255.255.255.240
- Gateway: 192.168.10.17

**PC-Ventas2:**
- IP: 192.168.10.19
- Mask: 255.255.255.240
- Gateway: 192.168.10.17

**4.4 Configuración de PCs - VLAN 30 Producción**

**PC-Prod1:**
- IP: 192.168.10.34
- Mask: 255.255.255.240
- Gateway: 192.168.10.33

**PC-Prod2:**
- IP: 192.168.10.35
- Mask: 255.255.255.240
- Gateway: 192.168.10.33

**PC-Prod3:**
- IP: 192.168.10.36
- Mask: 255.255.255.240
- Gateway: 192.168.10.33

**4.5 Configuración de "Cámaras" - VLAN 40 CCTV**

**Cam-CCTV1 (PC simulando cámara):**
- IP: 192.168.10.50
- Mask: 255.255.255.240
- Gateway: 192.168.10.49

**Cam-CCTV2:**
- IP: 192.168.10.51
- Mask: 255.255.255.240
- Gateway: 192.168.10.49

**4.6 Configuración de PCs - VLAN 50 TI**

**PC-TI1:**
- IP: 192.168.10.66
- Mask: 255.255.255.240
- Gateway: 192.168.10.65

**PC-TI2:**
- IP: 192.168.10.67
- Mask: 255.255.255.240
- Gateway: 192.168.10.65

**PC-TI3:**
- IP: 192.168.10.68
- Mask: 255.255.255.240
- Gateway: 192.168.10.65

**4.7** Capture de pantalla mostrando la configuración IP de al menos un dispositivo por VLAN.

### Parte 5: Verificación de Conectividad Base (Sin ACLs)

**5.1** Desde PC-Ventas1, verifique conectividad básica:
```
C:\> ping 192.168.10.17     (Gateway local)
C:\> ping 192.168.10.10     (Servidor Web)
C:\> ping 192.168.10.34     (PC-Prod1)
C:\> ping 192.168.10.66     (PC-TI1)
```

**5.2** Desde PC-TI1, acceda al servidor web:
- Abrir navegador → http://192.168.10.10
- Capturar pantalla del acceso exitoso

**5.3** Desde Cam-CCTV1, acceda al servidor web:
- Abrir navegador → http://192.168.10.10
- Capturar pantalla del acceso exitoso

**Pregunta 1:** Sin ACLs configuradas, ¿todos los dispositivos pueden acceder a todos los servicios? ¿Es esto deseable desde el punto de vista de seguridad?

**5.4** Desde PC-Prod1, intente acceder al servidor FTP:
- Command Prompt → `ftp 192.168.10.11`
- Debería conectar exitosamente

**5.5** Capture de pantalla mostrando la conectividad completa entre VLANs sin restricciones.

### Parte 6: ACL Estándar con Wildcard Avanzada (¡CON ERROR INTENCIONAL!)

**6.1 Análisis del patrón de hosts a denegar**

Hosts a denegar en VLAN Producción (192.168.10.32/28): **0, 1, 4, 5, 8, 9, 12, 13**

**Analicemos el patrón binario:**

| Host Decimal | Binario | A denegar |
|--------------|---------|-----------|
| 0 | 0000 | ✅ |
| 1 | 0001 | ✅ |
| 2 | 0010 | ❌ |
| 3 | 0011 | ❌ |
| 4 | 0100 | ✅ |
| 5 | 0101 | ✅ |
| 6 | 0110 | ❌ |
| 7 | 0111 | ❌ |
| 8 | 1000 | ✅ |
| 9 | 1001 | ✅ |
| 10 | 1010 | ❌ |
| 11 | 1011 | ❌ |
| 12 | 1100 | ✅ |
| 13 | 1101 | ✅ |
| 14 | 1110 | ❌ |
| 15 | 1111 | ❌ |

**Patrón identificado:**
- Hosts con el **bit 1** (segundo menos significativo) = **0**
- Y con los bits restantes en posiciones específicas

**Wildcard correcta:** 0.0.0.13 (binario: 00001101)
- Bits que deben coincidir (0): posiciones que definen el patrón
- Bits "don't care" (1): posiciones variables

**Dirección base:** 192.168.10.32 (inicio de la subred de Producción)

**Verificación manual:**
```
192.168.10.32 (host .0 de la subred) con wildcard 0.0.0.13
coincide con: .32, .33, .36, .37, .40, .41, .44, .45

Que corresponden a hosts 0, 1, 4, 5, 8, 9, 12, 13 ✅
```

**6.2 Configuración de ACL**

```
R-Central#configure terminal

! Crear ACL estándar con nombre
R-Central(config)#ip access-list standard BLOQUEAR-HOSTS-PROD

! Denegar hosts específicos con wildcard calculada
R-Central(config-std-nacl)#remark Denegar hosts especificos de Produccion
R-Central(config-std-nacl)#deny 192.168.10.32 0.0.0.15
R-Central(config-std-nacl)#remark Permitir el resto del trafico
R-Central(config-std-nacl)#permit any
R-Central(config-std-nacl)#exit

! Aplicar ACL en la subinterfaz de Producción (dirección outbound)
R-Central(config)#interface gigabitEthernet 0/0.30
R-Central(config-subif)#ip access-group BLOQUEAR-HOSTS-PROD out
R-Central(config-subif)#exit

R-Central(config)#exit
```

**6.3** Verifique la ACL configurada:
```
R-Central#show access-lists
R-Central#show ip interface gigabitEthernet 0/0.30
```

**6.4** Capture de pantalla de la configuración de la ACL.

**6.5 Pruebas de conectividad con ACL aplicada**

Desde el router, pruebe la ACL:
```
R-Central#ping 192.168.10.34 source 192.168.10.1
R-Central#ping 192.168.10.35 source 192.168.10.1
R-Central#ping 192.168.10.36 source 192.168.10.1
```

**Pregunta 2:** ¿Qué hosts esperaría que no respondan al ping? Haga una lista predicha antes de probar.

**6.6** Desde PC-Ventas1, pruebe conectividad a los PCs de Producción:
```
C:\> ping 192.168.10.34
C:\> ping 192.168.10.35
C:\> ping 192.168.10.36
C:\> ping 192.168.10.37
C:\> ping 192.168.10.38
C:\> ping 192.168.10.40
```

**6.7** Complete la siguiente tabla de resultados:

| Host Destino | IP | Host# en subred | Predicción (Bloquear/Permitir) | Resultado Real |
|--------------|----|-----------------|---------------------------------|----------------|
| PC-Prod1 | 192.168.10.34 | 2 | | |
| PC-Prod2 | 192.168.10.35 | 3 | | |
| PC-Prod3 | 192.168.10.36 | 4 | | |
| - | 192.168.10.37 | 5 | | |
| - | 192.168.10.40 | 8 | | |
| - | 192.168.10.41 | 9 | | |

**Pregunta 3:** ¿Los resultados coinciden con sus predicciones? Si no, analice cuidadosamente la wildcard utilizada y explique qué hosts están siendo bloqueados realmente.

**6.8 Análisis de la wildcard configurada (TROUBLESHOOTING)**

Analice la wildcard que configuró:
```
Wildcard configurada: 0.0.0.15 (binario: 00001111)
```

**Calculemos qué hosts coinciden con 192.168.10.32 wildcard 0.0.0.15:**

| Octeto | Valor | Wildcard | Explicación |
|--------|-------|----------|-------------|
| 1 | 192 | 0 | Debe ser exactamente 192 |
| 2 | 168 | 0 | Debe ser exactamente 168 |
| 3 | 10 | 0 | Debe ser exactamente 10 |
| 4 | 32 | 15 | Bits 0-3 pueden variar |

**Wildcard 15 en binario: 0000 1111**
- Bits 0-3 (últimos 4 bits): "don't care" (pueden ser cualquier valor)
- Bits 4-7: deben coincidir

Esto significa: todos los hosts de .32 a .47 (16 hosts) serán bloqueados, ¡no solo los 8 que queríamos!

**Pregunta 4:** Analice bit por bit la wildcard 0.0.0.15. ¿Coincide exactamente con los hosts que queremos bloquear (0, 1, 4, 5, 8, 9, 12, 13)? Si no, calcule cuál sería la wildcard correcta.

**6.9 Corrección de la configuración**

Una vez identificado el problema, elimine la ACL y créela con la wildcard correcta:

```
R-Central#configure terminal

! Eliminar ACL errónea
R-Central(config)#no ip access-list standard BLOQUEAR-HOSTS-PROD

! Crear ACL correcta
R-Central(config)#ip access-list standard BLOQUEAR-HOSTS-PROD
R-Central(config-std-nacl)#remark Denegar hosts 0,1,4,5,8,9,12,13 de Produccion
R-Central(config-std-nacl)#deny 192.168.10.32 0.0.0.13
R-Central(config-std-nacl)#remark Permitir resto del trafico
R-Central(config-std-nacl)#permit any
R-Central(config-std-nacl)#exit

! Aplicar en la subinterfaz
R-Central(config)#interface gigabitEthernet 0/0.30
R-Central(config-subif)#ip access-group BLOQUEAR-HOSTS-PROD out
R-Central(config-subif)#exit

R-Central(config)#exit
```

**6.10** Verifique la nueva configuración:
```
R-Central#show access-lists BLOQUEAR-HOSTS-PROD
```

**6.11** Vuelva a probar la conectividad con la wildcard correcta y verifique que ahora solo se bloquean los hosts esperados.

**6.12** Capture de pantalla mostrando:
- La ACL corregida
- Resultados de ping mostrando el bloqueo correcto

**Pregunta 5:** ¿Cuál es la fórmula para calcular una wildcard a partir de los hosts que desea coincidir cuando no siguen un patrón de subred estándar?

### Parte 7: ACL Extendida - Bloquear CCTV del Servidor Web

**7.1 Análisis del requisito**

**Política de seguridad:**
- Las cámaras CCTV (VLAN 40) NO deben tener acceso al servidor web
- Solo necesitan conectividad para enviar video a sistema de grabación
- Acceso web innecesario y riesgo de seguridad (malware en firmware comprometido)

**Parámetros de la ACL:**
- Origen: Red CCTV (192.168.10.48/28)
- Destino: Servidor Web (192.168.10.10)
- Protocolo: TCP
- Puerto destino: 80 (HTTP) y 443 (HTTPS)

**7.2 Configuración de ACL extendida**

```
R-Central#configure terminal

! Crear ACL extendida con nombre
R-Central(config)#ip access-list extended BLOQUEAR-CCTV-WEB

! Denegar HTTP de CCTV a servidor web
R-Central(config-ext-nacl)#remark Denegar HTTP de CCTV a servidor web
R-Central(config-ext-nacl)#deny tcp 192.168.10.48 0.0.0.15 host 192.168.10.10 eq 80

! Denegar HTTPS de CCTV a servidor web
R-Central(config-ext-nacl)#remark Denegar HTTPS de CCTV a servidor web
R-Central(config-ext-nacl)#deny tcp 192.168.10.48 0.0.0.15 host 192.168.10.10 eq 443

! Permitir todo lo demás
R-Central(config-ext-nacl)#remark Permitir resto del trafico
R-Central(config-ext-nacl)#permit ip any any
R-Central(config-ext-nacl)#exit

! Aplicar en la subinterfaz de CCTV (dirección IN - cerca del origen)
R-Central(config)#interface gigabitEthernet 0/0.40
R-Central(config-subif)#ip access-group BLOQUEAR-CCTV-WEB in
R-Central(config-subif)#exit

R-Central(config)#exit
R-Central#copy running-config startup-config
```

**Explicación de parámetros:**
- `tcp`: Protocolo de transporte
- `192.168.10.48 0.0.0.15`: Toda la red CCTV
- `host 192.168.10.10`: Específicamente el servidor web (equivale a wildcard 0.0.0.0)
- `eq 80`: Puerto igual a 80 (HTTP)
- `eq 443`: Puerto igual a 443 (HTTPS)

**7.3** Verifique la ACL:
```
R-Central#show access-lists BLOQUEAR-CCTV-WEB
R-Central#show ip interface gigabitEthernet 0/0.40
```

**7.4** Capture de pantalla de la configuración de la ACL extendida.

**7.5 Pruebas de la ACL**

Desde Cam-CCTV1:
```
C:\> ping 192.168.10.10     (Debe funcionar - ICMP no está bloqueado)
```

Abrir navegador:
```
http://192.168.10.10        (Debe fallar - HTTP bloqueado)
```

Desde PC-Ventas1:
```
Navegador: http://192.168.10.10    (Debe funcionar - otras VLANs permitidas)
```

Desde PC-TI1:
```
Navegador: http://192.168.10.10    (Debe funcionar)
```

**7.6** Capture de pantalla mostrando:
- Ping exitoso desde CCTV al servidor web
- Acceso HTTP bloqueado desde CCTV
- Acceso HTTP exitoso desde otras VLANs

**Pregunta 6:** ¿Por qué el ping funciona pero el HTTP no desde la VLAN CCTV? Explique la diferencia entre bloquear por protocolo de capa 3 vs capa 4.

**7.7** Verifique las estadísticas de la ACL:
```
R-Central#show access-lists BLOQUEAR-CCTV-WEB
```

Observe los contadores de coincidencias (matches).

**Pregunta 7:** ¿Qué muestran los contadores de la ACL? ¿Para qué son útiles estos contadores en troubleshooting?

### Parte 8: ACL Extendida - Restringir FTP Solo para TI

**8.1 Análisis del requisito**

**Política de seguridad:**
- El servidor FTP (192.168.10.11) es solo para uso del departamento de TI
- Otras VLANs NO deben tener acceso FTP
- TI necesita acceso completo (control y datos FTP)

**Estrategia de ACL:**
- Permitir FTP desde VLAN TI al servidor
- Denegar FTP desde todas las demás VLANs
- Permitir resto del tráfico

**8.2 Configuración de ACL extendida**

```
R-Central#configure terminal

! Crear ACL extendida
R-Central(config)#ip access-list extended RESTRINGIR-FTP-TI

! Permitir FTP de TI a servidor FTP (puerto 21 - control)
R-Central(config-ext-nacl)#remark Permitir FTP control de TI a servidor
R-Central(config-ext-nacl)#permit tcp 192.168.10.64 0.0.0.15 host 192.168.10.11 eq 21

! Permitir FTP de TI a servidor FTP (puerto 20 - datos)
R-Central(config-ext-nacl)#remark Permitir FTP datos de TI a servidor
R-Central(config-ext-nacl)#permit tcp 192.168.10.64 0.0.0.15 host 192.168.10.11 eq 20

! Denegar FTP de cualquier otra red al servidor (puerto 21)
R-Central(config-ext-nacl)#remark Denegar FTP control de otras VLANs
R-Central(config-ext-nacl)#deny tcp any host 192.168.10.11 eq 21

! Denegar FTP de cualquier otra red al servidor (puerto 20)
R-Central(config-ext-nacl)#remark Denegar FTP datos de otras VLANs
R-Central(config-ext-nacl)#deny tcp any host 192.168.10.11 eq 20

! Permitir todo lo demás
R-Central(config-ext-nacl)#remark Permitir resto del trafico
R-Central(config-ext-nacl)#permit ip any any
R-Central(config-ext-nacl)#exit

! Aplicar en la subinterfaz de Servidores (cerca del destino)
R-Central(config)#interface gigabitEthernet 0/0.10
R-Central(config-subif)#ip access-group RESTRINGIR-FTP-TI in
R-Central(config-subif)#exit

R-Central(config)#exit
R-Central#copy running-config startup-config
```

**8.3** Verifique la ACL:
```
R-Central#show access-lists RESTRINGIR-FTP-TI
R-Central#show ip interface gigabitEthernet 0/0.10
```

**8.4** Capture de pantalla de la ACL configurada.

**8.5 Pruebas de acceso FTP**

Desde PC-TI1 (debe permitir):
```
C:\> ftp 192.168.10.11
Username: admin
Password: admin123
ftp> dir
ftp> quit
```

Desde PC-Ventas1 (debe denegar):
```
C:\> ftp 192.168.10.11
(Debe fallar la conexión)
```

Desde PC-Prod1 (debe denegar):
```
C:\> ftp 192.168.10.11
(Debe fallar la conexión)
```

**8.6** Capture de pantalla mostrando:
- Conexión FTP exitosa desde TI
- Conexión FTP bloqueada desde Ventas
- Conexión FTP bloqueada desde Producción

**Pregunta 8:** ¿Por qué se aplicó esta ACL en la interfaz de Servidores (VLAN 10) en dirección "in" y no en las interfaces de origen? ¿Cuál es más eficiente?

**8.7** Verifique que otros servicios del servidor aún funcionen:

Desde PC-Ventas1:
```
C:\> ping 192.168.10.11     (Debe funcionar)
```

**Pregunta 9:** ¿Se puede hacer ping al servidor FTP desde Ventas aunque el FTP esté bloqueado? ¿Por qué?

### Parte 9: Verificación y Análisis Completo de ACLs

**9.1** Muestre todas las ACLs configuradas:
```
R-Central#show access-lists
```

**9.2** Muestre las ACLs aplicadas en cada interfaz:
```
R-Central#show ip interface gigabitEthernet 0/0.10
R-Central#show ip interface gigabitEthernet 0/0.30
R-Central#show ip interface gigabitEthernet 0/0.40
```

**9.3** Capture de pantalla mostrando todas las ACLs configuradas.

**9.4** Complete la siguiente tabla de políticas implementadas:

| Política | Tipo ACL | Nombre ACL | Aplicada en | Dirección | Efecto |
|----------|----------|------------|-------------|-----------|--------|
| Bloquear hosts específicos Prod | Estándar | BLOQUEAR-HOSTS-PROD | Gi0/0.30 | Out | Niega hosts 0,1,4,5,8,9,12,13 |
| Bloquear CCTV de Web | Extendida | BLOQUEAR-CCTV-WEB | | | |
| Restringir FTP solo a TI | Extendida | RESTRINGIR-FTP-TI | | | |

**9.5 Matriz de conectividad**

Complete la siguiente matriz (✅ permitido, ❌ bloqueado):

| Origen → Destino | Web (HTTP) | FTP | Ping Web | Ping FTP | Otras VLANs |
|------------------|------------|-----|----------|----------|-------------|
| Ventas | | | | | |
| Producción | | | | | |
| CCTV | | | | | |
| TI | | | | | |

### Parte 10: Troubleshooting Avanzado de ACLs

**10.1 Escenario 1: ACL en dirección incorrecta**

Mueva la ACL de CCTV a dirección outbound (incorrecta):
```
R-Central(config)#interface gigabitEthernet 0/0.40
R-Central(config-subif)#no ip access-group BLOQUEAR-CCTV-WEB in
R-Central(config-subif)#ip access-group BLOQUEAR-CCTV-WEB out
R-Central(config-subif)#exit
```

Pruebe desde Cam-CCTV1:
```
Navegador: http://192.168.10.10
```

**Pregunta 10:** ¿Funciona el bloqueo? ¿Por qué la dirección importa?

Corrija la configuración:
```
R-Central(config)#interface gigabitEthernet 0/0.40
R-Central(config-subif)#no ip access-group BLOQUEAR-CCTV-WEB out
R-Central(config-subif)#ip access-group BLOQUEAR-CCTV-WEB in
R-Central(config-subif)#exit
```

**10.2 Escenario 2: Orden incorrecto de reglas**

Modifique la ACL de FTP con orden incorrecto:
```
R-Central(config)#no ip access-list extended RESTRINGIR-FTP-TI
R-Central(config)#ip access-list extended RESTRINGIR-FTP-TI

! ORDEN INCORRECTO: permit any primero
R-Central(config-ext-nacl)#permit ip any any
R-Central(config-ext-nacl)#deny tcp any host 192.168.10.11 eq 21
R-Central(config-ext-nacl)#deny tcp any host 192.168.10.11 eq 20
R-Central(config-ext-nacl)#exit
```

Pruebe desde PC-Ventas1:
```
C:\> ftp 192.168.10.11
```

**Pregunta 11:** ¿Se bloquea el acceso FTP desde Ventas? ¿Por qué no funciona esta ACL?

Explique el concepto de "primera coincidencia gana".

Corrija el orden:
```
R-Central(config)#no ip access-list extended RESTRINGIR-FTP-TI
R-Central(config)#ip access-list extended RESTRINGIR-FTP-TI
R-Central(config-ext-nacl)#permit tcp 192.168.10.64 0.0.0.15 host 192.168.10.11 eq 21
R-Central(config-ext-nacl)#permit tcp 192.168.10.64 0.0.0.15 host 192.168.10.11 eq 20
R-Central(config-ext-nacl)#deny tcp any host 192.168.10.11 eq 21
R-Central(config-ext-nacl)#deny tcp any host 192.168.10.11 eq 20
R-Central(config-ext-nacl)#permit ip any any
R-Central(config-ext-nacl)#exit
```

**10.3 Comandos de troubleshooting útiles**

```
! Ver ACLs configuradas
show access-lists
show ip access-lists
show access-lists [nombre]

! Ver ACLs aplicadas en interfaces
show ip interface [interfaz]
show running-config interface [interfaz]

! Ver estadísticas de coincidencias
show access-lists [nombre]

! Limpiar contadores de ACL
clear access-list counters [nombre]

! Debug de ACLs (usar con precaución)
debug ip packet [acl-number] detail

! Ver todas las interfaces con ACLs
show ip interface | include access list

! Deshabilitar debugs
undebug all
```

**10.4** Capture de pantalla del troubleshooting y corrección de errores.

### Parte 11: Optimización y Mejores Prácticas

**11.1 Consolidación de ACLs**

Analice si algunas ACLs pueden combinarse o reordenarse para mayor eficiencia.

**Pregunta 12:** ¿Sería más eficiente tener una sola ACL grande aplicada en el router o múltiples ACLs pequeñas en cada interfaz? Justifique su respuesta.

**11.2 Uso de ACLs con nombre vs numeradas**

**Ventajas de ACLs con nombre:**
- ✅ Nombres descriptivos
- ✅ Pueden editarse sin eliminarlas completamente
- ✅ Pueden insertarse líneas específicas
- ✅ Facilitan el mantenimiento

**Ejemplo de edición de ACL con nombre:**
```
R-Central(config)#ip access-list extended BLOQUEAR-CCTV-WEB
R-Central(config-ext-nacl)#15 deny tcp 192.168.10.48 0.0.0.15 host 192.168.10.10 eq 8080
R-Central(config-ext-nacl)#exit
```

**11.3 Documentación con remarks**

Agregue comentarios descriptivos:
```
R-Central(config)#ip access-list extended RESTRINGIR-FTP-TI
R-Central(config-ext-nacl)#1 remark ================================================
R-Central(config-ext-nacl)#2 remark ACL: Restringir acceso FTP solo a departamento TI
R-Central(config-ext-nacl)#3 remark Creada: 19-Mar-2026
R-Central(config-ext-nacl)#4 remark Responsable: Admin de Red
R-Central(config-ext-nacl)#5 remark ================================================
R-Central(config-ext-nacl)#exit
```

**11.4** Verifique la configuración completa:
```
R-Central#show running-config | section access-list
```

**11.5** Capture de pantalla de la configuración final optimizada.

### Parte 12: Análisis de Seguridad y Reflexión

**12.1** Responda las siguientes preguntas de análisis:

**Pregunta 13:** ¿Qué pasaría si aplicara una ACL que solo tiene reglas "deny" sin un "permit any" al final? ¿Por qué?

**Pregunta 14:** En una ACL extendida, ¿cuál es la diferencia entre usar "any" vs usar la red específica con wildcard? ¿Cuál es más eficiente?

**Pregunta 15:** Si necesita permitir acceso HTTPS (puerto 443) además de HTTP (puerto 80), ¿cómo modificaría la ACL BLOQUEAR-CCTV-WEB?

**Pregunta 16:** Explique cuándo es apropiado usar una ACL estándar vs una ACL extendida. Proporcione ejemplos de cada caso.

**Pregunta 17:** ¿Por qué es importante el orden de las reglas en una ACL? Proporcione un ejemplo donde el orden incorrecto cause problemas.

**12.2 Escenario de diseño**

Se requiere implementar las siguientes políticas adicionales:
1. Denegar acceso Telnet (puerto 23) desde cualquier VLAN excepto TI
2. Permitir DNS (puerto 53 UDP) desde todas las VLANs
3. Bloquear ping (ICMP) desde CCTV a todas las demás VLANs

**Diseñe las ACLs necesarias** (no las implemente, solo escriba las reglas):

```
! ACL para política 1 - Telnet solo TI
ip access-list extended [NOMBRE]
[escriba las reglas aquí]

! ACL para política 3 - Bloquear ICMP de CCTV
ip access-list extended [NOMBRE]
[escriba las reglas aquí]
```

**12.3** Elabore un diagrama que muestre:
- La topología completa
- Todas las ACLs aplicadas
- Dirección de aplicación (in/out)
- Flujos de tráfico permitidos/bloqueados

## Notas

### Consideraciones importantes:

1. **Procesamiento de ACLs:**
   - Las ACLs se procesan de arriba hacia abajo
   - Primera coincidencia gana (no continúa evaluando)
   - Deny implícito al final (invisible pero siempre presente)
   - Orden de las reglas es CRÍTICO

2. **Impacto en rendimiento:**
   - ACLs muy largas pueden afectar performance del router
   - Colocar reglas más comunes primero optimiza procesamiento
   - ACLs extendidas son más costosas que estándar (más criterios)
   - Usar ACLs con nombre permite mejor gestión

3. **Dirección de aplicación:**
   - **Inbound (in)**: Tráfico que entra a la interfaz
   - **Outbound (out)**: Tráfico que sale de la interfaz
   - Elegir correctamente evita tráfico innecesario en el router
   - Regla general: ACLs extendidas cerca del origen (in), estándar cerca del destino (out)

4. **Wildcards complejas:**
   - No todas las wildcards son subredes estándar
   - Pueden crear patrones binarios arbitrarios
   - Útiles para filtrado granular (hosts pares, rangos específicos)
   - Requieren análisis binario cuidadoso

5. **Limitaciones de ACLs:**
   - No inspeccionan contenido de paquetes (solo headers)
   - No protegen contra ataques de capa de aplicación
   - No son stateful (no rastrean conexiones)
   - Para seguridad avanzada, considerar firewalls dedicados

6. **Troubleshooting:**
   - Usar `show access-lists` para ver configuración y contadores
   - Contadores muestran cuántos paquetes coincidieron con cada regla
   - `clear access-list counters` reinicia contadores para pruebas
   - Debug puede generar mucha salida (usar con cuidado en producción)

7. **Seguridad por capas:**
   - ACLs son una capa de seguridad, no la única
   - Complementar con:
     * VLANs para segmentación
     * Firewalls perimetrales
     * IPS/IDS para detección de intrusiones
     * Autenticación 802.1X en puertos
     * Políticas de seguridad corporativas

### Mejores prácticas:

**Diseño de ACLs:**
1. **Planificar antes de implementar**: Documentar políticas de seguridad
2. **Usar nombres descriptivos**: Facilita mantenimiento
3. **Reglas específicas primero**: Orden de más específico a más general
4. **Incluir remarks**: Documentar propósito de cada regla
5. **Permitir explícitamente**: Incluir `permit any` si es necesario (no confiar solo en deny implícito)

**Implementación:**
6. **Probar en laboratorio primero**: Nunca en producción directamente
7. **Aplicar en horarios de bajo tráfico**: Minimizar impacto
8. **Backup de configuración**: Antes de cambios importantes
9. **Monitorear contadores**: Verificar que las reglas se activen como esperado
10. **Documentar cambios**: Log de cuándo, quién y por qué

**Mantenimiento:**
11. **Revisar periódicamente**: Eliminar reglas obsoletas
12. **Optimizar**: Reordenar según estadísticas de uso
13. **Consolidar**: Combinar reglas similares cuando sea posible
14. **Auditar**: Verificar que las políticas sigan siendo necesarias

### Wildcards útiles comunes:

| Propósito | Dirección | Wildcard | Descripción |
|-----------|-----------|----------|-------------|
| Host único | x.x.x.x | 0.0.0.0 | Un solo host (equivale a "host x.x.x.x") |
| Cualquier host | 0.0.0.0 | 255.255.255.255 | Todos los hosts (equivale a "any") |
| Subred /24 | x.x.x.0 | 0.0.0.255 | Red clase C completa |
| Subred /28 | x.x.x.0 | 0.0.0.15 | 16 hosts |
| Subred /30 | x.x.x.0 | 0.0.0.3 | 4 hosts (punto a punto) |
| Hosts pares | x.x.x.0 | 0.0.0.254 | Solo hosts pares (.0, .2, .4...) |
| Hosts impares | x.x.x.1 | 0.0.0.254 | Solo hosts impares (.1, .3, .5...) |

### Comandos de verificación rápida:

```
! Configuración de ACLs
show access-lists                      # Todas las ACLs
show ip access-lists                   # Solo ACLs IP
show access-lists [nombre]             # ACL específica
show running-config | include access   # Todas las menciones de ACLs

! Aplicación de ACLs
show ip interface [interfaz]           # ACLs en interfaz específica
show ip interface | include access     # Resumen de ACLs aplicadas

! Troubleshooting
show access-lists [nombre]             # Ver contadores
clear access-list counters [nombre]    # Limpiar contadores
debug ip packet [acl] detail           # Debug de paquetes (cuidado)

! Edición de ACLs con nombre
ip access-list [standard|extended] [nombre]
  [número] [permit|deny] [criterios]   # Insertar regla en posición
  no [número]                          # Eliminar regla específica
```

### Alternativas y tecnologías relacionadas:

- **Zone-Based Firewall (ZBF)**: Firewall stateful de Cisco IOS
- **Cisco ASA**: Appliance firewall dedicado con inspección stateful
- **Firepower**: NGFW con IPS integrado
- **Network Security Groups (NSG)**: En entornos cloud (Azure, AWS)
- **VACLs**: ACLs de VLAN en switches multicapa
- **PACLs**: ACLs de puerto en switches

### Entrega de la práctica:

**Formato de entrega:** Reporte en PDF con las siguientes secciones:

1. **Portada** con datos del alumno
2. **Introducción** explicando los conceptos de ACLs y wildcards
3. **Desarrollo** con capturas de pantalla de cada paso (mínimo 25)
4. **Tablas completas** de análisis binario de wildcards
5. **Respuestas** a las 17 preguntas planteadas
6. **Diagramas** de topología con ACLs aplicadas
7. **Matriz de conectividad** completa
8. **Análisis del error** de wildcard y su corrección
9. **Diseño de ACLs** para escenario adicional (Parte 12.2)
10. **Conclusiones** sobre la importancia de ACLs en seguridad
11. **Referencias** bibliográficas consultadas

**Puntos clave a incluir:**
- Evidencia de configuración completa de VLANs y router-on-a-stick
- Análisis binario detallado de la wildcard errónea vs correcta
- Capturas mostrando bloqueos y permisos según políticas
- ACLs estándar y extendidas correctamente configuradas
- Troubleshooting de escenarios de error
- Estadísticas de contadores de ACLs
- Reflexión sobre mejores prácticas de seguridad
- Comparación de ACLs estándar vs extendidas

### Referencias:

**Documentación Cisco:**
- Cisco. (2023). *IP Access List Entry Sequence Numbering*. Cisco IOS Security Configuration Guide.
- Cisco. (2023). *Configuring IP Access Lists*. Cisco IOS IP Configuration Guide.
- Cisco. (2023). *Access Control Lists: Overview and Guidelines*. Cisco Documentation.

**RFCs y Estándares:**
- RFC 2827: *Network Ingress Filtering: Defeating Denial of Service Attacks*
- RFC 3704: *Ingress Filtering for Multihomed Networks*

**Certificaciones y libros:**
- CCNA 200-301: *Implementing and Administering Cisco Solutions*
- CCNP ENCOR 350-401: *Implementing Cisco Enterprise Network Core Technologies*
- Odom, W. (2023). *CCNA 200-301 Official Cert Guide Library*. Cisco Press.
- Wilkins, S. (2023). *CCNA 200-301 Portable Command Guide*. Cisco Press.

---

**Fecha de elaboración:** Marzo 2026  
**Versión:** 1.0  
**Nivel:** CCNA/ENSA
