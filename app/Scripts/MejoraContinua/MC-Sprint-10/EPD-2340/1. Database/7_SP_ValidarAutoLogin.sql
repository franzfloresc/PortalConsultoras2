

USE BelcorpBolivia
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.ValidarAutoLogin'))
BEGIN
    DROP PROCEDURE dbo.ValidarAutoLogin
END
GO

CREATE PROCEDURE [dbo].[ValidarAutoLogin]
(
	@CodigoUsuario VARCHAR(30),
	--@Contrasenia VARCHAR(200)
	@Proveedor VARCHAR(50)
)
AS
BEGIN

SET NOCOUNT ON

--SET @Contrasenia = dbo.EncriptarClaveSHA1(@Contrasenia)

DECLARE @CodigoConsultora VARCHAR(20)
DECLARE @PaisID INT

DECLARE @Result INT
DECLARE @Mensaje VARCHAR(100)

SET @Result = -1

DECLARE @TipoUsuario TINYINT
--DECLARE @CodigoUsuario_ VARCHAR(30)

SELECT
	@CodigoConsultora = ISNULL(u.CodigoConsultora,''),
	--@CodigoUsuario_ = CodigoUsuario,
	@PaisID = ISNULL(u.PaisID,0),
	@TipoUsuario = ISNULL(u.TipoUsuario,0)
FROM Usuario u WITH(NOLOCK) 
INNER JOIN UsuarioExterno ue WITH(NOLOCK) ON u.CodigoUsuario = ue.CodigoUsuario
AND ue.Estado = 1
WHERE u.Activo = 1 --AND ClaveSecreta = @Contrasenia
AND (u.CodigoUsuario = @CodigoUsuario)
AND u.TipoUsuario = 1

IF (@CodigoConsultora != '' AND @PaisID != 0)
BEGIN
	SELECT @Result = Result, @Mensaje = Mensaje 
	FROM dbo.fnGetAccesoUsuario(@PaisID,@CodigoUsuario,@CodigoConsultora,@TipoUsuario)
END
ELSE
BEGIN
	SET @Result = 4 
	SET @Mensaje = 'Usuario o Contraseña Incorrectas'
END
	
SELECT @Result AS Result, @Mensaje AS Mensaje, @CodigoUsuario AS CodigoUsuario

SET NOCOUNT OFF

END
GO
/*end*/

USE BelcorpChile
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.ValidarAutoLogin'))
BEGIN
    DROP PROCEDURE dbo.ValidarAutoLogin
END
GO

CREATE PROCEDURE [dbo].[ValidarAutoLogin]
(
	@CodigoUsuario VARCHAR(30),
	--@Contrasenia VARCHAR(200)
	@Proveedor VARCHAR(50)
)
AS
BEGIN

SET NOCOUNT ON

--SET @Contrasenia = dbo.EncriptarClaveSHA1(@Contrasenia)

DECLARE @CodigoConsultora VARCHAR(20)
DECLARE @PaisID INT

DECLARE @Result INT
DECLARE @Mensaje VARCHAR(100)

SET @Result = -1

DECLARE @TipoUsuario TINYINT
--DECLARE @CodigoUsuario_ VARCHAR(30)

SELECT
	@CodigoConsultora = ISNULL(u.CodigoConsultora,''),
	--@CodigoUsuario_ = CodigoUsuario,
	@PaisID = ISNULL(u.PaisID,0),
	@TipoUsuario = ISNULL(u.TipoUsuario,0)
FROM Usuario u WITH(NOLOCK) 
INNER JOIN UsuarioExterno ue WITH(NOLOCK) ON u.CodigoUsuario = ue.CodigoUsuario
AND ue.Estado = 1
WHERE u.Activo = 1 --AND ClaveSecreta = @Contrasenia
AND (u.CodigoUsuario = @CodigoUsuario)
AND u.TipoUsuario = 1

