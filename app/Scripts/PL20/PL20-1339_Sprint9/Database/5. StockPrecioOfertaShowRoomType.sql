
USE BelcorpBolivia
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'ShowRoom.UpdStockOfertaShowRoomMasivo'))
BEGIN
    DROP PROCEDURE ShowRoom.UpdStockOfertaShowRoomMasivo
END
GO

IF TYPE_ID(N'ShowRoom.StockPrecioOfertaShowRoomType') IS NOT NULL
BEGIN
	DROP TYPE ShowRoom.StockPrecioOfertaShowRoomType
END
GO

CREATE TYPE [ShowRoom].[StockPrecioOfertaShowRoomType] AS TABLE(
	[TipoOfertaSisID] [int] NULL,
	[CampaniaID] [int] NULL,
	[CUV] [varchar](20) NULL,
	[Stock] [int] NULL,
	[PrecioOferta] [decimal](18, 2) NULL,
	[UnidadesPermitidas] [int] NULL,
	[Descripcion] [varchar](250) NULL,
	[CodigoCategoria] [varchar](100) NULL,
	[TipNegocio] [varchar](500) NULL,
	[PrecioOferta2] [decimal](18, 2) NULL
)
GO

CREATE PROCEDURE [ShowRoom].[UpdStockOfertaShowRoomMasivo]
@StockPrecioOfertaShowRoom ShowRoom.StockPrecioOfertaShowRoomType readonly
AS
BEGIN

UPDATE ShowRoom.OfertaShowRoom
SET Stock = t.Stock,
	StockInicial = t.Stock,
	PrecioOferta = t.PrecioOferta,
	UnidadesPermitidas = t.UnidadesPermitidas,
	Descripcion = t.Descripcion,
	CodigoCategoria = t.CodigoCategoria,
	TipNegocio = t.TipNegocio,
	PrecioOferta2 = t.PrecioOferta2
FROM ShowRoom.OfertaShowRoom o
INNER JOIN ods.Campania c ON 
	c.CampaniaID = o.CampaniaID
JOIN @StockPrecioOfertaShowRoom t ON 
	c.Codigo = t.CampaniaID
	AND o.CUV = t.CUV
	AND o.TipoOfertaSisID = t.TipoOfertaSisID
END
GO
/*end*/

USE BelcorpChile
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'ShowRoom.UpdStockOfertaShowRoomMasivo'))
BEGIN
    DROP PROCEDURE ShowRoom.UpdStockOfertaShowRoomMasivo
END
GO

IF TYPE_ID(N'ShowRoom.StockPrecioOfertaShowRoomType') IS NOT NULL
BEGIN
	DROP TYPE ShowRoom.StockPrecioOfertaShowRoomType
END
GO

CREATE TYPE [ShowRoom].[StockPrecioOfertaShowRoomType] AS TABLE(
	[TipoOfertaSisID] [int] NULL,
	[CampaniaID] [int] NULL,
	[CUV] [varchar](20) NULL,
	[Stock] [int] NULL,
	[PrecioOferta] [decimal](18, 2) NULL,
	[UnidadesPermitidas] [int] NULL,
	[Descripcion] [varchar](250) NULL,
	[CodigoCategoria] [varchar](100) NULL,
	[TipNegocio] [varchar](500) NULL,
	[PrecioOferta2] [decimal](18, 2) NULL
)
GO

CREATE PROCEDURE [ShowRoom].[UpdStockOfertaShowRoomMasivo]
@StockPrecioOfertaShowRoom ShowRoom.StockPrecioOfertaShowRoomType readonly
AS
BEGIN

UPDATE ShowRoom.OfertaShowRoom
SET Stock = t.Stock,
	StockInicial = t.Stock,
	PrecioOferta = t.PrecioOferta,
	UnidadesPermitidas = t.UnidadesPermitidas,
	Descripcion = t.Descripcion,
	CodigoCategoria = t.CodigoCategoria,
	TipNegocio = t.TipNegocio,
	PrecioOferta2 = t.PrecioOferta2
