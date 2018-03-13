USE BelcorpPeru
GO

DECLARE @CodigoSubscripcionAutomatica VARCHAR(50) = 'SubscripcionAutomaticaAVirtualCoach'
DECLARE @CODIGO_RD VARCHAR(50) = 'RD'
DECLARE @CONFIGURACION_PAIS_ID_RD INT = 0

SELECT @CONFIGURACION_PAIS_ID_RD = CP.ConfiguracionPaisID
FROM configuracionPais CP
WHERE CP.Codigo = @CODIGO_RD

IF EXISTS(SELECT 1 FROM ConfiguracionPaisDatos
	WHERE CODIGO = @CodigoSubscripcionAutomatica AND ConfiguracionPaisID = @CONFIGURACION_PAIS_ID_RD)
BEGIN
	DELETE FROM ConfiguracionPaisDatos WHERE CODIGO = @CodigoSubscripcionAutomatica AND ConfiguracionPaisID = @CONFIGURACION_PAIS_ID_RD
END

BEGIN
	PRINT 'Insertando ' + @CodigoSubscripcionAutomatica
	INSERT INTO ConfiguracionPaisDatos
	(
	ConfiguracionPaisID
	,Codigo
	,CampaniaID
	,Valor1
	,Valor2
	,Valor3
	,Descripcion
	,Estado
	)
	VALUES
	(
	@CONFIGURACION_PAIS_ID_RD
	,@CodigoSubscripcionAutomatica
	,0
	,'1'
	,''
	,NULL
	,''
	,0
	)

END
GO

USE BelcorpMexico
GO

DECLARE @CodigoSubscripcionAutomatica VARCHAR(50) = 'SubscripcionAutomaticaAVirtualCoach'
DECLARE @CODIGO_RD VARCHAR(50) = 'RD'
DECLARE @CONFIGURACION_PAIS_ID_RD INT = 0

SELECT @CONFIGURACION_PAIS_ID_RD = CP.ConfiguracionPaisID
FROM configuracionPais CP
WHERE CP.Codigo = @CODIGO_RD

IF EXISTS(SELECT 1 FROM ConfiguracionPaisDatos
	WHERE CODIGO = @CodigoSubscripcionAutomatica AND ConfiguracionPaisID = @CONFIGURACION_PAIS_ID_RD)
BEGIN
	DELETE FROM ConfiguracionPaisDatos WHERE CODIGO = @CodigoSubscripcionAutomatica AND ConfiguracionPaisID = @CONFIGURACION_PAIS_ID_RD
END

BEGIN
	PRINT 'Insertando ' + @CodigoSubscripcionAutomatica
	INSERT INTO ConfiguracionPaisDatos
	(
	ConfiguracionPaisID
	,Codigo
	,CampaniaID
	,Valor1
	,Valor2
	,Valor3
	,Descripcion
	,Estado
	)
	VALUES
	(
	@CONFIGURACION_PAIS_ID_RD
	,@CodigoSubscripcionAutomatica
	,0
	,'1'
	,''
	,NULL
	,''
	,0
	)

END
GO

USE BelcorpColombia
GO

DECLARE @CodigoSubscripcionAutomatica VARCHAR(50) = 'SubscripcionAutomaticaAVirtualCoach'
DECLARE @CODIGO_RD VARCHAR(50) = 'RD'
DECLARE @CONFIGURACION_PAIS_ID_RD INT = 0

SELECT @CONFIGURACION_PAIS_ID_RD = CP.ConfiguracionPaisID
FROM configuracionPais CP
WHERE CP.Codigo = @CODIGO_RD

IF EXISTS(SELECT 1 FROM ConfiguracionPaisDatos
	WHERE CODIGO = @CodigoSubscripcionAutomatica AND ConfiguracionPaisID = @CONFIGURACION_PAIS_ID_RD)
BEGIN
	DELETE FROM ConfiguracionPaisDatos WHERE CODIGO = @CodigoSubscripcionAutomatica AND ConfiguracionPaisID = @CONFIGURACION_PAIS_ID_RD
