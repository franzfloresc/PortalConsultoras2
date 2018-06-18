GO
USE BelcorpPeru
GO

GO
 -- exec ListarEstrategiasRevistaDigital 201807, '000001740'
ALTER PROCEDURE [dbo].[ListarEstrategiasRevistaDigital]
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(30)
AS
BEGIN
SET NOCOUNT ON;
	DECLARE @StrCampaniaID CHAR(6) = CONVERT(CHAR(6),@CampaniaID)
	DECLARE @tablaCuvFaltante table( CUV varchar(6))
	DECLARE @EstrategiaCodigoOPM varchar(100) = '007'
	DECLARE @EstrategiaCodigoPAD varchar(100) = '008'

	insert into @tablaCuvFaltante(CUV)
	select CUV from [dbo].[ObtenerCuvFaltante](@CampaniaID,@CodigoConsultora)
	declare  @OfertasPersonalizadas table
	(
		Orden int,
		CUV char(6),
		TipoPersonalizacion char(3),
		FlagRevista int,
		AnioCampanaVenta int
	)
	DECLARE @codConsultoraForzada VARCHAR(9) = ''
	DECLARE @codConsultoraDefault VARCHAR(9) = ''
	SELECT @codConsultoraForzada = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10002
	SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001

	INSERT INTO @OfertasPersonalizadas
	select
		isnull(Orden,0) Orden,CUV,TipoPersonalizacion,FlagRevista,convert(int,AnioCampanaVenta) AnioCampanaVenta
	from ods.OfertasPersonalizadas op with(nolock)
	where op.CodConsultora = @CodigoConsultora
		and op.AnioCampanaVenta = @StrCampaniaID
		and op.TipoPersonalizacion in ('OPM', 'PAD')
	IF NOT EXISTS (SELECT CUV FROM @OfertasPersonalizadas)
	BEGIN
		INSERT INTO @OfertasPersonalizadas
		select isnull(Orden,0) Orden,CUV,TipoPersonalizacion,FlagRevista,convert(int,AnioCampanaVenta) AnioCampanaVenta
		from ods.OfertasPersonalizadas op with(nolock)
		where op.CodConsultora = @codConsultoraDefault
			and op.AnioCampanaVenta = @StrCampaniaID
			and op.TipoPersonalizacion in ('OPM', 'PAD')
	END

	INSERT INTO @OfertasPersonalizadas(Orden,CUV,TipoPersonalizacion,FlagRevista,AnioCampanaVenta)
	SELECT Orden,CUV,TipoPersonalizacion,FlagRevista,AnioCampanaVenta
	from [dbo].[ListarEstrategiasForzadas](@CampaniaID,@EstrategiaCodigoOPM)
	INSERT INTO @OfertasPersonalizadas(Orden,CUV,TipoPersonalizacion,FlagRevista,AnioCampanaVenta)
	SELECT Orden,CUV,TipoPersonalizacion,FlagRevista,AnioCampanaVenta
	from [dbo].[ListarEstrategiasForzadas](@CampaniaID,@EstrategiaCodigoPAD)

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
	FROM dbo.Estrategia E with(nolock)
		INNER JOIN @OfertasPersonalizadas op
			ON E.CampaniaID = op.AnioCampanaVenta
			AND E.CUV2 = op.CUV
		INNER JOIN ods.ProductoComercial PC with(nolock)
			ON PC.CUV = E.CUV2
			AND PC.AnoCampania = E.CampaniaID
		INNER JOIN dbo.TipoEstrategia TE with(nolock)
			ON E.TipoEstrategiaID = TE.TipoEstrategiaID
			AND TE.Codigo in ('007', '008')
		LEFT JOIN dbo.Marca M with(nolock)
			ON M.MarcaId = PC.MarcaId
	WHERE
		E.Activo = 1
		AND TE.FlagActivo = 1
		AND TE.flagRecoPerfil = 1
		AND NOT EXISTS(SELECT CUV FROM @tablaCuvFaltante TF WHERE E.CUV2 = TF.CUV)
	ORDER BY OP.Orden ASC, E.EstrategiaID ASC
SET NOCOUNT OFF
END
GO


GO
USE BelcorpMexico
GO

GO
 -- exec ListarEstrategiasRevistaDigital 201807, '000001740'
