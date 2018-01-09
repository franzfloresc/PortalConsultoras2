USE BelcorpPeru
GO

DECLARE @CodigoActivacionUnete VARCHAR(50) = 'ActivarSuscripcionUnete'
DECLARE @CODIGO_RD VARCHAR(50) = 'RD'
DECLARE @CONFIGURACION_PAIS_ID_RD INT = 0

SELECT @CONFIGURACION_PAIS_ID_RD = CP.ConfiguracionPaisID
FROM configuracionPais CP
WHERE CP.Codigo = @CODIGO_RD

IF EXISTS(SELECT 1 FROM ConfiguracionPaisDatos
	WHERE CODIGO = @CodigoActivacionUnete AND ConfiguracionPaisID = @CONFIGURACION_PAIS_ID_RD)
BEGIN
	DELETE FROM ConfiguracionPaisDatos WHERE CODIGO = @CodigoActivacionUnete AND ConfiguracionPaisID = @CONFIGURACION_PAIS_ID_RD
END

BEGIN
	PRINT 'Insertando ' + @CodigoActivacionUnete
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
	,@CodigoActivacionUnete
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

DECLARE @CodigoActivacionUnete VARCHAR(50) = 'ActivarSuscripcionUnete'
DECLARE @CODIGO_RD VARCHAR(50) = 'RD'
DECLARE @CONFIGURACION_PAIS_ID_RD INT = 0

SELECT @CONFIGURACION_PAIS_ID_RD = CP.ConfiguracionPaisID
FROM configuracionPais CP
WHERE CP.Codigo = @CODIGO_RD

IF EXISTS(SELECT 1 FROM ConfiguracionPaisDatos
	WHERE CODIGO = @CodigoActivacionUnete AND ConfiguracionPaisID = @CONFIGURACION_PAIS_ID_RD)
BEGIN
	DELETE FROM ConfiguracionPaisDatos WHERE CODIGO = @CodigoActivacionUnete AND ConfiguracionPaisID = @CONFIGURACION_PAIS_ID_RD
END

BEGIN
	PRINT 'Insertando ' + @CodigoActivacionUnete
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
	,@CodigoActivacionUnete
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

DECLARE @CodigoActivacionUnete VARCHAR(50) = 'ActivarSuscripcionUnete'
DECLARE @CODIGO_RD VARCHAR(50) = 'RD'
DECLARE @CONFIGURACION_PAIS_ID_RD INT = 0

SELECT @CONFIGURACION_PAIS_ID_RD = CP.ConfiguracionPaisID
FROM configuracionPais CP
WHERE CP.Codigo = @CODIGO_RD

IF EXISTS(SELECT 1 FROM ConfiguracionPaisDatos
	WHERE CODIGO = @CodigoActivacionUnete AND ConfiguracionPaisID = @CONFIGURACION_PAIS_ID_RD)
BEGIN
	DELETE FROM ConfiguracionPaisDatos WHERE CODIGO = @CodigoActivacionUnete AND ConfiguracionPaisID = @CONFIGURACION_PAIS_ID_RD
END

BEGIN
	PRINT 'Insertando ' + @CodigoActivacionUnete
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
	,@CodigoActivacionUnete
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

DECLARE @CodigoActivacionUnete VARCHAR(50) = 'ActivarSuscripcionUnete'
DECLARE @CODIGO_RD VARCHAR(50) = 'RD'
DECLARE @CONFIGURACION_PAIS_ID_RD INT = 0

SELECT @CONFIGURACION_PAIS_ID_RD = CP.ConfiguracionPaisID
FROM configuracionPais CP
WHERE CP.Codigo = @CODIGO_RD

IF EXISTS(SELECT 1 FROM ConfiguracionPaisDatos
	WHERE CODIGO = @CodigoActivacionUnete AND ConfiguracionPaisID = @CONFIGURACION_PAIS_ID_RD)
BEGIN
	DELETE FROM ConfiguracionPaisDatos WHERE CODIGO = @CodigoActivacionUnete AND ConfiguracionPaisID = @CONFIGURACION_PAIS_ID_RD
END

BEGIN
	PRINT 'Insertando ' + @CodigoActivacionUnete
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
	,@CodigoActivacionUnete
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

DECLARE @CodigoActivacionUnete VARCHAR(50) = 'ActivarSuscripcionUnete'
DECLARE @CODIGO_RD VARCHAR(50) = 'RD'
DECLARE @CONFIGURACION_PAIS_ID_RD INT = 0

SELECT @CONFIGURACION_PAIS_ID_RD = CP.ConfiguracionPaisID
FROM configuracionPais CP
WHERE CP.Codigo = @CODIGO_RD

