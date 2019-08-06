USE BelcorpPeru
GO

IF (NOT EXISTS(SELECT * FROM CONFIGURACIONPAIS WHERE CODIGO='FUNCIONALIDAD_HOME'))
BEGIN
	INSERT INTO ConfiguracionPais(Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,OrdenBpt,MobileOrden,MobileOrdenBPT)
	VALUES('FUNCIONALIDAD_HOME',1,'Prende o apaga funcionalidades del home',1,0,0,0,0,0,0)
END


INSERT INTO [ConfiguracionPaisDatos]([ConfiguracionPaisID], [Codigo], [CampaniaID], [Valor1],[Valor2],[Valor3], [Descripcion], [Estado])
SELECT TOP 1 CP.ConfiguracionPaisID, 'ENCUESTA', 0, '1','','', '1: activa funcionalidad de encuesta en el home', 1
		FROM [ConfiguracionPais] CP where CP.Codigo = 'FUNCIONALIDAD_HOME' AND
			NOT EXISTS (SELECT Codigo FROM [ConfiguracionPaisDatos] CDP
WHERE  CDP.Codigo = 'ENCUESTA' AND CDP.ConfiguracionPaisID = CP.ConfiguracionPaisID)

GO

USE BelcorpMexico
GO

IF (NOT EXISTS(SELECT * FROM CONFIGURACIONPAIS WHERE CODIGO='FUNCIONALIDAD_HOME'))
BEGIN
	INSERT INTO ConfiguracionPais(Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,OrdenBpt,MobileOrden,MobileOrdenBPT)
	VALUES('FUNCIONALIDAD_HOME',1,'Prende o apaga funcionalidades del home',1,0,0,0,0,0,0)
END


INSERT INTO [ConfiguracionPaisDatos]([ConfiguracionPaisID], [Codigo], [CampaniaID], [Valor1],[Valor2],[Valor3], [Descripcion], [Estado])
SELECT TOP 1 CP.ConfiguracionPaisID, 'ENCUESTA', 0, '1','','', '1: activa funcionalidad de encuesta en el home', 1
		FROM [ConfiguracionPais] CP where CP.Codigo = 'FUNCIONALIDAD_HOME' AND
			NOT EXISTS (SELECT Codigo FROM [ConfiguracionPaisDatos] CDP
WHERE  CDP.Codigo = 'ENCUESTA' AND CDP.ConfiguracionPaisID = CP.ConfiguracionPaisID)

GO

USE BelcorpColombia
GO

IF (NOT EXISTS(SELECT * FROM CONFIGURACIONPAIS WHERE CODIGO='FUNCIONALIDAD_HOME'))
BEGIN
	INSERT INTO ConfiguracionPais(Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,OrdenBpt,MobileOrden,MobileOrdenBPT)
	VALUES('FUNCIONALIDAD_HOME',1,'Prende o apaga funcionalidades del home',1,0,0,0,0,0,0)
END


INSERT INTO [ConfiguracionPaisDatos]([ConfiguracionPaisID], [Codigo], [CampaniaID], [Valor1],[Valor2],[Valor3], [Descripcion], [Estado])
SELECT TOP 1 CP.ConfiguracionPaisID, 'ENCUESTA', 0, '1','','', '1: activa funcionalidad de encuesta en el home', 1
		FROM [ConfiguracionPais] CP where CP.Codigo = 'FUNCIONALIDAD_HOME' AND
			NOT EXISTS (SELECT Codigo FROM [ConfiguracionPaisDatos] CDP
WHERE  CDP.Codigo = 'ENCUESTA' AND CDP.ConfiguracionPaisID = CP.ConfiguracionPaisID)

GO

USE BelcorpSalvador
GO

IF (NOT EXISTS(SELECT * FROM CONFIGURACIONPAIS WHERE CODIGO='FUNCIONALIDAD_HOME'))
BEGIN
	INSERT INTO ConfiguracionPais(Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,OrdenBpt,MobileOrden,MobileOrdenBPT)
	VALUES('FUNCIONALIDAD_HOME',1,'Prende o apaga funcionalidades del home',1,0,0,0,0,0,0)
END


INSERT INTO [ConfiguracionPaisDatos]([ConfiguracionPaisID], [Codigo], [CampaniaID], [Valor1],[Valor2],[Valor3], [Descripcion], [Estado])
SELECT TOP 1 CP.ConfiguracionPaisID, 'ENCUESTA', 0, '1','','', '1: activa funcionalidad de encuesta en el home', 1
		FROM [ConfiguracionPais] CP where CP.Codigo = 'FUNCIONALIDAD_HOME' AND
			NOT EXISTS (SELECT Codigo FROM [ConfiguracionPaisDatos] CDP
WHERE  CDP.Codigo = 'ENCUESTA' AND CDP.ConfiguracionPaisID = CP.ConfiguracionPaisID)

GO

