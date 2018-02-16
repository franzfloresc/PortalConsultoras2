ALTER PROCEDURE [dbo].[ListarTipoEstrategia_SB2]  
 @TipoEstrategiaID INT  
AS  
BEGIN  
SET NOCOUNT ON 

	DECLARE @CodigoTipoEstrategia INT
    SET @CodigoTipoEstrategia = (SELECT TOP 1 TipoEstrategiaID FROM TipoEstrategia WHERE DescripcionEstrategia= 'Los m�s vendidos')

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

	DECLARE @TipoEstrategiaIdSR INT
    SET @TipoEstrategiaIdSR = (SELECT TOP 1 TipoEstrategiaID FROM TipoEstrategia WHERE Codigo = '030')

	DECLARE @TipoEstrategiaIdHv INT
    SET @TipoEstrategiaIdHv = (SELECT TOP 1 TipoEstrategiaID FROM TipoEstrategia WHERE Codigo = '011')

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
		when @TipoEstrategiaIdHv then 13
		when @CodigoTipoEstrategia then 20
		when @TipoEstrategiaIdSR then 30
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
GO