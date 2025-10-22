# Consultas básicas (Taller de BD)


## 1. Sintaxis básica de SELECT

SELECT [ALL | DISTINCT] [TOP n] <select_list>
FROM <table_source>[, ...]
[WHERE <search_condition>]
[GROUP BY ...] [HAVING ...]
[ORDER BY ...]

- `SELECT` especifica las columnas a recuperar (select_list).
- `FROM` especifica la tabla(s) origen.
- `WHERE` especifica la condición para filtrar filas.
- `DISTINCT` elimina duplicados.
- `TOP n` (T-SQL) limita el número de filas.

Ejemplo: recuperar todos los empleados
```sql
USE northwind;
SELECT *
FROM employees;
```

> Nota: `*` devuelve todas las columnas en el orden definido por la tabla.

---

## 2. Selección de columnas

En la mayoría de los casos conviene seleccionar sólo las columnas necesarias.

```sql
USE northwind;
SELECT employeeid, lastname, firstname, title
FROM employees;
```

Esto reduce I/O y hace más claro el propósito de la consulta.

---

## 3. Filtrado de filas: la cláusula WHERE

Operadores comunes:
- Comparación: `=`, `<>`, `<`, `>`, `<=`, `>=`
- Lógicos: `AND`, `OR`, `NOT`
- Rango: `BETWEEN ... AND ...`
- Lista: `IN (...)`
- NULL check: `IS NULL`, `IS NOT NULL`

Ejemplo: recuperar empleado con id=5
```sql
USE northwind;
SELECT employeeid, lastname, firstname, title
FROM employees
WHERE employeeid = 5;
```

---

## 4. Predicado LIKE (comparación de cadenas)

`LIKE` permite búsquedas basadas en patrones con comodines:
- `%` — cualquier cadena (incluye cadena vacía en algunos SGBD)
- `_` — un único carácter
- `[abc]` — cualquier carácter del conjunto

Ejemplos:
```sql
-- nombres que contienen 'BOOK'
USE pubs;
SELECT store_name
FROM stores
WHERE store_name LIKE '%BOOK%';

-- empieza con 'BR'
WHERE name LIKE 'BR%';

-- termina con 'een'
WHERE name LIKE '%een';

-- contiene 'en'
WHERE name LIKE '%en%';

-- inicia con C o K
WHERE name LIKE '[CK]%';
```

> Nota: el comportamiento de clases (`[ ]`) y sensibilidades de mayúsculas/minúsculas dependen del collation y del SGBD.

---

## 5. Operadores lógicos y precedencia

Usa paréntesis para dejar explícita la precedencia entre `AND` y `OR`.

```sql
USE northwind;
SELECT productid, productname, supplierid, unitprice
FROM products
WHERE (productname LIKE 'T%' OR productid = 46)
  AND (unitprice > 16.00);
```

---

## 6. Rangos y listas

`BETWEEN a AND b` es inclusivo en la mayoría de SGBD.

```sql
SELECT productname, unitprice
FROM products
WHERE unitprice BETWEEN 10 AND 20;

SELECT companyname, country
FROM suppliers
WHERE country IN ('Japan','Italy');
```

---

## 7. Valores NULL

Para consultar valores desconocidos o ausentes:

```sql
SELECT companyname, fax
FROM suppliers
WHERE fax IS NULL;
```

Evita `= NULL`; siempre usar `IS NULL` o `IS NOT NULL`.

---

## 8. Ordenamiento y DISTINCT

`ORDER BY` permite ordenar resultados por una o más columnas.

```sql
SELECT productid, productname, categoryid, unitprice
FROM products
ORDER BY categoryid, unitprice DESC;
```

`DISTINCT` elimina duplicados en la combinación de columnas del select:

```sql
SELECT DISTINCT country
FROM suppliers
ORDER BY country;
```

---

## 9. Alias de columna y literales

- Los alias hacen las columnas más legibles en el output.

```sql
SELECT firstname AS First, lastname AS Last, employeeid AS [Employee ID]
FROM employees;

SELECT firstname, lastname, 'Identification number:', employeeid
FROM employees;
```

- En T-SQL los alias entre corchetes o comillas simples según SGBD.

---

## 10. Insertar datos (INSERT)

Sintaxis básica:
```sql
INSERT INTO table_name (col1, col2, ...)
VALUES (val1, val2, ...);
```

