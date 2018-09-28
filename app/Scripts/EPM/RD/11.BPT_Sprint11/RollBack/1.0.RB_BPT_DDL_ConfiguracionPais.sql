USE BelcorpPeru
GO

GO
IF EXISTS(
	SELECT * 
	FROM SYS.COLUMNS C
		JOIN SYS.OBJECTS  O
		ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'ConfiguracionPais'
	AND C.NAME = 'MobileOrden'
	)
BEGIN
	ALTER TABLE ConfiguracionPais 
	DROP CONSTRAINT MobileOrden_def
	
	ALTER TABLE ConfiguracionPais
	DROP COLUMN MobileOrden
END

GO

IF EXISTS(
	SELECT * 
	FROM SYS.COLUMNS C
		JOIN SYS.OBJECTS  O
		ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'ConfiguracionPais'
	AND C.NAME = 'MobileOrden'
	)
BEGIN
	ALTER TABLE ConfiguracionPais 
	DROP CONSTRAINT MobileOrdenBPT_def
	
	ALTER TABLE ConfiguracionPais
	DROP COLUMN MobileOrdenBPT
END
GO
/*END*/
GO

USE BelcorpMexico
GO

GO
IF EXISTS(
	SELECT * 
	FROM SYS.COLUMNS C
		JOIN SYS.OBJECTS  O
		ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'ConfiguracionPais'
	AND C.NAME = 'MobileOrden'
	)
BEGIN
	ALTER TABLE ConfiguracionPais 
	DROP CONSTRAINT MobileOrden_def
	
	ALTER TABLE ConfiguracionPais
	DROP COLUMN MobileOrden
END

GO

IF EXISTS(
	SELECT * 
	FROM SYS.COLUMNS C
		JOIN SYS.OBJECTS  O
		ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'ConfiguracionPais'
	AND C.NAME = 'MobileOrden'
	)
BEGIN
	ALTER TABLE ConfiguracionPais 
	DROP CONSTRAINT MobileOrdenBPT_def
	
	ALTER TABLE ConfiguracionPais
	DROP COLUMN MobileOrdenBPT
END
GO
/*END*/
GO

USE BelcorpColombia
GO

GO
IF EXISTS(
	SELECT * 
	FROM SYS.COLUMNS C
		JOIN SYS.OBJECTS  O
		ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'ConfiguracionPais'
	AND C.NAME = 'MobileOrden'
	)
BEGIN
	ALTER TABLE ConfiguracionPais 
	DROP CONSTRAINT MobileOrden_def
	
	ALTER TABLE ConfiguracionPais
	DROP COLUMN MobileOrden
END

GO

IF EXISTS(
	SELECT * 
	FROM SYS.COLUMNS C
		JOIN SYS.OBJECTS  O
		ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'ConfiguracionPais'
	AND C.NAME = 'MobileOrden'
	)
BEGIN
	ALTER TABLE ConfiguracionPais 
	DROP CONSTRAINT MobileOrdenBPT_def
	
	ALTER TABLE ConfiguracionPais
	DROP COLUMN MobileOrdenBPT
END
GO
/*END*/
GO

USE BelcorpVenezuela
GO

GO
IF EXISTS(
	SELECT * 
	FROM SYS.COLUMNS C
		JOIN SYS.OBJECTS  O
		ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'ConfiguracionPais'
	AND C.NAME = 'MobileOrden'
	)
BEGIN
	ALTER TABLE ConfiguracionPais 
	DROP CONSTRAINT MobileOrden_def
	
	ALTER TABLE ConfiguracionPais
	DROP COLUMN MobileOrden
END

GO

IF EXISTS(
	SELECT * 
	FROM SYS.COLUMNS C
		JOIN SYS.OBJECTS  O
		ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'ConfiguracionPais'
	AND C.NAME = 'MobileOrden'
	)
BEGIN
	ALTER TABLE ConfiguracionPais 
	DROP CONSTRAINT MobileOrdenBPT_def
	
	ALTER TABLE ConfiguracionPais
	DROP COLUMN MobileOrdenBPT
END
GO
/*END*/
GO

USE BelcorpSalvador
GO

GO
IF EXISTS(
	SELECT * 
	FROM SYS.COLUMNS C
		JOIN SYS.OBJECTS  O
		ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'ConfiguracionPais'
	AND C.NAME = 'MobileOrden'
	)
