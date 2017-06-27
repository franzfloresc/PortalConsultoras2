USE BelcorpPeru
GO

GO
ALTER PROCEDURE [dbo].[ListarEstrategiasPedido_SB2]
	@CampaniaID INT,
	@ConsultoraID VARCHAR(30),
	@CUV VARCHAR(20),
	@ZonaID VARCHAR(20),
	@CodigoAgrupacion VARCHAR(10) = ''
AS
/*
dbo.ListarEstrategiasPedido_SB2 201710,'1107','','2329', '101'
*/
BEGIN
	SET NOCOUNT ON;
	
	--declare @CampaniaID INT = 201710,
	--@ConsultoraID VARCHAR(30) = '1107',
	--@CUV VARCHAR(20) = '',
	--@ZonaID VARCHAR(20) = '2329',
	--@CodigoAgrupacion VARCHAR(10) = '101'
		

	set @CodigoAgrupacion = ISNULL(@CodigoAgrupacion, '')

	-- CrossSelling se implemento a un servicio
	--DECLARE @CuvReco VARCHAR(20)
	--SELECT @CuvReco = CSA.CUV
	--FROM CrossSellingAsociacion CSA
	--INNER JOIN ods.Campania CA ON CSA.CampaniaID = CA.CampaniaID
	--WHERE
	--	CA.Codigo = @CampaniaID
	--	AND (CUVAsociado = @CUV OR CUVAsociado2 = @CUV OR CUV = @CUV)

	--/* RECOMENDACION POR CUV - INICIO */
	--SELECT
	--	EstrategiaID,
	--	CUV2,
	--	DescripcionCUV2,
	--	dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
	--	E.Precio,
	--	dbo.ObtenerDescripcionEtiqueta(EtiquetaID2) EtiquetaDescripcion2,
	--	Precio2,
	--	TextoLibre,
	--	FlagEstrella,
	--	ColorFondo,
	--	e.TipoEstrategiaID,
	--	e.ImagenURL FotoProducto01,
	--	te.ImagenEstrategia ImagenURL,
	--	e.LimiteVenta,
	--	pc.MarcaID,
	--	te.Orden Orden1,
	--	e.Orden Orden2,
	--	pc.IndicadorMontoMinimo,
	--	pc.CodigoProducto,
	--	TE.FlagNueva,
	--	dbo.fn_ObtenerTallaColorCuv_SB2(E.CUV2,@CampaniaID) as TipoTallaColor,
	--	1 as TipoEstrategiaImagenMostrar	--CrossSelling
	--	, E.EtiquetaID		-- SB20-351
	--	, E.EtiquetaID2		-- SB20-351
	--	, E.CodigoEstrategia
	--	, E.TieneVariedad
	--INTO #TEMPORAL
	--FROM Estrategia E
	--INNER JOIN TipoEstrategia TE ON E.TipoEstrategiaID = TE.TipoEstrategiaID
	--INNER JOIN ods.Campania CA ON E.CampaniaID = CA.Codigo
	--INNER JOIN CrossSellingAsociacion CSA ON CSA.CampaniaID = CA.CampaniaID AND (E.CUV2 = CSA.CUVAsociado OR E.CUV2 = CSA.CUVAsociado2 )
	--INNER JOIN ods.ProductoComercial PC ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
	--WHERE
	--	E.Activo = 1
	--	AND TE.flagRecoProduc = 1
	--	AND TE.FlagActivo = 1
	--	AND CSA.CUV IS NOT NULL
	--	AND CA.Codigo = @CampaniaID
	--	AND CSA.CUV = @CuvReco
	--	AND E.Zona LIKE '%' + @ZonaID + '%'
	--ORDER BY
	--	te.Orden ASC,
	--	e.Orden ASC
	--/* RECOMENDACION POR CUV - FIN */

	declare @ConsultoraID2 bigint = CAST(@ConsultoraID as bigint)

	DECLARE @tablaCuvPedido table (CUV varchar(6))
	insert into @tablaCuvPedido
	SELECT CUV
	FROM PedidoWebDetalle with(nolock)
	WHERE CampaniaID=@CampaniaID and ConsultoraID=@ConsultoraID2

	DECLARE @CodigoConsultora VARCHAR(25)
	DECLARE @NumeroPedido INT
	declare @CodigoRegion varchar(2) = null
	declare @CodigoZona varchar(4) = null

	SELECT
		@NumeroPedido = c.ConsecutivoNueva + 1,
		@CodigoConsultora = c.Codigo,
		@CodigoRegion = r.Codigo,
		@CodigoZona = z.Codigo
	FROM ods.Consultora c with(nolock)
		INNER JOIN ods.Region r with(nolock) on r.RegionID = c.RegionID
		INNER JOIN ods.Zona z with(nolock) on z.ZonaID = c.ZonaID
	WHERE 
		c.ConsultoraID = @ConsultoraID2

	CREATE TABLE #TEMPORAL (
		ColId uniqueIdentifier,
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

	-- Obtener estrategias de Pack Nuevas.
	INSERT INTO #TEMPORAL
	SELECT
		newId() AS ColId,
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
		1 AS FlagNueva, -- R2621
		--dbo.fn_ObtenerTallaColorCuv_SB2(E.CUV2,@CampaniaID) as TipoTallaColor,
		'' as TipoTallaColor,
		2 as TipoEstrategiaImagenMostrar	-- Pack Nuevas
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
		AND E.Activo = 1
		AND CPN.Participa = 1
		AND TE.FlagActivo = 1
		AND TE.flagNueva = 1
		AND E.NumeroPedido = @NumeroPedido
		AND E.Zona LIKE '%' + @ZonaID + '%'
		AND E.CUV2 not in(SELECT CUV FROM @tablaCuvPedido)
	--ORDER BY te.Orden ASC, e.Orden ASC

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

	DECLARE @cont1 INT, @cont2 INT, @codConsultoraDefault VARCHAR(9)
	SELECT @cont1 = COUNT(EstrategiaID) FROM #TEMPORAL
	
	INSERT INTO #TEMPORAL
		SELECT
		newId() AS ColId,
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
		--dbo.fn_ObtenerTallaColorCuv_SB2(E.CUV2,@CampaniaID) as TipoTallaColor,
		'' as TipoTallaColor,
		3 as TipoEstrategiaImagenMostrar	--Oferta para Ti
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
		and (
			( @CodigoAgrupacion = '101' and op.TipoPersonalizacion in ('LAN', 'OPM', 'PAD'))
			OR (@CodigoAgrupacion = '' and op.TipoPersonalizacion = 'OPT')
		)
	INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
	--INNER JOIN ods.Consultora c with(nolock) ON op.CodConsultora = c.Codigo
	INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
	INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
	WHERE
		E.Activo = 1
		AND ca.Codigo = @CampaniaID
		--AND c.ConsultoraID = @ConsultoraID2
		--AND E.Zona LIKE '%' + @ZonaID + '%'
		AND TE.FlagActivo = 1
		AND TE.flagRecoPerfil = 1
		AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
	--ORDER BY CASE WHEN ISNULL(op.Orden,0) = 0 THEN te.Orden ELSE op.Orden END ASC

	/*SB20-1080 - INICIO */
	SET @cont2 = (SELECT COUNT(EstrategiaID) FROM #TEMPORAL)

	IF (@cont1 = @cont2)
	BEGIN

		SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001

		INSERT INTO #TEMPORAL
		SELECT
		newId() AS ColId,
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
			--dbo.fn_ObtenerTallaColorCuv_SB2(E.CUV2,@CampaniaID) as TipoTallaColor,
			'' as TipoTallaColor,
			3 as TipoEstrategiaImagenMostrar	--Oferta para Ti
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
			and (
				( @CodigoAgrupacion = '101' and op.TipoPersonalizacion in ('LAN', 'OPM', 'PAD'))
				OR (@CodigoAgrupacion = '' and op.TipoPersonalizacion = 'OPT')
			)
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		--INNER JOIN ods.Consultora c with(nolock) ON op.CodConsultora = c.Codigo
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
		WHERE
			E.Activo = 1
			AND ca.Codigo = @CampaniaID
			--AND c.ConsultoraID = @ConsultoraID2
			--AND E.Zona LIKE '%' + @ZonaID + '%'
			AND TE.FlagActivo = 1
			AND TE.flagRecoPerfil = 1
			AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
		--ORDER BY CASE WHEN ISNULL(op.Orden,0) = 0 THEN te.Orden ELSE op.Orden END ASC
	END

	IF @CodigoAgrupacion = ''
	BEGIN
	--  Oferta Web y Lanzamiento
	INSERT INTO #TEMPORAL
	SELECT
		newId() AS ColId,
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
		--dbo.fn_ObtenerTallaColorCuv_SB2(E.CUV2,@CampaniaID) as TipoTallaColor,
		'' as TipoTallaColor,
		4 as TipoEstrategiaImagenMostrar	--Oferta Web
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
		AND E.Zona LIKE '%' + @ZonaID + '%'
	--ORDER BY te.Orden ASC, e.Orden ASC

	END -- @CodigoAgrupacion = ''

	DECLARE @tablaCuvUnicos table (CUV varchar(6), Id uniqueIdentifier)
	
	insert into @tablaCuvUnicos
	select CUV2, NULL from #TEMPORAL
	group by CUV2 -- having count(CUV2) > 1

	update @tablaCuvUnicos
	set Id = (SELECT TOP 1 B.ColId FROM #TEMPORAL B WHERE  B.CUV2 = CUV)
	FROM @tablaCuvUnicos A

	DELETE B 
	--SELECT *
	FROM #TEMPORAL B
	LEFT JOIN @tablaCuvUnicos A
		ON B.CUV2 = A.CUV AND B.ColId = A.Id
	 WHERE A.CUV IS NULL	

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
	)

	IF @CodigoAgrupacion = '101'
	BEGIN

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
		FROM #TEMPORAL as T
			where T.CODIGO = '005'
		GROUP BY EstrategiaID

	END -- @CodigoAgrupacion = '101'
	
	SELECT
		T.EstrategiaID,
		T.CUV2,
		T.DescripcionCUV2,
		T.EtiquetaDescripcion,
		T.Precio,
		T.EtiquetaDescripcion2,
		T.Precio2,
		isnull(T.TextoLibre,'') as TextoLibre,
		T.FlagEstrella,
		T.ColorFondo,
		T.TipoEstrategiaID,
		T.FotoProducto01,
		T.ImagenURL,
		T.LimiteVenta,
		T.MarcaID,
		T.Orden1,
		T.Orden2,
		T.IndicadorMontoMinimo,
		T.FlagNueva,
		T.TipoTallaColor,
		T.TipoEstrategiaImagenMostrar,
		T.CodigoProducto
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
	FROM #TEMPORAL T
	LEFT JOIN Marca M with(nolock) ON M.MarcaId = T.MarcaId
	LEFT JOIN @temp D ON D.EstrategiaID = T.EstrategiaID
	ORDER BY
	Orden1 ASC, CASE WHEN ISNULL(T.Orden2,0) = 0 THEN T.Orden1 ELSE T.Orden2 END ASC, EstrategiaID ASC

	DROP TABLE #TEMPORAL

	SET NOCOUNT OFF
END

GO

USE BelcorpMexico
GO

GO
ALTER PROCEDURE [dbo].[ListarEstrategiasPedido_SB2]
	@CampaniaID INT,
	@ConsultoraID VARCHAR(30),
	@CUV VARCHAR(20),
	@ZonaID VARCHAR(20),
	@CodigoAgrupacion VARCHAR(10) = ''
AS
/*
dbo.ListarEstrategiasPedido_SB2 201710,'1107','','2329', '101'
*/
BEGIN
	SET NOCOUNT ON;
	
	--declare @CampaniaID INT = 201710,
	--@ConsultoraID VARCHAR(30) = '1107',
	--@CUV VARCHAR(20) = '',
	--@ZonaID VARCHAR(20) = '2329',
	--@CodigoAgrupacion VARCHAR(10) = '101'
		

	set @CodigoAgrupacion = ISNULL(@CodigoAgrupacion, '')

	-- CrossSelling se implemento a un servicio
	--DECLARE @CuvReco VARCHAR(20)
	--SELECT @CuvReco = CSA.CUV
	--FROM CrossSellingAsociacion CSA
	--INNER JOIN ods.Campania CA ON CSA.CampaniaID = CA.CampaniaID
	--WHERE
	--	CA.Codigo = @CampaniaID
	--	AND (CUVAsociado = @CUV OR CUVAsociado2 = @CUV OR CUV = @CUV)

	--/* RECOMENDACION POR CUV - INICIO */
	--SELECT
	--	EstrategiaID,
	--	CUV2,
	--	DescripcionCUV2,
	--	dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
	--	E.Precio,
	--	dbo.ObtenerDescripcionEtiqueta(EtiquetaID2) EtiquetaDescripcion2,
	--	Precio2,
	--	TextoLibre,
	--	FlagEstrella,
	--	ColorFondo,
	--	e.TipoEstrategiaID,
	--	e.ImagenURL FotoProducto01,
	--	te.ImagenEstrategia ImagenURL,
	--	e.LimiteVenta,
	--	pc.MarcaID,
	--	te.Orden Orden1,
	--	e.Orden Orden2,
	--	pc.IndicadorMontoMinimo,
	--	pc.CodigoProducto,
	--	TE.FlagNueva,
	--	dbo.fn_ObtenerTallaColorCuv_SB2(E.CUV2,@CampaniaID) as TipoTallaColor,
	--	1 as TipoEstrategiaImagenMostrar	--CrossSelling
	--	, E.EtiquetaID		-- SB20-351
	--	, E.EtiquetaID2		-- SB20-351
	--	, E.CodigoEstrategia
	--	, E.TieneVariedad
	--INTO #TEMPORAL
	--FROM Estrategia E
	--INNER JOIN TipoEstrategia TE ON E.TipoEstrategiaID = TE.TipoEstrategiaID
	--INNER JOIN ods.Campania CA ON E.CampaniaID = CA.Codigo
	--INNER JOIN CrossSellingAsociacion CSA ON CSA.CampaniaID = CA.CampaniaID AND (E.CUV2 = CSA.CUVAsociado OR E.CUV2 = CSA.CUVAsociado2 )
	--INNER JOIN ods.ProductoComercial PC ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
	--WHERE
	--	E.Activo = 1
	--	AND TE.flagRecoProduc = 1
	--	AND TE.FlagActivo = 1
	--	AND CSA.CUV IS NOT NULL
	--	AND CA.Codigo = @CampaniaID
	--	AND CSA.CUV = @CuvReco
	--	AND E.Zona LIKE '%' + @ZonaID + '%'
	--ORDER BY
	--	te.Orden ASC,
	--	e.Orden ASC
	--/* RECOMENDACION POR CUV - FIN */

	declare @ConsultoraID2 bigint = CAST(@ConsultoraID as bigint)

	DECLARE @tablaCuvPedido table (CUV varchar(6))
	insert into @tablaCuvPedido
	SELECT CUV
	FROM PedidoWebDetalle with(nolock)
	WHERE CampaniaID=@CampaniaID and ConsultoraID=@ConsultoraID2

	DECLARE @CodigoConsultora VARCHAR(25)
	DECLARE @NumeroPedido INT
	declare @CodigoRegion varchar(2) = null
	declare @CodigoZona varchar(4) = null

	SELECT
		@NumeroPedido = c.ConsecutivoNueva + 1,
		@CodigoConsultora = c.Codigo,
		@CodigoRegion = r.Codigo,
		@CodigoZona = z.Codigo
	FROM ods.Consultora c with(nolock)
		INNER JOIN ods.Region r with(nolock) on r.RegionID = c.RegionID
		INNER JOIN ods.Zona z with(nolock) on z.ZonaID = c.ZonaID
	WHERE 
		c.ConsultoraID = @ConsultoraID2

	CREATE TABLE #TEMPORAL (
		ColId uniqueIdentifier,
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

	-- Obtener estrategias de Pack Nuevas.
	INSERT INTO #TEMPORAL
	SELECT
		newId() AS ColId,
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
		1 AS FlagNueva, -- R2621
		--dbo.fn_ObtenerTallaColorCuv_SB2(E.CUV2,@CampaniaID) as TipoTallaColor,
		'' as TipoTallaColor,
		2 as TipoEstrategiaImagenMostrar	-- Pack Nuevas
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
		AND E.Activo = 1
		AND CPN.Participa = 1
		AND TE.FlagActivo = 1
		AND TE.flagNueva = 1
		AND E.NumeroPedido = @NumeroPedido
		AND E.Zona LIKE '%' + @ZonaID + '%'
		AND E.CUV2 not in(SELECT CUV FROM @tablaCuvPedido)
	--ORDER BY te.Orden ASC, e.Orden ASC

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

	DECLARE @cont1 INT, @cont2 INT, @codConsultoraDefault VARCHAR(9)
	SELECT @cont1 = COUNT(EstrategiaID) FROM #TEMPORAL
	
	INSERT INTO #TEMPORAL
		SELECT
		newId() AS ColId,
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
		--dbo.fn_ObtenerTallaColorCuv_SB2(E.CUV2,@CampaniaID) as TipoTallaColor,
		'' as TipoTallaColor,
		3 as TipoEstrategiaImagenMostrar	--Oferta para Ti
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
		and (
			( @CodigoAgrupacion = '101' and op.TipoPersonalizacion in ('LAN', 'OPM', 'PAD'))
			OR (@CodigoAgrupacion = '' and op.TipoPersonalizacion = 'OPT')
		)
	INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
	--INNER JOIN ods.Consultora c with(nolock) ON op.CodConsultora = c.Codigo
	INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
	INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
	WHERE
		E.Activo = 1
		AND ca.Codigo = @CampaniaID
		--AND c.ConsultoraID = @ConsultoraID2
		--AND E.Zona LIKE '%' + @ZonaID + '%'
		AND TE.FlagActivo = 1
		AND TE.flagRecoPerfil = 1
		AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
	--ORDER BY CASE WHEN ISNULL(op.Orden,0) = 0 THEN te.Orden ELSE op.Orden END ASC

	/*SB20-1080 - INICIO */
	SET @cont2 = (SELECT COUNT(EstrategiaID) FROM #TEMPORAL)

	IF (@cont1 = @cont2)
	BEGIN

		SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001

		INSERT INTO #TEMPORAL
		SELECT
		newId() AS ColId,
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
			--dbo.fn_ObtenerTallaColorCuv_SB2(E.CUV2,@CampaniaID) as TipoTallaColor,
			'' as TipoTallaColor,
			3 as TipoEstrategiaImagenMostrar	--Oferta para Ti
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
			and (
				( @CodigoAgrupacion = '101' and op.TipoPersonalizacion in ('LAN', 'OPM', 'PAD'))
				OR (@CodigoAgrupacion = '' and op.TipoPersonalizacion = 'OPT')
			)
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		--INNER JOIN ods.Consultora c with(nolock) ON op.CodConsultora = c.Codigo
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
		WHERE
			E.Activo = 1
			AND ca.Codigo = @CampaniaID
			--AND c.ConsultoraID = @ConsultoraID2
			--AND E.Zona LIKE '%' + @ZonaID + '%'
			AND TE.FlagActivo = 1
			AND TE.flagRecoPerfil = 1
			AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
		--ORDER BY CASE WHEN ISNULL(op.Orden,0) = 0 THEN te.Orden ELSE op.Orden END ASC
	END

	IF @CodigoAgrupacion = ''
	BEGIN
	--  Oferta Web y Lanzamiento
	INSERT INTO #TEMPORAL
	SELECT
		newId() AS ColId,
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
		--dbo.fn_ObtenerTallaColorCuv_SB2(E.CUV2,@CampaniaID) as TipoTallaColor,
		'' as TipoTallaColor,
		4 as TipoEstrategiaImagenMostrar	--Oferta Web
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
		AND E.Zona LIKE '%' + @ZonaID + '%'
	--ORDER BY te.Orden ASC, e.Orden ASC

	END -- @CodigoAgrupacion = ''

	DECLARE @tablaCuvUnicos table (CUV varchar(6), Id uniqueIdentifier)
	
	insert into @tablaCuvUnicos
	select CUV2, NULL from #TEMPORAL
	group by CUV2 -- having count(CUV2) > 1

	update @tablaCuvUnicos
	set Id = (SELECT TOP 1 B.ColId FROM #TEMPORAL B WHERE  B.CUV2 = CUV)
	FROM @tablaCuvUnicos A

	DELETE B 
	--SELECT *
	FROM #TEMPORAL B
	LEFT JOIN @tablaCuvUnicos A
		ON B.CUV2 = A.CUV AND B.ColId = A.Id
	 WHERE A.CUV IS NULL	

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
	)

	IF @CodigoAgrupacion = '101'
	BEGIN

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
		FROM #TEMPORAL as T
			where T.CODIGO = '005'
		GROUP BY EstrategiaID

	END -- @CodigoAgrupacion = '101'
	
	SELECT
		T.EstrategiaID,
		T.CUV2,
		T.DescripcionCUV2,
		T.EtiquetaDescripcion,
		T.Precio,
		T.EtiquetaDescripcion2,
		T.Precio2,
		isnull(T.TextoLibre,'') as TextoLibre,
		T.FlagEstrella,
		T.ColorFondo,
		T.TipoEstrategiaID,
		T.FotoProducto01,
		T.ImagenURL,
		T.LimiteVenta,
		T.MarcaID,
		T.Orden1,
		T.Orden2,
		T.IndicadorMontoMinimo,
		T.FlagNueva,
		T.TipoTallaColor,
		T.TipoEstrategiaImagenMostrar,
		T.CodigoProducto
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
	FROM #TEMPORAL T
	LEFT JOIN Marca M with(nolock) ON M.MarcaId = T.MarcaId
	LEFT JOIN @temp D ON D.EstrategiaID = T.EstrategiaID
	ORDER BY
	Orden1 ASC, CASE WHEN ISNULL(T.Orden2,0) = 0 THEN T.Orden1 ELSE T.Orden2 END ASC, EstrategiaID ASC

	DROP TABLE #TEMPORAL

	SET NOCOUNT OFF
END

GO

USE BelcorpColombia
GO

GO
ALTER PROCEDURE [dbo].[ListarEstrategiasPedido_SB2]
	@CampaniaID INT,
	@ConsultoraID VARCHAR(30),
	@CUV VARCHAR(20),
	@ZonaID VARCHAR(20),
	@CodigoAgrupacion VARCHAR(10) = ''
AS
/*
dbo.ListarEstrategiasPedido_SB2 201710,'1107','','2329', '101'
*/
BEGIN
	SET NOCOUNT ON;
	
	--declare @CampaniaID INT = 201710,
	--@ConsultoraID VARCHAR(30) = '1107',
	--@CUV VARCHAR(20) = '',
	--@ZonaID VARCHAR(20) = '2329',
	--@CodigoAgrupacion VARCHAR(10) = '101'
		

	set @CodigoAgrupacion = ISNULL(@CodigoAgrupacion, '')

	-- CrossSelling se implemento a un servicio
	--DECLARE @CuvReco VARCHAR(20)
	--SELECT @CuvReco = CSA.CUV
	--FROM CrossSellingAsociacion CSA
	--INNER JOIN ods.Campania CA ON CSA.CampaniaID = CA.CampaniaID
	--WHERE
	--	CA.Codigo = @CampaniaID
	--	AND (CUVAsociado = @CUV OR CUVAsociado2 = @CUV OR CUV = @CUV)

	--/* RECOMENDACION POR CUV - INICIO */
	--SELECT
	--	EstrategiaID,
	--	CUV2,
	--	DescripcionCUV2,
	--	dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
	--	E.Precio,
	--	dbo.ObtenerDescripcionEtiqueta(EtiquetaID2) EtiquetaDescripcion2,
	--	Precio2,
	--	TextoLibre,
	--	FlagEstrella,
	--	ColorFondo,
	--	e.TipoEstrategiaID,
	--	e.ImagenURL FotoProducto01,
	--	te.ImagenEstrategia ImagenURL,
	--	e.LimiteVenta,
	--	pc.MarcaID,
	--	te.Orden Orden1,
	--	e.Orden Orden2,
	--	pc.IndicadorMontoMinimo,
	--	pc.CodigoProducto,
	--	TE.FlagNueva,
	--	dbo.fn_ObtenerTallaColorCuv_SB2(E.CUV2,@CampaniaID) as TipoTallaColor,
	--	1 as TipoEstrategiaImagenMostrar	--CrossSelling
	--	, E.EtiquetaID		-- SB20-351
	--	, E.EtiquetaID2		-- SB20-351
	--	, E.CodigoEstrategia
	--	, E.TieneVariedad
	--INTO #TEMPORAL
	--FROM Estrategia E
	--INNER JOIN TipoEstrategia TE ON E.TipoEstrategiaID = TE.TipoEstrategiaID
	--INNER JOIN ods.Campania CA ON E.CampaniaID = CA.Codigo
	--INNER JOIN CrossSellingAsociacion CSA ON CSA.CampaniaID = CA.CampaniaID AND (E.CUV2 = CSA.CUVAsociado OR E.CUV2 = CSA.CUVAsociado2 )
	--INNER JOIN ods.ProductoComercial PC ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
	--WHERE
	--	E.Activo = 1
	--	AND TE.flagRecoProduc = 1
	--	AND TE.FlagActivo = 1
	--	AND CSA.CUV IS NOT NULL
	--	AND CA.Codigo = @CampaniaID
	--	AND CSA.CUV = @CuvReco
	--	AND E.Zona LIKE '%' + @ZonaID + '%'
	--ORDER BY
	--	te.Orden ASC,
	--	e.Orden ASC
	--/* RECOMENDACION POR CUV - FIN */

	declare @ConsultoraID2 bigint = CAST(@ConsultoraID as bigint)

	DECLARE @tablaCuvPedido table (CUV varchar(6))
	insert into @tablaCuvPedido
	SELECT CUV
	FROM PedidoWebDetalle with(nolock)
	WHERE CampaniaID=@CampaniaID and ConsultoraID=@ConsultoraID2

	DECLARE @CodigoConsultora VARCHAR(25)
	DECLARE @NumeroPedido INT
	declare @CodigoRegion varchar(2) = null
	declare @CodigoZona varchar(4) = null

	SELECT
		@NumeroPedido = c.ConsecutivoNueva + 1,
		@CodigoConsultora = c.Codigo,
		@CodigoRegion = r.Codigo,
		@CodigoZona = z.Codigo
	FROM ods.Consultora c with(nolock)
		INNER JOIN ods.Region r with(nolock) on r.RegionID = c.RegionID
		INNER JOIN ods.Zona z with(nolock) on z.ZonaID = c.ZonaID
	WHERE 
		c.ConsultoraID = @ConsultoraID2

	CREATE TABLE #TEMPORAL (
		ColId uniqueIdentifier,
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

	-- Obtener estrategias de Pack Nuevas.
	INSERT INTO #TEMPORAL
	SELECT
		newId() AS ColId,
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
		1 AS FlagNueva, -- R2621
		--dbo.fn_ObtenerTallaColorCuv_SB2(E.CUV2,@CampaniaID) as TipoTallaColor,
		'' as TipoTallaColor,
		2 as TipoEstrategiaImagenMostrar	-- Pack Nuevas
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
		AND E.Activo = 1
		AND CPN.Participa = 1
		AND TE.FlagActivo = 1
		AND TE.flagNueva = 1
		AND E.NumeroPedido = @NumeroPedido
		AND E.Zona LIKE '%' + @ZonaID + '%'
		AND E.CUV2 not in(SELECT CUV FROM @tablaCuvPedido)
	--ORDER BY te.Orden ASC, e.Orden ASC

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

	DECLARE @cont1 INT, @cont2 INT, @codConsultoraDefault VARCHAR(9)
	SELECT @cont1 = COUNT(EstrategiaID) FROM #TEMPORAL
	
	INSERT INTO #TEMPORAL
		SELECT
		newId() AS ColId,
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
		--dbo.fn_ObtenerTallaColorCuv_SB2(E.CUV2,@CampaniaID) as TipoTallaColor,
		'' as TipoTallaColor,
		3 as TipoEstrategiaImagenMostrar	--Oferta para Ti
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
		and (
			( @CodigoAgrupacion = '101' and op.TipoPersonalizacion in ('LAN', 'OPM', 'PAD'))
			OR (@CodigoAgrupacion = '' and op.TipoPersonalizacion = 'OPT')
		)
	INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
	--INNER JOIN ods.Consultora c with(nolock) ON op.CodConsultora = c.Codigo
	INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
	INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
	WHERE
		E.Activo = 1
		AND ca.Codigo = @CampaniaID
		--AND c.ConsultoraID = @ConsultoraID2
		--AND E.Zona LIKE '%' + @ZonaID + '%'
		AND TE.FlagActivo = 1
		AND TE.flagRecoPerfil = 1
		AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
	--ORDER BY CASE WHEN ISNULL(op.Orden,0) = 0 THEN te.Orden ELSE op.Orden END ASC

	/*SB20-1080 - INICIO */
	SET @cont2 = (SELECT COUNT(EstrategiaID) FROM #TEMPORAL)

	IF (@cont1 = @cont2)
	BEGIN

		SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001

		INSERT INTO #TEMPORAL
		SELECT
		newId() AS ColId,
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
			--dbo.fn_ObtenerTallaColorCuv_SB2(E.CUV2,@CampaniaID) as TipoTallaColor,
			'' as TipoTallaColor,
			3 as TipoEstrategiaImagenMostrar	--Oferta para Ti
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
			and (
				( @CodigoAgrupacion = '101' and op.TipoPersonalizacion in ('LAN', 'OPM', 'PAD'))
				OR (@CodigoAgrupacion = '' and op.TipoPersonalizacion = 'OPT')
			)
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		--INNER JOIN ods.Consultora c with(nolock) ON op.CodConsultora = c.Codigo
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
		WHERE
			E.Activo = 1
			AND ca.Codigo = @CampaniaID
			--AND c.ConsultoraID = @ConsultoraID2
			--AND E.Zona LIKE '%' + @ZonaID + '%'
			AND TE.FlagActivo = 1
			AND TE.flagRecoPerfil = 1
			AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
		--ORDER BY CASE WHEN ISNULL(op.Orden,0) = 0 THEN te.Orden ELSE op.Orden END ASC
	END

	IF @CodigoAgrupacion = ''
	BEGIN
	--  Oferta Web y Lanzamiento
	INSERT INTO #TEMPORAL
	SELECT
		newId() AS ColId,
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
		--dbo.fn_ObtenerTallaColorCuv_SB2(E.CUV2,@CampaniaID) as TipoTallaColor,
		'' as TipoTallaColor,
		4 as TipoEstrategiaImagenMostrar	--Oferta Web
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
		AND E.Zona LIKE '%' + @ZonaID + '%'
	--ORDER BY te.Orden ASC, e.Orden ASC

	END -- @CodigoAgrupacion = ''

	DECLARE @tablaCuvUnicos table (CUV varchar(6), Id uniqueIdentifier)
	
	insert into @tablaCuvUnicos
	select CUV2, NULL from #TEMPORAL
	group by CUV2 -- having count(CUV2) > 1

	update @tablaCuvUnicos
	set Id = (SELECT TOP 1 B.ColId FROM #TEMPORAL B WHERE  B.CUV2 = CUV)
	FROM @tablaCuvUnicos A

	DELETE B 
	--SELECT *
	FROM #TEMPORAL B
	LEFT JOIN @tablaCuvUnicos A
		ON B.CUV2 = A.CUV AND B.ColId = A.Id
	 WHERE A.CUV IS NULL	

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
	)

	IF @CodigoAgrupacion = '101'
	BEGIN

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
		FROM #TEMPORAL as T
			where T.CODIGO = '005'
		GROUP BY EstrategiaID

	END -- @CodigoAgrupacion = '101'
	
	SELECT
		T.EstrategiaID,
		T.CUV2,
		T.DescripcionCUV2,
		T.EtiquetaDescripcion,
		T.Precio,
		T.EtiquetaDescripcion2,
		T.Precio2,
		isnull(T.TextoLibre,'') as TextoLibre,
		T.FlagEstrella,
		T.ColorFondo,
		T.TipoEstrategiaID,
		T.FotoProducto01,
		T.ImagenURL,
		T.LimiteVenta,
		T.MarcaID,
		T.Orden1,
		T.Orden2,
		T.IndicadorMontoMinimo,
		T.FlagNueva,
		T.TipoTallaColor,
		T.TipoEstrategiaImagenMostrar,
		T.CodigoProducto
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
	FROM #TEMPORAL T
	LEFT JOIN Marca M with(nolock) ON M.MarcaId = T.MarcaId
	LEFT JOIN @temp D ON D.EstrategiaID = T.EstrategiaID
	ORDER BY
	Orden1 ASC, CASE WHEN ISNULL(T.Orden2,0) = 0 THEN T.Orden1 ELSE T.Orden2 END ASC, EstrategiaID ASC

	DROP TABLE #TEMPORAL

	SET NOCOUNT OFF
END

GO

USE BelcorpVenezuela
GO

GO
ALTER PROCEDURE [dbo].[ListarEstrategiasPedido_SB2]
	@CampaniaID INT,
	@ConsultoraID VARCHAR(30),
	@CUV VARCHAR(20),
	@ZonaID VARCHAR(20),
	@CodigoAgrupacion VARCHAR(10) = ''
AS
/*
dbo.ListarEstrategiasPedido_SB2 201710,'1107','','2329', '101'
*/
BEGIN
	SET NOCOUNT ON;
	
	--declare @CampaniaID INT = 201710,
	--@ConsultoraID VARCHAR(30) = '1107',
	--@CUV VARCHAR(20) = '',
	--@ZonaID VARCHAR(20) = '2329',
	--@CodigoAgrupacion VARCHAR(10) = '101'
		

	set @CodigoAgrupacion = ISNULL(@CodigoAgrupacion, '')

	-- CrossSelling se implemento a un servicio
	--DECLARE @CuvReco VARCHAR(20)
	--SELECT @CuvReco = CSA.CUV
	--FROM CrossSellingAsociacion CSA
	--INNER JOIN ods.Campania CA ON CSA.CampaniaID = CA.CampaniaID
	--WHERE
	--	CA.Codigo = @CampaniaID
	--	AND (CUVAsociado = @CUV OR CUVAsociado2 = @CUV OR CUV = @CUV)

	--/* RECOMENDACION POR CUV - INICIO */
	--SELECT
	--	EstrategiaID,
	--	CUV2,
	--	DescripcionCUV2,
	--	dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
	--	E.Precio,
	--	dbo.ObtenerDescripcionEtiqueta(EtiquetaID2) EtiquetaDescripcion2,
	--	Precio2,
	--	TextoLibre,
	--	FlagEstrella,
	--	ColorFondo,
	--	e.TipoEstrategiaID,
	--	e.ImagenURL FotoProducto01,
	--	te.ImagenEstrategia ImagenURL,
	--	e.LimiteVenta,
	--	pc.MarcaID,
	--	te.Orden Orden1,
	--	e.Orden Orden2,
	--	pc.IndicadorMontoMinimo,
	--	pc.CodigoProducto,
	--	TE.FlagNueva,
	--	dbo.fn_ObtenerTallaColorCuv_SB2(E.CUV2,@CampaniaID) as TipoTallaColor,
	--	1 as TipoEstrategiaImagenMostrar	--CrossSelling
	--	, E.EtiquetaID		-- SB20-351
	--	, E.EtiquetaID2		-- SB20-351
	--	, E.CodigoEstrategia
	--	, E.TieneVariedad
	--INTO #TEMPORAL
	--FROM Estrategia E
	--INNER JOIN TipoEstrategia TE ON E.TipoEstrategiaID = TE.TipoEstrategiaID
	--INNER JOIN ods.Campania CA ON E.CampaniaID = CA.Codigo
	--INNER JOIN CrossSellingAsociacion CSA ON CSA.CampaniaID = CA.CampaniaID AND (E.CUV2 = CSA.CUVAsociado OR E.CUV2 = CSA.CUVAsociado2 )
	--INNER JOIN ods.ProductoComercial PC ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
	--WHERE
	--	E.Activo = 1
	--	AND TE.flagRecoProduc = 1
	--	AND TE.FlagActivo = 1
	--	AND CSA.CUV IS NOT NULL
	--	AND CA.Codigo = @CampaniaID
	--	AND CSA.CUV = @CuvReco
	--	AND E.Zona LIKE '%' + @ZonaID + '%'
	--ORDER BY
	--	te.Orden ASC,
	--	e.Orden ASC
	--/* RECOMENDACION POR CUV - FIN */

	declare @ConsultoraID2 bigint = CAST(@ConsultoraID as bigint)

	DECLARE @tablaCuvPedido table (CUV varchar(6))
	insert into @tablaCuvPedido
	SELECT CUV
	FROM PedidoWebDetalle with(nolock)
	WHERE CampaniaID=@CampaniaID and ConsultoraID=@ConsultoraID2

	DECLARE @CodigoConsultora VARCHAR(25)
	DECLARE @NumeroPedido INT
	declare @CodigoRegion varchar(2) = null
	declare @CodigoZona varchar(4) = null

	SELECT
		@NumeroPedido = c.ConsecutivoNueva + 1,
		@CodigoConsultora = c.Codigo,
		@CodigoRegion = r.Codigo,
		@CodigoZona = z.Codigo
	FROM ods.Consultora c with(nolock)
		INNER JOIN ods.Region r with(nolock) on r.RegionID = c.RegionID
		INNER JOIN ods.Zona z with(nolock) on z.ZonaID = c.ZonaID
	WHERE 
		c.ConsultoraID = @ConsultoraID2

	CREATE TABLE #TEMPORAL (
		ColId uniqueIdentifier,
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

	-- Obtener estrategias de Pack Nuevas.
	INSERT INTO #TEMPORAL
	SELECT
		newId() AS ColId,
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
		1 AS FlagNueva, -- R2621
		--dbo.fn_ObtenerTallaColorCuv_SB2(E.CUV2,@CampaniaID) as TipoTallaColor,
		'' as TipoTallaColor,
		2 as TipoEstrategiaImagenMostrar	-- Pack Nuevas
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
		AND E.Activo = 1
		AND CPN.Participa = 1
		AND TE.FlagActivo = 1
		AND TE.flagNueva = 1
		AND E.NumeroPedido = @NumeroPedido
		AND E.Zona LIKE '%' + @ZonaID + '%'
		AND E.CUV2 not in(SELECT CUV FROM @tablaCuvPedido)
	--ORDER BY te.Orden ASC, e.Orden ASC

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

	DECLARE @cont1 INT, @cont2 INT, @codConsultoraDefault VARCHAR(9)
	SELECT @cont1 = COUNT(EstrategiaID) FROM #TEMPORAL
	
	INSERT INTO #TEMPORAL
		SELECT
		newId() AS ColId,
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
		--dbo.fn_ObtenerTallaColorCuv_SB2(E.CUV2,@CampaniaID) as TipoTallaColor,
		'' as TipoTallaColor,
		3 as TipoEstrategiaImagenMostrar	--Oferta para Ti
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
		and (
			( @CodigoAgrupacion = '101' and op.TipoPersonalizacion in ('LAN', 'OPM', 'PAD'))
			OR (@CodigoAgrupacion = '' and op.TipoPersonalizacion = 'OPT')
		)
	INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
	--INNER JOIN ods.Consultora c with(nolock) ON op.CodConsultora = c.Codigo
	INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
	INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
	WHERE
		E.Activo = 1
		AND ca.Codigo = @CampaniaID
		--AND c.ConsultoraID = @ConsultoraID2
		--AND E.Zona LIKE '%' + @ZonaID + '%'
		AND TE.FlagActivo = 1
		AND TE.flagRecoPerfil = 1
		AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
	--ORDER BY CASE WHEN ISNULL(op.Orden,0) = 0 THEN te.Orden ELSE op.Orden END ASC

	/*SB20-1080 - INICIO */
	SET @cont2 = (SELECT COUNT(EstrategiaID) FROM #TEMPORAL)

	IF (@cont1 = @cont2)
	BEGIN

		SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001

		INSERT INTO #TEMPORAL
		SELECT
		newId() AS ColId,
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
			--dbo.fn_ObtenerTallaColorCuv_SB2(E.CUV2,@CampaniaID) as TipoTallaColor,
			'' as TipoTallaColor,
			3 as TipoEstrategiaImagenMostrar	--Oferta para Ti
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
			and (
				( @CodigoAgrupacion = '101' and op.TipoPersonalizacion in ('LAN', 'OPM', 'PAD'))
				OR (@CodigoAgrupacion = '' and op.TipoPersonalizacion = 'OPT')
			)
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		--INNER JOIN ods.Consultora c with(nolock) ON op.CodConsultora = c.Codigo
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
		WHERE
			E.Activo = 1
			AND ca.Codigo = @CampaniaID
			--AND c.ConsultoraID = @ConsultoraID2
			--AND E.Zona LIKE '%' + @ZonaID + '%'
			AND TE.FlagActivo = 1
			AND TE.flagRecoPerfil = 1
			AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
		--ORDER BY CASE WHEN ISNULL(op.Orden,0) = 0 THEN te.Orden ELSE op.Orden END ASC
	END

	IF @CodigoAgrupacion = ''
	BEGIN
	--  Oferta Web y Lanzamiento
	INSERT INTO #TEMPORAL
	SELECT
		newId() AS ColId,
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
		--dbo.fn_ObtenerTallaColorCuv_SB2(E.CUV2,@CampaniaID) as TipoTallaColor,
		'' as TipoTallaColor,
		4 as TipoEstrategiaImagenMostrar	--Oferta Web
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
		AND E.Zona LIKE '%' + @ZonaID + '%'
	--ORDER BY te.Orden ASC, e.Orden ASC

	END -- @CodigoAgrupacion = ''

	DECLARE @tablaCuvUnicos table (CUV varchar(6), Id uniqueIdentifier)
	
	insert into @tablaCuvUnicos
	select CUV2, NULL from #TEMPORAL
	group by CUV2 -- having count(CUV2) > 1

	update @tablaCuvUnicos
	set Id = (SELECT TOP 1 B.ColId FROM #TEMPORAL B WHERE  B.CUV2 = CUV)
	FROM @tablaCuvUnicos A

	DELETE B 
	--SELECT *
	FROM #TEMPORAL B
	LEFT JOIN @tablaCuvUnicos A
		ON B.CUV2 = A.CUV AND B.ColId = A.Id
	 WHERE A.CUV IS NULL	

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
	)

	IF @CodigoAgrupacion = '101'
	BEGIN

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
		FROM #TEMPORAL as T
			where T.CODIGO = '005'
		GROUP BY EstrategiaID

	END -- @CodigoAgrupacion = '101'
	
	SELECT
		T.EstrategiaID,
		T.CUV2,
		T.DescripcionCUV2,
		T.EtiquetaDescripcion,
		T.Precio,
		T.EtiquetaDescripcion2,
		T.Precio2,
		isnull(T.TextoLibre,'') as TextoLibre,
		T.FlagEstrella,
		T.ColorFondo,
		T.TipoEstrategiaID,
		T.FotoProducto01,
		T.ImagenURL,
		T.LimiteVenta,
		T.MarcaID,
		T.Orden1,
		T.Orden2,
		T.IndicadorMontoMinimo,
		T.FlagNueva,
		T.TipoTallaColor,
		T.TipoEstrategiaImagenMostrar,
		T.CodigoProducto
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
	FROM #TEMPORAL T
	LEFT JOIN Marca M with(nolock) ON M.MarcaId = T.MarcaId
	LEFT JOIN @temp D ON D.EstrategiaID = T.EstrategiaID
	ORDER BY
	Orden1 ASC, CASE WHEN ISNULL(T.Orden2,0) = 0 THEN T.Orden1 ELSE T.Orden2 END ASC, EstrategiaID ASC

	DROP TABLE #TEMPORAL

	SET NOCOUNT OFF
END

GO

USE BelcorpSalvador
GO

GO
ALTER PROCEDURE [dbo].[ListarEstrategiasPedido_SB2]
	@CampaniaID INT,
	@ConsultoraID VARCHAR(30),
	@CUV VARCHAR(20),
	@ZonaID VARCHAR(20),
	@CodigoAgrupacion VARCHAR(10) = ''
AS
/*
dbo.ListarEstrategiasPedido_SB2 201710,'1107','','2329', '101'
*/
BEGIN
	SET NOCOUNT ON;
	
	--declare @CampaniaID INT = 201710,
	--@ConsultoraID VARCHAR(30) = '1107',
	--@CUV VARCHAR(20) = '',
	--@ZonaID VARCHAR(20) = '2329',
	--@CodigoAgrupacion VARCHAR(10) = '101'
		

	set @CodigoAgrupacion = ISNULL(@CodigoAgrupacion, '')

	-- CrossSelling se implemento a un servicio
	--DECLARE @CuvReco VARCHAR(20)
	--SELECT @CuvReco = CSA.CUV
	--FROM CrossSellingAsociacion CSA
	--INNER JOIN ods.Campania CA ON CSA.CampaniaID = CA.CampaniaID
	--WHERE
	--	CA.Codigo = @CampaniaID
	--	AND (CUVAsociado = @CUV OR CUVAsociado2 = @CUV OR CUV = @CUV)

	--/* RECOMENDACION POR CUV - INICIO */
	--SELECT
	--	EstrategiaID,
	--	CUV2,
	--	DescripcionCUV2,
	--	dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
	--	E.Precio,
	--	dbo.ObtenerDescripcionEtiqueta(EtiquetaID2) EtiquetaDescripcion2,
	--	Precio2,
	--	TextoLibre,
	--	FlagEstrella,
	--	ColorFondo,
	--	e.TipoEstrategiaID,
	--	e.ImagenURL FotoProducto01,
	--	te.ImagenEstrategia ImagenURL,
	--	e.LimiteVenta,
	--	pc.MarcaID,
	--	te.Orden Orden1,
	--	e.Orden Orden2,
	--	pc.IndicadorMontoMinimo,
	--	pc.CodigoProducto,
	--	TE.FlagNueva,
	--	dbo.fn_ObtenerTallaColorCuv_SB2(E.CUV2,@CampaniaID) as TipoTallaColor,
	--	1 as TipoEstrategiaImagenMostrar	--CrossSelling
	--	, E.EtiquetaID		-- SB20-351
	--	, E.EtiquetaID2		-- SB20-351
	--	, E.CodigoEstrategia
	--	, E.TieneVariedad
	--INTO #TEMPORAL
	--FROM Estrategia E
	--INNER JOIN TipoEstrategia TE ON E.TipoEstrategiaID = TE.TipoEstrategiaID
	--INNER JOIN ods.Campania CA ON E.CampaniaID = CA.Codigo
	--INNER JOIN CrossSellingAsociacion CSA ON CSA.CampaniaID = CA.CampaniaID AND (E.CUV2 = CSA.CUVAsociado OR E.CUV2 = CSA.CUVAsociado2 )
	--INNER JOIN ods.ProductoComercial PC ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
	--WHERE
	--	E.Activo = 1
	--	AND TE.flagRecoProduc = 1
	--	AND TE.FlagActivo = 1
	--	AND CSA.CUV IS NOT NULL
	--	AND CA.Codigo = @CampaniaID
	--	AND CSA.CUV = @CuvReco
	--	AND E.Zona LIKE '%' + @ZonaID + '%'
	--ORDER BY
	--	te.Orden ASC,
	--	e.Orden ASC
	--/* RECOMENDACION POR CUV - FIN */

	declare @ConsultoraID2 bigint = CAST(@ConsultoraID as bigint)

	DECLARE @tablaCuvPedido table (CUV varchar(6))
	insert into @tablaCuvPedido
	SELECT CUV
	FROM PedidoWebDetalle with(nolock)
	WHERE CampaniaID=@CampaniaID and ConsultoraID=@ConsultoraID2

	DECLARE @CodigoConsultora VARCHAR(25)
	DECLARE @NumeroPedido INT
	declare @CodigoRegion varchar(2) = null
	declare @CodigoZona varchar(4) = null

	SELECT
		@NumeroPedido = c.ConsecutivoNueva + 1,
		@CodigoConsultora = c.Codigo,
		@CodigoRegion = r.Codigo,
		@CodigoZona = z.Codigo
	FROM ods.Consultora c with(nolock)
		INNER JOIN ods.Region r with(nolock) on r.RegionID = c.RegionID
		INNER JOIN ods.Zona z with(nolock) on z.ZonaID = c.ZonaID
	WHERE 
		c.ConsultoraID = @ConsultoraID2

	CREATE TABLE #TEMPORAL (
		ColId uniqueIdentifier,
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

	-- Obtener estrategias de Pack Nuevas.
	INSERT INTO #TEMPORAL
	SELECT
		newId() AS ColId,
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
		1 AS FlagNueva, -- R2621
		--dbo.fn_ObtenerTallaColorCuv_SB2(E.CUV2,@CampaniaID) as TipoTallaColor,
		'' as TipoTallaColor,
		2 as TipoEstrategiaImagenMostrar	-- Pack Nuevas
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
		AND E.Activo = 1
		AND CPN.Participa = 1
		AND TE.FlagActivo = 1
		AND TE.flagNueva = 1
		AND E.NumeroPedido = @NumeroPedido
		AND E.Zona LIKE '%' + @ZonaID + '%'
		AND E.CUV2 not in(SELECT CUV FROM @tablaCuvPedido)
	--ORDER BY te.Orden ASC, e.Orden ASC

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

	DECLARE @cont1 INT, @cont2 INT, @codConsultoraDefault VARCHAR(9)
	SELECT @cont1 = COUNT(EstrategiaID) FROM #TEMPORAL
	
	INSERT INTO #TEMPORAL
		SELECT
		newId() AS ColId,
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
		--dbo.fn_ObtenerTallaColorCuv_SB2(E.CUV2,@CampaniaID) as TipoTallaColor,
		'' as TipoTallaColor,
		3 as TipoEstrategiaImagenMostrar	--Oferta para Ti
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
		and (
			( @CodigoAgrupacion = '101' and op.TipoPersonalizacion in ('LAN', 'OPM', 'PAD'))
			OR (@CodigoAgrupacion = '' and op.TipoPersonalizacion = 'OPT')
		)
	INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
	--INNER JOIN ods.Consultora c with(nolock) ON op.CodConsultora = c.Codigo
	INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
	INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
	WHERE
		E.Activo = 1
		AND ca.Codigo = @CampaniaID
		--AND c.ConsultoraID = @ConsultoraID2
		--AND E.Zona LIKE '%' + @ZonaID + '%'
		AND TE.FlagActivo = 1
		AND TE.flagRecoPerfil = 1
		AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
	--ORDER BY CASE WHEN ISNULL(op.Orden,0) = 0 THEN te.Orden ELSE op.Orden END ASC

	/*SB20-1080 - INICIO */
	SET @cont2 = (SELECT COUNT(EstrategiaID) FROM #TEMPORAL)

	IF (@cont1 = @cont2)
	BEGIN

		SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001

		INSERT INTO #TEMPORAL
		SELECT
		newId() AS ColId,
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
			--dbo.fn_ObtenerTallaColorCuv_SB2(E.CUV2,@CampaniaID) as TipoTallaColor,
			'' as TipoTallaColor,
			3 as TipoEstrategiaImagenMostrar	--Oferta para Ti
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
			and (
				( @CodigoAgrupacion = '101' and op.TipoPersonalizacion in ('LAN', 'OPM', 'PAD'))
				OR (@CodigoAgrupacion = '' and op.TipoPersonalizacion = 'OPT')
			)
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		--INNER JOIN ods.Consultora c with(nolock) ON op.CodConsultora = c.Codigo
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
		WHERE
			E.Activo = 1
			AND ca.Codigo = @CampaniaID
			--AND c.ConsultoraID = @ConsultoraID2
			--AND E.Zona LIKE '%' + @ZonaID + '%'
			AND TE.FlagActivo = 1
			AND TE.flagRecoPerfil = 1
			AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
		--ORDER BY CASE WHEN ISNULL(op.Orden,0) = 0 THEN te.Orden ELSE op.Orden END ASC
	END

	IF @CodigoAgrupacion = ''
	BEGIN
	--  Oferta Web y Lanzamiento
	INSERT INTO #TEMPORAL
	SELECT
		newId() AS ColId,
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
		--dbo.fn_ObtenerTallaColorCuv_SB2(E.CUV2,@CampaniaID) as TipoTallaColor,
		'' as TipoTallaColor,
		4 as TipoEstrategiaImagenMostrar	--Oferta Web
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
		AND E.Zona LIKE '%' + @ZonaID + '%'
	--ORDER BY te.Orden ASC, e.Orden ASC

	END -- @CodigoAgrupacion = ''

	DECLARE @tablaCuvUnicos table (CUV varchar(6), Id uniqueIdentifier)
	
	insert into @tablaCuvUnicos
	select CUV2, NULL from #TEMPORAL
	group by CUV2 -- having count(CUV2) > 1

	update @tablaCuvUnicos
	set Id = (SELECT TOP 1 B.ColId FROM #TEMPORAL B WHERE  B.CUV2 = CUV)
	FROM @tablaCuvUnicos A

	DELETE B 
	--SELECT *
	FROM #TEMPORAL B
	LEFT JOIN @tablaCuvUnicos A
		ON B.CUV2 = A.CUV AND B.ColId = A.Id
	 WHERE A.CUV IS NULL	

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
	)

	IF @CodigoAgrupacion = '101'
	BEGIN

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
		FROM #TEMPORAL as T
			where T.CODIGO = '005'
		GROUP BY EstrategiaID

	END -- @CodigoAgrupacion = '101'
	
	SELECT
		T.EstrategiaID,
		T.CUV2,
		T.DescripcionCUV2,
		T.EtiquetaDescripcion,
		T.Precio,
		T.EtiquetaDescripcion2,
		T.Precio2,
		isnull(T.TextoLibre,'') as TextoLibre,
		T.FlagEstrella,
		T.ColorFondo,
		T.TipoEstrategiaID,
		T.FotoProducto01,
		T.ImagenURL,
		T.LimiteVenta,
		T.MarcaID,
		T.Orden1,
		T.Orden2,
		T.IndicadorMontoMinimo,
		T.FlagNueva,
		T.TipoTallaColor,
		T.TipoEstrategiaImagenMostrar,
		T.CodigoProducto
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
	FROM #TEMPORAL T
	LEFT JOIN Marca M with(nolock) ON M.MarcaId = T.MarcaId
	LEFT JOIN @temp D ON D.EstrategiaID = T.EstrategiaID
	ORDER BY
	Orden1 ASC, CASE WHEN ISNULL(T.Orden2,0) = 0 THEN T.Orden1 ELSE T.Orden2 END ASC, EstrategiaID ASC

	DROP TABLE #TEMPORAL

	SET NOCOUNT OFF
END

GO

USE BelcorpPuertoRico
GO

GO
ALTER PROCEDURE [dbo].[ListarEstrategiasPedido_SB2]
	@CampaniaID INT,
	@ConsultoraID VARCHAR(30),
	@CUV VARCHAR(20),
	@ZonaID VARCHAR(20),
	@CodigoAgrupacion VARCHAR(10) = ''
AS
/*
dbo.ListarEstrategiasPedido_SB2 201710,'1107','','2329', '101'
*/
BEGIN
	SET NOCOUNT ON;
	
	--declare @CampaniaID INT = 201710,
	--@ConsultoraID VARCHAR(30) = '1107',
	--@CUV VARCHAR(20) = '',
	--@ZonaID VARCHAR(20) = '2329',
	--@CodigoAgrupacion VARCHAR(10) = '101'
		

	set @CodigoAgrupacion = ISNULL(@CodigoAgrupacion, '')

	-- CrossSelling se implemento a un servicio
	--DECLARE @CuvReco VARCHAR(20)
	--SELECT @CuvReco = CSA.CUV
	--FROM CrossSellingAsociacion CSA
	--INNER JOIN ods.Campania CA ON CSA.CampaniaID = CA.CampaniaID
	--WHERE
	--	CA.Codigo = @CampaniaID
	--	AND (CUVAsociado = @CUV OR CUVAsociado2 = @CUV OR CUV = @CUV)

	--/* RECOMENDACION POR CUV - INICIO */
	--SELECT
	--	EstrategiaID,
	--	CUV2,
	--	DescripcionCUV2,
	--	dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
	--	E.Precio,
	--	dbo.ObtenerDescripcionEtiqueta(EtiquetaID2) EtiquetaDescripcion2,
	--	Precio2,
	--	TextoLibre,
	--	FlagEstrella,
	--	ColorFondo,
	--	e.TipoEstrategiaID,
	--	e.ImagenURL FotoProducto01,
	--	te.ImagenEstrategia ImagenURL,
	--	e.LimiteVenta,
	--	pc.MarcaID,
	--	te.Orden Orden1,
	--	e.Orden Orden2,
	--	pc.IndicadorMontoMinimo,
	--	pc.CodigoProducto,
	--	TE.FlagNueva,
	--	dbo.fn_ObtenerTallaColorCuv_SB2(E.CUV2,@CampaniaID) as TipoTallaColor,
	--	1 as TipoEstrategiaImagenMostrar	--CrossSelling
	--	, E.EtiquetaID		-- SB20-351
	--	, E.EtiquetaID2		-- SB20-351
	--	, E.CodigoEstrategia
	--	, E.TieneVariedad
	--INTO #TEMPORAL
	--FROM Estrategia E
	--INNER JOIN TipoEstrategia TE ON E.TipoEstrategiaID = TE.TipoEstrategiaID
	--INNER JOIN ods.Campania CA ON E.CampaniaID = CA.Codigo
	--INNER JOIN CrossSellingAsociacion CSA ON CSA.CampaniaID = CA.CampaniaID AND (E.CUV2 = CSA.CUVAsociado OR E.CUV2 = CSA.CUVAsociado2 )
	--INNER JOIN ods.ProductoComercial PC ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
	--WHERE
	--	E.Activo = 1
	--	AND TE.flagRecoProduc = 1
	--	AND TE.FlagActivo = 1
	--	AND CSA.CUV IS NOT NULL
	--	AND CA.Codigo = @CampaniaID
	--	AND CSA.CUV = @CuvReco
	--	AND E.Zona LIKE '%' + @ZonaID + '%'
	--ORDER BY
	--	te.Orden ASC,
	--	e.Orden ASC
	--/* RECOMENDACION POR CUV - FIN */

	declare @ConsultoraID2 bigint = CAST(@ConsultoraID as bigint)

	DECLARE @tablaCuvPedido table (CUV varchar(6))
	insert into @tablaCuvPedido
	SELECT CUV
	FROM PedidoWebDetalle with(nolock)
	WHERE CampaniaID=@CampaniaID and ConsultoraID=@ConsultoraID2

	DECLARE @CodigoConsultora VARCHAR(25)
	DECLARE @NumeroPedido INT
	declare @CodigoRegion varchar(2) = null
	declare @CodigoZona varchar(4) = null

	SELECT
		@NumeroPedido = c.ConsecutivoNueva + 1,
		@CodigoConsultora = c.Codigo,
		@CodigoRegion = r.Codigo,
		@CodigoZona = z.Codigo
	FROM ods.Consultora c with(nolock)
		INNER JOIN ods.Region r with(nolock) on r.RegionID = c.RegionID
		INNER JOIN ods.Zona z with(nolock) on z.ZonaID = c.ZonaID
	WHERE 
		c.ConsultoraID = @ConsultoraID2

	CREATE TABLE #TEMPORAL (
		ColId uniqueIdentifier,
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

	-- Obtener estrategias de Pack Nuevas.
	INSERT INTO #TEMPORAL
	SELECT
		newId() AS ColId,
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
		1 AS FlagNueva, -- R2621
		--dbo.fn_ObtenerTallaColorCuv_SB2(E.CUV2,@CampaniaID) as TipoTallaColor,
		'' as TipoTallaColor,
		2 as TipoEstrategiaImagenMostrar	-- Pack Nuevas
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
		AND E.Activo = 1
		AND CPN.Participa = 1
		AND TE.FlagActivo = 1
		AND TE.flagNueva = 1
		AND E.NumeroPedido = @NumeroPedido
		AND E.Zona LIKE '%' + @ZonaID + '%'
		AND E.CUV2 not in(SELECT CUV FROM @tablaCuvPedido)
	--ORDER BY te.Orden ASC, e.Orden ASC

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

	DECLARE @cont1 INT, @cont2 INT, @codConsultoraDefault VARCHAR(9)
	SELECT @cont1 = COUNT(EstrategiaID) FROM #TEMPORAL
	
	INSERT INTO #TEMPORAL
		SELECT
		newId() AS ColId,
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
		--dbo.fn_ObtenerTallaColorCuv_SB2(E.CUV2,@CampaniaID) as TipoTallaColor,
		'' as TipoTallaColor,
		3 as TipoEstrategiaImagenMostrar	--Oferta para Ti
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
		and (
			( @CodigoAgrupacion = '101' and op.TipoPersonalizacion in ('LAN', 'OPM', 'PAD'))
			OR (@CodigoAgrupacion = '' and op.TipoPersonalizacion = 'OPT')
		)
	INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
	--INNER JOIN ods.Consultora c with(nolock) ON op.CodConsultora = c.Codigo
	INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
	INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
	WHERE
		E.Activo = 1
		AND ca.Codigo = @CampaniaID
		--AND c.ConsultoraID = @ConsultoraID2
		--AND E.Zona LIKE '%' + @ZonaID + '%'
		AND TE.FlagActivo = 1
		AND TE.flagRecoPerfil = 1
		AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
	--ORDER BY CASE WHEN ISNULL(op.Orden,0) = 0 THEN te.Orden ELSE op.Orden END ASC

	/*SB20-1080 - INICIO */
	SET @cont2 = (SELECT COUNT(EstrategiaID) FROM #TEMPORAL)

	IF (@cont1 = @cont2)
	BEGIN

		SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001

		INSERT INTO #TEMPORAL
		SELECT
		newId() AS ColId,
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
			--dbo.fn_ObtenerTallaColorCuv_SB2(E.CUV2,@CampaniaID) as TipoTallaColor,
			'' as TipoTallaColor,
			3 as TipoEstrategiaImagenMostrar	--Oferta para Ti
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
			and (
				( @CodigoAgrupacion = '101' and op.TipoPersonalizacion in ('LAN', 'OPM', 'PAD'))
				OR (@CodigoAgrupacion = '' and op.TipoPersonalizacion = 'OPT')
			)
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		--INNER JOIN ods.Consultora c with(nolock) ON op.CodConsultora = c.Codigo
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
		WHERE
			E.Activo = 1
			AND ca.Codigo = @CampaniaID
			--AND c.ConsultoraID = @ConsultoraID2
			--AND E.Zona LIKE '%' + @ZonaID + '%'
			AND TE.FlagActivo = 1
			AND TE.flagRecoPerfil = 1
			AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
		--ORDER BY CASE WHEN ISNULL(op.Orden,0) = 0 THEN te.Orden ELSE op.Orden END ASC
	END

	IF @CodigoAgrupacion = ''
	BEGIN
	--  Oferta Web y Lanzamiento
	INSERT INTO #TEMPORAL
	SELECT
		newId() AS ColId,
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
		--dbo.fn_ObtenerTallaColorCuv_SB2(E.CUV2,@CampaniaID) as TipoTallaColor,
		'' as TipoTallaColor,
		4 as TipoEstrategiaImagenMostrar	--Oferta Web
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
		AND E.Zona LIKE '%' + @ZonaID + '%'
	--ORDER BY te.Orden ASC, e.Orden ASC

	END -- @CodigoAgrupacion = ''

	DECLARE @tablaCuvUnicos table (CUV varchar(6), Id uniqueIdentifier)
	
	insert into @tablaCuvUnicos
	select CUV2, NULL from #TEMPORAL
	group by CUV2 -- having count(CUV2) > 1

	update @tablaCuvUnicos
	set Id = (SELECT TOP 1 B.ColId FROM #TEMPORAL B WHERE  B.CUV2 = CUV)
	FROM @tablaCuvUnicos A

	DELETE B 
	--SELECT *
	FROM #TEMPORAL B
	LEFT JOIN @tablaCuvUnicos A
		ON B.CUV2 = A.CUV AND B.ColId = A.Id
	 WHERE A.CUV IS NULL	

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
	)

	IF @CodigoAgrupacion = '101'
	BEGIN

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
		FROM #TEMPORAL as T
			where T.CODIGO = '005'
		GROUP BY EstrategiaID

	END -- @CodigoAgrupacion = '101'
	
	SELECT
		T.EstrategiaID,
		T.CUV2,
		T.DescripcionCUV2,
		T.EtiquetaDescripcion,
		T.Precio,
		T.EtiquetaDescripcion2,
		T.Precio2,
		isnull(T.TextoLibre,'') as TextoLibre,
		T.FlagEstrella,
		T.ColorFondo,
		T.TipoEstrategiaID,
		T.FotoProducto01,
		T.ImagenURL,
		T.LimiteVenta,
		T.MarcaID,
		T.Orden1,
		T.Orden2,
		T.IndicadorMontoMinimo,
		T.FlagNueva,
		T.TipoTallaColor,
		T.TipoEstrategiaImagenMostrar,
		T.CodigoProducto
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
	FROM #TEMPORAL T
	LEFT JOIN Marca M with(nolock) ON M.MarcaId = T.MarcaId
	LEFT JOIN @temp D ON D.EstrategiaID = T.EstrategiaID
	ORDER BY
	Orden1 ASC, CASE WHEN ISNULL(T.Orden2,0) = 0 THEN T.Orden1 ELSE T.Orden2 END ASC, EstrategiaID ASC

	DROP TABLE #TEMPORAL

	SET NOCOUNT OFF
END

GO

USE BelcorpPanama
GO

GO
ALTER PROCEDURE [dbo].[ListarEstrategiasPedido_SB2]
	@CampaniaID INT,
	@ConsultoraID VARCHAR(30),
	@CUV VARCHAR(20),
	@ZonaID VARCHAR(20),
	@CodigoAgrupacion VARCHAR(10) = ''
AS
/*
dbo.ListarEstrategiasPedido_SB2 201710,'1107','','2329', '101'
*/
BEGIN
	SET NOCOUNT ON;
	
	--declare @CampaniaID INT = 201710,
	--@ConsultoraID VARCHAR(30) = '1107',
	--@CUV VARCHAR(20) = '',
	--@ZonaID VARCHAR(20) = '2329',
	--@CodigoAgrupacion VARCHAR(10) = '101'
		

	set @CodigoAgrupacion = ISNULL(@CodigoAgrupacion, '')

	-- CrossSelling se implemento a un servicio
	--DECLARE @CuvReco VARCHAR(20)
	--SELECT @CuvReco = CSA.CUV
	--FROM CrossSellingAsociacion CSA
	--INNER JOIN ods.Campania CA ON CSA.CampaniaID = CA.CampaniaID
	--WHERE
	--	CA.Codigo = @CampaniaID
	--	AND (CUVAsociado = @CUV OR CUVAsociado2 = @CUV OR CUV = @CUV)

	--/* RECOMENDACION POR CUV - INICIO */
	--SELECT
	--	EstrategiaID,
	--	CUV2,
	--	DescripcionCUV2,
	--	dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
	--	E.Precio,
	--	dbo.ObtenerDescripcionEtiqueta(EtiquetaID2) EtiquetaDescripcion2,
	--	Precio2,
	--	TextoLibre,
	--	FlagEstrella,
	--	ColorFondo,
	--	e.TipoEstrategiaID,
	--	e.ImagenURL FotoProducto01,
	--	te.ImagenEstrategia ImagenURL,
	--	e.LimiteVenta,
	--	pc.MarcaID,
	--	te.Orden Orden1,
	--	e.Orden Orden2,
	--	pc.IndicadorMontoMinimo,
	--	pc.CodigoProducto,
	--	TE.FlagNueva,
	--	dbo.fn_ObtenerTallaColorCuv_SB2(E.CUV2,@CampaniaID) as TipoTallaColor,
	--	1 as TipoEstrategiaImagenMostrar	--CrossSelling
	--	, E.EtiquetaID		-- SB20-351
	--	, E.EtiquetaID2		-- SB20-351
	--	, E.CodigoEstrategia
	--	, E.TieneVariedad
	--INTO #TEMPORAL
	--FROM Estrategia E
	--INNER JOIN TipoEstrategia TE ON E.TipoEstrategiaID = TE.TipoEstrategiaID
	--INNER JOIN ods.Campania CA ON E.CampaniaID = CA.Codigo
	--INNER JOIN CrossSellingAsociacion CSA ON CSA.CampaniaID = CA.CampaniaID AND (E.CUV2 = CSA.CUVAsociado OR E.CUV2 = CSA.CUVAsociado2 )
	--INNER JOIN ods.ProductoComercial PC ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
	--WHERE
	--	E.Activo = 1
	--	AND TE.flagRecoProduc = 1
	--	AND TE.FlagActivo = 1
	--	AND CSA.CUV IS NOT NULL
	--	AND CA.Codigo = @CampaniaID
	--	AND CSA.CUV = @CuvReco
	--	AND E.Zona LIKE '%' + @ZonaID + '%'
	--ORDER BY
	--	te.Orden ASC,
	--	e.Orden ASC
	--/* RECOMENDACION POR CUV - FIN */

	declare @ConsultoraID2 bigint = CAST(@ConsultoraID as bigint)

	DECLARE @tablaCuvPedido table (CUV varchar(6))
	insert into @tablaCuvPedido
	SELECT CUV
	FROM PedidoWebDetalle with(nolock)
	WHERE CampaniaID=@CampaniaID and ConsultoraID=@ConsultoraID2

	DECLARE @CodigoConsultora VARCHAR(25)
	DECLARE @NumeroPedido INT
	declare @CodigoRegion varchar(2) = null
	declare @CodigoZona varchar(4) = null

	SELECT
		@NumeroPedido = c.ConsecutivoNueva + 1,
		@CodigoConsultora = c.Codigo,
		@CodigoRegion = r.Codigo,
		@CodigoZona = z.Codigo
	FROM ods.Consultora c with(nolock)
		INNER JOIN ods.Region r with(nolock) on r.RegionID = c.RegionID
		INNER JOIN ods.Zona z with(nolock) on z.ZonaID = c.ZonaID
	WHERE 
		c.ConsultoraID = @ConsultoraID2

	CREATE TABLE #TEMPORAL (
		ColId uniqueIdentifier,
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

	-- Obtener estrategias de Pack Nuevas.
	INSERT INTO #TEMPORAL
	SELECT
		newId() AS ColId,
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
		1 AS FlagNueva, -- R2621
		--dbo.fn_ObtenerTallaColorCuv_SB2(E.CUV2,@CampaniaID) as TipoTallaColor,
		'' as TipoTallaColor,
		2 as TipoEstrategiaImagenMostrar	-- Pack Nuevas
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
		AND E.Activo = 1
		AND CPN.Participa = 1
		AND TE.FlagActivo = 1
		AND TE.flagNueva = 1
		AND E.NumeroPedido = @NumeroPedido
		AND E.Zona LIKE '%' + @ZonaID + '%'
		AND E.CUV2 not in(SELECT CUV FROM @tablaCuvPedido)
	--ORDER BY te.Orden ASC, e.Orden ASC

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

	DECLARE @cont1 INT, @cont2 INT, @codConsultoraDefault VARCHAR(9)
	SELECT @cont1 = COUNT(EstrategiaID) FROM #TEMPORAL
	
	INSERT INTO #TEMPORAL
		SELECT
		newId() AS ColId,
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
		--dbo.fn_ObtenerTallaColorCuv_SB2(E.CUV2,@CampaniaID) as TipoTallaColor,
		'' as TipoTallaColor,
		3 as TipoEstrategiaImagenMostrar	--Oferta para Ti
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
		and (
			( @CodigoAgrupacion = '101' and op.TipoPersonalizacion in ('LAN', 'OPM', 'PAD'))
			OR (@CodigoAgrupacion = '' and op.TipoPersonalizacion = 'OPT')
		)
	INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
	--INNER JOIN ods.Consultora c with(nolock) ON op.CodConsultora = c.Codigo
	INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
	INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
	WHERE
		E.Activo = 1
		AND ca.Codigo = @CampaniaID
		--AND c.ConsultoraID = @ConsultoraID2
		--AND E.Zona LIKE '%' + @ZonaID + '%'
		AND TE.FlagActivo = 1
		AND TE.flagRecoPerfil = 1
		AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
	--ORDER BY CASE WHEN ISNULL(op.Orden,0) = 0 THEN te.Orden ELSE op.Orden END ASC

	/*SB20-1080 - INICIO */
	SET @cont2 = (SELECT COUNT(EstrategiaID) FROM #TEMPORAL)

	IF (@cont1 = @cont2)
	BEGIN

		SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001

		INSERT INTO #TEMPORAL
		SELECT
		newId() AS ColId,
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
			--dbo.fn_ObtenerTallaColorCuv_SB2(E.CUV2,@CampaniaID) as TipoTallaColor,
			'' as TipoTallaColor,
			3 as TipoEstrategiaImagenMostrar	--Oferta para Ti
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
			and (
				( @CodigoAgrupacion = '101' and op.TipoPersonalizacion in ('LAN', 'OPM', 'PAD'))
				OR (@CodigoAgrupacion = '' and op.TipoPersonalizacion = 'OPT')
			)
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		--INNER JOIN ods.Consultora c with(nolock) ON op.CodConsultora = c.Codigo
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
		WHERE
			E.Activo = 1
			AND ca.Codigo = @CampaniaID
			--AND c.ConsultoraID = @ConsultoraID2
			--AND E.Zona LIKE '%' + @ZonaID + '%'
			AND TE.FlagActivo = 1
			AND TE.flagRecoPerfil = 1
			AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
		--ORDER BY CASE WHEN ISNULL(op.Orden,0) = 0 THEN te.Orden ELSE op.Orden END ASC
	END

	IF @CodigoAgrupacion = ''
	BEGIN
	--  Oferta Web y Lanzamiento
	INSERT INTO #TEMPORAL
	SELECT
		newId() AS ColId,
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
		--dbo.fn_ObtenerTallaColorCuv_SB2(E.CUV2,@CampaniaID) as TipoTallaColor,
		'' as TipoTallaColor,
		4 as TipoEstrategiaImagenMostrar	--Oferta Web
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
		AND E.Zona LIKE '%' + @ZonaID + '%'
	--ORDER BY te.Orden ASC, e.Orden ASC

	END -- @CodigoAgrupacion = ''

	DECLARE @tablaCuvUnicos table (CUV varchar(6), Id uniqueIdentifier)
	
	insert into @tablaCuvUnicos
	select CUV2, NULL from #TEMPORAL
	group by CUV2 -- having count(CUV2) > 1

	update @tablaCuvUnicos
	set Id = (SELECT TOP 1 B.ColId FROM #TEMPORAL B WHERE  B.CUV2 = CUV)
	FROM @tablaCuvUnicos A

	DELETE B 
	--SELECT *
	FROM #TEMPORAL B
	LEFT JOIN @tablaCuvUnicos A
		ON B.CUV2 = A.CUV AND B.ColId = A.Id
	 WHERE A.CUV IS NULL	

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
	)

	IF @CodigoAgrupacion = '101'
	BEGIN

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
		FROM #TEMPORAL as T
			where T.CODIGO = '005'
		GROUP BY EstrategiaID

	END -- @CodigoAgrupacion = '101'
	
	SELECT
		T.EstrategiaID,
		T.CUV2,
		T.DescripcionCUV2,
		T.EtiquetaDescripcion,
		T.Precio,
		T.EtiquetaDescripcion2,
		T.Precio2,
		isnull(T.TextoLibre,'') as TextoLibre,
		T.FlagEstrella,
		T.ColorFondo,
		T.TipoEstrategiaID,
		T.FotoProducto01,
		T.ImagenURL,
		T.LimiteVenta,
		T.MarcaID,
		T.Orden1,
		T.Orden2,
		T.IndicadorMontoMinimo,
		T.FlagNueva,
		T.TipoTallaColor,
		T.TipoEstrategiaImagenMostrar,
		T.CodigoProducto
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
	FROM #TEMPORAL T
	LEFT JOIN Marca M with(nolock) ON M.MarcaId = T.MarcaId
	LEFT JOIN @temp D ON D.EstrategiaID = T.EstrategiaID
	ORDER BY
	Orden1 ASC, CASE WHEN ISNULL(T.Orden2,0) = 0 THEN T.Orden1 ELSE T.Orden2 END ASC, EstrategiaID ASC

	DROP TABLE #TEMPORAL

	SET NOCOUNT OFF
END

GO

USE BelcorpGuatemala
GO

GO
ALTER PROCEDURE [dbo].[ListarEstrategiasPedido_SB2]
	@CampaniaID INT,
	@ConsultoraID VARCHAR(30),
	@CUV VARCHAR(20),
	@ZonaID VARCHAR(20),
	@CodigoAgrupacion VARCHAR(10) = ''
AS
/*
dbo.ListarEstrategiasPedido_SB2 201710,'1107','','2329', '101'
*/
BEGIN
	SET NOCOUNT ON;
	
	--declare @CampaniaID INT = 201710,
	--@ConsultoraID VARCHAR(30) = '1107',
	--@CUV VARCHAR(20) = '',
	--@ZonaID VARCHAR(20) = '2329',
	--@CodigoAgrupacion VARCHAR(10) = '101'
		

	set @CodigoAgrupacion = ISNULL(@CodigoAgrupacion, '')

	-- CrossSelling se implemento a un servicio
	--DECLARE @CuvReco VARCHAR(20)
	--SELECT @CuvReco = CSA.CUV
	--FROM CrossSellingAsociacion CSA
	--INNER JOIN ods.Campania CA ON CSA.CampaniaID = CA.CampaniaID
	--WHERE
	--	CA.Codigo = @CampaniaID
	--	AND (CUVAsociado = @CUV OR CUVAsociado2 = @CUV OR CUV = @CUV)

	--/* RECOMENDACION POR CUV - INICIO */
	--SELECT
	--	EstrategiaID,
	--	CUV2,
	--	DescripcionCUV2,
	--	dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
	--	E.Precio,
	--	dbo.ObtenerDescripcionEtiqueta(EtiquetaID2) EtiquetaDescripcion2,
	--	Precio2,
	--	TextoLibre,
	--	FlagEstrella,
	--	ColorFondo,
	--	e.TipoEstrategiaID,
	--	e.ImagenURL FotoProducto01,
	--	te.ImagenEstrategia ImagenURL,
	--	e.LimiteVenta,
	--	pc.MarcaID,
	--	te.Orden Orden1,
	--	e.Orden Orden2,
	--	pc.IndicadorMontoMinimo,
	--	pc.CodigoProducto,
	--	TE.FlagNueva,
	--	dbo.fn_ObtenerTallaColorCuv_SB2(E.CUV2,@CampaniaID) as TipoTallaColor,
	--	1 as TipoEstrategiaImagenMostrar	--CrossSelling
	--	, E.EtiquetaID		-- SB20-351
	--	, E.EtiquetaID2		-- SB20-351
	--	, E.CodigoEstrategia
	--	, E.TieneVariedad
	--INTO #TEMPORAL
	--FROM Estrategia E
	--INNER JOIN TipoEstrategia TE ON E.TipoEstrategiaID = TE.TipoEstrategiaID
	--INNER JOIN ods.Campania CA ON E.CampaniaID = CA.Codigo
	--INNER JOIN CrossSellingAsociacion CSA ON CSA.CampaniaID = CA.CampaniaID AND (E.CUV2 = CSA.CUVAsociado OR E.CUV2 = CSA.CUVAsociado2 )
	--INNER JOIN ods.ProductoComercial PC ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
	--WHERE
	--	E.Activo = 1
	--	AND TE.flagRecoProduc = 1
	--	AND TE.FlagActivo = 1
	--	AND CSA.CUV IS NOT NULL
	--	AND CA.Codigo = @CampaniaID
	--	AND CSA.CUV = @CuvReco
	--	AND E.Zona LIKE '%' + @ZonaID + '%'
	--ORDER BY
	--	te.Orden ASC,
	--	e.Orden ASC
	--/* RECOMENDACION POR CUV - FIN */

	declare @ConsultoraID2 bigint = CAST(@ConsultoraID as bigint)

	DECLARE @tablaCuvPedido table (CUV varchar(6))
	insert into @tablaCuvPedido
	SELECT CUV
	FROM PedidoWebDetalle with(nolock)
	WHERE CampaniaID=@CampaniaID and ConsultoraID=@ConsultoraID2

	DECLARE @CodigoConsultora VARCHAR(25)
	DECLARE @NumeroPedido INT
	declare @CodigoRegion varchar(2) = null
	declare @CodigoZona varchar(4) = null

	SELECT
		@NumeroPedido = c.ConsecutivoNueva + 1,
		@CodigoConsultora = c.Codigo,
		@CodigoRegion = r.Codigo,
		@CodigoZona = z.Codigo
	FROM ods.Consultora c with(nolock)
		INNER JOIN ods.Region r with(nolock) on r.RegionID = c.RegionID
		INNER JOIN ods.Zona z with(nolock) on z.ZonaID = c.ZonaID
	WHERE 
		c.ConsultoraID = @ConsultoraID2

	CREATE TABLE #TEMPORAL (
		ColId uniqueIdentifier,
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

	-- Obtener estrategias de Pack Nuevas.
	INSERT INTO #TEMPORAL
	SELECT
		newId() AS ColId,
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
		1 AS FlagNueva, -- R2621
		--dbo.fn_ObtenerTallaColorCuv_SB2(E.CUV2,@CampaniaID) as TipoTallaColor,
		'' as TipoTallaColor,
		2 as TipoEstrategiaImagenMostrar	-- Pack Nuevas
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
		AND E.Activo = 1
		AND CPN.Participa = 1
		AND TE.FlagActivo = 1
		AND TE.flagNueva = 1
		AND E.NumeroPedido = @NumeroPedido
		AND E.Zona LIKE '%' + @ZonaID + '%'
		AND E.CUV2 not in(SELECT CUV FROM @tablaCuvPedido)
	--ORDER BY te.Orden ASC, e.Orden ASC

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

	DECLARE @cont1 INT, @cont2 INT, @codConsultoraDefault VARCHAR(9)
	SELECT @cont1 = COUNT(EstrategiaID) FROM #TEMPORAL
	
	INSERT INTO #TEMPORAL
		SELECT
		newId() AS ColId,
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
		--dbo.fn_ObtenerTallaColorCuv_SB2(E.CUV2,@CampaniaID) as TipoTallaColor,
		'' as TipoTallaColor,
		3 as TipoEstrategiaImagenMostrar	--Oferta para Ti
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
		and (
			( @CodigoAgrupacion = '101' and op.TipoPersonalizacion in ('LAN', 'OPM', 'PAD'))
			OR (@CodigoAgrupacion = '' and op.TipoPersonalizacion = 'OPT')
		)
	INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
	--INNER JOIN ods.Consultora c with(nolock) ON op.CodConsultora = c.Codigo
	INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
	INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
	WHERE
		E.Activo = 1
		AND ca.Codigo = @CampaniaID
		--AND c.ConsultoraID = @ConsultoraID2
		--AND E.Zona LIKE '%' + @ZonaID + '%'
		AND TE.FlagActivo = 1
		AND TE.flagRecoPerfil = 1
		AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
	--ORDER BY CASE WHEN ISNULL(op.Orden,0) = 0 THEN te.Orden ELSE op.Orden END ASC

	/*SB20-1080 - INICIO */
	SET @cont2 = (SELECT COUNT(EstrategiaID) FROM #TEMPORAL)

	IF (@cont1 = @cont2)
	BEGIN

		SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001

		INSERT INTO #TEMPORAL
		SELECT
		newId() AS ColId,
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
			--dbo.fn_ObtenerTallaColorCuv_SB2(E.CUV2,@CampaniaID) as TipoTallaColor,
			'' as TipoTallaColor,
			3 as TipoEstrategiaImagenMostrar	--Oferta para Ti
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
			and (
				( @CodigoAgrupacion = '101' and op.TipoPersonalizacion in ('LAN', 'OPM', 'PAD'))
				OR (@CodigoAgrupacion = '' and op.TipoPersonalizacion = 'OPT')
			)
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		--INNER JOIN ods.Consultora c with(nolock) ON op.CodConsultora = c.Codigo
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
		WHERE
			E.Activo = 1
			AND ca.Codigo = @CampaniaID
			--AND c.ConsultoraID = @ConsultoraID2
			--AND E.Zona LIKE '%' + @ZonaID + '%'
			AND TE.FlagActivo = 1
			AND TE.flagRecoPerfil = 1
			AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
		--ORDER BY CASE WHEN ISNULL(op.Orden,0) = 0 THEN te.Orden ELSE op.Orden END ASC
	END

	IF @CodigoAgrupacion = ''
	BEGIN
	--  Oferta Web y Lanzamiento
	INSERT INTO #TEMPORAL
	SELECT
		newId() AS ColId,
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
		--dbo.fn_ObtenerTallaColorCuv_SB2(E.CUV2,@CampaniaID) as TipoTallaColor,
		'' as TipoTallaColor,
		4 as TipoEstrategiaImagenMostrar	--Oferta Web
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
		AND E.Zona LIKE '%' + @ZonaID + '%'
	--ORDER BY te.Orden ASC, e.Orden ASC

	END -- @CodigoAgrupacion = ''

	DECLARE @tablaCuvUnicos table (CUV varchar(6), Id uniqueIdentifier)
	
	insert into @tablaCuvUnicos
	select CUV2, NULL from #TEMPORAL
	group by CUV2 -- having count(CUV2) > 1

	update @tablaCuvUnicos
	set Id = (SELECT TOP 1 B.ColId FROM #TEMPORAL B WHERE  B.CUV2 = CUV)
	FROM @tablaCuvUnicos A

	DELETE B 
	--SELECT *
	FROM #TEMPORAL B
	LEFT JOIN @tablaCuvUnicos A
		ON B.CUV2 = A.CUV AND B.ColId = A.Id
	 WHERE A.CUV IS NULL	

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
	)

	IF @CodigoAgrupacion = '101'
	BEGIN

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
		FROM #TEMPORAL as T
			where T.CODIGO = '005'
		GROUP BY EstrategiaID

	END -- @CodigoAgrupacion = '101'
	
	SELECT
		T.EstrategiaID,
		T.CUV2,
		T.DescripcionCUV2,
		T.EtiquetaDescripcion,
		T.Precio,
		T.EtiquetaDescripcion2,
		T.Precio2,
		isnull(T.TextoLibre,'') as TextoLibre,
		T.FlagEstrella,
		T.ColorFondo,
		T.TipoEstrategiaID,
		T.FotoProducto01,
		T.ImagenURL,
		T.LimiteVenta,
		T.MarcaID,
		T.Orden1,
		T.Orden2,
		T.IndicadorMontoMinimo,
		T.FlagNueva,
		T.TipoTallaColor,
		T.TipoEstrategiaImagenMostrar,
		T.CodigoProducto
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
	FROM #TEMPORAL T
	LEFT JOIN Marca M with(nolock) ON M.MarcaId = T.MarcaId
	LEFT JOIN @temp D ON D.EstrategiaID = T.EstrategiaID
	ORDER BY
	Orden1 ASC, CASE WHEN ISNULL(T.Orden2,0) = 0 THEN T.Orden1 ELSE T.Orden2 END ASC, EstrategiaID ASC

	DROP TABLE #TEMPORAL

	SET NOCOUNT OFF
END

GO

USE BelcorpEcuador
GO

GO
ALTER PROCEDURE [dbo].[ListarEstrategiasPedido_SB2]
	@CampaniaID INT,
	@ConsultoraID VARCHAR(30),
	@CUV VARCHAR(20),
	@ZonaID VARCHAR(20),
	@CodigoAgrupacion VARCHAR(10) = ''
AS
/*
dbo.ListarEstrategiasPedido_SB2 201710,'1107','','2329', '101'
*/
BEGIN
	SET NOCOUNT ON;
	
	--declare @CampaniaID INT = 201710,
	--@ConsultoraID VARCHAR(30) = '1107',
	--@CUV VARCHAR(20) = '',
	--@ZonaID VARCHAR(20) = '2329',
	--@CodigoAgrupacion VARCHAR(10) = '101'
		

	set @CodigoAgrupacion = ISNULL(@CodigoAgrupacion, '')

	-- CrossSelling se implemento a un servicio
	--DECLARE @CuvReco VARCHAR(20)
	--SELECT @CuvReco = CSA.CUV
	--FROM CrossSellingAsociacion CSA
	--INNER JOIN ods.Campania CA ON CSA.CampaniaID = CA.CampaniaID
	--WHERE
	--	CA.Codigo = @CampaniaID
	--	AND (CUVAsociado = @CUV OR CUVAsociado2 = @CUV OR CUV = @CUV)

	--/* RECOMENDACION POR CUV - INICIO */
	--SELECT
	--	EstrategiaID,
	--	CUV2,
	--	DescripcionCUV2,
	--	dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
	--	E.Precio,
	--	dbo.ObtenerDescripcionEtiqueta(EtiquetaID2) EtiquetaDescripcion2,
	--	Precio2,
	--	TextoLibre,
	--	FlagEstrella,
	--	ColorFondo,
	--	e.TipoEstrategiaID,
	--	e.ImagenURL FotoProducto01,
	--	te.ImagenEstrategia ImagenURL,
	--	e.LimiteVenta,
	--	pc.MarcaID,
	--	te.Orden Orden1,
	--	e.Orden Orden2,
	--	pc.IndicadorMontoMinimo,
	--	pc.CodigoProducto,
	--	TE.FlagNueva,
	--	dbo.fn_ObtenerTallaColorCuv_SB2(E.CUV2,@CampaniaID) as TipoTallaColor,
	--	1 as TipoEstrategiaImagenMostrar	--CrossSelling
	--	, E.EtiquetaID		-- SB20-351
	--	, E.EtiquetaID2		-- SB20-351
	--	, E.CodigoEstrategia
	--	, E.TieneVariedad
	--INTO #TEMPORAL
	--FROM Estrategia E
	--INNER JOIN TipoEstrategia TE ON E.TipoEstrategiaID = TE.TipoEstrategiaID
	--INNER JOIN ods.Campania CA ON E.CampaniaID = CA.Codigo
	--INNER JOIN CrossSellingAsociacion CSA ON CSA.CampaniaID = CA.CampaniaID AND (E.CUV2 = CSA.CUVAsociado OR E.CUV2 = CSA.CUVAsociado2 )
	--INNER JOIN ods.ProductoComercial PC ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
	--WHERE
	--	E.Activo = 1
	--	AND TE.flagRecoProduc = 1
	--	AND TE.FlagActivo = 1
	--	AND CSA.CUV IS NOT NULL
	--	AND CA.Codigo = @CampaniaID
	--	AND CSA.CUV = @CuvReco
	--	AND E.Zona LIKE '%' + @ZonaID + '%'
	--ORDER BY
	--	te.Orden ASC,
	--	e.Orden ASC
	--/* RECOMENDACION POR CUV - FIN */

	declare @ConsultoraID2 bigint = CAST(@ConsultoraID as bigint)

	DECLARE @tablaCuvPedido table (CUV varchar(6))
	insert into @tablaCuvPedido
	SELECT CUV
	FROM PedidoWebDetalle with(nolock)
	WHERE CampaniaID=@CampaniaID and ConsultoraID=@ConsultoraID2

	DECLARE @CodigoConsultora VARCHAR(25)
	DECLARE @NumeroPedido INT
	declare @CodigoRegion varchar(2) = null
	declare @CodigoZona varchar(4) = null

	SELECT
		@NumeroPedido = c.ConsecutivoNueva + 1,
		@CodigoConsultora = c.Codigo,
		@CodigoRegion = r.Codigo,
		@CodigoZona = z.Codigo
	FROM ods.Consultora c with(nolock)
		INNER JOIN ods.Region r with(nolock) on r.RegionID = c.RegionID
		INNER JOIN ods.Zona z with(nolock) on z.ZonaID = c.ZonaID
	WHERE 
		c.ConsultoraID = @ConsultoraID2

	CREATE TABLE #TEMPORAL (
		ColId uniqueIdentifier,
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

	-- Obtener estrategias de Pack Nuevas.
	INSERT INTO #TEMPORAL
	SELECT
		newId() AS ColId,
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
		1 AS FlagNueva, -- R2621
		--dbo.fn_ObtenerTallaColorCuv_SB2(E.CUV2,@CampaniaID) as TipoTallaColor,
		'' as TipoTallaColor,
		2 as TipoEstrategiaImagenMostrar	-- Pack Nuevas
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
		AND E.Activo = 1
		AND CPN.Participa = 1
		AND TE.FlagActivo = 1
		AND TE.flagNueva = 1
		AND E.NumeroPedido = @NumeroPedido
		AND E.Zona LIKE '%' + @ZonaID + '%'
		AND E.CUV2 not in(SELECT CUV FROM @tablaCuvPedido)
	--ORDER BY te.Orden ASC, e.Orden ASC

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

	DECLARE @cont1 INT, @cont2 INT, @codConsultoraDefault VARCHAR(9)
	SELECT @cont1 = COUNT(EstrategiaID) FROM #TEMPORAL
	
	INSERT INTO #TEMPORAL
		SELECT
		newId() AS ColId,
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
		--dbo.fn_ObtenerTallaColorCuv_SB2(E.CUV2,@CampaniaID) as TipoTallaColor,
		'' as TipoTallaColor,
		3 as TipoEstrategiaImagenMostrar	--Oferta para Ti
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
		and (
			( @CodigoAgrupacion = '101' and op.TipoPersonalizacion in ('LAN', 'OPM', 'PAD'))
			OR (@CodigoAgrupacion = '' and op.TipoPersonalizacion = 'OPT')
		)
	INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
	--INNER JOIN ods.Consultora c with(nolock) ON op.CodConsultora = c.Codigo
	INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
	INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
	WHERE
		E.Activo = 1
		AND ca.Codigo = @CampaniaID
		--AND c.ConsultoraID = @ConsultoraID2
		--AND E.Zona LIKE '%' + @ZonaID + '%'
		AND TE.FlagActivo = 1
		AND TE.flagRecoPerfil = 1
		AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
	--ORDER BY CASE WHEN ISNULL(op.Orden,0) = 0 THEN te.Orden ELSE op.Orden END ASC

	/*SB20-1080 - INICIO */
	SET @cont2 = (SELECT COUNT(EstrategiaID) FROM #TEMPORAL)

	IF (@cont1 = @cont2)
	BEGIN

		SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001

		INSERT INTO #TEMPORAL
		SELECT
		newId() AS ColId,
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
			--dbo.fn_ObtenerTallaColorCuv_SB2(E.CUV2,@CampaniaID) as TipoTallaColor,
			'' as TipoTallaColor,
			3 as TipoEstrategiaImagenMostrar	--Oferta para Ti
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
			and (
				( @CodigoAgrupacion = '101' and op.TipoPersonalizacion in ('LAN', 'OPM', 'PAD'))
				OR (@CodigoAgrupacion = '' and op.TipoPersonalizacion = 'OPT')
			)
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		--INNER JOIN ods.Consultora c with(nolock) ON op.CodConsultora = c.Codigo
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
		WHERE
			E.Activo = 1
			AND ca.Codigo = @CampaniaID
			--AND c.ConsultoraID = @ConsultoraID2
			--AND E.Zona LIKE '%' + @ZonaID + '%'
			AND TE.FlagActivo = 1
			AND TE.flagRecoPerfil = 1
			AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
		--ORDER BY CASE WHEN ISNULL(op.Orden,0) = 0 THEN te.Orden ELSE op.Orden END ASC
	END

	IF @CodigoAgrupacion = ''
	BEGIN
	--  Oferta Web y Lanzamiento
	INSERT INTO #TEMPORAL
	SELECT
		newId() AS ColId,
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
		--dbo.fn_ObtenerTallaColorCuv_SB2(E.CUV2,@CampaniaID) as TipoTallaColor,
		'' as TipoTallaColor,
		4 as TipoEstrategiaImagenMostrar	--Oferta Web
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
		AND E.Zona LIKE '%' + @ZonaID + '%'
	--ORDER BY te.Orden ASC, e.Orden ASC

	END -- @CodigoAgrupacion = ''

	DECLARE @tablaCuvUnicos table (CUV varchar(6), Id uniqueIdentifier)
	
	insert into @tablaCuvUnicos
	select CUV2, NULL from #TEMPORAL
	group by CUV2 -- having count(CUV2) > 1

	update @tablaCuvUnicos
	set Id = (SELECT TOP 1 B.ColId FROM #TEMPORAL B WHERE  B.CUV2 = CUV)
	FROM @tablaCuvUnicos A

	DELETE B 
	--SELECT *
	FROM #TEMPORAL B
	LEFT JOIN @tablaCuvUnicos A
		ON B.CUV2 = A.CUV AND B.ColId = A.Id
	 WHERE A.CUV IS NULL	

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
	)

	IF @CodigoAgrupacion = '101'
	BEGIN

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
		FROM #TEMPORAL as T
			where T.CODIGO = '005'
		GROUP BY EstrategiaID

	END -- @CodigoAgrupacion = '101'
	
	SELECT
		T.EstrategiaID,
		T.CUV2,
		T.DescripcionCUV2,
		T.EtiquetaDescripcion,
		T.Precio,
		T.EtiquetaDescripcion2,
		T.Precio2,
		isnull(T.TextoLibre,'') as TextoLibre,
		T.FlagEstrella,
		T.ColorFondo,
		T.TipoEstrategiaID,
		T.FotoProducto01,
		T.ImagenURL,
		T.LimiteVenta,
		T.MarcaID,
		T.Orden1,
		T.Orden2,
		T.IndicadorMontoMinimo,
		T.FlagNueva,
		T.TipoTallaColor,
		T.TipoEstrategiaImagenMostrar,
		T.CodigoProducto
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
	FROM #TEMPORAL T
	LEFT JOIN Marca M with(nolock) ON M.MarcaId = T.MarcaId
	LEFT JOIN @temp D ON D.EstrategiaID = T.EstrategiaID
	ORDER BY
	Orden1 ASC, CASE WHEN ISNULL(T.Orden2,0) = 0 THEN T.Orden1 ELSE T.Orden2 END ASC, EstrategiaID ASC

	DROP TABLE #TEMPORAL

	SET NOCOUNT OFF
END

GO

USE BelcorpDominicana
GO

GO
ALTER PROCEDURE [dbo].[ListarEstrategiasPedido_SB2]
	@CampaniaID INT,
	@ConsultoraID VARCHAR(30),
	@CUV VARCHAR(20),
	@ZonaID VARCHAR(20),
	@CodigoAgrupacion VARCHAR(10) = ''
AS
/*
dbo.ListarEstrategiasPedido_SB2 201710,'1107','','2329', '101'
*/
BEGIN
	SET NOCOUNT ON;
	
	--declare @CampaniaID INT = 201710,
	--@ConsultoraID VARCHAR(30) = '1107',
	--@CUV VARCHAR(20) = '',
	--@ZonaID VARCHAR(20) = '2329',
	--@CodigoAgrupacion VARCHAR(10) = '101'
		

	set @CodigoAgrupacion = ISNULL(@CodigoAgrupacion, '')

	-- CrossSelling se implemento a un servicio
	--DECLARE @CuvReco VARCHAR(20)
	--SELECT @CuvReco = CSA.CUV
	--FROM CrossSellingAsociacion CSA
	--INNER JOIN ods.Campania CA ON CSA.CampaniaID = CA.CampaniaID
	--WHERE
	--	CA.Codigo = @CampaniaID
	--	AND (CUVAsociado = @CUV OR CUVAsociado2 = @CUV OR CUV = @CUV)

	--/* RECOMENDACION POR CUV - INICIO */
	--SELECT
	--	EstrategiaID,
	--	CUV2,
	--	DescripcionCUV2,
	--	dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
	--	E.Precio,
	--	dbo.ObtenerDescripcionEtiqueta(EtiquetaID2) EtiquetaDescripcion2,
	--	Precio2,
	--	TextoLibre,
	--	FlagEstrella,
	--	ColorFondo,
	--	e.TipoEstrategiaID,
	--	e.ImagenURL FotoProducto01,
	--	te.ImagenEstrategia ImagenURL,
	--	e.LimiteVenta,
	--	pc.MarcaID,
	--	te.Orden Orden1,
	--	e.Orden Orden2,
	--	pc.IndicadorMontoMinimo,
	--	pc.CodigoProducto,
	--	TE.FlagNueva,
	--	dbo.fn_ObtenerTallaColorCuv_SB2(E.CUV2,@CampaniaID) as TipoTallaColor,
	--	1 as TipoEstrategiaImagenMostrar	--CrossSelling
	--	, E.EtiquetaID		-- SB20-351
	--	, E.EtiquetaID2		-- SB20-351
	--	, E.CodigoEstrategia
	--	, E.TieneVariedad
	--INTO #TEMPORAL
	--FROM Estrategia E
	--INNER JOIN TipoEstrategia TE ON E.TipoEstrategiaID = TE.TipoEstrategiaID
	--INNER JOIN ods.Campania CA ON E.CampaniaID = CA.Codigo
	--INNER JOIN CrossSellingAsociacion CSA ON CSA.CampaniaID = CA.CampaniaID AND (E.CUV2 = CSA.CUVAsociado OR E.CUV2 = CSA.CUVAsociado2 )
	--INNER JOIN ods.ProductoComercial PC ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
	--WHERE
	--	E.Activo = 1
	--	AND TE.flagRecoProduc = 1
	--	AND TE.FlagActivo = 1
	--	AND CSA.CUV IS NOT NULL
	--	AND CA.Codigo = @CampaniaID
	--	AND CSA.CUV = @CuvReco
	--	AND E.Zona LIKE '%' + @ZonaID + '%'
	--ORDER BY
	--	te.Orden ASC,
	--	e.Orden ASC
	--/* RECOMENDACION POR CUV - FIN */

	declare @ConsultoraID2 bigint = CAST(@ConsultoraID as bigint)

	DECLARE @tablaCuvPedido table (CUV varchar(6))
	insert into @tablaCuvPedido
	SELECT CUV
	FROM PedidoWebDetalle with(nolock)
	WHERE CampaniaID=@CampaniaID and ConsultoraID=@ConsultoraID2

	DECLARE @CodigoConsultora VARCHAR(25)
	DECLARE @NumeroPedido INT
	declare @CodigoRegion varchar(2) = null
	declare @CodigoZona varchar(4) = null

	SELECT
		@NumeroPedido = c.ConsecutivoNueva + 1,
		@CodigoConsultora = c.Codigo,
		@CodigoRegion = r.Codigo,
		@CodigoZona = z.Codigo
	FROM ods.Consultora c with(nolock)
		INNER JOIN ods.Region r with(nolock) on r.RegionID = c.RegionID
		INNER JOIN ods.Zona z with(nolock) on z.ZonaID = c.ZonaID
	WHERE 
		c.ConsultoraID = @ConsultoraID2

	CREATE TABLE #TEMPORAL (
		ColId uniqueIdentifier,
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

	-- Obtener estrategias de Pack Nuevas.
	INSERT INTO #TEMPORAL
	SELECT
		newId() AS ColId,
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
		1 AS FlagNueva, -- R2621
		--dbo.fn_ObtenerTallaColorCuv_SB2(E.CUV2,@CampaniaID) as TipoTallaColor,
		'' as TipoTallaColor,
		2 as TipoEstrategiaImagenMostrar	-- Pack Nuevas
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
		AND E.Activo = 1
		AND CPN.Participa = 1
		AND TE.FlagActivo = 1
		AND TE.flagNueva = 1
		AND E.NumeroPedido = @NumeroPedido
		AND E.Zona LIKE '%' + @ZonaID + '%'
		AND E.CUV2 not in(SELECT CUV FROM @tablaCuvPedido)
	--ORDER BY te.Orden ASC, e.Orden ASC

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

	DECLARE @cont1 INT, @cont2 INT, @codConsultoraDefault VARCHAR(9)
	SELECT @cont1 = COUNT(EstrategiaID) FROM #TEMPORAL
	
	INSERT INTO #TEMPORAL
		SELECT
		newId() AS ColId,
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
		--dbo.fn_ObtenerTallaColorCuv_SB2(E.CUV2,@CampaniaID) as TipoTallaColor,
		'' as TipoTallaColor,
		3 as TipoEstrategiaImagenMostrar	--Oferta para Ti
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
		and (
			( @CodigoAgrupacion = '101' and op.TipoPersonalizacion in ('LAN', 'OPM', 'PAD'))
			OR (@CodigoAgrupacion = '' and op.TipoPersonalizacion = 'OPT')
		)
	INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
	--INNER JOIN ods.Consultora c with(nolock) ON op.CodConsultora = c.Codigo
	INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
	INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
	WHERE
		E.Activo = 1
		AND ca.Codigo = @CampaniaID
		--AND c.ConsultoraID = @ConsultoraID2
		--AND E.Zona LIKE '%' + @ZonaID + '%'
		AND TE.FlagActivo = 1
		AND TE.flagRecoPerfil = 1
		AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
	--ORDER BY CASE WHEN ISNULL(op.Orden,0) = 0 THEN te.Orden ELSE op.Orden END ASC

	/*SB20-1080 - INICIO */
	SET @cont2 = (SELECT COUNT(EstrategiaID) FROM #TEMPORAL)

	IF (@cont1 = @cont2)
	BEGIN

		SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001

		INSERT INTO #TEMPORAL
		SELECT
		newId() AS ColId,
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
			--dbo.fn_ObtenerTallaColorCuv_SB2(E.CUV2,@CampaniaID) as TipoTallaColor,
			'' as TipoTallaColor,
			3 as TipoEstrategiaImagenMostrar	--Oferta para Ti
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
			and (
				( @CodigoAgrupacion = '101' and op.TipoPersonalizacion in ('LAN', 'OPM', 'PAD'))
				OR (@CodigoAgrupacion = '' and op.TipoPersonalizacion = 'OPT')
			)
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		--INNER JOIN ods.Consultora c with(nolock) ON op.CodConsultora = c.Codigo
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
		WHERE
			E.Activo = 1
			AND ca.Codigo = @CampaniaID
			--AND c.ConsultoraID = @ConsultoraID2
			--AND E.Zona LIKE '%' + @ZonaID + '%'
			AND TE.FlagActivo = 1
			AND TE.flagRecoPerfil = 1
			AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
		--ORDER BY CASE WHEN ISNULL(op.Orden,0) = 0 THEN te.Orden ELSE op.Orden END ASC
	END

	IF @CodigoAgrupacion = ''
	BEGIN
	--  Oferta Web y Lanzamiento
	INSERT INTO #TEMPORAL
	SELECT
		newId() AS ColId,
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
		--dbo.fn_ObtenerTallaColorCuv_SB2(E.CUV2,@CampaniaID) as TipoTallaColor,
		'' as TipoTallaColor,
		4 as TipoEstrategiaImagenMostrar	--Oferta Web
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
		AND E.Zona LIKE '%' + @ZonaID + '%'
	--ORDER BY te.Orden ASC, e.Orden ASC

	END -- @CodigoAgrupacion = ''

	DECLARE @tablaCuvUnicos table (CUV varchar(6), Id uniqueIdentifier)
	
	insert into @tablaCuvUnicos
	select CUV2, NULL from #TEMPORAL
	group by CUV2 -- having count(CUV2) > 1

	update @tablaCuvUnicos
	set Id = (SELECT TOP 1 B.ColId FROM #TEMPORAL B WHERE  B.CUV2 = CUV)
	FROM @tablaCuvUnicos A

	DELETE B 
	--SELECT *
	FROM #TEMPORAL B
	LEFT JOIN @tablaCuvUnicos A
		ON B.CUV2 = A.CUV AND B.ColId = A.Id
	 WHERE A.CUV IS NULL	

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
	)

	IF @CodigoAgrupacion = '101'
	BEGIN

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
		FROM #TEMPORAL as T
			where T.CODIGO = '005'
		GROUP BY EstrategiaID

	END -- @CodigoAgrupacion = '101'
	
	SELECT
		T.EstrategiaID,
		T.CUV2,
		T.DescripcionCUV2,
		T.EtiquetaDescripcion,
		T.Precio,
		T.EtiquetaDescripcion2,
		T.Precio2,
		isnull(T.TextoLibre,'') as TextoLibre,
		T.FlagEstrella,
		T.ColorFondo,
		T.TipoEstrategiaID,
		T.FotoProducto01,
		T.ImagenURL,
		T.LimiteVenta,
		T.MarcaID,
		T.Orden1,
		T.Orden2,
		T.IndicadorMontoMinimo,
		T.FlagNueva,
		T.TipoTallaColor,
		T.TipoEstrategiaImagenMostrar,
		T.CodigoProducto
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
	FROM #TEMPORAL T
	LEFT JOIN Marca M with(nolock) ON M.MarcaId = T.MarcaId
	LEFT JOIN @temp D ON D.EstrategiaID = T.EstrategiaID
	ORDER BY
	Orden1 ASC, CASE WHEN ISNULL(T.Orden2,0) = 0 THEN T.Orden1 ELSE T.Orden2 END ASC, EstrategiaID ASC

	DROP TABLE #TEMPORAL

	SET NOCOUNT OFF
END

GO

USE BelcorpCostaRica
GO

GO
ALTER PROCEDURE [dbo].[ListarEstrategiasPedido_SB2]
	@CampaniaID INT,
	@ConsultoraID VARCHAR(30),
	@CUV VARCHAR(20),
	@ZonaID VARCHAR(20),
	@CodigoAgrupacion VARCHAR(10) = ''
AS
/*
dbo.ListarEstrategiasPedido_SB2 201710,'1107','','2329', '101'
*/
BEGIN
	SET NOCOUNT ON;
	
	--declare @CampaniaID INT = 201710,
	--@ConsultoraID VARCHAR(30) = '1107',
	--@CUV VARCHAR(20) = '',
	--@ZonaID VARCHAR(20) = '2329',
	--@CodigoAgrupacion VARCHAR(10) = '101'
		

	set @CodigoAgrupacion = ISNULL(@CodigoAgrupacion, '')

	-- CrossSelling se implemento a un servicio
	--DECLARE @CuvReco VARCHAR(20)
	--SELECT @CuvReco = CSA.CUV
	--FROM CrossSellingAsociacion CSA
	--INNER JOIN ods.Campania CA ON CSA.CampaniaID = CA.CampaniaID
	--WHERE
	--	CA.Codigo = @CampaniaID
	--	AND (CUVAsociado = @CUV OR CUVAsociado2 = @CUV OR CUV = @CUV)

	--/* RECOMENDACION POR CUV - INICIO */
	--SELECT
	--	EstrategiaID,
	--	CUV2,
	--	DescripcionCUV2,
	--	dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
	--	E.Precio,
	--	dbo.ObtenerDescripcionEtiqueta(EtiquetaID2) EtiquetaDescripcion2,
	--	Precio2,
	--	TextoLibre,
	--	FlagEstrella,
	--	ColorFondo,
	--	e.TipoEstrategiaID,
	--	e.ImagenURL FotoProducto01,
	--	te.ImagenEstrategia ImagenURL,
	--	e.LimiteVenta,
	--	pc.MarcaID,
	--	te.Orden Orden1,
	--	e.Orden Orden2,
	--	pc.IndicadorMontoMinimo,
	--	pc.CodigoProducto,
	--	TE.FlagNueva,
	--	dbo.fn_ObtenerTallaColorCuv_SB2(E.CUV2,@CampaniaID) as TipoTallaColor,
	--	1 as TipoEstrategiaImagenMostrar	--CrossSelling
	--	, E.EtiquetaID		-- SB20-351
	--	, E.EtiquetaID2		-- SB20-351
	--	, E.CodigoEstrategia
	--	, E.TieneVariedad
	--INTO #TEMPORAL
	--FROM Estrategia E
	--INNER JOIN TipoEstrategia TE ON E.TipoEstrategiaID = TE.TipoEstrategiaID
	--INNER JOIN ods.Campania CA ON E.CampaniaID = CA.Codigo
	--INNER JOIN CrossSellingAsociacion CSA ON CSA.CampaniaID = CA.CampaniaID AND (E.CUV2 = CSA.CUVAsociado OR E.CUV2 = CSA.CUVAsociado2 )
	--INNER JOIN ods.ProductoComercial PC ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
	--WHERE
	--	E.Activo = 1
	--	AND TE.flagRecoProduc = 1
	--	AND TE.FlagActivo = 1
	--	AND CSA.CUV IS NOT NULL
	--	AND CA.Codigo = @CampaniaID
	--	AND CSA.CUV = @CuvReco
	--	AND E.Zona LIKE '%' + @ZonaID + '%'
	--ORDER BY
	--	te.Orden ASC,
	--	e.Orden ASC
	--/* RECOMENDACION POR CUV - FIN */

	declare @ConsultoraID2 bigint = CAST(@ConsultoraID as bigint)

	DECLARE @tablaCuvPedido table (CUV varchar(6))
	insert into @tablaCuvPedido
	SELECT CUV
	FROM PedidoWebDetalle with(nolock)
	WHERE CampaniaID=@CampaniaID and ConsultoraID=@ConsultoraID2

	DECLARE @CodigoConsultora VARCHAR(25)
	DECLARE @NumeroPedido INT
	declare @CodigoRegion varchar(2) = null
	declare @CodigoZona varchar(4) = null

	SELECT
		@NumeroPedido = c.ConsecutivoNueva + 1,
		@CodigoConsultora = c.Codigo,
		@CodigoRegion = r.Codigo,
		@CodigoZona = z.Codigo
	FROM ods.Consultora c with(nolock)
		INNER JOIN ods.Region r with(nolock) on r.RegionID = c.RegionID
		INNER JOIN ods.Zona z with(nolock) on z.ZonaID = c.ZonaID
	WHERE 
		c.ConsultoraID = @ConsultoraID2

	CREATE TABLE #TEMPORAL (
		ColId uniqueIdentifier,
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

	-- Obtener estrategias de Pack Nuevas.
	INSERT INTO #TEMPORAL
	SELECT
		newId() AS ColId,
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
		1 AS FlagNueva, -- R2621
		--dbo.fn_ObtenerTallaColorCuv_SB2(E.CUV2,@CampaniaID) as TipoTallaColor,
		'' as TipoTallaColor,
		2 as TipoEstrategiaImagenMostrar	-- Pack Nuevas
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
		AND E.Activo = 1
		AND CPN.Participa = 1
		AND TE.FlagActivo = 1
		AND TE.flagNueva = 1
		AND E.NumeroPedido = @NumeroPedido
		AND E.Zona LIKE '%' + @ZonaID + '%'
		AND E.CUV2 not in(SELECT CUV FROM @tablaCuvPedido)
	--ORDER BY te.Orden ASC, e.Orden ASC

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

	DECLARE @cont1 INT, @cont2 INT, @codConsultoraDefault VARCHAR(9)
	SELECT @cont1 = COUNT(EstrategiaID) FROM #TEMPORAL
	
	INSERT INTO #TEMPORAL
		SELECT
		newId() AS ColId,
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
		--dbo.fn_ObtenerTallaColorCuv_SB2(E.CUV2,@CampaniaID) as TipoTallaColor,
		'' as TipoTallaColor,
		3 as TipoEstrategiaImagenMostrar	--Oferta para Ti
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
		and (
			( @CodigoAgrupacion = '101' and op.TipoPersonalizacion in ('LAN', 'OPM', 'PAD'))
			OR (@CodigoAgrupacion = '' and op.TipoPersonalizacion = 'OPT')
		)
	INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
	--INNER JOIN ods.Consultora c with(nolock) ON op.CodConsultora = c.Codigo
	INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
	INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
	WHERE
		E.Activo = 1
		AND ca.Codigo = @CampaniaID
		--AND c.ConsultoraID = @ConsultoraID2
		--AND E.Zona LIKE '%' + @ZonaID + '%'
		AND TE.FlagActivo = 1
		AND TE.flagRecoPerfil = 1
		AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
	--ORDER BY CASE WHEN ISNULL(op.Orden,0) = 0 THEN te.Orden ELSE op.Orden END ASC

	/*SB20-1080 - INICIO */
	SET @cont2 = (SELECT COUNT(EstrategiaID) FROM #TEMPORAL)

	IF (@cont1 = @cont2)
	BEGIN

		SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001

		INSERT INTO #TEMPORAL
		SELECT
		newId() AS ColId,
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
			--dbo.fn_ObtenerTallaColorCuv_SB2(E.CUV2,@CampaniaID) as TipoTallaColor,
			'' as TipoTallaColor,
			3 as TipoEstrategiaImagenMostrar	--Oferta para Ti
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
			and (
				( @CodigoAgrupacion = '101' and op.TipoPersonalizacion in ('LAN', 'OPM', 'PAD'))
				OR (@CodigoAgrupacion = '' and op.TipoPersonalizacion = 'OPT')
			)
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		--INNER JOIN ods.Consultora c with(nolock) ON op.CodConsultora = c.Codigo
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
		WHERE
			E.Activo = 1
			AND ca.Codigo = @CampaniaID
			--AND c.ConsultoraID = @ConsultoraID2
			--AND E.Zona LIKE '%' + @ZonaID + '%'
			AND TE.FlagActivo = 1
			AND TE.flagRecoPerfil = 1
			AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
		--ORDER BY CASE WHEN ISNULL(op.Orden,0) = 0 THEN te.Orden ELSE op.Orden END ASC
	END

	IF @CodigoAgrupacion = ''
	BEGIN
	--  Oferta Web y Lanzamiento
	INSERT INTO #TEMPORAL
	SELECT
		newId() AS ColId,
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
		--dbo.fn_ObtenerTallaColorCuv_SB2(E.CUV2,@CampaniaID) as TipoTallaColor,
		'' as TipoTallaColor,
		4 as TipoEstrategiaImagenMostrar	--Oferta Web
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
		AND E.Zona LIKE '%' + @ZonaID + '%'
	--ORDER BY te.Orden ASC, e.Orden ASC

	END -- @CodigoAgrupacion = ''

	DECLARE @tablaCuvUnicos table (CUV varchar(6), Id uniqueIdentifier)
	
	insert into @tablaCuvUnicos
	select CUV2, NULL from #TEMPORAL
	group by CUV2 -- having count(CUV2) > 1

	update @tablaCuvUnicos
	set Id = (SELECT TOP 1 B.ColId FROM #TEMPORAL B WHERE  B.CUV2 = CUV)
	FROM @tablaCuvUnicos A

	DELETE B 
	--SELECT *
	FROM #TEMPORAL B
	LEFT JOIN @tablaCuvUnicos A
		ON B.CUV2 = A.CUV AND B.ColId = A.Id
	 WHERE A.CUV IS NULL	

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
	)

	IF @CodigoAgrupacion = '101'
	BEGIN

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
		FROM #TEMPORAL as T
			where T.CODIGO = '005'
		GROUP BY EstrategiaID

	END -- @CodigoAgrupacion = '101'
	
	SELECT
		T.EstrategiaID,
		T.CUV2,
		T.DescripcionCUV2,
		T.EtiquetaDescripcion,
		T.Precio,
		T.EtiquetaDescripcion2,
		T.Precio2,
		isnull(T.TextoLibre,'') as TextoLibre,
		T.FlagEstrella,
		T.ColorFondo,
		T.TipoEstrategiaID,
		T.FotoProducto01,
		T.ImagenURL,
		T.LimiteVenta,
		T.MarcaID,
		T.Orden1,
		T.Orden2,
		T.IndicadorMontoMinimo,
		T.FlagNueva,
		T.TipoTallaColor,
		T.TipoEstrategiaImagenMostrar,
		T.CodigoProducto
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
	FROM #TEMPORAL T
	LEFT JOIN Marca M with(nolock) ON M.MarcaId = T.MarcaId
	LEFT JOIN @temp D ON D.EstrategiaID = T.EstrategiaID
	ORDER BY
	Orden1 ASC, CASE WHEN ISNULL(T.Orden2,0) = 0 THEN T.Orden1 ELSE T.Orden2 END ASC, EstrategiaID ASC

	DROP TABLE #TEMPORAL

	SET NOCOUNT OFF
END

GO

USE BelcorpChile
GO

GO
ALTER PROCEDURE [dbo].[ListarEstrategiasPedido_SB2]
	@CampaniaID INT,
	@ConsultoraID VARCHAR(30),
	@CUV VARCHAR(20),
	@ZonaID VARCHAR(20),
	@CodigoAgrupacion VARCHAR(10) = ''
AS
/*
dbo.ListarEstrategiasPedido_SB2 201710,'1107','','2329', '101'
*/
BEGIN
	SET NOCOUNT ON;
	
	--declare @CampaniaID INT = 201710,
	--@ConsultoraID VARCHAR(30) = '1107',
	--@CUV VARCHAR(20) = '',
	--@ZonaID VARCHAR(20) = '2329',
	--@CodigoAgrupacion VARCHAR(10) = '101'
		

	set @CodigoAgrupacion = ISNULL(@CodigoAgrupacion, '')

	-- CrossSelling se implemento a un servicio
	--DECLARE @CuvReco VARCHAR(20)
	--SELECT @CuvReco = CSA.CUV
	--FROM CrossSellingAsociacion CSA
	--INNER JOIN ods.Campania CA ON CSA.CampaniaID = CA.CampaniaID
	--WHERE
	--	CA.Codigo = @CampaniaID
	--	AND (CUVAsociado = @CUV OR CUVAsociado2 = @CUV OR CUV = @CUV)

	--/* RECOMENDACION POR CUV - INICIO */
	--SELECT
	--	EstrategiaID,
	--	CUV2,
	--	DescripcionCUV2,
	--	dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
	--	E.Precio,
	--	dbo.ObtenerDescripcionEtiqueta(EtiquetaID2) EtiquetaDescripcion2,
	--	Precio2,
	--	TextoLibre,
	--	FlagEstrella,
	--	ColorFondo,
	--	e.TipoEstrategiaID,
	--	e.ImagenURL FotoProducto01,
	--	te.ImagenEstrategia ImagenURL,
	--	e.LimiteVenta,
	--	pc.MarcaID,
	--	te.Orden Orden1,
	--	e.Orden Orden2,
	--	pc.IndicadorMontoMinimo,
	--	pc.CodigoProducto,
	--	TE.FlagNueva,
	--	dbo.fn_ObtenerTallaColorCuv_SB2(E.CUV2,@CampaniaID) as TipoTallaColor,
	--	1 as TipoEstrategiaImagenMostrar	--CrossSelling
	--	, E.EtiquetaID		-- SB20-351
	--	, E.EtiquetaID2		-- SB20-351
	--	, E.CodigoEstrategia
	--	, E.TieneVariedad
	--INTO #TEMPORAL
	--FROM Estrategia E
	--INNER JOIN TipoEstrategia TE ON E.TipoEstrategiaID = TE.TipoEstrategiaID
	--INNER JOIN ods.Campania CA ON E.CampaniaID = CA.Codigo
	--INNER JOIN CrossSellingAsociacion CSA ON CSA.CampaniaID = CA.CampaniaID AND (E.CUV2 = CSA.CUVAsociado OR E.CUV2 = CSA.CUVAsociado2 )
	--INNER JOIN ods.ProductoComercial PC ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
	--WHERE
	--	E.Activo = 1
	--	AND TE.flagRecoProduc = 1
	--	AND TE.FlagActivo = 1
	--	AND CSA.CUV IS NOT NULL
	--	AND CA.Codigo = @CampaniaID
	--	AND CSA.CUV = @CuvReco
	--	AND E.Zona LIKE '%' + @ZonaID + '%'
	--ORDER BY
	--	te.Orden ASC,
	--	e.Orden ASC
	--/* RECOMENDACION POR CUV - FIN */

	declare @ConsultoraID2 bigint = CAST(@ConsultoraID as bigint)

	DECLARE @tablaCuvPedido table (CUV varchar(6))
	insert into @tablaCuvPedido
	SELECT CUV
	FROM PedidoWebDetalle with(nolock)
	WHERE CampaniaID=@CampaniaID and ConsultoraID=@ConsultoraID2

	DECLARE @CodigoConsultora VARCHAR(25)
	DECLARE @NumeroPedido INT
	declare @CodigoRegion varchar(2) = null
	declare @CodigoZona varchar(4) = null

	SELECT
		@NumeroPedido = c.ConsecutivoNueva + 1,
		@CodigoConsultora = c.Codigo,
		@CodigoRegion = r.Codigo,
		@CodigoZona = z.Codigo
	FROM ods.Consultora c with(nolock)
		INNER JOIN ods.Region r with(nolock) on r.RegionID = c.RegionID
		INNER JOIN ods.Zona z with(nolock) on z.ZonaID = c.ZonaID
	WHERE 
		c.ConsultoraID = @ConsultoraID2

	CREATE TABLE #TEMPORAL (
		ColId uniqueIdentifier,
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

	-- Obtener estrategias de Pack Nuevas.
	INSERT INTO #TEMPORAL
	SELECT
		newId() AS ColId,
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
		1 AS FlagNueva, -- R2621
		--dbo.fn_ObtenerTallaColorCuv_SB2(E.CUV2,@CampaniaID) as TipoTallaColor,
		'' as TipoTallaColor,
		2 as TipoEstrategiaImagenMostrar	-- Pack Nuevas
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
		AND E.Activo = 1
		AND CPN.Participa = 1
		AND TE.FlagActivo = 1
		AND TE.flagNueva = 1
		AND E.NumeroPedido = @NumeroPedido
		AND E.Zona LIKE '%' + @ZonaID + '%'
		AND E.CUV2 not in(SELECT CUV FROM @tablaCuvPedido)
	--ORDER BY te.Orden ASC, e.Orden ASC

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

	DECLARE @cont1 INT, @cont2 INT, @codConsultoraDefault VARCHAR(9)
	SELECT @cont1 = COUNT(EstrategiaID) FROM #TEMPORAL
	
	INSERT INTO #TEMPORAL
		SELECT
		newId() AS ColId,
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
		--dbo.fn_ObtenerTallaColorCuv_SB2(E.CUV2,@CampaniaID) as TipoTallaColor,
		'' as TipoTallaColor,
		3 as TipoEstrategiaImagenMostrar	--Oferta para Ti
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
		and (
			( @CodigoAgrupacion = '101' and op.TipoPersonalizacion in ('LAN', 'OPM', 'PAD'))
			OR (@CodigoAgrupacion = '' and op.TipoPersonalizacion = 'OPT')
		)
	INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
	--INNER JOIN ods.Consultora c with(nolock) ON op.CodConsultora = c.Codigo
	INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
	INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
	WHERE
		E.Activo = 1
		AND ca.Codigo = @CampaniaID
		--AND c.ConsultoraID = @ConsultoraID2
		--AND E.Zona LIKE '%' + @ZonaID + '%'
		AND TE.FlagActivo = 1
		AND TE.flagRecoPerfil = 1
		AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
	--ORDER BY CASE WHEN ISNULL(op.Orden,0) = 0 THEN te.Orden ELSE op.Orden END ASC

	/*SB20-1080 - INICIO */
	SET @cont2 = (SELECT COUNT(EstrategiaID) FROM #TEMPORAL)

	IF (@cont1 = @cont2)
	BEGIN

		SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001

		INSERT INTO #TEMPORAL
		SELECT
		newId() AS ColId,
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
			--dbo.fn_ObtenerTallaColorCuv_SB2(E.CUV2,@CampaniaID) as TipoTallaColor,
			'' as TipoTallaColor,
			3 as TipoEstrategiaImagenMostrar	--Oferta para Ti
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
			and (
				( @CodigoAgrupacion = '101' and op.TipoPersonalizacion in ('LAN', 'OPM', 'PAD'))
				OR (@CodigoAgrupacion = '' and op.TipoPersonalizacion = 'OPT')
			)
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		--INNER JOIN ods.Consultora c with(nolock) ON op.CodConsultora = c.Codigo
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
		WHERE
			E.Activo = 1
			AND ca.Codigo = @CampaniaID
			--AND c.ConsultoraID = @ConsultoraID2
			--AND E.Zona LIKE '%' + @ZonaID + '%'
			AND TE.FlagActivo = 1
			AND TE.flagRecoPerfil = 1
			AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
		--ORDER BY CASE WHEN ISNULL(op.Orden,0) = 0 THEN te.Orden ELSE op.Orden END ASC
	END

	IF @CodigoAgrupacion = ''
	BEGIN
	--  Oferta Web y Lanzamiento
	INSERT INTO #TEMPORAL
	SELECT
		newId() AS ColId,
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
		--dbo.fn_ObtenerTallaColorCuv_SB2(E.CUV2,@CampaniaID) as TipoTallaColor,
		'' as TipoTallaColor,
		4 as TipoEstrategiaImagenMostrar	--Oferta Web
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
		AND E.Zona LIKE '%' + @ZonaID + '%'
	--ORDER BY te.Orden ASC, e.Orden ASC

	END -- @CodigoAgrupacion = ''

	DECLARE @tablaCuvUnicos table (CUV varchar(6), Id uniqueIdentifier)
	
	insert into @tablaCuvUnicos
	select CUV2, NULL from #TEMPORAL
	group by CUV2 -- having count(CUV2) > 1

	update @tablaCuvUnicos
	set Id = (SELECT TOP 1 B.ColId FROM #TEMPORAL B WHERE  B.CUV2 = CUV)
	FROM @tablaCuvUnicos A

	DELETE B 
	--SELECT *
	FROM #TEMPORAL B
	LEFT JOIN @tablaCuvUnicos A
		ON B.CUV2 = A.CUV AND B.ColId = A.Id
	 WHERE A.CUV IS NULL	

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
	)

	IF @CodigoAgrupacion = '101'
	BEGIN

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
		FROM #TEMPORAL as T
			where T.CODIGO = '005'
		GROUP BY EstrategiaID

	END -- @CodigoAgrupacion = '101'
	
	SELECT
		T.EstrategiaID,
		T.CUV2,
		T.DescripcionCUV2,
		T.EtiquetaDescripcion,
		T.Precio,
		T.EtiquetaDescripcion2,
		T.Precio2,
		isnull(T.TextoLibre,'') as TextoLibre,
		T.FlagEstrella,
		T.ColorFondo,
		T.TipoEstrategiaID,
		T.FotoProducto01,
		T.ImagenURL,
		T.LimiteVenta,
		T.MarcaID,
		T.Orden1,
		T.Orden2,
		T.IndicadorMontoMinimo,
		T.FlagNueva,
		T.TipoTallaColor,
		T.TipoEstrategiaImagenMostrar,
		T.CodigoProducto
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
	FROM #TEMPORAL T
	LEFT JOIN Marca M with(nolock) ON M.MarcaId = T.MarcaId
	LEFT JOIN @temp D ON D.EstrategiaID = T.EstrategiaID
	ORDER BY
	Orden1 ASC, CASE WHEN ISNULL(T.Orden2,0) = 0 THEN T.Orden1 ELSE T.Orden2 END ASC, EstrategiaID ASC

	DROP TABLE #TEMPORAL

	SET NOCOUNT OFF
END

GO

USE BelcorpBolivia
GO

GO
ALTER PROCEDURE [dbo].[ListarEstrategiasPedido_SB2]
	@CampaniaID INT,
	@ConsultoraID VARCHAR(30),
	@CUV VARCHAR(20),
	@ZonaID VARCHAR(20),
	@CodigoAgrupacion VARCHAR(10) = ''
AS
/*
dbo.ListarEstrategiasPedido_SB2 201710,'1107','','2329', '101'
*/
BEGIN
	SET NOCOUNT ON;
	
	--declare @CampaniaID INT = 201710,
	--@ConsultoraID VARCHAR(30) = '1107',
	--@CUV VARCHAR(20) = '',
	--@ZonaID VARCHAR(20) = '2329',
	--@CodigoAgrupacion VARCHAR(10) = '101'
		

	set @CodigoAgrupacion = ISNULL(@CodigoAgrupacion, '')

	-- CrossSelling se implemento a un servicio
	--DECLARE @CuvReco VARCHAR(20)
	--SELECT @CuvReco = CSA.CUV
	--FROM CrossSellingAsociacion CSA
	--INNER JOIN ods.Campania CA ON CSA.CampaniaID = CA.CampaniaID
	--WHERE
	--	CA.Codigo = @CampaniaID
	--	AND (CUVAsociado = @CUV OR CUVAsociado2 = @CUV OR CUV = @CUV)

	--/* RECOMENDACION POR CUV - INICIO */
	--SELECT
	--	EstrategiaID,
	--	CUV2,
	--	DescripcionCUV2,
	--	dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
	--	E.Precio,
	--	dbo.ObtenerDescripcionEtiqueta(EtiquetaID2) EtiquetaDescripcion2,
	--	Precio2,
	--	TextoLibre,
	--	FlagEstrella,
	--	ColorFondo,
	--	e.TipoEstrategiaID,
	--	e.ImagenURL FotoProducto01,
	--	te.ImagenEstrategia ImagenURL,
	--	e.LimiteVenta,
	--	pc.MarcaID,
	--	te.Orden Orden1,
	--	e.Orden Orden2,
	--	pc.IndicadorMontoMinimo,
	--	pc.CodigoProducto,
	--	TE.FlagNueva,
	--	dbo.fn_ObtenerTallaColorCuv_SB2(E.CUV2,@CampaniaID) as TipoTallaColor,
	--	1 as TipoEstrategiaImagenMostrar	--CrossSelling
	--	, E.EtiquetaID		-- SB20-351
	--	, E.EtiquetaID2		-- SB20-351
	--	, E.CodigoEstrategia
	--	, E.TieneVariedad
	--INTO #TEMPORAL
	--FROM Estrategia E
	--INNER JOIN TipoEstrategia TE ON E.TipoEstrategiaID = TE.TipoEstrategiaID
	--INNER JOIN ods.Campania CA ON E.CampaniaID = CA.Codigo
	--INNER JOIN CrossSellingAsociacion CSA ON CSA.CampaniaID = CA.CampaniaID AND (E.CUV2 = CSA.CUVAsociado OR E.CUV2 = CSA.CUVAsociado2 )
	--INNER JOIN ods.ProductoComercial PC ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
	--WHERE
	--	E.Activo = 1
	--	AND TE.flagRecoProduc = 1
	--	AND TE.FlagActivo = 1
	--	AND CSA.CUV IS NOT NULL
	--	AND CA.Codigo = @CampaniaID
	--	AND CSA.CUV = @CuvReco
	--	AND E.Zona LIKE '%' + @ZonaID + '%'
	--ORDER BY
	--	te.Orden ASC,
	--	e.Orden ASC
	--/* RECOMENDACION POR CUV - FIN */

	declare @ConsultoraID2 bigint = CAST(@ConsultoraID as bigint)

	DECLARE @tablaCuvPedido table (CUV varchar(6))
	insert into @tablaCuvPedido
	SELECT CUV
	FROM PedidoWebDetalle with(nolock)
	WHERE CampaniaID=@CampaniaID and ConsultoraID=@ConsultoraID2

	DECLARE @CodigoConsultora VARCHAR(25)
	DECLARE @NumeroPedido INT
	declare @CodigoRegion varchar(2) = null
	declare @CodigoZona varchar(4) = null

	SELECT
		@NumeroPedido = c.ConsecutivoNueva + 1,
		@CodigoConsultora = c.Codigo,
		@CodigoRegion = r.Codigo,
		@CodigoZona = z.Codigo
	FROM ods.Consultora c with(nolock)
		INNER JOIN ods.Region r with(nolock) on r.RegionID = c.RegionID
		INNER JOIN ods.Zona z with(nolock) on z.ZonaID = c.ZonaID
	WHERE 
		c.ConsultoraID = @ConsultoraID2

	CREATE TABLE #TEMPORAL (
		ColId uniqueIdentifier,
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

	-- Obtener estrategias de Pack Nuevas.
	INSERT INTO #TEMPORAL
	SELECT
		newId() AS ColId,
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
		1 AS FlagNueva, -- R2621
		--dbo.fn_ObtenerTallaColorCuv_SB2(E.CUV2,@CampaniaID) as TipoTallaColor,
		'' as TipoTallaColor,
		2 as TipoEstrategiaImagenMostrar	-- Pack Nuevas
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
		AND E.Activo = 1
		AND CPN.Participa = 1
		AND TE.FlagActivo = 1
		AND TE.flagNueva = 1
		AND E.NumeroPedido = @NumeroPedido
		AND E.Zona LIKE '%' + @ZonaID + '%'
		AND E.CUV2 not in(SELECT CUV FROM @tablaCuvPedido)
	--ORDER BY te.Orden ASC, e.Orden ASC

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

	DECLARE @cont1 INT, @cont2 INT, @codConsultoraDefault VARCHAR(9)
	SELECT @cont1 = COUNT(EstrategiaID) FROM #TEMPORAL
	
	INSERT INTO #TEMPORAL
		SELECT
		newId() AS ColId,
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
		--dbo.fn_ObtenerTallaColorCuv_SB2(E.CUV2,@CampaniaID) as TipoTallaColor,
		'' as TipoTallaColor,
		3 as TipoEstrategiaImagenMostrar	--Oferta para Ti
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
		and (
			( @CodigoAgrupacion = '101' and op.TipoPersonalizacion in ('LAN', 'OPM', 'PAD'))
			OR (@CodigoAgrupacion = '' and op.TipoPersonalizacion = 'OPT')
		)
	INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
	--INNER JOIN ods.Consultora c with(nolock) ON op.CodConsultora = c.Codigo
	INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
	INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
	WHERE
		E.Activo = 1
		AND ca.Codigo = @CampaniaID
		--AND c.ConsultoraID = @ConsultoraID2
		--AND E.Zona LIKE '%' + @ZonaID + '%'
		AND TE.FlagActivo = 1
		AND TE.flagRecoPerfil = 1
		AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
	--ORDER BY CASE WHEN ISNULL(op.Orden,0) = 0 THEN te.Orden ELSE op.Orden END ASC

	/*SB20-1080 - INICIO */
	SET @cont2 = (SELECT COUNT(EstrategiaID) FROM #TEMPORAL)

	IF (@cont1 = @cont2)
	BEGIN

		SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001

		INSERT INTO #TEMPORAL
		SELECT
		newId() AS ColId,
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
			--dbo.fn_ObtenerTallaColorCuv_SB2(E.CUV2,@CampaniaID) as TipoTallaColor,
			'' as TipoTallaColor,
			3 as TipoEstrategiaImagenMostrar	--Oferta para Ti
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
			and (
				( @CodigoAgrupacion = '101' and op.TipoPersonalizacion in ('LAN', 'OPM', 'PAD'))
				OR (@CodigoAgrupacion = '' and op.TipoPersonalizacion = 'OPT')
			)
		INNER JOIN ods.Campania ca with(nolock) ON CA.Codigo = E.CampaniaID
		--INNER JOIN ods.Consultora c with(nolock) ON op.CodConsultora = c.Codigo
		INNER JOIN ods.ProductoComercial PC with(nolock) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
		WHERE
			E.Activo = 1
			AND ca.Codigo = @CampaniaID
			--AND c.ConsultoraID = @ConsultoraID2
			--AND E.Zona LIKE '%' + @ZonaID + '%'
			AND TE.FlagActivo = 1
			AND TE.flagRecoPerfil = 1
			AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
		--ORDER BY CASE WHEN ISNULL(op.Orden,0) = 0 THEN te.Orden ELSE op.Orden END ASC
	END

	IF @CodigoAgrupacion = ''
	BEGIN
	--  Oferta Web y Lanzamiento
	INSERT INTO #TEMPORAL
	SELECT
		newId() AS ColId,
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
		--dbo.fn_ObtenerTallaColorCuv_SB2(E.CUV2,@CampaniaID) as TipoTallaColor,
		'' as TipoTallaColor,
		4 as TipoEstrategiaImagenMostrar	--Oferta Web
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
		AND E.Zona LIKE '%' + @ZonaID + '%'
	--ORDER BY te.Orden ASC, e.Orden ASC

	END -- @CodigoAgrupacion = ''

	DECLARE @tablaCuvUnicos table (CUV varchar(6), Id uniqueIdentifier)
	
	insert into @tablaCuvUnicos
	select CUV2, NULL from #TEMPORAL
	group by CUV2 -- having count(CUV2) > 1

	update @tablaCuvUnicos
	set Id = (SELECT TOP 1 B.ColId FROM #TEMPORAL B WHERE  B.CUV2 = CUV)
	FROM @tablaCuvUnicos A

	DELETE B 
	--SELECT *
	FROM #TEMPORAL B
	LEFT JOIN @tablaCuvUnicos A
		ON B.CUV2 = A.CUV AND B.ColId = A.Id
	 WHERE A.CUV IS NULL	

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
	)

	IF @CodigoAgrupacion = '101'
	BEGIN

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
		FROM #TEMPORAL as T
			where T.CODIGO = '005'
		GROUP BY EstrategiaID

	END -- @CodigoAgrupacion = '101'
	
	SELECT
		T.EstrategiaID,
		T.CUV2,
		T.DescripcionCUV2,
		T.EtiquetaDescripcion,
		T.Precio,
		T.EtiquetaDescripcion2,
		T.Precio2,
		isnull(T.TextoLibre,'') as TextoLibre,
		T.FlagEstrella,
		T.ColorFondo,
		T.TipoEstrategiaID,
		T.FotoProducto01,
		T.ImagenURL,
		T.LimiteVenta,
		T.MarcaID,
		T.Orden1,
		T.Orden2,
		T.IndicadorMontoMinimo,
		T.FlagNueva,
		T.TipoTallaColor,
		T.TipoEstrategiaImagenMostrar,
		T.CodigoProducto
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
	FROM #TEMPORAL T
	LEFT JOIN Marca M with(nolock) ON M.MarcaId = T.MarcaId
	LEFT JOIN @temp D ON D.EstrategiaID = T.EstrategiaID
	ORDER BY
	Orden1 ASC, CASE WHEN ISNULL(T.Orden2,0) = 0 THEN T.Orden1 ELSE T.Orden2 END ASC, EstrategiaID ASC

	DROP TABLE #TEMPORAL

	SET NOCOUNT OFF
END

GO

