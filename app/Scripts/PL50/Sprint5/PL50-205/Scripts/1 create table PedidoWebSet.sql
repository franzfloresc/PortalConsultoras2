
use belcorpBolivia
go

IF OBJECT_ID (N'PedidoWebSet', N'U') IS NULL 
begin
	CREATE TABLE PedidoWebSet (
		SetID INT IDENTITY(1, 1) primary KEY
		,PedidoID INT
		,CuvSet VARCHAR(20)
		,EstrategiaId INT
		,NombreSet NVARCHAR(800)
		,Cantidad INT
		,PrecioUnidad MONEY
		,ImporteTotal MONEY
		,           TipoEstrategiaId INT
		,           Campania INT
		,           ConsultoraID BIGINT
		,           OrdenPedido INT
		,           CodigoUsuarioCreacion VARCHAR(25)
		,           CodigoUsuarioModificacion VARCHAR(25)
		,           FechaCreacion DATETIME
		,           FechaModificacion DATETIME
		)
end

GO


IF OBJECT_ID (N'PedidoWebSetDetalle', N'U') IS  NULL 
begin
	CREATE TABLE PedidoWebSetDetalle (
		SetDetalleID INT IDENTITY(1, 1)   primary KEY
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
end
go

use belcorpChile
go

IF OBJECT_ID (N'PedidoWebSet', N'U') IS NULL 
begin
	CREATE TABLE PedidoWebSet (
		SetID INT IDENTITY(1, 1) primary KEY
		,PedidoID INT
		,CuvSet VARCHAR(20)
		,EstrategiaId INT
		,NombreSet NVARCHAR(800)
		,Cantidad INT
		,PrecioUnidad MONEY
		,ImporteTotal MONEY
		,           TipoEstrategiaId INT
		,           Campania INT
		,           ConsultoraID BIGINT
		,           OrdenPedido INT
		,           CodigoUsuarioCreacion VARCHAR(25)
		,           CodigoUsuarioModificacion VARCHAR(25)
		,           FechaCreacion DATETIME
		,           FechaModificacion DATETIME
		)
end

GO


IF OBJECT_ID (N'PedidoWebSetDetalle', N'U') IS  NULL 
begin
	CREATE TABLE PedidoWebSetDetalle (
		SetDetalleID INT IDENTITY(1, 1)   primary KEY
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
end
go

use belcorpColombia
go

IF OBJECT_ID (N'PedidoWebSet', N'U') IS NULL 
begin
	CREATE TABLE PedidoWebSet (
		SetID INT IDENTITY(1, 1) primary KEY
		,PedidoID INT
		,CuvSet VARCHAR(20)
		,EstrategiaId INT
		,NombreSet NVARCHAR(800)
		,Cantidad INT
		,PrecioUnidad MONEY
		,ImporteTotal MONEY
		,           TipoEstrategiaId INT
		,           Campania INT
		,           ConsultoraID BIGINT
		,           OrdenPedido INT
		,           CodigoUsuarioCreacion VARCHAR(25)
		,           CodigoUsuarioModificacion VARCHAR(25)
		,           FechaCreacion DATETIME
		,           FechaModificacion DATETIME
		)
end

GO


IF OBJECT_ID (N'PedidoWebSetDetalle', N'U') IS  NULL 
begin
	CREATE TABLE PedidoWebSetDetalle (
		SetDetalleID INT IDENTITY(1, 1)   primary KEY
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
end
go

use belcorpCostaRica
go

IF OBJECT_ID (N'PedidoWebSet', N'U') IS NULL 
begin
	CREATE TABLE PedidoWebSet (
		SetID INT IDENTITY(1, 1) primary KEY
		,PedidoID INT
		,CuvSet VARCHAR(20)
		,EstrategiaId INT
		,NombreSet NVARCHAR(800)
		,Cantidad INT
		,PrecioUnidad MONEY
		,ImporteTotal MONEY
		,           TipoEstrategiaId INT
		,           Campania INT
		,           ConsultoraID BIGINT
		,           OrdenPedido INT
		,           CodigoUsuarioCreacion VARCHAR(25)
		,           CodigoUsuarioModificacion VARCHAR(25)
		,           FechaCreacion DATETIME
		,           FechaModificacion DATETIME
		)
end

GO


IF OBJECT_ID (N'PedidoWebSetDetalle', N'U') IS  NULL 
begin
	CREATE TABLE PedidoWebSetDetalle (
		SetDetalleID INT IDENTITY(1, 1)   primary KEY
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
end
go

use belcorpDominicana
go

IF OBJECT_ID (N'PedidoWebSet', N'U') IS NULL 
begin
	CREATE TABLE PedidoWebSet (
		SetID INT IDENTITY(1, 1) primary KEY
		,PedidoID INT
		,CuvSet VARCHAR(20)
		,EstrategiaId INT
		,NombreSet NVARCHAR(800)
		,Cantidad INT
		,PrecioUnidad MONEY
		,ImporteTotal MONEY
		,           TipoEstrategiaId INT
		,           Campania INT
		,           ConsultoraID BIGINT
		,           OrdenPedido INT
		,           CodigoUsuarioCreacion VARCHAR(25)
		,           CodigoUsuarioModificacion VARCHAR(25)
		,           FechaCreacion DATETIME
		,           FechaModificacion DATETIME
		)
end

GO


IF OBJECT_ID (N'PedidoWebSetDetalle', N'U') IS  NULL 
begin
	CREATE TABLE PedidoWebSetDetalle (
		SetDetalleID INT IDENTITY(1, 1)   primary KEY
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
end
go

use belcorpEcuador
go

IF OBJECT_ID (N'PedidoWebSet', N'U') IS NULL 
begin
	CREATE TABLE PedidoWebSet (
		SetID INT IDENTITY(1, 1) primary KEY
		,PedidoID INT
		,CuvSet VARCHAR(20)
		,EstrategiaId INT
		,NombreSet NVARCHAR(800)
		,Cantidad INT
		,PrecioUnidad MONEY
		,ImporteTotal MONEY
		,           TipoEstrategiaId INT
		,           Campania INT
		,           ConsultoraID BIGINT
		,           OrdenPedido INT
		,           CodigoUsuarioCreacion VARCHAR(25)
		,           CodigoUsuarioModificacion VARCHAR(25)
		,           FechaCreacion DATETIME
		,           FechaModificacion DATETIME
		)
end

GO


IF OBJECT_ID (N'PedidoWebSetDetalle', N'U') IS  NULL 
begin
	CREATE TABLE PedidoWebSetDetalle (
		SetDetalleID INT IDENTITY(1, 1)   primary KEY
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
end
go

use belcorpGuatemala
go

IF OBJECT_ID (N'PedidoWebSet', N'U') IS NULL 
begin
	CREATE TABLE PedidoWebSet (
		SetID INT IDENTITY(1, 1) primary KEY
		,PedidoID INT
		,CuvSet VARCHAR(20)
		,EstrategiaId INT
		,NombreSet NVARCHAR(800)
		,Cantidad INT
		,PrecioUnidad MONEY
		,ImporteTotal MONEY
		,           TipoEstrategiaId INT
		,           Campania INT
		,           ConsultoraID BIGINT
		,           OrdenPedido INT
		,           CodigoUsuarioCreacion VARCHAR(25)
		,           CodigoUsuarioModificacion VARCHAR(25)
		,           FechaCreacion DATETIME
		,           FechaModificacion DATETIME
		)
end

GO


IF OBJECT_ID (N'PedidoWebSetDetalle', N'U') IS  NULL 
begin
	CREATE TABLE PedidoWebSetDetalle (
		SetDetalleID INT IDENTITY(1, 1)   primary KEY
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
end
go

use belcorpMexico
go

IF OBJECT_ID (N'PedidoWebSet', N'U') IS NULL 
begin
	CREATE TABLE PedidoWebSet (
		SetID INT IDENTITY(1, 1) primary KEY
		,PedidoID INT
		,CuvSet VARCHAR(20)
		,EstrategiaId INT
		,NombreSet NVARCHAR(800)
		,Cantidad INT
		,PrecioUnidad MONEY
		,ImporteTotal MONEY
		,           TipoEstrategiaId INT
		,           Campania INT
		,           ConsultoraID BIGINT
		,           OrdenPedido INT
		,           CodigoUsuarioCreacion VARCHAR(25)
		,           CodigoUsuarioModificacion VARCHAR(25)
		,           FechaCreacion DATETIME
		,           FechaModificacion DATETIME
		)
end

GO


IF OBJECT_ID (N'PedidoWebSetDetalle', N'U') IS  NULL 
begin
	CREATE TABLE PedidoWebSetDetalle (
		SetDetalleID INT IDENTITY(1, 1)   primary KEY
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
end
go

use belcorpPanama
go

IF OBJECT_ID (N'PedidoWebSet', N'U') IS NULL 
begin
	CREATE TABLE PedidoWebSet (
		SetID INT IDENTITY(1, 1) primary KEY
		,PedidoID INT
		,CuvSet VARCHAR(20)
		,EstrategiaId INT
		,NombreSet NVARCHAR(800)
		,Cantidad INT
		,PrecioUnidad MONEY
		,ImporteTotal MONEY
		,           TipoEstrategiaId INT
		,           Campania INT
		,           ConsultoraID BIGINT
		,           OrdenPedido INT
		,           CodigoUsuarioCreacion VARCHAR(25)
		,           CodigoUsuarioModificacion VARCHAR(25)
		,           FechaCreacion DATETIME
		,           FechaModificacion DATETIME
		)
end

GO


IF OBJECT_ID (N'PedidoWebSetDetalle', N'U') IS  NULL 
begin
	CREATE TABLE PedidoWebSetDetalle (
		SetDetalleID INT IDENTITY(1, 1)   primary KEY
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
end
go

use belcorpPeru
go

IF OBJECT_ID (N'PedidoWebSet', N'U') IS NULL 
begin
	CREATE TABLE PedidoWebSet (
		SetID INT IDENTITY(1, 1) primary KEY
		,PedidoID INT
		,CuvSet VARCHAR(20)
		,EstrategiaId INT
		,NombreSet NVARCHAR(800)
		,Cantidad INT
		,PrecioUnidad MONEY
		,ImporteTotal MONEY
		,           TipoEstrategiaId INT
		,           Campania INT
		,           ConsultoraID BIGINT
		,           OrdenPedido INT
		,           CodigoUsuarioCreacion VARCHAR(25)
		,           CodigoUsuarioModificacion VARCHAR(25)
		,           FechaCreacion DATETIME
		,           FechaModificacion DATETIME
		)
end

GO


IF OBJECT_ID (N'PedidoWebSetDetalle', N'U') IS  NULL 
begin
	CREATE TABLE PedidoWebSetDetalle (
		SetDetalleID INT IDENTITY(1, 1)   primary KEY
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
end
go

use belcorpPuertoRico
go

IF OBJECT_ID (N'PedidoWebSet', N'U') IS NULL 
begin
	CREATE TABLE PedidoWebSet (
		SetID INT IDENTITY(1, 1) primary KEY
		,PedidoID INT
		,CuvSet VARCHAR(20)
		,EstrategiaId INT
		,NombreSet NVARCHAR(800)
		,Cantidad INT
		,PrecioUnidad MONEY
		,ImporteTotal MONEY
		,           TipoEstrategiaId INT
		,           Campania INT
		,           ConsultoraID BIGINT
		,           OrdenPedido INT
		,           CodigoUsuarioCreacion VARCHAR(25)
		,           CodigoUsuarioModificacion VARCHAR(25)
		,           FechaCreacion DATETIME
		,           FechaModificacion DATETIME
		)
end

GO


IF OBJECT_ID (N'PedidoWebSetDetalle', N'U') IS  NULL 
begin
	CREATE TABLE PedidoWebSetDetalle (
		SetDetalleID INT IDENTITY(1, 1)   primary KEY
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
end
go

use belcorpSalvador
go

IF OBJECT_ID (N'PedidoWebSet', N'U') IS NULL 
begin
	CREATE TABLE PedidoWebSet (
		SetID INT IDENTITY(1, 1) primary KEY
		,PedidoID INT
		,CuvSet VARCHAR(20)
		,EstrategiaId INT
		,NombreSet NVARCHAR(800)
		,Cantidad INT
		,PrecioUnidad MONEY
		,ImporteTotal MONEY
		,           TipoEstrategiaId INT
		,           Campania INT
		,           ConsultoraID BIGINT
		,           OrdenPedido INT
		,           CodigoUsuarioCreacion VARCHAR(25)
		,           CodigoUsuarioModificacion VARCHAR(25)
		,           FechaCreacion DATETIME
		,           FechaModificacion DATETIME
		)
end

GO


IF OBJECT_ID (N'PedidoWebSetDetalle', N'U') IS  NULL 
begin
	CREATE TABLE PedidoWebSetDetalle (
		SetDetalleID INT IDENTITY(1, 1)   primary KEY
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
end
go
