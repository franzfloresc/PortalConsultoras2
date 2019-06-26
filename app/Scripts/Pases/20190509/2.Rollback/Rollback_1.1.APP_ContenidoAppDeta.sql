﻿USE BelcorpPeru
GO

IF(EXISTS(SELECT * FROM SYS.COLUMNS C JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID] WHERE  O.TYPE = 'U' AND O.NAME = 'ContenidoAppDeta' AND C.NAME = 'Campania'))
BEGIN 
	ALTER TABLE ContenidoAppDeta
	DROP COLUMN Campania
END

IF(EXISTS(SELECT * FROM SYS.COLUMNS C JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID] WHERE  O.TYPE = 'U' AND O.NAME = 'ContenidoAppDeta' AND C.NAME = 'Region'))
BEGIN 
	ALTER TABLE ContenidoAppDeta
	DROP COLUMN Region
END

IF(EXISTS(SELECT * FROM SYS.COLUMNS C JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID] WHERE  O.TYPE = 'U' AND O.NAME = 'ContenidoAppDeta' AND C.NAME = 'Zona'))
BEGIN 
	ALTER TABLE ContenidoAppDeta
	DROP COLUMN Zona
END

IF(EXISTS(SELECT * FROM SYS.COLUMNS C JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID] WHERE  O.TYPE = 'U' AND O.NAME = 'ContenidoAppDeta' AND C.NAME = 'Seccion'))
BEGIN 
	ALTER TABLE ContenidoAppDeta
	DROP COLUMN Seccion
END

GO

USE BelcorpMexico
GO

IF(EXISTS(SELECT * FROM SYS.COLUMNS C JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID] WHERE  O.TYPE = 'U' AND O.NAME = 'ContenidoAppDeta' AND C.NAME = 'Campania'))
BEGIN 
	ALTER TABLE ContenidoAppDeta
	DROP COLUMN Campania
END

IF(EXISTS(SELECT * FROM SYS.COLUMNS C JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID] WHERE  O.TYPE = 'U' AND O.NAME = 'ContenidoAppDeta' AND C.NAME = 'Region'))
BEGIN 
	ALTER TABLE ContenidoAppDeta
	DROP COLUMN Region
END

IF(EXISTS(SELECT * FROM SYS.COLUMNS C JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID] WHERE  O.TYPE = 'U' AND O.NAME = 'ContenidoAppDeta' AND C.NAME = 'Zona'))
BEGIN 
	ALTER TABLE ContenidoAppDeta
	DROP COLUMN Zona
END

IF(EXISTS(SELECT * FROM SYS.COLUMNS C JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID] WHERE  O.TYPE = 'U' AND O.NAME = 'ContenidoAppDeta' AND C.NAME = 'Seccion'))
BEGIN 
	ALTER TABLE ContenidoAppDeta
	DROP COLUMN Seccion
END

GO

USE BelcorpColombia
GO

IF(EXISTS(SELECT * FROM SYS.COLUMNS C JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID] WHERE  O.TYPE = 'U' AND O.NAME = 'ContenidoAppDeta' AND C.NAME = 'Campania'))
BEGIN 
	ALTER TABLE ContenidoAppDeta
	DROP COLUMN Campania
END

IF(EXISTS(SELECT * FROM SYS.COLUMNS C JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID] WHERE  O.TYPE = 'U' AND O.NAME = 'ContenidoAppDeta' AND C.NAME = 'Region'))
BEGIN 
	ALTER TABLE ContenidoAppDeta
	DROP COLUMN Region
END

IF(EXISTS(SELECT * FROM SYS.COLUMNS C JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID] WHERE  O.TYPE = 'U' AND O.NAME = 'ContenidoAppDeta' AND C.NAME = 'Zona'))
BEGIN 
	ALTER TABLE ContenidoAppDeta
	DROP COLUMN Zona
END

IF(EXISTS(SELECT * FROM SYS.COLUMNS C JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID] WHERE  O.TYPE = 'U' AND O.NAME = 'ContenidoAppDeta' AND C.NAME = 'Seccion'))
BEGIN 
	ALTER TABLE ContenidoAppDeta
	DROP COLUMN Seccion
