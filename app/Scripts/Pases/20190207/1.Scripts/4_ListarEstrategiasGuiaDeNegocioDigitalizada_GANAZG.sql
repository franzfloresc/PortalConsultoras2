﻿USE BelcorpPeru
GO

GO
/****** Object:  StoredProcedure [dbo].[ListarEstrategiasGuiaDeNegocioDigitalizada]    Script Date: 20/11/2018 17:02:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Exec dbo.ListarEstrategiasGuiaDeNegocioDigitalizada 201807, ''
ALTER PROCEDURE [dbo].[ListarEstrategiasGuiaDeNegocioDigitalizada]
(
	@CampaniaID int,
	@CodigoConsultora varchar(30)
)
AS
BEGIN
SET NOCOUNT ON
	DECLARE @StrCampaniaID char(6) = CONVERT(char(6), @CampaniaID)
	DECLARE @EstrategiaCodigo varchar(100) = '010'
	DECLARE @OfertasPersonalizadas TABLE (
	  Orden int,
	  CUV char(6),
	  TipoPersonalizacion char(3),
	  FlagRevista int,
	  AnioCampanaVenta int
	)

	DECLARE @codConsultoraDefault VARCHAR(9) = ''
	SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001

	-- xxxxxxxxx
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
		AND op.TipoPersonalizacion = 'GND'

	-- yyyyyyyyy
	INSERT INTO @OfertasPersonalizadas(Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta)
	SELECT Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta
	FROM dbo.ListarEstrategiasForzadas(@CampaniaID, @EstrategiaCodigo)

	SELECT DISTINCT
    EstrategiaID,
    CUV2,
    DescripcionCUV2,
    dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
    e.Precio,
    dbo.ObtenerDescripcionEtiqueta(EtiquetaID2) EtiquetaDescripcion2,
    Precio2,
    ISNULL(TextoLibre, '') AS TextoLibre,
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
    '' AS TipoTallaColor,
    3 AS TipoEstrategiaImagenMostrar,
    E.EtiquetaID,
    E.EtiquetaID2,
    E.CodigoEstrategia,
    E.TieneVariedad,
    TE.CODIGO,
    TE.DescripcionEstrategia,
    ISNULL(TE.FlagMostrarImg, 0) AS FlagMostrarImg,
    E.PrecioPublico,
    E.Ganancia,
    M.Descripcion AS DescripcionMarca,
    op.FlagRevista
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
/****** Object:  StoredProcedure [dbo].[ListarEstrategiasGuiaDeNegocioDigitalizada]    Script Date: 20/11/2018 17:02:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Exec dbo.ListarEstrategiasGuiaDeNegocioDigitalizada 201807, ''
ALTER PROCEDURE [dbo].[ListarEstrategiasGuiaDeNegocioDigitalizada]
(
	@CampaniaID int,
	@CodigoConsultora varchar(30)
)
AS
BEGIN
SET NOCOUNT ON
	DECLARE @StrCampaniaID char(6) = CONVERT(char(6), @CampaniaID)
	DECLARE @EstrategiaCodigo varchar(100) = '010'
	DECLARE @OfertasPersonalizadas TABLE (
	  Orden int,
	  CUV char(6),
	  TipoPersonalizacion char(3),
	  FlagRevista int,
	  AnioCampanaVenta int
	)

	DECLARE @codConsultoraDefault VARCHAR(9) = ''
	SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001

	-- xxxxxxxxx
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
		AND op.TipoPersonalizacion = 'GND'

	-- yyyyyyyyy
	INSERT INTO @OfertasPersonalizadas(Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta)
	SELECT Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta
	FROM dbo.ListarEstrategiasForzadas(@CampaniaID, @EstrategiaCodigo)

	SELECT DISTINCT
    EstrategiaID,
    CUV2,
    DescripcionCUV2,
    dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
    e.Precio,
    dbo.ObtenerDescripcionEtiqueta(EtiquetaID2) EtiquetaDescripcion2,
    Precio2,
    ISNULL(TextoLibre, '') AS TextoLibre,
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
    '' AS TipoTallaColor,
    3 AS TipoEstrategiaImagenMostrar,
    E.EtiquetaID,
    E.EtiquetaID2,
    E.CodigoEstrategia,
    E.TieneVariedad,
    TE.CODIGO,
    TE.DescripcionEstrategia,
    ISNULL(TE.FlagMostrarImg, 0) AS FlagMostrarImg,
    E.PrecioPublico,
    E.Ganancia,
    M.Descripcion AS DescripcionMarca,
    op.FlagRevista
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
/****** Object:  StoredProcedure [dbo].[ListarEstrategiasGuiaDeNegocioDigitalizada]    Script Date: 20/11/2018 17:02:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Exec dbo.ListarEstrategiasGuiaDeNegocioDigitalizada 201807, ''
ALTER PROCEDURE [dbo].[ListarEstrategiasGuiaDeNegocioDigitalizada]
(
	@CampaniaID int,
	@CodigoConsultora varchar(30)
)
AS
BEGIN
SET NOCOUNT ON
	DECLARE @StrCampaniaID char(6) = CONVERT(char(6), @CampaniaID)
	DECLARE @EstrategiaCodigo varchar(100) = '010'
	DECLARE @OfertasPersonalizadas TABLE (
	  Orden int,
	  CUV char(6),
	  TipoPersonalizacion char(3),
	  FlagRevista int,
	  AnioCampanaVenta int
	)

	DECLARE @codConsultoraDefault VARCHAR(9) = ''
	SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001

	-- xxxxxxxxx
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
		AND op.TipoPersonalizacion = 'GND'

	-- yyyyyyyyy
	INSERT INTO @OfertasPersonalizadas(Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta)
	SELECT Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta
	FROM dbo.ListarEstrategiasForzadas(@CampaniaID, @EstrategiaCodigo)

	SELECT DISTINCT
    EstrategiaID,
    CUV2,
    DescripcionCUV2,
    dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
    e.Precio,
    dbo.ObtenerDescripcionEtiqueta(EtiquetaID2) EtiquetaDescripcion2,
    Precio2,
    ISNULL(TextoLibre, '') AS TextoLibre,
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
    '' AS TipoTallaColor,
    3 AS TipoEstrategiaImagenMostrar,
    E.EtiquetaID,
    E.EtiquetaID2,
    E.CodigoEstrategia,
    E.TieneVariedad,
    TE.CODIGO,
    TE.DescripcionEstrategia,
    ISNULL(TE.FlagMostrarImg, 0) AS FlagMostrarImg,
    E.PrecioPublico,
    E.Ganancia,
    M.Descripcion AS DescripcionMarca,
    op.FlagRevista
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
/****** Object:  StoredProcedure [dbo].[ListarEstrategiasGuiaDeNegocioDigitalizada]    Script Date: 20/11/2018 17:02:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Exec dbo.ListarEstrategiasGuiaDeNegocioDigitalizada 201807, ''
ALTER PROCEDURE [dbo].[ListarEstrategiasGuiaDeNegocioDigitalizada]
(
	@CampaniaID int,
	@CodigoConsultora varchar(30)
)
AS
BEGIN
SET NOCOUNT ON
	DECLARE @StrCampaniaID char(6) = CONVERT(char(6), @CampaniaID)
	DECLARE @EstrategiaCodigo varchar(100) = '010'
	DECLARE @OfertasPersonalizadas TABLE (
	  Orden int,
	  CUV char(6),
	  TipoPersonalizacion char(3),
	  FlagRevista int,
	  AnioCampanaVenta int
	)

	DECLARE @codConsultoraDefault VARCHAR(9) = ''
	SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001

	-- xxxxxxxxx
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
		AND op.TipoPersonalizacion = 'GND'

	-- yyyyyyyyy
	INSERT INTO @OfertasPersonalizadas(Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta)
	SELECT Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta
	FROM dbo.ListarEstrategiasForzadas(@CampaniaID, @EstrategiaCodigo)

	SELECT DISTINCT
    EstrategiaID,
    CUV2,
    DescripcionCUV2,
    dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
    e.Precio,
    dbo.ObtenerDescripcionEtiqueta(EtiquetaID2) EtiquetaDescripcion2,
    Precio2,
    ISNULL(TextoLibre, '') AS TextoLibre,
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
    '' AS TipoTallaColor,
    3 AS TipoEstrategiaImagenMostrar,
    E.EtiquetaID,
    E.EtiquetaID2,
    E.CodigoEstrategia,
    E.TieneVariedad,
    TE.CODIGO,
    TE.DescripcionEstrategia,
    ISNULL(TE.FlagMostrarImg, 0) AS FlagMostrarImg,
    E.PrecioPublico,
    E.Ganancia,
    M.Descripcion AS DescripcionMarca,
    op.FlagRevista
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
/****** Object:  StoredProcedure [dbo].[ListarEstrategiasGuiaDeNegocioDigitalizada]    Script Date: 20/11/2018 17:02:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Exec dbo.ListarEstrategiasGuiaDeNegocioDigitalizada 201807, ''
ALTER PROCEDURE [dbo].[ListarEstrategiasGuiaDeNegocioDigitalizada]
(
	@CampaniaID int,
	@CodigoConsultora varchar(30)
)
AS
BEGIN
SET NOCOUNT ON
	DECLARE @StrCampaniaID char(6) = CONVERT(char(6), @CampaniaID)
	DECLARE @EstrategiaCodigo varchar(100) = '010'
	DECLARE @OfertasPersonalizadas TABLE (
	  Orden int,
	  CUV char(6),
	  TipoPersonalizacion char(3),
	  FlagRevista int,
	  AnioCampanaVenta int
	)

	DECLARE @codConsultoraDefault VARCHAR(9) = ''
	SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001

	-- xxxxxxxxx
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
		AND op.TipoPersonalizacion = 'GND'

	-- yyyyyyyyy
	INSERT INTO @OfertasPersonalizadas(Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta)
	SELECT Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta
	FROM dbo.ListarEstrategiasForzadas(@CampaniaID, @EstrategiaCodigo)

	SELECT DISTINCT
    EstrategiaID,
    CUV2,
    DescripcionCUV2,
    dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
    e.Precio,
    dbo.ObtenerDescripcionEtiqueta(EtiquetaID2) EtiquetaDescripcion2,
    Precio2,
    ISNULL(TextoLibre, '') AS TextoLibre,
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
    '' AS TipoTallaColor,
    3 AS TipoEstrategiaImagenMostrar,
    E.EtiquetaID,
    E.EtiquetaID2,
    E.CodigoEstrategia,
    E.TieneVariedad,
    TE.CODIGO,
    TE.DescripcionEstrategia,
    ISNULL(TE.FlagMostrarImg, 0) AS FlagMostrarImg,
    E.PrecioPublico,
    E.Ganancia,
    M.Descripcion AS DescripcionMarca,
    op.FlagRevista
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
/****** Object:  StoredProcedure [dbo].[ListarEstrategiasGuiaDeNegocioDigitalizada]    Script Date: 20/11/2018 17:02:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Exec dbo.ListarEstrategiasGuiaDeNegocioDigitalizada 201807, ''
ALTER PROCEDURE [dbo].[ListarEstrategiasGuiaDeNegocioDigitalizada]
(
	@CampaniaID int,
	@CodigoConsultora varchar(30)
)
AS
BEGIN
SET NOCOUNT ON
	DECLARE @StrCampaniaID char(6) = CONVERT(char(6), @CampaniaID)
	DECLARE @EstrategiaCodigo varchar(100) = '010'
	DECLARE @OfertasPersonalizadas TABLE (
	  Orden int,
	  CUV char(6),
	  TipoPersonalizacion char(3),
	  FlagRevista int,
	  AnioCampanaVenta int
	)

	DECLARE @codConsultoraDefault VARCHAR(9) = ''
	SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001

	-- xxxxxxxxx
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
		AND op.TipoPersonalizacion = 'GND'

	-- yyyyyyyyy
	INSERT INTO @OfertasPersonalizadas(Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta)
	SELECT Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta
	FROM dbo.ListarEstrategiasForzadas(@CampaniaID, @EstrategiaCodigo)

	SELECT DISTINCT
    EstrategiaID,
    CUV2,
    DescripcionCUV2,
    dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
    e.Precio,
    dbo.ObtenerDescripcionEtiqueta(EtiquetaID2) EtiquetaDescripcion2,
    Precio2,
    ISNULL(TextoLibre, '') AS TextoLibre,
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
    '' AS TipoTallaColor,
    3 AS TipoEstrategiaImagenMostrar,
    E.EtiquetaID,
    E.EtiquetaID2,
    E.CodigoEstrategia,
    E.TieneVariedad,
    TE.CODIGO,
    TE.DescripcionEstrategia,
    ISNULL(TE.FlagMostrarImg, 0) AS FlagMostrarImg,
    E.PrecioPublico,
    E.Ganancia,
    M.Descripcion AS DescripcionMarca,
    op.FlagRevista
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
/****** Object:  StoredProcedure [dbo].[ListarEstrategiasGuiaDeNegocioDigitalizada]    Script Date: 20/11/2018 17:02:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Exec dbo.ListarEstrategiasGuiaDeNegocioDigitalizada 201807, ''
ALTER PROCEDURE [dbo].[ListarEstrategiasGuiaDeNegocioDigitalizada]
(
	@CampaniaID int,
	@CodigoConsultora varchar(30)
)
AS
BEGIN
SET NOCOUNT ON
	DECLARE @StrCampaniaID char(6) = CONVERT(char(6), @CampaniaID)
	DECLARE @EstrategiaCodigo varchar(100) = '010'
	DECLARE @OfertasPersonalizadas TABLE (
	  Orden int,
	  CUV char(6),
	  TipoPersonalizacion char(3),
	  FlagRevista int,
	  AnioCampanaVenta int
	)

	DECLARE @codConsultoraDefault VARCHAR(9) = ''
	SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001

	-- xxxxxxxxx
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
		AND op.TipoPersonalizacion = 'GND'

	-- yyyyyyyyy
	INSERT INTO @OfertasPersonalizadas(Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta)
	SELECT Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta
	FROM dbo.ListarEstrategiasForzadas(@CampaniaID, @EstrategiaCodigo)

	SELECT DISTINCT
    EstrategiaID,
    CUV2,
    DescripcionCUV2,
    dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
    e.Precio,
    dbo.ObtenerDescripcionEtiqueta(EtiquetaID2) EtiquetaDescripcion2,
    Precio2,
    ISNULL(TextoLibre, '') AS TextoLibre,
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
    '' AS TipoTallaColor,
    3 AS TipoEstrategiaImagenMostrar,
    E.EtiquetaID,
    E.EtiquetaID2,
    E.CodigoEstrategia,
    E.TieneVariedad,
    TE.CODIGO,
    TE.DescripcionEstrategia,
    ISNULL(TE.FlagMostrarImg, 0) AS FlagMostrarImg,
    E.PrecioPublico,
    E.Ganancia,
    M.Descripcion AS DescripcionMarca,
    op.FlagRevista
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
/****** Object:  StoredProcedure [dbo].[ListarEstrategiasGuiaDeNegocioDigitalizada]    Script Date: 20/11/2018 17:02:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Exec dbo.ListarEstrategiasGuiaDeNegocioDigitalizada 201807, ''
ALTER PROCEDURE [dbo].[ListarEstrategiasGuiaDeNegocioDigitalizada]
(
	@CampaniaID int,
	@CodigoConsultora varchar(30)
)
AS
BEGIN
SET NOCOUNT ON
	DECLARE @StrCampaniaID char(6) = CONVERT(char(6), @CampaniaID)
	DECLARE @EstrategiaCodigo varchar(100) = '010'
	DECLARE @OfertasPersonalizadas TABLE (
	  Orden int,
	  CUV char(6),
	  TipoPersonalizacion char(3),
	  FlagRevista int,
	  AnioCampanaVenta int
	)

	DECLARE @codConsultoraDefault VARCHAR(9) = ''
	SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001

	-- xxxxxxxxx
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
		AND op.TipoPersonalizacion = 'GND'

	-- yyyyyyyyy
	INSERT INTO @OfertasPersonalizadas(Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta)
	SELECT Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta
	FROM dbo.ListarEstrategiasForzadas(@CampaniaID, @EstrategiaCodigo)

	SELECT DISTINCT
    EstrategiaID,
    CUV2,
    DescripcionCUV2,
    dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
    e.Precio,
    dbo.ObtenerDescripcionEtiqueta(EtiquetaID2) EtiquetaDescripcion2,
    Precio2,
    ISNULL(TextoLibre, '') AS TextoLibre,
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
    '' AS TipoTallaColor,
    3 AS TipoEstrategiaImagenMostrar,
    E.EtiquetaID,
    E.EtiquetaID2,
    E.CodigoEstrategia,
    E.TieneVariedad,
    TE.CODIGO,
    TE.DescripcionEstrategia,
    ISNULL(TE.FlagMostrarImg, 0) AS FlagMostrarImg,
    E.PrecioPublico,
    E.Ganancia,
    M.Descripcion AS DescripcionMarca,
    op.FlagRevista
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
/****** Object:  StoredProcedure [dbo].[ListarEstrategiasGuiaDeNegocioDigitalizada]    Script Date: 20/11/2018 17:02:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Exec dbo.ListarEstrategiasGuiaDeNegocioDigitalizada 201807, ''
ALTER PROCEDURE [dbo].[ListarEstrategiasGuiaDeNegocioDigitalizada]
(
	@CampaniaID int,
	@CodigoConsultora varchar(30)
)
AS
BEGIN
SET NOCOUNT ON
	DECLARE @StrCampaniaID char(6) = CONVERT(char(6), @CampaniaID)
	DECLARE @EstrategiaCodigo varchar(100) = '010'
	DECLARE @OfertasPersonalizadas TABLE (
	  Orden int,
	  CUV char(6),
	  TipoPersonalizacion char(3),
	  FlagRevista int,
	  AnioCampanaVenta int
	)

	DECLARE @codConsultoraDefault VARCHAR(9) = ''
	SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001

	-- xxxxxxxxx
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
		AND op.TipoPersonalizacion = 'GND'

	-- yyyyyyyyy
	INSERT INTO @OfertasPersonalizadas(Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta)
	SELECT Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta
	FROM dbo.ListarEstrategiasForzadas(@CampaniaID, @EstrategiaCodigo)

	SELECT DISTINCT
    EstrategiaID,
    CUV2,
    DescripcionCUV2,
    dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
    e.Precio,
    dbo.ObtenerDescripcionEtiqueta(EtiquetaID2) EtiquetaDescripcion2,
    Precio2,
    ISNULL(TextoLibre, '') AS TextoLibre,
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
    '' AS TipoTallaColor,
    3 AS TipoEstrategiaImagenMostrar,
    E.EtiquetaID,
    E.EtiquetaID2,
    E.CodigoEstrategia,
    E.TieneVariedad,
    TE.CODIGO,
    TE.DescripcionEstrategia,
    ISNULL(TE.FlagMostrarImg, 0) AS FlagMostrarImg,
    E.PrecioPublico,
    E.Ganancia,
    M.Descripcion AS DescripcionMarca,
    op.FlagRevista
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
/****** Object:  StoredProcedure [dbo].[ListarEstrategiasGuiaDeNegocioDigitalizada]    Script Date: 20/11/2018 17:02:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Exec dbo.ListarEstrategiasGuiaDeNegocioDigitalizada 201807, ''
ALTER PROCEDURE [dbo].[ListarEstrategiasGuiaDeNegocioDigitalizada]
(
	@CampaniaID int,
	@CodigoConsultora varchar(30)
)
AS
BEGIN
SET NOCOUNT ON
	DECLARE @StrCampaniaID char(6) = CONVERT(char(6), @CampaniaID)
	DECLARE @EstrategiaCodigo varchar(100) = '010'
	DECLARE @OfertasPersonalizadas TABLE (
	  Orden int,
	  CUV char(6),
	  TipoPersonalizacion char(3),
	  FlagRevista int,
	  AnioCampanaVenta int
	)

	DECLARE @codConsultoraDefault VARCHAR(9) = ''
	SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001

	-- xxxxxxxxx
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
		AND op.TipoPersonalizacion = 'GND'

	-- yyyyyyyyy
	INSERT INTO @OfertasPersonalizadas(Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta)
	SELECT Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta
	FROM dbo.ListarEstrategiasForzadas(@CampaniaID, @EstrategiaCodigo)

	SELECT DISTINCT
    EstrategiaID,
    CUV2,
    DescripcionCUV2,
    dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
    e.Precio,
    dbo.ObtenerDescripcionEtiqueta(EtiquetaID2) EtiquetaDescripcion2,
    Precio2,
    ISNULL(TextoLibre, '') AS TextoLibre,
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
    '' AS TipoTallaColor,
    3 AS TipoEstrategiaImagenMostrar,
    E.EtiquetaID,
    E.EtiquetaID2,
    E.CodigoEstrategia,
    E.TieneVariedad,
    TE.CODIGO,
    TE.DescripcionEstrategia,
    ISNULL(TE.FlagMostrarImg, 0) AS FlagMostrarImg,
    E.PrecioPublico,
    E.Ganancia,
    M.Descripcion AS DescripcionMarca,
    op.FlagRevista
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
/****** Object:  StoredProcedure [dbo].[ListarEstrategiasGuiaDeNegocioDigitalizada]    Script Date: 20/11/2018 17:02:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Exec dbo.ListarEstrategiasGuiaDeNegocioDigitalizada 201807, ''
ALTER PROCEDURE [dbo].[ListarEstrategiasGuiaDeNegocioDigitalizada]
(
	@CampaniaID int,
	@CodigoConsultora varchar(30)
)
AS
BEGIN
SET NOCOUNT ON
	DECLARE @StrCampaniaID char(6) = CONVERT(char(6), @CampaniaID)
	DECLARE @EstrategiaCodigo varchar(100) = '010'
	DECLARE @OfertasPersonalizadas TABLE (
	  Orden int,
	  CUV char(6),
	  TipoPersonalizacion char(3),
	  FlagRevista int,
	  AnioCampanaVenta int
	)

	DECLARE @codConsultoraDefault VARCHAR(9) = ''
	SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001

	-- xxxxxxxxx
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
		AND op.TipoPersonalizacion = 'GND'

	-- yyyyyyyyy
	INSERT INTO @OfertasPersonalizadas(Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta)
	SELECT Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta
	FROM dbo.ListarEstrategiasForzadas(@CampaniaID, @EstrategiaCodigo)

	SELECT DISTINCT
    EstrategiaID,
    CUV2,
    DescripcionCUV2,
    dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
    e.Precio,
    dbo.ObtenerDescripcionEtiqueta(EtiquetaID2) EtiquetaDescripcion2,
    Precio2,
    ISNULL(TextoLibre, '') AS TextoLibre,
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
    '' AS TipoTallaColor,
    3 AS TipoEstrategiaImagenMostrar,
    E.EtiquetaID,
    E.EtiquetaID2,
    E.CodigoEstrategia,
    E.TieneVariedad,
    TE.CODIGO,
    TE.DescripcionEstrategia,
    ISNULL(TE.FlagMostrarImg, 0) AS FlagMostrarImg,
    E.PrecioPublico,
    E.Ganancia,
    M.Descripcion AS DescripcionMarca,
    op.FlagRevista
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
/****** Object:  StoredProcedure [dbo].[ListarEstrategiasGuiaDeNegocioDigitalizada]    Script Date: 20/11/2018 17:02:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Exec dbo.ListarEstrategiasGuiaDeNegocioDigitalizada 201807, ''
ALTER PROCEDURE [dbo].[ListarEstrategiasGuiaDeNegocioDigitalizada]
(
	@CampaniaID int,
	@CodigoConsultora varchar(30)
)
AS
BEGIN
SET NOCOUNT ON
	DECLARE @StrCampaniaID char(6) = CONVERT(char(6), @CampaniaID)
	DECLARE @EstrategiaCodigo varchar(100) = '010'
	DECLARE @OfertasPersonalizadas TABLE (
	  Orden int,
	  CUV char(6),
	  TipoPersonalizacion char(3),
	  FlagRevista int,
	  AnioCampanaVenta int
	)

	DECLARE @codConsultoraDefault VARCHAR(9) = ''
	SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001

	-- xxxxxxxxx
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
		AND op.TipoPersonalizacion = 'GND'

	-- yyyyyyyyy
	INSERT INTO @OfertasPersonalizadas(Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta)
	SELECT Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta
	FROM dbo.ListarEstrategiasForzadas(@CampaniaID, @EstrategiaCodigo)

	SELECT DISTINCT
    EstrategiaID,
    CUV2,
    DescripcionCUV2,
    dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
    e.Precio,
    dbo.ObtenerDescripcionEtiqueta(EtiquetaID2) EtiquetaDescripcion2,
    Precio2,
    ISNULL(TextoLibre, '') AS TextoLibre,
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
    '' AS TipoTallaColor,
    3 AS TipoEstrategiaImagenMostrar,
    E.EtiquetaID,
    E.EtiquetaID2,
    E.CodigoEstrategia,
    E.TieneVariedad,
    TE.CODIGO,
    TE.DescripcionEstrategia,
    ISNULL(TE.FlagMostrarImg, 0) AS FlagMostrarImg,
    E.PrecioPublico,
    E.Ganancia,
    M.Descripcion AS DescripcionMarca,
    op.FlagRevista
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

