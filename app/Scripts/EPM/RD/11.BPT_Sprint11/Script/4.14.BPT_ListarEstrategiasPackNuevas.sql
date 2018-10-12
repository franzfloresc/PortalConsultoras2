USE BelcorpPeru
GO

GO
ALTER PROCEDURE [dbo].[ListarEstrategiasPackNuevas]
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(30)
AS
/*
dbo.ListarEstrategiasPackNuevas 201715, '0001511'
*/
BEGIN
SET NOCOUNT ON;
	
	declare @ZonaID VARCHAR(20) = ''
	, @NumeroPedido INT = 0

	select @ZonaID = ZonaID
		, @NumeroPedido = ConsecutivoNueva + 1
	from ods.Consultora with(nolock)
	where Codigo = @CodigoConsultora

	SELECT
		EstrategiaID,
		CUV2,
		DescripcionCUV2,
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
		Precio,
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID2) EtiquetaDescripcion2,
		Precio2,
		TextoLibre,
		FlagEstrella,
		ColorFondo,
		e.TipoEstrategiaID,
		e.ImagenURL FotoProducto01,
		te.ImagenEstrategia ImagenURL,
		e.LimiteVenta,
		pc.MarcaID,
		te.Orden Orden1,
		e.Orden Orden2,
		pc.IndicadorMontoMinimo,
		pc.CodigoProducto,
		1 AS FlagNueva,
		'' as TipoTallaColor,
		2 as TipoEstrategiaImagenMostrar
		, E.EtiquetaID
		, E.EtiquetaID2
		, E.CodigoEstrategia
		, E.TieneVariedad
		, TE.CODIGO
		, TE.DescripcionEstrategia
		, ISNULL(TE.FlagMostrarImg,0) AS FlagMostrarImg
		, E.EsOfertaIndependiente
		, TE.ImagenOfertaIndependiente
		, TE.MostrarImgOfertaIndependiente
		, E.PrecioPublico
		, E.Ganancia
	FROM Estrategia E with(nolock)
		INNER JOIN TipoEstrategia TE with(nolock) ON
			E.TipoEstrategiaID = TE.TipoEstrategiaID
		INNER JOIN ods.Campania CA with(nolock) ON
			E.CampaniaID = CA.Codigo
		INNER JOIN ods.ProductoComercial PC with(nolock) ON
			PC.CampaniaID = CA.CampaniaID
			AND PC.CUV = E.CUV2
		INNER JOIN Ods.ConsultorasProgramaNuevas CPN with(nolock) ON
			CPN.CodigoConsultora = @CodigoConsultora
			AND CPN.CodigoPrograma = TE.CodigoPrograma
	WHERE
		(E.CampaniaID = @CampaniaID OR @CampaniaID between E.CampaniaID and E.CampaniaIDFin)
		AND CPN.Participa = 1
		AND TE.FlagActivo = 1
		AND TE.flagNueva = 1
		AND E.Activo = 1
		AND E.Zona LIKE '%' + @ZonaID + '%'
		AND E.NumeroPedido = @NumeroPedido
	order by
		te.Orden ASC, CASE WHEN ISNULL(e.Orden,0) = 0 THEN te.Orden ELSE e.Orden END ASC, EstrategiaID ASC


SET NOCOUNT OFF
END
GO

USE BelcorpMexico
GO

GO
ALTER PROCEDURE [dbo].[ListarEstrategiasPackNuevas]
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(30)
AS
/*
dbo.ListarEstrategiasPackNuevas 201715, '0001511'
*/
BEGIN
SET NOCOUNT ON;
	
	declare @ZonaID VARCHAR(20) = ''
	, @NumeroPedido INT = 0

	select @ZonaID = ZonaID
		, @NumeroPedido = ConsecutivoNueva + 1
	from ods.Consultora with(nolock)
	where Codigo = @CodigoConsultora

	SELECT
		EstrategiaID,
		CUV2,
		DescripcionCUV2,
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
		Precio,
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID2) EtiquetaDescripcion2,
		Precio2,
		TextoLibre,
		FlagEstrella,
		ColorFondo,
		e.TipoEstrategiaID,
		e.ImagenURL FotoProducto01,
		te.ImagenEstrategia ImagenURL,
		e.LimiteVenta,
		pc.MarcaID,
		te.Orden Orden1,
		e.Orden Orden2,
		pc.IndicadorMontoMinimo,
		pc.CodigoProducto,
		1 AS FlagNueva,
		'' as TipoTallaColor,
		2 as TipoEstrategiaImagenMostrar
		, E.EtiquetaID
		, E.EtiquetaID2
		, E.CodigoEstrategia
		, E.TieneVariedad
		, TE.CODIGO
		, TE.DescripcionEstrategia
		, ISNULL(TE.FlagMostrarImg,0) AS FlagMostrarImg
		, E.EsOfertaIndependiente
		, TE.ImagenOfertaIndependiente
		, TE.MostrarImgOfertaIndependiente
		, E.PrecioPublico
		, E.Ganancia
	FROM Estrategia E with(nolock)
		INNER JOIN TipoEstrategia TE with(nolock) ON
			E.TipoEstrategiaID = TE.TipoEstrategiaID
		INNER JOIN ods.Campania CA with(nolock) ON
			E.CampaniaID = CA.Codigo
		INNER JOIN ods.ProductoComercial PC with(nolock) ON
			PC.CampaniaID = CA.CampaniaID
			AND PC.CUV = E.CUV2
		INNER JOIN Ods.ConsultorasProgramaNuevas CPN with(nolock) ON
			CPN.CodigoConsultora = @CodigoConsultora
			AND CPN.CodigoPrograma = TE.CodigoPrograma
	WHERE
		(E.CampaniaID = @CampaniaID OR @CampaniaID between E.CampaniaID and E.CampaniaIDFin)
		AND CPN.Participa = 1
		AND TE.FlagActivo = 1
		AND TE.flagNueva = 1
		AND E.Activo = 1
		AND E.Zona LIKE '%' + @ZonaID + '%'
		AND E.NumeroPedido = @NumeroPedido
	order by
		te.Orden ASC, CASE WHEN ISNULL(e.Orden,0) = 0 THEN te.Orden ELSE e.Orden END ASC, EstrategiaID ASC