IF (@CodigoConsultora != '' AND @PaisID != 0)
BEGIN
	SELECT @Result = Result, @Mensaje = Mensaje 
	FROM dbo.fnGetAccesoUsuario(@PaisID,@CodigoUsuario,@CodigoConsultora,@TipoUsuario)
END
ELSE
BEGIN
	SET @Result = 4 
	SET @Mensaje = 'Usuario o Contraseña Incorrectas'
END
	
SELECT @Result AS Result, @Mensaje AS Mensaje, @CodigoUsuario AS CodigoUsuario

SET NOCOUNT OFF

END
GO
/*end*/

USE BelcorpColombia
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.ValidarAutoLogin'))
BEGIN
    DROP PROCEDURE dbo.ValidarAutoLogin
END
GO

CREATE PROCEDURE [dbo].[ValidarAutoLogin]
(
	@CodigoUsuario VARCHAR(30),
	--@Contrasenia VARCHAR(200)
	@Proveedor VARCHAR(50)
)
AS
BEGIN

SET NOCOUNT ON

--SET @Contrasenia = dbo.EncriptarClaveSHA1(@Contrasenia)

DECLARE @CodigoConsultora VARCHAR(20)
DECLARE @PaisID INT

DECLARE @Result INT
DECLARE @Mensaje VARCHAR(100)

SET @Result = -1

DECLARE @TipoUsuario TINYINT
--DECLARE @CodigoUsuario_ VARCHAR(30)

SELECT
	@CodigoConsultora = ISNULL(u.CodigoConsultora,''),
	--@CodigoUsuario_ = CodigoUsuario,
	@PaisID = ISNULL(u.PaisID,0),
	@TipoUsuario = ISNULL(u.TipoUsuario,0)
FROM Usuario u WITH(NOLOCK) 
INNER JOIN UsuarioExterno ue WITH(NOLOCK) ON u.CodigoUsuario = ue.CodigoUsuario
AND ue.Estado = 1
WHERE u.Activo = 1 --AND ClaveSecreta = @Contrasenia
AND (u.CodigoUsuario = @CodigoUsuario)
AND u.TipoUsuario = 1

IF (@CodigoConsultora != '' AND @PaisID != 0)
BEGIN
	SELECT @Result = Result, @Mensaje = Mensaje 
	FROM dbo.fnGetAccesoUsuario(@PaisID,@CodigoUsuario,@CodigoConsultora,@TipoUsuario)
END
ELSE
BEGIN
	SET @Result = 4 
	SET @Mensaje = 'Usuario o Contraseña Incorrectas'
END
	
SELECT @Result AS Result, @Mensaje AS Mensaje, @CodigoUsuario AS CodigoUsuario

SET NOCOUNT OFF

END
GO
/*end*/

USE BelcorpCostaRica
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.ValidarAutoLogin'))
BEGIN
    DROP PROCEDURE dbo.ValidarAutoLogin
END
GO

CREATE PROCEDURE [dbo].[ValidarAutoLogin]
(
	@CodigoUsuario VARCHAR(30),
	--@Contrasenia VARCHAR(200)
	@Proveedor VARCHAR(50)
)
AS
BEGIN

SET NOCOUNT ON

--SET @Contrasenia = dbo.EncriptarClaveSHA1(@Contrasenia)

DECLARE @CodigoConsultora VARCHAR(20)
DECLARE @PaisID INT

DECLARE @Result INT
DECLARE @Mensaje VARCHAR(100)

SET @Result = -1

DECLARE @TipoUsuario TINYINT
--DECLARE @CodigoUsuario_ VARCHAR(30)

SELECT
	@CodigoConsultora = ISNULL(u.CodigoConsultora,''),
	--@CodigoUsuario_ = CodigoUsuario,
	@PaisID = ISNULL(u.PaisID,0),
	@TipoUsuario = ISNULL(u.TipoUsuario,0)
FROM Usuario u WITH(NOLOCK) 
INNER JOIN UsuarioExterno ue WITH(NOLOCK) ON u.CodigoUsuario = ue.CodigoUsuario
AND ue.Estado = 1
WHERE u.Activo = 1 --AND ClaveSecreta = @Contrasenia
AND (u.CodigoUsuario = @CodigoUsuario)
AND u.TipoUsuario = 1

