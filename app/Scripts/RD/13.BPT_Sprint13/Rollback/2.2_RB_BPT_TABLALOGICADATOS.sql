USE [BelcorpPeru_BPT]
GO

DECLARE @ID_TABLA_LOGICA_REVISTA_DIGITAL INT = 0

SELECT @ID_TABLA_LOGICA_REVISTA_DIGITAL = TL.TABLALOGICAID
FROM TABLALOGICA TL
WHERE TL.DESCRIPCION = 'REVISTA DIGITAL'

IF	EXISTS(
	SELECT TLD.*
	FROM TABLALOGICADATOS TLD
	WHERE TABLALOGICAID = @ID_TABLA_LOGICA_REVISTA_DIGITAL
	AND CODIGO = 'Cat�logos'
	)
BEGIN
	PRINT 'DELETING TABLALOGICADATOS ''Cat�logos'''

	DELETE TLD
	FROM TABLALOGICADATOS TLD
	WHERE TABLALOGICAID = @ID_TABLA_LOGICA_REVISTA_DIGITAL
	AND CODIGO = 'Cat�logos'
END