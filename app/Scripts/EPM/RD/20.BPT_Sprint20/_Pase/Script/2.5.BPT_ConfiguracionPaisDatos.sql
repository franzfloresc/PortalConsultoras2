USE BelcorpPeru
GO

BEGIN
DECLARE @ConfiguracionPaisID INT
SELECT @ConfiguracionPaisID = [ConfiguracionPaisID] FROM ConfiguracionPais WHERE Codigo = 'RD'

IF EXISTS (SELECT 1 FROM [ConfiguracionPaisDatos] WHERE Codigo = 'HabilitarRegionesNuevas' AND [ConfiguracionPaisID] = @ConfiguracionPaisID)
DELETE FROM [ConfiguracionPaisDatos] WHERE Codigo = 'HabilitarRegionesNuevas' AND [ConfiguracionPaisID] = @ConfiguracionPaisID

INSERT INTO [dbo].[ConfiguracionPaisDatos]
		([ConfiguracionPaisID]
		,[Codigo]
		,[CampaniaID]
		,[Valor1]
		,[Valor2]
		,[Valor3]
		,[Descripcion]
		,[Estado]
		,[Componente])
	VALUES
		(@ConfiguracionPaisID
		,'HabilitarRegionesNuevas'
		,0
		,'60,02'
		,''
		,''
		,'Filtrar regiones para la suscripción automática de Nuevas.'
		,0
		,'')

IF EXISTS (SELECT 1 FROM [ConfiguracionPaisDatos] WHERE Codigo = 'HabilitarRegionesUnete' AND [ConfiguracionPaisID] = @ConfiguracionPaisID)
DELETE FROM [ConfiguracionPaisDatos] WHERE Codigo = 'HabilitarRegionesUnete' AND [ConfiguracionPaisID] = @ConfiguracionPaisID

INSERT INTO [dbo].[ConfiguracionPaisDatos]
		([ConfiguracionPaisID]
		,[Codigo]
		,[CampaniaID]
		,[Valor1]
		,[Valor2]
		,[Valor3]
		,[Descripcion]
		,[Estado]
		,[Componente])
	VALUES
		(@ConfiguracionPaisID
		,'HabilitarRegionesUnete'
		,0
		,'60,02'
		,''
		,''
		,'Filtrar regiones para la suscripción automática de Unete.'
		,0
		,'')

IF EXISTS (SELECT 1 FROM [ConfiguracionPaisDatos] WHERE Codigo = 'ActivarSuscripcionNueva' AND [ConfiguracionPaisID] = @ConfiguracionPaisID)
DELETE FROM [ConfiguracionPaisDatos] WHERE Codigo = 'ActivarSuscripcionNueva' AND [ConfiguracionPaisID] = @ConfiguracionPaisID

INSERT INTO [dbo].[ConfiguracionPaisDatos]
		([ConfiguracionPaisID]
		,[Codigo]
		,[CampaniaID]
		,[Valor1]
		,[Valor2]
		,[Valor3]
		,[Descripcion]
		,[Estado]
		,[Componente])
	VALUES
		(@ConfiguracionPaisID
		,'ActivarSuscripcionNueva'
		,0
		,'1'
		,''
		,''
		,'Activar suscripcion de las consultoras nuevas.'
		,0
		,'')
END
GO

USE BelcorpMexico
GO

BEGIN
DECLARE @ConfiguracionPaisID INT
SELECT @ConfiguracionPaisID = [ConfiguracionPaisID] FROM ConfiguracionPais WHERE Codigo = 'RD'

IF EXISTS (SELECT 1 FROM [ConfiguracionPaisDatos] WHERE Codigo = 'HabilitarRegionesNuevas' AND [ConfiguracionPaisID] = @ConfiguracionPaisID)
DELETE FROM [ConfiguracionPaisDatos] WHERE Codigo = 'HabilitarRegionesNuevas' AND [ConfiguracionPaisID] = @ConfiguracionPaisID

INSERT INTO [dbo].[ConfiguracionPaisDatos]
		([ConfiguracionPaisID]
		,[Codigo]
		,[CampaniaID]
		,[Valor1]
		,[Valor2]
		,[Valor3]
		,[Descripcion]
		,[Estado]
		,[Componente])
	VALUES
		(@ConfiguracionPaisID
		,'HabilitarRegionesNuevas'
		,0
		,''
		,''
		,''
		,'Filtrar regiones para la suscripción automática de Nuevas.'
		,0
		,'')

