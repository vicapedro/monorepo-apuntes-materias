# Evidencia de Producto: Sistema de Análisis de Ventas con Python

## Datos Generales
- **Asignatura**: Analítica y Ciencia de Datos
- **Unidad**: 1. Fundamentos de Programación
- **Competencia Específica**: Conocer los fundamentos de la programación para el diseño de herramientas de analítica y ciencia de datos
- **Tipo de Evidencia**: Producto
- **Modalidad**: Individual
- **Duración**: 3 semanas
- **Valor**: 35% de la calificación de la Unidad 1

---

## Descripción de la Evidencia

### Contexto del Problema
La empresa "DataMart Solutions" es una cadena de supermercados que opera en 5 ciudades diferentes y maneja un volumen considerable de transacciones diarias. La gerencia necesita implementar un sistema de análisis de ventas que les permita:

- **Monitorear el rendimiento** de productos y sucursales
- **Identificar patrones de venta** por temporadas y ubicaciones  
- **Optimizar el inventario** basado en demanda histórica
- **Generar reportes automatizados** para la toma de decisiones
- **Visualizar tendencias** de manera clara y comprensible

### Escenario Empresarial
DataMart Solutions tiene las siguientes características operacionales:

| Aspecto | Detalles |
|---------|----------|
| **Sucursales** | 5 tiendas en diferentes ciudades |
| **Productos** | 50+ productos en 8 categorías |
| **Transacciones** | 200-500 transacciones diarias por sucursal |
| **Periodo de análisis** | Datos de 6 meses (Enero-Junio 2025) |
| **Formato de datos** | Archivos CSV con transacciones diarias |
| **Usuarios finales** | Gerentes de sucursal y dirección general |

### Objetivos de la Evidencia
1. **Configurar** un entorno Python completo con las herramientas necesarias
2. **Desarrollar** un sistema de análisis de ventas usando NumPy, Pandas y Matplotlib
3. **Implementar** funciones para carga, limpieza y procesamiento de datos
4. **Crear** visualizaciones informativas para diferentes audiencias
5. **Generar** reportes automatizados con insights empresariales
6. **Documentar** el código y proceso de manera profesional

---

## Entregables Requeridos

### 1. Jupyter Notebook Principal (Archivo .ipynb)
**Estructura mínima requerida:**
```markdown
# Sistema de Análisis de Ventas - DataMart Solutions

## 1. Configuración del Entorno
- Importación de bibliotecas
- Configuración de parámetros globales
- Verificación de instalaciones

## 2. Carga y Exploración de Datos
- Función para carga de archivos CSV
- Exploración inicial del dataset
- Identificación de problemas en los datos

## 3. Limpieza y Preprocesamiento
- Manejo de valores faltantes
- Corrección de tipos de datos
- Creación de variables derivadas

## 4. Análisis Descriptivo
- Estadísticas por sucursal y producto
- Análisis de tendencias temporales
- Identificación de patrones de venta

## 5. Visualizaciones
- Gráficos de ventas por sucursal
- Análisis temporal de productos
- Distribución de categorías

## 6. Reportes Automatizados
- Función para generar reportes
- Métricas clave de desempeño
- Recomendaciones basadas en datos

## 7. Conclusiones y Recomendaciones
```

### 2. Dataset de Ventas (Archivo CSV)
**Estructura de datos requerida:**
```csv
fecha,sucursal,ciudad,producto,categoria,cantidad,precio_unitario,total_venta,vendedor
2025-01-15,SUC001,Mexico,Laptop Dell,Tecnologia,1,15000.00,15000.00,Juan Perez
2025-01-15,SUC001,Mexico,Mouse Wireless,Tecnologia,2,350.00,700.00,Ana Garcia
...
```

### 3. Archivo de Configuración (config.py)
```python
# Configuraciones del sistema
SUCURSALES = ['SUC001', 'SUC002', 'SUC003', 'SUC004', 'SUC005']
CIUDADES = ['Mexico', 'Guadalajara', 'Monterrey', 'Puebla', 'Tijuana']
CATEGORIAS = ['Tecnologia', 'Hogar', 'Deportes', 'Ropa', 'Alimentacion', 'Salud', 'Libros', 'Juguetes']
```

### 4. Documento de Reflexión (PDF)
**Contenido requerido:**
- Proceso de aprendizaje personal
- Desafíos encontrados y cómo los resolvió
- Aplicaciones potenciales en otros contextos
- Áreas de mejora identificadas (500-750 palabras)

---

## Especificaciones Técnicas

### Requisitos Técnicos Mínimos

#### Entorno de Desarrollo
- **Python**: Versión 3.8 o superior
- **Anaconda**: Distribución completa instalada
- **Jupyter Notebook**: Interfaz principal de desarrollo
- **Git**: Control de versiones (opcional)

#### Bibliotecas Obligatorias
```python
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns (opcional)
from datetime import datetime
import warnings
```

#### Funcionalidades Requeridas

##### 1. Función de Carga de Datos
```python
def cargar_datos_ventas(archivo_csv):
    """
    Carga y valida datos de ventas desde archivo CSV
    
    Parameters:
    archivo_csv (str): Ruta al archivo CSV
    
    Returns:
    pd.DataFrame: DataFrame con los datos validados
    """
    # Implementación requerida
```

##### 2. Función de Limpieza
```python
def limpiar_datos(df):
    """
    Limpia y preprocesa los datos de ventas
    
    Parameters:
    df (pd.DataFrame): DataFrame con datos crudos
    
    Returns:
    pd.DataFrame: DataFrame limpio y procesado
    """
    # Implementación requerida
```

##### 3. Función de Análisis por Sucursal
```python
def analizar_por_sucursal(df):
    """
    Genera análisis descriptivo por sucursal
    
    Parameters:
    df (pd.DataFrame): DataFrame con datos limpios
    
    Returns:
    pd.DataFrame: Resumen estadístico por sucursal
    """
    # Implementación requerida
```

