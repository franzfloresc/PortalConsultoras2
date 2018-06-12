GO
USE BelcorpPeru
GO

GO
-- Exec dbo.ListarEstrategiasGuiaDeNegocioDigitalizada 201807, ''
ALTER  PROCEDURE [dbo].[ListarEstrategiasGuiaDeNegocioDigitalizada]
(
	@CampaniaID int,
	@CodigoConsultora varchar(30)
)
AS
BEGIN
  SET NOCOUNT ON

DECLARE @StrCampaniaID char(6) = CONVERT(char(6), @CampaniaID)
DECLARE @EstrategiaCodigo varchar(100) = '010'
DECLARE @tablaCuvFaltante TABLE (
  CUV varchar(6)
)

DECLARE @OfertasPersonalizadas TABLE (
  Orden int,
  CUV char(6),
  TipoPersonalizacion char(3),
  FlagRevista int,
  AnioCampanaVenta int
)
INSERT INTO @tablaCuvFaltante (CUV)
  SELECT
    CUV
  FROM dbo.ObtenerCuvFaltante (@CampaniaID, @CodigoConsultora)

  	DECLARE @codConsultoraForzada VARCHAR(9) = ''
	DECLARE @codConsultoraDefault VARCHAR(9) = ''
	SELECT @codConsultoraForzada = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10002
	SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001

	IF(@codConsultoraForzada <> @CodigoConsultora)
	BEGIN
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
			AND op.TipoPersonalizacion = 'GND'
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
				AND op.TipoPersonalizacion = 'GND'
		END
	END

	IF(@codConsultoraDefault<>@CodigoConsultora)
	BEGIN
		INSERT INTO @OfertasPersonalizadas(Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta)
		SELECT Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta
		FROM dbo.ListarEstrategiasForzadas(@CampaniaID, @EstrategiaCodigo)
	END
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
	  INNER JOIN @OfertasPersonalizadas op    ON E.CampaniaID = op.AnioCampanaVenta    AND E.CUV2 = op.CUV
	  INNER JOIN ods.ProductoComercial PC WITH (NOLOCK)    ON PC.CUV = E.CUV2    AND PC.AnoCampania = E.CampaniaID
	  INNER JOIN dbo.TipoEstrategia TE WITH (NOLOCK)    ON E.TipoEstrategiaID = TE.TipoEstrategiaID    AND TE.Codigo = @EstrategiaCodigo
	  LEFT JOIN dbo.Marca M WITH (NOLOCK)    ON M.MarcaId = PC.MarcaId
  WHERE E.Activo = 1
	  AND TE.FlagActivo = 1
	  AND TE.flagRecoPerfil = 1
	  AND NOT EXISTS (SELECT    CUV  FROM @tablaCuvFaltante TF  WHERE E.CUV2 = TF.CUV)
    ORDER BY
		op.Orden ASC, EstrategiaID ASC

  SET NOCOUNT OFF
END
GO

GO
USE BelcorpMexico
GO

GO
-- Exec dbo.ListarEstrategiasGuiaDeNegocioDigitalizada 201807, ''
ALTER  PROCEDURE [dbo].[ListarEstrategiasGuiaDeNegocioDigitalizada]
(
	@CampaniaID int,
	@CodigoConsultora varchar(30)
)
AS
BEGIN
  SET NOCOUNT ON

DECLARE @StrCampaniaID char(6) = CONVERT(char(6), @CampaniaID)
DECLARE @EstrategiaCodigo varchar(100) = '010'
DECLARE @tablaCuvFaltante TABLE (
  CUV varchar(6)
)

