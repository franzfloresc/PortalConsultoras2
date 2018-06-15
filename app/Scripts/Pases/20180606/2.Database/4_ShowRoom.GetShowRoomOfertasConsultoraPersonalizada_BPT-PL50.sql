GO
USE BelcorpPeru
GO

GO
 -- exec ShowRoom.GetShowRoomOfertasConsultoraPersonalizada 201807, '000001740'
ALTER PROCEDURE ShowRoom.GetShowRoomOfertasConsultoraPersonalizada
  @CampaniaID INT
 ,@CodigoConsultora VARCHAR(20)
AS
BEGIN
 SET NOCOUNT ON
	DECLARE @StrCampaniaID char(6) = CONVERT(char(6), @CampaniaID)
	DECLARE @EstrategiaCodigo varchar(100) = '030'
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
	SELECT CUV FROM dbo.ObtenerCuvFaltante (@CampaniaID, @CodigoConsultora)

	DECLARE @codConsultoraDefault VARCHAR(9) = ''
	SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001
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
		AND TipoPersonalizacion = 'SR'

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
			AND op.TipoPersonalizacion = 'SR'
	END
	INSERT INTO @OfertasPersonalizadas(Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta)
		SELECT Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta
		FROM dbo.ListarEstrategiasForzadas(@CampaniaID, @EstrategiaCodigo)

	SELECT
		e.EstrategiaID
	  ,e.CUV2 AS CUV
	  ,e.DescripcionCUV2 AS Descripcion
	  ,e.Precio AS PrecioValorizado --tachado
	  ,COALESCE(e.Precio2, pc.PrecioCatalogo) AS PrecioOferta
	  ,e.Cantidad AS Stock
	  ,e.ImagenURL AS ImagenProducto
	  ,e.LimiteVenta AS UnidadesPermitidas
	  ,e.Activo AS FlagHabilitarProducto
	  ,e.UsuarioCreacion AS UsuarioRegistro
	  ,e.FechaCreacion AS FechaRegistro
	  ,e.UsuarioModificacion
	  ,e.FechaModificacion
	  ,e.ImagenMiniaturaURL AS ImagenMini
	  ,pc.MarcaID
	  ,op.Orden
	  ,e.TextoLibre AS TipNegocio
	  ,pc.CodigoProducto
	  ,e.EsSubCampania
	  , ISNULL(e.CodigoEstrategia,0) AS 'CodigoEstrategia'
	  ,ISNULL(e.TieneVariedad,0) AS 'TieneVariedad'
	  ,e.TipoEstrategiaId AS ConfiguracionOfertaID
	  ,op.FlagRevista
	FROM dbo.Estrategia E WITH (NOLOCK)
		INNER JOIN @OfertasPersonalizadas op
			ON E.CampaniaID = op.AnioCampanaVenta
			AND E.CUV2 = op.CUV
		INNER JOIN ods.ProductoComercial PC WITH (NOLOCK)
			ON PC.CUV = E.CUV2
			AND PC.AnoCampania = E.CampaniaID
		INNER JOIN dbo.vwEstrategiaShowRoomEquivalencia ves
			ON e.TipoEstrategiaId = ves.TipoEstrategiaID
		LEFT JOIN dbo.Marca M WITH (NOLOCK)
			ON M.MarcaId = PC.MarcaId
	WHERE E.Activo = 1
		AND NOT EXISTS (SELECT CUV FROM @tablaCuvFaltante TF WHERE E.CUV2 = TF.CUV)
	ORDER BY op.Orden ASC, EstrategiaID ASC
SET NOCOUNT OFF
END
GO


GO
USE BelcorpMexico
GO

GO
 -- exec ShowRoom.GetShowRoomOfertasConsultoraPersonalizada 201807, '000001740'
ALTER PROCEDURE ShowRoom.GetShowRoomOfertasConsultoraPersonalizada
  @CampaniaID INT
 ,@CodigoConsultora VARCHAR(20)
