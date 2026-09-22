# Práctica 5: Gestión de Contabilidad mediante un reporte de showback

## Objetivo

Organizar registros sencillos de consumo de red, calcular el uso y costo equivalente por área, y elaborar un reporte de **showback** que permita tomar decisiones de administración de recursos.

**Duración estimada:** 1.5 horas

## Competencias a desarrollar

- Aplica las funciones de la administración de redes para la optimización del desempeño y el aseguramiento de las mismas.
- Identifica el recurso, servicio, consumidor, unidad de medida y periodo de un registro de uso.
- Calcula consumo y costo equivalente mediante una regla documentada.
- Interpreta información de Accounting para proponer acciones de capacidad, cuotas o mejora del servicio.

## Introducción

La Gestión de Contabilidad o **Accounting Management** permite conocer qué recurso se utilizó, quién lo utilizó, durante cuánto tiempo y en qué cantidad. La información puede emplearse para elaborar reportes operativos, aplicar cuotas, distribuir costos o justificar una ampliación de capacidad.

En esta práctica se analizarán registros simulados de consumo de Internet de tres departamentos de una institución educativa. El resultado será un reporte de **showback**: se mostrará el consumo y su costo equivalente, pero no se realizará un cobro real.

La práctica se relaciona con [1.3 Contabilidad - Enfoque ITU-T.md](../1.3%20Contabilidad%20-%20Enfoque%20ITU-T.md).

## Equipo de protección e higiene

- Trabaja únicamente con datos simulados; no utilices nombres reales ni información personal.
- Guarda una copia del archivo original antes de modificarlo.
- No presentes el costo equivalente como una factura real.
- Documenta las unidades y periodos utilizados para evitar comparaciones incorrectas.

## Material y equipo necesario

### Materiales e insumos

- Archivo de hoja de cálculo o una hoja de trabajo.
- Calculadora, LibreOffice Calc, Microsoft Excel o Google Sheets.
- Documento para elaborar el reporte final.

### Equipo de laboratorio

- Computadora con acceso a la red local, si se utiliza un archivo compartido.
- Opcional: servidor Syslog, colector NetFlow/IPFIX o registros previamente exportados.

## Datos del caso

Una institución desea conocer el consumo mensual de Internet de sus áreas. La tarifa interna de referencia es de **$0.80 por GB**. La tarifa solo se utiliza para mostrar el costo equivalente.

| Registro | Área | Servicio | Periodo | Entrada (GB) | Salida (GB) | Fuente | Estado |
|---|---|---|---|---:|---:|---|---|
| 1 | Investigación | Internet institucional | Septiembre | 860 | 210 | IPFIX | Validado |
| 2 | Administración | Internet institucional | Septiembre | 420 | 180 | IPFIX | Validado |
| 3 | Biblioteca | Internet institucional | Septiembre | 310 | 95 | IPFIX | Validado |
| 4 | Investigación | Internet institucional | Septiembre | 120 | 40 | IPFIX | Duplicado |
| 5 | Administración | Internet institucional | Septiembre | 90 | 30 | IPFIX | Validado |
| 6 | Biblioteca | Internet institucional | Septiembre | 75 | 20 | IPFIX | Validado |
| 7 | Invitados | Wi-Fi visitantes | Septiembre | 250 | 110 | SNMP estimado | Sin validar |

## Instrucciones

### Parte 1: Identificar el modelo de medición

Completa la siguiente ficha antes de realizar cálculos:

| Elemento | Respuesta |
|---|---|
| Recurso contabilizado | |
| Servicio | |
| Sujetos de consumo | |
| Unidad de medida | |
| Periodo | |
| Fuente de datos | |
| Tarifa aplicada | |
| Registros excluidos y motivo | |

**Evidencia E1:** ficha del modelo de medición completa.

### Parte 2: Validar los registros

1. Revisa los registros de la tabla.
2. Identifica el registro duplicado.
3. Identifica el registro cuya fuente aún no está validada.
4. Decide si el registro de Invitados debe:
   - Excluirse del reporte principal.
   - Presentarse como dato separado y no validado.
   - Integrarse después de una verificación.
5. Justifica la decisión en tu reporte.