IF EXISTS(SELECT 1 FROM ConfiguracionPaisDatos
	WHERE CODIGO = @CodigoActivacionUnete AND ConfiguracionPaisID = @CONFIGURACION_PAIS_ID_RD)
BEGIN
	DELETE FROM ConfiguracionPaisDatos WHERE CODIGO = @CodigoActivacionUnete AND ConfiguracionPaisID = @CONFIGURACION_PAIS_ID_RD
END

BEGIN
	PRINT 'Insertando ' + @CodigoActivacionUnete
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
	,@CodigoActivacionUnete
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

DECLARE @CodigoActivacionUnete VARCHAR(50) = 'ActivarSuscripcionUnete'
DECLARE @CODIGO_RD VARCHAR(50) = 'RD'
DECLARE @CONFIGURACION_PAIS_ID_RD INT = 0

SELECT @CONFIGURACION_PAIS_ID_RD = CP.ConfiguracionPaisID
FROM configuracionPais CP
WHERE CP.Codigo = @CODIGO_RD

IF EXISTS(SELECT 1 FROM ConfiguracionPaisDatos
	WHERE CODIGO = @CodigoActivacionUnete AND ConfiguracionPaisID = @CONFIGURACION_PAIS_ID_RD)
BEGIN
	DELETE FROM ConfiguracionPaisDatos WHERE CODIGO = @CodigoActivacionUnete AND ConfiguracionPaisID = @CONFIGURACION_PAIS_ID_RD
END

BEGIN
	PRINT 'Insertando ' + @CodigoActivacionUnete
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
	,@CodigoActivacionUnete
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

DECLARE @CodigoActivacionUnete VARCHAR(50) = 'ActivarSuscripcionUnete'
DECLARE @CODIGO_RD VARCHAR(50) = 'RD'
DECLARE @CONFIGURACION_PAIS_ID_RD INT = 0

SELECT @CONFIGURACION_PAIS_ID_RD = CP.ConfiguracionPaisID
FROM configuracionPais CP
WHERE CP.Codigo = @CODIGO_RD

IF EXISTS(SELECT 1 FROM ConfiguracionPaisDatos
	WHERE CODIGO = @CodigoActivacionUnete AND ConfiguracionPaisID = @CONFIGURACION_PAIS_ID_RD)
BEGIN
	DELETE FROM ConfiguracionPaisDatos WHERE CODIGO = @CodigoActivacionUnete AND ConfiguracionPaisID = @CONFIGURACION_PAIS_ID_RD
END

BEGIN
	PRINT 'Insertando ' + @CodigoActivacionUnete
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
	,@CodigoActivacionUnete
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

DECLARE @CodigoActivacionUnete VARCHAR(50) = 'ActivarSuscripcionUnete'
DECLARE @CODIGO_RD VARCHAR(50) = 'RD'
DECLARE @CONFIGURACION_PAIS_ID_RD INT = 0

SELECT @CONFIGURACION_PAIS_ID_RD = CP.ConfiguracionPaisID
FROM configuracionPais CP
WHERE CP.Codigo = @CODIGO_RD

IF EXISTS(SELECT 1 FROM ConfiguracionPaisDatos
	WHERE CODIGO = @CodigoActivacionUnete AND ConfiguracionPaisID = @CONFIGURACION_PAIS_ID_RD)
BEGIN
	DELETE FROM ConfiguracionPaisDatos WHERE CODIGO = @CodigoActivacionUnete AND ConfiguracionPaisID = @CONFIGURACION_PAIS_ID_RD
END

BEGIN
	PRINT 'Insertando ' + @CodigoActivacionUnete
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
	,@CodigoActivacionUnete
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

DECLARE @CodigoActivacionUnete VARCHAR(50) = 'ActivarSuscripcionUnete'
DECLARE @CODIGO_RD VARCHAR(50) = 'RD'
DECLARE @CONFIGURACION_PAIS_ID_RD INT = 0

SELECT @CONFIGURACION_PAIS_ID_RD = CP.ConfiguracionPaisID
FROM configuracionPais CP
WHERE CP.Codigo = @CODIGO_RD

IF EXISTS(SELECT 1 FROM ConfiguracionPaisDatos
	WHERE CODIGO = @CodigoActivacionUnete AND ConfiguracionPaisID = @CONFIGURACION_PAIS_ID_RD)
BEGIN
	DELETE FROM ConfiguracionPaisDatos WHERE CODIGO = @CodigoActivacionUnete AND ConfiguracionPaisID = @CONFIGURACION_PAIS_ID_RD
