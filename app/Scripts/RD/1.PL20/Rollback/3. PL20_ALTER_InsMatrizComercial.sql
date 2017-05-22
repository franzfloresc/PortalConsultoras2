USE BelcorpBolivia
GO
ALTER PROCEDURE InsMatrizComercial
	@CodigoSAP varchar(50),
	@DescripcionOriginal varchar(250),
	@Descripcion varchar(250),
	@FotoProducto01 varchar(150),
	@FotoProducto02 varchar(150),
	@FotoProducto03 varchar(150),
	@FotoProducto04 varchar(150),
	@FotoProducto05 varchar(150),
	@FotoProducto06 varchar(150),
	@FotoProducto07 varchar(150),
	@FotoProducto08 varchar(150),
	@FotoProducto09 varchar(150),
	@FotoProducto10 varchar(150),
	@UsuarioRegistro varchar(50)
AS
	IF NOT EXISTS(SELECT IdMatrizComercial FROM dbo.MatrizComercial WHERE CodigoSAP=@CodigoSAP)
	BEGIN
		INSERT INTO MatrizComercial
		(
			CodigoSAP,
			DescripcionOriginal,
			Descripcion,
			FotoProducto01,
			FotoProducto02,
			FotoProducto03,
			FotoProducto04,
			FotoProducto05,
			FotoProducto06,
			FotoProducto07,
			FotoProducto08,
			FotoProducto09,
			FotoProducto10,
			UsuarioRegistro,
			FechaRegistro
		)
		VALUES
		(
			@CodigoSAP,
			@DescripcionOriginal,
			@Descripcion,
			@FotoProducto01,
			@FotoProducto02,
			@FotoProducto03,
			@FotoProducto04,
			@FotoProducto05,
			@FotoProducto06,
			@FotoProducto07,
			@FotoProducto08,
			@FotoProducto09,
			@FotoProducto10,
			@UsuarioRegistro,
			GETDATE()
		)
		END
GO
USE BelcorpCostaRica
GO
ALTER PROCEDURE InsMatrizComercial
	@CodigoSAP varchar(50),
	@DescripcionOriginal varchar(250),
	@Descripcion varchar(250),
	@FotoProducto01 varchar(150),
	@FotoProducto02 varchar(150),
	@FotoProducto03 varchar(150),
	@FotoProducto04 varchar(150),
	@FotoProducto05 varchar(150),
	@FotoProducto06 varchar(150),
	@FotoProducto07 varchar(150),
	@FotoProducto08 varchar(150),
	@FotoProducto09 varchar(150),
	@FotoProducto10 varchar(150),
	@UsuarioRegistro varchar(50)
AS
	IF NOT EXISTS(SELECT IdMatrizComercial FROM dbo.MatrizComercial WHERE CodigoSAP=@CodigoSAP)
	BEGIN
		INSERT INTO MatrizComercial
		(
			CodigoSAP,
			DescripcionOriginal,
			Descripcion,
			FotoProducto01,
			FotoProducto02,
			FotoProducto03,
			FotoProducto04,
			FotoProducto05,
			FotoProducto06,
			FotoProducto07,
			FotoProducto08,
			FotoProducto09,
			FotoProducto10,
			UsuarioRegistro,
			FechaRegistro
		)
		VALUES
		(
			@CodigoSAP,
			@DescripcionOriginal,
			@Descripcion,
			@FotoProducto01,
			@FotoProducto02,
			@FotoProducto03,
			@FotoProducto04,
			@FotoProducto05,
			@FotoProducto06,
			@FotoProducto07,
			@FotoProducto08,
			@FotoProducto09,
			@FotoProducto10,
			@UsuarioRegistro,
			GETDATE()
		)
		END
GO
USE BelcorpChile
GO
ALTER PROCEDURE InsMatrizComercial
	@CodigoSAP varchar(50),
	@DescripcionOriginal varchar(250),
	@Descripcion varchar(250),
	@FotoProducto01 varchar(150),
	@FotoProducto02 varchar(150),
	@FotoProducto03 varchar(150),
	@FotoProducto04 varchar(150),
	@FotoProducto05 varchar(150),
	@FotoProducto06 varchar(150),
	@FotoProducto07 varchar(150),
	@FotoProducto08 varchar(150),
	@FotoProducto09 varchar(150),
	@FotoProducto10 varchar(150),
	@UsuarioRegistro varchar(50)
