 use belcorpBolivia
 go

IF (OBJECT_ID('dbo.InsertarEstrategia_SB2', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.InsertarEstrategia_SB2 AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.InsertarEstrategia_SB2 @EstrategiaID INT
	,@TipoEstrategiaID INT
	,@CampaniaID INT
	,@CampaniaIDFin INT
	,@NumeroPedido INT
	,@Activo BIT
	,@ImagenURL VARCHAR(800)
	,@LimiteVenta INT
	,@DescripcionCUV2 VARCHAR(800)
	,@FlagDescripcion BIT
	,@CUV VARCHAR(20)
	,@EtiquetaID INT
	,@Precio NUMERIC(12, 2)
	,@FlagCEP BIT
	,@CUV2 VARCHAR(20)
	,@EtiquetaID2 INT
	,@Precio2 NUMERIC(12, 2)
	,@FlagCEP2 BIT
	,@TextoLibre VARCHAR(800)
	,@FlagTextoLibre BIT
	,@Cantidad INT
	,@FlagCantidad BIT
	,@Zona VARCHAR(8000)
	,@Orden INT
	,@UsuarioCreacion VARCHAR(100)
	,@UsuarioModificacion VARCHAR(100)
	,@ColorFondo VARCHAR(20)
	,@FlagEstrella BIT
	,@CodigoEstrategia VARCHAR(100)
	,@TieneVariedad INT
	,@EsOfertaIndependiente BIT = 0
	,@Ganancia DECIMAL(18, 2) = 0.0
	,@CodigoPrograma VARCHAR(3) = NULL
	,@CodigoConcurso VARCHAR(6) = NULL
	,@ImagenMiniaturaURL VARCHAR(800) = NULL
	,@EsSubCampania BIT = 0
	,@Niveles VARCHAR(255) = NULL
	,@Retorno INT OUT
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @CodigoTipoEstrategia VARCHAR(5) = ''
		,@TipoEstrategiaIDPackNueva INT = 0
		,@TipoEstrategiaIDOfertaDia INT = 0

	BEGIN TRY
		SET @Retorno = 0

		SELECT @CodigoTipoEstrategia = Codigo
		FROM dbo.TipoEstrategia(NOLOCK)
		WHERE TipoEstrategiaID = @TipoEstrategiaID

		-- Para calcular la etiqueta para pack nuevas  
		SELECT @TipoEstrategiaIDPackNueva = COUNT(1)
		FROM dbo.TipoEstrategia(NOLOCK)
		WHERE TipoEstrategiaID = @TipoEstrategiaID
			AND flagNueva = 1

		-- Para calcular la etiqueta Oferta del día  
		SELECT @TipoEstrategiaIDOfertaDia = COUNT(1)
		FROM dbo.TipoEstrategia(NOLOCK)
		WHERE TipoEstrategiaId = @TipoEstrategiaID
			AND DescripcionEstrategia LIKE '%OFERTA DEL%'

		-- Obtener el EtiquetaID2 de Precio para TI  
		SELECT @EtiquetaID2 = EtiquetaID
		FROM dbo.Etiqueta(NOLOCK)
		WHERE Descripcion LIKE '%PRECIO PARA T%'

		-- Obtener el EtiquetaID de Precio Catalogo.   
		IF ISNULL(@CUV, '') != ''
		BEGIN
			SELECT @EtiquetaID = EtiquetaID
			FROM dbo.Etiqueta(NOLOCK)
			WHERE Descripcion LIKE '%PRECIO CAT%'
		END
		ELSE IF @CodigoTipoEstrategia IN (
				'005'
				,'007'
				,'008'
				,'010'
				,'011'
				)
		BEGIN
			SET @EtiquetaID = 1
		END
		ELSE
		BEGIN
			SET @EtiquetaID = 0
		END

		-- Obtener el EtiquetaID de Ganancia  
		IF @TipoEstrategiaIDPackNueva > 0
		BEGIN
			SELECT @EtiquetaID = EtiquetaID
			FROM dbo.Etiqueta(NOLOCK)
			WHERE Descripcion LIKE '%GANANCIA%'
		END

		-- Obtener el EtiquetaID de la Oferta del día.  
		IF @TipoEstrategiaIDOfertaDia > 0
		BEGIN
			SELECT @EtiquetaID2 = EtiquetaID
			FROM dbo.Etiqueta(NOLOCK)
			WHERE Descripcion LIKE '%OFERTA DEL%'
		END

		IF EXISTS (
				SELECT 1
				FROM dbo.Estrategia(NOLOCK)
				WHERE CUV2 = @CUV2
					AND CampaniaID = @CampaniaID
					AND TipoEstrategiaID = @TipoEstrategiaID
					AND EstrategiaID <> @EstrategiaID
					AND NumeroPedido = @NumeroPedido
				)
		BEGIN
			RAISERROR (
					'El valor de cuv2 a registrar ya existe para el tipo de estrategia y campaña seleccionado.'
					,16
					,1
					)
		END

		IF @CampaniaIDFin > 0
		BEGIN
			IF EXISTS (
					SELECT 1
					FROM dbo.Estrategia(NOLOCK)
					WHERE CUV2 = @CUV2
						AND (
							(
								@CampaniaID BETWEEN CampaniaID
									AND CampaniaIDFin
								)
							OR (
								@CampaniaIDFin BETWEEN CampaniaID
									AND CampaniaIDFin
								)
							)
						AND TipoEstrategiaID = @TipoEstrategiaID
						AND EstrategiaID <> @EstrategiaID
						AND NumeroPedido = @NumeroPedido
					)
			BEGIN
				RAISERROR (
						'El valor de cuv2 a registrar ya existe para el tipo de estrategia y rango de campaña seleccionado.'
						,16
						,1
						)
			END
		END

		IF (
				@CodigoTipoEstrategia NOT IN (
					'001'
					,'005'
					,'007'
					,'008'
					,'010'
					,'011'
					)
				AND ISNULL(@Orden, 0) > 0
				)
		BEGIN
			IF EXISTS (
					SELECT 1
					FROM dbo.Estrategia(NOLOCK)
					WHERE Orden = @Orden
						AND CampaniaID = @CampaniaID
						AND TipoEstrategiaID = @TipoEstrategiaID
						AND EstrategiaID <> @EstrategiaID
						AND NumeroPedido = @NumeroPedido
					)
			BEGIN
				RAISERROR (
						'El orden ingresado para la estrategia ya está siendo utilizado.'
						,16
						,1
						)
			END
		END

		IF NOT EXISTS (
				SELECT 1
				FROM dbo.Estrategia(NOLOCK)
				WHERE EstrategiaID = @EstrategiaID
				)
		BEGIN
			INSERT INTO dbo.Estrategia (
				TipoEstrategiaID
				,CampaniaID
				,CampaniaIDFin
				,NumeroPedido
				,Activo
				,ImagenURL
				,LimiteVenta
				,DescripcionCUV2
				,FlagDescripcion
				,CUV
				,EtiquetaID
				,Precio
				,FlagCEP
				,CUV2
				,EtiquetaID2
				,Precio2
				,FlagCEP2
				,TextoLibre
				,FlagTextoLibre
				,Cantidad
				,FlagCantidad
				,Zona
				,Orden
				,UsuarioCreacion
				,FechaCreacion
				,ColorFondo
				,FlagEstrella
				,CodigoEstrategia
				,TieneVariedad
				,EsOfertaIndependiente
				,Ganancia
				,CodigoPrograma
				,CodigoConcurso
				,ImagenMiniaturaURL
				,EsSubCampania
				,Niveles
				)
			VALUES (
				@TipoEstrategiaID
				,@CampaniaID
				,@CampaniaIDFin
				,@NumeroPedido
				,@Activo
				,@ImagenURL
				,@LimiteVenta
				,@DescripcionCUV2
				,@FlagDescripcion
				,@CUV
				,@EtiquetaID
				,@Precio
				,@FlagCEP
				,@CUV2
				,@EtiquetaID2
				,@Precio2
				,@FlagCEP2
				,@TextoLibre
				,@FlagTextoLibre
				,@Cantidad
				,@FlagCantidad
				,@Zona
				,@Orden
				,@UsuarioCreacion
				,GETDATE()
				,@ColorFondo
				,@FlagEstrella
				,@CodigoEstrategia
				,@TieneVariedad
				,@EsOfertaIndependiente
				,@Ganancia
				,@CodigoPrograma
				,@CodigoConcurso
				,@ImagenMiniaturaURL
				,@EsSubCampania
				,@Niveles
				)

			SET @Retorno = @@IDENTITY
		END
		ELSE
		BEGIN
			UPDATE Estrategia
			SET TipoEstrategiaID = @TipoEstrategiaID
				,CampaniaID = @CampaniaID
				,CampaniaIDFin = @CampaniaIDFin
				,NumeroPedido = @NumeroPedido
				,Activo = @Activo
				,ImagenURL = @ImagenURL
				,LimiteVenta = @LimiteVenta
				,DescripcionCUV2 = @DescripcionCUV2
				,FlagDescripcion = @FlagDescripcion
				,CUV = @CUV
				,EtiquetaID = @EtiquetaID
				,Precio = @Precio
				,FlagCEP = @FlagCEP
				,CUV2 = @CUV2
				,EtiquetaID2 = @EtiquetaID2
				,Precio2 = @Precio2
				,FlagCEP2 = @FlagCEP2
				,TextoLibre = @TextoLibre
				,FlagTextoLibre = @FlagTextoLibre
				,Cantidad = @Cantidad
				,FlagCantidad = @FlagCantidad
				,Zona = @Zona
				,Orden = @Orden
				,UsuarioModificacion = @UsuarioModificacion
				,FechaModificacion = GETDATE()
				,ColorFondo = @ColorFondo
				,FlagEstrella = @FlagEstrella
				,EsOfertaIndependiente = @EsOfertaIndependiente
				,Ganancia = @Ganancia
				,CodigoPrograma = @CodigoPrograma
				,CodigoConcurso = @CodigoConcurso
				,ImagenMiniaturaURL = @ImagenMiniaturaURL
				,EsSubCampania = @EsSubCampania
				,Niveles = @Niveles
			WHERE EstrategiaID = @EstrategiaID

			if(@Activo='1')
			begin
				UPDATE EstrategiaProducto
				SET Activo = 1
				WHERE EstrategiaID = @EstrategiaID and Activo!=1
			end


			SET @Retorno = @EstrategiaID
		END
	END TRY

	BEGIN CATCH
		THROW;
	END CATCH

	SET NOCOUNT OFF
END
GO
use belcorpChile
 go

IF (OBJECT_ID('dbo.InsertarEstrategia_SB2', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.InsertarEstrategia_SB2 AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.InsertarEstrategia_SB2 @EstrategiaID INT
	,@TipoEstrategiaID INT
	,@CampaniaID INT
	,@CampaniaIDFin INT
	,@NumeroPedido INT
	,@Activo BIT
	,@ImagenURL VARCHAR(800)
	,@LimiteVenta INT
	,@DescripcionCUV2 VARCHAR(800)
	,@FlagDescripcion BIT
	,@CUV VARCHAR(20)
	,@EtiquetaID INT
	,@Precio NUMERIC(12, 2)
	,@FlagCEP BIT
	,@CUV2 VARCHAR(20)
	,@EtiquetaID2 INT
	,@Precio2 NUMERIC(12, 2)
	,@FlagCEP2 BIT
	,@TextoLibre VARCHAR(800)
	,@FlagTextoLibre BIT
	,@Cantidad INT
	,@FlagCantidad BIT
	,@Zona VARCHAR(8000)
	,@Orden INT
	,@UsuarioCreacion VARCHAR(100)
	,@UsuarioModificacion VARCHAR(100)
	,@ColorFondo VARCHAR(20)
	,@FlagEstrella BIT
	,@CodigoEstrategia VARCHAR(100)
	,@TieneVariedad INT
	,@EsOfertaIndependiente BIT = 0
	,@Ganancia DECIMAL(18, 2) = 0.0
	,@CodigoPrograma VARCHAR(3) = NULL
	,@CodigoConcurso VARCHAR(6) = NULL
	,@ImagenMiniaturaURL VARCHAR(800) = NULL
	,@EsSubCampania BIT = 0
	,@Niveles VARCHAR(255) = NULL
	,@Retorno INT OUT
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @CodigoTipoEstrategia VARCHAR(5) = ''
		,@TipoEstrategiaIDPackNueva INT = 0
		,@TipoEstrategiaIDOfertaDia INT = 0

	BEGIN TRY
		SET @Retorno = 0

		SELECT @CodigoTipoEstrategia = Codigo
		FROM dbo.TipoEstrategia(NOLOCK)
		WHERE TipoEstrategiaID = @TipoEstrategiaID

		-- Para calcular la etiqueta para pack nuevas  
		SELECT @TipoEstrategiaIDPackNueva = COUNT(1)
		FROM dbo.TipoEstrategia(NOLOCK)
		WHERE TipoEstrategiaID = @TipoEstrategiaID
			AND flagNueva = 1

		-- Para calcular la etiqueta Oferta del día  
		SELECT @TipoEstrategiaIDOfertaDia = COUNT(1)
		FROM dbo.TipoEstrategia(NOLOCK)
		WHERE TipoEstrategiaId = @TipoEstrategiaID
			AND DescripcionEstrategia LIKE '%OFERTA DEL%'

		-- Obtener el EtiquetaID2 de Precio para TI  
		SELECT @EtiquetaID2 = EtiquetaID
		FROM dbo.Etiqueta(NOLOCK)
		WHERE Descripcion LIKE '%PRECIO PARA T%'

		-- Obtener el EtiquetaID de Precio Catalogo.   
		IF ISNULL(@CUV, '') != ''
		BEGIN
			SELECT @EtiquetaID = EtiquetaID
			FROM dbo.Etiqueta(NOLOCK)
			WHERE Descripcion LIKE '%PRECIO CAT%'
		END
		ELSE IF @CodigoTipoEstrategia IN (
				'005'
				,'007'
				,'008'
				,'010'
				,'011'
				)
		BEGIN
			SET @EtiquetaID = 1
		END
		ELSE
		BEGIN
			SET @EtiquetaID = 0
		END

		-- Obtener el EtiquetaID de Ganancia  
		IF @TipoEstrategiaIDPackNueva > 0
		BEGIN
			SELECT @EtiquetaID = EtiquetaID
			FROM dbo.Etiqueta(NOLOCK)
			WHERE Descripcion LIKE '%GANANCIA%'
		END

		-- Obtener el EtiquetaID de la Oferta del día.  
		IF @TipoEstrategiaIDOfertaDia > 0
		BEGIN
			SELECT @EtiquetaID2 = EtiquetaID
			FROM dbo.Etiqueta(NOLOCK)
			WHERE Descripcion LIKE '%OFERTA DEL%'
		END

		IF EXISTS (
				SELECT 1
				FROM dbo.Estrategia(NOLOCK)
				WHERE CUV2 = @CUV2
					AND CampaniaID = @CampaniaID
					AND TipoEstrategiaID = @TipoEstrategiaID
					AND EstrategiaID <> @EstrategiaID
					AND NumeroPedido = @NumeroPedido
				)
		BEGIN
			RAISERROR (
					'El valor de cuv2 a registrar ya existe para el tipo de estrategia y campaña seleccionado.'
					,16
					,1
					)
		END

		IF @CampaniaIDFin > 0
		BEGIN
			IF EXISTS (
					SELECT 1
					FROM dbo.Estrategia(NOLOCK)
					WHERE CUV2 = @CUV2
						AND (
							(
								@CampaniaID BETWEEN CampaniaID
									AND CampaniaIDFin
								)
							OR (
								@CampaniaIDFin BETWEEN CampaniaID
									AND CampaniaIDFin
								)
							)
						AND TipoEstrategiaID = @TipoEstrategiaID
						AND EstrategiaID <> @EstrategiaID
						AND NumeroPedido = @NumeroPedido
					)
			BEGIN
				RAISERROR (
						'El valor de cuv2 a registrar ya existe para el tipo de estrategia y rango de campaña seleccionado.'
						,16
						,1
						)
			END
		END

		IF (
				@CodigoTipoEstrategia NOT IN (
					'001'
					,'005'
					,'007'
					,'008'
					,'010'
					,'011'
					)
				AND ISNULL(@Orden, 0) > 0
				)
		BEGIN
			IF EXISTS (
					SELECT 1
					FROM dbo.Estrategia(NOLOCK)
					WHERE Orden = @Orden
						AND CampaniaID = @CampaniaID
						AND TipoEstrategiaID = @TipoEstrategiaID
						AND EstrategiaID <> @EstrategiaID
						AND NumeroPedido = @NumeroPedido
					)
			BEGIN
				RAISERROR (
						'El orden ingresado para la estrategia ya está siendo utilizado.'
						,16
						,1
						)
			END
		END

		IF NOT EXISTS (
				SELECT 1
				FROM dbo.Estrategia(NOLOCK)
				WHERE EstrategiaID = @EstrategiaID
				)
		BEGIN
			INSERT INTO dbo.Estrategia (
				TipoEstrategiaID
				,CampaniaID
				,CampaniaIDFin
				,NumeroPedido
				,Activo
				,ImagenURL
				,LimiteVenta
				,DescripcionCUV2
				,FlagDescripcion
				,CUV
				,EtiquetaID
				,Precio
				,FlagCEP
				,CUV2
				,EtiquetaID2
				,Precio2
				,FlagCEP2
				,TextoLibre
				,FlagTextoLibre
				,Cantidad
				,FlagCantidad
				,Zona
				,Orden
				,UsuarioCreacion
				,FechaCreacion
				,ColorFondo
				,FlagEstrella
				,CodigoEstrategia
				,TieneVariedad
				,EsOfertaIndependiente
				,Ganancia
				,CodigoPrograma
				,CodigoConcurso
				,ImagenMiniaturaURL
				,EsSubCampania
				,Niveles
				)
			VALUES (
				@TipoEstrategiaID
				,@CampaniaID
				,@CampaniaIDFin
				,@NumeroPedido
				,@Activo
				,@ImagenURL
				,@LimiteVenta
				,@DescripcionCUV2
				,@FlagDescripcion
				,@CUV
				,@EtiquetaID
				,@Precio
				,@FlagCEP
				,@CUV2
				,@EtiquetaID2
				,@Precio2
				,@FlagCEP2
				,@TextoLibre
				,@FlagTextoLibre
				,@Cantidad
				,@FlagCantidad
				,@Zona
				,@Orden
				,@UsuarioCreacion
				,GETDATE()
				,@ColorFondo
				,@FlagEstrella
				,@CodigoEstrategia
				,@TieneVariedad
				,@EsOfertaIndependiente
				,@Ganancia
				,@CodigoPrograma
				,@CodigoConcurso
				,@ImagenMiniaturaURL
				,@EsSubCampania
				,@Niveles
				)

			SET @Retorno = @@IDENTITY
		END
		ELSE
		BEGIN
			UPDATE Estrategia
			SET TipoEstrategiaID = @TipoEstrategiaID
				,CampaniaID = @CampaniaID
				,CampaniaIDFin = @CampaniaIDFin
				,NumeroPedido = @NumeroPedido
				,Activo = @Activo
				,ImagenURL = @ImagenURL
				,LimiteVenta = @LimiteVenta
				,DescripcionCUV2 = @DescripcionCUV2
				,FlagDescripcion = @FlagDescripcion
				,CUV = @CUV
				,EtiquetaID = @EtiquetaID
				,Precio = @Precio
				,FlagCEP = @FlagCEP
				,CUV2 = @CUV2
				,EtiquetaID2 = @EtiquetaID2
				,Precio2 = @Precio2
				,FlagCEP2 = @FlagCEP2
				,TextoLibre = @TextoLibre
				,FlagTextoLibre = @FlagTextoLibre
				,Cantidad = @Cantidad
				,FlagCantidad = @FlagCantidad
				,Zona = @Zona
				,Orden = @Orden
				,UsuarioModificacion = @UsuarioModificacion
				,FechaModificacion = GETDATE()
				,ColorFondo = @ColorFondo
				,FlagEstrella = @FlagEstrella
				,EsOfertaIndependiente = @EsOfertaIndependiente
				,Ganancia = @Ganancia
				,CodigoPrograma = @CodigoPrograma
				,CodigoConcurso = @CodigoConcurso
				,ImagenMiniaturaURL = @ImagenMiniaturaURL
				,EsSubCampania = @EsSubCampania
				,Niveles = @Niveles
			WHERE EstrategiaID = @EstrategiaID

			if(@Activo='1')
			begin
				UPDATE EstrategiaProducto
				SET Activo = 1
				WHERE EstrategiaID = @EstrategiaID and Activo!=1
			end


			SET @Retorno = @EstrategiaID
		END
	END TRY

	BEGIN CATCH
		THROW;
	END CATCH

	SET NOCOUNT OFF
END
GO
use belcorpColombia
 go

IF (OBJECT_ID('dbo.InsertarEstrategia_SB2', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.InsertarEstrategia_SB2 AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.InsertarEstrategia_SB2 @EstrategiaID INT
	,@TipoEstrategiaID INT
	,@CampaniaID INT
	,@CampaniaIDFin INT
	,@NumeroPedido INT
	,@Activo BIT
	,@ImagenURL VARCHAR(800)
	,@LimiteVenta INT
	,@DescripcionCUV2 VARCHAR(800)
	,@FlagDescripcion BIT
	,@CUV VARCHAR(20)
	,@EtiquetaID INT
	,@Precio NUMERIC(12, 2)
	,@FlagCEP BIT
	,@CUV2 VARCHAR(20)
	,@EtiquetaID2 INT
	,@Precio2 NUMERIC(12, 2)
	,@FlagCEP2 BIT
	,@TextoLibre VARCHAR(800)
	,@FlagTextoLibre BIT
	,@Cantidad INT
	,@FlagCantidad BIT
	,@Zona VARCHAR(8000)
	,@Orden INT
	,@UsuarioCreacion VARCHAR(100)
	,@UsuarioModificacion VARCHAR(100)
	,@ColorFondo VARCHAR(20)
	,@FlagEstrella BIT
	,@CodigoEstrategia VARCHAR(100)
	,@TieneVariedad INT
	,@EsOfertaIndependiente BIT = 0
	,@Ganancia DECIMAL(18, 2) = 0.0
	,@CodigoPrograma VARCHAR(3) = NULL
	,@CodigoConcurso VARCHAR(6) = NULL
	,@ImagenMiniaturaURL VARCHAR(800) = NULL
	,@EsSubCampania BIT = 0
	,@Niveles VARCHAR(255) = NULL
	,@Retorno INT OUT
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @CodigoTipoEstrategia VARCHAR(5) = ''
		,@TipoEstrategiaIDPackNueva INT = 0
		,@TipoEstrategiaIDOfertaDia INT = 0

	BEGIN TRY
		SET @Retorno = 0

		SELECT @CodigoTipoEstrategia = Codigo
		FROM dbo.TipoEstrategia(NOLOCK)
		WHERE TipoEstrategiaID = @TipoEstrategiaID

		-- Para calcular la etiqueta para pack nuevas  
		SELECT @TipoEstrategiaIDPackNueva = COUNT(1)
		FROM dbo.TipoEstrategia(NOLOCK)
		WHERE TipoEstrategiaID = @TipoEstrategiaID
			AND flagNueva = 1

		-- Para calcular la etiqueta Oferta del día  
		SELECT @TipoEstrategiaIDOfertaDia = COUNT(1)
		FROM dbo.TipoEstrategia(NOLOCK)
		WHERE TipoEstrategiaId = @TipoEstrategiaID
			AND DescripcionEstrategia LIKE '%OFERTA DEL%'

		-- Obtener el EtiquetaID2 de Precio para TI  
		SELECT @EtiquetaID2 = EtiquetaID
		FROM dbo.Etiqueta(NOLOCK)
		WHERE Descripcion LIKE '%PRECIO PARA T%'

		-- Obtener el EtiquetaID de Precio Catalogo.   
		IF ISNULL(@CUV, '') != ''
		BEGIN
			SELECT @EtiquetaID = EtiquetaID
			FROM dbo.Etiqueta(NOLOCK)
			WHERE Descripcion LIKE '%PRECIO CAT%'
		END
		ELSE IF @CodigoTipoEstrategia IN (
				'005'
				,'007'
				,'008'
				,'010'
				,'011'
				)
		BEGIN
			SET @EtiquetaID = 1
		END
		ELSE
		BEGIN
			SET @EtiquetaID = 0
		END

		-- Obtener el EtiquetaID de Ganancia  
		IF @TipoEstrategiaIDPackNueva > 0
		BEGIN
			SELECT @EtiquetaID = EtiquetaID
			FROM dbo.Etiqueta(NOLOCK)
			WHERE Descripcion LIKE '%GANANCIA%'
		END

		-- Obtener el EtiquetaID de la Oferta del día.  
		IF @TipoEstrategiaIDOfertaDia > 0
		BEGIN
			SELECT @EtiquetaID2 = EtiquetaID
			FROM dbo.Etiqueta(NOLOCK)
			WHERE Descripcion LIKE '%OFERTA DEL%'
		END

		IF EXISTS (
				SELECT 1
				FROM dbo.Estrategia(NOLOCK)
				WHERE CUV2 = @CUV2
					AND CampaniaID = @CampaniaID
					AND TipoEstrategiaID = @TipoEstrategiaID
					AND EstrategiaID <> @EstrategiaID
					AND NumeroPedido = @NumeroPedido
				)
		BEGIN
			RAISERROR (
					'El valor de cuv2 a registrar ya existe para el tipo de estrategia y campaña seleccionado.'
					,16
					,1
					)
		END

		IF @CampaniaIDFin > 0
		BEGIN
			IF EXISTS (
					SELECT 1
					FROM dbo.Estrategia(NOLOCK)
					WHERE CUV2 = @CUV2
						AND (
							(
								@CampaniaID BETWEEN CampaniaID
									AND CampaniaIDFin
								)
							OR (
								@CampaniaIDFin BETWEEN CampaniaID
									AND CampaniaIDFin
								)
							)
						AND TipoEstrategiaID = @TipoEstrategiaID
						AND EstrategiaID <> @EstrategiaID
						AND NumeroPedido = @NumeroPedido
					)
			BEGIN
				RAISERROR (
						'El valor de cuv2 a registrar ya existe para el tipo de estrategia y rango de campaña seleccionado.'
						,16
						,1
						)
			END
		END

		IF (
				@CodigoTipoEstrategia NOT IN (
					'001'
					,'005'
					,'007'
					,'008'
					,'010'
					,'011'
					)
				AND ISNULL(@Orden, 0) > 0
				)
		BEGIN
			IF EXISTS (
					SELECT 1
					FROM dbo.Estrategia(NOLOCK)
					WHERE Orden = @Orden
						AND CampaniaID = @CampaniaID
						AND TipoEstrategiaID = @TipoEstrategiaID
						AND EstrategiaID <> @EstrategiaID
						AND NumeroPedido = @NumeroPedido
					)
			BEGIN
				RAISERROR (
						'El orden ingresado para la estrategia ya está siendo utilizado.'
						,16
						,1
						)
			END
		END

		IF NOT EXISTS (
				SELECT 1
				FROM dbo.Estrategia(NOLOCK)
				WHERE EstrategiaID = @EstrategiaID
				)
		BEGIN
			INSERT INTO dbo.Estrategia (
				TipoEstrategiaID
				,CampaniaID
				,CampaniaIDFin
				,NumeroPedido
				,Activo
				,ImagenURL
				,LimiteVenta
				,DescripcionCUV2
				,FlagDescripcion
				,CUV
				,EtiquetaID
				,Precio
				,FlagCEP
				,CUV2
				,EtiquetaID2
				,Precio2
				,FlagCEP2
				,TextoLibre
				,FlagTextoLibre
				,Cantidad
				,FlagCantidad
				,Zona
				,Orden
				,UsuarioCreacion
				,FechaCreacion
				,ColorFondo
				,FlagEstrella
				,CodigoEstrategia
				,TieneVariedad
				,EsOfertaIndependiente
				,Ganancia
				,CodigoPrograma
				,CodigoConcurso
				,ImagenMiniaturaURL
				,EsSubCampania
				,Niveles
				)
			VALUES (
				@TipoEstrategiaID
				,@CampaniaID
				,@CampaniaIDFin
				,@NumeroPedido
				,@Activo
				,@ImagenURL
				,@LimiteVenta
				,@DescripcionCUV2
				,@FlagDescripcion
				,@CUV
				,@EtiquetaID
				,@Precio
				,@FlagCEP
				,@CUV2
				,@EtiquetaID2
				,@Precio2
				,@FlagCEP2
				,@TextoLibre
				,@FlagTextoLibre
				,@Cantidad
				,@FlagCantidad
				,@Zona
				,@Orden
				,@UsuarioCreacion
				,GETDATE()
				,@ColorFondo
				,@FlagEstrella
				,@CodigoEstrategia
				,@TieneVariedad
				,@EsOfertaIndependiente
				,@Ganancia
				,@CodigoPrograma
				,@CodigoConcurso
				,@ImagenMiniaturaURL
				,@EsSubCampania
				,@Niveles
				)

			SET @Retorno = @@IDENTITY
		END
		ELSE
		BEGIN
			UPDATE Estrategia
			SET TipoEstrategiaID = @TipoEstrategiaID
				,CampaniaID = @CampaniaID
				,CampaniaIDFin = @CampaniaIDFin
				,NumeroPedido = @NumeroPedido
				,Activo = @Activo
				,ImagenURL = @ImagenURL
				,LimiteVenta = @LimiteVenta
				,DescripcionCUV2 = @DescripcionCUV2
				,FlagDescripcion = @FlagDescripcion
				,CUV = @CUV
				,EtiquetaID = @EtiquetaID
				,Precio = @Precio
				,FlagCEP = @FlagCEP
				,CUV2 = @CUV2
				,EtiquetaID2 = @EtiquetaID2
				,Precio2 = @Precio2
				,FlagCEP2 = @FlagCEP2
				,TextoLibre = @TextoLibre
				,FlagTextoLibre = @FlagTextoLibre
				,Cantidad = @Cantidad
				,FlagCantidad = @FlagCantidad
				,Zona = @Zona
				,Orden = @Orden
				,UsuarioModificacion = @UsuarioModificacion
				,FechaModificacion = GETDATE()
				,ColorFondo = @ColorFondo
				,FlagEstrella = @FlagEstrella
				,EsOfertaIndependiente = @EsOfertaIndependiente
				,Ganancia = @Ganancia
				,CodigoPrograma = @CodigoPrograma
				,CodigoConcurso = @CodigoConcurso
				,ImagenMiniaturaURL = @ImagenMiniaturaURL
				,EsSubCampania = @EsSubCampania
				,Niveles = @Niveles
			WHERE EstrategiaID = @EstrategiaID

			if(@Activo='1')
			begin
				UPDATE EstrategiaProducto
				SET Activo = 1
				WHERE EstrategiaID = @EstrategiaID and Activo!=1
			end


			SET @Retorno = @EstrategiaID
		END
	END TRY

	BEGIN CATCH
		THROW;
	END CATCH

	SET NOCOUNT OFF
END
GO
use belcorpCostaRica
 go

IF (OBJECT_ID('dbo.InsertarEstrategia_SB2', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.InsertarEstrategia_SB2 AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.InsertarEstrategia_SB2 @EstrategiaID INT
	,@TipoEstrategiaID INT
	,@CampaniaID INT
	,@CampaniaIDFin INT
	,@NumeroPedido INT
	,@Activo BIT
	,@ImagenURL VARCHAR(800)
	,@LimiteVenta INT
	,@DescripcionCUV2 VARCHAR(800)
	,@FlagDescripcion BIT
	,@CUV VARCHAR(20)
	,@EtiquetaID INT
	,@Precio NUMERIC(12, 2)
	,@FlagCEP BIT
	,@CUV2 VARCHAR(20)
	,@EtiquetaID2 INT
	,@Precio2 NUMERIC(12, 2)
	,@FlagCEP2 BIT
	,@TextoLibre VARCHAR(800)
	,@FlagTextoLibre BIT
	,@Cantidad INT
	,@FlagCantidad BIT
	,@Zona VARCHAR(8000)
	,@Orden INT
	,@UsuarioCreacion VARCHAR(100)
	,@UsuarioModificacion VARCHAR(100)
	,@ColorFondo VARCHAR(20)
	,@FlagEstrella BIT
	,@CodigoEstrategia VARCHAR(100)
	,@TieneVariedad INT
	,@EsOfertaIndependiente BIT = 0
	,@Ganancia DECIMAL(18, 2) = 0.0
	,@CodigoPrograma VARCHAR(3) = NULL
	,@CodigoConcurso VARCHAR(6) = NULL
	,@ImagenMiniaturaURL VARCHAR(800) = NULL
	,@EsSubCampania BIT = 0
	,@Niveles VARCHAR(255) = NULL
	,@Retorno INT OUT
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @CodigoTipoEstrategia VARCHAR(5) = ''
		,@TipoEstrategiaIDPackNueva INT = 0
		,@TipoEstrategiaIDOfertaDia INT = 0

	BEGIN TRY
		SET @Retorno = 0

		SELECT @CodigoTipoEstrategia = Codigo
		FROM dbo.TipoEstrategia(NOLOCK)
		WHERE TipoEstrategiaID = @TipoEstrategiaID

		-- Para calcular la etiqueta para pack nuevas  
		SELECT @TipoEstrategiaIDPackNueva = COUNT(1)
		FROM dbo.TipoEstrategia(NOLOCK)
		WHERE TipoEstrategiaID = @TipoEstrategiaID
			AND flagNueva = 1

		-- Para calcular la etiqueta Oferta del día  
		SELECT @TipoEstrategiaIDOfertaDia = COUNT(1)
		FROM dbo.TipoEstrategia(NOLOCK)
		WHERE TipoEstrategiaId = @TipoEstrategiaID
			AND DescripcionEstrategia LIKE '%OFERTA DEL%'

		-- Obtener el EtiquetaID2 de Precio para TI  
		SELECT @EtiquetaID2 = EtiquetaID
		FROM dbo.Etiqueta(NOLOCK)
		WHERE Descripcion LIKE '%PRECIO PARA T%'

		-- Obtener el EtiquetaID de Precio Catalogo.   
		IF ISNULL(@CUV, '') != ''
		BEGIN
			SELECT @EtiquetaID = EtiquetaID
			FROM dbo.Etiqueta(NOLOCK)
			WHERE Descripcion LIKE '%PRECIO CAT%'
		END
		ELSE IF @CodigoTipoEstrategia IN (
				'005'
				,'007'
				,'008'
				,'010'
				,'011'
				)
		BEGIN
			SET @EtiquetaID = 1
		END
		ELSE
		BEGIN
			SET @EtiquetaID = 0
		END

		-- Obtener el EtiquetaID de Ganancia  
		IF @TipoEstrategiaIDPackNueva > 0
		BEGIN
			SELECT @EtiquetaID = EtiquetaID
			FROM dbo.Etiqueta(NOLOCK)
			WHERE Descripcion LIKE '%GANANCIA%'
		END

		-- Obtener el EtiquetaID de la Oferta del día.  
		IF @TipoEstrategiaIDOfertaDia > 0
		BEGIN
			SELECT @EtiquetaID2 = EtiquetaID
			FROM dbo.Etiqueta(NOLOCK)
			WHERE Descripcion LIKE '%OFERTA DEL%'
		END

		IF EXISTS (
				SELECT 1
				FROM dbo.Estrategia(NOLOCK)
				WHERE CUV2 = @CUV2
					AND CampaniaID = @CampaniaID
					AND TipoEstrategiaID = @TipoEstrategiaID
					AND EstrategiaID <> @EstrategiaID
					AND NumeroPedido = @NumeroPedido
				)
		BEGIN
			RAISERROR (
					'El valor de cuv2 a registrar ya existe para el tipo de estrategia y campaña seleccionado.'
					,16
					,1
					)
		END

		IF @CampaniaIDFin > 0
		BEGIN
			IF EXISTS (
					SELECT 1
					FROM dbo.Estrategia(NOLOCK)
					WHERE CUV2 = @CUV2
						AND (
							(
								@CampaniaID BETWEEN CampaniaID
									AND CampaniaIDFin
								)
							OR (
								@CampaniaIDFin BETWEEN CampaniaID
									AND CampaniaIDFin
								)
							)
						AND TipoEstrategiaID = @TipoEstrategiaID
						AND EstrategiaID <> @EstrategiaID
						AND NumeroPedido = @NumeroPedido
					)
			BEGIN
				RAISERROR (
						'El valor de cuv2 a registrar ya existe para el tipo de estrategia y rango de campaña seleccionado.'
						,16
						,1
						)
			END
		END

		IF (
				@CodigoTipoEstrategia NOT IN (
					'001'
					,'005'
					,'007'
					,'008'
					,'010'
					,'011'
					)
				AND ISNULL(@Orden, 0) > 0
				)
		BEGIN
			IF EXISTS (
					SELECT 1
					FROM dbo.Estrategia(NOLOCK)
					WHERE Orden = @Orden
						AND CampaniaID = @CampaniaID
						AND TipoEstrategiaID = @TipoEstrategiaID
						AND EstrategiaID <> @EstrategiaID
						AND NumeroPedido = @NumeroPedido
					)
			BEGIN
				RAISERROR (
						'El orden ingresado para la estrategia ya está siendo utilizado.'
						,16
						,1
						)
			END
		END

		IF NOT EXISTS (
				SELECT 1
				FROM dbo.Estrategia(NOLOCK)
				WHERE EstrategiaID = @EstrategiaID
				)
		BEGIN
			INSERT INTO dbo.Estrategia (
				TipoEstrategiaID
				,CampaniaID
				,CampaniaIDFin
				,NumeroPedido
				,Activo
				,ImagenURL
				,LimiteVenta
				,DescripcionCUV2
				,FlagDescripcion
				,CUV
				,EtiquetaID
				,Precio
				,FlagCEP
				,CUV2
				,EtiquetaID2
				,Precio2
				,FlagCEP2
				,TextoLibre
				,FlagTextoLibre
				,Cantidad
				,FlagCantidad
				,Zona
				,Orden
				,UsuarioCreacion
				,FechaCreacion
				,ColorFondo
				,FlagEstrella
				,CodigoEstrategia
				,TieneVariedad
				,EsOfertaIndependiente
				,Ganancia
				,CodigoPrograma
				,CodigoConcurso
				,ImagenMiniaturaURL
				,EsSubCampania
				,Niveles
				)
			VALUES (
				@TipoEstrategiaID
				,@CampaniaID
				,@CampaniaIDFin
				,@NumeroPedido
				,@Activo
				,@ImagenURL
				,@LimiteVenta
				,@DescripcionCUV2
				,@FlagDescripcion
				,@CUV
				,@EtiquetaID
				,@Precio
				,@FlagCEP
				,@CUV2
				,@EtiquetaID2
				,@Precio2
				,@FlagCEP2
				,@TextoLibre
				,@FlagTextoLibre
				,@Cantidad
				,@FlagCantidad
				,@Zona
				,@Orden
				,@UsuarioCreacion
				,GETDATE()
				,@ColorFondo
				,@FlagEstrella
				,@CodigoEstrategia
				,@TieneVariedad
				,@EsOfertaIndependiente
				,@Ganancia
				,@CodigoPrograma
				,@CodigoConcurso
				,@ImagenMiniaturaURL
				,@EsSubCampania
				,@Niveles
				)

			SET @Retorno = @@IDENTITY
		END
		ELSE
		BEGIN
			UPDATE Estrategia
			SET TipoEstrategiaID = @TipoEstrategiaID
				,CampaniaID = @CampaniaID
				,CampaniaIDFin = @CampaniaIDFin
				,NumeroPedido = @NumeroPedido
				,Activo = @Activo
				,ImagenURL = @ImagenURL
				,LimiteVenta = @LimiteVenta
				,DescripcionCUV2 = @DescripcionCUV2
				,FlagDescripcion = @FlagDescripcion
				,CUV = @CUV
				,EtiquetaID = @EtiquetaID
				,Precio = @Precio
				,FlagCEP = @FlagCEP
				,CUV2 = @CUV2
				,EtiquetaID2 = @EtiquetaID2
				,Precio2 = @Precio2
				,FlagCEP2 = @FlagCEP2
				,TextoLibre = @TextoLibre
				,FlagTextoLibre = @FlagTextoLibre
				,Cantidad = @Cantidad
				,FlagCantidad = @FlagCantidad
				,Zona = @Zona
				,Orden = @Orden
				,UsuarioModificacion = @UsuarioModificacion
				,FechaModificacion = GETDATE()
				,ColorFondo = @ColorFondo
				,FlagEstrella = @FlagEstrella
				,EsOfertaIndependiente = @EsOfertaIndependiente
				,Ganancia = @Ganancia
				,CodigoPrograma = @CodigoPrograma
				,CodigoConcurso = @CodigoConcurso
				,ImagenMiniaturaURL = @ImagenMiniaturaURL
				,EsSubCampania = @EsSubCampania
				,Niveles = @Niveles
			WHERE EstrategiaID = @EstrategiaID

			if(@Activo='1')
			begin
				UPDATE EstrategiaProducto
				SET Activo = 1
				WHERE EstrategiaID = @EstrategiaID and Activo!=1
			end


			SET @Retorno = @EstrategiaID
		END
	END TRY

	BEGIN CATCH
		THROW;
	END CATCH

	SET NOCOUNT OFF
END
GO
use belcorpDominicana
 go

IF (OBJECT_ID('dbo.InsertarEstrategia_SB2', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.InsertarEstrategia_SB2 AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.InsertarEstrategia_SB2 @EstrategiaID INT
	,@TipoEstrategiaID INT
	,@CampaniaID INT
	,@CampaniaIDFin INT
	,@NumeroPedido INT
	,@Activo BIT
	,@ImagenURL VARCHAR(800)
	,@LimiteVenta INT
	,@DescripcionCUV2 VARCHAR(800)
	,@FlagDescripcion BIT
	,@CUV VARCHAR(20)
	,@EtiquetaID INT
	,@Precio NUMERIC(12, 2)
	,@FlagCEP BIT
	,@CUV2 VARCHAR(20)
	,@EtiquetaID2 INT
	,@Precio2 NUMERIC(12, 2)
	,@FlagCEP2 BIT
	,@TextoLibre VARCHAR(800)
	,@FlagTextoLibre BIT
	,@Cantidad INT
	,@FlagCantidad BIT
	,@Zona VARCHAR(8000)
	,@Orden INT
	,@UsuarioCreacion VARCHAR(100)
	,@UsuarioModificacion VARCHAR(100)
	,@ColorFondo VARCHAR(20)
	,@FlagEstrella BIT
	,@CodigoEstrategia VARCHAR(100)
	,@TieneVariedad INT
	,@EsOfertaIndependiente BIT = 0
	,@Ganancia DECIMAL(18, 2) = 0.0
	,@CodigoPrograma VARCHAR(3) = NULL
	,@CodigoConcurso VARCHAR(6) = NULL
	,@ImagenMiniaturaURL VARCHAR(800) = NULL
	,@EsSubCampania BIT = 0
	,@Niveles VARCHAR(255) = NULL
	,@Retorno INT OUT
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @CodigoTipoEstrategia VARCHAR(5) = ''
		,@TipoEstrategiaIDPackNueva INT = 0
		,@TipoEstrategiaIDOfertaDia INT = 0

	BEGIN TRY
		SET @Retorno = 0

		SELECT @CodigoTipoEstrategia = Codigo
		FROM dbo.TipoEstrategia(NOLOCK)
		WHERE TipoEstrategiaID = @TipoEstrategiaID

		-- Para calcular la etiqueta para pack nuevas  
		SELECT @TipoEstrategiaIDPackNueva = COUNT(1)
		FROM dbo.TipoEstrategia(NOLOCK)
		WHERE TipoEstrategiaID = @TipoEstrategiaID
			AND flagNueva = 1

		-- Para calcular la etiqueta Oferta del día  
		SELECT @TipoEstrategiaIDOfertaDia = COUNT(1)
		FROM dbo.TipoEstrategia(NOLOCK)
		WHERE TipoEstrategiaId = @TipoEstrategiaID
			AND DescripcionEstrategia LIKE '%OFERTA DEL%'

		-- Obtener el EtiquetaID2 de Precio para TI  
		SELECT @EtiquetaID2 = EtiquetaID
		FROM dbo.Etiqueta(NOLOCK)
		WHERE Descripcion LIKE '%PRECIO PARA T%'

		-- Obtener el EtiquetaID de Precio Catalogo.   
		IF ISNULL(@CUV, '') != ''
		BEGIN
			SELECT @EtiquetaID = EtiquetaID
			FROM dbo.Etiqueta(NOLOCK)
			WHERE Descripcion LIKE '%PRECIO CAT%'
		END
		ELSE IF @CodigoTipoEstrategia IN (
				'005'
				,'007'
				,'008'
				,'010'
				,'011'
				)
		BEGIN
			SET @EtiquetaID = 1
		END
		ELSE
		BEGIN
			SET @EtiquetaID = 0
		END

		-- Obtener el EtiquetaID de Ganancia  
		IF @TipoEstrategiaIDPackNueva > 0
		BEGIN
			SELECT @EtiquetaID = EtiquetaID
			FROM dbo.Etiqueta(NOLOCK)
			WHERE Descripcion LIKE '%GANANCIA%'
		END

		-- Obtener el EtiquetaID de la Oferta del día.  
		IF @TipoEstrategiaIDOfertaDia > 0
		BEGIN
			SELECT @EtiquetaID2 = EtiquetaID
			FROM dbo.Etiqueta(NOLOCK)
			WHERE Descripcion LIKE '%OFERTA DEL%'
		END

		IF EXISTS (
				SELECT 1
				FROM dbo.Estrategia(NOLOCK)
				WHERE CUV2 = @CUV2
					AND CampaniaID = @CampaniaID
					AND TipoEstrategiaID = @TipoEstrategiaID
					AND EstrategiaID <> @EstrategiaID
					AND NumeroPedido = @NumeroPedido
				)
		BEGIN
			RAISERROR (
					'El valor de cuv2 a registrar ya existe para el tipo de estrategia y campaña seleccionado.'
					,16
					,1
					)
		END

		IF @CampaniaIDFin > 0
		BEGIN
			IF EXISTS (
					SELECT 1
					FROM dbo.Estrategia(NOLOCK)
					WHERE CUV2 = @CUV2
						AND (
							(
								@CampaniaID BETWEEN CampaniaID
									AND CampaniaIDFin
								)
							OR (
								@CampaniaIDFin BETWEEN CampaniaID
									AND CampaniaIDFin
								)
							)
						AND TipoEstrategiaID = @TipoEstrategiaID
						AND EstrategiaID <> @EstrategiaID
						AND NumeroPedido = @NumeroPedido
					)
			BEGIN
				RAISERROR (
						'El valor de cuv2 a registrar ya existe para el tipo de estrategia y rango de campaña seleccionado.'
						,16
						,1
						)
			END
		END

		IF (
				@CodigoTipoEstrategia NOT IN (
					'001'
					,'005'
					,'007'
					,'008'
					,'010'
					,'011'
					)
				AND ISNULL(@Orden, 0) > 0
				)
		BEGIN
			IF EXISTS (
					SELECT 1
					FROM dbo.Estrategia(NOLOCK)
					WHERE Orden = @Orden
						AND CampaniaID = @CampaniaID
						AND TipoEstrategiaID = @TipoEstrategiaID
						AND EstrategiaID <> @EstrategiaID
						AND NumeroPedido = @NumeroPedido
					)
			BEGIN
				RAISERROR (
						'El orden ingresado para la estrategia ya está siendo utilizado.'
						,16
						,1
						)
			END
		END

		IF NOT EXISTS (
				SELECT 1
				FROM dbo.Estrategia(NOLOCK)
				WHERE EstrategiaID = @EstrategiaID
				)
		BEGIN
			INSERT INTO dbo.Estrategia (
				TipoEstrategiaID
				,CampaniaID
				,CampaniaIDFin
				,NumeroPedido
				,Activo
				,ImagenURL
				,LimiteVenta
				,DescripcionCUV2
				,FlagDescripcion
				,CUV
				,EtiquetaID
				,Precio
				,FlagCEP
				,CUV2
				,EtiquetaID2
				,Precio2
				,FlagCEP2
				,TextoLibre
				,FlagTextoLibre
				,Cantidad
				,FlagCantidad
				,Zona
				,Orden
				,UsuarioCreacion
				,FechaCreacion
				,ColorFondo
				,FlagEstrella
				,CodigoEstrategia
				,TieneVariedad
				,EsOfertaIndependiente
				,Ganancia
				,CodigoPrograma
				,CodigoConcurso
				,ImagenMiniaturaURL
				,EsSubCampania
				,Niveles
				)
			VALUES (
				@TipoEstrategiaID
				,@CampaniaID
				,@CampaniaIDFin
				,@NumeroPedido
				,@Activo
				,@ImagenURL
				,@LimiteVenta
				,@DescripcionCUV2
				,@FlagDescripcion
				,@CUV
				,@EtiquetaID
				,@Precio
				,@FlagCEP
				,@CUV2
				,@EtiquetaID2
				,@Precio2
				,@FlagCEP2
				,@TextoLibre
				,@FlagTextoLibre
				,@Cantidad
				,@FlagCantidad
				,@Zona
				,@Orden
				,@UsuarioCreacion
				,GETDATE()
				,@ColorFondo
				,@FlagEstrella
				,@CodigoEstrategia
				,@TieneVariedad
				,@EsOfertaIndependiente
				,@Ganancia
				,@CodigoPrograma
				,@CodigoConcurso
				,@ImagenMiniaturaURL
				,@EsSubCampania
				,@Niveles
				)

			SET @Retorno = @@IDENTITY
		END
		ELSE
		BEGIN
			UPDATE Estrategia
			SET TipoEstrategiaID = @TipoEstrategiaID
				,CampaniaID = @CampaniaID
				,CampaniaIDFin = @CampaniaIDFin
				,NumeroPedido = @NumeroPedido
				,Activo = @Activo
				,ImagenURL = @ImagenURL
				,LimiteVenta = @LimiteVenta
				,DescripcionCUV2 = @DescripcionCUV2
				,FlagDescripcion = @FlagDescripcion
				,CUV = @CUV
				,EtiquetaID = @EtiquetaID
				,Precio = @Precio
				,FlagCEP = @FlagCEP
				,CUV2 = @CUV2
				,EtiquetaID2 = @EtiquetaID2
				,Precio2 = @Precio2
				,FlagCEP2 = @FlagCEP2
				,TextoLibre = @TextoLibre
				,FlagTextoLibre = @FlagTextoLibre
				,Cantidad = @Cantidad
				,FlagCantidad = @FlagCantidad
				,Zona = @Zona
				,Orden = @Orden
				,UsuarioModificacion = @UsuarioModificacion
				,FechaModificacion = GETDATE()
				,ColorFondo = @ColorFondo
				,FlagEstrella = @FlagEstrella
				,EsOfertaIndependiente = @EsOfertaIndependiente
				,Ganancia = @Ganancia
				,CodigoPrograma = @CodigoPrograma
				,CodigoConcurso = @CodigoConcurso
				,ImagenMiniaturaURL = @ImagenMiniaturaURL
				,EsSubCampania = @EsSubCampania
				,Niveles = @Niveles
			WHERE EstrategiaID = @EstrategiaID

			if(@Activo='1')
			begin
				UPDATE EstrategiaProducto
				SET Activo = 1
				WHERE EstrategiaID = @EstrategiaID and Activo!=1
			end


			SET @Retorno = @EstrategiaID
		END
	END TRY

	BEGIN CATCH
		THROW;
	END CATCH

	SET NOCOUNT OFF
END
GO
use belcorpEcuador
 go

IF (OBJECT_ID('dbo.InsertarEstrategia_SB2', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.InsertarEstrategia_SB2 AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.InsertarEstrategia_SB2 @EstrategiaID INT
	,@TipoEstrategiaID INT
	,@CampaniaID INT
	,@CampaniaIDFin INT
	,@NumeroPedido INT
	,@Activo BIT
	,@ImagenURL VARCHAR(800)
	,@LimiteVenta INT
	,@DescripcionCUV2 VARCHAR(800)
	,@FlagDescripcion BIT
	,@CUV VARCHAR(20)
	,@EtiquetaID INT
	,@Precio NUMERIC(12, 2)
	,@FlagCEP BIT
	,@CUV2 VARCHAR(20)
	,@EtiquetaID2 INT
	,@Precio2 NUMERIC(12, 2)
	,@FlagCEP2 BIT
	,@TextoLibre VARCHAR(800)
	,@FlagTextoLibre BIT
	,@Cantidad INT
	,@FlagCantidad BIT
	,@Zona VARCHAR(8000)
	,@Orden INT
	,@UsuarioCreacion VARCHAR(100)
	,@UsuarioModificacion VARCHAR(100)
	,@ColorFondo VARCHAR(20)
	,@FlagEstrella BIT
	,@CodigoEstrategia VARCHAR(100)
	,@TieneVariedad INT
	,@EsOfertaIndependiente BIT = 0
	,@Ganancia DECIMAL(18, 2) = 0.0
	,@CodigoPrograma VARCHAR(3) = NULL
	,@CodigoConcurso VARCHAR(6) = NULL
	,@ImagenMiniaturaURL VARCHAR(800) = NULL
	,@EsSubCampania BIT = 0
	,@Niveles VARCHAR(255) = NULL
	,@Retorno INT OUT
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @CodigoTipoEstrategia VARCHAR(5) = ''
		,@TipoEstrategiaIDPackNueva INT = 0
		,@TipoEstrategiaIDOfertaDia INT = 0

	BEGIN TRY
		SET @Retorno = 0

		SELECT @CodigoTipoEstrategia = Codigo
		FROM dbo.TipoEstrategia(NOLOCK)
		WHERE TipoEstrategiaID = @TipoEstrategiaID

		-- Para calcular la etiqueta para pack nuevas  
		SELECT @TipoEstrategiaIDPackNueva = COUNT(1)
		FROM dbo.TipoEstrategia(NOLOCK)
		WHERE TipoEstrategiaID = @TipoEstrategiaID
			AND flagNueva = 1

		-- Para calcular la etiqueta Oferta del día  
		SELECT @TipoEstrategiaIDOfertaDia = COUNT(1)
		FROM dbo.TipoEstrategia(NOLOCK)
		WHERE TipoEstrategiaId = @TipoEstrategiaID
			AND DescripcionEstrategia LIKE '%OFERTA DEL%'

		-- Obtener el EtiquetaID2 de Precio para TI  
		SELECT @EtiquetaID2 = EtiquetaID
		FROM dbo.Etiqueta(NOLOCK)
		WHERE Descripcion LIKE '%PRECIO PARA T%'

		-- Obtener el EtiquetaID de Precio Catalogo.   
		IF ISNULL(@CUV, '') != ''
		BEGIN
			SELECT @EtiquetaID = EtiquetaID
			FROM dbo.Etiqueta(NOLOCK)
			WHERE Descripcion LIKE '%PRECIO CAT%'
		END
		ELSE IF @CodigoTipoEstrategia IN (
				'005'
				,'007'
				,'008'
				,'010'
				,'011'
				)
		BEGIN
			SET @EtiquetaID = 1
		END
		ELSE
		BEGIN
			SET @EtiquetaID = 0
		END

		-- Obtener el EtiquetaID de Ganancia  
		IF @TipoEstrategiaIDPackNueva > 0
		BEGIN
			SELECT @EtiquetaID = EtiquetaID
			FROM dbo.Etiqueta(NOLOCK)
			WHERE Descripcion LIKE '%GANANCIA%'
		END

		-- Obtener el EtiquetaID de la Oferta del día.  
		IF @TipoEstrategiaIDOfertaDia > 0
		BEGIN
			SELECT @EtiquetaID2 = EtiquetaID
			FROM dbo.Etiqueta(NOLOCK)
			WHERE Descripcion LIKE '%OFERTA DEL%'
		END

		IF EXISTS (
				SELECT 1
				FROM dbo.Estrategia(NOLOCK)
				WHERE CUV2 = @CUV2
					AND CampaniaID = @CampaniaID
					AND TipoEstrategiaID = @TipoEstrategiaID
					AND EstrategiaID <> @EstrategiaID
					AND NumeroPedido = @NumeroPedido
				)
		BEGIN
			RAISERROR (
					'El valor de cuv2 a registrar ya existe para el tipo de estrategia y campaña seleccionado.'
					,16
					,1
					)
		END

		IF @CampaniaIDFin > 0
		BEGIN
			IF EXISTS (
					SELECT 1
					FROM dbo.Estrategia(NOLOCK)
					WHERE CUV2 = @CUV2
						AND (
							(
								@CampaniaID BETWEEN CampaniaID
									AND CampaniaIDFin
								)
							OR (
								@CampaniaIDFin BETWEEN CampaniaID
									AND CampaniaIDFin
								)
							)
						AND TipoEstrategiaID = @TipoEstrategiaID
						AND EstrategiaID <> @EstrategiaID
						AND NumeroPedido = @NumeroPedido
					)
			BEGIN
				RAISERROR (
						'El valor de cuv2 a registrar ya existe para el tipo de estrategia y rango de campaña seleccionado.'
						,16
						,1
						)
			END
		END

		IF (
				@CodigoTipoEstrategia NOT IN (
					'001'
					,'005'
					,'007'
					,'008'
					,'010'
					,'011'
					)
				AND ISNULL(@Orden, 0) > 0
				)
		BEGIN
			IF EXISTS (
					SELECT 1
					FROM dbo.Estrategia(NOLOCK)
					WHERE Orden = @Orden
						AND CampaniaID = @CampaniaID
						AND TipoEstrategiaID = @TipoEstrategiaID
						AND EstrategiaID <> @EstrategiaID
						AND NumeroPedido = @NumeroPedido
					)
			BEGIN
				RAISERROR (
						'El orden ingresado para la estrategia ya está siendo utilizado.'
						,16
						,1
						)
			END
		END

		IF NOT EXISTS (
				SELECT 1
				FROM dbo.Estrategia(NOLOCK)
				WHERE EstrategiaID = @EstrategiaID
				)
		BEGIN
			INSERT INTO dbo.Estrategia (
				TipoEstrategiaID
				,CampaniaID
				,CampaniaIDFin
				,NumeroPedido
				,Activo
				,ImagenURL
				,LimiteVenta
				,DescripcionCUV2
				,FlagDescripcion
				,CUV
				,EtiquetaID
				,Precio
				,FlagCEP
				,CUV2
				,EtiquetaID2
				,Precio2
				,FlagCEP2
				,TextoLibre
				,FlagTextoLibre
				,Cantidad
				,FlagCantidad
				,Zona
				,Orden
				,UsuarioCreacion
				,FechaCreacion
				,ColorFondo
				,FlagEstrella
				,CodigoEstrategia
				,TieneVariedad
				,EsOfertaIndependiente
				,Ganancia
				,CodigoPrograma
				,CodigoConcurso
				,ImagenMiniaturaURL
				,EsSubCampania
				,Niveles
				)
			VALUES (
				@TipoEstrategiaID
				,@CampaniaID
				,@CampaniaIDFin
				,@NumeroPedido
				,@Activo
				,@ImagenURL
				,@LimiteVenta
				,@DescripcionCUV2
				,@FlagDescripcion
				,@CUV
				,@EtiquetaID
				,@Precio
				,@FlagCEP
				,@CUV2
				,@EtiquetaID2
				,@Precio2
				,@FlagCEP2
				,@TextoLibre
				,@FlagTextoLibre
				,@Cantidad
				,@FlagCantidad
				,@Zona
				,@Orden
				,@UsuarioCreacion
				,GETDATE()
				,@ColorFondo
				,@FlagEstrella
				,@CodigoEstrategia
				,@TieneVariedad
				,@EsOfertaIndependiente
				,@Ganancia
				,@CodigoPrograma
				,@CodigoConcurso
				,@ImagenMiniaturaURL
				,@EsSubCampania
				,@Niveles
				)

			SET @Retorno = @@IDENTITY
		END
		ELSE
		BEGIN
			UPDATE Estrategia
			SET TipoEstrategiaID = @TipoEstrategiaID
				,CampaniaID = @CampaniaID
				,CampaniaIDFin = @CampaniaIDFin
				,NumeroPedido = @NumeroPedido
				,Activo = @Activo
				,ImagenURL = @ImagenURL
				,LimiteVenta = @LimiteVenta
				,DescripcionCUV2 = @DescripcionCUV2
				,FlagDescripcion = @FlagDescripcion
				,CUV = @CUV
				,EtiquetaID = @EtiquetaID
				,Precio = @Precio
				,FlagCEP = @FlagCEP
				,CUV2 = @CUV2
				,EtiquetaID2 = @EtiquetaID2
				,Precio2 = @Precio2
				,FlagCEP2 = @FlagCEP2
				,TextoLibre = @TextoLibre
				,FlagTextoLibre = @FlagTextoLibre
				,Cantidad = @Cantidad
				,FlagCantidad = @FlagCantidad
				,Zona = @Zona
				,Orden = @Orden
				,UsuarioModificacion = @UsuarioModificacion
				,FechaModificacion = GETDATE()
				,ColorFondo = @ColorFondo
				,FlagEstrella = @FlagEstrella
				,EsOfertaIndependiente = @EsOfertaIndependiente
				,Ganancia = @Ganancia
				,CodigoPrograma = @CodigoPrograma
				,CodigoConcurso = @CodigoConcurso
				,ImagenMiniaturaURL = @ImagenMiniaturaURL
				,EsSubCampania = @EsSubCampania
				,Niveles = @Niveles
			WHERE EstrategiaID = @EstrategiaID

			if(@Activo='1')
			begin
				UPDATE EstrategiaProducto
				SET Activo = 1
				WHERE EstrategiaID = @EstrategiaID and Activo!=1
			end


			SET @Retorno = @EstrategiaID
		END
	END TRY

	BEGIN CATCH
		THROW;
	END CATCH

	SET NOCOUNT OFF
END
GO
use belcorpGuatemala
 go

IF (OBJECT_ID('dbo.InsertarEstrategia_SB2', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.InsertarEstrategia_SB2 AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.InsertarEstrategia_SB2 @EstrategiaID INT
	,@TipoEstrategiaID INT
	,@CampaniaID INT
	,@CampaniaIDFin INT
	,@NumeroPedido INT
	,@Activo BIT
	,@ImagenURL VARCHAR(800)
	,@LimiteVenta INT
	,@DescripcionCUV2 VARCHAR(800)
	,@FlagDescripcion BIT
	,@CUV VARCHAR(20)
	,@EtiquetaID INT
	,@Precio NUMERIC(12, 2)
	,@FlagCEP BIT
	,@CUV2 VARCHAR(20)
	,@EtiquetaID2 INT
	,@Precio2 NUMERIC(12, 2)
	,@FlagCEP2 BIT
	,@TextoLibre VARCHAR(800)
	,@FlagTextoLibre BIT
	,@Cantidad INT
	,@FlagCantidad BIT
	,@Zona VARCHAR(8000)
	,@Orden INT
	,@UsuarioCreacion VARCHAR(100)
	,@UsuarioModificacion VARCHAR(100)
	,@ColorFondo VARCHAR(20)
	,@FlagEstrella BIT
	,@CodigoEstrategia VARCHAR(100)
	,@TieneVariedad INT
	,@EsOfertaIndependiente BIT = 0
	,@Ganancia DECIMAL(18, 2) = 0.0
	,@CodigoPrograma VARCHAR(3) = NULL
	,@CodigoConcurso VARCHAR(6) = NULL
	,@ImagenMiniaturaURL VARCHAR(800) = NULL
	,@EsSubCampania BIT = 0
	,@Niveles VARCHAR(255) = NULL
	,@Retorno INT OUT
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @CodigoTipoEstrategia VARCHAR(5) = ''
		,@TipoEstrategiaIDPackNueva INT = 0
		,@TipoEstrategiaIDOfertaDia INT = 0

	BEGIN TRY
		SET @Retorno = 0

		SELECT @CodigoTipoEstrategia = Codigo
		FROM dbo.TipoEstrategia(NOLOCK)
		WHERE TipoEstrategiaID = @TipoEstrategiaID

		-- Para calcular la etiqueta para pack nuevas  
		SELECT @TipoEstrategiaIDPackNueva = COUNT(1)
		FROM dbo.TipoEstrategia(NOLOCK)
		WHERE TipoEstrategiaID = @TipoEstrategiaID
			AND flagNueva = 1

		-- Para calcular la etiqueta Oferta del día  
		SELECT @TipoEstrategiaIDOfertaDia = COUNT(1)
		FROM dbo.TipoEstrategia(NOLOCK)
		WHERE TipoEstrategiaId = @TipoEstrategiaID
			AND DescripcionEstrategia LIKE '%OFERTA DEL%'

		-- Obtener el EtiquetaID2 de Precio para TI  
		SELECT @EtiquetaID2 = EtiquetaID
		FROM dbo.Etiqueta(NOLOCK)
		WHERE Descripcion LIKE '%PRECIO PARA T%'

		-- Obtener el EtiquetaID de Precio Catalogo.   
		IF ISNULL(@CUV, '') != ''
		BEGIN
			SELECT @EtiquetaID = EtiquetaID
			FROM dbo.Etiqueta(NOLOCK)
			WHERE Descripcion LIKE '%PRECIO CAT%'
		END
		ELSE IF @CodigoTipoEstrategia IN (
				'005'
				,'007'
				,'008'
				,'010'
				,'011'
				)
		BEGIN
			SET @EtiquetaID = 1
		END
		ELSE
		BEGIN
			SET @EtiquetaID = 0
		END

		-- Obtener el EtiquetaID de Ganancia  
		IF @TipoEstrategiaIDPackNueva > 0
		BEGIN
			SELECT @EtiquetaID = EtiquetaID
			FROM dbo.Etiqueta(NOLOCK)
			WHERE Descripcion LIKE '%GANANCIA%'
		END

		-- Obtener el EtiquetaID de la Oferta del día.  
		IF @TipoEstrategiaIDOfertaDia > 0
		BEGIN
			SELECT @EtiquetaID2 = EtiquetaID
			FROM dbo.Etiqueta(NOLOCK)
			WHERE Descripcion LIKE '%OFERTA DEL%'
		END

		IF EXISTS (
				SELECT 1
				FROM dbo.Estrategia(NOLOCK)
				WHERE CUV2 = @CUV2
					AND CampaniaID = @CampaniaID
					AND TipoEstrategiaID = @TipoEstrategiaID
					AND EstrategiaID <> @EstrategiaID
					AND NumeroPedido = @NumeroPedido
				)
		BEGIN
			RAISERROR (
					'El valor de cuv2 a registrar ya existe para el tipo de estrategia y campaña seleccionado.'
					,16
					,1
					)
		END

		IF @CampaniaIDFin > 0
		BEGIN
			IF EXISTS (
					SELECT 1
					FROM dbo.Estrategia(NOLOCK)
					WHERE CUV2 = @CUV2
						AND (
							(
								@CampaniaID BETWEEN CampaniaID
									AND CampaniaIDFin
								)
							OR (
								@CampaniaIDFin BETWEEN CampaniaID
									AND CampaniaIDFin
								)
							)
						AND TipoEstrategiaID = @TipoEstrategiaID
						AND EstrategiaID <> @EstrategiaID
						AND NumeroPedido = @NumeroPedido
					)
			BEGIN
				RAISERROR (
						'El valor de cuv2 a registrar ya existe para el tipo de estrategia y rango de campaña seleccionado.'
						,16
						,1
						)
			END
		END

		IF (
				@CodigoTipoEstrategia NOT IN (
					'001'
					,'005'
					,'007'
					,'008'
					,'010'
					,'011'
					)
				AND ISNULL(@Orden, 0) > 0
				)
		BEGIN
			IF EXISTS (
					SELECT 1
					FROM dbo.Estrategia(NOLOCK)
					WHERE Orden = @Orden
						AND CampaniaID = @CampaniaID
						AND TipoEstrategiaID = @TipoEstrategiaID
						AND EstrategiaID <> @EstrategiaID
						AND NumeroPedido = @NumeroPedido
					)
			BEGIN
				RAISERROR (
						'El orden ingresado para la estrategia ya está siendo utilizado.'
						,16
						,1
						)
			END
		END

		IF NOT EXISTS (
				SELECT 1
				FROM dbo.Estrategia(NOLOCK)
				WHERE EstrategiaID = @EstrategiaID
				)
		BEGIN
			INSERT INTO dbo.Estrategia (
				TipoEstrategiaID
				,CampaniaID
				,CampaniaIDFin
				,NumeroPedido
				,Activo
				,ImagenURL
				,LimiteVenta
				,DescripcionCUV2
				,FlagDescripcion
				,CUV
				,EtiquetaID
				,Precio
				,FlagCEP
				,CUV2
				,EtiquetaID2
				,Precio2
				,FlagCEP2
				,TextoLibre
				,FlagTextoLibre
				,Cantidad
				,FlagCantidad
				,Zona
				,Orden
				,UsuarioCreacion
				,FechaCreacion
				,ColorFondo
				,FlagEstrella
				,CodigoEstrategia
				,TieneVariedad
				,EsOfertaIndependiente
				,Ganancia
				,CodigoPrograma
				,CodigoConcurso
				,ImagenMiniaturaURL
				,EsSubCampania
				,Niveles
				)
			VALUES (
				@TipoEstrategiaID
				,@CampaniaID
				,@CampaniaIDFin
				,@NumeroPedido
				,@Activo
				,@ImagenURL
				,@LimiteVenta
				,@DescripcionCUV2
				,@FlagDescripcion
				,@CUV
				,@EtiquetaID
				,@Precio
				,@FlagCEP
				,@CUV2
				,@EtiquetaID2
				,@Precio2
				,@FlagCEP2
				,@TextoLibre
				,@FlagTextoLibre
				,@Cantidad
				,@FlagCantidad
				,@Zona
				,@Orden
				,@UsuarioCreacion
				,GETDATE()
				,@ColorFondo
				,@FlagEstrella
				,@CodigoEstrategia
				,@TieneVariedad
				,@EsOfertaIndependiente
				,@Ganancia
				,@CodigoPrograma
				,@CodigoConcurso
				,@ImagenMiniaturaURL
				,@EsSubCampania
				,@Niveles
				)

			SET @Retorno = @@IDENTITY
		END
		ELSE
		BEGIN
			UPDATE Estrategia
			SET TipoEstrategiaID = @TipoEstrategiaID
				,CampaniaID = @CampaniaID
				,CampaniaIDFin = @CampaniaIDFin
				,NumeroPedido = @NumeroPedido
				,Activo = @Activo
				,ImagenURL = @ImagenURL
				,LimiteVenta = @LimiteVenta
				,DescripcionCUV2 = @DescripcionCUV2
				,FlagDescripcion = @FlagDescripcion
				,CUV = @CUV
				,EtiquetaID = @EtiquetaID
				,Precio = @Precio
				,FlagCEP = @FlagCEP
				,CUV2 = @CUV2
				,EtiquetaID2 = @EtiquetaID2
				,Precio2 = @Precio2
				,FlagCEP2 = @FlagCEP2
				,TextoLibre = @TextoLibre
				,FlagTextoLibre = @FlagTextoLibre
				,Cantidad = @Cantidad
				,FlagCantidad = @FlagCantidad
				,Zona = @Zona
				,Orden = @Orden
				,UsuarioModificacion = @UsuarioModificacion
				,FechaModificacion = GETDATE()
				,ColorFondo = @ColorFondo
				,FlagEstrella = @FlagEstrella
				,EsOfertaIndependiente = @EsOfertaIndependiente
				,Ganancia = @Ganancia
				,CodigoPrograma = @CodigoPrograma
				,CodigoConcurso = @CodigoConcurso
				,ImagenMiniaturaURL = @ImagenMiniaturaURL
				,EsSubCampania = @EsSubCampania
				,Niveles = @Niveles
			WHERE EstrategiaID = @EstrategiaID

			if(@Activo='1')
			begin
				UPDATE EstrategiaProducto
				SET Activo = 1
				WHERE EstrategiaID = @EstrategiaID and Activo!=1
			end


			SET @Retorno = @EstrategiaID
		END
	END TRY

	BEGIN CATCH
		THROW;
	END CATCH

	SET NOCOUNT OFF
END
GO
use belcorpMexico
 go

IF (OBJECT_ID('dbo.InsertarEstrategia_SB2', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.InsertarEstrategia_SB2 AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.InsertarEstrategia_SB2 @EstrategiaID INT
	,@TipoEstrategiaID INT
	,@CampaniaID INT
	,@CampaniaIDFin INT
	,@NumeroPedido INT
	,@Activo BIT
	,@ImagenURL VARCHAR(800)
	,@LimiteVenta INT
	,@DescripcionCUV2 VARCHAR(800)
	,@FlagDescripcion BIT
	,@CUV VARCHAR(20)
	,@EtiquetaID INT
	,@Precio NUMERIC(12, 2)
	,@FlagCEP BIT
	,@CUV2 VARCHAR(20)
	,@EtiquetaID2 INT
	,@Precio2 NUMERIC(12, 2)
	,@FlagCEP2 BIT
	,@TextoLibre VARCHAR(800)
	,@FlagTextoLibre BIT
	,@Cantidad INT
	,@FlagCantidad BIT
	,@Zona VARCHAR(8000)
	,@Orden INT
	,@UsuarioCreacion VARCHAR(100)
	,@UsuarioModificacion VARCHAR(100)
	,@ColorFondo VARCHAR(20)
	,@FlagEstrella BIT
	,@CodigoEstrategia VARCHAR(100)
	,@TieneVariedad INT
	,@EsOfertaIndependiente BIT = 0
	,@Ganancia DECIMAL(18, 2) = 0.0
	,@CodigoPrograma VARCHAR(3) = NULL
	,@CodigoConcurso VARCHAR(6) = NULL
	,@ImagenMiniaturaURL VARCHAR(800) = NULL
	,@EsSubCampania BIT = 0
	,@Niveles VARCHAR(255) = NULL
	,@Retorno INT OUT
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @CodigoTipoEstrategia VARCHAR(5) = ''
		,@TipoEstrategiaIDPackNueva INT = 0
		,@TipoEstrategiaIDOfertaDia INT = 0

	BEGIN TRY
		SET @Retorno = 0

		SELECT @CodigoTipoEstrategia = Codigo
		FROM dbo.TipoEstrategia(NOLOCK)
		WHERE TipoEstrategiaID = @TipoEstrategiaID

		-- Para calcular la etiqueta para pack nuevas  
		SELECT @TipoEstrategiaIDPackNueva = COUNT(1)
		FROM dbo.TipoEstrategia(NOLOCK)
		WHERE TipoEstrategiaID = @TipoEstrategiaID
			AND flagNueva = 1

		-- Para calcular la etiqueta Oferta del día  
		SELECT @TipoEstrategiaIDOfertaDia = COUNT(1)
		FROM dbo.TipoEstrategia(NOLOCK)
		WHERE TipoEstrategiaId = @TipoEstrategiaID
			AND DescripcionEstrategia LIKE '%OFERTA DEL%'

		-- Obtener el EtiquetaID2 de Precio para TI  
		SELECT @EtiquetaID2 = EtiquetaID
		FROM dbo.Etiqueta(NOLOCK)
		WHERE Descripcion LIKE '%PRECIO PARA T%'

		-- Obtener el EtiquetaID de Precio Catalogo.   
		IF ISNULL(@CUV, '') != ''
		BEGIN
			SELECT @EtiquetaID = EtiquetaID
			FROM dbo.Etiqueta(NOLOCK)
			WHERE Descripcion LIKE '%PRECIO CAT%'
		END
		ELSE IF @CodigoTipoEstrategia IN (
				'005'
				,'007'
				,'008'
				,'010'
				,'011'
				)
		BEGIN
			SET @EtiquetaID = 1
		END
		ELSE
		BEGIN
			SET @EtiquetaID = 0
		END

		-- Obtener el EtiquetaID de Ganancia  
		IF @TipoEstrategiaIDPackNueva > 0
		BEGIN
			SELECT @EtiquetaID = EtiquetaID
			FROM dbo.Etiqueta(NOLOCK)
			WHERE Descripcion LIKE '%GANANCIA%'
		END

		-- Obtener el EtiquetaID de la Oferta del día.  
		IF @TipoEstrategiaIDOfertaDia > 0
		BEGIN
			SELECT @EtiquetaID2 = EtiquetaID
			FROM dbo.Etiqueta(NOLOCK)
			WHERE Descripcion LIKE '%OFERTA DEL%'
		END

		IF EXISTS (
				SELECT 1
				FROM dbo.Estrategia(NOLOCK)
				WHERE CUV2 = @CUV2
					AND CampaniaID = @CampaniaID
					AND TipoEstrategiaID = @TipoEstrategiaID
					AND EstrategiaID <> @EstrategiaID
					AND NumeroPedido = @NumeroPedido
				)
		BEGIN
			RAISERROR (
					'El valor de cuv2 a registrar ya existe para el tipo de estrategia y campaña seleccionado.'
					,16
					,1
					)
		END

		IF @CampaniaIDFin > 0
		BEGIN
			IF EXISTS (
					SELECT 1
					FROM dbo.Estrategia(NOLOCK)
					WHERE CUV2 = @CUV2
						AND (
							(
								@CampaniaID BETWEEN CampaniaID
									AND CampaniaIDFin
								)
							OR (
								@CampaniaIDFin BETWEEN CampaniaID
									AND CampaniaIDFin
								)
							)
						AND TipoEstrategiaID = @TipoEstrategiaID
						AND EstrategiaID <> @EstrategiaID
						AND NumeroPedido = @NumeroPedido
					)
			BEGIN
				RAISERROR (
						'El valor de cuv2 a registrar ya existe para el tipo de estrategia y rango de campaña seleccionado.'
						,16
						,1
						)
			END
		END

		IF (
				@CodigoTipoEstrategia NOT IN (
					'001'
					,'005'
					,'007'
					,'008'
					,'010'
					,'011'
					)
				AND ISNULL(@Orden, 0) > 0
				)
		BEGIN
			IF EXISTS (
					SELECT 1
					FROM dbo.Estrategia(NOLOCK)
					WHERE Orden = @Orden
						AND CampaniaID = @CampaniaID
						AND TipoEstrategiaID = @TipoEstrategiaID
						AND EstrategiaID <> @EstrategiaID
						AND NumeroPedido = @NumeroPedido
					)
			BEGIN
				RAISERROR (
						'El orden ingresado para la estrategia ya está siendo utilizado.'
						,16
						,1
						)
			END
		END

		IF NOT EXISTS (
				SELECT 1
				FROM dbo.Estrategia(NOLOCK)
				WHERE EstrategiaID = @EstrategiaID
				)
		BEGIN
			INSERT INTO dbo.Estrategia (
				TipoEstrategiaID
				,CampaniaID
				,CampaniaIDFin
				,NumeroPedido
				,Activo
				,ImagenURL
				,LimiteVenta
				,DescripcionCUV2
				,FlagDescripcion
				,CUV
				,EtiquetaID
				,Precio
				,FlagCEP
				,CUV2
				,EtiquetaID2
				,Precio2
				,FlagCEP2
				,TextoLibre
				,FlagTextoLibre
				,Cantidad
				,FlagCantidad
				,Zona
				,Orden
				,UsuarioCreacion
				,FechaCreacion
				,ColorFondo
				,FlagEstrella
				,CodigoEstrategia
				,TieneVariedad
				,EsOfertaIndependiente
				,Ganancia
				,CodigoPrograma
				,CodigoConcurso
				,ImagenMiniaturaURL
				,EsSubCampania
				,Niveles
				)
			VALUES (
				@TipoEstrategiaID
				,@CampaniaID
				,@CampaniaIDFin
				,@NumeroPedido
				,@Activo
				,@ImagenURL
				,@LimiteVenta
				,@DescripcionCUV2
				,@FlagDescripcion
				,@CUV
				,@EtiquetaID
				,@Precio
				,@FlagCEP
				,@CUV2
				,@EtiquetaID2
				,@Precio2
				,@FlagCEP2
				,@TextoLibre
				,@FlagTextoLibre
				,@Cantidad
				,@FlagCantidad
				,@Zona
				,@Orden
				,@UsuarioCreacion
				,GETDATE()
				,@ColorFondo
				,@FlagEstrella
				,@CodigoEstrategia
				,@TieneVariedad
				,@EsOfertaIndependiente
				,@Ganancia
				,@CodigoPrograma
				,@CodigoConcurso
				,@ImagenMiniaturaURL
				,@EsSubCampania
				,@Niveles
				)

			SET @Retorno = @@IDENTITY
		END
		ELSE
		BEGIN
			UPDATE Estrategia
			SET TipoEstrategiaID = @TipoEstrategiaID
				,CampaniaID = @CampaniaID
				,CampaniaIDFin = @CampaniaIDFin
				,NumeroPedido = @NumeroPedido
				,Activo = @Activo
				,ImagenURL = @ImagenURL
				,LimiteVenta = @LimiteVenta
				,DescripcionCUV2 = @DescripcionCUV2
				,FlagDescripcion = @FlagDescripcion
				,CUV = @CUV
				,EtiquetaID = @EtiquetaID
				,Precio = @Precio
				,FlagCEP = @FlagCEP
				,CUV2 = @CUV2
				,EtiquetaID2 = @EtiquetaID2
				,Precio2 = @Precio2
				,FlagCEP2 = @FlagCEP2
				,TextoLibre = @TextoLibre
				,FlagTextoLibre = @FlagTextoLibre
				,Cantidad = @Cantidad
				,FlagCantidad = @FlagCantidad
				,Zona = @Zona
				,Orden = @Orden
				,UsuarioModificacion = @UsuarioModificacion
				,FechaModificacion = GETDATE()
				,ColorFondo = @ColorFondo
				,FlagEstrella = @FlagEstrella
				,EsOfertaIndependiente = @EsOfertaIndependiente
				,Ganancia = @Ganancia
				,CodigoPrograma = @CodigoPrograma
				,CodigoConcurso = @CodigoConcurso
				,ImagenMiniaturaURL = @ImagenMiniaturaURL
				,EsSubCampania = @EsSubCampania
				,Niveles = @Niveles
			WHERE EstrategiaID = @EstrategiaID

			if(@Activo='1')
			begin
				UPDATE EstrategiaProducto
				SET Activo = 1
				WHERE EstrategiaID = @EstrategiaID and Activo!=1
			end


			SET @Retorno = @EstrategiaID
		END
	END TRY

	BEGIN CATCH
		THROW;
	END CATCH

	SET NOCOUNT OFF
END
GO
use belcorpPanama
 go

IF (OBJECT_ID('dbo.InsertarEstrategia_SB2', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.InsertarEstrategia_SB2 AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.InsertarEstrategia_SB2 @EstrategiaID INT
	,@TipoEstrategiaID INT
	,@CampaniaID INT
	,@CampaniaIDFin INT
	,@NumeroPedido INT
	,@Activo BIT
	,@ImagenURL VARCHAR(800)
	,@LimiteVenta INT
	,@DescripcionCUV2 VARCHAR(800)
	,@FlagDescripcion BIT
	,@CUV VARCHAR(20)
	,@EtiquetaID INT
	,@Precio NUMERIC(12, 2)
	,@FlagCEP BIT
	,@CUV2 VARCHAR(20)
	,@EtiquetaID2 INT
	,@Precio2 NUMERIC(12, 2)
	,@FlagCEP2 BIT
	,@TextoLibre VARCHAR(800)
	,@FlagTextoLibre BIT
	,@Cantidad INT
	,@FlagCantidad BIT
	,@Zona VARCHAR(8000)
	,@Orden INT
	,@UsuarioCreacion VARCHAR(100)
	,@UsuarioModificacion VARCHAR(100)
	,@ColorFondo VARCHAR(20)
	,@FlagEstrella BIT
	,@CodigoEstrategia VARCHAR(100)
	,@TieneVariedad INT
	,@EsOfertaIndependiente BIT = 0
	,@Ganancia DECIMAL(18, 2) = 0.0
	,@CodigoPrograma VARCHAR(3) = NULL
	,@CodigoConcurso VARCHAR(6) = NULL
	,@ImagenMiniaturaURL VARCHAR(800) = NULL
	,@EsSubCampania BIT = 0
	,@Niveles VARCHAR(255) = NULL
	,@Retorno INT OUT
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @CodigoTipoEstrategia VARCHAR(5) = ''
		,@TipoEstrategiaIDPackNueva INT = 0
		,@TipoEstrategiaIDOfertaDia INT = 0

	BEGIN TRY
		SET @Retorno = 0

		SELECT @CodigoTipoEstrategia = Codigo
		FROM dbo.TipoEstrategia(NOLOCK)
		WHERE TipoEstrategiaID = @TipoEstrategiaID

		-- Para calcular la etiqueta para pack nuevas  
		SELECT @TipoEstrategiaIDPackNueva = COUNT(1)
		FROM dbo.TipoEstrategia(NOLOCK)
		WHERE TipoEstrategiaID = @TipoEstrategiaID
			AND flagNueva = 1

		-- Para calcular la etiqueta Oferta del día  
		SELECT @TipoEstrategiaIDOfertaDia = COUNT(1)
		FROM dbo.TipoEstrategia(NOLOCK)
		WHERE TipoEstrategiaId = @TipoEstrategiaID
			AND DescripcionEstrategia LIKE '%OFERTA DEL%'

		-- Obtener el EtiquetaID2 de Precio para TI  
		SELECT @EtiquetaID2 = EtiquetaID
		FROM dbo.Etiqueta(NOLOCK)
		WHERE Descripcion LIKE '%PRECIO PARA T%'

		-- Obtener el EtiquetaID de Precio Catalogo.   
		IF ISNULL(@CUV, '') != ''
		BEGIN
			SELECT @EtiquetaID = EtiquetaID
			FROM dbo.Etiqueta(NOLOCK)
			WHERE Descripcion LIKE '%PRECIO CAT%'
		END
		ELSE IF @CodigoTipoEstrategia IN (
				'005'
				,'007'
				,'008'
				,'010'
				,'011'
				)
		BEGIN
			SET @EtiquetaID = 1
		END
		ELSE
		BEGIN
			SET @EtiquetaID = 0
		END

		-- Obtener el EtiquetaID de Ganancia  
		IF @TipoEstrategiaIDPackNueva > 0
		BEGIN
			SELECT @EtiquetaID = EtiquetaID
			FROM dbo.Etiqueta(NOLOCK)
			WHERE Descripcion LIKE '%GANANCIA%'
		END

		-- Obtener el EtiquetaID de la Oferta del día.  
		IF @TipoEstrategiaIDOfertaDia > 0
		BEGIN
			SELECT @EtiquetaID2 = EtiquetaID
			FROM dbo.Etiqueta(NOLOCK)
			WHERE Descripcion LIKE '%OFERTA DEL%'
		END

		IF EXISTS (
				SELECT 1
				FROM dbo.Estrategia(NOLOCK)
				WHERE CUV2 = @CUV2
					AND CampaniaID = @CampaniaID
					AND TipoEstrategiaID = @TipoEstrategiaID
					AND EstrategiaID <> @EstrategiaID
					AND NumeroPedido = @NumeroPedido
				)
		BEGIN
			RAISERROR (
					'El valor de cuv2 a registrar ya existe para el tipo de estrategia y campaña seleccionado.'
					,16
					,1
					)
		END

		IF @CampaniaIDFin > 0
		BEGIN
			IF EXISTS (
					SELECT 1
					FROM dbo.Estrategia(NOLOCK)
					WHERE CUV2 = @CUV2
						AND (
							(
								@CampaniaID BETWEEN CampaniaID
									AND CampaniaIDFin
								)
							OR (
								@CampaniaIDFin BETWEEN CampaniaID
									AND CampaniaIDFin
								)
							)
						AND TipoEstrategiaID = @TipoEstrategiaID
						AND EstrategiaID <> @EstrategiaID
						AND NumeroPedido = @NumeroPedido
					)
			BEGIN
				RAISERROR (
						'El valor de cuv2 a registrar ya existe para el tipo de estrategia y rango de campaña seleccionado.'
						,16
						,1
						)
			END
		END

		IF (
				@CodigoTipoEstrategia NOT IN (
					'001'
					,'005'
					,'007'
					,'008'
					,'010'
					,'011'
					)
				AND ISNULL(@Orden, 0) > 0
				)
		BEGIN
			IF EXISTS (
					SELECT 1
					FROM dbo.Estrategia(NOLOCK)
					WHERE Orden = @Orden
						AND CampaniaID = @CampaniaID
						AND TipoEstrategiaID = @TipoEstrategiaID
						AND EstrategiaID <> @EstrategiaID
						AND NumeroPedido = @NumeroPedido
					)
			BEGIN
				RAISERROR (
						'El orden ingresado para la estrategia ya está siendo utilizado.'
						,16
						,1
						)
			END
		END

		IF NOT EXISTS (
				SELECT 1
				FROM dbo.Estrategia(NOLOCK)
				WHERE EstrategiaID = @EstrategiaID
				)
		BEGIN
			INSERT INTO dbo.Estrategia (
				TipoEstrategiaID
				,CampaniaID
				,CampaniaIDFin
				,NumeroPedido
				,Activo
				,ImagenURL
				,LimiteVenta
				,DescripcionCUV2
				,FlagDescripcion
				,CUV
				,EtiquetaID
				,Precio
				,FlagCEP
				,CUV2
				,EtiquetaID2
				,Precio2
				,FlagCEP2
				,TextoLibre
				,FlagTextoLibre
				,Cantidad
				,FlagCantidad
				,Zona
				,Orden
				,UsuarioCreacion
				,FechaCreacion
				,ColorFondo
				,FlagEstrella
				,CodigoEstrategia
				,TieneVariedad
				,EsOfertaIndependiente
				,Ganancia
				,CodigoPrograma
				,CodigoConcurso
				,ImagenMiniaturaURL
				,EsSubCampania
				,Niveles
				)
			VALUES (
				@TipoEstrategiaID
				,@CampaniaID
				,@CampaniaIDFin
				,@NumeroPedido
				,@Activo
				,@ImagenURL
				,@LimiteVenta
				,@DescripcionCUV2
				,@FlagDescripcion
				,@CUV
				,@EtiquetaID
				,@Precio
				,@FlagCEP
				,@CUV2
				,@EtiquetaID2
				,@Precio2
				,@FlagCEP2
				,@TextoLibre
				,@FlagTextoLibre
				,@Cantidad
				,@FlagCantidad
				,@Zona
				,@Orden
				,@UsuarioCreacion
				,GETDATE()
				,@ColorFondo
				,@FlagEstrella
				,@CodigoEstrategia
				,@TieneVariedad
				,@EsOfertaIndependiente
				,@Ganancia
				,@CodigoPrograma
				,@CodigoConcurso
				,@ImagenMiniaturaURL
				,@EsSubCampania
				,@Niveles
				)

			SET @Retorno = @@IDENTITY
		END
		ELSE
		BEGIN
			UPDATE Estrategia
			SET TipoEstrategiaID = @TipoEstrategiaID
				,CampaniaID = @CampaniaID
				,CampaniaIDFin = @CampaniaIDFin
				,NumeroPedido = @NumeroPedido
				,Activo = @Activo
				,ImagenURL = @ImagenURL
				,LimiteVenta = @LimiteVenta
				,DescripcionCUV2 = @DescripcionCUV2
				,FlagDescripcion = @FlagDescripcion
				,CUV = @CUV
				,EtiquetaID = @EtiquetaID
				,Precio = @Precio
				,FlagCEP = @FlagCEP
				,CUV2 = @CUV2
				,EtiquetaID2 = @EtiquetaID2
				,Precio2 = @Precio2
				,FlagCEP2 = @FlagCEP2
				,TextoLibre = @TextoLibre
				,FlagTextoLibre = @FlagTextoLibre
				,Cantidad = @Cantidad
				,FlagCantidad = @FlagCantidad
				,Zona = @Zona
				,Orden = @Orden
				,UsuarioModificacion = @UsuarioModificacion
				,FechaModificacion = GETDATE()
				,ColorFondo = @ColorFondo
				,FlagEstrella = @FlagEstrella
				,EsOfertaIndependiente = @EsOfertaIndependiente
				,Ganancia = @Ganancia
				,CodigoPrograma = @CodigoPrograma
				,CodigoConcurso = @CodigoConcurso
				,ImagenMiniaturaURL = @ImagenMiniaturaURL
				,EsSubCampania = @EsSubCampania
				,Niveles = @Niveles
			WHERE EstrategiaID = @EstrategiaID

			if(@Activo='1')
			begin
				UPDATE EstrategiaProducto
				SET Activo = 1
				WHERE EstrategiaID = @EstrategiaID and Activo!=1
			end


			SET @Retorno = @EstrategiaID
		END
	END TRY

	BEGIN CATCH
		THROW;
	END CATCH

	SET NOCOUNT OFF
END
GO
use belcorpPeru
 go

IF (OBJECT_ID('dbo.InsertarEstrategia_SB2', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.InsertarEstrategia_SB2 AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.InsertarEstrategia_SB2 @EstrategiaID INT
	,@TipoEstrategiaID INT
	,@CampaniaID INT
	,@CampaniaIDFin INT
	,@NumeroPedido INT
	,@Activo BIT
	,@ImagenURL VARCHAR(800)
	,@LimiteVenta INT
	,@DescripcionCUV2 VARCHAR(800)
	,@FlagDescripcion BIT
	,@CUV VARCHAR(20)
	,@EtiquetaID INT
	,@Precio NUMERIC(12, 2)
	,@FlagCEP BIT
	,@CUV2 VARCHAR(20)
	,@EtiquetaID2 INT
	,@Precio2 NUMERIC(12, 2)
	,@FlagCEP2 BIT
	,@TextoLibre VARCHAR(800)
	,@FlagTextoLibre BIT
	,@Cantidad INT
	,@FlagCantidad BIT
	,@Zona VARCHAR(8000)
	,@Orden INT
	,@UsuarioCreacion VARCHAR(100)
	,@UsuarioModificacion VARCHAR(100)
	,@ColorFondo VARCHAR(20)
	,@FlagEstrella BIT
	,@CodigoEstrategia VARCHAR(100)
	,@TieneVariedad INT
	,@EsOfertaIndependiente BIT = 0
	,@Ganancia DECIMAL(18, 2) = 0.0
	,@CodigoPrograma VARCHAR(3) = NULL
	,@CodigoConcurso VARCHAR(6) = NULL
	,@ImagenMiniaturaURL VARCHAR(800) = NULL
	,@EsSubCampania BIT = 0
	,@Niveles VARCHAR(255) = NULL
	,@Retorno INT OUT
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @CodigoTipoEstrategia VARCHAR(5) = ''
		,@TipoEstrategiaIDPackNueva INT = 0
		,@TipoEstrategiaIDOfertaDia INT = 0

	BEGIN TRY
		SET @Retorno = 0

		SELECT @CodigoTipoEstrategia = Codigo
		FROM dbo.TipoEstrategia(NOLOCK)
		WHERE TipoEstrategiaID = @TipoEstrategiaID

		-- Para calcular la etiqueta para pack nuevas  
		SELECT @TipoEstrategiaIDPackNueva = COUNT(1)
		FROM dbo.TipoEstrategia(NOLOCK)
		WHERE TipoEstrategiaID = @TipoEstrategiaID
			AND flagNueva = 1

		-- Para calcular la etiqueta Oferta del día  
		SELECT @TipoEstrategiaIDOfertaDia = COUNT(1)
		FROM dbo.TipoEstrategia(NOLOCK)
		WHERE TipoEstrategiaId = @TipoEstrategiaID
			AND DescripcionEstrategia LIKE '%OFERTA DEL%'

		-- Obtener el EtiquetaID2 de Precio para TI  
		SELECT @EtiquetaID2 = EtiquetaID
		FROM dbo.Etiqueta(NOLOCK)
		WHERE Descripcion LIKE '%PRECIO PARA T%'

		-- Obtener el EtiquetaID de Precio Catalogo.   
		IF ISNULL(@CUV, '') != ''
		BEGIN
			SELECT @EtiquetaID = EtiquetaID
			FROM dbo.Etiqueta(NOLOCK)
			WHERE Descripcion LIKE '%PRECIO CAT%'
		END
		ELSE IF @CodigoTipoEstrategia IN (
				'005'
				,'007'
				,'008'
				,'010'
				,'011'
				)
		BEGIN
			SET @EtiquetaID = 1
		END
		ELSE
		BEGIN
			SET @EtiquetaID = 0
		END

		-- Obtener el EtiquetaID de Ganancia  
		IF @TipoEstrategiaIDPackNueva > 0
		BEGIN
			SELECT @EtiquetaID = EtiquetaID
			FROM dbo.Etiqueta(NOLOCK)
			WHERE Descripcion LIKE '%GANANCIA%'
		END

		-- Obtener el EtiquetaID de la Oferta del día.  
		IF @TipoEstrategiaIDOfertaDia > 0
		BEGIN
			SELECT @EtiquetaID2 = EtiquetaID
			FROM dbo.Etiqueta(NOLOCK)
			WHERE Descripcion LIKE '%OFERTA DEL%'
		END

		IF EXISTS (
				SELECT 1
				FROM dbo.Estrategia(NOLOCK)
				WHERE CUV2 = @CUV2
					AND CampaniaID = @CampaniaID
					AND TipoEstrategiaID = @TipoEstrategiaID
					AND EstrategiaID <> @EstrategiaID
					AND NumeroPedido = @NumeroPedido
				)
		BEGIN
			RAISERROR (
					'El valor de cuv2 a registrar ya existe para el tipo de estrategia y campaña seleccionado.'
					,16
					,1
					)
		END

		IF @CampaniaIDFin > 0
		BEGIN
			IF EXISTS (
					SELECT 1
					FROM dbo.Estrategia(NOLOCK)
					WHERE CUV2 = @CUV2
						AND (
							(
								@CampaniaID BETWEEN CampaniaID
									AND CampaniaIDFin
								)
							OR (
								@CampaniaIDFin BETWEEN CampaniaID
									AND CampaniaIDFin
								)
							)
						AND TipoEstrategiaID = @TipoEstrategiaID
						AND EstrategiaID <> @EstrategiaID
						AND NumeroPedido = @NumeroPedido
					)
			BEGIN
				RAISERROR (
						'El valor de cuv2 a registrar ya existe para el tipo de estrategia y rango de campaña seleccionado.'
						,16
						,1
						)
			END
		END

		IF (
				@CodigoTipoEstrategia NOT IN (
					'001'
					,'005'
					,'007'
					,'008'
					,'010'
					,'011'
					)
				AND ISNULL(@Orden, 0) > 0
				)
		BEGIN
			IF EXISTS (
					SELECT 1
					FROM dbo.Estrategia(NOLOCK)
					WHERE Orden = @Orden
						AND CampaniaID = @CampaniaID
						AND TipoEstrategiaID = @TipoEstrategiaID
						AND EstrategiaID <> @EstrategiaID
						AND NumeroPedido = @NumeroPedido
					)
			BEGIN
				RAISERROR (
						'El orden ingresado para la estrategia ya está siendo utilizado.'
						,16
						,1
						)
			END
		END

		IF NOT EXISTS (
				SELECT 1
				FROM dbo.Estrategia(NOLOCK)
				WHERE EstrategiaID = @EstrategiaID
				)
		BEGIN
			INSERT INTO dbo.Estrategia (
				TipoEstrategiaID
				,CampaniaID
				,CampaniaIDFin
				,NumeroPedido
				,Activo
				,ImagenURL
				,LimiteVenta
				,DescripcionCUV2
				,FlagDescripcion
				,CUV
				,EtiquetaID
				,Precio
				,FlagCEP
				,CUV2
				,EtiquetaID2
				,Precio2
				,FlagCEP2
				,TextoLibre
				,FlagTextoLibre
				,Cantidad
				,FlagCantidad
				,Zona
				,Orden
				,UsuarioCreacion
				,FechaCreacion
				,ColorFondo
				,FlagEstrella
				,CodigoEstrategia
				,TieneVariedad
				,EsOfertaIndependiente
				,Ganancia
				,CodigoPrograma
				,CodigoConcurso
				,ImagenMiniaturaURL
				,EsSubCampania
				,Niveles
				)
			VALUES (
				@TipoEstrategiaID
				,@CampaniaID
				,@CampaniaIDFin
				,@NumeroPedido
				,@Activo
				,@ImagenURL
				,@LimiteVenta
				,@DescripcionCUV2
				,@FlagDescripcion
				,@CUV
				,@EtiquetaID
				,@Precio
				,@FlagCEP
				,@CUV2
				,@EtiquetaID2
				,@Precio2
				,@FlagCEP2
				,@TextoLibre
				,@FlagTextoLibre
				,@Cantidad
				,@FlagCantidad
				,@Zona
				,@Orden
				,@UsuarioCreacion
				,GETDATE()
				,@ColorFondo
				,@FlagEstrella
				,@CodigoEstrategia
				,@TieneVariedad
				,@EsOfertaIndependiente
				,@Ganancia
				,@CodigoPrograma
				,@CodigoConcurso
				,@ImagenMiniaturaURL
				,@EsSubCampania
				,@Niveles
				)

			SET @Retorno = @@IDENTITY
		END
		ELSE
		BEGIN
			UPDATE Estrategia
			SET TipoEstrategiaID = @TipoEstrategiaID
				,CampaniaID = @CampaniaID
				,CampaniaIDFin = @CampaniaIDFin
				,NumeroPedido = @NumeroPedido
				,Activo = @Activo
				,ImagenURL = @ImagenURL
				,LimiteVenta = @LimiteVenta
				,DescripcionCUV2 = @DescripcionCUV2
				,FlagDescripcion = @FlagDescripcion
				,CUV = @CUV
				,EtiquetaID = @EtiquetaID
				,Precio = @Precio
				,FlagCEP = @FlagCEP
				,CUV2 = @CUV2
				,EtiquetaID2 = @EtiquetaID2
				,Precio2 = @Precio2
				,FlagCEP2 = @FlagCEP2
				,TextoLibre = @TextoLibre
				,FlagTextoLibre = @FlagTextoLibre
				,Cantidad = @Cantidad
				,FlagCantidad = @FlagCantidad
				,Zona = @Zona
				,Orden = @Orden
				,UsuarioModificacion = @UsuarioModificacion
				,FechaModificacion = GETDATE()
				,ColorFondo = @ColorFondo
				,FlagEstrella = @FlagEstrella
				,EsOfertaIndependiente = @EsOfertaIndependiente
				,Ganancia = @Ganancia
				,CodigoPrograma = @CodigoPrograma
				,CodigoConcurso = @CodigoConcurso
				,ImagenMiniaturaURL = @ImagenMiniaturaURL
				,EsSubCampania = @EsSubCampania
				,Niveles = @Niveles
			WHERE EstrategiaID = @EstrategiaID

			if(@Activo='1')
			begin
				UPDATE EstrategiaProducto
				SET Activo = 1
				WHERE EstrategiaID = @EstrategiaID and Activo!=1
			end


			SET @Retorno = @EstrategiaID
		END
	END TRY

	BEGIN CATCH
		THROW;
	END CATCH

	SET NOCOUNT OFF
END
GO
use belcorpPuertoRico
 go

IF (OBJECT_ID('dbo.InsertarEstrategia_SB2', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.InsertarEstrategia_SB2 AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.InsertarEstrategia_SB2 @EstrategiaID INT
	,@TipoEstrategiaID INT
	,@CampaniaID INT
	,@CampaniaIDFin INT
	,@NumeroPedido INT
	,@Activo BIT
	,@ImagenURL VARCHAR(800)
	,@LimiteVenta INT
	,@DescripcionCUV2 VARCHAR(800)
	,@FlagDescripcion BIT
	,@CUV VARCHAR(20)
	,@EtiquetaID INT
	,@Precio NUMERIC(12, 2)
	,@FlagCEP BIT
	,@CUV2 VARCHAR(20)
	,@EtiquetaID2 INT
	,@Precio2 NUMERIC(12, 2)
	,@FlagCEP2 BIT
	,@TextoLibre VARCHAR(800)
	,@FlagTextoLibre BIT
	,@Cantidad INT
	,@FlagCantidad BIT
	,@Zona VARCHAR(8000)
	,@Orden INT
	,@UsuarioCreacion VARCHAR(100)
	,@UsuarioModificacion VARCHAR(100)
	,@ColorFondo VARCHAR(20)
	,@FlagEstrella BIT
	,@CodigoEstrategia VARCHAR(100)
	,@TieneVariedad INT
	,@EsOfertaIndependiente BIT = 0
	,@Ganancia DECIMAL(18, 2) = 0.0
	,@CodigoPrograma VARCHAR(3) = NULL
	,@CodigoConcurso VARCHAR(6) = NULL
	,@ImagenMiniaturaURL VARCHAR(800) = NULL
	,@EsSubCampania BIT = 0
	,@Niveles VARCHAR(255) = NULL
	,@Retorno INT OUT
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @CodigoTipoEstrategia VARCHAR(5) = ''
		,@TipoEstrategiaIDPackNueva INT = 0
		,@TipoEstrategiaIDOfertaDia INT = 0

	BEGIN TRY
		SET @Retorno = 0

		SELECT @CodigoTipoEstrategia = Codigo
		FROM dbo.TipoEstrategia(NOLOCK)
		WHERE TipoEstrategiaID = @TipoEstrategiaID

		-- Para calcular la etiqueta para pack nuevas  
		SELECT @TipoEstrategiaIDPackNueva = COUNT(1)
		FROM dbo.TipoEstrategia(NOLOCK)
		WHERE TipoEstrategiaID = @TipoEstrategiaID
			AND flagNueva = 1

		-- Para calcular la etiqueta Oferta del día  
		SELECT @TipoEstrategiaIDOfertaDia = COUNT(1)
		FROM dbo.TipoEstrategia(NOLOCK)
		WHERE TipoEstrategiaId = @TipoEstrategiaID
			AND DescripcionEstrategia LIKE '%OFERTA DEL%'

		-- Obtener el EtiquetaID2 de Precio para TI  
		SELECT @EtiquetaID2 = EtiquetaID
		FROM dbo.Etiqueta(NOLOCK)
		WHERE Descripcion LIKE '%PRECIO PARA T%'

		-- Obtener el EtiquetaID de Precio Catalogo.   
		IF ISNULL(@CUV, '') != ''
		BEGIN
			SELECT @EtiquetaID = EtiquetaID
			FROM dbo.Etiqueta(NOLOCK)
			WHERE Descripcion LIKE '%PRECIO CAT%'
		END
		ELSE IF @CodigoTipoEstrategia IN (
				'005'
				,'007'
				,'008'
				,'010'
				,'011'
				)
		BEGIN
			SET @EtiquetaID = 1
		END
		ELSE
		BEGIN
			SET @EtiquetaID = 0
		END

		-- Obtener el EtiquetaID de Ganancia  
		IF @TipoEstrategiaIDPackNueva > 0
		BEGIN
			SELECT @EtiquetaID = EtiquetaID
			FROM dbo.Etiqueta(NOLOCK)
			WHERE Descripcion LIKE '%GANANCIA%'
		END

		-- Obtener el EtiquetaID de la Oferta del día.  
		IF @TipoEstrategiaIDOfertaDia > 0
		BEGIN
			SELECT @EtiquetaID2 = EtiquetaID
			FROM dbo.Etiqueta(NOLOCK)
			WHERE Descripcion LIKE '%OFERTA DEL%'
		END

		IF EXISTS (
				SELECT 1
				FROM dbo.Estrategia(NOLOCK)
				WHERE CUV2 = @CUV2
					AND CampaniaID = @CampaniaID
					AND TipoEstrategiaID = @TipoEstrategiaID
					AND EstrategiaID <> @EstrategiaID
					AND NumeroPedido = @NumeroPedido
				)
		BEGIN
			RAISERROR (
					'El valor de cuv2 a registrar ya existe para el tipo de estrategia y campaña seleccionado.'
					,16
					,1
					)
		END

		IF @CampaniaIDFin > 0
		BEGIN
			IF EXISTS (
					SELECT 1
					FROM dbo.Estrategia(NOLOCK)
					WHERE CUV2 = @CUV2
						AND (
							(
								@CampaniaID BETWEEN CampaniaID
									AND CampaniaIDFin
								)
							OR (
								@CampaniaIDFin BETWEEN CampaniaID
									AND CampaniaIDFin
								)
							)
						AND TipoEstrategiaID = @TipoEstrategiaID
						AND EstrategiaID <> @EstrategiaID
						AND NumeroPedido = @NumeroPedido
					)
			BEGIN
				RAISERROR (
						'El valor de cuv2 a registrar ya existe para el tipo de estrategia y rango de campaña seleccionado.'
						,16
						,1
						)
			END
		END

		IF (
				@CodigoTipoEstrategia NOT IN (
					'001'
					,'005'
					,'007'
					,'008'
					,'010'
					,'011'
					)
				AND ISNULL(@Orden, 0) > 0
				)
		BEGIN
			IF EXISTS (
					SELECT 1
					FROM dbo.Estrategia(NOLOCK)
					WHERE Orden = @Orden
						AND CampaniaID = @CampaniaID
						AND TipoEstrategiaID = @TipoEstrategiaID
						AND EstrategiaID <> @EstrategiaID
						AND NumeroPedido = @NumeroPedido
					)
			BEGIN
				RAISERROR (
						'El orden ingresado para la estrategia ya está siendo utilizado.'
						,16
						,1
						)
			END
		END

		IF NOT EXISTS (
				SELECT 1
				FROM dbo.Estrategia(NOLOCK)
				WHERE EstrategiaID = @EstrategiaID
				)
		BEGIN
			INSERT INTO dbo.Estrategia (
				TipoEstrategiaID
				,CampaniaID
				,CampaniaIDFin
				,NumeroPedido
				,Activo
				,ImagenURL
				,LimiteVenta
				,DescripcionCUV2
				,FlagDescripcion
				,CUV
				,EtiquetaID
				,Precio
				,FlagCEP
				,CUV2
				,EtiquetaID2
				,Precio2
				,FlagCEP2
				,TextoLibre
				,FlagTextoLibre
				,Cantidad
				,FlagCantidad
				,Zona
				,Orden
				,UsuarioCreacion
				,FechaCreacion
				,ColorFondo
				,FlagEstrella
				,CodigoEstrategia
				,TieneVariedad
				,EsOfertaIndependiente
				,Ganancia
				,CodigoPrograma
				,CodigoConcurso
				,ImagenMiniaturaURL
				,EsSubCampania
				,Niveles
				)
			VALUES (
				@TipoEstrategiaID
				,@CampaniaID
				,@CampaniaIDFin
				,@NumeroPedido
				,@Activo
				,@ImagenURL
				,@LimiteVenta
				,@DescripcionCUV2
				,@FlagDescripcion
				,@CUV
				,@EtiquetaID
				,@Precio
				,@FlagCEP
				,@CUV2
				,@EtiquetaID2
				,@Precio2
				,@FlagCEP2
				,@TextoLibre
				,@FlagTextoLibre
				,@Cantidad
				,@FlagCantidad
				,@Zona
				,@Orden
				,@UsuarioCreacion
				,GETDATE()
				,@ColorFondo
				,@FlagEstrella
				,@CodigoEstrategia
				,@TieneVariedad
				,@EsOfertaIndependiente
				,@Ganancia
				,@CodigoPrograma
				,@CodigoConcurso
				,@ImagenMiniaturaURL
				,@EsSubCampania
				,@Niveles
				)

			SET @Retorno = @@IDENTITY
		END
		ELSE
		BEGIN
			UPDATE Estrategia
			SET TipoEstrategiaID = @TipoEstrategiaID
				,CampaniaID = @CampaniaID
				,CampaniaIDFin = @CampaniaIDFin
				,NumeroPedido = @NumeroPedido
				,Activo = @Activo
				,ImagenURL = @ImagenURL
				,LimiteVenta = @LimiteVenta
				,DescripcionCUV2 = @DescripcionCUV2
				,FlagDescripcion = @FlagDescripcion
				,CUV = @CUV
				,EtiquetaID = @EtiquetaID
				,Precio = @Precio
				,FlagCEP = @FlagCEP
				,CUV2 = @CUV2
				,EtiquetaID2 = @EtiquetaID2
				,Precio2 = @Precio2
				,FlagCEP2 = @FlagCEP2
				,TextoLibre = @TextoLibre
				,FlagTextoLibre = @FlagTextoLibre
				,Cantidad = @Cantidad
				,FlagCantidad = @FlagCantidad
				,Zona = @Zona
				,Orden = @Orden
				,UsuarioModificacion = @UsuarioModificacion
				,FechaModificacion = GETDATE()
				,ColorFondo = @ColorFondo
				,FlagEstrella = @FlagEstrella
				,EsOfertaIndependiente = @EsOfertaIndependiente
				,Ganancia = @Ganancia
				,CodigoPrograma = @CodigoPrograma
				,CodigoConcurso = @CodigoConcurso
				,ImagenMiniaturaURL = @ImagenMiniaturaURL
				,EsSubCampania = @EsSubCampania
				,Niveles = @Niveles
			WHERE EstrategiaID = @EstrategiaID

			if(@Activo='1')
			begin
				UPDATE EstrategiaProducto
				SET Activo = 1
				WHERE EstrategiaID = @EstrategiaID and Activo!=1
			end


			SET @Retorno = @EstrategiaID
		END
	END TRY

	BEGIN CATCH
		THROW;
	END CATCH

	SET NOCOUNT OFF
END
GO
use belcorpSalvador
 go

IF (OBJECT_ID('dbo.InsertarEstrategia_SB2', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.InsertarEstrategia_SB2 AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.InsertarEstrategia_SB2 @EstrategiaID INT
	,@TipoEstrategiaID INT
	,@CampaniaID INT
	,@CampaniaIDFin INT
	,@NumeroPedido INT
	,@Activo BIT
	,@ImagenURL VARCHAR(800)
	,@LimiteVenta INT
	,@DescripcionCUV2 VARCHAR(800)
	,@FlagDescripcion BIT
	,@CUV VARCHAR(20)
	,@EtiquetaID INT
	,@Precio NUMERIC(12, 2)
	,@FlagCEP BIT
	,@CUV2 VARCHAR(20)
	,@EtiquetaID2 INT
	,@Precio2 NUMERIC(12, 2)
	,@FlagCEP2 BIT
	,@TextoLibre VARCHAR(800)
	,@FlagTextoLibre BIT
	,@Cantidad INT
	,@FlagCantidad BIT
	,@Zona VARCHAR(8000)
	,@Orden INT
	,@UsuarioCreacion VARCHAR(100)
	,@UsuarioModificacion VARCHAR(100)
	,@ColorFondo VARCHAR(20)
	,@FlagEstrella BIT
	,@CodigoEstrategia VARCHAR(100)
	,@TieneVariedad INT
	,@EsOfertaIndependiente BIT = 0
	,@Ganancia DECIMAL(18, 2) = 0.0
	,@CodigoPrograma VARCHAR(3) = NULL
	,@CodigoConcurso VARCHAR(6) = NULL
	,@ImagenMiniaturaURL VARCHAR(800) = NULL
	,@EsSubCampania BIT = 0
	,@Niveles VARCHAR(255) = NULL
	,@Retorno INT OUT
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @CodigoTipoEstrategia VARCHAR(5) = ''
		,@TipoEstrategiaIDPackNueva INT = 0
		,@TipoEstrategiaIDOfertaDia INT = 0

	BEGIN TRY
		SET @Retorno = 0

		SELECT @CodigoTipoEstrategia = Codigo
		FROM dbo.TipoEstrategia(NOLOCK)
		WHERE TipoEstrategiaID = @TipoEstrategiaID

		-- Para calcular la etiqueta para pack nuevas  
		SELECT @TipoEstrategiaIDPackNueva = COUNT(1)
		FROM dbo.TipoEstrategia(NOLOCK)
		WHERE TipoEstrategiaID = @TipoEstrategiaID
			AND flagNueva = 1

		-- Para calcular la etiqueta Oferta del día  
		SELECT @TipoEstrategiaIDOfertaDia = COUNT(1)
		FROM dbo.TipoEstrategia(NOLOCK)
		WHERE TipoEstrategiaId = @TipoEstrategiaID
			AND DescripcionEstrategia LIKE '%OFERTA DEL%'

		-- Obtener el EtiquetaID2 de Precio para TI  
		SELECT @EtiquetaID2 = EtiquetaID
		FROM dbo.Etiqueta(NOLOCK)
		WHERE Descripcion LIKE '%PRECIO PARA T%'

		-- Obtener el EtiquetaID de Precio Catalogo.   
		IF ISNULL(@CUV, '') != ''
		BEGIN
			SELECT @EtiquetaID = EtiquetaID
			FROM dbo.Etiqueta(NOLOCK)
			WHERE Descripcion LIKE '%PRECIO CAT%'
		END
		ELSE IF @CodigoTipoEstrategia IN (
				'005'
				,'007'
				,'008'
				,'010'
				,'011'
				)
		BEGIN
			SET @EtiquetaID = 1
		END
		ELSE
		BEGIN
			SET @EtiquetaID = 0
		END

		-- Obtener el EtiquetaID de Ganancia  
		IF @TipoEstrategiaIDPackNueva > 0
		BEGIN
			SELECT @EtiquetaID = EtiquetaID
			FROM dbo.Etiqueta(NOLOCK)
			WHERE Descripcion LIKE '%GANANCIA%'
		END

		-- Obtener el EtiquetaID de la Oferta del día.  
		IF @TipoEstrategiaIDOfertaDia > 0
		BEGIN
			SELECT @EtiquetaID2 = EtiquetaID
			FROM dbo.Etiqueta(NOLOCK)
			WHERE Descripcion LIKE '%OFERTA DEL%'
		END

		IF EXISTS (
				SELECT 1
				FROM dbo.Estrategia(NOLOCK)
				WHERE CUV2 = @CUV2
					AND CampaniaID = @CampaniaID
					AND TipoEstrategiaID = @TipoEstrategiaID
					AND EstrategiaID <> @EstrategiaID
					AND NumeroPedido = @NumeroPedido
				)
		BEGIN
			RAISERROR (
					'El valor de cuv2 a registrar ya existe para el tipo de estrategia y campaña seleccionado.'
					,16
					,1
					)
		END

		IF @CampaniaIDFin > 0
		BEGIN
			IF EXISTS (
					SELECT 1
					FROM dbo.Estrategia(NOLOCK)
					WHERE CUV2 = @CUV2
						AND (
							(
								@CampaniaID BETWEEN CampaniaID
									AND CampaniaIDFin
								)
							OR (
								@CampaniaIDFin BETWEEN CampaniaID
									AND CampaniaIDFin
								)
							)
						AND TipoEstrategiaID = @TipoEstrategiaID
						AND EstrategiaID <> @EstrategiaID
						AND NumeroPedido = @NumeroPedido
					)
			BEGIN
				RAISERROR (
						'El valor de cuv2 a registrar ya existe para el tipo de estrategia y rango de campaña seleccionado.'
						,16
						,1
						)
			END
		END

		IF (
				@CodigoTipoEstrategia NOT IN (
					'001'
					,'005'
					,'007'
					,'008'
					,'010'
					,'011'
					)
				AND ISNULL(@Orden, 0) > 0
				)
		BEGIN
			IF EXISTS (
					SELECT 1
					FROM dbo.Estrategia(NOLOCK)
					WHERE Orden = @Orden
						AND CampaniaID = @CampaniaID
						AND TipoEstrategiaID = @TipoEstrategiaID
						AND EstrategiaID <> @EstrategiaID
						AND NumeroPedido = @NumeroPedido
					)
			BEGIN
				RAISERROR (
						'El orden ingresado para la estrategia ya está siendo utilizado.'
						,16
						,1
						)
			END
		END

		IF NOT EXISTS (
				SELECT 1
				FROM dbo.Estrategia(NOLOCK)
				WHERE EstrategiaID = @EstrategiaID
				)
		BEGIN
			INSERT INTO dbo.Estrategia (
				TipoEstrategiaID
				,CampaniaID
				,CampaniaIDFin
				,NumeroPedido
				,Activo
				,ImagenURL
				,LimiteVenta
				,DescripcionCUV2
				,FlagDescripcion
				,CUV
				,EtiquetaID
				,Precio
				,FlagCEP
				,CUV2
				,EtiquetaID2
				,Precio2
				,FlagCEP2
				,TextoLibre
				,FlagTextoLibre
				,Cantidad
				,FlagCantidad
				,Zona
				,Orden
				,UsuarioCreacion
				,FechaCreacion
				,ColorFondo
				,FlagEstrella
				,CodigoEstrategia
				,TieneVariedad
				,EsOfertaIndependiente
				,Ganancia
				,CodigoPrograma
				,CodigoConcurso
				,ImagenMiniaturaURL
				,EsSubCampania
				,Niveles
				)
			VALUES (
				@TipoEstrategiaID
				,@CampaniaID
				,@CampaniaIDFin
				,@NumeroPedido
				,@Activo
				,@ImagenURL
				,@LimiteVenta
				,@DescripcionCUV2
				,@FlagDescripcion
				,@CUV
				,@EtiquetaID
				,@Precio
				,@FlagCEP
				,@CUV2
				,@EtiquetaID2
				,@Precio2
				,@FlagCEP2
				,@TextoLibre
				,@FlagTextoLibre
				,@Cantidad
				,@FlagCantidad
				,@Zona
				,@Orden
				,@UsuarioCreacion
				,GETDATE()
				,@ColorFondo
				,@FlagEstrella
				,@CodigoEstrategia
				,@TieneVariedad
				,@EsOfertaIndependiente
				,@Ganancia
				,@CodigoPrograma
				,@CodigoConcurso
				,@ImagenMiniaturaURL
				,@EsSubCampania
				,@Niveles
				)

			SET @Retorno = @@IDENTITY
		END
		ELSE
		BEGIN
			UPDATE Estrategia
			SET TipoEstrategiaID = @TipoEstrategiaID
				,CampaniaID = @CampaniaID
				,CampaniaIDFin = @CampaniaIDFin
				,NumeroPedido = @NumeroPedido
				,Activo = @Activo
				,ImagenURL = @ImagenURL
				,LimiteVenta = @LimiteVenta
				,DescripcionCUV2 = @DescripcionCUV2
				,FlagDescripcion = @FlagDescripcion
				,CUV = @CUV
				,EtiquetaID = @EtiquetaID
				,Precio = @Precio
				,FlagCEP = @FlagCEP
				,CUV2 = @CUV2
				,EtiquetaID2 = @EtiquetaID2
				,Precio2 = @Precio2
				,FlagCEP2 = @FlagCEP2
				,TextoLibre = @TextoLibre
				,FlagTextoLibre = @FlagTextoLibre
				,Cantidad = @Cantidad
				,FlagCantidad = @FlagCantidad
				,Zona = @Zona
				,Orden = @Orden
				,UsuarioModificacion = @UsuarioModificacion
				,FechaModificacion = GETDATE()
				,ColorFondo = @ColorFondo
				,FlagEstrella = @FlagEstrella
				,EsOfertaIndependiente = @EsOfertaIndependiente
				,Ganancia = @Ganancia
				,CodigoPrograma = @CodigoPrograma
				,CodigoConcurso = @CodigoConcurso
				,ImagenMiniaturaURL = @ImagenMiniaturaURL
				,EsSubCampania = @EsSubCampania
				,Niveles = @Niveles
			WHERE EstrategiaID = @EstrategiaID

			if(@Activo='1')
			begin
				UPDATE EstrategiaProducto
				SET Activo = 1
				WHERE EstrategiaID = @EstrategiaID and Activo!=1
			end


			SET @Retorno = @EstrategiaID
		END
	END TRY

	BEGIN CATCH
		THROW;
	END CATCH

	SET NOCOUNT OFF
END
GO
