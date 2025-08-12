# Evidencia de Producto: Diseño e Implementación de Red LAN Segmentada

## Datos Generales
- **Asignatura**: Conmutación y Enrutamiento en Redes de Datos
- **Unidad**: 2. Conmutación de Redes LAN
- **Competencia Específica**: Implementar tecnologías de conmutación LAN incluyendo VLANs, VTP y STP para segmentar y optimizar el tráfico de red local
- **Tipo de Evidencia**: Producto
- **Modalidad**: Grupal (2-3 integrantes)
- **Duración**: 3 semanas
- **Valor**: 35% de la calificación de la Unidad 2

---

## Descripción de la Evidencia

### Contexto del Problema
La empresa "TechSolutions Inc." ha experimentado un crecimiento significativo y actualmente opera con una red plana que presenta los siguientes problemas:

- **Alto tráfico de broadcast**: La red tiene más de 200 dispositivos en un solo dominio de broadcast
- **Colisiones frecuentes**: Los hubs heredados están causando degradación del rendimiento
- **Problemas de seguridad**: Todos los departamentos pueden acceder a recursos de otros departamentos
- **Gestión compleja**: Los cambios en la red afectan a toda la infraestructura
- **Rendimiento degradado**: Los usuarios reportan lentitud en aplicaciones críticas

### Escenario Empresarial
TechSolutions Inc. tiene los siguientes departamentos con sus respectivos requisitos:

| Departamento | Usuarios | Dispositivos Adicionales | Requisitos Especiales |
|--------------|----------|--------------------------|----------------------|
| **Administración** | 15 | 2 servidores, 3 impresoras | Alta seguridad, acceso restringido |
| **Desarrollo** | 25 | 5 servidores de desarrollo | Alto ancho de banda, acceso a internet |
| **Ventas** | 20 | 4 impresoras, 1 servidor CRM | Acceso a base de datos de clientes |
| **Soporte Técnico** | 10 | 2 servidores de tickets | Acceso a todas las VLANs para soporte |
| **Invitados/Visitantes** | 15 | WiFi público | Acceso limitado solo a internet |
| **Infraestructura** | - | 3 servidores, equipos de red | Gestión centralizada |

### Objetivos de la Evidencia
1. **Analizar** la problemática de la red actual y proponer una solución de segmentación
2. **Diseñar** una topología de red segmentada usando VLANs y tecnologías de conmutación
3. **Implementar** la solución en Cisco Packet Tracer con configuraciones funcionales
4. **Documentar** el proceso completo con justificación técnica y económica
5. **Evaluar** el impacto de la segmentación en el rendimiento y seguridad

---

## Entregables Requeridos

### 1. Documento Técnico (Formato PDF)
**Estructura mínima:**
- Portada con datos del equipo
- Índice detallado
- Resumen ejecutivo (1 página)
- Análisis de la problemática actual
- Propuesta de solución técnica
- Diseño de topología con justificación
- Plan de direccionamiento IP y VLANs
- Configuraciones de dispositivos
- Análisis comparativo antes/después
- Conclusiones y recomendaciones
- Referencias bibliográficas

### 2. Archivo de Simulación (Cisco Packet Tracer)
**Contenido requerido:**
- Topología completa implementada
- Configuraciones aplicadas a todos los dispositivos
- VLANs configuradas según el diseño
- Pruebas de conectividad documentadas
- Etiquetado claro de todos los elementos

### 3. Presentación Ejecutiva (PowerPoint/PDF)
**Duración**: 15 minutos + 5 minutos de preguntas
**Contenido**:
- Problemática identificada
- Solución propuesta
- Demostración en vivo de la simulación
- Resultados obtenidos
- ROI y beneficios empresariales

---

## Especificaciones Técnicas

### Requisitos Mínimos de la Solución

#### Topología de Red
- Mínimo **3 switches** de capa 2 con capacidad VLAN
- **1 router** para interconexión entre VLANs
- **1 servidor** por departamento crítico
- Enlaces **redundantes** para alta disponibilidad
- **Documentación** gráfica clara con estándares profesionales