DECLARE @OfertasPersonalizadas TABLE (
  Orden int,
  CUV char(6),
  TipoPersonalizacion char(3),
  FlagRevista int,
  AnioCampanaVenta int
)
INSERT INTO @tablaCuvFaltante (CUV)
  SELECT
    CUV
  FROM dbo.ObtenerCuvFaltante (@CampaniaID, @CodigoConsultora)

  	DECLARE @codConsultoraForzada VARCHAR(9) = ''
	DECLARE @codConsultoraDefault VARCHAR(9) = ''
	SELECT @codConsultoraForzada = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10002
	SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001

	IF(@codConsultoraForzada <> @CodigoConsultora)
	BEGIN
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
			AND op.TipoPersonalizacion = 'GND'
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
				AND op.TipoPersonalizacion = 'GND'
		END
	END

	IF(@codConsultoraDefault<>@CodigoConsultora)
	BEGIN
		INSERT INTO @OfertasPersonalizadas(Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta)
		SELECT Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta
		FROM dbo.ListarEstrategiasForzadas(@CampaniaID, @EstrategiaCodigo)
	END
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
	  INNER JOIN @OfertasPersonalizadas op    ON E.CampaniaID = op.AnioCampanaVenta    AND E.CUV2 = op.CUV
	  INNER JOIN ods.ProductoComercial PC WITH (NOLOCK)    ON PC.CUV = E.CUV2    AND PC.AnoCampania = E.CampaniaID
	  INNER JOIN dbo.TipoEstrategia TE WITH (NOLOCK)    ON E.TipoEstrategiaID = TE.TipoEstrategiaID    AND TE.Codigo = @EstrategiaCodigo
	  LEFT JOIN dbo.Marca M WITH (NOLOCK)    ON M.MarcaId = PC.MarcaId
  WHERE E.Activo = 1
	  AND TE.FlagActivo = 1
	  AND TE.flagRecoPerfil = 1
	  AND NOT EXISTS (SELECT    CUV  FROM @tablaCuvFaltante TF  WHERE E.CUV2 = TF.CUV)
    ORDER BY
		op.Orden ASC, EstrategiaID ASC

  SET NOCOUNT OFF
END
GO

GO
USE BelcorpColombia
GO

GO
-- Exec dbo.ListarEstrategiasGuiaDeNegocioDigitalizada 201807, ''
ALTER  PROCEDURE [dbo].[ListarEstrategiasGuiaDeNegocioDigitalizada]
(
	@CampaniaID int,
	@CodigoConsultora varchar(30)
)
AS
BEGIN
  SET NOCOUNT ON

DECLARE @StrCampaniaID char(6) = CONVERT(char(6), @CampaniaID)
DECLARE @EstrategiaCodigo varchar(100) = '010'
DECLARE @tablaCuvFaltante TABLE (
  CUV varchar(6)
)

DECLARE @OfertasPersonalizadas TABLE (
  Orden int,
  CUV char(6),
  TipoPersonalizacion char(3),
  FlagRevista int,
  AnioCampanaVenta int
)
INSERT INTO @tablaCuvFaltante (CUV)
  SELECT
    CUV
  FROM dbo.ObtenerCuvFaltante (@CampaniaID, @CodigoConsultora)

  	DECLARE @codConsultoraForzada VARCHAR(9) = ''
	DECLARE @codConsultoraDefault VARCHAR(9) = ''
	SELECT @codConsultoraForzada = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10002
	SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001

	IF(@codConsultoraForzada <> @CodigoConsultora)
	BEGIN
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
			AND op.TipoPersonalizacion = 'GND'
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
				AND op.TipoPersonalizacion = 'GND'
		END
	END

	IF(@codConsultoraDefault<>@CodigoConsultora)
	BEGIN
		INSERT INTO @OfertasPersonalizadas(Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta)
		SELECT Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta
		FROM dbo.ListarEstrategiasForzadas(@CampaniaID, @EstrategiaCodigo)
	END
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
	  INNER JOIN @OfertasPersonalizadas op    ON E.CampaniaID = op.AnioCampanaVenta    AND E.CUV2 = op.CUV
	  INNER JOIN ods.ProductoComercial PC WITH (NOLOCK)    ON PC.CUV = E.CUV2    AND PC.AnoCampania = E.CampaniaID
	  INNER JOIN dbo.TipoEstrategia TE WITH (NOLOCK)    ON E.TipoEstrategiaID = TE.TipoEstrategiaID    AND TE.Codigo = @EstrategiaCodigo
	  LEFT JOIN dbo.Marca M WITH (NOLOCK)    ON M.MarcaId = PC.MarcaId
  WHERE E.Activo = 1
	  AND TE.FlagActivo = 1
	  AND TE.flagRecoPerfil = 1
	  AND NOT EXISTS (SELECT    CUV  FROM @tablaCuvFaltante TF  WHERE E.CUV2 = TF.CUV)
    ORDER BY
		op.Orden ASC, EstrategiaID ASC

  SET NOCOUNT OFF
