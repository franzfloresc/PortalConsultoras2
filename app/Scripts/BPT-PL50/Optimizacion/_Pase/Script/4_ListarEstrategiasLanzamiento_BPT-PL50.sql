GO
USE BelcorpPeru
GO

GO
-- exec dbo.ListarEstrategiasLanzamiento 201807, '000685941'
ALTER PROCEDURE [dbo].[ListarEstrategiasLanzamiento]
@CampaniaID INT,
@CodigoConsultora VARCHAR(30)
AS
BEGIN
SET NOCOUNT ON
DECLARE @StrCampaniaID char(6) = CONVERT(char(6), @CampaniaID)
DECLARE @EstrategiaCodigo varchar(100) = '005'

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
		FROM ods.OfertasPersonalizadas WITH (NOLOCK)
		WHERE CodConsultora = @CodigoConsultora
			AND AnioCampanaVenta = @StrCampaniaID
			AND TipoPersonalizacion = 'LAN'

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
				AND op.TipoPersonalizacion = 'LAN'
		END
	END
	IF(@codConsultoraDefault<>@CodigoConsultora)
	INSERT INTO @OfertasPersonalizadas(Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta)
		SELECT Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta
		FROM dbo.ListarEstrategiasForzadas(@CampaniaID, @EstrategiaCodigo)

	DECLARE @OfertaEstrategiasLanzamiento TABLE (
	  EstrategiaID int,
	  CUV2 varchar(5),
	  DescripcionCUV2 varchar(800),
	  EtiquetaDescripcion varchar(8000),
	  Precio numeric(12, 2),
	  EtiquetaDescripcion2 varchar(8000),
	  Precio2 numeric(12, 2),
	  TextoLibre varchar(800),
	  FlagEstrella bit,
	  ColorFondo varchar(20),
	  TipoEstrategiaID int,
	  FotoProducto01 varchar(800),
	  ImagenURL varchar(500),
	  LimiteVenta int,
	  MarcaID int,
	  DescripcionMarca VARCHAR(20),
	  Orden1 int,
	  Orden2 int,
	  IndicadorMontoMinimo int,
	  CodigoProducto varchar(12),
	  FlagNueva int,
	  TipoTallaColor varchar(50),
	  TipoEstrategiaImagenMostrar int,
	  EtiquetaID int,
	  EtiquetaID2 int,
	  CodigoEstrategia varchar(100),
	  TieneVariedad int,
	  CODIGO varchar(100),
	  DescripcionEstrategia varchar(200),
	  FlagMostrarImg int,
	  PrecioPublico decimal(18, 2),
	  Ganancia decimal(18, 2)
	)
	INSERT INTO @OfertaEstrategiasLanzamiento
	SELECT
		EstrategiaID,
		CUV2,
		DescripcionCUV2,
		EtiquetaDescripcion,
		Precio,
		EtiquetaDescripcion2,
		Precio2,
		TextoLibre,
		FlagEstrella,
		ColorFondo,
		TipoEstrategiaID,
		FotoProducto01,
		ImagenURL,
		LimiteVenta,
		MarcaID,
		Descripcion,
		Orden Orden1,
		Orden Orden2,
		IndicadorMontoMinimo,
		CodigoProducto,
		FlagNueva,
		TipoTallaColor,
		TipoEstrategiaImagenMostrar,
		EtiquetaID,
		EtiquetaID2,
		CodigoEstrategia,
		TieneVariedad,
		CODIGO,
		DescripcionEstrategia,
		FlagMostrarImg,
		PrecioPublico,
		Ganancia
	 FROM(
	  SELECT DISTINCT
		E.EstrategiaID,
		e.CUV2,
		e.DescripcionCUV2,
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
		e.Precio,
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID2) EtiquetaDescripcion2,
		e.Precio2,
		e.TextoLibre,
		e.FlagEstrella,
		e.ColorFondo,
		e.TipoEstrategiaID,
		e.ImagenURL FotoProducto01,
		te.ImagenEstrategia ImagenURL,
		e.LimiteVenta,
		pc.MarcaID,
		M.Descripcion,
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
		op.Orden
	  FROM dbo.Estrategia E WITH (NOLOCK)
		  INNER JOIN @OfertasPersonalizadas op    ON E.CampaniaID = op.AnioCampanaVenta    AND E.CUV2 = op.CUV
		  INNER JOIN ods.ProductoComercial PC WITH (NOLOCK)    ON PC.CUV = E.CUV2    AND PC.AnoCampania = E.CampaniaID
		  INNER JOIN dbo.TipoEstrategia TE WITH (NOLOCK)    ON E.TipoEstrategiaID = TE.TipoEstrategiaID    AND TE.Codigo = @EstrategiaCodigo
		  LEFT JOIN dbo.Marca M WITH (NOLOCK)    ON M.MarcaId = PC.MarcaId
	  WHERE E.Activo = 1
		  AND TE.FlagActivo = 1
		  AND TE.flagRecoPerfil = 1
		  AND NOT EXISTS (SELECT    CUV  FROM @tablaCuvFaltante TF  WHERE E.CUV2 = TF.CUV)) op
		ORDER BY
			op.Orden ASC, EstrategiaID ASC

	DECLARE @DetalleEstrategiasLanzamiento TABLE (
	  EstrategiaID int,
	  TablaLogicaDatosId smallint,
	  Valor varchar(500)
	)
	INSERT @DetalleEstrategiasLanzamiento
	  SELECT
		ED.EstrategiaID,
		ED.TablaLogicaDatosId,
		ED.Valor
	  FROM @OfertaEstrategiasLanzamiento T
	  LEFT JOIN dbo.EstrategiaDetalle ED WITH (NOLOCK)    ON ED.EstrategiaID = T.EstrategiaID
		AND TablaLogicaDatosId BETWEEN 10201 AND 10213

	DECLARE @EstrategiasLanzamiento TABLE (
	  EstrategiaID int,
	  FlagIndividual bit,
	  Slogan varchar(1000),
	  ImgFondoDesktop varchar(1000),
	  ImgSelloProductoDesktop varchar(1000),
	  UrlVideoDesktop varchar(1000),
	  ImgFichaFondoDesktop varchar(1000),
	  ImgFondoMobile varchar(1000),
	  ImgSelloProductoMobile varchar(1000),
	  UrlVideoMobile varchar(1000),
	  ImgFichaFondoMobile varchar(1000),
	  ImgHomeDesktop varchar(1000),
	  ImgHomeMobile varchar(1000)
	)
	INSERT @EstrategiasLanzamiento
	  SELECT
		EstrategiaID,
		(SELECT CASE WHEN valor = '1' THEN 1 ELSE 0 END FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10212) AS FlagIndividual,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10213) AS Slogan,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10201) AS ImgFondoDesktop,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10203) AS ImgSelloProductoDesktop,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10204) AS UrlVideoDesktop,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10208) AS ImgFichaFondoDesktop,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10205) AS ImgFondoMobile,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10206) AS ImgSelloProductoMobile,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10207) AS UrlVideoMobile,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10209) AS ImgFichaFondoMobile,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10210) AS ImgHomeDesktop,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10211) AS ImgHomeMobile
	  FROM @OfertaEstrategiasLanzamiento AS T
	SELECT
	  T.EstrategiaID,
	  T.CUV2,
	  T.DescripcionCUV2,
	  T.EtiquetaDescripcion,
	  T.Precio,
	  T.EtiquetaDescripcion2,
	  T.Precio2,
	  ISNULL(T.TextoLibre, '') AS TextoLibre,
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
	  T.CodigoProducto,
	  T.EtiquetaID,
	  T.EtiquetaID2,
	  T.CodigoEstrategia,
	  T.TieneVariedad,
	  T.CODIGO,
	  T.DescripcionEstrategia,
	  T.FlagMostrarImg,
	  T.DescripcionMarca,
	  'NO DISPONIBLE' AS DescripcionCategoria,
	  D.FlagIndividual,
	  D.Slogan,
	  D.ImgFondoDesktop,
	  D.ImgSelloProductoDesktop AS ImgFichaDesktop,
	  D.UrlVideoDesktop,
	  D.ImgFichaFondoDesktop,
	  D.ImgFondoMobile,
	  D.ImgSelloProductoMobile AS ImgFichaMobile,
	  D.UrlVideoMobile,
	  D.ImgFichaFondoMobile,
	  D.ImgHomeDesktop,
	  D.ImgHomeMobile,
	  T.PrecioPublico,
	  T.Ganancia
	FROM @OfertaEstrategiasLanzamiento T
	LEFT JOIN @EstrategiasLanzamiento D  ON D.EstrategiaID = T.EstrategiaID
	ORDER BY Orden1 ASC, CASE
	  WHEN ISNULL(T.Orden2, 0) = 0 THEN T.Orden1
	  ELSE T.Orden2
	END ASC, EstrategiaID ASC

SET NOCOUNT OFF
END
GO

GO
USE BelcorpMexico
GO

