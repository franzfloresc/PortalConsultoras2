USE [BelcorpPeru]
GO

IF OBJECT_ID('GetReporteCuvDetallado', 'P') IS NOT NULL 
  DROP PROCEDURE GetReporteCuvDetallado
  GO

CREATE PROC GetReporteCuvDetallado
(
	@CampaniaID INT = 0,
	@Cuv VARCHAR(10) = ''
)
AS
BEGIN
	select
		test.DescripcionEstrategia,
		estp.cuv2 as CuvPadre,
		estp.cuv as CuvHijo,
		estp.CodigoEstrategia,
		estp.Grupo,
		estp.SAP,
		mare.Nombre as MarcaEstrategia,
		marpc.Nombre as MarcaMatriz,
		estp.FactorCuadre,
		pco.PrecioUnitario,
		pco.IndicadorPreUni as PrecioPublico,
		estp.Digitable,
		estp.NombreProducto,
		estp.ImagenProducto AS ImagenTipos,
		estp.ImagenBulk AS ImagenTonos,
		estp.NombreBulk,
		pco.FactorRepeticion,
		estp.IdMarca as CodigoMarca
	from 
		estrategiaproducto estp with(nolock)
		INNER JOIN estrategia est with(nolock) on estp.estrategiaid = est.estrategiaid
		INNER JOIN tipoestrategia test with(nolock) on est.tipoestrategiaid = test.tipoestrategiaid
		INNER JOIN ods.productocomercial pco WITH (NOLOCK) ON estp.cuv = pco.cuv and estp.campania = pco.anocampania
		LEFT JOIN ods.marca mare WITH(NOLOCK) ON estp.IdMarca = mare.MarcaId
		LEFT JOIN ods.marca marpc WITH(NOLOCK) ON pco.MarcaID = marpc.MarcaId
		
	where
		(estp.cuv2 = @Cuv OR estp.cuv = @cuv) and
		estp.campania = @CampaniaID
	order by estp.EstrategiaID,estp.cuv2, estp.Grupo
		
END
GO

IF OBJECT_ID('GetReporteEstrategiasPorConsultora', 'P') IS NOT NULL 
  DROP PROCEDURE GetReporteEstrategiasPorConsultora
  GO

CREATE PROC GetReporteEstrategiasPorConsultora
(
	@CampaniaID INT = 0,
	@CodigoConsultora VARCHAR(30) = '',
	@Palanca VARCHAR(3) = '',
	@FechaConsulta DATE
)
AS
BEGIN

	DECLARE @Activa INT = (SELECT TOP 1 1 FROM RevistaDigitalSuscripcion WHERE codigoConsultora = @CodigoConsultora AND CampaniaEfectiva = @CampaniaID AND EstadoRegistro = 1)
	DECLARE @ActivoMDO INT = (SELECT Estado FROM ConfiguracionPaisdatos where codigo='ActivoMDO')

	IF @Palanca = '4'
	BEGIN
		SET @Palanca = '10'
		IF @ActivoMDO <> 1 AND @Activa <> 1
		BEGIN
			SET @Palanca = '4'
		END

	END


	IF @Palanca = '4'--OPT
	BEGIN

		declare @tmpOpt TABLE (
			EstrategiaID VARCHAR(150)				,CUV2 VARCHAR(150)			,DescripcionCUV2 VARCHAR(300)		,EtiquetaDescripcion VARCHAR(150)	,Precio VARCHAR(150),
			EtiquetaDescripcion2 VARCHAR(150)		,Precio2 VARCHAR(150)		,TextoLibre VARCHAR(150)			,FlagEstrella VARCHAR(150)			,ColorFondo VARCHAR(150),
			TipoEstrategiaID VARCHAR(150)			,FotoProducto01 VARCHAR(150),ImagenURL VARCHAR(150)				,LimiteVenta VARCHAR(150)			,MarcaID VARCHAR(150),
			Orden1 VARCHAR(150)						,Orden2 VARCHAR(150)		,IndicadorMontoMinimo VARCHAR(150)	,FlagNueva VARCHAR(150)				,TipoTallaColor VARCHAR(150),
			TipoEstrategiaImagenMostrar VARCHAR(150),CodigoProducto VARCHAR(150),EtiquetaID VARCHAR(150)			,EtiquetaID2 VARCHAR(150)			,CodigoEstrategia VARCHAR(150),
			TieneVariedad VARCHAR(150)				,CODIGO VARCHAR(150)		,DescripcionEstrategia VARCHAR(150)	,FlagMostrarImg VARCHAR(150)		,DescripcionMarca VARCHAR(150),
			DescripcionCategoria VARCHAR(150)		,PrecioPublico VARCHAR(150)	,Ganancia VARCHAR(150))
		
		insert into @tmpOpt exec ListarEstrategiasOPT @CampaniaID,@CodigoConsultora
		select CUV2 as CUV, DescripcionCUV2 as Descripcion from @tmpOpt

	END
	ELSE IF @Palanca = '10' --RD
	BEGIN

		DECLARE @EstrategiaCodigoOPM varchar(100) = '007'
		DECLARE @EstrategiaCodigoPAD varchar(100) = '008'
		DECLARE @TipoPersonalizacionCodigoOpm varchar(3) = 'OPM'
		DECLARE @TipoPersonalizacionCodigoPad varchar(3) = 'PAD'
		DECLARE @TipoPersonalizacionCodigoOpmPad varchar(3) = 'OPM;PAD'

		DECLARE @tablaCuvFaltante TABLE(CUV VARCHAR(6))
		INSERT INTO @tablaCuvFaltante(CUV)
		SELECT CUV FROM [dbo].[ObtenerCuvFaltante](@CampaniaID,@CodigoConsultora)

		DECLARE @CodConsultoraDefault VARCHAR(9) = ''
		SELECT @CodConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001

		DECLARE @CodConsultoraForzada VARCHAR(9) = ''
		SELECT @CodConsultoraForzada = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10002

		DECLARE  @OfertasPersonalizadas TABLE (Orden INT, CUV CHAR(6), TipoPersonalizacion CHAR(3), FlagRevista INT, AnioCampanaVenta INT, TipoEstrategiaId INT)

		INSERT INTO @OfertasPersonalizadas EXEC ListarOfertasPersonalizadas @CampaniaID,@TipoPersonalizacionCodigoOpmPad,@CodigoConsultora

		IF NOT EXISTS (SELECT TOP 1 CUV FROM @OfertasPersonalizadas)
		BEGIN
			INSERT INTO @OfertasPersonalizadas
			EXEC ListarOfertasPersonalizadas @CampaniaID,@TipoPersonalizacionCodigoOpmPad,@codConsultoraDefault
		END

		INSERT INTO @OfertasPersonalizadas EXEC ListarOfertasPersonalizadas @CampaniaID,@TipoPersonalizacionCodigoPad,@codConsultoraForzada
		INSERT INTO @OfertasPersonalizadas EXEC ListarOfertasPersonalizadas @CampaniaID,@TipoPersonalizacionCodigoOpm,@codConsultoraForzada

		SELECT
			E.CUV2 as CUV,
			E.DescripcionCUV2 as Descripcion
		FROM  dbo.Estrategia E with(nolock)
			INNER JOIN @OfertasPersonalizadas op ON E.CampaniaID = op.AnioCampanaVenta AND E.CUV2 = op.CUV AND OP.TipoEstrategiaId = E.TipoEstrategiaId
			INNER JOIN dbo.TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID AND TE.Codigo in (@EstrategiaCodigoOPM, @EstrategiaCodigoPAD)
			LEFT JOIN @tablaCuvFaltante TF ON E.CUV2 = TF.CUV
		WHERE
			E.Activo = 1 AND TE.FlagActivo = 1 AND TE.flagRecoPerfil = 1 AND TF.CUV IS NULL
		ORDER BY OP.Orden ASC, E.EstrategiaID ASC

	END
	ELSE IF @Palanca = '7' --ODD
	BEGIN

		DECLARE @fechaInicioFact DATE
		DECLARE @ZonaId INT
		DECLARE @num INT

		SET @ZonaId = (select ZonaId from ods.consultora where codigo = @CodigoConsultora)
		SET @fechaInicioFact = 
			(SELECT C.FechaInicioFacturacion 
			FROM ods.Cronograma C  
			INNER JOIN ods.Campania Ca ON C.CampaniaID = Ca.CampaniaID
			INNER JOIN [ods].[Zona] z (nolock) ON C.RegionID = z.RegionID AND c.ZonaID = z.ZonaID	
			WHERE Ca.Codigo = @CampaniaID AND Z.ZonaID = CASE WHEN @ZonaID = -1 THEN Z.ZonaID ELSE @ZonaID END)

		SET @num = (DATEDIFF(dd, @FechaConsulta, GETDATE()))
		SET @fechaInicioFact = (DATEADD(dd, @num, @fechaInicioFact))

		declare @tmpODD TABLE (
			EstrategiaID VARCHAR(150)				,CUV2 VARCHAR(150)				,DescripcionCUV2 VARCHAR(300)				,EtiquetaDescripcion VARCHAR(150)	,Precio VARCHAR(150),
			EtiquetaDescripcion2 VARCHAR(150)		,Precio2 VARCHAR(150)			,TextoLibre VARCHAR(150)					,CodigoEstrategia VARCHAR(150)		,FlagEstrella VARCHAR(150),
			ColorFondo VARCHAR(150)					,TipoEstrategiaID VARCHAR(150)	,FotoProducto01 VARCHAR(150)				,ImagenURL VARCHAR(150)				,LimiteVenta VARCHAR(150),
			MarcaID VARCHAR(150)					,Orden1 VARCHAR(150)			,Orden2 VARCHAR(150)						,IndicadorMontoMinimo VARCHAR(150)	,CodigoProducto VARCHAR(150),
			FlagNueva VARCHAR(150)					,TipoTallaColor VARCHAR(150)	,TipoEstrategiaImagenMostrar VARCHAR(150)	,EtiquetaID VARCHAR(150)			,EtiquetaID2 VARCHAR(150),
			CodigoEstrategia2 VARCHAR(150)			,TieneVariedad VARCHAR(150)		,CODIGO VARCHAR(150)						,DescripcionEstrategia VARCHAR(150)	,FlagMostrarImg VARCHAR(150),
			PrecioPublico VARCHAR(150)				,Ganancia VARCHAR(150)			,DescripcionMarca VARCHAR(150)				,FlagRevista VARCHAR(150)			,ImagenMiniaturaURL VARCHAR(150),
			DiaInicio VARCHAR(150))	

		insert into @tmpODD exec ListarEstrategiasODD2 @CampaniaID,@CodigoConsultora,@fechaInicioFact
		select CUV2 as CUV, DescripcionCUV2 as Descripcion from @tmpODD

	END
	ELSE IF @Palanca = '30' --SR
	BEGIN

		declare @tmpSR TABLE (
			EstrategiaID VARCHAR(150)				,CUV2 VARCHAR(150)							,DescripcionCUV2 VARCHAR(300)				,EtiquetaDescripcion VARCHAR(150)	,Precio VARCHAR(150),
			EtiquetaDescripcion2 VARCHAR(150)		,Precio2 VARCHAR(150)						,TextoLibre VARCHAR(150)					,FlagEstrella VARCHAR(150)			,ColorFondo VARCHAR(150),
			TipoEstrategiaID VARCHAR(150)			,FotoProducto01 VARCHAR(150)				,ImagenURL VARCHAR(150)						,LimiteVenta VARCHAR(150)			,MarcaID VARCHAR(150),
			Orden1 VARCHAR(150)						,Orden2 VARCHAR(150)						,IndicadorMontoMinimo VARCHAR(150)			,CodigoProducto VARCHAR(150)		,FlagNueva VARCHAR(150),
			TipoTallaColor VARCHAR(150)				,TipoEstrategiaImagenMostrar VARCHAR(150)	,EtiquetaID VARCHAR(150)					,EtiquetaID2 VARCHAR(150)			,CodigoEstrategia VARCHAR(150),
			TieneVariedad VARCHAR(150)				,CODIGO VARCHAR(150)						,DescripcionEstrategia VARCHAR(150)			,FlagMostrarImg VARCHAR(150)		,PrecioPublico VARCHAR(150),
			Ganancia VARCHAR(150)					,DescripcionMarca VARCHAR(150)				,FlagRevista VARCHAR(150)					,ImagenMiniaturaURL VARCHAR(150)	,EsSubCampania VARCHAR(150))

		insert into @tmpSR exec ListarEstrategiasShowRoom @CampaniaID,@CodigoConsultora
		select CUV2 as CUV, DescripcionCUV2 as Descripcion from @tmpSR

	END
	ELSE IF @Palanca = '9' --LAN
	BEGIN

		declare @tmpLAN TABLE (
			EstrategiaID VARCHAR(150)				,CUV2 VARCHAR(150)							,DescripcionCUV2 VARCHAR(300)				,EtiquetaDescripcion VARCHAR(150)	,Precio VARCHAR(150),
			EtiquetaDescripcion2 VARCHAR(150)		,Precio2 VARCHAR(150)						,TextoLibre VARCHAR(150)					,FlagEstrella VARCHAR(150)			,ColorFondo VARCHAR(150),
			TipoEstrategiaID VARCHAR(150)			,FotoProducto01 VARCHAR(150)				,ImagenURL VARCHAR(150)						,LimiteVenta VARCHAR(150)			,MarcaID VARCHAR(150),
			Orden1 VARCHAR(150)						,Orden2 VARCHAR(150)						,IndicadorMontoMinimo VARCHAR(150)			,FlagNueva VARCHAR(150)				,TipoTallaColor VARCHAR(150),
			TipoEstrategiaImagenMostrar VARCHAR(150),CodigoProducto VARCHAR(150)				,EtiquetaID VARCHAR(150)					,EtiquetaID2 VARCHAR(150)			,CodigoEstrategia VARCHAR(150),
			TieneVariedad VARCHAR(150)				,CODIGO VARCHAR(150)						,DescripcionEstrategia VARCHAR(150)			,FlagMostrarImg VARCHAR(150)		,DescripcionMarca VARCHAR(150),
			DescripcionCategoria VARCHAR(150)		,FlagIndividual VARCHAR(150)				,Slogan VARCHAR(150)						,ImgFondoDesktop VARCHAR(150)		,ImgFichaDesktop VARCHAR(150),
			UrlVideoDesktop VARCHAR(150)			,ImgFichaFondoDesktop VARCHAR(150)			,ImgFondoMobile VARCHAR(150)				,ImgSelloProductoMobile VARCHAR(150),UrlVideoMobile VARCHAR(150),
			ImgFichaFondoMobile VARCHAR(150)		,ImgHomeDesktop VARCHAR(150)				,ImgHomeMobile VARCHAR(150)					,PrecioPublico VARCHAR(150)			,Ganancia VARCHAR(150))

		insert into @tmpLAN exec ListarEstrategiasLanzamiento @CampaniaID,@CodigoConsultora
		select CUV2 as CUV, DescripcionCUV2 as Descripcion from @tmpLAN

	END
	ELSE IF @Palanca = '12' --GND 
	BEGIN

		declare @tmpGND TABLE (
			EstrategiaID VARCHAR(150)				,CUV2 VARCHAR(150)							,DescripcionCUV2 VARCHAR(300)				,EtiquetaDescripcion VARCHAR(150)	,Precio VARCHAR(150),
			EtiquetaDescripcion2 VARCHAR(150)		,Precio2 VARCHAR(150)						,TextoLibre VARCHAR(150)					,FlagEstrella VARCHAR(150)			,ColorFondo VARCHAR(150),
			TipoEstrategiaID VARCHAR(150)			,FotoProducto01 VARCHAR(150)				,ImagenURL VARCHAR(150)						,LimiteVenta VARCHAR(150)			,MarcaID VARCHAR(150),
			Orden1 VARCHAR(150)						,Orden2 VARCHAR(150)						,IndicadorMontoMinimo VARCHAR(150)			,CodigoProducto VARCHAR(150)		,FlagNueva VARCHAR(150),
			TipoTallaColor VARCHAR(150)				,TipoEstrategiaImagenMostrar VARCHAR(150)	,EtiquetaID VARCHAR(150)					,EtiquetaID2 VARCHAR(150)			,CodigoEstrategia VARCHAR(150),
			TieneVariedad VARCHAR(150)				,CODIGO VARCHAR(150)						,DescripcionEstrategia VARCHAR(150)			,FlagMostrarImg VARCHAR(150)		,PrecioPublico VARCHAR(150),
			Ganancia VARCHAR(150)					,DescripcionMarca VARCHAR(150)				,FlagRevista VARCHAR(150))

		insert into @tmpGND exec ListarEstrategiasGuiaDeNegocioDigitalizada @CampaniaID,@CodigoConsultora
		select CUV2 as CUV, DescripcionCUV2 as Descripcion from @tmpGND

	END
END
GO

IF OBJECT_ID('GetReporteMovimientosPedido', 'P') IS NOT NULL 
  DROP PROCEDURE GetReporteMovimientosPedido
  GO

CREATE PROC GetReporteMovimientosPedido
(
	@CampaniaID INT = 0,
	@CodigoConsultora VARCHAR(30) = ''
)
AS
BEGIN

	DECLARE @consultoraId INT
	DECLARE @tipoAccionEliminacionProl INT

	SET @tipoAccionEliminacionProl = 201
	SET @consultoraId = (select consultoraid from ods.consultora where codigo = @CodigoConsultora)

	select
		pwaprol.Cuv, COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, pco.Descripcion) AS Descripcion, FechaAccion, 'PROL' as Origen, MensajeProl as Mensaje
	from 
		[dbo].[PedidoWebAccionesPROL] pwaprol
		LEFT join ods.productocomercial pco with(nolock) ON pwaprol.Cuv = pco.cuv and @CampaniaID = pco.anocampania
		LEFT JOIN dbo.MatrizComercial MC WITH (NOLOCK) ON pco.CodigoProducto = MC.CodigoSAP
		LEFT JOIN dbo.OfertaProducto OP WITH (NOLOCK) ON OP.CampaniaID = pco.anocampania AND OP.CUV = pco.CUV
		LEFT JOIN dbo.ProductoDescripcion PD WITH (NOLOCK) ON pco.anocampania = PD.CampaniaID AND pco.CUV = PD.CUV
	where
		pwaprol.ConsultoraID = @consultoraId and 
		pwaprol.CampaniaID = @CampaniaID and
		pwaprol.Accion = @tipoAccionEliminacionProl

	UNION

	select
		pwdseg.Cuv, COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, pco.Descripcion) AS Descripcion, FechaAccion, 'CONSULTORA' as Origen, '' as Mensaje
	from 
		[dbo].[PedidoWebDetalleSeguimiento] pwdseg
		LEFT join ods.productocomercial pco with(nolock) ON pwdseg.Cuv = pco.cuv and @CampaniaID = pco.anocampania
		LEFT JOIN dbo.MatrizComercial MC WITH (NOLOCK) ON pco.CodigoProducto = MC.CodigoSAP
		LEFT JOIN dbo.OfertaProducto OP WITH (NOLOCK) ON OP.CampaniaID = pco.anocampania AND OP.CUV = pco.CUV
		LEFT JOIN dbo.ProductoDescripcion PD WITH (NOLOCK) ON pco.anocampania = PD.CampaniaID AND pco.CUV = PD.CUV
	where
		pwdseg.ConsultoraID = @consultoraId and 
		pwdseg.CampaniaID = @CampaniaID

END
GO

IF OBJECT_ID('GetReporteCuvResumido', 'P') IS NOT NULL 
  DROP PROCEDURE GetReporteCuvResumido
  GO

CREATE PROC GetReporteCuvResumido
(
	@CampaniaID INT = 0,
	@Cuv VARCHAR(10) = ''
)
AS
BEGIN
	select
		
		pco.Cuv
		, pco.CodigoProducto as SAP
		, COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, est.DescripcionCUV2, pco.Descripcion) AS DescripcionProd
		, isnull(tes.DescripcionEstrategia,'') as Palanca
		, isnull(est.imagenURL,'') as imagenURL
		, case isnull(est.activo,'1') when 1 then 'SI' else 'NO' end as Activo
		, case isnull(pco.IndicadorDigitable,'0') when 1 then 'NO' else 'SI' end as PuedeDigitarse
		, isnull(est.Precio2,pco.PrecioCatalogo) as PrecioSet
	from 
		ods.productocomercial pco with(nolock)
		LEFT JOIN dbo.MatrizComercial MC WITH (NOLOCK) ON pco.CodigoProducto = MC.CodigoSAP
		LEFT JOIN dbo.OfertaProducto OP WITH (NOLOCK) ON OP.CampaniaID = pco.anocampania AND OP.CUV = pco.CUV
		LEFT JOIN dbo.ProductoDescripcion PD WITH (NOLOCK) ON pco.anocampania = PD.CampaniaID AND pco.CUV = PD.CUV
		LEFT JOIN estrategia est with(nolock) on pco.cuv = est.cuv2 and pco.anocampania = est.campaniaid
		LEFT JOIN tipoestrategia tes with(nolock) on est.tipoestrategiaid = tes.tipoestrategiaid
	where
		pco.cuv = @Cuv and 
		pco.anocampania = @CampaniaID
END
GO

USE [BelcorpBolivia]
GO

IF OBJECT_ID('GetReporteCuvDetallado', 'P') IS NOT NULL 
  DROP PROCEDURE GetReporteCuvDetallado
  GO

CREATE PROC GetReporteCuvDetallado
(
	@CampaniaID INT = 0,
	@Cuv VARCHAR(10) = ''
)
AS
BEGIN
	select
		test.DescripcionEstrategia,
		estp.cuv2 as CuvPadre,
		estp.cuv as CuvHijo,
		estp.CodigoEstrategia,
		estp.Grupo,
		estp.SAP,
		mare.Nombre as MarcaEstrategia,
		marpc.Nombre as MarcaMatriz,
		estp.FactorCuadre,
		pco.PrecioUnitario,
		pco.IndicadorPreUni as PrecioPublico,
		estp.Digitable,
		estp.NombreProducto,
		estp.ImagenProducto AS ImagenTipos,
		estp.ImagenBulk AS ImagenTonos,
		estp.NombreBulk,
		pco.FactorRepeticion,
		estp.IdMarca as CodigoMarca
	from 
		estrategiaproducto estp with(nolock)
		INNER JOIN estrategia est with(nolock) on estp.estrategiaid = est.estrategiaid
		INNER JOIN tipoestrategia test with(nolock) on est.tipoestrategiaid = test.tipoestrategiaid
		INNER JOIN ods.productocomercial pco WITH (NOLOCK) ON estp.cuv = pco.cuv and estp.campania = pco.anocampania
		LEFT JOIN ods.marca mare WITH(NOLOCK) ON estp.IdMarca = mare.MarcaId
		LEFT JOIN ods.marca marpc WITH(NOLOCK) ON pco.MarcaID = marpc.MarcaId
		
	where
		(estp.cuv2 = @Cuv OR estp.cuv = @cuv) and
		estp.campania = @CampaniaID
	order by estp.EstrategiaID,estp.cuv2, estp.Grupo
		
END
GO

IF OBJECT_ID('GetReporteEstrategiasPorConsultora', 'P') IS NOT NULL 
  DROP PROCEDURE GetReporteEstrategiasPorConsultora
  GO

CREATE PROC GetReporteEstrategiasPorConsultora
(
	@CampaniaID INT = 0,
	@CodigoConsultora VARCHAR(30) = '',
	@Palanca VARCHAR(3) = '',
	@FechaConsulta DATE
)
AS
BEGIN

	DECLARE @Activa INT = (SELECT TOP 1 1 FROM RevistaDigitalSuscripcion WHERE codigoConsultora = @CodigoConsultora AND CampaniaEfectiva = @CampaniaID AND EstadoRegistro = 1)
	DECLARE @ActivoMDO INT = (SELECT Estado FROM ConfiguracionPaisdatos where codigo='ActivoMDO')

	IF @Palanca = '4'
	BEGIN
		SET @Palanca = '10'
		IF @ActivoMDO <> 1 AND @Activa <> 1
		BEGIN
			SET @Palanca = '4'
		END

	END


	IF @Palanca = '4'--OPT
	BEGIN

		declare @tmpOpt TABLE (
			EstrategiaID VARCHAR(150)				,CUV2 VARCHAR(150)			,DescripcionCUV2 VARCHAR(300)		,EtiquetaDescripcion VARCHAR(150)	,Precio VARCHAR(150),
			EtiquetaDescripcion2 VARCHAR(150)		,Precio2 VARCHAR(150)		,TextoLibre VARCHAR(150)			,FlagEstrella VARCHAR(150)			,ColorFondo VARCHAR(150),
			TipoEstrategiaID VARCHAR(150)			,FotoProducto01 VARCHAR(150),ImagenURL VARCHAR(150)				,LimiteVenta VARCHAR(150)			,MarcaID VARCHAR(150),
			Orden1 VARCHAR(150)						,Orden2 VARCHAR(150)		,IndicadorMontoMinimo VARCHAR(150)	,FlagNueva VARCHAR(150)				,TipoTallaColor VARCHAR(150),
			TipoEstrategiaImagenMostrar VARCHAR(150),CodigoProducto VARCHAR(150),EtiquetaID VARCHAR(150)			,EtiquetaID2 VARCHAR(150)			,CodigoEstrategia VARCHAR(150),
			TieneVariedad VARCHAR(150)				,CODIGO VARCHAR(150)		,DescripcionEstrategia VARCHAR(150)	,FlagMostrarImg VARCHAR(150)		,DescripcionMarca VARCHAR(150),
			DescripcionCategoria VARCHAR(150)		,PrecioPublico VARCHAR(150)	,Ganancia VARCHAR(150))
		
		insert into @tmpOpt exec ListarEstrategiasOPT @CampaniaID,@CodigoConsultora
		select CUV2 as CUV, DescripcionCUV2 as Descripcion from @tmpOpt

	END
	ELSE IF @Palanca = '10' --RD
	BEGIN

		DECLARE @EstrategiaCodigoOPM varchar(100) = '007'
		DECLARE @EstrategiaCodigoPAD varchar(100) = '008'
		DECLARE @TipoPersonalizacionCodigoOpm varchar(3) = 'OPM'
		DECLARE @TipoPersonalizacionCodigoPad varchar(3) = 'PAD'
		DECLARE @TipoPersonalizacionCodigoOpmPad varchar(3) = 'OPM;PAD'

		DECLARE @tablaCuvFaltante TABLE(CUV VARCHAR(6))
		INSERT INTO @tablaCuvFaltante(CUV)
		SELECT CUV FROM [dbo].[ObtenerCuvFaltante](@CampaniaID,@CodigoConsultora)

		DECLARE @CodConsultoraDefault VARCHAR(9) = ''
		SELECT @CodConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001

		DECLARE @CodConsultoraForzada VARCHAR(9) = ''
		SELECT @CodConsultoraForzada = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10002

		DECLARE  @OfertasPersonalizadas TABLE (Orden INT, CUV CHAR(6), TipoPersonalizacion CHAR(3), FlagRevista INT, AnioCampanaVenta INT, TipoEstrategiaId INT)

		INSERT INTO @OfertasPersonalizadas EXEC ListarOfertasPersonalizadas @CampaniaID,@TipoPersonalizacionCodigoOpmPad,@CodigoConsultora

		IF NOT EXISTS (SELECT TOP 1 CUV FROM @OfertasPersonalizadas)
		BEGIN
			INSERT INTO @OfertasPersonalizadas
			EXEC ListarOfertasPersonalizadas @CampaniaID,@TipoPersonalizacionCodigoOpmPad,@codConsultoraDefault
		END

		INSERT INTO @OfertasPersonalizadas EXEC ListarOfertasPersonalizadas @CampaniaID,@TipoPersonalizacionCodigoPad,@codConsultoraForzada
		INSERT INTO @OfertasPersonalizadas EXEC ListarOfertasPersonalizadas @CampaniaID,@TipoPersonalizacionCodigoOpm,@codConsultoraForzada

		SELECT
			E.CUV2 as CUV,
			E.DescripcionCUV2 as Descripcion
		FROM  dbo.Estrategia E with(nolock)
			INNER JOIN @OfertasPersonalizadas op ON E.CampaniaID = op.AnioCampanaVenta AND E.CUV2 = op.CUV AND OP.TipoEstrategiaId = E.TipoEstrategiaId
			INNER JOIN dbo.TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID AND TE.Codigo in (@EstrategiaCodigoOPM, @EstrategiaCodigoPAD)
			LEFT JOIN @tablaCuvFaltante TF ON E.CUV2 = TF.CUV
		WHERE
			E.Activo = 1 AND TE.FlagActivo = 1 AND TE.flagRecoPerfil = 1 AND TF.CUV IS NULL
		ORDER BY OP.Orden ASC, E.EstrategiaID ASC

	END
	ELSE IF @Palanca = '7' --ODD
	BEGIN

		DECLARE @fechaInicioFact DATE
		DECLARE @ZonaId INT
		DECLARE @num INT

		SET @ZonaId = (select ZonaId from ods.consultora where codigo = @CodigoConsultora)
		SET @fechaInicioFact = 
			(SELECT C.FechaInicioFacturacion 
			FROM ods.Cronograma C  
			INNER JOIN ods.Campania Ca ON C.CampaniaID = Ca.CampaniaID
			INNER JOIN [ods].[Zona] z (nolock) ON C.RegionID = z.RegionID AND c.ZonaID = z.ZonaID	
			WHERE Ca.Codigo = @CampaniaID AND Z.ZonaID = CASE WHEN @ZonaID = -1 THEN Z.ZonaID ELSE @ZonaID END)

		SET @num = (DATEDIFF(dd, @FechaConsulta, GETDATE()))
		SET @fechaInicioFact = (DATEADD(dd, @num, @fechaInicioFact))

		declare @tmpODD TABLE (
			EstrategiaID VARCHAR(150)				,CUV2 VARCHAR(150)				,DescripcionCUV2 VARCHAR(300)				,EtiquetaDescripcion VARCHAR(150)	,Precio VARCHAR(150),
			EtiquetaDescripcion2 VARCHAR(150)		,Precio2 VARCHAR(150)			,TextoLibre VARCHAR(150)					,CodigoEstrategia VARCHAR(150)		,FlagEstrella VARCHAR(150),
			ColorFondo VARCHAR(150)					,TipoEstrategiaID VARCHAR(150)	,FotoProducto01 VARCHAR(150)				,ImagenURL VARCHAR(150)				,LimiteVenta VARCHAR(150),
			MarcaID VARCHAR(150)					,Orden1 VARCHAR(150)			,Orden2 VARCHAR(150)						,IndicadorMontoMinimo VARCHAR(150)	,CodigoProducto VARCHAR(150),
			FlagNueva VARCHAR(150)					,TipoTallaColor VARCHAR(150)	,TipoEstrategiaImagenMostrar VARCHAR(150)	,EtiquetaID VARCHAR(150)			,EtiquetaID2 VARCHAR(150),
			CodigoEstrategia2 VARCHAR(150)			,TieneVariedad VARCHAR(150)		,CODIGO VARCHAR(150)						,DescripcionEstrategia VARCHAR(150)	,FlagMostrarImg VARCHAR(150),
			PrecioPublico VARCHAR(150)				,Ganancia VARCHAR(150)			,DescripcionMarca VARCHAR(150)				,FlagRevista VARCHAR(150)			,ImagenMiniaturaURL VARCHAR(150),
			DiaInicio VARCHAR(150))	

		insert into @tmpODD exec ListarEstrategiasODD2 @CampaniaID,@CodigoConsultora,@fechaInicioFact
		select CUV2 as CUV, DescripcionCUV2 as Descripcion from @tmpODD

	END
	ELSE IF @Palanca = '30' --SR
	BEGIN

		declare @tmpSR TABLE (
			EstrategiaID VARCHAR(150)				,CUV2 VARCHAR(150)							,DescripcionCUV2 VARCHAR(300)				,EtiquetaDescripcion VARCHAR(150)	,Precio VARCHAR(150),
			EtiquetaDescripcion2 VARCHAR(150)		,Precio2 VARCHAR(150)						,TextoLibre VARCHAR(150)					,FlagEstrella VARCHAR(150)			,ColorFondo VARCHAR(150),
			TipoEstrategiaID VARCHAR(150)			,FotoProducto01 VARCHAR(150)				,ImagenURL VARCHAR(150)						,LimiteVenta VARCHAR(150)			,MarcaID VARCHAR(150),
			Orden1 VARCHAR(150)						,Orden2 VARCHAR(150)						,IndicadorMontoMinimo VARCHAR(150)			,CodigoProducto VARCHAR(150)		,FlagNueva VARCHAR(150),
			TipoTallaColor VARCHAR(150)				,TipoEstrategiaImagenMostrar VARCHAR(150)	,EtiquetaID VARCHAR(150)					,EtiquetaID2 VARCHAR(150)			,CodigoEstrategia VARCHAR(150),
			TieneVariedad VARCHAR(150)				,CODIGO VARCHAR(150)						,DescripcionEstrategia VARCHAR(150)			,FlagMostrarImg VARCHAR(150)		,PrecioPublico VARCHAR(150),
			Ganancia VARCHAR(150)					,DescripcionMarca VARCHAR(150)				,FlagRevista VARCHAR(150)					,ImagenMiniaturaURL VARCHAR(150)	,EsSubCampania VARCHAR(150))

		insert into @tmpSR exec ListarEstrategiasShowRoom @CampaniaID,@CodigoConsultora
		select CUV2 as CUV, DescripcionCUV2 as Descripcion from @tmpSR

	END
	ELSE IF @Palanca = '9' --LAN
	BEGIN

		declare @tmpLAN TABLE (
			EstrategiaID VARCHAR(150)				,CUV2 VARCHAR(150)							,DescripcionCUV2 VARCHAR(300)				,EtiquetaDescripcion VARCHAR(150)	,Precio VARCHAR(150),
			EtiquetaDescripcion2 VARCHAR(150)		,Precio2 VARCHAR(150)						,TextoLibre VARCHAR(150)					,FlagEstrella VARCHAR(150)			,ColorFondo VARCHAR(150),
			TipoEstrategiaID VARCHAR(150)			,FotoProducto01 VARCHAR(150)				,ImagenURL VARCHAR(150)						,LimiteVenta VARCHAR(150)			,MarcaID VARCHAR(150),
			Orden1 VARCHAR(150)						,Orden2 VARCHAR(150)						,IndicadorMontoMinimo VARCHAR(150)			,FlagNueva VARCHAR(150)				,TipoTallaColor VARCHAR(150),
			TipoEstrategiaImagenMostrar VARCHAR(150),CodigoProducto VARCHAR(150)				,EtiquetaID VARCHAR(150)					,EtiquetaID2 VARCHAR(150)			,CodigoEstrategia VARCHAR(150),
			TieneVariedad VARCHAR(150)				,CODIGO VARCHAR(150)						,DescripcionEstrategia VARCHAR(150)			,FlagMostrarImg VARCHAR(150)		,DescripcionMarca VARCHAR(150),
			DescripcionCategoria VARCHAR(150)		,FlagIndividual VARCHAR(150)				,Slogan VARCHAR(150)						,ImgFondoDesktop VARCHAR(150)		,ImgFichaDesktop VARCHAR(150),
			UrlVideoDesktop VARCHAR(150)			,ImgFichaFondoDesktop VARCHAR(150)			,ImgFondoMobile VARCHAR(150)				,ImgSelloProductoMobile VARCHAR(150),UrlVideoMobile VARCHAR(150),
			ImgFichaFondoMobile VARCHAR(150)		,ImgHomeDesktop VARCHAR(150)				,ImgHomeMobile VARCHAR(150)					,PrecioPublico VARCHAR(150)			,Ganancia VARCHAR(150))

		insert into @tmpLAN exec ListarEstrategiasLanzamiento @CampaniaID,@CodigoConsultora
		select CUV2 as CUV, DescripcionCUV2 as Descripcion from @tmpLAN

	END
	ELSE IF @Palanca = '12' --GND 
	BEGIN

		declare @tmpGND TABLE (
			EstrategiaID VARCHAR(150)				,CUV2 VARCHAR(150)							,DescripcionCUV2 VARCHAR(300)				,EtiquetaDescripcion VARCHAR(150)	,Precio VARCHAR(150),
			EtiquetaDescripcion2 VARCHAR(150)		,Precio2 VARCHAR(150)						,TextoLibre VARCHAR(150)					,FlagEstrella VARCHAR(150)			,ColorFondo VARCHAR(150),
			TipoEstrategiaID VARCHAR(150)			,FotoProducto01 VARCHAR(150)				,ImagenURL VARCHAR(150)						,LimiteVenta VARCHAR(150)			,MarcaID VARCHAR(150),
			Orden1 VARCHAR(150)						,Orden2 VARCHAR(150)						,IndicadorMontoMinimo VARCHAR(150)			,CodigoProducto VARCHAR(150)		,FlagNueva VARCHAR(150),
			TipoTallaColor VARCHAR(150)				,TipoEstrategiaImagenMostrar VARCHAR(150)	,EtiquetaID VARCHAR(150)					,EtiquetaID2 VARCHAR(150)			,CodigoEstrategia VARCHAR(150),
			TieneVariedad VARCHAR(150)				,CODIGO VARCHAR(150)						,DescripcionEstrategia VARCHAR(150)			,FlagMostrarImg VARCHAR(150)		,PrecioPublico VARCHAR(150),
			Ganancia VARCHAR(150)					,DescripcionMarca VARCHAR(150)				,FlagRevista VARCHAR(150))

		insert into @tmpGND exec ListarEstrategiasGuiaDeNegocioDigitalizada @CampaniaID,@CodigoConsultora
		select CUV2 as CUV, DescripcionCUV2 as Descripcion from @tmpGND

	END
