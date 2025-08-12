# Práctica 4: Análisis básico de datos con Pandas

## Objetivo
Dominar las operaciones fundamentales de Pandas para la manipulación y análisis de datos estructurados, incluyendo carga, limpieza, transformación y análisis exploratorio básico de datasets empresariales.

## Competencias
- Crear y manipular DataFrames y Series de Pandas eficientemente
- Cargar datos desde diferentes formatos (CSV, Excel, JSON) y fuentes
- Realizar operaciones de filtrado, selección y transformación de datos
- Aplicar funciones de agrupación y agregación para análisis segmentado
- Manejar valores faltantes y duplicados de manera apropiada
- Generar estadísticas descriptivas y análisis exploratorio básico
- Combinar y fusionar DataFrames para análisis integrado

## Introducción
Pandas es la biblioteca más importante para análisis de datos en Python, especialmente para datos estructurados y tabulares. Construida sobre NumPy, ofrece estructuras de datos flexibles y herramientas de análisis que son intuitivas y potentes. Su capacidad para manejar datos heterogéneos, series temporales y operaciones complejas la convierte en la herramienta estándar para científicos de datos y analistas.

En el contexto empresarial, Pandas es fundamental para procesar datos de ventas, inventarios, clientes, finanzas y operaciones. Esta práctica simula escenarios reales donde necesitamos extraer insights accionables de datos empresariales complejos.

## Instrucciones

### Parte 1: Estructuras básicas de Pandas
1. Crear Series y DataFrames desde diferentes fuentes
2. Explorar propiedades básicas (shape, dtypes, info, describe)
3. Indexing y selección de datos
4. Operaciones básicas con DataFrames

### Parte 2: Carga y exploración de datos
1. Leer datos desde archivos CSV y Excel
2. Inspeccionar la calidad de los datos
3. Identificar patrones y anomalías iniciales
4. Configurar índices apropiados

### Parte 3: Limpieza y transformación
1. Manejar valores faltantes y duplicados
2. Cambiar tipos de datos cuando sea necesario
3. Crear nuevas columnas derivadas
4. Filtrar y seleccionar subconjuntos relevantes

### Parte 4: Análisis y agregaciones
1. Aplicar funciones de agrupación (groupby)
2. Realizar agregaciones estadísticas
3. Crear tablas pivot para análisis cruzado
4. Generar resúmenes ejecutivos

## Ejercicio

