
USE BelcorpBolivia
GO

ALTER PROCEDURE [dbo].[InsUsuarioPostulante]
(
	@CodigoUsuario VARCHAR(20),
	@Zona VARCHAR(4),
	@Seccion CHAR(1),
	@EnvioCorreo CHAR(1),
	@UsuarioReal CHAR(1)
)
AS
BEGIN

DECLARE @Validador INT
DECLARE @ConsultoraID BIGINT
DECLARE @codigo VARCHAR(25)
DECLARE @RegionID VARCHAR (5)
DECLARE @PrimerNombre VARCHAR(25)
DECLARE @NombreCompleto VARCHAR(80)

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
		-- Calcular la consultoraID para la consultora postulante
		SET @ConsultoraID = (SELECT ISNULL(MAX(ConsultoraID), 980000000) + 1 FROM ConsultoraPostulante)
		SET @codigo = CAST(@ConsultoraID AS VARCHAR)
		
		-- Insertar data en ConsultoraPostulante.
		SELECT @PrimerNombre = SUBSTRING(Nombre, 1, CHARINDEX(' ', Nombre) - 1), 
		@NombreCompleto= Nombre 		
		FROM Usuario WHERE TipoUsuario = 2 AND CodigoUsuario = @CodigoUsuario

		INSERT INTO ConsultoraPostulante 
		(ConsultoraID, SeccionID, RegionID, ZonaID, SegmentoID, Codigo, PrimerNombre, NombreCompleto, AutorizaPedido)	
		SELECT @ConsultoraID, S.SeccionID, R.RegionID, Z.zonaid, '0', @CodigoUsuario, @PrimerNombre, @NombreCompleto, 1 
		FROM ods.zona Z 
		INNER JOIN ods.Seccion S ON Z.ZonaID = S.ZonaID
		INNER JOIN ods.Region R ON S.RegionID = R.RegionID 
		WHERE  Z.Codigo = @Zona AND S.Codigo =  @Seccion


		SELECT SCOPE_IDENTITY()
	END
END
GO
/*end*/

USE BelcorpChile
GO

ALTER PROCEDURE [dbo].[InsUsuarioPostulante]
(
	@CodigoUsuario VARCHAR(20),
	@Zona VARCHAR(4),
	@Seccion CHAR(1),
	@EnvioCorreo CHAR(1),
	@UsuarioReal CHAR(1)
)
AS
BEGIN

DECLARE @Validador INT
DECLARE @ConsultoraID BIGINT
DECLARE @codigo VARCHAR(25)
DECLARE @RegionID VARCHAR (5)
DECLARE @PrimerNombre VARCHAR(25)
DECLARE @NombreCompleto VARCHAR(80)

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
		-- Calcular la consultoraID para la consultora postulante
		SET @ConsultoraID = (SELECT ISNULL(MAX(ConsultoraID), 980000000) + 1 FROM ConsultoraPostulante)
		SET @codigo = CAST(@ConsultoraID AS VARCHAR)
		
		-- Insertar data en ConsultoraPostulante.
		SELECT @PrimerNombre = SUBSTRING(Nombre, 1, CHARINDEX(' ', Nombre) - 1), 
		@NombreCompleto= Nombre 		
		FROM Usuario WHERE TipoUsuario = 2 AND CodigoUsuario = @CodigoUsuario

		INSERT INTO ConsultoraPostulante 
		(ConsultoraID, SeccionID, RegionID, ZonaID, SegmentoID, Codigo, PrimerNombre, NombreCompleto, AutorizaPedido)	
		SELECT @ConsultoraID, S.SeccionID, R.RegionID, Z.zonaid, '0', @CodigoUsuario, @PrimerNombre, @NombreCompleto, 1 
		FROM ods.zona Z 
		INNER JOIN ods.Seccion S ON Z.ZonaID = S.ZonaID
		INNER JOIN ods.Region R ON S.RegionID = R.RegionID 
		WHERE  Z.Codigo = @Zona AND S.Codigo =  @Seccion


		SELECT SCOPE_IDENTITY()
	END
END
GO
/*end*/

USE BelcorpColombia
GO

ALTER PROCEDURE [dbo].[InsUsuarioPostulante]
(
	@CodigoUsuario VARCHAR(20),
	@Zona VARCHAR(4),
	@Seccion CHAR(1),
	@EnvioCorreo CHAR(1),
	@UsuarioReal CHAR(1)
)
AS
BEGIN

