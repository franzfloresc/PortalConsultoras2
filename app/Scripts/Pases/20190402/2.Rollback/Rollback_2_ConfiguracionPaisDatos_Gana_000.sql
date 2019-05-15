USE BelcorpPeru
GO

DECLARE @ConfiguracionPaisID int
SELECT @ConfiguracionPaisID = ConfiguracionPaisID FROM dbo.ConfiguracionPais WHERE Codigo = 'MSPersonalizacion'

IF(ISNULL(@ConfiguracionPaisID,0) > 0)
BEGIN
    DELETE FROM dbo.ConfiguracionPaisDatos WHERE Codigo IN ('GuardaDataEnLocalStorage', 'GuardaDataEnSession')
END

GO

USE BelcorpMexico
GO

DECLARE @ConfiguracionPaisID int
SELECT @ConfiguracionPaisID = ConfiguracionPaisID FROM dbo.ConfiguracionPais WHERE Codigo = 'MSPersonalizacion'

IF(ISNULL(@ConfiguracionPaisID,0) > 0)
BEGIN
    DELETE FROM dbo.ConfiguracionPaisDatos WHERE Codigo IN ('GuardaDataEnLocalStorage', 'GuardaDataEnSession')
END

GO

USE BelcorpColombia
GO

DECLARE @ConfiguracionPaisID int
SELECT @ConfiguracionPaisID = ConfiguracionPaisID FROM dbo.ConfiguracionPais WHERE Codigo = 'MSPersonalizacion'

IF(ISNULL(@ConfiguracionPaisID,0) > 0)
BEGIN
    DELETE FROM dbo.ConfiguracionPaisDatos WHERE Codigo IN ('GuardaDataEnLocalStorage', 'GuardaDataEnSession')
END

GO

USE BelcorpSalvador
GO

DECLARE @ConfiguracionPaisID int
SELECT @ConfiguracionPaisID = ConfiguracionPaisID FROM dbo.ConfiguracionPais WHERE Codigo = 'MSPersonalizacion'

IF(ISNULL(@ConfiguracionPaisID,0) > 0)
BEGIN
    DELETE FROM dbo.ConfiguracionPaisDatos WHERE Codigo IN ('GuardaDataEnLocalStorage', 'GuardaDataEnSession')
END

GO

USE BelcorpPuertoRico
GO

DECLARE @ConfiguracionPaisID int
SELECT @ConfiguracionPaisID = ConfiguracionPaisID FROM dbo.ConfiguracionPais WHERE Codigo = 'MSPersonalizacion'

IF(ISNULL(@ConfiguracionPaisID,0) > 0)
BEGIN
    DELETE FROM dbo.ConfiguracionPaisDatos WHERE Codigo IN ('GuardaDataEnLocalStorage', 'GuardaDataEnSession')
END

GO

USE BelcorpPanama
GO

DECLARE @ConfiguracionPaisID int
SELECT @ConfiguracionPaisID = ConfiguracionPaisID FROM dbo.ConfiguracionPais WHERE Codigo = 'MSPersonalizacion'

IF(ISNULL(@ConfiguracionPaisID,0) > 0)
BEGIN
    DELETE FROM dbo.ConfiguracionPaisDatos WHERE Codigo IN ('GuardaDataEnLocalStorage', 'GuardaDataEnSession')
END

GO

USE BelcorpGuatemala
GO

DECLARE @ConfiguracionPaisID int
SELECT @ConfiguracionPaisID = ConfiguracionPaisID FROM dbo.ConfiguracionPais WHERE Codigo = 'MSPersonalizacion'

IF(ISNULL(@ConfiguracionPaisID,0) > 0)
BEGIN
    DELETE FROM dbo.ConfiguracionPaisDatos WHERE Codigo IN ('GuardaDataEnLocalStorage', 'GuardaDataEnSession')
END

GO

USE BelcorpEcuador
GO

DECLARE @ConfiguracionPaisID int
SELECT @ConfiguracionPaisID = ConfiguracionPaisID FROM dbo.ConfiguracionPais WHERE Codigo = 'MSPersonalizacion'

IF(ISNULL(@ConfiguracionPaisID,0) > 0)
BEGIN
    DELETE FROM dbo.ConfiguracionPaisDatos WHERE Codigo IN ('GuardaDataEnLocalStorage', 'GuardaDataEnSession')
END

GO

USE BelcorpDominicana
GO

DECLARE @ConfiguracionPaisID int
SELECT @ConfiguracionPaisID = ConfiguracionPaisID FROM dbo.ConfiguracionPais WHERE Codigo = 'MSPersonalizacion'

IF(ISNULL(@ConfiguracionPaisID,0) > 0)
BEGIN
    DELETE FROM dbo.ConfiguracionPaisDatos WHERE Codigo IN ('GuardaDataEnLocalStorage', 'GuardaDataEnSession')
END

GO

USE BelcorpCostaRica
GO

DECLARE @ConfiguracionPaisID int
SELECT @ConfiguracionPaisID = ConfiguracionPaisID FROM dbo.ConfiguracionPais WHERE Codigo = 'MSPersonalizacion'

IF(ISNULL(@ConfiguracionPaisID,0) > 0)
BEGIN
    DELETE FROM dbo.ConfiguracionPaisDatos WHERE Codigo IN ('GuardaDataEnLocalStorage', 'GuardaDataEnSession')
END

GO

USE BelcorpChile
GO

DECLARE @ConfiguracionPaisID int
SELECT @ConfiguracionPaisID = ConfiguracionPaisID FROM dbo.ConfiguracionPais WHERE Codigo = 'MSPersonalizacion'

IF(ISNULL(@ConfiguracionPaisID,0) > 0)
BEGIN
    DELETE FROM dbo.ConfiguracionPaisDatos WHERE Codigo IN ('GuardaDataEnLocalStorage', 'GuardaDataEnSession')
END

GO

USE BelcorpBolivia
GO

DECLARE @ConfiguracionPaisID int
SELECT @ConfiguracionPaisID = ConfiguracionPaisID FROM dbo.ConfiguracionPais WHERE Codigo = 'MSPersonalizacion'

IF(ISNULL(@ConfiguracionPaisID,0) > 0)
BEGIN
    DELETE FROM dbo.ConfiguracionPaisDatos WHERE Codigo IN ('GuardaDataEnLocalStorage', 'GuardaDataEnSession')
END

GO