IF EXISTS (SELECT 1 FROM [ConfiguracionPaisDatos] WHERE Codigo = 'HabilitarRegionesUnete' AND [ConfiguracionPaisID] = @ConfiguracionPaisID)
DELETE FROM [ConfiguracionPaisDatos] WHERE Codigo = 'HabilitarRegionesUnete' AND [ConfiguracionPaisID] = @ConfiguracionPaisID

INSERT INTO [dbo].[ConfiguracionPaisDatos]
		([ConfiguracionPaisID]
		,[Codigo]
		,[CampaniaID]
		,[Valor1]
		,[Valor2]
		,[Valor3]
		,[Descripcion]
		,[Estado]
		,[Componente])
	VALUES
		(@ConfiguracionPaisID
		,'HabilitarRegionesUnete'
		,0
		,''
		,''
		,''
		,'Filtrar regiones para la suscripción automática de Unete.'
		,0
		,'')

IF EXISTS (SELECT 1 FROM [ConfiguracionPaisDatos] WHERE Codigo = 'ActivarSuscripcionNueva' AND [ConfiguracionPaisID] = @ConfiguracionPaisID)
DELETE FROM [ConfiguracionPaisDatos] WHERE Codigo = 'ActivarSuscripcionNueva' AND [ConfiguracionPaisID] = @ConfiguracionPaisID

INSERT INTO [dbo].[ConfiguracionPaisDatos]
		([ConfiguracionPaisID]
		,[Codigo]
		,[CampaniaID]
		,[Valor1]
		,[Valor2]
		,[Valor3]
		,[Descripcion]
		,[Estado]
		,[Componente])
	VALUES
		(@ConfiguracionPaisID
		,'ActivarSuscripcionNueva'
		,0
		,'1'
		,''
		,''
		,'Activar suscripcion de las consultoras nuevas.'
		,0
		,'')
END
GO

USE BelcorpColombia
GO

BEGIN
DECLARE @ConfiguracionPaisID INT
SELECT @ConfiguracionPaisID = [ConfiguracionPaisID] FROM ConfiguracionPais WHERE Codigo = 'RD'

IF EXISTS (SELECT 1 FROM [ConfiguracionPaisDatos] WHERE Codigo = 'HabilitarRegionesNuevas' AND [ConfiguracionPaisID] = @ConfiguracionPaisID)
DELETE FROM [ConfiguracionPaisDatos] WHERE Codigo = 'HabilitarRegionesNuevas' AND [ConfiguracionPaisID] = @ConfiguracionPaisID

INSERT INTO [dbo].[ConfiguracionPaisDatos]
		([ConfiguracionPaisID]
		,[Codigo]
		,[CampaniaID]
		,[Valor1]
		,[Valor2]
		,[Valor3]
		,[Descripcion]
		,[Estado]
		,[Componente])
	VALUES
		(@ConfiguracionPaisID
		,'HabilitarRegionesNuevas'
		,0
		,'01,26'
		,''
		,''
		,'Filtrar regiones para la suscripción automática de Nuevas.'
		,0
		,'')

IF EXISTS (SELECT 1 FROM [ConfiguracionPaisDatos] WHERE Codigo = 'HabilitarRegionesUnete' AND [ConfiguracionPaisID] = @ConfiguracionPaisID)
DELETE FROM [ConfiguracionPaisDatos] WHERE Codigo = 'HabilitarRegionesUnete' AND [ConfiguracionPaisID] = @ConfiguracionPaisID

INSERT INTO [dbo].[ConfiguracionPaisDatos]
		([ConfiguracionPaisID]
		,[Codigo]
		,[CampaniaID]
		,[Valor1]
		,[Valor2]
		,[Valor3]
		,[Descripcion]
		,[Estado]
		,[Componente])
	VALUES
		(@ConfiguracionPaisID
		,'HabilitarRegionesUnete'
		,0
		,'01,26'
		,''
		,''
		,'Filtrar regiones para la suscripción automática de Unete.'
		,0
		,'')

IF EXISTS (SELECT 1 FROM [ConfiguracionPaisDatos] WHERE Codigo = 'ActivarSuscripcionNueva' AND [ConfiguracionPaisID] = @ConfiguracionPaisID)
DELETE FROM [ConfiguracionPaisDatos] WHERE Codigo = 'ActivarSuscripcionNueva' AND [ConfiguracionPaisID] = @ConfiguracionPaisID

INSERT INTO [dbo].[ConfiguracionPaisDatos]
		([ConfiguracionPaisID]
		,[Codigo]
		,[CampaniaID]
		,[Valor1]
		,[Valor2]
		,[Valor3]
		,[Descripcion]
		,[Estado]
		,[Componente])
	VALUES
		(@ConfiguracionPaisID
		,'ActivarSuscripcionNueva'
		,0
		,'1'
		,''
		,''
		,'Activar suscripcion de las consultoras nuevas.'
		,0
		,'')
