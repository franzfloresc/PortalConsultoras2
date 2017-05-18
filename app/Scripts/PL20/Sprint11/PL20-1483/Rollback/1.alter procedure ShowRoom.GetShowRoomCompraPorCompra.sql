use BelcorpBolivia
go
alter procedure ShowRoom.GetShowRoomCompraPorCompra
(
@EventoID int,
@CampaniaID int
)
as
/*
ShowRoom.GetShowRoomCompraPorCompra 5,201705 cc
*/
Begin

declare @CodigoCampania int
select @CodigoCampania = CampaniaID from [ods].[Campania] where Codigo = @CampaniaID

declare @Productos_Faltantes_tmp table
(
Cuv varchar(20)
)

insert into @Productos_Faltantes_tmp
select distinct CodigoVenta from ods.faltanteanunciado where campaniaID = @CodigoCampania

insert into @Productos_Faltantes_tmp
select distinct CUV from dbo.productofaltante where CampaniaID = @CampaniaID

select 
	CompraxCompraID as OfertaShowRoomID,
	c.CampaniaID as CampaniaID,
	cpc.CUV,
	pc.PrecioCatalogo as PrecioOferta,
	MarcaID as MarcaID,
	Orden,
	SAP as CodigoProducto,
	cpc.PrecioValorizado as PrecioValorizado	
from [ShowRoom].[CompraPorCompra] cpc 
inner join [ShowRoom].[Evento] e on cpc.EventoID = e.EventoID
inner join [ods].[Campania] c on e.CampaniaID = c.Codigo
inner join [ods].[ProductoComercial] pc on (c.CampaniaID = pc.CampaniaID and cpc.CUV = pc.CUV and cpc.SAP = pc.CodigoProducto)
where cpc.CUV not in (select distinct Cuv from @Productos_Faltantes_tmp)
and cpc.EventoID = @EventoID

end

go
use BelcorpChile
go
alter procedure ShowRoom.GetShowRoomCompraPorCompra
(
@EventoID int,
@CampaniaID int
)
as
/*
ShowRoom.GetShowRoomCompraPorCompra 5,201705 cc
*/
Begin

declare @CodigoCampania int
select @CodigoCampania = CampaniaID from [ods].[Campania] where Codigo = @CampaniaID

declare @Productos_Faltantes_tmp table
(
Cuv varchar(20)
)

insert into @Productos_Faltantes_tmp
select distinct CodigoVenta from ods.faltanteanunciado where campaniaID = @CodigoCampania

insert into @Productos_Faltantes_tmp
select distinct CUV from dbo.productofaltante where CampaniaID = @CampaniaID

select 
	CompraxCompraID as OfertaShowRoomID,
	c.CampaniaID as CampaniaID,
	cpc.CUV,
	pc.PrecioCatalogo as PrecioOferta,
	MarcaID as MarcaID,
	Orden,
	SAP as CodigoProducto,
	cpc.PrecioValorizado as PrecioValorizado	
from [ShowRoom].[CompraPorCompra] cpc 
inner join [ShowRoom].[Evento] e on cpc.EventoID = e.EventoID
inner join [ods].[Campania] c on e.CampaniaID = c.Codigo
inner join [ods].[ProductoComercial] pc on (c.CampaniaID = pc.CampaniaID and cpc.CUV = pc.CUV and cpc.SAP = pc.CodigoProducto)
where cpc.CUV not in (select distinct Cuv from @Productos_Faltantes_tmp)
and cpc.EventoID = @EventoID

end
go
use BelcorpColombia
go
alter procedure ShowRoom.GetShowRoomCompraPorCompra
(
@EventoID int,
@CampaniaID int
)
as
/*
ShowRoom.GetShowRoomCompraPorCompra 5,201705 cc
*/
Begin

declare @CodigoCampania int
select @CodigoCampania = CampaniaID from [ods].[Campania] where Codigo = @CampaniaID

declare @Productos_Faltantes_tmp table
(
Cuv varchar(20)
)

insert into @Productos_Faltantes_tmp
select distinct CodigoVenta from ods.faltanteanunciado where campaniaID = @CodigoCampania

insert into @Productos_Faltantes_tmp
select distinct CUV from dbo.productofaltante where CampaniaID = @CampaniaID

