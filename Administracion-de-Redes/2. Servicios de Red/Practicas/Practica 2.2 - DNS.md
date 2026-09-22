# Práctica 2.2: Resolución de nombres con DNS

## Objetivo
Configurar un servicio DNS local para resolver nombres de una organización pequeña y comprobar su funcionamiento desde un cliente.

**Duración estimada:** 1.5 horas

## Competencias a desarrollar
- Instala y administra un servicio DNS básico.
- Analiza la relación entre nombre, dirección IP y servicio.
- Documenta resultados en un formato accesible para otras personas.

## Introducción
DNS permite utilizar nombres comprensibles en lugar de memorizar direcciones IP. El caso representa una cooperativa comunitaria con servicios web y de archivos; los nombres deben ser claros para personal técnico y no técnico.

## Equipo de protección e higiene
- Trabaja en una red aislada y utiliza nombres de dominio de laboratorio, por ejemplo `cooperativa.test`.
- No publiques registros internos en DNS público.
- No incluyas nombres reales de personas en las capturas.

## Material y equipo necesario
- VM Debian/Ubuntu o servidor físico.
- Cliente Linux o Windows.
- VirtualBox, VMware, GNS3, PNetLab o laboratorio físico.
- `bind9`, `dnsutils` y navegador web opcional.

## Instrucciones
1. Define la red `192.168.50.0/24` y los registros `dns.cooperativa.test`, `web.cooperativa.test` y `archivos.cooperativa.test`.
2. Instala BIND9 y utilidades:
   ```bash
   sudo apt update
   sudo apt install -y bind9 dnsutils
   ```
3. Crea una zona directa y, si es posible, una zona inversa para la red de laboratorio.
4. Reinicia y valida la configuración:
   ```bash
   sudo named-checkconf
   sudo systemctl restart bind9
   dig @192.168.50.1 web.cooperativa.test
   ```
5. Configura el cliente para usar el DNS del laboratorio y comprueba:
   ```bash
   nslookup web.cooperativa.test
   ping -c 3 web.cooperativa.test
   ```
6. Modifica deliberadamente un registro, documenta el cambio y verifica el nuevo resultado.
7. Como alternativa, configura el servicio en un router de GNS3/PNetLab o utiliza un DNS equivalente disponible en el laboratorio físico.

## Evidencias
- E1: tabla de nombres y direcciones.
- E2: archivos o pantalla de configuración de la zona.
- E3: salida de `dig` o `nslookup` correcta.
- E4: prueba de resolución inversa o análisis de una falla controlada.

## Preguntas de análisis
1. ¿Qué diferencia hay entre resolver un nombre y comprobar que el servicio funciona?
2. ¿Qué consecuencia tendría un registro desactualizado?
3. ¿Cómo proporcionarías instrucciones equivalentes a una persona que usa Windows, Linux o un lector de pantalla?

## Evaluación
Lista de cotejo: zona válida, consultas exitosas, documentación clara, prueba de cambio y explicación técnica.

## Notas
Si no se dispone de permisos para cambiar DNS del cliente, ejecuta consultas explícitas con `dig @IP_DEL_DNS` y documenta la limitación.
