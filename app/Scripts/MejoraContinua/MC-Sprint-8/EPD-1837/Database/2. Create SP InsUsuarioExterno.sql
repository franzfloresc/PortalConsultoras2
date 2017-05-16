

USE BelcorpBolivia
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.InsUsuarioExterno'))
BEGIN
    DROP PROCEDURE dbo.InsUsuarioExterno
END
GO

CREATE PROCEDURE InsUsuarioExterno
(
	@CodigoUsuario VARCHAR(20),
	@Proveedor VARCHAR(20),
	@IdAplicacion VARCHAR(50),
	@Login VARCHAR(50),
	@Nombres VARCHAR(50),
	@Apellidos VARCHAR(50),
	@FechaNacimiento VARCHAR(20),
	@Correo VARCHAR(50),
	@Genero VARCHAR(10),
	@Ubicacion VARCHAR(30),
	@LinkPerfil VARCHAR(150),
	@FotoPerfil VARCHAR(255)
)
AS
BEGIN
	INSERT INTO UsuarioExterno
	(
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
	)
	VALUES 
	(
		@CodigoUsuario,
		@Proveedor,
		@IdAplicacion,
		@Login,
		@Nombres,
		@Apellidos,
		@FechaNacimiento,
		@Correo,
		@Genero,
		@Ubicacion,
		@LinkPerfil,
		@FotoPerfil,
		GETDATE(),
		1
	)

	SELECT SCOPE_IDENTITY()
END
GO

/*end*/

USE BelcorpChile
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.InsUsuarioExterno'))
BEGIN
    DROP PROCEDURE dbo.InsUsuarioExterno
END
GO

CREATE PROCEDURE InsUsuarioExterno
(
	@CodigoUsuario VARCHAR(20),
	@Proveedor VARCHAR(20),
	@IdAplicacion VARCHAR(50),
	@Login VARCHAR(50),
	@Nombres VARCHAR(50),
	@Apellidos VARCHAR(50),
	@FechaNacimiento VARCHAR(20),
	@Correo VARCHAR(50),
	@Genero VARCHAR(10),
	@Ubicacion VARCHAR(30),
	@LinkPerfil VARCHAR(150),
	@FotoPerfil VARCHAR(255)
)
AS
BEGIN
	INSERT INTO UsuarioExterno
	(
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
	)
	VALUES 
	(
		@CodigoUsuario,
		@Proveedor,
		@IdAplicacion,
		@Login,
		@Nombres,
		@Apellidos,
		@FechaNacimiento,
		@Correo,
		@Genero,
		@Ubicacion,
		@LinkPerfil,
		@FotoPerfil,
		GETDATE(),
		1
	)

	SELECT SCOPE_IDENTITY()
END
GO

/*end*/

USE BelcorpColombia
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.InsUsuarioExterno'))
BEGIN
    DROP PROCEDURE dbo.InsUsuarioExterno
END
GO

CREATE PROCEDURE InsUsuarioExterno
(
	@CodigoUsuario VARCHAR(20),
	@Proveedor VARCHAR(20),
	@IdAplicacion VARCHAR(50),
	@Login VARCHAR(50),
	@Nombres VARCHAR(50),
	@Apellidos VARCHAR(50),
	@FechaNacimiento VARCHAR(20),
	@Correo VARCHAR(50),
	@Genero VARCHAR(10),
	@Ubicacion VARCHAR(30),
	@LinkPerfil VARCHAR(150),
	@FotoPerfil VARCHAR(255)
)
AS
BEGIN
	INSERT INTO UsuarioExterno
	(
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
	)
	VALUES 
	(
		@CodigoUsuario,
		@Proveedor,
		@IdAplicacion,
		@Login,
		@Nombres,
		@Apellidos,
		@FechaNacimiento,
		@Correo,
		@Genero,
		@Ubicacion,
		@LinkPerfil,
		@FotoPerfil,
		GETDATE(),
		1
	)

	SELECT SCOPE_IDENTITY()
END
GO

/*end*/

USE BelcorpCostaRica
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.InsUsuarioExterno'))
BEGIN
    DROP PROCEDURE dbo.InsUsuarioExterno
