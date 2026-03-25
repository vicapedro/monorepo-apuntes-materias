#!/usr/bin/env python3
"""
=====================================================
Script Python: Ejecutar Stored Procedure con Northwind
=====================================================

Demuestra cómo ejecutar un procedimiento almacenado y capturar:
1. Parámetros OUTPUT
2. Código de retorno (RETURN)
3. Excepciones (RAISERROR)
4. Record Sets (múltiples conjuntos de resultados)

Requisitos:
    pip install pyodbc

Autor: Taller de Base de Datos
Fecha: 2025-11-10
=====================================================
"""

import pyodbc
from datetime import datetime
from typing import Tuple, List, Optional


class NorthwindOrderProcessor:
    """
    Clase para ejecutar el procedimiento almacenado usp_ProcessCustomerOrder
    y manejar todos sus mecanismos de retorno.
    """
    
    def __init__(self, server: str, database: str = "Northwind", 
                 username: str = None, password: str = None):
        """
        Inicializa la conexión a SQL Server.
        
        Args:
            server: Nombre o IP del servidor SQL Server
            database: Nombre de la base de datos (default: Northwind)
            username: Usuario de SQL Server (None para Windows Auth)
            password: Contraseña (None para Windows Auth)
        """
        self.server = server
        self.database = database
        self.connection = None
        
        # Construir connection string
        if username and password:
            # Autenticación SQL Server
            self.conn_string = (
                f"DRIVER={{ODBC Driver 17 for SQL Server}};"
                f"SERVER={server};"
                f"DATABASE={database};"
                f"UID={username};"
                f"PWD={password};"
                f"TrustServerCertificate=yes;"
            )
        else:
            # Autenticación Windows
            self.conn_string = (
                f"DRIVER={{ODBC Driver 17 for SQL Server}};"
                f"SERVER={server};"
                f"DATABASE={database};"
                f"Trusted_Connection=yes;"
            )
    
    def connect(self):
        """Establece conexión con la base de datos."""
        try:
            self.connection = pyodbc.connect(self.conn_string)
            print(f"✓ Conectado a {self.database} en {self.server}")
            return True
        except pyodbc.Error as e:
            print(f"✗ Error de conexión: {e}")
            return False
    
    def disconnect(self):
        """Cierra la conexión con la base de datos."""
        if self.connection:
            self.connection.close()
            print("✓ Conexión cerrada")
    
    def process_order(self, customer_id: str, employee_id: int,
                     ship_via: int = 1, required_days: int = 7,
                     apply_discount: bool = False) -> dict:
        """
        Ejecuta el procedimiento almacenado usp_ProcessCustomerOrder.
        
        Args:
            customer_id: ID del cliente (ej: 'ALFKI')
            employee_id: ID del empleado
            ship_via: ID del transportista (default: 1)
            required_days: Días para entrega (default: 7)
            apply_discount: Aplicar descuento del 10% (default: False)
        
        Returns:
            Diccionario con:
                - return_code: Código de retorno del procedimiento
                - order_id: ID del pedido generado (OUTPUT)
                - total_amount: Total del pedido (OUTPUT)
                - products_processed: Cantidad de productos (OUTPUT)
                - discount_applied: Descuento aplicado (OUTPUT)
                - order_header: Datos del encabezado del pedido (Record Set 1)
                - order_details: Detalles de productos (Record Set 2)
                - messages: Mensajes PRINT del servidor
                - error: Mensaje de error si ocurrió
        """
        if not self.connection:
            return {"error": "No hay conexión a la base de datos"}
        
        result = {
            "return_code": None,
            "order_id": None,
            "total_amount": None,
            "products_processed": None,
            "discount_applied": None,
            "order_header": [],
            "order_details": [],
            "messages": [],
            "error": None
        }
        
        try:
            cursor = self.connection.cursor()
            
            # Habilitar captura de mensajes PRINT del servidor
            cursor.connection.add_output_converter(-155, self._handle_print_message)
            
            # =====================================================
            # EJECUTAR PROCEDIMIENTO ALMACENADO
            # =====================================================
            # Sintaxis: {? = call procedure_name (?, ?, ...)}
            # El primer ? captura el RETURN value
            # Los siguientes ? son parámetros INPUT/OUTPUT
            
            sql_call = """
                DECLARE @return_value int,
                        @OrderID int,
                        @TotalAmount money,
                        @ProductsProcessed int,
                        @DiscountApplied money;
                
                EXEC @return_value = dbo.usp_ProcessCustomerOrder
                    @CustomerID = ?,
                    @EmployeeID = ?,
                    @ShipVia = ?,
                    @RequiredDays = ?,
                    @ApplyDiscount = ?,
                    @OrderID = @OrderID OUTPUT,
                    @TotalAmount = @TotalAmount OUTPUT,
                    @ProductsProcessed = @ProductsProcessed OUTPUT,
                    @DiscountApplied = @DiscountApplied OUTPUT;
                
                SELECT @return_value as return_value,
                       @OrderID as order_id,
                       @TotalAmount as total_amount,
                       @ProductsProcessed as products_processed,
                       @DiscountApplied as discount_applied;
            """
            
            # Ejecutar con parámetros
            cursor.execute(sql_call, 
                          customer_id, 
                          employee_id, 
                          ship_via, 
                          required_days, 
                          1 if apply_discount else 0)
            
            # =====================================================
            # CAPTURAR MÚLTIPLES RECORD SETS
            # =====================================================
            
            recordset_count = 0
            
            while True:
                # Obtener filas del record set actual
                rows = cursor.fetchall()
                
                if rows:
                    recordset_count += 1
                    columns = [column[0] for column in cursor.description]
                    
                    # Convertir filas a lista de diccionarios
                    data = []
                    for row in rows:
                        row_dict = {}
                        for i, col in enumerate(columns):
                            row_dict[col] = row[i]
                        data.append(row_dict)
                    
                    # Determinar qué record set es según el contenido
                    if recordset_count == 1 and 'return_value' in columns:
                        # Primer record set: valores de OUTPUT y RETURN
                        result["return_code"] = data[0]["return_value"]
                        result["order_id"] = data[0]["order_id"]
                        result["total_amount"] = float(data[0]["total_amount"]) if data[0]["total_amount"] else None
                        result["products_processed"] = data[0]["products_processed"]
                        result["discount_applied"] = float(data[0]["discount_applied"]) if data[0]["discount_applied"] else None
                    
                    elif 'OrderID' in columns and 'CustomerName' in columns:
                        # Record set del encabezado del pedido
                        result["order_header"] = data
                    
                    elif 'ProductName' in columns:
                        # Record set de detalles de productos
                        result["order_details"] = data
                
                # Intentar avanzar al siguiente record set
                if not cursor.nextset():
                    break
            
            cursor.close()
            
        except pyodbc.Error as e:
            # =====================================================
            # CAPTURAR EXCEPCIONES (RAISERROR)
            # =====================================================
            result["error"] = str(e)
            result["return_code"] = -4  # Error general
            
            # Extraer código de error SQL Server
            if hasattr(e, 'args') and len(e.args) > 0:
                error_msg = e.args[0]
                if isinstance(error_msg, str):
                    result["error"] = error_msg
        
        return result
    
    def _handle_print_message(self, value):
        """Manejador para capturar mensajes PRINT del servidor."""
        # Esta función se llama por pyodbc cuando hay mensajes PRINT
        # En pyodbc, los mensajes PRINT se manejan a través de eventos
        return value
    
    def display_result(self, result: dict):
        """
        Muestra los resultados de la ejecución del procedimiento de forma legible.
        
        Args:
            result: Diccionario retornado por process_order()
        """
        print("\n" + "=" * 70)
        print("RESULTADOS DE LA EJECUCIÓN DEL PROCEDIMIENTO")
        print("=" * 70)
        
        # =====================================================
        # 1. CÓDIGO DE RETORNO (RETURN)
        # =====================================================
        print(f"\n1. CÓDIGO DE RETORNO (RETURN): {result['return_code']}")
        
        return_codes = {
            0: "✓ Operación exitosa",
            -1: "✗ Error: Cliente no encontrado",
            -2: "✗ Error: Empleado no encontrado",
            -3: "✗ Error: Producto no disponible o sin stock",
            -4: "✗ Error: Error general en la transacción"
        }
        
        status = return_codes.get(result['return_code'], "✗ Error desconocido")
        print(f"   Estado: {status}")
        
        # =====================================================
        # 2. PARÁMETROS OUTPUT
        # =====================================================
        print(f"\n2. PARÁMETROS OUTPUT:")
        print(f"   - Order ID: {result['order_id']}")
        print(f"   - Total Amount: ${result['total_amount']:.2f}" if result['total_amount'] else "   - Total Amount: N/A")
        print(f"   - Products Processed: {result['products_processed']}")
        print(f"   - Discount Applied: ${result['discount_applied']:.2f}" if result['discount_applied'] else "   - Discount Applied: N/A")
        
        # =====================================================
        # 3. EXCEPCIONES (ERROR si existe)
        # =====================================================
        if result['error']:
            print(f"\n3. EXCEPCIÓN CAPTURADA (RAISERROR):")
            print(f"   {result['error']}")
        
        # =====================================================
        # 4. RECORD SET 1: Encabezado del Pedido
        # =====================================================
        if result['order_header']:
            print(f"\n4. RECORD SET 1 - ENCABEZADO DEL PEDIDO:")
            header = result['order_header'][0]
            print(f"   Order ID: {header.get('OrderID')}")
            print(f"   Customer: {header.get('CustomerName')}")
            print(f"   Employee: {header.get('EmployeeName')}")
            print(f"   Order Date: {header.get('OrderDate')}")
            print(f"   Required Date: {header.get('RequiredDate')}")
            print(f"   Shipper: {header.get('ShipperName')}")
            print(f"   Freight: ${float(header.get('Freight', 0)):.2f}")
            print(f"   Subtotal: ${float(header.get('Subtotal', 0)):.2f}")
            print(f"   Discount: ${float(header.get('TotalDiscount', 0)):.2f}")
            print(f"   Grand Total: ${float(header.get('GrandTotal', 0)):.2f}")
        
        # =====================================================
        # 5. RECORD SET 2: Detalles de Productos
        # =====================================================
        if result['order_details']:
            print(f"\n5. RECORD SET 2 - DETALLES DE PRODUCTOS:")
            print(f"   {'ID':<6} {'Producto':<30} {'Precio':<10} {'Cant.':<6} {'Desc.':<8} {'Total':<10}")
            print(f"   {'-'*6} {'-'*30} {'-'*10} {'-'*6} {'-'*8} {'-'*10}")
            
            for item in result['order_details']:
                print(f"   {item.get('ProductID'):<6} "
                      f"{item.get('ProductName', '')[:30]:<30} "
                      f"${float(item.get('UnitPrice', 0)):<9.2f} "
                      f"{item.get('Quantity'):<6} "
                      f"{float(item.get('Discount', 0))*100:<7.1f}% "
                      f"${float(item.get('Total', 0)):<9.2f}")
        
        print("\n" + "=" * 70 + "\n")


