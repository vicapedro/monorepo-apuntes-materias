# Práctica 3: Manipulación de arrays con NumPy

## Objetivo
Dominar las operaciones fundamentales con arrays de NumPy para el procesamiento eficiente de datos numéricos, estableciendo las bases para análisis matemáticos y estadísticos avanzados.

## Competencias
- Crear y manipular arrays de NumPy de diferentes dimensiones
- Aplicar operaciones matemáticas vectorizadas para cálculos eficientes
- Utilizar indexing y slicing avanzado para extraer subconjuntos de datos
- Realizar operaciones estadísticas básicas con arrays multidimensionales
- Implementar broadcasting para operaciones entre arrays de diferentes dimensiones
- Transformar y reestructurar arrays según necesidades de análisis

## Introducción
NumPy (Numerical Python) es la biblioteca fundamental para computación científica en Python. Proporciona arrays multidimensionales de alto rendimiento y herramientas para trabajar con estos arrays. Es la base sobre la cual se construyen la mayoría de las bibliotecas de ciencia de datos en Python, incluyendo Pandas, Matplotlib y Scikit-learn.

La principal ventaja de NumPy es su capacidad de realizar operaciones vectorizadas, que son significativamente más rápidas que los loops tradicionales de Python. Esta eficiencia es crucial cuando trabajamos con grandes volúmenes de datos, como es común en proyectos de analítica empresarial.

## Instrucciones

### Parte 1: Creación y tipos de arrays
1. Importar NumPy y explorar métodos de creación de arrays
2. Trabajar con arrays de 1D, 2D y 3D
3. Explorar diferentes tipos de datos (dtype)
4. Generar arrays con funciones especiales (zeros, ones, random, etc.)

### Parte 2: Indexing y slicing
1. Acceder a elementos individuales y rangos
2. Utilizar indexing booleano para filtrar datos
3. Modificar arrays mediante indexing
4. Trabajar con arrays multidimensionales

### Parte 3: Operaciones matemáticas
1. Operaciones aritméticas básicas
2. Funciones matemáticas universales (ufuncs)
3. Broadcasting entre arrays de diferentes tamaños
4. Operaciones de álgebra lineal básica

### Parte 4: Estadística con NumPy
1. Cálculos estadísticos básicos (media, mediana, desviación estándar)
2. Agregaciones a lo largo de ejes específicos
3. Operaciones de ordenamiento y búsqueda
4. Análisis de correlación básico

## Ejercicio