ALTER PROCEDURE [dbo].[ListarEstrategiasRevistaDigital]
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(30)
AS
BEGIN
SET NOCOUNT ON;
	DECLARE @StrCampaniaID CHAR(6) = CONVERT(CHAR(6),@CampaniaID)
	DECLARE @tablaCuvFaltante table( CUV varchar(6))
	DECLARE @EstrategiaCodigoOPM varchar(100) = '007'
	DECLARE @EstrategiaCodigoPAD varchar(100) = '008'

	insert into @tablaCuvFaltante(CUV)
	select CUV from [dbo].[ObtenerCuvFaltante](@CampaniaID,@CodigoConsultora)
	declare  @OfertasPersonalizadas table
	(
		Orden int,
		CUV char(6),
		TipoPersonalizacion char(3),
		FlagRevista int,
		AnioCampanaVenta int
	)
	DECLARE @codConsultoraForzada VARCHAR(9) = ''
	DECLARE @codConsultoraDefault VARCHAR(9) = ''
	SELECT @codConsultoraForzada = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10002
	SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001

	INSERT INTO @OfertasPersonalizadas
	select
		isnull(Orden,0) Orden,CUV,TipoPersonalizacion,FlagRevista,convert(int,AnioCampanaVenta) AnioCampanaVenta
	from ods.OfertasPersonalizadas op with(nolock)
	where op.CodConsultora = @CodigoConsultora
		and op.AnioCampanaVenta = @StrCampaniaID
		and op.TipoPersonalizacion in ('OPM', 'PAD')
	IF NOT EXISTS (SELECT CUV FROM @OfertasPersonalizadas)
	BEGIN
		INSERT INTO @OfertasPersonalizadas
		select isnull(Orden,0) Orden,CUV,TipoPersonalizacion,FlagRevista,convert(int,AnioCampanaVenta) AnioCampanaVenta
		from ods.OfertasPersonalizadas op with(nolock)
		where op.CodConsultora = @codConsultoraDefault
			and op.AnioCampanaVenta = @StrCampaniaID
			and op.TipoPersonalizacion in ('OPM', 'PAD')
	END

	INSERT INTO @OfertasPersonalizadas(Orden,CUV,TipoPersonalizacion,FlagRevista,AnioCampanaVenta)
	SELECT Orden,CUV,TipoPersonalizacion,FlagRevista,AnioCampanaVenta
	from [dbo].[ListarEstrategiasForzadas](@CampaniaID,@EstrategiaCodigoOPM)
	INSERT INTO @OfertasPersonalizadas(Orden,CUV,TipoPersonalizacion,FlagRevista,AnioCampanaVenta)
	SELECT Orden,CUV,TipoPersonalizacion,FlagRevista,AnioCampanaVenta
	from [dbo].[ListarEstrategiasForzadas](@CampaniaID,@EstrategiaCodigoPAD)

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
	FROM dbo.Estrategia E with(nolock)
		INNER JOIN @OfertasPersonalizadas op
			ON E.CampaniaID = op.AnioCampanaVenta
			AND E.CUV2 = op.CUV
		INNER JOIN ods.ProductoComercial PC with(nolock)
			ON PC.CUV = E.CUV2
			AND PC.AnoCampania = E.CampaniaID
		INNER JOIN dbo.TipoEstrategia TE with(nolock)
			ON E.TipoEstrategiaID = TE.TipoEstrategiaID
			AND TE.Codigo in ('007', '008')
		LEFT JOIN dbo.Marca M with(nolock)
			ON M.MarcaId = PC.MarcaId
	WHERE
		E.Activo = 1
		AND TE.FlagActivo = 1
		AND TE.flagRecoPerfil = 1
		AND NOT EXISTS(SELECT CUV FROM @tablaCuvFaltante TF WHERE E.CUV2 = TF.CUV)
	ORDER BY OP.Orden ASC, E.EstrategiaID ASC
SET NOCOUNT OFF
END
GO


GO
USE BelcorpColombia
GO

GO
 -- exec ListarEstrategiasRevistaDigital 201807, '000001740'
ALTER PROCEDURE [dbo].[ListarEstrategiasRevistaDigital]
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(30)
AS
BEGIN
SET NOCOUNT ON;
	DECLARE @StrCampaniaID CHAR(6) = CONVERT(CHAR(6),@CampaniaID)
	DECLARE @tablaCuvFaltante table( CUV varchar(6))
	DECLARE @EstrategiaCodigoOPM varchar(100) = '007'
	DECLARE @EstrategiaCodigoPAD varchar(100) = '008'

	insert into @tablaCuvFaltante(CUV)
	select CUV from [dbo].[ObtenerCuvFaltante](@CampaniaID,@CodigoConsultora)
	declare  @OfertasPersonalizadas table
	(
		Orden int,
		CUV char(6),
		TipoPersonalizacion char(3),
		FlagRevista int,
		AnioCampanaVenta int
	)
	DECLARE @codConsultoraForzada VARCHAR(9) = ''
	DECLARE @codConsultoraDefault VARCHAR(9) = ''
	SELECT @codConsultoraForzada = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10002
	SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001

	INSERT INTO @OfertasPersonalizadas
	select
		isnull(Orden,0) Orden,CUV,TipoPersonalizacion,FlagRevista,convert(int,AnioCampanaVenta) AnioCampanaVenta
	from ods.OfertasPersonalizadas op with(nolock)
	where op.CodConsultora = @CodigoConsultora
		and op.AnioCampanaVenta = @StrCampaniaID
		and op.TipoPersonalizacion in ('OPM', 'PAD')
	IF NOT EXISTS (SELECT CUV FROM @OfertasPersonalizadas)
	BEGIN
		INSERT INTO @OfertasPersonalizadas
		select isnull(Orden,0) Orden,CUV,TipoPersonalizacion,FlagRevista,convert(int,AnioCampanaVenta) AnioCampanaVenta
		from ods.OfertasPersonalizadas op with(nolock)
		where op.CodConsultora = @codConsultoraDefault
			and op.AnioCampanaVenta = @StrCampaniaID
			and op.TipoPersonalizacion in ('OPM', 'PAD')
	END

	INSERT INTO @OfertasPersonalizadas(Orden,CUV,TipoPersonalizacion,FlagRevista,AnioCampanaVenta)
	SELECT Orden,CUV,TipoPersonalizacion,FlagRevista,AnioCampanaVenta
	from [dbo].[ListarEstrategiasForzadas](@CampaniaID,@EstrategiaCodigoOPM)
	INSERT INTO @OfertasPersonalizadas(Orden,CUV,TipoPersonalizacion,FlagRevista,AnioCampanaVenta)
	SELECT Orden,CUV,TipoPersonalizacion,FlagRevista,AnioCampanaVenta
	from [dbo].[ListarEstrategiasForzadas](@CampaniaID,@EstrategiaCodigoPAD)

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
	FROM dbo.Estrategia E with(nolock)
		INNER JOIN @OfertasPersonalizadas op
			ON E.CampaniaID = op.AnioCampanaVenta
			AND E.CUV2 = op.CUV
		INNER JOIN ods.ProductoComercial PC with(nolock)
			ON PC.CUV = E.CUV2
			AND PC.AnoCampania = E.CampaniaID
		INNER JOIN dbo.TipoEstrategia TE with(nolock)
			ON E.TipoEstrategiaID = TE.TipoEstrategiaID
			AND TE.Codigo in ('007', '008')
		LEFT JOIN dbo.Marca M with(nolock)
			ON M.MarcaId = PC.MarcaId
	WHERE
		E.Activo = 1
		AND TE.FlagActivo = 1
		AND TE.flagRecoPerfil = 1
		AND NOT EXISTS(SELECT CUV FROM @tablaCuvFaltante TF WHERE E.CUV2 = TF.CUV)
	ORDER BY OP.Orden ASC, E.EstrategiaID ASC
