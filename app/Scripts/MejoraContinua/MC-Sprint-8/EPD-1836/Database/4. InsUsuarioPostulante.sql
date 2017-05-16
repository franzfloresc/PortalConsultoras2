USE BelcorpBolivia
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.InsUsuarioPostulante'))
BEGIN
    DROP PROCEDURE dbo.InsUsuarioPostulante
END
GO

CREATE PROCEDURE [dbo].[InsUsuarioPostulante]
(
	@CodigoUsuario VARCHAR(20),
	@Zona VARCHAR(4),
	@Seccion CHAR(1),
	@EnvioCorreo CHAR(1),
	@UsuarioReal CHAR(1)
)
AS
BEGIN

	IF EXISTS(SELECT 1 FROM UsuarioPostulante WHERE CodigoUsuario = @CodigoUsuario AND Estado = 0)
	BEGIN
		UPDATE UsuarioPostulante
		SET Estado = 1
		WHERE CodigoUsuario = @CodigoUsuario
		AND Estado = 0

		SELECT 1
	END
	ELSE
	BEGIN
		INSERT INTO UsuarioPostulante
		(
			CodigoUsuario,
			Zona,
			Seccion,
			EnvioCorreo,
			UsuarioReal,
			FechaRegistro,
			Estado
		)
		VALUES 
		(
			@CodigoUsuario,
			@Zona,
			@Seccion,
			'0',
			'0',
			GETDATE(),
			1
		)

		SELECT SCOPE_IDENTITY()
	END
END
GO

/*end*/

USE BelcorpChile
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.InsUsuarioPostulante'))
BEGIN
    DROP PROCEDURE dbo.InsUsuarioPostulante
END
GO

CREATE PROCEDURE [dbo].[InsUsuarioPostulante]
(
	@CodigoUsuario VARCHAR(20),
	@Zona VARCHAR(4),
	@Seccion CHAR(1),
	@EnvioCorreo CHAR(1),
	@UsuarioReal CHAR(1)
)
AS
BEGIN

	IF EXISTS(SELECT 1 FROM UsuarioPostulante WHERE CodigoUsuario = @CodigoUsuario AND Estado = 0)
	BEGIN
		UPDATE UsuarioPostulante
		SET Estado = 1
		WHERE CodigoUsuario = @CodigoUsuario
		AND Estado = 0

		SELECT 1
	END
	ELSE
	BEGIN
		INSERT INTO UsuarioPostulante
		(
			CodigoUsuario,
			Zona,
			Seccion,
			EnvioCorreo,
			UsuarioReal,
			FechaRegistro,
			Estado
		)
		VALUES 
		(
			@CodigoUsuario,
			@Zona,
			@Seccion,
			'0',
			'0',
			GETDATE(),
			1
		)

		SELECT SCOPE_IDENTITY()
	END
END
GO
/*end*/

USE BelcorpColombia
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.InsUsuarioPostulante'))
BEGIN
    DROP PROCEDURE dbo.InsUsuarioPostulante
END
GO

CREATE PROCEDURE [dbo].[InsUsuarioPostulante]
(
	@CodigoUsuario VARCHAR(20),
	@Zona VARCHAR(4),
	@Seccion CHAR(1),
	@EnvioCorreo CHAR(1),
	@UsuarioReal CHAR(1)
)
AS
BEGIN

	IF EXISTS(SELECT 1 FROM UsuarioPostulante WHERE CodigoUsuario = @CodigoUsuario AND Estado = 0)
	BEGIN
		UPDATE UsuarioPostulante
		SET Estado = 1
		WHERE CodigoUsuario = @CodigoUsuario
		AND Estado = 0

		SELECT 1
	END
	ELSE
	BEGIN
		INSERT INTO UsuarioPostulante
		(
			CodigoUsuario,
			Zona,
			Seccion,
			EnvioCorreo,
			UsuarioReal,
			FechaRegistro,
			Estado
		)
		VALUES 
		(
			@CodigoUsuario,
			@Zona,
			@Seccion,
			'0',
			'0',
			GETDATE(),
			1
		)

		SELECT SCOPE_IDENTITY()
	END
END
GO
/*end*/

USE BelcorpCostaRica
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.InsUsuarioPostulante'))
BEGIN
    DROP PROCEDURE dbo.InsUsuarioPostulante
END
GO