AS
	IF NOT EXISTS(SELECT IdMatrizComercial FROM dbo.MatrizComercial WHERE CodigoSAP=@CodigoSAP)
	BEGIN
		INSERT INTO MatrizComercial
		(
			CodigoSAP,
			DescripcionOriginal,
			Descripcion,
			FotoProducto01,
			FotoProducto02,
			FotoProducto03,
			FotoProducto04,
			FotoProducto05,
			FotoProducto06,
			FotoProducto07,
			FotoProducto08,
			FotoProducto09,
			FotoProducto10,
			UsuarioRegistro,
			FechaRegistro
		)
		VALUES
		(
			@CodigoSAP,
			@DescripcionOriginal,
			@Descripcion,
			@FotoProducto01,
			@FotoProducto02,
			@FotoProducto03,
			@FotoProducto04,
			@FotoProducto05,
			@FotoProducto06,
			@FotoProducto07,
			@FotoProducto08,
			@FotoProducto09,
			@FotoProducto10,
			@UsuarioRegistro,
			GETDATE()
		)
		END
GO
USE BelcorpColombia
GO
ALTER PROCEDURE InsMatrizComercial
	@CodigoSAP varchar(50),
	@DescripcionOriginal varchar(250),
	@Descripcion varchar(250),
	@FotoProducto01 varchar(150),
	@FotoProducto02 varchar(150),
	@FotoProducto03 varchar(150),
	@FotoProducto04 varchar(150),
	@FotoProducto05 varchar(150),
	@FotoProducto06 varchar(150),
	@FotoProducto07 varchar(150),
	@FotoProducto08 varchar(150),
	@FotoProducto09 varchar(150),
	@FotoProducto10 varchar(150),
	@UsuarioRegistro varchar(50)
AS
	IF NOT EXISTS(SELECT IdMatrizComercial FROM dbo.MatrizComercial WHERE CodigoSAP=@CodigoSAP)
	BEGIN
		INSERT INTO MatrizComercial
		(
			CodigoSAP,
			DescripcionOriginal,
			Descripcion,
			FotoProducto01,
			FotoProducto02,
			FotoProducto03,
			FotoProducto04,
			FotoProducto05,
			FotoProducto06,
			FotoProducto07,
			FotoProducto08,
			FotoProducto09,
			FotoProducto10,
			UsuarioRegistro,
			FechaRegistro
		)
		VALUES
		(
			@CodigoSAP,
			@DescripcionOriginal,
			@Descripcion,
			@FotoProducto01,
			@FotoProducto02,
			@FotoProducto03,
			@FotoProducto04,
			@FotoProducto05,
			@FotoProducto06,
			@FotoProducto07,
			@FotoProducto08,
			@FotoProducto09,
			@FotoProducto10,
			@UsuarioRegistro,
			GETDATE()
		)
		END
GO
USE BelcorpDominicana
GO
ALTER PROCEDURE InsMatrizComercial
	@CodigoSAP varchar(50),
	@DescripcionOriginal varchar(250),
	@Descripcion varchar(250),
	@FotoProducto01 varchar(150),
	@FotoProducto02 varchar(150),
	@FotoProducto03 varchar(150),
	@FotoProducto04 varchar(150),
	@FotoProducto05 varchar(150),
	@FotoProducto06 varchar(150),
	@FotoProducto07 varchar(150),
	@FotoProducto08 varchar(150),
	@FotoProducto09 varchar(150),
	@FotoProducto10 varchar(150),
	@UsuarioRegistro varchar(50)
AS
	IF NOT EXISTS(SELECT IdMatrizComercial FROM dbo.MatrizComercial WHERE CodigoSAP=@CodigoSAP)
	BEGIN
		INSERT INTO MatrizComercial
		(
			CodigoSAP,
			DescripcionOriginal,
			Descripcion,
			FotoProducto01,
			FotoProducto02,
			FotoProducto03,
			FotoProducto04,
			FotoProducto05,
			FotoProducto06,
			FotoProducto07,
			FotoProducto08,
			FotoProducto09,
			FotoProducto10,
			UsuarioRegistro,
			FechaRegistro
		)
		VALUES
		(
			@CodigoSAP,
			@DescripcionOriginal,
			@Descripcion,
			@FotoProducto01,
			@FotoProducto02,
			@FotoProducto03,
			@FotoProducto04,
			@FotoProducto05,
			@FotoProducto06,
			@FotoProducto07,
			@FotoProducto08,
			@FotoProducto09,
			@FotoProducto10,
			@UsuarioRegistro,
			GETDATE()
		)
		END