SET NOCOUNT OFF
END
GO

USE BelcorpColombia
GO

GO
ALTER PROCEDURE [dbo].[ListarEstrategiasPackNuevas]
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(30)
AS
/*
dbo.ListarEstrategiasPackNuevas 201715, '0001511'
*/
BEGIN
SET NOCOUNT ON;
	
	declare @ZonaID VARCHAR(20) = ''
	, @NumeroPedido INT = 0

	select @ZonaID = ZonaID
		, @NumeroPedido = ConsecutivoNueva + 1
	from ods.Consultora with(nolock)
	where Codigo = @CodigoConsultora

	SELECT
		EstrategiaID,
		CUV2,
		DescripcionCUV2,
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
		Precio,
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID2) EtiquetaDescripcion2,
		Precio2,
		TextoLibre,
		FlagEstrella,
		ColorFondo,
		e.TipoEstrategiaID,
		e.ImagenURL FotoProducto01,
		te.ImagenEstrategia ImagenURL,
		e.LimiteVenta,
		pc.MarcaID,
		te.Orden Orden1,
		e.Orden Orden2,
		pc.IndicadorMontoMinimo,
		pc.CodigoProducto,
		1 AS FlagNueva,
		'' as TipoTallaColor,
		2 as TipoEstrategiaImagenMostrar
		, E.EtiquetaID
		, E.EtiquetaID2
		, E.CodigoEstrategia
		, E.TieneVariedad
		, TE.CODIGO
		, TE.DescripcionEstrategia
		, ISNULL(TE.FlagMostrarImg,0) AS FlagMostrarImg
		, E.EsOfertaIndependiente
		, TE.ImagenOfertaIndependiente
		, TE.MostrarImgOfertaIndependiente
		, E.PrecioPublico
		, E.Ganancia
	FROM Estrategia E with(nolock)
		INNER JOIN TipoEstrategia TE with(nolock) ON
			E.TipoEstrategiaID = TE.TipoEstrategiaID
		INNER JOIN ods.Campania CA with(nolock) ON
			E.CampaniaID = CA.Codigo
		INNER JOIN ods.ProductoComercial PC with(nolock) ON
			PC.CampaniaID = CA.CampaniaID
			AND PC.CUV = E.CUV2
		INNER JOIN Ods.ConsultorasProgramaNuevas CPN with(nolock) ON
			CPN.CodigoConsultora = @CodigoConsultora
			AND CPN.CodigoPrograma = TE.CodigoPrograma
	WHERE
		(E.CampaniaID = @CampaniaID OR @CampaniaID between E.CampaniaID and E.CampaniaIDFin)
		AND CPN.Participa = 1
		AND TE.FlagActivo = 1
		AND TE.flagNueva = 1
		AND E.Activo = 1
		AND E.Zona LIKE '%' + @ZonaID + '%'
		AND E.NumeroPedido = @NumeroPedido
	order by
		te.Orden ASC, CASE WHEN ISNULL(e.Orden,0) = 0 THEN te.Orden ELSE e.Orden END ASC, EstrategiaID ASC


SET NOCOUNT OFF
END
GO

USE BelcorpVenezuela
GO

