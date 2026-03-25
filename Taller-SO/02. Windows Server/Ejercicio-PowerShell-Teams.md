# Ejercicio de PowerShell: Gestión de Microsoft Teams

**Taller de Sistemas Operativos - Windows Server**

---

## Objetivo

Crear un script de PowerShell que automatice la creación de un equipo de Microsoft Teams y la asignación de miembros utilizando parámetros.

---

## Escenario

Eres administrador de sistemas en una empresa y necesitas automatizar la creación de equipos de Microsoft Teams para diferentes departamentos. El script debe ser reutilizable y aceptar parámetros para personalizar el nombre del equipo y los miembros que se agregarán.

---

## Requisitos del Ejercicio

### Parte 1: Instalación del Módulo de Microsoft Teams

Antes de comenzar a trabajar con Teams desde PowerShell, necesitas instalar y configurar el módulo adecuado.

**Tareas:**

1. Instalar el módulo de Microsoft Teams desde la galería de PowerShell
2. Verificar que el módulo se instaló correctamente
3. Conectarse a Microsoft Teams con tus credenciales de administrador

**Pistas de comandos:**

```powershell
# Para instalar módulos desde la galería de PowerShell
Install-Module -Name ___________

# Para verificar módulos instalados
Get-Module -Name ___________ -ListAvailable

# Para importar un módulo
Import-Module ___________

# Para conectarse a Teams
Connect-___________
```

---

### Parte 2: Crear el Script con Parámetros

Desarrolla un script de PowerShell que acepte parámetros y realice las siguientes operaciones:

**Especificaciones del Script:**

- **Parámetro 1:** Nombre del equipo (obligatorio)
- **Parámetro 2:** Descripción del equipo (opcional)
- **Parámetro 3:** Lista de correos electrónicos de los miembros (obligatorio)

**Funcionalidad Requerida:**

1. Crear un nuevo equipo con el nombre y descripción proporcionados
2. Agregar los usuarios especificados como miembros del equipo
3. Mostrar mensajes informativos sobre el progreso
4. Manejar posibles errores (equipo ya existe, usuario no encontrado, etc.)

**Pistas de comandos:**

```powershell
# Para definir parámetros en un script
param(
    [Parameter(Mandatory=$___)]
    [string]$___________,
    
    [Parameter(Mandatory=$___)]
    [string[]]$___________
)

# Para crear un nuevo equipo
New-___________ -DisplayName "_______" -Description "______"

# Para agregar miembros a un equipo
Add-___________Member -GroupId _______ -User _______

# Para obtener el ID del grupo/equipo creado
Get-___________ -DisplayName "_______"

# Para recorrer una lista de elementos
foreach ($_______ in $_______) {
    # Código aquí
}
```

---

### Parte 3: Ejemplo de Uso

Tu script debe poder ejecutarse de la siguiente manera:

```powershell
.\Crear-EquipoTeams.ps1 -NombreEquipo "Desarrollo Web" `
                        -Descripcion "Equipo de desarrollo frontend y backend" `
                        -Miembros @("usuario1@empresa.com", "usuario2@empresa.com", "usuario3@empresa.com")
```

---

## Entregables

1. **Script PowerShell** (`Crear-EquipoTeams.ps1`) con:
   - Encabezado con información del script (autor, fecha, descripción)
   - Definición de parámetros
   - Validación de entrada
   - Lógica para crear equipo
   - Lógica para agregar miembros
   - Manejo de errores con `try-catch`
   - Mensajes informativos

2. **Documento de pruebas** que incluya:
   - Capturas de pantalla de la instalación del módulo
   - Ejecución exitosa del script
   - Verificación del equipo creado en Teams
   - Verificación de los miembros agregados
   - Prueba de manejo de errores (ej. usuario inexistente)

---

## Estructura Sugerida del Script

