USE BelcorpPeru
GO

ALTER PROCEDURE dbo.ListarTipoEstrategia_SB2 
@TipoEstrategiaID INT    
AS    
BEGIN    
	SET NOCOUNT ON   
  
	DECLARE @CodigoTipoEstrategia INT,
			@TipoEstrategiaIdLan INT,
			@TipoEstrategiaIdSimples INT,
			@TipoEstrategiaIdNiveles INT,
			@TipoEstrategiaIdGnd INT,
			@TipoEstrategiaIdOpt INT,
			@TipoEstrategiaIdSR INT,
			@TipoEstrategiaIdHv INT,
			@TipoEstrategiaIdLMG INT

	SET @CodigoTipoEstrategia = (SELECT TOP 1 TipoEstrategiaID FROM dbo.TipoEstrategia (NOLOCK) WHERE DescripcionEstrategia= 'Los m�s vendidos')  
	SET @TipoEstrategiaIdLan = (SELECT TOP 1 TipoEstrategiaID FROM dbo.TipoEstrategia (NOLOCK) WHERE Codigo = '005')  
	SET @TipoEstrategiaIdSimples = (SELECT TOP 1 TipoEstrategiaID FROM dbo.TipoEstrategia (NOLOCK) WHERE Codigo = '007')  
	SET @TipoEstrategiaIdNiveles = (SELECT TOP 1 TipoEstrategiaID FROM dbo.TipoEstrategia (NOLOCK) WHERE Codigo = '008')  
	SET @TipoEstrategiaIdGnd = (SELECT TOP 1 TipoEstrategiaID FROM dbo.TipoEstrategia (NOLOCK) WHERE Codigo = '010')  
	SET @TipoEstrategiaIdOpt = (SELECT TOP 1 TipoEstrategiaID FROM dbo.TipoEstrategia (NOLOCK) WHERE Codigo = '001')  
	SET @TipoEstrategiaIdSR = (SELECT TOP 1 TipoEstrategiaID FROM dbo.TipoEstrategia (NOLOCK) WHERE Codigo = '030')  
	SET @TipoEstrategiaIdHv = (SELECT TOP 1 TipoEstrategiaID FROM dbo.TipoEstrategia (NOLOCK) WHERE Codigo = '011')  
	SET @TipoEstrategiaIdLMG = (SELECT TOP 1 TipoEstrategiaID FROM dbo.TipoEstrategia (NOLOCK) WHERE Codigo = 'LMG')
  
	IF @TipoEstrategiaID = 0
		SET @TipoEstrategiaID = NULL

	SELECT     
		TipoEstrategiaID,     
		DescripcionEstrategia,     
		ISNULL(dbo.ObtenerDescripcionOferta(TipoEstrategiaID),'') AS DescripcionOferta,    
		Orden,     
		FlagActivo,     
		ISNULL(CodigoPrograma,'') AS CodigoPrograma,  
		ISNULL(dbo.ObtenerOfertaID(TipoEstrategiaID),'') AS OfertaID,    
		ImagenEstrategia,    
		FlagNueva,    
		FlagRecoPerfil,    
		FlagRecoProduc,   
		ISNULL(FlagMostrarImg,0) AS FlagMostrarImg,  
		CASE TipoEstrategiaID  
		WHEN 10 THEN 1  
		WHEN 1009 THEN 2  
		WHEN 2009 THEN 3  
		WHEN @TipoEstrategiaIdOpt THEN 4  
		WHEN 3011 THEN 5  
		WHEN 3012 THEN 6  
		WHEN 3014 THEN 7  
		WHEN 3015 THEN 8  
		WHEN @TipoEstrategiaIdLan THEN 9  
		WHEN @TipoEstrategiaIdSimples THEN 10  
		WHEN @TipoEstrategiaIdLMG THEN 10  
		WHEN @TipoEstrategiaIdNiveles THEN 11  
		WHEN @TipoEstrategiaIdGnd THEN 12  
		WHEN @TipoEstrategiaIdHv THEN 13  
		WHEN @CodigoTipoEstrategia THEN 20  
		WHEN @TipoEstrategiaIdSR THEN 30  
		END AS CodigoGeneral,  
		Codigo  
		, MostrarImgOfertaIndependiente  
		, ImagenOfertaIndependiente  
		, FlagValidarImagen  
		,PesoMaximoImagen
		,MensajeValidacion
		,NombreComercial
	FROM dbo.TipoEstrategia (NOLOCK)
	WHERE TipoEstrategiaID = ISNULL(@TipoEstrategiaID, TipoEstrategiaID)
	ORDER BY Orden, DescripcionEstrategia   
	 
	SET NOCOUNT OFF    
END   
GO

USE BelcorpMexico
GO

