GO
USE BelcorpPeru
GO

GO
-- exec ListarEstrategiasODD 201807, '000685941','2018-05-07'
ALTER PROCEDURE dbo.ListarEstrategiasODD
(
	 @CodCampania INT
	, @CodConsultora VARCHAR(10)
	, @FechaInicioFact DATE
)
AS
BEGIN
SET NOCOUNT ON
	DECLARE @StrCampaniaID char(6) = CONVERT(char(6), @CodCampania)
	DECLARE @EstrategiaCodigo varchar(100) = '009'

	DECLARE @tablaCuvFaltante TABLE (
	  CUV varchar(6)
	)
	DECLARE @OfertasPersonalizadas TABLE (
	  Orden int,
	  CUV char(6),
	  TipoPersonalizacion char(3),
	  FlagRevista int,
	  AnioCampanaVenta int,
	  DiaInicio INT
	)

	INSERT INTO @tablaCuvFaltante (CUV)
	  SELECT
		CUV
	  FROM dbo.ObtenerCuvFaltante (@CodCampania, @CodConsultora)
	DECLARE @codConsultoraForzada VARCHAR(9) = ''
	DECLARE @codConsultoraDefault VARCHAR(9) = ''
	SELECT @codConsultoraForzada = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10002
	SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001

	IF(@codConsultoraForzada <> @CodConsultora)
	BEGIN
		INSERT INTO @OfertasPersonalizadas
		SELECT
		ISNULL(Orden, 0),
		CUV,
		TipoPersonalizacion,
		FlagRevista,
		CONVERT(int, AnioCampanaVenta),
		DiaInicio
		FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
		WHERE op.CodConsultora = @CodConsultora
			AND op.AnioCampanaVenta = @StrCampaniaID
			AND op.TipoPersonalizacion = 'ODD'
		IF NOT EXISTS (SELECT   CUV  FROM @OfertasPersonalizadas)
		BEGIN
		  INSERT INTO @OfertasPersonalizadas
			SELECT
			  ISNULL(Orden, 0),
			  CUV,
			  TipoPersonalizacion,
			  FlagRevista,
			  CONVERT(int, AnioCampanaVenta),
			  DiaInicio
			FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
			WHERE op.CodConsultora = @codConsultoraDefault
				AND op.AnioCampanaVenta = @StrCampaniaID
				AND op.TipoPersonalizacion = 'ODD'
		END
	END

	IF(@codConsultoraDefault<>@CodConsultora)
	INSERT INTO @OfertasPersonalizadas(Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta, DiaInicio)
		SELECT Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta,DiaInicio
		FROM dbo.ListarEstrategiasForzadas(@CodCampania, @EstrategiaCodigo)
	SELECT
	 e.EstrategiaID,
		e.CodigoEstrategia,
		e.CUV2,
		e.DescripcionCUV2,
		e.Precio,
		e.Precio2,
		e.TipoEstrategiaID,
		e.ImagenURL AS FotoProducto01,
		te.ImagenEstrategia AS ImagenURL,
		e.LimiteVenta,
		e.TextoLibre,
		pc.MarcaID,
		m.Descripcion AS DescripcionMarca,
		pc.IndicadorMontoMinimo,
		pc.CodigoProducto,
		0 AS FlagNueva,
		6 AS TipoEstrategiaImagenMostrar,
		op.DiaInicio,
		op.Orden,
		te.DescripcionEstrategia AS DescripcionEstrategia
	FROM dbo.Estrategia E WITH (NOLOCK)
		  INNER JOIN @OfertasPersonalizadas op    ON E.CampaniaID = op.AnioCampanaVenta    AND E.CUV2 = op.CUV
		  INNER JOIN ods.ProductoComercial PC WITH (NOLOCK)    ON PC.CUV = E.CUV2    AND PC.AnoCampania = E.CampaniaID
		  INNER JOIN dbo.TipoEstrategia TE WITH (NOLOCK)    ON E.TipoEstrategiaID = TE.TipoEstrategiaID    AND TE.Codigo =@EstrategiaCodigo
		  LEFT JOIN dbo.Marca M WITH (NOLOCK)    ON M.MarcaId = PC.MarcaId
	  WHERE E.Activo = 1
		  AND TE.FlagActivo = 1
		  AND TE.flagRecoPerfil = 1
		  AND NOT EXISTS (SELECT    CUV  FROM @tablaCuvFaltante TF  WHERE E.CUV2 = TF.CUV)
		   AND DATEDIFF(dd, GETDATE(), DATEADD(dd, op.DiaInicio, CAST(@FechaInicioFact AS date))) = 0
		ORDER BY
			op.Orden ASC, EstrategiaID ASC

	SET NOCOUNT OFF
END
GO

GO
USE BelcorpMexico
GO

