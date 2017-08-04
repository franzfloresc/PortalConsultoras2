USE BelcorpBolivia
GO

ALTER PROCEDURE [dbo].[ValidarAutoLogin]
(
	@CodigoUsuario VARCHAR(30),
	@Proveedor VARCHAR(50)
)
AS
BEGIN

	SET NOCOUNT ON

	--SET @Contrasenia = dbo.EncriptarClaveSHA1(@Contrasenia)

	DECLARE @CodigoConsultora VARCHAR(20)
	DECLARE @PaisID INT
	DECLARE @Result TINYINT
	DECLARE @Mensaje VARCHAR(100)

	SET @Result = 0

	DECLARE @TipoUsuario TINYINT
	DECLARE @RolID INT

	SELECT
		@CodigoConsultora = ISNULL(u.CodigoConsultora,''),
		@PaisID = ISNULL(u.PaisID,0),
		@TipoUsuario = ISNULL(u.TipoUsuario,0),
		@RolID = ISNULL(ur.RolID,0)
	FROM Usuario u WITH(NOLOCK) 
	INNER JOIN UsuarioRol ur WITH(NOLOCK) ON u.CodigoUsuario = ur.CodigoUsuario 
		AND ur.Activo = 1
	INNER JOIN UsuarioExterno ue WITH(NOLOCK) ON u.CodigoUsuario = ue.CodigoUsuario
		AND ue.Estado = 1
	WHERE u.Activo = 1 
	AND u.CodigoUsuario = @CodigoUsuario
	AND u.TipoUsuario = 1

	IF (ISNULL(@CodigoConsultora,'') != '' AND @PaisID != 0)
	BEGIN
		SELECT @Result = Result, @Mensaje = Mensaje 
		FROM dbo.fnGetAccesoUsuario(@PaisID,@CodigoUsuario,@CodigoConsultora,@TipoUsuario,@RolID)
	END
	ELSE
	BEGIN
		SET @Result = 4 
		SET @Mensaje = 'Usuario o Contraseña Incorrectas'
	END
	
	SELECT @Result AS Result, 
		@Mensaje AS Mensaje, 
		@CodigoUsuario AS CodigoUsuario

	SET NOCOUNT OFF

END
GO
/*end*/

USE BelcorpChile
GO

ALTER PROCEDURE [dbo].[ValidarAutoLogin]
(
	@CodigoUsuario VARCHAR(30),
	@Proveedor VARCHAR(50)
)
AS
BEGIN

	SET NOCOUNT ON

	--SET @Contrasenia = dbo.EncriptarClaveSHA1(@Contrasenia)

	DECLARE @CodigoConsultora VARCHAR(20)
	DECLARE @PaisID INT
	DECLARE @Result TINYINT
	DECLARE @Mensaje VARCHAR(100)

	SET @Result = 0

	DECLARE @TipoUsuario TINYINT
	DECLARE @RolID INT

	SELECT
		@CodigoConsultora = ISNULL(u.CodigoConsultora,''),
		@PaisID = ISNULL(u.PaisID,0),
		@TipoUsuario = ISNULL(u.TipoUsuario,0),
		@RolID = ISNULL(ur.RolID,0)
	FROM Usuario u WITH(NOLOCK) 
	INNER JOIN UsuarioRol ur WITH(NOLOCK) ON u.CodigoUsuario = ur.CodigoUsuario 
		AND ur.Activo = 1
	INNER JOIN UsuarioExterno ue WITH(NOLOCK) ON u.CodigoUsuario = ue.CodigoUsuario
		AND ue.Estado = 1
	WHERE u.Activo = 1 
	AND u.CodigoUsuario = @CodigoUsuario
	AND u.TipoUsuario = 1

	IF (ISNULL(@CodigoConsultora,'') != '' AND @PaisID != 0)
	BEGIN
		SELECT @Result = Result, @Mensaje = Mensaje 
		FROM dbo.fnGetAccesoUsuario(@PaisID,@CodigoUsuario,@CodigoConsultora,@TipoUsuario,@RolID)
	END
	ELSE
	BEGIN
		SET @Result = 4 
		SET @Mensaje = 'Usuario o Contraseña Incorrectas'
	END
	
	SELECT @Result AS Result, 
		@Mensaje AS Mensaje, 
		@CodigoUsuario AS CodigoUsuario

	SET NOCOUNT OFF

