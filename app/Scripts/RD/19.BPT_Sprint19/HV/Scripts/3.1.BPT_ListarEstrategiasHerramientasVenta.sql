USE BelcorpPeru
GO

PRINT DB_NAME()
 
IF EXISTS (
	SELECT 1 
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[dbo].[ListarEstrategiasHerramientasVenta]')
	AND Type in (N'P',N'PC')
)
	PRINT 'Eliminando procedure ListarEstrategiasHerramientasVenta'
	DROP PROCEDURE [dbo].[ListarEstrategiasHerramientasVenta]
GO

PRINT 'Creando procedure ListarEstrategiasHerramientasVenta'
GO

CREATE PROCEDURE [dbo].[ListarEstrategiasHerramientasVenta]
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(30)
AS
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
		Ganancia decimal(18,2),
		Niveles varchar(200)
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
		1 Orden2,
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
		, E.Niveles
	FROM Estrategia E with(nolock)
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
			AND TE.Codigo in ('011')
	WHERE
		E.Activo = 1
		AND ca.Codigo = @CampaniaID
		AND TE.FlagActivo = 1
		AND TE.flagRecoPerfil = 1
		AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
	
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
		, T.PrecioPublico
		, T.Ganancia
		, T.Niveles
	FROM #TEMPORAL T
		LEFT JOIN Marca M with(nolock) ON M.MarcaId = T.MarcaId
	ORDER BY
		Orden1 ASC, CASE WHEN ISNULL(T.Orden2,0) = 0 THEN T.Orden1 ELSE T.Orden2 END ASC, EstrategiaID ASC
	
	DROP TABLE #TEMPORAL

SET NOCOUNT OFF
END

USE BelcorpMexico
GO

PRINT DB_NAME()
 
IF EXISTS (
	SELECT 1 
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[dbo].[ListarEstrategiasHerramientasVenta]')
	AND Type in (N'P',N'PC')
)
	PRINT 'Eliminando procedure ListarEstrategiasHerramientasVenta'
	DROP PROCEDURE [dbo].[ListarEstrategiasHerramientasVenta]
GO

PRINT 'Creando procedure ListarEstrategiasHerramientasVenta'
GO

CREATE PROCEDURE [dbo].[ListarEstrategiasHerramientasVenta]
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(30)
AS
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
		Ganancia decimal(18,2),
		Niveles varchar(200)
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
		1 Orden2,
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
		, E.Niveles
	FROM Estrategia E with(nolock)
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
			AND TE.Codigo in ('011')
	WHERE
		E.Activo = 1
		AND ca.Codigo = @CampaniaID
		AND TE.FlagActivo = 1
		AND TE.flagRecoPerfil = 1
		AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
	
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
		, T.PrecioPublico
		, T.Ganancia
		, T.Niveles
	FROM #TEMPORAL T
		LEFT JOIN Marca M with(nolock) ON M.MarcaId = T.MarcaId
	ORDER BY
		Orden1 ASC, CASE WHEN ISNULL(T.Orden2,0) = 0 THEN T.Orden1 ELSE T.Orden2 END ASC, EstrategiaID ASC
	
	DROP TABLE #TEMPORAL

SET NOCOUNT OFF
END

USE BelcorpColombia
GO

PRINT DB_NAME()
 
IF EXISTS (
	SELECT 1 
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[dbo].[ListarEstrategiasHerramientasVenta]')
	AND Type in (N'P',N'PC')
)
	PRINT 'Eliminando procedure ListarEstrategiasHerramientasVenta'
	DROP PROCEDURE [dbo].[ListarEstrategiasHerramientasVenta]
GO

PRINT 'Creando procedure ListarEstrategiasHerramientasVenta'
GO

