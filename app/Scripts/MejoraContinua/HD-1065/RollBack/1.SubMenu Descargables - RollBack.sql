USE BelcorpPeru
GO

IF EXISTS (SELECT 1 FROM ConfiguracionPais where Codigo = 'DES-NAV') 
BEGIN
	DECLARE @ConfiguracionPaisID INT 
	SELECT @ConfiguracionPaisID = ConfiguracionPaisID FROM ConfiguracionPais where Codigo = 'DES-NAV'

	DELETE FROM ConfiguracionPais where Codigo = 'DES-NAV'
	DELETE FROM ConfiguracionOfertasHome WHERE ConfiguracionPaisID = @ConfiguracionPaisID
END
GO

USE BelcorpSalvador
GO

IF EXISTS (SELECT 1 FROM ConfiguracionPais where Codigo = 'DES-NAV') 
BEGIN
	DECLARE @ConfiguracionPaisID INT 
	SELECT @ConfiguracionPaisID = ConfiguracionPaisID FROM ConfiguracionPais where Codigo = 'DES-NAV'

	DELETE FROM ConfiguracionPais where Codigo = 'DES-NAV'
	DELETE FROM ConfiguracionOfertasHome WHERE ConfiguracionPaisID = @ConfiguracionPaisID
END
GO

USE BelcorpPuertoRico
GO

IF EXISTS (SELECT 1 FROM ConfiguracionPais where Codigo = 'DES-NAV') 
BEGIN
	DECLARE @ConfiguracionPaisID INT 
	SELECT @ConfiguracionPaisID = ConfiguracionPaisID FROM ConfiguracionPais where Codigo = 'DES-NAV'

	DELETE FROM ConfiguracionPais where Codigo = 'DES-NAV'
	DELETE FROM ConfiguracionOfertasHome WHERE ConfiguracionPaisID = @ConfiguracionPaisID
END
GO

USE BelcorpPanama
GO

IF EXISTS (SELECT 1 FROM ConfiguracionPais where Codigo = 'DES-NAV') 
BEGIN
	DECLARE @ConfiguracionPaisID INT 
	SELECT @ConfiguracionPaisID = ConfiguracionPaisID FROM ConfiguracionPais where Codigo = 'DES-NAV'

	DELETE FROM ConfiguracionPais where Codigo = 'DES-NAV'
	DELETE FROM ConfiguracionOfertasHome WHERE ConfiguracionPaisID = @ConfiguracionPaisID
END
GO

USE BelcorpGuatemala
GO

IF EXISTS (SELECT 1 FROM ConfiguracionPais where Codigo = 'DES-NAV') 
BEGIN
	DECLARE @ConfiguracionPaisID INT 
	SELECT @ConfiguracionPaisID = ConfiguracionPaisID FROM ConfiguracionPais where Codigo = 'DES-NAV'

	DELETE FROM ConfiguracionPais where Codigo = 'DES-NAV'
	DELETE FROM ConfiguracionOfertasHome WHERE ConfiguracionPaisID = @ConfiguracionPaisID
END
GO

USE BelcorpEcuador
GO

IF EXISTS (SELECT 1 FROM ConfiguracionPais where Codigo = 'DES-NAV') 
BEGIN
	DECLARE @ConfiguracionPaisID INT 
	SELECT @ConfiguracionPaisID = ConfiguracionPaisID FROM ConfiguracionPais where Codigo = 'DES-NAV'

	DELETE FROM ConfiguracionPais where Codigo = 'DES-NAV'
	DELETE FROM ConfiguracionOfertasHome WHERE ConfiguracionPaisID = @ConfiguracionPaisID
END
GO

USE BelcorpDominicana
GO

IF EXISTS (SELECT 1 FROM ConfiguracionPais where Codigo = 'DES-NAV') 
BEGIN
	DECLARE @ConfiguracionPaisID INT 
	SELECT @ConfiguracionPaisID = ConfiguracionPaisID FROM ConfiguracionPais where Codigo = 'DES-NAV'

	DELETE FROM ConfiguracionPais where Codigo = 'DES-NAV'
	DELETE FROM ConfiguracionOfertasHome WHERE ConfiguracionPaisID = @ConfiguracionPaisID
END
GO

USE BelcorpCostaRica
GO

IF EXISTS (SELECT 1 FROM ConfiguracionPais where Codigo = 'DES-NAV') 
BEGIN
	DECLARE @ConfiguracionPaisID INT 
	SELECT @ConfiguracionPaisID = ConfiguracionPaisID FROM ConfiguracionPais where Codigo = 'DES-NAV'

	DELETE FROM ConfiguracionPais where Codigo = 'DES-NAV'
	DELETE FROM ConfiguracionOfertasHome WHERE ConfiguracionPaisID = @ConfiguracionPaisID
END
GO

USE BelcorpBolivia
GO

IF EXISTS (SELECT 1 FROM ConfiguracionPais where Codigo = 'DES-NAV') 
BEGIN
	DECLARE @ConfiguracionPaisID INT 
	SELECT @ConfiguracionPaisID = ConfiguracionPaisID FROM ConfiguracionPais where Codigo = 'DES-NAV'

	DELETE FROM ConfiguracionPais where Codigo = 'DES-NAV'
	DELETE FROM ConfiguracionOfertasHome WHERE ConfiguracionPaisID = @ConfiguracionPaisID
END
GO

