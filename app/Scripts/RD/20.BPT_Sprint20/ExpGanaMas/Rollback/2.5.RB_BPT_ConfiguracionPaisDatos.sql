USE BelcorpPeru
GO

BEGIN
DECLARE @ConfiguracionPaisID INT
SELECT @ConfiguracionPaisID = [ConfiguracionPaisID] FROM ConfiguracionPais WHERE Codigo = 'RD'

IF EXISTS (SELECT 1 FROM [ConfiguracionPaisDatos] WHERE Codigo = 'HabilitarRegionesNuevas' AND [ConfiguracionPaisID] = @ConfiguracionPaisID)
DELETE FROM [ConfiguracionPaisDatos] WHERE Codigo = 'HabilitarRegionesNuevas' AND [ConfiguracionPaisID] = @ConfiguracionPaisID

IF EXISTS (SELECT 1 FROM [ConfiguracionPaisDatos] WHERE Codigo = 'HabilitarRegionesUnete' AND [ConfiguracionPaisID] = @ConfiguracionPaisID)
DELETE FROM [ConfiguracionPaisDatos] WHERE Codigo = 'HabilitarRegionesUnete' AND [ConfiguracionPaisID] = @ConfiguracionPaisID

IF EXISTS (SELECT 1 FROM [ConfiguracionPaisDatos] WHERE Codigo = 'ActivarSuscripcionNueva' AND [ConfiguracionPaisID] = @ConfiguracionPaisID)
DELETE FROM [ConfiguracionPaisDatos] WHERE Codigo = 'ActivarSuscripcionNueva' AND [ConfiguracionPaisID] = @ConfiguracionPaisID

END
GO

USE BelcorpMexico
GO

BEGIN
DECLARE @ConfiguracionPaisID INT
SELECT @ConfiguracionPaisID = [ConfiguracionPaisID] FROM ConfiguracionPais WHERE Codigo = 'RD'

IF EXISTS (SELECT 1 FROM [ConfiguracionPaisDatos] WHERE Codigo = 'HabilitarRegionesNuevas' AND [ConfiguracionPaisID] = @ConfiguracionPaisID)
DELETE FROM [ConfiguracionPaisDatos] WHERE Codigo = 'HabilitarRegionesNuevas' AND [ConfiguracionPaisID] = @ConfiguracionPaisID

IF EXISTS (SELECT 1 FROM [ConfiguracionPaisDatos] WHERE Codigo = 'HabilitarRegionesUnete' AND [ConfiguracionPaisID] = @ConfiguracionPaisID)
DELETE FROM [ConfiguracionPaisDatos] WHERE Codigo = 'HabilitarRegionesUnete' AND [ConfiguracionPaisID] = @ConfiguracionPaisID

IF EXISTS (SELECT 1 FROM [ConfiguracionPaisDatos] WHERE Codigo = 'ActivarSuscripcionNueva' AND [ConfiguracionPaisID] = @ConfiguracionPaisID)
DELETE FROM [ConfiguracionPaisDatos] WHERE Codigo = 'ActivarSuscripcionNueva' AND [ConfiguracionPaisID] = @ConfiguracionPaisID

END
GO

USE BelcorpColombia
GO

BEGIN
DECLARE @ConfiguracionPaisID INT
SELECT @ConfiguracionPaisID = [ConfiguracionPaisID] FROM ConfiguracionPais WHERE Codigo = 'RD'

IF EXISTS (SELECT 1 FROM [ConfiguracionPaisDatos] WHERE Codigo = 'HabilitarRegionesNuevas' AND [ConfiguracionPaisID] = @ConfiguracionPaisID)
DELETE FROM [ConfiguracionPaisDatos] WHERE Codigo = 'HabilitarRegionesNuevas' AND [ConfiguracionPaisID] = @ConfiguracionPaisID

IF EXISTS (SELECT 1 FROM [ConfiguracionPaisDatos] WHERE Codigo = 'HabilitarRegionesUnete' AND [ConfiguracionPaisID] = @ConfiguracionPaisID)
DELETE FROM [ConfiguracionPaisDatos] WHERE Codigo = 'HabilitarRegionesUnete' AND [ConfiguracionPaisID] = @ConfiguracionPaisID

IF EXISTS (SELECT 1 FROM [ConfiguracionPaisDatos] WHERE Codigo = 'ActivarSuscripcionNueva' AND [ConfiguracionPaisID] = @ConfiguracionPaisID)
DELETE FROM [ConfiguracionPaisDatos] WHERE Codigo = 'ActivarSuscripcionNueva' AND [ConfiguracionPaisID] = @ConfiguracionPaisID