GO
ALTER PROCEDURE [dbo].[ListarEstrategiasPackNuevas]
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(30)
AS
/*
dbo.ListarEstrategiasPackNuevas 201715, '0001511'
*/
BEGIN
SET NOCOUNT ON;
	
	declare @ZonaID VARCHAR(20) = ''
	, @NumeroPedido INT = 0

	select @ZonaID = ZonaID
		, @NumeroPedido = ConsecutivoNueva + 1
	from ods.Consultora with(nolock)
	where Codigo = @CodigoConsultora

	SELECT
		EstrategiaID,
		CUV2,
		DescripcionCUV2,
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
		Precio,
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID2) EtiquetaDescripcion2,
		Precio2,
		TextoLibre,
		FlagEstrella,
		ColorFondo,
		e.TipoEstrategiaID,
		e.ImagenURL FotoProducto01,
		te.ImagenEstrategia ImagenURL,
		e.LimiteVenta,
		pc.MarcaID,
		te.Orden Orden1,
		e.Orden Orden2,
		pc.IndicadorMontoMinimo,
		pc.CodigoProducto,
		1 AS FlagNueva,
		'' as TipoTallaColor,
		2 as TipoEstrategiaImagenMostrar
		, E.EtiquetaID
		, E.EtiquetaID2
		, E.CodigoEstrategia
		, E.TieneVariedad
		, TE.CODIGO
		, TE.DescripcionEstrategia
		, ISNULL(TE.FlagMostrarImg,0) AS FlagMostrarImg
		, E.EsOfertaIndependiente
		, TE.ImagenOfertaIndependiente
		, TE.MostrarImgOfertaIndependiente
		, E.PrecioPublico
		, E.Ganancia
	FROM Estrategia E with(nolock)
		INNER JOIN TipoEstrategia TE with(nolock) ON
			E.TipoEstrategiaID = TE.TipoEstrategiaID
		INNER JOIN ods.Campania CA with(nolock) ON
			E.CampaniaID = CA.Codigo
		INNER JOIN ods.ProductoComercial PC with(nolock) ON
			PC.CampaniaID = CA.CampaniaID
			AND PC.CUV = E.CUV2
		INNER JOIN Ods.ConsultorasProgramaNuevas CPN with(nolock) ON
			CPN.CodigoConsultora = @CodigoConsultora
			AND CPN.CodigoPrograma = TE.CodigoPrograma
	WHERE
		(E.CampaniaID = @CampaniaID OR @CampaniaID between E.CampaniaID and E.CampaniaIDFin)
		AND CPN.Participa = 1
		AND TE.FlagActivo = 1
		AND TE.flagNueva = 1
		AND E.Activo = 1
		AND E.Zona LIKE '%' + @ZonaID + '%'
		AND E.NumeroPedido = @NumeroPedido
	order by
		te.Orden ASC, CASE WHEN ISNULL(e.Orden,0) = 0 THEN te.Orden ELSE e.Orden END ASC, EstrategiaID ASC


SET NOCOUNT OFF
END
GO

USE BelcorpSalvador
GO

GO
ALTER PROCEDURE [dbo].[ListarEstrategiasPackNuevas]
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(30)
AS
/*
dbo.ListarEstrategiasPackNuevas 201715, '0001511'
*/
BEGIN
SET NOCOUNT ON;
	
	declare @ZonaID VARCHAR(20) = ''
	, @NumeroPedido INT = 0

	select @ZonaID = ZonaID
		, @NumeroPedido = ConsecutivoNueva + 1
	from ods.Consultora with(nolock)
	where Codigo = @CodigoConsultora

	SELECT
		EstrategiaID,
		CUV2,
		DescripcionCUV2,
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
		Precio,
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID2) EtiquetaDescripcion2,
		Precio2,
		TextoLibre,
		FlagEstrella,
		ColorFondo,
		e.TipoEstrategiaID,
		e.ImagenURL FotoProducto01,
		te.ImagenEstrategia ImagenURL,
		e.LimiteVenta,
		pc.MarcaID,
		te.Orden Orden1,
		e.Orden Orden2,
		pc.IndicadorMontoMinimo,
		pc.CodigoProducto,
		1 AS FlagNueva,
		'' as TipoTallaColor,
		2 as TipoEstrategiaImagenMostrar
		, E.EtiquetaID
		, E.EtiquetaID2
		, E.CodigoEstrategia
		, E.TieneVariedad
		, TE.CODIGO
		, TE.DescripcionEstrategia
		, ISNULL(TE.FlagMostrarImg,0) AS FlagMostrarImg
		, E.EsOfertaIndependiente
		, TE.ImagenOfertaIndependiente
		, TE.MostrarImgOfertaIndependiente
		, E.PrecioPublico
		, E.Ganancia
	FROM Estrategia E with(nolock)
		INNER JOIN TipoEstrategia TE with(nolock) ON
			E.TipoEstrategiaID = TE.TipoEstrategiaID
		INNER JOIN ods.Campania CA with(nolock) ON
			E.CampaniaID = CA.Codigo
		INNER JOIN ods.ProductoComercial PC with(nolock) ON
			PC.CampaniaID = CA.CampaniaID
			AND PC.CUV = E.CUV2
		INNER JOIN Ods.ConsultorasProgramaNuevas CPN with(nolock) ON
			CPN.CodigoConsultora = @CodigoConsultora
			AND CPN.CodigoPrograma = TE.CodigoPrograma
	WHERE
		(E.CampaniaID = @CampaniaID OR @CampaniaID between E.CampaniaID and E.CampaniaIDFin)
		AND CPN.Participa = 1
		AND TE.FlagActivo = 1
		AND TE.flagNueva = 1
		AND E.Activo = 1
		AND E.Zona LIKE '%' + @ZonaID + '%'
		AND E.NumeroPedido = @NumeroPedido
	order by
		te.Orden ASC, CASE WHEN ISNULL(e.Orden,0) = 0 THEN te.Orden ELSE e.Orden END ASC, EstrategiaID ASC


