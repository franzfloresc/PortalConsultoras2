USE BelcorpPeru
GO

ALTER PROCEDURE [dbo].[ValidarLogin]
-- exec ValidarLogin '044315718', '1'
(
	@CodigoUsuario VARCHAR(50),
	@Contrasenia VARCHAR(200)
)
AS
BEGIN

	SET NOCOUNT ON

	SET @Contrasenia = dbo.EncriptarClaveSHA1(@Contrasenia)

	DECLARE @Result TINYINT
	DECLARE @Mensaje VARCHAR(100)

	SET @Result = 0

	DECLARE @CodigoUsuarioReal VARCHAR(20)
	DECLARE @CodigoConsultora VARCHAR(20)
	DECLARE @PaisID INT
	DECLARE @TipoUsuario TINYINT
	DECLARE @RolID INT
	DECLARE @IsEmail BIT

	SELECT @IsEmail = dbo.fnAppEmailCheck(@CodigoUsuario)

	IF (@IsEmail = 1) 
	BEGIN
		SELECT
			@CodigoUsuarioReal = ISNULL(u.CodigoUsuario,''),
			@CodigoConsultora = ISNULL(u.CodigoConsultora,''),
			@PaisID = ISNULL(u.PaisID,0),
			@TipoUsuario = ISNULL(u.TipoUsuario,0),
			@RolID = ISNULL(ur.RolID,0)
		FROM Usuario u WITH(NOLOCK) 
		INNER JOIN UsuarioRol ur WITH(NOLOCK) ON u.CodigoUsuario = ur.CodigoUsuario 
			AND ur.Activo = 1
		WHERE u.Activo = 1
		AND u.Email = @CodigoUsuario
		AND u.ClaveSecreta = @Contrasenia
	END
	ELSE
	BEGIN
		SELECT
			@CodigoUsuarioReal = ISNULL(u.CodigoUsuario,''),
			@CodigoConsultora = ISNULL(u.CodigoConsultora,''),
			@PaisID = ISNULL(u.PaisID,0),
			@TipoUsuario = ISNULL(u.TipoUsuario,0),
			@RolID = ISNULL(ur.RolID,0)
		FROM Usuario u WITH(NOLOCK) 
		INNER JOIN UsuarioRol ur WITH(NOLOCK) ON u.CodigoUsuario = ur.CodigoUsuario 
			AND ur.Activo = 1
		WHERE u.Activo = 1
		AND u.CodigoUsuario = @CodigoUsuario
		AND u.ClaveSecreta = @Contrasenia
	END

	-- si no se encontro ahora buscar por doc identidad
	IF (ISNULL(@CodigoConsultora,'') = '')
	BEGIN
		SELECT
			@CodigoUsuarioReal = ISNULL(u.CodigoUsuario,''),
			@CodigoConsultora = ISNULL(u.CodigoConsultora,''),
			@PaisID = ISNULL(u.PaisID,0),
			@TipoUsuario = ISNULL(u.TipoUsuario,0),
			@RolID = ISNULL(ur.RolID,0)
		FROM Usuario u WITH(NOLOCK)
		INNER JOIN UsuarioRol ur WITH(NOLOCK) ON u.CodigoUsuario = ur.CodigoUsuario 
			AND ur.Activo = 1
		WHERE u.Activo = 1
		AND u.DocumentoIdentidad = @CodigoUsuario
		AND u.ClaveSecreta = @Contrasenia
	END

	-- validar si es usuario postulante
	IF (@TipoUsuario = 2 AND ISNULL(@CodigoUsuarioReal,'') != '')
	BEGIN
		IF EXISTS(
			SELECT 1 FROM UsuarioPostulante WITH(NOLOCK)
			WHERE CodigoUsuario = @CodigoUsuarioReal
			AND Estado = 1 AND ISNULL(UsuarioReal,'0') = '0'
		)
		BEGIN
			SET @CodigoConsultora = @CodigoUsuarioReal
		END
	END

	--Validar el # intentos de logueo y tiempo de espera
	declare @TiempoEsperaLogueo int = (select cast(Valor as int) from TablaLogicaDatos where Codigo = 'TiempoLogueo') --obtener tiempo de espera de logueo
	declare @FechaUltimoIntentoLogueo datetime = (select FechaUltimoIntentoLogueo from usuario where CodigoUsuario = @CodigoUsuario)
	declare @UsuarioBloqueado int = (select 1 from Usuario where CodigoUsuario = @CodigoUsuario and Bloqueado = 1)

	if (SELECT DATEDIFF(second, @FechaUltimoIntentoLogueo, getdate())) >  @TiempoEsperaLogueo and isnull(@UsuarioBloqueado,0) = 1
	begin
		UPDATE Usuario 
		set CantidadIntentoLogueo = 0, 
		Bloqueado = 0,
		FechaUltimoIntentoLogueo = getdate() 
		WHERE CodigoUsuario = @CodigoUsuario
	end

	IF exists(select 1 from Usuario where CodigoUsuario = @CodigoUsuario and Bloqueado = 1)
	begin			
		SET @Result = 5 
		SET @Mensaje = 'Su cuenta fue bloqueada, por superar la cantidad maxima de intento'
	end
	ELSE IF (ISNULL(@CodigoConsultora,'') != '' AND @PaisID != 0)
	BEGIN
		SELECT @Result = Result, @Mensaje = Mensaje 
		FROM dbo.fnGetAccesoUsuario(@PaisID,@CodigoUsuarioReal,@CodigoConsultora,@TipoUsuario,@RolID)
		
		UPDATE Usuario 
		set CantidadIntentoLogueo = 0, 
		FechaUltimoIntentoLogueo = getdate() 
		WHERE CodigoUsuario = @CodigoUsuario
	END
	ELSE
	BEGIN
		declare @CantidadIntentoLogueo int = (select CantidadIntentoLogueo from Usuario WHERE CodigoUsuario = @CodigoUsuario)
		
		IF (@CantidadIntentoLogueo + 1 >= (select cast(Valor as int) from TablaLogicaDatos where Codigo = 'IntentoLogueo'))
		begin
			UPDATE Usuario 
			set Bloqueado = 1,
			CantidadIntentoLogueo = (select cast(Valor as int) from TablaLogicaDatos where Codigo = 'IntentoLogueo'),
			FechaUltimoIntentoLogueo = getdate()
			WHERE CodigoUsuario = @CodigoUsuario

			SET @Result = 5 
			SET @Mensaje = 'Su cuenta fue bloqueada, por superar la cantidad maxima de intento'
		end
		else
		begin
			SET @Result = 4 
			SET @Mensaje = 'Usuario o Contraseña Incorrectas'

			UPDATE Usuario 
			set CantidadIntentoLogueo = CantidadIntentoLogueo + 1, 
			FechaUltimoIntentoLogueo = getdate() 
			WHERE CodigoUsuario = @CodigoUsuario
		end
	END
		
	SELECT @Result AS Result, 
		@Mensaje AS Mensaje, 
		@CodigoUsuarioReal AS CodigoUsuario,
		@TipoUsuario AS TipoUsuario

	SET NOCOUNT OFF

END
go

USE BelcorpMexico
GO