FROM ShowRoom.OfertaShowRoom o
INNER JOIN ods.Campania c ON 
	c.CampaniaID = o.CampaniaID
JOIN @StockPrecioOfertaShowRoom t ON 
	c.Codigo = t.CampaniaID
	AND o.CUV = t.CUV
	AND o.TipoOfertaSisID = t.TipoOfertaSisID
END
GO
/*end*/

USE BelcorpColombia
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'ShowRoom.UpdStockOfertaShowRoomMasivo'))
BEGIN
    DROP PROCEDURE ShowRoom.UpdStockOfertaShowRoomMasivo
END
GO

IF TYPE_ID(N'ShowRoom.StockPrecioOfertaShowRoomType') IS NOT NULL
BEGIN
	DROP TYPE ShowRoom.StockPrecioOfertaShowRoomType
END
GO

CREATE TYPE [ShowRoom].[StockPrecioOfertaShowRoomType] AS TABLE(
	[TipoOfertaSisID] [int] NULL,
	[CampaniaID] [int] NULL,
	[CUV] [varchar](20) NULL,
	[Stock] [int] NULL,
	[PrecioOferta] [decimal](18, 2) NULL,
	[UnidadesPermitidas] [int] NULL,
	[Descripcion] [varchar](250) NULL,
	[CodigoCategoria] [varchar](100) NULL,
	[TipNegocio] [varchar](500) NULL,
	[PrecioOferta2] [decimal](18, 2) NULL
)
GO

CREATE PROCEDURE [ShowRoom].[UpdStockOfertaShowRoomMasivo]
@StockPrecioOfertaShowRoom ShowRoom.StockPrecioOfertaShowRoomType readonly
AS
BEGIN

UPDATE ShowRoom.OfertaShowRoom
SET Stock = t.Stock,
	StockInicial = t.Stock,
	PrecioOferta = t.PrecioOferta,
	UnidadesPermitidas = t.UnidadesPermitidas,
	Descripcion = t.Descripcion,
	CodigoCategoria = t.CodigoCategoria,
	TipNegocio = t.TipNegocio,
	PrecioOferta2 = t.PrecioOferta2
FROM ShowRoom.OfertaShowRoom o
INNER JOIN ods.Campania c ON 
	c.CampaniaID = o.CampaniaID
JOIN @StockPrecioOfertaShowRoom t ON 
	c.Codigo = t.CampaniaID
	AND o.CUV = t.CUV
	AND o.TipoOfertaSisID = t.TipoOfertaSisID
END
GO
/*end*/

USE BelcorpCostaRica
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'ShowRoom.UpdStockOfertaShowRoomMasivo'))
BEGIN
    DROP PROCEDURE ShowRoom.UpdStockOfertaShowRoomMasivo
END
GO

IF TYPE_ID(N'ShowRoom.StockPrecioOfertaShowRoomType') IS NOT NULL
BEGIN
	DROP TYPE ShowRoom.StockPrecioOfertaShowRoomType
END
GO

CREATE TYPE [ShowRoom].[StockPrecioOfertaShowRoomType] AS TABLE(
	[TipoOfertaSisID] [int] NULL,
	[CampaniaID] [int] NULL,
	[CUV] [varchar](20) NULL,
	[Stock] [int] NULL,
	[PrecioOferta] [decimal](18, 2) NULL,
	[UnidadesPermitidas] [int] NULL,
	[Descripcion] [varchar](250) NULL,
	[CodigoCategoria] [varchar](100) NULL,
	[TipNegocio] [varchar](500) NULL,
	[PrecioOferta2] [decimal](18, 2) NULL
)
GO

CREATE PROCEDURE [ShowRoom].[UpdStockOfertaShowRoomMasivo]
@StockPrecioOfertaShowRoom ShowRoom.StockPrecioOfertaShowRoomType readonly
AS
BEGIN

