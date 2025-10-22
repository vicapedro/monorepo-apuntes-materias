# Northwind

La base de datos Northwind modela una empresa ficticia de importación y distribución de alimentos gourmet. Opera en un esquema B2B: compra productos a proveedores internacionales, mantiene un catálogo por categorías y vende a clientes (tiendas y mayoristas) mediante pedidos que son atendidos por representantes de ventas y enviados a través de transportistas.

Modelo de datos principal
- Customers: clientes empresariales con datos de contacto y direcciones de envío.
- Orders: pedidos con fechas (orden, requerida, envío), dirección de envío y transportista (ShipVia).
- Order Details: líneas de pedido con ProductID, UnitPrice, Quantity y Discount.
- Products: catálogo con precios, existencias, SupplierID y CategoryID.
- Categories: clasificación de productos.
- Suppliers: proveedores internacionales.
- Shippers: transportistas.
- Employees: representantes de ventas con estructura jerárquica (ReportsTo).
- Territories y Regions: asignación geográfica de ventas.

Relaciones clave
- Customers 1—N Orders.
- Orders 1—N Order Details.
- Products 1—N Order Details; Products N—1 Suppliers; Products N—1 Categories.
- Employees 1—N Orders; Employees N—N Territories (vía una tabla puente).
- Orders N—1 Shippers.

Reglas/consideraciones típicas
- Importe de línea: UnitPrice × Quantity × (1 − Discount).
- Total de pedido: suma de importes de línea.
- Descuento por línea en [0, 1].
- Un pedido enviado tiene ShippedDate no nula.
- El stock de Products puede controlarse al confirmar pedidos.

Escenarios de práctica (DML)
- SELECT y JOINs: ventas por cliente, por categoría, por empleado; top productos; pedidos pendientes.
- Agregaciones: totales mensuales, promedio de descuento, ticket promedio por cliente.
- Subconsultas/CTEs: clientes sin pedidos en el último año; productos sin ventas; reorden por bajo stock.
- INSERT: alta de clientes/proveedores/productos; creación de un pedido con sus detalles.
- UPDATE: cambio de transportista antes del envío; actualización de descuentos o precios; ajuste de stock.
- DELETE: eliminación de líneas de pedido; depuración de productos sin ventas (respetando FK).
- Transacciones: crear pedido + detalles y revertir si falta stock.
- Vistas y funciones: vista de ventas por región; función para total de pedido.

Preguntas guía
- ¿Qué clientes generan mayor ingreso y en qué periodos?
- ¿Qué categorías aportan más margen?
- ¿Qué empleado y región tienen mejor desempeño?
- ¿Qué transportista presenta mayores tiempos entre OrderDate y ShippedDate?

Esta descripción permite contextualizar consultas y operaciones DML en un caso realista y completo.
