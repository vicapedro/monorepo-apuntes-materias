# Práctica 5: Creación de gráficas con Matplotlib

## Objetivo
Dominar las técnicas de visualización de datos usando Matplotlib para crear gráficos informativos y profesionales que comuniquen insights de manera efectiva en contextos empresariales y analíticos.

## Competencias
- Crear gráficos básicos (líneas, barras, dispersión, histogramas) con Matplotlib
- Personalizar elementos gráficos (títulos, etiquetas, colores, estilos)
- Generar visualizaciones complejas con múltiples subplots y ejes
- Aplicar principios de design para comunicación efectiva de datos
- Crear visualizaciones interactivas básicas y exportar en diferentes formatos
- Integrar gráficos con análisis de datos usando Pandas para storytelling
- Seleccionar el tipo de visualización apropiado según el tipo de datos y mensaje

## Introducción
Matplotlib es la biblioteca fundamental para visualización de datos en Python y la base sobre la cual se construyen muchas otras bibliotecas de gráficos. Su flexibilidad permite crear desde gráficos simples hasta visualizaciones altamente personalizadas y publicaciones de calidad científica.

La visualización efectiva de datos es crucial en el análisis empresarial, ya que permite comunicar patrones, tendencias y insights de manera que sean comprensibles para audiencias técnicas y no técnicas. Un buen gráfico puede revelar patrones que no son evidentes en tablas numéricas y facilitar la toma de decisiones basada en datos.

## Instrucciones

### Parte 1: Gráficos básicos
1. Configurar el entorno de Matplotlib y estilos básicos
2. Crear gráficos de líneas para series temporales
3. Generar gráficos de barras para comparaciones categóricas
4. Desarrollar histogramas para distribuciones de datos

### Parte 2: Personalización avanzada
1. Modificar colores, estilos de línea y marcadores
2. Agregar títulos, etiquetas y leyendas descriptivas
3. Configurar ejes y escalas apropiadas
4. Aplicar temas y estilos profesionales

### Parte 3: Gráficos complejos
1. Crear subplots para análisis multidimensional
2. Desarrollar gráficos de dispersión con múltiples variables
3. Generar box plots para análisis de distribuciones
4. Implementar gráficos combinados (barras + líneas)

### Parte 4: Visualizaciones empresariales
1. Crear dashboards básicos con múltiples métricas
2. Desarrollar reportes visuales automatizados
3. Exportar gráficos en formatos de alta calidad
4. Integrar visualizaciones con análisis de Pandas

## Ejercicio

