USE [BelcorpPeru]
GO


IF NOT EXISTS (SELECT TablaLogicaID FROM TablaLogica WHERE TablaLogicaID = 98)
BEGIN
	INSERT INTO TablaLogica (TablaLogicaID, Descripcion) VALUES (98, 'Validación para determinar desde que campaña se realizará la búsqueda de la información de la estrategia.')
END

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 9802)
BEGIN
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion) VALUES (9802, 98, '201704', 'Campaña para la busqueda.')
END

go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
 where sysobjects.id = object_id('dbo.EstrategiaProducto')) = 0
 begin

CREATE TABLE [dbo].[EstrategiaProducto](
	[EstrategiaProductoId] [int] IDENTITY(1,1) NOT NULL,
	[EstrategiaId] int NOT null,
	[Campania] [int] NOT NULL,
	[CUV] [nvarchar](20) NOT NULL,
	[CodigoEstrategia] [nvarchar](100) NOT NULL,
	[Grupo] [nvarchar](20) NULL,
	[Orden] int NULL,
	[CUV2] [nvarchar](20) NULL,
	[SAP] [nvarchar](50) NULL,
	[Cantidad] INT NULL,
	[Precio] MONEY NULL,
	[PrecioValorizado] MONEY NULL,
	[Digitable] int NULL,
	[CodigoError] [nvarchar](100) NULL,
	[CodigoErrorObs] [nvarchar](4000) NULL
)

end
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('dbo.Estrategia') and SYSCOLUMNS.NAME = N'CodigoEstrategia') = 0
	ALTER TABLE dbo.Estrategia ADD CodigoEstrategia varchar(100)
go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertEstrategiaProducto]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].InsertEstrategiaProducto
GO

CREATE PROCEDURE dbo.InsertEstrategiaProducto
	@Retorno int output
	,@EstrategiaProductoId int 
	,@EstrategiaId int
	,@Campania int
	,@CUV nvarchar(20)
	,@CodigoEstrategia nvarchar(100)
	,@Grupo nvarchar(20)
	,@Orden int
	,@CUV2 nvarchar(20)
	,@SAP nvarchar(50)
	,@Cantidad int
	,@Precio money
	,@PrecioValorizado money
	,@Digitable int
	,@CodigoError nvarchar(100)
	,@CodigoErrorObs nvarchar(4000)
AS
begin

	INSERT INTO EstrategiaProducto(
		EstrategiaId
		,Campania
		,CUV
		,CodigoEstrategia
		,Grupo
		,Orden
		,CUV2
		,SAP
		,Cantidad
		,Precio
		,PrecioValorizado
		,Digitable
		,CodigoError
		,CodigoErrorObs
	)VALUES(
		@EstrategiaId
		,@Campania
		,@CUV
		,@CodigoEstrategia
		,@Grupo
		,@Orden
		,@CUV2
		,@SAP
		,@Cantidad
		,@Precio
		,@PrecioValorizado
		,@Digitable
		,@CodigoError
		,@CodigoErrorObs
	)

	set @Retorno = @@IDENTITY
end
go

GO
ALTER PROCEDURE [dbo].[InsertarEstrategia_SB2]
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
	@FlagEstrella bit,
	@CodigoEstrategia varchar(100),
	@Retorno int output
