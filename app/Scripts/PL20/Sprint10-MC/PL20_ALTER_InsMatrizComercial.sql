USE BelcorpBolivia
GO

BEGIN
ALTER PROCEDURE [dbo].[InsMatrizComercial]
	@CodigoSAP varchar(50),
	@DescripcionOriginal varchar(250),
	@Descripcion varchar(250),
	@UsuarioRegistro varchar(50)
AS
BEGIN
	IF NOT EXISTS(SELECT IdMatrizComercial FROM dbo.MatrizComercial WHERE CodigoSAP=@CodigoSAP)
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
END
GO
/*end*/

USE BelcorpChile
GO

BEGIN
ALTER PROCEDURE [dbo].[InsMatrizComercial]
	@CodigoSAP varchar(50),
	@DescripcionOriginal varchar(250),
	@Descripcion varchar(250),
	@UsuarioRegistro varchar(50)
AS
BEGIN
	IF NOT EXISTS(SELECT IdMatrizComercial FROM dbo.MatrizComercial WHERE CodigoSAP=@CodigoSAP)
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
END
GO
/*end*/

USE BelcorpColombia
GO

BEGIN
ALTER PROCEDURE [dbo].[InsMatrizComercial]
	@CodigoSAP varchar(50),
	@DescripcionOriginal varchar(250),
	@Descripcion varchar(250),
	@UsuarioRegistro varchar(50)
AS
BEGIN
	IF NOT EXISTS(SELECT IdMatrizComercial FROM dbo.MatrizComercial WHERE CodigoSAP=@CodigoSAP)
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

END
GO
/*end*/

USE BelcorpCostaRica
GO

BEGIN
ALTER PROCEDURE [dbo].[InsMatrizComercial]
	@CodigoSAP varchar(50),
	@DescripcionOriginal varchar(250),
	@Descripcion varchar(250),
	@UsuarioRegistro varchar(50)
AS
BEGIN
	IF NOT EXISTS(SELECT IdMatrizComercial FROM dbo.MatrizComercial WHERE CodigoSAP=@CodigoSAP)
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
END
GO
/*end*/

USE BelcorpDominicana
GO

BEGIN
ALTER PROCEDURE [dbo].[InsMatrizComercial]
	@CodigoSAP varchar(50),
	@DescripcionOriginal varchar(250),
	@Descripcion varchar(250),
	@UsuarioRegistro varchar(50)
AS
BEGIN
	IF NOT EXISTS(SELECT IdMatrizComercial FROM dbo.MatrizComercial WHERE CodigoSAP=@CodigoSAP)
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

END
GO
/*end*/

USE BelcorpEcuador
GO

BEGIN
ALTER PROCEDURE [dbo].[InsMatrizComercial]
	@CodigoSAP varchar(50),
	@DescripcionOriginal varchar(250),
	@Descripcion varchar(250),
	@UsuarioRegistro varchar(50)
AS
BEGIN
	IF NOT EXISTS(SELECT IdMatrizComercial FROM dbo.MatrizComercial WHERE CodigoSAP=@CodigoSAP)
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
END
GO
/*end*/

USE BelcorpGuatemala
GO

BEGIN
ALTER PROCEDURE [dbo].[InsMatrizComercial]
	@CodigoSAP varchar(50),
	@DescripcionOriginal varchar(250),
	@Descripcion varchar(250),
	@UsuarioRegistro varchar(50)
AS
BEGIN
	IF NOT EXISTS(SELECT IdMatrizComercial FROM dbo.MatrizComercial WHERE CodigoSAP=@CodigoSAP)
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

END
GO
/*end*/

USE BelcorpMexico
GO

BEGIN
ALTER PROCEDURE [dbo].[InsMatrizComercial]
	@CodigoSAP varchar(50),
	@DescripcionOriginal varchar(250),
	@Descripcion varchar(250),
	@UsuarioRegistro varchar(50)
AS
BEGIN
	IF NOT EXISTS(SELECT IdMatrizComercial FROM dbo.MatrizComercial WHERE CodigoSAP=@CodigoSAP)
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

END
GO
/*end*/

USE BelcorpPanama
GO

BEGIN
ALTER PROCEDURE [dbo].[InsMatrizComercial]
	@CodigoSAP varchar(50),
	@DescripcionOriginal varchar(250),
	@Descripcion varchar(250),
	@UsuarioRegistro varchar(50)
AS
BEGIN
	IF NOT EXISTS(SELECT IdMatrizComercial FROM dbo.MatrizComercial WHERE CodigoSAP=@CodigoSAP)
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

END
GO
/*end*/

USE BelcorpPeru
GO


BEGIN
ALTER PROCEDURE [dbo].[InsMatrizComercial]
	@CodigoSAP varchar(50),
	@DescripcionOriginal varchar(250),
	@Descripcion varchar(250),
	@UsuarioRegistro varchar(50)
AS
BEGIN
	IF NOT EXISTS(SELECT IdMatrizComercial FROM dbo.MatrizComercial WHERE CodigoSAP=@CodigoSAP)
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
	
END
GO
/*end*/

USE BelcorpPuertoRico
GO
BEGIN
ALTER PROCEDURE [dbo].[InsMatrizComercial]
	@CodigoSAP varchar(50),
	@DescripcionOriginal varchar(250),
	@Descripcion varchar(250),
	@UsuarioRegistro varchar(50)
AS
BEGIN
	IF NOT EXISTS(SELECT IdMatrizComercial FROM dbo.MatrizComercial WHERE CodigoSAP=@CodigoSAP)
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


END
GO
/*end*/

USE BelcorpSalvador
GO

BEGIN
ALTER PROCEDURE [dbo].[InsMatrizComercial]
	@CodigoSAP varchar(50),
	@DescripcionOriginal varchar(250),
	@Descripcion varchar(250),
	@UsuarioRegistro varchar(50)
AS
BEGIN
	IF NOT EXISTS(SELECT IdMatrizComercial FROM dbo.MatrizComercial WHERE CodigoSAP=@CodigoSAP)
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

END
GO
/*end*/

USE BelcorpVenezuela
GO

BEGIN
ALTER PROCEDURE [dbo].[InsMatrizComercial]
	@CodigoSAP varchar(50),
	@DescripcionOriginal varchar(250),
	@Descripcion varchar(250),
	@UsuarioRegistro varchar(50)
AS
BEGIN
	IF NOT EXISTS(SELECT IdMatrizComercial FROM dbo.MatrizComercial WHERE CodigoSAP=@CodigoSAP)
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
END

GO