END
GO

USE BelcorpSalvador
GO

BEGIN
DECLARE @ConfiguracionPaisID INT
SELECT @ConfiguracionPaisID = [ConfiguracionPaisID] FROM ConfiguracionPais WHERE Codigo = 'RD'

IF EXISTS (SELECT 1 FROM [ConfiguracionPaisDatos] WHERE Codigo = 'HabilitarRegionesNuevas' AND [ConfiguracionPaisID] = @ConfiguracionPaisID)
DELETE FROM [ConfiguracionPaisDatos] WHERE Codigo = 'HabilitarRegionesNuevas' AND [ConfiguracionPaisID] = @ConfiguracionPaisID

INSERT INTO [dbo].[ConfiguracionPaisDatos]
		([ConfiguracionPaisID]
		,[Codigo]
		,[CampaniaID]
		,[Valor1]
		,[Valor2]
		,[Valor3]
		,[Descripcion]
		,[Estado]
		,[Componente])
	VALUES
		(@ConfiguracionPaisID
		,'HabilitarRegionesNuevas'
		,0
		,''
		,''
		,''
		,'Filtrar regiones para la suscripción automática de Nuevas.'
		,0
		,'')

IF EXISTS (SELECT 1 FROM [ConfiguracionPaisDatos] WHERE Codigo = 'HabilitarRegionesUnete' AND [ConfiguracionPaisID] = @ConfiguracionPaisID)
DELETE FROM [ConfiguracionPaisDatos] WHERE Codigo = 'HabilitarRegionesUnete' AND [ConfiguracionPaisID] = @ConfiguracionPaisID

INSERT INTO [dbo].[ConfiguracionPaisDatos]
		([ConfiguracionPaisID]
		,[Codigo]
		,[CampaniaID]
		,[Valor1]
		,[Valor2]
		,[Valor3]
		,[Descripcion]
		,[Estado]
		,[Componente])
	VALUES
		(@ConfiguracionPaisID
		,'HabilitarRegionesUnete'
		,0
		,''
		,''
		,''
		,'Filtrar regiones para la suscripción automática de Unete.'
		,0
		,'')

IF EXISTS (SELECT 1 FROM [ConfiguracionPaisDatos] WHERE Codigo = 'ActivarSuscripcionNueva' AND [ConfiguracionPaisID] = @ConfiguracionPaisID)
DELETE FROM [ConfiguracionPaisDatos] WHERE Codigo = 'ActivarSuscripcionNueva' AND [ConfiguracionPaisID] = @ConfiguracionPaisID

INSERT INTO [dbo].[ConfiguracionPaisDatos]
		([ConfiguracionPaisID]
		,[Codigo]
		,[CampaniaID]
		,[Valor1]
		,[Valor2]
		,[Valor3]
		,[Descripcion]
		,[Estado]
		,[Componente])
	VALUES
		(@ConfiguracionPaisID
		,'ActivarSuscripcionNueva'
		,0
		,'1'
		,''
		,''
		,'Activar suscripcion de las consultoras nuevas.'
		,0
		,'')
END
GO

USE BelcorpPuertoRico
GO

BEGIN
DECLARE @ConfiguracionPaisID INT
SELECT @ConfiguracionPaisID = [ConfiguracionPaisID] FROM ConfiguracionPais WHERE Codigo = 'RD'

IF EXISTS (SELECT 1 FROM [ConfiguracionPaisDatos] WHERE Codigo = 'HabilitarRegionesNuevas' AND [ConfiguracionPaisID] = @ConfiguracionPaisID)
DELETE FROM [ConfiguracionPaisDatos] WHERE Codigo = 'HabilitarRegionesNuevas' AND [ConfiguracionPaisID] = @ConfiguracionPaisID

INSERT INTO [dbo].[ConfiguracionPaisDatos]
		([ConfiguracionPaisID]
		,[Codigo]
		,[CampaniaID]
		,[Valor1]
		,[Valor2]
		,[Valor3]
		,[Descripcion]
		,[Estado]
		,[Componente])
	VALUES
		(@ConfiguracionPaisID
		,'HabilitarRegionesNuevas'
		,0
		,''
		,''
		,''
		,'Filtrar regiones para la suscripción automática de Nuevas.'
		,0
		,'')

