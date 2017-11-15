USE BelcorpPeru
GO

IF EXISTS (SELECT 1 FROM ConfiguracionPais WHERE Codigo = 'DES-NAV')
BEGIN
	DECLARE @ConfiguracionPaisID INT = 0
	DECLARE @MobileOrden INT = 0
	DECLARE @MobileOrdenBPT INT = 0
	DECLARE @MobileOrden2 INT = 0
	DECLARE @MobileOrdenBpt2 INT = 0


	SELECT @ConfiguracionPaisID = ConfiguracionPaisID FROM ConfiguracionPais WHERE Codigo = 'DES-NAV'

	select @MobileOrden = max(MobileOrden) + 1 from ConfiguracionPais
	select @MobileOrdenBPT = max(MobileOrdenBPT) + 1 from ConfiguracionPais
	select @MobileOrden2 = max(MobileOrden) + 1 from ConfiguracionOfertasHome
	select @MobileOrdenBpt2 = max(MobileOrdenBpt) + 1 from ConfiguracionOfertasHome


	UPDATE [dbo].[ConfiguracionPais] SET MobileTituloMenu = 'Descarga e Imprime', MobileOrden = @MobileOrden, MobileOrdenBPT = @MobileOrdenBPT where Codigo = 'DES-NAV'
	UPDATE [dbo].[ConfiguracionOfertasHome] SET MobileOrden = @MobileOrden2, MobileTitulo = 'Descarga e Imprime', MobileTipoPresentacion = 7, MobileActivo = 1, MobileOrdenBpt = @MobileOrdenBpt2 where ConfiguracionPaisID = @ConfiguracionPaisID
END
GO

USE BelcorpSalvador
GO

IF EXISTS (SELECT 1 FROM ConfiguracionPais WHERE Codigo = 'DES-NAV')
BEGIN
	DECLARE @ConfiguracionPaisID INT = 0
	DECLARE @MobileOrden INT = 0
	DECLARE @MobileOrdenBPT INT = 0
	DECLARE @MobileOrden2 INT = 0
	DECLARE @MobileOrdenBpt2 INT = 0


	SELECT @ConfiguracionPaisID = ConfiguracionPaisID FROM ConfiguracionPais WHERE Codigo = 'DES-NAV'

	select @MobileOrden = max(MobileOrden) + 1 from ConfiguracionPais
	select @MobileOrdenBPT = max(MobileOrdenBPT) + 1 from ConfiguracionPais
	select @MobileOrden2 = max(MobileOrden) + 1 from ConfiguracionOfertasHome
	select @MobileOrdenBpt2 = max(MobileOrdenBpt) + 1 from ConfiguracionOfertasHome


	UPDATE [dbo].[ConfiguracionPais] SET MobileTituloMenu = 'Descarga e Imprime', MobileOrden = @MobileOrden, MobileOrdenBPT = @MobileOrdenBPT where Codigo = 'DES-NAV'
	UPDATE [dbo].[ConfiguracionOfertasHome] SET MobileOrden = @MobileOrden2, MobileTitulo = 'Descarga e Imprime', MobileTipoPresentacion = 7, MobileActivo = 1, MobileOrdenBpt = @MobileOrdenBpt2 where ConfiguracionPaisID = @ConfiguracionPaisID
END
GO

USE BelcorpPuertoRico
GO

IF EXISTS (SELECT 1 FROM ConfiguracionPais WHERE Codigo = 'DES-NAV')
BEGIN
	DECLARE @ConfiguracionPaisID INT = 0
	DECLARE @MobileOrden INT = 0
	DECLARE @MobileOrdenBPT INT = 0
	DECLARE @MobileOrden2 INT = 0
	DECLARE @MobileOrdenBpt2 INT = 0


	SELECT @ConfiguracionPaisID = ConfiguracionPaisID FROM ConfiguracionPais WHERE Codigo = 'DES-NAV'

	select @MobileOrden = max(MobileOrden) + 1 from ConfiguracionPais
	select @MobileOrdenBPT = max(MobileOrdenBPT) + 1 from ConfiguracionPais
	select @MobileOrden2 = max(MobileOrden) + 1 from ConfiguracionOfertasHome
	select @MobileOrdenBpt2 = max(MobileOrdenBpt) + 1 from ConfiguracionOfertasHome


	UPDATE [dbo].[ConfiguracionPais] SET MobileTituloMenu = 'Descarga e Imprime', MobileOrden = @MobileOrden, MobileOrdenBPT = @MobileOrdenBPT where Codigo = 'DES-NAV'
	UPDATE [dbo].[ConfiguracionOfertasHome] SET MobileOrden = @MobileOrden2, MobileTitulo = 'Descarga e Imprime', MobileTipoPresentacion = 7, MobileActivo = 1, MobileOrdenBpt = @MobileOrdenBpt2 where ConfiguracionPaisID = @ConfiguracionPaisID
