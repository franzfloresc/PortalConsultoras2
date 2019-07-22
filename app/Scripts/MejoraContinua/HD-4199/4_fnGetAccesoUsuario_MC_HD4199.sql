GO
USE [BelcorpBolivia]
GO
ALTER FUNCTION [dbo].[fnGetAccesoUsuario]
(
	@PaisID INT,
	@CodigoUsuario VARCHAR(20),
	@CodigoConsultora VARCHAR(20),
	@TipoUsuario TINYINT,
	@RolID INT
)
RETURNS @TB TABLE(
	Result TINYINT,
	Mensaje VARCHAR(100)
)
AS

BEGIN
	DECLARE @Result TINYINT
	DECLARE @Mensaje VARCHAR(100)
	DECLARE @PaisLbel TABLE (Id INT)
	DECLARE @TablaLogicaDatos TABLE (Id INT, Codigo VARCHAR(10))

	SET @Result = 0
	INSERT INTO @PaisLbel(Id) VALUES (1),(5),(9),(10)

	INSERT INTO @TablaLogicaDatos 
	SELECT TablaLogicaId, Codigo 
	FROM TablaLogicaDatos WHERE TablaLogicaID IN (12,18,19)

	DECLARE @ZonaID INT
	DECLARE @RegionID INT
	DECLARE @ConsultoraID INT
	DECLARE @IdEstadoActividad INT
	DECLARE @AutorizaPedido CHAR(1)
	DECLARE @UltimaCampanaFacturada INT

	IF (@TipoUsuario = 1)
	BEGIN
		SELECT	
			@ZonaID = ISNULL(ZonaID,0),
			@RegionID = ISNULL(RegionID,0),
			@ConsultoraID = ISNULL(ConsultoraID,0),
			@IdEstadoActividad = ISNULL(IdEstadoActividad,-1),
			@AutorizaPedido = ISNULL(AutorizaPedido,''),
			@UltimaCampanaFacturada = ISNULL(UltimaCampanaFacturada,0)
		FROM ods.Consultora WITH(NOLOCK)
		WHERE Codigo = @CodigoConsultora
	END

	IF (@RolID != 0)
	BEGIN
		IF (@IdEstadoActividad = 7)
		BEGIN
			SET @Result = 2 --*/HD-4199 Se bloquean a las consultoras retiradas /*
		END
		ELSE IF (@AutorizaPedido != '')
		BEGIN
			IF (@IdEstadoActividad != -1)
			BEGIN
				-- validar si es pais Esika
				IF @PaisID NOT IN (SELECT Id FROM @PaisLbel)
				BEGIN		
					-- caso CH
					IF (@PaisID = 3 AND @IdEstadoActividad IN (SELECT Codigo FROM @TablaLogicaDatos WHERE Id = 18) )
					BEGIN
						DECLARE @CampaniaActual INT
						SET @CampaniaActual = ISNULL((SELECT TOP 1 CampaniaID FROM dbo.GetCampaniaPreLogin(@PaisID,@ZonaID,@RegionID,@ConsultoraID)),0)

						-- validar las campañas que no ha ingresado
						IF (LEN(@UltimaCampanaFacturada) = 6 AND LEN(@CampaniaActual) = 6)
						BEGIN
							DECLARE @ca VARCHAR(10)
							DECLARE @uc VARCHAR(10)

							SET @ca = SUBSTRING(CAST(@CampaniaActual AS VARCHAR),1,4)
							SET @uc = SUBSTRING(CAST(@UltimaCampanaFacturada AS VARCHAR),1,4)

							IF @ca != @uc
							BEGIN
								SET @ca = SUBSTRING(CAST(@CampaniaActual AS VARCHAR),5,2)
								SET @uc = SUBSTRING(CAST(@UltimaCampanaFacturada AS VARCHAR),5,2)
								SET @CampaniaActual = CAST(@uc AS INT) + CAST(@ca AS INT)
								SET @UltimaCampanaFacturada = CAST(@uc AS INT)
							END
						END

						IF (@UltimaCampanaFacturada != 0 AND @CampaniaActual - @UltimaCampanaFacturada > 3)
							SET @Result = 2
						ELSE
						BEGIN
							-- validar si autoriza pedido
							/******HD-3693********/
							--IF (@AutorizaPedido = '0')
							--	SET @Result = 2
							--ELSE
							--	SET @Result = 3
							SET @Result = 3
							/******HD-3693********/
						END
					END				
					ELSE
					BEGIN
						-- validar si autoriza pedido
						/******HD-3693********/
						--IF (@AutorizaPedido = '0')
						--	SET @Result = 2
						--ELSE
						--	SET @Result = 3
						SET @Result = 3
						/******HD-3693********/
					END
				END	-- pais Esika
				ELSE
				BEGIN
					-- validar si autoriza pedido
					/******HD-3693********/
					--IF (@AutorizaPedido = '0')
					--	SET @Result = 2
					--ELSE
					--	SET @Result = 3
					SET @Result = 3
					/******HD-3693********/
				END -- pais Lbel
			END	-- @IdEstadoActividad
			ELSE
				SET @Result = 3		-- se asume para usuarios tipo SAC o tipo postulante
		END	-- @AutorizaPedido
		ELSE
			SET @Result = 3		-- se asume para usuarios tipo SAC o tipo postulante
	END	-- @RolID

	IF (@Result = 0)
		SET @Mensaje = 'Usuario No Existe'
	ELSE IF (@Result = 1)
		SET @Mensaje = 'Usuario No es del Portal'
	ELSE IF (@Result = 2)
		SET @Mensaje = 'No estás autorizada para pasar pedido'
	ELSE IF (@Result = 3)
		SET @Mensaje = 'Usuario OK'
	ELSE IF (@Result = 4)
		SET @Mensaje = 'Usuario o Contraseña Incorrectas'

	INSERT INTO @TB (Result,Mensaje) VALUES (@Result,@Mensaje)

	RETURN

END
GO
USE [BelcorpChile]
GO
ALTER FUNCTION [dbo].[fnGetAccesoUsuario]
(
	@PaisID INT,
	@CodigoUsuario VARCHAR(20),
	@CodigoConsultora VARCHAR(20),
	@TipoUsuario TINYINT,
	@RolID INT
)
RETURNS @TB TABLE(
	Result TINYINT,
	Mensaje VARCHAR(100)
)
AS