IF (@CodigoConsultora != '' AND @PaisID != 0)
BEGIN
	SELECT @Result = Result, @Mensaje = Mensaje 
	FROM dbo.fnGetAccesoUsuario(@PaisID,@CodigoUsuario,@CodigoConsultora,@TipoUsuario)
END
ELSE
BEGIN
	SET @Result = 4 
	SET @Mensaje = 'Usuario o Contraseña Incorrectas'
END
	
SELECT @Result AS Result, @Mensaje AS Mensaje, @CodigoUsuario AS CodigoUsuario

SET NOCOUNT OFF

END
GO
/*end*/

USE BelcorpDominicana
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.ValidarAutoLogin'))
BEGIN
    DROP PROCEDURE dbo.ValidarAutoLogin
END
GO

CREATE PROCEDURE [dbo].[ValidarAutoLogin]
(
	@CodigoUsuario VARCHAR(30),
	--@Contrasenia VARCHAR(200)
	@Proveedor VARCHAR(50)
)
AS
BEGIN

SET NOCOUNT ON

--SET @Contrasenia = dbo.EncriptarClaveSHA1(@Contrasenia)

DECLARE @CodigoConsultora VARCHAR(20)
DECLARE @PaisID INT

DECLARE @Result INT
DECLARE @Mensaje VARCHAR(100)

SET @Result = -1

DECLARE @TipoUsuario TINYINT
--DECLARE @CodigoUsuario_ VARCHAR(30)

SELECT
	@CodigoConsultora = ISNULL(u.CodigoConsultora,''),
	--@CodigoUsuario_ = CodigoUsuario,
	@PaisID = ISNULL(u.PaisID,0),
	@TipoUsuario = ISNULL(u.TipoUsuario,0)
FROM Usuario u WITH(NOLOCK) 
INNER JOIN UsuarioExterno ue WITH(NOLOCK) ON u.CodigoUsuario = ue.CodigoUsuario
AND ue.Estado = 1
WHERE u.Activo = 1 --AND ClaveSecreta = @Contrasenia
AND (u.CodigoUsuario = @CodigoUsuario)
AND u.TipoUsuario = 1

IF (@CodigoConsultora != '' AND @PaisID != 0)
BEGIN
	SELECT @Result = Result, @Mensaje = Mensaje 
	FROM dbo.fnGetAccesoUsuario(@PaisID,@CodigoUsuario,@CodigoConsultora,@TipoUsuario)
END
ELSE
BEGIN
	SET @Result = 4 
	SET @Mensaje = 'Usuario o Contraseña Incorrectas'
END
	
SELECT @Result AS Result, @Mensaje AS Mensaje, @CodigoUsuario AS CodigoUsuario

SET NOCOUNT OFF

END
GO
/*end*/

USE BelcorpEcuador
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.ValidarAutoLogin'))
BEGIN
    DROP PROCEDURE dbo.ValidarAutoLogin
END
GO

CREATE PROCEDURE [dbo].[ValidarAutoLogin]
(
	@CodigoUsuario VARCHAR(30),
	--@Contrasenia VARCHAR(200)
	@Proveedor VARCHAR(50)
)
AS
BEGIN

SET NOCOUNT ON

--SET @Contrasenia = dbo.EncriptarClaveSHA1(@Contrasenia)

DECLARE @CodigoConsultora VARCHAR(20)
DECLARE @PaisID INT

DECLARE @Result INT
DECLARE @Mensaje VARCHAR(100)

SET @Result = -1

DECLARE @TipoUsuario TINYINT
--DECLARE @CodigoUsuario_ VARCHAR(30)

SELECT
	@CodigoConsultora = ISNULL(u.CodigoConsultora,''),
	--@CodigoUsuario_ = CodigoUsuario,
	@PaisID = ISNULL(u.PaisID,0),
	@TipoUsuario = ISNULL(u.TipoUsuario,0)