Ejemplo:
```sql
USE northwind;
INSERT INTO customers (customerid, companyname, contactname, contacttitle,
    address, city, region, postalcode, country, phone, fax)
VALUES ('PECOF','Pecos Coffee Company','Michael Dunn','Owner',
    '1900 Oak Street','Vancouver','BC','V3F 2K1','Canada','(604) 555-3392','(604) 555-7293');
```

- Se puede usar `DEFAULT` para insertar el valor por defecto de una columna.

```sql
INSERT INTO shippers (companyname, phone)
VALUES ('Kenya Coffee Co.', DEFAULT);
```

- Inserciones parciales: especificar sólo las columnas deseadas; las demás tomarán `DEFAULT` o `NULL`.

```sql
INSERT INTO shippers (companyname)
VALUES ('Fitch & Mather');
```

---

## 11. Eliminar filas (DELETE) y TRUNCATE

- `DELETE FROM table WHERE condition;` elimina filas y registra cada fila en el log.
- `TRUNCATE TABLE table;` elimina todos los registros rápidamente; en muchos SGBD no registra fila por fila y puede resetear identidades.

Siempre incluir `WHERE` con `DELETE` para evitar borrar toda la tabla por error.

Ejemplo:
```sql
USE pubs;
DELETE FROM authors WHERE title = 'Lenguaje C';
```

---

## 12. Actualizar filas (UPDATE)

Sintaxis:
```sql
UPDATE table_name
SET column1 = value1, column2 = value2
WHERE <condition>;
```

Ejemplos:
```sql
USE pubs;
UPDATE discount
SET discount = discount + 0.10
WHERE lowqty >= 100;

UPDATE authors
SET phone = '203 987-6543'
WHERE au_id = '123-45-6789';

USE northwind;
UPDATE products
SET unitprice = unitprice * 1.1;
```

> Nota: sin cláusula `WHERE`, el `UPDATE` afectará a todas las filas de la tabla.

---

## 13. Buenas prácticas y notas pedagógicas

- Seleccionar sólo las columnas necesarias para reducir I/O.
- Usar parámetros o consultas preparadas para evitar SQL injection.
- Documentar las consultas complejas con comentarios.
- Probar `DELETE` y `UPDATE` con una transacción o con `SELECT` previo para confirmar filas afectadas:

```sql
BEGIN TRANSACTION;
UPDATE ... WHERE ...;
-- verificar resultados
ROLLBACK; -- o COMMIT;
```

- Para performance: usa índices en columnas utilizadas frecuentemente en `WHERE`, `JOIN` y `ORDER BY`.

---

## 14. Ejercicios propuestos

1. Recupera los `productname` cuyo precio (`unitprice`) esté entre 20 y 50, ordenados por precio descendente.
2. Lista los `companyname` de proveedores (`suppliers`) que están en 'Japan' o 'Italy'.
3. Inserta un nuevo `shipper` llamado 'ACME Logistics' y luego verifica que aparece en la tabla.
4. Actualiza el `unitprice` de todos los productos de la categoría 1 aumentando 15%.
5. Intenta borrar un `supplier` que tenga productos asociados y documenta el resultado (si falla, explica por qué).
6. Crea una consulta que muestre el `firstname` y `lastname` de empleados con un alias y añada una columna literal 'Office' seguido del `city`.

---

## 15. Respuestas (guía corta)

1. 
```sql
SELECT productname, unitprice
FROM products
WHERE unitprice BETWEEN 20 AND 50
ORDER BY unitprice DESC;
```

2.
```sql
SELECT companyname, country
FROM suppliers
WHERE country IN ('Japan','Italy');
```

3.
```sql
INSERT INTO shippers (companyname) VALUES ('ACME Logistics');
SELECT * FROM shippers WHERE companyname = 'ACME Logistics';
```

4.
```sql
UPDATE products
SET unitprice = unitprice * 1.15
WHERE categoryid = 1;
```

5. Depende de las restricciones; si existen `FOREIGN KEY` que impiden la eliminación, el `DELETE` fallará a menos que se use `CASCADE`.

6.
```sql
SELECT firstname AS First, lastname AS Last, 'Office: ' + city AS Office
FROM employees;
```

---

## 16. Referencias y recursos

- Documentación oficial de SQL Server, MySQL y PostgreSQL
- Ejemplos provistos por las bases de datos `Northwind` y `Pubs`

---

Si quieres, genero una versión con ejemplos adaptados a MySQL y PostgreSQL (sintaxis `LIMIT`/`OFFSET`, concatenación de cadenas, funciones de fecha) o un PDF listo para imprimir. ¿Cuál prefieres?