##### 4. Función de Visualización
```python
def crear_dashboard_ventas(df):
    """
    Crea dashboard con visualizaciones principales
    
    Parameters:
    df (pd.DataFrame): DataFrame con datos procesados
    
    Returns:
    None (muestra gráficos)
    """
    # Implementación requerida
```

### Criterios de Funcionalidad
- **Código ejecutable**: Sin errores de sintaxis o runtime
- **Datos procesados**: Manejo correcto de tipos de datos y valores faltantes
- **Visualizaciones**: Gráficos claros con títulos, etiquetas y leyendas apropiadas
- **Funciones modulares**: Código bien estructurado y reutilizable
- **Documentación**: Comentarios claros y docstrings en funciones

---

## Solución Paso a Paso

### Fase 1: Configuración del Entorno (Semana 1, Días 1-2)

#### Paso 1: Instalación y Verificación
```python
# Verificar instalación de bibliotecas
import sys
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

print(f"Python version: {sys.version}")
print(f"Pandas version: {pd.__version__}")
print(f"NumPy version: {np.__version__}")
print(f"Matplotlib version: {plt.matplotlib.__version__}")

# Configuración de visualización
plt.style.use('seaborn-v0_8')
plt.rcParams['figure.figsize'] = (12, 8)
plt.rcParams['font.size'] = 12
```

#### Paso 2: Estructura del Proyecto
```
proyecto_ventas/
├── datos/
│   └── ventas_datamart.csv
├── notebooks/
│   └── analisis_ventas.ipynb
├── src/
│   └── config.py
└── reportes/
    └── reflexion.pdf
```

#### Paso 3: Generación del Dataset de Prueba
```python
import pandas as pd
import numpy as np
from datetime import datetime, timedelta
import random

# Configuración de datos
np.random.seed(42)
random.seed(42)

# Parámetros del negocio
sucursales = ['SUC001', 'SUC002', 'SUC003', 'SUC004', 'SUC005']
ciudades = ['Mexico', 'Guadalajara', 'Monterrey', 'Puebla', 'Tijuana']
productos = [
    'Laptop Dell', 'Mouse Wireless', 'Teclado Mecánico', 'Monitor 24"', 'Impresora HP',
    'Refrigerador LG', 'Microondas Samsung', 'Licuadora Oster', 'Televisor Sony', 'Aspiradora Electrolux',
    'Balón Futbol', 'Raqueta Tennis', 'Bicicleta MTB', 'Pesas 10kg', 'Caminadora',
    'Camisa Polo', 'Jeans Levis', 'Zapatos Nike', 'Chaqueta North Face', 'Vestido Zara',
    'Arroz 5kg', 'Aceite Vegetal', 'Pasta Barilla', 'Cereal Kellogs', 'Leche Lala',
    'Vitaminas C', 'Paracetamol', 'Crema Hidratante', 'Shampoo Pantene', 'Pasta Dental',
    'Libro Python', 'Novela Bestseller', 'Enciclopedia', 'Comic Marvel', 'Revista Tech',
    'Lego Classic', 'Muñeca Barbie', 'Carro Control Remoto', 'Rompecabezas 1000', 'Pelota Basketball'
]

categorias = {
    'Laptop Dell': 'Tecnologia', 'Mouse Wireless': 'Tecnologia', 'Teclado Mecánico': 'Tecnologia',
    'Monitor 24"': 'Tecnologia', 'Impresora HP': 'Tecnologia',
    'Refrigerador LG': 'Hogar', 'Microondas Samsung': 'Hogar', 'Licuadora Oster': 'Hogar',
    'Televisor Sony': 'Hogar', 'Aspiradora Electrolux': 'Hogar',
    'Balón Futbol': 'Deportes', 'Raqueta Tennis': 'Deportes', 'Bicicleta MTB': 'Deportes',
    'Pesas 10kg': 'Deportes', 'Caminadora': 'Deportes',
    'Camisa Polo': 'Ropa', 'Jeans Levis': 'Ropa', 'Zapatos Nike': 'Ropa',
    'Chaqueta North Face': 'Ropa', 'Vestido Zara': 'Ropa',
    'Arroz 5kg': 'Alimentacion', 'Aceite Vegetal': 'Alimentacion', 'Pasta Barilla': 'Alimentacion',
    'Cereal Kellogs': 'Alimentacion', 'Leche Lala': 'Alimentacion',
    'Vitaminas C': 'Salud', 'Paracetamol': 'Salud', 'Crema Hidratante': 'Salud',
    'Shampoo Pantene': 'Salud', 'Pasta Dental': 'Salud',
    'Libro Python': 'Libros', 'Novela Bestseller': 'Libros', 'Enciclopedia': 'Libros',
    'Comic Marvel': 'Libros', 'Revista Tech': 'Libros',
    'Lego Classic': 'Juguetes', 'Muñeca Barbie': 'Juguetes', 'Carro Control Remoto': 'Juguetes',
    'Rompecabezas 1000': 'Juguetes', 'Pelota Basketball': 'Juguetes'
}

precios = {
    'Laptop Dell': 15000, 'Mouse Wireless': 350, 'Teclado Mecánico': 1200, 'Monitor 24"': 4500, 'Impresora HP': 2800,
    'Refrigerador LG': 12000, 'Microondas Samsung': 3500, 'Licuadora Oster': 800, 'Televisor Sony': 8500, 'Aspiradora Electrolux': 1500,
    'Balón Futbol': 450, 'Raqueta Tennis': 1200, 'Bicicleta MTB': 8500, 'Pesas 10kg': 600, 'Caminadora': 15000,
    'Camisa Polo': 580, 'Jeans Levis': 1200, 'Zapatos Nike': 2200, 'Chaqueta North Face': 3200, 'Vestido Zara': 890,
    'Arroz 5kg': 85, 'Aceite Vegetal': 45, 'Pasta Barilla': 35, 'Cereal Kellogs': 120, 'Leche Lala': 28,
    'Vitaminas C': 180, 'Paracetamol': 25, 'Crema Hidratante': 120, 'Shampoo Pantene': 85, 'Pasta Dental': 45,
    'Libro Python': 650, 'Novela Bestseller': 320, 'Enciclopedia': 1200, 'Comic Marvel': 85, 'Revista Tech': 45,
    'Lego Classic': 850, 'Muñeca Barbie': 420, 'Carro Control Remoto': 680, 'Rompecabezas 1000': 180, 'Pelota Basketball': 320
}

vendedores = ['Juan Perez', 'Ana Garcia', 'Carlos Lopez', 'Maria Rodriguez', 'Luis Martinez', 'Sofia Hernandez']

# Generar datos de ventas
ventas_data = []
fecha_inicio = datetime(2025, 1, 1)
fecha_fin = datetime(2025, 6, 30)

for single_date in pd.date_range(fecha_inicio, fecha_fin):
    for sucursal in sucursales:
        ciudad = ciudades[sucursales.index(sucursal)]
        num_transacciones = random.randint(30, 80)  # 30-80 transacciones por día por sucursal
        
        for _ in range(num_transacciones):
            producto = random.choice(productos)
            categoria = categorias[producto]
            cantidad = random.randint(1, 5)
            precio_unitario = precios[producto]
            # Agregar variación de precio ±10%
            precio_unitario *= random.uniform(0.9, 1.1)
            total_venta = cantidad * precio_unitario
            vendedor = random.choice(vendedores)
            
            ventas_data.append({
                'fecha': single_date.strftime('%Y-%m-%d'),
                'sucursal': sucursal,
                'ciudad': ciudad,
                'producto': producto,
                'categoria': categoria,
                'cantidad': cantidad,
                'precio_unitario': round(precio_unitario, 2),
                'total_venta': round(total_venta, 2),
                'vendedor': vendedor
            })

# Crear DataFrame y guardar
df_ventas = pd.DataFrame(ventas_data)
df_ventas.to_csv('ventas_datamart.csv', index=False)
print(f"Dataset generado con {len(df_ventas)} registros")
print(df_ventas.head())
```