END
GO

GO
USE BelcorpSalvador
GO

GO
-- Exec dbo.ListarEstrategiasGuiaDeNegocioDigitalizada 201807, ''
ALTER  PROCEDURE [dbo].[ListarEstrategiasGuiaDeNegocioDigitalizada]
(
	@CampaniaID int,
	@CodigoConsultora varchar(30)
)
AS
BEGIN
  SET NOCOUNT ON

DECLARE @StrCampaniaID char(6) = CONVERT(char(6), @CampaniaID)
DECLARE @EstrategiaCodigo varchar(100) = '010'
DECLARE @tablaCuvFaltante TABLE (
  CUV varchar(6)
)

DECLARE @OfertasPersonalizadas TABLE (
  Orden int,
  CUV char(6),
  TipoPersonalizacion char(3),
  FlagRevista int,
  AnioCampanaVenta int
)
INSERT INTO @tablaCuvFaltante (CUV)
  SELECT
    CUV
  FROM dbo.ObtenerCuvFaltante (@CampaniaID, @CodigoConsultora)

  	DECLARE @codConsultoraForzada VARCHAR(9) = ''
	DECLARE @codConsultoraDefault VARCHAR(9) = ''
	SELECT @codConsultoraForzada = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10002
	SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001

	IF(@codConsultoraForzada <> @CodigoConsultora)
	BEGIN
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
			AND op.TipoPersonalizacion = 'GND'
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
				AND op.TipoPersonalizacion = 'GND'
		END
	END

	IF(@codConsultoraDefault<>@CodigoConsultora)
	BEGIN
		INSERT INTO @OfertasPersonalizadas(Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta)
		SELECT Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta
		FROM dbo.ListarEstrategiasForzadas(@CampaniaID, @EstrategiaCodigo)
	END
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
	  INNER JOIN @OfertasPersonalizadas op    ON E.CampaniaID = op.AnioCampanaVenta    AND E.CUV2 = op.CUV
	  INNER JOIN ods.ProductoComercial PC WITH (NOLOCK)    ON PC.CUV = E.CUV2    AND PC.AnoCampania = E.CampaniaID
	  INNER JOIN dbo.TipoEstrategia TE WITH (NOLOCK)    ON E.TipoEstrategiaID = TE.TipoEstrategiaID    AND TE.Codigo = @EstrategiaCodigo
	  LEFT JOIN dbo.Marca M WITH (NOLOCK)    ON M.MarcaId = PC.MarcaId
  WHERE E.Activo = 1
	  AND TE.FlagActivo = 1
	  AND TE.flagRecoPerfil = 1
	  AND NOT EXISTS (SELECT    CUV  FROM @tablaCuvFaltante TF  WHERE E.CUV2 = TF.CUV)
    ORDER BY
		op.Orden ASC, EstrategiaID ASC

  SET NOCOUNT OFF
END
GO

GO
USE BelcorpPuertoRico
GO

GO
-- Exec dbo.ListarEstrategiasGuiaDeNegocioDigitalizada 201807, ''
ALTER  PROCEDURE [dbo].[ListarEstrategiasGuiaDeNegocioDigitalizada]
(
	@CampaniaID int,
	@CodigoConsultora varchar(30)
)
AS
BEGIN
  SET NOCOUNT ON

DECLARE @StrCampaniaID char(6) = CONVERT(char(6), @CampaniaID)
DECLARE @EstrategiaCodigo varchar(100) = '010'
DECLARE @tablaCuvFaltante TABLE (
  CUV varchar(6)
)

