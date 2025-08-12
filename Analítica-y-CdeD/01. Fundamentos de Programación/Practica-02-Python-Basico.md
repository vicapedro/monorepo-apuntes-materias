# Práctica 2: Programación básica en Python

## Objetivo
Dominar las estructuras básicas del lenguaje Python, incluyendo tipos de datos, estructuras de control y funciones, estableciendo las bases de programación necesarias para el análisis de datos.

## Competencias
- Utilizar tipos de datos básicos de Python (int, float, string, boolean) en contextos de análisis
- Implementar estructuras de control (condicionales y ciclos) para procesar datos
- Crear y utilizar funciones para modularizar código de análisis
- Manejar listas, tuplas y diccionarios para organizar información
- Aplicar conceptos de programación orientada a objetos básicos
- Desarrollar scripts Python funcionales para resolver problemas de datos

## Introducción
Python es el lenguaje de programación más utilizado en ciencia de datos debido a su sintaxis clara, amplia biblioteca de paquetes especializados y capacidad para manejar grandes volúmenes de información. Dominar sus fundamentos es esencial para cualquier analista o científico de datos.

En esta práctica exploraremos los elementos fundamentales del lenguaje que utilizaremos constantemente en nuestros análisis: desde la manipulación básica de datos hasta la creación de funciones reutilizables que nos ayuden a automatizar procesos de análisis.

## Instrucciones

### Parte 1: Tipos de datos y variables
1. Crear un notebook `Python-Basico.ipynb`
2. Explorar cada tipo de dato con ejemplos prácticos
3. Practicar conversiones entre tipos
4. Aplicar operadores matemáticos y lógicos

### Parte 2: Estructuras de datos
1. Trabajar con listas para datos secuenciales
2. Utilizar diccionarios para datos estructurados
3. Explorar tuplas para datos inmutables
4. Combinar estructuras para casos complejos

### Parte 3: Control de flujo
1. Implementar condicionales para toma de decisiones
2. Utilizar ciclos para procesamiento repetitivo
3. Combinar estructuras de control
4. Manejar excepciones básicas

### Parte 4: Funciones y modularidad
1. Crear funciones para cálculos específicos
2. Utilizar parámetros y valores de retorno
3. Implementar funciones lambda
4. Organizar código en módulos

## Ejercicio

### Ejercicio 1: Calculadora de métricas básicas
```python
# Simulando datos de ventas de una empresa
ventas_mensuales = [120000, 135000, 98000, 156000, 142000, 118000, 
                   165000, 178000, 134000, 149000, 167000, 189000]

# 1. Calcular métricas básicas sin usar bibliotecas
def calcular_promedio(datos):
    """Calcula el promedio de una lista de números"""
    return sum(datos) / len(datos)

def encontrar_maximo(datos):
    """Encuentra el valor máximo en una lista"""
    maximo = datos[0]
    for valor in datos:
        if valor > maximo:
            maximo = valor
    return maximo

def encontrar_minimo(datos):
    """Encuentra el valor mínimo en una lista"""
    minimo = datos[0]
    for valor in datos:
        if valor < minimo:
            minimo = valor
    return minimo

# 2. Aplicar las funciones
promedio_ventas = calcular_promedio(ventas_mensuales)
mes_mejor_venta = encontrar_maximo(ventas_mensuales)
mes_peor_venta = encontrar_minimo(ventas_mensuales)

print(f"Promedio de ventas anuales: ${promedio_ventas:,.2f}")
print(f"Mejor mes de ventas: ${mes_mejor_venta:,.2f}")
print(f"Peor mes de ventas: ${mes_peor_venta:,.2f}")

# 3. Clasificar meses según rendimiento
def clasificar_rendimiento(venta, promedio):
    """Clasifica el rendimiento de un mes"""
    if venta >= promedio * 1.1:
        return "Excelente"
    elif venta >= promedio:
        return "Bueno"
    elif venta >= promedio * 0.9:
        return "Regular"
    else:
        return "Deficiente"

# Generar reporte mensual
meses = ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio',
         'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre']

print("\n--- REPORTE MENSUAL ---")
for i in range(len(ventas_mensuales)):
    rendimiento = clasificar_rendimiento(ventas_mensuales[i], promedio_ventas)
    print(f"{meses[i]}: ${ventas_mensuales[i]:,} - {rendimiento}")
```

