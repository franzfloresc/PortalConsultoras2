USE BelcorpPeru
GO

IF (OBJECT_ID ( 'dbo.InsConfiguracionProgramaNuevasApp', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.InsConfiguracionProgramaNuevasApp AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.InsConfiguracionProgramaNuevasApp
@ConfiguracionProgramaNuevasAppID INT,
@CodigoPrograma VARCHAR(3),
@TextoCupon VARCHAR(500) = NULL,
@TextoCuponIndependiente VARCHAR(500) = NULL,
@MensajeValidacion VARCHAR(200) OUT
AS
BEGIN
	SET NOCOUNT ON

	SET @MensajeValidacion = ''

	IF EXISTS(SELECT 1 FROM dbo.ConfiguracionProgramaNuevasApp WHERE CodigoPrograma = @CodigoPrograma 
				AND ConfiguracionProgramaNuevasAppID <> @ConfiguracionProgramaNuevasAppID)
	BEGIN
		SET @MensajeValidacion = 'El código de programa ' + @CodigoPrograma + ' ya cuenta con una configuración'
	END

	IF LEN(@MensajeValidacion) = 0
	BEGIN
		IF EXISTS(SELECT 1 FROM dbo.ConfiguracionProgramaNuevasApp WHERE ConfiguracionProgramaNuevasAppID = @ConfiguracionProgramaNuevasAppID)
		BEGIN
			UPDATE dbo.ConfiguracionProgramaNuevasApp
			SET CodigoPrograma = @CodigoPrograma,
				TextoCupon = @TextoCupon,
				TextoCuponIndependiente = @TextoCuponIndependiente,
				FechaModificacion = GETDATE()
			WHERE ConfiguracionProgramaNuevasAppID = @ConfiguracionProgramaNuevasAppID
		END
		ELSE
		BEGIN
			INSERT INTO dbo.ConfiguracionProgramaNuevasApp
			(
				CodigoPrograma,
				TextoCupon,
				TextoCuponIndependiente
			)
			VALUES
			(
				@CodigoPrograma,
				@TextoCupon,
				@TextoCuponIndependiente
			)
		END
	END

	SET NOCOUNT OFF
END
GO

USE BelcorpMexico
GO

IF (OBJECT_ID ( 'dbo.InsConfiguracionProgramaNuevasApp', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.InsConfiguracionProgramaNuevasApp AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.InsConfiguracionProgramaNuevasApp
@ConfiguracionProgramaNuevasAppID INT,
@CodigoPrograma VARCHAR(3),
@TextoCupon VARCHAR(500) = NULL,
@TextoCuponIndependiente VARCHAR(500) = NULL,
@MensajeValidacion VARCHAR(200) OUT
AS
BEGIN
	SET NOCOUNT ON

	SET @MensajeValidacion = ''

	IF EXISTS(SELECT 1 FROM dbo.ConfiguracionProgramaNuevasApp WHERE CodigoPrograma = @CodigoPrograma 
				AND ConfiguracionProgramaNuevasAppID <> @ConfiguracionProgramaNuevasAppID)
	BEGIN
		SET @MensajeValidacion = 'El código de programa ' + @CodigoPrograma + ' ya cuenta con una configuración'
	END

	IF LEN(@MensajeValidacion) = 0
	BEGIN
		IF EXISTS(SELECT 1 FROM dbo.ConfiguracionProgramaNuevasApp WHERE ConfiguracionProgramaNuevasAppID = @ConfiguracionProgramaNuevasAppID)
		BEGIN
			UPDATE dbo.ConfiguracionProgramaNuevasApp
			SET CodigoPrograma = @CodigoPrograma,
				TextoCupon = @TextoCupon,
				TextoCuponIndependiente = @TextoCuponIndependiente,
				FechaModificacion = GETDATE()
			WHERE ConfiguracionProgramaNuevasAppID = @ConfiguracionProgramaNuevasAppID
		END
		ELSE
		BEGIN
			INSERT INTO dbo.ConfiguracionProgramaNuevasApp
			(
				CodigoPrograma,
				TextoCupon,
				TextoCuponIndependiente
			)
			VALUES
			(
				@CodigoPrograma,
				@TextoCupon,
				@TextoCuponIndependiente
			)
		END
	END

	SET NOCOUNT OFF
END
GO

USE BelcorpColombia
GO

IF (OBJECT_ID ( 'dbo.InsConfiguracionProgramaNuevasApp', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.InsConfiguracionProgramaNuevasApp AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.InsConfiguracionProgramaNuevasApp
@ConfiguracionProgramaNuevasAppID INT,
@CodigoPrograma VARCHAR(3),
@TextoCupon VARCHAR(500) = NULL,
@TextoCuponIndependiente VARCHAR(500) = NULL,
@MensajeValidacion VARCHAR(200) OUT
AS
BEGIN
	SET NOCOUNT ON

	SET @MensajeValidacion = ''

	IF EXISTS(SELECT 1 FROM dbo.ConfiguracionProgramaNuevasApp WHERE CodigoPrograma = @CodigoPrograma 
				AND ConfiguracionProgramaNuevasAppID <> @ConfiguracionProgramaNuevasAppID)
	BEGIN
		SET @MensajeValidacion = 'El código de programa ' + @CodigoPrograma + ' ya cuenta con una configuración'
	END

	IF LEN(@MensajeValidacion) = 0
	BEGIN
		IF EXISTS(SELECT 1 FROM dbo.ConfiguracionProgramaNuevasApp WHERE ConfiguracionProgramaNuevasAppID = @ConfiguracionProgramaNuevasAppID)
		BEGIN
			UPDATE dbo.ConfiguracionProgramaNuevasApp
			SET CodigoPrograma = @CodigoPrograma,
				TextoCupon = @TextoCupon,
				TextoCuponIndependiente = @TextoCuponIndependiente,
				FechaModificacion = GETDATE()
			WHERE ConfiguracionProgramaNuevasAppID = @ConfiguracionProgramaNuevasAppID
		END
		ELSE
		BEGIN
			INSERT INTO dbo.ConfiguracionProgramaNuevasApp
			(
				CodigoPrograma,
				TextoCupon,
				TextoCuponIndependiente
			)
			VALUES
			(
				@CodigoPrograma,
				@TextoCupon,
				@TextoCuponIndependiente
			)
		END
	END

	SET NOCOUNT OFF
END
GO

USE BelcorpSalvador
GO

IF (OBJECT_ID ( 'dbo.InsConfiguracionProgramaNuevasApp', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.InsConfiguracionProgramaNuevasApp AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.InsConfiguracionProgramaNuevasApp
@ConfiguracionProgramaNuevasAppID INT,
@CodigoPrograma VARCHAR(3),
@TextoCupon VARCHAR(500) = NULL,
@TextoCuponIndependiente VARCHAR(500) = NULL,
@MensajeValidacion VARCHAR(200) OUT
AS
BEGIN
	SET NOCOUNT ON

	SET @MensajeValidacion = ''

	IF EXISTS(SELECT 1 FROM dbo.ConfiguracionProgramaNuevasApp WHERE CodigoPrograma = @CodigoPrograma 
				AND ConfiguracionProgramaNuevasAppID <> @ConfiguracionProgramaNuevasAppID)
	BEGIN
		SET @MensajeValidacion = 'El código de programa ' + @CodigoPrograma + ' ya cuenta con una configuración'
	END

	IF LEN(@MensajeValidacion) = 0
	BEGIN
		IF EXISTS(SELECT 1 FROM dbo.ConfiguracionProgramaNuevasApp WHERE ConfiguracionProgramaNuevasAppID = @ConfiguracionProgramaNuevasAppID)
		BEGIN
			UPDATE dbo.ConfiguracionProgramaNuevasApp
			SET CodigoPrograma = @CodigoPrograma,
				TextoCupon = @TextoCupon,
				TextoCuponIndependiente = @TextoCuponIndependiente,
				FechaModificacion = GETDATE()
			WHERE ConfiguracionProgramaNuevasAppID = @ConfiguracionProgramaNuevasAppID
		END
		ELSE
		BEGIN
			INSERT INTO dbo.ConfiguracionProgramaNuevasApp
			(
				CodigoPrograma,
				TextoCupon,
				TextoCuponIndependiente
			)
			VALUES
			(
				@CodigoPrograma,
				@TextoCupon,
				@TextoCuponIndependiente
			)
		END
	END

	SET NOCOUNT OFF
END
GO

USE BelcorpPuertoRico
GO

IF (OBJECT_ID ( 'dbo.InsConfiguracionProgramaNuevasApp', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.InsConfiguracionProgramaNuevasApp AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.InsConfiguracionProgramaNuevasApp
@ConfiguracionProgramaNuevasAppID INT,
@CodigoPrograma VARCHAR(3),
@TextoCupon VARCHAR(500) = NULL,
@TextoCuponIndependiente VARCHAR(500) = NULL,
@MensajeValidacion VARCHAR(200) OUT
AS
BEGIN
	SET NOCOUNT ON

	SET @MensajeValidacion = ''

	IF EXISTS(SELECT 1 FROM dbo.ConfiguracionProgramaNuevasApp WHERE CodigoPrograma = @CodigoPrograma 
				AND ConfiguracionProgramaNuevasAppID <> @ConfiguracionProgramaNuevasAppID)
	BEGIN
		SET @MensajeValidacion = 'El código de programa ' + @CodigoPrograma + ' ya cuenta con una configuración'
	END

	IF LEN(@MensajeValidacion) = 0
	BEGIN
		IF EXISTS(SELECT 1 FROM dbo.ConfiguracionProgramaNuevasApp WHERE ConfiguracionProgramaNuevasAppID = @ConfiguracionProgramaNuevasAppID)
		BEGIN
			UPDATE dbo.ConfiguracionProgramaNuevasApp
			SET CodigoPrograma = @CodigoPrograma,
				TextoCupon = @TextoCupon,
				TextoCuponIndependiente = @TextoCuponIndependiente,
				FechaModificacion = GETDATE()
			WHERE ConfiguracionProgramaNuevasAppID = @ConfiguracionProgramaNuevasAppID
		END
		ELSE
		BEGIN
			INSERT INTO dbo.ConfiguracionProgramaNuevasApp
			(
				CodigoPrograma,
				TextoCupon,
				TextoCuponIndependiente
			)
			VALUES
			(
				@CodigoPrograma,
				@TextoCupon,
				@TextoCuponIndependiente
			)
		END
	END

	SET NOCOUNT OFF
END
GO

USE BelcorpPanama
GO

IF (OBJECT_ID ( 'dbo.InsConfiguracionProgramaNuevasApp', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.InsConfiguracionProgramaNuevasApp AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.InsConfiguracionProgramaNuevasApp
@ConfiguracionProgramaNuevasAppID INT,
@CodigoPrograma VARCHAR(3),
@TextoCupon VARCHAR(500) = NULL,
@TextoCuponIndependiente VARCHAR(500) = NULL,
@MensajeValidacion VARCHAR(200) OUT
AS
BEGIN
	SET NOCOUNT ON

	SET @MensajeValidacion = ''

	IF EXISTS(SELECT 1 FROM dbo.ConfiguracionProgramaNuevasApp WHERE CodigoPrograma = @CodigoPrograma 
				AND ConfiguracionProgramaNuevasAppID <> @ConfiguracionProgramaNuevasAppID)
	BEGIN
		SET @MensajeValidacion = 'El código de programa ' + @CodigoPrograma + ' ya cuenta con una configuración'
	END

	IF LEN(@MensajeValidacion) = 0
	BEGIN
		IF EXISTS(SELECT 1 FROM dbo.ConfiguracionProgramaNuevasApp WHERE ConfiguracionProgramaNuevasAppID = @ConfiguracionProgramaNuevasAppID)
		BEGIN
			UPDATE dbo.ConfiguracionProgramaNuevasApp
			SET CodigoPrograma = @CodigoPrograma,
				TextoCupon = @TextoCupon,
				TextoCuponIndependiente = @TextoCuponIndependiente,
				FechaModificacion = GETDATE()
			WHERE ConfiguracionProgramaNuevasAppID = @ConfiguracionProgramaNuevasAppID
		END
		ELSE
		BEGIN
			INSERT INTO dbo.ConfiguracionProgramaNuevasApp
			(
				CodigoPrograma,
				TextoCupon,
				TextoCuponIndependiente
			)
			VALUES
			(
				@CodigoPrograma,
				@TextoCupon,
				@TextoCuponIndependiente
			)
		END
	END

	SET NOCOUNT OFF
END
GO

USE BelcorpGuatemala
GO

IF (OBJECT_ID ( 'dbo.InsConfiguracionProgramaNuevasApp', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.InsConfiguracionProgramaNuevasApp AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.InsConfiguracionProgramaNuevasApp
@ConfiguracionProgramaNuevasAppID INT,
@CodigoPrograma VARCHAR(3),
@TextoCupon VARCHAR(500) = NULL,
@TextoCuponIndependiente VARCHAR(500) = NULL,
@MensajeValidacion VARCHAR(200) OUT
AS
BEGIN
	SET NOCOUNT ON

	SET @MensajeValidacion = ''

	IF EXISTS(SELECT 1 FROM dbo.ConfiguracionProgramaNuevasApp WHERE CodigoPrograma = @CodigoPrograma 
				AND ConfiguracionProgramaNuevasAppID <> @ConfiguracionProgramaNuevasAppID)
	BEGIN
		SET @MensajeValidacion = 'El código de programa ' + @CodigoPrograma + ' ya cuenta con una configuración'
	END

	IF LEN(@MensajeValidacion) = 0
	BEGIN
		IF EXISTS(SELECT 1 FROM dbo.ConfiguracionProgramaNuevasApp WHERE ConfiguracionProgramaNuevasAppID = @ConfiguracionProgramaNuevasAppID)
		BEGIN
			UPDATE dbo.ConfiguracionProgramaNuevasApp
			SET CodigoPrograma = @CodigoPrograma,
				TextoCupon = @TextoCupon,
				TextoCuponIndependiente = @TextoCuponIndependiente,
				FechaModificacion = GETDATE()
			WHERE ConfiguracionProgramaNuevasAppID = @ConfiguracionProgramaNuevasAppID
		END
		ELSE
		BEGIN
			INSERT INTO dbo.ConfiguracionProgramaNuevasApp
			(
				CodigoPrograma,
				TextoCupon,
				TextoCuponIndependiente
			)
			VALUES
			(
				@CodigoPrograma,
				@TextoCupon,
				@TextoCuponIndependiente
			)
		END
	END

	SET NOCOUNT OFF
END
GO

USE BelcorpEcuador
GO

IF (OBJECT_ID ( 'dbo.InsConfiguracionProgramaNuevasApp', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.InsConfiguracionProgramaNuevasApp AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.InsConfiguracionProgramaNuevasApp
@ConfiguracionProgramaNuevasAppID INT,
@CodigoPrograma VARCHAR(3),
@TextoCupon VARCHAR(500) = NULL,
@TextoCuponIndependiente VARCHAR(500) = NULL,
@MensajeValidacion VARCHAR(200) OUT
AS
BEGIN
	SET NOCOUNT ON

	SET @MensajeValidacion = ''

	IF EXISTS(SELECT 1 FROM dbo.ConfiguracionProgramaNuevasApp WHERE CodigoPrograma = @CodigoPrograma 
				AND ConfiguracionProgramaNuevasAppID <> @ConfiguracionProgramaNuevasAppID)
	BEGIN
		SET @MensajeValidacion = 'El código de programa ' + @CodigoPrograma + ' ya cuenta con una configuración'
	END

	IF LEN(@MensajeValidacion) = 0
	BEGIN
		IF EXISTS(SELECT 1 FROM dbo.ConfiguracionProgramaNuevasApp WHERE ConfiguracionProgramaNuevasAppID = @ConfiguracionProgramaNuevasAppID)
		BEGIN
			UPDATE dbo.ConfiguracionProgramaNuevasApp
			SET CodigoPrograma = @CodigoPrograma,
				TextoCupon = @TextoCupon,
				TextoCuponIndependiente = @TextoCuponIndependiente,
				FechaModificacion = GETDATE()
			WHERE ConfiguracionProgramaNuevasAppID = @ConfiguracionProgramaNuevasAppID
		END
		ELSE
		BEGIN
			INSERT INTO dbo.ConfiguracionProgramaNuevasApp
			(
				CodigoPrograma,
				TextoCupon,
				TextoCuponIndependiente
			)
			VALUES
			(
				@CodigoPrograma,
				@TextoCupon,
				@TextoCuponIndependiente
			)
		END
	END

	SET NOCOUNT OFF
END
GO

USE BelcorpDominicana
GO

IF (OBJECT_ID ( 'dbo.InsConfiguracionProgramaNuevasApp', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.InsConfiguracionProgramaNuevasApp AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.InsConfiguracionProgramaNuevasApp
@ConfiguracionProgramaNuevasAppID INT,
@CodigoPrograma VARCHAR(3),
@TextoCupon VARCHAR(500) = NULL,
@TextoCuponIndependiente VARCHAR(500) = NULL,
@MensajeValidacion VARCHAR(200) OUT
AS
BEGIN
	SET NOCOUNT ON

	SET @MensajeValidacion = ''

	IF EXISTS(SELECT 1 FROM dbo.ConfiguracionProgramaNuevasApp WHERE CodigoPrograma = @CodigoPrograma 
				AND ConfiguracionProgramaNuevasAppID <> @ConfiguracionProgramaNuevasAppID)
	BEGIN
		SET @MensajeValidacion = 'El código de programa ' + @CodigoPrograma + ' ya cuenta con una configuración'
	END

	IF LEN(@MensajeValidacion) = 0
	BEGIN
		IF EXISTS(SELECT 1 FROM dbo.ConfiguracionProgramaNuevasApp WHERE ConfiguracionProgramaNuevasAppID = @ConfiguracionProgramaNuevasAppID)
		BEGIN
			UPDATE dbo.ConfiguracionProgramaNuevasApp
			SET CodigoPrograma = @CodigoPrograma,
				TextoCupon = @TextoCupon,
				TextoCuponIndependiente = @TextoCuponIndependiente,
				FechaModificacion = GETDATE()
			WHERE ConfiguracionProgramaNuevasAppID = @ConfiguracionProgramaNuevasAppID
		END
		ELSE
		BEGIN
			INSERT INTO dbo.ConfiguracionProgramaNuevasApp
			(
				CodigoPrograma,
				TextoCupon,
				TextoCuponIndependiente
			)
			VALUES
			(
				@CodigoPrograma,
				@TextoCupon,
				@TextoCuponIndependiente
			)
		END
	END

	SET NOCOUNT OFF
END
GO

USE BelcorpCostaRica
GO

IF (OBJECT_ID ( 'dbo.InsConfiguracionProgramaNuevasApp', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.InsConfiguracionProgramaNuevasApp AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.InsConfiguracionProgramaNuevasApp
@ConfiguracionProgramaNuevasAppID INT,
@CodigoPrograma VARCHAR(3),
@TextoCupon VARCHAR(500) = NULL,
@TextoCuponIndependiente VARCHAR(500) = NULL,
@MensajeValidacion VARCHAR(200) OUT
AS
BEGIN
	SET NOCOUNT ON

	SET @MensajeValidacion = ''

	IF EXISTS(SELECT 1 FROM dbo.ConfiguracionProgramaNuevasApp WHERE CodigoPrograma = @CodigoPrograma 
				AND ConfiguracionProgramaNuevasAppID <> @ConfiguracionProgramaNuevasAppID)
	BEGIN
		SET @MensajeValidacion = 'El código de programa ' + @CodigoPrograma + ' ya cuenta con una configuración'
	END

	IF LEN(@MensajeValidacion) = 0
	BEGIN
		IF EXISTS(SELECT 1 FROM dbo.ConfiguracionProgramaNuevasApp WHERE ConfiguracionProgramaNuevasAppID = @ConfiguracionProgramaNuevasAppID)
		BEGIN
			UPDATE dbo.ConfiguracionProgramaNuevasApp
			SET CodigoPrograma = @CodigoPrograma,
				TextoCupon = @TextoCupon,
				TextoCuponIndependiente = @TextoCuponIndependiente,
				FechaModificacion = GETDATE()
			WHERE ConfiguracionProgramaNuevasAppID = @ConfiguracionProgramaNuevasAppID
		END
		ELSE
		BEGIN
			INSERT INTO dbo.ConfiguracionProgramaNuevasApp
			(
				CodigoPrograma,
				TextoCupon,
				TextoCuponIndependiente
			)
			VALUES
			(
				@CodigoPrograma,
				@TextoCupon,
				@TextoCuponIndependiente
			)
		END
	END

	SET NOCOUNT OFF
END
GO

USE BelcorpChile
GO

IF (OBJECT_ID ( 'dbo.InsConfiguracionProgramaNuevasApp', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.InsConfiguracionProgramaNuevasApp AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.InsConfiguracionProgramaNuevasApp
@ConfiguracionProgramaNuevasAppID INT,
@CodigoPrograma VARCHAR(3),
@TextoCupon VARCHAR(500) = NULL,
@TextoCuponIndependiente VARCHAR(500) = NULL,
@MensajeValidacion VARCHAR(200) OUT
AS
BEGIN
	SET NOCOUNT ON

	SET @MensajeValidacion = ''

	IF EXISTS(SELECT 1 FROM dbo.ConfiguracionProgramaNuevasApp WHERE CodigoPrograma = @CodigoPrograma 
				AND ConfiguracionProgramaNuevasAppID <> @ConfiguracionProgramaNuevasAppID)
	BEGIN
		SET @MensajeValidacion = 'El código de programa ' + @CodigoPrograma + ' ya cuenta con una configuración'
	END

	IF LEN(@MensajeValidacion) = 0
	BEGIN
		IF EXISTS(SELECT 1 FROM dbo.ConfiguracionProgramaNuevasApp WHERE ConfiguracionProgramaNuevasAppID = @ConfiguracionProgramaNuevasAppID)
		BEGIN
			UPDATE dbo.ConfiguracionProgramaNuevasApp
			SET CodigoPrograma = @CodigoPrograma,
				TextoCupon = @TextoCupon,
				TextoCuponIndependiente = @TextoCuponIndependiente,
				FechaModificacion = GETDATE()
			WHERE ConfiguracionProgramaNuevasAppID = @ConfiguracionProgramaNuevasAppID
		END
		ELSE
		BEGIN
			INSERT INTO dbo.ConfiguracionProgramaNuevasApp
			(
				CodigoPrograma,
				TextoCupon,
				TextoCuponIndependiente
			)
			VALUES
			(
				@CodigoPrograma,
				@TextoCupon,
				@TextoCuponIndependiente
			)
		END
	END

	SET NOCOUNT OFF
END
GO

USE BelcorpBolivia
GO

IF (OBJECT_ID ( 'dbo.InsConfiguracionProgramaNuevasApp', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.InsConfiguracionProgramaNuevasApp AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.InsConfiguracionProgramaNuevasApp
@ConfiguracionProgramaNuevasAppID INT,
@CodigoPrograma VARCHAR(3),
@TextoCupon VARCHAR(500) = NULL,
@TextoCuponIndependiente VARCHAR(500) = NULL,
@MensajeValidacion VARCHAR(200) OUT
AS
BEGIN
	SET NOCOUNT ON

	SET @MensajeValidacion = ''

	IF EXISTS(SELECT 1 FROM dbo.ConfiguracionProgramaNuevasApp WHERE CodigoPrograma = @CodigoPrograma 
				AND ConfiguracionProgramaNuevasAppID <> @ConfiguracionProgramaNuevasAppID)
	BEGIN
		SET @MensajeValidacion = 'El código de programa ' + @CodigoPrograma + ' ya cuenta con una configuración'
	END

	IF LEN(@MensajeValidacion) = 0
	BEGIN
		IF EXISTS(SELECT 1 FROM dbo.ConfiguracionProgramaNuevasApp WHERE ConfiguracionProgramaNuevasAppID = @ConfiguracionProgramaNuevasAppID)
		BEGIN
			UPDATE dbo.ConfiguracionProgramaNuevasApp
			SET CodigoPrograma = @CodigoPrograma,
				TextoCupon = @TextoCupon,
				TextoCuponIndependiente = @TextoCuponIndependiente,
				FechaModificacion = GETDATE()
			WHERE ConfiguracionProgramaNuevasAppID = @ConfiguracionProgramaNuevasAppID
		END
		ELSE
		BEGIN
			INSERT INTO dbo.ConfiguracionProgramaNuevasApp
			(
				CodigoPrograma,
				TextoCupon,
				TextoCuponIndependiente
			)
			VALUES
			(
				@CodigoPrograma,
				@TextoCupon,
				@TextoCuponIndependiente
			)
		END
	END

	SET NOCOUNT OFF
END
GO