ALTER PROCEDURE dbo.ListarTipoEstrategia_SB2 
@TipoEstrategiaID INT    
AS    
BEGIN    
	SET NOCOUNT ON   
  
	DECLARE @CodigoTipoEstrategia INT,
			@TipoEstrategiaIdLan INT,
			@TipoEstrategiaIdSimples INT,
			@TipoEstrategiaIdNiveles INT,
			@TipoEstrategiaIdGnd INT,
			@TipoEstrategiaIdOpt INT,
			@TipoEstrategiaIdSR INT,
			@TipoEstrategiaIdHv INT,
			@TipoEstrategiaIdLMG INT

	SET @CodigoTipoEstrategia = (SELECT TOP 1 TipoEstrategiaID FROM dbo.TipoEstrategia (NOLOCK) WHERE DescripcionEstrategia= 'Los m�s vendidos')  
	SET @TipoEstrategiaIdLan = (SELECT TOP 1 TipoEstrategiaID FROM dbo.TipoEstrategia (NOLOCK) WHERE Codigo = '005')  
	SET @TipoEstrategiaIdSimples = (SELECT TOP 1 TipoEstrategiaID FROM dbo.TipoEstrategia (NOLOCK) WHERE Codigo = '007')  
	SET @TipoEstrategiaIdNiveles = (SELECT TOP 1 TipoEstrategiaID FROM dbo.TipoEstrategia (NOLOCK) WHERE Codigo = '008')  
	SET @TipoEstrategiaIdGnd = (SELECT TOP 1 TipoEstrategiaID FROM dbo.TipoEstrategia (NOLOCK) WHERE Codigo = '010')  
	SET @TipoEstrategiaIdOpt = (SELECT TOP 1 TipoEstrategiaID FROM dbo.TipoEstrategia (NOLOCK) WHERE Codigo = '001')  
	SET @TipoEstrategiaIdSR = (SELECT TOP 1 TipoEstrategiaID FROM dbo.TipoEstrategia (NOLOCK) WHERE Codigo = '030')  
	SET @TipoEstrategiaIdHv = (SELECT TOP 1 TipoEstrategiaID FROM dbo.TipoEstrategia (NOLOCK) WHERE Codigo = '011')  
	SET @TipoEstrategiaIdLMG = (SELECT TOP 1 TipoEstrategiaID FROM dbo.TipoEstrategia (NOLOCK) WHERE Codigo = 'LMG')
  
	IF @TipoEstrategiaID = 0
		SET @TipoEstrategiaID = NULL

	SELECT     
		TipoEstrategiaID,     
		DescripcionEstrategia,     
		ISNULL(dbo.ObtenerDescripcionOferta(TipoEstrategiaID),'') AS DescripcionOferta,    
		Orden,     
		FlagActivo,     
		ISNULL(CodigoPrograma,'') AS CodigoPrograma,  
		ISNULL(dbo.ObtenerOfertaID(TipoEstrategiaID),'') AS OfertaID,    
		ImagenEstrategia,    
		FlagNueva,    
		FlagRecoPerfil,    
		FlagRecoProduc,   
		ISNULL(FlagMostrarImg,0) AS FlagMostrarImg,  
		CASE TipoEstrategiaID  
		WHEN 10 THEN 1  
		WHEN 1009 THEN 2  
		WHEN 2009 THEN 3  
		WHEN @TipoEstrategiaIdOpt THEN 4  
		WHEN 3011 THEN 5  
		WHEN 3012 THEN 6  
		WHEN 3014 THEN 7  
		WHEN 3015 THEN 8  
		WHEN @TipoEstrategiaIdLan THEN 9  
		WHEN @TipoEstrategiaIdSimples THEN 10  
		WHEN @TipoEstrategiaIdLMG THEN 10  
		WHEN @TipoEstrategiaIdNiveles THEN 11  
		WHEN @TipoEstrategiaIdGnd THEN 12  
		WHEN @TipoEstrategiaIdHv THEN 13  
		WHEN @CodigoTipoEstrategia THEN 20  
		WHEN @TipoEstrategiaIdSR THEN 30  
		END AS CodigoGeneral,  
		Codigo  
		, MostrarImgOfertaIndependiente  
		, ImagenOfertaIndependiente  
		, FlagValidarImagen  
		,PesoMaximoImagen
		,MensajeValidacion
		,NombreComercial
	FROM dbo.TipoEstrategia (NOLOCK)
	WHERE TipoEstrategiaID = ISNULL(@TipoEstrategiaID, TipoEstrategiaID)
	ORDER BY Orden, DescripcionEstrategia   
	 
	SET NOCOUNT OFF    
END   
GO

USE BelcorpColombia
GO

ALTER PROCEDURE dbo.ListarTipoEstrategia_SB2 
@TipoEstrategiaID INT    
AS    
BEGIN    
	SET NOCOUNT ON   
  
	DECLARE @CodigoTipoEstrategia INT,
			@TipoEstrategiaIdLan INT,
			@TipoEstrategiaIdSimples INT,
			@TipoEstrategiaIdNiveles INT,
			@TipoEstrategiaIdGnd INT,
			@TipoEstrategiaIdOpt INT,
			@TipoEstrategiaIdSR INT,
			@TipoEstrategiaIdHv INT,
			@TipoEstrategiaIdLMG INT

	SET @CodigoTipoEstrategia = (SELECT TOP 1 TipoEstrategiaID FROM dbo.TipoEstrategia (NOLOCK) WHERE DescripcionEstrategia= 'Los m�s vendidos')  
	SET @TipoEstrategiaIdLan = (SELECT TOP 1 TipoEstrategiaID FROM dbo.TipoEstrategia (NOLOCK) WHERE Codigo = '005')  
	SET @TipoEstrategiaIdSimples = (SELECT TOP 1 TipoEstrategiaID FROM dbo.TipoEstrategia (NOLOCK) WHERE Codigo = '007')  
	SET @TipoEstrategiaIdNiveles = (SELECT TOP 1 TipoEstrategiaID FROM dbo.TipoEstrategia (NOLOCK) WHERE Codigo = '008')  
	SET @TipoEstrategiaIdGnd = (SELECT TOP 1 TipoEstrategiaID FROM dbo.TipoEstrategia (NOLOCK) WHERE Codigo = '010')  
	SET @TipoEstrategiaIdOpt = (SELECT TOP 1 TipoEstrategiaID FROM dbo.TipoEstrategia (NOLOCK) WHERE Codigo = '001')  
	SET @TipoEstrategiaIdSR = (SELECT TOP 1 TipoEstrategiaID FROM dbo.TipoEstrategia (NOLOCK) WHERE Codigo = '030')  
	SET @TipoEstrategiaIdHv = (SELECT TOP 1 TipoEstrategiaID FROM dbo.TipoEstrategia (NOLOCK) WHERE Codigo = '011')  
	SET @TipoEstrategiaIdLMG = (SELECT TOP 1 TipoEstrategiaID FROM dbo.TipoEstrategia (NOLOCK) WHERE Codigo = 'LMG')
  
	IF @TipoEstrategiaID = 0
		SET @TipoEstrategiaID = NULL

	SELECT     
		TipoEstrategiaID,     
		DescripcionEstrategia,     
		ISNULL(dbo.ObtenerDescripcionOferta(TipoEstrategiaID),'') AS DescripcionOferta,    
		Orden,     
		FlagActivo,     
		ISNULL(CodigoPrograma,'') AS CodigoPrograma,  
		ISNULL(dbo.ObtenerOfertaID(TipoEstrategiaID),'') AS OfertaID,    
		ImagenEstrategia,    
		FlagNueva,    
		FlagRecoPerfil,    
		FlagRecoProduc,   
		ISNULL(FlagMostrarImg,0) AS FlagMostrarImg,  
		CASE TipoEstrategiaID  
		WHEN 10 THEN 1  
		WHEN 1009 THEN 2  
		WHEN 2009 THEN 3  
		WHEN @TipoEstrategiaIdOpt THEN 4  
		WHEN 3011 THEN 5  
		WHEN 3012 THEN 6  
		WHEN 3014 THEN 7  
		WHEN 3015 THEN 8  
		WHEN @TipoEstrategiaIdLan THEN 9  
		WHEN @TipoEstrategiaIdSimples THEN 10  
		WHEN @TipoEstrategiaIdLMG THEN 10  
		WHEN @TipoEstrategiaIdNiveles THEN 11  
		WHEN @TipoEstrategiaIdGnd THEN 12  
		WHEN @TipoEstrategiaIdHv THEN 13  
		WHEN @CodigoTipoEstrategia THEN 20  
		WHEN @TipoEstrategiaIdSR THEN 30  
		END AS CodigoGeneral,  
		Codigo  
		, MostrarImgOfertaIndependiente  
		, ImagenOfertaIndependiente  
		, FlagValidarImagen  
		,PesoMaximoImagen
		,MensajeValidacion
		,NombreComercial
	FROM dbo.TipoEstrategia (NOLOCK)
	WHERE TipoEstrategiaID = ISNULL(@TipoEstrategiaID, TipoEstrategiaID)
	ORDER BY Orden, DescripcionEstrategia   
	 
	SET NOCOUNT OFF    
END   
GO