### Ejercicio 1: Dashboard de ventas empresariales
```python
import matplotlib.pyplot as plt
import pandas as pd
import numpy as np
from datetime import datetime, timedelta
import seaborn as sns

# Configuración de estilo global
plt.style.use('seaborn-v0_8')
sns.set_palette("husl")

# Crear datos sintéticos de ventas
np.random.seed(42)
fechas = pd.date_range('2023-01-01', periods=365, freq='D')

# Simular datos de ventas con tendencias y estacionalidad
trend = np.linspace(10000, 15000, 365)
seasonality = 3000 * np.sin(2 * np.pi * np.arange(365) / 365) + 2000 * np.sin(2 * np.pi * np.arange(365) / 30)
noise = np.random.normal(0, 1000, 365)
ventas_diarias = trend + seasonality + noise

# Crear DataFrame
df_ventas = pd.DataFrame({
    'fecha': fechas,
    'ventas': ventas_diarias,
    'mes': fechas.month,
    'trimestre': fechas.quarter,
    'dia_semana': fechas.day_name()
})

# Agregar datos por categorías de producto
categorias = ['Electrónicos', 'Ropa', 'Hogar', 'Deportes']
for categoria in categorias:
    df_ventas[f'ventas_{categoria.lower()}'] = ventas_diarias * np.random.uniform(0.1, 0.4, 365)

print("=== DASHBOARD DE VENTAS EMPRESARIALES ===")

# Crear dashboard con múltiples subplots
fig, axes = plt.subplots(2, 3, figsize=(20, 12))
fig.suptitle('Dashboard de Análisis de Ventas 2023', fontsize=16, fontweight='bold')

# 1. Gráfico de línea: Evolución temporal de ventas
axes[0, 0].plot(df_ventas['fecha'], df_ventas['ventas'], linewidth=2, color='#2E86C1', alpha=0.8)
axes[0, 0].set_title('Evolución de Ventas Diarias', fontweight='bold')
axes[0, 0].set_xlabel('Fecha')
axes[0, 0].set_ylabel('Ventas ($)')
axes[0, 0].grid(True, alpha=0.3)
axes[0, 0].tick_params(axis='x', rotation=45)

# Agregar línea de tendencia
z = np.polyfit(range(len(ventas_diarias)), ventas_diarias, 1)
p = np.poly1d(z)
axes[0, 0].plot(df_ventas['fecha'], p(range(len(ventas_diarias))), '--', color='red', alpha=0.8, linewidth=2, label='Tendencia')
axes[0, 0].legend()

# 2. Gráfico de barras: Ventas por mes
ventas_mensuales = df_ventas.groupby('mes')['ventas'].sum() / 1000  # En miles
meses = ['Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun', 'Jul', 'Ago', 'Sep', 'Oct', 'Nov', 'Dic']

bars = axes[0, 1].bar(range(1, 13), ventas_mensuales, color='#28B463', alpha=0.8, edgecolor='black', linewidth=0.5)
axes[0, 1].set_title('Ventas por Mes (Miles $)', fontweight='bold')
axes[0, 1].set_xlabel('Mes')
axes[0, 1].set_ylabel('Ventas (Miles $)')
axes[0, 1].set_xticks(range(1, 13))
axes[0, 1].set_xticklabels(meses)
axes[0, 1].grid(True, alpha=0.3, axis='y')

# Agregar valores en las barras
for i, bar in enumerate(bars):
    height = bar.get_height()
    axes[0, 1].text(bar.get_x() + bar.get_width()/2., height + 5,
                   f'{height:.0f}K', ha='center', va='bottom', fontweight='bold')

# 3. Histograma: Distribución de ventas diarias
axes[0, 2].hist(df_ventas['ventas'], bins=30, color='#E74C3C', alpha=0.7, edgecolor='black', linewidth=0.5)
axes[0, 2].set_title('Distribución de Ventas Diarias', fontweight='bold')
axes[0, 2].set_xlabel('Ventas ($)')
axes[0, 2].set_ylabel('Frecuencia')
axes[0, 2].grid(True, alpha=0.3, axis='y')

# Agregar estadísticas
media_ventas = df_ventas['ventas'].mean()
mediana_ventas = df_ventas['ventas'].median()
axes[0, 2].axvline(media_ventas, color='red', linestyle='--', linewidth=2, label=f'Media: ${media_ventas:,.0f}')
axes[0, 2].axvline(mediana_ventas, color='orange', linestyle='--', linewidth=2, label=f'Mediana: ${mediana_ventas:,.0f}')
axes[0, 2].legend()

# 4. Gráfico de barras apiladas: Ventas por categoría
categorias_data = df_ventas[[f'ventas_{cat.lower()}' for cat in categorias]].sum() / 1000
colores_categorias = ['#3498DB', '#E74C3C', '#2ECC71', '#F39C12']

axes[1, 0].bar(categorias, categorias_data, color=colores_categorias, alpha=0.8, edgecolor='black', linewidth=0.5)
axes[1, 0].set_title('Ventas Totales por Categoría', fontweight='bold')
axes[1, 0].set_xlabel('Categoría')
axes[1, 0].set_ylabel('Ventas (Miles $)')
axes[1, 0].grid(True, alpha=0.3, axis='y')
axes[1, 0].tick_params(axis='x', rotation=45)

# Agregar porcentajes
total_categorias = categorias_data.sum()
for i, (cat, valor) in enumerate(zip(categorias, categorias_data)):
    porcentaje = (valor / total_categorias) * 100
    axes[1, 0].text(i, valor + 20, f'{porcentaje:.1f}%', ha='center', va='bottom', fontweight='bold')

# 5. Box plot: Ventas por día de la semana
dias_orden = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday']
dias_espanol = ['Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb', 'Dom']

ventas_por_dia = [df_ventas[df_ventas['dia_semana'] == dia]['ventas'] for dia in dias_orden]

box_plot = axes[1, 1].boxplot(ventas_por_dia, labels=dias_espanol, patch_artist=True)
axes[1, 1].set_title('Distribución de Ventas por Día de la Semana', fontweight='bold')
axes[1, 1].set_xlabel('Día de la Semana')
axes[1, 1].set_ylabel('Ventas ($)')
axes[1, 1].grid(True, alpha=0.3, axis='y')
axes[1, 1].tick_params(axis='x', rotation=45)

# Colorear las cajas
colores_dias = ['#3498DB', '#E74C3C', '#2ECC71', '#F39C12', '#9B59B6', '#1ABC9C', '#E67E22']
for patch, color in zip(box_plot['boxes'], colores_dias):
    patch.set_facecolor(color)
    patch.set_alpha(0.7)

# 6. Gráfico combinado: Ventas y tendencia trimestral
ventas_trimestrales = df_ventas.groupby('trimestre')['ventas'].agg(['sum', 'mean']) / 1000
trimestres = ['Q1', 'Q2', 'Q3', 'Q4']

ax2 = axes[1, 2].twinx()

# Barras para ventas totales
bars = axes[1, 2].bar(trimestres, ventas_trimestrales['sum'], color='#3498DB', alpha=0.7, label='Total (Miles $)')
axes[1, 2].set_title('Análisis Trimestral: Total vs Promedio', fontweight='bold')
axes[1, 2].set_xlabel('Trimestre')
axes[1, 2].set_ylabel('Ventas Totales (Miles $)', color='#3498DB')
axes[1, 2].tick_params(axis='y', labelcolor='#3498DB')

# Línea para promedio
line = ax2.plot(trimestres, ventas_trimestrales['mean'], color='#E74C3C', marker='o', linewidth=3, markersize=8, label='Promedio (Miles $)')
ax2.set_ylabel('Ventas Promedio (Miles $)', color='#E74C3C')
ax2.tick_params(axis='y', labelcolor='#E74C3C')

# Agregar leyenda combinada
lines1, labels1 = axes[1, 2].get_legend_handles_labels()
lines2, labels2 = ax2.get_legend_handles_labels()
axes[1, 2].legend(lines1 + lines2, labels1 + labels2, loc='upper left')

plt.tight_layout()
plt.show()

# Resumen estadístico
print(f"\nRESUMEN EJECUTIVO:")
print(f"Ventas totales 2023: ${df_ventas['ventas'].sum():,.2f}")
print(f"Promedio diario: ${df_ventas['ventas'].mean():,.2f}")
print(f"Mejor día: ${df_ventas['ventas'].max():,.2f} ({df_ventas.loc[df_ventas['ventas'].idxmax(), 'fecha'].strftime('%d-%m-%Y')})")
print(f"Mejor mes: {meses[ventas_mensuales.idxmax()-1]} (${ventas_mensuales.max()*1000:,.2f})")
print(f"Crecimiento anual: {((ventas_diarias[-30:].mean() - ventas_diarias[:30].mean()) / ventas_diarias[:30].mean() * 100):.1f}%")
```

