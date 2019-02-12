GO
USE BelcorpPeru
GO
PRINT 'ADD COLUMNS'

IF NOT EXISTS (
	SELECT *
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'PedidoWebSetDetalle'
	AND C.NAME = 'NombreProducto'
	)
BEGIN
	ALTER TABLE [dbo].[PedidoWebSetDetalle] ADD NombreProducto NVARCHAR(800)
END
GO

IF NOT EXISTS (
	SELECT *
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'PedidoWebSetDetalle'
	AND C.NAME = 'CantidadOriginal'
	)
BEGIN
	ALTER TABLE [dbo].[PedidoWebSetDetalle] ADD CantidadOriginal INT
	ALTER TABLE [dbo].[PedidoWebSetDetalle] ADD  DEFAULT ((1)) FOR [CantidadOriginal]
END
GO

IF NOT EXISTS (
	SELECT *
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'PedidoWebSetDetalle'
	AND C.NAME = 'TipoOfertaSisID'
	)
BEGIN
	ALTER TABLE [dbo].[PedidoWebSetDetalle] ADD TipoOfertaSisID INT
END
GO

PRINT 'DROP COLUMNS'


IF EXISTS (
	SELECT *
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'PedidoWebSetDetalle'
	AND C.NAME = 'EstrategiaProductoID'
	)
BEGIN
	ALTER TABLE [dbo].[PedidoWebSetDetalle] DROP COLUMN EstrategiaProductoID
END
GO

IF EXISTS (
	SELECT *
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'PedidoWebSetDetalle'
	AND C.NAME = 'Digitable'
	)
BEGIN
	ALTER TABLE [dbo].[PedidoWebSetDetalle] DROP COLUMN Digitable
END
GO

IF EXISTS (
	SELECT *
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'PedidoWebSetDetalle'
	AND C.NAME = 'Grupo'
	)
BEGIN
	ALTER TABLE [dbo].[PedidoWebSetDetalle] DROP COLUMN Grupo
END

GO
USE BelcorpMexico
GO
PRINT 'ADD COLUMNS'

IF NOT EXISTS (
	SELECT *
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'PedidoWebSetDetalle'
	AND C.NAME = 'NombreProducto'
	)
BEGIN
	ALTER TABLE [dbo].[PedidoWebSetDetalle] ADD NombreProducto NVARCHAR(800)
END
GO

IF NOT EXISTS (
	SELECT *
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'PedidoWebSetDetalle'
	AND C.NAME = 'CantidadOriginal'
	)
BEGIN
	ALTER TABLE [dbo].[PedidoWebSetDetalle] ADD CantidadOriginal INT
	ALTER TABLE [dbo].[PedidoWebSetDetalle] ADD  DEFAULT ((1)) FOR [CantidadOriginal]
END
GO

IF NOT EXISTS (
	SELECT *
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'PedidoWebSetDetalle'
	AND C.NAME = 'TipoOfertaSisID'
	)
BEGIN
	ALTER TABLE [dbo].[PedidoWebSetDetalle] ADD TipoOfertaSisID INT
END
GO

PRINT 'DROP COLUMNS'


IF EXISTS (
	SELECT *
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'PedidoWebSetDetalle'
	AND C.NAME = 'EstrategiaProductoID'
	)
BEGIN
	ALTER TABLE [dbo].[PedidoWebSetDetalle] DROP COLUMN EstrategiaProductoID
END
GO

IF EXISTS (
	SELECT *
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'PedidoWebSetDetalle'
	AND C.NAME = 'Digitable'
	)
BEGIN
	ALTER TABLE [dbo].[PedidoWebSetDetalle] DROP COLUMN Digitable
END
GO

IF EXISTS (
	SELECT *
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'PedidoWebSetDetalle'
	AND C.NAME = 'Grupo'
	)
BEGIN
	ALTER TABLE [dbo].[PedidoWebSetDetalle] DROP COLUMN Grupo
END