IF EXISTS (SELECT 1 FROM [ConfiguracionPaisDatos] WHERE Codigo = 'HabilitarRegionesUnete' AND [ConfiguracionPaisID] = @ConfiguracionPaisID)
DELETE FROM [ConfiguracionPaisDatos] WHERE Codigo = 'HabilitarRegionesUnete' AND [ConfiguracionPaisID] = @ConfiguracionPaisID

INSERT INTO [dbo].[ConfiguracionPaisDatos]
		([ConfiguracionPaisID]
		,[Codigo]
		,[CampaniaID]
		,[Valor1]
		,[Valor2]
		,[Valor3]
		,[Descripcion]
		,[Estado]
		,[Componente])
	VALUES
		(@ConfiguracionPaisID
		,'HabilitarRegionesUnete'
		,0
		,''
		,''
		,''
		,'Filtrar regiones para la suscripción automática de Unete.'
		,0
		,'')

IF EXISTS (SELECT 1 FROM [ConfiguracionPaisDatos] WHERE Codigo = 'ActivarSuscripcionNueva' AND [ConfiguracionPaisID] = @ConfiguracionPaisID)
DELETE FROM [ConfiguracionPaisDatos] WHERE Codigo = 'ActivarSuscripcionNueva' AND [ConfiguracionPaisID] = @ConfiguracionPaisID

INSERT INTO [dbo].[ConfiguracionPaisDatos]
		([ConfiguracionPaisID]
		,[Codigo]
		,[CampaniaID]
		,[Valor1]
		,[Valor2]
		,[Valor3]
		,[Descripcion]
		,[Estado]
		,[Componente])
	VALUES
		(@ConfiguracionPaisID
		,'ActivarSuscripcionNueva'
		,0
		,'1'
		,''
		,''
		,'Activar suscripcion de las consultoras nuevas.'
		,0
		,'')
END
GO

USE BelcorpPanama
GO

BEGIN
DECLARE @ConfiguracionPaisID INT
SELECT @ConfiguracionPaisID = [ConfiguracionPaisID] FROM ConfiguracionPais WHERE Codigo = 'RD'

IF EXISTS (SELECT 1 FROM [ConfiguracionPaisDatos] WHERE Codigo = 'HabilitarRegionesNuevas' AND [ConfiguracionPaisID] = @ConfiguracionPaisID)
DELETE FROM [ConfiguracionPaisDatos] WHERE Codigo = 'HabilitarRegionesNuevas' AND [ConfiguracionPaisID] = @ConfiguracionPaisID

INSERT INTO [dbo].[ConfiguracionPaisDatos]
		([ConfiguracionPaisID]
		,[Codigo]
		,[CampaniaID]
		,[Valor1]
		,[Valor2]
		,[Valor3]
		,[Descripcion]
		,[Estado]
		,[Componente])
	VALUES
		(@ConfiguracionPaisID
		,'HabilitarRegionesNuevas'
		,0
		,''
		,''
		,''
		,'Filtrar regiones para la suscripción automática de Nuevas.'
		,0
		,'')

IF EXISTS (SELECT 1 FROM [ConfiguracionPaisDatos] WHERE Codigo = 'HabilitarRegionesUnete' AND [ConfiguracionPaisID] = @ConfiguracionPaisID)
DELETE FROM [ConfiguracionPaisDatos] WHERE Codigo = 'HabilitarRegionesUnete' AND [ConfiguracionPaisID] = @ConfiguracionPaisID

INSERT INTO [dbo].[ConfiguracionPaisDatos]
		([ConfiguracionPaisID]
		,[Codigo]
		,[CampaniaID]
		,[Valor1]
		,[Valor2]
		,[Valor3]
		,[Descripcion]
		,[Estado]
		,[Componente])
	VALUES
		(@ConfiguracionPaisID
		,'HabilitarRegionesUnete'
		,0
		,''
		,''
		,''
		,'Filtrar regiones para la suscripción automática de Unete.'
		,0
		,'')

IF EXISTS (SELECT 1 FROM [ConfiguracionPaisDatos] WHERE Codigo = 'ActivarSuscripcionNueva' AND [ConfiguracionPaisID] = @ConfiguracionPaisID)
DELETE FROM [ConfiguracionPaisDatos] WHERE Codigo = 'ActivarSuscripcionNueva' AND [ConfiguracionPaisID] = @ConfiguracionPaisID

INSERT INTO [dbo].[ConfiguracionPaisDatos]
		([ConfiguracionPaisID]
		,[Codigo]
		,[CampaniaID]
		,[Valor1]
		,[Valor2]
		,[Valor3]
		,[Descripcion]
		,[Estado]
		,[Componente])
	VALUES
		(@ConfiguracionPaisID
		,'ActivarSuscripcionNueva'
		,0
		,'1'
		,''
		,''
		,'Activar suscripcion de las consultoras nuevas.'
		,0
		,'')
