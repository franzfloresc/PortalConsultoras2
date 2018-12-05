if Exists (select 1 from sys.objects where type = 'P' and name = 'GetPremiosElectivos')
	drop procedure GetPremiosElectivos

GO

CREATE PROC GetPremiosElectivos
(
@CampaniaID int,
@CodigoPrograma varchar(10)
)
AS
BEGIN
	SET NOCOUNT ON;
	SELECT
		e.EstrategiaID				,
		e.TipoEstrategiaID			,
		e.CampaniaID				,
		e.CampaniaIDFin				,
		e.NumeroPedido				,
		e.Activo					,
		e.ImagenURL					,
		e.LimiteVenta				,
		e.DescripcionCUV2			,
		e.FlagDescripcion			,
		e.CUV						,
		e.EtiquetaID				,
		e.Precio					,
		e.FlagCEP					,
		e.CUV2						,
		e.EtiquetaID2				,
		e.Precio2					,
		e.FlagCEP2					,
		e.TextoLibre				,
		e.FlagTextoLibre			,
		e.Cantidad					,
		e.FlagCantidad				,
		e.Zona						,
		e.Limite					,
		e.Orden						,
		e.UsuarioCreacion			,
		e.FechaCreacion				,
		e.UsuarioModificacion		,
		e.FechaModificacion			,
		e.ColorFondo				,
		e.FlagEstrella				,
		1 AS FlagNueva				,
		e.CodigoEstrategia			,
		e.TieneVariedad				,
		e.EsOfertaIndependiente		,
		e.PrecioPublico				,
		e.Ganancia					,
		e.CodigoPrograma			,
		e.FlagImagenURL				,
		e.CodigoConcurso			,
		e.ImagenMiniaturaURL		,
		e.EsSubCampania				,
		e.OfertaShowRoomID			,
		e.Niveles					,
		c.INC_CUPO_ELEC_DEFA		,
		m.Descripcion AS DescripcionMarca
	FROM ods.CuponesProgramaNuevas c With(nolock)
	inner join dbo.Estrategia e  With(nolock) on c.CodigoCupon = e.CUV2 and c.CodigoPrograma = e.CodigoPrograma
	LEFT JOIN ods.Campania ca with(nolock) ON @CampaniaID = ca.Codigo
	LEFT join ods.ProductoComercial pc with(nolock) ON ca.CampaniaID = pc.CampaniaID AND e.CUV2 = pc.CUV
	LEFT JOIN dbo.Marca m WITH (NOLOCK) ON pc.MarcaId = m.MarcaId

	where e.activo = 1
		and isnull(c.Campana,'') != ''
		and c.CodigoPrograma = @CodigoPrograma 
		and e.campaniaid <= @CampaniaID and e.campaniaidfin >= @CampaniaID 
		and c.Campana = cast(@CampaniaID as varchar(6))
		and c.PrecioUnitario = 0
		and c.IND_CUPO_ELEC = 1

END
