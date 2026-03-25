# Proyecto Blade: Estrategia Académica y Operativa

Instituto: TecNM  
Programa: Ingeniería en Sistemas Computacionales  
Alcance: Uso académico multi-materia de un servidor tipo blade con 8 nodos

## 1) Resumen ejecutivo
- Plataforma objetivo: Proxmox VE (cluster de 8 blades) para virtualización KVM/LXC, SDN, alta disponibilidad, backups y API.
- Seguridad y facilidad de uso: Acceso por roles, plantillas con cloud-init, redes por curso (VLAN), autoservicio limitado para docentes.
- Escenarios didácticos: Soporte a BD distribuidas, SO con contenedores/Kubernetes, Redes y servicios, Web/Móvil y Pruebas de software.
- Migración: De VMware 6.5 a Proxmox con ventana controlada, importación OVA/OVF y validación progresiva.

## 2) Objetivos
- Pedagógicos: Aprendizajes prácticos con escenarios realistas (multi-nodo, alto nivel de disponibilidad, CI/CD).
- Técnicos: Aislar entornos por curso, reducir riesgo operativo, facilitar despliegues a docentes vía plantillas y automatización.

## 3) Decisión de plataforma
- Opción recomendada: Proxmox VE 8
  - KVM y LXC (contenerización ligera)
  - Clustering y HA
  - SDN y VLANs por curso
  - Proxmox Backup Server (PBS)
  - Integración LDAP/AD y API robusta
  - Suscripción opcional (no obligatoria)
- VMware 6.5 (actual): EOL, licenciamiento y compatibilidad limitan evolución.

## 4) Arquitectura propuesta (8 blades)
- Cluster Proxmox VE: 8 nodos
- Red:
  - VLAN-10 Gestión (PVE, IPMI)
  - VLAN-20 Backup (PBS)
  - VLAN-30 Alumnos/Prácticas (por curso, sub-VLANs)
  - VLAN-40 Servicios comunes (repositorios, mirror apt, registro Docker)
  - VLAN-50 DMZ (accesos externos si aplica)
- Almacenamiento:
  - Opción A (simple y estable): ZFS por nodo + PBS externo (backups)
  - Opción B (distribuido): Ceph en 3-5 nodos con SSD/NVMe (si hay discos locales rápidos)
- Roles por nodo (sugerido):
  - Nodos 1-6: Compute (cursos, laboratorios)
  - Nodo 7: Servicios de plataforma (PBS, Registry, GitLab Runner, Mirror repos)
  - Nodo 8: Bastión/Firewall virtual (pfSense/OPNsense), monitoreo

## 5) Identidad, acceso y seguridad
- Autenticación: LDAP/AD institucional (si existe) o Keycloak (SSO).
- Autorización: Pools por curso en Proxmox y roles por perfil:
  - Admin-plataforma (TI)
  - Docente-curso (crea VMs desde plantillas de su pool)
  - Alumno (acceso a sus VMs; sin privilegios de crear)
- Segmentación:
  - VLAN por materia y por grupo si se requiere.
  - Bastión SSH y VPN docente, sin exposición directa de hipervisores.
- Mínimo privilegio:
  - Plantillas bloqueadas, recursos y cuotas por pool.
  - Acceso a consolas vía Proxmox Web UI con 2FA (opcional).

## 6) Catálogo de plantillas (cloud-init)
- Linux: Ubuntu Server LTS, Debian, Rocky Linux
- Windows Server (si hay licenciamiento académico)
- K3s/Kubernetes worker preconfigurado
- Base de datos (PostgreSQL/MySQL) pre-endurecido
- NGINX reverse proxy con TLS (Let’s Encrypt interno)

## 7) Automatización y CI/CD
- Terraform (provider Proxmox) para VMs por curso
- Ansible para configuración por rol (DB, web, DNS, etc.)
- GitHub Classroom + GitHub Actions/GitLab Runner para pipelines de prácticas
- Registro de contenedores local (Harbor/Registry) y mirror de repos (apt/npm/pypi) para reducir internet-dependencia