ALTER PROCEDURE [dbo].[ValidarLogin]
-- exec ValidarLogin '044315718', '1'
(
	@CodigoUsuario VARCHAR(50),
	@Contrasenia VARCHAR(200)
)
AS
BEGIN

	SET NOCOUNT ON

	SET @Contrasenia = dbo.EncriptarClaveSHA1(@Contrasenia)

	DECLARE @Result TINYINT
	DECLARE @Mensaje VARCHAR(100)

	SET @Result = 0

	DECLARE @CodigoUsuarioReal VARCHAR(20)
	DECLARE @CodigoConsultora VARCHAR(20)
	DECLARE @PaisID INT
	DECLARE @TipoUsuario TINYINT
	DECLARE @RolID INT
	DECLARE @IsEmail BIT

	SELECT @IsEmail = dbo.fnAppEmailCheck(@CodigoUsuario)

	IF (@IsEmail = 1) 
	BEGIN
		SELECT
			@CodigoUsuarioReal = ISNULL(u.CodigoUsuario,''),
			@CodigoConsultora = ISNULL(u.CodigoConsultora,''),
			@PaisID = ISNULL(u.PaisID,0),
			@TipoUsuario = ISNULL(u.TipoUsuario,0),
			@RolID = ISNULL(ur.RolID,0)
		FROM Usuario u WITH(NOLOCK) 
		INNER JOIN UsuarioRol ur WITH(NOLOCK) ON u.CodigoUsuario = ur.CodigoUsuario 
			AND ur.Activo = 1
		WHERE u.Activo = 1
		AND u.Email = @CodigoUsuario
		AND u.ClaveSecreta = @Contrasenia
	END
	ELSE
	BEGIN
		SELECT
			@CodigoUsuarioReal = ISNULL(u.CodigoUsuario,''),
			@CodigoConsultora = ISNULL(u.CodigoConsultora,''),
			@PaisID = ISNULL(u.PaisID,0),
			@TipoUsuario = ISNULL(u.TipoUsuario,0),
			@RolID = ISNULL(ur.RolID,0)
		FROM Usuario u WITH(NOLOCK) 
		INNER JOIN UsuarioRol ur WITH(NOLOCK) ON u.CodigoUsuario = ur.CodigoUsuario 
			AND ur.Activo = 1
		WHERE u.Activo = 1
		AND u.CodigoUsuario = @CodigoUsuario
		AND u.ClaveSecreta = @Contrasenia
	END

	-- si no se encontro ahora buscar por doc identidad
	IF (ISNULL(@CodigoConsultora,'') = '')
	BEGIN
		SELECT
			@CodigoUsuarioReal = ISNULL(u.CodigoUsuario,''),
			@CodigoConsultora = ISNULL(u.CodigoConsultora,''),
			@PaisID = ISNULL(u.PaisID,0),
			@TipoUsuario = ISNULL(u.TipoUsuario,0),
			@RolID = ISNULL(ur.RolID,0)
		FROM Usuario u WITH(NOLOCK)
		INNER JOIN UsuarioRol ur WITH(NOLOCK) ON u.CodigoUsuario = ur.CodigoUsuario 
			AND ur.Activo = 1
		WHERE u.Activo = 1
		AND u.DocumentoIdentidad = @CodigoUsuario
		AND u.ClaveSecreta = @Contrasenia
	END

	-- validar si es usuario postulante
	IF (@TipoUsuario = 2 AND ISNULL(@CodigoUsuarioReal,'') != '')
	BEGIN
		IF EXISTS(
			SELECT 1 FROM UsuarioPostulante WITH(NOLOCK)
			WHERE CodigoUsuario = @CodigoUsuarioReal
			AND Estado = 1 AND ISNULL(UsuarioReal,'0') = '0'
		)
		BEGIN
			SET @CodigoConsultora = @CodigoUsuarioReal
		END
	END

	--Validar el # intentos de logueo y tiempo de espera
	declare @TiempoEsperaLogueo int = (select cast(Valor as int) from TablaLogicaDatos where Codigo = 'TiempoLogueo') --obtener tiempo de espera de logueo
	declare @FechaUltimoIntentoLogueo datetime = (select FechaUltimoIntentoLogueo from usuario where CodigoUsuario = @CodigoUsuario)
	declare @UsuarioBloqueado int = (select 1 from Usuario where CodigoUsuario = @CodigoUsuario and Bloqueado = 1)

	if (SELECT DATEDIFF(second, @FechaUltimoIntentoLogueo, getdate())) >  @TiempoEsperaLogueo and isnull(@UsuarioBloqueado,0) = 1
	begin
		UPDATE Usuario 
		set CantidadIntentoLogueo = 0, 
		Bloqueado = 0,
		FechaUltimoIntentoLogueo = getdate() 
		WHERE CodigoUsuario = @CodigoUsuario
	end

	IF exists(select 1 from Usuario where CodigoUsuario = @CodigoUsuario and Bloqueado = 1)
	begin			
		SET @Result = 5 
		SET @Mensaje = 'Su cuenta fue bloqueada, por superar la cantidad maxima de intento'
	end
	ELSE IF (ISNULL(@CodigoConsultora,'') != '' AND @PaisID != 0)
	BEGIN
		SELECT @Result = Result, @Mensaje = Mensaje 
		FROM dbo.fnGetAccesoUsuario(@PaisID,@CodigoUsuarioReal,@CodigoConsultora,@TipoUsuario,@RolID)
		
		UPDATE Usuario 
		set CantidadIntentoLogueo = 0, 
		FechaUltimoIntentoLogueo = getdate() 
		WHERE CodigoUsuario = @CodigoUsuario
	END
	ELSE
	BEGIN
		declare @CantidadIntentoLogueo int = (select CantidadIntentoLogueo from Usuario WHERE CodigoUsuario = @CodigoUsuario)
		
		IF (@CantidadIntentoLogueo + 1 >= (select cast(Valor as int) from TablaLogicaDatos where Codigo = 'IntentoLogueo'))
		begin
			UPDATE Usuario 
			set Bloqueado = 1,
			CantidadIntentoLogueo = (select cast(Valor as int) from TablaLogicaDatos where Codigo = 'IntentoLogueo'),
			FechaUltimoIntentoLogueo = getdate()
			WHERE CodigoUsuario = @CodigoUsuario

			SET @Result = 5 
			SET @Mensaje = 'Su cuenta fue bloqueada, por superar la cantidad maxima de intento'
		end
		else
		begin
			SET @Result = 4 
			SET @Mensaje = 'Usuario o Contraseña Incorrectas'

			UPDATE Usuario 
			set CantidadIntentoLogueo = CantidadIntentoLogueo + 1, 
			FechaUltimoIntentoLogueo = getdate() 
			WHERE CodigoUsuario = @CodigoUsuario
		end
	END
		
	SELECT @Result AS Result, 
		@Mensaje AS Mensaje, 
		@CodigoUsuarioReal AS CodigoUsuario,
		@TipoUsuario AS TipoUsuario

	SET NOCOUNT OFF

END
go

USE BelcorpColombia
GO

ALTER PROCEDURE [dbo].[ValidarLogin]
-- exec ValidarLogin '044315718', '1'
(
	@CodigoUsuario VARCHAR(50),
	@Contrasenia VARCHAR(200)
)
AS
BEGIN

	SET NOCOUNT ON

	SET @Contrasenia = dbo.EncriptarClaveSHA1(@Contrasenia)

	DECLARE @Result TINYINT
	DECLARE @Mensaje VARCHAR(100)

	SET @Result = 0

	DECLARE @CodigoUsuarioReal VARCHAR(20)
	DECLARE @CodigoConsultora VARCHAR(20)
	DECLARE @PaisID INT
	DECLARE @TipoUsuario TINYINT
	DECLARE @RolID INT
	DECLARE @IsEmail BIT

	SELECT @IsEmail = dbo.fnAppEmailCheck(@CodigoUsuario)

	IF (@IsEmail = 1) 
	BEGIN
		SELECT
			@CodigoUsuarioReal = ISNULL(u.CodigoUsuario,''),
			@CodigoConsultora = ISNULL(u.CodigoConsultora,''),
			@PaisID = ISNULL(u.PaisID,0),
			@TipoUsuario = ISNULL(u.TipoUsuario,0),
			@RolID = ISNULL(ur.RolID,0)
		FROM Usuario u WITH(NOLOCK) 
		INNER JOIN UsuarioRol ur WITH(NOLOCK) ON u.CodigoUsuario = ur.CodigoUsuario 
			AND ur.Activo = 1
		WHERE u.Activo = 1
		AND u.Email = @CodigoUsuario
		AND u.ClaveSecreta = @Contrasenia
	END
	ELSE
	BEGIN
		SELECT
			@CodigoUsuarioReal = ISNULL(u.CodigoUsuario,''),
			@CodigoConsultora = ISNULL(u.CodigoConsultora,''),
			@PaisID = ISNULL(u.PaisID,0),
			@TipoUsuario = ISNULL(u.TipoUsuario,0),
			@RolID = ISNULL(ur.RolID,0)
		FROM Usuario u WITH(NOLOCK) 
		INNER JOIN UsuarioRol ur WITH(NOLOCK) ON u.CodigoUsuario = ur.CodigoUsuario 
			AND ur.Activo = 1
		WHERE u.Activo = 1
		AND u.CodigoUsuario = @CodigoUsuario
		AND u.ClaveSecreta = @Contrasenia
	END

	-- si no se encontro ahora buscar por doc identidad
	IF (ISNULL(@CodigoConsultora,'') = '')
	BEGIN
		SELECT
			@CodigoUsuarioReal = ISNULL(u.CodigoUsuario,''),
			@CodigoConsultora = ISNULL(u.CodigoConsultora,''),
			@PaisID = ISNULL(u.PaisID,0),
			@TipoUsuario = ISNULL(u.TipoUsuario,0),
			@RolID = ISNULL(ur.RolID,0)
		FROM Usuario u WITH(NOLOCK)
		INNER JOIN UsuarioRol ur WITH(NOLOCK) ON u.CodigoUsuario = ur.CodigoUsuario 
			AND ur.Activo = 1
		WHERE u.Activo = 1
		AND u.DocumentoIdentidad = @CodigoUsuario
		AND u.ClaveSecreta = @Contrasenia
	END

	-- validar si es usuario postulante
	IF (@TipoUsuario = 2 AND ISNULL(@CodigoUsuarioReal,'') != '')
	BEGIN
		IF EXISTS(
			SELECT 1 FROM UsuarioPostulante WITH(NOLOCK)
			WHERE CodigoUsuario = @CodigoUsuarioReal
			AND Estado = 1 AND ISNULL(UsuarioReal,'0') = '0'
		)
		BEGIN
			SET @CodigoConsultora = @CodigoUsuarioReal
		END
	END

	--Validar el # intentos de logueo y tiempo de espera
	declare @TiempoEsperaLogueo int = (select cast(Valor as int) from TablaLogicaDatos where Codigo = 'TiempoLogueo') --obtener tiempo de espera de logueo
	declare @FechaUltimoIntentoLogueo datetime = (select FechaUltimoIntentoLogueo from usuario where CodigoUsuario = @CodigoUsuario)
	declare @UsuarioBloqueado int = (select 1 from Usuario where CodigoUsuario = @CodigoUsuario and Bloqueado = 1)

	if (SELECT DATEDIFF(second, @FechaUltimoIntentoLogueo, getdate())) >  @TiempoEsperaLogueo and isnull(@UsuarioBloqueado,0) = 1
	begin
		UPDATE Usuario 
		set CantidadIntentoLogueo = 0, 
		Bloqueado = 0,
		FechaUltimoIntentoLogueo = getdate() 
		WHERE CodigoUsuario = @CodigoUsuario
	end

	IF exists(select 1 from Usuario where CodigoUsuario = @CodigoUsuario and Bloqueado = 1)
	begin			
		SET @Result = 5 
		SET @Mensaje = 'Su cuenta fue bloqueada, por superar la cantidad maxima de intento'
	end
	ELSE IF (ISNULL(@CodigoConsultora,'') != '' AND @PaisID != 0)
	BEGIN
		SELECT @Result = Result, @Mensaje = Mensaje 
		FROM dbo.fnGetAccesoUsuario(@PaisID,@CodigoUsuarioReal,@CodigoConsultora,@TipoUsuario,@RolID)
		
		UPDATE Usuario 
		set CantidadIntentoLogueo = 0, 
		FechaUltimoIntentoLogueo = getdate() 
		WHERE CodigoUsuario = @CodigoUsuario
	END
	ELSE
	BEGIN
		declare @CantidadIntentoLogueo int = (select CantidadIntentoLogueo from Usuario WHERE CodigoUsuario = @CodigoUsuario)
		
		IF (@CantidadIntentoLogueo + 1 >= (select cast(Valor as int) from TablaLogicaDatos where Codigo = 'IntentoLogueo'))
		begin
			UPDATE Usuario 
			set Bloqueado = 1,
			CantidadIntentoLogueo = (select cast(Valor as int) from TablaLogicaDatos where Codigo = 'IntentoLogueo'),
			FechaUltimoIntentoLogueo = getdate()
			WHERE CodigoUsuario = @CodigoUsuario

			SET @Result = 5 
			SET @Mensaje = 'Su cuenta fue bloqueada, por superar la cantidad maxima de intento'
		end
		else
		begin
			SET @Result = 4 
			SET @Mensaje = 'Usuario o Contraseña Incorrectas'

			UPDATE Usuario 
			set CantidadIntentoLogueo = CantidadIntentoLogueo + 1, 
			FechaUltimoIntentoLogueo = getdate() 
			WHERE CodigoUsuario = @CodigoUsuario
		end
	END
		
	SELECT @Result AS Result, 
		@Mensaje AS Mensaje, 
		@CodigoUsuarioReal AS CodigoUsuario,
		@TipoUsuario AS TipoUsuario

	SET NOCOUNT OFF

