# Práctica 4.2: Identificación y priorización de riesgos y amenazas

## Objetivo
Identificar amenazas y vulnerabilidades en una red de laboratorio, estimar su riesgo y proponer controles preventivos, detectivos y correctivos.

**Duración estimada:** 1.5 horas

## Competencia
Aplica mecanismos de seguridad para proporcionar niveles de confiabilidad en una red.

## Introducción
Un riesgo surge cuando una amenaza puede aprovechar una vulnerabilidad y producir un impacto. El análisis no debe centrarse solo en malware o ataques externos: también considera errores de configuración, cuentas compartidas, fallas eléctricas, pérdida de respaldos y barreras de acceso.

## Equipo de protección e higiene
- No ejecutes malware, phishing ni ataques reales.
- Usa escenarios controlados y datos ficticios.
- No escanees redes externas ni equipos personales sin autorización.

## Material y equipo necesario
- Topología en VirtualBox, VMware, PNetLab, GNS3 o laboratorio físico.
- Opcional: Nmap únicamente sobre direcciones propias del laboratorio.
- Matriz de riesgo en papel o hoja de cálculo.

## Instrucciones
1. Selecciona una red de laboratorio con al menos tres activos.
2. Identifica cinco amenazas, por ejemplo: contraseña débil, servicio innecesario, error humano, pérdida de energía o dispositivo no autorizado.
3. Para cada amenaza, registra vulnerabilidad, probabilidad, impacto y nivel de riesgo.
4. Propón un control preventivo, uno detectivo y uno correctivo.
5. Ordena los riesgos por prioridad y justifica cuál atenderías primero.
6. Si se dispone de autorización, verifica una vulnerabilidad no invasiva, como un puerto de prueba abierto o un servicio sin uso.
7. Elabora una recomendación que considere recursos económicos, accesibilidad y responsabilidades del personal.

## Evidencias
- E1: inventario de activos.
- E2: matriz de riesgos priorizada.
- E3: evidencia de una verificación segura o datos preparados.
- E4: plan de controles y responsables.

## Preguntas de análisis
1. ¿Por qué una vulnerabilidad no siempre produce un incidente?
2. ¿Qué diferencia hay entre probabilidad e impacto?
3. ¿Qué riesgo se suele ignorar cuando solo se piensa en ataques técnicos?

## Evaluación
Lista de cotejo: amenazas, vulnerabilidades, valoración, controles, prioridad y ética.

## Notas
Si no hay herramientas de escaneo disponibles, la verificación puede realizarse mediante `ss`, revisión de servicios o análisis de una captura preparada por la persona docente.
