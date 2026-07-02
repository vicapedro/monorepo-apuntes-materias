# Ejercicios de Montecarlo

## Clínica de diálisis

En una clínica se tienen 8 máquinas de diálisis. Se atiende a un grupo de pacientes con diferentes frecuencias y duración de conexión a la máquina. Cada máquina necesita un tiempo entre un paciente y otro para servicio.

### Características del Sistema de Diálisis

#### **Frecuencia de Asistencia de Pacientes**
Los pacientes **NO tienen las mismas necesidades** - varían según su condición renal:

| Tipo de Paciente | Frecuencia Semanal | % Aproximado | Descripción |
|------------------|-------------------|--------------|-------------|
| **Hemodiálisis Estándar** | 3 veces/semana | 70-80% | Lun-Mié-Vie o Mar-Jue-Sáb |
| **Hemodiálisis Intensiva** | 4-5 veces/semana | 10-15% | Pacientes con mayor deterioro |
| **Hemodiálisis Reducida** | 2 veces/semana | 5-10% | Inicio de tratamiento o función renal residual |
| **Diálisis Nocturna** | 3-6 veces/semana | 5% | Sesiones más largas, menor frecuencia |

**Patrón típico:** Los pacientes tienen **horarios fijos asignados** (no llegan aleatoriamente). Por ejemplo:
- Paciente A: Lunes, Miércoles, Viernes a las 7:00 AM
- Paciente B: Martes, Jueves, Sábado a las 9:00 AM

#### **Duración de las Sesiones (VARIABLE)**
El tiempo en la máquina **depende de varios factores**:

| Factor | Duración Típica | Variabilidad |
|--------|----------------|--------------|
| **Hemodiálisis Estándar** | 3.5 - 4.5 horas | ±30 min |
| **Pacientes de alto flujo** | 2.5 - 3.5 horas | ±20 min |
| **Diálisis nocturna** | 6 - 8 horas | ±1 hora |
| **Primera sesión (nuevo paciente)** | 2 - 3 horas | ±30 min (más corta) |

**Factores que afectan la duración:**
- **Peso del paciente**: Más peso → más tiempo para remover líquidos
- **Nivel de toxinas acumuladas**: Mayor acumulación → más tiempo
- **Velocidad del flujo sanguíneo**: 250-450 mL/min (depende de acceso vascular)
- **Complicaciones durante sesión**: Hipotensión, calambres (+15-30 min)
- **Tipo de membrana del dializador**: Alta eficiencia reduce tiempo

#### **Distribución Probabilística Sugerida**
```
Tiempo de sesión ~ Normal(μ = 240 min, σ = 30 min)
- Mínimo: 150 minutos (2.5 horas)
- Máximo: 330 minutos (5.5 horas)
- Moda: 240 minutos (4 horas)
```

#### **Tiempo de Preparación entre Pacientes**
Cada máquina necesita **servicio entre pacientes**:

| Actividad | Tiempo (minutos) | Variabilidad |
|-----------|------------------|--------------|
| **Desconexión del paciente anterior** | 10-15 min | ±5 min |
| **Limpieza y desinfección de máquina** | 15-20 min | ±3 min |
| **Cebado del circuito (preparación)** | 10-15 min | ±2 min |
| **Conexión del nuevo paciente** | 15-20 min | ±5 min |
| **TOTAL tiempo de transición** | **50-70 min** | **±10 min** |

**Distribución sugerida:**
```
Tiempo de preparación ~ Uniforme(45, 75) minutos
o
Tiempo de preparación ~ Triangular(45, 60, 75) minutos
```

#### **Organización de Turnos Típica**

Las clínicas operan en **3 turnos diarios** para maximizar uso de máquinas:

| Turno | Horario | Capacidad (8 máquinas) | Características |
|-------|---------|------------------------|-----------------|
| **Matutino** | 6:00 AM - 1:00 PM | 8 pacientes | Más demandado, pacientes activos laboralmente |
| **Vespertino** | 1:30 PM - 8:30 PM | 8 pacientes | Segunda opción preferida |
| **Nocturno** | 9:00 PM - 5:00 AM | 6-8 pacientes | Menor demanda, diálisis prolongada |

**Capacidad teórica diaria:** 24 pacientes máximo (8 máq × 3 turnos)
**Capacidad semanal (6 días):** 144 sesiones
**Población atendida:** ~50-60 pacientes únicos (cada uno 3 sesiones/semana)

#### **Variables Aleatorias para el Modelo**

**1. Llegadas de Pacientes (Determinísticas con Variabilidad)**
```
Hora_Llegada = Hora_Programada ± Normal(0, 10 min)
- 90% llegan dentro de ±15 min de su cita
- 5% llegan tarde (15-30 min)
- 5% llegan muy tarde (30-60 min) → requiere reprogramación
```

**2. Duración de Sesión (Variable Normal)**
```
Duración ~ Normal(μ = 240, σ = 30) minutos
Truncada entre [150, 330] minutos
```

**3. Complicaciones Médicas (Eventos Raros)**
```
P(Complicación) = 0.05 por sesión
Si hay complicación: +30 minutos adicionales
```

**4. Tiempo de Preparación de Máquina**
```
Preparación ~ Uniforme(45, 75) minutos
o
Preparación ~ Normal(60, 8) minutos
```

**5. Ausencias de Pacientes (No-Shows)**
```
P(Ausencia sin aviso) = 0.03-0.05 por cita programada
→ Máquina queda libre inesperadamente
```

---

### Ejercicio de Simulación

Modelar la llegada de los pacientes y sus tiempos de servicio considerando:

1. **Sistema de citas programadas** (no llegadas aleatorias Poisson)
2. **Variabilidad en tiempos de sesión** según distribución normal
3. **Tiempo de preparación** entre pacientes (50-70 min)
4. **Complicaciones médicas** aleatorias que extienden el tratamiento
5. **Ausencias** ocasionales de pacientes

**Objetivos del modelo:**
- Calcular **utilización promedio** de las 8 máquinas
- Determinar **tiempo de espera** si un paciente llega y no hay máquina disponible
- Identificar **cuellos de botella** en turnos específicos
- Evaluar impacto de **agregar/remover máquinas**
- Estimar **capacidad máxima** de atención con recursos actuales

**Parámetros a definir:**
- Número de pacientes activos en la clínica
- Distribución de pacientes por turno (matutino/vespertino/nocturno)
- Política de asignación cuando hay retrasos
- Periodo de simulación (1 semana = 6 días operativos)
