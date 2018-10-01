GO
IF NOT EXISTS(SELECT * 
	FROM SYS.COLUMNS C
		JOIN SYS.OBJECTS  O
		ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'ConfiguracionPaisDatos'
	AND C.NAME = 'Componente')
BEGIN
	ALTER TABLE ConfiguracionPaisDatos
	ADD Componente varchar(100)
	CONSTRAINT COST_ConfiguracionPaisDatos_Componente DEFAULT 'NA'
END
GO