GO
-- exec dbo.ListarEstrategiasLanzamiento 201807, '000685941'
ALTER PROCEDURE [dbo].[ListarEstrategiasLanzamiento]
@CampaniaID INT,
@CodigoConsultora VARCHAR(30)
AS
BEGIN
SET NOCOUNT ON
DECLARE @StrCampaniaID char(6) = CONVERT(char(6), @CampaniaID)
DECLARE @EstrategiaCodigo varchar(100) = '005'

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
		FROM ods.OfertasPersonalizadas WITH (NOLOCK)
		WHERE CodConsultora = @CodigoConsultora
			AND AnioCampanaVenta = @StrCampaniaID
			AND TipoPersonalizacion = 'LAN'

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
				AND op.TipoPersonalizacion = 'LAN'
		END
	END
	IF(@codConsultoraDefault<>@CodigoConsultora)
	INSERT INTO @OfertasPersonalizadas(Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta)
		SELECT Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta
		FROM dbo.ListarEstrategiasForzadas(@CampaniaID, @EstrategiaCodigo)

	DECLARE @OfertaEstrategiasLanzamiento TABLE (
	  EstrategiaID int,
	  CUV2 varchar(5),
	  DescripcionCUV2 varchar(800),
	  EtiquetaDescripcion varchar(8000),
	  Precio numeric(12, 2),
	  EtiquetaDescripcion2 varchar(8000),
	  Precio2 numeric(12, 2),
	  TextoLibre varchar(800),
	  FlagEstrella bit,
	  ColorFondo varchar(20),
	  TipoEstrategiaID int,
	  FotoProducto01 varchar(800),
	  ImagenURL varchar(500),
	  LimiteVenta int,
	  MarcaID int,
	  DescripcionMarca VARCHAR(20),
	  Orden1 int,
	  Orden2 int,
	  IndicadorMontoMinimo int,
	  CodigoProducto varchar(12),
	  FlagNueva int,
	  TipoTallaColor varchar(50),
	  TipoEstrategiaImagenMostrar int,
	  EtiquetaID int,
	  EtiquetaID2 int,
	  CodigoEstrategia varchar(100),
	  TieneVariedad int,
	  CODIGO varchar(100),
	  DescripcionEstrategia varchar(200),
	  FlagMostrarImg int,
	  PrecioPublico decimal(18, 2),
	  Ganancia decimal(18, 2)
	)
	INSERT INTO @OfertaEstrategiasLanzamiento
	SELECT
		EstrategiaID,
		CUV2,
		DescripcionCUV2,
		EtiquetaDescripcion,
		Precio,
		EtiquetaDescripcion2,
		Precio2,
		TextoLibre,
		FlagEstrella,
		ColorFondo,
		TipoEstrategiaID,
		FotoProducto01,
		ImagenURL,
		LimiteVenta,
		MarcaID,
		Descripcion,
		Orden Orden1,
		Orden Orden2,
		IndicadorMontoMinimo,
		CodigoProducto,
		FlagNueva,
		TipoTallaColor,
		TipoEstrategiaImagenMostrar,
		EtiquetaID,
		EtiquetaID2,
		CodigoEstrategia,
		TieneVariedad,
		CODIGO,
		DescripcionEstrategia,
		FlagMostrarImg,
		PrecioPublico,
		Ganancia
	 FROM(
	  SELECT DISTINCT
		E.EstrategiaID,
		e.CUV2,
		e.DescripcionCUV2,
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
		e.Precio,
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID2) EtiquetaDescripcion2,
		e.Precio2,
		e.TextoLibre,
		e.FlagEstrella,
		e.ColorFondo,
		e.TipoEstrategiaID,
		e.ImagenURL FotoProducto01,
		te.ImagenEstrategia ImagenURL,
		e.LimiteVenta,
		pc.MarcaID,
		M.Descripcion,
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
		op.Orden
	  FROM dbo.Estrategia E WITH (NOLOCK)
		  INNER JOIN @OfertasPersonalizadas op    ON E.CampaniaID = op.AnioCampanaVenta    AND E.CUV2 = op.CUV
		  INNER JOIN ods.ProductoComercial PC WITH (NOLOCK)    ON PC.CUV = E.CUV2    AND PC.AnoCampania = E.CampaniaID
		  INNER JOIN dbo.TipoEstrategia TE WITH (NOLOCK)    ON E.TipoEstrategiaID = TE.TipoEstrategiaID    AND TE.Codigo = @EstrategiaCodigo
		  LEFT JOIN dbo.Marca M WITH (NOLOCK)    ON M.MarcaId = PC.MarcaId
	  WHERE E.Activo = 1
		  AND TE.FlagActivo = 1
		  AND TE.flagRecoPerfil = 1
		  AND NOT EXISTS (SELECT    CUV  FROM @tablaCuvFaltante TF  WHERE E.CUV2 = TF.CUV)) op
		ORDER BY
			op.Orden ASC, EstrategiaID ASC

	DECLARE @DetalleEstrategiasLanzamiento TABLE (
	  EstrategiaID int,
	  TablaLogicaDatosId smallint,
	  Valor varchar(500)
	)
	INSERT @DetalleEstrategiasLanzamiento
	  SELECT
		ED.EstrategiaID,
		ED.TablaLogicaDatosId,
		ED.Valor
	  FROM @OfertaEstrategiasLanzamiento T
	  LEFT JOIN dbo.EstrategiaDetalle ED WITH (NOLOCK)    ON ED.EstrategiaID = T.EstrategiaID
		AND TablaLogicaDatosId BETWEEN 10201 AND 10213

	DECLARE @EstrategiasLanzamiento TABLE (
	  EstrategiaID int,
	  FlagIndividual bit,
	  Slogan varchar(1000),
	  ImgFondoDesktop varchar(1000),
	  ImgSelloProductoDesktop varchar(1000),
	  UrlVideoDesktop varchar(1000),
	  ImgFichaFondoDesktop varchar(1000),
	  ImgFondoMobile varchar(1000),
	  ImgSelloProductoMobile varchar(1000),
	  UrlVideoMobile varchar(1000),
	  ImgFichaFondoMobile varchar(1000),
	  ImgHomeDesktop varchar(1000),
	  ImgHomeMobile varchar(1000)
	)
	INSERT @EstrategiasLanzamiento
	  SELECT
		EstrategiaID,
		(SELECT CASE WHEN valor = '1' THEN 1 ELSE 0 END FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10212) AS FlagIndividual,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10213) AS Slogan,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10201) AS ImgFondoDesktop,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10203) AS ImgSelloProductoDesktop,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10204) AS UrlVideoDesktop,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10208) AS ImgFichaFondoDesktop,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10205) AS ImgFondoMobile,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10206) AS ImgSelloProductoMobile,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10207) AS UrlVideoMobile,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10209) AS ImgFichaFondoMobile,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10210) AS ImgHomeDesktop,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10211) AS ImgHomeMobile
	  FROM @OfertaEstrategiasLanzamiento AS T
	SELECT
	  T.EstrategiaID,
	  T.CUV2,
	  T.DescripcionCUV2,
	  T.EtiquetaDescripcion,
	  T.Precio,
	  T.EtiquetaDescripcion2,
	  T.Precio2,
	  ISNULL(T.TextoLibre, '') AS TextoLibre,
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
	  T.CodigoProducto,
	  T.EtiquetaID,
	  T.EtiquetaID2,
	  T.CodigoEstrategia,
	  T.TieneVariedad,
	  T.CODIGO,
	  T.DescripcionEstrategia,
	  T.FlagMostrarImg,
	  T.DescripcionMarca,
	  'NO DISPONIBLE' AS DescripcionCategoria,
	  D.FlagIndividual,
	  D.Slogan,
	  D.ImgFondoDesktop,
	  D.ImgSelloProductoDesktop AS ImgFichaDesktop,
	  D.UrlVideoDesktop,
	  D.ImgFichaFondoDesktop,
	  D.ImgFondoMobile,
	  D.ImgSelloProductoMobile AS ImgFichaMobile,
	  D.UrlVideoMobile,
	  D.ImgFichaFondoMobile,
	  D.ImgHomeDesktop,
	  D.ImgHomeMobile,
	  T.PrecioPublico,
	  T.Ganancia
	FROM @OfertaEstrategiasLanzamiento T
	LEFT JOIN @EstrategiasLanzamiento D  ON D.EstrategiaID = T.EstrategiaID
	ORDER BY Orden1 ASC, CASE
	  WHEN ISNULL(T.Orden2, 0) = 0 THEN T.Orden1
	  ELSE T.Orden2
	END ASC, EstrategiaID ASC

SET NOCOUNT OFF
END
GO

GO
USE BelcorpColombia
GO

GO
-- exec dbo.ListarEstrategiasLanzamiento 201807, '000685941'
ALTER PROCEDURE [dbo].[ListarEstrategiasLanzamiento]
@CampaniaID INT,
@CodigoConsultora VARCHAR(30)
AS
BEGIN
SET NOCOUNT ON
DECLARE @StrCampaniaID char(6) = CONVERT(char(6), @CampaniaID)
DECLARE @EstrategiaCodigo varchar(100) = '005'

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
		FROM ods.OfertasPersonalizadas WITH (NOLOCK)
		WHERE CodConsultora = @CodigoConsultora
			AND AnioCampanaVenta = @StrCampaniaID
			AND TipoPersonalizacion = 'LAN'

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
				AND op.TipoPersonalizacion = 'LAN'
		END
	END
	IF(@codConsultoraDefault<>@CodigoConsultora)
	INSERT INTO @OfertasPersonalizadas(Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta)
		SELECT Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta
		FROM dbo.ListarEstrategiasForzadas(@CampaniaID, @EstrategiaCodigo)

	DECLARE @OfertaEstrategiasLanzamiento TABLE (
	  EstrategiaID int,
	  CUV2 varchar(5),
	  DescripcionCUV2 varchar(800),
	  EtiquetaDescripcion varchar(8000),
	  Precio numeric(12, 2),
	  EtiquetaDescripcion2 varchar(8000),
	  Precio2 numeric(12, 2),
	  TextoLibre varchar(800),
	  FlagEstrella bit,
	  ColorFondo varchar(20),
	  TipoEstrategiaID int,
	  FotoProducto01 varchar(800),
	  ImagenURL varchar(500),
	  LimiteVenta int,
	  MarcaID int,
	  DescripcionMarca VARCHAR(20),
	  Orden1 int,
	  Orden2 int,
	  IndicadorMontoMinimo int,
	  CodigoProducto varchar(12),
	  FlagNueva int,
	  TipoTallaColor varchar(50),
	  TipoEstrategiaImagenMostrar int,
	  EtiquetaID int,
	  EtiquetaID2 int,
	  CodigoEstrategia varchar(100),
	  TieneVariedad int,
	  CODIGO varchar(100),
	  DescripcionEstrategia varchar(200),
	  FlagMostrarImg int,
	  PrecioPublico decimal(18, 2),
	  Ganancia decimal(18, 2)
	)
	INSERT INTO @OfertaEstrategiasLanzamiento
	SELECT
		EstrategiaID,
		CUV2,
		DescripcionCUV2,
		EtiquetaDescripcion,
		Precio,
		EtiquetaDescripcion2,
		Precio2,
		TextoLibre,
		FlagEstrella,
		ColorFondo,
		TipoEstrategiaID,
		FotoProducto01,
		ImagenURL,
		LimiteVenta,
		MarcaID,
		Descripcion,
		Orden Orden1,
		Orden Orden2,
		IndicadorMontoMinimo,
		CodigoProducto,
		FlagNueva,
		TipoTallaColor,
		TipoEstrategiaImagenMostrar,
		EtiquetaID,
		EtiquetaID2,
		CodigoEstrategia,
		TieneVariedad,
		CODIGO,
		DescripcionEstrategia,
		FlagMostrarImg,
		PrecioPublico,
		Ganancia
	 FROM(
	  SELECT DISTINCT
		E.EstrategiaID,
		e.CUV2,
		e.DescripcionCUV2,
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
		e.Precio,
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID2) EtiquetaDescripcion2,
		e.Precio2,
		e.TextoLibre,
		e.FlagEstrella,
		e.ColorFondo,
		e.TipoEstrategiaID,
		e.ImagenURL FotoProducto01,
		te.ImagenEstrategia ImagenURL,
		e.LimiteVenta,
		pc.MarcaID,
		M.Descripcion,
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
		op.Orden
	  FROM dbo.Estrategia E WITH (NOLOCK)
		  INNER JOIN @OfertasPersonalizadas op    ON E.CampaniaID = op.AnioCampanaVenta    AND E.CUV2 = op.CUV
		  INNER JOIN ods.ProductoComercial PC WITH (NOLOCK)    ON PC.CUV = E.CUV2    AND PC.AnoCampania = E.CampaniaID
		  INNER JOIN dbo.TipoEstrategia TE WITH (NOLOCK)    ON E.TipoEstrategiaID = TE.TipoEstrategiaID    AND TE.Codigo = @EstrategiaCodigo
		  LEFT JOIN dbo.Marca M WITH (NOLOCK)    ON M.MarcaId = PC.MarcaId
	  WHERE E.Activo = 1
		  AND TE.FlagActivo = 1
		  AND TE.flagRecoPerfil = 1
		  AND NOT EXISTS (SELECT    CUV  FROM @tablaCuvFaltante TF  WHERE E.CUV2 = TF.CUV)) op
		ORDER BY
			op.Orden ASC, EstrategiaID ASC

	DECLARE @DetalleEstrategiasLanzamiento TABLE (
	  EstrategiaID int,
	  TablaLogicaDatosId smallint,
	  Valor varchar(500)
	)
	INSERT @DetalleEstrategiasLanzamiento
	  SELECT
		ED.EstrategiaID,
		ED.TablaLogicaDatosId,
		ED.Valor
	  FROM @OfertaEstrategiasLanzamiento T
	  LEFT JOIN dbo.EstrategiaDetalle ED WITH (NOLOCK)    ON ED.EstrategiaID = T.EstrategiaID
		AND TablaLogicaDatosId BETWEEN 10201 AND 10213

	DECLARE @EstrategiasLanzamiento TABLE (
	  EstrategiaID int,
	  FlagIndividual bit,
	  Slogan varchar(1000),
	  ImgFondoDesktop varchar(1000),
	  ImgSelloProductoDesktop varchar(1000),
	  UrlVideoDesktop varchar(1000),
	  ImgFichaFondoDesktop varchar(1000),
	  ImgFondoMobile varchar(1000),
	  ImgSelloProductoMobile varchar(1000),
	  UrlVideoMobile varchar(1000),
	  ImgFichaFondoMobile varchar(1000),
	  ImgHomeDesktop varchar(1000),
	  ImgHomeMobile varchar(1000)
	)
	INSERT @EstrategiasLanzamiento
	  SELECT
		EstrategiaID,
		(SELECT CASE WHEN valor = '1' THEN 1 ELSE 0 END FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10212) AS FlagIndividual,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10213) AS Slogan,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10201) AS ImgFondoDesktop,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10203) AS ImgSelloProductoDesktop,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10204) AS UrlVideoDesktop,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10208) AS ImgFichaFondoDesktop,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10205) AS ImgFondoMobile,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10206) AS ImgSelloProductoMobile,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10207) AS UrlVideoMobile,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10209) AS ImgFichaFondoMobile,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10210) AS ImgHomeDesktop,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10211) AS ImgHomeMobile
	  FROM @OfertaEstrategiasLanzamiento AS T
	SELECT
	  T.EstrategiaID,
	  T.CUV2,
	  T.DescripcionCUV2,
	  T.EtiquetaDescripcion,
	  T.Precio,
	  T.EtiquetaDescripcion2,
	  T.Precio2,
	  ISNULL(T.TextoLibre, '') AS TextoLibre,
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
	  T.CodigoProducto,
	  T.EtiquetaID,
	  T.EtiquetaID2,
	  T.CodigoEstrategia,
	  T.TieneVariedad,
	  T.CODIGO,
	  T.DescripcionEstrategia,
	  T.FlagMostrarImg,
	  T.DescripcionMarca,
	  'NO DISPONIBLE' AS DescripcionCategoria,
	  D.FlagIndividual,
	  D.Slogan,
	  D.ImgFondoDesktop,
	  D.ImgSelloProductoDesktop AS ImgFichaDesktop,
	  D.UrlVideoDesktop,
	  D.ImgFichaFondoDesktop,
	  D.ImgFondoMobile,
	  D.ImgSelloProductoMobile AS ImgFichaMobile,
	  D.UrlVideoMobile,
	  D.ImgFichaFondoMobile,
	  D.ImgHomeDesktop,
	  D.ImgHomeMobile,
	  T.PrecioPublico,
	  T.Ganancia
	FROM @OfertaEstrategiasLanzamiento T
	LEFT JOIN @EstrategiasLanzamiento D  ON D.EstrategiaID = T.EstrategiaID
	ORDER BY Orden1 ASC, CASE
	  WHEN ISNULL(T.Orden2, 0) = 0 THEN T.Orden1
	  ELSE T.Orden2
	END ASC, EstrategiaID ASC