END
GO

USE BelcorpPanama
GO

IF EXISTS (SELECT 1 FROM ConfiguracionPais WHERE Codigo = 'DES-NAV')
BEGIN
	DECLARE @ConfiguracionPaisID INT = 0
	DECLARE @MobileOrden INT = 0
	DECLARE @MobileOrdenBPT INT = 0
	DECLARE @MobileOrden2 INT = 0
	DECLARE @MobileOrdenBpt2 INT = 0


	SELECT @ConfiguracionPaisID = ConfiguracionPaisID FROM ConfiguracionPais WHERE Codigo = 'DES-NAV'

	select @MobileOrden = max(MobileOrden) + 1 from ConfiguracionPais
	select @MobileOrdenBPT = max(MobileOrdenBPT) + 1 from ConfiguracionPais
	select @MobileOrden2 = max(MobileOrden) + 1 from ConfiguracionOfertasHome
	select @MobileOrdenBpt2 = max(MobileOrdenBpt) + 1 from ConfiguracionOfertasHome


	UPDATE [dbo].[ConfiguracionPais] SET MobileTituloMenu = 'Descarga e Imprime', MobileOrden = @MobileOrden, MobileOrdenBPT = @MobileOrdenBPT where Codigo = 'DES-NAV'
	UPDATE [dbo].[ConfiguracionOfertasHome] SET MobileOrden = @MobileOrden2, MobileTitulo = 'Descarga e Imprime', MobileTipoPresentacion = 7, MobileActivo = 1, MobileOrdenBpt = @MobileOrdenBpt2 where ConfiguracionPaisID = @ConfiguracionPaisID
END
GO

USE BelcorpGuatemala
GO

IF EXISTS (SELECT 1 FROM ConfiguracionPais WHERE Codigo = 'DES-NAV')
BEGIN
	DECLARE @ConfiguracionPaisID INT = 0
	DECLARE @MobileOrden INT = 0
	DECLARE @MobileOrdenBPT INT = 0
	DECLARE @MobileOrden2 INT = 0
	DECLARE @MobileOrdenBpt2 INT = 0


	SELECT @ConfiguracionPaisID = ConfiguracionPaisID FROM ConfiguracionPais WHERE Codigo = 'DES-NAV'

	select @MobileOrden = max(MobileOrden) + 1 from ConfiguracionPais
	select @MobileOrdenBPT = max(MobileOrdenBPT) + 1 from ConfiguracionPais
	select @MobileOrden2 = max(MobileOrden) + 1 from ConfiguracionOfertasHome
	select @MobileOrdenBpt2 = max(MobileOrdenBpt) + 1 from ConfiguracionOfertasHome


	UPDATE [dbo].[ConfiguracionPais] SET MobileTituloMenu = 'Descarga e Imprime', MobileOrden = @MobileOrden, MobileOrdenBPT = @MobileOrdenBPT where Codigo = 'DES-NAV'
	UPDATE [dbo].[ConfiguracionOfertasHome] SET MobileOrden = @MobileOrden2, MobileTitulo = 'Descarga e Imprime', MobileTipoPresentacion = 7, MobileActivo = 1, MobileOrdenBpt = @MobileOrdenBpt2 where ConfiguracionPaisID = @ConfiguracionPaisID
END
GO

USE BelcorpEcuador
GO

IF EXISTS (SELECT 1 FROM ConfiguracionPais WHERE Codigo = 'DES-NAV')
BEGIN
	DECLARE @ConfiguracionPaisID INT = 0
	DECLARE @MobileOrden INT = 0
	DECLARE @MobileOrdenBPT INT = 0
	DECLARE @MobileOrden2 INT = 0
	DECLARE @MobileOrdenBpt2 INT = 0


	SELECT @ConfiguracionPaisID = ConfiguracionPaisID FROM ConfiguracionPais WHERE Codigo = 'DES-NAV'

	select @MobileOrden = max(MobileOrden) + 1 from ConfiguracionPais
	select @MobileOrdenBPT = max(MobileOrdenBPT) + 1 from ConfiguracionPais
	select @MobileOrden2 = max(MobileOrden) + 1 from ConfiguracionOfertasHome
	select @MobileOrdenBpt2 = max(MobileOrdenBpt) + 1 from ConfiguracionOfertasHome


	UPDATE [dbo].[ConfiguracionPais] SET MobileTituloMenu = 'Descarga e Imprime', MobileOrden = @MobileOrden, MobileOrdenBPT = @MobileOrdenBPT where Codigo = 'DES-NAV'
	UPDATE [dbo].[ConfiguracionOfertasHome] SET MobileOrden = @MobileOrden2, MobileTitulo = 'Descarga e Imprime', MobileTipoPresentacion = 7, MobileActivo = 1, MobileOrdenBpt = @MobileOrdenBpt2 where ConfiguracionPaisID = @ConfiguracionPaisID