USE BelcorpSalvador
GO

ALTER PROCEDURE dbo.ListarTipoEstrategia_SB2 
@TipoEstrategiaID INT    
AS    
BEGIN    
	SET NOCOUNT ON   
  
	DECLARE @CodigoTipoEstrategia INT,
			@TipoEstrategiaIdLan INT,
			@TipoEstrategiaIdSimples INT,
			@TipoEstrategiaIdNiveles INT,
			@TipoEstrategiaIdGnd INT,
			@TipoEstrategiaIdOpt INT,
			@TipoEstrategiaIdSR INT,
			@TipoEstrategiaIdHv INT,
			@TipoEstrategiaIdLMG INT

	SET @CodigoTipoEstrategia = (SELECT TOP 1 TipoEstrategiaID FROM dbo.TipoEstrategia (NOLOCK) WHERE DescripcionEstrategia= 'Los m�s vendidos')  
	SET @TipoEstrategiaIdLan = (SELECT TOP 1 TipoEstrategiaID FROM dbo.TipoEstrategia (NOLOCK) WHERE Codigo = '005')  
	SET @TipoEstrategiaIdSimples = (SELECT TOP 1 TipoEstrategiaID FROM dbo.TipoEstrategia (NOLOCK) WHERE Codigo = '007')  
	SET @TipoEstrategiaIdNiveles = (SELECT TOP 1 TipoEstrategiaID FROM dbo.TipoEstrategia (NOLOCK) WHERE Codigo = '008')  
	SET @TipoEstrategiaIdGnd = (SELECT TOP 1 TipoEstrategiaID FROM dbo.TipoEstrategia (NOLOCK) WHERE Codigo = '010')  
	SET @TipoEstrategiaIdOpt = (SELECT TOP 1 TipoEstrategiaID FROM dbo.TipoEstrategia (NOLOCK) WHERE Codigo = '001')  
	SET @TipoEstrategiaIdSR = (SELECT TOP 1 TipoEstrategiaID FROM dbo.TipoEstrategia (NOLOCK) WHERE Codigo = '030')  
	SET @TipoEstrategiaIdHv = (SELECT TOP 1 TipoEstrategiaID FROM dbo.TipoEstrategia (NOLOCK) WHERE Codigo = '011')  
	SET @TipoEstrategiaIdLMG = (SELECT TOP 1 TipoEstrategiaID FROM dbo.TipoEstrategia (NOLOCK) WHERE Codigo = 'LMG')
  
	IF @TipoEstrategiaID = 0
		SET @TipoEstrategiaID = NULL

	SELECT     
		TipoEstrategiaID,     
		DescripcionEstrategia,     
		ISNULL(dbo.ObtenerDescripcionOferta(TipoEstrategiaID),'') AS DescripcionOferta,    
		Orden,     
		FlagActivo,     
		ISNULL(CodigoPrograma,'') AS CodigoPrograma,  
		ISNULL(dbo.ObtenerOfertaID(TipoEstrategiaID),'') AS OfertaID,    
		ImagenEstrategia,    
		FlagNueva,    
		FlagRecoPerfil,    
		FlagRecoProduc,   
		ISNULL(FlagMostrarImg,0) AS FlagMostrarImg,  
		CASE TipoEstrategiaID  
		WHEN 10 THEN 1  
		WHEN 1009 THEN 2  
		WHEN 2009 THEN 3  
		WHEN @TipoEstrategiaIdOpt THEN 4  
		WHEN 3011 THEN 5  
		WHEN 3012 THEN 6  
		WHEN 3014 THEN 7  
		WHEN 3015 THEN 8  
		WHEN @TipoEstrategiaIdLan THEN 9  
		WHEN @TipoEstrategiaIdSimples THEN 10  
		WHEN @TipoEstrategiaIdLMG THEN 10  
		WHEN @TipoEstrategiaIdNiveles THEN 11  
		WHEN @TipoEstrategiaIdGnd THEN 12  
		WHEN @TipoEstrategiaIdHv THEN 13  
		WHEN @CodigoTipoEstrategia THEN 20  
		WHEN @TipoEstrategiaIdSR THEN 30  
		END AS CodigoGeneral,  
		Codigo  
		, MostrarImgOfertaIndependiente  
		, ImagenOfertaIndependiente  
		, FlagValidarImagen  
		,PesoMaximoImagen
		,MensajeValidacion
		,NombreComercial
	FROM dbo.TipoEstrategia (NOLOCK)
	WHERE TipoEstrategiaID = ISNULL(@TipoEstrategiaID, TipoEstrategiaID)
	ORDER BY Orden, DescripcionEstrategia   
	 
	SET NOCOUNT OFF    
END   
GO

USE BelcorpPuertoRico
GO

