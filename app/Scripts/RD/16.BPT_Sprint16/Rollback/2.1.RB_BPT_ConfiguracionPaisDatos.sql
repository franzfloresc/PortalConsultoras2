use belcorpChile_bpt
go

DECLARE @CodigoSubscripcionAutomatica VARCHAR(50) = 'SubscripcionAutomaticaAVirtualCoach'
IF EXISTS(
	SELECT 1 
	FROM ConfiguracionPaisDatos
	WHERE CODIGO = @CodigoSubscripcionAutomatica)
BEGIN
	PRINT 'Eliminando ' +@CodigoSubscripcionAutomatica

	DELETE
	FROM ConfiguracionPaisDatos
	WHERE Codigo = @CodigoSubscripcionAutomatica
END