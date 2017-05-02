
USE BelcorpBolivia
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.ValidarLogin'))
BEGIN
    DROP PROCEDURE dbo.ValidarLogin
END
GO

CREATE PROCEDURE [dbo].[ValidarLogin]
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

DECLARE @Result INT
DECLARE @Mensaje VARCHAR(100)

SET @Result = -1

DECLARE @TipoUsuario TINYINT
DECLARE @CodigoUsuario_ VARCHAR(30)

SELECT
	@CodigoConsultora = ISNULL(CodigoConsultora,''),
	@CodigoUsuario_ = CodigoUsuario,
	@PaisID = ISNULL(PaisID,0),
	@TipoUsuario = ISNULL(TipoUsuario,0)
FROM Usuario WITH(NOLOCK)
WHERE Activo = 1 AND ClaveSecreta = @Contrasenia
AND (CodigoUsuario = @CodigoUsuario OR Email = @CodigoUsuario OR DocumentoIdentidad = @CodigoUsuario)

-- validar usuario postulante
IF (@TipoUsuario = 2)
BEGIN
	IF EXISTS(
		SELECT 1 FROM UsuarioPostulante WITH(NOLOCK)
		WHERE CodigoUsuario = @CodigoUsuario_
		AND Estado = 1 AND ISNULL(UsuarioReal,'0') = '0'
	)
	BEGIN
		SET @CodigoConsultora = @CodigoUsuario
	END
END

IF (@CodigoConsultora != '' AND @PaisID != 0)
BEGIN
	SELECT @Result = Result, @Mensaje = Mensaje 
	FROM dbo.fnGetAccesoUsuario(@PaisID,@CodigoUsuario_,@CodigoConsultora,@TipoUsuario)
END
ELSE
BEGIN
	SET @Result = 4 
	SET @Mensaje = 'Usuario o Contraseña Incorrectas'
END
	
SELECT @Result AS Result, @Mensaje AS Mensaje, @CodigoUsuario_ AS CodigoUsuario

SET NOCOUNT OFF

END
GO
/*end*/

USE BelcorpChile
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.ValidarLogin'))
BEGIN
    DROP PROCEDURE dbo.ValidarLogin
END
GO

CREATE PROCEDURE [dbo].[ValidarLogin]
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

DECLARE @Result INT
DECLARE @Mensaje VARCHAR(100)

SET @Result = -1

DECLARE @TipoUsuario TINYINT
DECLARE @CodigoUsuario_ VARCHAR(30)

SELECT
	@CodigoConsultora = ISNULL(CodigoConsultora,''),
	@CodigoUsuario_ = CodigoUsuario,
	@PaisID = ISNULL(PaisID,0),
	@TipoUsuario = ISNULL(TipoUsuario,0)
FROM Usuario WITH(NOLOCK)
WHERE Activo = 1 AND ClaveSecreta = @Contrasenia
AND (CodigoUsuario = @CodigoUsuario OR Email = @CodigoUsuario OR DocumentoIdentidad = @CodigoUsuario)

-- validar usuario postulante
IF (@TipoUsuario = 2)
BEGIN
	IF EXISTS(
		SELECT 1 FROM UsuarioPostulante WITH(NOLOCK)
		WHERE CodigoUsuario = @CodigoUsuario_
		AND Estado = 1 AND ISNULL(UsuarioReal,'0') = '0'
	)
	BEGIN
		SET @CodigoConsultora = @CodigoUsuario
	END
END

IF (@CodigoConsultora != '' AND @PaisID != 0)
BEGIN
	SELECT @Result = Result, @Mensaje = Mensaje 
	FROM dbo.fnGetAccesoUsuario(@PaisID,@CodigoUsuario_,@CodigoConsultora,@TipoUsuario)
END
ELSE
BEGIN
	SET @Result = 4 
	SET @Mensaje = 'Usuario o Contraseña Incorrectas'
END
	
SELECT @Result AS Result, @Mensaje AS Mensaje, @CodigoUsuario_ AS CodigoUsuario

SET NOCOUNT OFF

END
GO
/*end*/

USE BelcorpColombia
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.ValidarLogin'))
BEGIN
    DROP PROCEDURE dbo.ValidarLogin
END
GO

CREATE PROCEDURE [dbo].[ValidarLogin]
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

DECLARE @Result INT
DECLARE @Mensaje VARCHAR(100)

SET @Result = -1

