USE BelcorpBolivia
GO
IF  EXISTS (
	SELECT * 
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'LogCDRWebDetalle'
	AND C.NAME = 'DetalleReemplazo'
	)
BEGIN
     ALTER TABLE interfaces.LogCDRWebDetalle
     DROP COLUMN DetalleReemplazo
END
GO

USE BelcorpChile
GO
IF  EXISTS (
	SELECT * 
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'LogCDRWebDetalle'
	AND C.NAME = 'DetalleReemplazo'
	)
BEGIN
     ALTER TABLE interfaces.LogCDRWebDetalle
     DROP COLUMN DetalleReemplazo
END
GO

USE BelcorpColombia
GO
IF  EXISTS (
	SELECT * 
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'LogCDRWebDetalle'
	AND C.NAME = 'DetalleReemplazo'
	)
BEGIN
     ALTER TABLE interfaces.LogCDRWebDetalle
     DROP COLUMN DetalleReemplazo
END
GO

USE BelcorpCostaRica
GO
IF  EXISTS (
	SELECT * 
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'LogCDRWebDetalle'
	AND C.NAME = 'DetalleReemplazo'
	)
BEGIN
     ALTER TABLE interfaces.LogCDRWebDetalle
     DROP COLUMN DetalleReemplazo
END
GO

USE BelcorpDominicana
GO
IF  EXISTS (
	SELECT * 
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'LogCDRWebDetalle'
	AND C.NAME = 'DetalleReemplazo'
	)
BEGIN
     ALTER TABLE interfaces.LogCDRWebDetalle
     DROP COLUMN DetalleReemplazo
END
GO

USE BelcorpEcuador
GO
IF  EXISTS (
	SELECT * 
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'LogCDRWebDetalle'
	AND C.NAME = 'DetalleReemplazo'
	)
BEGIN
     ALTER TABLE interfaces.LogCDRWebDetalle
     DROP COLUMN DetalleReemplazo
END
GO

USE BelcorpGuatemala
GO
IF  EXISTS (
	SELECT * 
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'LogCDRWebDetalle'
	AND C.NAME = 'DetalleReemplazo'
	)
BEGIN
     ALTER TABLE interfaces.LogCDRWebDetalle
     DROP COLUMN DetalleReemplazo
END
GO

USE BelcorpMexico
GO
IF  EXISTS (
	SELECT * 
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'LogCDRWebDetalle'
	AND C.NAME = 'DetalleReemplazo'
	)
BEGIN
     ALTER TABLE interfaces.LogCDRWebDetalle
     DROP COLUMN DetalleReemplazo
END
GO

USE BelcorpPanama
GO
IF  EXISTS (
	SELECT * 
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'LogCDRWebDetalle'
	AND C.NAME = 'DetalleReemplazo'
	)
BEGIN
     ALTER TABLE interfaces.LogCDRWebDetalle
     DROP COLUMN DetalleReemplazo
END
GO

USE BelcorpPeru
GO
IF  EXISTS (
	SELECT * 
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'LogCDRWebDetalle'
	AND C.NAME = 'DetalleReemplazo'
	)
BEGIN
     ALTER TABLE interfaces.LogCDRWebDetalle
     DROP COLUMN DetalleReemplazo
END
GO

USE BelcorpPuertoRico
GO
IF  EXISTS (
	SELECT * 
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'LogCDRWebDetalle'
	AND C.NAME = 'DetalleReemplazo'
	)
BEGIN
     ALTER TABLE interfaces.LogCDRWebDetalle
     DROP COLUMN DetalleReemplazo
END
GO

USE BelcorpSalvador
GO
IF  EXISTS (
	SELECT * 
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'LogCDRWebDetalle'
	AND C.NAME = 'DetalleReemplazo'
	)
BEGIN
     ALTER TABLE interfaces.LogCDRWebDetalle
     DROP COLUMN DetalleReemplazo
END
GO