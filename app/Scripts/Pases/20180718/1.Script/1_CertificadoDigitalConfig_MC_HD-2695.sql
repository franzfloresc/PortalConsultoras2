GO
USE BelcorpPeru
GO
IF EXISTS (SELECT * FROM SYS.COLUMNS C JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U' AND O.NAME = 'certificadodigitalconfig' AND C.NAME = 'documento')
BEGIN
	ALTER TABLE certificadodigitalconfig
	alter column documento VARCHAR (250)
END
ELSE
BEGIN
	ALTER TABLE certificadodigitalconfig
	ADD documento varchar(250) NULL
END

GO
USE BelcorpMexico
GO
IF EXISTS (SELECT * FROM SYS.COLUMNS C JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U' AND O.NAME = 'certificadodigitalconfig' AND C.NAME = 'documento')
BEGIN
	ALTER TABLE certificadodigitalconfig
	alter column documento VARCHAR (250)
END
ELSE
BEGIN
	ALTER TABLE certificadodigitalconfig
	ADD documento varchar(250) NULL
END

GO
USE BelcorpColombia
GO
IF EXISTS (SELECT * FROM SYS.COLUMNS C JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U' AND O.NAME = 'certificadodigitalconfig' AND C.NAME = 'documento')
BEGIN
	ALTER TABLE certificadodigitalconfig
	alter column documento VARCHAR (250)
END
ELSE
BEGIN
	ALTER TABLE certificadodigitalconfig
	ADD documento varchar(250) NULL
END

GO
USE BelcorpSalvador
GO
IF EXISTS (SELECT * FROM SYS.COLUMNS C JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U' AND O.NAME = 'certificadodigitalconfig' AND C.NAME = 'documento')
BEGIN
	ALTER TABLE certificadodigitalconfig
	alter column documento VARCHAR (250)
END
ELSE
BEGIN
	ALTER TABLE certificadodigitalconfig
	ADD documento varchar(250) NULL
END

GO
USE BelcorpPuertoRico
GO
IF EXISTS (SELECT * FROM SYS.COLUMNS C JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U' AND O.NAME = 'certificadodigitalconfig' AND C.NAME = 'documento')
BEGIN
	ALTER TABLE certificadodigitalconfig
	alter column documento VARCHAR (250)
END
ELSE
BEGIN
	ALTER TABLE certificadodigitalconfig
	ADD documento varchar(250) NULL
END

GO
USE BelcorpPanama
GO
IF EXISTS (SELECT * FROM SYS.COLUMNS C JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U' AND O.NAME = 'certificadodigitalconfig' AND C.NAME = 'documento')
BEGIN
	ALTER TABLE certificadodigitalconfig
	alter column documento VARCHAR (250)
END
ELSE
BEGIN
	ALTER TABLE certificadodigitalconfig
	ADD documento varchar(250) NULL
END

GO
USE BelcorpGuatemala
GO
IF EXISTS (SELECT * FROM SYS.COLUMNS C JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U' AND O.NAME = 'certificadodigitalconfig' AND C.NAME = 'documento')
BEGIN
	ALTER TABLE certificadodigitalconfig
	alter column documento VARCHAR (250)
END
ELSE
BEGIN
	ALTER TABLE certificadodigitalconfig
	ADD documento varchar(250) NULL
END

GO
USE BelcorpEcuador
GO
IF EXISTS (SELECT * FROM SYS.COLUMNS C JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U' AND O.NAME = 'certificadodigitalconfig' AND C.NAME = 'documento')
BEGIN
	ALTER TABLE certificadodigitalconfig
	alter column documento VARCHAR (250)
END
ELSE
BEGIN
	ALTER TABLE certificadodigitalconfig
	ADD documento varchar(250) NULL
END

GO
USE BelcorpDominicana
GO
IF EXISTS (SELECT * FROM SYS.COLUMNS C JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U' AND O.NAME = 'certificadodigitalconfig' AND C.NAME = 'documento')
BEGIN
	ALTER TABLE certificadodigitalconfig
	alter column documento VARCHAR (250)
END
ELSE
BEGIN
	ALTER TABLE certificadodigitalconfig
	ADD documento varchar(250) NULL
END

GO
USE BelcorpCostaRica
GO
IF EXISTS (SELECT * FROM SYS.COLUMNS C JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U' AND O.NAME = 'certificadodigitalconfig' AND C.NAME = 'documento')
BEGIN
	ALTER TABLE certificadodigitalconfig
	alter column documento VARCHAR (250)
END
ELSE
BEGIN
	ALTER TABLE certificadodigitalconfig
	ADD documento varchar(250) NULL
END

GO
USE BelcorpChile
GO
IF EXISTS (SELECT * FROM SYS.COLUMNS C JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U' AND O.NAME = 'certificadodigitalconfig' AND C.NAME = 'documento')
BEGIN
	ALTER TABLE certificadodigitalconfig
	alter column documento VARCHAR (250)
END
ELSE
BEGIN
	ALTER TABLE certificadodigitalconfig
	ADD documento varchar(250) NULL
END

GO
USE BelcorpBolivia
GO
IF EXISTS (SELECT * FROM SYS.COLUMNS C JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U' AND O.NAME = 'certificadodigitalconfig' AND C.NAME = 'documento')
BEGIN
	ALTER TABLE certificadodigitalconfig
	alter column documento VARCHAR (250)
END
ELSE
BEGIN
	ALTER TABLE certificadodigitalconfig
	ADD documento varchar(250) NULL
END

GO
