GO
IF EXISTS(select 1 from sys.objects where type = 'P' and name = 'GetProductosProgramaNuevas')
BEGIN
	DROP PROC GetProductosProgramaNuevas 
END
GO
CREATE PROC GetProductosProgramaNuevas 
(
@CampaniaID int
)
AS
BEGIN
	SELECT 
		CodigoPrograma,
		Campana,
		isnull(CodigoNivel,'') as CodigoNivel,
		isnull(CodigoCupon,'') as CodigoCupon,
		isnull(CodigoVenta,'') as CodigoVenta,
		isnull(DescripcionProducto,'') as DescripcionProducto,
		isnull(UnidadesMaximas,0) as UnidadesMaximas,
		isnull(IndicadorKit,0) as IndicadorKit,
		isnull(IndicadorCuponIndependiente,0) as IndicadorCuponIndependiente,
		isnull(PrecioUnitario,0) as PrecioUnitario,
		isnull(NumeroCampanasVigentes,0) as NumeroCampanasVigentes
	FROM ods.CuponesProgramaNuevas With(nolock)
	Where isnull(Campana,'') != ''
	and isnull(CodigoPrograma,'') != ''
	and Campana = cast(@CampaniaID as varchar(6))
END
GO