END
GO

IF OBJECT_ID('GetReporteMovimientosPedido', 'P') IS NOT NULL 
  DROP PROCEDURE GetReporteMovimientosPedido
  GO

CREATE PROC GetReporteMovimientosPedido
(
	@CampaniaID INT = 0,
	@CodigoConsultora VARCHAR(30) = ''
)
AS
BEGIN

	DECLARE @consultoraId INT
	DECLARE @tipoAccionEliminacionProl INT

	SET @tipoAccionEliminacionProl = 201
	SET @consultoraId = (select consultoraid from ods.consultora where codigo = @CodigoConsultora)

	select
		pwaprol.Cuv, COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, pco.Descripcion) AS Descripcion, FechaAccion, 'PROL' as Origen, MensajeProl as Mensaje
	from 
		[dbo].[PedidoWebAccionesPROL] pwaprol
		LEFT join ods.productocomercial pco with(nolock) ON pwaprol.Cuv = pco.cuv and @CampaniaID = pco.anocampania
		LEFT JOIN dbo.MatrizComercial MC WITH (NOLOCK) ON pco.CodigoProducto = MC.CodigoSAP
		LEFT JOIN dbo.OfertaProducto OP WITH (NOLOCK) ON OP.CampaniaID = pco.anocampania AND OP.CUV = pco.CUV
		LEFT JOIN dbo.ProductoDescripcion PD WITH (NOLOCK) ON pco.anocampania = PD.CampaniaID AND pco.CUV = PD.CUV
	where
		pwaprol.ConsultoraID = @consultoraId and 
		pwaprol.CampaniaID = @CampaniaID and
		pwaprol.Accion = @tipoAccionEliminacionProl

	UNION

	select
		pwdseg.Cuv, COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, pco.Descripcion) AS Descripcion, FechaAccion, 'CONSULTORA' as Origen, '' as Mensaje
	from 
		[dbo].[PedidoWebDetalleSeguimiento] pwdseg
		LEFT join ods.productocomercial pco with(nolock) ON pwdseg.Cuv = pco.cuv and @CampaniaID = pco.anocampania
		LEFT JOIN dbo.MatrizComercial MC WITH (NOLOCK) ON pco.CodigoProducto = MC.CodigoSAP
		LEFT JOIN dbo.OfertaProducto OP WITH (NOLOCK) ON OP.CampaniaID = pco.anocampania AND OP.CUV = pco.CUV
		LEFT JOIN dbo.ProductoDescripcion PD WITH (NOLOCK) ON pco.anocampania = PD.CampaniaID AND pco.CUV = PD.CUV
	where
		pwdseg.ConsultoraID = @consultoraId and 
		pwdseg.CampaniaID = @CampaniaID

END
GO

IF OBJECT_ID('GetReporteCuvResumido', 'P') IS NOT NULL 
  DROP PROCEDURE GetReporteCuvResumido
  GO

CREATE PROC GetReporteCuvResumido
(
	@CampaniaID INT = 0,
	@Cuv VARCHAR(10) = ''
)
AS
BEGIN
	select
		
		pco.Cuv
		, pco.CodigoProducto as SAP
		, COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, est.DescripcionCUV2, pco.Descripcion) AS DescripcionProd
		, isnull(tes.DescripcionEstrategia,'') as Palanca
		, isnull(est.imagenURL,'') as imagenURL
		, case isnull(est.activo,'1') when 1 then 'SI' else 'NO' end as Activo
		, case isnull(pco.IndicadorDigitable,'0') when 1 then 'NO' else 'SI' end as PuedeDigitarse
		, isnull(est.Precio2,pco.PrecioCatalogo) as PrecioSet
	from 
		ods.productocomercial pco with(nolock)
		LEFT JOIN dbo.MatrizComercial MC WITH (NOLOCK) ON pco.CodigoProducto = MC.CodigoSAP
		LEFT JOIN dbo.OfertaProducto OP WITH (NOLOCK) ON OP.CampaniaID = pco.anocampania AND OP.CUV = pco.CUV
		LEFT JOIN dbo.ProductoDescripcion PD WITH (NOLOCK) ON pco.anocampania = PD.CampaniaID AND pco.CUV = PD.CUV
		LEFT JOIN estrategia est with(nolock) on pco.cuv = est.cuv2 and pco.anocampania = est.campaniaid
		LEFT JOIN tipoestrategia tes with(nolock) on est.tipoestrategiaid = tes.tipoestrategiaid
	where
		pco.cuv = @Cuv and 
		pco.anocampania = @CampaniaID
END
GO


USE [BelcorpChile]
GO

IF OBJECT_ID('GetReporteCuvDetallado', 'P') IS NOT NULL 
  DROP PROCEDURE GetReporteCuvDetallado
  GO

CREATE PROC GetReporteCuvDetallado
(
	@CampaniaID INT = 0,
	@Cuv VARCHAR(10) = ''
)
AS
BEGIN
	select
		test.DescripcionEstrategia,
		estp.cuv2 as CuvPadre,
		estp.cuv as CuvHijo,
		estp.CodigoEstrategia,
		estp.Grupo,
		estp.SAP,
		mare.Nombre as MarcaEstrategia,
		marpc.Nombre as MarcaMatriz,
		estp.FactorCuadre,
		pco.PrecioUnitario,
		pco.IndicadorPreUni as PrecioPublico,
		estp.Digitable,
		estp.NombreProducto,
		estp.ImagenProducto AS ImagenTipos,
		estp.ImagenBulk AS ImagenTonos,
		estp.NombreBulk,
		pco.FactorRepeticion,
		estp.IdMarca as CodigoMarca
	from 
		estrategiaproducto estp with(nolock)
		INNER JOIN estrategia est with(nolock) on estp.estrategiaid = est.estrategiaid
		INNER JOIN tipoestrategia test with(nolock) on est.tipoestrategiaid = test.tipoestrategiaid
		INNER JOIN ods.productocomercial pco WITH (NOLOCK) ON estp.cuv = pco.cuv and estp.campania = pco.anocampania
		LEFT JOIN ods.marca mare WITH(NOLOCK) ON estp.IdMarca = mare.MarcaId
		LEFT JOIN ods.marca marpc WITH(NOLOCK) ON pco.MarcaID = marpc.MarcaId
		
	where
		(estp.cuv2 = @Cuv OR estp.cuv = @cuv) and
		estp.campania = @CampaniaID
	order by estp.EstrategiaID,estp.cuv2, estp.Grupo
		
END
GO

IF OBJECT_ID('GetReporteEstrategiasPorConsultora', 'P') IS NOT NULL 
  DROP PROCEDURE GetReporteEstrategiasPorConsultora
  GO

CREATE PROC GetReporteEstrategiasPorConsultora
(
	@CampaniaID INT = 0,
	@CodigoConsultora VARCHAR(30) = '',
	@Palanca VARCHAR(3) = '',
	@FechaConsulta DATE
)
AS
BEGIN

	DECLARE @Activa INT = (SELECT TOP 1 1 FROM RevistaDigitalSuscripcion WHERE codigoConsultora = @CodigoConsultora AND CampaniaEfectiva = @CampaniaID AND EstadoRegistro = 1)
	DECLARE @ActivoMDO INT = (SELECT Estado FROM ConfiguracionPaisdatos where codigo='ActivoMDO')

	IF @Palanca = '4'
	BEGIN
		SET @Palanca = '10'
		IF @ActivoMDO <> 1 AND @Activa <> 1
		BEGIN
			SET @Palanca = '4'
		END

	END


	IF @Palanca = '4'--OPT
	BEGIN

		declare @tmpOpt TABLE (
			EstrategiaID VARCHAR(150)				,CUV2 VARCHAR(150)			,DescripcionCUV2 VARCHAR(300)		,EtiquetaDescripcion VARCHAR(150)	,Precio VARCHAR(150),
			EtiquetaDescripcion2 VARCHAR(150)		,Precio2 VARCHAR(150)		,TextoLibre VARCHAR(150)			,FlagEstrella VARCHAR(150)			,ColorFondo VARCHAR(150),
			TipoEstrategiaID VARCHAR(150)			,FotoProducto01 VARCHAR(150),ImagenURL VARCHAR(150)				,LimiteVenta VARCHAR(150)			,MarcaID VARCHAR(150),
			Orden1 VARCHAR(150)						,Orden2 VARCHAR(150)		,IndicadorMontoMinimo VARCHAR(150)	,FlagNueva VARCHAR(150)				,TipoTallaColor VARCHAR(150),
			TipoEstrategiaImagenMostrar VARCHAR(150),CodigoProducto VARCHAR(150),EtiquetaID VARCHAR(150)			,EtiquetaID2 VARCHAR(150)			,CodigoEstrategia VARCHAR(150),
			TieneVariedad VARCHAR(150)				,CODIGO VARCHAR(150)		,DescripcionEstrategia VARCHAR(150)	,FlagMostrarImg VARCHAR(150)		,DescripcionMarca VARCHAR(150),
			DescripcionCategoria VARCHAR(150)		,PrecioPublico VARCHAR(150)	,Ganancia VARCHAR(150))
		
		insert into @tmpOpt exec ListarEstrategiasOPT @CampaniaID,@CodigoConsultora
		select CUV2 as CUV, DescripcionCUV2 as Descripcion from @tmpOpt

	END
	ELSE IF @Palanca = '10' --RD
	BEGIN

		DECLARE @EstrategiaCodigoOPM varchar(100) = '007'
		DECLARE @EstrategiaCodigoPAD varchar(100) = '008'
		DECLARE @TipoPersonalizacionCodigoOpm varchar(3) = 'OPM'
		DECLARE @TipoPersonalizacionCodigoPad varchar(3) = 'PAD'
		DECLARE @TipoPersonalizacionCodigoOpmPad varchar(3) = 'OPM;PAD'

		DECLARE @tablaCuvFaltante TABLE(CUV VARCHAR(6))
		INSERT INTO @tablaCuvFaltante(CUV)
		SELECT CUV FROM [dbo].[ObtenerCuvFaltante](@CampaniaID,@CodigoConsultora)

		DECLARE @CodConsultoraDefault VARCHAR(9) = ''
		SELECT @CodConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001

		DECLARE @CodConsultoraForzada VARCHAR(9) = ''
		SELECT @CodConsultoraForzada = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10002

		DECLARE  @OfertasPersonalizadas TABLE (Orden INT, CUV CHAR(6), TipoPersonalizacion CHAR(3), FlagRevista INT, AnioCampanaVenta INT, TipoEstrategiaId INT)

		INSERT INTO @OfertasPersonalizadas EXEC ListarOfertasPersonalizadas @CampaniaID,@TipoPersonalizacionCodigoOpmPad,@CodigoConsultora

		IF NOT EXISTS (SELECT TOP 1 CUV FROM @OfertasPersonalizadas)
		BEGIN
			INSERT INTO @OfertasPersonalizadas
			EXEC ListarOfertasPersonalizadas @CampaniaID,@TipoPersonalizacionCodigoOpmPad,@codConsultoraDefault
		END

		INSERT INTO @OfertasPersonalizadas EXEC ListarOfertasPersonalizadas @CampaniaID,@TipoPersonalizacionCodigoPad,@codConsultoraForzada
		INSERT INTO @OfertasPersonalizadas EXEC ListarOfertasPersonalizadas @CampaniaID,@TipoPersonalizacionCodigoOpm,@codConsultoraForzada

		SELECT
			E.CUV2 as CUV,
			E.DescripcionCUV2 as Descripcion
		FROM  dbo.Estrategia E with(nolock)
			INNER JOIN @OfertasPersonalizadas op ON E.CampaniaID = op.AnioCampanaVenta AND E.CUV2 = op.CUV AND OP.TipoEstrategiaId = E.TipoEstrategiaId
			INNER JOIN dbo.TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID AND TE.Codigo in (@EstrategiaCodigoOPM, @EstrategiaCodigoPAD)
			LEFT JOIN @tablaCuvFaltante TF ON E.CUV2 = TF.CUV
		WHERE
			E.Activo = 1 AND TE.FlagActivo = 1 AND TE.flagRecoPerfil = 1 AND TF.CUV IS NULL
		ORDER BY OP.Orden ASC, E.EstrategiaID ASC

	END
	ELSE IF @Palanca = '7' --ODD
	BEGIN

		DECLARE @fechaInicioFact DATE
		DECLARE @ZonaId INT
		DECLARE @num INT

		SET @ZonaId = (select ZonaId from ods.consultora where codigo = @CodigoConsultora)
		SET @fechaInicioFact = 
			(SELECT C.FechaInicioFacturacion 
			FROM ods.Cronograma C  
			INNER JOIN ods.Campania Ca ON C.CampaniaID = Ca.CampaniaID
			INNER JOIN [ods].[Zona] z (nolock) ON C.RegionID = z.RegionID AND c.ZonaID = z.ZonaID	
			WHERE Ca.Codigo = @CampaniaID AND Z.ZonaID = CASE WHEN @ZonaID = -1 THEN Z.ZonaID ELSE @ZonaID END)

		SET @num = (DATEDIFF(dd, @FechaConsulta, GETDATE()))
		SET @fechaInicioFact = (DATEADD(dd, @num, @fechaInicioFact))

		declare @tmpODD TABLE (
			EstrategiaID VARCHAR(150)				,CUV2 VARCHAR(150)				,DescripcionCUV2 VARCHAR(300)				,EtiquetaDescripcion VARCHAR(150)	,Precio VARCHAR(150),
			EtiquetaDescripcion2 VARCHAR(150)		,Precio2 VARCHAR(150)			,TextoLibre VARCHAR(150)					,CodigoEstrategia VARCHAR(150)		,FlagEstrella VARCHAR(150),
			ColorFondo VARCHAR(150)					,TipoEstrategiaID VARCHAR(150)	,FotoProducto01 VARCHAR(150)				,ImagenURL VARCHAR(150)				,LimiteVenta VARCHAR(150),
			MarcaID VARCHAR(150)					,Orden1 VARCHAR(150)			,Orden2 VARCHAR(150)						,IndicadorMontoMinimo VARCHAR(150)	,CodigoProducto VARCHAR(150),
			FlagNueva VARCHAR(150)					,TipoTallaColor VARCHAR(150)	,TipoEstrategiaImagenMostrar VARCHAR(150)	,EtiquetaID VARCHAR(150)			,EtiquetaID2 VARCHAR(150),
			CodigoEstrategia2 VARCHAR(150)			,TieneVariedad VARCHAR(150)		,CODIGO VARCHAR(150)						,DescripcionEstrategia VARCHAR(150)	,FlagMostrarImg VARCHAR(150),
			PrecioPublico VARCHAR(150)				,Ganancia VARCHAR(150)			,DescripcionMarca VARCHAR(150)				,FlagRevista VARCHAR(150)			,ImagenMiniaturaURL VARCHAR(150),
			DiaInicio VARCHAR(150))	

		insert into @tmpODD exec ListarEstrategiasODD2 @CampaniaID,@CodigoConsultora,@fechaInicioFact
		select CUV2 as CUV, DescripcionCUV2 as Descripcion from @tmpODD

	END
	ELSE IF @Palanca = '30' --SR
	BEGIN

		declare @tmpSR TABLE (
			EstrategiaID VARCHAR(150)				,CUV2 VARCHAR(150)							,DescripcionCUV2 VARCHAR(300)				,EtiquetaDescripcion VARCHAR(150)	,Precio VARCHAR(150),
			EtiquetaDescripcion2 VARCHAR(150)		,Precio2 VARCHAR(150)						,TextoLibre VARCHAR(150)					,FlagEstrella VARCHAR(150)			,ColorFondo VARCHAR(150),
			TipoEstrategiaID VARCHAR(150)			,FotoProducto01 VARCHAR(150)				,ImagenURL VARCHAR(150)						,LimiteVenta VARCHAR(150)			,MarcaID VARCHAR(150),
			Orden1 VARCHAR(150)						,Orden2 VARCHAR(150)						,IndicadorMontoMinimo VARCHAR(150)			,CodigoProducto VARCHAR(150)		,FlagNueva VARCHAR(150),
			TipoTallaColor VARCHAR(150)				,TipoEstrategiaImagenMostrar VARCHAR(150)	,EtiquetaID VARCHAR(150)					,EtiquetaID2 VARCHAR(150)			,CodigoEstrategia VARCHAR(150),
			TieneVariedad VARCHAR(150)				,CODIGO VARCHAR(150)						,DescripcionEstrategia VARCHAR(150)			,FlagMostrarImg VARCHAR(150)		,PrecioPublico VARCHAR(150),
			Ganancia VARCHAR(150)					,DescripcionMarca VARCHAR(150)				,FlagRevista VARCHAR(150)					,ImagenMiniaturaURL VARCHAR(150)	,EsSubCampania VARCHAR(150))

		insert into @tmpSR exec ListarEstrategiasShowRoom @CampaniaID,@CodigoConsultora
		select CUV2 as CUV, DescripcionCUV2 as Descripcion from @tmpSR

	END
	ELSE IF @Palanca = '9' --LAN
	BEGIN

		declare @tmpLAN TABLE (
			EstrategiaID VARCHAR(150)				,CUV2 VARCHAR(150)							,DescripcionCUV2 VARCHAR(300)				,EtiquetaDescripcion VARCHAR(150)	,Precio VARCHAR(150),
			EtiquetaDescripcion2 VARCHAR(150)		,Precio2 VARCHAR(150)						,TextoLibre VARCHAR(150)					,FlagEstrella VARCHAR(150)			,ColorFondo VARCHAR(150),
			TipoEstrategiaID VARCHAR(150)			,FotoProducto01 VARCHAR(150)				,ImagenURL VARCHAR(150)						,LimiteVenta VARCHAR(150)			,MarcaID VARCHAR(150),
			Orden1 VARCHAR(150)						,Orden2 VARCHAR(150)						,IndicadorMontoMinimo VARCHAR(150)			,FlagNueva VARCHAR(150)				,TipoTallaColor VARCHAR(150),
			TipoEstrategiaImagenMostrar VARCHAR(150),CodigoProducto VARCHAR(150)				,EtiquetaID VARCHAR(150)					,EtiquetaID2 VARCHAR(150)			,CodigoEstrategia VARCHAR(150),
			TieneVariedad VARCHAR(150)				,CODIGO VARCHAR(150)						,DescripcionEstrategia VARCHAR(150)			,FlagMostrarImg VARCHAR(150)		,DescripcionMarca VARCHAR(150),
			DescripcionCategoria VARCHAR(150)		,FlagIndividual VARCHAR(150)				,Slogan VARCHAR(150)						,ImgFondoDesktop VARCHAR(150)		,ImgFichaDesktop VARCHAR(150),
			UrlVideoDesktop VARCHAR(150)			,ImgFichaFondoDesktop VARCHAR(150)			,ImgFondoMobile VARCHAR(150)				,ImgSelloProductoMobile VARCHAR(150),UrlVideoMobile VARCHAR(150),
			ImgFichaFondoMobile VARCHAR(150)		,ImgHomeDesktop VARCHAR(150)				,ImgHomeMobile VARCHAR(150)					,PrecioPublico VARCHAR(150)			,Ganancia VARCHAR(150))

		insert into @tmpLAN exec ListarEstrategiasLanzamiento @CampaniaID,@CodigoConsultora
		select CUV2 as CUV, DescripcionCUV2 as Descripcion from @tmpLAN

	END
	ELSE IF @Palanca = '12' --GND 
	BEGIN

		declare @tmpGND TABLE (
			EstrategiaID VARCHAR(150)				,CUV2 VARCHAR(150)							,DescripcionCUV2 VARCHAR(300)				,EtiquetaDescripcion VARCHAR(150)	,Precio VARCHAR(150),
			EtiquetaDescripcion2 VARCHAR(150)		,Precio2 VARCHAR(150)						,TextoLibre VARCHAR(150)					,FlagEstrella VARCHAR(150)			,ColorFondo VARCHAR(150),
			TipoEstrategiaID VARCHAR(150)			,FotoProducto01 VARCHAR(150)				,ImagenURL VARCHAR(150)						,LimiteVenta VARCHAR(150)			,MarcaID VARCHAR(150),
			Orden1 VARCHAR(150)						,Orden2 VARCHAR(150)						,IndicadorMontoMinimo VARCHAR(150)			,CodigoProducto VARCHAR(150)		,FlagNueva VARCHAR(150),
			TipoTallaColor VARCHAR(150)				,TipoEstrategiaImagenMostrar VARCHAR(150)	,EtiquetaID VARCHAR(150)					,EtiquetaID2 VARCHAR(150)			,CodigoEstrategia VARCHAR(150),
			TieneVariedad VARCHAR(150)				,CODIGO VARCHAR(150)						,DescripcionEstrategia VARCHAR(150)			,FlagMostrarImg VARCHAR(150)		,PrecioPublico VARCHAR(150),
			Ganancia VARCHAR(150)					,DescripcionMarca VARCHAR(150)				,FlagRevista VARCHAR(150))

		insert into @tmpGND exec ListarEstrategiasGuiaDeNegocioDigitalizada @CampaniaID,@CodigoConsultora
		select CUV2 as CUV, DescripcionCUV2 as Descripcion from @tmpGND

	END
END
GO

IF OBJECT_ID('GetReporteMovimientosPedido', 'P') IS NOT NULL 
  DROP PROCEDURE GetReporteMovimientosPedido
  GO

CREATE PROC GetReporteMovimientosPedido
(
	@CampaniaID INT = 0,
	@CodigoConsultora VARCHAR(30) = ''
)
AS
BEGIN

	DECLARE @consultoraId INT
	DECLARE @tipoAccionEliminacionProl INT

	SET @tipoAccionEliminacionProl = 201
	SET @consultoraId = (select consultoraid from ods.consultora where codigo = @CodigoConsultora)

	select
		pwaprol.Cuv, COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, pco.Descripcion) AS Descripcion, FechaAccion, 'PROL' as Origen, MensajeProl as Mensaje
	from 
		[dbo].[PedidoWebAccionesPROL] pwaprol
		LEFT join ods.productocomercial pco with(nolock) ON pwaprol.Cuv = pco.cuv and @CampaniaID = pco.anocampania
		LEFT JOIN dbo.MatrizComercial MC WITH (NOLOCK) ON pco.CodigoProducto = MC.CodigoSAP
		LEFT JOIN dbo.OfertaProducto OP WITH (NOLOCK) ON OP.CampaniaID = pco.anocampania AND OP.CUV = pco.CUV
		LEFT JOIN dbo.ProductoDescripcion PD WITH (NOLOCK) ON pco.anocampania = PD.CampaniaID AND pco.CUV = PD.CUV
	where
		pwaprol.ConsultoraID = @consultoraId and 
		pwaprol.CampaniaID = @CampaniaID and
		pwaprol.Accion = @tipoAccionEliminacionProl

	UNION

	select
		pwdseg.Cuv, COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, pco.Descripcion) AS Descripcion, FechaAccion, 'CONSULTORA' as Origen, '' as Mensaje
	from 
		[dbo].[PedidoWebDetalleSeguimiento] pwdseg
		LEFT join ods.productocomercial pco with(nolock) ON pwdseg.Cuv = pco.cuv and @CampaniaID = pco.anocampania
		LEFT JOIN dbo.MatrizComercial MC WITH (NOLOCK) ON pco.CodigoProducto = MC.CodigoSAP
		LEFT JOIN dbo.OfertaProducto OP WITH (NOLOCK) ON OP.CampaniaID = pco.anocampania AND OP.CUV = pco.CUV
		LEFT JOIN dbo.ProductoDescripcion PD WITH (NOLOCK) ON pco.anocampania = PD.CampaniaID AND pco.CUV = PD.CUV
	where
		pwdseg.ConsultoraID = @consultoraId and 
		pwdseg.CampaniaID = @CampaniaID

END
GO

IF OBJECT_ID('GetReporteCuvResumido', 'P') IS NOT NULL 
  DROP PROCEDURE GetReporteCuvResumido
  GO

CREATE PROC GetReporteCuvResumido
(
	@CampaniaID INT = 0,
	@Cuv VARCHAR(10) = ''
)
AS
BEGIN
	select
		
		pco.Cuv
		, pco.CodigoProducto as SAP
		, COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, est.DescripcionCUV2, pco.Descripcion) AS DescripcionProd
		, isnull(tes.DescripcionEstrategia,'') as Palanca
		, isnull(est.imagenURL,'') as imagenURL
		, case isnull(est.activo,'1') when 1 then 'SI' else 'NO' end as Activo
		, case isnull(pco.IndicadorDigitable,'0') when 1 then 'NO' else 'SI' end as PuedeDigitarse
		, isnull(est.Precio2,pco.PrecioCatalogo) as PrecioSet
	from 
		ods.productocomercial pco with(nolock)
		LEFT JOIN dbo.MatrizComercial MC WITH (NOLOCK) ON pco.CodigoProducto = MC.CodigoSAP
		LEFT JOIN dbo.OfertaProducto OP WITH (NOLOCK) ON OP.CampaniaID = pco.anocampania AND OP.CUV = pco.CUV
		LEFT JOIN dbo.ProductoDescripcion PD WITH (NOLOCK) ON pco.anocampania = PD.CampaniaID AND pco.CUV = PD.CUV
		LEFT JOIN estrategia est with(nolock) on pco.cuv = est.cuv2 and pco.anocampania = est.campaniaid
		LEFT JOIN tipoestrategia tes with(nolock) on est.tipoestrategiaid = tes.tipoestrategiaid
	where
		pco.cuv = @Cuv and 
		pco.anocampania = @CampaniaID
