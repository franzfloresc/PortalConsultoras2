USE BelcorpBolivia
GO

BEGIN
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
BEGIN
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
		);
	END
END
END
GO
/*end*/

USE BelcorpChile
GO

BEGIN
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
BEGIN
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
		);
	END
END
END
GO
/*end*/

USE BelcorpColombia
GO

BEGIN
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
BEGIN
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
		);
	END
END

END
GO
/*end*/

USE BelcorpCostaRica
GO

BEGIN
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
BEGIN
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
		);
	END
END
END
GO
/*end*/

USE BelcorpDominicana
GO

BEGIN
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
BEGIN
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
		);
	END
END

END
GO
/*end*/

USE BelcorpEcuador
GO

BEGIN
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
BEGIN
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
		);
	END
END
END
GO
/*end*/

USE BelcorpGuatemala
GO

BEGIN
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
BEGIN
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
		);
	END
END

END
GO
/*end*/

USE BelcorpMexico
GO

BEGIN
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
BEGIN
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
		);
	END
END

END
GO
/*end*/

USE BelcorpPanama
GO

BEGIN
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
BEGIN
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
		);
	END
END

END
GO
/*end*/

USE BelcorpPeru
GO


BEGIN
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
BEGIN
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
		);
	END
END
	
END
GO
/*end*/

USE BelcorpPuertoRico
GO
BEGIN
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
BEGIN
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
		);
	END
END

END
GO
/*end*/

USE BelcorpSalvador
GO

BEGIN
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
BEGIN
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
		);
	END
END

END
GO
/*end*/

USE BelcorpVenezuela
GO

BEGIN
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
BEGIN
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
		);
	END
END
END

GO




