# Ejecutor de Stored Procedure - Northwind

Script en Python para ejecutar el procedimiento almacenado `usp_ProcessCustomerOrder` y demostrar cómo capturar todos sus mecanismos de retorno.

## Requisitos

### 1. Software Necesario

- Python 3.7 o superior
- SQL Server (local o remoto)
- Base de datos Northwind
- ODBC Driver for SQL Server

### 2. Instalación de Dependencias

```bash
# Instalar pyodbc
pip install pyodbc
```

### 3. Instalar ODBC Driver para SQL Server

#### Windows
El driver generalmente viene preinstalado. Si no:
- Descargar desde: https://learn.microsoft.com/en-us/sql/connect/odbc/download-odbc-driver-for-sql-server

#### Linux (Ubuntu/Debian)
```bash
curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
curl https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/prod.list > /etc/apt/sources.list.d/mssql-release.list
apt-get update
ACCEPT_EULA=Y apt-get install -y msodbcsql17
```

#### macOS
```bash
brew tap microsoft/mssql-release https://github.com/Microsoft/homebrew-mssql-release
brew update
HOMEBREW_NO_ENV_FILTERING=1 ACCEPT_EULA=Y brew install msodbcsql17
```

## Preparación

### 1. Crear el Procedimiento Almacenado

Ejecutar primero el script SQL `Ejemplo-SP-Northwind-Completo.sql` en SQL Server:

```sql
-- Abrir SQL Server Management Studio o Azure Data Studio
-- Conectar a la base de datos Northwind
-- Ejecutar el contenido completo de: Ejemplo-SP-Northwind-Completo.sql
```

### 2. Configurar Conexión

Editar el script `ejecutar_sp_northwind.py` según tu configuración:

#### Autenticación Windows (recomendado)
```python
processor = NorthwindOrderProcessor(
    server="localhost"  # o nombre/IP de tu servidor
)
```

#### Autenticación SQL Server
```python
processor = NorthwindOrderProcessor(
    server="localhost",
    username="sa",
    password="tu_password"
)
```

## Uso del Script

### Ejecución Interactiva

```bash
python ejecutar_sp_northwind.py
```

El script presenta un menú con opciones:

```
1. Ejecución exitosa (con descuento)
2. Error: Cliente inexistente
3. Error: Empleado inexistente
4. Ejecución interactiva
5. Listar clientes disponibles
0. Salir
```

### Uso como Módulo

```python
from ejecutar_sp_northwind import NorthwindOrderProcessor

# Crear instancia
processor = NorthwindOrderProcessor(server="localhost")

# Conectar
if processor.connect():
    # Ejecutar procedimiento
    result = processor.process_order(
        customer_id="ALFKI",
        employee_id=5,
        ship_via=1,
        required_days=7,
        apply_discount=True
    )
    
    # Procesar resultado
    if result['return_code'] == 0:
        print(f"✓ Pedido creado: {result['order_id']}")
        print(f"  Total: ${result['total_amount']:.2f}")
    else:
        print(f"✗ Error: {result['error']}")
    
    processor.disconnect()
```

## Mecanismos Demostrados

### 1. Parámetros OUTPUT

El script captura los valores OUTPUT del procedimiento:

```python
result['order_id']           # ID del pedido generado
result['total_amount']       # Total calculado
result['products_processed'] # Cantidad de productos
result['discount_applied']   # Descuento aplicado
```

### 2. Código de Retorno (RETURN)

```python
result['return_code']  # Código numérico de estado
```

Códigos posibles:
- `0`: Operación exitosa
- `-1`: Cliente no encontrado
- `-2`: Empleado no encontrado
- `-3`: Producto sin stock
- `-4`: Error general

### 3. Excepciones (RAISERROR)

Las excepciones SQL se capturan en el bloque `try/except`:

```python
try:
    cursor.execute(sql_call, params)
except pyodbc.Error as e:
    result['error'] = str(e)  # Mensaje de RAISERROR
```

