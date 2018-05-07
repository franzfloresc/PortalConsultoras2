USE BelcorpBolivia
GO

IF OBJECT_ID (N'PedidoWebSet', N'U') IS NULL 
BEGIN
	CREATE TABLE PedidoWebSet (
		SetID INT IDENTITY(1, 1) primary KEY
		,PedidoID INT
		,CuvSet VARCHAR(20)
		,EstrategiaId INT
		,NombreSet NVARCHAR(800)
		,Cantidad INT
		,PrecioUnidad MONEY
		,ImporteTotal MONEY
		,TipoEstrategiaId INT
		,Campania INT
		, ConsultoraID BIGINT
		,OrdenPedido INT
		,CodigoUsuarioCreacion VARCHAR(25)
		,CodigoUsuarioModificacion VARCHAR(25)
		,FechaCreacion DATETIME
		,FechaModificacion DATETIME
		)
END
GO

IF OBJECT_ID (N'PedidoWebSetDetalle', N'U') IS  NULL 
BEGIN
	CREATE TABLE PedidoWebSetDetalle (
		SetDetalleID INT IDENTITY(1, 1) primary KEY
		,[SetID] INT FOREIGN KEY (SetID) REFERENCES PedidoWebSet(SetID) ON DELETE CASCADE
		,[CuvProducto] NVARCHAR(20)
		,NombreProducto NVARCHAR(800)
		,[Cantidad] INT DEFAULT 1
		,[CantidadOriginal] INT DEFAULT 1
		,[FactorRepeticion] INT DEFAULT 0
		,[PedidoDetalleID] INT
		,PrecioUnidad  money  null
		,TipoOfertaSisID  int null
		)
END
GO

USE BelcorpChile
GO

IF OBJECT_ID (N'PedidoWebSet', N'U') IS NULL 
BEGIN
	CREATE TABLE PedidoWebSet (
		SetID INT IDENTITY(1, 1) primary KEY
		,PedidoID INT
		,CuvSet VARCHAR(20)
		,EstrategiaId INT
		,NombreSet NVARCHAR(800)
		,Cantidad INT
		,PrecioUnidad MONEY
		,ImporteTotal MONEY
		,TipoEstrategiaId INT
		,Campania INT
		, ConsultoraID BIGINT
		,OrdenPedido INT
		,CodigoUsuarioCreacion VARCHAR(25)
		,CodigoUsuarioModificacion VARCHAR(25)
		,FechaCreacion DATETIME
		,FechaModificacion DATETIME
		)
END
GO

IF OBJECT_ID (N'PedidoWebSetDetalle', N'U') IS  NULL 
BEGIN
	CREATE TABLE PedidoWebSetDetalle (
		SetDetalleID INT IDENTITY(1, 1) primary KEY
		,[SetID] INT FOREIGN KEY (SetID) REFERENCES PedidoWebSet(SetID) ON DELETE CASCADE
		,[CuvProducto] NVARCHAR(20)
		,NombreProducto NVARCHAR(800)
		,[Cantidad] INT DEFAULT 1
		,[CantidadOriginal] INT DEFAULT 1
		,[FactorRepeticion] INT DEFAULT 0
		,[PedidoDetalleID] INT
		,PrecioUnidad  money  null
		,TipoOfertaSisID  int null
		)
END
GO

USE BelcorpColombia
GO

IF OBJECT_ID (N'PedidoWebSet', N'U') IS NULL 
BEGIN
	CREATE TABLE PedidoWebSet (
		SetID INT IDENTITY(1, 1) primary KEY
		,PedidoID INT
		,CuvSet VARCHAR(20)
		,EstrategiaId INT
		,NombreSet NVARCHAR(800)
		,Cantidad INT
		,PrecioUnidad MONEY
		,ImporteTotal MONEY
		,TipoEstrategiaId INT
		,Campania INT
		, ConsultoraID BIGINT
		,OrdenPedido INT
		,CodigoUsuarioCreacion VARCHAR(25)
		,CodigoUsuarioModificacion VARCHAR(25)
		,FechaCreacion DATETIME
		,FechaModificacion DATETIME
		)
