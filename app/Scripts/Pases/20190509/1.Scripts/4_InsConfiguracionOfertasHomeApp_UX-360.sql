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
@AppSubTitulo VARCHAR(250),
@AppTextoBotonInicial VARCHAR(24) = NULL,
@AppTextoBotonFinal VARCHAR(24) = NULL,
@AppColorFondoBoton VARCHAR(10) = NULL,
@AppColorTextoBoton VARCHAR(10) = NULL
AS
BEGIN
	SET NOCOUNT ON
	
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
			AppTextoBotonInicial = @AppTextoBotonInicial,
			AppTextoBotonFinal = @AppTextoBotonFinal,
			AppColorFondoBoton = @AppColorFondoBoton,
			AppColorTextoBoton = @AppColorTextoBoton,
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
			AppCantidadProductos,
			AppTextoBotonInicial,
			AppTextoBotonFinal,
			AppColorFondoBoton,
			AppColorTextoBoton
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
			@AppCantidadProductos,
			@AppTextoBotonInicial,
			@AppTextoBotonFinal,
			@AppColorFondoBoton,
			@AppColorTextoBoton
		)
	END

	SET NOCOUNT OFF
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
@AppSubTitulo VARCHAR(250),
@AppTextoBotonInicial VARCHAR(24) = NULL,
@AppTextoBotonFinal VARCHAR(24) = NULL,
@AppColorFondoBoton VARCHAR(10) = NULL,
@AppColorTextoBoton VARCHAR(10) = NULL
AS
BEGIN
	SET NOCOUNT ON
	
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
			AppTextoBotonInicial = @AppTextoBotonInicial,
			AppTextoBotonFinal = @AppTextoBotonFinal,
			AppColorFondoBoton = @AppColorFondoBoton,
			AppColorTextoBoton = @AppColorTextoBoton,
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
			AppCantidadProductos,
			AppTextoBotonInicial,
			AppTextoBotonFinal,
			AppColorFondoBoton,
			AppColorTextoBoton
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
			@AppCantidadProductos,
			@AppTextoBotonInicial,
			@AppTextoBotonFinal,
			@AppColorFondoBoton,
			@AppColorTextoBoton
		)
	END

	SET NOCOUNT OFF
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
@AppSubTitulo VARCHAR(250),
@AppTextoBotonInicial VARCHAR(24) = NULL,
@AppTextoBotonFinal VARCHAR(24) = NULL,
@AppColorFondoBoton VARCHAR(10) = NULL,
@AppColorTextoBoton VARCHAR(10) = NULL
AS
BEGIN
	SET NOCOUNT ON
	
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
			AppTextoBotonInicial = @AppTextoBotonInicial,
			AppTextoBotonFinal = @AppTextoBotonFinal,
			AppColorFondoBoton = @AppColorFondoBoton,
			AppColorTextoBoton = @AppColorTextoBoton,
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
			AppCantidadProductos,
			AppTextoBotonInicial,
			AppTextoBotonFinal,
			AppColorFondoBoton,
			AppColorTextoBoton
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
			@AppCantidadProductos,
			@AppTextoBotonInicial,
			@AppTextoBotonFinal,
			@AppColorFondoBoton,
			@AppColorTextoBoton
		)
	END

	SET NOCOUNT OFF
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
@AppSubTitulo VARCHAR(250),
@AppTextoBotonInicial VARCHAR(24) = NULL,
@AppTextoBotonFinal VARCHAR(24) = NULL,
@AppColorFondoBoton VARCHAR(10) = NULL,
@AppColorTextoBoton VARCHAR(10) = NULL
AS
BEGIN
	SET NOCOUNT ON
	
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
			AppTextoBotonInicial = @AppTextoBotonInicial,
			AppTextoBotonFinal = @AppTextoBotonFinal,
			AppColorFondoBoton = @AppColorFondoBoton,
			AppColorTextoBoton = @AppColorTextoBoton,
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
			AppCantidadProductos,
			AppTextoBotonInicial,
			AppTextoBotonFinal,
			AppColorFondoBoton,
			AppColorTextoBoton
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
			@AppCantidadProductos,
			@AppTextoBotonInicial,
			@AppTextoBotonFinal,
			@AppColorFondoBoton,
			@AppColorTextoBoton
		)
	END

	SET NOCOUNT OFF
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
@AppSubTitulo VARCHAR(250),
@AppTextoBotonInicial VARCHAR(24) = NULL,
@AppTextoBotonFinal VARCHAR(24) = NULL,
@AppColorFondoBoton VARCHAR(10) = NULL,
@AppColorTextoBoton VARCHAR(10) = NULL
AS
BEGIN
	SET NOCOUNT ON
	
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
			AppTextoBotonInicial = @AppTextoBotonInicial,
			AppTextoBotonFinal = @AppTextoBotonFinal,
			AppColorFondoBoton = @AppColorFondoBoton,
			AppColorTextoBoton = @AppColorTextoBoton,
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
			AppCantidadProductos,
			AppTextoBotonInicial,
			AppTextoBotonFinal,
			AppColorFondoBoton,
			AppColorTextoBoton
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
			@AppCantidadProductos,
			@AppTextoBotonInicial,
			@AppTextoBotonFinal,
			@AppColorFondoBoton,
			@AppColorTextoBoton
		)
	END

	SET NOCOUNT OFF
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
@AppSubTitulo VARCHAR(250),
@AppTextoBotonInicial VARCHAR(24) = NULL,
@AppTextoBotonFinal VARCHAR(24) = NULL,
@AppColorFondoBoton VARCHAR(10) = NULL,
@AppColorTextoBoton VARCHAR(10) = NULL
AS
BEGIN
	SET NOCOUNT ON
	
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
			AppTextoBotonInicial = @AppTextoBotonInicial,
			AppTextoBotonFinal = @AppTextoBotonFinal,
			AppColorFondoBoton = @AppColorFondoBoton,
			AppColorTextoBoton = @AppColorTextoBoton,
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
			AppCantidadProductos,
			AppTextoBotonInicial,
			AppTextoBotonFinal,
			AppColorFondoBoton,
			AppColorTextoBoton
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
			@AppCantidadProductos,
			@AppTextoBotonInicial,
			@AppTextoBotonFinal,
			@AppColorFondoBoton,
			@AppColorTextoBoton
		)
	END

	SET NOCOUNT OFF
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
@AppSubTitulo VARCHAR(250),
@AppTextoBotonInicial VARCHAR(24) = NULL,
@AppTextoBotonFinal VARCHAR(24) = NULL,
@AppColorFondoBoton VARCHAR(10) = NULL,
@AppColorTextoBoton VARCHAR(10) = NULL
AS
BEGIN
	SET NOCOUNT ON
	
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
			AppTextoBotonInicial = @AppTextoBotonInicial,
			AppTextoBotonFinal = @AppTextoBotonFinal,
			AppColorFondoBoton = @AppColorFondoBoton,
			AppColorTextoBoton = @AppColorTextoBoton,
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
			AppCantidadProductos,
			AppTextoBotonInicial,
			AppTextoBotonFinal,
			AppColorFondoBoton,
			AppColorTextoBoton
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
			@AppCantidadProductos,
			@AppTextoBotonInicial,
			@AppTextoBotonFinal,
			@AppColorFondoBoton,
			@AppColorTextoBoton
		)
	END

	SET NOCOUNT OFF
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
@AppSubTitulo VARCHAR(250),
@AppTextoBotonInicial VARCHAR(24) = NULL,
@AppTextoBotonFinal VARCHAR(24) = NULL,
@AppColorFondoBoton VARCHAR(10) = NULL,
@AppColorTextoBoton VARCHAR(10) = NULL
AS
BEGIN
	SET NOCOUNT ON
	
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
			AppTextoBotonInicial = @AppTextoBotonInicial,
			AppTextoBotonFinal = @AppTextoBotonFinal,
			AppColorFondoBoton = @AppColorFondoBoton,
			AppColorTextoBoton = @AppColorTextoBoton,
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
			AppCantidadProductos,
			AppTextoBotonInicial,
			AppTextoBotonFinal,
			AppColorFondoBoton,
			AppColorTextoBoton
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
			@AppCantidadProductos,
			@AppTextoBotonInicial,
			@AppTextoBotonFinal,
			@AppColorFondoBoton,
			@AppColorTextoBoton
		)
	END

	SET NOCOUNT OFF
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
@AppSubTitulo VARCHAR(250),
@AppTextoBotonInicial VARCHAR(24) = NULL,
@AppTextoBotonFinal VARCHAR(24) = NULL,
@AppColorFondoBoton VARCHAR(10) = NULL,
@AppColorTextoBoton VARCHAR(10) = NULL
AS
BEGIN
	SET NOCOUNT ON
	
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
			AppTextoBotonInicial = @AppTextoBotonInicial,
			AppTextoBotonFinal = @AppTextoBotonFinal,
			AppColorFondoBoton = @AppColorFondoBoton,
			AppColorTextoBoton = @AppColorTextoBoton,
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
			AppCantidadProductos,
			AppTextoBotonInicial,
			AppTextoBotonFinal,
			AppColorFondoBoton,
			AppColorTextoBoton
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
			@AppCantidadProductos,
			@AppTextoBotonInicial,
			@AppTextoBotonFinal,
			@AppColorFondoBoton,
			@AppColorTextoBoton
		)
	END

	SET NOCOUNT OFF
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
@AppSubTitulo VARCHAR(250),
@AppTextoBotonInicial VARCHAR(24) = NULL,
@AppTextoBotonFinal VARCHAR(24) = NULL,
@AppColorFondoBoton VARCHAR(10) = NULL,
@AppColorTextoBoton VARCHAR(10) = NULL
AS
BEGIN
	SET NOCOUNT ON
	
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
			AppTextoBotonInicial = @AppTextoBotonInicial,
			AppTextoBotonFinal = @AppTextoBotonFinal,
			AppColorFondoBoton = @AppColorFondoBoton,
			AppColorTextoBoton = @AppColorTextoBoton,
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
			AppCantidadProductos,
			AppTextoBotonInicial,
			AppTextoBotonFinal,
			AppColorFondoBoton,
			AppColorTextoBoton
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
			@AppCantidadProductos,
			@AppTextoBotonInicial,
			@AppTextoBotonFinal,
			@AppColorFondoBoton,
			@AppColorTextoBoton
		)
	END

	SET NOCOUNT OFF
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
@AppSubTitulo VARCHAR(250),
@AppTextoBotonInicial VARCHAR(24) = NULL,
@AppTextoBotonFinal VARCHAR(24) = NULL,
@AppColorFondoBoton VARCHAR(10) = NULL,
@AppColorTextoBoton VARCHAR(10) = NULL
AS
BEGIN
	SET NOCOUNT ON
	
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
			AppTextoBotonInicial = @AppTextoBotonInicial,
			AppTextoBotonFinal = @AppTextoBotonFinal,
			AppColorFondoBoton = @AppColorFondoBoton,
			AppColorTextoBoton = @AppColorTextoBoton,
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
			AppCantidadProductos,
			AppTextoBotonInicial,
			AppTextoBotonFinal,
			AppColorFondoBoton,
			AppColorTextoBoton
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
			@AppCantidadProductos,
			@AppTextoBotonInicial,
			@AppTextoBotonFinal,
			@AppColorFondoBoton,
			@AppColorTextoBoton
		)
	END

	SET NOCOUNT OFF
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
@AppSubTitulo VARCHAR(250),
@AppTextoBotonInicial VARCHAR(24) = NULL,
@AppTextoBotonFinal VARCHAR(24) = NULL,
@AppColorFondoBoton VARCHAR(10) = NULL,
@AppColorTextoBoton VARCHAR(10) = NULL
AS
BEGIN
	SET NOCOUNT ON
	
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
			AppTextoBotonInicial = @AppTextoBotonInicial,
			AppTextoBotonFinal = @AppTextoBotonFinal,
			AppColorFondoBoton = @AppColorFondoBoton,
			AppColorTextoBoton = @AppColorTextoBoton,
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
			AppCantidadProductos,
			AppTextoBotonInicial,
			AppTextoBotonFinal,
			AppColorFondoBoton,
			AppColorTextoBoton
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
			@AppCantidadProductos,
			@AppTextoBotonInicial,
			@AppTextoBotonFinal,
			@AppColorFondoBoton,
			@AppColorTextoBoton
		)
	END

	SET NOCOUNT OFF
END
GO

