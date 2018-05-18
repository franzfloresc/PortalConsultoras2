GO
if exists (select 1 from sys.objects where type = 'P' and name = 'GetProductoExclusivos')
BEGIN
	DROP PROC GetProductoExclusivos
END
GO
CREATE PROC GetProductoExclusivos
(
@CampaniaID int
)
AS
BEGIN
	select 
		Cuv
	from
	ods.ProductoExclusivo with(nolock)
	where Campania = @CampaniaID
END
GO