BEGIN
	ALTER TABLE ConfiguracionPais 
	DROP CONSTRAINT MobileOrden_def
	
	ALTER TABLE ConfiguracionPais
	DROP COLUMN MobileOrden
END

GO

IF EXISTS(
	SELECT * 
	FROM SYS.COLUMNS C
		JOIN SYS.OBJECTS  O
		ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'ConfiguracionPais'
	AND C.NAME = 'MobileOrden'
	)
BEGIN
	ALTER TABLE ConfiguracionPais 
	DROP CONSTRAINT MobileOrdenBPT_def
	
	ALTER TABLE ConfiguracionPais
	DROP COLUMN MobileOrdenBPT
END
GO
/*END*/
GO

USE BelcorpPuertoRico
GO

GO
IF EXISTS(
	SELECT * 
	FROM SYS.COLUMNS C
		JOIN SYS.OBJECTS  O
		ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'ConfiguracionPais'
	AND C.NAME = 'MobileOrden'
	)
BEGIN
	ALTER TABLE ConfiguracionPais 
	DROP CONSTRAINT MobileOrden_def
	
	ALTER TABLE ConfiguracionPais
	DROP COLUMN MobileOrden
END

GO

IF EXISTS(
	SELECT * 
	FROM SYS.COLUMNS C
		JOIN SYS.OBJECTS  O
		ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'ConfiguracionPais'
	AND C.NAME = 'MobileOrden'
	)
BEGIN
	ALTER TABLE ConfiguracionPais 
	DROP CONSTRAINT MobileOrdenBPT_def
	
	ALTER TABLE ConfiguracionPais
	DROP COLUMN MobileOrdenBPT
END
GO
/*END*/
GO

USE BelcorpPanama
GO

GO
IF EXISTS(
	SELECT * 
	FROM SYS.COLUMNS C
		JOIN SYS.OBJECTS  O
		ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'ConfiguracionPais'
	AND C.NAME = 'MobileOrden'
	)
BEGIN
	ALTER TABLE ConfiguracionPais 
	DROP CONSTRAINT MobileOrden_def
	
	ALTER TABLE ConfiguracionPais
	DROP COLUMN MobileOrden
END

GO

IF EXISTS(
	SELECT * 
	FROM SYS.COLUMNS C
		JOIN SYS.OBJECTS  O
		ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'ConfiguracionPais'
	AND C.NAME = 'MobileOrden'
	)
BEGIN
	ALTER TABLE ConfiguracionPais 
	DROP CONSTRAINT MobileOrdenBPT_def
	
	ALTER TABLE ConfiguracionPais
	DROP COLUMN MobileOrdenBPT
END
GO
/*END*/
GO

USE BelcorpGuatemala
GO

GO
IF EXISTS(
	SELECT * 
	FROM SYS.COLUMNS C
		JOIN SYS.OBJECTS  O
		ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'ConfiguracionPais'
	AND C.NAME = 'MobileOrden'
	)
BEGIN
	ALTER TABLE ConfiguracionPais 
	DROP CONSTRAINT MobileOrden_def
	
	ALTER TABLE ConfiguracionPais
	DROP COLUMN MobileOrden
END

GO

IF EXISTS(
	SELECT * 
	FROM SYS.COLUMNS C
		JOIN SYS.OBJECTS  O
		ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'ConfiguracionPais'
	AND C.NAME = 'MobileOrden'
	)
BEGIN
	ALTER TABLE ConfiguracionPais 
	DROP CONSTRAINT MobileOrdenBPT_def
	
	ALTER TABLE ConfiguracionPais
	DROP COLUMN MobileOrdenBPT
END
GO
/*END*/
GO

USE BelcorpEcuador
GO

GO
IF EXISTS(
	SELECT * 
	FROM SYS.COLUMNS C
		JOIN SYS.OBJECTS  O
		ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'ConfiguracionPais'
	AND C.NAME = 'MobileOrden'
	)
BEGIN
	ALTER TABLE ConfiguracionPais 
	DROP CONSTRAINT MobileOrden_def
	
	ALTER TABLE ConfiguracionPais
	DROP COLUMN MobileOrden
END

GO

