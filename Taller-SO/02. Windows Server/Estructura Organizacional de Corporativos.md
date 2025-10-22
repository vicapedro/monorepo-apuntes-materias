# Estructura Organizacional de Corporativos

## Guía de Referencia para Implementación de Unidades Organizacionales en Active Directory

---

## Introducción

Este documento proporciona una referencia detallada sobre cómo se organizan los corporativos con presencia nacional en México, para ser utilizada como base en la implementación de **Unidades Organizacionales (OU)** en **Active Directory**.

### Objetivo

Comprender la estructura organizacional real de empresas con múltiples sucursales para poder:
- Diseñar una jerarquía de OUs coherente
- Aplicar políticas de grupo (GPOs) apropiadas por nivel
- Implementar delegación de permisos efectiva
- Organizar usuarios, equipos y recursos lógicamente

### Principios de Organización Corporativa

Un corporativo con presencia nacional debe equilibrar:
1. **Estandarización**: Procesos y políticas uniformes en todo el país
2. **Adaptación local**: Flexibilidad para responder a mercados regionales
3. **Control centralizado**: Decisiones estratégicas en casa matriz
4. **Operación descentralizada**: Ejecución eficiente a nivel local

---

## Modelo de Organización Corporativa

### Estructura Jerárquica de 3 Niveles

```
CORPORATIVO (Nivel Nacional)
    │
    ├── REGIONAL (Zonas Geográficas)
    │       │
    │       └── SUCURSALES (Unidades de Negocio)
```

### Representación Visual

```
┌─────────────────────────────────────────┐
│     CORPORATIVO - Nivel Nacional        │
│        (Ciudad de México)               │
│  • Estrategia y Dirección General       │
│  • Finanzas, IT, Legal, RRHH Corp.      │
└───────────┬─────────────────────────────┘
            │
    ┌───────┴────────┬──────────────┬──────────────┐
    ▼                ▼              ▼              ▼
┌─────────┐    ┌──────────┐   ┌──────────┐   ┌──────────┐
│  ZONA   │    │  ZONA    │   │  ZONA    │   │  ZONA    │
│  NORTE  │    │  CENTRO  │   │  SUR     │   │ SURESTE  │
│(Monterrey)   │  (CDMX)  │   │(Guadalajara) │(Mérida)  │
└────┬────┘    └────┬─────┘   └────┬─────┘   └────┬─────┘
     │              │              │              │
  ┌──┴──┬──┐     ┌──┴──┬──┐    ┌──┴──┬──┐    ┌──┴──┬──┐
  ▼     ▼  ▼     ▼     ▼  ▼    ▼     ▼  ▼    ▼     ▼  ▼
Tijuana MTY CHI  CDMX QRO PUE  GDL  MOR COL  MID CUN VER
(Sucursales en cada ciudad)
```

---

## División Geográfica en México

### Modelo por Zonas Geográficas (5-7 Regiones)

| **Zona** | **Estados Cubiertos** | **Sede Regional** | **Población Aprox.** |
|----------|----------------------|-------------------|----------------------|
| **Norte** | Baja California, Sonora, Chihuahua, Coahuila, Nuevo León, Tamaulipas | Monterrey | 25 millones |
| **Noroeste** | Baja California Sur, Sinaloa, Durango | Culiacán | 5 millones |
| **Centro-Occidente** | Jalisco, Nayarit, Colima, Michoacán, Guanajuato | Guadalajara | 18 millones |
| **Centro** | CDMX, Estado de México, Querétaro, Hidalgo, Tlaxcala, Puebla, Morelos | Ciudad de México | 32 millones |
| **Sur** | Guerrero, Oaxaca, Chiapas | Oaxaca | 10 millones |
| **Sureste** | Veracruz, Tabasco, Campeche, Yucatán, Quintana Roo | Mérida | 15 millones |
| **Bajío** | Aguascalientes, Zacatecas, San Luis Potosí | Querétaro | 8 millones |

### Modelo Simplificado (4 Zonas)

**Para corporativos medianos:**