END
GO


USE [BelcorpColombia]
GO

IF OBJECT_ID('GetReporteCuvDetallado', 'P') IS NOT NULL 
  DROP PROCEDURE GetReporteCuvDetallado
  GO

CREATE PROC GetReporteCuvDetallado
(
	@CampaniaID INT = 0,
	@Cuv VARCHAR(10) = ''
)
AS
BEGIN
	select
		test.DescripcionEstrategia,
		estp.cuv2 as CuvPadre,
		estp.cuv as CuvHijo,
		estp.CodigoEstrategia,
		estp.Grupo,
		estp.SAP,
		mare.Nombre as MarcaEstrategia,
		marpc.Nombre as MarcaMatriz,
		estp.FactorCuadre,
		pco.PrecioUnitario,
		pco.IndicadorPreUni as PrecioPublico,
		estp.Digitable,
		estp.NombreProducto,
		estp.ImagenProducto AS ImagenTipos,
		estp.ImagenBulk AS ImagenTonos,
		estp.NombreBulk,
		pco.FactorRepeticion,
		estp.IdMarca as CodigoMarca
	from 
		estrategiaproducto estp with(nolock)
		INNER JOIN estrategia est with(nolock) on estp.estrategiaid = est.estrategiaid
		INNER JOIN tipoestrategia test with(nolock) on est.tipoestrategiaid = test.tipoestrategiaid
		INNER JOIN ods.productocomercial pco WITH (NOLOCK) ON estp.cuv = pco.cuv and estp.campania = pco.anocampania
		LEFT JOIN ods.marca mare WITH(NOLOCK) ON estp.IdMarca = mare.MarcaId
		LEFT JOIN ods.marca marpc WITH(NOLOCK) ON pco.MarcaID = marpc.MarcaId
		
	where
		(estp.cuv2 = @Cuv OR estp.cuv = @cuv) and
		estp.campania = @CampaniaID
	order by estp.EstrategiaID,estp.cuv2, estp.Grupo
		
END
GO

IF OBJECT_ID('GetReporteEstrategiasPorConsultora', 'P') IS NOT NULL 
  DROP PROCEDURE GetReporteEstrategiasPorConsultora
  GO

CREATE PROC GetReporteEstrategiasPorConsultora
(
	@CampaniaID INT = 0,
	@CodigoConsultora VARCHAR(30) = '',
	@Palanca VARCHAR(3) = '',
	@FechaConsulta DATE
)
AS
BEGIN

	DECLARE @Activa INT = (SELECT TOP 1 1 FROM RevistaDigitalSuscripcion WHERE codigoConsultora = @CodigoConsultora AND CampaniaEfectiva = @CampaniaID AND EstadoRegistro = 1)
	DECLARE @ActivoMDO INT = (SELECT Estado FROM ConfiguracionPaisdatos where codigo='ActivoMDO')

	IF @Palanca = '4'
	BEGIN
		SET @Palanca = '10'
		IF @ActivoMDO <> 1 AND @Activa <> 1
		BEGIN
			SET @Palanca = '4'
		END

	END


	IF @Palanca = '4'--OPT
	BEGIN

		declare @tmpOpt TABLE (
			EstrategiaID VARCHAR(150)				,CUV2 VARCHAR(150)			,DescripcionCUV2 VARCHAR(300)		,EtiquetaDescripcion VARCHAR(150)	,Precio VARCHAR(150),
			EtiquetaDescripcion2 VARCHAR(150)		,Precio2 VARCHAR(150)		,TextoLibre VARCHAR(150)			,FlagEstrella VARCHAR(150)			,ColorFondo VARCHAR(150),
			TipoEstrategiaID VARCHAR(150)			,FotoProducto01 VARCHAR(150),ImagenURL VARCHAR(150)				,LimiteVenta VARCHAR(150)			,MarcaID VARCHAR(150),
			Orden1 VARCHAR(150)						,Orden2 VARCHAR(150)		,IndicadorMontoMinimo VARCHAR(150)	,FlagNueva VARCHAR(150)				,TipoTallaColor VARCHAR(150),
			TipoEstrategiaImagenMostrar VARCHAR(150),CodigoProducto VARCHAR(150),EtiquetaID VARCHAR(150)			,EtiquetaID2 VARCHAR(150)			,CodigoEstrategia VARCHAR(150),
			TieneVariedad VARCHAR(150)				,CODIGO VARCHAR(150)		,DescripcionEstrategia VARCHAR(150)	,FlagMostrarImg VARCHAR(150)		,DescripcionMarca VARCHAR(150),
			DescripcionCategoria VARCHAR(150)		,PrecioPublico VARCHAR(150)	,Ganancia VARCHAR(150))
		
		insert into @tmpOpt exec ListarEstrategiasOPT @CampaniaID,@CodigoConsultora
		select CUV2 as CUV, DescripcionCUV2 as Descripcion from @tmpOpt

	END
	ELSE IF @Palanca = '10' --RD
	BEGIN

		DECLARE @EstrategiaCodigoOPM varchar(100) = '007'
		DECLARE @EstrategiaCodigoPAD varchar(100) = '008'
		DECLARE @TipoPersonalizacionCodigoOpm varchar(3) = 'OPM'
		DECLARE @TipoPersonalizacionCodigoPad varchar(3) = 'PAD'
		DECLARE @TipoPersonalizacionCodigoOpmPad varchar(3) = 'OPM;PAD'

		DECLARE @tablaCuvFaltante TABLE(CUV VARCHAR(6))
		INSERT INTO @tablaCuvFaltante(CUV)
		SELECT CUV FROM [dbo].[ObtenerCuvFaltante](@CampaniaID,@CodigoConsultora)

		DECLARE @CodConsultoraDefault VARCHAR(9) = ''
		SELECT @CodConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001

		DECLARE @CodConsultoraForzada VARCHAR(9) = ''
		SELECT @CodConsultoraForzada = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10002

		DECLARE  @OfertasPersonalizadas TABLE (Orden INT, CUV CHAR(6), TipoPersonalizacion CHAR(3), FlagRevista INT, AnioCampanaVenta INT, TipoEstrategiaId INT)

		INSERT INTO @OfertasPersonalizadas EXEC ListarOfertasPersonalizadas @CampaniaID,@TipoPersonalizacionCodigoOpmPad,@CodigoConsultora

		IF NOT EXISTS (SELECT TOP 1 CUV FROM @OfertasPersonalizadas)
		BEGIN
			INSERT INTO @OfertasPersonalizadas
			EXEC ListarOfertasPersonalizadas @CampaniaID,@TipoPersonalizacionCodigoOpmPad,@codConsultoraDefault
		END

		INSERT INTO @OfertasPersonalizadas EXEC ListarOfertasPersonalizadas @CampaniaID,@TipoPersonalizacionCodigoPad,@codConsultoraForzada
		INSERT INTO @OfertasPersonalizadas EXEC ListarOfertasPersonalizadas @CampaniaID,@TipoPersonalizacionCodigoOpm,@codConsultoraForzada

		SELECT
			E.CUV2 as CUV,
			E.DescripcionCUV2 as Descripcion
		FROM  dbo.Estrategia E with(nolock)
			INNER JOIN @OfertasPersonalizadas op ON E.CampaniaID = op.AnioCampanaVenta AND E.CUV2 = op.CUV AND OP.TipoEstrategiaId = E.TipoEstrategiaId
			INNER JOIN dbo.TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID AND TE.Codigo in (@EstrategiaCodigoOPM, @EstrategiaCodigoPAD)
			LEFT JOIN @tablaCuvFaltante TF ON E.CUV2 = TF.CUV
		WHERE
			E.Activo = 1 AND TE.FlagActivo = 1 AND TE.flagRecoPerfil = 1 AND TF.CUV IS NULL
		ORDER BY OP.Orden ASC, E.EstrategiaID ASC

	END
	ELSE IF @Palanca = '7' --ODD
	BEGIN

		DECLARE @fechaInicioFact DATE
		DECLARE @ZonaId INT
		DECLARE @num INT

		SET @ZonaId = (select ZonaId from ods.consultora where codigo = @CodigoConsultora)
		SET @fechaInicioFact = 
			(SELECT C.FechaInicioFacturacion 
			FROM ods.Cronograma C  
			INNER JOIN ods.Campania Ca ON C.CampaniaID = Ca.CampaniaID
			INNER JOIN [ods].[Zona] z (nolock) ON C.RegionID = z.RegionID AND c.ZonaID = z.ZonaID	
			WHERE Ca.Codigo = @CampaniaID AND Z.ZonaID = CASE WHEN @ZonaID = -1 THEN Z.ZonaID ELSE @ZonaID END)

		SET @num = (DATEDIFF(dd, @FechaConsulta, GETDATE()))
		SET @fechaInicioFact = (DATEADD(dd, @num, @fechaInicioFact))

		declare @tmpODD TABLE (
			EstrategiaID VARCHAR(150)				,CUV2 VARCHAR(150)				,DescripcionCUV2 VARCHAR(300)				,EtiquetaDescripcion VARCHAR(150)	,Precio VARCHAR(150),
			EtiquetaDescripcion2 VARCHAR(150)		,Precio2 VARCHAR(150)			,TextoLibre VARCHAR(150)					,CodigoEstrategia VARCHAR(150)		,FlagEstrella VARCHAR(150),
			ColorFondo VARCHAR(150)					,TipoEstrategiaID VARCHAR(150)	,FotoProducto01 VARCHAR(150)				,ImagenURL VARCHAR(150)				,LimiteVenta VARCHAR(150),
			MarcaID VARCHAR(150)					,Orden1 VARCHAR(150)			,Orden2 VARCHAR(150)						,IndicadorMontoMinimo VARCHAR(150)	,CodigoProducto VARCHAR(150),
			FlagNueva VARCHAR(150)					,TipoTallaColor VARCHAR(150)	,TipoEstrategiaImagenMostrar VARCHAR(150)	,EtiquetaID VARCHAR(150)			,EtiquetaID2 VARCHAR(150),
			CodigoEstrategia2 VARCHAR(150)			,TieneVariedad VARCHAR(150)		,CODIGO VARCHAR(150)						,DescripcionEstrategia VARCHAR(150)	,FlagMostrarImg VARCHAR(150),
			PrecioPublico VARCHAR(150)				,Ganancia VARCHAR(150)			,DescripcionMarca VARCHAR(150)				,FlagRevista VARCHAR(150)			,ImagenMiniaturaURL VARCHAR(150),
			DiaInicio VARCHAR(150))	

		insert into @tmpODD exec ListarEstrategiasODD2 @CampaniaID,@CodigoConsultora,@fechaInicioFact
		select CUV2 as CUV, DescripcionCUV2 as Descripcion from @tmpODD

	END
	ELSE IF @Palanca = '30' --SR
	BEGIN

		declare @tmpSR TABLE (
			EstrategiaID VARCHAR(150)				,CUV2 VARCHAR(150)							,DescripcionCUV2 VARCHAR(300)				,EtiquetaDescripcion VARCHAR(150)	,Precio VARCHAR(150),
			EtiquetaDescripcion2 VARCHAR(150)		,Precio2 VARCHAR(150)						,TextoLibre VARCHAR(150)					,FlagEstrella VARCHAR(150)			,ColorFondo VARCHAR(150),
			TipoEstrategiaID VARCHAR(150)			,FotoProducto01 VARCHAR(150)				,ImagenURL VARCHAR(150)						,LimiteVenta VARCHAR(150)			,MarcaID VARCHAR(150),
			Orden1 VARCHAR(150)						,Orden2 VARCHAR(150)						,IndicadorMontoMinimo VARCHAR(150)			,CodigoProducto VARCHAR(150)		,FlagNueva VARCHAR(150),
			TipoTallaColor VARCHAR(150)				,TipoEstrategiaImagenMostrar VARCHAR(150)	,EtiquetaID VARCHAR(150)					,EtiquetaID2 VARCHAR(150)			,CodigoEstrategia VARCHAR(150),
			TieneVariedad VARCHAR(150)				,CODIGO VARCHAR(150)						,DescripcionEstrategia VARCHAR(150)			,FlagMostrarImg VARCHAR(150)		,PrecioPublico VARCHAR(150),
			Ganancia VARCHAR(150)					,DescripcionMarca VARCHAR(150)				,FlagRevista VARCHAR(150)					,ImagenMiniaturaURL VARCHAR(150)	,EsSubCampania VARCHAR(150))

		insert into @tmpSR exec ListarEstrategiasShowRoom @CampaniaID,@CodigoConsultora
		select CUV2 as CUV, DescripcionCUV2 as Descripcion from @tmpSR

	END
	ELSE IF @Palanca = '9' --LAN
	BEGIN

		declare @tmpLAN TABLE (
			EstrategiaID VARCHAR(150)				,CUV2 VARCHAR(150)							,DescripcionCUV2 VARCHAR(300)				,EtiquetaDescripcion VARCHAR(150)	,Precio VARCHAR(150),
			EtiquetaDescripcion2 VARCHAR(150)		,Precio2 VARCHAR(150)						,TextoLibre VARCHAR(150)					,FlagEstrella VARCHAR(150)			,ColorFondo VARCHAR(150),
			TipoEstrategiaID VARCHAR(150)			,FotoProducto01 VARCHAR(150)				,ImagenURL VARCHAR(150)						,LimiteVenta VARCHAR(150)			,MarcaID VARCHAR(150),
			Orden1 VARCHAR(150)						,Orden2 VARCHAR(150)						,IndicadorMontoMinimo VARCHAR(150)			,FlagNueva VARCHAR(150)				,TipoTallaColor VARCHAR(150),
			TipoEstrategiaImagenMostrar VARCHAR(150),CodigoProducto VARCHAR(150)				,EtiquetaID VARCHAR(150)					,EtiquetaID2 VARCHAR(150)			,CodigoEstrategia VARCHAR(150),
			TieneVariedad VARCHAR(150)				,CODIGO VARCHAR(150)						,DescripcionEstrategia VARCHAR(150)			,FlagMostrarImg VARCHAR(150)		,DescripcionMarca VARCHAR(150),
			DescripcionCategoria VARCHAR(150)		,FlagIndividual VARCHAR(150)				,Slogan VARCHAR(150)						,ImgFondoDesktop VARCHAR(150)		,ImgFichaDesktop VARCHAR(150),
			UrlVideoDesktop VARCHAR(150)			,ImgFichaFondoDesktop VARCHAR(150)			,ImgFondoMobile VARCHAR(150)				,ImgSelloProductoMobile VARCHAR(150),UrlVideoMobile VARCHAR(150),
			ImgFichaFondoMobile VARCHAR(150)		,ImgHomeDesktop VARCHAR(150)				,ImgHomeMobile VARCHAR(150)					,PrecioPublico VARCHAR(150)			,Ganancia VARCHAR(150))

		insert into @tmpLAN exec ListarEstrategiasLanzamiento @CampaniaID,@CodigoConsultora
		select CUV2 as CUV, DescripcionCUV2 as Descripcion from @tmpLAN

	END
	ELSE IF @Palanca = '12' --GND 
	BEGIN

		declare @tmpGND TABLE (
			EstrategiaID VARCHAR(150)				,CUV2 VARCHAR(150)							,DescripcionCUV2 VARCHAR(300)				,EtiquetaDescripcion VARCHAR(150)	,Precio VARCHAR(150),
			EtiquetaDescripcion2 VARCHAR(150)		,Precio2 VARCHAR(150)						,TextoLibre VARCHAR(150)					,FlagEstrella VARCHAR(150)			,ColorFondo VARCHAR(150),
			TipoEstrategiaID VARCHAR(150)			,FotoProducto01 VARCHAR(150)				,ImagenURL VARCHAR(150)						,LimiteVenta VARCHAR(150)			,MarcaID VARCHAR(150),
			Orden1 VARCHAR(150)						,Orden2 VARCHAR(150)						,IndicadorMontoMinimo VARCHAR(150)			,CodigoProducto VARCHAR(150)		,FlagNueva VARCHAR(150),
			TipoTallaColor VARCHAR(150)				,TipoEstrategiaImagenMostrar VARCHAR(150)	,EtiquetaID VARCHAR(150)					,EtiquetaID2 VARCHAR(150)			,CodigoEstrategia VARCHAR(150),
			TieneVariedad VARCHAR(150)				,CODIGO VARCHAR(150)						,DescripcionEstrategia VARCHAR(150)			,FlagMostrarImg VARCHAR(150)		,PrecioPublico VARCHAR(150),
			Ganancia VARCHAR(150)					,DescripcionMarca VARCHAR(150)				,FlagRevista VARCHAR(150))

		insert into @tmpGND exec ListarEstrategiasGuiaDeNegocioDigitalizada @CampaniaID,@CodigoConsultora
		select CUV2 as CUV, DescripcionCUV2 as Descripcion from @tmpGND

	END
END
GO

IF OBJECT_ID('GetReporteMovimientosPedido', 'P') IS NOT NULL 
  DROP PROCEDURE GetReporteMovimientosPedido
  GO

CREATE PROC GetReporteMovimientosPedido
(
	@CampaniaID INT = 0,
	@CodigoConsultora VARCHAR(30) = ''
)
AS
BEGIN

	DECLARE @consultoraId INT
	DECLARE @tipoAccionEliminacionProl INT

	SET @tipoAccionEliminacionProl = 201
	SET @consultoraId = (select consultoraid from ods.consultora where codigo = @CodigoConsultora)

	select
		pwaprol.Cuv, COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, pco.Descripcion) AS Descripcion, FechaAccion, 'PROL' as Origen, MensajeProl as Mensaje
	from 
		[dbo].[PedidoWebAccionesPROL] pwaprol
		LEFT join ods.productocomercial pco with(nolock) ON pwaprol.Cuv = pco.cuv and @CampaniaID = pco.anocampania
		LEFT JOIN dbo.MatrizComercial MC WITH (NOLOCK) ON pco.CodigoProducto = MC.CodigoSAP
		LEFT JOIN dbo.OfertaProducto OP WITH (NOLOCK) ON OP.CampaniaID = pco.anocampania AND OP.CUV = pco.CUV
		LEFT JOIN dbo.ProductoDescripcion PD WITH (NOLOCK) ON pco.anocampania = PD.CampaniaID AND pco.CUV = PD.CUV
	where
		pwaprol.ConsultoraID = @consultoraId and 
		pwaprol.CampaniaID = @CampaniaID and
		pwaprol.Accion = @tipoAccionEliminacionProl

	UNION

	select
		pwdseg.Cuv, COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, pco.Descripcion) AS Descripcion, FechaAccion, 'CONSULTORA' as Origen, '' as Mensaje
	from 
		[dbo].[PedidoWebDetalleSeguimiento] pwdseg
		LEFT join ods.productocomercial pco with(nolock) ON pwdseg.Cuv = pco.cuv and @CampaniaID = pco.anocampania
		LEFT JOIN dbo.MatrizComercial MC WITH (NOLOCK) ON pco.CodigoProducto = MC.CodigoSAP
		LEFT JOIN dbo.OfertaProducto OP WITH (NOLOCK) ON OP.CampaniaID = pco.anocampania AND OP.CUV = pco.CUV
		LEFT JOIN dbo.ProductoDescripcion PD WITH (NOLOCK) ON pco.anocampania = PD.CampaniaID AND pco.CUV = PD.CUV
	where
		pwdseg.ConsultoraID = @consultoraId and 
		pwdseg.CampaniaID = @CampaniaID

END
GO

IF OBJECT_ID('GetReporteCuvResumido', 'P') IS NOT NULL 
  DROP PROCEDURE GetReporteCuvResumido
  GO

CREATE PROC GetReporteCuvResumido
(
	@CampaniaID INT = 0,
	@Cuv VARCHAR(10) = ''
)
AS
BEGIN
	select
		
		pco.Cuv
		, pco.CodigoProducto as SAP
		, COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, est.DescripcionCUV2, pco.Descripcion) AS DescripcionProd
		, isnull(tes.DescripcionEstrategia,'') as Palanca
		, isnull(est.imagenURL,'') as imagenURL
		, case isnull(est.activo,'1') when 1 then 'SI' else 'NO' end as Activo
		, case isnull(pco.IndicadorDigitable,'0') when 1 then 'NO' else 'SI' end as PuedeDigitarse
		, isnull(est.Precio2,pco.PrecioCatalogo) as PrecioSet
	from 
		ods.productocomercial pco with(nolock)
		LEFT JOIN dbo.MatrizComercial MC WITH (NOLOCK) ON pco.CodigoProducto = MC.CodigoSAP
		LEFT JOIN dbo.OfertaProducto OP WITH (NOLOCK) ON OP.CampaniaID = pco.anocampania AND OP.CUV = pco.CUV
		LEFT JOIN dbo.ProductoDescripcion PD WITH (NOLOCK) ON pco.anocampania = PD.CampaniaID AND pco.CUV = PD.CUV
		LEFT JOIN estrategia est with(nolock) on pco.cuv = est.cuv2 and pco.anocampania = est.campaniaid
		LEFT JOIN tipoestrategia tes with(nolock) on est.tipoestrategiaid = tes.tipoestrategiaid
	where
		pco.cuv = @Cuv and 
		pco.anocampania = @CampaniaID
END
GO


USE [BelcorpCostaRica]
GO

IF OBJECT_ID('GetReporteCuvDetallado', 'P') IS NOT NULL 
  DROP PROCEDURE GetReporteCuvDetallado
  GO

CREATE PROC GetReporteCuvDetallado
(
	@CampaniaID INT = 0,
	@Cuv VARCHAR(10) = ''
)
AS
BEGIN
	select
		test.DescripcionEstrategia,
		estp.cuv2 as CuvPadre,
		estp.cuv as CuvHijo,
		estp.CodigoEstrategia,
		estp.Grupo,
		estp.SAP,
		mare.Nombre as MarcaEstrategia,
		marpc.Nombre as MarcaMatriz,
		estp.FactorCuadre,
		pco.PrecioUnitario,
		pco.IndicadorPreUni as PrecioPublico,
		estp.Digitable,
		estp.NombreProducto,
		estp.ImagenProducto AS ImagenTipos,
		estp.ImagenBulk AS ImagenTonos,
		estp.NombreBulk,
		pco.FactorRepeticion,
		estp.IdMarca as CodigoMarca
	from 
		estrategiaproducto estp with(nolock)
		INNER JOIN estrategia est with(nolock) on estp.estrategiaid = est.estrategiaid
		INNER JOIN tipoestrategia test with(nolock) on est.tipoestrategiaid = test.tipoestrategiaid
		INNER JOIN ods.productocomercial pco WITH (NOLOCK) ON estp.cuv = pco.cuv and estp.campania = pco.anocampania
		LEFT JOIN ods.marca mare WITH(NOLOCK) ON estp.IdMarca = mare.MarcaId
		LEFT JOIN ods.marca marpc WITH(NOLOCK) ON pco.MarcaID = marpc.MarcaId
		
	where
		(estp.cuv2 = @Cuv OR estp.cuv = @cuv) and
		estp.campania = @CampaniaID
	order by estp.EstrategiaID,estp.cuv2, estp.Grupo
		
END
GO

IF OBJECT_ID('GetReporteEstrategiasPorConsultora', 'P') IS NOT NULL 
  DROP PROCEDURE GetReporteEstrategiasPorConsultora
  GO

CREATE PROC GetReporteEstrategiasPorConsultora
(
	@CampaniaID INT = 0,
	@CodigoConsultora VARCHAR(30) = '',
	@Palanca VARCHAR(3) = '',
	@FechaConsulta DATE
)
AS
BEGIN

	DECLARE @Activa INT = (SELECT TOP 1 1 FROM RevistaDigitalSuscripcion WHERE codigoConsultora = @CodigoConsultora AND CampaniaEfectiva = @CampaniaID AND EstadoRegistro = 1)
	DECLARE @ActivoMDO INT = (SELECT Estado FROM ConfiguracionPaisdatos where codigo='ActivoMDO')

	IF @Palanca = '4'
	BEGIN
		SET @Palanca = '10'
		IF @ActivoMDO <> 1 AND @Activa <> 1
		BEGIN
			SET @Palanca = '4'
		END

	END


	IF @Palanca = '4'--OPT
	BEGIN

		declare @tmpOpt TABLE (
			EstrategiaID VARCHAR(150)				,CUV2 VARCHAR(150)			,DescripcionCUV2 VARCHAR(300)		,EtiquetaDescripcion VARCHAR(150)	,Precio VARCHAR(150),
			EtiquetaDescripcion2 VARCHAR(150)		,Precio2 VARCHAR(150)		,TextoLibre VARCHAR(150)			,FlagEstrella VARCHAR(150)			,ColorFondo VARCHAR(150),
			TipoEstrategiaID VARCHAR(150)			,FotoProducto01 VARCHAR(150),ImagenURL VARCHAR(150)				,LimiteVenta VARCHAR(150)			,MarcaID VARCHAR(150),
			Orden1 VARCHAR(150)						,Orden2 VARCHAR(150)		,IndicadorMontoMinimo VARCHAR(150)	,FlagNueva VARCHAR(150)				,TipoTallaColor VARCHAR(150),
			TipoEstrategiaImagenMostrar VARCHAR(150),CodigoProducto VARCHAR(150),EtiquetaID VARCHAR(150)			,EtiquetaID2 VARCHAR(150)			,CodigoEstrategia VARCHAR(150),
			TieneVariedad VARCHAR(150)				,CODIGO VARCHAR(150)		,DescripcionEstrategia VARCHAR(150)	,FlagMostrarImg VARCHAR(150)		,DescripcionMarca VARCHAR(150),
			DescripcionCategoria VARCHAR(150)		,PrecioPublico VARCHAR(150)	,Ganancia VARCHAR(150))
		
		insert into @tmpOpt exec ListarEstrategiasOPT @CampaniaID,@CodigoConsultora
		select CUV2 as CUV, DescripcionCUV2 as Descripcion from @tmpOpt

	END
	ELSE IF @Palanca = '10' --RD
	BEGIN

		DECLARE @EstrategiaCodigoOPM varchar(100) = '007'
		DECLARE @EstrategiaCodigoPAD varchar(100) = '008'
		DECLARE @TipoPersonalizacionCodigoOpm varchar(3) = 'OPM'
		DECLARE @TipoPersonalizacionCodigoPad varchar(3) = 'PAD'
		DECLARE @TipoPersonalizacionCodigoOpmPad varchar(3) = 'OPM;PAD'

		DECLARE @tablaCuvFaltante TABLE(CUV VARCHAR(6))
		INSERT INTO @tablaCuvFaltante(CUV)
		SELECT CUV FROM [dbo].[ObtenerCuvFaltante](@CampaniaID,@CodigoConsultora)

		DECLARE @CodConsultoraDefault VARCHAR(9) = ''
		SELECT @CodConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001

		DECLARE @CodConsultoraForzada VARCHAR(9) = ''
		SELECT @CodConsultoraForzada = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10002

		DECLARE  @OfertasPersonalizadas TABLE (Orden INT, CUV CHAR(6), TipoPersonalizacion CHAR(3), FlagRevista INT, AnioCampanaVenta INT, TipoEstrategiaId INT)

		INSERT INTO @OfertasPersonalizadas EXEC ListarOfertasPersonalizadas @CampaniaID,@TipoPersonalizacionCodigoOpmPad,@CodigoConsultora

		IF NOT EXISTS (SELECT TOP 1 CUV FROM @OfertasPersonalizadas)
		BEGIN
			INSERT INTO @OfertasPersonalizadas
			EXEC ListarOfertasPersonalizadas @CampaniaID,@TipoPersonalizacionCodigoOpmPad,@codConsultoraDefault
		END

		INSERT INTO @OfertasPersonalizadas EXEC ListarOfertasPersonalizadas @CampaniaID,@TipoPersonalizacionCodigoPad,@codConsultoraForzada
		INSERT INTO @OfertasPersonalizadas EXEC ListarOfertasPersonalizadas @CampaniaID,@TipoPersonalizacionCodigoOpm,@codConsultoraForzada

		SELECT
			E.CUV2 as CUV,
			E.DescripcionCUV2 as Descripcion
		FROM  dbo.Estrategia E with(nolock)
			INNER JOIN @OfertasPersonalizadas op ON E.CampaniaID = op.AnioCampanaVenta AND E.CUV2 = op.CUV AND OP.TipoEstrategiaId = E.TipoEstrategiaId
			INNER JOIN dbo.TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID AND TE.Codigo in (@EstrategiaCodigoOPM, @EstrategiaCodigoPAD)
			LEFT JOIN @tablaCuvFaltante TF ON E.CUV2 = TF.CUV
		WHERE
			E.Activo = 1 AND TE.FlagActivo = 1 AND TE.flagRecoPerfil = 1 AND TF.CUV IS NULL
		ORDER BY OP.Orden ASC, E.EstrategiaID ASC

	END
	ELSE IF @Palanca = '7' --ODD
	BEGIN

		DECLARE @fechaInicioFact DATE
		DECLARE @ZonaId INT
		DECLARE @num INT

		SET @ZonaId = (select ZonaId from ods.consultora where codigo = @CodigoConsultora)
		SET @fechaInicioFact = 
			(SELECT C.FechaInicioFacturacion 
			FROM ods.Cronograma C  
			INNER JOIN ods.Campania Ca ON C.CampaniaID = Ca.CampaniaID
			INNER JOIN [ods].[Zona] z (nolock) ON C.RegionID = z.RegionID AND c.ZonaID = z.ZonaID	
			WHERE Ca.Codigo = @CampaniaID AND Z.ZonaID = CASE WHEN @ZonaID = -1 THEN Z.ZonaID ELSE @ZonaID END)

		SET @num = (DATEDIFF(dd, @FechaConsulta, GETDATE()))
		SET @fechaInicioFact = (DATEADD(dd, @num, @fechaInicioFact))

		declare @tmpODD TABLE (
			EstrategiaID VARCHAR(150)				,CUV2 VARCHAR(150)				,DescripcionCUV2 VARCHAR(300)				,EtiquetaDescripcion VARCHAR(150)	,Precio VARCHAR(150),
			EtiquetaDescripcion2 VARCHAR(150)		,Precio2 VARCHAR(150)			,TextoLibre VARCHAR(150)					,CodigoEstrategia VARCHAR(150)		,FlagEstrella VARCHAR(150),
			ColorFondo VARCHAR(150)					,TipoEstrategiaID VARCHAR(150)	,FotoProducto01 VARCHAR(150)				,ImagenURL VARCHAR(150)				,LimiteVenta VARCHAR(150),
			MarcaID VARCHAR(150)					,Orden1 VARCHAR(150)			,Orden2 VARCHAR(150)						,IndicadorMontoMinimo VARCHAR(150)	,CodigoProducto VARCHAR(150),
			FlagNueva VARCHAR(150)					,TipoTallaColor VARCHAR(150)	,TipoEstrategiaImagenMostrar VARCHAR(150)	,EtiquetaID VARCHAR(150)			,EtiquetaID2 VARCHAR(150),
			CodigoEstrategia2 VARCHAR(150)			,TieneVariedad VARCHAR(150)		,CODIGO VARCHAR(150)						,DescripcionEstrategia VARCHAR(150)	,FlagMostrarImg VARCHAR(150),
			PrecioPublico VARCHAR(150)				,Ganancia VARCHAR(150)			,DescripcionMarca VARCHAR(150)				,FlagRevista VARCHAR(150)			,ImagenMiniaturaURL VARCHAR(150),
			DiaInicio VARCHAR(150))	

		insert into @tmpODD exec ListarEstrategiasODD2 @CampaniaID,@CodigoConsultora,@fechaInicioFact
		select CUV2 as CUV, DescripcionCUV2 as Descripcion from @tmpODD

	END
	ELSE IF @Palanca = '30' --SR
	BEGIN

		declare @tmpSR TABLE (
			EstrategiaID VARCHAR(150)				,CUV2 VARCHAR(150)							,DescripcionCUV2 VARCHAR(300)				,EtiquetaDescripcion VARCHAR(150)	,Precio VARCHAR(150),
			EtiquetaDescripcion2 VARCHAR(150)		,Precio2 VARCHAR(150)						,TextoLibre VARCHAR(150)					,FlagEstrella VARCHAR(150)			,ColorFondo VARCHAR(150),
			TipoEstrategiaID VARCHAR(150)			,FotoProducto01 VARCHAR(150)				,ImagenURL VARCHAR(150)						,LimiteVenta VARCHAR(150)			,MarcaID VARCHAR(150),
			Orden1 VARCHAR(150)						,Orden2 VARCHAR(150)						,IndicadorMontoMinimo VARCHAR(150)			,CodigoProducto VARCHAR(150)		,FlagNueva VARCHAR(150),
			TipoTallaColor VARCHAR(150)				,TipoEstrategiaImagenMostrar VARCHAR(150)	,EtiquetaID VARCHAR(150)					,EtiquetaID2 VARCHAR(150)			,CodigoEstrategia VARCHAR(150),
			TieneVariedad VARCHAR(150)				,CODIGO VARCHAR(150)						,DescripcionEstrategia VARCHAR(150)			,FlagMostrarImg VARCHAR(150)		,PrecioPublico VARCHAR(150),
			Ganancia VARCHAR(150)					,DescripcionMarca VARCHAR(150)				,FlagRevista VARCHAR(150)					,ImagenMiniaturaURL VARCHAR(150)	,EsSubCampania VARCHAR(150))

		insert into @tmpSR exec ListarEstrategiasShowRoom @CampaniaID,@CodigoConsultora
		select CUV2 as CUV, DescripcionCUV2 as Descripcion from @tmpSR

	END
	ELSE IF @Palanca = '9' --LAN
	BEGIN

		declare @tmpLAN TABLE (
			EstrategiaID VARCHAR(150)				,CUV2 VARCHAR(150)							,DescripcionCUV2 VARCHAR(300)				,EtiquetaDescripcion VARCHAR(150)	,Precio VARCHAR(150),
			EtiquetaDescripcion2 VARCHAR(150)		,Precio2 VARCHAR(150)						,TextoLibre VARCHAR(150)					,FlagEstrella VARCHAR(150)			,ColorFondo VARCHAR(150),
			TipoEstrategiaID VARCHAR(150)			,FotoProducto01 VARCHAR(150)				,ImagenURL VARCHAR(150)						,LimiteVenta VARCHAR(150)			,MarcaID VARCHAR(150),
			Orden1 VARCHAR(150)						,Orden2 VARCHAR(150)						,IndicadorMontoMinimo VARCHAR(150)			,FlagNueva VARCHAR(150)				,TipoTallaColor VARCHAR(150),
			TipoEstrategiaImagenMostrar VARCHAR(150),CodigoProducto VARCHAR(150)				,EtiquetaID VARCHAR(150)					,EtiquetaID2 VARCHAR(150)			,CodigoEstrategia VARCHAR(150),
			TieneVariedad VARCHAR(150)				,CODIGO VARCHAR(150)						,DescripcionEstrategia VARCHAR(150)			,FlagMostrarImg VARCHAR(150)		,DescripcionMarca VARCHAR(150),
			DescripcionCategoria VARCHAR(150)		,FlagIndividual VARCHAR(150)				,Slogan VARCHAR(150)						,ImgFondoDesktop VARCHAR(150)		,ImgFichaDesktop VARCHAR(150),
			UrlVideoDesktop VARCHAR(150)			,ImgFichaFondoDesktop VARCHAR(150)			,ImgFondoMobile VARCHAR(150)				,ImgSelloProductoMobile VARCHAR(150),UrlVideoMobile VARCHAR(150),
			ImgFichaFondoMobile VARCHAR(150)		,ImgHomeDesktop VARCHAR(150)				,ImgHomeMobile VARCHAR(150)					,PrecioPublico VARCHAR(150)			,Ganancia VARCHAR(150))

		insert into @tmpLAN exec ListarEstrategiasLanzamiento @CampaniaID,@CodigoConsultora
		select CUV2 as CUV, DescripcionCUV2 as Descripcion from @tmpLAN

	END
	ELSE IF @Palanca = '12' --GND 
	BEGIN

		declare @tmpGND TABLE (
			EstrategiaID VARCHAR(150)				,CUV2 VARCHAR(150)							,DescripcionCUV2 VARCHAR(300)				,EtiquetaDescripcion VARCHAR(150)	,Precio VARCHAR(150),
			EtiquetaDescripcion2 VARCHAR(150)		,Precio2 VARCHAR(150)						,TextoLibre VARCHAR(150)					,FlagEstrella VARCHAR(150)			,ColorFondo VARCHAR(150),
			TipoEstrategiaID VARCHAR(150)			,FotoProducto01 VARCHAR(150)				,ImagenURL VARCHAR(150)						,LimiteVenta VARCHAR(150)			,MarcaID VARCHAR(150),
			Orden1 VARCHAR(150)						,Orden2 VARCHAR(150)						,IndicadorMontoMinimo VARCHAR(150)			,CodigoProducto VARCHAR(150)		,FlagNueva VARCHAR(150),
			TipoTallaColor VARCHAR(150)				,TipoEstrategiaImagenMostrar VARCHAR(150)	,EtiquetaID VARCHAR(150)					,EtiquetaID2 VARCHAR(150)			,CodigoEstrategia VARCHAR(150),
			TieneVariedad VARCHAR(150)				,CODIGO VARCHAR(150)						,DescripcionEstrategia VARCHAR(150)			,FlagMostrarImg VARCHAR(150)		,PrecioPublico VARCHAR(150),
			Ganancia VARCHAR(150)					,DescripcionMarca VARCHAR(150)				,FlagRevista VARCHAR(150))

		insert into @tmpGND exec ListarEstrategiasGuiaDeNegocioDigitalizada @CampaniaID,@CodigoConsultora
		select CUV2 as CUV, DescripcionCUV2 as Descripcion from @tmpGND

	END
