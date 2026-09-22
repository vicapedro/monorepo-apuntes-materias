# Práctica 6: Controles básicos de seguridad en un servidor

## Objetivo

Identificar activos y riesgos básicos de un servidor, aplicar controles elementales de acceso, firewall, permisos y respaldo, y documentar cómo estos controles protegen la confidencialidad, integridad y disponibilidad de los servicios de red.

**Duración estimada:** 1.5 horas

## Competencias a desarrollar

- Aplica las funciones de la administración de redes para la optimización del desempeño y el aseguramiento de las mismas.
- Identifica activos, amenazas, vulnerabilidades y controles de seguridad.
- Configura reglas básicas de firewall y permisos de archivos en un entorno de laboratorio.
- Verifica que un control de seguridad funcione y documenta sus resultados.
- Propone mejoras de seguridad considerando personas, procesos y herramientas.

## Introducción

La Gestión de Seguridad protege la **confidencialidad, integridad y disponibilidad** de los recursos de red. Para ello combina controles técnicos, responsabilidades de las personas y procedimientos definidos.

En esta práctica se trabajará con una máquina virtual Debian o Ubuntu. Se revisarán los servicios activos, se configurará un firewall básico con UFW, se restringirá el acceso a un archivo y se realizará un respaldo de configuración. La actividad se ejecutará únicamente en una red de laboratorio y no incluye ataques ni escaneos contra sistemas externos.

La práctica se relaciona con [1.5 Seguridad.md](../1.5%20Seguridad.md).

## Equipo de protección e higiene

- Trabaja en una máquina virtual o equipo de laboratorio, nunca sobre un servidor de producción.
- Antes de cambiar el firewall, confirma que tienes acceso local o por consola para evitar perder la administración del equipo.
- Toma una instantánea de la máquina virtual o un respaldo de configuración antes de aplicar cambios.
- Utiliza contraseñas de laboratorio y no las reutilices en servicios reales.
- Permite únicamente los servicios necesarios para la práctica.
- No realices escaneos ni pruebas de acceso contra direcciones que no pertenezcan al laboratorio.

## Material y equipo necesario

### Materiales e insumos

- Hoja de trabajo o documento de reporte.
- Diagrama sencillo de la red de laboratorio.
- Credenciales de una cuenta administrativa de laboratorio.

### Equipo de laboratorio

- Computadora con VirtualBox, VMware, KVM u otro hipervisor.
- Máquina virtual Debian 12 o Ubuntu Server, con 2 GB de RAM y 20 GB de almacenamiento.
- Opcional: una segunda máquina virtual o PC cliente en la misma red aislada.

### Herramientas

- Terminal Linux.
- `ufw`, `openssh-server` y `curl`.
- `systemctl`, `ss`, `ls`, `chmod`, `chown` y `sha256sum`.
- Editor de texto.

## Instrucciones

### Parte 1: Identificar activos y riesgos

Antes de ejecutar comandos, completa la siguiente tabla para el servidor de laboratorio:

| Activo | Valor para la organización | Amenaza posible | Vulnerabilidad | Control propuesto |
|---|---|---|---|---|
| Servidor | | | | |
| Servicio SSH | | | | |
| Archivo de configuración | | | | |
| Cuenta administrativa | | | | |
| Red del laboratorio | | | | |

Considera como mínimo:

- Acceso no autorizado.
- Modificación de una configuración.
- Interrupción de un servicio.
- Pérdida o exposición de información.

**Evidencia E1:** matriz de activos, amenazas, vulnerabilidades y controles.

### Parte 2: Revisar el estado inicial del servidor

1. Identifica la versión del sistema y el nombre del equipo:

   ```bash
   hostnamectl
   cat /etc/os-release
   ```

2. Revisa los servicios activos:

   ```bash
   systemctl --type=service --state=running --no-pager
   ```

3. Revisa los puertos en escucha:

   ```bash
   sudo ss -tulpen
   ```

4. Identifica qué servicios son necesarios para el laboratorio y cuáles no deberían estar expuestos.
5. No desinstales ni detengas servicios sin autorización. Registra únicamente una propuesta de control.

**Evidencia E2:** captura o transcripción de los puertos y servicios identificados, con su justificación.

### Parte 3: Configurar un control básico de acceso

1. Comprueba si existe una cuenta administrativa de laboratorio diferente de `root`:

   ```bash
   whoami
   id
   getent group sudo
   ```

2. Si la persona docente lo solicita, crea una cuenta de práctica y agrégala al grupo administrativo. Utiliza una contraseña temporal definida para el laboratorio:

   ```bash
   sudo adduser operador-lab
   sudo usermod -aG sudo operador-lab
   id operador-lab
   ```

3. Verifica que la cuenta tenga únicamente los permisos necesarios para la práctica.
4. Documenta por qué no se debe compartir la cuenta `root` y por qué conviene asignar responsabilidades individuales.

**Evidencia E3:** comprobación de la cuenta y explicación del principio de mínimo privilegio.

### Parte 4: Configurar el firewall UFW

1. Revisa el estado inicial:

   ```bash
   sudo ufw status verbose
   ```

2. Establece una política predeterminada que bloquee conexiones entrantes y permita conexiones salientes:

   ```bash
   sudo ufw default deny incoming
   sudo ufw default allow outgoing
   ```

