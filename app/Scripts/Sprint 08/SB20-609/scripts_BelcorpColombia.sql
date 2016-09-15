USE [BelcorpColombia]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[UpdStockOfertaShowRoomMasivo]') AND type in (N'P', N'PC')) 
	drop procedure ShowRoom.UpdStockOfertaShowRoomMasivo
go

IF (SELECT COUNT(*) FROM sys.table_types WHERE name = 'StockPrecioOfertaShowRoomType') = 1
  DROP TYPE ShowRoom.StockPrecioOfertaShowRoomType
GO

IF (SELECT COUNT(*) FROM sys.table_types WHERE name = 'StockPrecioOfertaShowRoomType') = 0  
  CREATE TYPE ShowRoom.StockPrecioOfertaShowRoomType AS TABLE ( 
	TipoOfertaSisID int, CampaniaID int, CUV varchar(20), Stock int, PrecioOferta decimal(18,2), UnidadesPermitidas int
  )
GO

create procedure [ShowRoom].[UpdStockOfertaShowRoomMasivo]
@StockPrecioOfertaShowRoom ShowRoom.StockPrecioOfertaShowRoomType readonly
as
begin

UPDATE ShowRoom.OfertaShowRoom
SET Stock = t.Stock,
	StockInicial = t.Stock,
	PrecioOferta = t.PrecioOferta,
	UnidadesPermitidas = t.UnidadesPermitidas
FROM ShowRoom.OfertaShowRoom o
INNER JOIN ods.Campania c on 
	c.CampaniaID = o.CampaniaID
JOIN @StockPrecioOfertaShowRoom t ON 
	c.Codigo = t.CampaniaID
	AND o.CUV = t.CUV
	AND o.TipoOfertaSisID = t.TipoOfertaSisID

end

