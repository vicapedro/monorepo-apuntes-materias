# Práctica 1: Instalación y configuración del entorno Python

## Objetivo
Configurar un entorno de desarrollo Python completo con Anaconda y Jupyter Notebooks para el análisis de datos, estableciendo las bases tecnológicas necesarias para el curso.

## Competencias
- Instalar y configurar Anaconda Distribution en el sistema operativo
- Crear y gestionar entornos virtuales para proyectos de ciencia de datos
- Utilizar Jupyter Notebooks como herramienta principal de desarrollo
- Verificar la instalación correcta de las bibliotecas fundamentales (NumPy, Pandas, Matplotlib)
- Configurar un espacio de trabajo organizado para proyectos de analítica

## Introducción
El entorno de desarrollo es fundamental para el éxito en cualquier proyecto de ciencia de datos. Anaconda Distribution es la plataforma más utilizada en la industria, ya que incluye Python, Jupyter Notebooks y más de 250 paquetes científicos preinstalados. Esta práctica establece las bases tecnológicas que utilizaremos durante todo el curso.

Un entorno bien configurado no solo facilita el desarrollo, sino que también asegura la reproducibilidad de nuestros análisis y la colaboración efectiva en equipos de trabajo. La gestión adecuada de entornos virtuales es una práctica profesional esencial que evita conflictos entre versiones de bibliotecas.

## Instrucciones

### Parte 1: Instalación de Anaconda
1. **Descargar Anaconda**:
   - Visitar https://www.anaconda.com/products/distribution
   - Descargar la versión correspondiente a tu sistema operativo
   - Seleccionar Python 3.9 o superior

2. **Instalar Anaconda**:
   - Ejecutar el instalador descargado
   - **Windows**: Marcar "Add Anaconda to PATH" durante la instalación
   - **macOS/Linux**: Permitir que el instalador modifique el archivo .bashrc/.zshrc
   - Verificar que se instale en la ruta predeterminada

3. **Verificar la instalación**:
   ```bash
   # Abrir terminal/command prompt
   conda --version
   python --version
   jupyter --version
   ```

### Parte 2: Configuración del entorno de trabajo
1. **Crear entorno virtual**:
   ```bash
   conda create -n analitica-datos python=3.9
   conda activate analitica-datos
   ```

2. **Instalar paquetes adicionales**:
   ```bash
   conda install numpy pandas matplotlib seaborn scikit-learn jupyter
   pip install plotly
   ```

3. **Verificar instalación de paquetes**:
   ```python
   import numpy as np
   import pandas as pd
   import matplotlib.pyplot as plt
   print("¡Todas las bibliotecas instaladas correctamente!")
   ```

### Parte 3: Configuración de Jupyter Notebooks
1. **Iniciar Jupyter**:
   ```bash
   jupyter notebook
   ```

2. **Crear estructura de carpetas**:
   - Crear carpeta `Analitica-CdeD`
   - Subcarpetas: `Unidad1`, `Unidad2`, `Unidad3`, `Unidad4`
   - Subcarpeta `Datasets` para almacenar datos

3. **Crear notebook de prueba**:
   - Nuevo notebook: `Prueba-Instalacion.ipynb`
   - Ejecutar código de verificación en celdas separadas

## Ejercicio

### Ejercicio 1: Verificación del entorno
Crear un notebook llamado `Verificacion-Entorno.ipynb` que contenga:

```python
# Celda 1: Información del sistema
import sys
import platform
print(f"Python version: {sys.version}")
print(f"Platform: {platform.platform()}")

# Celda 2: Verificación de bibliotecas
libraries = ['numpy', 'pandas', 'matplotlib', 'seaborn', 'sklearn']
for lib in libraries:
    try:
        __import__(lib)
        print(f"✓ {lib} - Instalado correctamente")
    except ImportError:
        print(f"✗ {lib} - ERROR: No instalado")

# Celda 3: Prueba básica de funcionalidad
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

# Crear datos de prueba
datos = np.random.randn(100)
df = pd.DataFrame({'valores': datos})

# Crear gráfico simple
plt.figure(figsize=(8, 4))
plt.hist(datos, bins=20, alpha=0.7)
plt.title('Gráfico de prueba - Instalación exitosa')
plt.show()

print("¡Entorno configurado correctamente!")
```

### Ejercicio 2: Exploración de Jupyter
1. Crear un notebook `Exploracion-Jupyter.ipynb`
2. Practicar con diferentes tipos de celdas:
   - Celda de código con operaciones matemáticas básicas
   - Celda Markdown con texto formateado
   - Celda con gráfico simple usando matplotlib

### Ejercicio 3: Gestión de entornos
```bash
# Crear un segundo entorno para experimentar
conda create -n test-env python=3.8
conda activate test-env
conda list  # Observar diferencias con el entorno principal
conda deactivate
```

## Notas

### Comandos esenciales de Conda:
- `conda list`: Ver paquetes instalados
- `conda info --envs`: Listar entornos disponibles
- `conda activate nombre_entorno`: Activar entorno
- `conda deactivate`: Desactivar entorno actual
- `conda install paquete`: Instalar paquete
- `conda update conda`: Actualizar Conda

### Atajos útiles de Jupyter:
- `Shift + Enter`: Ejecutar celda y moverse a la siguiente
- `Ctrl + Enter`: Ejecutar celda sin moverse
- `A`: Insertar celda arriba
- `B`: Insertar celda abajo
- `M`: Cambiar a celda Markdown
- `Y`: Cambiar a celda de código

### Solución de problemas comunes:
1. **Error PATH en Windows**: Reiniciar Command Prompt o agregar manualmente Anaconda al PATH
2. **Jupyter no inicia**: Verificar que el puerto 8888 esté libre
3. **Permisos en macOS/Linux**: Usar `sudo` solo si es necesario, preferir instalación en directorio de usuario

### Recursos adicionales:
- Documentación oficial de Anaconda: https://docs.anaconda.com/
- Guía de Jupyter Notebooks: https://jupyter-notebook.readthedocs.io/
- Conda Cheat Sheet: https://conda.io/projects/conda/en/latest/user-guide/cheatsheet.html

### Criterios de evaluación:
- [ ] Anaconda instalado correctamente
- [ ] Entorno virtual creado y configurado
- [ ] Jupyter Notebooks funcional
- [ ] Todas las bibliotecas verificadas
- [ ] Estructura de carpetas organizada
- [ ] Ejercicios completados con evidencias (capturas de pantalla)