GO
USE BelcorpEcuador
GO
ALTER PROCEDURE InsMatrizComercial
	@CodigoSAP varchar(50),
	@DescripcionOriginal varchar(250),
	@Descripcion varchar(250),
	@FotoProducto01 varchar(150),
	@FotoProducto02 varchar(150),
	@FotoProducto03 varchar(150),
	@FotoProducto04 varchar(150),
	@FotoProducto05 varchar(150),
	@FotoProducto06 varchar(150),
	@FotoProducto07 varchar(150),
	@FotoProducto08 varchar(150),
	@FotoProducto09 varchar(150),
	@FotoProducto10 varchar(150),
	@UsuarioRegistro varchar(50)
AS
	IF NOT EXISTS(SELECT IdMatrizComercial FROM dbo.MatrizComercial WHERE CodigoSAP=@CodigoSAP)
	BEGIN
		INSERT INTO MatrizComercial
		(
			CodigoSAP,
			DescripcionOriginal,
			Descripcion,
			FotoProducto01,
			FotoProducto02,
			FotoProducto03,
			FotoProducto04,
			FotoProducto05,
			FotoProducto06,
			FotoProducto07,
			FotoProducto08,
			FotoProducto09,
			FotoProducto10,
			UsuarioRegistro,
			FechaRegistro
		)
		VALUES
		(
			@CodigoSAP,
			@DescripcionOriginal,
			@Descripcion,
			@FotoProducto01,
			@FotoProducto02,
			@FotoProducto03,
			@FotoProducto04,
			@FotoProducto05,
			@FotoProducto06,
			@FotoProducto07,
			@FotoProducto08,
			@FotoProducto09,
			@FotoProducto10,
			@UsuarioRegistro,
			GETDATE()
		)
		END
GO
USE BelcorpGuatemala
GO
ALTER PROCEDURE InsMatrizComercial
	@CodigoSAP varchar(50),
	@DescripcionOriginal varchar(250),
	@Descripcion varchar(250),
	@FotoProducto01 varchar(150),
	@FotoProducto02 varchar(150),
	@FotoProducto03 varchar(150),
	@FotoProducto04 varchar(150),
	@FotoProducto05 varchar(150),
	@FotoProducto06 varchar(150),
	@FotoProducto07 varchar(150),
	@FotoProducto08 varchar(150),
	@FotoProducto09 varchar(150),
	@FotoProducto10 varchar(150),
	@UsuarioRegistro varchar(50)
AS
	IF NOT EXISTS(SELECT IdMatrizComercial FROM dbo.MatrizComercial WHERE CodigoSAP=@CodigoSAP)
	BEGIN
		INSERT INTO MatrizComercial
		(
			CodigoSAP,
			DescripcionOriginal,
			Descripcion,
			FotoProducto01,
			FotoProducto02,
			FotoProducto03,
			FotoProducto04,
			FotoProducto05,
			FotoProducto06,
			FotoProducto07,
			FotoProducto08,
			FotoProducto09,
			FotoProducto10,
			UsuarioRegistro,
			FechaRegistro
		)
		VALUES
		(
			@CodigoSAP,
			@DescripcionOriginal,
			@Descripcion,
			@FotoProducto01,
			@FotoProducto02,
			@FotoProducto03,
			@FotoProducto04,
			@FotoProducto05,
			@FotoProducto06,
			@FotoProducto07,
			@FotoProducto08,
			@FotoProducto09,
			@FotoProducto10,
			@UsuarioRegistro,
			GETDATE()
		)
		END
GO
USE BelcorpMexico
GO
ALTER PROCEDURE InsMatrizComercial
	@CodigoSAP varchar(50),
	@DescripcionOriginal varchar(250),
	@Descripcion varchar(250),
	@FotoProducto01 varchar(150),
	@FotoProducto02 varchar(150),
	@FotoProducto03 varchar(150),
	@FotoProducto04 varchar(150),
	@FotoProducto05 varchar(150),
	@FotoProducto06 varchar(150),
	@FotoProducto07 varchar(150),
	@FotoProducto08 varchar(150),
	@FotoProducto09 varchar(150),
	@FotoProducto10 varchar(150),
	@UsuarioRegistro varchar(50)
AS
	IF NOT EXISTS(SELECT IdMatrizComercial FROM dbo.MatrizComercial WHERE CodigoSAP=@CodigoSAP)
	BEGIN
		INSERT INTO MatrizComercial
		(
			CodigoSAP,
			DescripcionOriginal,
			Descripcion,
			FotoProducto01,
			FotoProducto02,
			FotoProducto03,
			FotoProducto04,
			FotoProducto05,
			FotoProducto06,
			FotoProducto07,
			FotoProducto08,
			FotoProducto09,
			FotoProducto10,
			UsuarioRegistro,
			FechaRegistro
		)
		VALUES
		(
			@CodigoSAP,
			@DescripcionOriginal,
			@Descripcion,
			@FotoProducto01,
			@FotoProducto02,
			@FotoProducto03,
			@FotoProducto04,
			@FotoProducto05,
			@FotoProducto06,
			@FotoProducto07,
			@FotoProducto08,
			@FotoProducto09,
			@FotoProducto10,
			@UsuarioRegistro,
			GETDATE()
		)
		END
