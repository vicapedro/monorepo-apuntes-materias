# Examen Práctico: Ruteo Inter-VLAN y Enrutamiento Estático

**Asignatura:** Conmutación y Enrutamiento de Redes de Datos  
**Unidad:** 2. Conmutación de Redes LAN  
**Tipo de evaluación:** Examen práctico grupal  
**Duración:** 4 horas  
**Valor:** 25% de la calificación de la unidad  

---

## Objetivo

Diseñar e implementar una red empresarial multi-sitio con segmentación por VLANs, ruteo inter-VLAN mediante switches multicapa, enlaces troncales redundantes con EtherChannel, configuración de servidores DHCP distribuidos y enrutamiento estático entre sitios. Los estudiantes deberán resolver el problema de forma autónoma documentando sus decisiones técnicas y troubleshooting.

---

## Competencias a Evaluar

- Configura VLANs y enlaces troncales en switches administrables
- Implementa ruteo inter-VLAN en switches multicapa (SVI)
- Configura EtherChannel para redundancia y agregación de ancho de banda
- Implementa servidores DHCP en switches para asignación dinámica de IPs
- Configura enrutamiento estático entre routers
- Administra remotamente dispositivos de red mediante VLANs de gestión
- Documenta incidentes, troubleshooting y soluciones implementadas

---

## Modalidad de Trabajo

- **Equipos:** 6 equipos (uno por rack del laboratorio)
- **Integrantes por equipo:** 4-5 estudiantes
- **Asignación de roles:**
  - Líder de proyecto (coordinación general)
  - Especialista en switching (VLANs, trunking, EtherChannel)
  - Especialista en routing (ruteo inter-VLAN y estático)
  - Especialista en servicios (DHCP, verificación)
  - Documentador (captura evidencias y redacta reporte)

---

## Escenario de Red

**Empresa:** TechCorp Solutions  
**Descripción:** Empresa con dos sedes interconectadas (Sede Norte y Sede Sur) que requieren comunicación entre sus departamentos a través de una WAN simulada.

**Topología de red:** Ver diagrama adjunto en la plataforma LMS (Moodle)

### Características de la Red:

**Dos LANs empresariales idénticas:**
- **Sede Norte** (LAN 1)
- **Sede Sur** (LAN 2)

**Cada LAN incluye:**
- 1 Router (R1 para Norte, R2 para Sur)
- 1 Switch Multicapa (SW-MC1 para Norte, SW-MC2 para Sur)
- 2 Switches de Distribución (SW-Dist1 y SW-Dist2)
- 1 Switch de Acceso donde se configura el servidor DHCP

**Interconexión entre sedes:**
- Los routers R1 y R2 se conectan entre sí simulando una WAN
- Cada switch multicapa se conecta a su router mediante puerto enrutado (routed port)

---

## Especificaciones Técnicas

### 1. Direccionamiento IP

**Red Base Asignada:** `192.168.40.0/24`

**⚠️ IMPORTANTE:** Los IDs de VLAN NO corresponden al tercer octeto de las subredes (dificultad intencional para evaluar comprensión)

#### Sede Norte (LAN 1):

| VLAN | Nombre | ID VLAN | Subred | Gateway |
|------|--------|---------|--------|---------|
| Administración | Admin | 99 | 192.168.40.0/27 | 192.168.40.1 |
| Ventas | Sales | 100 | 192.168.40.32/27 | 192.168.40.33 |
| Sistemas | IT | 101 | 192.168.40.64/27 | 192.168.40.65 |
| Producción | Prod | 102 | 192.168.40.96/27 | 192.168.40.97 |

#### Sede Sur (LAN 2):

| VLAN | Nombre | ID VLAN | Subred | Gateway |
|------|--------|---------|--------|---------|
| Administración | Admin | 99 | 192.168.40.128/27 | 192.168.40.129 |
| Ventas | Sales | 100 | 192.168.40.160/27 | 192.168.40.161 |
| Sistemas | IT | 101 | 192.168.40.192/27 | 192.168.40.193 |
| Producción | Prod | 102 | 192.168.40.224/27 | 192.168.40.225 |

#### Enlace WAN (entre routers):

| Enlace | Red | R1 | R2 |
|--------|-----|----|----|
| Serial/GigabitEthernet | 10.0.0.0/30 | 10.0.0.1 | 10.0.0.2 |

