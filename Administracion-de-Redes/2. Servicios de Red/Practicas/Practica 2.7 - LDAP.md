# Práctica 2.7: Directorio de usuarios con LDAP

## Objetivo
Instalar un directorio LDAP de laboratorio, crear una estructura mínima de usuarios y grupos, y realizar consultas autenticadas sin utilizar datos personales reales.

**Duración estimada:** 2 horas

## Competencias a desarrollar
- Configura un servicio centralizado de identidad.
- Organiza usuarios y grupos conforme a una política de control.
- Reconoce la relación entre identidad, autorización y servicios de red.

## Introducción
LDAP organiza información de identidades y grupos para que varios servicios puedan consultarla. El caso representa una organización educativa que atiende a personas con diferentes roles y necesita evitar cuentas duplicadas.

## Equipo de protección e higiene
- Usa nombres ficticios como `ana`, `luis` o `grupo-soporte`.
- Trabaja solo en la red de laboratorio.
- No habilites LDAP sin TLS en producción.
- No almacenes contraseñas reales en el reporte.

## Material y equipo necesario
- VM Debian/Ubuntu o servidor físico.
- Cliente LDAP opcional.
- Paquetes `slapd`, `ldap-utils` y, si se requiere, una interfaz web de administración.
- VirtualBox, VMware, GNS3, PNetLab o laboratorio físico.

## Instrucciones
1. Instala OpenLDAP y sus utilidades:
   ```bash
   sudo apt update
   sudo apt install -y slapd ldap-utils
   ```
2. Define un dominio de laboratorio, por ejemplo `dc=campus,dc=test`.
3. Crea una unidad organizativa, dos usuarios ficticios y un grupo.
4. Consulta el directorio:
   ```bash
   ldapsearch -x -LLL -H ldap://127.0.0.1 -b dc=campus,dc=test
   ```
5. Comprueba que una cuenta puede localizarse y que el grupo contiene únicamente las personas previstas.
6. Documenta qué servicio podría consultar LDAP y qué controles adicionales requeriría.
7. Si el equipo no puede instalar LDAP, construye el árbol de directorio y las consultas con un nodo Linux disponible, explicando la limitación.

## Evidencias
- E1: árbol de directorio de laboratorio.
- E2: usuarios y grupo creados.
- E3: salida de `ldapsearch` sin contraseñas.
- E4: política de acceso y propuesta de TLS.

## Preguntas de análisis
1. ¿Qué diferencia hay entre autenticar una identidad y autorizarla para un recurso?
2. ¿Qué riesgo existe al mantener cuentas locales duplicadas en cada servidor?
3. ¿Cómo adaptarías las instrucciones para estudiantes con distintos niveles de experiencia?

## Evaluación
Lista de cotejo: instalación, estructura, consulta, control de acceso, privacidad y documentación.

## Notas
La práctica puede sustituirse por una demostración guiada si el hardware no permite ejecutar una VM adicional; la evidencia debe incluir el árbol y las consultas explicadas.