SET NOCOUNT OFF
END
GO


GO
USE BelcorpSalvador
GO

GO
 -- exec ListarEstrategiasRevistaDigital 201807, '000001740'
ALTER PROCEDURE [dbo].[ListarEstrategiasRevistaDigital]
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(30)
AS
BEGIN
SET NOCOUNT ON;
	DECLARE @StrCampaniaID CHAR(6) = CONVERT(CHAR(6),@CampaniaID)
	DECLARE @tablaCuvFaltante table( CUV varchar(6))
	DECLARE @EstrategiaCodigoOPM varchar(100) = '007'
	DECLARE @EstrategiaCodigoPAD varchar(100) = '008'

	insert into @tablaCuvFaltante(CUV)
	select CUV from [dbo].[ObtenerCuvFaltante](@CampaniaID,@CodigoConsultora)
	declare  @OfertasPersonalizadas table
	(
		Orden int,
		CUV char(6),
		TipoPersonalizacion char(3),
		FlagRevista int,
		AnioCampanaVenta int
	)
	DECLARE @codConsultoraForzada VARCHAR(9) = ''
	DECLARE @codConsultoraDefault VARCHAR(9) = ''
	SELECT @codConsultoraForzada = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10002
	SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001

	INSERT INTO @OfertasPersonalizadas
	select
		isnull(Orden,0) Orden,CUV,TipoPersonalizacion,FlagRevista,convert(int,AnioCampanaVenta) AnioCampanaVenta
	from ods.OfertasPersonalizadas op with(nolock)
	where op.CodConsultora = @CodigoConsultora
		and op.AnioCampanaVenta = @StrCampaniaID
		and op.TipoPersonalizacion in ('OPM', 'PAD')
	IF NOT EXISTS (SELECT CUV FROM @OfertasPersonalizadas)
	BEGIN
		INSERT INTO @OfertasPersonalizadas
		select isnull(Orden,0) Orden,CUV,TipoPersonalizacion,FlagRevista,convert(int,AnioCampanaVenta) AnioCampanaVenta
		from ods.OfertasPersonalizadas op with(nolock)
		where op.CodConsultora = @codConsultoraDefault
			and op.AnioCampanaVenta = @StrCampaniaID
			and op.TipoPersonalizacion in ('OPM', 'PAD')
	END

	INSERT INTO @OfertasPersonalizadas(Orden,CUV,TipoPersonalizacion,FlagRevista,AnioCampanaVenta)
	SELECT Orden,CUV,TipoPersonalizacion,FlagRevista,AnioCampanaVenta
	from [dbo].[ListarEstrategiasForzadas](@CampaniaID,@EstrategiaCodigoOPM)
	INSERT INTO @OfertasPersonalizadas(Orden,CUV,TipoPersonalizacion,FlagRevista,AnioCampanaVenta)
	SELECT Orden,CUV,TipoPersonalizacion,FlagRevista,AnioCampanaVenta
	from [dbo].[ListarEstrategiasForzadas](@CampaniaID,@EstrategiaCodigoPAD)

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
	FROM dbo.Estrategia E with(nolock)
		INNER JOIN @OfertasPersonalizadas op
			ON E.CampaniaID = op.AnioCampanaVenta
			AND E.CUV2 = op.CUV
		INNER JOIN ods.ProductoComercial PC with(nolock)
			ON PC.CUV = E.CUV2
			AND PC.AnoCampania = E.CampaniaID
		INNER JOIN dbo.TipoEstrategia TE with(nolock)
			ON E.TipoEstrategiaID = TE.TipoEstrategiaID
			AND TE.Codigo in ('007', '008')
		LEFT JOIN dbo.Marca M with(nolock)
			ON M.MarcaId = PC.MarcaId
	WHERE
		E.Activo = 1
		AND TE.FlagActivo = 1
		AND TE.flagRecoPerfil = 1
		AND NOT EXISTS(SELECT CUV FROM @tablaCuvFaltante TF WHERE E.CUV2 = TF.CUV)
	ORDER BY OP.Orden ASC, E.EstrategiaID ASC
SET NOCOUNT OFF
END
GO


GO
USE BelcorpPuertoRico
GO

GO
 -- exec ListarEstrategiasRevistaDigital 201807, '000001740'