ALTER PROCEDURE dbo.ListarTipoEstrategia_SB2 
@TipoEstrategiaID INT    
AS    
BEGIN    
	SET NOCOUNT ON   
  
	DECLARE @CodigoTipoEstrategia INT,
			@TipoEstrategiaIdLan INT,
			@TipoEstrategiaIdSimples INT,
			@TipoEstrategiaIdNiveles INT,
			@TipoEstrategiaIdGnd INT,
			@TipoEstrategiaIdOpt INT,
			@TipoEstrategiaIdSR INT,
			@TipoEstrategiaIdHv INT,
			@TipoEstrategiaIdLMG INT

	SET @CodigoTipoEstrategia = (SELECT TOP 1 TipoEstrategiaID FROM dbo.TipoEstrategia (NOLOCK) WHERE DescripcionEstrategia= 'Los m�s vendidos')  
	SET @TipoEstrategiaIdLan = (SELECT TOP 1 TipoEstrategiaID FROM dbo.TipoEstrategia (NOLOCK) WHERE Codigo = '005')  
	SET @TipoEstrategiaIdSimples = (SELECT TOP 1 TipoEstrategiaID FROM dbo.TipoEstrategia (NOLOCK) WHERE Codigo = '007')  
	SET @TipoEstrategiaIdNiveles = (SELECT TOP 1 TipoEstrategiaID FROM dbo.TipoEstrategia (NOLOCK) WHERE Codigo = '008')  
	SET @TipoEstrategiaIdGnd = (SELECT TOP 1 TipoEstrategiaID FROM dbo.TipoEstrategia (NOLOCK) WHERE Codigo = '010')  
	SET @TipoEstrategiaIdOpt = (SELECT TOP 1 TipoEstrategiaID FROM dbo.TipoEstrategia (NOLOCK) WHERE Codigo = '001')  
	SET @TipoEstrategiaIdSR = (SELECT TOP 1 TipoEstrategiaID FROM dbo.TipoEstrategia (NOLOCK) WHERE Codigo = '030')  
	SET @TipoEstrategiaIdHv = (SELECT TOP 1 TipoEstrategiaID FROM dbo.TipoEstrategia (NOLOCK) WHERE Codigo = '011')  
	SET @TipoEstrategiaIdLMG = (SELECT TOP 1 TipoEstrategiaID FROM dbo.TipoEstrategia (NOLOCK) WHERE Codigo = 'LMG')
  
	IF @TipoEstrategiaID = 0
		SET @TipoEstrategiaID = NULL

	SELECT     
		TipoEstrategiaID,     
		DescripcionEstrategia,     
		ISNULL(dbo.ObtenerDescripcionOferta(TipoEstrategiaID),'') AS DescripcionOferta,    
		Orden,     
		FlagActivo,     
		ISNULL(CodigoPrograma,'') AS CodigoPrograma,  
		ISNULL(dbo.ObtenerOfertaID(TipoEstrategiaID),'') AS OfertaID,    
		ImagenEstrategia,    
		FlagNueva,    
		FlagRecoPerfil,    
		FlagRecoProduc,   
		ISNULL(FlagMostrarImg,0) AS FlagMostrarImg,  
		CASE TipoEstrategiaID  
		WHEN 10 THEN 1  
		WHEN 1009 THEN 2  
		WHEN 2009 THEN 3  
		WHEN @TipoEstrategiaIdOpt THEN 4  
		WHEN 3011 THEN 5  
		WHEN 3012 THEN 6  
		WHEN 3014 THEN 7  
		WHEN 3015 THEN 8  
		WHEN @TipoEstrategiaIdLan THEN 9  
		WHEN @TipoEstrategiaIdSimples THEN 10  
		WHEN @TipoEstrategiaIdLMG THEN 10  
		WHEN @TipoEstrategiaIdNiveles THEN 11  
		WHEN @TipoEstrategiaIdGnd THEN 12  
		WHEN @TipoEstrategiaIdHv THEN 13  
		WHEN @CodigoTipoEstrategia THEN 20  
		WHEN @TipoEstrategiaIdSR THEN 30  
		END AS CodigoGeneral,  
		Codigo  
		, MostrarImgOfertaIndependiente  
		, ImagenOfertaIndependiente  
		, FlagValidarImagen  
		,PesoMaximoImagen
		,MensajeValidacion
		,NombreComercial
	FROM dbo.TipoEstrategia (NOLOCK)
	WHERE TipoEstrategiaID = ISNULL(@TipoEstrategiaID, TipoEstrategiaID)
	ORDER BY Orden, DescripcionEstrategia   
	 
	SET NOCOUNT OFF    
END   
GO

USE BelcorpPanama
GO

ALTER PROCEDURE dbo.ListarTipoEstrategia_SB2 
@TipoEstrategiaID INT    
AS    
BEGIN    
	SET NOCOUNT ON   
  
	DECLARE @CodigoTipoEstrategia INT,
			@TipoEstrategiaIdLan INT,
			@TipoEstrategiaIdSimples INT,
			@TipoEstrategiaIdNiveles INT,
			@TipoEstrategiaIdGnd INT,
			@TipoEstrategiaIdOpt INT,
			@TipoEstrategiaIdSR INT,
			@TipoEstrategiaIdHv INT,
			@TipoEstrategiaIdLMG INT

	SET @CodigoTipoEstrategia = (SELECT TOP 1 TipoEstrategiaID FROM dbo.TipoEstrategia (NOLOCK) WHERE DescripcionEstrategia= 'Los m�s vendidos')  
	SET @TipoEstrategiaIdLan = (SELECT TOP 1 TipoEstrategiaID FROM dbo.TipoEstrategia (NOLOCK) WHERE Codigo = '005')  
	SET @TipoEstrategiaIdSimples = (SELECT TOP 1 TipoEstrategiaID FROM dbo.TipoEstrategia (NOLOCK) WHERE Codigo = '007')  
	SET @TipoEstrategiaIdNiveles = (SELECT TOP 1 TipoEstrategiaID FROM dbo.TipoEstrategia (NOLOCK) WHERE Codigo = '008')  
	SET @TipoEstrategiaIdGnd = (SELECT TOP 1 TipoEstrategiaID FROM dbo.TipoEstrategia (NOLOCK) WHERE Codigo = '010')  
	SET @TipoEstrategiaIdOpt = (SELECT TOP 1 TipoEstrategiaID FROM dbo.TipoEstrategia (NOLOCK) WHERE Codigo = '001')  
	SET @TipoEstrategiaIdSR = (SELECT TOP 1 TipoEstrategiaID FROM dbo.TipoEstrategia (NOLOCK) WHERE Codigo = '030')  
	SET @TipoEstrategiaIdHv = (SELECT TOP 1 TipoEstrategiaID FROM dbo.TipoEstrategia (NOLOCK) WHERE Codigo = '011')  
	SET @TipoEstrategiaIdLMG = (SELECT TOP 1 TipoEstrategiaID FROM dbo.TipoEstrategia (NOLOCK) WHERE Codigo = 'LMG')
  
	IF @TipoEstrategiaID = 0
		SET @TipoEstrategiaID = NULL

	SELECT     
		TipoEstrategiaID,     
		DescripcionEstrategia,     
		ISNULL(dbo.ObtenerDescripcionOferta(TipoEstrategiaID),'') AS DescripcionOferta,    
		Orden,     
		FlagActivo,     
		ISNULL(CodigoPrograma,'') AS CodigoPrograma,  
		ISNULL(dbo.ObtenerOfertaID(TipoEstrategiaID),'') AS OfertaID,    
		ImagenEstrategia,    
		FlagNueva,    
		FlagRecoPerfil,    
		FlagRecoProduc,   
		ISNULL(FlagMostrarImg,0) AS FlagMostrarImg,  
		CASE TipoEstrategiaID  
		WHEN 10 THEN 1  
		WHEN 1009 THEN 2  
		WHEN 2009 THEN 3  
		WHEN @TipoEstrategiaIdOpt THEN 4  
		WHEN 3011 THEN 5  
		WHEN 3012 THEN 6  
		WHEN 3014 THEN 7  
		WHEN 3015 THEN 8  
		WHEN @TipoEstrategiaIdLan THEN 9  
		WHEN @TipoEstrategiaIdSimples THEN 10  
		WHEN @TipoEstrategiaIdLMG THEN 10  
		WHEN @TipoEstrategiaIdNiveles THEN 11  
		WHEN @TipoEstrategiaIdGnd THEN 12  
		WHEN @TipoEstrategiaIdHv THEN 13  
		WHEN @CodigoTipoEstrategia THEN 20  
		WHEN @TipoEstrategiaIdSR THEN 30  
		END AS CodigoGeneral,  
		Codigo  
		, MostrarImgOfertaIndependiente  
		, ImagenOfertaIndependiente  
		, FlagValidarImagen  
		,PesoMaximoImagen
		,MensajeValidacion
		,NombreComercial
	FROM dbo.TipoEstrategia (NOLOCK)
	WHERE TipoEstrategiaID = ISNULL(@TipoEstrategiaID, TipoEstrategiaID)
	ORDER BY Orden, DescripcionEstrategia   
	 
	SET NOCOUNT OFF    
END   
GO