END

BEGIN
	PRINT 'Insertando ' + @CodigoSubscripcionAutomatica
	INSERT INTO ConfiguracionPaisDatos
	(
	ConfiguracionPaisID
	,Codigo
	,CampaniaID
	,Valor1
	,Valor2
	,Valor3
	,Descripcion
	,Estado
	)
	VALUES
	(
	@CONFIGURACION_PAIS_ID_RD
	,@CodigoSubscripcionAutomatica
	,0
	,'1'
	,''
	,NULL
	,''
	,0
	)

END
GO

USE BelcorpVenezuela
GO

DECLARE @CodigoSubscripcionAutomatica VARCHAR(50) = 'SubscripcionAutomaticaAVirtualCoach'
DECLARE @CODIGO_RD VARCHAR(50) = 'RD'
DECLARE @CONFIGURACION_PAIS_ID_RD INT = 0

SELECT @CONFIGURACION_PAIS_ID_RD = CP.ConfiguracionPaisID
FROM configuracionPais CP
WHERE CP.Codigo = @CODIGO_RD

IF EXISTS(SELECT 1 FROM ConfiguracionPaisDatos
	WHERE CODIGO = @CodigoSubscripcionAutomatica AND ConfiguracionPaisID = @CONFIGURACION_PAIS_ID_RD)
BEGIN
	DELETE FROM ConfiguracionPaisDatos WHERE CODIGO = @CodigoSubscripcionAutomatica AND ConfiguracionPaisID = @CONFIGURACION_PAIS_ID_RD
END

BEGIN
	PRINT 'Insertando ' + @CodigoSubscripcionAutomatica
	INSERT INTO ConfiguracionPaisDatos
	(
	ConfiguracionPaisID
	,Codigo
	,CampaniaID
	,Valor1
	,Valor2
	,Valor3
	,Descripcion
	,Estado
	)
	VALUES
	(
	@CONFIGURACION_PAIS_ID_RD
	,@CodigoSubscripcionAutomatica
	,0
	,'1'
	,''
	,NULL
	,''
	,0
	)

END
GO

USE BelcorpSalvador
GO

DECLARE @CodigoSubscripcionAutomatica VARCHAR(50) = 'SubscripcionAutomaticaAVirtualCoach'
DECLARE @CODIGO_RD VARCHAR(50) = 'RD'
DECLARE @CONFIGURACION_PAIS_ID_RD INT = 0

SELECT @CONFIGURACION_PAIS_ID_RD = CP.ConfiguracionPaisID
FROM configuracionPais CP
WHERE CP.Codigo = @CODIGO_RD

IF EXISTS(SELECT 1 FROM ConfiguracionPaisDatos
	WHERE CODIGO = @CodigoSubscripcionAutomatica AND ConfiguracionPaisID = @CONFIGURACION_PAIS_ID_RD)
BEGIN
	DELETE FROM ConfiguracionPaisDatos WHERE CODIGO = @CodigoSubscripcionAutomatica AND ConfiguracionPaisID = @CONFIGURACION_PAIS_ID_RD
END

BEGIN
	PRINT 'Insertando ' + @CodigoSubscripcionAutomatica
	INSERT INTO ConfiguracionPaisDatos
	(
	ConfiguracionPaisID
	,Codigo
	,CampaniaID
	,Valor1
	,Valor2
	,Valor3
	,Descripcion
	,Estado
	)
	VALUES
	(
	@CONFIGURACION_PAIS_ID_RD
	,@CodigoSubscripcionAutomatica
	,0
	,'1'
	,''
	,NULL
	,''
	,0
	)

END
GO

USE BelcorpPuertoRico
GO

DECLARE @CodigoSubscripcionAutomatica VARCHAR(50) = 'SubscripcionAutomaticaAVirtualCoach'
DECLARE @CODIGO_RD VARCHAR(50) = 'RD'
DECLARE @CONFIGURACION_PAIS_ID_RD INT = 0