DECLARE @TipoUsuario TINYINT
DECLARE @CodigoUsuario_ VARCHAR(30)

SELECT
	@CodigoConsultora = ISNULL(CodigoConsultora,''),
	@CodigoUsuario_ = CodigoUsuario,
	@PaisID = ISNULL(PaisID,0),
	@TipoUsuario = ISNULL(TipoUsuario,0)
FROM Usuario WITH(NOLOCK)
WHERE Activo = 1 AND ClaveSecreta = @Contrasenia
AND (CodigoUsuario = @CodigoUsuario OR Email = @CodigoUsuario OR DocumentoIdentidad = @CodigoUsuario)

-- validar usuario postulante
IF (@TipoUsuario = 2)
BEGIN
	IF EXISTS(
		SELECT 1 FROM UsuarioPostulante WITH(NOLOCK)
		WHERE CodigoUsuario = @CodigoUsuario_
		AND Estado = 1 AND ISNULL(UsuarioReal,'0') = '0'
	)
	BEGIN
		SET @CodigoConsultora = @CodigoUsuario
	END
END

IF (@CodigoConsultora != '' AND @PaisID != 0)
BEGIN
	SELECT @Result = Result, @Mensaje = Mensaje 
	FROM dbo.fnGetAccesoUsuario(@PaisID,@CodigoUsuario_,@CodigoConsultora,@TipoUsuario)
END
ELSE
BEGIN
	SET @Result = 4 
	SET @Mensaje = 'Usuario o Contraseña Incorrectas'
END
	
SELECT @Result AS Result, @Mensaje AS Mensaje, @CodigoUsuario_ AS CodigoUsuario

SET NOCOUNT OFF

END
GO
/*end*/

USE BelcorpCostaRica
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.ValidarLogin'))
BEGIN
    DROP PROCEDURE dbo.ValidarLogin
END
GO

CREATE PROCEDURE [dbo].[ValidarLogin]
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

DECLARE @Result INT
DECLARE @Mensaje VARCHAR(100)

SET @Result = -1

DECLARE @TipoUsuario TINYINT
DECLARE @CodigoUsuario_ VARCHAR(30)

SELECT
	@CodigoConsultora = ISNULL(CodigoConsultora,''),
	@CodigoUsuario_ = CodigoUsuario,
	@PaisID = ISNULL(PaisID,0),
	@TipoUsuario = ISNULL(TipoUsuario,0)
FROM Usuario WITH(NOLOCK)
WHERE Activo = 1 AND ClaveSecreta = @Contrasenia
AND (CodigoUsuario = @CodigoUsuario OR Email = @CodigoUsuario OR DocumentoIdentidad = @CodigoUsuario)

-- validar usuario postulante
IF (@TipoUsuario = 2)
BEGIN
	IF EXISTS(
		SELECT 1 FROM UsuarioPostulante WITH(NOLOCK)
		WHERE CodigoUsuario = @CodigoUsuario_
		AND Estado = 1 AND ISNULL(UsuarioReal,'0') = '0'
	)
	BEGIN
		SET @CodigoConsultora = @CodigoUsuario
	END
END

IF (@CodigoConsultora != '' AND @PaisID != 0)
BEGIN
	SELECT @Result = Result, @Mensaje = Mensaje 
	FROM dbo.fnGetAccesoUsuario(@PaisID,@CodigoUsuario_,@CodigoConsultora,@TipoUsuario)
END
ELSE
BEGIN
	SET @Result = 4 
	SET @Mensaje = 'Usuario o Contraseña Incorrectas'
END
	
SELECT @Result AS Result, @Mensaje AS Mensaje, @CodigoUsuario_ AS CodigoUsuario

SET NOCOUNT OFF

END
GO
/*end*/

USE BelcorpDominicana
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.ValidarLogin'))
BEGIN
    DROP PROCEDURE dbo.ValidarLogin
END
GO

CREATE PROCEDURE [dbo].[ValidarLogin]
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

DECLARE @Result INT
DECLARE @Mensaje VARCHAR(100)

SET @Result = -1

DECLARE @TipoUsuario TINYINT
DECLARE @CodigoUsuario_ VARCHAR(30)

SELECT
	@CodigoConsultora = ISNULL(CodigoConsultora,''),
	@CodigoUsuario_ = CodigoUsuario,
	@PaisID = ISNULL(PaisID,0),
	@TipoUsuario = ISNULL(TipoUsuario,0)
