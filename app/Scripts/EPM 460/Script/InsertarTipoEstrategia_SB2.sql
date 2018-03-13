SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
@ImagenOfertaIndependiente  VARCHAR(500) = '',
@Codigo VARCHAR(100) = '',
@FlagValidarImagen INT, /* BPT-369 */
@PesoMaximoImagen INT /* BPT-369 */
AS  
BEGIN  
	SET NOCOUNT ON  

	BEGIN TRAN TRX_TIPO_ESTRATEGIA

	BEGIN TRY  
		DECLARE @TipoEstrategiaIdAux INT  

		IF EXISTS(SELECT 1 FROM dbo.TipoEstrategia (NOLOCK) WHERE REPLACE(DescripcionEstrategia, ' ', '') = REPLACE(@DescripcionEstrategia, ' ', '') AND TipoEstrategiaID <> @TipoEstrategiaID)  
		BEGIN  
			RAISERROR('El Nombre del tipo estrategia ya existe.', 16, 1)  
		END  
		IF EXISTS(SELECT 1 FROM dbo.TipoEstrategia (NOLOCK) WHERE orden = @Orden AND TipoEstrategiaID <> @TipoEstrategiaID AND @FlagNueva <> 1)  
		BEGIN  
			RAISERROR('El order indicado ya existe.', 16, 1)  
		END 
		IF EXISTS(SELECT 1 FROM dbo.TipoEstrategia (NOLOCK) WHERE orden = @Orden AND CodigoPrograma = @CodigoPrograma AND TipoEstrategiaID <> @TipoEstrategiaID AND FlagNueva = 1)  
		BEGIN  
			RAISERROR('El C�digo de programa ya existe.', 16, 1)  
		END 

		IF EXISTS(SELECT 1 FROM dbo.TipoEstrategia (NOLOCK) WHERE TipoEstrategiaID = @TipoEstrategiaID)  
		BEGIN  
			UPDATE TipoEstrategia 
			SET  DescripcionEstrategia = @DescripcionEstrategia,  
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
				ImagenOfertaIndependiente = @ImagenOfertaIndependiente,
				Codigo = @Codigo,
				FlagValidarImagen	= @FlagValidarImagen,
				PesoMaximoImagen	= @PesoMaximoImagen
			WHERE TipoEstrategiaID  = @TipoEstrategiaID  

			SET @TipoEstrategiaIdAux = @TipoEstrategiaID  
   
			IF LEN(@CodigoPrograma) > 0
			BEGIN	
				UPDATE O 
				SET O.CodigoPrograma = @CodigoPrograma
				FROM dbo.Oferta O (NOLOCK)
				INNER JOIN dbo.TipoEstrategiaOferta TEO  (NOLOCK)
					ON O.OfertaID = TEO.OfertaID
				INNER JOIN dbo.TipoEstrategia TE  (NOLOCK)
					ON TEO.TipoEstrategiaID = TE.TipoEstrategiaID
				WHERE TE.TipoEstrategiaID = @TipoEstrategiaIdAux 
		
				DELETE FROM dbo.TipoEstrategiaOferta WHERE TipoEstrategiaID = @TipoEstrategiaIdAux  
		
				INSERT INTO dbo.TipoEstrategiaOferta
				(
					TipoEstrategiaID,
					OfertaID
				)
				SELECT 
					@TipoEstrategiaIdAux, 
					O.OfertaID 
				FROM dbo.Oferta O (NOLOCK)
				INNER JOIN dbo.fnSplit(@OfertaID,',') S
				ON O.CodigoOferta = S.item
				WHERE O.CodigoPrograma = @CodigoPrograma
			END								
			ELSE
			BEGIN  
				DELETE FROM dbo.TipoEstrategiaOferta WHERE TipoEstrategiaID = @TipoEstrategiaIdAux  

				INSERT INTO dbo.TipoEstrategiaOferta  
				(
					TipoEstrategiaID,
					OfertaID
				)
				SELECT 
					@TipoEstrategiaIdAux, 
					O.OfertaID 
				FROM dbo.Oferta O (NOLOCK)
				INNER JOIN dbo.fnSplit(@OfertaID,',') S
				ON O.CodigoOferta = S.item
			END
		END  
		ELSE  
		BEGIN  
			INSERT INTO TipoEstrategia 
			(
				DescripcionEstrategia, 
				ImagenEstrategia, 
				Orden, 
				FlagActivo, 
				UsuarioRegistro, 
				FechaRegistro, 
				UsuarioModificacion, 
				FechaModificacion, 
				FlagNueva, 
				FlagRecoProduc, 
				FlagRecoPerfil, 
				CodigoPrograma, 
				FlagMostrarImg, 
				MostrarImgOfertaIndependiente, 
				ImagenOfertaIndependiente,
				Codigo,
				FlagValidarImagen, 
				PesoMaximoImagen
			)
			VALUES 
			(
				@DescripcionEstrategia, 
				@ImagenEstrategia, 
				@Orden, 
				@FlagActivo, 
				@UsuarioRegistro, 
				GETDATE(), 
				NULL, 
				NULL, 
				@FlagNueva, 
				@FlagRecoProduc, 
				@FlagRecoPerfil, 
				@CodigoPrograma, 
				@FlagMostrarImg, 
				@MostrarImgOfertaIndependiente, 
				@ImagenOfertaIndependiente,
				@Codigo,
				@FlagValidarImagen,
				@PesoMaximoImagen
			)

			SET @TipoEstrategiaIdAux = @@IDENTITY 
    
			IF LEN(@CodigoPrograma) > 0
			BEGIN 
				INSERT INTO dbo.TipoEstrategiaOferta  
				(
					TipoEstrategiaID,
					OfertaID
				)
				SELECT 
					@TipoEstrategiaIdAux, 
					O.OfertaID 
				FROM dbo.Oferta O (NOLOCK)
				INNER JOIN dbo.fnSplit(@OfertaID,',') S
				ON O.CodigoOferta = S.item
				WHERE O.CodigoPrograma =   @CodigoPrograma		
			END
			ELSE
			BEGIN
				INSERT INTO dbo.TipoEstrategiaOferta  
				(
					TipoEstrategiaID,
					OfertaID
				)
				SELECT 
					@TipoEstrategiaIdAux, 
					O.OfertaID 
				FROM dbo.Oferta O (NOLOCK)
				INNER JOIN dbo.fnSplit(@OfertaID,',') S
				ON O.CodigoOferta = S.item
			END
		END  

		COMMIT TRAN TRX_TIPO_ESTRATEGIA
	END TRY  
	BEGIN CATCH  
		ROLLBACK TRAN TRX_TIPO_ESTRATEGIA;

		THROW;    
	END CATCH  

	SET NOCOUNT OFF  
END 