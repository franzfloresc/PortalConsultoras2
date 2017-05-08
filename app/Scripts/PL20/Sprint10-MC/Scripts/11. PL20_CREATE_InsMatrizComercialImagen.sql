USE BelcorpBolivia
GO

IF OBJECT_ID('InsMatrizComercialImagen', 'P') IS NOT NULL
DROP PROC InsMatrizComercialImagen
GO

BEGIN
	

CREATE PROCEDURE [dbo].[InsMatrizComercialImagen]
	@IdMatrizComercial varchar(50),
	@Foto varchar(150),
	@UsuarioRegistro varchar(50)
AS
BEGIN
	BEGIN
		INSERT INTO MatrizComercialImagen
		(
			IdMatrizComercial,
			Foto,
			UsuarioRegistro,
			FechaRegistro
		)
		VALUES
		(
			@IdMatrizComercial,
			@Foto,
			@UsuarioRegistro,
			GETDATE()
		);
		
		SELECT SCOPE_IDENTITY();
	END
END

END
GO
/*end*/

USE BelcorpChile
GO

IF OBJECT_ID('InsMatrizComercialImagen', 'P') IS NOT NULL
DROP PROC InsMatrizComercialImagen
GO

BEGIN
	

	CREATE PROCEDURE [dbo].[InsMatrizComercialImagen]
		@IdMatrizComercial varchar(50),
		@Foto varchar(150),
		@UsuarioRegistro varchar(50)
	AS
	BEGIN
		BEGIN
			INSERT INTO MatrizComercialImagen
			(
				IdMatrizComercial,
				Foto,
				UsuarioRegistro,
				FechaRegistro
			)
			VALUES
			(
				@IdMatrizComercial,
				@Foto,
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

IF OBJECT_ID('InsMatrizComercialImagen', 'P') IS NOT NULL
DROP PROC InsMatrizComercialImagen
GO

BEGIN
		
CREATE PROCEDURE [dbo].[InsMatrizComercialImagen]
	@IdMatrizComercial varchar(50),
	@Foto varchar(150),
	@UsuarioRegistro varchar(50)
AS
BEGIN
	BEGIN
		INSERT INTO MatrizComercialImagen
		(
			IdMatrizComercial,
			Foto,
			UsuarioRegistro,
			FechaRegistro
		)
		VALUES
		(
			@IdMatrizComercial,
			@Foto,
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

IF OBJECT_ID('InsMatrizComercialImagen', 'P') IS NOT NULL
DROP PROC InsMatrizComercialImagen
GO

BEGIN
	
CREATE PROCEDURE [dbo].[InsMatrizComercialImagen]
	@IdMatrizComercial varchar(50),
	@Foto varchar(150),
	@UsuarioRegistro varchar(50)
AS
BEGIN
	BEGIN
		INSERT INTO MatrizComercialImagen
		(
			IdMatrizComercial,
			Foto,
			UsuarioRegistro,
			FechaRegistro
		)
		VALUES
		(
			@IdMatrizComercial,
			@Foto,
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

IF OBJECT_ID('InsMatrizComercialImagen', 'P') IS NOT NULL
DROP PROC InsMatrizComercialImagen
GO

BEGIN
	
CREATE PROCEDURE [dbo].[InsMatrizComercialImagen]
	@IdMatrizComercial varchar(50),
	@Foto varchar(150),
	@UsuarioRegistro varchar(50)
AS
BEGIN
	BEGIN
		INSERT INTO MatrizComercialImagen
		(
			IdMatrizComercial,
			Foto,
			UsuarioRegistro,
			FechaRegistro
		)
		VALUES
		(
			@IdMatrizComercial,
			@Foto,
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

IF OBJECT_ID('InsMatrizComercialImagen', 'P') IS NOT NULL
DROP PROC InsMatrizComercialImagen
GO

BEGIN
		
CREATE PROCEDURE [dbo].[InsMatrizComercialImagen]
	@IdMatrizComercial varchar(50),
	@Foto varchar(150),
	@UsuarioRegistro varchar(50)
AS
BEGIN
	BEGIN
		INSERT INTO MatrizComercialImagen
		(
			IdMatrizComercial,
			Foto,
			UsuarioRegistro,
			FechaRegistro
		)
		VALUES
		(
			@IdMatrizComercial,
			@Foto,
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

IF OBJECT_ID('InsMatrizComercialImagen', 'P') IS NOT NULL
DROP PROC InsMatrizComercialImagen
GO

BEGIN
	
CREATE PROCEDURE [dbo].[InsMatrizComercialImagen]
	@IdMatrizComercial varchar(50),
	@Foto varchar(150),
	@UsuarioRegistro varchar(50)
AS
BEGIN
	BEGIN
		INSERT INTO MatrizComercialImagen
		(
			IdMatrizComercial,
			Foto,
			UsuarioRegistro,
			FechaRegistro
		)
		VALUES
		(
			@IdMatrizComercial,
			@Foto,
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

IF OBJECT_ID('InsMatrizComercialImagen', 'P') IS NOT NULL
DROP PROC InsMatrizComercialImagen
GO

BEGIN
	
CREATE PROCEDURE [dbo].[InsMatrizComercialImagen]
	@IdMatrizComercial varchar(50),
	@Foto varchar(150),
	@UsuarioRegistro varchar(50)
AS
BEGIN
	BEGIN
		INSERT INTO MatrizComercialImagen
		(
			IdMatrizComercial,
			Foto,
			UsuarioRegistro,
			FechaRegistro
		)
		VALUES
		(
			@IdMatrizComercial,
			@Foto,
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

IF OBJECT_ID('InsMatrizComercialImagen', 'P') IS NOT NULL
DROP PROC InsMatrizComercialImagen
GO

BEGIN
	
CREATE PROCEDURE [dbo].[InsMatrizComercialImagen]
	@IdMatrizComercial varchar(50),
	@Foto varchar(150),
	@UsuarioRegistro varchar(50)
AS
BEGIN
	BEGIN
		INSERT INTO MatrizComercialImagen
		(
			IdMatrizComercial,
			Foto,
			UsuarioRegistro,
			FechaRegistro
		)
		VALUES
		(
			@IdMatrizComercial,
			@Foto,
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

IF OBJECT_ID('InsMatrizComercialImagen', 'P') IS NOT NULL
DROP PROC InsMatrizComercialImagen
GO

BEGIN
	
CREATE PROCEDURE [dbo].[InsMatrizComercialImagen]
	@IdMatrizComercial varchar(50),
	@Foto varchar(150),
	@UsuarioRegistro varchar(50)
AS
BEGIN
	BEGIN
		INSERT INTO MatrizComercialImagen
		(
			IdMatrizComercial,
			Foto,
			UsuarioRegistro,
			FechaRegistro
		)
		VALUES
		(
			@IdMatrizComercial,
			@Foto,
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

IF OBJECT_ID('InsMatrizComercialImagen', 'P') IS NOT NULL
DROP PROC InsMatrizComercialImagen
GO

BEGIN
		
CREATE PROCEDURE [dbo].[InsMatrizComercialImagen]
	@IdMatrizComercial varchar(50),
	@Foto varchar(150),
	@UsuarioRegistro varchar(50)
AS
BEGIN
	BEGIN
		INSERT INTO MatrizComercialImagen
		(
			IdMatrizComercial,
			Foto,
			UsuarioRegistro,
			FechaRegistro
		)
		VALUES
		(
			@IdMatrizComercial,
			@Foto,
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

IF OBJECT_ID('InsMatrizComercialImagen', 'P') IS NOT NULL
DROP PROC InsMatrizComercialImagen
GO

BEGIN
	
CREATE PROCEDURE [dbo].[InsMatrizComercialImagen]
	@IdMatrizComercial varchar(50),
	@Foto varchar(150),
	@UsuarioRegistro varchar(50)
AS
BEGIN
	BEGIN
		INSERT INTO MatrizComercialImagen
		(
			IdMatrizComercial,
			Foto,
			UsuarioRegistro,
			FechaRegistro
		)
		VALUES
		(
			@IdMatrizComercial,
			@Foto,
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

IF OBJECT_ID('InsMatrizComercialImagen', 'P') IS NOT NULL
DROP PROC InsMatrizComercialImagen
GO

BEGIN
		
CREATE PROCEDURE [dbo].[InsMatrizComercialImagen]
	@IdMatrizComercial int,
	@Foto varchar(150),
	@UsuarioRegistro varchar(50)
AS
BEGIN
	BEGIN
		INSERT INTO MatrizComercialImagen
		(
			IdMatrizComercial,
			Foto,
			UsuarioRegistro,
			FechaRegistro
		)
		VALUES
		(
			@IdMatrizComercial,
			@Foto,
			@UsuarioRegistro,
			GETDATE()
		);
	END
END

END
GO


