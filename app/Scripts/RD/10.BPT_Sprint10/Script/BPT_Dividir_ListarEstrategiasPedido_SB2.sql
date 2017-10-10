USE BelcorpPeru
GO

go
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListarEstrategiasPackNuevas]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ListarEstrategiasPackNuevas]
GO

go
CREATE PROCEDURE [dbo].[ListarEstrategiasPackNuevas]
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(30)
AS
/*
dbo.ListarEstrategiasPackNuevas 201710, ''
*/
BEGIN
SET NOCOUNT ON;
	
	declare @ZonaID VARCHAR(20) = ''
	, @NumeroPedido INT = 0

	select @ZonaID = ZonaID
		, @NumeroPedido = ConsecutivoNueva + 1
	from ods.Consultora with(nolock)
	where Codigo = @CodigoConsultora

	SELECT
		EstrategiaID,
		CUV2,
		DescripcionCUV2,
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
		Precio,
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
		e.Orden Orden2,
		pc.IndicadorMontoMinimo,
		pc.CodigoProducto,
		1 AS FlagNueva,
		'' as TipoTallaColor,
		2 as TipoEstrategiaImagenMostrar
		, E.EtiquetaID
		, E.EtiquetaID2
		, E.CodigoEstrategia
		, E.TieneVariedad
		, TE.CODIGO
		, TE.DescripcionEstrategia
		, ISNULL(TE.FlagMostrarImg,0) AS FlagMostrarImg
	FROM Estrategia E with(nolock)
		INNER JOIN TipoEstrategia TE with(nolock) ON
			E.TipoEstrategiaID = TE.TipoEstrategiaID
		INNER JOIN ods.Campania CA with(nolock) ON
			E.CampaniaID = CA.Codigo
		INNER JOIN ods.ProductoComercial PC with(nolock) ON
			PC.CampaniaID = CA.CampaniaID
			AND PC.CUV = E.CUV2
		INNER JOIN Ods.ConsultorasProgramaNuevas CPN with(nolock) ON
			CPN.CodigoConsultora = @CodigoConsultora
			AND CPN.CodigoPrograma = TE.CodigoPrograma
	WHERE
		(E.CampaniaID = @CampaniaID OR @CampaniaID between E.CampaniaID and E.CampaniaIDFin)
		AND CPN.Participa = 1
		AND TE.FlagActivo = 1
		AND TE.flagNueva = 1
		AND E.Activo = 1
		AND E.Zona LIKE '%' + @ZonaID + '%'
		AND E.NumeroPedido = @NumeroPedido
	order by
		te.Orden ASC, CASE WHEN ISNULL(e.Orden,0) = 0 THEN te.Orden ELSE e.Orden END ASC, EstrategiaID ASC


SET NOCOUNT OFF
END
go

go
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListarEstrategiasLanzamiento]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ListarEstrategiasLanzamiento]
GO

go
CREATE PROCEDURE [dbo].[ListarEstrategiasLanzamiento]
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(30)
AS
/*
dbo.ListarEstrategiasLanzamiento 201710, ''
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
		FlagMostrarImg int
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
	FROM Estrategia E with(nolock)
		INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON 
			op.CodConsultora = @CodigoConsultora  
			and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
			and op.TipoPersonalizacion = 'LAN'
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
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
		FROM Estrategia E with(nolock)
		INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON 
			op.CodConsultora = @codConsultoraDefault  
			and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
			and op.TipoPersonalizacion = 'LAN'
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
		WHERE
			E.Activo = 1
			AND ca.Codigo = @CampaniaID
			AND TE.FlagActivo = 1
			AND TE.flagRecoPerfil = 1
			AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
	
	END
	
	declare @TEMP table (
		EstrategiaID int
		, ImgFondoDesktop varchar(1000)
		, ImgPrevDesktop varchar(1000)
		, ImgSelloProductoDesktop varchar(1000)
		, UrlVideoDesktop varchar(1000)
		, ImgFichaFondoDesktop varchar(1000)
		, ImgFondoMobile varchar(1000)
		, ImgSelloProductoMobile varchar(1000)
		, UrlVideoMobile varchar(1000)
		, ImgFichaFondoMobile varchar(1000)
		, ImgHomeDesktop varchar(1000)
		, ImgHomeMobile varchar(1000)
	)

	insert into @temp 
	SELECT EstrategiaID
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10201) as ImgFondoDesktop
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10202) as ImgPrevDesktop
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10203) as ImgSelloProductoDesktop
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10204) as UrlVideoDesktop
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10208) as ImgFichaFondoDesktop
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10205) as ImgFondoMobile
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10206) as ImgSelloProductoMobile
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10207) as UrlVideoMobile
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10209) as ImgFichaFondoMobile	
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10210) as ImgHomeDesktop		
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10211) as ImgHomeMobile				
	FROM #TEMPORAL as T
	
	SELECT
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
		, D.ImgFondoDesktop
		, D.ImgPrevDesktop	
		, D.ImgSelloProductoDesktop as ImgFichaDesktop
		, D.UrlVideoDesktop 
		, D.ImgFichaFondoDesktop 
		, D.ImgFondoMobile		
		, D.ImgSelloProductoMobile as ImgFichaMobile
		, D.UrlVideoMobile  
		, D.ImgFichaFondoMobile
		, D.ImgHomeDesktop
		, D.ImgHomeMobile
	FROM #TEMPORAL T
		LEFT JOIN Marca M with(nolock) ON M.MarcaId = T.MarcaId
		LEFT JOIN @temp D ON D.EstrategiaID = T.EstrategiaID
	ORDER BY
		Orden1 ASC, CASE WHEN ISNULL(T.Orden2,0) = 0 THEN T.Orden1 ELSE T.Orden2 END ASC, EstrategiaID ASC
	
	DROP TABLE #TEMPORAL

SET NOCOUNT OFF
END

go

go
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListarEstrategiasOPT]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ListarEstrategiasOPT]
GO

go
CREATE PROCEDURE [dbo].[ListarEstrategiasOPT]
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
		FlagMostrarImg int
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
	FROM Estrategia E with(nolock)
		INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON 
			op.CodConsultora = @CodigoConsultora  
			and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
			and op.TipoPersonalizacion = 'OPT'
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
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
		FROM Estrategia E with(nolock)
		INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON 
			op.CodConsultora = @codConsultoraDefault  
			and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
			and op.TipoPersonalizacion = 'OPT'
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
		WHERE
			E.Activo = 1
			AND ca.Codigo = @CampaniaID
			AND TE.FlagActivo = 1
			AND TE.flagRecoPerfil = 1
			AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
	
	END
	
	SELECT
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
	FROM #TEMPORAL T
		LEFT JOIN Marca M with(nolock) ON M.MarcaId = T.MarcaId
	ORDER BY
		Orden1 ASC, CASE WHEN ISNULL(T.Orden2,0) = 0 THEN T.Orden1 ELSE T.Orden2 END ASC, EstrategiaID ASC
	
	DROP TABLE #TEMPORAL

SET NOCOUNT OFF
END
go

go
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListarEstrategiasRevistaDigital]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ListarEstrategiasRevistaDigital]
GO

go
CREATE PROCEDURE [dbo].[ListarEstrategiasRevistaDigital]
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
		FlagMostrarImg int
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
	FROM Estrategia E with(nolock)
		INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON 
			op.CodConsultora = @CodigoConsultora  
			and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
			and op.TipoPersonalizacion in ('OPM', 'PAD')
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
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
		FROM Estrategia E with(nolock)
		INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON 
			op.CodConsultora = @codConsultoraDefault  
			and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
			and op.TipoPersonalizacion in ('OPM', 'PAD')
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
		WHERE
			E.Activo = 1
			AND ca.Codigo = @CampaniaID
			AND TE.FlagActivo = 1
			AND TE.flagRecoPerfil = 1
			AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
	
	END
	
	SELECT
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
	FROM #TEMPORAL T
		LEFT JOIN Marca M with(nolock) ON M.MarcaId = T.MarcaId
	ORDER BY
		Orden1 ASC, CASE WHEN ISNULL(T.Orden2,0) = 0 THEN T.Orden1 ELSE T.Orden2 END ASC, EstrategiaID ASC
	
	DROP TABLE #TEMPORAL

SET NOCOUNT OFF
END

go

go
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListarEstrategiasOfertaWeb]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ListarEstrategiasOfertaWeb]
GO

go
CREATE PROCEDURE [dbo].[ListarEstrategiasOfertaWeb]
	@CampaniaID INT,
	@ZonaID INT
AS
/*
dbo.ListarEstrategiasOfertaWeb 201710, ''
*/
BEGIN
SET NOCOUNT ON;
	
	SELECT
		EstrategiaID,
		CUV2,
		DescripcionCUV2,
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
		Precio,
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
		e.Orden Orden2,
		pc.IndicadorMontoMinimo,
		pc.CodigoProducto,
		te.flagNueva,
		'' as TipoTallaColor,
		4 as TipoEstrategiaImagenMostrar
		, E.EtiquetaID
		, E.EtiquetaID2
		, E.CodigoEstrategia
		, E.TieneVariedad
		, TE.CODIGO
		, TE.DescripcionEstrategia
		, ISNULL(TE.FlagMostrarImg,0) AS FlagMostrarImg	
	FROM Estrategia E with(nolock)
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
		INNER JOIN ods.Campania CA with(nolock) ON E.CampaniaID = CA.Codigo
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
	WHERE
		E.Activo = 1
		AND TE.FlagActivo = 1
		AND E.CampaniaID = @CampaniaID
		AND TE.flagRecoProduc = 0
		AND TE.flagNueva = 0
		AND TE.flagRecoPerfil = 0
		AND E.Zona LIKE '%' + Convert(varchar, @ZonaID) + '%'

SET NOCOUNT OFF
END

go

USE BelcorpMexico
GO

go
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListarEstrategiasPackNuevas]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ListarEstrategiasPackNuevas]
GO

go
CREATE PROCEDURE [dbo].[ListarEstrategiasPackNuevas]
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(30)
AS
/*
dbo.ListarEstrategiasPackNuevas 201710, ''
*/
BEGIN
SET NOCOUNT ON;
	
	declare @ZonaID VARCHAR(20) = ''
	, @NumeroPedido INT = 0

	select @ZonaID = ZonaID
		, @NumeroPedido = ConsecutivoNueva + 1
	from ods.Consultora with(nolock)
	where Codigo = @CodigoConsultora

	SELECT
		EstrategiaID,
		CUV2,
		DescripcionCUV2,
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
		Precio,
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
		e.Orden Orden2,
		pc.IndicadorMontoMinimo,
		pc.CodigoProducto,
		1 AS FlagNueva,
		'' as TipoTallaColor,
		2 as TipoEstrategiaImagenMostrar
		, E.EtiquetaID
		, E.EtiquetaID2
		, E.CodigoEstrategia
		, E.TieneVariedad
		, TE.CODIGO
		, TE.DescripcionEstrategia
		, ISNULL(TE.FlagMostrarImg,0) AS FlagMostrarImg
	FROM Estrategia E with(nolock)
		INNER JOIN TipoEstrategia TE with(nolock) ON
			E.TipoEstrategiaID = TE.TipoEstrategiaID
		INNER JOIN ods.Campania CA with(nolock) ON
			E.CampaniaID = CA.Codigo
		INNER JOIN ods.ProductoComercial PC with(nolock) ON
			PC.CampaniaID = CA.CampaniaID
			AND PC.CUV = E.CUV2
		INNER JOIN Ods.ConsultorasProgramaNuevas CPN with(nolock) ON
			CPN.CodigoConsultora = @CodigoConsultora
			AND CPN.CodigoPrograma = TE.CodigoPrograma
	WHERE
		(E.CampaniaID = @CampaniaID OR @CampaniaID between E.CampaniaID and E.CampaniaIDFin)
		AND CPN.Participa = 1
		AND TE.FlagActivo = 1
		AND TE.flagNueva = 1
		AND E.Activo = 1
		AND E.Zona LIKE '%' + @ZonaID + '%'
		AND E.NumeroPedido = @NumeroPedido
	order by
		te.Orden ASC, CASE WHEN ISNULL(e.Orden,0) = 0 THEN te.Orden ELSE e.Orden END ASC, EstrategiaID ASC


SET NOCOUNT OFF
END
go

go
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListarEstrategiasLanzamiento]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ListarEstrategiasLanzamiento]
GO

