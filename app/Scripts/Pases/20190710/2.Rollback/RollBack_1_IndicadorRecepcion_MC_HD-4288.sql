use [BelcorpBolivia]	
go

IF  EXISTS (
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
	DROP CONSTRAINT DF__PedidoWeb__IndicadorRecepcion

	ALTER TABLE pedidoweb
    DROP COLUMN IndicadorRecepcion
END
GO


use [BelcorpChile]	
go

IF  EXISTS (
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
	DROP CONSTRAINT DF__PedidoWeb__IndicadorRecepcion

	ALTER TABLE pedidoweb
    DROP COLUMN IndicadorRecepcion
END
GO


use [BelcorpColombia]	
go

IF  EXISTS (
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
	DROP CONSTRAINT DF__PedidoWeb__IndicadorRecepcion

	ALTER TABLE pedidoweb
    DROP COLUMN IndicadorRecepcion
END
GO


use [BelcorpCostaRica]	
go

IF  EXISTS (
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
	DROP CONSTRAINT DF__PedidoWeb__IndicadorRecepcion

	ALTER TABLE pedidoweb
    DROP COLUMN IndicadorRecepcion
END
GO


use [BelcorpDominicana]	
go

IF  EXISTS (
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
	DROP CONSTRAINT DF__PedidoWeb__IndicadorRecepcion

	ALTER TABLE pedidoweb
    DROP COLUMN IndicadorRecepcion
END
GO


use [BelcorpEcuador]	
go

IF  EXISTS (
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
	DROP CONSTRAINT DF__PedidoWeb__IndicadorRecepcion

	ALTER TABLE pedidoweb
    DROP COLUMN IndicadorRecepcion
END
GO


use [BelcorpGuatemala]	
go

IF  EXISTS (
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
	DROP CONSTRAINT DF__PedidoWeb__IndicadorRecepcion

	ALTER TABLE pedidoweb
    DROP COLUMN IndicadorRecepcion
END
GO


use [BelcorpMexico]	
go

IF  EXISTS (
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
	DROP CONSTRAINT DF__PedidoWeb__IndicadorRecepcion

	ALTER TABLE pedidoweb
    DROP COLUMN IndicadorRecepcion
END
GO


use [BelcorpPanama]	
go

IF  EXISTS (
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
	DROP CONSTRAINT DF__PedidoWeb__IndicadorRecepcion

	ALTER TABLE pedidoweb
    DROP COLUMN IndicadorRecepcion
END
GO


use [BelcorpPeru]	
go

IF  EXISTS (
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
	DROP CONSTRAINT DF__PedidoWeb__IndicadorRecepcion

	ALTER TABLE pedidoweb
    DROP COLUMN IndicadorRecepcion
END
GO


use [BelcorpPuertoRico]	
go

IF  EXISTS (
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
	DROP CONSTRAINT DF__PedidoWeb__IndicadorRecepcion

	ALTER TABLE pedidoweb
    DROP COLUMN IndicadorRecepcion
END
GO


use [BelcorpSalvador]	
go

IF  EXISTS (
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
	DROP CONSTRAINT DF__PedidoWeb__IndicadorRecepcion

	ALTER TABLE pedidoweb
    DROP COLUMN IndicadorRecepcion
END
GO