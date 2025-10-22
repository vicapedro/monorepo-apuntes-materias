# Examen Práctico - Enrutamiento Dinámico

## Objetivo
Implementar una topología de red multi-regional utilizando protocolos de enrutamiento dinámico y demostrar conectividad completa entre todas las regiones mediante Packet Tracer.

---

## Modalidad de Trabajo
**Equipos de 4 personas** - Cada integrante será responsable de implementar una región completa.

---

## Descripción del Ejercicio

### Topología a Implementar
Deberá implementar la topología adjunta en Packet Tracer según el **protocolo de enrutamiento asignado por el profesor**:
- 🔵 **RIP** (Routing Information Protocol)
- 🟢 **EIGRP** (Enhanced Interior Gateway Routing Protocol)
- 🟠 **OSPF** (Open Shortest Path First - Monoárea únicamente)


### Estructura de la Red
La topología contiene **4 redes regionales**, cada una asignada a un integrante del equipo:

| Región | Responsable | Router de Interconexión |
|--------|-------------|-------------------------|
| 🐱 **Gatos** | Integrante 1 | Puma |
| 🐘 **Elefantes** | Integrante 2 | Mamut |
| 🐋 **Cetáceos** | Integrante 3 | Beluga |
| 🦜 **Aves** | Integrante 4 | Loro |

En el diagrama proporcionado, **cada switch tiene un número debajo** que indica la **cantidad de hosts requeridos en esa subred**. Utilice estos valores para calcular correctamente las máscaras de subred usando VLSM.


---

## Requisitos Técnicos

### 1. **Direccionamiento IP con VLSM**
- Utilice **VLSM (Variable Length Subnet Mask)** para optimizar el uso de direcciones IP
- El **número de red global** será proporcionado por el profesor al momento del examen
- El profesor indicará si trabajará con **IPv4 o IPv6**

### 2. **Configuración de Routers**
- Asigne a cada router el **nombre correspondiente** según la topología (Puma, Mamut, Beluga, Loro, etc.)
- Configure el **protocolo de enrutamiento asignado** en todos los routers
- Utilice **rutas por defecto (default route)** únicamente donde tenga sentido técnico
- **Nota importante**: En este curso, OSPF solo cubre **configuración monoárea**

### 3. **Dispositivos Finales**
- En cada subred debe haber **al menos 1 PC configurada** correctamente
- Todas las PCs deben estar listas para **recibir paquetes desde cualquier otra subred**
- Configure direcciones IP, máscaras de subred y gateways predeterminados

### 4. **Interconexión Multi-Usuario**
- Las 4 regiones se interconectarán utilizando el **elemento Multiuser de Packet Tracer**
- ⚠️ **IMPORTANTE**: Al realizar la interconexión multiusuario, se **pierde la capacidad de simulación** de Packet Tracer
- **Verifique completamente su región individual** antes de proceder con la interconexión

---

## Entregables

### **Archivo 1: Reporte en PDF**
El reporte debe incluir la siguiente información **para cada región**:

#### **Esquema de Direccionamiento**
- [ ] Tabla completa con direcciones de cada subred (red, máscara, rango utilizable)
- [ ] Direcciones IP asignadas a cada interfaz de cada router
- [ ] Gateway predeterminado de cada subred

#### **Capturas de Pantalla**
- [ ] Captura de la topología completa en Packet Tracer (vista lógica)
- [ ] Capturas de las configuraciones relevantes de los routers

#### 🔍 **Pruebas de Conectividad**
Desde la **PC más extrema de una región**, ejecutar **traceroute** hacia cada una de las **PCs más extremas de las otras regiones**:
- [ ] Traceroute Región 1 → Región 2
- [ ] Traceroute Región 1 → Región 3  
- [ ] Traceroute Región 1 → Región 4

**Total: 3 pruebas de traceroute por región** (puede elegir cualquier región como origen)

#### **Tablas de Enrutamiento**
- [ ] Captura de la tabla de enrutamiento (`show ip route` o `show ipv6 route`) de los **routers de interconexión** de cada región:
  - Router Puma (Gatos)
  - Router Mamut (Elefantes)
  - Router Beluga (Cetáceos)
  - Router Loro (Aves)

### **Archivo 2: Archivos .PKT**
- [ ] **Cuatro archivos .PKT** (uno por región), nombrados claramente:
  - `Region_Gatos.pkt`
  - `Region_Elefantes.pkt`
  - `Region_Cetaceos.pkt`
  - `Region_Aves.pkt`

---

## Rúbrica de Evaluación

### **Criterio 1: Diseño de Direccionamiento (25 puntos)**

| Nivel | Puntos | Descripción |
|-------|--------|-------------|
| **Excelente** | 25 | Esquema VLSM **óptimo** con cero desperdicio de direcciones. Documentación completa y clara de todas las subredes, interfaces y gateways. Uso correcto de direcciones de red, broadcast y rangos utilizables. |
| **Bueno** | 18 | Esquema VLSM **funcional** con desperdicio mínimo (<10% de direcciones). Documentación completa pero con errores menores de formato. Direccionamiento correcto en todos los dispositivos. |
| **Suficiente** | 10 | Esquema de direccionamiento **funciona pero no usa VLSM** óptimamente (desperdicio >20%). Documentación incompleta o con errores. Algunos dispositivos con direcciones incorrectas que requieren corrección. |