END
GO
/*end*/

USE BelcorpColombia
GO

ALTER PROCEDURE [dbo].[ValidarAutoLogin]
(
	@CodigoUsuario VARCHAR(30),
	@Proveedor VARCHAR(50)
)
AS
BEGIN

	SET NOCOUNT ON

	--SET @Contrasenia = dbo.EncriptarClaveSHA1(@Contrasenia)

	DECLARE @CodigoConsultora VARCHAR(20)
	DECLARE @PaisID INT
	DECLARE @Result TINYINT
	DECLARE @Mensaje VARCHAR(100)

	SET @Result = 0

	DECLARE @TipoUsuario TINYINT
	DECLARE @RolID INT

	SELECT
		@CodigoConsultora = ISNULL(u.CodigoConsultora,''),
		@PaisID = ISNULL(u.PaisID,0),
		@TipoUsuario = ISNULL(u.TipoUsuario,0),
		@RolID = ISNULL(ur.RolID,0)
	FROM Usuario u WITH(NOLOCK) 
	INNER JOIN UsuarioRol ur WITH(NOLOCK) ON u.CodigoUsuario = ur.CodigoUsuario 
		AND ur.Activo = 1
	INNER JOIN UsuarioExterno ue WITH(NOLOCK) ON u.CodigoUsuario = ue.CodigoUsuario
		AND ue.Estado = 1
	WHERE u.Activo = 1 
	AND u.CodigoUsuario = @CodigoUsuario
	AND u.TipoUsuario = 1

	IF (ISNULL(@CodigoConsultora,'') != '' AND @PaisID != 0)
	BEGIN
		SELECT @Result = Result, @Mensaje = Mensaje 
		FROM dbo.fnGetAccesoUsuario(@PaisID,@CodigoUsuario,@CodigoConsultora,@TipoUsuario,@RolID)
	END
	ELSE
	BEGIN
		SET @Result = 4 
		SET @Mensaje = 'Usuario o Contraseña Incorrectas'
	END
	
	SELECT @Result AS Result, 
		@Mensaje AS Mensaje, 
		@CodigoUsuario AS CodigoUsuario

	SET NOCOUNT OFF

END
GO
/*end*/

USE BelcorpCostaRica
GO

ALTER PROCEDURE [dbo].[ValidarAutoLogin]
(
	@CodigoUsuario VARCHAR(30),
	@Proveedor VARCHAR(50)
)
AS
BEGIN

	SET NOCOUNT ON

	--SET @Contrasenia = dbo.EncriptarClaveSHA1(@Contrasenia)

	DECLARE @CodigoConsultora VARCHAR(20)
	DECLARE @PaisID INT
	DECLARE @Result TINYINT
	DECLARE @Mensaje VARCHAR(100)

	SET @Result = 0

	DECLARE @TipoUsuario TINYINT
	DECLARE @RolID INT

	SELECT
		@CodigoConsultora = ISNULL(u.CodigoConsultora,''),
		@PaisID = ISNULL(u.PaisID,0),
		@TipoUsuario = ISNULL(u.TipoUsuario,0),
		@RolID = ISNULL(ur.RolID,0)
	FROM Usuario u WITH(NOLOCK) 
	INNER JOIN UsuarioRol ur WITH(NOLOCK) ON u.CodigoUsuario = ur.CodigoUsuario 
		AND ur.Activo = 1
	INNER JOIN UsuarioExterno ue WITH(NOLOCK) ON u.CodigoUsuario = ue.CodigoUsuario
		AND ue.Estado = 1
	WHERE u.Activo = 1 
	AND u.CodigoUsuario = @CodigoUsuario
	AND u.TipoUsuario = 1

	IF (ISNULL(@CodigoConsultora,'') != '' AND @PaisID != 0)
	BEGIN
		SELECT @Result = Result, @Mensaje = Mensaje 
		FROM dbo.fnGetAccesoUsuario(@PaisID,@CodigoUsuario,@CodigoConsultora,@TipoUsuario,@RolID)
	END
	ELSE
	BEGIN
		SET @Result = 4 
		SET @Mensaje = 'Usuario o Contraseña Incorrectas'
	END
	
	SELECT @Result AS Result, 
		@Mensaje AS Mensaje, 
		@CodigoUsuario AS CodigoUsuario

	SET NOCOUNT OFF