SET NOCOUNT OFF
END
GO

USE BelcorpPuertoRico
GO

GO
ALTER PROCEDURE [dbo].[ListarEstrategiasPackNuevas]
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(30)
AS
/*
dbo.ListarEstrategiasPackNuevas 201715, '0001511'
*/
BEGIN
SET NOCOUNT ON;
	
	declare @ZonaID VARCHAR(20) = ''
	, @NumeroPedido INT = 0

	select @ZonaID = ZonaID
		, @NumeroPedido = ConsecutivoNueva + 1
	from ods.Consultora with(nolock)
	where Codigo = @CodigoConsultora

	SELECT
		EstrategiaID,
		CUV2,
		DescripcionCUV2,
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
		Precio,
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID2) EtiquetaDescripcion2,
		Precio2,
		TextoLibre,
		FlagEstrella,
		ColorFondo,
		e.TipoEstrategiaID,
		e.ImagenURL FotoProducto01,
		te.ImagenEstrategia ImagenURL,
		e.LimiteVenta,
		pc.MarcaID,
		te.Orden Orden1,
		e.Orden Orden2,
		pc.IndicadorMontoMinimo,
		pc.CodigoProducto,
		1 AS FlagNueva,
		'' as TipoTallaColor,
		2 as TipoEstrategiaImagenMostrar
		, E.EtiquetaID
		, E.EtiquetaID2
		, E.CodigoEstrategia
		, E.TieneVariedad
		, TE.CODIGO
		, TE.DescripcionEstrategia
		, ISNULL(TE.FlagMostrarImg,0) AS FlagMostrarImg
		, E.EsOfertaIndependiente
		, TE.ImagenOfertaIndependiente
		, TE.MostrarImgOfertaIndependiente
		, E.PrecioPublico
		, E.Ganancia
	FROM Estrategia E with(nolock)
		INNER JOIN TipoEstrategia TE with(nolock) ON
			E.TipoEstrategiaID = TE.TipoEstrategiaID
		INNER JOIN ods.Campania CA with(nolock) ON
			E.CampaniaID = CA.Codigo
		INNER JOIN ods.ProductoComercial PC with(nolock) ON
			PC.CampaniaID = CA.CampaniaID
			AND PC.CUV = E.CUV2
		INNER JOIN Ods.ConsultorasProgramaNuevas CPN with(nolock) ON
			CPN.CodigoConsultora = @CodigoConsultora
			AND CPN.CodigoPrograma = TE.CodigoPrograma
	WHERE
		(E.CampaniaID = @CampaniaID OR @CampaniaID between E.CampaniaID and E.CampaniaIDFin)
		AND CPN.Participa = 1
		AND TE.FlagActivo = 1
		AND TE.flagNueva = 1
		AND E.Activo = 1
		AND E.Zona LIKE '%' + @ZonaID + '%'
		AND E.NumeroPedido = @NumeroPedido
	order by
		te.Orden ASC, CASE WHEN ISNULL(e.Orden,0) = 0 THEN te.Orden ELSE e.Orden END ASC, EstrategiaID ASC


SET NOCOUNT OFF
END
GO

USE BelcorpPanama
GO