UPDATE ShowRoom.OfertaShowRoom
SET Stock = t.Stock,
	StockInicial = t.Stock,
	PrecioOferta = t.PrecioOferta,
	UnidadesPermitidas = t.UnidadesPermitidas,
	Descripcion = t.Descripcion,
	CodigoCategoria = t.CodigoCategoria,
	TipNegocio = t.TipNegocio,
	PrecioOferta2 = t.PrecioOferta2
FROM ShowRoom.OfertaShowRoom o
INNER JOIN ods.Campania c ON 
	c.CampaniaID = o.CampaniaID
JOIN @StockPrecioOfertaShowRoom t ON 
	c.Codigo = t.CampaniaID
	AND o.CUV = t.CUV
	AND o.TipoOfertaSisID = t.TipoOfertaSisID
END
GO
/*end*/

USE BelcorpDominicana
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'ShowRoom.UpdStockOfertaShowRoomMasivo'))
BEGIN
    DROP PROCEDURE ShowRoom.UpdStockOfertaShowRoomMasivo
END
GO

IF TYPE_ID(N'ShowRoom.StockPrecioOfertaShowRoomType') IS NOT NULL
BEGIN
	DROP TYPE ShowRoom.StockPrecioOfertaShowRoomType
END
GO

CREATE TYPE [ShowRoom].[StockPrecioOfertaShowRoomType] AS TABLE(
	[TipoOfertaSisID] [int] NULL,
	[CampaniaID] [int] NULL,
	[CUV] [varchar](20) NULL,
	[Stock] [int] NULL,
	[PrecioOferta] [decimal](18, 2) NULL,
	[UnidadesPermitidas] [int] NULL,
	[Descripcion] [varchar](250) NULL,
	[CodigoCategoria] [varchar](100) NULL,
	[TipNegocio] [varchar](500) NULL,
	[PrecioOferta2] [decimal](18, 2) NULL
)
GO

CREATE PROCEDURE [ShowRoom].[UpdStockOfertaShowRoomMasivo]
@StockPrecioOfertaShowRoom ShowRoom.StockPrecioOfertaShowRoomType readonly
AS
BEGIN

UPDATE ShowRoom.OfertaShowRoom
SET Stock = t.Stock,
	StockInicial = t.Stock,
	PrecioOferta = t.PrecioOferta,
	UnidadesPermitidas = t.UnidadesPermitidas,
	Descripcion = t.Descripcion,
	CodigoCategoria = t.CodigoCategoria,
	TipNegocio = t.TipNegocio,
	PrecioOferta2 = t.PrecioOferta2
FROM ShowRoom.OfertaShowRoom o
INNER JOIN ods.Campania c ON 
	c.CampaniaID = o.CampaniaID
JOIN @StockPrecioOfertaShowRoom t ON 
	c.Codigo = t.CampaniaID
	AND o.CUV = t.CUV
	AND o.TipoOfertaSisID = t.TipoOfertaSisID
END
GO
/*end*/

USE BelcorpEcuador
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'ShowRoom.UpdStockOfertaShowRoomMasivo'))
BEGIN
    DROP PROCEDURE ShowRoom.UpdStockOfertaShowRoomMasivo
END
GO

IF TYPE_ID(N'ShowRoom.StockPrecioOfertaShowRoomType') IS NOT NULL
BEGIN
	DROP TYPE ShowRoom.StockPrecioOfertaShowRoomType
END
GO

CREATE TYPE [ShowRoom].[StockPrecioOfertaShowRoomType] AS TABLE(
	[TipoOfertaSisID] [int] NULL,
	[CampaniaID] [int] NULL,
	[CUV] [varchar](20) NULL,
	[Stock] [int] NULL,
	[PrecioOferta] [decimal](18, 2) NULL,
	[UnidadesPermitidas] [int] NULL,
	[Descripcion] [varchar](250) NULL,
	[CodigoCategoria] [varchar](100) NULL,
	[TipNegocio] [varchar](500) NULL,
	[PrecioOferta2] [decimal](18, 2) NULL
)
GO