ALTER PROCEDURE [dbo].[ListarEstrategiasRevistaDigital]
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(30)
AS
BEGIN
SET NOCOUNT ON;
	DECLARE @StrCampaniaID CHAR(6) = CONVERT(CHAR(6),@CampaniaID)
	DECLARE @tablaCuvFaltante table( CUV varchar(6))
	DECLARE @EstrategiaCodigoOPM varchar(100) = '007'
	DECLARE @EstrategiaCodigoPAD varchar(100) = '008'

	insert into @tablaCuvFaltante(CUV)
	select CUV from [dbo].[ObtenerCuvFaltante](@CampaniaID,@CodigoConsultora)
	declare  @OfertasPersonalizadas table
	(
		Orden int,
		CUV char(6),
		TipoPersonalizacion char(3),
		FlagRevista int,
		AnioCampanaVenta int
	)
	DECLARE @codConsultoraForzada VARCHAR(9) = ''
	DECLARE @codConsultoraDefault VARCHAR(9) = ''
	SELECT @codConsultoraForzada = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10002
	SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001

	INSERT INTO @OfertasPersonalizadas
	select
		isnull(Orden,0) Orden,CUV,TipoPersonalizacion,FlagRevista,convert(int,AnioCampanaVenta) AnioCampanaVenta
	from ods.OfertasPersonalizadas op with(nolock)
	where op.CodConsultora = @CodigoConsultora
		and op.AnioCampanaVenta = @StrCampaniaID
		and op.TipoPersonalizacion in ('OPM', 'PAD')
	IF NOT EXISTS (SELECT CUV FROM @OfertasPersonalizadas)
	BEGIN
		INSERT INTO @OfertasPersonalizadas
		select isnull(Orden,0) Orden,CUV,TipoPersonalizacion,FlagRevista,convert(int,AnioCampanaVenta) AnioCampanaVenta
		from ods.OfertasPersonalizadas op with(nolock)
		where op.CodConsultora = @codConsultoraDefault
			and op.AnioCampanaVenta = @StrCampaniaID
			and op.TipoPersonalizacion in ('OPM', 'PAD')
	END

	INSERT INTO @OfertasPersonalizadas(Orden,CUV,TipoPersonalizacion,FlagRevista,AnioCampanaVenta)
	SELECT Orden,CUV,TipoPersonalizacion,FlagRevista,AnioCampanaVenta
	from [dbo].[ListarEstrategiasForzadas](@CampaniaID,@EstrategiaCodigoOPM)
	INSERT INTO @OfertasPersonalizadas(Orden,CUV,TipoPersonalizacion,FlagRevista,AnioCampanaVenta)
	SELECT Orden,CUV,TipoPersonalizacion,FlagRevista,AnioCampanaVenta
	from [dbo].[ListarEstrategiasForzadas](@CampaniaID,@EstrategiaCodigoPAD)

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
	FROM dbo.Estrategia E with(nolock)
		INNER JOIN @OfertasPersonalizadas op
			ON E.CampaniaID = op.AnioCampanaVenta
			AND E.CUV2 = op.CUV
		INNER JOIN ods.ProductoComercial PC with(nolock)
			ON PC.CUV = E.CUV2
			AND PC.AnoCampania = E.CampaniaID
		INNER JOIN dbo.TipoEstrategia TE with(nolock)
			ON E.TipoEstrategiaID = TE.TipoEstrategiaID
			AND TE.Codigo in ('007', '008')
		LEFT JOIN dbo.Marca M with(nolock)
			ON M.MarcaId = PC.MarcaId
	WHERE
		E.Activo = 1
		AND TE.FlagActivo = 1
		AND TE.flagRecoPerfil = 1
		AND NOT EXISTS(SELECT CUV FROM @tablaCuvFaltante TF WHERE E.CUV2 = TF.CUV)
	ORDER BY OP.Orden ASC, E.EstrategiaID ASC
SET NOCOUNT OFF
END
GO


GO
USE BelcorpPanama
GO

GO
 -- exec ListarEstrategiasRevistaDigital 201807, '000001740'
ALTER PROCEDURE [dbo].[ListarEstrategiasRevistaDigital]
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(30)
AS
BEGIN
SET NOCOUNT ON;
	DECLARE @StrCampaniaID CHAR(6) = CONVERT(CHAR(6),@CampaniaID)
	DECLARE @tablaCuvFaltante table( CUV varchar(6))
	DECLARE @EstrategiaCodigoOPM varchar(100) = '007'
	DECLARE @EstrategiaCodigoPAD varchar(100) = '008'

	insert into @tablaCuvFaltante(CUV)
	select CUV from [dbo].[ObtenerCuvFaltante](@CampaniaID,@CodigoConsultora)
	declare  @OfertasPersonalizadas table
	(
		Orden int,
		CUV char(6),
		TipoPersonalizacion char(3),
		FlagRevista int,
		AnioCampanaVenta int
	)
	DECLARE @codConsultoraForzada VARCHAR(9) = ''
	DECLARE @codConsultoraDefault VARCHAR(9) = ''
	SELECT @codConsultoraForzada = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10002
	SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001

	INSERT INTO @OfertasPersonalizadas
	select
		isnull(Orden,0) Orden,CUV,TipoPersonalizacion,FlagRevista,convert(int,AnioCampanaVenta) AnioCampanaVenta
	from ods.OfertasPersonalizadas op with(nolock)
	where op.CodConsultora = @CodigoConsultora
		and op.AnioCampanaVenta = @StrCampaniaID
		and op.TipoPersonalizacion in ('OPM', 'PAD')
	IF NOT EXISTS (SELECT CUV FROM @OfertasPersonalizadas)
	BEGIN
		INSERT INTO @OfertasPersonalizadas
		select isnull(Orden,0) Orden,CUV,TipoPersonalizacion,FlagRevista,convert(int,AnioCampanaVenta) AnioCampanaVenta
		from ods.OfertasPersonalizadas op with(nolock)
		where op.CodConsultora = @codConsultoraDefault
			and op.AnioCampanaVenta = @StrCampaniaID
			and op.TipoPersonalizacion in ('OPM', 'PAD')
	END

	INSERT INTO @OfertasPersonalizadas(Orden,CUV,TipoPersonalizacion,FlagRevista,AnioCampanaVenta)
	SELECT Orden,CUV,TipoPersonalizacion,FlagRevista,AnioCampanaVenta
	from [dbo].[ListarEstrategiasForzadas](@CampaniaID,@EstrategiaCodigoOPM)
	INSERT INTO @OfertasPersonalizadas(Orden,CUV,TipoPersonalizacion,FlagRevista,AnioCampanaVenta)
	SELECT Orden,CUV,TipoPersonalizacion,FlagRevista,AnioCampanaVenta
	from [dbo].[ListarEstrategiasForzadas](@CampaniaID,@EstrategiaCodigoPAD)

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
	FROM dbo.Estrategia E with(nolock)
		INNER JOIN @OfertasPersonalizadas op
			ON E.CampaniaID = op.AnioCampanaVenta
			AND E.CUV2 = op.CUV
		INNER JOIN ods.ProductoComercial PC with(nolock)
			ON PC.CUV = E.CUV2
			AND PC.AnoCampania = E.CampaniaID
		INNER JOIN dbo.TipoEstrategia TE with(nolock)
			ON E.TipoEstrategiaID = TE.TipoEstrategiaID
			AND TE.Codigo in ('007', '008')
		LEFT JOIN dbo.Marca M with(nolock)
			ON M.MarcaId = PC.MarcaId
	WHERE
		E.Activo = 1
		AND TE.FlagActivo = 1
		AND TE.flagRecoPerfil = 1
		AND NOT EXISTS(SELECT CUV FROM @tablaCuvFaltante TF WHERE E.CUV2 = TF.CUV)
	ORDER BY OP.Orden ASC, E.EstrategiaID ASC
