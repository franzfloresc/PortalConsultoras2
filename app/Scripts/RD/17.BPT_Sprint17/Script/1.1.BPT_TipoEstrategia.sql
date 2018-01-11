USE BelcorpPeru
GO

IF NOT EXISTS(SELECT * 
	FROM SYS.COLUMNS C
		JOIN SYS.OBJECTS  O
		ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'TipoEstrategia'
	AND C.NAME = 'NombreComercial')
BEGIN
	ALTER TABLE TipoEstrategia
	ADD NombreComercial VARCHAR(255)
	CONSTRAINT COST_TipoEstrategia_NombreComercial DEFAULT ''
END
GO

USE BelcorpMexico
GO

IF NOT EXISTS(SELECT * 
	FROM SYS.COLUMNS C
		JOIN SYS.OBJECTS  O
		ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'TipoEstrategia'
	AND C.NAME = 'NombreComercial')
BEGIN
	ALTER TABLE TipoEstrategia
	ADD NombreComercial VARCHAR(255)
	CONSTRAINT COST_TipoEstrategia_NombreComercial DEFAULT ''
END
GO

USE BelcorpColombia
GO

IF NOT EXISTS(SELECT * 
	FROM SYS.COLUMNS C
		JOIN SYS.OBJECTS  O
		ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'TipoEstrategia'
	AND C.NAME = 'NombreComercial')
BEGIN
	ALTER TABLE TipoEstrategia
	ADD NombreComercial VARCHAR(255)
	CONSTRAINT COST_TipoEstrategia_NombreComercial DEFAULT ''
END
GO

USE BelcorpVenezuela
GO

IF NOT EXISTS(SELECT * 
	FROM SYS.COLUMNS C
		JOIN SYS.OBJECTS  O
		ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'TipoEstrategia'
	AND C.NAME = 'NombreComercial')
BEGIN
	ALTER TABLE TipoEstrategia
	ADD NombreComercial VARCHAR(255)
	CONSTRAINT COST_TipoEstrategia_NombreComercial DEFAULT ''
END
GO

USE BelcorpSalvador
GO

IF NOT EXISTS(SELECT * 
	FROM SYS.COLUMNS C
		JOIN SYS.OBJECTS  O
		ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'TipoEstrategia'
	AND C.NAME = 'NombreComercial')
BEGIN
	ALTER TABLE TipoEstrategia
	ADD NombreComercial VARCHAR(255)
	CONSTRAINT COST_TipoEstrategia_NombreComercial DEFAULT ''
END
GO

USE BelcorpPuertoRico
GO

IF NOT EXISTS(SELECT * 
	FROM SYS.COLUMNS C
		JOIN SYS.OBJECTS  O
		ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'TipoEstrategia'
	AND C.NAME = 'NombreComercial')
BEGIN
	ALTER TABLE TipoEstrategia
	ADD NombreComercial VARCHAR(255)
	CONSTRAINT COST_TipoEstrategia_NombreComercial DEFAULT ''
END
GO

USE BelcorpPanama
GO

IF NOT EXISTS(SELECT * 
	FROM SYS.COLUMNS C
		JOIN SYS.OBJECTS  O
		ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'TipoEstrategia'
	AND C.NAME = 'NombreComercial')
BEGIN
	ALTER TABLE TipoEstrategia
	ADD NombreComercial VARCHAR(255)
	CONSTRAINT COST_TipoEstrategia_NombreComercial DEFAULT ''
END
GO

USE BelcorpGuatemala
GO

IF NOT EXISTS(SELECT * 
	FROM SYS.COLUMNS C
		JOIN SYS.OBJECTS  O
		ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'TipoEstrategia'
	AND C.NAME = 'NombreComercial')
BEGIN
	ALTER TABLE TipoEstrategia
	ADD NombreComercial VARCHAR(255)
	CONSTRAINT COST_TipoEstrategia_NombreComercial DEFAULT ''
END
GO

USE BelcorpEcuador
GO

IF NOT EXISTS(SELECT * 
	FROM SYS.COLUMNS C
		JOIN SYS.OBJECTS  O
		ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'TipoEstrategia'
	AND C.NAME = 'NombreComercial')
BEGIN
	ALTER TABLE TipoEstrategia
	ADD NombreComercial VARCHAR(255)
	CONSTRAINT COST_TipoEstrategia_NombreComercial DEFAULT ''
END
GO

USE BelcorpDominicana
GO

IF NOT EXISTS(SELECT * 
	FROM SYS.COLUMNS C
		JOIN SYS.OBJECTS  O
		ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'TipoEstrategia'
	AND C.NAME = 'NombreComercial')
BEGIN
	ALTER TABLE TipoEstrategia
	ADD NombreComercial VARCHAR(255)
	CONSTRAINT COST_TipoEstrategia_NombreComercial DEFAULT ''
END
GO

USE BelcorpCostaRica
GO

IF NOT EXISTS(SELECT * 
	FROM SYS.COLUMNS C
		JOIN SYS.OBJECTS  O
		ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'TipoEstrategia'
	AND C.NAME = 'NombreComercial')
BEGIN
	ALTER TABLE TipoEstrategia
	ADD NombreComercial VARCHAR(255)
	CONSTRAINT COST_TipoEstrategia_NombreComercial DEFAULT ''
END
GO

USE BelcorpChile
GO

IF NOT EXISTS(SELECT * 
	FROM SYS.COLUMNS C
		JOIN SYS.OBJECTS  O
		ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'TipoEstrategia'
	AND C.NAME = 'NombreComercial')
BEGIN
	ALTER TABLE TipoEstrategia
	ADD NombreComercial VARCHAR(255)
	CONSTRAINT COST_TipoEstrategia_NombreComercial DEFAULT ''
END
GO

USE BelcorpBolivia
GO

IF NOT EXISTS(SELECT * 
	FROM SYS.COLUMNS C
		JOIN SYS.OBJECTS  O
		ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'TipoEstrategia'
	AND C.NAME = 'NombreComercial')
BEGIN
	ALTER TABLE TipoEstrategia
	ADD NombreComercial VARCHAR(255)
	CONSTRAINT COST_TipoEstrategia_NombreComercial DEFAULT ''
END
GO