def ejemplo_ejecucion_exitosa():
    """Ejemplo 1: Ejecución exitosa del procedimiento."""
    print("\n╔══════════════════════════════════════════════════════════╗")
    print("║  EJEMPLO 1: Ejecución Exitosa                           ║")
    print("╚══════════════════════════════════════════════════════════╝")
    
    # Crear instancia del procesador
    processor = NorthwindOrderProcessor(
        server="localhost",  # Cambiar según tu servidor
        # Para autenticación SQL Server, descomentar:
        username="sa",
        password="Gestion8.0"
    )
    
    if processor.connect():
        # Ejecutar procedimiento
        result = processor.process_order(
            customer_id="ALFKI",        # Alfreds Futterkiste
            employee_id=5,              # Steven Buchanan
            ship_via=1,                 # Speedy Express
            required_days=7,
            apply_discount=True         # Aplicar descuento del 10%
        )
        
        # Mostrar resultados
        processor.display_result(result)
        
        processor.disconnect()


def ejemplo_cliente_inexistente():
    """Ejemplo 2: Error - Cliente no existe."""
    print("\n╔══════════════════════════════════════════════════════════╗")
    print("║  EJEMPLO 2: Error - Cliente No Existe                   ║")
    print("╚══════════════════════════════════════════════════════════╝")
    
    processor = NorthwindOrderProcessor(server="localhost")
    
    if processor.connect():
        result = processor.process_order(
            customer_id="XXXXX",        # Cliente inexistente
            employee_id=5,
            ship_via=1,
            required_days=7,
            apply_discount=False
        )
        
        processor.display_result(result)
        processor.disconnect()


