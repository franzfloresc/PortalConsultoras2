GO
USE BelcorpPeru
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContraseniaRepetida]')
		   AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[ContraseniaRepetida]
GO

create PROC ContraseniaRepetida
(
	@CodigoUsuario VARCHAR(50),
	@Contrasenia VARCHAR(200)
)
AS
BEGIN
	declare @existe bit = 0
	SET @Contrasenia = dbo.EncriptarClaveSHA1(@Contrasenia)

	SELECT @existe = 1 from  USUARIO  u
	WHERE u.Activo = 1
			AND u.CodigoUsuario =   @CodigoUsuario
			AND u.ClaveSecreta = @Contrasenia


	select @existe 'existe'
END


GO
USE BelcorpMexico
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContraseniaRepetida]')
		   AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[ContraseniaRepetida]
GO

create PROC ContraseniaRepetida
(
	@CodigoUsuario VARCHAR(50),
	@Contrasenia VARCHAR(200)
)
AS
BEGIN
	declare @existe bit = 0
	SET @Contrasenia = dbo.EncriptarClaveSHA1(@Contrasenia)

	SELECT @existe = 1 from  USUARIO  u
	WHERE u.Activo = 1
			AND u.CodigoUsuario =   @CodigoUsuario
			AND u.ClaveSecreta = @Contrasenia


	select @existe 'existe'
END


GO
USE BelcorpColombia
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContraseniaRepetida]')
		   AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[ContraseniaRepetida]
GO

create PROC ContraseniaRepetida
(
	@CodigoUsuario VARCHAR(50),
	@Contrasenia VARCHAR(200)
)
AS
BEGIN
	declare @existe bit = 0
	SET @Contrasenia = dbo.EncriptarClaveSHA1(@Contrasenia)

	SELECT @existe = 1 from  USUARIO  u
	WHERE u.Activo = 1
			AND u.CodigoUsuario =   @CodigoUsuario
			AND u.ClaveSecreta = @Contrasenia


	select @existe 'existe'
END


GO
USE BelcorpSalvador
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContraseniaRepetida]')
		   AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[ContraseniaRepetida]
GO

create PROC ContraseniaRepetida
(
	@CodigoUsuario VARCHAR(50),
	@Contrasenia VARCHAR(200)
)
AS
BEGIN
	declare @existe bit = 0
	SET @Contrasenia = dbo.EncriptarClaveSHA1(@Contrasenia)

	SELECT @existe = 1 from  USUARIO  u
	WHERE u.Activo = 1
			AND u.CodigoUsuario =   @CodigoUsuario
			AND u.ClaveSecreta = @Contrasenia


	select @existe 'existe'
END


GO
USE BelcorpPuertoRico
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContraseniaRepetida]')
		   AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[ContraseniaRepetida]
GO

create PROC ContraseniaRepetida
(
	@CodigoUsuario VARCHAR(50),
	@Contrasenia VARCHAR(200)
)
AS
BEGIN
	declare @existe bit = 0
	SET @Contrasenia = dbo.EncriptarClaveSHA1(@Contrasenia)

	SELECT @existe = 1 from  USUARIO  u
	WHERE u.Activo = 1
			AND u.CodigoUsuario =   @CodigoUsuario
			AND u.ClaveSecreta = @Contrasenia


	select @existe 'existe'
END


GO
USE BelcorpPanama
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContraseniaRepetida]')
		   AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[ContraseniaRepetida]
GO

create PROC ContraseniaRepetida
(
	@CodigoUsuario VARCHAR(50),
	@Contrasenia VARCHAR(200)
)
AS
BEGIN
	declare @existe bit = 0
	SET @Contrasenia = dbo.EncriptarClaveSHA1(@Contrasenia)

	SELECT @existe = 1 from  USUARIO  u
	WHERE u.Activo = 1
			AND u.CodigoUsuario =   @CodigoUsuario
			AND u.ClaveSecreta = @Contrasenia


	select @existe 'existe'