GO
ALTER PROCEDURE [dbo].[ListarEstrategiasPackNuevas]
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(30)
AS
/*
dbo.ListarEstrategiasPackNuevas 201715, '0001511'
*/
BEGIN
SET NOCOUNT ON;
	
	declare @ZonaID VARCHAR(20) = ''
	, @NumeroPedido INT = 0

	select @ZonaID = ZonaID
		, @NumeroPedido = ConsecutivoNueva + 1
	from ods.Consultora with(nolock)
	where Codigo = @CodigoConsultora

	SELECT
		EstrategiaID,
		CUV2,
		DescripcionCUV2,
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
		Precio,
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID2) EtiquetaDescripcion2,
		Precio2,
		TextoLibre,
		FlagEstrella,
		ColorFondo,
		e.TipoEstrategiaID,
		e.ImagenURL FotoProducto01,
		te.ImagenEstrategia ImagenURL,
		e.LimiteVenta,
		pc.MarcaID,
		te.Orden Orden1,
		e.Orden Orden2,
		pc.IndicadorMontoMinimo,
		pc.CodigoProducto,
		1 AS FlagNueva,
		'' as TipoTallaColor,
		2 as TipoEstrategiaImagenMostrar
		, E.EtiquetaID
		, E.EtiquetaID2
		, E.CodigoEstrategia
		, E.TieneVariedad
		, TE.CODIGO
		, TE.DescripcionEstrategia
		, ISNULL(TE.FlagMostrarImg,0) AS FlagMostrarImg
		, E.EsOfertaIndependiente
		, TE.ImagenOfertaIndependiente
		, TE.MostrarImgOfertaIndependiente
		, E.PrecioPublico
		, E.Ganancia
	FROM Estrategia E with(nolock)
		INNER JOIN TipoEstrategia TE with(nolock) ON
			E.TipoEstrategiaID = TE.TipoEstrategiaID
		INNER JOIN ods.Campania CA with(nolock) ON
			E.CampaniaID = CA.Codigo
		INNER JOIN ods.ProductoComercial PC with(nolock) ON
			PC.CampaniaID = CA.CampaniaID
			AND PC.CUV = E.CUV2
		INNER JOIN Ods.ConsultorasProgramaNuevas CPN with(nolock) ON
			CPN.CodigoConsultora = @CodigoConsultora
			AND CPN.CodigoPrograma = TE.CodigoPrograma
	WHERE
		(E.CampaniaID = @CampaniaID OR @CampaniaID between E.CampaniaID and E.CampaniaIDFin)
		AND CPN.Participa = 1
		AND TE.FlagActivo = 1
		AND TE.flagNueva = 1
		AND E.Activo = 1
		AND E.Zona LIKE '%' + @ZonaID + '%'
		AND E.NumeroPedido = @NumeroPedido
	order by
		te.Orden ASC, CASE WHEN ISNULL(e.Orden,0) = 0 THEN te.Orden ELSE e.Orden END ASC, EstrategiaID ASC


SET NOCOUNT OFF
END
GO

USE BelcorpGuatemala
GO

GO
ALTER PROCEDURE [dbo].[ListarEstrategiasPackNuevas]
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(30)
AS
/*
dbo.ListarEstrategiasPackNuevas 201715, '0001511'
*/
BEGIN
SET NOCOUNT ON;
	
	declare @ZonaID VARCHAR(20) = ''
	, @NumeroPedido INT = 0

	select @ZonaID = ZonaID
		, @NumeroPedido = ConsecutivoNueva + 1
	from ods.Consultora with(nolock)
	where Codigo = @CodigoConsultora

	SELECT
		EstrategiaID,
		CUV2,
		DescripcionCUV2,
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
		Precio,
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID2) EtiquetaDescripcion2,
		Precio2,
		TextoLibre,
		FlagEstrella,
		ColorFondo,
		e.TipoEstrategiaID,
		e.ImagenURL FotoProducto01,
		te.ImagenEstrategia ImagenURL,
		e.LimiteVenta,
		pc.MarcaID,
		te.Orden Orden1,
		e.Orden Orden2,
		pc.IndicadorMontoMinimo,
		pc.CodigoProducto,
		1 AS FlagNueva,
		'' as TipoTallaColor,
		2 as TipoEstrategiaImagenMostrar
		, E.EtiquetaID
		, E.EtiquetaID2
		, E.CodigoEstrategia
		, E.TieneVariedad
		, TE.CODIGO
		, TE.DescripcionEstrategia
		, ISNULL(TE.FlagMostrarImg,0) AS FlagMostrarImg
		, E.EsOfertaIndependiente
		, TE.ImagenOfertaIndependiente
		, TE.MostrarImgOfertaIndependiente
		, E.PrecioPublico
		, E.Ganancia
	FROM Estrategia E with(nolock)
		INNER JOIN TipoEstrategia TE with(nolock) ON
			E.TipoEstrategiaID = TE.TipoEstrategiaID
		INNER JOIN ods.Campania CA with(nolock) ON
			E.CampaniaID = CA.Codigo
		INNER JOIN ods.ProductoComercial PC with(nolock) ON
			PC.CampaniaID = CA.CampaniaID
			AND PC.CUV = E.CUV2
		INNER JOIN Ods.ConsultorasProgramaNuevas CPN with(nolock) ON
			CPN.CodigoConsultora = @CodigoConsultora
			AND CPN.CodigoPrograma = TE.CodigoPrograma
	WHERE
		(E.CampaniaID = @CampaniaID OR @CampaniaID between E.CampaniaID and E.CampaniaIDFin)
		AND CPN.Participa = 1
		AND TE.FlagActivo = 1
		AND TE.flagNueva = 1
		AND E.Activo = 1
		AND E.Zona LIKE '%' + @ZonaID + '%'
		AND E.NumeroPedido = @NumeroPedido
	order by
		te.Orden ASC, CASE WHEN ISNULL(e.Orden,0) = 0 THEN te.Orden ELSE e.Orden END ASC, EstrategiaID ASC


SET NOCOUNT OFF
END
GO

USE BelcorpEcuador
GO

