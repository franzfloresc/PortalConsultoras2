USE BelcorpPeru
GO

IF EXISTS (SELECT 1 FROM ConfiguracionPais WHERE Codigo = 'DES-NAV')
BEGIN
	DECLARE @ConfiguracionPaisID INT = 0
	SELECT @ConfiguracionPaisID = ConfiguracionPaisID FROM ConfiguracionPais WHERE Codigo = 'DES-NAV'

	UPDATE [dbo].[ConfiguracionPais] SET MobileTituloMenu = 'Descarga e Imprime', MobileOrden = 7, MobileOrdenBPT = 7 where Codigo = 'DES-NAV'
	UPDATE [dbo].[ConfiguracionOfertasHome] SET MobileOrden = 7, MobileTitulo = 'Descarga e Imprime', MobileTipoPresentacion = 7, MobileActivo = 1, MobileOrdenBpt = 100 where ConfiguracionPaisID = @ConfiguracionPaisID
END
GO

USE BelcorpMexico
GO

IF EXISTS (SELECT 1 FROM ConfiguracionPais WHERE Codigo = 'DES-NAV')
BEGIN
	DECLARE @ConfiguracionPaisID INT = 0
	SELECT @ConfiguracionPaisID = ConfiguracionPaisID FROM ConfiguracionPais WHERE Codigo = 'DES-NAV'

	UPDATE [dbo].[ConfiguracionPais] SET MobileTituloMenu = 'Descarga e Imprime', MobileOrden = 7, MobileOrdenBPT = 7 where Codigo = 'DES-NAV'
	UPDATE [dbo].[ConfiguracionOfertasHome] SET MobileOrden = 7, MobileTitulo = 'Descarga e Imprime', MobileTipoPresentacion = 7, MobileActivo = 1, MobileOrdenBpt = 100 where ConfiguracionPaisID = @ConfiguracionPaisID
END
GO

USE BelcorpSalvador
GO

IF EXISTS (SELECT 1 FROM ConfiguracionPais WHERE Codigo = 'DES-NAV')
BEGIN
	DECLARE @ConfiguracionPaisID INT = 0
	SELECT @ConfiguracionPaisID = ConfiguracionPaisID FROM ConfiguracionPais WHERE Codigo = 'DES-NAV'

	UPDATE [dbo].[ConfiguracionPais] SET MobileTituloMenu = 'Descarga e Imprime', MobileOrden = 7, MobileOrdenBPT = 7 where Codigo = 'DES-NAV'
	UPDATE [dbo].[ConfiguracionOfertasHome] SET MobileOrden = 7, MobileTitulo = 'Descarga e Imprime', MobileTipoPresentacion = 7, MobileActivo = 1, MobileOrdenBpt = 100 where ConfiguracionPaisID = @ConfiguracionPaisID
END
GO

USE BelcorpPuertoRico
GO

IF EXISTS (SELECT 1 FROM ConfiguracionPais WHERE Codigo = 'DES-NAV')
BEGIN
	DECLARE @ConfiguracionPaisID INT = 0
	SELECT @ConfiguracionPaisID = ConfiguracionPaisID FROM ConfiguracionPais WHERE Codigo = 'DES-NAV'

	UPDATE [dbo].[ConfiguracionPais] SET MobileTituloMenu = 'Descarga e Imprime', MobileOrden = 7, MobileOrdenBPT = 7 where Codigo = 'DES-NAV'
	UPDATE [dbo].[ConfiguracionOfertasHome] SET MobileOrden = 7, MobileTitulo = 'Descarga e Imprime', MobileTipoPresentacion = 7, MobileActivo = 1, MobileOrdenBpt = 100 where ConfiguracionPaisID = @ConfiguracionPaisID
END
GO

USE BelcorpPanama
GO

IF EXISTS (SELECT 1 FROM ConfiguracionPais WHERE Codigo = 'DES-NAV')
BEGIN
	DECLARE @ConfiguracionPaisID INT = 0
	SELECT @ConfiguracionPaisID = ConfiguracionPaisID FROM ConfiguracionPais WHERE Codigo = 'DES-NAV'

	UPDATE [dbo].[ConfiguracionPais] SET MobileTituloMenu = 'Descarga e Imprime', MobileOrden = 7, MobileOrdenBPT = 7 where Codigo = 'DES-NAV'
	UPDATE [dbo].[ConfiguracionOfertasHome] SET MobileOrden = 7, MobileTitulo = 'Descarga e Imprime', MobileTipoPresentacion = 7, MobileActivo = 1, MobileOrdenBpt = 100 where ConfiguracionPaisID = @ConfiguracionPaisID
