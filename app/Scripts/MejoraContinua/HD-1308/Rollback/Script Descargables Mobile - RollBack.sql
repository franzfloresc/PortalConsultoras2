USE BelcorpPeru
GO

IF EXISTS (SELECT 1 FROM ConfiguracionPais WHERE Codigo = 'DES-NAV')
BEGIN
	DECLARE @ConfiguracionPaisID INT = 0
	SELECT @ConfiguracionPaisID = ConfiguracionPaisID FROM ConfiguracionPais WHERE Codigo = 'DES-NAV'

	UPDATE [dbo].[ConfiguracionPais] SET MobileTituloMenu = NULL, MobileOrden = 0, MobileOrdenBPT = 0 where Codigo = 'DES-NAV'
	UPDATE [dbo].[ConfiguracionOfertasHome] SET MobileOrden = 0, MobileTitulo = NULL, MobileTipoPresentacion = 0, MobileActivo = 0, MobileOrdenBpt = 0 where ConfiguracionPaisID = @ConfiguracionPaisID
END
GO

USE BelcorpMexico
GO

IF EXISTS (SELECT 1 FROM ConfiguracionPais WHERE Codigo = 'DES-NAV')
BEGIN
	DECLARE @ConfiguracionPaisID INT = 0
	SELECT @ConfiguracionPaisID = ConfiguracionPaisID FROM ConfiguracionPais WHERE Codigo = 'DES-NAV'

	UPDATE [dbo].[ConfiguracionPais] SET MobileTituloMenu = NULL, MobileOrden = 0, MobileOrdenBPT = 0 where Codigo = 'DES-NAV'
	UPDATE [dbo].[ConfiguracionOfertasHome] SET MobileOrden = 0, MobileTitulo = NULL, MobileTipoPresentacion = 0, MobileActivo = 0, MobileOrdenBpt = 0 where ConfiguracionPaisID = @ConfiguracionPaisID
END
GO

USE BelcorpSalvador
GO

IF EXISTS (SELECT 1 FROM ConfiguracionPais WHERE Codigo = 'DES-NAV')
BEGIN
	DECLARE @ConfiguracionPaisID INT = 0
	SELECT @ConfiguracionPaisID = ConfiguracionPaisID FROM ConfiguracionPais WHERE Codigo = 'DES-NAV'

	UPDATE [dbo].[ConfiguracionPais] SET MobileTituloMenu = NULL, MobileOrden = 0, MobileOrdenBPT = 0 where Codigo = 'DES-NAV'
	UPDATE [dbo].[ConfiguracionOfertasHome] SET MobileOrden = 0, MobileTitulo = NULL, MobileTipoPresentacion = 0, MobileActivo = 0, MobileOrdenBpt = 0 where ConfiguracionPaisID = @ConfiguracionPaisID
END
GO

USE BelcorpPuertoRico
GO

IF EXISTS (SELECT 1 FROM ConfiguracionPais WHERE Codigo = 'DES-NAV')
BEGIN
	DECLARE @ConfiguracionPaisID INT = 0
	SELECT @ConfiguracionPaisID = ConfiguracionPaisID FROM ConfiguracionPais WHERE Codigo = 'DES-NAV'

	UPDATE [dbo].[ConfiguracionPais] SET MobileTituloMenu = NULL, MobileOrden = 0, MobileOrdenBPT = 0 where Codigo = 'DES-NAV'
	UPDATE [dbo].[ConfiguracionOfertasHome] SET MobileOrden = 0, MobileTitulo = NULL, MobileTipoPresentacion = 0, MobileActivo = 0, MobileOrdenBpt = 0 where ConfiguracionPaisID = @ConfiguracionPaisID
END
GO

USE BelcorpPanama
GO

IF EXISTS (SELECT 1 FROM ConfiguracionPais WHERE Codigo = 'DES-NAV')
BEGIN
	DECLARE @ConfiguracionPaisID INT = 0
	SELECT @ConfiguracionPaisID = ConfiguracionPaisID FROM ConfiguracionPais WHERE Codigo = 'DES-NAV'

	UPDATE [dbo].[ConfiguracionPais] SET MobileTituloMenu = NULL, MobileOrden = 0, MobileOrdenBPT = 0 where Codigo = 'DES-NAV'
	UPDATE [dbo].[ConfiguracionOfertasHome] SET MobileOrden = 0, MobileTitulo = NULL, MobileTipoPresentacion = 0, MobileActivo = 0, MobileOrdenBpt = 0 where ConfiguracionPaisID = @ConfiguracionPaisID
