GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetProductoComercialByCampaniaAndCuv' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetProductoComercialByCampaniaAndCuv
END
GO
CREATE PROCEDURE dbo.GetProductoComercialByCampaniaAndCuv
	@CampaniaID int,
	@CUV varchar(50),
	@RowCount int
AS
BEGIN
	select top(@RowCount)
		p.CUV,
		p.Descripcion
	from ods.ProductoComercial p
	where p.AnoCampania = @CampaniaID and charindex(@CUV, p.CUV) > 0;
END
GO