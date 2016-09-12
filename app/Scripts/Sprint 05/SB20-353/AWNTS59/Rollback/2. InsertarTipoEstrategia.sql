
USE [BelcorpPeru_SB2]
GO

ALTER PROCEDURE [dbo].[InsertarTipoEstrategia]  
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
 @CodigoPrograma VARCHAR(3)
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
     CodigoPrograma		= @CodigoPrograma 
    WHERE  
     TipoEstrategiaID  = @TipoEstrategiaID  
    SET @TipoEstrategiaIdAux = @TipoEstrategiaID  
   
    /*R20160301*/
    --IF @CodigoPrograma IS NOT NULL OR @CodigoPrograma != '' 
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
    
    INSERT INTO TipoEstrategia VALUES (@DescripcionEstrategia, @ImagenEstrategia, @Orden, @FlagActivo, @UsuarioRegistro, GETDATE(), NULL, NULL, @FlagNueva, @FlagRecoProduc, @FlagRecoPerfil, @CodigoPrograma )
    SET @TipoEstrategiaIdAux = @@IDENTITY 
    /*R20160301*/
    --IF @CodigoPrograma IS NOT NULL OR @CodigoPrograma != '' 
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

/*end*/

USE [BelcorpMexico_SB2]
GO

ALTER PROCEDURE [dbo].[InsertarTipoEstrategia]  
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
 @CodigoPrograma VARCHAR(3)
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
     CodigoPrograma		= @CodigoPrograma
    WHERE  
     TipoEstrategiaID  = @TipoEstrategiaID  
    SET @TipoEstrategiaIdAux = @TipoEstrategiaID  
   
    /*R20160301*/
    --IF @CodigoPrograma IS NOT NULL OR @CodigoPrograma != '' 
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
    
    INSERT INTO TipoEstrategia VALUES (@DescripcionEstrategia, @ImagenEstrategia, @Orden, @FlagActivo, @UsuarioRegistro, GETDATE(), NULL, NULL, @FlagNueva, @FlagRecoProduc, @FlagRecoPerfil, @CodigoPrograma )  
    SET @TipoEstrategiaIdAux = @@IDENTITY 
    /*R20160301*/
    --IF @CodigoPrograma IS NOT NULL OR @CodigoPrograma != '' 
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


/*end*/

USE [BelcorpColombia_SB2]
GO
/****** Object:  StoredProcedure [dbo].[InsertarTipoEstrategia]    Script Date: 03/08/2016 12:18:08 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[InsertarTipoEstrategia]  
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
 @CodigoPrograma VARCHAR(3)
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
     CodigoPrograma		= @CodigoPrograma
    WHERE  
     TipoEstrategiaID  = @TipoEstrategiaID  
    SET @TipoEstrategiaIdAux = @TipoEstrategiaID  
   
    /*R20160301*/
    --IF @CodigoPrograma IS NOT NULL OR @CodigoPrograma != '' 
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
    
    INSERT INTO TipoEstrategia VALUES (@DescripcionEstrategia, @ImagenEstrategia, @Orden, @FlagActivo, @UsuarioRegistro, GETDATE(), NULL, NULL, @FlagNueva, @FlagRecoProduc, @FlagRecoPerfil, @CodigoPrograma )
    SET @TipoEstrategiaIdAux = @@IDENTITY 
    /*R20160301*/
    --IF @CodigoPrograma IS NOT NULL OR @CodigoPrograma != '' 
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