### Fase 2: Desarrollo del Sistema de Análisis (Semana 1-2)

#### Paso 4: Función de Carga y Validación
```python
def cargar_datos_ventas(archivo_csv):
    """
    Carga y valida datos de ventas desde archivo CSV
    
    Parameters:
    archivo_csv (str): Ruta al archivo CSV
    
    Returns:
    pd.DataFrame: DataFrame con los datos validados
    """
    try:
        # Cargar datos
        df = pd.read_csv(archivo_csv)
        
        # Validar columnas requeridas
        columnas_requeridas = ['fecha', 'sucursal', 'ciudad', 'producto', 'categoria', 
                             'cantidad', 'precio_unitario', 'total_venta', 'vendedor']
        
        columnas_faltantes = set(columnas_requeridas) - set(df.columns)
        if columnas_faltantes:
            raise ValueError(f"Columnas faltantes: {columnas_faltantes}")
        
        print(f"✓ Datos cargados exitosamente: {len(df)} registros")
        print(f"✓ Periodo: {df['fecha'].min()} a {df['fecha'].max()}")
        print(f"✓ Sucursales: {df['sucursal'].nunique()}")
        print(f"✓ Productos únicos: {df['producto'].nunique()}")
        
        return df
        
    except FileNotFoundError:
        print(f"❌ Error: No se encontró el archivo {archivo_csv}")
        return None
    except Exception as e:
        print(f"❌ Error al cargar datos: {str(e)}")
        return None
```

#### Paso 5: Función de Limpieza y Preprocesamiento
```python
def limpiar_datos(df):
    """
    Limpia y preprocesa los datos de ventas
    
    Parameters:
    df (pd.DataFrame): DataFrame con datos crudos
    
    Returns:
    pd.DataFrame: DataFrame limpio y procesado
    """
    # Crear copia para no modificar el original
    df_clean = df.copy()
    
    # Convertir fecha a datetime
    df_clean['fecha'] = pd.to_datetime(df_clean['fecha'])
    
    # Crear columnas adicionales
    df_clean['año'] = df_clean['fecha'].dt.year
    df_clean['mes'] = df_clean['fecha'].dt.month
    df_clean['día_semana'] = df_clean['fecha'].dt.day_name()
    df_clean['trimestre'] = df_clean['fecha'].dt.quarter
    
    # Validar tipos numéricos
    columnas_numericas = ['cantidad', 'precio_unitario', 'total_venta']
    for col in columnas_numericas:
        df_clean[col] = pd.to_numeric(df_clean[col], errors='coerce')
    
    # Identificar y reportar valores faltantes
    valores_faltantes = df_clean.isnull().sum()
    if valores_faltantes.sum() > 0:
        print("⚠️ Valores faltantes encontrados:")
        print(valores_faltantes[valores_faltantes > 0])
    
    # Eliminar filas con valores críticos faltantes
    df_clean = df_clean.dropna(subset=['fecha', 'sucursal', 'producto', 'total_venta'])
    
    # Validar consistencia de datos
    df_clean['total_calculado'] = df_clean['cantidad'] * df_clean['precio_unitario']
    df_clean['diferencia'] = abs(df_clean['total_venta'] - df_clean['total_calculado'])
    
    # Reportar inconsistencias
    inconsistencias = (df_clean['diferencia'] > 1).sum()  # diferencia mayor a $1
    if inconsistencias > 0:
        print(f"⚠️ {inconsistencias} registros con posibles inconsistencias en cálculos")
    
    # Limpiar columna temporal
    df_clean = df_clean.drop(['total_calculado', 'diferencia'], axis=1)
    
    print(f"✓ Limpieza completada: {len(df_clean)} registros válidos")
    
    return df_clean
```