select 
	CompraxCompraID as OfertaShowRoomID,
	c.CampaniaID as CampaniaID,
	cpc.CUV,
	pc.PrecioCatalogo as PrecioOferta,
	MarcaID as MarcaID,
	Orden,
	SAP as CodigoProducto,
	cpc.PrecioValorizado as PrecioValorizado	
from [ShowRoom].[CompraPorCompra] cpc 
inner join [ShowRoom].[Evento] e on cpc.EventoID = e.EventoID
inner join [ods].[Campania] c on e.CampaniaID = c.Codigo
inner join [ods].[ProductoComercial] pc on (c.CampaniaID = pc.CampaniaID and cpc.CUV = pc.CUV and cpc.SAP = pc.CodigoProducto)
where cpc.CUV not in (select distinct Cuv from @Productos_Faltantes_tmp)
and cpc.EventoID = @EventoID

end
go
use BelcorpCostaRica
go
alter procedure ShowRoom.GetShowRoomCompraPorCompra
(
@EventoID int,
@CampaniaID int
)
as
/*
ShowRoom.GetShowRoomCompraPorCompra 5,201705 cc
*/
Begin

declare @CodigoCampania int
select @CodigoCampania = CampaniaID from [ods].[Campania] where Codigo = @CampaniaID

declare @Productos_Faltantes_tmp table
(
Cuv varchar(20)
)

insert into @Productos_Faltantes_tmp
select distinct CodigoVenta from ods.faltanteanunciado where campaniaID = @CodigoCampania

insert into @Productos_Faltantes_tmp
select distinct CUV from dbo.productofaltante where CampaniaID = @CampaniaID

select 
	CompraxCompraID as OfertaShowRoomID,
	c.CampaniaID as CampaniaID,
	cpc.CUV,
	pc.PrecioCatalogo as PrecioOferta,
	MarcaID as MarcaID,
	Orden,
	SAP as CodigoProducto,
	cpc.PrecioValorizado as PrecioValorizado	
from [ShowRoom].[CompraPorCompra] cpc 
inner join [ShowRoom].[Evento] e on cpc.EventoID = e.EventoID
inner join [ods].[Campania] c on e.CampaniaID = c.Codigo
inner join [ods].[ProductoComercial] pc on (c.CampaniaID = pc.CampaniaID and cpc.CUV = pc.CUV and cpc.SAP = pc.CodigoProducto)
where cpc.CUV not in (select distinct Cuv from @Productos_Faltantes_tmp)
and cpc.EventoID = @EventoID

end
go
use BelcorpDominicana
go
alter procedure ShowRoom.GetShowRoomCompraPorCompra
(
@EventoID int,
@CampaniaID int
)
as
/*
ShowRoom.GetShowRoomCompraPorCompra 5,201705 cc
*/
Begin

declare @CodigoCampania int
select @CodigoCampania = CampaniaID from [ods].[Campania] where Codigo = @CampaniaID

declare @Productos_Faltantes_tmp table
(
Cuv varchar(20)
)

insert into @Productos_Faltantes_tmp
select distinct CodigoVenta from ods.faltanteanunciado where campaniaID = @CodigoCampania

insert into @Productos_Faltantes_tmp
select distinct CUV from dbo.productofaltante where CampaniaID = @CampaniaID

select 
	CompraxCompraID as OfertaShowRoomID,
	c.CampaniaID as CampaniaID,
	cpc.CUV,
	pc.PrecioCatalogo as PrecioOferta,
	MarcaID as MarcaID,
	Orden,
	SAP as CodigoProducto,
	cpc.PrecioValorizado as PrecioValorizado	
from [ShowRoom].[CompraPorCompra] cpc 
inner join [ShowRoom].[Evento] e on cpc.EventoID = e.EventoID
inner join [ods].[Campania] c on e.CampaniaID = c.Codigo
inner join [ods].[ProductoComercial] pc on (c.CampaniaID = pc.CampaniaID and cpc.CUV = pc.CUV and cpc.SAP = pc.CodigoProducto)
where cpc.CUV not in (select distinct Cuv from @Productos_Faltantes_tmp)
and cpc.EventoID = @EventoID

end
go
use BelcorpEcuador
go
alter procedure ShowRoom.GetShowRoomCompraPorCompra
(
@EventoID int,
@CampaniaID int
)
as
/*
ShowRoom.GetShowRoomCompraPorCompra 5,201705 cc
*/
Begin

