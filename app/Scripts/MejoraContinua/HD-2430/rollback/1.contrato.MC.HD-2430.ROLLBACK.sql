use BelcorpColombia
go

IF EXISTS (
	SELECT * 
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'contrato'
	AND C.NAME = 'origen'
	)
BEGIN
	ALTER TABLE contrato DROP COLUMN origen
END

GO
