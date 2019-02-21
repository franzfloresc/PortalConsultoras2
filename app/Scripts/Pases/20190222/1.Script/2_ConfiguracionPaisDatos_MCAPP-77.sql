USE BelcorpPeru
GO

IF NOT EXISTS(SELECT CODIGO FROM CONFIGURACIONPAISDATOS WHERE CODIGO='FlujoPagoLinea')
BEGIN
	INSERT INTO [ConfiguracionPaisDatos]([ConfiguracionPaisID], [Codigo], [CampaniaID], [Valor1],[Valor2], [Descripcion], [Estado])
	SELECT TOP 1 CP.ConfiguracionPaisID, 'FlujoPagoLinea', '0', '1',NULL, '0: No aplica 1: Flujo interno 2:Flujo externo', 1
		FROM [ConfiguracionPais] CP where CP.Codigo = 'PAYONLINE' AND
			NOT EXISTS (SELECT Codigo FROM [ConfiguracionPaisDatos] CDP
				WHERE  CDP.Codigo = 'PAYONLINE' AND CDP.ConfiguracionPaisID = CP.ConfiguracionPaisID)
END

USE BelcorpMexico
GO

IF NOT EXISTS(SELECT CODIGO FROM CONFIGURACIONPAISDATOS WHERE CODIGO='FlujoPagoLinea')
BEGIN
	INSERT INTO [ConfiguracionPaisDatos]([ConfiguracionPaisID], [Codigo], [CampaniaID], [Valor1],[Valor2], [Descripcion], [Estado])
	SELECT TOP 1 CP.ConfiguracionPaisID, 'FlujoPagoLinea', '0', '0',NULL, '0: No aplica 1: Flujo interno 2:Flujo externo', 1
		FROM [ConfiguracionPais] CP where CP.Codigo = 'PAYONLINE' AND
			NOT EXISTS (SELECT Codigo FROM [ConfiguracionPaisDatos] CDP
				WHERE  CDP.Codigo = 'PAYONLINE' AND CDP.ConfiguracionPaisID = CP.ConfiguracionPaisID)
END

USE BelcorpEcuador
GO

IF NOT EXISTS(SELECT CODIGO FROM CONFIGURACIONPAISDATOS WHERE CODIGO='FlujoPagoLinea')
BEGIN
	INSERT INTO [ConfiguracionPaisDatos]([ConfiguracionPaisID], [Codigo], [CampaniaID], [Valor1],[Valor2], [Descripcion], [Estado])
	SELECT TOP 1 CP.ConfiguracionPaisID, 'FlujoPagoLinea', '0', '0',NULL, '0: No aplica 1: Flujo interno 2:Flujo externo', 1
		FROM [ConfiguracionPais] CP where CP.Codigo = 'PAYONLINE' AND
			NOT EXISTS (SELECT Codigo FROM [ConfiguracionPaisDatos] CDP
				WHERE  CDP.Codigo = 'PAYONLINE' AND CDP.ConfiguracionPaisID = CP.ConfiguracionPaisID)
END


USE BelcorpSalvador
GO

IF NOT EXISTS(SELECT CODIGO FROM CONFIGURACIONPAISDATOS WHERE CODIGO='FlujoPagoLinea')
BEGIN
	INSERT INTO [ConfiguracionPaisDatos]([ConfiguracionPaisID], [Codigo], [CampaniaID], [Valor1],[Valor2], [Descripcion], [Estado])
	SELECT TOP 1 CP.ConfiguracionPaisID, 'FlujoPagoLinea', '0', '0',NULL, '0: No aplica 1: Flujo interno 2:Flujo externo', 1
		FROM [ConfiguracionPais] CP where CP.Codigo = 'PAYONLINE' AND
			NOT EXISTS (SELECT Codigo FROM [ConfiguracionPaisDatos] CDP
				WHERE  CDP.Codigo = 'PAYONLINE' AND CDP.ConfiguracionPaisID = CP.ConfiguracionPaisID)
