USE BelcorpPeru
GO

IF(NOT EXISTS(SELECT * FROM CONFIGURACIONPAIS WHERE CODIGO='RESERVA_CONTADO'))
BEGIN
	INSERT INTO ConfiguracionPais(Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,OrdenBpt,MobileOrden,MobileOrdenBPT)
	VALUES('RESERVA_CONTADO',1,'Activa la reserva para pago contado',1,0,0,0,0,0,0)

	INSERT INTO [ConfiguracionPaisDatos]([ConfiguracionPaisID], [Codigo], [CampaniaID], [Valor1],[Valor2],[Valor3], [Descripcion], [Estado])
		SELECT TOP 1 CP.ConfiguracionPaisID, 'ActivaFlujoContado', 0, '1','','', 'Activa el flujo para pago contado', 1
			FROM [ConfiguracionPais] CP where CP.Codigo = 'RESERVA_CONTADO' AND
				NOT EXISTS (SELECT Codigo FROM [ConfiguracionPaisDatos] CDP
	WHERE  CDP.Codigo = 'ActivaFlujoContado' AND CDP.ConfiguracionPaisID = CP.ConfiguracionPaisID)
END

USE BelcorpMexico
GO

IF(NOT EXISTS(SELECT * FROM CONFIGURACIONPAIS WHERE CODIGO='RESERVA_CONTADO'))
BEGIN
	INSERT INTO ConfiguracionPais(Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,OrdenBpt,MobileOrden,MobileOrdenBPT)
	VALUES('RESERVA_CONTADO',1,'Activa la reserva para pago contado',1,0,0,0,0,0,0)

	INSERT INTO [ConfiguracionPaisDatos]([ConfiguracionPaisID], [Codigo], [CampaniaID], [Valor1],[Valor2],[Valor3], [Descripcion], [Estado])
		SELECT TOP 1 CP.ConfiguracionPaisID, 'ActivaFlujoContado', 0, '1','','', 'Activa el flujo para pago contado', 1
			FROM [ConfiguracionPais] CP where CP.Codigo = 'RESERVA_CONTADO' AND
				NOT EXISTS (SELECT Codigo FROM [ConfiguracionPaisDatos] CDP
	WHERE  CDP.Codigo = 'ActivaFlujoContado' AND CDP.ConfiguracionPaisID = CP.ConfiguracionPaisID)
END

USE BelcorpColombia
GO

IF(NOT EXISTS(SELECT * FROM CONFIGURACIONPAIS WHERE CODIGO='RESERVA_CONTADO'))
BEGIN
	INSERT INTO ConfiguracionPais(Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,OrdenBpt,MobileOrden,MobileOrdenBPT)
	VALUES('RESERVA_CONTADO',1,'Activa la reserva para pago contado',1,0,0,0,0,0,0)

	INSERT INTO [ConfiguracionPaisDatos]([ConfiguracionPaisID], [Codigo], [CampaniaID], [Valor1],[Valor2],[Valor3], [Descripcion], [Estado])
		SELECT TOP 1 CP.ConfiguracionPaisID, 'ActivaFlujoContado', 0, '1','','', 'Activa el flujo para pago contado', 1
			FROM [ConfiguracionPais] CP where CP.Codigo = 'RESERVA_CONTADO' AND
				NOT EXISTS (SELECT Codigo FROM [ConfiguracionPaisDatos] CDP
	WHERE  CDP.Codigo = 'ActivaFlujoContado' AND CDP.ConfiguracionPaisID = CP.ConfiguracionPaisID)
END

USE BelcorpSalvador
GO

IF(NOT EXISTS(SELECT * FROM CONFIGURACIONPAIS WHERE CODIGO='RESERVA_CONTADO'))
BEGIN
	INSERT INTO ConfiguracionPais(Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,OrdenBpt,MobileOrden,MobileOrdenBPT)
	VALUES('RESERVA_CONTADO',1,'Activa la reserva para pago contado',1,0,0,0,0,0,0)

	INSERT INTO [ConfiguracionPaisDatos]([ConfiguracionPaisID], [Codigo], [CampaniaID], [Valor1],[Valor2],[Valor3], [Descripcion], [Estado])
		SELECT TOP 1 CP.ConfiguracionPaisID, 'ActivaFlujoContado', 0, '1','','', 'Activa el flujo para pago contado', 1
			FROM [ConfiguracionPais] CP where CP.Codigo = 'RESERVA_CONTADO' AND
				NOT EXISTS (SELECT Codigo FROM [ConfiguracionPaisDatos] CDP
	WHERE  CDP.Codigo = 'ActivaFlujoContado' AND CDP.ConfiguracionPaisID = CP.ConfiguracionPaisID)
END