go
CREATE PROCEDURE [dbo].[ListarEstrategiasLanzamiento]
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(30)
AS
/*
dbo.ListarEstrategiasLanzamiento 201710, ''
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
		FlagMostrarImg int
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
	FROM Estrategia E with(nolock)
		INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON 
			op.CodConsultora = @CodigoConsultora  
			and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
			and op.TipoPersonalizacion = 'LAN'
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
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
		FROM Estrategia E with(nolock)
		INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON 
			op.CodConsultora = @codConsultoraDefault  
			and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
			and op.TipoPersonalizacion = 'LAN'
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
		WHERE
			E.Activo = 1
			AND ca.Codigo = @CampaniaID
			AND TE.FlagActivo = 1
			AND TE.flagRecoPerfil = 1
			AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
	
	END
	
	declare @TEMP table (
		EstrategiaID int
		, ImgFondoDesktop varchar(1000)
		, ImgPrevDesktop varchar(1000)
		, ImgSelloProductoDesktop varchar(1000)
		, UrlVideoDesktop varchar(1000)
		, ImgFichaFondoDesktop varchar(1000)
		, ImgFondoMobile varchar(1000)
		, ImgSelloProductoMobile varchar(1000)
		, UrlVideoMobile varchar(1000)
		, ImgFichaFondoMobile varchar(1000)
		, ImgHomeDesktop varchar(1000)
		, ImgHomeMobile varchar(1000)
	)

	insert into @temp 
	SELECT EstrategiaID
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10201) as ImgFondoDesktop
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10202) as ImgPrevDesktop
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10203) as ImgSelloProductoDesktop
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10204) as UrlVideoDesktop
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10208) as ImgFichaFondoDesktop
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10205) as ImgFondoMobile
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10206) as ImgSelloProductoMobile
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10207) as UrlVideoMobile
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10209) as ImgFichaFondoMobile	
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10210) as ImgHomeDesktop		
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10211) as ImgHomeMobile				
	FROM #TEMPORAL as T
	
	SELECT
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
		, D.ImgFondoDesktop
		, D.ImgPrevDesktop	
		, D.ImgSelloProductoDesktop as ImgFichaDesktop
		, D.UrlVideoDesktop 
		, D.ImgFichaFondoDesktop 
		, D.ImgFondoMobile		
		, D.ImgSelloProductoMobile as ImgFichaMobile
		, D.UrlVideoMobile  
		, D.ImgFichaFondoMobile
		, D.ImgHomeDesktop
		, D.ImgHomeMobile
	FROM #TEMPORAL T
		LEFT JOIN Marca M with(nolock) ON M.MarcaId = T.MarcaId
		LEFT JOIN @temp D ON D.EstrategiaID = T.EstrategiaID
	ORDER BY
		Orden1 ASC, CASE WHEN ISNULL(T.Orden2,0) = 0 THEN T.Orden1 ELSE T.Orden2 END ASC, EstrategiaID ASC
	
	DROP TABLE #TEMPORAL

SET NOCOUNT OFF
END

go

go
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListarEstrategiasOPT]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ListarEstrategiasOPT]
GO

go
CREATE PROCEDURE [dbo].[ListarEstrategiasOPT]
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
		FlagMostrarImg int
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
	FROM Estrategia E with(nolock)
		INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON 
			op.CodConsultora = @CodigoConsultora  
			and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
			and op.TipoPersonalizacion = 'OPT'
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
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
		FROM Estrategia E with(nolock)
		INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON 
			op.CodConsultora = @codConsultoraDefault  
			and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
			and op.TipoPersonalizacion = 'OPT'
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
		WHERE
			E.Activo = 1
			AND ca.Codigo = @CampaniaID
			AND TE.FlagActivo = 1
			AND TE.flagRecoPerfil = 1
			AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
	
	END
	
	SELECT
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
	FROM #TEMPORAL T
		LEFT JOIN Marca M with(nolock) ON M.MarcaId = T.MarcaId
	ORDER BY
		Orden1 ASC, CASE WHEN ISNULL(T.Orden2,0) = 0 THEN T.Orden1 ELSE T.Orden2 END ASC, EstrategiaID ASC
	
	DROP TABLE #TEMPORAL

SET NOCOUNT OFF
END
go

go
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListarEstrategiasRevistaDigital]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ListarEstrategiasRevistaDigital]
GO

go
CREATE PROCEDURE [dbo].[ListarEstrategiasRevistaDigital]
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
		FlagMostrarImg int
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
	FROM Estrategia E with(nolock)
		INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON 
			op.CodConsultora = @CodigoConsultora  
			and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
			and op.TipoPersonalizacion in ('OPM', 'PAD')
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
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
		FROM Estrategia E with(nolock)
		INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON 
			op.CodConsultora = @codConsultoraDefault  
			and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
			and op.TipoPersonalizacion in ('OPM', 'PAD')
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
		WHERE
			E.Activo = 1
			AND ca.Codigo = @CampaniaID
			AND TE.FlagActivo = 1
			AND TE.flagRecoPerfil = 1
			AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
	
	END
	
	SELECT
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
	FROM #TEMPORAL T
		LEFT JOIN Marca M with(nolock) ON M.MarcaId = T.MarcaId
	ORDER BY
		Orden1 ASC, CASE WHEN ISNULL(T.Orden2,0) = 0 THEN T.Orden1 ELSE T.Orden2 END ASC, EstrategiaID ASC
	
	DROP TABLE #TEMPORAL

SET NOCOUNT OFF
END

go

go
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListarEstrategiasOfertaWeb]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ListarEstrategiasOfertaWeb]
GO

go
CREATE PROCEDURE [dbo].[ListarEstrategiasOfertaWeb]
	@CampaniaID INT,
	@ZonaID INT
AS
/*
dbo.ListarEstrategiasOfertaWeb 201710, ''
*/
BEGIN
SET NOCOUNT ON;
	
	SELECT
		EstrategiaID,
		CUV2,
		DescripcionCUV2,
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
		Precio,
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
		e.Orden Orden2,
		pc.IndicadorMontoMinimo,
		pc.CodigoProducto,
		te.flagNueva,
		'' as TipoTallaColor,
		4 as TipoEstrategiaImagenMostrar
		, E.EtiquetaID
		, E.EtiquetaID2
		, E.CodigoEstrategia
		, E.TieneVariedad
		, TE.CODIGO
		, TE.DescripcionEstrategia
		, ISNULL(TE.FlagMostrarImg,0) AS FlagMostrarImg	
	FROM Estrategia E with(nolock)
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
		INNER JOIN ods.Campania CA with(nolock) ON E.CampaniaID = CA.Codigo
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
	WHERE
		E.Activo = 1
		AND TE.FlagActivo = 1
		AND E.CampaniaID = @CampaniaID
		AND TE.flagRecoProduc = 0
		AND TE.flagNueva = 0
		AND TE.flagRecoPerfil = 0
		AND E.Zona LIKE '%' + Convert(varchar, @ZonaID) + '%'

SET NOCOUNT OFF
END

go

USE BelcorpColombia
GO

go
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListarEstrategiasPackNuevas]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ListarEstrategiasPackNuevas]
GO

go
CREATE PROCEDURE [dbo].[ListarEstrategiasPackNuevas]
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(30)
AS
/*
dbo.ListarEstrategiasPackNuevas 201710, ''
*/
BEGIN
SET NOCOUNT ON;
	
	declare @ZonaID VARCHAR(20) = ''
	, @NumeroPedido INT = 0

	select @ZonaID = ZonaID
		, @NumeroPedido = ConsecutivoNueva + 1
	from ods.Consultora with(nolock)
	where Codigo = @CodigoConsultora

	SELECT
		EstrategiaID,
		CUV2,
		DescripcionCUV2,
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
		Precio,
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
		e.Orden Orden2,
		pc.IndicadorMontoMinimo,
		pc.CodigoProducto,
		1 AS FlagNueva,
		'' as TipoTallaColor,
		2 as TipoEstrategiaImagenMostrar
		, E.EtiquetaID
		, E.EtiquetaID2
		, E.CodigoEstrategia
		, E.TieneVariedad
		, TE.CODIGO
		, TE.DescripcionEstrategia
		, ISNULL(TE.FlagMostrarImg,0) AS FlagMostrarImg
	FROM Estrategia E with(nolock)
		INNER JOIN TipoEstrategia TE with(nolock) ON
			E.TipoEstrategiaID = TE.TipoEstrategiaID
		INNER JOIN ods.Campania CA with(nolock) ON
			E.CampaniaID = CA.Codigo
		INNER JOIN ods.ProductoComercial PC with(nolock) ON
			PC.CampaniaID = CA.CampaniaID
			AND PC.CUV = E.CUV2
		INNER JOIN Ods.ConsultorasProgramaNuevas CPN with(nolock) ON
			CPN.CodigoConsultora = @CodigoConsultora
			AND CPN.CodigoPrograma = TE.CodigoPrograma
	WHERE
		(E.CampaniaID = @CampaniaID OR @CampaniaID between E.CampaniaID and E.CampaniaIDFin)
		AND CPN.Participa = 1
		AND TE.FlagActivo = 1
		AND TE.flagNueva = 1
		AND E.Activo = 1
		AND E.Zona LIKE '%' + @ZonaID + '%'
		AND E.NumeroPedido = @NumeroPedido
	order by
		te.Orden ASC, CASE WHEN ISNULL(e.Orden,0) = 0 THEN te.Orden ELSE e.Orden END ASC, EstrategiaID ASC


SET NOCOUNT OFF
END
go

go
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListarEstrategiasLanzamiento]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ListarEstrategiasLanzamiento]
GO

go
CREATE PROCEDURE [dbo].[ListarEstrategiasLanzamiento]
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(30)
AS
/*
dbo.ListarEstrategiasLanzamiento 201710, ''
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
		FlagMostrarImg int
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
	FROM Estrategia E with(nolock)
		INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON 
			op.CodConsultora = @CodigoConsultora  
			and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
			and op.TipoPersonalizacion = 'LAN'
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
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
		FROM Estrategia E with(nolock)
		INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON 
			op.CodConsultora = @codConsultoraDefault  
			and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
			and op.TipoPersonalizacion = 'LAN'
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
		WHERE
			E.Activo = 1
			AND ca.Codigo = @CampaniaID
			AND TE.FlagActivo = 1
			AND TE.flagRecoPerfil = 1
			AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
	
	END
	
	declare @TEMP table (
		EstrategiaID int
		, ImgFondoDesktop varchar(1000)
		, ImgPrevDesktop varchar(1000)
		, ImgSelloProductoDesktop varchar(1000)
		, UrlVideoDesktop varchar(1000)
		, ImgFichaFondoDesktop varchar(1000)
		, ImgFondoMobile varchar(1000)
		, ImgSelloProductoMobile varchar(1000)
		, UrlVideoMobile varchar(1000)
		, ImgFichaFondoMobile varchar(1000)
		, ImgHomeDesktop varchar(1000)
		, ImgHomeMobile varchar(1000)
	)

	insert into @temp 
	SELECT EstrategiaID
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10201) as ImgFondoDesktop
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10202) as ImgPrevDesktop
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10203) as ImgSelloProductoDesktop
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10204) as UrlVideoDesktop
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10208) as ImgFichaFondoDesktop
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10205) as ImgFondoMobile
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10206) as ImgSelloProductoMobile
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10207) as UrlVideoMobile
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10209) as ImgFichaFondoMobile	
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10210) as ImgHomeDesktop		
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10211) as ImgHomeMobile				
	FROM #TEMPORAL as T
	
	SELECT
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
		, D.ImgFondoDesktop
		, D.ImgPrevDesktop	
		, D.ImgSelloProductoDesktop as ImgFichaDesktop
		, D.UrlVideoDesktop 
		, D.ImgFichaFondoDesktop 
		, D.ImgFondoMobile		
		, D.ImgSelloProductoMobile as ImgFichaMobile
		, D.UrlVideoMobile  
		, D.ImgFichaFondoMobile
		, D.ImgHomeDesktop
		, D.ImgHomeMobile
	FROM #TEMPORAL T
		LEFT JOIN Marca M with(nolock) ON M.MarcaId = T.MarcaId
		LEFT JOIN @temp D ON D.EstrategiaID = T.EstrategiaID
	ORDER BY
		Orden1 ASC, CASE WHEN ISNULL(T.Orden2,0) = 0 THEN T.Orden1 ELSE T.Orden2 END ASC, EstrategiaID ASC
	
	DROP TABLE #TEMPORAL

SET NOCOUNT OFF
END

go

go
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListarEstrategiasOPT]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ListarEstrategiasOPT]
GO

go
CREATE PROCEDURE [dbo].[ListarEstrategiasOPT]
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
		FlagMostrarImg int
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
	FROM Estrategia E with(nolock)
		INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON 
			op.CodConsultora = @CodigoConsultora  
			and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
			and op.TipoPersonalizacion = 'OPT'
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
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
		FROM Estrategia E with(nolock)
		INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON 
			op.CodConsultora = @codConsultoraDefault  
			and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
			and op.TipoPersonalizacion = 'OPT'
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
		WHERE
			E.Activo = 1
			AND ca.Codigo = @CampaniaID
			AND TE.FlagActivo = 1
			AND TE.flagRecoPerfil = 1
			AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
	
	END
	
	SELECT
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
	FROM #TEMPORAL T
		LEFT JOIN Marca M with(nolock) ON M.MarcaId = T.MarcaId
	ORDER BY
		Orden1 ASC, CASE WHEN ISNULL(T.Orden2,0) = 0 THEN T.Orden1 ELSE T.Orden2 END ASC, EstrategiaID ASC
	
	DROP TABLE #TEMPORAL

SET NOCOUNT OFF
END
go

go
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListarEstrategiasRevistaDigital]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ListarEstrategiasRevistaDigital]
GO

go
CREATE PROCEDURE [dbo].[ListarEstrategiasRevistaDigital]
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
		FlagMostrarImg int
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
	FROM Estrategia E with(nolock)
		INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON 
			op.CodConsultora = @CodigoConsultora  
			and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
			and op.TipoPersonalizacion in ('OPM', 'PAD')
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
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
		FROM Estrategia E with(nolock)
		INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON 
			op.CodConsultora = @codConsultoraDefault  
			and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
			and op.TipoPersonalizacion in ('OPM', 'PAD')
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
		WHERE
			E.Activo = 1
			AND ca.Codigo = @CampaniaID
			AND TE.FlagActivo = 1
			AND TE.flagRecoPerfil = 1
			AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
	
	END
	
	SELECT
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
	FROM #TEMPORAL T
		LEFT JOIN Marca M with(nolock) ON M.MarcaId = T.MarcaId
	ORDER BY
		Orden1 ASC, CASE WHEN ISNULL(T.Orden2,0) = 0 THEN T.Orden1 ELSE T.Orden2 END ASC, EstrategiaID ASC
	
	DROP TABLE #TEMPORAL

SET NOCOUNT OFF
END

go

go
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListarEstrategiasOfertaWeb]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ListarEstrategiasOfertaWeb]
GO

go
CREATE PROCEDURE [dbo].[ListarEstrategiasOfertaWeb]
	@CampaniaID INT,
	@ZonaID INT
AS
/*
dbo.ListarEstrategiasOfertaWeb 201710, ''
*/
BEGIN
SET NOCOUNT ON;
	
	SELECT
		EstrategiaID,
		CUV2,
		DescripcionCUV2,
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
		Precio,
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
		e.Orden Orden2,
		pc.IndicadorMontoMinimo,
		pc.CodigoProducto,
		te.flagNueva,
		'' as TipoTallaColor,
		4 as TipoEstrategiaImagenMostrar
		, E.EtiquetaID
		, E.EtiquetaID2
		, E.CodigoEstrategia
		, E.TieneVariedad
		, TE.CODIGO
		, TE.DescripcionEstrategia
		, ISNULL(TE.FlagMostrarImg,0) AS FlagMostrarImg	
	FROM Estrategia E with(nolock)
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
		INNER JOIN ods.Campania CA with(nolock) ON E.CampaniaID = CA.Codigo
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
	WHERE
		E.Activo = 1
		AND TE.FlagActivo = 1
		AND E.CampaniaID = @CampaniaID
		AND TE.flagRecoProduc = 0
		AND TE.flagNueva = 0
		AND TE.flagRecoPerfil = 0
		AND E.Zona LIKE '%' + Convert(varchar, @ZonaID) + '%'

SET NOCOUNT OFF
END

go

USE BelcorpVenezuela
GO

go
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListarEstrategiasPackNuevas]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ListarEstrategiasPackNuevas]
GO

go
CREATE PROCEDURE [dbo].[ListarEstrategiasPackNuevas]
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(30)
AS
/*
dbo.ListarEstrategiasPackNuevas 201710, ''
*/
BEGIN
SET NOCOUNT ON;
	
	declare @ZonaID VARCHAR(20) = ''
	, @NumeroPedido INT = 0

	select @ZonaID = ZonaID
		, @NumeroPedido = ConsecutivoNueva + 1
	from ods.Consultora with(nolock)
	where Codigo = @CodigoConsultora

	SELECT
		EstrategiaID,
		CUV2,
		DescripcionCUV2,
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
		Precio,
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
		e.Orden Orden2,
		pc.IndicadorMontoMinimo,
		pc.CodigoProducto,
		1 AS FlagNueva,
		'' as TipoTallaColor,
		2 as TipoEstrategiaImagenMostrar
		, E.EtiquetaID
		, E.EtiquetaID2
		, E.CodigoEstrategia
		, E.TieneVariedad
		, TE.CODIGO
		, TE.DescripcionEstrategia
		, ISNULL(TE.FlagMostrarImg,0) AS FlagMostrarImg
	FROM Estrategia E with(nolock)
		INNER JOIN TipoEstrategia TE with(nolock) ON
			E.TipoEstrategiaID = TE.TipoEstrategiaID
		INNER JOIN ods.Campania CA with(nolock) ON
			E.CampaniaID = CA.Codigo
		INNER JOIN ods.ProductoComercial PC with(nolock) ON
			PC.CampaniaID = CA.CampaniaID
			AND PC.CUV = E.CUV2
		INNER JOIN Ods.ConsultorasProgramaNuevas CPN with(nolock) ON
			CPN.CodigoConsultora = @CodigoConsultora
			AND CPN.CodigoPrograma = TE.CodigoPrograma
	WHERE
		(E.CampaniaID = @CampaniaID OR @CampaniaID between E.CampaniaID and E.CampaniaIDFin)
		AND CPN.Participa = 1
		AND TE.FlagActivo = 1
		AND TE.flagNueva = 1
		AND E.Activo = 1
		AND E.Zona LIKE '%' + @ZonaID + '%'
		AND E.NumeroPedido = @NumeroPedido
	order by
		te.Orden ASC, CASE WHEN ISNULL(e.Orden,0) = 0 THEN te.Orden ELSE e.Orden END ASC, EstrategiaID ASC


