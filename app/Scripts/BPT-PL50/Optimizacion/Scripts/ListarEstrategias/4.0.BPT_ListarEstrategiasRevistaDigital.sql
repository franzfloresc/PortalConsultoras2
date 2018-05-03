USE [BelcorpPeru_BPT]
GO

ALTER PROCEDURE [dbo].[ListarEstrategiasRevistaDigital]
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(30)
AS
BEGIN
SET NOCOUNT ON;
	
	declare @StrCampaniaID CHAR(6) = CONVERT(CHAR(6),@CampaniaID);
	declare @tablaCuvFaltante table( CUV varchar(6))

	insert into @tablaCuvFaltante(CUV)
	select CUV from [dbo].[ObtenerCuvFaltante](@CampaniaID,@CodigoConsultora)

	declare  @OfertasPersonalizadas table 
	(
		Orden int,
		CUV char(6),
		TipoPersonalizacion char(3),
		FlagRevista int,
		AnioCampanaVenta int
	)

	INSERT INTO @OfertasPersonalizadas
	select 
		isnull(Orden,0),CUV,TipoPersonalizacion,FlagRevista,convert(int,AnioCampanaVenta)
		from ods.OfertasPersonalizadas op with(nolock) where
	op.CodConsultora = @CodigoConsultora
	and op.AnioCampanaVenta = @StrCampaniaID
	and op.TipoPersonalizacion in ('OPM', 'PAD') 

	IF NOT EXISTS (SELECT CUV FROM @OfertasPersonalizadas) 
	BEGIN

		DECLARE @codConsultoraDefault VARCHAR(9)
		SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001

		INSERT INTO @OfertasPersonalizadas
		select isnull(Orden,0),CUV,TipoPersonalizacion,FlagRevista,convert(int,AnioCampanaVenta) from ods.OfertasPersonalizadas op with(nolock) where
		op.CodConsultora = @codConsultoraDefault
		and op.AnioCampanaVenta = @StrCampaniaID
		and op.TipoPersonalizacion in ('OPM', 'PAD')

	END
	
	SELECT
		EstrategiaID,
		CUV2,
		DescripcionCUV2,
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
		e.Precio,
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID2) EtiquetaDescripcion2,
		Precio2,
		TextoLibre,
		FlagEstrella,
		ColorFondo,
		e.TipoEstrategiaID,
		e.ImagenURL FotoProducto01,
		te.ImagenEstrategia ImagenURL,
		e.LimiteVenta,    
		pc.MarcaID,
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
		, TE.FlagMostrarImg AS FlagMostrarImg	
		, E.PrecioPublico
		, E.Ganancia
		, op.FlagRevista
	FROM Estrategia E with(nolock)
		INNER JOIN @OfertasPersonalizadas op ON E.CampaniaID = op.AnioCampanaVenta AND E.CUV2 = op.CUV
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
			AND TE.Codigo in ('007', '008')
		LEFT JOIN Marca M with(nolock) ON M.MarcaId = PC.MarcaId
	WHERE
		E.Activo = 1
		AND TE.FlagActivo = 1
		AND TE.flagRecoPerfil = 1
		AND NOT EXISTS(SELECT CUV FROM @tablaCuvFaltante TF WHERE E.CUV2 = TF.CUV)
	ORDER BY
		op.Orden ASC, EstrategiaID ASC

SET NOCOUNT OFF
END