| **Zona** | **Estados** | **Sede** |
|----------|-------------|----------|
| **Norte** | Todo el norte desde Baja California hasta Tamaulipas | Monterrey |
| **Centro** | Del Bajío a CDMX (incluye zona metropolitana) | Ciudad de México |
| **Occidente** | Pacífico centro (Jalisco, Nayarit, Colima, Michoacán) | Guadalajara |
| **Sur-Sureste** | De Guerrero a Quintana Roo | Mérida o Cancún |

---

## Organigrama Corporativo Típico

### Nivel 1: Corporativo Nacional

```
                    ┌─────────────────────┐
                    │  Director General   │
                    │       (CEO)         │
                    └──────────┬──────────┘
                               │
        ┌──────────┬───────────┼────────────┬──────────┬──────────┐
        │          │           │            │          │          │
    ┌───▼───┐  ┌───▼───┐  ┌───▼────┐  ┌───▼───┐  ┌───▼───┐  ┌───▼───┐
    │  CFO  │  │  COO  │  │  CMO   │  │  CIO  │  │ CHRO  │  │  CLO  │
    │Finanzas│ │ Ops.  │  │Marketing│ │  IT   │  │ RRHH  │  │ Legal │
    └───────┘  └───┬───┘  └────────┘  └───────┘  └───────┘  └───────┘
                   │
          ┌────────┼────────┬──────────┐
          │        │        │          │
      ┌───▼───┐┌───▼───┐┌───▼───┐ ┌───▼────┐
      │ Zona  ││ Zona  ││ Zona  │ │  Zona  │
      │ Norte ││Centro ││  Sur  │ │Sureste │
      └───────┘└───────┘└───────┘ └────────┘
```

### Áreas Corporativas Centralizadas

#### Áreas Estratégicas (100% Centralizadas)

**Estas funciones se manejan EXCLUSIVAMENTE desde casa matriz:**

1. **Dirección General y Planeación Estratégica**
   - Definición de objetivos corporativos
   - Planeación estratégica a 3-5 años
   - Relaciones con accionistas

2. **Finanzas y Contraloría Corporativa**
   - Tesorería nacional
   - Auditoría interna
   - Relaciones con inversionistas
   - Planeación financiera
   - Control presupuestal corporativo

3. **Desarrollo de Productos/Servicios**
   - Investigación y desarrollo (I+D)
   - Innovación
   - Diseño de productos/servicios

4. **Marketing y Marca Nacional**
   - Estrategia de marca corporativa
   - Publicidad nacional
   - Campañas corporativas
   - Posicionamiento de marca

5. **Tecnología de Información (TI/IT)**
   - Infraestructura tecnológica nacional
   - Sistemas corporativos (ERP, CRM, Active Directory)
   - Ciberseguridad
   - Arquitectura de sistemas
   - Políticas de TI

6. **Legal Corporativo**
   - Cumplimiento regulatorio
   - Contratos corporativos
   - Propiedad intelectual
   - Litigios estratégicos

7. **Recursos Humanos Corporativos**
   - Políticas de compensación
   - Desarrollo organizacional
   - Capacitación corporativa
   - Cultura organizacional
   - Relaciones laborales estratégicas

8. **Compras Corporativas**
   - Negociación con proveedores estratégicos
   - Contratos marco
   - Economías de escala

---

## Nivel Regional - Estructura Mixta

### Organigrama de Región Típica

```
┌────────────────────────────────┐
│    Director Regional /         │
│      Gerente Zonal             │
│  (Responsable P&L Regional)    │
└───────────┬────────────────────┘
            │
    ┌───────┼───────┬────────┬────────┬────────┐
    │       │       │        │        │        │
┌───▼───┐┌──▼───┐┌──▼────┐┌──▼────┐┌──▼────┐┌──▼────┐
│Ventas ││RRHH  ││Logística││Servicio││Finanzas││Marketing│
│Regional││Regional││Regional││Regional││Regional││Regional│
└───────┘└──────┘└───────┘└───────┘└───────┘└───────┘
    │
    └─── Supervisores de Sucursales
              │
              └─── Sucursales (8-15 por supervisor)
```

### Áreas que SE REPLICAN en Regiones

**Cada zona regional tiene estas áreas (70-80% de funciones):**

#### 1. **Dirección Regional**
- **Director Regional / Gerente Zonal**
  - Responsable de Resultados (P&L) de la región
  - Implementa estrategia nacional con adaptación local
  - Reporta a Director de Operaciones (COO) Corporativo