USE BelcorpPuertoRico
GO

IF (NOT EXISTS(SELECT * FROM CONFIGURACIONPAIS WHERE CODIGO='FUNCIONALIDAD_HOME'))
BEGIN
	INSERT INTO ConfiguracionPais(Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,OrdenBpt,MobileOrden,MobileOrdenBPT)
	VALUES('FUNCIONALIDAD_HOME',1,'Prende o apaga funcionalidades del home',1,0,0,0,0,0,0)
END


INSERT INTO [ConfiguracionPaisDatos]([ConfiguracionPaisID], [Codigo], [CampaniaID], [Valor1],[Valor2],[Valor3], [Descripcion], [Estado])
SELECT TOP 1 CP.ConfiguracionPaisID, 'ENCUESTA', 0, '1','','', '1: activa funcionalidad de encuesta en el home', 1
		FROM [ConfiguracionPais] CP where CP.Codigo = 'FUNCIONALIDAD_HOME' AND
			NOT EXISTS (SELECT Codigo FROM [ConfiguracionPaisDatos] CDP
WHERE  CDP.Codigo = 'ENCUESTA' AND CDP.ConfiguracionPaisID = CP.ConfiguracionPaisID)

GO

USE BelcorpPanama
GO

IF (NOT EXISTS(SELECT * FROM CONFIGURACIONPAIS WHERE CODIGO='FUNCIONALIDAD_HOME'))
BEGIN
	INSERT INTO ConfiguracionPais(Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,OrdenBpt,MobileOrden,MobileOrdenBPT)
	VALUES('FUNCIONALIDAD_HOME',1,'Prende o apaga funcionalidades del home',1,0,0,0,0,0,0)
END


INSERT INTO [ConfiguracionPaisDatos]([ConfiguracionPaisID], [Codigo], [CampaniaID], [Valor1],[Valor2],[Valor3], [Descripcion], [Estado])
SELECT TOP 1 CP.ConfiguracionPaisID, 'ENCUESTA', 0, '1','','', '1: activa funcionalidad de encuesta en el home', 1
		FROM [ConfiguracionPais] CP where CP.Codigo = 'FUNCIONALIDAD_HOME' AND
			NOT EXISTS (SELECT Codigo FROM [ConfiguracionPaisDatos] CDP
WHERE  CDP.Codigo = 'ENCUESTA' AND CDP.ConfiguracionPaisID = CP.ConfiguracionPaisID)

GO

USE BelcorpGuatemala
GO

IF (NOT EXISTS(SELECT * FROM CONFIGURACIONPAIS WHERE CODIGO='FUNCIONALIDAD_HOME'))
BEGIN
	INSERT INTO ConfiguracionPais(Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,OrdenBpt,MobileOrden,MobileOrdenBPT)
	VALUES('FUNCIONALIDAD_HOME',1,'Prende o apaga funcionalidades del home',1,0,0,0,0,0,0)
END


INSERT INTO [ConfiguracionPaisDatos]([ConfiguracionPaisID], [Codigo], [CampaniaID], [Valor1],[Valor2],[Valor3], [Descripcion], [Estado])
SELECT TOP 1 CP.ConfiguracionPaisID, 'ENCUESTA', 0, '1','','', '1: activa funcionalidad de encuesta en el home', 1
		FROM [ConfiguracionPais] CP where CP.Codigo = 'FUNCIONALIDAD_HOME' AND
			NOT EXISTS (SELECT Codigo FROM [ConfiguracionPaisDatos] CDP
WHERE  CDP.Codigo = 'ENCUESTA' AND CDP.ConfiguracionPaisID = CP.ConfiguracionPaisID)

GO

USE BelcorpEcuador
GO

IF (NOT EXISTS(SELECT * FROM CONFIGURACIONPAIS WHERE CODIGO='FUNCIONALIDAD_HOME'))
BEGIN
	INSERT INTO ConfiguracionPais(Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,OrdenBpt,MobileOrden,MobileOrdenBPT)
	VALUES('FUNCIONALIDAD_HOME',1,'Prende o apaga funcionalidades del home',1,0,0,0,0,0,0)
END


INSERT INTO [ConfiguracionPaisDatos]([ConfiguracionPaisID], [Codigo], [CampaniaID], [Valor1],[Valor2],[Valor3], [Descripcion], [Estado])
SELECT TOP 1 CP.ConfiguracionPaisID, 'ENCUESTA', 0, '1','','', '1: activa funcionalidad de encuesta en el home', 1
		FROM [ConfiguracionPais] CP where CP.Codigo = 'FUNCIONALIDAD_HOME' AND
			NOT EXISTS (SELECT Codigo FROM [ConfiguracionPaisDatos] CDP
WHERE  CDP.Codigo = 'ENCUESTA' AND CDP.ConfiguracionPaisID = CP.ConfiguracionPaisID)

GO

USE BelcorpDominicana
GO