### **Criterio 2: Configuración de Protocolos de Enrutamiento (30 puntos)**

| Nivel | Puntos | Descripción |
|-------|--------|-------------|
| **Excelente** | 30 | Protocolo de enrutamiento **configurado correctamente** en todos los routers. Rutas óptimas establecidas. Uso apropiado de rutas por defecto. Convergencia rápida. Tablas de enrutamiento completas y correctas. |
| **Bueno** | 21 | Protocolo configurado en todos los routers con **funcionalidad completa**, pero con configuraciones subóptimas (métricas, timers, etc.). Rutas por defecto configuradas pero no en todos los puntos necesarios. |
| **Suficiente** | 12 | Protocolo configurado pero con **errores que afectan parcialmente** la conectividad. Algunas rutas faltantes o incorrectas. Convergencia lenta. Tablas de enrutamiento incompletas. |

### **Criterio 3: Pruebas de Conectividad (20 puntos)**

| Nivel | Puntos | Descripción |
|-------|--------|-------------|
| **Excelente** | 20 | **Todas las pruebas de traceroute exitosas** (3/3). Muestra la ruta completa esperada. Capturas de pantalla claras y legibles. Tiempos de respuesta razonables. Documentación correcta de cada salto. |
| **Bueno** | 14 | **2 de 3 pruebas de traceroute exitosas**. Rutas mostradas son correctas. Capturas de pantalla adecuadas. Un destino no alcanzable o con problemas intermitentes. |
| **Suficiente** | 8 | **1 de 3 pruebas de traceroute exitosa**. Capturas de pantalla presentes pero con problemas de legibilidad. Múltiples destinos no alcanzables. Rutas mostradas incompletas o incorrectas. |

### **Criterio 4: Documentación y Presentación (15 puntos)**

| Nivel | Puntos | Descripción |
|-------|--------|-------------|
| **Excelente** | 15 | Reporte **profesional y completo**: Todas las capturas de pantalla claras, tablas bien formateadas, nomenclatura consistente. Incluye introducción, metodología y conclusiones. Sin errores ortográficos. Archivos .PKT bien organizados y nombrados. |
| **Bueno** | 11 | Reporte **completo** con todos los elementos requeridos. Capturas de pantalla adecuadas. Formato consistente con errores menores. Faltan algunos elementos secundarios (introducción o conclusiones). Archivos .PKT correctamente nombrados. |
| **Suficiente** | 6 | Reporte **básico** que incluye elementos mínimos requeridos. Capturas de pantalla de baja calidad o poco claras. Formato inconsistente. Faltan secciones importantes. Archivos .PKT sin nomenclatura clara. |

### **Criterio 5: Trabajo en Equipo y Coordinación (10 puntos)**

| Nivel | Puntos | Descripción |
|-------|--------|-------------|
| **Excelente** | 10 | **Integración perfecta** entre las 4 regiones. Esquema de direccionamiento coordinado sin conflictos. Interconexión Multiuser funcional al primer intento. Evidencia de planeación colaborativa (convenciones de nombres, estándares). |
| **Bueno** | 7 | Integración **funcional** con ajustes menores durante la interconexión. Un conflicto de direccionamiento resuelto rápidamente. Coordinación adecuada entre integrantes. Algunas inconsistencias en nomenclatura. |
| **Suficiente** | 4 | Integración **problemática** con múltiples conflictos de direccionamiento. Requirió reconfiguración significativa durante la interconexión. Poca evidencia de coordinación previa. Nomenclatura inconsistente entre regiones. |

---

## Calificación Total

| Criterio | Puntos Máximos |
|----------|----------------|
| Diseño de Direccionamiento | 25 |
| Configuración de Protocolos de Enrutamiento | 30 |
| Pruebas de Conectividad | 20 |
| Documentación y Presentación | 15 |
| Trabajo en Equipo y Coordinación | 10 |
| **TOTAL** | **100** |

---

## ⚠️ Notas Importantes

1. **Verificación previa**: Pruebe completamente su región individual antes de la interconexión Multiuser
2. **Pérdida de simulación**: Una vez conectado en modo Multiuser, NO podrá usar el modo simulación de Packet Tracer
3. **Coordinación**: Establezcan convenciones de nombres y rangos de direccionamiento antes de comenzar
4. **Tiempo**: Administre su tiempo considerando la complejidad de la configuración y las pruebas
5. **Respaldo**: Guarde versiones de respaldo de su archivo .PKT antes de la interconexión

---

## 🎓 Criterios de Aprobación

- **Calificación mínima**: 70 puntos (60%)
- **Conectividad mínima requerida**: Al menos 1 prueba de traceroute exitosa
- **Entrega completa**: Reporte PDF + 4 archivos .PKT

**¡Buena suerte en su examen práctico!** 