END
GO

IF OBJECT_ID('GetReporteMovimientosPedido', 'P') IS NOT NULL 
  DROP PROCEDURE GetReporteMovimientosPedido
  GO

CREATE PROC GetReporteMovimientosPedido
(
	@CampaniaID INT = 0,
	@CodigoConsultora VARCHAR(30) = ''
)
AS
BEGIN

	DECLARE @consultoraId INT
	DECLARE @tipoAccionEliminacionProl INT

	SET @tipoAccionEliminacionProl = 201
	SET @consultoraId = (select consultoraid from ods.consultora where codigo = @CodigoConsultora)

	select
		pwaprol.Cuv, COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, pco.Descripcion) AS Descripcion, FechaAccion, 'PROL' as Origen, MensajeProl as Mensaje
	from 
		[dbo].[PedidoWebAccionesPROL] pwaprol
		LEFT join ods.productocomercial pco with(nolock) ON pwaprol.Cuv = pco.cuv and @CampaniaID = pco.anocampania
		LEFT JOIN dbo.MatrizComercial MC WITH (NOLOCK) ON pco.CodigoProducto = MC.CodigoSAP
		LEFT JOIN dbo.OfertaProducto OP WITH (NOLOCK) ON OP.CampaniaID = pco.anocampania AND OP.CUV = pco.CUV
		LEFT JOIN dbo.ProductoDescripcion PD WITH (NOLOCK) ON pco.anocampania = PD.CampaniaID AND pco.CUV = PD.CUV
	where
		pwaprol.ConsultoraID = @consultoraId and 
		pwaprol.CampaniaID = @CampaniaID and
		pwaprol.Accion = @tipoAccionEliminacionProl

	UNION

	select
		pwdseg.Cuv, COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, pco.Descripcion) AS Descripcion, FechaAccion, 'CONSULTORA' as Origen, '' as Mensaje
	from 
		[dbo].[PedidoWebDetalleSeguimiento] pwdseg
		LEFT join ods.productocomercial pco with(nolock) ON pwdseg.Cuv = pco.cuv and @CampaniaID = pco.anocampania
		LEFT JOIN dbo.MatrizComercial MC WITH (NOLOCK) ON pco.CodigoProducto = MC.CodigoSAP
		LEFT JOIN dbo.OfertaProducto OP WITH (NOLOCK) ON OP.CampaniaID = pco.anocampania AND OP.CUV = pco.CUV
		LEFT JOIN dbo.ProductoDescripcion PD WITH (NOLOCK) ON pco.anocampania = PD.CampaniaID AND pco.CUV = PD.CUV
	where
		pwdseg.ConsultoraID = @consultoraId and 
		pwdseg.CampaniaID = @CampaniaID

END
GO

IF OBJECT_ID('GetReporteCuvResumido', 'P') IS NOT NULL 
  DROP PROCEDURE GetReporteCuvResumido
  GO

CREATE PROC GetReporteCuvResumido
(
	@CampaniaID INT = 0,
	@Cuv VARCHAR(10) = ''
)
AS
BEGIN
	select
		
		pco.Cuv
		, pco.CodigoProducto as SAP
		, COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, est.DescripcionCUV2, pco.Descripcion) AS DescripcionProd
		, isnull(tes.DescripcionEstrategia,'') as Palanca
		, isnull(est.imagenURL,'') as imagenURL
		, case isnull(est.activo,'1') when 1 then 'SI' else 'NO' end as Activo
		, case isnull(pco.IndicadorDigitable,'0') when 1 then 'NO' else 'SI' end as PuedeDigitarse
		, isnull(est.Precio2,pco.PrecioCatalogo) as PrecioSet
	from 
		ods.productocomercial pco with(nolock)
		LEFT JOIN dbo.MatrizComercial MC WITH (NOLOCK) ON pco.CodigoProducto = MC.CodigoSAP
		LEFT JOIN dbo.OfertaProducto OP WITH (NOLOCK) ON OP.CampaniaID = pco.anocampania AND OP.CUV = pco.CUV
		LEFT JOIN dbo.ProductoDescripcion PD WITH (NOLOCK) ON pco.anocampania = PD.CampaniaID AND pco.CUV = PD.CUV
		LEFT JOIN estrategia est with(nolock) on pco.cuv = est.cuv2 and pco.anocampania = est.campaniaid
		LEFT JOIN tipoestrategia tes with(nolock) on est.tipoestrategiaid = tes.tipoestrategiaid
	where
		pco.cuv = @Cuv and 
		pco.anocampania = @CampaniaID
END
GO


USE [BelcorpDominicana]
GO

IF OBJECT_ID('GetReporteCuvDetallado', 'P') IS NOT NULL 
  DROP PROCEDURE GetReporteCuvDetallado
  GO

CREATE PROC GetReporteCuvDetallado
(
	@CampaniaID INT = 0,
	@Cuv VARCHAR(10) = ''
)
AS
BEGIN
	select
		test.DescripcionEstrategia,
		estp.cuv2 as CuvPadre,
		estp.cuv as CuvHijo,
		estp.CodigoEstrategia,
		estp.Grupo,
		estp.SAP,
		mare.Nombre as MarcaEstrategia,
		marpc.Nombre as MarcaMatriz,
		estp.FactorCuadre,
		pco.PrecioUnitario,
		pco.IndicadorPreUni as PrecioPublico,
		estp.Digitable,
		estp.NombreProducto,
		estp.ImagenProducto AS ImagenTipos,
		estp.ImagenBulk AS ImagenTonos,
		estp.NombreBulk,
		pco.FactorRepeticion,
		estp.IdMarca as CodigoMarca
	from 
		estrategiaproducto estp with(nolock)
		INNER JOIN estrategia est with(nolock) on estp.estrategiaid = est.estrategiaid
		INNER JOIN tipoestrategia test with(nolock) on est.tipoestrategiaid = test.tipoestrategiaid
		INNER JOIN ods.productocomercial pco WITH (NOLOCK) ON estp.cuv = pco.cuv and estp.campania = pco.anocampania
		LEFT JOIN ods.marca mare WITH(NOLOCK) ON estp.IdMarca = mare.MarcaId
		LEFT JOIN ods.marca marpc WITH(NOLOCK) ON pco.MarcaID = marpc.MarcaId
		
	where
		(estp.cuv2 = @Cuv OR estp.cuv = @cuv) and
		estp.campania = @CampaniaID
	order by estp.EstrategiaID,estp.cuv2, estp.Grupo
		
END
GO

IF OBJECT_ID('GetReporteEstrategiasPorConsultora', 'P') IS NOT NULL 
  DROP PROCEDURE GetReporteEstrategiasPorConsultora
  GO

CREATE PROC GetReporteEstrategiasPorConsultora
(
	@CampaniaID INT = 0,
	@CodigoConsultora VARCHAR(30) = '',
	@Palanca VARCHAR(3) = '',
	@FechaConsulta DATE
)
AS
BEGIN

	DECLARE @Activa INT = (SELECT TOP 1 1 FROM RevistaDigitalSuscripcion WHERE codigoConsultora = @CodigoConsultora AND CampaniaEfectiva = @CampaniaID AND EstadoRegistro = 1)
	DECLARE @ActivoMDO INT = (SELECT Estado FROM ConfiguracionPaisdatos where codigo='ActivoMDO')

	IF @Palanca = '4'
	BEGIN
		SET @Palanca = '10'
		IF @ActivoMDO <> 1 AND @Activa <> 1
		BEGIN
			SET @Palanca = '4'
		END

	END


	IF @Palanca = '4'--OPT
	BEGIN

		declare @tmpOpt TABLE (
			EstrategiaID VARCHAR(150)				,CUV2 VARCHAR(150)			,DescripcionCUV2 VARCHAR(300)		,EtiquetaDescripcion VARCHAR(150)	,Precio VARCHAR(150),
			EtiquetaDescripcion2 VARCHAR(150)		,Precio2 VARCHAR(150)		,TextoLibre VARCHAR(150)			,FlagEstrella VARCHAR(150)			,ColorFondo VARCHAR(150),
			TipoEstrategiaID VARCHAR(150)			,FotoProducto01 VARCHAR(150),ImagenURL VARCHAR(150)				,LimiteVenta VARCHAR(150)			,MarcaID VARCHAR(150),
			Orden1 VARCHAR(150)						,Orden2 VARCHAR(150)		,IndicadorMontoMinimo VARCHAR(150)	,FlagNueva VARCHAR(150)				,TipoTallaColor VARCHAR(150),
			TipoEstrategiaImagenMostrar VARCHAR(150),CodigoProducto VARCHAR(150),EtiquetaID VARCHAR(150)			,EtiquetaID2 VARCHAR(150)			,CodigoEstrategia VARCHAR(150),
			TieneVariedad VARCHAR(150)				,CODIGO VARCHAR(150)		,DescripcionEstrategia VARCHAR(150)	,FlagMostrarImg VARCHAR(150)		,DescripcionMarca VARCHAR(150),
			DescripcionCategoria VARCHAR(150)		,PrecioPublico VARCHAR(150)	,Ganancia VARCHAR(150))
		
		insert into @tmpOpt exec ListarEstrategiasOPT @CampaniaID,@CodigoConsultora
		select CUV2 as CUV, DescripcionCUV2 as Descripcion from @tmpOpt

	END
	ELSE IF @Palanca = '10' --RD
	BEGIN

		DECLARE @EstrategiaCodigoOPM varchar(100) = '007'
		DECLARE @EstrategiaCodigoPAD varchar(100) = '008'
		DECLARE @TipoPersonalizacionCodigoOpm varchar(3) = 'OPM'
		DECLARE @TipoPersonalizacionCodigoPad varchar(3) = 'PAD'
		DECLARE @TipoPersonalizacionCodigoOpmPad varchar(3) = 'OPM;PAD'

		DECLARE @tablaCuvFaltante TABLE(CUV VARCHAR(6))
		INSERT INTO @tablaCuvFaltante(CUV)
		SELECT CUV FROM [dbo].[ObtenerCuvFaltante](@CampaniaID,@CodigoConsultora)

		DECLARE @CodConsultoraDefault VARCHAR(9) = ''
		SELECT @CodConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001

		DECLARE @CodConsultoraForzada VARCHAR(9) = ''
		SELECT @CodConsultoraForzada = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10002

		DECLARE  @OfertasPersonalizadas TABLE (Orden INT, CUV CHAR(6), TipoPersonalizacion CHAR(3), FlagRevista INT, AnioCampanaVenta INT, TipoEstrategiaId INT)

		INSERT INTO @OfertasPersonalizadas EXEC ListarOfertasPersonalizadas @CampaniaID,@TipoPersonalizacionCodigoOpmPad,@CodigoConsultora

		IF NOT EXISTS (SELECT TOP 1 CUV FROM @OfertasPersonalizadas)
		BEGIN
			INSERT INTO @OfertasPersonalizadas
			EXEC ListarOfertasPersonalizadas @CampaniaID,@TipoPersonalizacionCodigoOpmPad,@codConsultoraDefault
		END

		INSERT INTO @OfertasPersonalizadas EXEC ListarOfertasPersonalizadas @CampaniaID,@TipoPersonalizacionCodigoPad,@codConsultoraForzada
		INSERT INTO @OfertasPersonalizadas EXEC ListarOfertasPersonalizadas @CampaniaID,@TipoPersonalizacionCodigoOpm,@codConsultoraForzada

		SELECT
			E.CUV2 as CUV,
			E.DescripcionCUV2 as Descripcion
		FROM  dbo.Estrategia E with(nolock)
			INNER JOIN @OfertasPersonalizadas op ON E.CampaniaID = op.AnioCampanaVenta AND E.CUV2 = op.CUV AND OP.TipoEstrategiaId = E.TipoEstrategiaId
			INNER JOIN dbo.TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID AND TE.Codigo in (@EstrategiaCodigoOPM, @EstrategiaCodigoPAD)
			LEFT JOIN @tablaCuvFaltante TF ON E.CUV2 = TF.CUV
		WHERE
			E.Activo = 1 AND TE.FlagActivo = 1 AND TE.flagRecoPerfil = 1 AND TF.CUV IS NULL
		ORDER BY OP.Orden ASC, E.EstrategiaID ASC

	END
	ELSE IF @Palanca = '7' --ODD
	BEGIN

		DECLARE @fechaInicioFact DATE
		DECLARE @ZonaId INT
		DECLARE @num INT

		SET @ZonaId = (select ZonaId from ods.consultora where codigo = @CodigoConsultora)
		SET @fechaInicioFact = 
			(SELECT C.FechaInicioFacturacion 
			FROM ods.Cronograma C  
			INNER JOIN ods.Campania Ca ON C.CampaniaID = Ca.CampaniaID
			INNER JOIN [ods].[Zona] z (nolock) ON C.RegionID = z.RegionID AND c.ZonaID = z.ZonaID	
			WHERE Ca.Codigo = @CampaniaID AND Z.ZonaID = CASE WHEN @ZonaID = -1 THEN Z.ZonaID ELSE @ZonaID END)

		SET @num = (DATEDIFF(dd, @FechaConsulta, GETDATE()))
		SET @fechaInicioFact = (DATEADD(dd, @num, @fechaInicioFact))

		declare @tmpODD TABLE (
			EstrategiaID VARCHAR(150)				,CUV2 VARCHAR(150)				,DescripcionCUV2 VARCHAR(300)				,EtiquetaDescripcion VARCHAR(150)	,Precio VARCHAR(150),
			EtiquetaDescripcion2 VARCHAR(150)		,Precio2 VARCHAR(150)			,TextoLibre VARCHAR(150)					,CodigoEstrategia VARCHAR(150)		,FlagEstrella VARCHAR(150),
			ColorFondo VARCHAR(150)					,TipoEstrategiaID VARCHAR(150)	,FotoProducto01 VARCHAR(150)				,ImagenURL VARCHAR(150)				,LimiteVenta VARCHAR(150),
			MarcaID VARCHAR(150)					,Orden1 VARCHAR(150)			,Orden2 VARCHAR(150)						,IndicadorMontoMinimo VARCHAR(150)	,CodigoProducto VARCHAR(150),
			FlagNueva VARCHAR(150)					,TipoTallaColor VARCHAR(150)	,TipoEstrategiaImagenMostrar VARCHAR(150)	,EtiquetaID VARCHAR(150)			,EtiquetaID2 VARCHAR(150),
			CodigoEstrategia2 VARCHAR(150)			,TieneVariedad VARCHAR(150)		,CODIGO VARCHAR(150)						,DescripcionEstrategia VARCHAR(150)	,FlagMostrarImg VARCHAR(150),
			PrecioPublico VARCHAR(150)				,Ganancia VARCHAR(150)			,DescripcionMarca VARCHAR(150)				,FlagRevista VARCHAR(150)			,ImagenMiniaturaURL VARCHAR(150),
			DiaInicio VARCHAR(150))	

		insert into @tmpODD exec ListarEstrategiasODD2 @CampaniaID,@CodigoConsultora,@fechaInicioFact
		select CUV2 as CUV, DescripcionCUV2 as Descripcion from @tmpODD

	END
	ELSE IF @Palanca = '30' --SR
	BEGIN

		declare @tmpSR TABLE (
			EstrategiaID VARCHAR(150)				,CUV2 VARCHAR(150)							,DescripcionCUV2 VARCHAR(300)				,EtiquetaDescripcion VARCHAR(150)	,Precio VARCHAR(150),
			EtiquetaDescripcion2 VARCHAR(150)		,Precio2 VARCHAR(150)						,TextoLibre VARCHAR(150)					,FlagEstrella VARCHAR(150)			,ColorFondo VARCHAR(150),
			TipoEstrategiaID VARCHAR(150)			,FotoProducto01 VARCHAR(150)				,ImagenURL VARCHAR(150)						,LimiteVenta VARCHAR(150)			,MarcaID VARCHAR(150),
			Orden1 VARCHAR(150)						,Orden2 VARCHAR(150)						,IndicadorMontoMinimo VARCHAR(150)			,CodigoProducto VARCHAR(150)		,FlagNueva VARCHAR(150),
			TipoTallaColor VARCHAR(150)				,TipoEstrategiaImagenMostrar VARCHAR(150)	,EtiquetaID VARCHAR(150)					,EtiquetaID2 VARCHAR(150)			,CodigoEstrategia VARCHAR(150),
			TieneVariedad VARCHAR(150)				,CODIGO VARCHAR(150)						,DescripcionEstrategia VARCHAR(150)			,FlagMostrarImg VARCHAR(150)		,PrecioPublico VARCHAR(150),
			Ganancia VARCHAR(150)					,DescripcionMarca VARCHAR(150)				,FlagRevista VARCHAR(150)					,ImagenMiniaturaURL VARCHAR(150)	,EsSubCampania VARCHAR(150))

		insert into @tmpSR exec ListarEstrategiasShowRoom @CampaniaID,@CodigoConsultora
		select CUV2 as CUV, DescripcionCUV2 as Descripcion from @tmpSR

	END
	ELSE IF @Palanca = '9' --LAN
	BEGIN

		declare @tmpLAN TABLE (
			EstrategiaID VARCHAR(150)				,CUV2 VARCHAR(150)							,DescripcionCUV2 VARCHAR(300)				,EtiquetaDescripcion VARCHAR(150)	,Precio VARCHAR(150),
			EtiquetaDescripcion2 VARCHAR(150)		,Precio2 VARCHAR(150)						,TextoLibre VARCHAR(150)					,FlagEstrella VARCHAR(150)			,ColorFondo VARCHAR(150),
			TipoEstrategiaID VARCHAR(150)			,FotoProducto01 VARCHAR(150)				,ImagenURL VARCHAR(150)						,LimiteVenta VARCHAR(150)			,MarcaID VARCHAR(150),
			Orden1 VARCHAR(150)						,Orden2 VARCHAR(150)						,IndicadorMontoMinimo VARCHAR(150)			,FlagNueva VARCHAR(150)				,TipoTallaColor VARCHAR(150),
			TipoEstrategiaImagenMostrar VARCHAR(150),CodigoProducto VARCHAR(150)				,EtiquetaID VARCHAR(150)					,EtiquetaID2 VARCHAR(150)			,CodigoEstrategia VARCHAR(150),
			TieneVariedad VARCHAR(150)				,CODIGO VARCHAR(150)						,DescripcionEstrategia VARCHAR(150)			,FlagMostrarImg VARCHAR(150)		,DescripcionMarca VARCHAR(150),
			DescripcionCategoria VARCHAR(150)		,FlagIndividual VARCHAR(150)				,Slogan VARCHAR(150)						,ImgFondoDesktop VARCHAR(150)		,ImgFichaDesktop VARCHAR(150),
			UrlVideoDesktop VARCHAR(150)			,ImgFichaFondoDesktop VARCHAR(150)			,ImgFondoMobile VARCHAR(150)				,ImgSelloProductoMobile VARCHAR(150),UrlVideoMobile VARCHAR(150),
			ImgFichaFondoMobile VARCHAR(150)		,ImgHomeDesktop VARCHAR(150)				,ImgHomeMobile VARCHAR(150)					,PrecioPublico VARCHAR(150)			,Ganancia VARCHAR(150))

		insert into @tmpLAN exec ListarEstrategiasLanzamiento @CampaniaID,@CodigoConsultora
		select CUV2 as CUV, DescripcionCUV2 as Descripcion from @tmpLAN

	END
	ELSE IF @Palanca = '12' --GND 
	BEGIN

		declare @tmpGND TABLE (
			EstrategiaID VARCHAR(150)				,CUV2 VARCHAR(150)							,DescripcionCUV2 VARCHAR(300)				,EtiquetaDescripcion VARCHAR(150)	,Precio VARCHAR(150),
			EtiquetaDescripcion2 VARCHAR(150)		,Precio2 VARCHAR(150)						,TextoLibre VARCHAR(150)					,FlagEstrella VARCHAR(150)			,ColorFondo VARCHAR(150),
			TipoEstrategiaID VARCHAR(150)			,FotoProducto01 VARCHAR(150)				,ImagenURL VARCHAR(150)						,LimiteVenta VARCHAR(150)			,MarcaID VARCHAR(150),
			Orden1 VARCHAR(150)						,Orden2 VARCHAR(150)						,IndicadorMontoMinimo VARCHAR(150)			,CodigoProducto VARCHAR(150)		,FlagNueva VARCHAR(150),
			TipoTallaColor VARCHAR(150)				,TipoEstrategiaImagenMostrar VARCHAR(150)	,EtiquetaID VARCHAR(150)					,EtiquetaID2 VARCHAR(150)			,CodigoEstrategia VARCHAR(150),
			TieneVariedad VARCHAR(150)				,CODIGO VARCHAR(150)						,DescripcionEstrategia VARCHAR(150)			,FlagMostrarImg VARCHAR(150)		,PrecioPublico VARCHAR(150),
			Ganancia VARCHAR(150)					,DescripcionMarca VARCHAR(150)				,FlagRevista VARCHAR(150))

		insert into @tmpGND exec ListarEstrategiasGuiaDeNegocioDigitalizada @CampaniaID,@CodigoConsultora
		select CUV2 as CUV, DescripcionCUV2 as Descripcion from @tmpGND

	END
END
GO

IF OBJECT_ID('GetReporteMovimientosPedido', 'P') IS NOT NULL 
  DROP PROCEDURE GetReporteMovimientosPedido
  GO

CREATE PROC GetReporteMovimientosPedido
(
	@CampaniaID INT = 0,
	@CodigoConsultora VARCHAR(30) = ''
)
AS
BEGIN

	DECLARE @consultoraId INT
	DECLARE @tipoAccionEliminacionProl INT

	SET @tipoAccionEliminacionProl = 201
	SET @consultoraId = (select consultoraid from ods.consultora where codigo = @CodigoConsultora)

	select
		pwaprol.Cuv, COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, pco.Descripcion) AS Descripcion, FechaAccion, 'PROL' as Origen, MensajeProl as Mensaje
	from 
		[dbo].[PedidoWebAccionesPROL] pwaprol
		LEFT join ods.productocomercial pco with(nolock) ON pwaprol.Cuv = pco.cuv and @CampaniaID = pco.anocampania
		LEFT JOIN dbo.MatrizComercial MC WITH (NOLOCK) ON pco.CodigoProducto = MC.CodigoSAP
		LEFT JOIN dbo.OfertaProducto OP WITH (NOLOCK) ON OP.CampaniaID = pco.anocampania AND OP.CUV = pco.CUV
		LEFT JOIN dbo.ProductoDescripcion PD WITH (NOLOCK) ON pco.anocampania = PD.CampaniaID AND pco.CUV = PD.CUV
	where
		pwaprol.ConsultoraID = @consultoraId and 
		pwaprol.CampaniaID = @CampaniaID and
		pwaprol.Accion = @tipoAccionEliminacionProl

	UNION

	select
		pwdseg.Cuv, COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, pco.Descripcion) AS Descripcion, FechaAccion, 'CONSULTORA' as Origen, '' as Mensaje
	from 
		[dbo].[PedidoWebDetalleSeguimiento] pwdseg
		LEFT join ods.productocomercial pco with(nolock) ON pwdseg.Cuv = pco.cuv and @CampaniaID = pco.anocampania
		LEFT JOIN dbo.MatrizComercial MC WITH (NOLOCK) ON pco.CodigoProducto = MC.CodigoSAP
		LEFT JOIN dbo.OfertaProducto OP WITH (NOLOCK) ON OP.CampaniaID = pco.anocampania AND OP.CUV = pco.CUV
		LEFT JOIN dbo.ProductoDescripcion PD WITH (NOLOCK) ON pco.anocampania = PD.CampaniaID AND pco.CUV = PD.CUV
	where
		pwdseg.ConsultoraID = @consultoraId and 
		pwdseg.CampaniaID = @CampaniaID

END
GO

IF OBJECT_ID('GetReporteCuvResumido', 'P') IS NOT NULL 
  DROP PROCEDURE GetReporteCuvResumido
  GO

CREATE PROC GetReporteCuvResumido
(
	@CampaniaID INT = 0,
	@Cuv VARCHAR(10) = ''
)
AS
BEGIN
	select
		
		pco.Cuv
		, pco.CodigoProducto as SAP
		, COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, est.DescripcionCUV2, pco.Descripcion) AS DescripcionProd
		, isnull(tes.DescripcionEstrategia,'') as Palanca
		, isnull(est.imagenURL,'') as imagenURL
		, case isnull(est.activo,'1') when 1 then 'SI' else 'NO' end as Activo
		, case isnull(pco.IndicadorDigitable,'0') when 1 then 'NO' else 'SI' end as PuedeDigitarse
		, isnull(est.Precio2,pco.PrecioCatalogo) as PrecioSet
	from 
		ods.productocomercial pco with(nolock)
		LEFT JOIN dbo.MatrizComercial MC WITH (NOLOCK) ON pco.CodigoProducto = MC.CodigoSAP
		LEFT JOIN dbo.OfertaProducto OP WITH (NOLOCK) ON OP.CampaniaID = pco.anocampania AND OP.CUV = pco.CUV
		LEFT JOIN dbo.ProductoDescripcion PD WITH (NOLOCK) ON pco.anocampania = PD.CampaniaID AND pco.CUV = PD.CUV
		LEFT JOIN estrategia est with(nolock) on pco.cuv = est.cuv2 and pco.anocampania = est.campaniaid
		LEFT JOIN tipoestrategia tes with(nolock) on est.tipoestrategiaid = tes.tipoestrategiaid
	where
		pco.cuv = @Cuv and 
		pco.anocampania = @CampaniaID