### 4. Record Sets

El procedimiento devuelve dos conjuntos de resultados:

```python
result['order_header']   # Lista con encabezado del pedido
result['order_details']  # Lista con detalles de productos
```

## Ejemplos de Salida

### Ejecución Exitosa

```
======================================================================
RESULTADOS DE LA EJECUCIÓN DEL PROCEDIMIENTO
======================================================================

1. CÓDIGO DE RETORNO (RETURN): 0
   Estado: ✓ Operación exitosa

2. PARÁMETROS OUTPUT:
   - Order ID: 11078
   - Total Amount: $453.50
   - Products Processed: 5
   - Discount Applied: $45.35

4. RECORD SET 1 - ENCABEZADO DEL PEDIDO:
   Order ID: 11078
   Customer: Alfreds Futterkiste
   Employee: Steven Buchanan
   Shipper: Speedy Express
   Subtotal: $453.50
   Discount: $45.35
   Grand Total: $476.18

5. RECORD SET 2 - DETALLES DE PRODUCTOS:
   ID     Producto                       Precio     Cant.  Desc.    Total     
   ------ ------------------------------ ---------- ------ -------- ----------
   12     Queso Cabrales                 $21.00     10     10.0%    $189.00   
   34     Sasquatch Ale                  $14.00     5      10.0%    $63.00    
   ...
```

### Error Capturado

```
======================================================================
RESULTADOS DE LA EJECUCIÓN DEL PROCEDIMIENTO
======================================================================

1. CÓDIGO DE RETORNO (RETURN): -1
   Estado: ✗ Error: Cliente no encontrado

2. PARÁMETROS OUTPUT:
   - Order ID: None
   - Total Amount: N/A
   - Products Processed: None
   - Discount Applied: N/A

3. EXCEPCIÓN CAPTURADA (RAISERROR):
   [ODBC Driver 17 for SQL Server][SQL Server]Error: El cliente con ID "XXXXX" 
   no existe en la base de datos.
```

## Estructura del Código

### Clase Principal: `NorthwindOrderProcessor`

```python
class NorthwindOrderProcessor:
    def __init__(self, server, database="Northwind", username=None, password=None)
    def connect(self)
    def disconnect(self)
    def process_order(self, customer_id, employee_id, ...) -> dict
    def display_result(self, result)
```

### Funciones de Ejemplo

- `ejemplo_ejecucion_exitosa()`: Caso exitoso con descuento
- `ejemplo_cliente_inexistente()`: Demuestra manejo de error
- `ejemplo_empleado_inexistente()`: Demuestra otro error
- `ejemplo_interactivo()`: Permite entrada manual
- `listar_clientes_disponibles()`: Consulta auxiliar

## Solución de Problemas

### Error: "Driver not found"

```
[IM002] [Microsoft][ODBC Driver Manager] Data source name not found
```

**Solución:** Instalar ODBC Driver 17 for SQL Server (ver sección de instalación)

### Error: "Login failed for user"

**Solución:** Verificar credenciales o usar autenticación Windows

### Error: "Cannot open database Northwind"

**Solución:** 
1. Verificar que la base de datos Northwind existe
2. Asegurar que el usuario tiene permisos
3. Restaurar Northwind desde backup si es necesario

### Error: "Could not find stored procedure"

**Solución:** Ejecutar primero `Ejemplo-SP-Northwind-Completo.sql`

## Recursos Adicionales

- [pyodbc Documentation](https://github.com/mkleehammer/pyodbc/wiki)
- [SQL Server Connection Strings](https://www.connectionstrings.com/sql-server/)
- [Northwind Database Download](https://github.com/microsoft/sql-server-samples/tree/master/samples/databases/northwind-pubs)

## Licencia

Material educativo para Taller de Base de Datos.

## Autor

Taller de Base de Datos - 2025
