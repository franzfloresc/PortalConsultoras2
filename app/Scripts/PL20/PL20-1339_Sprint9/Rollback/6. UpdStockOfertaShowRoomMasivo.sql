
USE BelcorpBolivia
GO

ALTER procedure [ShowRoom].[UpdStockOfertaShowRoomMasivo]
@StockPrecioOfertaShowRoom ShowRoom.StockPrecioOfertaShowRoomType readonly
as
begin

UPDATE ShowRoom.OfertaShowRoom
SET Stock = t.Stock,
	StockInicial = t.Stock,
	PrecioOferta = t.PrecioOferta,
	UnidadesPermitidas = t.UnidadesPermitidas,
	Descripcion = t.Descripcion,
	CodigoCategoria = t.CodigoCategoria,
	TipNegocio = t.TipNegocio
FROM ShowRoom.OfertaShowRoom o
INNER JOIN ods.Campania c on 
	c.CampaniaID = o.CampaniaID
JOIN @StockPrecioOfertaShowRoom t ON 
	c.Codigo = t.CampaniaID
	AND o.CUV = t.CUV
	AND o.TipoOfertaSisID = t.TipoOfertaSisID

end
GO
/*end*/

USE BelcorpChile
GO

ALTER procedure [ShowRoom].[UpdStockOfertaShowRoomMasivo]
@StockPrecioOfertaShowRoom ShowRoom.StockPrecioOfertaShowRoomType readonly
as
begin

UPDATE ShowRoom.OfertaShowRoom
SET Stock = t.Stock,
	StockInicial = t.Stock,
	PrecioOferta = t.PrecioOferta,
	UnidadesPermitidas = t.UnidadesPermitidas,
	Descripcion = t.Descripcion,
	CodigoCategoria = t.CodigoCategoria,
	TipNegocio = t.TipNegocio
FROM ShowRoom.OfertaShowRoom o
INNER JOIN ods.Campania c on 
	c.CampaniaID = o.CampaniaID
JOIN @StockPrecioOfertaShowRoom t ON 
	c.Codigo = t.CampaniaID
	AND o.CUV = t.CUV
	AND o.TipoOfertaSisID = t.TipoOfertaSisID

end
GO
/*end*/

USE BelcorpColombia
GO

ALTER procedure [ShowRoom].[UpdStockOfertaShowRoomMasivo]
@StockPrecioOfertaShowRoom ShowRoom.StockPrecioOfertaShowRoomType readonly
as
begin

UPDATE ShowRoom.OfertaShowRoom
SET Stock = t.Stock,
	StockInicial = t.Stock,
	PrecioOferta = t.PrecioOferta,
	UnidadesPermitidas = t.UnidadesPermitidas,
	Descripcion = t.Descripcion,
	CodigoCategoria = t.CodigoCategoria,
	TipNegocio = t.TipNegocio
FROM ShowRoom.OfertaShowRoom o
INNER JOIN ods.Campania c on 
	c.CampaniaID = o.CampaniaID
JOIN @StockPrecioOfertaShowRoom t ON 
	c.Codigo = t.CampaniaID
	AND o.CUV = t.CUV
	AND o.TipoOfertaSisID = t.TipoOfertaSisID

end
GO
/*end*/

USE BelcorpCostaRica
GO

ALTER procedure [ShowRoom].[UpdStockOfertaShowRoomMasivo]
@StockPrecioOfertaShowRoom ShowRoom.StockPrecioOfertaShowRoomType readonly
as
begin

UPDATE ShowRoom.OfertaShowRoom
SET Stock = t.Stock,
	StockInicial = t.Stock,
	PrecioOferta = t.PrecioOferta,
	UnidadesPermitidas = t.UnidadesPermitidas,
	Descripcion = t.Descripcion,
	CodigoCategoria = t.CodigoCategoria,
	TipNegocio = t.TipNegocio
FROM ShowRoom.OfertaShowRoom o
INNER JOIN ods.Campania c on 
	c.CampaniaID = o.CampaniaID
JOIN @StockPrecioOfertaShowRoom t ON 
	c.Codigo = t.CampaniaID
	AND o.CUV = t.CUV
	AND o.TipoOfertaSisID = t.TipoOfertaSisID

end
GO
/*end*/

USE BelcorpDominicana
GO

ALTER procedure [ShowRoom].[UpdStockOfertaShowRoomMasivo]
@StockPrecioOfertaShowRoom ShowRoom.StockPrecioOfertaShowRoomType readonly
as
begin