GO
USE BelcorpPanama
GO
ALTER PROCEDURE InsMatrizComercial
	@CodigoSAP varchar(50),
	@DescripcionOriginal varchar(250),
	@Descripcion varchar(250),
	@FotoProducto01 varchar(150),
	@FotoProducto02 varchar(150),
	@FotoProducto03 varchar(150),
	@FotoProducto04 varchar(150),
	@FotoProducto05 varchar(150),
	@FotoProducto06 varchar(150),
	@FotoProducto07 varchar(150),
	@FotoProducto08 varchar(150),
	@FotoProducto09 varchar(150),
	@FotoProducto10 varchar(150),
	@UsuarioRegistro varchar(50)
AS
	IF NOT EXISTS(SELECT IdMatrizComercial FROM dbo.MatrizComercial WHERE CodigoSAP=@CodigoSAP)
	BEGIN
		INSERT INTO MatrizComercial
		(
			CodigoSAP,
			DescripcionOriginal,
			Descripcion,
			FotoProducto01,
			FotoProducto02,
			FotoProducto03,
			FotoProducto04,
			FotoProducto05,
			FotoProducto06,
			FotoProducto07,
			FotoProducto08,
			FotoProducto09,
			FotoProducto10,
			UsuarioRegistro,
			FechaRegistro
		)
		VALUES
		(
			@CodigoSAP,
			@DescripcionOriginal,
			@Descripcion,
			@FotoProducto01,
			@FotoProducto02,
			@FotoProducto03,
			@FotoProducto04,
			@FotoProducto05,
			@FotoProducto06,
			@FotoProducto07,
			@FotoProducto08,
			@FotoProducto09,
			@FotoProducto10,
			@UsuarioRegistro,
			GETDATE()
		)
		END
GO
USE BelcorpPeru
GO
ALTER PROCEDURE InsMatrizComercial
	@CodigoSAP varchar(50),
	@DescripcionOriginal varchar(250),
	@Descripcion varchar(250),
	@FotoProducto01 varchar(150),
	@FotoProducto02 varchar(150),
	@FotoProducto03 varchar(150),
	@FotoProducto04 varchar(150),
	@FotoProducto05 varchar(150),
	@FotoProducto06 varchar(150),
	@FotoProducto07 varchar(150),
	@FotoProducto08 varchar(150),
	@FotoProducto09 varchar(150),
	@FotoProducto10 varchar(150),
	@UsuarioRegistro varchar(50)
AS
	IF NOT EXISTS(SELECT IdMatrizComercial FROM dbo.MatrizComercial WHERE CodigoSAP=@CodigoSAP)
	BEGIN
		INSERT INTO MatrizComercial
		(
			CodigoSAP,
			DescripcionOriginal,
			Descripcion,
			FotoProducto01,
			FotoProducto02,
			FotoProducto03,
			FotoProducto04,
			FotoProducto05,
			FotoProducto06,
			FotoProducto07,
			FotoProducto08,
			FotoProducto09,
			FotoProducto10,
			UsuarioRegistro,
			FechaRegistro
		)
		VALUES
		(
			@CodigoSAP,
			@DescripcionOriginal,
			@Descripcion,
			@FotoProducto01,
			@FotoProducto02,
			@FotoProducto03,
			@FotoProducto04,
			@FotoProducto05,
			@FotoProducto06,
			@FotoProducto07,
			@FotoProducto08,
			@FotoProducto09,
			@FotoProducto10,
			@UsuarioRegistro,
			GETDATE()
		)
		END
GO
USE BelcorpPuertoRico
GO
ALTER PROCEDURE InsMatrizComercial
	@CodigoSAP varchar(50),
	@DescripcionOriginal varchar(250),
	@Descripcion varchar(250),
	@FotoProducto01 varchar(150),
	@FotoProducto02 varchar(150),
	@FotoProducto03 varchar(150),
	@FotoProducto04 varchar(150),
	@FotoProducto05 varchar(150),
	@FotoProducto06 varchar(150),
	@FotoProducto07 varchar(150),
	@FotoProducto08 varchar(150),
	@FotoProducto09 varchar(150),
	@FotoProducto10 varchar(150),
	@UsuarioRegistro varchar(50)
