﻿USE BelcorpPeru
GO

GO
IF NOT EXISTS(SELECT * FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'  AND O.NAME = 'EstrategiaTemporal'
		AND C.NAME = 'Niveles')
BEGIN
	ALTER TABLE EstrategiaTemporal ADD Niveles varchar(200)
END
GO

USE BelcorpMexico
GO

GO
IF NOT EXISTS(SELECT * FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'  AND O.NAME = 'EstrategiaTemporal'
		AND C.NAME = 'Niveles')
BEGIN
	ALTER TABLE EstrategiaTemporal ADD Niveles varchar(200)
END
GO

USE BelcorpColombia
GO

GO
IF NOT EXISTS(SELECT * FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'  AND O.NAME = 'EstrategiaTemporal'
		AND C.NAME = 'Niveles')
BEGIN
	ALTER TABLE EstrategiaTemporal ADD Niveles varchar(200)
END
GO

USE BelcorpVenezuela
GO

GO
IF NOT EXISTS(SELECT * FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'  AND O.NAME = 'EstrategiaTemporal'
		AND C.NAME = 'Niveles')
BEGIN
	ALTER TABLE EstrategiaTemporal ADD Niveles varchar(200)
END
GO

USE BelcorpSalvador
GO

GO
IF NOT EXISTS(SELECT * FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'  AND O.NAME = 'EstrategiaTemporal'
		AND C.NAME = 'Niveles')
BEGIN
	ALTER TABLE EstrategiaTemporal ADD Niveles varchar(200)
END
GO

USE BelcorpPuertoRico
GO

GO
IF NOT EXISTS(SELECT * FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'  AND O.NAME = 'EstrategiaTemporal'
		AND C.NAME = 'Niveles')
BEGIN
	ALTER TABLE EstrategiaTemporal ADD Niveles varchar(200)
END
GO

USE BelcorpPanama
GO

GO
IF NOT EXISTS(SELECT * FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'  AND O.NAME = 'EstrategiaTemporal'
		AND C.NAME = 'Niveles')
BEGIN
	ALTER TABLE EstrategiaTemporal ADD Niveles varchar(200)
END
GO

USE BelcorpGuatemala
GO

GO
IF NOT EXISTS(SELECT * FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'  AND O.NAME = 'EstrategiaTemporal'
		AND C.NAME = 'Niveles')
BEGIN
	ALTER TABLE EstrategiaTemporal ADD Niveles varchar(200)
END
GO

USE BelcorpEcuador
GO

GO
IF NOT EXISTS(SELECT * FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'  AND O.NAME = 'EstrategiaTemporal'
		AND C.NAME = 'Niveles')
BEGIN
	ALTER TABLE EstrategiaTemporal ADD Niveles varchar(200)
END
GO

USE BelcorpDominicana
GO

GO
IF NOT EXISTS(SELECT * FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'  AND O.NAME = 'EstrategiaTemporal'
		AND C.NAME = 'Niveles')
BEGIN
	ALTER TABLE EstrategiaTemporal ADD Niveles varchar(200)
END
GO

USE BelcorpCostaRica
GO

GO
IF NOT EXISTS(SELECT * FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'  AND O.NAME = 'EstrategiaTemporal'
		AND C.NAME = 'Niveles')
BEGIN
	ALTER TABLE EstrategiaTemporal ADD Niveles varchar(200)
END
GO

USE BelcorpChile
GO

GO
IF NOT EXISTS(SELECT * FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'  AND O.NAME = 'EstrategiaTemporal'
		AND C.NAME = 'Niveles')
BEGIN
	ALTER TABLE EstrategiaTemporal ADD Niveles varchar(200)
END
GO

USE BelcorpBolivia
GO

GO
IF NOT EXISTS(SELECT * FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'  AND O.NAME = 'EstrategiaTemporal'
		AND C.NAME = 'Niveles')
BEGIN
	ALTER TABLE EstrategiaTemporal ADD Niveles varchar(200)
END
GO