END
GO

USE BelcorpSalvador
GO

BEGIN
DECLARE @ConfiguracionPaisID INT
SELECT @ConfiguracionPaisID = [ConfiguracionPaisID] FROM ConfiguracionPais WHERE Codigo = 'RD'

IF EXISTS (SELECT 1 FROM [ConfiguracionPaisDatos] WHERE Codigo = 'HabilitarRegionesNuevas' AND [ConfiguracionPaisID] = @ConfiguracionPaisID)
DELETE FROM [ConfiguracionPaisDatos] WHERE Codigo = 'HabilitarRegionesNuevas' AND [ConfiguracionPaisID] = @ConfiguracionPaisID

IF EXISTS (SELECT 1 FROM [ConfiguracionPaisDatos] WHERE Codigo = 'HabilitarRegionesUnete' AND [ConfiguracionPaisID] = @ConfiguracionPaisID)
DELETE FROM [ConfiguracionPaisDatos] WHERE Codigo = 'HabilitarRegionesUnete' AND [ConfiguracionPaisID] = @ConfiguracionPaisID

IF EXISTS (SELECT 1 FROM [ConfiguracionPaisDatos] WHERE Codigo = 'ActivarSuscripcionNueva' AND [ConfiguracionPaisID] = @ConfiguracionPaisID)
DELETE FROM [ConfiguracionPaisDatos] WHERE Codigo = 'ActivarSuscripcionNueva' AND [ConfiguracionPaisID] = @ConfiguracionPaisID

END
GO

USE BelcorpPuertoRico
GO

BEGIN
DECLARE @ConfiguracionPaisID INT
SELECT @ConfiguracionPaisID = [ConfiguracionPaisID] FROM ConfiguracionPais WHERE Codigo = 'RD'

IF EXISTS (SELECT 1 FROM [ConfiguracionPaisDatos] WHERE Codigo = 'HabilitarRegionesNuevas' AND [ConfiguracionPaisID] = @ConfiguracionPaisID)
DELETE FROM [ConfiguracionPaisDatos] WHERE Codigo = 'HabilitarRegionesNuevas' AND [ConfiguracionPaisID] = @ConfiguracionPaisID

IF EXISTS (SELECT 1 FROM [ConfiguracionPaisDatos] WHERE Codigo = 'HabilitarRegionesUnete' AND [ConfiguracionPaisID] = @ConfiguracionPaisID)
DELETE FROM [ConfiguracionPaisDatos] WHERE Codigo = 'HabilitarRegionesUnete' AND [ConfiguracionPaisID] = @ConfiguracionPaisID

IF EXISTS (SELECT 1 FROM [ConfiguracionPaisDatos] WHERE Codigo = 'ActivarSuscripcionNueva' AND [ConfiguracionPaisID] = @ConfiguracionPaisID)
DELETE FROM [ConfiguracionPaisDatos] WHERE Codigo = 'ActivarSuscripcionNueva' AND [ConfiguracionPaisID] = @ConfiguracionPaisID

END
GO

USE BelcorpPanama
GO

BEGIN
DECLARE @ConfiguracionPaisID INT
SELECT @ConfiguracionPaisID = [ConfiguracionPaisID] FROM ConfiguracionPais WHERE Codigo = 'RD'

IF EXISTS (SELECT 1 FROM [ConfiguracionPaisDatos] WHERE Codigo = 'HabilitarRegionesNuevas' AND [ConfiguracionPaisID] = @ConfiguracionPaisID)
DELETE FROM [ConfiguracionPaisDatos] WHERE Codigo = 'HabilitarRegionesNuevas' AND [ConfiguracionPaisID] = @ConfiguracionPaisID

IF EXISTS (SELECT 1 FROM [ConfiguracionPaisDatos] WHERE Codigo = 'HabilitarRegionesUnete' AND [ConfiguracionPaisID] = @ConfiguracionPaisID)
DELETE FROM [ConfiguracionPaisDatos] WHERE Codigo = 'HabilitarRegionesUnete' AND [ConfiguracionPaisID] = @ConfiguracionPaisID

IF EXISTS (SELECT 1 FROM [ConfiguracionPaisDatos] WHERE Codigo = 'ActivarSuscripcionNueva' AND [ConfiguracionPaisID] = @ConfiguracionPaisID)
DELETE FROM [ConfiguracionPaisDatos] WHERE Codigo = 'ActivarSuscripcionNueva' AND [ConfiguracionPaisID] = @ConfiguracionPaisID

