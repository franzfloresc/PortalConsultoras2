﻿USE BelcorpPeru
GO

/****** Object:  StoredProcedure [dbo].[ListarEstrategiasShowRoom]    Script Date: 20/11/2018 15:35:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[ListarEstrategiasShowRoom] @CampaniaID INT
	,@CodigoConsultora VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @StrCampaniaID CHAR(6) = CONVERT(CHAR(6), @CampaniaID)
	DECLARE @EstrategiaCodigo VARCHAR(100) = '030'
	DECLARE @OfertasPersonalizadas TABLE (
		Orden INT
		,CUV CHAR(6)
		,TipoPersonalizacion CHAR(3)
		,FlagRevista INT
		,AnioCampanaVenta INT
		)

	DECLARE @codConsultoraDefault VARCHAR(9) = ''

	SELECT @codConsultoraDefault = Codigo
	FROM TablaLogicaDatos WITH (NOLOCK)
	WHERE TablaLogicaDatosID = 10001

	INSERT INTO @OfertasPersonalizadas
	SELECT ISNULL(Orden, 0)
		,CUV
		,TipoPersonalizacion
		,FlagRevista
		,CONVERT(INT, AnioCampanaVenta)
	FROM ods.OfertasPersonalizadas WITH (NOLOCK)
	WHERE CodConsultora = @CodigoConsultora
		AND AnioCampanaVenta = @StrCampaniaID
		AND TipoPersonalizacion = 'SR'

	IF NOT EXISTS (
			SELECT 1
			FROM @OfertasPersonalizadas
			)
	BEGIN
		INSERT INTO @OfertasPersonalizadas
		SELECT ISNULL(Orden, 0)
			,CUV
			,TipoPersonalizacion
			,FlagRevista
			,CONVERT(INT, AnioCampanaVenta)
		FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
		WHERE op.CodConsultora = @codConsultoraDefault
			AND op.AnioCampanaVenta = @StrCampaniaID
			AND op.TipoPersonalizacion = 'SR'
	END

	INSERT INTO @OfertasPersonalizadas (
		Orden
		,CUV
		,TipoPersonalizacion
		,FlagRevista
		,AnioCampanaVenta
		)
	SELECT Orden
		,CUV
		,TipoPersonalizacion
		,FlagRevista
		,AnioCampanaVenta
	FROM dbo.ListarEstrategiasForzadas(@CampaniaID, @EstrategiaCodigo)

	SELECT e.EstrategiaID
		,e.CUV2
		,e.DescripcionCUV2
		,'' AS EtiquetaDescripcion
		,e.Precio
		,'' AS EtiquetaDescripcion2
		,e.Precio2
		,ISNULL(e.TextoLibre, '') AS TextoLibre
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
		,e.EsSubCampania
	FROM TipoEstrategia te WITH (NOLOCK)
	INNER JOIN dbo.Estrategia e WITH (NOLOCK) ON te.TipoEstrategiaId = e.TipoEstrategiaId
		AND te.Codigo = @EstrategiaCodigo
	INNER JOIN @OfertasPersonalizadas op ON e.CampaniaID = op.AnioCampanaVenta
		AND e.CUV2 = op.CUV
	INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON e.CampaniaID = pc.AnoCampania
		AND e.CUV2 = pc.CUV
	--INNER JOIN dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
	LEFT JOIN dbo.Marca M WITH (NOLOCK) ON pc.MarcaId = m.MarcaId
	WHERE e.Activo = 1
	ORDER BY op.Orden ASC
		,EstrategiaID ASC

	SET NOCOUNT OFF
END
GO

USE BelcorpMexico
GO

/****** Object:  StoredProcedure [dbo].[ListarEstrategiasShowRoom]    Script Date: 20/11/2018 15:35:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[ListarEstrategiasShowRoom] @CampaniaID INT
	,@CodigoConsultora VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @StrCampaniaID CHAR(6) = CONVERT(CHAR(6), @CampaniaID)
	DECLARE @EstrategiaCodigo VARCHAR(100) = '030'
	DECLARE @OfertasPersonalizadas TABLE (
		Orden INT
		,CUV CHAR(6)
		,TipoPersonalizacion CHAR(3)
		,FlagRevista INT
		,AnioCampanaVenta INT
		)

	DECLARE @codConsultoraDefault VARCHAR(9) = ''

	SELECT @codConsultoraDefault = Codigo
	FROM TablaLogicaDatos WITH (NOLOCK)
	WHERE TablaLogicaDatosID = 10001

	INSERT INTO @OfertasPersonalizadas
	SELECT ISNULL(Orden, 0)
		,CUV
		,TipoPersonalizacion
		,FlagRevista
		,CONVERT(INT, AnioCampanaVenta)
	FROM ods.OfertasPersonalizadas WITH (NOLOCK)
	WHERE CodConsultora = @CodigoConsultora
		AND AnioCampanaVenta = @StrCampaniaID
		AND TipoPersonalizacion = 'SR'

	IF NOT EXISTS (
			SELECT 1
			FROM @OfertasPersonalizadas
			)
	BEGIN
		INSERT INTO @OfertasPersonalizadas
		SELECT ISNULL(Orden, 0)
			,CUV
			,TipoPersonalizacion
			,FlagRevista
			,CONVERT(INT, AnioCampanaVenta)
		FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
		WHERE op.CodConsultora = @codConsultoraDefault
			AND op.AnioCampanaVenta = @StrCampaniaID
			AND op.TipoPersonalizacion = 'SR'
	END

	INSERT INTO @OfertasPersonalizadas (
		Orden
		,CUV
		,TipoPersonalizacion
		,FlagRevista
		,AnioCampanaVenta
		)
	SELECT Orden
		,CUV
		,TipoPersonalizacion
		,FlagRevista
		,AnioCampanaVenta
	FROM dbo.ListarEstrategiasForzadas(@CampaniaID, @EstrategiaCodigo)

	SELECT e.EstrategiaID
		,e.CUV2
		,e.DescripcionCUV2
		,'' AS EtiquetaDescripcion
		,e.Precio
		,'' AS EtiquetaDescripcion2
		,e.Precio2
		,ISNULL(e.TextoLibre, '') AS TextoLibre
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
		,e.EsSubCampania
	FROM TipoEstrategia te WITH (NOLOCK)
	INNER JOIN dbo.Estrategia e WITH (NOLOCK) ON te.TipoEstrategiaId = e.TipoEstrategiaId
		AND te.Codigo = @EstrategiaCodigo
	INNER JOIN @OfertasPersonalizadas op ON e.CampaniaID = op.AnioCampanaVenta
		AND e.CUV2 = op.CUV
	INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON e.CampaniaID = pc.AnoCampania
		AND e.CUV2 = pc.CUV
	--INNER JOIN dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
	LEFT JOIN dbo.Marca M WITH (NOLOCK) ON pc.MarcaId = m.MarcaId
	WHERE e.Activo = 1
	ORDER BY op.Orden ASC
		,EstrategiaID ASC

	SET NOCOUNT OFF
END
GO

USE BelcorpColombia
GO

/****** Object:  StoredProcedure [dbo].[ListarEstrategiasShowRoom]    Script Date: 20/11/2018 15:35:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[ListarEstrategiasShowRoom] @CampaniaID INT
	,@CodigoConsultora VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @StrCampaniaID CHAR(6) = CONVERT(CHAR(6), @CampaniaID)
	DECLARE @EstrategiaCodigo VARCHAR(100) = '030'
	DECLARE @OfertasPersonalizadas TABLE (
		Orden INT
		,CUV CHAR(6)
		,TipoPersonalizacion CHAR(3)
		,FlagRevista INT
		,AnioCampanaVenta INT
		)

	DECLARE @codConsultoraDefault VARCHAR(9) = ''

	SELECT @codConsultoraDefault = Codigo
	FROM TablaLogicaDatos WITH (NOLOCK)
	WHERE TablaLogicaDatosID = 10001

	INSERT INTO @OfertasPersonalizadas
	SELECT ISNULL(Orden, 0)
		,CUV
		,TipoPersonalizacion
		,FlagRevista
		,CONVERT(INT, AnioCampanaVenta)
	FROM ods.OfertasPersonalizadas WITH (NOLOCK)
	WHERE CodConsultora = @CodigoConsultora
		AND AnioCampanaVenta = @StrCampaniaID
		AND TipoPersonalizacion = 'SR'

	IF NOT EXISTS (
			SELECT 1
			FROM @OfertasPersonalizadas
			)
	BEGIN
		INSERT INTO @OfertasPersonalizadas
		SELECT ISNULL(Orden, 0)
			,CUV
			,TipoPersonalizacion
			,FlagRevista
			,CONVERT(INT, AnioCampanaVenta)
		FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
		WHERE op.CodConsultora = @codConsultoraDefault
			AND op.AnioCampanaVenta = @StrCampaniaID
			AND op.TipoPersonalizacion = 'SR'
	END

	INSERT INTO @OfertasPersonalizadas (
		Orden
		,CUV
		,TipoPersonalizacion
		,FlagRevista
		,AnioCampanaVenta
		)
	SELECT Orden
		,CUV
		,TipoPersonalizacion
		,FlagRevista
		,AnioCampanaVenta
	FROM dbo.ListarEstrategiasForzadas(@CampaniaID, @EstrategiaCodigo)

	SELECT e.EstrategiaID
		,e.CUV2
		,e.DescripcionCUV2
		,'' AS EtiquetaDescripcion
		,e.Precio
		,'' AS EtiquetaDescripcion2
		,e.Precio2
		,ISNULL(e.TextoLibre, '') AS TextoLibre
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
		,e.EsSubCampania
	FROM TipoEstrategia te WITH (NOLOCK)
	INNER JOIN dbo.Estrategia e WITH (NOLOCK) ON te.TipoEstrategiaId = e.TipoEstrategiaId
		AND te.Codigo = @EstrategiaCodigo
	INNER JOIN @OfertasPersonalizadas op ON e.CampaniaID = op.AnioCampanaVenta
		AND e.CUV2 = op.CUV
	INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON e.CampaniaID = pc.AnoCampania
		AND e.CUV2 = pc.CUV
	--INNER JOIN dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
	LEFT JOIN dbo.Marca M WITH (NOLOCK) ON pc.MarcaId = m.MarcaId
	WHERE e.Activo = 1
	ORDER BY op.Orden ASC
		,EstrategiaID ASC

	SET NOCOUNT OFF
END
GO

USE BelcorpSalvador
GO

/****** Object:  StoredProcedure [dbo].[ListarEstrategiasShowRoom]    Script Date: 20/11/2018 15:35:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[ListarEstrategiasShowRoom] @CampaniaID INT
	,@CodigoConsultora VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @StrCampaniaID CHAR(6) = CONVERT(CHAR(6), @CampaniaID)
	DECLARE @EstrategiaCodigo VARCHAR(100) = '030'
	DECLARE @OfertasPersonalizadas TABLE (
		Orden INT
		,CUV CHAR(6)
		,TipoPersonalizacion CHAR(3)
		,FlagRevista INT
		,AnioCampanaVenta INT
		)

	DECLARE @codConsultoraDefault VARCHAR(9) = ''

	SELECT @codConsultoraDefault = Codigo
	FROM TablaLogicaDatos WITH (NOLOCK)
	WHERE TablaLogicaDatosID = 10001

	INSERT INTO @OfertasPersonalizadas
	SELECT ISNULL(Orden, 0)
		,CUV
		,TipoPersonalizacion
		,FlagRevista
		,CONVERT(INT, AnioCampanaVenta)
	FROM ods.OfertasPersonalizadas WITH (NOLOCK)
	WHERE CodConsultora = @CodigoConsultora
		AND AnioCampanaVenta = @StrCampaniaID
		AND TipoPersonalizacion = 'SR'

	IF NOT EXISTS (
			SELECT 1
			FROM @OfertasPersonalizadas
			)
	BEGIN
		INSERT INTO @OfertasPersonalizadas
		SELECT ISNULL(Orden, 0)
			,CUV
			,TipoPersonalizacion
			,FlagRevista
			,CONVERT(INT, AnioCampanaVenta)
		FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
		WHERE op.CodConsultora = @codConsultoraDefault
			AND op.AnioCampanaVenta = @StrCampaniaID
			AND op.TipoPersonalizacion = 'SR'
	END

	INSERT INTO @OfertasPersonalizadas (
		Orden
		,CUV
		,TipoPersonalizacion
		,FlagRevista
		,AnioCampanaVenta
		)
	SELECT Orden
		,CUV
		,TipoPersonalizacion
		,FlagRevista
		,AnioCampanaVenta
	FROM dbo.ListarEstrategiasForzadas(@CampaniaID, @EstrategiaCodigo)

	SELECT e.EstrategiaID
		,e.CUV2
		,e.DescripcionCUV2
		,'' AS EtiquetaDescripcion
		,e.Precio
		,'' AS EtiquetaDescripcion2
		,e.Precio2
		,ISNULL(e.TextoLibre, '') AS TextoLibre
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
		,e.EsSubCampania
	FROM TipoEstrategia te WITH (NOLOCK)
	INNER JOIN dbo.Estrategia e WITH (NOLOCK) ON te.TipoEstrategiaId = e.TipoEstrategiaId
		AND te.Codigo = @EstrategiaCodigo
	INNER JOIN @OfertasPersonalizadas op ON e.CampaniaID = op.AnioCampanaVenta
		AND e.CUV2 = op.CUV
	INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON e.CampaniaID = pc.AnoCampania
		AND e.CUV2 = pc.CUV
	--INNER JOIN dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
	LEFT JOIN dbo.Marca M WITH (NOLOCK) ON pc.MarcaId = m.MarcaId
	WHERE e.Activo = 1
	ORDER BY op.Orden ASC
		,EstrategiaID ASC

	SET NOCOUNT OFF
END
GO

USE BelcorpPuertoRico
GO

/****** Object:  StoredProcedure [dbo].[ListarEstrategiasShowRoom]    Script Date: 20/11/2018 15:35:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[ListarEstrategiasShowRoom] @CampaniaID INT
	,@CodigoConsultora VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @StrCampaniaID CHAR(6) = CONVERT(CHAR(6), @CampaniaID)
	DECLARE @EstrategiaCodigo VARCHAR(100) = '030'
	DECLARE @OfertasPersonalizadas TABLE (
		Orden INT
		,CUV CHAR(6)
		,TipoPersonalizacion CHAR(3)
		,FlagRevista INT
		,AnioCampanaVenta INT
		)

	DECLARE @codConsultoraDefault VARCHAR(9) = ''

	SELECT @codConsultoraDefault = Codigo
	FROM TablaLogicaDatos WITH (NOLOCK)
	WHERE TablaLogicaDatosID = 10001

	INSERT INTO @OfertasPersonalizadas
	SELECT ISNULL(Orden, 0)
		,CUV
		,TipoPersonalizacion
		,FlagRevista
		,CONVERT(INT, AnioCampanaVenta)
	FROM ods.OfertasPersonalizadas WITH (NOLOCK)
	WHERE CodConsultora = @CodigoConsultora
		AND AnioCampanaVenta = @StrCampaniaID
		AND TipoPersonalizacion = 'SR'

	IF NOT EXISTS (
			SELECT 1
			FROM @OfertasPersonalizadas
			)
	BEGIN
		INSERT INTO @OfertasPersonalizadas
		SELECT ISNULL(Orden, 0)
			,CUV
			,TipoPersonalizacion
			,FlagRevista
			,CONVERT(INT, AnioCampanaVenta)
		FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
		WHERE op.CodConsultora = @codConsultoraDefault
			AND op.AnioCampanaVenta = @StrCampaniaID
			AND op.TipoPersonalizacion = 'SR'
	END

	INSERT INTO @OfertasPersonalizadas (
		Orden
		,CUV
		,TipoPersonalizacion
		,FlagRevista
		,AnioCampanaVenta
		)
	SELECT Orden
		,CUV
		,TipoPersonalizacion
		,FlagRevista
		,AnioCampanaVenta
	FROM dbo.ListarEstrategiasForzadas(@CampaniaID, @EstrategiaCodigo)

	SELECT e.EstrategiaID
		,e.CUV2
		,e.DescripcionCUV2
		,'' AS EtiquetaDescripcion
		,e.Precio
		,'' AS EtiquetaDescripcion2
		,e.Precio2
		,ISNULL(e.TextoLibre, '') AS TextoLibre
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
		,e.EsSubCampania
	FROM TipoEstrategia te WITH (NOLOCK)
	INNER JOIN dbo.Estrategia e WITH (NOLOCK) ON te.TipoEstrategiaId = e.TipoEstrategiaId
		AND te.Codigo = @EstrategiaCodigo
	INNER JOIN @OfertasPersonalizadas op ON e.CampaniaID = op.AnioCampanaVenta
		AND e.CUV2 = op.CUV
	INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON e.CampaniaID = pc.AnoCampania
		AND e.CUV2 = pc.CUV
	--INNER JOIN dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
	LEFT JOIN dbo.Marca M WITH (NOLOCK) ON pc.MarcaId = m.MarcaId
	WHERE e.Activo = 1
	ORDER BY op.Orden ASC
		,EstrategiaID ASC

	SET NOCOUNT OFF
END
GO

USE BelcorpPanama
GO

/****** Object:  StoredProcedure [dbo].[ListarEstrategiasShowRoom]    Script Date: 20/11/2018 15:35:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[ListarEstrategiasShowRoom] @CampaniaID INT
	,@CodigoConsultora VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @StrCampaniaID CHAR(6) = CONVERT(CHAR(6), @CampaniaID)
	DECLARE @EstrategiaCodigo VARCHAR(100) = '030'
	DECLARE @OfertasPersonalizadas TABLE (
		Orden INT
		,CUV CHAR(6)
		,TipoPersonalizacion CHAR(3)
		,FlagRevista INT
		,AnioCampanaVenta INT
		)

	DECLARE @codConsultoraDefault VARCHAR(9) = ''

	SELECT @codConsultoraDefault = Codigo
	FROM TablaLogicaDatos WITH (NOLOCK)
	WHERE TablaLogicaDatosID = 10001

	INSERT INTO @OfertasPersonalizadas
	SELECT ISNULL(Orden, 0)
		,CUV
		,TipoPersonalizacion
		,FlagRevista
		,CONVERT(INT, AnioCampanaVenta)
	FROM ods.OfertasPersonalizadas WITH (NOLOCK)
	WHERE CodConsultora = @CodigoConsultora
		AND AnioCampanaVenta = @StrCampaniaID
		AND TipoPersonalizacion = 'SR'

	IF NOT EXISTS (
			SELECT 1
			FROM @OfertasPersonalizadas
			)
	BEGIN
		INSERT INTO @OfertasPersonalizadas
		SELECT ISNULL(Orden, 0)
			,CUV
			,TipoPersonalizacion
			,FlagRevista
			,CONVERT(INT, AnioCampanaVenta)
		FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
		WHERE op.CodConsultora = @codConsultoraDefault
			AND op.AnioCampanaVenta = @StrCampaniaID
			AND op.TipoPersonalizacion = 'SR'
	END

	INSERT INTO @OfertasPersonalizadas (
		Orden
		,CUV
		,TipoPersonalizacion
		,FlagRevista
		,AnioCampanaVenta
		)
	SELECT Orden
		,CUV
		,TipoPersonalizacion
		,FlagRevista
		,AnioCampanaVenta
	FROM dbo.ListarEstrategiasForzadas(@CampaniaID, @EstrategiaCodigo)

	SELECT e.EstrategiaID
		,e.CUV2
		,e.DescripcionCUV2
		,'' AS EtiquetaDescripcion
		,e.Precio
		,'' AS EtiquetaDescripcion2
		,e.Precio2
		,ISNULL(e.TextoLibre, '') AS TextoLibre
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
		,e.EsSubCampania
	FROM TipoEstrategia te WITH (NOLOCK)
	INNER JOIN dbo.Estrategia e WITH (NOLOCK) ON te.TipoEstrategiaId = e.TipoEstrategiaId
		AND te.Codigo = @EstrategiaCodigo
	INNER JOIN @OfertasPersonalizadas op ON e.CampaniaID = op.AnioCampanaVenta
		AND e.CUV2 = op.CUV
	INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON e.CampaniaID = pc.AnoCampania
		AND e.CUV2 = pc.CUV
	--INNER JOIN dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
	LEFT JOIN dbo.Marca M WITH (NOLOCK) ON pc.MarcaId = m.MarcaId
	WHERE e.Activo = 1
	ORDER BY op.Orden ASC
		,EstrategiaID ASC

	SET NOCOUNT OFF
END
GO

USE BelcorpGuatemala
GO

/****** Object:  StoredProcedure [dbo].[ListarEstrategiasShowRoom]    Script Date: 20/11/2018 15:35:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[ListarEstrategiasShowRoom] @CampaniaID INT
	,@CodigoConsultora VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @StrCampaniaID CHAR(6) = CONVERT(CHAR(6), @CampaniaID)
	DECLARE @EstrategiaCodigo VARCHAR(100) = '030'
	DECLARE @OfertasPersonalizadas TABLE (
		Orden INT
		,CUV CHAR(6)
		,TipoPersonalizacion CHAR(3)
		,FlagRevista INT
		,AnioCampanaVenta INT
		)

	DECLARE @codConsultoraDefault VARCHAR(9) = ''

	SELECT @codConsultoraDefault = Codigo
	FROM TablaLogicaDatos WITH (NOLOCK)
	WHERE TablaLogicaDatosID = 10001

	INSERT INTO @OfertasPersonalizadas
	SELECT ISNULL(Orden, 0)
		,CUV
		,TipoPersonalizacion
		,FlagRevista
		,CONVERT(INT, AnioCampanaVenta)
	FROM ods.OfertasPersonalizadas WITH (NOLOCK)
	WHERE CodConsultora = @CodigoConsultora
		AND AnioCampanaVenta = @StrCampaniaID
		AND TipoPersonalizacion = 'SR'

	IF NOT EXISTS (
			SELECT 1
			FROM @OfertasPersonalizadas
			)
	BEGIN
		INSERT INTO @OfertasPersonalizadas
		SELECT ISNULL(Orden, 0)
			,CUV
			,TipoPersonalizacion
			,FlagRevista
			,CONVERT(INT, AnioCampanaVenta)
		FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
		WHERE op.CodConsultora = @codConsultoraDefault
			AND op.AnioCampanaVenta = @StrCampaniaID
			AND op.TipoPersonalizacion = 'SR'
	END

	INSERT INTO @OfertasPersonalizadas (
		Orden
		,CUV
		,TipoPersonalizacion
		,FlagRevista
		,AnioCampanaVenta
		)
	SELECT Orden
		,CUV
		,TipoPersonalizacion
		,FlagRevista
		,AnioCampanaVenta
	FROM dbo.ListarEstrategiasForzadas(@CampaniaID, @EstrategiaCodigo)

	SELECT e.EstrategiaID
		,e.CUV2
		,e.DescripcionCUV2
		,'' AS EtiquetaDescripcion
		,e.Precio
		,'' AS EtiquetaDescripcion2
		,e.Precio2
		,ISNULL(e.TextoLibre, '') AS TextoLibre
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
		,e.EsSubCampania
	FROM TipoEstrategia te WITH (NOLOCK)
	INNER JOIN dbo.Estrategia e WITH (NOLOCK) ON te.TipoEstrategiaId = e.TipoEstrategiaId
		AND te.Codigo = @EstrategiaCodigo
	INNER JOIN @OfertasPersonalizadas op ON e.CampaniaID = op.AnioCampanaVenta
		AND e.CUV2 = op.CUV
	INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON e.CampaniaID = pc.AnoCampania
		AND e.CUV2 = pc.CUV
	--INNER JOIN dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
	LEFT JOIN dbo.Marca M WITH (NOLOCK) ON pc.MarcaId = m.MarcaId
	WHERE e.Activo = 1
	ORDER BY op.Orden ASC
		,EstrategiaID ASC

	SET NOCOUNT OFF
END
GO

USE BelcorpEcuador
GO

/****** Object:  StoredProcedure [dbo].[ListarEstrategiasShowRoom]    Script Date: 20/11/2018 15:35:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[ListarEstrategiasShowRoom] @CampaniaID INT
	,@CodigoConsultora VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @StrCampaniaID CHAR(6) = CONVERT(CHAR(6), @CampaniaID)
	DECLARE @EstrategiaCodigo VARCHAR(100) = '030'
	DECLARE @OfertasPersonalizadas TABLE (
		Orden INT
		,CUV CHAR(6)
		,TipoPersonalizacion CHAR(3)
		,FlagRevista INT
		,AnioCampanaVenta INT
		)

	DECLARE @codConsultoraDefault VARCHAR(9) = ''

	SELECT @codConsultoraDefault = Codigo
	FROM TablaLogicaDatos WITH (NOLOCK)
	WHERE TablaLogicaDatosID = 10001

	INSERT INTO @OfertasPersonalizadas
	SELECT ISNULL(Orden, 0)
		,CUV
		,TipoPersonalizacion
		,FlagRevista
		,CONVERT(INT, AnioCampanaVenta)
	FROM ods.OfertasPersonalizadas WITH (NOLOCK)
	WHERE CodConsultora = @CodigoConsultora
		AND AnioCampanaVenta = @StrCampaniaID
		AND TipoPersonalizacion = 'SR'

	IF NOT EXISTS (
			SELECT 1
			FROM @OfertasPersonalizadas
			)
	BEGIN
		INSERT INTO @OfertasPersonalizadas
		SELECT ISNULL(Orden, 0)
			,CUV
			,TipoPersonalizacion
			,FlagRevista
			,CONVERT(INT, AnioCampanaVenta)
		FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
		WHERE op.CodConsultora = @codConsultoraDefault
			AND op.AnioCampanaVenta = @StrCampaniaID
			AND op.TipoPersonalizacion = 'SR'
	END

	INSERT INTO @OfertasPersonalizadas (
		Orden
		,CUV
		,TipoPersonalizacion
		,FlagRevista
		,AnioCampanaVenta
		)
	SELECT Orden
		,CUV
		,TipoPersonalizacion
		,FlagRevista
		,AnioCampanaVenta
	FROM dbo.ListarEstrategiasForzadas(@CampaniaID, @EstrategiaCodigo)

	SELECT e.EstrategiaID
		,e.CUV2
		,e.DescripcionCUV2
		,'' AS EtiquetaDescripcion
		,e.Precio
		,'' AS EtiquetaDescripcion2
		,e.Precio2
		,ISNULL(e.TextoLibre, '') AS TextoLibre
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
		,e.EsSubCampania
	FROM TipoEstrategia te WITH (NOLOCK)
	INNER JOIN dbo.Estrategia e WITH (NOLOCK) ON te.TipoEstrategiaId = e.TipoEstrategiaId
		AND te.Codigo = @EstrategiaCodigo
	INNER JOIN @OfertasPersonalizadas op ON e.CampaniaID = op.AnioCampanaVenta
		AND e.CUV2 = op.CUV
	INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON e.CampaniaID = pc.AnoCampania
		AND e.CUV2 = pc.CUV
	--INNER JOIN dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
	LEFT JOIN dbo.Marca M WITH (NOLOCK) ON pc.MarcaId = m.MarcaId
	WHERE e.Activo = 1
	ORDER BY op.Orden ASC
		,EstrategiaID ASC

	SET NOCOUNT OFF
END
GO

USE BelcorpDominicana
GO

/****** Object:  StoredProcedure [dbo].[ListarEstrategiasShowRoom]    Script Date: 20/11/2018 15:35:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[ListarEstrategiasShowRoom] @CampaniaID INT
	,@CodigoConsultora VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @StrCampaniaID CHAR(6) = CONVERT(CHAR(6), @CampaniaID)
	DECLARE @EstrategiaCodigo VARCHAR(100) = '030'
	DECLARE @OfertasPersonalizadas TABLE (
		Orden INT
		,CUV CHAR(6)
		,TipoPersonalizacion CHAR(3)
		,FlagRevista INT
		,AnioCampanaVenta INT
		)

	DECLARE @codConsultoraDefault VARCHAR(9) = ''

	SELECT @codConsultoraDefault = Codigo
	FROM TablaLogicaDatos WITH (NOLOCK)
	WHERE TablaLogicaDatosID = 10001

	INSERT INTO @OfertasPersonalizadas
	SELECT ISNULL(Orden, 0)
		,CUV
		,TipoPersonalizacion
		,FlagRevista
		,CONVERT(INT, AnioCampanaVenta)
	FROM ods.OfertasPersonalizadas WITH (NOLOCK)
	WHERE CodConsultora = @CodigoConsultora
		AND AnioCampanaVenta = @StrCampaniaID
		AND TipoPersonalizacion = 'SR'

	IF NOT EXISTS (
			SELECT 1
			FROM @OfertasPersonalizadas
			)
	BEGIN
		INSERT INTO @OfertasPersonalizadas
		SELECT ISNULL(Orden, 0)
			,CUV
			,TipoPersonalizacion
			,FlagRevista
			,CONVERT(INT, AnioCampanaVenta)
		FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
		WHERE op.CodConsultora = @codConsultoraDefault
			AND op.AnioCampanaVenta = @StrCampaniaID
			AND op.TipoPersonalizacion = 'SR'
	END

	INSERT INTO @OfertasPersonalizadas (
		Orden
		,CUV
		,TipoPersonalizacion
		,FlagRevista
		,AnioCampanaVenta
		)
	SELECT Orden
		,CUV
		,TipoPersonalizacion
		,FlagRevista
		,AnioCampanaVenta
	FROM dbo.ListarEstrategiasForzadas(@CampaniaID, @EstrategiaCodigo)

	SELECT e.EstrategiaID
		,e.CUV2
		,e.DescripcionCUV2
		,'' AS EtiquetaDescripcion
		,e.Precio
		,'' AS EtiquetaDescripcion2
		,e.Precio2
		,ISNULL(e.TextoLibre, '') AS TextoLibre
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
		,e.EsSubCampania
	FROM TipoEstrategia te WITH (NOLOCK)
	INNER JOIN dbo.Estrategia e WITH (NOLOCK) ON te.TipoEstrategiaId = e.TipoEstrategiaId
		AND te.Codigo = @EstrategiaCodigo
	INNER JOIN @OfertasPersonalizadas op ON e.CampaniaID = op.AnioCampanaVenta
		AND e.CUV2 = op.CUV
	INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON e.CampaniaID = pc.AnoCampania
		AND e.CUV2 = pc.CUV
	--INNER JOIN dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
	LEFT JOIN dbo.Marca M WITH (NOLOCK) ON pc.MarcaId = m.MarcaId
	WHERE e.Activo = 1
	ORDER BY op.Orden ASC
		,EstrategiaID ASC

	SET NOCOUNT OFF
END
GO

USE BelcorpCostaRica
GO

/****** Object:  StoredProcedure [dbo].[ListarEstrategiasShowRoom]    Script Date: 20/11/2018 15:35:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[ListarEstrategiasShowRoom] @CampaniaID INT
	,@CodigoConsultora VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @StrCampaniaID CHAR(6) = CONVERT(CHAR(6), @CampaniaID)
	DECLARE @EstrategiaCodigo VARCHAR(100) = '030'
	DECLARE @OfertasPersonalizadas TABLE (
		Orden INT
		,CUV CHAR(6)
		,TipoPersonalizacion CHAR(3)
		,FlagRevista INT
		,AnioCampanaVenta INT
		)

	DECLARE @codConsultoraDefault VARCHAR(9) = ''

	SELECT @codConsultoraDefault = Codigo
	FROM TablaLogicaDatos WITH (NOLOCK)
	WHERE TablaLogicaDatosID = 10001

	INSERT INTO @OfertasPersonalizadas
	SELECT ISNULL(Orden, 0)
		,CUV
		,TipoPersonalizacion
		,FlagRevista
		,CONVERT(INT, AnioCampanaVenta)
	FROM ods.OfertasPersonalizadas WITH (NOLOCK)
	WHERE CodConsultora = @CodigoConsultora
		AND AnioCampanaVenta = @StrCampaniaID
		AND TipoPersonalizacion = 'SR'

	IF NOT EXISTS (
			SELECT 1
			FROM @OfertasPersonalizadas
			)
	BEGIN
		INSERT INTO @OfertasPersonalizadas
		SELECT ISNULL(Orden, 0)
			,CUV
			,TipoPersonalizacion
			,FlagRevista
			,CONVERT(INT, AnioCampanaVenta)
		FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
		WHERE op.CodConsultora = @codConsultoraDefault
			AND op.AnioCampanaVenta = @StrCampaniaID
			AND op.TipoPersonalizacion = 'SR'
	END

	INSERT INTO @OfertasPersonalizadas (
		Orden
		,CUV
		,TipoPersonalizacion
		,FlagRevista
		,AnioCampanaVenta
		)
	SELECT Orden
		,CUV
		,TipoPersonalizacion
		,FlagRevista
		,AnioCampanaVenta
	FROM dbo.ListarEstrategiasForzadas(@CampaniaID, @EstrategiaCodigo)

	SELECT e.EstrategiaID
		,e.CUV2
		,e.DescripcionCUV2
		,'' AS EtiquetaDescripcion
		,e.Precio
		,'' AS EtiquetaDescripcion2
		,e.Precio2
		,ISNULL(e.TextoLibre, '') AS TextoLibre
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
		,e.EsSubCampania
	FROM TipoEstrategia te WITH (NOLOCK)
	INNER JOIN dbo.Estrategia e WITH (NOLOCK) ON te.TipoEstrategiaId = e.TipoEstrategiaId
		AND te.Codigo = @EstrategiaCodigo
	INNER JOIN @OfertasPersonalizadas op ON e.CampaniaID = op.AnioCampanaVenta
		AND e.CUV2 = op.CUV
	INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON e.CampaniaID = pc.AnoCampania
		AND e.CUV2 = pc.CUV
	--INNER JOIN dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
	LEFT JOIN dbo.Marca M WITH (NOLOCK) ON pc.MarcaId = m.MarcaId
	WHERE e.Activo = 1
	ORDER BY op.Orden ASC
		,EstrategiaID ASC

	SET NOCOUNT OFF
END
GO

USE BelcorpChile
GO

/****** Object:  StoredProcedure [dbo].[ListarEstrategiasShowRoom]    Script Date: 20/11/2018 15:35:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[ListarEstrategiasShowRoom] @CampaniaID INT
	,@CodigoConsultora VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @StrCampaniaID CHAR(6) = CONVERT(CHAR(6), @CampaniaID)
	DECLARE @EstrategiaCodigo VARCHAR(100) = '030'
	DECLARE @OfertasPersonalizadas TABLE (
		Orden INT
		,CUV CHAR(6)
		,TipoPersonalizacion CHAR(3)
		,FlagRevista INT
		,AnioCampanaVenta INT
		)

	DECLARE @codConsultoraDefault VARCHAR(9) = ''

	SELECT @codConsultoraDefault = Codigo
	FROM TablaLogicaDatos WITH (NOLOCK)
	WHERE TablaLogicaDatosID = 10001

	INSERT INTO @OfertasPersonalizadas
	SELECT ISNULL(Orden, 0)
		,CUV
		,TipoPersonalizacion
		,FlagRevista
		,CONVERT(INT, AnioCampanaVenta)
	FROM ods.OfertasPersonalizadas WITH (NOLOCK)
	WHERE CodConsultora = @CodigoConsultora
		AND AnioCampanaVenta = @StrCampaniaID
		AND TipoPersonalizacion = 'SR'

	IF NOT EXISTS (
			SELECT 1
			FROM @OfertasPersonalizadas
			)
	BEGIN
		INSERT INTO @OfertasPersonalizadas
		SELECT ISNULL(Orden, 0)
			,CUV
			,TipoPersonalizacion
			,FlagRevista
			,CONVERT(INT, AnioCampanaVenta)
		FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
		WHERE op.CodConsultora = @codConsultoraDefault
			AND op.AnioCampanaVenta = @StrCampaniaID
			AND op.TipoPersonalizacion = 'SR'
	END

	INSERT INTO @OfertasPersonalizadas (
		Orden
		,CUV
		,TipoPersonalizacion
		,FlagRevista
		,AnioCampanaVenta
		)
	SELECT Orden
		,CUV
		,TipoPersonalizacion
		,FlagRevista
		,AnioCampanaVenta
	FROM dbo.ListarEstrategiasForzadas(@CampaniaID, @EstrategiaCodigo)

	SELECT e.EstrategiaID
		,e.CUV2
		,e.DescripcionCUV2
		,'' AS EtiquetaDescripcion
		,e.Precio
		,'' AS EtiquetaDescripcion2
		,e.Precio2
		,ISNULL(e.TextoLibre, '') AS TextoLibre
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
		,e.EsSubCampania
	FROM TipoEstrategia te WITH (NOLOCK)
	INNER JOIN dbo.Estrategia e WITH (NOLOCK) ON te.TipoEstrategiaId = e.TipoEstrategiaId
		AND te.Codigo = @EstrategiaCodigo
	INNER JOIN @OfertasPersonalizadas op ON e.CampaniaID = op.AnioCampanaVenta
		AND e.CUV2 = op.CUV
	INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON e.CampaniaID = pc.AnoCampania
		AND e.CUV2 = pc.CUV
	--INNER JOIN dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
	LEFT JOIN dbo.Marca M WITH (NOLOCK) ON pc.MarcaId = m.MarcaId
	WHERE e.Activo = 1
	ORDER BY op.Orden ASC
		,EstrategiaID ASC

	SET NOCOUNT OFF
END
GO

USE BelcorpBolivia
GO

/****** Object:  StoredProcedure [dbo].[ListarEstrategiasShowRoom]    Script Date: 20/11/2018 15:35:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[ListarEstrategiasShowRoom] @CampaniaID INT
	,@CodigoConsultora VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @StrCampaniaID CHAR(6) = CONVERT(CHAR(6), @CampaniaID)
	DECLARE @EstrategiaCodigo VARCHAR(100) = '030'
	DECLARE @OfertasPersonalizadas TABLE (
		Orden INT
		,CUV CHAR(6)
		,TipoPersonalizacion CHAR(3)
		,FlagRevista INT
		,AnioCampanaVenta INT
		)

	DECLARE @codConsultoraDefault VARCHAR(9) = ''

	SELECT @codConsultoraDefault = Codigo
	FROM TablaLogicaDatos WITH (NOLOCK)
	WHERE TablaLogicaDatosID = 10001

	INSERT INTO @OfertasPersonalizadas
	SELECT ISNULL(Orden, 0)
		,CUV
		,TipoPersonalizacion
		,FlagRevista
		,CONVERT(INT, AnioCampanaVenta)
	FROM ods.OfertasPersonalizadas WITH (NOLOCK)
	WHERE CodConsultora = @CodigoConsultora
		AND AnioCampanaVenta = @StrCampaniaID
		AND TipoPersonalizacion = 'SR'

	IF NOT EXISTS (
			SELECT 1
			FROM @OfertasPersonalizadas
			)
	BEGIN
		INSERT INTO @OfertasPersonalizadas
		SELECT ISNULL(Orden, 0)
			,CUV
			,TipoPersonalizacion
			,FlagRevista
			,CONVERT(INT, AnioCampanaVenta)
		FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
		WHERE op.CodConsultora = @codConsultoraDefault
			AND op.AnioCampanaVenta = @StrCampaniaID
			AND op.TipoPersonalizacion = 'SR'
	END

	INSERT INTO @OfertasPersonalizadas (
		Orden
		,CUV
		,TipoPersonalizacion
		,FlagRevista
		,AnioCampanaVenta
		)
	SELECT Orden
		,CUV
		,TipoPersonalizacion
		,FlagRevista
		,AnioCampanaVenta
	FROM dbo.ListarEstrategiasForzadas(@CampaniaID, @EstrategiaCodigo)

	SELECT e.EstrategiaID
		,e.CUV2
		,e.DescripcionCUV2
		,'' AS EtiquetaDescripcion
		,e.Precio
		,'' AS EtiquetaDescripcion2
		,e.Precio2
		,ISNULL(e.TextoLibre, '') AS TextoLibre
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
		,e.EsSubCampania
	FROM TipoEstrategia te WITH (NOLOCK)
	INNER JOIN dbo.Estrategia e WITH (NOLOCK) ON te.TipoEstrategiaId = e.TipoEstrategiaId
		AND te.Codigo = @EstrategiaCodigo
	INNER JOIN @OfertasPersonalizadas op ON e.CampaniaID = op.AnioCampanaVenta
		AND e.CUV2 = op.CUV
	INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON e.CampaniaID = pc.AnoCampania
		AND e.CUV2 = pc.CUV
	--INNER JOIN dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
	LEFT JOIN dbo.Marca M WITH (NOLOCK) ON pc.MarcaId = m.MarcaId
	WHERE e.Activo = 1
	ORDER BY op.Orden ASC
		,EstrategiaID ASC

	SET NOCOUNT OFF
END
GO