END


GO
USE BelcorpGuatemala
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContraseniaRepetida]')
		   AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[ContraseniaRepetida]
GO

create PROC ContraseniaRepetida
(
	@CodigoUsuario VARCHAR(50),
	@Contrasenia VARCHAR(200)
)
AS
BEGIN
	declare @existe bit = 0
	SET @Contrasenia = dbo.EncriptarClaveSHA1(@Contrasenia)

	SELECT @existe = 1 from  USUARIO  u
	WHERE u.Activo = 1
			AND u.CodigoUsuario =   @CodigoUsuario
			AND u.ClaveSecreta = @Contrasenia


	select @existe 'existe'
END


GO
USE BelcorpEcuador
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContraseniaRepetida]')
		   AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[ContraseniaRepetida]
GO

create PROC ContraseniaRepetida
(
	@CodigoUsuario VARCHAR(50),
	@Contrasenia VARCHAR(200)
)
AS
BEGIN
	declare @existe bit = 0
	SET @Contrasenia = dbo.EncriptarClaveSHA1(@Contrasenia)

	SELECT @existe = 1 from  USUARIO  u
	WHERE u.Activo = 1
			AND u.CodigoUsuario =   @CodigoUsuario
			AND u.ClaveSecreta = @Contrasenia


	select @existe 'existe'
END


GO
USE BelcorpDominicana
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContraseniaRepetida]')
		   AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[ContraseniaRepetida]
GO

create PROC ContraseniaRepetida
(
	@CodigoUsuario VARCHAR(50),
	@Contrasenia VARCHAR(200)
)
AS
BEGIN
	declare @existe bit = 0
	SET @Contrasenia = dbo.EncriptarClaveSHA1(@Contrasenia)

	SELECT @existe = 1 from  USUARIO  u
	WHERE u.Activo = 1
			AND u.CodigoUsuario =   @CodigoUsuario
			AND u.ClaveSecreta = @Contrasenia


	select @existe 'existe'
END


GO
USE BelcorpCostaRica
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContraseniaRepetida]')
		   AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[ContraseniaRepetida]
GO

create PROC ContraseniaRepetida
(
	@CodigoUsuario VARCHAR(50),
	@Contrasenia VARCHAR(200)
)
AS
BEGIN
	declare @existe bit = 0
	SET @Contrasenia = dbo.EncriptarClaveSHA1(@Contrasenia)

	SELECT @existe = 1 from  USUARIO  u
	WHERE u.Activo = 1
			AND u.CodigoUsuario =   @CodigoUsuario
			AND u.ClaveSecreta = @Contrasenia


	select @existe 'existe'
END


GO
USE BelcorpChile
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContraseniaRepetida]')
		   AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[ContraseniaRepetida]
GO

create PROC ContraseniaRepetida
(
	@CodigoUsuario VARCHAR(50),
	@Contrasenia VARCHAR(200)
)
AS
BEGIN
	declare @existe bit = 0
	SET @Contrasenia = dbo.EncriptarClaveSHA1(@Contrasenia)

	SELECT @existe = 1 from  USUARIO  u
	WHERE u.Activo = 1
			AND u.CodigoUsuario =   @CodigoUsuario
			AND u.ClaveSecreta = @Contrasenia


	select @existe 'existe'
END


GO
USE BelcorpBolivia
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContraseniaRepetida]')
		   AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[ContraseniaRepetida]
GO

create PROC ContraseniaRepetida
(
	@CodigoUsuario VARCHAR(50),
	@Contrasenia VARCHAR(200)
)
AS
BEGIN
	declare @existe bit = 0
	SET @Contrasenia = dbo.EncriptarClaveSHA1(@Contrasenia)

	SELECT @existe = 1 from  USUARIO  u
	WHERE u.Activo = 1
			AND u.CodigoUsuario =   @CodigoUsuario
			AND u.ClaveSecreta = @Contrasenia


	select @existe 'existe'
END


GO
