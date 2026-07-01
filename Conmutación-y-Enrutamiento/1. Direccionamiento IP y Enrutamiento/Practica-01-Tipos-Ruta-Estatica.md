# Practica 01: Tipos de Ruta Estatica

## Objetivo
Distinguir entre ruta directamente conectada, ruta de siguiente salto y ruta completamente especificada mediante el analisis de tablas de enrutamiento y configuraciones basicas.

**Duracion estimada:** 30 minutos

## Competencias a desarrollar
- Identifica el tipo de ruta en escenarios IPv4 de enrutamiento estatico.
- Interpreta la tabla de enrutamiento para justificar decisiones de reenvio.
- Relaciona comandos de configuracion con el comportamiento esperado de la red.

## Introduccion
En enrutamiento estatico, la forma en que se define una ruta afecta la resolucion de siguiente salto y la eficiencia del reenvio. En esta practica se comparan tres casos: ruta directamente conectada (aprendida por interfaz activa), ruta estatica de siguiente salto y ruta estatica completamente especificada. El foco es reconocer su diferencia operativa y su representacion en la tabla de enrutamiento.

## Equipo de proteccion e higiene
- Mantener orden en el area de trabajo y cableado.
- Evitar consumir alimentos o bebidas cerca del equipo.
- Manipular conexiones fisicas con el equipo apagado cuando aplique.
- Guardar configuraciones y cerrar sesion al terminar.

## Material y equipo necesario
### Materiales e insumos
- Hoja de trabajo o formato digital para registrar observaciones.
- Tabla de apoyo con prefijos IPv4.

### Equipo de laboratorio
- 1 PC con simulador de redes (Packet Tracer o equivalente).
- 2 routers virtuales.
- 2 redes LAN de prueba.

### Herramientas
- CLI del router.
- Comandos de verificacion: `show ip route`, `show running-config`, `ping`, `traceroute`.

## Instrucciones
1. Construir una topologia minima con dos routers y dos LAN (una en cada extremo).
2. Configurar direccionamiento IP basico en interfaces y verificar conectividad directa entre enlaces.
3. Identificar en `show ip route` al menos una ruta directamente conectada y registrarla con su codigo.
4. En R1, crear una ruta estatica de siguiente salto hacia la LAN remota:
   - `ip route <red-destino> <mascara> <ip-siguiente-salto>`
5. Verificar tabla de enrutamiento y probar conectividad con `ping`.
6. Sustituir la ruta anterior por una ruta estatica completamente especificada:
   - `ip route <red-destino> <mascara> <ip-siguiente-salto> <interfaz-salida>`
7. Comparar ambas configuraciones y documentar diferencias observables en salida de comandos y trazado.
8. Responder una conclusion breve: cuando conviene usar siguiente salto y cuando una ruta completamente especificada.

## Evidencia esperada
- Captura de `show ip route` donde se observe una ruta conectada.
- Captura de configuracion con ruta de siguiente salto.
- Captura de configuracion con ruta completamente especificada.
- Tabla comparativa de 3 filas: tipo de ruta, sintaxis, comportamiento observado.
- Conclusion tecnica de 5 a 8 lineas.

## Criterios de evaluacion
- Identifica correctamente los tres tipos de ruta.
- Configura sin errores de sintaxis las rutas estaticas solicitadas.
- Sustenta con evidencia de comandos la diferencia entre los tipos de ruta.
- Presenta conclusion coherente con el comportamiento observado.

## Instrumento sugerido: Lista de cotejo
- [ ] Presenta topologia funcional y direccionamiento correcto.
- [ ] Identifica una ruta directamente conectada en la tabla.
- [ ] Configura correctamente ruta de siguiente salto.
- [ ] Configura correctamente ruta completamente especificada.
- [ ] Incluye evidencias de comandos y pruebas de conectividad.
- [ ] Entrega comparacion tecnica clara entre tipos de ruta.

## Notas
- Si una prueba falla, revisar primero estado de interfaces y mascara de red.
- Conservar evidencia de antes y despues de cada cambio para facilitar comparacion.
- Esta practica puede ampliarse con distancia administrativa en una sesion posterior.
