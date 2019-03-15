﻿GO
USE BelcorpPeru
GO
IF NOT EXISTS (SELECT * FROM SYS.COLUMNS C JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U' AND O.NAME = 'filtrobuscador' AND C.NAME = 'Imagen')
BEGIN
	ALTER TABLE filtrobuscador ADD Imagen Varchar(250) NULL
END
GO
IF NOT EXISTS (SELECT * FROM SYS.COLUMNS C JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U' AND O.NAME = 'filtrobuscador' AND C.NAME = 'ImagenAncha')
BEGIN
	ALTER TABLE filtrobuscador ADD ImagenAncha int NULL
END

GO
USE BelcorpMexico
GO
IF NOT EXISTS (SELECT * FROM SYS.COLUMNS C JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U' AND O.NAME = 'filtrobuscador' AND C.NAME = 'Imagen')
BEGIN
	ALTER TABLE filtrobuscador ADD Imagen Varchar(250) NULL
END
GO
IF NOT EXISTS (SELECT * FROM SYS.COLUMNS C JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U' AND O.NAME = 'filtrobuscador' AND C.NAME = 'ImagenAncha')
BEGIN
	ALTER TABLE filtrobuscador ADD ImagenAncha int NULL
END

GO
USE BelcorpColombia
GO
IF NOT EXISTS (SELECT * FROM SYS.COLUMNS C JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U' AND O.NAME = 'filtrobuscador' AND C.NAME = 'Imagen')
BEGIN
	ALTER TABLE filtrobuscador ADD Imagen Varchar(250) NULL
END
GO
IF NOT EXISTS (SELECT * FROM SYS.COLUMNS C JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U' AND O.NAME = 'filtrobuscador' AND C.NAME = 'ImagenAncha')
BEGIN
	ALTER TABLE filtrobuscador ADD ImagenAncha int NULL
END

GO
USE BelcorpSalvador
GO
IF NOT EXISTS (SELECT * FROM SYS.COLUMNS C JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U' AND O.NAME = 'filtrobuscador' AND C.NAME = 'Imagen')
BEGIN
	ALTER TABLE filtrobuscador ADD Imagen Varchar(250) NULL
END
GO
IF NOT EXISTS (SELECT * FROM SYS.COLUMNS C JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U' AND O.NAME = 'filtrobuscador' AND C.NAME = 'ImagenAncha')
BEGIN
	ALTER TABLE filtrobuscador ADD ImagenAncha int NULL
END

GO
USE BelcorpPuertoRico
GO
IF NOT EXISTS (SELECT * FROM SYS.COLUMNS C JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U' AND O.NAME = 'filtrobuscador' AND C.NAME = 'Imagen')
BEGIN
	ALTER TABLE filtrobuscador ADD Imagen Varchar(250) NULL
END
GO
IF NOT EXISTS (SELECT * FROM SYS.COLUMNS C JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U' AND O.NAME = 'filtrobuscador' AND C.NAME = 'ImagenAncha')
BEGIN
	ALTER TABLE filtrobuscador ADD ImagenAncha int NULL
END

GO
USE BelcorpPanama
GO
IF NOT EXISTS (SELECT * FROM SYS.COLUMNS C JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U' AND O.NAME = 'filtrobuscador' AND C.NAME = 'Imagen')
BEGIN
	ALTER TABLE filtrobuscador ADD Imagen Varchar(250) NULL
END
GO
IF NOT EXISTS (SELECT * FROM SYS.COLUMNS C JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U' AND O.NAME = 'filtrobuscador' AND C.NAME = 'ImagenAncha')
BEGIN
	ALTER TABLE filtrobuscador ADD ImagenAncha int NULL
END

GO
USE BelcorpGuatemala
GO
IF NOT EXISTS (SELECT * FROM SYS.COLUMNS C JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U' AND O.NAME = 'filtrobuscador' AND C.NAME = 'Imagen')
BEGIN
	ALTER TABLE filtrobuscador ADD Imagen Varchar(250) NULL
END
GO
IF NOT EXISTS (SELECT * FROM SYS.COLUMNS C JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U' AND O.NAME = 'filtrobuscador' AND C.NAME = 'ImagenAncha')
BEGIN
	ALTER TABLE filtrobuscador ADD ImagenAncha int NULL
END

GO
USE BelcorpEcuador
GO
IF NOT EXISTS (SELECT * FROM SYS.COLUMNS C JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U' AND O.NAME = 'filtrobuscador' AND C.NAME = 'Imagen')
BEGIN
	ALTER TABLE filtrobuscador ADD Imagen Varchar(250) NULL
END
GO
IF NOT EXISTS (SELECT * FROM SYS.COLUMNS C JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U' AND O.NAME = 'filtrobuscador' AND C.NAME = 'ImagenAncha')
BEGIN
	ALTER TABLE filtrobuscador ADD ImagenAncha int NULL
END

GO
USE BelcorpDominicana
GO
IF NOT EXISTS (SELECT * FROM SYS.COLUMNS C JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U' AND O.NAME = 'filtrobuscador' AND C.NAME = 'Imagen')
BEGIN
	ALTER TABLE filtrobuscador ADD Imagen Varchar(250) NULL
END
GO
IF NOT EXISTS (SELECT * FROM SYS.COLUMNS C JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U' AND O.NAME = 'filtrobuscador' AND C.NAME = 'ImagenAncha')
BEGIN
	ALTER TABLE filtrobuscador ADD ImagenAncha int NULL
END

GO
USE BelcorpCostaRica
GO
IF NOT EXISTS (SELECT * FROM SYS.COLUMNS C JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U' AND O.NAME = 'filtrobuscador' AND C.NAME = 'Imagen')
BEGIN
	ALTER TABLE filtrobuscador ADD Imagen Varchar(250) NULL
END
GO
IF NOT EXISTS (SELECT * FROM SYS.COLUMNS C JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U' AND O.NAME = 'filtrobuscador' AND C.NAME = 'ImagenAncha')
BEGIN
	ALTER TABLE filtrobuscador ADD ImagenAncha int NULL
END

GO
USE BelcorpChile
GO
IF NOT EXISTS (SELECT * FROM SYS.COLUMNS C JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U' AND O.NAME = 'filtrobuscador' AND C.NAME = 'Imagen')
BEGIN
	ALTER TABLE filtrobuscador ADD Imagen Varchar(250) NULL
END
GO
IF NOT EXISTS (SELECT * FROM SYS.COLUMNS C JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U' AND O.NAME = 'filtrobuscador' AND C.NAME = 'ImagenAncha')
BEGIN
	ALTER TABLE filtrobuscador ADD ImagenAncha int NULL
END

GO
USE BelcorpBolivia
GO
IF NOT EXISTS (SELECT * FROM SYS.COLUMNS C JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U' AND O.NAME = 'filtrobuscador' AND C.NAME = 'Imagen')
BEGIN
	ALTER TABLE filtrobuscador ADD Imagen Varchar(250) NULL
END
GO
IF NOT EXISTS (SELECT * FROM SYS.COLUMNS C JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U' AND O.NAME = 'filtrobuscador' AND C.NAME = 'ImagenAncha')
BEGIN
	ALTER TABLE filtrobuscador ADD ImagenAncha int NULL
END

GO