### Ejercicio 1: Análisis de datos de ventas empresariales
```python
import pandas as pd
import numpy as np
from datetime import datetime, timedelta

# Crear dataset sintético de ventas empresariales
np.random.seed(42)

# Configuración del dataset
fecha_inicio = datetime(2023, 1, 1)
n_registros = 1000

# Generar datos sintéticos
datos_ventas = {
    'fecha': [fecha_inicio + timedelta(days=np.random.randint(0, 365)) for _ in range(n_registros)],
    'vendedor': np.random.choice(['Ana García', 'Carlos López', 'María Rodríguez', 'Juan Martínez', 'Laura Sánchez'], n_registros),
    'region': np.random.choice(['Norte', 'Sur', 'Este', 'Oeste', 'Centro'], n_registros),
    'producto': np.random.choice(['Laptop', 'Desktop', 'Monitor', 'Teclado', 'Mouse', 'Impresora'], n_registros),
    'categoria': np.random.choice(['Hardware', 'Accesorios', 'Periféricos'], n_registros),
    'cantidad': np.random.randint(1, 20, n_registros),
    'precio_unitario': np.random.uniform(50, 2000, n_registros),
    'descuento_pct': np.random.choice([0, 5, 10, 15, 20], n_registros),
    'metodo_pago': np.random.choice(['Efectivo', 'Tarjeta', 'Transferencia', 'Crédito'], n_registros),
    'cliente_id': np.random.randint(1000, 5000, n_registros)
}

# Crear DataFrame
df_ventas = pd.DataFrame(datos_ventas)

# Crear columnas calculadas
df_ventas['venta_bruta'] = df_ventas['cantidad'] * df_ventas['precio_unitario']
df_ventas['descuento_monto'] = df_ventas['venta_bruta'] * df_ventas['descuento_pct'] / 100
df_ventas['venta_neta'] = df_ventas['venta_bruta'] - df_ventas['descuento_monto']
df_ventas['mes'] = df_ventas['fecha'].dt.month
df_ventas['trimestre'] = df_ventas['fecha'].dt.quarter

# Agregar algunos valores faltantes para práctica de limpieza
indices_nan = np.random.choice(df_ventas.index, size=50, replace=False)
df_ventas.loc[indices_nan[:25], 'descuento_pct'] = np.nan
df_ventas.loc[indices_nan[25:], 'metodo_pago'] = np.nan

print("=== ANÁLISIS DE DATOS DE VENTAS EMPRESARIALES ===")
print(f"Dataset creado con {len(df_ventas)} registros de ventas")

# 1. Exploración inicial del dataset
print(f"\n--- INFORMACIÓN GENERAL DEL DATASET ---")
print(f"Forma del dataset: {df_ventas.shape}")
print(f"Período de datos: {df_ventas['fecha'].min().strftime('%Y-%m-%d')} a {df_ventas['fecha'].max().strftime('%Y-%m-%d')}")
print(f"\nTipos de datos:")
print(df_ventas.dtypes)

print(f"\nInformación de valores faltantes:")
valores_faltantes = df_ventas.isnull().sum()
print(valores_faltantes[valores_faltantes > 0])

# 2. Estadísticas descriptivas
print(f"\n--- ESTADÍSTICAS DESCRIPTIVAS ---")
stats_numericas = df_ventas.describe()
print("Variables numéricas:")
print(stats_numericas.round(2))

print(f"\nDistribución de variables categóricas:")
categoricas = ['vendedor', 'region', 'producto', 'categoria', 'metodo_pago']
for col in categoricas:
    if col in df_ventas.columns:
        print(f"\n{col}:")
        print(df_ventas[col].value_counts())

# 3. Limpieza de datos
print(f"\n--- LIMPIEZA DE DATOS ---")

# Manejar valores faltantes en descuento (rellenar con 0)
df_ventas['descuento_pct'].fillna(0, inplace=True)
print("✓ Valores faltantes en descuento_pct rellenados con 0")

# Manejar valores faltantes en método de pago (rellenar con moda)
moda_pago = df_ventas['metodo_pago'].mode()[0]
df_ventas['metodo_pago'].fillna(moda_pago, inplace=True)
print(f"✓ Valores faltantes en metodo_pago rellenados con '{moda_pago}'")

# Verificar duplicados
duplicados = df_ventas.duplicated().sum()
print(f"✓ Registros duplicados encontrados: {duplicados}")

# Verificar datos inconsistentes
inconsistencias = df_ventas[(df_ventas['cantidad'] <= 0) | (df_ventas['precio_unitario'] <= 0)]
print(f"✓ Registros con valores inconsistentes: {len(inconsistencias)}")

print(f"Dataset limpio: {df_ventas.shape[0]} registros, {df_ventas.isnull().sum().sum()} valores faltantes")

# 4. Análisis de ventas por vendedor
print(f"\n--- ANÁLISIS POR VENDEDOR ---")
analisis_vendedor = df_ventas.groupby('vendedor').agg({
    'venta_neta': ['sum', 'mean', 'count'],
    'cantidad': 'sum',
    'cliente_id': 'nunique'
}).round(2)

# Aplanar nombres de columnas
analisis_vendedor.columns = ['Ventas_Total', 'Venta_Promedio', 'Num_Transacciones', 'Cantidad_Vendida', 'Clientes_Unicos']
analisis_vendedor = analisis_vendedor.sort_values('Ventas_Total', ascending=False)

print(analisis_vendedor)

# Identificar el mejor vendedor
mejor_vendedor = analisis_vendedor.index[0]
print(f"\nMejor vendedor: {mejor_vendedor}")
print(f"Ventas totales: ${analisis_vendedor.loc[mejor_vendedor, 'Ventas_Total']:,.2f}")
print(f"Clientes únicos atendidos: {analisis_vendedor.loc[mejor_vendedor, 'Clientes_Unicos']}")

# 5. Análisis temporal de ventas
print(f"\n--- ANÁLISIS TEMPORAL ---")

# Ventas por mes
ventas_mensuales = df_ventas.groupby('mes')['venta_neta'].agg(['sum', 'count', 'mean']).round(2)
ventas_mensuales.columns = ['Total_Ventas', 'Num_Transacciones', 'Venta_Promedio']

print("Ventas por mes:")
print(ventas_mensuales)

# Identificar tendencias
mes_mejor = ventas_mensuales['Total_Ventas'].idxmax()
mes_peor = ventas_mensuales['Total_Ventas'].idxmin()
print(f"\nMejor mes: {mes_mejor} (${ventas_mensuales.loc[mes_mejor, 'Total_Ventas']:,.2f})")
print(f"Peor mes: {mes_peor} (${ventas_mensuales.loc[mes_peor, 'Total_Ventas']:,.2f})")

# Ventas por trimestre
ventas_trimestrales = df_ventas.groupby('trimestre')['venta_neta'].sum().round(2)
print(f"\nVentas por trimestre:")
for trim in ventas_trimestrales.index:
    print(f"Q{trim}: ${ventas_trimestrales[trim]:,.2f}")

# 6. Análisis de productos y regiones
print(f"\n--- ANÁLISIS POR PRODUCTO Y REGIÓN ---")

# Top productos por ventas
top_productos = df_ventas.groupby('producto')['venta_neta'].sum().sort_values(ascending=False)
print("Top productos por ventas totales:")
for producto, ventas in top_productos.items():
    print(f"  {producto}: ${ventas:,.2f}")

# Análisis cruzado: Región vs Producto (tabla pivot)
pivot_region_producto = df_ventas.pivot_table(
    values='venta_neta', 
    index='region', 
    columns='producto', 
    aggfunc='sum', 
    fill_value=0
).round(2)

print(f"\nVentas por Región y Producto:")
print(pivot_region_producto)

# Región con mejor rendimiento
mejor_region = df_ventas.groupby('region')['venta_neta'].sum().sort_values(ascending=False)
print(f"\nRanking de regiones:")
for i, (region, ventas) in enumerate(mejor_region.items(), 1):
    print(f"  {i}. {region}: ${ventas:,.2f}")
```