CREATE PROCEDURE [dbo].[ListarEstrategiasHerramientasVenta]
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(30)
AS
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
		Ganancia decimal(18,2),
		Niveles varchar(200)
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
		1 Orden2,
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
		, E.Niveles
	FROM Estrategia E with(nolock)
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
			AND TE.Codigo in ('011')
	WHERE
		E.Activo = 1
		AND ca.Codigo = @CampaniaID
		AND TE.FlagActivo = 1
		AND TE.flagRecoPerfil = 1
		AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
	
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
		, T.PrecioPublico
		, T.Ganancia
		, T.Niveles
	FROM #TEMPORAL T
		LEFT JOIN Marca M with(nolock) ON M.MarcaId = T.MarcaId
	ORDER BY
		Orden1 ASC, CASE WHEN ISNULL(T.Orden2,0) = 0 THEN T.Orden1 ELSE T.Orden2 END ASC, EstrategiaID ASC
	
	DROP TABLE #TEMPORAL

SET NOCOUNT OFF
END

USE BelcorpVenezuela
GO

PRINT DB_NAME()
 
IF EXISTS (
	SELECT 1 
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[dbo].[ListarEstrategiasHerramientasVenta]')
	AND Type in (N'P',N'PC')
)
	PRINT 'Eliminando procedure ListarEstrategiasHerramientasVenta'
	DROP PROCEDURE [dbo].[ListarEstrategiasHerramientasVenta]
GO

PRINT 'Creando procedure ListarEstrategiasHerramientasVenta'
GO

CREATE PROCEDURE [dbo].[ListarEstrategiasHerramientasVenta]
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(30)
AS
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
		Ganancia decimal(18,2),
		Niveles varchar(200)
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
		1 Orden2,
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
		, E.Niveles
	FROM Estrategia E with(nolock)
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
			AND TE.Codigo in ('011')
	WHERE
		E.Activo = 1
		AND ca.Codigo = @CampaniaID
		AND TE.FlagActivo = 1
		AND TE.flagRecoPerfil = 1
		AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
	
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
		, T.PrecioPublico
		, T.Ganancia
		, T.Niveles
	FROM #TEMPORAL T
		LEFT JOIN Marca M with(nolock) ON M.MarcaId = T.MarcaId
	ORDER BY
		Orden1 ASC, CASE WHEN ISNULL(T.Orden2,0) = 0 THEN T.Orden1 ELSE T.Orden2 END ASC, EstrategiaID ASC
	
	DROP TABLE #TEMPORAL

SET NOCOUNT OFF
END

USE BelcorpSalvador
GO

PRINT DB_NAME()
 
IF EXISTS (
	SELECT 1 
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[dbo].[ListarEstrategiasHerramientasVenta]')
	AND Type in (N'P',N'PC')
)
	PRINT 'Eliminando procedure ListarEstrategiasHerramientasVenta'
	DROP PROCEDURE [dbo].[ListarEstrategiasHerramientasVenta]
GO

PRINT 'Creando procedure ListarEstrategiasHerramientasVenta'
GO

CREATE PROCEDURE [dbo].[ListarEstrategiasHerramientasVenta]
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(30)
AS
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
		Ganancia decimal(18,2),
		Niveles varchar(200)
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
		1 Orden2,
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
		, E.Niveles
	FROM Estrategia E with(nolock)
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
			AND TE.Codigo in ('011')
	WHERE
		E.Activo = 1
		AND ca.Codigo = @CampaniaID
		AND TE.FlagActivo = 1
		AND TE.flagRecoPerfil = 1
		AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
	
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
		, T.PrecioPublico
		, T.Ganancia
		, T.Niveles
	FROM #TEMPORAL T
		LEFT JOIN Marca M with(nolock) ON M.MarcaId = T.MarcaId
	ORDER BY
		Orden1 ASC, CASE WHEN ISNULL(T.Orden2,0) = 0 THEN T.Orden1 ELSE T.Orden2 END ASC, EstrategiaID ASC
	
	DROP TABLE #TEMPORAL

SET NOCOUNT OFF
END

USE BelcorpPuertoRico
GO

PRINT DB_NAME()
 