SELECT @CONFIGURACION_PAIS_ID_RD = CP.ConfiguracionPaisID
FROM configuracionPais CP
WHERE CP.Codigo = @CODIGO_RD

IF EXISTS(SELECT 1 FROM ConfiguracionPaisDatos
	WHERE CODIGO = @CodigoSubscripcionAutomatica AND ConfiguracionPaisID = @CONFIGURACION_PAIS_ID_RD)
BEGIN
	DELETE FROM ConfiguracionPaisDatos WHERE CODIGO = @CodigoSubscripcionAutomatica AND ConfiguracionPaisID = @CONFIGURACION_PAIS_ID_RD
END

BEGIN
	PRINT 'Insertando ' + @CodigoSubscripcionAutomatica
	INSERT INTO ConfiguracionPaisDatos
	(
	ConfiguracionPaisID
	,Codigo
	,CampaniaID
	,Valor1
	,Valor2
	,Valor3
	,Descripcion
	,Estado
	)
	VALUES
	(
	@CONFIGURACION_PAIS_ID_RD
	,@CodigoSubscripcionAutomatica
	,0
	,'1'
	,''
	,NULL
	,''
	,0
	)

END
GO

USE BelcorpPanama
GO

DECLARE @CodigoSubscripcionAutomatica VARCHAR(50) = 'SubscripcionAutomaticaAVirtualCoach'
DECLARE @CODIGO_RD VARCHAR(50) = 'RD'
DECLARE @CONFIGURACION_PAIS_ID_RD INT = 0

SELECT @CONFIGURACION_PAIS_ID_RD = CP.ConfiguracionPaisID
FROM configuracionPais CP
WHERE CP.Codigo = @CODIGO_RD

IF EXISTS(SELECT 1 FROM ConfiguracionPaisDatos
	WHERE CODIGO = @CodigoSubscripcionAutomatica AND ConfiguracionPaisID = @CONFIGURACION_PAIS_ID_RD)
BEGIN
	DELETE FROM ConfiguracionPaisDatos WHERE CODIGO = @CodigoSubscripcionAutomatica AND ConfiguracionPaisID = @CONFIGURACION_PAIS_ID_RD
END

BEGIN
	PRINT 'Insertando ' + @CodigoSubscripcionAutomatica
	INSERT INTO ConfiguracionPaisDatos
	(
	ConfiguracionPaisID
	,Codigo
	,CampaniaID
	,Valor1
	,Valor2
	,Valor3
	,Descripcion
	,Estado
	)
	VALUES
	(
	@CONFIGURACION_PAIS_ID_RD
	,@CodigoSubscripcionAutomatica
	,0
	,'1'
	,''
	,NULL
	,''
	,0
	)

END
GO

USE BelcorpGuatemala
GO

DECLARE @CodigoSubscripcionAutomatica VARCHAR(50) = 'SubscripcionAutomaticaAVirtualCoach'
DECLARE @CODIGO_RD VARCHAR(50) = 'RD'
DECLARE @CONFIGURACION_PAIS_ID_RD INT = 0

SELECT @CONFIGURACION_PAIS_ID_RD = CP.ConfiguracionPaisID
FROM configuracionPais CP
WHERE CP.Codigo = @CODIGO_RD

IF EXISTS(SELECT 1 FROM ConfiguracionPaisDatos
	WHERE CODIGO = @CodigoSubscripcionAutomatica AND ConfiguracionPaisID = @CONFIGURACION_PAIS_ID_RD)
BEGIN
	DELETE FROM ConfiguracionPaisDatos WHERE CODIGO = @CodigoSubscripcionAutomatica AND ConfiguracionPaisID = @CONFIGURACION_PAIS_ID_RD
END

