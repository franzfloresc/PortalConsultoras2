﻿USE BelcorpBolivia
GO
ALTER PROCEDURE [dbo].[ListarEstrategiasPackNuevas]
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(30)
AS
BEGIN
	SET NOCOUNT ON;
	
	declare
		@ZonaID VARCHAR(20) = '',
		@NumeroPedido INT = 0;

	select
		@ZonaID = ZonaID,
		@NumeroPedido = ConsecutivoNueva + 1
	from ods.Consultora with(nolock)
	where Codigo = @CodigoConsultora;

	SELECT * from (
		select distinct 
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
			2 as TipoEstrategiaImagenMostrar,
			E.EtiquetaID,
			E.EtiquetaID2,
			E.CodigoEstrategia,
			E.TieneVariedad,
			TE.CODIGO,
			TE.DescripcionEstrategia,
			ISNULL(TE.FlagMostrarImg,0) AS FlagMostrarImg,
			E.EsOfertaIndependiente,
			TE.ImagenOfertaIndependiente,
			TE.MostrarImgOfertaIndependiente,
			E.PrecioPublico,
			E.Ganancia,
			M.Descripcion AS DescripcionMarca
		FROM Estrategia E with(nolock)
			INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID AND TE.Codigo = '002'
			INNER JOIN ods.Campania CA with(nolock) ON @CampaniaID = CA.Codigo
			INNER JOIN ods.ProductoComercial PC with(nolock) ON	PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
			INNER JOIN Ods.ConsultorasProgramaNuevas CPN with(nolock) ON CPN.CodigoConsultora = @CodigoConsultora AND CPN.CodigoPrograma = TE.CodigoPrograma
			LEFT JOIN dbo.Marca M WITH (NOLOCK)	ON M.MarcaId = PC.MarcaId
		WHERE
			(E.CampaniaID = @CampaniaID OR @CampaniaID between E.CampaniaID and E.CampaniaIDFin)
			AND CPN.Participa = 1
			AND TE.FlagActivo = 1
			AND TE.flagNueva = 1
			AND E.Activo = 1
			AND E.Zona LIKE '%' + @ZonaID + '%'
			AND E.NumeroPedido = @NumeroPedido
	) as TablaTem
	order by
		Orden1 ASC,
		CASE WHEN ISNULL(Orden2,0) = 0 THEN Orden1 ELSE Orden2 END ASC,
		EstrategiaID ASC

	SET NOCOUNT OFF;
END
GO
/*end*/

USE BelcorpChile
GO
ALTER PROCEDURE [dbo].[ListarEstrategiasPackNuevas]
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(30)
AS
BEGIN
	SET NOCOUNT ON;
	
	declare
		@ZonaID VARCHAR(20) = '',
		@NumeroPedido INT = 0;

	select
		@ZonaID = ZonaID,
		@NumeroPedido = ConsecutivoNueva + 1
	from ods.Consultora with(nolock)
	where Codigo = @CodigoConsultora;

	SELECT * from (
		select distinct 
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
			2 as TipoEstrategiaImagenMostrar,
			E.EtiquetaID,
			E.EtiquetaID2,
			E.CodigoEstrategia,
			E.TieneVariedad,
			TE.CODIGO,
			TE.DescripcionEstrategia,
			ISNULL(TE.FlagMostrarImg,0) AS FlagMostrarImg,
			E.EsOfertaIndependiente,
			TE.ImagenOfertaIndependiente,
			TE.MostrarImgOfertaIndependiente,
			E.PrecioPublico,
			E.Ganancia,
			M.Descripcion AS DescripcionMarca
		FROM Estrategia E with(nolock)
			INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID AND TE.Codigo = '002'
			INNER JOIN ods.Campania CA with(nolock) ON @CampaniaID = CA.Codigo
			INNER JOIN ods.ProductoComercial PC with(nolock) ON	PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
			INNER JOIN Ods.ConsultorasProgramaNuevas CPN with(nolock) ON CPN.CodigoConsultora = @CodigoConsultora AND CPN.CodigoPrograma = TE.CodigoPrograma
			LEFT JOIN dbo.Marca M WITH (NOLOCK)	ON M.MarcaId = PC.MarcaId
		WHERE
			(E.CampaniaID = @CampaniaID OR @CampaniaID between E.CampaniaID and E.CampaniaIDFin)
			AND CPN.Participa = 1
			AND TE.FlagActivo = 1
			AND TE.flagNueva = 1
			AND E.Activo = 1
			AND E.Zona LIKE '%' + @ZonaID + '%'
			AND E.NumeroPedido = @NumeroPedido
	) as TablaTem
	order by
		Orden1 ASC,
		CASE WHEN ISNULL(Orden2,0) = 0 THEN Orden1 ELSE Orden2 END ASC,
		EstrategiaID ASC

	SET NOCOUNT OFF;