SET NOCOUNT OFF
END
GO

GO
USE BelcorpSalvador
GO

GO
-- exec dbo.ListarEstrategiasLanzamiento 201807, '000685941'
ALTER PROCEDURE [dbo].[ListarEstrategiasLanzamiento]
@CampaniaID INT,
@CodigoConsultora VARCHAR(30)
AS
BEGIN
SET NOCOUNT ON
DECLARE @StrCampaniaID char(6) = CONVERT(char(6), @CampaniaID)
DECLARE @EstrategiaCodigo varchar(100) = '005'

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
		FROM ods.OfertasPersonalizadas WITH (NOLOCK)
		WHERE CodConsultora = @CodigoConsultora
			AND AnioCampanaVenta = @StrCampaniaID
			AND TipoPersonalizacion = 'LAN'

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
				AND op.TipoPersonalizacion = 'LAN'
		END
	END
	IF(@codConsultoraDefault<>@CodigoConsultora)
	INSERT INTO @OfertasPersonalizadas(Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta)
		SELECT Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta
		FROM dbo.ListarEstrategiasForzadas(@CampaniaID, @EstrategiaCodigo)

	DECLARE @OfertaEstrategiasLanzamiento TABLE (
	  EstrategiaID int,
	  CUV2 varchar(5),
	  DescripcionCUV2 varchar(800),
	  EtiquetaDescripcion varchar(8000),
	  Precio numeric(12, 2),
	  EtiquetaDescripcion2 varchar(8000),
	  Precio2 numeric(12, 2),
	  TextoLibre varchar(800),
	  FlagEstrella bit,
	  ColorFondo varchar(20),
	  TipoEstrategiaID int,
	  FotoProducto01 varchar(800),
	  ImagenURL varchar(500),
	  LimiteVenta int,
	  MarcaID int,
	  DescripcionMarca VARCHAR(20),
	  Orden1 int,
	  Orden2 int,
	  IndicadorMontoMinimo int,
	  CodigoProducto varchar(12),
	  FlagNueva int,
	  TipoTallaColor varchar(50),
	  TipoEstrategiaImagenMostrar int,
	  EtiquetaID int,
	  EtiquetaID2 int,
	  CodigoEstrategia varchar(100),
	  TieneVariedad int,
	  CODIGO varchar(100),
	  DescripcionEstrategia varchar(200),
	  FlagMostrarImg int,
	  PrecioPublico decimal(18, 2),
	  Ganancia decimal(18, 2)
	)
	INSERT INTO @OfertaEstrategiasLanzamiento
	SELECT
		EstrategiaID,
		CUV2,
		DescripcionCUV2,
		EtiquetaDescripcion,
		Precio,
		EtiquetaDescripcion2,
		Precio2,
		TextoLibre,
		FlagEstrella,
		ColorFondo,
		TipoEstrategiaID,
		FotoProducto01,
		ImagenURL,
		LimiteVenta,
		MarcaID,
		Descripcion,
		Orden Orden1,
		Orden Orden2,
		IndicadorMontoMinimo,
		CodigoProducto,
		FlagNueva,
		TipoTallaColor,
		TipoEstrategiaImagenMostrar,
		EtiquetaID,
		EtiquetaID2,
		CodigoEstrategia,
		TieneVariedad,
		CODIGO,
		DescripcionEstrategia,
		FlagMostrarImg,
		PrecioPublico,
		Ganancia
	 FROM(
	  SELECT DISTINCT
		E.EstrategiaID,
		e.CUV2,
		e.DescripcionCUV2,
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
		e.Precio,
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID2) EtiquetaDescripcion2,
		e.Precio2,
		e.TextoLibre,
		e.FlagEstrella,
		e.ColorFondo,
		e.TipoEstrategiaID,
		e.ImagenURL FotoProducto01,
		te.ImagenEstrategia ImagenURL,
		e.LimiteVenta,
		pc.MarcaID,
		M.Descripcion,
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
		op.Orden
	  FROM dbo.Estrategia E WITH (NOLOCK)
		  INNER JOIN @OfertasPersonalizadas op    ON E.CampaniaID = op.AnioCampanaVenta    AND E.CUV2 = op.CUV
		  INNER JOIN ods.ProductoComercial PC WITH (NOLOCK)    ON PC.CUV = E.CUV2    AND PC.AnoCampania = E.CampaniaID
		  INNER JOIN dbo.TipoEstrategia TE WITH (NOLOCK)    ON E.TipoEstrategiaID = TE.TipoEstrategiaID    AND TE.Codigo = @EstrategiaCodigo
		  LEFT JOIN dbo.Marca M WITH (NOLOCK)    ON M.MarcaId = PC.MarcaId
	  WHERE E.Activo = 1
		  AND TE.FlagActivo = 1
		  AND TE.flagRecoPerfil = 1
		  AND NOT EXISTS (SELECT    CUV  FROM @tablaCuvFaltante TF  WHERE E.CUV2 = TF.CUV)) op
		ORDER BY
			op.Orden ASC, EstrategiaID ASC

	DECLARE @DetalleEstrategiasLanzamiento TABLE (
	  EstrategiaID int,
	  TablaLogicaDatosId smallint,
	  Valor varchar(500)
	)
	INSERT @DetalleEstrategiasLanzamiento
	  SELECT
		ED.EstrategiaID,
		ED.TablaLogicaDatosId,
		ED.Valor
	  FROM @OfertaEstrategiasLanzamiento T
	  LEFT JOIN dbo.EstrategiaDetalle ED WITH (NOLOCK)    ON ED.EstrategiaID = T.EstrategiaID
		AND TablaLogicaDatosId BETWEEN 10201 AND 10213

	DECLARE @EstrategiasLanzamiento TABLE (
	  EstrategiaID int,
	  FlagIndividual bit,
	  Slogan varchar(1000),
	  ImgFondoDesktop varchar(1000),
	  ImgSelloProductoDesktop varchar(1000),
	  UrlVideoDesktop varchar(1000),
	  ImgFichaFondoDesktop varchar(1000),
	  ImgFondoMobile varchar(1000),
	  ImgSelloProductoMobile varchar(1000),
	  UrlVideoMobile varchar(1000),
	  ImgFichaFondoMobile varchar(1000),
	  ImgHomeDesktop varchar(1000),
	  ImgHomeMobile varchar(1000)
	)
	INSERT @EstrategiasLanzamiento
	  SELECT
		EstrategiaID,
		(SELECT CASE WHEN valor = '1' THEN 1 ELSE 0 END FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10212) AS FlagIndividual,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10213) AS Slogan,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10201) AS ImgFondoDesktop,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10203) AS ImgSelloProductoDesktop,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10204) AS UrlVideoDesktop,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10208) AS ImgFichaFondoDesktop,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10205) AS ImgFondoMobile,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10206) AS ImgSelloProductoMobile,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10207) AS UrlVideoMobile,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10209) AS ImgFichaFondoMobile,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10210) AS ImgHomeDesktop,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10211) AS ImgHomeMobile
	  FROM @OfertaEstrategiasLanzamiento AS T
	SELECT
	  T.EstrategiaID,
	  T.CUV2,
	  T.DescripcionCUV2,
	  T.EtiquetaDescripcion,
	  T.Precio,
	  T.EtiquetaDescripcion2,
	  T.Precio2,
	  ISNULL(T.TextoLibre, '') AS TextoLibre,
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
	  T.CodigoProducto,
	  T.EtiquetaID,
	  T.EtiquetaID2,
	  T.CodigoEstrategia,
	  T.TieneVariedad,
	  T.CODIGO,
	  T.DescripcionEstrategia,
	  T.FlagMostrarImg,
	  T.DescripcionMarca,
	  'NO DISPONIBLE' AS DescripcionCategoria,
	  D.FlagIndividual,
	  D.Slogan,
	  D.ImgFondoDesktop,
	  D.ImgSelloProductoDesktop AS ImgFichaDesktop,
	  D.UrlVideoDesktop,
	  D.ImgFichaFondoDesktop,
	  D.ImgFondoMobile,
	  D.ImgSelloProductoMobile AS ImgFichaMobile,
	  D.UrlVideoMobile,
	  D.ImgFichaFondoMobile,
	  D.ImgHomeDesktop,
	  D.ImgHomeMobile,
	  T.PrecioPublico,
	  T.Ganancia
	FROM @OfertaEstrategiasLanzamiento T
	LEFT JOIN @EstrategiasLanzamiento D  ON D.EstrategiaID = T.EstrategiaID
	ORDER BY Orden1 ASC, CASE
	  WHEN ISNULL(T.Orden2, 0) = 0 THEN T.Orden1
	  ELSE T.Orden2
	END ASC, EstrategiaID ASC

SET NOCOUNT OFF
END
GO

GO
USE BelcorpPuertoRico
GO