#### Enlaces entre Switch Multicapa y Router (Routed Ports):

**Sede Norte:**
- Red: `172.16.1.0/30`
- SW-MC1: `172.16.1.1`
- R1: `172.16.1.2`

**Sede Sur:**
- Red: `172.16.2.0/30`
- SW-MC2: `172.16.2.1`
- R2: `172.16.2.2`

---

### 2. Configuración de VLANs

**En TODOS los switches de ambas sedes:**

| **VLAN ID** | **Nombre** | **Descripción** |
|-------------|------------|-----------------|
| 99 | Admin | Administración y gestión remota |
| 100 | Sales | Departamento de ventas |
| 101 | IT | Tecnologías de información |
| 102 | Prod | Área de producción |

**Asignación de Puertos en Switches de Acceso:**

Cada switch de acceso debe configurar:
- **Al menos 3-5 puertos** para cada VLAN de usuario (100, 101, 102)
- **Puertos de administración:** VLAN 99
- **Puertos no usados:** Deshabilitar por seguridad

**Nota:** Ajustar la distribución de puertos según el número de interfaces disponibles en cada switch.

---

### 3. Enlaces Troncales (Trunk)

**Configurar enlaces trunk en:**

- Switch Multicapa ↔ Switches de Distribución
- Switches de Distribución ↔ Switches de Acceso
- Entre Switches de Distribución (si aplica según topología)

**Especificaciones:**
- **Protocolo:** IEEE 802.1Q (dot1q)
- **VLAN nativa:** VLAN 99 (Administración)
- **VLANs permitidas:** 99, 100, 101, 102

---

### 4. EtherChannel (Agregación de Enlaces)

**Configurar EtherChannel entre:**

**Ambas sedes:**
- Switch Multicapa ↔ Switch de Distribución 1 (Port-Channel 1)
- Switch Multicapa ↔ Switch de Distribución 2 (Port-Channel 2)

**Especificaciones:**
- **Protocolo:** LACP (Link Aggregation Control Protocol)
- **Número de enlaces por EtherChannel:** 2 interfaces físicas
- **Modo:** Active (LACP activo)
- **Configuración adicional:** El Port-Channel debe funcionar como enlace trunk

**Nota:** Identificar las interfaces físicas disponibles según la topología del LMS.

---

### 5. Ruteo Inter-VLAN (Switches Multicapa)

**En cada switch multicapa:**

1. **Habilitar enrutamiento IP** en el switch
2. **Crear SVIs (Switch Virtual Interfaces)** para cada VLAN
3. **Asignar direcciones IP** según la tabla de direccionamiento (las IPs gateway de cada VLAN)
4. **Configurar puerto enrutado** hacia el router local
5. **Configurar rutas estáticas** hacia las subredes de la otra sede

---

### 6. Servidor DHCP en Switch

**⚠️ REQUISITO ESPECIAL:** El servidor DHCP NO se configura en el switch multicapa, sino en un **switch de acceso específico** indicado en la topología del LMS.

**En el switch designado como servidor DHCP:**

- Configurar **pools DHCP** para las VLANs 100, 101, 102 (NO para VLAN 99)
- Cada pool debe incluir:
  - Red y máscara de la subred
  - Gateway por defecto (la IP del SVI correspondiente)
  - Servidor DNS (usar 8.8.8.8)
- **Excluir direcciones** reservadas para:
  - Gateway (primera IP utilizable)
  - Rango administrativo (primeras 2-3 IPs)

**⚠️ CONFIGURACIÓN CRÍTICA:** 

Como el servidor DHCP está en un switch diferente al switch multicapa que actúa como gateway, se requiere configurar **DHCP relay (ip helper-address)** en las interfaces SVI del switch multicapa para reenviar las solicitudes DHCP broadcast al servidor DHCP.

---

### 7. Configuración de Routers

**Cada router debe configurar:**

1. **Interfaz hacia el switch multicapa:**
   - Asignar IP según tabla de direccionamiento (172.16.x.x)
   
2. **Interfaz WAN hacia el otro router:**
   - Asignar IP según tabla de direccionamiento (10.0.0.x)

3. **Rutas estáticas:**
   - Configurar rutas hacia las 4 subredes de VLANs de la otra sede
   - Next-hop: IP del router remoto en el enlace WAN

---

### 8. Gestión Remota de Switches

**TODOS los switches deben poder administrarse remotamente vía Telnet/SSH desde la VLAN 99 (Administración).**