END
GO
/*end*/

USE BelcorpColombia
GO
ALTER PROCEDURE [dbo].[ListarEstrategiasPackNuevas]
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(30)
AS
BEGIN
	SET NOCOUNT ON;
	
	declare
		@ZonaID VARCHAR(20) = '',
		@NumeroPedido INT = 0;

	select
		@ZonaID = ZonaID,
		@NumeroPedido = ConsecutivoNueva + 1
	from ods.Consultora with(nolock)
	where Codigo = @CodigoConsultora;

	SELECT * from (
		select distinct 
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
			2 as TipoEstrategiaImagenMostrar,
			E.EtiquetaID,
			E.EtiquetaID2,
			E.CodigoEstrategia,
			E.TieneVariedad,
			TE.CODIGO,
			TE.DescripcionEstrategia,
			ISNULL(TE.FlagMostrarImg,0) AS FlagMostrarImg,
			E.EsOfertaIndependiente,
			TE.ImagenOfertaIndependiente,
			TE.MostrarImgOfertaIndependiente,
			E.PrecioPublico,
			E.Ganancia,
			M.Descripcion AS DescripcionMarca
		FROM Estrategia E with(nolock)
			INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID AND TE.Codigo = '002'
			INNER JOIN ods.Campania CA with(nolock) ON @CampaniaID = CA.Codigo
			INNER JOIN ods.ProductoComercial PC with(nolock) ON	PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
			INNER JOIN Ods.ConsultorasProgramaNuevas CPN with(nolock) ON CPN.CodigoConsultora = @CodigoConsultora AND CPN.CodigoPrograma = TE.CodigoPrograma
			LEFT JOIN dbo.Marca M WITH (NOLOCK)	ON M.MarcaId = PC.MarcaId
		WHERE
			(E.CampaniaID = @CampaniaID OR @CampaniaID between E.CampaniaID and E.CampaniaIDFin)
			AND CPN.Participa = 1
			AND TE.FlagActivo = 1
			AND TE.flagNueva = 1
			AND E.Activo = 1
			AND E.Zona LIKE '%' + @ZonaID + '%'
			AND E.NumeroPedido = @NumeroPedido
	) as TablaTem
	order by
		Orden1 ASC,
		CASE WHEN ISNULL(Orden2,0) = 0 THEN Orden1 ELSE Orden2 END ASC,
		EstrategiaID ASC

	SET NOCOUNT OFF;
END
GO
/*end*/

