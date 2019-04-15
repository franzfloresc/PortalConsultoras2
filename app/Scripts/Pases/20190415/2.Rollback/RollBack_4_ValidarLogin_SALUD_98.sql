USE BelcorpPeru
GO

ALTER PROCEDURE [dbo].[ValidarLogin]
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

	IF (ISNULL(@CodigoConsultora,'') != '' AND @PaisID != 0)
	BEGIN
		SELECT @Result = Result, @Mensaje = Mensaje 
		FROM dbo.fnGetAccesoUsuario(@PaisID,@CodigoUsuarioReal,@CodigoConsultora,@TipoUsuario,@RolID)
	END
	ELSE
	BEGIN
		SET @Result = 4 
		SET @Mensaje = 'Usuario o Contraseña Incorrectas'
	END
		
	SELECT @Result AS Result, 
		@Mensaje AS Mensaje, 
		@CodigoUsuarioReal AS CodigoUsuario,
		@TipoUsuario AS TipoUsuario

	SET NOCOUNT OFF

END

GO

USE BelcorpMexico
GO

ALTER PROCEDURE [dbo].[ValidarLogin]
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

	IF (ISNULL(@CodigoConsultora,'') != '' AND @PaisID != 0)
	BEGIN
		SELECT @Result = Result, @Mensaje = Mensaje 
		FROM dbo.fnGetAccesoUsuario(@PaisID,@CodigoUsuarioReal,@CodigoConsultora,@TipoUsuario,@RolID)
	END
	ELSE
	BEGIN
		SET @Result = 4 
		SET @Mensaje = 'Usuario o Contraseña Incorrectas'
	END
		
	SELECT @Result AS Result, 
		@Mensaje AS Mensaje, 
		@CodigoUsuarioReal AS CodigoUsuario,
		@TipoUsuario AS TipoUsuario

	SET NOCOUNT OFF

END

GO

USE BelcorpColombia
GO

ALTER PROCEDURE [dbo].[ValidarLogin]
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

	IF (ISNULL(@CodigoConsultora,'') != '' AND @PaisID != 0)
	BEGIN
		SELECT @Result = Result, @Mensaje = Mensaje 
		FROM dbo.fnGetAccesoUsuario(@PaisID,@CodigoUsuarioReal,@CodigoConsultora,@TipoUsuario,@RolID)
	END
	ELSE
	BEGIN
		SET @Result = 4 
		SET @Mensaje = 'Usuario o Contraseña Incorrectas'
	END
		
	SELECT @Result AS Result, 
		@Mensaje AS Mensaje, 
		@CodigoUsuarioReal AS CodigoUsuario,
		@TipoUsuario AS TipoUsuario

	SET NOCOUNT OFF

END

GO

USE BelcorpSalvador
GO

ALTER PROCEDURE [dbo].[ValidarLogin]
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

	IF (ISNULL(@CodigoConsultora,'') != '' AND @PaisID != 0)
	BEGIN
		SELECT @Result = Result, @Mensaje = Mensaje 
		FROM dbo.fnGetAccesoUsuario(@PaisID,@CodigoUsuarioReal,@CodigoConsultora,@TipoUsuario,@RolID)
	END
	ELSE
	BEGIN
		SET @Result = 4 
		SET @Mensaje = 'Usuario o Contraseña Incorrectas'
	END
		
	SELECT @Result AS Result, 
		@Mensaje AS Mensaje, 
		@CodigoUsuarioReal AS CodigoUsuario,
		@TipoUsuario AS TipoUsuario

	SET NOCOUNT OFF

END

GO

USE BelcorpPuertoRico
GO

ALTER PROCEDURE [dbo].[ValidarLogin]
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

	IF (ISNULL(@CodigoConsultora,'') != '' AND @PaisID != 0)
	BEGIN
		SELECT @Result = Result, @Mensaje = Mensaje 
		FROM dbo.fnGetAccesoUsuario(@PaisID,@CodigoUsuarioReal,@CodigoConsultora,@TipoUsuario,@RolID)
	END
	ELSE
	BEGIN
		SET @Result = 4 
		SET @Mensaje = 'Usuario o Contraseña Incorrectas'
	END
		
	SELECT @Result AS Result, 
		@Mensaje AS Mensaje, 
		@CodigoUsuarioReal AS CodigoUsuario,
		@TipoUsuario AS TipoUsuario

	SET NOCOUNT OFF

END

GO

USE BelcorpPanama
GO

ALTER PROCEDURE [dbo].[ValidarLogin]
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

	IF (ISNULL(@CodigoConsultora,'') != '' AND @PaisID != 0)
	BEGIN
		SELECT @Result = Result, @Mensaje = Mensaje 
		FROM dbo.fnGetAccesoUsuario(@PaisID,@CodigoUsuarioReal,@CodigoConsultora,@TipoUsuario,@RolID)
	END
	ELSE
	BEGIN
		SET @Result = 4 
		SET @Mensaje = 'Usuario o Contraseña Incorrectas'
	END
		
	SELECT @Result AS Result, 
		@Mensaje AS Mensaje, 
		@CodigoUsuarioReal AS CodigoUsuario,
		@TipoUsuario AS TipoUsuario

	SET NOCOUNT OFF