BEGIN
	DECLARE @Result TINYINT
	DECLARE @Mensaje VARCHAR(100)
	DECLARE @PaisLbel TABLE (Id INT)
	DECLARE @TablaLogicaDatos TABLE (Id INT, Codigo VARCHAR(10))

	SET @Result = 0
	INSERT INTO @PaisLbel(Id) VALUES (1),(5),(9),(10)

	INSERT INTO @TablaLogicaDatos 
	SELECT TablaLogicaId, Codigo 
	FROM TablaLogicaDatos WHERE TablaLogicaID IN (12,18,19)

	DECLARE @ZonaID INT
	DECLARE @RegionID INT
	DECLARE @ConsultoraID INT
	DECLARE @IdEstadoActividad INT
	DECLARE @AutorizaPedido CHAR(1)
	DECLARE @UltimaCampanaFacturada INT

	IF (@TipoUsuario = 1)
	BEGIN
		SELECT	
			@ZonaID = ISNULL(ZonaID,0),
			@RegionID = ISNULL(RegionID,0),
			@ConsultoraID = ISNULL(ConsultoraID,0),
			@IdEstadoActividad = ISNULL(IdEstadoActividad,-1),
			@AutorizaPedido = ISNULL(AutorizaPedido,''),
			@UltimaCampanaFacturada = ISNULL(UltimaCampanaFacturada,0)
		FROM ods.Consultora WITH(NOLOCK)
		WHERE Codigo = @CodigoConsultora
	END

	IF (@RolID != 0)
	BEGIN
		IF (@IdEstadoActividad = 7)
		BEGIN
			SET @Result = 2 --*/HD-4199 Se bloquean a las consultoras retiradas /*
		END
		ELSE IF (@AutorizaPedido != '')
		BEGIN
			IF (@IdEstadoActividad != -1)
			BEGIN
				-- validar si es pais Esika
				IF @PaisID NOT IN (SELECT Id FROM @PaisLbel)
				BEGIN		
					-- caso CH
					IF (@PaisID = 3 AND @IdEstadoActividad IN (SELECT Codigo FROM @TablaLogicaDatos WHERE Id = 18) )
					BEGIN
						DECLARE @CampaniaActual INT
						SET @CampaniaActual = ISNULL((SELECT TOP 1 CampaniaID FROM dbo.GetCampaniaPreLogin(@PaisID,@ZonaID,@RegionID,@ConsultoraID)),0)

						-- validar las campañas que no ha ingresado
						IF (LEN(@UltimaCampanaFacturada) = 6 AND LEN(@CampaniaActual) = 6)
						BEGIN
							DECLARE @ca VARCHAR(10)
							DECLARE @uc VARCHAR(10)

							SET @ca = SUBSTRING(CAST(@CampaniaActual AS VARCHAR),1,4)
							SET @uc = SUBSTRING(CAST(@UltimaCampanaFacturada AS VARCHAR),1,4)

							IF @ca != @uc
							BEGIN
								SET @ca = SUBSTRING(CAST(@CampaniaActual AS VARCHAR),5,2)
								SET @uc = SUBSTRING(CAST(@UltimaCampanaFacturada AS VARCHAR),5,2)
								SET @CampaniaActual = CAST(@uc AS INT) + CAST(@ca AS INT)
								SET @UltimaCampanaFacturada = CAST(@uc AS INT)
							END
						END

						IF (@UltimaCampanaFacturada != 0 AND @CampaniaActual - @UltimaCampanaFacturada > 3)
							SET @Result = 2
						ELSE
						BEGIN
							-- validar si autoriza pedido
							/******HD-3693********/
							--IF (@AutorizaPedido = '0')
							--	SET @Result = 2
							--ELSE
							--	SET @Result = 3
							SET @Result = 3
							/******HD-3693********/
						END
					END				
					ELSE
					BEGIN
						-- validar si autoriza pedido
						/******HD-3693********/
						--IF (@AutorizaPedido = '0')
						--	SET @Result = 2
						--ELSE
						--	SET @Result = 3
						SET @Result = 3
						/******HD-3693********/
					END
				END	-- pais Esika
				ELSE
				BEGIN
					-- validar si autoriza pedido
					/******HD-3693********/
					--IF (@AutorizaPedido = '0')
					--	SET @Result = 2
					--ELSE
					--	SET @Result = 3
					SET @Result = 3
					/******HD-3693********/
				END -- pais Lbel
			END	-- @IdEstadoActividad
			ELSE
				SET @Result = 3		-- se asume para usuarios tipo SAC o tipo postulante
		END	-- @AutorizaPedido
		ELSE
			SET @Result = 3		-- se asume para usuarios tipo SAC o tipo postulante
	END	-- @RolID

	IF (@Result = 0)
		SET @Mensaje = 'Usuario No Existe'
	ELSE IF (@Result = 1)
		SET @Mensaje = 'Usuario No es del Portal'
	ELSE IF (@Result = 2)
		SET @Mensaje = 'No estás autorizada para pasar pedido'
	ELSE IF (@Result = 3)
		SET @Mensaje = 'Usuario OK'
	ELSE IF (@Result = 4)
		SET @Mensaje = 'Usuario o Contraseña Incorrectas'

	INSERT INTO @TB (Result,Mensaje) VALUES (@Result,@Mensaje)

	RETURN

END
GO
USE [BelcorpColombia]
GO
ALTER FUNCTION [dbo].[fnGetAccesoUsuario]
(
	@PaisID INT,
	@CodigoUsuario VARCHAR(20),
	@CodigoConsultora VARCHAR(20),
	@TipoUsuario TINYINT,
	@RolID INT
)
RETURNS @TB TABLE(
	Result TINYINT,
	Mensaje VARCHAR(100)
)
AS

BEGIN
	DECLARE @Result TINYINT
	DECLARE @Mensaje VARCHAR(100)
	DECLARE @PaisLbel TABLE (Id INT)
	DECLARE @TablaLogicaDatos TABLE (Id INT, Codigo VARCHAR(10))

	SET @Result = 0
	INSERT INTO @PaisLbel(Id) VALUES (1),(5),(9),(10)

	INSERT INTO @TablaLogicaDatos 
	SELECT TablaLogicaId, Codigo 
	FROM TablaLogicaDatos WHERE TablaLogicaID IN (12,18,19)

	DECLARE @ZonaID INT
	DECLARE @RegionID INT
	DECLARE @ConsultoraID INT
	DECLARE @IdEstadoActividad INT
	DECLARE @AutorizaPedido CHAR(1)
	DECLARE @UltimaCampanaFacturada INT

	IF (@TipoUsuario = 1)
	BEGIN
		SELECT	
			@ZonaID = ISNULL(ZonaID,0),
			@RegionID = ISNULL(RegionID,0),
			@ConsultoraID = ISNULL(ConsultoraID,0),
			@IdEstadoActividad = ISNULL(IdEstadoActividad,-1),
			@AutorizaPedido = ISNULL(AutorizaPedido,''),
			@UltimaCampanaFacturada = ISNULL(UltimaCampanaFacturada,0)
		FROM ods.Consultora WITH(NOLOCK)
		WHERE Codigo = @CodigoConsultora
	END

	IF (@RolID != 0)
	BEGIN
		IF (@IdEstadoActividad = 7)
		BEGIN
			SET @Result = 2 --*/HD-4199 Se bloquean a las consultoras retiradas /*
		END
		ELSE IF (@AutorizaPedido != '')
		BEGIN
			IF (@IdEstadoActividad != -1)
			BEGIN
				-- validar si es pais Esika
				IF @PaisID NOT IN (SELECT Id FROM @PaisLbel)
				BEGIN		
					-- caso CH
					IF (@PaisID = 3 AND @IdEstadoActividad IN (SELECT Codigo FROM @TablaLogicaDatos WHERE Id = 18) )
					BEGIN
						DECLARE @CampaniaActual INT
						SET @CampaniaActual = ISNULL((SELECT TOP 1 CampaniaID FROM dbo.GetCampaniaPreLogin(@PaisID,@ZonaID,@RegionID,@ConsultoraID)),0)

						-- validar las campañas que no ha ingresado
						IF (LEN(@UltimaCampanaFacturada) = 6 AND LEN(@CampaniaActual) = 6)
						BEGIN
							DECLARE @ca VARCHAR(10)
							DECLARE @uc VARCHAR(10)

							SET @ca = SUBSTRING(CAST(@CampaniaActual AS VARCHAR),1,4)
							SET @uc = SUBSTRING(CAST(@UltimaCampanaFacturada AS VARCHAR),1,4)

							IF @ca != @uc
							BEGIN
								SET @ca = SUBSTRING(CAST(@CampaniaActual AS VARCHAR),5,2)
								SET @uc = SUBSTRING(CAST(@UltimaCampanaFacturada AS VARCHAR),5,2)
								SET @CampaniaActual = CAST(@uc AS INT) + CAST(@ca AS INT)
								SET @UltimaCampanaFacturada = CAST(@uc AS INT)
							END
						END

						IF (@UltimaCampanaFacturada != 0 AND @CampaniaActual - @UltimaCampanaFacturada > 3)
							SET @Result = 2
						ELSE
						BEGIN
							-- validar si autoriza pedido
							/******HD-3693********/
							--IF (@AutorizaPedido = '0')
							--	SET @Result = 2
							--ELSE
							--	SET @Result = 3
							SET @Result = 3
							/******HD-3693********/
						END
					END				
					ELSE
					BEGIN
						-- validar si autoriza pedido
						/******HD-3693********/
						--IF (@AutorizaPedido = '0')
						--	SET @Result = 2
						--ELSE
						--	SET @Result = 3
						SET @Result = 3
						/******HD-3693********/
					END
				END	-- pais Esika
				ELSE
				BEGIN
					-- validar si autoriza pedido
					/******HD-3693********/
					--IF (@AutorizaPedido = '0')
					--	SET @Result = 2
					--ELSE
					--	SET @Result = 3
					SET @Result = 3
					/******HD-3693********/
				END -- pais Lbel
			END	-- @IdEstadoActividad
			ELSE
				SET @Result = 3		-- se asume para usuarios tipo SAC o tipo postulante
		END	-- @AutorizaPedido
		ELSE
			SET @Result = 3		-- se asume para usuarios tipo SAC o tipo postulante
	END	-- @RolID

	IF (@Result = 0)
		SET @Mensaje = 'Usuario No Existe'
	ELSE IF (@Result = 1)
		SET @Mensaje = 'Usuario No es del Portal'
	ELSE IF (@Result = 2)
		SET @Mensaje = 'No estás autorizada para pasar pedido'
	ELSE IF (@Result = 3)
		SET @Mensaje = 'Usuario OK'
	ELSE IF (@Result = 4)
		SET @Mensaje = 'Usuario o Contraseña Incorrectas'

	INSERT INTO @TB (Result,Mensaje) VALUES (@Result,@Mensaje)

	RETURN