GO
-- exec ListarEstrategiasODD 201807, '000685941','2018-05-07'
ALTER PROCEDURE dbo.ListarEstrategiasODD
(
	 @CodCampania INT
	, @CodConsultora VARCHAR(10)
	, @FechaInicioFact DATE
)
AS
BEGIN
SET NOCOUNT ON
	DECLARE @StrCampaniaID char(6) = CONVERT(char(6), @CodCampania)
	DECLARE @EstrategiaCodigo varchar(100) = '009'

	DECLARE @tablaCuvFaltante TABLE (
	  CUV varchar(6)
	)
	DECLARE @OfertasPersonalizadas TABLE (
	  Orden int,
	  CUV char(6),
	  TipoPersonalizacion char(3),
	  FlagRevista int,
	  AnioCampanaVenta int,
	  DiaInicio INT
	)

	INSERT INTO @tablaCuvFaltante (CUV)
	  SELECT
		CUV
	  FROM dbo.ObtenerCuvFaltante (@CodCampania, @CodConsultora)
	DECLARE @codConsultoraForzada VARCHAR(9) = ''
	DECLARE @codConsultoraDefault VARCHAR(9) = ''
	SELECT @codConsultoraForzada = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10002
	SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001

	IF(@codConsultoraForzada <> @CodConsultora)
	BEGIN
		INSERT INTO @OfertasPersonalizadas
		SELECT
		ISNULL(Orden, 0),
		CUV,
		TipoPersonalizacion,
		FlagRevista,
		CONVERT(int, AnioCampanaVenta),
		DiaInicio
		FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
		WHERE op.CodConsultora = @CodConsultora
			AND op.AnioCampanaVenta = @StrCampaniaID
			AND op.TipoPersonalizacion = 'ODD'
		IF NOT EXISTS (SELECT   CUV  FROM @OfertasPersonalizadas)
		BEGIN
		  INSERT INTO @OfertasPersonalizadas
			SELECT
			  ISNULL(Orden, 0),
			  CUV,
			  TipoPersonalizacion,
			  FlagRevista,
			  CONVERT(int, AnioCampanaVenta),
			  DiaInicio
			FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
			WHERE op.CodConsultora = @codConsultoraDefault
				AND op.AnioCampanaVenta = @StrCampaniaID
				AND op.TipoPersonalizacion = 'ODD'
		END
	END

	IF(@codConsultoraDefault<>@CodConsultora)
	INSERT INTO @OfertasPersonalizadas(Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta, DiaInicio)
		SELECT Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta,DiaInicio
		FROM dbo.ListarEstrategiasForzadas(@CodCampania, @EstrategiaCodigo)
	SELECT
	 e.EstrategiaID,
		e.CodigoEstrategia,
		e.CUV2,
		e.DescripcionCUV2,
		e.Precio,
		e.Precio2,
		e.TipoEstrategiaID,
		e.ImagenURL AS FotoProducto01,
		te.ImagenEstrategia AS ImagenURL,
		e.LimiteVenta,
		e.TextoLibre,
		pc.MarcaID,
		m.Descripcion AS DescripcionMarca,
		pc.IndicadorMontoMinimo,
		pc.CodigoProducto,
		0 AS FlagNueva,
		6 AS TipoEstrategiaImagenMostrar,
		op.DiaInicio,
		op.Orden,
		te.DescripcionEstrategia AS DescripcionEstrategia
	FROM dbo.Estrategia E WITH (NOLOCK)
		  INNER JOIN @OfertasPersonalizadas op    ON E.CampaniaID = op.AnioCampanaVenta    AND E.CUV2 = op.CUV
		  INNER JOIN ods.ProductoComercial PC WITH (NOLOCK)    ON PC.CUV = E.CUV2    AND PC.AnoCampania = E.CampaniaID
		  INNER JOIN dbo.TipoEstrategia TE WITH (NOLOCK)    ON E.TipoEstrategiaID = TE.TipoEstrategiaID    AND TE.Codigo =@EstrategiaCodigo
		  LEFT JOIN dbo.Marca M WITH (NOLOCK)    ON M.MarcaId = PC.MarcaId
	  WHERE E.Activo = 1
		  AND TE.FlagActivo = 1
		  AND TE.flagRecoPerfil = 1
		  AND NOT EXISTS (SELECT    CUV  FROM @tablaCuvFaltante TF  WHERE E.CUV2 = TF.CUV)
		   AND DATEDIFF(dd, GETDATE(), DATEADD(dd, op.DiaInicio, CAST(@FechaInicioFact AS date))) = 0
		ORDER BY
			op.Orden ASC, EstrategiaID ASC

	SET NOCOUNT OFF
END
GO

GO
USE BelcorpColombia
GO

GO
-- exec ListarEstrategiasODD 201807, '000685941','2018-05-07'
ALTER PROCEDURE dbo.ListarEstrategiasODD
(
	 @CodCampania INT
	, @CodConsultora VARCHAR(10)
	, @FechaInicioFact DATE
)
AS
BEGIN
SET NOCOUNT ON
	DECLARE @StrCampaniaID char(6) = CONVERT(char(6), @CodCampania)
	DECLARE @EstrategiaCodigo varchar(100) = '009'

	DECLARE @tablaCuvFaltante TABLE (
	  CUV varchar(6)
	)
	DECLARE @OfertasPersonalizadas TABLE (
	  Orden int,
	  CUV char(6),
	  TipoPersonalizacion char(3),
	  FlagRevista int,
	  AnioCampanaVenta int,
	  DiaInicio INT
	)

	INSERT INTO @tablaCuvFaltante (CUV)
	  SELECT
		CUV
	  FROM dbo.ObtenerCuvFaltante (@CodCampania, @CodConsultora)
	DECLARE @codConsultoraForzada VARCHAR(9) = ''
	DECLARE @codConsultoraDefault VARCHAR(9) = ''
	SELECT @codConsultoraForzada = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10002
	SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001

	IF(@codConsultoraForzada <> @CodConsultora)
	BEGIN
		INSERT INTO @OfertasPersonalizadas
		SELECT
		ISNULL(Orden, 0),
		CUV,
		TipoPersonalizacion,
		FlagRevista,
		CONVERT(int, AnioCampanaVenta),
		DiaInicio
		FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
		WHERE op.CodConsultora = @CodConsultora
			AND op.AnioCampanaVenta = @StrCampaniaID
			AND op.TipoPersonalizacion = 'ODD'
		IF NOT EXISTS (SELECT   CUV  FROM @OfertasPersonalizadas)
		BEGIN
		  INSERT INTO @OfertasPersonalizadas
			SELECT
			  ISNULL(Orden, 0),
			  CUV,
			  TipoPersonalizacion,
			  FlagRevista,
			  CONVERT(int, AnioCampanaVenta),
			  DiaInicio
			FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
			WHERE op.CodConsultora = @codConsultoraDefault
				AND op.AnioCampanaVenta = @StrCampaniaID
				AND op.TipoPersonalizacion = 'ODD'
		END
	END

	IF(@codConsultoraDefault<>@CodConsultora)
	INSERT INTO @OfertasPersonalizadas(Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta, DiaInicio)
		SELECT Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta,DiaInicio
		FROM dbo.ListarEstrategiasForzadas(@CodCampania, @EstrategiaCodigo)
	SELECT
	 e.EstrategiaID,
		e.CodigoEstrategia,
		e.CUV2,
		e.DescripcionCUV2,
		e.Precio,
		e.Precio2,
		e.TipoEstrategiaID,
		e.ImagenURL AS FotoProducto01,
		te.ImagenEstrategia AS ImagenURL,
		e.LimiteVenta,
		e.TextoLibre,
		pc.MarcaID,
		m.Descripcion AS DescripcionMarca,
		pc.IndicadorMontoMinimo,
		pc.CodigoProducto,
		0 AS FlagNueva,
		6 AS TipoEstrategiaImagenMostrar,
		op.DiaInicio,
		op.Orden,
		te.DescripcionEstrategia AS DescripcionEstrategia
	FROM dbo.Estrategia E WITH (NOLOCK)
		  INNER JOIN @OfertasPersonalizadas op    ON E.CampaniaID = op.AnioCampanaVenta    AND E.CUV2 = op.CUV
		  INNER JOIN ods.ProductoComercial PC WITH (NOLOCK)    ON PC.CUV = E.CUV2    AND PC.AnoCampania = E.CampaniaID
		  INNER JOIN dbo.TipoEstrategia TE WITH (NOLOCK)    ON E.TipoEstrategiaID = TE.TipoEstrategiaID    AND TE.Codigo =@EstrategiaCodigo
		  LEFT JOIN dbo.Marca M WITH (NOLOCK)    ON M.MarcaId = PC.MarcaId
	  WHERE E.Activo = 1
		  AND TE.FlagActivo = 1
		  AND TE.flagRecoPerfil = 1
		  AND NOT EXISTS (SELECT    CUV  FROM @tablaCuvFaltante TF  WHERE E.CUV2 = TF.CUV)
		   AND DATEDIFF(dd, GETDATE(), DATEADD(dd, op.DiaInicio, CAST(@FechaInicioFact AS date))) = 0
		ORDER BY
			op.Orden ASC, EstrategiaID ASC

	SET NOCOUNT OFF
END
GO