FROM Usuario WITH(NOLOCK)
WHERE Activo = 1 AND ClaveSecreta = @Contrasenia
AND (CodigoUsuario = @CodigoUsuario OR Email = @CodigoUsuario OR DocumentoIdentidad = @CodigoUsuario)

-- validar usuario postulante
IF (@TipoUsuario = 2)
BEGIN
	IF EXISTS(
		SELECT 1 FROM UsuarioPostulante WITH(NOLOCK)
		WHERE CodigoUsuario = @CodigoUsuario_
		AND Estado = 1 AND ISNULL(UsuarioReal,'0') = '0'
	)
	BEGIN
		SET @CodigoConsultora = @CodigoUsuario
	END
END

IF (@CodigoConsultora != '' AND @PaisID != 0)
BEGIN
	SELECT @Result = Result, @Mensaje = Mensaje 
	FROM dbo.fnGetAccesoUsuario(@PaisID,@CodigoUsuario_,@CodigoConsultora,@TipoUsuario)
END
ELSE
BEGIN
	SET @Result = 4 
	SET @Mensaje = 'Usuario o Contraseña Incorrectas'
END
	
SELECT @Result AS Result, @Mensaje AS Mensaje, @CodigoUsuario_ AS CodigoUsuario

SET NOCOUNT OFF

END
GO
/*end*/

USE BelcorpEcuador
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.ValidarLogin'))
BEGIN
    DROP PROCEDURE dbo.ValidarLogin
END
GO

CREATE PROCEDURE [dbo].[ValidarLogin]
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

DECLARE @Result INT
DECLARE @Mensaje VARCHAR(100)

SET @Result = -1

DECLARE @TipoUsuario TINYINT
DECLARE @CodigoUsuario_ VARCHAR(30)

SELECT
	@CodigoConsultora = ISNULL(CodigoConsultora,''),
	@CodigoUsuario_ = CodigoUsuario,
	@PaisID = ISNULL(PaisID,0),
	@TipoUsuario = ISNULL(TipoUsuario,0)
FROM Usuario WITH(NOLOCK)
WHERE Activo = 1 AND ClaveSecreta = @Contrasenia
AND (CodigoUsuario = @CodigoUsuario OR Email = @CodigoUsuario OR DocumentoIdentidad = @CodigoUsuario)

-- validar usuario postulante
IF (@TipoUsuario = 2)
BEGIN
	IF EXISTS(
		SELECT 1 FROM UsuarioPostulante WITH(NOLOCK)
		WHERE CodigoUsuario = @CodigoUsuario_
		AND Estado = 1 AND ISNULL(UsuarioReal,'0') = '0'
	)
	BEGIN
		SET @CodigoConsultora = @CodigoUsuario
	END
END

IF (@CodigoConsultora != '' AND @PaisID != 0)
BEGIN
	SELECT @Result = Result, @Mensaje = Mensaje 
	FROM dbo.fnGetAccesoUsuario(@PaisID,@CodigoUsuario_,@CodigoConsultora,@TipoUsuario)
END
ELSE
BEGIN
	SET @Result = 4 
	SET @Mensaje = 'Usuario o Contraseña Incorrectas'
END
	
SELECT @Result AS Result, @Mensaje AS Mensaje, @CodigoUsuario_ AS CodigoUsuario

SET NOCOUNT OFF

END
GO
/*end*/

USE BelcorpGuatemala
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.ValidarLogin'))
BEGIN
    DROP PROCEDURE dbo.ValidarLogin
END
GO

CREATE PROCEDURE [dbo].[ValidarLogin]
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

DECLARE @Result INT
DECLARE @Mensaje VARCHAR(100)

SET @Result = -1

DECLARE @TipoUsuario TINYINT
DECLARE @CodigoUsuario_ VARCHAR(30)

SELECT
	@CodigoConsultora = ISNULL(CodigoConsultora,''),
	@CodigoUsuario_ = CodigoUsuario,
	@PaisID = ISNULL(PaisID,0),
	@TipoUsuario = ISNULL(TipoUsuario,0)
FROM Usuario WITH(NOLOCK)
WHERE Activo = 1 AND ClaveSecreta = @Contrasenia
AND (CodigoUsuario = @CodigoUsuario OR Email = @CodigoUsuario OR DocumentoIdentidad = @CodigoUsuario)

