USE [BelcorpBolivia];
GO
ALTER PROCEDURE [dbo].[RegistrarSolicitudClienteAppCatalogo]	
    @Campania VARCHAR(6),
	@CodigoConsultora VARCHAR(30),
	@CodigoUbigeo VARCHAR(40),
	@ConsultoraID BIGINT,
	@Direccion VARCHAR(800),
	@Email VARCHAR(110),
	@Mensaje VARCHAR(810),
	@NombreCompleto VARCHAR(110),
	@Telefono VARCHAR(110),
	@FlagConsultora BIT,
	@FlagMedio VARCHAR(10),
	@NumIteracion INT,
	@CodigoDispositivo VARCHAR(50) = '-',
	@SODispositivo VARCHAR(20) = '-',
	@TipoUsuario INT = 0,
	@UsuarioAppID BIGINT = 0,
	@SolicitudDetalle dbo.SolicitudDetalleAppCatalogoType READONLY,
	@SolicitudClienteOrigen BIGINT = null,
	@IDCDC VARCHAR(100) = NULL,
	@IDCMC VARCHAR(200) = NULL
AS
BEGIN
	DECLARE
		@SolicitudClienteID BIGINT,
		@MensajeResultado VARCHAR(500),
		@SolicitudClienteLogID BIGINT,
		@MensajeResultadoDetalle VARCHAR(500),
		@flagDetalle BIT,
		@TerritorioID INT

	SET @SolicitudClienteID = 0
	SET @SolicitudClienteLogID = 0
	SET @flagDetalle = 0
	SET @TerritorioID = (SELECT TerritorioID FROM ods.Consultora where ConsultoraID=@ConsultoraID)

	BEGIN TRY
		SET @MensajeResultado = ''

		--VALIDACIONES: INICIO--
		IF @CodigoConsultora IS NULL
			SET @MensajeResultado = @MensajeResultado + 'El código de consultora no fue ingresado.|'
		ELSE IF LEN(@CodigoConsultora) > 20
			SET @MensajeResultado = @MensajeResultado + 'El código de consultora no debe exceder los 20 caracteres.|'
		ELSE IF NOT EXISTS(SELECT 1 FROM ods.Consultora WHERE RTRIM(Codigo) = RTRIM(@CodigoConsultora))
			SET @MensajeResultado = @MensajeResultado + 'No existe el Código de Consultora.|'

		IF @ConsultoraID IS NULL OR @ConsultoraID = 0
			SET @MensajeResultado = @MensajeResultado + 'El ID de consultora no fue ingresado.|'
		ELSE IF NOT EXISTS(SELECT 1 FROM ods.Consultora WHERE ConsultoraID = @ConsultoraID)
			SET @MensajeResultado = @MensajeResultado + 'No existe el ID de la consultora.|'
		ELSE IF RTRIM(@CodigoConsultora) <> (SELECT RTRIM(Codigo) FROM ods.Consultora where ConsultoraID=@ConsultoraID)
			SET @MensajeResultado = @MensajeResultado + 'El Id de Consultora no está asociado con el Código Consultora.|'

		IF @CodigoUbigeo IS NULL
			SET @MensajeResultado = @MensajeResultado + 'El código ubigeo no fue ingresado.|'
		ELSE IF NOT EXISTS(SELECT 1 FROM dbo.Ubigeo WHERE CodigoUbigeo = @CodigoUbigeo)
		BEGIN
			IF NOT EXISTS(SELECT 1 FROM ods.Ubigeo WHERE CodigoUbigeo = @CodigoUbigeo)
			    SET @MensajeResultado = @MensajeResultado + 'No existe el código ubigeo.|'
		END

		IF @NombreCompleto IS NULL
			SET @MensajeResultado = @MensajeResultado + 'El nombre completo de la cliente no fue ingresado.|'
		ELSE IF LEN(@NombreCompleto) > 100
			SET @MensajeResultado = @MensajeResultado + 'El nombre completo de la cliente no debe exceder los 100 caracteres.|'

		IF @Email IS NULL
			SET @MensajeResultado = @MensajeResultado + 'El email de la cliente no fue ingresado.|'
		ELSE IF LEN(@Email) > 100
			SET @MensajeResultado = @MensajeResultado + 'El email de la cliente no debe exceder los 100 caracteres.|'

		IF @Telefono IS NULL
			SET @MensajeResultado = @MensajeResultado + 'El teléfono de la cliente no fue ingresado.|'
		ELSE IF LEN(@Telefono) > 100
			SET @MensajeResultado = @MensajeResultado + 'El teléfono de la cliente no debe exceder los 100 caracteres.|'

		IF @Mensaje IS NULL
			SET @MensajeResultado = @MensajeResultado + 'El mensaje de la cliente no fue ingresado.|'
		ELSE IF LEN(@Mensaje) > 800
			SET @MensajeResultado = @MensajeResultado + 'El mensaje no debe exceder los 800 caracteres.|'

		IF @Campania IS NULL
			SET @MensajeResultado = @MensajeResultado + 'La campaña no fue ingresada.|'
		ELSE IF LEN(@Campania) > 6
			SET @MensajeResultado = @MensajeResultado + 'El código de campaña no debe exceder los 6 caracteres.|'
		ELSE IF NOT EXISTS(SELECT Codigo FROM ods.Campania WHERE Codigo IN (@Campania))
			SET @MensajeResultado = @MensajeResultado + 'No existe la campaña ' + @Campania + '.|'

		IF @FlagMedio IS NULL OR LEN (@FlagMedio) = 0
			SET @MensajeResultado = @MensajeResultado + 'El flag medio no fue ingresado.|'
		ELSE IF NOT EXISTS(SELECT 1 FROM TablaLogicaDatos WHERE TablaLogicaID = 85 AND Codigo = @FlagMedio)
			SET @MensajeResultado = @MensajeResultado + 'El flag medio ''' + @FlagMedio + ''' no es válido.|'
		
		IF @CodigoDispositivo IS NULL
			SET @MensajeResultado = @MensajeResultado + 'El código del dispositivo no fue ingresado.|'
		ELSE IF LEN(@CodigoDispositivo) > 50
			SET @MensajeResultado = @MensajeResultado + 'El código del dispositivo no debe exceder los 50 caracteres.|'

		IF @SODispositivo IS NULL
			SET @MensajeResultado = @MensajeResultado + 'El so del dispositivo no fue ingresado.|'
		ELSE IF LEN(@SODispositivo) > 20
			SET @MensajeResultado = @MensajeResultado + 'El so del dispositivo no debe exceder los 100 caracteres.|'

		--VALIDACIONES: FIN--
		---------------------

		DECLARE
			@UnidGeo1 VARCHAR(100),
			@UnidGeo2 VARCHAR(100),
			@UnidGeo3 VARCHAR(100),
			@TipoDistribucion SMALLINT,
			@CodigoTipoDistribucion VARCHAR(10);

		SELECT TOP 1
			@UnidGeo1 = UnidadGeografica1,
			@UnidGeo2 = UnidadGeografica2,
			@UnidGeo3 = UnidadGeografica3
		FROM dbo.Ubigeo
		WHERE CodigoUbigeo = @CodigoUbigeo

		SELECT @CodigoTipoDistribucion = Codigo
		FROM TablaLogicaDatos
		WHERE TablaLogicaDatosID = 6801 AND TablaLogicaID = 68;

		SET @TipoDistribucion = CAST(@CodigoTipoDistribucion AS SMALLINT);

		IF @MensajeResultado <> ''
		BEGIN
			INSERT INTO SolicitudClienteLog(SolicitudClienteID, FechaEjecucion, Descripcion, ConsultoraID, CodigoUbigeo, NombreCompleto, Email, Telefono,
				Mensaje, Campania, UnidadGeografica1, UnidadGeografica2, UnidadGeografica3, TipoDistribucion, MarcaID, SolicitudClienteOrigen, Direccion, 
				FlagConsultora, FlagMedio, CodigoDispositivo, SODispositivo)
			VALUES (NULL, GETDATE(), @MensajeResultado, @ConsultoraID, @CodigoUbigeo, @NombreCompleto, @Email, @Telefono,
				@Mensaje, @Campania, @UnidGeo1, @UnidGeo2, @UnidGeo3, @TipoDistribucion, 0, 0, @Direccion, 
				@FlagConsultora, @FlagMedio, @CodigoDispositivo, @SODispositivo)
			SET @SolicitudClienteLogID = SCOPE_IDENTITY();
		END
		ELSE
		BEGIN
			INSERT INTO SolicitudCliente(ConsultoraID, CodigoUbigeo, NombreCompleto, Email, Telefono, Mensaje, Campania, MarcaID, FechaSolicitud, Leido, NumIteracion,UnidadGeografica1, UnidadGeografica2, UnidadGeografica3, TipoDistribucion, SolicitudClienteOrigen,
 Direccion, FlagConsultora, FlagMedio, CodigoDispositivo, SODispositivo, TipoUsuario, UsuarioAppID, IDCDC, IDCMC)
			VALUES (@ConsultoraID, @CodigoUbigeo, @NombreCompleto, @Email, @Telefono, @Mensaje, @Campania, 0, GETDATE(), 0, @NumIteracion, @UnidGeo1, @UnidGeo2, @UnidGeo3, @TipoDistribucion,isnull(@SolicitudClienteOrigen,0),@Direccion, @FlagConsultora, @FlagMedio,
 @CodigoDispositivo, @SODispositivo, @TipoUsuario, @UsuarioAppID, @IDCDC, @IDCMC)

			SET @SolicitudClienteID = SCOPE_IDENTITY();
			SET @MensajeResultado = 'Acción ejecutada satisfactoriamente.';

			--********************************Buscar el cliente origen, Codigo: Cesar FLores**************************
			IF @SolicitudClienteOrigen is null
			BEGIN
				SET @SolicitudClienteOrigen = isnull(dbo.ObtenerSolicitudClienteOrigen(@SolicitudClienteID),0);
				IF @SolicitudClienteOrigen <> 0
				BEGIN
					UPDATE SolicitudCliente
					SET SolicitudClienteOrigen=@SolicitudClienteOrigen
					WHERE SolicitudClienteID=@SolicitudClienteID;
				END
			END
			--*********************************************************************************************************

			INSERT INTO SolicitudClienteLog(SolicitudClienteID, FechaEjecucion, Descripcion, ConsultoraID, CodigoUbigeo, NombreCompleto, Email, Telefono,
				Mensaje, Campania, UnidadGeografica1, UnidadGeografica2, UnidadGeografica3, TipoDistribucion, MarcaID, SolicitudClienteOrigen, Direccion, 
				FlagConsultora, FlagMedio, CodigoDispositivo, SODispositivo)
			VALUES (@SolicitudClienteID, GETDATE(), @MensajeResultado, @ConsultoraID, @CodigoUbigeo, @NombreCompleto, @Email, @Telefono,
				@Mensaje, @Campania, @UnidGeo1, @UnidGeo2, @UnidGeo3, @TipoDistribucion, 0, @SolicitudClienteOrigen, @Direccion, 
				@FlagConsultora, @FlagMedio, @CodigoDispositivo, @SODispositivo)
			SET @SolicitudClienteLogID = SCOPE_IDENTITY();
				
			DECLARE
				@Cantidad INT,
				@CUV VARCHAR(6),
				@MarcaID INT,
				@DescripcionProducto VARCHAR(100),
				@Precio DECIMAL(20,2),
				@Tono VARCHAR(250),
				@Url VARCHAR(500),
				@i INT,
				@total INT

			DECLARE @TempSolicitudClienteDetalle TABLE
			(
				ID INT IDENTITY(1, 1),
				Cantidad INT,
				CUV VARCHAR(6),
				MarcaID INT,
				DescripcionProducto VARCHAR(100),
				Precio DECIMAL(20,2),
				Tono VARCHAR(250),
				Url VARCHAR(500)
			)

			INSERT INTO @TempSolicitudClienteDetalle(Cantidad, CUV, MarcaID, DescripcionProducto, Precio, Tono, Url)
			SELECT Cantidad, CUV, MarcaID, DescripcionProducto, Precio, Tono, Url FROM @SolicitudDetalle

			SET @i = 1
			SET @total = (SELECT MAX(ID) FROM @TempSolicitudClienteDetalle)
			WHILE @i <= @total
			BEGIN
				SET @CUV = (SELECT CUV FROM @TempSolicitudClienteDetalle WHERE ID = @i)
				SET @DescripcionProducto = (SELECT DescripcionProducto FROM @TempSolicitudClienteDetalle WHERE ID = @i)
				SET @Cantidad = (SELECT Cantidad FROM @TempSolicitudClienteDetalle WHERE ID = @i)
				SET @Precio = (SELECT Precio FROM @TempSolicitudClienteDetalle WHERE ID = @i)
				SET @MarcaID = (SELECT MarcaID FROM @TempSolicitudClienteDetalle WHERE ID = @i)
				SET @Tono = (SELECT Tono FROM @TempSolicitudClienteDetalle WHERE ID = @i)
				SET @Url = (SELECT Url FROM @TempSolicitudClienteDetalle WHERE ID = @i)
				SET @MensajeResultadoDetalle = ''

				/*RE2603 - CS(GGI) - 22/05/2015 - se esta quitando la validación para el @cuv*/

				--VALIDACIONES: INICIO--
				IF @DescripcionProducto IS NULL OR LEN(@DescripcionProducto) = 0
					SET @MensajeResultadoDetalle = @MensajeResultadoDetalle + 'No se ha ingresado la descripción de producto.|'

				IF @Cantidad <= 0
					SET @MensajeResultadoDetalle = @MensajeResultadoDetalle + 'La cantidad ingresada debe ser mayor a cero.|'

				IF @Precio <= 0
					SET @MensajeResultadoDetalle = @MensajeResultadoDetalle + 'El precio ingresado debe ser mayor a cero.|'
					
				IF NOT EXISTS(SELECT 1 FROM ods.Marca WHERE MarcaID IN (@MarcaID))
					SET @MensajeResultado = @MensajeResultado + 'No existe la marca con ID: ' + @MarcaID + '.|'
				ELSE IF @MarcaID NOT IN (1, 2, 3)
					SET @MensajeResultado = @MensajeResultado + 'El registro de solicitud es solo para las marcas: LBel, Esika, Cyzone.|'
				--VALIDACIONES: FIN--

				IF @MensajeResultadoDetalle <> ''
				BEGIN
					SET @flagDetalle = 1
					INSERT INTO SolicitudClienteDetalleLog(SolicitudClienteLogID, FechaEjecucion, Descripcion, CUV, Producto, Cantidad, Precio, MarcaID, Tono, Url) 
					VALUES (@SolicitudClienteLogID, GETDATE(), @MensajeResultadoDetalle, @CUV, @DescripcionProducto, @Cantidad, @Precio, @MarcaID, @Tono, @Url);
				END
				ELSE
				BEGIN
					SET @MensajeResultadoDetalle = 'Acción ejecutada satisfactoriamente.';
					-- Insertar el log del detalle. CORRECTO
					INSERT INTO SolicitudClienteDetalle(SolicitudClienteID, CUV, Producto, Cantidad, Precio, MarcaID, FechaCreacion, Tono, Url)
					VALUES (@SolicitudClienteID, @CUV, @DescripcionProducto, @Cantidad, @Precio, @MarcaID, getDate(), @Tono, @Url);
					INSERT INTO SolicitudClienteDetalleLog(SolicitudClienteLogID, FechaEjecucion, Descripcion, CUV, Producto, Cantidad, Precio, MarcaID, Tono, Url)
					VALUES (@SolicitudClienteLogID, GETDATE(), @MensajeResultadoDetalle, @CUV, @DescripcionProducto, @Cantidad, @Precio, @MarcaID, @Tono, @Url);
				END

				SET @i = @i + 1;
			END
		END

		IF @flagDetalle = 1
		BEGIN
			SET @MensajeResultado = 'Hubo un error al intentar registrar el detalle de la solicitud.';
			DELETE FROM SolicitudClienteDetalle WHERE SolicitudClienteID = @SolicitudClienteID;
			DELETE FROM SolicitudCliente WHERE SolicitudClienteID = @SolicitudClienteID;

			UPDATE SolicitudClienteLog
			SET
				SolicitudClienteID = NULL,
				Descripcion = @MensajeResultado
			WHERE SolicitudClienteLogID = @SolicitudClienteLogID;

			SET @SolicitudClienteID = 0;
		END

		SELECT @SolicitudClienteID Resultado, @MensajeResultado Mensaje;
	END TRY
	BEGIN CATCH
		SET @MensajeResultado = CONCAT(ERROR_MESSAGE(),' ',ERROR_LINE());
		SELECT @SolicitudClienteID Resultado, @MensajeResultado Mensaje
		
		INSERT INTO SolicitudClienteLog(SolicitudClienteID, FechaEjecucion, Descripcion, ConsultoraID, CodigoUbigeo, NombreCompleto, Email, Telefono,
				Mensaje, Campania, UnidadGeografica1, UnidadGeografica2, UnidadGeografica3, TipoDistribucion, MarcaID, SolicitudClienteOrigen, Direccion, 
				FlagConsultora, FlagMedio, CodigoDispositivo, SODispositivo)
		VALUES (NULL, GETDATE(), @MensajeResultado, @ConsultoraID, @CodigoUbigeo, @NombreCompleto, @Email, @Telefono,
				@Mensaje, @Campania, @UnidGeo1, @UnidGeo2, @UnidGeo3, @TipoDistribucion, 0, 0, @Direccion, 
				@FlagConsultora, @FlagMedio, @CodigoDispositivo, @SODispositivo)
		SET @SolicitudClienteLogID = SCOPE_IDENTITY();
	END CATCH
END

GO
USE [BelcorpChile];
GO
ALTER PROCEDURE [dbo].[RegistrarSolicitudClienteAppCatalogo]	
    @Campania VARCHAR(6),
	@CodigoConsultora VARCHAR(30),
	@CodigoUbigeo VARCHAR(40),
	@ConsultoraID BIGINT,
	@Direccion VARCHAR(800),
	@Email VARCHAR(110),
	@Mensaje VARCHAR(810),
	@NombreCompleto VARCHAR(110),
	@Telefono VARCHAR(110),
	@FlagConsultora BIT,
	@FlagMedio VARCHAR(10),
	@NumIteracion INT,
	@CodigoDispositivo VARCHAR(50) = '-',
	@SODispositivo VARCHAR(20) = '-',
	@TipoUsuario INT = 0,
	@UsuarioAppID BIGINT = 0,
	@SolicitudDetalle dbo.SolicitudDetalleAppCatalogoType READONLY,
	@SolicitudClienteOrigen BIGINT = null,
	@IDCDC VARCHAR(100) = NULL,
	@IDCMC VARCHAR(200) = NULL
AS
BEGIN
	DECLARE
		@SolicitudClienteID BIGINT,
		@MensajeResultado VARCHAR(500),
		@SolicitudClienteLogID BIGINT,
		@MensajeResultadoDetalle VARCHAR(500),
		@flagDetalle BIT,
		@TerritorioID INT

	SET @SolicitudClienteID = 0
	SET @SolicitudClienteLogID = 0
	SET @flagDetalle = 0
	SET @TerritorioID = (SELECT TerritorioID FROM ods.Consultora where ConsultoraID=@ConsultoraID)

	BEGIN TRY
		SET @MensajeResultado = ''

		--VALIDACIONES: INICIO--
		IF @CodigoConsultora IS NULL
			SET @MensajeResultado = @MensajeResultado + 'El código de consultora no fue ingresado.|'
		ELSE IF LEN(@CodigoConsultora) > 20
			SET @MensajeResultado = @MensajeResultado + 'El código de consultora no debe exceder los 20 caracteres.|'
		ELSE IF NOT EXISTS(SELECT 1 FROM ods.Consultora WHERE RTRIM(Codigo) = RTRIM(@CodigoConsultora))
			SET @MensajeResultado = @MensajeResultado + 'No existe el Código de Consultora.|'

		IF @ConsultoraID IS NULL OR @ConsultoraID = 0
			SET @MensajeResultado = @MensajeResultado + 'El ID de consultora no fue ingresado.|'
		ELSE IF NOT EXISTS(SELECT 1 FROM ods.Consultora WHERE ConsultoraID = @ConsultoraID)
			SET @MensajeResultado = @MensajeResultado + 'No existe el ID de la consultora.|'
		ELSE IF RTRIM(@CodigoConsultora) <> (SELECT RTRIM(Codigo) FROM ods.Consultora where ConsultoraID=@ConsultoraID)
			SET @MensajeResultado = @MensajeResultado + 'El Id de Consultora no está asociado con el Código Consultora.|'

		IF @CodigoUbigeo IS NULL
			SET @MensajeResultado = @MensajeResultado + 'El código ubigeo no fue ingresado.|'
		ELSE IF NOT EXISTS(SELECT 1 FROM dbo.Ubigeo WHERE CodigoUbigeo = @CodigoUbigeo)
		BEGIN
			IF NOT EXISTS(SELECT 1 FROM ods.Ubigeo WHERE CodigoUbigeo = @CodigoUbigeo)
			    SET @MensajeResultado = @MensajeResultado + 'No existe el código ubigeo.|'
		END

		IF @NombreCompleto IS NULL
			SET @MensajeResultado = @MensajeResultado + 'El nombre completo de la cliente no fue ingresado.|'
		ELSE IF LEN(@NombreCompleto) > 100
			SET @MensajeResultado = @MensajeResultado + 'El nombre completo de la cliente no debe exceder los 100 caracteres.|'

		IF @Email IS NULL
			SET @MensajeResultado = @MensajeResultado + 'El email de la cliente no fue ingresado.|'
		ELSE IF LEN(@Email) > 100
			SET @MensajeResultado = @MensajeResultado + 'El email de la cliente no debe exceder los 100 caracteres.|'

		IF @Telefono IS NULL
			SET @MensajeResultado = @MensajeResultado + 'El teléfono de la cliente no fue ingresado.|'
		ELSE IF LEN(@Telefono) > 100
			SET @MensajeResultado = @MensajeResultado + 'El teléfono de la cliente no debe exceder los 100 caracteres.|'

		IF @Mensaje IS NULL
			SET @MensajeResultado = @MensajeResultado + 'El mensaje de la cliente no fue ingresado.|'
		ELSE IF LEN(@Mensaje) > 800
			SET @MensajeResultado = @MensajeResultado + 'El mensaje no debe exceder los 800 caracteres.|'

		IF @Campania IS NULL
			SET @MensajeResultado = @MensajeResultado + 'La campaña no fue ingresada.|'
		ELSE IF LEN(@Campania) > 6
			SET @MensajeResultado = @MensajeResultado + 'El código de campaña no debe exceder los 6 caracteres.|'
		ELSE IF NOT EXISTS(SELECT Codigo FROM ods.Campania WHERE Codigo IN (@Campania))
			SET @MensajeResultado = @MensajeResultado + 'No existe la campaña ' + @Campania + '.|'

		IF @FlagMedio IS NULL OR LEN (@FlagMedio) = 0
			SET @MensajeResultado = @MensajeResultado + 'El flag medio no fue ingresado.|'
		ELSE IF NOT EXISTS(SELECT 1 FROM TablaLogicaDatos WHERE TablaLogicaID = 85 AND Codigo = @FlagMedio)
			SET @MensajeResultado = @MensajeResultado + 'El flag medio ''' + @FlagMedio + ''' no es válido.|'
		
		IF @CodigoDispositivo IS NULL
			SET @MensajeResultado = @MensajeResultado + 'El código del dispositivo no fue ingresado.|'
		ELSE IF LEN(@CodigoDispositivo) > 50
			SET @MensajeResultado = @MensajeResultado + 'El código del dispositivo no debe exceder los 50 caracteres.|'

		IF @SODispositivo IS NULL
			SET @MensajeResultado = @MensajeResultado + 'El so del dispositivo no fue ingresado.|'
		ELSE IF LEN(@SODispositivo) > 20
			SET @MensajeResultado = @MensajeResultado + 'El so del dispositivo no debe exceder los 100 caracteres.|'

		--VALIDACIONES: FIN--
		---------------------

		DECLARE
			@UnidGeo1 VARCHAR(100),
			@UnidGeo2 VARCHAR(100),
			@UnidGeo3 VARCHAR(100),
			@TipoDistribucion SMALLINT,
			@CodigoTipoDistribucion VARCHAR(10);

		SELECT TOP 1
			@UnidGeo1 = UnidadGeografica1,
			@UnidGeo2 = UnidadGeografica2,
			@UnidGeo3 = UnidadGeografica3
		FROM dbo.Ubigeo
		WHERE CodigoUbigeo = @CodigoUbigeo

		SELECT @CodigoTipoDistribucion = Codigo
		FROM TablaLogicaDatos
		WHERE TablaLogicaDatosID = 6801 AND TablaLogicaID = 68;

		SET @TipoDistribucion = CAST(@CodigoTipoDistribucion AS SMALLINT);

		IF @MensajeResultado <> ''
		BEGIN
			INSERT INTO SolicitudClienteLog(SolicitudClienteID, FechaEjecucion, Descripcion, ConsultoraID, CodigoUbigeo, NombreCompleto, Email, Telefono,
				Mensaje, Campania, UnidadGeografica1, UnidadGeografica2, UnidadGeografica3, TipoDistribucion, MarcaID, SolicitudClienteOrigen, Direccion, 
				FlagConsultora, FlagMedio, CodigoDispositivo, SODispositivo)
			VALUES (NULL, GETDATE(), @MensajeResultado, @ConsultoraID, @CodigoUbigeo, @NombreCompleto, @Email, @Telefono,
				@Mensaje, @Campania, @UnidGeo1, @UnidGeo2, @UnidGeo3, @TipoDistribucion, 0, 0, @Direccion, 
				@FlagConsultora, @FlagMedio, @CodigoDispositivo, @SODispositivo)
			SET @SolicitudClienteLogID = SCOPE_IDENTITY();
		END
		ELSE
		BEGIN
			INSERT INTO SolicitudCliente(ConsultoraID, CodigoUbigeo, NombreCompleto, Email, Telefono, Mensaje, Campania, MarcaID, FechaSolicitud, Leido, NumIteracion,UnidadGeografica1, UnidadGeografica2, UnidadGeografica3, TipoDistribucion, SolicitudClienteOrigen,
 Direccion, FlagConsultora, FlagMedio, CodigoDispositivo, SODispositivo, TipoUsuario, UsuarioAppID, IDCDC, IDCMC)
			VALUES (@ConsultoraID, @CodigoUbigeo, @NombreCompleto, @Email, @Telefono, @Mensaje, @Campania, 0, GETDATE(), 0, @NumIteracion, @UnidGeo1, @UnidGeo2, @UnidGeo3, @TipoDistribucion,isnull(@SolicitudClienteOrigen,0),@Direccion, @FlagConsultora, @FlagMedio,
 @CodigoDispositivo, @SODispositivo, @TipoUsuario, @UsuarioAppID, @IDCDC, @IDCMC)

			SET @SolicitudClienteID = SCOPE_IDENTITY();
			SET @MensajeResultado = 'Acción ejecutada satisfactoriamente.';

			--********************************Buscar el cliente origen, Codigo: Cesar FLores**************************
			IF @SolicitudClienteOrigen is null
			BEGIN
				SET @SolicitudClienteOrigen = isnull(dbo.ObtenerSolicitudClienteOrigen(@SolicitudClienteID),0);
				IF @SolicitudClienteOrigen <> 0
				BEGIN
					UPDATE SolicitudCliente
					SET SolicitudClienteOrigen=@SolicitudClienteOrigen
					WHERE SolicitudClienteID=@SolicitudClienteID;
				END
			END
			--*********************************************************************************************************

			INSERT INTO SolicitudClienteLog(SolicitudClienteID, FechaEjecucion, Descripcion, ConsultoraID, CodigoUbigeo, NombreCompleto, Email, Telefono,
				Mensaje, Campania, UnidadGeografica1, UnidadGeografica2, UnidadGeografica3, TipoDistribucion, MarcaID, SolicitudClienteOrigen, Direccion, 
				FlagConsultora, FlagMedio, CodigoDispositivo, SODispositivo)
			VALUES (@SolicitudClienteID, GETDATE(), @MensajeResultado, @ConsultoraID, @CodigoUbigeo, @NombreCompleto, @Email, @Telefono,
				@Mensaje, @Campania, @UnidGeo1, @UnidGeo2, @UnidGeo3, @TipoDistribucion, 0, @SolicitudClienteOrigen, @Direccion, 
				@FlagConsultora, @FlagMedio, @CodigoDispositivo, @SODispositivo)
			SET @SolicitudClienteLogID = SCOPE_IDENTITY();
				
			DECLARE
				@Cantidad INT,
				@CUV VARCHAR(6),
				@MarcaID INT,
				@DescripcionProducto VARCHAR(100),
				@Precio DECIMAL(20,2),
				@Tono VARCHAR(250),
				@Url VARCHAR(500),
				@i INT,
				@total INT

			DECLARE @TempSolicitudClienteDetalle TABLE
			(
				ID INT IDENTITY(1, 1),
				Cantidad INT,
				CUV VARCHAR(6),
				MarcaID INT,
				DescripcionProducto VARCHAR(100),
				Precio DECIMAL(20,2),
				Tono VARCHAR(250),
				Url VARCHAR(500)
			)

			INSERT INTO @TempSolicitudClienteDetalle(Cantidad, CUV, MarcaID, DescripcionProducto, Precio, Tono, Url)
			SELECT Cantidad, CUV, MarcaID, DescripcionProducto, Precio, Tono, Url FROM @SolicitudDetalle

			SET @i = 1
			SET @total = (SELECT MAX(ID) FROM @TempSolicitudClienteDetalle)
			WHILE @i <= @total
			BEGIN
				SET @CUV = (SELECT CUV FROM @TempSolicitudClienteDetalle WHERE ID = @i)
				SET @DescripcionProducto = (SELECT DescripcionProducto FROM @TempSolicitudClienteDetalle WHERE ID = @i)
				SET @Cantidad = (SELECT Cantidad FROM @TempSolicitudClienteDetalle WHERE ID = @i)
				SET @Precio = (SELECT Precio FROM @TempSolicitudClienteDetalle WHERE ID = @i)
				SET @MarcaID = (SELECT MarcaID FROM @TempSolicitudClienteDetalle WHERE ID = @i)
				SET @Tono = (SELECT Tono FROM @TempSolicitudClienteDetalle WHERE ID = @i)
				SET @Url = (SELECT Url FROM @TempSolicitudClienteDetalle WHERE ID = @i)
				SET @MensajeResultadoDetalle = ''

				/*RE2603 - CS(GGI) - 22/05/2015 - se esta quitando la validación para el @cuv*/

				--VALIDACIONES: INICIO--
				IF @DescripcionProducto IS NULL OR LEN(@DescripcionProducto) = 0
					SET @MensajeResultadoDetalle = @MensajeResultadoDetalle + 'No se ha ingresado la descripción de producto.|'

				IF @Cantidad <= 0
					SET @MensajeResultadoDetalle = @MensajeResultadoDetalle + 'La cantidad ingresada debe ser mayor a cero.|'

				IF @Precio <= 0
					SET @MensajeResultadoDetalle = @MensajeResultadoDetalle + 'El precio ingresado debe ser mayor a cero.|'
					
				IF NOT EXISTS(SELECT 1 FROM ods.Marca WHERE MarcaID IN (@MarcaID))
					SET @MensajeResultado = @MensajeResultado + 'No existe la marca con ID: ' + @MarcaID + '.|'
				ELSE IF @MarcaID NOT IN (1, 2, 3)
					SET @MensajeResultado = @MensajeResultado + 'El registro de solicitud es solo para las marcas: LBel, Esika, Cyzone.|'
				--VALIDACIONES: FIN--

				IF @MensajeResultadoDetalle <> ''
				BEGIN
					SET @flagDetalle = 1
					INSERT INTO SolicitudClienteDetalleLog(SolicitudClienteLogID, FechaEjecucion, Descripcion, CUV, Producto, Cantidad, Precio, MarcaID, Tono, Url) 
					VALUES (@SolicitudClienteLogID, GETDATE(), @MensajeResultadoDetalle, @CUV, @DescripcionProducto, @Cantidad, @Precio, @MarcaID, @Tono, @Url);
				END
				ELSE
				BEGIN
					SET @MensajeResultadoDetalle = 'Acción ejecutada satisfactoriamente.';
					-- Insertar el log del detalle. CORRECTO
					INSERT INTO SolicitudClienteDetalle(SolicitudClienteID, CUV, Producto, Cantidad, Precio, MarcaID, FechaCreacion, Tono, Url)
					VALUES (@SolicitudClienteID, @CUV, @DescripcionProducto, @Cantidad, @Precio, @MarcaID, getDate(), @Tono, @Url);
					INSERT INTO SolicitudClienteDetalleLog(SolicitudClienteLogID, FechaEjecucion, Descripcion, CUV, Producto, Cantidad, Precio, MarcaID, Tono, Url)
					VALUES (@SolicitudClienteLogID, GETDATE(), @MensajeResultadoDetalle, @CUV, @DescripcionProducto, @Cantidad, @Precio, @MarcaID, @Tono, @Url);
				END

				SET @i = @i + 1;
			END
		END

		IF @flagDetalle = 1
		BEGIN
			SET @MensajeResultado = 'Hubo un error al intentar registrar el detalle de la solicitud.';
			DELETE FROM SolicitudClienteDetalle WHERE SolicitudClienteID = @SolicitudClienteID;
			DELETE FROM SolicitudCliente WHERE SolicitudClienteID = @SolicitudClienteID;

			UPDATE SolicitudClienteLog
			SET
				SolicitudClienteID = NULL,
				Descripcion = @MensajeResultado
			WHERE SolicitudClienteLogID = @SolicitudClienteLogID;

			SET @SolicitudClienteID = 0;
		END

		SELECT @SolicitudClienteID Resultado, @MensajeResultado Mensaje;
	END TRY
	BEGIN CATCH
		SET @MensajeResultado = CONCAT(ERROR_MESSAGE(),' ',ERROR_LINE());
		SELECT @SolicitudClienteID Resultado, @MensajeResultado Mensaje
		
		INSERT INTO SolicitudClienteLog(SolicitudClienteID, FechaEjecucion, Descripcion, ConsultoraID, CodigoUbigeo, NombreCompleto, Email, Telefono,
				Mensaje, Campania, UnidadGeografica1, UnidadGeografica2, UnidadGeografica3, TipoDistribucion, MarcaID, SolicitudClienteOrigen, Direccion, 
				FlagConsultora, FlagMedio, CodigoDispositivo, SODispositivo)
		VALUES (NULL, GETDATE(), @MensajeResultado, @ConsultoraID, @CodigoUbigeo, @NombreCompleto, @Email, @Telefono,
				@Mensaje, @Campania, @UnidGeo1, @UnidGeo2, @UnidGeo3, @TipoDistribucion, 0, 0, @Direccion, 
				@FlagConsultora, @FlagMedio, @CodigoDispositivo, @SODispositivo)
		SET @SolicitudClienteLogID = SCOPE_IDENTITY();
	END CATCH
END

GO
USE [BelcorpColombia];
GO
ALTER PROCEDURE [dbo].[RegistrarSolicitudClienteAppCatalogo]	
    @Campania VARCHAR(6),
	@CodigoConsultora VARCHAR(30),
	@CodigoUbigeo VARCHAR(40),
	@ConsultoraID BIGINT,
	@Direccion VARCHAR(800),
	@Email VARCHAR(110),
	@Mensaje VARCHAR(810),
	@NombreCompleto VARCHAR(110),
	@Telefono VARCHAR(110),
	@FlagConsultora BIT,
	@FlagMedio VARCHAR(10),
	@NumIteracion INT,
	@CodigoDispositivo VARCHAR(50) = '-',
	@SODispositivo VARCHAR(20) = '-',
	@TipoUsuario INT = 0,
	@UsuarioAppID BIGINT = 0,
	@SolicitudDetalle dbo.SolicitudDetalleAppCatalogoType READONLY,
	@SolicitudClienteOrigen BIGINT = null,
	@IDCDC VARCHAR(100) = NULL,
	@IDCMC VARCHAR(200) = NULL
AS
BEGIN
	DECLARE
		@SolicitudClienteID BIGINT,
		@MensajeResultado VARCHAR(500),
		@SolicitudClienteLogID BIGINT,
		@MensajeResultadoDetalle VARCHAR(500),
		@flagDetalle BIT,
		@TerritorioID INT

	SET @SolicitudClienteID = 0
	SET @SolicitudClienteLogID = 0
	SET @flagDetalle = 0
	SET @TerritorioID = (SELECT TerritorioID FROM ods.Consultora where ConsultoraID=@ConsultoraID)

	BEGIN TRY
		SET @MensajeResultado = ''

		--VALIDACIONES: INICIO--
		IF @CodigoConsultora IS NULL
			SET @MensajeResultado = @MensajeResultado + 'El código de consultora no fue ingresado.|'
		ELSE IF LEN(@CodigoConsultora) > 20
			SET @MensajeResultado = @MensajeResultado + 'El código de consultora no debe exceder los 20 caracteres.|'
		ELSE IF NOT EXISTS(SELECT 1 FROM ods.Consultora WHERE RTRIM(Codigo) = RTRIM(@CodigoConsultora))
			SET @MensajeResultado = @MensajeResultado + 'No existe el Código de Consultora.|'

		IF @ConsultoraID IS NULL OR @ConsultoraID = 0
			SET @MensajeResultado = @MensajeResultado + 'El ID de consultora no fue ingresado.|'
		ELSE IF NOT EXISTS(SELECT 1 FROM ods.Consultora WHERE ConsultoraID = @ConsultoraID)
			SET @MensajeResultado = @MensajeResultado + 'No existe el ID de la consultora.|'
		ELSE IF RTRIM(@CodigoConsultora) <> (SELECT RTRIM(Codigo) FROM ods.Consultora where ConsultoraID=@ConsultoraID)
			SET @MensajeResultado = @MensajeResultado + 'El Id de Consultora no está asociado con el Código Consultora.|'

		IF @CodigoUbigeo IS NULL
			SET @MensajeResultado = @MensajeResultado + 'El código ubigeo no fue ingresado.|'
		ELSE IF NOT EXISTS(SELECT 1 FROM dbo.Ubigeo WHERE CodigoUbigeo = @CodigoUbigeo)
		BEGIN
			IF NOT EXISTS(SELECT 1 FROM ods.Ubigeo WHERE CodigoUbigeo = @CodigoUbigeo)
			    SET @MensajeResultado = @MensajeResultado + 'No existe el código ubigeo.|'
		END

		IF @NombreCompleto IS NULL
			SET @MensajeResultado = @MensajeResultado + 'El nombre completo de la cliente no fue ingresado.|'
		ELSE IF LEN(@NombreCompleto) > 100
			SET @MensajeResultado = @MensajeResultado + 'El nombre completo de la cliente no debe exceder los 100 caracteres.|'

		IF @Email IS NULL
			SET @MensajeResultado = @MensajeResultado + 'El email de la cliente no fue ingresado.|'
		ELSE IF LEN(@Email) > 100
			SET @MensajeResultado = @MensajeResultado + 'El email de la cliente no debe exceder los 100 caracteres.|'

		IF @Telefono IS NULL
			SET @MensajeResultado = @MensajeResultado + 'El teléfono de la cliente no fue ingresado.|'
		ELSE IF LEN(@Telefono) > 100
			SET @MensajeResultado = @MensajeResultado + 'El teléfono de la cliente no debe exceder los 100 caracteres.|'

		IF @Mensaje IS NULL
			SET @MensajeResultado = @MensajeResultado + 'El mensaje de la cliente no fue ingresado.|'
		ELSE IF LEN(@Mensaje) > 800
			SET @MensajeResultado = @MensajeResultado + 'El mensaje no debe exceder los 800 caracteres.|'

		IF @Campania IS NULL
			SET @MensajeResultado = @MensajeResultado + 'La campaña no fue ingresada.|'
		ELSE IF LEN(@Campania) > 6
			SET @MensajeResultado = @MensajeResultado + 'El código de campaña no debe exceder los 6 caracteres.|'
		ELSE IF NOT EXISTS(SELECT Codigo FROM ods.Campania WHERE Codigo IN (@Campania))
			SET @MensajeResultado = @MensajeResultado + 'No existe la campaña ' + @Campania + '.|'

		IF @FlagMedio IS NULL OR LEN (@FlagMedio) = 0
			SET @MensajeResultado = @MensajeResultado + 'El flag medio no fue ingresado.|'
		ELSE IF NOT EXISTS(SELECT 1 FROM TablaLogicaDatos WHERE TablaLogicaID = 85 AND Codigo = @FlagMedio)
			SET @MensajeResultado = @MensajeResultado + 'El flag medio ''' + @FlagMedio + ''' no es válido.|'
		
		IF @CodigoDispositivo IS NULL
			SET @MensajeResultado = @MensajeResultado + 'El código del dispositivo no fue ingresado.|'
		ELSE IF LEN(@CodigoDispositivo) > 50
			SET @MensajeResultado = @MensajeResultado + 'El código del dispositivo no debe exceder los 50 caracteres.|'

		IF @SODispositivo IS NULL
			SET @MensajeResultado = @MensajeResultado + 'El so del dispositivo no fue ingresado.|'
		ELSE IF LEN(@SODispositivo) > 20
			SET @MensajeResultado = @MensajeResultado + 'El so del dispositivo no debe exceder los 100 caracteres.|'

		--VALIDACIONES: FIN--
		---------------------

		DECLARE
			@UnidGeo1 VARCHAR(100),
			@UnidGeo2 VARCHAR(100),
			@UnidGeo3 VARCHAR(100),
			@TipoDistribucion SMALLINT,
			@CodigoTipoDistribucion VARCHAR(10);

		SELECT TOP 1
			@UnidGeo1 = UnidadGeografica1,
			@UnidGeo2 = UnidadGeografica2,
			@UnidGeo3 = UnidadGeografica3
		FROM dbo.Ubigeo
		WHERE CodigoUbigeo = @CodigoUbigeo

		SELECT @CodigoTipoDistribucion = Codigo
		FROM TablaLogicaDatos
		WHERE TablaLogicaDatosID = 6801 AND TablaLogicaID = 68;

		SET @TipoDistribucion = CAST(@CodigoTipoDistribucion AS SMALLINT);

		IF @MensajeResultado <> ''
		BEGIN
			INSERT INTO SolicitudClienteLog(SolicitudClienteID, FechaEjecucion, Descripcion, ConsultoraID, CodigoUbigeo, NombreCompleto, Email, Telefono,
				Mensaje, Campania, UnidadGeografica1, UnidadGeografica2, UnidadGeografica3, TipoDistribucion, MarcaID, SolicitudClienteOrigen, Direccion, 
				FlagConsultora, FlagMedio, CodigoDispositivo, SODispositivo)
			VALUES (NULL, GETDATE(), @MensajeResultado, @ConsultoraID, @CodigoUbigeo, @NombreCompleto, @Email, @Telefono,
				@Mensaje, @Campania, @UnidGeo1, @UnidGeo2, @UnidGeo3, @TipoDistribucion, 0, 0, @Direccion, 
				@FlagConsultora, @FlagMedio, @CodigoDispositivo, @SODispositivo)
			SET @SolicitudClienteLogID = SCOPE_IDENTITY();
		END
		ELSE
		BEGIN
			INSERT INTO SolicitudCliente(ConsultoraID, CodigoUbigeo, NombreCompleto, Email, Telefono, Mensaje, Campania, MarcaID, FechaSolicitud, Leido, NumIteracion,UnidadGeografica1, UnidadGeografica2, UnidadGeografica3, TipoDistribucion, SolicitudClienteOrigen,
 Direccion, FlagConsultora, FlagMedio, CodigoDispositivo, SODispositivo, TipoUsuario, UsuarioAppID, IDCDC, IDCMC)
			VALUES (@ConsultoraID, @CodigoUbigeo, @NombreCompleto, @Email, @Telefono, @Mensaje, @Campania, 0, GETDATE(), 0, @NumIteracion, @UnidGeo1, @UnidGeo2, @UnidGeo3, @TipoDistribucion,isnull(@SolicitudClienteOrigen,0),@Direccion, @FlagConsultora, @FlagMedio,
 @CodigoDispositivo, @SODispositivo, @TipoUsuario, @UsuarioAppID, @IDCDC, @IDCMC)

			SET @SolicitudClienteID = SCOPE_IDENTITY();
			SET @MensajeResultado = 'Acción ejecutada satisfactoriamente.';

			--********************************Buscar el cliente origen, Codigo: Cesar FLores**************************
			IF @SolicitudClienteOrigen is null
			BEGIN
				SET @SolicitudClienteOrigen = isnull(dbo.ObtenerSolicitudClienteOrigen(@SolicitudClienteID),0);
				IF @SolicitudClienteOrigen <> 0
				BEGIN
					UPDATE SolicitudCliente
					SET SolicitudClienteOrigen=@SolicitudClienteOrigen
					WHERE SolicitudClienteID=@SolicitudClienteID;
				END
			END
			--*********************************************************************************************************

			INSERT INTO SolicitudClienteLog(SolicitudClienteID, FechaEjecucion, Descripcion, ConsultoraID, CodigoUbigeo, NombreCompleto, Email, Telefono,
				Mensaje, Campania, UnidadGeografica1, UnidadGeografica2, UnidadGeografica3, TipoDistribucion, MarcaID, SolicitudClienteOrigen, Direccion, 
				FlagConsultora, FlagMedio, CodigoDispositivo, SODispositivo)
			VALUES (@SolicitudClienteID, GETDATE(), @MensajeResultado, @ConsultoraID, @CodigoUbigeo, @NombreCompleto, @Email, @Telefono,
				@Mensaje, @Campania, @UnidGeo1, @UnidGeo2, @UnidGeo3, @TipoDistribucion, 0, @SolicitudClienteOrigen, @Direccion, 
				@FlagConsultora, @FlagMedio, @CodigoDispositivo, @SODispositivo)
			SET @SolicitudClienteLogID = SCOPE_IDENTITY();
				
			DECLARE
				@Cantidad INT,
				@CUV VARCHAR(6),
				@MarcaID INT,
				@DescripcionProducto VARCHAR(100),
				@Precio DECIMAL(20,2),
				@Tono VARCHAR(250),
				@Url VARCHAR(500),
				@i INT,
				@total INT

			DECLARE @TempSolicitudClienteDetalle TABLE
			(
				ID INT IDENTITY(1, 1),
				Cantidad INT,
				CUV VARCHAR(6),
				MarcaID INT,
				DescripcionProducto VARCHAR(100),
				Precio DECIMAL(20,2),
				Tono VARCHAR(250),
				Url VARCHAR(500)
			)

			INSERT INTO @TempSolicitudClienteDetalle(Cantidad, CUV, MarcaID, DescripcionProducto, Precio, Tono, Url)
			SELECT Cantidad, CUV, MarcaID, DescripcionProducto, Precio, Tono, Url FROM @SolicitudDetalle

			SET @i = 1
			SET @total = (SELECT MAX(ID) FROM @TempSolicitudClienteDetalle)
			WHILE @i <= @total
			BEGIN
				SET @CUV = (SELECT CUV FROM @TempSolicitudClienteDetalle WHERE ID = @i)
				SET @DescripcionProducto = (SELECT DescripcionProducto FROM @TempSolicitudClienteDetalle WHERE ID = @i)
				SET @Cantidad = (SELECT Cantidad FROM @TempSolicitudClienteDetalle WHERE ID = @i)
				SET @Precio = (SELECT Precio FROM @TempSolicitudClienteDetalle WHERE ID = @i)
				SET @MarcaID = (SELECT MarcaID FROM @TempSolicitudClienteDetalle WHERE ID = @i)
				SET @Tono = (SELECT Tono FROM @TempSolicitudClienteDetalle WHERE ID = @i)
				SET @Url = (SELECT Url FROM @TempSolicitudClienteDetalle WHERE ID = @i)
				SET @MensajeResultadoDetalle = ''

				/*RE2603 - CS(GGI) - 22/05/2015 - se esta quitando la validación para el @cuv*/

				--VALIDACIONES: INICIO--
				IF @DescripcionProducto IS NULL OR LEN(@DescripcionProducto) = 0
					SET @MensajeResultadoDetalle = @MensajeResultadoDetalle + 'No se ha ingresado la descripción de producto.|'

				IF @Cantidad <= 0
					SET @MensajeResultadoDetalle = @MensajeResultadoDetalle + 'La cantidad ingresada debe ser mayor a cero.|'

				IF @Precio <= 0
					SET @MensajeResultadoDetalle = @MensajeResultadoDetalle + 'El precio ingresado debe ser mayor a cero.|'
					
				IF NOT EXISTS(SELECT 1 FROM ods.Marca WHERE MarcaID IN (@MarcaID))
					SET @MensajeResultado = @MensajeResultado + 'No existe la marca con ID: ' + @MarcaID + '.|'
				ELSE IF @MarcaID NOT IN (1, 2, 3)
					SET @MensajeResultado = @MensajeResultado + 'El registro de solicitud es solo para las marcas: LBel, Esika, Cyzone.|'
				--VALIDACIONES: FIN--

				IF @MensajeResultadoDetalle <> ''
				BEGIN
					SET @flagDetalle = 1
					INSERT INTO SolicitudClienteDetalleLog(SolicitudClienteLogID, FechaEjecucion, Descripcion, CUV, Producto, Cantidad, Precio, MarcaID, Tono, Url) 
					VALUES (@SolicitudClienteLogID, GETDATE(), @MensajeResultadoDetalle, @CUV, @DescripcionProducto, @Cantidad, @Precio, @MarcaID, @Tono, @Url);
				END
				ELSE
				BEGIN
					SET @MensajeResultadoDetalle = 'Acción ejecutada satisfactoriamente.';
					-- Insertar el log del detalle. CORRECTO
					INSERT INTO SolicitudClienteDetalle(SolicitudClienteID, CUV, Producto, Cantidad, Precio, MarcaID, FechaCreacion, Tono, Url)
					VALUES (@SolicitudClienteID, @CUV, @DescripcionProducto, @Cantidad, @Precio, @MarcaID, getDate(), @Tono, @Url);
					INSERT INTO SolicitudClienteDetalleLog(SolicitudClienteLogID, FechaEjecucion, Descripcion, CUV, Producto, Cantidad, Precio, MarcaID, Tono, Url)
					VALUES (@SolicitudClienteLogID, GETDATE(), @MensajeResultadoDetalle, @CUV, @DescripcionProducto, @Cantidad, @Precio, @MarcaID, @Tono, @Url);
				END

				SET @i = @i + 1;
			END
		END

		IF @flagDetalle = 1
		BEGIN
			SET @MensajeResultado = 'Hubo un error al intentar registrar el detalle de la solicitud.';
			DELETE FROM SolicitudClienteDetalle WHERE SolicitudClienteID = @SolicitudClienteID;
			DELETE FROM SolicitudCliente WHERE SolicitudClienteID = @SolicitudClienteID;

			UPDATE SolicitudClienteLog
			SET
				SolicitudClienteID = NULL,
				Descripcion = @MensajeResultado
			WHERE SolicitudClienteLogID = @SolicitudClienteLogID;

			SET @SolicitudClienteID = 0;
		END

		SELECT @SolicitudClienteID Resultado, @MensajeResultado Mensaje;
	END TRY
	BEGIN CATCH
		SET @MensajeResultado = CONCAT(ERROR_MESSAGE(),' ',ERROR_LINE());
		SELECT @SolicitudClienteID Resultado, @MensajeResultado Mensaje
		
		INSERT INTO SolicitudClienteLog(SolicitudClienteID, FechaEjecucion, Descripcion, ConsultoraID, CodigoUbigeo, NombreCompleto, Email, Telefono,
				Mensaje, Campania, UnidadGeografica1, UnidadGeografica2, UnidadGeografica3, TipoDistribucion, MarcaID, SolicitudClienteOrigen, Direccion, 
				FlagConsultora, FlagMedio, CodigoDispositivo, SODispositivo)
		VALUES (NULL, GETDATE(), @MensajeResultado, @ConsultoraID, @CodigoUbigeo, @NombreCompleto, @Email, @Telefono,
				@Mensaje, @Campania, @UnidGeo1, @UnidGeo2, @UnidGeo3, @TipoDistribucion, 0, 0, @Direccion, 
				@FlagConsultora, @FlagMedio, @CodigoDispositivo, @SODispositivo)
		SET @SolicitudClienteLogID = SCOPE_IDENTITY();
	END CATCH
END

GO
USE [BelcorpCostaRica];
GO
ALTER PROCEDURE [dbo].[RegistrarSolicitudClienteAppCatalogo]	
    @Campania VARCHAR(6),
	@CodigoConsultora VARCHAR(30),
	@CodigoUbigeo VARCHAR(40),
	@ConsultoraID BIGINT,
	@Direccion VARCHAR(800),
	@Email VARCHAR(110),
	@Mensaje VARCHAR(810),
	@NombreCompleto VARCHAR(110),
	@Telefono VARCHAR(110),
	@FlagConsultora BIT,
	@FlagMedio VARCHAR(10),
	@NumIteracion INT,
	@CodigoDispositivo VARCHAR(50) = '-',
	@SODispositivo VARCHAR(20) = '-',
	@TipoUsuario INT = 0,
	@UsuarioAppID BIGINT = 0,
	@SolicitudDetalle dbo.SolicitudDetalleAppCatalogoType READONLY,
	@SolicitudClienteOrigen BIGINT = null,
	@IDCDC VARCHAR(100) = NULL,
	@IDCMC VARCHAR(200) = NULL
AS
BEGIN
	DECLARE
		@SolicitudClienteID BIGINT,
		@MensajeResultado VARCHAR(500),
		@SolicitudClienteLogID BIGINT,
		@MensajeResultadoDetalle VARCHAR(500),
		@flagDetalle BIT,
		@TerritorioID INT

	SET @SolicitudClienteID = 0
	SET @SolicitudClienteLogID = 0
	SET @flagDetalle = 0
	SET @TerritorioID = (SELECT TerritorioID FROM ods.Consultora where ConsultoraID=@ConsultoraID)

	BEGIN TRY
		SET @MensajeResultado = ''

		--VALIDACIONES: INICIO--
		IF @CodigoConsultora IS NULL
			SET @MensajeResultado = @MensajeResultado + 'El código de consultora no fue ingresado.|'
		ELSE IF LEN(@CodigoConsultora) > 20
			SET @MensajeResultado = @MensajeResultado + 'El código de consultora no debe exceder los 20 caracteres.|'
		ELSE IF NOT EXISTS(SELECT 1 FROM ods.Consultora WHERE RTRIM(Codigo) = RTRIM(@CodigoConsultora))
			SET @MensajeResultado = @MensajeResultado + 'No existe el Código de Consultora.|'

		IF @ConsultoraID IS NULL OR @ConsultoraID = 0
			SET @MensajeResultado = @MensajeResultado + 'El ID de consultora no fue ingresado.|'
		ELSE IF NOT EXISTS(SELECT 1 FROM ods.Consultora WHERE ConsultoraID = @ConsultoraID)
			SET @MensajeResultado = @MensajeResultado + 'No existe el ID de la consultora.|'
		ELSE IF RTRIM(@CodigoConsultora) <> (SELECT RTRIM(Codigo) FROM ods.Consultora where ConsultoraID=@ConsultoraID)
			SET @MensajeResultado = @MensajeResultado + 'El Id de Consultora no está asociado con el Código Consultora.|'

		IF @CodigoUbigeo IS NULL
			SET @MensajeResultado = @MensajeResultado + 'El código ubigeo no fue ingresado.|'
		ELSE IF NOT EXISTS(SELECT 1 FROM dbo.Ubigeo WHERE CodigoUbigeo = @CodigoUbigeo)
		BEGIN
			IF NOT EXISTS(SELECT 1 FROM ods.Ubigeo WHERE CodigoUbigeo = @CodigoUbigeo)
			    SET @MensajeResultado = @MensajeResultado + 'No existe el código ubigeo.|'
		END

		IF @NombreCompleto IS NULL
			SET @MensajeResultado = @MensajeResultado + 'El nombre completo de la cliente no fue ingresado.|'
		ELSE IF LEN(@NombreCompleto) > 100
			SET @MensajeResultado = @MensajeResultado + 'El nombre completo de la cliente no debe exceder los 100 caracteres.|'

		IF @Email IS NULL
			SET @MensajeResultado = @MensajeResultado + 'El email de la cliente no fue ingresado.|'
		ELSE IF LEN(@Email) > 100
			SET @MensajeResultado = @MensajeResultado + 'El email de la cliente no debe exceder los 100 caracteres.|'

		IF @Telefono IS NULL
			SET @MensajeResultado = @MensajeResultado + 'El teléfono de la cliente no fue ingresado.|'
		ELSE IF LEN(@Telefono) > 100
			SET @MensajeResultado = @MensajeResultado + 'El teléfono de la cliente no debe exceder los 100 caracteres.|'

		IF @Mensaje IS NULL
			SET @MensajeResultado = @MensajeResultado + 'El mensaje de la cliente no fue ingresado.|'
		ELSE IF LEN(@Mensaje) > 800
			SET @MensajeResultado = @MensajeResultado + 'El mensaje no debe exceder los 800 caracteres.|'

		IF @Campania IS NULL
			SET @MensajeResultado = @MensajeResultado + 'La campaña no fue ingresada.|'
		ELSE IF LEN(@Campania) > 6
			SET @MensajeResultado = @MensajeResultado + 'El código de campaña no debe exceder los 6 caracteres.|'
		ELSE IF NOT EXISTS(SELECT Codigo FROM ods.Campania WHERE Codigo IN (@Campania))
			SET @MensajeResultado = @MensajeResultado + 'No existe la campaña ' + @Campania + '.|'

		IF @FlagMedio IS NULL OR LEN (@FlagMedio) = 0
			SET @MensajeResultado = @MensajeResultado + 'El flag medio no fue ingresado.|'
		ELSE IF NOT EXISTS(SELECT 1 FROM TablaLogicaDatos WHERE TablaLogicaID = 85 AND Codigo = @FlagMedio)
			SET @MensajeResultado = @MensajeResultado + 'El flag medio ''' + @FlagMedio + ''' no es válido.|'
		
		IF @CodigoDispositivo IS NULL
			SET @MensajeResultado = @MensajeResultado + 'El código del dispositivo no fue ingresado.|'
		ELSE IF LEN(@CodigoDispositivo) > 50
			SET @MensajeResultado = @MensajeResultado + 'El código del dispositivo no debe exceder los 50 caracteres.|'

		IF @SODispositivo IS NULL
			SET @MensajeResultado = @MensajeResultado + 'El so del dispositivo no fue ingresado.|'
		ELSE IF LEN(@SODispositivo) > 20
			SET @MensajeResultado = @MensajeResultado + 'El so del dispositivo no debe exceder los 100 caracteres.|'

		--VALIDACIONES: FIN--
		---------------------

		DECLARE
			@UnidGeo1 VARCHAR(100),
			@UnidGeo2 VARCHAR(100),
			@UnidGeo3 VARCHAR(100),
			@TipoDistribucion SMALLINT,
			@CodigoTipoDistribucion VARCHAR(10);

		SELECT TOP 1
			@UnidGeo1 = UnidadGeografica1,
			@UnidGeo2 = UnidadGeografica2,
			@UnidGeo3 = UnidadGeografica3
		FROM dbo.Ubigeo
		WHERE CodigoUbigeo = @CodigoUbigeo

		SELECT @CodigoTipoDistribucion = Codigo
		FROM TablaLogicaDatos
		WHERE TablaLogicaDatosID = 6801 AND TablaLogicaID = 68;

		SET @TipoDistribucion = CAST(@CodigoTipoDistribucion AS SMALLINT);

		IF @MensajeResultado <> ''
		BEGIN
			INSERT INTO SolicitudClienteLog(SolicitudClienteID, FechaEjecucion, Descripcion, ConsultoraID, CodigoUbigeo, NombreCompleto, Email, Telefono,
				Mensaje, Campania, UnidadGeografica1, UnidadGeografica2, UnidadGeografica3, TipoDistribucion, MarcaID, SolicitudClienteOrigen, Direccion, 
				FlagConsultora, FlagMedio, CodigoDispositivo, SODispositivo)
			VALUES (NULL, GETDATE(), @MensajeResultado, @ConsultoraID, @CodigoUbigeo, @NombreCompleto, @Email, @Telefono,
				@Mensaje, @Campania, @UnidGeo1, @UnidGeo2, @UnidGeo3, @TipoDistribucion, 0, 0, @Direccion, 
				@FlagConsultora, @FlagMedio, @CodigoDispositivo, @SODispositivo)
			SET @SolicitudClienteLogID = SCOPE_IDENTITY();
		END
		ELSE
		BEGIN
			INSERT INTO SolicitudCliente(ConsultoraID, CodigoUbigeo, NombreCompleto, Email, Telefono, Mensaje, Campania, MarcaID, FechaSolicitud, Leido, NumIteracion,UnidadGeografica1, UnidadGeografica2, UnidadGeografica3, TipoDistribucion, SolicitudClienteOrigen,
 Direccion, FlagConsultora, FlagMedio, CodigoDispositivo, SODispositivo, TipoUsuario, UsuarioAppID, IDCDC, IDCMC)
			VALUES (@ConsultoraID, @CodigoUbigeo, @NombreCompleto, @Email, @Telefono, @Mensaje, @Campania, 0, GETDATE(), 0, @NumIteracion, @UnidGeo1, @UnidGeo2, @UnidGeo3, @TipoDistribucion,isnull(@SolicitudClienteOrigen,0),@Direccion, @FlagConsultora, @FlagMedio,
 @CodigoDispositivo, @SODispositivo, @TipoUsuario, @UsuarioAppID, @IDCDC, @IDCMC)

			SET @SolicitudClienteID = SCOPE_IDENTITY();
			SET @MensajeResultado = 'Acción ejecutada satisfactoriamente.';

			--********************************Buscar el cliente origen, Codigo: Cesar FLores**************************
			IF @SolicitudClienteOrigen is null
			BEGIN
				SET @SolicitudClienteOrigen = isnull(dbo.ObtenerSolicitudClienteOrigen(@SolicitudClienteID),0);
				IF @SolicitudClienteOrigen <> 0
				BEGIN
					UPDATE SolicitudCliente
					SET SolicitudClienteOrigen=@SolicitudClienteOrigen
					WHERE SolicitudClienteID=@SolicitudClienteID;
				END
			END
			--*********************************************************************************************************

			INSERT INTO SolicitudClienteLog(SolicitudClienteID, FechaEjecucion, Descripcion, ConsultoraID, CodigoUbigeo, NombreCompleto, Email, Telefono,
				Mensaje, Campania, UnidadGeografica1, UnidadGeografica2, UnidadGeografica3, TipoDistribucion, MarcaID, SolicitudClienteOrigen, Direccion, 
				FlagConsultora, FlagMedio, CodigoDispositivo, SODispositivo)
			VALUES (@SolicitudClienteID, GETDATE(), @MensajeResultado, @ConsultoraID, @CodigoUbigeo, @NombreCompleto, @Email, @Telefono,
				@Mensaje, @Campania, @UnidGeo1, @UnidGeo2, @UnidGeo3, @TipoDistribucion, 0, @SolicitudClienteOrigen, @Direccion, 
				@FlagConsultora, @FlagMedio, @CodigoDispositivo, @SODispositivo)
			SET @SolicitudClienteLogID = SCOPE_IDENTITY();
				
			DECLARE
				@Cantidad INT,
				@CUV VARCHAR(6),
				@MarcaID INT,
				@DescripcionProducto VARCHAR(100),
				@Precio DECIMAL(20,2),
				@Tono VARCHAR(250),
				@Url VARCHAR(500),
				@i INT,
				@total INT

			DECLARE @TempSolicitudClienteDetalle TABLE
			(
				ID INT IDENTITY(1, 1),
				Cantidad INT,
				CUV VARCHAR(6),
				MarcaID INT,
				DescripcionProducto VARCHAR(100),
				Precio DECIMAL(20,2),
				Tono VARCHAR(250),
				Url VARCHAR(500)
			)

			INSERT INTO @TempSolicitudClienteDetalle(Cantidad, CUV, MarcaID, DescripcionProducto, Precio, Tono, Url)
			SELECT Cantidad, CUV, MarcaID, DescripcionProducto, Precio, Tono, Url FROM @SolicitudDetalle

			SET @i = 1
			SET @total = (SELECT MAX(ID) FROM @TempSolicitudClienteDetalle)
			WHILE @i <= @total
			BEGIN
				SET @CUV = (SELECT CUV FROM @TempSolicitudClienteDetalle WHERE ID = @i)
				SET @DescripcionProducto = (SELECT DescripcionProducto FROM @TempSolicitudClienteDetalle WHERE ID = @i)
				SET @Cantidad = (SELECT Cantidad FROM @TempSolicitudClienteDetalle WHERE ID = @i)
				SET @Precio = (SELECT Precio FROM @TempSolicitudClienteDetalle WHERE ID = @i)
				SET @MarcaID = (SELECT MarcaID FROM @TempSolicitudClienteDetalle WHERE ID = @i)
				SET @Tono = (SELECT Tono FROM @TempSolicitudClienteDetalle WHERE ID = @i)
				SET @Url = (SELECT Url FROM @TempSolicitudClienteDetalle WHERE ID = @i)
				SET @MensajeResultadoDetalle = ''

				/*RE2603 - CS(GGI) - 22/05/2015 - se esta quitando la validación para el @cuv*/

				--VALIDACIONES: INICIO--
				IF @DescripcionProducto IS NULL OR LEN(@DescripcionProducto) = 0
					SET @MensajeResultadoDetalle = @MensajeResultadoDetalle + 'No se ha ingresado la descripción de producto.|'

				IF @Cantidad <= 0
					SET @MensajeResultadoDetalle = @MensajeResultadoDetalle + 'La cantidad ingresada debe ser mayor a cero.|'

				IF @Precio <= 0
					SET @MensajeResultadoDetalle = @MensajeResultadoDetalle + 'El precio ingresado debe ser mayor a cero.|'
					
				IF NOT EXISTS(SELECT 1 FROM ods.Marca WHERE MarcaID IN (@MarcaID))
					SET @MensajeResultado = @MensajeResultado + 'No existe la marca con ID: ' + @MarcaID + '.|'
				ELSE IF @MarcaID NOT IN (1, 2, 3)
					SET @MensajeResultado = @MensajeResultado + 'El registro de solicitud es solo para las marcas: LBel, Esika, Cyzone.|'
				--VALIDACIONES: FIN--

				IF @MensajeResultadoDetalle <> ''
				BEGIN
					SET @flagDetalle = 1
					INSERT INTO SolicitudClienteDetalleLog(SolicitudClienteLogID, FechaEjecucion, Descripcion, CUV, Producto, Cantidad, Precio, MarcaID, Tono, Url) 
					VALUES (@SolicitudClienteLogID, GETDATE(), @MensajeResultadoDetalle, @CUV, @DescripcionProducto, @Cantidad, @Precio, @MarcaID, @Tono, @Url);
				END
				ELSE
				BEGIN
					SET @MensajeResultadoDetalle = 'Acción ejecutada satisfactoriamente.';
					-- Insertar el log del detalle. CORRECTO
					INSERT INTO SolicitudClienteDetalle(SolicitudClienteID, CUV, Producto, Cantidad, Precio, MarcaID, FechaCreacion, Tono, Url)
					VALUES (@SolicitudClienteID, @CUV, @DescripcionProducto, @Cantidad, @Precio, @MarcaID, getDate(), @Tono, @Url);
					INSERT INTO SolicitudClienteDetalleLog(SolicitudClienteLogID, FechaEjecucion, Descripcion, CUV, Producto, Cantidad, Precio, MarcaID, Tono, Url)
					VALUES (@SolicitudClienteLogID, GETDATE(), @MensajeResultadoDetalle, @CUV, @DescripcionProducto, @Cantidad, @Precio, @MarcaID, @Tono, @Url);
				END

				SET @i = @i + 1;
			END
		END

		IF @flagDetalle = 1
		BEGIN
			SET @MensajeResultado = 'Hubo un error al intentar registrar el detalle de la solicitud.';
			DELETE FROM SolicitudClienteDetalle WHERE SolicitudClienteID = @SolicitudClienteID;
			DELETE FROM SolicitudCliente WHERE SolicitudClienteID = @SolicitudClienteID;

			UPDATE SolicitudClienteLog
			SET
				SolicitudClienteID = NULL,
				Descripcion = @MensajeResultado
			WHERE SolicitudClienteLogID = @SolicitudClienteLogID;

			SET @SolicitudClienteID = 0;
		END

		SELECT @SolicitudClienteID Resultado, @MensajeResultado Mensaje;
	END TRY
	BEGIN CATCH
		SET @MensajeResultado = CONCAT(ERROR_MESSAGE(),' ',ERROR_LINE());
		SELECT @SolicitudClienteID Resultado, @MensajeResultado Mensaje
		
		INSERT INTO SolicitudClienteLog(SolicitudClienteID, FechaEjecucion, Descripcion, ConsultoraID, CodigoUbigeo, NombreCompleto, Email, Telefono,
				Mensaje, Campania, UnidadGeografica1, UnidadGeografica2, UnidadGeografica3, TipoDistribucion, MarcaID, SolicitudClienteOrigen, Direccion, 
				FlagConsultora, FlagMedio, CodigoDispositivo, SODispositivo)
		VALUES (NULL, GETDATE(), @MensajeResultado, @ConsultoraID, @CodigoUbigeo, @NombreCompleto, @Email, @Telefono,
				@Mensaje, @Campania, @UnidGeo1, @UnidGeo2, @UnidGeo3, @TipoDistribucion, 0, 0, @Direccion, 
				@FlagConsultora, @FlagMedio, @CodigoDispositivo, @SODispositivo)
		SET @SolicitudClienteLogID = SCOPE_IDENTITY();
	END CATCH
END

GO
USE [BelcorpDominicana];
GO
ALTER PROCEDURE [dbo].[RegistrarSolicitudClienteAppCatalogo]	
    @Campania VARCHAR(6),
	@CodigoConsultora VARCHAR(30),
	@CodigoUbigeo VARCHAR(40),
	@ConsultoraID BIGINT,
	@Direccion VARCHAR(800),
	@Email VARCHAR(110),
	@Mensaje VARCHAR(810),
	@NombreCompleto VARCHAR(110),
	@Telefono VARCHAR(110),
	@FlagConsultora BIT,
	@FlagMedio VARCHAR(10),
	@NumIteracion INT,
	@CodigoDispositivo VARCHAR(50) = '-',
	@SODispositivo VARCHAR(20) = '-',
	@TipoUsuario INT = 0,
	@UsuarioAppID BIGINT = 0,
	@SolicitudDetalle dbo.SolicitudDetalleAppCatalogoType READONLY,
	@SolicitudClienteOrigen BIGINT = null,
	@IDCDC VARCHAR(100) = NULL,
	@IDCMC VARCHAR(200) = NULL
AS
BEGIN
	DECLARE
		@SolicitudClienteID BIGINT,
		@MensajeResultado VARCHAR(500),
		@SolicitudClienteLogID BIGINT,
		@MensajeResultadoDetalle VARCHAR(500),
		@flagDetalle BIT,
		@TerritorioID INT

	SET @SolicitudClienteID = 0
	SET @SolicitudClienteLogID = 0
	SET @flagDetalle = 0
	SET @TerritorioID = (SELECT TerritorioID FROM ods.Consultora where ConsultoraID=@ConsultoraID)

	BEGIN TRY
		SET @MensajeResultado = ''

		--VALIDACIONES: INICIO--
		IF @CodigoConsultora IS NULL
			SET @MensajeResultado = @MensajeResultado + 'El código de consultora no fue ingresado.|'
		ELSE IF LEN(@CodigoConsultora) > 20
			SET @MensajeResultado = @MensajeResultado + 'El código de consultora no debe exceder los 20 caracteres.|'
		ELSE IF NOT EXISTS(SELECT 1 FROM ods.Consultora WHERE RTRIM(Codigo) = RTRIM(@CodigoConsultora))
			SET @MensajeResultado = @MensajeResultado + 'No existe el Código de Consultora.|'

		IF @ConsultoraID IS NULL OR @ConsultoraID = 0
			SET @MensajeResultado = @MensajeResultado + 'El ID de consultora no fue ingresado.|'
		ELSE IF NOT EXISTS(SELECT 1 FROM ods.Consultora WHERE ConsultoraID = @ConsultoraID)
			SET @MensajeResultado = @MensajeResultado + 'No existe el ID de la consultora.|'
		ELSE IF RTRIM(@CodigoConsultora) <> (SELECT RTRIM(Codigo) FROM ods.Consultora where ConsultoraID=@ConsultoraID)
			SET @MensajeResultado = @MensajeResultado + 'El Id de Consultora no está asociado con el Código Consultora.|'

		IF @CodigoUbigeo IS NULL
			SET @MensajeResultado = @MensajeResultado + 'El código ubigeo no fue ingresado.|'
		ELSE IF NOT EXISTS(SELECT 1 FROM dbo.Ubigeo WHERE CodigoUbigeo = @CodigoUbigeo)
		BEGIN
			IF NOT EXISTS(SELECT 1 FROM ods.Ubigeo WHERE CodigoUbigeo = @CodigoUbigeo)
			    SET @MensajeResultado = @MensajeResultado + 'No existe el código ubigeo.|'
		END

		IF @NombreCompleto IS NULL
			SET @MensajeResultado = @MensajeResultado + 'El nombre completo de la cliente no fue ingresado.|'
		ELSE IF LEN(@NombreCompleto) > 100
			SET @MensajeResultado = @MensajeResultado + 'El nombre completo de la cliente no debe exceder los 100 caracteres.|'

		IF @Email IS NULL
			SET @MensajeResultado = @MensajeResultado + 'El email de la cliente no fue ingresado.|'
		ELSE IF LEN(@Email) > 100
			SET @MensajeResultado = @MensajeResultado + 'El email de la cliente no debe exceder los 100 caracteres.|'

		IF @Telefono IS NULL
			SET @MensajeResultado = @MensajeResultado + 'El teléfono de la cliente no fue ingresado.|'
		ELSE IF LEN(@Telefono) > 100
			SET @MensajeResultado = @MensajeResultado + 'El teléfono de la cliente no debe exceder los 100 caracteres.|'

		IF @Mensaje IS NULL
			SET @MensajeResultado = @MensajeResultado + 'El mensaje de la cliente no fue ingresado.|'
		ELSE IF LEN(@Mensaje) > 800
			SET @MensajeResultado = @MensajeResultado + 'El mensaje no debe exceder los 800 caracteres.|'

		IF @Campania IS NULL
			SET @MensajeResultado = @MensajeResultado + 'La campaña no fue ingresada.|'
		ELSE IF LEN(@Campania) > 6
			SET @MensajeResultado = @MensajeResultado + 'El código de campaña no debe exceder los 6 caracteres.|'
		ELSE IF NOT EXISTS(SELECT Codigo FROM ods.Campania WHERE Codigo IN (@Campania))
			SET @MensajeResultado = @MensajeResultado + 'No existe la campaña ' + @Campania + '.|'

		IF @FlagMedio IS NULL OR LEN (@FlagMedio) = 0
			SET @MensajeResultado = @MensajeResultado + 'El flag medio no fue ingresado.|'
		ELSE IF NOT EXISTS(SELECT 1 FROM TablaLogicaDatos WHERE TablaLogicaID = 85 AND Codigo = @FlagMedio)
			SET @MensajeResultado = @MensajeResultado + 'El flag medio ''' + @FlagMedio + ''' no es válido.|'
		
		IF @CodigoDispositivo IS NULL
			SET @MensajeResultado = @MensajeResultado + 'El código del dispositivo no fue ingresado.|'
		ELSE IF LEN(@CodigoDispositivo) > 50
			SET @MensajeResultado = @MensajeResultado + 'El código del dispositivo no debe exceder los 50 caracteres.|'

		IF @SODispositivo IS NULL
			SET @MensajeResultado = @MensajeResultado + 'El so del dispositivo no fue ingresado.|'
		ELSE IF LEN(@SODispositivo) > 20
			SET @MensajeResultado = @MensajeResultado + 'El so del dispositivo no debe exceder los 100 caracteres.|'

		--VALIDACIONES: FIN--
		---------------------

		DECLARE
			@UnidGeo1 VARCHAR(100),
			@UnidGeo2 VARCHAR(100),
			@UnidGeo3 VARCHAR(100),
			@TipoDistribucion SMALLINT,
			@CodigoTipoDistribucion VARCHAR(10);

		SELECT TOP 1
			@UnidGeo1 = UnidadGeografica1,
			@UnidGeo2 = UnidadGeografica2,
			@UnidGeo3 = UnidadGeografica3
		FROM dbo.Ubigeo
		WHERE CodigoUbigeo = @CodigoUbigeo

		SELECT @CodigoTipoDistribucion = Codigo
		FROM TablaLogicaDatos
		WHERE TablaLogicaDatosID = 6801 AND TablaLogicaID = 68;

		SET @TipoDistribucion = CAST(@CodigoTipoDistribucion AS SMALLINT);

		IF @MensajeResultado <> ''
		BEGIN
			INSERT INTO SolicitudClienteLog(SolicitudClienteID, FechaEjecucion, Descripcion, ConsultoraID, CodigoUbigeo, NombreCompleto, Email, Telefono,
				Mensaje, Campania, UnidadGeografica1, UnidadGeografica2, UnidadGeografica3, TipoDistribucion, MarcaID, SolicitudClienteOrigen, Direccion, 
				FlagConsultora, FlagMedio, CodigoDispositivo, SODispositivo)
			VALUES (NULL, GETDATE(), @MensajeResultado, @ConsultoraID, @CodigoUbigeo, @NombreCompleto, @Email, @Telefono,
				@Mensaje, @Campania, @UnidGeo1, @UnidGeo2, @UnidGeo3, @TipoDistribucion, 0, 0, @Direccion, 
				@FlagConsultora, @FlagMedio, @CodigoDispositivo, @SODispositivo)
			SET @SolicitudClienteLogID = SCOPE_IDENTITY();
		END
		ELSE
		BEGIN
			INSERT INTO SolicitudCliente(ConsultoraID, CodigoUbigeo, NombreCompleto, Email, Telefono, Mensaje, Campania, MarcaID, FechaSolicitud, Leido, NumIteracion,UnidadGeografica1, UnidadGeografica2, UnidadGeografica3, TipoDistribucion, SolicitudClienteOrigen,
 Direccion, FlagConsultora, FlagMedio, CodigoDispositivo, SODispositivo, TipoUsuario, UsuarioAppID, IDCDC, IDCMC)
			VALUES (@ConsultoraID, @CodigoUbigeo, @NombreCompleto, @Email, @Telefono, @Mensaje, @Campania, 0, GETDATE(), 0, @NumIteracion, @UnidGeo1, @UnidGeo2, @UnidGeo3, @TipoDistribucion,isnull(@SolicitudClienteOrigen,0),@Direccion, @FlagConsultora, @FlagMedio,
 @CodigoDispositivo, @SODispositivo, @TipoUsuario, @UsuarioAppID, @IDCDC, @IDCMC)

			SET @SolicitudClienteID = SCOPE_IDENTITY();
			SET @MensajeResultado = 'Acción ejecutada satisfactoriamente.';

			--********************************Buscar el cliente origen, Codigo: Cesar FLores**************************
			IF @SolicitudClienteOrigen is null
			BEGIN
				SET @SolicitudClienteOrigen = isnull(dbo.ObtenerSolicitudClienteOrigen(@SolicitudClienteID),0);
				IF @SolicitudClienteOrigen <> 0
				BEGIN
					UPDATE SolicitudCliente
					SET SolicitudClienteOrigen=@SolicitudClienteOrigen
					WHERE SolicitudClienteID=@SolicitudClienteID;
				END
			END
			--*********************************************************************************************************

			INSERT INTO SolicitudClienteLog(SolicitudClienteID, FechaEjecucion, Descripcion, ConsultoraID, CodigoUbigeo, NombreCompleto, Email, Telefono,
				Mensaje, Campania, UnidadGeografica1, UnidadGeografica2, UnidadGeografica3, TipoDistribucion, MarcaID, SolicitudClienteOrigen, Direccion, 
				FlagConsultora, FlagMedio, CodigoDispositivo, SODispositivo)
			VALUES (@SolicitudClienteID, GETDATE(), @MensajeResultado, @ConsultoraID, @CodigoUbigeo, @NombreCompleto, @Email, @Telefono,
				@Mensaje, @Campania, @UnidGeo1, @UnidGeo2, @UnidGeo3, @TipoDistribucion, 0, @SolicitudClienteOrigen, @Direccion, 
				@FlagConsultora, @FlagMedio, @CodigoDispositivo, @SODispositivo)
			SET @SolicitudClienteLogID = SCOPE_IDENTITY();
				
			DECLARE
				@Cantidad INT,
				@CUV VARCHAR(6),
				@MarcaID INT,
				@DescripcionProducto VARCHAR(100),
				@Precio DECIMAL(20,2),
				@Tono VARCHAR(250),
				@Url VARCHAR(500),
				@i INT,
				@total INT

			DECLARE @TempSolicitudClienteDetalle TABLE
			(
				ID INT IDENTITY(1, 1),
				Cantidad INT,
				CUV VARCHAR(6),
				MarcaID INT,
				DescripcionProducto VARCHAR(100),
				Precio DECIMAL(20,2),
				Tono VARCHAR(250),
				Url VARCHAR(500)
			)

			INSERT INTO @TempSolicitudClienteDetalle(Cantidad, CUV, MarcaID, DescripcionProducto, Precio, Tono, Url)
			SELECT Cantidad, CUV, MarcaID, DescripcionProducto, Precio, Tono, Url FROM @SolicitudDetalle

			SET @i = 1
			SET @total = (SELECT MAX(ID) FROM @TempSolicitudClienteDetalle)
			WHILE @i <= @total
			BEGIN
				SET @CUV = (SELECT CUV FROM @TempSolicitudClienteDetalle WHERE ID = @i)
				SET @DescripcionProducto = (SELECT DescripcionProducto FROM @TempSolicitudClienteDetalle WHERE ID = @i)
				SET @Cantidad = (SELECT Cantidad FROM @TempSolicitudClienteDetalle WHERE ID = @i)
				SET @Precio = (SELECT Precio FROM @TempSolicitudClienteDetalle WHERE ID = @i)
				SET @MarcaID = (SELECT MarcaID FROM @TempSolicitudClienteDetalle WHERE ID = @i)
				SET @Tono = (SELECT Tono FROM @TempSolicitudClienteDetalle WHERE ID = @i)
				SET @Url = (SELECT Url FROM @TempSolicitudClienteDetalle WHERE ID = @i)
				SET @MensajeResultadoDetalle = ''

				/*RE2603 - CS(GGI) - 22/05/2015 - se esta quitando la validación para el @cuv*/

				--VALIDACIONES: INICIO--
				IF @DescripcionProducto IS NULL OR LEN(@DescripcionProducto) = 0
					SET @MensajeResultadoDetalle = @MensajeResultadoDetalle + 'No se ha ingresado la descripción de producto.|'

				IF @Cantidad <= 0
					SET @MensajeResultadoDetalle = @MensajeResultadoDetalle + 'La cantidad ingresada debe ser mayor a cero.|'

				IF @Precio <= 0
					SET @MensajeResultadoDetalle = @MensajeResultadoDetalle + 'El precio ingresado debe ser mayor a cero.|'
					
				IF NOT EXISTS(SELECT 1 FROM ods.Marca WHERE MarcaID IN (@MarcaID))
					SET @MensajeResultado = @MensajeResultado + 'No existe la marca con ID: ' + @MarcaID + '.|'
				ELSE IF @MarcaID NOT IN (1, 2, 3)
					SET @MensajeResultado = @MensajeResultado + 'El registro de solicitud es solo para las marcas: LBel, Esika, Cyzone.|'
				--VALIDACIONES: FIN--

				IF @MensajeResultadoDetalle <> ''
				BEGIN
					SET @flagDetalle = 1
					INSERT INTO SolicitudClienteDetalleLog(SolicitudClienteLogID, FechaEjecucion, Descripcion, CUV, Producto, Cantidad, Precio, MarcaID, Tono, Url) 
					VALUES (@SolicitudClienteLogID, GETDATE(), @MensajeResultadoDetalle, @CUV, @DescripcionProducto, @Cantidad, @Precio, @MarcaID, @Tono, @Url);
				END
				ELSE
				BEGIN
					SET @MensajeResultadoDetalle = 'Acción ejecutada satisfactoriamente.';
					-- Insertar el log del detalle. CORRECTO
					INSERT INTO SolicitudClienteDetalle(SolicitudClienteID, CUV, Producto, Cantidad, Precio, MarcaID, FechaCreacion, Tono, Url)
					VALUES (@SolicitudClienteID, @CUV, @DescripcionProducto, @Cantidad, @Precio, @MarcaID, getDate(), @Tono, @Url);
					INSERT INTO SolicitudClienteDetalleLog(SolicitudClienteLogID, FechaEjecucion, Descripcion, CUV, Producto, Cantidad, Precio, MarcaID, Tono, Url)
					VALUES (@SolicitudClienteLogID, GETDATE(), @MensajeResultadoDetalle, @CUV, @DescripcionProducto, @Cantidad, @Precio, @MarcaID, @Tono, @Url);
				END

				SET @i = @i + 1;
			END
		END

		IF @flagDetalle = 1
		BEGIN
			SET @MensajeResultado = 'Hubo un error al intentar registrar el detalle de la solicitud.';
			DELETE FROM SolicitudClienteDetalle WHERE SolicitudClienteID = @SolicitudClienteID;
			DELETE FROM SolicitudCliente WHERE SolicitudClienteID = @SolicitudClienteID;

			UPDATE SolicitudClienteLog
			SET
				SolicitudClienteID = NULL,
				Descripcion = @MensajeResultado
			WHERE SolicitudClienteLogID = @SolicitudClienteLogID;

			SET @SolicitudClienteID = 0;
		END

		SELECT @SolicitudClienteID Resultado, @MensajeResultado Mensaje;
	END TRY
	BEGIN CATCH
		SET @MensajeResultado = CONCAT(ERROR_MESSAGE(),' ',ERROR_LINE());
		SELECT @SolicitudClienteID Resultado, @MensajeResultado Mensaje
		
		INSERT INTO SolicitudClienteLog(SolicitudClienteID, FechaEjecucion, Descripcion, ConsultoraID, CodigoUbigeo, NombreCompleto, Email, Telefono,
				Mensaje, Campania, UnidadGeografica1, UnidadGeografica2, UnidadGeografica3, TipoDistribucion, MarcaID, SolicitudClienteOrigen, Direccion, 
				FlagConsultora, FlagMedio, CodigoDispositivo, SODispositivo)
		VALUES (NULL, GETDATE(), @MensajeResultado, @ConsultoraID, @CodigoUbigeo, @NombreCompleto, @Email, @Telefono,
				@Mensaje, @Campania, @UnidGeo1, @UnidGeo2, @UnidGeo3, @TipoDistribucion, 0, 0, @Direccion, 
				@FlagConsultora, @FlagMedio, @CodigoDispositivo, @SODispositivo)
		SET @SolicitudClienteLogID = SCOPE_IDENTITY();
	END CATCH
END

GO
USE [BelcorpEcuador];
GO
ALTER PROCEDURE [dbo].[RegistrarSolicitudClienteAppCatalogo]	
    @Campania VARCHAR(6),
	@CodigoConsultora VARCHAR(30),
	@CodigoUbigeo VARCHAR(40),
	@ConsultoraID BIGINT,
	@Direccion VARCHAR(800),
	@Email VARCHAR(110),
	@Mensaje VARCHAR(810),
	@NombreCompleto VARCHAR(110),
	@Telefono VARCHAR(110),
	@FlagConsultora BIT,
	@FlagMedio VARCHAR(10),
	@NumIteracion INT,
	@CodigoDispositivo VARCHAR(50) = '-',
	@SODispositivo VARCHAR(20) = '-',
	@TipoUsuario INT = 0,
	@UsuarioAppID BIGINT = 0,
	@SolicitudDetalle dbo.SolicitudDetalleAppCatalogoType READONLY,
	@SolicitudClienteOrigen BIGINT = null,
	@IDCDC VARCHAR(100) = NULL,
	@IDCMC VARCHAR(200) = NULL
AS
BEGIN
	DECLARE
		@SolicitudClienteID BIGINT,
		@MensajeResultado VARCHAR(500),
		@SolicitudClienteLogID BIGINT,
		@MensajeResultadoDetalle VARCHAR(500),
		@flagDetalle BIT,
		@TerritorioID INT

	SET @SolicitudClienteID = 0
	SET @SolicitudClienteLogID = 0
	SET @flagDetalle = 0
	SET @TerritorioID = (SELECT TerritorioID FROM ods.Consultora where ConsultoraID=@ConsultoraID)

	BEGIN TRY
		SET @MensajeResultado = ''

		--VALIDACIONES: INICIO--
		IF @CodigoConsultora IS NULL
			SET @MensajeResultado = @MensajeResultado + 'El código de consultora no fue ingresado.|'
		ELSE IF LEN(@CodigoConsultora) > 20
			SET @MensajeResultado = @MensajeResultado + 'El código de consultora no debe exceder los 20 caracteres.|'
		ELSE IF NOT EXISTS(SELECT 1 FROM ods.Consultora WHERE RTRIM(Codigo) = RTRIM(@CodigoConsultora))
			SET @MensajeResultado = @MensajeResultado + 'No existe el Código de Consultora.|'

		IF @ConsultoraID IS NULL OR @ConsultoraID = 0
			SET @MensajeResultado = @MensajeResultado + 'El ID de consultora no fue ingresado.|'
		ELSE IF NOT EXISTS(SELECT 1 FROM ods.Consultora WHERE ConsultoraID = @ConsultoraID)
			SET @MensajeResultado = @MensajeResultado + 'No existe el ID de la consultora.|'
		ELSE IF RTRIM(@CodigoConsultora) <> (SELECT RTRIM(Codigo) FROM ods.Consultora where ConsultoraID=@ConsultoraID)
			SET @MensajeResultado = @MensajeResultado + 'El Id de Consultora no está asociado con el Código Consultora.|'

		IF @CodigoUbigeo IS NULL
			SET @MensajeResultado = @MensajeResultado + 'El código ubigeo no fue ingresado.|'
		ELSE IF NOT EXISTS(SELECT 1 FROM dbo.Ubigeo WHERE CodigoUbigeo = @CodigoUbigeo)
		BEGIN
			IF NOT EXISTS(SELECT 1 FROM ods.Ubigeo WHERE CodigoUbigeo = @CodigoUbigeo)
			    SET @MensajeResultado = @MensajeResultado + 'No existe el código ubigeo.|'
		END

		IF @NombreCompleto IS NULL
			SET @MensajeResultado = @MensajeResultado + 'El nombre completo de la cliente no fue ingresado.|'
		ELSE IF LEN(@NombreCompleto) > 100
			SET @MensajeResultado = @MensajeResultado + 'El nombre completo de la cliente no debe exceder los 100 caracteres.|'

		IF @Email IS NULL
			SET @MensajeResultado = @MensajeResultado + 'El email de la cliente no fue ingresado.|'
		ELSE IF LEN(@Email) > 100
			SET @MensajeResultado = @MensajeResultado + 'El email de la cliente no debe exceder los 100 caracteres.|'

		IF @Telefono IS NULL
			SET @MensajeResultado = @MensajeResultado + 'El teléfono de la cliente no fue ingresado.|'
		ELSE IF LEN(@Telefono) > 100
			SET @MensajeResultado = @MensajeResultado + 'El teléfono de la cliente no debe exceder los 100 caracteres.|'

		IF @Mensaje IS NULL
			SET @MensajeResultado = @MensajeResultado + 'El mensaje de la cliente no fue ingresado.|'
		ELSE IF LEN(@Mensaje) > 800
			SET @MensajeResultado = @MensajeResultado + 'El mensaje no debe exceder los 800 caracteres.|'

		IF @Campania IS NULL
			SET @MensajeResultado = @MensajeResultado + 'La campaña no fue ingresada.|'
		ELSE IF LEN(@Campania) > 6
			SET @MensajeResultado = @MensajeResultado + 'El código de campaña no debe exceder los 6 caracteres.|'
		ELSE IF NOT EXISTS(SELECT Codigo FROM ods.Campania WHERE Codigo IN (@Campania))
			SET @MensajeResultado = @MensajeResultado + 'No existe la campaña ' + @Campania + '.|'

		IF @FlagMedio IS NULL OR LEN (@FlagMedio) = 0
			SET @MensajeResultado = @MensajeResultado + 'El flag medio no fue ingresado.|'
		ELSE IF NOT EXISTS(SELECT 1 FROM TablaLogicaDatos WHERE TablaLogicaID = 85 AND Codigo = @FlagMedio)
			SET @MensajeResultado = @MensajeResultado + 'El flag medio ''' + @FlagMedio + ''' no es válido.|'
		
		IF @CodigoDispositivo IS NULL
			SET @MensajeResultado = @MensajeResultado + 'El código del dispositivo no fue ingresado.|'
		ELSE IF LEN(@CodigoDispositivo) > 50
			SET @MensajeResultado = @MensajeResultado + 'El código del dispositivo no debe exceder los 50 caracteres.|'

		IF @SODispositivo IS NULL
			SET @MensajeResultado = @MensajeResultado + 'El so del dispositivo no fue ingresado.|'
		ELSE IF LEN(@SODispositivo) > 20
			SET @MensajeResultado = @MensajeResultado + 'El so del dispositivo no debe exceder los 100 caracteres.|'

		--VALIDACIONES: FIN--
		---------------------

		DECLARE
			@UnidGeo1 VARCHAR(100),
			@UnidGeo2 VARCHAR(100),
			@UnidGeo3 VARCHAR(100),
			@TipoDistribucion SMALLINT,
			@CodigoTipoDistribucion VARCHAR(10);

		SELECT TOP 1
			@UnidGeo1 = UnidadGeografica1,
			@UnidGeo2 = UnidadGeografica2,
			@UnidGeo3 = UnidadGeografica3
		FROM dbo.Ubigeo
		WHERE CodigoUbigeo = @CodigoUbigeo

		SELECT @CodigoTipoDistribucion = Codigo
		FROM TablaLogicaDatos
		WHERE TablaLogicaDatosID = 6801 AND TablaLogicaID = 68;

		SET @TipoDistribucion = CAST(@CodigoTipoDistribucion AS SMALLINT);

		IF @MensajeResultado <> ''
		BEGIN
			INSERT INTO SolicitudClienteLog(SolicitudClienteID, FechaEjecucion, Descripcion, ConsultoraID, CodigoUbigeo, NombreCompleto, Email, Telefono,
				Mensaje, Campania, UnidadGeografica1, UnidadGeografica2, UnidadGeografica3, TipoDistribucion, MarcaID, SolicitudClienteOrigen, Direccion, 
				FlagConsultora, FlagMedio, CodigoDispositivo, SODispositivo)
			VALUES (NULL, GETDATE(), @MensajeResultado, @ConsultoraID, @CodigoUbigeo, @NombreCompleto, @Email, @Telefono,
				@Mensaje, @Campania, @UnidGeo1, @UnidGeo2, @UnidGeo3, @TipoDistribucion, 0, 0, @Direccion, 
				@FlagConsultora, @FlagMedio, @CodigoDispositivo, @SODispositivo)
			SET @SolicitudClienteLogID = SCOPE_IDENTITY();
		END
		ELSE
		BEGIN
			INSERT INTO SolicitudCliente(ConsultoraID, CodigoUbigeo, NombreCompleto, Email, Telefono, Mensaje, Campania, MarcaID, FechaSolicitud, Leido, NumIteracion,UnidadGeografica1, UnidadGeografica2, UnidadGeografica3, TipoDistribucion, SolicitudClienteOrigen,
 Direccion, FlagConsultora, FlagMedio, CodigoDispositivo, SODispositivo, TipoUsuario, UsuarioAppID, IDCDC, IDCMC)
			VALUES (@ConsultoraID, @CodigoUbigeo, @NombreCompleto, @Email, @Telefono, @Mensaje, @Campania, 0, GETDATE(), 0, @NumIteracion, @UnidGeo1, @UnidGeo2, @UnidGeo3, @TipoDistribucion,isnull(@SolicitudClienteOrigen,0),@Direccion, @FlagConsultora, @FlagMedio,
 @CodigoDispositivo, @SODispositivo, @TipoUsuario, @UsuarioAppID, @IDCDC, @IDCMC)

			SET @SolicitudClienteID = SCOPE_IDENTITY();
			SET @MensajeResultado = 'Acción ejecutada satisfactoriamente.';

			--********************************Buscar el cliente origen, Codigo: Cesar FLores**************************
			IF @SolicitudClienteOrigen is null
			BEGIN
				SET @SolicitudClienteOrigen = isnull(dbo.ObtenerSolicitudClienteOrigen(@SolicitudClienteID),0);
				IF @SolicitudClienteOrigen <> 0
				BEGIN
					UPDATE SolicitudCliente
					SET SolicitudClienteOrigen=@SolicitudClienteOrigen
					WHERE SolicitudClienteID=@SolicitudClienteID;
				END
			END
			--*********************************************************************************************************

			INSERT INTO SolicitudClienteLog(SolicitudClienteID, FechaEjecucion, Descripcion, ConsultoraID, CodigoUbigeo, NombreCompleto, Email, Telefono,
				Mensaje, Campania, UnidadGeografica1, UnidadGeografica2, UnidadGeografica3, TipoDistribucion, MarcaID, SolicitudClienteOrigen, Direccion, 
				FlagConsultora, FlagMedio, CodigoDispositivo, SODispositivo)
			VALUES (@SolicitudClienteID, GETDATE(), @MensajeResultado, @ConsultoraID, @CodigoUbigeo, @NombreCompleto, @Email, @Telefono,
				@Mensaje, @Campania, @UnidGeo1, @UnidGeo2, @UnidGeo3, @TipoDistribucion, 0, @SolicitudClienteOrigen, @Direccion, 
				@FlagConsultora, @FlagMedio, @CodigoDispositivo, @SODispositivo)
			SET @SolicitudClienteLogID = SCOPE_IDENTITY();
				
			DECLARE
				@Cantidad INT,
				@CUV VARCHAR(6),
				@MarcaID INT,
				@DescripcionProducto VARCHAR(100),
				@Precio DECIMAL(20,2),
				@Tono VARCHAR(250),
				@Url VARCHAR(500),
				@i INT,
				@total INT

			DECLARE @TempSolicitudClienteDetalle TABLE
			(
				ID INT IDENTITY(1, 1),
				Cantidad INT,
				CUV VARCHAR(6),
				MarcaID INT,
				DescripcionProducto VARCHAR(100),
				Precio DECIMAL(20,2),
				Tono VARCHAR(250),
				Url VARCHAR(500)
			)

			INSERT INTO @TempSolicitudClienteDetalle(Cantidad, CUV, MarcaID, DescripcionProducto, Precio, Tono, Url)
			SELECT Cantidad, CUV, MarcaID, DescripcionProducto, Precio, Tono, Url FROM @SolicitudDetalle

			SET @i = 1
			SET @total = (SELECT MAX(ID) FROM @TempSolicitudClienteDetalle)
			WHILE @i <= @total
			BEGIN
				SET @CUV = (SELECT CUV FROM @TempSolicitudClienteDetalle WHERE ID = @i)
				SET @DescripcionProducto = (SELECT DescripcionProducto FROM @TempSolicitudClienteDetalle WHERE ID = @i)
				SET @Cantidad = (SELECT Cantidad FROM @TempSolicitudClienteDetalle WHERE ID = @i)
				SET @Precio = (SELECT Precio FROM @TempSolicitudClienteDetalle WHERE ID = @i)
				SET @MarcaID = (SELECT MarcaID FROM @TempSolicitudClienteDetalle WHERE ID = @i)
				SET @Tono = (SELECT Tono FROM @TempSolicitudClienteDetalle WHERE ID = @i)
				SET @Url = (SELECT Url FROM @TempSolicitudClienteDetalle WHERE ID = @i)
				SET @MensajeResultadoDetalle = ''

				/*RE2603 - CS(GGI) - 22/05/2015 - se esta quitando la validación para el @cuv*/

				--VALIDACIONES: INICIO--
				IF @DescripcionProducto IS NULL OR LEN(@DescripcionProducto) = 0
					SET @MensajeResultadoDetalle = @MensajeResultadoDetalle + 'No se ha ingresado la descripción de producto.|'

				IF @Cantidad <= 0
					SET @MensajeResultadoDetalle = @MensajeResultadoDetalle + 'La cantidad ingresada debe ser mayor a cero.|'

				IF @Precio <= 0
					SET @MensajeResultadoDetalle = @MensajeResultadoDetalle + 'El precio ingresado debe ser mayor a cero.|'
					
				IF NOT EXISTS(SELECT 1 FROM ods.Marca WHERE MarcaID IN (@MarcaID))
					SET @MensajeResultado = @MensajeResultado + 'No existe la marca con ID: ' + @MarcaID + '.|'
				ELSE IF @MarcaID NOT IN (1, 2, 3)
					SET @MensajeResultado = @MensajeResultado + 'El registro de solicitud es solo para las marcas: LBel, Esika, Cyzone.|'
				--VALIDACIONES: FIN--

				IF @MensajeResultadoDetalle <> ''
				BEGIN
					SET @flagDetalle = 1
					INSERT INTO SolicitudClienteDetalleLog(SolicitudClienteLogID, FechaEjecucion, Descripcion, CUV, Producto, Cantidad, Precio, MarcaID, Tono, Url) 
					VALUES (@SolicitudClienteLogID, GETDATE(), @MensajeResultadoDetalle, @CUV, @DescripcionProducto, @Cantidad, @Precio, @MarcaID, @Tono, @Url);
				END
				ELSE
				BEGIN
					SET @MensajeResultadoDetalle = 'Acción ejecutada satisfactoriamente.';
					-- Insertar el log del detalle. CORRECTO
					INSERT INTO SolicitudClienteDetalle(SolicitudClienteID, CUV, Producto, Cantidad, Precio, MarcaID, FechaCreacion, Tono, Url)
					VALUES (@SolicitudClienteID, @CUV, @DescripcionProducto, @Cantidad, @Precio, @MarcaID, getDate(), @Tono, @Url);
					INSERT INTO SolicitudClienteDetalleLog(SolicitudClienteLogID, FechaEjecucion, Descripcion, CUV, Producto, Cantidad, Precio, MarcaID, Tono, Url)
					VALUES (@SolicitudClienteLogID, GETDATE(), @MensajeResultadoDetalle, @CUV, @DescripcionProducto, @Cantidad, @Precio, @MarcaID, @Tono, @Url);
				END

				SET @i = @i + 1;
			END
		END

		IF @flagDetalle = 1
		BEGIN
			SET @MensajeResultado = 'Hubo un error al intentar registrar el detalle de la solicitud.';
			DELETE FROM SolicitudClienteDetalle WHERE SolicitudClienteID = @SolicitudClienteID;
			DELETE FROM SolicitudCliente WHERE SolicitudClienteID = @SolicitudClienteID;

			UPDATE SolicitudClienteLog
			SET
				SolicitudClienteID = NULL,
				Descripcion = @MensajeResultado
			WHERE SolicitudClienteLogID = @SolicitudClienteLogID;

			SET @SolicitudClienteID = 0;
		END

		SELECT @SolicitudClienteID Resultado, @MensajeResultado Mensaje;
	END TRY
	BEGIN CATCH
		SET @MensajeResultado = CONCAT(ERROR_MESSAGE(),' ',ERROR_LINE());
		SELECT @SolicitudClienteID Resultado, @MensajeResultado Mensaje
		
		INSERT INTO SolicitudClienteLog(SolicitudClienteID, FechaEjecucion, Descripcion, ConsultoraID, CodigoUbigeo, NombreCompleto, Email, Telefono,
				Mensaje, Campania, UnidadGeografica1, UnidadGeografica2, UnidadGeografica3, TipoDistribucion, MarcaID, SolicitudClienteOrigen, Direccion, 
				FlagConsultora, FlagMedio, CodigoDispositivo, SODispositivo)
		VALUES (NULL, GETDATE(), @MensajeResultado, @ConsultoraID, @CodigoUbigeo, @NombreCompleto, @Email, @Telefono,
				@Mensaje, @Campania, @UnidGeo1, @UnidGeo2, @UnidGeo3, @TipoDistribucion, 0, 0, @Direccion, 
				@FlagConsultora, @FlagMedio, @CodigoDispositivo, @SODispositivo)
		SET @SolicitudClienteLogID = SCOPE_IDENTITY();
	END CATCH
END

GO
USE [BelcorpGuatemala];
GO
ALTER PROCEDURE [dbo].[RegistrarSolicitudClienteAppCatalogo]	
    @Campania VARCHAR(6),
	@CodigoConsultora VARCHAR(30),
	@CodigoUbigeo VARCHAR(40),
	@ConsultoraID BIGINT,
	@Direccion VARCHAR(800),
	@Email VARCHAR(110),
	@Mensaje VARCHAR(810),
	@NombreCompleto VARCHAR(110),
	@Telefono VARCHAR(110),
	@FlagConsultora BIT,
	@FlagMedio VARCHAR(10),
	@NumIteracion INT,
	@CodigoDispositivo VARCHAR(50) = '-',
	@SODispositivo VARCHAR(20) = '-',
	@TipoUsuario INT = 0,
	@UsuarioAppID BIGINT = 0,
	@SolicitudDetalle dbo.SolicitudDetalleAppCatalogoType READONLY,
	@SolicitudClienteOrigen BIGINT = null,
	@IDCDC VARCHAR(100) = NULL,
	@IDCMC VARCHAR(200) = NULL
AS
BEGIN
	DECLARE
		@SolicitudClienteID BIGINT,
		@MensajeResultado VARCHAR(500),
		@SolicitudClienteLogID BIGINT,
		@MensajeResultadoDetalle VARCHAR(500),
		@flagDetalle BIT,
		@TerritorioID INT

	SET @SolicitudClienteID = 0
	SET @SolicitudClienteLogID = 0
	SET @flagDetalle = 0
	SET @TerritorioID = (SELECT TerritorioID FROM ods.Consultora where ConsultoraID=@ConsultoraID)

	BEGIN TRY
		SET @MensajeResultado = ''

		--VALIDACIONES: INICIO--
		IF @CodigoConsultora IS NULL
			SET @MensajeResultado = @MensajeResultado + 'El código de consultora no fue ingresado.|'
		ELSE IF LEN(@CodigoConsultora) > 20
			SET @MensajeResultado = @MensajeResultado + 'El código de consultora no debe exceder los 20 caracteres.|'
		ELSE IF NOT EXISTS(SELECT 1 FROM ods.Consultora WHERE RTRIM(Codigo) = RTRIM(@CodigoConsultora))
			SET @MensajeResultado = @MensajeResultado + 'No existe el Código de Consultora.|'

		IF @ConsultoraID IS NULL OR @ConsultoraID = 0
			SET @MensajeResultado = @MensajeResultado + 'El ID de consultora no fue ingresado.|'
		ELSE IF NOT EXISTS(SELECT 1 FROM ods.Consultora WHERE ConsultoraID = @ConsultoraID)
			SET @MensajeResultado = @MensajeResultado + 'No existe el ID de la consultora.|'
		ELSE IF RTRIM(@CodigoConsultora) <> (SELECT RTRIM(Codigo) FROM ods.Consultora where ConsultoraID=@ConsultoraID)
			SET @MensajeResultado = @MensajeResultado + 'El Id de Consultora no está asociado con el Código Consultora.|'

		IF @CodigoUbigeo IS NULL
			SET @MensajeResultado = @MensajeResultado + 'El código ubigeo no fue ingresado.|'
		ELSE IF NOT EXISTS(SELECT 1 FROM dbo.Ubigeo WHERE CodigoUbigeo = @CodigoUbigeo)
		BEGIN
			IF NOT EXISTS(SELECT 1 FROM ods.Ubigeo WHERE CodigoUbigeo = @CodigoUbigeo)
			    SET @MensajeResultado = @MensajeResultado + 'No existe el código ubigeo.|'
		END

		IF @NombreCompleto IS NULL
			SET @MensajeResultado = @MensajeResultado + 'El nombre completo de la cliente no fue ingresado.|'
		ELSE IF LEN(@NombreCompleto) > 100
			SET @MensajeResultado = @MensajeResultado + 'El nombre completo de la cliente no debe exceder los 100 caracteres.|'

		IF @Email IS NULL
			SET @MensajeResultado = @MensajeResultado + 'El email de la cliente no fue ingresado.|'
		ELSE IF LEN(@Email) > 100
			SET @MensajeResultado = @MensajeResultado + 'El email de la cliente no debe exceder los 100 caracteres.|'

		IF @Telefono IS NULL
			SET @MensajeResultado = @MensajeResultado + 'El teléfono de la cliente no fue ingresado.|'
		ELSE IF LEN(@Telefono) > 100
			SET @MensajeResultado = @MensajeResultado + 'El teléfono de la cliente no debe exceder los 100 caracteres.|'

		IF @Mensaje IS NULL
			SET @MensajeResultado = @MensajeResultado + 'El mensaje de la cliente no fue ingresado.|'
		ELSE IF LEN(@Mensaje) > 800
			SET @MensajeResultado = @MensajeResultado + 'El mensaje no debe exceder los 800 caracteres.|'

		IF @Campania IS NULL
			SET @MensajeResultado = @MensajeResultado + 'La campaña no fue ingresada.|'
		ELSE IF LEN(@Campania) > 6
			SET @MensajeResultado = @MensajeResultado + 'El código de campaña no debe exceder los 6 caracteres.|'
		ELSE IF NOT EXISTS(SELECT Codigo FROM ods.Campania WHERE Codigo IN (@Campania))
			SET @MensajeResultado = @MensajeResultado + 'No existe la campaña ' + @Campania + '.|'

		IF @FlagMedio IS NULL OR LEN (@FlagMedio) = 0
			SET @MensajeResultado = @MensajeResultado + 'El flag medio no fue ingresado.|'
		ELSE IF NOT EXISTS(SELECT 1 FROM TablaLogicaDatos WHERE TablaLogicaID = 85 AND Codigo = @FlagMedio)
			SET @MensajeResultado = @MensajeResultado + 'El flag medio ''' + @FlagMedio + ''' no es válido.|'
		
		IF @CodigoDispositivo IS NULL
			SET @MensajeResultado = @MensajeResultado + 'El código del dispositivo no fue ingresado.|'
		ELSE IF LEN(@CodigoDispositivo) > 50
			SET @MensajeResultado = @MensajeResultado + 'El código del dispositivo no debe exceder los 50 caracteres.|'

		IF @SODispositivo IS NULL
			SET @MensajeResultado = @MensajeResultado + 'El so del dispositivo no fue ingresado.|'
		ELSE IF LEN(@SODispositivo) > 20
			SET @MensajeResultado = @MensajeResultado + 'El so del dispositivo no debe exceder los 100 caracteres.|'

		--VALIDACIONES: FIN--
		---------------------

		DECLARE
			@UnidGeo1 VARCHAR(100),
			@UnidGeo2 VARCHAR(100),
			@UnidGeo3 VARCHAR(100),
			@TipoDistribucion SMALLINT,
			@CodigoTipoDistribucion VARCHAR(10);

		SELECT TOP 1
			@UnidGeo1 = UnidadGeografica1,
			@UnidGeo2 = UnidadGeografica2,
			@UnidGeo3 = UnidadGeografica3
		FROM dbo.Ubigeo
		WHERE CodigoUbigeo = @CodigoUbigeo

		SELECT @CodigoTipoDistribucion = Codigo
		FROM TablaLogicaDatos
		WHERE TablaLogicaDatosID = 6801 AND TablaLogicaID = 68;

		SET @TipoDistribucion = CAST(@CodigoTipoDistribucion AS SMALLINT);

		IF @MensajeResultado <> ''
		BEGIN
			INSERT INTO SolicitudClienteLog(SolicitudClienteID, FechaEjecucion, Descripcion, ConsultoraID, CodigoUbigeo, NombreCompleto, Email, Telefono,
				Mensaje, Campania, UnidadGeografica1, UnidadGeografica2, UnidadGeografica3, TipoDistribucion, MarcaID, SolicitudClienteOrigen, Direccion, 
				FlagConsultora, FlagMedio, CodigoDispositivo, SODispositivo)
			VALUES (NULL, GETDATE(), @MensajeResultado, @ConsultoraID, @CodigoUbigeo, @NombreCompleto, @Email, @Telefono,
				@Mensaje, @Campania, @UnidGeo1, @UnidGeo2, @UnidGeo3, @TipoDistribucion, 0, 0, @Direccion, 
				@FlagConsultora, @FlagMedio, @CodigoDispositivo, @SODispositivo)
			SET @SolicitudClienteLogID = SCOPE_IDENTITY();
		END
		ELSE
		BEGIN
			INSERT INTO SolicitudCliente(ConsultoraID, CodigoUbigeo, NombreCompleto, Email, Telefono, Mensaje, Campania, MarcaID, FechaSolicitud, Leido, NumIteracion,UnidadGeografica1, UnidadGeografica2, UnidadGeografica3, TipoDistribucion, SolicitudClienteOrigen,
 Direccion, FlagConsultora, FlagMedio, CodigoDispositivo, SODispositivo, TipoUsuario, UsuarioAppID, IDCDC, IDCMC)
			VALUES (@ConsultoraID, @CodigoUbigeo, @NombreCompleto, @Email, @Telefono, @Mensaje, @Campania, 0, GETDATE(), 0, @NumIteracion, @UnidGeo1, @UnidGeo2, @UnidGeo3, @TipoDistribucion,isnull(@SolicitudClienteOrigen,0),@Direccion, @FlagConsultora, @FlagMedio,
 @CodigoDispositivo, @SODispositivo, @TipoUsuario, @UsuarioAppID, @IDCDC, @IDCMC)

			SET @SolicitudClienteID = SCOPE_IDENTITY();
			SET @MensajeResultado = 'Acción ejecutada satisfactoriamente.';

			--********************************Buscar el cliente origen, Codigo: Cesar FLores**************************
			IF @SolicitudClienteOrigen is null
			BEGIN
				SET @SolicitudClienteOrigen = isnull(dbo.ObtenerSolicitudClienteOrigen(@SolicitudClienteID),0);
				IF @SolicitudClienteOrigen <> 0
				BEGIN
					UPDATE SolicitudCliente
					SET SolicitudClienteOrigen=@SolicitudClienteOrigen
					WHERE SolicitudClienteID=@SolicitudClienteID;
				END
			END
			--*********************************************************************************************************

			INSERT INTO SolicitudClienteLog(SolicitudClienteID, FechaEjecucion, Descripcion, ConsultoraID, CodigoUbigeo, NombreCompleto, Email, Telefono,
				Mensaje, Campania, UnidadGeografica1, UnidadGeografica2, UnidadGeografica3, TipoDistribucion, MarcaID, SolicitudClienteOrigen, Direccion, 
				FlagConsultora, FlagMedio, CodigoDispositivo, SODispositivo)
			VALUES (@SolicitudClienteID, GETDATE(), @MensajeResultado, @ConsultoraID, @CodigoUbigeo, @NombreCompleto, @Email, @Telefono,
				@Mensaje, @Campania, @UnidGeo1, @UnidGeo2, @UnidGeo3, @TipoDistribucion, 0, @SolicitudClienteOrigen, @Direccion, 
				@FlagConsultora, @FlagMedio, @CodigoDispositivo, @SODispositivo)
			SET @SolicitudClienteLogID = SCOPE_IDENTITY();
				
			DECLARE
				@Cantidad INT,
				@CUV VARCHAR(6),
				@MarcaID INT,
				@DescripcionProducto VARCHAR(100),
				@Precio DECIMAL(20,2),
				@Tono VARCHAR(250),
				@Url VARCHAR(500),
				@i INT,
				@total INT

			DECLARE @TempSolicitudClienteDetalle TABLE
			(
				ID INT IDENTITY(1, 1),
				Cantidad INT,
				CUV VARCHAR(6),
				MarcaID INT,
				DescripcionProducto VARCHAR(100),
				Precio DECIMAL(20,2),
				Tono VARCHAR(250),
				Url VARCHAR(500)
			)

			INSERT INTO @TempSolicitudClienteDetalle(Cantidad, CUV, MarcaID, DescripcionProducto, Precio, Tono, Url)
			SELECT Cantidad, CUV, MarcaID, DescripcionProducto, Precio, Tono, Url FROM @SolicitudDetalle

			SET @i = 1
			SET @total = (SELECT MAX(ID) FROM @TempSolicitudClienteDetalle)
			WHILE @i <= @total
			BEGIN
				SET @CUV = (SELECT CUV FROM @TempSolicitudClienteDetalle WHERE ID = @i)
				SET @DescripcionProducto = (SELECT DescripcionProducto FROM @TempSolicitudClienteDetalle WHERE ID = @i)
				SET @Cantidad = (SELECT Cantidad FROM @TempSolicitudClienteDetalle WHERE ID = @i)
				SET @Precio = (SELECT Precio FROM @TempSolicitudClienteDetalle WHERE ID = @i)
				SET @MarcaID = (SELECT MarcaID FROM @TempSolicitudClienteDetalle WHERE ID = @i)
				SET @Tono = (SELECT Tono FROM @TempSolicitudClienteDetalle WHERE ID = @i)
				SET @Url = (SELECT Url FROM @TempSolicitudClienteDetalle WHERE ID = @i)
				SET @MensajeResultadoDetalle = ''

				/*RE2603 - CS(GGI) - 22/05/2015 - se esta quitando la validación para el @cuv*/

				--VALIDACIONES: INICIO--
				IF @DescripcionProducto IS NULL OR LEN(@DescripcionProducto) = 0
					SET @MensajeResultadoDetalle = @MensajeResultadoDetalle + 'No se ha ingresado la descripción de producto.|'

				IF @Cantidad <= 0
					SET @MensajeResultadoDetalle = @MensajeResultadoDetalle + 'La cantidad ingresada debe ser mayor a cero.|'

				IF @Precio <= 0
					SET @MensajeResultadoDetalle = @MensajeResultadoDetalle + 'El precio ingresado debe ser mayor a cero.|'
					
				IF NOT EXISTS(SELECT 1 FROM ods.Marca WHERE MarcaID IN (@MarcaID))
					SET @MensajeResultado = @MensajeResultado + 'No existe la marca con ID: ' + @MarcaID + '.|'
				ELSE IF @MarcaID NOT IN (1, 2, 3)
					SET @MensajeResultado = @MensajeResultado + 'El registro de solicitud es solo para las marcas: LBel, Esika, Cyzone.|'
				--VALIDACIONES: FIN--

				IF @MensajeResultadoDetalle <> ''
				BEGIN
					SET @flagDetalle = 1
					INSERT INTO SolicitudClienteDetalleLog(SolicitudClienteLogID, FechaEjecucion, Descripcion, CUV, Producto, Cantidad, Precio, MarcaID, Tono, Url) 
					VALUES (@SolicitudClienteLogID, GETDATE(), @MensajeResultadoDetalle, @CUV, @DescripcionProducto, @Cantidad, @Precio, @MarcaID, @Tono, @Url);
				END
				ELSE
				BEGIN
					SET @MensajeResultadoDetalle = 'Acción ejecutada satisfactoriamente.';
					-- Insertar el log del detalle. CORRECTO
					INSERT INTO SolicitudClienteDetalle(SolicitudClienteID, CUV, Producto, Cantidad, Precio, MarcaID, FechaCreacion, Tono, Url)
					VALUES (@SolicitudClienteID, @CUV, @DescripcionProducto, @Cantidad, @Precio, @MarcaID, getDate(), @Tono, @Url);
					INSERT INTO SolicitudClienteDetalleLog(SolicitudClienteLogID, FechaEjecucion, Descripcion, CUV, Producto, Cantidad, Precio, MarcaID, Tono, Url)
					VALUES (@SolicitudClienteLogID, GETDATE(), @MensajeResultadoDetalle, @CUV, @DescripcionProducto, @Cantidad, @Precio, @MarcaID, @Tono, @Url);
				END

				SET @i = @i + 1;
			END
		END

		IF @flagDetalle = 1
		BEGIN
			SET @MensajeResultado = 'Hubo un error al intentar registrar el detalle de la solicitud.';
			DELETE FROM SolicitudClienteDetalle WHERE SolicitudClienteID = @SolicitudClienteID;
			DELETE FROM SolicitudCliente WHERE SolicitudClienteID = @SolicitudClienteID;

			UPDATE SolicitudClienteLog
			SET
				SolicitudClienteID = NULL,
				Descripcion = @MensajeResultado
			WHERE SolicitudClienteLogID = @SolicitudClienteLogID;

			SET @SolicitudClienteID = 0;
		END

		SELECT @SolicitudClienteID Resultado, @MensajeResultado Mensaje;
	END TRY
	BEGIN CATCH
		SET @MensajeResultado = CONCAT(ERROR_MESSAGE(),' ',ERROR_LINE());
		SELECT @SolicitudClienteID Resultado, @MensajeResultado Mensaje
		
		INSERT INTO SolicitudClienteLog(SolicitudClienteID, FechaEjecucion, Descripcion, ConsultoraID, CodigoUbigeo, NombreCompleto, Email, Telefono,
				Mensaje, Campania, UnidadGeografica1, UnidadGeografica2, UnidadGeografica3, TipoDistribucion, MarcaID, SolicitudClienteOrigen, Direccion, 
				FlagConsultora, FlagMedio, CodigoDispositivo, SODispositivo)
		VALUES (NULL, GETDATE(), @MensajeResultado, @ConsultoraID, @CodigoUbigeo, @NombreCompleto, @Email, @Telefono,
				@Mensaje, @Campania, @UnidGeo1, @UnidGeo2, @UnidGeo3, @TipoDistribucion, 0, 0, @Direccion, 
				@FlagConsultora, @FlagMedio, @CodigoDispositivo, @SODispositivo)
		SET @SolicitudClienteLogID = SCOPE_IDENTITY();
	END CATCH
END

GO
USE [BelcorpMexico];
GO
ALTER PROCEDURE [dbo].[RegistrarSolicitudClienteAppCatalogo]	
    @Campania VARCHAR(6),
	@CodigoConsultora VARCHAR(30),
	@CodigoUbigeo VARCHAR(40),
	@ConsultoraID BIGINT,
	@Direccion VARCHAR(800),
	@Email VARCHAR(110),
	@Mensaje VARCHAR(810),
	@NombreCompleto VARCHAR(110),
	@Telefono VARCHAR(110),
	@FlagConsultora BIT,
	@FlagMedio VARCHAR(10),
	@NumIteracion INT,
	@CodigoDispositivo VARCHAR(50) = '-',
	@SODispositivo VARCHAR(20) = '-',
	@TipoUsuario INT = 0,
	@UsuarioAppID BIGINT = 0,
	@SolicitudDetalle dbo.SolicitudDetalleAppCatalogoType READONLY,
	@SolicitudClienteOrigen BIGINT = null,
	@IDCDC VARCHAR(100) = NULL,
	@IDCMC VARCHAR(200) = NULL
AS
BEGIN
	DECLARE
		@SolicitudClienteID BIGINT,
		@MensajeResultado VARCHAR(500),
		@SolicitudClienteLogID BIGINT,
		@MensajeResultadoDetalle VARCHAR(500),
		@flagDetalle BIT,
		@TerritorioID INT

	SET @SolicitudClienteID = 0
	SET @SolicitudClienteLogID = 0
	SET @flagDetalle = 0
	SET @TerritorioID = (SELECT TerritorioID FROM ods.Consultora where ConsultoraID=@ConsultoraID)

	BEGIN TRY
		SET @MensajeResultado = ''

		--VALIDACIONES: INICIO--
		IF @CodigoConsultora IS NULL
			SET @MensajeResultado = @MensajeResultado + 'El código de consultora no fue ingresado.|'
		ELSE IF LEN(@CodigoConsultora) > 20
			SET @MensajeResultado = @MensajeResultado + 'El código de consultora no debe exceder los 20 caracteres.|'
		ELSE IF NOT EXISTS(SELECT 1 FROM ods.Consultora WHERE RTRIM(Codigo) = RTRIM(@CodigoConsultora))
			SET @MensajeResultado = @MensajeResultado + 'No existe el Código de Consultora.|'

		IF @ConsultoraID IS NULL OR @ConsultoraID = 0
			SET @MensajeResultado = @MensajeResultado + 'El ID de consultora no fue ingresado.|'
		ELSE IF NOT EXISTS(SELECT 1 FROM ods.Consultora WHERE ConsultoraID = @ConsultoraID)
			SET @MensajeResultado = @MensajeResultado + 'No existe el ID de la consultora.|'
		ELSE IF RTRIM(@CodigoConsultora) <> (SELECT RTRIM(Codigo) FROM ods.Consultora where ConsultoraID=@ConsultoraID)
			SET @MensajeResultado = @MensajeResultado + 'El Id de Consultora no está asociado con el Código Consultora.|'

		IF @CodigoUbigeo IS NULL
			SET @MensajeResultado = @MensajeResultado + 'El código ubigeo no fue ingresado.|'
		ELSE IF NOT EXISTS(SELECT 1 FROM dbo.Ubigeo WHERE CodigoUbigeo = @CodigoUbigeo)
		BEGIN
			IF NOT EXISTS(SELECT 1 FROM ods.Ubigeo WHERE CodigoUbigeo = @CodigoUbigeo)
			    SET @MensajeResultado = @MensajeResultado + 'No existe el código ubigeo.|'
		END

		IF @NombreCompleto IS NULL
			SET @MensajeResultado = @MensajeResultado + 'El nombre completo de la cliente no fue ingresado.|'
		ELSE IF LEN(@NombreCompleto) > 100
			SET @MensajeResultado = @MensajeResultado + 'El nombre completo de la cliente no debe exceder los 100 caracteres.|'

		IF @Email IS NULL
			SET @MensajeResultado = @MensajeResultado + 'El email de la cliente no fue ingresado.|'
		ELSE IF LEN(@Email) > 100
			SET @MensajeResultado = @MensajeResultado + 'El email de la cliente no debe exceder los 100 caracteres.|'

		IF @Telefono IS NULL
			SET @MensajeResultado = @MensajeResultado + 'El teléfono de la cliente no fue ingresado.|'
		ELSE IF LEN(@Telefono) > 100
			SET @MensajeResultado = @MensajeResultado + 'El teléfono de la cliente no debe exceder los 100 caracteres.|'

		IF @Mensaje IS NULL
			SET @MensajeResultado = @MensajeResultado + 'El mensaje de la cliente no fue ingresado.|'
		ELSE IF LEN(@Mensaje) > 800
			SET @MensajeResultado = @MensajeResultado + 'El mensaje no debe exceder los 800 caracteres.|'

		IF @Campania IS NULL
			SET @MensajeResultado = @MensajeResultado + 'La campaña no fue ingresada.|'
		ELSE IF LEN(@Campania) > 6
			SET @MensajeResultado = @MensajeResultado + 'El código de campaña no debe exceder los 6 caracteres.|'
		ELSE IF NOT EXISTS(SELECT Codigo FROM ods.Campania WHERE Codigo IN (@Campania))
			SET @MensajeResultado = @MensajeResultado + 'No existe la campaña ' + @Campania + '.|'

		IF @FlagMedio IS NULL OR LEN (@FlagMedio) = 0
			SET @MensajeResultado = @MensajeResultado + 'El flag medio no fue ingresado.|'
		ELSE IF NOT EXISTS(SELECT 1 FROM TablaLogicaDatos WHERE TablaLogicaID = 85 AND Codigo = @FlagMedio)
			SET @MensajeResultado = @MensajeResultado + 'El flag medio ''' + @FlagMedio + ''' no es válido.|'
		
		IF @CodigoDispositivo IS NULL
			SET @MensajeResultado = @MensajeResultado + 'El código del dispositivo no fue ingresado.|'
		ELSE IF LEN(@CodigoDispositivo) > 50
			SET @MensajeResultado = @MensajeResultado + 'El código del dispositivo no debe exceder los 50 caracteres.|'

		IF @SODispositivo IS NULL
			SET @MensajeResultado = @MensajeResultado + 'El so del dispositivo no fue ingresado.|'
		ELSE IF LEN(@SODispositivo) > 20
			SET @MensajeResultado = @MensajeResultado + 'El so del dispositivo no debe exceder los 100 caracteres.|'

		--VALIDACIONES: FIN--
		---------------------

		DECLARE
			@UnidGeo1 VARCHAR(100),
			@UnidGeo2 VARCHAR(100),
			@UnidGeo3 VARCHAR(100),
			@TipoDistribucion SMALLINT,
			@CodigoTipoDistribucion VARCHAR(10);

		SELECT TOP 1
			@UnidGeo1 = UnidadGeografica1,
			@UnidGeo2 = UnidadGeografica2,
			@UnidGeo3 = UnidadGeografica3
		FROM dbo.Ubigeo
		WHERE CodigoUbigeo = @CodigoUbigeo

		SELECT @CodigoTipoDistribucion = Codigo
		FROM TablaLogicaDatos
		WHERE TablaLogicaDatosID = 6801 AND TablaLogicaID = 68;

		SET @TipoDistribucion = CAST(@CodigoTipoDistribucion AS SMALLINT);

		IF @MensajeResultado <> ''
		BEGIN
			INSERT INTO SolicitudClienteLog(SolicitudClienteID, FechaEjecucion, Descripcion, ConsultoraID, CodigoUbigeo, NombreCompleto, Email, Telefono,
				Mensaje, Campania, UnidadGeografica1, UnidadGeografica2, UnidadGeografica3, TipoDistribucion, MarcaID, SolicitudClienteOrigen, Direccion, 
				FlagConsultora, FlagMedio, CodigoDispositivo, SODispositivo)
			VALUES (NULL, GETDATE(), @MensajeResultado, @ConsultoraID, @CodigoUbigeo, @NombreCompleto, @Email, @Telefono,
				@Mensaje, @Campania, @UnidGeo1, @UnidGeo2, @UnidGeo3, @TipoDistribucion, 0, 0, @Direccion, 
				@FlagConsultora, @FlagMedio, @CodigoDispositivo, @SODispositivo)
			SET @SolicitudClienteLogID = SCOPE_IDENTITY();
		END
		ELSE
		BEGIN
			INSERT INTO SolicitudCliente(ConsultoraID, CodigoUbigeo, NombreCompleto, Email, Telefono, Mensaje, Campania, MarcaID, FechaSolicitud, Leido, NumIteracion,UnidadGeografica1, UnidadGeografica2, UnidadGeografica3, TipoDistribucion, SolicitudClienteOrigen,
 Direccion, FlagConsultora, FlagMedio, CodigoDispositivo, SODispositivo, TipoUsuario, UsuarioAppID, IDCDC, IDCMC)
			VALUES (@ConsultoraID, @CodigoUbigeo, @NombreCompleto, @Email, @Telefono, @Mensaje, @Campania, 0, GETDATE(), 0, @NumIteracion, @UnidGeo1, @UnidGeo2, @UnidGeo3, @TipoDistribucion,isnull(@SolicitudClienteOrigen,0),@Direccion, @FlagConsultora, @FlagMedio,
 @CodigoDispositivo, @SODispositivo, @TipoUsuario, @UsuarioAppID, @IDCDC, @IDCMC)

			SET @SolicitudClienteID = SCOPE_IDENTITY();
			SET @MensajeResultado = 'Acción ejecutada satisfactoriamente.';

			--********************************Buscar el cliente origen, Codigo: Cesar FLores**************************
			IF @SolicitudClienteOrigen is null
			BEGIN
				SET @SolicitudClienteOrigen = isnull(dbo.ObtenerSolicitudClienteOrigen(@SolicitudClienteID),0);
				IF @SolicitudClienteOrigen <> 0
				BEGIN
					UPDATE SolicitudCliente
					SET SolicitudClienteOrigen=@SolicitudClienteOrigen
					WHERE SolicitudClienteID=@SolicitudClienteID;
				END
			END
			--*********************************************************************************************************

			INSERT INTO SolicitudClienteLog(SolicitudClienteID, FechaEjecucion, Descripcion, ConsultoraID, CodigoUbigeo, NombreCompleto, Email, Telefono,
				Mensaje, Campania, UnidadGeografica1, UnidadGeografica2, UnidadGeografica3, TipoDistribucion, MarcaID, SolicitudClienteOrigen, Direccion, 
				FlagConsultora, FlagMedio, CodigoDispositivo, SODispositivo)
			VALUES (@SolicitudClienteID, GETDATE(), @MensajeResultado, @ConsultoraID, @CodigoUbigeo, @NombreCompleto, @Email, @Telefono,
				@Mensaje, @Campania, @UnidGeo1, @UnidGeo2, @UnidGeo3, @TipoDistribucion, 0, @SolicitudClienteOrigen, @Direccion, 
				@FlagConsultora, @FlagMedio, @CodigoDispositivo, @SODispositivo)
			SET @SolicitudClienteLogID = SCOPE_IDENTITY();
				
			DECLARE
				@Cantidad INT,
				@CUV VARCHAR(6),
				@MarcaID INT,
				@DescripcionProducto VARCHAR(100),
				@Precio DECIMAL(20,2),
				@Tono VARCHAR(250),
				@Url VARCHAR(500),
				@i INT,
				@total INT

			DECLARE @TempSolicitudClienteDetalle TABLE
			(
				ID INT IDENTITY(1, 1),
				Cantidad INT,
				CUV VARCHAR(6),
				MarcaID INT,
				DescripcionProducto VARCHAR(100),
				Precio DECIMAL(20,2),
				Tono VARCHAR(250),
				Url VARCHAR(500)
			)

			INSERT INTO @TempSolicitudClienteDetalle(Cantidad, CUV, MarcaID, DescripcionProducto, Precio, Tono, Url)
			SELECT Cantidad, CUV, MarcaID, DescripcionProducto, Precio, Tono, Url FROM @SolicitudDetalle

			SET @i = 1
			SET @total = (SELECT MAX(ID) FROM @TempSolicitudClienteDetalle)
			WHILE @i <= @total
			BEGIN
				SET @CUV = (SELECT CUV FROM @TempSolicitudClienteDetalle WHERE ID = @i)
				SET @DescripcionProducto = (SELECT DescripcionProducto FROM @TempSolicitudClienteDetalle WHERE ID = @i)
				SET @Cantidad = (SELECT Cantidad FROM @TempSolicitudClienteDetalle WHERE ID = @i)
				SET @Precio = (SELECT Precio FROM @TempSolicitudClienteDetalle WHERE ID = @i)
				SET @MarcaID = (SELECT MarcaID FROM @TempSolicitudClienteDetalle WHERE ID = @i)
				SET @Tono = (SELECT Tono FROM @TempSolicitudClienteDetalle WHERE ID = @i)
				SET @Url = (SELECT Url FROM @TempSolicitudClienteDetalle WHERE ID = @i)
				SET @MensajeResultadoDetalle = ''

				/*RE2603 - CS(GGI) - 22/05/2015 - se esta quitando la validación para el @cuv*/

				--VALIDACIONES: INICIO--
				IF @DescripcionProducto IS NULL OR LEN(@DescripcionProducto) = 0
					SET @MensajeResultadoDetalle = @MensajeResultadoDetalle + 'No se ha ingresado la descripción de producto.|'

				IF @Cantidad <= 0
					SET @MensajeResultadoDetalle = @MensajeResultadoDetalle + 'La cantidad ingresada debe ser mayor a cero.|'

				IF @Precio <= 0
					SET @MensajeResultadoDetalle = @MensajeResultadoDetalle + 'El precio ingresado debe ser mayor a cero.|'
					
				IF NOT EXISTS(SELECT 1 FROM ods.Marca WHERE MarcaID IN (@MarcaID))
					SET @MensajeResultado = @MensajeResultado + 'No existe la marca con ID: ' + @MarcaID + '.|'
				ELSE IF @MarcaID NOT IN (1, 2, 3)
					SET @MensajeResultado = @MensajeResultado + 'El registro de solicitud es solo para las marcas: LBel, Esika, Cyzone.|'
				--VALIDACIONES: FIN--

				IF @MensajeResultadoDetalle <> ''
				BEGIN
					SET @flagDetalle = 1
					INSERT INTO SolicitudClienteDetalleLog(SolicitudClienteLogID, FechaEjecucion, Descripcion, CUV, Producto, Cantidad, Precio, MarcaID, Tono, Url) 
					VALUES (@SolicitudClienteLogID, GETDATE(), @MensajeResultadoDetalle, @CUV, @DescripcionProducto, @Cantidad, @Precio, @MarcaID, @Tono, @Url);
				END
				ELSE
				BEGIN
					SET @MensajeResultadoDetalle = 'Acción ejecutada satisfactoriamente.';
					-- Insertar el log del detalle. CORRECTO
					INSERT INTO SolicitudClienteDetalle(SolicitudClienteID, CUV, Producto, Cantidad, Precio, MarcaID, FechaCreacion, Tono, Url)
					VALUES (@SolicitudClienteID, @CUV, @DescripcionProducto, @Cantidad, @Precio, @MarcaID, getDate(), @Tono, @Url);
					INSERT INTO SolicitudClienteDetalleLog(SolicitudClienteLogID, FechaEjecucion, Descripcion, CUV, Producto, Cantidad, Precio, MarcaID, Tono, Url)
					VALUES (@SolicitudClienteLogID, GETDATE(), @MensajeResultadoDetalle, @CUV, @DescripcionProducto, @Cantidad, @Precio, @MarcaID, @Tono, @Url);
				END

				SET @i = @i + 1;
			END
		END

		IF @flagDetalle = 1
		BEGIN
			SET @MensajeResultado = 'Hubo un error al intentar registrar el detalle de la solicitud.';
			DELETE FROM SolicitudClienteDetalle WHERE SolicitudClienteID = @SolicitudClienteID;
			DELETE FROM SolicitudCliente WHERE SolicitudClienteID = @SolicitudClienteID;

			UPDATE SolicitudClienteLog
			SET
				SolicitudClienteID = NULL,
				Descripcion = @MensajeResultado
			WHERE SolicitudClienteLogID = @SolicitudClienteLogID;

			SET @SolicitudClienteID = 0;
		END

		SELECT @SolicitudClienteID Resultado, @MensajeResultado Mensaje;
	END TRY
	BEGIN CATCH
		SET @MensajeResultado = CONCAT(ERROR_MESSAGE(),' ',ERROR_LINE());
		SELECT @SolicitudClienteID Resultado, @MensajeResultado Mensaje
		
		INSERT INTO SolicitudClienteLog(SolicitudClienteID, FechaEjecucion, Descripcion, ConsultoraID, CodigoUbigeo, NombreCompleto, Email, Telefono,
				Mensaje, Campania, UnidadGeografica1, UnidadGeografica2, UnidadGeografica3, TipoDistribucion, MarcaID, SolicitudClienteOrigen, Direccion, 
				FlagConsultora, FlagMedio, CodigoDispositivo, SODispositivo)
		VALUES (NULL, GETDATE(), @MensajeResultado, @ConsultoraID, @CodigoUbigeo, @NombreCompleto, @Email, @Telefono,
				@Mensaje, @Campania, @UnidGeo1, @UnidGeo2, @UnidGeo3, @TipoDistribucion, 0, 0, @Direccion, 
				@FlagConsultora, @FlagMedio, @CodigoDispositivo, @SODispositivo)
		SET @SolicitudClienteLogID = SCOPE_IDENTITY();
	END CATCH
END

GO
USE [BelcorpPanama];
GO
ALTER PROCEDURE [dbo].[RegistrarSolicitudClienteAppCatalogo]	
    @Campania VARCHAR(6),
	@CodigoConsultora VARCHAR(30),
	@CodigoUbigeo VARCHAR(40),
	@ConsultoraID BIGINT,
	@Direccion VARCHAR(800),
	@Email VARCHAR(110),
	@Mensaje VARCHAR(810),
	@NombreCompleto VARCHAR(110),
	@Telefono VARCHAR(110),
	@FlagConsultora BIT,
	@FlagMedio VARCHAR(10),
	@NumIteracion INT,
	@CodigoDispositivo VARCHAR(50) = '-',
	@SODispositivo VARCHAR(20) = '-',
	@TipoUsuario INT = 0,
	@UsuarioAppID BIGINT = 0,
	@SolicitudDetalle dbo.SolicitudDetalleAppCatalogoType READONLY,
	@SolicitudClienteOrigen BIGINT = null,
	@IDCDC VARCHAR(100) = NULL,
	@IDCMC VARCHAR(200) = NULL
AS
BEGIN
	DECLARE
		@SolicitudClienteID BIGINT,
		@MensajeResultado VARCHAR(500),
		@SolicitudClienteLogID BIGINT,
		@MensajeResultadoDetalle VARCHAR(500),
		@flagDetalle BIT,
		@TerritorioID INT

	SET @SolicitudClienteID = 0
	SET @SolicitudClienteLogID = 0
	SET @flagDetalle = 0
	SET @TerritorioID = (SELECT TerritorioID FROM ods.Consultora where ConsultoraID=@ConsultoraID)

	BEGIN TRY
		SET @MensajeResultado = ''

		--VALIDACIONES: INICIO--
		IF @CodigoConsultora IS NULL
			SET @MensajeResultado = @MensajeResultado + 'El código de consultora no fue ingresado.|'
		ELSE IF LEN(@CodigoConsultora) > 20
			SET @MensajeResultado = @MensajeResultado + 'El código de consultora no debe exceder los 20 caracteres.|'
		ELSE IF NOT EXISTS(SELECT 1 FROM ods.Consultora WHERE RTRIM(Codigo) = RTRIM(@CodigoConsultora))
			SET @MensajeResultado = @MensajeResultado + 'No existe el Código de Consultora.|'

		IF @ConsultoraID IS NULL OR @ConsultoraID = 0
			SET @MensajeResultado = @MensajeResultado + 'El ID de consultora no fue ingresado.|'
		ELSE IF NOT EXISTS(SELECT 1 FROM ods.Consultora WHERE ConsultoraID = @ConsultoraID)
			SET @MensajeResultado = @MensajeResultado + 'No existe el ID de la consultora.|'
		ELSE IF RTRIM(@CodigoConsultora) <> (SELECT RTRIM(Codigo) FROM ods.Consultora where ConsultoraID=@ConsultoraID)
			SET @MensajeResultado = @MensajeResultado + 'El Id de Consultora no está asociado con el Código Consultora.|'

		IF @CodigoUbigeo IS NULL
			SET @MensajeResultado = @MensajeResultado + 'El código ubigeo no fue ingresado.|'
		ELSE IF NOT EXISTS(SELECT 1 FROM dbo.Ubigeo WHERE CodigoUbigeo = @CodigoUbigeo)
		BEGIN
			IF NOT EXISTS(SELECT 1 FROM ods.Ubigeo WHERE CodigoUbigeo = @CodigoUbigeo)
			    SET @MensajeResultado = @MensajeResultado + 'No existe el código ubigeo.|'
		END

		IF @NombreCompleto IS NULL
			SET @MensajeResultado = @MensajeResultado + 'El nombre completo de la cliente no fue ingresado.|'
		ELSE IF LEN(@NombreCompleto) > 100
			SET @MensajeResultado = @MensajeResultado + 'El nombre completo de la cliente no debe exceder los 100 caracteres.|'

		IF @Email IS NULL
			SET @MensajeResultado = @MensajeResultado + 'El email de la cliente no fue ingresado.|'
		ELSE IF LEN(@Email) > 100
			SET @MensajeResultado = @MensajeResultado + 'El email de la cliente no debe exceder los 100 caracteres.|'

		IF @Telefono IS NULL
			SET @MensajeResultado = @MensajeResultado + 'El teléfono de la cliente no fue ingresado.|'
		ELSE IF LEN(@Telefono) > 100
			SET @MensajeResultado = @MensajeResultado + 'El teléfono de la cliente no debe exceder los 100 caracteres.|'

		IF @Mensaje IS NULL
			SET @MensajeResultado = @MensajeResultado + 'El mensaje de la cliente no fue ingresado.|'
		ELSE IF LEN(@Mensaje) > 800
			SET @MensajeResultado = @MensajeResultado + 'El mensaje no debe exceder los 800 caracteres.|'

		IF @Campania IS NULL
			SET @MensajeResultado = @MensajeResultado + 'La campaña no fue ingresada.|'
		ELSE IF LEN(@Campania) > 6
			SET @MensajeResultado = @MensajeResultado + 'El código de campaña no debe exceder los 6 caracteres.|'
		ELSE IF NOT EXISTS(SELECT Codigo FROM ods.Campania WHERE Codigo IN (@Campania))
			SET @MensajeResultado = @MensajeResultado + 'No existe la campaña ' + @Campania + '.|'

		IF @FlagMedio IS NULL OR LEN (@FlagMedio) = 0
			SET @MensajeResultado = @MensajeResultado + 'El flag medio no fue ingresado.|'
		ELSE IF NOT EXISTS(SELECT 1 FROM TablaLogicaDatos WHERE TablaLogicaID = 85 AND Codigo = @FlagMedio)
			SET @MensajeResultado = @MensajeResultado + 'El flag medio ''' + @FlagMedio + ''' no es válido.|'
		
		IF @CodigoDispositivo IS NULL
			SET @MensajeResultado = @MensajeResultado + 'El código del dispositivo no fue ingresado.|'
		ELSE IF LEN(@CodigoDispositivo) > 50
			SET @MensajeResultado = @MensajeResultado + 'El código del dispositivo no debe exceder los 50 caracteres.|'

		IF @SODispositivo IS NULL
			SET @MensajeResultado = @MensajeResultado + 'El so del dispositivo no fue ingresado.|'
		ELSE IF LEN(@SODispositivo) > 20
			SET @MensajeResultado = @MensajeResultado + 'El so del dispositivo no debe exceder los 100 caracteres.|'

		--VALIDACIONES: FIN--
		---------------------

		DECLARE
			@UnidGeo1 VARCHAR(100),
			@UnidGeo2 VARCHAR(100),
			@UnidGeo3 VARCHAR(100),
			@TipoDistribucion SMALLINT,
			@CodigoTipoDistribucion VARCHAR(10);

		SELECT TOP 1
			@UnidGeo1 = UnidadGeografica1,
			@UnidGeo2 = UnidadGeografica2,
			@UnidGeo3 = UnidadGeografica3
		FROM dbo.Ubigeo
		WHERE CodigoUbigeo = @CodigoUbigeo

		SELECT @CodigoTipoDistribucion = Codigo
		FROM TablaLogicaDatos
		WHERE TablaLogicaDatosID = 6801 AND TablaLogicaID = 68;

		SET @TipoDistribucion = CAST(@CodigoTipoDistribucion AS SMALLINT);

		IF @MensajeResultado <> ''
		BEGIN
			INSERT INTO SolicitudClienteLog(SolicitudClienteID, FechaEjecucion, Descripcion, ConsultoraID, CodigoUbigeo, NombreCompleto, Email, Telefono,
				Mensaje, Campania, UnidadGeografica1, UnidadGeografica2, UnidadGeografica3, TipoDistribucion, MarcaID, SolicitudClienteOrigen, Direccion, 
				FlagConsultora, FlagMedio, CodigoDispositivo, SODispositivo)
			VALUES (NULL, GETDATE(), @MensajeResultado, @ConsultoraID, @CodigoUbigeo, @NombreCompleto, @Email, @Telefono,
				@Mensaje, @Campania, @UnidGeo1, @UnidGeo2, @UnidGeo3, @TipoDistribucion, 0, 0, @Direccion, 
				@FlagConsultora, @FlagMedio, @CodigoDispositivo, @SODispositivo)
			SET @SolicitudClienteLogID = SCOPE_IDENTITY();
		END
		ELSE
		BEGIN
			INSERT INTO SolicitudCliente(ConsultoraID, CodigoUbigeo, NombreCompleto, Email, Telefono, Mensaje, Campania, MarcaID, FechaSolicitud, Leido, NumIteracion,UnidadGeografica1, UnidadGeografica2, UnidadGeografica3, TipoDistribucion, SolicitudClienteOrigen,
 Direccion, FlagConsultora, FlagMedio, CodigoDispositivo, SODispositivo, TipoUsuario, UsuarioAppID, IDCDC, IDCMC)
			VALUES (@ConsultoraID, @CodigoUbigeo, @NombreCompleto, @Email, @Telefono, @Mensaje, @Campania, 0, GETDATE(), 0, @NumIteracion, @UnidGeo1, @UnidGeo2, @UnidGeo3, @TipoDistribucion,isnull(@SolicitudClienteOrigen,0),@Direccion, @FlagConsultora, @FlagMedio,
 @CodigoDispositivo, @SODispositivo, @TipoUsuario, @UsuarioAppID, @IDCDC, @IDCMC)

			SET @SolicitudClienteID = SCOPE_IDENTITY();
			SET @MensajeResultado = 'Acción ejecutada satisfactoriamente.';

			--********************************Buscar el cliente origen, Codigo: Cesar FLores**************************
			IF @SolicitudClienteOrigen is null
			BEGIN
				SET @SolicitudClienteOrigen = isnull(dbo.ObtenerSolicitudClienteOrigen(@SolicitudClienteID),0);
				IF @SolicitudClienteOrigen <> 0
				BEGIN
					UPDATE SolicitudCliente
					SET SolicitudClienteOrigen=@SolicitudClienteOrigen
					WHERE SolicitudClienteID=@SolicitudClienteID;
				END
			END
			--*********************************************************************************************************

			INSERT INTO SolicitudClienteLog(SolicitudClienteID, FechaEjecucion, Descripcion, ConsultoraID, CodigoUbigeo, NombreCompleto, Email, Telefono,
				Mensaje, Campania, UnidadGeografica1, UnidadGeografica2, UnidadGeografica3, TipoDistribucion, MarcaID, SolicitudClienteOrigen, Direccion, 
				FlagConsultora, FlagMedio, CodigoDispositivo, SODispositivo)
			VALUES (@SolicitudClienteID, GETDATE(), @MensajeResultado, @ConsultoraID, @CodigoUbigeo, @NombreCompleto, @Email, @Telefono,
				@Mensaje, @Campania, @UnidGeo1, @UnidGeo2, @UnidGeo3, @TipoDistribucion, 0, @SolicitudClienteOrigen, @Direccion, 
				@FlagConsultora, @FlagMedio, @CodigoDispositivo, @SODispositivo)
			SET @SolicitudClienteLogID = SCOPE_IDENTITY();
				
			DECLARE
				@Cantidad INT,
				@CUV VARCHAR(6),
				@MarcaID INT,
				@DescripcionProducto VARCHAR(100),
				@Precio DECIMAL(20,2),
				@Tono VARCHAR(250),
				@Url VARCHAR(500),
				@i INT,
				@total INT

			DECLARE @TempSolicitudClienteDetalle TABLE
			(
				ID INT IDENTITY(1, 1),
				Cantidad INT,
				CUV VARCHAR(6),
				MarcaID INT,
				DescripcionProducto VARCHAR(100),
				Precio DECIMAL(20,2),
				Tono VARCHAR(250),
				Url VARCHAR(500)
			)

			INSERT INTO @TempSolicitudClienteDetalle(Cantidad, CUV, MarcaID, DescripcionProducto, Precio, Tono, Url)
			SELECT Cantidad, CUV, MarcaID, DescripcionProducto, Precio, Tono, Url FROM @SolicitudDetalle

			SET @i = 1
			SET @total = (SELECT MAX(ID) FROM @TempSolicitudClienteDetalle)
			WHILE @i <= @total
			BEGIN
				SET @CUV = (SELECT CUV FROM @TempSolicitudClienteDetalle WHERE ID = @i)
				SET @DescripcionProducto = (SELECT DescripcionProducto FROM @TempSolicitudClienteDetalle WHERE ID = @i)
				SET @Cantidad = (SELECT Cantidad FROM @TempSolicitudClienteDetalle WHERE ID = @i)
				SET @Precio = (SELECT Precio FROM @TempSolicitudClienteDetalle WHERE ID = @i)
				SET @MarcaID = (SELECT MarcaID FROM @TempSolicitudClienteDetalle WHERE ID = @i)
				SET @Tono = (SELECT Tono FROM @TempSolicitudClienteDetalle WHERE ID = @i)
				SET @Url = (SELECT Url FROM @TempSolicitudClienteDetalle WHERE ID = @i)
				SET @MensajeResultadoDetalle = ''

				/*RE2603 - CS(GGI) - 22/05/2015 - se esta quitando la validación para el @cuv*/

				--VALIDACIONES: INICIO--
				IF @DescripcionProducto IS NULL OR LEN(@DescripcionProducto) = 0
					SET @MensajeResultadoDetalle = @MensajeResultadoDetalle + 'No se ha ingresado la descripción de producto.|'

				IF @Cantidad <= 0
					SET @MensajeResultadoDetalle = @MensajeResultadoDetalle + 'La cantidad ingresada debe ser mayor a cero.|'

				IF @Precio <= 0
					SET @MensajeResultadoDetalle = @MensajeResultadoDetalle + 'El precio ingresado debe ser mayor a cero.|'
					
				IF NOT EXISTS(SELECT 1 FROM ods.Marca WHERE MarcaID IN (@MarcaID))
					SET @MensajeResultado = @MensajeResultado + 'No existe la marca con ID: ' + @MarcaID + '.|'
				ELSE IF @MarcaID NOT IN (1, 2, 3)
					SET @MensajeResultado = @MensajeResultado + 'El registro de solicitud es solo para las marcas: LBel, Esika, Cyzone.|'
				--VALIDACIONES: FIN--

				IF @MensajeResultadoDetalle <> ''
				BEGIN
					SET @flagDetalle = 1
					INSERT INTO SolicitudClienteDetalleLog(SolicitudClienteLogID, FechaEjecucion, Descripcion, CUV, Producto, Cantidad, Precio, MarcaID, Tono, Url) 
					VALUES (@SolicitudClienteLogID, GETDATE(), @MensajeResultadoDetalle, @CUV, @DescripcionProducto, @Cantidad, @Precio, @MarcaID, @Tono, @Url);
				END
				ELSE
				BEGIN
					SET @MensajeResultadoDetalle = 'Acción ejecutada satisfactoriamente.';
					-- Insertar el log del detalle. CORRECTO
					INSERT INTO SolicitudClienteDetalle(SolicitudClienteID, CUV, Producto, Cantidad, Precio, MarcaID, FechaCreacion, Tono, Url)
					VALUES (@SolicitudClienteID, @CUV, @DescripcionProducto, @Cantidad, @Precio, @MarcaID, getDate(), @Tono, @Url);
					INSERT INTO SolicitudClienteDetalleLog(SolicitudClienteLogID, FechaEjecucion, Descripcion, CUV, Producto, Cantidad, Precio, MarcaID, Tono, Url)
					VALUES (@SolicitudClienteLogID, GETDATE(), @MensajeResultadoDetalle, @CUV, @DescripcionProducto, @Cantidad, @Precio, @MarcaID, @Tono, @Url);
				END

				SET @i = @i + 1;
			END
		END

		IF @flagDetalle = 1
		BEGIN
			SET @MensajeResultado = 'Hubo un error al intentar registrar el detalle de la solicitud.';
			DELETE FROM SolicitudClienteDetalle WHERE SolicitudClienteID = @SolicitudClienteID;
			DELETE FROM SolicitudCliente WHERE SolicitudClienteID = @SolicitudClienteID;

			UPDATE SolicitudClienteLog
			SET
				SolicitudClienteID = NULL,
				Descripcion = @MensajeResultado
			WHERE SolicitudClienteLogID = @SolicitudClienteLogID;

			SET @SolicitudClienteID = 0;
		END

		SELECT @SolicitudClienteID Resultado, @MensajeResultado Mensaje;
	END TRY
	BEGIN CATCH
		SET @MensajeResultado = CONCAT(ERROR_MESSAGE(),' ',ERROR_LINE());
		SELECT @SolicitudClienteID Resultado, @MensajeResultado Mensaje
		
		INSERT INTO SolicitudClienteLog(SolicitudClienteID, FechaEjecucion, Descripcion, ConsultoraID, CodigoUbigeo, NombreCompleto, Email, Telefono,
				Mensaje, Campania, UnidadGeografica1, UnidadGeografica2, UnidadGeografica3, TipoDistribucion, MarcaID, SolicitudClienteOrigen, Direccion, 
				FlagConsultora, FlagMedio, CodigoDispositivo, SODispositivo)
		VALUES (NULL, GETDATE(), @MensajeResultado, @ConsultoraID, @CodigoUbigeo, @NombreCompleto, @Email, @Telefono,
				@Mensaje, @Campania, @UnidGeo1, @UnidGeo2, @UnidGeo3, @TipoDistribucion, 0, 0, @Direccion, 
				@FlagConsultora, @FlagMedio, @CodigoDispositivo, @SODispositivo)
		SET @SolicitudClienteLogID = SCOPE_IDENTITY();
	END CATCH
END

GO
USE [BelcorpPeru];
GO
ALTER PROCEDURE [dbo].[RegistrarSolicitudClienteAppCatalogo]	
    @Campania VARCHAR(6),
	@CodigoConsultora VARCHAR(30),
	@CodigoUbigeo VARCHAR(40),
	@ConsultoraID BIGINT,
	@Direccion VARCHAR(800),
	@Email VARCHAR(110),
	@Mensaje VARCHAR(810),
	@NombreCompleto VARCHAR(110),
	@Telefono VARCHAR(110),
	@FlagConsultora BIT,
	@FlagMedio VARCHAR(10),
	@NumIteracion INT,
	@CodigoDispositivo VARCHAR(50) = '-',
	@SODispositivo VARCHAR(20) = '-',
	@TipoUsuario INT = 0,
	@UsuarioAppID BIGINT = 0,
	@SolicitudDetalle dbo.SolicitudDetalleAppCatalogoType READONLY,
	@SolicitudClienteOrigen BIGINT = null,
	@IDCDC VARCHAR(100) = NULL,
	@IDCMC VARCHAR(200) = NULL
AS
BEGIN
	DECLARE
		@SolicitudClienteID BIGINT,
		@MensajeResultado VARCHAR(500),
		@SolicitudClienteLogID BIGINT,
		@MensajeResultadoDetalle VARCHAR(500),
		@flagDetalle BIT,
		@TerritorioID INT

	SET @SolicitudClienteID = 0
	SET @SolicitudClienteLogID = 0
	SET @flagDetalle = 0
	SET @TerritorioID = (SELECT TerritorioID FROM ods.Consultora where ConsultoraID=@ConsultoraID)

	BEGIN TRY
		SET @MensajeResultado = ''

		--VALIDACIONES: INICIO--
		IF @CodigoConsultora IS NULL
			SET @MensajeResultado = @MensajeResultado + 'El código de consultora no fue ingresado.|'
		ELSE IF LEN(@CodigoConsultora) > 20
			SET @MensajeResultado = @MensajeResultado + 'El código de consultora no debe exceder los 20 caracteres.|'
		ELSE IF NOT EXISTS(SELECT 1 FROM ods.Consultora WHERE RTRIM(Codigo) = RTRIM(@CodigoConsultora))
			SET @MensajeResultado = @MensajeResultado + 'No existe el Código de Consultora.|'

		IF @ConsultoraID IS NULL OR @ConsultoraID = 0
			SET @MensajeResultado = @MensajeResultado + 'El ID de consultora no fue ingresado.|'
		ELSE IF NOT EXISTS(SELECT 1 FROM ods.Consultora WHERE ConsultoraID = @ConsultoraID)
			SET @MensajeResultado = @MensajeResultado + 'No existe el ID de la consultora.|'
		ELSE IF RTRIM(@CodigoConsultora) <> (SELECT RTRIM(Codigo) FROM ods.Consultora where ConsultoraID=@ConsultoraID)
			SET @MensajeResultado = @MensajeResultado + 'El Id de Consultora no está asociado con el Código Consultora.|'

		IF @CodigoUbigeo IS NULL
			SET @MensajeResultado = @MensajeResultado + 'El código ubigeo no fue ingresado.|'
		ELSE IF NOT EXISTS(SELECT 1 FROM dbo.Ubigeo WHERE CodigoUbigeo = @CodigoUbigeo)
		BEGIN
			IF NOT EXISTS(SELECT 1 FROM ods.Ubigeo WHERE CodigoUbigeo = @CodigoUbigeo)
			    SET @MensajeResultado = @MensajeResultado + 'No existe el código ubigeo.|'
		END

		IF @NombreCompleto IS NULL
			SET @MensajeResultado = @MensajeResultado + 'El nombre completo de la cliente no fue ingresado.|'
		ELSE IF LEN(@NombreCompleto) > 100
			SET @MensajeResultado = @MensajeResultado + 'El nombre completo de la cliente no debe exceder los 100 caracteres.|'

		IF @Email IS NULL
			SET @MensajeResultado = @MensajeResultado + 'El email de la cliente no fue ingresado.|'
		ELSE IF LEN(@Email) > 100
			SET @MensajeResultado = @MensajeResultado + 'El email de la cliente no debe exceder los 100 caracteres.|'

		IF @Telefono IS NULL
			SET @MensajeResultado = @MensajeResultado + 'El teléfono de la cliente no fue ingresado.|'
		ELSE IF LEN(@Telefono) > 100
			SET @MensajeResultado = @MensajeResultado + 'El teléfono de la cliente no debe exceder los 100 caracteres.|'

		IF @Mensaje IS NULL
			SET @MensajeResultado = @MensajeResultado + 'El mensaje de la cliente no fue ingresado.|'
		ELSE IF LEN(@Mensaje) > 800
			SET @MensajeResultado = @MensajeResultado + 'El mensaje no debe exceder los 800 caracteres.|'

		IF @Campania IS NULL
			SET @MensajeResultado = @MensajeResultado + 'La campaña no fue ingresada.|'
		ELSE IF LEN(@Campania) > 6
			SET @MensajeResultado = @MensajeResultado + 'El código de campaña no debe exceder los 6 caracteres.|'
		ELSE IF NOT EXISTS(SELECT Codigo FROM ods.Campania WHERE Codigo IN (@Campania))
			SET @MensajeResultado = @MensajeResultado + 'No existe la campaña ' + @Campania + '.|'

		IF @FlagMedio IS NULL OR LEN (@FlagMedio) = 0
			SET @MensajeResultado = @MensajeResultado + 'El flag medio no fue ingresado.|'
		ELSE IF NOT EXISTS(SELECT 1 FROM TablaLogicaDatos WHERE TablaLogicaID = 85 AND Codigo = @FlagMedio)
			SET @MensajeResultado = @MensajeResultado + 'El flag medio ''' + @FlagMedio + ''' no es válido.|'
		
		IF @CodigoDispositivo IS NULL
			SET @MensajeResultado = @MensajeResultado + 'El código del dispositivo no fue ingresado.|'
		ELSE IF LEN(@CodigoDispositivo) > 50
			SET @MensajeResultado = @MensajeResultado + 'El código del dispositivo no debe exceder los 50 caracteres.|'

		IF @SODispositivo IS NULL
			SET @MensajeResultado = @MensajeResultado + 'El so del dispositivo no fue ingresado.|'
		ELSE IF LEN(@SODispositivo) > 20
			SET @MensajeResultado = @MensajeResultado + 'El so del dispositivo no debe exceder los 100 caracteres.|'

		--VALIDACIONES: FIN--
		---------------------

		DECLARE
			@UnidGeo1 VARCHAR(100),
			@UnidGeo2 VARCHAR(100),
			@UnidGeo3 VARCHAR(100),
			@TipoDistribucion SMALLINT,
			@CodigoTipoDistribucion VARCHAR(10);

		SELECT TOP 1
			@UnidGeo1 = UnidadGeografica1,
			@UnidGeo2 = UnidadGeografica2,
			@UnidGeo3 = UnidadGeografica3
		FROM dbo.Ubigeo
		WHERE CodigoUbigeo = @CodigoUbigeo

		SELECT @CodigoTipoDistribucion = Codigo
		FROM TablaLogicaDatos
		WHERE TablaLogicaDatosID = 6801 AND TablaLogicaID = 68;

		SET @TipoDistribucion = CAST(@CodigoTipoDistribucion AS SMALLINT);

		IF @MensajeResultado <> ''
		BEGIN
			INSERT INTO SolicitudClienteLog(SolicitudClienteID, FechaEjecucion, Descripcion, ConsultoraID, CodigoUbigeo, NombreCompleto, Email, Telefono,
				Mensaje, Campania, UnidadGeografica1, UnidadGeografica2, UnidadGeografica3, TipoDistribucion, MarcaID, SolicitudClienteOrigen, Direccion, 
				FlagConsultora, FlagMedio, CodigoDispositivo, SODispositivo)
			VALUES (NULL, GETDATE(), @MensajeResultado, @ConsultoraID, @CodigoUbigeo, @NombreCompleto, @Email, @Telefono,
				@Mensaje, @Campania, @UnidGeo1, @UnidGeo2, @UnidGeo3, @TipoDistribucion, 0, 0, @Direccion, 
				@FlagConsultora, @FlagMedio, @CodigoDispositivo, @SODispositivo)
			SET @SolicitudClienteLogID = SCOPE_IDENTITY();
		END
		ELSE
		BEGIN
			INSERT INTO SolicitudCliente(ConsultoraID, CodigoUbigeo, NombreCompleto, Email, Telefono, Mensaje, Campania, MarcaID, FechaSolicitud, Leido, NumIteracion,UnidadGeografica1, UnidadGeografica2, UnidadGeografica3, TipoDistribucion, SolicitudClienteOrigen,
 Direccion, FlagConsultora, FlagMedio, CodigoDispositivo, SODispositivo, TipoUsuario, UsuarioAppID, IDCDC, IDCMC)
			VALUES (@ConsultoraID, @CodigoUbigeo, @NombreCompleto, @Email, @Telefono, @Mensaje, @Campania, 0, GETDATE(), 0, @NumIteracion, @UnidGeo1, @UnidGeo2, @UnidGeo3, @TipoDistribucion,isnull(@SolicitudClienteOrigen,0),@Direccion, @FlagConsultora, @FlagMedio,
 @CodigoDispositivo, @SODispositivo, @TipoUsuario, @UsuarioAppID, @IDCDC, @IDCMC)

			SET @SolicitudClienteID = SCOPE_IDENTITY();
			SET @MensajeResultado = 'Acción ejecutada satisfactoriamente.';

			--********************************Buscar el cliente origen, Codigo: Cesar FLores**************************
			IF @SolicitudClienteOrigen is null
			BEGIN
				SET @SolicitudClienteOrigen = isnull(dbo.ObtenerSolicitudClienteOrigen(@SolicitudClienteID),0);
				IF @SolicitudClienteOrigen <> 0
				BEGIN
					UPDATE SolicitudCliente
					SET SolicitudClienteOrigen=@SolicitudClienteOrigen
					WHERE SolicitudClienteID=@SolicitudClienteID;
				END
			END
			--*********************************************************************************************************

			INSERT INTO SolicitudClienteLog(SolicitudClienteID, FechaEjecucion, Descripcion, ConsultoraID, CodigoUbigeo, NombreCompleto, Email, Telefono,
				Mensaje, Campania, UnidadGeografica1, UnidadGeografica2, UnidadGeografica3, TipoDistribucion, MarcaID, SolicitudClienteOrigen, Direccion, 
				FlagConsultora, FlagMedio, CodigoDispositivo, SODispositivo)
			VALUES (@SolicitudClienteID, GETDATE(), @MensajeResultado, @ConsultoraID, @CodigoUbigeo, @NombreCompleto, @Email, @Telefono,
				@Mensaje, @Campania, @UnidGeo1, @UnidGeo2, @UnidGeo3, @TipoDistribucion, 0, @SolicitudClienteOrigen, @Direccion, 
				@FlagConsultora, @FlagMedio, @CodigoDispositivo, @SODispositivo)
			SET @SolicitudClienteLogID = SCOPE_IDENTITY();
				
			DECLARE
				@Cantidad INT,
				@CUV VARCHAR(6),
				@MarcaID INT,
				@DescripcionProducto VARCHAR(100),
				@Precio DECIMAL(20,2),
				@Tono VARCHAR(250),
				@Url VARCHAR(500),
				@i INT,
				@total INT

			DECLARE @TempSolicitudClienteDetalle TABLE
			(
				ID INT IDENTITY(1, 1),
				Cantidad INT,
				CUV VARCHAR(6),
				MarcaID INT,
				DescripcionProducto VARCHAR(100),
				Precio DECIMAL(20,2),
				Tono VARCHAR(250),
				Url VARCHAR(500)
			)

			INSERT INTO @TempSolicitudClienteDetalle(Cantidad, CUV, MarcaID, DescripcionProducto, Precio, Tono, Url)
			SELECT Cantidad, CUV, MarcaID, DescripcionProducto, Precio, Tono, Url FROM @SolicitudDetalle

			SET @i = 1
			SET @total = (SELECT MAX(ID) FROM @TempSolicitudClienteDetalle)
			WHILE @i <= @total
			BEGIN
				SET @CUV = (SELECT CUV FROM @TempSolicitudClienteDetalle WHERE ID = @i)
				SET @DescripcionProducto = (SELECT DescripcionProducto FROM @TempSolicitudClienteDetalle WHERE ID = @i)
				SET @Cantidad = (SELECT Cantidad FROM @TempSolicitudClienteDetalle WHERE ID = @i)
				SET @Precio = (SELECT Precio FROM @TempSolicitudClienteDetalle WHERE ID = @i)
				SET @MarcaID = (SELECT MarcaID FROM @TempSolicitudClienteDetalle WHERE ID = @i)
				SET @Tono = (SELECT Tono FROM @TempSolicitudClienteDetalle WHERE ID = @i)
				SET @Url = (SELECT Url FROM @TempSolicitudClienteDetalle WHERE ID = @i)
				SET @MensajeResultadoDetalle = ''

				/*RE2603 - CS(GGI) - 22/05/2015 - se esta quitando la validación para el @cuv*/

				--VALIDACIONES: INICIO--
				IF @DescripcionProducto IS NULL OR LEN(@DescripcionProducto) = 0
					SET @MensajeResultadoDetalle = @MensajeResultadoDetalle + 'No se ha ingresado la descripción de producto.|'

				IF @Cantidad <= 0
					SET @MensajeResultadoDetalle = @MensajeResultadoDetalle + 'La cantidad ingresada debe ser mayor a cero.|'

				IF @Precio <= 0
					SET @MensajeResultadoDetalle = @MensajeResultadoDetalle + 'El precio ingresado debe ser mayor a cero.|'
					
				IF NOT EXISTS(SELECT 1 FROM ods.Marca WHERE MarcaID IN (@MarcaID))
					SET @MensajeResultado = @MensajeResultado + 'No existe la marca con ID: ' + @MarcaID + '.|'
				ELSE IF @MarcaID NOT IN (1, 2, 3)
					SET @MensajeResultado = @MensajeResultado + 'El registro de solicitud es solo para las marcas: LBel, Esika, Cyzone.|'
				--VALIDACIONES: FIN--

				IF @MensajeResultadoDetalle <> ''
				BEGIN
					SET @flagDetalle = 1
					INSERT INTO SolicitudClienteDetalleLog(SolicitudClienteLogID, FechaEjecucion, Descripcion, CUV, Producto, Cantidad, Precio, MarcaID, Tono, Url) 
					VALUES (@SolicitudClienteLogID, GETDATE(), @MensajeResultadoDetalle, @CUV, @DescripcionProducto, @Cantidad, @Precio, @MarcaID, @Tono, @Url);
				END
				ELSE
				BEGIN
					SET @MensajeResultadoDetalle = 'Acción ejecutada satisfactoriamente.';
					-- Insertar el log del detalle. CORRECTO
					INSERT INTO SolicitudClienteDetalle(SolicitudClienteID, CUV, Producto, Cantidad, Precio, MarcaID, FechaCreacion, Tono, Url)
					VALUES (@SolicitudClienteID, @CUV, @DescripcionProducto, @Cantidad, @Precio, @MarcaID, getDate(), @Tono, @Url);
					INSERT INTO SolicitudClienteDetalleLog(SolicitudClienteLogID, FechaEjecucion, Descripcion, CUV, Producto, Cantidad, Precio, MarcaID, Tono, Url)
					VALUES (@SolicitudClienteLogID, GETDATE(), @MensajeResultadoDetalle, @CUV, @DescripcionProducto, @Cantidad, @Precio, @MarcaID, @Tono, @Url);
				END

				SET @i = @i + 1;
			END
		END

		IF @flagDetalle = 1
		BEGIN
			SET @MensajeResultado = 'Hubo un error al intentar registrar el detalle de la solicitud.';
			DELETE FROM SolicitudClienteDetalle WHERE SolicitudClienteID = @SolicitudClienteID;
			DELETE FROM SolicitudCliente WHERE SolicitudClienteID = @SolicitudClienteID;

			UPDATE SolicitudClienteLog
			SET
				SolicitudClienteID = NULL,
				Descripcion = @MensajeResultado
			WHERE SolicitudClienteLogID = @SolicitudClienteLogID;

			SET @SolicitudClienteID = 0;
		END

		SELECT @SolicitudClienteID Resultado, @MensajeResultado Mensaje;
	END TRY
	BEGIN CATCH
		SET @MensajeResultado = CONCAT(ERROR_MESSAGE(),' ',ERROR_LINE());
		SELECT @SolicitudClienteID Resultado, @MensajeResultado Mensaje
		
		INSERT INTO SolicitudClienteLog(SolicitudClienteID, FechaEjecucion, Descripcion, ConsultoraID, CodigoUbigeo, NombreCompleto, Email, Telefono,
				Mensaje, Campania, UnidadGeografica1, UnidadGeografica2, UnidadGeografica3, TipoDistribucion, MarcaID, SolicitudClienteOrigen, Direccion, 
				FlagConsultora, FlagMedio, CodigoDispositivo, SODispositivo)
		VALUES (NULL, GETDATE(), @MensajeResultado, @ConsultoraID, @CodigoUbigeo, @NombreCompleto, @Email, @Telefono,
				@Mensaje, @Campania, @UnidGeo1, @UnidGeo2, @UnidGeo3, @TipoDistribucion, 0, 0, @Direccion, 
				@FlagConsultora, @FlagMedio, @CodigoDispositivo, @SODispositivo)
		SET @SolicitudClienteLogID = SCOPE_IDENTITY();
	END CATCH
END

GO
USE [BelcorpPuertoRico];
GO
ALTER PROCEDURE [dbo].[RegistrarSolicitudClienteAppCatalogo]	
    @Campania VARCHAR(6),
	@CodigoConsultora VARCHAR(30),
	@CodigoUbigeo VARCHAR(40),
	@ConsultoraID BIGINT,
	@Direccion VARCHAR(800),
	@Email VARCHAR(110),
	@Mensaje VARCHAR(810),
	@NombreCompleto VARCHAR(110),
	@Telefono VARCHAR(110),
	@FlagConsultora BIT,
	@FlagMedio VARCHAR(10),
	@NumIteracion INT,
	@CodigoDispositivo VARCHAR(50) = '-',
	@SODispositivo VARCHAR(20) = '-',
	@TipoUsuario INT = 0,
	@UsuarioAppID BIGINT = 0,
	@SolicitudDetalle dbo.SolicitudDetalleAppCatalogoType READONLY,
	@SolicitudClienteOrigen BIGINT = null,
	@IDCDC VARCHAR(100) = NULL,
	@IDCMC VARCHAR(200) = NULL
AS
BEGIN
	DECLARE
		@SolicitudClienteID BIGINT,
		@MensajeResultado VARCHAR(500),
		@SolicitudClienteLogID BIGINT,
		@MensajeResultadoDetalle VARCHAR(500),
		@flagDetalle BIT,
		@TerritorioID INT

	SET @SolicitudClienteID = 0
	SET @SolicitudClienteLogID = 0
	SET @flagDetalle = 0
	SET @TerritorioID = (SELECT TerritorioID FROM ods.Consultora where ConsultoraID=@ConsultoraID)

	BEGIN TRY
		SET @MensajeResultado = ''

		--VALIDACIONES: INICIO--
		IF @CodigoConsultora IS NULL
			SET @MensajeResultado = @MensajeResultado + 'El código de consultora no fue ingresado.|'
		ELSE IF LEN(@CodigoConsultora) > 20
			SET @MensajeResultado = @MensajeResultado + 'El código de consultora no debe exceder los 20 caracteres.|'
		ELSE IF NOT EXISTS(SELECT 1 FROM ods.Consultora WHERE RTRIM(Codigo) = RTRIM(@CodigoConsultora))
			SET @MensajeResultado = @MensajeResultado + 'No existe el Código de Consultora.|'

		IF @ConsultoraID IS NULL OR @ConsultoraID = 0
			SET @MensajeResultado = @MensajeResultado + 'El ID de consultora no fue ingresado.|'
		ELSE IF NOT EXISTS(SELECT 1 FROM ods.Consultora WHERE ConsultoraID = @ConsultoraID)
			SET @MensajeResultado = @MensajeResultado + 'No existe el ID de la consultora.|'
		ELSE IF RTRIM(@CodigoConsultora) <> (SELECT RTRIM(Codigo) FROM ods.Consultora where ConsultoraID=@ConsultoraID)
			SET @MensajeResultado = @MensajeResultado + 'El Id de Consultora no está asociado con el Código Consultora.|'

		IF @CodigoUbigeo IS NULL
			SET @MensajeResultado = @MensajeResultado + 'El código ubigeo no fue ingresado.|'
		ELSE IF NOT EXISTS(SELECT 1 FROM dbo.Ubigeo WHERE CodigoUbigeo = @CodigoUbigeo)
		BEGIN
			IF NOT EXISTS(SELECT 1 FROM ods.Ubigeo WHERE CodigoUbigeo = @CodigoUbigeo)
			    SET @MensajeResultado = @MensajeResultado + 'No existe el código ubigeo.|'
		END

		IF @NombreCompleto IS NULL
			SET @MensajeResultado = @MensajeResultado + 'El nombre completo de la cliente no fue ingresado.|'
		ELSE IF LEN(@NombreCompleto) > 100
			SET @MensajeResultado = @MensajeResultado + 'El nombre completo de la cliente no debe exceder los 100 caracteres.|'

		IF @Email IS NULL
			SET @MensajeResultado = @MensajeResultado + 'El email de la cliente no fue ingresado.|'
		ELSE IF LEN(@Email) > 100
			SET @MensajeResultado = @MensajeResultado + 'El email de la cliente no debe exceder los 100 caracteres.|'

		IF @Telefono IS NULL
			SET @MensajeResultado = @MensajeResultado + 'El teléfono de la cliente no fue ingresado.|'
		ELSE IF LEN(@Telefono) > 100
			SET @MensajeResultado = @MensajeResultado + 'El teléfono de la cliente no debe exceder los 100 caracteres.|'

		IF @Mensaje IS NULL
			SET @MensajeResultado = @MensajeResultado + 'El mensaje de la cliente no fue ingresado.|'
		ELSE IF LEN(@Mensaje) > 800
			SET @MensajeResultado = @MensajeResultado + 'El mensaje no debe exceder los 800 caracteres.|'

		IF @Campania IS NULL
			SET @MensajeResultado = @MensajeResultado + 'La campaña no fue ingresada.|'
		ELSE IF LEN(@Campania) > 6
			SET @MensajeResultado = @MensajeResultado + 'El código de campaña no debe exceder los 6 caracteres.|'
		ELSE IF NOT EXISTS(SELECT Codigo FROM ods.Campania WHERE Codigo IN (@Campania))
			SET @MensajeResultado = @MensajeResultado + 'No existe la campaña ' + @Campania + '.|'

		IF @FlagMedio IS NULL OR LEN (@FlagMedio) = 0
			SET @MensajeResultado = @MensajeResultado + 'El flag medio no fue ingresado.|'
		ELSE IF NOT EXISTS(SELECT 1 FROM TablaLogicaDatos WHERE TablaLogicaID = 85 AND Codigo = @FlagMedio)
			SET @MensajeResultado = @MensajeResultado + 'El flag medio ''' + @FlagMedio + ''' no es válido.|'
		
		IF @CodigoDispositivo IS NULL
			SET @MensajeResultado = @MensajeResultado + 'El código del dispositivo no fue ingresado.|'
		ELSE IF LEN(@CodigoDispositivo) > 50
			SET @MensajeResultado = @MensajeResultado + 'El código del dispositivo no debe exceder los 50 caracteres.|'

		IF @SODispositivo IS NULL
			SET @MensajeResultado = @MensajeResultado + 'El so del dispositivo no fue ingresado.|'
		ELSE IF LEN(@SODispositivo) > 20
			SET @MensajeResultado = @MensajeResultado + 'El so del dispositivo no debe exceder los 100 caracteres.|'

		--VALIDACIONES: FIN--
		---------------------

		DECLARE
			@UnidGeo1 VARCHAR(100),
			@UnidGeo2 VARCHAR(100),
			@UnidGeo3 VARCHAR(100),
			@TipoDistribucion SMALLINT,
			@CodigoTipoDistribucion VARCHAR(10);

		SELECT TOP 1
			@UnidGeo1 = UnidadGeografica1,
			@UnidGeo2 = UnidadGeografica2,
			@UnidGeo3 = UnidadGeografica3
		FROM dbo.Ubigeo
		WHERE CodigoUbigeo = @CodigoUbigeo

		SELECT @CodigoTipoDistribucion = Codigo
		FROM TablaLogicaDatos
		WHERE TablaLogicaDatosID = 6801 AND TablaLogicaID = 68;

		SET @TipoDistribucion = CAST(@CodigoTipoDistribucion AS SMALLINT);

		IF @MensajeResultado <> ''
		BEGIN
			INSERT INTO SolicitudClienteLog(SolicitudClienteID, FechaEjecucion, Descripcion, ConsultoraID, CodigoUbigeo, NombreCompleto, Email, Telefono,
				Mensaje, Campania, UnidadGeografica1, UnidadGeografica2, UnidadGeografica3, TipoDistribucion, MarcaID, SolicitudClienteOrigen, Direccion, 
				FlagConsultora, FlagMedio, CodigoDispositivo, SODispositivo)
			VALUES (NULL, GETDATE(), @MensajeResultado, @ConsultoraID, @CodigoUbigeo, @NombreCompleto, @Email, @Telefono,
				@Mensaje, @Campania, @UnidGeo1, @UnidGeo2, @UnidGeo3, @TipoDistribucion, 0, 0, @Direccion, 
				@FlagConsultora, @FlagMedio, @CodigoDispositivo, @SODispositivo)
			SET @SolicitudClienteLogID = SCOPE_IDENTITY();
		END
		ELSE
		BEGIN
			INSERT INTO SolicitudCliente(ConsultoraID, CodigoUbigeo, NombreCompleto, Email, Telefono, Mensaje, Campania, MarcaID, FechaSolicitud, Leido, NumIteracion,UnidadGeografica1, UnidadGeografica2, UnidadGeografica3, TipoDistribucion, SolicitudClienteOrigen,
 Direccion, FlagConsultora, FlagMedio, CodigoDispositivo, SODispositivo, TipoUsuario, UsuarioAppID, IDCDC, IDCMC)
			VALUES (@ConsultoraID, @CodigoUbigeo, @NombreCompleto, @Email, @Telefono, @Mensaje, @Campania, 0, GETDATE(), 0, @NumIteracion, @UnidGeo1, @UnidGeo2, @UnidGeo3, @TipoDistribucion,isnull(@SolicitudClienteOrigen,0),@Direccion, @FlagConsultora, @FlagMedio,
 @CodigoDispositivo, @SODispositivo, @TipoUsuario, @UsuarioAppID, @IDCDC, @IDCMC)

			SET @SolicitudClienteID = SCOPE_IDENTITY();
			SET @MensajeResultado = 'Acción ejecutada satisfactoriamente.';

			--********************************Buscar el cliente origen, Codigo: Cesar FLores**************************
			IF @SolicitudClienteOrigen is null
			BEGIN
				SET @SolicitudClienteOrigen = isnull(dbo.ObtenerSolicitudClienteOrigen(@SolicitudClienteID),0);
				IF @SolicitudClienteOrigen <> 0
				BEGIN
					UPDATE SolicitudCliente
					SET SolicitudClienteOrigen=@SolicitudClienteOrigen
					WHERE SolicitudClienteID=@SolicitudClienteID;
				END
			END
			--*********************************************************************************************************

			INSERT INTO SolicitudClienteLog(SolicitudClienteID, FechaEjecucion, Descripcion, ConsultoraID, CodigoUbigeo, NombreCompleto, Email, Telefono,
				Mensaje, Campania, UnidadGeografica1, UnidadGeografica2, UnidadGeografica3, TipoDistribucion, MarcaID, SolicitudClienteOrigen, Direccion, 
				FlagConsultora, FlagMedio, CodigoDispositivo, SODispositivo)
			VALUES (@SolicitudClienteID, GETDATE(), @MensajeResultado, @ConsultoraID, @CodigoUbigeo, @NombreCompleto, @Email, @Telefono,
				@Mensaje, @Campania, @UnidGeo1, @UnidGeo2, @UnidGeo3, @TipoDistribucion, 0, @SolicitudClienteOrigen, @Direccion, 
				@FlagConsultora, @FlagMedio, @CodigoDispositivo, @SODispositivo)
			SET @SolicitudClienteLogID = SCOPE_IDENTITY();
				
			DECLARE
				@Cantidad INT,
				@CUV VARCHAR(6),
				@MarcaID INT,
				@DescripcionProducto VARCHAR(100),
				@Precio DECIMAL(20,2),
				@Tono VARCHAR(250),
				@Url VARCHAR(500),
				@i INT,
				@total INT

			DECLARE @TempSolicitudClienteDetalle TABLE
			(
				ID INT IDENTITY(1, 1),
				Cantidad INT,
				CUV VARCHAR(6),
				MarcaID INT,
				DescripcionProducto VARCHAR(100),
				Precio DECIMAL(20,2),
				Tono VARCHAR(250),
				Url VARCHAR(500)
			)

			INSERT INTO @TempSolicitudClienteDetalle(Cantidad, CUV, MarcaID, DescripcionProducto, Precio, Tono, Url)
			SELECT Cantidad, CUV, MarcaID, DescripcionProducto, Precio, Tono, Url FROM @SolicitudDetalle

			SET @i = 1
			SET @total = (SELECT MAX(ID) FROM @TempSolicitudClienteDetalle)
			WHILE @i <= @total
			BEGIN
				SET @CUV = (SELECT CUV FROM @TempSolicitudClienteDetalle WHERE ID = @i)
				SET @DescripcionProducto = (SELECT DescripcionProducto FROM @TempSolicitudClienteDetalle WHERE ID = @i)
				SET @Cantidad = (SELECT Cantidad FROM @TempSolicitudClienteDetalle WHERE ID = @i)
				SET @Precio = (SELECT Precio FROM @TempSolicitudClienteDetalle WHERE ID = @i)
				SET @MarcaID = (SELECT MarcaID FROM @TempSolicitudClienteDetalle WHERE ID = @i)
				SET @Tono = (SELECT Tono FROM @TempSolicitudClienteDetalle WHERE ID = @i)
				SET @Url = (SELECT Url FROM @TempSolicitudClienteDetalle WHERE ID = @i)
				SET @MensajeResultadoDetalle = ''

				/*RE2603 - CS(GGI) - 22/05/2015 - se esta quitando la validación para el @cuv*/

				--VALIDACIONES: INICIO--
				IF @DescripcionProducto IS NULL OR LEN(@DescripcionProducto) = 0
					SET @MensajeResultadoDetalle = @MensajeResultadoDetalle + 'No se ha ingresado la descripción de producto.|'

				IF @Cantidad <= 0
					SET @MensajeResultadoDetalle = @MensajeResultadoDetalle + 'La cantidad ingresada debe ser mayor a cero.|'

				IF @Precio <= 0
					SET @MensajeResultadoDetalle = @MensajeResultadoDetalle + 'El precio ingresado debe ser mayor a cero.|'
					
				IF NOT EXISTS(SELECT 1 FROM ods.Marca WHERE MarcaID IN (@MarcaID))
					SET @MensajeResultado = @MensajeResultado + 'No existe la marca con ID: ' + @MarcaID + '.|'
				ELSE IF @MarcaID NOT IN (1, 2, 3)
					SET @MensajeResultado = @MensajeResultado + 'El registro de solicitud es solo para las marcas: LBel, Esika, Cyzone.|'
				--VALIDACIONES: FIN--

				IF @MensajeResultadoDetalle <> ''
				BEGIN
					SET @flagDetalle = 1
					INSERT INTO SolicitudClienteDetalleLog(SolicitudClienteLogID, FechaEjecucion, Descripcion, CUV, Producto, Cantidad, Precio, MarcaID, Tono, Url) 
					VALUES (@SolicitudClienteLogID, GETDATE(), @MensajeResultadoDetalle, @CUV, @DescripcionProducto, @Cantidad, @Precio, @MarcaID, @Tono, @Url);
				END
				ELSE
				BEGIN
					SET @MensajeResultadoDetalle = 'Acción ejecutada satisfactoriamente.';
					-- Insertar el log del detalle. CORRECTO
					INSERT INTO SolicitudClienteDetalle(SolicitudClienteID, CUV, Producto, Cantidad, Precio, MarcaID, FechaCreacion, Tono, Url)
					VALUES (@SolicitudClienteID, @CUV, @DescripcionProducto, @Cantidad, @Precio, @MarcaID, getDate(), @Tono, @Url);
					INSERT INTO SolicitudClienteDetalleLog(SolicitudClienteLogID, FechaEjecucion, Descripcion, CUV, Producto, Cantidad, Precio, MarcaID, Tono, Url)
					VALUES (@SolicitudClienteLogID, GETDATE(), @MensajeResultadoDetalle, @CUV, @DescripcionProducto, @Cantidad, @Precio, @MarcaID, @Tono, @Url);
				END

				SET @i = @i + 1;
			END
		END

		IF @flagDetalle = 1
		BEGIN
			SET @MensajeResultado = 'Hubo un error al intentar registrar el detalle de la solicitud.';
			DELETE FROM SolicitudClienteDetalle WHERE SolicitudClienteID = @SolicitudClienteID;
			DELETE FROM SolicitudCliente WHERE SolicitudClienteID = @SolicitudClienteID;

			UPDATE SolicitudClienteLog
			SET
				SolicitudClienteID = NULL,
				Descripcion = @MensajeResultado
			WHERE SolicitudClienteLogID = @SolicitudClienteLogID;

			SET @SolicitudClienteID = 0;
		END

		SELECT @SolicitudClienteID Resultado, @MensajeResultado Mensaje;
	END TRY
	BEGIN CATCH
		SET @MensajeResultado = CONCAT(ERROR_MESSAGE(),' ',ERROR_LINE());
		SELECT @SolicitudClienteID Resultado, @MensajeResultado Mensaje
		
		INSERT INTO SolicitudClienteLog(SolicitudClienteID, FechaEjecucion, Descripcion, ConsultoraID, CodigoUbigeo, NombreCompleto, Email, Telefono,
				Mensaje, Campania, UnidadGeografica1, UnidadGeografica2, UnidadGeografica3, TipoDistribucion, MarcaID, SolicitudClienteOrigen, Direccion, 
				FlagConsultora, FlagMedio, CodigoDispositivo, SODispositivo)
		VALUES (NULL, GETDATE(), @MensajeResultado, @ConsultoraID, @CodigoUbigeo, @NombreCompleto, @Email, @Telefono,
				@Mensaje, @Campania, @UnidGeo1, @UnidGeo2, @UnidGeo3, @TipoDistribucion, 0, 0, @Direccion, 
				@FlagConsultora, @FlagMedio, @CodigoDispositivo, @SODispositivo)
		SET @SolicitudClienteLogID = SCOPE_IDENTITY();
	END CATCH
END

GO
USE [BelcorpSalvador];
GO
ALTER PROCEDURE [dbo].[RegistrarSolicitudClienteAppCatalogo]	
    @Campania VARCHAR(6),
	@CodigoConsultora VARCHAR(30),
	@CodigoUbigeo VARCHAR(40),
	@ConsultoraID BIGINT,
	@Direccion VARCHAR(800),
	@Email VARCHAR(110),
	@Mensaje VARCHAR(810),
	@NombreCompleto VARCHAR(110),
	@Telefono VARCHAR(110),
	@FlagConsultora BIT,
	@FlagMedio VARCHAR(10),
	@NumIteracion INT,
	@CodigoDispositivo VARCHAR(50) = '-',
	@SODispositivo VARCHAR(20) = '-',
	@TipoUsuario INT = 0,
	@UsuarioAppID BIGINT = 0,
	@SolicitudDetalle dbo.SolicitudDetalleAppCatalogoType READONLY,
	@SolicitudClienteOrigen BIGINT = null,
	@IDCDC VARCHAR(100) = NULL,
	@IDCMC VARCHAR(200) = NULL
AS
BEGIN
	DECLARE
		@SolicitudClienteID BIGINT,
		@MensajeResultado VARCHAR(500),
		@SolicitudClienteLogID BIGINT,
		@MensajeResultadoDetalle VARCHAR(500),
		@flagDetalle BIT,
		@TerritorioID INT

	SET @SolicitudClienteID = 0
	SET @SolicitudClienteLogID = 0
	SET @flagDetalle = 0
	SET @TerritorioID = (SELECT TerritorioID FROM ods.Consultora where ConsultoraID=@ConsultoraID)

	BEGIN TRY
		SET @MensajeResultado = ''

		--VALIDACIONES: INICIO--
		IF @CodigoConsultora IS NULL
			SET @MensajeResultado = @MensajeResultado + 'El código de consultora no fue ingresado.|'
		ELSE IF LEN(@CodigoConsultora) > 20
			SET @MensajeResultado = @MensajeResultado + 'El código de consultora no debe exceder los 20 caracteres.|'
		ELSE IF NOT EXISTS(SELECT 1 FROM ods.Consultora WHERE RTRIM(Codigo) = RTRIM(@CodigoConsultora))
			SET @MensajeResultado = @MensajeResultado + 'No existe el Código de Consultora.|'

		IF @ConsultoraID IS NULL OR @ConsultoraID = 0
			SET @MensajeResultado = @MensajeResultado + 'El ID de consultora no fue ingresado.|'
		ELSE IF NOT EXISTS(SELECT 1 FROM ods.Consultora WHERE ConsultoraID = @ConsultoraID)
			SET @MensajeResultado = @MensajeResultado + 'No existe el ID de la consultora.|'
		ELSE IF RTRIM(@CodigoConsultora) <> (SELECT RTRIM(Codigo) FROM ods.Consultora where ConsultoraID=@ConsultoraID)
			SET @MensajeResultado = @MensajeResultado + 'El Id de Consultora no está asociado con el Código Consultora.|'

		IF @CodigoUbigeo IS NULL
			SET @MensajeResultado = @MensajeResultado + 'El código ubigeo no fue ingresado.|'
		ELSE IF NOT EXISTS(SELECT 1 FROM dbo.Ubigeo WHERE CodigoUbigeo = @CodigoUbigeo)
		BEGIN
			IF NOT EXISTS(SELECT 1 FROM ods.Ubigeo WHERE CodigoUbigeo = @CodigoUbigeo)
			    SET @MensajeResultado = @MensajeResultado + 'No existe el código ubigeo.|'
		END

		IF @NombreCompleto IS NULL
			SET @MensajeResultado = @MensajeResultado + 'El nombre completo de la cliente no fue ingresado.|'
		ELSE IF LEN(@NombreCompleto) > 100
			SET @MensajeResultado = @MensajeResultado + 'El nombre completo de la cliente no debe exceder los 100 caracteres.|'

		IF @Email IS NULL
			SET @MensajeResultado = @MensajeResultado + 'El email de la cliente no fue ingresado.|'
		ELSE IF LEN(@Email) > 100
			SET @MensajeResultado = @MensajeResultado + 'El email de la cliente no debe exceder los 100 caracteres.|'

		IF @Telefono IS NULL
			SET @MensajeResultado = @MensajeResultado + 'El teléfono de la cliente no fue ingresado.|'
		ELSE IF LEN(@Telefono) > 100
			SET @MensajeResultado = @MensajeResultado + 'El teléfono de la cliente no debe exceder los 100 caracteres.|'

		IF @Mensaje IS NULL
			SET @MensajeResultado = @MensajeResultado + 'El mensaje de la cliente no fue ingresado.|'
		ELSE IF LEN(@Mensaje) > 800
			SET @MensajeResultado = @MensajeResultado + 'El mensaje no debe exceder los 800 caracteres.|'

		IF @Campania IS NULL
			SET @MensajeResultado = @MensajeResultado + 'La campaña no fue ingresada.|'
		ELSE IF LEN(@Campania) > 6
			SET @MensajeResultado = @MensajeResultado + 'El código de campaña no debe exceder los 6 caracteres.|'
		ELSE IF NOT EXISTS(SELECT Codigo FROM ods.Campania WHERE Codigo IN (@Campania))
			SET @MensajeResultado = @MensajeResultado + 'No existe la campaña ' + @Campania + '.|'

		IF @FlagMedio IS NULL OR LEN (@FlagMedio) = 0
			SET @MensajeResultado = @MensajeResultado + 'El flag medio no fue ingresado.|'
		ELSE IF NOT EXISTS(SELECT 1 FROM TablaLogicaDatos WHERE TablaLogicaID = 85 AND Codigo = @FlagMedio)
			SET @MensajeResultado = @MensajeResultado + 'El flag medio ''' + @FlagMedio + ''' no es válido.|'
		
		IF @CodigoDispositivo IS NULL
			SET @MensajeResultado = @MensajeResultado + 'El código del dispositivo no fue ingresado.|'
		ELSE IF LEN(@CodigoDispositivo) > 50
			SET @MensajeResultado = @MensajeResultado + 'El código del dispositivo no debe exceder los 50 caracteres.|'

		IF @SODispositivo IS NULL
			SET @MensajeResultado = @MensajeResultado + 'El so del dispositivo no fue ingresado.|'
		ELSE IF LEN(@SODispositivo) > 20
			SET @MensajeResultado = @MensajeResultado + 'El so del dispositivo no debe exceder los 100 caracteres.|'

		--VALIDACIONES: FIN--
		---------------------

		DECLARE
			@UnidGeo1 VARCHAR(100),
			@UnidGeo2 VARCHAR(100),
			@UnidGeo3 VARCHAR(100),
			@TipoDistribucion SMALLINT,
			@CodigoTipoDistribucion VARCHAR(10);

		SELECT TOP 1
			@UnidGeo1 = UnidadGeografica1,
			@UnidGeo2 = UnidadGeografica2,
			@UnidGeo3 = UnidadGeografica3
		FROM dbo.Ubigeo
		WHERE CodigoUbigeo = @CodigoUbigeo

		SELECT @CodigoTipoDistribucion = Codigo
		FROM TablaLogicaDatos
		WHERE TablaLogicaDatosID = 6801 AND TablaLogicaID = 68;

		SET @TipoDistribucion = CAST(@CodigoTipoDistribucion AS SMALLINT);

		IF @MensajeResultado <> ''
		BEGIN
			INSERT INTO SolicitudClienteLog(SolicitudClienteID, FechaEjecucion, Descripcion, ConsultoraID, CodigoUbigeo, NombreCompleto, Email, Telefono,
				Mensaje, Campania, UnidadGeografica1, UnidadGeografica2, UnidadGeografica3, TipoDistribucion, MarcaID, SolicitudClienteOrigen, Direccion, 
				FlagConsultora, FlagMedio, CodigoDispositivo, SODispositivo)
			VALUES (NULL, GETDATE(), @MensajeResultado, @ConsultoraID, @CodigoUbigeo, @NombreCompleto, @Email, @Telefono,
				@Mensaje, @Campania, @UnidGeo1, @UnidGeo2, @UnidGeo3, @TipoDistribucion, 0, 0, @Direccion, 
				@FlagConsultora, @FlagMedio, @CodigoDispositivo, @SODispositivo)
			SET @SolicitudClienteLogID = SCOPE_IDENTITY();
		END
		ELSE
		BEGIN
			INSERT INTO SolicitudCliente(ConsultoraID, CodigoUbigeo, NombreCompleto, Email, Telefono, Mensaje, Campania, MarcaID, FechaSolicitud, Leido, NumIteracion,UnidadGeografica1, UnidadGeografica2, UnidadGeografica3, TipoDistribucion, SolicitudClienteOrigen,
 Direccion, FlagConsultora, FlagMedio, CodigoDispositivo, SODispositivo, TipoUsuario, UsuarioAppID, IDCDC, IDCMC)
			VALUES (@ConsultoraID, @CodigoUbigeo, @NombreCompleto, @Email, @Telefono, @Mensaje, @Campania, 0, GETDATE(), 0, @NumIteracion, @UnidGeo1, @UnidGeo2, @UnidGeo3, @TipoDistribucion,isnull(@SolicitudClienteOrigen,0),@Direccion, @FlagConsultora, @FlagMedio,
 @CodigoDispositivo, @SODispositivo, @TipoUsuario, @UsuarioAppID, @IDCDC, @IDCMC)

			SET @SolicitudClienteID = SCOPE_IDENTITY();
			SET @MensajeResultado = 'Acción ejecutada satisfactoriamente.';

			--********************************Buscar el cliente origen, Codigo: Cesar FLores**************************
			IF @SolicitudClienteOrigen is null
			BEGIN
				SET @SolicitudClienteOrigen = isnull(dbo.ObtenerSolicitudClienteOrigen(@SolicitudClienteID),0);
				IF @SolicitudClienteOrigen <> 0
				BEGIN
					UPDATE SolicitudCliente
					SET SolicitudClienteOrigen=@SolicitudClienteOrigen
					WHERE SolicitudClienteID=@SolicitudClienteID;
				END
			END
			--*********************************************************************************************************

			INSERT INTO SolicitudClienteLog(SolicitudClienteID, FechaEjecucion, Descripcion, ConsultoraID, CodigoUbigeo, NombreCompleto, Email, Telefono,
				Mensaje, Campania, UnidadGeografica1, UnidadGeografica2, UnidadGeografica3, TipoDistribucion, MarcaID, SolicitudClienteOrigen, Direccion, 
				FlagConsultora, FlagMedio, CodigoDispositivo, SODispositivo)
			VALUES (@SolicitudClienteID, GETDATE(), @MensajeResultado, @ConsultoraID, @CodigoUbigeo, @NombreCompleto, @Email, @Telefono,
				@Mensaje, @Campania, @UnidGeo1, @UnidGeo2, @UnidGeo3, @TipoDistribucion, 0, @SolicitudClienteOrigen, @Direccion, 
				@FlagConsultora, @FlagMedio, @CodigoDispositivo, @SODispositivo)
			SET @SolicitudClienteLogID = SCOPE_IDENTITY();
				
			DECLARE
				@Cantidad INT,
				@CUV VARCHAR(6),
				@MarcaID INT,
				@DescripcionProducto VARCHAR(100),
				@Precio DECIMAL(20,2),
				@Tono VARCHAR(250),
				@Url VARCHAR(500),
				@i INT,
				@total INT

			DECLARE @TempSolicitudClienteDetalle TABLE
			(
				ID INT IDENTITY(1, 1),
				Cantidad INT,
				CUV VARCHAR(6),
				MarcaID INT,
				DescripcionProducto VARCHAR(100),
				Precio DECIMAL(20,2),
				Tono VARCHAR(250),
				Url VARCHAR(500)
			)

			INSERT INTO @TempSolicitudClienteDetalle(Cantidad, CUV, MarcaID, DescripcionProducto, Precio, Tono, Url)
			SELECT Cantidad, CUV, MarcaID, DescripcionProducto, Precio, Tono, Url FROM @SolicitudDetalle

			SET @i = 1
			SET @total = (SELECT MAX(ID) FROM @TempSolicitudClienteDetalle)
			WHILE @i <= @total
			BEGIN
				SET @CUV = (SELECT CUV FROM @TempSolicitudClienteDetalle WHERE ID = @i)
				SET @DescripcionProducto = (SELECT DescripcionProducto FROM @TempSolicitudClienteDetalle WHERE ID = @i)
				SET @Cantidad = (SELECT Cantidad FROM @TempSolicitudClienteDetalle WHERE ID = @i)
				SET @Precio = (SELECT Precio FROM @TempSolicitudClienteDetalle WHERE ID = @i)
				SET @MarcaID = (SELECT MarcaID FROM @TempSolicitudClienteDetalle WHERE ID = @i)
				SET @Tono = (SELECT Tono FROM @TempSolicitudClienteDetalle WHERE ID = @i)
				SET @Url = (SELECT Url FROM @TempSolicitudClienteDetalle WHERE ID = @i)
				SET @MensajeResultadoDetalle = ''

				/*RE2603 - CS(GGI) - 22/05/2015 - se esta quitando la validación para el @cuv*/

				--VALIDACIONES: INICIO--
				IF @DescripcionProducto IS NULL OR LEN(@DescripcionProducto) = 0
					SET @MensajeResultadoDetalle = @MensajeResultadoDetalle + 'No se ha ingresado la descripción de producto.|'

				IF @Cantidad <= 0
					SET @MensajeResultadoDetalle = @MensajeResultadoDetalle + 'La cantidad ingresada debe ser mayor a cero.|'

				IF @Precio <= 0
					SET @MensajeResultadoDetalle = @MensajeResultadoDetalle + 'El precio ingresado debe ser mayor a cero.|'
					
				IF NOT EXISTS(SELECT 1 FROM ods.Marca WHERE MarcaID IN (@MarcaID))
					SET @MensajeResultado = @MensajeResultado + 'No existe la marca con ID: ' + @MarcaID + '.|'
				ELSE IF @MarcaID NOT IN (1, 2, 3)
					SET @MensajeResultado = @MensajeResultado + 'El registro de solicitud es solo para las marcas: LBel, Esika, Cyzone.|'
				--VALIDACIONES: FIN--

				IF @MensajeResultadoDetalle <> ''
				BEGIN
					SET @flagDetalle = 1
					INSERT INTO SolicitudClienteDetalleLog(SolicitudClienteLogID, FechaEjecucion, Descripcion, CUV, Producto, Cantidad, Precio, MarcaID, Tono, Url) 
					VALUES (@SolicitudClienteLogID, GETDATE(), @MensajeResultadoDetalle, @CUV, @DescripcionProducto, @Cantidad, @Precio, @MarcaID, @Tono, @Url);
				END
				ELSE
				BEGIN
					SET @MensajeResultadoDetalle = 'Acción ejecutada satisfactoriamente.';
					-- Insertar el log del detalle. CORRECTO
					INSERT INTO SolicitudClienteDetalle(SolicitudClienteID, CUV, Producto, Cantidad, Precio, MarcaID, FechaCreacion, Tono, Url)
					VALUES (@SolicitudClienteID, @CUV, @DescripcionProducto, @Cantidad, @Precio, @MarcaID, getDate(), @Tono, @Url);
					INSERT INTO SolicitudClienteDetalleLog(SolicitudClienteLogID, FechaEjecucion, Descripcion, CUV, Producto, Cantidad, Precio, MarcaID, Tono, Url)
					VALUES (@SolicitudClienteLogID, GETDATE(), @MensajeResultadoDetalle, @CUV, @DescripcionProducto, @Cantidad, @Precio, @MarcaID, @Tono, @Url);
				END

				SET @i = @i + 1;
			END
		END

		IF @flagDetalle = 1
		BEGIN
			SET @MensajeResultado = 'Hubo un error al intentar registrar el detalle de la solicitud.';
			DELETE FROM SolicitudClienteDetalle WHERE SolicitudClienteID = @SolicitudClienteID;
			DELETE FROM SolicitudCliente WHERE SolicitudClienteID = @SolicitudClienteID;

			UPDATE SolicitudClienteLog
			SET
				SolicitudClienteID = NULL,
				Descripcion = @MensajeResultado
			WHERE SolicitudClienteLogID = @SolicitudClienteLogID;

			SET @SolicitudClienteID = 0;
		END

		SELECT @SolicitudClienteID Resultado, @MensajeResultado Mensaje;
	END TRY
	BEGIN CATCH
		SET @MensajeResultado = CONCAT(ERROR_MESSAGE(),' ',ERROR_LINE());
		SELECT @SolicitudClienteID Resultado, @MensajeResultado Mensaje
		
		INSERT INTO SolicitudClienteLog(SolicitudClienteID, FechaEjecucion, Descripcion, ConsultoraID, CodigoUbigeo, NombreCompleto, Email, Telefono,
				Mensaje, Campania, UnidadGeografica1, UnidadGeografica2, UnidadGeografica3, TipoDistribucion, MarcaID, SolicitudClienteOrigen, Direccion, 
				FlagConsultora, FlagMedio, CodigoDispositivo, SODispositivo)
		VALUES (NULL, GETDATE(), @MensajeResultado, @ConsultoraID, @CodigoUbigeo, @NombreCompleto, @Email, @Telefono,
				@Mensaje, @Campania, @UnidGeo1, @UnidGeo2, @UnidGeo3, @TipoDistribucion, 0, 0, @Direccion, 
				@FlagConsultora, @FlagMedio, @CodigoDispositivo, @SODispositivo)
		SET @SolicitudClienteLogID = SCOPE_IDENTITY();
	END CATCH
END

GO
