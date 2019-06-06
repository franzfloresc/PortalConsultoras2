USE BelcorpPeru
GO

IF (OBJECT_ID ( 'dbo.GetConfiguracionOfertasHomeApp', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.GetConfiguracionOfertasHomeApp AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.GetConfiguracionOfertasHomeApp
@ConfiguracionOfertasHomeID INT
AS
BEGIN
	SET NOCOUNT ON

	SELECT
		ConfiguracionOfertasHomeAppID,
		AppActivo,
		AppTitulo,
		AppSubTitulo,
		AppColorFondo,
		AppColorTexto,
		AppBannerInformativo,
		AppOrden,
		AppCantidadProductos,
		AppTextoBotonInicial,
		AppTextoBotonFinal,
		AppColorFondoBoton,
		AppColorTextoBoton
	FROM dbo.ConfiguracionOfertasHomeApp (NOLOCK)
	WHERE ConfiguracionOfertasHomeID = @ConfiguracionOfertasHomeID

	SET NOCOUNT OFF
END
GO

USE BelcorpMexico
GO

IF (OBJECT_ID ( 'dbo.GetConfiguracionOfertasHomeApp', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.GetConfiguracionOfertasHomeApp AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.GetConfiguracionOfertasHomeApp
@ConfiguracionOfertasHomeID INT
AS
BEGIN
	SET NOCOUNT ON

	SELECT
		ConfiguracionOfertasHomeAppID,
		AppActivo,
		AppTitulo,
		AppSubTitulo,
		AppColorFondo,
		AppColorTexto,
		AppBannerInformativo,
		AppOrden,
		AppCantidadProductos,
		AppTextoBotonInicial,
		AppTextoBotonFinal,
		AppColorFondoBoton,
		AppColorTextoBoton
	FROM dbo.ConfiguracionOfertasHomeApp (NOLOCK)
	WHERE ConfiguracionOfertasHomeID = @ConfiguracionOfertasHomeID

	SET NOCOUNT OFF
END
GO

USE BelcorpColombia
GO

IF (OBJECT_ID ( 'dbo.GetConfiguracionOfertasHomeApp', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.GetConfiguracionOfertasHomeApp AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.GetConfiguracionOfertasHomeApp
@ConfiguracionOfertasHomeID INT
AS
BEGIN
	SET NOCOUNT ON

	SELECT
		ConfiguracionOfertasHomeAppID,
		AppActivo,
		AppTitulo,
		AppSubTitulo,
		AppColorFondo,
		AppColorTexto,
		AppBannerInformativo,
		AppOrden,
		AppCantidadProductos,
		AppTextoBotonInicial,
		AppTextoBotonFinal,
		AppColorFondoBoton,
		AppColorTextoBoton
	FROM dbo.ConfiguracionOfertasHomeApp (NOLOCK)
	WHERE ConfiguracionOfertasHomeID = @ConfiguracionOfertasHomeID

	SET NOCOUNT OFF
END
GO

USE BelcorpSalvador
GO

IF (OBJECT_ID ( 'dbo.GetConfiguracionOfertasHomeApp', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.GetConfiguracionOfertasHomeApp AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.GetConfiguracionOfertasHomeApp
@ConfiguracionOfertasHomeID INT
AS
BEGIN
	SET NOCOUNT ON

	SELECT
		ConfiguracionOfertasHomeAppID,
		AppActivo,
		AppTitulo,
		AppSubTitulo,
		AppColorFondo,
		AppColorTexto,
		AppBannerInformativo,
		AppOrden,
		AppCantidadProductos,
		AppTextoBotonInicial,
		AppTextoBotonFinal,
		AppColorFondoBoton,
		AppColorTextoBoton
	FROM dbo.ConfiguracionOfertasHomeApp (NOLOCK)
	WHERE ConfiguracionOfertasHomeID = @ConfiguracionOfertasHomeID

	SET NOCOUNT OFF
END
GO

USE BelcorpPuertoRico
GO

IF (OBJECT_ID ( 'dbo.GetConfiguracionOfertasHomeApp', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.GetConfiguracionOfertasHomeApp AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.GetConfiguracionOfertasHomeApp
@ConfiguracionOfertasHomeID INT
AS
BEGIN
	SET NOCOUNT ON

	SELECT
		ConfiguracionOfertasHomeAppID,
		AppActivo,
		AppTitulo,
		AppSubTitulo,
		AppColorFondo,
		AppColorTexto,
		AppBannerInformativo,
		AppOrden,
		AppCantidadProductos,
		AppTextoBotonInicial,
		AppTextoBotonFinal,
		AppColorFondoBoton,
		AppColorTextoBoton
	FROM dbo.ConfiguracionOfertasHomeApp (NOLOCK)
	WHERE ConfiguracionOfertasHomeID = @ConfiguracionOfertasHomeID

	SET NOCOUNT OFF
END
GO

USE BelcorpPanama
GO

IF (OBJECT_ID ( 'dbo.GetConfiguracionOfertasHomeApp', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.GetConfiguracionOfertasHomeApp AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.GetConfiguracionOfertasHomeApp
@ConfiguracionOfertasHomeID INT
AS
BEGIN
	SET NOCOUNT ON

	SELECT
		ConfiguracionOfertasHomeAppID,
		AppActivo,
		AppTitulo,
		AppSubTitulo,
		AppColorFondo,
		AppColorTexto,
		AppBannerInformativo,
		AppOrden,
		AppCantidadProductos,
		AppTextoBotonInicial,
		AppTextoBotonFinal,
		AppColorFondoBoton,
		AppColorTextoBoton
	FROM dbo.ConfiguracionOfertasHomeApp (NOLOCK)
	WHERE ConfiguracionOfertasHomeID = @ConfiguracionOfertasHomeID

	SET NOCOUNT OFF
END
GO

USE BelcorpGuatemala
GO

IF (OBJECT_ID ( 'dbo.GetConfiguracionOfertasHomeApp', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.GetConfiguracionOfertasHomeApp AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.GetConfiguracionOfertasHomeApp
@ConfiguracionOfertasHomeID INT
AS
BEGIN
	SET NOCOUNT ON

	SELECT
		ConfiguracionOfertasHomeAppID,
		AppActivo,
		AppTitulo,
		AppSubTitulo,
		AppColorFondo,
		AppColorTexto,
		AppBannerInformativo,
		AppOrden,
		AppCantidadProductos,
		AppTextoBotonInicial,
		AppTextoBotonFinal,
		AppColorFondoBoton,
		AppColorTextoBoton
	FROM dbo.ConfiguracionOfertasHomeApp (NOLOCK)
	WHERE ConfiguracionOfertasHomeID = @ConfiguracionOfertasHomeID

	SET NOCOUNT OFF
END
GO

USE BelcorpEcuador
GO

IF (OBJECT_ID ( 'dbo.GetConfiguracionOfertasHomeApp', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.GetConfiguracionOfertasHomeApp AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.GetConfiguracionOfertasHomeApp
@ConfiguracionOfertasHomeID INT
AS
BEGIN
	SET NOCOUNT ON

	SELECT
		ConfiguracionOfertasHomeAppID,
		AppActivo,
		AppTitulo,
		AppSubTitulo,
		AppColorFondo,
		AppColorTexto,
		AppBannerInformativo,
		AppOrden,
		AppCantidadProductos,
		AppTextoBotonInicial,
		AppTextoBotonFinal,
		AppColorFondoBoton,
		AppColorTextoBoton
	FROM dbo.ConfiguracionOfertasHomeApp (NOLOCK)
	WHERE ConfiguracionOfertasHomeID = @ConfiguracionOfertasHomeID

	SET NOCOUNT OFF
END
GO

USE BelcorpDominicana
GO

IF (OBJECT_ID ( 'dbo.GetConfiguracionOfertasHomeApp', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.GetConfiguracionOfertasHomeApp AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.GetConfiguracionOfertasHomeApp
@ConfiguracionOfertasHomeID INT
AS
BEGIN
	SET NOCOUNT ON

	SELECT
		ConfiguracionOfertasHomeAppID,
		AppActivo,
		AppTitulo,
		AppSubTitulo,
		AppColorFondo,
		AppColorTexto,
		AppBannerInformativo,
		AppOrden,
		AppCantidadProductos,
		AppTextoBotonInicial,
		AppTextoBotonFinal,
		AppColorFondoBoton,
		AppColorTextoBoton
	FROM dbo.ConfiguracionOfertasHomeApp (NOLOCK)
	WHERE ConfiguracionOfertasHomeID = @ConfiguracionOfertasHomeID

	SET NOCOUNT OFF
END
GO

USE BelcorpCostaRica
GO

IF (OBJECT_ID ( 'dbo.GetConfiguracionOfertasHomeApp', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.GetConfiguracionOfertasHomeApp AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.GetConfiguracionOfertasHomeApp
@ConfiguracionOfertasHomeID INT
AS
BEGIN
	SET NOCOUNT ON

	SELECT
		ConfiguracionOfertasHomeAppID,
		AppActivo,
		AppTitulo,
		AppSubTitulo,
		AppColorFondo,
		AppColorTexto,
		AppBannerInformativo,
		AppOrden,
		AppCantidadProductos,
		AppTextoBotonInicial,
		AppTextoBotonFinal,
		AppColorFondoBoton,
		AppColorTextoBoton
	FROM dbo.ConfiguracionOfertasHomeApp (NOLOCK)
	WHERE ConfiguracionOfertasHomeID = @ConfiguracionOfertasHomeID

	SET NOCOUNT OFF
END
GO

USE BelcorpChile
GO

IF (OBJECT_ID ( 'dbo.GetConfiguracionOfertasHomeApp', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.GetConfiguracionOfertasHomeApp AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.GetConfiguracionOfertasHomeApp
@ConfiguracionOfertasHomeID INT
AS
BEGIN
	SET NOCOUNT ON

	SELECT
		ConfiguracionOfertasHomeAppID,
		AppActivo,
		AppTitulo,
		AppSubTitulo,
		AppColorFondo,
		AppColorTexto,
		AppBannerInformativo,
		AppOrden,
		AppCantidadProductos,
		AppTextoBotonInicial,
		AppTextoBotonFinal,
		AppColorFondoBoton,
		AppColorTextoBoton
	FROM dbo.ConfiguracionOfertasHomeApp (NOLOCK)
	WHERE ConfiguracionOfertasHomeID = @ConfiguracionOfertasHomeID

	SET NOCOUNT OFF
END
GO

USE BelcorpBolivia
GO

IF (OBJECT_ID ( 'dbo.GetConfiguracionOfertasHomeApp', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.GetConfiguracionOfertasHomeApp AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.GetConfiguracionOfertasHomeApp
@ConfiguracionOfertasHomeID INT
AS
BEGIN
	SET NOCOUNT ON

	SELECT
		ConfiguracionOfertasHomeAppID,
		AppActivo,
		AppTitulo,
		AppSubTitulo,
		AppColorFondo,
		AppColorTexto,
		AppBannerInformativo,
		AppOrden,
		AppCantidadProductos,
		AppTextoBotonInicial,
		AppTextoBotonFinal,
		AppColorFondoBoton,
		AppColorTextoBoton
	FROM dbo.ConfiguracionOfertasHomeApp (NOLOCK)
	WHERE ConfiguracionOfertasHomeID = @ConfiguracionOfertasHomeID

	SET NOCOUNT OFF
END
GO