GO
USE BelcorpSalvador
GO

GO
-- exec ListarEstrategiasODD 201807, '000685941','2018-05-07'
ALTER PROCEDURE dbo.ListarEstrategiasODD
(
	 @CodCampania INT
	, @CodConsultora VARCHAR(10)
	, @FechaInicioFact DATE
)
AS
BEGIN
SET NOCOUNT ON
	DECLARE @StrCampaniaID char(6) = CONVERT(char(6), @CodCampania)
	DECLARE @EstrategiaCodigo varchar(100) = '009'

	DECLARE @tablaCuvFaltante TABLE (
	  CUV varchar(6)
	)
	DECLARE @OfertasPersonalizadas TABLE (
	  Orden int,
	  CUV char(6),
	  TipoPersonalizacion char(3),
	  FlagRevista int,
	  AnioCampanaVenta int,
	  DiaInicio INT
	)

	INSERT INTO @tablaCuvFaltante (CUV)
	  SELECT
		CUV
	  FROM dbo.ObtenerCuvFaltante (@CodCampania, @CodConsultora)
	DECLARE @codConsultoraForzada VARCHAR(9) = ''
	DECLARE @codConsultoraDefault VARCHAR(9) = ''
	SELECT @codConsultoraForzada = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10002
	SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001

	IF(@codConsultoraForzada <> @CodConsultora)
	BEGIN
		INSERT INTO @OfertasPersonalizadas
		SELECT
		ISNULL(Orden, 0),
		CUV,
		TipoPersonalizacion,
		FlagRevista,
		CONVERT(int, AnioCampanaVenta),
		DiaInicio
		FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
		WHERE op.CodConsultora = @CodConsultora
			AND op.AnioCampanaVenta = @StrCampaniaID
			AND op.TipoPersonalizacion = 'ODD'
		IF NOT EXISTS (SELECT   CUV  FROM @OfertasPersonalizadas)
		BEGIN
		  INSERT INTO @OfertasPersonalizadas
			SELECT
			  ISNULL(Orden, 0),
			  CUV,
			  TipoPersonalizacion,
			  FlagRevista,
			  CONVERT(int, AnioCampanaVenta),
			  DiaInicio
			FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
			WHERE op.CodConsultora = @codConsultoraDefault
				AND op.AnioCampanaVenta = @StrCampaniaID
				AND op.TipoPersonalizacion = 'ODD'
		END
	END

	IF(@codConsultoraDefault<>@CodConsultora)
	INSERT INTO @OfertasPersonalizadas(Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta, DiaInicio)
		SELECT Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta,DiaInicio
		FROM dbo.ListarEstrategiasForzadas(@CodCampania, @EstrategiaCodigo)
	SELECT
	 e.EstrategiaID,
		e.CodigoEstrategia,
		e.CUV2,
		e.DescripcionCUV2,
		e.Precio,
		e.Precio2,
		e.TipoEstrategiaID,
		e.ImagenURL AS FotoProducto01,
		te.ImagenEstrategia AS ImagenURL,
		e.LimiteVenta,
		e.TextoLibre,
		pc.MarcaID,
		m.Descripcion AS DescripcionMarca,
		pc.IndicadorMontoMinimo,
		pc.CodigoProducto,
		0 AS FlagNueva,
		6 AS TipoEstrategiaImagenMostrar,
		op.DiaInicio,
		op.Orden,
		te.DescripcionEstrategia AS DescripcionEstrategia
	FROM dbo.Estrategia E WITH (NOLOCK)
		  INNER JOIN @OfertasPersonalizadas op    ON E.CampaniaID = op.AnioCampanaVenta    AND E.CUV2 = op.CUV
		  INNER JOIN ods.ProductoComercial PC WITH (NOLOCK)    ON PC.CUV = E.CUV2    AND PC.AnoCampania = E.CampaniaID
		  INNER JOIN dbo.TipoEstrategia TE WITH (NOLOCK)    ON E.TipoEstrategiaID = TE.TipoEstrategiaID    AND TE.Codigo =@EstrategiaCodigo
		  LEFT JOIN dbo.Marca M WITH (NOLOCK)    ON M.MarcaId = PC.MarcaId
	  WHERE E.Activo = 1
		  AND TE.FlagActivo = 1
		  AND TE.flagRecoPerfil = 1
		  AND NOT EXISTS (SELECT    CUV  FROM @tablaCuvFaltante TF  WHERE E.CUV2 = TF.CUV)
		   AND DATEDIFF(dd, GETDATE(), DATEADD(dd, op.DiaInicio, CAST(@FechaInicioFact AS date))) = 0
		ORDER BY
			op.Orden ASC, EstrategiaID ASC

	SET NOCOUNT OFF
END
GO

GO
USE BelcorpPuertoRico
GO

