# Indices - Scripts de prueba (SQL Server)

Este directorio contiene un script T-SQL de ejemplo para probar índices en SQL Server.

Archivos:
- `indices_sqlserver_examples.sql` — crea una base de datos de pruebas (`IndiceTestDB`), tablas de ejemplo, inserta datos, crea índices (clustered, nonclustered, unique), mide fragmentación y ejecuta REBUILD/REORGANIZE.

Instrucciones rápidas:

1. Abrir SQL Server Management Studio (SSMS) y conectarse a la instancia.
2. Copiar/abrir `indices_sqlserver_examples.sql`.
3. Ejecutar todo el script (F5). El script crea y usa la base de datos `IndiceTestDB`.

Ejecutar con `sqlcmd` (ejemplo):

```bash
sqlcmd -S localhost -U sa -P '<tu_password>' -i indices_sqlserver_examples.sql
```

Notas:
- El script eliminará `IndiceTestDB` si existe (para asegurar un entorno limpio). Cámbialo si necesitas conservar datos.
- Ejecuta primero en un entorno de desarrollo o staging.
- El script puede tardar unos minutos dependiendo del hardware por la cantidad de filas insertadas y las operaciones de rebuild.