END

USE BelcorpPuertoRico
GO

IF NOT EXISTS(SELECT CODIGO FROM CONFIGURACIONPAISDATOS WHERE CODIGO='FlujoPagoLinea')
BEGIN
	INSERT INTO [ConfiguracionPaisDatos]([ConfiguracionPaisID], [Codigo], [CampaniaID], [Valor1],[Valor2], [Descripcion], [Estado])
	SELECT TOP 1 CP.ConfiguracionPaisID, 'FlujoPagoLinea', '0', '0',NULL, '0: No aplica 1: Flujo interno 2:Flujo externo', 1
		FROM [ConfiguracionPais] CP where CP.Codigo = 'PAYONLINE' AND
			NOT EXISTS (SELECT Codigo FROM [ConfiguracionPaisDatos] CDP
				WHERE  CDP.Codigo = 'PAYONLINE' AND CDP.ConfiguracionPaisID = CP.ConfiguracionPaisID)
END

USE BelcorpPanama
GO

IF NOT EXISTS(SELECT CODIGO FROM CONFIGURACIONPAISDATOS WHERE CODIGO='FlujoPagoLinea')
BEGIN
	INSERT INTO [ConfiguracionPaisDatos]([ConfiguracionPaisID], [Codigo], [CampaniaID], [Valor1],[Valor2], [Descripcion], [Estado])
	SELECT TOP 1 CP.ConfiguracionPaisID, 'FlujoPagoLinea', '0', '0',NULL, '0: No aplica 1: Flujo interno 2:Flujo externo', 1
		FROM [ConfiguracionPais] CP where CP.Codigo = 'PAYONLINE' AND
			NOT EXISTS (SELECT Codigo FROM [ConfiguracionPaisDatos] CDP
				WHERE  CDP.Codigo = 'PAYONLINE' AND CDP.ConfiguracionPaisID = CP.ConfiguracionPaisID)
END

USE BelcorpGuatemala
GO

IF NOT EXISTS(SELECT CODIGO FROM CONFIGURACIONPAISDATOS WHERE CODIGO='FlujoPagoLinea')
BEGIN
	INSERT INTO [ConfiguracionPaisDatos]([ConfiguracionPaisID], [Codigo], [CampaniaID], [Valor1],[Valor2], [Descripcion], [Estado])
	SELECT TOP 1 CP.ConfiguracionPaisID, 'FlujoPagoLinea', '0', '0',NULL, '0: No aplica 1: Flujo interno 2:Flujo externo', 1
		FROM [ConfiguracionPais] CP where CP.Codigo = 'PAYONLINE' AND
			NOT EXISTS (SELECT Codigo FROM [ConfiguracionPaisDatos] CDP
				WHERE  CDP.Codigo = 'PAYONLINE' AND CDP.ConfiguracionPaisID = CP.ConfiguracionPaisID)
END

USE BelcorpDominicana
GO

IF NOT EXISTS(SELECT CODIGO FROM CONFIGURACIONPAISDATOS WHERE CODIGO='FlujoPagoLinea')
BEGIN
	INSERT INTO [ConfiguracionPaisDatos]([ConfiguracionPaisID], [Codigo], [CampaniaID], [Valor1],[Valor2], [Descripcion], [Estado])
	SELECT TOP 1 CP.ConfiguracionPaisID, 'FlujoPagoLinea', '0', '0',NULL, '0: No aplica 1: Flujo interno 2:Flujo externo', 1
		FROM [ConfiguracionPais] CP where CP.Codigo = 'PAYONLINE' AND
			NOT EXISTS (SELECT Codigo FROM [ConfiguracionPaisDatos] CDP
				WHERE  CDP.Codigo = 'PAYONLINE' AND CDP.ConfiguracionPaisID = CP.ConfiguracionPaisID)
END

USE BelcorpCostaRica
GO