SET NOCOUNT OFF
END
go

go
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListarEstrategiasLanzamiento]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ListarEstrategiasLanzamiento]
GO

go
CREATE PROCEDURE [dbo].[ListarEstrategiasLanzamiento]
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(30)
AS
/*
dbo.ListarEstrategiasLanzamiento 201710, ''
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
		FlagMostrarImg int
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
	FROM Estrategia E with(nolock)
		INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON 
			op.CodConsultora = @CodigoConsultora  
			and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
			and op.TipoPersonalizacion = 'LAN'
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
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
		FROM Estrategia E with(nolock)
		INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON 
			op.CodConsultora = @codConsultoraDefault  
			and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
			and op.TipoPersonalizacion = 'LAN'
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
		WHERE
			E.Activo = 1
			AND ca.Codigo = @CampaniaID
			AND TE.FlagActivo = 1
			AND TE.flagRecoPerfil = 1
			AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
	
	END
	
	declare @TEMP table (
		EstrategiaID int
		, ImgFondoDesktop varchar(1000)
		, ImgPrevDesktop varchar(1000)
		, ImgSelloProductoDesktop varchar(1000)
		, UrlVideoDesktop varchar(1000)
		, ImgFichaFondoDesktop varchar(1000)
		, ImgFondoMobile varchar(1000)
		, ImgSelloProductoMobile varchar(1000)
		, UrlVideoMobile varchar(1000)
		, ImgFichaFondoMobile varchar(1000)
		, ImgHomeDesktop varchar(1000)
		, ImgHomeMobile varchar(1000)
	)

	insert into @temp 
	SELECT EstrategiaID
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10201) as ImgFondoDesktop
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10202) as ImgPrevDesktop
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10203) as ImgSelloProductoDesktop
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10204) as UrlVideoDesktop
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10208) as ImgFichaFondoDesktop
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10205) as ImgFondoMobile
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10206) as ImgSelloProductoMobile
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10207) as UrlVideoMobile
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10209) as ImgFichaFondoMobile	
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10210) as ImgHomeDesktop		
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10211) as ImgHomeMobile				
	FROM #TEMPORAL as T
	
	SELECT
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
		, D.ImgFondoDesktop
		, D.ImgPrevDesktop	
		, D.ImgSelloProductoDesktop as ImgFichaDesktop
		, D.UrlVideoDesktop 
		, D.ImgFichaFondoDesktop 
		, D.ImgFondoMobile		
		, D.ImgSelloProductoMobile as ImgFichaMobile
		, D.UrlVideoMobile  
		, D.ImgFichaFondoMobile
		, D.ImgHomeDesktop
		, D.ImgHomeMobile
	FROM #TEMPORAL T
		LEFT JOIN Marca M with(nolock) ON M.MarcaId = T.MarcaId
		LEFT JOIN @temp D ON D.EstrategiaID = T.EstrategiaID
	ORDER BY
		Orden1 ASC, CASE WHEN ISNULL(T.Orden2,0) = 0 THEN T.Orden1 ELSE T.Orden2 END ASC, EstrategiaID ASC
	
	DROP TABLE #TEMPORAL

SET NOCOUNT OFF
END

go

go
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListarEstrategiasOPT]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ListarEstrategiasOPT]
GO

go
CREATE PROCEDURE [dbo].[ListarEstrategiasOPT]
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
		FlagMostrarImg int
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
	FROM Estrategia E with(nolock)
		INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON 
			op.CodConsultora = @CodigoConsultora  
			and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
			and op.TipoPersonalizacion = 'OPT'
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
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
		FROM Estrategia E with(nolock)
		INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON 
			op.CodConsultora = @codConsultoraDefault  
			and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
			and op.TipoPersonalizacion = 'OPT'
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
		WHERE
			E.Activo = 1
			AND ca.Codigo = @CampaniaID
			AND TE.FlagActivo = 1
			AND TE.flagRecoPerfil = 1
			AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
	
	END
	
	SELECT
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
	FROM #TEMPORAL T
		LEFT JOIN Marca M with(nolock) ON M.MarcaId = T.MarcaId
	ORDER BY
		Orden1 ASC, CASE WHEN ISNULL(T.Orden2,0) = 0 THEN T.Orden1 ELSE T.Orden2 END ASC, EstrategiaID ASC
	
	DROP TABLE #TEMPORAL

SET NOCOUNT OFF
END
go

go
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListarEstrategiasRevistaDigital]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ListarEstrategiasRevistaDigital]
GO

go
CREATE PROCEDURE [dbo].[ListarEstrategiasRevistaDigital]
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
		FlagMostrarImg int
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
	FROM Estrategia E with(nolock)
		INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON 
			op.CodConsultora = @CodigoConsultora  
			and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
			and op.TipoPersonalizacion in ('OPM', 'PAD')
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
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
		FROM Estrategia E with(nolock)
		INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON 
			op.CodConsultora = @codConsultoraDefault  
			and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
			and op.TipoPersonalizacion in ('OPM', 'PAD')
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
		WHERE
			E.Activo = 1
			AND ca.Codigo = @CampaniaID
			AND TE.FlagActivo = 1
			AND TE.flagRecoPerfil = 1
			AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
	
	END
	
	SELECT
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
	FROM #TEMPORAL T
		LEFT JOIN Marca M with(nolock) ON M.MarcaId = T.MarcaId
	ORDER BY
		Orden1 ASC, CASE WHEN ISNULL(T.Orden2,0) = 0 THEN T.Orden1 ELSE T.Orden2 END ASC, EstrategiaID ASC
	
	DROP TABLE #TEMPORAL

SET NOCOUNT OFF
END

go

go
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListarEstrategiasOfertaWeb]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ListarEstrategiasOfertaWeb]
GO

go
CREATE PROCEDURE [dbo].[ListarEstrategiasOfertaWeb]
	@CampaniaID INT,
	@ZonaID INT
AS
/*
dbo.ListarEstrategiasOfertaWeb 201710, ''
*/
BEGIN
SET NOCOUNT ON;
	
	SELECT
		EstrategiaID,
		CUV2,
		DescripcionCUV2,
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
		Precio,
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
		e.Orden Orden2,
		pc.IndicadorMontoMinimo,
		pc.CodigoProducto,
		te.flagNueva,
		'' as TipoTallaColor,
		4 as TipoEstrategiaImagenMostrar
		, E.EtiquetaID
		, E.EtiquetaID2
		, E.CodigoEstrategia
		, E.TieneVariedad
		, TE.CODIGO
		, TE.DescripcionEstrategia
		, ISNULL(TE.FlagMostrarImg,0) AS FlagMostrarImg	
	FROM Estrategia E with(nolock)
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
		INNER JOIN ods.Campania CA with(nolock) ON E.CampaniaID = CA.Codigo
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
	WHERE
		E.Activo = 1
		AND TE.FlagActivo = 1
		AND E.CampaniaID = @CampaniaID
		AND TE.flagRecoProduc = 0
		AND TE.flagNueva = 0
		AND TE.flagRecoPerfil = 0
		AND E.Zona LIKE '%' + Convert(varchar, @ZonaID) + '%'

SET NOCOUNT OFF
END

go

USE BelcorpSalvador
GO

go
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListarEstrategiasPackNuevas]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ListarEstrategiasPackNuevas]
GO

go
CREATE PROCEDURE [dbo].[ListarEstrategiasPackNuevas]
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(30)
AS
/*
dbo.ListarEstrategiasPackNuevas 201710, ''
*/
BEGIN
SET NOCOUNT ON;
	
	declare @ZonaID VARCHAR(20) = ''
	, @NumeroPedido INT = 0

	select @ZonaID = ZonaID
		, @NumeroPedido = ConsecutivoNueva + 1
	from ods.Consultora with(nolock)
	where Codigo = @CodigoConsultora

	SELECT
		EstrategiaID,
		CUV2,
		DescripcionCUV2,
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
		Precio,
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
		e.Orden Orden2,
		pc.IndicadorMontoMinimo,
		pc.CodigoProducto,
		1 AS FlagNueva,
		'' as TipoTallaColor,
		2 as TipoEstrategiaImagenMostrar
		, E.EtiquetaID
		, E.EtiquetaID2
		, E.CodigoEstrategia
		, E.TieneVariedad
		, TE.CODIGO
		, TE.DescripcionEstrategia
		, ISNULL(TE.FlagMostrarImg,0) AS FlagMostrarImg
	FROM Estrategia E with(nolock)
		INNER JOIN TipoEstrategia TE with(nolock) ON
			E.TipoEstrategiaID = TE.TipoEstrategiaID
		INNER JOIN ods.Campania CA with(nolock) ON
			E.CampaniaID = CA.Codigo
		INNER JOIN ods.ProductoComercial PC with(nolock) ON
			PC.CampaniaID = CA.CampaniaID
			AND PC.CUV = E.CUV2
		INNER JOIN Ods.ConsultorasProgramaNuevas CPN with(nolock) ON
			CPN.CodigoConsultora = @CodigoConsultora
			AND CPN.CodigoPrograma = TE.CodigoPrograma
	WHERE
		(E.CampaniaID = @CampaniaID OR @CampaniaID between E.CampaniaID and E.CampaniaIDFin)
		AND CPN.Participa = 1
		AND TE.FlagActivo = 1
		AND TE.flagNueva = 1
		AND E.Activo = 1
		AND E.Zona LIKE '%' + @ZonaID + '%'
		AND E.NumeroPedido = @NumeroPedido
	order by
		te.Orden ASC, CASE WHEN ISNULL(e.Orden,0) = 0 THEN te.Orden ELSE e.Orden END ASC, EstrategiaID ASC


SET NOCOUNT OFF
END
go

go
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListarEstrategiasLanzamiento]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ListarEstrategiasLanzamiento]
GO

go
CREATE PROCEDURE [dbo].[ListarEstrategiasLanzamiento]
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(30)
AS
/*
dbo.ListarEstrategiasLanzamiento 201710, ''
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
		FlagMostrarImg int
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
	FROM Estrategia E with(nolock)
		INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON 
			op.CodConsultora = @CodigoConsultora  
			and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
			and op.TipoPersonalizacion = 'LAN'
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
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
		FROM Estrategia E with(nolock)
		INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON 
			op.CodConsultora = @codConsultoraDefault  
			and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
			and op.TipoPersonalizacion = 'LAN'
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
		WHERE
			E.Activo = 1
			AND ca.Codigo = @CampaniaID
			AND TE.FlagActivo = 1
			AND TE.flagRecoPerfil = 1
			AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
	
	END
	
	declare @TEMP table (
		EstrategiaID int
		, ImgFondoDesktop varchar(1000)
		, ImgPrevDesktop varchar(1000)
		, ImgSelloProductoDesktop varchar(1000)
		, UrlVideoDesktop varchar(1000)
		, ImgFichaFondoDesktop varchar(1000)
		, ImgFondoMobile varchar(1000)
		, ImgSelloProductoMobile varchar(1000)
		, UrlVideoMobile varchar(1000)
		, ImgFichaFondoMobile varchar(1000)
		, ImgHomeDesktop varchar(1000)
		, ImgHomeMobile varchar(1000)
	)

	insert into @temp 
	SELECT EstrategiaID
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10201) as ImgFondoDesktop
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10202) as ImgPrevDesktop
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10203) as ImgSelloProductoDesktop
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10204) as UrlVideoDesktop
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10208) as ImgFichaFondoDesktop
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10205) as ImgFondoMobile
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10206) as ImgSelloProductoMobile
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10207) as UrlVideoMobile
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10209) as ImgFichaFondoMobile	
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10210) as ImgHomeDesktop		
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10211) as ImgHomeMobile				
	FROM #TEMPORAL as T
	
	SELECT
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
		, D.ImgFondoDesktop
		, D.ImgPrevDesktop	
		, D.ImgSelloProductoDesktop as ImgFichaDesktop
		, D.UrlVideoDesktop 
		, D.ImgFichaFondoDesktop 
		, D.ImgFondoMobile		
		, D.ImgSelloProductoMobile as ImgFichaMobile
		, D.UrlVideoMobile  
		, D.ImgFichaFondoMobile
		, D.ImgHomeDesktop
		, D.ImgHomeMobile
	FROM #TEMPORAL T
		LEFT JOIN Marca M with(nolock) ON M.MarcaId = T.MarcaId
		LEFT JOIN @temp D ON D.EstrategiaID = T.EstrategiaID
	ORDER BY
		Orden1 ASC, CASE WHEN ISNULL(T.Orden2,0) = 0 THEN T.Orden1 ELSE T.Orden2 END ASC, EstrategiaID ASC
	
	DROP TABLE #TEMPORAL

SET NOCOUNT OFF
END

go

go
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListarEstrategiasOPT]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ListarEstrategiasOPT]
GO

go
CREATE PROCEDURE [dbo].[ListarEstrategiasOPT]
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
		FlagMostrarImg int
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
	FROM Estrategia E with(nolock)
		INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON 
			op.CodConsultora = @CodigoConsultora  
			and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
			and op.TipoPersonalizacion = 'OPT'
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
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
		FROM Estrategia E with(nolock)
		INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON 
			op.CodConsultora = @codConsultoraDefault  
			and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
			and op.TipoPersonalizacion = 'OPT'
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
		WHERE
			E.Activo = 1
			AND ca.Codigo = @CampaniaID
			AND TE.FlagActivo = 1
			AND TE.flagRecoPerfil = 1
			AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
	
	END
	
	SELECT
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
	FROM #TEMPORAL T
		LEFT JOIN Marca M with(nolock) ON M.MarcaId = T.MarcaId
	ORDER BY
		Orden1 ASC, CASE WHEN ISNULL(T.Orden2,0) = 0 THEN T.Orden1 ELSE T.Orden2 END ASC, EstrategiaID ASC
	
	DROP TABLE #TEMPORAL

SET NOCOUNT OFF
END
go

go
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListarEstrategiasRevistaDigital]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ListarEstrategiasRevistaDigital]
GO

go
CREATE PROCEDURE [dbo].[ListarEstrategiasRevistaDigital]
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
		FlagMostrarImg int
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
	FROM Estrategia E with(nolock)
		INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON 
			op.CodConsultora = @CodigoConsultora  
			and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
			and op.TipoPersonalizacion in ('OPM', 'PAD')
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
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
		FROM Estrategia E with(nolock)
		INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON 
			op.CodConsultora = @codConsultoraDefault  
			and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
			and op.TipoPersonalizacion in ('OPM', 'PAD')
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
		WHERE
			E.Activo = 1
			AND ca.Codigo = @CampaniaID
			AND TE.FlagActivo = 1
			AND TE.flagRecoPerfil = 1
			AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
	
	END
	
	SELECT
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
	FROM #TEMPORAL T
		LEFT JOIN Marca M with(nolock) ON M.MarcaId = T.MarcaId
	ORDER BY
		Orden1 ASC, CASE WHEN ISNULL(T.Orden2,0) = 0 THEN T.Orden1 ELSE T.Orden2 END ASC, EstrategiaID ASC
	
	DROP TABLE #TEMPORAL

SET NOCOUNT OFF
END

go

go
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListarEstrategiasOfertaWeb]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ListarEstrategiasOfertaWeb]
GO

go
CREATE PROCEDURE [dbo].[ListarEstrategiasOfertaWeb]
	@CampaniaID INT,
	@ZonaID INT
AS
/*
dbo.ListarEstrategiasOfertaWeb 201710, ''
*/
BEGIN
SET NOCOUNT ON;
	
	SELECT
		EstrategiaID,
		CUV2,
		DescripcionCUV2,
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
		Precio,
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
		e.Orden Orden2,
		pc.IndicadorMontoMinimo,
		pc.CodigoProducto,
		te.flagNueva,
		'' as TipoTallaColor,
		4 as TipoEstrategiaImagenMostrar
		, E.EtiquetaID
		, E.EtiquetaID2
		, E.CodigoEstrategia
		, E.TieneVariedad
		, TE.CODIGO
		, TE.DescripcionEstrategia
		, ISNULL(TE.FlagMostrarImg,0) AS FlagMostrarImg	
	FROM Estrategia E with(nolock)
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
		INNER JOIN ods.Campania CA with(nolock) ON E.CampaniaID = CA.Codigo
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
	WHERE
		E.Activo = 1
		AND TE.FlagActivo = 1
		AND E.CampaniaID = @CampaniaID
		AND TE.flagRecoProduc = 0
		AND TE.flagNueva = 0
		AND TE.flagRecoPerfil = 0
		AND E.Zona LIKE '%' + Convert(varchar, @ZonaID) + '%'

