use belcorpChile_bpt
go

DECLARE @CodigoSubscripcionAutomatica VARCHAR(50) = 'SubscripcionAutomaticaAVirtualCoach'

IF NOT EXISTS(
	SELECT 1 
	FROM ConfiguracionPaisDatos
	WHERE CODIGO = @CodigoSubscripcionAutomatica)
BEGIN
	DECLARE @CODIGO_RD VARCHAR(50) = 'RD'
	DECLARE @CONFIGURACION_PAIS_ID_RD INT = 0

	SELECT @CONFIGURACION_PAIS_ID_RD = CP.ConfiguracionPaisID
	FROM configuracionPais CP
	WHERE CP.Codigo = @CODIGO_RD

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
END