DECLARE @Validador INT
DECLARE @ConsultoraID BIGINT
DECLARE @codigo VARCHAR(25)
DECLARE @RegionID VARCHAR (5)
DECLARE @PrimerNombre VARCHAR(25)
DECLARE @NombreCompleto VARCHAR(80)

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
		-- Calcular la consultoraID para la consultora postulante
		SET @ConsultoraID = (SELECT ISNULL(MAX(ConsultoraID), 980000000) + 1 FROM ConsultoraPostulante)
		SET @codigo = CAST(@ConsultoraID AS VARCHAR)
		
		-- Insertar data en ConsultoraPostulante.
		SELECT @PrimerNombre = SUBSTRING(Nombre, 1, CHARINDEX(' ', Nombre) - 1), 
		@NombreCompleto= Nombre 		
		FROM Usuario WHERE TipoUsuario = 2 AND CodigoUsuario = @CodigoUsuario

		INSERT INTO ConsultoraPostulante 
		(ConsultoraID, SeccionID, RegionID, ZonaID, SegmentoID, Codigo, PrimerNombre, NombreCompleto, AutorizaPedido)	
		SELECT @ConsultoraID, S.SeccionID, R.RegionID, Z.zonaid, '0', @CodigoUsuario, @PrimerNombre, @NombreCompleto, 1 
		FROM ods.zona Z 
		INNER JOIN ods.Seccion S ON Z.ZonaID = S.ZonaID
		INNER JOIN ods.Region R ON S.RegionID = R.RegionID 
		WHERE  Z.Codigo = @Zona AND S.Codigo =  @Seccion


		SELECT SCOPE_IDENTITY()
	END
END
GO
/*end*/

USE BelcorpCostaRica
GO

ALTER PROCEDURE [dbo].[InsUsuarioPostulante]
(
	@CodigoUsuario VARCHAR(20),
	@Zona VARCHAR(4),
	@Seccion CHAR(1),
	@EnvioCorreo CHAR(1),
	@UsuarioReal CHAR(1)
)
AS
BEGIN

DECLARE @Validador INT
DECLARE @ConsultoraID BIGINT
DECLARE @codigo VARCHAR(25)
DECLARE @RegionID VARCHAR (5)
DECLARE @PrimerNombre VARCHAR(25)
DECLARE @NombreCompleto VARCHAR(80)

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
		-- Calcular la consultoraID para la consultora postulante
		SET @ConsultoraID = (SELECT ISNULL(MAX(ConsultoraID), 980000000) + 1 FROM ConsultoraPostulante)
		SET @codigo = CAST(@ConsultoraID AS VARCHAR)
		
		-- Insertar data en ConsultoraPostulante.
		SELECT @PrimerNombre = SUBSTRING(Nombre, 1, CHARINDEX(' ', Nombre) - 1), 
		@NombreCompleto= Nombre 		
		FROM Usuario WHERE TipoUsuario = 2 AND CodigoUsuario = @CodigoUsuario

		INSERT INTO ConsultoraPostulante 
		(ConsultoraID, SeccionID, RegionID, ZonaID, SegmentoID, Codigo, PrimerNombre, NombreCompleto, AutorizaPedido)	
		SELECT @ConsultoraID, S.SeccionID, R.RegionID, Z.zonaid, '0', @CodigoUsuario, @PrimerNombre, @NombreCompleto, 1 
		FROM ods.zona Z 
		INNER JOIN ods.Seccion S ON Z.ZonaID = S.ZonaID
		INNER JOIN ods.Region R ON S.RegionID = R.RegionID 
		WHERE  Z.Codigo = @Zona AND S.Codigo =  @Seccion


		SELECT SCOPE_IDENTITY()
	END
END
GO
/*end*/

USE BelcorpDominicana
GO

ALTER PROCEDURE [dbo].[InsUsuarioPostulante]
(
	@CodigoUsuario VARCHAR(20),
	@Zona VARCHAR(4),
	@Seccion CHAR(1),
	@EnvioCorreo CHAR(1),
	@UsuarioReal CHAR(1)
)
AS
BEGIN

