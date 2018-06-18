GO
USE BelcorpPeru
GO
GO
IF EXISTS(SELECT * FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'  AND O.NAME = 'EstrategiaProductoTemporal'
		AND C.NAME = 'NumeroLote')
BEGIN
	ALTER TABLE EstrategiaProductoTemporal DROP COLUMN NumeroLote;
END
GO

GO
IF EXISTS(SELECT * FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'  AND O.NAME = 'EstrategiaProductoTemporal'
		AND C.NAME = 'Pagina')
BEGIN
	ALTER TABLE EstrategiaProductoTemporal DROP COLUMN Pagina;
END
GO

GO
USE BelcorpMexico
GO
GO
IF EXISTS(SELECT * FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'  AND O.NAME = 'EstrategiaProductoTemporal'
		AND C.NAME = 'NumeroLote')
BEGIN
	ALTER TABLE EstrategiaProductoTemporal DROP COLUMN NumeroLote;
END
GO

GO
IF EXISTS(SELECT * FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'  AND O.NAME = 'EstrategiaProductoTemporal'
		AND C.NAME = 'Pagina')
BEGIN
	ALTER TABLE EstrategiaProductoTemporal DROP COLUMN Pagina;
END
GO

GO
USE BelcorpColombia
GO
GO
IF EXISTS(SELECT * FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'  AND O.NAME = 'EstrategiaProductoTemporal'
		AND C.NAME = 'NumeroLote')
BEGIN
	ALTER TABLE EstrategiaProductoTemporal DROP COLUMN NumeroLote;
END
GO

GO
IF EXISTS(SELECT * FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'  AND O.NAME = 'EstrategiaProductoTemporal'
		AND C.NAME = 'Pagina')
BEGIN
	ALTER TABLE EstrategiaProductoTemporal DROP COLUMN Pagina;
END
GO

GO
USE BelcorpSalvador
GO
GO
IF EXISTS(SELECT * FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'  AND O.NAME = 'EstrategiaProductoTemporal'
		AND C.NAME = 'NumeroLote')
BEGIN
	ALTER TABLE EstrategiaProductoTemporal DROP COLUMN NumeroLote;
END
GO

GO
IF EXISTS(SELECT * FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'  AND O.NAME = 'EstrategiaProductoTemporal'
		AND C.NAME = 'Pagina')
BEGIN
	ALTER TABLE EstrategiaProductoTemporal DROP COLUMN Pagina;
END
GO

GO
USE BelcorpPuertoRico
GO
GO
IF EXISTS(SELECT * FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'  AND O.NAME = 'EstrategiaProductoTemporal'
		AND C.NAME = 'NumeroLote')
BEGIN
	ALTER TABLE EstrategiaProductoTemporal DROP COLUMN NumeroLote;
END
GO

GO
IF EXISTS(SELECT * FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'  AND O.NAME = 'EstrategiaProductoTemporal'
		AND C.NAME = 'Pagina')
BEGIN
	ALTER TABLE EstrategiaProductoTemporal DROP COLUMN Pagina;
END
GO

GO
USE BelcorpPanama
GO
GO
IF EXISTS(SELECT * FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'  AND O.NAME = 'EstrategiaProductoTemporal'
		AND C.NAME = 'NumeroLote')
BEGIN
	ALTER TABLE EstrategiaProductoTemporal DROP COLUMN NumeroLote;
END
GO

GO
IF EXISTS(SELECT * FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'  AND O.NAME = 'EstrategiaProductoTemporal'
		AND C.NAME = 'Pagina')
BEGIN
	ALTER TABLE EstrategiaProductoTemporal DROP COLUMN Pagina;
END
GO

GO
USE BelcorpGuatemala
GO
GO
IF EXISTS(SELECT * FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'  AND O.NAME = 'EstrategiaProductoTemporal'
		AND C.NAME = 'NumeroLote')
BEGIN
	ALTER TABLE EstrategiaProductoTemporal DROP COLUMN NumeroLote;
END
GO

GO
IF EXISTS(SELECT * FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'  AND O.NAME = 'EstrategiaProductoTemporal'
		AND C.NAME = 'Pagina')
BEGIN
	ALTER TABLE EstrategiaProductoTemporal DROP COLUMN Pagina;
END
GO

GO
USE BelcorpEcuador
GO
GO
IF EXISTS(SELECT * FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'  AND O.NAME = 'EstrategiaProductoTemporal'
		AND C.NAME = 'NumeroLote')
BEGIN
	ALTER TABLE EstrategiaProductoTemporal DROP COLUMN NumeroLote;
END
GO

GO
IF EXISTS(SELECT * FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'  AND O.NAME = 'EstrategiaProductoTemporal'
		AND C.NAME = 'Pagina')
BEGIN
	ALTER TABLE EstrategiaProductoTemporal DROP COLUMN Pagina;
END
GO

GO
USE BelcorpDominicana
GO
GO
IF EXISTS(SELECT * FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'  AND O.NAME = 'EstrategiaProductoTemporal'
		AND C.NAME = 'NumeroLote')
BEGIN
	ALTER TABLE EstrategiaProductoTemporal DROP COLUMN NumeroLote;
END
GO

GO
IF EXISTS(SELECT * FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'  AND O.NAME = 'EstrategiaProductoTemporal'
		AND C.NAME = 'Pagina')
BEGIN
	ALTER TABLE EstrategiaProductoTemporal DROP COLUMN Pagina;
END
GO

GO
USE BelcorpCostaRica
GO
GO
IF EXISTS(SELECT * FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'  AND O.NAME = 'EstrategiaProductoTemporal'
		AND C.NAME = 'NumeroLote')
BEGIN
	ALTER TABLE EstrategiaProductoTemporal DROP COLUMN NumeroLote;
END
GO

GO
IF EXISTS(SELECT * FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'  AND O.NAME = 'EstrategiaProductoTemporal'
		AND C.NAME = 'Pagina')
BEGIN
	ALTER TABLE EstrategiaProductoTemporal DROP COLUMN Pagina;
END
GO

GO
USE BelcorpChile
GO
GO
IF EXISTS(SELECT * FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'  AND O.NAME = 'EstrategiaProductoTemporal'
		AND C.NAME = 'NumeroLote')
BEGIN
	ALTER TABLE EstrategiaProductoTemporal DROP COLUMN NumeroLote;
END
GO

GO
IF EXISTS(SELECT * FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'  AND O.NAME = 'EstrategiaProductoTemporal'
		AND C.NAME = 'Pagina')
BEGIN
	ALTER TABLE EstrategiaProductoTemporal DROP COLUMN Pagina;
END
GO

GO
USE BelcorpBolivia
GO
GO
IF EXISTS(SELECT * FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'  AND O.NAME = 'EstrategiaProductoTemporal'
		AND C.NAME = 'NumeroLote')
BEGIN
	ALTER TABLE EstrategiaProductoTemporal DROP COLUMN NumeroLote;
END
GO

GO
IF EXISTS(SELECT * FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'  AND O.NAME = 'EstrategiaProductoTemporal'
		AND C.NAME = 'Pagina')
BEGIN
	ALTER TABLE EstrategiaProductoTemporal DROP COLUMN Pagina;
END
GO

GO
