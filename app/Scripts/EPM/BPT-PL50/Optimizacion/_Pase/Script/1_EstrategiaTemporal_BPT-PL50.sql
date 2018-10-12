GO
USE BelcorpPeru
GO
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


GO
USE BelcorpMexico
GO
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


GO
USE BelcorpColombia
GO
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


GO
USE BelcorpSalvador
GO
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


GO
USE BelcorpPuertoRico
GO
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


GO
USE BelcorpPanama
GO
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


GO
USE BelcorpGuatemala
GO
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


GO
USE BelcorpEcuador
GO
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


GO
USE BelcorpDominicana
GO
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


GO
USE BelcorpCostaRica
GO
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


GO
USE BelcorpChile
GO
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


GO
USE BelcorpBolivia
GO
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


GO
