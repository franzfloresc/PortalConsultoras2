USE BelcorpBolivia
GO
ALTER PROCEDURE [dbo].[InsMatrizComercial]
	@CodigoSAP varchar(50),
	@DescripcionOriginal varchar(250),
	@Descripcion varchar(250),
	@UsuarioRegistro varchar(50)
AS
	IF NOT EXISTS(SELECT IdMatrizComercial FROM dbo.MatrizComercial WHERE CodigoSAP=@CodigoSAP)
	BEGIN
		INSERT INTO MatrizComercial
		(
			CodigoSAP,
			DescripcionOriginal,
			Descripcion,
			UsuarioRegistro,
			FechaRegistro
		)
		VALUES
		(
			@CodigoSAP,
			@DescripcionOriginal,
			@Descripcion,
			@UsuarioRegistro,
			GETDATE()
		);

		SELECT SCOPE_IDENTITY();
	END
GO
USE BelcorpCostaRica
GO
ALTER PROCEDURE [dbo].[InsMatrizComercial]
	@CodigoSAP varchar(50),
	@DescripcionOriginal varchar(250),
	@Descripcion varchar(250),
	@UsuarioRegistro varchar(50)
AS
	IF NOT EXISTS(SELECT IdMatrizComercial FROM dbo.MatrizComercial WHERE CodigoSAP=@CodigoSAP)
	BEGIN
		INSERT INTO MatrizComercial
		(
			CodigoSAP,
			DescripcionOriginal,
			Descripcion,
			UsuarioRegistro,
			FechaRegistro
		)
		VALUES
		(
			@CodigoSAP,
			@DescripcionOriginal,
			@Descripcion,
			@UsuarioRegistro,
			GETDATE()
		);

		SELECT SCOPE_IDENTITY();
	END
GO
USE BelcorpChile
GO
ALTER PROCEDURE [dbo].[InsMatrizComercial]
	@CodigoSAP varchar(50),
	@DescripcionOriginal varchar(250),
	@Descripcion varchar(250),
	@UsuarioRegistro varchar(50)
AS
	IF NOT EXISTS(SELECT IdMatrizComercial FROM dbo.MatrizComercial WHERE CodigoSAP=@CodigoSAP)
	BEGIN
		INSERT INTO MatrizComercial
		(
			CodigoSAP,
			DescripcionOriginal,
			Descripcion,
			UsuarioRegistro,
			FechaRegistro
		)
		VALUES
		(
			@CodigoSAP,
			@DescripcionOriginal,
			@Descripcion,
			@UsuarioRegistro,
			GETDATE()
		);

		SELECT SCOPE_IDENTITY();
	END
GO
USE BelcorpColombia
GO
ALTER PROCEDURE [dbo].[InsMatrizComercial]
	@CodigoSAP varchar(50),
	@DescripcionOriginal varchar(250),
	@Descripcion varchar(250),
	@UsuarioRegistro varchar(50)
AS
	IF NOT EXISTS(SELECT IdMatrizComercial FROM dbo.MatrizComercial WHERE CodigoSAP=@CodigoSAP)
	BEGIN
		INSERT INTO MatrizComercial
		(
			CodigoSAP,
			DescripcionOriginal,
			Descripcion,
			UsuarioRegistro,
			FechaRegistro
		)
		VALUES
		(
			@CodigoSAP,
			@DescripcionOriginal,
			@Descripcion,
			@UsuarioRegistro,
			GETDATE()
		);

		SELECT SCOPE_IDENTITY();
	END
GO
USE BelcorpDominicana
GO
ALTER PROCEDURE [dbo].[InsMatrizComercial]
	@CodigoSAP varchar(50),
	@DescripcionOriginal varchar(250),
	@Descripcion varchar(250),
	@UsuarioRegistro varchar(50)
AS
	IF NOT EXISTS(SELECT IdMatrizComercial FROM dbo.MatrizComercial WHERE CodigoSAP=@CodigoSAP)
	BEGIN
		INSERT INTO MatrizComercial
		(
			CodigoSAP,
			DescripcionOriginal,
			Descripcion,
			UsuarioRegistro,
			FechaRegistro
		)
		VALUES
		(
			@CodigoSAP,
			@DescripcionOriginal,
			@Descripcion,
			@UsuarioRegistro,
			GETDATE()
		);

		SELECT SCOPE_IDENTITY();
	END
GO
USE BelcorpEcuador
GO
ALTER PROCEDURE [dbo].[InsMatrizComercial]
	@CodigoSAP varchar(50),
	@DescripcionOriginal varchar(250),
	@Descripcion varchar(250),
	@UsuarioRegistro varchar(50)
AS
	IF NOT EXISTS(SELECT IdMatrizComercial FROM dbo.MatrizComercial WHERE CodigoSAP=@CodigoSAP)
	BEGIN
		INSERT INTO MatrizComercial
		(
			CodigoSAP,
			DescripcionOriginal,
			Descripcion,
			UsuarioRegistro,
			FechaRegistro
		)
		VALUES
		(
			@CodigoSAP,
			@DescripcionOriginal,
			@Descripcion,
			@UsuarioRegistro,
			GETDATE()
		);

		SELECT SCOPE_IDENTITY();
	END
GO
USE BelcorpGuatemala
GO
ALTER PROCEDURE [dbo].[InsMatrizComercial]
	@CodigoSAP varchar(50),
	@DescripcionOriginal varchar(250),
	@Descripcion varchar(250),
	@UsuarioRegistro varchar(50)
