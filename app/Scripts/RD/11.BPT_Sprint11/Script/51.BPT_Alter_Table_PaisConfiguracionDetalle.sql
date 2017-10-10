USE [BelcorpPeru_BPT]
GO

IF NOT EXISTS(
	SELECT * 
	FROM SYS.COLUMNS C
		JOIN SYS.OBJECTS  O
		ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'ConfiguracionPaisDetalle'
	AND C.NAME = 'BloqueoRevistaImpresa'
	)
BEGIN
	PRINT 'Adding Column BloqueoRevistaImpresa to ConfiguracionPaisDetalle'
	ALTER TABLE ConfiguracionPaisDetalle
	ADD BloqueoRevistaImpresa BIT NULL
	CONSTRAINT DF_BloqueoRevistaImpresa_0 DEFAULT 0
END