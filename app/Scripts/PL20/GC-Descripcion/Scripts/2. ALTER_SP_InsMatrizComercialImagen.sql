USE BelcorpBolivia
GO

ALTER PROCEDURE [dbo].[InsMatrizComercialImagen]
	@IdMatrizComercial varchar(50),
	@Foto varchar(150),
	@UsuarioRegistro varchar(50),
	@NemoTecnico varchar(100),
	@DescripcionComercial varchar(800)
AS
BEGIN
		INSERT INTO MatrizComercialImagen
		(
			IdMatrizComercial,
			Foto,
			UsuarioRegistro,
			FechaRegistro,
			NemoTecnico,
			DescripcionComercial
		)
		VALUES
		(
			@IdMatrizComercial,
			@Foto,
			@UsuarioRegistro,
			GETDATE(),
			@NemoTecnico,
			@DescripcionComercial
		);
		
		SELECT SCOPE_IDENTITY();
END
GO

USE BelcorpChile
GO

ALTER PROCEDURE [dbo].[InsMatrizComercialImagen]
	@IdMatrizComercial varchar(50),
	@Foto varchar(150),
	@UsuarioRegistro varchar(50),
	@NemoTecnico varchar(100),
	@DescripcionComercial varchar(800)
AS
BEGIN
		INSERT INTO MatrizComercialImagen
		(
			IdMatrizComercial,
			Foto,
			UsuarioRegistro,
			FechaRegistro,
			NemoTecnico,
			DescripcionComercial
		)
		VALUES
		(
			@IdMatrizComercial,
			@Foto,
			@UsuarioRegistro,
			GETDATE(),
			@NemoTecnico,
			@DescripcionComercial
		);
		
		SELECT SCOPE_IDENTITY();
END
GO

USE BelcorpColombia
GO

ALTER PROCEDURE [dbo].[InsMatrizComercialImagen]
	@IdMatrizComercial varchar(50),
	@Foto varchar(150),
	@UsuarioRegistro varchar(50),
	@NemoTecnico varchar(100),
	@DescripcionComercial varchar(800)
AS
BEGIN
		INSERT INTO MatrizComercialImagen
		(
			IdMatrizComercial,
			Foto,
			UsuarioRegistro,
			FechaRegistro,
			NemoTecnico,
			DescripcionComercial
		)
		VALUES
		(
			@IdMatrizComercial,
			@Foto,
			@UsuarioRegistro,
			GETDATE(),
			@NemoTecnico,
			@DescripcionComercial
		);
		
		SELECT SCOPE_IDENTITY();
END
GO

USE BelcorpCostaRica
GO

ALTER PROCEDURE [dbo].[InsMatrizComercialImagen]
	@IdMatrizComercial varchar(50),
	@Foto varchar(150),
	@UsuarioRegistro varchar(50),
	@NemoTecnico varchar(100),
	@DescripcionComercial varchar(800)
AS
BEGIN
		INSERT INTO MatrizComercialImagen
		(
			IdMatrizComercial,
			Foto,
			UsuarioRegistro,
			FechaRegistro,
			NemoTecnico,
			DescripcionComercial
		)
		VALUES
		(
			@IdMatrizComercial,
			@Foto,
			@UsuarioRegistro,
			GETDATE(),
			@NemoTecnico,
			@DescripcionComercial
		);
		
		SELECT SCOPE_IDENTITY();
END
GO

USE BelcorpDominicana
GO

ALTER PROCEDURE [dbo].[InsMatrizComercialImagen]
	@IdMatrizComercial varchar(50),
	@Foto varchar(150),
	@UsuarioRegistro varchar(50),
	@NemoTecnico varchar(100),
	@DescripcionComercial varchar(800)
AS
BEGIN
		INSERT INTO MatrizComercialImagen
		(
			IdMatrizComercial,
			Foto,
			UsuarioRegistro,
			FechaRegistro,
			NemoTecnico,
			DescripcionComercial
		)
		VALUES
		(
			@IdMatrizComercial,
			@Foto,
			@UsuarioRegistro,
			GETDATE(),
			@NemoTecnico,
			@DescripcionComercial
		);
		
		SELECT SCOPE_IDENTITY();
END
GO

USE BelcorpEcuador
GO

ALTER PROCEDURE [dbo].[InsMatrizComercialImagen]
	@IdMatrizComercial varchar(50),
	@Foto varchar(150),
	@UsuarioRegistro varchar(50),
	@NemoTecnico varchar(100),
	@DescripcionComercial varchar(800)
AS
BEGIN
		INSERT INTO MatrizComercialImagen
		(
			IdMatrizComercial,
			Foto,
			UsuarioRegistro,
			FechaRegistro,
			NemoTecnico,
			DescripcionComercial
		)
		VALUES
		(
			@IdMatrizComercial,
			@Foto,
			@UsuarioRegistro,
			GETDATE(),
			@NemoTecnico,
			@DescripcionComercial
		);
		
		SELECT SCOPE_IDENTITY();
END
GO

USE BelcorpGuatemala
GO

ALTER PROCEDURE [dbo].[InsMatrizComercialImagen]
	@IdMatrizComercial varchar(50),
	@Foto varchar(150),
	@UsuarioRegistro varchar(50),
	@NemoTecnico varchar(100),
	@DescripcionComercial varchar(800)
