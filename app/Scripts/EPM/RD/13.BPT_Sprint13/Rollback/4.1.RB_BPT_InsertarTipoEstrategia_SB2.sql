USE BelcorpPeru
GO

GO
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
GO

USE BelcorpMexico
GO

GO
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
GO

USE BelcorpColombia
GO

GO
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
GO

USE BelcorpVenezuela
GO

GO
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
GO

USE BelcorpSalvador
GO

GO
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
GO

USE BelcorpPuertoRico
GO

GO
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
GO

USE BelcorpPanama
GO

GO
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
GO

USE BelcorpGuatemala
GO

GO
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
GO

USE BelcorpEcuador
GO

GO
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
GO

USE BelcorpDominicana
GO

GO
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
GO

USE BelcorpCostaRica
GO

GO
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
GO

USE BelcorpChile
GO

GO
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
GO

USE BelcorpBolivia
GO

GO
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
GO

