IF NOT EXISTS (
	SELECT * 
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'Banner'
	AND C.NAME = 'ArchivoMobile'
	)
BEGIN
	ALTER TABLE Banner
	ADD ArchivoMobile varchar(200) 
END
GO