# Diseño Instruccional - Conmutación y Enrutamiento en Redes de Datos

## Datos de la Asignatura
- **Nombre**: Conmutación y Enrutamiento en Redes de Datos
- **Carrera**: Ingeniería en Tecnologías de la Información y Comunicaciones  
- **Clave**: AED-2103
- **SATCA**: 1-4-5
- **Modalidad**: Presencial
- **Duración**: Un semestre

## Competencia General
Diseñar y configurar redes de área local y amplia con tecnologías de conmutación y enrutamiento para optimizar el rendimiento, seguridad y escalabilidad de las comunicaciones organizacionales.

## Objetivos Específicos por Competencia
1. **Analizar y diseñar esquemas de direccionamiento IP** utilizando técnicas modernas de subnetting y VLSM para optimizar el uso del espacio de direcciones
2. **Implementar tecnologías de conmutación LAN** incluyendo VLANs, VTP y STP para segmentar y optimizar el tráfico de red local
3. **Configurar tecnologías WAN** para interconectar redes geográficamente distribuidas con criterios de eficiencia y confiabilidad
4. **Evaluar e implementar tecnologías inalámbricas** considerando estándares, seguridad y optimización para entornos empresariales

## Matriz de Evidencias

| Actividad | Evidencia | Ponderación | A | B | C | D | E | F | Instrumento |
|-----------|-----------|-------------|---|---|---|---|---|---|-------------|
| Proyecto Integrador de Red Empresarial | Diseño e implementación completa con Packet Tracer + documentación técnica | 45% | 15% | 12% | 8% | 5% | 3% | 2% | Rúbrica |
| Portafolio de Configuraciones de Laboratorio | Reportes técnicos con capturas de Packet Tracer y reflexión | 30% | 8% | 7% | 5% | 4% | 3% | 3% | Lista de cotejo |
| Examen Teórico-Práctico | Resolución de casos de configuración y troubleshooting | 25% | 7% | 6% | 4% | 4% | 1% | 3% | Rúbrica |
| **TOTAL** |  | **100%** | **30%** | **25%** | **17%** | **13%** | **7%** | **8%** |  |

**Indicadores de Impacto:**
- **A**: Adapta a situaciones complejas y contextos
- **B**: Hace contribuciones a las actividades académicas desarrolladas  
- **C**: Propone soluciones/procedimientos no vistos en clase
- **D**: Introduce recursos que promueven pensamiento crítico
- **E**: Incorpora conocimiento interdisciplinario
- **F**: Realiza trabajo autónomo y autorregulado

---

## UNIDAD 1: DIRECCIONAMIENTO IP Y ENRUTAMIENTO
**Duración**: 4 semanas | **Horas**: 20 horas

### Competencia Específica
Analizar y diseñar esquemas de direccionamiento IP utilizando técnicas modernas de subnetting y VLSM para optimizar el uso del espacio de direcciones.

### Objetivos de Aprendizaje
Al finalizar esta unidad, el estudiante será capaz de:
- Analizar las limitaciones del direccionamiento con clase y las ventajas de CIDR
- Aplicar técnicas de VLSM para crear subredes de tamaños variables según necesidades organizacionales
- Configurar enrutamiento estático y dinámico usando protocolos RIP, EIGRP y OSPF
- Implementar esquemas de direccionamiento escalables para redes empresariales

### Matriz de Evidencias - Unidad 1

| Actividad | Evidencia | Ponderación | A | B | C | D | E | F | Instrumento |
|-----------|-----------|-------------|---|---|---|---|---|---|-------------|
| Laboratorios de Direccionamiento (4 prácticas) | Configuraciones Packet Tracer con documentación de subnetting | 35% | 10% | 8% | 5% | 6% | 2% | 4% | Lista de cotejo |
| Proyecto "Red empresarial con VLSM" | Diseño completo de direccionamiento para empresa ficticia | 45% | 12% | 10% | 8% | 6% | 4% | 5% | Rúbrica |
| Configuración de protocolos de enrutamiento | Implementación RIP/EIGRP/OSPF en escenarios complejos | 20% | 8% | 7% | 2% | 1% | 1% | 1% | Lista de cotejo |
| **TOTAL UNIDAD 1** |  | **100%** | **30%** | **25%** | **15%** | **13%** | **7%** | **10%** |  |