GO
ALTER PROCEDURE [dbo].[ListarEstrategiasPackNuevas]
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(30)
AS
/*
dbo.ListarEstrategiasPackNuevas 201715, '0001511'
*/
BEGIN
SET NOCOUNT ON;
	
	declare @ZonaID VARCHAR(20) = ''
	, @NumeroPedido INT = 0

	select @ZonaID = ZonaID
		, @NumeroPedido = ConsecutivoNueva + 1
	from ods.Consultora with(nolock)
	where Codigo = @CodigoConsultora

	SELECT
		EstrategiaID,
		CUV2,
		DescripcionCUV2,
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
		Precio,
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID2) EtiquetaDescripcion2,
		Precio2,
		TextoLibre,
		FlagEstrella,
		ColorFondo,
		e.TipoEstrategiaID,
		e.ImagenURL FotoProducto01,
		te.ImagenEstrategia ImagenURL,
		e.LimiteVenta,
		pc.MarcaID,
		te.Orden Orden1,
		e.Orden Orden2,
		pc.IndicadorMontoMinimo,
		pc.CodigoProducto,
		1 AS FlagNueva,
		'' as TipoTallaColor,
		2 as TipoEstrategiaImagenMostrar
		, E.EtiquetaID
		, E.EtiquetaID2
		, E.CodigoEstrategia
		, E.TieneVariedad
		, TE.CODIGO
		, TE.DescripcionEstrategia
		, ISNULL(TE.FlagMostrarImg,0) AS FlagMostrarImg
		, E.EsOfertaIndependiente
		, TE.ImagenOfertaIndependiente
		, TE.MostrarImgOfertaIndependiente
		, E.PrecioPublico
		, E.Ganancia
	FROM Estrategia E with(nolock)
		INNER JOIN TipoEstrategia TE with(nolock) ON
			E.TipoEstrategiaID = TE.TipoEstrategiaID
		INNER JOIN ods.Campania CA with(nolock) ON
			E.CampaniaID = CA.Codigo
		INNER JOIN ods.ProductoComercial PC with(nolock) ON
			PC.CampaniaID = CA.CampaniaID
			AND PC.CUV = E.CUV2
		INNER JOIN Ods.ConsultorasProgramaNuevas CPN with(nolock) ON
			CPN.CodigoConsultora = @CodigoConsultora
			AND CPN.CodigoPrograma = TE.CodigoPrograma
	WHERE
		(E.CampaniaID = @CampaniaID OR @CampaniaID between E.CampaniaID and E.CampaniaIDFin)
		AND CPN.Participa = 1
		AND TE.FlagActivo = 1
		AND TE.flagNueva = 1
		AND E.Activo = 1
		AND E.Zona LIKE '%' + @ZonaID + '%'
		AND E.NumeroPedido = @NumeroPedido
	order by
		te.Orden ASC, CASE WHEN ISNULL(e.Orden,0) = 0 THEN te.Orden ELSE e.Orden END ASC, EstrategiaID ASC


SET NOCOUNT OFF
END
GO

USE BelcorpDominicana
GO

GO
ALTER PROCEDURE [dbo].[ListarEstrategiasPackNuevas]
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(30)
AS
/*
dbo.ListarEstrategiasPackNuevas 201715, '0001511'
*/
BEGIN
SET NOCOUNT ON;
	
	declare @ZonaID VARCHAR(20) = ''
	, @NumeroPedido INT = 0

	select @ZonaID = ZonaID
		, @NumeroPedido = ConsecutivoNueva + 1
	from ods.Consultora with(nolock)
	where Codigo = @CodigoConsultora

	SELECT
		EstrategiaID,
		CUV2,
		DescripcionCUV2,
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
		Precio,
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID2) EtiquetaDescripcion2,
		Precio2,
		TextoLibre,
		FlagEstrella,
		ColorFondo,
		e.TipoEstrategiaID,
		e.ImagenURL FotoProducto01,
		te.ImagenEstrategia ImagenURL,
		e.LimiteVenta,
		pc.MarcaID,
		te.Orden Orden1,
		e.Orden Orden2,
		pc.IndicadorMontoMinimo,
		pc.CodigoProducto,
		1 AS FlagNueva,
		'' as TipoTallaColor,
		2 as TipoEstrategiaImagenMostrar
		, E.EtiquetaID
		, E.EtiquetaID2
		, E.CodigoEstrategia
		, E.TieneVariedad
		, TE.CODIGO
		, TE.DescripcionEstrategia
		, ISNULL(TE.FlagMostrarImg,0) AS FlagMostrarImg
		, E.EsOfertaIndependiente
		, TE.ImagenOfertaIndependiente
		, TE.MostrarImgOfertaIndependiente
		, E.PrecioPublico
		, E.Ganancia
	FROM Estrategia E with(nolock)
		INNER JOIN TipoEstrategia TE with(nolock) ON
			E.TipoEstrategiaID = TE.TipoEstrategiaID
		INNER JOIN ods.Campania CA with(nolock) ON
			E.CampaniaID = CA.Codigo
		INNER JOIN ods.ProductoComercial PC with(nolock) ON
			PC.CampaniaID = CA.CampaniaID
			AND PC.CUV = E.CUV2
		INNER JOIN Ods.ConsultorasProgramaNuevas CPN with(nolock) ON
			CPN.CodigoConsultora = @CodigoConsultora
			AND CPN.CodigoPrograma = TE.CodigoPrograma
	WHERE
		(E.CampaniaID = @CampaniaID OR @CampaniaID between E.CampaniaID and E.CampaniaIDFin)
		AND CPN.Participa = 1
		AND TE.FlagActivo = 1
		AND TE.flagNueva = 1
		AND E.Activo = 1
		AND E.Zona LIKE '%' + @ZonaID + '%'
		AND E.NumeroPedido = @NumeroPedido
	order by
		te.Orden ASC, CASE WHEN ISNULL(e.Orden,0) = 0 THEN te.Orden ELSE e.Orden END ASC, EstrategiaID ASC