END
GO


USE [BelcorpEcuador]
GO

IF OBJECT_ID('GetReporteCuvDetallado', 'P') IS NOT NULL 
  DROP PROCEDURE GetReporteCuvDetallado
  GO

CREATE PROC GetReporteCuvDetallado
(
	@CampaniaID INT = 0,
	@Cuv VARCHAR(10) = ''
)
AS
BEGIN
	select
		test.DescripcionEstrategia,
		estp.cuv2 as CuvPadre,
		estp.cuv as CuvHijo,
		estp.CodigoEstrategia,
		estp.Grupo,
		estp.SAP,
		mare.Nombre as MarcaEstrategia,
		marpc.Nombre as MarcaMatriz,
		estp.FactorCuadre,
		pco.PrecioUnitario,
		pco.IndicadorPreUni as PrecioPublico,
		estp.Digitable,
		estp.NombreProducto,
		estp.ImagenProducto AS ImagenTipos,
		estp.ImagenBulk AS ImagenTonos,
		estp.NombreBulk,
		pco.FactorRepeticion,
		estp.IdMarca as CodigoMarca
	from 
		estrategiaproducto estp with(nolock)
		INNER JOIN estrategia est with(nolock) on estp.estrategiaid = est.estrategiaid
		INNER JOIN tipoestrategia test with(nolock) on est.tipoestrategiaid = test.tipoestrategiaid
		INNER JOIN ods.productocomercial pco WITH (NOLOCK) ON estp.cuv = pco.cuv and estp.campania = pco.anocampania
		LEFT JOIN ods.marca mare WITH(NOLOCK) ON estp.IdMarca = mare.MarcaId
		LEFT JOIN ods.marca marpc WITH(NOLOCK) ON pco.MarcaID = marpc.MarcaId
		
	where
		(estp.cuv2 = @Cuv OR estp.cuv = @cuv) and
		estp.campania = @CampaniaID
	order by estp.EstrategiaID,estp.cuv2, estp.Grupo
		
END
GO

IF OBJECT_ID('GetReporteEstrategiasPorConsultora', 'P') IS NOT NULL 
  DROP PROCEDURE GetReporteEstrategiasPorConsultora
  GO

CREATE PROC GetReporteEstrategiasPorConsultora
(
	@CampaniaID INT = 0,
	@CodigoConsultora VARCHAR(30) = '',
	@Palanca VARCHAR(3) = '',
	@FechaConsulta DATE
)
AS
BEGIN

	DECLARE @Activa INT = (SELECT TOP 1 1 FROM RevistaDigitalSuscripcion WHERE codigoConsultora = @CodigoConsultora AND CampaniaEfectiva = @CampaniaID AND EstadoRegistro = 1)
	DECLARE @ActivoMDO INT = (SELECT Estado FROM ConfiguracionPaisdatos where codigo='ActivoMDO')

	IF @Palanca = '4'
	BEGIN
		SET @Palanca = '10'
		IF @ActivoMDO <> 1 AND @Activa <> 1
		BEGIN
			SET @Palanca = '4'
		END

	END


	IF @Palanca = '4'--OPT
	BEGIN

		declare @tmpOpt TABLE (
			EstrategiaID VARCHAR(150)				,CUV2 VARCHAR(150)			,DescripcionCUV2 VARCHAR(300)		,EtiquetaDescripcion VARCHAR(150)	,Precio VARCHAR(150),
			EtiquetaDescripcion2 VARCHAR(150)		,Precio2 VARCHAR(150)		,TextoLibre VARCHAR(150)			,FlagEstrella VARCHAR(150)			,ColorFondo VARCHAR(150),
			TipoEstrategiaID VARCHAR(150)			,FotoProducto01 VARCHAR(150),ImagenURL VARCHAR(150)				,LimiteVenta VARCHAR(150)			,MarcaID VARCHAR(150),
			Orden1 VARCHAR(150)						,Orden2 VARCHAR(150)		,IndicadorMontoMinimo VARCHAR(150)	,FlagNueva VARCHAR(150)				,TipoTallaColor VARCHAR(150),
			TipoEstrategiaImagenMostrar VARCHAR(150),CodigoProducto VARCHAR(150),EtiquetaID VARCHAR(150)			,EtiquetaID2 VARCHAR(150)			,CodigoEstrategia VARCHAR(150),
			TieneVariedad VARCHAR(150)				,CODIGO VARCHAR(150)		,DescripcionEstrategia VARCHAR(150)	,FlagMostrarImg VARCHAR(150)		,DescripcionMarca VARCHAR(150),
			DescripcionCategoria VARCHAR(150)		,PrecioPublico VARCHAR(150)	,Ganancia VARCHAR(150))
		
		insert into @tmpOpt exec ListarEstrategiasOPT @CampaniaID,@CodigoConsultora
		select CUV2 as CUV, DescripcionCUV2 as Descripcion from @tmpOpt

	END
	ELSE IF @Palanca = '10' --RD
	BEGIN

		DECLARE @EstrategiaCodigoOPM varchar(100) = '007'
		DECLARE @EstrategiaCodigoPAD varchar(100) = '008'
		DECLARE @TipoPersonalizacionCodigoOpm varchar(3) = 'OPM'
		DECLARE @TipoPersonalizacionCodigoPad varchar(3) = 'PAD'
		DECLARE @TipoPersonalizacionCodigoOpmPad varchar(3) = 'OPM;PAD'

		DECLARE @tablaCuvFaltante TABLE(CUV VARCHAR(6))
		INSERT INTO @tablaCuvFaltante(CUV)
		SELECT CUV FROM [dbo].[ObtenerCuvFaltante](@CampaniaID,@CodigoConsultora)

		DECLARE @CodConsultoraDefault VARCHAR(9) = ''
		SELECT @CodConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001

		DECLARE @CodConsultoraForzada VARCHAR(9) = ''
		SELECT @CodConsultoraForzada = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10002

		DECLARE  @OfertasPersonalizadas TABLE (Orden INT, CUV CHAR(6), TipoPersonalizacion CHAR(3), FlagRevista INT, AnioCampanaVenta INT, TipoEstrategiaId INT)

		INSERT INTO @OfertasPersonalizadas EXEC ListarOfertasPersonalizadas @CampaniaID,@TipoPersonalizacionCodigoOpmPad,@CodigoConsultora

		IF NOT EXISTS (SELECT TOP 1 CUV FROM @OfertasPersonalizadas)
		BEGIN
			INSERT INTO @OfertasPersonalizadas
			EXEC ListarOfertasPersonalizadas @CampaniaID,@TipoPersonalizacionCodigoOpmPad,@codConsultoraDefault
		END

		INSERT INTO @OfertasPersonalizadas EXEC ListarOfertasPersonalizadas @CampaniaID,@TipoPersonalizacionCodigoPad,@codConsultoraForzada
		INSERT INTO @OfertasPersonalizadas EXEC ListarOfertasPersonalizadas @CampaniaID,@TipoPersonalizacionCodigoOpm,@codConsultoraForzada

		SELECT
			E.CUV2 as CUV,
			E.DescripcionCUV2 as Descripcion
		FROM  dbo.Estrategia E with(nolock)
			INNER JOIN @OfertasPersonalizadas op ON E.CampaniaID = op.AnioCampanaVenta AND E.CUV2 = op.CUV AND OP.TipoEstrategiaId = E.TipoEstrategiaId
			INNER JOIN dbo.TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID AND TE.Codigo in (@EstrategiaCodigoOPM, @EstrategiaCodigoPAD)
			LEFT JOIN @tablaCuvFaltante TF ON E.CUV2 = TF.CUV
		WHERE
			E.Activo = 1 AND TE.FlagActivo = 1 AND TE.flagRecoPerfil = 1 AND TF.CUV IS NULL
		ORDER BY OP.Orden ASC, E.EstrategiaID ASC

	END
	ELSE IF @Palanca = '7' --ODD
	BEGIN

		DECLARE @fechaInicioFact DATE
		DECLARE @ZonaId INT
		DECLARE @num INT

		SET @ZonaId = (select ZonaId from ods.consultora where codigo = @CodigoConsultora)
		SET @fechaInicioFact = 
			(SELECT C.FechaInicioFacturacion 
			FROM ods.Cronograma C  
			INNER JOIN ods.Campania Ca ON C.CampaniaID = Ca.CampaniaID
			INNER JOIN [ods].[Zona] z (nolock) ON C.RegionID = z.RegionID AND c.ZonaID = z.ZonaID	
			WHERE Ca.Codigo = @CampaniaID AND Z.ZonaID = CASE WHEN @ZonaID = -1 THEN Z.ZonaID ELSE @ZonaID END)

		SET @num = (DATEDIFF(dd, @FechaConsulta, GETDATE()))
		SET @fechaInicioFact = (DATEADD(dd, @num, @fechaInicioFact))

		declare @tmpODD TABLE (
			EstrategiaID VARCHAR(150)				,CUV2 VARCHAR(150)				,DescripcionCUV2 VARCHAR(300)				,EtiquetaDescripcion VARCHAR(150)	,Precio VARCHAR(150),
			EtiquetaDescripcion2 VARCHAR(150)		,Precio2 VARCHAR(150)			,TextoLibre VARCHAR(150)					,CodigoEstrategia VARCHAR(150)		,FlagEstrella VARCHAR(150),
			ColorFondo VARCHAR(150)					,TipoEstrategiaID VARCHAR(150)	,FotoProducto01 VARCHAR(150)				,ImagenURL VARCHAR(150)				,LimiteVenta VARCHAR(150),
			MarcaID VARCHAR(150)					,Orden1 VARCHAR(150)			,Orden2 VARCHAR(150)						,IndicadorMontoMinimo VARCHAR(150)	,CodigoProducto VARCHAR(150),
			FlagNueva VARCHAR(150)					,TipoTallaColor VARCHAR(150)	,TipoEstrategiaImagenMostrar VARCHAR(150)	,EtiquetaID VARCHAR(150)			,EtiquetaID2 VARCHAR(150),
			CodigoEstrategia2 VARCHAR(150)			,TieneVariedad VARCHAR(150)		,CODIGO VARCHAR(150)						,DescripcionEstrategia VARCHAR(150)	,FlagMostrarImg VARCHAR(150),
			PrecioPublico VARCHAR(150)				,Ganancia VARCHAR(150)			,DescripcionMarca VARCHAR(150)				,FlagRevista VARCHAR(150)			,ImagenMiniaturaURL VARCHAR(150),
			DiaInicio VARCHAR(150))	

		insert into @tmpODD exec ListarEstrategiasODD2 @CampaniaID,@CodigoConsultora,@fechaInicioFact
		select CUV2 as CUV, DescripcionCUV2 as Descripcion from @tmpODD

	END
	ELSE IF @Palanca = '30' --SR
	BEGIN

		declare @tmpSR TABLE (
			EstrategiaID VARCHAR(150)				,CUV2 VARCHAR(150)							,DescripcionCUV2 VARCHAR(300)				,EtiquetaDescripcion VARCHAR(150)	,Precio VARCHAR(150),
			EtiquetaDescripcion2 VARCHAR(150)		,Precio2 VARCHAR(150)						,TextoLibre VARCHAR(150)					,FlagEstrella VARCHAR(150)			,ColorFondo VARCHAR(150),
			TipoEstrategiaID VARCHAR(150)			,FotoProducto01 VARCHAR(150)				,ImagenURL VARCHAR(150)						,LimiteVenta VARCHAR(150)			,MarcaID VARCHAR(150),
			Orden1 VARCHAR(150)						,Orden2 VARCHAR(150)						,IndicadorMontoMinimo VARCHAR(150)			,CodigoProducto VARCHAR(150)		,FlagNueva VARCHAR(150),
			TipoTallaColor VARCHAR(150)				,TipoEstrategiaImagenMostrar VARCHAR(150)	,EtiquetaID VARCHAR(150)					,EtiquetaID2 VARCHAR(150)			,CodigoEstrategia VARCHAR(150),
			TieneVariedad VARCHAR(150)				,CODIGO VARCHAR(150)						,DescripcionEstrategia VARCHAR(150)			,FlagMostrarImg VARCHAR(150)		,PrecioPublico VARCHAR(150),
			Ganancia VARCHAR(150)					,DescripcionMarca VARCHAR(150)				,FlagRevista VARCHAR(150)					,ImagenMiniaturaURL VARCHAR(150)	,EsSubCampania VARCHAR(150))

		insert into @tmpSR exec ListarEstrategiasShowRoom @CampaniaID,@CodigoConsultora
		select CUV2 as CUV, DescripcionCUV2 as Descripcion from @tmpSR

	END
	ELSE IF @Palanca = '9' --LAN
	BEGIN

		declare @tmpLAN TABLE (
			EstrategiaID VARCHAR(150)				,CUV2 VARCHAR(150)							,DescripcionCUV2 VARCHAR(300)				,EtiquetaDescripcion VARCHAR(150)	,Precio VARCHAR(150),
			EtiquetaDescripcion2 VARCHAR(150)		,Precio2 VARCHAR(150)						,TextoLibre VARCHAR(150)					,FlagEstrella VARCHAR(150)			,ColorFondo VARCHAR(150),
			TipoEstrategiaID VARCHAR(150)			,FotoProducto01 VARCHAR(150)				,ImagenURL VARCHAR(150)						,LimiteVenta VARCHAR(150)			,MarcaID VARCHAR(150),
			Orden1 VARCHAR(150)						,Orden2 VARCHAR(150)						,IndicadorMontoMinimo VARCHAR(150)			,FlagNueva VARCHAR(150)				,TipoTallaColor VARCHAR(150),
			TipoEstrategiaImagenMostrar VARCHAR(150),CodigoProducto VARCHAR(150)				,EtiquetaID VARCHAR(150)					,EtiquetaID2 VARCHAR(150)			,CodigoEstrategia VARCHAR(150),
			TieneVariedad VARCHAR(150)				,CODIGO VARCHAR(150)						,DescripcionEstrategia VARCHAR(150)			,FlagMostrarImg VARCHAR(150)		,DescripcionMarca VARCHAR(150),
			DescripcionCategoria VARCHAR(150)		,FlagIndividual VARCHAR(150)				,Slogan VARCHAR(150)						,ImgFondoDesktop VARCHAR(150)		,ImgFichaDesktop VARCHAR(150),
			UrlVideoDesktop VARCHAR(150)			,ImgFichaFondoDesktop VARCHAR(150)			,ImgFondoMobile VARCHAR(150)				,ImgSelloProductoMobile VARCHAR(150),UrlVideoMobile VARCHAR(150),
			ImgFichaFondoMobile VARCHAR(150)		,ImgHomeDesktop VARCHAR(150)				,ImgHomeMobile VARCHAR(150)					,PrecioPublico VARCHAR(150)			,Ganancia VARCHAR(150))

		insert into @tmpLAN exec ListarEstrategiasLanzamiento @CampaniaID,@CodigoConsultora
		select CUV2 as CUV, DescripcionCUV2 as Descripcion from @tmpLAN

	END
	ELSE IF @Palanca = '12' --GND 
	BEGIN

		declare @tmpGND TABLE (
			EstrategiaID VARCHAR(150)				,CUV2 VARCHAR(150)							,DescripcionCUV2 VARCHAR(300)				,EtiquetaDescripcion VARCHAR(150)	,Precio VARCHAR(150),
			EtiquetaDescripcion2 VARCHAR(150)		,Precio2 VARCHAR(150)						,TextoLibre VARCHAR(150)					,FlagEstrella VARCHAR(150)			,ColorFondo VARCHAR(150),
			TipoEstrategiaID VARCHAR(150)			,FotoProducto01 VARCHAR(150)				,ImagenURL VARCHAR(150)						,LimiteVenta VARCHAR(150)			,MarcaID VARCHAR(150),
			Orden1 VARCHAR(150)						,Orden2 VARCHAR(150)						,IndicadorMontoMinimo VARCHAR(150)			,CodigoProducto VARCHAR(150)		,FlagNueva VARCHAR(150),
			TipoTallaColor VARCHAR(150)				,TipoEstrategiaImagenMostrar VARCHAR(150)	,EtiquetaID VARCHAR(150)					,EtiquetaID2 VARCHAR(150)			,CodigoEstrategia VARCHAR(150),
			TieneVariedad VARCHAR(150)				,CODIGO VARCHAR(150)						,DescripcionEstrategia VARCHAR(150)			,FlagMostrarImg VARCHAR(150)		,PrecioPublico VARCHAR(150),
			Ganancia VARCHAR(150)					,DescripcionMarca VARCHAR(150)				,FlagRevista VARCHAR(150))

		insert into @tmpGND exec ListarEstrategiasGuiaDeNegocioDigitalizada @CampaniaID,@CodigoConsultora
		select CUV2 as CUV, DescripcionCUV2 as Descripcion from @tmpGND

	END
END
GO

IF OBJECT_ID('GetReporteMovimientosPedido', 'P') IS NOT NULL 
  DROP PROCEDURE GetReporteMovimientosPedido
  GO

CREATE PROC GetReporteMovimientosPedido
(
	@CampaniaID INT = 0,
	@CodigoConsultora VARCHAR(30) = ''
)
AS
BEGIN

	DECLARE @consultoraId INT
	DECLARE @tipoAccionEliminacionProl INT

	SET @tipoAccionEliminacionProl = 201
	SET @consultoraId = (select consultoraid from ods.consultora where codigo = @CodigoConsultora)

	select
		pwaprol.Cuv, COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, pco.Descripcion) AS Descripcion, FechaAccion, 'PROL' as Origen, MensajeProl as Mensaje
	from 
		[dbo].[PedidoWebAccionesPROL] pwaprol
		LEFT join ods.productocomercial pco with(nolock) ON pwaprol.Cuv = pco.cuv and @CampaniaID = pco.anocampania
		LEFT JOIN dbo.MatrizComercial MC WITH (NOLOCK) ON pco.CodigoProducto = MC.CodigoSAP
		LEFT JOIN dbo.OfertaProducto OP WITH (NOLOCK) ON OP.CampaniaID = pco.anocampania AND OP.CUV = pco.CUV
		LEFT JOIN dbo.ProductoDescripcion PD WITH (NOLOCK) ON pco.anocampania = PD.CampaniaID AND pco.CUV = PD.CUV
	where
		pwaprol.ConsultoraID = @consultoraId and 
		pwaprol.CampaniaID = @CampaniaID and
		pwaprol.Accion = @tipoAccionEliminacionProl

	UNION

	select
		pwdseg.Cuv, COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, pco.Descripcion) AS Descripcion, FechaAccion, 'CONSULTORA' as Origen, '' as Mensaje
	from 
		[dbo].[PedidoWebDetalleSeguimiento] pwdseg
		LEFT join ods.productocomercial pco with(nolock) ON pwdseg.Cuv = pco.cuv and @CampaniaID = pco.anocampania
		LEFT JOIN dbo.MatrizComercial MC WITH (NOLOCK) ON pco.CodigoProducto = MC.CodigoSAP
		LEFT JOIN dbo.OfertaProducto OP WITH (NOLOCK) ON OP.CampaniaID = pco.anocampania AND OP.CUV = pco.CUV
		LEFT JOIN dbo.ProductoDescripcion PD WITH (NOLOCK) ON pco.anocampania = PD.CampaniaID AND pco.CUV = PD.CUV
	where
		pwdseg.ConsultoraID = @consultoraId and 
		pwdseg.CampaniaID = @CampaniaID

END
GO

IF OBJECT_ID('GetReporteCuvResumido', 'P') IS NOT NULL 
  DROP PROCEDURE GetReporteCuvResumido
  GO

CREATE PROC GetReporteCuvResumido
(
	@CampaniaID INT = 0,
	@Cuv VARCHAR(10) = ''
)
AS
BEGIN
	select
		
		pco.Cuv
		, pco.CodigoProducto as SAP
		, COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, est.DescripcionCUV2, pco.Descripcion) AS DescripcionProd
		, isnull(tes.DescripcionEstrategia,'') as Palanca
		, isnull(est.imagenURL,'') as imagenURL
		, case isnull(est.activo,'1') when 1 then 'SI' else 'NO' end as Activo
		, case isnull(pco.IndicadorDigitable,'0') when 1 then 'NO' else 'SI' end as PuedeDigitarse
		, isnull(est.Precio2,pco.PrecioCatalogo) as PrecioSet
	from 
		ods.productocomercial pco with(nolock)
		LEFT JOIN dbo.MatrizComercial MC WITH (NOLOCK) ON pco.CodigoProducto = MC.CodigoSAP
		LEFT JOIN dbo.OfertaProducto OP WITH (NOLOCK) ON OP.CampaniaID = pco.anocampania AND OP.CUV = pco.CUV
		LEFT JOIN dbo.ProductoDescripcion PD WITH (NOLOCK) ON pco.anocampania = PD.CampaniaID AND pco.CUV = PD.CUV
		LEFT JOIN estrategia est with(nolock) on pco.cuv = est.cuv2 and pco.anocampania = est.campaniaid
		LEFT JOIN tipoestrategia tes with(nolock) on est.tipoestrategiaid = tes.tipoestrategiaid
	where
		pco.cuv = @Cuv and 
		pco.anocampania = @CampaniaID
END
GO


USE [BelcorpGuatemala]
GO

IF OBJECT_ID('GetReporteCuvDetallado', 'P') IS NOT NULL 
  DROP PROCEDURE GetReporteCuvDetallado
  GO

CREATE PROC GetReporteCuvDetallado
(
	@CampaniaID INT = 0,
	@Cuv VARCHAR(10) = ''
)
AS
BEGIN
	select
		test.DescripcionEstrategia,
		estp.cuv2 as CuvPadre,
		estp.cuv as CuvHijo,
		estp.CodigoEstrategia,
		estp.Grupo,
		estp.SAP,
		mare.Nombre as MarcaEstrategia,
		marpc.Nombre as MarcaMatriz,
		estp.FactorCuadre,
		pco.PrecioUnitario,
		pco.IndicadorPreUni as PrecioPublico,
		estp.Digitable,
		estp.NombreProducto,
		estp.ImagenProducto AS ImagenTipos,
		estp.ImagenBulk AS ImagenTonos,
		estp.NombreBulk,
		pco.FactorRepeticion,
		estp.IdMarca as CodigoMarca
	from 
		estrategiaproducto estp with(nolock)
		INNER JOIN estrategia est with(nolock) on estp.estrategiaid = est.estrategiaid
		INNER JOIN tipoestrategia test with(nolock) on est.tipoestrategiaid = test.tipoestrategiaid
		INNER JOIN ods.productocomercial pco WITH (NOLOCK) ON estp.cuv = pco.cuv and estp.campania = pco.anocampania
		LEFT JOIN ods.marca mare WITH(NOLOCK) ON estp.IdMarca = mare.MarcaId
		LEFT JOIN ods.marca marpc WITH(NOLOCK) ON pco.MarcaID = marpc.MarcaId
		
	where
		(estp.cuv2 = @Cuv OR estp.cuv = @cuv) and
		estp.campania = @CampaniaID
	order by estp.EstrategiaID,estp.cuv2, estp.Grupo
		
END
GO

IF OBJECT_ID('GetReporteEstrategiasPorConsultora', 'P') IS NOT NULL 
  DROP PROCEDURE GetReporteEstrategiasPorConsultora
  GO

CREATE PROC GetReporteEstrategiasPorConsultora
(
	@CampaniaID INT = 0,
	@CodigoConsultora VARCHAR(30) = '',
	@Palanca VARCHAR(3) = '',
	@FechaConsulta DATE
)
AS
BEGIN

	DECLARE @Activa INT = (SELECT TOP 1 1 FROM RevistaDigitalSuscripcion WHERE codigoConsultora = @CodigoConsultora AND CampaniaEfectiva = @CampaniaID AND EstadoRegistro = 1)
	DECLARE @ActivoMDO INT = (SELECT Estado FROM ConfiguracionPaisdatos where codigo='ActivoMDO')

	IF @Palanca = '4'
	BEGIN
		SET @Palanca = '10'
		IF @ActivoMDO <> 1 AND @Activa <> 1
		BEGIN
			SET @Palanca = '4'
		END

	END


	IF @Palanca = '4'--OPT
	BEGIN

		declare @tmpOpt TABLE (
			EstrategiaID VARCHAR(150)				,CUV2 VARCHAR(150)			,DescripcionCUV2 VARCHAR(300)		,EtiquetaDescripcion VARCHAR(150)	,Precio VARCHAR(150),
			EtiquetaDescripcion2 VARCHAR(150)		,Precio2 VARCHAR(150)		,TextoLibre VARCHAR(150)			,FlagEstrella VARCHAR(150)			,ColorFondo VARCHAR(150),
			TipoEstrategiaID VARCHAR(150)			,FotoProducto01 VARCHAR(150),ImagenURL VARCHAR(150)				,LimiteVenta VARCHAR(150)			,MarcaID VARCHAR(150),
			Orden1 VARCHAR(150)						,Orden2 VARCHAR(150)		,IndicadorMontoMinimo VARCHAR(150)	,FlagNueva VARCHAR(150)				,TipoTallaColor VARCHAR(150),
			TipoEstrategiaImagenMostrar VARCHAR(150),CodigoProducto VARCHAR(150),EtiquetaID VARCHAR(150)			,EtiquetaID2 VARCHAR(150)			,CodigoEstrategia VARCHAR(150),
			TieneVariedad VARCHAR(150)				,CODIGO VARCHAR(150)		,DescripcionEstrategia VARCHAR(150)	,FlagMostrarImg VARCHAR(150)		,DescripcionMarca VARCHAR(150),
			DescripcionCategoria VARCHAR(150)		,PrecioPublico VARCHAR(150)	,Ganancia VARCHAR(150))
		
		insert into @tmpOpt exec ListarEstrategiasOPT @CampaniaID,@CodigoConsultora
		select CUV2 as CUV, DescripcionCUV2 as Descripcion from @tmpOpt

	END
	ELSE IF @Palanca = '10' --RD
	BEGIN

		DECLARE @EstrategiaCodigoOPM varchar(100) = '007'
		DECLARE @EstrategiaCodigoPAD varchar(100) = '008'
		DECLARE @TipoPersonalizacionCodigoOpm varchar(3) = 'OPM'
		DECLARE @TipoPersonalizacionCodigoPad varchar(3) = 'PAD'
		DECLARE @TipoPersonalizacionCodigoOpmPad varchar(3) = 'OPM;PAD'

		DECLARE @tablaCuvFaltante TABLE(CUV VARCHAR(6))
		INSERT INTO @tablaCuvFaltante(CUV)
		SELECT CUV FROM [dbo].[ObtenerCuvFaltante](@CampaniaID,@CodigoConsultora)

		DECLARE @CodConsultoraDefault VARCHAR(9) = ''
		SELECT @CodConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001

		DECLARE @CodConsultoraForzada VARCHAR(9) = ''
		SELECT @CodConsultoraForzada = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10002

		DECLARE  @OfertasPersonalizadas TABLE (Orden INT, CUV CHAR(6), TipoPersonalizacion CHAR(3), FlagRevista INT, AnioCampanaVenta INT, TipoEstrategiaId INT)

		INSERT INTO @OfertasPersonalizadas EXEC ListarOfertasPersonalizadas @CampaniaID,@TipoPersonalizacionCodigoOpmPad,@CodigoConsultora

		IF NOT EXISTS (SELECT TOP 1 CUV FROM @OfertasPersonalizadas)
		BEGIN
			INSERT INTO @OfertasPersonalizadas
			EXEC ListarOfertasPersonalizadas @CampaniaID,@TipoPersonalizacionCodigoOpmPad,@codConsultoraDefault
		END

		INSERT INTO @OfertasPersonalizadas EXEC ListarOfertasPersonalizadas @CampaniaID,@TipoPersonalizacionCodigoPad,@codConsultoraForzada
		INSERT INTO @OfertasPersonalizadas EXEC ListarOfertasPersonalizadas @CampaniaID,@TipoPersonalizacionCodigoOpm,@codConsultoraForzada

		SELECT
			E.CUV2 as CUV,
			E.DescripcionCUV2 as Descripcion
		FROM  dbo.Estrategia E with(nolock)
			INNER JOIN @OfertasPersonalizadas op ON E.CampaniaID = op.AnioCampanaVenta AND E.CUV2 = op.CUV AND OP.TipoEstrategiaId = E.TipoEstrategiaId
			INNER JOIN dbo.TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID AND TE.Codigo in (@EstrategiaCodigoOPM, @EstrategiaCodigoPAD)
			LEFT JOIN @tablaCuvFaltante TF ON E.CUV2 = TF.CUV
		WHERE
			E.Activo = 1 AND TE.FlagActivo = 1 AND TE.flagRecoPerfil = 1 AND TF.CUV IS NULL
		ORDER BY OP.Orden ASC, E.EstrategiaID ASC

	END
	ELSE IF @Palanca = '7' --ODD
	BEGIN

		DECLARE @fechaInicioFact DATE
		DECLARE @ZonaId INT
		DECLARE @num INT

		SET @ZonaId = (select ZonaId from ods.consultora where codigo = @CodigoConsultora)
		SET @fechaInicioFact = 
			(SELECT C.FechaInicioFacturacion 
			FROM ods.Cronograma C  
			INNER JOIN ods.Campania Ca ON C.CampaniaID = Ca.CampaniaID
			INNER JOIN [ods].[Zona] z (nolock) ON C.RegionID = z.RegionID AND c.ZonaID = z.ZonaID	
			WHERE Ca.Codigo = @CampaniaID AND Z.ZonaID = CASE WHEN @ZonaID = -1 THEN Z.ZonaID ELSE @ZonaID END)

		SET @num = (DATEDIFF(dd, @FechaConsulta, GETDATE()))
		SET @fechaInicioFact = (DATEADD(dd, @num, @fechaInicioFact))

		declare @tmpODD TABLE (
			EstrategiaID VARCHAR(150)				,CUV2 VARCHAR(150)				,DescripcionCUV2 VARCHAR(300)				,EtiquetaDescripcion VARCHAR(150)	,Precio VARCHAR(150),
			EtiquetaDescripcion2 VARCHAR(150)		,Precio2 VARCHAR(150)			,TextoLibre VARCHAR(150)					,CodigoEstrategia VARCHAR(150)		,FlagEstrella VARCHAR(150),
			ColorFondo VARCHAR(150)					,TipoEstrategiaID VARCHAR(150)	,FotoProducto01 VARCHAR(150)				,ImagenURL VARCHAR(150)				,LimiteVenta VARCHAR(150),
			MarcaID VARCHAR(150)					,Orden1 VARCHAR(150)			,Orden2 VARCHAR(150)						,IndicadorMontoMinimo VARCHAR(150)	,CodigoProducto VARCHAR(150),
			FlagNueva VARCHAR(150)					,TipoTallaColor VARCHAR(150)	,TipoEstrategiaImagenMostrar VARCHAR(150)	,EtiquetaID VARCHAR(150)			,EtiquetaID2 VARCHAR(150),
			CodigoEstrategia2 VARCHAR(150)			,TieneVariedad VARCHAR(150)		,CODIGO VARCHAR(150)						,DescripcionEstrategia VARCHAR(150)	,FlagMostrarImg VARCHAR(150),
			PrecioPublico VARCHAR(150)				,Ganancia VARCHAR(150)			,DescripcionMarca VARCHAR(150)				,FlagRevista VARCHAR(150)			,ImagenMiniaturaURL VARCHAR(150),
			DiaInicio VARCHAR(150))	

		insert into @tmpODD exec ListarEstrategiasODD2 @CampaniaID,@CodigoConsultora,@fechaInicioFact
		select CUV2 as CUV, DescripcionCUV2 as Descripcion from @tmpODD

	END
	ELSE IF @Palanca = '30' --SR
	BEGIN

		declare @tmpSR TABLE (
			EstrategiaID VARCHAR(150)				,CUV2 VARCHAR(150)							,DescripcionCUV2 VARCHAR(300)				,EtiquetaDescripcion VARCHAR(150)	,Precio VARCHAR(150),
			EtiquetaDescripcion2 VARCHAR(150)		,Precio2 VARCHAR(150)						,TextoLibre VARCHAR(150)					,FlagEstrella VARCHAR(150)			,ColorFondo VARCHAR(150),
			TipoEstrategiaID VARCHAR(150)			,FotoProducto01 VARCHAR(150)				,ImagenURL VARCHAR(150)						,LimiteVenta VARCHAR(150)			,MarcaID VARCHAR(150),
			Orden1 VARCHAR(150)						,Orden2 VARCHAR(150)						,IndicadorMontoMinimo VARCHAR(150)			,CodigoProducto VARCHAR(150)		,FlagNueva VARCHAR(150),
			TipoTallaColor VARCHAR(150)				,TipoEstrategiaImagenMostrar VARCHAR(150)	,EtiquetaID VARCHAR(150)					,EtiquetaID2 VARCHAR(150)			,CodigoEstrategia VARCHAR(150),
			TieneVariedad VARCHAR(150)				,CODIGO VARCHAR(150)						,DescripcionEstrategia VARCHAR(150)			,FlagMostrarImg VARCHAR(150)		,PrecioPublico VARCHAR(150),
			Ganancia VARCHAR(150)					,DescripcionMarca VARCHAR(150)				,FlagRevista VARCHAR(150)					,ImagenMiniaturaURL VARCHAR(150)	,EsSubCampania VARCHAR(150))

		insert into @tmpSR exec ListarEstrategiasShowRoom @CampaniaID,@CodigoConsultora
		select CUV2 as CUV, DescripcionCUV2 as Descripcion from @tmpSR

	END
	ELSE IF @Palanca = '9' --LAN
	BEGIN

		declare @tmpLAN TABLE (
			EstrategiaID VARCHAR(150)				,CUV2 VARCHAR(150)							,DescripcionCUV2 VARCHAR(300)				,EtiquetaDescripcion VARCHAR(150)	,Precio VARCHAR(150),
			EtiquetaDescripcion2 VARCHAR(150)		,Precio2 VARCHAR(150)						,TextoLibre VARCHAR(150)					,FlagEstrella VARCHAR(150)			,ColorFondo VARCHAR(150),
			TipoEstrategiaID VARCHAR(150)			,FotoProducto01 VARCHAR(150)				,ImagenURL VARCHAR(150)						,LimiteVenta VARCHAR(150)			,MarcaID VARCHAR(150),
			Orden1 VARCHAR(150)						,Orden2 VARCHAR(150)						,IndicadorMontoMinimo VARCHAR(150)			,FlagNueva VARCHAR(150)				,TipoTallaColor VARCHAR(150),
			TipoEstrategiaImagenMostrar VARCHAR(150),CodigoProducto VARCHAR(150)				,EtiquetaID VARCHAR(150)					,EtiquetaID2 VARCHAR(150)			,CodigoEstrategia VARCHAR(150),
			TieneVariedad VARCHAR(150)				,CODIGO VARCHAR(150)						,DescripcionEstrategia VARCHAR(150)			,FlagMostrarImg VARCHAR(150)		,DescripcionMarca VARCHAR(150),
			DescripcionCategoria VARCHAR(150)		,FlagIndividual VARCHAR(150)				,Slogan VARCHAR(150)						,ImgFondoDesktop VARCHAR(150)		,ImgFichaDesktop VARCHAR(150),
			UrlVideoDesktop VARCHAR(150)			,ImgFichaFondoDesktop VARCHAR(150)			,ImgFondoMobile VARCHAR(150)				,ImgSelloProductoMobile VARCHAR(150),UrlVideoMobile VARCHAR(150),
			ImgFichaFondoMobile VARCHAR(150)		,ImgHomeDesktop VARCHAR(150)				,ImgHomeMobile VARCHAR(150)					,PrecioPublico VARCHAR(150)			,Ganancia VARCHAR(150))

		insert into @tmpLAN exec ListarEstrategiasLanzamiento @CampaniaID,@CodigoConsultora
		select CUV2 as CUV, DescripcionCUV2 as Descripcion from @tmpLAN

	END
	ELSE IF @Palanca = '12' --GND 
	BEGIN

		declare @tmpGND TABLE (
			EstrategiaID VARCHAR(150)				,CUV2 VARCHAR(150)							,DescripcionCUV2 VARCHAR(300)				,EtiquetaDescripcion VARCHAR(150)	,Precio VARCHAR(150),
			EtiquetaDescripcion2 VARCHAR(150)		,Precio2 VARCHAR(150)						,TextoLibre VARCHAR(150)					,FlagEstrella VARCHAR(150)			,ColorFondo VARCHAR(150),
			TipoEstrategiaID VARCHAR(150)			,FotoProducto01 VARCHAR(150)				,ImagenURL VARCHAR(150)						,LimiteVenta VARCHAR(150)			,MarcaID VARCHAR(150),
			Orden1 VARCHAR(150)						,Orden2 VARCHAR(150)						,IndicadorMontoMinimo VARCHAR(150)			,CodigoProducto VARCHAR(150)		,FlagNueva VARCHAR(150),
			TipoTallaColor VARCHAR(150)				,TipoEstrategiaImagenMostrar VARCHAR(150)	,EtiquetaID VARCHAR(150)					,EtiquetaID2 VARCHAR(150)			,CodigoEstrategia VARCHAR(150),
			TieneVariedad VARCHAR(150)				,CODIGO VARCHAR(150)						,DescripcionEstrategia VARCHAR(150)			,FlagMostrarImg VARCHAR(150)		,PrecioPublico VARCHAR(150),
			Ganancia VARCHAR(150)					,DescripcionMarca VARCHAR(150)				,FlagRevista VARCHAR(150))

		insert into @tmpGND exec ListarEstrategiasGuiaDeNegocioDigitalizada @CampaniaID,@CodigoConsultora
		select CUV2 as CUV, DescripcionCUV2 as Descripcion from @tmpGND

	END