END
GO

IF OBJECT_ID (N'PedidoWebSetDetalle', N'U') IS  NULL 
BEGIN
	CREATE TABLE PedidoWebSetDetalle (
		SetDetalleID INT IDENTITY(1, 1) primary KEY
		,[SetID] INT FOREIGN KEY (SetID) REFERENCES PedidoWebSet(SetID) ON DELETE CASCADE
		,[CuvProducto] NVARCHAR(20)
		,NombreProducto NVARCHAR(800)
		,[Cantidad] INT DEFAULT 1
		,[CantidadOriginal] INT DEFAULT 1
		,[FactorRepeticion] INT DEFAULT 0
		,[PedidoDetalleID] INT
		,PrecioUnidad  money  null
		,TipoOfertaSisID  int null
		)
END
GO

USE BelcorpCostaRica
GO

IF OBJECT_ID (N'PedidoWebSet', N'U') IS NULL 
BEGIN
	CREATE TABLE PedidoWebSet (
		SetID INT IDENTITY(1, 1) primary KEY
		,PedidoID INT
		,CuvSet VARCHAR(20)
		,EstrategiaId INT
		,NombreSet NVARCHAR(800)
		,Cantidad INT
		,PrecioUnidad MONEY
		,ImporteTotal MONEY
		,TipoEstrategiaId INT
		,Campania INT
		, ConsultoraID BIGINT
		,OrdenPedido INT
		,CodigoUsuarioCreacion VARCHAR(25)
		,CodigoUsuarioModificacion VARCHAR(25)
		,FechaCreacion DATETIME
		,FechaModificacion DATETIME
		)
END
GO

IF OBJECT_ID (N'PedidoWebSetDetalle', N'U') IS  NULL 
BEGIN
	CREATE TABLE PedidoWebSetDetalle (
		SetDetalleID INT IDENTITY(1, 1) primary KEY
		,[SetID] INT FOREIGN KEY (SetID) REFERENCES PedidoWebSet(SetID) ON DELETE CASCADE
		,[CuvProducto] NVARCHAR(20)
		,NombreProducto NVARCHAR(800)
		,[Cantidad] INT DEFAULT 1
		,[CantidadOriginal] INT DEFAULT 1
		,[FactorRepeticion] INT DEFAULT 0
		,[PedidoDetalleID] INT
		,PrecioUnidad  money  null
		,TipoOfertaSisID  int null
		)
END
GO

USE BelcorpDominicana
GO

IF OBJECT_ID (N'PedidoWebSet', N'U') IS NULL 
BEGIN
	CREATE TABLE PedidoWebSet (
		SetID INT IDENTITY(1, 1) primary KEY
		,PedidoID INT
		,CuvSet VARCHAR(20)
		,EstrategiaId INT
		,NombreSet NVARCHAR(800)
		,Cantidad INT
		,PrecioUnidad MONEY
		,ImporteTotal MONEY
		,TipoEstrategiaId INT
		,Campania INT
		, ConsultoraID BIGINT
		,OrdenPedido INT
		,CodigoUsuarioCreacion VARCHAR(25)
		,CodigoUsuarioModificacion VARCHAR(25)
		,FechaCreacion DATETIME
		,FechaModificacion DATETIME
		)
END
GO

IF OBJECT_ID (N'PedidoWebSetDetalle', N'U') IS  NULL 
BEGIN
	CREATE TABLE PedidoWebSetDetalle (
		SetDetalleID INT IDENTITY(1, 1) primary KEY
		,[SetID] INT FOREIGN KEY (SetID) REFERENCES PedidoWebSet(SetID) ON DELETE CASCADE
		,[CuvProducto] NVARCHAR(20)
		,NombreProducto NVARCHAR(800)
		,[Cantidad] INT DEFAULT 1
		,[CantidadOriginal] INT DEFAULT 1
		,[FactorRepeticion] INT DEFAULT 0
		,[PedidoDetalleID] INT
		,PrecioUnidad  money  null
		,TipoOfertaSisID  int null
		)
