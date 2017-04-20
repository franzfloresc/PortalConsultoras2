
use BelcorpPeru
go


ALTER PROCEDURE [dbo].[ValidarLogin_SB2]
(
	@CodigoUsuario VARCHAR(30),
	@Contrasenia VARCHAR(200)
)
AS
/*
ValidarLogin_SB2 '000758833','000758833'
ValidarLogin_SB2 'admcontenido','1234567'
*/
BEGIN

SET NOCOUNT ON

SET @Contrasenia = dbo.EncriptarClaveSHA1(@Contrasenia)

DECLARE @CodigoConsultora VARCHAR(20)
DECLARE @PaisID INT
DECLARE @ZonaID INT
DECLARE @RegionID INT
DECLARE @ConsultoraID INT
DECLARE @IdEstadoActividad INT
DECLARE @AutorizaPedido CHAR(1)
DECLARE @UltimaCampanaFacturada INT

DECLARE @Result INT
DECLARE @Mensaje VARCHAR(100)

DECLARE @PaisesEsika TABLE ( PaisID INT )

DECLARE @PaisesLbel TABLE ( PaisID INT )

DECLARE @TablaLogica TABLE ( TablaLogicaID INT, Codigo VARCHAR(10) )

INSERT INTO @PaisesEsika(PaisID) VALUES (2),(3),(4),(7),(8),(11)
INSERT INTO @PaisesLbel(PaisID) VALUES (1),(5),(6),(9),(10),(12),(13),(14)

INSERT INTO @TablaLogica (TablaLogicaID, Codigo)
SELECT TablaLogicaID, Codigo
FROM TablaLogicaDatos WHERE TablaLogicaID in (12,18,19)

SET @Result = -1

SET @AutorizaPedido = ''
SET @IdEstadoActividad = -1
SET @UltimaCampanaFacturada = 0

DECLARE @TipoUsuario TINYINT

-- STEP 1
IF (@CodigoUsuario LIKE '[a-z,0-9,_,-]%@[a-z,0-9,_,-]%.[a-z][a-z]%')
BEGIN
	DECLARE @CodigoUsuario_1 VARCHAR(30)
	SELECT 
		@CodigoConsultora = ISNULL(CodigoConsultora,''),
		@CodigoUsuario_1 = CodigoUsuario,
		@PaisID = ISNULL(PaisID,0),
		@TipoUsuario = ISNULL(TipoUsuario,0)
	FROM usuario WITH(NOLOCK)
	WHERE EMail = @CodigoUsuario
	AND ClaveSecreta = @Contrasenia

	SET @CodigoUsuario = @CodigoUsuario_1
END
ELSE
BEGIN
	SELECT 
		@CodigoConsultora = ISNULL(CodigoConsultora,''),
		@PaisID = ISNULL(PaisID,0),
		@TipoUsuario = ISNULL(TipoUsuario,0)
	FROM usuario WITH(NOLOCK)
	WHERE CodigoUsuario LIKE @CodigoUsuario
	AND ClaveSecreta = @Contrasenia
END

-- usuario postulante
IF (@TipoUsuario = 2)
BEGIN
	IF EXISTS(
		SELECT 1 FROM UsuarioPostulante WITH(NOLOCK)
		WHERE CodigoUsuario = @CodigoUsuario 
		AND Estado = 1 
		AND ISNULL(UsuarioReal,'0') = '0'
	)
	BEGIN
		SET @CodigoConsultora = @CodigoUsuario 
	END
END