AS
BEGIN

	SET NOCOUNT ON
		BEGIN TRY

		set @Retorno = 0

		DECLARE @TipoEstrategiaIDPackNueva INT = 0, @TipoEstrategiaIDOfertaDia INT = 0
		
		-- Para calcular la etiqueta para pack nuevas
		SELECT	@TipoEstrategiaIDPackNueva = COUNT( TipoEstrategiaID) 
		FROM	TipoEstrategia 
		WHERE	TipoEstrategiaId = @TipoEstrategiaID AND  flagnueva = 1

		-- Para calcular la etiqueta Oferta del día
		SELECT	@TipoEstrategiaIDOfertaDia = COUNT( TipoEstrategiaID) 
		FROM	TipoEstrategia 
		WHERE	TipoEstrategiaId = @TipoEstrategiaID AND  DescripcionEstrategia like '%'+ UPPER('OFERTA DEL')+'%'

		-- Obtener el EtiquetaID2 de Precio para TI
		SELECT @EtiquetaID2 = EtiquetaID FROM Etiqueta 
		WHERE Descripcion like '%' + UPPER('Precio para T') + '%'
		
		-- Obtener el EtiquetaID de Precio Catalogo.	
		SELECT @EtiquetaID = EtiquetaID FROM Etiqueta 
		WHERE Descripcion like '%' + UPPER('Precio Cat') + '%'

		-- Obtener el EtiquetaID de Ganancia
		IF @TipoEstrategiaIDPackNueva > 0
		BEGIN
			SELECT @EtiquetaID = EtiquetaID from Etiqueta 
			WHERE Descripcion like '%' + UPPER('Ganancia') + '%'
		END
		-- Obtener el EtiquetaID de la Oferta del día.
		IF @TipoEstrategiaIDOfertaDia > 0
		BEGIN
			SELECT @EtiquetaID2 = EtiquetaID from Etiqueta 
			WHERE Descripcion like '%' + UPPER('OFERTA DEL') + '%'
		END		

			IF NOT EXISTS(SELECT 1 FROM Estrategia WHERE EstrategiaID = @EstrategiaID)
			BEGIN
				IF EXISTS(SELECT 1 FROM ESTRATEGIA WHERE CUV2 = @CUV2 AND CAMPANIAID = @CampaniaID AND TIPOESTRATEGIAID = @TipoEstrategiaID AND NUMEROPEDIDO = @NumeroPedido)
				BEGIN
					RAISERROR('El valor de cuv2 a registrar ya existe para el tipo de estrategia y campaña seleccionado.', 16, 1)
				END

				IF (@TipoEstrategiaID NOT IN (3009) AND ISNULL(@Orden,0) > 0)	-- SB20-312
				BEGIN
					IF EXISTS(SELECT 1 FROM ESTRATEGIA WHERE Orden = @Orden AND CAMPANIAID = @CampaniaID AND TIPOESTRATEGIAID = @TipoEstrategiaID AND NUMEROPEDIDO = @NumeroPedido)
					BEGIN
						RAISERROR('El orden ingresado para la estrategia ya está siendo utilizado.', 16, 1)
					END
				END							
				
			    INSERT INTO dbo.Estrategia
			    (TipoEstrategiaID, CampaniaID, CampaniaIDFin, NumeroPedido, Activo, ImagenURL, LimiteVenta, DescripcionCUV2
				,FlagDescripcion, CUV, EtiquetaID, Precio, FlagCEP, CUV2, EtiquetaID2, Precio2
				,FlagCEP2, TextoLibre, FlagTextoLibre, Cantidad, FlagCantidad, Zona, Orden, UsuarioCreacion, FechaCreacion, ColorFondo, FlagEstrella, CodigoEstrategia )
				VALUES
			   (@TipoEstrategiaID,@CampaniaID,@CampaniaIDFin,@NumeroPedido,@Activo,@ImagenURL,@LimiteVenta,@DescripcionCUV2
				,@FlagDescripcion,@CUV,@EtiquetaID,@Precio,@FlagCEP,@CUV2,@EtiquetaID2,@Precio2
				,@FlagCEP2,@TextoLibre,@FlagTextoLibre,@Cantidad,@FlagCantidad,@Zona,@Orden,@UsuarioCreacion,GETDATE(), @ColorFondo, @FlagEstrella, @CodigoEstrategia)

				set @Retorno = @@IDENTITY

			END
			ELSE
			BEGIN			

				IF EXISTS(SELECT 1 FROM ESTRATEGIA WHERE CUV2 = @CUV2 AND CAMPANIAID = @CampaniaID AND TIPOESTRATEGIAID = @TipoEstrategiaID AND ESTRATEGIAID <> @EstrategiaID  AND NUMEROPEDIDO = @NumeroPedido)
				BEGIN
					RAISERROR('El valor de cuv2 a registrar ya existe para el tipo de estrategia y campaña seleccionado.', 16, 1)
				END								 
				
				IF (@TipoEstrategiaID NOT IN (3009) AND ISNULL(@Orden,0) > 0) -- SB20-312
				BEGIN

					IF EXISTS(SELECT 1 FROM ESTRATEGIA WHERE Orden = @Orden AND CAMPANIAID = @CampaniaID AND TIPOESTRATEGIAID = @TipoEstrategiaID  AND ESTRATEGIAID <> @EstrategiaID AND NUMEROPEDIDO = @NumeroPedido)
					BEGIN
						RAISERROR('El orden ingresado para la estrategia ya está siendo utilizado.', 16, 1)
					END
				END
				
				--DECLARE @CantidadYaSolicitada INT
				--SELECT @CantidadYaSolicitada = Cantidad FROM PEDIDOWEBDETALLE WHERE CUV = @CUV AND CampaniaID = @CampaniaID
				--IF @LimiteVenta < @CantidadYaSolicitada
				--BEGIN
				--	DECLARE @mensaje VARCHAR(2000)
				--	SET @mensaje = 'No se puede reducir el limite de venta por que ya se hicieron ' + convert(varchar, @CantidadYaSolicitada) + ' pedido(s) de éste producto.'
				--	RAISERROR(@mensaje, 16, 1)
				--END			

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
					FlagEstrella		= @FlagEstrella,
					CodigoEstrategia	= @CodigoEstrategia
				WHERE EstrategiaID = @EstrategiaID
				
				set @Retorno = @EstrategiaID

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