declare @CodigoCampania int
select @CodigoCampania = CampaniaID from [ods].[Campania] where Codigo = @CampaniaID

declare @Productos_Faltantes_tmp table
(
Cuv varchar(20)
)

insert into @Productos_Faltantes_tmp
select distinct CodigoVenta from ods.faltanteanunciado where campaniaID = @CodigoCampania

insert into @Productos_Faltantes_tmp
select distinct CUV from dbo.productofaltante where CampaniaID = @CampaniaID

select 
	CompraxCompraID as OfertaShowRoomID,
	c.CampaniaID as CampaniaID,
	cpc.CUV,
	pc.PrecioCatalogo as PrecioOferta,
	MarcaID as MarcaID,
	Orden,
	SAP as CodigoProducto,
	cpc.PrecioValorizado as PrecioValorizado	
from [ShowRoom].[CompraPorCompra] cpc 
inner join [ShowRoom].[Evento] e on cpc.EventoID = e.EventoID
inner join [ods].[Campania] c on e.CampaniaID = c.Codigo
inner join [ods].[ProductoComercial] pc on (c.CampaniaID = pc.CampaniaID and cpc.CUV = pc.CUV and cpc.SAP = pc.CodigoProducto)
where cpc.CUV not in (select distinct Cuv from @Productos_Faltantes_tmp)
and cpc.EventoID = @EventoID

end
go
use BelcorpGuatemala
go
alter procedure ShowRoom.GetShowRoomCompraPorCompra
(
@EventoID int,
@CampaniaID int
)
as
/*
ShowRoom.GetShowRoomCompraPorCompra 5,201705 cc
*/
Begin

declare @CodigoCampania int
select @CodigoCampania = CampaniaID from [ods].[Campania] where Codigo = @CampaniaID

declare @Productos_Faltantes_tmp table
(
Cuv varchar(20)
)

insert into @Productos_Faltantes_tmp
select distinct CodigoVenta from ods.faltanteanunciado where campaniaID = @CodigoCampania

insert into @Productos_Faltantes_tmp
select distinct CUV from dbo.productofaltante where CampaniaID = @CampaniaID

select 
	CompraxCompraID as OfertaShowRoomID,
	c.CampaniaID as CampaniaID,
	cpc.CUV,
	pc.PrecioCatalogo as PrecioOferta,
	MarcaID as MarcaID,
	Orden,
	SAP as CodigoProducto,
	cpc.PrecioValorizado as PrecioValorizado	
from [ShowRoom].[CompraPorCompra] cpc 
inner join [ShowRoom].[Evento] e on cpc.EventoID = e.EventoID
inner join [ods].[Campania] c on e.CampaniaID = c.Codigo
inner join [ods].[ProductoComercial] pc on (c.CampaniaID = pc.CampaniaID and cpc.CUV = pc.CUV and cpc.SAP = pc.CodigoProducto)
where cpc.CUV not in (select distinct Cuv from @Productos_Faltantes_tmp)
and cpc.EventoID = @EventoID

end
go
use BelcorpMexico
go
alter procedure ShowRoom.GetShowRoomCompraPorCompra
(
@EventoID int,
@CampaniaID int
)
as
/*
ShowRoom.GetShowRoomCompraPorCompra 5,201705 cc
*/
Begin

declare @CodigoCampania int
select @CodigoCampania = CampaniaID from [ods].[Campania] where Codigo = @CampaniaID

declare @Productos_Faltantes_tmp table
(
Cuv varchar(20)
)

insert into @Productos_Faltantes_tmp
select distinct CodigoVenta from ods.faltanteanunciado where campaniaID = @CodigoCampania

insert into @Productos_Faltantes_tmp
select distinct CUV from dbo.productofaltante where CampaniaID = @CampaniaID

select 
	CompraxCompraID as OfertaShowRoomID,
	c.CampaniaID as CampaniaID,
	cpc.CUV,
	pc.PrecioCatalogo as PrecioOferta,
	MarcaID as MarcaID,
	Orden,
	SAP as CodigoProducto,
	cpc.PrecioValorizado as PrecioValorizado	