END
GO
USE [BelcorpCostaRica]
GO
ALTER FUNCTION [dbo].[fnGetAccesoUsuario]
(
	@PaisID INT,
	@CodigoUsuario VARCHAR(20),
	@CodigoConsultora VARCHAR(20),
	@TipoUsuario TINYINT,
	@RolID INT
)
RETURNS @TB TABLE(
	Result TINYINT,
	Mensaje VARCHAR(100)
)
AS

BEGIN
	DECLARE @Result TINYINT
	DECLARE @Mensaje VARCHAR(100)
	DECLARE @PaisLbel TABLE (Id INT)
	DECLARE @TablaLogicaDatos TABLE (Id INT, Codigo VARCHAR(10))

	SET @Result = 0
	INSERT INTO @PaisLbel(Id) VALUES (1),(5),(9),(10)

	INSERT INTO @TablaLogicaDatos 
	SELECT TablaLogicaId, Codigo 
	FROM TablaLogicaDatos WHERE TablaLogicaID IN (12,18,19)

	DECLARE @ZonaID INT
	DECLARE @RegionID INT
	DECLARE @ConsultoraID INT
	DECLARE @IdEstadoActividad INT
	DECLARE @AutorizaPedido CHAR(1)
	DECLARE @UltimaCampanaFacturada INT

	IF (@TipoUsuario = 1)
	BEGIN
		SELECT	
			@ZonaID = ISNULL(ZonaID,0),
			@RegionID = ISNULL(RegionID,0),
			@ConsultoraID = ISNULL(ConsultoraID,0),
			@IdEstadoActividad = ISNULL(IdEstadoActividad,-1),
			@AutorizaPedido = ISNULL(AutorizaPedido,''),
			@UltimaCampanaFacturada = ISNULL(UltimaCampanaFacturada,0)
		FROM ods.Consultora WITH(NOLOCK)
		WHERE Codigo = @CodigoConsultora
	END

	IF (@RolID != 0)
	BEGIN
		IF (@IdEstadoActividad = 7)
		BEGIN
			SET @Result = 2 --*/HD-4199 Se bloquean a las consultoras retiradas /*
		END
		ELSE IF (@AutorizaPedido != '')
		BEGIN
			IF (@IdEstadoActividad != -1)
			BEGIN
				-- validar si es pais Esika
				IF @PaisID NOT IN (SELECT Id FROM @PaisLbel)
				BEGIN		
					-- caso CH
					IF (@PaisID = 3 AND @IdEstadoActividad IN (SELECT Codigo FROM @TablaLogicaDatos WHERE Id = 18) )
					BEGIN
						DECLARE @CampaniaActual INT
						SET @CampaniaActual = ISNULL((SELECT TOP 1 CampaniaID FROM dbo.GetCampaniaPreLogin(@PaisID,@ZonaID,@RegionID,@ConsultoraID)),0)

						-- validar las campañas que no ha ingresado
						IF (LEN(@UltimaCampanaFacturada) = 6 AND LEN(@CampaniaActual) = 6)
						BEGIN
							DECLARE @ca VARCHAR(10)
							DECLARE @uc VARCHAR(10)

							SET @ca = SUBSTRING(CAST(@CampaniaActual AS VARCHAR),1,4)
							SET @uc = SUBSTRING(CAST(@UltimaCampanaFacturada AS VARCHAR),1,4)

							IF @ca != @uc
							BEGIN
								SET @ca = SUBSTRING(CAST(@CampaniaActual AS VARCHAR),5,2)
								SET @uc = SUBSTRING(CAST(@UltimaCampanaFacturada AS VARCHAR),5,2)
								SET @CampaniaActual = CAST(@uc AS INT) + CAST(@ca AS INT)
								SET @UltimaCampanaFacturada = CAST(@uc AS INT)
							END
						END

						IF (@UltimaCampanaFacturada != 0 AND @CampaniaActual - @UltimaCampanaFacturada > 3)
							SET @Result = 2
						ELSE
						BEGIN
							-- validar si autoriza pedido
							/******HD-3693********/
							--IF (@AutorizaPedido = '0')
							--	SET @Result = 2
							--ELSE
							--	SET @Result = 3
							SET @Result = 3
							/******HD-3693********/
						END
					END				
					ELSE
					BEGIN
						-- validar si autoriza pedido
						/******HD-3693********/
						--IF (@AutorizaPedido = '0')
						--	SET @Result = 2
						--ELSE
						--	SET @Result = 3
						SET @Result = 3
						/******HD-3693********/
					END
				END	-- pais Esika
				ELSE
				BEGIN
					-- validar si autoriza pedido
					/******HD-3693********/
					--IF (@AutorizaPedido = '0')
					--	SET @Result = 2
					--ELSE
					--	SET @Result = 3
					SET @Result = 3
					/******HD-3693********/
				END -- pais Lbel
			END	-- @IdEstadoActividad
			ELSE
				SET @Result = 3		-- se asume para usuarios tipo SAC o tipo postulante
		END	-- @AutorizaPedido
		ELSE
			SET @Result = 3		-- se asume para usuarios tipo SAC o tipo postulante
	END	-- @RolID

	IF (@Result = 0)
		SET @Mensaje = 'Usuario No Existe'
	ELSE IF (@Result = 1)
		SET @Mensaje = 'Usuario No es del Portal'
	ELSE IF (@Result = 2)
		SET @Mensaje = 'No estás autorizada para pasar pedido'
	ELSE IF (@Result = 3)
		SET @Mensaje = 'Usuario OK'
	ELSE IF (@Result = 4)
		SET @Mensaje = 'Usuario o Contraseña Incorrectas'

	INSERT INTO @TB (Result,Mensaje) VALUES (@Result,@Mensaje)

	RETURN

END
GO
USE [BelcorpDominicana]
GO
ALTER FUNCTION [dbo].[fnGetAccesoUsuario]
(
	@PaisID INT,
	@CodigoUsuario VARCHAR(20),
	@CodigoConsultora VARCHAR(20),
	@TipoUsuario TINYINT,
	@RolID INT
)
RETURNS @TB TABLE(
	Result TINYINT,
	Mensaje VARCHAR(100)
)
AS