USE BelcorpCostaRica
GO
ALTER PROCEDURE [dbo].[ListarEstrategiasPackNuevas]
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(30)
AS
BEGIN
	SET NOCOUNT ON;
	
	declare
		@ZonaID VARCHAR(20) = '',
		@NumeroPedido INT = 0;

	select
		@ZonaID = ZonaID,
		@NumeroPedido = ConsecutivoNueva + 1
	from ods.Consultora with(nolock)
	where Codigo = @CodigoConsultora;

	SELECT * from (
		select distinct 
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
			2 as TipoEstrategiaImagenMostrar,
			E.EtiquetaID,
			E.EtiquetaID2,
			E.CodigoEstrategia,
			E.TieneVariedad,
			TE.CODIGO,
			TE.DescripcionEstrategia,
			ISNULL(TE.FlagMostrarImg,0) AS FlagMostrarImg,
			E.EsOfertaIndependiente,
			TE.ImagenOfertaIndependiente,
			TE.MostrarImgOfertaIndependiente,
			E.PrecioPublico,
			E.Ganancia,
			M.Descripcion AS DescripcionMarca
		FROM Estrategia E with(nolock)
			INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID AND TE.Codigo = '002'
			INNER JOIN ods.Campania CA with(nolock) ON @CampaniaID = CA.Codigo
			INNER JOIN ods.ProductoComercial PC with(nolock) ON	PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
			INNER JOIN Ods.ConsultorasProgramaNuevas CPN with(nolock) ON CPN.CodigoConsultora = @CodigoConsultora AND CPN.CodigoPrograma = TE.CodigoPrograma
			LEFT JOIN dbo.Marca M WITH (NOLOCK)	ON M.MarcaId = PC.MarcaId
		WHERE
			(E.CampaniaID = @CampaniaID OR @CampaniaID between E.CampaniaID and E.CampaniaIDFin)
			AND CPN.Participa = 1
			AND TE.FlagActivo = 1
			AND TE.flagNueva = 1
			AND E.Activo = 1
			AND E.Zona LIKE '%' + @ZonaID + '%'
			AND E.NumeroPedido = @NumeroPedido
	) as TablaTem
	order by
		Orden1 ASC,
		CASE WHEN ISNULL(Orden2,0) = 0 THEN Orden1 ELSE Orden2 END ASC,
		EstrategiaID ASC

	SET NOCOUNT OFF;
END
GO
/*end*/

USE BelcorpDominicana
GO
ALTER PROCEDURE [dbo].[ListarEstrategiasPackNuevas]
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(30)
AS
BEGIN
	SET NOCOUNT ON;
	
	declare
		@ZonaID VARCHAR(20) = '',
		@NumeroPedido INT = 0;

	select
		@ZonaID = ZonaID,
		@NumeroPedido = ConsecutivoNueva + 1
	from ods.Consultora with(nolock)
	where Codigo = @CodigoConsultora;

	SELECT * from (
		select distinct 
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
			2 as TipoEstrategiaImagenMostrar,
			E.EtiquetaID,
			E.EtiquetaID2,
			E.CodigoEstrategia,
			E.TieneVariedad,
			TE.CODIGO,
			TE.DescripcionEstrategia,
			ISNULL(TE.FlagMostrarImg,0) AS FlagMostrarImg,
			E.EsOfertaIndependiente,
			TE.ImagenOfertaIndependiente,
			TE.MostrarImgOfertaIndependiente,
			E.PrecioPublico,
			E.Ganancia,
			M.Descripcion AS DescripcionMarca
		FROM Estrategia E with(nolock)
			INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID AND TE.Codigo = '002'
			INNER JOIN ods.Campania CA with(nolock) ON @CampaniaID = CA.Codigo
			INNER JOIN ods.ProductoComercial PC with(nolock) ON	PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
			INNER JOIN Ods.ConsultorasProgramaNuevas CPN with(nolock) ON CPN.CodigoConsultora = @CodigoConsultora AND CPN.CodigoPrograma = TE.CodigoPrograma
			LEFT JOIN dbo.Marca M WITH (NOLOCK)	ON M.MarcaId = PC.MarcaId
		WHERE
			(E.CampaniaID = @CampaniaID OR @CampaniaID between E.CampaniaID and E.CampaniaIDFin)
			AND CPN.Participa = 1
			AND TE.FlagActivo = 1
			AND TE.flagNueva = 1
			AND E.Activo = 1
			AND E.Zona LIKE '%' + @ZonaID + '%'
			AND E.NumeroPedido = @NumeroPedido
	) as TablaTem
	order by
		Orden1 ASC,
		CASE WHEN ISNULL(Orden2,0) = 0 THEN Orden1 ELSE Orden2 END ASC,
		EstrategiaID ASC

	SET NOCOUNT OFF;
END
GO
/*end*/