AS
BEGIN
 SET NOCOUNT ON
	DECLARE @StrCampaniaID char(6) = CONVERT(char(6), @CampaniaID)
	DECLARE @EstrategiaCodigo varchar(100) = '030'
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
	SELECT CUV FROM dbo.ObtenerCuvFaltante (@CampaniaID, @CodigoConsultora)

	DECLARE @codConsultoraDefault VARCHAR(9) = ''
	SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001
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
		AND TipoPersonalizacion = 'SR'

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
			AND op.TipoPersonalizacion = 'SR'
	END
	INSERT INTO @OfertasPersonalizadas(Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta)
		SELECT Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta
		FROM dbo.ListarEstrategiasForzadas(@CampaniaID, @EstrategiaCodigo)

	SELECT
		e.EstrategiaID
	  ,e.CUV2 AS CUV
	  ,e.DescripcionCUV2 AS Descripcion
	  ,e.Precio AS PrecioValorizado --tachado
	  ,COALESCE(e.Precio2, pc.PrecioCatalogo) AS PrecioOferta
	  ,e.Cantidad AS Stock
	  ,e.ImagenURL AS ImagenProducto
	  ,e.LimiteVenta AS UnidadesPermitidas
	  ,e.Activo AS FlagHabilitarProducto
	  ,e.UsuarioCreacion AS UsuarioRegistro
	  ,e.FechaCreacion AS FechaRegistro
	  ,e.UsuarioModificacion
	  ,e.FechaModificacion
	  ,e.ImagenMiniaturaURL AS ImagenMini
	  ,pc.MarcaID
	  ,op.Orden
	  ,e.TextoLibre AS TipNegocio
	  ,pc.CodigoProducto
	  ,e.EsSubCampania
	  , ISNULL(e.CodigoEstrategia,0) AS 'CodigoEstrategia'
	  ,ISNULL(e.TieneVariedad,0) AS 'TieneVariedad'
	  ,e.TipoEstrategiaId AS ConfiguracionOfertaID
	  ,op.FlagRevista
	FROM dbo.Estrategia E WITH (NOLOCK)
		INNER JOIN @OfertasPersonalizadas op
			ON E.CampaniaID = op.AnioCampanaVenta
			AND E.CUV2 = op.CUV
		INNER JOIN ods.ProductoComercial PC WITH (NOLOCK)
			ON PC.CUV = E.CUV2
			AND PC.AnoCampania = E.CampaniaID
		INNER JOIN dbo.vwEstrategiaShowRoomEquivalencia ves
			ON e.TipoEstrategiaId = ves.TipoEstrategiaID
		LEFT JOIN dbo.Marca M WITH (NOLOCK)
			ON M.MarcaId = PC.MarcaId
	WHERE E.Activo = 1
		AND NOT EXISTS (SELECT CUV FROM @tablaCuvFaltante TF WHERE E.CUV2 = TF.CUV)
	ORDER BY op.Orden ASC, EstrategiaID ASC
SET NOCOUNT OFF
END
GO


GO
USE BelcorpColombia
GO

GO
 -- exec ShowRoom.GetShowRoomOfertasConsultoraPersonalizada 201807, '000001740'
ALTER PROCEDURE ShowRoom.GetShowRoomOfertasConsultoraPersonalizada
  @CampaniaID INT
 ,@CodigoConsultora VARCHAR(20)
AS
BEGIN
 SET NOCOUNT ON
	DECLARE @StrCampaniaID char(6) = CONVERT(char(6), @CampaniaID)
	DECLARE @EstrategiaCodigo varchar(100) = '030'
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
	SELECT CUV FROM dbo.ObtenerCuvFaltante (@CampaniaID, @CodigoConsultora)

	DECLARE @codConsultoraDefault VARCHAR(9) = ''
	SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001
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
		AND TipoPersonalizacion = 'SR'

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
			AND op.TipoPersonalizacion = 'SR'
	END
	INSERT INTO @OfertasPersonalizadas(Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta)
		SELECT Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta
		FROM dbo.ListarEstrategiasForzadas(@CampaniaID, @EstrategiaCodigo)

	SELECT
		e.EstrategiaID
	  ,e.CUV2 AS CUV
	  ,e.DescripcionCUV2 AS Descripcion
	  ,e.Precio AS PrecioValorizado --tachado
	  ,COALESCE(e.Precio2, pc.PrecioCatalogo) AS PrecioOferta
	  ,e.Cantidad AS Stock
	  ,e.ImagenURL AS ImagenProducto
	  ,e.LimiteVenta AS UnidadesPermitidas
	  ,e.Activo AS FlagHabilitarProducto
	  ,e.UsuarioCreacion AS UsuarioRegistro
	  ,e.FechaCreacion AS FechaRegistro
	  ,e.UsuarioModificacion
	  ,e.FechaModificacion
	  ,e.ImagenMiniaturaURL AS ImagenMini
	  ,pc.MarcaID
	  ,op.Orden
	  ,e.TextoLibre AS TipNegocio
	  ,pc.CodigoProducto
	  ,e.EsSubCampania
	  , ISNULL(e.CodigoEstrategia,0) AS 'CodigoEstrategia'
	  ,ISNULL(e.TieneVariedad,0) AS 'TieneVariedad'
	  ,e.TipoEstrategiaId AS ConfiguracionOfertaID
	  ,op.FlagRevista
	FROM dbo.Estrategia E WITH (NOLOCK)
		INNER JOIN @OfertasPersonalizadas op
			ON E.CampaniaID = op.AnioCampanaVenta
			AND E.CUV2 = op.CUV
		INNER JOIN ods.ProductoComercial PC WITH (NOLOCK)
			ON PC.CUV = E.CUV2
			AND PC.AnoCampania = E.CampaniaID
		INNER JOIN dbo.vwEstrategiaShowRoomEquivalencia ves
			ON e.TipoEstrategiaId = ves.TipoEstrategiaID
		LEFT JOIN dbo.Marca M WITH (NOLOCK)
			ON M.MarcaId = PC.MarcaId
	WHERE E.Activo = 1
		AND NOT EXISTS (SELECT CUV FROM @tablaCuvFaltante TF WHERE E.CUV2 = TF.CUV)
	ORDER BY op.Orden ASC, EstrategiaID ASC