**Distribución de Indicadores de Impacto:**
- **A (30%)**: Adaptación a diferentes topologías de red, manejo de escenarios complejos
- **B (25%)**: Colaboración en diseño de redes, contribuciones técnicas en laboratorios
- **C (15%)**: Propuestas de optimización en direccionamiento, soluciones innovadoras
- **D (13%)**: Investigación de nuevos protocolos, herramientas de análisis de red
- **E (7%)**: Aplicación de conceptos matemáticos, principios de telecomunicaciones
- **F (10%)**: Trabajo independiente en configuraciones, resolución autónoma de problemas

### Aplicación del Modelo de Gagné

#### 1. Ganar la Atención
**Estrategia**: Caso real de crisis de red
- Presentar el caso "El colapso de red de una empresa por mal direccionamiento"
- Video: Demostración de una red saturada vs. una red bien segmentada
- Pregunta detonante: ¿Cómo puede un mal diseño de direccionamiento paralizar una empresa?

#### 2. Informar Objetivos
**Actividades del docente**:
- Presentar competencias específicas con ejemplos de redes reales
- Explicar la importancia del direccionamiento en la era de IoT y Cloud Computing
- Mostrar rúbrica enfocada en diseño y implementación práctica

**Actividades del estudiante**:
- Reflexionar sobre experiencias previas con redes domésticas
- Identificar problemas de conectividad vividos

#### 3. Estimular Conocimientos Previos
**Estrategia**: Diagnóstico práctico
- Quiz interactivo sobre conceptos básicos de redes (modelo OSI, TCP/IP)
- Análisis de la configuración de red de sus dispositivos personales
- Discusión sobre diferencias entre redes domésticas y empresariales

#### 4. Presentar Contenido
**Temas y subtemas**:
- 1.1 Direccionamiento IP
  - Limitaciones del direccionamiento con clase
  - Direccionamiento sin clase (CIDR)
  - VLSM para subredes de tamaños variables
  - Direcciones públicas, privadas y reservadas
- 1.2 Enrutamiento estático y dinámico
  - Ventajas y limitaciones de cada método
  - Configuración de rutas estáticas
  - Protocolos dinámicos: características y aplicaciones
- 1.3 Protocolos de enrutamiento
  - RIP: simplicidad para redes pequeñas
  - EIGRP: protocolo híbrido de Cisco
  - OSPF: estándar para redes empresariales
  - BGP: enrutamiento entre sistemas autónomos

#### 5. Proporcionar Orientación
**Metodología**: Aprendizaje basado en simulación
- Uso intensivo de Cisco Packet Tracer para simulaciones
- Demostraciones paso a paso de configuraciones
- Plantillas de configuración y mejores prácticas
- Sesiones de troubleshooting guiado

#### 6. Provocar Desempeño
**Actividades formativas**:
- **Laboratorio 1**: Análisis y diseño de subnetting con VLSM
- **Laboratorio 2**: Configuración de enrutamiento estático en Packet Tracer  
- **Laboratorio 3**: Implementación de RIP y análisis de convergencia
- **Laboratorio 4**: Configuración avanzada EIGRP y OSPF

**Actividad sumativa**: Proyecto "Red empresarial escalable"
- Escenario: Empresa con múltiples sucursales y departamentos
- Requisitos: Direccionamiento VLSM + enrutamiento dinámico + documentación
- Entregable: Archivo Packet Tracer + reporte técnico