IF EXISTS (
	SELECT 1 
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[dbo].[ListarEstrategiasHerramientasVenta]')
	AND Type in (N'P',N'PC')
)
	PRINT 'Eliminando procedure ListarEstrategiasHerramientasVenta'
	DROP PROCEDURE [dbo].[ListarEstrategiasHerramientasVenta]
GO

PRINT 'Creando procedure ListarEstrategiasHerramientasVenta'
GO

CREATE PROCEDURE [dbo].[ListarEstrategiasHerramientasVenta]
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(30)
AS
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
		Ganancia decimal(18,2),
		Niveles varchar(200)
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
		1 Orden2,
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
		, E.Niveles
	FROM Estrategia E with(nolock)
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
			AND TE.Codigo in ('011')
	WHERE
		E.Activo = 1
		AND ca.Codigo = @CampaniaID
		AND TE.FlagActivo = 1
		AND TE.flagRecoPerfil = 1
		AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
	
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
		, T.PrecioPublico
		, T.Ganancia
		, T.Niveles
	FROM #TEMPORAL T
		LEFT JOIN Marca M with(nolock) ON M.MarcaId = T.MarcaId
	ORDER BY
		Orden1 ASC, CASE WHEN ISNULL(T.Orden2,0) = 0 THEN T.Orden1 ELSE T.Orden2 END ASC, EstrategiaID ASC
	
	DROP TABLE #TEMPORAL

SET NOCOUNT OFF
END

USE BelcorpPanama
GO

PRINT DB_NAME()
 
IF EXISTS (
	SELECT 1 
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[dbo].[ListarEstrategiasHerramientasVenta]')
	AND Type in (N'P',N'PC')
)
	PRINT 'Eliminando procedure ListarEstrategiasHerramientasVenta'
	DROP PROCEDURE [dbo].[ListarEstrategiasHerramientasVenta]
GO

PRINT 'Creando procedure ListarEstrategiasHerramientasVenta'
GO

CREATE PROCEDURE [dbo].[ListarEstrategiasHerramientasVenta]
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(30)
AS
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
		Ganancia decimal(18,2),
		Niveles varchar(200)
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
		1 Orden2,
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
		, E.Niveles
	FROM Estrategia E with(nolock)
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
			AND TE.Codigo in ('011')
	WHERE
		E.Activo = 1
		AND ca.Codigo = @CampaniaID
		AND TE.FlagActivo = 1
		AND TE.flagRecoPerfil = 1
		AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
	
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
		, T.PrecioPublico
		, T.Ganancia
		, T.Niveles
	FROM #TEMPORAL T
		LEFT JOIN Marca M with(nolock) ON M.MarcaId = T.MarcaId
	ORDER BY
		Orden1 ASC, CASE WHEN ISNULL(T.Orden2,0) = 0 THEN T.Orden1 ELSE T.Orden2 END ASC, EstrategiaID ASC
	
	DROP TABLE #TEMPORAL

SET NOCOUNT OFF
END

USE BelcorpGuatemala
GO

PRINT DB_NAME()
 
IF EXISTS (
	SELECT 1 
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[dbo].[ListarEstrategiasHerramientasVenta]')
	AND Type in (N'P',N'PC')
)
	PRINT 'Eliminando procedure ListarEstrategiasHerramientasVenta'
	DROP PROCEDURE [dbo].[ListarEstrategiasHerramientasVenta]
GO

PRINT 'Creando procedure ListarEstrategiasHerramientasVenta'
GO

CREATE PROCEDURE [dbo].[ListarEstrategiasHerramientasVenta]
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(30)
AS
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
		Ganancia decimal(18,2),
		Niveles varchar(200)
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
		1 Orden2,
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
		, E.Niveles
	FROM Estrategia E with(nolock)
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
			AND TE.Codigo in ('011')
	WHERE
		E.Activo = 1
		AND ca.Codigo = @CampaniaID
		AND TE.FlagActivo = 1
		AND TE.flagRecoPerfil = 1
		AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
	
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
		, T.PrecioPublico
		, T.Ganancia
		, T.Niveles
	FROM #TEMPORAL T
		LEFT JOIN Marca M with(nolock) ON M.MarcaId = T.MarcaId
	ORDER BY
		Orden1 ASC, CASE WHEN ISNULL(T.Orden2,0) = 0 THEN T.Orden1 ELSE T.Orden2 END ASC, EstrategiaID ASC
	
	DROP TABLE #TEMPORAL