IF EXISTS(
	SELECT * 
	FROM SYS.COLUMNS C
		JOIN SYS.OBJECTS  O
		ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'ConfiguracionPais'
	AND C.NAME = 'MobileOrden'
	)
BEGIN
	ALTER TABLE ConfiguracionPais 
	DROP CONSTRAINT MobileOrdenBPT_def
	
	ALTER TABLE ConfiguracionPais
	DROP COLUMN MobileOrdenBPT
END
GO
/*END*/
GO

USE BelcorpDominicana
GO

GO
IF EXISTS(
	SELECT * 
	FROM SYS.COLUMNS C
		JOIN SYS.OBJECTS  O
		ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'ConfiguracionPais'
	AND C.NAME = 'MobileOrden'
	)
BEGIN
	ALTER TABLE ConfiguracionPais 
	DROP CONSTRAINT MobileOrden_def
	
	ALTER TABLE ConfiguracionPais
	DROP COLUMN MobileOrden
END

GO

IF EXISTS(
	SELECT * 
	FROM SYS.COLUMNS C
		JOIN SYS.OBJECTS  O
		ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'ConfiguracionPais'
	AND C.NAME = 'MobileOrden'
	)
BEGIN
	ALTER TABLE ConfiguracionPais 
	DROP CONSTRAINT MobileOrdenBPT_def
	
	ALTER TABLE ConfiguracionPais
	DROP COLUMN MobileOrdenBPT
END
GO
/*END*/
GO

USE BelcorpCostaRica
GO

GO
IF EXISTS(
	SELECT * 
	FROM SYS.COLUMNS C
		JOIN SYS.OBJECTS  O
		ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'ConfiguracionPais'
	AND C.NAME = 'MobileOrden'
	)
BEGIN
	ALTER TABLE ConfiguracionPais 
	DROP CONSTRAINT MobileOrden_def
	
	ALTER TABLE ConfiguracionPais
	DROP COLUMN MobileOrden
END

GO

IF EXISTS(
	SELECT * 
	FROM SYS.COLUMNS C
		JOIN SYS.OBJECTS  O
		ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'ConfiguracionPais'
	AND C.NAME = 'MobileOrden'
	)
BEGIN
	ALTER TABLE ConfiguracionPais 
	DROP CONSTRAINT MobileOrdenBPT_def
	
	ALTER TABLE ConfiguracionPais
	DROP COLUMN MobileOrdenBPT
END
GO
/*END*/
GO

USE BelcorpChile
GO

GO
IF EXISTS(
	SELECT * 
	FROM SYS.COLUMNS C
		JOIN SYS.OBJECTS  O
		ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'ConfiguracionPais'
	AND C.NAME = 'MobileOrden'
	)
BEGIN
	ALTER TABLE ConfiguracionPais 
	DROP CONSTRAINT MobileOrden_def
	
	ALTER TABLE ConfiguracionPais
	DROP COLUMN MobileOrden
END

GO

IF EXISTS(
	SELECT * 
	FROM SYS.COLUMNS C
		JOIN SYS.OBJECTS  O
		ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'ConfiguracionPais'
	AND C.NAME = 'MobileOrden'
	)
BEGIN
	ALTER TABLE ConfiguracionPais 
	DROP CONSTRAINT MobileOrdenBPT_def
	
	ALTER TABLE ConfiguracionPais
	DROP COLUMN MobileOrdenBPT
END
GO
/*END*/
GO

USE BelcorpBolivia
GO

GO
IF EXISTS(
	SELECT * 
	FROM SYS.COLUMNS C
		JOIN SYS.OBJECTS  O
		ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'ConfiguracionPais'
	AND C.NAME = 'MobileOrden'
	)
BEGIN
	ALTER TABLE ConfiguracionPais 
	DROP CONSTRAINT MobileOrden_def
	
	ALTER TABLE ConfiguracionPais
	DROP COLUMN MobileOrden
END

GO

IF EXISTS(
	SELECT * 
	FROM SYS.COLUMNS C
		JOIN SYS.OBJECTS  O
		ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'ConfiguracionPais'
	AND C.NAME = 'MobileOrden'
	)
BEGIN
	ALTER TABLE ConfiguracionPais 
	DROP CONSTRAINT MobileOrdenBPT_def
	
	ALTER TABLE ConfiguracionPais
	DROP COLUMN MobileOrdenBPT
END
GO
/*END*/
GO