#### 7. Proporcionar Retroalimentación
**Estrategias**:
- Revisión en tiempo real de configuraciones en Packet Tracer
- Peer review de diseños de direccionamiento
- Feedback específico sobre optimización de rutas
- Sesiones de Q&A para resolución de dudas técnicas

#### 8. Evaluar Desempeño
**Instrumentos**:
- **Formativa**: Laboratorios con autoevaluación técnica
- **Sumativa**: Proyecto de red empresarial (11.25% de calificación final)
- **Criterios**: Funcionalidad de configuraciones, eficiencia del diseño, documentación técnica

#### 9. Mejorar Retención y Transferencia
**Estrategias**:
- Biblioteca de configuraciones tipo para reutilización
- Conexión con certificaciones Cisco (CCNA)
- Aplicación en proyectos de otras materias (seguridad de redes)
- Preparación para tecnologías de conmutación LAN

---

## UNIDAD 2: CONMUTACIÓN DE REDES LAN
**Duración**: 4 semanas | **Horas**: 20 horas

### Competencia Específica
Implementar tecnologías de conmutación LAN incluyendo VLANs, VTP y STP para segmentar y optimizar el tráfico de red local.

### Objetivos de Aprendizaje
Al finalizar esta unidad, el estudiante será capaz de:
- Analizar dominios de colisión y broadcast para optimizar el rendimiento de red
- Configurar VLANs para segmentación lógica de redes empresariales
- Implementar VTP para gestión centralizada de VLANs
- Aplicar STP para prevenir bucles en topologías redundantes

### Matriz de Evidencias - Unidad 2

| Actividad | Evidencia | Ponderación | A | B | C | D | E | F | Instrumento |
|-----------|-----------|-------------|---|---|---|---|---|---|-------------|
| Laboratorios de Conmutación (4 prácticas) | Configuraciones de switches con VLANs y STP documentadas | 40% | 10% | 9% | 6% | 7% | 4% | 4% | Lista de cotejo |
| Proyecto "Red LAN segmentada" | Implementación completa con VTP y redundancia | 35% | 9% | 8% | 6% | 4% | 4% | 4% | Rúbrica |
| Análisis de rendimiento de red | Comparativa antes/después de segmentación con métricas | 25% | 11% | 8% | 3% | 2% | 1% | 0% | Rúbrica |
| **TOTAL UNIDAD 2** |  | **100%** | **30%** | **25%** | **15%** | **13%** | **9%** | **8%** |  |

**Distribución de Indicadores de Impacto:**
- **A (30%)**: Adaptación a diferentes topologías LAN, manejo de redes complejas
- **B (25%)**: Colaboración en configuraciones grupales, soporte técnico a compañeros
- **C (15%)**: Propuestas de optimización de VLANs, configuraciones innovadoras
- **D (13%)**: Investigación de estándares IEEE, herramientas de monitoreo
- **E (9%)**: Aplicación de principios de ingeniería de tráfico
- **F (8%)**: Configuración independiente de switches, resolución autónoma

### Aplicación del Modelo de Gagné

#### 1. Ganar la Atención
**Estrategia**: Demostración impactante de rendimiento
- Demo en vivo: Red sin VLANs vs. red segmentada (análisis de broadcasts)
- Caso real: "Cómo VLANs salvaron la red de un hospital"
- Pregunta provocadora: ¿Por qué una red plana puede ser un riesgo de seguridad?

#### 2. Informar Objetivos
**Actividades del docente**:
- Explicar el impacto de la conmutación en redes modernas
- Presentar ejemplos de implementaciones empresariales exitosas
- Mostrar criterios de evaluación enfocados en funcionalidad y optimización

**Actividades del estudiante**:
- Analizar la topología de red de su institución educativa
- Identificar posibles mejoras en segmentación

#### 3. Estimular Conocimientos Previos
**Estrategia**: Análisis de topologías existentes
- Repaso de conceptos de capa 2 del modelo OSI
- Análisis de diferencias entre hubs y switches
- Discusión sobre limitaciones de redes planas