from [ShowRoom].[CompraPorCompra] cpc 
inner join [ShowRoom].[Evento] e on cpc.EventoID = e.EventoID
inner join [ods].[Campania] c on e.CampaniaID = c.Codigo
inner join [ods].[ProductoComercial] pc on (c.CampaniaID = pc.CampaniaID and cpc.CUV = pc.CUV and cpc.SAP = pc.CodigoProducto)
where cpc.CUV not in (select distinct Cuv from @Productos_Faltantes_tmp)
and cpc.EventoID = @EventoID

end
go
use BelcorpPanama
go
alter procedure ShowRoom.GetShowRoomCompraPorCompra
(
@EventoID int,
@CampaniaID int
)
as
/*
ShowRoom.GetShowRoomCompraPorCompra 5,201705 cc
*/
Begin

declare @CodigoCampania int
select @CodigoCampania = CampaniaID from [ods].[Campania] where Codigo = @CampaniaID

declare @Productos_Faltantes_tmp table
(
Cuv varchar(20)
)

insert into @Productos_Faltantes_tmp
select distinct CodigoVenta from ods.faltanteanunciado where campaniaID = @CodigoCampania

insert into @Productos_Faltantes_tmp
select distinct CUV from dbo.productofaltante where CampaniaID = @CampaniaID

select 
	CompraxCompraID as OfertaShowRoomID,
	c.CampaniaID as CampaniaID,
	cpc.CUV,
	pc.PrecioCatalogo as PrecioOferta,
	MarcaID as MarcaID,
	Orden,
	SAP as CodigoProducto,
	cpc.PrecioValorizado as PrecioValorizado	
from [ShowRoom].[CompraPorCompra] cpc 
inner join [ShowRoom].[Evento] e on cpc.EventoID = e.EventoID
inner join [ods].[Campania] c on e.CampaniaID = c.Codigo
inner join [ods].[ProductoComercial] pc on (c.CampaniaID = pc.CampaniaID and cpc.CUV = pc.CUV and cpc.SAP = pc.CodigoProducto)
where cpc.CUV not in (select distinct Cuv from @Productos_Faltantes_tmp)
and cpc.EventoID = @EventoID

end
go
use BelcorpPeru
go
alter procedure ShowRoom.GetShowRoomCompraPorCompra
(
@EventoID int,
@CampaniaID int
)
as
/*
ShowRoom.GetShowRoomCompraPorCompra 5,201705 cc
*/
Begin

declare @CodigoCampania int
select @CodigoCampania = CampaniaID from [ods].[Campania] where Codigo = @CampaniaID

declare @Productos_Faltantes_tmp table
(
Cuv varchar(20)
)

insert into @Productos_Faltantes_tmp
select distinct CodigoVenta from ods.faltanteanunciado where campaniaID = @CodigoCampania

insert into @Productos_Faltantes_tmp
select distinct CUV from dbo.productofaltante where CampaniaID = @CampaniaID

select 
	CompraxCompraID as OfertaShowRoomID,
	c.CampaniaID as CampaniaID,
	cpc.CUV,
	pc.PrecioCatalogo as PrecioOferta,
	MarcaID as MarcaID,
	Orden,
	SAP as CodigoProducto,
	cpc.PrecioValorizado as PrecioValorizado	
from [ShowRoom].[CompraPorCompra] cpc 
inner join [ShowRoom].[Evento] e on cpc.EventoID = e.EventoID
inner join [ods].[Campania] c on e.CampaniaID = c.Codigo
inner join [ods].[ProductoComercial] pc on (c.CampaniaID = pc.CampaniaID and cpc.CUV = pc.CUV and cpc.SAP = pc.CodigoProducto)
where cpc.CUV not in (select distinct Cuv from @Productos_Faltantes_tmp)
and cpc.EventoID = @EventoID

end
go
use BelcorpPuertoRico
go
alter procedure ShowRoom.GetShowRoomCompraPorCompra
(
@EventoID int,
@CampaniaID int
)
as
/*
ShowRoom.GetShowRoomCompraPorCompra 5,201705 cc
*/
Begin

declare @CodigoCampania int
select @CodigoCampania = CampaniaID from [ods].[Campania] where Codigo = @CampaniaID

declare @Productos_Faltantes_tmp table
(
Cuv varchar(20)
)

insert into @Productos_Faltantes_tmp
select distinct CodigoVenta from ods.faltanteanunciado where campaniaID = @CodigoCampania

