IF NOT EXISTS(
	SELECT * 
	FROM SYS.COLUMNS C
		JOIN SYS.OBJECTS  O
		ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'RevistaDigitalSuscripcion'
	AND C.NAME = 'CantidadCampaniaEfectiva'
	)
BEGIN
	ALTER TABLE RevistaDigitalSuscripcion
	ADD CantidadCampaniaEfectiva [INT]
	CONSTRAINT COST_RevistaDigiralSuscripcion_Cantidad DEFAULT 0
END