#### 4. Presentar Contenido
**Temas y subtemas**:
- 2.1 Segmentación de dominio de colisión y broadcast
  - Conceptos fundamentales de dominios
  - Impacto en el rendimiento de red
  - Ventajas de la segmentación
- 2.2 Métodos de reenvío de tramas
  - Store-and-forward vs. Cut-through
  - Fragment-free switching
  - Análisis de latencia y confiabilidad
- 2.3 Tecnologías de conmutación
  - VLANs: configuración y ventajas
  - VTP: gestión centralizada
  - STP: prevención de bucles

#### 5. Proporcionar Orientación
**Metodología**: Laboratorio intensivo con simulación
- Configuraciones progresivas en Packet Tracer
- Escenarios de troubleshooting real
- Mejores prácticas de naming y documentación
- Plantillas de configuración empresarial

#### 6. Provocar Desempeño
**Actividades formativas**:
- **Laboratorio 5**: Configuración básica de VLANs y trunking
- **Laboratorio 6**: Implementación de VTP en topologías multi-switch
- **Laboratorio 7**: Configuración de STP y análisis de convergencia
- **Laboratorio 8**: Interconexión de VLANs con routing

**Actividad sumativa**: Proyecto "Campus universitario segmentado"
- Escenario: Red de campus con múltiples edificios y departamentos
- Requisitos: VLANs por función + VTP + STP + redundancia
- Entregable: Topología funcional + plan de direccionamiento + configuraciones

#### 7. Proporcionar Retroalimentación
**Estrategias**:
- Análisis en tiempo real del tráfico de red
- Validación cruzada de configuraciones entre equipos
- Feedback sobre eficiencia de diseños de VLAN
- Sesiones de troubleshooting colaborativo

#### 8. Evaluar Desempeño
**Instrumentos**:
- **Formativa**: Configuraciones progresivas con checkpoints
- **Sumativa**: Proyecto de red LAN (15% de calificación final)
- **Criterios**: Funcionalidad, eficiencia, seguridad, documentación

#### 9. Mejorar Retención y Transferencia
**Estrategias**:
- Documentación de comandos y procedimientos
- Análisis comparativo con tecnologías actuales (SDN)
- Preparación para certificaciones de switching
- Conexión con seguridad de redes y tecnologías WAN

---

## UNIDAD 3: TECNOLOGÍAS WAN
**Duración**: 4 semanas | **Horas**: 20 horas

### Competencia Específica
Configurar tecnologías WAN para interconectar redes geográficamente distribuidas con criterios de eficiencia y confiabilidad.

### Objetivos de Aprendizaje
Al finalizar esta unidad, el estudiante será capaz de:
- Analizar diferentes tecnologías WAN y sus casos de uso apropiados
- Configurar conexiones PPP y Frame Relay para enlaces punto a punto
- Implementar VPNs para conectividad segura a través de Internet
- Diseñar topologías WAN considerando redundancia y optimización de costos

### Matriz de Evidencias - Unidad 3

| Actividad | Evidencia | Ponderación | A | B | C | D | E | F | Instrumento |
|-----------|-----------|-------------|---|---|---|---|---|---|-------------|
| Laboratorios de Tecnologías WAN (4 prácticas) | Configuraciones de enlaces WAN con documentación técnica | 30% | 7% | 6% | 4% | 5% | 4% | 4% | Lista de cotejo |
| Proyecto "Red WAN Empresarial" | Diseño e implementación de interconexión multi-sitio | 50% | 15% | 12% | 8% | 6% | 4% | 5% | Rúbrica |
| Análisis comparativo de tecnologías | Evaluación técnica y económica de opciones WAN | 20% | 8% | 7% | 3% | 2% | 1% | -1% | Rúbrica |
| **TOTAL UNIDAD 3** |  | **100%** | **30%** | **25%** | **15%** | **13%** | **9%** | **8%** |  |

