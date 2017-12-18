--ROLLBACK
ALTER TABLE TipoEstrategia DROP CONSTRAINT FlagValidarImagen_def  
GO 
ALTER TABLE TipoEstrategia DROP CONSTRAINT PesoMaximoImagen_def 
GO 

ALTER TABLE TipoEstrategia  DROP COLUMN FlagValidarImagen; 
GO 
ALTER TABLE TipoEstrategia  DROP COLUMN PesoMaximoImagen; 
GO 

---------------------------------------------------------------------------

ALTER PROCEDURE [dbo].[InsertarTipoEstrategia_SB2]  
 @TipoEstrategiaID  INT,  
 @DescripcionEstrategia VARCHAR(200),  
 @ImagenEstrategia  VARCHAR(500),  
 @Orden     INT,  
 @FlagActivo    BIT,  
 @UsuarioRegistro  VARCHAR(100),  
 @UsuarioModificacion VARCHAR(100),  
 @OfertaID    VARCHAR(8000),  
 @FlagNueva    INT,  
 @FlagRecoPerfil   INT,  
 @FlagRecoProduc   INT,
 @CodigoPrograma VARCHAR(3),
 @FlagMostrarImg TINYINT,	/* SB20-353 */
 @MostrarImgOfertaIndependiente BIT = 0,
 @ImagenOfertaIndependiente  VARCHAR(500) = ''
