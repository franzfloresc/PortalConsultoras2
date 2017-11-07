USE [BelcorpPeru_BPT]
GO

IF	NOT EXISTS(
	SELECT 1
	FROM TABLALOGICA
	WHERE DESCRIPCION LIKE '%REVISTA DIGITAL%'
	)
BEGIN
	DECLARE @ID_TABLA_LOGICA_REVISTA_DIGITAL INT = 0
	
	SELECT @ID_TABLA_LOGICA_REVISTA_DIGITAL = MAX(TABLALOGICAID) + 1 
	FROM TABLALOGICA

	PRINT 'INSERTING ''REVISTA DIGITAL'' FROM TABLALOGICA'

	INSERT INTO TABLALOGICA(
	TablaLogicaID
	,Descripcion
	)
	VALUES(
	@ID_TABLA_LOGICA_REVISTA_DIGITAL
	,'REVISTA DIGITAL'
	)
END