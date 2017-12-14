use belcorpChile_bpt
go

DECLARE @CodigoSubscripcionAutomatica VARCHAR(50) = 'SubscripcionAutomaticaAVirtualCoach'
DECLARE @CodigoActivacionUnete VARCHAR(50) = 'ActivarSuscripcionUnete'
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

IF EXISTS(SELECT 1 FROM ConfiguracionPaisDatos
	WHERE CODIGO = @CodigoActivacionUnete AND ConfiguracionPaisID = @CONFIGURACION_PAIS_ID_RD)
BEGIN
	DELETE FROM ConfiguracionPaisDatos WHERE CODIGO = @CodigoActivacionUnete AND ConfiguracionPaisID = @CONFIGURACION_PAIS_ID_RD
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
	,NULL
	,NULL
	,''
	,1
	)

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
	,NULL
	,NULL
	,''
	,1
	)
END