END
GO

USE BelcorpGuatemala
GO

IF EXISTS (SELECT 1 FROM ConfiguracionPais WHERE Codigo = 'DES-NAV')
BEGIN
	DECLARE @ConfiguracionPaisID INT = 0
	SELECT @ConfiguracionPaisID = ConfiguracionPaisID FROM ConfiguracionPais WHERE Codigo = 'DES-NAV'

	UPDATE [dbo].[ConfiguracionPais] SET MobileTituloMenu = 'Descarga e Imprime', MobileOrden = 7, MobileOrdenBPT = 7 where Codigo = 'DES-NAV'
	UPDATE [dbo].[ConfiguracionOfertasHome] SET MobileOrden = 7, MobileTitulo = 'Descarga e Imprime', MobileTipoPresentacion = 7, MobileActivo = 1, MobileOrdenBpt = 100 where ConfiguracionPaisID = @ConfiguracionPaisID
END
GO

USE BelcorpEcuador
GO

IF EXISTS (SELECT 1 FROM ConfiguracionPais WHERE Codigo = 'DES-NAV')
BEGIN
	DECLARE @ConfiguracionPaisID INT = 0
	SELECT @ConfiguracionPaisID = ConfiguracionPaisID FROM ConfiguracionPais WHERE Codigo = 'DES-NAV'

	UPDATE [dbo].[ConfiguracionPais] SET MobileTituloMenu = 'Descarga e Imprime', MobileOrden = 7, MobileOrdenBPT = 7 where Codigo = 'DES-NAV'
	UPDATE [dbo].[ConfiguracionOfertasHome] SET MobileOrden = 7, MobileTitulo = 'Descarga e Imprime', MobileTipoPresentacion = 7, MobileActivo = 1, MobileOrdenBpt = 100 where ConfiguracionPaisID = @ConfiguracionPaisID
END
GO

USE BelcorpDominicana
GO

IF EXISTS (SELECT 1 FROM ConfiguracionPais WHERE Codigo = 'DES-NAV')
BEGIN
	DECLARE @ConfiguracionPaisID INT = 0
	SELECT @ConfiguracionPaisID = ConfiguracionPaisID FROM ConfiguracionPais WHERE Codigo = 'DES-NAV'

	UPDATE [dbo].[ConfiguracionPais] SET MobileTituloMenu = 'Descarga e Imprime', MobileOrden = 7, MobileOrdenBPT = 7 where Codigo = 'DES-NAV'
	UPDATE [dbo].[ConfiguracionOfertasHome] SET MobileOrden = 7, MobileTitulo = 'Descarga e Imprime', MobileTipoPresentacion = 7, MobileActivo = 1, MobileOrdenBpt = 100 where ConfiguracionPaisID = @ConfiguracionPaisID
END
GO

USE BelcorpCostaRica
GO

IF EXISTS (SELECT 1 FROM ConfiguracionPais WHERE Codigo = 'DES-NAV')
BEGIN
	DECLARE @ConfiguracionPaisID INT = 0
	SELECT @ConfiguracionPaisID = ConfiguracionPaisID FROM ConfiguracionPais WHERE Codigo = 'DES-NAV'

	UPDATE [dbo].[ConfiguracionPais] SET MobileTituloMenu = 'Descarga e Imprime', MobileOrden = 7, MobileOrdenBPT = 7 where Codigo = 'DES-NAV'
	UPDATE [dbo].[ConfiguracionOfertasHome] SET MobileOrden = 7, MobileTitulo = 'Descarga e Imprime', MobileTipoPresentacion = 7, MobileActivo = 1, MobileOrdenBpt = 100 where ConfiguracionPaisID = @ConfiguracionPaisID
END
GO

USE BelcorpBolivia
GO

IF EXISTS (SELECT 1 FROM ConfiguracionPais WHERE Codigo = 'DES-NAV')
BEGIN
	DECLARE @ConfiguracionPaisID INT = 0
	SELECT @ConfiguracionPaisID = ConfiguracionPaisID FROM ConfiguracionPais WHERE Codigo = 'DES-NAV'

	UPDATE [dbo].[ConfiguracionPais] SET MobileTituloMenu = 'Descarga e Imprime', MobileOrden = 7, MobileOrdenBPT = 7 where Codigo = 'DES-NAV'
	UPDATE [dbo].[ConfiguracionOfertasHome] SET MobileOrden = 7, MobileTitulo = 'Descarga e Imprime', MobileTipoPresentacion = 7, MobileActivo = 1, MobileOrdenBpt = 100 where ConfiguracionPaisID = @ConfiguracionPaisID
END
GO