END

BEGIN
	PRINT 'Insertando ' + @CodigoActivacionUnete
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
	,@CodigoActivacionUnete
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

DECLARE @CodigoActivacionUnete VARCHAR(50) = 'ActivarSuscripcionUnete'
DECLARE @CODIGO_RD VARCHAR(50) = 'RD'
DECLARE @CONFIGURACION_PAIS_ID_RD INT = 0

SELECT @CONFIGURACION_PAIS_ID_RD = CP.ConfiguracionPaisID
FROM configuracionPais CP
WHERE CP.Codigo = @CODIGO_RD

IF EXISTS(SELECT 1 FROM ConfiguracionPaisDatos
	WHERE CODIGO = @CodigoActivacionUnete AND ConfiguracionPaisID = @CONFIGURACION_PAIS_ID_RD)
BEGIN
	DELETE FROM ConfiguracionPaisDatos WHERE CODIGO = @CodigoActivacionUnete AND ConfiguracionPaisID = @CONFIGURACION_PAIS_ID_RD
END

BEGIN
	PRINT 'Insertando ' + @CodigoActivacionUnete
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
	,@CodigoActivacionUnete
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

DECLARE @CodigoActivacionUnete VARCHAR(50) = 'ActivarSuscripcionUnete'
DECLARE @CODIGO_RD VARCHAR(50) = 'RD'
DECLARE @CONFIGURACION_PAIS_ID_RD INT = 0

SELECT @CONFIGURACION_PAIS_ID_RD = CP.ConfiguracionPaisID
FROM configuracionPais CP
WHERE CP.Codigo = @CODIGO_RD

IF EXISTS(SELECT 1 FROM ConfiguracionPaisDatos
	WHERE CODIGO = @CodigoActivacionUnete AND ConfiguracionPaisID = @CONFIGURACION_PAIS_ID_RD)
BEGIN
	DELETE FROM ConfiguracionPaisDatos WHERE CODIGO = @CodigoActivacionUnete AND ConfiguracionPaisID = @CONFIGURACION_PAIS_ID_RD
END

BEGIN
	PRINT 'Insertando ' + @CodigoActivacionUnete
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
	,@CodigoActivacionUnete
	,0
	,'1'
	,''
	,NULL
	,''
	,1
	)
END
GO

USE BelcorpChile
GO

DECLARE @CodigoActivacionUnete VARCHAR(50) = 'ActivarSuscripcionUnete'
DECLARE @CODIGO_RD VARCHAR(50) = 'RD'
DECLARE @CONFIGURACION_PAIS_ID_RD INT = 0

SELECT @CONFIGURACION_PAIS_ID_RD = CP.ConfiguracionPaisID
FROM configuracionPais CP
WHERE CP.Codigo = @CODIGO_RD

IF EXISTS(SELECT 1 FROM ConfiguracionPaisDatos
	WHERE CODIGO = @CodigoActivacionUnete AND ConfiguracionPaisID = @CONFIGURACION_PAIS_ID_RD)
BEGIN
	DELETE FROM ConfiguracionPaisDatos WHERE CODIGO = @CodigoActivacionUnete AND ConfiguracionPaisID = @CONFIGURACION_PAIS_ID_RD
END

BEGIN
	PRINT 'Insertando ' + @CodigoActivacionUnete
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
	,@CodigoActivacionUnete
	,0
	,'1'
	,''
	,NULL
	,''
	,0
	)
END
GO

USE BelcorpBolivia
GO

DECLARE @CodigoActivacionUnete VARCHAR(50) = 'ActivarSuscripcionUnete'
DECLARE @CODIGO_RD VARCHAR(50) = 'RD'
DECLARE @CONFIGURACION_PAIS_ID_RD INT = 0

SELECT @CONFIGURACION_PAIS_ID_RD = CP.ConfiguracionPaisID
FROM configuracionPais CP
WHERE CP.Codigo = @CODIGO_RD

IF EXISTS(SELECT 1 FROM ConfiguracionPaisDatos
	WHERE CODIGO = @CodigoActivacionUnete AND ConfiguracionPaisID = @CONFIGURACION_PAIS_ID_RD)
BEGIN
	DELETE FROM ConfiguracionPaisDatos WHERE CODIGO = @CodigoActivacionUnete AND ConfiguracionPaisID = @CONFIGURACION_PAIS_ID_RD
END

BEGIN
	PRINT 'Insertando ' + @CodigoActivacionUnete
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
	,@CodigoActivacionUnete
	,0
	,'1'
	,''
	,NULL
	,''
	,0
	)
END
GO