-- validar usuario postulante
IF (@TipoUsuario = 2)
BEGIN
	IF EXISTS(
		SELECT 1 FROM UsuarioPostulante WITH(NOLOCK)
		WHERE CodigoUsuario = @CodigoUsuario_
		AND Estado = 1 AND ISNULL(UsuarioReal,'0') = '0'
	)
	BEGIN
		SET @CodigoConsultora = @CodigoUsuario
	END
END

IF (@CodigoConsultora != '' AND @PaisID != 0)
BEGIN
	SELECT @Result = Result, @Mensaje = Mensaje 
	FROM dbo.fnGetAccesoUsuario(@PaisID,@CodigoUsuario_,@CodigoConsultora,@TipoUsuario)
END
ELSE
BEGIN
	SET @Result = 4 
	SET @Mensaje = 'Usuario o Contraseña Incorrectas'
END
	
SELECT @Result AS Result, @Mensaje AS Mensaje, @CodigoUsuario_ AS CodigoUsuario

SET NOCOUNT OFF

END
GO
/*end*/

USE BelcorpMexico
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.ValidarLogin'))
BEGIN
    DROP PROCEDURE dbo.ValidarLogin
END
GO

CREATE PROCEDURE [dbo].[ValidarLogin]
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

DECLARE @Result INT
DECLARE @Mensaje VARCHAR(100)

SET @Result = -1

DECLARE @TipoUsuario TINYINT
DECLARE @CodigoUsuario_ VARCHAR(30)

SELECT
	@CodigoConsultora = ISNULL(CodigoConsultora,''),
	@CodigoUsuario_ = CodigoUsuario,
	@PaisID = ISNULL(PaisID,0),
	@TipoUsuario = ISNULL(TipoUsuario,0)
FROM Usuario WITH(NOLOCK)
WHERE Activo = 1 AND ClaveSecreta = @Contrasenia
AND (CodigoUsuario = @CodigoUsuario OR Email = @CodigoUsuario OR DocumentoIdentidad = @CodigoUsuario)

-- validar usuario postulante
IF (@TipoUsuario = 2)
BEGIN
	IF EXISTS(
		SELECT 1 FROM UsuarioPostulante WITH(NOLOCK)
		WHERE CodigoUsuario = @CodigoUsuario_
		AND Estado = 1 AND ISNULL(UsuarioReal,'0') = '0'
	)
	BEGIN
		SET @CodigoConsultora = @CodigoUsuario
	END
END

IF (@CodigoConsultora != '' AND @PaisID != 0)
BEGIN
	SELECT @Result = Result, @Mensaje = Mensaje 
	FROM dbo.fnGetAccesoUsuario(@PaisID,@CodigoUsuario_,@CodigoConsultora,@TipoUsuario)
END
ELSE
BEGIN
	SET @Result = 4 
	SET @Mensaje = 'Usuario o Contraseña Incorrectas'
END
	
SELECT @Result AS Result, @Mensaje AS Mensaje, @CodigoUsuario_ AS CodigoUsuario

SET NOCOUNT OFF

END
GO
/*end*/

USE BelcorpPanama
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.ValidarLogin'))
BEGIN
    DROP PROCEDURE dbo.ValidarLogin
END
GO

CREATE PROCEDURE [dbo].[ValidarLogin]
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

DECLARE @Result INT
DECLARE @Mensaje VARCHAR(100)

SET @Result = -1

DECLARE @TipoUsuario TINYINT
DECLARE @CodigoUsuario_ VARCHAR(30)

SELECT
	@CodigoConsultora = ISNULL(CodigoConsultora,''),
	@CodigoUsuario_ = CodigoUsuario,
	@PaisID = ISNULL(PaisID,0),
	@TipoUsuario = ISNULL(TipoUsuario,0)
FROM Usuario WITH(NOLOCK)
WHERE Activo = 1 AND ClaveSecreta = @Contrasenia
AND (CodigoUsuario = @CodigoUsuario OR Email = @CodigoUsuario OR DocumentoIdentidad = @CodigoUsuario)

-- validar usuario postulante
IF (@TipoUsuario = 2)
BEGIN
	IF EXISTS(
		SELECT 1 FROM UsuarioPostulante WITH(NOLOCK)
		WHERE CodigoUsuario = @CodigoUsuario_
		AND Estado = 1 AND ISNULL(UsuarioReal,'0') = '0'
	)
	BEGIN
		SET @CodigoConsultora = @CodigoUsuario
	END