BEGIN
	DECLARE @Result TINYINT
	DECLARE @Mensaje VARCHAR(100)
	DECLARE @PaisLbel TABLE (Id INT)
	DECLARE @TablaLogicaDatos TABLE (Id INT, Codigo VARCHAR(10))

	SET @Result = 0
	INSERT INTO @PaisLbel(Id) VALUES (1),(5),(9),(10)

	INSERT INTO @TablaLogicaDatos 
	SELECT TablaLogicaId, Codigo 
	FROM TablaLogicaDatos WHERE TablaLogicaID IN (12,18,19)

	DECLARE @ZonaID INT
	DECLARE @RegionID INT
	DECLARE @ConsultoraID INT
	DECLARE @IdEstadoActividad INT
	DECLARE @AutorizaPedido CHAR(1)
	DECLARE @UltimaCampanaFacturada INT

	IF (@TipoUsuario = 1)
	BEGIN
		SELECT	
			@ZonaID = ISNULL(ZonaID,0),
			@RegionID = ISNULL(RegionID,0),
			@ConsultoraID = ISNULL(ConsultoraID,0),
			@IdEstadoActividad = ISNULL(IdEstadoActividad,-1),
			@AutorizaPedido = ISNULL(AutorizaPedido,''),
			@UltimaCampanaFacturada = ISNULL(UltimaCampanaFacturada,0)
		FROM ods.Consultora WITH(NOLOCK)
		WHERE Codigo = @CodigoConsultora
	END

	IF (@RolID != 0)
	BEGIN
		IF (@IdEstadoActividad = 7)
		BEGIN
			SET @Result = 2 --*/HD-4199 Se bloquean a las consultoras retiradas /*
		END
		ELSE IF (@AutorizaPedido != '')
		BEGIN
			IF (@IdEstadoActividad != -1)
			BEGIN
				-- validar si es pais Esika
				IF @PaisID NOT IN (SELECT Id FROM @PaisLbel)
				BEGIN		
					-- caso CH
					IF (@PaisID = 3 AND @IdEstadoActividad IN (SELECT Codigo FROM @TablaLogicaDatos WHERE Id = 18) )
					BEGIN
						DECLARE @CampaniaActual INT
						SET @CampaniaActual = ISNULL((SELECT TOP 1 CampaniaID FROM dbo.GetCampaniaPreLogin(@PaisID,@ZonaID,@RegionID,@ConsultoraID)),0)

						-- validar las campañas que no ha ingresado
						IF (LEN(@UltimaCampanaFacturada) = 6 AND LEN(@CampaniaActual) = 6)
						BEGIN
							DECLARE @ca VARCHAR(10)
							DECLARE @uc VARCHAR(10)

							SET @ca = SUBSTRING(CAST(@CampaniaActual AS VARCHAR),1,4)
							SET @uc = SUBSTRING(CAST(@UltimaCampanaFacturada AS VARCHAR),1,4)

							IF @ca != @uc
							BEGIN
								SET @ca = SUBSTRING(CAST(@CampaniaActual AS VARCHAR),5,2)
								SET @uc = SUBSTRING(CAST(@UltimaCampanaFacturada AS VARCHAR),5,2)
								SET @CampaniaActual = CAST(@uc AS INT) + CAST(@ca AS INT)
								SET @UltimaCampanaFacturada = CAST(@uc AS INT)
							END
						END

						IF (@UltimaCampanaFacturada != 0 AND @CampaniaActual - @UltimaCampanaFacturada > 3)
							SET @Result = 2
						ELSE
						BEGIN
							-- validar si autoriza pedido
							/******HD-3693********/
							--IF (@AutorizaPedido = '0')
							--	SET @Result = 2
							--ELSE
							--	SET @Result = 3
							SET @Result = 3
							/******HD-3693********/
						END
					END				
					ELSE
					BEGIN
						-- validar si autoriza pedido
						/******HD-3693********/
						--IF (@AutorizaPedido = '0')
						--	SET @Result = 2
						--ELSE
						--	SET @Result = 3
						SET @Result = 3
						/******HD-3693********/
					END
				END	-- pais Esika
				ELSE
				BEGIN
					-- validar si autoriza pedido
					/******HD-3693********/
					--IF (@AutorizaPedido = '0')
					--	SET @Result = 2
					--ELSE
					--	SET @Result = 3
					SET @Result = 3
					/******HD-3693********/
				END -- pais Lbel
			END	-- @IdEstadoActividad
			ELSE
				SET @Result = 3		-- se asume para usuarios tipo SAC o tipo postulante
		END	-- @AutorizaPedido
		ELSE
			SET @Result = 3		-- se asume para usuarios tipo SAC o tipo postulante
	END	-- @RolID

	IF (@Result = 0)
		SET @Mensaje = 'Usuario No Existe'
	ELSE IF (@Result = 1)
		SET @Mensaje = 'Usuario No es del Portal'
	ELSE IF (@Result = 2)
		SET @Mensaje = 'No estás autorizada para pasar pedido'
	ELSE IF (@Result = 3)
		SET @Mensaje = 'Usuario OK'
	ELSE IF (@Result = 4)
		SET @Mensaje = 'Usuario o Contraseña Incorrectas'

	INSERT INTO @TB (Result,Mensaje) VALUES (@Result,@Mensaje)

	RETURN

END
GO
USE [BelcorpEcuador]
GO
ALTER FUNCTION [dbo].[fnGetAccesoUsuario]
(
	@PaisID INT,
	@CodigoUsuario VARCHAR(20),
	@CodigoConsultora VARCHAR(20),
	@TipoUsuario TINYINT,
	@RolID INT
)
RETURNS @TB TABLE(
	Result TINYINT,
	Mensaje VARCHAR(100)
)
AS

BEGIN
	DECLARE @Result TINYINT
	DECLARE @Mensaje VARCHAR(100)
	DECLARE @PaisLbel TABLE (Id INT)
	DECLARE @TablaLogicaDatos TABLE (Id INT, Codigo VARCHAR(10))

	SET @Result = 0
	INSERT INTO @PaisLbel(Id) VALUES (1),(5),(9),(10)

	INSERT INTO @TablaLogicaDatos 
	SELECT TablaLogicaId, Codigo 
	FROM TablaLogicaDatos WHERE TablaLogicaID IN (12,18,19)

	DECLARE @ZonaID INT
	DECLARE @RegionID INT
	DECLARE @ConsultoraID INT
	DECLARE @IdEstadoActividad INT
	DECLARE @AutorizaPedido CHAR(1)
	DECLARE @UltimaCampanaFacturada INT

	IF (@TipoUsuario = 1)
	BEGIN
		SELECT	
			@ZonaID = ISNULL(ZonaID,0),
			@RegionID = ISNULL(RegionID,0),
			@ConsultoraID = ISNULL(ConsultoraID,0),
			@IdEstadoActividad = ISNULL(IdEstadoActividad,-1),
			@AutorizaPedido = ISNULL(AutorizaPedido,''),
			@UltimaCampanaFacturada = ISNULL(UltimaCampanaFacturada,0)
		FROM ods.Consultora WITH(NOLOCK)
		WHERE Codigo = @CodigoConsultora
	END

	IF (@RolID != 0)
	BEGIN
		IF (@IdEstadoActividad = 7)
		BEGIN
			SET @Result = 2 --*/HD-4199 Se bloquean a las consultoras retiradas /*
		END
		ELSE IF (@AutorizaPedido != '')
		BEGIN
			IF (@IdEstadoActividad != -1)
			BEGIN
				-- validar si es pais Esika
				IF @PaisID NOT IN (SELECT Id FROM @PaisLbel)
				BEGIN		
					-- caso CH
					IF (@PaisID = 3 AND @IdEstadoActividad IN (SELECT Codigo FROM @TablaLogicaDatos WHERE Id = 18) )
					BEGIN
						DECLARE @CampaniaActual INT
						SET @CampaniaActual = ISNULL((SELECT TOP 1 CampaniaID FROM dbo.GetCampaniaPreLogin(@PaisID,@ZonaID,@RegionID,@ConsultoraID)),0)

						-- validar las campañas que no ha ingresado
						IF (LEN(@UltimaCampanaFacturada) = 6 AND LEN(@CampaniaActual) = 6)
						BEGIN
							DECLARE @ca VARCHAR(10)
							DECLARE @uc VARCHAR(10)

							SET @ca = SUBSTRING(CAST(@CampaniaActual AS VARCHAR),1,4)
							SET @uc = SUBSTRING(CAST(@UltimaCampanaFacturada AS VARCHAR),1,4)

							IF @ca != @uc
							BEGIN
								SET @ca = SUBSTRING(CAST(@CampaniaActual AS VARCHAR),5,2)
								SET @uc = SUBSTRING(CAST(@UltimaCampanaFacturada AS VARCHAR),5,2)
								SET @CampaniaActual = CAST(@uc AS INT) + CAST(@ca AS INT)
								SET @UltimaCampanaFacturada = CAST(@uc AS INT)
							END
						END

						IF (@UltimaCampanaFacturada != 0 AND @CampaniaActual - @UltimaCampanaFacturada > 3)
							SET @Result = 2
						ELSE
						BEGIN
							-- validar si autoriza pedido
							/******HD-3693********/
							--IF (@AutorizaPedido = '0')
							--	SET @Result = 2
							--ELSE
							--	SET @Result = 3
							SET @Result = 3
							/******HD-3693********/
						END
					END				
					ELSE
					BEGIN
						-- validar si autoriza pedido
						/******HD-3693********/
						--IF (@AutorizaPedido = '0')
						--	SET @Result = 2
						--ELSE
						--	SET @Result = 3
						SET @Result = 3
						/******HD-3693********/
					END
				END	-- pais Esika
				ELSE
				BEGIN
					-- validar si autoriza pedido
					/******HD-3693********/
					--IF (@AutorizaPedido = '0')
					--	SET @Result = 2
					--ELSE
					--	SET @Result = 3
					SET @Result = 3
					/******HD-3693********/
				END -- pais Lbel
			END	-- @IdEstadoActividad
			ELSE
				SET @Result = 3		-- se asume para usuarios tipo SAC o tipo postulante
		END	-- @AutorizaPedido
		ELSE
			SET @Result = 3		-- se asume para usuarios tipo SAC o tipo postulante
	END	-- @RolID

	IF (@Result = 0)
		SET @Mensaje = 'Usuario No Existe'
	ELSE IF (@Result = 1)
		SET @Mensaje = 'Usuario No es del Portal'
	ELSE IF (@Result = 2)
		SET @Mensaje = 'No estás autorizada para pasar pedido'
	ELSE IF (@Result = 3)
		SET @Mensaje = 'Usuario OK'
	ELSE IF (@Result = 4)
		SET @Mensaje = 'Usuario o Contraseña Incorrectas'

	INSERT INTO @TB (Result,Mensaje) VALUES (@Result,@Mensaje)

	RETURN