SET NOCOUNT OFF
END

go

USE BelcorpPuertoRico
GO

go
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListarEstrategiasPackNuevas]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ListarEstrategiasPackNuevas]
GO

go
CREATE PROCEDURE [dbo].[ListarEstrategiasPackNuevas]
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(30)
AS
/*
dbo.ListarEstrategiasPackNuevas 201710, ''
*/
BEGIN
SET NOCOUNT ON;
	
	declare @ZonaID VARCHAR(20) = ''
	, @NumeroPedido INT = 0

	select @ZonaID = ZonaID
		, @NumeroPedido = ConsecutivoNueva + 1
	from ods.Consultora with(nolock)
	where Codigo = @CodigoConsultora

	SELECT
		EstrategiaID,
		CUV2,
		DescripcionCUV2,
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
		Precio,
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
		e.Orden Orden2,
		pc.IndicadorMontoMinimo,
		pc.CodigoProducto,
		1 AS FlagNueva,
		'' as TipoTallaColor,
		2 as TipoEstrategiaImagenMostrar
		, E.EtiquetaID
		, E.EtiquetaID2
		, E.CodigoEstrategia
		, E.TieneVariedad
		, TE.CODIGO
		, TE.DescripcionEstrategia
		, ISNULL(TE.FlagMostrarImg,0) AS FlagMostrarImg
	FROM Estrategia E with(nolock)
		INNER JOIN TipoEstrategia TE with(nolock) ON
			E.TipoEstrategiaID = TE.TipoEstrategiaID
		INNER JOIN ods.Campania CA with(nolock) ON
			E.CampaniaID = CA.Codigo
		INNER JOIN ods.ProductoComercial PC with(nolock) ON
			PC.CampaniaID = CA.CampaniaID
			AND PC.CUV = E.CUV2
		INNER JOIN Ods.ConsultorasProgramaNuevas CPN with(nolock) ON
			CPN.CodigoConsultora = @CodigoConsultora
			AND CPN.CodigoPrograma = TE.CodigoPrograma
	WHERE
		(E.CampaniaID = @CampaniaID OR @CampaniaID between E.CampaniaID and E.CampaniaIDFin)
		AND CPN.Participa = 1
		AND TE.FlagActivo = 1
		AND TE.flagNueva = 1
		AND E.Activo = 1
		AND E.Zona LIKE '%' + @ZonaID + '%'
		AND E.NumeroPedido = @NumeroPedido
	order by
		te.Orden ASC, CASE WHEN ISNULL(e.Orden,0) = 0 THEN te.Orden ELSE e.Orden END ASC, EstrategiaID ASC


SET NOCOUNT OFF
END
go

go
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListarEstrategiasLanzamiento]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ListarEstrategiasLanzamiento]
GO

go
CREATE PROCEDURE [dbo].[ListarEstrategiasLanzamiento]
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(30)
AS
/*
dbo.ListarEstrategiasLanzamiento 201710, ''
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
		FlagMostrarImg int
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
	FROM Estrategia E with(nolock)
		INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON 
			op.CodConsultora = @CodigoConsultora  
			and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
			and op.TipoPersonalizacion = 'LAN'
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
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
		FROM Estrategia E with(nolock)
		INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON 
			op.CodConsultora = @codConsultoraDefault  
			and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
			and op.TipoPersonalizacion = 'LAN'
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
		WHERE
			E.Activo = 1
			AND ca.Codigo = @CampaniaID
			AND TE.FlagActivo = 1
			AND TE.flagRecoPerfil = 1
			AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
	
	END
	
	declare @TEMP table (
		EstrategiaID int
		, ImgFondoDesktop varchar(1000)
		, ImgPrevDesktop varchar(1000)
		, ImgSelloProductoDesktop varchar(1000)
		, UrlVideoDesktop varchar(1000)
		, ImgFichaFondoDesktop varchar(1000)
		, ImgFondoMobile varchar(1000)
		, ImgSelloProductoMobile varchar(1000)
		, UrlVideoMobile varchar(1000)
		, ImgFichaFondoMobile varchar(1000)
		, ImgHomeDesktop varchar(1000)
		, ImgHomeMobile varchar(1000)
	)

	insert into @temp 
	SELECT EstrategiaID
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10201) as ImgFondoDesktop
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10202) as ImgPrevDesktop
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10203) as ImgSelloProductoDesktop
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10204) as UrlVideoDesktop
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10208) as ImgFichaFondoDesktop
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10205) as ImgFondoMobile
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10206) as ImgSelloProductoMobile
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10207) as UrlVideoMobile
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10209) as ImgFichaFondoMobile	
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10210) as ImgHomeDesktop		
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10211) as ImgHomeMobile				
	FROM #TEMPORAL as T
	
	SELECT
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
		, D.ImgFondoDesktop
		, D.ImgPrevDesktop	
		, D.ImgSelloProductoDesktop as ImgFichaDesktop
		, D.UrlVideoDesktop 
		, D.ImgFichaFondoDesktop 
		, D.ImgFondoMobile		
		, D.ImgSelloProductoMobile as ImgFichaMobile
		, D.UrlVideoMobile  
		, D.ImgFichaFondoMobile
		, D.ImgHomeDesktop
		, D.ImgHomeMobile
	FROM #TEMPORAL T
		LEFT JOIN Marca M with(nolock) ON M.MarcaId = T.MarcaId
		LEFT JOIN @temp D ON D.EstrategiaID = T.EstrategiaID
	ORDER BY
		Orden1 ASC, CASE WHEN ISNULL(T.Orden2,0) = 0 THEN T.Orden1 ELSE T.Orden2 END ASC, EstrategiaID ASC
	
	DROP TABLE #TEMPORAL

SET NOCOUNT OFF
END

go

go
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListarEstrategiasOPT]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ListarEstrategiasOPT]
GO

go
CREATE PROCEDURE [dbo].[ListarEstrategiasOPT]
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
		FlagMostrarImg int
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
	FROM Estrategia E with(nolock)
		INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON 
			op.CodConsultora = @CodigoConsultora  
			and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
			and op.TipoPersonalizacion = 'OPT'
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
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
		FROM Estrategia E with(nolock)
		INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON 
			op.CodConsultora = @codConsultoraDefault  
			and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
			and op.TipoPersonalizacion = 'OPT'
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
		WHERE
			E.Activo = 1
			AND ca.Codigo = @CampaniaID
			AND TE.FlagActivo = 1
			AND TE.flagRecoPerfil = 1
			AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
	
	END
	
	SELECT
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
	FROM #TEMPORAL T
		LEFT JOIN Marca M with(nolock) ON M.MarcaId = T.MarcaId
	ORDER BY
		Orden1 ASC, CASE WHEN ISNULL(T.Orden2,0) = 0 THEN T.Orden1 ELSE T.Orden2 END ASC, EstrategiaID ASC
	
	DROP TABLE #TEMPORAL

SET NOCOUNT OFF
END
go

go
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListarEstrategiasRevistaDigital]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ListarEstrategiasRevistaDigital]
GO

go
CREATE PROCEDURE [dbo].[ListarEstrategiasRevistaDigital]
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
		FlagMostrarImg int
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
	FROM Estrategia E with(nolock)
		INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON 
			op.CodConsultora = @CodigoConsultora  
			and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
			and op.TipoPersonalizacion in ('OPM', 'PAD')
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
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
		FROM Estrategia E with(nolock)
		INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON 
			op.CodConsultora = @codConsultoraDefault  
			and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
			and op.TipoPersonalizacion in ('OPM', 'PAD')
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
		WHERE
			E.Activo = 1
			AND ca.Codigo = @CampaniaID
			AND TE.FlagActivo = 1
			AND TE.flagRecoPerfil = 1
			AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
	
	END
	
	SELECT
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
	FROM #TEMPORAL T
		LEFT JOIN Marca M with(nolock) ON M.MarcaId = T.MarcaId
	ORDER BY
		Orden1 ASC, CASE WHEN ISNULL(T.Orden2,0) = 0 THEN T.Orden1 ELSE T.Orden2 END ASC, EstrategiaID ASC
	
	DROP TABLE #TEMPORAL

SET NOCOUNT OFF
END

go

go
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListarEstrategiasOfertaWeb]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ListarEstrategiasOfertaWeb]
GO

go
CREATE PROCEDURE [dbo].[ListarEstrategiasOfertaWeb]
	@CampaniaID INT,
	@ZonaID INT
AS
/*
dbo.ListarEstrategiasOfertaWeb 201710, ''
*/
BEGIN
SET NOCOUNT ON;
	
	SELECT
		EstrategiaID,
		CUV2,
		DescripcionCUV2,
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
		Precio,
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
		e.Orden Orden2,
		pc.IndicadorMontoMinimo,
		pc.CodigoProducto,
		te.flagNueva,
		'' as TipoTallaColor,
		4 as TipoEstrategiaImagenMostrar
		, E.EtiquetaID
		, E.EtiquetaID2
		, E.CodigoEstrategia
		, E.TieneVariedad
		, TE.CODIGO
		, TE.DescripcionEstrategia
		, ISNULL(TE.FlagMostrarImg,0) AS FlagMostrarImg	
	FROM Estrategia E with(nolock)
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
		INNER JOIN ods.Campania CA with(nolock) ON E.CampaniaID = CA.Codigo
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
	WHERE
		E.Activo = 1
		AND TE.FlagActivo = 1
		AND E.CampaniaID = @CampaniaID
		AND TE.flagRecoProduc = 0
		AND TE.flagNueva = 0
		AND TE.flagRecoPerfil = 0
		AND E.Zona LIKE '%' + Convert(varchar, @ZonaID) + '%'

SET NOCOUNT OFF
END

go

USE BelcorpPanama
GO

go
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListarEstrategiasPackNuevas]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ListarEstrategiasPackNuevas]
GO

go
CREATE PROCEDURE [dbo].[ListarEstrategiasPackNuevas]
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(30)
AS
/*
dbo.ListarEstrategiasPackNuevas 201710, ''
*/
BEGIN
SET NOCOUNT ON;
	
	declare @ZonaID VARCHAR(20) = ''
	, @NumeroPedido INT = 0

	select @ZonaID = ZonaID
		, @NumeroPedido = ConsecutivoNueva + 1
	from ods.Consultora with(nolock)
	where Codigo = @CodigoConsultora

	SELECT
		EstrategiaID,
		CUV2,
		DescripcionCUV2,
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
		Precio,
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
		e.Orden Orden2,
		pc.IndicadorMontoMinimo,
		pc.CodigoProducto,
		1 AS FlagNueva,
		'' as TipoTallaColor,
		2 as TipoEstrategiaImagenMostrar
		, E.EtiquetaID
		, E.EtiquetaID2
		, E.CodigoEstrategia
		, E.TieneVariedad
		, TE.CODIGO
		, TE.DescripcionEstrategia
		, ISNULL(TE.FlagMostrarImg,0) AS FlagMostrarImg
	FROM Estrategia E with(nolock)
		INNER JOIN TipoEstrategia TE with(nolock) ON
			E.TipoEstrategiaID = TE.TipoEstrategiaID
		INNER JOIN ods.Campania CA with(nolock) ON
			E.CampaniaID = CA.Codigo
		INNER JOIN ods.ProductoComercial PC with(nolock) ON
			PC.CampaniaID = CA.CampaniaID
			AND PC.CUV = E.CUV2
		INNER JOIN Ods.ConsultorasProgramaNuevas CPN with(nolock) ON
			CPN.CodigoConsultora = @CodigoConsultora
			AND CPN.CodigoPrograma = TE.CodigoPrograma
	WHERE
		(E.CampaniaID = @CampaniaID OR @CampaniaID between E.CampaniaID and E.CampaniaIDFin)
		AND CPN.Participa = 1
		AND TE.FlagActivo = 1
		AND TE.flagNueva = 1
		AND E.Activo = 1
		AND E.Zona LIKE '%' + @ZonaID + '%'
		AND E.NumeroPedido = @NumeroPedido
	order by
		te.Orden ASC, CASE WHEN ISNULL(e.Orden,0) = 0 THEN te.Orden ELSE e.Orden END ASC, EstrategiaID ASC


SET NOCOUNT OFF
END
go

go
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListarEstrategiasLanzamiento]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ListarEstrategiasLanzamiento]
GO