CREATE PROCEDURE [dbo].[InsUsuarioPostulante]
(
	@CodigoUsuario VARCHAR(20),
	@Zona VARCHAR(4),
	@Seccion CHAR(1),
	@EnvioCorreo CHAR(1),
	@UsuarioReal CHAR(1)
)
AS
BEGIN

	IF EXISTS(SELECT 1 FROM UsuarioPostulante WHERE CodigoUsuario = @CodigoUsuario AND Estado = 0)
	BEGIN
		UPDATE UsuarioPostulante
		SET Estado = 1
		WHERE CodigoUsuario = @CodigoUsuario
		AND Estado = 0

		SELECT 1
	END
	ELSE
	BEGIN
		INSERT INTO UsuarioPostulante
		(
			CodigoUsuario,
			Zona,
			Seccion,
			EnvioCorreo,
			UsuarioReal,
			FechaRegistro,
			Estado
		)
		VALUES 
		(
			@CodigoUsuario,
			@Zona,
			@Seccion,
			'0',
			'0',
			GETDATE(),
			1
		)

		SELECT SCOPE_IDENTITY()
	END
END
GO
/*end*/

USE BelcorpDominicana
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.InsUsuarioPostulante'))
BEGIN
    DROP PROCEDURE dbo.InsUsuarioPostulante
END
GO

CREATE PROCEDURE [dbo].[InsUsuarioPostulante]
(
	@CodigoUsuario VARCHAR(20),
	@Zona VARCHAR(4),
	@Seccion CHAR(1),
	@EnvioCorreo CHAR(1),
	@UsuarioReal CHAR(1)
)
AS
BEGIN

	IF EXISTS(SELECT 1 FROM UsuarioPostulante WHERE CodigoUsuario = @CodigoUsuario AND Estado = 0)
	BEGIN
		UPDATE UsuarioPostulante
		SET Estado = 1
		WHERE CodigoUsuario = @CodigoUsuario
		AND Estado = 0

		SELECT 1
	END
	ELSE
	BEGIN
		INSERT INTO UsuarioPostulante
		(
			CodigoUsuario,
			Zona,
			Seccion,
			EnvioCorreo,
			UsuarioReal,
			FechaRegistro,
			Estado
		)
		VALUES 
		(
			@CodigoUsuario,
			@Zona,
			@Seccion,
			'0',
			'0',
			GETDATE(),
			1
		)

		SELECT SCOPE_IDENTITY()
	END
END
GO
/*end*/

USE BelcorpEcuador
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.InsUsuarioPostulante'))
BEGIN
    DROP PROCEDURE dbo.InsUsuarioPostulante
END
GO

CREATE PROCEDURE [dbo].[InsUsuarioPostulante]
(
	@CodigoUsuario VARCHAR(20),
	@Zona VARCHAR(4),
	@Seccion CHAR(1),
	@EnvioCorreo CHAR(1),
	@UsuarioReal CHAR(1)
)
AS
BEGIN

	IF EXISTS(SELECT 1 FROM UsuarioPostulante WHERE CodigoUsuario = @CodigoUsuario AND Estado = 0)
	BEGIN
		UPDATE UsuarioPostulante
		SET Estado = 1
		WHERE CodigoUsuario = @CodigoUsuario
		AND Estado = 0

		SELECT 1
	END
	ELSE
	BEGIN
		INSERT INTO UsuarioPostulante
		(
			CodigoUsuario,
			Zona,
			Seccion,
			EnvioCorreo,
			UsuarioReal,
			FechaRegistro,
			Estado
		)
		VALUES 
		(
			@CodigoUsuario,
			@Zona,
			@Seccion,
			'0',
			'0',
			GETDATE(),
			1
		)

		SELECT SCOPE_IDENTITY()
	END
END
GO
/*end*/

USE BelcorpGuatemala
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.InsUsuarioPostulante'))
BEGIN
    DROP PROCEDURE dbo.InsUsuarioPostulante
END
GO