SET NOCOUNT OFF
END

USE BelcorpEcuador
GO

PRINT DB_NAME()
 
IF EXISTS (
	SELECT 1 
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[dbo].[ListarEstrategiasHerramientasVenta]')
	AND Type in (N'P',N'PC')
)
	PRINT 'Eliminando procedure ListarEstrategiasHerramientasVenta'
	DROP PROCEDURE [dbo].[ListarEstrategiasHerramientasVenta]
GO

PRINT 'Creando procedure ListarEstrategiasHerramientasVenta'
GO

CREATE PROCEDURE [dbo].[ListarEstrategiasHerramientasVenta]
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(30)
AS
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
		Ganancia decimal(18,2),
		Niveles varchar(200)
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
		1 Orden2,
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
		, E.Niveles
	FROM Estrategia E with(nolock)
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
			AND TE.Codigo in ('011')
	WHERE
		E.Activo = 1
		AND ca.Codigo = @CampaniaID
		AND TE.FlagActivo = 1
		AND TE.flagRecoPerfil = 1
		AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
	
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
		, T.PrecioPublico
		, T.Ganancia
		, T.Niveles
	FROM #TEMPORAL T
		LEFT JOIN Marca M with(nolock) ON M.MarcaId = T.MarcaId
	ORDER BY
		Orden1 ASC, CASE WHEN ISNULL(T.Orden2,0) = 0 THEN T.Orden1 ELSE T.Orden2 END ASC, EstrategiaID ASC
	
	DROP TABLE #TEMPORAL

SET NOCOUNT OFF
END

USE BelcorpDominicana
GO

PRINT DB_NAME()
 
IF EXISTS (
	SELECT 1 
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[dbo].[ListarEstrategiasHerramientasVenta]')
	AND Type in (N'P',N'PC')
)
	PRINT 'Eliminando procedure ListarEstrategiasHerramientasVenta'
	DROP PROCEDURE [dbo].[ListarEstrategiasHerramientasVenta]
GO

PRINT 'Creando procedure ListarEstrategiasHerramientasVenta'
GO

CREATE PROCEDURE [dbo].[ListarEstrategiasHerramientasVenta]
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(30)
AS
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
		Ganancia decimal(18,2),
		Niveles varchar(200)
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
		1 Orden2,
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
		, E.Niveles
	FROM Estrategia E with(nolock)
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
			AND TE.Codigo in ('011')
	WHERE
		E.Activo = 1
		AND ca.Codigo = @CampaniaID
		AND TE.FlagActivo = 1
		AND TE.flagRecoPerfil = 1
		AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
	
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
		, T.PrecioPublico
		, T.Ganancia
		, T.Niveles
	FROM #TEMPORAL T
		LEFT JOIN Marca M with(nolock) ON M.MarcaId = T.MarcaId
	ORDER BY
		Orden1 ASC, CASE WHEN ISNULL(T.Orden2,0) = 0 THEN T.Orden1 ELSE T.Orden2 END ASC, EstrategiaID ASC
	
	DROP TABLE #TEMPORAL

SET NOCOUNT OFF
END

USE BelcorpCostaRica
GO

PRINT DB_NAME()
 
IF EXISTS (
	SELECT 1 
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[dbo].[ListarEstrategiasHerramientasVenta]')
	AND Type in (N'P',N'PC')
)
	PRINT 'Eliminando procedure ListarEstrategiasHerramientasVenta'
	DROP PROCEDURE [dbo].[ListarEstrategiasHerramientasVenta]
GO

PRINT 'Creando procedure ListarEstrategiasHerramientasVenta'
GO