END

GO

USE BelcorpGuatemala
GO

ALTER PROCEDURE [dbo].[ValidarLogin]
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

	IF (ISNULL(@CodigoConsultora,'') != '' AND @PaisID != 0)
	BEGIN
		SELECT @Result = Result, @Mensaje = Mensaje 
		FROM dbo.fnGetAccesoUsuario(@PaisID,@CodigoUsuarioReal,@CodigoConsultora,@TipoUsuario,@RolID)
	END
	ELSE
	BEGIN
		SET @Result = 4 
		SET @Mensaje = 'Usuario o Contraseña Incorrectas'
	END
		
	SELECT @Result AS Result, 
		@Mensaje AS Mensaje, 
		@CodigoUsuarioReal AS CodigoUsuario,
		@TipoUsuario AS TipoUsuario

	SET NOCOUNT OFF

END

GO

USE BelcorpEcuador
GO

ALTER PROCEDURE [dbo].[ValidarLogin]
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

	IF (ISNULL(@CodigoConsultora,'') != '' AND @PaisID != 0)
	BEGIN
		SELECT @Result = Result, @Mensaje = Mensaje 
		FROM dbo.fnGetAccesoUsuario(@PaisID,@CodigoUsuarioReal,@CodigoConsultora,@TipoUsuario,@RolID)
	END
	ELSE
	BEGIN
		SET @Result = 4 
		SET @Mensaje = 'Usuario o Contraseña Incorrectas'
	END
		
	SELECT @Result AS Result, 
		@Mensaje AS Mensaje, 
		@CodigoUsuarioReal AS CodigoUsuario,
		@TipoUsuario AS TipoUsuario

	SET NOCOUNT OFF

END

GO

USE BelcorpDominicana
GO

ALTER PROCEDURE [dbo].[ValidarLogin]
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

	IF (ISNULL(@CodigoConsultora,'') != '' AND @PaisID != 0)
	BEGIN
		SELECT @Result = Result, @Mensaje = Mensaje 
		FROM dbo.fnGetAccesoUsuario(@PaisID,@CodigoUsuarioReal,@CodigoConsultora,@TipoUsuario,@RolID)
	END
	ELSE
	BEGIN
		SET @Result = 4 
		SET @Mensaje = 'Usuario o Contraseña Incorrectas'
	END
		
	SELECT @Result AS Result, 
		@Mensaje AS Mensaje, 
		@CodigoUsuarioReal AS CodigoUsuario,
		@TipoUsuario AS TipoUsuario

	SET NOCOUNT OFF

END

GO

USE BelcorpCostaRica
GO

ALTER PROCEDURE [dbo].[ValidarLogin]
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

	IF (ISNULL(@CodigoConsultora,'') != '' AND @PaisID != 0)
	BEGIN
		SELECT @Result = Result, @Mensaje = Mensaje 
		FROM dbo.fnGetAccesoUsuario(@PaisID,@CodigoUsuarioReal,@CodigoConsultora,@TipoUsuario,@RolID)
	END
	ELSE
	BEGIN
		SET @Result = 4 
		SET @Mensaje = 'Usuario o Contraseña Incorrectas'
	END
		
	SELECT @Result AS Result, 
		@Mensaje AS Mensaje, 
		@CodigoUsuarioReal AS CodigoUsuario,
		@TipoUsuario AS TipoUsuario

	SET NOCOUNT OFF

END

GO

USE BelcorpChile
GO

ALTER PROCEDURE [dbo].[ValidarLogin]
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

	IF (ISNULL(@CodigoConsultora,'') != '' AND @PaisID != 0)
	BEGIN
		SELECT @Result = Result, @Mensaje = Mensaje 
		FROM dbo.fnGetAccesoUsuario(@PaisID,@CodigoUsuarioReal,@CodigoConsultora,@TipoUsuario,@RolID)
	END
	ELSE
	BEGIN
		SET @Result = 4 
		SET @Mensaje = 'Usuario o Contraseña Incorrectas'
	END
		
	SELECT @Result AS Result, 
		@Mensaje AS Mensaje, 
		@CodigoUsuarioReal AS CodigoUsuario,
		@TipoUsuario AS TipoUsuario

	SET NOCOUNT OFF

END

GO

USE BelcorpBolivia
GO

ALTER PROCEDURE [dbo].[ValidarLogin]
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

	IF (ISNULL(@CodigoConsultora,'') != '' AND @PaisID != 0)
	BEGIN
		SELECT @Result = Result, @Mensaje = Mensaje 
		FROM dbo.fnGetAccesoUsuario(@PaisID,@CodigoUsuarioReal,@CodigoConsultora,@TipoUsuario,@RolID)
	END
	ELSE
	BEGIN
		SET @Result = 4 
		SET @Mensaje = 'Usuario o Contraseña Incorrectas'
	END
		
	SELECT @Result AS Result, 
		@Mensaje AS Mensaje, 
		@CodigoUsuarioReal AS CodigoUsuario,
		@TipoUsuario AS TipoUsuario

	SET NOCOUNT OFF

END

GO