END
GO

USE BelcorpGuatemala
GO

BEGIN
DECLARE @ConfiguracionPaisID INT
SELECT @ConfiguracionPaisID = [ConfiguracionPaisID] FROM ConfiguracionPais WHERE Codigo = 'RD'

IF EXISTS (SELECT 1 FROM [ConfiguracionPaisDatos] WHERE Codigo = 'HabilitarRegionesNuevas' AND [ConfiguracionPaisID] = @ConfiguracionPaisID)
DELETE FROM [ConfiguracionPaisDatos] WHERE Codigo = 'HabilitarRegionesNuevas' AND [ConfiguracionPaisID] = @ConfiguracionPaisID

INSERT INTO [dbo].[ConfiguracionPaisDatos]
		([ConfiguracionPaisID]
		,[Codigo]
		,[CampaniaID]
		,[Valor1]
		,[Valor2]
		,[Valor3]
		,[Descripcion]
		,[Estado]
		,[Componente])
	VALUES
		(@ConfiguracionPaisID
		,'HabilitarRegionesNuevas'
		,0
		,''
		,''
		,''
		,'Filtrar regiones para la suscripción automática de Nuevas.'
		,0
		,'')

IF EXISTS (SELECT 1 FROM [ConfiguracionPaisDatos] WHERE Codigo = 'HabilitarRegionesUnete' AND [ConfiguracionPaisID] = @ConfiguracionPaisID)
DELETE FROM [ConfiguracionPaisDatos] WHERE Codigo = 'HabilitarRegionesUnete' AND [ConfiguracionPaisID] = @ConfiguracionPaisID

INSERT INTO [dbo].[ConfiguracionPaisDatos]
		([ConfiguracionPaisID]
		,[Codigo]
		,[CampaniaID]
		,[Valor1]
		,[Valor2]
		,[Valor3]
		,[Descripcion]
		,[Estado]
		,[Componente])
	VALUES
		(@ConfiguracionPaisID
		,'HabilitarRegionesUnete'
		,0
		,''
		,''
		,''
		,'Filtrar regiones para la suscripción automática de Unete.'
		,0
		,'')

IF EXISTS (SELECT 1 FROM [ConfiguracionPaisDatos] WHERE Codigo = 'ActivarSuscripcionNueva' AND [ConfiguracionPaisID] = @ConfiguracionPaisID)
DELETE FROM [ConfiguracionPaisDatos] WHERE Codigo = 'ActivarSuscripcionNueva' AND [ConfiguracionPaisID] = @ConfiguracionPaisID

INSERT INTO [dbo].[ConfiguracionPaisDatos]
		([ConfiguracionPaisID]
		,[Codigo]
		,[CampaniaID]
		,[Valor1]
		,[Valor2]
		,[Valor3]
		,[Descripcion]
		,[Estado]
		,[Componente])
	VALUES
		(@ConfiguracionPaisID
		,'ActivarSuscripcionNueva'
		,0
		,'1'
		,''
		,''
		,'Activar suscripcion de las consultoras nuevas.'
		,0
		,'')
END
GO

USE BelcorpEcuador
GO

BEGIN
DECLARE @ConfiguracionPaisID INT
SELECT @ConfiguracionPaisID = [ConfiguracionPaisID] FROM ConfiguracionPais WHERE Codigo = 'RD'

IF EXISTS (SELECT 1 FROM [ConfiguracionPaisDatos] WHERE Codigo = 'HabilitarRegionesNuevas' AND [ConfiguracionPaisID] = @ConfiguracionPaisID)
DELETE FROM [ConfiguracionPaisDatos] WHERE Codigo = 'HabilitarRegionesNuevas' AND [ConfiguracionPaisID] = @ConfiguracionPaisID

INSERT INTO [dbo].[ConfiguracionPaisDatos]
		([ConfiguracionPaisID]
		,[Codigo]
		,[CampaniaID]
		,[Valor1]
		,[Valor2]
		,[Valor3]
		,[Descripcion]
		,[Estado]
		,[Componente])
	VALUES
		(@ConfiguracionPaisID
		,'HabilitarRegionesNuevas'
		,0
		,''
		,''
		,''
		,'Filtrar regiones para la suscripción automática de Nuevas.'
		,0
		,'')

IF EXISTS (SELECT 1 FROM [ConfiguracionPaisDatos] WHERE Codigo = 'HabilitarRegionesUnete' AND [ConfiguracionPaisID] = @ConfiguracionPaisID)
DELETE FROM [ConfiguracionPaisDatos] WHERE Codigo = 'HabilitarRegionesUnete' AND [ConfiguracionPaisID] = @ConfiguracionPaisID