SET NOCOUNT OFF
END
GO


GO
USE BelcorpSalvador
GO

GO
 -- exec ShowRoom.GetShowRoomOfertasConsultoraPersonalizada 201807, '000001740'
ALTER PROCEDURE ShowRoom.GetShowRoomOfertasConsultoraPersonalizada
  @CampaniaID INT
 ,@CodigoConsultora VARCHAR(20)
AS
BEGIN
 SET NOCOUNT ON
	DECLARE @StrCampaniaID char(6) = CONVERT(char(6), @CampaniaID)
	DECLARE @EstrategiaCodigo varchar(100) = '030'
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
	SELECT CUV FROM dbo.ObtenerCuvFaltante (@CampaniaID, @CodigoConsultora)

	DECLARE @codConsultoraDefault VARCHAR(9) = ''
	SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001
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
		AND TipoPersonalizacion = 'SR'

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
			AND op.TipoPersonalizacion = 'SR'
	END
	INSERT INTO @OfertasPersonalizadas(Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta)
		SELECT Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta
		FROM dbo.ListarEstrategiasForzadas(@CampaniaID, @EstrategiaCodigo)

	SELECT
		e.EstrategiaID
	  ,e.CUV2 AS CUV
	  ,e.DescripcionCUV2 AS Descripcion
	  ,e.Precio AS PrecioValorizado --tachado
	  ,COALESCE(e.Precio2, pc.PrecioCatalogo) AS PrecioOferta
	  ,e.Cantidad AS Stock
	  ,e.ImagenURL AS ImagenProducto
	  ,e.LimiteVenta AS UnidadesPermitidas
	  ,e.Activo AS FlagHabilitarProducto
	  ,e.UsuarioCreacion AS UsuarioRegistro
	  ,e.FechaCreacion AS FechaRegistro
	  ,e.UsuarioModificacion
	  ,e.FechaModificacion
	  ,e.ImagenMiniaturaURL AS ImagenMini
	  ,pc.MarcaID
	  ,op.Orden
	  ,e.TextoLibre AS TipNegocio
	  ,pc.CodigoProducto
	  ,e.EsSubCampania
	  , ISNULL(e.CodigoEstrategia,0) AS 'CodigoEstrategia'
	  ,ISNULL(e.TieneVariedad,0) AS 'TieneVariedad'
	  ,e.TipoEstrategiaId AS ConfiguracionOfertaID
	  ,op.FlagRevista
	FROM dbo.Estrategia E WITH (NOLOCK)
		INNER JOIN @OfertasPersonalizadas op
			ON E.CampaniaID = op.AnioCampanaVenta
			AND E.CUV2 = op.CUV
		INNER JOIN ods.ProductoComercial PC WITH (NOLOCK)
			ON PC.CUV = E.CUV2
			AND PC.AnoCampania = E.CampaniaID
		INNER JOIN dbo.vwEstrategiaShowRoomEquivalencia ves
			ON e.TipoEstrategiaId = ves.TipoEstrategiaID
		LEFT JOIN dbo.Marca M WITH (NOLOCK)
			ON M.MarcaId = PC.MarcaId
	WHERE E.Activo = 1
		AND NOT EXISTS (SELECT CUV FROM @tablaCuvFaltante TF WHERE E.CUV2 = TF.CUV)
	ORDER BY op.Orden ASC, EstrategiaID ASC
SET NOCOUNT OFF
END
GO


GO
USE BelcorpPuertoRico
GO

GO
 -- exec ShowRoom.GetShowRoomOfertasConsultoraPersonalizada 201807, '000001740'
ALTER PROCEDURE ShowRoom.GetShowRoomOfertasConsultoraPersonalizada
  @CampaniaID INT
 ,@CodigoConsultora VARCHAR(20)