GO
USE BelcorpColombia
GO
PRINT 'ADD COLUMNS'

IF NOT EXISTS (
	SELECT *
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'PedidoWebSetDetalle'
	AND C.NAME = 'NombreProducto'
	)
BEGIN
	ALTER TABLE [dbo].[PedidoWebSetDetalle] ADD NombreProducto NVARCHAR(800)
END
GO

IF NOT EXISTS (
	SELECT *
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'PedidoWebSetDetalle'
	AND C.NAME = 'CantidadOriginal'
	)
BEGIN
	ALTER TABLE [dbo].[PedidoWebSetDetalle] ADD CantidadOriginal INT
	ALTER TABLE [dbo].[PedidoWebSetDetalle] ADD  DEFAULT ((1)) FOR [CantidadOriginal]
END
GO

IF NOT EXISTS (
	SELECT *
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'PedidoWebSetDetalle'
	AND C.NAME = 'TipoOfertaSisID'
	)
BEGIN
	ALTER TABLE [dbo].[PedidoWebSetDetalle] ADD TipoOfertaSisID INT
END
GO

PRINT 'DROP COLUMNS'


IF EXISTS (
	SELECT *
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'PedidoWebSetDetalle'
	AND C.NAME = 'EstrategiaProductoID'
	)
BEGIN
	ALTER TABLE [dbo].[PedidoWebSetDetalle] DROP COLUMN EstrategiaProductoID
END
GO

IF EXISTS (
	SELECT *
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'PedidoWebSetDetalle'
	AND C.NAME = 'Digitable'
	)
BEGIN
	ALTER TABLE [dbo].[PedidoWebSetDetalle] DROP COLUMN Digitable
END
GO

IF EXISTS (
	SELECT *
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'PedidoWebSetDetalle'
	AND C.NAME = 'Grupo'
	)
BEGIN
	ALTER TABLE [dbo].[PedidoWebSetDetalle] DROP COLUMN Grupo
END

GO
USE BelcorpSalvador
GO
PRINT 'ADD COLUMNS'

IF NOT EXISTS (
	SELECT *
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'PedidoWebSetDetalle'
	AND C.NAME = 'NombreProducto'
	)
BEGIN
	ALTER TABLE [dbo].[PedidoWebSetDetalle] ADD NombreProducto NVARCHAR(800)
END
GO

IF NOT EXISTS (
	SELECT *
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'PedidoWebSetDetalle'
	AND C.NAME = 'CantidadOriginal'
	)
BEGIN
	ALTER TABLE [dbo].[PedidoWebSetDetalle] ADD CantidadOriginal INT
	ALTER TABLE [dbo].[PedidoWebSetDetalle] ADD  DEFAULT ((1)) FOR [CantidadOriginal]
END
GO

IF NOT EXISTS (
	SELECT *
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'PedidoWebSetDetalle'
	AND C.NAME = 'TipoOfertaSisID'
	)
BEGIN
	ALTER TABLE [dbo].[PedidoWebSetDetalle] ADD TipoOfertaSisID INT
END
GO

PRINT 'DROP COLUMNS'


IF EXISTS (
	SELECT *
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'PedidoWebSetDetalle'
	AND C.NAME = 'EstrategiaProductoID'
	)
BEGIN
	ALTER TABLE [dbo].[PedidoWebSetDetalle] DROP COLUMN EstrategiaProductoID
END
GO

IF EXISTS (
	SELECT *
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'PedidoWebSetDetalle'
	AND C.NAME = 'Digitable'
	)
BEGIN
	ALTER TABLE [dbo].[PedidoWebSetDetalle] DROP COLUMN Digitable
END
GO

IF EXISTS (
	SELECT *
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'PedidoWebSetDetalle'
	AND C.NAME = 'Grupo'
	)
BEGIN
	ALTER TABLE [dbo].[PedidoWebSetDetalle] DROP COLUMN Grupo
END

GO
USE BelcorpPuertoRico
GO
PRINT 'ADD COLUMNS'