END

IF (@CodigoConsultora != '' AND @PaisID != 0)
BEGIN
	SELECT @Result = Result, @Mensaje = Mensaje 
	FROM dbo.fnGetAccesoUsuario(@PaisID,@CodigoUsuario_,@CodigoConsultora,@TipoUsuario)
END
ELSE
BEGIN
	SET @Result = 4 
	SET @Mensaje = 'Usuario o Contraseña Incorrectas'
END
	
SELECT @Result AS Result, @Mensaje AS Mensaje, @CodigoUsuario_ AS CodigoUsuario

SET NOCOUNT OFF

END
GO
/*end*/

USE BelcorpPeru
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.ValidarLogin'))
BEGIN
    DROP PROCEDURE dbo.ValidarLogin
END
GO

CREATE PROCEDURE [dbo].[ValidarLogin]
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

DECLARE @Result INT
DECLARE @Mensaje VARCHAR(100)

SET @Result = -1

DECLARE @TipoUsuario TINYINT
DECLARE @CodigoUsuario_ VARCHAR(30)

SELECT
	@CodigoConsultora = ISNULL(CodigoConsultora,''),
	@CodigoUsuario_ = CodigoUsuario,
	@PaisID = ISNULL(PaisID,0),
	@TipoUsuario = ISNULL(TipoUsuario,0)
FROM Usuario WITH(NOLOCK)
WHERE Activo = 1 AND ClaveSecreta = @Contrasenia
AND (CodigoUsuario = @CodigoUsuario OR Email = @CodigoUsuario OR DocumentoIdentidad = @CodigoUsuario)

-- validar usuario postulante
IF (@TipoUsuario = 2)
BEGIN
	IF EXISTS(
		SELECT 1 FROM UsuarioPostulante WITH(NOLOCK)
		WHERE CodigoUsuario = @CodigoUsuario_
		AND Estado = 1 AND ISNULL(UsuarioReal,'0') = '0'
	)
	BEGIN
		SET @CodigoConsultora = @CodigoUsuario
	END
END

IF (@CodigoConsultora != '' AND @PaisID != 0)
BEGIN
	SELECT @Result = Result, @Mensaje = Mensaje 
	FROM dbo.fnGetAccesoUsuario(@PaisID,@CodigoUsuario_,@CodigoConsultora,@TipoUsuario)
END
ELSE
BEGIN
	SET @Result = 4 
	SET @Mensaje = 'Usuario o Contraseña Incorrectas'
END
	
SELECT @Result AS Result, @Mensaje AS Mensaje, @CodigoUsuario_ AS CodigoUsuario

SET NOCOUNT OFF

END
GO
/*end*/

USE BelcorpPuertoRico
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.ValidarLogin'))
BEGIN
    DROP PROCEDURE dbo.ValidarLogin
END
GO

CREATE PROCEDURE [dbo].[ValidarLogin]
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

DECLARE @Result INT
DECLARE @Mensaje VARCHAR(100)

SET @Result = -1

DECLARE @TipoUsuario TINYINT
DECLARE @CodigoUsuario_ VARCHAR(30)

SELECT
	@CodigoConsultora = ISNULL(CodigoConsultora,''),
	@CodigoUsuario_ = CodigoUsuario,
	@PaisID = ISNULL(PaisID,0),
	@TipoUsuario = ISNULL(TipoUsuario,0)
FROM Usuario WITH(NOLOCK)
WHERE Activo = 1 AND ClaveSecreta = @Contrasenia
AND (CodigoUsuario = @CodigoUsuario OR Email = @CodigoUsuario OR DocumentoIdentidad = @CodigoUsuario)

-- validar usuario postulante
IF (@TipoUsuario = 2)
BEGIN
	IF EXISTS(
		SELECT 1 FROM UsuarioPostulante WITH(NOLOCK)
		WHERE CodigoUsuario = @CodigoUsuario_
		AND Estado = 1 AND ISNULL(UsuarioReal,'0') = '0'
	)
	BEGIN
		SET @CodigoConsultora = @CodigoUsuario
	END
END

IF (@CodigoConsultora != '' AND @PaisID != 0)
BEGIN
	SELECT @Result = Result, @Mensaje = Mensaje 
	FROM dbo.fnGetAccesoUsuario(@PaisID,@CodigoUsuario_,@CodigoConsultora,@TipoUsuario)