USE BelcorpPuertoRico
GO

IF(NOT EXISTS(SELECT * FROM CONFIGURACIONPAIS WHERE CODIGO='RESERVA_CONTADO'))
BEGIN
	INSERT INTO ConfiguracionPais(Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,OrdenBpt,MobileOrden,MobileOrdenBPT)
	VALUES('RESERVA_CONTADO',1,'Activa la reserva para pago contado',1,0,0,0,0,0,0)

	INSERT INTO [ConfiguracionPaisDatos]([ConfiguracionPaisID], [Codigo], [CampaniaID], [Valor1],[Valor2],[Valor3], [Descripcion], [Estado])
		SELECT TOP 1 CP.ConfiguracionPaisID, 'ActivaFlujoContado', 0, '1','','', 'Activa el flujo para pago contado', 1
			FROM [ConfiguracionPais] CP where CP.Codigo = 'RESERVA_CONTADO' AND
				NOT EXISTS (SELECT Codigo FROM [ConfiguracionPaisDatos] CDP
	WHERE  CDP.Codigo = 'ActivaFlujoContado' AND CDP.ConfiguracionPaisID = CP.ConfiguracionPaisID)
END

USE BelcorpPanama
GO

IF(NOT EXISTS(SELECT * FROM CONFIGURACIONPAIS WHERE CODIGO='RESERVA_CONTADO'))
BEGIN
	INSERT INTO ConfiguracionPais(Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,OrdenBpt,MobileOrden,MobileOrdenBPT)
	VALUES('RESERVA_CONTADO',1,'Activa la reserva para pago contado',1,0,0,0,0,0,0)

	INSERT INTO [ConfiguracionPaisDatos]([ConfiguracionPaisID], [Codigo], [CampaniaID], [Valor1],[Valor2],[Valor3], [Descripcion], [Estado])
		SELECT TOP 1 CP.ConfiguracionPaisID, 'ActivaFlujoContado', 0, '1','','', 'Activa el flujo para pago contado', 1
			FROM [ConfiguracionPais] CP where CP.Codigo = 'RESERVA_CONTADO' AND
				NOT EXISTS (SELECT Codigo FROM [ConfiguracionPaisDatos] CDP
	WHERE  CDP.Codigo = 'ActivaFlujoContado' AND CDP.ConfiguracionPaisID = CP.ConfiguracionPaisID)
END

USE BelcorpGuatemala
GO

IF(NOT EXISTS(SELECT * FROM CONFIGURACIONPAIS WHERE CODIGO='RESERVA_CONTADO'))
BEGIN
	INSERT INTO ConfiguracionPais(Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,OrdenBpt,MobileOrden,MobileOrdenBPT)
	VALUES('RESERVA_CONTADO',1,'Activa la reserva para pago contado',1,0,0,0,0,0,0)

	INSERT INTO [ConfiguracionPaisDatos]([ConfiguracionPaisID], [Codigo], [CampaniaID], [Valor1],[Valor2],[Valor3], [Descripcion], [Estado])
		SELECT TOP 1 CP.ConfiguracionPaisID, 'ActivaFlujoContado', 0, '1','','', 'Activa el flujo para pago contado', 1
			FROM [ConfiguracionPais] CP where CP.Codigo = 'RESERVA_CONTADO' AND
				NOT EXISTS (SELECT Codigo FROM [ConfiguracionPaisDatos] CDP
	WHERE  CDP.Codigo = 'ActivaFlujoContado' AND CDP.ConfiguracionPaisID = CP.ConfiguracionPaisID)
END

USE BelcorpEcuador
GO

IF(NOT EXISTS(SELECT * FROM CONFIGURACIONPAIS WHERE CODIGO='RESERVA_CONTADO'))
BEGIN
	INSERT INTO ConfiguracionPais(Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,OrdenBpt,MobileOrden,MobileOrdenBPT)
	VALUES('RESERVA_CONTADO',1,'Activa la reserva para pago contado',1,0,0,0,0,0,0)

	INSERT INTO [ConfiguracionPaisDatos]([ConfiguracionPaisID], [Codigo], [CampaniaID], [Valor1],[Valor2],[Valor3], [Descripcion], [Estado])
		SELECT TOP 1 CP.ConfiguracionPaisID, 'ActivaFlujoContado', 0, '1','','', 'Activa el flujo para pago contado', 1
			FROM [ConfiguracionPais] CP where CP.Codigo = 'RESERVA_CONTADO' AND
				NOT EXISTS (SELECT Codigo FROM [ConfiguracionPaisDatos] CDP
	WHERE  CDP.Codigo = 'ActivaFlujoContado' AND CDP.ConfiguracionPaisID = CP.ConfiguracionPaisID)
END