AS
BEGIN
 SET NOCOUNT ON
	DECLARE @StrCampaniaID char(6) = CONVERT(char(6), @CampaniaID)
	DECLARE @EstrategiaCodigo varchar(100) = '030'
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
	SELECT CUV FROM dbo.ObtenerCuvFaltante (@CampaniaID, @CodigoConsultora)

	DECLARE @codConsultoraDefault VARCHAR(9) = ''
	SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001
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
		AND TipoPersonalizacion = 'SR'

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
			AND op.TipoPersonalizacion = 'SR'
	END
	INSERT INTO @OfertasPersonalizadas(Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta)
		SELECT Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta
		FROM dbo.ListarEstrategiasForzadas(@CampaniaID, @EstrategiaCodigo)

	SELECT
		e.EstrategiaID
	  ,e.CUV2 AS CUV
	  ,e.DescripcionCUV2 AS Descripcion
	  ,e.Precio AS PrecioValorizado --tachado
	  ,COALESCE(e.Precio2, pc.PrecioCatalogo) AS PrecioOferta
	  ,e.Cantidad AS Stock
	  ,e.ImagenURL AS ImagenProducto
	  ,e.LimiteVenta AS UnidadesPermitidas
	  ,e.Activo AS FlagHabilitarProducto
	  ,e.UsuarioCreacion AS UsuarioRegistro
	  ,e.FechaCreacion AS FechaRegistro
	  ,e.UsuarioModificacion
	  ,e.FechaModificacion
	  ,e.ImagenMiniaturaURL AS ImagenMini
	  ,pc.MarcaID
	  ,op.Orden
	  ,e.TextoLibre AS TipNegocio
	  ,pc.CodigoProducto
	  ,e.EsSubCampania
	  , ISNULL(e.CodigoEstrategia,0) AS 'CodigoEstrategia'
	  ,ISNULL(e.TieneVariedad,0) AS 'TieneVariedad'
	  ,e.TipoEstrategiaId AS ConfiguracionOfertaID
	  ,op.FlagRevista
	FROM dbo.Estrategia E WITH (NOLOCK)
		INNER JOIN @OfertasPersonalizadas op
			ON E.CampaniaID = op.AnioCampanaVenta
			AND E.CUV2 = op.CUV
		INNER JOIN ods.ProductoComercial PC WITH (NOLOCK)
			ON PC.CUV = E.CUV2
			AND PC.AnoCampania = E.CampaniaID
		INNER JOIN dbo.vwEstrategiaShowRoomEquivalencia ves
			ON e.TipoEstrategiaId = ves.TipoEstrategiaID
		LEFT JOIN dbo.Marca M WITH (NOLOCK)
			ON M.MarcaId = PC.MarcaId
	WHERE E.Activo = 1
		AND NOT EXISTS (SELECT CUV FROM @tablaCuvFaltante TF WHERE E.CUV2 = TF.CUV)
	ORDER BY op.Orden ASC, EstrategiaID ASC
SET NOCOUNT OFF
END
GO


GO
USE BelcorpPanama
GO

GO
 -- exec ShowRoom.GetShowRoomOfertasConsultoraPersonalizada 201807, '000001740'
ALTER PROCEDURE ShowRoom.GetShowRoomOfertasConsultoraPersonalizada
  @CampaniaID INT
 ,@CodigoConsultora VARCHAR(20)
AS
BEGIN
 SET NOCOUNT ON
	DECLARE @StrCampaniaID char(6) = CONVERT(char(6), @CampaniaID)
	DECLARE @EstrategiaCodigo varchar(100) = '030'
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
	SELECT CUV FROM dbo.ObtenerCuvFaltante (@CampaniaID, @CodigoConsultora)

	DECLARE @codConsultoraDefault VARCHAR(9) = ''
	SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001
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
		AND TipoPersonalizacion = 'SR'

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
			AND op.TipoPersonalizacion = 'SR'
	END
	INSERT INTO @OfertasPersonalizadas(Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta)
		SELECT Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta
		FROM dbo.ListarEstrategiasForzadas(@CampaniaID, @EstrategiaCodigo)

	SELECT
		e.EstrategiaID
	  ,e.CUV2 AS CUV
	  ,e.DescripcionCUV2 AS Descripcion
	  ,e.Precio AS PrecioValorizado --tachado
	  ,COALESCE(e.Precio2, pc.PrecioCatalogo) AS PrecioOferta
	  ,e.Cantidad AS Stock
	  ,e.ImagenURL AS ImagenProducto
	  ,e.LimiteVenta AS UnidadesPermitidas
	  ,e.Activo AS FlagHabilitarProducto
	  ,e.UsuarioCreacion AS UsuarioRegistro
	  ,e.FechaCreacion AS FechaRegistro
	  ,e.UsuarioModificacion
	  ,e.FechaModificacion
	  ,e.ImagenMiniaturaURL AS ImagenMini
	  ,pc.MarcaID
	  ,op.Orden
	  ,e.TextoLibre AS TipNegocio
	  ,pc.CodigoProducto
	  ,e.EsSubCampania
	  , ISNULL(e.CodigoEstrategia,0) AS 'CodigoEstrategia'
	  ,ISNULL(e.TieneVariedad,0) AS 'TieneVariedad'
	  ,e.TipoEstrategiaId AS ConfiguracionOfertaID
	  ,op.FlagRevista
	FROM dbo.Estrategia E WITH (NOLOCK)
		INNER JOIN @OfertasPersonalizadas op
			ON E.CampaniaID = op.AnioCampanaVenta
			AND E.CUV2 = op.CUV
		INNER JOIN ods.ProductoComercial PC WITH (NOLOCK)
			ON PC.CUV = E.CUV2
			AND PC.AnoCampania = E.CampaniaID
		INNER JOIN dbo.vwEstrategiaShowRoomEquivalencia ves
			ON e.TipoEstrategiaId = ves.TipoEstrategiaID
		LEFT JOIN dbo.Marca M WITH (NOLOCK)
			ON M.MarcaId = PC.MarcaId
	WHERE E.Activo = 1
		AND NOT EXISTS (SELECT CUV FROM @tablaCuvFaltante TF WHERE E.CUV2 = TF.CUV)
	ORDER BY op.Orden ASC, EstrategiaID ASC