def ejemplo_empleado_inexistente():
    """Ejemplo 3: Error - Empleado no existe."""
    print("\n╔══════════════════════════════════════════════════════════╗")
    print("║  EJEMPLO 3: Error - Empleado No Existe                  ║")
    print("╚══════════════════════════════════════════════════════════╝")
    
    processor = NorthwindOrderProcessor(
        server="localhost",  # Cambiar según tu servidor
        # Para autenticación SQL Server, descomentar:
        username="sa",
        password="Gestion8.0"
    )
        
    if processor.connect():
        result = processor.process_order(
            customer_id="ALFKI",
            employee_id=9999,           # Empleado inexistente
            ship_via=1,
            required_days=7,
            apply_discount=False
        )
        
        processor.display_result(result)
        processor.disconnect()


def ejemplo_interactivo():
    """Ejemplo 4: Ejecución interactiva con input del usuario."""
    print("\n╔══════════════════════════════════════════════════════════╗")
    print("║  EJEMPLO 4: Ejecución Interactiva                       ║")
    print("╚══════════════════════════════════════════════════════════╝\n")
    
    # Solicitar datos de conexión
    server = input("Servidor SQL Server [localhost]: ").strip() or "localhost"
    use_sql_auth = input("¿Usar autenticación SQL Server? (s/n) [n]: ").strip().lower() == 's'
    
    username = None
    password = None
    
    if use_sql_auth:
        username = input("Usuario: ").strip()
        password = input("Contraseña: ").strip()
    
    # Solicitar parámetros del pedido
    print("\n--- Parámetros del Pedido ---")
    customer_id = input("Customer ID [ALFKI]: ").strip() or "ALFKI"
    employee_id = int(input("Employee ID [5]: ").strip() or "5")
    ship_via = int(input("Shipper ID [1]: ").strip() or "1")
    required_days = int(input("Días para entrega [7]: ").strip() or "7")
    apply_discount = input("¿Aplicar descuento 10%? (s/n) [n]: ").strip().lower() == 's'
    
    # Ejecutar
    processor = NorthwindOrderProcessor(server, username=username, password=password)
    
    if processor.connect():
        result = processor.process_order(
            customer_id=customer_id,
            employee_id=employee_id,
            ship_via=ship_via,
            required_days=required_days,
            apply_discount=apply_discount
        )
        
        processor.display_result(result)
        processor.disconnect()