SET NOCOUNT OFF
END
GO


GO
USE BelcorpGuatemala
GO

GO
 -- exec ListarEstrategiasRevistaDigital 201807, '000001740'
ALTER PROCEDURE [dbo].[ListarEstrategiasRevistaDigital]
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(30)
AS
BEGIN
SET NOCOUNT ON;
	DECLARE @StrCampaniaID CHAR(6) = CONVERT(CHAR(6),@CampaniaID)
	DECLARE @tablaCuvFaltante table( CUV varchar(6))
	DECLARE @EstrategiaCodigoOPM varchar(100) = '007'
	DECLARE @EstrategiaCodigoPAD varchar(100) = '008'

	insert into @tablaCuvFaltante(CUV)
	select CUV from [dbo].[ObtenerCuvFaltante](@CampaniaID,@CodigoConsultora)
	declare  @OfertasPersonalizadas table
	(
		Orden int,
		CUV char(6),
		TipoPersonalizacion char(3),
		FlagRevista int,
		AnioCampanaVenta int
	)
	DECLARE @codConsultoraForzada VARCHAR(9) = ''
	DECLARE @codConsultoraDefault VARCHAR(9) = ''
	SELECT @codConsultoraForzada = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10002
	SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001

	INSERT INTO @OfertasPersonalizadas
	select
		isnull(Orden,0) Orden,CUV,TipoPersonalizacion,FlagRevista,convert(int,AnioCampanaVenta) AnioCampanaVenta
	from ods.OfertasPersonalizadas op with(nolock)
	where op.CodConsultora = @CodigoConsultora
		and op.AnioCampanaVenta = @StrCampaniaID
		and op.TipoPersonalizacion in ('OPM', 'PAD')
	IF NOT EXISTS (SELECT CUV FROM @OfertasPersonalizadas)
	BEGIN
		INSERT INTO @OfertasPersonalizadas
		select isnull(Orden,0) Orden,CUV,TipoPersonalizacion,FlagRevista,convert(int,AnioCampanaVenta) AnioCampanaVenta
		from ods.OfertasPersonalizadas op with(nolock)
		where op.CodConsultora = @codConsultoraDefault
			and op.AnioCampanaVenta = @StrCampaniaID
			and op.TipoPersonalizacion in ('OPM', 'PAD')
	END

	INSERT INTO @OfertasPersonalizadas(Orden,CUV,TipoPersonalizacion,FlagRevista,AnioCampanaVenta)
	SELECT Orden,CUV,TipoPersonalizacion,FlagRevista,AnioCampanaVenta
	from [dbo].[ListarEstrategiasForzadas](@CampaniaID,@EstrategiaCodigoOPM)
	INSERT INTO @OfertasPersonalizadas(Orden,CUV,TipoPersonalizacion,FlagRevista,AnioCampanaVenta)
	SELECT Orden,CUV,TipoPersonalizacion,FlagRevista,AnioCampanaVenta
	from [dbo].[ListarEstrategiasForzadas](@CampaniaID,@EstrategiaCodigoPAD)

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
	FROM dbo.Estrategia E with(nolock)
		INNER JOIN @OfertasPersonalizadas op
			ON E.CampaniaID = op.AnioCampanaVenta
			AND E.CUV2 = op.CUV
		INNER JOIN ods.ProductoComercial PC with(nolock)
			ON PC.CUV = E.CUV2
			AND PC.AnoCampania = E.CampaniaID
		INNER JOIN dbo.TipoEstrategia TE with(nolock)
			ON E.TipoEstrategiaID = TE.TipoEstrategiaID
			AND TE.Codigo in ('007', '008')
		LEFT JOIN dbo.Marca M with(nolock)
			ON M.MarcaId = PC.MarcaId
	WHERE
		E.Activo = 1
		AND TE.FlagActivo = 1
		AND TE.flagRecoPerfil = 1
		AND NOT EXISTS(SELECT CUV FROM @tablaCuvFaltante TF WHERE E.CUV2 = TF.CUV)
	ORDER BY OP.Orden ASC, E.EstrategiaID ASC
SET NOCOUNT OFF
END
GO


GO
USE BelcorpEcuador
GO

GO
 -- exec ListarEstrategiasRevistaDigital 201807, '000001740'