IF NOT EXISTS(SELECT CODIGO FROM CONFIGURACIONPAISDATOS WHERE CODIGO='FlujoPagoLinea')
BEGIN
	INSERT INTO [ConfiguracionPaisDatos]([ConfiguracionPaisID], [Codigo], [CampaniaID], [Valor1],[Valor2], [Descripcion], [Estado])
	SELECT TOP 1 CP.ConfiguracionPaisID, 'FlujoPagoLinea', '0', '0',NULL, '0: No aplica 1: Flujo interno 2:Flujo externo', 1
		FROM [ConfiguracionPais] CP where CP.Codigo = 'PAYONLINE' AND
			NOT EXISTS (SELECT Codigo FROM [ConfiguracionPaisDatos] CDP
				WHERE  CDP.Codigo = 'PAYONLINE' AND CDP.ConfiguracionPaisID = CP.ConfiguracionPaisID)
END

USE BelcorpChile
GO

IF NOT EXISTS(SELECT CODIGO FROM CONFIGURACIONPAISDATOS WHERE CODIGO='FlujoPagoLinea')
BEGIN
	INSERT INTO [ConfiguracionPaisDatos]([ConfiguracionPaisID], [Codigo], [CampaniaID], [Valor1],[Valor2], [Descripcion], [Estado])
	SELECT TOP 1 CP.ConfiguracionPaisID, 'FlujoPagoLinea', '0', '0',NULL, '0: No aplica 1: Flujo interno 2:Flujo externo', 1
		FROM [ConfiguracionPais] CP where CP.Codigo = 'PAYONLINE' AND
			NOT EXISTS (SELECT Codigo FROM [ConfiguracionPaisDatos] CDP
				WHERE  CDP.Codigo = 'PAYONLINE' AND CDP.ConfiguracionPaisID = CP.ConfiguracionPaisID)
END

USE BelcorpBolivia
GO

IF NOT EXISTS(SELECT CODIGO FROM CONFIGURACIONPAISDATOS WHERE CODIGO='FlujoPagoLinea')
BEGIN
	INSERT INTO [ConfiguracionPaisDatos]([ConfiguracionPaisID], [Codigo], [CampaniaID], [Valor1],[Valor2], [Descripcion], [Estado])
	SELECT TOP 1 CP.ConfiguracionPaisID, 'FlujoPagoLinea', '0', '0',NULL, '0: No aplica 1: Flujo interno 2:Flujo externo', 1
		FROM [ConfiguracionPais] CP where CP.Codigo = 'PAYONLINE' AND
			NOT EXISTS (SELECT Codigo FROM [ConfiguracionPaisDatos] CDP
				WHERE  CDP.Codigo = 'PAYONLINE' AND CDP.ConfiguracionPaisID = CP.ConfiguracionPaisID)
END

USE BelcorpColombia
GO

IF NOT EXISTS(SELECT CODIGO FROM CONFIGURACIONPAISDATOS WHERE CODIGO='FlujoPagoLinea')
BEGIN
	INSERT INTO [ConfiguracionPaisDatos]([ConfiguracionPaisID], [Codigo], [CampaniaID], [Valor1],[Valor2], [Descripcion], [Estado])
	SELECT TOP 1 CP.ConfiguracionPaisID, 'FlujoPagoLinea', '0', '2','https://www.zonapagos.com/t_belstar/pagos.asp', '0: No aplica 1: Flujo interno 2:Flujo externo', 1
		FROM [ConfiguracionPais] CP where CP.Codigo = 'PAYONLINE' AND
			NOT EXISTS (SELECT Codigo FROM [ConfiguracionPaisDatos] CDP
				WHERE  CDP.Codigo = 'PAYONLINE' AND CDP.ConfiguracionPaisID = CP.ConfiguracionPaisID)
END


UPDATE ConfiguracionPais 
SET ESTADO=1
WHERE CODIGO='PAYONLINE'

UPDATE TablaLogicaDatos
SET Valor = 1
WHERE Codigo = 'FLAG_ENABLE_APP'