END
GO


USE BelcorpEcuador
GO

IF OBJECT_ID (N'PedidoWebSet', N'U') IS NULL 
BEGIN
	CREATE TABLE PedidoWebSet (
		SetID INT IDENTITY(1, 1) primary KEY
		,PedidoID INT
		,CuvSet VARCHAR(20)
		,EstrategiaId INT
		,NombreSet NVARCHAR(800)
		,Cantidad INT
		,PrecioUnidad MONEY
		,ImporteTotal MONEY
		,TipoEstrategiaId INT
		,Campania INT
		, ConsultoraID BIGINT
		,OrdenPedido INT
		,CodigoUsuarioCreacion VARCHAR(25)
		,CodigoUsuarioModificacion VARCHAR(25)
		,FechaCreacion DATETIME
		,FechaModificacion DATETIME
		)
END
GO

IF OBJECT_ID (N'PedidoWebSetDetalle', N'U') IS  NULL 
BEGIN
	CREATE TABLE PedidoWebSetDetalle (
		SetDetalleID INT IDENTITY(1, 1) primary KEY
		,[SetID] INT FOREIGN KEY (SetID) REFERENCES PedidoWebSet(SetID) ON DELETE CASCADE
		,[CuvProducto] NVARCHAR(20)
		,NombreProducto NVARCHAR(800)
		,[Cantidad] INT DEFAULT 1
		,[CantidadOriginal] INT DEFAULT 1
		,[FactorRepeticion] INT DEFAULT 0
		,[PedidoDetalleID] INT
		,PrecioUnidad  money  null
		,TipoOfertaSisID  int null
		)
END
GO

USE BelcorpGuatemala
GO

IF OBJECT_ID (N'PedidoWebSet', N'U') IS NULL 
BEGIN
	CREATE TABLE PedidoWebSet (
		SetID INT IDENTITY(1, 1) primary KEY
		,PedidoID INT
		,CuvSet VARCHAR(20)
		,EstrategiaId INT
		,NombreSet NVARCHAR(800)
		,Cantidad INT
		,PrecioUnidad MONEY
		,ImporteTotal MONEY
		,TipoEstrategiaId INT
		,Campania INT
		, ConsultoraID BIGINT
		,OrdenPedido INT
		,CodigoUsuarioCreacion VARCHAR(25)
		,CodigoUsuarioModificacion VARCHAR(25)
		,FechaCreacion DATETIME
		,FechaModificacion DATETIME
		)
END
GO

IF OBJECT_ID (N'PedidoWebSetDetalle', N'U') IS  NULL 
BEGIN
	CREATE TABLE PedidoWebSetDetalle (
		SetDetalleID INT IDENTITY(1, 1) primary KEY
		,[SetID] INT FOREIGN KEY (SetID) REFERENCES PedidoWebSet(SetID) ON DELETE CASCADE
		,[CuvProducto] NVARCHAR(20)
		,NombreProducto NVARCHAR(800)
		,[Cantidad] INT DEFAULT 1
		,[CantidadOriginal] INT DEFAULT 1
		,[FactorRepeticion] INT DEFAULT 0
		,[PedidoDetalleID] INT
		,PrecioUnidad  money  null
		,TipoOfertaSisID  int null
		)
END
GO

USE BelcorpMexico
GO