END
go

USE BelcorpSalvador
GO

ALTER PROCEDURE [dbo].[ValidarLogin]
-- exec ValidarLogin '044315718', '1'
(
	@CodigoUsuario VARCHAR(50),
	@Contrasenia VARCHAR(200)
)
AS
BEGIN

	SET NOCOUNT ON

	SET @Contrasenia = dbo.EncriptarClaveSHA1(@Contrasenia)

	DECLARE @Result TINYINT
	DECLARE @Mensaje VARCHAR(100)

	SET @Result = 0

	DECLARE @CodigoUsuarioReal VARCHAR(20)
	DECLARE @CodigoConsultora VARCHAR(20)
	DECLARE @PaisID INT
	DECLARE @TipoUsuario TINYINT
	DECLARE @RolID INT
	DECLARE @IsEmail BIT

	SELECT @IsEmail = dbo.fnAppEmailCheck(@CodigoUsuario)

	IF (@IsEmail = 1) 
	BEGIN
		SELECT
			@CodigoUsuarioReal = ISNULL(u.CodigoUsuario,''),
			@CodigoConsultora = ISNULL(u.CodigoConsultora,''),
			@PaisID = ISNULL(u.PaisID,0),
			@TipoUsuario = ISNULL(u.TipoUsuario,0),
			@RolID = ISNULL(ur.RolID,0)
		FROM Usuario u WITH(NOLOCK) 
		INNER JOIN UsuarioRol ur WITH(NOLOCK) ON u.CodigoUsuario = ur.CodigoUsuario 
			AND ur.Activo = 1
		WHERE u.Activo = 1
		AND u.Email = @CodigoUsuario
		AND u.ClaveSecreta = @Contrasenia
	END
	ELSE
	BEGIN
		SELECT
			@CodigoUsuarioReal = ISNULL(u.CodigoUsuario,''),
			@CodigoConsultora = ISNULL(u.CodigoConsultora,''),
			@PaisID = ISNULL(u.PaisID,0),
			@TipoUsuario = ISNULL(u.TipoUsuario,0),
			@RolID = ISNULL(ur.RolID,0)
		FROM Usuario u WITH(NOLOCK) 
		INNER JOIN UsuarioRol ur WITH(NOLOCK) ON u.CodigoUsuario = ur.CodigoUsuario 
			AND ur.Activo = 1
		WHERE u.Activo = 1
		AND u.CodigoUsuario = @CodigoUsuario
		AND u.ClaveSecreta = @Contrasenia
	END

	-- si no se encontro ahora buscar por doc identidad
	IF (ISNULL(@CodigoConsultora,'') = '')
	BEGIN
		SELECT
			@CodigoUsuarioReal = ISNULL(u.CodigoUsuario,''),
			@CodigoConsultora = ISNULL(u.CodigoConsultora,''),
			@PaisID = ISNULL(u.PaisID,0),
			@TipoUsuario = ISNULL(u.TipoUsuario,0),
			@RolID = ISNULL(ur.RolID,0)
		FROM Usuario u WITH(NOLOCK)
		INNER JOIN UsuarioRol ur WITH(NOLOCK) ON u.CodigoUsuario = ur.CodigoUsuario 
			AND ur.Activo = 1
		WHERE u.Activo = 1
		AND u.DocumentoIdentidad = @CodigoUsuario
		AND u.ClaveSecreta = @Contrasenia
	END

	-- validar si es usuario postulante
	IF (@TipoUsuario = 2 AND ISNULL(@CodigoUsuarioReal,'') != '')
	BEGIN
		IF EXISTS(
			SELECT 1 FROM UsuarioPostulante WITH(NOLOCK)
			WHERE CodigoUsuario = @CodigoUsuarioReal
			AND Estado = 1 AND ISNULL(UsuarioReal,'0') = '0'
		)
		BEGIN
			SET @CodigoConsultora = @CodigoUsuarioReal
		END
	END

	--Validar el # intentos de logueo y tiempo de espera
	declare @TiempoEsperaLogueo int = (select cast(Valor as int) from TablaLogicaDatos where Codigo = 'TiempoLogueo') --obtener tiempo de espera de logueo
	declare @FechaUltimoIntentoLogueo datetime = (select FechaUltimoIntentoLogueo from usuario where CodigoUsuario = @CodigoUsuario)
	declare @UsuarioBloqueado int = (select 1 from Usuario where CodigoUsuario = @CodigoUsuario and Bloqueado = 1)

	if (SELECT DATEDIFF(second, @FechaUltimoIntentoLogueo, getdate())) >  @TiempoEsperaLogueo and isnull(@UsuarioBloqueado,0) = 1
	begin
		UPDATE Usuario 
		set CantidadIntentoLogueo = 0, 
		Bloqueado = 0,
		FechaUltimoIntentoLogueo = getdate() 
		WHERE CodigoUsuario = @CodigoUsuario
	end

	IF exists(select 1 from Usuario where CodigoUsuario = @CodigoUsuario and Bloqueado = 1)
	begin			
		SET @Result = 5 
		SET @Mensaje = 'Su cuenta fue bloqueada, por superar la cantidad maxima de intento'
	end
	ELSE IF (ISNULL(@CodigoConsultora,'') != '' AND @PaisID != 0)
	BEGIN
		SELECT @Result = Result, @Mensaje = Mensaje 
		FROM dbo.fnGetAccesoUsuario(@PaisID,@CodigoUsuarioReal,@CodigoConsultora,@TipoUsuario,@RolID)
		
		UPDATE Usuario 
		set CantidadIntentoLogueo = 0, 
		FechaUltimoIntentoLogueo = getdate() 
		WHERE CodigoUsuario = @CodigoUsuario
	END
	ELSE
	BEGIN
		declare @CantidadIntentoLogueo int = (select CantidadIntentoLogueo from Usuario WHERE CodigoUsuario = @CodigoUsuario)
		
		IF (@CantidadIntentoLogueo + 1 >= (select cast(Valor as int) from TablaLogicaDatos where Codigo = 'IntentoLogueo'))
		begin
			UPDATE Usuario 
			set Bloqueado = 1,
			CantidadIntentoLogueo = (select cast(Valor as int) from TablaLogicaDatos where Codigo = 'IntentoLogueo'),
			FechaUltimoIntentoLogueo = getdate()
			WHERE CodigoUsuario = @CodigoUsuario

			SET @Result = 5 
			SET @Mensaje = 'Su cuenta fue bloqueada, por superar la cantidad maxima de intento'
		end
		else
		begin
			SET @Result = 4 
			SET @Mensaje = 'Usuario o Contraseña Incorrectas'

			UPDATE Usuario 
			set CantidadIntentoLogueo = CantidadIntentoLogueo + 1, 
			FechaUltimoIntentoLogueo = getdate() 
			WHERE CodigoUsuario = @CodigoUsuario
		end
	END
		
	SELECT @Result AS Result, 
		@Mensaje AS Mensaje, 
		@CodigoUsuarioReal AS CodigoUsuario,
		@TipoUsuario AS TipoUsuario

	SET NOCOUNT OFF

END
go

USE BelcorpPuertoRico
GO

