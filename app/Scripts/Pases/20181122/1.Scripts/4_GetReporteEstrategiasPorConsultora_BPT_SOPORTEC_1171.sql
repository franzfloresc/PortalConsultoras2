USE [BelcorpPeru]
GO

ALTER PROC GetReporteEstrategiasPorConsultora
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

USE [BelcorpBolivia]
GO

ALTER PROC GetReporteEstrategiasPorConsultora
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

USE [BelcorpChile]
GO

ALTER PROC GetReporteEstrategiasPorConsultora
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

USE [BelcorpColombia]
GO

ALTER PROC GetReporteEstrategiasPorConsultora
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

USE [BelcorpCostaRica]
GO

ALTER PROC GetReporteEstrategiasPorConsultora
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

USE [BelcorpDominicana]
GO

ALTER PROC GetReporteEstrategiasPorConsultora
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

USE [BelcorpEcuador]
GO

ALTER PROC GetReporteEstrategiasPorConsultora
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

USE [BelcorpGuatemala]
GO

ALTER PROC GetReporteEstrategiasPorConsultora
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

USE [BelcorpMexico]
GO

ALTER PROC GetReporteEstrategiasPorConsultora
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

USE [BelcorpPanama]
GO

ALTER PROC GetReporteEstrategiasPorConsultora
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

USE [BelcorpPuertoRico]
GO

ALTER PROC GetReporteEstrategiasPorConsultora
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

USE [BelcorpSalvador]
GO

ALTER PROC GetReporteEstrategiasPorConsultora
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