GO
-- exec dbo.ListarEstrategiasLanzamiento 201807, '000685941'
ALTER PROCEDURE [dbo].[ListarEstrategiasLanzamiento]
@CampaniaID INT,
@CodigoConsultora VARCHAR(30)
AS
BEGIN
SET NOCOUNT ON
DECLARE @StrCampaniaID char(6) = CONVERT(char(6), @CampaniaID)
DECLARE @EstrategiaCodigo varchar(100) = '005'

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
		FROM ods.OfertasPersonalizadas WITH (NOLOCK)
		WHERE CodConsultora = @CodigoConsultora
			AND AnioCampanaVenta = @StrCampaniaID
			AND TipoPersonalizacion = 'LAN'

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
				AND op.TipoPersonalizacion = 'LAN'
		END
	END
	IF(@codConsultoraDefault<>@CodigoConsultora)
	INSERT INTO @OfertasPersonalizadas(Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta)
		SELECT Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta
		FROM dbo.ListarEstrategiasForzadas(@CampaniaID, @EstrategiaCodigo)

	DECLARE @OfertaEstrategiasLanzamiento TABLE (
	  EstrategiaID int,
	  CUV2 varchar(5),
	  DescripcionCUV2 varchar(800),
	  EtiquetaDescripcion varchar(8000),
	  Precio numeric(12, 2),
	  EtiquetaDescripcion2 varchar(8000),
	  Precio2 numeric(12, 2),
	  TextoLibre varchar(800),
	  FlagEstrella bit,
	  ColorFondo varchar(20),
	  TipoEstrategiaID int,
	  FotoProducto01 varchar(800),
	  ImagenURL varchar(500),
	  LimiteVenta int,
	  MarcaID int,
	  DescripcionMarca VARCHAR(20),
	  Orden1 int,
	  Orden2 int,
	  IndicadorMontoMinimo int,
	  CodigoProducto varchar(12),
	  FlagNueva int,
	  TipoTallaColor varchar(50),
	  TipoEstrategiaImagenMostrar int,
	  EtiquetaID int,
	  EtiquetaID2 int,
	  CodigoEstrategia varchar(100),
	  TieneVariedad int,
	  CODIGO varchar(100),
	  DescripcionEstrategia varchar(200),
	  FlagMostrarImg int,
	  PrecioPublico decimal(18, 2),
	  Ganancia decimal(18, 2)
	)
	INSERT INTO @OfertaEstrategiasLanzamiento
	SELECT
		EstrategiaID,
		CUV2,
		DescripcionCUV2,
		EtiquetaDescripcion,
		Precio,
		EtiquetaDescripcion2,
		Precio2,
		TextoLibre,
		FlagEstrella,
		ColorFondo,
		TipoEstrategiaID,
		FotoProducto01,
		ImagenURL,
		LimiteVenta,
		MarcaID,
		Descripcion,
		Orden Orden1,
		Orden Orden2,
		IndicadorMontoMinimo,
		CodigoProducto,
		FlagNueva,
		TipoTallaColor,
		TipoEstrategiaImagenMostrar,
		EtiquetaID,
		EtiquetaID2,
		CodigoEstrategia,
		TieneVariedad,
		CODIGO,
		DescripcionEstrategia,
		FlagMostrarImg,
		PrecioPublico,
		Ganancia
	 FROM(
	  SELECT DISTINCT
		E.EstrategiaID,
		e.CUV2,
		e.DescripcionCUV2,
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
		e.Precio,
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID2) EtiquetaDescripcion2,
		e.Precio2,
		e.TextoLibre,
		e.FlagEstrella,
		e.ColorFondo,
		e.TipoEstrategiaID,
		e.ImagenURL FotoProducto01,
		te.ImagenEstrategia ImagenURL,
		e.LimiteVenta,
		pc.MarcaID,
		M.Descripcion,
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
		op.Orden
	  FROM dbo.Estrategia E WITH (NOLOCK)
		  INNER JOIN @OfertasPersonalizadas op    ON E.CampaniaID = op.AnioCampanaVenta    AND E.CUV2 = op.CUV
		  INNER JOIN ods.ProductoComercial PC WITH (NOLOCK)    ON PC.CUV = E.CUV2    AND PC.AnoCampania = E.CampaniaID
		  INNER JOIN dbo.TipoEstrategia TE WITH (NOLOCK)    ON E.TipoEstrategiaID = TE.TipoEstrategiaID    AND TE.Codigo = @EstrategiaCodigo
		  LEFT JOIN dbo.Marca M WITH (NOLOCK)    ON M.MarcaId = PC.MarcaId
	  WHERE E.Activo = 1
		  AND TE.FlagActivo = 1
		  AND TE.flagRecoPerfil = 1
		  AND NOT EXISTS (SELECT    CUV  FROM @tablaCuvFaltante TF  WHERE E.CUV2 = TF.CUV)) op
		ORDER BY
			op.Orden ASC, EstrategiaID ASC

	DECLARE @DetalleEstrategiasLanzamiento TABLE (
	  EstrategiaID int,
	  TablaLogicaDatosId smallint,
	  Valor varchar(500)
	)
	INSERT @DetalleEstrategiasLanzamiento
	  SELECT
		ED.EstrategiaID,
		ED.TablaLogicaDatosId,
		ED.Valor
	  FROM @OfertaEstrategiasLanzamiento T
	  LEFT JOIN dbo.EstrategiaDetalle ED WITH (NOLOCK)    ON ED.EstrategiaID = T.EstrategiaID
		AND TablaLogicaDatosId BETWEEN 10201 AND 10213

	DECLARE @EstrategiasLanzamiento TABLE (
	  EstrategiaID int,
	  FlagIndividual bit,
	  Slogan varchar(1000),
	  ImgFondoDesktop varchar(1000),
	  ImgSelloProductoDesktop varchar(1000),
	  UrlVideoDesktop varchar(1000),
	  ImgFichaFondoDesktop varchar(1000),
	  ImgFondoMobile varchar(1000),
	  ImgSelloProductoMobile varchar(1000),
	  UrlVideoMobile varchar(1000),
	  ImgFichaFondoMobile varchar(1000),
	  ImgHomeDesktop varchar(1000),
	  ImgHomeMobile varchar(1000)
	)
	INSERT @EstrategiasLanzamiento
	  SELECT
		EstrategiaID,
		(SELECT CASE WHEN valor = '1' THEN 1 ELSE 0 END FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10212) AS FlagIndividual,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10213) AS Slogan,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10201) AS ImgFondoDesktop,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10203) AS ImgSelloProductoDesktop,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10204) AS UrlVideoDesktop,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10208) AS ImgFichaFondoDesktop,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10205) AS ImgFondoMobile,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10206) AS ImgSelloProductoMobile,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10207) AS UrlVideoMobile,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10209) AS ImgFichaFondoMobile,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10210) AS ImgHomeDesktop,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10211) AS ImgHomeMobile
	  FROM @OfertaEstrategiasLanzamiento AS T
	SELECT
	  T.EstrategiaID,
	  T.CUV2,
	  T.DescripcionCUV2,
	  T.EtiquetaDescripcion,
	  T.Precio,
	  T.EtiquetaDescripcion2,
	  T.Precio2,
	  ISNULL(T.TextoLibre, '') AS TextoLibre,
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
	  T.CodigoProducto,
	  T.EtiquetaID,
	  T.EtiquetaID2,
	  T.CodigoEstrategia,
	  T.TieneVariedad,
	  T.CODIGO,
	  T.DescripcionEstrategia,
	  T.FlagMostrarImg,
	  T.DescripcionMarca,
	  'NO DISPONIBLE' AS DescripcionCategoria,
	  D.FlagIndividual,
	  D.Slogan,
	  D.ImgFondoDesktop,
	  D.ImgSelloProductoDesktop AS ImgFichaDesktop,
	  D.UrlVideoDesktop,
	  D.ImgFichaFondoDesktop,
	  D.ImgFondoMobile,
	  D.ImgSelloProductoMobile AS ImgFichaMobile,
	  D.UrlVideoMobile,
	  D.ImgFichaFondoMobile,
	  D.ImgHomeDesktop,
	  D.ImgHomeMobile,
	  T.PrecioPublico,
	  T.Ganancia
	FROM @OfertaEstrategiasLanzamiento T
	LEFT JOIN @EstrategiasLanzamiento D  ON D.EstrategiaID = T.EstrategiaID
	ORDER BY Orden1 ASC, CASE
	  WHEN ISNULL(T.Orden2, 0) = 0 THEN T.Orden1
	  ELSE T.Orden2
	END ASC, EstrategiaID ASC

SET NOCOUNT OFF
END
GO

GO
USE BelcorpPanama
GO

GO
-- exec dbo.ListarEstrategiasLanzamiento 201807, '000685941'
ALTER PROCEDURE [dbo].[ListarEstrategiasLanzamiento]
@CampaniaID INT,
@CodigoConsultora VARCHAR(30)
AS
BEGIN
SET NOCOUNT ON
DECLARE @StrCampaniaID char(6) = CONVERT(char(6), @CampaniaID)
DECLARE @EstrategiaCodigo varchar(100) = '005'

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
		FROM ods.OfertasPersonalizadas WITH (NOLOCK)
		WHERE CodConsultora = @CodigoConsultora
			AND AnioCampanaVenta = @StrCampaniaID
			AND TipoPersonalizacion = 'LAN'

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
				AND op.TipoPersonalizacion = 'LAN'
		END
	END
	IF(@codConsultoraDefault<>@CodigoConsultora)
	INSERT INTO @OfertasPersonalizadas(Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta)
		SELECT Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta
		FROM dbo.ListarEstrategiasForzadas(@CampaniaID, @EstrategiaCodigo)

	DECLARE @OfertaEstrategiasLanzamiento TABLE (
	  EstrategiaID int,
	  CUV2 varchar(5),
	  DescripcionCUV2 varchar(800),
	  EtiquetaDescripcion varchar(8000),
	  Precio numeric(12, 2),
	  EtiquetaDescripcion2 varchar(8000),
	  Precio2 numeric(12, 2),
	  TextoLibre varchar(800),
	  FlagEstrella bit,
	  ColorFondo varchar(20),
	  TipoEstrategiaID int,
	  FotoProducto01 varchar(800),
	  ImagenURL varchar(500),
	  LimiteVenta int,
	  MarcaID int,
	  DescripcionMarca VARCHAR(20),
	  Orden1 int,
	  Orden2 int,
	  IndicadorMontoMinimo int,
	  CodigoProducto varchar(12),
	  FlagNueva int,
	  TipoTallaColor varchar(50),
	  TipoEstrategiaImagenMostrar int,
	  EtiquetaID int,
	  EtiquetaID2 int,
	  CodigoEstrategia varchar(100),
	  TieneVariedad int,
	  CODIGO varchar(100),
	  DescripcionEstrategia varchar(200),
	  FlagMostrarImg int,
	  PrecioPublico decimal(18, 2),
	  Ganancia decimal(18, 2)
	)
	INSERT INTO @OfertaEstrategiasLanzamiento
	SELECT
		EstrategiaID,
		CUV2,
		DescripcionCUV2,
		EtiquetaDescripcion,
		Precio,
		EtiquetaDescripcion2,
		Precio2,
		TextoLibre,
		FlagEstrella,
		ColorFondo,
		TipoEstrategiaID,
		FotoProducto01,
		ImagenURL,
		LimiteVenta,
		MarcaID,
		Descripcion,
		Orden Orden1,
		Orden Orden2,
		IndicadorMontoMinimo,
		CodigoProducto,
		FlagNueva,
		TipoTallaColor,
		TipoEstrategiaImagenMostrar,
		EtiquetaID,
		EtiquetaID2,
		CodigoEstrategia,
		TieneVariedad,
		CODIGO,
		DescripcionEstrategia,
		FlagMostrarImg,
		PrecioPublico,
		Ganancia
	 FROM(
	  SELECT DISTINCT
		E.EstrategiaID,
		e.CUV2,
		e.DescripcionCUV2,
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
		e.Precio,
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID2) EtiquetaDescripcion2,
		e.Precio2,
		e.TextoLibre,
		e.FlagEstrella,
		e.ColorFondo,
		e.TipoEstrategiaID,
		e.ImagenURL FotoProducto01,
		te.ImagenEstrategia ImagenURL,
		e.LimiteVenta,
		pc.MarcaID,
		M.Descripcion,
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
		op.Orden
	  FROM dbo.Estrategia E WITH (NOLOCK)
		  INNER JOIN @OfertasPersonalizadas op    ON E.CampaniaID = op.AnioCampanaVenta    AND E.CUV2 = op.CUV
		  INNER JOIN ods.ProductoComercial PC WITH (NOLOCK)    ON PC.CUV = E.CUV2    AND PC.AnoCampania = E.CampaniaID
		  INNER JOIN dbo.TipoEstrategia TE WITH (NOLOCK)    ON E.TipoEstrategiaID = TE.TipoEstrategiaID    AND TE.Codigo = @EstrategiaCodigo
		  LEFT JOIN dbo.Marca M WITH (NOLOCK)    ON M.MarcaId = PC.MarcaId
	  WHERE E.Activo = 1
		  AND TE.FlagActivo = 1
		  AND TE.flagRecoPerfil = 1
		  AND NOT EXISTS (SELECT    CUV  FROM @tablaCuvFaltante TF  WHERE E.CUV2 = TF.CUV)) op
		ORDER BY
			op.Orden ASC, EstrategiaID ASC

	DECLARE @DetalleEstrategiasLanzamiento TABLE (
	  EstrategiaID int,
	  TablaLogicaDatosId smallint,
	  Valor varchar(500)
	)
	INSERT @DetalleEstrategiasLanzamiento
	  SELECT
		ED.EstrategiaID,
		ED.TablaLogicaDatosId,
		ED.Valor
	  FROM @OfertaEstrategiasLanzamiento T
	  LEFT JOIN dbo.EstrategiaDetalle ED WITH (NOLOCK)    ON ED.EstrategiaID = T.EstrategiaID
		AND TablaLogicaDatosId BETWEEN 10201 AND 10213

	DECLARE @EstrategiasLanzamiento TABLE (
	  EstrategiaID int,
	  FlagIndividual bit,
	  Slogan varchar(1000),
	  ImgFondoDesktop varchar(1000),
	  ImgSelloProductoDesktop varchar(1000),
	  UrlVideoDesktop varchar(1000),
	  ImgFichaFondoDesktop varchar(1000),
	  ImgFondoMobile varchar(1000),
	  ImgSelloProductoMobile varchar(1000),
	  UrlVideoMobile varchar(1000),
	  ImgFichaFondoMobile varchar(1000),
	  ImgHomeDesktop varchar(1000),
	  ImgHomeMobile varchar(1000)
	)
	INSERT @EstrategiasLanzamiento
	  SELECT
		EstrategiaID,
		(SELECT CASE WHEN valor = '1' THEN 1 ELSE 0 END FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10212) AS FlagIndividual,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10213) AS Slogan,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10201) AS ImgFondoDesktop,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10203) AS ImgSelloProductoDesktop,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10204) AS UrlVideoDesktop,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10208) AS ImgFichaFondoDesktop,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10205) AS ImgFondoMobile,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10206) AS ImgSelloProductoMobile,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10207) AS UrlVideoMobile,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10209) AS ImgFichaFondoMobile,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10210) AS ImgHomeDesktop,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10211) AS ImgHomeMobile
	  FROM @OfertaEstrategiasLanzamiento AS T
	SELECT
	  T.EstrategiaID,
	  T.CUV2,
	  T.DescripcionCUV2,
	  T.EtiquetaDescripcion,
	  T.Precio,
	  T.EtiquetaDescripcion2,
	  T.Precio2,
	  ISNULL(T.TextoLibre, '') AS TextoLibre,
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
	  T.CodigoProducto,
	  T.EtiquetaID,
	  T.EtiquetaID2,
	  T.CodigoEstrategia,
	  T.TieneVariedad,
	  T.CODIGO,
	  T.DescripcionEstrategia,
	  T.FlagMostrarImg,
	  T.DescripcionMarca,
	  'NO DISPONIBLE' AS DescripcionCategoria,
	  D.FlagIndividual,
	  D.Slogan,
	  D.ImgFondoDesktop,
	  D.ImgSelloProductoDesktop AS ImgFichaDesktop,
	  D.UrlVideoDesktop,
	  D.ImgFichaFondoDesktop,
	  D.ImgFondoMobile,
	  D.ImgSelloProductoMobile AS ImgFichaMobile,
	  D.UrlVideoMobile,
	  D.ImgFichaFondoMobile,
	  D.ImgHomeDesktop,
	  D.ImgHomeMobile,
	  T.PrecioPublico,
	  T.Ganancia
	FROM @OfertaEstrategiasLanzamiento T
	LEFT JOIN @EstrategiasLanzamiento D  ON D.EstrategiaID = T.EstrategiaID
	ORDER BY Orden1 ASC, CASE
	  WHEN ISNULL(T.Orden2, 0) = 0 THEN T.Orden1
	  ELSE T.Orden2
	END ASC, EstrategiaID ASC

SET NOCOUNT OFF
END
GO