ALTER PROCEDURE [dbo].[ValidarLogin]
-- exec ValidarLogin '044315718', '1'
(
	@CodigoUsuario VARCHAR(50),
	@Contrasenia VARCHAR(200)
)
AS
BEGIN

	SET NOCOUNT ON

	SET @Contrasenia = dbo.EncriptarClaveSHA1(@Contrasenia)

	DECLARE @Result TINYINT
	DECLARE @Mensaje VARCHAR(100)

	SET @Result = 0

	DECLARE @CodigoUsuarioReal VARCHAR(20)
	DECLARE @CodigoConsultora VARCHAR(20)
	DECLARE @PaisID INT
	DECLARE @TipoUsuario TINYINT
	DECLARE @RolID INT
	DECLARE @IsEmail BIT

	SELECT @IsEmail = dbo.fnAppEmailCheck(@CodigoUsuario)

	IF (@IsEmail = 1) 
	BEGIN
		SELECT
			@CodigoUsuarioReal = ISNULL(u.CodigoUsuario,''),
			@CodigoConsultora = ISNULL(u.CodigoConsultora,''),
			@PaisID = ISNULL(u.PaisID,0),
			@TipoUsuario = ISNULL(u.TipoUsuario,0),
			@RolID = ISNULL(ur.RolID,0)
		FROM Usuario u WITH(NOLOCK) 
		INNER JOIN UsuarioRol ur WITH(NOLOCK) ON u.CodigoUsuario = ur.CodigoUsuario 
			AND ur.Activo = 1
		WHERE u.Activo = 1
		AND u.Email = @CodigoUsuario
		AND u.ClaveSecreta = @Contrasenia
	END
	ELSE
	BEGIN
		SELECT
			@CodigoUsuarioReal = ISNULL(u.CodigoUsuario,''),
			@CodigoConsultora = ISNULL(u.CodigoConsultora,''),
			@PaisID = ISNULL(u.PaisID,0),
			@TipoUsuario = ISNULL(u.TipoUsuario,0),
			@RolID = ISNULL(ur.RolID,0)
		FROM Usuario u WITH(NOLOCK) 
		INNER JOIN UsuarioRol ur WITH(NOLOCK) ON u.CodigoUsuario = ur.CodigoUsuario 
			AND ur.Activo = 1
		WHERE u.Activo = 1
		AND u.CodigoUsuario = @CodigoUsuario
		AND u.ClaveSecreta = @Contrasenia
	END

	-- si no se encontro ahora buscar por doc identidad
	IF (ISNULL(@CodigoConsultora,'') = '')
	BEGIN
		SELECT
			@CodigoUsuarioReal = ISNULL(u.CodigoUsuario,''),
			@CodigoConsultora = ISNULL(u.CodigoConsultora,''),
			@PaisID = ISNULL(u.PaisID,0),
			@TipoUsuario = ISNULL(u.TipoUsuario,0),
			@RolID = ISNULL(ur.RolID,0)
		FROM Usuario u WITH(NOLOCK)
		INNER JOIN UsuarioRol ur WITH(NOLOCK) ON u.CodigoUsuario = ur.CodigoUsuario 
			AND ur.Activo = 1
		WHERE u.Activo = 1
		AND u.DocumentoIdentidad = @CodigoUsuario
		AND u.ClaveSecreta = @Contrasenia
	END

	-- validar si es usuario postulante
	IF (@TipoUsuario = 2 AND ISNULL(@CodigoUsuarioReal,'') != '')
	BEGIN
		IF EXISTS(
			SELECT 1 FROM UsuarioPostulante WITH(NOLOCK)
			WHERE CodigoUsuario = @CodigoUsuarioReal
			AND Estado = 1 AND ISNULL(UsuarioReal,'0') = '0'
		)
		BEGIN
			SET @CodigoConsultora = @CodigoUsuarioReal
		END
	END

	--Validar el # intentos de logueo y tiempo de espera
	declare @TiempoEsperaLogueo int = (select cast(Valor as int) from TablaLogicaDatos where Codigo = 'TiempoLogueo') --obtener tiempo de espera de logueo
	declare @FechaUltimoIntentoLogueo datetime = (select FechaUltimoIntentoLogueo from usuario where CodigoUsuario = @CodigoUsuario)
	declare @UsuarioBloqueado int = (select 1 from Usuario where CodigoUsuario = @CodigoUsuario and Bloqueado = 1)

	if (SELECT DATEDIFF(second, @FechaUltimoIntentoLogueo, getdate())) >  @TiempoEsperaLogueo and isnull(@UsuarioBloqueado,0) = 1
	begin
		UPDATE Usuario 
		set CantidadIntentoLogueo = 0, 
		Bloqueado = 0,
		FechaUltimoIntentoLogueo = getdate() 
		WHERE CodigoUsuario = @CodigoUsuario
	end

	IF exists(select 1 from Usuario where CodigoUsuario = @CodigoUsuario and Bloqueado = 1)
	begin			
		SET @Result = 5 
		SET @Mensaje = 'Su cuenta fue bloqueada, por superar la cantidad maxima de intento'
	end
	ELSE IF (ISNULL(@CodigoConsultora,'') != '' AND @PaisID != 0)
	BEGIN
		SELECT @Result = Result, @Mensaje = Mensaje 
		FROM dbo.fnGetAccesoUsuario(@PaisID,@CodigoUsuarioReal,@CodigoConsultora,@TipoUsuario,@RolID)
		
		UPDATE Usuario 
		set CantidadIntentoLogueo = 0, 
		FechaUltimoIntentoLogueo = getdate() 
		WHERE CodigoUsuario = @CodigoUsuario
	END
	ELSE
	BEGIN
		declare @CantidadIntentoLogueo int = (select CantidadIntentoLogueo from Usuario WHERE CodigoUsuario = @CodigoUsuario)
		
		IF (@CantidadIntentoLogueo + 1 >= (select cast(Valor as int) from TablaLogicaDatos where Codigo = 'IntentoLogueo'))
		begin
			UPDATE Usuario 
			set Bloqueado = 1,
			CantidadIntentoLogueo = (select cast(Valor as int) from TablaLogicaDatos where Codigo = 'IntentoLogueo'),
			FechaUltimoIntentoLogueo = getdate()
			WHERE CodigoUsuario = @CodigoUsuario

			SET @Result = 5 
			SET @Mensaje = 'Su cuenta fue bloqueada, por superar la cantidad maxima de intento'
		end
		else
		begin
			SET @Result = 4 
			SET @Mensaje = 'Usuario o Contraseña Incorrectas'

			UPDATE Usuario 
			set CantidadIntentoLogueo = CantidadIntentoLogueo + 1, 
			FechaUltimoIntentoLogueo = getdate() 
			WHERE CodigoUsuario = @CodigoUsuario
		end
	END
		
	SELECT @Result AS Result, 
		@Mensaje AS Mensaje, 
		@CodigoUsuarioReal AS CodigoUsuario,
		@TipoUsuario AS TipoUsuario

	SET NOCOUNT OFF

END
go

USE BelcorpPanama
GO

ALTER PROCEDURE [dbo].[ValidarLogin]
-- exec ValidarLogin '044315718', '1'
(
	@CodigoUsuario VARCHAR(50),
	@Contrasenia VARCHAR(200)
)
AS
BEGIN

	SET NOCOUNT ON

	SET @Contrasenia = dbo.EncriptarClaveSHA1(@Contrasenia)

	DECLARE @Result TINYINT
	DECLARE @Mensaje VARCHAR(100)

	SET @Result = 0

	DECLARE @CodigoUsuarioReal VARCHAR(20)
	DECLARE @CodigoConsultora VARCHAR(20)
	DECLARE @PaisID INT
	DECLARE @TipoUsuario TINYINT
	DECLARE @RolID INT
	DECLARE @IsEmail BIT

	SELECT @IsEmail = dbo.fnAppEmailCheck(@CodigoUsuario)

	IF (@IsEmail = 1) 
	BEGIN
		SELECT
			@CodigoUsuarioReal = ISNULL(u.CodigoUsuario,''),
			@CodigoConsultora = ISNULL(u.CodigoConsultora,''),
			@PaisID = ISNULL(u.PaisID,0),
			@TipoUsuario = ISNULL(u.TipoUsuario,0),
			@RolID = ISNULL(ur.RolID,0)
		FROM Usuario u WITH(NOLOCK) 
		INNER JOIN UsuarioRol ur WITH(NOLOCK) ON u.CodigoUsuario = ur.CodigoUsuario 
			AND ur.Activo = 1
		WHERE u.Activo = 1
		AND u.Email = @CodigoUsuario
		AND u.ClaveSecreta = @Contrasenia
	END
	ELSE
	BEGIN
		SELECT
			@CodigoUsuarioReal = ISNULL(u.CodigoUsuario,''),
			@CodigoConsultora = ISNULL(u.CodigoConsultora,''),
			@PaisID = ISNULL(u.PaisID,0),
			@TipoUsuario = ISNULL(u.TipoUsuario,0),
			@RolID = ISNULL(ur.RolID,0)
		FROM Usuario u WITH(NOLOCK) 
		INNER JOIN UsuarioRol ur WITH(NOLOCK) ON u.CodigoUsuario = ur.CodigoUsuario 
			AND ur.Activo = 1
		WHERE u.Activo = 1
		AND u.CodigoUsuario = @CodigoUsuario
		AND u.ClaveSecreta = @Contrasenia
	END

	-- si no se encontro ahora buscar por doc identidad
	IF (ISNULL(@CodigoConsultora,'') = '')
	BEGIN
		SELECT
			@CodigoUsuarioReal = ISNULL(u.CodigoUsuario,''),
			@CodigoConsultora = ISNULL(u.CodigoConsultora,''),
			@PaisID = ISNULL(u.PaisID,0),
			@TipoUsuario = ISNULL(u.TipoUsuario,0),
			@RolID = ISNULL(ur.RolID,0)
		FROM Usuario u WITH(NOLOCK)
		INNER JOIN UsuarioRol ur WITH(NOLOCK) ON u.CodigoUsuario = ur.CodigoUsuario 
			AND ur.Activo = 1
		WHERE u.Activo = 1
		AND u.DocumentoIdentidad = @CodigoUsuario
		AND u.ClaveSecreta = @Contrasenia
	END

	-- validar si es usuario postulante
	IF (@TipoUsuario = 2 AND ISNULL(@CodigoUsuarioReal,'') != '')
	BEGIN
		IF EXISTS(
			SELECT 1 FROM UsuarioPostulante WITH(NOLOCK)
			WHERE CodigoUsuario = @CodigoUsuarioReal
			AND Estado = 1 AND ISNULL(UsuarioReal,'0') = '0'
		)
		BEGIN
			SET @CodigoConsultora = @CodigoUsuarioReal
		END
	END

	--Validar el # intentos de logueo y tiempo de espera
	declare @TiempoEsperaLogueo int = (select cast(Valor as int) from TablaLogicaDatos where Codigo = 'TiempoLogueo') --obtener tiempo de espera de logueo
	declare @FechaUltimoIntentoLogueo datetime = (select FechaUltimoIntentoLogueo from usuario where CodigoUsuario = @CodigoUsuario)
	declare @UsuarioBloqueado int = (select 1 from Usuario where CodigoUsuario = @CodigoUsuario and Bloqueado = 1)

	if (SELECT DATEDIFF(second, @FechaUltimoIntentoLogueo, getdate())) >  @TiempoEsperaLogueo and isnull(@UsuarioBloqueado,0) = 1
	begin
		UPDATE Usuario 
		set CantidadIntentoLogueo = 0, 
		Bloqueado = 0,
		FechaUltimoIntentoLogueo = getdate() 
		WHERE CodigoUsuario = @CodigoUsuario
	end

	IF exists(select 1 from Usuario where CodigoUsuario = @CodigoUsuario and Bloqueado = 1)
	begin			
		SET @Result = 5 
		SET @Mensaje = 'Su cuenta fue bloqueada, por superar la cantidad maxima de intento'
	end
	ELSE IF (ISNULL(@CodigoConsultora,'') != '' AND @PaisID != 0)
	BEGIN
		SELECT @Result = Result, @Mensaje = Mensaje 
		FROM dbo.fnGetAccesoUsuario(@PaisID,@CodigoUsuarioReal,@CodigoConsultora,@TipoUsuario,@RolID)
		
		UPDATE Usuario 
		set CantidadIntentoLogueo = 0, 
		FechaUltimoIntentoLogueo = getdate() 
		WHERE CodigoUsuario = @CodigoUsuario
	END
	ELSE
	BEGIN
		declare @CantidadIntentoLogueo int = (select CantidadIntentoLogueo from Usuario WHERE CodigoUsuario = @CodigoUsuario)
		
		IF (@CantidadIntentoLogueo + 1 >= (select cast(Valor as int) from TablaLogicaDatos where Codigo = 'IntentoLogueo'))
		begin
			UPDATE Usuario 
			set Bloqueado = 1,
			CantidadIntentoLogueo = (select cast(Valor as int) from TablaLogicaDatos where Codigo = 'IntentoLogueo'),
			FechaUltimoIntentoLogueo = getdate()
			WHERE CodigoUsuario = @CodigoUsuario

			SET @Result = 5 
			SET @Mensaje = 'Su cuenta fue bloqueada, por superar la cantidad maxima de intento'
		end
		else
		begin
			SET @Result = 4 
			SET @Mensaje = 'Usuario o Contraseña Incorrectas'

			UPDATE Usuario 
			set CantidadIntentoLogueo = CantidadIntentoLogueo + 1, 
			FechaUltimoIntentoLogueo = getdate() 
			WHERE CodigoUsuario = @CodigoUsuario
		end
	END
		
	SELECT @Result AS Result, 
		@Mensaje AS Mensaje, 
		@CodigoUsuarioReal AS CodigoUsuario,
		@TipoUsuario AS TipoUsuario

	SET NOCOUNT OFF