SET NOCOUNT OFF
END
GO

USE BelcorpCostaRica
GO

GO
ALTER PROCEDURE [dbo].[ListarEstrategiasPackNuevas]
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(30)
AS
/*
dbo.ListarEstrategiasPackNuevas 201715, '0001511'
*/
BEGIN
SET NOCOUNT ON;
	
	declare @ZonaID VARCHAR(20) = ''
	, @NumeroPedido INT = 0

	select @ZonaID = ZonaID
		, @NumeroPedido = ConsecutivoNueva + 1
	from ods.Consultora with(nolock)
	where Codigo = @CodigoConsultora

	SELECT
		EstrategiaID,
		CUV2,
		DescripcionCUV2,
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
		Precio,
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID2) EtiquetaDescripcion2,
		Precio2,
		TextoLibre,
		FlagEstrella,
		ColorFondo,
		e.TipoEstrategiaID,
		e.ImagenURL FotoProducto01,
		te.ImagenEstrategia ImagenURL,
		e.LimiteVenta,
		pc.MarcaID,
		te.Orden Orden1,
		e.Orden Orden2,
		pc.IndicadorMontoMinimo,
		pc.CodigoProducto,
		1 AS FlagNueva,
		'' as TipoTallaColor,
		2 as TipoEstrategiaImagenMostrar
		, E.EtiquetaID
		, E.EtiquetaID2
		, E.CodigoEstrategia
		, E.TieneVariedad
		, TE.CODIGO
		, TE.DescripcionEstrategia
		, ISNULL(TE.FlagMostrarImg,0) AS FlagMostrarImg
		, E.EsOfertaIndependiente
		, TE.ImagenOfertaIndependiente
		, TE.MostrarImgOfertaIndependiente
		, E.PrecioPublico
		, E.Ganancia
	FROM Estrategia E with(nolock)
		INNER JOIN TipoEstrategia TE with(nolock) ON
			E.TipoEstrategiaID = TE.TipoEstrategiaID
		INNER JOIN ods.Campania CA with(nolock) ON
			E.CampaniaID = CA.Codigo
		INNER JOIN ods.ProductoComercial PC with(nolock) ON
			PC.CampaniaID = CA.CampaniaID
			AND PC.CUV = E.CUV2
		INNER JOIN Ods.ConsultorasProgramaNuevas CPN with(nolock) ON
			CPN.CodigoConsultora = @CodigoConsultora
			AND CPN.CodigoPrograma = TE.CodigoPrograma
	WHERE
		(E.CampaniaID = @CampaniaID OR @CampaniaID between E.CampaniaID and E.CampaniaIDFin)
		AND CPN.Participa = 1
		AND TE.FlagActivo = 1
		AND TE.flagNueva = 1
		AND E.Activo = 1
		AND E.Zona LIKE '%' + @ZonaID + '%'
		AND E.NumeroPedido = @NumeroPedido
	order by
		te.Orden ASC, CASE WHEN ISNULL(e.Orden,0) = 0 THEN te.Orden ELSE e.Orden END ASC, EstrategiaID ASC


SET NOCOUNT OFF
END
GO

USE BelcorpChile
GO