**Requisitos:**

1. **Asignar IP de gestión** en VLAN 99 a cada switch
2. **Configurar gateway por defecto** en switches de acceso y distribución
3. **Habilitar acceso Telnet/SSH** con contraseñas seguras
4. **Configurar SSH** (opcional pero recomendado para seguridad)

**IPs sugeridas para gestión (Sede Norte como ejemplo):**
- SW-MC1: 192.168.40.1 (ya asignada como SVI)
- SW-Dist1: 192.168.40.2
- SW-Dist2: 192.168.40.3
- SW-Acceso-DHCP: 192.168.40.4

**Repetir esquema similar para Sede Sur usando su subred 192.168.40.128/27**

---

## Requerimientos de Conectividad

Al finalizar la implementación, el equipo debe demostrar:

- [ ] **Conectividad intra-VLAN:** Hosts de la misma VLAN en la misma sede se comunican
- [ ] **Conectividad inter-VLAN:** Hosts de diferentes VLANs en la misma sede se comunican
- [ ] **Conectividad inter-sede:** Hosts de cualquier VLAN de una sede se comunican con hosts de cualquier VLAN de la otra sede
- [ ] **Asignación DHCP funcional:** PCs en VLANs 100, 101, 102 obtienen IPs automáticamente
- [ ] **EtherChannel operativo:** Port-Channel en estado up y balanceando tráfico
- [ ] **Gestión remota:** Todos los switches accesibles vía Telnet/SSH desde VLAN 99
- [ ] **Redundancia:** Al desconectar un enlace del EtherChannel, la conectividad se mantiene

---

## Entregables

### 1. Archivo de Configuraciones (25 puntos)

**Formato:** Archivo de texto `.txt`  
**Nombre:** `Equipo#_Configs.txt`

**Contenido:**
- Configuración completa (`show running-config`) de TODOS los dispositivos:
  - Routers (R1, R2)
  - Switches Multicapa (SW-MC1, SW-MC2)
  - Switches de Distribución (todos)
  - Switches de Acceso (todos)

**Formato sugerido:**
```
! ========================================
! Configuración de [Nombre del Dispositivo]
! ========================================
[Salida del comando show running-config]

! ========================================
! Configuración de [Siguiente Dispositivo]
! ========================================
[...]
```

---

### 2. Reporte Técnico Completo (65 puntos)

**Formato:** PDF  
**Nombre:** `Equipo#_Reporte_Examen_Practico.pdf`

**Estructura del reporte:**

#### Portada (obligatoria)
- Nombre de la institución
- Nombre de la asignatura
- Título: "Examen Práctico - Ruteo Inter-VLAN y Enrutamiento Estático"
- Integrantes del equipo con roles asignados
- Fecha de realización

#### 1. Introducción
- Descripción breve del escenario empresarial
- Objetivos del proyecto de red

#### 2. Diseño de Red
- **Topología:** Diagrama de red (puede ser foto del LMS, captura de Packet Tracer o diagrama en Visio)
- **Tabla de direccionamiento IP completa:** Todas las interfaces de todos los dispositivos
- **Tabla de VLANs:** ID, nombre, subred, gateway
- **Tabla de asignación de puertos:** Qué puertos pertenecen a qué VLANs

#### 3. Configuración Implementada

**Para cada sección explicar brevemente qué se configuró (sin pegar comandos completos):**

3.1 Configuración de VLANs  
3.2 Configuración de Enlaces Trunk y EtherChannel  
3.3 Ruteo Inter-VLAN (SVIs)  
3.4 Servidor DHCP y DHCP Relay  
3.5 Enrutamiento Estático  
3.6 Gestión Remota  

#### 4. Pruebas y Verificación (CRÍTICO - Incluir capturas de pantalla)

**Documentar las siguientes pruebas con:**
- Objetivo de la prueba
- Comando(s) utilizado(s)
- Captura de pantalla del resultado
- Interpretación del resultado

**Pruebas obligatorias:**