### Ejercicio 2: Procesador de datos de empleados
```python
# Base de datos simulada de empleados
empleados = [
    {"nombre": "Ana García", "departamento": "Ventas", "salario": 45000, "antiguedad": 3},
    {"nombre": "Carlos López", "departamento": "IT", "salario": 55000, "antiguedad": 5},
    {"nombre": "María Rodríguez", "departamento": "Marketing", "salario": 48000, "antiguedad": 2},
    {"nombre": "Juan Martínez", "departamento": "IT", "salario": 62000, "antiguedad": 7},
    {"nombre": "Laura Sánchez", "departamento": "Ventas", "salario": 41000, "antiguedad": 1},
    {"nombre": "Pedro Hernández", "departamento": "Marketing", "salario": 52000, "antiguedad": 4}
]

# 1. Función para filtrar por departamento
def filtrar_por_departamento(lista_empleados, departamento):
    """Filtra empleados por departamento específico"""
    empleados_filtrados = []
    for empleado in lista_empleados:
        if empleado["departamento"] == departamento:
            empleados_filtrados.append(empleado)
    return empleados_filtrados

# 2. Función para calcular estadísticas salariales
def calcular_estadisticas_salario(lista_empleados):
    """Calcula estadísticas salariales de un grupo de empleados"""
    if not lista_empleados:
        return None
    
    salarios = [emp["salario"] for emp in lista_empleados]
    
    estadisticas = {
        "total_empleados": len(lista_empleados),
        "salario_promedio": sum(salarios) / len(salarios),
        "salario_maximo": max(salarios),
        "salario_minimo": min(salarios),
        "masa_salarial": sum(salarios)
    }
    
    return estadisticas

# 3. Generar reportes por departamento
departamentos = ["Ventas", "IT", "Marketing"]

for dept in departamentos:
    empleados_dept = filtrar_por_departamento(empleados, dept)
    stats = calcular_estadisticas_salario(empleados_dept)
    
    print(f"\n--- DEPARTAMENTO: {dept.upper()} ---")
    print(f"Empleados: {stats['total_empleados']}")
    print(f"Salario promedio: ${stats['salario_promedio']:,.2f}")
    print(f"Rango salarial: ${stats['salario_minimo']:,} - ${stats['salario_maximo']:,}")
    print(f"Masa salarial: ${stats['masa_salarial']:,}")

# 4. Empleados con potencial de aumento
def empleados_aumento_potencial(lista_empleados):
    """Identifica empleados con potencial de aumento (alta antigüedad, salario bajo)"""
    candidatos = []
    
    for empleado in lista_empleados:
        if empleado["antiguedad"] >= 3 and empleado["salario"] < 50000:
            candidatos.append(empleado)
    
    return candidatos

candidatos_aumento = empleados_aumento_potencial(empleados)
print(f"\n--- CANDIDATOS PARA AUMENTO ---")
for candidato in candidatos_aumento:
    print(f"{candidato['nombre']}: {candidato['antiguedad']} años, ${candidato['salario']:,}")
```