END
GO

IF OBJECT_ID('GetReporteMovimientosPedido', 'P') IS NOT NULL 
  DROP PROCEDURE GetReporteMovimientosPedido
  GO

CREATE PROC GetReporteMovimientosPedido
(
	@CampaniaID INT = 0,
	@CodigoConsultora VARCHAR(30) = ''
)
AS
BEGIN

	DECLARE @consultoraId INT
	DECLARE @tipoAccionEliminacionProl INT

	SET @tipoAccionEliminacionProl = 201
	SET @consultoraId = (select consultoraid from ods.consultora where codigo = @CodigoConsultora)

	select
		pwaprol.Cuv, COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, pco.Descripcion) AS Descripcion, FechaAccion, 'PROL' as Origen, MensajeProl as Mensaje
	from 
		[dbo].[PedidoWebAccionesPROL] pwaprol
		LEFT join ods.productocomercial pco with(nolock) ON pwaprol.Cuv = pco.cuv and @CampaniaID = pco.anocampania
		LEFT JOIN dbo.MatrizComercial MC WITH (NOLOCK) ON pco.CodigoProducto = MC.CodigoSAP
		LEFT JOIN dbo.OfertaProducto OP WITH (NOLOCK) ON OP.CampaniaID = pco.anocampania AND OP.CUV = pco.CUV
		LEFT JOIN dbo.ProductoDescripcion PD WITH (NOLOCK) ON pco.anocampania = PD.CampaniaID AND pco.CUV = PD.CUV
	where
		pwaprol.ConsultoraID = @consultoraId and 
		pwaprol.CampaniaID = @CampaniaID and
		pwaprol.Accion = @tipoAccionEliminacionProl

	UNION

	select
		pwdseg.Cuv, COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, pco.Descripcion) AS Descripcion, FechaAccion, 'CONSULTORA' as Origen, '' as Mensaje
	from 
		[dbo].[PedidoWebDetalleSeguimiento] pwdseg
		LEFT join ods.productocomercial pco with(nolock) ON pwdseg.Cuv = pco.cuv and @CampaniaID = pco.anocampania
		LEFT JOIN dbo.MatrizComercial MC WITH (NOLOCK) ON pco.CodigoProducto = MC.CodigoSAP
		LEFT JOIN dbo.OfertaProducto OP WITH (NOLOCK) ON OP.CampaniaID = pco.anocampania AND OP.CUV = pco.CUV
		LEFT JOIN dbo.ProductoDescripcion PD WITH (NOLOCK) ON pco.anocampania = PD.CampaniaID AND pco.CUV = PD.CUV
	where
		pwdseg.ConsultoraID = @consultoraId and 
		pwdseg.CampaniaID = @CampaniaID

END
GO

IF OBJECT_ID('GetReporteCuvResumido', 'P') IS NOT NULL 
  DROP PROCEDURE GetReporteCuvResumido
  GO

CREATE PROC GetReporteCuvResumido
(
	@CampaniaID INT = 0,
	@Cuv VARCHAR(10) = ''
)
AS
BEGIN
	select
		
		pco.Cuv
		, pco.CodigoProducto as SAP
		, COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, est.DescripcionCUV2, pco.Descripcion) AS DescripcionProd
		, isnull(tes.DescripcionEstrategia,'') as Palanca
		, isnull(est.imagenURL,'') as imagenURL
		, case isnull(est.activo,'1') when 1 then 'SI' else 'NO' end as Activo
		, case isnull(pco.IndicadorDigitable,'0') when 1 then 'NO' else 'SI' end as PuedeDigitarse
		, isnull(est.Precio2,pco.PrecioCatalogo) as PrecioSet
	from 
		ods.productocomercial pco with(nolock)
		LEFT JOIN dbo.MatrizComercial MC WITH (NOLOCK) ON pco.CodigoProducto = MC.CodigoSAP
		LEFT JOIN dbo.OfertaProducto OP WITH (NOLOCK) ON OP.CampaniaID = pco.anocampania AND OP.CUV = pco.CUV
		LEFT JOIN dbo.ProductoDescripcion PD WITH (NOLOCK) ON pco.anocampania = PD.CampaniaID AND pco.CUV = PD.CUV
		LEFT JOIN estrategia est with(nolock) on pco.cuv = est.cuv2 and pco.anocampania = est.campaniaid
		LEFT JOIN tipoestrategia tes with(nolock) on est.tipoestrategiaid = tes.tipoestrategiaid
	where
		pco.cuv = @Cuv and 
		pco.anocampania = @CampaniaID
END
GO


USE [BelcorpMexico]
GO

IF OBJECT_ID('GetReporteCuvDetallado', 'P') IS NOT NULL 
  DROP PROCEDURE GetReporteCuvDetallado
  GO

CREATE PROC GetReporteCuvDetallado
(
	@CampaniaID INT = 0,
	@Cuv VARCHAR(10) = ''
)
AS
BEGIN
	select
		test.DescripcionEstrategia,
		estp.cuv2 as CuvPadre,
		estp.cuv as CuvHijo,
		estp.CodigoEstrategia,
		estp.Grupo,
		estp.SAP,
		mare.Nombre as MarcaEstrategia,
		marpc.Nombre as MarcaMatriz,
		estp.FactorCuadre,
		pco.PrecioUnitario,
		pco.IndicadorPreUni as PrecioPublico,
		estp.Digitable,
		estp.NombreProducto,
		estp.ImagenProducto AS ImagenTipos,
		estp.ImagenBulk AS ImagenTonos,
		estp.NombreBulk,
		pco.FactorRepeticion,
		estp.IdMarca as CodigoMarca
	from 
		estrategiaproducto estp with(nolock)
		INNER JOIN estrategia est with(nolock) on estp.estrategiaid = est.estrategiaid
		INNER JOIN tipoestrategia test with(nolock) on est.tipoestrategiaid = test.tipoestrategiaid
		INNER JOIN ods.productocomercial pco WITH (NOLOCK) ON estp.cuv = pco.cuv and estp.campania = pco.anocampania
		LEFT JOIN ods.marca mare WITH(NOLOCK) ON estp.IdMarca = mare.MarcaId
		LEFT JOIN ods.marca marpc WITH(NOLOCK) ON pco.MarcaID = marpc.MarcaId
		
	where
		(estp.cuv2 = @Cuv OR estp.cuv = @cuv) and
		estp.campania = @CampaniaID
	order by estp.EstrategiaID,estp.cuv2, estp.Grupo
		
END
GO

IF OBJECT_ID('GetReporteEstrategiasPorConsultora', 'P') IS NOT NULL 
  DROP PROCEDURE GetReporteEstrategiasPorConsultora
  GO

CREATE PROC GetReporteEstrategiasPorConsultora
(
	@CampaniaID INT = 0,
	@CodigoConsultora VARCHAR(30) = '',
	@Palanca VARCHAR(3) = '',
	@FechaConsulta DATE
)
AS
BEGIN

	DECLARE @Activa INT = (SELECT TOP 1 1 FROM RevistaDigitalSuscripcion WHERE codigoConsultora = @CodigoConsultora AND CampaniaEfectiva = @CampaniaID AND EstadoRegistro = 1)
	DECLARE @ActivoMDO INT = (SELECT Estado FROM ConfiguracionPaisdatos where codigo='ActivoMDO')

	IF @Palanca = '4'
	BEGIN
		SET @Palanca = '10'
		IF @ActivoMDO <> 1 AND @Activa <> 1
		BEGIN
			SET @Palanca = '4'
		END

	END


	IF @Palanca = '4'--OPT
	BEGIN

		declare @tmpOpt TABLE (
			EstrategiaID VARCHAR(150)				,CUV2 VARCHAR(150)			,DescripcionCUV2 VARCHAR(300)		,EtiquetaDescripcion VARCHAR(150)	,Precio VARCHAR(150),
			EtiquetaDescripcion2 VARCHAR(150)		,Precio2 VARCHAR(150)		,TextoLibre VARCHAR(150)			,FlagEstrella VARCHAR(150)			,ColorFondo VARCHAR(150),
			TipoEstrategiaID VARCHAR(150)			,FotoProducto01 VARCHAR(150),ImagenURL VARCHAR(150)				,LimiteVenta VARCHAR(150)			,MarcaID VARCHAR(150),
			Orden1 VARCHAR(150)						,Orden2 VARCHAR(150)		,IndicadorMontoMinimo VARCHAR(150)	,FlagNueva VARCHAR(150)				,TipoTallaColor VARCHAR(150),
			TipoEstrategiaImagenMostrar VARCHAR(150),CodigoProducto VARCHAR(150),EtiquetaID VARCHAR(150)			,EtiquetaID2 VARCHAR(150)			,CodigoEstrategia VARCHAR(150),
			TieneVariedad VARCHAR(150)				,CODIGO VARCHAR(150)		,DescripcionEstrategia VARCHAR(150)	,FlagMostrarImg VARCHAR(150)		,DescripcionMarca VARCHAR(150),
			DescripcionCategoria VARCHAR(150)		,PrecioPublico VARCHAR(150)	,Ganancia VARCHAR(150))
		
		insert into @tmpOpt exec ListarEstrategiasOPT @CampaniaID,@CodigoConsultora
		select CUV2 as CUV, DescripcionCUV2 as Descripcion from @tmpOpt

	END
	ELSE IF @Palanca = '10' --RD
	BEGIN

		DECLARE @EstrategiaCodigoOPM varchar(100) = '007'
		DECLARE @EstrategiaCodigoPAD varchar(100) = '008'
		DECLARE @TipoPersonalizacionCodigoOpm varchar(3) = 'OPM'
		DECLARE @TipoPersonalizacionCodigoPad varchar(3) = 'PAD'
		DECLARE @TipoPersonalizacionCodigoOpmPad varchar(3) = 'OPM;PAD'

		DECLARE @tablaCuvFaltante TABLE(CUV VARCHAR(6))
		INSERT INTO @tablaCuvFaltante(CUV)
		SELECT CUV FROM [dbo].[ObtenerCuvFaltante](@CampaniaID,@CodigoConsultora)

		DECLARE @CodConsultoraDefault VARCHAR(9) = ''
		SELECT @CodConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001

		DECLARE @CodConsultoraForzada VARCHAR(9) = ''
		SELECT @CodConsultoraForzada = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10002

		DECLARE  @OfertasPersonalizadas TABLE (Orden INT, CUV CHAR(6), TipoPersonalizacion CHAR(3), FlagRevista INT, AnioCampanaVenta INT, TipoEstrategiaId INT)

		INSERT INTO @OfertasPersonalizadas EXEC ListarOfertasPersonalizadas @CampaniaID,@TipoPersonalizacionCodigoOpmPad,@CodigoConsultora

		IF NOT EXISTS (SELECT TOP 1 CUV FROM @OfertasPersonalizadas)
		BEGIN
			INSERT INTO @OfertasPersonalizadas
			EXEC ListarOfertasPersonalizadas @CampaniaID,@TipoPersonalizacionCodigoOpmPad,@codConsultoraDefault
		END

		INSERT INTO @OfertasPersonalizadas EXEC ListarOfertasPersonalizadas @CampaniaID,@TipoPersonalizacionCodigoPad,@codConsultoraForzada
		INSERT INTO @OfertasPersonalizadas EXEC ListarOfertasPersonalizadas @CampaniaID,@TipoPersonalizacionCodigoOpm,@codConsultoraForzada

		SELECT
			E.CUV2 as CUV,
			E.DescripcionCUV2 as Descripcion
		FROM  dbo.Estrategia E with(nolock)
			INNER JOIN @OfertasPersonalizadas op ON E.CampaniaID = op.AnioCampanaVenta AND E.CUV2 = op.CUV AND OP.TipoEstrategiaId = E.TipoEstrategiaId
			INNER JOIN dbo.TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID AND TE.Codigo in (@EstrategiaCodigoOPM, @EstrategiaCodigoPAD)
			LEFT JOIN @tablaCuvFaltante TF ON E.CUV2 = TF.CUV
		WHERE
			E.Activo = 1 AND TE.FlagActivo = 1 AND TE.flagRecoPerfil = 1 AND TF.CUV IS NULL
		ORDER BY OP.Orden ASC, E.EstrategiaID ASC

	END
	ELSE IF @Palanca = '7' --ODD
	BEGIN

		DECLARE @fechaInicioFact DATE
		DECLARE @ZonaId INT
		DECLARE @num INT

		SET @ZonaId = (select ZonaId from ods.consultora where codigo = @CodigoConsultora)
		SET @fechaInicioFact = 
			(SELECT C.FechaInicioFacturacion 
			FROM ods.Cronograma C  
			INNER JOIN ods.Campania Ca ON C.CampaniaID = Ca.CampaniaID
			INNER JOIN [ods].[Zona] z (nolock) ON C.RegionID = z.RegionID AND c.ZonaID = z.ZonaID	
			WHERE Ca.Codigo = @CampaniaID AND Z.ZonaID = CASE WHEN @ZonaID = -1 THEN Z.ZonaID ELSE @ZonaID END)

		SET @num = (DATEDIFF(dd, @FechaConsulta, GETDATE()))
		SET @fechaInicioFact = (DATEADD(dd, @num, @fechaInicioFact))

		declare @tmpODD TABLE (
			EstrategiaID VARCHAR(150)				,CUV2 VARCHAR(150)				,DescripcionCUV2 VARCHAR(300)				,EtiquetaDescripcion VARCHAR(150)	,Precio VARCHAR(150),
			EtiquetaDescripcion2 VARCHAR(150)		,Precio2 VARCHAR(150)			,TextoLibre VARCHAR(150)					,CodigoEstrategia VARCHAR(150)		,FlagEstrella VARCHAR(150),
			ColorFondo VARCHAR(150)					,TipoEstrategiaID VARCHAR(150)	,FotoProducto01 VARCHAR(150)				,ImagenURL VARCHAR(150)				,LimiteVenta VARCHAR(150),
			MarcaID VARCHAR(150)					,Orden1 VARCHAR(150)			,Orden2 VARCHAR(150)						,IndicadorMontoMinimo VARCHAR(150)	,CodigoProducto VARCHAR(150),
			FlagNueva VARCHAR(150)					,TipoTallaColor VARCHAR(150)	,TipoEstrategiaImagenMostrar VARCHAR(150)	,EtiquetaID VARCHAR(150)			,EtiquetaID2 VARCHAR(150),
			CodigoEstrategia2 VARCHAR(150)			,TieneVariedad VARCHAR(150)		,CODIGO VARCHAR(150)						,DescripcionEstrategia VARCHAR(150)	,FlagMostrarImg VARCHAR(150),
			PrecioPublico VARCHAR(150)				,Ganancia VARCHAR(150)			,DescripcionMarca VARCHAR(150)				,FlagRevista VARCHAR(150)			,ImagenMiniaturaURL VARCHAR(150),
			DiaInicio VARCHAR(150))	

		insert into @tmpODD exec ListarEstrategiasODD2 @CampaniaID,@CodigoConsultora,@fechaInicioFact
		select CUV2 as CUV, DescripcionCUV2 as Descripcion from @tmpODD

	END
	ELSE IF @Palanca = '30' --SR
	BEGIN

		declare @tmpSR TABLE (
			EstrategiaID VARCHAR(150)				,CUV2 VARCHAR(150)							,DescripcionCUV2 VARCHAR(300)				,EtiquetaDescripcion VARCHAR(150)	,Precio VARCHAR(150),
			EtiquetaDescripcion2 VARCHAR(150)		,Precio2 VARCHAR(150)						,TextoLibre VARCHAR(150)					,FlagEstrella VARCHAR(150)			,ColorFondo VARCHAR(150),
			TipoEstrategiaID VARCHAR(150)			,FotoProducto01 VARCHAR(150)				,ImagenURL VARCHAR(150)						,LimiteVenta VARCHAR(150)			,MarcaID VARCHAR(150),
			Orden1 VARCHAR(150)						,Orden2 VARCHAR(150)						,IndicadorMontoMinimo VARCHAR(150)			,CodigoProducto VARCHAR(150)		,FlagNueva VARCHAR(150),
			TipoTallaColor VARCHAR(150)				,TipoEstrategiaImagenMostrar VARCHAR(150)	,EtiquetaID VARCHAR(150)					,EtiquetaID2 VARCHAR(150)			,CodigoEstrategia VARCHAR(150),
			TieneVariedad VARCHAR(150)				,CODIGO VARCHAR(150)						,DescripcionEstrategia VARCHAR(150)			,FlagMostrarImg VARCHAR(150)		,PrecioPublico VARCHAR(150),
			Ganancia VARCHAR(150)					,DescripcionMarca VARCHAR(150)				,FlagRevista VARCHAR(150)					,ImagenMiniaturaURL VARCHAR(150)	,EsSubCampania VARCHAR(150))

		insert into @tmpSR exec ListarEstrategiasShowRoom @CampaniaID,@CodigoConsultora
		select CUV2 as CUV, DescripcionCUV2 as Descripcion from @tmpSR

	END
	ELSE IF @Palanca = '9' --LAN
	BEGIN

		declare @tmpLAN TABLE (
			EstrategiaID VARCHAR(150)				,CUV2 VARCHAR(150)							,DescripcionCUV2 VARCHAR(300)				,EtiquetaDescripcion VARCHAR(150)	,Precio VARCHAR(150),
			EtiquetaDescripcion2 VARCHAR(150)		,Precio2 VARCHAR(150)						,TextoLibre VARCHAR(150)					,FlagEstrella VARCHAR(150)			,ColorFondo VARCHAR(150),
			TipoEstrategiaID VARCHAR(150)			,FotoProducto01 VARCHAR(150)				,ImagenURL VARCHAR(150)						,LimiteVenta VARCHAR(150)			,MarcaID VARCHAR(150),
			Orden1 VARCHAR(150)						,Orden2 VARCHAR(150)						,IndicadorMontoMinimo VARCHAR(150)			,FlagNueva VARCHAR(150)				,TipoTallaColor VARCHAR(150),
			TipoEstrategiaImagenMostrar VARCHAR(150),CodigoProducto VARCHAR(150)				,EtiquetaID VARCHAR(150)					,EtiquetaID2 VARCHAR(150)			,CodigoEstrategia VARCHAR(150),
			TieneVariedad VARCHAR(150)				,CODIGO VARCHAR(150)						,DescripcionEstrategia VARCHAR(150)			,FlagMostrarImg VARCHAR(150)		,DescripcionMarca VARCHAR(150),
			DescripcionCategoria VARCHAR(150)		,FlagIndividual VARCHAR(150)				,Slogan VARCHAR(150)						,ImgFondoDesktop VARCHAR(150)		,ImgFichaDesktop VARCHAR(150),
			UrlVideoDesktop VARCHAR(150)			,ImgFichaFondoDesktop VARCHAR(150)			,ImgFondoMobile VARCHAR(150)				,ImgSelloProductoMobile VARCHAR(150),UrlVideoMobile VARCHAR(150),
			ImgFichaFondoMobile VARCHAR(150)		,ImgHomeDesktop VARCHAR(150)				,ImgHomeMobile VARCHAR(150)					,PrecioPublico VARCHAR(150)			,Ganancia VARCHAR(150))

		insert into @tmpLAN exec ListarEstrategiasLanzamiento @CampaniaID,@CodigoConsultora
		select CUV2 as CUV, DescripcionCUV2 as Descripcion from @tmpLAN

	END
	ELSE IF @Palanca = '12' --GND 
	BEGIN

		declare @tmpGND TABLE (
			EstrategiaID VARCHAR(150)				,CUV2 VARCHAR(150)							,DescripcionCUV2 VARCHAR(300)				,EtiquetaDescripcion VARCHAR(150)	,Precio VARCHAR(150),
			EtiquetaDescripcion2 VARCHAR(150)		,Precio2 VARCHAR(150)						,TextoLibre VARCHAR(150)					,FlagEstrella VARCHAR(150)			,ColorFondo VARCHAR(150),
			TipoEstrategiaID VARCHAR(150)			,FotoProducto01 VARCHAR(150)				,ImagenURL VARCHAR(150)						,LimiteVenta VARCHAR(150)			,MarcaID VARCHAR(150),
			Orden1 VARCHAR(150)						,Orden2 VARCHAR(150)						,IndicadorMontoMinimo VARCHAR(150)			,CodigoProducto VARCHAR(150)		,FlagNueva VARCHAR(150),
			TipoTallaColor VARCHAR(150)				,TipoEstrategiaImagenMostrar VARCHAR(150)	,EtiquetaID VARCHAR(150)					,EtiquetaID2 VARCHAR(150)			,CodigoEstrategia VARCHAR(150),
			TieneVariedad VARCHAR(150)				,CODIGO VARCHAR(150)						,DescripcionEstrategia VARCHAR(150)			,FlagMostrarImg VARCHAR(150)		,PrecioPublico VARCHAR(150),
			Ganancia VARCHAR(150)					,DescripcionMarca VARCHAR(150)				,FlagRevista VARCHAR(150))

		insert into @tmpGND exec ListarEstrategiasGuiaDeNegocioDigitalizada @CampaniaID,@CodigoConsultora
		select CUV2 as CUV, DescripcionCUV2 as Descripcion from @tmpGND

	END
END
GO

IF OBJECT_ID('GetReporteMovimientosPedido', 'P') IS NOT NULL 
  DROP PROCEDURE GetReporteMovimientosPedido
  GO

CREATE PROC GetReporteMovimientosPedido
(
	@CampaniaID INT = 0,
	@CodigoConsultora VARCHAR(30) = ''
)
AS
BEGIN

	DECLARE @consultoraId INT
	DECLARE @tipoAccionEliminacionProl INT

	SET @tipoAccionEliminacionProl = 201
	SET @consultoraId = (select consultoraid from ods.consultora where codigo = @CodigoConsultora)

	select
		pwaprol.Cuv, COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, pco.Descripcion) AS Descripcion, FechaAccion, 'PROL' as Origen, MensajeProl as Mensaje
	from 
		[dbo].[PedidoWebAccionesPROL] pwaprol
		LEFT join ods.productocomercial pco with(nolock) ON pwaprol.Cuv = pco.cuv and @CampaniaID = pco.anocampania
		LEFT JOIN dbo.MatrizComercial MC WITH (NOLOCK) ON pco.CodigoProducto = MC.CodigoSAP
		LEFT JOIN dbo.OfertaProducto OP WITH (NOLOCK) ON OP.CampaniaID = pco.anocampania AND OP.CUV = pco.CUV
		LEFT JOIN dbo.ProductoDescripcion PD WITH (NOLOCK) ON pco.anocampania = PD.CampaniaID AND pco.CUV = PD.CUV
	where
		pwaprol.ConsultoraID = @consultoraId and 
		pwaprol.CampaniaID = @CampaniaID and
		pwaprol.Accion = @tipoAccionEliminacionProl

	UNION

	select
		pwdseg.Cuv, COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, pco.Descripcion) AS Descripcion, FechaAccion, 'CONSULTORA' as Origen, '' as Mensaje
	from 
		[dbo].[PedidoWebDetalleSeguimiento] pwdseg
		LEFT join ods.productocomercial pco with(nolock) ON pwdseg.Cuv = pco.cuv and @CampaniaID = pco.anocampania
		LEFT JOIN dbo.MatrizComercial MC WITH (NOLOCK) ON pco.CodigoProducto = MC.CodigoSAP
		LEFT JOIN dbo.OfertaProducto OP WITH (NOLOCK) ON OP.CampaniaID = pco.anocampania AND OP.CUV = pco.CUV
		LEFT JOIN dbo.ProductoDescripcion PD WITH (NOLOCK) ON pco.anocampania = PD.CampaniaID AND pco.CUV = PD.CUV
	where
		pwdseg.ConsultoraID = @consultoraId and 
		pwdseg.CampaniaID = @CampaniaID

END
GO

IF OBJECT_ID('GetReporteCuvResumido', 'P') IS NOT NULL 
  DROP PROCEDURE GetReporteCuvResumido
  GO

CREATE PROC GetReporteCuvResumido
(
	@CampaniaID INT = 0,
	@Cuv VARCHAR(10) = ''
)
AS
BEGIN
	select
		
		pco.Cuv
		, pco.CodigoProducto as SAP
		, COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, est.DescripcionCUV2, pco.Descripcion) AS DescripcionProd
		, isnull(tes.DescripcionEstrategia,'') as Palanca
		, isnull(est.imagenURL,'') as imagenURL
		, case isnull(est.activo,'1') when 1 then 'SI' else 'NO' end as Activo
		, case isnull(pco.IndicadorDigitable,'0') when 1 then 'NO' else 'SI' end as PuedeDigitarse
		, isnull(est.Precio2,pco.PrecioCatalogo) as PrecioSet
	from 
		ods.productocomercial pco with(nolock)
		LEFT JOIN dbo.MatrizComercial MC WITH (NOLOCK) ON pco.CodigoProducto = MC.CodigoSAP
		LEFT JOIN dbo.OfertaProducto OP WITH (NOLOCK) ON OP.CampaniaID = pco.anocampania AND OP.CUV = pco.CUV
		LEFT JOIN dbo.ProductoDescripcion PD WITH (NOLOCK) ON pco.anocampania = PD.CampaniaID AND pco.CUV = PD.CUV
		LEFT JOIN estrategia est with(nolock) on pco.cuv = est.cuv2 and pco.anocampania = est.campaniaid
		LEFT JOIN tipoestrategia tes with(nolock) on est.tipoestrategiaid = tes.tipoestrategiaid
	where
		pco.cuv = @Cuv and 
		pco.anocampania = @CampaniaID