| # | Prueba | Comando(s) | Qué demostrar |
|---|--------|------------|---------------|
| 1 | Verificar VLANs creadas | `show vlan brief` | Todas las VLANs creadas en switches |
| 2 | Verificar enlaces trunk | `show interfaces trunk` | Trunks activos con VLANs permitidas |
| 3 | Verificar EtherChannel | `show etherchannel summary` | Port-Channel up con interfaces member |
| 4 | Verificar tabla de rutas en routers | `show ip route` | Rutas estáticas configuradas |
| 5 | Verificar tabla de rutas en switches multicapa | `show ip route` | Rutas conectadas y estáticas |
| 6 | Verificar bindings DHCP | `show ip dhcp binding` | IPs asignadas a clientes |
| 7 | Ping intra-VLAN | `ping <IP>` | Conectividad dentro de la misma VLAN |
| 8 | Ping inter-VLAN (misma sede) | `ping <IP>` | Conectividad entre VLANs en misma sede |
| 9 | Ping inter-sede | `ping <IP>` | Conectividad entre VLANs de diferentes sedes |
| 10 | Traceroute inter-sede | `traceroute <IP>` | Ruta de paquetes entre sedes |
| 11 | Acceso remoto a switch | Telnet/SSH | Conexión exitosa desde VLAN 99 |
| 12 | Verificar obtención DHCP | `ipconfig` o `show ip dhcp binding` | PC obtiene IP automáticamente |

#### 5. Incidentes, Problemas y Soluciones (⚠️ OBLIGATORIO - 10 puntos)

**Tabla de incidentes:**

| # | Descripción del Problema | Síntomas Observados | Diagnóstico Realizado | Solución Implementada | Resultado |
|---|--------------------------|---------------------|------------------------|------------------------|-----------|
| 1 | | | | | |
| 2 | | | | | |
| 3 | | | | | |
| ... | | | | | |

**Requisito mínimo:** Documentar al menos **3 incidentes técnicos reales** encontrados durante la implementación.

**Ejemplos de incidentes comunes:**
- VLANs no comunicándose entre switches
- DHCP no asignando direcciones IP
- Rutas estáticas configuradas incorrectamente
- EtherChannel no formándose (estado down)
- Trunk no permitiendo todas las VLANs necesarias
- Enrutamiento IP no habilitado en switch multicapa
- IP helper-address olvidado en SVIs
- Default gateway incorrecto en switches de acceso
- Puerto enrutado configurado como switchport
- Next-hop incorrecto en rutas estáticas

#### 6. Conclusiones
- Lecciones aprendidas del proyecto
- Principales dificultades encontradas
- Competencias técnicas adquiridas o reforzadas

#### 7. Referencias
- Material de clase consultado
- Documentación de Cisco utilizada
- Comandos de referencia

---

### 3. Demostración en Vivo (10 puntos)

**Durante la sesión de laboratorio, el equipo deberá:**

- Explicar brevemente el diseño de red implementado
- Demostrar conectividad funcional entre hosts de diferentes VLANs y sedes
- Mostrar que DHCP está funcionando correctamente
- Responder preguntas técnicas del instructor sobre las decisiones tomadas
- Explicar cómo resolvieron al menos un problema técnico encontrado

---

## Criterios de Evaluación

### Rúbrica de Evaluación (100 puntos)