#### Paso 6: Análisis Descriptivo por Sucursal
```python
def analizar_por_sucursal(df):
    """
    Genera análisis descriptivo por sucursal
    
    Parameters:
    df (pd.DataFrame): DataFrame con datos limpios
    
    Returns:
    pd.DataFrame: Resumen estadístico por sucursal
    """
    # Análisis por sucursal
    resumen_sucursales = df.groupby(['sucursal', 'ciudad']).agg({
        'total_venta': ['count', 'sum', 'mean', 'std'],
        'cantidad': 'sum',
        'producto': 'nunique'
    }).round(2)
    
    # Aplanar columnas multinivel
    resumen_sucursales.columns = ['_'.join(col).strip() for col in resumen_sucursales.columns]
    
    # Renombrar columnas para claridad
    resumen_sucursales = resumen_sucursales.rename(columns={
        'total_venta_count': 'transacciones_total',
        'total_venta_sum': 'ventas_totales',
        'total_venta_mean': 'venta_promedio',
        'total_venta_std': 'desviacion_std',
        'cantidad_sum': 'productos_vendidos',
        'producto_nunique': 'productos_unicos'
    })
    
    # Agregar ranking por ventas
    resumen_sucursales['ranking_ventas'] = resumen_sucursales['ventas_totales'].rank(ascending=False)
    
    # Calcular participación de mercado
    total_general = resumen_sucursales['ventas_totales'].sum()
    resumen_sucursales['participacion_mercado'] = (resumen_sucursales['ventas_totales'] / total_general * 100).round(2)
    
    print("📊 Análisis por sucursal completado")
    print(f"💰 Ventas totales: ${total_general:,.2f}")
    
    return resumen_sucursales.reset_index()
```

#### Paso 7: Análisis Temporal y por Categorías
```python
def analizar_tendencias_temporales(df):
    """
    Analiza tendencias de ventas por tiempo y categoría
    """
    # Análisis mensual
    ventas_mensuales = df.groupby(['año', 'mes']).agg({
        'total_venta': 'sum',
        'cantidad': 'sum'
    }).reset_index()
    
    # Crear etiqueta de mes
    ventas_mensuales['periodo'] = ventas_mensuales['año'].astype(str) + '-' + \
                                 ventas_mensuales['mes'].astype(str).str.zfill(2)
    
    # Análisis por categoría
    ventas_categoria = df.groupby('categoria').agg({
        'total_venta': 'sum',
        'cantidad': 'sum',
        'producto': 'nunique'
    }).sort_values('total_venta', ascending=False)
    
    # Top 10 productos
    top_productos = df.groupby('producto')['total_venta'].sum().sort_values(ascending=False).head(10)
    
    return ventas_mensuales, ventas_categoria, top_productos

def analizar_patrones_semanales(df):
    """
    Analiza patrones de venta por día de la semana
    """
    # Definir orden de días
    orden_dias = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday']
    
    ventas_semanales = df.groupby('día_semana').agg({
        'total_venta': ['sum', 'mean'],
        'cantidad': 'sum'
    }).round(2)
    
    # Reordenar según días de la semana
    ventas_semanales = ventas_semanales.reindex(orden_dias)
    
    return ventas_semanales
```

### Fase 3: Visualizaciones y Dashboard (Semana 2-3)

#### Paso 8: Sistema de Visualizaciones
```python
def crear_dashboard_ventas(df):
    """
    Crea dashboard con visualizaciones principales
    
    Parameters:
    df (pd.DataFrame): DataFrame con datos procesados
    
    Returns:
    None (muestra gráficos)
    """
    # Configurar el layout del dashboard
    fig, axes = plt.subplots(2, 3, figsize=(20, 12))
    fig.suptitle('Dashboard de Análisis de Ventas - DataMart Solutions', fontsize=16, fontweight='bold')
    
    # 1. Ventas por Sucursal
    resumen_suc = df.groupby(['sucursal', 'ciudad'])['total_venta'].sum().reset_index()
    resumen_suc = resumen_suc.sort_values('total_venta', ascending=True)
    
    axes[0,0].barh(resumen_suc['sucursal'], resumen_suc['total_venta'])
    axes[0,0].set_title('Ventas Totales por Sucursal')
    axes[0,0].set_xlabel('Ventas ($)')
    for i, v in enumerate(resumen_suc['total_venta']):
        axes[0,0].text(v + max(resumen_suc['total_venta'])*0.01, i, f'${v:,.0f}', va='center')
    
    # 2. Tendencia Mensual
    ventas_mes = df.groupby(df['fecha'].dt.to_period('M'))['total_venta'].sum()
    axes[0,1].plot(ventas_mes.index.astype(str), ventas_mes.values, marker='o', linewidth=2)
    axes[0,1].set_title('Tendencia de Ventas Mensuales')
    axes[0,1].set_xlabel('Mes')
    axes[0,1].set_ylabel('Ventas ($)')
    axes[0,1].tick_params(axis='x', rotation=45)
    
    # 3. Ventas por Categoría
    ventas_cat = df.groupby('categoria')['total_venta'].sum().sort_values(ascending=False)
    axes[0,2].pie(ventas_cat.values, labels=ventas_cat.index, autopct='%1.1f%%', startangle=90)
    axes[0,2].set_title('Distribución de Ventas por Categoría')
    
    # 4. Top 10 Productos
    top_10 = df.groupby('producto')['total_venta'].sum().sort_values(ascending=True).tail(10)
    axes[1,0].barh(range(len(top_10)), top_10.values)
    axes[1,0].set_yticks(range(len(top_10)))
    axes[1,0].set_yticklabels(top_10.index)
    axes[1,0].set_title('Top 10 Productos por Ventas')
    axes[1,0].set_xlabel('Ventas ($)')
    
    # 5. Patrón Semanal
    orden_dias = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday']
    dias_esp = ['Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado', 'Domingo']
    
    ventas_dia = df.groupby('día_semana')['total_venta'].mean().reindex(orden_dias)
    axes[1,1].bar(dias_esp, ventas_dia.values)
    axes[1,1].set_title('Patrón de Ventas por Día de la Semana')
    axes[1,1].set_xlabel('Día de la Semana')
    axes[1,1].set_ylabel('Venta Promedio ($)')
    axes[1,1].tick_params(axis='x', rotation=45)
    
    # 6. Análisis de Vendedores
    ventas_vendedor = df.groupby('vendedor')['total_venta'].sum().sort_values(ascending=True)
    axes[1,2].barh(ventas_vendedor.index, ventas_vendedor.values)
    axes[1,2].set_title('Desempeño por Vendedor')
    axes[1,2].set_xlabel('Ventas Totales ($)')
    
    # Ajustar layout
    plt.tight_layout()
    plt.show()
    
    # Métricas clave
    print("\n" + "="*60)
    print("📈 MÉTRICAS CLAVE DE DESEMPEÑO")
    print("="*60)
    print(f"💰 Ventas totales: ${df['total_venta'].sum():,.2f}")
    print(f"📊 Transacciones totales: {len(df):,}")
    print(f"💳 Venta promedio por transacción: ${df['total_venta'].mean():.2f}")
    print(f"🏪 Número de sucursales: {df['sucursal'].nunique()}")
    print(f"📦 Productos únicos vendidos: {df['producto'].nunique()}")
    print(f"👥 Número de vendedores: {df['vendedor'].nunique()}")
    
    # Top performers
    print(f"\n🏆 Mejor sucursal: {resumen_suc.iloc[-1]['sucursal']} (${resumen_suc.iloc[-1]['total_venta']:,.2f})")
    print(f"⭐ Mejor vendedor: {ventas_vendedor.index[-1]} (${ventas_vendedor.iloc[-1]:,.2f})")
    print(f"🥇 Categoría líder: {ventas_cat.index[0]} (${ventas_cat.iloc[0]:,.2f})")
```