USE BelcorpEcuador
GO
ALTER PROCEDURE [dbo].[ListarEstrategiasPackNuevas]
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(30)
AS
BEGIN
	SET NOCOUNT ON;
	
	declare
		@ZonaID VARCHAR(20) = '',
		@NumeroPedido INT = 0;

	select
		@ZonaID = ZonaID,
		@NumeroPedido = ConsecutivoNueva + 1
	from ods.Consultora with(nolock)
	where Codigo = @CodigoConsultora;

	SELECT * from (
		select distinct 
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
			2 as TipoEstrategiaImagenMostrar,
			E.EtiquetaID,
			E.EtiquetaID2,
			E.CodigoEstrategia,
			E.TieneVariedad,
			TE.CODIGO,
			TE.DescripcionEstrategia,
			ISNULL(TE.FlagMostrarImg,0) AS FlagMostrarImg,
			E.EsOfertaIndependiente,
			TE.ImagenOfertaIndependiente,
			TE.MostrarImgOfertaIndependiente,
			E.PrecioPublico,
			E.Ganancia,
			M.Descripcion AS DescripcionMarca
		FROM Estrategia E with(nolock)
			INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID AND TE.Codigo = '002'
			INNER JOIN ods.Campania CA with(nolock) ON @CampaniaID = CA.Codigo
			INNER JOIN ods.ProductoComercial PC with(nolock) ON	PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
			INNER JOIN Ods.ConsultorasProgramaNuevas CPN with(nolock) ON CPN.CodigoConsultora = @CodigoConsultora AND CPN.CodigoPrograma = TE.CodigoPrograma
			LEFT JOIN dbo.Marca M WITH (NOLOCK)	ON M.MarcaId = PC.MarcaId
		WHERE
			(E.CampaniaID = @CampaniaID OR @CampaniaID between E.CampaniaID and E.CampaniaIDFin)
			AND CPN.Participa = 1
			AND TE.FlagActivo = 1
			AND TE.flagNueva = 1
			AND E.Activo = 1
			AND E.Zona LIKE '%' + @ZonaID + '%'
			AND E.NumeroPedido = @NumeroPedido
	) as TablaTem
	order by
		Orden1 ASC,
		CASE WHEN ISNULL(Orden2,0) = 0 THEN Orden1 ELSE Orden2 END ASC,
		EstrategiaID ASC

	SET NOCOUNT OFF;
END
GO
/*end*/

USE BelcorpGuatemala
GO
ALTER PROCEDURE [dbo].[ListarEstrategiasPackNuevas]
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(30)
AS
BEGIN
	SET NOCOUNT ON;
	
	declare
		@ZonaID VARCHAR(20) = '',
		@NumeroPedido INT = 0;

	select
		@ZonaID = ZonaID,
		@NumeroPedido = ConsecutivoNueva + 1
	from ods.Consultora with(nolock)
	where Codigo = @CodigoConsultora;

	SELECT * from (
		select distinct 
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
			2 as TipoEstrategiaImagenMostrar,
			E.EtiquetaID,
			E.EtiquetaID2,
			E.CodigoEstrategia,
			E.TieneVariedad,
			TE.CODIGO,
			TE.DescripcionEstrategia,
			ISNULL(TE.FlagMostrarImg,0) AS FlagMostrarImg,
			E.EsOfertaIndependiente,
			TE.ImagenOfertaIndependiente,
			TE.MostrarImgOfertaIndependiente,
			E.PrecioPublico,
			E.Ganancia,
			M.Descripcion AS DescripcionMarca
		FROM Estrategia E with(nolock)
			INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID AND TE.Codigo = '002'
			INNER JOIN ods.Campania CA with(nolock) ON @CampaniaID = CA.Codigo
			INNER JOIN ods.ProductoComercial PC with(nolock) ON	PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
			INNER JOIN Ods.ConsultorasProgramaNuevas CPN with(nolock) ON CPN.CodigoConsultora = @CodigoConsultora AND CPN.CodigoPrograma = TE.CodigoPrograma
			LEFT JOIN dbo.Marca M WITH (NOLOCK)	ON M.MarcaId = PC.MarcaId
		WHERE
			(E.CampaniaID = @CampaniaID OR @CampaniaID between E.CampaniaID and E.CampaniaIDFin)
			AND CPN.Participa = 1
			AND TE.FlagActivo = 1
			AND TE.flagNueva = 1
			AND E.Activo = 1
			AND E.Zona LIKE '%' + @ZonaID + '%'
			AND E.NumeroPedido = @NumeroPedido
	) as TablaTem
	order by
		Orden1 ASC,
		CASE WHEN ISNULL(Orden2,0) = 0 THEN Orden1 ELSE Orden2 END ASC,
		EstrategiaID ASC

	SET NOCOUNT OFF;