#### 2. **Ventas y Desarrollo Comercial Regional**
- Equipos de ventas locales
- Supervisores de sucursales (cada uno supervisa 8-15 tiendas)
- Ejecutivos de cuenta corporativos regionales
- Promotores y merchandising regional
- **Reporta a**: CMO Corporativo (matricialmente) y Director Regional

#### 3. **Recursos Humanos Regional**
- Reclutamiento y selección local
- Nómina regional
- Relaciones laborales locales
- Capacitación operativa
- Administración de personal
- **Reporta a**: CHRO Corporativo (matricialmente) y Director Regional

#### 4. **Logística y Distribución Regional**
- Centro de distribución regional (CEDIS)
- Gestión de inventarios regionales
- Transporte y última milla
- Almacenes regionales
- **Reporta a**: COO Corporativo (matricialmente) y Director Regional

#### 5. **Servicio al Cliente Regional**
- Call center regional (en algunos casos)
- Soporte técnico local
- Gestión de quejas y reclamaciones
- **Reporta a**: COO Corporativo (matricialmente) y Director Regional

#### 6. **Finanzas Regional (Parcial)**
- Control de gastos regionales
- Administración de cuentas por cobrar
- Reportes financieros regionales
- Análisis de rentabilidad por sucursal
- **Reporta a**: CFO Corporativo (matricialmente) y Director Regional

#### 7. **Marketing Regional (Parcial)**
- Campañas locales (dentro de lineamientos corporativos)
- Promociones regionales
- Eventos locales
- Relaciones públicas regionales
- **Reporta a**: CMO Corporativo (matricialmente) y Director Regional

#### 8. **TI Regional (Soporte)**
- Soporte técnico local (helpdesk)
- Instalación y mantenimiento de equipos
- Administración de infraestructura regional
- **Reporta a**: CIO Corporativo (matricialmente) y Director Regional

---

## Nivel Sucursal - Operación Local

### Organigrama de Sucursal Típica

```
┌────────────────────────┐
│  Gerente de Sucursal   │
│ (Reporta a Supervisor  │
│      Regional)         │
└──────────┬─────────────┘
           │
    ┌──────┼──────┬──────┐
    │      │      │      │
┌───▼────┐ │  ┌───▼────┐ │
│Subgerente│ │ │ Caja/  │ │
│Operativo│ │  │Admón.  │ │
└───┬────┘ │  └────────┘ │
    │      │             │
┌───▼────┐ │         ┌───▼────┐
│Personal│ │         │Personal│
│Operativo│         │Ventas  │
└────────┘          └────────┘
```

### Personal Típico por Sucursal

**Estructura básica (varía según tamaño y giro):**

1. **Gerente de Sucursal**
   - Responsable de resultados de la unidad
   - Reporta a Supervisor Regional
   - Ejecuta políticas corporativas y regionales

2. **Subgerente / Supervisor Operativo**
   - Apoyo en operación diaria
   - Cubre ausencias del gerente

3. **Personal de Ventas**
   - Vendedores / Ejecutivos de cuenta
   - Asesores de ventas
   - Promotores

4. **Personal Operativo / Técnico**
   - Operadores
   - Técnicos
   - Personal de producción/servicio
   - (Según el giro del negocio)

5. **Personal Administrativo**
   - Cajeros
   - Recepcionistas
   - Administrativos

6. **Personal de Apoyo**
   - Limpieza (puede ser outsourcing)
   - Mantenimiento (puede ser outsourcing)
   - Seguridad (puede ser outsourcing)

### Funciones que NO Existen a Nivel Sucursal

❌ **Estas áreas NO se replican en sucursales:**

- **Contabilidad**: Se hace en Regional o Corporativo
- **RRHH completo**: Solo ejecución básica (asistencias, incidencias)
- **Marketing estratégico**: Solo ejecución de campañas ya diseñadas
- **Compras estratégicas**: Solo pedidos de reposición
- **IT estratégico**: Solo soporte de primer nivel
- **Legal**: Ninguna función legal
- **Finanzas corporativas**: Solo manejo de caja chica
- **Desarrollo de producto**: Ninguna función de I+D

---

## 📊 Matriz de Decisión: ¿Qué se Centraliza vs. Descentraliza?

### Tabla de Funciones por Nivel

