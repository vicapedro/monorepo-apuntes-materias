# Actividad de Aprendizaje: Estudio de Casos en Administración de Redes


### 📌 Objetivo de la Actividad
Analizar incidentes críticos de infraestructura a nivel global para comprender el funcionamiento real del protocolo BGP (*Border Gateway Protocol*), la importancia de las políticas de filtrado de rutas y la gestión de crisis en la administración de redes a gran escala.


---

## Partes 1: Guía de Preguntas de Análisis para el Alumno

Estimado alumno, tras revisar los enlaces de consulta técnica oficial provistos en la sección de recursos, responde de manera analítica el siguiente cuestionario:

### Sección A: Caso Meta / Facebook (2021) - Falla de Configuración Interna
1. **El bucle de dependencia:** Explica detalladamente cómo la caída del enrutamiento BGP interno provocó que los ingenieros de Meta no pudieran ingresar físicamente a los centros de datos (problema con las tarjetas de acceso). ¿Qué principio de diseño de redes ("Out-of-Band Management") se violó en este escenario?
2. **Propagación del error:** En la cronología del evento, el comando de mantenimiento fue ejecutado en la red troncal (*backbone*). ¿Por qué los servidores DNS autoritativos de Facebook dejaron de responder a nivel mundial si el problema inicial era de enrutamiento y no de servidores DNS?
3. **Mecanismo de mitigación:** ¿Por qué el restablecimiento de los servicios de Meta se tuvo que realizar de forma paulatina y controlada en lugar de encender toda la infraestructura de golpe? (Pista: Considera el impacto en la carga eléctrica y tormentas de peticiones DNS).

### Sección B: Caso YouTube / Pakistan Telecom (2008) - Secuestro de Prefijos (BGP Hijacking)
4. **La regla de la ruta más específica:** YouTube anunciaba globalmente el bloque `208.65.153.0/22`. Pakistan Telecom, por orden gubernamental, anunció el bloque `208.65.153.0/24`. Explica matemáticamente y bajo la lógica de enrutamiento IP por qué los routers de internet de todo el mundo prefirieron la ruta de Pakistán.
5. **Responsabilidad de los operadores (AS):** El AS de Pakistán originó el anuncio erróneo, pero la falla se volvió global porque su proveedor de tránsito (PCCW Global) lo propagó al resto de la tabla de enrutamiento global de internet. ¿Qué tipo de filtros de prefijo (*Prefix Filtering*) debió implementar el proveedor para evitar esto?
6. **Estrategia de defensa:** ¿Qué contramedida técnica utilizó YouTube de forma inmediata para intentar "recuperar" el tráfico legítimo antes de que el proveedor troncal filtrara la ruta falsa?

---

## Parte 2: Diagramas de Flujo Conceptuales

Utiliza estos diagramas para visualizar la diferencia estructural entre ambos tipos de fallas de red.

### Diagrama 1: Falla Interna y Aislamiento Automático (Caso Meta 2021)
Muestra cómo un error de configuración propio causa un efecto dominó que incomunica a la misma empresa.

```text
[ Comando de Mantenimiento Rutinario ]
                  │
                  ▼
[ Desactiva accidentalmente enlaces del Backbone ]
                  │
                  ▼
[ Routers retiran anuncios BGP hacia el exterior ]
                  │
                  ├────────────────────────────────────────┐
                  ▼                                        ▼
[ Internet pierde las rutas hacia Meta ]     [ Red Interna pierde acceso a DNS ]
                  │                                        │
                  ▼                                        ▼
[ Usuarios ven error de conexión ]           [ Herramientas de control de acceso ]
                                             [ físico y SSH quedan INOPERABLES ]
                                                           │
                                                           ▼
                                             [ Ingenieros aislados sin poder ]
                                             [ entrar al Centro de Datos ]
```

### Diagrama 2: Secuestro de Prefijos BGP / Hijacking (Caso YouTube 2008)
Muestra cómo una mala configuración externa altera el tráfico legítimo de internet debido a las reglas de decisión de BGP.

```text
[ Gobierno de Pakistán ordena bloqueo local ]
                      │
                      ▼
[ Pakistan Telecom (AS17557) crea ruta "Agujero Negro" con prefijo /24 ]
                      │
                      ▼
[ Proveedor de Tránsito (PCCW) acepta y propaga el prefijo /24 sin filtrar ]
                      │
                      ▼
[ Routers en Internet comparan ambas rutas disponibles hacia YouTube ]:
  👉 Ruta A (Legítima):  208.65.153.0/22 (Menos específica)
  👉 Ruta B (Pakistán):  208.65.153.0/24 (Más específica)
                      │
                      ▼
[ Lógica BGP: Se selecciona SIEMPRE la máscara de red más larga (/24) ]
                      │
                      ▼
[ El tráfico mundial de YouTube se desvía hacia Pakistán y el servicio colapsa ]
```

---

## Parte 3: Rúbrica de Evaluación Sugerida

| Criterio | Excelente (5 pts) | Satisfactorio (3 pts) | Requiere Mejora (1 pt) |
| :--- | :--- | :--- | :--- |
| **Precisión Técnica** | Identifica correctamente los conceptos de BGP, AS, prefijos IP (`/22` vs `/24`) y direccionamiento de red. | Describe los eventos pero confunde términos de enrutamiento con fallas de capa de aplicación. | No distingue entre fallas de red (BGP) y fallas de software/servidores. |
| **Análisis de Causa Raíz** | Explica claramente la relación causa-efecto del incidente y los cuellos de botella generados en la mitigación. | Describe la cronología del caso pero no profundiza en el porqué de la falla. | Solo copia fragmentos de las fuentes sin realizar un análisis propio. |
| **Uso de Fuentes Técnicas** | Fundamenta sus respuestas utilizando las lecturas del Blog de Meta, Cloudflare o RIPE de forma explícita. | Menciona las fuentes de manera superficial sin correlacionarlas con sus argumentos. | No utiliza las lecturas asignadas para responder el cuestionario. |