END
GO

CREATE PROCEDURE InsUsuarioExterno
(
	@CodigoUsuario VARCHAR(20),
	@Proveedor VARCHAR(20),
	@IdAplicacion VARCHAR(50),
	@Login VARCHAR(50),
	@Nombres VARCHAR(50),
	@Apellidos VARCHAR(50),
	@FechaNacimiento VARCHAR(20),
	@Correo VARCHAR(50),
	@Genero VARCHAR(10),
	@Ubicacion VARCHAR(30),
	@LinkPerfil VARCHAR(150),
	@FotoPerfil VARCHAR(255)
)
AS
BEGIN
	INSERT INTO UsuarioExterno
	(
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
	)
	VALUES 
	(
		@CodigoUsuario,
		@Proveedor,
		@IdAplicacion,
		@Login,
		@Nombres,
		@Apellidos,
		@FechaNacimiento,
		@Correo,
		@Genero,
		@Ubicacion,
		@LinkPerfil,
		@FotoPerfil,
		GETDATE(),
		1
	)

	SELECT SCOPE_IDENTITY()
END
GO

/*end*/

USE BelcorpDominicana
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.InsUsuarioExterno'))
BEGIN
    DROP PROCEDURE dbo.InsUsuarioExterno
END
GO

CREATE PROCEDURE InsUsuarioExterno
(
	@CodigoUsuario VARCHAR(20),
	@Proveedor VARCHAR(20),
	@IdAplicacion VARCHAR(50),
	@Login VARCHAR(50),
	@Nombres VARCHAR(50),
	@Apellidos VARCHAR(50),
	@FechaNacimiento VARCHAR(20),
	@Correo VARCHAR(50),
	@Genero VARCHAR(10),
	@Ubicacion VARCHAR(30),
	@LinkPerfil VARCHAR(150),
	@FotoPerfil VARCHAR(255)
)
AS
BEGIN
	INSERT INTO UsuarioExterno
	(
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
	)
	VALUES 
	(
		@CodigoUsuario,
		@Proveedor,
		@IdAplicacion,
		@Login,
		@Nombres,
		@Apellidos,
		@FechaNacimiento,
		@Correo,
		@Genero,
		@Ubicacion,
		@LinkPerfil,
		@FotoPerfil,
		GETDATE(),
		1
	)

	SELECT SCOPE_IDENTITY()
END
GO

/*end*/

USE BelcorpEcuador
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.InsUsuarioExterno'))
BEGIN
    DROP PROCEDURE dbo.InsUsuarioExterno
END
GO

CREATE PROCEDURE InsUsuarioExterno
(
	@CodigoUsuario VARCHAR(20),
	@Proveedor VARCHAR(20),
	@IdAplicacion VARCHAR(50),
	@Login VARCHAR(50),
	@Nombres VARCHAR(50),
	@Apellidos VARCHAR(50),
	@FechaNacimiento VARCHAR(20),
	@Correo VARCHAR(50),
	@Genero VARCHAR(10),
	@Ubicacion VARCHAR(30),
	@LinkPerfil VARCHAR(150),
	@FotoPerfil VARCHAR(255)
)
AS
BEGIN
	INSERT INTO UsuarioExterno
	(
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
	)
	VALUES 
	(
		@CodigoUsuario,
		@Proveedor,
		@IdAplicacion,
		@Login,
		@Nombres,
		@Apellidos,
		@FechaNacimiento,
		@Correo,
		@Genero,
		@Ubicacion,
		@LinkPerfil,
		@FotoPerfil,
		GETDATE(),
		1
	)

	SELECT SCOPE_IDENTITY()
END
GO

/*end*/

USE BelcorpGuatemala
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.InsUsuarioExterno'))
BEGIN
    DROP PROCEDURE dbo.InsUsuarioExterno
END
GO