CREATE PROCEDURE [ShowRoom].[UpdStockOfertaShowRoomMasivo]
@StockPrecioOfertaShowRoom ShowRoom.StockPrecioOfertaShowRoomType readonly
AS
BEGIN

UPDATE ShowRoom.OfertaShowRoom
SET Stock = t.Stock,
	StockInicial = t.Stock,
	PrecioOferta = t.PrecioOferta,
	UnidadesPermitidas = t.UnidadesPermitidas,
	Descripcion = t.Descripcion,
	CodigoCategoria = t.CodigoCategoria,
	TipNegocio = t.TipNegocio,
	PrecioOferta2 = t.PrecioOferta2
FROM ShowRoom.OfertaShowRoom o
INNER JOIN ods.Campania c ON 
	c.CampaniaID = o.CampaniaID
JOIN @StockPrecioOfertaShowRoom t ON 
	c.Codigo = t.CampaniaID
	AND o.CUV = t.CUV
	AND o.TipoOfertaSisID = t.TipoOfertaSisID
END
GO
/*end*/

USE BelcorpGuatemala
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'ShowRoom.UpdStockOfertaShowRoomMasivo'))
BEGIN
    DROP PROCEDURE ShowRoom.UpdStockOfertaShowRoomMasivo
END
GO

IF TYPE_ID(N'ShowRoom.StockPrecioOfertaShowRoomType') IS NOT NULL
BEGIN
	DROP TYPE ShowRoom.StockPrecioOfertaShowRoomType
END
GO

CREATE TYPE [ShowRoom].[StockPrecioOfertaShowRoomType] AS TABLE(
	[TipoOfertaSisID] [int] NULL,
	[CampaniaID] [int] NULL,
	[CUV] [varchar](20) NULL,
	[Stock] [int] NULL,
	[PrecioOferta] [decimal](18, 2) NULL,
	[UnidadesPermitidas] [int] NULL,
	[Descripcion] [varchar](250) NULL,
	[CodigoCategoria] [varchar](100) NULL,
	[TipNegocio] [varchar](500) NULL,
	[PrecioOferta2] [decimal](18, 2) NULL
)
GO

CREATE PROCEDURE [ShowRoom].[UpdStockOfertaShowRoomMasivo]
@StockPrecioOfertaShowRoom ShowRoom.StockPrecioOfertaShowRoomType readonly
AS
BEGIN

UPDATE ShowRoom.OfertaShowRoom
SET Stock = t.Stock,
	StockInicial = t.Stock,
	PrecioOferta = t.PrecioOferta,
	UnidadesPermitidas = t.UnidadesPermitidas,
	Descripcion = t.Descripcion,
	CodigoCategoria = t.CodigoCategoria,
	TipNegocio = t.TipNegocio,
	PrecioOferta2 = t.PrecioOferta2
FROM ShowRoom.OfertaShowRoom o
INNER JOIN ods.Campania c ON 
	c.CampaniaID = o.CampaniaID
JOIN @StockPrecioOfertaShowRoom t ON 
	c.Codigo = t.CampaniaID
	AND o.CUV = t.CUV
	AND o.TipoOfertaSisID = t.TipoOfertaSisID
END
GO
/*end*/

USE BelcorpMexico
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'ShowRoom.UpdStockOfertaShowRoomMasivo'))
BEGIN
    DROP PROCEDURE ShowRoom.UpdStockOfertaShowRoomMasivo
END
GO

IF TYPE_ID(N'ShowRoom.StockPrecioOfertaShowRoomType') IS NOT NULL
BEGIN
	DROP TYPE ShowRoom.StockPrecioOfertaShowRoomType
END
GO

CREATE TYPE [ShowRoom].[StockPrecioOfertaShowRoomType] AS TABLE(
	[TipoOfertaSisID] [int] NULL,
	[CampaniaID] [int] NULL,
	[CUV] [varchar](20) NULL,
	[Stock] [int] NULL,
	[PrecioOferta] [decimal](18, 2) NULL,
	[UnidadesPermitidas] [int] NULL,
	[Descripcion] [varchar](250) NULL,
	[CodigoCategoria] [varchar](100) NULL,
	[TipNegocio] [varchar](500) NULL,
	[PrecioOferta2] [decimal](18, 2) NULL
)
GO

