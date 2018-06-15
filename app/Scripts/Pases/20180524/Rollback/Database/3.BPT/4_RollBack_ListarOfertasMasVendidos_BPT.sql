USE BelcorpPeru
GO

ALTER PROCEDURE [dbo].[ListarOfertasMasVendidos]
	@CampaniaID INT,
	@ConsultoraID VARCHAR(30),
	@ZonaID VARCHAR(20)
AS
/*
	ListarOfertasMasVendidos 201710, '49409307', '2228' --035708669
	ListarOfertasMasVendidos 201710, '2', '2161' --000758833
*/
BEGIN
	SET NOCOUNT ON;
		
	DECLARE @tablaCuvPedido table (CUV varchar(6))
	insert into @tablaCuvPedido
	SELECT CUV
	FROM PedidoWebDetalle with(nolock)
	WHERE CampaniaID=@CampaniaID and ConsultoraID=@ConsultoraID

	DECLARE @CodigoConsultora VARCHAR(25)
	DECLARE @NumeroPedido INT

	SELECT
		@NumeroPedido = consecutivonueva + 1,
		@CodigoConsultora = codigo
	FROM ods.Consultora
	WHERE
		ConsultoraID=@ConsultoraID
	
	DECLARE @TieneOfertas BIT
	SET @TieneOfertas = 0
	--validar si tiene ofertas , sino obtener del generico
	IF EXISTS (SELECT 1 FROM  ods.ofertaspersonalizadas op  WHERE op.CodConsultora= @CodigoConsultora AND op.AnioCampanaVenta= @CampaniaID AND op.TipoPersonalizacion= 'BS')
		SET @TieneOfertas = 1

	PRINT @TieneOfertas
	-- Obtener estrategias de recomendadas para ti.
	declare @CodigoRegion varchar(2) = null
	declare @CodigoZona varchar(4) = null
	select @CodigoRegion = r.Codigo, @CodigoZona = z.Codigo
	from ods.Zona z
	inner join ods.Region r on
		z.RegionId = r.RegionId
	where ZonaId = @ZonaID

	DECLARE @tablaCuvFaltante TABLE (CUV VARCHAR(6))

	insert into @tablaCuvFaltante
	select
		distinct ltrim(rtrim(CUV))
	from dbo.ProductoFaltante nolock
	where
		CampaniaID = @CampaniaID and Zonaid = @ZonaID
	UNION ALL
	select
		distinct ltrim(rtrim(fa.CodigoVenta)) AS CUV
	from ods.FaltanteAnunciado fa (nolock)
	inner join ods.Campania c (nolock) on
		fa.CampaniaID = c.CampaniaID
	where
		c.Codigo = @CampaniaID
		and (rtrim(fa.CodigoRegion) = @CodigoRegion or fa.CodigoRegion IS NULL)
		and (rtrim(fa.CodigoZona) = @CodigoZona or fa.CodigoZona IS NULL)

	DECLARE @OFERTAS TABLE (
		ColId UNIQUEIDENTIFIER,
		EstrategiaID INT,
		CUV2 VARCHAR(20),
		DescripcionCUV2 VARCHAR(800),
		EtiquetaDescripcion VARCHAR(8000),
		Precio NUMERIC(12,2),
		EtiquetaDescripcion2 VARCHAR(8000),
		Precio2 NUMERIC(12,2),
		TextoLibre VARCHAR(800),
		FlagEstrella BIT,
		ColorFondo VARCHAR(20),
		TipoEstrategiaID INT,
		FotoProducto01 VARCHAR(800),
		ImagenURL VARCHAR(500),
		LimiteVenta INT,
		MarcaID INT,
		Orden1 INT,
		Orden2 INT,
		IndicadorMontoMinimo INT,
		CodigoProducto VARCHAR(12),
		FlagNueva INT,
		TipoTallaColor VARCHAR(4),
		TipoEstrategiaImagenMostrar INT,
		EtiquetaID INT,
		EtiquetaID2 INT,
		CodigoEstrategia VARCHAR(100),
		TieneVariedad INT,
		CODIGO VARCHAR(100),
		DescripcionEstrategia VARCHAR(200),
		FlagMostrarImg TINYINT
	) 

	IF @TieneOfertas = 1
	BEGIN
		INSERT INTO @OFERTAS
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
		0 AS FlagNueva, -- R2621
		dbo.fn_ObtenerTallaColorCuv_SB2(E.CUV2,@CampaniaID) as TipoTallaColor,
		3 as TipoEstrategiaImagenMostrar	--Oferta para Ti
		, E.EtiquetaID		-- SB20-351
		, E.EtiquetaID2		-- SB20-351
		, E.CodigoEstrategia
		, E.TieneVariedad		
		, TE.CODIGO
		, TE.DescripcionEstrategia AS DescripcionEstrategia
		, ISNULL(TE.FlagMostrarImg,0) AS FlagMostrarImg
		FROM Estrategia E
		INNER JOIN TipoEstrategia TE ON E.TipoEstrategiaID = TE.TipoEstrategiaID AND TE.FlagActivo = 1 AND TE.Codigo = '020'
		INNER JOIN ods.Campania ca ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.OfertasPersonalizadas op ON CA.Codigo = op.AnioCampanaVenta AND E.CUV2 = op.CUV AND op.TipoPersonalizacion = 'BS'
		INNER JOIN ods.Consultora c ON op.CodConsultora = c.Codigo
		INNER JOIN ods.ProductoComercial PC ON CA.CampaniaID = PC.CampaniaID AND E.CUV2 = PC.CUV
		WHERE
			E.Activo = 1
			AND ca.Codigo = @CampaniaID
			AND c.ConsultoraID = @ConsultoraID
			AND E.Zona LIKE '%' + @ZonaID + '%'
			--AND TE.FlagActivo = 1
			AND TE.flagRecoPerfil = 1
			AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
		ORDER BY CASE WHEN ISNULL(op.Orden,0) = 0 THEN te.Orden ELSE op.Orden END ASC
	END
	ELSE 
	BEGIN
		DECLARE @ConsultoraGenerica VARCHAR(50) = ''
		SELECT @ConsultoraGenerica = Codigo FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10001

		INSERT INTO @OFERTAS
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
		0 AS FlagNueva, -- R2621
		dbo.fn_ObtenerTallaColorCuv_SB2(E.CUV2,@CampaniaID) as TipoTallaColor,
		3 as TipoEstrategiaImagenMostrar	--Oferta para Ti
		, E.EtiquetaID		-- SB20-351
		, E.EtiquetaID2		-- SB20-351
		, E.CodigoEstrategia
		, E.TieneVariedad		
		, TE.CODIGO
		, TE.DescripcionEstrategia AS DescripcionEstrategia
		, ISNULL(TE.FlagMostrarImg,0) AS FlagMostrarImg
		FROM Estrategia E
		INNER JOIN TipoEstrategia TE ON E.TipoEstrategiaID = TE.TipoEstrategiaID AND TE.Codigo='020'
		INNER JOIN ods.Campania ca ON CA.Codigo = e.campaniaid
		INNER JOIN ods.OfertasPersonalizadas op ON E.CUV2 = op.CUV and op.AnioCampanaVenta = CA.Codigo AND op.TipoPersonalizacion = 'BS'
		INNER JOIN ods.ProductoComercial PC ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		WHERE
			E.Activo = 1
			AND ca.Codigo = @CampaniaID
			AND op.CodConsultora = @ConsultoraGenerica
			AND E.Zona LIKE '%' + @ZonaID + '%'
			AND TE.FlagActivo = 1
			AND TE.flagRecoPerfil = 1
			AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
		ORDER BY CASE WHEN ISNULL(op.Orden,0) = 0 THEN te.Orden ELSE op.Orden END ASC
	END

	DECLARE @TEMP TABLE (
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

	INSERT INTO @temp 
		SELECT EstrategiaID
			,(select top 1 valor from EstrategiaDetalle where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10201) as ImgFondoDesktop
			,(select top 1 valor from EstrategiaDetalle where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10202) as ImgPrevDesktop
			,(select top 1 valor from EstrategiaDetalle where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10203) as ImgSelloProductoDesktop
			,(select top 1 valor from EstrategiaDetalle where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10204) as UrlVideoDesktop
			,(select top 1 valor from EstrategiaDetalle where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10208) as ImgFichaFondoDesktop
			,(select top 1 valor from EstrategiaDetalle where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10205) as ImgFondoMobile
			,(select top 1 valor from EstrategiaDetalle where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10206) as ImgSelloProductoMobile
			,(select top 1 valor from EstrategiaDetalle where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10207) as UrlVideoMobile
			,(select top 1 valor from EstrategiaDetalle where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10209) as ImgFichaFondoMobile			
		FROM @OFERTAS as T
		GROUP BY EstrategiaID

	DECLARE @tablaCuvUnicos table (CUV varchar(6), Id uniqueIdentifier)

	insert into @tablaCuvUnicos
	select CUV2, NULL from @OFERTAS
	group by CUV2

	update @tablaCuvUnicos
	set Id = (SELECT TOP 1 B.ColId FROM @OFERTAS B WHERE B.CUV2 = A.CUV)
	FROM @tablaCuvUnicos A

	DELETE B 
	FROM @OFERTAS B
	LEFT JOIN @tablaCuvUnicos A
		ON B.CUV2 = A.CUV AND B.ColId = A.Id
	 WHERE A.CUV IS NULL	 

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
		M.Descripcion as DescripcionMarca,
		'NO DISPONIBLE' AS DescripcionCategoria,
		T.FlagNueva, -- R2621
		T.TipoTallaColor,
		T.TipoEstrategiaImagenMostrar,
		T.CodigoProducto
		, T.EtiquetaID		-- SB20-351
		, T.EtiquetaID2		-- SB20-351
		, T.CodigoEstrategia
		, T.TieneVariedad
		, T.CODIGO
		, T.DescripcionEstrategia
		, T.FlagMostrarImg
		, D.ImgFondoDesktop
		, D.ImgPrevDesktop
		, D.ImgSelloProductoDesktop as ImgFichaDesktop
		, D.UrlVideoDesktop 
		, D.ImgFichaFondoDesktop 
		, D.ImgFondoMobile 
		, D.ImgSelloProductoMobile as ImgFichaMobile
		, D.UrlVideoMobile 
		, D.ImgFichaFondoMobile
		, RTRIM(SP.CodigoGenerico) AS CodigoGenerico
		, ISNULL(PC.CantAprobados,0) AS CantComenAprob
		, ISNULL(PC.CantRecomendados,0) AS CantComenRecom
		, ISNULL(PC.PromValorizado,0) AS PromValorizado
	FROM @OFERTAS T
	LEFT JOIN Marca M ON M.MarcaId = T.MarcaId
	LEFT JOIN @temp D ON D.EstrategiaID = T.EstrategiaID
	LEFT JOIN ods.SAP_PRODUCTO SP ON T.CodigoProducto = SP.CodigoSap AND ISNULL(SP.CodigoGenerico,'') <> ''
	LEFT JOIN ProductoComentario PC on T.CodigoProducto = PC.CodigoSap AND PC.Estado = 1
	ORDER BY
	Orden1 ASC, CASE WHEN ISNULL(T.Orden2,0) = 0 THEN T.Orden1 ELSE T.Orden2 END ASC, EstrategiaID ASC

	--DROP TABLE @OFERTAS
	SET NOCOUNT OFF
END
GO

USE BelcorpMexico
GO

ALTER PROCEDURE [dbo].[ListarOfertasMasVendidos]
	@CampaniaID INT,
	@ConsultoraID VARCHAR(30),
	@ZonaID VARCHAR(20)
AS
/*
	ListarOfertasMasVendidos 201710, '49409307', '2228' --035708669
	ListarOfertasMasVendidos 201710, '2', '2161' --000758833
*/
BEGIN
	SET NOCOUNT ON;
		
	DECLARE @tablaCuvPedido table (CUV varchar(6))
	insert into @tablaCuvPedido
	SELECT CUV
	FROM PedidoWebDetalle with(nolock)
	WHERE CampaniaID=@CampaniaID and ConsultoraID=@ConsultoraID

	DECLARE @CodigoConsultora VARCHAR(25)
	DECLARE @NumeroPedido INT

	SELECT
		@NumeroPedido = consecutivonueva + 1,
		@CodigoConsultora = codigo
	FROM ods.Consultora
	WHERE
		ConsultoraID=@ConsultoraID
	
	DECLARE @TieneOfertas BIT
	SET @TieneOfertas = 0
	--validar si tiene ofertas , sino obtener del generico
	IF EXISTS (SELECT 1 FROM  ods.ofertaspersonalizadas op  WHERE op.CodConsultora= @CodigoConsultora AND op.AnioCampanaVenta= @CampaniaID AND op.TipoPersonalizacion= 'BS')
		SET @TieneOfertas = 1

	PRINT @TieneOfertas
	-- Obtener estrategias de recomendadas para ti.
	declare @CodigoRegion varchar(2) = null
	declare @CodigoZona varchar(4) = null
	select @CodigoRegion = r.Codigo, @CodigoZona = z.Codigo
	from ods.Zona z
	inner join ods.Region r on
		z.RegionId = r.RegionId
	where ZonaId = @ZonaID

	DECLARE @tablaCuvFaltante TABLE (CUV VARCHAR(6))

	insert into @tablaCuvFaltante
	select
		distinct ltrim(rtrim(CUV))
	from dbo.ProductoFaltante nolock
	where
		CampaniaID = @CampaniaID and Zonaid = @ZonaID
	UNION ALL
	select
		distinct ltrim(rtrim(fa.CodigoVenta)) AS CUV
	from ods.FaltanteAnunciado fa (nolock)
	inner join ods.Campania c (nolock) on
		fa.CampaniaID = c.CampaniaID
	where
		c.Codigo = @CampaniaID
		and (rtrim(fa.CodigoRegion) = @CodigoRegion or fa.CodigoRegion IS NULL)
		and (rtrim(fa.CodigoZona) = @CodigoZona or fa.CodigoZona IS NULL)

	DECLARE @OFERTAS TABLE (
		ColId UNIQUEIDENTIFIER,
		EstrategiaID INT,
		CUV2 VARCHAR(20),
		DescripcionCUV2 VARCHAR(800),
		EtiquetaDescripcion VARCHAR(8000),
		Precio NUMERIC(12,2),
		EtiquetaDescripcion2 VARCHAR(8000),
		Precio2 NUMERIC(12,2),
		TextoLibre VARCHAR(800),
		FlagEstrella BIT,
		ColorFondo VARCHAR(20),
		TipoEstrategiaID INT,
		FotoProducto01 VARCHAR(800),
		ImagenURL VARCHAR(500),
		LimiteVenta INT,
		MarcaID INT,
		Orden1 INT,
		Orden2 INT,
		IndicadorMontoMinimo INT,
		CodigoProducto VARCHAR(12),
		FlagNueva INT,
		TipoTallaColor VARCHAR(4),
		TipoEstrategiaImagenMostrar INT,
		EtiquetaID INT,
		EtiquetaID2 INT,
		CodigoEstrategia VARCHAR(100),
		TieneVariedad INT,
		CODIGO VARCHAR(100),
		DescripcionEstrategia VARCHAR(200),
		FlagMostrarImg TINYINT
	) 

	IF @TieneOfertas = 1
	BEGIN
		INSERT INTO @OFERTAS
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
		0 AS FlagNueva, -- R2621
		dbo.fn_ObtenerTallaColorCuv_SB2(E.CUV2,@CampaniaID) as TipoTallaColor,
		3 as TipoEstrategiaImagenMostrar	--Oferta para Ti
		, E.EtiquetaID		-- SB20-351
		, E.EtiquetaID2		-- SB20-351
		, E.CodigoEstrategia
		, E.TieneVariedad		
		, TE.CODIGO
		, TE.DescripcionEstrategia AS DescripcionEstrategia
		, ISNULL(TE.FlagMostrarImg,0) AS FlagMostrarImg
		FROM Estrategia E
		INNER JOIN TipoEstrategia TE ON E.TipoEstrategiaID = TE.TipoEstrategiaID AND TE.FlagActivo = 1 AND TE.Codigo = '020'
		INNER JOIN ods.Campania ca ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.OfertasPersonalizadas op ON CA.Codigo = op.AnioCampanaVenta AND E.CUV2 = op.CUV AND op.TipoPersonalizacion = 'BS'
		INNER JOIN ods.Consultora c ON op.CodConsultora = c.Codigo
		INNER JOIN ods.ProductoComercial PC ON CA.CampaniaID = PC.CampaniaID AND E.CUV2 = PC.CUV
		WHERE
			E.Activo = 1
			AND ca.Codigo = @CampaniaID
			AND c.ConsultoraID = @ConsultoraID
			AND E.Zona LIKE '%' + @ZonaID + '%'
			--AND TE.FlagActivo = 1
			AND TE.flagRecoPerfil = 1
			AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
		ORDER BY CASE WHEN ISNULL(op.Orden,0) = 0 THEN te.Orden ELSE op.Orden END ASC
	END
	ELSE 
	BEGIN
		DECLARE @ConsultoraGenerica VARCHAR(50) = ''
		SELECT @ConsultoraGenerica = Codigo FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10001

		INSERT INTO @OFERTAS
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
		0 AS FlagNueva, -- R2621
		dbo.fn_ObtenerTallaColorCuv_SB2(E.CUV2,@CampaniaID) as TipoTallaColor,
		3 as TipoEstrategiaImagenMostrar	--Oferta para Ti
		, E.EtiquetaID		-- SB20-351
		, E.EtiquetaID2		-- SB20-351
		, E.CodigoEstrategia
		, E.TieneVariedad		
		, TE.CODIGO
		, TE.DescripcionEstrategia AS DescripcionEstrategia
		, ISNULL(TE.FlagMostrarImg,0) AS FlagMostrarImg
		FROM Estrategia E
		INNER JOIN TipoEstrategia TE ON E.TipoEstrategiaID = TE.TipoEstrategiaID AND TE.Codigo='020'
		INNER JOIN ods.Campania ca ON CA.Codigo = e.campaniaid
		INNER JOIN ods.OfertasPersonalizadas op ON E.CUV2 = op.CUV and op.AnioCampanaVenta = CA.Codigo AND op.TipoPersonalizacion = 'BS'
		INNER JOIN ods.ProductoComercial PC ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		WHERE
			E.Activo = 1
			AND ca.Codigo = @CampaniaID
			AND op.CodConsultora = @ConsultoraGenerica
			AND E.Zona LIKE '%' + @ZonaID + '%'
			AND TE.FlagActivo = 1
			AND TE.flagRecoPerfil = 1
			AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
		ORDER BY CASE WHEN ISNULL(op.Orden,0) = 0 THEN te.Orden ELSE op.Orden END ASC
	END

	DECLARE @TEMP TABLE (
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

	INSERT INTO @temp 
		SELECT EstrategiaID
			,(select top 1 valor from EstrategiaDetalle where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10201) as ImgFondoDesktop
			,(select top 1 valor from EstrategiaDetalle where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10202) as ImgPrevDesktop
			,(select top 1 valor from EstrategiaDetalle where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10203) as ImgSelloProductoDesktop
			,(select top 1 valor from EstrategiaDetalle where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10204) as UrlVideoDesktop
			,(select top 1 valor from EstrategiaDetalle where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10208) as ImgFichaFondoDesktop
			,(select top 1 valor from EstrategiaDetalle where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10205) as ImgFondoMobile
			,(select top 1 valor from EstrategiaDetalle where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10206) as ImgSelloProductoMobile
			,(select top 1 valor from EstrategiaDetalle where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10207) as UrlVideoMobile
			,(select top 1 valor from EstrategiaDetalle where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10209) as ImgFichaFondoMobile			
		FROM @OFERTAS as T
		GROUP BY EstrategiaID

	DECLARE @tablaCuvUnicos table (CUV varchar(6), Id uniqueIdentifier)

	insert into @tablaCuvUnicos
	select CUV2, NULL from @OFERTAS
	group by CUV2

	update @tablaCuvUnicos
	set Id = (SELECT TOP 1 B.ColId FROM @OFERTAS B WHERE B.CUV2 = A.CUV)
	FROM @tablaCuvUnicos A

	DELETE B 
	FROM @OFERTAS B
	LEFT JOIN @tablaCuvUnicos A
		ON B.CUV2 = A.CUV AND B.ColId = A.Id
	 WHERE A.CUV IS NULL	 

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
		M.Descripcion as DescripcionMarca,
		'NO DISPONIBLE' AS DescripcionCategoria,
		T.FlagNueva, -- R2621
		T.TipoTallaColor,
		T.TipoEstrategiaImagenMostrar,
		T.CodigoProducto
		, T.EtiquetaID		-- SB20-351
		, T.EtiquetaID2		-- SB20-351
		, T.CodigoEstrategia
		, T.TieneVariedad
		, T.CODIGO
		, T.DescripcionEstrategia
		, T.FlagMostrarImg
		, D.ImgFondoDesktop
		, D.ImgPrevDesktop
		, D.ImgSelloProductoDesktop as ImgFichaDesktop
		, D.UrlVideoDesktop 
		, D.ImgFichaFondoDesktop 
		, D.ImgFondoMobile 
		, D.ImgSelloProductoMobile as ImgFichaMobile
		, D.UrlVideoMobile 
		, D.ImgFichaFondoMobile
		, RTRIM(SP.CodigoGenerico) AS CodigoGenerico
		, ISNULL(PC.CantAprobados,0) AS CantComenAprob
		, ISNULL(PC.CantRecomendados,0) AS CantComenRecom
		, ISNULL(PC.PromValorizado,0) AS PromValorizado
	FROM @OFERTAS T
	LEFT JOIN Marca M ON M.MarcaId = T.MarcaId
	LEFT JOIN @temp D ON D.EstrategiaID = T.EstrategiaID
	LEFT JOIN ods.SAP_PRODUCTO SP ON T.CodigoProducto = SP.CodigoSap AND ISNULL(SP.CodigoGenerico,'') <> ''
	LEFT JOIN ProductoComentario PC on T.CodigoProducto = PC.CodigoSap AND PC.Estado = 1
	ORDER BY
	Orden1 ASC, CASE WHEN ISNULL(T.Orden2,0) = 0 THEN T.Orden1 ELSE T.Orden2 END ASC, EstrategiaID ASC

	--DROP TABLE @OFERTAS
	SET NOCOUNT OFF
END
GO

USE BelcorpColombia
GO

ALTER PROCEDURE [dbo].[ListarOfertasMasVendidos]
	@CampaniaID INT,
	@ConsultoraID VARCHAR(30),
	@ZonaID VARCHAR(20)
AS
/*
	ListarOfertasMasVendidos 201710, '49409307', '2228' --035708669
	ListarOfertasMasVendidos 201710, '2', '2161' --000758833
*/
BEGIN
	SET NOCOUNT ON;
		
	DECLARE @tablaCuvPedido table (CUV varchar(6))
	insert into @tablaCuvPedido
	SELECT CUV
	FROM PedidoWebDetalle with(nolock)
	WHERE CampaniaID=@CampaniaID and ConsultoraID=@ConsultoraID

	DECLARE @CodigoConsultora VARCHAR(25)
	DECLARE @NumeroPedido INT

	SELECT
		@NumeroPedido = consecutivonueva + 1,
		@CodigoConsultora = codigo
	FROM ods.Consultora
	WHERE
		ConsultoraID=@ConsultoraID
	
	DECLARE @TieneOfertas BIT
	SET @TieneOfertas = 0
	--validar si tiene ofertas , sino obtener del generico
	IF EXISTS (SELECT 1 FROM  ods.ofertaspersonalizadas op  WHERE op.CodConsultora= @CodigoConsultora AND op.AnioCampanaVenta= @CampaniaID AND op.TipoPersonalizacion= 'BS')
		SET @TieneOfertas = 1

	PRINT @TieneOfertas
	-- Obtener estrategias de recomendadas para ti.
	declare @CodigoRegion varchar(2) = null
	declare @CodigoZona varchar(4) = null
	select @CodigoRegion = r.Codigo, @CodigoZona = z.Codigo
	from ods.Zona z
	inner join ods.Region r on
		z.RegionId = r.RegionId
	where ZonaId = @ZonaID

	DECLARE @tablaCuvFaltante TABLE (CUV VARCHAR(6))

	insert into @tablaCuvFaltante
	select
		distinct ltrim(rtrim(CUV))
	from dbo.ProductoFaltante nolock
	where
		CampaniaID = @CampaniaID and Zonaid = @ZonaID
	UNION ALL
	select
		distinct ltrim(rtrim(fa.CodigoVenta)) AS CUV
	from ods.FaltanteAnunciado fa (nolock)
	inner join ods.Campania c (nolock) on
		fa.CampaniaID = c.CampaniaID
	where
		c.Codigo = @CampaniaID
		and (rtrim(fa.CodigoRegion) = @CodigoRegion or fa.CodigoRegion IS NULL)
		and (rtrim(fa.CodigoZona) = @CodigoZona or fa.CodigoZona IS NULL)

	DECLARE @OFERTAS TABLE (
		ColId UNIQUEIDENTIFIER,
		EstrategiaID INT,
		CUV2 VARCHAR(20),
		DescripcionCUV2 VARCHAR(800),
		EtiquetaDescripcion VARCHAR(8000),
		Precio NUMERIC(12,2),
		EtiquetaDescripcion2 VARCHAR(8000),
		Precio2 NUMERIC(12,2),
		TextoLibre VARCHAR(800),
		FlagEstrella BIT,
		ColorFondo VARCHAR(20),
		TipoEstrategiaID INT,
		FotoProducto01 VARCHAR(800),
		ImagenURL VARCHAR(500),
		LimiteVenta INT,
		MarcaID INT,
		Orden1 INT,
		Orden2 INT,
		IndicadorMontoMinimo INT,
		CodigoProducto VARCHAR(12),
		FlagNueva INT,
		TipoTallaColor VARCHAR(4),
		TipoEstrategiaImagenMostrar INT,
		EtiquetaID INT,
		EtiquetaID2 INT,
		CodigoEstrategia VARCHAR(100),
		TieneVariedad INT,
		CODIGO VARCHAR(100),
		DescripcionEstrategia VARCHAR(200),
		FlagMostrarImg TINYINT
	) 

	IF @TieneOfertas = 1
	BEGIN
		INSERT INTO @OFERTAS
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
		0 AS FlagNueva, -- R2621
		dbo.fn_ObtenerTallaColorCuv_SB2(E.CUV2,@CampaniaID) as TipoTallaColor,
		3 as TipoEstrategiaImagenMostrar	--Oferta para Ti
		, E.EtiquetaID		-- SB20-351
		, E.EtiquetaID2		-- SB20-351
		, E.CodigoEstrategia
		, E.TieneVariedad		
		, TE.CODIGO
		, TE.DescripcionEstrategia AS DescripcionEstrategia
		, ISNULL(TE.FlagMostrarImg,0) AS FlagMostrarImg
		FROM Estrategia E
		INNER JOIN TipoEstrategia TE ON E.TipoEstrategiaID = TE.TipoEstrategiaID AND TE.FlagActivo = 1 AND TE.Codigo = '020'
		INNER JOIN ods.Campania ca ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.OfertasPersonalizadas op ON CA.Codigo = op.AnioCampanaVenta AND E.CUV2 = op.CUV AND op.TipoPersonalizacion = 'BS'
		INNER JOIN ods.Consultora c ON op.CodConsultora = c.Codigo
		INNER JOIN ods.ProductoComercial PC ON CA.CampaniaID = PC.CampaniaID AND E.CUV2 = PC.CUV
		WHERE
			E.Activo = 1
			AND ca.Codigo = @CampaniaID
			AND c.ConsultoraID = @ConsultoraID
			AND E.Zona LIKE '%' + @ZonaID + '%'
			--AND TE.FlagActivo = 1
			AND TE.flagRecoPerfil = 1
			AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
		ORDER BY CASE WHEN ISNULL(op.Orden,0) = 0 THEN te.Orden ELSE op.Orden END ASC
	END
	ELSE 
	BEGIN
		DECLARE @ConsultoraGenerica VARCHAR(50) = ''
		SELECT @ConsultoraGenerica = Codigo FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10001

		INSERT INTO @OFERTAS
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
		0 AS FlagNueva, -- R2621
		dbo.fn_ObtenerTallaColorCuv_SB2(E.CUV2,@CampaniaID) as TipoTallaColor,
		3 as TipoEstrategiaImagenMostrar	--Oferta para Ti
		, E.EtiquetaID		-- SB20-351
		, E.EtiquetaID2		-- SB20-351
		, E.CodigoEstrategia
		, E.TieneVariedad		
		, TE.CODIGO
		, TE.DescripcionEstrategia AS DescripcionEstrategia
		, ISNULL(TE.FlagMostrarImg,0) AS FlagMostrarImg
		FROM Estrategia E
		INNER JOIN TipoEstrategia TE ON E.TipoEstrategiaID = TE.TipoEstrategiaID AND TE.Codigo='020'
		INNER JOIN ods.Campania ca ON CA.Codigo = e.campaniaid
		INNER JOIN ods.OfertasPersonalizadas op ON E.CUV2 = op.CUV and op.AnioCampanaVenta = CA.Codigo AND op.TipoPersonalizacion = 'BS'
		INNER JOIN ods.ProductoComercial PC ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		WHERE
			E.Activo = 1
			AND ca.Codigo = @CampaniaID
			AND op.CodConsultora = @ConsultoraGenerica
			AND E.Zona LIKE '%' + @ZonaID + '%'
			AND TE.FlagActivo = 1
			AND TE.flagRecoPerfil = 1
			AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
		ORDER BY CASE WHEN ISNULL(op.Orden,0) = 0 THEN te.Orden ELSE op.Orden END ASC
	END

	DECLARE @TEMP TABLE (
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

	INSERT INTO @temp 
		SELECT EstrategiaID
			,(select top 1 valor from EstrategiaDetalle where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10201) as ImgFondoDesktop
			,(select top 1 valor from EstrategiaDetalle where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10202) as ImgPrevDesktop
			,(select top 1 valor from EstrategiaDetalle where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10203) as ImgSelloProductoDesktop
			,(select top 1 valor from EstrategiaDetalle where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10204) as UrlVideoDesktop
			,(select top 1 valor from EstrategiaDetalle where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10208) as ImgFichaFondoDesktop
			,(select top 1 valor from EstrategiaDetalle where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10205) as ImgFondoMobile
			,(select top 1 valor from EstrategiaDetalle where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10206) as ImgSelloProductoMobile
			,(select top 1 valor from EstrategiaDetalle where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10207) as UrlVideoMobile
			,(select top 1 valor from EstrategiaDetalle where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10209) as ImgFichaFondoMobile			
		FROM @OFERTAS as T
		GROUP BY EstrategiaID

	DECLARE @tablaCuvUnicos table (CUV varchar(6), Id uniqueIdentifier)

	insert into @tablaCuvUnicos
	select CUV2, NULL from @OFERTAS
	group by CUV2

	update @tablaCuvUnicos
	set Id = (SELECT TOP 1 B.ColId FROM @OFERTAS B WHERE B.CUV2 = A.CUV)
	FROM @tablaCuvUnicos A

	DELETE B 
	FROM @OFERTAS B
	LEFT JOIN @tablaCuvUnicos A
		ON B.CUV2 = A.CUV AND B.ColId = A.Id
	 WHERE A.CUV IS NULL	 

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
		M.Descripcion as DescripcionMarca,
		'NO DISPONIBLE' AS DescripcionCategoria,
		T.FlagNueva, -- R2621
		T.TipoTallaColor,
		T.TipoEstrategiaImagenMostrar,
		T.CodigoProducto
		, T.EtiquetaID		-- SB20-351
		, T.EtiquetaID2		-- SB20-351
		, T.CodigoEstrategia
		, T.TieneVariedad
		, T.CODIGO
		, T.DescripcionEstrategia
		, T.FlagMostrarImg
		, D.ImgFondoDesktop
		, D.ImgPrevDesktop
		, D.ImgSelloProductoDesktop as ImgFichaDesktop
		, D.UrlVideoDesktop 
		, D.ImgFichaFondoDesktop 
		, D.ImgFondoMobile 
		, D.ImgSelloProductoMobile as ImgFichaMobile
		, D.UrlVideoMobile 
		, D.ImgFichaFondoMobile
		, RTRIM(SP.CodigoGenerico) AS CodigoGenerico
		, ISNULL(PC.CantAprobados,0) AS CantComenAprob
		, ISNULL(PC.CantRecomendados,0) AS CantComenRecom
		, ISNULL(PC.PromValorizado,0) AS PromValorizado
	FROM @OFERTAS T
	LEFT JOIN Marca M ON M.MarcaId = T.MarcaId
	LEFT JOIN @temp D ON D.EstrategiaID = T.EstrategiaID
	LEFT JOIN ods.SAP_PRODUCTO SP ON T.CodigoProducto = SP.CodigoSap AND ISNULL(SP.CodigoGenerico,'') <> ''
	LEFT JOIN ProductoComentario PC on T.CodigoProducto = PC.CodigoSap AND PC.Estado = 1
	ORDER BY
	Orden1 ASC, CASE WHEN ISNULL(T.Orden2,0) = 0 THEN T.Orden1 ELSE T.Orden2 END ASC, EstrategiaID ASC

	--DROP TABLE @OFERTAS
	SET NOCOUNT OFF
END
GO

USE BelcorpSalvador
GO

ALTER PROCEDURE [dbo].[ListarOfertasMasVendidos]
	@CampaniaID INT,
	@ConsultoraID VARCHAR(30),
	@ZonaID VARCHAR(20)
AS
/*
	ListarOfertasMasVendidos 201710, '49409307', '2228' --035708669
	ListarOfertasMasVendidos 201710, '2', '2161' --000758833
*/
BEGIN
	SET NOCOUNT ON;
		
	DECLARE @tablaCuvPedido table (CUV varchar(6))
	insert into @tablaCuvPedido
	SELECT CUV
	FROM PedidoWebDetalle with(nolock)
	WHERE CampaniaID=@CampaniaID and ConsultoraID=@ConsultoraID

	DECLARE @CodigoConsultora VARCHAR(25)
	DECLARE @NumeroPedido INT

	SELECT
		@NumeroPedido = consecutivonueva + 1,
		@CodigoConsultora = codigo
	FROM ods.Consultora
	WHERE
		ConsultoraID=@ConsultoraID
	
	DECLARE @TieneOfertas BIT
	SET @TieneOfertas = 0
	--validar si tiene ofertas , sino obtener del generico
	IF EXISTS (SELECT 1 FROM  ods.ofertaspersonalizadas op  WHERE op.CodConsultora= @CodigoConsultora AND op.AnioCampanaVenta= @CampaniaID AND op.TipoPersonalizacion= 'BS')
		SET @TieneOfertas = 1

	PRINT @TieneOfertas
	-- Obtener estrategias de recomendadas para ti.
	declare @CodigoRegion varchar(2) = null
	declare @CodigoZona varchar(4) = null
	select @CodigoRegion = r.Codigo, @CodigoZona = z.Codigo
	from ods.Zona z
	inner join ods.Region r on
		z.RegionId = r.RegionId
	where ZonaId = @ZonaID

	DECLARE @tablaCuvFaltante TABLE (CUV VARCHAR(6))

	insert into @tablaCuvFaltante
	select
		distinct ltrim(rtrim(CUV))
	from dbo.ProductoFaltante nolock
	where
		CampaniaID = @CampaniaID and Zonaid = @ZonaID
	UNION ALL
	select
		distinct ltrim(rtrim(fa.CodigoVenta)) AS CUV
	from ods.FaltanteAnunciado fa (nolock)
	inner join ods.Campania c (nolock) on
		fa.CampaniaID = c.CampaniaID
	where
		c.Codigo = @CampaniaID
		and (rtrim(fa.CodigoRegion) = @CodigoRegion or fa.CodigoRegion IS NULL)
		and (rtrim(fa.CodigoZona) = @CodigoZona or fa.CodigoZona IS NULL)

	DECLARE @OFERTAS TABLE (
		ColId UNIQUEIDENTIFIER,
		EstrategiaID INT,
		CUV2 VARCHAR(20),
		DescripcionCUV2 VARCHAR(800),
		EtiquetaDescripcion VARCHAR(8000),
		Precio NUMERIC(12,2),
		EtiquetaDescripcion2 VARCHAR(8000),
		Precio2 NUMERIC(12,2),
		TextoLibre VARCHAR(800),
		FlagEstrella BIT,
		ColorFondo VARCHAR(20),
		TipoEstrategiaID INT,
		FotoProducto01 VARCHAR(800),
		ImagenURL VARCHAR(500),
		LimiteVenta INT,
		MarcaID INT,
		Orden1 INT,
		Orden2 INT,
		IndicadorMontoMinimo INT,
		CodigoProducto VARCHAR(12),
		FlagNueva INT,
		TipoTallaColor VARCHAR(4),
		TipoEstrategiaImagenMostrar INT,
		EtiquetaID INT,
		EtiquetaID2 INT,
		CodigoEstrategia VARCHAR(100),
		TieneVariedad INT,
		CODIGO VARCHAR(100),
		DescripcionEstrategia VARCHAR(200),
		FlagMostrarImg TINYINT
	) 

	IF @TieneOfertas = 1
	BEGIN
		INSERT INTO @OFERTAS
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
		0 AS FlagNueva, -- R2621
		dbo.fn_ObtenerTallaColorCuv_SB2(E.CUV2,@CampaniaID) as TipoTallaColor,
		3 as TipoEstrategiaImagenMostrar	--Oferta para Ti
		, E.EtiquetaID		-- SB20-351
		, E.EtiquetaID2		-- SB20-351
		, E.CodigoEstrategia
		, E.TieneVariedad		
		, TE.CODIGO
		, TE.DescripcionEstrategia AS DescripcionEstrategia
		, ISNULL(TE.FlagMostrarImg,0) AS FlagMostrarImg
		FROM Estrategia E
		INNER JOIN TipoEstrategia TE ON E.TipoEstrategiaID = TE.TipoEstrategiaID AND TE.FlagActivo = 1 AND TE.Codigo = '020'
		INNER JOIN ods.Campania ca ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.OfertasPersonalizadas op ON CA.Codigo = op.AnioCampanaVenta AND E.CUV2 = op.CUV AND op.TipoPersonalizacion = 'BS'
		INNER JOIN ods.Consultora c ON op.CodConsultora = c.Codigo
		INNER JOIN ods.ProductoComercial PC ON CA.CampaniaID = PC.CampaniaID AND E.CUV2 = PC.CUV
		WHERE
			E.Activo = 1
			AND ca.Codigo = @CampaniaID
			AND c.ConsultoraID = @ConsultoraID
			AND E.Zona LIKE '%' + @ZonaID + '%'
			--AND TE.FlagActivo = 1
			AND TE.flagRecoPerfil = 1
			AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
		ORDER BY CASE WHEN ISNULL(op.Orden,0) = 0 THEN te.Orden ELSE op.Orden END ASC
	END
	ELSE 
	BEGIN
		DECLARE @ConsultoraGenerica VARCHAR(50) = ''
		SELECT @ConsultoraGenerica = Codigo FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10001

		INSERT INTO @OFERTAS
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
		0 AS FlagNueva, -- R2621
		dbo.fn_ObtenerTallaColorCuv_SB2(E.CUV2,@CampaniaID) as TipoTallaColor,
		3 as TipoEstrategiaImagenMostrar	--Oferta para Ti
		, E.EtiquetaID		-- SB20-351
		, E.EtiquetaID2		-- SB20-351
		, E.CodigoEstrategia
		, E.TieneVariedad		
		, TE.CODIGO
		, TE.DescripcionEstrategia AS DescripcionEstrategia
		, ISNULL(TE.FlagMostrarImg,0) AS FlagMostrarImg
		FROM Estrategia E
		INNER JOIN TipoEstrategia TE ON E.TipoEstrategiaID = TE.TipoEstrategiaID AND TE.Codigo='020'
		INNER JOIN ods.Campania ca ON CA.Codigo = e.campaniaid
		INNER JOIN ods.OfertasPersonalizadas op ON E.CUV2 = op.CUV and op.AnioCampanaVenta = CA.Codigo AND op.TipoPersonalizacion = 'BS'
		INNER JOIN ods.ProductoComercial PC ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		WHERE
			E.Activo = 1
			AND ca.Codigo = @CampaniaID
			AND op.CodConsultora = @ConsultoraGenerica
			AND E.Zona LIKE '%' + @ZonaID + '%'
			AND TE.FlagActivo = 1
			AND TE.flagRecoPerfil = 1
			AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
		ORDER BY CASE WHEN ISNULL(op.Orden,0) = 0 THEN te.Orden ELSE op.Orden END ASC
	END

	DECLARE @TEMP TABLE (
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

	INSERT INTO @temp 
		SELECT EstrategiaID
			,(select top 1 valor from EstrategiaDetalle where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10201) as ImgFondoDesktop
			,(select top 1 valor from EstrategiaDetalle where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10202) as ImgPrevDesktop
			,(select top 1 valor from EstrategiaDetalle where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10203) as ImgSelloProductoDesktop
			,(select top 1 valor from EstrategiaDetalle where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10204) as UrlVideoDesktop
			,(select top 1 valor from EstrategiaDetalle where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10208) as ImgFichaFondoDesktop
			,(select top 1 valor from EstrategiaDetalle where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10205) as ImgFondoMobile
			,(select top 1 valor from EstrategiaDetalle where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10206) as ImgSelloProductoMobile
			,(select top 1 valor from EstrategiaDetalle where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10207) as UrlVideoMobile
			,(select top 1 valor from EstrategiaDetalle where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10209) as ImgFichaFondoMobile			
		FROM @OFERTAS as T
		GROUP BY EstrategiaID

	DECLARE @tablaCuvUnicos table (CUV varchar(6), Id uniqueIdentifier)

	insert into @tablaCuvUnicos
	select CUV2, NULL from @OFERTAS
	group by CUV2

	update @tablaCuvUnicos
	set Id = (SELECT TOP 1 B.ColId FROM @OFERTAS B WHERE B.CUV2 = A.CUV)
	FROM @tablaCuvUnicos A

	DELETE B 
	FROM @OFERTAS B
	LEFT JOIN @tablaCuvUnicos A
		ON B.CUV2 = A.CUV AND B.ColId = A.Id
	 WHERE A.CUV IS NULL	 

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
		M.Descripcion as DescripcionMarca,
		'NO DISPONIBLE' AS DescripcionCategoria,
		T.FlagNueva, -- R2621
		T.TipoTallaColor,
		T.TipoEstrategiaImagenMostrar,
		T.CodigoProducto
		, T.EtiquetaID		-- SB20-351
		, T.EtiquetaID2		-- SB20-351
		, T.CodigoEstrategia
		, T.TieneVariedad
		, T.CODIGO
		, T.DescripcionEstrategia
		, T.FlagMostrarImg
		, D.ImgFondoDesktop
		, D.ImgPrevDesktop
		, D.ImgSelloProductoDesktop as ImgFichaDesktop
		, D.UrlVideoDesktop 
		, D.ImgFichaFondoDesktop 
		, D.ImgFondoMobile 
		, D.ImgSelloProductoMobile as ImgFichaMobile
		, D.UrlVideoMobile 
		, D.ImgFichaFondoMobile
		, RTRIM(SP.CodigoGenerico) AS CodigoGenerico
		, ISNULL(PC.CantAprobados,0) AS CantComenAprob
		, ISNULL(PC.CantRecomendados,0) AS CantComenRecom
		, ISNULL(PC.PromValorizado,0) AS PromValorizado
	FROM @OFERTAS T
	LEFT JOIN Marca M ON M.MarcaId = T.MarcaId
	LEFT JOIN @temp D ON D.EstrategiaID = T.EstrategiaID
	LEFT JOIN ods.SAP_PRODUCTO SP ON T.CodigoProducto = SP.CodigoSap AND ISNULL(SP.CodigoGenerico,'') <> ''
	LEFT JOIN ProductoComentario PC on T.CodigoProducto = PC.CodigoSap AND PC.Estado = 1
	ORDER BY
	Orden1 ASC, CASE WHEN ISNULL(T.Orden2,0) = 0 THEN T.Orden1 ELSE T.Orden2 END ASC, EstrategiaID ASC

	--DROP TABLE @OFERTAS
	SET NOCOUNT OFF
END
GO

USE BelcorpPuertoRico
GO

ALTER PROCEDURE [dbo].[ListarOfertasMasVendidos]
	@CampaniaID INT,
	@ConsultoraID VARCHAR(30),
	@ZonaID VARCHAR(20)
AS
/*
	ListarOfertasMasVendidos 201710, '49409307', '2228' --035708669
	ListarOfertasMasVendidos 201710, '2', '2161' --000758833
*/
BEGIN
	SET NOCOUNT ON;
		
	DECLARE @tablaCuvPedido table (CUV varchar(6))
	insert into @tablaCuvPedido
	SELECT CUV
	FROM PedidoWebDetalle with(nolock)
	WHERE CampaniaID=@CampaniaID and ConsultoraID=@ConsultoraID

	DECLARE @CodigoConsultora VARCHAR(25)
	DECLARE @NumeroPedido INT

	SELECT
		@NumeroPedido = consecutivonueva + 1,
		@CodigoConsultora = codigo
	FROM ods.Consultora
	WHERE
		ConsultoraID=@ConsultoraID
	
	DECLARE @TieneOfertas BIT
	SET @TieneOfertas = 0
	--validar si tiene ofertas , sino obtener del generico
	IF EXISTS (SELECT 1 FROM  ods.ofertaspersonalizadas op  WHERE op.CodConsultora= @CodigoConsultora AND op.AnioCampanaVenta= @CampaniaID AND op.TipoPersonalizacion= 'BS')
		SET @TieneOfertas = 1

	PRINT @TieneOfertas
	-- Obtener estrategias de recomendadas para ti.
	declare @CodigoRegion varchar(2) = null
	declare @CodigoZona varchar(4) = null
	select @CodigoRegion = r.Codigo, @CodigoZona = z.Codigo
	from ods.Zona z
	inner join ods.Region r on
		z.RegionId = r.RegionId
	where ZonaId = @ZonaID

	DECLARE @tablaCuvFaltante TABLE (CUV VARCHAR(6))

	insert into @tablaCuvFaltante
	select
		distinct ltrim(rtrim(CUV))
	from dbo.ProductoFaltante nolock
	where
		CampaniaID = @CampaniaID and Zonaid = @ZonaID
	UNION ALL
	select
		distinct ltrim(rtrim(fa.CodigoVenta)) AS CUV
	from ods.FaltanteAnunciado fa (nolock)
	inner join ods.Campania c (nolock) on
		fa.CampaniaID = c.CampaniaID
	where
		c.Codigo = @CampaniaID
		and (rtrim(fa.CodigoRegion) = @CodigoRegion or fa.CodigoRegion IS NULL)
		and (rtrim(fa.CodigoZona) = @CodigoZona or fa.CodigoZona IS NULL)

	DECLARE @OFERTAS TABLE (
		ColId UNIQUEIDENTIFIER,
		EstrategiaID INT,
		CUV2 VARCHAR(20),
		DescripcionCUV2 VARCHAR(800),
		EtiquetaDescripcion VARCHAR(8000),
		Precio NUMERIC(12,2),
		EtiquetaDescripcion2 VARCHAR(8000),
		Precio2 NUMERIC(12,2),
		TextoLibre VARCHAR(800),
		FlagEstrella BIT,
		ColorFondo VARCHAR(20),
		TipoEstrategiaID INT,
		FotoProducto01 VARCHAR(800),
		ImagenURL VARCHAR(500),
		LimiteVenta INT,
		MarcaID INT,
		Orden1 INT,
		Orden2 INT,
		IndicadorMontoMinimo INT,
		CodigoProducto VARCHAR(12),
		FlagNueva INT,
		TipoTallaColor VARCHAR(4),
		TipoEstrategiaImagenMostrar INT,
		EtiquetaID INT,
		EtiquetaID2 INT,
		CodigoEstrategia VARCHAR(100),
		TieneVariedad INT,
		CODIGO VARCHAR(100),
		DescripcionEstrategia VARCHAR(200),
		FlagMostrarImg TINYINT
	) 

	IF @TieneOfertas = 1
	BEGIN
		INSERT INTO @OFERTAS
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
		0 AS FlagNueva, -- R2621
		dbo.fn_ObtenerTallaColorCuv_SB2(E.CUV2,@CampaniaID) as TipoTallaColor,
		3 as TipoEstrategiaImagenMostrar	--Oferta para Ti
		, E.EtiquetaID		-- SB20-351
		, E.EtiquetaID2		-- SB20-351
		, E.CodigoEstrategia
		, E.TieneVariedad		
		, TE.CODIGO
		, TE.DescripcionEstrategia AS DescripcionEstrategia
		, ISNULL(TE.FlagMostrarImg,0) AS FlagMostrarImg
		FROM Estrategia E
		INNER JOIN TipoEstrategia TE ON E.TipoEstrategiaID = TE.TipoEstrategiaID AND TE.FlagActivo = 1 AND TE.Codigo = '020'
		INNER JOIN ods.Campania ca ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.OfertasPersonalizadas op ON CA.Codigo = op.AnioCampanaVenta AND E.CUV2 = op.CUV AND op.TipoPersonalizacion = 'BS'
		INNER JOIN ods.Consultora c ON op.CodConsultora = c.Codigo
		INNER JOIN ods.ProductoComercial PC ON CA.CampaniaID = PC.CampaniaID AND E.CUV2 = PC.CUV
		WHERE
			E.Activo = 1
			AND ca.Codigo = @CampaniaID
			AND c.ConsultoraID = @ConsultoraID
			AND E.Zona LIKE '%' + @ZonaID + '%'
			--AND TE.FlagActivo = 1
			AND TE.flagRecoPerfil = 1
			AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
		ORDER BY CASE WHEN ISNULL(op.Orden,0) = 0 THEN te.Orden ELSE op.Orden END ASC
	END
	ELSE 
	BEGIN
		DECLARE @ConsultoraGenerica VARCHAR(50) = ''
		SELECT @ConsultoraGenerica = Codigo FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10001

		INSERT INTO @OFERTAS
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
		0 AS FlagNueva, -- R2621
		dbo.fn_ObtenerTallaColorCuv_SB2(E.CUV2,@CampaniaID) as TipoTallaColor,
		3 as TipoEstrategiaImagenMostrar	--Oferta para Ti
		, E.EtiquetaID		-- SB20-351
		, E.EtiquetaID2		-- SB20-351
		, E.CodigoEstrategia
		, E.TieneVariedad		
		, TE.CODIGO
		, TE.DescripcionEstrategia AS DescripcionEstrategia
		, ISNULL(TE.FlagMostrarImg,0) AS FlagMostrarImg
		FROM Estrategia E
		INNER JOIN TipoEstrategia TE ON E.TipoEstrategiaID = TE.TipoEstrategiaID AND TE.Codigo='020'
		INNER JOIN ods.Campania ca ON CA.Codigo = e.campaniaid
		INNER JOIN ods.OfertasPersonalizadas op ON E.CUV2 = op.CUV and op.AnioCampanaVenta = CA.Codigo AND op.TipoPersonalizacion = 'BS'
		INNER JOIN ods.ProductoComercial PC ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		WHERE
			E.Activo = 1
			AND ca.Codigo = @CampaniaID
			AND op.CodConsultora = @ConsultoraGenerica
			AND E.Zona LIKE '%' + @ZonaID + '%'
			AND TE.FlagActivo = 1
			AND TE.flagRecoPerfil = 1
			AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
		ORDER BY CASE WHEN ISNULL(op.Orden,0) = 0 THEN te.Orden ELSE op.Orden END ASC
	END

	DECLARE @TEMP TABLE (
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

	INSERT INTO @temp 
		SELECT EstrategiaID
			,(select top 1 valor from EstrategiaDetalle where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10201) as ImgFondoDesktop
			,(select top 1 valor from EstrategiaDetalle where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10202) as ImgPrevDesktop
			,(select top 1 valor from EstrategiaDetalle where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10203) as ImgSelloProductoDesktop
			,(select top 1 valor from EstrategiaDetalle where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10204) as UrlVideoDesktop
			,(select top 1 valor from EstrategiaDetalle where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10208) as ImgFichaFondoDesktop
			,(select top 1 valor from EstrategiaDetalle where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10205) as ImgFondoMobile
			,(select top 1 valor from EstrategiaDetalle where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10206) as ImgSelloProductoMobile
			,(select top 1 valor from EstrategiaDetalle where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10207) as UrlVideoMobile
			,(select top 1 valor from EstrategiaDetalle where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10209) as ImgFichaFondoMobile			
		FROM @OFERTAS as T
		GROUP BY EstrategiaID

	DECLARE @tablaCuvUnicos table (CUV varchar(6), Id uniqueIdentifier)

	insert into @tablaCuvUnicos
	select CUV2, NULL from @OFERTAS
	group by CUV2

	update @tablaCuvUnicos
	set Id = (SELECT TOP 1 B.ColId FROM @OFERTAS B WHERE B.CUV2 = A.CUV)
	FROM @tablaCuvUnicos A

	DELETE B 
	FROM @OFERTAS B
	LEFT JOIN @tablaCuvUnicos A
		ON B.CUV2 = A.CUV AND B.ColId = A.Id
	 WHERE A.CUV IS NULL	 

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
		M.Descripcion as DescripcionMarca,
		'NO DISPONIBLE' AS DescripcionCategoria,
		T.FlagNueva, -- R2621
		T.TipoTallaColor,
		T.TipoEstrategiaImagenMostrar,
		T.CodigoProducto
		, T.EtiquetaID		-- SB20-351
		, T.EtiquetaID2		-- SB20-351
		, T.CodigoEstrategia
		, T.TieneVariedad
		, T.CODIGO
		, T.DescripcionEstrategia
		, T.FlagMostrarImg
		, D.ImgFondoDesktop
		, D.ImgPrevDesktop
		, D.ImgSelloProductoDesktop as ImgFichaDesktop
		, D.UrlVideoDesktop 
		, D.ImgFichaFondoDesktop 
		, D.ImgFondoMobile 
		, D.ImgSelloProductoMobile as ImgFichaMobile
		, D.UrlVideoMobile 
		, D.ImgFichaFondoMobile
		, RTRIM(SP.CodigoGenerico) AS CodigoGenerico
		, ISNULL(PC.CantAprobados,0) AS CantComenAprob
		, ISNULL(PC.CantRecomendados,0) AS CantComenRecom
		, ISNULL(PC.PromValorizado,0) AS PromValorizado
	FROM @OFERTAS T
	LEFT JOIN Marca M ON M.MarcaId = T.MarcaId
	LEFT JOIN @temp D ON D.EstrategiaID = T.EstrategiaID
	LEFT JOIN ods.SAP_PRODUCTO SP ON T.CodigoProducto = SP.CodigoSap AND ISNULL(SP.CodigoGenerico,'') <> ''
	LEFT JOIN ProductoComentario PC on T.CodigoProducto = PC.CodigoSap AND PC.Estado = 1
	ORDER BY
	Orden1 ASC, CASE WHEN ISNULL(T.Orden2,0) = 0 THEN T.Orden1 ELSE T.Orden2 END ASC, EstrategiaID ASC

	--DROP TABLE @OFERTAS
	SET NOCOUNT OFF
END
GO

USE BelcorpPanama
GO

ALTER PROCEDURE [dbo].[ListarOfertasMasVendidos]
	@CampaniaID INT,
	@ConsultoraID VARCHAR(30),
	@ZonaID VARCHAR(20)
AS
/*
	ListarOfertasMasVendidos 201710, '49409307', '2228' --035708669
	ListarOfertasMasVendidos 201710, '2', '2161' --000758833
*/
BEGIN
	SET NOCOUNT ON;
		
	DECLARE @tablaCuvPedido table (CUV varchar(6))
	insert into @tablaCuvPedido
	SELECT CUV
	FROM PedidoWebDetalle with(nolock)
	WHERE CampaniaID=@CampaniaID and ConsultoraID=@ConsultoraID

	DECLARE @CodigoConsultora VARCHAR(25)
	DECLARE @NumeroPedido INT

	SELECT
		@NumeroPedido = consecutivonueva + 1,
		@CodigoConsultora = codigo
	FROM ods.Consultora
	WHERE
		ConsultoraID=@ConsultoraID
	
	DECLARE @TieneOfertas BIT
	SET @TieneOfertas = 0
	--validar si tiene ofertas , sino obtener del generico
	IF EXISTS (SELECT 1 FROM  ods.ofertaspersonalizadas op  WHERE op.CodConsultora= @CodigoConsultora AND op.AnioCampanaVenta= @CampaniaID AND op.TipoPersonalizacion= 'BS')
		SET @TieneOfertas = 1

	PRINT @TieneOfertas
	-- Obtener estrategias de recomendadas para ti.
	declare @CodigoRegion varchar(2) = null
	declare @CodigoZona varchar(4) = null
	select @CodigoRegion = r.Codigo, @CodigoZona = z.Codigo
	from ods.Zona z
	inner join ods.Region r on
		z.RegionId = r.RegionId
	where ZonaId = @ZonaID

	DECLARE @tablaCuvFaltante TABLE (CUV VARCHAR(6))

	insert into @tablaCuvFaltante
	select
		distinct ltrim(rtrim(CUV))
	from dbo.ProductoFaltante nolock
	where
		CampaniaID = @CampaniaID and Zonaid = @ZonaID
	UNION ALL
	select
		distinct ltrim(rtrim(fa.CodigoVenta)) AS CUV
	from ods.FaltanteAnunciado fa (nolock)
	inner join ods.Campania c (nolock) on
		fa.CampaniaID = c.CampaniaID
	where
		c.Codigo = @CampaniaID
		and (rtrim(fa.CodigoRegion) = @CodigoRegion or fa.CodigoRegion IS NULL)
		and (rtrim(fa.CodigoZona) = @CodigoZona or fa.CodigoZona IS NULL)

	DECLARE @OFERTAS TABLE (
		ColId UNIQUEIDENTIFIER,
		EstrategiaID INT,
		CUV2 VARCHAR(20),
		DescripcionCUV2 VARCHAR(800),
		EtiquetaDescripcion VARCHAR(8000),
		Precio NUMERIC(12,2),
		EtiquetaDescripcion2 VARCHAR(8000),
		Precio2 NUMERIC(12,2),
		TextoLibre VARCHAR(800),
		FlagEstrella BIT,
		ColorFondo VARCHAR(20),
		TipoEstrategiaID INT,
		FotoProducto01 VARCHAR(800),
		ImagenURL VARCHAR(500),
		LimiteVenta INT,
		MarcaID INT,
		Orden1 INT,
		Orden2 INT,
		IndicadorMontoMinimo INT,
		CodigoProducto VARCHAR(12),
		FlagNueva INT,
		TipoTallaColor VARCHAR(4),
		TipoEstrategiaImagenMostrar INT,
		EtiquetaID INT,
		EtiquetaID2 INT,
		CodigoEstrategia VARCHAR(100),
		TieneVariedad INT,
		CODIGO VARCHAR(100),
		DescripcionEstrategia VARCHAR(200),
		FlagMostrarImg TINYINT
	) 

	IF @TieneOfertas = 1
	BEGIN
		INSERT INTO @OFERTAS
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
		0 AS FlagNueva, -- R2621
		dbo.fn_ObtenerTallaColorCuv_SB2(E.CUV2,@CampaniaID) as TipoTallaColor,
		3 as TipoEstrategiaImagenMostrar	--Oferta para Ti
		, E.EtiquetaID		-- SB20-351
		, E.EtiquetaID2		-- SB20-351
		, E.CodigoEstrategia
		, E.TieneVariedad		
		, TE.CODIGO
		, TE.DescripcionEstrategia AS DescripcionEstrategia
		, ISNULL(TE.FlagMostrarImg,0) AS FlagMostrarImg
		FROM Estrategia E
		INNER JOIN TipoEstrategia TE ON E.TipoEstrategiaID = TE.TipoEstrategiaID AND TE.FlagActivo = 1 AND TE.Codigo = '020'
		INNER JOIN ods.Campania ca ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.OfertasPersonalizadas op ON CA.Codigo = op.AnioCampanaVenta AND E.CUV2 = op.CUV AND op.TipoPersonalizacion = 'BS'
		INNER JOIN ods.Consultora c ON op.CodConsultora = c.Codigo
		INNER JOIN ods.ProductoComercial PC ON CA.CampaniaID = PC.CampaniaID AND E.CUV2 = PC.CUV
		WHERE
			E.Activo = 1
			AND ca.Codigo = @CampaniaID
			AND c.ConsultoraID = @ConsultoraID
			AND E.Zona LIKE '%' + @ZonaID + '%'
			--AND TE.FlagActivo = 1
			AND TE.flagRecoPerfil = 1
			AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
		ORDER BY CASE WHEN ISNULL(op.Orden,0) = 0 THEN te.Orden ELSE op.Orden END ASC
	END
	ELSE 
	BEGIN
		DECLARE @ConsultoraGenerica VARCHAR(50) = ''
		SELECT @ConsultoraGenerica = Codigo FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10001

		INSERT INTO @OFERTAS
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
		0 AS FlagNueva, -- R2621
		dbo.fn_ObtenerTallaColorCuv_SB2(E.CUV2,@CampaniaID) as TipoTallaColor,
		3 as TipoEstrategiaImagenMostrar	--Oferta para Ti
		, E.EtiquetaID		-- SB20-351
		, E.EtiquetaID2		-- SB20-351
		, E.CodigoEstrategia
		, E.TieneVariedad		
		, TE.CODIGO
		, TE.DescripcionEstrategia AS DescripcionEstrategia
		, ISNULL(TE.FlagMostrarImg,0) AS FlagMostrarImg
		FROM Estrategia E
		INNER JOIN TipoEstrategia TE ON E.TipoEstrategiaID = TE.TipoEstrategiaID AND TE.Codigo='020'
		INNER JOIN ods.Campania ca ON CA.Codigo = e.campaniaid
		INNER JOIN ods.OfertasPersonalizadas op ON E.CUV2 = op.CUV and op.AnioCampanaVenta = CA.Codigo AND op.TipoPersonalizacion = 'BS'
		INNER JOIN ods.ProductoComercial PC ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		WHERE
			E.Activo = 1
			AND ca.Codigo = @CampaniaID
			AND op.CodConsultora = @ConsultoraGenerica
			AND E.Zona LIKE '%' + @ZonaID + '%'
			AND TE.FlagActivo = 1
			AND TE.flagRecoPerfil = 1
			AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
		ORDER BY CASE WHEN ISNULL(op.Orden,0) = 0 THEN te.Orden ELSE op.Orden END ASC
	END

	DECLARE @TEMP TABLE (
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

	INSERT INTO @temp 
		SELECT EstrategiaID
			,(select top 1 valor from EstrategiaDetalle where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10201) as ImgFondoDesktop
			,(select top 1 valor from EstrategiaDetalle where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10202) as ImgPrevDesktop
			,(select top 1 valor from EstrategiaDetalle where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10203) as ImgSelloProductoDesktop
			,(select top 1 valor from EstrategiaDetalle where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10204) as UrlVideoDesktop
			,(select top 1 valor from EstrategiaDetalle where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10208) as ImgFichaFondoDesktop
			,(select top 1 valor from EstrategiaDetalle where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10205) as ImgFondoMobile
			,(select top 1 valor from EstrategiaDetalle where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10206) as ImgSelloProductoMobile
			,(select top 1 valor from EstrategiaDetalle where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10207) as UrlVideoMobile
			,(select top 1 valor from EstrategiaDetalle where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10209) as ImgFichaFondoMobile			
		FROM @OFERTAS as T
		GROUP BY EstrategiaID

	DECLARE @tablaCuvUnicos table (CUV varchar(6), Id uniqueIdentifier)

	insert into @tablaCuvUnicos
	select CUV2, NULL from @OFERTAS
	group by CUV2

	update @tablaCuvUnicos
	set Id = (SELECT TOP 1 B.ColId FROM @OFERTAS B WHERE B.CUV2 = A.CUV)
	FROM @tablaCuvUnicos A

	DELETE B 
	FROM @OFERTAS B
	LEFT JOIN @tablaCuvUnicos A
		ON B.CUV2 = A.CUV AND B.ColId = A.Id
	 WHERE A.CUV IS NULL	 

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
		M.Descripcion as DescripcionMarca,
		'NO DISPONIBLE' AS DescripcionCategoria,
		T.FlagNueva, -- R2621
		T.TipoTallaColor,
		T.TipoEstrategiaImagenMostrar,
		T.CodigoProducto
		, T.EtiquetaID		-- SB20-351
		, T.EtiquetaID2		-- SB20-351
		, T.CodigoEstrategia
		, T.TieneVariedad
		, T.CODIGO
		, T.DescripcionEstrategia
		, T.FlagMostrarImg
		, D.ImgFondoDesktop
		, D.ImgPrevDesktop
		, D.ImgSelloProductoDesktop as ImgFichaDesktop
		, D.UrlVideoDesktop 
		, D.ImgFichaFondoDesktop 
		, D.ImgFondoMobile 
		, D.ImgSelloProductoMobile as ImgFichaMobile
		, D.UrlVideoMobile 
		, D.ImgFichaFondoMobile
		, RTRIM(SP.CodigoGenerico) AS CodigoGenerico
		, ISNULL(PC.CantAprobados,0) AS CantComenAprob
		, ISNULL(PC.CantRecomendados,0) AS CantComenRecom
		, ISNULL(PC.PromValorizado,0) AS PromValorizado
	FROM @OFERTAS T
	LEFT JOIN Marca M ON M.MarcaId = T.MarcaId
	LEFT JOIN @temp D ON D.EstrategiaID = T.EstrategiaID
	LEFT JOIN ods.SAP_PRODUCTO SP ON T.CodigoProducto = SP.CodigoSap AND ISNULL(SP.CodigoGenerico,'') <> ''
	LEFT JOIN ProductoComentario PC on T.CodigoProducto = PC.CodigoSap AND PC.Estado = 1
	ORDER BY
	Orden1 ASC, CASE WHEN ISNULL(T.Orden2,0) = 0 THEN T.Orden1 ELSE T.Orden2 END ASC, EstrategiaID ASC

	--DROP TABLE @OFERTAS
	SET NOCOUNT OFF
END
GO

USE BelcorpGuatemala
GO

ALTER PROCEDURE [dbo].[ListarOfertasMasVendidos]
	@CampaniaID INT,
	@ConsultoraID VARCHAR(30),
	@ZonaID VARCHAR(20)
AS
/*
	ListarOfertasMasVendidos 201710, '49409307', '2228' --035708669
	ListarOfertasMasVendidos 201710, '2', '2161' --000758833
*/
BEGIN
	SET NOCOUNT ON;
		
	DECLARE @tablaCuvPedido table (CUV varchar(6))
	insert into @tablaCuvPedido
	SELECT CUV
	FROM PedidoWebDetalle with(nolock)
	WHERE CampaniaID=@CampaniaID and ConsultoraID=@ConsultoraID

	DECLARE @CodigoConsultora VARCHAR(25)
	DECLARE @NumeroPedido INT

	SELECT
		@NumeroPedido = consecutivonueva + 1,
		@CodigoConsultora = codigo
	FROM ods.Consultora
	WHERE
		ConsultoraID=@ConsultoraID
	
	DECLARE @TieneOfertas BIT
	SET @TieneOfertas = 0
	--validar si tiene ofertas , sino obtener del generico
	IF EXISTS (SELECT 1 FROM  ods.ofertaspersonalizadas op  WHERE op.CodConsultora= @CodigoConsultora AND op.AnioCampanaVenta= @CampaniaID AND op.TipoPersonalizacion= 'BS')
		SET @TieneOfertas = 1

	PRINT @TieneOfertas
	-- Obtener estrategias de recomendadas para ti.
	declare @CodigoRegion varchar(2) = null
	declare @CodigoZona varchar(4) = null
	select @CodigoRegion = r.Codigo, @CodigoZona = z.Codigo
	from ods.Zona z
	inner join ods.Region r on
		z.RegionId = r.RegionId
	where ZonaId = @ZonaID

	DECLARE @tablaCuvFaltante TABLE (CUV VARCHAR(6))

	insert into @tablaCuvFaltante
	select
		distinct ltrim(rtrim(CUV))
	from dbo.ProductoFaltante nolock
	where
		CampaniaID = @CampaniaID and Zonaid = @ZonaID
	UNION ALL
	select
		distinct ltrim(rtrim(fa.CodigoVenta)) AS CUV
	from ods.FaltanteAnunciado fa (nolock)
	inner join ods.Campania c (nolock) on
		fa.CampaniaID = c.CampaniaID
	where
		c.Codigo = @CampaniaID
		and (rtrim(fa.CodigoRegion) = @CodigoRegion or fa.CodigoRegion IS NULL)
		and (rtrim(fa.CodigoZona) = @CodigoZona or fa.CodigoZona IS NULL)

	DECLARE @OFERTAS TABLE (
		ColId UNIQUEIDENTIFIER,
		EstrategiaID INT,
		CUV2 VARCHAR(20),
		DescripcionCUV2 VARCHAR(800),
		EtiquetaDescripcion VARCHAR(8000),
		Precio NUMERIC(12,2),
		EtiquetaDescripcion2 VARCHAR(8000),
		Precio2 NUMERIC(12,2),
		TextoLibre VARCHAR(800),
		FlagEstrella BIT,
		ColorFondo VARCHAR(20),
		TipoEstrategiaID INT,
		FotoProducto01 VARCHAR(800),
		ImagenURL VARCHAR(500),
		LimiteVenta INT,
		MarcaID INT,
		Orden1 INT,
		Orden2 INT,
		IndicadorMontoMinimo INT,
		CodigoProducto VARCHAR(12),
		FlagNueva INT,
		TipoTallaColor VARCHAR(4),
		TipoEstrategiaImagenMostrar INT,
		EtiquetaID INT,
		EtiquetaID2 INT,
		CodigoEstrategia VARCHAR(100),
		TieneVariedad INT,
		CODIGO VARCHAR(100),
		DescripcionEstrategia VARCHAR(200),
		FlagMostrarImg TINYINT
	) 

	IF @TieneOfertas = 1
	BEGIN
		INSERT INTO @OFERTAS
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
		0 AS FlagNueva, -- R2621
		dbo.fn_ObtenerTallaColorCuv_SB2(E.CUV2,@CampaniaID) as TipoTallaColor,
		3 as TipoEstrategiaImagenMostrar	--Oferta para Ti
		, E.EtiquetaID		-- SB20-351
		, E.EtiquetaID2		-- SB20-351
		, E.CodigoEstrategia
		, E.TieneVariedad		
		, TE.CODIGO
		, TE.DescripcionEstrategia AS DescripcionEstrategia
		, ISNULL(TE.FlagMostrarImg,0) AS FlagMostrarImg
		FROM Estrategia E
		INNER JOIN TipoEstrategia TE ON E.TipoEstrategiaID = TE.TipoEstrategiaID AND TE.FlagActivo = 1 AND TE.Codigo = '020'
		INNER JOIN ods.Campania ca ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.OfertasPersonalizadas op ON CA.Codigo = op.AnioCampanaVenta AND E.CUV2 = op.CUV AND op.TipoPersonalizacion = 'BS'
		INNER JOIN ods.Consultora c ON op.CodConsultora = c.Codigo
		INNER JOIN ods.ProductoComercial PC ON CA.CampaniaID = PC.CampaniaID AND E.CUV2 = PC.CUV
		WHERE
			E.Activo = 1
			AND ca.Codigo = @CampaniaID
			AND c.ConsultoraID = @ConsultoraID
			AND E.Zona LIKE '%' + @ZonaID + '%'
			--AND TE.FlagActivo = 1
			AND TE.flagRecoPerfil = 1
			AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
		ORDER BY CASE WHEN ISNULL(op.Orden,0) = 0 THEN te.Orden ELSE op.Orden END ASC
	END
	ELSE 
	BEGIN
		DECLARE @ConsultoraGenerica VARCHAR(50) = ''
		SELECT @ConsultoraGenerica = Codigo FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10001

		INSERT INTO @OFERTAS
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
		0 AS FlagNueva, -- R2621
		dbo.fn_ObtenerTallaColorCuv_SB2(E.CUV2,@CampaniaID) as TipoTallaColor,
		3 as TipoEstrategiaImagenMostrar	--Oferta para Ti
		, E.EtiquetaID		-- SB20-351
		, E.EtiquetaID2		-- SB20-351
		, E.CodigoEstrategia
		, E.TieneVariedad		
		, TE.CODIGO
		, TE.DescripcionEstrategia AS DescripcionEstrategia
		, ISNULL(TE.FlagMostrarImg,0) AS FlagMostrarImg
		FROM Estrategia E
		INNER JOIN TipoEstrategia TE ON E.TipoEstrategiaID = TE.TipoEstrategiaID AND TE.Codigo='020'
		INNER JOIN ods.Campania ca ON CA.Codigo = e.campaniaid
		INNER JOIN ods.OfertasPersonalizadas op ON E.CUV2 = op.CUV and op.AnioCampanaVenta = CA.Codigo AND op.TipoPersonalizacion = 'BS'
		INNER JOIN ods.ProductoComercial PC ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		WHERE
			E.Activo = 1
			AND ca.Codigo = @CampaniaID
			AND op.CodConsultora = @ConsultoraGenerica
			AND E.Zona LIKE '%' + @ZonaID + '%'
			AND TE.FlagActivo = 1
			AND TE.flagRecoPerfil = 1
			AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
		ORDER BY CASE WHEN ISNULL(op.Orden,0) = 0 THEN te.Orden ELSE op.Orden END ASC
	END

	DECLARE @TEMP TABLE (
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

	INSERT INTO @temp 
		SELECT EstrategiaID
			,(select top 1 valor from EstrategiaDetalle where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10201) as ImgFondoDesktop
			,(select top 1 valor from EstrategiaDetalle where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10202) as ImgPrevDesktop
			,(select top 1 valor from EstrategiaDetalle where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10203) as ImgSelloProductoDesktop
			,(select top 1 valor from EstrategiaDetalle where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10204) as UrlVideoDesktop
			,(select top 1 valor from EstrategiaDetalle where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10208) as ImgFichaFondoDesktop
			,(select top 1 valor from EstrategiaDetalle where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10205) as ImgFondoMobile
			,(select top 1 valor from EstrategiaDetalle where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10206) as ImgSelloProductoMobile
			,(select top 1 valor from EstrategiaDetalle where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10207) as UrlVideoMobile
			,(select top 1 valor from EstrategiaDetalle where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10209) as ImgFichaFondoMobile			
		FROM @OFERTAS as T
		GROUP BY EstrategiaID

	DECLARE @tablaCuvUnicos table (CUV varchar(6), Id uniqueIdentifier)

	insert into @tablaCuvUnicos
	select CUV2, NULL from @OFERTAS
	group by CUV2

	update @tablaCuvUnicos
	set Id = (SELECT TOP 1 B.ColId FROM @OFERTAS B WHERE B.CUV2 = A.CUV)
	FROM @tablaCuvUnicos A

	DELETE B 
	FROM @OFERTAS B
	LEFT JOIN @tablaCuvUnicos A
		ON B.CUV2 = A.CUV AND B.ColId = A.Id
	 WHERE A.CUV IS NULL	 

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
		M.Descripcion as DescripcionMarca,
		'NO DISPONIBLE' AS DescripcionCategoria,
		T.FlagNueva, -- R2621
		T.TipoTallaColor,
		T.TipoEstrategiaImagenMostrar,
		T.CodigoProducto
		, T.EtiquetaID		-- SB20-351
		, T.EtiquetaID2		-- SB20-351
		, T.CodigoEstrategia
		, T.TieneVariedad
		, T.CODIGO
		, T.DescripcionEstrategia
		, T.FlagMostrarImg
		, D.ImgFondoDesktop
		, D.ImgPrevDesktop
		, D.ImgSelloProductoDesktop as ImgFichaDesktop
		, D.UrlVideoDesktop 
		, D.ImgFichaFondoDesktop 
		, D.ImgFondoMobile 
		, D.ImgSelloProductoMobile as ImgFichaMobile
		, D.UrlVideoMobile 
		, D.ImgFichaFondoMobile
		, RTRIM(SP.CodigoGenerico) AS CodigoGenerico
		, ISNULL(PC.CantAprobados,0) AS CantComenAprob
		, ISNULL(PC.CantRecomendados,0) AS CantComenRecom
		, ISNULL(PC.PromValorizado,0) AS PromValorizado
	FROM @OFERTAS T
	LEFT JOIN Marca M ON M.MarcaId = T.MarcaId
	LEFT JOIN @temp D ON D.EstrategiaID = T.EstrategiaID
	LEFT JOIN ods.SAP_PRODUCTO SP ON T.CodigoProducto = SP.CodigoSap AND ISNULL(SP.CodigoGenerico,'') <> ''
	LEFT JOIN ProductoComentario PC on T.CodigoProducto = PC.CodigoSap AND PC.Estado = 1
	ORDER BY
	Orden1 ASC, CASE WHEN ISNULL(T.Orden2,0) = 0 THEN T.Orden1 ELSE T.Orden2 END ASC, EstrategiaID ASC

	--DROP TABLE @OFERTAS
	SET NOCOUNT OFF
END
GO

USE BelcorpEcuador
GO

ALTER PROCEDURE [dbo].[ListarOfertasMasVendidos]
	@CampaniaID INT,
	@ConsultoraID VARCHAR(30),
	@ZonaID VARCHAR(20)
AS
/*
	ListarOfertasMasVendidos 201710, '49409307', '2228' --035708669
	ListarOfertasMasVendidos 201710, '2', '2161' --000758833
*/
BEGIN
	SET NOCOUNT ON;
		
	DECLARE @tablaCuvPedido table (CUV varchar(6))
	insert into @tablaCuvPedido
	SELECT CUV
	FROM PedidoWebDetalle with(nolock)
	WHERE CampaniaID=@CampaniaID and ConsultoraID=@ConsultoraID

	DECLARE @CodigoConsultora VARCHAR(25)
	DECLARE @NumeroPedido INT

	SELECT
		@NumeroPedido = consecutivonueva + 1,
		@CodigoConsultora = codigo
	FROM ods.Consultora
	WHERE
		ConsultoraID=@ConsultoraID
	
	DECLARE @TieneOfertas BIT
	SET @TieneOfertas = 0
	--validar si tiene ofertas , sino obtener del generico
	IF EXISTS (SELECT 1 FROM  ods.ofertaspersonalizadas op  WHERE op.CodConsultora= @CodigoConsultora AND op.AnioCampanaVenta= @CampaniaID AND op.TipoPersonalizacion= 'BS')
		SET @TieneOfertas = 1

	PRINT @TieneOfertas
	-- Obtener estrategias de recomendadas para ti.
	declare @CodigoRegion varchar(2) = null
	declare @CodigoZona varchar(4) = null
	select @CodigoRegion = r.Codigo, @CodigoZona = z.Codigo
	from ods.Zona z
	inner join ods.Region r on
		z.RegionId = r.RegionId
	where ZonaId = @ZonaID

	DECLARE @tablaCuvFaltante TABLE (CUV VARCHAR(6))

	insert into @tablaCuvFaltante
	select
		distinct ltrim(rtrim(CUV))
	from dbo.ProductoFaltante nolock
	where
		CampaniaID = @CampaniaID and Zonaid = @ZonaID
	UNION ALL
	select
		distinct ltrim(rtrim(fa.CodigoVenta)) AS CUV
	from ods.FaltanteAnunciado fa (nolock)
	inner join ods.Campania c (nolock) on
		fa.CampaniaID = c.CampaniaID
	where
		c.Codigo = @CampaniaID
		and (rtrim(fa.CodigoRegion) = @CodigoRegion or fa.CodigoRegion IS NULL)
		and (rtrim(fa.CodigoZona) = @CodigoZona or fa.CodigoZona IS NULL)

	DECLARE @OFERTAS TABLE (
		ColId UNIQUEIDENTIFIER,
		EstrategiaID INT,
		CUV2 VARCHAR(20),
		DescripcionCUV2 VARCHAR(800),
		EtiquetaDescripcion VARCHAR(8000),
		Precio NUMERIC(12,2),
		EtiquetaDescripcion2 VARCHAR(8000),
		Precio2 NUMERIC(12,2),
		TextoLibre VARCHAR(800),
		FlagEstrella BIT,
		ColorFondo VARCHAR(20),
		TipoEstrategiaID INT,
		FotoProducto01 VARCHAR(800),
		ImagenURL VARCHAR(500),
		LimiteVenta INT,
		MarcaID INT,
		Orden1 INT,
		Orden2 INT,
		IndicadorMontoMinimo INT,
		CodigoProducto VARCHAR(12),
		FlagNueva INT,
		TipoTallaColor VARCHAR(4),
		TipoEstrategiaImagenMostrar INT,
		EtiquetaID INT,
		EtiquetaID2 INT,
		CodigoEstrategia VARCHAR(100),
		TieneVariedad INT,
		CODIGO VARCHAR(100),
		DescripcionEstrategia VARCHAR(200),
		FlagMostrarImg TINYINT
	) 

	IF @TieneOfertas = 1
	BEGIN
		INSERT INTO @OFERTAS
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
		0 AS FlagNueva, -- R2621
		dbo.fn_ObtenerTallaColorCuv_SB2(E.CUV2,@CampaniaID) as TipoTallaColor,
		3 as TipoEstrategiaImagenMostrar	--Oferta para Ti
		, E.EtiquetaID		-- SB20-351
		, E.EtiquetaID2		-- SB20-351
		, E.CodigoEstrategia
		, E.TieneVariedad		
		, TE.CODIGO
		, TE.DescripcionEstrategia AS DescripcionEstrategia
		, ISNULL(TE.FlagMostrarImg,0) AS FlagMostrarImg
		FROM Estrategia E
		INNER JOIN TipoEstrategia TE ON E.TipoEstrategiaID = TE.TipoEstrategiaID AND TE.FlagActivo = 1 AND TE.Codigo = '020'
		INNER JOIN ods.Campania ca ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.OfertasPersonalizadas op ON CA.Codigo = op.AnioCampanaVenta AND E.CUV2 = op.CUV AND op.TipoPersonalizacion = 'BS'
		INNER JOIN ods.Consultora c ON op.CodConsultora = c.Codigo
		INNER JOIN ods.ProductoComercial PC ON CA.CampaniaID = PC.CampaniaID AND E.CUV2 = PC.CUV
		WHERE
			E.Activo = 1
			AND ca.Codigo = @CampaniaID
			AND c.ConsultoraID = @ConsultoraID
			AND E.Zona LIKE '%' + @ZonaID + '%'
			--AND TE.FlagActivo = 1
			AND TE.flagRecoPerfil = 1
			AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
		ORDER BY CASE WHEN ISNULL(op.Orden,0) = 0 THEN te.Orden ELSE op.Orden END ASC
	END
	ELSE 
	BEGIN
		DECLARE @ConsultoraGenerica VARCHAR(50) = ''
		SELECT @ConsultoraGenerica = Codigo FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10001

		INSERT INTO @OFERTAS
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
		0 AS FlagNueva, -- R2621
		dbo.fn_ObtenerTallaColorCuv_SB2(E.CUV2,@CampaniaID) as TipoTallaColor,
		3 as TipoEstrategiaImagenMostrar	--Oferta para Ti
		, E.EtiquetaID		-- SB20-351
		, E.EtiquetaID2		-- SB20-351
		, E.CodigoEstrategia
		, E.TieneVariedad		
		, TE.CODIGO
		, TE.DescripcionEstrategia AS DescripcionEstrategia
		, ISNULL(TE.FlagMostrarImg,0) AS FlagMostrarImg
		FROM Estrategia E
		INNER JOIN TipoEstrategia TE ON E.TipoEstrategiaID = TE.TipoEstrategiaID AND TE.Codigo='020'
		INNER JOIN ods.Campania ca ON CA.Codigo = e.campaniaid
		INNER JOIN ods.OfertasPersonalizadas op ON E.CUV2 = op.CUV and op.AnioCampanaVenta = CA.Codigo AND op.TipoPersonalizacion = 'BS'
		INNER JOIN ods.ProductoComercial PC ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		WHERE
			E.Activo = 1
			AND ca.Codigo = @CampaniaID
			AND op.CodConsultora = @ConsultoraGenerica
			AND E.Zona LIKE '%' + @ZonaID + '%'
			AND TE.FlagActivo = 1
			AND TE.flagRecoPerfil = 1
			AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
		ORDER BY CASE WHEN ISNULL(op.Orden,0) = 0 THEN te.Orden ELSE op.Orden END ASC
	END

	DECLARE @TEMP TABLE (
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

	INSERT INTO @temp 
		SELECT EstrategiaID
			,(select top 1 valor from EstrategiaDetalle where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10201) as ImgFondoDesktop
			,(select top 1 valor from EstrategiaDetalle where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10202) as ImgPrevDesktop
			,(select top 1 valor from EstrategiaDetalle where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10203) as ImgSelloProductoDesktop
			,(select top 1 valor from EstrategiaDetalle where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10204) as UrlVideoDesktop
			,(select top 1 valor from EstrategiaDetalle where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10208) as ImgFichaFondoDesktop
			,(select top 1 valor from EstrategiaDetalle where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10205) as ImgFondoMobile
			,(select top 1 valor from EstrategiaDetalle where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10206) as ImgSelloProductoMobile
			,(select top 1 valor from EstrategiaDetalle where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10207) as UrlVideoMobile
			,(select top 1 valor from EstrategiaDetalle where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10209) as ImgFichaFondoMobile			
		FROM @OFERTAS as T
		GROUP BY EstrategiaID

	DECLARE @tablaCuvUnicos table (CUV varchar(6), Id uniqueIdentifier)

	insert into @tablaCuvUnicos
	select CUV2, NULL from @OFERTAS
	group by CUV2

	update @tablaCuvUnicos
	set Id = (SELECT TOP 1 B.ColId FROM @OFERTAS B WHERE B.CUV2 = A.CUV)
	FROM @tablaCuvUnicos A

	DELETE B 
	FROM @OFERTAS B
	LEFT JOIN @tablaCuvUnicos A
		ON B.CUV2 = A.CUV AND B.ColId = A.Id
	 WHERE A.CUV IS NULL	 

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
		M.Descripcion as DescripcionMarca,
		'NO DISPONIBLE' AS DescripcionCategoria,
		T.FlagNueva, -- R2621
		T.TipoTallaColor,
		T.TipoEstrategiaImagenMostrar,
		T.CodigoProducto
		, T.EtiquetaID		-- SB20-351
		, T.EtiquetaID2		-- SB20-351
		, T.CodigoEstrategia
		, T.TieneVariedad
		, T.CODIGO
		, T.DescripcionEstrategia
		, T.FlagMostrarImg
		, D.ImgFondoDesktop
		, D.ImgPrevDesktop
		, D.ImgSelloProductoDesktop as ImgFichaDesktop
		, D.UrlVideoDesktop 
		, D.ImgFichaFondoDesktop 
		, D.ImgFondoMobile 
		, D.ImgSelloProductoMobile as ImgFichaMobile
		, D.UrlVideoMobile 
		, D.ImgFichaFondoMobile
		, RTRIM(SP.CodigoGenerico) AS CodigoGenerico
		, ISNULL(PC.CantAprobados,0) AS CantComenAprob
		, ISNULL(PC.CantRecomendados,0) AS CantComenRecom
		, ISNULL(PC.PromValorizado,0) AS PromValorizado
	FROM @OFERTAS T
	LEFT JOIN Marca M ON M.MarcaId = T.MarcaId
	LEFT JOIN @temp D ON D.EstrategiaID = T.EstrategiaID
	LEFT JOIN ods.SAP_PRODUCTO SP ON T.CodigoProducto = SP.CodigoSap AND ISNULL(SP.CodigoGenerico,'') <> ''
	LEFT JOIN ProductoComentario PC on T.CodigoProducto = PC.CodigoSap AND PC.Estado = 1
	ORDER BY
	Orden1 ASC, CASE WHEN ISNULL(T.Orden2,0) = 0 THEN T.Orden1 ELSE T.Orden2 END ASC, EstrategiaID ASC

	--DROP TABLE @OFERTAS
	SET NOCOUNT OFF
END
GO

USE BelcorpDominicana
GO

ALTER PROCEDURE [dbo].[ListarOfertasMasVendidos]
	@CampaniaID INT,
	@ConsultoraID VARCHAR(30),
	@ZonaID VARCHAR(20)
AS
/*
	ListarOfertasMasVendidos 201710, '49409307', '2228' --035708669
	ListarOfertasMasVendidos 201710, '2', '2161' --000758833
*/
BEGIN
	SET NOCOUNT ON;
		
	DECLARE @tablaCuvPedido table (CUV varchar(6))
	insert into @tablaCuvPedido
	SELECT CUV
	FROM PedidoWebDetalle with(nolock)
	WHERE CampaniaID=@CampaniaID and ConsultoraID=@ConsultoraID

	DECLARE @CodigoConsultora VARCHAR(25)
	DECLARE @NumeroPedido INT

	SELECT
		@NumeroPedido = consecutivonueva + 1,
		@CodigoConsultora = codigo
	FROM ods.Consultora
	WHERE
		ConsultoraID=@ConsultoraID
	
	DECLARE @TieneOfertas BIT
	SET @TieneOfertas = 0
	--validar si tiene ofertas , sino obtener del generico
	IF EXISTS (SELECT 1 FROM  ods.ofertaspersonalizadas op  WHERE op.CodConsultora= @CodigoConsultora AND op.AnioCampanaVenta= @CampaniaID AND op.TipoPersonalizacion= 'BS')
		SET @TieneOfertas = 1

	PRINT @TieneOfertas
	-- Obtener estrategias de recomendadas para ti.
	declare @CodigoRegion varchar(2) = null
	declare @CodigoZona varchar(4) = null
	select @CodigoRegion = r.Codigo, @CodigoZona = z.Codigo
	from ods.Zona z
	inner join ods.Region r on
		z.RegionId = r.RegionId
	where ZonaId = @ZonaID

	DECLARE @tablaCuvFaltante TABLE (CUV VARCHAR(6))

	insert into @tablaCuvFaltante
	select
		distinct ltrim(rtrim(CUV))
	from dbo.ProductoFaltante nolock
	where
		CampaniaID = @CampaniaID and Zonaid = @ZonaID
	UNION ALL
	select
		distinct ltrim(rtrim(fa.CodigoVenta)) AS CUV
	from ods.FaltanteAnunciado fa (nolock)
	inner join ods.Campania c (nolock) on
		fa.CampaniaID = c.CampaniaID
	where
		c.Codigo = @CampaniaID
		and (rtrim(fa.CodigoRegion) = @CodigoRegion or fa.CodigoRegion IS NULL)
		and (rtrim(fa.CodigoZona) = @CodigoZona or fa.CodigoZona IS NULL)

	DECLARE @OFERTAS TABLE (
		ColId UNIQUEIDENTIFIER,
		EstrategiaID INT,
		CUV2 VARCHAR(20),
		DescripcionCUV2 VARCHAR(800),
		EtiquetaDescripcion VARCHAR(8000),
		Precio NUMERIC(12,2),
		EtiquetaDescripcion2 VARCHAR(8000),
		Precio2 NUMERIC(12,2),
		TextoLibre VARCHAR(800),
		FlagEstrella BIT,
		ColorFondo VARCHAR(20),
		TipoEstrategiaID INT,
		FotoProducto01 VARCHAR(800),
		ImagenURL VARCHAR(500),
		LimiteVenta INT,
		MarcaID INT,
		Orden1 INT,
		Orden2 INT,
		IndicadorMontoMinimo INT,
		CodigoProducto VARCHAR(12),
		FlagNueva INT,
		TipoTallaColor VARCHAR(4),
		TipoEstrategiaImagenMostrar INT,
		EtiquetaID INT,
		EtiquetaID2 INT,
		CodigoEstrategia VARCHAR(100),
		TieneVariedad INT,
		CODIGO VARCHAR(100),
		DescripcionEstrategia VARCHAR(200),
		FlagMostrarImg TINYINT
	) 

	IF @TieneOfertas = 1
	BEGIN
		INSERT INTO @OFERTAS
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
		0 AS FlagNueva, -- R2621
		dbo.fn_ObtenerTallaColorCuv_SB2(E.CUV2,@CampaniaID) as TipoTallaColor,
		3 as TipoEstrategiaImagenMostrar	--Oferta para Ti
		, E.EtiquetaID		-- SB20-351
		, E.EtiquetaID2		-- SB20-351
		, E.CodigoEstrategia
		, E.TieneVariedad		
		, TE.CODIGO
		, TE.DescripcionEstrategia AS DescripcionEstrategia
		, ISNULL(TE.FlagMostrarImg,0) AS FlagMostrarImg
		FROM Estrategia E
		INNER JOIN TipoEstrategia TE ON E.TipoEstrategiaID = TE.TipoEstrategiaID AND TE.FlagActivo = 1 AND TE.Codigo = '020'
		INNER JOIN ods.Campania ca ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.OfertasPersonalizadas op ON CA.Codigo = op.AnioCampanaVenta AND E.CUV2 = op.CUV AND op.TipoPersonalizacion = 'BS'
		INNER JOIN ods.Consultora c ON op.CodConsultora = c.Codigo
		INNER JOIN ods.ProductoComercial PC ON CA.CampaniaID = PC.CampaniaID AND E.CUV2 = PC.CUV
		WHERE
			E.Activo = 1
			AND ca.Codigo = @CampaniaID
			AND c.ConsultoraID = @ConsultoraID
			AND E.Zona LIKE '%' + @ZonaID + '%'
			--AND TE.FlagActivo = 1
			AND TE.flagRecoPerfil = 1
			AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
		ORDER BY CASE WHEN ISNULL(op.Orden,0) = 0 THEN te.Orden ELSE op.Orden END ASC
	END
	ELSE 
	BEGIN
		DECLARE @ConsultoraGenerica VARCHAR(50) = ''
		SELECT @ConsultoraGenerica = Codigo FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10001

		INSERT INTO @OFERTAS
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
		0 AS FlagNueva, -- R2621
		dbo.fn_ObtenerTallaColorCuv_SB2(E.CUV2,@CampaniaID) as TipoTallaColor,
		3 as TipoEstrategiaImagenMostrar	--Oferta para Ti
		, E.EtiquetaID		-- SB20-351
		, E.EtiquetaID2		-- SB20-351
		, E.CodigoEstrategia
		, E.TieneVariedad		
		, TE.CODIGO
		, TE.DescripcionEstrategia AS DescripcionEstrategia
		, ISNULL(TE.FlagMostrarImg,0) AS FlagMostrarImg
		FROM Estrategia E
		INNER JOIN TipoEstrategia TE ON E.TipoEstrategiaID = TE.TipoEstrategiaID AND TE.Codigo='020'
		INNER JOIN ods.Campania ca ON CA.Codigo = e.campaniaid
		INNER JOIN ods.OfertasPersonalizadas op ON E.CUV2 = op.CUV and op.AnioCampanaVenta = CA.Codigo AND op.TipoPersonalizacion = 'BS'
		INNER JOIN ods.ProductoComercial PC ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		WHERE
			E.Activo = 1
			AND ca.Codigo = @CampaniaID
			AND op.CodConsultora = @ConsultoraGenerica
			AND E.Zona LIKE '%' + @ZonaID + '%'
			AND TE.FlagActivo = 1
			AND TE.flagRecoPerfil = 1
			AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
		ORDER BY CASE WHEN ISNULL(op.Orden,0) = 0 THEN te.Orden ELSE op.Orden END ASC
	END

	DECLARE @TEMP TABLE (
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

	INSERT INTO @temp 
		SELECT EstrategiaID
			,(select top 1 valor from EstrategiaDetalle where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10201) as ImgFondoDesktop
			,(select top 1 valor from EstrategiaDetalle where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10202) as ImgPrevDesktop
			,(select top 1 valor from EstrategiaDetalle where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10203) as ImgSelloProductoDesktop
			,(select top 1 valor from EstrategiaDetalle where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10204) as UrlVideoDesktop
			,(select top 1 valor from EstrategiaDetalle where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10208) as ImgFichaFondoDesktop
			,(select top 1 valor from EstrategiaDetalle where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10205) as ImgFondoMobile
			,(select top 1 valor from EstrategiaDetalle where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10206) as ImgSelloProductoMobile
			,(select top 1 valor from EstrategiaDetalle where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10207) as UrlVideoMobile
			,(select top 1 valor from EstrategiaDetalle where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10209) as ImgFichaFondoMobile			
		FROM @OFERTAS as T
		GROUP BY EstrategiaID

	DECLARE @tablaCuvUnicos table (CUV varchar(6), Id uniqueIdentifier)

	insert into @tablaCuvUnicos
	select CUV2, NULL from @OFERTAS
	group by CUV2

	update @tablaCuvUnicos
	set Id = (SELECT TOP 1 B.ColId FROM @OFERTAS B WHERE B.CUV2 = A.CUV)
	FROM @tablaCuvUnicos A

	DELETE B 
	FROM @OFERTAS B
	LEFT JOIN @tablaCuvUnicos A
		ON B.CUV2 = A.CUV AND B.ColId = A.Id
	 WHERE A.CUV IS NULL	 

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
		M.Descripcion as DescripcionMarca,
		'NO DISPONIBLE' AS DescripcionCategoria,
		T.FlagNueva, -- R2621
		T.TipoTallaColor,
		T.TipoEstrategiaImagenMostrar,
		T.CodigoProducto
		, T.EtiquetaID		-- SB20-351
		, T.EtiquetaID2		-- SB20-351
		, T.CodigoEstrategia
		, T.TieneVariedad
		, T.CODIGO
		, T.DescripcionEstrategia
		, T.FlagMostrarImg
		, D.ImgFondoDesktop
		, D.ImgPrevDesktop
		, D.ImgSelloProductoDesktop as ImgFichaDesktop
		, D.UrlVideoDesktop 
		, D.ImgFichaFondoDesktop 
		, D.ImgFondoMobile 
		, D.ImgSelloProductoMobile as ImgFichaMobile
		, D.UrlVideoMobile 
		, D.ImgFichaFondoMobile
		, RTRIM(SP.CodigoGenerico) AS CodigoGenerico
		, ISNULL(PC.CantAprobados,0) AS CantComenAprob
		, ISNULL(PC.CantRecomendados,0) AS CantComenRecom
		, ISNULL(PC.PromValorizado,0) AS PromValorizado
	FROM @OFERTAS T
	LEFT JOIN Marca M ON M.MarcaId = T.MarcaId
	LEFT JOIN @temp D ON D.EstrategiaID = T.EstrategiaID
	LEFT JOIN ods.SAP_PRODUCTO SP ON T.CodigoProducto = SP.CodigoSap AND ISNULL(SP.CodigoGenerico,'') <> ''
	LEFT JOIN ProductoComentario PC on T.CodigoProducto = PC.CodigoSap AND PC.Estado = 1
	ORDER BY
	Orden1 ASC, CASE WHEN ISNULL(T.Orden2,0) = 0 THEN T.Orden1 ELSE T.Orden2 END ASC, EstrategiaID ASC

	--DROP TABLE @OFERTAS
	SET NOCOUNT OFF
END
GO

USE BelcorpCostaRica
GO

ALTER PROCEDURE [dbo].[ListarOfertasMasVendidos]
	@CampaniaID INT,
	@ConsultoraID VARCHAR(30),
	@ZonaID VARCHAR(20)
AS
/*
	ListarOfertasMasVendidos 201710, '49409307', '2228' --035708669
	ListarOfertasMasVendidos 201710, '2', '2161' --000758833
*/
BEGIN
	SET NOCOUNT ON;
		
	DECLARE @tablaCuvPedido table (CUV varchar(6))
	insert into @tablaCuvPedido
	SELECT CUV
	FROM PedidoWebDetalle with(nolock)
	WHERE CampaniaID=@CampaniaID and ConsultoraID=@ConsultoraID

	DECLARE @CodigoConsultora VARCHAR(25)
	DECLARE @NumeroPedido INT

	SELECT
		@NumeroPedido = consecutivonueva + 1,
		@CodigoConsultora = codigo
	FROM ods.Consultora
	WHERE
		ConsultoraID=@ConsultoraID
	
	DECLARE @TieneOfertas BIT
	SET @TieneOfertas = 0
	--validar si tiene ofertas , sino obtener del generico
	IF EXISTS (SELECT 1 FROM  ods.ofertaspersonalizadas op  WHERE op.CodConsultora= @CodigoConsultora AND op.AnioCampanaVenta= @CampaniaID AND op.TipoPersonalizacion= 'BS')
		SET @TieneOfertas = 1

	PRINT @TieneOfertas
	-- Obtener estrategias de recomendadas para ti.
	declare @CodigoRegion varchar(2) = null
	declare @CodigoZona varchar(4) = null
	select @CodigoRegion = r.Codigo, @CodigoZona = z.Codigo
	from ods.Zona z
	inner join ods.Region r on
		z.RegionId = r.RegionId
	where ZonaId = @ZonaID

	DECLARE @tablaCuvFaltante TABLE (CUV VARCHAR(6))

	insert into @tablaCuvFaltante
	select
		distinct ltrim(rtrim(CUV))
	from dbo.ProductoFaltante nolock
	where
		CampaniaID = @CampaniaID and Zonaid = @ZonaID
	UNION ALL
	select
		distinct ltrim(rtrim(fa.CodigoVenta)) AS CUV
	from ods.FaltanteAnunciado fa (nolock)
	inner join ods.Campania c (nolock) on
		fa.CampaniaID = c.CampaniaID
	where
		c.Codigo = @CampaniaID
		and (rtrim(fa.CodigoRegion) = @CodigoRegion or fa.CodigoRegion IS NULL)
		and (rtrim(fa.CodigoZona) = @CodigoZona or fa.CodigoZona IS NULL)

	DECLARE @OFERTAS TABLE (
		ColId UNIQUEIDENTIFIER,
		EstrategiaID INT,
		CUV2 VARCHAR(20),
		DescripcionCUV2 VARCHAR(800),
		EtiquetaDescripcion VARCHAR(8000),
		Precio NUMERIC(12,2),
		EtiquetaDescripcion2 VARCHAR(8000),
		Precio2 NUMERIC(12,2),
		TextoLibre VARCHAR(800),
		FlagEstrella BIT,
		ColorFondo VARCHAR(20),
		TipoEstrategiaID INT,
		FotoProducto01 VARCHAR(800),
		ImagenURL VARCHAR(500),
		LimiteVenta INT,
		MarcaID INT,
		Orden1 INT,
		Orden2 INT,
		IndicadorMontoMinimo INT,
		CodigoProducto VARCHAR(12),
		FlagNueva INT,
		TipoTallaColor VARCHAR(4),
		TipoEstrategiaImagenMostrar INT,
		EtiquetaID INT,
		EtiquetaID2 INT,
		CodigoEstrategia VARCHAR(100),
		TieneVariedad INT,
		CODIGO VARCHAR(100),
		DescripcionEstrategia VARCHAR(200),
		FlagMostrarImg TINYINT
	) 

	IF @TieneOfertas = 1
	BEGIN
		INSERT INTO @OFERTAS
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
		0 AS FlagNueva, -- R2621
		dbo.fn_ObtenerTallaColorCuv_SB2(E.CUV2,@CampaniaID) as TipoTallaColor,
		3 as TipoEstrategiaImagenMostrar	--Oferta para Ti
		, E.EtiquetaID		-- SB20-351
		, E.EtiquetaID2		-- SB20-351
		, E.CodigoEstrategia
		, E.TieneVariedad		
		, TE.CODIGO
		, TE.DescripcionEstrategia AS DescripcionEstrategia
		, ISNULL(TE.FlagMostrarImg,0) AS FlagMostrarImg
		FROM Estrategia E
		INNER JOIN TipoEstrategia TE ON E.TipoEstrategiaID = TE.TipoEstrategiaID AND TE.FlagActivo = 1 AND TE.Codigo = '020'
		INNER JOIN ods.Campania ca ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.OfertasPersonalizadas op ON CA.Codigo = op.AnioCampanaVenta AND E.CUV2 = op.CUV AND op.TipoPersonalizacion = 'BS'
		INNER JOIN ods.Consultora c ON op.CodConsultora = c.Codigo
		INNER JOIN ods.ProductoComercial PC ON CA.CampaniaID = PC.CampaniaID AND E.CUV2 = PC.CUV
		WHERE
			E.Activo = 1
			AND ca.Codigo = @CampaniaID
			AND c.ConsultoraID = @ConsultoraID
			AND E.Zona LIKE '%' + @ZonaID + '%'
			--AND TE.FlagActivo = 1
			AND TE.flagRecoPerfil = 1
			AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
		ORDER BY CASE WHEN ISNULL(op.Orden,0) = 0 THEN te.Orden ELSE op.Orden END ASC
	END
	ELSE 
	BEGIN
		DECLARE @ConsultoraGenerica VARCHAR(50) = ''
		SELECT @ConsultoraGenerica = Codigo FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10001

		INSERT INTO @OFERTAS
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
		0 AS FlagNueva, -- R2621
		dbo.fn_ObtenerTallaColorCuv_SB2(E.CUV2,@CampaniaID) as TipoTallaColor,
		3 as TipoEstrategiaImagenMostrar	--Oferta para Ti
		, E.EtiquetaID		-- SB20-351
		, E.EtiquetaID2		-- SB20-351
		, E.CodigoEstrategia
		, E.TieneVariedad		
		, TE.CODIGO
		, TE.DescripcionEstrategia AS DescripcionEstrategia
		, ISNULL(TE.FlagMostrarImg,0) AS FlagMostrarImg
		FROM Estrategia E
		INNER JOIN TipoEstrategia TE ON E.TipoEstrategiaID = TE.TipoEstrategiaID AND TE.Codigo='020'
		INNER JOIN ods.Campania ca ON CA.Codigo = e.campaniaid
		INNER JOIN ods.OfertasPersonalizadas op ON E.CUV2 = op.CUV and op.AnioCampanaVenta = CA.Codigo AND op.TipoPersonalizacion = 'BS'
		INNER JOIN ods.ProductoComercial PC ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		WHERE
			E.Activo = 1
			AND ca.Codigo = @CampaniaID
			AND op.CodConsultora = @ConsultoraGenerica
			AND E.Zona LIKE '%' + @ZonaID + '%'
			AND TE.FlagActivo = 1
			AND TE.flagRecoPerfil = 1
			AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
		ORDER BY CASE WHEN ISNULL(op.Orden,0) = 0 THEN te.Orden ELSE op.Orden END ASC
	END

	DECLARE @TEMP TABLE (
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

	INSERT INTO @temp 
		SELECT EstrategiaID
			,(select top 1 valor from EstrategiaDetalle where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10201) as ImgFondoDesktop
			,(select top 1 valor from EstrategiaDetalle where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10202) as ImgPrevDesktop
			,(select top 1 valor from EstrategiaDetalle where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10203) as ImgSelloProductoDesktop
			,(select top 1 valor from EstrategiaDetalle where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10204) as UrlVideoDesktop
			,(select top 1 valor from EstrategiaDetalle where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10208) as ImgFichaFondoDesktop
			,(select top 1 valor from EstrategiaDetalle where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10205) as ImgFondoMobile
			,(select top 1 valor from EstrategiaDetalle where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10206) as ImgSelloProductoMobile
			,(select top 1 valor from EstrategiaDetalle where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10207) as UrlVideoMobile
			,(select top 1 valor from EstrategiaDetalle where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10209) as ImgFichaFondoMobile			
		FROM @OFERTAS as T
		GROUP BY EstrategiaID

	DECLARE @tablaCuvUnicos table (CUV varchar(6), Id uniqueIdentifier)

	insert into @tablaCuvUnicos
	select CUV2, NULL from @OFERTAS
	group by CUV2

	update @tablaCuvUnicos
	set Id = (SELECT TOP 1 B.ColId FROM @OFERTAS B WHERE B.CUV2 = A.CUV)
	FROM @tablaCuvUnicos A

	DELETE B 
	FROM @OFERTAS B
	LEFT JOIN @tablaCuvUnicos A
		ON B.CUV2 = A.CUV AND B.ColId = A.Id
	 WHERE A.CUV IS NULL	 

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
		M.Descripcion as DescripcionMarca,
		'NO DISPONIBLE' AS DescripcionCategoria,
		T.FlagNueva, -- R2621
		T.TipoTallaColor,
		T.TipoEstrategiaImagenMostrar,
		T.CodigoProducto
		, T.EtiquetaID		-- SB20-351
		, T.EtiquetaID2		-- SB20-351
		, T.CodigoEstrategia
		, T.TieneVariedad
		, T.CODIGO
		, T.DescripcionEstrategia
		, T.FlagMostrarImg
		, D.ImgFondoDesktop
		, D.ImgPrevDesktop
		, D.ImgSelloProductoDesktop as ImgFichaDesktop
		, D.UrlVideoDesktop 
		, D.ImgFichaFondoDesktop 
		, D.ImgFondoMobile 
		, D.ImgSelloProductoMobile as ImgFichaMobile
		, D.UrlVideoMobile 
		, D.ImgFichaFondoMobile
		, RTRIM(SP.CodigoGenerico) AS CodigoGenerico
		, ISNULL(PC.CantAprobados,0) AS CantComenAprob
		, ISNULL(PC.CantRecomendados,0) AS CantComenRecom
		, ISNULL(PC.PromValorizado,0) AS PromValorizado
	FROM @OFERTAS T
	LEFT JOIN Marca M ON M.MarcaId = T.MarcaId
	LEFT JOIN @temp D ON D.EstrategiaID = T.EstrategiaID
	LEFT JOIN ods.SAP_PRODUCTO SP ON T.CodigoProducto = SP.CodigoSap AND ISNULL(SP.CodigoGenerico,'') <> ''
	LEFT JOIN ProductoComentario PC on T.CodigoProducto = PC.CodigoSap AND PC.Estado = 1
	ORDER BY
	Orden1 ASC, CASE WHEN ISNULL(T.Orden2,0) = 0 THEN T.Orden1 ELSE T.Orden2 END ASC, EstrategiaID ASC

	--DROP TABLE @OFERTAS
	SET NOCOUNT OFF
END
GO

USE BelcorpChile
GO

ALTER PROCEDURE [dbo].[ListarOfertasMasVendidos]
	@CampaniaID INT,
	@ConsultoraID VARCHAR(30),
	@ZonaID VARCHAR(20)
AS
/*
	ListarOfertasMasVendidos 201710, '49409307', '2228' --035708669
	ListarOfertasMasVendidos 201710, '2', '2161' --000758833
*/
BEGIN
	SET NOCOUNT ON;
		
	DECLARE @tablaCuvPedido table (CUV varchar(6))
	insert into @tablaCuvPedido
	SELECT CUV
	FROM PedidoWebDetalle with(nolock)
	WHERE CampaniaID=@CampaniaID and ConsultoraID=@ConsultoraID

	DECLARE @CodigoConsultora VARCHAR(25)
	DECLARE @NumeroPedido INT

	SELECT
		@NumeroPedido = consecutivonueva + 1,
		@CodigoConsultora = codigo
	FROM ods.Consultora
	WHERE
		ConsultoraID=@ConsultoraID
	
	DECLARE @TieneOfertas BIT
	SET @TieneOfertas = 0
	--validar si tiene ofertas , sino obtener del generico
	IF EXISTS (SELECT 1 FROM  ods.ofertaspersonalizadas op  WHERE op.CodConsultora= @CodigoConsultora AND op.AnioCampanaVenta= @CampaniaID AND op.TipoPersonalizacion= 'BS')
		SET @TieneOfertas = 1

	PRINT @TieneOfertas
	-- Obtener estrategias de recomendadas para ti.
	declare @CodigoRegion varchar(2) = null
	declare @CodigoZona varchar(4) = null
	select @CodigoRegion = r.Codigo, @CodigoZona = z.Codigo
	from ods.Zona z
	inner join ods.Region r on
		z.RegionId = r.RegionId
	where ZonaId = @ZonaID

	DECLARE @tablaCuvFaltante TABLE (CUV VARCHAR(6))

	insert into @tablaCuvFaltante
	select
		distinct ltrim(rtrim(CUV))
	from dbo.ProductoFaltante nolock
	where
		CampaniaID = @CampaniaID and Zonaid = @ZonaID
	UNION ALL
	select
		distinct ltrim(rtrim(fa.CodigoVenta)) AS CUV
	from ods.FaltanteAnunciado fa (nolock)
	inner join ods.Campania c (nolock) on
		fa.CampaniaID = c.CampaniaID
	where
		c.Codigo = @CampaniaID
		and (rtrim(fa.CodigoRegion) = @CodigoRegion or fa.CodigoRegion IS NULL)
		and (rtrim(fa.CodigoZona) = @CodigoZona or fa.CodigoZona IS NULL)

	DECLARE @OFERTAS TABLE (
		ColId UNIQUEIDENTIFIER,
		EstrategiaID INT,
		CUV2 VARCHAR(20),
		DescripcionCUV2 VARCHAR(800),
		EtiquetaDescripcion VARCHAR(8000),
		Precio NUMERIC(12,2),
		EtiquetaDescripcion2 VARCHAR(8000),
		Precio2 NUMERIC(12,2),
		TextoLibre VARCHAR(800),
		FlagEstrella BIT,
		ColorFondo VARCHAR(20),
		TipoEstrategiaID INT,
		FotoProducto01 VARCHAR(800),
		ImagenURL VARCHAR(500),
		LimiteVenta INT,
		MarcaID INT,
		Orden1 INT,
		Orden2 INT,
		IndicadorMontoMinimo INT,
		CodigoProducto VARCHAR(12),
		FlagNueva INT,
		TipoTallaColor VARCHAR(4),
		TipoEstrategiaImagenMostrar INT,
		EtiquetaID INT,
		EtiquetaID2 INT,
		CodigoEstrategia VARCHAR(100),
		TieneVariedad INT,
		CODIGO VARCHAR(100),
		DescripcionEstrategia VARCHAR(200),
		FlagMostrarImg TINYINT
	) 

	IF @TieneOfertas = 1
	BEGIN
		INSERT INTO @OFERTAS
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
		0 AS FlagNueva, -- R2621
		dbo.fn_ObtenerTallaColorCuv_SB2(E.CUV2,@CampaniaID) as TipoTallaColor,
		3 as TipoEstrategiaImagenMostrar	--Oferta para Ti
		, E.EtiquetaID		-- SB20-351
		, E.EtiquetaID2		-- SB20-351
		, E.CodigoEstrategia
		, E.TieneVariedad		
		, TE.CODIGO
		, TE.DescripcionEstrategia AS DescripcionEstrategia
		, ISNULL(TE.FlagMostrarImg,0) AS FlagMostrarImg
		FROM Estrategia E
		INNER JOIN TipoEstrategia TE ON E.TipoEstrategiaID = TE.TipoEstrategiaID AND TE.FlagActivo = 1 AND TE.Codigo = '020'
		INNER JOIN ods.Campania ca ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.OfertasPersonalizadas op ON CA.Codigo = op.AnioCampanaVenta AND E.CUV2 = op.CUV AND op.TipoPersonalizacion = 'BS'
		INNER JOIN ods.Consultora c ON op.CodConsultora = c.Codigo
		INNER JOIN ods.ProductoComercial PC ON CA.CampaniaID = PC.CampaniaID AND E.CUV2 = PC.CUV
		WHERE
			E.Activo = 1
			AND ca.Codigo = @CampaniaID
			AND c.ConsultoraID = @ConsultoraID
			AND E.Zona LIKE '%' + @ZonaID + '%'
			--AND TE.FlagActivo = 1
			AND TE.flagRecoPerfil = 1
			AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
		ORDER BY CASE WHEN ISNULL(op.Orden,0) = 0 THEN te.Orden ELSE op.Orden END ASC
	END
	ELSE 
	BEGIN
		DECLARE @ConsultoraGenerica VARCHAR(50) = ''
		SELECT @ConsultoraGenerica = Codigo FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10001

		INSERT INTO @OFERTAS
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
		0 AS FlagNueva, -- R2621
		dbo.fn_ObtenerTallaColorCuv_SB2(E.CUV2,@CampaniaID) as TipoTallaColor,
		3 as TipoEstrategiaImagenMostrar	--Oferta para Ti
		, E.EtiquetaID		-- SB20-351
		, E.EtiquetaID2		-- SB20-351
		, E.CodigoEstrategia
		, E.TieneVariedad		
		, TE.CODIGO
		, TE.DescripcionEstrategia AS DescripcionEstrategia
		, ISNULL(TE.FlagMostrarImg,0) AS FlagMostrarImg
		FROM Estrategia E
		INNER JOIN TipoEstrategia TE ON E.TipoEstrategiaID = TE.TipoEstrategiaID AND TE.Codigo='020'
		INNER JOIN ods.Campania ca ON CA.Codigo = e.campaniaid
		INNER JOIN ods.OfertasPersonalizadas op ON E.CUV2 = op.CUV and op.AnioCampanaVenta = CA.Codigo AND op.TipoPersonalizacion = 'BS'
		INNER JOIN ods.ProductoComercial PC ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		WHERE
			E.Activo = 1
			AND ca.Codigo = @CampaniaID
			AND op.CodConsultora = @ConsultoraGenerica
			AND E.Zona LIKE '%' + @ZonaID + '%'
			AND TE.FlagActivo = 1
			AND TE.flagRecoPerfil = 1
			AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
		ORDER BY CASE WHEN ISNULL(op.Orden,0) = 0 THEN te.Orden ELSE op.Orden END ASC
	END

	DECLARE @TEMP TABLE (
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

	INSERT INTO @temp 
		SELECT EstrategiaID
			,(select top 1 valor from EstrategiaDetalle where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10201) as ImgFondoDesktop
			,(select top 1 valor from EstrategiaDetalle where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10202) as ImgPrevDesktop
			,(select top 1 valor from EstrategiaDetalle where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10203) as ImgSelloProductoDesktop
			,(select top 1 valor from EstrategiaDetalle where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10204) as UrlVideoDesktop
			,(select top 1 valor from EstrategiaDetalle where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10208) as ImgFichaFondoDesktop
			,(select top 1 valor from EstrategiaDetalle where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10205) as ImgFondoMobile
			,(select top 1 valor from EstrategiaDetalle where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10206) as ImgSelloProductoMobile
			,(select top 1 valor from EstrategiaDetalle where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10207) as UrlVideoMobile
			,(select top 1 valor from EstrategiaDetalle where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10209) as ImgFichaFondoMobile			
		FROM @OFERTAS as T
		GROUP BY EstrategiaID

	DECLARE @tablaCuvUnicos table (CUV varchar(6), Id uniqueIdentifier)

	insert into @tablaCuvUnicos
	select CUV2, NULL from @OFERTAS
	group by CUV2

	update @tablaCuvUnicos
	set Id = (SELECT TOP 1 B.ColId FROM @OFERTAS B WHERE B.CUV2 = A.CUV)
	FROM @tablaCuvUnicos A

	DELETE B 
	FROM @OFERTAS B
	LEFT JOIN @tablaCuvUnicos A
		ON B.CUV2 = A.CUV AND B.ColId = A.Id
	 WHERE A.CUV IS NULL	 

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
		M.Descripcion as DescripcionMarca,
		'NO DISPONIBLE' AS DescripcionCategoria,
		T.FlagNueva, -- R2621
		T.TipoTallaColor,
		T.TipoEstrategiaImagenMostrar,
		T.CodigoProducto
		, T.EtiquetaID		-- SB20-351
		, T.EtiquetaID2		-- SB20-351
		, T.CodigoEstrategia
		, T.TieneVariedad
		, T.CODIGO
		, T.DescripcionEstrategia
		, T.FlagMostrarImg
		, D.ImgFondoDesktop
		, D.ImgPrevDesktop
		, D.ImgSelloProductoDesktop as ImgFichaDesktop
		, D.UrlVideoDesktop 
		, D.ImgFichaFondoDesktop 
		, D.ImgFondoMobile 
		, D.ImgSelloProductoMobile as ImgFichaMobile
		, D.UrlVideoMobile 
		, D.ImgFichaFondoMobile
		, RTRIM(SP.CodigoGenerico) AS CodigoGenerico
		, ISNULL(PC.CantAprobados,0) AS CantComenAprob
		, ISNULL(PC.CantRecomendados,0) AS CantComenRecom
		, ISNULL(PC.PromValorizado,0) AS PromValorizado
	FROM @OFERTAS T
	LEFT JOIN Marca M ON M.MarcaId = T.MarcaId
	LEFT JOIN @temp D ON D.EstrategiaID = T.EstrategiaID
	LEFT JOIN ods.SAP_PRODUCTO SP ON T.CodigoProducto = SP.CodigoSap AND ISNULL(SP.CodigoGenerico,'') <> ''
	LEFT JOIN ProductoComentario PC on T.CodigoProducto = PC.CodigoSap AND PC.Estado = 1
	ORDER BY
	Orden1 ASC, CASE WHEN ISNULL(T.Orden2,0) = 0 THEN T.Orden1 ELSE T.Orden2 END ASC, EstrategiaID ASC

	--DROP TABLE @OFERTAS
	SET NOCOUNT OFF
END
GO

USE BelcorpBolivia
GO

ALTER PROCEDURE [dbo].[ListarOfertasMasVendidos]
	@CampaniaID INT,
	@ConsultoraID VARCHAR(30),
	@ZonaID VARCHAR(20)
AS
/*
	ListarOfertasMasVendidos 201710, '49409307', '2228' --035708669
	ListarOfertasMasVendidos 201710, '2', '2161' --000758833
*/
BEGIN
	SET NOCOUNT ON;
		
	DECLARE @tablaCuvPedido table (CUV varchar(6))
	insert into @tablaCuvPedido
	SELECT CUV
	FROM PedidoWebDetalle with(nolock)
	WHERE CampaniaID=@CampaniaID and ConsultoraID=@ConsultoraID

	DECLARE @CodigoConsultora VARCHAR(25)
	DECLARE @NumeroPedido INT

	SELECT
		@NumeroPedido = consecutivonueva + 1,
		@CodigoConsultora = codigo
	FROM ods.Consultora
	WHERE
		ConsultoraID=@ConsultoraID
	
	DECLARE @TieneOfertas BIT
	SET @TieneOfertas = 0
	--validar si tiene ofertas , sino obtener del generico
	IF EXISTS (SELECT 1 FROM  ods.ofertaspersonalizadas op  WHERE op.CodConsultora= @CodigoConsultora AND op.AnioCampanaVenta= @CampaniaID AND op.TipoPersonalizacion= 'BS')
		SET @TieneOfertas = 1

	PRINT @TieneOfertas
	-- Obtener estrategias de recomendadas para ti.
	declare @CodigoRegion varchar(2) = null
	declare @CodigoZona varchar(4) = null
	select @CodigoRegion = r.Codigo, @CodigoZona = z.Codigo
	from ods.Zona z
	inner join ods.Region r on
		z.RegionId = r.RegionId
	where ZonaId = @ZonaID

	DECLARE @tablaCuvFaltante TABLE (CUV VARCHAR(6))

	insert into @tablaCuvFaltante
	select
		distinct ltrim(rtrim(CUV))
	from dbo.ProductoFaltante nolock
	where
		CampaniaID = @CampaniaID and Zonaid = @ZonaID
	UNION ALL
	select
		distinct ltrim(rtrim(fa.CodigoVenta)) AS CUV
	from ods.FaltanteAnunciado fa (nolock)
	inner join ods.Campania c (nolock) on
		fa.CampaniaID = c.CampaniaID
	where
		c.Codigo = @CampaniaID
		and (rtrim(fa.CodigoRegion) = @CodigoRegion or fa.CodigoRegion IS NULL)
		and (rtrim(fa.CodigoZona) = @CodigoZona or fa.CodigoZona IS NULL)

	DECLARE @OFERTAS TABLE (
		ColId UNIQUEIDENTIFIER,
		EstrategiaID INT,
		CUV2 VARCHAR(20),
		DescripcionCUV2 VARCHAR(800),
		EtiquetaDescripcion VARCHAR(8000),
		Precio NUMERIC(12,2),
		EtiquetaDescripcion2 VARCHAR(8000),
		Precio2 NUMERIC(12,2),
		TextoLibre VARCHAR(800),
		FlagEstrella BIT,
		ColorFondo VARCHAR(20),
		TipoEstrategiaID INT,
		FotoProducto01 VARCHAR(800),
		ImagenURL VARCHAR(500),
		LimiteVenta INT,
		MarcaID INT,
		Orden1 INT,
		Orden2 INT,
		IndicadorMontoMinimo INT,
		CodigoProducto VARCHAR(12),
		FlagNueva INT,
		TipoTallaColor VARCHAR(4),
		TipoEstrategiaImagenMostrar INT,
		EtiquetaID INT,
		EtiquetaID2 INT,
		CodigoEstrategia VARCHAR(100),
		TieneVariedad INT,
		CODIGO VARCHAR(100),
		DescripcionEstrategia VARCHAR(200),
		FlagMostrarImg TINYINT
	) 

	IF @TieneOfertas = 1
	BEGIN
		INSERT INTO @OFERTAS
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
		0 AS FlagNueva, -- R2621
		dbo.fn_ObtenerTallaColorCuv_SB2(E.CUV2,@CampaniaID) as TipoTallaColor,
		3 as TipoEstrategiaImagenMostrar	--Oferta para Ti
		, E.EtiquetaID		-- SB20-351
		, E.EtiquetaID2		-- SB20-351
		, E.CodigoEstrategia
		, E.TieneVariedad		
		, TE.CODIGO
		, TE.DescripcionEstrategia AS DescripcionEstrategia
		, ISNULL(TE.FlagMostrarImg,0) AS FlagMostrarImg
		FROM Estrategia E
		INNER JOIN TipoEstrategia TE ON E.TipoEstrategiaID = TE.TipoEstrategiaID AND TE.FlagActivo = 1 AND TE.Codigo = '020'
		INNER JOIN ods.Campania ca ON CA.Codigo = E.CampaniaID
		INNER JOIN ods.OfertasPersonalizadas op ON CA.Codigo = op.AnioCampanaVenta AND E.CUV2 = op.CUV AND op.TipoPersonalizacion = 'BS'
		INNER JOIN ods.Consultora c ON op.CodConsultora = c.Codigo
		INNER JOIN ods.ProductoComercial PC ON CA.CampaniaID = PC.CampaniaID AND E.CUV2 = PC.CUV
		WHERE
			E.Activo = 1
			AND ca.Codigo = @CampaniaID
			AND c.ConsultoraID = @ConsultoraID
			AND E.Zona LIKE '%' + @ZonaID + '%'
			--AND TE.FlagActivo = 1
			AND TE.flagRecoPerfil = 1
			AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
		ORDER BY CASE WHEN ISNULL(op.Orden,0) = 0 THEN te.Orden ELSE op.Orden END ASC
	END
	ELSE 
	BEGIN
		DECLARE @ConsultoraGenerica VARCHAR(50) = ''
		SELECT @ConsultoraGenerica = Codigo FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10001

		INSERT INTO @OFERTAS
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
		0 AS FlagNueva, -- R2621
		dbo.fn_ObtenerTallaColorCuv_SB2(E.CUV2,@CampaniaID) as TipoTallaColor,
		3 as TipoEstrategiaImagenMostrar	--Oferta para Ti
		, E.EtiquetaID		-- SB20-351
		, E.EtiquetaID2		-- SB20-351
		, E.CodigoEstrategia
		, E.TieneVariedad		
		, TE.CODIGO
		, TE.DescripcionEstrategia AS DescripcionEstrategia
		, ISNULL(TE.FlagMostrarImg,0) AS FlagMostrarImg
		FROM Estrategia E
		INNER JOIN TipoEstrategia TE ON E.TipoEstrategiaID = TE.TipoEstrategiaID AND TE.Codigo='020'
		INNER JOIN ods.Campania ca ON CA.Codigo = e.campaniaid
		INNER JOIN ods.OfertasPersonalizadas op ON E.CUV2 = op.CUV and op.AnioCampanaVenta = CA.Codigo AND op.TipoPersonalizacion = 'BS'
		INNER JOIN ods.ProductoComercial PC ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
		WHERE
			E.Activo = 1
			AND ca.Codigo = @CampaniaID
			AND op.CodConsultora = @ConsultoraGenerica
			AND E.Zona LIKE '%' + @ZonaID + '%'
			AND TE.FlagActivo = 1
			AND TE.flagRecoPerfil = 1
			AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
		ORDER BY CASE WHEN ISNULL(op.Orden,0) = 0 THEN te.Orden ELSE op.Orden END ASC
	END

	DECLARE @TEMP TABLE (
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

	INSERT INTO @temp 
		SELECT EstrategiaID
			,(select top 1 valor from EstrategiaDetalle where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10201) as ImgFondoDesktop
			,(select top 1 valor from EstrategiaDetalle where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10202) as ImgPrevDesktop
			,(select top 1 valor from EstrategiaDetalle where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10203) as ImgSelloProductoDesktop
			,(select top 1 valor from EstrategiaDetalle where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10204) as UrlVideoDesktop
			,(select top 1 valor from EstrategiaDetalle where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10208) as ImgFichaFondoDesktop
			,(select top 1 valor from EstrategiaDetalle where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10205) as ImgFondoMobile
			,(select top 1 valor from EstrategiaDetalle where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10206) as ImgSelloProductoMobile
			,(select top 1 valor from EstrategiaDetalle where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10207) as UrlVideoMobile
			,(select top 1 valor from EstrategiaDetalle where EstrategiaID = T.EstrategiaID and TablaLogicaDatosId = 10209) as ImgFichaFondoMobile			
		FROM @OFERTAS as T
		GROUP BY EstrategiaID

	DECLARE @tablaCuvUnicos table (CUV varchar(6), Id uniqueIdentifier)

	insert into @tablaCuvUnicos
	select CUV2, NULL from @OFERTAS
	group by CUV2

	update @tablaCuvUnicos
	set Id = (SELECT TOP 1 B.ColId FROM @OFERTAS B WHERE B.CUV2 = A.CUV)
	FROM @tablaCuvUnicos A

	DELETE B 
	FROM @OFERTAS B
	LEFT JOIN @tablaCuvUnicos A
		ON B.CUV2 = A.CUV AND B.ColId = A.Id
	 WHERE A.CUV IS NULL	 

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
		M.Descripcion as DescripcionMarca,
		'NO DISPONIBLE' AS DescripcionCategoria,
		T.FlagNueva, -- R2621
		T.TipoTallaColor,
		T.TipoEstrategiaImagenMostrar,
		T.CodigoProducto
		, T.EtiquetaID		-- SB20-351
		, T.EtiquetaID2		-- SB20-351
		, T.CodigoEstrategia
		, T.TieneVariedad
		, T.CODIGO
		, T.DescripcionEstrategia
		, T.FlagMostrarImg
		, D.ImgFondoDesktop
		, D.ImgPrevDesktop
		, D.ImgSelloProductoDesktop as ImgFichaDesktop
		, D.UrlVideoDesktop 
		, D.ImgFichaFondoDesktop 
		, D.ImgFondoMobile 
		, D.ImgSelloProductoMobile as ImgFichaMobile
		, D.UrlVideoMobile 
		, D.ImgFichaFondoMobile
		, RTRIM(SP.CodigoGenerico) AS CodigoGenerico
		, ISNULL(PC.CantAprobados,0) AS CantComenAprob
		, ISNULL(PC.CantRecomendados,0) AS CantComenRecom
		, ISNULL(PC.PromValorizado,0) AS PromValorizado
	FROM @OFERTAS T
	LEFT JOIN Marca M ON M.MarcaId = T.MarcaId
	LEFT JOIN @temp D ON D.EstrategiaID = T.EstrategiaID
	LEFT JOIN ods.SAP_PRODUCTO SP ON T.CodigoProducto = SP.CodigoSap AND ISNULL(SP.CodigoGenerico,'') <> ''
	LEFT JOIN ProductoComentario PC on T.CodigoProducto = PC.CodigoSap AND PC.Estado = 1
	ORDER BY
	Orden1 ASC, CASE WHEN ISNULL(T.Orden2,0) = 0 THEN T.Orden1 ELSE T.Orden2 END ASC, EstrategiaID ASC

	--DROP TABLE @OFERTAS
	SET NOCOUNT OFF
END
GO