END
GO
USE [BelcorpGuatemala]
GO
ALTER FUNCTION [dbo].[fnGetAccesoUsuario]
(
	@PaisID INT,
	@CodigoUsuario VARCHAR(20),
	@CodigoConsultora VARCHAR(20),
	@TipoUsuario TINYINT,
	@RolID INT
)
RETURNS @TB TABLE(
	Result TINYINT,
	Mensaje VARCHAR(100)
)
AS

BEGIN
	DECLARE @Result TINYINT
	DECLARE @Mensaje VARCHAR(100)
	DECLARE @PaisLbel TABLE (Id INT)
	DECLARE @TablaLogicaDatos TABLE (Id INT, Codigo VARCHAR(10))

	SET @Result = 0
	INSERT INTO @PaisLbel(Id) VALUES (1),(5),(9),(10)

	INSERT INTO @TablaLogicaDatos 
	SELECT TablaLogicaId, Codigo 
	FROM TablaLogicaDatos WHERE TablaLogicaID IN (12,18,19)

	DECLARE @ZonaID INT
	DECLARE @RegionID INT
	DECLARE @ConsultoraID INT
	DECLARE @IdEstadoActividad INT
	DECLARE @AutorizaPedido CHAR(1)
	DECLARE @UltimaCampanaFacturada INT

	IF (@TipoUsuario = 1)
	BEGIN
		SELECT	
			@ZonaID = ISNULL(ZonaID,0),
			@RegionID = ISNULL(RegionID,0),
			@ConsultoraID = ISNULL(ConsultoraID,0),
			@IdEstadoActividad = ISNULL(IdEstadoActividad,-1),
			@AutorizaPedido = ISNULL(AutorizaPedido,''),
			@UltimaCampanaFacturada = ISNULL(UltimaCampanaFacturada,0)
		FROM ods.Consultora WITH(NOLOCK)
		WHERE Codigo = @CodigoConsultora
	END

	IF (@RolID != 0)
	BEGIN
		IF (@IdEstadoActividad = 7)
		BEGIN
			SET @Result = 2 --*/HD-4199 Se bloquean a las consultoras retiradas /*
		END
		ELSE IF (@AutorizaPedido != '')
		BEGIN
			IF (@IdEstadoActividad != -1)
			BEGIN
				-- validar si es pais Esika
				IF @PaisID NOT IN (SELECT Id FROM @PaisLbel)
				BEGIN		
					-- caso CH
					IF (@PaisID = 3 AND @IdEstadoActividad IN (SELECT Codigo FROM @TablaLogicaDatos WHERE Id = 18) )
					BEGIN
						DECLARE @CampaniaActual INT
						SET @CampaniaActual = ISNULL((SELECT TOP 1 CampaniaID FROM dbo.GetCampaniaPreLogin(@PaisID,@ZonaID,@RegionID,@ConsultoraID)),0)

						-- validar las campañas que no ha ingresado
						IF (LEN(@UltimaCampanaFacturada) = 6 AND LEN(@CampaniaActual) = 6)
						BEGIN
							DECLARE @ca VARCHAR(10)
							DECLARE @uc VARCHAR(10)

							SET @ca = SUBSTRING(CAST(@CampaniaActual AS VARCHAR),1,4)
							SET @uc = SUBSTRING(CAST(@UltimaCampanaFacturada AS VARCHAR),1,4)

							IF @ca != @uc
							BEGIN
								SET @ca = SUBSTRING(CAST(@CampaniaActual AS VARCHAR),5,2)
								SET @uc = SUBSTRING(CAST(@UltimaCampanaFacturada AS VARCHAR),5,2)
								SET @CampaniaActual = CAST(@uc AS INT) + CAST(@ca AS INT)
								SET @UltimaCampanaFacturada = CAST(@uc AS INT)
							END
						END

						IF (@UltimaCampanaFacturada != 0 AND @CampaniaActual - @UltimaCampanaFacturada > 3)
							SET @Result = 2
						ELSE
						BEGIN
							-- validar si autoriza pedido
							/******HD-3693********/
							--IF (@AutorizaPedido = '0')
							--	SET @Result = 2
							--ELSE
							--	SET @Result = 3
							SET @Result = 3
							/******HD-3693********/
						END
					END				
					ELSE
					BEGIN
						-- validar si autoriza pedido
						/******HD-3693********/
						--IF (@AutorizaPedido = '0')
						--	SET @Result = 2
						--ELSE
						--	SET @Result = 3
						SET @Result = 3
						/******HD-3693********/
					END
				END	-- pais Esika
				ELSE
				BEGIN
					-- validar si autoriza pedido
					/******HD-3693********/
					--IF (@AutorizaPedido = '0')
					--	SET @Result = 2
					--ELSE
					--	SET @Result = 3
					SET @Result = 3
					/******HD-3693********/
				END -- pais Lbel
			END	-- @IdEstadoActividad
			ELSE
				SET @Result = 3		-- se asume para usuarios tipo SAC o tipo postulante
		END	-- @AutorizaPedido
		ELSE
			SET @Result = 3		-- se asume para usuarios tipo SAC o tipo postulante
	END	-- @RolID

	IF (@Result = 0)
		SET @Mensaje = 'Usuario No Existe'
	ELSE IF (@Result = 1)
		SET @Mensaje = 'Usuario No es del Portal'
	ELSE IF (@Result = 2)
		SET @Mensaje = 'No estás autorizada para pasar pedido'
	ELSE IF (@Result = 3)
		SET @Mensaje = 'Usuario OK'
	ELSE IF (@Result = 4)
		SET @Mensaje = 'Usuario o Contraseña Incorrectas'

	INSERT INTO @TB (Result,Mensaje) VALUES (@Result,@Mensaje)

	RETURN

END
GO
USE [BelcorpMexico]
GO
ALTER FUNCTION [dbo].[fnGetAccesoUsuario]
(
	@PaisID INT,
	@CodigoUsuario VARCHAR(20),
	@CodigoConsultora VARCHAR(20),
	@TipoUsuario TINYINT,
	@RolID INT
)
RETURNS @TB TABLE(
	Result TINYINT,
	Mensaje VARCHAR(100)
)
AS