IF NOT EXISTS (
	SELECT *
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'PedidoWebSetDetalle'
	AND C.NAME = 'NombreProducto'
	)
BEGIN
	ALTER TABLE [dbo].[PedidoWebSetDetalle] ADD NombreProducto NVARCHAR(800)
END
GO

IF NOT EXISTS (
	SELECT *
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'PedidoWebSetDetalle'
	AND C.NAME = 'CantidadOriginal'
	)
BEGIN
	ALTER TABLE [dbo].[PedidoWebSetDetalle] ADD CantidadOriginal INT
	ALTER TABLE [dbo].[PedidoWebSetDetalle] ADD  DEFAULT ((1)) FOR [CantidadOriginal]
END
GO

IF NOT EXISTS (
	SELECT *
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'PedidoWebSetDetalle'
	AND C.NAME = 'TipoOfertaSisID'
	)
BEGIN
	ALTER TABLE [dbo].[PedidoWebSetDetalle] ADD TipoOfertaSisID INT
END
GO

PRINT 'DROP COLUMNS'


IF EXISTS (
	SELECT *
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'PedidoWebSetDetalle'
	AND C.NAME = 'EstrategiaProductoID'
	)
BEGIN
	ALTER TABLE [dbo].[PedidoWebSetDetalle] DROP COLUMN EstrategiaProductoID
END
GO

IF EXISTS (
	SELECT *
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'PedidoWebSetDetalle'
	AND C.NAME = 'Digitable'
	)
BEGIN
	ALTER TABLE [dbo].[PedidoWebSetDetalle] DROP COLUMN Digitable
END
GO

IF EXISTS (
	SELECT *
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'PedidoWebSetDetalle'
	AND C.NAME = 'Grupo'
	)
BEGIN
	ALTER TABLE [dbo].[PedidoWebSetDetalle] DROP COLUMN Grupo
END

GO
USE BelcorpPanama
GO
PRINT 'ADD COLUMNS'

IF NOT EXISTS (
	SELECT *
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'PedidoWebSetDetalle'
	AND C.NAME = 'NombreProducto'
	)
BEGIN
	ALTER TABLE [dbo].[PedidoWebSetDetalle] ADD NombreProducto NVARCHAR(800)
END
GO

IF NOT EXISTS (
	SELECT *
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'PedidoWebSetDetalle'
	AND C.NAME = 'CantidadOriginal'
	)
BEGIN
	ALTER TABLE [dbo].[PedidoWebSetDetalle] ADD CantidadOriginal INT
	ALTER TABLE [dbo].[PedidoWebSetDetalle] ADD  DEFAULT ((1)) FOR [CantidadOriginal]
END
GO

IF NOT EXISTS (
	SELECT *
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'PedidoWebSetDetalle'
	AND C.NAME = 'TipoOfertaSisID'
	)
BEGIN
	ALTER TABLE [dbo].[PedidoWebSetDetalle] ADD TipoOfertaSisID INT
END
GO

PRINT 'DROP COLUMNS'


IF EXISTS (
	SELECT *
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'PedidoWebSetDetalle'
	AND C.NAME = 'EstrategiaProductoID'
	)
BEGIN
	ALTER TABLE [dbo].[PedidoWebSetDetalle] DROP COLUMN EstrategiaProductoID
END
GO

IF EXISTS (
	SELECT *
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'PedidoWebSetDetalle'
	AND C.NAME = 'Digitable'
	)
BEGIN
	ALTER TABLE [dbo].[PedidoWebSetDetalle] DROP COLUMN Digitable
END
GO

IF EXISTS (
	SELECT *
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'PedidoWebSetDetalle'
	AND C.NAME = 'Grupo'
	)
BEGIN
	ALTER TABLE [dbo].[PedidoWebSetDetalle] DROP COLUMN Grupo
END

GO
USE BelcorpGuatemala
GO
PRINT 'ADD COLUMNS'