### Ejercicio 1: Análisis de ventas trimestrales
```python
import numpy as np

# Datos de ventas por trimestre (filas) y región (columnas)
# Trimestres: Q1, Q2, Q3, Q4
# Regiones: Norte, Sur, Este, Oeste, Centro
ventas_regionales = np.array([
    [120000, 98000, 135000, 87000, 102000],   # Q1
    [142000, 105000, 156000, 94000, 118000],  # Q2  
    [158000, 122000, 178000, 103000, 134000], # Q3
    [165000, 134000, 189000, 98000, 149000]   # Q4
])

regiones = np.array(['Norte', 'Sur', 'Este', 'Oeste', 'Centro'])
trimestres = np.array(['Q1', 'Q2', 'Q3', 'Q4'])

print("=== ANÁLISIS DE VENTAS TRIMESTRALES ===")
print(f"Dimensiones del array: {ventas_regionales.shape}")
print(f"Tipo de datos: {ventas_regionales.dtype}")
print(f"Ventas totales del año: ${ventas_regionales.sum():,}")

# 1. Análisis por trimestre
print("\n--- ANÁLISIS POR TRIMESTRE ---")
ventas_por_trimestre = np.sum(ventas_regionales, axis=1)  # Suma por filas
for i, trimestre in enumerate(trimestres):
    print(f"{trimestre}: ${ventas_por_trimestre[i]:,}")

# Encontrar el mejor y peor trimestre
mejor_trimestre_idx = np.argmax(ventas_por_trimestre)
peor_trimestre_idx = np.argmin(ventas_por_trimestre)
print(f"\nMejor trimestre: {trimestres[mejor_trimestre_idx]} (${ventas_por_trimestre[mejor_trimestre_idx]:,})")
print(f"Peor trimestre: {trimestres[peor_trimestre_idx]} (${ventas_por_trimestre[peor_trimestre_idx]:,})")

# 2. Análisis por región
print("\n--- ANÁLISIS POR REGIÓN ---")
ventas_por_region = np.sum(ventas_regionales, axis=0)  # Suma por columnas
for i, region in enumerate(regiones):
    print(f"{region}: ${ventas_por_region[i]:,}")

# Ranking de regiones
indices_ranking = np.argsort(ventas_por_region)[::-1]  # Ordenar de mayor a menor
print(f"\nRanking de regiones:")
for i, idx in enumerate(indices_ranking):
    print(f"{i+1}. {regiones[idx]}: ${ventas_por_region[idx]:,}")

# 3. Estadísticas avanzadas
print("\n--- ESTADÍSTICAS GENERALES ---")
print(f"Promedio general: ${np.mean(ventas_regionales):,.2f}")
print(f"Mediana: ${np.median(ventas_regionales):,.2f}")
print(f"Desviación estándar: ${np.std(ventas_regionales):,.2f}")
print(f"Coeficiente de variación: {(np.std(ventas_regionales)/np.mean(ventas_regionales)*100):.2f}%")

# 4. Análisis de crecimiento trimestral
print("\n--- CRECIMIENTO TRIMESTRAL ---")
for i in range(1, len(trimestres)):
    crecimiento = ((ventas_por_trimestre[i] - ventas_por_trimestre[i-1]) / ventas_por_trimestre[i-1]) * 100
    print(f"{trimestres[i-1]} -> {trimestres[i]}: {crecimiento:+.2f}%")

# 5. Identificar regiones con crecimiento consistente
print("\n--- REGIONES CON CRECIMIENTO CONSISTENTE ---")
for i, region in enumerate(regiones):
    ventas_region = ventas_regionales[:, i]  # Extraer columna de la región
    crecimientos = []
    for j in range(1, len(ventas_region)):
        crecimiento = ((ventas_region[j] - ventas_region[j-1]) / ventas_region[j-1]) * 100
        crecimientos.append(crecimiento)
    
    crecimiento_promedio = np.mean(crecimientos)
    crecimientos_positivos = np.sum(np.array(crecimientos) > 0)
    
    print(f"{region}: {crecimiento_promedio:+.2f}% promedio, {crecimientos_positivos}/3 trimestres positivos")
```