### Ejercicio 2: Análisis de inventario y stock
```python
# Crear dataset de inventario
np.random.seed(123)

productos_inventario = {
    'codigo_producto': [f'PROD_{i:04d}' for i in range(1, 201)],
    'nombre_producto': [f'Producto_{i}' for i in range(1, 201)],
    'categoria': np.random.choice(['Electrónicos', 'Ropa', 'Hogar', 'Deportes', 'Libros'], 200),
    'precio_compra': np.random.uniform(10, 500, 200),
    'precio_venta': np.random.uniform(15, 750, 200),
    'stock_actual': np.random.randint(0, 1000, 200),
    'stock_minimo': np.random.randint(10, 100, 200),
    'proveedor': np.random.choice(['Proveedor_A', 'Proveedor_B', 'Proveedor_C', 'Proveedor_D'], 200),
    'fecha_ultima_compra': [fecha_inicio - timedelta(days=np.random.randint(0, 180)) for _ in range(200)],
    'unidades_vendidas_mes': np.random.randint(0, 200, 200)
}

df_inventario = pd.DataFrame(productos_inventario)

# Calcular columnas derivadas
df_inventario['margen_unitario'] = df_inventario['precio_venta'] - df_inventario['precio_compra']
df_inventario['margen_porcentual'] = (df_inventario['margen_unitario'] / df_inventario['precio_compra']) * 100
df_inventario['valor_inventario'] = df_inventario['stock_actual'] * df_inventario['precio_compra']
df_inventario['stock_critico'] = df_inventario['stock_actual'] < df_inventario['stock_minimo']
df_inventario['dias_sin_compra'] = (datetime.now() - df_inventario['fecha_ultima_compra']).dt.days
df_inventario['rotacion_estimada'] = df_inventario['unidades_vendidas_mes'] * 12 / (df_inventario['stock_actual'] + 1)

print("=== ANÁLISIS DE INVENTARIO Y STOCK ===")
print(f"Dataset de inventario: {len(df_inventario)} productos")

# 1. Resumen general del inventario
print(f"\n--- RESUMEN GENERAL DEL INVENTARIO ---")
valor_total_inventario = df_inventario['valor_inventario'].sum()
print(f"Valor total del inventario: ${valor_total_inventario:,.2f}")
print(f"Número de productos únicos: {len(df_inventario)}")
print(f"Categorías de productos: {df_inventario['categoria'].nunique()}")

# Distribución por categoría
print(f"\nDistribución de inventario por categoría:")
inventario_categoria = df_inventario.groupby('categoria').agg({
    'valor_inventario': 'sum',
    'stock_actual': 'sum',
    'codigo_producto': 'count'
}).round(2)
inventario_categoria.columns = ['Valor_Total', 'Stock_Total', 'Num_Productos']
inventario_categoria['Porcentaje_Valor'] = (inventario_categoria['Valor_Total'] / valor_total_inventario * 100).round(2)

print(inventario_categoria.sort_values('Valor_Total', ascending=False))

# 2. Análisis de stock crítico
print(f"\n--- ANÁLISIS DE STOCK CRÍTICO ---")
productos_criticos = df_inventario[df_inventario['stock_critico']]
print(f"Productos con stock crítico: {len(productos_criticos)} de {len(df_inventario)} ({len(productos_criticos)/len(df_inventario)*100:.1f}%)")

if len(productos_criticos) > 0:
    print(f"\nTop 10 productos con stock más crítico:")
    productos_urgentes = productos_criticos.nsmallest(10, 'stock_actual')[
        ['codigo_producto', 'nombre_producto', 'categoria', 'stock_actual', 'stock_minimo', 'proveedor']
    ]
    print(productos_urgentes.to_string(index=False))
    
    # Valor en riesgo por stock crítico
    valor_riesgo = productos_criticos['valor_inventario'].sum()
    print(f"\nValor en riesgo por stock crítico: ${valor_riesgo:,.2f} ({valor_riesgo/valor_total_inventario*100:.1f}% del inventario total)")

# 3. Análisis de rentabilidad
print(f"\n--- ANÁLISIS DE RENTABILIDAD ---")
stats_margen = df_inventario['margen_porcentual'].describe()
print("Estadísticas de margen porcentual:")
print(stats_margen.round(2))

# Top productos por margen
top_margen = df_inventario.nlargest(10, 'margen_porcentual')[
    ['codigo_producto', 'nombre_producto', 'categoria', 'precio_compra', 'precio_venta', 'margen_porcentual']
]
print(f"\nTop 10 productos por margen porcentual:")
print(top_margen.round(2).to_string(index=False))

# Análisis de margen por categoría
margen_categoria = df_inventario.groupby('categoria').agg({
    'margen_porcentual': ['mean', 'median'],
    'margen_unitario': 'mean',
    'valor_inventario': 'sum'
}).round(2)
margen_categoria.columns = ['Margen_Prom', 'Margen_Mediano', 'Margen_Unit_Prom', 'Valor_Inventario']

print(f"\nAnálisis de margen por categoría:")
print(margen_categoria.sort_values('Margen_Prom', ascending=False))

# 4. Análisis de rotación de inventario
print(f"\n--- ANÁLISIS DE ROTACIÓN DE INVENTARIO ---")

# Productos de alta rotación (> 6 veces por año)
alta_rotacion = df_inventario[df_inventario['rotacion_estimada'] > 6]
print(f"Productos de alta rotación: {len(alta_rotacion)} ({len(alta_rotacion)/len(df_inventario)*100:.1f}%)")

# Productos de baja rotación (< 2 veces por año)
baja_rotacion = df_inventario[df_inventario['rotacion_estimada'] < 2]
print(f"Productos de baja rotación: {len(baja_rotacion)} ({len(baja_rotacion)/len(df_inventario)*100:.1f}%)")

if len(baja_rotacion) > 0:
    valor_baja_rotacion = baja_rotacion['valor_inventario'].sum()
    print(f"Valor inmovilizado en baja rotación: ${valor_baja_rotacion:,.2f}")
    
    print(f"\nTop 10 productos con menor rotación:")
    productos_lentos = baja_rotacion.nsmallest(10, 'rotacion_estimada')[
        ['codigo_producto', 'nombre_producto', 'categoria', 'stock_actual', 'unidades_vendidas_mes', 'rotacion_estimada']
    ]
    print(productos_lentos.round(2).to_string(index=False))

# 5. Análisis por proveedor
print(f"\n--- ANÁLISIS POR PROVEEDOR ---")
analisis_proveedor = df_inventario.groupby('proveedor').agg({
    'codigo_producto': 'count',
    'valor_inventario': 'sum',
    'stock_critico': 'sum',
    'margen_porcentual': 'mean',
    'dias_sin_compra': 'mean'
}).round(2)

analisis_proveedor.columns = ['Num_Productos', 'Valor_Inventario', 'Productos_Criticos', 'Margen_Promedio', 'Dias_Sin_Compra_Prom']
analisis_proveedor = analisis_proveedor.sort_values('Valor_Inventario', ascending=False)

print(analisis_proveedor)

# Proveedor con más productos en stock crítico
proveedor_problematico = analisis_proveedor['Productos_Criticos'].idxmax()
productos_criticos_proveedor = analisis_proveedor.loc[proveedor_problematico, 'Productos_Criticos']

print(f"\nProveedor con más productos en stock crítico: {proveedor_problematico} ({productos_criticos_proveedor} productos)")
```

