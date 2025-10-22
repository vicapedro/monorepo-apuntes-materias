# Actividad 1: Criterios de Selección de SGBD

## Objetivo de la Actividad
**Analizar y comparar diferentes SGBD aplicando criterios técnicos y empresariales para tomar decisiones fundamentadas de selección tecnológica.**

**Duración estimada**: 2 horas  
**Modalidad**: Individual con discusión grupal

## Competencias a Desarrollar
- Evalúa características técnicas de diferentes SGBD
- Analiza factores empresariales en decisiones tecnológicas
- Aplica metodología de comparación sistemática
- Justifica selecciones tecnológicas con criterios objetivos

## Introducción

La selección de un Sistema Gestor de Base de Datos (SGBD) es una decisión estratégica que impacta el desarrollo, mantenimiento y escalabilidad de sistemas de información. Esta decisión debe basarse en criterios técnicos, económicos y organizacionales bien fundamentados.

### Contexto Empresarial
Una empresa de desarrollo de software ha sido contratada para desarrollar sistemas para tres clientes diferentes:
1. **Startup tecnológica** - Aplicación web con crecimiento rápido
2. **Hospital regional** - Sistema de gestión de expedientes médicos
3. **Banco comunitario** - Sistema de transacciones financieras

## Metodología de Trabajo

### Fase 1: Investigación Dirigida (45 minutos)

**Instrucciones**:
1. Forma equipos de 3 personas
2. Cada equipo investiga **3 SGBD diferentes**: MySQL, PostgreSQL, SQL Server
3. Completa la **Matriz de Análisis** proporcionada

### Matriz de Análisis Comparativo

| Criterio | MySQL | PostgreSQL | SQL Server |
|----------|-------|------------|------------|
| **CRITERIOS TÉCNICOS** | | | |
| Modelo de datos soportado | | | |
| Tipos de datos disponibles | | | |
| Soporte para transacciones ACID | | | |
| Escalabilidad horizontal | | | |
| Escalabilidad vertical | | | |
| Rendimiento en OLTP | | | |
| Rendimiento en OLAP | | | |
| Soporte para procedimientos almacenados | | | |
| Características de seguridad | | | |
| **CRITERIOS ECONÓMICOS** | | | |
| Modelo de licenciamiento | | | |
| Costo de licencias | | | |
| Costo de soporte técnico | | | |
| Costo de capacitación | | | |
| **CRITERIOS OPERACIONALES** | | | |
| Plataformas soportadas | | | |
| Facilidad de instalación | | | |
| Herramientas de administración | | | |
| Facilidad de mantenimiento | | | |
| Disponibilidad de profesionales | | | |
| Comunidad y documentación | | | |

### Fase 2: Análisis por Escenarios (45 minutos)

Para cada uno de los tres clientes, determina:

#### Escenario A: Startup Tecnológica
**Características**:
- Presupuesto limitado inicial
- Crecimiento rápido esperado (10x en 2 años)
- Equipo técnico joven y ágil
- Producto web con alta concurrencia

**Preguntas guía**:
1. ¿Qué SGBD recomendarías y por qué?
2. ¿Cuáles son los 3 criterios más importantes para este escenario?
3. ¿Qué riesgos identifica para cada opción?

#### Escenario B: Hospital Regional
**Características**:
- Datos médicos sensibles y regulaciones estrictas
- Disponibilidad crítica 24/7
- Integración con sistemas legacy
- Presupuesto establecido para tecnología

**Preguntas guía**:
1. ¿Qué aspectos de seguridad son críticos?
2. ¿Cómo impacta el compliance en la selección?
3. ¿Qué SGBD ofrece mejor soporte empresarial?

#### Escenario C: Banco Comunitario
**Características**:
- Transacciones financieras críticas
- Regulaciones bancarias estrictas
- Necesidad de auditoría completa
- Integración con sistemas financieros existentes

**Preguntas guía**:
1. ¿Qué características ACID son más relevantes?
2. ¿Cómo evalúas el soporte para auditoría?
3. ¿Cuál es el costo total de propiedad más atractivo?