### Ejercicio 2: Análisis de rendimiento de empleados
```python
# Crear datos de rendimiento de empleados
np.random.seed(123)

empleados = {
    'nombre': [f'Empleado_{i:02d}' for i in range(1, 31)],
    'departamento': np.random.choice(['Ventas', 'Marketing', 'IT', 'RRHH', 'Finanzas'], 30),
    'antiguedad': np.random.randint(1, 15, 30),
    'ventas_realizadas': np.random.randint(50, 500, 30),
    'satisfaccion_cliente': np.random.uniform(3.0, 5.0, 30),
    'proyectos_completados': np.random.randint(5, 50, 30),
    'horas_capacitacion': np.random.randint(10, 100, 30),
    'salario': np.random.uniform(35000, 85000, 30)
}

df_empleados = pd.DataFrame(empleados)

# Calcular métricas derivadas
df_empleados['productividad'] = (df_empleados['ventas_realizadas'] * 0.3 + 
                                df_empleados['proyectos_completados'] * 0.4 + 
                                df_empleados['satisfaccion_cliente'] * 20) / 100

df_empleados['ratio_capacitacion'] = df_empleados['horas_capacitacion'] / df_empleados['antiguedad']

print("=== ANÁLISIS DE RENDIMIENTO DE EMPLEADOS ===")

# Crear visualizaciones de análisis de RRHH
fig, axes = plt.subplots(2, 2, figsize=(16, 12))
fig.suptitle('Dashboard de Análisis de Recursos Humanos', fontsize=16, fontweight='bold')

# 1. Scatter plot: Salario vs Productividad por Departamento
departamentos = df_empleados['departamento'].unique()
colores_dept = plt.cm.Set3(np.linspace(0, 1, len(departamentos)))

for dept, color in zip(departamentos, colores_dept):
    dept_data = df_empleados[df_empleados['departamento'] == dept]
    axes[0, 0].scatter(dept_data['productividad'], dept_data['salario'], 
                      c=[color], label=dept, alpha=0.7, s=100, edgecolors='black', linewidth=0.5)

axes[0, 0].set_title('Salario vs Productividad por Departamento', fontweight='bold')
axes[0, 0].set_xlabel('Índice de Productividad')
axes[0, 0].set_ylabel('Salario ($)')
axes[0, 0].legend(bbox_to_anchor=(1.05, 1), loc='upper left')
axes[0, 0].grid(True, alpha=0.3)

# Línea de tendencia
z = np.polyfit(df_empleados['productividad'], df_empleados['salario'], 1)
p = np.poly1d(z)
x_trend = np.linspace(df_empleados['productividad'].min(), df_empleados['productividad'].max(), 100)
axes[0, 0].plot(x_trend, p(x_trend), '--', color='red', linewidth=2, alpha=0.8, label='Tendencia')

# 2. Gráfico de barras horizontales: Promedio de satisfacción por departamento
satisfaccion_dept = df_empleados.groupby('departamento')['satisfaccion_cliente'].mean().sort_values(ascending=True)

bars = axes[0, 1].barh(range(len(satisfaccion_dept)), satisfaccion_dept.values, 
                      color='#2ECC71', alpha=0.8, edgecolor='black', linewidth=0.5)
axes[0, 1].set_title('Satisfacción Promedio del Cliente por Departamento', fontweight='bold')
axes[0, 1].set_xlabel('Satisfacción del Cliente (1-5)')
axes[0, 1].set_ylabel('Departamento')
axes[0, 1].set_yticks(range(len(satisfaccion_dept)))
axes[0, 1].set_yticklabels(satisfaccion_dept.index)
axes[0, 1].grid(True, alpha=0.3, axis='x')

# Agregar valores en las barras
for i, (bar, valor) in enumerate(zip(bars, satisfaccion_dept.values)):
    axes[0, 1].text(valor + 0.05, bar.get_y() + bar.get_height()/2, 
                   f'{valor:.2f}', va='center', fontweight='bold')

# 3. Histograma con curva: Distribución de antigüedad
axes[1, 0].hist(df_empleados['antiguedad'], bins=10, density=True, alpha=0.7, 
               color='#3498DB', edgecolor='black', linewidth=0.5, label='Histograma')

# Agregar curva de densidad
from scipy import stats
kde = stats.gaussian_kde(df_empleados['antiguedad'])
x_kde = np.linspace(df_empleados['antiguedad'].min(), df_empleados['antiguedad'].max(), 100)
axes[1, 0].plot(x_kde, kde(x_kde), color='red', linewidth=3, label='Densidad')

axes[1, 0].set_title('Distribución de Antigüedad de Empleados', fontweight='bold')
axes[1, 0].set_xlabel('Años de Antigüedad')
axes[1, 0].set_ylabel('Densidad')
axes[1, 0].legend()
axes[1, 0].grid(True, alpha=0.3)

# Agregar estadísticas
media_ant = df_empleados['antiguedad'].mean()
mediana_ant = df_empleados['antiguedad'].median()
axes[1, 0].axvline(media_ant, color='orange', linestyle='--', linewidth=2, 
                  label=f'Media: {media_ant:.1f} años')
axes[1, 0].axvline(mediana_ant, color='purple', linestyle='--', linewidth=2, 
                  label=f'Mediana: {mediana_ant:.1f} años')

# 4. Gráfico de burbujas: Relación múltiple
axes[1, 1].scatter(df_empleados['horas_capacitacion'], df_empleados['productividad'],
                  s=df_empleados['antiguedad']*20, c=df_empleados['salario'], 
                  alpha=0.6, cmap='viridis', edgecolors='black', linewidth=0.5)

axes[1, 1].set_title('Capacitación vs Productividad\n(Tamaño=Antigüedad, Color=Salario)', fontweight='bold')
axes[1, 1].set_xlabel('Horas de Capacitación')
axes[1, 1].set_ylabel('Índice de Productividad')
axes[1, 1].grid(True, alpha=0.3)

# Agregar colorbar
cbar = plt.colorbar(axes[1, 1].collections[0], ax=axes[1, 1])
cbar.set_label('Salario ($)', rotation=270, labelpad=15)

plt.tight_layout()
plt.show()

# Análisis de correlaciones
print(f"\n--- MATRIZ DE CORRELACIONES ---")
columnas_numericas = ['antiguedad', 'ventas_realizadas', 'satisfaccion_cliente', 
                     'proyectos_completados', 'horas_capacitacion', 'salario', 'productividad']
correlaciones = df_empleados[columnas_numericas].corr()

# Crear heatmap de correlaciones
plt.figure(figsize=(10, 8))
mask = np.triu(np.ones_like(correlaciones, dtype=bool))
heatmap = plt.imshow(correlaciones.values, cmap='RdBu_r', aspect='auto', vmin=-1, vmax=1)
plt.colorbar(heatmap, label='Correlación')

# Personalizar ejes
plt.xticks(range(len(columnas_numericas)), [col.replace('_', ' ').title() for col in columnas_numericas], rotation=45)
plt.yticks(range(len(columnas_numericas)), [col.replace('_', ' ').title() for col in columnas_numericas])

# Agregar valores en las celdas
for i in range(len(columnas_numericas)):
    for j in range(len(columnas_numericas)):
        if not mask[i, j]:
            plt.text(j, i, f'{correlaciones.iloc[i, j]:.2f}', 
                    ha='center', va='center', 
                    color='white' if abs(correlaciones.iloc[i, j]) > 0.5 else 'black',
                    fontweight='bold')

plt.title('Matriz de Correlaciones - Variables de RRHH', fontsize=14, fontweight='bold', pad=20)
plt.tight_layout()
plt.show()

# Top insights
print(f"\nTOP INSIGHTS:")
top_performer = df_empleados.loc[df_empleados['productividad'].idxmax()]
print(f"Empleado más productivo: {top_performer['nombre']} ({top_performer['departamento']}) - Productividad: {top_performer['productividad']:.2f}")

mejor_dept = df_empleados.groupby('departamento')['productividad'].mean().idxmax()
print(f"Departamento más productivo: {mejor_dept}")

correlacion_fuerte = correlaciones.abs().unstack().sort_values(ascending=False).drop_duplicates()
correlacion_fuerte = correlacion_fuerte[correlacion_fuerte < 1.0].head(3)
print(f"Correlaciones más fuertes: {list(correlacion_fuerte.index)}")
```