**Distribución de Indicadores de Impacto:**
- **A (30%)**: Adaptación a diferentes tecnologías WAN, contextos geográficos diversos
- **B (25%)**: Colaboración en diseños complejos, soporte en configuraciones
- **C (15%)**: Propuestas de topologías optimizadas, soluciones híbridas
- **D (13%)**: Investigación de tendencias WAN (SD-WAN, MPLS), análisis económico
- **E (9%)**: Integración de conceptos de telecomunicaciones y economía
- **F (8%)**: Configuración autónoma de enlaces, gestión independiente de proyectos

### Aplicación del Modelo de Gagné

#### 1. Ganar la Atención
**Estrategia**: Caso de conectividad global
- Presentar el desafío: "Conectar oficinas en 5 países con un presupuesto limitado"
- Video: Evolución de tecnologías WAN (de líneas dedicadas a SD-WAN)
- Pregunta detonante: ¿Cómo eligen las empresas entre costo, velocidad y confiabilidad?

#### 2. Informar Objetivos
**Actividades del docente**:
- Explicar la importancia de WAN en la era del trabajo remoto
- Presentar casos de éxito en diferentes industrias
- Mostrar criterios de evaluación enfocados en viabilidad técnica y económica

**Actividades del estudiante**:
- Analizar las opciones de conectividad en su región
- Reflexionar sobre experiencias con conexiones remotas

#### 3. Estimular Conocimientos Previos
**Estrategia**: Análisis de conectividad actual
- Repaso de diferencias entre LAN, MAN y WAN
- Discusión sobre proveedores de servicios locales
- Análisis de limitaciones geográficas y regulatorias

#### 4. Presentar Contenido
**Temas y subtemas**:
- 3.1 Tecnologías WAN fundamentales
  - Líneas dedicadas (E1/T1, E3/T3)
  - Frame Relay y ATM
  - PPP y configuraciones punto a punto
- 3.2 Tecnologías WAN modernas
  - MPLS y QoS
  - VPN Site-to-Site e IPSec
  - SD-WAN y conectividad híbrida
- 3.3 Diseño de topologías WAN
  - Hub-and-spoke vs. full mesh
  - Análisis de costo-beneficio
  - Redundancia y failover

#### 5. Proporcionar Orientación
**Metodología**: Simulación de escenarios empresariales reales
- Casos de estudio de empresas multinacionales
- Configuraciones en Packet Tracer con topologías complejas
- Análisis de cotizaciones reales de proveedores
- Talleres de diseño colaborativo

#### 6. Provocar Desempeño
**Actividades formativas**:
- **Laboratorio 9**: Configuración de enlaces PPP y Frame Relay
- **Laboratorio 10**: Implementación de VPN Site-to-Site
- **Laboratorio 11**: QoS y optimización de tráfico WAN
- **Laboratorio 12**: Diseño de topología con redundancia

**Actividad sumativa**: Proyecto "Expansión internacional"
- Escenario: Empresa que requiere conectar oficinas en múltiples países
- Requisitos: Análisis de opciones + diseño de topología + configuraciones + presupuesto
- Entregable: Propuesta técnica completa + implementación en Packet Tracer

#### 7. Proporcionar Retroalimentación
**Estrategias**:
- Revisión de factibilidad técnica y económica
- Feedback de expertos de la industria (invitados)
- Evaluación por pares de propuestas WAN
- Análisis de viabilidad con casos reales

#### 8. Evaluar Desempeño
**Instrumentos**:
- **Formativa**: Configuraciones de tecnologías específicas
- **Sumativa**: Proyecto de red WAN (18.75% de calificación final)
- **Criterios**: Viabilidad técnica, optimización económica, implementación funcional

#### 9. Mejorar Retención y Transferencia
**Estrategias**:
- Portafolio de configuraciones WAN
- Conexiones con administración de proyectos
- Análisis de tendencias futuras (5G, satellite networking)
- Preparación para certificaciones WAN