INSERT INTO [dbo].[ConfiguracionPaisDatos]
		([ConfiguracionPaisID]
		,[Codigo]
		,[CampaniaID]
		,[Valor1]
		,[Valor2]
		,[Valor3]
		,[Descripcion]
		,[Estado]
		,[Componente])
	VALUES
		(@ConfiguracionPaisID
		,'HabilitarRegionesUnete'
		,0
		,''
		,''
		,''
		,'Filtrar regiones para la suscripción automática de Unete.'
		,0
		,'')

IF EXISTS (SELECT 1 FROM [ConfiguracionPaisDatos] WHERE Codigo = 'ActivarSuscripcionNueva' AND [ConfiguracionPaisID] = @ConfiguracionPaisID)
DELETE FROM [ConfiguracionPaisDatos] WHERE Codigo = 'ActivarSuscripcionNueva' AND [ConfiguracionPaisID] = @ConfiguracionPaisID

INSERT INTO [dbo].[ConfiguracionPaisDatos]
		([ConfiguracionPaisID]
		,[Codigo]
		,[CampaniaID]
		,[Valor1]
		,[Valor2]
		,[Valor3]
		,[Descripcion]
		,[Estado]
		,[Componente])
	VALUES
		(@ConfiguracionPaisID
		,'ActivarSuscripcionNueva'
		,0
		,'1'
		,''
		,''
		,'Activar suscripcion de las consultoras nuevas.'
		,0
		,'')
END
GO

USE BelcorpDominicana
GO

BEGIN
DECLARE @ConfiguracionPaisID INT
SELECT @ConfiguracionPaisID = [ConfiguracionPaisID] FROM ConfiguracionPais WHERE Codigo = 'RD'

IF EXISTS (SELECT 1 FROM [ConfiguracionPaisDatos] WHERE Codigo = 'HabilitarRegionesNuevas' AND [ConfiguracionPaisID] = @ConfiguracionPaisID)
DELETE FROM [ConfiguracionPaisDatos] WHERE Codigo = 'HabilitarRegionesNuevas' AND [ConfiguracionPaisID] = @ConfiguracionPaisID

INSERT INTO [dbo].[ConfiguracionPaisDatos]
		([ConfiguracionPaisID]
		,[Codigo]
		,[CampaniaID]
		,[Valor1]
		,[Valor2]
		,[Valor3]
		,[Descripcion]
		,[Estado]
		,[Componente])
	VALUES
		(@ConfiguracionPaisID
		,'HabilitarRegionesNuevas'
		,0
		,''
		,''
		,''
		,'Filtrar regiones para la suscripción automática de Nuevas.'
		,0
		,'')

IF EXISTS (SELECT 1 FROM [ConfiguracionPaisDatos] WHERE Codigo = 'HabilitarRegionesUnete' AND [ConfiguracionPaisID] = @ConfiguracionPaisID)
DELETE FROM [ConfiguracionPaisDatos] WHERE Codigo = 'HabilitarRegionesUnete' AND [ConfiguracionPaisID] = @ConfiguracionPaisID

INSERT INTO [dbo].[ConfiguracionPaisDatos]
		([ConfiguracionPaisID]
		,[Codigo]
		,[CampaniaID]
		,[Valor1]
		,[Valor2]
		,[Valor3]
		,[Descripcion]
		,[Estado]
		,[Componente])
	VALUES
		(@ConfiguracionPaisID
		,'HabilitarRegionesUnete'
		,0
		,''
		,''
		,''
		,'Filtrar regiones para la suscripción automática de Unete.'
		,0
		,'')

IF EXISTS (SELECT 1 FROM [ConfiguracionPaisDatos] WHERE Codigo = 'ActivarSuscripcionNueva' AND [ConfiguracionPaisID] = @ConfiguracionPaisID)
DELETE FROM [ConfiguracionPaisDatos] WHERE Codigo = 'ActivarSuscripcionNueva' AND [ConfiguracionPaisID] = @ConfiguracionPaisID

INSERT INTO [dbo].[ConfiguracionPaisDatos]
		([ConfiguracionPaisID]
		,[Codigo]
		,[CampaniaID]
		,[Valor1]
		,[Valor2]
		,[Valor3]
		,[Descripcion]
		,[Estado]
		,[Componente])
	VALUES
		(@ConfiguracionPaisID
		,'ActivarSuscripcionNueva'
		,0
		,'1'
		,''
		,''
		,'Activar suscripcion de las consultoras nuevas.'
		,0
		,'')