CREATE PROCEDURE InsUsuarioExterno
(
	@CodigoUsuario VARCHAR(20),
	@Proveedor VARCHAR(20),
	@IdAplicacion VARCHAR(50),
	@Login VARCHAR(50),
	@Nombres VARCHAR(50),
	@Apellidos VARCHAR(50),
	@FechaNacimiento VARCHAR(20),
	@Correo VARCHAR(50),
	@Genero VARCHAR(10),
	@Ubicacion VARCHAR(30),
	@LinkPerfil VARCHAR(150),
	@FotoPerfil VARCHAR(255)
)
AS
BEGIN
	INSERT INTO UsuarioExterno
	(
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
	)
	VALUES 
	(
		@CodigoUsuario,
		@Proveedor,
		@IdAplicacion,
		@Login,
		@Nombres,
		@Apellidos,
		@FechaNacimiento,
		@Correo,
		@Genero,
		@Ubicacion,
		@LinkPerfil,
		@FotoPerfil,
		GETDATE(),
		1
	)

	SELECT SCOPE_IDENTITY()
END
GO

/*end*/

USE BelcorpMexico
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.InsUsuarioExterno'))
BEGIN
    DROP PROCEDURE dbo.InsUsuarioExterno
END
GO

CREATE PROCEDURE InsUsuarioExterno
(
	@CodigoUsuario VARCHAR(20),
	@Proveedor VARCHAR(20),
	@IdAplicacion VARCHAR(50),
	@Login VARCHAR(50),
	@Nombres VARCHAR(50),
	@Apellidos VARCHAR(50),
	@FechaNacimiento VARCHAR(20),
	@Correo VARCHAR(50),
	@Genero VARCHAR(10),
	@Ubicacion VARCHAR(30),
	@LinkPerfil VARCHAR(150),
	@FotoPerfil VARCHAR(255)
)
AS
BEGIN
	INSERT INTO UsuarioExterno
	(
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
	)
	VALUES 
	(
		@CodigoUsuario,
		@Proveedor,
		@IdAplicacion,
		@Login,
		@Nombres,
		@Apellidos,
		@FechaNacimiento,
		@Correo,
		@Genero,
		@Ubicacion,
		@LinkPerfil,
		@FotoPerfil,
		GETDATE(),
		1
	)

	SELECT SCOPE_IDENTITY()
END
GO

/*end*/

USE BelcorpPanama
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.InsUsuarioExterno'))
BEGIN
    DROP PROCEDURE dbo.InsUsuarioExterno
END
GO

CREATE PROCEDURE InsUsuarioExterno
(
	@CodigoUsuario VARCHAR(20),
	@Proveedor VARCHAR(20),
	@IdAplicacion VARCHAR(50),
	@Login VARCHAR(50),
	@Nombres VARCHAR(50),
	@Apellidos VARCHAR(50),
	@FechaNacimiento VARCHAR(20),
	@Correo VARCHAR(50),
	@Genero VARCHAR(10),
	@Ubicacion VARCHAR(30),
	@LinkPerfil VARCHAR(150),
	@FotoPerfil VARCHAR(255)
)
AS
BEGIN
	INSERT INTO UsuarioExterno
	(
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
	)
	VALUES 
	(
		@CodigoUsuario,
		@Proveedor,
		@IdAplicacion,
		@Login,
		@Nombres,
		@Apellidos,
		@FechaNacimiento,
		@Correo,
		@Genero,
		@Ubicacion,
		@LinkPerfil,
		@FotoPerfil,
		GETDATE(),
		1
	)

	SELECT SCOPE_IDENTITY()
END
GO

/*end*/

USE BelcorpPeru
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.InsUsuarioExterno'))
BEGIN
    DROP PROCEDURE dbo.InsUsuarioExterno
END
GO

CREATE PROCEDURE InsUsuarioExterno
(
	@CodigoUsuario VARCHAR(20),
	@Proveedor VARCHAR(20),
	@IdAplicacion VARCHAR(50),
	@Login VARCHAR(50),
	@Nombres VARCHAR(50),
	@Apellidos VARCHAR(50),
	@FechaNacimiento VARCHAR(20),
	@Correo VARCHAR(50),
	@Genero VARCHAR(10),
	@Ubicacion VARCHAR(30),
	@LinkPerfil VARCHAR(150),
	@FotoPerfil VARCHAR(255)
)
AS
BEGIN
	INSERT INTO UsuarioExterno
	(
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
	)
	VALUES 
	(
		@CodigoUsuario,
		@Proveedor,
		@IdAplicacion,
		@Login,
		@Nombres,
		@Apellidos,
		@FechaNacimiento,
		@Correo,
		@Genero,
		@Ubicacion,
		@LinkPerfil,
		@FotoPerfil,
		GETDATE(),
		1
	)

	SELECT SCOPE_IDENTITY()