GO
USE BelcorpGuatemala
GO

GO
-- exec dbo.ListarEstrategiasLanzamiento 201807, '000685941'
ALTER PROCEDURE [dbo].[ListarEstrategiasLanzamiento]
@CampaniaID INT,
@CodigoConsultora VARCHAR(30)
AS
BEGIN
SET NOCOUNT ON
DECLARE @StrCampaniaID char(6) = CONVERT(char(6), @CampaniaID)
DECLARE @EstrategiaCodigo varchar(100) = '005'

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
		FROM ods.OfertasPersonalizadas WITH (NOLOCK)
		WHERE CodConsultora = @CodigoConsultora
			AND AnioCampanaVenta = @StrCampaniaID
			AND TipoPersonalizacion = 'LAN'

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
				AND op.TipoPersonalizacion = 'LAN'
		END
	END
	IF(@codConsultoraDefault<>@CodigoConsultora)
	INSERT INTO @OfertasPersonalizadas(Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta)
		SELECT Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta
		FROM dbo.ListarEstrategiasForzadas(@CampaniaID, @EstrategiaCodigo)

	DECLARE @OfertaEstrategiasLanzamiento TABLE (
	  EstrategiaID int,
	  CUV2 varchar(5),
	  DescripcionCUV2 varchar(800),
	  EtiquetaDescripcion varchar(8000),
	  Precio numeric(12, 2),
	  EtiquetaDescripcion2 varchar(8000),
	  Precio2 numeric(12, 2),
	  TextoLibre varchar(800),
	  FlagEstrella bit,
	  ColorFondo varchar(20),
	  TipoEstrategiaID int,
	  FotoProducto01 varchar(800),
	  ImagenURL varchar(500),
	  LimiteVenta int,
	  MarcaID int,
	  DescripcionMarca VARCHAR(20),
	  Orden1 int,
	  Orden2 int,
	  IndicadorMontoMinimo int,
	  CodigoProducto varchar(12),
	  FlagNueva int,
	  TipoTallaColor varchar(50),
	  TipoEstrategiaImagenMostrar int,
	  EtiquetaID int,
	  EtiquetaID2 int,
	  CodigoEstrategia varchar(100),
	  TieneVariedad int,
	  CODIGO varchar(100),
	  DescripcionEstrategia varchar(200),
	  FlagMostrarImg int,
	  PrecioPublico decimal(18, 2),
	  Ganancia decimal(18, 2)
	)
	INSERT INTO @OfertaEstrategiasLanzamiento
	SELECT
		EstrategiaID,
		CUV2,
		DescripcionCUV2,
		EtiquetaDescripcion,
		Precio,
		EtiquetaDescripcion2,
		Precio2,
		TextoLibre,
		FlagEstrella,
		ColorFondo,
		TipoEstrategiaID,
		FotoProducto01,
		ImagenURL,
		LimiteVenta,
		MarcaID,
		Descripcion,
		Orden Orden1,
		Orden Orden2,
		IndicadorMontoMinimo,
		CodigoProducto,
		FlagNueva,
		TipoTallaColor,
		TipoEstrategiaImagenMostrar,
		EtiquetaID,
		EtiquetaID2,
		CodigoEstrategia,
		TieneVariedad,
		CODIGO,
		DescripcionEstrategia,
		FlagMostrarImg,
		PrecioPublico,
		Ganancia
	 FROM(
	  SELECT DISTINCT
		E.EstrategiaID,
		e.CUV2,
		e.DescripcionCUV2,
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
		e.Precio,
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID2) EtiquetaDescripcion2,
		e.Precio2,
		e.TextoLibre,
		e.FlagEstrella,
		e.ColorFondo,
		e.TipoEstrategiaID,
		e.ImagenURL FotoProducto01,
		te.ImagenEstrategia ImagenURL,
		e.LimiteVenta,
		pc.MarcaID,
		M.Descripcion,
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
		op.Orden
	  FROM dbo.Estrategia E WITH (NOLOCK)
		  INNER JOIN @OfertasPersonalizadas op    ON E.CampaniaID = op.AnioCampanaVenta    AND E.CUV2 = op.CUV
		  INNER JOIN ods.ProductoComercial PC WITH (NOLOCK)    ON PC.CUV = E.CUV2    AND PC.AnoCampania = E.CampaniaID
		  INNER JOIN dbo.TipoEstrategia TE WITH (NOLOCK)    ON E.TipoEstrategiaID = TE.TipoEstrategiaID    AND TE.Codigo = @EstrategiaCodigo
		  LEFT JOIN dbo.Marca M WITH (NOLOCK)    ON M.MarcaId = PC.MarcaId
	  WHERE E.Activo = 1
		  AND TE.FlagActivo = 1
		  AND TE.flagRecoPerfil = 1
		  AND NOT EXISTS (SELECT    CUV  FROM @tablaCuvFaltante TF  WHERE E.CUV2 = TF.CUV)) op
		ORDER BY
			op.Orden ASC, EstrategiaID ASC

	DECLARE @DetalleEstrategiasLanzamiento TABLE (
	  EstrategiaID int,
	  TablaLogicaDatosId smallint,
	  Valor varchar(500)
	)
	INSERT @DetalleEstrategiasLanzamiento
	  SELECT
		ED.EstrategiaID,
		ED.TablaLogicaDatosId,
		ED.Valor
	  FROM @OfertaEstrategiasLanzamiento T
	  LEFT JOIN dbo.EstrategiaDetalle ED WITH (NOLOCK)    ON ED.EstrategiaID = T.EstrategiaID
		AND TablaLogicaDatosId BETWEEN 10201 AND 10213

	DECLARE @EstrategiasLanzamiento TABLE (
	  EstrategiaID int,
	  FlagIndividual bit,
	  Slogan varchar(1000),
	  ImgFondoDesktop varchar(1000),
	  ImgSelloProductoDesktop varchar(1000),
	  UrlVideoDesktop varchar(1000),
	  ImgFichaFondoDesktop varchar(1000),
	  ImgFondoMobile varchar(1000),
	  ImgSelloProductoMobile varchar(1000),
	  UrlVideoMobile varchar(1000),
	  ImgFichaFondoMobile varchar(1000),
	  ImgHomeDesktop varchar(1000),
	  ImgHomeMobile varchar(1000)
	)
	INSERT @EstrategiasLanzamiento
	  SELECT
		EstrategiaID,
		(SELECT CASE WHEN valor = '1' THEN 1 ELSE 0 END FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10212) AS FlagIndividual,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10213) AS Slogan,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10201) AS ImgFondoDesktop,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10203) AS ImgSelloProductoDesktop,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10204) AS UrlVideoDesktop,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10208) AS ImgFichaFondoDesktop,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10205) AS ImgFondoMobile,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10206) AS ImgSelloProductoMobile,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10207) AS UrlVideoMobile,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10209) AS ImgFichaFondoMobile,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10210) AS ImgHomeDesktop,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10211) AS ImgHomeMobile
	  FROM @OfertaEstrategiasLanzamiento AS T
	SELECT
	  T.EstrategiaID,
	  T.CUV2,
	  T.DescripcionCUV2,
	  T.EtiquetaDescripcion,
	  T.Precio,
	  T.EtiquetaDescripcion2,
	  T.Precio2,
	  ISNULL(T.TextoLibre, '') AS TextoLibre,
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
	  T.CodigoProducto,
	  T.EtiquetaID,
	  T.EtiquetaID2,
	  T.CodigoEstrategia,
	  T.TieneVariedad,
	  T.CODIGO,
	  T.DescripcionEstrategia,
	  T.FlagMostrarImg,
	  T.DescripcionMarca,
	  'NO DISPONIBLE' AS DescripcionCategoria,
	  D.FlagIndividual,
	  D.Slogan,
	  D.ImgFondoDesktop,
	  D.ImgSelloProductoDesktop AS ImgFichaDesktop,
	  D.UrlVideoDesktop,
	  D.ImgFichaFondoDesktop,
	  D.ImgFondoMobile,
	  D.ImgSelloProductoMobile AS ImgFichaMobile,
	  D.UrlVideoMobile,
	  D.ImgFichaFondoMobile,
	  D.ImgHomeDesktop,
	  D.ImgHomeMobile,
	  T.PrecioPublico,
	  T.Ganancia
	FROM @OfertaEstrategiasLanzamiento T
	LEFT JOIN @EstrategiasLanzamiento D  ON D.EstrategiaID = T.EstrategiaID
	ORDER BY Orden1 ASC, CASE
	  WHEN ISNULL(T.Orden2, 0) = 0 THEN T.Orden1
	  ELSE T.Orden2
	END ASC, EstrategiaID ASC

SET NOCOUNT OFF
END
GO

GO
USE BelcorpEcuador
GO

GO
-- exec dbo.ListarEstrategiasLanzamiento 201807, '000685941'
ALTER PROCEDURE [dbo].[ListarEstrategiasLanzamiento]
@CampaniaID INT,
@CodigoConsultora VARCHAR(30)
AS
BEGIN
SET NOCOUNT ON
DECLARE @StrCampaniaID char(6) = CONVERT(char(6), @CampaniaID)
DECLARE @EstrategiaCodigo varchar(100) = '005'

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
		FROM ods.OfertasPersonalizadas WITH (NOLOCK)
		WHERE CodConsultora = @CodigoConsultora
			AND AnioCampanaVenta = @StrCampaniaID
			AND TipoPersonalizacion = 'LAN'

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
				AND op.TipoPersonalizacion = 'LAN'
		END
	END
	IF(@codConsultoraDefault<>@CodigoConsultora)
	INSERT INTO @OfertasPersonalizadas(Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta)
		SELECT Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta
		FROM dbo.ListarEstrategiasForzadas(@CampaniaID, @EstrategiaCodigo)

	DECLARE @OfertaEstrategiasLanzamiento TABLE (
	  EstrategiaID int,
	  CUV2 varchar(5),
	  DescripcionCUV2 varchar(800),
	  EtiquetaDescripcion varchar(8000),
	  Precio numeric(12, 2),
	  EtiquetaDescripcion2 varchar(8000),
	  Precio2 numeric(12, 2),
	  TextoLibre varchar(800),
	  FlagEstrella bit,
	  ColorFondo varchar(20),
	  TipoEstrategiaID int,
	  FotoProducto01 varchar(800),
	  ImagenURL varchar(500),
	  LimiteVenta int,
	  MarcaID int,
	  DescripcionMarca VARCHAR(20),
	  Orden1 int,
	  Orden2 int,
	  IndicadorMontoMinimo int,
	  CodigoProducto varchar(12),
	  FlagNueva int,
	  TipoTallaColor varchar(50),
	  TipoEstrategiaImagenMostrar int,
	  EtiquetaID int,
	  EtiquetaID2 int,
	  CodigoEstrategia varchar(100),
	  TieneVariedad int,
	  CODIGO varchar(100),
	  DescripcionEstrategia varchar(200),
	  FlagMostrarImg int,
	  PrecioPublico decimal(18, 2),
	  Ganancia decimal(18, 2)
	)
	INSERT INTO @OfertaEstrategiasLanzamiento
	SELECT
		EstrategiaID,
		CUV2,
		DescripcionCUV2,
		EtiquetaDescripcion,
		Precio,
		EtiquetaDescripcion2,
		Precio2,
		TextoLibre,
		FlagEstrella,
		ColorFondo,
		TipoEstrategiaID,
		FotoProducto01,
		ImagenURL,
		LimiteVenta,
		MarcaID,
		Descripcion,
		Orden Orden1,
		Orden Orden2,
		IndicadorMontoMinimo,
		CodigoProducto,
		FlagNueva,
		TipoTallaColor,
		TipoEstrategiaImagenMostrar,
		EtiquetaID,
		EtiquetaID2,
		CodigoEstrategia,
		TieneVariedad,
		CODIGO,
		DescripcionEstrategia,
		FlagMostrarImg,
		PrecioPublico,
		Ganancia
	 FROM(
	  SELECT DISTINCT
		E.EstrategiaID,
		e.CUV2,
		e.DescripcionCUV2,
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
		e.Precio,
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID2) EtiquetaDescripcion2,
		e.Precio2,
		e.TextoLibre,
		e.FlagEstrella,
		e.ColorFondo,
		e.TipoEstrategiaID,
		e.ImagenURL FotoProducto01,
		te.ImagenEstrategia ImagenURL,
		e.LimiteVenta,
		pc.MarcaID,
		M.Descripcion,
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
		op.Orden
	  FROM dbo.Estrategia E WITH (NOLOCK)
		  INNER JOIN @OfertasPersonalizadas op    ON E.CampaniaID = op.AnioCampanaVenta    AND E.CUV2 = op.CUV
		  INNER JOIN ods.ProductoComercial PC WITH (NOLOCK)    ON PC.CUV = E.CUV2    AND PC.AnoCampania = E.CampaniaID
		  INNER JOIN dbo.TipoEstrategia TE WITH (NOLOCK)    ON E.TipoEstrategiaID = TE.TipoEstrategiaID    AND TE.Codigo = @EstrategiaCodigo
		  LEFT JOIN dbo.Marca M WITH (NOLOCK)    ON M.MarcaId = PC.MarcaId
	  WHERE E.Activo = 1
		  AND TE.FlagActivo = 1
		  AND TE.flagRecoPerfil = 1
		  AND NOT EXISTS (SELECT    CUV  FROM @tablaCuvFaltante TF  WHERE E.CUV2 = TF.CUV)) op
		ORDER BY
			op.Orden ASC, EstrategiaID ASC

	DECLARE @DetalleEstrategiasLanzamiento TABLE (
	  EstrategiaID int,
	  TablaLogicaDatosId smallint,
	  Valor varchar(500)
	)
	INSERT @DetalleEstrategiasLanzamiento
	  SELECT
		ED.EstrategiaID,
		ED.TablaLogicaDatosId,
		ED.Valor
	  FROM @OfertaEstrategiasLanzamiento T
	  LEFT JOIN dbo.EstrategiaDetalle ED WITH (NOLOCK)    ON ED.EstrategiaID = T.EstrategiaID
		AND TablaLogicaDatosId BETWEEN 10201 AND 10213

	DECLARE @EstrategiasLanzamiento TABLE (
	  EstrategiaID int,
	  FlagIndividual bit,
	  Slogan varchar(1000),
	  ImgFondoDesktop varchar(1000),
	  ImgSelloProductoDesktop varchar(1000),
	  UrlVideoDesktop varchar(1000),
	  ImgFichaFondoDesktop varchar(1000),
	  ImgFondoMobile varchar(1000),
	  ImgSelloProductoMobile varchar(1000),
	  UrlVideoMobile varchar(1000),
	  ImgFichaFondoMobile varchar(1000),
	  ImgHomeDesktop varchar(1000),
	  ImgHomeMobile varchar(1000)
	)
	INSERT @EstrategiasLanzamiento
	  SELECT
		EstrategiaID,
		(SELECT CASE WHEN valor = '1' THEN 1 ELSE 0 END FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10212) AS FlagIndividual,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10213) AS Slogan,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10201) AS ImgFondoDesktop,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10203) AS ImgSelloProductoDesktop,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10204) AS UrlVideoDesktop,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10208) AS ImgFichaFondoDesktop,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10205) AS ImgFondoMobile,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10206) AS ImgSelloProductoMobile,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10207) AS UrlVideoMobile,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10209) AS ImgFichaFondoMobile,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10210) AS ImgHomeDesktop,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10211) AS ImgHomeMobile
	  FROM @OfertaEstrategiasLanzamiento AS T
	SELECT
	  T.EstrategiaID,
	  T.CUV2,
	  T.DescripcionCUV2,
	  T.EtiquetaDescripcion,
	  T.Precio,
	  T.EtiquetaDescripcion2,
	  T.Precio2,
	  ISNULL(T.TextoLibre, '') AS TextoLibre,
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
	  T.CodigoProducto,
	  T.EtiquetaID,
	  T.EtiquetaID2,
	  T.CodigoEstrategia,
	  T.TieneVariedad,
	  T.CODIGO,
	  T.DescripcionEstrategia,
	  T.FlagMostrarImg,
	  T.DescripcionMarca,
	  'NO DISPONIBLE' AS DescripcionCategoria,
	  D.FlagIndividual,
	  D.Slogan,
	  D.ImgFondoDesktop,
	  D.ImgSelloProductoDesktop AS ImgFichaDesktop,
	  D.UrlVideoDesktop,
	  D.ImgFichaFondoDesktop,
	  D.ImgFondoMobile,
	  D.ImgSelloProductoMobile AS ImgFichaMobile,
	  D.UrlVideoMobile,
	  D.ImgFichaFondoMobile,
	  D.ImgHomeDesktop,
	  D.ImgHomeMobile,
	  T.PrecioPublico,
	  T.Ganancia
	FROM @OfertaEstrategiasLanzamiento T
	LEFT JOIN @EstrategiasLanzamiento D  ON D.EstrategiaID = T.EstrategiaID
	ORDER BY Orden1 ASC, CASE
	  WHEN ISNULL(T.Orden2, 0) = 0 THEN T.Orden1
	  ELSE T.Orden2
	END ASC, EstrategiaID ASC