IF NOT EXISTS (
	SELECT *
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'PedidoWebSetDetalle'
	AND C.NAME = 'NombreProducto'
	)
BEGIN
	ALTER TABLE [dbo].[PedidoWebSetDetalle] ADD NombreProducto NVARCHAR(800)
END
GO

IF NOT EXISTS (
	SELECT *
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'PedidoWebSetDetalle'
	AND C.NAME = 'CantidadOriginal'
	)
BEGIN
	ALTER TABLE [dbo].[PedidoWebSetDetalle] ADD CantidadOriginal INT
	ALTER TABLE [dbo].[PedidoWebSetDetalle] ADD  DEFAULT ((1)) FOR [CantidadOriginal]
END
GO

IF NOT EXISTS (
	SELECT *
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'PedidoWebSetDetalle'
	AND C.NAME = 'TipoOfertaSisID'
	)
BEGIN
	ALTER TABLE [dbo].[PedidoWebSetDetalle] ADD TipoOfertaSisID INT
END
GO

PRINT 'DROP COLUMNS'


IF EXISTS (
	SELECT *
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'PedidoWebSetDetalle'
	AND C.NAME = 'EstrategiaProductoID'
	)
BEGIN
	ALTER TABLE [dbo].[PedidoWebSetDetalle] DROP COLUMN EstrategiaProductoID
END
GO

IF EXISTS (
	SELECT *
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'PedidoWebSetDetalle'
	AND C.NAME = 'Digitable'
	)
BEGIN
	ALTER TABLE [dbo].[PedidoWebSetDetalle] DROP COLUMN Digitable
END
GO

IF EXISTS (
	SELECT *
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'PedidoWebSetDetalle'
	AND C.NAME = 'Grupo'
	)
BEGIN
	ALTER TABLE [dbo].[PedidoWebSetDetalle] DROP COLUMN Grupo
END

GO
USE BelcorpEcuador
GO
PRINT 'ADD COLUMNS'

IF NOT EXISTS (
	SELECT *
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'PedidoWebSetDetalle'
	AND C.NAME = 'NombreProducto'
	)
BEGIN
	ALTER TABLE [dbo].[PedidoWebSetDetalle] ADD NombreProducto NVARCHAR(800)
END
GO

IF NOT EXISTS (
	SELECT *
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'PedidoWebSetDetalle'
	AND C.NAME = 'CantidadOriginal'
	)
BEGIN
	ALTER TABLE [dbo].[PedidoWebSetDetalle] ADD CantidadOriginal INT
	ALTER TABLE [dbo].[PedidoWebSetDetalle] ADD  DEFAULT ((1)) FOR [CantidadOriginal]
END
GO

IF NOT EXISTS (
	SELECT *
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'PedidoWebSetDetalle'
	AND C.NAME = 'TipoOfertaSisID'
	)
BEGIN
	ALTER TABLE [dbo].[PedidoWebSetDetalle] ADD TipoOfertaSisID INT
END
GO

PRINT 'DROP COLUMNS'


IF EXISTS (
	SELECT *
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'PedidoWebSetDetalle'
	AND C.NAME = 'EstrategiaProductoID'
	)
BEGIN
	ALTER TABLE [dbo].[PedidoWebSetDetalle] DROP COLUMN EstrategiaProductoID
END
GO

IF EXISTS (
	SELECT *
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'PedidoWebSetDetalle'
	AND C.NAME = 'Digitable'
	)
BEGIN
	ALTER TABLE [dbo].[PedidoWebSetDetalle] DROP COLUMN Digitable
END
GO

IF EXISTS (
	SELECT *
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'PedidoWebSetDetalle'
	AND C.NAME = 'Grupo'
	)
BEGIN
	ALTER TABLE [dbo].[PedidoWebSetDetalle] DROP COLUMN Grupo
END

GO
USE BelcorpDominicana
GO
PRINT 'ADD COLUMNS'