#### Configuración de VLANs
| VLAN ID | Nombre | Red IP | Dispositivos | Propósito |
|---------|--------|--------|--------------|-----------|
| 10 | Admin | 192.168.10.0/24 | 20 | Administración |
| 20 | Desarrollo | 192.168.20.0/24 | 32 | Desarrollo software |
| 30 | Ventas | 192.168.30.0/24 | 25 | Equipo comercial |
| 40 | Soporte | 192.168.40.0/24 | 15 | Soporte técnico |
| 50 | Invitados | 192.168.50.0/24 | 20 | Acceso temporal |
| 99 | Gestión | 192.168.99.0/24 | 10 | Infraestructura |

#### Configuraciones Requeridas
1. **VLANs**: Configuración en todos los switches
2. **Trunking**: Enlaces entre switches con protocolos 802.1Q
3. **VTP**: Gestión centralizada de VLANs (opcional)
4. **STP**: Prevención de bucles en topologías redundantes
5. **Inter-VLAN Routing**: Router-on-a-stick o switch de capa 3
6. **Seguridad básica**: Port security, DHCP snooping (opcional)

### Criterios de Funcionalidad
- **Conectividad**: Todos los dispositivos deben poder comunicarse según políticas
- **Segmentación**: Dominios de broadcast separados por VLAN
- **Rendimiento**: Reducción measurable de tráfico broadcast
- **Redundancia**: Tolerancia a fallas de enlaces
- **Escalabilidad**: Capacidad para agregar nuevas VLANs/dispositivos

---

## Solución Paso a Paso

### Fase 1: Análisis y Planificación (Semana 1)

#### Paso 1: Análisis de la Red Actual
```markdown
**Problemas identificados:**
1. Dominio de broadcast único con 200+ dispositivos
2. Uso de hubs (tecnología obsoleta)
3. Sin segmentación de tráfico
4. Gestión centralizada imposible
5. Vulnerabilidades de seguridad

**Métricas actuales estimadas:**
- Utilización de ancho de banda: 60-80%
- Colisiones por segundo: 50-100
- Broadcasts por minuto: 200-500
- Tiempo de respuesta promedio: 150-300ms
```

#### Paso 2: Definición de Requisitos
```markdown
**Requisitos funcionales:**
- Separación por departamentos
- Control de acceso entre VLANs
- Alta disponibilidad (99.5%)
- Escalabilidad para 50% más dispositivos
- Gestión centralizada

**Requisitos no funcionales:**
- Presupuesto máximo: $50,000 USD
- Tiempo de implementación: 2 semanas
- Capacitación mínima requerida
- Compatibilidad con equipos existentes
```

#### Paso 3: Diseño de la Topología
```
[Internet]
    |
[Router Principal] - 192.168.1.1/24
    |
[Switch Core] - VLAN Trunk
   / | \
[SW1] [SW2] [SW3] - Access Switches
  |     |     |
[Depto] [Depto] [Depto]
```

### Fase 2: Configuración e Implementación (Semana 2)

#### Paso 4: Configuración del Switch Core
```cisco
! Configuración básica
hostname SW-CORE
enable secret cisco123

! Creación de VLANs
vlan 10
 name Admin
vlan 20
 name Desarrollo  
vlan 30
 name Ventas
vlan 40
 name Soporte
vlan 50
 name Invitados
vlan 99
 name Gestion

! Configuración de interfaces trunk
interface FastEthernet0/1
 switchport mode trunk
 switchport trunk allowed vlan all
 
interface FastEthernet0/2
 switchport mode trunk
 switchport trunk allowed vlan all

interface FastEthernet0/3
 switchport mode trunk
 switchport trunk allowed vlan all

! IP de gestión
interface vlan 99
 ip address 192.168.99.10 255.255.255.0
 no shutdown

! Gateway por defecto
ip default-gateway 192.168.99.1
```

