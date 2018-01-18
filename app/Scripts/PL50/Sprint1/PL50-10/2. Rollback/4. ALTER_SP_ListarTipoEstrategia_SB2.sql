USE [BelcorpColombia_PL50]
GO
/****** Object:  StoredProcedure [dbo].[ListarTipoEstrategia_SB2]    Script Date: 17/01/2018 14:33:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[ListarTipoEstrategia_SB2]  
 @TipoEstrategiaID INT  
AS  
BEGIN  
SET NOCOUNT ON 

	DECLARE @CodigoTipoEstrategia INT
    SET @CodigoTipoEstrategia = (SELECT TOP 1 TipoEstrategiaID FROM TipoEstrategia WHERE DescripcionEstrategia= 'Los más vendidos')

	DECLARE @TipoEstrategiaIdLan INT
    SET @TipoEstrategiaIdLan = (SELECT TOP 1 TipoEstrategiaID FROM TipoEstrategia WHERE Codigo = '005')
	
	DECLARE @TipoEstrategiaIdSimples INT
    SET @TipoEstrategiaIdSimples = (SELECT TOP 1 TipoEstrategiaID FROM TipoEstrategia WHERE Codigo = '007')

	DECLARE @TipoEstrategiaIdNiveles INT
    SET @TipoEstrategiaIdNiveles = (SELECT TOP 1 TipoEstrategiaID FROM TipoEstrategia WHERE Codigo = '008')

	DECLARE @TipoEstrategiaIdGnd INT
    SET @TipoEstrategiaIdGnd = (SELECT TOP 1 TipoEstrategiaID FROM TipoEstrategia WHERE Codigo = '010')

	DECLARE @TipoEstrategiaIdOpt INT
    SET @TipoEstrategiaIdOpt = (SELECT TOP 1 TipoEstrategiaID FROM TipoEstrategia WHERE Codigo = '001')

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
		case TipoEstrategiaID
		when 10 then 1
		when 1009 then 2
		when 2009 then 3
		when @TipoEstrategiaIdOpt then 4
		when 3011 then 5
		when 3012 then 6
		when 3014 then 7
		when 3015 then 8
		when @TipoEstrategiaIdLan then 9
		when @TipoEstrategiaIdSimples then 10
		when @TipoEstrategiaIdNiveles then 11
		when @TipoEstrategiaIdGnd then 12
		WHEN @CodigoTipoEstrategia then 20
		end as CodigoGeneral,
		Codigo
		, MostrarImgOfertaIndependiente
		, ImagenOfertaIndependiente
		, FlagValidarImagen
	    ,PesoMaximoImagen
	FROM TipoEstrategia  
	WHERE TipoEstrategiaID = @TipoEstrategiaID OR 0 = @TipoEstrategiaID  
	ORDER BY Orden, DescripcionEstrategia ASC  
SET NOCOUNT OFF  
END 