AS
BEGIN
		INSERT INTO MatrizComercialImagen
		(
			IdMatrizComercial,
			Foto,
			UsuarioRegistro,
			FechaRegistro,
			NemoTecnico,
			DescripcionComercial
		)
		VALUES
		(
			@IdMatrizComercial,
			@Foto,
			@UsuarioRegistro,
			GETDATE(),
			@NemoTecnico,
			@DescripcionComercial
		);
		
		SELECT SCOPE_IDENTITY();
END
GO

USE BelcorpMexico
GO

ALTER PROCEDURE [dbo].[InsMatrizComercialImagen]
	@IdMatrizComercial varchar(50),
	@Foto varchar(150),
	@UsuarioRegistro varchar(50),
	@NemoTecnico varchar(100),
	@DescripcionComercial varchar(800)
AS
BEGIN
		INSERT INTO MatrizComercialImagen
		(
			IdMatrizComercial,
			Foto,
			UsuarioRegistro,
			FechaRegistro,
			NemoTecnico,
			DescripcionComercial
		)
		VALUES
		(
			@IdMatrizComercial,
			@Foto,
			@UsuarioRegistro,
			GETDATE(),
			@NemoTecnico,
			@DescripcionComercial
		);
		
		SELECT SCOPE_IDENTITY();
END
GO

USE BelcorpPanama
GO

ALTER PROCEDURE [dbo].[InsMatrizComercialImagen]
	@IdMatrizComercial varchar(50),
	@Foto varchar(150),
	@UsuarioRegistro varchar(50),
	@NemoTecnico varchar(100),
	@DescripcionComercial varchar(800)
AS
BEGIN
		INSERT INTO MatrizComercialImagen
		(
			IdMatrizComercial,
			Foto,
			UsuarioRegistro,
			FechaRegistro,
			NemoTecnico,
			DescripcionComercial
		)
		VALUES
		(
			@IdMatrizComercial,
			@Foto,
			@UsuarioRegistro,
			GETDATE(),
			@NemoTecnico,
			@DescripcionComercial
		);
		
		SELECT SCOPE_IDENTITY();
END
GO

USE BelcorpPeru
GO

ALTER PROCEDURE [dbo].[InsMatrizComercialImagen]
	@IdMatrizComercial varchar(50),
	@Foto varchar(150),
	@UsuarioRegistro varchar(50),
	@NemoTecnico varchar(100),
	@DescripcionComercial varchar(800)
AS
BEGIN
		INSERT INTO MatrizComercialImagen
		(
			IdMatrizComercial,
			Foto,
			UsuarioRegistro,
			FechaRegistro,
			NemoTecnico,
			DescripcionComercial
		)
		VALUES
		(
			@IdMatrizComercial,
			@Foto,
			@UsuarioRegistro,
			GETDATE(),
			@NemoTecnico,
			@DescripcionComercial
		);
		
		SELECT SCOPE_IDENTITY();
END
GO

USE BelcorpPuertoRico
GO

ALTER PROCEDURE [dbo].[InsMatrizComercialImagen]
	@IdMatrizComercial varchar(50),
	@Foto varchar(150),
	@UsuarioRegistro varchar(50),
	@NemoTecnico varchar(100),
	@DescripcionComercial varchar(800)
AS
BEGIN
		INSERT INTO MatrizComercialImagen
		(
			IdMatrizComercial,
			Foto,
			UsuarioRegistro,
			FechaRegistro,
			NemoTecnico,
			DescripcionComercial
		)
		VALUES
		(
			@IdMatrizComercial,
			@Foto,
			@UsuarioRegistro,
			GETDATE(),
			@NemoTecnico,
			@DescripcionComercial
		);
		
		SELECT SCOPE_IDENTITY();
END
GO

USE BelcorpSalvador
GO

ALTER PROCEDURE [dbo].[InsMatrizComercialImagen]
	@IdMatrizComercial varchar(50),
	@Foto varchar(150),
	@UsuarioRegistro varchar(50),
	@NemoTecnico varchar(100),
	@DescripcionComercial varchar(800)
AS
BEGIN
		INSERT INTO MatrizComercialImagen
		(
			IdMatrizComercial,
			Foto,
			UsuarioRegistro,
			FechaRegistro,
			NemoTecnico,
			DescripcionComercial
		)
		VALUES
		(
			@IdMatrizComercial,
			@Foto,
			@UsuarioRegistro,
			GETDATE(),
			@NemoTecnico,
			@DescripcionComercial
		);
		
		SELECT SCOPE_IDENTITY();
END
GO

USE BelcorpVenezuela
GO

ALTER PROCEDURE [dbo].[InsMatrizComercialImagen]
	@IdMatrizComercial varchar(50),
	@Foto varchar(150),
	@UsuarioRegistro varchar(50),
	@NemoTecnico varchar(100),
	@DescripcionComercial varchar(800)
AS
BEGIN
		INSERT INTO MatrizComercialImagen
		(
			IdMatrizComercial,
			Foto,
			UsuarioRegistro,
			FechaRegistro,
			NemoTecnico,
			DescripcionComercial
		)
		VALUES
		(
			@IdMatrizComercial,
			@Foto,
			@UsuarioRegistro,
			GETDATE(),
			@NemoTecnico,
			@DescripcionComercial
		);
		
		SELECT SCOPE_IDENTITY();
END
GO