END
GO
/*end*/

USE BelcorpMexico
GO
ALTER PROCEDURE [dbo].[ListarEstrategiasPackNuevas]
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(30)
AS
BEGIN
	SET NOCOUNT ON;
	
	declare
		@ZonaID VARCHAR(20) = '',
		@NumeroPedido INT = 0;

	select
		@ZonaID = ZonaID,
		@NumeroPedido = ConsecutivoNueva + 1
	from ods.Consultora with(nolock)
	where Codigo = @CodigoConsultora;

	SELECT * from (
		select distinct 
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
			2 as TipoEstrategiaImagenMostrar,
			E.EtiquetaID,
			E.EtiquetaID2,
			E.CodigoEstrategia,
			E.TieneVariedad,
			TE.CODIGO,
			TE.DescripcionEstrategia,
			ISNULL(TE.FlagMostrarImg,0) AS FlagMostrarImg,
			E.EsOfertaIndependiente,
			TE.ImagenOfertaIndependiente,
			TE.MostrarImgOfertaIndependiente,
			E.PrecioPublico,
			E.Ganancia,
			M.Descripcion AS DescripcionMarca
		FROM Estrategia E with(nolock)
			INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID AND TE.Codigo = '002'
			INNER JOIN ods.Campania CA with(nolock) ON @CampaniaID = CA.Codigo
			INNER JOIN ods.ProductoComercial PC with(nolock) ON	PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
			INNER JOIN Ods.ConsultorasProgramaNuevas CPN with(nolock) ON CPN.CodigoConsultora = @CodigoConsultora AND CPN.CodigoPrograma = TE.CodigoPrograma
			LEFT JOIN dbo.Marca M WITH (NOLOCK)	ON M.MarcaId = PC.MarcaId
		WHERE
			(E.CampaniaID = @CampaniaID OR @CampaniaID between E.CampaniaID and E.CampaniaIDFin)
			AND CPN.Participa = 1
			AND TE.FlagActivo = 1
			AND TE.flagNueva = 1
			AND E.Activo = 1
			AND E.Zona LIKE '%' + @ZonaID + '%'
			AND E.NumeroPedido = @NumeroPedido
	) as TablaTem
	order by
		Orden1 ASC,
		CASE WHEN ISNULL(Orden2,0) = 0 THEN Orden1 ELSE Orden2 END ASC,
		EstrategiaID ASC

	SET NOCOUNT OFF;
END
GO
/*end*/

USE BelcorpPanama
GO
ALTER PROCEDURE [dbo].[ListarEstrategiasPackNuevas]
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(30)
AS
BEGIN
	SET NOCOUNT ON;
	
	declare
		@ZonaID VARCHAR(20) = '',
		@NumeroPedido INT = 0;

	select
		@ZonaID = ZonaID,
		@NumeroPedido = ConsecutivoNueva + 1
	from ods.Consultora with(nolock)
	where Codigo = @CodigoConsultora;

	SELECT * from (
		select distinct 
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
			2 as TipoEstrategiaImagenMostrar,
			E.EtiquetaID,
			E.EtiquetaID2,
			E.CodigoEstrategia,
			E.TieneVariedad,
			TE.CODIGO,
			TE.DescripcionEstrategia,
			ISNULL(TE.FlagMostrarImg,0) AS FlagMostrarImg,
			E.EsOfertaIndependiente,
			TE.ImagenOfertaIndependiente,
			TE.MostrarImgOfertaIndependiente,
			E.PrecioPublico,
			E.Ganancia,
			M.Descripcion AS DescripcionMarca
		FROM Estrategia E with(nolock)
			INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID AND TE.Codigo = '002'
			INNER JOIN ods.Campania CA with(nolock) ON @CampaniaID = CA.Codigo
			INNER JOIN ods.ProductoComercial PC with(nolock) ON	PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
			INNER JOIN Ods.ConsultorasProgramaNuevas CPN with(nolock) ON CPN.CodigoConsultora = @CodigoConsultora AND CPN.CodigoPrograma = TE.CodigoPrograma
			LEFT JOIN dbo.Marca M WITH (NOLOCK)	ON M.MarcaId = PC.MarcaId
		WHERE
			(E.CampaniaID = @CampaniaID OR @CampaniaID between E.CampaniaID and E.CampaniaIDFin)
			AND CPN.Participa = 1
			AND TE.FlagActivo = 1
			AND TE.flagNueva = 1
			AND E.Activo = 1
			AND E.Zona LIKE '%' + @ZonaID + '%'
			AND E.NumeroPedido = @NumeroPedido
	) as TablaTem
	order by
		Orden1 ASC,
		CASE WHEN ISNULL(Orden2,0) = 0 THEN Orden1 ELSE Orden2 END ASC,
		EstrategiaID ASC

	SET NOCOUNT OFF;