### Ejercicio 3: Análisis financiero y tendencias de mercado
```python
# Simular datos financieros de múltiples activos
np.random.seed(789)
fechas_financieras = pd.date_range('2023-01-01', periods=252, freq='B')  # Días bursátiles

# Simular precios de 4 activos con diferentes características
activos = ['TECH_STOCK', 'BANK_STOCK', 'ENERGY_STOCK', 'BOND_ETF']
precios_iniciales = [100, 50, 75, 25]

datos_financieros = {}
for i, activo in enumerate(activos):
    # Diferentes volatilidades y tendencias
    if 'TECH' in activo:
        rendimientos = np.random.normal(0.0008, 0.025, len(fechas_financieras))  # Alta volatilidad
    elif 'BANK' in activo:
        rendimientos = np.random.normal(0.0004, 0.020, len(fechas_financieras))  # Moderada volatilidad
    elif 'ENERGY' in activo:
        rendimientos = np.random.normal(0.0006, 0.030, len(fechas_financieras))  # Muy alta volatilidad
    else:  # BOND
        rendimientos = np.random.normal(0.0002, 0.008, len(fechas_financieras))  # Baja volatilidad
    
    # Calcular precios acumulativos
    precios = [precios_iniciales[i]]
    for rendimiento in rendimientos:
        precios.append(precios[-1] * (1 + rendimiento))
    
    datos_financieros[activo] = precios[1:]  # Excluir precio inicial duplicado

df_financiero = pd.DataFrame(datos_financieros, index=fechas_financieras)
df_financiero['PORTFOLIO'] = df_financiero.mean(axis=1)  # Portfolio balanceado

print("=== ANÁLISIS FINANCIERO Y TENDENCIAS DE MERCADO ===")

# Dashboard financiero
fig, axes = plt.subplots(2, 2, figsize=(16, 12))
fig.suptitle('Dashboard de Análisis Financiero', fontsize=16, fontweight='bold')

# 1. Gráfico de líneas múltiples: Evolución de precios normalizados
df_normalizado = df_financiero / df_financiero.iloc[0] * 100

colores_activos = ['#E74C3C', '#3498DB', '#2ECC71', '#F39C12', '#9B59B6']
for i, activo in enumerate(df_financiero.columns):
    axes[0, 0].plot(df_normalizado.index, df_normalizado[activo], 
                   linewidth=2, label=activo.replace('_', ' '), color=colores_activos[i])

axes[0, 0].set_title('Evolución de Precios (Base 100)', fontweight='bold')
axes[0, 0].set_xlabel('Fecha')
axes[0, 0].set_ylabel('Precio Normalizado')
axes[0, 0].legend()
axes[0, 0].grid(True, alpha=0.3)
axes[0, 0].tick_params(axis='x', rotation=45)

# 2. Gráfico de barras: Rendimientos anualizados y volatilidad
rendimientos_anuales = ((df_financiero.iloc[-1] / df_financiero.iloc[0]) ** (252/len(df_financiero)) - 1) * 100
volatilidad_anual = df_financiero.pct_change().std() * np.sqrt(252) * 100

x_pos = np.arange(len(activos))
width = 0.35

bars1 = axes[0, 1].bar(x_pos - width/2, rendimientos_anuales[activos], width, 
                      label='Rendimiento (%)', color='#2ECC71', alpha=0.8)
bars2 = axes[0, 1].bar(x_pos + width/2, volatilidad_anual[activos], width, 
                      label='Volatilidad (%)', color='#E74C3C', alpha=0.8)

axes[0, 1].set_title('Rendimiento vs Riesgo (Anualizado)', fontweight='bold')
axes[0, 1].set_xlabel('Activos')
axes[0, 1].set_ylabel('Porcentaje (%)')
axes[0, 1].set_xticks(x_pos)
axes[0, 1].set_xticklabels([a.replace('_', '\n') for a in activos])
axes[0, 1].legend()
axes[0, 1].grid(True, alpha=0.3, axis='y')

# Agregar valores en las barras
for bars in [bars1, bars2]:
    for bar in bars:
        height = bar.get_height()
        axes[0, 1].text(bar.get_x() + bar.get_width()/2., height + 0.5,
                       f'{height:.1f}%', ha='center', va='bottom', fontsize=8, fontweight='bold')

# 3. Scatter plot: Riesgo vs Rendimiento
axes[1, 0].scatter(volatilidad_anual[activos], rendimientos_anuales[activos], 
                  s=200, alpha=0.7, c=colores_activos[:len(activos)], edgecolors='black', linewidth=2)

for i, activo in enumerate(activos):
    axes[1, 0].annotate(activo.replace('_', '\n'), 
                       (volatilidad_anual[activo], rendimientos_anuales[activo]),
                       xytext=(10, 10), textcoords='offset points', fontsize=9, fontweight='bold')

axes[1, 0].set_title('Frontera Eficiente Simplificada', fontweight='bold')
axes[1, 0].set_xlabel('Riesgo (Volatilidad %)')
axes[1, 0].set_ylabel('Rendimiento Esperado (%)')
axes[1, 0].grid(True, alpha=0.3)

# Agregar líneas de referencia
axes[1, 0].axhline(y=0, color='gray', linestyle='--', alpha=0.5)
axes[1, 0].axvline(x=volatilidad_anual.mean(), color='orange', linestyle='--', alpha=0.7, label='Vol. Promedio')

# 4. Distribución de rendimientos diarios
rendimientos_diarios = df_financiero.pct_change().dropna()

# Crear histograma para cada activo
for i, activo in enumerate(activos):
    axes[1, 1].hist(rendimientos_diarios[activo] * 100, bins=30, alpha=0.5, 
                   label=activo.replace('_', ' '), color=colores_activos[i], density=True)

axes[1, 1].set_title('Distribución de Rendimientos Diarios', fontweight='bold')
axes[1, 1].set_xlabel('Rendimiento Diario (%)')
axes[1, 1].set_ylabel('Densidad')
axes[1, 1].legend()
axes[1, 1].grid(True, alpha=0.3)

# Agregar línea de rendimiento cero
axes[1, 1].axvline(x=0, color='red', linestyle='--', linewidth=2, alpha=0.7, label='Rendimiento = 0%')

plt.tight_layout()
plt.show()

# Análisis de correlaciones financieras
plt.figure(figsize=(12, 8))

# Crear matriz de correlación
correlacion_activos = df_financiero[activos].corr()

# Crear heatmap más sofisticado
mask = np.triu(np.ones_like(correlacion_activos))
heatmap = plt.imshow(correlacion_activos, cmap='RdYlBu_r', aspect='auto', vmin=-1, vmax=1)

# Personalización
plt.colorbar(heatmap, label='Correlación', shrink=0.8)
plt.xticks(range(len(activos)), [a.replace('_', '\n') for a in activos])
plt.yticks(range(len(activos)), [a.replace('_', '\n') for a in activos])

# Agregar valores y círculos proporcionales
for i in range(len(activos)):
    for j in range(len(activos)):
        corr_val = correlacion_activos.iloc[i, j]
        
        # Círculo proporcional a la correlación
        circle = plt.Circle((j, i), abs(corr_val)*0.4, 
                          color='white', alpha=0.8, zorder=10)
        plt.gca().add_patch(circle)
        
        # Texto con valor
        plt.text(j, i, f'{corr_val:.2f}', ha='center', va='center', 
                fontweight='bold', fontsize=10, zorder=11,
                color='black' if abs(corr_val) < 0.7 else 'white')

plt.title('Matriz de Correlaciones - Activos Financieros\n(Tamaño del círculo = |Correlación|)', 
          fontsize=14, fontweight='bold', pad=20)
plt.tight_layout()
plt.show()

# Reporte de análisis financiero
print(f"\n--- REPORTE DE ANÁLISIS FINANCIERO ---")
print(f"Período de análisis: {fechas_financieras[0].strftime('%Y-%m-%d')} a {fechas_financieras[-1].strftime('%Y-%m-%d')}")
print(f"Días de trading analizados: {len(fechas_financieras)}")

print(f"\nRENDIMIENTOS ANUALIZADOS:")
for activo in activos:
    print(f"  {activo}: {rendimientos_anuales[activo]:+.2f}% (Vol: {volatilidad_anual[activo]:.2f}%)")

mejor_activo = rendimientos_anuales[activos].idxmax()
peor_activo = rendimientos_anuales[activos].idxmin()
print(f"\nMejor activo: {mejor_activo} ({rendimientos_anuales[mejor_activo]:+.2f}%)")
print(f"Peor activo: {peor_activo} ({rendimientos_anuales[peor_activo]:+.2f}%)")

# Calcular Sharpe ratio simplificado (asumiendo tasa libre de riesgo = 2%)
tasa_libre_riesgo = 2.0
sharpe_ratios = (rendimientos_anuales[activos] - tasa_libre_riesgo) / volatilidad_anual[activos]
mejor_sharpe = sharpe_ratios.idxmax()
print(f"\nMejor ratio de Sharpe: {mejor_sharpe} ({sharpe_ratios[mejor_sharpe]:.3f})")

# Portfolio performance
portfolio_return = rendimientos_anuales['PORTFOLIO']
portfolio_vol = volatilidad_anual['PORTFOLIO']
portfolio_sharpe = (portfolio_return - tasa_libre_riesgo) / portfolio_vol
print(f"\nPortfolio balanceado:")
print(f"  Rendimiento: {portfolio_return:+.2f}%")
print(f"  Volatilidad: {portfolio_vol:.2f}%")
print(f"  Ratio Sharpe: {portfolio_sharpe:.3f}")
```