CREATE PROCEDURE [ShowRoom].[UpdStockOfertaShowRoomMasivo]
@StockPrecioOfertaShowRoom ShowRoom.StockPrecioOfertaShowRoomType readonly
AS
BEGIN

UPDATE ShowRoom.OfertaShowRoom
SET Stock = t.Stock,
	StockInicial = t.Stock,
	PrecioOferta = t.PrecioOferta,
	UnidadesPermitidas = t.UnidadesPermitidas,
	Descripcion = t.Descripcion,
	CodigoCategoria = t.CodigoCategoria,
	TipNegocio = t.TipNegocio,
	PrecioOferta2 = t.PrecioOferta2
FROM ShowRoom.OfertaShowRoom o
INNER JOIN ods.Campania c ON 
	c.CampaniaID = o.CampaniaID
JOIN @StockPrecioOfertaShowRoom t ON 
	c.Codigo = t.CampaniaID
	AND o.CUV = t.CUV
	AND o.TipoOfertaSisID = t.TipoOfertaSisID
END
GO
/*end*/

USE BelcorpPanama
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'ShowRoom.UpdStockOfertaShowRoomMasivo'))
BEGIN
    DROP PROCEDURE ShowRoom.UpdStockOfertaShowRoomMasivo
END
GO

IF TYPE_ID(N'ShowRoom.StockPrecioOfertaShowRoomType') IS NOT NULL
BEGIN
	DROP TYPE ShowRoom.StockPrecioOfertaShowRoomType
END
GO

CREATE TYPE [ShowRoom].[StockPrecioOfertaShowRoomType] AS TABLE(
	[TipoOfertaSisID] [int] NULL,
	[CampaniaID] [int] NULL,
	[CUV] [varchar](20) NULL,
	[Stock] [int] NULL,
	[PrecioOferta] [decimal](18, 2) NULL,
	[UnidadesPermitidas] [int] NULL,
	[Descripcion] [varchar](250) NULL,
	[CodigoCategoria] [varchar](100) NULL,
	[TipNegocio] [varchar](500) NULL,
	[PrecioOferta2] [decimal](18, 2) NULL
)
GO

CREATE PROCEDURE [ShowRoom].[UpdStockOfertaShowRoomMasivo]
@StockPrecioOfertaShowRoom ShowRoom.StockPrecioOfertaShowRoomType readonly
AS
BEGIN

UPDATE ShowRoom.OfertaShowRoom
SET Stock = t.Stock,
	StockInicial = t.Stock,
	PrecioOferta = t.PrecioOferta,
	UnidadesPermitidas = t.UnidadesPermitidas,
	Descripcion = t.Descripcion,
	CodigoCategoria = t.CodigoCategoria,
	TipNegocio = t.TipNegocio,
	PrecioOferta2 = t.PrecioOferta2
FROM ShowRoom.OfertaShowRoom o
INNER JOIN ods.Campania c ON 
	c.CampaniaID = o.CampaniaID
JOIN @StockPrecioOfertaShowRoom t ON 
	c.Codigo = t.CampaniaID
	AND o.CUV = t.CUV
	AND o.TipoOfertaSisID = t.TipoOfertaSisID
END
GO
/*end*/

USE BelcorpPeru
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'ShowRoom.UpdStockOfertaShowRoomMasivo'))
BEGIN
    DROP PROCEDURE ShowRoom.UpdStockOfertaShowRoomMasivo
END
GO

IF TYPE_ID(N'ShowRoom.StockPrecioOfertaShowRoomType') IS NOT NULL
BEGIN
	DROP TYPE ShowRoom.StockPrecioOfertaShowRoomType
END
GO