go
CREATE PROCEDURE [dbo].[ListarEstrategiasLanzamiento]
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(30)
AS
/*
dbo.ListarEstrategiasLanzamiento 201710, ''
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
		FlagMostrarImg int
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
	FROM Estrategia E with(nolock)
		INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON 
			op.CodConsultora = @CodigoConsultora  
			and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
			and op.TipoPersonalizacion = 'LAN'
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
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
		FROM Estrategia E with(nolock)
		INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON 
			op.CodConsultora = @codConsultoraDefault  
			and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
			and op.TipoPersonalizacion = 'LAN'
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
		WHERE
			E.Activo = 1
			AND ca.Codigo = @CampaniaID
			AND TE.FlagActivo = 1
			AND TE.flagRecoPerfil = 1
			AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
	
	END
	
	declare @TEMP table (
		EstrategiaID int
		, ImgFondoDesktop varchar(1000)
		, ImgPrevDesktop varchar(1000)
		, ImgSelloProductoDesktop varchar(1000)
		, UrlVideoDesktop varchar(1000)
		, ImgFichaFondoDesktop varchar(1000)
		, ImgFondoMobile varchar(1000)
		, ImgSelloProductoMobile varchar(1000)
		, UrlVideoMobile varchar(1000)
		, ImgFichaFondoMobile varchar(1000)
		, ImgHomeDesktop varchar(1000)
		, ImgHomeMobile varchar(1000)
	)

	insert into @temp 
	SELECT EstrategiaID
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10201) as ImgFondoDesktop
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10202) as ImgPrevDesktop
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10203) as ImgSelloProductoDesktop
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10204) as UrlVideoDesktop
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10208) as ImgFichaFondoDesktop
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10205) as ImgFondoMobile
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10206) as ImgSelloProductoMobile
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10207) as UrlVideoMobile
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10209) as ImgFichaFondoMobile	
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10210) as ImgHomeDesktop		
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10211) as ImgHomeMobile				
	FROM #TEMPORAL as T
	
	SELECT
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
		, D.ImgFondoDesktop
		, D.ImgPrevDesktop	
		, D.ImgSelloProductoDesktop as ImgFichaDesktop
		, D.UrlVideoDesktop 
		, D.ImgFichaFondoDesktop 
		, D.ImgFondoMobile		
		, D.ImgSelloProductoMobile as ImgFichaMobile
		, D.UrlVideoMobile  
		, D.ImgFichaFondoMobile
		, D.ImgHomeDesktop
		, D.ImgHomeMobile
	FROM #TEMPORAL T
		LEFT JOIN Marca M with(nolock) ON M.MarcaId = T.MarcaId
		LEFT JOIN @temp D ON D.EstrategiaID = T.EstrategiaID
	ORDER BY
		Orden1 ASC, CASE WHEN ISNULL(T.Orden2,0) = 0 THEN T.Orden1 ELSE T.Orden2 END ASC, EstrategiaID ASC
	
	DROP TABLE #TEMPORAL

SET NOCOUNT OFF
END

go

go
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListarEstrategiasOPT]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ListarEstrategiasOPT]
GO

go
CREATE PROCEDURE [dbo].[ListarEstrategiasOPT]
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
		FlagMostrarImg int
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
	FROM Estrategia E with(nolock)
		INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON 
			op.CodConsultora = @CodigoConsultora  
			and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
			and op.TipoPersonalizacion = 'OPT'
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
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
		FROM Estrategia E with(nolock)
		INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON 
			op.CodConsultora = @codConsultoraDefault  
			and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
			and op.TipoPersonalizacion = 'OPT'
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
		WHERE
			E.Activo = 1
			AND ca.Codigo = @CampaniaID
			AND TE.FlagActivo = 1
			AND TE.flagRecoPerfil = 1
			AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
	
	END
	
	SELECT
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
	FROM #TEMPORAL T
		LEFT JOIN Marca M with(nolock) ON M.MarcaId = T.MarcaId
	ORDER BY
		Orden1 ASC, CASE WHEN ISNULL(T.Orden2,0) = 0 THEN T.Orden1 ELSE T.Orden2 END ASC, EstrategiaID ASC
	
	DROP TABLE #TEMPORAL

SET NOCOUNT OFF
END
go

go
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListarEstrategiasRevistaDigital]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ListarEstrategiasRevistaDigital]
GO

go
CREATE PROCEDURE [dbo].[ListarEstrategiasRevistaDigital]
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
		FlagMostrarImg int
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
	FROM Estrategia E with(nolock)
		INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON 
			op.CodConsultora = @CodigoConsultora  
			and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
			and op.TipoPersonalizacion in ('OPM', 'PAD')
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
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
		FROM Estrategia E with(nolock)
		INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON 
			op.CodConsultora = @codConsultoraDefault  
			and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
			and op.TipoPersonalizacion in ('OPM', 'PAD')
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
		WHERE
			E.Activo = 1
			AND ca.Codigo = @CampaniaID
			AND TE.FlagActivo = 1
			AND TE.flagRecoPerfil = 1
			AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
	
	END
	
	SELECT
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
	FROM #TEMPORAL T
		LEFT JOIN Marca M with(nolock) ON M.MarcaId = T.MarcaId
	ORDER BY
		Orden1 ASC, CASE WHEN ISNULL(T.Orden2,0) = 0 THEN T.Orden1 ELSE T.Orden2 END ASC, EstrategiaID ASC
	
	DROP TABLE #TEMPORAL

SET NOCOUNT OFF
END

go

go
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListarEstrategiasOfertaWeb]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ListarEstrategiasOfertaWeb]
GO

go
CREATE PROCEDURE [dbo].[ListarEstrategiasOfertaWeb]
	@CampaniaID INT,
	@ZonaID INT
AS
/*
dbo.ListarEstrategiasOfertaWeb 201710, ''
*/
BEGIN
SET NOCOUNT ON;
	
	SELECT
		EstrategiaID,
		CUV2,
		DescripcionCUV2,
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
		Precio,
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
		e.Orden Orden2,
		pc.IndicadorMontoMinimo,
		pc.CodigoProducto,
		te.flagNueva,
		'' as TipoTallaColor,
		4 as TipoEstrategiaImagenMostrar
		, E.EtiquetaID
		, E.EtiquetaID2
		, E.CodigoEstrategia
		, E.TieneVariedad
		, TE.CODIGO
		, TE.DescripcionEstrategia
		, ISNULL(TE.FlagMostrarImg,0) AS FlagMostrarImg	
	FROM Estrategia E with(nolock)
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
		INNER JOIN ods.Campania CA with(nolock) ON E.CampaniaID = CA.Codigo
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
	WHERE
		E.Activo = 1
		AND TE.FlagActivo = 1
		AND E.CampaniaID = @CampaniaID
		AND TE.flagRecoProduc = 0
		AND TE.flagNueva = 0
		AND TE.flagRecoPerfil = 0
		AND E.Zona LIKE '%' + Convert(varchar, @ZonaID) + '%'

SET NOCOUNT OFF
END

go

USE BelcorpGuatemala
GO

go
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListarEstrategiasPackNuevas]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ListarEstrategiasPackNuevas]
GO

go
CREATE PROCEDURE [dbo].[ListarEstrategiasPackNuevas]
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(30)
AS
/*
dbo.ListarEstrategiasPackNuevas 201710, ''
*/
BEGIN
SET NOCOUNT ON;
	
	declare @ZonaID VARCHAR(20) = ''
	, @NumeroPedido INT = 0

	select @ZonaID = ZonaID
		, @NumeroPedido = ConsecutivoNueva + 1
	from ods.Consultora with(nolock)
	where Codigo = @CodigoConsultora

	SELECT
		EstrategiaID,
		CUV2,
		DescripcionCUV2,
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
		Precio,
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
		e.Orden Orden2,
		pc.IndicadorMontoMinimo,
		pc.CodigoProducto,
		1 AS FlagNueva,
		'' as TipoTallaColor,
		2 as TipoEstrategiaImagenMostrar
		, E.EtiquetaID
		, E.EtiquetaID2
		, E.CodigoEstrategia
		, E.TieneVariedad
		, TE.CODIGO
		, TE.DescripcionEstrategia
		, ISNULL(TE.FlagMostrarImg,0) AS FlagMostrarImg
	FROM Estrategia E with(nolock)
		INNER JOIN TipoEstrategia TE with(nolock) ON
			E.TipoEstrategiaID = TE.TipoEstrategiaID
		INNER JOIN ods.Campania CA with(nolock) ON
			E.CampaniaID = CA.Codigo
		INNER JOIN ods.ProductoComercial PC with(nolock) ON
			PC.CampaniaID = CA.CampaniaID
			AND PC.CUV = E.CUV2
		INNER JOIN Ods.ConsultorasProgramaNuevas CPN with(nolock) ON
			CPN.CodigoConsultora = @CodigoConsultora
			AND CPN.CodigoPrograma = TE.CodigoPrograma
	WHERE
		(E.CampaniaID = @CampaniaID OR @CampaniaID between E.CampaniaID and E.CampaniaIDFin)
		AND CPN.Participa = 1
		AND TE.FlagActivo = 1
		AND TE.flagNueva = 1
		AND E.Activo = 1
		AND E.Zona LIKE '%' + @ZonaID + '%'
		AND E.NumeroPedido = @NumeroPedido
	order by
		te.Orden ASC, CASE WHEN ISNULL(e.Orden,0) = 0 THEN te.Orden ELSE e.Orden END ASC, EstrategiaID ASC


SET NOCOUNT OFF
END
go

go
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListarEstrategiasLanzamiento]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ListarEstrategiasLanzamiento]
GO

go
CREATE PROCEDURE [dbo].[ListarEstrategiasLanzamiento]
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(30)
AS
/*
dbo.ListarEstrategiasLanzamiento 201710, ''
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
		FlagMostrarImg int
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
	FROM Estrategia E with(nolock)
		INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON 
			op.CodConsultora = @CodigoConsultora  
			and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
			and op.TipoPersonalizacion = 'LAN'
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
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
		FROM Estrategia E with(nolock)
		INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON 
			op.CodConsultora = @codConsultoraDefault  
			and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
			and op.TipoPersonalizacion = 'LAN'
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
		WHERE
			E.Activo = 1
			AND ca.Codigo = @CampaniaID
			AND TE.FlagActivo = 1
			AND TE.flagRecoPerfil = 1
			AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
	
	END
	
	declare @TEMP table (
		EstrategiaID int
		, ImgFondoDesktop varchar(1000)
		, ImgPrevDesktop varchar(1000)
		, ImgSelloProductoDesktop varchar(1000)
		, UrlVideoDesktop varchar(1000)
		, ImgFichaFondoDesktop varchar(1000)
		, ImgFondoMobile varchar(1000)
		, ImgSelloProductoMobile varchar(1000)
		, UrlVideoMobile varchar(1000)
		, ImgFichaFondoMobile varchar(1000)
		, ImgHomeDesktop varchar(1000)
		, ImgHomeMobile varchar(1000)
	)

	insert into @temp 
	SELECT EstrategiaID
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10201) as ImgFondoDesktop
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10202) as ImgPrevDesktop
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10203) as ImgSelloProductoDesktop
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10204) as UrlVideoDesktop
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10208) as ImgFichaFondoDesktop
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10205) as ImgFondoMobile
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10206) as ImgSelloProductoMobile
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10207) as UrlVideoMobile
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10209) as ImgFichaFondoMobile	
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10210) as ImgHomeDesktop		
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10211) as ImgHomeMobile				
	FROM #TEMPORAL as T
	
	SELECT
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
		, D.ImgFondoDesktop
		, D.ImgPrevDesktop	
		, D.ImgSelloProductoDesktop as ImgFichaDesktop
		, D.UrlVideoDesktop 
		, D.ImgFichaFondoDesktop 
		, D.ImgFondoMobile		
		, D.ImgSelloProductoMobile as ImgFichaMobile
		, D.UrlVideoMobile  
		, D.ImgFichaFondoMobile
		, D.ImgHomeDesktop
		, D.ImgHomeMobile
	FROM #TEMPORAL T
		LEFT JOIN Marca M with(nolock) ON M.MarcaId = T.MarcaId
		LEFT JOIN @temp D ON D.EstrategiaID = T.EstrategiaID
	ORDER BY
		Orden1 ASC, CASE WHEN ISNULL(T.Orden2,0) = 0 THEN T.Orden1 ELSE T.Orden2 END ASC, EstrategiaID ASC
	
	DROP TABLE #TEMPORAL

SET NOCOUNT OFF
END

go

go
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListarEstrategiasOPT]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ListarEstrategiasOPT]
GO

go
CREATE PROCEDURE [dbo].[ListarEstrategiasOPT]
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
		FlagMostrarImg int
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
	FROM Estrategia E with(nolock)
		INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON 
			op.CodConsultora = @CodigoConsultora  
			and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
			and op.TipoPersonalizacion = 'OPT'
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
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
		FROM Estrategia E with(nolock)
		INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON 
			op.CodConsultora = @codConsultoraDefault  
			and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
			and op.TipoPersonalizacion = 'OPT'
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
		WHERE
			E.Activo = 1
			AND ca.Codigo = @CampaniaID
			AND TE.FlagActivo = 1
			AND TE.flagRecoPerfil = 1
			AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
	
	END
	
	SELECT
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
	FROM #TEMPORAL T
		LEFT JOIN Marca M with(nolock) ON M.MarcaId = T.MarcaId
	ORDER BY
		Orden1 ASC, CASE WHEN ISNULL(T.Orden2,0) = 0 THEN T.Orden1 ELSE T.Orden2 END ASC, EstrategiaID ASC
	
	DROP TABLE #TEMPORAL

SET NOCOUNT OFF
END
go

go
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListarEstrategiasRevistaDigital]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ListarEstrategiasRevistaDigital]
GO

go
CREATE PROCEDURE [dbo].[ListarEstrategiasRevistaDigital]
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
		FlagMostrarImg int
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
	FROM Estrategia E with(nolock)
		INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON 
			op.CodConsultora = @CodigoConsultora  
			and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
			and op.TipoPersonalizacion in ('OPM', 'PAD')
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
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
		FROM Estrategia E with(nolock)
		INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON 
			op.CodConsultora = @codConsultoraDefault  
			and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
			and op.TipoPersonalizacion in ('OPM', 'PAD')
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
		WHERE
			E.Activo = 1
			AND ca.Codigo = @CampaniaID
			AND TE.FlagActivo = 1
			AND TE.flagRecoPerfil = 1
			AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
	
	END
	
	SELECT
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
	FROM #TEMPORAL T
		LEFT JOIN Marca M with(nolock) ON M.MarcaId = T.MarcaId
	ORDER BY
		Orden1 ASC, CASE WHEN ISNULL(T.Orden2,0) = 0 THEN T.Orden1 ELSE T.Orden2 END ASC, EstrategiaID ASC
	
	DROP TABLE #TEMPORAL

SET NOCOUNT OFF
END

go

go
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListarEstrategiasOfertaWeb]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ListarEstrategiasOfertaWeb]
GO

go
CREATE PROCEDURE [dbo].[ListarEstrategiasOfertaWeb]
	@CampaniaID INT,
	@ZonaID INT
AS
/*
dbo.ListarEstrategiasOfertaWeb 201710, ''
*/
BEGIN
SET NOCOUNT ON;
	
	SELECT
		EstrategiaID,
		CUV2,
		DescripcionCUV2,
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
		Precio,
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
		e.Orden Orden2,
		pc.IndicadorMontoMinimo,
		pc.CodigoProducto,
		te.flagNueva,
		'' as TipoTallaColor,
		4 as TipoEstrategiaImagenMostrar
		, E.EtiquetaID
		, E.EtiquetaID2
		, E.CodigoEstrategia
		, E.TieneVariedad
		, TE.CODIGO
		, TE.DescripcionEstrategia
		, ISNULL(TE.FlagMostrarImg,0) AS FlagMostrarImg	
	FROM Estrategia E with(nolock)
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
		INNER JOIN ods.Campania CA with(nolock) ON E.CampaniaID = CA.Codigo
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
	WHERE
		E.Activo = 1
		AND TE.FlagActivo = 1
		AND E.CampaniaID = @CampaniaID
		AND TE.flagRecoProduc = 0
		AND TE.flagNueva = 0
		AND TE.flagRecoPerfil = 0
		AND E.Zona LIKE '%' + Convert(varchar, @ZonaID) + '%'

SET NOCOUNT OFF
END

go

USE BelcorpEcuador
GO

go
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListarEstrategiasPackNuevas]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ListarEstrategiasPackNuevas]
GO