## Notas

### Principios de visualización efectiva:
- **Claridad**: El mensaje debe ser inmediatamente comprensible
- **Precisión**: Los datos deben representarse fielmente sin distorsiones
- **Eficiencia**: Maximizar la información comunicada con elementos mínimos
- **Estética**: Diseño visual atractivo que invite al análisis
- **Accesibilidad**: Colores y formatos que sean inclusivos

### Tipos de gráficos y cuándo usarlos:
- **Líneas**: Series temporales, tendencias continuas
- **Barras**: Comparaciones categóricas, rankings
- **Histogramas**: Distribuciones de frecuencia
- **Scatter**: Relaciones entre variables continuas
- **Box plots**: Distribuciones con outliers y cuartiles
- **Heatmaps**: Matrices de correlación, datos multidimensionales

### Personalización avanzada:
- **Colores**: Usar paletas apropiadas (secuenciales, divergentes, categóricas)
- **Tipografía**: Tamaños y pesos que jerarquicen información
- **Espaciado**: Márgenes y padding que mejoren legibilidad
- **Elementos gráficos**: Líneas de referencia, anotaciones, leyendas
- **Estilos**: Temas consistentes para reportes profesionales

### Mejores prácticas:
- Siempre incluir títulos descriptivos y etiquetas en ejes
- Usar escalas apropiadas que no distorsionen los datos
- Elegir tipos de gráficos según la naturaleza de los datos
- Mantener consistencia visual en dashboards
- Verificar legibilidad en diferentes tamaños y formatos