| Criterio | Excelente (Máx.) | Bueno (70-90%) | Aceptable (50-69%) | Insuficiente (0-49%) | Puntos |
|----------|------------------|----------------|---------------------|----------------------|--------|
| **1. Configuración de VLANs** | VLANs correctamente creadas en todos los switches, puertos asignados según especificación | VLANs creadas, asignación de puertos con errores menores | VLANs creadas pero asignación incorrecta o incompleta | VLANs no funcionales o no implementadas | **/15** |
| **2. Enlaces Trunk** | Todos los trunks configurados correctamente con VLANs permitidas y VLAN nativa | Trunks funcionales, errores menores en VLAN nativa o permitidas | Algunos trunks no funcionales o mal configurados | Trunking no implementado o no funcional | **/10** |
| **3. EtherChannel** | EtherChannel configurado con LACP, funcional, redundancia probada | EtherChannel funcional, protocolo o modo con errores | EtherChannel parcialmente funcional o sin probar redundancia | EtherChannel no implementado o no funcional | **/10** |
| **4. Ruteo Inter-VLAN** | SVIs correctamente configuradas, comunicación entre VLANs completamente funcional | SVIs configuradas, comunicación con errores menores | Algunas SVIs incorrectas, comunicación parcial | Ruteo inter-VLAN no funcional o no implementado | **/15** |
| **5. Servidor DHCP** | Pools configurados correctamente en switch especificado, DHCP relay funcional, asignación exitosa | DHCP funcional, configuración con errores menores | DHCP parcialmente funcional o sin relay configurado | DHCP no implementado o no funcional | **/10** |
| **6. Enrutamiento Estático** | Rutas estáticas correctas en routers y switches, comunicación inter-sede completamente funcional | Rutas configuradas, comunicación con errores menores | Rutas incompletas o parcialmente incorrectas | Enrutamiento estático no funcional o no implementado | **/10** |
| **7. Gestión Remota** | Todos los switches accesibles remotamente desde VLAN 99 con SSH/Telnet | Mayoría de switches accesibles, configuración con errores menores | Algunos switches accesibles, configuración incompleta | Gestión remota no funcional o no implementada | **/5** |
| **8. Pruebas y Verificación** | Todas las pruebas documentadas con capturas de pantalla, comandos y análisis detallado | Mayoría de pruebas realizadas, documentación adecuada | Pruebas mínimas documentadas, sin análisis | Sin pruebas o documentación insuficiente | **/10** |
| **9. Incidentes y Soluciones** | Tabla completa con 5+ incidentes técnicos reales, diagnóstico y solución detallados | 3-4 incidentes bien documentados | 1-2 incidentes documentados o poca profundidad | Sin documentación de incidentes o incidentes irrelevantes | **/10** |
| **10. Reporte Técnico** | Reporte profesional, completo, bien estructurado, excelente redacción | Reporte completo, estructura adecuada, buena redacción | Reporte básico, información incompleta, redacción aceptable | Reporte deficiente, incompleto o ausente | **/5** |
| **TOTAL** | | | | | **/100** |

---

## Políticas del Examen

### Durante el Examen:

1. **Trabajo en equipo obligatorio:** Todos los integrantes deben participar activamente en la configuración
2. **No se permite copiar configuraciones** de otros equipos (se considera falta académica)
3. **Consulta de material:** Permitido consultar apuntes, comandos de referencia y documentación oficial de Cisco
4. **Consulta al profesor:** Permitida para dudas de interpretación de especificaciones, NO para solución de problemas técnicos
5. **Uso de dispositivos:** Solo se utilizan los dispositivos del rack asignado a su equipo

### Penalizaciones:

- **-10 puntos:** Copia de configuraciones de otro equipo (falta académica grave)
- **-5 puntos:** No guardar configuraciones antes de desconectar equipos
- **-5 puntos:** Entrega fuera de tiempo (por cada 15 minutos de retraso)
- **0 puntos en configuraciones:** No entregar archivo de configuraciones
- **0 puntos en reporte:** No documentar incidentes (sección obligatoria)

### Entrega:

- **Plataforma:** Moodle (subir archivos a la tarea de examen práctico)
- **Formato de archivos:**
  - `Equipo#_Configs.txt` (configuraciones completas)
  - `Equipo#_Reporte_Examen_Practico.pdf` (reporte técnico completo con capturas)
- **Fecha límite:** Al finalizar la sesión de laboratorio (4 horas desde el inicio del examen)
- **Responsable de subir:** Un solo integrante (especificar quién en el reporte)

---

## Recursos de Apoyo

### Comandos de Verificación Útiles:

**VLANs:**
- `show vlan brief`
- `show interfaces trunk`
- `show interfaces <interfaz> switchport`

**EtherChannel:**
- `show etherchannel summary`
- `show etherchannel port-channel`
- `show interfaces port-channel <número>`

**Enrutamiento:**
- `show ip route`
- `show ip interface brief`
- `show ip protocols`

**DHCP:**
- `show ip dhcp pool`
- `show ip dhcp binding`
- `show ip dhcp server statistics`

**Conectividad:**
- `ping <IP>`
- `traceroute <IP>`
- `show cdp neighbors`
- `show interfaces status`

**Troubleshooting:**
- `show running-config`
- `show startup-config`
- `show logging`

---

## Consejos para el Éxito

### Planificación:
1. Lean **completamente** todas las especificaciones antes de configurar
2. Revisen la **topología del LMS** cuidadosamente e identifiquen todos los dispositivos
3. Identifiquen **qué switch es el servidor DHCP** en el diagrama
4. Verifiquen el **cableado físico** antes de configurar
5. Creen una **tabla de direccionamiento** completa antes de empezar

