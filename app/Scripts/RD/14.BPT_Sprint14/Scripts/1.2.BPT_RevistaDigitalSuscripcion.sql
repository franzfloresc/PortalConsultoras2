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