END

GO

USE BelcorpSalvador
GO

IF(EXISTS(SELECT * FROM SYS.COLUMNS C JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID] WHERE  O.TYPE = 'U' AND O.NAME = 'ContenidoAppDeta' AND C.NAME = 'Campania'))
BEGIN 
	ALTER TABLE ContenidoAppDeta
	DROP COLUMN Campania
END

IF(EXISTS(SELECT * FROM SYS.COLUMNS C JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID] WHERE  O.TYPE = 'U' AND O.NAME = 'ContenidoAppDeta' AND C.NAME = 'Region'))
BEGIN 
	ALTER TABLE ContenidoAppDeta
	DROP COLUMN Region
END

IF(EXISTS(SELECT * FROM SYS.COLUMNS C JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID] WHERE  O.TYPE = 'U' AND O.NAME = 'ContenidoAppDeta' AND C.NAME = 'Zona'))
BEGIN 
	ALTER TABLE ContenidoAppDeta
	DROP COLUMN Zona
END

IF(EXISTS(SELECT * FROM SYS.COLUMNS C JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID] WHERE  O.TYPE = 'U' AND O.NAME = 'ContenidoAppDeta' AND C.NAME = 'Seccion'))
BEGIN 
	ALTER TABLE ContenidoAppDeta
	DROP COLUMN Seccion
END

GO

USE BelcorpPuertoRico
GO

IF(EXISTS(SELECT * FROM SYS.COLUMNS C JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID] WHERE  O.TYPE = 'U' AND O.NAME = 'ContenidoAppDeta' AND C.NAME = 'Campania'))
BEGIN 
	ALTER TABLE ContenidoAppDeta
	DROP COLUMN Campania
END

IF(EXISTS(SELECT * FROM SYS.COLUMNS C JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID] WHERE  O.TYPE = 'U' AND O.NAME = 'ContenidoAppDeta' AND C.NAME = 'Region'))
BEGIN 
	ALTER TABLE ContenidoAppDeta
	DROP COLUMN Region
END

IF(EXISTS(SELECT * FROM SYS.COLUMNS C JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID] WHERE  O.TYPE = 'U' AND O.NAME = 'ContenidoAppDeta' AND C.NAME = 'Zona'))
BEGIN 
	ALTER TABLE ContenidoAppDeta
	DROP COLUMN Zona
END

IF(EXISTS(SELECT * FROM SYS.COLUMNS C JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID] WHERE  O.TYPE = 'U' AND O.NAME = 'ContenidoAppDeta' AND C.NAME = 'Seccion'))
BEGIN 
	ALTER TABLE ContenidoAppDeta
	DROP COLUMN Seccion
END

GO

USE BelcorpPanama
GO

IF(EXISTS(SELECT * FROM SYS.COLUMNS C JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID] WHERE  O.TYPE = 'U' AND O.NAME = 'ContenidoAppDeta' AND C.NAME = 'Campania'))
BEGIN 
	ALTER TABLE ContenidoAppDeta
	DROP COLUMN Campania
END

IF(EXISTS(SELECT * FROM SYS.COLUMNS C JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID] WHERE  O.TYPE = 'U' AND O.NAME = 'ContenidoAppDeta' AND C.NAME = 'Region'))
BEGIN 
	ALTER TABLE ContenidoAppDeta
	DROP COLUMN Region
END

IF(EXISTS(SELECT * FROM SYS.COLUMNS C JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID] WHERE  O.TYPE = 'U' AND O.NAME = 'ContenidoAppDeta' AND C.NAME = 'Zona'))
BEGIN 
	ALTER TABLE ContenidoAppDeta
	DROP COLUMN Zona
END

IF(EXISTS(SELECT * FROM SYS.COLUMNS C JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID] WHERE  O.TYPE = 'U' AND O.NAME = 'ContenidoAppDeta' AND C.NAME = 'Seccion'))
BEGIN 
	ALTER TABLE ContenidoAppDeta
	DROP COLUMN Seccion