def listar_clientes_disponibles():
    """Función auxiliar: Listar clientes disponibles."""
    print("\n╔══════════════════════════════════════════════════════════╗")
    print("║  Listado de Clientes Disponibles                        ║")
    print("╚══════════════════════════════════════════════════════════╝\n")
    
    processor = NorthwindOrderProcessor(server="localhost")
    
    if processor.connect():
        try:
            cursor = processor.connection.cursor()
            cursor.execute("""
                SELECT TOP 10 CustomerID, CompanyName, City, Country
                FROM Customers
                ORDER BY CustomerID
            """)
            
            print(f"{'ID':<8} {'Compañía':<40} {'Ciudad':<20} {'País'}")
            print(f"{'-'*8} {'-'*40} {'-'*20} {'-'*15}")
            
            for row in cursor.fetchall():
                print(f"{row.CustomerID:<8} {row.CompanyName:<40} {row.City:<20} {row.Country}")
            
            cursor.close()
        except Exception as e:
            print(f"Error al listar clientes: {e}")
        
        processor.disconnect()


def main():
    """Función principal del script."""
    print("""
    ╔══════════════════════════════════════════════════════════╗
    ║    Ejecutor de Stored Procedure - Northwind Database    ║
    ║             Procedimiento: usp_ProcessCustomerOrder      ║
    ╚══════════════════════════════════════════════════════════╝
    
    Este script demuestra cómo ejecutar un procedimiento almacenado
    de SQL Server desde Python y capturar:
    
    1. Parámetros OUTPUT
    2. Código de retorno (RETURN)
    3. Excepciones (RAISERROR / TRY...CATCH)
    4. Múltiples Record Sets
    
    Requisitos:
    - pyodbc instalado: pip install pyodbc
    - SQL Server con base de datos Northwind
    - Procedimiento usp_ProcessCustomerOrder creado
    """)
    
    while True:
        print("\nSeleccione una opción:")
        print("1. Ejecución exitosa (con descuento)")
        print("2. Error: Cliente inexistente")
        print("3. Error: Empleado inexistente")
        print("4. Ejecución interactiva")
        print("5. Listar clientes disponibles")
        print("0. Salir")
        
        opcion = input("\nOpción: ").strip()
        
        if opcion == "1":
            ejemplo_ejecucion_exitosa()
        elif opcion == "2":
            ejemplo_cliente_inexistente()
        elif opcion == "3":
            ejemplo_empleado_inexistente()
        elif opcion == "4":
            ejemplo_interactivo()
        elif opcion == "5":
            listar_clientes_disponibles()
        elif opcion == "0":
            print("\n¡Hasta luego!")
            break
        else:
            print("\n✗ Opción inválida")


if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
        print("\n\n✗ Ejecución interrumpida por el usuario")
    except Exception as e:
        print(f"\n✗ Error no manejado: {e}")
        import traceback
        traceback.print_exc()
