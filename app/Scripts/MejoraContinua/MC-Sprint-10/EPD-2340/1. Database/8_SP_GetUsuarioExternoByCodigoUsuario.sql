
USE BelcorpBolivia
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetUsuarioExternoByCodigoUsuario'))
BEGIN
    DROP PROCEDURE dbo.GetUsuarioExternoByCodigoUsuario
END
GO

CREATE PROCEDURE [dbo].[GetUsuarioExternoByCodigoUsuario]
(
	@CodigoUsuario VARCHAR(30)
)
AS

BEGIN
	SELECT TOP 1
		CodigoUsuario,
		Proveedor,
		IdAplicacion,
		[Login],
		Nombres,
		Apellidos,
		FechaNacimiento,
		Correo,
		Genero,
		Ubicacion,
		LinkPerfil,
		FotoPerfil,
		FechaRegistro,
		Estado 
	FROM UsuarioExterno 
	WHERE CodigoUsuario = @CodigoUsuario
	AND Estado = 1
END

GO
/*end*/

USE BelcorpChile
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetUsuarioExternoByCodigoUsuario'))
BEGIN
    DROP PROCEDURE dbo.GetUsuarioExternoByCodigoUsuario
END
GO

CREATE PROCEDURE [dbo].[GetUsuarioExternoByCodigoUsuario]
(
	@CodigoUsuario VARCHAR(30)
)
AS

BEGIN
	SELECT TOP 1
		CodigoUsuario,
		Proveedor,
		IdAplicacion,
		[Login],
		Nombres,
		Apellidos,
		FechaNacimiento,
		Correo,
		Genero,
		Ubicacion,
		LinkPerfil,
		FotoPerfil,
		FechaRegistro,
		Estado 
	FROM UsuarioExterno 
	WHERE CodigoUsuario = @CodigoUsuario
	AND Estado = 1
END

GO
/*end*/

USE BelcorpColombia
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetUsuarioExternoByCodigoUsuario'))
BEGIN
    DROP PROCEDURE dbo.GetUsuarioExternoByCodigoUsuario
END
GO

CREATE PROCEDURE [dbo].[GetUsuarioExternoByCodigoUsuario]
(
	@CodigoUsuario VARCHAR(30)
)
AS

BEGIN
	SELECT TOP 1
		CodigoUsuario,
		Proveedor,
		IdAplicacion,
		[Login],
		Nombres,
		Apellidos,
		FechaNacimiento,
		Correo,
		Genero,
		Ubicacion,
		LinkPerfil,
		FotoPerfil,
		FechaRegistro,
		Estado 
	FROM UsuarioExterno 
	WHERE CodigoUsuario = @CodigoUsuario
	AND Estado = 1
END

GO
/*end*/

USE BelcorpCostaRica
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetUsuarioExternoByCodigoUsuario'))
BEGIN
    DROP PROCEDURE dbo.GetUsuarioExternoByCodigoUsuario
END
GO

CREATE PROCEDURE [dbo].[GetUsuarioExternoByCodigoUsuario]
(
	@CodigoUsuario VARCHAR(30)
)
AS

BEGIN
	SELECT TOP 1
		CodigoUsuario,
		Proveedor,
		IdAplicacion,
		[Login],
		Nombres,
		Apellidos,
		FechaNacimiento,
		Correo,
		Genero,
		Ubicacion,
		LinkPerfil,
		FotoPerfil,
		FechaRegistro,
		Estado 
	FROM UsuarioExterno 
	WHERE CodigoUsuario = @CodigoUsuario
	AND Estado = 1
END

GO
/*end*/

USE BelcorpDominicana
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetUsuarioExternoByCodigoUsuario'))
BEGIN
    DROP PROCEDURE dbo.GetUsuarioExternoByCodigoUsuario
END
GO

CREATE PROCEDURE [dbo].[GetUsuarioExternoByCodigoUsuario]
(
	@CodigoUsuario VARCHAR(30)
)
AS

BEGIN
	SELECT TOP 1
		CodigoUsuario,
		Proveedor,
		IdAplicacion,
		[Login],
		Nombres,
		Apellidos,
		FechaNacimiento,
		Correo,
		Genero,
		Ubicacion,
		LinkPerfil,
		FotoPerfil,
		FechaRegistro,
		Estado 
	FROM UsuarioExterno 
	WHERE CodigoUsuario = @CodigoUsuario
	AND Estado = 1
END

GO
/*end*/

USE BelcorpEcuador
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetUsuarioExternoByCodigoUsuario'))
BEGIN
    DROP PROCEDURE dbo.GetUsuarioExternoByCodigoUsuario
END
GO

CREATE PROCEDURE [dbo].[GetUsuarioExternoByCodigoUsuario]
(
	@CodigoUsuario VARCHAR(30)
)
AS

BEGIN
	SELECT TOP 1
		CodigoUsuario,
		Proveedor,
		IdAplicacion,
		[Login],
		Nombres,
		Apellidos,
		FechaNacimiento,
		Correo,
		Genero,
		Ubicacion,
		LinkPerfil,
		FotoPerfil,
		FechaRegistro,
		Estado 
	FROM UsuarioExterno 
	WHERE CodigoUsuario = @CodigoUsuario
	AND Estado = 1
END

GO
/*end*/

USE BelcorpGuatemala
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetUsuarioExternoByCodigoUsuario'))
BEGIN
    DROP PROCEDURE dbo.GetUsuarioExternoByCodigoUsuario
END
GO

CREATE PROCEDURE [dbo].[GetUsuarioExternoByCodigoUsuario]
(
	@CodigoUsuario VARCHAR(30)
)
AS