END

GO

USE BelcorpGuatemala
GO

IF(EXISTS(SELECT * FROM SYS.COLUMNS C JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID] WHERE  O.TYPE = 'U' AND O.NAME = 'ContenidoAppDeta' AND C.NAME = 'Campania'))
BEGIN 
	ALTER TABLE ContenidoAppDeta
	DROP COLUMN Campania
END

IF(EXISTS(SELECT * FROM SYS.COLUMNS C JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID] WHERE  O.TYPE = 'U' AND O.NAME = 'ContenidoAppDeta' AND C.NAME = 'Region'))
BEGIN 
	ALTER TABLE ContenidoAppDeta
	DROP COLUMN Region
END

IF(EXISTS(SELECT * FROM SYS.COLUMNS C JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID] WHERE  O.TYPE = 'U' AND O.NAME = 'ContenidoAppDeta' AND C.NAME = 'Zona'))
BEGIN 
	ALTER TABLE ContenidoAppDeta
	DROP COLUMN Zona
END

IF(EXISTS(SELECT * FROM SYS.COLUMNS C JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID] WHERE  O.TYPE = 'U' AND O.NAME = 'ContenidoAppDeta' AND C.NAME = 'Seccion'))
BEGIN 
	ALTER TABLE ContenidoAppDeta
	DROP COLUMN Seccion
END

GO

USE BelcorpEcuador
GO

IF(EXISTS(SELECT * FROM SYS.COLUMNS C JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID] WHERE  O.TYPE = 'U' AND O.NAME = 'ContenidoAppDeta' AND C.NAME = 'Campania'))
BEGIN 
	ALTER TABLE ContenidoAppDeta
	DROP COLUMN Campania
END

IF(EXISTS(SELECT * FROM SYS.COLUMNS C JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID] WHERE  O.TYPE = 'U' AND O.NAME = 'ContenidoAppDeta' AND C.NAME = 'Region'))
BEGIN 
	ALTER TABLE ContenidoAppDeta
	DROP COLUMN Region
END

IF(EXISTS(SELECT * FROM SYS.COLUMNS C JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID] WHERE  O.TYPE = 'U' AND O.NAME = 'ContenidoAppDeta' AND C.NAME = 'Zona'))
BEGIN 
	ALTER TABLE ContenidoAppDeta
	DROP COLUMN Zona
END

IF(EXISTS(SELECT * FROM SYS.COLUMNS C JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID] WHERE  O.TYPE = 'U' AND O.NAME = 'ContenidoAppDeta' AND C.NAME = 'Seccion'))
BEGIN 
	ALTER TABLE ContenidoAppDeta
	DROP COLUMN Seccion
END

GO

USE BelcorpDominicana
GO

IF(EXISTS(SELECT * FROM SYS.COLUMNS C JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID] WHERE  O.TYPE = 'U' AND O.NAME = 'ContenidoAppDeta' AND C.NAME = 'Campania'))
BEGIN 
	ALTER TABLE ContenidoAppDeta
	DROP COLUMN Campania
END

IF(EXISTS(SELECT * FROM SYS.COLUMNS C JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID] WHERE  O.TYPE = 'U' AND O.NAME = 'ContenidoAppDeta' AND C.NAME = 'Region'))
BEGIN 
	ALTER TABLE ContenidoAppDeta
	DROP COLUMN Region
END

IF(EXISTS(SELECT * FROM SYS.COLUMNS C JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID] WHERE  O.TYPE = 'U' AND O.NAME = 'ContenidoAppDeta' AND C.NAME = 'Zona'))
BEGIN 
	ALTER TABLE ContenidoAppDeta
	DROP COLUMN Zona
END

IF(EXISTS(SELECT * FROM SYS.COLUMNS C JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID] WHERE  O.TYPE = 'U' AND O.NAME = 'ContenidoAppDeta' AND C.NAME = 'Seccion'))
BEGIN 
	ALTER TABLE ContenidoAppDeta
	DROP COLUMN Seccion
END

GO