AS  
BEGIN  
 SET NOCOUNT ON  
  BEGIN TRY  
  DECLARE @TipoEstrategiaIdAux INT  
  IF EXISTS(SELECT 1 FROM TipoEstrategia WHERE TipoEstrategiaID = @TipoEstrategiaID)  
   BEGIN  
    IF EXISTS(SELECT 1 FROM TipoEstrategia WHERE REPLACE(DescripcionEstrategia, ' ', '') = REPLACE(@DescripcionEstrategia, ' ', '') AND TipoEstrategiaID <> @TipoEstrategiaID)  
    BEGIN  
     RAISERROR('El Nombre del tipo estrategia ya existe.', 16, 1)  
    END  
    IF EXISTS(SELECT 1 FROM TipoEstrategia WHERE orden = @Orden AND TipoEstrategiaID <> @TipoEstrategiaID AND @FlagNueva <> 1)  

    BEGIN  
     RAISERROR('El order indicado ya existe.', 16, 1)  
    END 
    IF EXISTS(SELECT 1 FROM TipoEstrategia WHERE orden = @Orden AND CodigoPrograma = @CodigoPrograma AND TipoEstrategiaID <> @TipoEstrategiaID AND FlagNueva = 1)  
    BEGIN  
 
    RAISERROR('El Código de programa ya existe.', 16, 1)  
    END   
    UPDATE TipoEstrategia SET  
     DescripcionEstrategia = @DescripcionEstrategia,  
     ImagenEstrategia	= @ImagenEstrategia,  
     Orden				= @Orden,  
     FlagActivo			= @FlagActivo,  
     UsuarioModificacion  = @UsuarioModificacion,  
     FechaModificacion  = GETDATE(),  
     flagNueva			= @FlagNueva,  
     flagRecoProduc		= @FlagRecoProduc,  
     flagRecoPerfil		= @FlagRecoPerfil ,
     CodigoPrograma		= @CodigoPrograma , 
	 FlagMostrarImg		= @FlagMostrarImg,
	 MostrarImgOfertaIndependiente = @MostrarImgOfertaIndependiente,
	 ImagenOfertaIndependiente = @ImagenOfertaIndependiente
    WHERE  
     TipoEstrategiaID  = @TipoEstrategiaID  
    SET @TipoEstrategiaIdAux = @TipoEstrategiaID  
   
    IF @CodigoPrograma != '' 
	BEGIN
				
		UPDATE Oferta 
		SET  CodigoPrograma = @CodigoPrograma
		FROM Oferta O
			INNER JOIN TipoEstrategiaOferta TEO ON O.OfertaID = TEO.OfertaID
			INNER JOIN TipoEstrategia TE ON TEO.TipoEstrategiaID = TE.TipoEstrategiaID
		WHERE TE.TipoEstrategiaID = @TipoEstrategiaIdAux 
		
		DELETE FROM TipoEstrategiaOferta WHERE TipoEstrategiaID = @TipoEstrategiaIdAux  
		
		INSERT INTO TipoEstrategiaOferta
		SELECT @TipoEstrategiaIdAux, OfertaID 
		FROM Oferta 
		WHERE CodigoOferta IN (SELECT * FROM dbo.fnSplit(@OfertaID,',')) AND CodigoPrograma =   @CodigoPrograma
		
	END								
	ELSE
	BEGIN  
	
		DELETE FROM TipoEstrategiaOferta WHERE TipoEstrategiaID = @TipoEstrategiaIdAux  
	    INSERT INTO TipoEstrategiaOferta  
		SELECT @TipoEstrategiaIdAux, OfertaID FROM Oferta WHERE CodigoOferta IN (SELECT * FROM dbo.fnSplit(@OfertaID,','))  
    END
    
   END  
   ELSE  
   BEGIN  
    IF EXISTS(SELECT 1 FROM TipoEstrategia WHERE REPLACE(DescripcionEstrategia, ' ', '') = REPLACE(@DescripcionEstrategia, ' ', ''))  
    BEGIN  
     RAISERROR('El Nombre de la estrategia ya existe.', 16, 1)  
    END  
    IF EXISTS(SELECT 1 FROM TipoEstrategia WHERE orden = @Orden AND @FlagNueva <> 1)  
    BEGIN  
     RAISERROR('El orden indicado ya existe.', 16, 1)  
    END  
    IF EXISTS(SELECT 1 FROM TipoEstrategia WHERE orden = @Orden AND TipoEstrategiaID <> @TipoEstrategiaID AND CodigoPrograma = @CodigoPrograma)  
    BEGIN  
     RAISERROR('El Código de programa ya existe.', 16, 1)
    END     
    
	INSERT INTO TipoEstrategia (DescripcionEstrategia, ImagenEstrategia, Orden, FlagActivo, UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion, 
		FlagNueva, FlagRecoProduc, FlagRecoPerfil, CodigoPrograma, FlagMostrarImg, MostrarImgOfertaIndependiente, ImagenOfertaIndependiente)
    VALUES (@DescripcionEstrategia, @ImagenEstrategia, @Orden, @FlagActivo, @UsuarioRegistro, GETDATE(), NULL, NULL, @FlagNueva, @FlagRecoProduc, @FlagRecoPerfil, 
		@CodigoPrograma, @FlagMostrarImg, @MostrarImgOfertaIndependiente, @ImagenOfertaIndependiente)
    SET @TipoEstrategiaIdAux = @@IDENTITY 
    
    IF @CodigoPrograma != '' 
	BEGIN 
		INSERT INTO TipoEstrategiaOferta  
		SELECT @TipoEstrategiaIdAux, OfertaID FROM Oferta WHERE CodigoOferta IN (SELECT * FROM dbo.fnSplit(@OfertaID,',')) AND CodigoPrograma =   @CodigoPrograma		
	END
    ELSE
    BEGIN
    	INSERT INTO TipoEstrategiaOferta  
		SELECT @TipoEstrategiaIdAux, OfertaID FROM Oferta WHERE CodigoOferta IN (SELECT * FROM dbo.fnSplit(@OfertaID,','))  
    END

   END  
  END TRY  
  BEGIN CATCH  
   DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT  
   SELECT @ErrorMessage = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE()  
   RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState)     
  END CATCH  
 SET NOCOUNT OFF  
END 

--------------------------------------------------------------------

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
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
	FROM TipoEstrategia  
	WHERE TipoEstrategiaID = @TipoEstrategiaID OR 0 = @TipoEstrategiaID  
	ORDER BY Orden, DescripcionEstrategia ASC  
SET NOCOUNT OFF  
END 