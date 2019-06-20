USE [BelcorpBolivia];
GO
IF NOT EXISTS (
	SELECT * 
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'Comunicado'
	AND C.NAME = 'Comentario'
	)
BEGIN
	ALTER TABLE Comunicado
	ADD Comentario varchar(max) NULL
END
GO
GO
USE [BelcorpChile];
GO
IF NOT EXISTS (
	SELECT * 
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'Comunicado'
	AND C.NAME = 'Comentario'
	)
BEGIN
	ALTER TABLE Comunicado
	ADD Comentario varchar(max) NULL
END
GO
GO
USE [BelcorpColombia];
GO
IF NOT EXISTS (
	SELECT * 
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'Comunicado'
	AND C.NAME = 'Comentario'
	)
BEGIN
	ALTER TABLE Comunicado
	ADD Comentario varchar(max) NULL
END
GO
GO
USE [BelcorpCostaRica];
GO
IF NOT EXISTS (
	SELECT * 
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'Comunicado'
	AND C.NAME = 'Comentario'
	)
BEGIN
	ALTER TABLE Comunicado
	ADD Comentario varchar(max) NULL
END
GO
GO
USE [BelcorpDominicana];
GO
IF NOT EXISTS (
	SELECT * 
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'Comunicado'
	AND C.NAME = 'Comentario'
	)
BEGIN
	ALTER TABLE Comunicado
	ADD Comentario varchar(max) NULL
END
GO
GO
USE [BelcorpEcuador];
GO
IF NOT EXISTS (
	SELECT * 
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'Comunicado'
	AND C.NAME = 'Comentario'
	)
BEGIN
	ALTER TABLE Comunicado
	ADD Comentario varchar(max) NULL
END
GO
GO
USE [BelcorpGuatemala];
GO
IF NOT EXISTS (
	SELECT * 
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'Comunicado'
	AND C.NAME = 'Comentario'
	)
BEGIN
	ALTER TABLE Comunicado
	ADD Comentario varchar(max) NULL
END
GO
GO
USE [BelcorpMexico];
GO
IF NOT EXISTS (
	SELECT * 
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'Comunicado'
	AND C.NAME = 'Comentario'
	)
BEGIN
	ALTER TABLE Comunicado
	ADD Comentario varchar(max) NULL
END
GO
GO
USE [BelcorpPanama];
GO
IF NOT EXISTS (
	SELECT * 
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'Comunicado'
	AND C.NAME = 'Comentario'
	)
BEGIN
	ALTER TABLE Comunicado
	ADD Comentario varchar(max) NULL
END
GO
GO
USE [BelcorpPeru];
GO
IF NOT EXISTS (
	SELECT * 
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'Comunicado'
	AND C.NAME = 'Comentario'
	)
BEGIN
	ALTER TABLE Comunicado
	ADD Comentario varchar(max) NULL
END
GO
GO
USE [BelcorpPuertoRico];
GO
IF NOT EXISTS (
	SELECT * 
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'Comunicado'
	AND C.NAME = 'Comentario'
	)
BEGIN
	ALTER TABLE Comunicado
	ADD Comentario varchar(max) NULL
END
GO
GO
USE [BelcorpSalvador];
GO
IF NOT EXISTS (
	SELECT * 
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'Comunicado'
	AND C.NAME = 'Comentario'
	)
BEGIN
	ALTER TABLE Comunicado
	ADD Comentario varchar(max) NULL
END
GO
GO