USE BelcorpCostaRica
GO

IF(EXISTS(SELECT * FROM SYS.COLUMNS C JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID] WHERE  O.TYPE = 'U' AND O.NAME = 'ContenidoAppDeta' AND C.NAME = 'Campania'))
BEGIN 
	ALTER TABLE ContenidoAppDeta
	DROP COLUMN Campania
END

IF(EXISTS(SELECT * FROM SYS.COLUMNS C JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID] WHERE  O.TYPE = 'U' AND O.NAME = 'ContenidoAppDeta' AND C.NAME = 'Region'))
BEGIN 
	ALTER TABLE ContenidoAppDeta
	DROP COLUMN Region
END

IF(EXISTS(SELECT * FROM SYS.COLUMNS C JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID] WHERE  O.TYPE = 'U' AND O.NAME = 'ContenidoAppDeta' AND C.NAME = 'Zona'))
BEGIN 
	ALTER TABLE ContenidoAppDeta
	DROP COLUMN Zona
END

IF(EXISTS(SELECT * FROM SYS.COLUMNS C JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID] WHERE  O.TYPE = 'U' AND O.NAME = 'ContenidoAppDeta' AND C.NAME = 'Seccion'))
BEGIN 
	ALTER TABLE ContenidoAppDeta
	DROP COLUMN Seccion
END

GO

USE BelcorpChile
GO

IF(EXISTS(SELECT * FROM SYS.COLUMNS C JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID] WHERE  O.TYPE = 'U' AND O.NAME = 'ContenidoAppDeta' AND C.NAME = 'Campania'))
BEGIN 
	ALTER TABLE ContenidoAppDeta
	DROP COLUMN Campania
END

IF(EXISTS(SELECT * FROM SYS.COLUMNS C JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID] WHERE  O.TYPE = 'U' AND O.NAME = 'ContenidoAppDeta' AND C.NAME = 'Region'))
BEGIN 
	ALTER TABLE ContenidoAppDeta
	DROP COLUMN Region
END

IF(EXISTS(SELECT * FROM SYS.COLUMNS C JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID] WHERE  O.TYPE = 'U' AND O.NAME = 'ContenidoAppDeta' AND C.NAME = 'Zona'))
BEGIN 
	ALTER TABLE ContenidoAppDeta
	DROP COLUMN Zona
END

IF(EXISTS(SELECT * FROM SYS.COLUMNS C JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID] WHERE  O.TYPE = 'U' AND O.NAME = 'ContenidoAppDeta' AND C.NAME = 'Seccion'))
BEGIN 
	ALTER TABLE ContenidoAppDeta
	DROP COLUMN Seccion
END

GO

USE BelcorpBolivia
GO

IF(EXISTS(SELECT * FROM SYS.COLUMNS C JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID] WHERE  O.TYPE = 'U' AND O.NAME = 'ContenidoAppDeta' AND C.NAME = 'Campania'))
BEGIN 
	ALTER TABLE ContenidoAppDeta
	DROP COLUMN Campania
END

IF(EXISTS(SELECT * FROM SYS.COLUMNS C JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID] WHERE  O.TYPE = 'U' AND O.NAME = 'ContenidoAppDeta' AND C.NAME = 'Region'))
BEGIN 
	ALTER TABLE ContenidoAppDeta
	DROP COLUMN Region
END

IF(EXISTS(SELECT * FROM SYS.COLUMNS C JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID] WHERE  O.TYPE = 'U' AND O.NAME = 'ContenidoAppDeta' AND C.NAME = 'Zona'))
BEGIN 
	ALTER TABLE ContenidoAppDeta
	DROP COLUMN Zona
END

IF(EXISTS(SELECT * FROM SYS.COLUMNS C JOIN SYS.OBJECTS  O ON C.[OBJECT_ID] = O.[OBJECT_ID] WHERE  O.TYPE = 'U' AND O.NAME = 'ContenidoAppDeta' AND C.NAME = 'Seccion'))
BEGIN 
	ALTER TABLE ContenidoAppDeta
	DROP COLUMN Seccion
END

GO