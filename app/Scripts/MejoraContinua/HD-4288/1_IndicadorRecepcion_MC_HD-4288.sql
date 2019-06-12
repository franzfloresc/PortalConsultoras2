IF NOT EXISTS (
	SELECT * 
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'pedidoweb'
	AND C.NAME = 'IndicadorRecepcion'
	)
BEGIN
	ALTER TABLE pedidoweb
	ADD IndicadorRecepcion bit NOT NULL CONSTRAINT [DF__PedidoWeb__IndicadorRecepcion] DEFAULT (0)
END
GO
