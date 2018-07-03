USE BelcorpPeru
GO

IF (OBJECT_ID ( 'dbo.InsConfiguracionProgramaNuevasApp', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.InsConfiguracionProgramaNuevasApp AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.InsConfiguracionProgramaNuevasApp
@CodigoPrograma VARCHAR(3),
@TextoCupon VARCHAR(500) = NULL,
@TextoCuponIndependiente VARCHAR(500) = NULL,
@CodigoNivel CHAR(2) = NULL,
@ArchivoBannerCupon VARCHAR(100) = NULL,
@ArchivoBannerPremio VARCHAR(100) = NULL
AS
BEGIN
	SET NOCOUNT ON

	IF EXISTS(SELECT 1 FROM dbo.ConfiguracionProgramaNuevasApp WHERE CodigoPrograma = @CodigoPrograma AND ISNULL(CodigoNivel,'00') = ISNULL(@CodigoNivel, ISNULL(CodigoNivel,'00')))
	BEGIN
		UPDATE dbo.ConfiguracionProgramaNuevasApp
		SET CodigoPrograma = @CodigoPrograma,
			TextoCupon = @TextoCupon,
			TextoCuponIndependiente = @TextoCuponIndependiente,
			ArchivoBannerCupon = ISNULL(@ArchivoBannerCupon,ArchivoBannerCupon),
			ArchivoBannerPremio = ISNULL(@ArchivoBannerPremio,ArchivoBannerPremio),
			FechaModificacion = GETDATE()
		WHERE CodigoPrograma = @CodigoPrograma AND ISNULL(CodigoNivel,'00') = ISNULL(@CodigoNivel, ISNULL(CodigoNivel,'00'))
	END
	ELSE
	BEGIN
		INSERT INTO dbo.ConfiguracionProgramaNuevasApp
		(
			CodigoPrograma,
			TextoCupon,
			TextoCuponIndependiente,
			CodigoNivel,
			ArchivoBannerCupon,
			ArchivoBannerPremio
		)
		VALUES
		(
			@CodigoPrograma,
			@TextoCupon,
			@TextoCuponIndependiente,
			@CodigoNivel,
			@ArchivoBannerCupon,
			@ArchivoBannerPremio
		)
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
@CodigoPrograma VARCHAR(3),
@TextoCupon VARCHAR(500) = NULL,
@TextoCuponIndependiente VARCHAR(500) = NULL,
@CodigoNivel CHAR(2) = NULL,
@ArchivoBannerCupon VARCHAR(100) = NULL,
@ArchivoBannerPremio VARCHAR(100) = NULL
AS
BEGIN
	SET NOCOUNT ON

	IF EXISTS(SELECT 1 FROM dbo.ConfiguracionProgramaNuevasApp WHERE CodigoPrograma = @CodigoPrograma AND ISNULL(CodigoNivel,'00') = ISNULL(@CodigoNivel, ISNULL(CodigoNivel,'00')))
	BEGIN
		UPDATE dbo.ConfiguracionProgramaNuevasApp
		SET CodigoPrograma = @CodigoPrograma,
			TextoCupon = @TextoCupon,
			TextoCuponIndependiente = @TextoCuponIndependiente,
			ArchivoBannerCupon = ISNULL(@ArchivoBannerCupon,ArchivoBannerCupon),
			ArchivoBannerPremio = ISNULL(@ArchivoBannerPremio,ArchivoBannerPremio),
			FechaModificacion = GETDATE()
		WHERE CodigoPrograma = @CodigoPrograma AND ISNULL(CodigoNivel,'00') = ISNULL(@CodigoNivel, ISNULL(CodigoNivel,'00'))
	END
	ELSE
	BEGIN
		INSERT INTO dbo.ConfiguracionProgramaNuevasApp
		(
			CodigoPrograma,
			TextoCupon,
			TextoCuponIndependiente,
			CodigoNivel,
			ArchivoBannerCupon,
			ArchivoBannerPremio
		)
		VALUES
		(
			@CodigoPrograma,
			@TextoCupon,
			@TextoCuponIndependiente,
			@CodigoNivel,
			@ArchivoBannerCupon,
			@ArchivoBannerPremio
		)
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
@CodigoPrograma VARCHAR(3),
@TextoCupon VARCHAR(500) = NULL,
@TextoCuponIndependiente VARCHAR(500) = NULL,
@CodigoNivel CHAR(2) = NULL,
@ArchivoBannerCupon VARCHAR(100) = NULL,
@ArchivoBannerPremio VARCHAR(100) = NULL
AS
BEGIN
	SET NOCOUNT ON

	IF EXISTS(SELECT 1 FROM dbo.ConfiguracionProgramaNuevasApp WHERE CodigoPrograma = @CodigoPrograma AND ISNULL(CodigoNivel,'00') = ISNULL(@CodigoNivel, ISNULL(CodigoNivel,'00')))
	BEGIN
		UPDATE dbo.ConfiguracionProgramaNuevasApp
		SET CodigoPrograma = @CodigoPrograma,
			TextoCupon = @TextoCupon,
			TextoCuponIndependiente = @TextoCuponIndependiente,
			ArchivoBannerCupon = ISNULL(@ArchivoBannerCupon,ArchivoBannerCupon),
			ArchivoBannerPremio = ISNULL(@ArchivoBannerPremio,ArchivoBannerPremio),
			FechaModificacion = GETDATE()
		WHERE CodigoPrograma = @CodigoPrograma AND ISNULL(CodigoNivel,'00') = ISNULL(@CodigoNivel, ISNULL(CodigoNivel,'00'))
	END
	ELSE
	BEGIN
		INSERT INTO dbo.ConfiguracionProgramaNuevasApp
		(
			CodigoPrograma,
			TextoCupon,
			TextoCuponIndependiente,
			CodigoNivel,
			ArchivoBannerCupon,
			ArchivoBannerPremio
		)
		VALUES
		(
			@CodigoPrograma,
			@TextoCupon,
			@TextoCuponIndependiente,
			@CodigoNivel,
			@ArchivoBannerCupon,
			@ArchivoBannerPremio
		)
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
@CodigoPrograma VARCHAR(3),
@TextoCupon VARCHAR(500) = NULL,
@TextoCuponIndependiente VARCHAR(500) = NULL,
@CodigoNivel CHAR(2) = NULL,
@ArchivoBannerCupon VARCHAR(100) = NULL,
@ArchivoBannerPremio VARCHAR(100) = NULL
AS
BEGIN
	SET NOCOUNT ON

	IF EXISTS(SELECT 1 FROM dbo.ConfiguracionProgramaNuevasApp WHERE CodigoPrograma = @CodigoPrograma AND ISNULL(CodigoNivel,'00') = ISNULL(@CodigoNivel, ISNULL(CodigoNivel,'00')))
	BEGIN
		UPDATE dbo.ConfiguracionProgramaNuevasApp
		SET CodigoPrograma = @CodigoPrograma,
			TextoCupon = @TextoCupon,
			TextoCuponIndependiente = @TextoCuponIndependiente,
			ArchivoBannerCupon = ISNULL(@ArchivoBannerCupon,ArchivoBannerCupon),
			ArchivoBannerPremio = ISNULL(@ArchivoBannerPremio,ArchivoBannerPremio),
			FechaModificacion = GETDATE()
		WHERE CodigoPrograma = @CodigoPrograma AND ISNULL(CodigoNivel,'00') = ISNULL(@CodigoNivel, ISNULL(CodigoNivel,'00'))
	END
	ELSE
	BEGIN
		INSERT INTO dbo.ConfiguracionProgramaNuevasApp
		(
			CodigoPrograma,
			TextoCupon,
			TextoCuponIndependiente,
			CodigoNivel,
			ArchivoBannerCupon,
			ArchivoBannerPremio
		)
		VALUES
		(
			@CodigoPrograma,
			@TextoCupon,
			@TextoCuponIndependiente,
			@CodigoNivel,
			@ArchivoBannerCupon,
			@ArchivoBannerPremio
		)
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
@CodigoPrograma VARCHAR(3),
@TextoCupon VARCHAR(500) = NULL,
@TextoCuponIndependiente VARCHAR(500) = NULL,
@CodigoNivel CHAR(2) = NULL,
@ArchivoBannerCupon VARCHAR(100) = NULL,
@ArchivoBannerPremio VARCHAR(100) = NULL
AS
BEGIN
	SET NOCOUNT ON

	IF EXISTS(SELECT 1 FROM dbo.ConfiguracionProgramaNuevasApp WHERE CodigoPrograma = @CodigoPrograma AND ISNULL(CodigoNivel,'00') = ISNULL(@CodigoNivel, ISNULL(CodigoNivel,'00')))
	BEGIN
		UPDATE dbo.ConfiguracionProgramaNuevasApp
		SET CodigoPrograma = @CodigoPrograma,
			TextoCupon = @TextoCupon,
			TextoCuponIndependiente = @TextoCuponIndependiente,
			ArchivoBannerCupon = ISNULL(@ArchivoBannerCupon,ArchivoBannerCupon),
			ArchivoBannerPremio = ISNULL(@ArchivoBannerPremio,ArchivoBannerPremio),
			FechaModificacion = GETDATE()
		WHERE CodigoPrograma = @CodigoPrograma AND ISNULL(CodigoNivel,'00') = ISNULL(@CodigoNivel, ISNULL(CodigoNivel,'00'))
	END
	ELSE
	BEGIN
		INSERT INTO dbo.ConfiguracionProgramaNuevasApp
		(
			CodigoPrograma,
			TextoCupon,
			TextoCuponIndependiente,
			CodigoNivel,
			ArchivoBannerCupon,
			ArchivoBannerPremio
		)
		VALUES
		(
			@CodigoPrograma,
			@TextoCupon,
			@TextoCuponIndependiente,
			@CodigoNivel,
			@ArchivoBannerCupon,
			@ArchivoBannerPremio
		)
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
@CodigoPrograma VARCHAR(3),
@TextoCupon VARCHAR(500) = NULL,
@TextoCuponIndependiente VARCHAR(500) = NULL,
@CodigoNivel CHAR(2) = NULL,
@ArchivoBannerCupon VARCHAR(100) = NULL,
@ArchivoBannerPremio VARCHAR(100) = NULL
AS
BEGIN
	SET NOCOUNT ON

	IF EXISTS(SELECT 1 FROM dbo.ConfiguracionProgramaNuevasApp WHERE CodigoPrograma = @CodigoPrograma AND ISNULL(CodigoNivel,'00') = ISNULL(@CodigoNivel, ISNULL(CodigoNivel,'00')))
	BEGIN
		UPDATE dbo.ConfiguracionProgramaNuevasApp
		SET CodigoPrograma = @CodigoPrograma,
			TextoCupon = @TextoCupon,
			TextoCuponIndependiente = @TextoCuponIndependiente,
			ArchivoBannerCupon = ISNULL(@ArchivoBannerCupon,ArchivoBannerCupon),
			ArchivoBannerPremio = ISNULL(@ArchivoBannerPremio,ArchivoBannerPremio),
			FechaModificacion = GETDATE()
		WHERE CodigoPrograma = @CodigoPrograma AND ISNULL(CodigoNivel,'00') = ISNULL(@CodigoNivel, ISNULL(CodigoNivel,'00'))
	END
	ELSE
	BEGIN
		INSERT INTO dbo.ConfiguracionProgramaNuevasApp
		(
			CodigoPrograma,
			TextoCupon,
			TextoCuponIndependiente,
			CodigoNivel,
			ArchivoBannerCupon,
			ArchivoBannerPremio
		)
		VALUES
		(
			@CodigoPrograma,
			@TextoCupon,
			@TextoCuponIndependiente,
			@CodigoNivel,
			@ArchivoBannerCupon,
			@ArchivoBannerPremio
		)
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
@CodigoPrograma VARCHAR(3),
@TextoCupon VARCHAR(500) = NULL,
@TextoCuponIndependiente VARCHAR(500) = NULL,
@CodigoNivel CHAR(2) = NULL,
@ArchivoBannerCupon VARCHAR(100) = NULL,
@ArchivoBannerPremio VARCHAR(100) = NULL
AS
BEGIN
	SET NOCOUNT ON

	IF EXISTS(SELECT 1 FROM dbo.ConfiguracionProgramaNuevasApp WHERE CodigoPrograma = @CodigoPrograma AND ISNULL(CodigoNivel,'00') = ISNULL(@CodigoNivel, ISNULL(CodigoNivel,'00')))
	BEGIN
		UPDATE dbo.ConfiguracionProgramaNuevasApp
		SET CodigoPrograma = @CodigoPrograma,
			TextoCupon = @TextoCupon,
			TextoCuponIndependiente = @TextoCuponIndependiente,
			ArchivoBannerCupon = ISNULL(@ArchivoBannerCupon,ArchivoBannerCupon),
			ArchivoBannerPremio = ISNULL(@ArchivoBannerPremio,ArchivoBannerPremio),
			FechaModificacion = GETDATE()
		WHERE CodigoPrograma = @CodigoPrograma AND ISNULL(CodigoNivel,'00') = ISNULL(@CodigoNivel, ISNULL(CodigoNivel,'00'))
	END
	ELSE
	BEGIN
		INSERT INTO dbo.ConfiguracionProgramaNuevasApp
		(
			CodigoPrograma,
			TextoCupon,
			TextoCuponIndependiente,
			CodigoNivel,
			ArchivoBannerCupon,
			ArchivoBannerPremio
		)
		VALUES
		(
			@CodigoPrograma,
			@TextoCupon,
			@TextoCuponIndependiente,
			@CodigoNivel,
			@ArchivoBannerCupon,
			@ArchivoBannerPremio
		)
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
@CodigoPrograma VARCHAR(3),
@TextoCupon VARCHAR(500) = NULL,
@TextoCuponIndependiente VARCHAR(500) = NULL,
@CodigoNivel CHAR(2) = NULL,
@ArchivoBannerCupon VARCHAR(100) = NULL,
@ArchivoBannerPremio VARCHAR(100) = NULL
AS
BEGIN
	SET NOCOUNT ON

	IF EXISTS(SELECT 1 FROM dbo.ConfiguracionProgramaNuevasApp WHERE CodigoPrograma = @CodigoPrograma AND ISNULL(CodigoNivel,'00') = ISNULL(@CodigoNivel, ISNULL(CodigoNivel,'00')))
	BEGIN
		UPDATE dbo.ConfiguracionProgramaNuevasApp
		SET CodigoPrograma = @CodigoPrograma,
			TextoCupon = @TextoCupon,
			TextoCuponIndependiente = @TextoCuponIndependiente,
			ArchivoBannerCupon = ISNULL(@ArchivoBannerCupon,ArchivoBannerCupon),
			ArchivoBannerPremio = ISNULL(@ArchivoBannerPremio,ArchivoBannerPremio),
			FechaModificacion = GETDATE()
		WHERE CodigoPrograma = @CodigoPrograma AND ISNULL(CodigoNivel,'00') = ISNULL(@CodigoNivel, ISNULL(CodigoNivel,'00'))
	END
	ELSE
	BEGIN
		INSERT INTO dbo.ConfiguracionProgramaNuevasApp
		(
			CodigoPrograma,
			TextoCupon,
			TextoCuponIndependiente,
			CodigoNivel,
			ArchivoBannerCupon,
			ArchivoBannerPremio
		)
		VALUES
		(
			@CodigoPrograma,
			@TextoCupon,
			@TextoCuponIndependiente,
			@CodigoNivel,
			@ArchivoBannerCupon,
			@ArchivoBannerPremio
		)
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
@CodigoPrograma VARCHAR(3),
@TextoCupon VARCHAR(500) = NULL,
@TextoCuponIndependiente VARCHAR(500) = NULL,
@CodigoNivel CHAR(2) = NULL,
@ArchivoBannerCupon VARCHAR(100) = NULL,
@ArchivoBannerPremio VARCHAR(100) = NULL
AS
BEGIN
	SET NOCOUNT ON

	IF EXISTS(SELECT 1 FROM dbo.ConfiguracionProgramaNuevasApp WHERE CodigoPrograma = @CodigoPrograma AND ISNULL(CodigoNivel,'00') = ISNULL(@CodigoNivel, ISNULL(CodigoNivel,'00')))
	BEGIN
		UPDATE dbo.ConfiguracionProgramaNuevasApp
		SET CodigoPrograma = @CodigoPrograma,
			TextoCupon = @TextoCupon,
			TextoCuponIndependiente = @TextoCuponIndependiente,
			ArchivoBannerCupon = ISNULL(@ArchivoBannerCupon,ArchivoBannerCupon),
			ArchivoBannerPremio = ISNULL(@ArchivoBannerPremio,ArchivoBannerPremio),
			FechaModificacion = GETDATE()
		WHERE CodigoPrograma = @CodigoPrograma AND ISNULL(CodigoNivel,'00') = ISNULL(@CodigoNivel, ISNULL(CodigoNivel,'00'))
	END
	ELSE
	BEGIN
		INSERT INTO dbo.ConfiguracionProgramaNuevasApp
		(
			CodigoPrograma,
			TextoCupon,
			TextoCuponIndependiente,
			CodigoNivel,
			ArchivoBannerCupon,
			ArchivoBannerPremio
		)
		VALUES
		(
			@CodigoPrograma,
			@TextoCupon,
			@TextoCuponIndependiente,
			@CodigoNivel,
			@ArchivoBannerCupon,
			@ArchivoBannerPremio
		)
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
@CodigoPrograma VARCHAR(3),
@TextoCupon VARCHAR(500) = NULL,
@TextoCuponIndependiente VARCHAR(500) = NULL,
@CodigoNivel CHAR(2) = NULL,
@ArchivoBannerCupon VARCHAR(100) = NULL,
@ArchivoBannerPremio VARCHAR(100) = NULL
AS
BEGIN
	SET NOCOUNT ON

	IF EXISTS(SELECT 1 FROM dbo.ConfiguracionProgramaNuevasApp WHERE CodigoPrograma = @CodigoPrograma AND ISNULL(CodigoNivel,'00') = ISNULL(@CodigoNivel, ISNULL(CodigoNivel,'00')))
	BEGIN
		UPDATE dbo.ConfiguracionProgramaNuevasApp
		SET CodigoPrograma = @CodigoPrograma,
			TextoCupon = @TextoCupon,
			TextoCuponIndependiente = @TextoCuponIndependiente,
			ArchivoBannerCupon = ISNULL(@ArchivoBannerCupon,ArchivoBannerCupon),
			ArchivoBannerPremio = ISNULL(@ArchivoBannerPremio,ArchivoBannerPremio),
			FechaModificacion = GETDATE()
		WHERE CodigoPrograma = @CodigoPrograma AND ISNULL(CodigoNivel,'00') = ISNULL(@CodigoNivel, ISNULL(CodigoNivel,'00'))
	END
	ELSE
	BEGIN
		INSERT INTO dbo.ConfiguracionProgramaNuevasApp
		(
			CodigoPrograma,
			TextoCupon,
			TextoCuponIndependiente,
			CodigoNivel,
			ArchivoBannerCupon,
			ArchivoBannerPremio
		)
		VALUES
		(
			@CodigoPrograma,
			@TextoCupon,
			@TextoCuponIndependiente,
			@CodigoNivel,
			@ArchivoBannerCupon,
			@ArchivoBannerPremio
		)
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
@CodigoPrograma VARCHAR(3),
@TextoCupon VARCHAR(500) = NULL,
@TextoCuponIndependiente VARCHAR(500) = NULL,
@CodigoNivel CHAR(2) = NULL,
@ArchivoBannerCupon VARCHAR(100) = NULL,
@ArchivoBannerPremio VARCHAR(100) = NULL
AS
BEGIN
	SET NOCOUNT ON

	IF EXISTS(SELECT 1 FROM dbo.ConfiguracionProgramaNuevasApp WHERE CodigoPrograma = @CodigoPrograma AND ISNULL(CodigoNivel,'00') = ISNULL(@CodigoNivel, ISNULL(CodigoNivel,'00')))
	BEGIN
		UPDATE dbo.ConfiguracionProgramaNuevasApp
		SET CodigoPrograma = @CodigoPrograma,
			TextoCupon = @TextoCupon,
			TextoCuponIndependiente = @TextoCuponIndependiente,
			ArchivoBannerCupon = ISNULL(@ArchivoBannerCupon,ArchivoBannerCupon),
			ArchivoBannerPremio = ISNULL(@ArchivoBannerPremio,ArchivoBannerPremio),
			FechaModificacion = GETDATE()
		WHERE CodigoPrograma = @CodigoPrograma AND ISNULL(CodigoNivel,'00') = ISNULL(@CodigoNivel, ISNULL(CodigoNivel,'00'))
	END
	ELSE
	BEGIN
		INSERT INTO dbo.ConfiguracionProgramaNuevasApp
		(
			CodigoPrograma,
			TextoCupon,
			TextoCuponIndependiente,
			CodigoNivel,
			ArchivoBannerCupon,
			ArchivoBannerPremio
		)
		VALUES
		(
			@CodigoPrograma,
			@TextoCupon,
			@TextoCuponIndependiente,
			@CodigoNivel,
			@ArchivoBannerCupon,
			@ArchivoBannerPremio
		)
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
@CodigoPrograma VARCHAR(3),
@TextoCupon VARCHAR(500) = NULL,
@TextoCuponIndependiente VARCHAR(500) = NULL,
@CodigoNivel CHAR(2) = NULL,
@ArchivoBannerCupon VARCHAR(100) = NULL,
@ArchivoBannerPremio VARCHAR(100) = NULL
AS
BEGIN
	SET NOCOUNT ON

	IF EXISTS(SELECT 1 FROM dbo.ConfiguracionProgramaNuevasApp WHERE CodigoPrograma = @CodigoPrograma AND ISNULL(CodigoNivel,'00') = ISNULL(@CodigoNivel, ISNULL(CodigoNivel,'00')))
	BEGIN
		UPDATE dbo.ConfiguracionProgramaNuevasApp
		SET CodigoPrograma = @CodigoPrograma,
			TextoCupon = @TextoCupon,
			TextoCuponIndependiente = @TextoCuponIndependiente,
			ArchivoBannerCupon = ISNULL(@ArchivoBannerCupon,ArchivoBannerCupon),
			ArchivoBannerPremio = ISNULL(@ArchivoBannerPremio,ArchivoBannerPremio),
			FechaModificacion = GETDATE()
		WHERE CodigoPrograma = @CodigoPrograma AND ISNULL(CodigoNivel,'00') = ISNULL(@CodigoNivel, ISNULL(CodigoNivel,'00'))
	END
	ELSE
	BEGIN
		INSERT INTO dbo.ConfiguracionProgramaNuevasApp
		(
			CodigoPrograma,
			TextoCupon,
			TextoCuponIndependiente,
			CodigoNivel,
			ArchivoBannerCupon,
			ArchivoBannerPremio
		)
		VALUES
		(
			@CodigoPrograma,
			@TextoCupon,
			@TextoCuponIndependiente,
			@CodigoNivel,
			@ArchivoBannerCupon,
			@ArchivoBannerPremio
		)
	END

	SET NOCOUNT OFF
END
GO