DECLARE @Validador INT
DECLARE @ConsultoraID BIGINT
DECLARE @codigo VARCHAR(25)
DECLARE @RegionID VARCHAR (5)
DECLARE @PrimerNombre VARCHAR(25)
DECLARE @NombreCompleto VARCHAR(80)

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
		-- Calcular la consultoraID para la consultora postulante
		SET @ConsultoraID = (SELECT ISNULL(MAX(ConsultoraID), 980000000) + 1 FROM ConsultoraPostulante)
		SET @codigo = CAST(@ConsultoraID AS VARCHAR)
		
		-- Insertar data en ConsultoraPostulante.
		SELECT @PrimerNombre = SUBSTRING(Nombre, 1, CHARINDEX(' ', Nombre) - 1), 
		@NombreCompleto= Nombre 		
		FROM Usuario WHERE TipoUsuario = 2 AND CodigoUsuario = @CodigoUsuario

		INSERT INTO ConsultoraPostulante 
		(ConsultoraID, SeccionID, RegionID, ZonaID, SegmentoID, Codigo, PrimerNombre, NombreCompleto, AutorizaPedido)	
		SELECT @ConsultoraID, S.SeccionID, R.RegionID, Z.zonaid, '0', @CodigoUsuario, @PrimerNombre, @NombreCompleto, 1 
		FROM ods.zona Z 
		INNER JOIN ods.Seccion S ON Z.ZonaID = S.ZonaID
		INNER JOIN ods.Region R ON S.RegionID = R.RegionID 
		WHERE  Z.Codigo = @Zona AND S.Codigo =  @Seccion


		SELECT SCOPE_IDENTITY()
	END
END
GO
/*end*/

USE BelcorpEcuador
GO

ALTER PROCEDURE [dbo].[InsUsuarioPostulante]
(
	@CodigoUsuario VARCHAR(20),
	@Zona VARCHAR(4),
	@Seccion CHAR(1),
	@EnvioCorreo CHAR(1),
	@UsuarioReal CHAR(1)
)
AS
BEGIN

DECLARE @Validador INT
DECLARE @ConsultoraID BIGINT
DECLARE @codigo VARCHAR(25)
DECLARE @RegionID VARCHAR (5)
DECLARE @PrimerNombre VARCHAR(25)
DECLARE @NombreCompleto VARCHAR(80)

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
		-- Calcular la consultoraID para la consultora postulante
		SET @ConsultoraID = (SELECT ISNULL(MAX(ConsultoraID), 980000000) + 1 FROM ConsultoraPostulante)
		SET @codigo = CAST(@ConsultoraID AS VARCHAR)
		
		-- Insertar data en ConsultoraPostulante.
		SELECT @PrimerNombre = SUBSTRING(Nombre, 1, CHARINDEX(' ', Nombre) - 1), 
		@NombreCompleto= Nombre 		
		FROM Usuario WHERE TipoUsuario = 2 AND CodigoUsuario = @CodigoUsuario

		INSERT INTO ConsultoraPostulante 
		(ConsultoraID, SeccionID, RegionID, ZonaID, SegmentoID, Codigo, PrimerNombre, NombreCompleto, AutorizaPedido)	
		SELECT @ConsultoraID, S.SeccionID, R.RegionID, Z.zonaid, '0', @CodigoUsuario, @PrimerNombre, @NombreCompleto, 1 
		FROM ods.zona Z 
		INNER JOIN ods.Seccion S ON Z.ZonaID = S.ZonaID
		INNER JOIN ods.Region R ON S.RegionID = R.RegionID 
		WHERE  Z.Codigo = @Zona AND S.Codigo =  @Seccion


		SELECT SCOPE_IDENTITY()
	END
END
GO
/*end*/

USE BelcorpGuatemala
GO

ALTER PROCEDURE [dbo].[InsUsuarioPostulante]
(
	@CodigoUsuario VARCHAR(20),
	@Zona VARCHAR(4),
	@Seccion CHAR(1),
	@EnvioCorreo CHAR(1),
	@UsuarioReal CHAR(1)
)
AS
BEGIN

