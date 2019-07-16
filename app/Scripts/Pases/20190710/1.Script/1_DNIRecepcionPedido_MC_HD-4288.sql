use [BelcorpBolivia]	
go
IF NOT EXISTS (
	SELECT * 
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'pedidoweb'
	AND C.NAME = 'DNIRecepcionPedido'
	)
BEGIN
	ALTER TABLE pedidoweb
	ADD DNIRecepcionPedido varchar(512) null
END
GO

use [BelcorpChile]	
go
IF NOT EXISTS (
	SELECT * 
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'pedidoweb'
	AND C.NAME = 'DNIRecepcionPedido'
	)
BEGIN
	ALTER TABLE pedidoweb
	ADD DNIRecepcionPedido varchar(512) null
END
GO


use [BelcorpColombia]	
go
IF NOT EXISTS (
	SELECT * 
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'pedidoweb'
	AND C.NAME = 'DNIRecepcionPedido'
	)
BEGIN
	ALTER TABLE pedidoweb
	ADD DNIRecepcionPedido varchar(512) null
END
GO


use [BelcorpCostaRica]	
go
IF NOT EXISTS (
	SELECT * 
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'pedidoweb'
	AND C.NAME = 'DNIRecepcionPedido'
	)
BEGIN
	ALTER TABLE pedidoweb
	ADD DNIRecepcionPedido varchar(512) null
END
GO


use [BelcorpDominicana]	
go
IF NOT EXISTS (
	SELECT * 
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'pedidoweb'
	AND C.NAME = 'DNIRecepcionPedido'
	)
BEGIN
	ALTER TABLE pedidoweb
	ADD DNIRecepcionPedido varchar(512) null
END
GO


use [BelcorpEcuador]	
go
IF NOT EXISTS (
	SELECT * 
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'pedidoweb'
	AND C.NAME = 'DNIRecepcionPedido'
	)
BEGIN
	ALTER TABLE pedidoweb
	ADD DNIRecepcionPedido varchar(512) null
END
GO


use [BelcorpGuatemala]	
go
IF NOT EXISTS (
	SELECT * 
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'pedidoweb'
	AND C.NAME = 'DNIRecepcionPedido'
	)
BEGIN
	ALTER TABLE pedidoweb
	ADD DNIRecepcionPedido varchar(512) null
END
GO


use [BelcorpMexico]	
go
IF NOT EXISTS (
	SELECT * 
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'pedidoweb'
	AND C.NAME = 'DNIRecepcionPedido'
	)
BEGIN
	ALTER TABLE pedidoweb
	ADD DNIRecepcionPedido varchar(512) null
END
GO


use [BelcorpPanama]	
go
IF NOT EXISTS (
	SELECT * 
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'pedidoweb'
	AND C.NAME = 'DNIRecepcionPedido'
	)
BEGIN
	ALTER TABLE pedidoweb
	ADD DNIRecepcionPedido varchar(512) null
END
GO


use [BelcorpPeru]	
go
IF NOT EXISTS (
	SELECT * 
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'pedidoweb'
	AND C.NAME = 'DNIRecepcionPedido'
	)
BEGIN
	ALTER TABLE pedidoweb
	ADD DNIRecepcionPedido varchar(512) null
END
GO


use [BelcorpPuertoRico]	
go
IF NOT EXISTS (
	SELECT * 
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'pedidoweb'
	AND C.NAME = 'DNIRecepcionPedido'
	)
BEGIN
	ALTER TABLE pedidoweb
	ADD DNIRecepcionPedido varchar(512) null
END
GO


use [BelcorpSalvador]	
go
IF NOT EXISTS (
	SELECT * 
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'pedidoweb'
	AND C.NAME = 'DNIRecepcionPedido'
	)
BEGIN
	ALTER TABLE pedidoweb
	ADD DNIRecepcionPedido varchar(512) null
END
GO