AS
	IF NOT EXISTS(SELECT IdMatrizComercial FROM dbo.MatrizComercial WHERE CodigoSAP=@CodigoSAP)
	BEGIN
		INSERT INTO MatrizComercial
		(
			CodigoSAP,
			DescripcionOriginal,
			Descripcion,
			UsuarioRegistro,
			FechaRegistro
		)
		VALUES
		(
			@CodigoSAP,
			@DescripcionOriginal,
			@Descripcion,
			@UsuarioRegistro,
			GETDATE()
		);

		SELECT SCOPE_IDENTITY();
	END
GO
USE BelcorpMexico
GO
ALTER PROCEDURE [dbo].[InsMatrizComercial]
	@CodigoSAP varchar(50),
	@DescripcionOriginal varchar(250),
	@Descripcion varchar(250),
	@UsuarioRegistro varchar(50)
AS
	IF NOT EXISTS(SELECT IdMatrizComercial FROM dbo.MatrizComercial WHERE CodigoSAP=@CodigoSAP)
	BEGIN
		INSERT INTO MatrizComercial
		(
			CodigoSAP,
			DescripcionOriginal,
			Descripcion,
			UsuarioRegistro,
			FechaRegistro
		)
		VALUES
		(
			@CodigoSAP,
			@DescripcionOriginal,
			@Descripcion,
			@UsuarioRegistro,
			GETDATE()
		);

		SELECT SCOPE_IDENTITY();
	END
GO
USE BelcorpPanama
GO
ALTER PROCEDURE [dbo].[InsMatrizComercial]
	@CodigoSAP varchar(50),
	@DescripcionOriginal varchar(250),
	@Descripcion varchar(250),
	@UsuarioRegistro varchar(50)
AS
	IF NOT EXISTS(SELECT IdMatrizComercial FROM dbo.MatrizComercial WHERE CodigoSAP=@CodigoSAP)
	BEGIN
		INSERT INTO MatrizComercial
		(
			CodigoSAP,
			DescripcionOriginal,
			Descripcion,
			UsuarioRegistro,
			FechaRegistro
		)
		VALUES
		(
			@CodigoSAP,
			@DescripcionOriginal,
			@Descripcion,
			@UsuarioRegistro,
			GETDATE()
		);

		SELECT SCOPE_IDENTITY();
	END
GO
USE BelcorpPeru
GO
ALTER PROCEDURE [dbo].[InsMatrizComercial]
	@CodigoSAP varchar(50),
	@DescripcionOriginal varchar(250),
	@Descripcion varchar(250),
	@UsuarioRegistro varchar(50)
AS
	IF NOT EXISTS(SELECT IdMatrizComercial FROM dbo.MatrizComercial WHERE CodigoSAP=@CodigoSAP)
	BEGIN
		INSERT INTO MatrizComercial
		(
			CodigoSAP,
			DescripcionOriginal,
			Descripcion,
			UsuarioRegistro,
			FechaRegistro
		)
		VALUES
		(
			@CodigoSAP,
			@DescripcionOriginal,
			@Descripcion,
			@UsuarioRegistro,
			GETDATE()
		);

		SELECT SCOPE_IDENTITY();
	END
GO
USE BelcorpPuertoRico
GO
ALTER PROCEDURE [dbo].[InsMatrizComercial]
	@CodigoSAP varchar(50),
	@DescripcionOriginal varchar(250),
	@Descripcion varchar(250),
	@UsuarioRegistro varchar(50)
AS
	IF NOT EXISTS(SELECT IdMatrizComercial FROM dbo.MatrizComercial WHERE CodigoSAP=@CodigoSAP)
	BEGIN
		INSERT INTO MatrizComercial
		(
			CodigoSAP,
			DescripcionOriginal,
			Descripcion,
			UsuarioRegistro,
			FechaRegistro
		)
		VALUES
		(
			@CodigoSAP,
			@DescripcionOriginal,
			@Descripcion,
			@UsuarioRegistro,
			GETDATE()
		);

		SELECT SCOPE_IDENTITY();
	END
GO
USE BelcorpSalvador
GO
ALTER PROCEDURE [dbo].[InsMatrizComercial]
	@CodigoSAP varchar(50),
	@DescripcionOriginal varchar(250),
	@Descripcion varchar(250),
	@UsuarioRegistro varchar(50)
AS
	IF NOT EXISTS(SELECT IdMatrizComercial FROM dbo.MatrizComercial WHERE CodigoSAP=@CodigoSAP)
	BEGIN
		INSERT INTO MatrizComercial
		(
			CodigoSAP,
			DescripcionOriginal,
			Descripcion,
			UsuarioRegistro,
			FechaRegistro
		)
		VALUES
		(
			@CodigoSAP,
			@DescripcionOriginal,
			@Descripcion,
			@UsuarioRegistro,
			GETDATE()
		);

		SELECT SCOPE_IDENTITY();
	END
GO
USE BelcorpVenezuela
GO
ALTER PROCEDURE [dbo].[InsMatrizComercial]
	@CodigoSAP varchar(50),
	@DescripcionOriginal varchar(250),
	@Descripcion varchar(250),
	@UsuarioRegistro varchar(50)
AS
	IF NOT EXISTS(SELECT IdMatrizComercial FROM dbo.MatrizComercial WHERE CodigoSAP=@CodigoSAP)
	BEGIN
		INSERT INTO MatrizComercial
		(
			CodigoSAP,
			DescripcionOriginal,
			Descripcion,
			UsuarioRegistro,
			FechaRegistro
		)
		VALUES
		(
			@CodigoSAP,
			@DescripcionOriginal,
			@Descripcion,
			@UsuarioRegistro,
			GETDATE()
		);

		SELECT SCOPE_IDENTITY();
	END
GO
