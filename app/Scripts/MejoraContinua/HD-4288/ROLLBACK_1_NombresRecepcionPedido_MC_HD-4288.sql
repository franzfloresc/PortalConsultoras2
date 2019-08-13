IF  EXISTS (
	SELECT * 
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'pedidoweb'
	AND C.NAME = 'NombresRecepcionPedido'
	)
BEGIN
	ALTER TABLE pedidoweb
	DROP COLUMN NombresRecepcionPedido
END
GO