END
GO
/*end*/

USE BelcorpPeru
GO
ALTER PROCEDURE [dbo].[ListarEstrategiasPackNuevas]
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(30)
AS
BEGIN
	SET NOCOUNT ON;
	
	declare
		@ZonaID VARCHAR(20) = '',
		@NumeroPedido INT = 0;

	select
		@ZonaID = ZonaID,
		@NumeroPedido = ConsecutivoNueva + 1
	from ods.Consultora with(nolock)
	where Codigo = @CodigoConsultora;

	SELECT * from (
		select distinct 
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
			2 as TipoEstrategiaImagenMostrar,
			E.EtiquetaID,
			E.EtiquetaID2,
			E.CodigoEstrategia,
			E.TieneVariedad,
			TE.CODIGO,
			TE.DescripcionEstrategia,
			ISNULL(TE.FlagMostrarImg,0) AS FlagMostrarImg,
			E.EsOfertaIndependiente,
			TE.ImagenOfertaIndependiente,
			TE.MostrarImgOfertaIndependiente,
			E.PrecioPublico,
			E.Ganancia,
			M.Descripcion AS DescripcionMarca
		FROM Estrategia E with(nolock)
			INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID AND TE.Codigo = '002'
			INNER JOIN ods.Campania CA with(nolock) ON @CampaniaID = CA.Codigo
			INNER JOIN ods.ProductoComercial PC with(nolock) ON	PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
			INNER JOIN Ods.ConsultorasProgramaNuevas CPN with(nolock) ON CPN.CodigoConsultora = @CodigoConsultora AND CPN.CodigoPrograma = TE.CodigoPrograma
			LEFT JOIN dbo.Marca M WITH (NOLOCK)	ON M.MarcaId = PC.MarcaId
		WHERE
			(E.CampaniaID = @CampaniaID OR @CampaniaID between E.CampaniaID and E.CampaniaIDFin)
			AND CPN.Participa = 1
			AND TE.FlagActivo = 1
			AND TE.flagNueva = 1
			AND E.Activo = 1
			AND E.Zona LIKE '%' + @ZonaID + '%'
			AND E.NumeroPedido = @NumeroPedido
	) as TablaTem
	order by
		Orden1 ASC,
		CASE WHEN ISNULL(Orden2,0) = 0 THEN Orden1 ELSE Orden2 END ASC,
		EstrategiaID ASC

	SET NOCOUNT OFF;
END
GO
/*end*/