DECLARE @Validador INT
DECLARE @ConsultoraID BIGINT
DECLARE @codigo VARCHAR(25)
DECLARE @RegionID VARCHAR (5)
DECLARE @PrimerNombre VARCHAR(25)
DECLARE @NombreCompleto VARCHAR(80)

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
		-- Calcular la consultoraID para la consultora postulante
		SET @ConsultoraID = (SELECT ISNULL(MAX(ConsultoraID), 980000000) + 1 FROM ConsultoraPostulante)
		SET @codigo = CAST(@ConsultoraID AS VARCHAR)
		
		-- Insertar data en ConsultoraPostulante.
		SELECT @PrimerNombre = SUBSTRING(Nombre, 1, CHARINDEX(' ', Nombre) - 1), 
		@NombreCompleto= Nombre 		
		FROM Usuario WHERE TipoUsuario = 2 AND CodigoUsuario = @CodigoUsuario

		INSERT INTO ConsultoraPostulante 
		(ConsultoraID, SeccionID, RegionID, ZonaID, SegmentoID, Codigo, PrimerNombre, NombreCompleto, AutorizaPedido)	
		SELECT @ConsultoraID, S.SeccionID, R.RegionID, Z.zonaid, '0', @CodigoUsuario, @PrimerNombre, @NombreCompleto, 1 
		FROM ods.zona Z 
		INNER JOIN ods.Seccion S ON Z.ZonaID = S.ZonaID
		INNER JOIN ods.Region R ON S.RegionID = R.RegionID 
		WHERE  Z.Codigo = @Zona AND S.Codigo =  @Seccion


		SELECT SCOPE_IDENTITY()
	END
END
GO
/*end*/

USE BelcorpMexico
GO

ALTER PROCEDURE [dbo].[InsUsuarioPostulante]
(
	@CodigoUsuario VARCHAR(20),
	@Zona VARCHAR(4),
	@Seccion CHAR(1),
	@EnvioCorreo CHAR(1),
	@UsuarioReal CHAR(1)
)
AS
BEGIN

DECLARE @Validador INT
DECLARE @ConsultoraID BIGINT
DECLARE @codigo VARCHAR(25)
DECLARE @RegionID VARCHAR (5)
DECLARE @PrimerNombre VARCHAR(25)
DECLARE @NombreCompleto VARCHAR(80)

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
		-- Calcular la consultoraID para la consultora postulante
		SET @ConsultoraID = (SELECT ISNULL(MAX(ConsultoraID), 980000000) + 1 FROM ConsultoraPostulante)
		SET @codigo = CAST(@ConsultoraID AS VARCHAR)
		
		-- Insertar data en ConsultoraPostulante.
		SELECT @PrimerNombre = SUBSTRING(Nombre, 1, CHARINDEX(' ', Nombre) - 1), 
		@NombreCompleto= Nombre 		
		FROM Usuario WHERE TipoUsuario = 2 AND CodigoUsuario = @CodigoUsuario

		INSERT INTO ConsultoraPostulante 
		(ConsultoraID, SeccionID, RegionID, ZonaID, SegmentoID, Codigo, PrimerNombre, NombreCompleto, AutorizaPedido)	
		SELECT @ConsultoraID, S.SeccionID, R.RegionID, Z.zonaid, '0', @CodigoUsuario, @PrimerNombre, @NombreCompleto, 1 
		FROM ods.zona Z 
		INNER JOIN ods.Seccion S ON Z.ZonaID = S.ZonaID
		INNER JOIN ods.Region R ON S.RegionID = R.RegionID 
		WHERE  Z.Codigo = @Zona AND S.Codigo =  @Seccion


		SELECT SCOPE_IDENTITY()
	END
END
GO
/*end*/

USE BelcorpPanama
GO

ALTER PROCEDURE [dbo].[InsUsuarioPostulante]
(
	@CodigoUsuario VARCHAR(20),
	@Zona VARCHAR(4),
	@Seccion CHAR(1),
	@EnvioCorreo CHAR(1),
	@UsuarioReal CHAR(1)
)
AS
BEGIN

DECLARE @Validador INT
DECLARE @ConsultoraID BIGINT
DECLARE @codigo VARCHAR(25)
DECLARE @RegionID VARCHAR (5)
DECLARE @PrimerNombre VARCHAR(25)
DECLARE @NombreCompleto VARCHAR(80)

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
		-- Calcular la consultoraID para la consultora postulante
		SET @ConsultoraID = (SELECT ISNULL(MAX(ConsultoraID), 980000000) + 1 FROM ConsultoraPostulante)
		SET @codigo = CAST(@ConsultoraID AS VARCHAR)
		
		-- Insertar data en ConsultoraPostulante.
		SELECT @PrimerNombre = SUBSTRING(Nombre, 1, CHARINDEX(' ', Nombre) - 1), 
		@NombreCompleto= Nombre 		
		FROM Usuario WHERE TipoUsuario = 2 AND CodigoUsuario = @CodigoUsuario

		INSERT INTO ConsultoraPostulante 
		(ConsultoraID, SeccionID, RegionID, ZonaID, SegmentoID, Codigo, PrimerNombre, NombreCompleto, AutorizaPedido)	
		SELECT @ConsultoraID, S.SeccionID, R.RegionID, Z.zonaid, '0', @CodigoUsuario, @PrimerNombre, @NombreCompleto, 1 
		FROM ods.zona Z 
		INNER JOIN ods.Seccion S ON Z.ZonaID = S.ZonaID
		INNER JOIN ods.Region R ON S.RegionID = R.RegionID 
		WHERE  Z.Codigo = @Zona AND S.Codigo =  @Seccion


		SELECT SCOPE_IDENTITY()
	END
