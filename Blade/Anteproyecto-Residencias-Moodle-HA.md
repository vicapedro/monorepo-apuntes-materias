# Instituto Tecnológico [Nombre del Plantel]
## Tecnológico Nacional de México

---

# SOLICITUD DE RESIDENCIA PROFESIONAL
## Anteproyecto

**Departamento de:** Sistemas y Computación  
**Carrera:** Ingeniería en Sistemas Computacionales  
**Periodo:** [Mes] – [Mes] de [Año]

---

## I. DATOS GENERALES DEL PROYECTO

| Campo | Información |
|-------|-------------|
| **Nombre del proyecto** | Implementación de una Plataforma Moodle de Alto Desempeño y Alta Disponibilidad sobre Infraestructura de Virtualización Proxmox VE |
| **Área de desarrollo** | Infraestructura de TI — Departamento de Sistemas y Computación |
| **Organización receptora** | Instituto Tecnológico [Nombre del Plantel] / TecNM |
| **Domicilio** | [Dirección del plantel] |
| **Duración** | 4 meses (480 horas mínimas) |
| **Fecha de inicio propuesta** | [DD/MM/AAAA] |
| **Fecha de término propuesta** | [DD/MM/AAAA] |

---

## II. DATOS DEL RESIDENTE 1

| Campo | Información |
|-------|-------------|
| **Nombre completo** | [Apellido Paterno] [Apellido Materno] [Nombre(s)] |
| **Número de control** | [##XXXXX] |
| **Carrera** | Ingeniería en Sistemas Computacionales |
| **Semestre** | [#] |
| **Créditos acreditados** | [XX]% |
| **Teléfono** | [10 dígitos] |
| **Correo institucional** | [numero_control]@[dominio_tecnm.mx] |

---

## III. DATOS DEL RESIDENTE 2

| Campo | Información |
|-------|-------------|
| **Nombre completo** | [Apellido Paterno] [Apellido Materno] [Nombre(s)] |
| **Número de control** | [##XXXXX] |
| **Carrera** | Ingeniería en Sistemas Computacionales |
| **Semestre** | [#] |
| **Créditos acreditados** | [XX]% |
| **Teléfono** | [10 dígitos] |
| **Correo institucional** | [numero_control]@[dominio_tecnm.mx] |

---

## IV. DATOS DEL ASESOR INTERNO

| Campo | Información |
|-------|-------------|
| **Nombre completo** | [Nombre del Asesor] |
| **Grado académico** | [Maestro / Doctor en ...] |
| **Departamento** | Sistemas y Computación |
| **Teléfono / extensión** | [Teléfono] |
| **Correo** | [correo@dominio_tecnm.mx] |

---

## V. DATOS DEL ASESOR EXTERNO

| Campo | Información |
|-------|-------------|
| **Nombre completo** | [Nombre del responsable en la organización] |
| **Cargo** | Jefe del Departamento de Sistemas / Coordinador de TI |
| **Organización** | Instituto Tecnológico [Nombre del Plantel] |
| **Teléfono** | [Teléfono] |
| **Correo** | [correo@dominio] |

---

## VI. DESCRIPCIÓN DEL PROBLEMA

El Instituto Tecnológico [Nombre del Plantel] utiliza Moodle como plataforma de gestión de aprendizaje (LMS) para la administración de cursos, entrega de actividades, aplicación de evaluaciones y comunicación docente-alumno. La instalación actual opera sobre un servidor único, sin redundancia, lo que representa un riesgo crítico de disponibilidad para los procesos académicos.

Durante periodos de alta demanda —parciales, entrega de proyectos finales, inicio de semestre— el sistema presenta degradación notable en los tiempos de respuesta, afectando la experiencia de docentes y alumnos. Adicionalmente, cualquier falla en el servidor único implica la interrupción total del servicio sin posibilidad de recuperación automática.

El plantel cuenta con un servidor tipo blade HP BladeSystem c-Class con 14 nodos de cómputo y almacenamiento SAN HP P2000, actualmente con capacidad subutilizada. Esta infraestructura, configurada con Proxmox VE como hipervisor, representa una oportunidad para implementar una arquitectura de alta disponibilidad que elimine el punto único de falla y mejore el desempeño de la plataforma Moodle institucional.

---

## VII. OBJETIVOS

### Objetivo General

Implementar una plataforma Moodle de alto desempeño y alta disponibilidad mediante una arquitectura de múltiples nodos virtualizados sobre Proxmox VE, garantizando continuidad del servicio ante fallos de componentes y soporte a carga concurrente de usuarios.

### Objetivos Específicos

1. Diseñar la arquitectura de alta disponibilidad para la plataforma Moodle, definiendo roles, VMs, red y almacenamiento compartido.
2. Implementar un clúster de base de datos MariaDB Galera con tres nodos para replicación síncrona y failover automático.
3. Configurar almacenamiento compartido NFS para el directorio `moodledata` accesible desde todos los nodos de aplicación.
4. Desplegar dos instancias de la aplicación Moodle con PHP-FPM y Nginx, optimizadas con OPcache y Redis para gestión de sesiones y caché.
5. Implementar balanceo de carga con HAProxy y alta disponibilidad de IP virtual con Keepalived.
6. Integrar monitoreo activo con Prometheus y Grafana para visualización de métricas de disponibilidad y desempeño.
7. Realizar pruebas de carga con un mínimo de 200 usuarios concurrentes simulados y documentar los resultados.
8. Elaborar la documentación técnica completa del sistema implementado.

---

## VIII. JUSTIFICACIÓN

La continuidad de los servicios académicos digitales es un factor crítico en la formación de los estudiantes del TecNM. La dependencia de un servidor único para la operación de Moodle representa un riesgo institucional que puede traducirse en:

- Pérdida de información de evaluaciones y actividades en curso
- Imposibilidad de entrega de evidencias en fechas límite
- Afectación a procesos de evaluación institucional y acreditación

Desde la perspectiva de formación de competencias, este proyecto permite que los residentes apliquen de manera integrada conocimientos de:

- Administración de sistemas operativos Linux
- Redes de computadoras y configuración de VLANs
- Bases de datos distribuidas y replicación
- Virtualización y administración de hipervisores
- Monitoreo de infraestructura y análisis de desempeño
- Seguridad en servidores y servicios web

El uso de la infraestructura blade existente en el plantel optimiza la inversión institucional ya realizada, sin requerir adquisición de equipamiento adicional. La solución propuesta es replicable y documentada, lo que permite que futuras generaciones de residentes o alumnos de materias afines continúen su evolución.

---

## IX. ALCANCES Y LIMITACIONES

### Alcances

- La implementación se realizará como prueba de concepto (PoC) sobre la infraestructura blade del plantel
- Se configurarán un mínimo de 6 máquinas virtuales: 3 nodos de BD, 2 nodos de aplicación, 1 balanceador
- Las pruebas de disponibilidad incluirán simulación de caída de nodos individuales
- El sistema quedará documentado y funcional al término de la residencia
- Se entregará manual de operación y procedimientos de mantenimiento

### Limitaciones

- No se migrará el contenido de la instancia Moodle de producción actual durante la residencia; la implementación será un ambiente paralelo de PoC
- El acceso a la infraestructura física depende de la disponibilidad del cuarto de servidores y los permisos del Departamento de TI
- Las pruebas de carga se realizarán en horario de baja demanda para no afectar otros servicios en el blade
- La integración con el SSO institucional (si existe) queda fuera del alcance de esta residencia

---

## X. FUNDAMENTO TEÓRICO (Preliminar)

Los temas centrales que sustentan el desarrollo del proyecto son:

- **Virtualización con KVM/Proxmox VE:** Gestión de máquinas virtuales, alta disponibilidad de nodos, migración en vivo (live migration)
- **Alta disponibilidad (HA):** Conceptos de SPOF (Single Point of Failure), RTO/RPO, heartbeat, failover automático
- **MariaDB Galera Cluster:** Replicación síncrona multi-master, quórum, resolución de conflictos
- **Balanceo de carga:** Algoritmos round-robin, least-connections; HAProxy como proxy de capa 7
- **Keepalived y VRRP:** Protocolo de redundancia de router virtual para IP flotante
- **Moodle:** Arquitectura de la aplicación, requerimientos de PHP, configuración para múltiples nodos, gestión de sesiones
- **Redis:** Almacenamiento en memoria, persistencia, uso como caché de sesiones PHP
- **NFS:** Sistema de archivos en red, consideraciones de rendimiento y consistencia para `moodledata`
- **Prometheus y Grafana:** Modelo de métricas pull, exporters, dashboards y alertas

---

## XI. PLAN DE TRABAJO

| Semana | Fase | Actividades | Responsable |
|--------|------|-------------|-------------|
| 1 | Análisis y diseño | Revisión de infraestructura, diseño de arquitectura, definición de red y VLANs, creación de VMs base | Ambos |
| 2 | Diseño | Elaboración de diagrama de red, plan de pruebas, configuración de repositorios de documentación | Ambos |
| 3 | Base de datos | Instalación y configuración de MariaDB Galera nodo 1 | R1 |
| 4 | Base de datos | Integración nodos 2 y 3, pruebas de replicación y failover de BD | R1 |
| 5 | Almacenamiento | Configuración de servidor NFS, montaje en nodos de aplicación, pruebas de lectura/escritura | R1 |
| 6 | Caché y sesiones | Instalación y configuración de Redis, integración con PHP para gestión de sesiones | R2 |
| 7 | Aplicación Moodle | Instalación de Moodle en nodo de aplicación 1, configuración PHP-FPM y Nginx | R2 |
| 8 | Aplicación Moodle | Replicación a nodo de aplicación 2, sincronización de configuración, pruebas de funcionamiento | R2 |
| 9 | Balanceo de carga | Instalación HAProxy, configuración de backends, health checks | R1 |
| 10 | Alta disponibilidad | Configuración Keepalived, IP virtual, pruebas de failover del balanceador | R1 |
| 11 | Monitoreo | Instalación Prometheus + exporters (node, mysqld, nginx, haproxy), dashboards Grafana | R1 |
| 12 | Hardening y TLS | Certificado TLS interno (Let's Encrypt o CA propia), hardening Nginx y SSH | R2 |
| 13 | Pruebas de carga | Diseño de escenarios JMeter/k6, ejecución con 100/200 usuarios, análisis de resultados | Ambos |
| 14 | Pruebas de HA | Simulación de caídas de nodos (BD, app, balanceador), medición de RTO/RPO | Ambos |
| 15 | Documentación | Redacción de reporte técnico, manual de operación, procedimientos de mantenimiento | Ambos |
| 16 | Cierre | Revisión con asesor, correcciones, presentación final, entrega de documentos | Ambos |

**R1 = Residente 1 (énfasis infraestructura) / R2 = Residente 2 (énfasis aplicación)**

---

## XII. RECURSOS DISPONIBLES

### Hardware (existente en el plantel)

| Recurso | Descripción | Disponibilidad |
|---------|-------------|----------------|
| Servidor blade | HP BladeSystem c-Class, 8+ nodos activos con Proxmox VE | Confirmado |
| Nodos de cómputo | HP ProLiant BL465c Gen8, AMD Opteron 6348 (24 cores), 64 GB RAM | Confirmado |
| Almacenamiento | HP P2000 SAN Fibre Channel | Confirmado |
| Red | Switches LAN duales + SAN switches duales en chasis | Confirmado |

### Software (libre/open source — sin costo de licencia)

- Proxmox VE 8 (hipervisor, ya instalado)
- Debian 12 / Ubuntu Server 24.04 LTS (sistema base de VMs)
- MariaDB 10.11 + Galera Cluster
- Moodle LMS (versión LTS vigente)
- PHP 8.2 + PHP-FPM + OPcache
- Nginx
- Redis 7
- HAProxy 2.8
- Keepalived
- Prometheus + Grafana
- Apache JMeter / k6

### Recursos humanos

- 2 residentes ISC con conocimientos en Linux, redes y bases de datos
- 1 asesor interno del Departamento de Sistemas
- 1 asesor externo / responsable de TI del plantel

---

## XIII. ENTREGABLES

1. Sistema Moodle HA funcional desplegado en infraestructura blade del plantel (PoC)
2. Documentación técnica de arquitectura e implementación
3. Manual de operación y procedimientos de administración
4. Dashboard de monitoreo (Grafana) con alertas configuradas
5. Informe de resultados de pruebas de carga y disponibilidad
6. Reporte de residencias profesionales (formato TecNM)

---

## XIV. FIRMAS

---

**Residente 1**

Nombre: _______________________________________________

Firma: ________________________________________________  Fecha: _______________

---

**Residente 2**

Nombre: _______________________________________________

Firma: ________________________________________________  Fecha: _______________

---

**Asesor Interno**

Nombre: _______________________________________________

Grado: ________________________________________________

Firma: ________________________________________________  Fecha: _______________

---

**Jefe del Departamento de Sistemas y Computación**

Nombre: _______________________________________________

Firma: ________________________________________________  Fecha: _______________

---

**Vo. Bo. Subdirección Académica**

Nombre: _______________________________________________

Firma: ________________________________________________  Fecha: _______________

---

*Documento elaborado conforme a los lineamientos de Residencias Profesionales del Tecnológico Nacional de México.*