BEGIN
	DECLARE @Result TINYINT
	DECLARE @Mensaje VARCHAR(100)
	DECLARE @PaisLbel TABLE (Id INT)
	DECLARE @TablaLogicaDatos TABLE (Id INT, Codigo VARCHAR(10))

	SET @Result = 0
	INSERT INTO @PaisLbel(Id) VALUES (1),(5),(9),(10)

	INSERT INTO @TablaLogicaDatos 
	SELECT TablaLogicaId, Codigo 
	FROM TablaLogicaDatos WHERE TablaLogicaID IN (12,18,19)

	DECLARE @ZonaID INT
	DECLARE @RegionID INT
	DECLARE @ConsultoraID INT
	DECLARE @IdEstadoActividad INT
	DECLARE @AutorizaPedido CHAR(1)
	DECLARE @UltimaCampanaFacturada INT

	IF (@TipoUsuario = 1)
	BEGIN
		SELECT	
			@ZonaID = ISNULL(ZonaID,0),
			@RegionID = ISNULL(RegionID,0),
			@ConsultoraID = ISNULL(ConsultoraID,0),
			@IdEstadoActividad = ISNULL(IdEstadoActividad,-1),
			@AutorizaPedido = ISNULL(AutorizaPedido,''),
			@UltimaCampanaFacturada = ISNULL(UltimaCampanaFacturada,0)
		FROM ods.Consultora WITH(NOLOCK)
		WHERE Codigo = @CodigoConsultora
	END

	IF (@RolID != 0)
	BEGIN
		IF (@IdEstadoActividad = 7)
		BEGIN
			SET @Result = 2 --*/HD-4199 Se bloquean a las consultoras retiradas /*
		END
		ELSE IF (@AutorizaPedido != '')
		BEGIN
			IF (@IdEstadoActividad != -1)
			BEGIN
				-- validar si es pais Esika
				IF @PaisID NOT IN (SELECT Id FROM @PaisLbel)
				BEGIN		
					-- caso CH
					IF (@PaisID = 3 AND @IdEstadoActividad IN (SELECT Codigo FROM @TablaLogicaDatos WHERE Id = 18) )
					BEGIN
						DECLARE @CampaniaActual INT
						SET @CampaniaActual = ISNULL((SELECT TOP 1 CampaniaID FROM dbo.GetCampaniaPreLogin(@PaisID,@ZonaID,@RegionID,@ConsultoraID)),0)

						-- validar las campañas que no ha ingresado
						IF (LEN(@UltimaCampanaFacturada) = 6 AND LEN(@CampaniaActual) = 6)
						BEGIN
							DECLARE @ca VARCHAR(10)
							DECLARE @uc VARCHAR(10)

							SET @ca = SUBSTRING(CAST(@CampaniaActual AS VARCHAR),1,4)
							SET @uc = SUBSTRING(CAST(@UltimaCampanaFacturada AS VARCHAR),1,4)

							IF @ca != @uc
							BEGIN
								SET @ca = SUBSTRING(CAST(@CampaniaActual AS VARCHAR),5,2)
								SET @uc = SUBSTRING(CAST(@UltimaCampanaFacturada AS VARCHAR),5,2)
								SET @CampaniaActual = CAST(@uc AS INT) + CAST(@ca AS INT)
								SET @UltimaCampanaFacturada = CAST(@uc AS INT)
							END
						END

						IF (@UltimaCampanaFacturada != 0 AND @CampaniaActual - @UltimaCampanaFacturada > 3)
							SET @Result = 2
						ELSE
						BEGIN
							-- validar si autoriza pedido
							/******HD-3693********/
							--IF (@AutorizaPedido = '0')
							--	SET @Result = 2
							--ELSE
							--	SET @Result = 3
							SET @Result = 3
							/******HD-3693********/
						END
					END				
					ELSE
					BEGIN
						-- validar si autoriza pedido
						/******HD-3693********/
						--IF (@AutorizaPedido = '0')
						--	SET @Result = 2
						--ELSE
						--	SET @Result = 3
						SET @Result = 3
						/******HD-3693********/
					END
				END	-- pais Esika
				ELSE
				BEGIN
					-- validar si autoriza pedido
					/******HD-3693********/
					--IF (@AutorizaPedido = '0')
					--	SET @Result = 2
					--ELSE
					--	SET @Result = 3
					SET @Result = 3
					/******HD-3693********/
				END -- pais Lbel
			END	-- @IdEstadoActividad
			ELSE
				SET @Result = 3		-- se asume para usuarios tipo SAC o tipo postulante
		END	-- @AutorizaPedido
		ELSE
			SET @Result = 3		-- se asume para usuarios tipo SAC o tipo postulante
	END	-- @RolID

	IF (@Result = 0)
		SET @Mensaje = 'Usuario No Existe'
	ELSE IF (@Result = 1)
		SET @Mensaje = 'Usuario No es del Portal'
	ELSE IF (@Result = 2)
		SET @Mensaje = 'No estás autorizada para pasar pedido'
	ELSE IF (@Result = 3)
		SET @Mensaje = 'Usuario OK'
	ELSE IF (@Result = 4)
		SET @Mensaje = 'Usuario o Contraseña Incorrectas'

	INSERT INTO @TB (Result,Mensaje) VALUES (@Result,@Mensaje)

	RETURN

END
GO
USE [BelcorpPanama]
GO
ALTER FUNCTION [dbo].[fnGetAccesoUsuario]
(
	@PaisID INT,
	@CodigoUsuario VARCHAR(20),
	@CodigoConsultora VARCHAR(20),
	@TipoUsuario TINYINT,
	@RolID INT
)
RETURNS @TB TABLE(
	Result TINYINT,
	Mensaje VARCHAR(100)
)
AS

BEGIN
	DECLARE @Result TINYINT
	DECLARE @Mensaje VARCHAR(100)
	DECLARE @PaisLbel TABLE (Id INT)
	DECLARE @TablaLogicaDatos TABLE (Id INT, Codigo VARCHAR(10))

	SET @Result = 0
	INSERT INTO @PaisLbel(Id) VALUES (1),(5),(9),(10)

	INSERT INTO @TablaLogicaDatos 
	SELECT TablaLogicaId, Codigo 
	FROM TablaLogicaDatos WHERE TablaLogicaID IN (12,18,19)

	DECLARE @ZonaID INT
	DECLARE @RegionID INT
	DECLARE @ConsultoraID INT
	DECLARE @IdEstadoActividad INT
	DECLARE @AutorizaPedido CHAR(1)
	DECLARE @UltimaCampanaFacturada INT

	IF (@TipoUsuario = 1)
	BEGIN
		SELECT	
			@ZonaID = ISNULL(ZonaID,0),
			@RegionID = ISNULL(RegionID,0),
			@ConsultoraID = ISNULL(ConsultoraID,0),
			@IdEstadoActividad = ISNULL(IdEstadoActividad,-1),
			@AutorizaPedido = ISNULL(AutorizaPedido,''),
			@UltimaCampanaFacturada = ISNULL(UltimaCampanaFacturada,0)
		FROM ods.Consultora WITH(NOLOCK)
		WHERE Codigo = @CodigoConsultora
	END

	IF (@RolID != 0)
	BEGIN
		IF (@IdEstadoActividad = 7)
		BEGIN
			SET @Result = 2 --*/HD-4199 Se bloquean a las consultoras retiradas /*
		END
		ELSE IF (@AutorizaPedido != '')
		BEGIN
			IF (@IdEstadoActividad != -1)
			BEGIN
				-- validar si es pais Esika
				IF @PaisID NOT IN (SELECT Id FROM @PaisLbel)
				BEGIN		
					-- caso CH
					IF (@PaisID = 3 AND @IdEstadoActividad IN (SELECT Codigo FROM @TablaLogicaDatos WHERE Id = 18) )
					BEGIN
						DECLARE @CampaniaActual INT
						SET @CampaniaActual = ISNULL((SELECT TOP 1 CampaniaID FROM dbo.GetCampaniaPreLogin(@PaisID,@ZonaID,@RegionID,@ConsultoraID)),0)

						-- validar las campañas que no ha ingresado
						IF (LEN(@UltimaCampanaFacturada) = 6 AND LEN(@CampaniaActual) = 6)
						BEGIN
							DECLARE @ca VARCHAR(10)
							DECLARE @uc VARCHAR(10)

							SET @ca = SUBSTRING(CAST(@CampaniaActual AS VARCHAR),1,4)
							SET @uc = SUBSTRING(CAST(@UltimaCampanaFacturada AS VARCHAR),1,4)

							IF @ca != @uc
							BEGIN
								SET @ca = SUBSTRING(CAST(@CampaniaActual AS VARCHAR),5,2)
								SET @uc = SUBSTRING(CAST(@UltimaCampanaFacturada AS VARCHAR),5,2)
								SET @CampaniaActual = CAST(@uc AS INT) + CAST(@ca AS INT)
								SET @UltimaCampanaFacturada = CAST(@uc AS INT)
							END
						END

						IF (@UltimaCampanaFacturada != 0 AND @CampaniaActual - @UltimaCampanaFacturada > 3)
							SET @Result = 2
						ELSE
						BEGIN
							-- validar si autoriza pedido
							/******HD-3693********/
							--IF (@AutorizaPedido = '0')
							--	SET @Result = 2
							--ELSE
							--	SET @Result = 3
							SET @Result = 3
							/******HD-3693********/
						END
					END				
					ELSE
					BEGIN
						-- validar si autoriza pedido
						/******HD-3693********/
						--IF (@AutorizaPedido = '0')
						--	SET @Result = 2
						--ELSE
						--	SET @Result = 3
						SET @Result = 3
						/******HD-3693********/
					END
				END	-- pais Esika
				ELSE
				BEGIN
					-- validar si autoriza pedido
					/******HD-3693********/
					--IF (@AutorizaPedido = '0')
					--	SET @Result = 2
					--ELSE
					--	SET @Result = 3
					SET @Result = 3
					/******HD-3693********/
				END -- pais Lbel
			END	-- @IdEstadoActividad
			ELSE
				SET @Result = 3		-- se asume para usuarios tipo SAC o tipo postulante
		END	-- @AutorizaPedido
		ELSE
			SET @Result = 3		-- se asume para usuarios tipo SAC o tipo postulante
	END	-- @RolID

	IF (@Result = 0)
		SET @Mensaje = 'Usuario No Existe'
	ELSE IF (@Result = 1)
		SET @Mensaje = 'Usuario No es del Portal'
	ELSE IF (@Result = 2)
		SET @Mensaje = 'No estás autorizada para pasar pedido'
	ELSE IF (@Result = 3)
		SET @Mensaje = 'Usuario OK'
	ELSE IF (@Result = 4)
		SET @Mensaje = 'Usuario o Contraseña Incorrectas'

	INSERT INTO @TB (Result,Mensaje) VALUES (@Result,@Mensaje)

	RETURN