### Ejercicio 3: Análisis de satisfacción del cliente
```python
# Dataset de encuestas de satisfacción
np.random.seed(456)

# Generar respuestas de encuestas
n_encuestas = 500

datos_satisfaccion = {
    'cliente_id': range(1001, 1001 + n_encuestas),
    'fecha_encuesta': [fecha_inicio + timedelta(days=np.random.randint(0, 365)) for _ in range(n_encuestas)],
    'edad': np.random.randint(18, 70, n_encuestas),
    'genero': np.random.choice(['M', 'F'], n_encuestas),
    'region': np.random.choice(['Norte', 'Sur', 'Este', 'Oeste', 'Centro'], n_encuestas),
    'tipo_cliente': np.random.choice(['Nuevo', 'Recurrente', 'Premium'], n_encuestas, p=[0.3, 0.5, 0.2]),
    'canal_compra': np.random.choice(['Online', 'Tienda_Física', 'Teléfono', 'App_Móvil'], n_encuestas),
    'calidad_producto': np.random.randint(1, 6, n_encuestas),  # Escala 1-5
    'servicio_cliente': np.random.randint(1, 6, n_encuestas),
    'facilidad_compra': np.random.randint(1, 6, n_encuestas),
    'tiempo_entrega': np.random.randint(1, 6, n_encuestas),
    'valor_dinero': np.random.randint(1, 6, n_encuestas),
    'recomendaria': np.random.choice(['Sí', 'No'], n_encuestas, p=[0.75, 0.25]),
    'monto_compra': np.random.uniform(50, 2000, n_encuestas)
}

df_satisfaccion = pd.DataFrame(datos_satisfaccion)

# Crear score de satisfacción general (promedio de las 5 dimensiones)
dimensiones_satisfaccion = ['calidad_producto', 'servicio_cliente', 'facilidad_compra', 'tiempo_entrega', 'valor_dinero']
df_satisfaccion['satisfaccion_general'] = df_satisfaccion[dimensiones_satisfaccion].mean(axis=1)

# Crear categorías de satisfacción
def categorizar_satisfaccion(score):
    if score >= 4.5:
        return 'Muy Satisfecho'
    elif score >= 3.5:
        return 'Satisfecho'
    elif score >= 2.5:
        return 'Neutral'
    elif score >= 1.5:
        return 'Insatisfecho'
    else:
        return 'Muy Insatisfecho'

df_satisfaccion['categoria_satisfaccion'] = df_satisfaccion['satisfaccion_general'].apply(categorizar_satisfaccion)

# Crear grupos de edad
def grupo_edad(edad):
    if edad < 30:
        return '18-29'
    elif edad < 45:
        return '30-44'
    elif edad < 60:
        return '45-59'
    else:
        return '60+'

df_satisfaccion['grupo_edad'] = df_satisfaccion['edad'].apply(grupo_edad)

print("=== ANÁLISIS DE SATISFACCIÓN DEL CLIENTE ===")
print(f"Dataset de encuestas: {len(df_satisfaccion)} respuestas")

# 1. Análisis general de satisfacción
print(f"\n--- ANÁLISIS GENERAL DE SATISFACCIÓN ---")
satisfaccion_stats = df_satisfaccion['satisfaccion_general'].describe()
print("Estadísticas de satisfacción general:")
print(satisfaccion_stats.round(2))

# Distribución de categorías
print(f"\nDistribución por categoría de satisfacción:")
dist_categorias = df_satisfaccion['categoria_satisfaccion'].value_counts(normalize=True) * 100
for categoria, porcentaje in dist_categorias.items():
    print(f"  {categoria}: {porcentaje:.1f}%")

# Net Promoter Score (NPS) basado en recomendación
nps_positivo = (df_satisfaccion['recomendaria'] == 'Sí').sum()
nps_score = (nps_positivo / len(df_satisfaccion) - 0.5) * 100  # Simplificado
print(f"\nNet Promoter Score (NPS): {nps_score:.1f}")

# 2. Análisis por dimensiones de satisfacción
print(f"\n--- ANÁLISIS POR DIMENSIONES ---")
promedios_dimensiones = df_satisfaccion[dimensiones_satisfaccion].mean().sort_values(ascending=False)
print("Promedios por dimensión:")
for dimension, promedio in promedios_dimensiones.items():
    dimension_nombre = dimension.replace('_', ' ').title()
    print(f"  {dimension_nombre}: {promedio:.2f}/5.0")

# Correlación entre dimensiones
correlacion_dimensiones = df_satisfaccion[dimensiones_satisfaccion + ['satisfaccion_general']].corr().round(3)
print(f"\nCorrelación con satisfacción general:")
correlaciones = correlacion_dimensiones['satisfaccion_general'].drop('satisfaccion_general').sort_values(ascending=False)
for dimension, corr in correlaciones.items():
    dimension_nombre = dimension.replace('_', ' ').title()
    print(f"  {dimension_nombre}: {corr:.3f}")

# 3. Análisis demográfico
print(f"\n--- ANÁLISIS DEMOGRÁFICO ---")

# Satisfacción por género
satisfaccion_genero = df_satisfaccion.groupby('genero').agg({
    'satisfaccion_general': ['mean', 'count'],
    'recomendaria': lambda x: (x == 'Sí').mean() * 100,
    'monto_compra': 'mean'
}).round(2)
satisfaccion_genero.columns = ['Satisfaccion_Promedio', 'Num_Respuestas', 'Pct_Recomendacion', 'Compra_Promedio']
print("Por género:")
print(satisfaccion_genero)

# Satisfacción por grupo de edad
satisfaccion_edad = df_satisfaccion.groupby('grupo_edad').agg({
    'satisfaccion_general': ['mean', 'count'],
    'recomendaria': lambda x: (x == 'Sí').mean() * 100,
    'monto_compra': 'mean'
}).round(2)
satisfaccion_edad.columns = ['Satisfaccion_Promedio', 'Num_Respuestas', 'Pct_Recomendacion', 'Compra_Promedio']
print(f"\nPor grupo de edad:")
print(satisfaccion_edad)

# 4. Análisis por tipo de cliente y canal
print(f"\n--- ANÁLISIS POR TIPO DE CLIENTE Y CANAL ---")

# Tabla pivot: Tipo de cliente vs Canal de compra
pivot_cliente_canal = df_satisfaccion.pivot_table(
    values='satisfaccion_general', 
    index='tipo_cliente', 
    columns='canal_compra', 
    aggfunc='mean'
).round(2)

print("Satisfacción promedio por Tipo de Cliente y Canal:")
print(pivot_cliente_canal)

# Análisis de valor del cliente (satisfacción vs gasto)
print(f"\nAnálisis de valor del cliente:")
analisis_valor = df_satisfaccion.groupby('categoria_satisfaccion').agg({
    'monto_compra': ['mean', 'sum', 'count'],
    'recomendaria': lambda x: (x == 'Sí').mean() * 100
}).round(2)
analisis_valor.columns = ['Compra_Promedio', 'Compra_Total', 'Num_Clientes', 'Pct_Recomendacion']
print(analisis_valor)

# 5. Identificación de oportunidades de mejora
print(f"\n--- OPORTUNIDADES DE MEJORA ---")

# Clientes insatisfechos con alta inversión
clientes_riesgo = df_satisfaccion[
    (df_satisfaccion['categoria_satisfaccion'].isin(['Insatisfecho', 'Muy Insatisfecho'])) &
    (df_satisfaccion['monto_compra'] > df_satisfaccion['monto_compra'].median())
]

print(f"Clientes de alto valor en riesgo: {len(clientes_riesgo)} clientes")
if len(clientes_riesgo) > 0:
    valor_en_riesgo = clientes_riesgo['monto_compra'].sum()
    print(f"Valor en riesgo: ${valor_en_riesgo:,.2f}")
    
    print(f"\nDimensiones con peor calificación en clientes de riesgo:")
    dimensiones_riesgo = clientes_riesgo[dimensiones_satisfaccion].mean().sort_values()
    for dimension, promedio in dimensiones_riesgo.items():
        dimension_nombre = dimension.replace('_', ' ').title()
        print(f"  {dimension_nombre}: {promedio:.2f}/5.0")

# Segmentos con baja recomendación
segmentos_baja_recomendacion = df_satisfaccion.groupby(['region', 'canal_compra']).agg({
    'recomendaria': lambda x: (x == 'Sí').mean() * 100,
    'cliente_id': 'count'
}).round(2)
segmentos_baja_recomendacion.columns = ['Pct_Recomendacion', 'Num_Clientes']
segmentos_baja_recomendacion = segmentos_baja_recomendacion[segmentos_baja_recomendacion['Num_Clientes'] >= 10]
segmentos_problema = segmentos_baja_recomendacion[segmentos_baja_recomendacion['Pct_Recomendacion'] < 70]

print(f"\nSegmentos con baja recomendación (<70%):")
if len(segmentos_problema) > 0:
    print(segmentos_problema.sort_values('Pct_Recomendacion'))
else:
    print("No se encontraron segmentos con baja recomendación significativa")
```