ALTER PROCEDURE [dbo].[ListarEstrategiasRevistaDigital]
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(30)
AS
BEGIN
SET NOCOUNT ON;
	DECLARE @StrCampaniaID CHAR(6) = CONVERT(CHAR(6),@CampaniaID)
	DECLARE @tablaCuvFaltante table( CUV varchar(6))
	DECLARE @EstrategiaCodigoOPM varchar(100) = '007'
	DECLARE @EstrategiaCodigoPAD varchar(100) = '008'

	insert into @tablaCuvFaltante(CUV)
	select CUV from [dbo].[ObtenerCuvFaltante](@CampaniaID,@CodigoConsultora)
	declare  @OfertasPersonalizadas table
	(
		Orden int,
		CUV char(6),
		TipoPersonalizacion char(3),
		FlagRevista int,
		AnioCampanaVenta int
	)
	DECLARE @codConsultoraForzada VARCHAR(9) = ''
	DECLARE @codConsultoraDefault VARCHAR(9) = ''
	SELECT @codConsultoraForzada = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10002
	SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001

	INSERT INTO @OfertasPersonalizadas
	select
		isnull(Orden,0) Orden,CUV,TipoPersonalizacion,FlagRevista,convert(int,AnioCampanaVenta) AnioCampanaVenta
	from ods.OfertasPersonalizadas op with(nolock)
	where op.CodConsultora = @CodigoConsultora
		and op.AnioCampanaVenta = @StrCampaniaID
		and op.TipoPersonalizacion in ('OPM', 'PAD')
	IF NOT EXISTS (SELECT CUV FROM @OfertasPersonalizadas)
	BEGIN
		INSERT INTO @OfertasPersonalizadas
		select isnull(Orden,0) Orden,CUV,TipoPersonalizacion,FlagRevista,convert(int,AnioCampanaVenta) AnioCampanaVenta
		from ods.OfertasPersonalizadas op with(nolock)
		where op.CodConsultora = @codConsultoraDefault
			and op.AnioCampanaVenta = @StrCampaniaID
			and op.TipoPersonalizacion in ('OPM', 'PAD')
	END

	INSERT INTO @OfertasPersonalizadas(Orden,CUV,TipoPersonalizacion,FlagRevista,AnioCampanaVenta)
	SELECT Orden,CUV,TipoPersonalizacion,FlagRevista,AnioCampanaVenta
	from [dbo].[ListarEstrategiasForzadas](@CampaniaID,@EstrategiaCodigoOPM)
	INSERT INTO @OfertasPersonalizadas(Orden,CUV,TipoPersonalizacion,FlagRevista,AnioCampanaVenta)
	SELECT Orden,CUV,TipoPersonalizacion,FlagRevista,AnioCampanaVenta
	from [dbo].[ListarEstrategiasForzadas](@CampaniaID,@EstrategiaCodigoPAD)

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
	FROM dbo.Estrategia E with(nolock)
		INNER JOIN @OfertasPersonalizadas op
			ON E.CampaniaID = op.AnioCampanaVenta
			AND E.CUV2 = op.CUV
		INNER JOIN ods.ProductoComercial PC with(nolock)
			ON PC.CUV = E.CUV2
			AND PC.AnoCampania = E.CampaniaID
		INNER JOIN dbo.TipoEstrategia TE with(nolock)
			ON E.TipoEstrategiaID = TE.TipoEstrategiaID
			AND TE.Codigo in ('007', '008')
		LEFT JOIN dbo.Marca M with(nolock)
			ON M.MarcaId = PC.MarcaId
	WHERE
		E.Activo = 1
		AND TE.FlagActivo = 1
		AND TE.flagRecoPerfil = 1
		AND NOT EXISTS(SELECT CUV FROM @tablaCuvFaltante TF WHERE E.CUV2 = TF.CUV)
	ORDER BY OP.Orden ASC, E.EstrategiaID ASC
SET NOCOUNT OFF
END
GO


GO
USE BelcorpDominicana
GO

GO
 -- exec ListarEstrategiasRevistaDigital 201807, '000001740'
ALTER PROCEDURE [dbo].[ListarEstrategiasRevistaDigital]
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(30)
AS
BEGIN
SET NOCOUNT ON;
	DECLARE @StrCampaniaID CHAR(6) = CONVERT(CHAR(6),@CampaniaID)
	DECLARE @tablaCuvFaltante table( CUV varchar(6))
	DECLARE @EstrategiaCodigoOPM varchar(100) = '007'
	DECLARE @EstrategiaCodigoPAD varchar(100) = '008'

	insert into @tablaCuvFaltante(CUV)
	select CUV from [dbo].[ObtenerCuvFaltante](@CampaniaID,@CodigoConsultora)
	declare  @OfertasPersonalizadas table
	(
		Orden int,
		CUV char(6),
		TipoPersonalizacion char(3),
		FlagRevista int,
		AnioCampanaVenta int
	)
	DECLARE @codConsultoraForzada VARCHAR(9) = ''
	DECLARE @codConsultoraDefault VARCHAR(9) = ''
	SELECT @codConsultoraForzada = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10002
	SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001

	INSERT INTO @OfertasPersonalizadas
	select
		isnull(Orden,0) Orden,CUV,TipoPersonalizacion,FlagRevista,convert(int,AnioCampanaVenta) AnioCampanaVenta
	from ods.OfertasPersonalizadas op with(nolock)
	where op.CodConsultora = @CodigoConsultora
		and op.AnioCampanaVenta = @StrCampaniaID
		and op.TipoPersonalizacion in ('OPM', 'PAD')
	IF NOT EXISTS (SELECT CUV FROM @OfertasPersonalizadas)
	BEGIN
		INSERT INTO @OfertasPersonalizadas
		select isnull(Orden,0) Orden,CUV,TipoPersonalizacion,FlagRevista,convert(int,AnioCampanaVenta) AnioCampanaVenta
		from ods.OfertasPersonalizadas op with(nolock)
		where op.CodConsultora = @codConsultoraDefault
			and op.AnioCampanaVenta = @StrCampaniaID
			and op.TipoPersonalizacion in ('OPM', 'PAD')
	END

	INSERT INTO @OfertasPersonalizadas(Orden,CUV,TipoPersonalizacion,FlagRevista,AnioCampanaVenta)
	SELECT Orden,CUV,TipoPersonalizacion,FlagRevista,AnioCampanaVenta
	from [dbo].[ListarEstrategiasForzadas](@CampaniaID,@EstrategiaCodigoOPM)
	INSERT INTO @OfertasPersonalizadas(Orden,CUV,TipoPersonalizacion,FlagRevista,AnioCampanaVenta)
	SELECT Orden,CUV,TipoPersonalizacion,FlagRevista,AnioCampanaVenta
	from [dbo].[ListarEstrategiasForzadas](@CampaniaID,@EstrategiaCodigoPAD)

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
	FROM dbo.Estrategia E with(nolock)
		INNER JOIN @OfertasPersonalizadas op
			ON E.CampaniaID = op.AnioCampanaVenta
			AND E.CUV2 = op.CUV
		INNER JOIN ods.ProductoComercial PC with(nolock)
			ON PC.CUV = E.CUV2
			AND PC.AnoCampania = E.CampaniaID
		INNER JOIN dbo.TipoEstrategia TE with(nolock)
			ON E.TipoEstrategiaID = TE.TipoEstrategiaID
			AND TE.Codigo in ('007', '008')
		LEFT JOIN dbo.Marca M with(nolock)
			ON M.MarcaId = PC.MarcaId
	WHERE
		E.Activo = 1
		AND TE.FlagActivo = 1
		AND TE.flagRecoPerfil = 1
		AND NOT EXISTS(SELECT CUV FROM @tablaCuvFaltante TF WHERE E.CUV2 = TF.CUV)
	ORDER BY OP.Orden ASC, E.EstrategiaID ASC
SET NOCOUNT OFF
END
GO