SET NOCOUNT OFF
END
GO


GO
USE BelcorpGuatemala
GO

GO
 -- exec ShowRoom.GetShowRoomOfertasConsultoraPersonalizada 201807, '000001740'
ALTER PROCEDURE ShowRoom.GetShowRoomOfertasConsultoraPersonalizada
  @CampaniaID INT
 ,@CodigoConsultora VARCHAR(20)
AS
BEGIN
 SET NOCOUNT ON
	DECLARE @StrCampaniaID char(6) = CONVERT(char(6), @CampaniaID)
	DECLARE @EstrategiaCodigo varchar(100) = '030'
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
	SELECT CUV FROM dbo.ObtenerCuvFaltante (@CampaniaID, @CodigoConsultora)

	DECLARE @codConsultoraDefault VARCHAR(9) = ''
	SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001
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
		AND TipoPersonalizacion = 'SR'

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
			AND op.TipoPersonalizacion = 'SR'
	END
	INSERT INTO @OfertasPersonalizadas(Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta)
		SELECT Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta
		FROM dbo.ListarEstrategiasForzadas(@CampaniaID, @EstrategiaCodigo)

	SELECT
		e.EstrategiaID
	  ,e.CUV2 AS CUV
	  ,e.DescripcionCUV2 AS Descripcion
	  ,e.Precio AS PrecioValorizado --tachado
	  ,COALESCE(e.Precio2, pc.PrecioCatalogo) AS PrecioOferta
	  ,e.Cantidad AS Stock
	  ,e.ImagenURL AS ImagenProducto
	  ,e.LimiteVenta AS UnidadesPermitidas
	  ,e.Activo AS FlagHabilitarProducto
	  ,e.UsuarioCreacion AS UsuarioRegistro
	  ,e.FechaCreacion AS FechaRegistro
	  ,e.UsuarioModificacion
	  ,e.FechaModificacion
	  ,e.ImagenMiniaturaURL AS ImagenMini
	  ,pc.MarcaID
	  ,op.Orden
	  ,e.TextoLibre AS TipNegocio
	  ,pc.CodigoProducto
	  ,e.EsSubCampania
	  , ISNULL(e.CodigoEstrategia,0) AS 'CodigoEstrategia'
	  ,ISNULL(e.TieneVariedad,0) AS 'TieneVariedad'
	  ,e.TipoEstrategiaId AS ConfiguracionOfertaID
	  ,op.FlagRevista
	FROM dbo.Estrategia E WITH (NOLOCK)
		INNER JOIN @OfertasPersonalizadas op
			ON E.CampaniaID = op.AnioCampanaVenta
			AND E.CUV2 = op.CUV
		INNER JOIN ods.ProductoComercial PC WITH (NOLOCK)
			ON PC.CUV = E.CUV2
			AND PC.AnoCampania = E.CampaniaID
		INNER JOIN dbo.vwEstrategiaShowRoomEquivalencia ves
			ON e.TipoEstrategiaId = ves.TipoEstrategiaID
		LEFT JOIN dbo.Marca M WITH (NOLOCK)
			ON M.MarcaId = PC.MarcaId
	WHERE E.Activo = 1
		AND NOT EXISTS (SELECT CUV FROM @tablaCuvFaltante TF WHERE E.CUV2 = TF.CUV)
	ORDER BY op.Orden ASC, EstrategiaID ASC
SET NOCOUNT OFF
END
GO


GO
USE BelcorpEcuador
GO

GO
 -- exec ShowRoom.GetShowRoomOfertasConsultoraPersonalizada 201807, '000001740'
ALTER PROCEDURE ShowRoom.GetShowRoomOfertasConsultoraPersonalizada
  @CampaniaID INT
 ,@CodigoConsultora VARCHAR(20)