| **Función** | **Nivel** | **Razón Principal** | **% Centralización** |
|-------------|-----------|---------------------|----------------------|
| **Estrategia y Planeación** | 🔴 Corporativo | Visión unificada a largo plazo | 100% |
| **Finanzas y Tesorería** | 🔴 Corporativo | Control financiero y liquidez | 95% |
| **IT e Infraestructura** | 🔴 Corporativo | Estandarización y seguridad | 90% |
| **Marca y Publicidad Nacional** | 🔴 Corporativo | Consistencia de marca | 90% |
| **Compras Corporativas** | 🔴 Corporativo | Economías de escala | 85% |
| **Legal y Compliance** | 🔴 Corporativo | Cumplimiento normativo | 95% |
| **Desarrollo de Producto** | 🔴 Corporativo | Innovación centralizada | 90% |
| **RRHH Estratégico** | 🔴 Corporativo | Cultura y políticas uniformes | 70% |
| **Ventas y Desarrollo Comercial** | 🔵 Regional | Cercanía al cliente | 20% |
| **RRHH Operativo** | 🔵 Regional | Conocimiento del mercado laboral local | 30% |
| **Logística y Distribución** | 🔵 Regional | Eficiencia en última milla | 40% |
| **Marketing Local** | 🔵 Regional | Adaptación al mercado regional | 30% |
| **Servicio al Cliente** | 🔵 Regional | Atención cercana y personalizada | 40% |
| **Finanzas Operativas** | 🔵 Regional | Control de gastos locales | 30% |
| **Operación Diaria** | 🟢 Sucursal | Atención directa al cliente | 5% |
| **Ventas Directas** | 🟢 Sucursal | Contacto cara a cara | 10% |
| **Servicio Local** | 🟢 Sucursal | Ejecución en punto de venta | 10% |

---

## 🏢 Ejemplos de Estructuras Reales en México

### Ejemplo 1: OXXO (Retail - Tiendas de Conveniencia)

#### **Nivel Corporativo (FEMSA Comercio - Monterrey)**
- Dirección General México
- CFO, COO, CMO, CIO Corporativos
- Desarrollo de formato y operación
- Compras centralizadas (negociación con Coca-Cola, Bimbo, etc.)
- TI centralizada (sistema de punto de venta unificado)
- Centro de operaciones nacional

#### **Nivel Regional (7 Zonas Operativas)**

| **Zona** | **Sede** | **Estados Cubiertos** | **Sucursales Aprox.** |
|----------|----------|----------------------|----------------------|
| Norte | Monterrey | NL, Coahuila, Tamaulipas | 2,500 |
| Occidente | Guadalajara | Jalisco, Nayarit, Colima | 2,000 |
| Centro | Ciudad de México | CDMX, EdoMex, Hidalgo | 3,500 |
| Bajío | Querétaro | Guanajuato, Querétaro, SLP | 1,800 |
| Pacífico | Culiacán | Sinaloa, Sonora, BC | 1,500 |
| Sureste | Mérida | Yucatán, Quintana Roo, Campeche | 1,200 |
| Sur | Puebla/Oaxaca | Puebla, Veracruz, Oaxaca, Guerrero | 1,500 |

**Cada Región tiene:**
- Director Regional
- Gerentes de zona (subdivisión por ciudades)
- Supervisores de tienda (cada uno supervisa 8-12 tiendas)
- Centro de distribución regional (CEDIS)
- Equipo de RRHH regional (reclutamiento masivo)

#### **Nivel Sucursal (Más de 21,000 tiendas)**
- 1 Gerente de tienda
- 1 Subgerente
- 4-6 empleados por turno (operación 24/7)
- **NO tienen**: Contador, RRHH, Comprador (todo centralizado)
- **Sistema**: POS (punto de venta) conectado en tiempo real a corporativo

---

### Ejemplo 2: BBVA México (Banca - Sector Regulado)

#### **Nivel Corporativo (Ciudad de México)**

**Áreas Altamente Centralizadas (por regulación CNBV):**
- Dirección General México
- **Cumplimiento y Riesgos** (regulación estricta)
- Tesorería y finanzas corporativas
- Crédito corporativo (aprobaciones centralizadas)
- Innovación y transformación digital
- Seguridad de la información
- Legal y cumplimiento
- Marketing y marca nacional