### Ejercicio 2: Simulador de carteras de inversión
```python
# Simulación de rendimientos de diferentes activos financieros
np.random.seed(42)  # Para reproducibilidad

# Generar 252 días de trading (1 año) para 5 activos
activos = ['AAPL', 'GOOGL', 'MSFT', 'AMZN', 'TSLA']
dias_trading = 252

# Rendimientos diarios simulados (distribución normal)
# Diferentes medias y volatilidades para cada activo
medias_rendimiento = np.array([0.0008, 0.0012, 0.0009, 0.0011, 0.0020])  # ~20-50% anual
volatilidades = np.array([0.020, 0.025, 0.018, 0.022, 0.035])           # Volatilidad diaria

rendimientos_diarios = np.random.normal(
    loc=medias_rendimiento.reshape(1, -1), 
    scale=volatilidades.reshape(1, -1), 
    size=(dias_trading, len(activos))
)

print("=== SIMULADOR DE CARTERAS DE INVERSIÓN ===")
print(f"Período de análisis: {dias_trading} días de trading")
print(f"Activos analizados: {', '.join(activos)}")

# 1. Cálculo de precios simulados (asumiendo precio inicial de $100)
precios_iniciales = np.full(len(activos), 100.0)
precios_acumulados = np.zeros((dias_trading + 1, len(activos)))
precios_acumulados[0] = precios_iniciales

for dia in range(dias_trading):
    precios_acumulados[dia + 1] = precios_acumulados[dia] * (1 + rendimientos_diarios[dia])

print(f"\n--- RENDIMIENTOS ANUALES ---")
rendimientos_anuales = (precios_acumulados[-1] / precios_acumulados[0] - 1) * 100
for i, activo in enumerate(activos):
    print(f"{activo}: {rendimientos_anuales[i]:+.2f}% (${precios_acumulados[0][i]:.2f} -> ${precios_acumulados[-1][i]:.2f})")

# 2. Análisis de riesgo (volatilidad)
print(f"\n--- ANÁLISIS DE RIESGO ---")
volatilidad_anual = np.std(rendimientos_diarios, axis=0) * np.sqrt(252) * 100  # Anualizada
for i, activo in enumerate(activos):
    print(f"{activo}: {volatilidad_anual[i]:.2f}% volatilidad anual")

# 3. Ratio de Sharpe simplificado (asumiendo tasa libre de riesgo = 2%)
tasa_libre_riesgo = 2.0
print(f"\n--- RATIO DE SHARPE ---")
ratios_sharpe = (rendimientos_anuales - tasa_libre_riesgo) / volatilidad_anual
for i, activo in enumerate(activos):
    print(f"{activo}: {ratios_sharpe[i]:.3f}")

# 4. Correlaciones entre activos
matriz_correlacion = np.corrcoef(rendimientos_diarios.T)
print(f"\n--- MATRIZ DE CORRELACIONES ---")
print("     ", "  ".join(f"{activo:>6}" for activo in activos))
for i, activo in enumerate(activos):
    fila = f"{activo:<6}"
    for j in range(len(activos)):
        fila += f"{matriz_correlacion[i][j]:>8.3f}"
    print(fila)

# 5. Optimización de cartera simple (pesos iguales vs mejor Sharpe)
print(f"\n--- COMPARACIÓN DE CARTERAS ---")

# Cartera con pesos iguales
pesos_iguales = np.full(len(activos), 1/len(activos))
rendimiento_cartera_igual = np.sum(pesos_iguales * rendimientos_anuales)
# Volatilidad de cartera considerando correlaciones
volatilidad_cartera_igual = np.sqrt(np.dot(pesos_iguales, np.dot(matriz_correlacion * (volatilidad_anual.reshape(-1,1) @ volatilidad_anual.reshape(1,-1)), pesos_iguales)))
sharpe_cartera_igual = (rendimiento_cartera_igual - tasa_libre_riesgo) / volatilidad_cartera_igual

print(f"Cartera pesos iguales:")
print(f"  Rendimiento: {rendimiento_cartera_igual:.2f}%")
print(f"  Volatilidad: {volatilidad_cartera_igual:.2f}%")
print(f"  Ratio Sharpe: {sharpe_cartera_igual:.3f}")

# Cartera concentrada en mejor Sharpe
mejor_activo_idx = np.argmax(ratios_sharpe)
print(f"\nCartera concentrada en {activos[mejor_activo_idx]}:")
print(f"  Rendimiento: {rendimientos_anuales[mejor_activo_idx]:.2f}%")
print(f"  Volatilidad: {volatilidad_anual[mejor_activo_idx]:.2f}%")
print(f"  Ratio Sharpe: {ratios_sharpe[mejor_activo_idx]:.3f}")

# 6. Análisis de drawdown máximo
print(f"\n--- DRAWDOWN MÁXIMO ---")
for i, activo in enumerate(activos):
    precios_activo = precios_acumulados[:, i]
    picos_acumulados = np.maximum.accumulate(precios_activo)
    drawdowns = (precios_activo - picos_acumulados) / picos_acumulados * 100
    drawdown_maximo = np.min(drawdowns)
    print(f"{activo}: {drawdown_maximo:.2f}%")
```