DECLARE @OfertasPersonalizadas TABLE (
  Orden int,
  CUV char(6),
  TipoPersonalizacion char(3),
  FlagRevista int,
  AnioCampanaVenta int
)
INSERT INTO @tablaCuvFaltante (CUV)
  SELECT
    CUV
  FROM dbo.ObtenerCuvFaltante (@CampaniaID, @CodigoConsultora)

  	DECLARE @codConsultoraForzada VARCHAR(9) = ''
	DECLARE @codConsultoraDefault VARCHAR(9) = ''
	SELECT @codConsultoraForzada = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10002
	SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001

	IF(@codConsultoraForzada <> @CodigoConsultora)
	BEGIN
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
			AND op.TipoPersonalizacion = 'GND'
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
				AND op.TipoPersonalizacion = 'GND'
		END
	END

	IF(@codConsultoraDefault<>@CodigoConsultora)
	BEGIN
		INSERT INTO @OfertasPersonalizadas(Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta)
		SELECT Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta
		FROM dbo.ListarEstrategiasForzadas(@CampaniaID, @EstrategiaCodigo)
	END
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
	  INNER JOIN @OfertasPersonalizadas op    ON E.CampaniaID = op.AnioCampanaVenta    AND E.CUV2 = op.CUV
	  INNER JOIN ods.ProductoComercial PC WITH (NOLOCK)    ON PC.CUV = E.CUV2    AND PC.AnoCampania = E.CampaniaID
	  INNER JOIN dbo.TipoEstrategia TE WITH (NOLOCK)    ON E.TipoEstrategiaID = TE.TipoEstrategiaID    AND TE.Codigo = @EstrategiaCodigo
	  LEFT JOIN dbo.Marca M WITH (NOLOCK)    ON M.MarcaId = PC.MarcaId
  WHERE E.Activo = 1
	  AND TE.FlagActivo = 1
	  AND TE.flagRecoPerfil = 1
	  AND NOT EXISTS (SELECT    CUV  FROM @tablaCuvFaltante TF  WHERE E.CUV2 = TF.CUV)
    ORDER BY
		op.Orden ASC, EstrategiaID ASC

  SET NOCOUNT OFF
END
GO

GO
USE BelcorpPanama
GO

GO
-- Exec dbo.ListarEstrategiasGuiaDeNegocioDigitalizada 201807, ''
ALTER  PROCEDURE [dbo].[ListarEstrategiasGuiaDeNegocioDigitalizada]
(
	@CampaniaID int,
	@CodigoConsultora varchar(30)
)
AS
BEGIN
  SET NOCOUNT ON

DECLARE @StrCampaniaID char(6) = CONVERT(char(6), @CampaniaID)
DECLARE @EstrategiaCodigo varchar(100) = '010'
DECLARE @tablaCuvFaltante TABLE (
  CUV varchar(6)
)

DECLARE @OfertasPersonalizadas TABLE (
  Orden int,
  CUV char(6),
  TipoPersonalizacion char(3),
  FlagRevista int,
  AnioCampanaVenta int
)
INSERT INTO @tablaCuvFaltante (CUV)
  SELECT
    CUV
  FROM dbo.ObtenerCuvFaltante (@CampaniaID, @CodigoConsultora)

  	DECLARE @codConsultoraForzada VARCHAR(9) = ''
	DECLARE @codConsultoraDefault VARCHAR(9) = ''
	SELECT @codConsultoraForzada = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10002
	SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001

	IF(@codConsultoraForzada <> @CodigoConsultora)
	BEGIN
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
			AND op.TipoPersonalizacion = 'GND'
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
				AND op.TipoPersonalizacion = 'GND'
		END
	END

	IF(@codConsultoraDefault<>@CodigoConsultora)
	BEGIN
		INSERT INTO @OfertasPersonalizadas(Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta)
		SELECT Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta
		FROM dbo.ListarEstrategiasForzadas(@CampaniaID, @EstrategiaCodigo)
	END
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
	  INNER JOIN @OfertasPersonalizadas op    ON E.CampaniaID = op.AnioCampanaVenta    AND E.CUV2 = op.CUV
	  INNER JOIN ods.ProductoComercial PC WITH (NOLOCK)    ON PC.CUV = E.CUV2    AND PC.AnoCampania = E.CampaniaID
	  INNER JOIN dbo.TipoEstrategia TE WITH (NOLOCK)    ON E.TipoEstrategiaID = TE.TipoEstrategiaID    AND TE.Codigo = @EstrategiaCodigo
	  LEFT JOIN dbo.Marca M WITH (NOLOCK)    ON M.MarcaId = PC.MarcaId
  WHERE E.Activo = 1
	  AND TE.FlagActivo = 1
	  AND TE.flagRecoPerfil = 1
	  AND NOT EXISTS (SELECT    CUV  FROM @tablaCuvFaltante TF  WHERE E.CUV2 = TF.CUV)
    ORDER BY
		op.Orden ASC, EstrategiaID ASC

  SET NOCOUNT OFF