### Ejercicio 3: Analizador de texto básico
```python
# Función para analizar texto (simulando análisis de comentarios de clientes)
def analizar_texto(texto):
    """Analiza un texto y devuelve estadísticas básicas"""
    # Convertir a minúsculas para análisis
    texto_limpio = texto.lower()
    
    # Contar elementos básicos
    num_caracteres = len(texto)
    num_caracteres_sin_espacios = len(texto.replace(" ", ""))
    num_palabras = len(texto.split())
    num_oraciones = texto.count(".") + texto.count("!") + texto.count("?")
    
    # Palabras más comunes (manual, sin usar Counter)
    palabras = texto_limpio.split()
    frecuencia_palabras = {}
    
    for palabra in palabras:
        # Limpiar signos de puntuación básicos
        palabra = palabra.strip(".,!?;:")
        if len(palabra) > 2:  # Ignorar palabras muy cortas
            if palabra in frecuencia_palabras:
                frecuencia_palabras[palabra] += 1
            else:
                frecuencia_palabras[palabra] = 1
    
    # Encontrar palabras más frecuentes
    palabra_mas_frecuente = ""
    max_frecuencia = 0
    for palabra, frecuencia in frecuencia_palabras.items():
        if frecuencia > max_frecuencia:
            max_frecuencia = frecuencia
            palabra_mas_frecuente = palabra
    
    # Análisis de sentimiento básico (palabras clave)
    palabras_positivas = ["excelente", "bueno", "genial", "perfecto", "recomiendo", "satisfecho"]
    palabras_negativas = ["malo", "terrible", "deficiente", "problema", "error", "disappointing"]
    
    score_positivo = sum(1 for palabra in palabras_positivas if palabra in texto_limpio)
    score_negativo = sum(1 for palabra in palabras_negativas if palabra in texto_limpio)
    
    if score_positivo > score_negativo:
        sentimiento = "Positivo"
    elif score_negativo > score_positivo:
        sentimiento = "Negativo"
    else:
        sentimiento = "Neutro"
    
    return {
        "caracteres": num_caracteres,
        "caracteres_sin_espacios": num_caracteres_sin_espacios,
        "palabras": num_palabras,
        "oraciones": num_oraciones,
        "palabra_mas_frecuente": palabra_mas_frecuente,
        "frecuencia_maxima": max_frecuencia,
        "sentimiento": sentimiento,
        "score_positivo": score_positivo,
        "score_negativo": score_negativo
    }

# Comentarios de clientes simulados
comentarios = [
    "El producto es excelente y el servicio genial. Lo recomiendo ampliamente.",
    "Tuve un problema con la entrega pero el soporte fue bueno para resolverlo.",
    "Deficiente calidad del producto. Muy disappointing la experiencia.",
    "Perfecto para mis necesidades. Estoy muy satisfecho con la compra."
]

print("--- ANÁLISIS DE COMENTARIOS DE CLIENTES ---")
for i, comentario in enumerate(comentarios, 1):
    print(f"\nComentario {i}: {comentario[:50]}...")
    analisis = analizar_texto(comentario)
    print(f"Palabras: {analisis['palabras']}")
    print(f"Sentimiento: {analisis['sentimiento']}")
    print(f"Palabra más frecuente: '{analisis['palabra_mas_frecuente']}' ({analisis['frecuencia_maxima']} veces)")
```

## Notas

### Conceptos clave a recordar:
1. **Tipos de datos**: int, float, str, bool, list, dict, tuple
2. **Operadores**: Aritméticos (+, -, *, /), Lógicos (and, or, not), Comparación (==, !=, <, >)
3. **Estructuras de control**: if/elif/else, for, while
4. **Funciones**: def, return, parámetros, scope de variables
5. **Manejo de errores**: try/except básico

### Mejores prácticas:
- Usar nombres descriptivos para variables y funciones
- Documentar funciones con docstrings
- Mantener funciones simples y con un propósito específico
- Usar comentarios para explicar lógica compleja
- Validar entradas de datos cuando sea necesario

### Errores comunes a evitar:
- División por cero sin verificación
- Acceso a índices fuera de rango en listas
- Modificar listas mientras se iteran sobre ellas
- Confundir asignación (=) con comparación (==)
- No manejar casos de listas vacías

### Recursos de consulta:
- Documentación oficial de Python: https://docs.python.org/3/
- Python for Beginners: https://www.python.org/about/gettingstarted/
- Real Python tutorials: https://realpython.com/

### Criterios de evaluación:
- [ ] Sintaxis correcta en todos los ejercicios
- [ ] Funciones implementadas correctamente
- [ ] Manejo adecuado de estructuras de datos
- [ ] Lógica de programación aplicada correctamente
- [ ] Código documentado y comentado
- [ ] Ejercicios completados con resultados correctos