BEGIN
	SELECT TOP 1
		CodigoUsuario,
		Proveedor,
		IdAplicacion,
		[Login],
		Nombres,
		Apellidos,
		FechaNacimiento,
		Correo,
		Genero,
		Ubicacion,
		LinkPerfil,
		FotoPerfil,
		FechaRegistro,
		Estado 
	FROM UsuarioExterno 
	WHERE CodigoUsuario = @CodigoUsuario
	AND Estado = 1
END

GO
/*end*/

USE BelcorpMexico
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetUsuarioExternoByCodigoUsuario'))
BEGIN
    DROP PROCEDURE dbo.GetUsuarioExternoByCodigoUsuario
END
GO

CREATE PROCEDURE [dbo].[GetUsuarioExternoByCodigoUsuario]
(
	@CodigoUsuario VARCHAR(30)
)
AS

BEGIN
	SELECT TOP 1
		CodigoUsuario,
		Proveedor,
		IdAplicacion,
		[Login],
		Nombres,
		Apellidos,
		FechaNacimiento,
		Correo,
		Genero,
		Ubicacion,
		LinkPerfil,
		FotoPerfil,
		FechaRegistro,
		Estado 
	FROM UsuarioExterno 
	WHERE CodigoUsuario = @CodigoUsuario
	AND Estado = 1
END

GO
/*end*/

USE BelcorpPanama
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetUsuarioExternoByCodigoUsuario'))
BEGIN
    DROP PROCEDURE dbo.GetUsuarioExternoByCodigoUsuario
END
GO

CREATE PROCEDURE [dbo].[GetUsuarioExternoByCodigoUsuario]
(
	@CodigoUsuario VARCHAR(30)
)
AS

BEGIN
	SELECT TOP 1
		CodigoUsuario,
		Proveedor,
		IdAplicacion,
		[Login],
		Nombres,
		Apellidos,
		FechaNacimiento,
		Correo,
		Genero,
		Ubicacion,
		LinkPerfil,
		FotoPerfil,
		FechaRegistro,
		Estado 
	FROM UsuarioExterno 
	WHERE CodigoUsuario = @CodigoUsuario
	AND Estado = 1
END

GO
/*end*/

USE BelcorpPeru
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetUsuarioExternoByCodigoUsuario'))
BEGIN
    DROP PROCEDURE dbo.GetUsuarioExternoByCodigoUsuario
END
GO

CREATE PROCEDURE [dbo].[GetUsuarioExternoByCodigoUsuario]
(
	@CodigoUsuario VARCHAR(30)
)
AS

BEGIN
	SELECT TOP 1
		CodigoUsuario,
		Proveedor,
		IdAplicacion,
		[Login],
		Nombres,
		Apellidos,
		FechaNacimiento,
		Correo,
		Genero,
		Ubicacion,
		LinkPerfil,
		FotoPerfil,
		FechaRegistro,
		Estado 
	FROM UsuarioExterno 
	WHERE CodigoUsuario = @CodigoUsuario
	AND Estado = 1
END

GO
/*end*/

USE BelcorpPuertoRico
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetUsuarioExternoByCodigoUsuario'))
BEGIN
    DROP PROCEDURE dbo.GetUsuarioExternoByCodigoUsuario
END
GO

CREATE PROCEDURE [dbo].[GetUsuarioExternoByCodigoUsuario]
(
	@CodigoUsuario VARCHAR(30)
)
AS

BEGIN
	SELECT TOP 1
		CodigoUsuario,
		Proveedor,
		IdAplicacion,
		[Login],
		Nombres,
		Apellidos,
		FechaNacimiento,
		Correo,
		Genero,
		Ubicacion,
		LinkPerfil,
		FotoPerfil,
		FechaRegistro,
		Estado 
	FROM UsuarioExterno 
	WHERE CodigoUsuario = @CodigoUsuario
	AND Estado = 1
END

GO
/*end*/

USE BelcorpSalvador
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetUsuarioExternoByCodigoUsuario'))
BEGIN
    DROP PROCEDURE dbo.GetUsuarioExternoByCodigoUsuario
END
GO

CREATE PROCEDURE [dbo].[GetUsuarioExternoByCodigoUsuario]
(
	@CodigoUsuario VARCHAR(30)
)
AS

BEGIN
	SELECT TOP 1
		CodigoUsuario,
		Proveedor,
		IdAplicacion,
		[Login],
		Nombres,
		Apellidos,
		FechaNacimiento,
		Correo,
		Genero,
		Ubicacion,
		LinkPerfil,
		FotoPerfil,
		FechaRegistro,
		Estado 
	FROM UsuarioExterno 
	WHERE CodigoUsuario = @CodigoUsuario
	AND Estado = 1
END

GO
/*end*/

USE BelcorpVenezuela
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetUsuarioExternoByCodigoUsuario'))
BEGIN
    DROP PROCEDURE dbo.GetUsuarioExternoByCodigoUsuario
END
GO

CREATE PROCEDURE [dbo].[GetUsuarioExternoByCodigoUsuario]
(
	@CodigoUsuario VARCHAR(30)
)
AS

BEGIN
	SELECT TOP 1
		CodigoUsuario,
		Proveedor,
		IdAplicacion,
		[Login],
		Nombres,
		Apellidos,
		FechaNacimiento,
		Correo,
		Genero,
		Ubicacion,
		LinkPerfil,
		FotoPerfil,
		FechaRegistro,
		Estado 
	FROM UsuarioExterno 
	WHERE CodigoUsuario = @CodigoUsuario
	AND Estado = 1
END

GO