FROM Usuario u WITH(NOLOCK) 
INNER JOIN UsuarioExterno ue WITH(NOLOCK) ON u.CodigoUsuario = ue.CodigoUsuario
AND ue.Estado = 1
WHERE u.Activo = 1 --AND ClaveSecreta = @Contrasenia
AND (u.CodigoUsuario = @CodigoUsuario)
AND u.TipoUsuario = 1

IF (@CodigoConsultora != '' AND @PaisID != 0)
BEGIN
	SELECT @Result = Result, @Mensaje = Mensaje 
	FROM dbo.fnGetAccesoUsuario(@PaisID,@CodigoUsuario,@CodigoConsultora,@TipoUsuario)
END
ELSE
BEGIN
	SET @Result = 4 
	SET @Mensaje = 'Usuario o Contraseña Incorrectas'
END
	
SELECT @Result AS Result, @Mensaje AS Mensaje, @CodigoUsuario AS CodigoUsuario

SET NOCOUNT OFF

END
GO
/*end*/

USE BelcorpGuatemala
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.ValidarAutoLogin'))
BEGIN
    DROP PROCEDURE dbo.ValidarAutoLogin
END
GO

CREATE PROCEDURE [dbo].[ValidarAutoLogin]
(
	@CodigoUsuario VARCHAR(30),
	--@Contrasenia VARCHAR(200)
	@Proveedor VARCHAR(50)
)
AS
BEGIN

SET NOCOUNT ON

--SET @Contrasenia = dbo.EncriptarClaveSHA1(@Contrasenia)

DECLARE @CodigoConsultora VARCHAR(20)
DECLARE @PaisID INT

DECLARE @Result INT
DECLARE @Mensaje VARCHAR(100)

SET @Result = -1

DECLARE @TipoUsuario TINYINT
--DECLARE @CodigoUsuario_ VARCHAR(30)

SELECT
	@CodigoConsultora = ISNULL(u.CodigoConsultora,''),
	--@CodigoUsuario_ = CodigoUsuario,
	@PaisID = ISNULL(u.PaisID,0),
	@TipoUsuario = ISNULL(u.TipoUsuario,0)
FROM Usuario u WITH(NOLOCK) 
INNER JOIN UsuarioExterno ue WITH(NOLOCK) ON u.CodigoUsuario = ue.CodigoUsuario
AND ue.Estado = 1
WHERE u.Activo = 1 --AND ClaveSecreta = @Contrasenia
AND (u.CodigoUsuario = @CodigoUsuario)
AND u.TipoUsuario = 1

IF (@CodigoConsultora != '' AND @PaisID != 0)
BEGIN
	SELECT @Result = Result, @Mensaje = Mensaje 
	FROM dbo.fnGetAccesoUsuario(@PaisID,@CodigoUsuario,@CodigoConsultora,@TipoUsuario)
END
ELSE
BEGIN
	SET @Result = 4 
	SET @Mensaje = 'Usuario o Contraseña Incorrectas'
END
	
SELECT @Result AS Result, @Mensaje AS Mensaje, @CodigoUsuario AS CodigoUsuario

SET NOCOUNT OFF

END
GO
/*end*/

USE BelcorpMexico
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.ValidarAutoLogin'))
BEGIN
    DROP PROCEDURE dbo.ValidarAutoLogin
END
GO

CREATE PROCEDURE [dbo].[ValidarAutoLogin]
(
	@CodigoUsuario VARCHAR(30),
	--@Contrasenia VARCHAR(200)
	@Proveedor VARCHAR(50)
)
AS
BEGIN

SET NOCOUNT ON

--SET @Contrasenia = dbo.EncriptarClaveSHA1(@Contrasenia)

DECLARE @CodigoConsultora VARCHAR(20)
DECLARE @PaisID INT

DECLARE @Result INT
DECLARE @Mensaje VARCHAR(100)

SET @Result = -1

DECLARE @TipoUsuario TINYINT
--DECLARE @CodigoUsuario_ VARCHAR(30)