CREATE TYPE [ShowRoom].[StockPrecioOfertaShowRoomType] AS TABLE(
	[TipoOfertaSisID] [int] NULL,
	[CampaniaID] [int] NULL,
	[CUV] [varchar](20) NULL,
	[Stock] [int] NULL,
	[PrecioOferta] [decimal](18, 2) NULL,
	[UnidadesPermitidas] [int] NULL,
	[Descripcion] [varchar](250) NULL,
	[CodigoCategoria] [varchar](100) NULL,
	[TipNegocio] [varchar](500) NULL,
	[PrecioOferta2] [decimal](18, 2) NULL
)
GO

CREATE PROCEDURE [ShowRoom].[UpdStockOfertaShowRoomMasivo]
@StockPrecioOfertaShowRoom ShowRoom.StockPrecioOfertaShowRoomType readonly
AS
BEGIN

UPDATE ShowRoom.OfertaShowRoom
SET Stock = t.Stock,
	StockInicial = t.Stock,
	PrecioOferta = t.PrecioOferta,
	UnidadesPermitidas = t.UnidadesPermitidas,
	Descripcion = t.Descripcion,
	CodigoCategoria = t.CodigoCategoria,
	TipNegocio = t.TipNegocio,
	PrecioOferta2 = t.PrecioOferta2
FROM ShowRoom.OfertaShowRoom o
INNER JOIN ods.Campania c ON 
	c.CampaniaID = o.CampaniaID
JOIN @StockPrecioOfertaShowRoom t ON 
	c.Codigo = t.CampaniaID
	AND o.CUV = t.CUV
	AND o.TipoOfertaSisID = t.TipoOfertaSisID
END
GO
/*end*/

USE BelcorpPuertoRico
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'ShowRoom.UpdStockOfertaShowRoomMasivo'))
BEGIN
    DROP PROCEDURE ShowRoom.UpdStockOfertaShowRoomMasivo
END
GO

IF TYPE_ID(N'ShowRoom.StockPrecioOfertaShowRoomType') IS NOT NULL
BEGIN
	DROP TYPE ShowRoom.StockPrecioOfertaShowRoomType
END
GO

CREATE TYPE [ShowRoom].[StockPrecioOfertaShowRoomType] AS TABLE(
	[TipoOfertaSisID] [int] NULL,
	[CampaniaID] [int] NULL,
	[CUV] [varchar](20) NULL,
	[Stock] [int] NULL,
	[PrecioOferta] [decimal](18, 2) NULL,
	[UnidadesPermitidas] [int] NULL,
	[Descripcion] [varchar](250) NULL,
	[CodigoCategoria] [varchar](100) NULL,
	[TipNegocio] [varchar](500) NULL,
	[PrecioOferta2] [decimal](18, 2) NULL
)
GO

CREATE PROCEDURE [ShowRoom].[UpdStockOfertaShowRoomMasivo]
@StockPrecioOfertaShowRoom ShowRoom.StockPrecioOfertaShowRoomType readonly
AS
BEGIN

UPDATE ShowRoom.OfertaShowRoom
SET Stock = t.Stock,
	StockInicial = t.Stock,
	PrecioOferta = t.PrecioOferta,
	UnidadesPermitidas = t.UnidadesPermitidas,
	Descripcion = t.Descripcion,
	CodigoCategoria = t.CodigoCategoria,
	TipNegocio = t.TipNegocio,
	PrecioOferta2 = t.PrecioOferta2
FROM ShowRoom.OfertaShowRoom o
INNER JOIN ods.Campania c ON 
	c.CampaniaID = o.CampaniaID
JOIN @StockPrecioOfertaShowRoom t ON 
	c.Codigo = t.CampaniaID
	AND o.CUV = t.CUV
	AND o.TipoOfertaSisID = t.TipoOfertaSisID
END
GO
/*end*/

USE BelcorpSalvador
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'ShowRoom.UpdStockOfertaShowRoomMasivo'))
BEGIN
    DROP PROCEDURE ShowRoom.UpdStockOfertaShowRoomMasivo
END
GO