AS
BEGIN
 SET NOCOUNT ON
	DECLARE @StrCampaniaID char(6) = CONVERT(char(6), @CampaniaID)
	DECLARE @EstrategiaCodigo varchar(100) = '030'
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
	SELECT CUV FROM dbo.ObtenerCuvFaltante (@CampaniaID, @CodigoConsultora)

	DECLARE @codConsultoraDefault VARCHAR(9) = ''
	SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001
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
		AND TipoPersonalizacion = 'SR'

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
			AND op.TipoPersonalizacion = 'SR'
	END
	INSERT INTO @OfertasPersonalizadas(Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta)
		SELECT Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta
		FROM dbo.ListarEstrategiasForzadas(@CampaniaID, @EstrategiaCodigo)

	SELECT
		e.EstrategiaID
	  ,e.CUV2 AS CUV
	  ,e.DescripcionCUV2 AS Descripcion
	  ,e.Precio AS PrecioValorizado --tachado
	  ,COALESCE(e.Precio2, pc.PrecioCatalogo) AS PrecioOferta
	  ,e.Cantidad AS Stock
	  ,e.ImagenURL AS ImagenProducto
	  ,e.LimiteVenta AS UnidadesPermitidas
	  ,e.Activo AS FlagHabilitarProducto
	  ,e.UsuarioCreacion AS UsuarioRegistro
	  ,e.FechaCreacion AS FechaRegistro
	  ,e.UsuarioModificacion
	  ,e.FechaModificacion
	  ,e.ImagenMiniaturaURL AS ImagenMini
	  ,pc.MarcaID
	  ,op.Orden
	  ,e.TextoLibre AS TipNegocio
	  ,pc.CodigoProducto
	  ,e.EsSubCampania
	  , ISNULL(e.CodigoEstrategia,0) AS 'CodigoEstrategia'
	  ,ISNULL(e.TieneVariedad,0) AS 'TieneVariedad'
	  ,e.TipoEstrategiaId AS ConfiguracionOfertaID
	  ,op.FlagRevista
	FROM dbo.Estrategia E WITH (NOLOCK)
		INNER JOIN @OfertasPersonalizadas op
			ON E.CampaniaID = op.AnioCampanaVenta
			AND E.CUV2 = op.CUV
		INNER JOIN ods.ProductoComercial PC WITH (NOLOCK)
			ON PC.CUV = E.CUV2
			AND PC.AnoCampania = E.CampaniaID
		INNER JOIN dbo.vwEstrategiaShowRoomEquivalencia ves
			ON e.TipoEstrategiaId = ves.TipoEstrategiaID
		LEFT JOIN dbo.Marca M WITH (NOLOCK)
			ON M.MarcaId = PC.MarcaId
	WHERE E.Activo = 1
		AND NOT EXISTS (SELECT CUV FROM @tablaCuvFaltante TF WHERE E.CUV2 = TF.CUV)
	ORDER BY op.Orden ASC, EstrategiaID ASC
SET NOCOUNT OFF
END
GO


GO
USE BelcorpDominicana
GO

GO
 -- exec ShowRoom.GetShowRoomOfertasConsultoraPersonalizada 201807, '000001740'
ALTER PROCEDURE ShowRoom.GetShowRoomOfertasConsultoraPersonalizada
  @CampaniaID INT
 ,@CodigoConsultora VARCHAR(20)
AS
BEGIN
 SET NOCOUNT ON
	DECLARE @StrCampaniaID char(6) = CONVERT(char(6), @CampaniaID)
	DECLARE @EstrategiaCodigo varchar(100) = '030'
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
	SELECT CUV FROM dbo.ObtenerCuvFaltante (@CampaniaID, @CodigoConsultora)

	DECLARE @codConsultoraDefault VARCHAR(9) = ''
	SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001
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
		AND TipoPersonalizacion = 'SR'

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
			AND op.TipoPersonalizacion = 'SR'
	END
	INSERT INTO @OfertasPersonalizadas(Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta)
		SELECT Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta
		FROM dbo.ListarEstrategiasForzadas(@CampaniaID, @EstrategiaCodigo)

	SELECT
		e.EstrategiaID
	  ,e.CUV2 AS CUV
	  ,e.DescripcionCUV2 AS Descripcion
	  ,e.Precio AS PrecioValorizado --tachado
	  ,COALESCE(e.Precio2, pc.PrecioCatalogo) AS PrecioOferta
	  ,e.Cantidad AS Stock
	  ,e.ImagenURL AS ImagenProducto
	  ,e.LimiteVenta AS UnidadesPermitidas
	  ,e.Activo AS FlagHabilitarProducto
	  ,e.UsuarioCreacion AS UsuarioRegistro
	  ,e.FechaCreacion AS FechaRegistro
	  ,e.UsuarioModificacion
	  ,e.FechaModificacion
	  ,e.ImagenMiniaturaURL AS ImagenMini
	  ,pc.MarcaID
	  ,op.Orden
	  ,e.TextoLibre AS TipNegocio
	  ,pc.CodigoProducto
	  ,e.EsSubCampania
	  , ISNULL(e.CodigoEstrategia,0) AS 'CodigoEstrategia'
	  ,ISNULL(e.TieneVariedad,0) AS 'TieneVariedad'
	  ,e.TipoEstrategiaId AS ConfiguracionOfertaID
	  ,op.FlagRevista
	FROM dbo.Estrategia E WITH (NOLOCK)
		INNER JOIN @OfertasPersonalizadas op
			ON E.CampaniaID = op.AnioCampanaVenta
			AND E.CUV2 = op.CUV
		INNER JOIN ods.ProductoComercial PC WITH (NOLOCK)
			ON PC.CUV = E.CUV2
			AND PC.AnoCampania = E.CampaniaID
		INNER JOIN dbo.vwEstrategiaShowRoomEquivalencia ves
			ON e.TipoEstrategiaId = ves.TipoEstrategiaID
		LEFT JOIN dbo.Marca M WITH (NOLOCK)
			ON M.MarcaId = PC.MarcaId
	WHERE E.Activo = 1
		AND NOT EXISTS (SELECT CUV FROM @tablaCuvFaltante TF WHERE E.CUV2 = TF.CUV)
	ORDER BY op.Orden ASC, EstrategiaID ASC
