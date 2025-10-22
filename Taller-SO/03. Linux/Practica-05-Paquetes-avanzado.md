# Práctica 05: Paquetes avanzados — Instalación de PHP más reciente en Debian 12

## Objetivo
**Duración estimada:** 1.5 horas

Instalar la última versión de PHP en Debian 12 agregando repositorios externos y su firma, instalar Apache, y verificar la integración mediante un script phpinfo.php.

## Competencias a desarrollar
- Instala y configura repositorios externos en Linux
- Instala y verifica paquetes avanzados (PHP, Apache)
- Comprende la integración de PHP con Apache
- Realiza pruebas básicas de funcionamiento de servicios web

## Introducción

En Debian 12, los repositorios oficiales no siempre incluyen la versión más reciente de PHP. Para instalar la última versión, es necesario agregar el repositorio oficial de PHP, importar su firma GPG y luego instalar el paquete. Esta práctica te guiará en el proceso completo, incluyendo la verificación de la integración con Apache mediante un script de prueba.

## Equipo de protección e higiene
- Mantener el área de trabajo limpia y ordenada
- No consumir alimentos cerca del equipo
- Verificar que los cables y conexiones estén en buen estado

## Material y equipo necesario
### Materiales e insumos
- Manual de referencia de PHP y Apache
- Libreta para anotaciones
### Equipo de laboratorio
- Computadora con Debian 12
- Acceso a internet
- Privilegios de superusuario (sudo)
### Herramientas
- Terminal Bash
- Navegador web para pruebas locales

## Instrucciones

### 1. Preparación del sistema

1. **Actualizar el sistema**
   ```bash
   sudo apt update && sudo apt upgrade -y
   ```

2. **Instalar dependencias necesarias**
   ```bash
   sudo apt install -y lsb-release ca-certificates apt-transport-https software-properties-common gnupg2 curl
   ```

### 2. Agregar el repositorio oficial de PHP

1. **Importar la firma GPG del repositorio**
   ```bash
   curl -fsSL https://packages.sury.org/php/apt.gpg | sudo gpg --dearmor -o /usr/share/keyrings/php.gpg
   ```

2. **Agregar el repositorio a sources.list.d**
   ```bash
   echo "deb [signed-by=/usr/share/keyrings/php.gpg] https://packages.sury.org/php/ $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/php.list
   ```

3. **Actualizar la lista de paquetes**
   ```bash
   sudo apt update
   ```

### 3. Instalar la última versión de PHP y Apache

1. **Instalar Apache**
   ```bash
   sudo apt install -y apache2
   ```

2. **Instalar la última versión de PHP (ejemplo: php8.3)**
   ```bash
   sudo apt install -y php8.3 libapache2-mod-php8.3
   ```
   > Si la versión cambia, verifica con `apt search php` cuál es la más reciente disponible.

3. **Verificar instalación**
   ```bash
   php -v
   apache2 -v
   ```

### 4. Configurar y probar PHP con Apache

1. **Crear el archivo de prueba phpinfo.php**
   ```bash
   echo "<?php phpinfo(); ?>" | sudo tee /var/www/html/phpinfo.php
   ```

2. **Reiniciar Apache para aplicar cambios**
   ```bash
   sudo systemctl restart apache2
   ```

3. **Probar en el navegador**
   - Abre: `http://localhost/phpinfo.php`
   - Deberías ver la página de información de PHP
   - Verifica la versión instalada y los módulos cargados

### 5. Limpieza y seguridad

1. **Eliminar el archivo de prueba (opcional)**
   ```bash
   sudo rm /var/www/html/phpinfo.php
   ```
   > Por seguridad, elimina phpinfo.php después de verificar.

## Notas
- Si tienes problemas con la firma, revisa que el archivo `/usr/share/keyrings/php.gpg` exista y esté correctamente importado.
- Puedes instalar extensiones adicionales de PHP con `sudo apt install php8.3-mysql php8.3-xml` según tus necesidades.
- Para cambiar la versión activa de PHP, usa `sudo update-alternatives --config php` si tienes varias instaladas.

## Entregables
- Captura de pantalla de la página phpinfo en el navegador
- Comandos ejecutados y salida de `php -v` y `apache2 -v`
- Breve explicación de los pasos realizados y problemas encontrados (si los hubo)

## Criterios de evaluación
| **Criterio** | **Excelente (3)** | **Bueno (2)** | **Aceptable (1)** | **Insuficiente (0)** |
|--------------|-------------------|----------------|-------------------|----------------------|
| Instalación de repositorio y firma | Sin errores, documenta cada paso | Instala correctamente, pocos errores | Instala con ayuda | No logra instalar |
| Instalación de PHP y Apache | Funciona y se verifica con phpinfo | Funciona pero sin verificación | Instalación parcial | No instala |
| Prueba y evidencia | Captura clara y explicación completa | Captura y explicación básica | Solo captura | Sin evidencia |
| Documentación de problemas | Explica y resuelve problemas | Explica pero no resuelve | Menciona problemas | No documenta |

## Extensiones opcionales
- Instalar y probar módulos adicionales de PHP
- Configurar virtual hosts en Apache
- Probar integración con bases de datos (MySQL, PostgreSQL)
- Investigar diferencias entre versiones de PHP

---

**¿Dudas o problemas? Consulta la documentación oficial de PHP y Apache, o pregunta al instructor.**
