USE BelcorpPeru
GO

GO
/****** Object:  StoredProcedure [dbo].[ListarEstrategiasOPT]    Script Date: 20/11/2018 15:11:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Exec ListarEstrategiasOPT  201806, '000685941'
ALTER PROCEDURE [dbo].[ListarEstrategiasOPT]
(
	@CampaniaID int,
	@CodigoConsultora varchar(30)
)
AS
BEGIN
  SET NOCOUNT ON
	DECLARE @StrCampaniaID char(6) = CONVERT(char(6), @CampaniaID)
	DECLARE @EstrategiaCodigo varchar(100) = '001'
	DECLARE @OfertasPersonalizadas TABLE (
	  Orden int,
	  CUV char(6),
	  TipoPersonalizacion char(3),
	  FlagRevista int,
	  AnioCampanaVenta int
	)
	
	DECLARE @codConsultoraDefault VARCHAR(9) = ''
	SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001

	INSERT INTO @OfertasPersonalizadas
	SELECT
		ISNULL(Orden, 0),
		CUV,
		TipoPersonalizacion,
		FlagRevista,
		CONVERT(int, AnioCampanaVenta)
	FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
	WHERE op.CodConsultora = @CodigoConsultora
		AND op.AnioCampanaVenta = @StrCampaniaID
		AND op.TipoPersonalizacion = 'OPT'
	IF NOT EXISTS (SELECT   CUV  FROM @OfertasPersonalizadas)
	BEGIN
		INSERT INTO @OfertasPersonalizadas
		SELECT
			ISNULL(Orden, 0),
			CUV,
			TipoPersonalizacion,
			FlagRevista,
			CONVERT(int, AnioCampanaVenta)
		FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
		WHERE op.CodConsultora = @codConsultoraDefault
			AND op.AnioCampanaVenta = @StrCampaniaID
			AND op.TipoPersonalizacion = 'OPT'
	END
	INSERT INTO @OfertasPersonalizadas(Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta)
	SELECT Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta
	FROM dbo.ListarEstrategiasForzadas(@CampaniaID, @EstrategiaCodigo)

	  SELECT
		E.EstrategiaID,
		E.CUV2,
		E.DescripcionCUV2,
		 dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
		E.Precio,
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID2) EtiquetaDescripcion2,
		E.Precio2,
		ISNULL(E.TextoLibre, '') AS TextoLibre,
		E.FlagEstrella,
		E.ColorFondo,
		E.TipoEstrategiaID,
		E.ImagenURL AS FotoProducto01,
		E.ImagenURL,
		E.LimiteVenta,
		PC.MarcaID,
		TE.Orden AS Orden1,
		op.Orden Orden2,
		PC.IndicadorMontoMinimo,
		0 AS FlagNueva,
		'' AS TipoTallaColor,
		 3 AS TipoEstrategiaImagenMostrar,
		PC.CodigoProducto,
		E.EtiquetaID,
		E.EtiquetaID2,
		E.CodigoEstrategia,
		E.TieneVariedad,
		TE.CODIGO,
		TE.DescripcionEstrategia,
		 ISNULL(TE.FlagMostrarImg,0) AS FlagMostrarImg,
		M.Descripcion AS DescripcionMarca,
		'NO DISPONIBLE' AS DescripcionCategoria,
		E.PrecioPublico,
		E.Ganancia 
	FROM dbo.Estrategia E WITH (NOLOCK)
		INNER JOIN @OfertasPersonalizadas op
			ON E.CampaniaID = op.AnioCampanaVenta
			AND E.CUV2 = op.CUV
		INNER JOIN ods.ProductoComercial PC WITH (NOLOCK)
			ON PC.CUV = E.CUV2
			AND PC.AnoCampania = E.CampaniaID
		INNER JOIN dbo.TipoEstrategia TE WITH (NOLOCK)
			ON E.TipoEstrategiaID = TE.TipoEstrategiaID
			AND TE.Codigo = @EstrategiaCodigo
		LEFT JOIN dbo.Marca M WITH (NOLOCK)
			ON M.MarcaId = PC.MarcaId
	WHERE E.Activo = 1
		AND TE.FlagActivo = 1
		AND TE.flagRecoPerfil = 1
	ORDER BY op.Orden ASC, EstrategiaID ASC
SET NOCOUNT OFF
END
GO

USE BelcorpMexico
GO

GO
/****** Object:  StoredProcedure [dbo].[ListarEstrategiasOPT]    Script Date: 20/11/2018 15:11:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Exec ListarEstrategiasOPT  201806, '000685941'
ALTER PROCEDURE [dbo].[ListarEstrategiasOPT]
(
	@CampaniaID int,
	@CodigoConsultora varchar(30)
)
AS
BEGIN
  SET NOCOUNT ON
	DECLARE @StrCampaniaID char(6) = CONVERT(char(6), @CampaniaID)
	DECLARE @EstrategiaCodigo varchar(100) = '001'
	DECLARE @OfertasPersonalizadas TABLE (
	  Orden int,
	  CUV char(6),
	  TipoPersonalizacion char(3),
	  FlagRevista int,
	  AnioCampanaVenta int
	)
	
	DECLARE @codConsultoraDefault VARCHAR(9) = ''
	SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001

	INSERT INTO @OfertasPersonalizadas
	SELECT
		ISNULL(Orden, 0),
		CUV,
		TipoPersonalizacion,
		FlagRevista,
		CONVERT(int, AnioCampanaVenta)
	FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
	WHERE op.CodConsultora = @CodigoConsultora
		AND op.AnioCampanaVenta = @StrCampaniaID
		AND op.TipoPersonalizacion = 'OPT'
	IF NOT EXISTS (SELECT   CUV  FROM @OfertasPersonalizadas)
	BEGIN
		INSERT INTO @OfertasPersonalizadas
		SELECT
			ISNULL(Orden, 0),
			CUV,
			TipoPersonalizacion,
			FlagRevista,
			CONVERT(int, AnioCampanaVenta)
		FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
		WHERE op.CodConsultora = @codConsultoraDefault
			AND op.AnioCampanaVenta = @StrCampaniaID
			AND op.TipoPersonalizacion = 'OPT'
	END
	INSERT INTO @OfertasPersonalizadas(Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta)
	SELECT Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta
	FROM dbo.ListarEstrategiasForzadas(@CampaniaID, @EstrategiaCodigo)

	  SELECT
		E.EstrategiaID,
		E.CUV2,
		E.DescripcionCUV2,
		 dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
		E.Precio,
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID2) EtiquetaDescripcion2,
		E.Precio2,
		ISNULL(E.TextoLibre, '') AS TextoLibre,
		E.FlagEstrella,
		E.ColorFondo,
		E.TipoEstrategiaID,
		E.ImagenURL AS FotoProducto01,
		E.ImagenURL,
		E.LimiteVenta,
		PC.MarcaID,
		TE.Orden AS Orden1,
		op.Orden Orden2,
		PC.IndicadorMontoMinimo,
		0 AS FlagNueva,
		'' AS TipoTallaColor,
		 3 AS TipoEstrategiaImagenMostrar,
		PC.CodigoProducto,
		E.EtiquetaID,
		E.EtiquetaID2,
		E.CodigoEstrategia,
		E.TieneVariedad,
		TE.CODIGO,
		TE.DescripcionEstrategia,
		 ISNULL(TE.FlagMostrarImg,0) AS FlagMostrarImg,
		M.Descripcion AS DescripcionMarca,
		'NO DISPONIBLE' AS DescripcionCategoria,
		E.PrecioPublico,
		E.Ganancia 
	FROM dbo.Estrategia E WITH (NOLOCK)
		INNER JOIN @OfertasPersonalizadas op
			ON E.CampaniaID = op.AnioCampanaVenta
			AND E.CUV2 = op.CUV
		INNER JOIN ods.ProductoComercial PC WITH (NOLOCK)
			ON PC.CUV = E.CUV2
			AND PC.AnoCampania = E.CampaniaID
		INNER JOIN dbo.TipoEstrategia TE WITH (NOLOCK)
			ON E.TipoEstrategiaID = TE.TipoEstrategiaID
			AND TE.Codigo = @EstrategiaCodigo
		LEFT JOIN dbo.Marca M WITH (NOLOCK)
			ON M.MarcaId = PC.MarcaId
	WHERE E.Activo = 1
		AND TE.FlagActivo = 1
		AND TE.flagRecoPerfil = 1
	ORDER BY op.Orden ASC, EstrategiaID ASC
SET NOCOUNT OFF
END
GO

USE BelcorpColombia
GO

GO
/****** Object:  StoredProcedure [dbo].[ListarEstrategiasOPT]    Script Date: 20/11/2018 15:11:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Exec ListarEstrategiasOPT  201806, '000685941'
ALTER PROCEDURE [dbo].[ListarEstrategiasOPT]
(
	@CampaniaID int,
	@CodigoConsultora varchar(30)
)
AS
BEGIN
  SET NOCOUNT ON
	DECLARE @StrCampaniaID char(6) = CONVERT(char(6), @CampaniaID)
	DECLARE @EstrategiaCodigo varchar(100) = '001'
	DECLARE @OfertasPersonalizadas TABLE (
	  Orden int,
	  CUV char(6),
	  TipoPersonalizacion char(3),
	  FlagRevista int,
	  AnioCampanaVenta int
	)
	
	DECLARE @codConsultoraDefault VARCHAR(9) = ''
	SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001

	INSERT INTO @OfertasPersonalizadas
	SELECT
		ISNULL(Orden, 0),
		CUV,
		TipoPersonalizacion,
		FlagRevista,
		CONVERT(int, AnioCampanaVenta)
	FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
	WHERE op.CodConsultora = @CodigoConsultora
		AND op.AnioCampanaVenta = @StrCampaniaID
		AND op.TipoPersonalizacion = 'OPT'
	IF NOT EXISTS (SELECT   CUV  FROM @OfertasPersonalizadas)
	BEGIN
		INSERT INTO @OfertasPersonalizadas
		SELECT
			ISNULL(Orden, 0),
			CUV,
			TipoPersonalizacion,
			FlagRevista,
			CONVERT(int, AnioCampanaVenta)
		FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
		WHERE op.CodConsultora = @codConsultoraDefault
			AND op.AnioCampanaVenta = @StrCampaniaID
			AND op.TipoPersonalizacion = 'OPT'
	END
	INSERT INTO @OfertasPersonalizadas(Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta)
	SELECT Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta
	FROM dbo.ListarEstrategiasForzadas(@CampaniaID, @EstrategiaCodigo)

	  SELECT
		E.EstrategiaID,
		E.CUV2,
		E.DescripcionCUV2,
		 dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
		E.Precio,
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID2) EtiquetaDescripcion2,
		E.Precio2,
		ISNULL(E.TextoLibre, '') AS TextoLibre,
		E.FlagEstrella,
		E.ColorFondo,
		E.TipoEstrategiaID,
		E.ImagenURL AS FotoProducto01,
		E.ImagenURL,
		E.LimiteVenta,
		PC.MarcaID,
		TE.Orden AS Orden1,
		op.Orden Orden2,
		PC.IndicadorMontoMinimo,
		0 AS FlagNueva,
		'' AS TipoTallaColor,
		 3 AS TipoEstrategiaImagenMostrar,
		PC.CodigoProducto,
		E.EtiquetaID,
		E.EtiquetaID2,
		E.CodigoEstrategia,
		E.TieneVariedad,
		TE.CODIGO,
		TE.DescripcionEstrategia,
		 ISNULL(TE.FlagMostrarImg,0) AS FlagMostrarImg,
		M.Descripcion AS DescripcionMarca,
		'NO DISPONIBLE' AS DescripcionCategoria,
		E.PrecioPublico,
		E.Ganancia 
	FROM dbo.Estrategia E WITH (NOLOCK)
		INNER JOIN @OfertasPersonalizadas op
			ON E.CampaniaID = op.AnioCampanaVenta
			AND E.CUV2 = op.CUV
		INNER JOIN ods.ProductoComercial PC WITH (NOLOCK)
			ON PC.CUV = E.CUV2
			AND PC.AnoCampania = E.CampaniaID
		INNER JOIN dbo.TipoEstrategia TE WITH (NOLOCK)
			ON E.TipoEstrategiaID = TE.TipoEstrategiaID
			AND TE.Codigo = @EstrategiaCodigo
		LEFT JOIN dbo.Marca M WITH (NOLOCK)
			ON M.MarcaId = PC.MarcaId
	WHERE E.Activo = 1
		AND TE.FlagActivo = 1
		AND TE.flagRecoPerfil = 1
	ORDER BY op.Orden ASC, EstrategiaID ASC
SET NOCOUNT OFF
END
GO

USE BelcorpSalvador
GO

GO
/****** Object:  StoredProcedure [dbo].[ListarEstrategiasOPT]    Script Date: 20/11/2018 15:11:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Exec ListarEstrategiasOPT  201806, '000685941'
ALTER PROCEDURE [dbo].[ListarEstrategiasOPT]
(
	@CampaniaID int,
	@CodigoConsultora varchar(30)
)
AS
BEGIN
  SET NOCOUNT ON
	DECLARE @StrCampaniaID char(6) = CONVERT(char(6), @CampaniaID)
	DECLARE @EstrategiaCodigo varchar(100) = '001'
	DECLARE @OfertasPersonalizadas TABLE (
	  Orden int,
	  CUV char(6),
	  TipoPersonalizacion char(3),
	  FlagRevista int,
	  AnioCampanaVenta int
	)
	
	DECLARE @codConsultoraDefault VARCHAR(9) = ''
	SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001

	INSERT INTO @OfertasPersonalizadas
	SELECT
		ISNULL(Orden, 0),
		CUV,
		TipoPersonalizacion,
		FlagRevista,
		CONVERT(int, AnioCampanaVenta)
	FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
	WHERE op.CodConsultora = @CodigoConsultora
		AND op.AnioCampanaVenta = @StrCampaniaID
		AND op.TipoPersonalizacion = 'OPT'
	IF NOT EXISTS (SELECT   CUV  FROM @OfertasPersonalizadas)
	BEGIN
		INSERT INTO @OfertasPersonalizadas
		SELECT
			ISNULL(Orden, 0),
			CUV,
			TipoPersonalizacion,
			FlagRevista,
			CONVERT(int, AnioCampanaVenta)
		FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
		WHERE op.CodConsultora = @codConsultoraDefault
			AND op.AnioCampanaVenta = @StrCampaniaID
			AND op.TipoPersonalizacion = 'OPT'
	END
	INSERT INTO @OfertasPersonalizadas(Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta)
	SELECT Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta
	FROM dbo.ListarEstrategiasForzadas(@CampaniaID, @EstrategiaCodigo)

	  SELECT
		E.EstrategiaID,
		E.CUV2,
		E.DescripcionCUV2,
		 dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
		E.Precio,
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID2) EtiquetaDescripcion2,
		E.Precio2,
		ISNULL(E.TextoLibre, '') AS TextoLibre,
		E.FlagEstrella,
		E.ColorFondo,
		E.TipoEstrategiaID,
		E.ImagenURL AS FotoProducto01,
		E.ImagenURL,
		E.LimiteVenta,
		PC.MarcaID,
		TE.Orden AS Orden1,
		op.Orden Orden2,
		PC.IndicadorMontoMinimo,
		0 AS FlagNueva,
		'' AS TipoTallaColor,
		 3 AS TipoEstrategiaImagenMostrar,
		PC.CodigoProducto,
		E.EtiquetaID,
		E.EtiquetaID2,
		E.CodigoEstrategia,
		E.TieneVariedad,
		TE.CODIGO,
		TE.DescripcionEstrategia,
		 ISNULL(TE.FlagMostrarImg,0) AS FlagMostrarImg,
		M.Descripcion AS DescripcionMarca,
		'NO DISPONIBLE' AS DescripcionCategoria,
		E.PrecioPublico,
		E.Ganancia 
	FROM dbo.Estrategia E WITH (NOLOCK)
		INNER JOIN @OfertasPersonalizadas op
			ON E.CampaniaID = op.AnioCampanaVenta
			AND E.CUV2 = op.CUV
		INNER JOIN ods.ProductoComercial PC WITH (NOLOCK)
			ON PC.CUV = E.CUV2
			AND PC.AnoCampania = E.CampaniaID
		INNER JOIN dbo.TipoEstrategia TE WITH (NOLOCK)
			ON E.TipoEstrategiaID = TE.TipoEstrategiaID
			AND TE.Codigo = @EstrategiaCodigo
		LEFT JOIN dbo.Marca M WITH (NOLOCK)
			ON M.MarcaId = PC.MarcaId
	WHERE E.Activo = 1
		AND TE.FlagActivo = 1
		AND TE.flagRecoPerfil = 1
	ORDER BY op.Orden ASC, EstrategiaID ASC
SET NOCOUNT OFF
END
GO

USE BelcorpPuertoRico
GO

GO
/****** Object:  StoredProcedure [dbo].[ListarEstrategiasOPT]    Script Date: 20/11/2018 15:11:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Exec ListarEstrategiasOPT  201806, '000685941'
ALTER PROCEDURE [dbo].[ListarEstrategiasOPT]
(
	@CampaniaID int,
	@CodigoConsultora varchar(30)
)
AS
BEGIN
  SET NOCOUNT ON
	DECLARE @StrCampaniaID char(6) = CONVERT(char(6), @CampaniaID)
	DECLARE @EstrategiaCodigo varchar(100) = '001'
	DECLARE @OfertasPersonalizadas TABLE (
	  Orden int,
	  CUV char(6),
	  TipoPersonalizacion char(3),
	  FlagRevista int,
	  AnioCampanaVenta int
	)
	
	DECLARE @codConsultoraDefault VARCHAR(9) = ''
	SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001

	INSERT INTO @OfertasPersonalizadas
	SELECT
		ISNULL(Orden, 0),
		CUV,
		TipoPersonalizacion,
		FlagRevista,
		CONVERT(int, AnioCampanaVenta)
	FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
	WHERE op.CodConsultora = @CodigoConsultora
		AND op.AnioCampanaVenta = @StrCampaniaID
		AND op.TipoPersonalizacion = 'OPT'
	IF NOT EXISTS (SELECT   CUV  FROM @OfertasPersonalizadas)
	BEGIN
		INSERT INTO @OfertasPersonalizadas
		SELECT
			ISNULL(Orden, 0),
			CUV,
			TipoPersonalizacion,
			FlagRevista,
			CONVERT(int, AnioCampanaVenta)
		FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
		WHERE op.CodConsultora = @codConsultoraDefault
			AND op.AnioCampanaVenta = @StrCampaniaID
			AND op.TipoPersonalizacion = 'OPT'
	END
	INSERT INTO @OfertasPersonalizadas(Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta)
	SELECT Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta
	FROM dbo.ListarEstrategiasForzadas(@CampaniaID, @EstrategiaCodigo)

	  SELECT
		E.EstrategiaID,
		E.CUV2,
		E.DescripcionCUV2,
		 dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
		E.Precio,
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID2) EtiquetaDescripcion2,
		E.Precio2,
		ISNULL(E.TextoLibre, '') AS TextoLibre,
		E.FlagEstrella,
		E.ColorFondo,
		E.TipoEstrategiaID,
		E.ImagenURL AS FotoProducto01,
		E.ImagenURL,
		E.LimiteVenta,
		PC.MarcaID,
		TE.Orden AS Orden1,
		op.Orden Orden2,
		PC.IndicadorMontoMinimo,
		0 AS FlagNueva,
		'' AS TipoTallaColor,
		 3 AS TipoEstrategiaImagenMostrar,
		PC.CodigoProducto,
		E.EtiquetaID,
		E.EtiquetaID2,
		E.CodigoEstrategia,
		E.TieneVariedad,
		TE.CODIGO,
		TE.DescripcionEstrategia,
		 ISNULL(TE.FlagMostrarImg,0) AS FlagMostrarImg,
		M.Descripcion AS DescripcionMarca,
		'NO DISPONIBLE' AS DescripcionCategoria,
		E.PrecioPublico,
		E.Ganancia 
	FROM dbo.Estrategia E WITH (NOLOCK)
		INNER JOIN @OfertasPersonalizadas op
			ON E.CampaniaID = op.AnioCampanaVenta
			AND E.CUV2 = op.CUV
		INNER JOIN ods.ProductoComercial PC WITH (NOLOCK)
			ON PC.CUV = E.CUV2
			AND PC.AnoCampania = E.CampaniaID
		INNER JOIN dbo.TipoEstrategia TE WITH (NOLOCK)
			ON E.TipoEstrategiaID = TE.TipoEstrategiaID
			AND TE.Codigo = @EstrategiaCodigo
		LEFT JOIN dbo.Marca M WITH (NOLOCK)
			ON M.MarcaId = PC.MarcaId
	WHERE E.Activo = 1
		AND TE.FlagActivo = 1
		AND TE.flagRecoPerfil = 1
	ORDER BY op.Orden ASC, EstrategiaID ASC
SET NOCOUNT OFF
END
GO

USE BelcorpPanama
GO

GO
/****** Object:  StoredProcedure [dbo].[ListarEstrategiasOPT]    Script Date: 20/11/2018 15:11:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Exec ListarEstrategiasOPT  201806, '000685941'
ALTER PROCEDURE [dbo].[ListarEstrategiasOPT]
(
	@CampaniaID int,
	@CodigoConsultora varchar(30)
)
AS
BEGIN
  SET NOCOUNT ON
	DECLARE @StrCampaniaID char(6) = CONVERT(char(6), @CampaniaID)
	DECLARE @EstrategiaCodigo varchar(100) = '001'
	DECLARE @OfertasPersonalizadas TABLE (
	  Orden int,
	  CUV char(6),
	  TipoPersonalizacion char(3),
	  FlagRevista int,
	  AnioCampanaVenta int
	)
	
	DECLARE @codConsultoraDefault VARCHAR(9) = ''
	SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001

	INSERT INTO @OfertasPersonalizadas
	SELECT
		ISNULL(Orden, 0),
		CUV,
		TipoPersonalizacion,
		FlagRevista,
		CONVERT(int, AnioCampanaVenta)
	FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
	WHERE op.CodConsultora = @CodigoConsultora
		AND op.AnioCampanaVenta = @StrCampaniaID
		AND op.TipoPersonalizacion = 'OPT'
	IF NOT EXISTS (SELECT   CUV  FROM @OfertasPersonalizadas)
	BEGIN
		INSERT INTO @OfertasPersonalizadas
		SELECT
			ISNULL(Orden, 0),
			CUV,
			TipoPersonalizacion,
			FlagRevista,
			CONVERT(int, AnioCampanaVenta)
		FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
		WHERE op.CodConsultora = @codConsultoraDefault
			AND op.AnioCampanaVenta = @StrCampaniaID
			AND op.TipoPersonalizacion = 'OPT'
	END
	INSERT INTO @OfertasPersonalizadas(Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta)
	SELECT Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta
	FROM dbo.ListarEstrategiasForzadas(@CampaniaID, @EstrategiaCodigo)

	  SELECT
		E.EstrategiaID,
		E.CUV2,
		E.DescripcionCUV2,
		 dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
		E.Precio,
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID2) EtiquetaDescripcion2,
		E.Precio2,
		ISNULL(E.TextoLibre, '') AS TextoLibre,
		E.FlagEstrella,
		E.ColorFondo,
		E.TipoEstrategiaID,
		E.ImagenURL AS FotoProducto01,
		E.ImagenURL,
		E.LimiteVenta,
		PC.MarcaID,
		TE.Orden AS Orden1,
		op.Orden Orden2,
		PC.IndicadorMontoMinimo,
		0 AS FlagNueva,
		'' AS TipoTallaColor,
		 3 AS TipoEstrategiaImagenMostrar,
		PC.CodigoProducto,
		E.EtiquetaID,
		E.EtiquetaID2,
		E.CodigoEstrategia,
		E.TieneVariedad,
		TE.CODIGO,
		TE.DescripcionEstrategia,
		 ISNULL(TE.FlagMostrarImg,0) AS FlagMostrarImg,
		M.Descripcion AS DescripcionMarca,
		'NO DISPONIBLE' AS DescripcionCategoria,
		E.PrecioPublico,
		E.Ganancia 
	FROM dbo.Estrategia E WITH (NOLOCK)
		INNER JOIN @OfertasPersonalizadas op
			ON E.CampaniaID = op.AnioCampanaVenta
			AND E.CUV2 = op.CUV
		INNER JOIN ods.ProductoComercial PC WITH (NOLOCK)
			ON PC.CUV = E.CUV2
			AND PC.AnoCampania = E.CampaniaID
		INNER JOIN dbo.TipoEstrategia TE WITH (NOLOCK)
			ON E.TipoEstrategiaID = TE.TipoEstrategiaID
			AND TE.Codigo = @EstrategiaCodigo
		LEFT JOIN dbo.Marca M WITH (NOLOCK)
			ON M.MarcaId = PC.MarcaId
	WHERE E.Activo = 1
		AND TE.FlagActivo = 1
		AND TE.flagRecoPerfil = 1
	ORDER BY op.Orden ASC, EstrategiaID ASC
SET NOCOUNT OFF
END
GO

USE BelcorpGuatemala
GO

GO
/****** Object:  StoredProcedure [dbo].[ListarEstrategiasOPT]    Script Date: 20/11/2018 15:11:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Exec ListarEstrategiasOPT  201806, '000685941'
ALTER PROCEDURE [dbo].[ListarEstrategiasOPT]
(
	@CampaniaID int,
	@CodigoConsultora varchar(30)
)
AS
BEGIN
  SET NOCOUNT ON
	DECLARE @StrCampaniaID char(6) = CONVERT(char(6), @CampaniaID)
	DECLARE @EstrategiaCodigo varchar(100) = '001'
	DECLARE @OfertasPersonalizadas TABLE (
	  Orden int,
	  CUV char(6),
	  TipoPersonalizacion char(3),
	  FlagRevista int,
	  AnioCampanaVenta int
	)
	
	DECLARE @codConsultoraDefault VARCHAR(9) = ''
	SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001

	INSERT INTO @OfertasPersonalizadas
	SELECT
		ISNULL(Orden, 0),
		CUV,
		TipoPersonalizacion,
		FlagRevista,
		CONVERT(int, AnioCampanaVenta)
	FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
	WHERE op.CodConsultora = @CodigoConsultora
		AND op.AnioCampanaVenta = @StrCampaniaID
		AND op.TipoPersonalizacion = 'OPT'
	IF NOT EXISTS (SELECT   CUV  FROM @OfertasPersonalizadas)
	BEGIN
		INSERT INTO @OfertasPersonalizadas
		SELECT
			ISNULL(Orden, 0),
			CUV,
			TipoPersonalizacion,
			FlagRevista,
			CONVERT(int, AnioCampanaVenta)
		FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
		WHERE op.CodConsultora = @codConsultoraDefault
			AND op.AnioCampanaVenta = @StrCampaniaID
			AND op.TipoPersonalizacion = 'OPT'
	END
	INSERT INTO @OfertasPersonalizadas(Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta)
	SELECT Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta
	FROM dbo.ListarEstrategiasForzadas(@CampaniaID, @EstrategiaCodigo)

	  SELECT
		E.EstrategiaID,
		E.CUV2,
		E.DescripcionCUV2,
		 dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
		E.Precio,
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID2) EtiquetaDescripcion2,
		E.Precio2,
		ISNULL(E.TextoLibre, '') AS TextoLibre,
		E.FlagEstrella,
		E.ColorFondo,
		E.TipoEstrategiaID,
		E.ImagenURL AS FotoProducto01,
		E.ImagenURL,
		E.LimiteVenta,
		PC.MarcaID,
		TE.Orden AS Orden1,
		op.Orden Orden2,
		PC.IndicadorMontoMinimo,
		0 AS FlagNueva,
		'' AS TipoTallaColor,
		 3 AS TipoEstrategiaImagenMostrar,
		PC.CodigoProducto,
		E.EtiquetaID,
		E.EtiquetaID2,
		E.CodigoEstrategia,
		E.TieneVariedad,
		TE.CODIGO,
		TE.DescripcionEstrategia,
		 ISNULL(TE.FlagMostrarImg,0) AS FlagMostrarImg,
		M.Descripcion AS DescripcionMarca,
		'NO DISPONIBLE' AS DescripcionCategoria,
		E.PrecioPublico,
		E.Ganancia 
	FROM dbo.Estrategia E WITH (NOLOCK)
		INNER JOIN @OfertasPersonalizadas op
			ON E.CampaniaID = op.AnioCampanaVenta
			AND E.CUV2 = op.CUV
		INNER JOIN ods.ProductoComercial PC WITH (NOLOCK)
			ON PC.CUV = E.CUV2
			AND PC.AnoCampania = E.CampaniaID
		INNER JOIN dbo.TipoEstrategia TE WITH (NOLOCK)
			ON E.TipoEstrategiaID = TE.TipoEstrategiaID
			AND TE.Codigo = @EstrategiaCodigo
		LEFT JOIN dbo.Marca M WITH (NOLOCK)
			ON M.MarcaId = PC.MarcaId
	WHERE E.Activo = 1
		AND TE.FlagActivo = 1
		AND TE.flagRecoPerfil = 1
	ORDER BY op.Orden ASC, EstrategiaID ASC
SET NOCOUNT OFF
END
GO

USE BelcorpEcuador
GO

GO
/****** Object:  StoredProcedure [dbo].[ListarEstrategiasOPT]    Script Date: 20/11/2018 15:11:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Exec ListarEstrategiasOPT  201806, '000685941'
ALTER PROCEDURE [dbo].[ListarEstrategiasOPT]
(
	@CampaniaID int,
	@CodigoConsultora varchar(30)
)
AS
BEGIN
  SET NOCOUNT ON
	DECLARE @StrCampaniaID char(6) = CONVERT(char(6), @CampaniaID)
	DECLARE @EstrategiaCodigo varchar(100) = '001'
	DECLARE @OfertasPersonalizadas TABLE (
	  Orden int,
	  CUV char(6),
	  TipoPersonalizacion char(3),
	  FlagRevista int,
	  AnioCampanaVenta int
	)
	
	DECLARE @codConsultoraDefault VARCHAR(9) = ''
	SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001

	INSERT INTO @OfertasPersonalizadas
	SELECT
		ISNULL(Orden, 0),
		CUV,
		TipoPersonalizacion,
		FlagRevista,
		CONVERT(int, AnioCampanaVenta)
	FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
	WHERE op.CodConsultora = @CodigoConsultora
		AND op.AnioCampanaVenta = @StrCampaniaID
		AND op.TipoPersonalizacion = 'OPT'
	IF NOT EXISTS (SELECT   CUV  FROM @OfertasPersonalizadas)
	BEGIN
		INSERT INTO @OfertasPersonalizadas
		SELECT
			ISNULL(Orden, 0),
			CUV,
			TipoPersonalizacion,
			FlagRevista,
			CONVERT(int, AnioCampanaVenta)
		FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
		WHERE op.CodConsultora = @codConsultoraDefault
			AND op.AnioCampanaVenta = @StrCampaniaID
			AND op.TipoPersonalizacion = 'OPT'
	END
	INSERT INTO @OfertasPersonalizadas(Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta)
	SELECT Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta
	FROM dbo.ListarEstrategiasForzadas(@CampaniaID, @EstrategiaCodigo)

	  SELECT
		E.EstrategiaID,
		E.CUV2,
		E.DescripcionCUV2,
		 dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
		E.Precio,
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID2) EtiquetaDescripcion2,
		E.Precio2,
		ISNULL(E.TextoLibre, '') AS TextoLibre,
		E.FlagEstrella,
		E.ColorFondo,
		E.TipoEstrategiaID,
		E.ImagenURL AS FotoProducto01,
		E.ImagenURL,
		E.LimiteVenta,
		PC.MarcaID,
		TE.Orden AS Orden1,
		op.Orden Orden2,
		PC.IndicadorMontoMinimo,
		0 AS FlagNueva,
		'' AS TipoTallaColor,
		 3 AS TipoEstrategiaImagenMostrar,
		PC.CodigoProducto,
		E.EtiquetaID,
		E.EtiquetaID2,
		E.CodigoEstrategia,
		E.TieneVariedad,
		TE.CODIGO,
		TE.DescripcionEstrategia,
		 ISNULL(TE.FlagMostrarImg,0) AS FlagMostrarImg,
		M.Descripcion AS DescripcionMarca,
		'NO DISPONIBLE' AS DescripcionCategoria,
		E.PrecioPublico,
		E.Ganancia 
	FROM dbo.Estrategia E WITH (NOLOCK)
		INNER JOIN @OfertasPersonalizadas op
			ON E.CampaniaID = op.AnioCampanaVenta
			AND E.CUV2 = op.CUV
		INNER JOIN ods.ProductoComercial PC WITH (NOLOCK)
			ON PC.CUV = E.CUV2
			AND PC.AnoCampania = E.CampaniaID
		INNER JOIN dbo.TipoEstrategia TE WITH (NOLOCK)
			ON E.TipoEstrategiaID = TE.TipoEstrategiaID
			AND TE.Codigo = @EstrategiaCodigo
		LEFT JOIN dbo.Marca M WITH (NOLOCK)
			ON M.MarcaId = PC.MarcaId
	WHERE E.Activo = 1
		AND TE.FlagActivo = 1
		AND TE.flagRecoPerfil = 1
	ORDER BY op.Orden ASC, EstrategiaID ASC
SET NOCOUNT OFF
END
GO

USE BelcorpDominicana
GO

GO
/****** Object:  StoredProcedure [dbo].[ListarEstrategiasOPT]    Script Date: 20/11/2018 15:11:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Exec ListarEstrategiasOPT  201806, '000685941'
ALTER PROCEDURE [dbo].[ListarEstrategiasOPT]
(
	@CampaniaID int,
	@CodigoConsultora varchar(30)
)
AS
BEGIN
  SET NOCOUNT ON
	DECLARE @StrCampaniaID char(6) = CONVERT(char(6), @CampaniaID)
	DECLARE @EstrategiaCodigo varchar(100) = '001'
	DECLARE @OfertasPersonalizadas TABLE (
	  Orden int,
	  CUV char(6),
	  TipoPersonalizacion char(3),
	  FlagRevista int,
	  AnioCampanaVenta int
	)
	
	DECLARE @codConsultoraDefault VARCHAR(9) = ''
	SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001

	INSERT INTO @OfertasPersonalizadas
	SELECT
		ISNULL(Orden, 0),
		CUV,
		TipoPersonalizacion,
		FlagRevista,
		CONVERT(int, AnioCampanaVenta)
	FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
	WHERE op.CodConsultora = @CodigoConsultora
		AND op.AnioCampanaVenta = @StrCampaniaID
		AND op.TipoPersonalizacion = 'OPT'
	IF NOT EXISTS (SELECT   CUV  FROM @OfertasPersonalizadas)
	BEGIN
		INSERT INTO @OfertasPersonalizadas
		SELECT
			ISNULL(Orden, 0),
			CUV,
			TipoPersonalizacion,
			FlagRevista,
			CONVERT(int, AnioCampanaVenta)
		FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
		WHERE op.CodConsultora = @codConsultoraDefault
			AND op.AnioCampanaVenta = @StrCampaniaID
			AND op.TipoPersonalizacion = 'OPT'
	END
	INSERT INTO @OfertasPersonalizadas(Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta)
	SELECT Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta
	FROM dbo.ListarEstrategiasForzadas(@CampaniaID, @EstrategiaCodigo)

	  SELECT
		E.EstrategiaID,
		E.CUV2,
		E.DescripcionCUV2,
		 dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
		E.Precio,
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID2) EtiquetaDescripcion2,
		E.Precio2,
		ISNULL(E.TextoLibre, '') AS TextoLibre,
		E.FlagEstrella,
		E.ColorFondo,
		E.TipoEstrategiaID,
		E.ImagenURL AS FotoProducto01,
		E.ImagenURL,
		E.LimiteVenta,
		PC.MarcaID,
		TE.Orden AS Orden1,
		op.Orden Orden2,
		PC.IndicadorMontoMinimo,
		0 AS FlagNueva,
		'' AS TipoTallaColor,
		 3 AS TipoEstrategiaImagenMostrar,
		PC.CodigoProducto,
		E.EtiquetaID,
		E.EtiquetaID2,
		E.CodigoEstrategia,
		E.TieneVariedad,
		TE.CODIGO,
		TE.DescripcionEstrategia,
		 ISNULL(TE.FlagMostrarImg,0) AS FlagMostrarImg,
		M.Descripcion AS DescripcionMarca,
		'NO DISPONIBLE' AS DescripcionCategoria,
		E.PrecioPublico,
		E.Ganancia 
	FROM dbo.Estrategia E WITH (NOLOCK)
		INNER JOIN @OfertasPersonalizadas op
			ON E.CampaniaID = op.AnioCampanaVenta
			AND E.CUV2 = op.CUV
		INNER JOIN ods.ProductoComercial PC WITH (NOLOCK)
			ON PC.CUV = E.CUV2
			AND PC.AnoCampania = E.CampaniaID
		INNER JOIN dbo.TipoEstrategia TE WITH (NOLOCK)
			ON E.TipoEstrategiaID = TE.TipoEstrategiaID
			AND TE.Codigo = @EstrategiaCodigo
		LEFT JOIN dbo.Marca M WITH (NOLOCK)
			ON M.MarcaId = PC.MarcaId
	WHERE E.Activo = 1
		AND TE.FlagActivo = 1
		AND TE.flagRecoPerfil = 1
	ORDER BY op.Orden ASC, EstrategiaID ASC
SET NOCOUNT OFF
END
GO

USE BelcorpCostaRica
GO

GO
/****** Object:  StoredProcedure [dbo].[ListarEstrategiasOPT]    Script Date: 20/11/2018 15:11:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Exec ListarEstrategiasOPT  201806, '000685941'
ALTER PROCEDURE [dbo].[ListarEstrategiasOPT]
(
	@CampaniaID int,
	@CodigoConsultora varchar(30)
)
AS
BEGIN
  SET NOCOUNT ON
	DECLARE @StrCampaniaID char(6) = CONVERT(char(6), @CampaniaID)
	DECLARE @EstrategiaCodigo varchar(100) = '001'
	DECLARE @OfertasPersonalizadas TABLE (
	  Orden int,
	  CUV char(6),
	  TipoPersonalizacion char(3),
	  FlagRevista int,
	  AnioCampanaVenta int
	)
	
	DECLARE @codConsultoraDefault VARCHAR(9) = ''
	SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001

	INSERT INTO @OfertasPersonalizadas
	SELECT
		ISNULL(Orden, 0),
		CUV,
		TipoPersonalizacion,
		FlagRevista,
		CONVERT(int, AnioCampanaVenta)
	FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
	WHERE op.CodConsultora = @CodigoConsultora
		AND op.AnioCampanaVenta = @StrCampaniaID
		AND op.TipoPersonalizacion = 'OPT'
	IF NOT EXISTS (SELECT   CUV  FROM @OfertasPersonalizadas)
	BEGIN
		INSERT INTO @OfertasPersonalizadas
		SELECT
			ISNULL(Orden, 0),
			CUV,
			TipoPersonalizacion,
			FlagRevista,
			CONVERT(int, AnioCampanaVenta)
		FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
		WHERE op.CodConsultora = @codConsultoraDefault
			AND op.AnioCampanaVenta = @StrCampaniaID
			AND op.TipoPersonalizacion = 'OPT'
	END
	INSERT INTO @OfertasPersonalizadas(Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta)
	SELECT Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta
	FROM dbo.ListarEstrategiasForzadas(@CampaniaID, @EstrategiaCodigo)

	  SELECT
		E.EstrategiaID,
		E.CUV2,
		E.DescripcionCUV2,
		 dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
		E.Precio,
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID2) EtiquetaDescripcion2,
		E.Precio2,
		ISNULL(E.TextoLibre, '') AS TextoLibre,
		E.FlagEstrella,
		E.ColorFondo,
		E.TipoEstrategiaID,
		E.ImagenURL AS FotoProducto01,
		E.ImagenURL,
		E.LimiteVenta,
		PC.MarcaID,
		TE.Orden AS Orden1,
		op.Orden Orden2,
		PC.IndicadorMontoMinimo,
		0 AS FlagNueva,
		'' AS TipoTallaColor,
		 3 AS TipoEstrategiaImagenMostrar,
		PC.CodigoProducto,
		E.EtiquetaID,
		E.EtiquetaID2,
		E.CodigoEstrategia,
		E.TieneVariedad,
		TE.CODIGO,
		TE.DescripcionEstrategia,
		 ISNULL(TE.FlagMostrarImg,0) AS FlagMostrarImg,
		M.Descripcion AS DescripcionMarca,
		'NO DISPONIBLE' AS DescripcionCategoria,
		E.PrecioPublico,
		E.Ganancia 
	FROM dbo.Estrategia E WITH (NOLOCK)
		INNER JOIN @OfertasPersonalizadas op
			ON E.CampaniaID = op.AnioCampanaVenta
			AND E.CUV2 = op.CUV
		INNER JOIN ods.ProductoComercial PC WITH (NOLOCK)
			ON PC.CUV = E.CUV2
			AND PC.AnoCampania = E.CampaniaID
		INNER JOIN dbo.TipoEstrategia TE WITH (NOLOCK)
			ON E.TipoEstrategiaID = TE.TipoEstrategiaID
			AND TE.Codigo = @EstrategiaCodigo
		LEFT JOIN dbo.Marca M WITH (NOLOCK)
			ON M.MarcaId = PC.MarcaId
	WHERE E.Activo = 1
		AND TE.FlagActivo = 1
		AND TE.flagRecoPerfil = 1
	ORDER BY op.Orden ASC, EstrategiaID ASC
SET NOCOUNT OFF
END
GO

USE BelcorpChile
GO

GO
/****** Object:  StoredProcedure [dbo].[ListarEstrategiasOPT]    Script Date: 20/11/2018 15:11:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Exec ListarEstrategiasOPT  201806, '000685941'
ALTER PROCEDURE [dbo].[ListarEstrategiasOPT]
(
	@CampaniaID int,
	@CodigoConsultora varchar(30)
)
AS
BEGIN
  SET NOCOUNT ON
	DECLARE @StrCampaniaID char(6) = CONVERT(char(6), @CampaniaID)
	DECLARE @EstrategiaCodigo varchar(100) = '001'
	DECLARE @OfertasPersonalizadas TABLE (
	  Orden int,
	  CUV char(6),
	  TipoPersonalizacion char(3),
	  FlagRevista int,
	  AnioCampanaVenta int
	)
	
	DECLARE @codConsultoraDefault VARCHAR(9) = ''
	SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001

	INSERT INTO @OfertasPersonalizadas
	SELECT
		ISNULL(Orden, 0),
		CUV,
		TipoPersonalizacion,
		FlagRevista,
		CONVERT(int, AnioCampanaVenta)
	FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
	WHERE op.CodConsultora = @CodigoConsultora
		AND op.AnioCampanaVenta = @StrCampaniaID
		AND op.TipoPersonalizacion = 'OPT'
	IF NOT EXISTS (SELECT   CUV  FROM @OfertasPersonalizadas)
	BEGIN
		INSERT INTO @OfertasPersonalizadas
		SELECT
			ISNULL(Orden, 0),
			CUV,
			TipoPersonalizacion,
			FlagRevista,
			CONVERT(int, AnioCampanaVenta)
		FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
		WHERE op.CodConsultora = @codConsultoraDefault
			AND op.AnioCampanaVenta = @StrCampaniaID
			AND op.TipoPersonalizacion = 'OPT'
	END
	INSERT INTO @OfertasPersonalizadas(Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta)
	SELECT Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta
	FROM dbo.ListarEstrategiasForzadas(@CampaniaID, @EstrategiaCodigo)

	  SELECT
		E.EstrategiaID,
		E.CUV2,
		E.DescripcionCUV2,
		 dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
		E.Precio,
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID2) EtiquetaDescripcion2,
		E.Precio2,
		ISNULL(E.TextoLibre, '') AS TextoLibre,
		E.FlagEstrella,
		E.ColorFondo,
		E.TipoEstrategiaID,
		E.ImagenURL AS FotoProducto01,
		E.ImagenURL,
		E.LimiteVenta,
		PC.MarcaID,
		TE.Orden AS Orden1,
		op.Orden Orden2,
		PC.IndicadorMontoMinimo,
		0 AS FlagNueva,
		'' AS TipoTallaColor,
		 3 AS TipoEstrategiaImagenMostrar,
		PC.CodigoProducto,
		E.EtiquetaID,
		E.EtiquetaID2,
		E.CodigoEstrategia,
		E.TieneVariedad,
		TE.CODIGO,
		TE.DescripcionEstrategia,
		 ISNULL(TE.FlagMostrarImg,0) AS FlagMostrarImg,
		M.Descripcion AS DescripcionMarca,
		'NO DISPONIBLE' AS DescripcionCategoria,
		E.PrecioPublico,
		E.Ganancia 
	FROM dbo.Estrategia E WITH (NOLOCK)
		INNER JOIN @OfertasPersonalizadas op
			ON E.CampaniaID = op.AnioCampanaVenta
			AND E.CUV2 = op.CUV
		INNER JOIN ods.ProductoComercial PC WITH (NOLOCK)
			ON PC.CUV = E.CUV2
			AND PC.AnoCampania = E.CampaniaID
		INNER JOIN dbo.TipoEstrategia TE WITH (NOLOCK)
			ON E.TipoEstrategiaID = TE.TipoEstrategiaID
			AND TE.Codigo = @EstrategiaCodigo
		LEFT JOIN dbo.Marca M WITH (NOLOCK)
			ON M.MarcaId = PC.MarcaId
	WHERE E.Activo = 1
		AND TE.FlagActivo = 1
		AND TE.flagRecoPerfil = 1
	ORDER BY op.Orden ASC, EstrategiaID ASC
SET NOCOUNT OFF
END
GO

USE BelcorpBolivia
GO

GO
/****** Object:  StoredProcedure [dbo].[ListarEstrategiasOPT]    Script Date: 20/11/2018 15:11:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Exec ListarEstrategiasOPT  201806, '000685941'
ALTER PROCEDURE [dbo].[ListarEstrategiasOPT]
(
	@CampaniaID int,
	@CodigoConsultora varchar(30)
)
AS
BEGIN
  SET NOCOUNT ON
	DECLARE @StrCampaniaID char(6) = CONVERT(char(6), @CampaniaID)
	DECLARE @EstrategiaCodigo varchar(100) = '001'
	DECLARE @OfertasPersonalizadas TABLE (
	  Orden int,
	  CUV char(6),
	  TipoPersonalizacion char(3),
	  FlagRevista int,
	  AnioCampanaVenta int
	)
	
	DECLARE @codConsultoraDefault VARCHAR(9) = ''
	SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001

	INSERT INTO @OfertasPersonalizadas
	SELECT
		ISNULL(Orden, 0),
		CUV,
		TipoPersonalizacion,
		FlagRevista,
		CONVERT(int, AnioCampanaVenta)
	FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
	WHERE op.CodConsultora = @CodigoConsultora
		AND op.AnioCampanaVenta = @StrCampaniaID
		AND op.TipoPersonalizacion = 'OPT'
	IF NOT EXISTS (SELECT   CUV  FROM @OfertasPersonalizadas)
	BEGIN
		INSERT INTO @OfertasPersonalizadas
		SELECT
			ISNULL(Orden, 0),
			CUV,
			TipoPersonalizacion,
			FlagRevista,
			CONVERT(int, AnioCampanaVenta)
		FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
		WHERE op.CodConsultora = @codConsultoraDefault
			AND op.AnioCampanaVenta = @StrCampaniaID
			AND op.TipoPersonalizacion = 'OPT'
	END
	INSERT INTO @OfertasPersonalizadas(Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta)
	SELECT Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta
	FROM dbo.ListarEstrategiasForzadas(@CampaniaID, @EstrategiaCodigo)

	  SELECT
		E.EstrategiaID,
		E.CUV2,
		E.DescripcionCUV2,
		 dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
		E.Precio,
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID2) EtiquetaDescripcion2,
		E.Precio2,
		ISNULL(E.TextoLibre, '') AS TextoLibre,
		E.FlagEstrella,
		E.ColorFondo,
		E.TipoEstrategiaID,
		E.ImagenURL AS FotoProducto01,
		E.ImagenURL,
		E.LimiteVenta,
		PC.MarcaID,
		TE.Orden AS Orden1,
		op.Orden Orden2,
		PC.IndicadorMontoMinimo,
		0 AS FlagNueva,
		'' AS TipoTallaColor,
		 3 AS TipoEstrategiaImagenMostrar,
		PC.CodigoProducto,
		E.EtiquetaID,
		E.EtiquetaID2,
		E.CodigoEstrategia,
		E.TieneVariedad,
		TE.CODIGO,
		TE.DescripcionEstrategia,
		 ISNULL(TE.FlagMostrarImg,0) AS FlagMostrarImg,
		M.Descripcion AS DescripcionMarca,
		'NO DISPONIBLE' AS DescripcionCategoria,
		E.PrecioPublico,
		E.Ganancia 
	FROM dbo.Estrategia E WITH (NOLOCK)
		INNER JOIN @OfertasPersonalizadas op
			ON E.CampaniaID = op.AnioCampanaVenta
			AND E.CUV2 = op.CUV
		INNER JOIN ods.ProductoComercial PC WITH (NOLOCK)
			ON PC.CUV = E.CUV2
			AND PC.AnoCampania = E.CampaniaID
		INNER JOIN dbo.TipoEstrategia TE WITH (NOLOCK)
			ON E.TipoEstrategiaID = TE.TipoEstrategiaID
			AND TE.Codigo = @EstrategiaCodigo
		LEFT JOIN dbo.Marca M WITH (NOLOCK)
			ON M.MarcaId = PC.MarcaId
	WHERE E.Activo = 1
		AND TE.FlagActivo = 1
		AND TE.flagRecoPerfil = 1
	ORDER BY op.Orden ASC, EstrategiaID ASC
SET NOCOUNT OFF
END
GO