---

## UNIDAD 4: TECNOLOGÍAS INALÁMBRICAS
**Duración**: 4 semanas | **Horas**: 20 horas

### Competencia Específica
Evaluar e implementar tecnologías inalámbricas considerando estándares, seguridad y optimización para entornos empresariales.

### Objetivos de Aprendizaje
Al finalizar esta unidad, el estudiante será capaz de:
- Analizar estándares IEEE 802.11 y sus aplicaciones en diferentes contextos
- Configurar redes inalámbricas empresariales con criterios de seguridad avanzados
- Implementar controladores de acceso inalámbrico para gestión centralizada
- Diseñar topologías inalámbricas considerando cobertura, capacidad y interferencia

### Matriz de Evidencias - Unidad 4

| Actividad | Evidencia | Ponderación | A | B | C | D | E | F | Instrumento |
|-----------|-----------|-------------|---|---|---|---|---|---|-------------|
| Laboratorios de Redes Inalámbricas (4 prácticas) | Configuraciones de infraestructura WLAN documentadas | 25% | 6% | 5% | 3% | 4% | 3% | 4% | Lista de cotejo |
| Proyecto "Campus Inalámbrico Inteligente" | Diseño completo con site survey y optimización | 60% | 18% | 15% | 9% | 7% | 6% | 5% | Rúbrica |
| Site Survey y análisis de espectro | Evaluación de cobertura y calidad de señal | 15% | 6% | 5% | 3% | 2% | 0% | -1% | Lista de cotejo |
| **TOTAL UNIDAD 4** |  | **100%** | **30%** | **25%** | **15%** | **13%** | **9%** | **8%** |  |

**Distribución de Indicadores de Impacto:**
- **A (30%)**: Adaptación a diferentes entornos inalámbricos, manejo de interferencias
- **B (25%)**: Colaboración en proyectos complejos, soporte técnico especializado
- **C (15%)**: Propuestas de optimización de cobertura, soluciones innovadoras
- **D (13%)**: Investigación de nuevos estándares, herramientas de análisis
- **E (9%)**: Integración de principios de física de ondas, regulaciones
- **F (8%)**: Trabajo independiente en site surveys, gestión autónoma de proyectos

### Aplicación del Modelo de Gagné

#### 1. Ganar la Atención
**Estrategia**: Demostración de conectividad ubicua
- Demo: Campus completamente inalámbrico vs. tradicional
- Caso de éxito: "Transformación digital de un aeropuerto"
- Pregunta provocadora: ¿Puede una red inalámbrica ser más confiable que una cableada?

#### 2. Informar Objetivos
**Actividades del docente**:
- Explicar la importancia del Wi-Fi en la era de IoT y movilidad
- Presentar tendencias como Wi-Fi 6 y 7
- Mostrar criterios enfocados en performance y experiencia de usuario

**Actividades del estudiante**:
- Analizar la cobertura inalámbrica en su entorno
- Reflexionar sobre problemas de conectividad móvil

#### 3. Estimular Conocimientos Previos
**Estrategia**: Análisis del ecosistema inalámbrico
- Repaso de conceptos de radiofrecuencia y propagación
- Discusión sobre estándares IEEE 802.11 conocidos
- Análisis de configuraciones domésticas vs. empresariales

#### 4. Presentar Contenido
**Temas y subtemas**:
- 4.1 Estándares inalámbricos IEEE 802.11
  - Evolución desde 802.11a hasta 802.11ax (Wi-Fi 6)
  - Bandas de frecuencia y canales
  - Técnicas de modulación y throughput
- 4.2 Seguridad en redes inalámbricas
  - WEP, WPA, WPA2, WPA3
  - Enterprise authentication (RADIUS, EAP)
  - Mejores prácticas de seguridad