#### Paso 9: Generación de Reportes Automatizados
```python
def generar_reporte_ejecutivo(df):
    """
    Genera reporte ejecutivo con insights clave
    """
    print("\n" + "="*80)
    print("📋 REPORTE EJECUTIVO - DATAMART SOLUTIONS")
    print("="*80)
    
    # Periodo de análisis
    fecha_inicio = df['fecha'].min().strftime('%d/%m/%Y')
    fecha_fin = df['fecha'].max().strftime('%d/%m/%Y')
    print(f"📅 Periodo de análisis: {fecha_inicio} - {fecha_fin}")
    
    # Resumen general
    total_ventas = df['total_venta'].sum()
    total_transacciones = len(df)
    ticket_promedio = df['total_venta'].mean()
    
    print(f"\n📊 RESUMEN GENERAL:")
    print(f"   💰 Ventas totales: ${total_ventas:,.2f}")
    print(f"   📈 Total transacciones: {total_transacciones:,}")
    print(f"   💳 Ticket promedio: ${ticket_promedio:.2f}")
    
    # Análisis por sucursal
    print(f"\n🏪 ANÁLISIS POR SUCURSAL:")
    sucursal_performance = df.groupby(['sucursal', 'ciudad']).agg({
        'total_venta': 'sum',
        'cantidad': 'sum'
    }).sort_values('total_venta', ascending=False)
    
    for idx, (sucursal, data) in enumerate(sucursal_performance.iterrows(), 1):
        participacion = (data['total_venta'] / total_ventas) * 100
        print(f"   {idx}. {sucursal[0]} ({sucursal[1]}): ${data['total_venta']:,.2f} ({participacion:.1f}%)")
    
    # Categorías más vendidas
    print(f"\n📦 TOP CATEGORÍAS:")
    cat_performance = df.groupby('categoria')['total_venta'].sum().sort_values(ascending=False)
    for idx, (categoria, ventas) in enumerate(cat_performance.head(5).items(), 1):
        participacion = (ventas / total_ventas) * 100
        print(f"   {idx}. {categoria}: ${ventas:,.2f} ({participacion:.1f}%)")
    
    # Tendencias temporales
    ventas_mensuales = df.groupby(df['fecha'].dt.to_period('M'))['total_venta'].sum()
    crecimiento = ((ventas_mensuales.iloc[-1] - ventas_mensuales.iloc[0]) / ventas_mensuales.iloc[0]) * 100
    
    print(f"\n📈 TENDENCIAS:")
    print(f"   📊 Mejor mes: {ventas_mensuales.idxmax()} (${ventas_mensuales.max():,.2f})")
    print(f"   📉 Peor mes: {ventas_mensuales.idxmin()} (${ventas_mensuales.min():,.2f})")
    print(f"   📈 Crecimiento periodo: {crecimiento:+.1f}%")
    
    # Recomendaciones
    print(f"\n💡 RECOMENDACIONES ESTRATÉGICAS:")
    
    # Identificar sucursal con menor performance
    peor_sucursal = sucursal_performance.index[-1]
    print(f"   🎯 Enfocar esfuerzos en {peor_sucursal[0]} ({peor_sucursal[1]}) para mejorar ventas")
    
    # Identificar categoría de mayor crecimiento potencial
    cat_oportunidad = cat_performance.index[-1]  # Categoría con menores ventas
    print(f"   📈 Desarrollar estrategia de marketing para categoría '{cat_oportunidad}'")
    
    # Análisis de días de la semana
    mejor_dia = df.groupby('día_semana')['total_venta'].mean().idxmax()
    print(f"   🗓️ Optimizar inventario para {mejor_dia}s (día con mayor venta promedio)")
    
    print("="*80)

def generar_alertas_operacionales(df):
    """
    Genera alertas basadas en patrones anómalos
    """
    print("\n🚨 ALERTAS OPERACIONALES:")
    
    # Detectar productos con baja rotación
    productos_ventas = df.groupby('producto')['cantidad'].sum()
    umbral_bajo = productos_ventas.quantile(0.1)  # 10% inferior
    productos_baja_rotacion = productos_ventas[productos_ventas <= umbral_bajo]
    
    if len(productos_baja_rotacion) > 0:
        print(f"⚠️ {len(productos_baja_rotacion)} productos con baja rotación requieren atención")
    
    # Detectar variaciones significativas en precios
    precios_producto = df.groupby('producto')['precio_unitario'].agg(['mean', 'std'])
    productos_precio_variable = precios_producto[precios_producto['std'] / precios_producto['mean'] > 0.1]
    
    if len(productos_precio_variable) > 0:
        print(f"💰 {len(productos_precio_variable)} productos con alta variación de precios")
    
    # Detectar sucursales con performance muy por debajo del promedio
    ventas_sucursal = df.groupby('sucursal')['total_venta'].sum()
    promedio_sucursal = ventas_sucursal.mean()
    sucursales_bajo_promedio = ventas_sucursal[ventas_sucursal < promedio_sucursal * 0.8]
    
    if len(sucursales_bajo_promedio) > 0:
        print(f"🏪 {len(sucursales_bajo_promedio)} sucursales con ventas 20% por debajo del promedio")
```