SET NOCOUNT OFF
END
GO

GO
USE BelcorpDominicana
GO

GO
-- exec dbo.ListarEstrategiasLanzamiento 201807, '000685941'
ALTER PROCEDURE [dbo].[ListarEstrategiasLanzamiento]
@CampaniaID INT,
@CodigoConsultora VARCHAR(30)
AS
BEGIN
SET NOCOUNT ON
DECLARE @StrCampaniaID char(6) = CONVERT(char(6), @CampaniaID)
DECLARE @EstrategiaCodigo varchar(100) = '005'

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
		FROM ods.OfertasPersonalizadas WITH (NOLOCK)
		WHERE CodConsultora = @CodigoConsultora
			AND AnioCampanaVenta = @StrCampaniaID
			AND TipoPersonalizacion = 'LAN'

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
				AND op.TipoPersonalizacion = 'LAN'
		END
	END
	IF(@codConsultoraDefault<>@CodigoConsultora)
	INSERT INTO @OfertasPersonalizadas(Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta)
		SELECT Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta
		FROM dbo.ListarEstrategiasForzadas(@CampaniaID, @EstrategiaCodigo)

	DECLARE @OfertaEstrategiasLanzamiento TABLE (
	  EstrategiaID int,
	  CUV2 varchar(5),
	  DescripcionCUV2 varchar(800),
	  EtiquetaDescripcion varchar(8000),
	  Precio numeric(12, 2),
	  EtiquetaDescripcion2 varchar(8000),
	  Precio2 numeric(12, 2),
	  TextoLibre varchar(800),
	  FlagEstrella bit,
	  ColorFondo varchar(20),
	  TipoEstrategiaID int,
	  FotoProducto01 varchar(800),
	  ImagenURL varchar(500),
	  LimiteVenta int,
	  MarcaID int,
	  DescripcionMarca VARCHAR(20),
	  Orden1 int,
	  Orden2 int,
	  IndicadorMontoMinimo int,
	  CodigoProducto varchar(12),
	  FlagNueva int,
	  TipoTallaColor varchar(50),
	  TipoEstrategiaImagenMostrar int,
	  EtiquetaID int,
	  EtiquetaID2 int,
	  CodigoEstrategia varchar(100),
	  TieneVariedad int,
	  CODIGO varchar(100),
	  DescripcionEstrategia varchar(200),
	  FlagMostrarImg int,
	  PrecioPublico decimal(18, 2),
	  Ganancia decimal(18, 2)
	)
	INSERT INTO @OfertaEstrategiasLanzamiento
	SELECT
		EstrategiaID,
		CUV2,
		DescripcionCUV2,
		EtiquetaDescripcion,
		Precio,
		EtiquetaDescripcion2,
		Precio2,
		TextoLibre,
		FlagEstrella,
		ColorFondo,
		TipoEstrategiaID,
		FotoProducto01,
		ImagenURL,
		LimiteVenta,
		MarcaID,
		Descripcion,
		Orden Orden1,
		Orden Orden2,
		IndicadorMontoMinimo,
		CodigoProducto,
		FlagNueva,
		TipoTallaColor,
		TipoEstrategiaImagenMostrar,
		EtiquetaID,
		EtiquetaID2,
		CodigoEstrategia,
		TieneVariedad,
		CODIGO,
		DescripcionEstrategia,
		FlagMostrarImg,
		PrecioPublico,
		Ganancia
	 FROM(
	  SELECT DISTINCT
		E.EstrategiaID,
		e.CUV2,
		e.DescripcionCUV2,
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
		e.Precio,
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID2) EtiquetaDescripcion2,
		e.Precio2,
		e.TextoLibre,
		e.FlagEstrella,
		e.ColorFondo,
		e.TipoEstrategiaID,
		e.ImagenURL FotoProducto01,
		te.ImagenEstrategia ImagenURL,
		e.LimiteVenta,
		pc.MarcaID,
		M.Descripcion,
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
		op.Orden
	  FROM dbo.Estrategia E WITH (NOLOCK)
		  INNER JOIN @OfertasPersonalizadas op    ON E.CampaniaID = op.AnioCampanaVenta    AND E.CUV2 = op.CUV
		  INNER JOIN ods.ProductoComercial PC WITH (NOLOCK)    ON PC.CUV = E.CUV2    AND PC.AnoCampania = E.CampaniaID
		  INNER JOIN dbo.TipoEstrategia TE WITH (NOLOCK)    ON E.TipoEstrategiaID = TE.TipoEstrategiaID    AND TE.Codigo = @EstrategiaCodigo
		  LEFT JOIN dbo.Marca M WITH (NOLOCK)    ON M.MarcaId = PC.MarcaId
	  WHERE E.Activo = 1
		  AND TE.FlagActivo = 1
		  AND TE.flagRecoPerfil = 1
		  AND NOT EXISTS (SELECT    CUV  FROM @tablaCuvFaltante TF  WHERE E.CUV2 = TF.CUV)) op
		ORDER BY
			op.Orden ASC, EstrategiaID ASC

	DECLARE @DetalleEstrategiasLanzamiento TABLE (
	  EstrategiaID int,
	  TablaLogicaDatosId smallint,
	  Valor varchar(500)
	)
	INSERT @DetalleEstrategiasLanzamiento
	  SELECT
		ED.EstrategiaID,
		ED.TablaLogicaDatosId,
		ED.Valor
	  FROM @OfertaEstrategiasLanzamiento T
	  LEFT JOIN dbo.EstrategiaDetalle ED WITH (NOLOCK)    ON ED.EstrategiaID = T.EstrategiaID
		AND TablaLogicaDatosId BETWEEN 10201 AND 10213

	DECLARE @EstrategiasLanzamiento TABLE (
	  EstrategiaID int,
	  FlagIndividual bit,
	  Slogan varchar(1000),
	  ImgFondoDesktop varchar(1000),
	  ImgSelloProductoDesktop varchar(1000),
	  UrlVideoDesktop varchar(1000),
	  ImgFichaFondoDesktop varchar(1000),
	  ImgFondoMobile varchar(1000),
	  ImgSelloProductoMobile varchar(1000),
	  UrlVideoMobile varchar(1000),
	  ImgFichaFondoMobile varchar(1000),
	  ImgHomeDesktop varchar(1000),
	  ImgHomeMobile varchar(1000)
	)
	INSERT @EstrategiasLanzamiento
	  SELECT
		EstrategiaID,
		(SELECT CASE WHEN valor = '1' THEN 1 ELSE 0 END FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10212) AS FlagIndividual,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10213) AS Slogan,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10201) AS ImgFondoDesktop,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10203) AS ImgSelloProductoDesktop,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10204) AS UrlVideoDesktop,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10208) AS ImgFichaFondoDesktop,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10205) AS ImgFondoMobile,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10206) AS ImgSelloProductoMobile,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10207) AS UrlVideoMobile,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10209) AS ImgFichaFondoMobile,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10210) AS ImgHomeDesktop,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10211) AS ImgHomeMobile
	  FROM @OfertaEstrategiasLanzamiento AS T
	SELECT
	  T.EstrategiaID,
	  T.CUV2,
	  T.DescripcionCUV2,
	  T.EtiquetaDescripcion,
	  T.Precio,
	  T.EtiquetaDescripcion2,
	  T.Precio2,
	  ISNULL(T.TextoLibre, '') AS TextoLibre,
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
	  T.CodigoProducto,
	  T.EtiquetaID,
	  T.EtiquetaID2,
	  T.CodigoEstrategia,
	  T.TieneVariedad,
	  T.CODIGO,
	  T.DescripcionEstrategia,
	  T.FlagMostrarImg,
	  T.DescripcionMarca,
	  'NO DISPONIBLE' AS DescripcionCategoria,
	  D.FlagIndividual,
	  D.Slogan,
	  D.ImgFondoDesktop,
	  D.ImgSelloProductoDesktop AS ImgFichaDesktop,
	  D.UrlVideoDesktop,
	  D.ImgFichaFondoDesktop,
	  D.ImgFondoMobile,
	  D.ImgSelloProductoMobile AS ImgFichaMobile,
	  D.UrlVideoMobile,
	  D.ImgFichaFondoMobile,
	  D.ImgHomeDesktop,
	  D.ImgHomeMobile,
	  T.PrecioPublico,
	  T.Ganancia
	FROM @OfertaEstrategiasLanzamiento T
	LEFT JOIN @EstrategiasLanzamiento D  ON D.EstrategiaID = T.EstrategiaID
	ORDER BY Orden1 ASC, CASE
	  WHEN ISNULL(T.Orden2, 0) = 0 THEN T.Orden1
	  ELSE T.Orden2
	END ASC, EstrategiaID ASC

SET NOCOUNT OFF
END
GO

GO
USE BelcorpCostaRica
GO