- 4.3 Infraestructura inalámbrica empresarial
  - Access Points autónomos vs. controlados
  - Wireless LAN Controllers (WLC)
  - Site surveys y planning de RF

#### 5. Proporcionar Orientación
**Metodología**: Laboratorio práctico con análisis real
- Configuraciones en equipos reales y Packet Tracer
- Uso de herramientas de site survey
- Análisis de espectro con analizadores
- Mejores prácticas de deployment empresarial

#### 6. Provocar Desempeño
**Actividades formativas**:
- **Laboratorio 13**: Configuración básica de Access Points
- **Laboratorio 14**: Implementación de seguridad WPA2-Enterprise
- **Laboratorio 15**: Site survey y análisis de cobertura
- **Laboratorio 16**: Configuración de Wireless LAN Controller

**Actividad sumativa**: Proyecto "Smart Campus Deployment"
- Escenario: Universidad que requiere cobertura inalámbrica completa
- Requisitos: Site survey + diseño RF + configuraciones + seguridad + IoT
- Entregable: Plan de deployment + configuraciones + análisis de ROI

#### 7. Proporcionar Retroalimentación
**Estrategias**:
- Mediciones reales de señal y throughput
- Feedback sobre optimización de cobertura
- Validación de configuraciones de seguridad
- Análisis de interferencias y mitigación

#### 8. Evaluar Desempeño
**Instrumentos**:
- **Formativa**: Configuraciones progresivas con validación
- **Sumativa**: Proyecto de red inalámbrica (30% de calificación final)
- **Criterios**: Cobertura efectiva, seguridad implementada, optimización de performance

#### 9. Mejorar Retención y Transferencia
**Estrategias**:
- Portafolio de configuraciones inalámbricas
- Conexiones con IoT y ciudades inteligentes
- Preparación para certificaciones wireless (CWNA)
- Análisis de tecnologías emergentes (Wi-Fi 7, 6GHz)

---

## Integración de Matrices de Evidencias por Unidad

### Resumen de Distribución por Indicadores de Impacto

| Unidad | Peso en Curso | A | B | C | D | E | F | Total Unidad |
|--------|---------------|---|---|---|---|---|---|--------------|
| **Unidad 1**: Direccionamiento y Enrutamiento (25% del curso) | 25% | 7.5% | 6.3% | 3.8% | 3.3% | 1.8% | 2.5% | 25% |
| **Unidad 2**: Conmutación LAN (30% del curso) | 30% | 9.0% | 7.5% | 4.5% | 3.9% | 2.7% | 2.4% | 30% |
| **Unidad 3**: Tecnologías WAN (37.5% del curso) | 37.5% | 11.3% | 9.4% | 5.6% | 4.9% | 3.4% | 3.0% | 37.5% |
| **Unidad 4**: Tecnologías Inalámbricas (60% del curso) | 7.5% | 2.3% | 1.9% | 1.1% | 1.0% | 0.7% | 0.6% | 7.5% |
| **TOTAL CURSO** |  | **30%** | **25%** | **15%** | **13%** | **8.6%** | **8.5%** | **100%** |

### Instrumentos de Evaluación por Unidad

| Unidad | Rúbricas | Listas de Cotejo | Evaluación Práctica | Proyectos Integradores |
|--------|----------|------------------|---------------------|----------------------|
| **Unidad 1** | Proyecto VLSM | Laboratorios + Configuraciones | Protocolos enrutamiento | Red empresarial escalable |
| **Unidad 2** | Proyecto LAN + Análisis rendimiento | Laboratorios conmutación | Configuraciones VTP/STP | Campus universitario |
| **Unidad 3** | Proyecto WAN + Análisis comparativo | Laboratorios tecnologías | Enlaces punto a punto | Expansión internacional |
| **Unidad 4** | Proyecto campus inalámbrico | Laboratorios + Site survey | Configuraciones WLAN | Smart campus deployment |

### Evidencias Principales por Competencia