USE BelcorpPuertoRico
GO
ALTER PROCEDURE [dbo].[ListarEstrategiasPackNuevas]
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(30)
AS
BEGIN
	SET NOCOUNT ON;
	
	declare
		@ZonaID VARCHAR(20) = '',
		@NumeroPedido INT = 0;

	select
		@ZonaID = ZonaID,
		@NumeroPedido = ConsecutivoNueva + 1
	from ods.Consultora with(nolock)
	where Codigo = @CodigoConsultora;

	SELECT * from (
		select distinct 
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
			2 as TipoEstrategiaImagenMostrar,
			E.EtiquetaID,
			E.EtiquetaID2,
			E.CodigoEstrategia,
			E.TieneVariedad,
			TE.CODIGO,
			TE.DescripcionEstrategia,
			ISNULL(TE.FlagMostrarImg,0) AS FlagMostrarImg,
			E.EsOfertaIndependiente,
			TE.ImagenOfertaIndependiente,
			TE.MostrarImgOfertaIndependiente,
			E.PrecioPublico,
			E.Ganancia,
			M.Descripcion AS DescripcionMarca
		FROM Estrategia E with(nolock)
			INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID AND TE.Codigo = '002'
			INNER JOIN ods.Campania CA with(nolock) ON @CampaniaID = CA.Codigo
			INNER JOIN ods.ProductoComercial PC with(nolock) ON	PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
			INNER JOIN Ods.ConsultorasProgramaNuevas CPN with(nolock) ON CPN.CodigoConsultora = @CodigoConsultora AND CPN.CodigoPrograma = TE.CodigoPrograma
			LEFT JOIN dbo.Marca M WITH (NOLOCK)	ON M.MarcaId = PC.MarcaId
		WHERE
			(E.CampaniaID = @CampaniaID OR @CampaniaID between E.CampaniaID and E.CampaniaIDFin)
			AND CPN.Participa = 1
			AND TE.FlagActivo = 1
			AND TE.flagNueva = 1
			AND E.Activo = 1
			AND E.Zona LIKE '%' + @ZonaID + '%'
			AND E.NumeroPedido = @NumeroPedido
	) as TablaTem
	order by
		Orden1 ASC,
		CASE WHEN ISNULL(Orden2,0) = 0 THEN Orden1 ELSE Orden2 END ASC,
		EstrategiaID ASC

	SET NOCOUNT OFF;
END
GO
/*end*/

USE BelcorpSalvador
GO
ALTER PROCEDURE [dbo].[ListarEstrategiasPackNuevas]
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(30)
AS
BEGIN
	SET NOCOUNT ON;
	
	declare
		@ZonaID VARCHAR(20) = '',
		@NumeroPedido INT = 0;

	select
		@ZonaID = ZonaID,
		@NumeroPedido = ConsecutivoNueva + 1
	from ods.Consultora with(nolock)
	where Codigo = @CodigoConsultora;

	SELECT * from (
		select distinct 
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
			2 as TipoEstrategiaImagenMostrar,
			E.EtiquetaID,
			E.EtiquetaID2,
			E.CodigoEstrategia,
			E.TieneVariedad,
			TE.CODIGO,
			TE.DescripcionEstrategia,
			ISNULL(TE.FlagMostrarImg,0) AS FlagMostrarImg,
			E.EsOfertaIndependiente,
			TE.ImagenOfertaIndependiente,
			TE.MostrarImgOfertaIndependiente,
			E.PrecioPublico,
			E.Ganancia,
			M.Descripcion AS DescripcionMarca
		FROM Estrategia E with(nolock)
			INNER JOIN TipoEstrategia TE with(nolock) ON E.TipoEstrategiaID = TE.TipoEstrategiaID AND TE.Codigo = '002'
			INNER JOIN ods.Campania CA with(nolock) ON @CampaniaID = CA.Codigo
			INNER JOIN ods.ProductoComercial PC with(nolock) ON	PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
			INNER JOIN Ods.ConsultorasProgramaNuevas CPN with(nolock) ON CPN.CodigoConsultora = @CodigoConsultora AND CPN.CodigoPrograma = TE.CodigoPrograma
			LEFT JOIN dbo.Marca M WITH (NOLOCK)	ON M.MarcaId = PC.MarcaId
		WHERE
			(E.CampaniaID = @CampaniaID OR @CampaniaID between E.CampaniaID and E.CampaniaIDFin)
			AND CPN.Participa = 1
			AND TE.FlagActivo = 1
			AND TE.flagNueva = 1
			AND E.Activo = 1
			AND E.Zona LIKE '%' + @ZonaID + '%'
			AND E.NumeroPedido = @NumeroPedido
	) as TablaTem
	order by
		Orden1 ASC,
		CASE WHEN ISNULL(Orden2,0) = 0 THEN Orden1 ELSE Orden2 END ASC,
		EstrategiaID ASC

	SET NOCOUNT OFF;
END
GO