END
GO
/*end*/

USE BelcorpDominicana
GO

ALTER PROCEDURE [dbo].[ValidarAutoLogin]
(
	@CodigoUsuario VARCHAR(30),
	@Proveedor VARCHAR(50)
)
AS
BEGIN

	SET NOCOUNT ON

	--SET @Contrasenia = dbo.EncriptarClaveSHA1(@Contrasenia)

	DECLARE @CodigoConsultora VARCHAR(20)
	DECLARE @PaisID INT
	DECLARE @Result TINYINT
	DECLARE @Mensaje VARCHAR(100)

	SET @Result = 0

	DECLARE @TipoUsuario TINYINT
	DECLARE @RolID INT

	SELECT
		@CodigoConsultora = ISNULL(u.CodigoConsultora,''),
		@PaisID = ISNULL(u.PaisID,0),
		@TipoUsuario = ISNULL(u.TipoUsuario,0),
		@RolID = ISNULL(ur.RolID,0)
	FROM Usuario u WITH(NOLOCK) 
	INNER JOIN UsuarioRol ur WITH(NOLOCK) ON u.CodigoUsuario = ur.CodigoUsuario 
		AND ur.Activo = 1
	INNER JOIN UsuarioExterno ue WITH(NOLOCK) ON u.CodigoUsuario = ue.CodigoUsuario
		AND ue.Estado = 1
	WHERE u.Activo = 1 
	AND u.CodigoUsuario = @CodigoUsuario
	AND u.TipoUsuario = 1

	IF (ISNULL(@CodigoConsultora,'') != '' AND @PaisID != 0)
	BEGIN
		SELECT @Result = Result, @Mensaje = Mensaje 
		FROM dbo.fnGetAccesoUsuario(@PaisID,@CodigoUsuario,@CodigoConsultora,@TipoUsuario,@RolID)
	END
	ELSE
	BEGIN
		SET @Result = 4 
		SET @Mensaje = 'Usuario o Contraseña Incorrectas'
	END
	
	SELECT @Result AS Result, 
		@Mensaje AS Mensaje, 
		@CodigoUsuario AS CodigoUsuario

	SET NOCOUNT OFF

END
GO
/*end*/

USE BelcorpEcuador
GO

ALTER PROCEDURE [dbo].[ValidarAutoLogin]
(
	@CodigoUsuario VARCHAR(30),
	@Proveedor VARCHAR(50)
)
AS
BEGIN

	SET NOCOUNT ON

	--SET @Contrasenia = dbo.EncriptarClaveSHA1(@Contrasenia)

	DECLARE @CodigoConsultora VARCHAR(20)
	DECLARE @PaisID INT
	DECLARE @Result TINYINT
	DECLARE @Mensaje VARCHAR(100)

	SET @Result = 0

	DECLARE @TipoUsuario TINYINT
	DECLARE @RolID INT

	SELECT
		@CodigoConsultora = ISNULL(u.CodigoConsultora,''),
		@PaisID = ISNULL(u.PaisID,0),
		@TipoUsuario = ISNULL(u.TipoUsuario,0),
		@RolID = ISNULL(ur.RolID,0)
	FROM Usuario u WITH(NOLOCK) 
	INNER JOIN UsuarioRol ur WITH(NOLOCK) ON u.CodigoUsuario = ur.CodigoUsuario 
		AND ur.Activo = 1
	INNER JOIN UsuarioExterno ue WITH(NOLOCK) ON u.CodigoUsuario = ue.CodigoUsuario
		AND ue.Estado = 1
	WHERE u.Activo = 1 
	AND u.CodigoUsuario = @CodigoUsuario
	AND u.TipoUsuario = 1

	IF (ISNULL(@CodigoConsultora,'') != '' AND @PaisID != 0)
	BEGIN
		SELECT @Result = Result, @Mensaje = Mensaje 
		FROM dbo.fnGetAccesoUsuario(@PaisID,@CodigoUsuario,@CodigoConsultora,@TipoUsuario,@RolID)
	END
	ELSE
	BEGIN
		SET @Result = 4 
		SET @Mensaje = 'Usuario o Contraseña Incorrectas'
	END
	
	SELECT @Result AS Result, 
		@Mensaje AS Mensaje, 
		@CodigoUsuario AS CodigoUsuario

	SET NOCOUNT OFF