GO
USE BelcorpCostaRica
GO

GO
 -- exec ListarEstrategiasRevistaDigital 201807, '000001740'
ALTER PROCEDURE [dbo].[ListarEstrategiasRevistaDigital]
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(30)
AS
BEGIN
SET NOCOUNT ON;
	DECLARE @StrCampaniaID CHAR(6) = CONVERT(CHAR(6),@CampaniaID)
	DECLARE @tablaCuvFaltante table( CUV varchar(6))
	DECLARE @EstrategiaCodigoOPM varchar(100) = '007'
	DECLARE @EstrategiaCodigoPAD varchar(100) = '008'

	insert into @tablaCuvFaltante(CUV)
	select CUV from [dbo].[ObtenerCuvFaltante](@CampaniaID,@CodigoConsultora)
	declare  @OfertasPersonalizadas table
	(
		Orden int,
		CUV char(6),
		TipoPersonalizacion char(3),
		FlagRevista int,
		AnioCampanaVenta int
	)
	DECLARE @codConsultoraForzada VARCHAR(9) = ''
	DECLARE @codConsultoraDefault VARCHAR(9) = ''
	SELECT @codConsultoraForzada = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10002
	SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001

	INSERT INTO @OfertasPersonalizadas
	select
		isnull(Orden,0) Orden,CUV,TipoPersonalizacion,FlagRevista,convert(int,AnioCampanaVenta) AnioCampanaVenta
	from ods.OfertasPersonalizadas op with(nolock)
	where op.CodConsultora = @CodigoConsultora
		and op.AnioCampanaVenta = @StrCampaniaID
		and op.TipoPersonalizacion in ('OPM', 'PAD')
	IF NOT EXISTS (SELECT CUV FROM @OfertasPersonalizadas)
	BEGIN
		INSERT INTO @OfertasPersonalizadas
		select isnull(Orden,0) Orden,CUV,TipoPersonalizacion,FlagRevista,convert(int,AnioCampanaVenta) AnioCampanaVenta
		from ods.OfertasPersonalizadas op with(nolock)
		where op.CodConsultora = @codConsultoraDefault
			and op.AnioCampanaVenta = @StrCampaniaID
			and op.TipoPersonalizacion in ('OPM', 'PAD')
	END

	INSERT INTO @OfertasPersonalizadas(Orden,CUV,TipoPersonalizacion,FlagRevista,AnioCampanaVenta)
	SELECT Orden,CUV,TipoPersonalizacion,FlagRevista,AnioCampanaVenta
	from [dbo].[ListarEstrategiasForzadas](@CampaniaID,@EstrategiaCodigoOPM)
	INSERT INTO @OfertasPersonalizadas(Orden,CUV,TipoPersonalizacion,FlagRevista,AnioCampanaVenta)
	SELECT Orden,CUV,TipoPersonalizacion,FlagRevista,AnioCampanaVenta
	from [dbo].[ListarEstrategiasForzadas](@CampaniaID,@EstrategiaCodigoPAD)

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
	FROM dbo.Estrategia E with(nolock)
		INNER JOIN @OfertasPersonalizadas op
			ON E.CampaniaID = op.AnioCampanaVenta
			AND E.CUV2 = op.CUV
		INNER JOIN ods.ProductoComercial PC with(nolock)
			ON PC.CUV = E.CUV2
			AND PC.AnoCampania = E.CampaniaID
		INNER JOIN dbo.TipoEstrategia TE with(nolock)
			ON E.TipoEstrategiaID = TE.TipoEstrategiaID
			AND TE.Codigo in ('007', '008')
		LEFT JOIN dbo.Marca M with(nolock)
			ON M.MarcaId = PC.MarcaId
	WHERE
		E.Activo = 1
		AND TE.FlagActivo = 1
		AND TE.flagRecoPerfil = 1
		AND NOT EXISTS(SELECT CUV FROM @tablaCuvFaltante TF WHERE E.CUV2 = TF.CUV)
	ORDER BY OP.Orden ASC, E.EstrategiaID ASC
SET NOCOUNT OFF
END
GO


GO
USE BelcorpChile
GO

GO
 -- exec ListarEstrategiasRevistaDigital 201807, '000001740'