IF (NOT EXISTS(SELECT * FROM CONFIGURACIONPAIS WHERE CODIGO='FUNCIONALIDAD_HOME'))
BEGIN
	INSERT INTO ConfiguracionPais(Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,OrdenBpt,MobileOrden,MobileOrdenBPT)
	VALUES('FUNCIONALIDAD_HOME',1,'Prende o apaga funcionalidades del home',1,0,0,0,0,0,0)
END


INSERT INTO [ConfiguracionPaisDatos]([ConfiguracionPaisID], [Codigo], [CampaniaID], [Valor1],[Valor2],[Valor3], [Descripcion], [Estado])
SELECT TOP 1 CP.ConfiguracionPaisID, 'ENCUESTA', 0, '1','','', '1: activa funcionalidad de encuesta en el home', 1
		FROM [ConfiguracionPais] CP where CP.Codigo = 'FUNCIONALIDAD_HOME' AND
			NOT EXISTS (SELECT Codigo FROM [ConfiguracionPaisDatos] CDP
WHERE  CDP.Codigo = 'ENCUESTA' AND CDP.ConfiguracionPaisID = CP.ConfiguracionPaisID)

GO

USE BelcorpCostaRica
GO

IF (NOT EXISTS(SELECT * FROM CONFIGURACIONPAIS WHERE CODIGO='FUNCIONALIDAD_HOME'))
BEGIN
	INSERT INTO ConfiguracionPais(Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,OrdenBpt,MobileOrden,MobileOrdenBPT)
	VALUES('FUNCIONALIDAD_HOME',1,'Prende o apaga funcionalidades del home',1,0,0,0,0,0,0)
END


INSERT INTO [ConfiguracionPaisDatos]([ConfiguracionPaisID], [Codigo], [CampaniaID], [Valor1],[Valor2],[Valor3], [Descripcion], [Estado])
SELECT TOP 1 CP.ConfiguracionPaisID, 'ENCUESTA', 0, '1','','', '1: activa funcionalidad de encuesta en el home', 1
		FROM [ConfiguracionPais] CP where CP.Codigo = 'FUNCIONALIDAD_HOME' AND
			NOT EXISTS (SELECT Codigo FROM [ConfiguracionPaisDatos] CDP
WHERE  CDP.Codigo = 'ENCUESTA' AND CDP.ConfiguracionPaisID = CP.ConfiguracionPaisID)

GO

USE BelcorpChile
GO

IF (NOT EXISTS(SELECT * FROM CONFIGURACIONPAIS WHERE CODIGO='FUNCIONALIDAD_HOME'))
BEGIN
	INSERT INTO ConfiguracionPais(Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,OrdenBpt,MobileOrden,MobileOrdenBPT)
	VALUES('FUNCIONALIDAD_HOME',1,'Prende o apaga funcionalidades del home',1,0,0,0,0,0,0)
END


INSERT INTO [ConfiguracionPaisDatos]([ConfiguracionPaisID], [Codigo], [CampaniaID], [Valor1],[Valor2],[Valor3], [Descripcion], [Estado])
SELECT TOP 1 CP.ConfiguracionPaisID, 'ENCUESTA', 0, '1','','', '1: activa funcionalidad de encuesta en el home', 1
		FROM [ConfiguracionPais] CP where CP.Codigo = 'FUNCIONALIDAD_HOME' AND
			NOT EXISTS (SELECT Codigo FROM [ConfiguracionPaisDatos] CDP
WHERE  CDP.Codigo = 'ENCUESTA' AND CDP.ConfiguracionPaisID = CP.ConfiguracionPaisID)

GO

USE BelcorpBolivia
GO

IF (NOT EXISTS(SELECT * FROM CONFIGURACIONPAIS WHERE CODIGO='FUNCIONALIDAD_HOME'))
BEGIN
	INSERT INTO ConfiguracionPais(Codigo,Excluyente,Descripcion,Estado,TienePerfil,DesdeCampania,Orden,OrdenBpt,MobileOrden,MobileOrdenBPT)
	VALUES('FUNCIONALIDAD_HOME',1,'Prende o apaga funcionalidades del home',1,0,0,0,0,0,0)
END


INSERT INTO [ConfiguracionPaisDatos]([ConfiguracionPaisID], [Codigo], [CampaniaID], [Valor1],[Valor2],[Valor3], [Descripcion], [Estado])
SELECT TOP 1 CP.ConfiguracionPaisID, 'ENCUESTA', 0, '1','','', '1: activa funcionalidad de encuesta en el home', 1
		FROM [ConfiguracionPais] CP where CP.Codigo = 'FUNCIONALIDAD_HOME' AND
			NOT EXISTS (SELECT Codigo FROM [ConfiguracionPaisDatos] CDP
WHERE  CDP.Codigo = 'ENCUESTA' AND CDP.ConfiguracionPaisID = CP.ConfiguracionPaisID)

GO