IF TYPE_ID(N'ShowRoom.StockPrecioOfertaShowRoomType') IS NOT NULL
BEGIN
	DROP TYPE ShowRoom.StockPrecioOfertaShowRoomType
END
GO

CREATE TYPE [ShowRoom].[StockPrecioOfertaShowRoomType] AS TABLE(
	[TipoOfertaSisID] [int] NULL,
	[CampaniaID] [int] NULL,
	[CUV] [varchar](20) NULL,
	[Stock] [int] NULL,
	[PrecioOferta] [decimal](18, 2) NULL,
	[UnidadesPermitidas] [int] NULL,
	[Descripcion] [varchar](250) NULL,
	[CodigoCategoria] [varchar](100) NULL,
	[TipNegocio] [varchar](500) NULL,
	[PrecioOferta2] [decimal](18, 2) NULL
)
GO

CREATE PROCEDURE [ShowRoom].[UpdStockOfertaShowRoomMasivo]
@StockPrecioOfertaShowRoom ShowRoom.StockPrecioOfertaShowRoomType readonly
AS
BEGIN

UPDATE ShowRoom.OfertaShowRoom
SET Stock = t.Stock,
	StockInicial = t.Stock,
	PrecioOferta = t.PrecioOferta,
	UnidadesPermitidas = t.UnidadesPermitidas,
	Descripcion = t.Descripcion,
	CodigoCategoria = t.CodigoCategoria,
	TipNegocio = t.TipNegocio,
	PrecioOferta2 = t.PrecioOferta2
FROM ShowRoom.OfertaShowRoom o
INNER JOIN ods.Campania c ON 
	c.CampaniaID = o.CampaniaID
JOIN @StockPrecioOfertaShowRoom t ON 
	c.Codigo = t.CampaniaID
	AND o.CUV = t.CUV
	AND o.TipoOfertaSisID = t.TipoOfertaSisID
END
GO
/*end*/

USE BelcorpVenezuela
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'ShowRoom.UpdStockOfertaShowRoomMasivo'))
BEGIN
    DROP PROCEDURE ShowRoom.UpdStockOfertaShowRoomMasivo
END
GO

IF TYPE_ID(N'ShowRoom.StockPrecioOfertaShowRoomType') IS NOT NULL
BEGIN
	DROP TYPE ShowRoom.StockPrecioOfertaShowRoomType
END
GO

CREATE TYPE [ShowRoom].[StockPrecioOfertaShowRoomType] AS TABLE(
	[TipoOfertaSisID] [int] NULL,
	[CampaniaID] [int] NULL,
	[CUV] [varchar](20) NULL,
	[Stock] [int] NULL,
	[PrecioOferta] [decimal](18, 2) NULL,
	[UnidadesPermitidas] [int] NULL,
	[Descripcion] [varchar](250) NULL,
	[CodigoCategoria] [varchar](100) NULL,
	[TipNegocio] [varchar](500) NULL,
	[PrecioOferta2] [decimal](18, 2) NULL
)
GO

CREATE PROCEDURE [ShowRoom].[UpdStockOfertaShowRoomMasivo]
@StockPrecioOfertaShowRoom ShowRoom.StockPrecioOfertaShowRoomType readonly
AS
BEGIN

UPDATE ShowRoom.OfertaShowRoom
SET Stock = t.Stock,
	StockInicial = t.Stock,
	PrecioOferta = t.PrecioOferta,
	UnidadesPermitidas = t.UnidadesPermitidas,
	Descripcion = t.Descripcion,
	CodigoCategoria = t.CodigoCategoria,
	TipNegocio = t.TipNegocio,
	PrecioOferta2 = t.PrecioOferta2
FROM ShowRoom.OfertaShowRoom o
INNER JOIN ods.Campania c ON 
	c.CampaniaID = o.CampaniaID
JOIN @StockPrecioOfertaShowRoom t ON 
	c.Codigo = t.CampaniaID
	AND o.CUV = t.CUV
	AND o.TipoOfertaSisID = t.TipoOfertaSisID
END
GO