## 8) Backups, monitoreo y operación
- Backups: Proxmox Backup Server (incrementales, deduplicados). Política: diaria (7), semanal (4), mensual (3).
- Monitoreo: Prometheus + Grafana, alertas (hooks a Teams/Email).
- Logs: Loki/ELK opcional por curso.
- DR básico: Exportación periódica de VMs críticas y snapshots de infraestructura.

## 9) Política de uso y calendario
- Pools por curso (Unidad/Periodo). Cuotas por docente (vCPU/RAM/Disco).
- Ventana de mantenimiento: semanal (domingos 02:00-05:00).
- Solicitudes por issue en repositorio interno (plantilla de solicitud).
- Apagado automático de VMs inactivas (etiquetas y TTL).

---

# Escenarios y prácticas por materia

## A) Taller de Base de Datos y Administración de BD (distribuidas)
- Laboratorio 1: Replicación primaria-secundaria (PostgreSQL streaming / MySQL replica)
- Laboratorio 2: Alta disponibilidad (PostgreSQL Patroni o MySQL InnoDB Cluster)
- Laboratorio 3: Sharding/particiones y balanceo de lectura
- Laboratorio 4: Backups lógicos y físicos + recuperación puntual
- Laboratorio 5: Seguridad: roles, cifrado en tránsito, auditoría básica

Recursos:
- 3 VMs por equipo: db-primary, db-replica, client
- VLAN-BD y plantilla “db-secured”

## B) Taller de Sistemas Operativos (contenedores y Kubernetes)
- Laboratorio 1: Docker/Podman fundamentos + Compose
- Laboratorio 2: k3s (3 nodos), despliegue de microservicios, Ingress y TLS
- Laboratorio 3: Persistencia (NFS/Longhorn), ConfigMaps/Secrets
- Laboratorio 4: Observabilidad (Prometheus/Grafana/Loki)
- Laboratorio 5: Escalado/HPA y tolerancia a fallos

Recursos:
- 3 VMs por equipo (k3s-master, k3s-worker1, k3s-worker2)
- Registro local para imágenes (Harbor/Registry)

## C) Administración de Redes (HTTP, DNS, FTP, SSH)
- Laboratorio 1: DNS autoritativo y recursivo (Bind9) + zonas
- Laboratorio 2: NGINX reverse proxy, TLS, hardening
- Laboratorio 3: FTP seguro (vsftpd/SFTP), chroot y permisos
- Laboratorio 4: SSH endurecido, claves, fail2ban
- Laboratorio 5: Firewall y segmentación (pfSense), NAT, ACLs

Recursos:
- 2-3 VMs por equipo en VLAN-RED, pfSense compartido por curso

## D) Programación Web y Móvil
- Laboratorio 1: CI/CD (build, test, image, deploy a k3s dev)
- Laboratorio 2: API con DB y migraciones; secrets y variables
- Laboratorio 3: Observabilidad de app (logs, métricas, tracing básico)
- Laboratorio 4: Canary/Blue-Green en k3s
- Laboratorio 5: Pruebas E2E con Selenium/Cypress en pipeline

Recursos:
- Proyecto template + runner + namespace k3s por equipo

## E) Pruebas de Software
- Laboratorio 1: Integración de pruebas unitarias y cobertura en pipeline
- Laboratorio 2: Selenium Grid/E2E automatizadas
- Laboratorio 3: Carga con JMeter/k6
- Laboratorio 4: Análisis estático (SonarQube) y DAST (OWASP ZAP)
- Laboratorio 5: Reportes y Quality Gates

Recursos:
- VM de herramientas (SonarQube/ZAP/JMeter), runners

---

# Diseño de permisos y operación docente

## Pools y roles en Proxmox
- Pool “U3-TallerBD-2025A”: cuota 32 vCPU, 128 GB RAM, 2 TB
- Roles:
  - PVEAdmin (TI plataforma)
  - PVE-Docente (crear desde plantillas en su pool, iniciar/detener)
  - PVE-Alumno (consola VM propia, sin crear/borrar)

## Red por curso
- VLAN 131 (TallerBD), 132 (SO), 133 (Redes), 134 (WebMovil), 135 (Pruebas)
- Subnets RFC1918, DNS interno, salida NAT controlada
- Ingress a DMZ solo si lo aprueba TI (evaluaciones públicas)