END
ELSE
BEGIN
	SET @Result = 4 
	SET @Mensaje = 'Usuario o Contraseña Incorrectas'
END
	
SELECT @Result AS Result, @Mensaje AS Mensaje, @CodigoUsuario_ AS CodigoUsuario

SET NOCOUNT OFF

END
GO
/*end*/

USE BelcorpSalvador
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.ValidarLogin'))
BEGIN
    DROP PROCEDURE dbo.ValidarLogin
END
GO

CREATE PROCEDURE [dbo].[ValidarLogin]
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

DECLARE @Result INT
DECLARE @Mensaje VARCHAR(100)

SET @Result = -1

DECLARE @TipoUsuario TINYINT
DECLARE @CodigoUsuario_ VARCHAR(30)

SELECT
	@CodigoConsultora = ISNULL(CodigoConsultora,''),
	@CodigoUsuario_ = CodigoUsuario,
	@PaisID = ISNULL(PaisID,0),
	@TipoUsuario = ISNULL(TipoUsuario,0)
FROM Usuario WITH(NOLOCK)
WHERE Activo = 1 AND ClaveSecreta = @Contrasenia
AND (CodigoUsuario = @CodigoUsuario OR Email = @CodigoUsuario OR DocumentoIdentidad = @CodigoUsuario)

-- validar usuario postulante
IF (@TipoUsuario = 2)
BEGIN
	IF EXISTS(
		SELECT 1 FROM UsuarioPostulante WITH(NOLOCK)
		WHERE CodigoUsuario = @CodigoUsuario_
		AND Estado = 1 AND ISNULL(UsuarioReal,'0') = '0'
	)
	BEGIN
		SET @CodigoConsultora = @CodigoUsuario
	END
END

IF (@CodigoConsultora != '' AND @PaisID != 0)
BEGIN
	SELECT @Result = Result, @Mensaje = Mensaje 
	FROM dbo.fnGetAccesoUsuario(@PaisID,@CodigoUsuario_,@CodigoConsultora,@TipoUsuario)
END
ELSE
BEGIN
	SET @Result = 4 
	SET @Mensaje = 'Usuario o Contraseña Incorrectas'
END
	
SELECT @Result AS Result, @Mensaje AS Mensaje, @CodigoUsuario_ AS CodigoUsuario

SET NOCOUNT OFF

END
GO
/*end*/

USE BelcorpVenezuela
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.ValidarLogin'))
BEGIN
    DROP PROCEDURE dbo.ValidarLogin
END
GO

CREATE PROCEDURE [dbo].[ValidarLogin]
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

DECLARE @Result INT
DECLARE @Mensaje VARCHAR(100)

SET @Result = -1

DECLARE @TipoUsuario TINYINT
DECLARE @CodigoUsuario_ VARCHAR(30)

SELECT
	@CodigoConsultora = ISNULL(CodigoConsultora,''),
	@CodigoUsuario_ = CodigoUsuario,
	@PaisID = ISNULL(PaisID,0),
	@TipoUsuario = ISNULL(TipoUsuario,0)
FROM Usuario WITH(NOLOCK)
WHERE Activo = 1 AND ClaveSecreta = @Contrasenia
AND (CodigoUsuario = @CodigoUsuario OR Email = @CodigoUsuario OR DocumentoIdentidad = @CodigoUsuario)

-- validar usuario postulante
IF (@TipoUsuario = 2)
BEGIN
	IF EXISTS(
		SELECT 1 FROM UsuarioPostulante WITH(NOLOCK)
		WHERE CodigoUsuario = @CodigoUsuario_
		AND Estado = 1 AND ISNULL(UsuarioReal,'0') = '0'
	)
	BEGIN
		SET @CodigoConsultora = @CodigoUsuario
	END
END

IF (@CodigoConsultora != '' AND @PaisID != 0)
BEGIN
	SELECT @Result = Result, @Mensaje = Mensaje 
	FROM dbo.fnGetAccesoUsuario(@PaisID,@CodigoUsuario_,@CodigoConsultora,@TipoUsuario)
END
ELSE
BEGIN
	SET @Result = 4 
	SET @Mensaje = 'Usuario o Contraseña Incorrectas'
END
	
SELECT @Result AS Result, @Mensaje AS Mensaje, @CodigoUsuario_ AS CodigoUsuario

SET NOCOUNT OFF

END
GO