#### **Nivel Regional (7 Divisiones Territoriales)**

| **División** | **Sede** | **Estados** |
|--------------|----------|-------------|
| Noroeste | Hermosillo | BC, BCS, Sonora, Sinaloa |
| Norte | Monterrey | Coahuila, Nuevo León, Tamaulipas |
| Occidente | Guadalajara | Jalisco, Nayarit, Colima, Michoacán |
| Bajío | León | Guanajuato, Querétaro, Aguascalientes |
| Centro | CDMX | CDMX, EdoMex, Morelos, Hidalgo |
| Centro Sur | Puebla | Puebla, Tlaxcala, Veracruz |
| Sur | Mérida | Yucatán, Quintana Roo, Campeche, Tabasco, Chiapas |

**Cada División Territorial tiene:**
- **Director Territorial** (responsable de P&L regional)
- **Banca de Empresas Regional**: Ejecutivos para clientes corporativos
- **Banca Personal y PYME Regional**: Atención a personas físicas
- **Operaciones y servicios**: Back office regional
- **RRHH Regional**: Reclutamiento local (solo operativo)
- **Centro de atención telefónica** (en algunas regiones)

#### **Nivel Sucursal (Más de 1,800 sucursales)**
- **Gerente de Sucursal** (reporta a Director Territorial)
- **Subgerente**
- **Ejecutivos de cuenta** (banca personal, empresas, PYME)
- **Cajeros y servicio al cliente**
- **Personal de seguridad** (outsourcing)
- **Promotores** (tarjetas, créditos)

**Lo que NO existe en sucursal:**
- ❌ Departamento de crédito (evaluación centralizada en regional/corporativo)
- ❌ RRHH estratégico (solo ejecutan políticas)
- ❌ Contabilidad (100% centralizada)
- ❌ Marketing (solo ejecutan campañas nacionales/regionales)
- ❌ Compliance (centralizado por regulación)

---

### Ejemplo 3: Liverpool (Retail - Departamental)

#### **Nivel Corporativo (Ciudad de México)**
- Dirección General
- Compras centralizadas (negociación con marcas internacionales)
- Marketing y publicidad nacional
- IT corporativo (sistema de inventarios en tiempo real)
- Logística corporativa
- RRHH corporativo
- Finanzas corporativas

#### **Nivel Regional (4 Zonas)**
- **Norte**: Monterrey
- **Centro**: CDMX
- **Occidente**: Guadalajara
- **Sureste**: Mérida

**Cada región:**
- Gerente Regional
- Centro de distribución regional
- Supervisores de tienda
- Equipo de visual merchandising regional

#### **Nivel Tienda (Aprox. 120 tiendas)**
- Gerente de tienda
- Subgerentes por departamento (Moda, Hogar, Electrónica, etc.)
- Jefes de piso
- Vendedores especializados
- Cajeros
- Personal de servicios (empacadores, limpieza)

---

## Aplicación a Active Directory

### Diseño de OUs Basado en Estructura Organizacional

#### Opción 1: Organización Geográfica (Recomendada para Corporativos Multi-Sucursal)

```
miempresa.com (Dominio raíz)
│
├── Corporativo (OU)
│   ├── Direccion_General
│   ├── Finanzas
│   ├── Recursos_Humanos
│   ├── Tecnologias_Informacion
│   ├── Marketing
│   ├── Legal
│   └── Compras
│
├── Zona_Norte (OU)
│   ├── Administracion_Regional
│   ├── Ventas_Regional
│   ├── RRHH_Regional
│   ├── Logistica_Regional
│   ├── Sucursal_Monterrey
│   ├── Sucursal_Tijuana
│   └── Sucursal_Chihuahua
│
├── Zona_Centro (OU)
│   ├── Administracion_Regional
│   ├── Ventas_Regional
│   ├── RRHH_Regional
│   ├── Logistica_Regional
│   ├── Sucursal_CDMX_Centro
│   ├── Sucursal_CDMX_Sur
│   └── Sucursal_Queretaro
│
├── Zona_Sur (OU)
│   ├── Administracion_Regional
│   ├── Ventas_Regional
│   ├── RRHH_Regional
│   ├── Logistica_Regional
│   ├── Sucursal_Guadalajara
│   └── Sucursal_Oaxaca
│
└── Zona_Sureste (OU)
    ├── Administracion_Regional
    ├── Ventas_Regional
    ├── RRHH_Regional
    ├── Logistica_Regional
    ├── Sucursal_Merida
    └── Sucursal_Cancun
```