END
GO

GO
USE BelcorpGuatemala
GO

GO
-- Exec dbo.ListarEstrategiasGuiaDeNegocioDigitalizada 201807, ''
ALTER  PROCEDURE [dbo].[ListarEstrategiasGuiaDeNegocioDigitalizada]
(
	@CampaniaID int,
	@CodigoConsultora varchar(30)
)
AS
BEGIN
  SET NOCOUNT ON

DECLARE @StrCampaniaID char(6) = CONVERT(char(6), @CampaniaID)
DECLARE @EstrategiaCodigo varchar(100) = '010'
DECLARE @tablaCuvFaltante TABLE (
  CUV varchar(6)
)

DECLARE @OfertasPersonalizadas TABLE (
  Orden int,
  CUV char(6),
  TipoPersonalizacion char(3),
  FlagRevista int,
  AnioCampanaVenta int
)
INSERT INTO @tablaCuvFaltante (CUV)
  SELECT
    CUV
  FROM dbo.ObtenerCuvFaltante (@CampaniaID, @CodigoConsultora)

  	DECLARE @codConsultoraForzada VARCHAR(9) = ''
	DECLARE @codConsultoraDefault VARCHAR(9) = ''
	SELECT @codConsultoraForzada = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10002
	SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001

	IF(@codConsultoraForzada <> @CodigoConsultora)
	BEGIN
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
			AND op.TipoPersonalizacion = 'GND'
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
				AND op.TipoPersonalizacion = 'GND'
		END
	END

	IF(@codConsultoraDefault<>@CodigoConsultora)
	BEGIN
		INSERT INTO @OfertasPersonalizadas(Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta)
		SELECT Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta
		FROM dbo.ListarEstrategiasForzadas(@CampaniaID, @EstrategiaCodigo)
	END
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
	  INNER JOIN @OfertasPersonalizadas op    ON E.CampaniaID = op.AnioCampanaVenta    AND E.CUV2 = op.CUV
	  INNER JOIN ods.ProductoComercial PC WITH (NOLOCK)    ON PC.CUV = E.CUV2    AND PC.AnoCampania = E.CampaniaID
	  INNER JOIN dbo.TipoEstrategia TE WITH (NOLOCK)    ON E.TipoEstrategiaID = TE.TipoEstrategiaID    AND TE.Codigo = @EstrategiaCodigo
	  LEFT JOIN dbo.Marca M WITH (NOLOCK)    ON M.MarcaId = PC.MarcaId
  WHERE E.Activo = 1
	  AND TE.FlagActivo = 1
	  AND TE.flagRecoPerfil = 1
	  AND NOT EXISTS (SELECT    CUV  FROM @tablaCuvFaltante TF  WHERE E.CUV2 = TF.CUV)
    ORDER BY
		op.Orden ASC, EstrategiaID ASC

  SET NOCOUNT OFF
END
GO

GO
USE BelcorpEcuador
GO

GO
-- Exec dbo.ListarEstrategiasGuiaDeNegocioDigitalizada 201807, ''
ALTER  PROCEDURE [dbo].[ListarEstrategiasGuiaDeNegocioDigitalizada]
(
	@CampaniaID int,
	@CodigoConsultora varchar(30)
)
AS
BEGIN
  SET NOCOUNT ON

DECLARE @StrCampaniaID char(6) = CONVERT(char(6), @CampaniaID)
DECLARE @EstrategiaCodigo varchar(100) = '010'
DECLARE @tablaCuvFaltante TABLE (
  CUV varchar(6)
)