CREATE PROCEDURE [dbo].[InsUsuarioPostulante]
(
	@CodigoUsuario VARCHAR(20),
	@Zona VARCHAR(4),
	@Seccion CHAR(1),
	@EnvioCorreo CHAR(1),
	@UsuarioReal CHAR(1)
)
AS
BEGIN

	IF EXISTS(SELECT 1 FROM UsuarioPostulante WHERE CodigoUsuario = @CodigoUsuario AND Estado = 0)
	BEGIN
		UPDATE UsuarioPostulante
		SET Estado = 1
		WHERE CodigoUsuario = @CodigoUsuario
		AND Estado = 0

		SELECT 1
	END
	ELSE
	BEGIN
		INSERT INTO UsuarioPostulante
		(
			CodigoUsuario,
			Zona,
			Seccion,
			EnvioCorreo,
			UsuarioReal,
			FechaRegistro,
			Estado
		)
		VALUES 
		(
			@CodigoUsuario,
			@Zona,
			@Seccion,
			'0',
			'0',
			GETDATE(),
			1
		)

		SELECT SCOPE_IDENTITY()
	END
END
GO
/*end*/

USE BelcorpMexico
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.InsUsuarioPostulante'))
BEGIN
    DROP PROCEDURE dbo.InsUsuarioPostulante
END
GO

CREATE PROCEDURE [dbo].[InsUsuarioPostulante]
(
	@CodigoUsuario VARCHAR(20),
	@Zona VARCHAR(4),
	@Seccion CHAR(1),
	@EnvioCorreo CHAR(1),
	@UsuarioReal CHAR(1)
)
AS
BEGIN

	IF EXISTS(SELECT 1 FROM UsuarioPostulante WHERE CodigoUsuario = @CodigoUsuario AND Estado = 0)
	BEGIN
		UPDATE UsuarioPostulante
		SET Estado = 1
		WHERE CodigoUsuario = @CodigoUsuario
		AND Estado = 0

		SELECT 1
	END
	ELSE
	BEGIN
		INSERT INTO UsuarioPostulante
		(
			CodigoUsuario,
			Zona,
			Seccion,
			EnvioCorreo,
			UsuarioReal,
			FechaRegistro,
			Estado
		)
		VALUES 
		(
			@CodigoUsuario,
			@Zona,
			@Seccion,
			'0',
			'0',
			GETDATE(),
			1
		)

		SELECT SCOPE_IDENTITY()
	END
END
GO
/*end*/

USE BelcorpPanama
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.InsUsuarioPostulante'))
BEGIN
    DROP PROCEDURE dbo.InsUsuarioPostulante
END
GO

CREATE PROCEDURE [dbo].[InsUsuarioPostulante]
(
	@CodigoUsuario VARCHAR(20),
	@Zona VARCHAR(4),
	@Seccion CHAR(1),
	@EnvioCorreo CHAR(1),
	@UsuarioReal CHAR(1)
)
AS
BEGIN

	IF EXISTS(SELECT 1 FROM UsuarioPostulante WHERE CodigoUsuario = @CodigoUsuario AND Estado = 0)
	BEGIN
		UPDATE UsuarioPostulante
		SET Estado = 1
		WHERE CodigoUsuario = @CodigoUsuario
		AND Estado = 0

		SELECT 1
	END
	ELSE
	BEGIN
		INSERT INTO UsuarioPostulante
		(
			CodigoUsuario,
			Zona,
			Seccion,
			EnvioCorreo,
			UsuarioReal,
			FechaRegistro,
			Estado
		)
		VALUES 
		(
			@CodigoUsuario,
			@Zona,
			@Seccion,
			'0',
			'0',
			GETDATE(),
			1
		)

		SELECT SCOPE_IDENTITY()
	END
END
GO
/*end*/

USE BelcorpPeru
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.InsUsuarioPostulante'))
BEGIN
    DROP PROCEDURE dbo.InsUsuarioPostulante
END
GO

CREATE PROCEDURE [dbo].[InsUsuarioPostulante]
(
	@CodigoUsuario VARCHAR(20),
	@Zona VARCHAR(4),
	@Seccion CHAR(1),
	@EnvioCorreo CHAR(1),
	@UsuarioReal CHAR(1)
)
AS
BEGIN

	IF EXISTS(SELECT 1 FROM UsuarioPostulante WHERE CodigoUsuario = @CodigoUsuario AND Estado = 0)
	BEGIN
		UPDATE UsuarioPostulante
		SET Estado = 1
		WHERE CodigoUsuario = @CodigoUsuario
		AND Estado = 0

		SELECT 1
	END
	ELSE
	BEGIN
		INSERT INTO UsuarioPostulante
		(
			CodigoUsuario,
			Zona,
			Seccion,
			EnvioCorreo,
			UsuarioReal,
			FechaRegistro,
			Estado
		)
		VALUES 
		(
			@CodigoUsuario,
			@Zona,
			@Seccion,
			'0',
			'0',
			GETDATE(),
			1
		)

		SELECT SCOPE_IDENTITY()
	END