#### Paso 5: Configuración de Switches de Acceso
```cisco
! Switch de Administración (SW1)
hostname SW-ADMIN
enable secret cisco123

! Configuración de puertos de acceso
interface range FastEthernet0/1-15
 switchport mode access
 switchport access vlan 10
 switchport port-security
 switchport port-security maximum 2

! Puerto hacia el core
interface FastEthernet0/24
 switchport mode trunk
 switchport trunk allowed vlan 10,99

! IP de gestión  
interface vlan 99
 ip address 192.168.99.11 255.255.255.0
 no shutdown

ip default-gateway 192.168.99.1
```

#### Paso 6: Configuración del Router (Inter-VLAN)
```cisco
hostname ROUTER-CORE
enable secret cisco123

! Configuración de subinterfaces
interface FastEthernet0/0.10
 encapsulation dot1Q 10
 ip address 192.168.10.1 255.255.255.0

interface FastEthernet0/0.20
 encapsulation dot1Q 20
 ip address 192.168.20.1 255.255.255.0

interface FastEthernet0/0.30
 encapsulation dot1Q 30
 ip address 192.168.30.1 255.255.255.0

interface FastEthernet0/0.40
 encapsulation dot1Q 40
 ip address 192.168.40.1 255.255.255.0

interface FastEthernet0/0.50
 encapsulation dot1Q 50  
 ip address 192.168.50.1 255.255.255.0

interface FastEthernet0/0.99
 encapsulation dot1Q 99
 ip address 192.168.99.1 255.255.255.0

! Activar interfaz principal
interface FastEthernet0/0
 no shutdown

! Configuración de enrutamiento (opcional)
ip route 0.0.0.0 0.0.0.0 [ISP_GATEWAY]
```

### Fase 3: Pruebas y Validación (Semana 3)

#### Paso 7: Pruebas de Conectividad
```markdown
**Pruebas requeridas:**
1. Ping dentro de la misma VLAN ✓
2. Ping entre VLANs (solo si permitido) ✓
3. Acceso a internet desde todas las VLANs ✓
4. Funcionamiento de STP ✓
5. Redundancia de enlaces ✓

**Comandos de verificación:**
- show vlan brief
- show interfaces trunk  
- show spanning-tree
- show ip route
- ping [IP_destino]
```

#### Paso 8: Análisis de Rendimiento
```markdown
**Métricas objetivo post-implementación:**
- Reducción de tráfico broadcast: 80%
- Eliminación de colisiones: 100%
- Mejora en tiempo de respuesta: 60%
- Disponibilidad objetivo: 99.5%
- Facilidad de gestión: Alta
```

#### Paso 9: Documentación Final
```markdown
**Elementos a documentar:**
1. Diagrama de topología actualizado
2. Tabla de direccionamiento completa  
3. Configuraciones finales de todos los dispositivos
4. Manual de operación y mantenimiento
5. Procedimientos de troubleshooting
6. Plan de respaldo y recuperación
```

---

## Rúbrica de Evaluación

### Indicadores de Alcance para Rúbrica

Según el Manual de Evaluación ASERTUM, la rúbrica debe evaluar **desempeños** y **productos** con los siguientes indicadores de alcance:

**Nivel 4 - Excelente (3 puntos)**: Supera las expectativas, demuestra dominio completo
**Nivel 3 - Bueno (2 puntos)**: Cumple satisfactoriamente con los estándares esperados  
**Nivel 2 - Aceptable (1 punto)**: Cumple mínimamente con los requisitos básicos
**Nivel 1 - Insuficiente (0 puntos)**: No cumple con los estándares mínimos

### Instrumento de Evaluación: Rúbrica Analítica

