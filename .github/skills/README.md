# Skills Docentes del Repositorio

Este directorio contiene skills reutilizables para crear contenidos academicos alineados al enfoque por competencias.

## Relacion con prompts
- Los prompts en `.github/prompts/` se usan para capturar entradas estructuradas y lanzar tareas con contexto.
- Las skills en `.github/skills/` se usan para guiar el procedimiento especializado y reutilizable.
- No son duplicados: son capas complementarias.
- Convencion de nombres para evitar confusion:
	- Prompts: `crea-*`
	- Skills: `wf-crea-*`

## Skills disponibles
- `wf-crea-practica`
- `wf-crea-apuntes`
- `wf-crea-actividad`
- `wf-crea-quiz`
- `wf-crea-examen`
- `wf-crea-instrumentacion`
- `wf-crea-unidad-completa`

## Orden recomendado de uso
1. `wf-crea-instrumentacion`
2. `wf-crea-actividad`
3. `wf-crea-practica`
4. `wf-crea-apuntes`
5. `wf-crea-quiz`
6. `wf-crea-examen`

`wf-crea-unidad-completa` ejecuta este flujo de forma orquestada.

## Fuentes de referencia
- `.github/copilot-instructions.md`
- `shared/plantilla-instrumentacion-didactica.md`
- `shared/correspondencia_evidencia_indicadores.md`
- `shared/Evaluacion_Enfoque_Competencias.md`

## Nota
Estas skills estan orientadas a generar plantillas guiadas y borradores de alta calidad para refinamiento docente posterior.