SELECT
	@CodigoConsultora = ISNULL(u.CodigoConsultora,''),
	--@CodigoUsuario_ = CodigoUsuario,
	@PaisID = ISNULL(u.PaisID,0),
	@TipoUsuario = ISNULL(u.TipoUsuario,0)
FROM Usuario u WITH(NOLOCK) 
INNER JOIN UsuarioExterno ue WITH(NOLOCK) ON u.CodigoUsuario = ue.CodigoUsuario
AND ue.Estado = 1
WHERE u.Activo = 1 --AND ClaveSecreta = @Contrasenia
AND (u.CodigoUsuario = @CodigoUsuario)
AND u.TipoUsuario = 1

IF (@CodigoConsultora != '' AND @PaisID != 0)
BEGIN
	SELECT @Result = Result, @Mensaje = Mensaje 
	FROM dbo.fnGetAccesoUsuario(@PaisID,@CodigoUsuario,@CodigoConsultora,@TipoUsuario)
END
ELSE
BEGIN
	SET @Result = 4 
	SET @Mensaje = 'Usuario o Contraseña Incorrectas'
END
	
SELECT @Result AS Result, @Mensaje AS Mensaje, @CodigoUsuario AS CodigoUsuario

SET NOCOUNT OFF

END
GO
/*end*/

USE BelcorpPanama
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.ValidarAutoLogin'))
BEGIN
    DROP PROCEDURE dbo.ValidarAutoLogin
END
GO

CREATE PROCEDURE [dbo].[ValidarAutoLogin]
(
	@CodigoUsuario VARCHAR(30),
	--@Contrasenia VARCHAR(200)
	@Proveedor VARCHAR(50)
)
AS
BEGIN

SET NOCOUNT ON

--SET @Contrasenia = dbo.EncriptarClaveSHA1(@Contrasenia)

DECLARE @CodigoConsultora VARCHAR(20)
DECLARE @PaisID INT

DECLARE @Result INT
DECLARE @Mensaje VARCHAR(100)

SET @Result = -1

DECLARE @TipoUsuario TINYINT
--DECLARE @CodigoUsuario_ VARCHAR(30)

SELECT
	@CodigoConsultora = ISNULL(u.CodigoConsultora,''),
	--@CodigoUsuario_ = CodigoUsuario,
	@PaisID = ISNULL(u.PaisID,0),
	@TipoUsuario = ISNULL(u.TipoUsuario,0)
FROM Usuario u WITH(NOLOCK) 
INNER JOIN UsuarioExterno ue WITH(NOLOCK) ON u.CodigoUsuario = ue.CodigoUsuario
AND ue.Estado = 1
WHERE u.Activo = 1 --AND ClaveSecreta = @Contrasenia
AND (u.CodigoUsuario = @CodigoUsuario)
AND u.TipoUsuario = 1

IF (@CodigoConsultora != '' AND @PaisID != 0)
BEGIN
	SELECT @Result = Result, @Mensaje = Mensaje 
	FROM dbo.fnGetAccesoUsuario(@PaisID,@CodigoUsuario,@CodigoConsultora,@TipoUsuario)
END
ELSE
BEGIN
	SET @Result = 4 
	SET @Mensaje = 'Usuario o Contraseña Incorrectas'
END
	
SELECT @Result AS Result, @Mensaje AS Mensaje, @CodigoUsuario AS CodigoUsuario

SET NOCOUNT OFF

END
GO
/*end*/

USE BelcorpPeru
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.ValidarAutoLogin'))
BEGIN
    DROP PROCEDURE dbo.ValidarAutoLogin
END
GO

CREATE PROCEDURE [dbo].[ValidarAutoLogin]
(
	@CodigoUsuario VARCHAR(30),
	--@Contrasenia VARCHAR(200)
	@Proveedor VARCHAR(50)
)
AS
BEGIN

SET NOCOUNT ON

--SET @Contrasenia = dbo.EncriptarClaveSHA1(@Contrasenia)