### Errores comunes:
- Usar gráficos 3D innecesarios que distorsionan percepción
- Escalas truncadas que exageran diferencias
- Demasiados colores que confunden en lugar de clarificar
- Falta de contexto o referencias para interpretar valores
- Gráficos sobrecargados con demasiada información

### Exportación y formatos:
```python
# Para publicaciones
plt.savefig('grafico.pdf', dpi=300, bbox_inches='tight')
# Para web
plt.savefig('grafico.png', dpi=150, bbox_inches='tight')
# Para presentaciones
plt.savefig('grafico.svg', format='svg', bbox_inches='tight')
```

### Recursos adicionales:
- Documentación de Matplotlib: https://matplotlib.org/stable/contents.html
- Gallery de ejemplos: https://matplotlib.org/stable/gallery/index.html
- Seaborn para gráficos estadísticos: https://seaborn.pydata.org/
- Plotly para interactividad: https://plotly.com/python/

### Criterios de evaluación:
- [ ] Gráficos apropiados para el tipo de datos presentados
- [ ] Personalización profesional (títulos, etiquetas, colores)
- [ ] Interpretación correcta de patrones y tendencias
- [ ] Dashboards integrados con múltiples visualizaciones
- [ ] Código limpio y reutilizable
- [ ] Insights empresariales derivados de las visualizaciones