END
GO
/*end*/

USE BelcorpGuatemala
GO

ALTER PROCEDURE [dbo].[ValidarAutoLogin]
(
	@CodigoUsuario VARCHAR(30),
	@Proveedor VARCHAR(50)
)
AS
BEGIN

	SET NOCOUNT ON

	--SET @Contrasenia = dbo.EncriptarClaveSHA1(@Contrasenia)

	DECLARE @CodigoConsultora VARCHAR(20)
	DECLARE @PaisID INT
	DECLARE @Result TINYINT
	DECLARE @Mensaje VARCHAR(100)

	SET @Result = 0

	DECLARE @TipoUsuario TINYINT
	DECLARE @RolID INT

	SELECT
		@CodigoConsultora = ISNULL(u.CodigoConsultora,''),
		@PaisID = ISNULL(u.PaisID,0),
		@TipoUsuario = ISNULL(u.TipoUsuario,0),
		@RolID = ISNULL(ur.RolID,0)
	FROM Usuario u WITH(NOLOCK) 
	INNER JOIN UsuarioRol ur WITH(NOLOCK) ON u.CodigoUsuario = ur.CodigoUsuario 
		AND ur.Activo = 1
	INNER JOIN UsuarioExterno ue WITH(NOLOCK) ON u.CodigoUsuario = ue.CodigoUsuario
		AND ue.Estado = 1
	WHERE u.Activo = 1 
	AND u.CodigoUsuario = @CodigoUsuario
	AND u.TipoUsuario = 1

	IF (ISNULL(@CodigoConsultora,'') != '' AND @PaisID != 0)
	BEGIN
		SELECT @Result = Result, @Mensaje = Mensaje 
		FROM dbo.fnGetAccesoUsuario(@PaisID,@CodigoUsuario,@CodigoConsultora,@TipoUsuario,@RolID)
	END
	ELSE
	BEGIN
		SET @Result = 4 
		SET @Mensaje = 'Usuario o Contraseña Incorrectas'
	END
	
	SELECT @Result AS Result, 
		@Mensaje AS Mensaje, 
		@CodigoUsuario AS CodigoUsuario

	SET NOCOUNT OFF

END
GO
/*end*/

USE BelcorpMexico
GO