DECLARE @CodigoConsultora VARCHAR(20)
DECLARE @PaisID INT

DECLARE @Result INT
DECLARE @Mensaje VARCHAR(100)

SET @Result = -1

DECLARE @TipoUsuario TINYINT
--DECLARE @CodigoUsuario_ VARCHAR(30)

SELECT
	@CodigoConsultora = ISNULL(u.CodigoConsultora,''),
	--@CodigoUsuario_ = CodigoUsuario,
	@PaisID = ISNULL(u.PaisID,0),
	@TipoUsuario = ISNULL(u.TipoUsuario,0)
FROM Usuario u WITH(NOLOCK) 
INNER JOIN UsuarioExterno ue WITH(NOLOCK) ON u.CodigoUsuario = ue.CodigoUsuario
AND ue.Estado = 1
WHERE u.Activo = 1 --AND ClaveSecreta = @Contrasenia
AND (u.CodigoUsuario = @CodigoUsuario)
AND u.TipoUsuario = 1

IF (@CodigoConsultora != '' AND @PaisID != 0)
BEGIN
	SELECT @Result = Result, @Mensaje = Mensaje 
	FROM dbo.fnGetAccesoUsuario(@PaisID,@CodigoUsuario,@CodigoConsultora,@TipoUsuario)
END
ELSE
BEGIN
	SET @Result = 4 
	SET @Mensaje = 'Usuario o Contraseña Incorrectas'
END
	
SELECT @Result AS Result, @Mensaje AS Mensaje, @CodigoUsuario AS CodigoUsuario

SET NOCOUNT OFF

END
GO
/*end*/

USE BelcorpPuertoRico
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.ValidarAutoLogin'))
BEGIN
    DROP PROCEDURE dbo.ValidarAutoLogin
END
GO

CREATE PROCEDURE [dbo].[ValidarAutoLogin]
(
	@CodigoUsuario VARCHAR(30),
	--@Contrasenia VARCHAR(200)
	@Proveedor VARCHAR(50)
)
AS
BEGIN

SET NOCOUNT ON

--SET @Contrasenia = dbo.EncriptarClaveSHA1(@Contrasenia)

DECLARE @CodigoConsultora VARCHAR(20)
DECLARE @PaisID INT

DECLARE @Result INT
DECLARE @Mensaje VARCHAR(100)

SET @Result = -1

DECLARE @TipoUsuario TINYINT
--DECLARE @CodigoUsuario_ VARCHAR(30)

SELECT
	@CodigoConsultora = ISNULL(u.CodigoConsultora,''),
	--@CodigoUsuario_ = CodigoUsuario,
	@PaisID = ISNULL(u.PaisID,0),
	@TipoUsuario = ISNULL(u.TipoUsuario,0)
FROM Usuario u WITH(NOLOCK) 
INNER JOIN UsuarioExterno ue WITH(NOLOCK) ON u.CodigoUsuario = ue.CodigoUsuario
AND ue.Estado = 1
WHERE u.Activo = 1 --AND ClaveSecreta = @Contrasenia
AND (u.CodigoUsuario = @CodigoUsuario)
AND u.TipoUsuario = 1

IF (@CodigoConsultora != '' AND @PaisID != 0)
BEGIN
	SELECT @Result = Result, @Mensaje = Mensaje 
	FROM dbo.fnGetAccesoUsuario(@PaisID,@CodigoUsuario,@CodigoConsultora,@TipoUsuario)
END
ELSE
BEGIN
	SET @Result = 4 
	SET @Mensaje = 'Usuario o Contraseña Incorrectas'
END
	
SELECT @Result AS Result, @Mensaje AS Mensaje, @CodigoUsuario AS CodigoUsuario

SET NOCOUNT OFF

END
GO
/*end*/

USE BelcorpSalvador
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.ValidarAutoLogin'))
BEGIN
    DROP PROCEDURE dbo.ValidarAutoLogin
END
GO