END
GO

USE BelcorpDominicana
GO

IF EXISTS (SELECT 1 FROM ConfiguracionPais WHERE Codigo = 'DES-NAV')
BEGIN
	DECLARE @ConfiguracionPaisID INT = 0
	DECLARE @MobileOrden INT = 0
	DECLARE @MobileOrdenBPT INT = 0
	DECLARE @MobileOrden2 INT = 0
	DECLARE @MobileOrdenBpt2 INT = 0


	SELECT @ConfiguracionPaisID = ConfiguracionPaisID FROM ConfiguracionPais WHERE Codigo = 'DES-NAV'

	select @MobileOrden = max(MobileOrden) + 1 from ConfiguracionPais
	select @MobileOrdenBPT = max(MobileOrdenBPT) + 1 from ConfiguracionPais
	select @MobileOrden2 = max(MobileOrden) + 1 from ConfiguracionOfertasHome
	select @MobileOrdenBpt2 = max(MobileOrdenBpt) + 1 from ConfiguracionOfertasHome


	UPDATE [dbo].[ConfiguracionPais] SET MobileTituloMenu = 'Descarga e Imprime', MobileOrden = @MobileOrden, MobileOrdenBPT = @MobileOrdenBPT where Codigo = 'DES-NAV'
	UPDATE [dbo].[ConfiguracionOfertasHome] SET MobileOrden = @MobileOrden2, MobileTitulo = 'Descarga e Imprime', MobileTipoPresentacion = 7, MobileActivo = 1, MobileOrdenBpt = @MobileOrdenBpt2 where ConfiguracionPaisID = @ConfiguracionPaisID
END
GO

USE BelcorpCostaRica
GO

IF EXISTS (SELECT 1 FROM ConfiguracionPais WHERE Codigo = 'DES-NAV')
BEGIN
	DECLARE @ConfiguracionPaisID INT = 0
	DECLARE @MobileOrden INT = 0
	DECLARE @MobileOrdenBPT INT = 0
	DECLARE @MobileOrden2 INT = 0
	DECLARE @MobileOrdenBpt2 INT = 0


	SELECT @ConfiguracionPaisID = ConfiguracionPaisID FROM ConfiguracionPais WHERE Codigo = 'DES-NAV'

	select @MobileOrden = max(MobileOrden) + 1 from ConfiguracionPais
	select @MobileOrdenBPT = max(MobileOrdenBPT) + 1 from ConfiguracionPais
	select @MobileOrden2 = max(MobileOrden) + 1 from ConfiguracionOfertasHome
	select @MobileOrdenBpt2 = max(MobileOrdenBpt) + 1 from ConfiguracionOfertasHome


	UPDATE [dbo].[ConfiguracionPais] SET MobileTituloMenu = 'Descarga e Imprime', MobileOrden = @MobileOrden, MobileOrdenBPT = @MobileOrdenBPT where Codigo = 'DES-NAV'
	UPDATE [dbo].[ConfiguracionOfertasHome] SET MobileOrden = @MobileOrden2, MobileTitulo = 'Descarga e Imprime', MobileTipoPresentacion = 7, MobileActivo = 1, MobileOrdenBpt = @MobileOrdenBpt2 where ConfiguracionPaisID = @ConfiguracionPaisID
END
GO

USE BelcorpBolivia
GO

IF EXISTS (SELECT 1 FROM ConfiguracionPais WHERE Codigo = 'DES-NAV')
BEGIN
	DECLARE @ConfiguracionPaisID INT = 0
	DECLARE @MobileOrden INT = 0
	DECLARE @MobileOrdenBPT INT = 0
	DECLARE @MobileOrden2 INT = 0
	DECLARE @MobileOrdenBpt2 INT = 0


	SELECT @ConfiguracionPaisID = ConfiguracionPaisID FROM ConfiguracionPais WHERE Codigo = 'DES-NAV'

	select @MobileOrden = max(MobileOrden) + 1 from ConfiguracionPais
	select @MobileOrdenBPT = max(MobileOrdenBPT) + 1 from ConfiguracionPais
	select @MobileOrden2 = max(MobileOrden) + 1 from ConfiguracionOfertasHome
	select @MobileOrdenBpt2 = max(MobileOrdenBpt) + 1 from ConfiguracionOfertasHome


	UPDATE [dbo].[ConfiguracionPais] SET MobileTituloMenu = 'Descarga e Imprime', MobileOrden = @MobileOrden, MobileOrdenBPT = @MobileOrdenBPT where Codigo = 'DES-NAV'
	UPDATE [dbo].[ConfiguracionOfertasHome] SET MobileOrden = @MobileOrden2, MobileTitulo = 'Descarga e Imprime', MobileTipoPresentacion = 7, MobileActivo = 1, MobileOrdenBpt = @MobileOrdenBpt2 where ConfiguracionPaisID = @ConfiguracionPaisID
END
GO