GO
-- exec ListarEstrategiasODD 201807, '000685941','2018-05-07'
ALTER PROCEDURE dbo.ListarEstrategiasODD
(
	 @CodCampania INT
	, @CodConsultora VARCHAR(10)
	, @FechaInicioFact DATE
)
AS
BEGIN
SET NOCOUNT ON
	DECLARE @StrCampaniaID char(6) = CONVERT(char(6), @CodCampania)
	DECLARE @EstrategiaCodigo varchar(100) = '009'

	DECLARE @tablaCuvFaltante TABLE (
	  CUV varchar(6)
	)
	DECLARE @OfertasPersonalizadas TABLE (
	  Orden int,
	  CUV char(6),
	  TipoPersonalizacion char(3),
	  FlagRevista int,
	  AnioCampanaVenta int,
	  DiaInicio INT
	)

	INSERT INTO @tablaCuvFaltante (CUV)
	  SELECT
		CUV
	  FROM dbo.ObtenerCuvFaltante (@CodCampania, @CodConsultora)
	DECLARE @codConsultoraForzada VARCHAR(9) = ''
	DECLARE @codConsultoraDefault VARCHAR(9) = ''
	SELECT @codConsultoraForzada = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10002
	SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001

	IF(@codConsultoraForzada <> @CodConsultora)
	BEGIN
		INSERT INTO @OfertasPersonalizadas
		SELECT
		ISNULL(Orden, 0),
		CUV,
		TipoPersonalizacion,
		FlagRevista,
		CONVERT(int, AnioCampanaVenta),
		DiaInicio
		FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
		WHERE op.CodConsultora = @CodConsultora
			AND op.AnioCampanaVenta = @StrCampaniaID
			AND op.TipoPersonalizacion = 'ODD'
		IF NOT EXISTS (SELECT   CUV  FROM @OfertasPersonalizadas)
		BEGIN
		  INSERT INTO @OfertasPersonalizadas
			SELECT
			  ISNULL(Orden, 0),
			  CUV,
			  TipoPersonalizacion,
			  FlagRevista,
			  CONVERT(int, AnioCampanaVenta),
			  DiaInicio
			FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
			WHERE op.CodConsultora = @codConsultoraDefault
				AND op.AnioCampanaVenta = @StrCampaniaID
				AND op.TipoPersonalizacion = 'ODD'
		END
	END

	IF(@codConsultoraDefault<>@CodConsultora)
	INSERT INTO @OfertasPersonalizadas(Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta, DiaInicio)
		SELECT Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta,DiaInicio
		FROM dbo.ListarEstrategiasForzadas(@CodCampania, @EstrategiaCodigo)
	SELECT
	 e.EstrategiaID,
		e.CodigoEstrategia,
		e.CUV2,
		e.DescripcionCUV2,
		e.Precio,
		e.Precio2,
		e.TipoEstrategiaID,
		e.ImagenURL AS FotoProducto01,
		te.ImagenEstrategia AS ImagenURL,
		e.LimiteVenta,
		e.TextoLibre,
		pc.MarcaID,
		m.Descripcion AS DescripcionMarca,
		pc.IndicadorMontoMinimo,
		pc.CodigoProducto,
		0 AS FlagNueva,
		6 AS TipoEstrategiaImagenMostrar,
		op.DiaInicio,
		op.Orden,
		te.DescripcionEstrategia AS DescripcionEstrategia
	FROM dbo.Estrategia E WITH (NOLOCK)
		  INNER JOIN @OfertasPersonalizadas op    ON E.CampaniaID = op.AnioCampanaVenta    AND E.CUV2 = op.CUV
		  INNER JOIN ods.ProductoComercial PC WITH (NOLOCK)    ON PC.CUV = E.CUV2    AND PC.AnoCampania = E.CampaniaID
		  INNER JOIN dbo.TipoEstrategia TE WITH (NOLOCK)    ON E.TipoEstrategiaID = TE.TipoEstrategiaID    AND TE.Codigo =@EstrategiaCodigo
		  LEFT JOIN dbo.Marca M WITH (NOLOCK)    ON M.MarcaId = PC.MarcaId
	  WHERE E.Activo = 1
		  AND TE.FlagActivo = 1
		  AND TE.flagRecoPerfil = 1
		  AND NOT EXISTS (SELECT    CUV  FROM @tablaCuvFaltante TF  WHERE E.CUV2 = TF.CUV)
		   AND DATEDIFF(dd, GETDATE(), DATEADD(dd, op.DiaInicio, CAST(@FechaInicioFact AS date))) = 0
		ORDER BY
			op.Orden ASC, EstrategiaID ASC

	SET NOCOUNT OFF
END
GO

GO
USE BelcorpPanama
GO

GO
-- exec ListarEstrategiasODD 201807, '000685941','2018-05-07'
ALTER PROCEDURE dbo.ListarEstrategiasODD
(
	 @CodCampania INT
	, @CodConsultora VARCHAR(10)
	, @FechaInicioFact DATE
)
AS
BEGIN
SET NOCOUNT ON
	DECLARE @StrCampaniaID char(6) = CONVERT(char(6), @CodCampania)
	DECLARE @EstrategiaCodigo varchar(100) = '009'

	DECLARE @tablaCuvFaltante TABLE (
	  CUV varchar(6)
	)
	DECLARE @OfertasPersonalizadas TABLE (
	  Orden int,
	  CUV char(6),
	  TipoPersonalizacion char(3),
	  FlagRevista int,
	  AnioCampanaVenta int,
	  DiaInicio INT
	)

	INSERT INTO @tablaCuvFaltante (CUV)
	  SELECT
		CUV
	  FROM dbo.ObtenerCuvFaltante (@CodCampania, @CodConsultora)
	DECLARE @codConsultoraForzada VARCHAR(9) = ''
	DECLARE @codConsultoraDefault VARCHAR(9) = ''
	SELECT @codConsultoraForzada = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10002
	SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001

	IF(@codConsultoraForzada <> @CodConsultora)
	BEGIN
		INSERT INTO @OfertasPersonalizadas
		SELECT
		ISNULL(Orden, 0),
		CUV,
		TipoPersonalizacion,
		FlagRevista,
		CONVERT(int, AnioCampanaVenta),
		DiaInicio
		FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
		WHERE op.CodConsultora = @CodConsultora
			AND op.AnioCampanaVenta = @StrCampaniaID
			AND op.TipoPersonalizacion = 'ODD'
		IF NOT EXISTS (SELECT   CUV  FROM @OfertasPersonalizadas)
		BEGIN
		  INSERT INTO @OfertasPersonalizadas
			SELECT
			  ISNULL(Orden, 0),
			  CUV,
			  TipoPersonalizacion,
			  FlagRevista,
			  CONVERT(int, AnioCampanaVenta),
			  DiaInicio
			FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
			WHERE op.CodConsultora = @codConsultoraDefault
				AND op.AnioCampanaVenta = @StrCampaniaID
				AND op.TipoPersonalizacion = 'ODD'
		END
	END

	IF(@codConsultoraDefault<>@CodConsultora)
	INSERT INTO @OfertasPersonalizadas(Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta, DiaInicio)
		SELECT Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta,DiaInicio
		FROM dbo.ListarEstrategiasForzadas(@CodCampania, @EstrategiaCodigo)
	SELECT
	 e.EstrategiaID,
		e.CodigoEstrategia,
		e.CUV2,
		e.DescripcionCUV2,
		e.Precio,
		e.Precio2,
		e.TipoEstrategiaID,
		e.ImagenURL AS FotoProducto01,
		te.ImagenEstrategia AS ImagenURL,
		e.LimiteVenta,
		e.TextoLibre,
		pc.MarcaID,
		m.Descripcion AS DescripcionMarca,
		pc.IndicadorMontoMinimo,
		pc.CodigoProducto,
		0 AS FlagNueva,
		6 AS TipoEstrategiaImagenMostrar,
		op.DiaInicio,
		op.Orden,
		te.DescripcionEstrategia AS DescripcionEstrategia
	FROM dbo.Estrategia E WITH (NOLOCK)
		  INNER JOIN @OfertasPersonalizadas op    ON E.CampaniaID = op.AnioCampanaVenta    AND E.CUV2 = op.CUV
		  INNER JOIN ods.ProductoComercial PC WITH (NOLOCK)    ON PC.CUV = E.CUV2    AND PC.AnoCampania = E.CampaniaID
		  INNER JOIN dbo.TipoEstrategia TE WITH (NOLOCK)    ON E.TipoEstrategiaID = TE.TipoEstrategiaID    AND TE.Codigo =@EstrategiaCodigo
		  LEFT JOIN dbo.Marca M WITH (NOLOCK)    ON M.MarcaId = PC.MarcaId
	  WHERE E.Activo = 1
		  AND TE.FlagActivo = 1
		  AND TE.flagRecoPerfil = 1
		  AND NOT EXISTS (SELECT    CUV  FROM @tablaCuvFaltante TF  WHERE E.CUV2 = TF.CUV)
		   AND DATEDIFF(dd, GETDATE(), DATEADD(dd, op.DiaInicio, CAST(@FechaInicioFact AS date))) = 0
		ORDER BY
			op.Orden ASC, EstrategiaID ASC

	SET NOCOUNT OFF
END
GO

