# Práctica 2.6: Sistema de archivos en red NFS

## Objetivo
Compartir un directorio mediante NFS entre un servidor y un cliente, aplicando permisos básicos y verificando el acceso controlado.

**Duración estimada:** 1.5 horas

## Competencias a desarrollar
- Configura un servicio de archivos en red.
- Aplica permisos y restricciones según una necesidad organizacional.
- Verifica disponibilidad, acceso e integridad de archivos.

## Introducción
NFS permite que un cliente utilice un directorio compartido en un servidor. El caso representa un equipo de trabajo que comparte materiales de una cooperativa, procurando que las personas puedan colaborar sin otorgar permisos excesivos.

## Equipo de protección e higiene
- Utiliza una red aislada y archivos de prueba.
- No exportes `/home` completo ni el sistema de archivos raíz.
- No incluyas información personal en el directorio compartido.

## Material y equipo necesario
- Dos VM Debian/Ubuntu, dos equipos físicos o nodos Linux en GNS3/PNetLab.
- `nfs-kernel-server`, `nfs-common`, `mount` y herramientas de permisos.
- La plataforma queda a elección del equipo.

## Instrucciones
1. Define un servidor `192.168.50.1` y un cliente `192.168.50.20`.
2. En el servidor instala y crea el directorio compartido:
   ```bash
   sudo apt update
   sudo apt install -y nfs-kernel-server
   sudo mkdir -p /srv/compartido
   echo "Archivo de colaboración" | sudo tee /srv/compartido/lectura.txt
   ```
3. Exporta el directorio únicamente a la red de laboratorio mediante `/etc/exports`.
4. Aplica y verifica la exportación:
   ```bash
   sudo exportfs -ra
   sudo exportfs -v
   sudo systemctl status nfs-server --no-pager
   ```
5. En el cliente instala `nfs-common`, crea un punto de montaje y monta el recurso.
6. Verifica lectura y prueba escritura solo si la política lo permite.
7. Cambia los permisos del directorio y documenta el efecto en el cliente.
8. Desmonta el recurso y explica cómo se protegería en producción.

## Evidencias
- E1: diagrama y permisos del directorio.
- E2: exportación visible en el servidor.
- E3: montaje exitoso en el cliente.
- E4: prueba de permiso permitido y rechazado.

## Preguntas de análisis
1. ¿Por qué se limita la exportación a una red específica?
2. ¿Qué diferencia hay entre disponibilidad del recurso y autorización para escribir?
3. ¿Cómo ofrecerías el material a personas que no pueden instalar un cliente NFS?

## Evaluación
Lista de cotejo: exportación, montaje, permisos, pruebas, seguridad y documentación.

## Notas
Una alternativa accesible es realizar la práctica en dos máquinas virtuales; no se requiere hardware físico si la red virtual permite comunicación entre ambas.