DECLARE @OfertasPersonalizadas TABLE (
  Orden int,
  CUV char(6),
  TipoPersonalizacion char(3),
  FlagRevista int,
  AnioCampanaVenta int
)
INSERT INTO @tablaCuvFaltante (CUV)
  SELECT
    CUV
  FROM dbo.ObtenerCuvFaltante (@CampaniaID, @CodigoConsultora)

  	DECLARE @codConsultoraForzada VARCHAR(9) = ''
	DECLARE @codConsultoraDefault VARCHAR(9) = ''
	SELECT @codConsultoraForzada = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10002
	SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001

	IF(@codConsultoraForzada <> @CodigoConsultora)
	BEGIN
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
			AND op.TipoPersonalizacion = 'GND'
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
				AND op.TipoPersonalizacion = 'GND'
		END
	END

	IF(@codConsultoraDefault<>@CodigoConsultora)
	BEGIN
		INSERT INTO @OfertasPersonalizadas(Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta)
		SELECT Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta
		FROM dbo.ListarEstrategiasForzadas(@CampaniaID, @EstrategiaCodigo)
	END
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
	  INNER JOIN @OfertasPersonalizadas op    ON E.CampaniaID = op.AnioCampanaVenta    AND E.CUV2 = op.CUV
	  INNER JOIN ods.ProductoComercial PC WITH (NOLOCK)    ON PC.CUV = E.CUV2    AND PC.AnoCampania = E.CampaniaID
	  INNER JOIN dbo.TipoEstrategia TE WITH (NOLOCK)    ON E.TipoEstrategiaID = TE.TipoEstrategiaID    AND TE.Codigo = @EstrategiaCodigo
	  LEFT JOIN dbo.Marca M WITH (NOLOCK)    ON M.MarcaId = PC.MarcaId
  WHERE E.Activo = 1
	  AND TE.FlagActivo = 1
	  AND TE.flagRecoPerfil = 1
	  AND NOT EXISTS (SELECT    CUV  FROM @tablaCuvFaltante TF  WHERE E.CUV2 = TF.CUV)
    ORDER BY
		op.Orden ASC, EstrategiaID ASC

  SET NOCOUNT OFF
END
GO

GO
USE BelcorpDominicana
GO

GO
-- Exec dbo.ListarEstrategiasGuiaDeNegocioDigitalizada 201807, ''
ALTER  PROCEDURE [dbo].[ListarEstrategiasGuiaDeNegocioDigitalizada]
(
	@CampaniaID int,
	@CodigoConsultora varchar(30)
)
AS
BEGIN
  SET NOCOUNT ON

DECLARE @StrCampaniaID char(6) = CONVERT(char(6), @CampaniaID)
DECLARE @EstrategiaCodigo varchar(100) = '010'
DECLARE @tablaCuvFaltante TABLE (
  CUV varchar(6)
)

DECLARE @OfertasPersonalizadas TABLE (
  Orden int,
  CUV char(6),
  TipoPersonalizacion char(3),
  FlagRevista int,
  AnioCampanaVenta int
)
INSERT INTO @tablaCuvFaltante (CUV)
  SELECT
    CUV
  FROM dbo.ObtenerCuvFaltante (@CampaniaID, @CodigoConsultora)

  	DECLARE @codConsultoraForzada VARCHAR(9) = ''
	DECLARE @codConsultoraDefault VARCHAR(9) = ''
	SELECT @codConsultoraForzada = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10002
	SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001

	IF(@codConsultoraForzada <> @CodigoConsultora)
	BEGIN
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
			AND op.TipoPersonalizacion = 'GND'
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
				AND op.TipoPersonalizacion = 'GND'
		END
	END

	IF(@codConsultoraDefault<>@CodigoConsultora)
	BEGIN
		INSERT INTO @OfertasPersonalizadas(Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta)
		SELECT Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta
		FROM dbo.ListarEstrategiasForzadas(@CampaniaID, @EstrategiaCodigo)
	END
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
	  INNER JOIN @OfertasPersonalizadas op    ON E.CampaniaID = op.AnioCampanaVenta    AND E.CUV2 = op.CUV
	  INNER JOIN ods.ProductoComercial PC WITH (NOLOCK)    ON PC.CUV = E.CUV2    AND PC.AnoCampania = E.CampaniaID
	  INNER JOIN dbo.TipoEstrategia TE WITH (NOLOCK)    ON E.TipoEstrategiaID = TE.TipoEstrategiaID    AND TE.Codigo = @EstrategiaCodigo
	  LEFT JOIN dbo.Marca M WITH (NOLOCK)    ON M.MarcaId = PC.MarcaId
  WHERE E.Activo = 1
	  AND TE.FlagActivo = 1
	  AND TE.flagRecoPerfil = 1
	  AND NOT EXISTS (SELECT    CUV  FROM @tablaCuvFaltante TF  WHERE E.CUV2 = TF.CUV)
    ORDER BY
		op.Orden ASC, EstrategiaID ASC

  SET NOCOUNT OFF