USE BelcorpGuatemala
GO

ALTER PROCEDURE dbo.ListarTipoEstrategia_SB2 
@TipoEstrategiaID INT    
AS    
BEGIN    
	SET NOCOUNT ON   
  
	DECLARE @CodigoTipoEstrategia INT,
			@TipoEstrategiaIdLan INT,
			@TipoEstrategiaIdSimples INT,
			@TipoEstrategiaIdNiveles INT,
			@TipoEstrategiaIdGnd INT,
			@TipoEstrategiaIdOpt INT,
			@TipoEstrategiaIdSR INT,
			@TipoEstrategiaIdHv INT,
			@TipoEstrategiaIdLMG INT

	SET @CodigoTipoEstrategia = (SELECT TOP 1 TipoEstrategiaID FROM dbo.TipoEstrategia (NOLOCK) WHERE DescripcionEstrategia= 'Los m�s vendidos')  
	SET @TipoEstrategiaIdLan = (SELECT TOP 1 TipoEstrategiaID FROM dbo.TipoEstrategia (NOLOCK) WHERE Codigo = '005')  
	SET @TipoEstrategiaIdSimples = (SELECT TOP 1 TipoEstrategiaID FROM dbo.TipoEstrategia (NOLOCK) WHERE Codigo = '007')  
	SET @TipoEstrategiaIdNiveles = (SELECT TOP 1 TipoEstrategiaID FROM dbo.TipoEstrategia (NOLOCK) WHERE Codigo = '008')  
	SET @TipoEstrategiaIdGnd = (SELECT TOP 1 TipoEstrategiaID FROM dbo.TipoEstrategia (NOLOCK) WHERE Codigo = '010')  
	SET @TipoEstrategiaIdOpt = (SELECT TOP 1 TipoEstrategiaID FROM dbo.TipoEstrategia (NOLOCK) WHERE Codigo = '001')  
	SET @TipoEstrategiaIdSR = (SELECT TOP 1 TipoEstrategiaID FROM dbo.TipoEstrategia (NOLOCK) WHERE Codigo = '030')  
	SET @TipoEstrategiaIdHv = (SELECT TOP 1 TipoEstrategiaID FROM dbo.TipoEstrategia (NOLOCK) WHERE Codigo = '011')  
	SET @TipoEstrategiaIdLMG = (SELECT TOP 1 TipoEstrategiaID FROM dbo.TipoEstrategia (NOLOCK) WHERE Codigo = 'LMG')
  
	IF @TipoEstrategiaID = 0
		SET @TipoEstrategiaID = NULL

	SELECT     
		TipoEstrategiaID,     
		DescripcionEstrategia,     
		ISNULL(dbo.ObtenerDescripcionOferta(TipoEstrategiaID),'') AS DescripcionOferta,    
		Orden,     
		FlagActivo,     
		ISNULL(CodigoPrograma,'') AS CodigoPrograma,  
		ISNULL(dbo.ObtenerOfertaID(TipoEstrategiaID),'') AS OfertaID,    
		ImagenEstrategia,    
		FlagNueva,    
		FlagRecoPerfil,    
		FlagRecoProduc,   
		ISNULL(FlagMostrarImg,0) AS FlagMostrarImg,  
		CASE TipoEstrategiaID  
		WHEN 10 THEN 1  
		WHEN 1009 THEN 2  
		WHEN 2009 THEN 3  
		WHEN @TipoEstrategiaIdOpt THEN 4  
		WHEN 3011 THEN 5  
		WHEN 3012 THEN 6  
		WHEN 3014 THEN 7  
		WHEN 3015 THEN 8  
		WHEN @TipoEstrategiaIdLan THEN 9  
		WHEN @TipoEstrategiaIdSimples THEN 10  
		WHEN @TipoEstrategiaIdLMG THEN 10  
		WHEN @TipoEstrategiaIdNiveles THEN 11  
		WHEN @TipoEstrategiaIdGnd THEN 12  
		WHEN @TipoEstrategiaIdHv THEN 13  
		WHEN @CodigoTipoEstrategia THEN 20  
		WHEN @TipoEstrategiaIdSR THEN 30  
		END AS CodigoGeneral,  
		Codigo  
		, MostrarImgOfertaIndependiente  
		, ImagenOfertaIndependiente  
		, FlagValidarImagen  
		,PesoMaximoImagen
		,MensajeValidacion
		,NombreComercial
	FROM dbo.TipoEstrategia (NOLOCK)
	WHERE TipoEstrategiaID = ISNULL(@TipoEstrategiaID, TipoEstrategiaID)
	ORDER BY Orden, DescripcionEstrategia   
	 
	SET NOCOUNT OFF    
END   
GO

USE BelcorpEcuador
GO