END
GO

USE BelcorpCostaRica
GO

BEGIN
DECLARE @ConfiguracionPaisID INT
SELECT @ConfiguracionPaisID = [ConfiguracionPaisID] FROM ConfiguracionPais WHERE Codigo = 'RD'

IF EXISTS (SELECT 1 FROM [ConfiguracionPaisDatos] WHERE Codigo = 'HabilitarRegionesNuevas' AND [ConfiguracionPaisID] = @ConfiguracionPaisID)
DELETE FROM [ConfiguracionPaisDatos] WHERE Codigo = 'HabilitarRegionesNuevas' AND [ConfiguracionPaisID] = @ConfiguracionPaisID

INSERT INTO [dbo].[ConfiguracionPaisDatos]
		([ConfiguracionPaisID]
		,[Codigo]
		,[CampaniaID]
		,[Valor1]
		,[Valor2]
		,[Valor3]
		,[Descripcion]
		,[Estado]
		,[Componente])
	VALUES
		(@ConfiguracionPaisID
		,'HabilitarRegionesNuevas'
		,0
		,''
		,''
		,''
		,'Filtrar regiones para la suscripción automática de Nuevas.'
		,0
		,'')

IF EXISTS (SELECT 1 FROM [ConfiguracionPaisDatos] WHERE Codigo = 'HabilitarRegionesUnete' AND [ConfiguracionPaisID] = @ConfiguracionPaisID)
DELETE FROM [ConfiguracionPaisDatos] WHERE Codigo = 'HabilitarRegionesUnete' AND [ConfiguracionPaisID] = @ConfiguracionPaisID

INSERT INTO [dbo].[ConfiguracionPaisDatos]
		([ConfiguracionPaisID]
		,[Codigo]
		,[CampaniaID]
		,[Valor1]
		,[Valor2]
		,[Valor3]
		,[Descripcion]
		,[Estado]
		,[Componente])
	VALUES
		(@ConfiguracionPaisID
		,'HabilitarRegionesUnete'
		,0
		,''
		,''
		,''
		,'Filtrar regiones para la suscripción automática de Unete.'
		,0
		,'')

IF EXISTS (SELECT 1 FROM [ConfiguracionPaisDatos] WHERE Codigo = 'ActivarSuscripcionNueva' AND [ConfiguracionPaisID] = @ConfiguracionPaisID)
DELETE FROM [ConfiguracionPaisDatos] WHERE Codigo = 'ActivarSuscripcionNueva' AND [ConfiguracionPaisID] = @ConfiguracionPaisID

INSERT INTO [dbo].[ConfiguracionPaisDatos]
		([ConfiguracionPaisID]
		,[Codigo]
		,[CampaniaID]
		,[Valor1]
		,[Valor2]
		,[Valor3]
		,[Descripcion]
		,[Estado]
		,[Componente])
	VALUES
		(@ConfiguracionPaisID
		,'ActivarSuscripcionNueva'
		,0
		,'1'
		,''
		,''
		,'Activar suscripcion de las consultoras nuevas.'
		,0
		,'')
END
GO

USE BelcorpChile
GO

BEGIN
DECLARE @ConfiguracionPaisID INT
SELECT @ConfiguracionPaisID = [ConfiguracionPaisID] FROM ConfiguracionPais WHERE Codigo = 'RD'

IF EXISTS (SELECT 1 FROM [ConfiguracionPaisDatos] WHERE Codigo = 'HabilitarRegionesNuevas' AND [ConfiguracionPaisID] = @ConfiguracionPaisID)
DELETE FROM [ConfiguracionPaisDatos] WHERE Codigo = 'HabilitarRegionesNuevas' AND [ConfiguracionPaisID] = @ConfiguracionPaisID

INSERT INTO [dbo].[ConfiguracionPaisDatos]
		([ConfiguracionPaisID]
		,[Codigo]
		,[CampaniaID]
		,[Valor1]
		,[Valor2]
		,[Valor3]
		,[Descripcion]
		,[Estado]
		,[Componente])
	VALUES
		(@ConfiguracionPaisID
		,'HabilitarRegionesNuevas'
		,0
		,''
		,''
		,''
		,'Filtrar regiones para la suscripción automática de Nuevas.'
		,0
		,'')

IF EXISTS (SELECT 1 FROM [ConfiguracionPaisDatos] WHERE Codigo = 'HabilitarRegionesUnete' AND [ConfiguracionPaisID] = @ConfiguracionPaisID)
DELETE FROM [ConfiguracionPaisDatos] WHERE Codigo = 'HabilitarRegionesUnete' AND [ConfiguracionPaisID] = @ConfiguracionPaisID

