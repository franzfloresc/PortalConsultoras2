USE BelcorpPeru
GO

go
IF NOT EXISTS(
	SELECT * 
	FROM SYS.COLUMNS C
		JOIN SYS.OBJECTS  O
		ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'RevistaDigitalSuscripcion'
	AND C.NAME = 'CampaniaEfectiva'
	)
BEGIN
	ALTER TABLE RevistaDigitalSuscripcion
	ADD CampaniaEfectiva [INT]
	CONSTRAINT COST_RevistaDigiralSuscripcion_CampaniaEfectiva DEFAULT 0
END
go

USE BelcorpMexico
GO

go
IF NOT EXISTS(
	SELECT * 
	FROM SYS.COLUMNS C
		JOIN SYS.OBJECTS  O
		ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'RevistaDigitalSuscripcion'
	AND C.NAME = 'CampaniaEfectiva'
	)
BEGIN
	ALTER TABLE RevistaDigitalSuscripcion
	ADD CampaniaEfectiva [INT]
	CONSTRAINT COST_RevistaDigiralSuscripcion_CampaniaEfectiva DEFAULT 0
END
go

USE BelcorpColombia
GO

go
IF NOT EXISTS(
	SELECT * 
	FROM SYS.COLUMNS C
		JOIN SYS.OBJECTS  O
		ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'RevistaDigitalSuscripcion'
	AND C.NAME = 'CampaniaEfectiva'
	)
BEGIN
	ALTER TABLE RevistaDigitalSuscripcion
	ADD CampaniaEfectiva [INT]
	CONSTRAINT COST_RevistaDigiralSuscripcion_CampaniaEfectiva DEFAULT 0
END
go

USE BelcorpVenezuela
GO

go
IF NOT EXISTS(
	SELECT * 
	FROM SYS.COLUMNS C
		JOIN SYS.OBJECTS  O
		ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'RevistaDigitalSuscripcion'
	AND C.NAME = 'CampaniaEfectiva'
	)
BEGIN
	ALTER TABLE RevistaDigitalSuscripcion
	ADD CampaniaEfectiva [INT]
	CONSTRAINT COST_RevistaDigiralSuscripcion_CampaniaEfectiva DEFAULT 0
END
go

USE BelcorpSalvador
GO

go
IF NOT EXISTS(
	SELECT * 
	FROM SYS.COLUMNS C
		JOIN SYS.OBJECTS  O
		ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'RevistaDigitalSuscripcion'
	AND C.NAME = 'CampaniaEfectiva'
	)
BEGIN
	ALTER TABLE RevistaDigitalSuscripcion
	ADD CampaniaEfectiva [INT]
	CONSTRAINT COST_RevistaDigiralSuscripcion_CampaniaEfectiva DEFAULT 0
END
go

USE BelcorpPuertoRico
GO

go
IF NOT EXISTS(
	SELECT * 
	FROM SYS.COLUMNS C
		JOIN SYS.OBJECTS  O
		ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'RevistaDigitalSuscripcion'
	AND C.NAME = 'CampaniaEfectiva'
	)
BEGIN
	ALTER TABLE RevistaDigitalSuscripcion
	ADD CampaniaEfectiva [INT]
	CONSTRAINT COST_RevistaDigiralSuscripcion_CampaniaEfectiva DEFAULT 0
END
go

USE BelcorpPanama
GO

go
IF NOT EXISTS(
	SELECT * 
	FROM SYS.COLUMNS C
		JOIN SYS.OBJECTS  O
		ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'RevistaDigitalSuscripcion'
	AND C.NAME = 'CampaniaEfectiva'
	)
BEGIN
	ALTER TABLE RevistaDigitalSuscripcion
	ADD CampaniaEfectiva [INT]
	CONSTRAINT COST_RevistaDigiralSuscripcion_CampaniaEfectiva DEFAULT 0
END
go

USE BelcorpGuatemala
GO

go
IF NOT EXISTS(
	SELECT * 
	FROM SYS.COLUMNS C
		JOIN SYS.OBJECTS  O
		ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'RevistaDigitalSuscripcion'
	AND C.NAME = 'CampaniaEfectiva'
	)
BEGIN
	ALTER TABLE RevistaDigitalSuscripcion
	ADD CampaniaEfectiva [INT]
	CONSTRAINT COST_RevistaDigiralSuscripcion_CampaniaEfectiva DEFAULT 0
END
go

USE BelcorpEcuador
GO

go
IF NOT EXISTS(
	SELECT * 
	FROM SYS.COLUMNS C
		JOIN SYS.OBJECTS  O
		ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'RevistaDigitalSuscripcion'
	AND C.NAME = 'CampaniaEfectiva'
	)
BEGIN
	ALTER TABLE RevistaDigitalSuscripcion
	ADD CampaniaEfectiva [INT]
	CONSTRAINT COST_RevistaDigiralSuscripcion_CampaniaEfectiva DEFAULT 0
END
go

USE BelcorpDominicana
GO

go
IF NOT EXISTS(
	SELECT * 
	FROM SYS.COLUMNS C
		JOIN SYS.OBJECTS  O
		ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'RevistaDigitalSuscripcion'
	AND C.NAME = 'CampaniaEfectiva'
	)
BEGIN
	ALTER TABLE RevistaDigitalSuscripcion
	ADD CampaniaEfectiva [INT]
	CONSTRAINT COST_RevistaDigiralSuscripcion_CampaniaEfectiva DEFAULT 0
END
go

USE BelcorpCostaRica
GO

go
IF NOT EXISTS(
	SELECT * 
	FROM SYS.COLUMNS C
		JOIN SYS.OBJECTS  O
		ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'RevistaDigitalSuscripcion'
	AND C.NAME = 'CampaniaEfectiva'
	)
BEGIN
	ALTER TABLE RevistaDigitalSuscripcion
	ADD CampaniaEfectiva [INT]
	CONSTRAINT COST_RevistaDigiralSuscripcion_CampaniaEfectiva DEFAULT 0
END
go

USE BelcorpChile
GO

go
IF NOT EXISTS(
	SELECT * 
	FROM SYS.COLUMNS C
		JOIN SYS.OBJECTS  O
		ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'RevistaDigitalSuscripcion'
	AND C.NAME = 'CampaniaEfectiva'
	)
BEGIN
	ALTER TABLE RevistaDigitalSuscripcion
	ADD CampaniaEfectiva [INT]
	CONSTRAINT COST_RevistaDigiralSuscripcion_CampaniaEfectiva DEFAULT 0
END
go

USE BelcorpBolivia
GO

go
IF NOT EXISTS(
	SELECT * 
	FROM SYS.COLUMNS C
		JOIN SYS.OBJECTS  O
		ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'RevistaDigitalSuscripcion'
	AND C.NAME = 'CampaniaEfectiva'
	)
BEGIN
	ALTER TABLE RevistaDigitalSuscripcion
	ADD CampaniaEfectiva [INT]
	CONSTRAINT COST_RevistaDigiralSuscripcion_CampaniaEfectiva DEFAULT 0
END
go

