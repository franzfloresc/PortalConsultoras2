
USE BelcorpBolivia
GO

ALTER PROCEDURE [dbo].[ValidarLogin]
(
	@CodigoUsuario VARCHAR(30),
	@Contrasenia VARCHAR(200)
)
AS
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
		SET @CodigoConsultora = @CodigoUsuario_
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
	
SELECT @Result AS Result, @Mensaje AS Mensaje, @CodigoUsuario_ AS CodigoUsuario,
	@TipoUsuario AS TipoUsuario

SET NOCOUNT OFF

END
GO
/*end*/

USE BelcorpChile
GO

ALTER PROCEDURE [dbo].[ValidarLogin]
(
	@CodigoUsuario VARCHAR(30),
	@Contrasenia VARCHAR(200)
)
AS
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
		SET @CodigoConsultora = @CodigoUsuario_
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
	
SELECT @Result AS Result, @Mensaje AS Mensaje, @CodigoUsuario_ AS CodigoUsuario,
	@TipoUsuario AS TipoUsuario

SET NOCOUNT OFF

END
GO
/*end*/

USE BelcorpColombia
GO
ALTER PROCEDURE [dbo].[ValidarLogin]
(
	@CodigoUsuario VARCHAR(30),
	@Contrasenia VARCHAR(200)
)
AS
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
		SET @CodigoConsultora = @CodigoUsuario_
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
	
SELECT @Result AS Result, @Mensaje AS Mensaje, @CodigoUsuario_ AS CodigoUsuario,
	@TipoUsuario AS TipoUsuario

SET NOCOUNT OFF

END
GO
/*end*/

USE BelcorpCostaRica
GO

ALTER PROCEDURE [dbo].[ValidarLogin]
(
	@CodigoUsuario VARCHAR(30),
	@Contrasenia VARCHAR(200)
)
AS
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
		SET @CodigoConsultora = @CodigoUsuario_
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
	
SELECT @Result AS Result, @Mensaje AS Mensaje, @CodigoUsuario_ AS CodigoUsuario,
	@TipoUsuario AS TipoUsuario

SET NOCOUNT OFF

END
GO
/*end*/

USE BelcorpDominicana
GO

ALTER PROCEDURE [dbo].[ValidarLogin]
(
	@CodigoUsuario VARCHAR(30),
	@Contrasenia VARCHAR(200)
)
AS
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
		SET @CodigoConsultora = @CodigoUsuario_
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
	
SELECT @Result AS Result, @Mensaje AS Mensaje, @CodigoUsuario_ AS CodigoUsuario,
	@TipoUsuario AS TipoUsuario

SET NOCOUNT OFF

END
GO
/*end*/

USE BelcorpEcuador
GO
ALTER PROCEDURE [dbo].[ValidarLogin]
(
	@CodigoUsuario VARCHAR(30),
	@Contrasenia VARCHAR(200)
)
AS
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
		SET @CodigoConsultora = @CodigoUsuario_
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
	
SELECT @Result AS Result, @Mensaje AS Mensaje, @CodigoUsuario_ AS CodigoUsuario,
	@TipoUsuario AS TipoUsuario

SET NOCOUNT OFF

END
GO
/*end*/

USE BelcorpGuatemala
GO

ALTER PROCEDURE [dbo].[ValidarLogin]
(
	@CodigoUsuario VARCHAR(30),
	@Contrasenia VARCHAR(200)
)
AS
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
		SET @CodigoConsultora = @CodigoUsuario_
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
	
SELECT @Result AS Result, @Mensaje AS Mensaje, @CodigoUsuario_ AS CodigoUsuario,
	@TipoUsuario AS TipoUsuario

SET NOCOUNT OFF

END
GO
/*end*/

USE BelcorpMexico
GO

ALTER PROCEDURE [dbo].[ValidarLogin]
(
	@CodigoUsuario VARCHAR(30),
	@Contrasenia VARCHAR(200)
)
AS
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
		SET @CodigoConsultora = @CodigoUsuario_
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
	
SELECT @Result AS Result, @Mensaje AS Mensaje, @CodigoUsuario_ AS CodigoUsuario,
	@TipoUsuario AS TipoUsuario

SET NOCOUNT OFF

END
GO
/*end*/

USE BelcorpPanama
GO

ALTER PROCEDURE [dbo].[ValidarLogin]
(
	@CodigoUsuario VARCHAR(30),
	@Contrasenia VARCHAR(200)
)
AS
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
		SET @CodigoConsultora = @CodigoUsuario_
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
	
SELECT @Result AS Result, @Mensaje AS Mensaje, @CodigoUsuario_ AS CodigoUsuario,
	@TipoUsuario AS TipoUsuario

SET NOCOUNT OFF

END
GO
/*end*/

USE BelcorpPeru
GO

ALTER PROCEDURE [dbo].[ValidarLogin]
(
	@CodigoUsuario VARCHAR(30),
	@Contrasenia VARCHAR(200)
)
AS
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
		SET @CodigoConsultora = @CodigoUsuario_
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
	
SELECT @Result AS Result, @Mensaje AS Mensaje, @CodigoUsuario_ AS CodigoUsuario,
	@TipoUsuario AS TipoUsuario

SET NOCOUNT OFF

END
GO
/*end*/

USE BelcorpPuertoRico
GO

ALTER PROCEDURE [dbo].[ValidarLogin]
(
	@CodigoUsuario VARCHAR(30),
	@Contrasenia VARCHAR(200)
)
AS
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
		SET @CodigoConsultora = @CodigoUsuario_
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
	
SELECT @Result AS Result, @Mensaje AS Mensaje, @CodigoUsuario_ AS CodigoUsuario,
	@TipoUsuario AS TipoUsuario

SET NOCOUNT OFF

END
GO
/*end*/

USE BelcorpSalvador
GO

ALTER PROCEDURE [dbo].[ValidarLogin]
(
	@CodigoUsuario VARCHAR(30),
	@Contrasenia VARCHAR(200)
)
AS
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
		SET @CodigoConsultora = @CodigoUsuario_
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
	
SELECT @Result AS Result, @Mensaje AS Mensaje, @CodigoUsuario_ AS CodigoUsuario,
	@TipoUsuario AS TipoUsuario

SET NOCOUNT OFF

END
GO
/*end*/

USE BelcorpVenezuela
GO

ALTER PROCEDURE [dbo].[ValidarLogin]
(
	@CodigoUsuario VARCHAR(30),
	@Contrasenia VARCHAR(200)
)
AS
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
		SET @CodigoConsultora = @CodigoUsuario_
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
	
SELECT @Result AS Result, @Mensaje AS Mensaje, @CodigoUsuario_ AS CodigoUsuario,
	@TipoUsuario AS TipoUsuario

SET NOCOUNT OFF

END
GO


