# ACTIVIDADES MOODLE: TALLER DE SISTEMAS OPERATIVOS
# UNIDAD 1: INTRODUCCIÓN A SISTEMAS OPERATIVOS

---

## 🎯 ACTIVIDAD 1: FORO DE INVESTIGACIÓN COLABORATIVA
**Tipo de actividad**: Foro de discusión estructurado  
**Duración**: 1 semana  
**Modalidad**: Grupal (equipos de 4 estudiantes)

### Configuración Moodle:
```
Tipo: Foro con clasificación
Modo de calificación: Punto (0-100)
Calificación máxima: 100 puntos
Tipo de agregación: Promedio de calificaciones
Grupos: Grupos separados
Rastreo de lectura: Sí
```

### Instrucciones:
**Tema**: "Virtualización en la industria actual"

**Fases del foro:**

1. **Investigación individual** (Días 1-2):
   - Cada estudiante investiga un tipo específico de virtualización:
     - Estudiante A: Hipervisores tipo 1 (VMware vSphere, Hyper-V)
     - Estudiante B: Hipervisores tipo 2 (VirtualBox, VMware Workstation)
     - Estudiante C: Contenedores (Docker, Kubernetes)
     - Estudiante D: Virtualización en la nube (AWS, Azure, GCP)

2. **Discusión grupal** (Días 3-5):
   - Compartir hallazgos en el foro del equipo
   - Comparar ventajas, desventajas y casos de uso
   - Identificar tendencias actuales

3. **Síntesis colaborativa** (Días 6-7):
   - Crear documento colaborativo con conclusiones
   - Presentar recomendaciones para diferentes escenarios empresariales

### Criterios de evaluación:
- **Calidad de investigación** (30%): Fuentes confiables, información actualizada
- **Participación activa** (25%): Contribuciones significativas al foro
- **Análisis crítico** (25%): Comparaciones y evaluaciones fundamentadas
- **Síntesis final** (20%): Documento colaborativo coherente

---

## 🔬 ACTIVIDAD 2: LABORATORIO VIRTUAL - CONFIGURACIÓN DE HIPERVISOR
**Tipo de actividad**: Tarea práctica con entrega de evidencias  
**Duración**: 2 semanas  
**Modalidad**: Individual

### Configuración Moodle:
```
Tipo: Tarea
Tipo de entrega: Archivos y texto en línea
Tamaño máximo: 500 MB
Número máximo de archivos: 10
Calificación: Escala personalizada (Excelente/Bueno/Aceptable/Insuficiente)
Fecha límite: 2 semanas
Entrega tardía: Permitida con penalización del 10% por día
```

### Instrucciones detalladas:

#### Objetivos:
1. Instalar y configurar VirtualBox como hipervisor tipo 2
2. Crear máquinas virtuales con diferentes sistemas operativos
3. Configurar recursos virtuales (CPU, RAM, almacenamiento, red)
4. Implementar snapshots para gestión de estados
5. Documentar el proceso completo

#### Requerimientos técnicos:
- **Hardware mínimo**: 8GB RAM, 100GB espacio libre, procesador con virtualización
- **Software**: VirtualBox 7.0+, ISOs de SO (Ubuntu Server, Windows 10)
- **Tiempo estimado**: 10-12 horas

#### Entregables:
1. **Reporte técnico** (PDF, máx. 15 páginas):
   - Proceso de instalación con capturas de pantalla
   - Configuración de VMs con justificación de recursos asignados
   - Pruebas de funcionalidad
   - Análisis de rendimiento
   - Conclusiones y recomendaciones

2. **Archivos de configuración**:
   - Exportación de VMs (.ova)
   - Scripts de automatización (si aplica)
   - Logs de instalación

3. **Video demostrativo** (máx. 10 minutos):
   - Demostración de VMs funcionando
   - Explicación de configuraciones implementadas
   - Uso de snapshots