## Notas

### Conceptos fundamentales de Pandas:
- **Series**: Array unidimensional con etiquetas (similar a una columna de Excel)
- **DataFrame**: Estructura tabular bidimensional (similar a una hoja de Excel)
- **Index**: Etiquetas para filas y columnas que facilitan selección y alineación
- **Groupby**: Operación dividir-aplicar-combinar para análisis agregado
- **Pivot Tables**: Reorganización de datos para análisis cruzado

### Operaciones esenciales:
- **Carga**: `pd.read_csv()`, `pd.read_excel()`, `pd.read_json()`
- **Exploración**: `.head()`, `.info()`, `.describe()`, `.value_counts()`
- **Selección**: `.loc[]`, `.iloc[]`, filtros booleanos
- **Agregación**: `.groupby()`, `.agg()`, `.sum()`, `.mean()`
- **Limpieza**: `.fillna()`, `.dropna()`, `.drop_duplicates()`

### Técnicas de análisis:
- **Estadística descriptiva**: Medidas de tendencia central y dispersión
- **Análisis segmentado**: Agrupaciones por categorías
- **Análisis temporal**: Patrones por fechas y períodos
- **Análisis cruzado**: Relaciones entre múltiples variables
- **Detección de anomalías**: Valores atípicos e inconsistencias