END
go

USE BelcorpGuatemala
GO

ALTER PROCEDURE [dbo].[ValidarLogin]
-- exec ValidarLogin '044315718', '1'
(
	@CodigoUsuario VARCHAR(50),
	@Contrasenia VARCHAR(200)
)
AS
BEGIN

	SET NOCOUNT ON

	SET @Contrasenia = dbo.EncriptarClaveSHA1(@Contrasenia)

	DECLARE @Result TINYINT
	DECLARE @Mensaje VARCHAR(100)

	SET @Result = 0

	DECLARE @CodigoUsuarioReal VARCHAR(20)
	DECLARE @CodigoConsultora VARCHAR(20)
	DECLARE @PaisID INT
	DECLARE @TipoUsuario TINYINT
	DECLARE @RolID INT
	DECLARE @IsEmail BIT

	SELECT @IsEmail = dbo.fnAppEmailCheck(@CodigoUsuario)

	IF (@IsEmail = 1) 
	BEGIN
		SELECT
			@CodigoUsuarioReal = ISNULL(u.CodigoUsuario,''),
			@CodigoConsultora = ISNULL(u.CodigoConsultora,''),
			@PaisID = ISNULL(u.PaisID,0),
			@TipoUsuario = ISNULL(u.TipoUsuario,0),
			@RolID = ISNULL(ur.RolID,0)
		FROM Usuario u WITH(NOLOCK) 
		INNER JOIN UsuarioRol ur WITH(NOLOCK) ON u.CodigoUsuario = ur.CodigoUsuario 
			AND ur.Activo = 1
		WHERE u.Activo = 1
		AND u.Email = @CodigoUsuario
		AND u.ClaveSecreta = @Contrasenia
	END
	ELSE
	BEGIN
		SELECT
			@CodigoUsuarioReal = ISNULL(u.CodigoUsuario,''),
			@CodigoConsultora = ISNULL(u.CodigoConsultora,''),
			@PaisID = ISNULL(u.PaisID,0),
			@TipoUsuario = ISNULL(u.TipoUsuario,0),
			@RolID = ISNULL(ur.RolID,0)
		FROM Usuario u WITH(NOLOCK) 
		INNER JOIN UsuarioRol ur WITH(NOLOCK) ON u.CodigoUsuario = ur.CodigoUsuario 
			AND ur.Activo = 1
		WHERE u.Activo = 1
		AND u.CodigoUsuario = @CodigoUsuario
		AND u.ClaveSecreta = @Contrasenia
	END

	-- si no se encontro ahora buscar por doc identidad
	IF (ISNULL(@CodigoConsultora,'') = '')
	BEGIN
		SELECT
			@CodigoUsuarioReal = ISNULL(u.CodigoUsuario,''),
			@CodigoConsultora = ISNULL(u.CodigoConsultora,''),
			@PaisID = ISNULL(u.PaisID,0),
			@TipoUsuario = ISNULL(u.TipoUsuario,0),
			@RolID = ISNULL(ur.RolID,0)
		FROM Usuario u WITH(NOLOCK)
		INNER JOIN UsuarioRol ur WITH(NOLOCK) ON u.CodigoUsuario = ur.CodigoUsuario 
			AND ur.Activo = 1
		WHERE u.Activo = 1
		AND u.DocumentoIdentidad = @CodigoUsuario
		AND u.ClaveSecreta = @Contrasenia
	END

	-- validar si es usuario postulante
	IF (@TipoUsuario = 2 AND ISNULL(@CodigoUsuarioReal,'') != '')
	BEGIN
		IF EXISTS(
			SELECT 1 FROM UsuarioPostulante WITH(NOLOCK)
			WHERE CodigoUsuario = @CodigoUsuarioReal
			AND Estado = 1 AND ISNULL(UsuarioReal,'0') = '0'
		)
		BEGIN
			SET @CodigoConsultora = @CodigoUsuarioReal
		END
	END

	--Validar el # intentos de logueo y tiempo de espera
	declare @TiempoEsperaLogueo int = (select cast(Valor as int) from TablaLogicaDatos where Codigo = 'TiempoLogueo') --obtener tiempo de espera de logueo
	declare @FechaUltimoIntentoLogueo datetime = (select FechaUltimoIntentoLogueo from usuario where CodigoUsuario = @CodigoUsuario)
	declare @UsuarioBloqueado int = (select 1 from Usuario where CodigoUsuario = @CodigoUsuario and Bloqueado = 1)

	if (SELECT DATEDIFF(second, @FechaUltimoIntentoLogueo, getdate())) >  @TiempoEsperaLogueo and isnull(@UsuarioBloqueado,0) = 1
	begin
		UPDATE Usuario 
		set CantidadIntentoLogueo = 0, 
		Bloqueado = 0,
		FechaUltimoIntentoLogueo = getdate() 
		WHERE CodigoUsuario = @CodigoUsuario
	end

	IF exists(select 1 from Usuario where CodigoUsuario = @CodigoUsuario and Bloqueado = 1)
	begin			
		SET @Result = 5 
		SET @Mensaje = 'Su cuenta fue bloqueada, por superar la cantidad maxima de intento'
	end
	ELSE IF (ISNULL(@CodigoConsultora,'') != '' AND @PaisID != 0)
	BEGIN
		SELECT @Result = Result, @Mensaje = Mensaje 
		FROM dbo.fnGetAccesoUsuario(@PaisID,@CodigoUsuarioReal,@CodigoConsultora,@TipoUsuario,@RolID)
		
		UPDATE Usuario 
		set CantidadIntentoLogueo = 0, 
		FechaUltimoIntentoLogueo = getdate() 
		WHERE CodigoUsuario = @CodigoUsuario
	END
	ELSE
	BEGIN
		declare @CantidadIntentoLogueo int = (select CantidadIntentoLogueo from Usuario WHERE CodigoUsuario = @CodigoUsuario)
		
		IF (@CantidadIntentoLogueo + 1 >= (select cast(Valor as int) from TablaLogicaDatos where Codigo = 'IntentoLogueo'))
		begin
			UPDATE Usuario 
			set Bloqueado = 1,
			CantidadIntentoLogueo = (select cast(Valor as int) from TablaLogicaDatos where Codigo = 'IntentoLogueo'),
			FechaUltimoIntentoLogueo = getdate()
			WHERE CodigoUsuario = @CodigoUsuario

			SET @Result = 5 
			SET @Mensaje = 'Su cuenta fue bloqueada, por superar la cantidad maxima de intento'
		end
		else
		begin
			SET @Result = 4 
			SET @Mensaje = 'Usuario o Contraseña Incorrectas'

			UPDATE Usuario 
			set CantidadIntentoLogueo = CantidadIntentoLogueo + 1, 
			FechaUltimoIntentoLogueo = getdate() 
			WHERE CodigoUsuario = @CodigoUsuario
		end
	END
		
	SELECT @Result AS Result, 
		@Mensaje AS Mensaje, 
		@CodigoUsuarioReal AS CodigoUsuario,
		@TipoUsuario AS TipoUsuario

	SET NOCOUNT OFF

END
go

USE BelcorpEcuador
GO

