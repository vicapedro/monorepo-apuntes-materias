# Ejercicios — Direccionamiento IP (VLSM) y Sumarización de rutas

Este archivo contiene ejercicios con soluciones (VLSM y sumarización de rutas) para práctica y autoevaluación.

## Ejercicios VLSM (5)

### VLSM 1 — Asignación básica
- Enunciado: dispone de la red 192.168.10.0/24. Se necesitan subredes para:
	- A: 60 hosts
	- B: 30 hosts
	- C: 12 hosts
	- D: 6 hosts

	Asigna subredes usando VLSM (primero la mayor). Indica para cada subred: red, máscara, rango de hosts y broadcast.

- Solución (asignación ordenada por tamaño):
	- A (>=60): /26 → 64 hosts
		- Red: 192.168.10.0/26
		- Hosts: 192.168.10.1 — 192.168.10.62
		- Broadcast: 192.168.10.63
	- B (>=30): /27 → 32 hosts
		- Red: 192.168.10.64/27
		- Hosts: 192.168.10.65 — 192.168.10.94
		- Broadcast: 192.168.10.95
	- C (>=12): /28 → 16 hosts
		- Red: 192.168.10.96/28
		- Hosts: 192.168.10.97 — 192.168.10.110
		- Broadcast: 192.168.10.111
	- D (>=6): /29 → 8 hosts
		- Red: 192.168.10.112/29
		- Hosts: 192.168.10.113 — 192.168.10.118
		- Broadcast: 192.168.10.119

	(Espacio libre restante desde 192.168.10.120/29 en adelante).

### VLSM 2 — Red grande con varios tamaños
- Enunciado: dispone de 10.10.0.0/16. Necesita subredes para:
	- A: 2000 hosts
	- B: 500 hosts
	- C: 200 hosts
	- D: 50 hosts
	- E: 10 hosts

- Solución (orden descendente):
	- A (>=2000): /21 → 2046 hosts → 10.10.0.0/21  (10.10.0.0 — 10.10.7.255)
	- B (>=500): /23 → 510 hosts  → 10.10.8.0/23  (10.10.8.0 — 10.10.9.255)
	- C (>=200): /24 → 254 hosts  → 10.10.10.0/24
	- D (>=50): /26 → 62 hosts   → 10.10.11.0/26
	- E (>=10): /28 → 14 hosts   → 10.10.11.64/28

	(Verificar alineación y evitar solapamientos en la asignación en cadena).

### VLSM 3 — LANs y enlaces punto a punto
- Enunciado: dispone de 172.16.100.0/24. Debe diseñar 4 LANs con 30 hosts cada una y 6 enlaces punto a punto (2 hosts cada uno). Asigna subredes.

- Solución:
	- LANs (30 hosts → /27):
		- LAN1: 172.16.100.0/27 (hosts .1 — .30, bcast .31)
		- LAN2: 172.16.100.32/27
		- LAN3: 172.16.100.64/27
		- LAN4: 172.16.100.96/27
	- Enlaces P2P (/30 cada uno, 4 direcciones, 2 hosts):
		- P2P1: 172.16.100.128/30
		- P2P2: 172.16.100.132/30
		- P2P3: 172.16.100.136/30
		- P2P4: 172.16.100.140/30
		- P2P5: 172.16.100.144/30
		- P2P6: 172.16.100.148/30

	(Resto libre a partir de 172.16.100.152).

### VLSM 4 — DMZ, administración y enlaces
- Enunciado: dispone de 203.0.113.0/24. Necesita:
	- DMZ: 120 hosts
	- 3 subredes administrativas: 25 hosts cada una
	- 10 enlaces p2p

- Solución sugerida y observaciones:
	- DMZ 120 → /25 (126 hosts) → 203.0.113.0/25 (.0—.127)
	- Admin (25 cada una) → /27 (32 hosts):
		- Admin1: 203.0.113.128/27
		- Admin2: 203.0.113.160/27
		- Admin3: 203.0.113.192/27
	- Enlaces /30 desde 203.0.113.224/30 en adelante. Nota: en un /24 hay espacio para 8 /30 (32 direcciones) entre .224–.255 → solo 8 enlaces. Si se requieren 10, hay que reorganizar (p.ej. reducir DMZ o conseguir un bloque mayor).

	(Este ejercicio enfatiza verificar disponibilidad total antes de fijar requisitos).

### VLSM 5 — Reto práctico
- Enunciado: dispone de 192.0.2.0/24. Necesita:
	- A: 120 hosts
	- B: 60 hosts
	- C: 20 hosts
	- D: 5 hosts
	- E: espacio para administración

- Solución eficiente:
	- A: /25 → 192.0.2.0/25 (.0—.127)
	- B: /26 → 192.0.2.128/26 (.128—.191)
	- C: /27 → 192.0.2.192/27 (.192—.223)
	- D: /29 → 192.0.2.224/29 (.224—.231)
	- E: reservar /28 o /29 según necesidad — p.ej. 192.0.2.240/28 (.240—.255)

	(Ejercicio: pedir a los alumnos calcular hosts utilizables por subred y espacio restante).

## Ejercicios de Sumarización de rutas (3)

### Sumarización 1 (fácil)
- Enunciado: agrega las rutas:
	- 192.168.0.0/24
	- 192.168.1.0/24
	- 192.168.2.0/24
	- 192.168.3.0/24

- Solución:
	- Rutas contiguas → resumen: 192.168.0.0/22 (cubre 0.0—3.255). Justificación: /22 agrupa 4 /24 contiguos.

### Sumarización 2 (intermedio)
- Enunciado: evalúa la mejor agregación para:
	- 10.0.4.0/24
	- 10.0.5.0/24
	- 10.0.6.0/24

- Solución y decisión:
	- No es posible resumir los tres en un /22 sin incluir 10.0.7.0/24. Opciones:
		- Agregar 10.0.4.0/23 (cubre .4—.5) y conservar 10.0.6.0/24 → 2 rutas.
		- Si la política lo permite y 10.0.7.0 no existe/está controlada, se puede anunciar 10.0.4.0/22 (incluye .7).

	- Explica trade‑offs: minimizar rutas vs. evitar anunciar redes no existentes.

### Sumarización 3 (avanzado)
- Enunciado: resume estas redes:
	- 172.16.10.0/24
	- 172.16.11.0/24
	- 172.16.12.0/24
	- 172.16.13.0/24
	- 172.16.14.0/24

- Solución:
	- Las redes .10—.13 forman 172.16.10.0/22. La red .14 queda fuera.
	- Posibles agregaciones:
		- 172.16.10.0/22 + 172.16.14.0/24 (mínimo cambio)
		- Si se acepta incluir .8—.15, usar 172.16.8.0/21 (reduce a 1 ruta, pero anuncia redes adicionales).

	- Justificación: elegir la agregación mínima que no incluya redes no deseadas salvo política institucional.

---

## Notas pedagógicas
- Para VLSM: ordenar subredes por tamaño descendente antes de asignar, comprobar alineación de bloques y evitar solapamientos.
- Para sumarización: identificar bits de prefijo comunes; ser cauteloso al incluir redes inexistentes en una agregación.
- Ejercicio adicional para alumnos: generar tabla con columnas (Subred, Máscara, Hosts disponibles, Primer host, Último host, Broadcast) y calcular espacio libre.

---

Si quieres, genero una versión del archivo con solo enunciados (sin soluciones) para entregar a los alumnos, o un documento PDF listo para imprimir. ¿Cuál prefieres?