### Mejores prácticas:
- Explorar siempre los datos antes de analizarlos (`.info()`, `.describe()`)
- Manejar valores faltantes de manera apropiada según el contexto
- Validar la calidad de los datos antes de sacar conclusiones
- Usar nombres descriptivos para variables y DataFrames
- Documentar las transformaciones realizadas

### Errores comunes:
- No verificar tipos de datos después de cargar archivos
- Ignorar valores faltantes en cálculos estadísticos
- Confundir agregaciones (sum vs mean) según el contexto
- No validar los resultados de join/merge operations
- Modificar DataFrames sin crear copias cuando es necesario

### Recursos adicionales:
- Documentación oficial de Pandas: https://pandas.pydata.org/docs/
- Pandas Cheat Sheet: https://pandas.pydata.org/Pandas_Cheat_Sheet.pdf
- 10 Minutes to Pandas: https://pandas.pydata.org/docs/user_guide/10min.html

### Criterios de evaluación:
- [ ] DataFrames creados y manipulados correctamente
- [ ] Operaciones de limpieza aplicadas apropiadamente
- [ ] Análisis estadísticos realizados con precisión
- [ ] Agrupaciones y agregaciones implementadas correctamente
- [ ] Insights empresariales identificados y comunicados
- [ ] Código limpio, comentado y reproducible
