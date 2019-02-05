USE BelcorpPeru
GO

/****** Object:  StoredProcedure [dbo].[ListarEstrategiasODD2]    Script Date: 20/11/2018 16:52:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[ListarEstrategiasODD2] (
	@CodCampania INT
	,@CodConsultora VARCHAR(10)
	,@FechaInicioFact DATE
	)
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @StrCampaniaID CHAR(6) = CONVERT(CHAR(6), @CodCampania)
	DECLARE @EstrategiaCodigo VARCHAR(100) = '009'
	DECLARE @tablaCuvFaltante TABLE (CUV VARCHAR(6))
	DECLARE @OfertasPersonalizadas TABLE (
		Orden INT
		,CUV CHAR(6)
		,TipoPersonalizacion CHAR(3)
		,FlagRevista INT
		,AnioCampanaVenta INT
		,DiaInicio INT
		)

	INSERT INTO @tablaCuvFaltante (CUV)
	SELECT CUV
	FROM dbo.ObtenerCuvFaltante(@CodCampania, @CodConsultora)

	DECLARE @codConsultoraForzada VARCHAR(9) = ''
	DECLARE @codConsultoraDefault VARCHAR(9) = ''

	SELECT @codConsultoraForzada = Codigo
	FROM TablaLogicaDatos WITH (NOLOCK)
	WHERE TablaLogicaDatosID = 10002

	SELECT @codConsultoraDefault = Codigo
	FROM TablaLogicaDatos WITH (NOLOCK)
	WHERE TablaLogicaDatosID = 10001

	INSERT INTO @OfertasPersonalizadas
	SELECT ISNULL(Orden, 0)
		,CUV
		,TipoPersonalizacion
		,FlagRevista
		,CONVERT(INT, AnioCampanaVenta)
		,DiaInicio
	FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
	WHERE op.CodConsultora = @CodConsultora
		AND op.AnioCampanaVenta = @StrCampaniaID
		AND op.TipoPersonalizacion = 'ODD'

	IF NOT EXISTS (
			SELECT CUV
			FROM @OfertasPersonalizadas
			)
	BEGIN
		INSERT INTO @OfertasPersonalizadas
		SELECT ISNULL(Orden, 0)
			,CUV
			,TipoPersonalizacion
			,FlagRevista
			,CONVERT(INT, AnioCampanaVenta)
			,DiaInicio
		FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
		WHERE op.CodConsultora = @codConsultoraDefault
			AND op.AnioCampanaVenta = @StrCampaniaID
			AND op.TipoPersonalizacion = 'ODD'
	END

	INSERT INTO @OfertasPersonalizadas (
		Orden
		,CUV
		,TipoPersonalizacion
		,FlagRevista
		,AnioCampanaVenta
		,DiaInicio
		)
	SELECT Orden
		,CUV
		,TipoPersonalizacion
		,FlagRevista
		,AnioCampanaVenta
		,DiaInicio
	FROM dbo.ListarEstrategiasForzadas(@CodCampania, @EstrategiaCodigo)

	SELECT e.EstrategiaID
		,e.CUV2
		,e.DescripcionCUV2
		,'' AS EtiquetaDescripcion
		,e.Precio
		,'' AS EtiquetaDescripcion2
		,e.Precio2
		,ISNULL(e.TextoLibre, '') AS TextoLibre
		,e.CodigoEstrategia
		,0 AS FlagEstrella
		,'' AS ColorFondo
		,e.TipoEstrategiaID
		,e.ImagenURL AS FotoProducto01
		,te.ImagenEstrategia AS ImagenURL
		,e.LimiteVenta
		,pc.MarcaID
		,te.Orden AS Orden1
		,op.Orden Orden2
		,pc.IndicadorMontoMinimo
		,pc.CodigoProducto
		,0 AS FlagNueva
		,'' AS TipoTallaColor
		,3 AS TipoEstrategiaImagenMostrar
		,e.EtiquetaID
		,e.EtiquetaID2
		,e.CodigoEstrategia
		,e.TieneVariedad
		,te.Codigo
		,te.DescripcionEstrategia
		,ISNULL(te.FlagMostrarImg, 0) AS FlagMostrarImg
		,e.PrecioPublico
		,e.Ganancia
		,m.Descripcion AS DescripcionMarca
		,op.FlagRevista
		--adicionales
		,ISNULL(e.ImagenMiniaturaURL, '') AS ImagenMiniaturaURL
		,op.DiaInicio
		, CASE WHEN TF.CUV IS NULL THEN 1 ELSE 0 END AS TieneStock
	FROM TipoEstrategia te WITH (NOLOCK)
	INNER JOIN dbo.Estrategia e WITH (NOLOCK) ON te.TipoEstrategiaId = e.TipoEstrategiaId
		AND te.Codigo = @EstrategiaCodigo
	INNER JOIN @OfertasPersonalizadas op ON e.CampaniaID = op.AnioCampanaVenta
		AND e.CUV2 = op.CUV
	INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON e.CampaniaID = pc.AnoCampania
		AND e.CUV2 = pc.CUV
	--INNER JOIN dbo.TipoEstrategia TE WITH (NOLOCK) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
	--	AND TE.Codigo = @EstrategiaCodigo
	LEFT JOIN dbo.Marca M WITH (NOLOCK) ON pc.MarcaId = m.MarcaId
	LEFT JOIN @tablaCuvFaltante TF on TF.CUV = E.CUV2
	WHERE e.Activo = 1
		--AND NOT EXISTS (
		--	SELECT CUV
		--	FROM @tablaCuvFaltante TF
		--	WHERE E.CUV2 = TF.CUV
		--	)
		AND DATEDIFF(dd, GETDATE(), DATEADD(dd, op.DiaInicio, CAST(@FechaInicioFact AS DATE))) = 0
	ORDER BY op.Orden ASC
		,EstrategiaID ASC

	SET NOCOUNT OFF
END
GO

USE BelcorpMexico
GO

/****** Object:  StoredProcedure [dbo].[ListarEstrategiasODD2]    Script Date: 20/11/2018 16:52:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[ListarEstrategiasODD2] (
	@CodCampania INT
	,@CodConsultora VARCHAR(10)
	,@FechaInicioFact DATE
	)
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @StrCampaniaID CHAR(6) = CONVERT(CHAR(6), @CodCampania)
	DECLARE @EstrategiaCodigo VARCHAR(100) = '009'
	DECLARE @tablaCuvFaltante TABLE (CUV VARCHAR(6))
	DECLARE @OfertasPersonalizadas TABLE (
		Orden INT
		,CUV CHAR(6)
		,TipoPersonalizacion CHAR(3)
		,FlagRevista INT
		,AnioCampanaVenta INT
		,DiaInicio INT
		)

	INSERT INTO @tablaCuvFaltante (CUV)
	SELECT CUV
	FROM dbo.ObtenerCuvFaltante(@CodCampania, @CodConsultora)

	DECLARE @codConsultoraForzada VARCHAR(9) = ''
	DECLARE @codConsultoraDefault VARCHAR(9) = ''

	SELECT @codConsultoraForzada = Codigo
	FROM TablaLogicaDatos WITH (NOLOCK)
	WHERE TablaLogicaDatosID = 10002

	SELECT @codConsultoraDefault = Codigo
	FROM TablaLogicaDatos WITH (NOLOCK)
	WHERE TablaLogicaDatosID = 10001

	INSERT INTO @OfertasPersonalizadas
	SELECT ISNULL(Orden, 0)
		,CUV
		,TipoPersonalizacion
		,FlagRevista
		,CONVERT(INT, AnioCampanaVenta)
		,DiaInicio
	FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
	WHERE op.CodConsultora = @CodConsultora
		AND op.AnioCampanaVenta = @StrCampaniaID
		AND op.TipoPersonalizacion = 'ODD'

	IF NOT EXISTS (
			SELECT CUV
			FROM @OfertasPersonalizadas
			)
	BEGIN
		INSERT INTO @OfertasPersonalizadas
		SELECT ISNULL(Orden, 0)
			,CUV
			,TipoPersonalizacion
			,FlagRevista
			,CONVERT(INT, AnioCampanaVenta)
			,DiaInicio
		FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
		WHERE op.CodConsultora = @codConsultoraDefault
			AND op.AnioCampanaVenta = @StrCampaniaID
			AND op.TipoPersonalizacion = 'ODD'
	END

	INSERT INTO @OfertasPersonalizadas (
		Orden
		,CUV
		,TipoPersonalizacion
		,FlagRevista
		,AnioCampanaVenta
		,DiaInicio
		)
	SELECT Orden
		,CUV
		,TipoPersonalizacion
		,FlagRevista
		,AnioCampanaVenta
		,DiaInicio
	FROM dbo.ListarEstrategiasForzadas(@CodCampania, @EstrategiaCodigo)

	SELECT e.EstrategiaID
		,e.CUV2
		,e.DescripcionCUV2
		,'' AS EtiquetaDescripcion
		,e.Precio
		,'' AS EtiquetaDescripcion2
		,e.Precio2
		,ISNULL(e.TextoLibre, '') AS TextoLibre
		,e.CodigoEstrategia
		,0 AS FlagEstrella
		,'' AS ColorFondo
		,e.TipoEstrategiaID
		,e.ImagenURL AS FotoProducto01
		,te.ImagenEstrategia AS ImagenURL
		,e.LimiteVenta
		,pc.MarcaID
		,te.Orden AS Orden1
		,op.Orden Orden2
		,pc.IndicadorMontoMinimo
		,pc.CodigoProducto
		,0 AS FlagNueva
		,'' AS TipoTallaColor
		,3 AS TipoEstrategiaImagenMostrar
		,e.EtiquetaID
		,e.EtiquetaID2
		,e.CodigoEstrategia
		,e.TieneVariedad
		,te.Codigo
		,te.DescripcionEstrategia
		,ISNULL(te.FlagMostrarImg, 0) AS FlagMostrarImg
		,e.PrecioPublico
		,e.Ganancia
		,m.Descripcion AS DescripcionMarca
		,op.FlagRevista
		--adicionales
		,ISNULL(e.ImagenMiniaturaURL, '') AS ImagenMiniaturaURL
		,op.DiaInicio
		, CASE WHEN TF.CUV IS NULL THEN 1 ELSE 0 END AS TieneStock
	FROM TipoEstrategia te WITH (NOLOCK)
	INNER JOIN dbo.Estrategia e WITH (NOLOCK) ON te.TipoEstrategiaId = e.TipoEstrategiaId
		AND te.Codigo = @EstrategiaCodigo
	INNER JOIN @OfertasPersonalizadas op ON e.CampaniaID = op.AnioCampanaVenta
		AND e.CUV2 = op.CUV
	INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON e.CampaniaID = pc.AnoCampania
		AND e.CUV2 = pc.CUV
	--INNER JOIN dbo.TipoEstrategia TE WITH (NOLOCK) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
	--	AND TE.Codigo = @EstrategiaCodigo
	LEFT JOIN dbo.Marca M WITH (NOLOCK) ON pc.MarcaId = m.MarcaId
	LEFT JOIN @tablaCuvFaltante TF on TF.CUV = E.CUV2
	WHERE e.Activo = 1
		--AND NOT EXISTS (
		--	SELECT CUV
		--	FROM @tablaCuvFaltante TF
		--	WHERE E.CUV2 = TF.CUV
		--	)
		AND DATEDIFF(dd, GETDATE(), DATEADD(dd, op.DiaInicio, CAST(@FechaInicioFact AS DATE))) = 0
	ORDER BY op.Orden ASC
		,EstrategiaID ASC

	SET NOCOUNT OFF
END
GO

USE BelcorpColombia
GO

/****** Object:  StoredProcedure [dbo].[ListarEstrategiasODD2]    Script Date: 20/11/2018 16:52:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[ListarEstrategiasODD2] (
	@CodCampania INT
	,@CodConsultora VARCHAR(10)
	,@FechaInicioFact DATE
	)
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @StrCampaniaID CHAR(6) = CONVERT(CHAR(6), @CodCampania)
	DECLARE @EstrategiaCodigo VARCHAR(100) = '009'
	DECLARE @tablaCuvFaltante TABLE (CUV VARCHAR(6))
	DECLARE @OfertasPersonalizadas TABLE (
		Orden INT
		,CUV CHAR(6)
		,TipoPersonalizacion CHAR(3)
		,FlagRevista INT
		,AnioCampanaVenta INT
		,DiaInicio INT
		)

	INSERT INTO @tablaCuvFaltante (CUV)
	SELECT CUV
	FROM dbo.ObtenerCuvFaltante(@CodCampania, @CodConsultora)

	DECLARE @codConsultoraForzada VARCHAR(9) = ''
	DECLARE @codConsultoraDefault VARCHAR(9) = ''

	SELECT @codConsultoraForzada = Codigo
	FROM TablaLogicaDatos WITH (NOLOCK)
	WHERE TablaLogicaDatosID = 10002

	SELECT @codConsultoraDefault = Codigo
	FROM TablaLogicaDatos WITH (NOLOCK)
	WHERE TablaLogicaDatosID = 10001

	INSERT INTO @OfertasPersonalizadas
	SELECT ISNULL(Orden, 0)
		,CUV
		,TipoPersonalizacion
		,FlagRevista
		,CONVERT(INT, AnioCampanaVenta)
		,DiaInicio
	FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
	WHERE op.CodConsultora = @CodConsultora
		AND op.AnioCampanaVenta = @StrCampaniaID
		AND op.TipoPersonalizacion = 'ODD'

	IF NOT EXISTS (
			SELECT CUV
			FROM @OfertasPersonalizadas
			)
	BEGIN
		INSERT INTO @OfertasPersonalizadas
		SELECT ISNULL(Orden, 0)
			,CUV
			,TipoPersonalizacion
			,FlagRevista
			,CONVERT(INT, AnioCampanaVenta)
			,DiaInicio
		FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
		WHERE op.CodConsultora = @codConsultoraDefault
			AND op.AnioCampanaVenta = @StrCampaniaID
			AND op.TipoPersonalizacion = 'ODD'
	END

	INSERT INTO @OfertasPersonalizadas (
		Orden
		,CUV
		,TipoPersonalizacion
		,FlagRevista
		,AnioCampanaVenta
		,DiaInicio
		)
	SELECT Orden
		,CUV
		,TipoPersonalizacion
		,FlagRevista
		,AnioCampanaVenta
		,DiaInicio
	FROM dbo.ListarEstrategiasForzadas(@CodCampania, @EstrategiaCodigo)

	SELECT e.EstrategiaID
		,e.CUV2
		,e.DescripcionCUV2
		,'' AS EtiquetaDescripcion
		,e.Precio
		,'' AS EtiquetaDescripcion2
		,e.Precio2
		,ISNULL(e.TextoLibre, '') AS TextoLibre
		,e.CodigoEstrategia
		,0 AS FlagEstrella
		,'' AS ColorFondo
		,e.TipoEstrategiaID
		,e.ImagenURL AS FotoProducto01
		,te.ImagenEstrategia AS ImagenURL
		,e.LimiteVenta
		,pc.MarcaID
		,te.Orden AS Orden1
		,op.Orden Orden2
		,pc.IndicadorMontoMinimo
		,pc.CodigoProducto
		,0 AS FlagNueva
		,'' AS TipoTallaColor
		,3 AS TipoEstrategiaImagenMostrar
		,e.EtiquetaID
		,e.EtiquetaID2
		,e.CodigoEstrategia
		,e.TieneVariedad
		,te.Codigo
		,te.DescripcionEstrategia
		,ISNULL(te.FlagMostrarImg, 0) AS FlagMostrarImg
		,e.PrecioPublico
		,e.Ganancia
		,m.Descripcion AS DescripcionMarca
		,op.FlagRevista
		--adicionales
		,ISNULL(e.ImagenMiniaturaURL, '') AS ImagenMiniaturaURL
		,op.DiaInicio
		, CASE WHEN TF.CUV IS NULL THEN 1 ELSE 0 END AS TieneStock
	FROM TipoEstrategia te WITH (NOLOCK)
	INNER JOIN dbo.Estrategia e WITH (NOLOCK) ON te.TipoEstrategiaId = e.TipoEstrategiaId
		AND te.Codigo = @EstrategiaCodigo
	INNER JOIN @OfertasPersonalizadas op ON e.CampaniaID = op.AnioCampanaVenta
		AND e.CUV2 = op.CUV
	INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON e.CampaniaID = pc.AnoCampania
		AND e.CUV2 = pc.CUV
	--INNER JOIN dbo.TipoEstrategia TE WITH (NOLOCK) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
	--	AND TE.Codigo = @EstrategiaCodigo
	LEFT JOIN dbo.Marca M WITH (NOLOCK) ON pc.MarcaId = m.MarcaId
	LEFT JOIN @tablaCuvFaltante TF on TF.CUV = E.CUV2
	WHERE e.Activo = 1
		--AND NOT EXISTS (
		--	SELECT CUV
		--	FROM @tablaCuvFaltante TF
		--	WHERE E.CUV2 = TF.CUV
		--	)
		AND DATEDIFF(dd, GETDATE(), DATEADD(dd, op.DiaInicio, CAST(@FechaInicioFact AS DATE))) = 0
	ORDER BY op.Orden ASC
		,EstrategiaID ASC

	SET NOCOUNT OFF
END
GO

USE BelcorpSalvador
GO

/****** Object:  StoredProcedure [dbo].[ListarEstrategiasODD2]    Script Date: 20/11/2018 16:52:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[ListarEstrategiasODD2] (
	@CodCampania INT
	,@CodConsultora VARCHAR(10)
	,@FechaInicioFact DATE
	)
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @StrCampaniaID CHAR(6) = CONVERT(CHAR(6), @CodCampania)
	DECLARE @EstrategiaCodigo VARCHAR(100) = '009'
	DECLARE @tablaCuvFaltante TABLE (CUV VARCHAR(6))
	DECLARE @OfertasPersonalizadas TABLE (
		Orden INT
		,CUV CHAR(6)
		,TipoPersonalizacion CHAR(3)
		,FlagRevista INT
		,AnioCampanaVenta INT
		,DiaInicio INT
		)

	INSERT INTO @tablaCuvFaltante (CUV)
	SELECT CUV
	FROM dbo.ObtenerCuvFaltante(@CodCampania, @CodConsultora)

	DECLARE @codConsultoraForzada VARCHAR(9) = ''
	DECLARE @codConsultoraDefault VARCHAR(9) = ''

	SELECT @codConsultoraForzada = Codigo
	FROM TablaLogicaDatos WITH (NOLOCK)
	WHERE TablaLogicaDatosID = 10002

	SELECT @codConsultoraDefault = Codigo
	FROM TablaLogicaDatos WITH (NOLOCK)
	WHERE TablaLogicaDatosID = 10001

	INSERT INTO @OfertasPersonalizadas
	SELECT ISNULL(Orden, 0)
		,CUV
		,TipoPersonalizacion
		,FlagRevista
		,CONVERT(INT, AnioCampanaVenta)
		,DiaInicio
	FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
	WHERE op.CodConsultora = @CodConsultora
		AND op.AnioCampanaVenta = @StrCampaniaID
		AND op.TipoPersonalizacion = 'ODD'

	IF NOT EXISTS (
			SELECT CUV
			FROM @OfertasPersonalizadas
			)
	BEGIN
		INSERT INTO @OfertasPersonalizadas
		SELECT ISNULL(Orden, 0)
			,CUV
			,TipoPersonalizacion
			,FlagRevista
			,CONVERT(INT, AnioCampanaVenta)
			,DiaInicio
		FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
		WHERE op.CodConsultora = @codConsultoraDefault
			AND op.AnioCampanaVenta = @StrCampaniaID
			AND op.TipoPersonalizacion = 'ODD'
	END

	INSERT INTO @OfertasPersonalizadas (
		Orden
		,CUV
		,TipoPersonalizacion
		,FlagRevista
		,AnioCampanaVenta
		,DiaInicio
		)
	SELECT Orden
		,CUV
		,TipoPersonalizacion
		,FlagRevista
		,AnioCampanaVenta
		,DiaInicio
	FROM dbo.ListarEstrategiasForzadas(@CodCampania, @EstrategiaCodigo)

	SELECT e.EstrategiaID
		,e.CUV2
		,e.DescripcionCUV2
		,'' AS EtiquetaDescripcion
		,e.Precio
		,'' AS EtiquetaDescripcion2
		,e.Precio2
		,ISNULL(e.TextoLibre, '') AS TextoLibre
		,e.CodigoEstrategia
		,0 AS FlagEstrella
		,'' AS ColorFondo
		,e.TipoEstrategiaID
		,e.ImagenURL AS FotoProducto01
		,te.ImagenEstrategia AS ImagenURL
		,e.LimiteVenta
		,pc.MarcaID
		,te.Orden AS Orden1
		,op.Orden Orden2
		,pc.IndicadorMontoMinimo
		,pc.CodigoProducto
		,0 AS FlagNueva
		,'' AS TipoTallaColor
		,3 AS TipoEstrategiaImagenMostrar
		,e.EtiquetaID
		,e.EtiquetaID2
		,e.CodigoEstrategia
		,e.TieneVariedad
		,te.Codigo
		,te.DescripcionEstrategia
		,ISNULL(te.FlagMostrarImg, 0) AS FlagMostrarImg
		,e.PrecioPublico
		,e.Ganancia
		,m.Descripcion AS DescripcionMarca
		,op.FlagRevista
		--adicionales
		,ISNULL(e.ImagenMiniaturaURL, '') AS ImagenMiniaturaURL
		,op.DiaInicio
		, CASE WHEN TF.CUV IS NULL THEN 1 ELSE 0 END AS TieneStock
	FROM TipoEstrategia te WITH (NOLOCK)
	INNER JOIN dbo.Estrategia e WITH (NOLOCK) ON te.TipoEstrategiaId = e.TipoEstrategiaId
		AND te.Codigo = @EstrategiaCodigo
	INNER JOIN @OfertasPersonalizadas op ON e.CampaniaID = op.AnioCampanaVenta
		AND e.CUV2 = op.CUV
	INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON e.CampaniaID = pc.AnoCampania
		AND e.CUV2 = pc.CUV
	--INNER JOIN dbo.TipoEstrategia TE WITH (NOLOCK) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
	--	AND TE.Codigo = @EstrategiaCodigo
	LEFT JOIN dbo.Marca M WITH (NOLOCK) ON pc.MarcaId = m.MarcaId
	LEFT JOIN @tablaCuvFaltante TF on TF.CUV = E.CUV2
	WHERE e.Activo = 1
		--AND NOT EXISTS (
		--	SELECT CUV
		--	FROM @tablaCuvFaltante TF
		--	WHERE E.CUV2 = TF.CUV
		--	)
		AND DATEDIFF(dd, GETDATE(), DATEADD(dd, op.DiaInicio, CAST(@FechaInicioFact AS DATE))) = 0
	ORDER BY op.Orden ASC
		,EstrategiaID ASC

	SET NOCOUNT OFF
END
GO

USE BelcorpPuertoRico
GO

/****** Object:  StoredProcedure [dbo].[ListarEstrategiasODD2]    Script Date: 20/11/2018 16:52:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[ListarEstrategiasODD2] (
	@CodCampania INT
	,@CodConsultora VARCHAR(10)
	,@FechaInicioFact DATE
	)
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @StrCampaniaID CHAR(6) = CONVERT(CHAR(6), @CodCampania)
	DECLARE @EstrategiaCodigo VARCHAR(100) = '009'
	DECLARE @tablaCuvFaltante TABLE (CUV VARCHAR(6))
	DECLARE @OfertasPersonalizadas TABLE (
		Orden INT
		,CUV CHAR(6)
		,TipoPersonalizacion CHAR(3)
		,FlagRevista INT
		,AnioCampanaVenta INT
		,DiaInicio INT
		)

	INSERT INTO @tablaCuvFaltante (CUV)
	SELECT CUV
	FROM dbo.ObtenerCuvFaltante(@CodCampania, @CodConsultora)

	DECLARE @codConsultoraForzada VARCHAR(9) = ''
	DECLARE @codConsultoraDefault VARCHAR(9) = ''

	SELECT @codConsultoraForzada = Codigo
	FROM TablaLogicaDatos WITH (NOLOCK)
	WHERE TablaLogicaDatosID = 10002

	SELECT @codConsultoraDefault = Codigo
	FROM TablaLogicaDatos WITH (NOLOCK)
	WHERE TablaLogicaDatosID = 10001

	INSERT INTO @OfertasPersonalizadas
	SELECT ISNULL(Orden, 0)
		,CUV
		,TipoPersonalizacion
		,FlagRevista
		,CONVERT(INT, AnioCampanaVenta)
		,DiaInicio
	FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
	WHERE op.CodConsultora = @CodConsultora
		AND op.AnioCampanaVenta = @StrCampaniaID
		AND op.TipoPersonalizacion = 'ODD'

	IF NOT EXISTS (
			SELECT CUV
			FROM @OfertasPersonalizadas
			)
	BEGIN
		INSERT INTO @OfertasPersonalizadas
		SELECT ISNULL(Orden, 0)
			,CUV
			,TipoPersonalizacion
			,FlagRevista
			,CONVERT(INT, AnioCampanaVenta)
			,DiaInicio
		FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
		WHERE op.CodConsultora = @codConsultoraDefault
			AND op.AnioCampanaVenta = @StrCampaniaID
			AND op.TipoPersonalizacion = 'ODD'
	END

	INSERT INTO @OfertasPersonalizadas (
		Orden
		,CUV
		,TipoPersonalizacion
		,FlagRevista
		,AnioCampanaVenta
		,DiaInicio
		)
	SELECT Orden
		,CUV
		,TipoPersonalizacion
		,FlagRevista
		,AnioCampanaVenta
		,DiaInicio
	FROM dbo.ListarEstrategiasForzadas(@CodCampania, @EstrategiaCodigo)

	SELECT e.EstrategiaID
		,e.CUV2
		,e.DescripcionCUV2
		,'' AS EtiquetaDescripcion
		,e.Precio
		,'' AS EtiquetaDescripcion2
		,e.Precio2
		,ISNULL(e.TextoLibre, '') AS TextoLibre
		,e.CodigoEstrategia
		,0 AS FlagEstrella
		,'' AS ColorFondo
		,e.TipoEstrategiaID
		,e.ImagenURL AS FotoProducto01
		,te.ImagenEstrategia AS ImagenURL
		,e.LimiteVenta
		,pc.MarcaID
		,te.Orden AS Orden1
		,op.Orden Orden2
		,pc.IndicadorMontoMinimo
		,pc.CodigoProducto
		,0 AS FlagNueva
		,'' AS TipoTallaColor
		,3 AS TipoEstrategiaImagenMostrar
		,e.EtiquetaID
		,e.EtiquetaID2
		,e.CodigoEstrategia
		,e.TieneVariedad
		,te.Codigo
		,te.DescripcionEstrategia
		,ISNULL(te.FlagMostrarImg, 0) AS FlagMostrarImg
		,e.PrecioPublico
		,e.Ganancia
		,m.Descripcion AS DescripcionMarca
		,op.FlagRevista
		--adicionales
		,ISNULL(e.ImagenMiniaturaURL, '') AS ImagenMiniaturaURL
		,op.DiaInicio
		, CASE WHEN TF.CUV IS NULL THEN 1 ELSE 0 END AS TieneStock
	FROM TipoEstrategia te WITH (NOLOCK)
	INNER JOIN dbo.Estrategia e WITH (NOLOCK) ON te.TipoEstrategiaId = e.TipoEstrategiaId
		AND te.Codigo = @EstrategiaCodigo
	INNER JOIN @OfertasPersonalizadas op ON e.CampaniaID = op.AnioCampanaVenta
		AND e.CUV2 = op.CUV
	INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON e.CampaniaID = pc.AnoCampania
		AND e.CUV2 = pc.CUV
	--INNER JOIN dbo.TipoEstrategia TE WITH (NOLOCK) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
	--	AND TE.Codigo = @EstrategiaCodigo
	LEFT JOIN dbo.Marca M WITH (NOLOCK) ON pc.MarcaId = m.MarcaId
	LEFT JOIN @tablaCuvFaltante TF on TF.CUV = E.CUV2
	WHERE e.Activo = 1
		--AND NOT EXISTS (
		--	SELECT CUV
		--	FROM @tablaCuvFaltante TF
		--	WHERE E.CUV2 = TF.CUV
		--	)
		AND DATEDIFF(dd, GETDATE(), DATEADD(dd, op.DiaInicio, CAST(@FechaInicioFact AS DATE))) = 0
	ORDER BY op.Orden ASC
		,EstrategiaID ASC

	SET NOCOUNT OFF
END
GO

USE BelcorpPanama
GO

/****** Object:  StoredProcedure [dbo].[ListarEstrategiasODD2]    Script Date: 20/11/2018 16:52:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[ListarEstrategiasODD2] (
	@CodCampania INT
	,@CodConsultora VARCHAR(10)
	,@FechaInicioFact DATE
	)
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @StrCampaniaID CHAR(6) = CONVERT(CHAR(6), @CodCampania)
	DECLARE @EstrategiaCodigo VARCHAR(100) = '009'
	DECLARE @tablaCuvFaltante TABLE (CUV VARCHAR(6))
	DECLARE @OfertasPersonalizadas TABLE (
		Orden INT
		,CUV CHAR(6)
		,TipoPersonalizacion CHAR(3)
		,FlagRevista INT
		,AnioCampanaVenta INT
		,DiaInicio INT
		)

	INSERT INTO @tablaCuvFaltante (CUV)
	SELECT CUV
	FROM dbo.ObtenerCuvFaltante(@CodCampania, @CodConsultora)

	DECLARE @codConsultoraForzada VARCHAR(9) = ''
	DECLARE @codConsultoraDefault VARCHAR(9) = ''

	SELECT @codConsultoraForzada = Codigo
	FROM TablaLogicaDatos WITH (NOLOCK)
	WHERE TablaLogicaDatosID = 10002

	SELECT @codConsultoraDefault = Codigo
	FROM TablaLogicaDatos WITH (NOLOCK)
	WHERE TablaLogicaDatosID = 10001

	INSERT INTO @OfertasPersonalizadas
	SELECT ISNULL(Orden, 0)
		,CUV
		,TipoPersonalizacion
		,FlagRevista
		,CONVERT(INT, AnioCampanaVenta)
		,DiaInicio
	FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
	WHERE op.CodConsultora = @CodConsultora
		AND op.AnioCampanaVenta = @StrCampaniaID
		AND op.TipoPersonalizacion = 'ODD'

	IF NOT EXISTS (
			SELECT CUV
			FROM @OfertasPersonalizadas
			)
	BEGIN
		INSERT INTO @OfertasPersonalizadas
		SELECT ISNULL(Orden, 0)
			,CUV
			,TipoPersonalizacion
			,FlagRevista
			,CONVERT(INT, AnioCampanaVenta)
			,DiaInicio
		FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
		WHERE op.CodConsultora = @codConsultoraDefault
			AND op.AnioCampanaVenta = @StrCampaniaID
			AND op.TipoPersonalizacion = 'ODD'
	END

	INSERT INTO @OfertasPersonalizadas (
		Orden
		,CUV
		,TipoPersonalizacion
		,FlagRevista
		,AnioCampanaVenta
		,DiaInicio
		)
	SELECT Orden
		,CUV
		,TipoPersonalizacion
		,FlagRevista
		,AnioCampanaVenta
		,DiaInicio
	FROM dbo.ListarEstrategiasForzadas(@CodCampania, @EstrategiaCodigo)

	SELECT e.EstrategiaID
		,e.CUV2
		,e.DescripcionCUV2
		,'' AS EtiquetaDescripcion
		,e.Precio
		,'' AS EtiquetaDescripcion2
		,e.Precio2
		,ISNULL(e.TextoLibre, '') AS TextoLibre
		,e.CodigoEstrategia
		,0 AS FlagEstrella
		,'' AS ColorFondo
		,e.TipoEstrategiaID
		,e.ImagenURL AS FotoProducto01
		,te.ImagenEstrategia AS ImagenURL
		,e.LimiteVenta
		,pc.MarcaID
		,te.Orden AS Orden1
		,op.Orden Orden2
		,pc.IndicadorMontoMinimo
		,pc.CodigoProducto
		,0 AS FlagNueva
		,'' AS TipoTallaColor
		,3 AS TipoEstrategiaImagenMostrar
		,e.EtiquetaID
		,e.EtiquetaID2
		,e.CodigoEstrategia
		,e.TieneVariedad
		,te.Codigo
		,te.DescripcionEstrategia
		,ISNULL(te.FlagMostrarImg, 0) AS FlagMostrarImg
		,e.PrecioPublico
		,e.Ganancia
		,m.Descripcion AS DescripcionMarca
		,op.FlagRevista
		--adicionales
		,ISNULL(e.ImagenMiniaturaURL, '') AS ImagenMiniaturaURL
		,op.DiaInicio
		, CASE WHEN TF.CUV IS NULL THEN 1 ELSE 0 END AS TieneStock
	FROM TipoEstrategia te WITH (NOLOCK)
	INNER JOIN dbo.Estrategia e WITH (NOLOCK) ON te.TipoEstrategiaId = e.TipoEstrategiaId
		AND te.Codigo = @EstrategiaCodigo
	INNER JOIN @OfertasPersonalizadas op ON e.CampaniaID = op.AnioCampanaVenta
		AND e.CUV2 = op.CUV
	INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON e.CampaniaID = pc.AnoCampania
		AND e.CUV2 = pc.CUV
	--INNER JOIN dbo.TipoEstrategia TE WITH (NOLOCK) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
	--	AND TE.Codigo = @EstrategiaCodigo
	LEFT JOIN dbo.Marca M WITH (NOLOCK) ON pc.MarcaId = m.MarcaId
	LEFT JOIN @tablaCuvFaltante TF on TF.CUV = E.CUV2
	WHERE e.Activo = 1
		--AND NOT EXISTS (
		--	SELECT CUV
		--	FROM @tablaCuvFaltante TF
		--	WHERE E.CUV2 = TF.CUV
		--	)
		AND DATEDIFF(dd, GETDATE(), DATEADD(dd, op.DiaInicio, CAST(@FechaInicioFact AS DATE))) = 0
	ORDER BY op.Orden ASC
		,EstrategiaID ASC

	SET NOCOUNT OFF
END
GO

USE BelcorpGuatemala
GO

/****** Object:  StoredProcedure [dbo].[ListarEstrategiasODD2]    Script Date: 20/11/2018 16:52:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[ListarEstrategiasODD2] (
	@CodCampania INT
	,@CodConsultora VARCHAR(10)
	,@FechaInicioFact DATE
	)
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @StrCampaniaID CHAR(6) = CONVERT(CHAR(6), @CodCampania)
	DECLARE @EstrategiaCodigo VARCHAR(100) = '009'
	DECLARE @tablaCuvFaltante TABLE (CUV VARCHAR(6))
	DECLARE @OfertasPersonalizadas TABLE (
		Orden INT
		,CUV CHAR(6)
		,TipoPersonalizacion CHAR(3)
		,FlagRevista INT
		,AnioCampanaVenta INT
		,DiaInicio INT
		)

	INSERT INTO @tablaCuvFaltante (CUV)
	SELECT CUV
	FROM dbo.ObtenerCuvFaltante(@CodCampania, @CodConsultora)

	DECLARE @codConsultoraForzada VARCHAR(9) = ''
	DECLARE @codConsultoraDefault VARCHAR(9) = ''

	SELECT @codConsultoraForzada = Codigo
	FROM TablaLogicaDatos WITH (NOLOCK)
	WHERE TablaLogicaDatosID = 10002

	SELECT @codConsultoraDefault = Codigo
	FROM TablaLogicaDatos WITH (NOLOCK)
	WHERE TablaLogicaDatosID = 10001

	INSERT INTO @OfertasPersonalizadas
	SELECT ISNULL(Orden, 0)
		,CUV
		,TipoPersonalizacion
		,FlagRevista
		,CONVERT(INT, AnioCampanaVenta)
		,DiaInicio
	FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
	WHERE op.CodConsultora = @CodConsultora
		AND op.AnioCampanaVenta = @StrCampaniaID
		AND op.TipoPersonalizacion = 'ODD'

	IF NOT EXISTS (
			SELECT CUV
			FROM @OfertasPersonalizadas
			)
	BEGIN
		INSERT INTO @OfertasPersonalizadas
		SELECT ISNULL(Orden, 0)
			,CUV
			,TipoPersonalizacion
			,FlagRevista
			,CONVERT(INT, AnioCampanaVenta)
			,DiaInicio
		FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
		WHERE op.CodConsultora = @codConsultoraDefault
			AND op.AnioCampanaVenta = @StrCampaniaID
			AND op.TipoPersonalizacion = 'ODD'
	END

	INSERT INTO @OfertasPersonalizadas (
		Orden
		,CUV
		,TipoPersonalizacion
		,FlagRevista
		,AnioCampanaVenta
		,DiaInicio
		)
	SELECT Orden
		,CUV
		,TipoPersonalizacion
		,FlagRevista
		,AnioCampanaVenta
		,DiaInicio
	FROM dbo.ListarEstrategiasForzadas(@CodCampania, @EstrategiaCodigo)

	SELECT e.EstrategiaID
		,e.CUV2
		,e.DescripcionCUV2
		,'' AS EtiquetaDescripcion
		,e.Precio
		,'' AS EtiquetaDescripcion2
		,e.Precio2
		,ISNULL(e.TextoLibre, '') AS TextoLibre
		,e.CodigoEstrategia
		,0 AS FlagEstrella
		,'' AS ColorFondo
		,e.TipoEstrategiaID
		,e.ImagenURL AS FotoProducto01
		,te.ImagenEstrategia AS ImagenURL
		,e.LimiteVenta
		,pc.MarcaID
		,te.Orden AS Orden1
		,op.Orden Orden2
		,pc.IndicadorMontoMinimo
		,pc.CodigoProducto
		,0 AS FlagNueva
		,'' AS TipoTallaColor
		,3 AS TipoEstrategiaImagenMostrar
		,e.EtiquetaID
		,e.EtiquetaID2
		,e.CodigoEstrategia
		,e.TieneVariedad
		,te.Codigo
		,te.DescripcionEstrategia
		,ISNULL(te.FlagMostrarImg, 0) AS FlagMostrarImg
		,e.PrecioPublico
		,e.Ganancia
		,m.Descripcion AS DescripcionMarca
		,op.FlagRevista
		--adicionales
		,ISNULL(e.ImagenMiniaturaURL, '') AS ImagenMiniaturaURL
		,op.DiaInicio
		, CASE WHEN TF.CUV IS NULL THEN 1 ELSE 0 END AS TieneStock
	FROM TipoEstrategia te WITH (NOLOCK)
	INNER JOIN dbo.Estrategia e WITH (NOLOCK) ON te.TipoEstrategiaId = e.TipoEstrategiaId
		AND te.Codigo = @EstrategiaCodigo
	INNER JOIN @OfertasPersonalizadas op ON e.CampaniaID = op.AnioCampanaVenta
		AND e.CUV2 = op.CUV
	INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON e.CampaniaID = pc.AnoCampania
		AND e.CUV2 = pc.CUV
	--INNER JOIN dbo.TipoEstrategia TE WITH (NOLOCK) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
	--	AND TE.Codigo = @EstrategiaCodigo
	LEFT JOIN dbo.Marca M WITH (NOLOCK) ON pc.MarcaId = m.MarcaId
	LEFT JOIN @tablaCuvFaltante TF on TF.CUV = E.CUV2
	WHERE e.Activo = 1
		--AND NOT EXISTS (
		--	SELECT CUV
		--	FROM @tablaCuvFaltante TF
		--	WHERE E.CUV2 = TF.CUV
		--	)
		AND DATEDIFF(dd, GETDATE(), DATEADD(dd, op.DiaInicio, CAST(@FechaInicioFact AS DATE))) = 0
	ORDER BY op.Orden ASC
		,EstrategiaID ASC

	SET NOCOUNT OFF
END
GO

USE BelcorpEcuador
GO

/****** Object:  StoredProcedure [dbo].[ListarEstrategiasODD2]    Script Date: 20/11/2018 16:52:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[ListarEstrategiasODD2] (
	@CodCampania INT
	,@CodConsultora VARCHAR(10)
	,@FechaInicioFact DATE
	)
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @StrCampaniaID CHAR(6) = CONVERT(CHAR(6), @CodCampania)
	DECLARE @EstrategiaCodigo VARCHAR(100) = '009'
	DECLARE @tablaCuvFaltante TABLE (CUV VARCHAR(6))
	DECLARE @OfertasPersonalizadas TABLE (
		Orden INT
		,CUV CHAR(6)
		,TipoPersonalizacion CHAR(3)
		,FlagRevista INT
		,AnioCampanaVenta INT
		,DiaInicio INT
		)

	INSERT INTO @tablaCuvFaltante (CUV)
	SELECT CUV
	FROM dbo.ObtenerCuvFaltante(@CodCampania, @CodConsultora)

	DECLARE @codConsultoraForzada VARCHAR(9) = ''
	DECLARE @codConsultoraDefault VARCHAR(9) = ''

	SELECT @codConsultoraForzada = Codigo
	FROM TablaLogicaDatos WITH (NOLOCK)
	WHERE TablaLogicaDatosID = 10002

	SELECT @codConsultoraDefault = Codigo
	FROM TablaLogicaDatos WITH (NOLOCK)
	WHERE TablaLogicaDatosID = 10001

	INSERT INTO @OfertasPersonalizadas
	SELECT ISNULL(Orden, 0)
		,CUV
		,TipoPersonalizacion
		,FlagRevista
		,CONVERT(INT, AnioCampanaVenta)
		,DiaInicio
	FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
	WHERE op.CodConsultora = @CodConsultora
		AND op.AnioCampanaVenta = @StrCampaniaID
		AND op.TipoPersonalizacion = 'ODD'

	IF NOT EXISTS (
			SELECT CUV
			FROM @OfertasPersonalizadas
			)
	BEGIN
		INSERT INTO @OfertasPersonalizadas
		SELECT ISNULL(Orden, 0)
			,CUV
			,TipoPersonalizacion
			,FlagRevista
			,CONVERT(INT, AnioCampanaVenta)
			,DiaInicio
		FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
		WHERE op.CodConsultora = @codConsultoraDefault
			AND op.AnioCampanaVenta = @StrCampaniaID
			AND op.TipoPersonalizacion = 'ODD'
	END

	INSERT INTO @OfertasPersonalizadas (
		Orden
		,CUV
		,TipoPersonalizacion
		,FlagRevista
		,AnioCampanaVenta
		,DiaInicio
		)
	SELECT Orden
		,CUV
		,TipoPersonalizacion
		,FlagRevista
		,AnioCampanaVenta
		,DiaInicio
	FROM dbo.ListarEstrategiasForzadas(@CodCampania, @EstrategiaCodigo)

	SELECT e.EstrategiaID
		,e.CUV2
		,e.DescripcionCUV2
		,'' AS EtiquetaDescripcion
		,e.Precio
		,'' AS EtiquetaDescripcion2
		,e.Precio2
		,ISNULL(e.TextoLibre, '') AS TextoLibre
		,e.CodigoEstrategia
		,0 AS FlagEstrella
		,'' AS ColorFondo
		,e.TipoEstrategiaID
		,e.ImagenURL AS FotoProducto01
		,te.ImagenEstrategia AS ImagenURL
		,e.LimiteVenta
		,pc.MarcaID
		,te.Orden AS Orden1
		,op.Orden Orden2
		,pc.IndicadorMontoMinimo
		,pc.CodigoProducto
		,0 AS FlagNueva
		,'' AS TipoTallaColor
		,3 AS TipoEstrategiaImagenMostrar
		,e.EtiquetaID
		,e.EtiquetaID2
		,e.CodigoEstrategia
		,e.TieneVariedad
		,te.Codigo
		,te.DescripcionEstrategia
		,ISNULL(te.FlagMostrarImg, 0) AS FlagMostrarImg
		,e.PrecioPublico
		,e.Ganancia
		,m.Descripcion AS DescripcionMarca
		,op.FlagRevista
		--adicionales
		,ISNULL(e.ImagenMiniaturaURL, '') AS ImagenMiniaturaURL
		,op.DiaInicio
		, CASE WHEN TF.CUV IS NULL THEN 1 ELSE 0 END AS TieneStock
	FROM TipoEstrategia te WITH (NOLOCK)
	INNER JOIN dbo.Estrategia e WITH (NOLOCK) ON te.TipoEstrategiaId = e.TipoEstrategiaId
		AND te.Codigo = @EstrategiaCodigo
	INNER JOIN @OfertasPersonalizadas op ON e.CampaniaID = op.AnioCampanaVenta
		AND e.CUV2 = op.CUV
	INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON e.CampaniaID = pc.AnoCampania
		AND e.CUV2 = pc.CUV
	--INNER JOIN dbo.TipoEstrategia TE WITH (NOLOCK) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
	--	AND TE.Codigo = @EstrategiaCodigo
	LEFT JOIN dbo.Marca M WITH (NOLOCK) ON pc.MarcaId = m.MarcaId
	LEFT JOIN @tablaCuvFaltante TF on TF.CUV = E.CUV2
	WHERE e.Activo = 1
		--AND NOT EXISTS (
		--	SELECT CUV
		--	FROM @tablaCuvFaltante TF
		--	WHERE E.CUV2 = TF.CUV
		--	)
		AND DATEDIFF(dd, GETDATE(), DATEADD(dd, op.DiaInicio, CAST(@FechaInicioFact AS DATE))) = 0
	ORDER BY op.Orden ASC
		,EstrategiaID ASC

	SET NOCOUNT OFF
END
GO

USE BelcorpDominicana
GO

/****** Object:  StoredProcedure [dbo].[ListarEstrategiasODD2]    Script Date: 20/11/2018 16:52:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[ListarEstrategiasODD2] (
	@CodCampania INT
	,@CodConsultora VARCHAR(10)
	,@FechaInicioFact DATE
	)
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @StrCampaniaID CHAR(6) = CONVERT(CHAR(6), @CodCampania)
	DECLARE @EstrategiaCodigo VARCHAR(100) = '009'
	DECLARE @tablaCuvFaltante TABLE (CUV VARCHAR(6))
	DECLARE @OfertasPersonalizadas TABLE (
		Orden INT
		,CUV CHAR(6)
		,TipoPersonalizacion CHAR(3)
		,FlagRevista INT
		,AnioCampanaVenta INT
		,DiaInicio INT
		)

	INSERT INTO @tablaCuvFaltante (CUV)
	SELECT CUV
	FROM dbo.ObtenerCuvFaltante(@CodCampania, @CodConsultora)

	DECLARE @codConsultoraForzada VARCHAR(9) = ''
	DECLARE @codConsultoraDefault VARCHAR(9) = ''

	SELECT @codConsultoraForzada = Codigo
	FROM TablaLogicaDatos WITH (NOLOCK)
	WHERE TablaLogicaDatosID = 10002

	SELECT @codConsultoraDefault = Codigo
	FROM TablaLogicaDatos WITH (NOLOCK)
	WHERE TablaLogicaDatosID = 10001

	INSERT INTO @OfertasPersonalizadas
	SELECT ISNULL(Orden, 0)
		,CUV
		,TipoPersonalizacion
		,FlagRevista
		,CONVERT(INT, AnioCampanaVenta)
		,DiaInicio
	FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
	WHERE op.CodConsultora = @CodConsultora
		AND op.AnioCampanaVenta = @StrCampaniaID
		AND op.TipoPersonalizacion = 'ODD'

	IF NOT EXISTS (
			SELECT CUV
			FROM @OfertasPersonalizadas
			)
	BEGIN
		INSERT INTO @OfertasPersonalizadas
		SELECT ISNULL(Orden, 0)
			,CUV
			,TipoPersonalizacion
			,FlagRevista
			,CONVERT(INT, AnioCampanaVenta)
			,DiaInicio
		FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
		WHERE op.CodConsultora = @codConsultoraDefault
			AND op.AnioCampanaVenta = @StrCampaniaID
			AND op.TipoPersonalizacion = 'ODD'
	END

	INSERT INTO @OfertasPersonalizadas (
		Orden
		,CUV
		,TipoPersonalizacion
		,FlagRevista
		,AnioCampanaVenta
		,DiaInicio
		)
	SELECT Orden
		,CUV
		,TipoPersonalizacion
		,FlagRevista
		,AnioCampanaVenta
		,DiaInicio
	FROM dbo.ListarEstrategiasForzadas(@CodCampania, @EstrategiaCodigo)

	SELECT e.EstrategiaID
		,e.CUV2
		,e.DescripcionCUV2
		,'' AS EtiquetaDescripcion
		,e.Precio
		,'' AS EtiquetaDescripcion2
		,e.Precio2
		,ISNULL(e.TextoLibre, '') AS TextoLibre
		,e.CodigoEstrategia
		,0 AS FlagEstrella
		,'' AS ColorFondo
		,e.TipoEstrategiaID
		,e.ImagenURL AS FotoProducto01
		,te.ImagenEstrategia AS ImagenURL
		,e.LimiteVenta
		,pc.MarcaID
		,te.Orden AS Orden1
		,op.Orden Orden2
		,pc.IndicadorMontoMinimo
		,pc.CodigoProducto
		,0 AS FlagNueva
		,'' AS TipoTallaColor
		,3 AS TipoEstrategiaImagenMostrar
		,e.EtiquetaID
		,e.EtiquetaID2
		,e.CodigoEstrategia
		,e.TieneVariedad
		,te.Codigo
		,te.DescripcionEstrategia
		,ISNULL(te.FlagMostrarImg, 0) AS FlagMostrarImg
		,e.PrecioPublico
		,e.Ganancia
		,m.Descripcion AS DescripcionMarca
		,op.FlagRevista
		--adicionales
		,ISNULL(e.ImagenMiniaturaURL, '') AS ImagenMiniaturaURL
		,op.DiaInicio
		, CASE WHEN TF.CUV IS NULL THEN 1 ELSE 0 END AS TieneStock
	FROM TipoEstrategia te WITH (NOLOCK)
	INNER JOIN dbo.Estrategia e WITH (NOLOCK) ON te.TipoEstrategiaId = e.TipoEstrategiaId
		AND te.Codigo = @EstrategiaCodigo
	INNER JOIN @OfertasPersonalizadas op ON e.CampaniaID = op.AnioCampanaVenta
		AND e.CUV2 = op.CUV
	INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON e.CampaniaID = pc.AnoCampania
		AND e.CUV2 = pc.CUV
	--INNER JOIN dbo.TipoEstrategia TE WITH (NOLOCK) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
	--	AND TE.Codigo = @EstrategiaCodigo
	LEFT JOIN dbo.Marca M WITH (NOLOCK) ON pc.MarcaId = m.MarcaId
	LEFT JOIN @tablaCuvFaltante TF on TF.CUV = E.CUV2
	WHERE e.Activo = 1
		--AND NOT EXISTS (
		--	SELECT CUV
		--	FROM @tablaCuvFaltante TF
		--	WHERE E.CUV2 = TF.CUV
		--	)
		AND DATEDIFF(dd, GETDATE(), DATEADD(dd, op.DiaInicio, CAST(@FechaInicioFact AS DATE))) = 0
	ORDER BY op.Orden ASC
		,EstrategiaID ASC

	SET NOCOUNT OFF
END
GO

USE BelcorpCostaRica
GO

/****** Object:  StoredProcedure [dbo].[ListarEstrategiasODD2]    Script Date: 20/11/2018 16:52:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[ListarEstrategiasODD2] (
	@CodCampania INT
	,@CodConsultora VARCHAR(10)
	,@FechaInicioFact DATE
	)
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @StrCampaniaID CHAR(6) = CONVERT(CHAR(6), @CodCampania)
	DECLARE @EstrategiaCodigo VARCHAR(100) = '009'
	DECLARE @tablaCuvFaltante TABLE (CUV VARCHAR(6))
	DECLARE @OfertasPersonalizadas TABLE (
		Orden INT
		,CUV CHAR(6)
		,TipoPersonalizacion CHAR(3)
		,FlagRevista INT
		,AnioCampanaVenta INT
		,DiaInicio INT
		)

	INSERT INTO @tablaCuvFaltante (CUV)
	SELECT CUV
	FROM dbo.ObtenerCuvFaltante(@CodCampania, @CodConsultora)

	DECLARE @codConsultoraForzada VARCHAR(9) = ''
	DECLARE @codConsultoraDefault VARCHAR(9) = ''

	SELECT @codConsultoraForzada = Codigo
	FROM TablaLogicaDatos WITH (NOLOCK)
	WHERE TablaLogicaDatosID = 10002

	SELECT @codConsultoraDefault = Codigo
	FROM TablaLogicaDatos WITH (NOLOCK)
	WHERE TablaLogicaDatosID = 10001

	INSERT INTO @OfertasPersonalizadas
	SELECT ISNULL(Orden, 0)
		,CUV
		,TipoPersonalizacion
		,FlagRevista
		,CONVERT(INT, AnioCampanaVenta)
		,DiaInicio
	FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
	WHERE op.CodConsultora = @CodConsultora
		AND op.AnioCampanaVenta = @StrCampaniaID
		AND op.TipoPersonalizacion = 'ODD'

	IF NOT EXISTS (
			SELECT CUV
			FROM @OfertasPersonalizadas
			)
	BEGIN
		INSERT INTO @OfertasPersonalizadas
		SELECT ISNULL(Orden, 0)
			,CUV
			,TipoPersonalizacion
			,FlagRevista
			,CONVERT(INT, AnioCampanaVenta)
			,DiaInicio
		FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
		WHERE op.CodConsultora = @codConsultoraDefault
			AND op.AnioCampanaVenta = @StrCampaniaID
			AND op.TipoPersonalizacion = 'ODD'
	END

	INSERT INTO @OfertasPersonalizadas (
		Orden
		,CUV
		,TipoPersonalizacion
		,FlagRevista
		,AnioCampanaVenta
		,DiaInicio
		)
	SELECT Orden
		,CUV
		,TipoPersonalizacion
		,FlagRevista
		,AnioCampanaVenta
		,DiaInicio
	FROM dbo.ListarEstrategiasForzadas(@CodCampania, @EstrategiaCodigo)

	SELECT e.EstrategiaID
		,e.CUV2
		,e.DescripcionCUV2
		,'' AS EtiquetaDescripcion
		,e.Precio
		,'' AS EtiquetaDescripcion2
		,e.Precio2
		,ISNULL(e.TextoLibre, '') AS TextoLibre
		,e.CodigoEstrategia
		,0 AS FlagEstrella
		,'' AS ColorFondo
		,e.TipoEstrategiaID
		,e.ImagenURL AS FotoProducto01
		,te.ImagenEstrategia AS ImagenURL
		,e.LimiteVenta
		,pc.MarcaID
		,te.Orden AS Orden1
		,op.Orden Orden2
		,pc.IndicadorMontoMinimo
		,pc.CodigoProducto
		,0 AS FlagNueva
		,'' AS TipoTallaColor
		,3 AS TipoEstrategiaImagenMostrar
		,e.EtiquetaID
		,e.EtiquetaID2
		,e.CodigoEstrategia
		,e.TieneVariedad
		,te.Codigo
		,te.DescripcionEstrategia
		,ISNULL(te.FlagMostrarImg, 0) AS FlagMostrarImg
		,e.PrecioPublico
		,e.Ganancia
		,m.Descripcion AS DescripcionMarca
		,op.FlagRevista
		--adicionales
		,ISNULL(e.ImagenMiniaturaURL, '') AS ImagenMiniaturaURL
		,op.DiaInicio
		, CASE WHEN TF.CUV IS NULL THEN 1 ELSE 0 END AS TieneStock
	FROM TipoEstrategia te WITH (NOLOCK)
	INNER JOIN dbo.Estrategia e WITH (NOLOCK) ON te.TipoEstrategiaId = e.TipoEstrategiaId
		AND te.Codigo = @EstrategiaCodigo
	INNER JOIN @OfertasPersonalizadas op ON e.CampaniaID = op.AnioCampanaVenta
		AND e.CUV2 = op.CUV
	INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON e.CampaniaID = pc.AnoCampania
		AND e.CUV2 = pc.CUV
	--INNER JOIN dbo.TipoEstrategia TE WITH (NOLOCK) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
	--	AND TE.Codigo = @EstrategiaCodigo
	LEFT JOIN dbo.Marca M WITH (NOLOCK) ON pc.MarcaId = m.MarcaId
	LEFT JOIN @tablaCuvFaltante TF on TF.CUV = E.CUV2
	WHERE e.Activo = 1
		--AND NOT EXISTS (
		--	SELECT CUV
		--	FROM @tablaCuvFaltante TF
		--	WHERE E.CUV2 = TF.CUV
		--	)
		AND DATEDIFF(dd, GETDATE(), DATEADD(dd, op.DiaInicio, CAST(@FechaInicioFact AS DATE))) = 0
	ORDER BY op.Orden ASC
		,EstrategiaID ASC

	SET NOCOUNT OFF
END
GO

USE BelcorpChile
GO

/****** Object:  StoredProcedure [dbo].[ListarEstrategiasODD2]    Script Date: 20/11/2018 16:52:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[ListarEstrategiasODD2] (
	@CodCampania INT
	,@CodConsultora VARCHAR(10)
	,@FechaInicioFact DATE
	)
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @StrCampaniaID CHAR(6) = CONVERT(CHAR(6), @CodCampania)
	DECLARE @EstrategiaCodigo VARCHAR(100) = '009'
	DECLARE @tablaCuvFaltante TABLE (CUV VARCHAR(6))
	DECLARE @OfertasPersonalizadas TABLE (
		Orden INT
		,CUV CHAR(6)
		,TipoPersonalizacion CHAR(3)
		,FlagRevista INT
		,AnioCampanaVenta INT
		,DiaInicio INT
		)

	INSERT INTO @tablaCuvFaltante (CUV)
	SELECT CUV
	FROM dbo.ObtenerCuvFaltante(@CodCampania, @CodConsultora)

	DECLARE @codConsultoraForzada VARCHAR(9) = ''
	DECLARE @codConsultoraDefault VARCHAR(9) = ''

	SELECT @codConsultoraForzada = Codigo
	FROM TablaLogicaDatos WITH (NOLOCK)
	WHERE TablaLogicaDatosID = 10002

	SELECT @codConsultoraDefault = Codigo
	FROM TablaLogicaDatos WITH (NOLOCK)
	WHERE TablaLogicaDatosID = 10001

	INSERT INTO @OfertasPersonalizadas
	SELECT ISNULL(Orden, 0)
		,CUV
		,TipoPersonalizacion
		,FlagRevista
		,CONVERT(INT, AnioCampanaVenta)
		,DiaInicio
	FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
	WHERE op.CodConsultora = @CodConsultora
		AND op.AnioCampanaVenta = @StrCampaniaID
		AND op.TipoPersonalizacion = 'ODD'

	IF NOT EXISTS (
			SELECT CUV
			FROM @OfertasPersonalizadas
			)
	BEGIN
		INSERT INTO @OfertasPersonalizadas
		SELECT ISNULL(Orden, 0)
			,CUV
			,TipoPersonalizacion
			,FlagRevista
			,CONVERT(INT, AnioCampanaVenta)
			,DiaInicio
		FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
		WHERE op.CodConsultora = @codConsultoraDefault
			AND op.AnioCampanaVenta = @StrCampaniaID
			AND op.TipoPersonalizacion = 'ODD'
	END

	INSERT INTO @OfertasPersonalizadas (
		Orden
		,CUV
		,TipoPersonalizacion
		,FlagRevista
		,AnioCampanaVenta
		,DiaInicio
		)
	SELECT Orden
		,CUV
		,TipoPersonalizacion
		,FlagRevista
		,AnioCampanaVenta
		,DiaInicio
	FROM dbo.ListarEstrategiasForzadas(@CodCampania, @EstrategiaCodigo)

	SELECT e.EstrategiaID
		,e.CUV2
		,e.DescripcionCUV2
		,'' AS EtiquetaDescripcion
		,e.Precio
		,'' AS EtiquetaDescripcion2
		,e.Precio2
		,ISNULL(e.TextoLibre, '') AS TextoLibre
		,e.CodigoEstrategia
		,0 AS FlagEstrella
		,'' AS ColorFondo
		,e.TipoEstrategiaID
		,e.ImagenURL AS FotoProducto01
		,te.ImagenEstrategia AS ImagenURL
		,e.LimiteVenta
		,pc.MarcaID
		,te.Orden AS Orden1
		,op.Orden Orden2
		,pc.IndicadorMontoMinimo
		,pc.CodigoProducto
		,0 AS FlagNueva
		,'' AS TipoTallaColor
		,3 AS TipoEstrategiaImagenMostrar
		,e.EtiquetaID
		,e.EtiquetaID2
		,e.CodigoEstrategia
		,e.TieneVariedad
		,te.Codigo
		,te.DescripcionEstrategia
		,ISNULL(te.FlagMostrarImg, 0) AS FlagMostrarImg
		,e.PrecioPublico
		,e.Ganancia
		,m.Descripcion AS DescripcionMarca
		,op.FlagRevista
		--adicionales
		,ISNULL(e.ImagenMiniaturaURL, '') AS ImagenMiniaturaURL
		,op.DiaInicio
		, CASE WHEN TF.CUV IS NULL THEN 1 ELSE 0 END AS TieneStock
	FROM TipoEstrategia te WITH (NOLOCK)
	INNER JOIN dbo.Estrategia e WITH (NOLOCK) ON te.TipoEstrategiaId = e.TipoEstrategiaId
		AND te.Codigo = @EstrategiaCodigo
	INNER JOIN @OfertasPersonalizadas op ON e.CampaniaID = op.AnioCampanaVenta
		AND e.CUV2 = op.CUV
	INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON e.CampaniaID = pc.AnoCampania
		AND e.CUV2 = pc.CUV
	--INNER JOIN dbo.TipoEstrategia TE WITH (NOLOCK) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
	--	AND TE.Codigo = @EstrategiaCodigo
	LEFT JOIN dbo.Marca M WITH (NOLOCK) ON pc.MarcaId = m.MarcaId
	LEFT JOIN @tablaCuvFaltante TF on TF.CUV = E.CUV2
	WHERE e.Activo = 1
		--AND NOT EXISTS (
		--	SELECT CUV
		--	FROM @tablaCuvFaltante TF
		--	WHERE E.CUV2 = TF.CUV
		--	)
		AND DATEDIFF(dd, GETDATE(), DATEADD(dd, op.DiaInicio, CAST(@FechaInicioFact AS DATE))) = 0
	ORDER BY op.Orden ASC
		,EstrategiaID ASC

	SET NOCOUNT OFF
END
GO

USE BelcorpBolivia
GO

/****** Object:  StoredProcedure [dbo].[ListarEstrategiasODD2]    Script Date: 20/11/2018 16:52:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[ListarEstrategiasODD2] (
	@CodCampania INT
	,@CodConsultora VARCHAR(10)
	,@FechaInicioFact DATE
	)
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @StrCampaniaID CHAR(6) = CONVERT(CHAR(6), @CodCampania)
	DECLARE @EstrategiaCodigo VARCHAR(100) = '009'
	DECLARE @tablaCuvFaltante TABLE (CUV VARCHAR(6))
	DECLARE @OfertasPersonalizadas TABLE (
		Orden INT
		,CUV CHAR(6)
		,TipoPersonalizacion CHAR(3)
		,FlagRevista INT
		,AnioCampanaVenta INT
		,DiaInicio INT
		)

	INSERT INTO @tablaCuvFaltante (CUV)
	SELECT CUV
	FROM dbo.ObtenerCuvFaltante(@CodCampania, @CodConsultora)

	DECLARE @codConsultoraForzada VARCHAR(9) = ''
	DECLARE @codConsultoraDefault VARCHAR(9) = ''

	SELECT @codConsultoraForzada = Codigo
	FROM TablaLogicaDatos WITH (NOLOCK)
	WHERE TablaLogicaDatosID = 10002

	SELECT @codConsultoraDefault = Codigo
	FROM TablaLogicaDatos WITH (NOLOCK)
	WHERE TablaLogicaDatosID = 10001

	INSERT INTO @OfertasPersonalizadas
	SELECT ISNULL(Orden, 0)
		,CUV
		,TipoPersonalizacion
		,FlagRevista
		,CONVERT(INT, AnioCampanaVenta)
		,DiaInicio
	FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
	WHERE op.CodConsultora = @CodConsultora
		AND op.AnioCampanaVenta = @StrCampaniaID
		AND op.TipoPersonalizacion = 'ODD'

	IF NOT EXISTS (
			SELECT CUV
			FROM @OfertasPersonalizadas
			)
	BEGIN
		INSERT INTO @OfertasPersonalizadas
		SELECT ISNULL(Orden, 0)
			,CUV
			,TipoPersonalizacion
			,FlagRevista
			,CONVERT(INT, AnioCampanaVenta)
			,DiaInicio
		FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
		WHERE op.CodConsultora = @codConsultoraDefault
			AND op.AnioCampanaVenta = @StrCampaniaID
			AND op.TipoPersonalizacion = 'ODD'
	END

	INSERT INTO @OfertasPersonalizadas (
		Orden
		,CUV
		,TipoPersonalizacion
		,FlagRevista
		,AnioCampanaVenta
		,DiaInicio
		)
	SELECT Orden
		,CUV
		,TipoPersonalizacion
		,FlagRevista
		,AnioCampanaVenta
		,DiaInicio
	FROM dbo.ListarEstrategiasForzadas(@CodCampania, @EstrategiaCodigo)

	SELECT e.EstrategiaID
		,e.CUV2
		,e.DescripcionCUV2
		,'' AS EtiquetaDescripcion
		,e.Precio
		,'' AS EtiquetaDescripcion2
		,e.Precio2
		,ISNULL(e.TextoLibre, '') AS TextoLibre
		,e.CodigoEstrategia
		,0 AS FlagEstrella
		,'' AS ColorFondo
		,e.TipoEstrategiaID
		,e.ImagenURL AS FotoProducto01
		,te.ImagenEstrategia AS ImagenURL
		,e.LimiteVenta
		,pc.MarcaID
		,te.Orden AS Orden1
		,op.Orden Orden2
		,pc.IndicadorMontoMinimo
		,pc.CodigoProducto
		,0 AS FlagNueva
		,'' AS TipoTallaColor
		,3 AS TipoEstrategiaImagenMostrar
		,e.EtiquetaID
		,e.EtiquetaID2
		,e.CodigoEstrategia
		,e.TieneVariedad
		,te.Codigo
		,te.DescripcionEstrategia
		,ISNULL(te.FlagMostrarImg, 0) AS FlagMostrarImg
		,e.PrecioPublico
		,e.Ganancia
		,m.Descripcion AS DescripcionMarca
		,op.FlagRevista
		--adicionales
		,ISNULL(e.ImagenMiniaturaURL, '') AS ImagenMiniaturaURL
		,op.DiaInicio
		, CASE WHEN TF.CUV IS NULL THEN 1 ELSE 0 END AS TieneStock
	FROM TipoEstrategia te WITH (NOLOCK)
	INNER JOIN dbo.Estrategia e WITH (NOLOCK) ON te.TipoEstrategiaId = e.TipoEstrategiaId
		AND te.Codigo = @EstrategiaCodigo
	INNER JOIN @OfertasPersonalizadas op ON e.CampaniaID = op.AnioCampanaVenta
		AND e.CUV2 = op.CUV
	INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON e.CampaniaID = pc.AnoCampania
		AND e.CUV2 = pc.CUV
	--INNER JOIN dbo.TipoEstrategia TE WITH (NOLOCK) ON E.TipoEstrategiaID = TE.TipoEstrategiaID
	--	AND TE.Codigo = @EstrategiaCodigo
	LEFT JOIN dbo.Marca M WITH (NOLOCK) ON pc.MarcaId = m.MarcaId
	LEFT JOIN @tablaCuvFaltante TF on TF.CUV = E.CUV2
	WHERE e.Activo = 1
		--AND NOT EXISTS (
		--	SELECT CUV
		--	FROM @tablaCuvFaltante TF
		--	WHERE E.CUV2 = TF.CUV
		--	)
		AND DATEDIFF(dd, GETDATE(), DATEADD(dd, op.DiaInicio, CAST(@FechaInicioFact AS DATE))) = 0
	ORDER BY op.Orden ASC
		,EstrategiaID ASC

	SET NOCOUNT OFF
END
GO

