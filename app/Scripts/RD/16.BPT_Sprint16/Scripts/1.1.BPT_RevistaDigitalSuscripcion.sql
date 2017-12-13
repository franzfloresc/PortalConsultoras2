IF NOT EXISTS(SELECT * 
	FROM SYS.COLUMNS C
		JOIN SYS.OBJECTS  O
		ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'RevistaDigitalSuscripcion'
	AND C.NAME = 'Origen')
BEGIN
	ALTER TABLE RevistaDigitalSuscripcion
	ADD Origen VARCHAR(20)
	CONSTRAINT COST_RevistaDigiralSuscripcion_Origen DEFAULT ''
END