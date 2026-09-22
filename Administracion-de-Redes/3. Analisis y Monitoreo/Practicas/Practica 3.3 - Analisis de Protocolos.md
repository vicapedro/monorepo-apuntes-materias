# Práctica 3.3: Análisis de protocolos con Wireshark o tcpdump

## Objetivo
Capturar tráfico en una red de laboratorio, identificar protocolos y analizar una comunicación sin inspeccionar información personal ni tráfico externo.

**Duración estimada:** 1.5 horas

## Competencia
Analiza y monitorea la red para medir su desempeño y fiabilidad con herramientas de software.

## Introducción
Un analizador de protocolos muestra cómo se comunican los equipos y permite observar DNS, DHCP, HTTP, ICMP, TCP u otros protocolos. La captura debe realizarse con autorización y en un entorno controlado.

## Equipo de protección e higiene
- Captura únicamente tráfico generado por tu equipo o por el laboratorio autorizado.
- No captures contraseñas, conversaciones ni navegación de otras personas.
- Utiliza filtros para reducir la exposición de datos.
- Elimina las capturas al terminar si contienen información sensible.

## Material y equipo necesario
- Wireshark en un equipo físico o VM, o `tcpdump` en Linux.
- Dos clientes y un servidor, router o switch en VirtualBox, VMware, GNS3, PNetLab o laboratorio físico.
- Un servicio local: DNS, HTTP, DHCP o SSH.

## Instrucciones
1. Elige una comunicación permitida: consulta DNS, solicitud HTTP local, ping o renovación DHCP.
2. Inicia Wireshark en la interfaz correcta o ejecuta:
   ```bash
   sudo tcpdump -ni any -c 50
   ```
3. Genera el tráfico seleccionado.
4. Aplica filtros de captura o visualización, por ejemplo `dns`, `dhcp`, `icmp`, `http` o `tcp.port == 22`.
5. Identifica origen, destino, protocolo, puertos, cantidad de paquetes y resultado.
6. Captura una evidencia del intercambio sin mostrar datos sensibles.
7. Explica qué no puede concluirse únicamente a partir de una captura.
8. Repite con una comunicación fallida controlada, como un puerto cerrado del laboratorio, y compara los paquetes.

## Evidencias
- E1: diagrama y permiso de captura.
- E2: captura filtrada del protocolo elegido.
- E3: tabla de paquetes relevantes.
- E4: comparación entre comunicación exitosa y fallida.
- E5: reflexión ética y de privacidad.

## Preguntas de análisis
1. ¿Qué diferencia hay entre una captura y una conclusión sobre la causa del problema?
2. ¿Qué información puede quedar expuesta en protocolos sin cifrado?
3. ¿Cómo ofrecerías una alternativa textual a quien no puede utilizar la interfaz gráfica?

## Evaluación
Lista de cotejo: captura autorizada, filtro, identificación de campos, comparación, privacidad y conclusión.

## Notas
Si la interfaz de captura no está disponible en el simulador, usa un nodo Linux conectado a la topología o analiza un archivo `.pcap` preparado por la persona docente.
