USE BelcorpPeru
GO

IF NOT EXISTS(SELECT * FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'  AND O.NAME = 'RevistaDigitalSuscripcion'
		AND C.NAME = 'SubOrigen')
BEGIN
	ALTER TABLE RevistaDigitalSuscripcion ADD SubOrigen varchar(200)
END
GO

USE BelcorpMexico
GO

IF NOT EXISTS(SELECT * FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'  AND O.NAME = 'RevistaDigitalSuscripcion'
		AND C.NAME = 'SubOrigen')
BEGIN
	ALTER TABLE RevistaDigitalSuscripcion ADD SubOrigen varchar(200)
END
GO

USE BelcorpColombia
GO

IF NOT EXISTS(SELECT * FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'  AND O.NAME = 'RevistaDigitalSuscripcion'
		AND C.NAME = 'SubOrigen')
BEGIN
	ALTER TABLE RevistaDigitalSuscripcion ADD SubOrigen varchar(200)
END
GO

USE BelcorpSalvador
GO

IF NOT EXISTS(SELECT * FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'  AND O.NAME = 'RevistaDigitalSuscripcion'
		AND C.NAME = 'SubOrigen')
BEGIN
	ALTER TABLE RevistaDigitalSuscripcion ADD SubOrigen varchar(200)
END
GO

USE BelcorpPuertoRico
GO

IF NOT EXISTS(SELECT * FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'  AND O.NAME = 'RevistaDigitalSuscripcion'
		AND C.NAME = 'SubOrigen')
BEGIN
	ALTER TABLE RevistaDigitalSuscripcion ADD SubOrigen varchar(200)
END
GO

USE BelcorpPanama
GO

IF NOT EXISTS(SELECT * FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'  AND O.NAME = 'RevistaDigitalSuscripcion'
		AND C.NAME = 'SubOrigen')
BEGIN
	ALTER TABLE RevistaDigitalSuscripcion ADD SubOrigen varchar(200)
END
GO

USE BelcorpGuatemala
GO

IF NOT EXISTS(SELECT * FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'  AND O.NAME = 'RevistaDigitalSuscripcion'
		AND C.NAME = 'SubOrigen')
BEGIN
	ALTER TABLE RevistaDigitalSuscripcion ADD SubOrigen varchar(200)
END
GO

USE BelcorpEcuador
GO

IF NOT EXISTS(SELECT * FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'  AND O.NAME = 'RevistaDigitalSuscripcion'
		AND C.NAME = 'SubOrigen')
BEGIN
	ALTER TABLE RevistaDigitalSuscripcion ADD SubOrigen varchar(200)
END
GO

USE BelcorpDominicana
GO

IF NOT EXISTS(SELECT * FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'  AND O.NAME = 'RevistaDigitalSuscripcion'
		AND C.NAME = 'SubOrigen')
BEGIN
	ALTER TABLE RevistaDigitalSuscripcion ADD SubOrigen varchar(200)
END
GO

USE BelcorpCostaRica
GO

IF NOT EXISTS(SELECT * FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'  AND O.NAME = 'RevistaDigitalSuscripcion'
		AND C.NAME = 'SubOrigen')
BEGIN
	ALTER TABLE RevistaDigitalSuscripcion ADD SubOrigen varchar(200)
END
GO

USE BelcorpChile
GO

IF NOT EXISTS(SELECT * FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'  AND O.NAME = 'RevistaDigitalSuscripcion'
		AND C.NAME = 'SubOrigen')
BEGIN
	ALTER TABLE RevistaDigitalSuscripcion ADD SubOrigen varchar(200)
END
GO

USE BelcorpBolivia
GO

IF NOT EXISTS(SELECT * FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'  AND O.NAME = 'RevistaDigitalSuscripcion'
		AND C.NAME = 'SubOrigen')
BEGIN
	ALTER TABLE RevistaDigitalSuscripcion ADD SubOrigen varchar(200)
END
GO