IF OBJECT_ID (N'PedidoWebSet', N'U') IS NULL 
BEGIN
	CREATE TABLE PedidoWebSet (
		SetID INT IDENTITY(1, 1) primary KEY
		,PedidoID INT
		,CuvSet VARCHAR(20)
		,EstrategiaId INT
		,NombreSet NVARCHAR(800)
		,Cantidad INT
		,PrecioUnidad MONEY
		,ImporteTotal MONEY
		,TipoEstrategiaId INT
		,Campania INT
		, ConsultoraID BIGINT
		,OrdenPedido INT
		,CodigoUsuarioCreacion VARCHAR(25)
		,CodigoUsuarioModificacion VARCHAR(25)
		,FechaCreacion DATETIME
		,FechaModificacion DATETIME
		)
END
GO

IF OBJECT_ID (N'PedidoWebSetDetalle', N'U') IS  NULL 
BEGIN
	CREATE TABLE PedidoWebSetDetalle (
		SetDetalleID INT IDENTITY(1, 1) primary KEY
		,[SetID] INT FOREIGN KEY (SetID) REFERENCES PedidoWebSet(SetID) ON DELETE CASCADE
		,[CuvProducto] NVARCHAR(20)
		,NombreProducto NVARCHAR(800)
		,[Cantidad] INT DEFAULT 1
		,[CantidadOriginal] INT DEFAULT 1
		,[FactorRepeticion] INT DEFAULT 0
		,[PedidoDetalleID] INT
		,PrecioUnidad  money  null
		,TipoOfertaSisID  int null
		)
END
GO

USE BelcorpPanama
GO

IF OBJECT_ID (N'PedidoWebSet', N'U') IS NULL 
BEGIN
	CREATE TABLE PedidoWebSet (
		SetID INT IDENTITY(1, 1) primary KEY
		,PedidoID INT
		,CuvSet VARCHAR(20)
		,EstrategiaId INT
		,NombreSet NVARCHAR(800)
		,Cantidad INT
		,PrecioUnidad MONEY
		,ImporteTotal MONEY
		,TipoEstrategiaId INT
		,Campania INT
		, ConsultoraID BIGINT
		,OrdenPedido INT
		,CodigoUsuarioCreacion VARCHAR(25)
		,CodigoUsuarioModificacion VARCHAR(25)
		,FechaCreacion DATETIME
		,FechaModificacion DATETIME
		)
END
GO

IF OBJECT_ID (N'PedidoWebSetDetalle', N'U') IS  NULL 
BEGIN
	CREATE TABLE PedidoWebSetDetalle (
		SetDetalleID INT IDENTITY(1, 1) primary KEY
		,[SetID] INT FOREIGN KEY (SetID) REFERENCES PedidoWebSet(SetID) ON DELETE CASCADE
		,[CuvProducto] NVARCHAR(20)
		,NombreProducto NVARCHAR(800)
		,[Cantidad] INT DEFAULT 1
		,[CantidadOriginal] INT DEFAULT 1
		,[FactorRepeticion] INT DEFAULT 0
		,[PedidoDetalleID] INT
		,PrecioUnidad  money  null
		,TipoOfertaSisID  int null
		)
END
GO

USE BelcorpPeru
GO

IF OBJECT_ID (N'PedidoWebSet', N'U') IS NULL 
BEGIN
	CREATE TABLE PedidoWebSet (
		SetID INT IDENTITY(1, 1) primary KEY
		,PedidoID INT
		,CuvSet VARCHAR(20)
		,EstrategiaId INT
		,NombreSet NVARCHAR(800)
		,Cantidad INT
		,PrecioUnidad MONEY
		,ImporteTotal MONEY
		,TipoEstrategiaId INT
		,Campania INT
		, ConsultoraID BIGINT
		,OrdenPedido INT
		,CodigoUsuarioCreacion VARCHAR(25)
		,CodigoUsuarioModificacion VARCHAR(25)
		,FechaCreacion DATETIME
		,FechaModificacion DATETIME
		)
END
GO