go
CREATE PROCEDURE [dbo].[ListarEstrategiasPackNuevas]
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(30)
AS
/*
dbo.ListarEstrategiasPackNuevas 201710, ''
*/
BEGIN
SET NOCOUNT ON;
	
	declare @ZonaID VARCHAR(20) = ''
	, @NumeroPedido INT = 0

	select @ZonaID = ZonaID
		, @NumeroPedido = ConsecutivoNueva + 1
	from ods.Consultora with(nolock)
	where Codigo = @CodigoConsultora

	SELECT
		EstrategiaID,
		CUV2,
		DescripcionCUV2,
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
		Precio,
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
		e.Orden Orden2,
		pc.IndicadorMontoMinimo,
		pc.CodigoProducto,
		1 AS FlagNueva,
		'' as TipoTallaColor,
		2 as TipoEstrategiaImagenMostrar
		, E.EtiquetaID
		, E.EtiquetaID2
		, E.CodigoEstrategia
		, E.TieneVariedad
		, TE.CODIGO
		, TE.DescripcionEstrategia
		, ISNULL(TE.FlagMostrarImg,0) AS FlagMostrarImg
	FROM Estrategia E with(nolock)
		INNER JOIN TipoEstrategia TE with(nolock) ON
			E.TipoEstrategiaID = TE.TipoEstrategiaID
		INNER JOIN ods.Campania CA with(nolock) ON
			E.CampaniaID = CA.Codigo
		INNER JOIN ods.ProductoComercial PC with(nolock) ON
			PC.CampaniaID = CA.CampaniaID
			AND PC.CUV = E.CUV2
		INNER JOIN Ods.ConsultorasProgramaNuevas CPN with(nolock) ON
			CPN.CodigoConsultora = @CodigoConsultora
			AND CPN.CodigoPrograma = TE.CodigoPrograma
	WHERE
		(E.CampaniaID = @CampaniaID OR @CampaniaID between E.CampaniaID and E.CampaniaIDFin)
		AND CPN.Participa = 1
		AND TE.FlagActivo = 1
		AND TE.flagNueva = 1
		AND E.Activo = 1
		AND E.Zona LIKE '%' + @ZonaID + '%'
		AND E.NumeroPedido = @NumeroPedido
	order by
		te.Orden ASC, CASE WHEN ISNULL(e.Orden,0) = 0 THEN te.Orden ELSE e.Orden END ASC, EstrategiaID ASC


SET NOCOUNT OFF
END
go

go
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListarEstrategiasLanzamiento]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ListarEstrategiasLanzamiento]
GO

go
CREATE PROCEDURE [dbo].[ListarEstrategiasLanzamiento]
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(30)
AS
/*
dbo.ListarEstrategiasLanzamiento 201710, ''
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
		FlagMostrarImg int
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
	FROM Estrategia E with(nolock)
		INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON 
			op.CodConsultora = @CodigoConsultora  
			and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
			and op.TipoPersonalizacion = 'LAN'
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
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
		FROM Estrategia E with(nolock)
		INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON 
			op.CodConsultora = @codConsultoraDefault  
			and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
			and op.TipoPersonalizacion = 'LAN'
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
		WHERE
			E.Activo = 1
			AND ca.Codigo = @CampaniaID
			AND TE.FlagActivo = 1
			AND TE.flagRecoPerfil = 1
			AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
	
	END
	
	declare @TEMP table (
		EstrategiaID int
		, ImgFondoDesktop varchar(1000)
		, ImgPrevDesktop varchar(1000)
		, ImgSelloProductoDesktop varchar(1000)
		, UrlVideoDesktop varchar(1000)
		, ImgFichaFondoDesktop varchar(1000)
		, ImgFondoMobile varchar(1000)
		, ImgSelloProductoMobile varchar(1000)
		, UrlVideoMobile varchar(1000)
		, ImgFichaFondoMobile varchar(1000)
		, ImgHomeDesktop varchar(1000)
		, ImgHomeMobile varchar(1000)
	)

	insert into @temp 
	SELECT EstrategiaID
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10201) as ImgFondoDesktop
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10202) as ImgPrevDesktop
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10203) as ImgSelloProductoDesktop
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10204) as UrlVideoDesktop
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10208) as ImgFichaFondoDesktop
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10205) as ImgFondoMobile
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10206) as ImgSelloProductoMobile
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10207) as UrlVideoMobile
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10209) as ImgFichaFondoMobile	
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10210) as ImgHomeDesktop		
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10211) as ImgHomeMobile				
	FROM #TEMPORAL as T
	
	SELECT
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
		, D.ImgFondoDesktop
		, D.ImgPrevDesktop	
		, D.ImgSelloProductoDesktop as ImgFichaDesktop
		, D.UrlVideoDesktop 
		, D.ImgFichaFondoDesktop 
		, D.ImgFondoMobile		
		, D.ImgSelloProductoMobile as ImgFichaMobile
		, D.UrlVideoMobile  
		, D.ImgFichaFondoMobile
		, D.ImgHomeDesktop
		, D.ImgHomeMobile
	FROM #TEMPORAL T
		LEFT JOIN Marca M with(nolock) ON M.MarcaId = T.MarcaId
		LEFT JOIN @temp D ON D.EstrategiaID = T.EstrategiaID
	ORDER BY
		Orden1 ASC, CASE WHEN ISNULL(T.Orden2,0) = 0 THEN T.Orden1 ELSE T.Orden2 END ASC, EstrategiaID ASC
	
	DROP TABLE #TEMPORAL

SET NOCOUNT OFF
END

go

go
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListarEstrategiasOPT]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ListarEstrategiasOPT]
GO

go
CREATE PROCEDURE [dbo].[ListarEstrategiasOPT]
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
		FlagMostrarImg int
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
	FROM Estrategia E with(nolock)
		INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON 
			op.CodConsultora = @CodigoConsultora  
			and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
			and op.TipoPersonalizacion = 'OPT'
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
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
		FROM Estrategia E with(nolock)
		INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON 
			op.CodConsultora = @codConsultoraDefault  
			and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
			and op.TipoPersonalizacion = 'OPT'
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
		WHERE
			E.Activo = 1
			AND ca.Codigo = @CampaniaID
			AND TE.FlagActivo = 1
			AND TE.flagRecoPerfil = 1
			AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
	
	END
	
	SELECT
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
	FROM #TEMPORAL T
		LEFT JOIN Marca M with(nolock) ON M.MarcaId = T.MarcaId
	ORDER BY
		Orden1 ASC, CASE WHEN ISNULL(T.Orden2,0) = 0 THEN T.Orden1 ELSE T.Orden2 END ASC, EstrategiaID ASC
	
	DROP TABLE #TEMPORAL

SET NOCOUNT OFF
END
go

go
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListarEstrategiasRevistaDigital]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ListarEstrategiasRevistaDigital]
GO

go
CREATE PROCEDURE [dbo].[ListarEstrategiasRevistaDigital]
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
		FlagMostrarImg int
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
	FROM Estrategia E with(nolock)
		INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON 
			op.CodConsultora = @CodigoConsultora  
			and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
			and op.TipoPersonalizacion in ('OPM', 'PAD')
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
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
		FROM Estrategia E with(nolock)
		INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON 
			op.CodConsultora = @codConsultoraDefault  
			and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
			and op.TipoPersonalizacion in ('OPM', 'PAD')
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
		WHERE
			E.Activo = 1
			AND ca.Codigo = @CampaniaID
			AND TE.FlagActivo = 1
			AND TE.flagRecoPerfil = 1
			AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
	
	END
	
	SELECT
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
	FROM #TEMPORAL T
		LEFT JOIN Marca M with(nolock) ON M.MarcaId = T.MarcaId
	ORDER BY
		Orden1 ASC, CASE WHEN ISNULL(T.Orden2,0) = 0 THEN T.Orden1 ELSE T.Orden2 END ASC, EstrategiaID ASC
	
	DROP TABLE #TEMPORAL

SET NOCOUNT OFF
END

go

go
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListarEstrategiasOfertaWeb]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ListarEstrategiasOfertaWeb]
GO

go
CREATE PROCEDURE [dbo].[ListarEstrategiasOfertaWeb]
	@CampaniaID INT,
	@ZonaID INT
AS
/*
dbo.ListarEstrategiasOfertaWeb 201710, ''
*/
BEGIN
SET NOCOUNT ON;
	
	SELECT
		EstrategiaID,
		CUV2,
		DescripcionCUV2,
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
		Precio,
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
		e.Orden Orden2,
		pc.IndicadorMontoMinimo,
		pc.CodigoProducto,
		te.flagNueva,
		'' as TipoTallaColor,
		4 as TipoEstrategiaImagenMostrar
		, E.EtiquetaID
		, E.EtiquetaID2
		, E.CodigoEstrategia
		, E.TieneVariedad
		, TE.CODIGO
		, TE.DescripcionEstrategia
		, ISNULL(TE.FlagMostrarImg,0) AS FlagMostrarImg	
	FROM Estrategia E with(nolock)
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
		INNER JOIN ods.Campania CA with(nolock) ON E.CampaniaID = CA.Codigo
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
	WHERE
		E.Activo = 1
		AND TE.FlagActivo = 1
		AND E.CampaniaID = @CampaniaID
		AND TE.flagRecoProduc = 0
		AND TE.flagNueva = 0
		AND TE.flagRecoPerfil = 0
		AND E.Zona LIKE '%' + Convert(varchar, @ZonaID) + '%'

SET NOCOUNT OFF
END

go

USE BelcorpDominicana
GO

go
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListarEstrategiasPackNuevas]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ListarEstrategiasPackNuevas]
GO

go
CREATE PROCEDURE [dbo].[ListarEstrategiasPackNuevas]
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(30)
AS
/*
dbo.ListarEstrategiasPackNuevas 201710, ''
*/
BEGIN
SET NOCOUNT ON;
	
	declare @ZonaID VARCHAR(20) = ''
	, @NumeroPedido INT = 0

	select @ZonaID = ZonaID
		, @NumeroPedido = ConsecutivoNueva + 1
	from ods.Consultora with(nolock)
	where Codigo = @CodigoConsultora

	SELECT
		EstrategiaID,
		CUV2,
		DescripcionCUV2,
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
		Precio,
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
		e.Orden Orden2,
		pc.IndicadorMontoMinimo,
		pc.CodigoProducto,
		1 AS FlagNueva,
		'' as TipoTallaColor,
		2 as TipoEstrategiaImagenMostrar
		, E.EtiquetaID
		, E.EtiquetaID2
		, E.CodigoEstrategia
		, E.TieneVariedad
		, TE.CODIGO
		, TE.DescripcionEstrategia
		, ISNULL(TE.FlagMostrarImg,0) AS FlagMostrarImg
	FROM Estrategia E with(nolock)
		INNER JOIN TipoEstrategia TE with(nolock) ON
			E.TipoEstrategiaID = TE.TipoEstrategiaID
		INNER JOIN ods.Campania CA with(nolock) ON
			E.CampaniaID = CA.Codigo
		INNER JOIN ods.ProductoComercial PC with(nolock) ON
			PC.CampaniaID = CA.CampaniaID
			AND PC.CUV = E.CUV2
		INNER JOIN Ods.ConsultorasProgramaNuevas CPN with(nolock) ON
			CPN.CodigoConsultora = @CodigoConsultora
			AND CPN.CodigoPrograma = TE.CodigoPrograma
	WHERE
		(E.CampaniaID = @CampaniaID OR @CampaniaID between E.CampaniaID and E.CampaniaIDFin)
		AND CPN.Participa = 1
		AND TE.FlagActivo = 1
		AND TE.flagNueva = 1
		AND E.Activo = 1
		AND E.Zona LIKE '%' + @ZonaID + '%'
		AND E.NumeroPedido = @NumeroPedido
	order by
		te.Orden ASC, CASE WHEN ISNULL(e.Orden,0) = 0 THEN te.Orden ELSE e.Orden END ASC, EstrategiaID ASC


SET NOCOUNT OFF
END
go

go
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListarEstrategiasLanzamiento]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ListarEstrategiasLanzamiento]
GO

go
CREATE PROCEDURE [dbo].[ListarEstrategiasLanzamiento]
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(30)
AS
/*
dbo.ListarEstrategiasLanzamiento 201710, ''
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
		FlagMostrarImg int
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
	FROM Estrategia E with(nolock)
		INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON 
			op.CodConsultora = @CodigoConsultora  
			and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
			and op.TipoPersonalizacion = 'LAN'
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
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
		FROM Estrategia E with(nolock)
		INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON 
			op.CodConsultora = @codConsultoraDefault  
			and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
			and op.TipoPersonalizacion = 'LAN'
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
		WHERE
			E.Activo = 1
			AND ca.Codigo = @CampaniaID
			AND TE.FlagActivo = 1
			AND TE.flagRecoPerfil = 1
			AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
	
	END
	
	declare @TEMP table (
		EstrategiaID int
		, ImgFondoDesktop varchar(1000)
		, ImgPrevDesktop varchar(1000)
		, ImgSelloProductoDesktop varchar(1000)
		, UrlVideoDesktop varchar(1000)
		, ImgFichaFondoDesktop varchar(1000)
		, ImgFondoMobile varchar(1000)
		, ImgSelloProductoMobile varchar(1000)
		, UrlVideoMobile varchar(1000)
		, ImgFichaFondoMobile varchar(1000)
		, ImgHomeDesktop varchar(1000)
		, ImgHomeMobile varchar(1000)
	)

	insert into @temp 
	SELECT EstrategiaID
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10201) as ImgFondoDesktop
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10202) as ImgPrevDesktop
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10203) as ImgSelloProductoDesktop
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10204) as UrlVideoDesktop
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10208) as ImgFichaFondoDesktop
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10205) as ImgFondoMobile
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10206) as ImgSelloProductoMobile
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10207) as UrlVideoMobile
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10209) as ImgFichaFondoMobile	
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10210) as ImgHomeDesktop		
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10211) as ImgHomeMobile				
	FROM #TEMPORAL as T
	
	SELECT
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
		, D.ImgFondoDesktop
		, D.ImgPrevDesktop	
		, D.ImgSelloProductoDesktop as ImgFichaDesktop
		, D.UrlVideoDesktop 
		, D.ImgFichaFondoDesktop 
		, D.ImgFondoMobile		
		, D.ImgSelloProductoMobile as ImgFichaMobile
		, D.UrlVideoMobile  
		, D.ImgFichaFondoMobile
		, D.ImgHomeDesktop
		, D.ImgHomeMobile
	FROM #TEMPORAL T
		LEFT JOIN Marca M with(nolock) ON M.MarcaId = T.MarcaId
		LEFT JOIN @temp D ON D.EstrategiaID = T.EstrategiaID
	ORDER BY
		Orden1 ASC, CASE WHEN ISNULL(T.Orden2,0) = 0 THEN T.Orden1 ELSE T.Orden2 END ASC, EstrategiaID ASC
	
	DROP TABLE #TEMPORAL

SET NOCOUNT OFF
END

go

go
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListarEstrategiasOPT]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ListarEstrategiasOPT]
GO

go
CREATE PROCEDURE [dbo].[ListarEstrategiasOPT]
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
		FlagMostrarImg int
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
	FROM Estrategia E with(nolock)
		INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON 
			op.CodConsultora = @CodigoConsultora  
			and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
			and op.TipoPersonalizacion = 'OPT'
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
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
		FROM Estrategia E with(nolock)
		INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON 
			op.CodConsultora = @codConsultoraDefault  
			and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
			and op.TipoPersonalizacion = 'OPT'
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
		WHERE
			E.Activo = 1
			AND ca.Codigo = @CampaniaID
			AND TE.FlagActivo = 1
			AND TE.flagRecoPerfil = 1
			AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
	
	END
	
	SELECT
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
	FROM #TEMPORAL T
		LEFT JOIN Marca M with(nolock) ON M.MarcaId = T.MarcaId
	ORDER BY
		Orden1 ASC, CASE WHEN ISNULL(T.Orden2,0) = 0 THEN T.Orden1 ELSE T.Orden2 END ASC, EstrategiaID ASC
	
	DROP TABLE #TEMPORAL

SET NOCOUNT OFF
END
go

go
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListarEstrategiasRevistaDigital]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ListarEstrategiasRevistaDigital]
GO

go
CREATE PROCEDURE [dbo].[ListarEstrategiasRevistaDigital]
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
		FlagMostrarImg int
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
	FROM Estrategia E with(nolock)
		INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON 
			op.CodConsultora = @CodigoConsultora  
			and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
			and op.TipoPersonalizacion in ('OPM', 'PAD')
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
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
		FROM Estrategia E with(nolock)
		INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON 
			op.CodConsultora = @codConsultoraDefault  
			and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
			and op.TipoPersonalizacion in ('OPM', 'PAD')
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
		WHERE
			E.Activo = 1
			AND ca.Codigo = @CampaniaID
			AND TE.FlagActivo = 1
			AND TE.flagRecoPerfil = 1
			AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
	
	END
	
	SELECT
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
	FROM #TEMPORAL T
		LEFT JOIN Marca M with(nolock) ON M.MarcaId = T.MarcaId
	ORDER BY
		Orden1 ASC, CASE WHEN ISNULL(T.Orden2,0) = 0 THEN T.Orden1 ELSE T.Orden2 END ASC, EstrategiaID ASC
	
	DROP TABLE #TEMPORAL

SET NOCOUNT OFF
END

go

go
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListarEstrategiasOfertaWeb]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ListarEstrategiasOfertaWeb]
GO

go
CREATE PROCEDURE [dbo].[ListarEstrategiasOfertaWeb]
	@CampaniaID INT,
	@ZonaID INT
AS
/*
dbo.ListarEstrategiasOfertaWeb 201710, ''
*/
BEGIN
SET NOCOUNT ON;
	
	SELECT
		EstrategiaID,
		CUV2,
		DescripcionCUV2,
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
		Precio,
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
		e.Orden Orden2,
		pc.IndicadorMontoMinimo,
		pc.CodigoProducto,
		te.flagNueva,
		'' as TipoTallaColor,
		4 as TipoEstrategiaImagenMostrar
		, E.EtiquetaID
		, E.EtiquetaID2
		, E.CodigoEstrategia
		, E.TieneVariedad
		, TE.CODIGO
		, TE.DescripcionEstrategia
		, ISNULL(TE.FlagMostrarImg,0) AS FlagMostrarImg	
	FROM Estrategia E with(nolock)
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
		INNER JOIN ods.Campania CA with(nolock) ON E.CampaniaID = CA.Codigo
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
	WHERE
		E.Activo = 1
		AND TE.FlagActivo = 1
		AND E.CampaniaID = @CampaniaID
		AND TE.flagRecoProduc = 0
		AND TE.flagNueva = 0
		AND TE.flagRecoPerfil = 0
		AND E.Zona LIKE '%' + Convert(varchar, @ZonaID) + '%'

