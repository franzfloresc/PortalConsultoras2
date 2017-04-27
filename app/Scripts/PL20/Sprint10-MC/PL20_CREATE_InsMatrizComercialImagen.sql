USE BelcorpBolivia
GO

BEGIN
	
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

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

BEGIN
	SET ANSI_NULLS ON
	GO
	SET QUOTED_IDENTIFIER ON
	GO

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

BEGIN
		SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

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

BEGIN
	SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

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

BEGIN
	SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

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

BEGIN
		SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

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

BEGIN
	SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

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

BEGIN
	SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

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

BEGIN
	SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

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


BEGIN
	SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

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

BEGIN
		SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

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


BEGIN
	SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

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

BEGIN
		SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

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