GO
USE BelcorpGuatemala
GO

GO
-- exec ListarEstrategiasODD 201807, '000685941','2018-05-07'
ALTER PROCEDURE dbo.ListarEstrategiasODD
(
	 @CodCampania INT
	, @CodConsultora VARCHAR(10)
	, @FechaInicioFact DATE
)
AS
BEGIN
SET NOCOUNT ON
	DECLARE @StrCampaniaID char(6) = CONVERT(char(6), @CodCampania)
	DECLARE @EstrategiaCodigo varchar(100) = '009'

	DECLARE @tablaCuvFaltante TABLE (
	  CUV varchar(6)
	)
	DECLARE @OfertasPersonalizadas TABLE (
	  Orden int,
	  CUV char(6),
	  TipoPersonalizacion char(3),
	  FlagRevista int,
	  AnioCampanaVenta int,
	  DiaInicio INT
	)

	INSERT INTO @tablaCuvFaltante (CUV)
	  SELECT
		CUV
	  FROM dbo.ObtenerCuvFaltante (@CodCampania, @CodConsultora)
	DECLARE @codConsultoraForzada VARCHAR(9) = ''
	DECLARE @codConsultoraDefault VARCHAR(9) = ''
	SELECT @codConsultoraForzada = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10002
	SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001

	IF(@codConsultoraForzada <> @CodConsultora)
	BEGIN
		INSERT INTO @OfertasPersonalizadas
		SELECT
		ISNULL(Orden, 0),
		CUV,
		TipoPersonalizacion,
		FlagRevista,
		CONVERT(int, AnioCampanaVenta),
		DiaInicio
		FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
		WHERE op.CodConsultora = @CodConsultora
			AND op.AnioCampanaVenta = @StrCampaniaID
			AND op.TipoPersonalizacion = 'ODD'
		IF NOT EXISTS (SELECT   CUV  FROM @OfertasPersonalizadas)
		BEGIN
		  INSERT INTO @OfertasPersonalizadas
			SELECT
			  ISNULL(Orden, 0),
			  CUV,
			  TipoPersonalizacion,
			  FlagRevista,
			  CONVERT(int, AnioCampanaVenta),
			  DiaInicio
			FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
			WHERE op.CodConsultora = @codConsultoraDefault
				AND op.AnioCampanaVenta = @StrCampaniaID
				AND op.TipoPersonalizacion = 'ODD'
		END
	END

	IF(@codConsultoraDefault<>@CodConsultora)
	INSERT INTO @OfertasPersonalizadas(Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta, DiaInicio)
		SELECT Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta,DiaInicio
		FROM dbo.ListarEstrategiasForzadas(@CodCampania, @EstrategiaCodigo)
	SELECT
	 e.EstrategiaID,
		e.CodigoEstrategia,
		e.CUV2,
		e.DescripcionCUV2,
		e.Precio,
		e.Precio2,
		e.TipoEstrategiaID,
		e.ImagenURL AS FotoProducto01,
		te.ImagenEstrategia AS ImagenURL,
		e.LimiteVenta,
		e.TextoLibre,
		pc.MarcaID,
		m.Descripcion AS DescripcionMarca,
		pc.IndicadorMontoMinimo,
		pc.CodigoProducto,
		0 AS FlagNueva,
		6 AS TipoEstrategiaImagenMostrar,
		op.DiaInicio,
		op.Orden,
		te.DescripcionEstrategia AS DescripcionEstrategia
	FROM dbo.Estrategia E WITH (NOLOCK)
		  INNER JOIN @OfertasPersonalizadas op    ON E.CampaniaID = op.AnioCampanaVenta    AND E.CUV2 = op.CUV
		  INNER JOIN ods.ProductoComercial PC WITH (NOLOCK)    ON PC.CUV = E.CUV2    AND PC.AnoCampania = E.CampaniaID
		  INNER JOIN dbo.TipoEstrategia TE WITH (NOLOCK)    ON E.TipoEstrategiaID = TE.TipoEstrategiaID    AND TE.Codigo =@EstrategiaCodigo
		  LEFT JOIN dbo.Marca M WITH (NOLOCK)    ON M.MarcaId = PC.MarcaId
	  WHERE E.Activo = 1
		  AND TE.FlagActivo = 1
		  AND TE.flagRecoPerfil = 1
		  AND NOT EXISTS (SELECT    CUV  FROM @tablaCuvFaltante TF  WHERE E.CUV2 = TF.CUV)
		   AND DATEDIFF(dd, GETDATE(), DATEADD(dd, op.DiaInicio, CAST(@FechaInicioFact AS date))) = 0
		ORDER BY
			op.Orden ASC, EstrategiaID ASC

	SET NOCOUNT OFF
END
GO

GO
USE BelcorpEcuador
GO