END
GO
USE [BelcorpPeru]
GO
ALTER FUNCTION [dbo].[fnGetAccesoUsuario]
(
	@PaisID INT,
	@CodigoUsuario VARCHAR(20),
	@CodigoConsultora VARCHAR(20),
	@TipoUsuario TINYINT,
	@RolID INT
)
RETURNS @TB TABLE(
	Result TINYINT,
	Mensaje VARCHAR(100)
)
AS

BEGIN
	DECLARE @Result TINYINT
	DECLARE @Mensaje VARCHAR(100)
	DECLARE @PaisLbel TABLE (Id INT)
	DECLARE @TablaLogicaDatos TABLE (Id INT, Codigo VARCHAR(10))

	SET @Result = 0
	INSERT INTO @PaisLbel(Id) VALUES (1),(5),(9),(10)

	INSERT INTO @TablaLogicaDatos 
	SELECT TablaLogicaId, Codigo 
	FROM TablaLogicaDatos WHERE TablaLogicaID IN (12,18,19)

	DECLARE @ZonaID INT
	DECLARE @RegionID INT
	DECLARE @ConsultoraID INT
	DECLARE @IdEstadoActividad INT
	DECLARE @AutorizaPedido CHAR(1)
	DECLARE @UltimaCampanaFacturada INT

	IF (@TipoUsuario = 1)
	BEGIN
		SELECT	
			@ZonaID = ISNULL(ZonaID,0),
			@RegionID = ISNULL(RegionID,0),
			@ConsultoraID = ISNULL(ConsultoraID,0),
			@IdEstadoActividad = ISNULL(IdEstadoActividad,-1),
			@AutorizaPedido = ISNULL(AutorizaPedido,''),
			@UltimaCampanaFacturada = ISNULL(UltimaCampanaFacturada,0)
		FROM ods.Consultora WITH(NOLOCK)
		WHERE Codigo = @CodigoConsultora
	END

	IF (@RolID != 0)
	BEGIN
		IF (@IdEstadoActividad = 7)
		BEGIN
			SET @Result = 2 --*/HD-4199 Se bloquean a las consultoras retiradas /*
		END
		ELSE IF (@AutorizaPedido != '')
		BEGIN
			IF (@IdEstadoActividad != -1)
			BEGIN
				-- validar si es pais Esika
				IF @PaisID NOT IN (SELECT Id FROM @PaisLbel)
				BEGIN		
					-- caso CH
					IF (@PaisID = 3 AND @IdEstadoActividad IN (SELECT Codigo FROM @TablaLogicaDatos WHERE Id = 18) )
					BEGIN
						DECLARE @CampaniaActual INT
						SET @CampaniaActual = ISNULL((SELECT TOP 1 CampaniaID FROM dbo.GetCampaniaPreLogin(@PaisID,@ZonaID,@RegionID,@ConsultoraID)),0)

						-- validar las campañas que no ha ingresado
						IF (LEN(@UltimaCampanaFacturada) = 6 AND LEN(@CampaniaActual) = 6)
						BEGIN
							DECLARE @ca VARCHAR(10)
							DECLARE @uc VARCHAR(10)

							SET @ca = SUBSTRING(CAST(@CampaniaActual AS VARCHAR),1,4)
							SET @uc = SUBSTRING(CAST(@UltimaCampanaFacturada AS VARCHAR),1,4)

							IF @ca != @uc
							BEGIN
								SET @ca = SUBSTRING(CAST(@CampaniaActual AS VARCHAR),5,2)
								SET @uc = SUBSTRING(CAST(@UltimaCampanaFacturada AS VARCHAR),5,2)
								SET @CampaniaActual = CAST(@uc AS INT) + CAST(@ca AS INT)
								SET @UltimaCampanaFacturada = CAST(@uc AS INT)
							END
						END

						IF (@UltimaCampanaFacturada != 0 AND @CampaniaActual - @UltimaCampanaFacturada > 3)
							SET @Result = 2
						ELSE
						BEGIN
							-- validar si autoriza pedido
							/******HD-3693********/
							--IF (@AutorizaPedido = '0')
							--	SET @Result = 2
							--ELSE
							--	SET @Result = 3
							SET @Result = 3
							/******HD-3693********/
						END
					END				
					ELSE
					BEGIN
						-- validar si autoriza pedido
						/******HD-3693********/
						--IF (@AutorizaPedido = '0')
						--	SET @Result = 2
						--ELSE
						--	SET @Result = 3
						SET @Result = 3
						/******HD-3693********/
					END
				END	-- pais Esika
				ELSE
				BEGIN
					-- validar si autoriza pedido
					/******HD-3693********/
					--IF (@AutorizaPedido = '0')
					--	SET @Result = 2
					--ELSE
					--	SET @Result = 3
					SET @Result = 3
					/******HD-3693********/

				END -- pais Lbel
			END	-- @IdEstadoActividad
			ELSE
				SET @Result = 3		-- se asume para usuarios tipo SAC o tipo postulante
		END	-- @AutorizaPedido
		ELSE
			SET @Result = 3		-- se asume para usuarios tipo SAC o tipo postulante
	END	-- @RolID

	IF (@Result = 0)
		SET @Mensaje = 'Usuario No Existe'
	ELSE IF (@Result = 1)
		SET @Mensaje = 'Usuario No es del Portal'
	ELSE IF (@Result = 2)
		SET @Mensaje = 'No estás autorizada para pasar pedido'
	ELSE IF (@Result = 3)
		SET @Mensaje = 'Usuario OK'
	ELSE IF (@Result = 4)
		SET @Mensaje = 'Usuario o Contraseña Incorrectas'

	INSERT INTO @TB (Result,Mensaje) VALUES (@Result,@Mensaje)

	RETURN

END
GO
USE [BelcorpPuertoRico]
GO
ALTER FUNCTION [dbo].[fnGetAccesoUsuario]
(
	@PaisID INT,
	@CodigoUsuario VARCHAR(20),
	@CodigoConsultora VARCHAR(20),
	@TipoUsuario TINYINT,
	@RolID INT
)
RETURNS @TB TABLE(
	Result TINYINT,
	Mensaje VARCHAR(100)
)
AS