END
GO
/*end*/

USE BelcorpPuertoRico
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.InsUsuarioPostulante'))
BEGIN
    DROP PROCEDURE dbo.InsUsuarioPostulante
END
GO

CREATE PROCEDURE [dbo].[InsUsuarioPostulante]
(
	@CodigoUsuario VARCHAR(20),
	@Zona VARCHAR(4),
	@Seccion CHAR(1),
	@EnvioCorreo CHAR(1),
	@UsuarioReal CHAR(1)
)
AS
BEGIN

	IF EXISTS(SELECT 1 FROM UsuarioPostulante WHERE CodigoUsuario = @CodigoUsuario AND Estado = 0)
	BEGIN
		UPDATE UsuarioPostulante
		SET Estado = 1
		WHERE CodigoUsuario = @CodigoUsuario
		AND Estado = 0

		SELECT 1
	END
	ELSE
	BEGIN
		INSERT INTO UsuarioPostulante
		(
			CodigoUsuario,
			Zona,
			Seccion,
			EnvioCorreo,
			UsuarioReal,
			FechaRegistro,
			Estado
		)
		VALUES 
		(
			@CodigoUsuario,
			@Zona,
			@Seccion,
			'0',
			'0',
			GETDATE(),
			1
		)

		SELECT SCOPE_IDENTITY()
	END
END
GO
/*end*/

USE BelcorpSalvador
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.InsUsuarioPostulante'))
BEGIN
    DROP PROCEDURE dbo.InsUsuarioPostulante
END
GO

CREATE PROCEDURE [dbo].[InsUsuarioPostulante]
(
	@CodigoUsuario VARCHAR(20),
	@Zona VARCHAR(4),
	@Seccion CHAR(1),
	@EnvioCorreo CHAR(1),
	@UsuarioReal CHAR(1)
)
AS
BEGIN

	IF EXISTS(SELECT 1 FROM UsuarioPostulante WHERE CodigoUsuario = @CodigoUsuario AND Estado = 0)
	BEGIN
		UPDATE UsuarioPostulante
		SET Estado = 1
		WHERE CodigoUsuario = @CodigoUsuario
		AND Estado = 0

		SELECT 1
	END
	ELSE
	BEGIN
		INSERT INTO UsuarioPostulante
		(
			CodigoUsuario,
			Zona,
			Seccion,
			EnvioCorreo,
			UsuarioReal,
			FechaRegistro,
			Estado
		)
		VALUES 
		(
			@CodigoUsuario,
			@Zona,
			@Seccion,
			'0',
			'0',
			GETDATE(),
			1
		)

		SELECT SCOPE_IDENTITY()
	END
END
GO
/*end*/

USE BelcorpVenezuela
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.InsUsuarioPostulante'))
BEGIN
    DROP PROCEDURE dbo.InsUsuarioPostulante
END
GO

CREATE PROCEDURE [dbo].[InsUsuarioPostulante]
(
	@CodigoUsuario VARCHAR(20),
	@Zona VARCHAR(4),
	@Seccion CHAR(1),
	@EnvioCorreo CHAR(1),
	@UsuarioReal CHAR(1)
)
AS
BEGIN

	IF EXISTS(SELECT 1 FROM UsuarioPostulante WHERE CodigoUsuario = @CodigoUsuario AND Estado = 0)
	BEGIN
		UPDATE UsuarioPostulante
		SET Estado = 1
		WHERE CodigoUsuario = @CodigoUsuario
		AND Estado = 0

		SELECT 1
	END
	ELSE
	BEGIN
		INSERT INTO UsuarioPostulante
		(
			CodigoUsuario,
			Zona,
			Seccion,
			EnvioCorreo,
			UsuarioReal,
			FechaRegistro,
			Estado
		)
		VALUES 
		(
			@CodigoUsuario,
			@Zona,
			@Seccion,
			'0',
			'0',
			GETDATE(),
			1
		)

		SELECT SCOPE_IDENTITY()
	END
END
GO