**Evidencia E2:** tabla de validación con registros incluidos, excluidos y pendientes.

### Parte 3: Calcular el consumo

1. Para cada registro validado, calcula el total:

   $$
   Consumo\ total = Entrada + Salida
   $$

2. Agrupa los registros por área.
3. No incluyas el registro duplicado.
4. Mantén separado el consumo de Invitados si decidiste no validarlo.
5. Calcula el porcentaje que representa cada área respecto al total validado:

   $$
   Porcentaje = \frac{Consumo\ del\ área}{Consumo\ total\ validado} \times 100
   $$

**Evidencia E3:** hoja de cálculo con fórmulas visibles o cálculos claramente documentados.

### Parte 4: Calcular el costo equivalente y elaborar el showback

1. Aplica la tarifa de $0.80 por GB:

   $$
   Costo\ equivalente = Consumo\ validado \times 0.80
   $$

2. Elabora una tabla como la siguiente:

| Área | Consumo validado (GB) | Porcentaje | Tarifa | Costo equivalente | Observaciones |
|---|---:|---:|---:|---:|---|
| Investigación | | | $0.80/GB | | |
| Administración | | | $0.80/GB | | |
| Biblioteca | | | $0.80/GB | | |
| Invitados | | | $0.80/GB | | Dato separado o no validado |
| **Total** | | | | | |

3. Incluye una gráfica de barras o circular con el consumo por área.
4. Titula el documento **Reporte de showback de consumo de red**.
5. Incluye una nota visible: *El costo mostrado es equivalente y no representa un cargo contable real.*

**Evidencia E4:** reporte de showback con tabla, gráfica, tarifa y nota de alcance.

### Parte 5: Interpretar y tomar decisiones

Redacta una recomendación de cinco a ocho líneas que responda:

1. ¿Qué área presenta el mayor consumo?
2. ¿Qué dato no debe utilizarse todavía para aplicar un cargo?
3. ¿Qué acción recomendarías: monitoreo adicional, cuota, optimización, ampliación o validación de datos?
4. ¿Qué información adicional solicitarías antes de implementar chargeback?
5. ¿Qué control de privacidad aplicarías al reporte?

**Evidencia E5:** recomendación administrativa sustentada en los resultados.

## Resultado esperado

Un reporte de showback que contenga:

- Modelo de medición.
- Validación de registros.
- Cálculos de consumo y costo equivalente.
- Tabla y gráfica por área.
- Tratamiento del registro duplicado y del dato no validado.
- Recomendación administrativa.

## Preguntas de reflexión

1. ¿Por qué un contador de bytes no es suficiente para justificar un costo?
2. ¿Qué problema produciría incluir el registro duplicado?
3. ¿Por qué showback y chargeback no son exactamente lo mismo?
4. ¿Cómo se relaciona Accounting con Desempeño y Seguridad?
5. ¿Qué podría ocurrir si el reporte no indica su fuente ni periodo?

## Evidencia y evaluación

**Instrumento sugerido:** lista de cotejo.

| Criterio | Cumple | No cumple |
|---|---|---|
| Identifica correctamente recurso, servicio, consumidor, unidad y periodo | | |
| Detecta y justifica el tratamiento del registro duplicado | | |
| Identifica el dato no validado y evita presentarlo como definitivo | | |
| Calcula correctamente el consumo por registro y por área | | |
| Aplica la tarifa documentada sin confundir showback con cobro real | | |
| Presenta tabla y gráfica legibles | | |
| Formula una recomendación basada en los resultados | | |
| Incluye consideraciones de privacidad y trazabilidad | | |
| Responde las preguntas de reflexión | | |

## Notas

- Los resultados esperados para los registros validados son: Investigación, **1,070 GB**; Administración, **630 GB**; Biblioteca, **480 GB**; total validado, **2,180 GB**.
- El costo equivalente total validado es de **$1,744.00**.
- El registro duplicado de Investigación no debe sumarse.
- El consumo de Invitados puede presentarse como dato separado porque su fuente está marcada como no validada.
- Si se realiza la práctica con datos reales de SNMP, NetFlow o IPFIX, conserva la fuente, el intervalo de medición, la unidad y el método de agregación.