ALTER PROCEDURE dbo.ListarTipoEstrategia_SB2 
@TipoEstrategiaID INT    
AS    
BEGIN    
	SET NOCOUNT ON   
  
	DECLARE @CodigoTipoEstrategia INT,
			@TipoEstrategiaIdLan INT,
			@TipoEstrategiaIdSimples INT,
			@TipoEstrategiaIdNiveles INT,
			@TipoEstrategiaIdGnd INT,
			@TipoEstrategiaIdOpt INT,
			@TipoEstrategiaIdSR INT,
			@TipoEstrategiaIdHv INT,
			@TipoEstrategiaIdLMG INT

	SET @CodigoTipoEstrategia = (SELECT TOP 1 TipoEstrategiaID FROM dbo.TipoEstrategia (NOLOCK) WHERE DescripcionEstrategia= 'Los m�s vendidos')  
	SET @TipoEstrategiaIdLan = (SELECT TOP 1 TipoEstrategiaID FROM dbo.TipoEstrategia (NOLOCK) WHERE Codigo = '005')  
	SET @TipoEstrategiaIdSimples = (SELECT TOP 1 TipoEstrategiaID FROM dbo.TipoEstrategia (NOLOCK) WHERE Codigo = '007')  
	SET @TipoEstrategiaIdNiveles = (SELECT TOP 1 TipoEstrategiaID FROM dbo.TipoEstrategia (NOLOCK) WHERE Codigo = '008')  
	SET @TipoEstrategiaIdGnd = (SELECT TOP 1 TipoEstrategiaID FROM dbo.TipoEstrategia (NOLOCK) WHERE Codigo = '010')  
	SET @TipoEstrategiaIdOpt = (SELECT TOP 1 TipoEstrategiaID FROM dbo.TipoEstrategia (NOLOCK) WHERE Codigo = '001')  
	SET @TipoEstrategiaIdSR = (SELECT TOP 1 TipoEstrategiaID FROM dbo.TipoEstrategia (NOLOCK) WHERE Codigo = '030')  
	SET @TipoEstrategiaIdHv = (SELECT TOP 1 TipoEstrategiaID FROM dbo.TipoEstrategia (NOLOCK) WHERE Codigo = '011')  
	SET @TipoEstrategiaIdLMG = (SELECT TOP 1 TipoEstrategiaID FROM dbo.TipoEstrategia (NOLOCK) WHERE Codigo = 'LMG')
  
	IF @TipoEstrategiaID = 0
		SET @TipoEstrategiaID = NULL

	SELECT     
		TipoEstrategiaID,     
		DescripcionEstrategia,     
		ISNULL(dbo.ObtenerDescripcionOferta(TipoEstrategiaID),'') AS DescripcionOferta,    
		Orden,     
		FlagActivo,     
		ISNULL(CodigoPrograma,'') AS CodigoPrograma,  
		ISNULL(dbo.ObtenerOfertaID(TipoEstrategiaID),'') AS OfertaID,    
		ImagenEstrategia,    
		FlagNueva,    
		FlagRecoPerfil,    
		FlagRecoProduc,   
		ISNULL(FlagMostrarImg,0) AS FlagMostrarImg,  
		CASE TipoEstrategiaID  
		WHEN 10 THEN 1  
		WHEN 1009 THEN 2  
		WHEN 2009 THEN 3  
		WHEN @TipoEstrategiaIdOpt THEN 4  
		WHEN 3011 THEN 5  
		WHEN 3012 THEN 6  
		WHEN 3014 THEN 7  
		WHEN 3015 THEN 8  
		WHEN @TipoEstrategiaIdLan THEN 9  
		WHEN @TipoEstrategiaIdSimples THEN 10  
		WHEN @TipoEstrategiaIdLMG THEN 10  
		WHEN @TipoEstrategiaIdNiveles THEN 11  
		WHEN @TipoEstrategiaIdGnd THEN 12  
		WHEN @TipoEstrategiaIdHv THEN 13  
		WHEN @CodigoTipoEstrategia THEN 20  
		WHEN @TipoEstrategiaIdSR THEN 30  
		END AS CodigoGeneral,  
		Codigo  
		, MostrarImgOfertaIndependiente  
		, ImagenOfertaIndependiente  
		, FlagValidarImagen  
		,PesoMaximoImagen
		,MensajeValidacion
		,NombreComercial
	FROM dbo.TipoEstrategia (NOLOCK)
	WHERE TipoEstrategiaID = ISNULL(@TipoEstrategiaID, TipoEstrategiaID)
	ORDER BY Orden, DescripcionEstrategia   
	 
	SET NOCOUNT OFF    
END   
GO

USE BelcorpDominicana
GO

ALTER PROCEDURE dbo.ListarTipoEstrategia_SB2 
@TipoEstrategiaID INT    
AS    
BEGIN    
	SET NOCOUNT ON   
  
	DECLARE @CodigoTipoEstrategia INT,
			@TipoEstrategiaIdLan INT,
			@TipoEstrategiaIdSimples INT,
			@TipoEstrategiaIdNiveles INT,
			@TipoEstrategiaIdGnd INT,
			@TipoEstrategiaIdOpt INT,
			@TipoEstrategiaIdSR INT,
			@TipoEstrategiaIdHv INT,
			@TipoEstrategiaIdLMG INT

	SET @CodigoTipoEstrategia = (SELECT TOP 1 TipoEstrategiaID FROM dbo.TipoEstrategia (NOLOCK) WHERE DescripcionEstrategia= 'Los m�s vendidos')  
	SET @TipoEstrategiaIdLan = (SELECT TOP 1 TipoEstrategiaID FROM dbo.TipoEstrategia (NOLOCK) WHERE Codigo = '005')  
	SET @TipoEstrategiaIdSimples = (SELECT TOP 1 TipoEstrategiaID FROM dbo.TipoEstrategia (NOLOCK) WHERE Codigo = '007')  
	SET @TipoEstrategiaIdNiveles = (SELECT TOP 1 TipoEstrategiaID FROM dbo.TipoEstrategia (NOLOCK) WHERE Codigo = '008')  
	SET @TipoEstrategiaIdGnd = (SELECT TOP 1 TipoEstrategiaID FROM dbo.TipoEstrategia (NOLOCK) WHERE Codigo = '010')  
	SET @TipoEstrategiaIdOpt = (SELECT TOP 1 TipoEstrategiaID FROM dbo.TipoEstrategia (NOLOCK) WHERE Codigo = '001')  
	SET @TipoEstrategiaIdSR = (SELECT TOP 1 TipoEstrategiaID FROM dbo.TipoEstrategia (NOLOCK) WHERE Codigo = '030')  
	SET @TipoEstrategiaIdHv = (SELECT TOP 1 TipoEstrategiaID FROM dbo.TipoEstrategia (NOLOCK) WHERE Codigo = '011')  
	SET @TipoEstrategiaIdLMG = (SELECT TOP 1 TipoEstrategiaID FROM dbo.TipoEstrategia (NOLOCK) WHERE Codigo = 'LMG')
  
	IF @TipoEstrategiaID = 0
		SET @TipoEstrategiaID = NULL

	SELECT     
		TipoEstrategiaID,     
		DescripcionEstrategia,     
		ISNULL(dbo.ObtenerDescripcionOferta(TipoEstrategiaID),'') AS DescripcionOferta,    
		Orden,     
		FlagActivo,     
		ISNULL(CodigoPrograma,'') AS CodigoPrograma,  
		ISNULL(dbo.ObtenerOfertaID(TipoEstrategiaID),'') AS OfertaID,    
		ImagenEstrategia,    
		FlagNueva,    
		FlagRecoPerfil,    
		FlagRecoProduc,   
		ISNULL(FlagMostrarImg,0) AS FlagMostrarImg,  
		CASE TipoEstrategiaID  
		WHEN 10 THEN 1  
		WHEN 1009 THEN 2  
		WHEN 2009 THEN 3  
		WHEN @TipoEstrategiaIdOpt THEN 4  
		WHEN 3011 THEN 5  
		WHEN 3012 THEN 6  
		WHEN 3014 THEN 7  
		WHEN 3015 THEN 8  
		WHEN @TipoEstrategiaIdLan THEN 9  
		WHEN @TipoEstrategiaIdSimples THEN 10  
		WHEN @TipoEstrategiaIdLMG THEN 10  
		WHEN @TipoEstrategiaIdNiveles THEN 11  
		WHEN @TipoEstrategiaIdGnd THEN 12  
		WHEN @TipoEstrategiaIdHv THEN 13  
		WHEN @CodigoTipoEstrategia THEN 20  
		WHEN @TipoEstrategiaIdSR THEN 30  
		END AS CodigoGeneral,  
		Codigo  
		, MostrarImgOfertaIndependiente  
		, ImagenOfertaIndependiente  
		, FlagValidarImagen  
		,PesoMaximoImagen
		,MensajeValidacion
		,NombreComercial
	FROM dbo.TipoEstrategia (NOLOCK)
	WHERE TipoEstrategiaID = ISNULL(@TipoEstrategiaID, TipoEstrategiaID)
	ORDER BY Orden, DescripcionEstrategia   
	 
	SET NOCOUNT OFF    
END   
GO