GO
ALTER PROCEDURE [dbo].[ListarEstrategiasPackNuevas]
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(30)
AS
/*
dbo.ListarEstrategiasPackNuevas 201715, '0001511'
*/
BEGIN
SET NOCOUNT ON;
	
	declare @ZonaID VARCHAR(20) = ''
	, @NumeroPedido INT = 0

	select @ZonaID = ZonaID
		, @NumeroPedido = ConsecutivoNueva + 1
	from ods.Consultora with(nolock)
	where Codigo = @CodigoConsultora

	SELECT
		EstrategiaID,
		CUV2,
		DescripcionCUV2,
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
		Precio,
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID2) EtiquetaDescripcion2,
		Precio2,
		TextoLibre,
		FlagEstrella,
		ColorFondo,
		e.TipoEstrategiaID,
		e.ImagenURL FotoProducto01,
		te.ImagenEstrategia ImagenURL,
		e.LimiteVenta,
		pc.MarcaID,
		te.Orden Orden1,
		e.Orden Orden2,
		pc.IndicadorMontoMinimo,
		pc.CodigoProducto,
		1 AS FlagNueva,
		'' as TipoTallaColor,
		2 as TipoEstrategiaImagenMostrar
		, E.EtiquetaID
		, E.EtiquetaID2
		, E.CodigoEstrategia
		, E.TieneVariedad
		, TE.CODIGO
		, TE.DescripcionEstrategia
		, ISNULL(TE.FlagMostrarImg,0) AS FlagMostrarImg
		, E.EsOfertaIndependiente
		, TE.ImagenOfertaIndependiente
		, TE.MostrarImgOfertaIndependiente
		, E.PrecioPublico
		, E.Ganancia
	FROM Estrategia E with(nolock)
		INNER JOIN TipoEstrategia TE with(nolock) ON
			E.TipoEstrategiaID = TE.TipoEstrategiaID
		INNER JOIN ods.Campania CA with(nolock) ON
			E.CampaniaID = CA.Codigo
		INNER JOIN ods.ProductoComercial PC with(nolock) ON
			PC.CampaniaID = CA.CampaniaID
			AND PC.CUV = E.CUV2
		INNER JOIN Ods.ConsultorasProgramaNuevas CPN with(nolock) ON
			CPN.CodigoConsultora = @CodigoConsultora
			AND CPN.CodigoPrograma = TE.CodigoPrograma
	WHERE
		(E.CampaniaID = @CampaniaID OR @CampaniaID between E.CampaniaID and E.CampaniaIDFin)
		AND CPN.Participa = 1
		AND TE.FlagActivo = 1
		AND TE.flagNueva = 1
		AND E.Activo = 1
		AND E.Zona LIKE '%' + @ZonaID + '%'
		AND E.NumeroPedido = @NumeroPedido
	order by
		te.Orden ASC, CASE WHEN ISNULL(e.Orden,0) = 0 THEN te.Orden ELSE e.Orden END ASC, EstrategiaID ASC


SET NOCOUNT OFF
END
GO

USE BelcorpBolivia
GO

GO
ALTER PROCEDURE [dbo].[ListarEstrategiasPackNuevas]
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(30)
AS
/*
dbo.ListarEstrategiasPackNuevas 201715, '0001511'
*/
BEGIN
SET NOCOUNT ON;
	
	declare @ZonaID VARCHAR(20) = ''
	, @NumeroPedido INT = 0

	select @ZonaID = ZonaID
		, @NumeroPedido = ConsecutivoNueva + 1
	from ods.Consultora with(nolock)
	where Codigo = @CodigoConsultora

	SELECT
		EstrategiaID,
		CUV2,
		DescripcionCUV2,
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
		Precio,
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID2) EtiquetaDescripcion2,
		Precio2,
		TextoLibre,
		FlagEstrella,
		ColorFondo,
		e.TipoEstrategiaID,
		e.ImagenURL FotoProducto01,
		te.ImagenEstrategia ImagenURL,
		e.LimiteVenta,
		pc.MarcaID,
		te.Orden Orden1,
		e.Orden Orden2,
		pc.IndicadorMontoMinimo,
		pc.CodigoProducto,
		1 AS FlagNueva,
		'' as TipoTallaColor,
		2 as TipoEstrategiaImagenMostrar
		, E.EtiquetaID
		, E.EtiquetaID2
		, E.CodigoEstrategia
		, E.TieneVariedad
		, TE.CODIGO
		, TE.DescripcionEstrategia
		, ISNULL(TE.FlagMostrarImg,0) AS FlagMostrarImg
		, E.EsOfertaIndependiente
		, TE.ImagenOfertaIndependiente
		, TE.MostrarImgOfertaIndependiente
		, E.PrecioPublico
		, E.Ganancia
	FROM Estrategia E with(nolock)
		INNER JOIN TipoEstrategia TE with(nolock) ON
			E.TipoEstrategiaID = TE.TipoEstrategiaID
		INNER JOIN ods.Campania CA with(nolock) ON
			E.CampaniaID = CA.Codigo
		INNER JOIN ods.ProductoComercial PC with(nolock) ON
			PC.CampaniaID = CA.CampaniaID
			AND PC.CUV = E.CUV2
		INNER JOIN Ods.ConsultorasProgramaNuevas CPN with(nolock) ON
			CPN.CodigoConsultora = @CodigoConsultora
			AND CPN.CodigoPrograma = TE.CodigoPrograma
	WHERE
		(E.CampaniaID = @CampaniaID OR @CampaniaID between E.CampaniaID and E.CampaniaIDFin)
		AND CPN.Participa = 1
		AND TE.FlagActivo = 1
		AND TE.flagNueva = 1
		AND E.Activo = 1
		AND E.Zona LIKE '%' + @ZonaID + '%'
		AND E.NumeroPedido = @NumeroPedido
	order by
		te.Orden ASC, CASE WHEN ISNULL(e.Orden,0) = 0 THEN te.Orden ELSE e.Orden END ASC, EstrategiaID ASC


SET NOCOUNT OFF
END
GO