ALTER PROCEDURE [dbo].[ValidarAutoLogin]
(
	@CodigoUsuario VARCHAR(30),
	@Proveedor VARCHAR(50)
)
AS
BEGIN

	SET NOCOUNT ON

	--SET @Contrasenia = dbo.EncriptarClaveSHA1(@Contrasenia)

	DECLARE @CodigoConsultora VARCHAR(20)
	DECLARE @PaisID INT
	DECLARE @Result TINYINT
	DECLARE @Mensaje VARCHAR(100)

	SET @Result = 0

	DECLARE @TipoUsuario TINYINT
	DECLARE @RolID INT

	SELECT
		@CodigoConsultora = ISNULL(u.CodigoConsultora,''),
		@PaisID = ISNULL(u.PaisID,0),
		@TipoUsuario = ISNULL(u.TipoUsuario,0),
		@RolID = ISNULL(ur.RolID,0)
	FROM Usuario u WITH(NOLOCK) 
	INNER JOIN UsuarioRol ur WITH(NOLOCK) ON u.CodigoUsuario = ur.CodigoUsuario 
		AND ur.Activo = 1
	INNER JOIN UsuarioExterno ue WITH(NOLOCK) ON u.CodigoUsuario = ue.CodigoUsuario
		AND ue.Estado = 1
	WHERE u.Activo = 1 
	AND u.CodigoUsuario = @CodigoUsuario
	AND u.TipoUsuario = 1

	IF (ISNULL(@CodigoConsultora,'') != '' AND @PaisID != 0)
	BEGIN
		SELECT @Result = Result, @Mensaje = Mensaje 
		FROM dbo.fnGetAccesoUsuario(@PaisID,@CodigoUsuario,@CodigoConsultora,@TipoUsuario,@RolID)
	END
	ELSE
	BEGIN
		SET @Result = 4 
		SET @Mensaje = 'Usuario o Contraseña Incorrectas'
	END
	
	SELECT @Result AS Result, 
		@Mensaje AS Mensaje, 
		@CodigoUsuario AS CodigoUsuario

	SET NOCOUNT OFF

END
GO
/*end*/

USE BelcorpPanama
GO

ALTER PROCEDURE [dbo].[ValidarAutoLogin]
(
	@CodigoUsuario VARCHAR(30),
	@Proveedor VARCHAR(50)
)
AS
BEGIN

	SET NOCOUNT ON

	--SET @Contrasenia = dbo.EncriptarClaveSHA1(@Contrasenia)

	DECLARE @CodigoConsultora VARCHAR(20)
	DECLARE @PaisID INT
	DECLARE @Result TINYINT
	DECLARE @Mensaje VARCHAR(100)

	SET @Result = 0

	DECLARE @TipoUsuario TINYINT
	DECLARE @RolID INT

	SELECT
		@CodigoConsultora = ISNULL(u.CodigoConsultora,''),
		@PaisID = ISNULL(u.PaisID,0),
		@TipoUsuario = ISNULL(u.TipoUsuario,0),
		@RolID = ISNULL(ur.RolID,0)
	FROM Usuario u WITH(NOLOCK) 
	INNER JOIN UsuarioRol ur WITH(NOLOCK) ON u.CodigoUsuario = ur.CodigoUsuario 
		AND ur.Activo = 1
	INNER JOIN UsuarioExterno ue WITH(NOLOCK) ON u.CodigoUsuario = ue.CodigoUsuario
		AND ue.Estado = 1
	WHERE u.Activo = 1 
	AND u.CodigoUsuario = @CodigoUsuario
	AND u.TipoUsuario = 1

	IF (ISNULL(@CodigoConsultora,'') != '' AND @PaisID != 0)
	BEGIN
		SELECT @Result = Result, @Mensaje = Mensaje 
		FROM dbo.fnGetAccesoUsuario(@PaisID,@CodigoUsuario,@CodigoConsultora,@TipoUsuario,@RolID)
	END
	ELSE
	BEGIN
		SET @Result = 4 
		SET @Mensaje = 'Usuario o Contraseña Incorrectas'
	END
	
	SELECT @Result AS Result, 
		@Mensaje AS Mensaje, 
		@CodigoUsuario AS CodigoUsuario

	SET NOCOUNT OFF

END
GO
/*end*/

USE BelcorpPeru
GO