END
GO
/*end*/

USE BelcorpPeru
GO

ALTER PROCEDURE [dbo].[InsUsuarioPostulante]
(
	@CodigoUsuario VARCHAR(20),
	@Zona VARCHAR(4),
	@Seccion CHAR(1),
	@EnvioCorreo CHAR(1),
	@UsuarioReal CHAR(1)
)
AS
BEGIN

DECLARE @Validador INT
DECLARE @ConsultoraID BIGINT
DECLARE @codigo VARCHAR(25)
DECLARE @RegionID VARCHAR (5)
DECLARE @PrimerNombre VARCHAR(25)
DECLARE @NombreCompleto VARCHAR(80)

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
		-- Calcular la consultoraID para la consultora postulante
		SET @ConsultoraID = (SELECT ISNULL(MAX(ConsultoraID), 980000000) + 1 FROM ConsultoraPostulante)
		SET @codigo = CAST(@ConsultoraID AS VARCHAR)
		
		-- Insertar data en ConsultoraPostulante.
		SELECT @PrimerNombre = SUBSTRING(Nombre, 1, CHARINDEX(' ', Nombre) - 1), 
		@NombreCompleto= Nombre 		
		FROM Usuario WHERE TipoUsuario = 2 AND CodigoUsuario = @CodigoUsuario

		INSERT INTO ConsultoraPostulante 
		(ConsultoraID, SeccionID, RegionID, ZonaID, SegmentoID, Codigo, PrimerNombre, NombreCompleto, AutorizaPedido)	
		SELECT @ConsultoraID, S.SeccionID, R.RegionID, Z.zonaid, '0', @CodigoUsuario, @PrimerNombre, @NombreCompleto, 1 
		FROM ods.zona Z 
		INNER JOIN ods.Seccion S ON Z.ZonaID = S.ZonaID
		INNER JOIN ods.Region R ON S.RegionID = R.RegionID 
		WHERE  Z.Codigo = @Zona AND S.Codigo =  @Seccion


		SELECT SCOPE_IDENTITY()
	END
END
GO
/*end*/

USE BelcorpPuertoRico
GO

ALTER PROCEDURE [dbo].[InsUsuarioPostulante]
(
	@CodigoUsuario VARCHAR(20),
	@Zona VARCHAR(4),
	@Seccion CHAR(1),
	@EnvioCorreo CHAR(1),
	@UsuarioReal CHAR(1)
)
AS
BEGIN

DECLARE @Validador INT
DECLARE @ConsultoraID BIGINT
DECLARE @codigo VARCHAR(25)
DECLARE @RegionID VARCHAR (5)
DECLARE @PrimerNombre VARCHAR(25)
DECLARE @NombreCompleto VARCHAR(80)

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
		-- Calcular la consultoraID para la consultora postulante
		SET @ConsultoraID = (SELECT ISNULL(MAX(ConsultoraID), 980000000) + 1 FROM ConsultoraPostulante)
		SET @codigo = CAST(@ConsultoraID AS VARCHAR)
		
		-- Insertar data en ConsultoraPostulante.
		SELECT @PrimerNombre = SUBSTRING(Nombre, 1, CHARINDEX(' ', Nombre) - 1), 
		@NombreCompleto= Nombre 		
		FROM Usuario WHERE TipoUsuario = 2 AND CodigoUsuario = @CodigoUsuario

		INSERT INTO ConsultoraPostulante 
		(ConsultoraID, SeccionID, RegionID, ZonaID, SegmentoID, Codigo, PrimerNombre, NombreCompleto, AutorizaPedido)	
		SELECT @ConsultoraID, S.SeccionID, R.RegionID, Z.zonaid, '0', @CodigoUsuario, @PrimerNombre, @NombreCompleto, 1 
		FROM ods.zona Z 
		INNER JOIN ods.Seccion S ON Z.ZonaID = S.ZonaID
		INNER JOIN ods.Region R ON S.RegionID = R.RegionID 
		WHERE  Z.Codigo = @Zona AND S.Codigo =  @Seccion


		SELECT SCOPE_IDENTITY()
	END