### Fase 3: Presentación y Debate (30 minutos)

**Formato**: Cada equipo presenta sus recomendaciones para UN escenario (asignado aleatoriamente)

**Estructura de presentación** (5 minutos por equipo):
1. **Recomendación** (1 min): SGBD seleccionado
2. **Justificación** (2 min): Top 3 criterios decisivos
3. **Trade-offs** (1 min): Ventajas/desventajas identificadas
4. **Implementación** (1 min): Siguientes pasos recomendados

## Entregables

### Documento Individual (2 páginas máximo)
1. **Matriz comparativa completa** con investigación documentada
2. **Recomendación por escenario** con justificación de 3 párrafos cada una
3. **Reflexión personal** (1 párrafo): ¿Cómo cambió tu perspectiva sobre la selección de SGBD?

### Presentación Grupal
- **Slides de apoyo** (máximo 5 slides)
- **Demo opcional**: Capturas de pantalla de características clave

## Criterios de Evaluación

| Aspecto | Excelente (4) | Proficiente (3) | Básico (2) | Insuficiente (1) |
|---------|---------------|-----------------|------------|------------------|
| **Investigación** | Información completa, fuentes confiables, datos actualizados | Información adecuada con fuentes apropiadas | Información básica, algunas fuentes | Información incompleta o no confiable |
| **Análisis Comparativo** | Comparación sistemática con criterios claros y ponderados | Comparación adecuada con criterios apropiados | Comparación básica con algunos criterios | Comparación superficial o incorrecta |
| **Contextualización** | Recomendaciones perfectamente adaptadas al contexto empresarial | Recomendaciones bien adaptadas al contexto | Recomendaciones básicas considerando contexto | Recomendaciones genéricas sin contexto |
| **Justificación** | Argumentos sólidos basados en evidencia técnica y empresarial | Buenos argumentos con base técnica | Argumentos básicos con algo de sustento | Argumentos débiles o sin sustento |

## Recursos de Apoyo

### Lecturas Preparatorias
- "Choosing a Database Management System" - IEEE Computer Society
- Documentación oficial: MySQL vs PostgreSQL Feature Comparison
- Gartner Magic Quadrant for Operational Database Management Systems

### Recursos en Línea
- **MySQL**: https://dev.mysql.com/doc/refman/8.0/en/
- **PostgreSQL**: https://www.postgresql.org/docs/
- **SQL Server**: https://docs.microsoft.com/en-us/sql/

### Videos Recomendados
- "Database Selection Criteria for Modern Applications" (20 min)
- "MySQL vs PostgreSQL vs SQL Server - Technical Comparison" (25 min)

## Preguntas Reflexivas Post-Actividad

1. **Análisis crítico**: ¿Encontraste algún criterio que inicialmente subestimaste pero resultó ser crucial?

2. **Perspectiva empresarial**: ¿Cómo balanceas criterios técnicos vs criterios de negocio cuando están en conflicto?

3. **Evolución tecnológica**: ¿Cómo consideras la evolución futura de cada SGBD en tu decisión actual?

4. **Lecciones aprendidas**: Si fueras el CTO de una startup, ¿qué proceso seguirías para esta decisión?

## Conexión con Siguientes Actividades

Esta actividad prepara el contexto para:
- **Actividad 2**: Instalación práctica de los SGBD seleccionados
- **Actividad 3**: Implementación de esquemas comparativos
- **Laboratorio 1**: Instalación comparativa con métricas de rendimiento

## Indicadores de Impacto Desarrollados

- **A - Adaptación a contextos complejos**: Análisis multi-criterio por escenario empresarial
- **B - Contribuciones académicas**: Investigación sistemática y presentación de hallazgos
- **D - Pensamiento crítico**: Evaluación de trade-offs y toma de decisiones fundamentadas
- **E - Conocimiento interdisciplinario**: Integración de aspectos técnicos, económicos y organizacionales
