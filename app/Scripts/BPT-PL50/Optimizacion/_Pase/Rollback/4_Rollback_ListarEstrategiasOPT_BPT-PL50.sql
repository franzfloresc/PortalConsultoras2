GO
USE BelcorpPeru
GO
GO
ALTER PROCEDURE [dbo].[ListarEstrategiasOPT]
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(30)
AS
/*
dbo.ListarEstrategiasOPT 201710, ''
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

	CREATE TABLE #TEMPORAL (
		EstrategiaID int,
		CUV2 varchar(5),
		DescripcionCUV2 varchar(800),
		EtiquetaDescripcion varchar(8000),
		Precio numeric(12,2),
		EtiquetaDescripcion2 varchar(8000),
		Precio2 numeric(12,2),
		TextoLibre varchar(800),
		FlagEstrella bit,
		ColorFondo varchar(20),
		TipoEstrategiaID int,
		FotoProducto01 varchar(800),
		ImagenURL varchar(500),
		LimiteVenta int,
		MarcaID int,
		Orden1 int,
		Orden2 int,
		IndicadorMontoMinimo int,
		CodigoProducto varchar(12),
		FlagNueva int,
		TipoTallaColor varchar(50),
		TipoEstrategiaImagenMostrar	int,
		EtiquetaID int,
		EtiquetaID2 int,
		CodigoEstrategia varchar(100),
		TieneVariedad int,
		CODIGO varchar(100),
		DescripcionEstrategia varchar(200),
		FlagMostrarImg int,
		PrecioPublico decimal(18,2),
		Ganancia decimal(18,2)
	)
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

	INSERT INTO #TEMPORAL
	SELECT distinct
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
	FROM Estrategia E with(nolock)
		INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON
			op.CodConsultora = @CodigoConsultora
			and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
			and op.TipoPersonalizacion = 'OPT'
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
			AND TE.Codigo = '001'
	WHERE
		E.Activo = 1
		AND ca.Codigo = @CampaniaID
		AND TE.FlagActivo = 1
		AND TE.flagRecoPerfil = 1
		AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
	DECLARE @cont2 INT = 0
	SET @cont2 = (SELECT COUNT(EstrategiaID) FROM #TEMPORAL)

	IF (0 = @cont2)
	BEGIN
		DECLARE @codConsultoraDefault VARCHAR(9)

		SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001
		INSERT INTO #TEMPORAL
		SELECT distinct
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
		FROM Estrategia E with(nolock)
		INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON
			op.CodConsultora = @codConsultoraDefault
			and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
			and op.TipoPersonalizacion = 'OPT'
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
			AND TE.Codigo = '001'
		WHERE
			E.Activo = 1
			AND ca.Codigo = @CampaniaID
			AND TE.FlagActivo = 1
			AND TE.flagRecoPerfil = 1
			AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )

	END
	DECLARE @codConsultoraForzadas VARCHAR(9) = ''
	SELECT @codConsultoraForzadas = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10002

	INSERT INTO #TEMPORAL
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
	FROM Estrategia E with(nolock)
	INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON
	op.CodConsultora = @codConsultoraForzadas
	and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
	and op.TipoPersonalizacion = 'OPT'
	INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
	INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
	INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
	AND TE.Codigo = '001'
	WHERE
	E.Activo = 1
	AND ca.Codigo = @CampaniaID
	AND TE.FlagActivo = 1
	AND TE.flagRecoPerfil = 1
	AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
	SELECT * FROM (
	SELECT DISTINCT
		  T.EstrategiaID
		, T.CUV2
		, T.DescripcionCUV2
		, T.EtiquetaDescripcion
		, T.Precio
		, T.EtiquetaDescripcion2
		, T.Precio2
		, isnull(T.TextoLibre,'') as TextoLibre
		, T.FlagEstrella
		, T.ColorFondo
		, T.TipoEstrategiaID
		, T.FotoProducto01
		, T.ImagenURL
		, T.LimiteVenta
		, T.MarcaID
		, T.Orden1
		, T.Orden2
		, T.IndicadorMontoMinimo
		, T.FlagNueva
		, T.TipoTallaColor
		, T.TipoEstrategiaImagenMostrar
		, T.CodigoProducto
		, T.EtiquetaID
		, T.EtiquetaID2
		, T.CodigoEstrategia
		, T.TieneVariedad
		, T.CODIGO
		, T.DescripcionEstrategia
		, T.FlagMostrarImg
		, M.Descripcion as DescripcionMarca
		, 'NO DISPONIBLE' AS DescripcionCategoria
		, T.PrecioPublico
		, T.Ganancia
	FROM #TEMPORAL T
		LEFT JOIN Marca M with(nolock) ON M.MarcaId = T.MarcaId) T
	ORDER BY
		Orden1 ASC, CASE WHEN ISNULL(T.Orden2,0) = 0 THEN T.Orden1 ELSE T.Orden2 END ASC, EstrategiaID ASC

	DROP TABLE #TEMPORAL
SET NOCOUNT OFF
END
GO

GO
USE BelcorpMexico
GO
GO
ALTER PROCEDURE [dbo].[ListarEstrategiasOPT]
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(30)
AS
/*
dbo.ListarEstrategiasOPT 201710, ''
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

	CREATE TABLE #TEMPORAL (
		EstrategiaID int,
		CUV2 varchar(5),
		DescripcionCUV2 varchar(800),
		EtiquetaDescripcion varchar(8000),
		Precio numeric(12,2),
		EtiquetaDescripcion2 varchar(8000),
		Precio2 numeric(12,2),
		TextoLibre varchar(800),
		FlagEstrella bit,
		ColorFondo varchar(20),
		TipoEstrategiaID int,
		FotoProducto01 varchar(800),
		ImagenURL varchar(500),
		LimiteVenta int,
		MarcaID int,
		Orden1 int,
		Orden2 int,
		IndicadorMontoMinimo int,
		CodigoProducto varchar(12),
		FlagNueva int,
		TipoTallaColor varchar(50),
		TipoEstrategiaImagenMostrar	int,
		EtiquetaID int,
		EtiquetaID2 int,
		CodigoEstrategia varchar(100),
		TieneVariedad int,
		CODIGO varchar(100),
		DescripcionEstrategia varchar(200),
		FlagMostrarImg int,
		PrecioPublico decimal(18,2),
		Ganancia decimal(18,2)
	)
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

	INSERT INTO #TEMPORAL
	SELECT distinct
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
	FROM Estrategia E with(nolock)
		INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON
			op.CodConsultora = @CodigoConsultora
			and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
			and op.TipoPersonalizacion = 'OPT'
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
			AND TE.Codigo = '001'
	WHERE
		E.Activo = 1
		AND ca.Codigo = @CampaniaID
		AND TE.FlagActivo = 1
		AND TE.flagRecoPerfil = 1
		AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
	DECLARE @cont2 INT = 0
	SET @cont2 = (SELECT COUNT(EstrategiaID) FROM #TEMPORAL)

	IF (0 = @cont2)
	BEGIN
		DECLARE @codConsultoraDefault VARCHAR(9)

		SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001
		INSERT INTO #TEMPORAL
		SELECT distinct
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
		FROM Estrategia E with(nolock)
		INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON
			op.CodConsultora = @codConsultoraDefault
			and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
			and op.TipoPersonalizacion = 'OPT'
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
			AND TE.Codigo = '001'
		WHERE
			E.Activo = 1
			AND ca.Codigo = @CampaniaID
			AND TE.FlagActivo = 1
			AND TE.flagRecoPerfil = 1
			AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )

	END
	DECLARE @codConsultoraForzadas VARCHAR(9) = ''
	SELECT @codConsultoraForzadas = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10002

	INSERT INTO #TEMPORAL
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
	FROM Estrategia E with(nolock)
	INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON
	op.CodConsultora = @codConsultoraForzadas
	and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
	and op.TipoPersonalizacion = 'OPT'
	INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
	INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
	INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
	AND TE.Codigo = '001'
	WHERE
	E.Activo = 1
	AND ca.Codigo = @CampaniaID
	AND TE.FlagActivo = 1
	AND TE.flagRecoPerfil = 1
	AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
	SELECT * FROM (
	SELECT DISTINCT
		  T.EstrategiaID
		, T.CUV2
		, T.DescripcionCUV2
		, T.EtiquetaDescripcion
		, T.Precio
		, T.EtiquetaDescripcion2
		, T.Precio2
		, isnull(T.TextoLibre,'') as TextoLibre
		, T.FlagEstrella
		, T.ColorFondo
		, T.TipoEstrategiaID
		, T.FotoProducto01
		, T.ImagenURL
		, T.LimiteVenta
		, T.MarcaID
		, T.Orden1
		, T.Orden2
		, T.IndicadorMontoMinimo
		, T.FlagNueva
		, T.TipoTallaColor
		, T.TipoEstrategiaImagenMostrar
		, T.CodigoProducto
		, T.EtiquetaID
		, T.EtiquetaID2
		, T.CodigoEstrategia
		, T.TieneVariedad
		, T.CODIGO
		, T.DescripcionEstrategia
		, T.FlagMostrarImg
		, M.Descripcion as DescripcionMarca
		, 'NO DISPONIBLE' AS DescripcionCategoria
		, T.PrecioPublico
		, T.Ganancia
	FROM #TEMPORAL T
		LEFT JOIN Marca M with(nolock) ON M.MarcaId = T.MarcaId) T
	ORDER BY
		Orden1 ASC, CASE WHEN ISNULL(T.Orden2,0) = 0 THEN T.Orden1 ELSE T.Orden2 END ASC, EstrategiaID ASC

	DROP TABLE #TEMPORAL
SET NOCOUNT OFF
END
GO

GO
USE BelcorpColombia
GO
GO
ALTER PROCEDURE [dbo].[ListarEstrategiasOPT]
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(30)
AS
/*
dbo.ListarEstrategiasOPT 201710, ''
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

	CREATE TABLE #TEMPORAL (
		EstrategiaID int,
		CUV2 varchar(5),
		DescripcionCUV2 varchar(800),
		EtiquetaDescripcion varchar(8000),
		Precio numeric(12,2),
		EtiquetaDescripcion2 varchar(8000),
		Precio2 numeric(12,2),
		TextoLibre varchar(800),
		FlagEstrella bit,
		ColorFondo varchar(20),
		TipoEstrategiaID int,
		FotoProducto01 varchar(800),
		ImagenURL varchar(500),
		LimiteVenta int,
		MarcaID int,
		Orden1 int,
		Orden2 int,
		IndicadorMontoMinimo int,
		CodigoProducto varchar(12),
		FlagNueva int,
		TipoTallaColor varchar(50),
		TipoEstrategiaImagenMostrar	int,
		EtiquetaID int,
		EtiquetaID2 int,
		CodigoEstrategia varchar(100),
		TieneVariedad int,
		CODIGO varchar(100),
		DescripcionEstrategia varchar(200),
		FlagMostrarImg int,
		PrecioPublico decimal(18,2),
		Ganancia decimal(18,2)
	)
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

	INSERT INTO #TEMPORAL
	SELECT distinct
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
	FROM Estrategia E with(nolock)
		INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON
			op.CodConsultora = @CodigoConsultora
			and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
			and op.TipoPersonalizacion = 'OPT'
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
			AND TE.Codigo = '001'
	WHERE
		E.Activo = 1
		AND ca.Codigo = @CampaniaID
		AND TE.FlagActivo = 1
		AND TE.flagRecoPerfil = 1
		AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
	DECLARE @cont2 INT = 0
	SET @cont2 = (SELECT COUNT(EstrategiaID) FROM #TEMPORAL)

	IF (0 = @cont2)
	BEGIN
		DECLARE @codConsultoraDefault VARCHAR(9)

		SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001
		INSERT INTO #TEMPORAL
		SELECT distinct
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
		FROM Estrategia E with(nolock)
		INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON
			op.CodConsultora = @codConsultoraDefault
			and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
			and op.TipoPersonalizacion = 'OPT'
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
			AND TE.Codigo = '001'
		WHERE
			E.Activo = 1
			AND ca.Codigo = @CampaniaID
			AND TE.FlagActivo = 1
			AND TE.flagRecoPerfil = 1
			AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )

	END
	DECLARE @codConsultoraForzadas VARCHAR(9) = ''
	SELECT @codConsultoraForzadas = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10002

	INSERT INTO #TEMPORAL
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
	FROM Estrategia E with(nolock)
	INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON
	op.CodConsultora = @codConsultoraForzadas
	and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
	and op.TipoPersonalizacion = 'OPT'
	INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
	INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
	INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
	AND TE.Codigo = '001'
	WHERE
	E.Activo = 1
	AND ca.Codigo = @CampaniaID
	AND TE.FlagActivo = 1
	AND TE.flagRecoPerfil = 1
	AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
	SELECT * FROM (
	SELECT DISTINCT
		  T.EstrategiaID
		, T.CUV2
		, T.DescripcionCUV2
		, T.EtiquetaDescripcion
		, T.Precio
		, T.EtiquetaDescripcion2
		, T.Precio2
		, isnull(T.TextoLibre,'') as TextoLibre
		, T.FlagEstrella
		, T.ColorFondo
		, T.TipoEstrategiaID
		, T.FotoProducto01
		, T.ImagenURL
		, T.LimiteVenta
		, T.MarcaID
		, T.Orden1
		, T.Orden2
		, T.IndicadorMontoMinimo
		, T.FlagNueva
		, T.TipoTallaColor
		, T.TipoEstrategiaImagenMostrar
		, T.CodigoProducto
		, T.EtiquetaID
		, T.EtiquetaID2
		, T.CodigoEstrategia
		, T.TieneVariedad
		, T.CODIGO
		, T.DescripcionEstrategia
		, T.FlagMostrarImg
		, M.Descripcion as DescripcionMarca
		, 'NO DISPONIBLE' AS DescripcionCategoria
		, T.PrecioPublico
		, T.Ganancia
	FROM #TEMPORAL T
		LEFT JOIN Marca M with(nolock) ON M.MarcaId = T.MarcaId) T
	ORDER BY
		Orden1 ASC, CASE WHEN ISNULL(T.Orden2,0) = 0 THEN T.Orden1 ELSE T.Orden2 END ASC, EstrategiaID ASC

	DROP TABLE #TEMPORAL
SET NOCOUNT OFF
END
GO

GO
USE BelcorpSalvador
GO
GO
ALTER PROCEDURE [dbo].[ListarEstrategiasOPT]
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(30)
AS
/*
dbo.ListarEstrategiasOPT 201710, ''
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

	CREATE TABLE #TEMPORAL (
		EstrategiaID int,
		CUV2 varchar(5),
		DescripcionCUV2 varchar(800),
		EtiquetaDescripcion varchar(8000),
		Precio numeric(12,2),
		EtiquetaDescripcion2 varchar(8000),
		Precio2 numeric(12,2),
		TextoLibre varchar(800),
		FlagEstrella bit,
		ColorFondo varchar(20),
		TipoEstrategiaID int,
		FotoProducto01 varchar(800),
		ImagenURL varchar(500),
		LimiteVenta int,
		MarcaID int,
		Orden1 int,
		Orden2 int,
		IndicadorMontoMinimo int,
		CodigoProducto varchar(12),
		FlagNueva int,
		TipoTallaColor varchar(50),
		TipoEstrategiaImagenMostrar	int,
		EtiquetaID int,
		EtiquetaID2 int,
		CodigoEstrategia varchar(100),
		TieneVariedad int,
		CODIGO varchar(100),
		DescripcionEstrategia varchar(200),
		FlagMostrarImg int,
		PrecioPublico decimal(18,2),
		Ganancia decimal(18,2)
	)
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

	INSERT INTO #TEMPORAL
	SELECT distinct
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
	FROM Estrategia E with(nolock)
		INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON
			op.CodConsultora = @CodigoConsultora
			and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
			and op.TipoPersonalizacion = 'OPT'
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
			AND TE.Codigo = '001'
	WHERE
		E.Activo = 1
		AND ca.Codigo = @CampaniaID
		AND TE.FlagActivo = 1
		AND TE.flagRecoPerfil = 1
		AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
	DECLARE @cont2 INT = 0
	SET @cont2 = (SELECT COUNT(EstrategiaID) FROM #TEMPORAL)

	IF (0 = @cont2)
	BEGIN
		DECLARE @codConsultoraDefault VARCHAR(9)

		SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001
		INSERT INTO #TEMPORAL
		SELECT distinct
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
		FROM Estrategia E with(nolock)
		INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON
			op.CodConsultora = @codConsultoraDefault
			and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
			and op.TipoPersonalizacion = 'OPT'
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
			AND TE.Codigo = '001'
		WHERE
			E.Activo = 1
			AND ca.Codigo = @CampaniaID
			AND TE.FlagActivo = 1
			AND TE.flagRecoPerfil = 1
			AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )

	END
	DECLARE @codConsultoraForzadas VARCHAR(9) = ''
	SELECT @codConsultoraForzadas = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10002

	INSERT INTO #TEMPORAL
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
	FROM Estrategia E with(nolock)
	INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON
	op.CodConsultora = @codConsultoraForzadas
	and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
	and op.TipoPersonalizacion = 'OPT'
	INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
	INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
	INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
	AND TE.Codigo = '001'
	WHERE
	E.Activo = 1
	AND ca.Codigo = @CampaniaID
	AND TE.FlagActivo = 1
	AND TE.flagRecoPerfil = 1
	AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
	SELECT * FROM (
	SELECT DISTINCT
		  T.EstrategiaID
		, T.CUV2
		, T.DescripcionCUV2
		, T.EtiquetaDescripcion
		, T.Precio
		, T.EtiquetaDescripcion2
		, T.Precio2
		, isnull(T.TextoLibre,'') as TextoLibre
		, T.FlagEstrella
		, T.ColorFondo
		, T.TipoEstrategiaID
		, T.FotoProducto01
		, T.ImagenURL
		, T.LimiteVenta
		, T.MarcaID
		, T.Orden1
		, T.Orden2
		, T.IndicadorMontoMinimo
		, T.FlagNueva
		, T.TipoTallaColor
		, T.TipoEstrategiaImagenMostrar
		, T.CodigoProducto
		, T.EtiquetaID
		, T.EtiquetaID2
		, T.CodigoEstrategia
		, T.TieneVariedad
		, T.CODIGO
		, T.DescripcionEstrategia
		, T.FlagMostrarImg
		, M.Descripcion as DescripcionMarca
		, 'NO DISPONIBLE' AS DescripcionCategoria
		, T.PrecioPublico
		, T.Ganancia
	FROM #TEMPORAL T
		LEFT JOIN Marca M with(nolock) ON M.MarcaId = T.MarcaId) T
	ORDER BY
		Orden1 ASC, CASE WHEN ISNULL(T.Orden2,0) = 0 THEN T.Orden1 ELSE T.Orden2 END ASC, EstrategiaID ASC

	DROP TABLE #TEMPORAL
SET NOCOUNT OFF
END
GO

GO
USE BelcorpPuertoRico
GO
GO
ALTER PROCEDURE [dbo].[ListarEstrategiasOPT]
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(30)
AS
/*
dbo.ListarEstrategiasOPT 201710, ''
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

	CREATE TABLE #TEMPORAL (
		EstrategiaID int,
		CUV2 varchar(5),
		DescripcionCUV2 varchar(800),
		EtiquetaDescripcion varchar(8000),
		Precio numeric(12,2),
		EtiquetaDescripcion2 varchar(8000),
		Precio2 numeric(12,2),
		TextoLibre varchar(800),
		FlagEstrella bit,
		ColorFondo varchar(20),
		TipoEstrategiaID int,
		FotoProducto01 varchar(800),
		ImagenURL varchar(500),
		LimiteVenta int,
		MarcaID int,
		Orden1 int,
		Orden2 int,
		IndicadorMontoMinimo int,
		CodigoProducto varchar(12),
		FlagNueva int,
		TipoTallaColor varchar(50),
		TipoEstrategiaImagenMostrar	int,
		EtiquetaID int,
		EtiquetaID2 int,
		CodigoEstrategia varchar(100),
		TieneVariedad int,
		CODIGO varchar(100),
		DescripcionEstrategia varchar(200),
		FlagMostrarImg int,
		PrecioPublico decimal(18,2),
		Ganancia decimal(18,2)
	)
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

	INSERT INTO #TEMPORAL
	SELECT distinct
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
	FROM Estrategia E with(nolock)
		INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON
			op.CodConsultora = @CodigoConsultora
			and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
			and op.TipoPersonalizacion = 'OPT'
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
			AND TE.Codigo = '001'
	WHERE
		E.Activo = 1
		AND ca.Codigo = @CampaniaID
		AND TE.FlagActivo = 1
		AND TE.flagRecoPerfil = 1
		AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
	DECLARE @cont2 INT = 0
	SET @cont2 = (SELECT COUNT(EstrategiaID) FROM #TEMPORAL)

	IF (0 = @cont2)
	BEGIN
		DECLARE @codConsultoraDefault VARCHAR(9)

		SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001
		INSERT INTO #TEMPORAL
		SELECT distinct
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
		FROM Estrategia E with(nolock)
		INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON
			op.CodConsultora = @codConsultoraDefault
			and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
			and op.TipoPersonalizacion = 'OPT'
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
			AND TE.Codigo = '001'
		WHERE
			E.Activo = 1
			AND ca.Codigo = @CampaniaID
			AND TE.FlagActivo = 1
			AND TE.flagRecoPerfil = 1
			AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )

	END
	DECLARE @codConsultoraForzadas VARCHAR(9) = ''
	SELECT @codConsultoraForzadas = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10002

	INSERT INTO #TEMPORAL
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
	FROM Estrategia E with(nolock)
	INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON
	op.CodConsultora = @codConsultoraForzadas
	and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
	and op.TipoPersonalizacion = 'OPT'
	INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
	INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
	INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
	AND TE.Codigo = '001'
	WHERE
	E.Activo = 1
	AND ca.Codigo = @CampaniaID
	AND TE.FlagActivo = 1
	AND TE.flagRecoPerfil = 1
	AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
	SELECT * FROM (
	SELECT DISTINCT
		  T.EstrategiaID
		, T.CUV2
		, T.DescripcionCUV2
		, T.EtiquetaDescripcion
		, T.Precio
		, T.EtiquetaDescripcion2
		, T.Precio2
		, isnull(T.TextoLibre,'') as TextoLibre
		, T.FlagEstrella
		, T.ColorFondo
		, T.TipoEstrategiaID
		, T.FotoProducto01
		, T.ImagenURL
		, T.LimiteVenta
		, T.MarcaID
		, T.Orden1
		, T.Orden2
		, T.IndicadorMontoMinimo
		, T.FlagNueva
		, T.TipoTallaColor
		, T.TipoEstrategiaImagenMostrar
		, T.CodigoProducto
		, T.EtiquetaID
		, T.EtiquetaID2
		, T.CodigoEstrategia
		, T.TieneVariedad
		, T.CODIGO
		, T.DescripcionEstrategia
		, T.FlagMostrarImg
		, M.Descripcion as DescripcionMarca
		, 'NO DISPONIBLE' AS DescripcionCategoria
		, T.PrecioPublico
		, T.Ganancia
	FROM #TEMPORAL T
		LEFT JOIN Marca M with(nolock) ON M.MarcaId = T.MarcaId) T
	ORDER BY
		Orden1 ASC, CASE WHEN ISNULL(T.Orden2,0) = 0 THEN T.Orden1 ELSE T.Orden2 END ASC, EstrategiaID ASC

	DROP TABLE #TEMPORAL
SET NOCOUNT OFF
END
GO

GO
USE BelcorpPanama
GO
GO
ALTER PROCEDURE [dbo].[ListarEstrategiasOPT]
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(30)
AS
/*
dbo.ListarEstrategiasOPT 201710, ''
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

	CREATE TABLE #TEMPORAL (
		EstrategiaID int,
		CUV2 varchar(5),
		DescripcionCUV2 varchar(800),
		EtiquetaDescripcion varchar(8000),
		Precio numeric(12,2),
		EtiquetaDescripcion2 varchar(8000),
		Precio2 numeric(12,2),
		TextoLibre varchar(800),
		FlagEstrella bit,
		ColorFondo varchar(20),
		TipoEstrategiaID int,
		FotoProducto01 varchar(800),
		ImagenURL varchar(500),
		LimiteVenta int,
		MarcaID int,
		Orden1 int,
		Orden2 int,
		IndicadorMontoMinimo int,
		CodigoProducto varchar(12),
		FlagNueva int,
		TipoTallaColor varchar(50),
		TipoEstrategiaImagenMostrar	int,
		EtiquetaID int,
		EtiquetaID2 int,
		CodigoEstrategia varchar(100),
		TieneVariedad int,
		CODIGO varchar(100),
		DescripcionEstrategia varchar(200),
		FlagMostrarImg int,
		PrecioPublico decimal(18,2),
		Ganancia decimal(18,2)
	)
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

	INSERT INTO #TEMPORAL
	SELECT distinct
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
	FROM Estrategia E with(nolock)
		INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON
			op.CodConsultora = @CodigoConsultora
			and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
			and op.TipoPersonalizacion = 'OPT'
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
			AND TE.Codigo = '001'
	WHERE
		E.Activo = 1
		AND ca.Codigo = @CampaniaID
		AND TE.FlagActivo = 1
		AND TE.flagRecoPerfil = 1
		AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
	DECLARE @cont2 INT = 0
	SET @cont2 = (SELECT COUNT(EstrategiaID) FROM #TEMPORAL)

	IF (0 = @cont2)
	BEGIN
		DECLARE @codConsultoraDefault VARCHAR(9)

		SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001
		INSERT INTO #TEMPORAL
		SELECT distinct
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
		FROM Estrategia E with(nolock)
		INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON
			op.CodConsultora = @codConsultoraDefault
			and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
			and op.TipoPersonalizacion = 'OPT'
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
			AND TE.Codigo = '001'
		WHERE
			E.Activo = 1
			AND ca.Codigo = @CampaniaID
			AND TE.FlagActivo = 1
			AND TE.flagRecoPerfil = 1
			AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )

	END
	DECLARE @codConsultoraForzadas VARCHAR(9) = ''
	SELECT @codConsultoraForzadas = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10002

	INSERT INTO #TEMPORAL
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
	FROM Estrategia E with(nolock)
	INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON
	op.CodConsultora = @codConsultoraForzadas
	and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
	and op.TipoPersonalizacion = 'OPT'
	INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
	INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
	INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
	AND TE.Codigo = '001'
	WHERE
	E.Activo = 1
	AND ca.Codigo = @CampaniaID
	AND TE.FlagActivo = 1
	AND TE.flagRecoPerfil = 1
	AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
	SELECT * FROM (
	SELECT DISTINCT
		  T.EstrategiaID
		, T.CUV2
		, T.DescripcionCUV2
		, T.EtiquetaDescripcion
		, T.Precio
		, T.EtiquetaDescripcion2
		, T.Precio2
		, isnull(T.TextoLibre,'') as TextoLibre
		, T.FlagEstrella
		, T.ColorFondo
		, T.TipoEstrategiaID
		, T.FotoProducto01
		, T.ImagenURL
		, T.LimiteVenta
		, T.MarcaID
		, T.Orden1
		, T.Orden2
		, T.IndicadorMontoMinimo
		, T.FlagNueva
		, T.TipoTallaColor
		, T.TipoEstrategiaImagenMostrar
		, T.CodigoProducto
		, T.EtiquetaID
		, T.EtiquetaID2
		, T.CodigoEstrategia
		, T.TieneVariedad
		, T.CODIGO
		, T.DescripcionEstrategia
		, T.FlagMostrarImg
		, M.Descripcion as DescripcionMarca
		, 'NO DISPONIBLE' AS DescripcionCategoria
		, T.PrecioPublico
		, T.Ganancia
	FROM #TEMPORAL T
		LEFT JOIN Marca M with(nolock) ON M.MarcaId = T.MarcaId) T
	ORDER BY
		Orden1 ASC, CASE WHEN ISNULL(T.Orden2,0) = 0 THEN T.Orden1 ELSE T.Orden2 END ASC, EstrategiaID ASC

	DROP TABLE #TEMPORAL
SET NOCOUNT OFF
END
GO

GO
USE BelcorpGuatemala
GO
GO
ALTER PROCEDURE [dbo].[ListarEstrategiasOPT]
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(30)
AS
/*
dbo.ListarEstrategiasOPT 201710, ''
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

	CREATE TABLE #TEMPORAL (
		EstrategiaID int,
		CUV2 varchar(5),
		DescripcionCUV2 varchar(800),
		EtiquetaDescripcion varchar(8000),
		Precio numeric(12,2),
		EtiquetaDescripcion2 varchar(8000),
		Precio2 numeric(12,2),
		TextoLibre varchar(800),
		FlagEstrella bit,
		ColorFondo varchar(20),
		TipoEstrategiaID int,
		FotoProducto01 varchar(800),
		ImagenURL varchar(500),
		LimiteVenta int,
		MarcaID int,
		Orden1 int,
		Orden2 int,
		IndicadorMontoMinimo int,
		CodigoProducto varchar(12),
		FlagNueva int,
		TipoTallaColor varchar(50),
		TipoEstrategiaImagenMostrar	int,
		EtiquetaID int,
		EtiquetaID2 int,
		CodigoEstrategia varchar(100),
		TieneVariedad int,
		CODIGO varchar(100),
		DescripcionEstrategia varchar(200),
		FlagMostrarImg int,
		PrecioPublico decimal(18,2),
		Ganancia decimal(18,2)
	)
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

	INSERT INTO #TEMPORAL
	SELECT distinct
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
	FROM Estrategia E with(nolock)
		INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON
			op.CodConsultora = @CodigoConsultora
			and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
			and op.TipoPersonalizacion = 'OPT'
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
			AND TE.Codigo = '001'
	WHERE
		E.Activo = 1
		AND ca.Codigo = @CampaniaID
		AND TE.FlagActivo = 1
		AND TE.flagRecoPerfil = 1
		AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
	DECLARE @cont2 INT = 0
	SET @cont2 = (SELECT COUNT(EstrategiaID) FROM #TEMPORAL)

	IF (0 = @cont2)
	BEGIN
		DECLARE @codConsultoraDefault VARCHAR(9)

		SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001
		INSERT INTO #TEMPORAL
		SELECT distinct
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
		FROM Estrategia E with(nolock)
		INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON
			op.CodConsultora = @codConsultoraDefault
			and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
			and op.TipoPersonalizacion = 'OPT'
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
			AND TE.Codigo = '001'
		WHERE
			E.Activo = 1
			AND ca.Codigo = @CampaniaID
			AND TE.FlagActivo = 1
			AND TE.flagRecoPerfil = 1
			AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )

	END
	DECLARE @codConsultoraForzadas VARCHAR(9) = ''
	SELECT @codConsultoraForzadas = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10002

	INSERT INTO #TEMPORAL
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
	FROM Estrategia E with(nolock)
	INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON
	op.CodConsultora = @codConsultoraForzadas
	and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
	and op.TipoPersonalizacion = 'OPT'
	INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
	INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
	INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
	AND TE.Codigo = '001'
	WHERE
	E.Activo = 1
	AND ca.Codigo = @CampaniaID
	AND TE.FlagActivo = 1
	AND TE.flagRecoPerfil = 1
	AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
	SELECT * FROM (
	SELECT DISTINCT
		  T.EstrategiaID
		, T.CUV2
		, T.DescripcionCUV2
		, T.EtiquetaDescripcion
		, T.Precio
		, T.EtiquetaDescripcion2
		, T.Precio2
		, isnull(T.TextoLibre,'') as TextoLibre
		, T.FlagEstrella
		, T.ColorFondo
		, T.TipoEstrategiaID
		, T.FotoProducto01
		, T.ImagenURL
		, T.LimiteVenta
		, T.MarcaID
		, T.Orden1
		, T.Orden2
		, T.IndicadorMontoMinimo
		, T.FlagNueva
		, T.TipoTallaColor
		, T.TipoEstrategiaImagenMostrar
		, T.CodigoProducto
		, T.EtiquetaID
		, T.EtiquetaID2
		, T.CodigoEstrategia
		, T.TieneVariedad
		, T.CODIGO
		, T.DescripcionEstrategia
		, T.FlagMostrarImg
		, M.Descripcion as DescripcionMarca
		, 'NO DISPONIBLE' AS DescripcionCategoria
		, T.PrecioPublico
		, T.Ganancia
	FROM #TEMPORAL T
		LEFT JOIN Marca M with(nolock) ON M.MarcaId = T.MarcaId) T
	ORDER BY
		Orden1 ASC, CASE WHEN ISNULL(T.Orden2,0) = 0 THEN T.Orden1 ELSE T.Orden2 END ASC, EstrategiaID ASC

	DROP TABLE #TEMPORAL
SET NOCOUNT OFF
END
GO

GO
USE BelcorpEcuador
GO
GO
ALTER PROCEDURE [dbo].[ListarEstrategiasOPT]
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(30)
AS
/*
dbo.ListarEstrategiasOPT 201710, ''
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

	CREATE TABLE #TEMPORAL (
		EstrategiaID int,
		CUV2 varchar(5),
		DescripcionCUV2 varchar(800),
		EtiquetaDescripcion varchar(8000),
		Precio numeric(12,2),
		EtiquetaDescripcion2 varchar(8000),
		Precio2 numeric(12,2),
		TextoLibre varchar(800),
		FlagEstrella bit,
		ColorFondo varchar(20),
		TipoEstrategiaID int,
		FotoProducto01 varchar(800),
		ImagenURL varchar(500),
		LimiteVenta int,
		MarcaID int,
		Orden1 int,
		Orden2 int,
		IndicadorMontoMinimo int,
		CodigoProducto varchar(12),
		FlagNueva int,
		TipoTallaColor varchar(50),
		TipoEstrategiaImagenMostrar	int,
		EtiquetaID int,
		EtiquetaID2 int,
		CodigoEstrategia varchar(100),
		TieneVariedad int,
		CODIGO varchar(100),
		DescripcionEstrategia varchar(200),
		FlagMostrarImg int,
		PrecioPublico decimal(18,2),
		Ganancia decimal(18,2)
	)
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

	INSERT INTO #TEMPORAL
	SELECT distinct
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
	FROM Estrategia E with(nolock)
		INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON
			op.CodConsultora = @CodigoConsultora
			and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
			and op.TipoPersonalizacion = 'OPT'
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
			AND TE.Codigo = '001'
	WHERE
		E.Activo = 1
		AND ca.Codigo = @CampaniaID
		AND TE.FlagActivo = 1
		AND TE.flagRecoPerfil = 1
		AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
	DECLARE @cont2 INT = 0
	SET @cont2 = (SELECT COUNT(EstrategiaID) FROM #TEMPORAL)

	IF (0 = @cont2)
	BEGIN
		DECLARE @codConsultoraDefault VARCHAR(9)

		SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001
		INSERT INTO #TEMPORAL
		SELECT distinct
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
		FROM Estrategia E with(nolock)
		INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON
			op.CodConsultora = @codConsultoraDefault
			and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
			and op.TipoPersonalizacion = 'OPT'
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
			AND TE.Codigo = '001'
		WHERE
			E.Activo = 1
			AND ca.Codigo = @CampaniaID
			AND TE.FlagActivo = 1
			AND TE.flagRecoPerfil = 1
			AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )

	END
	DECLARE @codConsultoraForzadas VARCHAR(9) = ''
	SELECT @codConsultoraForzadas = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10002

	INSERT INTO #TEMPORAL
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
	FROM Estrategia E with(nolock)
	INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON
	op.CodConsultora = @codConsultoraForzadas
	and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
	and op.TipoPersonalizacion = 'OPT'
	INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
	INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
	INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
	AND TE.Codigo = '001'
	WHERE
	E.Activo = 1
	AND ca.Codigo = @CampaniaID
	AND TE.FlagActivo = 1
	AND TE.flagRecoPerfil = 1
	AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
	SELECT * FROM (
	SELECT DISTINCT
		  T.EstrategiaID
		, T.CUV2
		, T.DescripcionCUV2
		, T.EtiquetaDescripcion
		, T.Precio
		, T.EtiquetaDescripcion2
		, T.Precio2
		, isnull(T.TextoLibre,'') as TextoLibre
		, T.FlagEstrella
		, T.ColorFondo
		, T.TipoEstrategiaID
		, T.FotoProducto01
		, T.ImagenURL
		, T.LimiteVenta
		, T.MarcaID
		, T.Orden1
		, T.Orden2
		, T.IndicadorMontoMinimo
		, T.FlagNueva
		, T.TipoTallaColor
		, T.TipoEstrategiaImagenMostrar
		, T.CodigoProducto
		, T.EtiquetaID
		, T.EtiquetaID2
		, T.CodigoEstrategia
		, T.TieneVariedad
		, T.CODIGO
		, T.DescripcionEstrategia
		, T.FlagMostrarImg
		, M.Descripcion as DescripcionMarca
		, 'NO DISPONIBLE' AS DescripcionCategoria
		, T.PrecioPublico
		, T.Ganancia
	FROM #TEMPORAL T
		LEFT JOIN Marca M with(nolock) ON M.MarcaId = T.MarcaId) T
	ORDER BY
		Orden1 ASC, CASE WHEN ISNULL(T.Orden2,0) = 0 THEN T.Orden1 ELSE T.Orden2 END ASC, EstrategiaID ASC

	DROP TABLE #TEMPORAL
SET NOCOUNT OFF
END
GO

GO
USE BelcorpDominicana
GO
GO
ALTER PROCEDURE [dbo].[ListarEstrategiasOPT]
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(30)
AS
/*
dbo.ListarEstrategiasOPT 201710, ''
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

	CREATE TABLE #TEMPORAL (
		EstrategiaID int,
		CUV2 varchar(5),
		DescripcionCUV2 varchar(800),
		EtiquetaDescripcion varchar(8000),
		Precio numeric(12,2),
		EtiquetaDescripcion2 varchar(8000),
		Precio2 numeric(12,2),
		TextoLibre varchar(800),
		FlagEstrella bit,
		ColorFondo varchar(20),
		TipoEstrategiaID int,
		FotoProducto01 varchar(800),
		ImagenURL varchar(500),
		LimiteVenta int,
		MarcaID int,
		Orden1 int,
		Orden2 int,
		IndicadorMontoMinimo int,
		CodigoProducto varchar(12),
		FlagNueva int,
		TipoTallaColor varchar(50),
		TipoEstrategiaImagenMostrar	int,
		EtiquetaID int,
		EtiquetaID2 int,
		CodigoEstrategia varchar(100),
		TieneVariedad int,
		CODIGO varchar(100),
		DescripcionEstrategia varchar(200),
		FlagMostrarImg int,
		PrecioPublico decimal(18,2),
		Ganancia decimal(18,2)
	)
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

	INSERT INTO #TEMPORAL
	SELECT distinct
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
	FROM Estrategia E with(nolock)
		INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON
			op.CodConsultora = @CodigoConsultora
			and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
			and op.TipoPersonalizacion = 'OPT'
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
			AND TE.Codigo = '001'
	WHERE
		E.Activo = 1
		AND ca.Codigo = @CampaniaID
		AND TE.FlagActivo = 1
		AND TE.flagRecoPerfil = 1
		AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
	DECLARE @cont2 INT = 0
	SET @cont2 = (SELECT COUNT(EstrategiaID) FROM #TEMPORAL)

	IF (0 = @cont2)
	BEGIN
		DECLARE @codConsultoraDefault VARCHAR(9)

		SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001
		INSERT INTO #TEMPORAL
		SELECT distinct
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
		FROM Estrategia E with(nolock)
		INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON
			op.CodConsultora = @codConsultoraDefault
			and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
			and op.TipoPersonalizacion = 'OPT'
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
			AND TE.Codigo = '001'
		WHERE
			E.Activo = 1
			AND ca.Codigo = @CampaniaID
			AND TE.FlagActivo = 1
			AND TE.flagRecoPerfil = 1
			AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )

	END
	DECLARE @codConsultoraForzadas VARCHAR(9) = ''
	SELECT @codConsultoraForzadas = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10002

	INSERT INTO #TEMPORAL
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
	FROM Estrategia E with(nolock)
	INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON
	op.CodConsultora = @codConsultoraForzadas
	and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
	and op.TipoPersonalizacion = 'OPT'
	INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
	INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
	INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
	AND TE.Codigo = '001'
	WHERE
	E.Activo = 1
	AND ca.Codigo = @CampaniaID
	AND TE.FlagActivo = 1
	AND TE.flagRecoPerfil = 1
	AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
	SELECT * FROM (
	SELECT DISTINCT
		  T.EstrategiaID
		, T.CUV2
		, T.DescripcionCUV2
		, T.EtiquetaDescripcion
		, T.Precio
		, T.EtiquetaDescripcion2
		, T.Precio2
		, isnull(T.TextoLibre,'') as TextoLibre
		, T.FlagEstrella
		, T.ColorFondo
		, T.TipoEstrategiaID
		, T.FotoProducto01
		, T.ImagenURL
		, T.LimiteVenta
		, T.MarcaID
		, T.Orden1
		, T.Orden2
		, T.IndicadorMontoMinimo
		, T.FlagNueva
		, T.TipoTallaColor
		, T.TipoEstrategiaImagenMostrar
		, T.CodigoProducto
		, T.EtiquetaID
		, T.EtiquetaID2
		, T.CodigoEstrategia
		, T.TieneVariedad
		, T.CODIGO
		, T.DescripcionEstrategia
		, T.FlagMostrarImg
		, M.Descripcion as DescripcionMarca
		, 'NO DISPONIBLE' AS DescripcionCategoria
		, T.PrecioPublico
		, T.Ganancia
	FROM #TEMPORAL T
		LEFT JOIN Marca M with(nolock) ON M.MarcaId = T.MarcaId) T
	ORDER BY
		Orden1 ASC, CASE WHEN ISNULL(T.Orden2,0) = 0 THEN T.Orden1 ELSE T.Orden2 END ASC, EstrategiaID ASC

	DROP TABLE #TEMPORAL
SET NOCOUNT OFF
END
GO

GO
USE BelcorpCostaRica
GO
GO
ALTER PROCEDURE [dbo].[ListarEstrategiasOPT]
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(30)
AS
/*
dbo.ListarEstrategiasOPT 201710, ''
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

	CREATE TABLE #TEMPORAL (
		EstrategiaID int,
		CUV2 varchar(5),
		DescripcionCUV2 varchar(800),
		EtiquetaDescripcion varchar(8000),
		Precio numeric(12,2),
		EtiquetaDescripcion2 varchar(8000),
		Precio2 numeric(12,2),
		TextoLibre varchar(800),
		FlagEstrella bit,
		ColorFondo varchar(20),
		TipoEstrategiaID int,
		FotoProducto01 varchar(800),
		ImagenURL varchar(500),
		LimiteVenta int,
		MarcaID int,
		Orden1 int,
		Orden2 int,
		IndicadorMontoMinimo int,
		CodigoProducto varchar(12),
		FlagNueva int,
		TipoTallaColor varchar(50),
		TipoEstrategiaImagenMostrar	int,
		EtiquetaID int,
		EtiquetaID2 int,
		CodigoEstrategia varchar(100),
		TieneVariedad int,
		CODIGO varchar(100),
		DescripcionEstrategia varchar(200),
		FlagMostrarImg int,
		PrecioPublico decimal(18,2),
		Ganancia decimal(18,2)
	)
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

	INSERT INTO #TEMPORAL
	SELECT distinct
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
	FROM Estrategia E with(nolock)
		INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON
			op.CodConsultora = @CodigoConsultora
			and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
			and op.TipoPersonalizacion = 'OPT'
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
			AND TE.Codigo = '001'
	WHERE
		E.Activo = 1
		AND ca.Codigo = @CampaniaID
		AND TE.FlagActivo = 1
		AND TE.flagRecoPerfil = 1
		AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
	DECLARE @cont2 INT = 0
	SET @cont2 = (SELECT COUNT(EstrategiaID) FROM #TEMPORAL)

	IF (0 = @cont2)
	BEGIN
		DECLARE @codConsultoraDefault VARCHAR(9)

		SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001
		INSERT INTO #TEMPORAL
		SELECT distinct
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
		FROM Estrategia E with(nolock)
		INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON
			op.CodConsultora = @codConsultoraDefault
			and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
			and op.TipoPersonalizacion = 'OPT'
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
			AND TE.Codigo = '001'
		WHERE
			E.Activo = 1
			AND ca.Codigo = @CampaniaID
			AND TE.FlagActivo = 1
			AND TE.flagRecoPerfil = 1
			AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )

	END
	DECLARE @codConsultoraForzadas VARCHAR(9) = ''
	SELECT @codConsultoraForzadas = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10002

	INSERT INTO #TEMPORAL
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
	FROM Estrategia E with(nolock)
	INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON
	op.CodConsultora = @codConsultoraForzadas
	and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
	and op.TipoPersonalizacion = 'OPT'
	INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
	INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
	INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
	AND TE.Codigo = '001'
	WHERE
	E.Activo = 1
	AND ca.Codigo = @CampaniaID
	AND TE.FlagActivo = 1
	AND TE.flagRecoPerfil = 1
	AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
	SELECT * FROM (
	SELECT DISTINCT
		  T.EstrategiaID
		, T.CUV2
		, T.DescripcionCUV2
		, T.EtiquetaDescripcion
		, T.Precio
		, T.EtiquetaDescripcion2
		, T.Precio2
		, isnull(T.TextoLibre,'') as TextoLibre
		, T.FlagEstrella
		, T.ColorFondo
		, T.TipoEstrategiaID
		, T.FotoProducto01
		, T.ImagenURL
		, T.LimiteVenta
		, T.MarcaID
		, T.Orden1
		, T.Orden2
		, T.IndicadorMontoMinimo
		, T.FlagNueva
		, T.TipoTallaColor
		, T.TipoEstrategiaImagenMostrar
		, T.CodigoProducto
		, T.EtiquetaID
		, T.EtiquetaID2
		, T.CodigoEstrategia
		, T.TieneVariedad
		, T.CODIGO
		, T.DescripcionEstrategia
		, T.FlagMostrarImg
		, M.Descripcion as DescripcionMarca
		, 'NO DISPONIBLE' AS DescripcionCategoria
		, T.PrecioPublico
		, T.Ganancia
	FROM #TEMPORAL T
		LEFT JOIN Marca M with(nolock) ON M.MarcaId = T.MarcaId) T
	ORDER BY
		Orden1 ASC, CASE WHEN ISNULL(T.Orden2,0) = 0 THEN T.Orden1 ELSE T.Orden2 END ASC, EstrategiaID ASC

	DROP TABLE #TEMPORAL
SET NOCOUNT OFF
END
GO

GO
USE BelcorpChile
GO
GO
ALTER PROCEDURE [dbo].[ListarEstrategiasOPT]
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(30)
AS
/*
dbo.ListarEstrategiasOPT 201710, ''
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

	CREATE TABLE #TEMPORAL (
		EstrategiaID int,
		CUV2 varchar(5),
		DescripcionCUV2 varchar(800),
		EtiquetaDescripcion varchar(8000),
		Precio numeric(12,2),
		EtiquetaDescripcion2 varchar(8000),
		Precio2 numeric(12,2),
		TextoLibre varchar(800),
		FlagEstrella bit,
		ColorFondo varchar(20),
		TipoEstrategiaID int,
		FotoProducto01 varchar(800),
		ImagenURL varchar(500),
		LimiteVenta int,
		MarcaID int,
		Orden1 int,
		Orden2 int,
		IndicadorMontoMinimo int,
		CodigoProducto varchar(12),
		FlagNueva int,
		TipoTallaColor varchar(50),
		TipoEstrategiaImagenMostrar	int,
		EtiquetaID int,
		EtiquetaID2 int,
		CodigoEstrategia varchar(100),
		TieneVariedad int,
		CODIGO varchar(100),
		DescripcionEstrategia varchar(200),
		FlagMostrarImg int,
		PrecioPublico decimal(18,2),
		Ganancia decimal(18,2)
	)
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

	INSERT INTO #TEMPORAL
	SELECT distinct
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
	FROM Estrategia E with(nolock)
		INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON
			op.CodConsultora = @CodigoConsultora
			and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
			and op.TipoPersonalizacion = 'OPT'
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
			AND TE.Codigo = '001'
	WHERE
		E.Activo = 1
		AND ca.Codigo = @CampaniaID
		AND TE.FlagActivo = 1
		AND TE.flagRecoPerfil = 1
		AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
	DECLARE @cont2 INT = 0
	SET @cont2 = (SELECT COUNT(EstrategiaID) FROM #TEMPORAL)

	IF (0 = @cont2)
	BEGIN
		DECLARE @codConsultoraDefault VARCHAR(9)

		SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001
		INSERT INTO #TEMPORAL
		SELECT distinct
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
		FROM Estrategia E with(nolock)
		INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON
			op.CodConsultora = @codConsultoraDefault
			and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
			and op.TipoPersonalizacion = 'OPT'
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
			AND TE.Codigo = '001'
		WHERE
			E.Activo = 1
			AND ca.Codigo = @CampaniaID
			AND TE.FlagActivo = 1
			AND TE.flagRecoPerfil = 1
			AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )

	END
	DECLARE @codConsultoraForzadas VARCHAR(9) = ''
	SELECT @codConsultoraForzadas = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10002

	INSERT INTO #TEMPORAL
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
	FROM Estrategia E with(nolock)
	INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON
	op.CodConsultora = @codConsultoraForzadas
	and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
	and op.TipoPersonalizacion = 'OPT'
	INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
	INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
	INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
	AND TE.Codigo = '001'
	WHERE
	E.Activo = 1
	AND ca.Codigo = @CampaniaID
	AND TE.FlagActivo = 1
	AND TE.flagRecoPerfil = 1
	AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
	SELECT * FROM (
	SELECT DISTINCT
		  T.EstrategiaID
		, T.CUV2
		, T.DescripcionCUV2
		, T.EtiquetaDescripcion
		, T.Precio
		, T.EtiquetaDescripcion2
		, T.Precio2
		, isnull(T.TextoLibre,'') as TextoLibre
		, T.FlagEstrella
		, T.ColorFondo
		, T.TipoEstrategiaID
		, T.FotoProducto01
		, T.ImagenURL
		, T.LimiteVenta
		, T.MarcaID
		, T.Orden1
		, T.Orden2
		, T.IndicadorMontoMinimo
		, T.FlagNueva
		, T.TipoTallaColor
		, T.TipoEstrategiaImagenMostrar
		, T.CodigoProducto
		, T.EtiquetaID
		, T.EtiquetaID2
		, T.CodigoEstrategia
		, T.TieneVariedad
		, T.CODIGO
		, T.DescripcionEstrategia
		, T.FlagMostrarImg
		, M.Descripcion as DescripcionMarca
		, 'NO DISPONIBLE' AS DescripcionCategoria
		, T.PrecioPublico
		, T.Ganancia
	FROM #TEMPORAL T
		LEFT JOIN Marca M with(nolock) ON M.MarcaId = T.MarcaId) T
	ORDER BY
		Orden1 ASC, CASE WHEN ISNULL(T.Orden2,0) = 0 THEN T.Orden1 ELSE T.Orden2 END ASC, EstrategiaID ASC

	DROP TABLE #TEMPORAL
SET NOCOUNT OFF
END
GO

GO
USE BelcorpBolivia
GO
GO
ALTER PROCEDURE [dbo].[ListarEstrategiasOPT]
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(30)
AS
/*
dbo.ListarEstrategiasOPT 201710, ''
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

	CREATE TABLE #TEMPORAL (
		EstrategiaID int,
		CUV2 varchar(5),
		DescripcionCUV2 varchar(800),
		EtiquetaDescripcion varchar(8000),
		Precio numeric(12,2),
		EtiquetaDescripcion2 varchar(8000),
		Precio2 numeric(12,2),
		TextoLibre varchar(800),
		FlagEstrella bit,
		ColorFondo varchar(20),
		TipoEstrategiaID int,
		FotoProducto01 varchar(800),
		ImagenURL varchar(500),
		LimiteVenta int,
		MarcaID int,
		Orden1 int,
		Orden2 int,
		IndicadorMontoMinimo int,
		CodigoProducto varchar(12),
		FlagNueva int,
		TipoTallaColor varchar(50),
		TipoEstrategiaImagenMostrar	int,
		EtiquetaID int,
		EtiquetaID2 int,
		CodigoEstrategia varchar(100),
		TieneVariedad int,
		CODIGO varchar(100),
		DescripcionEstrategia varchar(200),
		FlagMostrarImg int,
		PrecioPublico decimal(18,2),
		Ganancia decimal(18,2)
	)
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

	INSERT INTO #TEMPORAL
	SELECT distinct
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
	FROM Estrategia E with(nolock)
		INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON
			op.CodConsultora = @CodigoConsultora
			and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
			and op.TipoPersonalizacion = 'OPT'
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
			AND TE.Codigo = '001'
	WHERE
		E.Activo = 1
		AND ca.Codigo = @CampaniaID
		AND TE.FlagActivo = 1
		AND TE.flagRecoPerfil = 1
		AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
	DECLARE @cont2 INT = 0
	SET @cont2 = (SELECT COUNT(EstrategiaID) FROM #TEMPORAL)

	IF (0 = @cont2)
	BEGIN
		DECLARE @codConsultoraDefault VARCHAR(9)

		SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001
		INSERT INTO #TEMPORAL
		SELECT distinct
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
		FROM Estrategia E with(nolock)
		INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON
			op.CodConsultora = @codConsultoraDefault
			and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
			and op.TipoPersonalizacion = 'OPT'
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
			AND TE.Codigo = '001'
		WHERE
			E.Activo = 1
			AND ca.Codigo = @CampaniaID
			AND TE.FlagActivo = 1
			AND TE.flagRecoPerfil = 1
			AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )

	END
	DECLARE @codConsultoraForzadas VARCHAR(9) = ''
	SELECT @codConsultoraForzadas = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10002

	INSERT INTO #TEMPORAL
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
	FROM Estrategia E with(nolock)
	INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON
	op.CodConsultora = @codConsultoraForzadas
	and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
	and op.TipoPersonalizacion = 'OPT'
	INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
	INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
	INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
	AND TE.Codigo = '001'
	WHERE
	E.Activo = 1
	AND ca.Codigo = @CampaniaID
	AND TE.FlagActivo = 1
	AND TE.flagRecoPerfil = 1
	AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
	SELECT * FROM (
	SELECT DISTINCT
		  T.EstrategiaID
		, T.CUV2
		, T.DescripcionCUV2
		, T.EtiquetaDescripcion
		, T.Precio
		, T.EtiquetaDescripcion2
		, T.Precio2
		, isnull(T.TextoLibre,'') as TextoLibre
		, T.FlagEstrella
		, T.ColorFondo
		, T.TipoEstrategiaID
		, T.FotoProducto01
		, T.ImagenURL
		, T.LimiteVenta
		, T.MarcaID
		, T.Orden1
		, T.Orden2
		, T.IndicadorMontoMinimo
		, T.FlagNueva
		, T.TipoTallaColor
		, T.TipoEstrategiaImagenMostrar
		, T.CodigoProducto
		, T.EtiquetaID
		, T.EtiquetaID2
		, T.CodigoEstrategia
		, T.TieneVariedad
		, T.CODIGO
		, T.DescripcionEstrategia
		, T.FlagMostrarImg
		, M.Descripcion as DescripcionMarca
		, 'NO DISPONIBLE' AS DescripcionCategoria
		, T.PrecioPublico
		, T.Ganancia
	FROM #TEMPORAL T
		LEFT JOIN Marca M with(nolock) ON M.MarcaId = T.MarcaId) T
	ORDER BY
		Orden1 ASC, CASE WHEN ISNULL(T.Orden2,0) = 0 THEN T.Orden1 ELSE T.Orden2 END ASC, EstrategiaID ASC

	DROP TABLE #TEMPORAL
SET NOCOUNT OFF
END
GO

GO
