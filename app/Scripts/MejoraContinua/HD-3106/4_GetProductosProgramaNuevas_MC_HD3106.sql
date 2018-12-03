ALTER PROC GetProductosProgramaNuevas 
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
		isnull(NumeroCampanasVigentes,0) as NumeroCampanasVigentes,
		isnull(IND_CUPO_ELEC,0) as IND_CUPO_ELEC,
		isnull(INC_CUPO_ELEC_DEFA,0) as INC_CUPO_ELEC_DEFA
	FROM ods.CuponesProgramaNuevas With(nolock)
	Where isnull(Campana,'') != ''
	and isnull(CodigoPrograma,'') != ''
	and Campana = cast(@CampaniaID as varchar(6))
END