SET NOCOUNT OFF
END

go

USE BelcorpCostaRica
GO

go
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListarEstrategiasPackNuevas]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ListarEstrategiasPackNuevas]
GO

go
CREATE PROCEDURE [dbo].[ListarEstrategiasPackNuevas]
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(30)
AS
/*
dbo.ListarEstrategiasPackNuevas 201710, ''
*/
BEGIN
SET NOCOUNT ON;
	
	declare @ZonaID VARCHAR(20) = ''
	, @NumeroPedido INT = 0

	select @ZonaID = ZonaID
		, @NumeroPedido = ConsecutivoNueva + 1
	from ods.Consultora with(nolock)
	where Codigo = @CodigoConsultora

	SELECT
		EstrategiaID,
		CUV2,
		DescripcionCUV2,
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
		Precio,
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
		e.Orden Orden2,
		pc.IndicadorMontoMinimo,
		pc.CodigoProducto,
		1 AS FlagNueva,
		'' as TipoTallaColor,
		2 as TipoEstrategiaImagenMostrar
		, E.EtiquetaID
		, E.EtiquetaID2
		, E.CodigoEstrategia
		, E.TieneVariedad
		, TE.CODIGO
		, TE.DescripcionEstrategia
		, ISNULL(TE.FlagMostrarImg,0) AS FlagMostrarImg
	FROM Estrategia E with(nolock)
		INNER JOIN TipoEstrategia TE with(nolock) ON
			E.TipoEstrategiaID = TE.TipoEstrategiaID
		INNER JOIN ods.Campania CA with(nolock) ON
			E.CampaniaID = CA.Codigo
		INNER JOIN ods.ProductoComercial PC with(nolock) ON
			PC.CampaniaID = CA.CampaniaID
			AND PC.CUV = E.CUV2
		INNER JOIN Ods.ConsultorasProgramaNuevas CPN with(nolock) ON
			CPN.CodigoConsultora = @CodigoConsultora
			AND CPN.CodigoPrograma = TE.CodigoPrograma
	WHERE
		(E.CampaniaID = @CampaniaID OR @CampaniaID between E.CampaniaID and E.CampaniaIDFin)
		AND CPN.Participa = 1
		AND TE.FlagActivo = 1
		AND TE.flagNueva = 1
		AND E.Activo = 1
		AND E.Zona LIKE '%' + @ZonaID + '%'
		AND E.NumeroPedido = @NumeroPedido
	order by
		te.Orden ASC, CASE WHEN ISNULL(e.Orden,0) = 0 THEN te.Orden ELSE e.Orden END ASC, EstrategiaID ASC


SET NOCOUNT OFF
END
go

go
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListarEstrategiasLanzamiento]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ListarEstrategiasLanzamiento]
GO

go
CREATE PROCEDURE [dbo].[ListarEstrategiasLanzamiento]
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(30)
AS
/*
dbo.ListarEstrategiasLanzamiento 201710, ''
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
		FlagMostrarImg int
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
	FROM Estrategia E with(nolock)
		INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON 
			op.CodConsultora = @CodigoConsultora  
			and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
			and op.TipoPersonalizacion = 'LAN'
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
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
		FROM Estrategia E with(nolock)
		INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON 
			op.CodConsultora = @codConsultoraDefault  
			and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
			and op.TipoPersonalizacion = 'LAN'
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
		WHERE
			E.Activo = 1
			AND ca.Codigo = @CampaniaID
			AND TE.FlagActivo = 1
			AND TE.flagRecoPerfil = 1
			AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
	
	END
	
	declare @TEMP table (
		EstrategiaID int
		, ImgFondoDesktop varchar(1000)
		, ImgPrevDesktop varchar(1000)
		, ImgSelloProductoDesktop varchar(1000)
		, UrlVideoDesktop varchar(1000)
		, ImgFichaFondoDesktop varchar(1000)
		, ImgFondoMobile varchar(1000)
		, ImgSelloProductoMobile varchar(1000)
		, UrlVideoMobile varchar(1000)
		, ImgFichaFondoMobile varchar(1000)
		, ImgHomeDesktop varchar(1000)
		, ImgHomeMobile varchar(1000)
	)

	insert into @temp 
	SELECT EstrategiaID
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10201) as ImgFondoDesktop
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10202) as ImgPrevDesktop
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10203) as ImgSelloProductoDesktop
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10204) as UrlVideoDesktop
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10208) as ImgFichaFondoDesktop
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10205) as ImgFondoMobile
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10206) as ImgSelloProductoMobile
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10207) as UrlVideoMobile
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10209) as ImgFichaFondoMobile	
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10210) as ImgHomeDesktop		
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10211) as ImgHomeMobile				
	FROM #TEMPORAL as T
	
	SELECT
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
		, D.ImgFondoDesktop
		, D.ImgPrevDesktop	
		, D.ImgSelloProductoDesktop as ImgFichaDesktop
		, D.UrlVideoDesktop 
		, D.ImgFichaFondoDesktop 
		, D.ImgFondoMobile		
		, D.ImgSelloProductoMobile as ImgFichaMobile
		, D.UrlVideoMobile  
		, D.ImgFichaFondoMobile
		, D.ImgHomeDesktop
		, D.ImgHomeMobile
	FROM #TEMPORAL T
		LEFT JOIN Marca M with(nolock) ON M.MarcaId = T.MarcaId
		LEFT JOIN @temp D ON D.EstrategiaID = T.EstrategiaID
	ORDER BY
		Orden1 ASC, CASE WHEN ISNULL(T.Orden2,0) = 0 THEN T.Orden1 ELSE T.Orden2 END ASC, EstrategiaID ASC
	
	DROP TABLE #TEMPORAL

SET NOCOUNT OFF
END

go

go
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListarEstrategiasOPT]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ListarEstrategiasOPT]
GO

go
CREATE PROCEDURE [dbo].[ListarEstrategiasOPT]
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
		FlagMostrarImg int
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
	FROM Estrategia E with(nolock)
		INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON 
			op.CodConsultora = @CodigoConsultora  
			and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
			and op.TipoPersonalizacion = 'OPT'
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
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
		FROM Estrategia E with(nolock)
		INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON 
			op.CodConsultora = @codConsultoraDefault  
			and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
			and op.TipoPersonalizacion = 'OPT'
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
		WHERE
			E.Activo = 1
			AND ca.Codigo = @CampaniaID
			AND TE.FlagActivo = 1
			AND TE.flagRecoPerfil = 1
			AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
	
	END
	
	SELECT
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
	FROM #TEMPORAL T
		LEFT JOIN Marca M with(nolock) ON M.MarcaId = T.MarcaId
	ORDER BY
		Orden1 ASC, CASE WHEN ISNULL(T.Orden2,0) = 0 THEN T.Orden1 ELSE T.Orden2 END ASC, EstrategiaID ASC
	
	DROP TABLE #TEMPORAL

SET NOCOUNT OFF
END
go

go
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListarEstrategiasRevistaDigital]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ListarEstrategiasRevistaDigital]
GO

go
CREATE PROCEDURE [dbo].[ListarEstrategiasRevistaDigital]
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
		FlagMostrarImg int
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
	FROM Estrategia E with(nolock)
		INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON 
			op.CodConsultora = @CodigoConsultora  
			and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
			and op.TipoPersonalizacion in ('OPM', 'PAD')
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
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
		FROM Estrategia E with(nolock)
		INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON 
			op.CodConsultora = @codConsultoraDefault  
			and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
			and op.TipoPersonalizacion in ('OPM', 'PAD')
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
		WHERE
			E.Activo = 1
			AND ca.Codigo = @CampaniaID
			AND TE.FlagActivo = 1
			AND TE.flagRecoPerfil = 1
			AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
	
	END
	
	SELECT
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
	FROM #TEMPORAL T
		LEFT JOIN Marca M with(nolock) ON M.MarcaId = T.MarcaId
	ORDER BY
		Orden1 ASC, CASE WHEN ISNULL(T.Orden2,0) = 0 THEN T.Orden1 ELSE T.Orden2 END ASC, EstrategiaID ASC
	
	DROP TABLE #TEMPORAL

SET NOCOUNT OFF
END

go

go
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListarEstrategiasOfertaWeb]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ListarEstrategiasOfertaWeb]
GO

go
CREATE PROCEDURE [dbo].[ListarEstrategiasOfertaWeb]
	@CampaniaID INT,
	@ZonaID INT
AS
/*
dbo.ListarEstrategiasOfertaWeb 201710, ''
*/
BEGIN
SET NOCOUNT ON;
	
	SELECT
		EstrategiaID,
		CUV2,
		DescripcionCUV2,
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
		Precio,
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
		e.Orden Orden2,
		pc.IndicadorMontoMinimo,
		pc.CodigoProducto,
		te.flagNueva,
		'' as TipoTallaColor,
		4 as TipoEstrategiaImagenMostrar
		, E.EtiquetaID
		, E.EtiquetaID2
		, E.CodigoEstrategia
		, E.TieneVariedad
		, TE.CODIGO
		, TE.DescripcionEstrategia
		, ISNULL(TE.FlagMostrarImg,0) AS FlagMostrarImg	
	FROM Estrategia E with(nolock)
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
		INNER JOIN ods.Campania CA with(nolock) ON E.CampaniaID = CA.Codigo
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
	WHERE
		E.Activo = 1
		AND TE.FlagActivo = 1
		AND E.CampaniaID = @CampaniaID
		AND TE.flagRecoProduc = 0
		AND TE.flagNueva = 0
		AND TE.flagRecoPerfil = 0
		AND E.Zona LIKE '%' + Convert(varchar, @ZonaID) + '%'

SET NOCOUNT OFF
END

go

USE BelcorpChile
GO

go
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListarEstrategiasPackNuevas]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ListarEstrategiasPackNuevas]
GO

go
CREATE PROCEDURE [dbo].[ListarEstrategiasPackNuevas]
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(30)
AS
/*
dbo.ListarEstrategiasPackNuevas 201710, ''
*/
BEGIN
SET NOCOUNT ON;
	
	declare @ZonaID VARCHAR(20) = ''
	, @NumeroPedido INT = 0

	select @ZonaID = ZonaID
		, @NumeroPedido = ConsecutivoNueva + 1
	from ods.Consultora with(nolock)
	where Codigo = @CodigoConsultora

	SELECT
		EstrategiaID,
		CUV2,
		DescripcionCUV2,
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
		Precio,
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
		e.Orden Orden2,
		pc.IndicadorMontoMinimo,
		pc.CodigoProducto,
		1 AS FlagNueva,
		'' as TipoTallaColor,
		2 as TipoEstrategiaImagenMostrar
		, E.EtiquetaID
		, E.EtiquetaID2
		, E.CodigoEstrategia
		, E.TieneVariedad
		, TE.CODIGO
		, TE.DescripcionEstrategia
		, ISNULL(TE.FlagMostrarImg,0) AS FlagMostrarImg
	FROM Estrategia E with(nolock)
		INNER JOIN TipoEstrategia TE with(nolock) ON
			E.TipoEstrategiaID = TE.TipoEstrategiaID
		INNER JOIN ods.Campania CA with(nolock) ON
			E.CampaniaID = CA.Codigo
		INNER JOIN ods.ProductoComercial PC with(nolock) ON
			PC.CampaniaID = CA.CampaniaID
			AND PC.CUV = E.CUV2
		INNER JOIN Ods.ConsultorasProgramaNuevas CPN with(nolock) ON
			CPN.CodigoConsultora = @CodigoConsultora
			AND CPN.CodigoPrograma = TE.CodigoPrograma
	WHERE
		(E.CampaniaID = @CampaniaID OR @CampaniaID between E.CampaniaID and E.CampaniaIDFin)
		AND CPN.Participa = 1
		AND TE.FlagActivo = 1
		AND TE.flagNueva = 1
		AND E.Activo = 1
		AND E.Zona LIKE '%' + @ZonaID + '%'
		AND E.NumeroPedido = @NumeroPedido
	order by
		te.Orden ASC, CASE WHEN ISNULL(e.Orden,0) = 0 THEN te.Orden ELSE e.Orden END ASC, EstrategiaID ASC


SET NOCOUNT OFF
END
go

go
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListarEstrategiasLanzamiento]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ListarEstrategiasLanzamiento]
GO