END
GO

/*end*/

USE BelcorpPuertoRico
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.InsUsuarioExterno'))
BEGIN
    DROP PROCEDURE dbo.InsUsuarioExterno
END
GO

CREATE PROCEDURE InsUsuarioExterno
(
	@CodigoUsuario VARCHAR(20),
	@Proveedor VARCHAR(20),
	@IdAplicacion VARCHAR(50),
	@Login VARCHAR(50),
	@Nombres VARCHAR(50),
	@Apellidos VARCHAR(50),
	@FechaNacimiento VARCHAR(20),
	@Correo VARCHAR(50),
	@Genero VARCHAR(10),
	@Ubicacion VARCHAR(30),
	@LinkPerfil VARCHAR(150),
	@FotoPerfil VARCHAR(255)
)
AS
BEGIN
	INSERT INTO UsuarioExterno
	(
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
	)
	VALUES 
	(
		@CodigoUsuario,
		@Proveedor,
		@IdAplicacion,
		@Login,
		@Nombres,
		@Apellidos,
		@FechaNacimiento,
		@Correo,
		@Genero,
		@Ubicacion,
		@LinkPerfil,
		@FotoPerfil,
		GETDATE(),
		1
	)

	SELECT SCOPE_IDENTITY()
END
GO

/*end*/

USE BelcorpSalvador
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.InsUsuarioExterno'))
BEGIN
    DROP PROCEDURE dbo.InsUsuarioExterno
END
GO

CREATE PROCEDURE InsUsuarioExterno
(
	@CodigoUsuario VARCHAR(20),
	@Proveedor VARCHAR(20),
	@IdAplicacion VARCHAR(50),
	@Login VARCHAR(50),
	@Nombres VARCHAR(50),
	@Apellidos VARCHAR(50),
	@FechaNacimiento VARCHAR(20),
	@Correo VARCHAR(50),
	@Genero VARCHAR(10),
	@Ubicacion VARCHAR(30),
	@LinkPerfil VARCHAR(150),
	@FotoPerfil VARCHAR(255)
)
AS
BEGIN
	INSERT INTO UsuarioExterno
	(
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
	)
	VALUES 
	(
		@CodigoUsuario,
		@Proveedor,
		@IdAplicacion,
		@Login,
		@Nombres,
		@Apellidos,
		@FechaNacimiento,
		@Correo,
		@Genero,
		@Ubicacion,
		@LinkPerfil,
		@FotoPerfil,
		GETDATE(),
		1
	)

	SELECT SCOPE_IDENTITY()
END
GO

/*end*/

USE BelcorpVenezuela
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.InsUsuarioExterno'))
BEGIN
    DROP PROCEDURE dbo.InsUsuarioExterno
END
GO

CREATE PROCEDURE InsUsuarioExterno
(
	@CodigoUsuario VARCHAR(20),
	@Proveedor VARCHAR(20),
	@IdAplicacion VARCHAR(50),
	@Login VARCHAR(50),
	@Nombres VARCHAR(50),
	@Apellidos VARCHAR(50),
	@FechaNacimiento VARCHAR(20),
	@Correo VARCHAR(50),
	@Genero VARCHAR(10),
	@Ubicacion VARCHAR(30),
	@LinkPerfil VARCHAR(150),
	@FotoPerfil VARCHAR(255)
)
AS
BEGIN
	INSERT INTO UsuarioExterno
	(
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
	)
	VALUES 
	(
		@CodigoUsuario,
		@Proveedor,
		@IdAplicacion,
		@Login,
		@Nombres,
		@Apellidos,
		@FechaNacimiento,
		@Correo,
		@Genero,
		@Ubicacion,
		@LinkPerfil,
		@FotoPerfil,
		GETDATE(),
		1
	)

	SELECT SCOPE_IDENTITY()
END
GO