### Fase 4: Integración y Documentación (Semana 3)

#### Paso 10: Sistema Integrado Principal
```python
def sistema_analisis_completo(archivo_datos):
    """
    Sistema integrado de análisis de ventas
    
    Parameters:
    archivo_datos (str): Ruta al archivo CSV con datos de ventas
    """
    print("🚀 INICIANDO SISTEMA DE ANÁLISIS DE VENTAS")
    print("="*60)
    
    # 1. Cargar datos
    df = cargar_datos_ventas(archivo_datos)
    if df is None:
        return
    
    # 2. Limpiar y procesar datos
    df_clean = limpiar_datos(df)
    
    # 3. Generar análisis descriptivos
    print("\n📊 Generando análisis por sucursal...")
    resumen_sucursales = analizar_por_sucursal(df_clean)
    
    print("\n📈 Analizando tendencias temporales...")
    ventas_mensuales, ventas_categoria, top_productos = analizar_tendencias_temporales(df_clean)
    
    print("\n📅 Analizando patrones semanales...")
    ventas_semanales = analizar_patrones_semanales(df_clean)
    
    # 4. Crear visualizaciones
    print("\n📊 Creando dashboard de visualizaciones...")
    crear_dashboard_ventas(df_clean)
    
    # 5. Generar reportes
    generar_reporte_ejecutivo(df_clean)
    generar_alertas_operacionales(df_clean)
    
    print("\n✅ ANÁLISIS COMPLETADO EXITOSAMENTE")
    
    # Retornar datos para análisis adicional
    return {
        'datos_limpios': df_clean,
        'resumen_sucursales': resumen_sucursales,
        'ventas_mensuales': ventas_mensuales,
        'ventas_categoria': ventas_categoria,
        'top_productos': top_productos,
        'ventas_semanales': ventas_semanales
    }

# Ejecutar sistema completo
if __name__ == "__main__":
    resultados = sistema_analisis_completo('ventas_datamart.csv')
```

#### Paso 11: Notebook Final Estructurado
El notebook final debe seguir esta estructura:

```markdown
# Sistema de Análisis de Ventas - DataMart Solutions
**Estudiante**: [Nombre del estudiante]  
**Fecha**: [Fecha de entrega]  
**Curso**: Analítica y Ciencia de Datos - Unidad 1

## Índice
1. [Configuración del Entorno](#configuracion)
2. [Carga y Exploración de Datos](#carga)
3. [Limpieza y Preprocesamiento](#limpieza)
4. [Análisis Descriptivo](#analisis)
5. [Visualizaciones](#visualizaciones)
6. [Reportes Automatizados](#reportes)
7. [Conclusiones y Recomendaciones](#conclusiones)

## 1. Configuración del Entorno {#configuracion}
[Código de importación de bibliotecas y configuración]

## 2. Carga y Exploración de Datos {#carga}
[Implementación de función de carga y exploración inicial]

## 3. Limpieza y Preprocesamiento {#limpieza}
[Función de limpieza y validación de datos]

## 4. Análisis Descriptivo {#analisis}
[Análisis estadístico por sucursales, categorías y temporal]

## 5. Visualizaciones {#visualizaciones}
[Dashboard completo con gráficos informativos]

## 6. Reportes Automatizados {#reportes}
[Generación de reportes ejecutivos y alertas]

## 7. Conclusiones y Recomendaciones {#conclusiones}
### Principales Hallazgos
- [Hallazgo 1 con evidencia de datos]
- [Hallazgo 2 con evidencia de datos]
- [Hallazgo 3 con evidencia de datos]

### Recomendaciones Estratégicas
- [Recomendación 1 basada en análisis]
- [Recomendación 2 basada en análisis]
- [Recomendación 3 basada en análisis]

### Oportunidades de Mejora del Sistema
- [Mejora técnica 1]
- [Mejora técnica 2]
- [Mejora técnica 3]
```

---

## Rúbrica de Evaluación

### Indicadores de Alcance para Rúbrica

Según el Manual de Evaluación ASERTUM y el diseño instruccional de la Unidad 1, la rúbrica debe evaluar **competencias técnicas** y **productos de análisis** con los siguientes indicadores de alcance:

**Nivel 4 - Excelente (3 puntos)**: Dominio completo de herramientas, código optimizado, análisis profundo
**Nivel 3 - Bueno (2 puntos)**: Manejo adecuado de herramientas, código funcional, análisis correcto  
**Nivel 2 - Aceptable (1 punto)**: Uso básico de herramientas, código simple, análisis superficial
**Nivel 1 - Insuficiente (0 puntos)**: Herramientas mal utilizadas, código no funcional, análisis incorrecto

### Instrumento de Evaluación: Rúbrica Analítica

