USE BelcorpPeru
GO

IF (OBJECT_ID ( 'dbo.InsConfiguracionOfertasHomeApp', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.InsConfiguracionOfertasHomeApp AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.InsConfiguracionOfertasHomeApp
@ConfiguracionOfertasHomeAppID INT,
@ConfiguracionOfertasHomeID INT,
@AppActivo BIT,
@AppTitulo VARCHAR(250),
@AppColorFondo VARCHAR(10),
@AppColorTexto VARCHAR(10),
@AppBannerInformativo VARCHAR(250),
@AppOrden INT,
@AppCantidadProductos INT,
@AppSubTitulo VARCHAR(250)
AS
BEGIN
	IF EXISTS(SELECT 1 FROM dbo.ConfiguracionOfertasHomeApp (NOLOCK) WHERE ConfiguracionOfertasHomeAppID = @ConfiguracionOfertasHomeAppID)
	BEGIN
		UPDATE dbo.ConfiguracionOfertasHomeApp
		SET AppActivo = @AppActivo,
			AppTitulo = @AppTitulo,
			AppSubTitulo = @AppSubTitulo,
			AppColorFondo = @AppColorFondo,
			AppColorTexto = @AppColorTexto,
			AppBannerInformativo = @AppBannerInformativo,
			AppOrden = @AppOrden,
			AppCantidadProductos = @AppCantidadProductos,
			FechaModificacion = GETDATE()
		WHERE ConfiguracionOfertasHomeAppID = @ConfiguracionOfertasHomeAppID
	END
	ELSE
	BEGIN
		INSERT INTO dbo.ConfiguracionOfertasHomeApp
		(
			ConfiguracionOfertasHomeID,
			AppActivo,
			AppTitulo,
			AppSubTitulo,
			AppColorFondo,
			AppColorTexto,
			AppBannerInformativo,
			AppOrden,
			AppCantidadProductos
		)
		VALUES
		(
			@ConfiguracionOfertasHomeID,
			@AppActivo,
			@AppTitulo,
			@AppSubTitulo,
			@AppColorFondo,
			@AppColorTexto,
			@AppBannerInformativo,
			@AppOrden,
			@AppCantidadProductos
		)
	END
END
GO

USE BelcorpMexico
GO

IF (OBJECT_ID ( 'dbo.InsConfiguracionOfertasHomeApp', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.InsConfiguracionOfertasHomeApp AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.InsConfiguracionOfertasHomeApp
@ConfiguracionOfertasHomeAppID INT,
@ConfiguracionOfertasHomeID INT,
@AppActivo BIT,
@AppTitulo VARCHAR(250),
@AppColorFondo VARCHAR(10),
@AppColorTexto VARCHAR(10),
@AppBannerInformativo VARCHAR(250),
@AppOrden INT,
@AppCantidadProductos INT,
@AppSubTitulo VARCHAR(250)
AS
BEGIN
	IF EXISTS(SELECT 1 FROM dbo.ConfiguracionOfertasHomeApp (NOLOCK) WHERE ConfiguracionOfertasHomeAppID = @ConfiguracionOfertasHomeAppID)
	BEGIN
		UPDATE dbo.ConfiguracionOfertasHomeApp
		SET AppActivo = @AppActivo,
			AppTitulo = @AppTitulo,
			AppSubTitulo = @AppSubTitulo,
			AppColorFondo = @AppColorFondo,
			AppColorTexto = @AppColorTexto,
			AppBannerInformativo = @AppBannerInformativo,
			AppOrden = @AppOrden,
			AppCantidadProductos = @AppCantidadProductos,
			FechaModificacion = GETDATE()
		WHERE ConfiguracionOfertasHomeAppID = @ConfiguracionOfertasHomeAppID
	END
	ELSE
	BEGIN
		INSERT INTO dbo.ConfiguracionOfertasHomeApp
		(
			ConfiguracionOfertasHomeID,
			AppActivo,
			AppTitulo,
			AppSubTitulo,
			AppColorFondo,
			AppColorTexto,
			AppBannerInformativo,
			AppOrden,
			AppCantidadProductos
		)
		VALUES
		(
			@ConfiguracionOfertasHomeID,
			@AppActivo,
			@AppTitulo,
			@AppSubTitulo,
			@AppColorFondo,
			@AppColorTexto,
			@AppBannerInformativo,
			@AppOrden,
			@AppCantidadProductos
		)
	END
END
GO

USE BelcorpColombia
GO

IF (OBJECT_ID ( 'dbo.InsConfiguracionOfertasHomeApp', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.InsConfiguracionOfertasHomeApp AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.InsConfiguracionOfertasHomeApp
@ConfiguracionOfertasHomeAppID INT,
@ConfiguracionOfertasHomeID INT,
@AppActivo BIT,
@AppTitulo VARCHAR(250),
@AppColorFondo VARCHAR(10),
@AppColorTexto VARCHAR(10),
@AppBannerInformativo VARCHAR(250),
@AppOrden INT,
@AppCantidadProductos INT,
@AppSubTitulo VARCHAR(250)
AS
BEGIN
	IF EXISTS(SELECT 1 FROM dbo.ConfiguracionOfertasHomeApp (NOLOCK) WHERE ConfiguracionOfertasHomeAppID = @ConfiguracionOfertasHomeAppID)
	BEGIN
		UPDATE dbo.ConfiguracionOfertasHomeApp
		SET AppActivo = @AppActivo,
			AppTitulo = @AppTitulo,
			AppSubTitulo = @AppSubTitulo,
			AppColorFondo = @AppColorFondo,
			AppColorTexto = @AppColorTexto,
			AppBannerInformativo = @AppBannerInformativo,
			AppOrden = @AppOrden,
			AppCantidadProductos = @AppCantidadProductos,
			FechaModificacion = GETDATE()
		WHERE ConfiguracionOfertasHomeAppID = @ConfiguracionOfertasHomeAppID
	END
	ELSE
	BEGIN
		INSERT INTO dbo.ConfiguracionOfertasHomeApp
		(
			ConfiguracionOfertasHomeID,
			AppActivo,
			AppTitulo,
			AppSubTitulo,
			AppColorFondo,
			AppColorTexto,
			AppBannerInformativo,
			AppOrden,
			AppCantidadProductos
		)
		VALUES
		(
			@ConfiguracionOfertasHomeID,
			@AppActivo,
			@AppTitulo,
			@AppSubTitulo,
			@AppColorFondo,
			@AppColorTexto,
			@AppBannerInformativo,
			@AppOrden,
			@AppCantidadProductos
		)
	END
END
GO

USE BelcorpSalvador
GO

IF (OBJECT_ID ( 'dbo.InsConfiguracionOfertasHomeApp', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.InsConfiguracionOfertasHomeApp AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.InsConfiguracionOfertasHomeApp
@ConfiguracionOfertasHomeAppID INT,
@ConfiguracionOfertasHomeID INT,
@AppActivo BIT,
@AppTitulo VARCHAR(250),
@AppColorFondo VARCHAR(10),
@AppColorTexto VARCHAR(10),
@AppBannerInformativo VARCHAR(250),
@AppOrden INT,
@AppCantidadProductos INT,
@AppSubTitulo VARCHAR(250)
AS
BEGIN
	IF EXISTS(SELECT 1 FROM dbo.ConfiguracionOfertasHomeApp (NOLOCK) WHERE ConfiguracionOfertasHomeAppID = @ConfiguracionOfertasHomeAppID)
	BEGIN
		UPDATE dbo.ConfiguracionOfertasHomeApp
		SET AppActivo = @AppActivo,
			AppTitulo = @AppTitulo,
			AppSubTitulo = @AppSubTitulo,
			AppColorFondo = @AppColorFondo,
			AppColorTexto = @AppColorTexto,
			AppBannerInformativo = @AppBannerInformativo,
			AppOrden = @AppOrden,
			AppCantidadProductos = @AppCantidadProductos,
			FechaModificacion = GETDATE()
		WHERE ConfiguracionOfertasHomeAppID = @ConfiguracionOfertasHomeAppID
	END
	ELSE
	BEGIN
		INSERT INTO dbo.ConfiguracionOfertasHomeApp
		(
			ConfiguracionOfertasHomeID,
			AppActivo,
			AppTitulo,
			AppSubTitulo,
			AppColorFondo,
			AppColorTexto,
			AppBannerInformativo,
			AppOrden,
			AppCantidadProductos
		)
		VALUES
		(
			@ConfiguracionOfertasHomeID,
			@AppActivo,
			@AppTitulo,
			@AppSubTitulo,
			@AppColorFondo,
			@AppColorTexto,
			@AppBannerInformativo,
			@AppOrden,
			@AppCantidadProductos
		)
	END
END
GO

USE BelcorpPuertoRico
GO

IF (OBJECT_ID ( 'dbo.InsConfiguracionOfertasHomeApp', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.InsConfiguracionOfertasHomeApp AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.InsConfiguracionOfertasHomeApp
@ConfiguracionOfertasHomeAppID INT,
@ConfiguracionOfertasHomeID INT,
@AppActivo BIT,
@AppTitulo VARCHAR(250),
@AppColorFondo VARCHAR(10),
@AppColorTexto VARCHAR(10),
@AppBannerInformativo VARCHAR(250),
@AppOrden INT,
@AppCantidadProductos INT,
@AppSubTitulo VARCHAR(250)
AS
BEGIN
	IF EXISTS(SELECT 1 FROM dbo.ConfiguracionOfertasHomeApp (NOLOCK) WHERE ConfiguracionOfertasHomeAppID = @ConfiguracionOfertasHomeAppID)
	BEGIN
		UPDATE dbo.ConfiguracionOfertasHomeApp
		SET AppActivo = @AppActivo,
			AppTitulo = @AppTitulo,
			AppSubTitulo = @AppSubTitulo,
			AppColorFondo = @AppColorFondo,
			AppColorTexto = @AppColorTexto,
			AppBannerInformativo = @AppBannerInformativo,
			AppOrden = @AppOrden,
			AppCantidadProductos = @AppCantidadProductos,
			FechaModificacion = GETDATE()
		WHERE ConfiguracionOfertasHomeAppID = @ConfiguracionOfertasHomeAppID
	END
	ELSE
	BEGIN
		INSERT INTO dbo.ConfiguracionOfertasHomeApp
		(
			ConfiguracionOfertasHomeID,
			AppActivo,
			AppTitulo,
			AppSubTitulo,
			AppColorFondo,
			AppColorTexto,
			AppBannerInformativo,
			AppOrden,
			AppCantidadProductos
		)
		VALUES
		(
			@ConfiguracionOfertasHomeID,
			@AppActivo,
			@AppTitulo,
			@AppSubTitulo,
			@AppColorFondo,
			@AppColorTexto,
			@AppBannerInformativo,
			@AppOrden,
			@AppCantidadProductos
		)
	END
END
GO

USE BelcorpPanama
GO

IF (OBJECT_ID ( 'dbo.InsConfiguracionOfertasHomeApp', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.InsConfiguracionOfertasHomeApp AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.InsConfiguracionOfertasHomeApp
@ConfiguracionOfertasHomeAppID INT,
@ConfiguracionOfertasHomeID INT,
@AppActivo BIT,
@AppTitulo VARCHAR(250),
@AppColorFondo VARCHAR(10),
@AppColorTexto VARCHAR(10),
@AppBannerInformativo VARCHAR(250),
@AppOrden INT,
@AppCantidadProductos INT,
@AppSubTitulo VARCHAR(250)
AS
BEGIN
	IF EXISTS(SELECT 1 FROM dbo.ConfiguracionOfertasHomeApp (NOLOCK) WHERE ConfiguracionOfertasHomeAppID = @ConfiguracionOfertasHomeAppID)
	BEGIN
		UPDATE dbo.ConfiguracionOfertasHomeApp
		SET AppActivo = @AppActivo,
			AppTitulo = @AppTitulo,
			AppSubTitulo = @AppSubTitulo,
			AppColorFondo = @AppColorFondo,
			AppColorTexto = @AppColorTexto,
			AppBannerInformativo = @AppBannerInformativo,
			AppOrden = @AppOrden,
			AppCantidadProductos = @AppCantidadProductos,
			FechaModificacion = GETDATE()
		WHERE ConfiguracionOfertasHomeAppID = @ConfiguracionOfertasHomeAppID
	END
	ELSE
	BEGIN
		INSERT INTO dbo.ConfiguracionOfertasHomeApp
		(
			ConfiguracionOfertasHomeID,
			AppActivo,
			AppTitulo,
			AppSubTitulo,
			AppColorFondo,
			AppColorTexto,
			AppBannerInformativo,
			AppOrden,
			AppCantidadProductos
		)
		VALUES
		(
			@ConfiguracionOfertasHomeID,
			@AppActivo,
			@AppTitulo,
			@AppSubTitulo,
			@AppColorFondo,
			@AppColorTexto,
			@AppBannerInformativo,
			@AppOrden,
			@AppCantidadProductos
		)
	END
END
GO

USE BelcorpGuatemala
GO

IF (OBJECT_ID ( 'dbo.InsConfiguracionOfertasHomeApp', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.InsConfiguracionOfertasHomeApp AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.InsConfiguracionOfertasHomeApp
@ConfiguracionOfertasHomeAppID INT,
@ConfiguracionOfertasHomeID INT,
@AppActivo BIT,
@AppTitulo VARCHAR(250),
@AppColorFondo VARCHAR(10),
@AppColorTexto VARCHAR(10),
@AppBannerInformativo VARCHAR(250),
@AppOrden INT,
@AppCantidadProductos INT,
@AppSubTitulo VARCHAR(250)
AS
BEGIN
	IF EXISTS(SELECT 1 FROM dbo.ConfiguracionOfertasHomeApp (NOLOCK) WHERE ConfiguracionOfertasHomeAppID = @ConfiguracionOfertasHomeAppID)
	BEGIN
		UPDATE dbo.ConfiguracionOfertasHomeApp
		SET AppActivo = @AppActivo,
			AppTitulo = @AppTitulo,
			AppSubTitulo = @AppSubTitulo,
			AppColorFondo = @AppColorFondo,
			AppColorTexto = @AppColorTexto,
			AppBannerInformativo = @AppBannerInformativo,
			AppOrden = @AppOrden,
			AppCantidadProductos = @AppCantidadProductos,
			FechaModificacion = GETDATE()
		WHERE ConfiguracionOfertasHomeAppID = @ConfiguracionOfertasHomeAppID
	END
	ELSE
	BEGIN
		INSERT INTO dbo.ConfiguracionOfertasHomeApp
		(
			ConfiguracionOfertasHomeID,
			AppActivo,
			AppTitulo,
			AppSubTitulo,
			AppColorFondo,
			AppColorTexto,
			AppBannerInformativo,
			AppOrden,
			AppCantidadProductos
		)
		VALUES
		(
			@ConfiguracionOfertasHomeID,
			@AppActivo,
			@AppTitulo,
			@AppSubTitulo,
			@AppColorFondo,
			@AppColorTexto,
			@AppBannerInformativo,
			@AppOrden,
			@AppCantidadProductos
		)
	END
END
GO

USE BelcorpEcuador
GO

IF (OBJECT_ID ( 'dbo.InsConfiguracionOfertasHomeApp', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.InsConfiguracionOfertasHomeApp AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.InsConfiguracionOfertasHomeApp
@ConfiguracionOfertasHomeAppID INT,
@ConfiguracionOfertasHomeID INT,
@AppActivo BIT,
@AppTitulo VARCHAR(250),
@AppColorFondo VARCHAR(10),
@AppColorTexto VARCHAR(10),
@AppBannerInformativo VARCHAR(250),
@AppOrden INT,
@AppCantidadProductos INT,
@AppSubTitulo VARCHAR(250)
AS
BEGIN
	IF EXISTS(SELECT 1 FROM dbo.ConfiguracionOfertasHomeApp (NOLOCK) WHERE ConfiguracionOfertasHomeAppID = @ConfiguracionOfertasHomeAppID)
	BEGIN
		UPDATE dbo.ConfiguracionOfertasHomeApp
		SET AppActivo = @AppActivo,
			AppTitulo = @AppTitulo,
			AppSubTitulo = @AppSubTitulo,
			AppColorFondo = @AppColorFondo,
			AppColorTexto = @AppColorTexto,
			AppBannerInformativo = @AppBannerInformativo,
			AppOrden = @AppOrden,
			AppCantidadProductos = @AppCantidadProductos,
			FechaModificacion = GETDATE()
		WHERE ConfiguracionOfertasHomeAppID = @ConfiguracionOfertasHomeAppID
	END
	ELSE
	BEGIN
		INSERT INTO dbo.ConfiguracionOfertasHomeApp
		(
			ConfiguracionOfertasHomeID,
			AppActivo,
			AppTitulo,
			AppSubTitulo,
			AppColorFondo,
			AppColorTexto,
			AppBannerInformativo,
			AppOrden,
			AppCantidadProductos
		)
		VALUES
		(
			@ConfiguracionOfertasHomeID,
			@AppActivo,
			@AppTitulo,
			@AppSubTitulo,
			@AppColorFondo,
			@AppColorTexto,
			@AppBannerInformativo,
			@AppOrden,
			@AppCantidadProductos
		)
	END
END
GO

USE BelcorpDominicana
GO

IF (OBJECT_ID ( 'dbo.InsConfiguracionOfertasHomeApp', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.InsConfiguracionOfertasHomeApp AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.InsConfiguracionOfertasHomeApp
@ConfiguracionOfertasHomeAppID INT,
@ConfiguracionOfertasHomeID INT,
@AppActivo BIT,
@AppTitulo VARCHAR(250),
@AppColorFondo VARCHAR(10),
@AppColorTexto VARCHAR(10),
@AppBannerInformativo VARCHAR(250),
@AppOrden INT,
@AppCantidadProductos INT,
@AppSubTitulo VARCHAR(250)
AS
BEGIN
	IF EXISTS(SELECT 1 FROM dbo.ConfiguracionOfertasHomeApp (NOLOCK) WHERE ConfiguracionOfertasHomeAppID = @ConfiguracionOfertasHomeAppID)
	BEGIN
		UPDATE dbo.ConfiguracionOfertasHomeApp
		SET AppActivo = @AppActivo,
			AppTitulo = @AppTitulo,
			AppSubTitulo = @AppSubTitulo,
			AppColorFondo = @AppColorFondo,
			AppColorTexto = @AppColorTexto,
			AppBannerInformativo = @AppBannerInformativo,
			AppOrden = @AppOrden,
			AppCantidadProductos = @AppCantidadProductos,
			FechaModificacion = GETDATE()
		WHERE ConfiguracionOfertasHomeAppID = @ConfiguracionOfertasHomeAppID
	END
	ELSE
	BEGIN
		INSERT INTO dbo.ConfiguracionOfertasHomeApp
		(
			ConfiguracionOfertasHomeID,
			AppActivo,
			AppTitulo,
			AppSubTitulo,
			AppColorFondo,
			AppColorTexto,
			AppBannerInformativo,
			AppOrden,
			AppCantidadProductos
		)
		VALUES
		(
			@ConfiguracionOfertasHomeID,
			@AppActivo,
			@AppTitulo,
			@AppSubTitulo,
			@AppColorFondo,
			@AppColorTexto,
			@AppBannerInformativo,
			@AppOrden,
			@AppCantidadProductos
		)
	END
END
GO

USE BelcorpCostaRica
GO

IF (OBJECT_ID ( 'dbo.InsConfiguracionOfertasHomeApp', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.InsConfiguracionOfertasHomeApp AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.InsConfiguracionOfertasHomeApp
@ConfiguracionOfertasHomeAppID INT,
@ConfiguracionOfertasHomeID INT,
@AppActivo BIT,
@AppTitulo VARCHAR(250),
@AppColorFondo VARCHAR(10),
@AppColorTexto VARCHAR(10),
@AppBannerInformativo VARCHAR(250),
@AppOrden INT,
@AppCantidadProductos INT,
@AppSubTitulo VARCHAR(250)
AS
BEGIN
	IF EXISTS(SELECT 1 FROM dbo.ConfiguracionOfertasHomeApp (NOLOCK) WHERE ConfiguracionOfertasHomeAppID = @ConfiguracionOfertasHomeAppID)
	BEGIN
		UPDATE dbo.ConfiguracionOfertasHomeApp
		SET AppActivo = @AppActivo,
			AppTitulo = @AppTitulo,
			AppSubTitulo = @AppSubTitulo,
			AppColorFondo = @AppColorFondo,
			AppColorTexto = @AppColorTexto,
			AppBannerInformativo = @AppBannerInformativo,
			AppOrden = @AppOrden,
			AppCantidadProductos = @AppCantidadProductos,
			FechaModificacion = GETDATE()
		WHERE ConfiguracionOfertasHomeAppID = @ConfiguracionOfertasHomeAppID
	END
	ELSE
	BEGIN
		INSERT INTO dbo.ConfiguracionOfertasHomeApp
		(
			ConfiguracionOfertasHomeID,
			AppActivo,
			AppTitulo,
			AppSubTitulo,
			AppColorFondo,
			AppColorTexto,
			AppBannerInformativo,
			AppOrden,
			AppCantidadProductos
		)
		VALUES
		(
			@ConfiguracionOfertasHomeID,
			@AppActivo,
			@AppTitulo,
			@AppSubTitulo,
			@AppColorFondo,
			@AppColorTexto,
			@AppBannerInformativo,
			@AppOrden,
			@AppCantidadProductos
		)
	END
END
GO

USE BelcorpChile
GO

IF (OBJECT_ID ( 'dbo.InsConfiguracionOfertasHomeApp', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.InsConfiguracionOfertasHomeApp AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.InsConfiguracionOfertasHomeApp
@ConfiguracionOfertasHomeAppID INT,
@ConfiguracionOfertasHomeID INT,
@AppActivo BIT,
@AppTitulo VARCHAR(250),
@AppColorFondo VARCHAR(10),
@AppColorTexto VARCHAR(10),
@AppBannerInformativo VARCHAR(250),
@AppOrden INT,
@AppCantidadProductos INT,
@AppSubTitulo VARCHAR(250)
AS
BEGIN
	IF EXISTS(SELECT 1 FROM dbo.ConfiguracionOfertasHomeApp (NOLOCK) WHERE ConfiguracionOfertasHomeAppID = @ConfiguracionOfertasHomeAppID)
	BEGIN
		UPDATE dbo.ConfiguracionOfertasHomeApp
		SET AppActivo = @AppActivo,
			AppTitulo = @AppTitulo,
			AppSubTitulo = @AppSubTitulo,
			AppColorFondo = @AppColorFondo,
			AppColorTexto = @AppColorTexto,
			AppBannerInformativo = @AppBannerInformativo,
			AppOrden = @AppOrden,
			AppCantidadProductos = @AppCantidadProductos,
			FechaModificacion = GETDATE()
		WHERE ConfiguracionOfertasHomeAppID = @ConfiguracionOfertasHomeAppID
	END
	ELSE
	BEGIN
		INSERT INTO dbo.ConfiguracionOfertasHomeApp
		(
			ConfiguracionOfertasHomeID,
			AppActivo,
			AppTitulo,
			AppSubTitulo,
			AppColorFondo,
			AppColorTexto,
			AppBannerInformativo,
			AppOrden,
			AppCantidadProductos
		)
		VALUES
		(
			@ConfiguracionOfertasHomeID,
			@AppActivo,
			@AppTitulo,
			@AppSubTitulo,
			@AppColorFondo,
			@AppColorTexto,
			@AppBannerInformativo,
			@AppOrden,
			@AppCantidadProductos
		)
	END
END
GO

USE BelcorpBolivia
GO

IF (OBJECT_ID ( 'dbo.InsConfiguracionOfertasHomeApp', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.InsConfiguracionOfertasHomeApp AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE dbo.InsConfiguracionOfertasHomeApp
@ConfiguracionOfertasHomeAppID INT,
@ConfiguracionOfertasHomeID INT,
@AppActivo BIT,
@AppTitulo VARCHAR(250),
@AppColorFondo VARCHAR(10),
@AppColorTexto VARCHAR(10),
@AppBannerInformativo VARCHAR(250),
@AppOrden INT,
@AppCantidadProductos INT,
@AppSubTitulo VARCHAR(250)
AS
BEGIN
	IF EXISTS(SELECT 1 FROM dbo.ConfiguracionOfertasHomeApp (NOLOCK) WHERE ConfiguracionOfertasHomeAppID = @ConfiguracionOfertasHomeAppID)
	BEGIN
		UPDATE dbo.ConfiguracionOfertasHomeApp
		SET AppActivo = @AppActivo,
			AppTitulo = @AppTitulo,
			AppSubTitulo = @AppSubTitulo,
			AppColorFondo = @AppColorFondo,
			AppColorTexto = @AppColorTexto,
			AppBannerInformativo = @AppBannerInformativo,
			AppOrden = @AppOrden,
			AppCantidadProductos = @AppCantidadProductos,
			FechaModificacion = GETDATE()
		WHERE ConfiguracionOfertasHomeAppID = @ConfiguracionOfertasHomeAppID
	END
	ELSE
	BEGIN
		INSERT INTO dbo.ConfiguracionOfertasHomeApp
		(
			ConfiguracionOfertasHomeID,
			AppActivo,
			AppTitulo,
			AppSubTitulo,
			AppColorFondo,
			AppColorTexto,
			AppBannerInformativo,
			AppOrden,
			AppCantidadProductos
		)
		VALUES
		(
			@ConfiguracionOfertasHomeID,
			@AppActivo,
			@AppTitulo,
			@AppSubTitulo,
			@AppColorFondo,
			@AppColorTexto,
			@AppBannerInformativo,
			@AppOrden,
			@AppCantidadProductos
		)
	END
END
GO