GO
-- exec ListarEstrategiasODD 201807, '000685941','2018-05-07'
ALTER PROCEDURE dbo.ListarEstrategiasODD
(
	 @CodCampania INT
	, @CodConsultora VARCHAR(10)
	, @FechaInicioFact DATE
)
AS
BEGIN
SET NOCOUNT ON
	DECLARE @StrCampaniaID char(6) = CONVERT(char(6), @CodCampania)
	DECLARE @EstrategiaCodigo varchar(100) = '009'

	DECLARE @tablaCuvFaltante TABLE (
	  CUV varchar(6)
	)
	DECLARE @OfertasPersonalizadas TABLE (
	  Orden int,
	  CUV char(6),
	  TipoPersonalizacion char(3),
	  FlagRevista int,
	  AnioCampanaVenta int,
	  DiaInicio INT
	)

	INSERT INTO @tablaCuvFaltante (CUV)
	  SELECT
		CUV
	  FROM dbo.ObtenerCuvFaltante (@CodCampania, @CodConsultora)
	DECLARE @codConsultoraForzada VARCHAR(9) = ''
	DECLARE @codConsultoraDefault VARCHAR(9) = ''
	SELECT @codConsultoraForzada = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10002
	SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001

	IF(@codConsultoraForzada <> @CodConsultora)
	BEGIN
		INSERT INTO @OfertasPersonalizadas
		SELECT
		ISNULL(Orden, 0),
		CUV,
		TipoPersonalizacion,
		FlagRevista,
		CONVERT(int, AnioCampanaVenta),
		DiaInicio
		FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
		WHERE op.CodConsultora = @CodConsultora
			AND op.AnioCampanaVenta = @StrCampaniaID
			AND op.TipoPersonalizacion = 'ODD'
		IF NOT EXISTS (SELECT   CUV  FROM @OfertasPersonalizadas)
		BEGIN
		  INSERT INTO @OfertasPersonalizadas
			SELECT
			  ISNULL(Orden, 0),
			  CUV,
			  TipoPersonalizacion,
			  FlagRevista,
			  CONVERT(int, AnioCampanaVenta),
			  DiaInicio
			FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
			WHERE op.CodConsultora = @codConsultoraDefault
				AND op.AnioCampanaVenta = @StrCampaniaID
				AND op.TipoPersonalizacion = 'ODD'
		END
	END

	IF(@codConsultoraDefault<>@CodConsultora)
	INSERT INTO @OfertasPersonalizadas(Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta, DiaInicio)
		SELECT Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta,DiaInicio
		FROM dbo.ListarEstrategiasForzadas(@CodCampania, @EstrategiaCodigo)
	SELECT
	 e.EstrategiaID,
		e.CodigoEstrategia,
		e.CUV2,
		e.DescripcionCUV2,
		e.Precio,
		e.Precio2,
		e.TipoEstrategiaID,
		e.ImagenURL AS FotoProducto01,
		te.ImagenEstrategia AS ImagenURL,
		e.LimiteVenta,
		e.TextoLibre,
		pc.MarcaID,
		m.Descripcion AS DescripcionMarca,
		pc.IndicadorMontoMinimo,
		pc.CodigoProducto,
		0 AS FlagNueva,
		6 AS TipoEstrategiaImagenMostrar,
		op.DiaInicio,
		op.Orden,
		te.DescripcionEstrategia AS DescripcionEstrategia
	FROM dbo.Estrategia E WITH (NOLOCK)
		  INNER JOIN @OfertasPersonalizadas op    ON E.CampaniaID = op.AnioCampanaVenta    AND E.CUV2 = op.CUV
		  INNER JOIN ods.ProductoComercial PC WITH (NOLOCK)    ON PC.CUV = E.CUV2    AND PC.AnoCampania = E.CampaniaID
		  INNER JOIN dbo.TipoEstrategia TE WITH (NOLOCK)    ON E.TipoEstrategiaID = TE.TipoEstrategiaID    AND TE.Codigo =@EstrategiaCodigo
		  LEFT JOIN dbo.Marca M WITH (NOLOCK)    ON M.MarcaId = PC.MarcaId
	  WHERE E.Activo = 1
		  AND TE.FlagActivo = 1
		  AND TE.flagRecoPerfil = 1
		  AND NOT EXISTS (SELECT    CUV  FROM @tablaCuvFaltante TF  WHERE E.CUV2 = TF.CUV)
		   AND DATEDIFF(dd, GETDATE(), DATEADD(dd, op.DiaInicio, CAST(@FechaInicioFact AS date))) = 0
		ORDER BY
			op.Orden ASC, EstrategiaID ASC

	SET NOCOUNT OFF
END
GO

GO
USE BelcorpDominicana
GO

GO
-- exec ListarEstrategiasODD 201807, '000685941','2018-05-07'
ALTER PROCEDURE dbo.ListarEstrategiasODD
(
	 @CodCampania INT
	, @CodConsultora VARCHAR(10)
	, @FechaInicioFact DATE
)
AS
BEGIN
SET NOCOUNT ON
	DECLARE @StrCampaniaID char(6) = CONVERT(char(6), @CodCampania)
	DECLARE @EstrategiaCodigo varchar(100) = '009'

	DECLARE @tablaCuvFaltante TABLE (
	  CUV varchar(6)
	)
	DECLARE @OfertasPersonalizadas TABLE (
	  Orden int,
	  CUV char(6),
	  TipoPersonalizacion char(3),
	  FlagRevista int,
	  AnioCampanaVenta int,
	  DiaInicio INT
	)

	INSERT INTO @tablaCuvFaltante (CUV)
	  SELECT
		CUV
	  FROM dbo.ObtenerCuvFaltante (@CodCampania, @CodConsultora)
	DECLARE @codConsultoraForzada VARCHAR(9) = ''
	DECLARE @codConsultoraDefault VARCHAR(9) = ''
	SELECT @codConsultoraForzada = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10002
	SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001

	IF(@codConsultoraForzada <> @CodConsultora)
	BEGIN
		INSERT INTO @OfertasPersonalizadas
		SELECT
		ISNULL(Orden, 0),
		CUV,
		TipoPersonalizacion,
		FlagRevista,
		CONVERT(int, AnioCampanaVenta),
		DiaInicio
		FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
		WHERE op.CodConsultora = @CodConsultora
			AND op.AnioCampanaVenta = @StrCampaniaID
			AND op.TipoPersonalizacion = 'ODD'
		IF NOT EXISTS (SELECT   CUV  FROM @OfertasPersonalizadas)
		BEGIN
		  INSERT INTO @OfertasPersonalizadas
			SELECT
			  ISNULL(Orden, 0),
			  CUV,
			  TipoPersonalizacion,
			  FlagRevista,
			  CONVERT(int, AnioCampanaVenta),
			  DiaInicio
			FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
			WHERE op.CodConsultora = @codConsultoraDefault
				AND op.AnioCampanaVenta = @StrCampaniaID
				AND op.TipoPersonalizacion = 'ODD'
		END
	END

	IF(@codConsultoraDefault<>@CodConsultora)
	INSERT INTO @OfertasPersonalizadas(Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta, DiaInicio)
		SELECT Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta,DiaInicio
		FROM dbo.ListarEstrategiasForzadas(@CodCampania, @EstrategiaCodigo)
	SELECT
	 e.EstrategiaID,
		e.CodigoEstrategia,
		e.CUV2,
		e.DescripcionCUV2,
		e.Precio,
		e.Precio2,
		e.TipoEstrategiaID,
		e.ImagenURL AS FotoProducto01,
		te.ImagenEstrategia AS ImagenURL,
		e.LimiteVenta,
		e.TextoLibre,
		pc.MarcaID,
		m.Descripcion AS DescripcionMarca,
		pc.IndicadorMontoMinimo,
		pc.CodigoProducto,
		0 AS FlagNueva,
		6 AS TipoEstrategiaImagenMostrar,
		op.DiaInicio,
		op.Orden,
		te.DescripcionEstrategia AS DescripcionEstrategia
	FROM dbo.Estrategia E WITH (NOLOCK)
		  INNER JOIN @OfertasPersonalizadas op    ON E.CampaniaID = op.AnioCampanaVenta    AND E.CUV2 = op.CUV
		  INNER JOIN ods.ProductoComercial PC WITH (NOLOCK)    ON PC.CUV = E.CUV2    AND PC.AnoCampania = E.CampaniaID
		  INNER JOIN dbo.TipoEstrategia TE WITH (NOLOCK)    ON E.TipoEstrategiaID = TE.TipoEstrategiaID    AND TE.Codigo =@EstrategiaCodigo
		  LEFT JOIN dbo.Marca M WITH (NOLOCK)    ON M.MarcaId = PC.MarcaId
	  WHERE E.Activo = 1
		  AND TE.FlagActivo = 1
		  AND TE.flagRecoPerfil = 1
		  AND NOT EXISTS (SELECT    CUV  FROM @tablaCuvFaltante TF  WHERE E.CUV2 = TF.CUV)
		   AND DATEDIFF(dd, GETDATE(), DATEADD(dd, op.DiaInicio, CAST(@FechaInicioFact AS date))) = 0
		ORDER BY
			op.Orden ASC, EstrategiaID ASC

	SET NOCOUNT OFF
END
GO

