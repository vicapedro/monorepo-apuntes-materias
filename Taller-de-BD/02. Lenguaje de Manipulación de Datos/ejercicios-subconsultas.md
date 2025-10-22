# Ejercicios: Subconsultas (Northwind)

Resuelva las siguientes necesidades de información aplicando subconsultas en la base de datos `Northwind`. Para cada ejercicio indique la consulta SQL utilizada, explique brevemente la lógica y muestre el resultado esperado (o una muestra representativa).

---

1. Vendedores por debajo del promedio en junio de 1997

   - Enunciado: Obtenga los nombres de los vendedores (employees) cuya suma total de ventas durante el mes de **junio de 1997** está por debajo del promedio de ventas de todos los vendedores en ese mismo mes.

2. Vendedores con órdenes el 11 de marzo de 1998

   - Enunciado: Obtenga los nombres de los vendedores que registraron al menos una orden en la fecha **1998-03-11**.

3. Vendedores en el día de mayor venta

   - Enunciado: Identifique la fecha en la que se registró el **mayor monto total de ventas** y devuelva los nombres de los vendedores que realizaron órdenes en esa fecha.

4. Vendedores y clientes en la misma ciudad

   - Enunciado: Obtenga los nombres de los vendedores que **viven en la misma ciudad** que al menos uno de sus clientes a los que les han vendido al menos una vez.

5. Producto más caro por proveedor

   - Enunciado: Para cada proveedor (`suppliers`), identifique el producto más caro que suministra y muestre el nombre del proveedor, el nombre del producto y su precio.
   - Requisito: Si un proveedor tiene varios productos con el mismo precio máximo, incluya todos.

6. Ciudades con más de dos clientes

   - Enunciado: Encuentre los nombres de las ciudades que tienen **más de dos clientes** registrados en la tabla `customers`.

Entregable: SQL y resultado.

---

### Instrucciones generales

- Use subconsultas donde corresponda (escalares, de lista o EXISTS) para resolver cada problema.
- Prefiera alias claros en tablas y subconsultas para mejorar la legibilidad.
- Incluya comentarios cortos en el SQL que expliquen cada paso.
- Entregue tanto la consulta como una breve explicación de la lógica.