END
GO

GO
USE BelcorpCostaRica
GO

GO
-- Exec dbo.ListarEstrategiasGuiaDeNegocioDigitalizada 201807, ''
ALTER  PROCEDURE [dbo].[ListarEstrategiasGuiaDeNegocioDigitalizada]
(
	@CampaniaID int,
	@CodigoConsultora varchar(30)
)
AS
BEGIN
  SET NOCOUNT ON

DECLARE @StrCampaniaID char(6) = CONVERT(char(6), @CampaniaID)
DECLARE @EstrategiaCodigo varchar(100) = '010'
DECLARE @tablaCuvFaltante TABLE (
  CUV varchar(6)
)

DECLARE @OfertasPersonalizadas TABLE (
  Orden int,
  CUV char(6),
  TipoPersonalizacion char(3),
  FlagRevista int,
  AnioCampanaVenta int
)
INSERT INTO @tablaCuvFaltante (CUV)
  SELECT
    CUV
  FROM dbo.ObtenerCuvFaltante (@CampaniaID, @CodigoConsultora)

  	DECLARE @codConsultoraForzada VARCHAR(9) = ''
	DECLARE @codConsultoraDefault VARCHAR(9) = ''
	SELECT @codConsultoraForzada = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10002
	SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001

	IF(@codConsultoraForzada <> @CodigoConsultora)
	BEGIN
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
			AND op.TipoPersonalizacion = 'GND'
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
				AND op.TipoPersonalizacion = 'GND'
		END
	END

	IF(@codConsultoraDefault<>@CodigoConsultora)
	BEGIN
		INSERT INTO @OfertasPersonalizadas(Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta)
		SELECT Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta
		FROM dbo.ListarEstrategiasForzadas(@CampaniaID, @EstrategiaCodigo)
	END
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
	  INNER JOIN @OfertasPersonalizadas op    ON E.CampaniaID = op.AnioCampanaVenta    AND E.CUV2 = op.CUV
	  INNER JOIN ods.ProductoComercial PC WITH (NOLOCK)    ON PC.CUV = E.CUV2    AND PC.AnoCampania = E.CampaniaID
	  INNER JOIN dbo.TipoEstrategia TE WITH (NOLOCK)    ON E.TipoEstrategiaID = TE.TipoEstrategiaID    AND TE.Codigo = @EstrategiaCodigo
	  LEFT JOIN dbo.Marca M WITH (NOLOCK)    ON M.MarcaId = PC.MarcaId
  WHERE E.Activo = 1
	  AND TE.FlagActivo = 1
	  AND TE.flagRecoPerfil = 1
	  AND NOT EXISTS (SELECT    CUV  FROM @tablaCuvFaltante TF  WHERE E.CUV2 = TF.CUV)
    ORDER BY
		op.Orden ASC, EstrategiaID ASC

  SET NOCOUNT OFF
END
GO

GO
USE BelcorpChile
GO

GO
-- Exec dbo.ListarEstrategiasGuiaDeNegocioDigitalizada 201807, ''
ALTER  PROCEDURE [dbo].[ListarEstrategiasGuiaDeNegocioDigitalizada]
(
	@CampaniaID int,
	@CodigoConsultora varchar(30)
)
AS
BEGIN
  SET NOCOUNT ON

DECLARE @StrCampaniaID char(6) = CONVERT(char(6), @CampaniaID)
DECLARE @EstrategiaCodigo varchar(100) = '010'
DECLARE @tablaCuvFaltante TABLE (
  CUV varchar(6)
)