END
GO

USE BelcorpGuatemala
GO

BEGIN
DECLARE @ConfiguracionPaisID INT
SELECT @ConfiguracionPaisID = [ConfiguracionPaisID] FROM ConfiguracionPais WHERE Codigo = 'RD'

IF EXISTS (SELECT 1 FROM [ConfiguracionPaisDatos] WHERE Codigo = 'HabilitarRegionesNuevas' AND [ConfiguracionPaisID] = @ConfiguracionPaisID)
DELETE FROM [ConfiguracionPaisDatos] WHERE Codigo = 'HabilitarRegionesNuevas' AND [ConfiguracionPaisID] = @ConfiguracionPaisID

IF EXISTS (SELECT 1 FROM [ConfiguracionPaisDatos] WHERE Codigo = 'HabilitarRegionesUnete' AND [ConfiguracionPaisID] = @ConfiguracionPaisID)
DELETE FROM [ConfiguracionPaisDatos] WHERE Codigo = 'HabilitarRegionesUnete' AND [ConfiguracionPaisID] = @ConfiguracionPaisID

IF EXISTS (SELECT 1 FROM [ConfiguracionPaisDatos] WHERE Codigo = 'ActivarSuscripcionNueva' AND [ConfiguracionPaisID] = @ConfiguracionPaisID)
DELETE FROM [ConfiguracionPaisDatos] WHERE Codigo = 'ActivarSuscripcionNueva' AND [ConfiguracionPaisID] = @ConfiguracionPaisID

END
GO

USE BelcorpEcuador
GO

BEGIN
DECLARE @ConfiguracionPaisID INT
SELECT @ConfiguracionPaisID = [ConfiguracionPaisID] FROM ConfiguracionPais WHERE Codigo = 'RD'

IF EXISTS (SELECT 1 FROM [ConfiguracionPaisDatos] WHERE Codigo = 'HabilitarRegionesNuevas' AND [ConfiguracionPaisID] = @ConfiguracionPaisID)
DELETE FROM [ConfiguracionPaisDatos] WHERE Codigo = 'HabilitarRegionesNuevas' AND [ConfiguracionPaisID] = @ConfiguracionPaisID

IF EXISTS (SELECT 1 FROM [ConfiguracionPaisDatos] WHERE Codigo = 'HabilitarRegionesUnete' AND [ConfiguracionPaisID] = @ConfiguracionPaisID)
DELETE FROM [ConfiguracionPaisDatos] WHERE Codigo = 'HabilitarRegionesUnete' AND [ConfiguracionPaisID] = @ConfiguracionPaisID

IF EXISTS (SELECT 1 FROM [ConfiguracionPaisDatos] WHERE Codigo = 'ActivarSuscripcionNueva' AND [ConfiguracionPaisID] = @ConfiguracionPaisID)
DELETE FROM [ConfiguracionPaisDatos] WHERE Codigo = 'ActivarSuscripcionNueva' AND [ConfiguracionPaisID] = @ConfiguracionPaisID

END
GO

USE BelcorpDominicana
GO

BEGIN
DECLARE @ConfiguracionPaisID INT
SELECT @ConfiguracionPaisID = [ConfiguracionPaisID] FROM ConfiguracionPais WHERE Codigo = 'RD'

IF EXISTS (SELECT 1 FROM [ConfiguracionPaisDatos] WHERE Codigo = 'HabilitarRegionesNuevas' AND [ConfiguracionPaisID] = @ConfiguracionPaisID)
DELETE FROM [ConfiguracionPaisDatos] WHERE Codigo = 'HabilitarRegionesNuevas' AND [ConfiguracionPaisID] = @ConfiguracionPaisID

IF EXISTS (SELECT 1 FROM [ConfiguracionPaisDatos] WHERE Codigo = 'HabilitarRegionesUnete' AND [ConfiguracionPaisID] = @ConfiguracionPaisID)
DELETE FROM [ConfiguracionPaisDatos] WHERE Codigo = 'HabilitarRegionesUnete' AND [ConfiguracionPaisID] = @ConfiguracionPaisID

IF EXISTS (SELECT 1 FROM [ConfiguracionPaisDatos] WHERE Codigo = 'ActivarSuscripcionNueva' AND [ConfiguracionPaisID] = @ConfiguracionPaisID)
DELETE FROM [ConfiguracionPaisDatos] WHERE Codigo = 'ActivarSuscripcionNueva' AND [ConfiguracionPaisID] = @ConfiguracionPaisID

