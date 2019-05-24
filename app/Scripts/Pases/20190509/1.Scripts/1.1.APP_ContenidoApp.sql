USE BelcorpPeru
GO

IF(EXISTS(SELECT * 
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'ContenidoApp'
	AND C.NAME = 'HastaCampania'))
BEGIN 
	ALTER TABLE ContenidoApp
	DROP COLUMN HastaCampania
END
ALTER TABLE ContenidoApp
  ADD HastaCampania INT;

GO

USE BelcorpMexico
GO

IF(EXISTS(SELECT * 
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'ContenidoApp'
	AND C.NAME = 'HastaCampania'))
BEGIN 
	ALTER TABLE ContenidoApp
	DROP COLUMN HastaCampania
END
ALTER TABLE ContenidoApp
  ADD HastaCampania INT;

GO

USE BelcorpColombia
GO

IF(EXISTS(SELECT * 
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'ContenidoApp'
	AND C.NAME = 'HastaCampania'))
BEGIN 
	ALTER TABLE ContenidoApp
	DROP COLUMN HastaCampania
END
ALTER TABLE ContenidoApp
  ADD HastaCampania INT;

GO

USE BelcorpSalvador
GO

IF(EXISTS(SELECT * 
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'ContenidoApp'
	AND C.NAME = 'HastaCampania'))
BEGIN 
	ALTER TABLE ContenidoApp
	DROP COLUMN HastaCampania
END
ALTER TABLE ContenidoApp
  ADD HastaCampania INT;

GO

USE BelcorpPuertoRico
GO

IF(EXISTS(SELECT * 
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'ContenidoApp'
	AND C.NAME = 'HastaCampania'))
BEGIN 
	ALTER TABLE ContenidoApp
	DROP COLUMN HastaCampania
END
ALTER TABLE ContenidoApp
  ADD HastaCampania INT;

GO

USE BelcorpPanama
GO

IF(EXISTS(SELECT * 
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'ContenidoApp'
	AND C.NAME = 'HastaCampania'))
BEGIN 
	ALTER TABLE ContenidoApp
	DROP COLUMN HastaCampania
END
ALTER TABLE ContenidoApp
  ADD HastaCampania INT;

GO

USE BelcorpGuatemala
GO

IF(EXISTS(SELECT * 
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'ContenidoApp'
	AND C.NAME = 'HastaCampania'))
BEGIN 
	ALTER TABLE ContenidoApp
	DROP COLUMN HastaCampania
END
ALTER TABLE ContenidoApp
  ADD HastaCampania INT;

GO

USE BelcorpEcuador
GO

IF(EXISTS(SELECT * 
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'ContenidoApp'
	AND C.NAME = 'HastaCampania'))
BEGIN 
	ALTER TABLE ContenidoApp
	DROP COLUMN HastaCampania
END
ALTER TABLE ContenidoApp
  ADD HastaCampania INT;

GO

USE BelcorpDominicana
GO

IF(EXISTS(SELECT * 
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'ContenidoApp'
	AND C.NAME = 'HastaCampania'))
BEGIN 
	ALTER TABLE ContenidoApp
	DROP COLUMN HastaCampania
END
ALTER TABLE ContenidoApp
  ADD HastaCampania INT;

GO

USE BelcorpCostaRica
GO

IF(EXISTS(SELECT * 
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'ContenidoApp'
	AND C.NAME = 'HastaCampania'))
BEGIN 
	ALTER TABLE ContenidoApp
	DROP COLUMN HastaCampania
END
ALTER TABLE ContenidoApp
  ADD HastaCampania INT;

GO

USE BelcorpChile
GO

IF(EXISTS(SELECT * 
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'ContenidoApp'
	AND C.NAME = 'HastaCampania'))
BEGIN 
	ALTER TABLE ContenidoApp
	DROP COLUMN HastaCampania
END
ALTER TABLE ContenidoApp
  ADD HastaCampania INT;

GO

USE BelcorpBolivia
GO

IF(EXISTS(SELECT * 
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'ContenidoApp'
	AND C.NAME = 'HastaCampania'))
BEGIN 
	ALTER TABLE ContenidoApp
	DROP COLUMN HastaCampania
END
ALTER TABLE ContenidoApp
  ADD HastaCampania INT;

GO
