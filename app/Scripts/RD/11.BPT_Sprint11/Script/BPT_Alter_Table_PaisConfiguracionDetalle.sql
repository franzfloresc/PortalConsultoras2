IF NOT EXISTS(
	SELECT * 
	FROM SYS.COLUMNS C
		JOIN SYS.OBJECTS  O
		ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'CONFIGURACIONPAISDETALLE'
	AND C.NAME = 'BloqueoRevistaImpresa'
	)
	ALTER TABLE CONFIGURACIONPAISDETALLE
	ADD BloqueoRevistaImpresa BIT