ALTER PROCEDURE [dbo].[ValidarAutoLogin]
(
	@CodigoUsuario VARCHAR(30),
	@Proveedor VARCHAR(50)
)
AS
BEGIN

	SET NOCOUNT ON

	--SET @Contrasenia = dbo.EncriptarClaveSHA1(@Contrasenia)

	DECLARE @CodigoConsultora VARCHAR(20)
	DECLARE @PaisID INT
	DECLARE @Result TINYINT
	DECLARE @Mensaje VARCHAR(100)

	SET @Result = 0

	DECLARE @TipoUsuario TINYINT
	DECLARE @RolID INT

	SELECT
		@CodigoConsultora = ISNULL(u.CodigoConsultora,''),
		@PaisID = ISNULL(u.PaisID,0),
		@TipoUsuario = ISNULL(u.TipoUsuario,0),
		@RolID = ISNULL(ur.RolID,0)
	FROM Usuario u WITH(NOLOCK) 
	INNER JOIN UsuarioRol ur WITH(NOLOCK) ON u.CodigoUsuario = ur.CodigoUsuario 
		AND ur.Activo = 1
	INNER JOIN UsuarioExterno ue WITH(NOLOCK) ON u.CodigoUsuario = ue.CodigoUsuario
		AND ue.Estado = 1
	WHERE u.Activo = 1 
	AND u.CodigoUsuario = @CodigoUsuario
	AND u.TipoUsuario = 1

	IF (ISNULL(@CodigoConsultora,'') != '' AND @PaisID != 0)
	BEGIN
		SELECT @Result = Result, @Mensaje = Mensaje 
		FROM dbo.fnGetAccesoUsuario(@PaisID,@CodigoUsuario,@CodigoConsultora,@TipoUsuario,@RolID)
	END
	ELSE
	BEGIN
		SET @Result = 4 
		SET @Mensaje = 'Usuario o Contraseña Incorrectas'
	END
	
	SELECT @Result AS Result, 
		@Mensaje AS Mensaje, 
		@CodigoUsuario AS CodigoUsuario

	SET NOCOUNT OFF

END
GO
/*end*/

USE BelcorpPuertoRico
GO

ALTER PROCEDURE [dbo].[ValidarAutoLogin]
(
	@CodigoUsuario VARCHAR(30),
	@Proveedor VARCHAR(50)
)
AS
BEGIN

	SET NOCOUNT ON

	--SET @Contrasenia = dbo.EncriptarClaveSHA1(@Contrasenia)

	DECLARE @CodigoConsultora VARCHAR(20)
	DECLARE @PaisID INT
	DECLARE @Result TINYINT
	DECLARE @Mensaje VARCHAR(100)

	SET @Result = 0

	DECLARE @TipoUsuario TINYINT
	DECLARE @RolID INT

	SELECT
		@CodigoConsultora = ISNULL(u.CodigoConsultora,''),
		@PaisID = ISNULL(u.PaisID,0),
		@TipoUsuario = ISNULL(u.TipoUsuario,0),
		@RolID = ISNULL(ur.RolID,0)
	FROM Usuario u WITH(NOLOCK) 
	INNER JOIN UsuarioRol ur WITH(NOLOCK) ON u.CodigoUsuario = ur.CodigoUsuario 
		AND ur.Activo = 1
	INNER JOIN UsuarioExterno ue WITH(NOLOCK) ON u.CodigoUsuario = ue.CodigoUsuario
		AND ue.Estado = 1
	WHERE u.Activo = 1 
	AND u.CodigoUsuario = @CodigoUsuario
	AND u.TipoUsuario = 1

	IF (ISNULL(@CodigoConsultora,'') != '' AND @PaisID != 0)
	BEGIN
		SELECT @Result = Result, @Mensaje = Mensaje 
		FROM dbo.fnGetAccesoUsuario(@PaisID,@CodigoUsuario,@CodigoConsultora,@TipoUsuario,@RolID)
	END
	ELSE
	BEGIN
		SET @Result = 4 
		SET @Mensaje = 'Usuario o Contraseña Incorrectas'
	END
	
	SELECT @Result AS Result, 
		@Mensaje AS Mensaje, 
		@CodigoUsuario AS CodigoUsuario

	SET NOCOUNT OFF

END
GO
/*end*/

USE BelcorpSalvador
GO