SET NOCOUNT OFF
END
GO


GO
USE BelcorpCostaRica
GO

GO
 -- exec ShowRoom.GetShowRoomOfertasConsultoraPersonalizada 201807, '000001740'
ALTER PROCEDURE ShowRoom.GetShowRoomOfertasConsultoraPersonalizada
  @CampaniaID INT
 ,@CodigoConsultora VARCHAR(20)
AS
BEGIN
 SET NOCOUNT ON
	DECLARE @StrCampaniaID char(6) = CONVERT(char(6), @CampaniaID)
	DECLARE @EstrategiaCodigo varchar(100) = '030'
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
	SELECT CUV FROM dbo.ObtenerCuvFaltante (@CampaniaID, @CodigoConsultora)

	DECLARE @codConsultoraDefault VARCHAR(9) = ''
	SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001
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
		AND TipoPersonalizacion = 'SR'

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
			AND op.TipoPersonalizacion = 'SR'
	END
	INSERT INTO @OfertasPersonalizadas(Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta)
		SELECT Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta
		FROM dbo.ListarEstrategiasForzadas(@CampaniaID, @EstrategiaCodigo)

	SELECT
		e.EstrategiaID
	  ,e.CUV2 AS CUV
	  ,e.DescripcionCUV2 AS Descripcion
	  ,e.Precio AS PrecioValorizado --tachado
	  ,COALESCE(e.Precio2, pc.PrecioCatalogo) AS PrecioOferta
	  ,e.Cantidad AS Stock
	  ,e.ImagenURL AS ImagenProducto
	  ,e.LimiteVenta AS UnidadesPermitidas
	  ,e.Activo AS FlagHabilitarProducto
	  ,e.UsuarioCreacion AS UsuarioRegistro
	  ,e.FechaCreacion AS FechaRegistro
	  ,e.UsuarioModificacion
	  ,e.FechaModificacion
	  ,e.ImagenMiniaturaURL AS ImagenMini
	  ,pc.MarcaID
	  ,op.Orden
	  ,e.TextoLibre AS TipNegocio
	  ,pc.CodigoProducto
	  ,e.EsSubCampania
	  , ISNULL(e.CodigoEstrategia,0) AS 'CodigoEstrategia'
	  ,ISNULL(e.TieneVariedad,0) AS 'TieneVariedad'
	  ,e.TipoEstrategiaId AS ConfiguracionOfertaID
	  ,op.FlagRevista
	FROM dbo.Estrategia E WITH (NOLOCK)
		INNER JOIN @OfertasPersonalizadas op
			ON E.CampaniaID = op.AnioCampanaVenta
			AND E.CUV2 = op.CUV
		INNER JOIN ods.ProductoComercial PC WITH (NOLOCK)
			ON PC.CUV = E.CUV2
			AND PC.AnoCampania = E.CampaniaID
		INNER JOIN dbo.vwEstrategiaShowRoomEquivalencia ves
			ON e.TipoEstrategiaId = ves.TipoEstrategiaID
		LEFT JOIN dbo.Marca M WITH (NOLOCK)
			ON M.MarcaId = PC.MarcaId
	WHERE E.Activo = 1
		AND NOT EXISTS (SELECT CUV FROM @tablaCuvFaltante TF WHERE E.CUV2 = TF.CUV)
	ORDER BY op.Orden ASC, EstrategiaID ASC
SET NOCOUNT OFF
END
GO


GO
USE BelcorpChile
GO

GO
 -- exec ShowRoom.GetShowRoomOfertasConsultoraPersonalizada 201807, '000001740'
ALTER PROCEDURE ShowRoom.GetShowRoomOfertasConsultoraPersonalizada
  @CampaniaID INT
 ,@CodigoConsultora VARCHAR(20)