CREATE PROCEDURE [dbo].[ValidarAutoLogin]
(
	@CodigoUsuario VARCHAR(30),
	--@Contrasenia VARCHAR(200)
	@Proveedor VARCHAR(50)
)
AS
BEGIN

SET NOCOUNT ON

--SET @Contrasenia = dbo.EncriptarClaveSHA1(@Contrasenia)

DECLARE @CodigoConsultora VARCHAR(20)
DECLARE @PaisID INT

DECLARE @Result INT
DECLARE @Mensaje VARCHAR(100)

SET @Result = -1

DECLARE @TipoUsuario TINYINT
--DECLARE @CodigoUsuario_ VARCHAR(30)

SELECT
	@CodigoConsultora = ISNULL(u.CodigoConsultora,''),
	--@CodigoUsuario_ = CodigoUsuario,
	@PaisID = ISNULL(u.PaisID,0),
	@TipoUsuario = ISNULL(u.TipoUsuario,0)
FROM Usuario u WITH(NOLOCK) 
INNER JOIN UsuarioExterno ue WITH(NOLOCK) ON u.CodigoUsuario = ue.CodigoUsuario
AND ue.Estado = 1
WHERE u.Activo = 1 --AND ClaveSecreta = @Contrasenia
AND (u.CodigoUsuario = @CodigoUsuario)
AND u.TipoUsuario = 1

IF (@CodigoConsultora != '' AND @PaisID != 0)
BEGIN
	SELECT @Result = Result, @Mensaje = Mensaje 
	FROM dbo.fnGetAccesoUsuario(@PaisID,@CodigoUsuario,@CodigoConsultora,@TipoUsuario)
END
ELSE
BEGIN
	SET @Result = 4 
	SET @Mensaje = 'Usuario o Contraseña Incorrectas'
END
	
SELECT @Result AS Result, @Mensaje AS Mensaje, @CodigoUsuario AS CodigoUsuario

SET NOCOUNT OFF

END
GO
/*end*/

USE BelcorpVenezuela
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.ValidarAutoLogin'))
BEGIN
    DROP PROCEDURE dbo.ValidarAutoLogin
END
GO

CREATE PROCEDURE [dbo].[ValidarAutoLogin]
(
	@CodigoUsuario VARCHAR(30),
	--@Contrasenia VARCHAR(200)
	@Proveedor VARCHAR(50)
)
AS
BEGIN

SET NOCOUNT ON

--SET @Contrasenia = dbo.EncriptarClaveSHA1(@Contrasenia)

DECLARE @CodigoConsultora VARCHAR(20)
DECLARE @PaisID INT

DECLARE @Result INT
DECLARE @Mensaje VARCHAR(100)

SET @Result = -1

DECLARE @TipoUsuario TINYINT
--DECLARE @CodigoUsuario_ VARCHAR(30)

SELECT
	@CodigoConsultora = ISNULL(u.CodigoConsultora,''),
	--@CodigoUsuario_ = CodigoUsuario,
	@PaisID = ISNULL(u.PaisID,0),
	@TipoUsuario = ISNULL(u.TipoUsuario,0)
FROM Usuario u WITH(NOLOCK) 
INNER JOIN UsuarioExterno ue WITH(NOLOCK) ON u.CodigoUsuario = ue.CodigoUsuario
AND ue.Estado = 1
WHERE u.Activo = 1 --AND ClaveSecreta = @Contrasenia
AND (u.CodigoUsuario = @CodigoUsuario)
AND u.TipoUsuario = 1

IF (@CodigoConsultora != '' AND @PaisID != 0)
BEGIN
	SELECT @Result = Result, @Mensaje = Mensaje 
	FROM dbo.fnGetAccesoUsuario(@PaisID,@CodigoUsuario,@CodigoConsultora,@TipoUsuario)
END
ELSE
BEGIN
	SET @Result = 4 
	SET @Mensaje = 'Usuario o Contraseña Incorrectas'
END
	
SELECT @Result AS Result, @Mensaje AS Mensaje, @CodigoUsuario AS CodigoUsuario

SET NOCOUNT OFF

END
GO