END
GO


USE [BelcorpPanama]
GO

IF OBJECT_ID('GetReporteCuvDetallado', 'P') IS NOT NULL 
  DROP PROCEDURE GetReporteCuvDetallado
  GO

CREATE PROC GetReporteCuvDetallado
(
	@CampaniaID INT = 0,
	@Cuv VARCHAR(10) = ''
)
AS
BEGIN
	select
		test.DescripcionEstrategia,
		estp.cuv2 as CuvPadre,
		estp.cuv as CuvHijo,
		estp.CodigoEstrategia,
		estp.Grupo,
		estp.SAP,
		mare.Nombre as MarcaEstrategia,
		marpc.Nombre as MarcaMatriz,
		estp.FactorCuadre,
		pco.PrecioUnitario,
		pco.IndicadorPreUni as PrecioPublico,
		estp.Digitable,
		estp.NombreProducto,
		estp.ImagenProducto AS ImagenTipos,
		estp.ImagenBulk AS ImagenTonos,
		estp.NombreBulk,
		pco.FactorRepeticion,
		estp.IdMarca as CodigoMarca
	from 
		estrategiaproducto estp with(nolock)
		INNER JOIN estrategia est with(nolock) on estp.estrategiaid = est.estrategiaid
		INNER JOIN tipoestrategia test with(nolock) on est.tipoestrategiaid = test.tipoestrategiaid
		INNER JOIN ods.productocomercial pco WITH (NOLOCK) ON estp.cuv = pco.cuv and estp.campania = pco.anocampania
		LEFT JOIN ods.marca mare WITH(NOLOCK) ON estp.IdMarca = mare.MarcaId
		LEFT JOIN ods.marca marpc WITH(NOLOCK) ON pco.MarcaID = marpc.MarcaId
		
	where
		(estp.cuv2 = @Cuv OR estp.cuv = @cuv) and
		estp.campania = @CampaniaID
	order by estp.EstrategiaID,estp.cuv2, estp.Grupo
		
END
GO

IF OBJECT_ID('GetReporteEstrategiasPorConsultora', 'P') IS NOT NULL 
  DROP PROCEDURE GetReporteEstrategiasPorConsultora
  GO

CREATE PROC GetReporteEstrategiasPorConsultora
(
	@CampaniaID INT = 0,
	@CodigoConsultora VARCHAR(30) = '',
	@Palanca VARCHAR(3) = '',
	@FechaConsulta DATE
)
AS
BEGIN

	DECLARE @Activa INT = (SELECT TOP 1 1 FROM RevistaDigitalSuscripcion WHERE codigoConsultora = @CodigoConsultora AND CampaniaEfectiva = @CampaniaID AND EstadoRegistro = 1)
	DECLARE @ActivoMDO INT = (SELECT Estado FROM ConfiguracionPaisdatos where codigo='ActivoMDO')

	IF @Palanca = '4'
	BEGIN
		SET @Palanca = '10'
		IF @ActivoMDO <> 1 AND @Activa <> 1
		BEGIN
			SET @Palanca = '4'
		END

	END


	IF @Palanca = '4'--OPT
	BEGIN

		declare @tmpOpt TABLE (
			EstrategiaID VARCHAR(150)				,CUV2 VARCHAR(150)			,DescripcionCUV2 VARCHAR(300)		,EtiquetaDescripcion VARCHAR(150)	,Precio VARCHAR(150),
			EtiquetaDescripcion2 VARCHAR(150)		,Precio2 VARCHAR(150)		,TextoLibre VARCHAR(150)			,FlagEstrella VARCHAR(150)			,ColorFondo VARCHAR(150),
			TipoEstrategiaID VARCHAR(150)			,FotoProducto01 VARCHAR(150),ImagenURL VARCHAR(150)				,LimiteVenta VARCHAR(150)			,MarcaID VARCHAR(150),
			Orden1 VARCHAR(150)						,Orden2 VARCHAR(150)		,IndicadorMontoMinimo VARCHAR(150)	,FlagNueva VARCHAR(150)				,TipoTallaColor VARCHAR(150),
			TipoEstrategiaImagenMostrar VARCHAR(150),CodigoProducto VARCHAR(150),EtiquetaID VARCHAR(150)			,EtiquetaID2 VARCHAR(150)			,CodigoEstrategia VARCHAR(150),
			TieneVariedad VARCHAR(150)				,CODIGO VARCHAR(150)		,DescripcionEstrategia VARCHAR(150)	,FlagMostrarImg VARCHAR(150)		,DescripcionMarca VARCHAR(150),
			DescripcionCategoria VARCHAR(150)		,PrecioPublico VARCHAR(150)	,Ganancia VARCHAR(150))
		
		insert into @tmpOpt exec ListarEstrategiasOPT @CampaniaID,@CodigoConsultora
		select CUV2 as CUV, DescripcionCUV2 as Descripcion from @tmpOpt

	END
	ELSE IF @Palanca = '10' --RD
	BEGIN

		DECLARE @EstrategiaCodigoOPM varchar(100) = '007'
		DECLARE @EstrategiaCodigoPAD varchar(100) = '008'
		DECLARE @TipoPersonalizacionCodigoOpm varchar(3) = 'OPM'
		DECLARE @TipoPersonalizacionCodigoPad varchar(3) = 'PAD'
		DECLARE @TipoPersonalizacionCodigoOpmPad varchar(3) = 'OPM;PAD'

		DECLARE @tablaCuvFaltante TABLE(CUV VARCHAR(6))
		INSERT INTO @tablaCuvFaltante(CUV)
		SELECT CUV FROM [dbo].[ObtenerCuvFaltante](@CampaniaID,@CodigoConsultora)

		DECLARE @CodConsultoraDefault VARCHAR(9) = ''
		SELECT @CodConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001

		DECLARE @CodConsultoraForzada VARCHAR(9) = ''
		SELECT @CodConsultoraForzada = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10002

		DECLARE  @OfertasPersonalizadas TABLE (Orden INT, CUV CHAR(6), TipoPersonalizacion CHAR(3), FlagRevista INT, AnioCampanaVenta INT, TipoEstrategiaId INT)

		INSERT INTO @OfertasPersonalizadas EXEC ListarOfertasPersonalizadas @CampaniaID,@TipoPersonalizacionCodigoOpmPad,@CodigoConsultora

		IF NOT EXISTS (SELECT TOP 1 CUV FROM @OfertasPersonalizadas)
		BEGIN
			INSERT INTO @OfertasPersonalizadas
			EXEC ListarOfertasPersonalizadas @CampaniaID,@TipoPersonalizacionCodigoOpmPad,@codConsultoraDefault
		END

		INSERT INTO @OfertasPersonalizadas EXEC ListarOfertasPersonalizadas @CampaniaID,@TipoPersonalizacionCodigoPad,@codConsultoraForzada
		INSERT INTO @OfertasPersonalizadas EXEC ListarOfertasPersonalizadas @CampaniaID,@TipoPersonalizacionCodigoOpm,@codConsultoraForzada

		SELECT
			E.CUV2 as CUV,
			E.DescripcionCUV2 as Descripcion
		FROM  dbo.Estrategia E with(nolock)
			INNER JOIN @OfertasPersonalizadas op ON E.CampaniaID = op.AnioCampanaVenta AND E.CUV2 = op.CUV AND OP.TipoEstrategiaId = E.TipoEstrategiaId
			INNER JOIN dbo.TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID AND TE.Codigo in (@EstrategiaCodigoOPM, @EstrategiaCodigoPAD)
			LEFT JOIN @tablaCuvFaltante TF ON E.CUV2 = TF.CUV
		WHERE
			E.Activo = 1 AND TE.FlagActivo = 1 AND TE.flagRecoPerfil = 1 AND TF.CUV IS NULL
		ORDER BY OP.Orden ASC, E.EstrategiaID ASC

	END
	ELSE IF @Palanca = '7' --ODD
	BEGIN

		DECLARE @fechaInicioFact DATE
		DECLARE @ZonaId INT
		DECLARE @num INT

		SET @ZonaId = (select ZonaId from ods.consultora where codigo = @CodigoConsultora)
		SET @fechaInicioFact = 
			(SELECT C.FechaInicioFacturacion 
			FROM ods.Cronograma C  
			INNER JOIN ods.Campania Ca ON C.CampaniaID = Ca.CampaniaID
			INNER JOIN [ods].[Zona] z (nolock) ON C.RegionID = z.RegionID AND c.ZonaID = z.ZonaID	
			WHERE Ca.Codigo = @CampaniaID AND Z.ZonaID = CASE WHEN @ZonaID = -1 THEN Z.ZonaID ELSE @ZonaID END)

		SET @num = (DATEDIFF(dd, @FechaConsulta, GETDATE()))
		SET @fechaInicioFact = (DATEADD(dd, @num, @fechaInicioFact))

		declare @tmpODD TABLE (
			EstrategiaID VARCHAR(150)				,CUV2 VARCHAR(150)				,DescripcionCUV2 VARCHAR(300)				,EtiquetaDescripcion VARCHAR(150)	,Precio VARCHAR(150),
			EtiquetaDescripcion2 VARCHAR(150)		,Precio2 VARCHAR(150)			,TextoLibre VARCHAR(150)					,CodigoEstrategia VARCHAR(150)		,FlagEstrella VARCHAR(150),
			ColorFondo VARCHAR(150)					,TipoEstrategiaID VARCHAR(150)	,FotoProducto01 VARCHAR(150)				,ImagenURL VARCHAR(150)				,LimiteVenta VARCHAR(150),
			MarcaID VARCHAR(150)					,Orden1 VARCHAR(150)			,Orden2 VARCHAR(150)						,IndicadorMontoMinimo VARCHAR(150)	,CodigoProducto VARCHAR(150),
			FlagNueva VARCHAR(150)					,TipoTallaColor VARCHAR(150)	,TipoEstrategiaImagenMostrar VARCHAR(150)	,EtiquetaID VARCHAR(150)			,EtiquetaID2 VARCHAR(150),
			CodigoEstrategia2 VARCHAR(150)			,TieneVariedad VARCHAR(150)		,CODIGO VARCHAR(150)						,DescripcionEstrategia VARCHAR(150)	,FlagMostrarImg VARCHAR(150),
			PrecioPublico VARCHAR(150)				,Ganancia VARCHAR(150)			,DescripcionMarca VARCHAR(150)				,FlagRevista VARCHAR(150)			,ImagenMiniaturaURL VARCHAR(150),
			DiaInicio VARCHAR(150))	

		insert into @tmpODD exec ListarEstrategiasODD2 @CampaniaID,@CodigoConsultora,@fechaInicioFact
		select CUV2 as CUV, DescripcionCUV2 as Descripcion from @tmpODD

	END
	ELSE IF @Palanca = '30' --SR
	BEGIN

		declare @tmpSR TABLE (
			EstrategiaID VARCHAR(150)				,CUV2 VARCHAR(150)							,DescripcionCUV2 VARCHAR(300)				,EtiquetaDescripcion VARCHAR(150)	,Precio VARCHAR(150),
			EtiquetaDescripcion2 VARCHAR(150)		,Precio2 VARCHAR(150)						,TextoLibre VARCHAR(150)					,FlagEstrella VARCHAR(150)			,ColorFondo VARCHAR(150),
			TipoEstrategiaID VARCHAR(150)			,FotoProducto01 VARCHAR(150)				,ImagenURL VARCHAR(150)						,LimiteVenta VARCHAR(150)			,MarcaID VARCHAR(150),
			Orden1 VARCHAR(150)						,Orden2 VARCHAR(150)						,IndicadorMontoMinimo VARCHAR(150)			,CodigoProducto VARCHAR(150)		,FlagNueva VARCHAR(150),
			TipoTallaColor VARCHAR(150)				,TipoEstrategiaImagenMostrar VARCHAR(150)	,EtiquetaID VARCHAR(150)					,EtiquetaID2 VARCHAR(150)			,CodigoEstrategia VARCHAR(150),
			TieneVariedad VARCHAR(150)				,CODIGO VARCHAR(150)						,DescripcionEstrategia VARCHAR(150)			,FlagMostrarImg VARCHAR(150)		,PrecioPublico VARCHAR(150),
			Ganancia VARCHAR(150)					,DescripcionMarca VARCHAR(150)				,FlagRevista VARCHAR(150)					,ImagenMiniaturaURL VARCHAR(150)	,EsSubCampania VARCHAR(150))

		insert into @tmpSR exec ListarEstrategiasShowRoom @CampaniaID,@CodigoConsultora
		select CUV2 as CUV, DescripcionCUV2 as Descripcion from @tmpSR

	END
	ELSE IF @Palanca = '9' --LAN
	BEGIN

		declare @tmpLAN TABLE (
			EstrategiaID VARCHAR(150)				,CUV2 VARCHAR(150)							,DescripcionCUV2 VARCHAR(300)				,EtiquetaDescripcion VARCHAR(150)	,Precio VARCHAR(150),
			EtiquetaDescripcion2 VARCHAR(150)		,Precio2 VARCHAR(150)						,TextoLibre VARCHAR(150)					,FlagEstrella VARCHAR(150)			,ColorFondo VARCHAR(150),
			TipoEstrategiaID VARCHAR(150)			,FotoProducto01 VARCHAR(150)				,ImagenURL VARCHAR(150)						,LimiteVenta VARCHAR(150)			,MarcaID VARCHAR(150),
			Orden1 VARCHAR(150)						,Orden2 VARCHAR(150)						,IndicadorMontoMinimo VARCHAR(150)			,FlagNueva VARCHAR(150)				,TipoTallaColor VARCHAR(150),
			TipoEstrategiaImagenMostrar VARCHAR(150),CodigoProducto VARCHAR(150)				,EtiquetaID VARCHAR(150)					,EtiquetaID2 VARCHAR(150)			,CodigoEstrategia VARCHAR(150),
			TieneVariedad VARCHAR(150)				,CODIGO VARCHAR(150)						,DescripcionEstrategia VARCHAR(150)			,FlagMostrarImg VARCHAR(150)		,DescripcionMarca VARCHAR(150),
			DescripcionCategoria VARCHAR(150)		,FlagIndividual VARCHAR(150)				,Slogan VARCHAR(150)						,ImgFondoDesktop VARCHAR(150)		,ImgFichaDesktop VARCHAR(150),
			UrlVideoDesktop VARCHAR(150)			,ImgFichaFondoDesktop VARCHAR(150)			,ImgFondoMobile VARCHAR(150)				,ImgSelloProductoMobile VARCHAR(150),UrlVideoMobile VARCHAR(150),
			ImgFichaFondoMobile VARCHAR(150)		,ImgHomeDesktop VARCHAR(150)				,ImgHomeMobile VARCHAR(150)					,PrecioPublico VARCHAR(150)			,Ganancia VARCHAR(150))

		insert into @tmpLAN exec ListarEstrategiasLanzamiento @CampaniaID,@CodigoConsultora
		select CUV2 as CUV, DescripcionCUV2 as Descripcion from @tmpLAN

	END
	ELSE IF @Palanca = '12' --GND 
	BEGIN

		declare @tmpGND TABLE (
			EstrategiaID VARCHAR(150)				,CUV2 VARCHAR(150)							,DescripcionCUV2 VARCHAR(300)				,EtiquetaDescripcion VARCHAR(150)	,Precio VARCHAR(150),
			EtiquetaDescripcion2 VARCHAR(150)		,Precio2 VARCHAR(150)						,TextoLibre VARCHAR(150)					,FlagEstrella VARCHAR(150)			,ColorFondo VARCHAR(150),
			TipoEstrategiaID VARCHAR(150)			,FotoProducto01 VARCHAR(150)				,ImagenURL VARCHAR(150)						,LimiteVenta VARCHAR(150)			,MarcaID VARCHAR(150),
			Orden1 VARCHAR(150)						,Orden2 VARCHAR(150)						,IndicadorMontoMinimo VARCHAR(150)			,CodigoProducto VARCHAR(150)		,FlagNueva VARCHAR(150),
			TipoTallaColor VARCHAR(150)				,TipoEstrategiaImagenMostrar VARCHAR(150)	,EtiquetaID VARCHAR(150)					,EtiquetaID2 VARCHAR(150)			,CodigoEstrategia VARCHAR(150),
			TieneVariedad VARCHAR(150)				,CODIGO VARCHAR(150)						,DescripcionEstrategia VARCHAR(150)			,FlagMostrarImg VARCHAR(150)		,PrecioPublico VARCHAR(150),
			Ganancia VARCHAR(150)					,DescripcionMarca VARCHAR(150)				,FlagRevista VARCHAR(150))

		insert into @tmpGND exec ListarEstrategiasGuiaDeNegocioDigitalizada @CampaniaID,@CodigoConsultora
		select CUV2 as CUV, DescripcionCUV2 as Descripcion from @tmpGND

	END
END
GO

IF OBJECT_ID('GetReporteMovimientosPedido', 'P') IS NOT NULL 
  DROP PROCEDURE GetReporteMovimientosPedido
  GO

CREATE PROC GetReporteMovimientosPedido
(
	@CampaniaID INT = 0,
	@CodigoConsultora VARCHAR(30) = ''
)
AS
BEGIN

	DECLARE @consultoraId INT
	DECLARE @tipoAccionEliminacionProl INT

	SET @tipoAccionEliminacionProl = 201
	SET @consultoraId = (select consultoraid from ods.consultora where codigo = @CodigoConsultora)

	select
		pwaprol.Cuv, COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, pco.Descripcion) AS Descripcion, FechaAccion, 'PROL' as Origen, MensajeProl as Mensaje
	from 
		[dbo].[PedidoWebAccionesPROL] pwaprol
		LEFT join ods.productocomercial pco with(nolock) ON pwaprol.Cuv = pco.cuv and @CampaniaID = pco.anocampania
		LEFT JOIN dbo.MatrizComercial MC WITH (NOLOCK) ON pco.CodigoProducto = MC.CodigoSAP
		LEFT JOIN dbo.OfertaProducto OP WITH (NOLOCK) ON OP.CampaniaID = pco.anocampania AND OP.CUV = pco.CUV
		LEFT JOIN dbo.ProductoDescripcion PD WITH (NOLOCK) ON pco.anocampania = PD.CampaniaID AND pco.CUV = PD.CUV
	where
		pwaprol.ConsultoraID = @consultoraId and 
		pwaprol.CampaniaID = @CampaniaID and
		pwaprol.Accion = @tipoAccionEliminacionProl

	UNION

	select
		pwdseg.Cuv, COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, pco.Descripcion) AS Descripcion, FechaAccion, 'CONSULTORA' as Origen, '' as Mensaje
	from 
		[dbo].[PedidoWebDetalleSeguimiento] pwdseg
		LEFT join ods.productocomercial pco with(nolock) ON pwdseg.Cuv = pco.cuv and @CampaniaID = pco.anocampania
		LEFT JOIN dbo.MatrizComercial MC WITH (NOLOCK) ON pco.CodigoProducto = MC.CodigoSAP
		LEFT JOIN dbo.OfertaProducto OP WITH (NOLOCK) ON OP.CampaniaID = pco.anocampania AND OP.CUV = pco.CUV
		LEFT JOIN dbo.ProductoDescripcion PD WITH (NOLOCK) ON pco.anocampania = PD.CampaniaID AND pco.CUV = PD.CUV
	where
		pwdseg.ConsultoraID = @consultoraId and 
		pwdseg.CampaniaID = @CampaniaID

END
GO

IF OBJECT_ID('GetReporteCuvResumido', 'P') IS NOT NULL 
  DROP PROCEDURE GetReporteCuvResumido
  GO

CREATE PROC GetReporteCuvResumido
(
	@CampaniaID INT = 0,
	@Cuv VARCHAR(10) = ''
)
AS
BEGIN
	select
		
		pco.Cuv
		, pco.CodigoProducto as SAP
		, COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, est.DescripcionCUV2, pco.Descripcion) AS DescripcionProd
		, isnull(tes.DescripcionEstrategia,'') as Palanca
		, isnull(est.imagenURL,'') as imagenURL
		, case isnull(est.activo,'1') when 1 then 'SI' else 'NO' end as Activo
		, case isnull(pco.IndicadorDigitable,'0') when 1 then 'NO' else 'SI' end as PuedeDigitarse
		, isnull(est.Precio2,pco.PrecioCatalogo) as PrecioSet
	from 
		ods.productocomercial pco with(nolock)
		LEFT JOIN dbo.MatrizComercial MC WITH (NOLOCK) ON pco.CodigoProducto = MC.CodigoSAP
		LEFT JOIN dbo.OfertaProducto OP WITH (NOLOCK) ON OP.CampaniaID = pco.anocampania AND OP.CUV = pco.CUV
		LEFT JOIN dbo.ProductoDescripcion PD WITH (NOLOCK) ON pco.anocampania = PD.CampaniaID AND pco.CUV = PD.CUV
		LEFT JOIN estrategia est with(nolock) on pco.cuv = est.cuv2 and pco.anocampania = est.campaniaid
		LEFT JOIN tipoestrategia tes with(nolock) on est.tipoestrategiaid = tes.tipoestrategiaid
	where
		pco.cuv = @Cuv and 
		pco.anocampania = @CampaniaID
END
GO


USE [BelcorpPuertoRico]
GO

IF OBJECT_ID('GetReporteCuvDetallado', 'P') IS NOT NULL 
  DROP PROCEDURE GetReporteCuvDetallado
  GO

CREATE PROC GetReporteCuvDetallado
(
	@CampaniaID INT = 0,
	@Cuv VARCHAR(10) = ''
)
AS
BEGIN
	select
		test.DescripcionEstrategia,
		estp.cuv2 as CuvPadre,
		estp.cuv as CuvHijo,
		estp.CodigoEstrategia,
		estp.Grupo,
		estp.SAP,
		mare.Nombre as MarcaEstrategia,
		marpc.Nombre as MarcaMatriz,
		estp.FactorCuadre,
		pco.PrecioUnitario,
		pco.IndicadorPreUni as PrecioPublico,
		estp.Digitable,
		estp.NombreProducto,
		estp.ImagenProducto AS ImagenTipos,
		estp.ImagenBulk AS ImagenTonos,
		estp.NombreBulk,
		pco.FactorRepeticion,
		estp.IdMarca as CodigoMarca
	from 
		estrategiaproducto estp with(nolock)
		INNER JOIN estrategia est with(nolock) on estp.estrategiaid = est.estrategiaid
		INNER JOIN tipoestrategia test with(nolock) on est.tipoestrategiaid = test.tipoestrategiaid
		INNER JOIN ods.productocomercial pco WITH (NOLOCK) ON estp.cuv = pco.cuv and estp.campania = pco.anocampania
		LEFT JOIN ods.marca mare WITH(NOLOCK) ON estp.IdMarca = mare.MarcaId
		LEFT JOIN ods.marca marpc WITH(NOLOCK) ON pco.MarcaID = marpc.MarcaId
		
	where
		(estp.cuv2 = @Cuv OR estp.cuv = @cuv) and
		estp.campania = @CampaniaID
	order by estp.EstrategiaID,estp.cuv2, estp.Grupo
		
END
GO

IF OBJECT_ID('GetReporteEstrategiasPorConsultora', 'P') IS NOT NULL 
  DROP PROCEDURE GetReporteEstrategiasPorConsultora
  GO

CREATE PROC GetReporteEstrategiasPorConsultora
(
	@CampaniaID INT = 0,
	@CodigoConsultora VARCHAR(30) = '',
	@Palanca VARCHAR(3) = '',
	@FechaConsulta DATE
)
AS
BEGIN

	DECLARE @Activa INT = (SELECT TOP 1 1 FROM RevistaDigitalSuscripcion WHERE codigoConsultora = @CodigoConsultora AND CampaniaEfectiva = @CampaniaID AND EstadoRegistro = 1)
	DECLARE @ActivoMDO INT = (SELECT Estado FROM ConfiguracionPaisdatos where codigo='ActivoMDO')

	IF @Palanca = '4'
	BEGIN
		SET @Palanca = '10'
		IF @ActivoMDO <> 1 AND @Activa <> 1
		BEGIN
			SET @Palanca = '4'
		END

	END


	IF @Palanca = '4'--OPT
	BEGIN

		declare @tmpOpt TABLE (
			EstrategiaID VARCHAR(150)				,CUV2 VARCHAR(150)			,DescripcionCUV2 VARCHAR(300)		,EtiquetaDescripcion VARCHAR(150)	,Precio VARCHAR(150),
			EtiquetaDescripcion2 VARCHAR(150)		,Precio2 VARCHAR(150)		,TextoLibre VARCHAR(150)			,FlagEstrella VARCHAR(150)			,ColorFondo VARCHAR(150),
			TipoEstrategiaID VARCHAR(150)			,FotoProducto01 VARCHAR(150),ImagenURL VARCHAR(150)				,LimiteVenta VARCHAR(150)			,MarcaID VARCHAR(150),
			Orden1 VARCHAR(150)						,Orden2 VARCHAR(150)		,IndicadorMontoMinimo VARCHAR(150)	,FlagNueva VARCHAR(150)				,TipoTallaColor VARCHAR(150),
			TipoEstrategiaImagenMostrar VARCHAR(150),CodigoProducto VARCHAR(150),EtiquetaID VARCHAR(150)			,EtiquetaID2 VARCHAR(150)			,CodigoEstrategia VARCHAR(150),
			TieneVariedad VARCHAR(150)				,CODIGO VARCHAR(150)		,DescripcionEstrategia VARCHAR(150)	,FlagMostrarImg VARCHAR(150)		,DescripcionMarca VARCHAR(150),
			DescripcionCategoria VARCHAR(150)		,PrecioPublico VARCHAR(150)	,Ganancia VARCHAR(150))
		
		insert into @tmpOpt exec ListarEstrategiasOPT @CampaniaID,@CodigoConsultora
		select CUV2 as CUV, DescripcionCUV2 as Descripcion from @tmpOpt

	END
	ELSE IF @Palanca = '10' --RD
	BEGIN

		DECLARE @EstrategiaCodigoOPM varchar(100) = '007'
		DECLARE @EstrategiaCodigoPAD varchar(100) = '008'
		DECLARE @TipoPersonalizacionCodigoOpm varchar(3) = 'OPM'
		DECLARE @TipoPersonalizacionCodigoPad varchar(3) = 'PAD'
		DECLARE @TipoPersonalizacionCodigoOpmPad varchar(3) = 'OPM;PAD'

		DECLARE @tablaCuvFaltante TABLE(CUV VARCHAR(6))
		INSERT INTO @tablaCuvFaltante(CUV)
		SELECT CUV FROM [dbo].[ObtenerCuvFaltante](@CampaniaID,@CodigoConsultora)

		DECLARE @CodConsultoraDefault VARCHAR(9) = ''
		SELECT @CodConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001

		DECLARE @CodConsultoraForzada VARCHAR(9) = ''
		SELECT @CodConsultoraForzada = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10002

		DECLARE  @OfertasPersonalizadas TABLE (Orden INT, CUV CHAR(6), TipoPersonalizacion CHAR(3), FlagRevista INT, AnioCampanaVenta INT, TipoEstrategiaId INT)

		INSERT INTO @OfertasPersonalizadas EXEC ListarOfertasPersonalizadas @CampaniaID,@TipoPersonalizacionCodigoOpmPad,@CodigoConsultora

		IF NOT EXISTS (SELECT TOP 1 CUV FROM @OfertasPersonalizadas)
		BEGIN
			INSERT INTO @OfertasPersonalizadas
			EXEC ListarOfertasPersonalizadas @CampaniaID,@TipoPersonalizacionCodigoOpmPad,@codConsultoraDefault
		END

		INSERT INTO @OfertasPersonalizadas EXEC ListarOfertasPersonalizadas @CampaniaID,@TipoPersonalizacionCodigoPad,@codConsultoraForzada
		INSERT INTO @OfertasPersonalizadas EXEC ListarOfertasPersonalizadas @CampaniaID,@TipoPersonalizacionCodigoOpm,@codConsultoraForzada

		SELECT
			E.CUV2 as CUV,
			E.DescripcionCUV2 as Descripcion
		FROM  dbo.Estrategia E with(nolock)
			INNER JOIN @OfertasPersonalizadas op ON E.CampaniaID = op.AnioCampanaVenta AND E.CUV2 = op.CUV AND OP.TipoEstrategiaId = E.TipoEstrategiaId
			INNER JOIN dbo.TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID AND TE.Codigo in (@EstrategiaCodigoOPM, @EstrategiaCodigoPAD)
			LEFT JOIN @tablaCuvFaltante TF ON E.CUV2 = TF.CUV
		WHERE
			E.Activo = 1 AND TE.FlagActivo = 1 AND TE.flagRecoPerfil = 1 AND TF.CUV IS NULL
		ORDER BY OP.Orden ASC, E.EstrategiaID ASC

	END
	ELSE IF @Palanca = '7' --ODD
	BEGIN

		DECLARE @fechaInicioFact DATE
		DECLARE @ZonaId INT
		DECLARE @num INT

		SET @ZonaId = (select ZonaId from ods.consultora where codigo = @CodigoConsultora)
		SET @fechaInicioFact = 
			(SELECT C.FechaInicioFacturacion 
			FROM ods.Cronograma C  
			INNER JOIN ods.Campania Ca ON C.CampaniaID = Ca.CampaniaID
			INNER JOIN [ods].[Zona] z (nolock) ON C.RegionID = z.RegionID AND c.ZonaID = z.ZonaID	
			WHERE Ca.Codigo = @CampaniaID AND Z.ZonaID = CASE WHEN @ZonaID = -1 THEN Z.ZonaID ELSE @ZonaID END)

		SET @num = (DATEDIFF(dd, @FechaConsulta, GETDATE()))
		SET @fechaInicioFact = (DATEADD(dd, @num, @fechaInicioFact))

		declare @tmpODD TABLE (
			EstrategiaID VARCHAR(150)				,CUV2 VARCHAR(150)				,DescripcionCUV2 VARCHAR(300)				,EtiquetaDescripcion VARCHAR(150)	,Precio VARCHAR(150),
			EtiquetaDescripcion2 VARCHAR(150)		,Precio2 VARCHAR(150)			,TextoLibre VARCHAR(150)					,CodigoEstrategia VARCHAR(150)		,FlagEstrella VARCHAR(150),
			ColorFondo VARCHAR(150)					,TipoEstrategiaID VARCHAR(150)	,FotoProducto01 VARCHAR(150)				,ImagenURL VARCHAR(150)				,LimiteVenta VARCHAR(150),
			MarcaID VARCHAR(150)					,Orden1 VARCHAR(150)			,Orden2 VARCHAR(150)						,IndicadorMontoMinimo VARCHAR(150)	,CodigoProducto VARCHAR(150),
			FlagNueva VARCHAR(150)					,TipoTallaColor VARCHAR(150)	,TipoEstrategiaImagenMostrar VARCHAR(150)	,EtiquetaID VARCHAR(150)			,EtiquetaID2 VARCHAR(150),
			CodigoEstrategia2 VARCHAR(150)			,TieneVariedad VARCHAR(150)		,CODIGO VARCHAR(150)						,DescripcionEstrategia VARCHAR(150)	,FlagMostrarImg VARCHAR(150),
			PrecioPublico VARCHAR(150)				,Ganancia VARCHAR(150)			,DescripcionMarca VARCHAR(150)				,FlagRevista VARCHAR(150)			,ImagenMiniaturaURL VARCHAR(150),
			DiaInicio VARCHAR(150))	

		insert into @tmpODD exec ListarEstrategiasODD2 @CampaniaID,@CodigoConsultora,@fechaInicioFact
		select CUV2 as CUV, DescripcionCUV2 as Descripcion from @tmpODD

	END
	ELSE IF @Palanca = '30' --SR
	BEGIN

		declare @tmpSR TABLE (
			EstrategiaID VARCHAR(150)				,CUV2 VARCHAR(150)							,DescripcionCUV2 VARCHAR(300)				,EtiquetaDescripcion VARCHAR(150)	,Precio VARCHAR(150),
			EtiquetaDescripcion2 VARCHAR(150)		,Precio2 VARCHAR(150)						,TextoLibre VARCHAR(150)					,FlagEstrella VARCHAR(150)			,ColorFondo VARCHAR(150),
			TipoEstrategiaID VARCHAR(150)			,FotoProducto01 VARCHAR(150)				,ImagenURL VARCHAR(150)						,LimiteVenta VARCHAR(150)			,MarcaID VARCHAR(150),
			Orden1 VARCHAR(150)						,Orden2 VARCHAR(150)						,IndicadorMontoMinimo VARCHAR(150)			,CodigoProducto VARCHAR(150)		,FlagNueva VARCHAR(150),
			TipoTallaColor VARCHAR(150)				,TipoEstrategiaImagenMostrar VARCHAR(150)	,EtiquetaID VARCHAR(150)					,EtiquetaID2 VARCHAR(150)			,CodigoEstrategia VARCHAR(150),
			TieneVariedad VARCHAR(150)				,CODIGO VARCHAR(150)						,DescripcionEstrategia VARCHAR(150)			,FlagMostrarImg VARCHAR(150)		,PrecioPublico VARCHAR(150),
			Ganancia VARCHAR(150)					,DescripcionMarca VARCHAR(150)				,FlagRevista VARCHAR(150)					,ImagenMiniaturaURL VARCHAR(150)	,EsSubCampania VARCHAR(150))

		insert into @tmpSR exec ListarEstrategiasShowRoom @CampaniaID,@CodigoConsultora
		select CUV2 as CUV, DescripcionCUV2 as Descripcion from @tmpSR

	END
	ELSE IF @Palanca = '9' --LAN
	BEGIN

		declare @tmpLAN TABLE (
			EstrategiaID VARCHAR(150)				,CUV2 VARCHAR(150)							,DescripcionCUV2 VARCHAR(300)				,EtiquetaDescripcion VARCHAR(150)	,Precio VARCHAR(150),
			EtiquetaDescripcion2 VARCHAR(150)		,Precio2 VARCHAR(150)						,TextoLibre VARCHAR(150)					,FlagEstrella VARCHAR(150)			,ColorFondo VARCHAR(150),
			TipoEstrategiaID VARCHAR(150)			,FotoProducto01 VARCHAR(150)				,ImagenURL VARCHAR(150)						,LimiteVenta VARCHAR(150)			,MarcaID VARCHAR(150),
			Orden1 VARCHAR(150)						,Orden2 VARCHAR(150)						,IndicadorMontoMinimo VARCHAR(150)			,FlagNueva VARCHAR(150)				,TipoTallaColor VARCHAR(150),
			TipoEstrategiaImagenMostrar VARCHAR(150),CodigoProducto VARCHAR(150)				,EtiquetaID VARCHAR(150)					,EtiquetaID2 VARCHAR(150)			,CodigoEstrategia VARCHAR(150),
			TieneVariedad VARCHAR(150)				,CODIGO VARCHAR(150)						,DescripcionEstrategia VARCHAR(150)			,FlagMostrarImg VARCHAR(150)		,DescripcionMarca VARCHAR(150),
			DescripcionCategoria VARCHAR(150)		,FlagIndividual VARCHAR(150)				,Slogan VARCHAR(150)						,ImgFondoDesktop VARCHAR(150)		,ImgFichaDesktop VARCHAR(150),
			UrlVideoDesktop VARCHAR(150)			,ImgFichaFondoDesktop VARCHAR(150)			,ImgFondoMobile VARCHAR(150)				,ImgSelloProductoMobile VARCHAR(150),UrlVideoMobile VARCHAR(150),
			ImgFichaFondoMobile VARCHAR(150)		,ImgHomeDesktop VARCHAR(150)				,ImgHomeMobile VARCHAR(150)					,PrecioPublico VARCHAR(150)			,Ganancia VARCHAR(150))

		insert into @tmpLAN exec ListarEstrategiasLanzamiento @CampaniaID,@CodigoConsultora
		select CUV2 as CUV, DescripcionCUV2 as Descripcion from @tmpLAN

	END
	ELSE IF @Palanca = '12' --GND 
	BEGIN

		declare @tmpGND TABLE (
			EstrategiaID VARCHAR(150)				,CUV2 VARCHAR(150)							,DescripcionCUV2 VARCHAR(300)				,EtiquetaDescripcion VARCHAR(150)	,Precio VARCHAR(150),
			EtiquetaDescripcion2 VARCHAR(150)		,Precio2 VARCHAR(150)						,TextoLibre VARCHAR(150)					,FlagEstrella VARCHAR(150)			,ColorFondo VARCHAR(150),
			TipoEstrategiaID VARCHAR(150)			,FotoProducto01 VARCHAR(150)				,ImagenURL VARCHAR(150)						,LimiteVenta VARCHAR(150)			,MarcaID VARCHAR(150),
			Orden1 VARCHAR(150)						,Orden2 VARCHAR(150)						,IndicadorMontoMinimo VARCHAR(150)			,CodigoProducto VARCHAR(150)		,FlagNueva VARCHAR(150),
			TipoTallaColor VARCHAR(150)				,TipoEstrategiaImagenMostrar VARCHAR(150)	,EtiquetaID VARCHAR(150)					,EtiquetaID2 VARCHAR(150)			,CodigoEstrategia VARCHAR(150),
			TieneVariedad VARCHAR(150)				,CODIGO VARCHAR(150)						,DescripcionEstrategia VARCHAR(150)			,FlagMostrarImg VARCHAR(150)		,PrecioPublico VARCHAR(150),
			Ganancia VARCHAR(150)					,DescripcionMarca VARCHAR(150)				,FlagRevista VARCHAR(150))

		insert into @tmpGND exec ListarEstrategiasGuiaDeNegocioDigitalizada @CampaniaID,@CodigoConsultora
		select CUV2 as CUV, DescripcionCUV2 as Descripcion from @tmpGND

	END