BEGIN
	PRINT 'Insertando ' + @CodigoSubscripcionAutomatica
	INSERT INTO ConfiguracionPaisDatos
	(
	ConfiguracionPaisID
	,Codigo
	,CampaniaID
	,Valor1
	,Valor2
	,Valor3
	,Descripcion
	,Estado
	)
	VALUES
	(
	@CONFIGURACION_PAIS_ID_RD
	,@CodigoSubscripcionAutomatica
	,0
	,'1'
	,''
	,NULL
	,''
	,0
	)

END
GO

USE BelcorpEcuador
GO

DECLARE @CodigoSubscripcionAutomatica VARCHAR(50) = 'SubscripcionAutomaticaAVirtualCoach'
DECLARE @CODIGO_RD VARCHAR(50) = 'RD'
DECLARE @CONFIGURACION_PAIS_ID_RD INT = 0

SELECT @CONFIGURACION_PAIS_ID_RD = CP.ConfiguracionPaisID
FROM configuracionPais CP
WHERE CP.Codigo = @CODIGO_RD

IF EXISTS(SELECT 1 FROM ConfiguracionPaisDatos
	WHERE CODIGO = @CodigoSubscripcionAutomatica AND ConfiguracionPaisID = @CONFIGURACION_PAIS_ID_RD)
BEGIN
	DELETE FROM ConfiguracionPaisDatos WHERE CODIGO = @CodigoSubscripcionAutomatica AND ConfiguracionPaisID = @CONFIGURACION_PAIS_ID_RD
END

BEGIN
	PRINT 'Insertando ' + @CodigoSubscripcionAutomatica
	INSERT INTO ConfiguracionPaisDatos
	(
	ConfiguracionPaisID
	,Codigo
	,CampaniaID
	,Valor1
	,Valor2
	,Valor3
	,Descripcion
	,Estado
	)
	VALUES
	(
	@CONFIGURACION_PAIS_ID_RD
	,@CodigoSubscripcionAutomatica
	,0
	,'1'
	,''
	,NULL
	,''
	,0
	)

END
GO

USE BelcorpDominicana
GO

DECLARE @CodigoSubscripcionAutomatica VARCHAR(50) = 'SubscripcionAutomaticaAVirtualCoach'
DECLARE @CODIGO_RD VARCHAR(50) = 'RD'
DECLARE @CONFIGURACION_PAIS_ID_RD INT = 0

SELECT @CONFIGURACION_PAIS_ID_RD = CP.ConfiguracionPaisID
FROM configuracionPais CP
WHERE CP.Codigo = @CODIGO_RD

IF EXISTS(SELECT 1 FROM ConfiguracionPaisDatos
	WHERE CODIGO = @CodigoSubscripcionAutomatica AND ConfiguracionPaisID = @CONFIGURACION_PAIS_ID_RD)
BEGIN
	DELETE FROM ConfiguracionPaisDatos WHERE CODIGO = @CodigoSubscripcionAutomatica AND ConfiguracionPaisID = @CONFIGURACION_PAIS_ID_RD
END

BEGIN
	PRINT 'Insertando ' + @CodigoSubscripcionAutomatica
	INSERT INTO ConfiguracionPaisDatos
	(
	ConfiguracionPaisID
	,Codigo
	,CampaniaID
	,Valor1
	,Valor2
	,Valor3
	,Descripcion
	,Estado
	)
	VALUES
	(
	@CONFIGURACION_PAIS_ID_RD
	,@CodigoSubscripcionAutomatica
	,0
	,'1'
	,''
	,NULL
	,''
	,0
	)

END
GO

USE BelcorpCostaRica
GO

DECLARE @CodigoSubscripcionAutomatica VARCHAR(50) = 'SubscripcionAutomaticaAVirtualCoach'
DECLARE @CODIGO_RD VARCHAR(50) = 'RD'
DECLARE @CONFIGURACION_PAIS_ID_RD INT = 0

SELECT @CONFIGURACION_PAIS_ID_RD = CP.ConfiguracionPaisID
FROM configuracionPais CP
WHERE CP.Codigo = @CODIGO_RD