ALTER PROCEDURE [dbo].[ListarEstrategiasRevistaDigital]
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(30)
AS
BEGIN
SET NOCOUNT ON;
	DECLARE @StrCampaniaID CHAR(6) = CONVERT(CHAR(6),@CampaniaID)
	DECLARE @tablaCuvFaltante table( CUV varchar(6))
	DECLARE @EstrategiaCodigoOPM varchar(100) = '007'
	DECLARE @EstrategiaCodigoPAD varchar(100) = '008'

	insert into @tablaCuvFaltante(CUV)
	select CUV from [dbo].[ObtenerCuvFaltante](@CampaniaID,@CodigoConsultora)
	declare  @OfertasPersonalizadas table
	(
		Orden int,
		CUV char(6),
		TipoPersonalizacion char(3),
		FlagRevista int,
		AnioCampanaVenta int
	)
	DECLARE @codConsultoraForzada VARCHAR(9) = ''
	DECLARE @codConsultoraDefault VARCHAR(9) = ''
	SELECT @codConsultoraForzada = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10002
	SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001

	INSERT INTO @OfertasPersonalizadas
	select
		isnull(Orden,0) Orden,CUV,TipoPersonalizacion,FlagRevista,convert(int,AnioCampanaVenta) AnioCampanaVenta
	from ods.OfertasPersonalizadas op with(nolock)
	where op.CodConsultora = @CodigoConsultora
		and op.AnioCampanaVenta = @StrCampaniaID
		and op.TipoPersonalizacion in ('OPM', 'PAD')
	IF NOT EXISTS (SELECT CUV FROM @OfertasPersonalizadas)
	BEGIN
		INSERT INTO @OfertasPersonalizadas
		select isnull(Orden,0) Orden,CUV,TipoPersonalizacion,FlagRevista,convert(int,AnioCampanaVenta) AnioCampanaVenta
		from ods.OfertasPersonalizadas op with(nolock)
		where op.CodConsultora = @codConsultoraDefault
			and op.AnioCampanaVenta = @StrCampaniaID
			and op.TipoPersonalizacion in ('OPM', 'PAD')
	END

	INSERT INTO @OfertasPersonalizadas(Orden,CUV,TipoPersonalizacion,FlagRevista,AnioCampanaVenta)
	SELECT Orden,CUV,TipoPersonalizacion,FlagRevista,AnioCampanaVenta
	from [dbo].[ListarEstrategiasForzadas](@CampaniaID,@EstrategiaCodigoOPM)
	INSERT INTO @OfertasPersonalizadas(Orden,CUV,TipoPersonalizacion,FlagRevista,AnioCampanaVenta)
	SELECT Orden,CUV,TipoPersonalizacion,FlagRevista,AnioCampanaVenta
	from [dbo].[ListarEstrategiasForzadas](@CampaniaID,@EstrategiaCodigoPAD)

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
	FROM dbo.Estrategia E with(nolock)
		INNER JOIN @OfertasPersonalizadas op
			ON E.CampaniaID = op.AnioCampanaVenta
			AND E.CUV2 = op.CUV
		INNER JOIN ods.ProductoComercial PC with(nolock)
			ON PC.CUV = E.CUV2
			AND PC.AnoCampania = E.CampaniaID
		INNER JOIN dbo.TipoEstrategia TE with(nolock)
			ON E.TipoEstrategiaID = TE.TipoEstrategiaID
			AND TE.Codigo in ('007', '008')
		LEFT JOIN dbo.Marca M with(nolock)
			ON M.MarcaId = PC.MarcaId
	WHERE
		E.Activo = 1
		AND TE.FlagActivo = 1
		AND TE.flagRecoPerfil = 1
		AND NOT EXISTS(SELECT CUV FROM @tablaCuvFaltante TF WHERE E.CUV2 = TF.CUV)
	ORDER BY OP.Orden ASC, E.EstrategiaID ASC
SET NOCOUNT OFF
END
GO


GO
USE BelcorpBolivia
GO

GO
 -- exec ListarEstrategiasRevistaDigital 201807, '000001740'
ALTER PROCEDURE [dbo].[ListarEstrategiasRevistaDigital]
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(30)
AS
BEGIN
SET NOCOUNT ON;
	DECLARE @StrCampaniaID CHAR(6) = CONVERT(CHAR(6),@CampaniaID)
	DECLARE @tablaCuvFaltante table( CUV varchar(6))
	DECLARE @EstrategiaCodigoOPM varchar(100) = '007'
	DECLARE @EstrategiaCodigoPAD varchar(100) = '008'

	insert into @tablaCuvFaltante(CUV)
	select CUV from [dbo].[ObtenerCuvFaltante](@CampaniaID,@CodigoConsultora)
	declare  @OfertasPersonalizadas table
	(
		Orden int,
		CUV char(6),
		TipoPersonalizacion char(3),
		FlagRevista int,
		AnioCampanaVenta int
	)
	DECLARE @codConsultoraForzada VARCHAR(9) = ''
	DECLARE @codConsultoraDefault VARCHAR(9) = ''
	SELECT @codConsultoraForzada = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10002
	SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10001

	INSERT INTO @OfertasPersonalizadas
	select
		isnull(Orden,0) Orden,CUV,TipoPersonalizacion,FlagRevista,convert(int,AnioCampanaVenta) AnioCampanaVenta
	from ods.OfertasPersonalizadas op with(nolock)
	where op.CodConsultora = @CodigoConsultora
		and op.AnioCampanaVenta = @StrCampaniaID
		and op.TipoPersonalizacion in ('OPM', 'PAD')
	IF NOT EXISTS (SELECT CUV FROM @OfertasPersonalizadas)
	BEGIN
		INSERT INTO @OfertasPersonalizadas
		select isnull(Orden,0) Orden,CUV,TipoPersonalizacion,FlagRevista,convert(int,AnioCampanaVenta) AnioCampanaVenta
		from ods.OfertasPersonalizadas op with(nolock)
		where op.CodConsultora = @codConsultoraDefault
			and op.AnioCampanaVenta = @StrCampaniaID
			and op.TipoPersonalizacion in ('OPM', 'PAD')
	END

	INSERT INTO @OfertasPersonalizadas(Orden,CUV,TipoPersonalizacion,FlagRevista,AnioCampanaVenta)
	SELECT Orden,CUV,TipoPersonalizacion,FlagRevista,AnioCampanaVenta
	from [dbo].[ListarEstrategiasForzadas](@CampaniaID,@EstrategiaCodigoOPM)
	INSERT INTO @OfertasPersonalizadas(Orden,CUV,TipoPersonalizacion,FlagRevista,AnioCampanaVenta)
	SELECT Orden,CUV,TipoPersonalizacion,FlagRevista,AnioCampanaVenta
	from [dbo].[ListarEstrategiasForzadas](@CampaniaID,@EstrategiaCodigoPAD)

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
	FROM dbo.Estrategia E with(nolock)
		INNER JOIN @OfertasPersonalizadas op
			ON E.CampaniaID = op.AnioCampanaVenta
			AND E.CUV2 = op.CUV
		INNER JOIN ods.ProductoComercial PC with(nolock)
			ON PC.CUV = E.CUV2
			AND PC.AnoCampania = E.CampaniaID
		INNER JOIN dbo.TipoEstrategia TE with(nolock)
			ON E.TipoEstrategiaID = TE.TipoEstrategiaID
			AND TE.Codigo in ('007', '008')
		LEFT JOIN dbo.Marca M with(nolock)
			ON M.MarcaId = PC.MarcaId
	WHERE
		E.Activo = 1
		AND TE.FlagActivo = 1
		AND TE.flagRecoPerfil = 1
		AND NOT EXISTS(SELECT CUV FROM @tablaCuvFaltante TF WHERE E.CUV2 = TF.CUV)
	ORDER BY OP.Orden ASC, E.EstrategiaID ASC
SET NOCOUNT OFF
END
GO


GO