GO
-- exec dbo.ListarEstrategiasLanzamiento 201807, '000685941'
ALTER PROCEDURE [dbo].[ListarEstrategiasLanzamiento]
@CampaniaID INT,
@CodigoConsultora VARCHAR(30)
AS
BEGIN
SET NOCOUNT ON
DECLARE @StrCampaniaID char(6) = CONVERT(char(6), @CampaniaID)
DECLARE @EstrategiaCodigo varchar(100) = '005'

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
		FROM ods.OfertasPersonalizadas WITH (NOLOCK)
		WHERE CodConsultora = @CodigoConsultora
			AND AnioCampanaVenta = @StrCampaniaID
			AND TipoPersonalizacion = 'LAN'

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
				AND op.TipoPersonalizacion = 'LAN'
		END
	END
	IF(@codConsultoraDefault<>@CodigoConsultora)
	INSERT INTO @OfertasPersonalizadas(Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta)
		SELECT Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta
		FROM dbo.ListarEstrategiasForzadas(@CampaniaID, @EstrategiaCodigo)

	DECLARE @OfertaEstrategiasLanzamiento TABLE (
	  EstrategiaID int,
	  CUV2 varchar(5),
	  DescripcionCUV2 varchar(800),
	  EtiquetaDescripcion varchar(8000),
	  Precio numeric(12, 2),
	  EtiquetaDescripcion2 varchar(8000),
	  Precio2 numeric(12, 2),
	  TextoLibre varchar(800),
	  FlagEstrella bit,
	  ColorFondo varchar(20),
	  TipoEstrategiaID int,
	  FotoProducto01 varchar(800),
	  ImagenURL varchar(500),
	  LimiteVenta int,
	  MarcaID int,
	  DescripcionMarca VARCHAR(20),
	  Orden1 int,
	  Orden2 int,
	  IndicadorMontoMinimo int,
	  CodigoProducto varchar(12),
	  FlagNueva int,
	  TipoTallaColor varchar(50),
	  TipoEstrategiaImagenMostrar int,
	  EtiquetaID int,
	  EtiquetaID2 int,
	  CodigoEstrategia varchar(100),
	  TieneVariedad int,
	  CODIGO varchar(100),
	  DescripcionEstrategia varchar(200),
	  FlagMostrarImg int,
	  PrecioPublico decimal(18, 2),
	  Ganancia decimal(18, 2)
	)
	INSERT INTO @OfertaEstrategiasLanzamiento
	SELECT
		EstrategiaID,
		CUV2,
		DescripcionCUV2,
		EtiquetaDescripcion,
		Precio,
		EtiquetaDescripcion2,
		Precio2,
		TextoLibre,
		FlagEstrella,
		ColorFondo,
		TipoEstrategiaID,
		FotoProducto01,
		ImagenURL,
		LimiteVenta,
		MarcaID,
		Descripcion,
		Orden Orden1,
		Orden Orden2,
		IndicadorMontoMinimo,
		CodigoProducto,
		FlagNueva,
		TipoTallaColor,
		TipoEstrategiaImagenMostrar,
		EtiquetaID,
		EtiquetaID2,
		CodigoEstrategia,
		TieneVariedad,
		CODIGO,
		DescripcionEstrategia,
		FlagMostrarImg,
		PrecioPublico,
		Ganancia
	 FROM(
	  SELECT DISTINCT
		E.EstrategiaID,
		e.CUV2,
		e.DescripcionCUV2,
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
		e.Precio,
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID2) EtiquetaDescripcion2,
		e.Precio2,
		e.TextoLibre,
		e.FlagEstrella,
		e.ColorFondo,
		e.TipoEstrategiaID,
		e.ImagenURL FotoProducto01,
		te.ImagenEstrategia ImagenURL,
		e.LimiteVenta,
		pc.MarcaID,
		M.Descripcion,
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
		op.Orden
	  FROM dbo.Estrategia E WITH (NOLOCK)
		  INNER JOIN @OfertasPersonalizadas op    ON E.CampaniaID = op.AnioCampanaVenta    AND E.CUV2 = op.CUV
		  INNER JOIN ods.ProductoComercial PC WITH (NOLOCK)    ON PC.CUV = E.CUV2    AND PC.AnoCampania = E.CampaniaID
		  INNER JOIN dbo.TipoEstrategia TE WITH (NOLOCK)    ON E.TipoEstrategiaID = TE.TipoEstrategiaID    AND TE.Codigo = @EstrategiaCodigo
		  LEFT JOIN dbo.Marca M WITH (NOLOCK)    ON M.MarcaId = PC.MarcaId
	  WHERE E.Activo = 1
		  AND TE.FlagActivo = 1
		  AND TE.flagRecoPerfil = 1
		  AND NOT EXISTS (SELECT    CUV  FROM @tablaCuvFaltante TF  WHERE E.CUV2 = TF.CUV)) op
		ORDER BY
			op.Orden ASC, EstrategiaID ASC

	DECLARE @DetalleEstrategiasLanzamiento TABLE (
	  EstrategiaID int,
	  TablaLogicaDatosId smallint,
	  Valor varchar(500)
	)
	INSERT @DetalleEstrategiasLanzamiento
	  SELECT
		ED.EstrategiaID,
		ED.TablaLogicaDatosId,
		ED.Valor
	  FROM @OfertaEstrategiasLanzamiento T
	  LEFT JOIN dbo.EstrategiaDetalle ED WITH (NOLOCK)    ON ED.EstrategiaID = T.EstrategiaID
		AND TablaLogicaDatosId BETWEEN 10201 AND 10213

	DECLARE @EstrategiasLanzamiento TABLE (
	  EstrategiaID int,
	  FlagIndividual bit,
	  Slogan varchar(1000),
	  ImgFondoDesktop varchar(1000),
	  ImgSelloProductoDesktop varchar(1000),
	  UrlVideoDesktop varchar(1000),
	  ImgFichaFondoDesktop varchar(1000),
	  ImgFondoMobile varchar(1000),
	  ImgSelloProductoMobile varchar(1000),
	  UrlVideoMobile varchar(1000),
	  ImgFichaFondoMobile varchar(1000),
	  ImgHomeDesktop varchar(1000),
	  ImgHomeMobile varchar(1000)
	)
	INSERT @EstrategiasLanzamiento
	  SELECT
		EstrategiaID,
		(SELECT CASE WHEN valor = '1' THEN 1 ELSE 0 END FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10212) AS FlagIndividual,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10213) AS Slogan,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10201) AS ImgFondoDesktop,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10203) AS ImgSelloProductoDesktop,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10204) AS UrlVideoDesktop,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10208) AS ImgFichaFondoDesktop,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10205) AS ImgFondoMobile,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10206) AS ImgSelloProductoMobile,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10207) AS UrlVideoMobile,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10209) AS ImgFichaFondoMobile,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10210) AS ImgHomeDesktop,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10211) AS ImgHomeMobile
	  FROM @OfertaEstrategiasLanzamiento AS T
	SELECT
	  T.EstrategiaID,
	  T.CUV2,
	  T.DescripcionCUV2,
	  T.EtiquetaDescripcion,
	  T.Precio,
	  T.EtiquetaDescripcion2,
	  T.Precio2,
	  ISNULL(T.TextoLibre, '') AS TextoLibre,
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
	  T.CodigoProducto,
	  T.EtiquetaID,
	  T.EtiquetaID2,
	  T.CodigoEstrategia,
	  T.TieneVariedad,
	  T.CODIGO,
	  T.DescripcionEstrategia,
	  T.FlagMostrarImg,
	  T.DescripcionMarca,
	  'NO DISPONIBLE' AS DescripcionCategoria,
	  D.FlagIndividual,
	  D.Slogan,
	  D.ImgFondoDesktop,
	  D.ImgSelloProductoDesktop AS ImgFichaDesktop,
	  D.UrlVideoDesktop,
	  D.ImgFichaFondoDesktop,
	  D.ImgFondoMobile,
	  D.ImgSelloProductoMobile AS ImgFichaMobile,
	  D.UrlVideoMobile,
	  D.ImgFichaFondoMobile,
	  D.ImgHomeDesktop,
	  D.ImgHomeMobile,
	  T.PrecioPublico,
	  T.Ganancia
	FROM @OfertaEstrategiasLanzamiento T
	LEFT JOIN @EstrategiasLanzamiento D  ON D.EstrategiaID = T.EstrategiaID
	ORDER BY Orden1 ASC, CASE
	  WHEN ISNULL(T.Orden2, 0) = 0 THEN T.Orden1
	  ELSE T.Orden2
	END ASC, EstrategiaID ASC

SET NOCOUNT OFF
END
GO

GO
USE BelcorpChile
GO

GO
-- exec dbo.ListarEstrategiasLanzamiento 201807, '000685941'
ALTER PROCEDURE [dbo].[ListarEstrategiasLanzamiento]
@CampaniaID INT,
@CodigoConsultora VARCHAR(30)
AS
BEGIN
SET NOCOUNT ON
DECLARE @StrCampaniaID char(6) = CONVERT(char(6), @CampaniaID)
DECLARE @EstrategiaCodigo varchar(100) = '005'

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
		FROM ods.OfertasPersonalizadas WITH (NOLOCK)
		WHERE CodConsultora = @CodigoConsultora
			AND AnioCampanaVenta = @StrCampaniaID
			AND TipoPersonalizacion = 'LAN'

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
				AND op.TipoPersonalizacion = 'LAN'
		END
	END
	IF(@codConsultoraDefault<>@CodigoConsultora)
	INSERT INTO @OfertasPersonalizadas(Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta)
		SELECT Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta
		FROM dbo.ListarEstrategiasForzadas(@CampaniaID, @EstrategiaCodigo)

	DECLARE @OfertaEstrategiasLanzamiento TABLE (
	  EstrategiaID int,
	  CUV2 varchar(5),
	  DescripcionCUV2 varchar(800),
	  EtiquetaDescripcion varchar(8000),
	  Precio numeric(12, 2),
	  EtiquetaDescripcion2 varchar(8000),
	  Precio2 numeric(12, 2),
	  TextoLibre varchar(800),
	  FlagEstrella bit,
	  ColorFondo varchar(20),
	  TipoEstrategiaID int,
	  FotoProducto01 varchar(800),
	  ImagenURL varchar(500),
	  LimiteVenta int,
	  MarcaID int,
	  DescripcionMarca VARCHAR(20),
	  Orden1 int,
	  Orden2 int,
	  IndicadorMontoMinimo int,
	  CodigoProducto varchar(12),
	  FlagNueva int,
	  TipoTallaColor varchar(50),
	  TipoEstrategiaImagenMostrar int,
	  EtiquetaID int,
	  EtiquetaID2 int,
	  CodigoEstrategia varchar(100),
	  TieneVariedad int,
	  CODIGO varchar(100),
	  DescripcionEstrategia varchar(200),
	  FlagMostrarImg int,
	  PrecioPublico decimal(18, 2),
	  Ganancia decimal(18, 2)
	)
	INSERT INTO @OfertaEstrategiasLanzamiento
	SELECT
		EstrategiaID,
		CUV2,
		DescripcionCUV2,
		EtiquetaDescripcion,
		Precio,
		EtiquetaDescripcion2,
		Precio2,
		TextoLibre,
		FlagEstrella,
		ColorFondo,
		TipoEstrategiaID,
		FotoProducto01,
		ImagenURL,
		LimiteVenta,
		MarcaID,
		Descripcion,
		Orden Orden1,
		Orden Orden2,
		IndicadorMontoMinimo,
		CodigoProducto,
		FlagNueva,
		TipoTallaColor,
		TipoEstrategiaImagenMostrar,
		EtiquetaID,
		EtiquetaID2,
		CodigoEstrategia,
		TieneVariedad,
		CODIGO,
		DescripcionEstrategia,
		FlagMostrarImg,
		PrecioPublico,
		Ganancia
	 FROM(
	  SELECT DISTINCT
		E.EstrategiaID,
		e.CUV2,
		e.DescripcionCUV2,
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
		e.Precio,
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID2) EtiquetaDescripcion2,
		e.Precio2,
		e.TextoLibre,
		e.FlagEstrella,
		e.ColorFondo,
		e.TipoEstrategiaID,
		e.ImagenURL FotoProducto01,
		te.ImagenEstrategia ImagenURL,
		e.LimiteVenta,
		pc.MarcaID,
		M.Descripcion,
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
		op.Orden
	  FROM dbo.Estrategia E WITH (NOLOCK)
		  INNER JOIN @OfertasPersonalizadas op    ON E.CampaniaID = op.AnioCampanaVenta    AND E.CUV2 = op.CUV
		  INNER JOIN ods.ProductoComercial PC WITH (NOLOCK)    ON PC.CUV = E.CUV2    AND PC.AnoCampania = E.CampaniaID
		  INNER JOIN dbo.TipoEstrategia TE WITH (NOLOCK)    ON E.TipoEstrategiaID = TE.TipoEstrategiaID    AND TE.Codigo = @EstrategiaCodigo
		  LEFT JOIN dbo.Marca M WITH (NOLOCK)    ON M.MarcaId = PC.MarcaId
	  WHERE E.Activo = 1
		  AND TE.FlagActivo = 1
		  AND TE.flagRecoPerfil = 1
		  AND NOT EXISTS (SELECT    CUV  FROM @tablaCuvFaltante TF  WHERE E.CUV2 = TF.CUV)) op
		ORDER BY
			op.Orden ASC, EstrategiaID ASC

	DECLARE @DetalleEstrategiasLanzamiento TABLE (
	  EstrategiaID int,
	  TablaLogicaDatosId smallint,
	  Valor varchar(500)
	)
	INSERT @DetalleEstrategiasLanzamiento
	  SELECT
		ED.EstrategiaID,
		ED.TablaLogicaDatosId,
		ED.Valor
	  FROM @OfertaEstrategiasLanzamiento T
	  LEFT JOIN dbo.EstrategiaDetalle ED WITH (NOLOCK)    ON ED.EstrategiaID = T.EstrategiaID
		AND TablaLogicaDatosId BETWEEN 10201 AND 10213

	DECLARE @EstrategiasLanzamiento TABLE (
	  EstrategiaID int,
	  FlagIndividual bit,
	  Slogan varchar(1000),
	  ImgFondoDesktop varchar(1000),
	  ImgSelloProductoDesktop varchar(1000),
	  UrlVideoDesktop varchar(1000),
	  ImgFichaFondoDesktop varchar(1000),
	  ImgFondoMobile varchar(1000),
	  ImgSelloProductoMobile varchar(1000),
	  UrlVideoMobile varchar(1000),
	  ImgFichaFondoMobile varchar(1000),
	  ImgHomeDesktop varchar(1000),
	  ImgHomeMobile varchar(1000)
	)
	INSERT @EstrategiasLanzamiento
	  SELECT
		EstrategiaID,
		(SELECT CASE WHEN valor = '1' THEN 1 ELSE 0 END FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10212) AS FlagIndividual,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10213) AS Slogan,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10201) AS ImgFondoDesktop,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10203) AS ImgSelloProductoDesktop,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10204) AS UrlVideoDesktop,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10208) AS ImgFichaFondoDesktop,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10205) AS ImgFondoMobile,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10206) AS ImgSelloProductoMobile,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10207) AS UrlVideoMobile,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10209) AS ImgFichaFondoMobile,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10210) AS ImgHomeDesktop,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10211) AS ImgHomeMobile
	  FROM @OfertaEstrategiasLanzamiento AS T
	SELECT
	  T.EstrategiaID,
	  T.CUV2,
	  T.DescripcionCUV2,
	  T.EtiquetaDescripcion,
	  T.Precio,
	  T.EtiquetaDescripcion2,
	  T.Precio2,
	  ISNULL(T.TextoLibre, '') AS TextoLibre,
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
	  T.CodigoProducto,
	  T.EtiquetaID,
	  T.EtiquetaID2,
	  T.CodigoEstrategia,
	  T.TieneVariedad,
	  T.CODIGO,
	  T.DescripcionEstrategia,
	  T.FlagMostrarImg,
	  T.DescripcionMarca,
	  'NO DISPONIBLE' AS DescripcionCategoria,
	  D.FlagIndividual,
	  D.Slogan,
	  D.ImgFondoDesktop,
	  D.ImgSelloProductoDesktop AS ImgFichaDesktop,
	  D.UrlVideoDesktop,
	  D.ImgFichaFondoDesktop,
	  D.ImgFondoMobile,
	  D.ImgSelloProductoMobile AS ImgFichaMobile,
	  D.UrlVideoMobile,
	  D.ImgFichaFondoMobile,
	  D.ImgHomeDesktop,
	  D.ImgHomeMobile,
	  T.PrecioPublico,
	  T.Ganancia
	FROM @OfertaEstrategiasLanzamiento T
	LEFT JOIN @EstrategiasLanzamiento D  ON D.EstrategiaID = T.EstrategiaID
	ORDER BY Orden1 ASC, CASE
	  WHEN ISNULL(T.Orden2, 0) = 0 THEN T.Orden1
	  ELSE T.Orden2
	END ASC, EstrategiaID ASC