| Criterio de Evaluación | Excelente (3) | Bueno (2) | Aceptable (1) | Insuficiente (0) | Peso |
|------------------------|---------------|-----------|---------------|------------------|------|
| **1. Configuración y Manejo del Entorno Python** | Configuración perfecta de Anaconda/Jupyter. Manejo experto de bibliotecas. Código que demuestra dominio completo del entorno. Implementa funcionalidades avanzadas no vistas en clase. | Configuración correcta del entorno. Buen manejo de las bibliotecas principales. Código funcional que demuestra comprensión sólida. Usa correctamente las herramientas enseñadas. | Configuración básica del entorno. Manejo elemental de bibliotecas. Código simple pero funcional. Demuestra comprensión básica de las herramientas. | Configuración incorrecta o incompleta. No maneja adecuadamente las bibliotecas. Código con errores críticos o no ejecutable. No demuestra comprensión del entorno. | **20%** |
| **2. Programación Python y Estructuras de Datos** | Código excepcional con estructuras de datos avanzadas. Funciones bien diseñadas y modulares. Uso eficiente de NumPy arrays y operaciones vectorizadas. Manejo experto de tipos de datos y control de flujo. | Código bien estructurado con buen uso de funciones. Manejo correcto de estructuras de datos básicas. Uso apropiado de NumPy para operaciones matemáticas. Control de flujo implementado correctamente. | Código funcional básico con estructuras simples. Uso elemental de funciones y tipos de datos. Implementación básica de NumPy. Control de flujo simple pero correcto. | Código deficiente con errores de sintaxis o lógica. Mal uso de estructuras de datos. No implementa correctamente NumPy. Errores en control de flujo o tipos de datos. | **25%** |
| **3. Análisis de Datos con Pandas** | Manipulación avanzada de DataFrames con operaciones complejas. Uso experto de groupby, merge, pivot. Limpieza de datos sofisticada con manejo de casos edge. Análisis estadístico profundo y preciso. | Manipulación correcta de DataFrames con operaciones esenciales. Buen uso de funciones de agrupación y agregación. Limpieza de datos efectiva. Análisis estadístico apropiado. | Manipulación básica de DataFrames con operaciones simples. Uso elemental de funciones de Pandas. Limpieza de datos básica. Análisis estadístico superficial pero correcto. | Manipulación incorrecta de DataFrames. No usa apropiadamente las funciones de Pandas. Limpieza de datos inadecuada o ausente. Análisis estadístico erróneo o faltante. | **25%** |
| **4. Visualizaciones con Matplotlib** | Visualizaciones profesionales, estéticamente excelentes y altamente informativas. Uso avanzado de customización. Gráficos innovadores que comunican insights efectivamente. Dashboard integrado y funcional. | Visualizaciones correctas y bien presentadas. Uso apropiado de títulos, etiquetas y leyendas. Gráficos claros que comunican información efectivamente. Dashboard funcional básico. | Visualizaciones básicas pero funcionales. Elementos esenciales presentes (títulos, etiquetas). Gráficos simples que muestran información básica. Intentos de dashboard. | Visualizaciones deficientes o incorrectas. Falta elementos esenciales. Gráficos confusos o que no comunican información útil. No implementa dashboard o es disfuncional. | **15%** |
| **5. Funcionalidad y Modularidad del Código** | Código altamente modular con funciones bien documentadas. Excelente manejo de errores. Sistema integrado completamente funcional. Reutilización efectiva de código. Documentación técnica excepcional. | Código bien organizado con funciones apropiadas. Manejo básico de errores. Sistema funcional que cumple todos los requisitos. Documentación adecuada con comentarios claros. | Código organizado básicamente con algunas funciones. Manejo limitado de errores. Sistema que cumple requisitos mínimos. Documentación básica presente. | Código mal organizado o monolítico. Sin manejo de errores. Sistema no funcional o incompleto. Documentación deficiente o ausente. | **10%** |
| **6. Reflexión y Aplicación Empresarial** | Reflexión profunda sobre el proceso de aprendizaje. Identifica múltiples aplicaciones empresariales avanzadas. Propone mejoras innovadoras al sistema. Demuestra pensamiento crítico excepcional sobre analítica de datos. | Reflexión adecuada sobre aprendizaje. Identifica aplicaciones empresariales relevantes. Propone mejoras viables al sistema. Demuestra comprensión sólida del valor empresarial. | Reflexión básica presente. Identifica algunas aplicaciones empresariales. Propone mejoras simples. Comprensión elemental del contexto empresarial. | Reflexión superficial o ausente. No identifica aplicaciones empresariales claras. No propone mejoras o son irrelevantes. No demuestra comprensión del contexto empresarial. | **5%** |
| **CALIFICACIÓN TOTAL** |  |  |  |  | **100%** |

### Escala de Calificación Final

| Puntuación Total | Calificación | Nivel de Desempeño |
|------------------|--------------|-------------------|
| 15.0 - 18.0 | 9.0 - 10.0 | Excelente |
| 12.0 - 14.9 | 7.0 - 8.9 | Bueno |
| 9.0 - 11.9 | 6.0 - 6.9 | Aceptable |
| 0.0 - 8.9 | 0.0 - 5.9 | Insuficiente |

### Criterios Específicos de Evaluación por Indicador TecNM

#### Indicador A (30%) - Adaptación a situaciones complejas y contextos
**Evidencia en el Producto**:
- Manejo de diferentes tipos de datos y formatos
- Adaptación del código a distintos escenarios empresariales
- Flexibilidad del sistema para diferentes datasets
- Configuración exitosa en diferentes sistemas operativos

**Criterios de Evaluación**:
- **Excelente**: Sistema adaptable a múltiples contextos, manejo de casos edge complejos
- **Bueno**: Sistema funcional en diferentes escenarios estándar
- **Aceptable**: Sistema básico que funciona en contexto específico
- **Insuficiente**: Sistema rígido que no se adapta a variaciones

#### Indicador B (25%) - Contribuciones a actividades académicas
**Evidencia en el Producto**:
- Calidad de la documentación para compartir conocimiento
- Código reutilizable que otros pueden aprovechar
- Insights empresariales que aportan valor al caso de estudio
- Participación en discusiones técnicas (evaluada separadamente)

