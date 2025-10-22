# Plantilla: Supuestos y Ambigüedades

Este documento sirve como plantilla estándar para registrar, clasificar y gestionar supuestos y ambigüedades en cualquier proyecto (no limitado a Zaboo Mazoo). Copia esta plantilla dentro de la carpeta de la práctica y rellena los ítems detectados.

## Cómo usarla (proceso rápido)
1. Cada vez que detectes un supuesto o ambigüedad, crea una entrada nueva con ID (p. ej. S01, S02...).
2. Clasifica su impacto (Alto/Medio/Bajo) y su tipo.
3. Propón una mitigación concreta y marca el estado (Propuesto / Confirmado / Rechazado / Pendiente Instructor).
4. Para supuestos de impacto ALTO: solicita sign‑off del instructor antes de avanzar con cambios dependientes.
5. Mantén el `changelog` al final del documento con cualquier decisión o cambio.

---

## Plantilla de entrada (copiar y completar por supuesto)

- ID: SXX
- Título corto: (p. ej. "Máximo de hábitats")
- Supuesto / Ambigüedad (frase clara):
- Tipo: Dominio / Datos / Diseño / Rendimiento / Seguridad / Legal / Otro
- Ámbito (qué partes del sistema afecta):
- Justificación / Por qué se asume esto:
- Impacto si es falso: Alto / Medio / Bajo (describir consecuencias):
- Mitigación propuesta (acciones concretas):
- Acción requerida (Preguntar al Instructor / Diseñar fallback / Implementar validación / Otro):
- Estado: Propuesto / Pendiente Instructor / Confirmado / Rechazado
- Autor (equipo/usuario) y fecha:
- Evidencia / enlace a discusión (issues, PRs, correos):
- Notas adicionales:

---

## Ejemplo

- ID: S01
- Título corto: Límite de hábitats
- Supuesto / Ambigüedad: El enunciado indica 5 zonas principales; se asume que no habrá más hábitats durante el semestre.
- Tipo: Dominio
- Ámbito: Asignación de `animal.habitat_id`, diseño de catálogo `habitat`.
- Justificación: Documento de requisitos menciona "5 zonas" y no especifica expansión.
- Impacto si es falso: Medio — cambia cardinalidad y capacidad, afecta integridad y UI.
- Mitigación propuesta: Diseñar `habitat` como tabla dinámica (FK nullable) y permitir alta posterior; documentar en `notes.md`.
- Acción requerida: Confirmar con instructor o aceptar mitigación.
- Estado: Propuesto
- Autor: Equipo A — 2025-08-26
- Evidencia: enlace a `discusiones/issue-12`
- Notas adicionales: Añadir test de carga que simule +10 hábitats.

---

## Checklist rápido para el docente / revisor
- [ ] ¿Todos los supuestos tienen ID y estado?
- [ ] ¿Los supuestos de impacto Alto tienen mitigación y sign‑off (o solicitud de sign‑off)?
- [ ] ¿Se registró la evidencia/discusión asociada? (issue/PR/email)
- [ ] ¿Se actualizó el `changelog` con decisiones que afecten el diseño?

---

## Changelog (registro de decisiones)
- S01 — 2025-08-28 — Estado: Confirmado — Instructor (Dr. X). Mitigación aceptada: tabla `habitat` dinámica.


---

Notas finales
- Recomiendo usar issues en Git para supuestos críticos y enlazarlos aquí.
- Solicita a los alumnos que incluyan `supuestos.md` en la carpeta raíz de su práctica antes de la entrega final.
- Puedo generar un script simple que valide el formato (ID, Estado, Impacto) si quieres automatizar la revisión.