## Plantillas base (cloud-init)
- “tpl-ubuntu-22LTS-ci”
- “tpl-debian-12-k3s”
- “tpl-rocky-9-web”
- “tpl-win-srv” (según licenciamiento)
- Endurecimiento: SSH sin password, usuario docente con sudo, agentes QEMU.

---

# Migración VMware 6.5 → Proxmox (plan resumido)

1) Compatibilidad y preparación  
- Verificar CPU (Intel VT-x/AMD-V), NICs y controladoras  
- Respaldar VMs en VMware (snapshots/exports)

2) Despliegue Proxmox cluster  
```bash
# Nodo 1
pvecm create campus-cluster
# Nodo 2..8
pvecm add <IP-nodo1>
```

3) Almacenamiento  
- ZFS por nodo (mirror si hay 2 SSD)  
- Proxmox Backup Server en nodo 7

4) Redes y VLANs  
- Trunk en switches físicos  
- Crear bridges vmbr0 (mgmt) y vmbrX por VLAN curso

5) Importación VMs  
```bash
# Exportar en VMware a OVA/OVF y luego:
qm create 200 --name vm-import --memory 4096 --cores 2 --net0 virtio,bridge=vmbr0
qm importovf 200 vmware-export.ovf local-lvm
qm set 200 --scsihw virtio-scsi-pci --virtio0 local-lvm:vm-200-disk-0
qm set 200 --boot order=virtio0
```

6) Validación y corte  
- Pruebas por curso en ventana de mantenimiento  
- Cambio de DNS y documentación de acceso

---

# Operación diaria y soporte

- Mesa de ayuda: issues por repositorio “Infra-Campus” (plantilla)
- Catálogo de servicios: lista de plantillas y redes disponibles
- Procedimientos: alta de curso, asignación de pool, caducidad de recursos
- Auditoría: revisión mensual de uso y costos energéticos

---

# Anexos

## A) Comandos útiles Proxmox
```bash
# Crear VM desde plantilla y cloud-init
qm clone 9000 1201 --name=u3-db-equipo01 --full true
qm set 1201 --ciuser alumno --cipassword '***' --ipconfig0 ip=dhcp
qm start 1201

# Backups (PBS)
proxmox-backup-client backup vm-1201.pxar:/etc/pve --repository pbs@pam@pbs:datastore
```

## B) Ejemplo Terraform (VM Ubuntu)
```hcl
provider "proxmox" {
  pm_api_url = "https://pve1:8006/api2/json"
  pm_user    = "terraform@pve"
  pm_password= var.pm_password
  pm_tls_insecure = true
}

resource "proxmox_vm_qemu" "u3_db_equipo01" {
  name        = "u3-db-equipo01"
  target_node = "pve1"
  clone       = "tpl-ubuntu-22LTS-ci"
  cores       = 2
  sockets     = 1
  memory      = 4096
  ipconfig0   = "ip=dhcp"
  ssh_user    = "alumno"
  ciuser      = "alumno"
}
```

## C) Ejemplo Ansible (rol DB)
```yaml
- hosts: db
  become: yes
  tasks:
    - name: Instalar PostgreSQL
      apt:
        name: postgresql
        state: present
        update_cache: yes
    - name: Ajustar pg_hba
      lineinfile:
        path: /etc/postgresql/14/main/pg_hba.conf
        regexp: '^host\s+all\s+all\s+10\.0\.0\.0/8\s+'
        line: 'host all all 10.0.0.0/8 md5'
      notify: restart pg
  handlers:
    - name: restart pg
      service:
        name: postgresql
        state: restarted
```

---

## Requerimientos pendientes
- Confirmar hardware de cada blade (CPU/RAM/NIC/Discos)
- Definir si habrá acceso externo público (DMZ)
- Licenciamiento Windows (si aplica)
- Integración con SSO institucional

## Riesgos y mitigación
- Carga excesiva en períodos pico → cuotas y escalado horizontal por pools
- Exposición de servicios → DMZ controlada, WAF/reverse proxy, VPN
- Fallos de disco → PBS + ZFS/Ceph con redundancia

Fin del documento.