BEGIN
	DECLARE @Result TINYINT
	DECLARE @Mensaje VARCHAR(100)
	DECLARE @PaisLbel TABLE (Id INT)
	DECLARE @TablaLogicaDatos TABLE (Id INT, Codigo VARCHAR(10))

	SET @Result = 0
	INSERT INTO @PaisLbel(Id) VALUES (1),(5),(9),(10)

	INSERT INTO @TablaLogicaDatos 
	SELECT TablaLogicaId, Codigo 
	FROM TablaLogicaDatos WHERE TablaLogicaID IN (12,18,19)

	DECLARE @ZonaID INT
	DECLARE @RegionID INT
	DECLARE @ConsultoraID INT
	DECLARE @IdEstadoActividad INT
	DECLARE @AutorizaPedido CHAR(1)
	DECLARE @UltimaCampanaFacturada INT

	IF (@TipoUsuario = 1)
	BEGIN
		SELECT	
			@ZonaID = ISNULL(ZonaID,0),
			@RegionID = ISNULL(RegionID,0),
			@ConsultoraID = ISNULL(ConsultoraID,0),
			@IdEstadoActividad = ISNULL(IdEstadoActividad,-1),
			@AutorizaPedido = ISNULL(AutorizaPedido,''),
			@UltimaCampanaFacturada = ISNULL(UltimaCampanaFacturada,0)
		FROM ods.Consultora WITH(NOLOCK)
		WHERE Codigo = @CodigoConsultora
	END

	IF (@RolID != 0)
	BEGIN
		IF (@IdEstadoActividad = 7)
		BEGIN
			SET @Result = 2 --*/HD-4199 Se bloquean a las consultoras retiradas /*
		END
		ELSE IF (@AutorizaPedido != '')
		BEGIN
			IF (@IdEstadoActividad != -1)
			BEGIN
				-- validar si es pais Esika
				IF @PaisID NOT IN (SELECT Id FROM @PaisLbel)
				BEGIN		
					-- caso CH
					IF (@PaisID = 3 AND @IdEstadoActividad IN (SELECT Codigo FROM @TablaLogicaDatos WHERE Id = 18) )
					BEGIN
						DECLARE @CampaniaActual INT
						SET @CampaniaActual = ISNULL((SELECT TOP 1 CampaniaID FROM dbo.GetCampaniaPreLogin(@PaisID,@ZonaID,@RegionID,@ConsultoraID)),0)

						-- validar las campañas que no ha ingresado
						IF (LEN(@UltimaCampanaFacturada) = 6 AND LEN(@CampaniaActual) = 6)
						BEGIN
							DECLARE @ca VARCHAR(10)
							DECLARE @uc VARCHAR(10)

							SET @ca = SUBSTRING(CAST(@CampaniaActual AS VARCHAR),1,4)
							SET @uc = SUBSTRING(CAST(@UltimaCampanaFacturada AS VARCHAR),1,4)

							IF @ca != @uc
							BEGIN
								SET @ca = SUBSTRING(CAST(@CampaniaActual AS VARCHAR),5,2)
								SET @uc = SUBSTRING(CAST(@UltimaCampanaFacturada AS VARCHAR),5,2)
								SET @CampaniaActual = CAST(@uc AS INT) + CAST(@ca AS INT)
								SET @UltimaCampanaFacturada = CAST(@uc AS INT)
							END
						END

						IF (@UltimaCampanaFacturada != 0 AND @CampaniaActual - @UltimaCampanaFacturada > 3)
							SET @Result = 2
						ELSE
						BEGIN
							-- validar si autoriza pedido
							/******HD-3693********/
							--IF (@AutorizaPedido = '0')
							--	SET @Result = 2
							--ELSE
							--	SET @Result = 3
							SET @Result = 3
							/******HD-3693********/
						END
					END				
					ELSE
					BEGIN
						-- validar si autoriza pedido
						/******HD-3693********/
						--IF (@AutorizaPedido = '0')
						--	SET @Result = 2
						--ELSE
						--	SET @Result = 3
						SET @Result = 3
						/******HD-3693********/
					END
				END	-- pais Esika
				ELSE
				BEGIN
					-- validar si autoriza pedido
					/******HD-3693********/
					--IF (@AutorizaPedido = '0')
					--	SET @Result = 2
					--ELSE
					--	SET @Result = 3
					SET @Result = 3
					/******HD-3693********/
				END -- pais Lbel
			END	-- @IdEstadoActividad
			ELSE
				SET @Result = 3		-- se asume para usuarios tipo SAC o tipo postulante
		END	-- @AutorizaPedido
		ELSE
			SET @Result = 3		-- se asume para usuarios tipo SAC o tipo postulante
	END	-- @RolID

	IF (@Result = 0)
		SET @Mensaje = 'Usuario No Existe'
	ELSE IF (@Result = 1)
		SET @Mensaje = 'Usuario No es del Portal'
	ELSE IF (@Result = 2)
		SET @Mensaje = 'No estás autorizada para pasar pedido'
	ELSE IF (@Result = 3)
		SET @Mensaje = 'Usuario OK'
	ELSE IF (@Result = 4)
		SET @Mensaje = 'Usuario o Contraseña Incorrectas'

	INSERT INTO @TB (Result,Mensaje) VALUES (@Result,@Mensaje)

	RETURN

END
GO
USE [BelcorpSalvador]
GO
ALTER FUNCTION [dbo].[fnGetAccesoUsuario]
(
	@PaisID INT,
	@CodigoUsuario VARCHAR(20),
	@CodigoConsultora VARCHAR(20),
	@TipoUsuario TINYINT,
	@RolID INT
)
RETURNS @TB TABLE(
	Result TINYINT,
	Mensaje VARCHAR(100)
)
AS

BEGIN
	DECLARE @Result TINYINT
	DECLARE @Mensaje VARCHAR(100)
	DECLARE @PaisLbel TABLE (Id INT)
	DECLARE @TablaLogicaDatos TABLE (Id INT, Codigo VARCHAR(10))

	SET @Result = 0
	INSERT INTO @PaisLbel(Id) VALUES (1),(5),(9),(10)

	INSERT INTO @TablaLogicaDatos 
	SELECT TablaLogicaId, Codigo 
	FROM TablaLogicaDatos WHERE TablaLogicaID IN (12,18,19)

	DECLARE @ZonaID INT
	DECLARE @RegionID INT
	DECLARE @ConsultoraID INT
	DECLARE @IdEstadoActividad INT
	DECLARE @AutorizaPedido CHAR(1)
	DECLARE @UltimaCampanaFacturada INT

	IF (@TipoUsuario = 1)
	BEGIN
		SELECT	
			@ZonaID = ISNULL(ZonaID,0),
			@RegionID = ISNULL(RegionID,0),
			@ConsultoraID = ISNULL(ConsultoraID,0),
			@IdEstadoActividad = ISNULL(IdEstadoActividad,-1),
			@AutorizaPedido = ISNULL(AutorizaPedido,''),
			@UltimaCampanaFacturada = ISNULL(UltimaCampanaFacturada,0)
		FROM ods.Consultora WITH(NOLOCK)
		WHERE Codigo = @CodigoConsultora
	END

	IF (@RolID != 0)
	BEGIN
		IF (@IdEstadoActividad = 7)
		BEGIN
			SET @Result = 2 --*/HD-4199 Se bloquean a las consultoras retiradas /*
		END
		ELSE IF (@AutorizaPedido != '')
		BEGIN
			IF (@IdEstadoActividad != -1)
			BEGIN
				-- validar si es pais Esika
				IF @PaisID NOT IN (SELECT Id FROM @PaisLbel)
				BEGIN		
					-- caso CH
					IF (@PaisID = 3 AND @IdEstadoActividad IN (SELECT Codigo FROM @TablaLogicaDatos WHERE Id = 18) )
					BEGIN
						DECLARE @CampaniaActual INT
						SET @CampaniaActual = ISNULL((SELECT TOP 1 CampaniaID FROM dbo.GetCampaniaPreLogin(@PaisID,@ZonaID,@RegionID,@ConsultoraID)),0)

						-- validar las campañas que no ha ingresado
						IF (LEN(@UltimaCampanaFacturada) = 6 AND LEN(@CampaniaActual) = 6)
						BEGIN
							DECLARE @ca VARCHAR(10)
							DECLARE @uc VARCHAR(10)

							SET @ca = SUBSTRING(CAST(@CampaniaActual AS VARCHAR),1,4)
							SET @uc = SUBSTRING(CAST(@UltimaCampanaFacturada AS VARCHAR),1,4)

							IF @ca != @uc
							BEGIN
								SET @ca = SUBSTRING(CAST(@CampaniaActual AS VARCHAR),5,2)
								SET @uc = SUBSTRING(CAST(@UltimaCampanaFacturada AS VARCHAR),5,2)
								SET @CampaniaActual = CAST(@uc AS INT) + CAST(@ca AS INT)
								SET @UltimaCampanaFacturada = CAST(@uc AS INT)
							END
						END

						IF (@UltimaCampanaFacturada != 0 AND @CampaniaActual - @UltimaCampanaFacturada > 3)
							SET @Result = 2
						ELSE
						BEGIN
							-- validar si autoriza pedido
							/******HD-3693********/
							--IF (@AutorizaPedido = '0')
							--	SET @Result = 2
							--ELSE
							--	SET @Result = 3
							SET @Result = 3
							/******HD-3693********/
						END
					END				
					ELSE
					BEGIN
						-- validar si autoriza pedido
						/******HD-3693********/
						--IF (@AutorizaPedido = '0')
						--	SET @Result = 2
						--ELSE
						--	SET @Result = 3
						SET @Result = 3
						/******HD-3693********/
					END
				END	-- pais Esika
				ELSE
				BEGIN
					-- validar si autoriza pedido
					/******HD-3693********/
					--IF (@AutorizaPedido = '0')
					--	SET @Result = 2
					--ELSE
					--	SET @Result = 3
					SET @Result = 3
					/******HD-3693********/
				END -- pais Lbel
			END	-- @IdEstadoActividad
			ELSE
				SET @Result = 3		-- se asume para usuarios tipo SAC o tipo postulante
		END	-- @AutorizaPedido
		ELSE
			SET @Result = 3		-- se asume para usuarios tipo SAC o tipo postulante
	END	-- @RolID

	IF (@Result = 0)
		SET @Mensaje = 'Usuario No Existe'
	ELSE IF (@Result = 1)
		SET @Mensaje = 'Usuario No es del Portal'
	ELSE IF (@Result = 2)
		SET @Mensaje = 'No estás autorizada para pasar pedido'
	ELSE IF (@Result = 3)
		SET @Mensaje = 'Usuario OK'
	ELSE IF (@Result = 4)
		SET @Mensaje = 'Usuario o Contraseña Incorrectas'

	INSERT INTO @TB (Result,Mensaje) VALUES (@Result,@Mensaje)

	RETURN

END