### Rúbrica de evaluación:
| Criterio | Excelente (3) | Bueno (2) | Aceptable (1) | Insuficiente (0) |
|----------|---------------|-----------|---------------|------------------|
| **Instalación** | Instalación completa sin errores, optimizada | Instalación correcta con configuraciones básicas | Instalación básica funcional | Instalación incompleta o con errores |
| **Configuración VMs** | VMs optimizadas según uso, recursos justificados | VMs funcionales con configuración adecuada | VMs básicas funcionando | VMs con problemas de configuración |
| **Documentación** | Reporte completo, claro, con análisis técnico | Reporte adecuado con información suficiente | Reporte básico con información mínima | Reporte incompleto o confuso |
| **Evidencias** | Todas las evidencias completas y organizadas | Evidencias suficientes y claras | Evidencias básicas presentes | Evidencias insuficientes o deficientes |

---

## 📊 ACTIVIDAD 3: CUESTIONARIO INTERACTIVO H5P
**Tipo de actividad**: Contenido interactivo  
**Duración**: 30 minutos  
**Modalidad**: Individual

### Configuración Moodle:
```
Tipo: H5P - Interactive Video + Question Set
Calificación: 50 puntos
Intentos: 2 máximo
Método de calificación: Intento más alto
Disponible: Después de completar Laboratorio Virtual
```

### Componentes:

#### 1. Video Interactivo: "Evolución de la Virtualización"
- **Duración**: 15 minutos
- **Contenido**: Historia desde mainframes IBM hasta contenedores modernos
- **Interacciones**:
  - 5 preguntas de comprensión durante el video
  - 3 puntos de pausa para reflexión
  - Enlaces a recursos adicionales
  - Glosario integrado

#### 2. Question Set: "Conceptos Fundamentales"
- **Total preguntas**: 20
- **Tipos**: Opción múltiple, arrastrar y soltar, completar texto
- **Temas**:
  - Tipos de hipervisores (5 preguntas)
  - Arquitecturas de virtualización (5 preguntas)
  - Casos de uso empresariales (5 preguntas)
  - Ventajas y desventajas (5 preguntas)

### Feedback personalizado:
- **90-100%**: "¡Excelente dominio! Estás listo para conceptos avanzados"
- **80-89%**: "Buen entendimiento. Revisa los temas marcados"
- **70-79%**: "Comprensión básica. Refuerza los conceptos fundamentales"
- **< 70%**: "Necesitas repasar los contenidos. Consulta los recursos adicionales"

---

## 🎮 ACTIVIDAD 4: SIMULACIÓN DE PLANIFICACIÓN DE PROCESOS
**Tipo de actividad**: Herramienta externa + Tarea  
**Duración**: 1 semana  
**Modalidad**: Individual con discusión grupal

### Configuración Moodle:
```
Tipo: Herramienta Externa (LTI) + Foro de seguimiento
Herramienta: ProcessSchedulingSimulator
URL: https://simulator.os-concepts.com/scheduling
Calificación: 75 puntos (50 simulación + 25 foro)
```

### Instrucciones:

#### Fase 1: Simulación (Individual)
**Algoritmos a evaluar**:
1. First Come First Served (FCFS)
2. Shortest Job First (SJF)
3. Round Robin (RR) con quantum = 2, 4, 6
4. Priority Scheduling
5. Multilevel Feedback Queue

**Escenarios de prueba**:
- **Escenario A**: 5 procesos con tiempos uniformes (CPU-bound)
- **Escenario B**: 5 procesos con tiempos variables (Mixed workload)
- **Escenario C**: 10 procesos con prioridades (Priority-based)

#### Fase 2: Análisis y comparación
**Métricas a evaluar**:
- Tiempo de respuesta promedio
- Tiempo de espera promedio
- Throughput del sistema
- Utilización de CPU

#### Fase 3: Discusión grupal en foro
**Preguntas guía**:
1. ¿Qué algoritmo fue más eficiente para cada escenario?
2. ¿Cómo afecta el quantum en Round Robin?
3. ¿En qué situaciones reales aplicarías cada algoritmo?

### Entregables:
1. **Capturas de resultados** de cada simulación
2. **Tabla comparativa** con métricas calculadas
3. **Análisis reflexivo** (500 palabras) sobre hallazgos
4. **Participación activa** en foro de discusión

---

## 📱 ACTIVIDAD 5: APLICACIÓN MÓVIL - QUIZ GAMIFICADO
**Tipo de actividad**: Gamificación con badges  
**Duración**: Disponible toda la unidad  
**Modalidad**: Individual con ranking grupal