CREATE PROCEDURE [dbo].[ListarEstrategiasHerramientasVenta]
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(30)
AS
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
		Ganancia decimal(18,2),
		Niveles varchar(200)
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
		1 Orden2,
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
		, E.Niveles
	FROM Estrategia E with(nolock)
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
			AND TE.Codigo in ('011')
	WHERE
		E.Activo = 1
		AND ca.Codigo = @CampaniaID
		AND TE.FlagActivo = 1
		AND TE.flagRecoPerfil = 1
		AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
	
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
		, T.PrecioPublico
		, T.Ganancia
		, T.Niveles
	FROM #TEMPORAL T
		LEFT JOIN Marca M with(nolock) ON M.MarcaId = T.MarcaId
	ORDER BY
		Orden1 ASC, CASE WHEN ISNULL(T.Orden2,0) = 0 THEN T.Orden1 ELSE T.Orden2 END ASC, EstrategiaID ASC
	
	DROP TABLE #TEMPORAL

SET NOCOUNT OFF
END

USE BelcorpChile
GO

PRINT DB_NAME()
 
IF EXISTS (
	SELECT 1 
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[dbo].[ListarEstrategiasHerramientasVenta]')
	AND Type in (N'P',N'PC')
)
	PRINT 'Eliminando procedure ListarEstrategiasHerramientasVenta'
	DROP PROCEDURE [dbo].[ListarEstrategiasHerramientasVenta]
GO

PRINT 'Creando procedure ListarEstrategiasHerramientasVenta'
GO

CREATE PROCEDURE [dbo].[ListarEstrategiasHerramientasVenta]
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(30)
AS
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
		Ganancia decimal(18,2),
		Niveles varchar(200)
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
		1 Orden2,
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
		, E.Niveles
	FROM Estrategia E with(nolock)
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
			AND TE.Codigo in ('011')
	WHERE
		E.Activo = 1
		AND ca.Codigo = @CampaniaID
		AND TE.FlagActivo = 1
		AND TE.flagRecoPerfil = 1
		AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
	
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
		, T.PrecioPublico
		, T.Ganancia
		, T.Niveles
	FROM #TEMPORAL T
		LEFT JOIN Marca M with(nolock) ON M.MarcaId = T.MarcaId
	ORDER BY
		Orden1 ASC, CASE WHEN ISNULL(T.Orden2,0) = 0 THEN T.Orden1 ELSE T.Orden2 END ASC, EstrategiaID ASC
	
	DROP TABLE #TEMPORAL

SET NOCOUNT OFF
END

USE BelcorpBolivia
GO

PRINT DB_NAME()
 
IF EXISTS (
	SELECT 1 
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[dbo].[ListarEstrategiasHerramientasVenta]')
	AND Type in (N'P',N'PC')
)
	PRINT 'Eliminando procedure ListarEstrategiasHerramientasVenta'
	DROP PROCEDURE [dbo].[ListarEstrategiasHerramientasVenta]
GO

PRINT 'Creando procedure ListarEstrategiasHerramientasVenta'
GO

CREATE PROCEDURE [dbo].[ListarEstrategiasHerramientasVenta]
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(30)
AS
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
		Ganancia decimal(18,2),
		Niveles varchar(200)
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
		1 Orden2,
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
		, E.Niveles
	FROM Estrategia E with(nolock)
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
			AND TE.Codigo in ('011')
	WHERE
		E.Activo = 1
		AND ca.Codigo = @CampaniaID
		AND TE.FlagActivo = 1
		AND TE.flagRecoPerfil = 1
		AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
	
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
		, T.PrecioPublico
		, T.Ganancia
		, T.Niveles
	FROM #TEMPORAL T
		LEFT JOIN Marca M with(nolock) ON M.MarcaId = T.MarcaId
	ORDER BY
		Orden1 ASC, CASE WHEN ISNULL(T.Orden2,0) = 0 THEN T.Orden1 ELSE T.Orden2 END ASC, EstrategiaID ASC
	
	DROP TABLE #TEMPORAL

SET NOCOUNT OFF
END