3. Permite SSH únicamente desde la red de laboratorio. Sustituye la red si tu laboratorio utiliza otra:

   ```bash
   sudo ufw allow from 192.168.10.0/24 to any port 22 proto tcp
   ```

4. Si el servidor ofrece una página web de prueba, permite HTTP solo dentro de la red del laboratorio:

   ```bash
   sudo ufw allow from 192.168.10.0/24 to any port 80 proto tcp
   ```

5. Activa el firewall y verifica sus reglas:

   ```bash
   sudo ufw enable
   sudo ufw status numbered
   ```

6. Desde otro equipo del laboratorio, comprueba el acceso permitido al servicio que corresponda. No pruebes desde redes externas.
7. Si pierdes el acceso remoto, utiliza la consola de la máquina virtual para revisar o eliminar la regla incorrecta.

**Evidencia E4:** captura de las políticas y reglas activas de UFW, junto con una prueba de acceso autorizado.

### Parte 5: Proteger la integridad de un archivo

1. Crea un archivo de configuración de ejemplo:

   ```bash
   sudo mkdir -p /opt/lab-seguridad
   echo "modo=produccion" | sudo tee /opt/lab-seguridad/servicio.conf
   sudo chown root:root /opt/lab-seguridad/servicio.conf
   sudo chmod 0640 /opt/lab-seguridad/servicio.conf
   ls -l /opt/lab-seguridad/servicio.conf
   ```

2. Genera una huella digital del archivo:

   ```bash
   sudo sha256sum /opt/lab-seguridad/servicio.conf | sudo tee /opt/lab-seguridad/servicio.conf.sha256
   ```

3. Verifica la huella:

   ```bash
   sudo sha256sum -c /opt/lab-seguridad/servicio.conf.sha256
   ```

4. Cambia de forma controlada el contenido del archivo y repite la verificación. Observa que la huella ya no coincida.
5. Restaura el contenido original y verifica nuevamente.

**Evidencia E5:** permisos del archivo y resultados de verificación antes, después del cambio y tras la restauración.

### Parte 6: Respaldar y documentar la configuración

1. Guarda la configuración actual de UFW en un archivo de respaldo:

   ```bash
   sudo ufw show raw | sudo tee /var/backups/ufw-lab-$(date +%F).txt
   ```

2. Registra en la bitácora:

   - Fecha y hora del cambio.
   - Persona responsable.
   - Regla agregada.
   - Justificación.
   - Resultado de la validación.
   - Procedimiento de reversión.

3. Propón un procedimiento de revisión periódica de cuentas, puertos, reglas y respaldos.

**Evidencia E6:** archivo de respaldo y bitácora de cambios completa.

## Registro de resultados

| Control | Estado inicial | Acción aplicada | Resultado de la verificación | Mejora pendiente |
|---|---|---|---|---|
| Cuentas y privilegios | | | | |
| Servicios activos | | | | |
| Firewall | | | | |
| Permisos de archivo | | | | |
| Integridad mediante hash | | | | |
| Respaldo y documentación | | | | |

## Preguntas de análisis

1. ¿Qué diferencia existe entre una amenaza y una vulnerabilidad?
2. ¿Qué propiedad del triángulo CIA protege principalmente cada control aplicado?
3. ¿Por qué un firewall configurado sin un procedimiento de cambios puede generar un nuevo riesgo?
4. ¿Qué evidencia permite demostrar que un archivo fue modificado?
5. ¿Por qué el control de acceso debe incluir personas y procesos, además de comandos?
6. ¿Qué relación existe entre Seguridad, Fallas y Configuración en esta práctica?
7. ¿Qué control adicional implementarías en una red institucional?

## Evidencia y evaluación

**Producto esperado:** reporte técnico con matriz de riesgos, estado inicial, comandos relevantes, capturas E1-E6, tabla de resultados y respuestas de análisis.

**Instrumento sugerido:** lista de cotejo.

| Criterio | Cumple | No cumple |
|---|---|---|
| Identifica activos, amenazas, vulnerabilidades y controles | | |
| Revisa servicios y puertos sin realizar acciones no autorizadas | | |
| Aplica el principio de mínimo privilegio | | |
| Configura UFW con reglas limitadas a la red de laboratorio | | |
| Verifica el funcionamiento del firewall | | |
| Configura permisos adecuados para el archivo de ejemplo | | |
| Comprueba la integridad mediante `sha256sum` | | |
| Genera respaldo y bitácora de cambios | | |
| Relaciona los controles con confidencialidad, integridad y disponibilidad | | |
| Responde las preguntas con argumentos técnicos | | |

## Notas

- Si no se dispone de una segunda computadora, la verificación puede realizarse localmente con `curl`, `ss` y la revisión de reglas; debe indicarse la limitación.
- No uses `ufw reset` en un equipo institucional. En el laboratorio, cualquier restauración debe hacerse desde la consola y con autorización.
- Una regla de firewall no sustituye la actualización del sistema, la autenticación fuerte, los respaldos ni la capacitación de las personas usuarias.
- En un entorno real se deben centralizar registros, sincronizar la hora, revisar alertas y establecer un procedimiento de respuesta a incidentes.
- La práctica utiliza un archivo de configuración simulado para demostrar integridad; no modifiques archivos críticos del sistema.
