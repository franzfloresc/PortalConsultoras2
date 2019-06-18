USE [BelcorpPeru_MC]
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