ALTER PROCEDURE [dbo].[ValidarLogin]
-- exec ValidarLogin '044315718', '1'
(
	@CodigoUsuario VARCHAR(50),
	@Contrasenia VARCHAR(200)
)
AS
BEGIN

	SET NOCOUNT ON

	SET @Contrasenia = dbo.EncriptarClaveSHA1(@Contrasenia)

	DECLARE @Result TINYINT
	DECLARE @Mensaje VARCHAR(100)

	SET @Result = 0

	DECLARE @CodigoUsuarioReal VARCHAR(20)
	DECLARE @CodigoConsultora VARCHAR(20)
	DECLARE @PaisID INT
	DECLARE @TipoUsuario TINYINT
	DECLARE @RolID INT
	DECLARE @IsEmail BIT

	SELECT @IsEmail = dbo.fnAppEmailCheck(@CodigoUsuario)

	IF (@IsEmail = 1) 
	BEGIN
		SELECT
			@CodigoUsuarioReal = ISNULL(u.CodigoUsuario,''),
			@CodigoConsultora = ISNULL(u.CodigoConsultora,''),
			@PaisID = ISNULL(u.PaisID,0),
			@TipoUsuario = ISNULL(u.TipoUsuario,0),
			@RolID = ISNULL(ur.RolID,0)
		FROM Usuario u WITH(NOLOCK) 
		INNER JOIN UsuarioRol ur WITH(NOLOCK) ON u.CodigoUsuario = ur.CodigoUsuario 
			AND ur.Activo = 1
		WHERE u.Activo = 1
		AND u.Email = @CodigoUsuario
		AND u.ClaveSecreta = @Contrasenia
	END
	ELSE
	BEGIN
		SELECT
			@CodigoUsuarioReal = ISNULL(u.CodigoUsuario,''),
			@CodigoConsultora = ISNULL(u.CodigoConsultora,''),
			@PaisID = ISNULL(u.PaisID,0),
			@TipoUsuario = ISNULL(u.TipoUsuario,0),
			@RolID = ISNULL(ur.RolID,0)
		FROM Usuario u WITH(NOLOCK) 
		INNER JOIN UsuarioRol ur WITH(NOLOCK) ON u.CodigoUsuario = ur.CodigoUsuario 
			AND ur.Activo = 1
		WHERE u.Activo = 1
		AND u.CodigoUsuario = @CodigoUsuario
		AND u.ClaveSecreta = @Contrasenia
	END

	-- si no se encontro ahora buscar por doc identidad
	IF (ISNULL(@CodigoConsultora,'') = '')
	BEGIN
		SELECT
			@CodigoUsuarioReal = ISNULL(u.CodigoUsuario,''),
			@CodigoConsultora = ISNULL(u.CodigoConsultora,''),
			@PaisID = ISNULL(u.PaisID,0),
			@TipoUsuario = ISNULL(u.TipoUsuario,0),
			@RolID = ISNULL(ur.RolID,0)
		FROM Usuario u WITH(NOLOCK)
		INNER JOIN UsuarioRol ur WITH(NOLOCK) ON u.CodigoUsuario = ur.CodigoUsuario 
			AND ur.Activo = 1
		WHERE u.Activo = 1
		AND u.DocumentoIdentidad = @CodigoUsuario
		AND u.ClaveSecreta = @Contrasenia
	END

	-- validar si es usuario postulante
	IF (@TipoUsuario = 2 AND ISNULL(@CodigoUsuarioReal,'') != '')
	BEGIN
		IF EXISTS(
			SELECT 1 FROM UsuarioPostulante WITH(NOLOCK)
			WHERE CodigoUsuario = @CodigoUsuarioReal
			AND Estado = 1 AND ISNULL(UsuarioReal,'0') = '0'
		)
		BEGIN
			SET @CodigoConsultora = @CodigoUsuarioReal
		END
	END

	--Validar el # intentos de logueo y tiempo de espera
	declare @TiempoEsperaLogueo int = (select cast(Valor as int) from TablaLogicaDatos where Codigo = 'TiempoLogueo') --obtener tiempo de espera de logueo
	declare @FechaUltimoIntentoLogueo datetime = (select FechaUltimoIntentoLogueo from usuario where CodigoUsuario = @CodigoUsuario)
	declare @UsuarioBloqueado int = (select 1 from Usuario where CodigoUsuario = @CodigoUsuario and Bloqueado = 1)

	if (SELECT DATEDIFF(second, @FechaUltimoIntentoLogueo, getdate())) >  @TiempoEsperaLogueo and isnull(@UsuarioBloqueado,0) = 1
	begin
		UPDATE Usuario 
		set CantidadIntentoLogueo = 0, 
		Bloqueado = 0,
		FechaUltimoIntentoLogueo = getdate() 
		WHERE CodigoUsuario = @CodigoUsuario
	end

	IF exists(select 1 from Usuario where CodigoUsuario = @CodigoUsuario and Bloqueado = 1)
	begin			
		SET @Result = 5 
		SET @Mensaje = 'Su cuenta fue bloqueada, por superar la cantidad maxima de intento'
	end
	ELSE IF (ISNULL(@CodigoConsultora,'') != '' AND @PaisID != 0)
	BEGIN
		SELECT @Result = Result, @Mensaje = Mensaje 
		FROM dbo.fnGetAccesoUsuario(@PaisID,@CodigoUsuarioReal,@CodigoConsultora,@TipoUsuario,@RolID)
		
		UPDATE Usuario 
		set CantidadIntentoLogueo = 0, 
		FechaUltimoIntentoLogueo = getdate() 
		WHERE CodigoUsuario = @CodigoUsuario
	END
	ELSE
	BEGIN
		declare @CantidadIntentoLogueo int = (select CantidadIntentoLogueo from Usuario WHERE CodigoUsuario = @CodigoUsuario)
		
		IF (@CantidadIntentoLogueo + 1 >= (select cast(Valor as int) from TablaLogicaDatos where Codigo = 'IntentoLogueo'))
		begin
			UPDATE Usuario 
			set Bloqueado = 1,
			CantidadIntentoLogueo = (select cast(Valor as int) from TablaLogicaDatos where Codigo = 'IntentoLogueo'),
			FechaUltimoIntentoLogueo = getdate()
			WHERE CodigoUsuario = @CodigoUsuario

			SET @Result = 5 
			SET @Mensaje = 'Su cuenta fue bloqueada, por superar la cantidad maxima de intento'
		end
		else
		begin
			SET @Result = 4 
			SET @Mensaje = 'Usuario o Contraseña Incorrectas'

			UPDATE Usuario 
			set CantidadIntentoLogueo = CantidadIntentoLogueo + 1, 
			FechaUltimoIntentoLogueo = getdate() 
			WHERE CodigoUsuario = @CodigoUsuario
		end
	END
		
	SELECT @Result AS Result, 
		@Mensaje AS Mensaje, 
		@CodigoUsuarioReal AS CodigoUsuario,
		@TipoUsuario AS TipoUsuario

	SET NOCOUNT OFF

END
go

USE BelcorpDominicana
GO

ALTER PROCEDURE [dbo].[ValidarLogin]
-- exec ValidarLogin '044315718', '1'
(
	@CodigoUsuario VARCHAR(50),
	@Contrasenia VARCHAR(200)
)
AS
BEGIN

	SET NOCOUNT ON

	SET @Contrasenia = dbo.EncriptarClaveSHA1(@Contrasenia)

	DECLARE @Result TINYINT
	DECLARE @Mensaje VARCHAR(100)

	SET @Result = 0

	DECLARE @CodigoUsuarioReal VARCHAR(20)
	DECLARE @CodigoConsultora VARCHAR(20)
	DECLARE @PaisID INT
	DECLARE @TipoUsuario TINYINT
	DECLARE @RolID INT
	DECLARE @IsEmail BIT

	SELECT @IsEmail = dbo.fnAppEmailCheck(@CodigoUsuario)

	IF (@IsEmail = 1) 
	BEGIN
		SELECT
			@CodigoUsuarioReal = ISNULL(u.CodigoUsuario,''),
			@CodigoConsultora = ISNULL(u.CodigoConsultora,''),
			@PaisID = ISNULL(u.PaisID,0),
			@TipoUsuario = ISNULL(u.TipoUsuario,0),
			@RolID = ISNULL(ur.RolID,0)
		FROM Usuario u WITH(NOLOCK) 
		INNER JOIN UsuarioRol ur WITH(NOLOCK) ON u.CodigoUsuario = ur.CodigoUsuario 
			AND ur.Activo = 1
		WHERE u.Activo = 1
		AND u.Email = @CodigoUsuario
		AND u.ClaveSecreta = @Contrasenia
	END
	ELSE
	BEGIN
		SELECT
			@CodigoUsuarioReal = ISNULL(u.CodigoUsuario,''),
			@CodigoConsultora = ISNULL(u.CodigoConsultora,''),
			@PaisID = ISNULL(u.PaisID,0),
			@TipoUsuario = ISNULL(u.TipoUsuario,0),
			@RolID = ISNULL(ur.RolID,0)
		FROM Usuario u WITH(NOLOCK) 
		INNER JOIN UsuarioRol ur WITH(NOLOCK) ON u.CodigoUsuario = ur.CodigoUsuario 
			AND ur.Activo = 1
		WHERE u.Activo = 1
		AND u.CodigoUsuario = @CodigoUsuario
		AND u.ClaveSecreta = @Contrasenia
	END

	-- si no se encontro ahora buscar por doc identidad
	IF (ISNULL(@CodigoConsultora,'') = '')
	BEGIN
		SELECT
			@CodigoUsuarioReal = ISNULL(u.CodigoUsuario,''),
			@CodigoConsultora = ISNULL(u.CodigoConsultora,''),
			@PaisID = ISNULL(u.PaisID,0),
			@TipoUsuario = ISNULL(u.TipoUsuario,0),
			@RolID = ISNULL(ur.RolID,0)
		FROM Usuario u WITH(NOLOCK)
		INNER JOIN UsuarioRol ur WITH(NOLOCK) ON u.CodigoUsuario = ur.CodigoUsuario 
			AND ur.Activo = 1
		WHERE u.Activo = 1
		AND u.DocumentoIdentidad = @CodigoUsuario
		AND u.ClaveSecreta = @Contrasenia
	END

	-- validar si es usuario postulante
	IF (@TipoUsuario = 2 AND ISNULL(@CodigoUsuarioReal,'') != '')
	BEGIN
		IF EXISTS(
			SELECT 1 FROM UsuarioPostulante WITH(NOLOCK)
			WHERE CodigoUsuario = @CodigoUsuarioReal
			AND Estado = 1 AND ISNULL(UsuarioReal,'0') = '0'
		)
		BEGIN
			SET @CodigoConsultora = @CodigoUsuarioReal
		END
	END

	--Validar el # intentos de logueo y tiempo de espera
	declare @TiempoEsperaLogueo int = (select cast(Valor as int) from TablaLogicaDatos where Codigo = 'TiempoLogueo') --obtener tiempo de espera de logueo
	declare @FechaUltimoIntentoLogueo datetime = (select FechaUltimoIntentoLogueo from usuario where CodigoUsuario = @CodigoUsuario)
	declare @UsuarioBloqueado int = (select 1 from Usuario where CodigoUsuario = @CodigoUsuario and Bloqueado = 1)

	if (SELECT DATEDIFF(second, @FechaUltimoIntentoLogueo, getdate())) >  @TiempoEsperaLogueo and isnull(@UsuarioBloqueado,0) = 1
	begin
		UPDATE Usuario 
		set CantidadIntentoLogueo = 0, 
		Bloqueado = 0,
		FechaUltimoIntentoLogueo = getdate() 
		WHERE CodigoUsuario = @CodigoUsuario
	end

	IF exists(select 1 from Usuario where CodigoUsuario = @CodigoUsuario and Bloqueado = 1)
	begin			
		SET @Result = 5 
		SET @Mensaje = 'Su cuenta fue bloqueada, por superar la cantidad maxima de intento'
	end
	ELSE IF (ISNULL(@CodigoConsultora,'') != '' AND @PaisID != 0)
	BEGIN
		SELECT @Result = Result, @Mensaje = Mensaje 
		FROM dbo.fnGetAccesoUsuario(@PaisID,@CodigoUsuarioReal,@CodigoConsultora,@TipoUsuario,@RolID)
		
		UPDATE Usuario 
		set CantidadIntentoLogueo = 0, 
		FechaUltimoIntentoLogueo = getdate() 
		WHERE CodigoUsuario = @CodigoUsuario
	END
	ELSE
	BEGIN
		declare @CantidadIntentoLogueo int = (select CantidadIntentoLogueo from Usuario WHERE CodigoUsuario = @CodigoUsuario)
		
		IF (@CantidadIntentoLogueo + 1 >= (select cast(Valor as int) from TablaLogicaDatos where Codigo = 'IntentoLogueo'))
		begin
			UPDATE Usuario 
			set Bloqueado = 1,
			CantidadIntentoLogueo = (select cast(Valor as int) from TablaLogicaDatos where Codigo = 'IntentoLogueo'),
			FechaUltimoIntentoLogueo = getdate()
			WHERE CodigoUsuario = @CodigoUsuario

			SET @Result = 5 
			SET @Mensaje = 'Su cuenta fue bloqueada, por superar la cantidad maxima de intento'
		end
		else
		begin
			SET @Result = 4 
			SET @Mensaje = 'Usuario o Contraseña Incorrectas'

			UPDATE Usuario 
			set CantidadIntentoLogueo = CantidadIntentoLogueo + 1, 
			FechaUltimoIntentoLogueo = getdate() 
			WHERE CodigoUsuario = @CodigoUsuario
		end
	END
		
	SELECT @Result AS Result, 
		@Mensaje AS Mensaje, 
		@CodigoUsuarioReal AS CodigoUsuario,
		@TipoUsuario AS TipoUsuario

	SET NOCOUNT OFF