#### Opción 2: Organización Funcional (Para Empresas Centralizadas)

```
miempresa.com
│
├── Finanzas (OU)
│   ├── Usuarios_Finanzas_Corporativo
│   ├── Usuarios_Finanzas_Regional
│   └── Equipos_Finanzas
│
├── Recursos_Humanos (OU)
│   ├── Usuarios_RRHH_Corporativo
│   ├── Usuarios_RRHH_Regional
│   └── Equipos_RRHH
│
├── Ventas (OU)
│   ├── Usuarios_Ventas_Corporativo
│   ├── Usuarios_Ventas_Regional
│   ├── Usuarios_Ventas_Sucursales
│   └── Equipos_Ventas
│
├── Tecnologia (OU)
│   ├── Administradores_TI
│   ├── Soporte_Tecnico
│   ├── Servidores
│   └── Equipos_TI
│
└── Operaciones (OU)
    ├── Usuarios_Operaciones
    └── Equipos_Operaciones
```

#### Opción 3: Organización Híbrida (Más Común)

```
miempresa.com
│
├── Usuarios (OU)
│   ├── Corporativo (OU)
│   │   ├── Ejecutivos
│   │   ├── Finanzas
│   │   ├── RRHH
│   │   ├── Tecnologia
│   │   ├── Marketing
│   │   └── Legal
│   │
│   ├── Zona_Norte (OU)
│   │   ├── Administracion
│   │   ├── Ventas
│   │   └── Operaciones
│   │
│   ├── Zona_Centro (OU)
│   │   ├── Administracion
│   │   ├── Ventas
│   │   └── Operaciones
│   │
│   └── Zona_Sur (OU)
│       ├── Administracion
│       ├── Ventas
│       └── Operaciones
│
├── Equipos (OU)
│   ├── Servidores
│   ├── Estaciones_Trabajo
│   │   ├── Corporativo
│   │   ├── Regional
│   │   └── Sucursales
│   ├── Portatiles
│   └── Dispositivos_Moviles
│
├── Grupos (OU)
│   ├── Grupos_Seguridad
│   ├── Grupos_Distribucion
│   └── Grupos_Aplicaciones
│
└── Recursos_Compartidos (OU)
    ├── Impresoras
    └── Carpetas_Compartidas
```

---

## Mejores Prácticas para Diseño de OUs

### 1. **Principios de Diseño**

**Diseñar pensando en delegación de permisos**
- Crear OUs que reflejen cómo se delegarán los permisos
- Ejemplo: OU "Zona_Norte" permite delegar administración a equipo de TI regional

**Evitar estructura demasiado profunda**
- Máximo 5-7 niveles de profundidad
- Más niveles = más complejidad en GPOs

**Planear para GPOs**
- Agrupar objetos que necesitarán las mismas políticas
- Ejemplo: Todas las sucursales de una zona pueden compartir GPO de seguridad

**Separar usuarios de equipos**
- Facilita aplicación de GPOs específicas
- Mejora claridad organizacional

### 2. **Convenciones de Nomenclatura**

**Recomendaciones:**
- Usar guiones bajos en lugar de espacios: `Zona_Norte` mejor que `Zona Norte`
- Nombres descriptivos pero concisos: `Finanzas_Regional` mejor que `Departamento_de_Finanzas_de_la_Region`
- Evitar caracteres especiales: áéíóú, ñ, #, @
- Usar prefijos para identificar tipo de OU cuando sea útil

**Ejemplos:**
```
OU_Corporativo
OU_Regional_Norte
OU_Sucursal_MTY
GRP_Ventas_Norte (para grupos de seguridad)
PC_Finanzas_01 (para equipos)
```

### 3. **Delegación de Permisos por Nivel**

| **Nivel** | **Quién administra** | **Permisos delegados** |
|-----------|---------------------|------------------------|
| **Corporativo** | Administradores de dominio | Control total |
| **Regional** | Administrador de TI regional | Crear/eliminar usuarios, resetear contraseñas, unir equipos al dominio |
| **Sucursal** | Gerente de sucursal (limitado) | Solo resetear contraseñas de su sucursal |

