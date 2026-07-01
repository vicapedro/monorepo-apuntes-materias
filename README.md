# Guía de Diseño de Curso Basado en Competencias

## Propósito
Estandarizar el orden de diseño de cursos para que todos los productos académicos estén alineados con el programa oficial, la evaluación por competencias y los formatos institucionales.

## Orden recomendado de diseño (macro a micro)
1. Analizar programa oficial y contexto del grupo.
2. Diseñar instrumentación didáctica por unidad.
3. Definir evaluación e instrumentos.
4. Diseñar actividades de enseñanza y aprendizaje.
5. Desarrollar apuntes y materiales de apoyo.
6. Planear operación del curso en calendario y LMS.
7. Implementar, retroalimentar y mejorar.

## Qué incluye cada fase

### 1) Análisis inicial
- Competencia general y competencias específicas por unidad.
- Temas, subtemas, prerrequisitos y bibliografía oficial.
- Diagnóstico de entrada del grupo (saberes previos y brechas).

### 2) Instrumentación didáctica
- Metodología activa prioritaria por unidad.
- Evidencias esperadas por tipo.
- Matriz de evidencias con ponderación total de 100% por unidad.
- Indicadores de alcance A-F según correspondencia oficial.

### 3) Evaluación e instrumentos
- Estrategia diagnóstica, formativa y sumativa.
- Instrumentos por evidencia:
  - Rúbrica (4 niveles: Excelente, Bueno, Aceptable, Insuficiente).
  - Lista de cotejo.
  - Guía de observación (si aplica).
- Reglas de logro y criterios de calidad por evidencia.

### 4) Actividades
- Actividades de enseñanza y actividades de aprendizaje.
- Prácticas, ejercicios, estudios de caso, proyectos.
- Quizzes y exámenes alineados a Bloom:
  - 20-30% Recordar/Comprender
  - 40-50% Aplicar/Analizar
  - 20-30% Evaluar/Crear

### 5) Apuntes y materiales
- Notas por tema, centradas en lo que sí se evalúa y aplica.
- Recursos de apoyo para ejecución de prácticas y proyectos.
- Materiales para trabajo autónomo y autorregulado.

### 6) Planeación operativa
- Cronograma semanal por unidad.
- Fechas de entregas, quizzes, exámenes y retroalimentaciones.
- Integración en LMS y requerimientos de laboratorio.

### 7) Mejora continua
- Revisión de resultados por evidencia e indicador.
- Ajustes de actividades, instrumentos y materiales.
- Registro de lecciones aprendidas por unidad.

## Entregables mínimos por unidad
1. Instrumentación didáctica de la unidad.
2. Matriz de evidencias cerrada al 100%.
3. Instrumentos de evaluación listos.
4. Actividades detalladas (enseñanza y aprendizaje).
5. Quizzes y exámenes alineados.
6. Apuntes y recursos de apoyo.
7. Mini informe de ajustes tras implementación.

## Checklist rápido de calidad
- Competencias extraídas del programa oficial.
- Evidencias coherentes con competencias.
- Ponderaciones suman 100% por unidad.
- Indicadores A-F correctamente distribuidos.
- Instrumentos adecuados al tipo de evidencia.
- Actividades alineadas con metodología activa.
- Evaluación alineada a Bloom y contexto profesional.
- Evidencias auténticas y aplicables al entorno real.

## Referencias internas del repositorio
- Base de lineamientos generales: .github/copilot-instructions.md
- Plantilla de instrumentación: shared/plantilla-instrumentacion-didactica.md
- Correspondencia evidencia-indicadores: shared/correspondencia_evidencia_indicadores.md
- Marco de evaluación por competencias: shared/Evaluacion_Enfoque_Competencias.md
- Ejemplo de diseño instruccional: Taller-de-BD/Diseño_Instruccional.md

## Nota de uso para equipo docente
Este flujo prioriza coherencia pedagógica antes de redacción de contenidos.
Primero se decide qué competencia se demostrará y cómo se evidenciará; después se producen actividades y apuntes.

## Siguiente paso sugerido
Derivar de esta guía una colección de skills docentes en `.github/skills/` con entradas y salidas claras para:
- wf-crea-practica
- wf-crea-apuntes
- wf-crea-actividad
- wf-crea-quiz
- wf-crea-examen
- wf-crea-instrumentacion

Convencion recomendada para evitar confusion con prompts:
- Prompts en `.github/prompts/`: `crea-*`
- Skills en `.github/skills/`: `wf-crea-*`