SET NOCOUNT OFF
END
GO

GO
USE BelcorpBolivia
GO

GO
-- exec dbo.ListarEstrategiasLanzamiento 201807, '000685941'
ALTER PROCEDURE [dbo].[ListarEstrategiasLanzamiento]
@CampaniaID INT,
@CodigoConsultora VARCHAR(30)
AS
BEGIN
SET NOCOUNT ON
DECLARE @StrCampaniaID char(6) = CONVERT(char(6), @CampaniaID)
DECLARE @EstrategiaCodigo varchar(100) = '005'

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
		FROM ods.OfertasPersonalizadas WITH (NOLOCK)
		WHERE CodConsultora = @CodigoConsultora
			AND AnioCampanaVenta = @StrCampaniaID
			AND TipoPersonalizacion = 'LAN'

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
				AND op.TipoPersonalizacion = 'LAN'
		END
	END
	IF(@codConsultoraDefault<>@CodigoConsultora)
	INSERT INTO @OfertasPersonalizadas(Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta)
		SELECT Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta
		FROM dbo.ListarEstrategiasForzadas(@CampaniaID, @EstrategiaCodigo)

	DECLARE @OfertaEstrategiasLanzamiento TABLE (
	  EstrategiaID int,
	  CUV2 varchar(5),
	  DescripcionCUV2 varchar(800),
	  EtiquetaDescripcion varchar(8000),
	  Precio numeric(12, 2),
	  EtiquetaDescripcion2 varchar(8000),
	  Precio2 numeric(12, 2),
	  TextoLibre varchar(800),
	  FlagEstrella bit,
	  ColorFondo varchar(20),
	  TipoEstrategiaID int,
	  FotoProducto01 varchar(800),
	  ImagenURL varchar(500),
	  LimiteVenta int,
	  MarcaID int,
	  DescripcionMarca VARCHAR(20),
	  Orden1 int,
	  Orden2 int,
	  IndicadorMontoMinimo int,
	  CodigoProducto varchar(12),
	  FlagNueva int,
	  TipoTallaColor varchar(50),
	  TipoEstrategiaImagenMostrar int,
	  EtiquetaID int,
	  EtiquetaID2 int,
	  CodigoEstrategia varchar(100),
	  TieneVariedad int,
	  CODIGO varchar(100),
	  DescripcionEstrategia varchar(200),
	  FlagMostrarImg int,
	  PrecioPublico decimal(18, 2),
	  Ganancia decimal(18, 2)
	)
	INSERT INTO @OfertaEstrategiasLanzamiento
	SELECT
		EstrategiaID,
		CUV2,
		DescripcionCUV2,
		EtiquetaDescripcion,
		Precio,
		EtiquetaDescripcion2,
		Precio2,
		TextoLibre,
		FlagEstrella,
		ColorFondo,
		TipoEstrategiaID,
		FotoProducto01,
		ImagenURL,
		LimiteVenta,
		MarcaID,
		Descripcion,
		Orden Orden1,
		Orden Orden2,
		IndicadorMontoMinimo,
		CodigoProducto,
		FlagNueva,
		TipoTallaColor,
		TipoEstrategiaImagenMostrar,
		EtiquetaID,
		EtiquetaID2,
		CodigoEstrategia,
		TieneVariedad,
		CODIGO,
		DescripcionEstrategia,
		FlagMostrarImg,
		PrecioPublico,
		Ganancia
	 FROM(
	  SELECT DISTINCT
		E.EstrategiaID,
		e.CUV2,
		e.DescripcionCUV2,
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
		e.Precio,
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID2) EtiquetaDescripcion2,
		e.Precio2,
		e.TextoLibre,
		e.FlagEstrella,
		e.ColorFondo,
		e.TipoEstrategiaID,
		e.ImagenURL FotoProducto01,
		te.ImagenEstrategia ImagenURL,
		e.LimiteVenta,
		pc.MarcaID,
		M.Descripcion,
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
		op.Orden
	  FROM dbo.Estrategia E WITH (NOLOCK)
		  INNER JOIN @OfertasPersonalizadas op    ON E.CampaniaID = op.AnioCampanaVenta    AND E.CUV2 = op.CUV
		  INNER JOIN ods.ProductoComercial PC WITH (NOLOCK)    ON PC.CUV = E.CUV2    AND PC.AnoCampania = E.CampaniaID
		  INNER JOIN dbo.TipoEstrategia TE WITH (NOLOCK)    ON E.TipoEstrategiaID = TE.TipoEstrategiaID    AND TE.Codigo = @EstrategiaCodigo
		  LEFT JOIN dbo.Marca M WITH (NOLOCK)    ON M.MarcaId = PC.MarcaId
	  WHERE E.Activo = 1
		  AND TE.FlagActivo = 1
		  AND TE.flagRecoPerfil = 1
		  AND NOT EXISTS (SELECT    CUV  FROM @tablaCuvFaltante TF  WHERE E.CUV2 = TF.CUV)) op
		ORDER BY
			op.Orden ASC, EstrategiaID ASC

	DECLARE @DetalleEstrategiasLanzamiento TABLE (
	  EstrategiaID int,
	  TablaLogicaDatosId smallint,
	  Valor varchar(500)
	)
	INSERT @DetalleEstrategiasLanzamiento
	  SELECT
		ED.EstrategiaID,
		ED.TablaLogicaDatosId,
		ED.Valor
	  FROM @OfertaEstrategiasLanzamiento T
	  LEFT JOIN dbo.EstrategiaDetalle ED WITH (NOLOCK)    ON ED.EstrategiaID = T.EstrategiaID
		AND TablaLogicaDatosId BETWEEN 10201 AND 10213

	DECLARE @EstrategiasLanzamiento TABLE (
	  EstrategiaID int,
	  FlagIndividual bit,
	  Slogan varchar(1000),
	  ImgFondoDesktop varchar(1000),
	  ImgSelloProductoDesktop varchar(1000),
	  UrlVideoDesktop varchar(1000),
	  ImgFichaFondoDesktop varchar(1000),
	  ImgFondoMobile varchar(1000),
	  ImgSelloProductoMobile varchar(1000),
	  UrlVideoMobile varchar(1000),
	  ImgFichaFondoMobile varchar(1000),
	  ImgHomeDesktop varchar(1000),
	  ImgHomeMobile varchar(1000)
	)
	INSERT @EstrategiasLanzamiento
	  SELECT
		EstrategiaID,
		(SELECT CASE WHEN valor = '1' THEN 1 ELSE 0 END FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10212) AS FlagIndividual,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10213) AS Slogan,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10201) AS ImgFondoDesktop,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10203) AS ImgSelloProductoDesktop,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10204) AS UrlVideoDesktop,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10208) AS ImgFichaFondoDesktop,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10205) AS ImgFondoMobile,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10206) AS ImgSelloProductoMobile,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10207) AS UrlVideoMobile,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10209) AS ImgFichaFondoMobile,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10210) AS ImgHomeDesktop,
		(SELECT valor FROM @DetalleEstrategiasLanzamiento WHERE EstrategiaID = T.EstrategiaID AND TablaLogicaDatosId = 10211) AS ImgHomeMobile
	  FROM @OfertaEstrategiasLanzamiento AS T
	SELECT
	  T.EstrategiaID,
	  T.CUV2,
	  T.DescripcionCUV2,
	  T.EtiquetaDescripcion,
	  T.Precio,
	  T.EtiquetaDescripcion2,
	  T.Precio2,
	  ISNULL(T.TextoLibre, '') AS TextoLibre,
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
	  T.CodigoProducto,
	  T.EtiquetaID,
	  T.EtiquetaID2,
	  T.CodigoEstrategia,
	  T.TieneVariedad,
	  T.CODIGO,
	  T.DescripcionEstrategia,
	  T.FlagMostrarImg,
	  T.DescripcionMarca,
	  'NO DISPONIBLE' AS DescripcionCategoria,
	  D.FlagIndividual,
	  D.Slogan,
	  D.ImgFondoDesktop,
	  D.ImgSelloProductoDesktop AS ImgFichaDesktop,
	  D.UrlVideoDesktop,
	  D.ImgFichaFondoDesktop,
	  D.ImgFondoMobile,
	  D.ImgSelloProductoMobile AS ImgFichaMobile,
	  D.UrlVideoMobile,
	  D.ImgFichaFondoMobile,
	  D.ImgHomeDesktop,
	  D.ImgHomeMobile,
	  T.PrecioPublico,
	  T.Ganancia
	FROM @OfertaEstrategiasLanzamiento T
	LEFT JOIN @EstrategiasLanzamiento D  ON D.EstrategiaID = T.EstrategiaID
	ORDER BY Orden1 ASC, CASE
	  WHEN ISNULL(T.Orden2, 0) = 0 THEN T.Orden1
	  ELSE T.Orden2
	END ASC, EstrategiaID ASC

SET NOCOUNT OFF
END
GO

GO