UPDATE ShowRoom.OfertaShowRoom
SET Stock = t.Stock,
	StockInicial = t.Stock,
	PrecioOferta = t.PrecioOferta,
	UnidadesPermitidas = t.UnidadesPermitidas,
	Descripcion = t.Descripcion,
	CodigoCategoria = t.CodigoCategoria,
	TipNegocio = t.TipNegocio
FROM ShowRoom.OfertaShowRoom o
INNER JOIN ods.Campania c on 
	c.CampaniaID = o.CampaniaID
JOIN @StockPrecioOfertaShowRoom t ON 
	c.Codigo = t.CampaniaID
	AND o.CUV = t.CUV
	AND o.TipoOfertaSisID = t.TipoOfertaSisID

end
GO
/*end*/

USE BelcorpEcuador
GO

ALTER procedure [ShowRoom].[UpdStockOfertaShowRoomMasivo]
@StockPrecioOfertaShowRoom ShowRoom.StockPrecioOfertaShowRoomType readonly
as
begin

UPDATE ShowRoom.OfertaShowRoom
SET Stock = t.Stock,
	StockInicial = t.Stock,
	PrecioOferta = t.PrecioOferta,
	UnidadesPermitidas = t.UnidadesPermitidas,
	Descripcion = t.Descripcion,
	CodigoCategoria = t.CodigoCategoria,
	TipNegocio = t.TipNegocio
FROM ShowRoom.OfertaShowRoom o
INNER JOIN ods.Campania c on 
	c.CampaniaID = o.CampaniaID
JOIN @StockPrecioOfertaShowRoom t ON 
	c.Codigo = t.CampaniaID
	AND o.CUV = t.CUV
	AND o.TipoOfertaSisID = t.TipoOfertaSisID

end
GO
/*end*/

USE BelcorpGuatemala
GO

ALTER procedure [ShowRoom].[UpdStockOfertaShowRoomMasivo]
@StockPrecioOfertaShowRoom ShowRoom.StockPrecioOfertaShowRoomType readonly
as
begin

UPDATE ShowRoom.OfertaShowRoom
SET Stock = t.Stock,
	StockInicial = t.Stock,
	PrecioOferta = t.PrecioOferta,
	UnidadesPermitidas = t.UnidadesPermitidas,
	Descripcion = t.Descripcion,
	CodigoCategoria = t.CodigoCategoria,
	TipNegocio = t.TipNegocio
FROM ShowRoom.OfertaShowRoom o
INNER JOIN ods.Campania c on 
	c.CampaniaID = o.CampaniaID
JOIN @StockPrecioOfertaShowRoom t ON 
	c.Codigo = t.CampaniaID
	AND o.CUV = t.CUV
	AND o.TipoOfertaSisID = t.TipoOfertaSisID

end
GO
/*end*/

USE BelcorpMexico
GO

ALTER procedure [ShowRoom].[UpdStockOfertaShowRoomMasivo]
@StockPrecioOfertaShowRoom ShowRoom.StockPrecioOfertaShowRoomType readonly
as
begin

UPDATE ShowRoom.OfertaShowRoom
SET Stock = t.Stock,
	StockInicial = t.Stock,
	PrecioOferta = t.PrecioOferta,
	UnidadesPermitidas = t.UnidadesPermitidas,
	Descripcion = t.Descripcion,
	CodigoCategoria = t.CodigoCategoria,
	TipNegocio = t.TipNegocio
FROM ShowRoom.OfertaShowRoom o
INNER JOIN ods.Campania c on 
	c.CampaniaID = o.CampaniaID
JOIN @StockPrecioOfertaShowRoom t ON 
	c.Codigo = t.CampaniaID
	AND o.CUV = t.CUV
	AND o.TipoOfertaSisID = t.TipoOfertaSisID

end
GO
/*end*/

USE BelcorpPanama
GO

ALTER procedure [ShowRoom].[UpdStockOfertaShowRoomMasivo]
@StockPrecioOfertaShowRoom ShowRoom.StockPrecioOfertaShowRoomType readonly
as
begin

UPDATE ShowRoom.OfertaShowRoom
SET Stock = t.Stock,
	StockInicial = t.Stock,
	PrecioOferta = t.PrecioOferta,
	UnidadesPermitidas = t.UnidadesPermitidas,
	Descripcion = t.Descripcion,
	CodigoCategoria = t.CodigoCategoria,
	TipNegocio = t.TipNegocio