IF NOT EXISTS (
	SELECT *
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'PedidoWebSetDetalle'
	AND C.NAME = 'NombreProducto'
	)
BEGIN
	ALTER TABLE [dbo].[PedidoWebSetDetalle] ADD NombreProducto NVARCHAR(800)
END
GO

IF NOT EXISTS (
	SELECT *
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'PedidoWebSetDetalle'
	AND C.NAME = 'CantidadOriginal'
	)
BEGIN
	ALTER TABLE [dbo].[PedidoWebSetDetalle] ADD CantidadOriginal INT
	ALTER TABLE [dbo].[PedidoWebSetDetalle] ADD  DEFAULT ((1)) FOR [CantidadOriginal]
END
GO

IF NOT EXISTS (
	SELECT *
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'PedidoWebSetDetalle'
	AND C.NAME = 'TipoOfertaSisID'
	)
BEGIN
	ALTER TABLE [dbo].[PedidoWebSetDetalle] ADD TipoOfertaSisID INT
END
GO

PRINT 'DROP COLUMNS'


IF EXISTS (
	SELECT *
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'PedidoWebSetDetalle'
	AND C.NAME = 'EstrategiaProductoID'
	)
BEGIN
	ALTER TABLE [dbo].[PedidoWebSetDetalle] DROP COLUMN EstrategiaProductoID
END
GO

IF EXISTS (
	SELECT *
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'PedidoWebSetDetalle'
	AND C.NAME = 'Digitable'
	)
BEGIN
	ALTER TABLE [dbo].[PedidoWebSetDetalle] DROP COLUMN Digitable
END
GO

IF EXISTS (
	SELECT *
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'PedidoWebSetDetalle'
	AND C.NAME = 'Grupo'
	)
BEGIN
	ALTER TABLE [dbo].[PedidoWebSetDetalle] DROP COLUMN Grupo
END

GO
USE BelcorpCostaRica
GO
PRINT 'ADD COLUMNS'

IF NOT EXISTS (
	SELECT *
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'PedidoWebSetDetalle'
	AND C.NAME = 'NombreProducto'
	)
BEGIN
	ALTER TABLE [dbo].[PedidoWebSetDetalle] ADD NombreProducto NVARCHAR(800)
END
GO

IF NOT EXISTS (
	SELECT *
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'PedidoWebSetDetalle'
	AND C.NAME = 'CantidadOriginal'
	)
BEGIN
	ALTER TABLE [dbo].[PedidoWebSetDetalle] ADD CantidadOriginal INT
	ALTER TABLE [dbo].[PedidoWebSetDetalle] ADD  DEFAULT ((1)) FOR [CantidadOriginal]
END
GO

IF NOT EXISTS (
	SELECT *
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'PedidoWebSetDetalle'
	AND C.NAME = 'TipoOfertaSisID'
	)
BEGIN
	ALTER TABLE [dbo].[PedidoWebSetDetalle] ADD TipoOfertaSisID INT
END
GO

PRINT 'DROP COLUMNS'


IF EXISTS (
	SELECT *
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'PedidoWebSetDetalle'
	AND C.NAME = 'EstrategiaProductoID'
	)
BEGIN
	ALTER TABLE [dbo].[PedidoWebSetDetalle] DROP COLUMN EstrategiaProductoID
END
GO

IF EXISTS (
	SELECT *
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'PedidoWebSetDetalle'
	AND C.NAME = 'Digitable'
	)
BEGIN
	ALTER TABLE [dbo].[PedidoWebSetDetalle] DROP COLUMN Digitable
END
GO

IF EXISTS (
	SELECT *
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'PedidoWebSetDetalle'
	AND C.NAME = 'Grupo'
	)
BEGIN
	ALTER TABLE [dbo].[PedidoWebSetDetalle] DROP COLUMN Grupo
END

GO
USE BelcorpChile
GO
PRINT 'ADD COLUMNS'

IF NOT EXISTS (
	SELECT *
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'PedidoWebSetDetalle'
	AND C.NAME = 'NombreProducto'
	)
