# Práctica 2.3: Acceso remoto seguro con SSH

## Objetivo
Instalar y configurar SSH para administrar un servidor de laboratorio aplicando autenticación individual y controles básicos de acceso.

**Duración estimada:** 1.5 horas

## Competencias a desarrollar
- Configura un servicio de administración remota.
- Aplica principios de autenticación, autorización y mínimo privilegio.
- Comprueba la conectividad y registra acciones de forma responsable.

## Introducción
SSH permite administrar equipos de forma remota mediante una comunicación cifrada. El caso representa un equipo de soporte con integrantes que trabajan desde comunidades y horarios distintos; la administración debe ser segura, trazable y accesible.

## Equipo de protección e higiene
- Usa únicamente la red de laboratorio.
- No habilites acceso SSH desde Internet.
- Conserva una sesión local o de consola antes de modificar `sshd_config`.
- Utiliza cuentas individuales, nunca credenciales compartidas.

## Material y equipo necesario
- Servidor Debian/Ubuntu, VM o equipo físico.
- Cliente Linux, Windows con OpenSSH o terminal de GNS3/PNetLab.
- VirtualBox, VMware, GNS3, PNetLab o laboratorio físico.

## Instrucciones
1. Instala y activa OpenSSH:
   ```bash
   sudo apt update
   sudo apt install -y openssh-server
   sudo systemctl enable --now ssh
   ```
2. Crea una cuenta individual de laboratorio y verifica su grupo:
   ```bash
   sudo adduser soporte-lab
   id soporte-lab
   ```
3. Desde el cliente prueba la conexión y registra la identidad utilizada:
   ```bash
   ssh soporte-lab@192.168.50.1
   whoami
   hostname
   ```
4. Genera una llave SSH en el cliente y prueba autenticación con llave, sin compartir la clave privada.
5. Revisa los registros de acceso:
   ```bash
   sudo journalctl -u ssh --since today
   ```
6. Configura una restricción sencilla, como permitir SSH solo desde `192.168.50.0/24`, valida la sintaxis y reinicia el servicio.
7. Verifica que una cuenta sin autorización no pueda administrar el servidor.

## Evidencias
- E1: servicio SSH activo y puerto en escucha.
- E2: conexión con cuenta individual.
- E3: autenticación con llave o política de acceso documentada.
- E4: registro de acceso y reflexión sobre mínimo privilegio.

## Preguntas de análisis
1. ¿Por qué una cuenta individual mejora la trazabilidad?
2. ¿Qué diferencia hay entre autenticación y autorización?
3. ¿Qué alternativa ofrecerías a quien no puede utilizar la misma herramienta de terminal?

## Evaluación
Lista de cotejo: instalación, conexión segura, cuenta individual, restricción de acceso, registro y documentación.

## Notas
En routers Cisco puede repetirse el objetivo con usuario local, claves RSA y `transport input ssh`; no es necesario configurar Telnet.