USE BelcorpDominicana
GO

IF(NOT EXISTS(SELECT * FROM CONFIGURACIONPAIS WHERE CODIGO='RESERVA_CONTADO'))
BEGIN
	INSERT INTO ConfiguracionPais(Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,OrdenBpt,MobileOrden,MobileOrdenBPT)
	VALUES('RESERVA_CONTADO',1,'Activa la reserva para pago contado',1,0,0,0,0,0,0)

	INSERT INTO [ConfiguracionPaisDatos]([ConfiguracionPaisID], [Codigo], [CampaniaID], [Valor1],[Valor2],[Valor3], [Descripcion], [Estado])
		SELECT TOP 1 CP.ConfiguracionPaisID, 'ActivaFlujoContado', 0, '1','','', 'Activa el flujo para pago contado', 1
			FROM [ConfiguracionPais] CP where CP.Codigo = 'RESERVA_CONTADO' AND
				NOT EXISTS (SELECT Codigo FROM [ConfiguracionPaisDatos] CDP
	WHERE  CDP.Codigo = 'ActivaFlujoContado' AND CDP.ConfiguracionPaisID = CP.ConfiguracionPaisID)
END

USE BelcorpCostaRica
GO

IF(NOT EXISTS(SELECT * FROM CONFIGURACIONPAIS WHERE CODIGO='RESERVA_CONTADO'))
BEGIN
	INSERT INTO ConfiguracionPais(Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,OrdenBpt,MobileOrden,MobileOrdenBPT)
	VALUES('RESERVA_CONTADO',1,'Activa la reserva para pago contado',1,0,0,0,0,0,0)

	INSERT INTO [ConfiguracionPaisDatos]([ConfiguracionPaisID], [Codigo], [CampaniaID], [Valor1],[Valor2],[Valor3], [Descripcion], [Estado])
		SELECT TOP 1 CP.ConfiguracionPaisID, 'ActivaFlujoContado', 0, '1','','', 'Activa el flujo para pago contado', 1
			FROM [ConfiguracionPais] CP where CP.Codigo = 'RESERVA_CONTADO' AND
				NOT EXISTS (SELECT Codigo FROM [ConfiguracionPaisDatos] CDP
	WHERE  CDP.Codigo = 'ActivaFlujoContado' AND CDP.ConfiguracionPaisID = CP.ConfiguracionPaisID)
END

USE BelcorpChile
GO

IF(NOT EXISTS(SELECT * FROM CONFIGURACIONPAIS WHERE CODIGO='RESERVA_CONTADO'))
BEGIN
	INSERT INTO ConfiguracionPais(Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,OrdenBpt,MobileOrden,MobileOrdenBPT)
	VALUES('RESERVA_CONTADO',1,'Activa la reserva para pago contado',1,0,0,0,0,0,0)

	INSERT INTO [ConfiguracionPaisDatos]([ConfiguracionPaisID], [Codigo], [CampaniaID], [Valor1],[Valor2],[Valor3], [Descripcion], [Estado])
		SELECT TOP 1 CP.ConfiguracionPaisID, 'ActivaFlujoContado', 0, '1','','', 'Activa el flujo para pago contado', 1
			FROM [ConfiguracionPais] CP where CP.Codigo = 'RESERVA_CONTADO' AND
				NOT EXISTS (SELECT Codigo FROM [ConfiguracionPaisDatos] CDP
	WHERE  CDP.Codigo = 'ActivaFlujoContado' AND CDP.ConfiguracionPaisID = CP.ConfiguracionPaisID)
END

USE BelcorpBolivia
GO

IF(NOT EXISTS(SELECT * FROM CONFIGURACIONPAIS WHERE CODIGO='RESERVA_CONTADO'))
BEGIN
	INSERT INTO ConfiguracionPais(Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,OrdenBpt,MobileOrden,MobileOrdenBPT)
	VALUES('RESERVA_CONTADO',1,'Activa la reserva para pago contado',1,0,0,0,0,0,0)

	INSERT INTO [ConfiguracionPaisDatos]([ConfiguracionPaisID], [Codigo], [CampaniaID], [Valor1],[Valor2],[Valor3], [Descripcion], [Estado])
		SELECT TOP 1 CP.ConfiguracionPaisID, 'ActivaFlujoContado', 0, '1','','', 'Activa el flujo para pago contado', 1
			FROM [ConfiguracionPais] CP where CP.Codigo = 'RESERVA_CONTADO' AND
				NOT EXISTS (SELECT Codigo FROM [ConfiguracionPaisDatos] CDP
	WHERE  CDP.Codigo = 'ActivaFlujoContado' AND CDP.ConfiguracionPaisID = CP.ConfiguracionPaisID)
END

