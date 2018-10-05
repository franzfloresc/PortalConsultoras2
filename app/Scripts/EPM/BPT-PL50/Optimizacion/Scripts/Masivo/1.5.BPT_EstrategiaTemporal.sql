GO
IF NOT EXISTS(SELECT * FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'  AND O.NAME = 'EstrategiaTemporal'
		AND C.NAME = 'CodigoTipoEstrategia')
BEGIN
	ALTER TABLE EstrategiaTemporal ADD CodigoTipoEstrategia varchar(100)
END
GO
GO
IF NOT EXISTS(SELECT * FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'  AND O.NAME = 'EstrategiaTemporal'
		AND C.NAME = 'Pagina')
BEGIN
	ALTER TABLE EstrategiaTemporal ADD Pagina int
END
GO