IF (@CodigoConsultora != '' AND @PaisID != 0)
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

	DECLARE @CodigoUsuario_ VARCHAR(30)
	DECLARE @RolID INT
	DECLARE @AutorizaPedido_ CHAR(1)
	DECLARE @CampaniaActual INT

	SELECT 
		@CodigoUsuario_ = ISNULL(u.CodigoUsuario,''), 
		@RolID = ISNULL(ur.RolID,0),
		@AutorizaPedido_ = (CASE WHEN @AutorizaPedido = '' THEN '' WHEN @AutorizaPedido = '1' THEN 'S' WHEN @AutorizaPedido = '0' THEN 'N' END)
		--@CampaniaActual = IIF(u.TipoUsuario = 1, ISNULL((SELECT TOP 1 CampaniaID FROM dbo.GetCampaniaPreLogin(@PaisID,@ZonaID,@RegionID,@ConsultoraID)),0), 0)
	FROM Usuario u WITH(NOLOCK)
	LEFT JOIN UsuarioRol ur WITH(NOLOCK) ON u.CodigoUsuario = ur.CodigoUsuario
	WHERE u.CodigoUsuario = @CodigoUsuario

	IF (@TipoUsuario = 1)
	BEGIN
		SET @CampaniaActual = ISNULL((SELECT TOP 1 CampaniaID FROM dbo.GetCampaniaPreLogin(@PaisID,@ZonaID,@RegionID,@ConsultoraID)),0)
	END

	-- STEP 3
	IF (@CodigoUsuario_ != '')
	BEGIN
		IF (@RolID != 0)
		BEGIN
			IF (@AutorizaPedido_ != '')
			BEGIN
				IF (@IdEstadoActividad != -1)
				BEGIN
					-- validamos si el pais esta en paises esika
					IF @PaisID IN (SELECT PaisID FROM @PaisesEsika)
					BEGIN						
						-- validamos si el estado es retirada
						IF @IdEstadoActividad IN (SELECT Codigo FROM @TablaLogica WHERE TablaLogicaID = 12)
						BEGIN
							-- validamos si el pais es SICC
							IF @PaisID IN (3,4,7,8,11)
							BEGIN
								-- caso Colombia
								IF (@PaisID = 4)
									SET @Result = 2
								ELSE
								BEGIN
									-- validamos si autoriza pedido
									IF (@AutorizaPedido_ = 'N')
										SET @Result = 2
									ELSE
										SET @Result = 3
								END
							END
							ELSE
							BEGIN
								-- caso Bolivia
								IF (@PaisID = 2)
								BEGIN
									-- validamos si autoriza pedido
									IF (@AutorizaPedido_ = 'N')
										SET @Result = 2
									ELSE
										SET @Result = 3
								END
								ELSE
									SET @Result = 3
							END
						END
						ELSE
						BEGIN
							-- validamos si el estado es reingresado
							IF @IdEstadoActividad IN (SELECT Codigo FROM @TablaLogica WHERE TablaLogicaID = 18)
							BEGIN
								-- caso Chile
								IF (@PaisID = 3)
								BEGIN
									-- validamos las campañas que no ha ingresado
									IF (@UltimaCampanaFacturada != 0 AND LEN(@CampaniaActual) = 6 AND LEN(@UltimaCampanaFacturada) = 6)
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

									IF (@CampaniaActual - @UltimaCampanaFacturada > 3 AND @UltimaCampanaFacturada != 0)
										SET @Result = 2
									ELSE
									BEGIN
										-- validamos si autoriza pedido
										IF (@AutorizaPedido_ = 'N')
											SET @Result = 2
										ELSE
											SET @Result = 3
									END
								END
								ELSE
								BEGIN
									-- caso Colombia
									IF (@PaisID = 4)
										SET @Result = 2
									ELSE
									BEGIN
										-- validamos si autoriza pedido
										IF (@AutorizaPedido_ = 'N')
										BEGIN
											-- validamos si el pais es SICC
											IF (@PaisID IN (2,3,7,8,11))
												SET @Result = 2
											ELSE
												SET @Result = 3
										END
										ELSE
											SET @Result = 3
									END
								END
							END
							ELSE
							BEGIN
								-- caso Colombia
								IF (@PaisID = 4)
								BEGIN
									-- validamos si el estado es egresada o posible egrese
									IF @IdEstadoActividad IN (SELECT Codigo FROM @TablaLogica WHERE TablaLogicaID = 19)
									BEGIN
										SET @Result = 2
									END
								END
								
								-- validamos si autoriza pedido
								IF (@AutorizaPedido_ = 'N')
								BEGIN
									-- validamos si el pais es SICC
									IF (@PaisID IN (2,3,4,7,8,11))
										SET @Result = 2
									ELSE
										SET @Result = 3
								END
								ELSE
									SET @Result = 3
							END
						END
					END	-- ESIKA
					-- validamos si el pais esta en paises lbel
					ELSE IF @PaisID IN (SELECT PaisID FROM @PaisesLbel)
					BEGIN
						-- validamos si la consultora es retirada
						IF @IdEstadoActividad IN (SELECT Codigo FROM @TablaLogica WHERE TablaLogicaID = 12)
						BEGIN
							-- validamos si el pais es SICC
							IF (@PaisID IN (5,6,10,14))
							BEGIN
								-- validamos si autoriza pedido
								IF (@AutorizaPedido_ = 'N')
									SET @Result = 2
								ELSE
									SET @Result = 3
							END
							ELSE
							BEGIN
								-- validamos si autoriza pedido
								IF (@AutorizaPedido_ = 'N')
									SET @Result = 2
								ELSE
									SET @Result = 3
							END
						END
						ELSE
						BEGIN
							-- validamos si el estado es egresada
							IF @IdEstadoActividad IN (SELECT Codigo FROM @TablaLogica WHERE TablaLogicaID = 19)
							BEGIN
								-- validamos si autoriza pedido
								IF (@AutorizaPedido_ = 'N')
								BEGIN
									-- validamos si el pais es SICC
									IF (@PaisID IN (5,6,9,10,12,13,14))
										SET @Result = 2
									ELSE
										SET @Result = 3
								END
								ELSE
									SET @Result = 3
							END
							ELSE
							BEGIN
								-- validamos si autoriza pedido
								IF (@AutorizaPedido_ = 'N')
								BEGIN
									-- validamos si el pais es SICC
									IF (@PaisID IN (5,6,9,10,12,13,14))
										SET @Result = 2
									ELSE
										SET @Result = 3
								END
								ELSE
									SET @Result = 3
							END
						END
						
					END		-- LBEL
					ELSE
						SET @Result = 3
						
				END	-- @IdEstadoActividad
				ELSE
					SET @Result = 3		-- se asume para usuarios del tipo SAC
			END	-- @AutorizaPedido_
			ELSE
				SET @Result = 3		-- se asume para usuarios tipo SAC / o para usuarios tipo postulante
		END	-- @RolID

	END	-- @CodigoUsuario_
	ELSE
		SET @Result = 0

END
ELSE
	SET @Result = 4 


/*
0: Usuario No Existe
1: Usuario No es del Portal
2: Usuario Esta dentro de la Lista / Autoriza Pedido NULL o N
3: Usuario OK
4: Usuario o contrasenia incorrectos
*/

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

SELECT @Result AS Result, @Mensaje AS Mensaje, @CodigoUsuario as CodigoUsuario

SET NOCOUNT OFF

END