go
CREATE PROCEDURE [dbo].[ListarEstrategiasLanzamiento]
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(30)
AS
/*
dbo.ListarEstrategiasLanzamiento 201710, ''
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
		FlagMostrarImg int
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
	FROM Estrategia E with(nolock)
		INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON 
			op.CodConsultora = @CodigoConsultora  
			and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
			and op.TipoPersonalizacion = 'LAN'
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
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
		FROM Estrategia E with(nolock)
		INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON 
			op.CodConsultora = @codConsultoraDefault  
			and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
			and op.TipoPersonalizacion = 'LAN'
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
		WHERE
			E.Activo = 1
			AND ca.Codigo = @CampaniaID
			AND TE.FlagActivo = 1
			AND TE.flagRecoPerfil = 1
			AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
	
	END
	
	declare @TEMP table (
		EstrategiaID int
		, ImgFondoDesktop varchar(1000)
		, ImgPrevDesktop varchar(1000)
		, ImgSelloProductoDesktop varchar(1000)
		, UrlVideoDesktop varchar(1000)
		, ImgFichaFondoDesktop varchar(1000)
		, ImgFondoMobile varchar(1000)
		, ImgSelloProductoMobile varchar(1000)
		, UrlVideoMobile varchar(1000)
		, ImgFichaFondoMobile varchar(1000)
		, ImgHomeDesktop varchar(1000)
		, ImgHomeMobile varchar(1000)
	)

	insert into @temp 
	SELECT EstrategiaID
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10201) as ImgFondoDesktop
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10202) as ImgPrevDesktop
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10203) as ImgSelloProductoDesktop
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10204) as UrlVideoDesktop
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10208) as ImgFichaFondoDesktop
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10205) as ImgFondoMobile
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10206) as ImgSelloProductoMobile
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10207) as UrlVideoMobile
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10209) as ImgFichaFondoMobile	
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10210) as ImgHomeDesktop		
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10211) as ImgHomeMobile				
	FROM #TEMPORAL as T
	
	SELECT
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
		, D.ImgFondoDesktop
		, D.ImgPrevDesktop	
		, D.ImgSelloProductoDesktop as ImgFichaDesktop
		, D.UrlVideoDesktop 
		, D.ImgFichaFondoDesktop 
		, D.ImgFondoMobile		
		, D.ImgSelloProductoMobile as ImgFichaMobile
		, D.UrlVideoMobile  
		, D.ImgFichaFondoMobile
		, D.ImgHomeDesktop
		, D.ImgHomeMobile
	FROM #TEMPORAL T
		LEFT JOIN Marca M with(nolock) ON M.MarcaId = T.MarcaId
		LEFT JOIN @temp D ON D.EstrategiaID = T.EstrategiaID
	ORDER BY
		Orden1 ASC, CASE WHEN ISNULL(T.Orden2,0) = 0 THEN T.Orden1 ELSE T.Orden2 END ASC, EstrategiaID ASC
	
	DROP TABLE #TEMPORAL

SET NOCOUNT OFF
END

go

go
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListarEstrategiasOPT]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ListarEstrategiasOPT]
GO

go
CREATE PROCEDURE [dbo].[ListarEstrategiasOPT]
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
		FlagMostrarImg int
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
	FROM Estrategia E with(nolock)
		INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON 
			op.CodConsultora = @CodigoConsultora  
			and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
			and op.TipoPersonalizacion = 'OPT'
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
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
		FROM Estrategia E with(nolock)
		INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON 
			op.CodConsultora = @codConsultoraDefault  
			and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
			and op.TipoPersonalizacion = 'OPT'
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
		WHERE
			E.Activo = 1
			AND ca.Codigo = @CampaniaID
			AND TE.FlagActivo = 1
			AND TE.flagRecoPerfil = 1
			AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
	
	END
	
	SELECT
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
	FROM #TEMPORAL T
		LEFT JOIN Marca M with(nolock) ON M.MarcaId = T.MarcaId
	ORDER BY
		Orden1 ASC, CASE WHEN ISNULL(T.Orden2,0) = 0 THEN T.Orden1 ELSE T.Orden2 END ASC, EstrategiaID ASC
	
	DROP TABLE #TEMPORAL

SET NOCOUNT OFF
END
go

go
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListarEstrategiasRevistaDigital]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ListarEstrategiasRevistaDigital]
GO

go
CREATE PROCEDURE [dbo].[ListarEstrategiasRevistaDigital]
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
		FlagMostrarImg int
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
	FROM Estrategia E with(nolock)
		INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON 
			op.CodConsultora = @CodigoConsultora  
			and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
			and op.TipoPersonalizacion in ('OPM', 'PAD')
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
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
		FROM Estrategia E with(nolock)
		INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON 
			op.CodConsultora = @codConsultoraDefault  
			and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
			and op.TipoPersonalizacion in ('OPM', 'PAD')
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
		WHERE
			E.Activo = 1
			AND ca.Codigo = @CampaniaID
			AND TE.FlagActivo = 1
			AND TE.flagRecoPerfil = 1
			AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
	
	END
	
	SELECT
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
	FROM #TEMPORAL T
		LEFT JOIN Marca M with(nolock) ON M.MarcaId = T.MarcaId
	ORDER BY
		Orden1 ASC, CASE WHEN ISNULL(T.Orden2,0) = 0 THEN T.Orden1 ELSE T.Orden2 END ASC, EstrategiaID ASC
	
	DROP TABLE #TEMPORAL

SET NOCOUNT OFF
END

go

go
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListarEstrategiasOfertaWeb]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ListarEstrategiasOfertaWeb]
GO

go
CREATE PROCEDURE [dbo].[ListarEstrategiasOfertaWeb]
	@CampaniaID INT,
	@ZonaID INT
AS
/*
dbo.ListarEstrategiasOfertaWeb 201710, ''
*/
BEGIN
SET NOCOUNT ON;
	
	SELECT
		EstrategiaID,
		CUV2,
		DescripcionCUV2,
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
		Precio,
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
		e.Orden Orden2,
		pc.IndicadorMontoMinimo,
		pc.CodigoProducto,
		te.flagNueva,
		'' as TipoTallaColor,
		4 as TipoEstrategiaImagenMostrar
		, E.EtiquetaID
		, E.EtiquetaID2
		, E.CodigoEstrategia
		, E.TieneVariedad
		, TE.CODIGO
		, TE.DescripcionEstrategia
		, ISNULL(TE.FlagMostrarImg,0) AS FlagMostrarImg	
	FROM Estrategia E with(nolock)
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
		INNER JOIN ods.Campania CA with(nolock) ON E.CampaniaID = CA.Codigo
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
	WHERE
		E.Activo = 1
		AND TE.FlagActivo = 1
		AND E.CampaniaID = @CampaniaID
		AND TE.flagRecoProduc = 0
		AND TE.flagNueva = 0
		AND TE.flagRecoPerfil = 0
		AND E.Zona LIKE '%' + Convert(varchar, @ZonaID) + '%'

SET NOCOUNT OFF
END

go

USE BelcorpBolivia
GO

go
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListarEstrategiasPackNuevas]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ListarEstrategiasPackNuevas]
GO

go
CREATE PROCEDURE [dbo].[ListarEstrategiasPackNuevas]
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(30)
AS
/*
dbo.ListarEstrategiasPackNuevas 201710, ''
*/
BEGIN
SET NOCOUNT ON;
	
	declare @ZonaID VARCHAR(20) = ''
	, @NumeroPedido INT = 0

	select @ZonaID = ZonaID
		, @NumeroPedido = ConsecutivoNueva + 1
	from ods.Consultora with(nolock)
	where Codigo = @CodigoConsultora

	SELECT
		EstrategiaID,
		CUV2,
		DescripcionCUV2,
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
		Precio,
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
		e.Orden Orden2,
		pc.IndicadorMontoMinimo,
		pc.CodigoProducto,
		1 AS FlagNueva,
		'' as TipoTallaColor,
		2 as TipoEstrategiaImagenMostrar
		, E.EtiquetaID
		, E.EtiquetaID2
		, E.CodigoEstrategia
		, E.TieneVariedad
		, TE.CODIGO
		, TE.DescripcionEstrategia
		, ISNULL(TE.FlagMostrarImg,0) AS FlagMostrarImg
	FROM Estrategia E with(nolock)
		INNER JOIN TipoEstrategia TE with(nolock) ON
			E.TipoEstrategiaID = TE.TipoEstrategiaID
		INNER JOIN ods.Campania CA with(nolock) ON
			E.CampaniaID = CA.Codigo
		INNER JOIN ods.ProductoComercial PC with(nolock) ON
			PC.CampaniaID = CA.CampaniaID
			AND PC.CUV = E.CUV2
		INNER JOIN Ods.ConsultorasProgramaNuevas CPN with(nolock) ON
			CPN.CodigoConsultora = @CodigoConsultora
			AND CPN.CodigoPrograma = TE.CodigoPrograma
	WHERE
		(E.CampaniaID = @CampaniaID OR @CampaniaID between E.CampaniaID and E.CampaniaIDFin)
		AND CPN.Participa = 1
		AND TE.FlagActivo = 1
		AND TE.flagNueva = 1
		AND E.Activo = 1
		AND E.Zona LIKE '%' + @ZonaID + '%'
		AND E.NumeroPedido = @NumeroPedido
	order by
		te.Orden ASC, CASE WHEN ISNULL(e.Orden,0) = 0 THEN te.Orden ELSE e.Orden END ASC, EstrategiaID ASC


SET NOCOUNT OFF
END
go

go
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListarEstrategiasLanzamiento]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ListarEstrategiasLanzamiento]
GO

go
CREATE PROCEDURE [dbo].[ListarEstrategiasLanzamiento]
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(30)
AS
/*
dbo.ListarEstrategiasLanzamiento 201710, ''
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
		FlagMostrarImg int
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
	FROM Estrategia E with(nolock)
		INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON 
			op.CodConsultora = @CodigoConsultora  
			and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
			and op.TipoPersonalizacion = 'LAN'
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
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
		FROM Estrategia E with(nolock)
		INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON 
			op.CodConsultora = @codConsultoraDefault  
			and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
			and op.TipoPersonalizacion = 'LAN'
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
		WHERE
			E.Activo = 1
			AND ca.Codigo = @CampaniaID
			AND TE.FlagActivo = 1
			AND TE.flagRecoPerfil = 1
			AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
	
	END
	
	declare @TEMP table (
		EstrategiaID int
		, ImgFondoDesktop varchar(1000)
		, ImgPrevDesktop varchar(1000)
		, ImgSelloProductoDesktop varchar(1000)
		, UrlVideoDesktop varchar(1000)
		, ImgFichaFondoDesktop varchar(1000)
		, ImgFondoMobile varchar(1000)
		, ImgSelloProductoMobile varchar(1000)
		, UrlVideoMobile varchar(1000)
		, ImgFichaFondoMobile varchar(1000)
		, ImgHomeDesktop varchar(1000)
		, ImgHomeMobile varchar(1000)
	)

	insert into @temp 
	SELECT EstrategiaID
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10201) as ImgFondoDesktop
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10202) as ImgPrevDesktop
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10203) as ImgSelloProductoDesktop
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10204) as UrlVideoDesktop
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10208) as ImgFichaFondoDesktop
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10205) as ImgFondoMobile
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10206) as ImgSelloProductoMobile
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10207) as UrlVideoMobile
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10209) as ImgFichaFondoMobile	
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10210) as ImgHomeDesktop		
		,(select top 1 valor from EstrategiaDetalle with(nolock) where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10211) as ImgHomeMobile				
	FROM #TEMPORAL as T
	
	SELECT
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
		, D.ImgFondoDesktop
		, D.ImgPrevDesktop	
		, D.ImgSelloProductoDesktop as ImgFichaDesktop
		, D.UrlVideoDesktop 
		, D.ImgFichaFondoDesktop 
		, D.ImgFondoMobile		
		, D.ImgSelloProductoMobile as ImgFichaMobile
		, D.UrlVideoMobile  
		, D.ImgFichaFondoMobile
		, D.ImgHomeDesktop
		, D.ImgHomeMobile
	FROM #TEMPORAL T
		LEFT JOIN Marca M with(nolock) ON M.MarcaId = T.MarcaId
		LEFT JOIN @temp D ON D.EstrategiaID = T.EstrategiaID
	ORDER BY
		Orden1 ASC, CASE WHEN ISNULL(T.Orden2,0) = 0 THEN T.Orden1 ELSE T.Orden2 END ASC, EstrategiaID ASC
	
	DROP TABLE #TEMPORAL

SET NOCOUNT OFF
END

go

go
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListarEstrategiasOPT]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ListarEstrategiasOPT]
GO

go
CREATE PROCEDURE [dbo].[ListarEstrategiasOPT]
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
		FlagMostrarImg int
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
	FROM Estrategia E with(nolock)
		INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON 
			op.CodConsultora = @CodigoConsultora  
			and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
			and op.TipoPersonalizacion = 'OPT'
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
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
		FROM Estrategia E with(nolock)
		INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON 
			op.CodConsultora = @codConsultoraDefault  
			and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
			and op.TipoPersonalizacion = 'OPT'
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
		WHERE
			E.Activo = 1
			AND ca.Codigo = @CampaniaID
			AND TE.FlagActivo = 1
			AND TE.flagRecoPerfil = 1
			AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
	
	END
	
	SELECT
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
	FROM #TEMPORAL T
		LEFT JOIN Marca M with(nolock) ON M.MarcaId = T.MarcaId
	ORDER BY
		Orden1 ASC, CASE WHEN ISNULL(T.Orden2,0) = 0 THEN T.Orden1 ELSE T.Orden2 END ASC, EstrategiaID ASC
	
	DROP TABLE #TEMPORAL

SET NOCOUNT OFF
END
go

go
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListarEstrategiasRevistaDigital]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ListarEstrategiasRevistaDigital]
GO

go
CREATE PROCEDURE [dbo].[ListarEstrategiasRevistaDigital]
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
		FlagMostrarImg int
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
	FROM Estrategia E with(nolock)
		INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON 
			op.CodConsultora = @CodigoConsultora  
			and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
			and op.TipoPersonalizacion in ('OPM', 'PAD')
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
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
		FROM Estrategia E with(nolock)
		INNER JOIN ods.OfertasPersonalizadas op with(nolock) ON 
			op.CodConsultora = @codConsultoraDefault  
			and E.CUV2 = op.CUV and op.AnioCampanaVenta = E.CampaniaID
			and op.TipoPersonalizacion in ('OPM', 'PAD')
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
		WHERE
			E.Activo = 1
			AND ca.Codigo = @CampaniaID
			AND TE.FlagActivo = 1
			AND TE.flagRecoPerfil = 1
			AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
	
	END
	
	SELECT
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
	FROM #TEMPORAL T
		LEFT JOIN Marca M with(nolock) ON M.MarcaId = T.MarcaId
	ORDER BY
		Orden1 ASC, CASE WHEN ISNULL(T.Orden2,0) = 0 THEN T.Orden1 ELSE T.Orden2 END ASC, EstrategiaID ASC
	
	DROP TABLE #TEMPORAL

SET NOCOUNT OFF
END

go

go
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListarEstrategiasOfertaWeb]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ListarEstrategiasOfertaWeb]
GO

go
CREATE PROCEDURE [dbo].[ListarEstrategiasOfertaWeb]
	@CampaniaID INT,
	@ZonaID INT
AS
/*
dbo.ListarEstrategiasOfertaWeb 201710, ''
*/
BEGIN
SET NOCOUNT ON;
	
	SELECT
		EstrategiaID,
		CUV2,
		DescripcionCUV2,
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
		Precio,
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
		e.Orden Orden2,
		pc.IndicadorMontoMinimo,
		pc.CodigoProducto,
		te.flagNueva,
		'' as TipoTallaColor,
		4 as TipoEstrategiaImagenMostrar
		, E.EtiquetaID
		, E.EtiquetaID2
		, E.CodigoEstrategia
		, E.TieneVariedad
		, TE.CODIGO
		, TE.DescripcionEstrategia
		, ISNULL(TE.FlagMostrarImg,0) AS FlagMostrarImg	
	FROM Estrategia E with(nolock)
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
		INNER JOIN ods.Campania CA with(nolock) ON E.CampaniaID = CA.Codigo
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
	WHERE
		E.Activo = 1
		AND TE.FlagActivo = 1
		AND E.CampaniaID = @CampaniaID
		AND TE.flagRecoProduc = 0
		AND TE.flagNueva = 0
		AND TE.flagRecoPerfil = 0
		AND E.Zona LIKE '%' + Convert(varchar, @ZonaID) + '%'

SET NOCOUNT OFF
END

go

