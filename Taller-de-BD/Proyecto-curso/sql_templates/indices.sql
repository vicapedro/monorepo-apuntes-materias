-- indices.sql
-- Índices iniciales sugeridos para Zaboo Mazoo (SQL Server)

USE IndiceTestDB;
GO

-- Índice clustered por defecto ya creado en PK de cada tabla (identity)
-- Índices nonclustered para consultas frecuentes
CREATE NONCLUSTERED INDEX ix_producto_sku ON store.producto(sku);
CREATE NONCLUSTERED INDEX ix_animal_especie ON zoo.animal(especie_id);
CREATE NONCLUSTERED INDEX ix_animal_habitat ON zoo.animal(habitat_id);
CREATE NONCLUSTERED INDEX ix_entrada_fecha ON zoo.entrada(fecha);
CREATE NONCLUSTERED INDEX ix_registro_vet_animal ON zoo.registro_vet(animal_id);

-- Índice cubriente ejemplo
CREATE NONCLUSTERED INDEX ix_venta_producto_fecha ON store.venta(producto_id)
INCLUDE (fecha, cantidad);

PRINT 'Índices creados (revisa fillfactor si es necesario)';
