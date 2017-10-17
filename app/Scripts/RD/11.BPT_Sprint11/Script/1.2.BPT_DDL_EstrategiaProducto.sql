
GO
IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[EstrategiaProducto]') 
         AND name = 'FactorCuadre'
)
BEGIN
	ALTER TABLE EstrategiaProducto
	ADD FactorCuadre int;
END
GO