### 4. **Políticas de Grupo (GPO) Típicas por Nivel**

#### GPOs Corporativas (aplican a todo el dominio)
- Políticas de contraseñas
- Configuración de firewall de Windows
- Windows Update (WSUS)
- Antivirus corporativo
- Configuración de escritorio base

#### GPOs Regionales
- Impresoras regionales
- Servidores de archivos regionales
- Scripts de mapeo de unidades
- Configuraciones de proxy regional

#### GPOs de Sucursal
- Impresoras locales
- Carpetas compartidas locales
- Configuraciones específicas de punto de venta

---

## Ejercicios Prácticos

### Ejercicio 1: Diseño de Estructura de OUs

**Escenario:**
Una cadena de farmacias tiene:
- Casa matriz en Guadalajara
- 3 regiones: Occidente (10 sucursales), Centro (15 sucursales), Norte (8 sucursales)
- Departamentos corporativos: Finanzas, RRHH, IT, Compras
- Cada sucursal tiene: 1 gerente, 2 farmacéuticos, 3 cajeros

**Tarea:**
Diseñar la estructura completa de OUs en Active Directory

---

### Ejercicio 2: Aplicación de GPOs

**Escenario:**
Usando la estructura del Ejercicio 1, definir:
- 3 GPOs corporativas
- 2 GPOs por región
- 1 GPO por sucursal tipo

**Tarea:**
Documentar qué configuraciones incluiría cada GPO y a qué OUs se aplicarían

---

### Ejercicio 3: Delegación de Permisos

**Escenario:**
En la estructura del Ejercicio 1:
- Administrador corporativo de TI
- 3 Técnicos de TI regionales (1 por región)
- Gerentes de sucursal

**Tarea:**
Definir qué permisos delegaría a cada rol y sobre qué OUs

---

## Resumen: Checklist de Implementación

### Planificación

- [ ] Identificar niveles organizacionales (Corporativo, Regional, Sucursal)
- [ ] Mapear departamentos y áreas funcionales
- [ ] Definir zonas geográficas
- [ ] Listar todas las sucursales por zona
- [ ] Identificar requisitos de delegación de permisos
- [ ] Planear GPOs necesarias por nivel

### Diseño de OUs

- [ ] Crear diagrama de estructura de OUs
- [ ] Validar profundidad (máx. 5-7 niveles)
- [ ] Definir convenciones de nomenclatura
- [ ] Separar usuarios, equipos y grupos
- [ ] Documentar propósito de cada OU

### Implementación en AD

- [ ] Crear OUs de nivel superior primero
- [ ] Implementar OUs de forma jerárquica
- [ ] Configurar delegación de permisos
- [ ] Crear y aplicar GPOs
- [ ] Probar delegación de permisos
- [ ] Documentar cambios realizados

### Validación

- [ ] Verificar que GPOs se aplican correctamente
- [ ] Comprobar delegación de permisos funciona
- [ ] Realizar pruebas de creación de usuarios en cada nivel
- [ ] Validar que estructura es escalable
- [ ] Obtener retroalimentación de usuarios

---

## Referencias y Recursos Adicionales

### Documentación de Microsoft
- [Diseño de unidades organizativas de Active Directory](https://docs.microsoft.com/es-es/windows-server/identity/ad-ds/plan/creating-an-organizational-unit-design)
- [Delegación de administración en Active Directory](https://docs.microsoft.com/es-es/windows-server/identity/ad-ds/plan/delegating-administration)
- [Directivas de grupo (GPO)](https://docs.microsoft.com/es-es/windows-server/identity/ad-ds/manage/group-policy/group-policy-overview)

### Mejores Prácticas
- No más de 5-7 niveles de profundidad en OUs
- Diseñar pensando en delegación, no en organigrama exacto
- Usar grupos de seguridad para permisos, OUs para GPOs
- Documentar toda la estructura y cambios
- Revisar y optimizar periódicamente

---

**Última actualización:** Octubre 2025  
**Documento creado para:** Taller de Sistemas Operativos - Windows Server  
**Tema:** Implementación de Active Directory y Unidades Organizacionales