AS
BEGIN
 SET NOCOUNT ON
	DECLARE @StrCampaniaID char(6) = CONVERT(char(6), @CampaniaID)
	DECLARE @EstrategiaCodigo varchar(100) = '030'
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
	SELECT CUV FROM dbo.ObtenerCuvFaltante (@CampaniaID, @CodigoConsultora)

	DECLARE @codConsultoraDefault VARCHAR(9) = ''
	SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001
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
		AND TipoPersonalizacion = 'SR'

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
			AND op.TipoPersonalizacion = 'SR'
	END
	INSERT INTO @OfertasPersonalizadas(Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta)
		SELECT Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta
		FROM dbo.ListarEstrategiasForzadas(@CampaniaID, @EstrategiaCodigo)

	SELECT
		e.EstrategiaID
	  ,e.CUV2 AS CUV
	  ,e.DescripcionCUV2 AS Descripcion
	  ,e.Precio AS PrecioValorizado --tachado
	  ,COALESCE(e.Precio2, pc.PrecioCatalogo) AS PrecioOferta
	  ,e.Cantidad AS Stock
	  ,e.ImagenURL AS ImagenProducto
	  ,e.LimiteVenta AS UnidadesPermitidas
	  ,e.Activo AS FlagHabilitarProducto
	  ,e.UsuarioCreacion AS UsuarioRegistro
	  ,e.FechaCreacion AS FechaRegistro
	  ,e.UsuarioModificacion
	  ,e.FechaModificacion
	  ,e.ImagenMiniaturaURL AS ImagenMini
	  ,pc.MarcaID
	  ,op.Orden
	  ,e.TextoLibre AS TipNegocio
	  ,pc.CodigoProducto
	  ,e.EsSubCampania
	  , ISNULL(e.CodigoEstrategia,0) AS 'CodigoEstrategia'
	  ,ISNULL(e.TieneVariedad,0) AS 'TieneVariedad'
	  ,e.TipoEstrategiaId AS ConfiguracionOfertaID
	  ,op.FlagRevista
	FROM dbo.Estrategia E WITH (NOLOCK)
		INNER JOIN @OfertasPersonalizadas op
			ON E.CampaniaID = op.AnioCampanaVenta
			AND E.CUV2 = op.CUV
		INNER JOIN ods.ProductoComercial PC WITH (NOLOCK)
			ON PC.CUV = E.CUV2
			AND PC.AnoCampania = E.CampaniaID
		INNER JOIN dbo.vwEstrategiaShowRoomEquivalencia ves
			ON e.TipoEstrategiaId = ves.TipoEstrategiaID
		LEFT JOIN dbo.Marca M WITH (NOLOCK)
			ON M.MarcaId = PC.MarcaId
	WHERE E.Activo = 1
		AND NOT EXISTS (SELECT CUV FROM @tablaCuvFaltante TF WHERE E.CUV2 = TF.CUV)
	ORDER BY op.Orden ASC, EstrategiaID ASC
SET NOCOUNT OFF
END
GO


GO
USE BelcorpBolivia
GO

GO
 -- exec ShowRoom.GetShowRoomOfertasConsultoraPersonalizada 201807, '000001740'
ALTER PROCEDURE ShowRoom.GetShowRoomOfertasConsultoraPersonalizada
  @CampaniaID INT
 ,@CodigoConsultora VARCHAR(20)
AS
BEGIN
 SET NOCOUNT ON
	DECLARE @StrCampaniaID char(6) = CONVERT(char(6), @CampaniaID)
	DECLARE @EstrategiaCodigo varchar(100) = '030'
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
	SELECT CUV FROM dbo.ObtenerCuvFaltante (@CampaniaID, @CodigoConsultora)

	DECLARE @codConsultoraDefault VARCHAR(9) = ''
	SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001
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
		AND TipoPersonalizacion = 'SR'

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
			AND op.TipoPersonalizacion = 'SR'
	END
	INSERT INTO @OfertasPersonalizadas(Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta)
		SELECT Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta
		FROM dbo.ListarEstrategiasForzadas(@CampaniaID, @EstrategiaCodigo)

	SELECT
		e.EstrategiaID
	  ,e.CUV2 AS CUV
	  ,e.DescripcionCUV2 AS Descripcion
	  ,e.Precio AS PrecioValorizado --tachado
	  ,COALESCE(e.Precio2, pc.PrecioCatalogo) AS PrecioOferta
	  ,e.Cantidad AS Stock
	  ,e.ImagenURL AS ImagenProducto
	  ,e.LimiteVenta AS UnidadesPermitidas
	  ,e.Activo AS FlagHabilitarProducto
	  ,e.UsuarioCreacion AS UsuarioRegistro
	  ,e.FechaCreacion AS FechaRegistro
	  ,e.UsuarioModificacion
	  ,e.FechaModificacion
	  ,e.ImagenMiniaturaURL AS ImagenMini
	  ,pc.MarcaID
	  ,op.Orden
	  ,e.TextoLibre AS TipNegocio
	  ,pc.CodigoProducto
	  ,e.EsSubCampania
	  , ISNULL(e.CodigoEstrategia,0) AS 'CodigoEstrategia'
	  ,ISNULL(e.TieneVariedad,0) AS 'TieneVariedad'
	  ,e.TipoEstrategiaId AS ConfiguracionOfertaID
	  ,op.FlagRevista
	FROM dbo.Estrategia E WITH (NOLOCK)
		INNER JOIN @OfertasPersonalizadas op
			ON E.CampaniaID = op.AnioCampanaVenta
			AND E.CUV2 = op.CUV
		INNER JOIN ods.ProductoComercial PC WITH (NOLOCK)
			ON PC.CUV = E.CUV2
			AND PC.AnoCampania = E.CampaniaID
		INNER JOIN dbo.vwEstrategiaShowRoomEquivalencia ves
			ON e.TipoEstrategiaId = ves.TipoEstrategiaID
		LEFT JOIN dbo.Marca M WITH (NOLOCK)
			ON M.MarcaId = PC.MarcaId
	WHERE E.Activo = 1
		AND NOT EXISTS (SELECT CUV FROM @tablaCuvFaltante TF WHERE E.CUV2 = TF.CUV)
	ORDER BY op.Orden ASC, EstrategiaID ASC
SET NOCOUNT OFF
END
GO


GO