AS
	IF NOT EXISTS(SELECT IdMatrizComercial FROM dbo.MatrizComercial WHERE CodigoSAP=@CodigoSAP)
	BEGIN
		INSERT INTO MatrizComercial
		(
			CodigoSAP,
			DescripcionOriginal,
			Descripcion,
			FotoProducto01,
			FotoProducto02,
			FotoProducto03,
			FotoProducto04,
			FotoProducto05,
			FotoProducto06,
			FotoProducto07,
			FotoProducto08,
			FotoProducto09,
			FotoProducto10,
			UsuarioRegistro,
			FechaRegistro
		)
		VALUES
		(
			@CodigoSAP,
			@DescripcionOriginal,
			@Descripcion,
			@FotoProducto01,
			@FotoProducto02,
			@FotoProducto03,
			@FotoProducto04,
			@FotoProducto05,
			@FotoProducto06,
			@FotoProducto07,
			@FotoProducto08,
			@FotoProducto09,
			@FotoProducto10,
			@UsuarioRegistro,
			GETDATE()
		)
		END
GO
USE BelcorpSalvador
GO
ALTER PROCEDURE InsMatrizComercial
	@CodigoSAP varchar(50),
	@DescripcionOriginal varchar(250),
	@Descripcion varchar(250),
	@FotoProducto01 varchar(150),
	@FotoProducto02 varchar(150),
	@FotoProducto03 varchar(150),
	@FotoProducto04 varchar(150),
	@FotoProducto05 varchar(150),
	@FotoProducto06 varchar(150),
	@FotoProducto07 varchar(150),
	@FotoProducto08 varchar(150),
	@FotoProducto09 varchar(150),
	@FotoProducto10 varchar(150),
	@UsuarioRegistro varchar(50)
AS
	IF NOT EXISTS(SELECT IdMatrizComercial FROM dbo.MatrizComercial WHERE CodigoSAP=@CodigoSAP)
	BEGIN
		INSERT INTO MatrizComercial
		(
			CodigoSAP,
			DescripcionOriginal,
			Descripcion,
			FotoProducto01,
			FotoProducto02,
			FotoProducto03,
			FotoProducto04,
			FotoProducto05,
			FotoProducto06,
			FotoProducto07,
			FotoProducto08,
			FotoProducto09,
			FotoProducto10,
			UsuarioRegistro,
			FechaRegistro
		)
		VALUES
		(
			@CodigoSAP,
			@DescripcionOriginal,
			@Descripcion,
			@FotoProducto01,
			@FotoProducto02,
			@FotoProducto03,
			@FotoProducto04,
			@FotoProducto05,
			@FotoProducto06,
			@FotoProducto07,
			@FotoProducto08,
			@FotoProducto09,
			@FotoProducto10,
			@UsuarioRegistro,
			GETDATE()
		)
		END
GO
USE BelcorpVenezuela
GO
ALTER PROCEDURE InsMatrizComercial
	@CodigoSAP varchar(50),
	@DescripcionOriginal varchar(250),
	@Descripcion varchar(250),
	@FotoProducto01 varchar(150),
	@FotoProducto02 varchar(150),
	@FotoProducto03 varchar(150),
	@FotoProducto04 varchar(150),
	@FotoProducto05 varchar(150),
	@FotoProducto06 varchar(150),
	@FotoProducto07 varchar(150),
	@FotoProducto08 varchar(150),
	@FotoProducto09 varchar(150),
	@FotoProducto10 varchar(150),
	@UsuarioRegistro varchar(50)
AS
	IF NOT EXISTS(SELECT IdMatrizComercial FROM dbo.MatrizComercial WHERE CodigoSAP=@CodigoSAP)
	BEGIN
		INSERT INTO MatrizComercial
		(
			CodigoSAP,
			DescripcionOriginal,
			Descripcion,
			FotoProducto01,
			FotoProducto02,
			FotoProducto03,
			FotoProducto04,
			FotoProducto05,
			FotoProducto06,
			FotoProducto07,
			FotoProducto08,
			FotoProducto09,
			FotoProducto10,
			UsuarioRegistro,
			FechaRegistro
		)
		VALUES
		(
			@CodigoSAP,
			@DescripcionOriginal,
			@Descripcion,
			@FotoProducto01,
			@FotoProducto02,
			@FotoProducto03,
			@FotoProducto04,
			@FotoProducto05,
			@FotoProducto06,
			@FotoProducto07,
			@FotoProducto08,
			@FotoProducto09,
			@FotoProducto10,
			@UsuarioRegistro,
			GETDATE()
		)
		END
GO