#### Competencia 1: Direccionamiento IP y Enrutamiento
- **Evidencia clave**: Diseño de red empresarial con VLSM + protocolos dinámicos
- **Peso**: 25% del curso total
- **Instrumento principal**: Rúbrica técnica para evaluación de diseño y funcionalidad

#### Competencia 2: Conmutación LAN  
- **Evidencia clave**: Red LAN segmentada con VLANs + análisis de rendimiento
- **Peso**: 30% del curso total
- **Instrumento principal**: Rúbrica enfocada en optimización y documentación

#### Competencia 3: Tecnologías WAN
- **Evidencia clave**: Propuesta de conectividad WAN multi-sitio + análisis económico
- **Peso**: 37.5% del curso total  
- **Instrumento principal**: Rúbrica de viabilidad técnica y económica

#### Competencia 4: Tecnologías Inalámbricas
- **Evidencia clave**: Diseño de campus inalámbrico + site survey + configuraciones
- **Peso**: 7.5% del curso total
- **Instrumento principal**: Lista de cotejo técnica + rúbrica de proyecto

### Cronograma de Evaluaciones

| Semana | Unidad | Actividad Evaluativa | Tipo | Peso |
|--------|--------|---------------------|------|------|
| 1-4 | 1 | Laboratorios direccionamiento (continuo) | Formativa | 0% |
| 4 | 1 | Proyecto red empresarial + configuraciones | Sumativa | 25% |
| 5-8 | 2 | Laboratorios conmutación (continuo) | Formativa | 0% |
| 8 | 2 | Proyecto LAN segmentada + análisis | Sumativa | 30% |
| 9-12 | 3 | Laboratorios WAN (continuo) | Formativa | 0% |
| 12 | 3 | Proyecto expansión internacional | Sumativa | 37.5% |
| 13-16 | 4 | Laboratorios inalámbricos + site survey | Formativa | 0% |
| 16 | 4 | Proyecto smart campus | Sumativa | 7.5% |

---

## Recursos de Apoyo

### Tecnológicos
- **Simulador principal**: Cisco Packet Tracer (versión más reciente)
- **LMS**: Moodle para entrega de configuraciones y foros técnicos
- **Comunicación**: Microsoft Teams para soporte técnico y colaboración
- **Documentación**: GitHub para versionado de configuraciones
- **Herramientas adicionales**: Wireshark para análisis de protocolos, herramientas de site survey

### Equipamiento de Laboratorio
- **Switches**: Equipos Cisco reales para configuraciones avanzadas
- **Routers**: Dispositivos con soporte para protocolos dinámicos
- **Access Points**: Equipos inalámbricos empresariales para laboratorios
- **Analizadores**: Herramientas de medición de espectro y señal

### Bibliografía Complementaria
- Odom, W. CCNA 200-301 Official Cert Guide. Cisco Press. 2019
- Lammle, T. CCNA Complete Study Guide. Sybex. 2020
- Graziani, R. Routing and Switching Essentials Companion Guide. Cisco Press. 2014
- White, R. Optimal Routing Design. Cisco Press. 2005

### Evaluación del Curso
- **Diagnóstica**: Evaluación de conocimientos previos en redes (0%)
- **Formativa**: Laboratorios prácticos y configuraciones (0%)
- **Sumativa**: 
  - Proyecto Direccionamiento y Enrutamiento: 25%
  - Proyecto Conmutación LAN: 30%
  - Proyecto Tecnologías WAN: 37.5%
  - Proyecto Tecnologías Inalámbricas: 7.5%

### Consideraciones Técnicas y Profesionales
- **Certificaciones**: Preparación para CCNA y certificaciones wireless
- **Estándares**: Adherencia a mejores prácticas de la industria
- **Seguridad**: Implementación de configuraciones seguras por defecto
- **Escalabilidad**: Diseños que consideren crecimiento futuro
- **Sostenibilidad**: Optimización energética y uso eficiente de recursos