END
GO
/*end*/

USE BelcorpSalvador
GO

ALTER PROCEDURE [dbo].[InsUsuarioPostulante]
(
	@CodigoUsuario VARCHAR(20),
	@Zona VARCHAR(4),
	@Seccion CHAR(1),
	@EnvioCorreo CHAR(1),
	@UsuarioReal CHAR(1)
)
AS
BEGIN

DECLARE @Validador INT
DECLARE @ConsultoraID BIGINT
DECLARE @codigo VARCHAR(25)
DECLARE @RegionID VARCHAR (5)
DECLARE @PrimerNombre VARCHAR(25)
DECLARE @NombreCompleto VARCHAR(80)

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
		-- Calcular la consultoraID para la consultora postulante
		SET @ConsultoraID = (SELECT ISNULL(MAX(ConsultoraID), 980000000) + 1 FROM ConsultoraPostulante)
		SET @codigo = CAST(@ConsultoraID AS VARCHAR)
		
		-- Insertar data en ConsultoraPostulante.
		SELECT @PrimerNombre = SUBSTRING(Nombre, 1, CHARINDEX(' ', Nombre) - 1), 
		@NombreCompleto= Nombre 		
		FROM Usuario WHERE TipoUsuario = 2 AND CodigoUsuario = @CodigoUsuario

		INSERT INTO ConsultoraPostulante 
		(ConsultoraID, SeccionID, RegionID, ZonaID, SegmentoID, Codigo, PrimerNombre, NombreCompleto, AutorizaPedido)	
		SELECT @ConsultoraID, S.SeccionID, R.RegionID, Z.zonaid, '0', @CodigoUsuario, @PrimerNombre, @NombreCompleto, 1 
		FROM ods.zona Z 
		INNER JOIN ods.Seccion S ON Z.ZonaID = S.ZonaID
		INNER JOIN ods.Region R ON S.RegionID = R.RegionID 
		WHERE  Z.Codigo = @Zona AND S.Codigo =  @Seccion


		SELECT SCOPE_IDENTITY()
	END
END
GO
/*end*/

USE BelcorpVenezuela
GO

ALTER PROCEDURE [dbo].[InsUsuarioPostulante]
(
	@CodigoUsuario VARCHAR(20),
	@Zona VARCHAR(4),
	@Seccion CHAR(1),
	@EnvioCorreo CHAR(1),
	@UsuarioReal CHAR(1)
)
AS
BEGIN

DECLARE @Validador INT
DECLARE @ConsultoraID BIGINT
DECLARE @codigo VARCHAR(25)
DECLARE @RegionID VARCHAR (5)
DECLARE @PrimerNombre VARCHAR(25)
DECLARE @NombreCompleto VARCHAR(80)

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
		-- Calcular la consultoraID para la consultora postulante
		SET @ConsultoraID = (SELECT ISNULL(MAX(ConsultoraID), 980000000) + 1 FROM ConsultoraPostulante)
		SET @codigo = CAST(@ConsultoraID AS VARCHAR)
		
		-- Insertar data en ConsultoraPostulante.
		SELECT @PrimerNombre = SUBSTRING(Nombre, 1, CHARINDEX(' ', Nombre) - 1), 
		@NombreCompleto= Nombre 		
		FROM Usuario WHERE TipoUsuario = 2 AND CodigoUsuario = @CodigoUsuario

		INSERT INTO ConsultoraPostulante 
		(ConsultoraID, SeccionID, RegionID, ZonaID, SegmentoID, Codigo, PrimerNombre, NombreCompleto, AutorizaPedido)	
		SELECT @ConsultoraID, S.SeccionID, R.RegionID, Z.zonaid, '0', @CodigoUsuario, @PrimerNombre, @NombreCompleto, 1 
		FROM ods.zona Z 
		INNER JOIN ods.Seccion S ON Z.ZonaID = S.ZonaID
		INNER JOIN ods.Region R ON S.RegionID = R.RegionID 
		WHERE  Z.Codigo = @Zona AND S.Codigo =  @Seccion


		SELECT SCOPE_IDENTITY()
	END
END
GO