IF EXISTS(SELECT 1 FROM ConfiguracionPaisDatos
	WHERE CODIGO = @CodigoSubscripcionAutomatica AND ConfiguracionPaisID = @CONFIGURACION_PAIS_ID_RD)
BEGIN
	DELETE FROM ConfiguracionPaisDatos WHERE CODIGO = @CodigoSubscripcionAutomatica AND ConfiguracionPaisID = @CONFIGURACION_PAIS_ID_RD
END

BEGIN
	PRINT 'Insertando ' + @CodigoSubscripcionAutomatica
	INSERT INTO ConfiguracionPaisDatos
	(
	ConfiguracionPaisID
	,Codigo
	,CampaniaID
	,Valor1
	,Valor2
	,Valor3
	,Descripcion
	,Estado
	)
	VALUES
	(
	@CONFIGURACION_PAIS_ID_RD
	,@CodigoSubscripcionAutomatica
	,0
	,'1'
	,''
	,NULL
	,''
	,0
	)

END
GO

USE BelcorpChile
GO

DECLARE @CodigoSubscripcionAutomatica VARCHAR(50) = 'SubscripcionAutomaticaAVirtualCoach'
DECLARE @CODIGO_RD VARCHAR(50) = 'RD'
DECLARE @CONFIGURACION_PAIS_ID_RD INT = 0

SELECT @CONFIGURACION_PAIS_ID_RD = CP.ConfiguracionPaisID
FROM configuracionPais CP
WHERE CP.Codigo = @CODIGO_RD

IF EXISTS(SELECT 1 FROM ConfiguracionPaisDatos
	WHERE CODIGO = @CodigoSubscripcionAutomatica AND ConfiguracionPaisID = @CONFIGURACION_PAIS_ID_RD)
BEGIN
	DELETE FROM ConfiguracionPaisDatos WHERE CODIGO = @CodigoSubscripcionAutomatica AND ConfiguracionPaisID = @CONFIGURACION_PAIS_ID_RD
END

BEGIN
	PRINT 'Insertando ' + @CodigoSubscripcionAutomatica
	INSERT INTO ConfiguracionPaisDatos
	(
	ConfiguracionPaisID
	,Codigo
	,CampaniaID
	,Valor1
	,Valor2
	,Valor3
	,Descripcion
	,Estado
	)
	VALUES
	(
	@CONFIGURACION_PAIS_ID_RD
	,@CodigoSubscripcionAutomatica
	,0
	,'1'
	,''
	,NULL
	,''
	,1
	)

END
GO

USE BelcorpBolivia
GO

DECLARE @CodigoSubscripcionAutomatica VARCHAR(50) = 'SubscripcionAutomaticaAVirtualCoach'
DECLARE @CODIGO_RD VARCHAR(50) = 'RD'
DECLARE @CONFIGURACION_PAIS_ID_RD INT = 0

SELECT @CONFIGURACION_PAIS_ID_RD = CP.ConfiguracionPaisID
FROM configuracionPais CP
WHERE CP.Codigo = @CODIGO_RD

IF EXISTS(SELECT 1 FROM ConfiguracionPaisDatos
	WHERE CODIGO = @CodigoSubscripcionAutomatica AND ConfiguracionPaisID = @CONFIGURACION_PAIS_ID_RD)
BEGIN
	DELETE FROM ConfiguracionPaisDatos WHERE CODIGO = @CodigoSubscripcionAutomatica AND ConfiguracionPaisID = @CONFIGURACION_PAIS_ID_RD
END

BEGIN
	PRINT 'Insertando ' + @CodigoSubscripcionAutomatica
	INSERT INTO ConfiguracionPaisDatos
	(
	ConfiguracionPaisID
	,Codigo
	,CampaniaID
	,Valor1
	,Valor2
	,Valor3
	,Descripcion
	,Estado
	)
	VALUES
	(
	@CONFIGURACION_PAIS_ID_RD
	,@CodigoSubscripcionAutomatica
	,0
	,'1'
	,''
	,NULL
	,''
	,0
	)

END
GO

