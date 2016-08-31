USE [BelcorpPeru_SB2]
GO


ALTER PROCEDURE [dbo].[InsertarEstrategia]
	@EstrategiaID int,
	@TipoEstrategiaID int,
	@CampaniaID int,
	@CampaniaIDFin int,
	@NumeroPedido int,
	@Activo bit,
	@ImagenURL varchar(800),
	@LimiteVenta int,
	@DescripcionCUV2 varchar(800),
	@FlagDescripcion bit,
	@CUV varchar(20),
	@EtiquetaID int,
	@Precio numeric(12,2),
	@FlagCEP bit,
	@CUV2 varchar(20),
	@EtiquetaID2 int,
	@Precio2 numeric(12,2),
	@FlagCEP2 bit,
	@TextoLibre varchar(800),
	@FlagTextoLibre bit,
	@Cantidad int,
	@FlagCantidad bit,
	@Zona varchar(8000),
	@Orden int,
	@UsuarioCreacion varchar(100),
	@UsuarioModificacion varchar(100),
	@ColorFondo varchar(20),
	@FlagEstrella bit
AS
BEGIN
	SET NOCOUNT ON
		BEGIN TRY
			IF NOT EXISTS(SELECT 1 FROM Estrategia WHERE EstrategiaID = @EstrategiaID)
			BEGIN

				IF EXISTS(SELECT 1 FROM ESTRATEGIA WHERE CUV2 = @CUV2 AND CAMPANIAID = @CampaniaID AND TIPOESTRATEGIAID = @TipoEstrategiaID AND NUMEROPEDIDO = @NumeroPedido)
				BEGIN
					RAISERROR('El valor de cuv2 a registrar ya existe para el tipo de estrategia y campa�a seleccionado.', 16, 1)
				END
				
				IF EXISTS(SELECT 1 FROM ESTRATEGIA WHERE Orden = @Orden AND CAMPANIAID = @CampaniaID AND TIPOESTRATEGIAID = @TipoEstrategiaID AND NUMEROPEDIDO = @NumeroPedido)
				BEGIN
					RAISERROR('El orden ingresado para la estrategia ya est� siendo utilizado.', 16, 1)
				END

			    INSERT INTO dbo.Estrategia
			    (TipoEstrategiaID, CampaniaID, CampaniaIDFin, NumeroPedido, Activo, ImagenURL, LimiteVenta, DescripcionCUV2
				,FlagDescripcion, CUV, EtiquetaID, Precio, FlagCEP, CUV2, EtiquetaID2, Precio2
				,FlagCEP2, TextoLibre, FlagTextoLibre, Cantidad, FlagCantidad, Zona, Orden, UsuarioCreacion, FechaCreacion, ColorFondo, FlagEstrella )
				VALUES
			   (@TipoEstrategiaID,@CampaniaID,@CampaniaIDFin,@NumeroPedido,@Activo,@ImagenURL,@LimiteVenta,@DescripcionCUV2
				,@FlagDescripcion,@CUV,@EtiquetaID,@Precio,@FlagCEP,@CUV2,@EtiquetaID2,@Precio2
				,@FlagCEP2,@TextoLibre,@FlagTextoLibre,@Cantidad,@FlagCantidad,@Zona,@Orden,@UsuarioCreacion,GETDATE(), @ColorFondo, @FlagEstrella)
			END
			ELSE
			BEGIN

				IF EXISTS(SELECT 1 FROM ESTRATEGIA WHERE CUV2 = @CUV2 AND CAMPANIAID = @CampaniaID AND TIPOESTRATEGIAID = @TipoEstrategiaID AND ESTRATEGIAID <> @EstrategiaID  AND NUMEROPEDIDO = @NumeroPedido)
				BEGIN
					RAISERROR('El valor de cuv2 a registrar ya existe para el tipo de estrategia y campa�a seleccionado.', 16, 1)
				END
				 
				IF EXISTS(SELECT 1 FROM ESTRATEGIA WHERE Orden = @Orden AND CAMPANIAID = @CampaniaID AND TIPOESTRATEGIAID = @TipoEstrategiaID  AND ESTRATEGIAID <> @EstrategiaID AND NUMEROPEDIDO = @NumeroPedido)
				BEGIN
					RAISERROR('El orden ingresado para la estrategia ya est� siendo utilizado.', 16, 1)
				END

				DECLARE @CantidadYaSolicitada INT
				SELECT @CantidadYaSolicitada = Cantidad FROM PEDIDOWEBDETALLE WHERE CUV = @CUV AND CampaniaID = @CampaniaID
				IF @LimiteVenta < @CantidadYaSolicitada
				BEGIN
					DECLARE @mensaje VARCHAR(2000)
					SET @mensaje = 'No se puede reducir el limite de venta por que ya se hicieron ' + convert(varchar, @CantidadYaSolicitada) + ' pedido(s) de �ste producto.'
					RAISERROR(@mensaje, 16, 1)
				END

				UPDATE Estrategia SET
					TipoEstrategiaID= @TipoEstrategiaID,
					CampaniaID= 	  @CampaniaID,
					CampaniaIDFin= 	  @CampaniaIDFin,
					NumeroPedido= 	  @NumeroPedido,
					Activo= 		  @Activo,
					ImagenURL= 		  @ImagenURL,
					LimiteVenta= 	  @LimiteVenta, 
					DescripcionCUV2=  @DescripcionCUV2,
					FlagDescripcion=  @FlagDescripcion ,
					CUV= 			  @CUV,
					EtiquetaID= 	  @EtiquetaID,
					Precio= 		  @Precio,
					FlagCEP= 		  @FlagCEP, 
					CUV2= 			  @CUV2,
					EtiquetaID2= 	  @EtiquetaID2,
					Precio2=		  @Precio2,
					FlagCEP2= 		  @FlagCEP2, 
					TextoLibre= 	  @TextoLibre, 
					FlagTextoLibre=   @FlagTextoLibre,
					Cantidad= 		  @Cantidad,
					FlagCantidad= 	  @FlagCantidad,
					Zona= 			  @Zona,
					Orden= 			  @Orden,
					UsuarioModificacion	=  @UsuarioModificacion,
					FechaModificacion	= GETDATE(),
					ColorFondo			= @ColorFondo, 
					FlagEstrella		= @FlagEstrella
				WHERE EstrategiaID = @EstrategiaID
			END
		END TRY
		BEGIN CATCH
			DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT
			SELECT @ErrorMessage = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE()
			RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState)
		END CATCH
	SET NOCOUNT OFF
END


