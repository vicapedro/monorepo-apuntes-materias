# Tarea: Comparativa de Estándares de Ejecución Remota

## Descripción

Implemente un procedimiento remoto que sume dos números enteros y devuelva el resultado como cadena de caracteres, utilizando cada uno de los siguientes estándares de comunicación remota:

- **RPC** (Remote Procedure Call)
- **RMI** (Remote Method Invocation)
- **DCOM** (Distributed Component Object Model)

La firma del procedimiento debe seguir este esquema:

```
String resultado = sumaRemota(3, 4);
// resultado esperado: "7"
```

Para apreciar las diferencias entre los estándares, el servidor y el cliente de cada implementación **deben estar escritos en lenguajes de programación distintos**. Si es posible, utilice también arquitecturas diferentes (por ejemplo, x86 vs. ARM, o Windows vs. Linux).

## Tabla resumen

Al finalizar las implementaciones, complete la siguiente tabla:

| Protocolo | Lenguaje del Servidor | Lenguaje del Cliente |
|-----------|-----------------------|----------------------|
| RPC       |                       |                      |
| RMI       |                       |                      |
| DCOM      |                       |                      |

## Entregables

1. Código fuente completo del cliente y del servidor para cada uno de los tres protocolos.
2. Evidencia del funcionamiento (capturas de pantalla o video) que muestre la comunicación entre cliente y servidor.

---

## Rubrica de Evaluación

| Criterio | Excelente (3) | Satisfactorio (2) | Insuficiente (1) |
|----------|---------------|-------------------|------------------|
| **Implementación técnica** | Los tres protocolos funcionan correctamente y el resultado se devuelve como cadena de caracteres en todos los casos. | Al menos dos protocolos funcionan correctamente. | Solo un protocolo funciona o ninguno devuelve el resultado esperado. |
| **Heterogeneidad de lenguajes** | Cada implementación usa lenguajes distintos en cliente y servidor; se emplea al menos una arquitectura diferente. | Cada implementación usa lenguajes distintos en cliente y servidor, pero la arquitectura es la misma. | Cliente y servidor están escritos en el mismo lenguaje en una o más implementaciones. |
| **Calidad del código** | Código limpio, con nombres descriptivos, sin redundancias y con manejo básico de errores. | Código funcional con estructura aceptable, aunque con algunas inconsistencias o sin manejo de errores. | Código difícil de leer, sin estructura clara o con errores frecuentes. |
| **Evidencia de funcionamiento** | Capturas o video que muestran claramente la comunicación cliente-servidor para los tres protocolos. | Evidencia parcial que cubre al menos dos protocolos. | Evidencia ausente o que no permite verificar el funcionamiento.