END
go

USE BelcorpCostaRica
GO

ALTER PROCEDURE [dbo].[ValidarLogin]
-- exec ValidarLogin '044315718', '1'
(
	@CodigoUsuario VARCHAR(50),
	@Contrasenia VARCHAR(200)
)
AS
BEGIN

	SET NOCOUNT ON

	SET @Contrasenia = dbo.EncriptarClaveSHA1(@Contrasenia)

	DECLARE @Result TINYINT
	DECLARE @Mensaje VARCHAR(100)

	SET @Result = 0

	DECLARE @CodigoUsuarioReal VARCHAR(20)
	DECLARE @CodigoConsultora VARCHAR(20)
	DECLARE @PaisID INT
	DECLARE @TipoUsuario TINYINT
	DECLARE @RolID INT
	DECLARE @IsEmail BIT

	SELECT @IsEmail = dbo.fnAppEmailCheck(@CodigoUsuario)

	IF (@IsEmail = 1) 
	BEGIN
		SELECT
			@CodigoUsuarioReal = ISNULL(u.CodigoUsuario,''),
			@CodigoConsultora = ISNULL(u.CodigoConsultora,''),
			@PaisID = ISNULL(u.PaisID,0),
			@TipoUsuario = ISNULL(u.TipoUsuario,0),
			@RolID = ISNULL(ur.RolID,0)
		FROM Usuario u WITH(NOLOCK) 
		INNER JOIN UsuarioRol ur WITH(NOLOCK) ON u.CodigoUsuario = ur.CodigoUsuario 
			AND ur.Activo = 1
		WHERE u.Activo = 1
		AND u.Email = @CodigoUsuario
		AND u.ClaveSecreta = @Contrasenia
	END
	ELSE
	BEGIN
		SELECT
			@CodigoUsuarioReal = ISNULL(u.CodigoUsuario,''),
			@CodigoConsultora = ISNULL(u.CodigoConsultora,''),
			@PaisID = ISNULL(u.PaisID,0),
			@TipoUsuario = ISNULL(u.TipoUsuario,0),
			@RolID = ISNULL(ur.RolID,0)
		FROM Usuario u WITH(NOLOCK) 
		INNER JOIN UsuarioRol ur WITH(NOLOCK) ON u.CodigoUsuario = ur.CodigoUsuario 
			AND ur.Activo = 1
		WHERE u.Activo = 1
		AND u.CodigoUsuario = @CodigoUsuario
		AND u.ClaveSecreta = @Contrasenia
	END

	-- si no se encontro ahora buscar por doc identidad
	IF (ISNULL(@CodigoConsultora,'') = '')
	BEGIN
		SELECT
			@CodigoUsuarioReal = ISNULL(u.CodigoUsuario,''),
			@CodigoConsultora = ISNULL(u.CodigoConsultora,''),
			@PaisID = ISNULL(u.PaisID,0),
			@TipoUsuario = ISNULL(u.TipoUsuario,0),
			@RolID = ISNULL(ur.RolID,0)
		FROM Usuario u WITH(NOLOCK)
		INNER JOIN UsuarioRol ur WITH(NOLOCK) ON u.CodigoUsuario = ur.CodigoUsuario 
			AND ur.Activo = 1
		WHERE u.Activo = 1
		AND u.DocumentoIdentidad = @CodigoUsuario
		AND u.ClaveSecreta = @Contrasenia
	END

	-- validar si es usuario postulante
	IF (@TipoUsuario = 2 AND ISNULL(@CodigoUsuarioReal,'') != '')
	BEGIN
		IF EXISTS(
			SELECT 1 FROM UsuarioPostulante WITH(NOLOCK)
			WHERE CodigoUsuario = @CodigoUsuarioReal
			AND Estado = 1 AND ISNULL(UsuarioReal,'0') = '0'
		)
		BEGIN
			SET @CodigoConsultora = @CodigoUsuarioReal
		END
	END

	--Validar el # intentos de logueo y tiempo de espera
	declare @TiempoEsperaLogueo int = (select cast(Valor as int) from TablaLogicaDatos where Codigo = 'TiempoLogueo') --obtener tiempo de espera de logueo
	declare @FechaUltimoIntentoLogueo datetime = (select FechaUltimoIntentoLogueo from usuario where CodigoUsuario = @CodigoUsuario)
	declare @UsuarioBloqueado int = (select 1 from Usuario where CodigoUsuario = @CodigoUsuario and Bloqueado = 1)

	if (SELECT DATEDIFF(second, @FechaUltimoIntentoLogueo, getdate())) >  @TiempoEsperaLogueo and isnull(@UsuarioBloqueado,0) = 1
	begin
		UPDATE Usuario 
		set CantidadIntentoLogueo = 0, 
		Bloqueado = 0,
		FechaUltimoIntentoLogueo = getdate() 
		WHERE CodigoUsuario = @CodigoUsuario
	end

	IF exists(select 1 from Usuario where CodigoUsuario = @CodigoUsuario and Bloqueado = 1)
	begin			
		SET @Result = 5 
		SET @Mensaje = 'Su cuenta fue bloqueada, por superar la cantidad maxima de intento'
	end
	ELSE IF (ISNULL(@CodigoConsultora,'') != '' AND @PaisID != 0)
	BEGIN
		SELECT @Result = Result, @Mensaje = Mensaje 
		FROM dbo.fnGetAccesoUsuario(@PaisID,@CodigoUsuarioReal,@CodigoConsultora,@TipoUsuario,@RolID)
		
		UPDATE Usuario 
		set CantidadIntentoLogueo = 0, 
		FechaUltimoIntentoLogueo = getdate() 
		WHERE CodigoUsuario = @CodigoUsuario
	END
	ELSE
	BEGIN
		declare @CantidadIntentoLogueo int = (select CantidadIntentoLogueo from Usuario WHERE CodigoUsuario = @CodigoUsuario)
		
		IF (@CantidadIntentoLogueo + 1 >= (select cast(Valor as int) from TablaLogicaDatos where Codigo = 'IntentoLogueo'))
		begin
			UPDATE Usuario 
			set Bloqueado = 1,
			CantidadIntentoLogueo = (select cast(Valor as int) from TablaLogicaDatos where Codigo = 'IntentoLogueo'),
			FechaUltimoIntentoLogueo = getdate()
			WHERE CodigoUsuario = @CodigoUsuario

			SET @Result = 5 
			SET @Mensaje = 'Su cuenta fue bloqueada, por superar la cantidad maxima de intento'
		end
		else
		begin
			SET @Result = 4 
			SET @Mensaje = 'Usuario o Contraseña Incorrectas'

			UPDATE Usuario 
			set CantidadIntentoLogueo = CantidadIntentoLogueo + 1, 
			FechaUltimoIntentoLogueo = getdate() 
			WHERE CodigoUsuario = @CodigoUsuario
		end
	END
		
	SELECT @Result AS Result, 
		@Mensaje AS Mensaje, 
		@CodigoUsuarioReal AS CodigoUsuario,
		@TipoUsuario AS TipoUsuario

	SET NOCOUNT OFF

END
go

USE BelcorpChile
GO