GO
USE BelcorpCostaRica
GO

GO
-- exec ListarEstrategiasODD 201807, '000685941','2018-05-07'
ALTER PROCEDURE dbo.ListarEstrategiasODD
(
	 @CodCampania INT
	, @CodConsultora VARCHAR(10)
	, @FechaInicioFact DATE
)
AS
BEGIN
SET NOCOUNT ON
	DECLARE @StrCampaniaID char(6) = CONVERT(char(6), @CodCampania)
	DECLARE @EstrategiaCodigo varchar(100) = '009'

	DECLARE @tablaCuvFaltante TABLE (
	  CUV varchar(6)
	)
	DECLARE @OfertasPersonalizadas TABLE (
	  Orden int,
	  CUV char(6),
	  TipoPersonalizacion char(3),
	  FlagRevista int,
	  AnioCampanaVenta int,
	  DiaInicio INT
	)

	INSERT INTO @tablaCuvFaltante (CUV)
	  SELECT
		CUV
	  FROM dbo.ObtenerCuvFaltante (@CodCampania, @CodConsultora)
	DECLARE @codConsultoraForzada VARCHAR(9) = ''
	DECLARE @codConsultoraDefault VARCHAR(9) = ''
	SELECT @codConsultoraForzada = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10002
	SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001

	IF(@codConsultoraForzada <> @CodConsultora)
	BEGIN
		INSERT INTO @OfertasPersonalizadas
		SELECT
		ISNULL(Orden, 0),
		CUV,
		TipoPersonalizacion,
		FlagRevista,
		CONVERT(int, AnioCampanaVenta),
		DiaInicio
		FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
		WHERE op.CodConsultora = @CodConsultora
			AND op.AnioCampanaVenta = @StrCampaniaID
			AND op.TipoPersonalizacion = 'ODD'
		IF NOT EXISTS (SELECT   CUV  FROM @OfertasPersonalizadas)
		BEGIN
		  INSERT INTO @OfertasPersonalizadas
			SELECT
			  ISNULL(Orden, 0),
			  CUV,
			  TipoPersonalizacion,
			  FlagRevista,
			  CONVERT(int, AnioCampanaVenta),
			  DiaInicio
			FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
			WHERE op.CodConsultora = @codConsultoraDefault
				AND op.AnioCampanaVenta = @StrCampaniaID
				AND op.TipoPersonalizacion = 'ODD'
		END
	END

	IF(@codConsultoraDefault<>@CodConsultora)
	INSERT INTO @OfertasPersonalizadas(Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta, DiaInicio)
		SELECT Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta,DiaInicio
		FROM dbo.ListarEstrategiasForzadas(@CodCampania, @EstrategiaCodigo)
	SELECT
	 e.EstrategiaID,
		e.CodigoEstrategia,
		e.CUV2,
		e.DescripcionCUV2,
		e.Precio,
		e.Precio2,
		e.TipoEstrategiaID,
		e.ImagenURL AS FotoProducto01,
		te.ImagenEstrategia AS ImagenURL,
		e.LimiteVenta,
		e.TextoLibre,
		pc.MarcaID,
		m.Descripcion AS DescripcionMarca,
		pc.IndicadorMontoMinimo,
		pc.CodigoProducto,
		0 AS FlagNueva,
		6 AS TipoEstrategiaImagenMostrar,
		op.DiaInicio,
		op.Orden,
		te.DescripcionEstrategia AS DescripcionEstrategia
	FROM dbo.Estrategia E WITH (NOLOCK)
		  INNER JOIN @OfertasPersonalizadas op    ON E.CampaniaID = op.AnioCampanaVenta    AND E.CUV2 = op.CUV
		  INNER JOIN ods.ProductoComercial PC WITH (NOLOCK)    ON PC.CUV = E.CUV2    AND PC.AnoCampania = E.CampaniaID
		  INNER JOIN dbo.TipoEstrategia TE WITH (NOLOCK)    ON E.TipoEstrategiaID = TE.TipoEstrategiaID    AND TE.Codigo =@EstrategiaCodigo
		  LEFT JOIN dbo.Marca M WITH (NOLOCK)    ON M.MarcaId = PC.MarcaId
	  WHERE E.Activo = 1
		  AND TE.FlagActivo = 1
		  AND TE.flagRecoPerfil = 1
		  AND NOT EXISTS (SELECT    CUV  FROM @tablaCuvFaltante TF  WHERE E.CUV2 = TF.CUV)
		   AND DATEDIFF(dd, GETDATE(), DATEADD(dd, op.DiaInicio, CAST(@FechaInicioFact AS date))) = 0
		ORDER BY
			op.Orden ASC, EstrategiaID ASC

	SET NOCOUNT OFF
END
GO

GO
USE BelcorpChile
GO