END
GO

IF OBJECT_ID('GetReporteMovimientosPedido', 'P') IS NOT NULL 
  DROP PROCEDURE GetReporteMovimientosPedido
  GO

CREATE PROC GetReporteMovimientosPedido
(
	@CampaniaID INT = 0,
	@CodigoConsultora VARCHAR(30) = ''
)
AS
BEGIN

	DECLARE @consultoraId INT
	DECLARE @tipoAccionEliminacionProl INT

	SET @tipoAccionEliminacionProl = 201
	SET @consultoraId = (select consultoraid from ods.consultora where codigo = @CodigoConsultora)

	select
		pwaprol.Cuv, COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, pco.Descripcion) AS Descripcion, FechaAccion, 'PROL' as Origen, MensajeProl as Mensaje
	from 
		[dbo].[PedidoWebAccionesPROL] pwaprol
		LEFT join ods.productocomercial pco with(nolock) ON pwaprol.Cuv = pco.cuv and @CampaniaID = pco.anocampania
		LEFT JOIN dbo.MatrizComercial MC WITH (NOLOCK) ON pco.CodigoProducto = MC.CodigoSAP
		LEFT JOIN dbo.OfertaProducto OP WITH (NOLOCK) ON OP.CampaniaID = pco.anocampania AND OP.CUV = pco.CUV
		LEFT JOIN dbo.ProductoDescripcion PD WITH (NOLOCK) ON pco.anocampania = PD.CampaniaID AND pco.CUV = PD.CUV
	where
		pwaprol.ConsultoraID = @consultoraId and 
		pwaprol.CampaniaID = @CampaniaID and
		pwaprol.Accion = @tipoAccionEliminacionProl

	UNION

	select
		pwdseg.Cuv, COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, pco.Descripcion) AS Descripcion, FechaAccion, 'CONSULTORA' as Origen, '' as Mensaje
	from 
		[dbo].[PedidoWebDetalleSeguimiento] pwdseg
		LEFT join ods.productocomercial pco with(nolock) ON pwdseg.Cuv = pco.cuv and @CampaniaID = pco.anocampania
		LEFT JOIN dbo.MatrizComercial MC WITH (NOLOCK) ON pco.CodigoProducto = MC.CodigoSAP
		LEFT JOIN dbo.OfertaProducto OP WITH (NOLOCK) ON OP.CampaniaID = pco.anocampania AND OP.CUV = pco.CUV
		LEFT JOIN dbo.ProductoDescripcion PD WITH (NOLOCK) ON pco.anocampania = PD.CampaniaID AND pco.CUV = PD.CUV
	where
		pwdseg.ConsultoraID = @consultoraId and 
		pwdseg.CampaniaID = @CampaniaID

END
GO

IF OBJECT_ID('GetReporteCuvResumido', 'P') IS NOT NULL 
  DROP PROCEDURE GetReporteCuvResumido
  GO

CREATE PROC GetReporteCuvResumido
(
	@CampaniaID INT = 0,
	@Cuv VARCHAR(10) = ''
)
AS
BEGIN
	select
		
		pco.Cuv
		, pco.CodigoProducto as SAP
		, COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, est.DescripcionCUV2, pco.Descripcion) AS DescripcionProd
		, isnull(tes.DescripcionEstrategia,'') as Palanca
		, isnull(est.imagenURL,'') as imagenURL
		, case isnull(est.activo,'1') when 1 then 'SI' else 'NO' end as Activo
		, case isnull(pco.IndicadorDigitable,'0') when 1 then 'NO' else 'SI' end as PuedeDigitarse
		, isnull(est.Precio2,pco.PrecioCatalogo) as PrecioSet
	from 
		ods.productocomercial pco with(nolock)
		LEFT JOIN dbo.MatrizComercial MC WITH (NOLOCK) ON pco.CodigoProducto = MC.CodigoSAP
		LEFT JOIN dbo.OfertaProducto OP WITH (NOLOCK) ON OP.CampaniaID = pco.anocampania AND OP.CUV = pco.CUV
		LEFT JOIN dbo.ProductoDescripcion PD WITH (NOLOCK) ON pco.anocampania = PD.CampaniaID AND pco.CUV = PD.CUV
		LEFT JOIN estrategia est with(nolock) on pco.cuv = est.cuv2 and pco.anocampania = est.campaniaid
		LEFT JOIN tipoestrategia tes with(nolock) on est.tipoestrategiaid = tes.tipoestrategiaid
	where
		pco.cuv = @Cuv and 
		pco.anocampania = @CampaniaID
END
GO


USE [BelcorpSalvador]
GO

IF OBJECT_ID('GetReporteCuvDetallado', 'P') IS NOT NULL 
  DROP PROCEDURE GetReporteCuvDetallado
  GO

CREATE PROC GetReporteCuvDetallado
(
	@CampaniaID INT = 0,
	@Cuv VARCHAR(10) = ''
)
AS
BEGIN
	select
		test.DescripcionEstrategia,
		estp.cuv2 as CuvPadre,
		estp.cuv as CuvHijo,
		estp.CodigoEstrategia,
		estp.Grupo,
		estp.SAP,
		mare.Nombre as MarcaEstrategia,
		marpc.Nombre as MarcaMatriz,
		estp.FactorCuadre,
		pco.PrecioUnitario,
		pco.IndicadorPreUni as PrecioPublico,
		estp.Digitable,
		estp.NombreProducto,
		estp.ImagenProducto AS ImagenTipos,
		estp.ImagenBulk AS ImagenTonos,
		estp.NombreBulk,
		pco.FactorRepeticion,
		estp.IdMarca as CodigoMarca
	from 
		estrategiaproducto estp with(nolock)
		INNER JOIN estrategia est with(nolock) on estp.estrategiaid = est.estrategiaid
		INNER JOIN tipoestrategia test with(nolock) on est.tipoestrategiaid = test.tipoestrategiaid
		INNER JOIN ods.productocomercial pco WITH (NOLOCK) ON estp.cuv = pco.cuv and estp.campania = pco.anocampania
		LEFT JOIN ods.marca mare WITH(NOLOCK) ON estp.IdMarca = mare.MarcaId
		LEFT JOIN ods.marca marpc WITH(NOLOCK) ON pco.MarcaID = marpc.MarcaId
		
	where
		(estp.cuv2 = @Cuv OR estp.cuv = @cuv) and
		estp.campania = @CampaniaID
	order by estp.EstrategiaID,estp.cuv2, estp.Grupo
		
END
GO

IF OBJECT_ID('GetReporteEstrategiasPorConsultora', 'P') IS NOT NULL 
  DROP PROCEDURE GetReporteEstrategiasPorConsultora
  GO

CREATE PROC GetReporteEstrategiasPorConsultora
(
	@CampaniaID INT = 0,
	@CodigoConsultora VARCHAR(30) = '',
	@Palanca VARCHAR(3) = '',
	@FechaConsulta DATE
)
AS
BEGIN

	DECLARE @Activa INT = (SELECT TOP 1 1 FROM RevistaDigitalSuscripcion WHERE codigoConsultora = @CodigoConsultora AND CampaniaEfectiva = @CampaniaID AND EstadoRegistro = 1)
	DECLARE @ActivoMDO INT = (SELECT Estado FROM ConfiguracionPaisdatos where codigo='ActivoMDO')

	IF @Palanca = '4'
	BEGIN
		SET @Palanca = '10'
		IF @ActivoMDO <> 1 AND @Activa <> 1
		BEGIN
			SET @Palanca = '4'
		END

	END


	IF @Palanca = '4'--OPT
	BEGIN

		declare @tmpOpt TABLE (
			EstrategiaID VARCHAR(150)				,CUV2 VARCHAR(150)			,DescripcionCUV2 VARCHAR(300)		,EtiquetaDescripcion VARCHAR(150)	,Precio VARCHAR(150),
			EtiquetaDescripcion2 VARCHAR(150)		,Precio2 VARCHAR(150)		,TextoLibre VARCHAR(150)			,FlagEstrella VARCHAR(150)			,ColorFondo VARCHAR(150),
			TipoEstrategiaID VARCHAR(150)			,FotoProducto01 VARCHAR(150),ImagenURL VARCHAR(150)				,LimiteVenta VARCHAR(150)			,MarcaID VARCHAR(150),
			Orden1 VARCHAR(150)						,Orden2 VARCHAR(150)		,IndicadorMontoMinimo VARCHAR(150)	,FlagNueva VARCHAR(150)				,TipoTallaColor VARCHAR(150),
			TipoEstrategiaImagenMostrar VARCHAR(150),CodigoProducto VARCHAR(150),EtiquetaID VARCHAR(150)			,EtiquetaID2 VARCHAR(150)			,CodigoEstrategia VARCHAR(150),
			TieneVariedad VARCHAR(150)				,CODIGO VARCHAR(150)		,DescripcionEstrategia VARCHAR(150)	,FlagMostrarImg VARCHAR(150)		,DescripcionMarca VARCHAR(150),
			DescripcionCategoria VARCHAR(150)		,PrecioPublico VARCHAR(150)	,Ganancia VARCHAR(150))
		
		insert into @tmpOpt exec ListarEstrategiasOPT @CampaniaID,@CodigoConsultora
		select CUV2 as CUV, DescripcionCUV2 as Descripcion from @tmpOpt

	END
	ELSE IF @Palanca = '10' --RD
	BEGIN

		DECLARE @EstrategiaCodigoOPM varchar(100) = '007'
		DECLARE @EstrategiaCodigoPAD varchar(100) = '008'
		DECLARE @TipoPersonalizacionCodigoOpm varchar(3) = 'OPM'
		DECLARE @TipoPersonalizacionCodigoPad varchar(3) = 'PAD'
		DECLARE @TipoPersonalizacionCodigoOpmPad varchar(3) = 'OPM;PAD'

		DECLARE @tablaCuvFaltante TABLE(CUV VARCHAR(6))
		INSERT INTO @tablaCuvFaltante(CUV)
		SELECT CUV FROM [dbo].[ObtenerCuvFaltante](@CampaniaID,@CodigoConsultora)

		DECLARE @CodConsultoraDefault VARCHAR(9) = ''
		SELECT @CodConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001

		DECLARE @CodConsultoraForzada VARCHAR(9) = ''
		SELECT @CodConsultoraForzada = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10002

		DECLARE  @OfertasPersonalizadas TABLE (Orden INT, CUV CHAR(6), TipoPersonalizacion CHAR(3), FlagRevista INT, AnioCampanaVenta INT, TipoEstrategiaId INT)

		INSERT INTO @OfertasPersonalizadas EXEC ListarOfertasPersonalizadas @CampaniaID,@TipoPersonalizacionCodigoOpmPad,@CodigoConsultora

		IF NOT EXISTS (SELECT TOP 1 CUV FROM @OfertasPersonalizadas)
		BEGIN
			INSERT INTO @OfertasPersonalizadas
			EXEC ListarOfertasPersonalizadas @CampaniaID,@TipoPersonalizacionCodigoOpmPad,@codConsultoraDefault
		END

		INSERT INTO @OfertasPersonalizadas EXEC ListarOfertasPersonalizadas @CampaniaID,@TipoPersonalizacionCodigoPad,@codConsultoraForzada
		INSERT INTO @OfertasPersonalizadas EXEC ListarOfertasPersonalizadas @CampaniaID,@TipoPersonalizacionCodigoOpm,@codConsultoraForzada

		SELECT
			E.CUV2 as CUV,
			E.DescripcionCUV2 as Descripcion
		FROM  dbo.Estrategia E with(nolock)
			INNER JOIN @OfertasPersonalizadas op ON E.CampaniaID = op.AnioCampanaVenta AND E.CUV2 = op.CUV AND OP.TipoEstrategiaId = E.TipoEstrategiaId
			INNER JOIN dbo.TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID AND TE.Codigo in (@EstrategiaCodigoOPM, @EstrategiaCodigoPAD)
			LEFT JOIN @tablaCuvFaltante TF ON E.CUV2 = TF.CUV
		WHERE
			E.Activo = 1 AND TE.FlagActivo = 1 AND TE.flagRecoPerfil = 1 AND TF.CUV IS NULL
		ORDER BY OP.Orden ASC, E.EstrategiaID ASC

	END
	ELSE IF @Palanca = '7' --ODD
	BEGIN

		DECLARE @fechaInicioFact DATE
		DECLARE @ZonaId INT
		DECLARE @num INT

		SET @ZonaId = (select ZonaId from ods.consultora where codigo = @CodigoConsultora)
		SET @fechaInicioFact = 
			(SELECT C.FechaInicioFacturacion 
			FROM ods.Cronograma C  
			INNER JOIN ods.Campania Ca ON C.CampaniaID = Ca.CampaniaID
			INNER JOIN [ods].[Zona] z (nolock) ON C.RegionID = z.RegionID AND c.ZonaID = z.ZonaID	
			WHERE Ca.Codigo = @CampaniaID AND Z.ZonaID = CASE WHEN @ZonaID = -1 THEN Z.ZonaID ELSE @ZonaID END)

		SET @num = (DATEDIFF(dd, @FechaConsulta, GETDATE()))
		SET @fechaInicioFact = (DATEADD(dd, @num, @fechaInicioFact))

		declare @tmpODD TABLE (
			EstrategiaID VARCHAR(150)				,CUV2 VARCHAR(150)				,DescripcionCUV2 VARCHAR(300)				,EtiquetaDescripcion VARCHAR(150)	,Precio VARCHAR(150),
			EtiquetaDescripcion2 VARCHAR(150)		,Precio2 VARCHAR(150)			,TextoLibre VARCHAR(150)					,CodigoEstrategia VARCHAR(150)		,FlagEstrella VARCHAR(150),
			ColorFondo VARCHAR(150)					,TipoEstrategiaID VARCHAR(150)	,FotoProducto01 VARCHAR(150)				,ImagenURL VARCHAR(150)				,LimiteVenta VARCHAR(150),
			MarcaID VARCHAR(150)					,Orden1 VARCHAR(150)			,Orden2 VARCHAR(150)						,IndicadorMontoMinimo VARCHAR(150)	,CodigoProducto VARCHAR(150),
			FlagNueva VARCHAR(150)					,TipoTallaColor VARCHAR(150)	,TipoEstrategiaImagenMostrar VARCHAR(150)	,EtiquetaID VARCHAR(150)			,EtiquetaID2 VARCHAR(150),
			CodigoEstrategia2 VARCHAR(150)			,TieneVariedad VARCHAR(150)		,CODIGO VARCHAR(150)						,DescripcionEstrategia VARCHAR(150)	,FlagMostrarImg VARCHAR(150),
			PrecioPublico VARCHAR(150)				,Ganancia VARCHAR(150)			,DescripcionMarca VARCHAR(150)				,FlagRevista VARCHAR(150)			,ImagenMiniaturaURL VARCHAR(150),
			DiaInicio VARCHAR(150))	

		insert into @tmpODD exec ListarEstrategiasODD2 @CampaniaID,@CodigoConsultora,@fechaInicioFact
		select CUV2 as CUV, DescripcionCUV2 as Descripcion from @tmpODD

	END
	ELSE IF @Palanca = '30' --SR
	BEGIN

		declare @tmpSR TABLE (
			EstrategiaID VARCHAR(150)				,CUV2 VARCHAR(150)							,DescripcionCUV2 VARCHAR(300)				,EtiquetaDescripcion VARCHAR(150)	,Precio VARCHAR(150),
			EtiquetaDescripcion2 VARCHAR(150)		,Precio2 VARCHAR(150)						,TextoLibre VARCHAR(150)					,FlagEstrella VARCHAR(150)			,ColorFondo VARCHAR(150),
			TipoEstrategiaID VARCHAR(150)			,FotoProducto01 VARCHAR(150)				,ImagenURL VARCHAR(150)						,LimiteVenta VARCHAR(150)			,MarcaID VARCHAR(150),
			Orden1 VARCHAR(150)						,Orden2 VARCHAR(150)						,IndicadorMontoMinimo VARCHAR(150)			,CodigoProducto VARCHAR(150)		,FlagNueva VARCHAR(150),
			TipoTallaColor VARCHAR(150)				,TipoEstrategiaImagenMostrar VARCHAR(150)	,EtiquetaID VARCHAR(150)					,EtiquetaID2 VARCHAR(150)			,CodigoEstrategia VARCHAR(150),
			TieneVariedad VARCHAR(150)				,CODIGO VARCHAR(150)						,DescripcionEstrategia VARCHAR(150)			,FlagMostrarImg VARCHAR(150)		,PrecioPublico VARCHAR(150),
			Ganancia VARCHAR(150)					,DescripcionMarca VARCHAR(150)				,FlagRevista VARCHAR(150)					,ImagenMiniaturaURL VARCHAR(150)	,EsSubCampania VARCHAR(150))

		insert into @tmpSR exec ListarEstrategiasShowRoom @CampaniaID,@CodigoConsultora
		select CUV2 as CUV, DescripcionCUV2 as Descripcion from @tmpSR

	END
	ELSE IF @Palanca = '9' --LAN
	BEGIN

		declare @tmpLAN TABLE (
			EstrategiaID VARCHAR(150)				,CUV2 VARCHAR(150)							,DescripcionCUV2 VARCHAR(300)				,EtiquetaDescripcion VARCHAR(150)	,Precio VARCHAR(150),
			EtiquetaDescripcion2 VARCHAR(150)		,Precio2 VARCHAR(150)						,TextoLibre VARCHAR(150)					,FlagEstrella VARCHAR(150)			,ColorFondo VARCHAR(150),
			TipoEstrategiaID VARCHAR(150)			,FotoProducto01 VARCHAR(150)				,ImagenURL VARCHAR(150)						,LimiteVenta VARCHAR(150)			,MarcaID VARCHAR(150),
			Orden1 VARCHAR(150)						,Orden2 VARCHAR(150)						,IndicadorMontoMinimo VARCHAR(150)			,FlagNueva VARCHAR(150)				,TipoTallaColor VARCHAR(150),
			TipoEstrategiaImagenMostrar VARCHAR(150),CodigoProducto VARCHAR(150)				,EtiquetaID VARCHAR(150)					,EtiquetaID2 VARCHAR(150)			,CodigoEstrategia VARCHAR(150),
			TieneVariedad VARCHAR(150)				,CODIGO VARCHAR(150)						,DescripcionEstrategia VARCHAR(150)			,FlagMostrarImg VARCHAR(150)		,DescripcionMarca VARCHAR(150),
			DescripcionCategoria VARCHAR(150)		,FlagIndividual VARCHAR(150)				,Slogan VARCHAR(150)						,ImgFondoDesktop VARCHAR(150)		,ImgFichaDesktop VARCHAR(150),
			UrlVideoDesktop VARCHAR(150)			,ImgFichaFondoDesktop VARCHAR(150)			,ImgFondoMobile VARCHAR(150)				,ImgSelloProductoMobile VARCHAR(150),UrlVideoMobile VARCHAR(150),
			ImgFichaFondoMobile VARCHAR(150)		,ImgHomeDesktop VARCHAR(150)				,ImgHomeMobile VARCHAR(150)					,PrecioPublico VARCHAR(150)			,Ganancia VARCHAR(150))

		insert into @tmpLAN exec ListarEstrategiasLanzamiento @CampaniaID,@CodigoConsultora
		select CUV2 as CUV, DescripcionCUV2 as Descripcion from @tmpLAN

	END
	ELSE IF @Palanca = '12' --GND 
	BEGIN

		declare @tmpGND TABLE (
			EstrategiaID VARCHAR(150)				,CUV2 VARCHAR(150)							,DescripcionCUV2 VARCHAR(300)				,EtiquetaDescripcion VARCHAR(150)	,Precio VARCHAR(150),
			EtiquetaDescripcion2 VARCHAR(150)		,Precio2 VARCHAR(150)						,TextoLibre VARCHAR(150)					,FlagEstrella VARCHAR(150)			,ColorFondo VARCHAR(150),
			TipoEstrategiaID VARCHAR(150)			,FotoProducto01 VARCHAR(150)				,ImagenURL VARCHAR(150)						,LimiteVenta VARCHAR(150)			,MarcaID VARCHAR(150),
			Orden1 VARCHAR(150)						,Orden2 VARCHAR(150)						,IndicadorMontoMinimo VARCHAR(150)			,CodigoProducto VARCHAR(150)		,FlagNueva VARCHAR(150),
			TipoTallaColor VARCHAR(150)				,TipoEstrategiaImagenMostrar VARCHAR(150)	,EtiquetaID VARCHAR(150)					,EtiquetaID2 VARCHAR(150)			,CodigoEstrategia VARCHAR(150),
			TieneVariedad VARCHAR(150)				,CODIGO VARCHAR(150)						,DescripcionEstrategia VARCHAR(150)			,FlagMostrarImg VARCHAR(150)		,PrecioPublico VARCHAR(150),
			Ganancia VARCHAR(150)					,DescripcionMarca VARCHAR(150)				,FlagRevista VARCHAR(150))

		insert into @tmpGND exec ListarEstrategiasGuiaDeNegocioDigitalizada @CampaniaID,@CodigoConsultora
		select CUV2 as CUV, DescripcionCUV2 as Descripcion from @tmpGND

	END
END
GO

IF OBJECT_ID('GetReporteMovimientosPedido', 'P') IS NOT NULL 
  DROP PROCEDURE GetReporteMovimientosPedido
  GO

CREATE PROC GetReporteMovimientosPedido
(
	@CampaniaID INT = 0,
	@CodigoConsultora VARCHAR(30) = ''
)
AS
BEGIN

	DECLARE @consultoraId INT
	DECLARE @tipoAccionEliminacionProl INT

	SET @tipoAccionEliminacionProl = 201
	SET @consultoraId = (select consultoraid from ods.consultora where codigo = @CodigoConsultora)

	select
		pwaprol.Cuv, COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, pco.Descripcion) AS Descripcion, FechaAccion, 'PROL' as Origen, MensajeProl as Mensaje
	from 
		[dbo].[PedidoWebAccionesPROL] pwaprol
		LEFT join ods.productocomercial pco with(nolock) ON pwaprol.Cuv = pco.cuv and @CampaniaID = pco.anocampania
		LEFT JOIN dbo.MatrizComercial MC WITH (NOLOCK) ON pco.CodigoProducto = MC.CodigoSAP
		LEFT JOIN dbo.OfertaProducto OP WITH (NOLOCK) ON OP.CampaniaID = pco.anocampania AND OP.CUV = pco.CUV
		LEFT JOIN dbo.ProductoDescripcion PD WITH (NOLOCK) ON pco.anocampania = PD.CampaniaID AND pco.CUV = PD.CUV
	where
		pwaprol.ConsultoraID = @consultoraId and 
		pwaprol.CampaniaID = @CampaniaID and
		pwaprol.Accion = @tipoAccionEliminacionProl

	UNION

	select
		pwdseg.Cuv, COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, pco.Descripcion) AS Descripcion, FechaAccion, 'CONSULTORA' as Origen, '' as Mensaje
	from 
		[dbo].[PedidoWebDetalleSeguimiento] pwdseg
		LEFT join ods.productocomercial pco with(nolock) ON pwdseg.Cuv = pco.cuv and @CampaniaID = pco.anocampania
		LEFT JOIN dbo.MatrizComercial MC WITH (NOLOCK) ON pco.CodigoProducto = MC.CodigoSAP
		LEFT JOIN dbo.OfertaProducto OP WITH (NOLOCK) ON OP.CampaniaID = pco.anocampania AND OP.CUV = pco.CUV
		LEFT JOIN dbo.ProductoDescripcion PD WITH (NOLOCK) ON pco.anocampania = PD.CampaniaID AND pco.CUV = PD.CUV
	where
		pwdseg.ConsultoraID = @consultoraId and 
		pwdseg.CampaniaID = @CampaniaID

END
GO

IF OBJECT_ID('GetReporteCuvResumido', 'P') IS NOT NULL 
  DROP PROCEDURE GetReporteCuvResumido
  GO

CREATE PROC GetReporteCuvResumido
(
	@CampaniaID INT = 0,
	@Cuv VARCHAR(10) = ''
)
AS
BEGIN
	select
		
		pco.Cuv
		, pco.CodigoProducto as SAP
		, COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, est.DescripcionCUV2, pco.Descripcion) AS DescripcionProd
		, isnull(tes.DescripcionEstrategia,'') as Palanca
		, isnull(est.imagenURL,'') as imagenURL
		, case isnull(est.activo,'1') when 1 then 'SI' else 'NO' end as Activo
		, case isnull(pco.IndicadorDigitable,'0') when 1 then 'NO' else 'SI' end as PuedeDigitarse
		, isnull(est.Precio2,pco.PrecioCatalogo) as PrecioSet
	from 
		ods.productocomercial pco with(nolock)
		LEFT JOIN dbo.MatrizComercial MC WITH (NOLOCK) ON pco.CodigoProducto = MC.CodigoSAP
		LEFT JOIN dbo.OfertaProducto OP WITH (NOLOCK) ON OP.CampaniaID = pco.anocampania AND OP.CUV = pco.CUV
		LEFT JOIN dbo.ProductoDescripcion PD WITH (NOLOCK) ON pco.anocampania = PD.CampaniaID AND pco.CUV = PD.CUV
		LEFT JOIN estrategia est with(nolock) on pco.cuv = est.cuv2 and pco.anocampania = est.campaniaid
		LEFT JOIN tipoestrategia tes with(nolock) on est.tipoestrategiaid = tes.tipoestrategiaid
	where
		pco.cuv = @Cuv and 
		pco.anocampania = @CampaniaID
END
GO