### Ejercicio 3: Análisis de datos de sensores IoT
```python
# Simulación de datos de sensores en una planta industrial
np.random.seed(123)

# Configuración de la simulación
horas_simulacion = 24 * 7  # Una semana completa
sensores = ['Temperatura', 'Presión', 'Humedad', 'Vibración', 'Consumo_Energía']
n_sensores = len(sensores)

# Generar datos base con patrones realistas
tiempo = np.arange(horas_simulacion)

# Temperatura: ciclo diario + ruido
temp_base = 22 + 5 * np.sin(2 * np.pi * tiempo / 24) + np.random.normal(0, 1, horas_simulacion)

# Presión: relativamente estable con drift lento
presion_base = 101.3 + 0.1 * np.sin(2 * np.pi * tiempo / (24*7)) + np.random.normal(0, 0.5, horas_simulacion)

# Humedad: anti-correlacionada con temperatura
humedad_base = 60 - 0.5 * (temp_base - 22) + np.random.normal(0, 3, horas_simulacion)

# Vibración: operación normal con algunas anomalías
vibración_base = np.random.gamma(2, 0.5, horas_simulacion)
# Agregar anomalías esporádicas
anomalias_idx = np.random.choice(horas_simulacion, size=10, replace=False)
vibración_base[anomalias_idx] *= 5

# Consumo energético: correlacionado con operación (vibración)
consumo_base = 100 + vibración_base * 20 + np.random.normal(0, 5, horas_simulacion)

# Combinar todos los datos
datos_sensores = np.column_stack([temp_base, presion_base, humedad_base, vibración_base, consumo_base])

print("=== ANÁLISIS DE DATOS DE SENSORES IoT ===")
print(f"Período de análisis: {horas_simulacion} horas ({horas_simulacion//24} días)")
print(f"Sensores monitoreados: {len(sensores)}")
print(f"Dimensiones del dataset: {datos_sensores.shape}")

# 1. Estadísticas descriptivas por sensor
print(f"\n--- ESTADÍSTICAS DESCRIPTIVAS ---")
estadisticas = {
    'Sensor': sensores,
    'Media': np.mean(datos_sensores, axis=0),
    'Mediana': np.median(datos_sensores, axis=0),
    'Std': np.std(datos_sensores, axis=0),
    'Min': np.min(datos_sensores, axis=0),
    'Max': np.max(datos_sensores, axis=0)
}

for i, sensor in enumerate(sensores):
    print(f"{sensor}:")
    print(f"  Media: {estadisticas['Media'][i]:.2f}")
    print(f"  Mediana: {estadisticas['Mediana'][i]:.2f}")
    print(f"  Desv. Std: {estadisticas['Std'][i]:.2f}")
    print(f"  Rango: [{estadisticas['Min'][i]:.2f}, {estadisticas['Max'][i]:.2f}]")

# 2. Detección de anomalías usando Z-score
print(f"\n--- DETECCIÓN DE ANOMALÍAS (Z-score > 3) ---")
z_scores = np.abs((datos_sensores - np.mean(datos_sensores, axis=0)) / np.std(datos_sensores, axis=0))
anomalias_detectadas = z_scores > 3

for i, sensor in enumerate(sensores):
    n_anomalias = np.sum(anomalias_detectadas[:, i])
    if n_anomalias > 0:
        horas_anomalias = tiempo[anomalias_detectadas[:, i]]
        print(f"{sensor}: {n_anomalias} anomalías detectadas")
        print(f"  Horas: {horas_anomalias[:5]}{'...' if n_anomalias > 5 else ''}")
        valores_anomalos = datos_sensores[anomalias_detectadas[:, i], i]
        print(f"  Valores: {valores_anomalos[:3]:.2f}{'...' if n_anomalias > 3 else ''}")
    else:
        print(f"{sensor}: No se detectaron anomalías")

# 3. Análisis de correlaciones entre sensores
print(f"\n--- MATRIZ DE CORRELACIONES ---")
matriz_corr = np.corrcoef(datos_sensores.T)
print("           ", "  ".join(f"{sensor[:8]:>10}" for sensor in sensores))
for i, sensor in enumerate(sensores):
    fila = f"{sensor[:10]:<11}"
    for j in range(len(sensores)):
        fila += f"{matriz_corr[i][j]:>10.3f}"
    print(fila)

# Identificar correlaciones fuertes
correlaciones_fuertes = []
for i in range(len(sensores)):
    for j in range(i+1, len(sensores)):
        if abs(matriz_corr[i][j]) > 0.5:
            correlaciones_fuertes.append((sensores[i], sensores[j], matriz_corr[i][j]))

print(f"\nCorrelaciones fuertes (|r| > 0.5):")
for sensor1, sensor2, corr in correlaciones_fuertes:
    print(f"  {sensor1} <-> {sensor2}: {corr:.3f}")

# 4. Análisis temporal por días de la semana
print(f"\n--- ANÁLISIS POR DÍA DE LA SEMANA ---")
dias_semana = ['Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb', 'Dom']

# Reorganizar datos por día de la semana (asumiendo que empezamos en lunes)
datos_por_dia = np.zeros((7, 24, n_sensores))
for hora in range(horas_simulacion):
    dia_semana = (hora // 24) % 7
    hora_dia = hora % 24
    datos_por_dia[dia_semana, hora_dia, :] = datos_sensores[hora, :]

# Promedios por día de la semana
promedios_dia = np.mean(datos_por_dia, axis=1)
print("Día        ", "  ".join(f"{sensor[:8]:>10}" for sensor in sensores))
for dia in range(7):
    fila = f"{dias_semana[dia]:<11}"
    for sensor in range(n_sensores):
        fila += f"{promedios_dia[dia, sensor]:>10.2f}"
    print(fila)

# 5. Detección de patrones de operación (horarios de alta/baja actividad)
print(f"\n--- PATRONES HORARIOS DE OPERACIÓN ---")
# Usar consumo energético como proxy de actividad
consumo_por_hora = np.mean(datos_por_dia[:, :, 4], axis=0)  # Promedio de consumo por hora del día
hora_pico = np.argmax(consumo_por_hora)
hora_valle = np.argmin(consumo_por_hora)

print(f"Hora de mayor actividad: {hora_pico:02d}:00 ({consumo_por_hora[hora_pico]:.2f} kW)")
print(f"Hora de menor actividad: {hora_valle:02d}:00 ({consumo_por_hora[hora_valle]:.2f} kW)")
print(f"Diferencia pico-valle: {(consumo_por_hora[hora_pico] - consumo_por_hora[hora_valle]):.2f} kW")

# Identificar horarios de operación normal (±1 std de la media)
media_consumo = np.mean(consumo_por_hora)
std_consumo = np.std(consumo_por_hora)
horas_normales = np.where((consumo_por_hora >= media_consumo - std_consumo) & 
                         (consumo_por_hora <= media_consumo + std_consumo))[0]

print(f"Horarios de operación normal: {', '.join(f'{h:02d}:00' for h in horas_normales)}")
```

