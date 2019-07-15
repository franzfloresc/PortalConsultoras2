GO
USE BelcorpPeru
GO
IF NOT EXISTS (
	SELECT *
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE
    O.NAME = 'Incentivo'
	AND C.NAME = 'Zona'
	AND C.NAME = 'Segmento'
	)
BEGIN
	ALTER TABLE Incentivo
	ADD Zona varchar(MAX) NULL,
		Segmento varchar(MAX) NULL
END

GO
USE BelcorpMexico
GO
IF NOT EXISTS (
	SELECT *
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE
    O.NAME = 'Incentivo'
	AND C.NAME = 'Zona'
	AND C.NAME = 'Segmento'
	)
BEGIN
	ALTER TABLE Incentivo
	ADD Zona varchar(MAX) NULL,
		Segmento varchar(MAX) NULL
END

GO
USE BelcorpColombia
GO
IF NOT EXISTS (
	SELECT *
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE
    O.NAME = 'Incentivo'
	AND C.NAME = 'Zona'
	AND C.NAME = 'Segmento'
	)
BEGIN
	ALTER TABLE Incentivo
	ADD Zona varchar(MAX) NULL,
		Segmento varchar(MAX) NULL
END

GO
USE BelcorpSalvador
GO
IF NOT EXISTS (
	SELECT *
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE
    O.NAME = 'Incentivo'
	AND C.NAME = 'Zona'
	AND C.NAME = 'Segmento'
	)
BEGIN
	ALTER TABLE Incentivo
	ADD Zona varchar(MAX) NULL,
		Segmento varchar(MAX) NULL
END

GO
USE BelcorpPuertoRico
GO
IF NOT EXISTS (
	SELECT *
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE
    O.NAME = 'Incentivo'
	AND C.NAME = 'Zona'
	AND C.NAME = 'Segmento'
	)
BEGIN
	ALTER TABLE Incentivo
	ADD Zona varchar(MAX) NULL,
		Segmento varchar(MAX) NULL
END

GO
USE BelcorpPanama
GO
IF NOT EXISTS (
	SELECT *
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE
    O.NAME = 'Incentivo'
	AND C.NAME = 'Zona'
	AND C.NAME = 'Segmento'
	)
BEGIN
	ALTER TABLE Incentivo
	ADD Zona varchar(MAX) NULL,
		Segmento varchar(MAX) NULL
END

GO
USE BelcorpGuatemala
GO
IF NOT EXISTS (
	SELECT *
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE
    O.NAME = 'Incentivo'
	AND C.NAME = 'Zona'
	AND C.NAME = 'Segmento'
	)
BEGIN
	ALTER TABLE Incentivo
	ADD Zona varchar(MAX) NULL,
		Segmento varchar(MAX) NULL
END

GO
USE BelcorpEcuador
GO
IF NOT EXISTS (
	SELECT *
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE
    O.NAME = 'Incentivo'
	AND C.NAME = 'Zona'
	AND C.NAME = 'Segmento'
	)
BEGIN
	ALTER TABLE Incentivo
	ADD Zona varchar(MAX) NULL,
		Segmento varchar(MAX) NULL
END

GO
USE BelcorpDominicana
GO
IF NOT EXISTS (
	SELECT *
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE
    O.NAME = 'Incentivo'
	AND C.NAME = 'Zona'
	AND C.NAME = 'Segmento'
	)
BEGIN
	ALTER TABLE Incentivo
	ADD Zona varchar(MAX) NULL,
		Segmento varchar(MAX) NULL
END

GO
USE BelcorpCostaRica
GO
IF NOT EXISTS (
	SELECT *
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE
    O.NAME = 'Incentivo'
	AND C.NAME = 'Zona'
	AND C.NAME = 'Segmento'
	)
BEGIN
	ALTER TABLE Incentivo
	ADD Zona varchar(MAX) NULL,
		Segmento varchar(MAX) NULL
END

GO
USE BelcorpChile
GO
IF NOT EXISTS (
	SELECT *
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE
    O.NAME = 'Incentivo'
	AND C.NAME = 'Zona'
	AND C.NAME = 'Segmento'
	)
BEGIN
	ALTER TABLE Incentivo
	ADD Zona varchar(MAX) NULL,
		Segmento varchar(MAX) NULL
END

GO
USE BelcorpBolivia
GO
IF NOT EXISTS (
	SELECT *
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE
    O.NAME = 'Incentivo'
	AND C.NAME = 'Zona'
	AND C.NAME = 'Segmento'
	)
BEGIN
	ALTER TABLE Incentivo
	ADD Zona varchar(MAX) NULL,
		Segmento varchar(MAX) NULL
END

GO

