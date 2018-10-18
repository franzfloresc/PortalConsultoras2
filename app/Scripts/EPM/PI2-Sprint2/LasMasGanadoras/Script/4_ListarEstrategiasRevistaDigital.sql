USE BelcorpPeru_BPT
GO

--USE BelcorpChile_BPT
--GO

--USE BelcorpCostaRica_BPT
--GO

PRINT DB_NAME()

PRINT 'ALTER PROCEDURE ''ListarEstrategiasRevistaDigital'''

GO

ALTER PROCEDURE [dbo].[ListarEstrategiasRevistaDigital]
	@CampaniaID INT = 0,
	@CodigoConsultora VARCHAR(30) = '',
	@FlagMaterialGanancia INT = 0
AS
BEGIN
	SET NOCOUNT ON;

	  --exec ListarEstrategiasRevistaDigital 201815, '000001740', 0
	  --exec ListarEstrategiasRevistaDigital 201815, '000001740', 1
	  --exec ListarEstrategiasRevistaDigital 201815, '000001740', 2

	---- TEMP ASSING 4 DEVELOPMENT PURPOUSES - INI
	--SET @CampaniaID = 201816
	--SET @CodigoConsultora = '14641723K'
	--SET @FlagMaterialGanancia = 1
	---- TEMP ASSING 4 DEVELOPMENT PURPOUSES - FIN

	DECLARE @ObtenerOpmTodo INT = 0
	DECLARE @ObtenerOpmSinForzadas INT = 1
	DECLARE @ObtenerOpmSoloForzadas INT = 2

	DECLARE @StrCampaniaID CHAR(6) = CONVERT(CHAR(6),@CampaniaID)
	DECLARE @EstrategiaCodigoOPM varchar(100) = '007'
	DECLARE @EstrategiaCodigoPAD varchar(100) = '008'
	DECLARE @TipoPersonalizacionCodigoOpm varchar(3) = 'OPM'
	DECLARE @TipoPersonalizacionCodigoPad varchar(3) = 'PAD'
	DECLARE @TipoPersonalizacionCodigoOpmPad varchar(3) = 'OPM;PAD'

	DECLARE @tablaCuvFaltante TABLE(CUV VARCHAR(6))
	INSERT INTO @tablaCuvFaltante(CUV)
	SELECT CUV 
	FROM [dbo].[ObtenerCuvFaltante](@CampaniaID,@CodigoConsultora)

	DECLARE @CodConsultoraDefault VARCHAR(9) = ''
	SELECT @CodConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001

	DECLARE @CodConsultoraForzada VARCHAR(9) = ''
	SELECT @CodConsultoraForzada = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10002

	DECLARE  @OfertasPersonalizadas TABLE
	(
		Orden					INT,
		CUV						CHAR(6),
		TipoPersonalizacion		CHAR(3),
		FlagRevista				INT,
		AnioCampanaVenta		INT,
		TipoEstrategiaId		INT
	)
	--
	IF @FlagMaterialGanancia = @ObtenerOpmTodo OR @FlagMaterialGanancia = @ObtenerOpmSinForzadas
	BEGIN
		INSERT INTO @OfertasPersonalizadas 
		EXEC ListarOfertasPersonalizadas @CampaniaID,@TipoPersonalizacionCodigoOpmPad,@CodigoConsultora

		IF NOT EXISTS (SELECT TOP 1 CUV FROM @OfertasPersonalizadas)
		BEGIN
			INSERT INTO @OfertasPersonalizadas
			EXEC ListarOfertasPersonalizadas @CampaniaID,@TipoPersonalizacionCodigoOpmPad,@codConsultoraDefault
		END

		INSERT INTO @OfertasPersonalizadas
		EXEC ListarOfertasPersonalizadas 
			@CampaniaID
			,@TipoPersonalizacionCodigoPad
			,@codConsultoraForzada

		DECLARE @MaterialGanancia INT = CASE WHEN @FlagMaterialGanancia = @ObtenerOpmSinForzadas THEN 0 ELSE NULL END
		INSERT INTO @OfertasPersonalizadas
		EXEC ListarOfertasPersonalizadas 
			@CampaniaID
			,@TipoPersonalizacionCodigoOpm
			,@codConsultoraForzada
			,@MaterialGanancia
	END
	ELSE IF @FlagMaterialGanancia = @ObtenerOpmSoloForzadas
	BEGIN
		INSERT INTO @OfertasPersonalizadas
		EXEC ListarOfertasPersonalizadas @CampaniaID,@TipoPersonalizacionCodigoOpm,@codConsultoraForzada,1
	END	

	SELECT
		E.EstrategiaID,
		E.CUV2,
		E.DescripcionCUV2,
		dbo.ObtenerDescripcionEtiqueta(E.EtiquetaID) EtiquetaDescripcion,
		E.Precio,
		dbo.ObtenerDescripcionEtiqueta(E.EtiquetaID2) EtiquetaDescripcion2,
		E.Precio2,
		E.TextoLibre,
		E.FlagEstrella,
		E.ColorFondo,
		E.TipoEstrategiaID,
		E.ImagenURL FotoProducto01,
		TE.ImagenEstrategia ImagenURL,
		E.LimiteVenta,
		PC.MarcaID,
		PC.IndicadorMontoMinimo,
		PC.CodigoProducto,
		0 AS FlagNueva,
		'' as TipoTallaColor,
		3 as TipoEstrategiaImagenMostrar
		, E.EtiquetaID
		, E.EtiquetaID2
		, E.CodigoEstrategia
		, E.TieneVariedad
		, TE.CODIGO
		, TE.DescripcionEstrategia
		, TE.FlagMostrarImg AS FlagMostrarImg
		, M.Descripcion as DescripcionMarca
		, 'NO DISPONIBLE' AS DescripcionCategoria
		, E.PrecioPublico
		, E.Ganancia
		, OP.FlagRevista
		, OP.Orden
	FROM  dbo.Estrategia E with(nolock)
		INNER JOIN @OfertasPersonalizadas op
			ON E.CampaniaID = op.AnioCampanaVenta
			AND E.CUV2 = op.CUV
			AND OP.TipoEstrategiaId = E.TipoEstrategiaId
		INNER JOIN ods.ProductoComercial PC with(nolock)
			ON PC.CUV = E.CUV2
			AND PC.AnoCampania = E.CampaniaID
		INNER JOIN dbo.TipoEstrategia TE with(nolock)
			ON E.TipoEstrategiaID = TE.TipoEstrategiaID
			AND TE.Codigo in (@EstrategiaCodigoOPM, @EstrategiaCodigoPAD)
		LEFT JOIN dbo.Marca M with(nolock)
			ON M.MarcaId = PC.MarcaId
		LEFT JOIN @tablaCuvFaltante TF
			ON E.CUV2 = TF.CUV
	WHERE
		E.Activo = 1
		AND TE.FlagActivo = 1
		AND TE.flagRecoPerfil = 1
		AND TF.CUV IS NULL
	ORDER BY OP.Orden ASC, E.EstrategiaID ASC

	SET NOCOUNT OFF
END
