# Práctica 4.4: Mecanismos de seguridad física y lógica

## Objetivo
Aplicar controles básicos de acceso, autenticación, respaldos y protección perimetral en una red de laboratorio, verificando su efecto sin interrumpir servicios no involucrados.

**Duración estimada:** 2 horas

## Competencia
Aplica mecanismos de seguridad para proporcionar niveles de confiabilidad en una red.

## Introducción
La defensa en profundidad combina controles físicos y lógicos. Una puerta cerrada no reemplaza una cuenta protegida, y un firewall no reemplaza los respaldos ni la capacitación. Esta práctica integra controles sencillos en un servidor o dispositivo aislado.

## Equipo de protección e higiene
- Realiza todos los cambios en una VM, simulador o equipo físico de laboratorio.
- Conserva acceso por consola antes de modificar el firewall.
- No utilices credenciales reales.
- Realiza respaldos antes de aplicar cambios y restaura al finalizar.

## Material y equipo necesario
- Debian/Ubuntu en VirtualBox o VMware, nodo Linux en GNS3/PNetLab o servidor físico.
- Opcional: router o firewall físico autorizado.
- `ufw` o ACL equivalente, cuentas de usuario, `sha256sum` y herramienta de respaldo.

## Instrucciones
1. Documenta el estado inicial: cuentas, servicios, puertos y ubicación física o virtual del equipo.
2. Crea una cuenta individual de laboratorio y aplica mínimo privilegio.
3. Configura un firewall que bloquee conexiones entrantes por defecto y permita solo SSH o HTTP desde la red de práctica.
4. Crea un archivo de configuración de prueba, restringe sus permisos y genera una huella SHA-256.
5. Realiza un respaldo de la configuración del firewall o ACL.
6. Comprueba una conexión permitida y una conexión rechazada.
7. Modifica el archivo de prueba y verifica que la huella cambie; restáuralo y verifica nuevamente.
8. Registra cómo un control físico, como acceso restringido al equipo o respaldo eléctrico, complementaría los controles lógicos.
9. Restaura configuraciones temporales y documenta el cierre.

## Evidencias
- E1: estado inicial y activos protegidos.
- E2: cuenta, permisos y firewall.
- E3: conexiones permitida y rechazada.
- E4: integridad del archivo antes y después.
- E5: respaldo, rollback y bitácora.

## Preguntas de análisis
1. ¿Qué propiedad CIA protege cada control aplicado?
2. ¿Qué ocurriría si se configura un firewall sin un plan de rollback?
3. ¿Cómo adaptarías el control de acceso físico para una comunidad con recursos limitados?

## Evaluación
Lista de cotejo: autenticación, mínimo privilegio, firewall, integridad, respaldo, rollback y documentación.

## Notas
Si no existe un firewall físico, se acepta UFW, una ACL de router o un firewall virtual. Si no es posible ejecutar comandos, se puede analizar una configuración preparada y explicar cada regla.