| Criterio de Evaluación | Excelente (3) | Bueno (2) | Aceptable (1) | Insuficiente (0) | Peso |
|------------------------|---------------|-----------|---------------|------------------|------|
| **1. Análisis Técnico de la Problemática** | Identifica todos los problemas de la red actual con análisis profundo, métricas específicas y comprensión completa del impacto empresarial. Propone soluciones innovadoras no vistas en clase. | Identifica la mayoría de problemas con análisis adecuado y métricas generales. Comprende el impacto y propone soluciones apropiadas basadas en lo visto en clase. | Identifica problemas básicos con análisis superficial. Comprensión limitada del impacto. Propone soluciones básicas. | No identifica correctamente los problemas o el análisis es erróneo. No comprende el impacto o no propone soluciones viables. | **20%** |
| **2. Diseño de Topología y Arquitectura** | Diseño altamente optimizado que supera los requisitos. Topología escalable con redundancia completa. Uso creativo de tecnologías de conmutación. Documentación profesional excepcional. | Diseño que cumple todos los requisitos con topología funcional y bien documentada. Implementa redundancia básica y usa correctamente las tecnologías. | Diseño básico que cumple requisitos mínimos. Topología funcional simple con documentación básica. Implementación estándar de tecnologías. | Diseño deficiente que no cumple requisitos. Topología no funcional o mal documentada. Uso incorrecto de tecnologías. | **25%** |
| **3. Implementación en Packet Tracer** | Simulación completamente funcional con configuraciones avanzadas. Todos los dispositivos operando correctamente. Pruebas exhaustivas documentadas. Manejo experto de la herramienta. | Simulación funcional con configuraciones correctas. La mayoría de dispositivos operan correctamente. Pruebas básicas completadas. Buen manejo de la herramienta. | Simulación básica funcional con configuraciones mínimas. Algunos dispositivos operan correctamente. Pruebas limitadas. Manejo básico de la herramienta. | Simulación no funcional o con errores críticos. Configuraciones incorrectas. Sin pruebas o pruebas fallidas. Manejo inadecuado de la herramienta. | **25%** |
| **4. Configuraciones de Red** | Configuraciones optimizadas con mejores prácticas de seguridad. Implementa características avanzadas (VTP, STP, port security). Código limpio y bien documentado. | Configuraciones correctas que cumplen todos los requisitos. Implementa características básicas correctamente. Código funcional con documentación adecuada. | Configuraciones básicas funcionales que cumplen requisitos mínimos. Implementación estándar. Código con documentación limitada. | Configuraciones incorrectas o no funcionales. No implementa características requeridas. Código mal documentado o erróneo. | **15%** |
| **5. Documentación Técnica** | Documentación técnica excepcional, completa y profesional. Incluye análisis económico detallado, diagramas profesionales y manual operativo completo. Redacción impecable. | Documentación técnica completa y bien estructurada. Incluye elementos esenciales con buena presentación y redacción clara. | Documentación técnica básica que cumple requisitos mínimos. Estructura simple con presentación adecuada. | Documentación técnica incompleta, mal estructurada o de baja calidad. Falta elementos esenciales. | **10%** |
| **6. Presentación Oral y Dominio del Tema** | Presentación excepcional con dominio completo del tema. Responde preguntas complejas con confianza. Demuestra comprensión profunda y capacidad de aplicación. | Presentación clara con buen dominio del tema. Responde la mayoría de preguntas correctamente. Demuestra comprensión sólida. | Presentación básica con dominio limitado. Responde preguntas simples. Comprensión superficial del tema. | Presentación deficiente con dominio insuficiente. No responde preguntas o respuestas incorrectas. No demuestra comprensión. | **5%** |
| **CALIFICACIÓN TOTAL** |  |  |  |  | **100%** |

### Escala de Calificación Final

| Puntuación Total | Calificación | Nivel de Desempeño |
|------------------|--------------|-------------------|
| 15.0 - 18.0 | 9.0 - 10.0 | Excelente |
| 12.0 - 14.9 | 7.0 - 8.9 | Bueno |
| 9.0 - 11.9 | 6.0 - 6.9 | Aceptable |
| 0.0 - 8.9 | 0.0 - 5.9 | Insuficiente |

### Criterios Específicos de Evaluación

#### Aspectos Técnicos Críticos
- **Funcionalidad**: La simulación debe ser 100% funcional
- **Configuraciones**: Sintaxis correcta de comandos Cisco IOS
- **Segmentación**: Separación efectiva de dominios de broadcast
- **Conectividad**: Pruebas exitosas de comunicación inter-VLAN
- **Redundancia**: Implementación correcta de STP