insert into @Productos_Faltantes_tmp
select distinct CUV from dbo.productofaltante where CampaniaID = @CampaniaID

select 
	CompraxCompraID as OfertaShowRoomID,
	c.CampaniaID as CampaniaID,
	cpc.CUV,
	pc.PrecioCatalogo as PrecioOferta,
	MarcaID as MarcaID,
	Orden,
	SAP as CodigoProducto,
	cpc.PrecioValorizado as PrecioValorizado	
from [ShowRoom].[CompraPorCompra] cpc 
inner join [ShowRoom].[Evento] e on cpc.EventoID = e.EventoID
inner join [ods].[Campania] c on e.CampaniaID = c.Codigo
inner join [ods].[ProductoComercial] pc on (c.CampaniaID = pc.CampaniaID and cpc.CUV = pc.CUV and cpc.SAP = pc.CodigoProducto)
where cpc.CUV not in (select distinct Cuv from @Productos_Faltantes_tmp)
and cpc.EventoID = @EventoID

end
go
use BelcorpSalvador
go
alter procedure ShowRoom.GetShowRoomCompraPorCompra
(
@EventoID int,
@CampaniaID int
)
as
/*
ShowRoom.GetShowRoomCompraPorCompra 5,201705 cc
*/
Begin

declare @CodigoCampania int
select @CodigoCampania = CampaniaID from [ods].[Campania] where Codigo = @CampaniaID

declare @Productos_Faltantes_tmp table
(
Cuv varchar(20)
)

insert into @Productos_Faltantes_tmp
select distinct CodigoVenta from ods.faltanteanunciado where campaniaID = @CodigoCampania

insert into @Productos_Faltantes_tmp
select distinct CUV from dbo.productofaltante where CampaniaID = @CampaniaID

select 
	CompraxCompraID as OfertaShowRoomID,
	c.CampaniaID as CampaniaID,
	cpc.CUV,
	pc.PrecioCatalogo as PrecioOferta,
	MarcaID as MarcaID,
	Orden,
	SAP as CodigoProducto,
	cpc.PrecioValorizado as PrecioValorizado	
from [ShowRoom].[CompraPorCompra] cpc 
inner join [ShowRoom].[Evento] e on cpc.EventoID = e.EventoID
inner join [ods].[Campania] c on e.CampaniaID = c.Codigo
inner join [ods].[ProductoComercial] pc on (c.CampaniaID = pc.CampaniaID and cpc.CUV = pc.CUV and cpc.SAP = pc.CodigoProducto)
where cpc.CUV not in (select distinct Cuv from @Productos_Faltantes_tmp)
and cpc.EventoID = @EventoID

end
go
use BelcorpVenezuela
go
alter procedure ShowRoom.GetShowRoomCompraPorCompra
(
@EventoID int,
@CampaniaID int
)
as
/*
ShowRoom.GetShowRoomCompraPorCompra 5,201705 cc
*/
Begin

declare @CodigoCampania int
select @CodigoCampania = CampaniaID from [ods].[Campania] where Codigo = @CampaniaID

declare @Productos_Faltantes_tmp table
(
Cuv varchar(20)
)

insert into @Productos_Faltantes_tmp
select distinct CodigoVenta from ods.faltanteanunciado where campaniaID = @CodigoCampania

insert into @Productos_Faltantes_tmp
select distinct CUV from dbo.productofaltante where CampaniaID = @CampaniaID

select 
	CompraxCompraID as OfertaShowRoomID,
	c.CampaniaID as CampaniaID,
	cpc.CUV,
	pc.PrecioCatalogo as PrecioOferta,
	MarcaID as MarcaID,
	Orden,
	SAP as CodigoProducto,
	cpc.PrecioValorizado as PrecioValorizado	
from [ShowRoom].[CompraPorCompra] cpc 
inner join [ShowRoom].[Evento] e on cpc.EventoID = e.EventoID
inner join [ods].[Campania] c on e.CampaniaID = c.Codigo
inner join [ods].[ProductoComercial] pc on (c.CampaniaID = pc.CampaniaID and cpc.CUV = pc.CUV and cpc.SAP = pc.CodigoProducto)
where cpc.CUV not in (select distinct Cuv from @Productos_Faltantes_tmp)
and cpc.EventoID = @EventoID

end
go