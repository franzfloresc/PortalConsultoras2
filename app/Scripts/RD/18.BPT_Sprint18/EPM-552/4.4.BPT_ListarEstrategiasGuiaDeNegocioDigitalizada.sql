GO
ALTER PROCEDURE [dbo].[ListarEstrategiasGuiaDeNegocioDigitalizada]
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(30)
AS
/*
dbo.ListarEstrategiasGuiaDeNegocioDigitalizada 201710, ''
*/
BEGIN
SET NOCOUNT ON;

	declare @CodigoRegion varchar(2) = null
	, @CodigoZona varchar(4) = null
	, @ZonaID VARCHAR(20) = ''

	SELECT
		@CodigoRegion = r.Codigo,
		@CodigoZona = z.Codigo,
		@ZonaID = c.ZonaID
	FROM ods.Consultora c with(nolock)
		INNER JOIN ods.Region r with(nolock) on r.RegionID = c.RegionID
		INNER JOIN ods.Zona z with(nolock) on z.ZonaID = c.ZonaID
	where c.Codigo = @CodigoConsultora

	
	-- Obtener estrategias de recomendadas para ti.
	declare @tablaCuvFaltante table (CUV varchar(6))
	insert into @tablaCuvFaltante
	select distinct ltrim(rtrim(CUV))
	from dbo.ProductoFaltante with(nolock)
	where CampaniaID = @CampaniaID and Zonaid = @ZonaID
	UNION ALL
	select distinct ltrim(rtrim(fa.CodigoVenta)) AS CUV
	from ods.FaltanteAnunciado fa with(nolock)
		inner join ods.Campania c  with(nolock) on
		fa.CampaniaID = c.CampaniaID
	where
		c.Codigo = @CampaniaID
		and (rtrim(fa.CodigoRegion) = @CodigoRegion or fa.CodigoRegion IS NULL)
		and (rtrim(fa.CodigoZona) = @CodigoZona or fa.CodigoZona IS NULL)
		
		DECLARE @codConsultoraDefault VARCHAR(9)

		SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001
	
		SELECT distinct
			EstrategiaID,
			CUV2,
			DescripcionCUV2,
			dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
			e.Precio,
			dbo.ObtenerDescripcionEtiqueta(EtiquetaID2) EtiquetaDescripcion2,
			Precio2,
			isnull(TextoLibre,'') as TextoLibre,	
			FlagEstrella,
			ColorFondo,
			e.TipoEstrategiaID,
			e.ImagenURL FotoProducto01,
			te.ImagenEstrategia ImagenURL,
			e.LimiteVenta,    
			pc.MarcaID,
			te.Orden Orden1,
			op.Orden Orden2,
			pc.IndicadorMontoMinimo,
			pc.CodigoProducto,
			0 AS FlagNueva,
			'' as TipoTallaColor,
			3 as TipoEstrategiaImagenMostrar
			, E.EtiquetaID
			, E.EtiquetaID2
			, E.CodigoEstrategia
			, E.TieneVariedad
			, TE.CODIGO
			, TE.DescripcionEstrategia
			, ISNULL(TE.FlagMostrarImg,0) AS FlagMostrarImg	
			, E.PrecioPublico
			, E.Ganancia
			, M.Descripcion as DescripcionMarca
		FROM Estrategia E with(nolock)
		INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON 
			op.CodConsultora = @codConsultoraDefault  
			and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
			and op.TipoPersonalizacion = 'GND'
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID and TE.Codigo = '010'
		LEFT JOIN Marca M with(nolock) ON M.MarcaId = pc.MarcaID
		WHERE
			E.Activo = 1
			AND ca.Codigo = @CampaniaID
			AND TE.FlagActivo = 1
			AND TE.flagRecoPerfil = 1
			AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
		ORDER BY
			te.Orden ASC, CASE WHEN ISNULL(op.Orden,0) = 0 THEN te.Orden ELSE op.Orden END ASC, E.EstrategiaID ASC


SET NOCOUNT OFF
END

GO