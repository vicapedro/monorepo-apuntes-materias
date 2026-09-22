# Práctica 2.1: Servicio DHCP

## Objetivo
Configurar un servidor DHCP en una red de laboratorio y verificar la asignación automática de parámetros TCP/IP.

**Duración estimada:** 1.5 horas

## Competencias a desarrollar
- Instala y configura un servicio de red para una necesidad organizacional.
- Verifica conectividad y documenta resultados.
- Colabora mediante roles técnicos y de documentación.

## Introducción
DHCP asigna direcciones IP, máscara, puerta de enlace y otros parámetros a los equipos clientes. Se trabajará con un contexto inclusivo: una biblioteca comunitaria que ofrece conectividad a personas con diferentes niveles de experiencia y dispositivos.

## Equipo de protección e higiene
- Utiliza una red aislada y no modifiques el DHCP institucional.
- Toma una instantánea o respaldo antes de cambiar configuraciones.
- No recolectes datos personales de los dispositivos clientes.

## Material y equipo necesario
- Una VM Debian/Ubuntu como servidor o un servidor físico.
- Una o más VM cliente, PC físico o nodos en GNS3/PNetLab.
- VirtualBox, VMware, GNS3, PNetLab o equipo físico, a elección del equipo.
- Paquetes `isc-dhcp-server` y herramientas `ip`, `ping` y `journalctl`.

## Instrucciones
1. Diseña una red aislada, por ejemplo `192.168.50.0/24`; reserva `192.168.50.1` para el servidor y el rango `192.168.50.100-150` para clientes.
2. Instala el servicio DHCP en Debian/Ubuntu:
   ```bash
   sudo apt update
   sudo apt install -y isc-dhcp-server
   ```
3. Configura la interfaz del servidor con una dirección fija y define el ámbito DHCP en `/etc/dhcp/dhcpd.conf`.
4. Reinicia y verifica el servicio:
   ```bash
   sudo systemctl restart isc-dhcp-server
   sudo systemctl status isc-dhcp-server --no-pager
   sudo journalctl -u isc-dhcp-server --no-pager
   ```
5. Configura el cliente en modo DHCP y comprueba la concesión:
   ```bash
   ip address
   ip route
   ping -c 4 192.168.50.1
   ```
6. Renueva la concesión y localiza el registro correspondiente en el servidor.
7. Si se trabaja con router Cisco o simulador, configura un pool DHCP equivalente y compara ambos procedimientos.

## Evidencias
- E1: diagrama y plan de direccionamiento.
- E2: configuración del ámbito y estado del servicio.
- E3: cliente con dirección asignada y conectividad.
- E4: registro de concesión y reflexión sobre reservas y exclusiones.

## Preguntas de análisis
1. ¿Por qué el servidor debe tener una dirección fija?
2. ¿Qué riesgo existe si dos servidores DHCP operan en la misma red sin coordinación?
3. ¿Cómo adaptarías el servicio para una comunidad con dispositivos antiguos o acceso limitado?

## Evaluación
Lista de cotejo: configuración correcta, concesión verificable, documentación, seguridad de la red aislada y análisis técnico.

## Notas
Si el equipo no puede instalar un servidor, puede usar un router en GNS3/PNetLab o una demostración guiada con capturas. La evidencia debe distinguir una configuración realizada de una observada.