INSERT INTO [dbo].[ConfiguracionPaisDatos]
		([ConfiguracionPaisID]
		,[Codigo]
		,[CampaniaID]
		,[Valor1]
		,[Valor2]
		,[Valor3]
		,[Descripcion]
		,[Estado]
		,[Componente])
	VALUES
		(@ConfiguracionPaisID
		,'HabilitarRegionesUnete'
		,0
		,''
		,''
		,''
		,'Filtrar regiones para la suscripción automática de Unete.'
		,0
		,'')

IF EXISTS (SELECT 1 FROM [ConfiguracionPaisDatos] WHERE Codigo = 'ActivarSuscripcionNueva' AND [ConfiguracionPaisID] = @ConfiguracionPaisID)
DELETE FROM [ConfiguracionPaisDatos] WHERE Codigo = 'ActivarSuscripcionNueva' AND [ConfiguracionPaisID] = @ConfiguracionPaisID

INSERT INTO [dbo].[ConfiguracionPaisDatos]
		([ConfiguracionPaisID]
		,[Codigo]
		,[CampaniaID]
		,[Valor1]
		,[Valor2]
		,[Valor3]
		,[Descripcion]
		,[Estado]
		,[Componente])
	VALUES
		(@ConfiguracionPaisID
		,'ActivarSuscripcionNueva'
		,0
		,'1'
		,''
		,''
		,'Activar suscripcion de las consultoras nuevas.'
		,0
		,'')
END
GO

USE BelcorpBolivia
GO

BEGIN
DECLARE @ConfiguracionPaisID INT
SELECT @ConfiguracionPaisID = [ConfiguracionPaisID] FROM ConfiguracionPais WHERE Codigo = 'RD'

IF EXISTS (SELECT 1 FROM [ConfiguracionPaisDatos] WHERE Codigo = 'HabilitarRegionesNuevas' AND [ConfiguracionPaisID] = @ConfiguracionPaisID)
DELETE FROM [ConfiguracionPaisDatos] WHERE Codigo = 'HabilitarRegionesNuevas' AND [ConfiguracionPaisID] = @ConfiguracionPaisID

INSERT INTO [dbo].[ConfiguracionPaisDatos]
		([ConfiguracionPaisID]
		,[Codigo]
		,[CampaniaID]
		,[Valor1]
		,[Valor2]
		,[Valor3]
		,[Descripcion]
		,[Estado]
		,[Componente])
	VALUES
		(@ConfiguracionPaisID
		,'HabilitarRegionesNuevas'
		,0
		,''
		,''
		,''
		,'Filtrar regiones para la suscripción automática de Nuevas.'
		,0
		,'')

IF EXISTS (SELECT 1 FROM [ConfiguracionPaisDatos] WHERE Codigo = 'HabilitarRegionesUnete' AND [ConfiguracionPaisID] = @ConfiguracionPaisID)
DELETE FROM [ConfiguracionPaisDatos] WHERE Codigo = 'HabilitarRegionesUnete' AND [ConfiguracionPaisID] = @ConfiguracionPaisID

INSERT INTO [dbo].[ConfiguracionPaisDatos]
		([ConfiguracionPaisID]
		,[Codigo]
		,[CampaniaID]
		,[Valor1]
		,[Valor2]
		,[Valor3]
		,[Descripcion]
		,[Estado]
		,[Componente])
	VALUES
		(@ConfiguracionPaisID
		,'HabilitarRegionesUnete'
		,0
		,''
		,''
		,''
		,'Filtrar regiones para la suscripción automática de Unete.'
		,0
		,'')

IF EXISTS (SELECT 1 FROM [ConfiguracionPaisDatos] WHERE Codigo = 'ActivarSuscripcionNueva' AND [ConfiguracionPaisID] = @ConfiguracionPaisID)
DELETE FROM [ConfiguracionPaisDatos] WHERE Codigo = 'ActivarSuscripcionNueva' AND [ConfiguracionPaisID] = @ConfiguracionPaisID

INSERT INTO [dbo].[ConfiguracionPaisDatos]
		([ConfiguracionPaisID]
		,[Codigo]
		,[CampaniaID]
		,[Valor1]
		,[Valor2]
		,[Valor3]
		,[Descripcion]
		,[Estado]
		,[Componente])
	VALUES
		(@ConfiguracionPaisID
		,'ActivarSuscripcionNueva'
		,0
		,'1'
		,''
		,''
		,'Activar suscripcion de las consultoras nuevas.'
		,0
		,'')
END
GO

