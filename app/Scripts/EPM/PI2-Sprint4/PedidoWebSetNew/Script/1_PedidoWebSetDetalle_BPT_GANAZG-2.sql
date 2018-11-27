USE [BelcorpPeru_GANA]
GO

PRINT 'DROP COLUMNS'

IF EXISTS (
	SELECT * 
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'PedidoWebSetDetalle'
	AND C.NAME = 'NombreProducto'
	)
BEGIN
	ALTER TABLE [dbo].[PedidoWebSetDetalle] DROP COLUMN NombreProducto
END
GO

IF EXISTS (
	SELECT * 
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'PedidoWebSetDetalle'
	AND C.NAME = 'CantidadOriginal'
	)
BEGIN
	DECLARE @ConstraintName nvarchar(200)
	SELECT @ConstraintName = Name FROM SYS.DEFAULT_CONSTRAINTS 
	WHERE PARENT_OBJECT_ID = OBJECT_ID('PedidoWebSetDetalle') AND PARENT_COLUMN_ID = (SELECT column_id FROM sys.columns WHERE NAME = N'CantidadOriginal' AND object_id = OBJECT_ID(N'PedidoWebSetDetalle'))
	
	EXEC('ALTER TABLE PedidoWebSetDetalle DROP CONSTRAINT ' + @ConstraintName)
	ALTER TABLE [dbo].[PedidoWebSetDetalle] DROP COLUMN CantidadOriginal
END
GO

IF EXISTS (
	SELECT * 
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'PedidoWebSetDetalle'
	AND C.NAME = 'TipoOfertaSisID'
	)
BEGIN
	ALTER TABLE [dbo].[PedidoWebSetDetalle] DROP COLUMN TipoOfertaSisID
END
GO

PRINT 'ADD COLUMNS'


IF NOT EXISTS (
	SELECT * 
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'PedidoWebSetDetalle'
	AND C.NAME = 'EstrategiaProductoID'
	)
BEGIN
	ALTER TABLE [dbo].[PedidoWebSetDetalle] ADD EstrategiaProductoID INT
END
GO

IF NOT EXISTS (
	SELECT * 
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'PedidoWebSetDetalle'
	AND C.NAME = 'Digitable'
	)
BEGIN
	ALTER TABLE [dbo].[PedidoWebSetDetalle] ADD Digitable INT
END
GO

IF NOT EXISTS (
	SELECT * 
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'PedidoWebSetDetalle'
	AND C.NAME = 'Grupo'
	)
BEGIN
	ALTER TABLE [dbo].[PedidoWebSetDetalle] ADD Grupo INT
END
GO
