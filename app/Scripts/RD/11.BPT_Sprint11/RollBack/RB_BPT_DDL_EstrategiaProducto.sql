
IF EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[EstrategiaProducto]') 
         AND name = 'FactorCuadre'
)
begin

	ALTER TABLE EstrategiaProducto drop column FactorCuadre

end