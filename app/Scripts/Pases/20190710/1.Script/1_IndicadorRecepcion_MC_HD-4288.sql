use [BelcorpBolivia]	
go
IF NOT EXISTS (
	SELECT * 
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'pedidoweb'
	AND C.NAME = 'IndicadorRecepcion'
	)
BEGIN
	ALTER TABLE pedidoweb
	ADD IndicadorRecepcion bit NOT NULL CONSTRAINT [DF__PedidoWeb__IndicadorRecepcion] DEFAULT (0)
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
	AND C.NAME = 'IndicadorRecepcion'
	)
BEGIN
	ALTER TABLE pedidoweb
	ADD IndicadorRecepcion bit NOT NULL CONSTRAINT [DF__PedidoWeb__IndicadorRecepcion] DEFAULT (0)
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
	AND C.NAME = 'IndicadorRecepcion'
	)
BEGIN
	ALTER TABLE pedidoweb
	ADD IndicadorRecepcion bit NOT NULL CONSTRAINT [DF__PedidoWeb__IndicadorRecepcion] DEFAULT (0)
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
	AND C.NAME = 'IndicadorRecepcion'
	)
BEGIN
	ALTER TABLE pedidoweb
	ADD IndicadorRecepcion bit NOT NULL CONSTRAINT [DF__PedidoWeb__IndicadorRecepcion] DEFAULT (0)
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
	AND C.NAME = 'IndicadorRecepcion'
	)
BEGIN
	ALTER TABLE pedidoweb
	ADD IndicadorRecepcion bit NOT NULL CONSTRAINT [DF__PedidoWeb__IndicadorRecepcion] DEFAULT (0)
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
	AND C.NAME = 'IndicadorRecepcion'
	)
BEGIN
	ALTER TABLE pedidoweb
	ADD IndicadorRecepcion bit NOT NULL CONSTRAINT [DF__PedidoWeb__IndicadorRecepcion] DEFAULT (0)
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
	AND C.NAME = 'IndicadorRecepcion'
	)
BEGIN
	ALTER TABLE pedidoweb
	ADD IndicadorRecepcion bit NOT NULL CONSTRAINT [DF__PedidoWeb__IndicadorRecepcion] DEFAULT (0)
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
	AND C.NAME = 'IndicadorRecepcion'
	)
BEGIN
	ALTER TABLE pedidoweb
	ADD IndicadorRecepcion bit NOT NULL CONSTRAINT [DF__PedidoWeb__IndicadorRecepcion] DEFAULT (0)
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
	AND C.NAME = 'IndicadorRecepcion'
	)
BEGIN
	ALTER TABLE pedidoweb
	ADD IndicadorRecepcion bit NOT NULL CONSTRAINT [DF__PedidoWeb__IndicadorRecepcion] DEFAULT (0)
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
	AND C.NAME = 'IndicadorRecepcion'
	)
BEGIN
	ALTER TABLE pedidoweb
	ADD IndicadorRecepcion bit NOT NULL CONSTRAINT [DF__PedidoWeb__IndicadorRecepcion] DEFAULT (0)
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
	AND C.NAME = 'IndicadorRecepcion'
	)
BEGIN
	ALTER TABLE pedidoweb
	ADD IndicadorRecepcion bit NOT NULL CONSTRAINT [DF__PedidoWeb__IndicadorRecepcion] DEFAULT (0)
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
	AND C.NAME = 'IndicadorRecepcion'
	)
BEGIN
	ALTER TABLE pedidoweb
	ADD IndicadorRecepcion bit NOT NULL CONSTRAINT [DF__PedidoWeb__IndicadorRecepcion] DEFAULT (0)
END
GO