FROM ShowRoom.OfertaShowRoom o
INNER JOIN ods.Campania c on 
	c.CampaniaID = o.CampaniaID
JOIN @StockPrecioOfertaShowRoom t ON 
	c.Codigo = t.CampaniaID
	AND o.CUV = t.CUV
	AND o.TipoOfertaSisID = t.TipoOfertaSisID

end
GO
/*end*/

USE BelcorpPeru
GO

ALTER procedure [ShowRoom].[UpdStockOfertaShowRoomMasivo]
@StockPrecioOfertaShowRoom ShowRoom.StockPrecioOfertaShowRoomType readonly
as
begin

UPDATE ShowRoom.OfertaShowRoom
SET Stock = t.Stock,
	StockInicial = t.Stock,
	PrecioOferta = t.PrecioOferta,
	UnidadesPermitidas = t.UnidadesPermitidas,
	Descripcion = t.Descripcion,
	CodigoCategoria = t.CodigoCategoria,
	TipNegocio = t.TipNegocio
FROM ShowRoom.OfertaShowRoom o
INNER JOIN ods.Campania c on 
	c.CampaniaID = o.CampaniaID
JOIN @StockPrecioOfertaShowRoom t ON 
	c.Codigo = t.CampaniaID
	AND o.CUV = t.CUV
	AND o.TipoOfertaSisID = t.TipoOfertaSisID

end
GO
/*end*/

USE BelcorpPuertoRico
GO

ALTER procedure [ShowRoom].[UpdStockOfertaShowRoomMasivo]
@StockPrecioOfertaShowRoom ShowRoom.StockPrecioOfertaShowRoomType readonly
as
begin

UPDATE ShowRoom.OfertaShowRoom
SET Stock = t.Stock,
	StockInicial = t.Stock,
	PrecioOferta = t.PrecioOferta,
	UnidadesPermitidas = t.UnidadesPermitidas,
	Descripcion = t.Descripcion,
	CodigoCategoria = t.CodigoCategoria,
	TipNegocio = t.TipNegocio
FROM ShowRoom.OfertaShowRoom o
INNER JOIN ods.Campania c on 
	c.CampaniaID = o.CampaniaID
JOIN @StockPrecioOfertaShowRoom t ON 
	c.Codigo = t.CampaniaID
	AND o.CUV = t.CUV
	AND o.TipoOfertaSisID = t.TipoOfertaSisID

end
GO
/*end*/

USE BelcorpSalvador
GO

ALTER procedure [ShowRoom].[UpdStockOfertaShowRoomMasivo]
@StockPrecioOfertaShowRoom ShowRoom.StockPrecioOfertaShowRoomType readonly
as
begin

UPDATE ShowRoom.OfertaShowRoom
SET Stock = t.Stock,
	StockInicial = t.Stock,
	PrecioOferta = t.PrecioOferta,
	UnidadesPermitidas = t.UnidadesPermitidas,
	Descripcion = t.Descripcion,
	CodigoCategoria = t.CodigoCategoria,
	TipNegocio = t.TipNegocio
FROM ShowRoom.OfertaShowRoom o
INNER JOIN ods.Campania c on 
	c.CampaniaID = o.CampaniaID
JOIN @StockPrecioOfertaShowRoom t ON 
	c.Codigo = t.CampaniaID
	AND o.CUV = t.CUV
	AND o.TipoOfertaSisID = t.TipoOfertaSisID

end
GO
/*end*/

USE BelcorpVenezuela
GO

ALTER procedure [ShowRoom].[UpdStockOfertaShowRoomMasivo]
@StockPrecioOfertaShowRoom ShowRoom.StockPrecioOfertaShowRoomType readonly
as
begin

UPDATE ShowRoom.OfertaShowRoom
SET Stock = t.Stock,
	StockInicial = t.Stock,
	PrecioOferta = t.PrecioOferta,
	UnidadesPermitidas = t.UnidadesPermitidas,
	Descripcion = t.Descripcion,
	CodigoCategoria = t.CodigoCategoria,
	TipNegocio = t.TipNegocio
FROM ShowRoom.OfertaShowRoom o
INNER JOIN ods.Campania c on 
	c.CampaniaID = o.CampaniaID
JOIN @StockPrecioOfertaShowRoom t ON 
	c.Codigo = t.CampaniaID
	AND o.CUV = t.CUV
	AND o.TipoOfertaSisID = t.TipoOfertaSisID

end
GO