BEGIN
	ALTER TABLE [dbo].[PedidoWebSetDetalle] ADD NombreProducto NVARCHAR(800)
END
GO

IF NOT EXISTS (
	SELECT *
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'PedidoWebSetDetalle'
	AND C.NAME = 'CantidadOriginal'
	)
BEGIN
	ALTER TABLE [dbo].[PedidoWebSetDetalle] ADD CantidadOriginal INT
	ALTER TABLE [dbo].[PedidoWebSetDetalle] ADD  DEFAULT ((1)) FOR [CantidadOriginal]
END
GO

IF NOT EXISTS (
	SELECT *
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'PedidoWebSetDetalle'
	AND C.NAME = 'TipoOfertaSisID'
	)
BEGIN
	ALTER TABLE [dbo].[PedidoWebSetDetalle] ADD TipoOfertaSisID INT
END
GO

PRINT 'DROP COLUMNS'


IF EXISTS (
	SELECT *
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'PedidoWebSetDetalle'
	AND C.NAME = 'EstrategiaProductoID'
	)
BEGIN
	ALTER TABLE [dbo].[PedidoWebSetDetalle] DROP COLUMN EstrategiaProductoID
END
GO

IF EXISTS (
	SELECT *
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'PedidoWebSetDetalle'
	AND C.NAME = 'Digitable'
	)
BEGIN
	ALTER TABLE [dbo].[PedidoWebSetDetalle] DROP COLUMN Digitable
END
GO

IF EXISTS (
	SELECT *
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'PedidoWebSetDetalle'
	AND C.NAME = 'Grupo'
	)
BEGIN
	ALTER TABLE [dbo].[PedidoWebSetDetalle] DROP COLUMN Grupo
END

GO
USE BelcorpBolivia
GO
PRINT 'ADD COLUMNS'

IF NOT EXISTS (
	SELECT *
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'PedidoWebSetDetalle'
	AND C.NAME = 'NombreProducto'
	)
BEGIN
	ALTER TABLE [dbo].[PedidoWebSetDetalle] ADD NombreProducto NVARCHAR(800)
END
GO

IF NOT EXISTS (
	SELECT *
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'PedidoWebSetDetalle'
	AND C.NAME = 'CantidadOriginal'
	)
BEGIN
	ALTER TABLE [dbo].[PedidoWebSetDetalle] ADD CantidadOriginal INT
	ALTER TABLE [dbo].[PedidoWebSetDetalle] ADD  DEFAULT ((1)) FOR [CantidadOriginal]
END
GO

IF NOT EXISTS (
	SELECT *
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'PedidoWebSetDetalle'
	AND C.NAME = 'TipoOfertaSisID'
	)
BEGIN
	ALTER TABLE [dbo].[PedidoWebSetDetalle] ADD TipoOfertaSisID INT
END
GO

PRINT 'DROP COLUMNS'


IF EXISTS (
	SELECT *
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'PedidoWebSetDetalle'
	AND C.NAME = 'EstrategiaProductoID'
	)
BEGIN
	ALTER TABLE [dbo].[PedidoWebSetDetalle] DROP COLUMN EstrategiaProductoID
END
GO

IF EXISTS (
	SELECT *
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'PedidoWebSetDetalle'
	AND C.NAME = 'Digitable'
	)
BEGIN
	ALTER TABLE [dbo].[PedidoWebSetDetalle] DROP COLUMN Digitable
END
GO

IF EXISTS (
	SELECT *
	FROM SYS.COLUMNS C
	JOIN SYS.OBJECTS  O
	ON C.[OBJECT_ID] = O.[OBJECT_ID]
	WHERE  O.TYPE = 'U'
	AND O.NAME = 'PedidoWebSetDetalle'
	AND C.NAME = 'Grupo'
	)
BEGIN
	ALTER TABLE [dbo].[PedidoWebSetDetalle] DROP COLUMN Grupo
END

GO