#### Aspectos de Documentación
- **Completitud**: Todos los elementos solicitados presentes
- **Claridad**: Redacción técnica clara y precisa
- **Profesionalismo**: Formato estándar de documentos técnicos
- **Justificación**: Argumentos técnicos sólidos para decisiones
- **Viabilidad**: Propuestas realistas y implementables

#### Aspectos de Presentación
- **Tiempo**: Respeto a los límites de tiempo establecidos
- **Claridad**: Comunicación efectiva de conceptos técnicos
- **Dominio**: Conocimiento profundo del tema presentado
- **Interacción**: Capacidad de responder preguntas técnicas
- **Profesionalismo**: Presentación formal y estructurada

---

## Recursos de Apoyo

### Herramientas Requeridas
- **Cisco Packet Tracer** (versión 8.0 o superior)
- **Microsoft Office** o Google Workspace
- **Draw.io** o Visio para diagramas
- **Acceso a documentación oficial de Cisco**

### Bibliografía Recomendada
- Odom, W. (2019). CCNA 200-301 Official Cert Guide. Cisco Press.
- Lammle, T. (2020). CCNA Complete Study Guide. Sybex.
- Cisco Systems. (2021). LAN Switching and Wireless, CCNA Exploration Companion Guide.

### Cronograma Sugerido
- **Semana 1**: Análisis, planificación y diseño inicial
- **Semana 2**: Implementación en Packet Tracer y configuraciones  
- **Semana 3**: Pruebas, documentación final y preparación de presentación
- **Entrega**: Viernes de la semana 3 antes de las 23:59 hrs

### Criterios de Entrega
- **Formato digital**: Todos los archivos en carpeta comprimida
- **Nomenclatura**: Apellido1_Apellido2_EvidenciaU2_Grupo#
- **Plataforma**: Subida a Moodle en la sección correspondiente
- **Respaldo**: Los equipos deben conservar copia de todos los archivos

---

## Competencias e Indicadores de Impacto Evaluados

### Indicadores de Impacto del Perfil de Egreso TecNM

| Indicador | Descripción | Evidencia en el Producto |
|-----------|-------------|-------------------------|
| **A** - Adapta a situaciones complejas y contextos | Diseño de red que se adapta a necesidades específicas de diferentes departamentos y escenarios empresariales complejos | Análisis diferenciado por departamento, soluciones contextualizadas |
| **B** - Hace contribuciones a actividades académicas | Participación activa en trabajo colaborativo, contribuciones técnicas significativas al proyecto grupal | Trabajo en equipo documentado, roles definidos, contribuciones individuales |
| **C** - Propone soluciones/procedimientos no vistos en clase | Implementación de características avanzadas o configuraciones optimizadas más allá del contenido básico | Configuraciones avanzadas, propuestas de mejora innovadoras |
| **D** - Introduce recursos que promueven pensamiento crítico | Análisis comparativo, evaluación de alternativas, justificación de decisiones técnicas | Análisis costo-beneficio, comparación de tecnologías, decisiones fundamentadas |
| **E** - Incorpora conocimiento interdisciplinario | Integración de aspectos económicos, administrativos y técnicos en la solución | Análisis de ROI, consideraciones organizacionales, impacto empresarial |
| **F** - Realiza trabajo autónomo y autorregulado | Gestión independiente del proyecto, cumplimiento de cronograma, calidad autoregulada | Cronograma cumplido, calidad consistente, gestión autónoma documentada |

### Competencias Genéricas Desarrolladas
1. **Capacidad de análisis y síntesis**: A través del análisis de problemáticas complejas de red
2. **Resolución de problemas**: Mediante el diseño de soluciones técnicas viables  
3. **Trabajo en equipo**: Por medio de la colaboración en proyectos grupales
4. **Comunicación efectiva**: A través de la documentación técnica y presentaciones
5. **Pensamiento crítico**: Mediante la evaluación de alternativas y toma de decisiones
6. **Aprendizaje autónomo**: Por medio de la investigación independiente y autoregulación

Esta evidencia de producto integra conocimientos teóricos con aplicación práctica, promoviendo el desarrollo de competencias profesionales alineadas con las necesidades de la industria de redes y telecomunicaciones.