### Configuración Moodle:
```
Plugin: Level Up! + Badges
Tipo: Banco de preguntas aleatorias
Total preguntas: 100 (banco rotativo)
Puntos por pregunta: 5-15 (según dificultad)
Badges disponibles: 8 diferentes
Ranking: Visible para motivación
```

### Mecánicas de juego:

#### Sistema de puntos:
- **Preguntas básicas**: 5 puntos
- **Preguntas intermedias**: 10 puntos  
- **Preguntas avanzadas**: 15 puntos
- **Bonus streak**: +50% por 5 respuestas consecutivas correctas
- **Penalty**: -25% por respuesta incorrecta

#### Badges/Insignias:
1. 🏁 **Primer Paso**: Completar primer quiz
2. 🎯 **Precisión**: 90% de aciertos en 20 preguntas
3. 🔥 **Racha**: 10 respuestas consecutivas correctas
4. 📚 **Estudioso**: Completar todos los temas
5. ⚡ **Velocidad**: Responder 50 preguntas en un día
6. 🏆 **Experto**: Estar en top 3 del ranking
7. 💪 **Perseverancia**: Completar 100 preguntas totales
8. 👑 **Maestro**: Obtener todos los badges anteriores

#### Contenido del quiz:
- **Virtualización**: 30 preguntas
- **Procesos e hilos**: 25 preguntas
- **Estructuras de SO**: 20 preguntas
- **Sincronización**: 15 preguntas
- **Casos prácticos**: 10 preguntas

---

## 🌐 ACTIVIDAD 6: PROYECTO WIKI COLABORATIVO
**Tipo de actividad**: Wiki + Glosario  
**Duración**: Durante toda la unidad  
**Modalidad**: Colaborativo (toda la clase)

### Configuración Moodle:
```
Tipo: Wiki colaborativo + Glosario
Modo: Colaborativo (una wiki para todos)
Formato: HTML enriquecido
Calificación: Participación (0-25 puntos)
Seguimiento: Control de versiones habilitado
```

### Estructura de la Wiki:

#### Página Principal: "Sistemas Operativos Modernos"
- Índice navegable
- Enlaces a secciones principales
- Últimas actualizaciones

#### Secciones principales:
1. **Historia de la Virtualización**
   - Línea temporal interactiva
   - Hitos importantes
   - Evolución tecnológica

2. **Catálogo de Hipervisores**
   - Comparativa técnica
   - Casos de uso
   - Pros y contras

3. **Algoritmos de Planificación**
   - Explicaciones detalladas
   - Ejemplos prácticos
   - Simulaciones embebidas

4. **Glosario Técnico**
   - Términos especializados
   - Definiciones precisas
   - Enlaces cruzados

### Metodología de trabajo:
- **Asignación rotativa**: Cada estudiante responsable de una sección por semana
- **Revisión por pares**: Validación cruzada de contenidos
- **Moderación docente**: Supervisión y retroalimentación
- **Versioning**: Control de cambios para transparencia

### Criterios de evaluación:
- **Contribución activa** (40%): Frecuencia y calidad de ediciones
- **Precisión técnica** (30%): Exactitud de la información
- **Organización** (20%): Estructura clara y navegación intuitiva
- **Colaboración** (10%): Trabajo en equipo y comunicación

---

## 📋 RECURSOS COMPLEMENTARIOS MOODLE

### Biblioteca Digital:
- **Libros electrónicos**: Tanenbaum, Silberschatz, Stallings
- **Papers académicos**: Últimas investigaciones en virtualización
- **Documentación oficial**: VMware, Microsoft, Docker
- **Videos técnicos**: Canales especializados de YouTube

### Herramientas integradas:
- **Calculator**: Para cálculos de planificación
- **File picker**: Acceso a repositorios institucionales
- **Plagiarism detector**: Verificación de originalidad
- **Analytics**: Seguimiento de progreso estudiantil

### Comunicación:
- **Mensajería**: Chat integrado para consultas rápidas
- **Calendarios**: Recordatorios de entregas
- **Notificaciones**: Actualizaciones automáticas
- **Zoom/BBB**: Sesiones de laboratorio en vivo

---

*Estas actividades están diseñadas para maximizar el aprendizaje activo, la colaboración y el desarrollo de competencias prácticas en administración de sistemas operativos, utilizando todas las capacidades de la plataforma Moodle.*