USE BelcorpCostaRica
GO

ALTER PROCEDURE dbo.ListarTipoEstrategia_SB2 
@TipoEstrategiaID INT    
AS    
BEGIN    
	SET NOCOUNT ON   
  
	DECLARE @CodigoTipoEstrategia INT,
			@TipoEstrategiaIdLan INT,
			@TipoEstrategiaIdSimples INT,
			@TipoEstrategiaIdNiveles INT,
			@TipoEstrategiaIdGnd INT,
			@TipoEstrategiaIdOpt INT,
			@TipoEstrategiaIdSR INT,
			@TipoEstrategiaIdHv INT,
			@TipoEstrategiaIdLMG INT

	SET @CodigoTipoEstrategia = (SELECT TOP 1 TipoEstrategiaID FROM dbo.TipoEstrategia (NOLOCK) WHERE DescripcionEstrategia= 'Los m�s vendidos')  
	SET @TipoEstrategiaIdLan = (SELECT TOP 1 TipoEstrategiaID FROM dbo.TipoEstrategia (NOLOCK) WHERE Codigo = '005')  
	SET @TipoEstrategiaIdSimples = (SELECT TOP 1 TipoEstrategiaID FROM dbo.TipoEstrategia (NOLOCK) WHERE Codigo = '007')  
	SET @TipoEstrategiaIdNiveles = (SELECT TOP 1 TipoEstrategiaID FROM dbo.TipoEstrategia (NOLOCK) WHERE Codigo = '008')  
	SET @TipoEstrategiaIdGnd = (SELECT TOP 1 TipoEstrategiaID FROM dbo.TipoEstrategia (NOLOCK) WHERE Codigo = '010')  
	SET @TipoEstrategiaIdOpt = (SELECT TOP 1 TipoEstrategiaID FROM dbo.TipoEstrategia (NOLOCK) WHERE Codigo = '001')  
	SET @TipoEstrategiaIdSR = (SELECT TOP 1 TipoEstrategiaID FROM dbo.TipoEstrategia (NOLOCK) WHERE Codigo = '030')  
	SET @TipoEstrategiaIdHv = (SELECT TOP 1 TipoEstrategiaID FROM dbo.TipoEstrategia (NOLOCK) WHERE Codigo = '011')  
	SET @TipoEstrategiaIdLMG = (SELECT TOP 1 TipoEstrategiaID FROM dbo.TipoEstrategia (NOLOCK) WHERE Codigo = 'LMG')
  
	IF @TipoEstrategiaID = 0
		SET @TipoEstrategiaID = NULL

	SELECT     
		TipoEstrategiaID,     
		DescripcionEstrategia,     
		ISNULL(dbo.ObtenerDescripcionOferta(TipoEstrategiaID),'') AS DescripcionOferta,    
		Orden,     
		FlagActivo,     
		ISNULL(CodigoPrograma,'') AS CodigoPrograma,  
		ISNULL(dbo.ObtenerOfertaID(TipoEstrategiaID),'') AS OfertaID,    
		ImagenEstrategia,    
		FlagNueva,    
		FlagRecoPerfil,    
		FlagRecoProduc,   
		ISNULL(FlagMostrarImg,0) AS FlagMostrarImg,  
		CASE TipoEstrategiaID  
		WHEN 10 THEN 1  
		WHEN 1009 THEN 2  
		WHEN 2009 THEN 3  
		WHEN @TipoEstrategiaIdOpt THEN 4  
		WHEN 3011 THEN 5  
		WHEN 3012 THEN 6  
		WHEN 3014 THEN 7  
		WHEN 3015 THEN 8  
		WHEN @TipoEstrategiaIdLan THEN 9  
		WHEN @TipoEstrategiaIdSimples THEN 10  
		WHEN @TipoEstrategiaIdLMG THEN 10  
		WHEN @TipoEstrategiaIdNiveles THEN 11  
		WHEN @TipoEstrategiaIdGnd THEN 12  
		WHEN @TipoEstrategiaIdHv THEN 13  
		WHEN @CodigoTipoEstrategia THEN 20  
		WHEN @TipoEstrategiaIdSR THEN 30  
		END AS CodigoGeneral,  
		Codigo  
		, MostrarImgOfertaIndependiente  
		, ImagenOfertaIndependiente  
		, FlagValidarImagen  
		,PesoMaximoImagen
		,MensajeValidacion
		,NombreComercial
	FROM dbo.TipoEstrategia (NOLOCK)
	WHERE TipoEstrategiaID = ISNULL(@TipoEstrategiaID, TipoEstrategiaID)
	ORDER BY Orden, DescripcionEstrategia   
	 
	SET NOCOUNT OFF    
END   
GO

USE BelcorpChile
GO