```powershell
<#
.SYNOPSIS
    Crea un equipo de Microsoft Teams y agrega miembros.

.DESCRIPTION
    Este script automatiza la creación de un equipo de Microsoft Teams
    y la asignación de miembros a partir de una lista de correos electrónicos.

.PARAMETER NombreEquipo
    Nombre del equipo a crear (obligatorio)

.PARAMETER Descripcion
    Descripción del equipo (opcional)

.PARAMETER Miembros
    Array de direcciones de correo de los usuarios a agregar (obligatorio)

.EXAMPLE
    .\Crear-EquipoTeams.ps1 -NombreEquipo "Marketing" -Miembros @("user1@empresa.com")

.NOTES
    Autor: [Tu nombre]
    Fecha: [Fecha]
    Versión: 1.0
#>

param(
    # Completa aquí la definición de parámetros
)

# Paso 1: Verificar conexión a Teams
Write-Host "Verificando conexión a Microsoft Teams..." -ForegroundColor Cyan

try {
    # Código para verificar conexión
}
catch {
    Write-Host "Error: No se pudo conectar a Teams. Ejecute Connect-MicrosoftTeams primero." -ForegroundColor Red
    exit
}

# Paso 2: Crear el equipo
Write-Host "Creando equipo: $NombreEquipo" -ForegroundColor Cyan

try {
    # Código para crear equipo
    Write-Host "✓ Equipo creado exitosamente" -ForegroundColor Green
}
catch {
    Write-Host "✗ Error al crear el equipo: $_" -ForegroundColor Red
    exit
}

# Paso 3: Obtener información del equipo creado
Write-Host "Obteniendo información del equipo..." -ForegroundColor Cyan

# Código aquí

# Paso 4: Agregar miembros
Write-Host "Agregando miembros al equipo..." -ForegroundColor Cyan

foreach ($_____ in $_____) {
    try {
        # Código para agregar cada miembro
        Write-Host "  ✓ Usuario agregado: $_____" -ForegroundColor Green
    }
    catch {
        Write-Host "  ✗ Error al agregar $_____: $_" -ForegroundColor Red
    }
}

# Paso 5: Mostrar resumen
Write-Host "`n=== RESUMEN ===" -ForegroundColor Yellow
Write-Host "Equipo: $NombreEquipo"
Write-Host "Miembros agregados: $($Miembros.Count)"
Write-Host "===============`n" -ForegroundColor Yellow
```

---

## Criterios de Evaluación

| Criterio | Puntos |
|----------|--------|
| Instalación correcta del módulo Teams | 10 |
| Definición correcta de parámetros (obligatorios/opcionales) | 15 |
| Creación exitosa del equipo | 20 |
| Adición correcta de miembros mediante bucle | 25 |
| Manejo de errores con try-catch | 15 |
| Mensajes informativos claros | 10 |
| Documentación del código (comentarios, help) | 5 |
| **TOTAL** | **100** |

---

## Comandos de Referencia (Cmdlets Clave)

**Módulo y Conexión:**
- `Install-Module`
- `Import-Module`
- `Connect-MicrosoftTeams`
- `Get-Module`

**Gestión de Equipos:**
- `New-Team`
- `Get-Team`
- `Remove-Team`

**Gestión de Miembros:**
- `Add-TeamUser`
- `Get-TeamUser`
- `Remove-TeamUser`

**Información Adicional:**
- `Get-Help <cmdlet> -Full`
- `Get-Help <cmdlet> -Examples`

---

## Retos Adicionales (Opcional)

Si completas el ejercicio básico, intenta implementar estas mejoras:

1. **Validación de formato de email:** Verifica que los correos tengan formato válido antes de procesarlos

2. **Roles diferenciados:** Permite especificar qué usuarios serán owners y cuáles members

3. **Archivo de configuración:** Lee los miembros desde un archivo CSV en lugar de pasarlos como parámetro

4. **Configuración avanzada:** Permite especificar el tipo de equipo (Private/Public) y configuraciones adicionales

5. **Reporte en archivo:** Genera un archivo de log con el resultado de cada operación

---

## Recursos Adicionales

- [Documentación oficial de Microsoft Teams PowerShell](https://learn.microsoft.com/en-us/microsoftteams/teams-powershell-overview)
- [New-Team Cmdlet Reference](https://learn.microsoft.com/en-us/powershell/module/teams/new-team)
- [Add-TeamUser Cmdlet Reference](https://learn.microsoft.com/en-us/powershell/module/teams/add-teamuser)

---

## Solución de Problemas Comunes

### Error: "Module not found"
- Verifica que PowerShell se ejecute como administrador
- Usa `Set-ExecutionPolicy RemoteSigned` si es necesario

### Error: "Authentication failed"
- Asegúrate de tener cuenta de Microsoft 365 con permisos de administrador
- Verifica que el MFA (autenticación multifactor) esté configurado correctamente

### Error: "User not found"
- Verifica que el correo electrónico sea correcto
- Asegúrate de que el usuario existe en Azure AD / Microsoft 365

---

**Fecha límite de entrega:** [Especificar]  
**Modalidad:** Individual  
**Plataforma de entrega:** [Especificar]

---

**Última actualización:** Noviembre 2025  
**Materia:** Taller de Sistemas Operativos  
**Tema:** Windows Server - PowerShell y Microsoft Teams
