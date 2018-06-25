USE BelcorpPeru
GO

IF (OBJECT_ID ( 'dbo.GetConfiguracionProgramaNuevasApp', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.GetConfiguracionProgramaNuevasApp AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.GetConfiguracionProgramaNuevasApp
@CodigoPrograma VARCHAR(3),
@CodigoNivel CHAR(2) = NULL
AS
BEGIN
	SET NOCOUNT ON

	SELECT
		ConfiguracionProgramaNuevasAppID,
		CodigoPrograma,
		TextoCupon,
		TextoCuponIndependiente,
		CodigoNivel,
		ArchivoBannerCupon,
		ArchivoBannerPremio,
		FechaCreacion,
		FechaModificacion
	FROM dbo.ConfiguracionProgramaNuevasApp (NOLOCK)
	WHERE CodigoPrograma = @CodigoPrograma
	AND ISNULL(CodigoNivel, '00') = ISNULL(@CodigoNivel,ISNULL(CodigoNivel, '00'))

	SET NOCOUNT OFF
END
GO

USE BelcorpMexico
GO

IF (OBJECT_ID ( 'dbo.GetConfiguracionProgramaNuevasApp', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.GetConfiguracionProgramaNuevasApp AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.GetConfiguracionProgramaNuevasApp
@CodigoPrograma VARCHAR(3),
@CodigoNivel CHAR(2) = NULL
AS
BEGIN
	SET NOCOUNT ON

	SELECT
		ConfiguracionProgramaNuevasAppID,
		CodigoPrograma,
		TextoCupon,
		TextoCuponIndependiente,
		CodigoNivel,
		ArchivoBannerCupon,
		ArchivoBannerPremio,
		FechaCreacion,
		FechaModificacion
	FROM dbo.ConfiguracionProgramaNuevasApp (NOLOCK)
	WHERE CodigoPrograma = @CodigoPrograma
	AND ISNULL(CodigoNivel, '00') = ISNULL(@CodigoNivel,ISNULL(CodigoNivel, '00'))

	SET NOCOUNT OFF
END
GO

USE BelcorpColombia
GO

IF (OBJECT_ID ( 'dbo.GetConfiguracionProgramaNuevasApp', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.GetConfiguracionProgramaNuevasApp AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.GetConfiguracionProgramaNuevasApp
@CodigoPrograma VARCHAR(3),
@CodigoNivel CHAR(2) = NULL
AS
BEGIN
	SET NOCOUNT ON

	SELECT
		ConfiguracionProgramaNuevasAppID,
		CodigoPrograma,
		TextoCupon,
		TextoCuponIndependiente,
		CodigoNivel,
		ArchivoBannerCupon,
		ArchivoBannerPremio,
		FechaCreacion,
		FechaModificacion
	FROM dbo.ConfiguracionProgramaNuevasApp (NOLOCK)
	WHERE CodigoPrograma = @CodigoPrograma
	AND ISNULL(CodigoNivel, '00') = ISNULL(@CodigoNivel,ISNULL(CodigoNivel, '00'))

	SET NOCOUNT OFF
END
GO

USE BelcorpSalvador
GO

IF (OBJECT_ID ( 'dbo.GetConfiguracionProgramaNuevasApp', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.GetConfiguracionProgramaNuevasApp AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.GetConfiguracionProgramaNuevasApp
@CodigoPrograma VARCHAR(3),
@CodigoNivel CHAR(2) = NULL
AS
BEGIN
	SET NOCOUNT ON

	SELECT
		ConfiguracionProgramaNuevasAppID,
		CodigoPrograma,
		TextoCupon,
		TextoCuponIndependiente,
		CodigoNivel,
		ArchivoBannerCupon,
		ArchivoBannerPremio,
		FechaCreacion,
		FechaModificacion
	FROM dbo.ConfiguracionProgramaNuevasApp (NOLOCK)
	WHERE CodigoPrograma = @CodigoPrograma
	AND ISNULL(CodigoNivel, '00') = ISNULL(@CodigoNivel,ISNULL(CodigoNivel, '00'))

	SET NOCOUNT OFF
END
GO

USE BelcorpPuertoRico
GO

IF (OBJECT_ID ( 'dbo.GetConfiguracionProgramaNuevasApp', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.GetConfiguracionProgramaNuevasApp AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.GetConfiguracionProgramaNuevasApp
@CodigoPrograma VARCHAR(3),
@CodigoNivel CHAR(2) = NULL
AS
BEGIN
	SET NOCOUNT ON

	SELECT
		ConfiguracionProgramaNuevasAppID,
		CodigoPrograma,
		TextoCupon,
		TextoCuponIndependiente,
		CodigoNivel,
		ArchivoBannerCupon,
		ArchivoBannerPremio,
		FechaCreacion,
		FechaModificacion
	FROM dbo.ConfiguracionProgramaNuevasApp (NOLOCK)
	WHERE CodigoPrograma = @CodigoPrograma
	AND ISNULL(CodigoNivel, '00') = ISNULL(@CodigoNivel,ISNULL(CodigoNivel, '00'))

	SET NOCOUNT OFF
END
GO

USE BelcorpPanama
GO

IF (OBJECT_ID ( 'dbo.GetConfiguracionProgramaNuevasApp', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.GetConfiguracionProgramaNuevasApp AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.GetConfiguracionProgramaNuevasApp
@CodigoPrograma VARCHAR(3),
@CodigoNivel CHAR(2) = NULL
AS
BEGIN
	SET NOCOUNT ON

	SELECT
		ConfiguracionProgramaNuevasAppID,
		CodigoPrograma,
		TextoCupon,
		TextoCuponIndependiente,
		CodigoNivel,
		ArchivoBannerCupon,
		ArchivoBannerPremio,
		FechaCreacion,
		FechaModificacion
	FROM dbo.ConfiguracionProgramaNuevasApp (NOLOCK)
	WHERE CodigoPrograma = @CodigoPrograma
	AND ISNULL(CodigoNivel, '00') = ISNULL(@CodigoNivel,ISNULL(CodigoNivel, '00'))

	SET NOCOUNT OFF
END
GO

USE BelcorpGuatemala
GO

IF (OBJECT_ID ( 'dbo.GetConfiguracionProgramaNuevasApp', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.GetConfiguracionProgramaNuevasApp AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.GetConfiguracionProgramaNuevasApp
@CodigoPrograma VARCHAR(3),
@CodigoNivel CHAR(2) = NULL
AS
BEGIN
	SET NOCOUNT ON

	SELECT
		ConfiguracionProgramaNuevasAppID,
		CodigoPrograma,
		TextoCupon,
		TextoCuponIndependiente,
		CodigoNivel,
		ArchivoBannerCupon,
		ArchivoBannerPremio,
		FechaCreacion,
		FechaModificacion
	FROM dbo.ConfiguracionProgramaNuevasApp (NOLOCK)
	WHERE CodigoPrograma = @CodigoPrograma
	AND ISNULL(CodigoNivel, '00') = ISNULL(@CodigoNivel,ISNULL(CodigoNivel, '00'))

	SET NOCOUNT OFF
END
GO

USE BelcorpEcuador
GO

IF (OBJECT_ID ( 'dbo.GetConfiguracionProgramaNuevasApp', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.GetConfiguracionProgramaNuevasApp AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.GetConfiguracionProgramaNuevasApp
@CodigoPrograma VARCHAR(3),
@CodigoNivel CHAR(2) = NULL
AS
BEGIN
	SET NOCOUNT ON

	SELECT
		ConfiguracionProgramaNuevasAppID,
		CodigoPrograma,
		TextoCupon,
		TextoCuponIndependiente,
		CodigoNivel,
		ArchivoBannerCupon,
		ArchivoBannerPremio,
		FechaCreacion,
		FechaModificacion
	FROM dbo.ConfiguracionProgramaNuevasApp (NOLOCK)
	WHERE CodigoPrograma = @CodigoPrograma
	AND ISNULL(CodigoNivel, '00') = ISNULL(@CodigoNivel,ISNULL(CodigoNivel, '00'))

	SET NOCOUNT OFF
END
GO

USE BelcorpDominicana
GO

IF (OBJECT_ID ( 'dbo.GetConfiguracionProgramaNuevasApp', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.GetConfiguracionProgramaNuevasApp AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.GetConfiguracionProgramaNuevasApp
@CodigoPrograma VARCHAR(3),
@CodigoNivel CHAR(2) = NULL
AS
BEGIN
	SET NOCOUNT ON

	SELECT
		ConfiguracionProgramaNuevasAppID,
		CodigoPrograma,
		TextoCupon,
		TextoCuponIndependiente,
		CodigoNivel,
		ArchivoBannerCupon,
		ArchivoBannerPremio,
		FechaCreacion,
		FechaModificacion
	FROM dbo.ConfiguracionProgramaNuevasApp (NOLOCK)
	WHERE CodigoPrograma = @CodigoPrograma
	AND ISNULL(CodigoNivel, '00') = ISNULL(@CodigoNivel,ISNULL(CodigoNivel, '00'))

	SET NOCOUNT OFF
END
GO

USE BelcorpCostaRica
GO

IF (OBJECT_ID ( 'dbo.GetConfiguracionProgramaNuevasApp', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.GetConfiguracionProgramaNuevasApp AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.GetConfiguracionProgramaNuevasApp
@CodigoPrograma VARCHAR(3),
@CodigoNivel CHAR(2) = NULL
AS
BEGIN
	SET NOCOUNT ON

	SELECT
		ConfiguracionProgramaNuevasAppID,
		CodigoPrograma,
		TextoCupon,
		TextoCuponIndependiente,
		CodigoNivel,
		ArchivoBannerCupon,
		ArchivoBannerPremio,
		FechaCreacion,
		FechaModificacion
	FROM dbo.ConfiguracionProgramaNuevasApp (NOLOCK)
	WHERE CodigoPrograma = @CodigoPrograma
	AND ISNULL(CodigoNivel, '00') = ISNULL(@CodigoNivel,ISNULL(CodigoNivel, '00'))

	SET NOCOUNT OFF
END
GO

USE BelcorpChile
GO

IF (OBJECT_ID ( 'dbo.GetConfiguracionProgramaNuevasApp', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.GetConfiguracionProgramaNuevasApp AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.GetConfiguracionProgramaNuevasApp
@CodigoPrograma VARCHAR(3),
@CodigoNivel CHAR(2) = NULL
AS
BEGIN
	SET NOCOUNT ON

	SELECT
		ConfiguracionProgramaNuevasAppID,
		CodigoPrograma,
		TextoCupon,
		TextoCuponIndependiente,
		CodigoNivel,
		ArchivoBannerCupon,
		ArchivoBannerPremio,
		FechaCreacion,
		FechaModificacion
	FROM dbo.ConfiguracionProgramaNuevasApp (NOLOCK)
	WHERE CodigoPrograma = @CodigoPrograma
	AND ISNULL(CodigoNivel, '00') = ISNULL(@CodigoNivel,ISNULL(CodigoNivel, '00'))

	SET NOCOUNT OFF
END
GO

USE BelcorpBolivia
GO

IF (OBJECT_ID ( 'dbo.GetConfiguracionProgramaNuevasApp', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.GetConfiguracionProgramaNuevasApp AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.GetConfiguracionProgramaNuevasApp
@CodigoPrograma VARCHAR(3),
@CodigoNivel CHAR(2) = NULL
AS
BEGIN
	SET NOCOUNT ON

	SELECT
		ConfiguracionProgramaNuevasAppID,
		CodigoPrograma,
		TextoCupon,
		TextoCuponIndependiente,
		CodigoNivel,
		ArchivoBannerCupon,
		ArchivoBannerPremio,
		FechaCreacion,
		FechaModificacion
	FROM dbo.ConfiguracionProgramaNuevasApp (NOLOCK)
	WHERE CodigoPrograma = @CodigoPrograma
	AND ISNULL(CodigoNivel, '00') = ISNULL(@CodigoNivel,ISNULL(CodigoNivel, '00'))

	SET NOCOUNT OFF
END
GO