## Notas

### Conceptos fundamentales de NumPy:
- **Arrays**: Estructura de datos fundamental, homogénea y multidimensional
- **Vectorización**: Operaciones aplicadas elemento por elemento sin loops explícitos
- **Broadcasting**: Reglas para operaciones entre arrays de diferentes formas
- **Views vs Copies**: Diferencia entre referencias y copias independientes
- **Dtype**: Tipos de datos que determinan precisión y uso de memoria

### Funciones esenciales:
- **Creación**: `np.array()`, `np.zeros()`, `np.ones()`, `np.arange()`, `np.linspace()`
- **Forma y tamaño**: `.shape`, `.size`, `.ndim`, `np.reshape()`
- **Indexing**: Entero, slice, booleano, fancy indexing
- **Matemáticas**: `np.sum()`, `np.mean()`, `np.std()`, `np.min()`, `np.max()`
- **Álgebra lineal**: `np.dot()`, `np.linalg.inv()`, `np.corrcoef()`

### Optimización de rendimiento:
- Preferir operaciones vectorizadas sobre loops de Python
- Usar vistas en lugar de copias cuando sea posible
- Especificar dtype apropiado para ahorrar memoria
- Utilizar funciones de NumPy en lugar de equivalentes de Python puro

### Errores comunes:
- Confundir arrays 1D con arrays 2D de una sola fila/columna
- No considerar el broadcasting en operaciones
- Modificar arrays inadvertidamente a través de views
- Usar loops cuando existe una función vectorizada equivalente

### Recursos adicionales:
- Documentación oficial de NumPy: https://numpy.org/doc/
- NumPy Quickstart: https://numpy.org/doc/stable/user/quickstart.html
- From Python to NumPy: https://numpy.org/devdocs/user/numpy-for-matlab-users.html

### Criterios de evaluación:
- [ ] Arrays creados y manipulados correctamente
- [ ] Operaciones matemáticas aplicadas eficientemente
- [ ] Indexing y slicing utilizados apropiadamente
- [ ] Estadísticas calculadas con funciones de NumPy
- [ ] Broadcasting comprendido y aplicado
- [ ] Código optimizado sin loops innecesarios