**Criterios de Evaluación**:
- **Excelente**: Contribuciones significativas que enriquecen el aprendizaje colectivo
- **Bueno**: Contribuciones apropiadas y útiles para el contexto académico
- **Aceptable**: Contribuciones básicas que cumplen requisitos mínimos
- **Insuficiente**: Sin contribuciones significativas o de baja calidad

#### Indicador C (15%) - Propuestas de soluciones no vistas en clase
**Evidencia en el Producto**:
- Implementación de funcionalidades adicionales
- Uso creativo de bibliotecas o métodos
- Optimizaciones o mejoras propias al código
- Análisis o visualizaciones innovadoras

**Criterios de Evaluación**:
- **Excelente**: Múltiples innovaciones técnicas funcionales y útiles
- **Bueno**: Algunas mejoras o funcionalidades adicionales implementadas
- **Aceptable**: Al menos una propuesta de mejora implementada
- **Insuficiente**: Solo implementa lo visto en clase sin variaciones

#### Indicador D (15%) - Recursos que promueven pensamiento crítico
**Evidencia en el Producto**:
- Referencias adicionales consultadas y aplicadas
- Comparación de diferentes enfoques técnicos
- Análisis crítico de limitaciones del sistema
- Investigación de herramientas complementarias

**Criterios de Evaluación**:
- **Excelente**: Investigación profunda con múltiples recursos técnicos aplicados
- **Bueno**: Consulta de recursos adicionales con aplicación práctica
- **Aceptable**: Algunas referencias adicionales consultadas
- **Insuficiente**: Solo usa recursos proporcionados en clase

#### Indicador E (7%) - Conocimiento interdisciplinario
**Evidencia en el Producto**:
- Conexiones con conceptos matemáticos/estadísticos
- Aplicación de principios de administración o economía
- Integración de aspectos de ingeniería de software
- Consideraciones de diseño o experiencia de usuario

**Criterios de Evaluación**:
- **Excelente**: Integración fluida de múltiples disciplinas
- **Bueno**: Algunas conexiones interdisciplinarias evidentes
- **Aceptable**: Conexiones básicas con otras disciplinas
- **Insuficiente**: Enfoque puramente técnico sin conexiones

#### Indicador F (8%) - Trabajo autónomo y autorregulado
**Evidencia en el Producto**:
- Gestión independiente del cronograma de trabajo
- Calidad consistente a lo largo del proyecto
- Resolución autónoma de problemas técnicos
- Reflexión sobre el proceso de aprendizaje

**Criterios de Evaluación**:
- **Excelente**: Gestión completamente autónoma con alta calidad sostenida
- **Bueno**: Trabajo independiente con algunas consultas apropiadas
- **Aceptable**: Trabajo básicamente autónomo con apoyo mínimo
- **Insuficiente**: Dependencia excesiva de apoyo externo

---

## Recursos de Apoyo

### Herramientas Requeridas
- **Anaconda Distribution**: Python 3.8+ con Jupyter Notebooks
- **Bibliotecas principales**: NumPy, Pandas, Matplotlib
- **Editor de código**: VS Code o PyCharm (opcional)
- **Git**: Para control de versiones (opcional)

### Datasets de Apoyo
- **Generador incluido**: Script para crear datos sintéticos realistas
- **Datasets alternativos**: Enlaces a Kaggle y UCI ML Repository
- **Datos empresariales**: Plantillas para casos reales

### Cronograma Detallado
- **Semana 1, Días 1-2**: Configuración del entorno y generación de datos
- **Semana 1, Días 3-5**: Desarrollo de funciones de carga y limpieza
- **Semana 2, Días 1-3**: Implementación de análisis descriptivos
- **Semana 2, Días 4-5**: Creación de visualizaciones y dashboard
- **Semana 3, Días 1-3**: Sistema integrado y generación de reportes
- **Semana 3, Días 4-5**: Documentación final y reflexión

### Criterios de Entrega
- **Formato digital**: Todos los archivos en carpeta comprimida (.zip)
- **Nomenclatura**: Apellido_Nombre_EvidenciaU1_Python
- **Plataforma**: Subida a Moodle en la sección correspondiente
- **Fecha límite**: Viernes de la semana 3 antes de las 23:59 hrs
- **Respaldo**: Conservar copia de todos los archivos desarrollados

---

## Competencias e Indicadores de Impacto Evaluados

### Vinculación con Competencias de la Unidad 1

| Competencia Específica | Evidencia en el Producto | Criterio de Evaluación |
|------------------------|-------------------------|------------------------|
| **Configurar entorno de desarrollo Python** | Sistema completamente funcional con todas las bibliotecas | Funcionamiento sin errores + configuraciones optimizadas |
| **Aplicar estructuras de control y tipos de datos** | Funciones modulares con lógica correcta | Código bien estructurado + manejo apropiado de datos |
| **Utilizar NumPy, Pandas y Matplotlib** | Análisis completo + visualizaciones profesionales | Uso avanzado de las bibliotecas + resultados correctos |

### Alineación con Perfil de Egreso TecNM

Esta evidencia desarrolla las siguientes competencias del perfil de egreso:

1. **Resolución de problemas complejos**: A través del análisis de datos empresariales reales
2. **Uso de herramientas tecnológicas**: Mediante el dominio de Python y sus bibliotecas
3. **Pensamiento analítico**: Por medio del análisis estadístico y generación de insights
4. **Comunicación técnica**: A través de la documentación y visualizaciones profesionales
5. **Aprendizaje autónomo**: Mediante la investigación independiente y resolución de problemas
6. **Aplicación empresarial**: Por medio del contexto de negocio y generación de valor

Esta evidencia de producto proporciona una evaluación integral de las competencias fundamentales de programación para analítica de datos, estableciendo las bases sólidas necesarias para las unidades subsecuentes del curso.