ALTER PROCEDURE dbo.ListarTipoEstrategia_SB2 
@TipoEstrategiaID INT    
AS    
BEGIN    
	SET NOCOUNT ON   
  
	DECLARE @CodigoTipoEstrategia INT,
			@TipoEstrategiaIdLan INT,
			@TipoEstrategiaIdSimples INT,
			@TipoEstrategiaIdNiveles INT,
			@TipoEstrategiaIdGnd INT,
			@TipoEstrategiaIdOpt INT,
			@TipoEstrategiaIdSR INT,
			@TipoEstrategiaIdHv INT,
			@TipoEstrategiaIdLMG INT

	SET @CodigoTipoEstrategia = (SELECT TOP 1 TipoEstrategiaID FROM dbo.TipoEstrategia (NOLOCK) WHERE DescripcionEstrategia= 'Los m�s vendidos')  
	SET @TipoEstrategiaIdLan = (SELECT TOP 1 TipoEstrategiaID FROM dbo.TipoEstrategia (NOLOCK) WHERE Codigo = '005')  
	SET @TipoEstrategiaIdSimples = (SELECT TOP 1 TipoEstrategiaID FROM dbo.TipoEstrategia (NOLOCK) WHERE Codigo = '007')  
	SET @TipoEstrategiaIdNiveles = (SELECT TOP 1 TipoEstrategiaID FROM dbo.TipoEstrategia (NOLOCK) WHERE Codigo = '008')  
	SET @TipoEstrategiaIdGnd = (SELECT TOP 1 TipoEstrategiaID FROM dbo.TipoEstrategia (NOLOCK) WHERE Codigo = '010')  
	SET @TipoEstrategiaIdOpt = (SELECT TOP 1 TipoEstrategiaID FROM dbo.TipoEstrategia (NOLOCK) WHERE Codigo = '001')  
	SET @TipoEstrategiaIdSR = (SELECT TOP 1 TipoEstrategiaID FROM dbo.TipoEstrategia (NOLOCK) WHERE Codigo = '030')  
	SET @TipoEstrategiaIdHv = (SELECT TOP 1 TipoEstrategiaID FROM dbo.TipoEstrategia (NOLOCK) WHERE Codigo = '011')  
	SET @TipoEstrategiaIdLMG = (SELECT TOP 1 TipoEstrategiaID FROM dbo.TipoEstrategia (NOLOCK) WHERE Codigo = 'LMG')
  
	IF @TipoEstrategiaID = 0
		SET @TipoEstrategiaID = NULL

	SELECT     
		TipoEstrategiaID,     
		DescripcionEstrategia,     
		ISNULL(dbo.ObtenerDescripcionOferta(TipoEstrategiaID),'') AS DescripcionOferta,    
		Orden,     
		FlagActivo,     
		ISNULL(CodigoPrograma,'') AS CodigoPrograma,  
		ISNULL(dbo.ObtenerOfertaID(TipoEstrategiaID),'') AS OfertaID,    
		ImagenEstrategia,    
		FlagNueva,    
		FlagRecoPerfil,    
		FlagRecoProduc,   
		ISNULL(FlagMostrarImg,0) AS FlagMostrarImg,  
		CASE TipoEstrategiaID  
		WHEN 10 THEN 1  
		WHEN 1009 THEN 2  
		WHEN 2009 THEN 3  
		WHEN @TipoEstrategiaIdOpt THEN 4  
		WHEN 3011 THEN 5  
		WHEN 3012 THEN 6  
		WHEN 3014 THEN 7  
		WHEN 3015 THEN 8  
		WHEN @TipoEstrategiaIdLan THEN 9  
		WHEN @TipoEstrategiaIdSimples THEN 10  
		WHEN @TipoEstrategiaIdLMG THEN 10  
		WHEN @TipoEstrategiaIdNiveles THEN 11  
		WHEN @TipoEstrategiaIdGnd THEN 12  
		WHEN @TipoEstrategiaIdHv THEN 13  
		WHEN @CodigoTipoEstrategia THEN 20  
		WHEN @TipoEstrategiaIdSR THEN 30  
		END AS CodigoGeneral,  
		Codigo  
		, MostrarImgOfertaIndependiente  
		, ImagenOfertaIndependiente  
		, FlagValidarImagen  
		,PesoMaximoImagen
		,MensajeValidacion
		,NombreComercial
	FROM dbo.TipoEstrategia (NOLOCK)
	WHERE TipoEstrategiaID = ISNULL(@TipoEstrategiaID, TipoEstrategiaID)
	ORDER BY Orden, DescripcionEstrategia   
	 
	SET NOCOUNT OFF    
END   
GO

USE BelcorpBolivia
GO

ALTER PROCEDURE dbo.ListarTipoEstrategia_SB2 
@TipoEstrategiaID INT    
AS    
BEGIN    
	SET NOCOUNT ON   
  
	DECLARE @CodigoTipoEstrategia INT,
			@TipoEstrategiaIdLan INT,
			@TipoEstrategiaIdSimples INT,
			@TipoEstrategiaIdNiveles INT,
			@TipoEstrategiaIdGnd INT,
			@TipoEstrategiaIdOpt INT,
			@TipoEstrategiaIdSR INT,
			@TipoEstrategiaIdHv INT,
			@TipoEstrategiaIdLMG INT

	SET @CodigoTipoEstrategia = (SELECT TOP 1 TipoEstrategiaID FROM dbo.TipoEstrategia (NOLOCK) WHERE DescripcionEstrategia= 'Los m�s vendidos')  
	SET @TipoEstrategiaIdLan = (SELECT TOP 1 TipoEstrategiaID FROM dbo.TipoEstrategia (NOLOCK) WHERE Codigo = '005')  
	SET @TipoEstrategiaIdSimples = (SELECT TOP 1 TipoEstrategiaID FROM dbo.TipoEstrategia (NOLOCK) WHERE Codigo = '007')  
	SET @TipoEstrategiaIdNiveles = (SELECT TOP 1 TipoEstrategiaID FROM dbo.TipoEstrategia (NOLOCK) WHERE Codigo = '008')  
	SET @TipoEstrategiaIdGnd = (SELECT TOP 1 TipoEstrategiaID FROM dbo.TipoEstrategia (NOLOCK) WHERE Codigo = '010')  
	SET @TipoEstrategiaIdOpt = (SELECT TOP 1 TipoEstrategiaID FROM dbo.TipoEstrategia (NOLOCK) WHERE Codigo = '001')  
	SET @TipoEstrategiaIdSR = (SELECT TOP 1 TipoEstrategiaID FROM dbo.TipoEstrategia (NOLOCK) WHERE Codigo = '030')  
	SET @TipoEstrategiaIdHv = (SELECT TOP 1 TipoEstrategiaID FROM dbo.TipoEstrategia (NOLOCK) WHERE Codigo = '011')  
	SET @TipoEstrategiaIdLMG = (SELECT TOP 1 TipoEstrategiaID FROM dbo.TipoEstrategia (NOLOCK) WHERE Codigo = 'LMG')
  
	IF @TipoEstrategiaID = 0
		SET @TipoEstrategiaID = NULL

	SELECT     
		TipoEstrategiaID,     
		DescripcionEstrategia,     
		ISNULL(dbo.ObtenerDescripcionOferta(TipoEstrategiaID),'') AS DescripcionOferta,    
		Orden,     
		FlagActivo,     
		ISNULL(CodigoPrograma,'') AS CodigoPrograma,  
		ISNULL(dbo.ObtenerOfertaID(TipoEstrategiaID),'') AS OfertaID,    
		ImagenEstrategia,    
		FlagNueva,    
		FlagRecoPerfil,    
		FlagRecoProduc,   
		ISNULL(FlagMostrarImg,0) AS FlagMostrarImg,  
		CASE TipoEstrategiaID  
		WHEN 10 THEN 1  
		WHEN 1009 THEN 2  
		WHEN 2009 THEN 3  
		WHEN @TipoEstrategiaIdOpt THEN 4  
		WHEN 3011 THEN 5  
		WHEN 3012 THEN 6  
		WHEN 3014 THEN 7  
		WHEN 3015 THEN 8  
		WHEN @TipoEstrategiaIdLan THEN 9  
		WHEN @TipoEstrategiaIdSimples THEN 10  
		WHEN @TipoEstrategiaIdLMG THEN 10  
		WHEN @TipoEstrategiaIdNiveles THEN 11  
		WHEN @TipoEstrategiaIdGnd THEN 12  
		WHEN @TipoEstrategiaIdHv THEN 13  
		WHEN @CodigoTipoEstrategia THEN 20  
		WHEN @TipoEstrategiaIdSR THEN 30  
		END AS CodigoGeneral,  
		Codigo  
		, MostrarImgOfertaIndependiente  
		, ImagenOfertaIndependiente  
		, FlagValidarImagen  
		,PesoMaximoImagen
		,MensajeValidacion
		,NombreComercial
	FROM dbo.TipoEstrategia (NOLOCK)
	WHERE TipoEstrategiaID = ISNULL(@TipoEstrategiaID, TipoEstrategiaID)
	ORDER BY Orden, DescripcionEstrategia   
	 
	SET NOCOUNT OFF    
END   
GO