-- procedures.sql
-- Plantilla de stored procedures, funciones y triggers para Zaboo Mazoo (SQL Server)
USE IndiceTestDB;
GO

-- Función: calcular edad de animal en años (simple)
CREATE FUNCTION zoo.fn_calcula_edad(@fecha_nac DATE)
RETURNS INT
AS
BEGIN
  RETURN DATEDIFF(year, @fecha_nac, GETDATE());
END;
GO

-- Procedimiento: registrar entrada
CREATE PROCEDURE zoo.sp_registrar_entrada
  @visitante_id INT,
  @tipo VARCHAR(50),
  @precio DECIMAL(10,2)
AS
BEGIN
  SET NOCOUNT ON;
  BEGIN TRY
    INSERT INTO zoo.entrada (visitante_id, tipo, precio)
    VALUES (@visitante_id, @tipo, @precio);
    SELECT SCOPE_IDENTITY() AS entrada_id;
  END TRY
  BEGIN CATCH
    SELECT ERROR_MESSAGE() AS error;
  END CATCH
END;
GO

-- Trigger: auditoría simple para INSERT en zoo.animal
CREATE TRIGGER audit_animal_insert
ON zoo.animal
AFTER INSERT
AS
BEGIN
  INSERT INTO audit.auditoria (schema_name, table_name, operacion, usuario, detalle)
  SELECT 'zoo', 'animal', 'INSERT', SUSER_SNAME(), CONCAT('Inserted IDs: ', STRING_AGG(CAST(id AS NVARCHAR(20)), ','))
  FROM inserted;
END;
GO

PRINT 'Procedures, functions and basic trigger created (review and adapt error handling).';