END
GO

USE BelcorpCostaRica
GO

BEGIN
DECLARE @ConfiguracionPaisID INT
SELECT @ConfiguracionPaisID = [ConfiguracionPaisID] FROM ConfiguracionPais WHERE Codigo = 'RD'

IF EXISTS (SELECT 1 FROM [ConfiguracionPaisDatos] WHERE Codigo = 'HabilitarRegionesNuevas' AND [ConfiguracionPaisID] = @ConfiguracionPaisID)
DELETE FROM [ConfiguracionPaisDatos] WHERE Codigo = 'HabilitarRegionesNuevas' AND [ConfiguracionPaisID] = @ConfiguracionPaisID

IF EXISTS (SELECT 1 FROM [ConfiguracionPaisDatos] WHERE Codigo = 'HabilitarRegionesUnete' AND [ConfiguracionPaisID] = @ConfiguracionPaisID)
DELETE FROM [ConfiguracionPaisDatos] WHERE Codigo = 'HabilitarRegionesUnete' AND [ConfiguracionPaisID] = @ConfiguracionPaisID

IF EXISTS (SELECT 1 FROM [ConfiguracionPaisDatos] WHERE Codigo = 'ActivarSuscripcionNueva' AND [ConfiguracionPaisID] = @ConfiguracionPaisID)
DELETE FROM [ConfiguracionPaisDatos] WHERE Codigo = 'ActivarSuscripcionNueva' AND [ConfiguracionPaisID] = @ConfiguracionPaisID

END
GO

USE BelcorpChile
GO

BEGIN
DECLARE @ConfiguracionPaisID INT
SELECT @ConfiguracionPaisID = [ConfiguracionPaisID] FROM ConfiguracionPais WHERE Codigo = 'RD'

IF EXISTS (SELECT 1 FROM [ConfiguracionPaisDatos] WHERE Codigo = 'HabilitarRegionesNuevas' AND [ConfiguracionPaisID] = @ConfiguracionPaisID)
DELETE FROM [ConfiguracionPaisDatos] WHERE Codigo = 'HabilitarRegionesNuevas' AND [ConfiguracionPaisID] = @ConfiguracionPaisID

IF EXISTS (SELECT 1 FROM [ConfiguracionPaisDatos] WHERE Codigo = 'HabilitarRegionesUnete' AND [ConfiguracionPaisID] = @ConfiguracionPaisID)
DELETE FROM [ConfiguracionPaisDatos] WHERE Codigo = 'HabilitarRegionesUnete' AND [ConfiguracionPaisID] = @ConfiguracionPaisID

IF EXISTS (SELECT 1 FROM [ConfiguracionPaisDatos] WHERE Codigo = 'ActivarSuscripcionNueva' AND [ConfiguracionPaisID] = @ConfiguracionPaisID)
DELETE FROM [ConfiguracionPaisDatos] WHERE Codigo = 'ActivarSuscripcionNueva' AND [ConfiguracionPaisID] = @ConfiguracionPaisID

END
GO

USE BelcorpBolivia
GO

BEGIN
DECLARE @ConfiguracionPaisID INT
SELECT @ConfiguracionPaisID = [ConfiguracionPaisID] FROM ConfiguracionPais WHERE Codigo = 'RD'

IF EXISTS (SELECT 1 FROM [ConfiguracionPaisDatos] WHERE Codigo = 'HabilitarRegionesNuevas' AND [ConfiguracionPaisID] = @ConfiguracionPaisID)
DELETE FROM [ConfiguracionPaisDatos] WHERE Codigo = 'HabilitarRegionesNuevas' AND [ConfiguracionPaisID] = @ConfiguracionPaisID

IF EXISTS (SELECT 1 FROM [ConfiguracionPaisDatos] WHERE Codigo = 'HabilitarRegionesUnete' AND [ConfiguracionPaisID] = @ConfiguracionPaisID)
DELETE FROM [ConfiguracionPaisDatos] WHERE Codigo = 'HabilitarRegionesUnete' AND [ConfiguracionPaisID] = @ConfiguracionPaisID

IF EXISTS (SELECT 1 FROM [ConfiguracionPaisDatos] WHERE Codigo = 'ActivarSuscripcionNueva' AND [ConfiguracionPaisID] = @ConfiguracionPaisID)
DELETE FROM [ConfiguracionPaisDatos] WHERE Codigo = 'ActivarSuscripcionNueva' AND [ConfiguracionPaisID] = @ConfiguracionPaisID

END
GO