DECLARE @OfertasPersonalizadas TABLE (
  Orden int,
  CUV char(6),
  TipoPersonalizacion char(3),
  FlagRevista int,
  AnioCampanaVenta int
)
INSERT INTO @tablaCuvFaltante (CUV)
  SELECT
    CUV
  FROM dbo.ObtenerCuvFaltante (@CampaniaID, @CodigoConsultora)

  	DECLARE @codConsultoraForzada VARCHAR(9) = ''
	DECLARE @codConsultoraDefault VARCHAR(9) = ''
	SELECT @codConsultoraForzada = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10002
	SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001

	IF(@codConsultoraForzada <> @CodigoConsultora)
	BEGIN
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
			AND op.TipoPersonalizacion = 'GND'
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
				AND op.TipoPersonalizacion = 'GND'
		END
	END

	IF(@codConsultoraDefault<>@CodigoConsultora)
	BEGIN
		INSERT INTO @OfertasPersonalizadas(Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta)
		SELECT Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta
		FROM dbo.ListarEstrategiasForzadas(@CampaniaID, @EstrategiaCodigo)
	END
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
	  INNER JOIN @OfertasPersonalizadas op    ON E.CampaniaID = op.AnioCampanaVenta    AND E.CUV2 = op.CUV
	  INNER JOIN ods.ProductoComercial PC WITH (NOLOCK)    ON PC.CUV = E.CUV2    AND PC.AnoCampania = E.CampaniaID
	  INNER JOIN dbo.TipoEstrategia TE WITH (NOLOCK)    ON E.TipoEstrategiaID = TE.TipoEstrategiaID    AND TE.Codigo = @EstrategiaCodigo
	  LEFT JOIN dbo.Marca M WITH (NOLOCK)    ON M.MarcaId = PC.MarcaId
  WHERE E.Activo = 1
	  AND TE.FlagActivo = 1
	  AND TE.flagRecoPerfil = 1
	  AND NOT EXISTS (SELECT    CUV  FROM @tablaCuvFaltante TF  WHERE E.CUV2 = TF.CUV)
    ORDER BY
		op.Orden ASC, EstrategiaID ASC

  SET NOCOUNT OFF
END
GO

GO
USE BelcorpBolivia
GO

GO
-- Exec dbo.ListarEstrategiasGuiaDeNegocioDigitalizada 201807, ''
ALTER  PROCEDURE [dbo].[ListarEstrategiasGuiaDeNegocioDigitalizada]
(
	@CampaniaID int,
	@CodigoConsultora varchar(30)
)
AS
BEGIN
  SET NOCOUNT ON

DECLARE @StrCampaniaID char(6) = CONVERT(char(6), @CampaniaID)
DECLARE @EstrategiaCodigo varchar(100) = '010'
DECLARE @tablaCuvFaltante TABLE (
  CUV varchar(6)
)

DECLARE @OfertasPersonalizadas TABLE (
  Orden int,
  CUV char(6),
  TipoPersonalizacion char(3),
  FlagRevista int,
  AnioCampanaVenta int
)
INSERT INTO @tablaCuvFaltante (CUV)
  SELECT
    CUV
  FROM dbo.ObtenerCuvFaltante (@CampaniaID, @CodigoConsultora)

  	DECLARE @codConsultoraForzada VARCHAR(9) = ''
	DECLARE @codConsultoraDefault VARCHAR(9) = ''
	SELECT @codConsultoraForzada = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10002
	SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001

	IF(@codConsultoraForzada <> @CodigoConsultora)
	BEGIN
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
			AND op.TipoPersonalizacion = 'GND'
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
				AND op.TipoPersonalizacion = 'GND'
		END
	END

	IF(@codConsultoraDefault<>@CodigoConsultora)
	BEGIN
		INSERT INTO @OfertasPersonalizadas(Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta)
		SELECT Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta
		FROM dbo.ListarEstrategiasForzadas(@CampaniaID, @EstrategiaCodigo)
	END
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
	  INNER JOIN @OfertasPersonalizadas op    ON E.CampaniaID = op.AnioCampanaVenta    AND E.CUV2 = op.CUV
	  INNER JOIN ods.ProductoComercial PC WITH (NOLOCK)    ON PC.CUV = E.CUV2    AND PC.AnoCampania = E.CampaniaID
	  INNER JOIN dbo.TipoEstrategia TE WITH (NOLOCK)    ON E.TipoEstrategiaID = TE.TipoEstrategiaID    AND TE.Codigo = @EstrategiaCodigo
	  LEFT JOIN dbo.Marca M WITH (NOLOCK)    ON M.MarcaId = PC.MarcaId
  WHERE E.Activo = 1
	  AND TE.FlagActivo = 1
	  AND TE.flagRecoPerfil = 1
	  AND NOT EXISTS (SELECT    CUV  FROM @tablaCuvFaltante TF  WHERE E.CUV2 = TF.CUV)
    ORDER BY
		op.Orden ASC, EstrategiaID ASC

  SET NOCOUNT OFF
END
GO

GO