### Implementación:
1. Sigan un **orden lógico:** VLANs → Trunks → EtherChannel → Ruteo → DHCP → Routing
2. **Prueben cada fase** antes de continuar a la siguiente
3. **Guarden configuraciones** (`write` o `copy run start`) después de cada fase exitosa
4. **Documenten problemas** a medida que los encuentran (no al final)

### Troubleshooting:
1. Usen **comandos show** para diagnosticar (no adivinen)
2. Comparen configuraciones con las **especificaciones** del examen
3. Verifiquen la **tabla de enrutamiento** para asegurar que las rutas están presentes
4. Si DHCP no funciona, verifiquen **ip helper-address** en las SVIs

### Trabajo en Equipo:
1. **Comuníquense constantemente** entre roles
2. **Revisen el trabajo** de otros miembros (verificación cruzada)
3. El **documentador** debe estar presente en todas las configuraciones para capturar evidencias
4. No avancen si hay dudas - **consulten entre ustedes primero**

---

## Preguntas Frecuentes

**P: ¿Qué switch actúa como servidor DHCP?**  
R: Está indicado específicamente en la topología adjunta en Moodle. Revisen el diagrama cuidadosamente - es uno de los switches de acceso.

**P: ¿Por qué el servidor DHCP no está en el switch multicapa?**  
R: Es una configuración intencionalmente compleja para evaluar su comprensión de **DHCP relay (ip helper-address)**. En redes reales, los servidores DHCP pueden estar en diferentes segmentos.

**P: ¿Cómo sabemos qué interfaces usar para EtherChannel?**  
R: Consulten la topología específica de su rack en Moodle. Generalmente son 2 interfaces consecutivas (ej: Fa0/23-24 o Gi0/1-2).

**P: ¿Qué pasa si no documentamos incidentes?**  
R: Pierden **10 puntos automáticamente**. Es obligatorio documentar problemas encontrados y cómo los resolvieron. El troubleshooting es parte esencial de la competencia.

**P: ¿Podemos usar Packet Tracer en lugar de equipos físicos?**  
R: **No**, el examen debe realizarse en el laboratorio con los equipos reales asignados a su rack.

**P: ¿Cuántas PCs necesitamos conectar y configurar?**  
R: Al menos **2 PCs por VLAN de usuario** (VLANs 100, 101, 102) - una en cada sede - para poder probar conectividad inter-sede.

**P: ¿Qué pasa si un dispositivo falla durante el examen?**  
R: Reporten **inmediatamente** al profesor. Se evaluará el caso y se proporcionará equipo de reemplazo si está disponible.

**P: ¿Podemos consultar Internet durante el examen?**  
R: Sí, pueden consultar documentación oficial de Cisco y material de clase. No pueden copiar configuraciones completas de otros equipos.

---

## Checklist de Pre-Entrega

**Antes de entregar, verificar:**

### Configuración:
- [ ] Todas las VLANs creadas en todos los switches
- [ ] Enlaces trunk configurados y operativos
- [ ] EtherChannel funcionando (Port-Channel en estado up)
- [ ] SVIs creadas con IPs correctas
- [ ] Ruteo IP habilitado en switches multicapa
- [ ] Pools DHCP configurados
- [ ] IP helper-address configurado en SVIs
- [ ] Hosts obteniendo IPs por DHCP
- [ ] Rutas estáticas configuradas en routers y switches multicapa
- [ ] IPs de gestión asignadas en VLAN 99
- [ ] Telnet/SSH habilitado y funcional
- [ ] **Configuraciones guardadas** en todos los dispositivos

### Conectividad:
- [ ] Ping intra-VLAN funcional
- [ ] Ping inter-VLAN en misma sede funcional
- [ ] Ping inter-sede funcional
- [ ] Acceso remoto a switches desde VLAN 99 funcional

### Documentación:
- [ ] Archivo de configuraciones completo
- [ ] Reporte con todas las secciones
- [ ] Todas las capturas de pantalla incluidas
- [ ] Tabla de incidentes con mínimo 3 problemas documentados
- [ ] Reporte en formato PDF
- [ ] Archivos con nombres correctos (Equipo#...)

---

**¡Buena suerte en el examen!**

**Recuerden:** La documentación de incidentes y soluciones demuestra su capacidad de análisis y troubleshooting, competencias esenciales para un ingeniero en redes.

---

**Última actualización:** Noviembre 2025  
**Asignatura:** Conmutación y Enrutamiento de Redes de Datos