ALTER PROCEDURE [dbo].[ValidarAutoLogin]
(
	@CodigoUsuario VARCHAR(30),
	@Proveedor VARCHAR(50)
)
AS
BEGIN

	SET NOCOUNT ON

	--SET @Contrasenia = dbo.EncriptarClaveSHA1(@Contrasenia)

	DECLARE @CodigoConsultora VARCHAR(20)
	DECLARE @PaisID INT
	DECLARE @Result TINYINT
	DECLARE @Mensaje VARCHAR(100)

	SET @Result = 0

	DECLARE @TipoUsuario TINYINT
	DECLARE @RolID INT

	SELECT
		@CodigoConsultora = ISNULL(u.CodigoConsultora,''),
		@PaisID = ISNULL(u.PaisID,0),
		@TipoUsuario = ISNULL(u.TipoUsuario,0),
		@RolID = ISNULL(ur.RolID,0)
	FROM Usuario u WITH(NOLOCK) 
	INNER JOIN UsuarioRol ur WITH(NOLOCK) ON u.CodigoUsuario = ur.CodigoUsuario 
		AND ur.Activo = 1
	INNER JOIN UsuarioExterno ue WITH(NOLOCK) ON u.CodigoUsuario = ue.CodigoUsuario
		AND ue.Estado = 1
	WHERE u.Activo = 1 
	AND u.CodigoUsuario = @CodigoUsuario
	AND u.TipoUsuario = 1

	IF (ISNULL(@CodigoConsultora,'') != '' AND @PaisID != 0)
	BEGIN
		SELECT @Result = Result, @Mensaje = Mensaje 
		FROM dbo.fnGetAccesoUsuario(@PaisID,@CodigoUsuario,@CodigoConsultora,@TipoUsuario,@RolID)
	END
	ELSE
	BEGIN
		SET @Result = 4 
		SET @Mensaje = 'Usuario o Contraseña Incorrectas'
	END
	
	SELECT @Result AS Result, 
		@Mensaje AS Mensaje, 
		@CodigoUsuario AS CodigoUsuario

	SET NOCOUNT OFF

END
GO
/*end*/

USE BelcorpVenezuela
GO

ALTER PROCEDURE [dbo].[ValidarAutoLogin]
(
	@CodigoUsuario VARCHAR(30),
	@Proveedor VARCHAR(50)
)
AS
BEGIN

	SET NOCOUNT ON

	--SET @Contrasenia = dbo.EncriptarClaveSHA1(@Contrasenia)

	DECLARE @CodigoConsultora VARCHAR(20)
	DECLARE @PaisID INT
	DECLARE @Result TINYINT
	DECLARE @Mensaje VARCHAR(100)

	SET @Result = 0

	DECLARE @TipoUsuario TINYINT
	DECLARE @RolID INT

	SELECT
		@CodigoConsultora = ISNULL(u.CodigoConsultora,''),
		@PaisID = ISNULL(u.PaisID,0),
		@TipoUsuario = ISNULL(u.TipoUsuario,0),
		@RolID = ISNULL(ur.RolID,0)
	FROM Usuario u WITH(NOLOCK) 
	INNER JOIN UsuarioRol ur WITH(NOLOCK) ON u.CodigoUsuario = ur.CodigoUsuario 
		AND ur.Activo = 1
	INNER JOIN UsuarioExterno ue WITH(NOLOCK) ON u.CodigoUsuario = ue.CodigoUsuario
		AND ue.Estado = 1
	WHERE u.Activo = 1 
	AND u.CodigoUsuario = @CodigoUsuario
	AND u.TipoUsuario = 1

	IF (ISNULL(@CodigoConsultora,'') != '' AND @PaisID != 0)
	BEGIN
		SELECT @Result = Result, @Mensaje = Mensaje 
		FROM dbo.fnGetAccesoUsuario(@PaisID,@CodigoUsuario,@CodigoConsultora,@TipoUsuario,@RolID)
	END
	ELSE
	BEGIN
		SET @Result = 4 
		SET @Mensaje = 'Usuario o Contraseña Incorrectas'
	END
	
	SELECT @Result AS Result, 
		@Mensaje AS Mensaje, 
		@CodigoUsuario AS CodigoUsuario

	SET NOCOUNT OFF

END
GO