END
GO

USE BelcorpGuatemala
GO

IF EXISTS (SELECT 1 FROM ConfiguracionPais WHERE Codigo = 'DES-NAV')
BEGIN
	DECLARE @ConfiguracionPaisID INT = 0
	SELECT @ConfiguracionPaisID = ConfiguracionPaisID FROM ConfiguracionPais WHERE Codigo = 'DES-NAV'

	UPDATE [dbo].[ConfiguracionPais] SET MobileTituloMenu = NULL, MobileOrden = 0, MobileOrdenBPT = 0 where Codigo = 'DES-NAV'
	UPDATE [dbo].[ConfiguracionOfertasHome] SET MobileOrden = 0, MobileTitulo = NULL, MobileTipoPresentacion = 0, MobileActivo = 0, MobileOrdenBpt = 0 where ConfiguracionPaisID = @ConfiguracionPaisID
END
GO

USE BelcorpEcuador
GO

IF EXISTS (SELECT 1 FROM ConfiguracionPais WHERE Codigo = 'DES-NAV')
BEGIN
	DECLARE @ConfiguracionPaisID INT = 0
	SELECT @ConfiguracionPaisID = ConfiguracionPaisID FROM ConfiguracionPais WHERE Codigo = 'DES-NAV'

	UPDATE [dbo].[ConfiguracionPais] SET MobileTituloMenu = NULL, MobileOrden = 0, MobileOrdenBPT = 0 where Codigo = 'DES-NAV'
	UPDATE [dbo].[ConfiguracionOfertasHome] SET MobileOrden = 0, MobileTitulo = NULL, MobileTipoPresentacion = 0, MobileActivo = 0, MobileOrdenBpt = 0 where ConfiguracionPaisID = @ConfiguracionPaisID
END
GO

USE BelcorpDominicana
GO

IF EXISTS (SELECT 1 FROM ConfiguracionPais WHERE Codigo = 'DES-NAV')
BEGIN
	DECLARE @ConfiguracionPaisID INT = 0
	SELECT @ConfiguracionPaisID = ConfiguracionPaisID FROM ConfiguracionPais WHERE Codigo = 'DES-NAV'

	UPDATE [dbo].[ConfiguracionPais] SET MobileTituloMenu = NULL, MobileOrden = 0, MobileOrdenBPT = 0 where Codigo = 'DES-NAV'
	UPDATE [dbo].[ConfiguracionOfertasHome] SET MobileOrden = 0, MobileTitulo = NULL, MobileTipoPresentacion = 0, MobileActivo = 0, MobileOrdenBpt = 0 where ConfiguracionPaisID = @ConfiguracionPaisID
END
GO

USE BelcorpCostaRica
GO

IF EXISTS (SELECT 1 FROM ConfiguracionPais WHERE Codigo = 'DES-NAV')
BEGIN
	DECLARE @ConfiguracionPaisID INT = 0
	SELECT @ConfiguracionPaisID = ConfiguracionPaisID FROM ConfiguracionPais WHERE Codigo = 'DES-NAV'

	UPDATE [dbo].[ConfiguracionPais] SET MobileTituloMenu = NULL, MobileOrden = 0, MobileOrdenBPT = 0 where Codigo = 'DES-NAV'
	UPDATE [dbo].[ConfiguracionOfertasHome] SET MobileOrden = 0, MobileTitulo = NULL, MobileTipoPresentacion = 0, MobileActivo = 0, MobileOrdenBpt = 0 where ConfiguracionPaisID = @ConfiguracionPaisID
END
GO

USE BelcorpBolivia
GO

IF EXISTS (SELECT 1 FROM ConfiguracionPais WHERE Codigo = 'DES-NAV')
BEGIN
	DECLARE @ConfiguracionPaisID INT = 0
	SELECT @ConfiguracionPaisID = ConfiguracionPaisID FROM ConfiguracionPais WHERE Codigo = 'DES-NAV'

	UPDATE [dbo].[ConfiguracionPais] SET MobileTituloMenu = NULL, MobileOrden = 0, MobileOrdenBPT = 0 where Codigo = 'DES-NAV'
	UPDATE [dbo].[ConfiguracionOfertasHome] SET MobileOrden = 0, MobileTitulo = NULL, MobileTipoPresentacion = 0, MobileActivo = 0, MobileOrdenBpt = 0 where ConfiguracionPaisID = @ConfiguracionPaisID
END
GO