ALTER PROCEDURE [dbo].[ValidarLogin]
-- exec ValidarLogin '044315718', '1'
(
	@CodigoUsuario VARCHAR(50),
	@Contrasenia VARCHAR(200)
)
AS
BEGIN

	SET NOCOUNT ON

	SET @Contrasenia = dbo.EncriptarClaveSHA1(@Contrasenia)

	DECLARE @Result TINYINT
	DECLARE @Mensaje VARCHAR(100)

	SET @Result = 0

	DECLARE @CodigoUsuarioReal VARCHAR(20)
	DECLARE @CodigoConsultora VARCHAR(20)
	DECLARE @PaisID INT
	DECLARE @TipoUsuario TINYINT
	DECLARE @RolID INT
	DECLARE @IsEmail BIT

	SELECT @IsEmail = dbo.fnAppEmailCheck(@CodigoUsuario)

	IF (@IsEmail = 1) 
	BEGIN
		SELECT
			@CodigoUsuarioReal = ISNULL(u.CodigoUsuario,''),
			@CodigoConsultora = ISNULL(u.CodigoConsultora,''),
			@PaisID = ISNULL(u.PaisID,0),
			@TipoUsuario = ISNULL(u.TipoUsuario,0),
			@RolID = ISNULL(ur.RolID,0)
		FROM Usuario u WITH(NOLOCK) 
		INNER JOIN UsuarioRol ur WITH(NOLOCK) ON u.CodigoUsuario = ur.CodigoUsuario 
			AND ur.Activo = 1
		WHERE u.Activo = 1
		AND u.Email = @CodigoUsuario
		AND u.ClaveSecreta = @Contrasenia
	END
	ELSE
	BEGIN
		SELECT
			@CodigoUsuarioReal = ISNULL(u.CodigoUsuario,''),
			@CodigoConsultora = ISNULL(u.CodigoConsultora,''),
			@PaisID = ISNULL(u.PaisID,0),
			@TipoUsuario = ISNULL(u.TipoUsuario,0),
			@RolID = ISNULL(ur.RolID,0)
		FROM Usuario u WITH(NOLOCK) 
		INNER JOIN UsuarioRol ur WITH(NOLOCK) ON u.CodigoUsuario = ur.CodigoUsuario 
			AND ur.Activo = 1
		WHERE u.Activo = 1
		AND u.CodigoUsuario = @CodigoUsuario
		AND u.ClaveSecreta = @Contrasenia
	END

	-- si no se encontro ahora buscar por doc identidad
	IF (ISNULL(@CodigoConsultora,'') = '')
	BEGIN
		SELECT
			@CodigoUsuarioReal = ISNULL(u.CodigoUsuario,''),
			@CodigoConsultora = ISNULL(u.CodigoConsultora,''),
			@PaisID = ISNULL(u.PaisID,0),
			@TipoUsuario = ISNULL(u.TipoUsuario,0),
			@RolID = ISNULL(ur.RolID,0)
		FROM Usuario u WITH(NOLOCK)
		INNER JOIN UsuarioRol ur WITH(NOLOCK) ON u.CodigoUsuario = ur.CodigoUsuario 
			AND ur.Activo = 1
		WHERE u.Activo = 1
		AND u.DocumentoIdentidad = @CodigoUsuario
		AND u.ClaveSecreta = @Contrasenia
	END

	-- validar si es usuario postulante
	IF (@TipoUsuario = 2 AND ISNULL(@CodigoUsuarioReal,'') != '')
	BEGIN
		IF EXISTS(
			SELECT 1 FROM UsuarioPostulante WITH(NOLOCK)
			WHERE CodigoUsuario = @CodigoUsuarioReal
			AND Estado = 1 AND ISNULL(UsuarioReal,'0') = '0'
		)
		BEGIN
			SET @CodigoConsultora = @CodigoUsuarioReal
		END
	END

	--Validar el # intentos de logueo y tiempo de espera
	declare @TiempoEsperaLogueo int = (select cast(Valor as int) from TablaLogicaDatos where Codigo = 'TiempoLogueo') --obtener tiempo de espera de logueo
	declare @FechaUltimoIntentoLogueo datetime = (select FechaUltimoIntentoLogueo from usuario where CodigoUsuario = @CodigoUsuario)
	declare @UsuarioBloqueado int = (select 1 from Usuario where CodigoUsuario = @CodigoUsuario and Bloqueado = 1)

	if (SELECT DATEDIFF(second, @FechaUltimoIntentoLogueo, getdate())) >  @TiempoEsperaLogueo and isnull(@UsuarioBloqueado,0) = 1
	begin
		UPDATE Usuario 
		set CantidadIntentoLogueo = 0, 
		Bloqueado = 0,
		FechaUltimoIntentoLogueo = getdate() 
		WHERE CodigoUsuario = @CodigoUsuario
	end

	IF exists(select 1 from Usuario where CodigoUsuario = @CodigoUsuario and Bloqueado = 1)
	begin			
		SET @Result = 5 
		SET @Mensaje = 'Su cuenta fue bloqueada, por superar la cantidad maxima de intento'
	end
	ELSE IF (ISNULL(@CodigoConsultora,'') != '' AND @PaisID != 0)
	BEGIN
		SELECT @Result = Result, @Mensaje = Mensaje 
		FROM dbo.fnGetAccesoUsuario(@PaisID,@CodigoUsuarioReal,@CodigoConsultora,@TipoUsuario,@RolID)
		
		UPDATE Usuario 
		set CantidadIntentoLogueo = 0, 
		FechaUltimoIntentoLogueo = getdate() 
		WHERE CodigoUsuario = @CodigoUsuario
	END
	ELSE
	BEGIN
		declare @CantidadIntentoLogueo int = (select CantidadIntentoLogueo from Usuario WHERE CodigoUsuario = @CodigoUsuario)
		
		IF (@CantidadIntentoLogueo + 1 >= (select cast(Valor as int) from TablaLogicaDatos where Codigo = 'IntentoLogueo'))
		begin
			UPDATE Usuario 
			set Bloqueado = 1,
			CantidadIntentoLogueo = (select cast(Valor as int) from TablaLogicaDatos where Codigo = 'IntentoLogueo'),
			FechaUltimoIntentoLogueo = getdate()
			WHERE CodigoUsuario = @CodigoUsuario

			SET @Result = 5 
			SET @Mensaje = 'Su cuenta fue bloqueada, por superar la cantidad maxima de intento'
		end
		else
		begin
			SET @Result = 4 
			SET @Mensaje = 'Usuario o Contraseña Incorrectas'

			UPDATE Usuario 
			set CantidadIntentoLogueo = CantidadIntentoLogueo + 1, 
			FechaUltimoIntentoLogueo = getdate() 
			WHERE CodigoUsuario = @CodigoUsuario
		end
	END
		
	SELECT @Result AS Result, 
		@Mensaje AS Mensaje, 
		@CodigoUsuarioReal AS CodigoUsuario,
		@TipoUsuario AS TipoUsuario

	SET NOCOUNT OFF

END
go

USE BelcorpBolivia
GO

ALTER PROCEDURE [dbo].[ValidarLogin]
-- exec ValidarLogin '044315718', '1'
(
	@CodigoUsuario VARCHAR(50),
	@Contrasenia VARCHAR(200)
)
AS
BEGIN

	SET NOCOUNT ON

	SET @Contrasenia = dbo.EncriptarClaveSHA1(@Contrasenia)

	DECLARE @Result TINYINT
	DECLARE @Mensaje VARCHAR(100)

	SET @Result = 0

	DECLARE @CodigoUsuarioReal VARCHAR(20)
	DECLARE @CodigoConsultora VARCHAR(20)
	DECLARE @PaisID INT
	DECLARE @TipoUsuario TINYINT
	DECLARE @RolID INT
	DECLARE @IsEmail BIT

	SELECT @IsEmail = dbo.fnAppEmailCheck(@CodigoUsuario)

	IF (@IsEmail = 1) 
	BEGIN
		SELECT
			@CodigoUsuarioReal = ISNULL(u.CodigoUsuario,''),
			@CodigoConsultora = ISNULL(u.CodigoConsultora,''),
			@PaisID = ISNULL(u.PaisID,0),
			@TipoUsuario = ISNULL(u.TipoUsuario,0),
			@RolID = ISNULL(ur.RolID,0)
		FROM Usuario u WITH(NOLOCK) 
		INNER JOIN UsuarioRol ur WITH(NOLOCK) ON u.CodigoUsuario = ur.CodigoUsuario 
			AND ur.Activo = 1
		WHERE u.Activo = 1
		AND u.Email = @CodigoUsuario
		AND u.ClaveSecreta = @Contrasenia
	END
	ELSE
	BEGIN
		SELECT
			@CodigoUsuarioReal = ISNULL(u.CodigoUsuario,''),
			@CodigoConsultora = ISNULL(u.CodigoConsultora,''),
			@PaisID = ISNULL(u.PaisID,0),
			@TipoUsuario = ISNULL(u.TipoUsuario,0),
			@RolID = ISNULL(ur.RolID,0)
		FROM Usuario u WITH(NOLOCK) 
		INNER JOIN UsuarioRol ur WITH(NOLOCK) ON u.CodigoUsuario = ur.CodigoUsuario 
			AND ur.Activo = 1
		WHERE u.Activo = 1
		AND u.CodigoUsuario = @CodigoUsuario
		AND u.ClaveSecreta = @Contrasenia
	END

	-- si no se encontro ahora buscar por doc identidad
	IF (ISNULL(@CodigoConsultora,'') = '')
	BEGIN
		SELECT
			@CodigoUsuarioReal = ISNULL(u.CodigoUsuario,''),
			@CodigoConsultora = ISNULL(u.CodigoConsultora,''),
			@PaisID = ISNULL(u.PaisID,0),
			@TipoUsuario = ISNULL(u.TipoUsuario,0),
			@RolID = ISNULL(ur.RolID,0)
		FROM Usuario u WITH(NOLOCK)
		INNER JOIN UsuarioRol ur WITH(NOLOCK) ON u.CodigoUsuario = ur.CodigoUsuario 
			AND ur.Activo = 1
		WHERE u.Activo = 1
		AND u.DocumentoIdentidad = @CodigoUsuario
		AND u.ClaveSecreta = @Contrasenia
	END

	-- validar si es usuario postulante
	IF (@TipoUsuario = 2 AND ISNULL(@CodigoUsuarioReal,'') != '')
	BEGIN
		IF EXISTS(
			SELECT 1 FROM UsuarioPostulante WITH(NOLOCK)
			WHERE CodigoUsuario = @CodigoUsuarioReal
			AND Estado = 1 AND ISNULL(UsuarioReal,'0') = '0'
		)
		BEGIN
			SET @CodigoConsultora = @CodigoUsuarioReal
		END
	END

	--Validar el # intentos de logueo y tiempo de espera
	declare @TiempoEsperaLogueo int = (select cast(Valor as int) from TablaLogicaDatos where Codigo = 'TiempoLogueo') --obtener tiempo de espera de logueo
	declare @FechaUltimoIntentoLogueo datetime = (select FechaUltimoIntentoLogueo from usuario where CodigoUsuario = @CodigoUsuario)
	declare @UsuarioBloqueado int = (select 1 from Usuario where CodigoUsuario = @CodigoUsuario and Bloqueado = 1)

	if (SELECT DATEDIFF(second, @FechaUltimoIntentoLogueo, getdate())) >  @TiempoEsperaLogueo and isnull(@UsuarioBloqueado,0) = 1
	begin
		UPDATE Usuario 
		set CantidadIntentoLogueo = 0, 
		Bloqueado = 0,
		FechaUltimoIntentoLogueo = getdate() 
		WHERE CodigoUsuario = @CodigoUsuario
	end

	IF exists(select 1 from Usuario where CodigoUsuario = @CodigoUsuario and Bloqueado = 1)
	begin			
		SET @Result = 5 
		SET @Mensaje = 'Su cuenta fue bloqueada, por superar la cantidad maxima de intento'
	end
	ELSE IF (ISNULL(@CodigoConsultora,'') != '' AND @PaisID != 0)
	BEGIN
		SELECT @Result = Result, @Mensaje = Mensaje 
		FROM dbo.fnGetAccesoUsuario(@PaisID,@CodigoUsuarioReal,@CodigoConsultora,@TipoUsuario,@RolID)
		
		UPDATE Usuario 
		set CantidadIntentoLogueo = 0, 
		FechaUltimoIntentoLogueo = getdate() 
		WHERE CodigoUsuario = @CodigoUsuario
	END
	ELSE
	BEGIN
		declare @CantidadIntentoLogueo int = (select CantidadIntentoLogueo from Usuario WHERE CodigoUsuario = @CodigoUsuario)
		
		IF (@CantidadIntentoLogueo + 1 >= (select cast(Valor as int) from TablaLogicaDatos where Codigo = 'IntentoLogueo'))
		begin
			UPDATE Usuario 
			set Bloqueado = 1,
			CantidadIntentoLogueo = (select cast(Valor as int) from TablaLogicaDatos where Codigo = 'IntentoLogueo'),
			FechaUltimoIntentoLogueo = getdate()
			WHERE CodigoUsuario = @CodigoUsuario

			SET @Result = 5 
			SET @Mensaje = 'Su cuenta fue bloqueada, por superar la cantidad maxima de intento'
		end
		else
		begin
			SET @Result = 4 
			SET @Mensaje = 'Usuario o Contraseña Incorrectas'

			UPDATE Usuario 
			set CantidadIntentoLogueo = CantidadIntentoLogueo + 1, 
			FechaUltimoIntentoLogueo = getdate() 
			WHERE CodigoUsuario = @CodigoUsuario
		end
	END
		
	SELECT @Result AS Result, 
		@Mensaje AS Mensaje, 
		@CodigoUsuarioReal AS CodigoUsuario,
		@TipoUsuario AS TipoUsuario

	SET NOCOUNT OFF

END
go

