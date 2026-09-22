# Práctica 2.9: Proxy web y control de acceso

## Objetivo
Configurar un proxy web sencillo para observar solicitudes, aplicar una regla de acceso controlada y analizar sus efectos sobre disponibilidad, privacidad y rendimiento.

**Duración estimada:** 1.5 horas

## Competencias a desarrollar
- Instala y configura un servicio proxy.
- Aplica una política de acceso documentada.
- Analiza el equilibrio entre control, privacidad, rendimiento y accesibilidad.

## Introducción
Un proxy intermedia solicitudes entre clientes y servicios web. Puede aplicar políticas, almacenar caché y generar registros. El caso representa una biblioteca que ofrece acceso compartido y necesita administrar recursos sin bloquear contenidos legítimos para distintos perfiles de usuarios.

## Equipo de protección e higiene
- Trabaja únicamente con sitios de prueba o una página local.
- No interceptes tráfico cifrado de otras personas.
- No bloquees categorías basadas en prejuicios o características personales.
- Documenta cualquier regla antes de aplicarla.

## Material y equipo necesario
- VM Debian/Ubuntu o servidor físico.
- Cliente web en la misma red.
- Squid u otro proxy disponible.
- Página web local para pruebas.
- VirtualBox, VMware, GNS3, PNetLab o laboratorio físico.

## Instrucciones
1. Instala Squid:
   ```bash
   sudo apt update
   sudo apt install -y squid
   sudo systemctl enable --now squid
   ```
2. Identifica el puerto de escucha y el archivo de registros.
3. Configura una ACL que permita únicamente la red de laboratorio `192.168.50.0/24` y deniegue una URL local de prueba.
4. Valida la configuración y reinicia el servicio:
   ```bash
   sudo squid -k parse
   sudo systemctl restart squid
   ```
5. Configura el navegador o `curl` del cliente para utilizar el proxy.
6. Comprueba un acceso permitido y uno rechazado; revisa los registros de Squid.
7. Elabora una recomendación que considere rendimiento, privacidad, accesibilidad y procedimiento de revisión de reglas.

## Evidencias
- E1: diagrama cliente-proxy-servidor.
- E2: ACL y estado del servicio.
- E3: solicitud permitida y solicitud rechazada.
- E4: registro de accesos y recomendación de política.

## Preguntas de análisis
1. ¿Qué diferencia hay entre controlar acceso y vigilar el contenido de las comunicaciones?
2. ¿Qué información puede revelar un registro de proxy?
3. ¿Cómo diseñarías una política que no perjudique a personas con necesidades de acceso legítimas?

## Evaluación
Lista de cotejo: instalación, ACL, pruebas, registros, privacidad y recomendación.

## Notas
Si no es posible configurar Squid, puede usarse un proxy disponible en el laboratorio o representar las solicitudes con una tabla de decisiones y registros simulados. Debe indicarse la alternativa utilizada.