IF OBJECT_ID (N'PedidoWebSetDetalle', N'U') IS  NULL 
BEGIN
	CREATE TABLE PedidoWebSetDetalle (
		SetDetalleID INT IDENTITY(1, 1) primary KEY
		,[SetID] INT FOREIGN KEY (SetID) REFERENCES PedidoWebSet(SetID) ON DELETE CASCADE
		,[CuvProducto] NVARCHAR(20)
		,NombreProducto NVARCHAR(800)
		,[Cantidad] INT DEFAULT 1
		,[CantidadOriginal] INT DEFAULT 1
		,[FactorRepeticion] INT DEFAULT 0
		,[PedidoDetalleID] INT
		,PrecioUnidad  money  null
		,TipoOfertaSisID  int null
		)
END
GO

USE BelcorpPuertoRico
GO

IF OBJECT_ID (N'PedidoWebSet', N'U') IS NULL 
BEGIN
	CREATE TABLE PedidoWebSet (
		SetID INT IDENTITY(1, 1) primary KEY
		,PedidoID INT
		,CuvSet VARCHAR(20)
		,EstrategiaId INT
		,NombreSet NVARCHAR(800)
		,Cantidad INT
		,PrecioUnidad MONEY
		,ImporteTotal MONEY
		,TipoEstrategiaId INT
		,Campania INT
		, ConsultoraID BIGINT
		,OrdenPedido INT
		,CodigoUsuarioCreacion VARCHAR(25)
		,CodigoUsuarioModificacion VARCHAR(25)
		,FechaCreacion DATETIME
		,FechaModificacion DATETIME
		)
END
GO

IF OBJECT_ID (N'PedidoWebSetDetalle', N'U') IS  NULL 
BEGIN
	CREATE TABLE PedidoWebSetDetalle (
		SetDetalleID INT IDENTITY(1, 1) primary KEY
		,[SetID] INT FOREIGN KEY (SetID) REFERENCES PedidoWebSet(SetID) ON DELETE CASCADE
		,[CuvProducto] NVARCHAR(20)
		,NombreProducto NVARCHAR(800)
		,[Cantidad] INT DEFAULT 1
		,[CantidadOriginal] INT DEFAULT 1
		,[FactorRepeticion] INT DEFAULT 0
		,[PedidoDetalleID] INT
		,PrecioUnidad  money  null
		,TipoOfertaSisID  int null
		)
END
GO

USE BelcorpSalvador
GO

IF OBJECT_ID (N'PedidoWebSet', N'U') IS NULL 
BEGIN
	CREATE TABLE PedidoWebSet (
		SetID INT IDENTITY(1, 1) primary KEY
		,PedidoID INT
		,CuvSet VARCHAR(20)
		,EstrategiaId INT
		,NombreSet NVARCHAR(800)
		,Cantidad INT
		,PrecioUnidad MONEY
		,ImporteTotal MONEY
		,TipoEstrategiaId INT
		,Campania INT
		, ConsultoraID BIGINT
		,OrdenPedido INT
		,CodigoUsuarioCreacion VARCHAR(25)
		,CodigoUsuarioModificacion VARCHAR(25)
		,FechaCreacion DATETIME
		,FechaModificacion DATETIME
		)
END
GO

IF OBJECT_ID (N'PedidoWebSetDetalle', N'U') IS  NULL 
BEGIN
	CREATE TABLE PedidoWebSetDetalle (
		SetDetalleID INT IDENTITY(1, 1) primary KEY
		,[SetID] INT FOREIGN KEY (SetID) REFERENCES PedidoWebSet(SetID) ON DELETE CASCADE
		,[CuvProducto] NVARCHAR(20)
		,NombreProducto NVARCHAR(800)
		,[Cantidad] INT DEFAULT 1
		,[CantidadOriginal] INT DEFAULT 1
		,[FactorRepeticion] INT DEFAULT 0
		,[PedidoDetalleID] INT
		,PrecioUnidad  money  null
		,TipoOfertaSisID  int null
		)
END
GO