GO
-- exec ListarEstrategiasODD 201807, '000685941','2018-05-07'
ALTER PROCEDURE dbo.ListarEstrategiasODD
(
	 @CodCampania INT
	, @CodConsultora VARCHAR(10)
	, @FechaInicioFact DATE
)
AS
BEGIN
SET NOCOUNT ON
	DECLARE @StrCampaniaID char(6) = CONVERT(char(6), @CodCampania)
	DECLARE @EstrategiaCodigo varchar(100) = '009'

	DECLARE @tablaCuvFaltante TABLE (
	  CUV varchar(6)
	)
	DECLARE @OfertasPersonalizadas TABLE (
	  Orden int,
	  CUV char(6),
	  TipoPersonalizacion char(3),
	  FlagRevista int,
	  AnioCampanaVenta int,
	  DiaInicio INT
	)

	INSERT INTO @tablaCuvFaltante (CUV)
	  SELECT
		CUV
	  FROM dbo.ObtenerCuvFaltante (@CodCampania, @CodConsultora)
	DECLARE @codConsultoraForzada VARCHAR(9) = ''
	DECLARE @codConsultoraDefault VARCHAR(9) = ''
	SELECT @codConsultoraForzada = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10002
	SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001

	IF(@codConsultoraForzada <> @CodConsultora)
	BEGIN
		INSERT INTO @OfertasPersonalizadas
		SELECT
		ISNULL(Orden, 0),
		CUV,
		TipoPersonalizacion,
		FlagRevista,
		CONVERT(int, AnioCampanaVenta),
		DiaInicio
		FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
		WHERE op.CodConsultora = @CodConsultora
			AND op.AnioCampanaVenta = @StrCampaniaID
			AND op.TipoPersonalizacion = 'ODD'
		IF NOT EXISTS (SELECT   CUV  FROM @OfertasPersonalizadas)
		BEGIN
		  INSERT INTO @OfertasPersonalizadas
			SELECT
			  ISNULL(Orden, 0),
			  CUV,
			  TipoPersonalizacion,
			  FlagRevista,
			  CONVERT(int, AnioCampanaVenta),
			  DiaInicio
			FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
			WHERE op.CodConsultora = @codConsultoraDefault
				AND op.AnioCampanaVenta = @StrCampaniaID
				AND op.TipoPersonalizacion = 'ODD'
		END
	END

	IF(@codConsultoraDefault<>@CodConsultora)
	INSERT INTO @OfertasPersonalizadas(Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta, DiaInicio)
		SELECT Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta,DiaInicio
		FROM dbo.ListarEstrategiasForzadas(@CodCampania, @EstrategiaCodigo)
	SELECT
	 e.EstrategiaID,
		e.CodigoEstrategia,
		e.CUV2,
		e.DescripcionCUV2,
		e.Precio,
		e.Precio2,
		e.TipoEstrategiaID,
		e.ImagenURL AS FotoProducto01,
		te.ImagenEstrategia AS ImagenURL,
		e.LimiteVenta,
		e.TextoLibre,
		pc.MarcaID,
		m.Descripcion AS DescripcionMarca,
		pc.IndicadorMontoMinimo,
		pc.CodigoProducto,
		0 AS FlagNueva,
		6 AS TipoEstrategiaImagenMostrar,
		op.DiaInicio,
		op.Orden,
		te.DescripcionEstrategia AS DescripcionEstrategia
	FROM dbo.Estrategia E WITH (NOLOCK)
		  INNER JOIN @OfertasPersonalizadas op    ON E.CampaniaID = op.AnioCampanaVenta    AND E.CUV2 = op.CUV
		  INNER JOIN ods.ProductoComercial PC WITH (NOLOCK)    ON PC.CUV = E.CUV2    AND PC.AnoCampania = E.CampaniaID
		  INNER JOIN dbo.TipoEstrategia TE WITH (NOLOCK)    ON E.TipoEstrategiaID = TE.TipoEstrategiaID    AND TE.Codigo =@EstrategiaCodigo
		  LEFT JOIN dbo.Marca M WITH (NOLOCK)    ON M.MarcaId = PC.MarcaId
	  WHERE E.Activo = 1
		  AND TE.FlagActivo = 1
		  AND TE.flagRecoPerfil = 1
		  AND NOT EXISTS (SELECT    CUV  FROM @tablaCuvFaltante TF  WHERE E.CUV2 = TF.CUV)
		   AND DATEDIFF(dd, GETDATE(), DATEADD(dd, op.DiaInicio, CAST(@FechaInicioFact AS date))) = 0
		ORDER BY
			op.Orden ASC, EstrategiaID ASC

	SET NOCOUNT OFF
END
GO

GO
USE BelcorpBolivia
GO

GO
-- exec ListarEstrategiasODD 201807, '000685941','2018-05-07'
ALTER PROCEDURE dbo.ListarEstrategiasODD
(
	 @CodCampania INT
	, @CodConsultora VARCHAR(10)
	, @FechaInicioFact DATE
)
AS
BEGIN
SET NOCOUNT ON
	DECLARE @StrCampaniaID char(6) = CONVERT(char(6), @CodCampania)
	DECLARE @EstrategiaCodigo varchar(100) = '009'

	DECLARE @tablaCuvFaltante TABLE (
	  CUV varchar(6)
	)
	DECLARE @OfertasPersonalizadas TABLE (
	  Orden int,
	  CUV char(6),
	  TipoPersonalizacion char(3),
	  FlagRevista int,
	  AnioCampanaVenta int,
	  DiaInicio INT
	)

	INSERT INTO @tablaCuvFaltante (CUV)
	  SELECT
		CUV
	  FROM dbo.ObtenerCuvFaltante (@CodCampania, @CodConsultora)
	DECLARE @codConsultoraForzada VARCHAR(9) = ''
	DECLARE @codConsultoraDefault VARCHAR(9) = ''
	SELECT @codConsultoraForzada = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10002
	SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001

	IF(@codConsultoraForzada <> @CodConsultora)
	BEGIN
		INSERT INTO @OfertasPersonalizadas
		SELECT
		ISNULL(Orden, 0),
		CUV,
		TipoPersonalizacion,
		FlagRevista,
		CONVERT(int, AnioCampanaVenta),
		DiaInicio
		FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
		WHERE op.CodConsultora = @CodConsultora
			AND op.AnioCampanaVenta = @StrCampaniaID
			AND op.TipoPersonalizacion = 'ODD'
		IF NOT EXISTS (SELECT   CUV  FROM @OfertasPersonalizadas)
		BEGIN
		  INSERT INTO @OfertasPersonalizadas
			SELECT
			  ISNULL(Orden, 0),
			  CUV,
			  TipoPersonalizacion,
			  FlagRevista,
			  CONVERT(int, AnioCampanaVenta),
			  DiaInicio
			FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
			WHERE op.CodConsultora = @codConsultoraDefault
				AND op.AnioCampanaVenta = @StrCampaniaID
				AND op.TipoPersonalizacion = 'ODD'
		END
	END

	IF(@codConsultoraDefault<>@CodConsultora)
	INSERT INTO @OfertasPersonalizadas(Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta, DiaInicio)
		SELECT Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta,DiaInicio
		FROM dbo.ListarEstrategiasForzadas(@CodCampania, @EstrategiaCodigo)
	SELECT
	 e.EstrategiaID,
		e.CodigoEstrategia,
		e.CUV2,
		e.DescripcionCUV2,
		e.Precio,
		e.Precio2,
		e.TipoEstrategiaID,
		e.ImagenURL AS FotoProducto01,
		te.ImagenEstrategia AS ImagenURL,
		e.LimiteVenta,
		e.TextoLibre,
		pc.MarcaID,
		m.Descripcion AS DescripcionMarca,
		pc.IndicadorMontoMinimo,
		pc.CodigoProducto,
		0 AS FlagNueva,
		6 AS TipoEstrategiaImagenMostrar,
		op.DiaInicio,
		op.Orden,
		te.DescripcionEstrategia AS DescripcionEstrategia
	FROM dbo.Estrategia E WITH (NOLOCK)
		  INNER JOIN @OfertasPersonalizadas op    ON E.CampaniaID = op.AnioCampanaVenta    AND E.CUV2 = op.CUV
		  INNER JOIN ods.ProductoComercial PC WITH (NOLOCK)    ON PC.CUV = E.CUV2    AND PC.AnoCampania = E.CampaniaID
		  INNER JOIN dbo.TipoEstrategia TE WITH (NOLOCK)    ON E.TipoEstrategiaID = TE.TipoEstrategiaID    AND TE.Codigo =@EstrategiaCodigo
		  LEFT JOIN dbo.Marca M WITH (NOLOCK)    ON M.MarcaId = PC.MarcaId
	  WHERE E.Activo = 1
		  AND TE.FlagActivo = 1
		  AND TE.flagRecoPerfil = 1
		  AND NOT EXISTS (SELECT    CUV  FROM @tablaCuvFaltante TF  WHERE E.CUV2 = TF.CUV)
		   AND DATEDIFF(dd, GETDATE(), DATEADD(dd, op.DiaInicio, CAST(@FechaInicioFact AS date))) = 0
		ORDER BY
			op.Orden ASC, EstrategiaID ASC

	SET NOCOUNT OFF
END
GO

GO
