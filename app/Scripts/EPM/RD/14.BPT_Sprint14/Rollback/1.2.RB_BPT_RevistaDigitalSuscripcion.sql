USE BelcorpPeru
GO

IF EXISTS(
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
	DROP COST_RevistaDigiralSuscripcion_CampaniaEfectiva
	ALTER TABLE RevistaDigitalSuscripcion
	DROP COLUMN CampaniaEfectiva
END
GO

USE BelcorpMexico
GO

IF EXISTS(
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
	DROP COST_RevistaDigiralSuscripcion_CampaniaEfectiva
	ALTER TABLE RevistaDigitalSuscripcion
	DROP COLUMN CampaniaEfectiva
END
GO

USE BelcorpColombia
GO

IF EXISTS(
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
	DROP COST_RevistaDigiralSuscripcion_CampaniaEfectiva
	ALTER TABLE RevistaDigitalSuscripcion
	DROP COLUMN CampaniaEfectiva
END
GO

USE BelcorpVenezuela
GO

IF EXISTS(
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
	DROP COST_RevistaDigiralSuscripcion_CampaniaEfectiva
	ALTER TABLE RevistaDigitalSuscripcion
	DROP COLUMN CampaniaEfectiva
END
GO

USE BelcorpSalvador
GO

IF EXISTS(
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
	DROP COST_RevistaDigiralSuscripcion_CampaniaEfectiva
	ALTER TABLE RevistaDigitalSuscripcion
	DROP COLUMN CampaniaEfectiva
END
GO

USE BelcorpPuertoRico
GO

IF EXISTS(
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
	DROP COST_RevistaDigiralSuscripcion_CampaniaEfectiva
	ALTER TABLE RevistaDigitalSuscripcion
	DROP COLUMN CampaniaEfectiva
END
GO

USE BelcorpPanama
GO

IF EXISTS(
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
	DROP COST_RevistaDigiralSuscripcion_CampaniaEfectiva
	ALTER TABLE RevistaDigitalSuscripcion
	DROP COLUMN CampaniaEfectiva
END
GO

USE BelcorpGuatemala
GO

IF EXISTS(
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
	DROP COST_RevistaDigiralSuscripcion_CampaniaEfectiva
	ALTER TABLE RevistaDigitalSuscripcion
	DROP COLUMN CampaniaEfectiva
END
GO

USE BelcorpEcuador
GO

IF EXISTS(
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
	DROP COST_RevistaDigiralSuscripcion_CampaniaEfectiva
	ALTER TABLE RevistaDigitalSuscripcion
	DROP COLUMN CampaniaEfectiva
END
GO

USE BelcorpDominicana
GO

IF EXISTS(
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
	DROP COST_RevistaDigiralSuscripcion_CampaniaEfectiva
	ALTER TABLE RevistaDigitalSuscripcion
	DROP COLUMN CampaniaEfectiva
END
GO

USE BelcorpCostaRica
GO

IF EXISTS(
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
	DROP COST_RevistaDigiralSuscripcion_CampaniaEfectiva
	ALTER TABLE RevistaDigitalSuscripcion
	DROP COLUMN CampaniaEfectiva
END
GO

USE BelcorpChile
GO

IF EXISTS(
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
	DROP COST_RevistaDigiralSuscripcion_CampaniaEfectiva
	ALTER TABLE RevistaDigitalSuscripcion
	DROP COLUMN CampaniaEfectiva
END
GO

USE BelcorpBolivia
GO

IF EXISTS(
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
	DROP COST_RevistaDigiralSuscripcion_CampaniaEfectiva
	ALTER TABLE RevistaDigitalSuscripcion
	DROP COLUMN CampaniaEfectiva
END
GO

