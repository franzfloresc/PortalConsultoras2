GO
IF NOT EXISTS(SELECT * FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'  AND O.NAME = 'EstrategiaProductoTemporal'
		AND C.NAME = 'NumeroLote')
BEGIN
	ALTER TABLE EstrategiaProductoTemporal ADD NumeroLote int
END
GO

GO
IF NOT EXISTS(SELECT * FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'  AND O.NAME = 'EstrategiaProductoTemporal'
		AND C.NAME = 'Pagina')
BEGIN
	ALTER TABLE EstrategiaProductoTemporal ADD Pagina int
END
GO