
USE BelcorpBolivia
GO

ALTER procedure [ShowRoom].[GetShowRoomOfertasConsultora]
@CampaniaID int,
@CodigoConsultora varchar(20)
as
/*
ShowRoom.GetShowRoomOfertasConsultora 201705,'9900126709'
*/
begin

declare @tablaEventoConsultora table 
(
	EventoConsultoraID int,
	EventoID int,
	CampaniaID int,
	CodigoConsultora varchar(20),
	Segmento varchar(50),
	MostrarPopup bit,
	MostrarPopupVenta bit,
	FechaCreacion datetime,
	UsuarioCreacion varchar(20), 
	FechaModificacion datetime,
	UsuarioModificacion varchar(20)
)

insert into @tablaEventoConsultora
select top 1
EventoConsultoraID, EventoID, CampaniaID, CodigoConsultora, Segmento, MostrarPopup, MostrarPopupVenta,
FechaCreacion, UsuarioCreacion, FechaModificacion, UsuarioModificacion
from ShowRoom.EventoConsultora
where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
order by EventoConsultoraID desc

/*Validacion FaltanteAnunciado y ProductoFaltante*/
declare @ZonaID int
declare @CodigoRegion varchar(2)
declare @CodigoZona varchar(4)

select top 1 
@ZonaID = z.ZonaID, @CodigoRegion = r.Codigo, @CodigoZona = z.Codigo
from ods.Consultora c
inner join ods.Zona z on
	c.ZonaID = z.ZonaID
inner join ods.Region r on
	c.RegionID = r.RegionID
where c.Codigo = @CodigoConsultora

declare @tablaFaltante table (CUV varchar(6))

insert into @tablaFaltante
select 
	distinct ltrim(rtrim(CUV))
from dbo.ProductoFaltante nolock
where 
	CampaniaID = @CampaniaID and Zonaid = @ZonaID
UNION ALL
select 
	distinct ltrim(rtrim(fa.CodigoVenta)) AS CUV
from ods.FaltanteAnunciado fa (nolock)
inner join ods.Campania c (nolock) on 
	fa.CampaniaID = c.CampaniaID
where 
	c.Codigo = @CampaniaID 
	and (rtrim(fa.CodigoRegion) = @CodigoRegion or fa.CodigoRegion IS NULL) 
	and (rtrim(fa.CodigoZona) = @CodigoZona or fa.CodigoZona IS NULL)
/*Fin Validacion FaltanteAnunciado y ProductoFaltante*/

select
o.OfertaShowRoomID,o.CampaniaID,o.CUV,o.TipoOfertaSisID,o.ConfiguracionOfertaID,o.Descripcion,o.PrecioOferta,pc.PrecioCatalogo,o.Stock,
o.StockInicial,o.ImagenProducto,o.UnidadesPermitidas,o.FlagHabilitarProducto,o.DescripcionLegal,o.UsuarioRegistro,
o.FechaRegistro,o.UsuarioModificacion,o.FechaModificacion,o.ImagenMini,pc.MarcaID, pos.Orden, o.CodigoCategoria, o.TipNegocio,
pc.CodigoProducto, cat.Descripcion as DescripcionCategoria
from ShowRoom.OfertaShowRoom o
inner join ods.ProductoComercial pc on
	o.CUV = pc.CUV
	and o.CampaniaID = pc.CampaniaID
inner join ods.Campania c on
	o.CampaniaID = c.CampaniaID
inner join @tablaEventoConsultora ec on
	c.Codigo = ec.CampaniaID
inner join ShowRoom.Perfil p on
	ec.Segmento = p.PerfilDescripcion
	and ec.EventoID = p.EventoID
inner join ShowRoom.PerfilOfertaShowRoom pos on
	p.PerfilID = pos.PerfilID
	and c.Codigo = pos.CampaniaID
	and p.EventoID = pos.EventoID	
	and o.CUV = pos.CUV
left join ShowRoom.Categoria cat on
	ec.EventoID = cat.EventoID
	and o.CodigoCategoria = cat.Codigo
where 
	c.Codigo = @CampaniaID
	and ec.CodigoConsultora = @CodigoConsultora
	and o.FlagHabilitarProducto = 1
	and o.CUV not in (
		select CUV from @tablaFaltante
	)
order by pos.Orden

end
GO
/*end*/

USE BelcorpChile
GO

ALTER procedure [ShowRoom].[GetShowRoomOfertasConsultora]
@CampaniaID int,
@CodigoConsultora varchar(20)
as
/*
ShowRoom.GetShowRoomOfertasConsultora 201705,'9900126709'
*/
begin

declare @tablaEventoConsultora table 
(
	EventoConsultoraID int,
	EventoID int,
	CampaniaID int,
	CodigoConsultora varchar(20),
	Segmento varchar(50),
	MostrarPopup bit,
	MostrarPopupVenta bit,
	FechaCreacion datetime,
	UsuarioCreacion varchar(20), 
	FechaModificacion datetime,
	UsuarioModificacion varchar(20)
)

insert into @tablaEventoConsultora
select top 1
EventoConsultoraID, EventoID, CampaniaID, CodigoConsultora, Segmento, MostrarPopup, MostrarPopupVenta,
FechaCreacion, UsuarioCreacion, FechaModificacion, UsuarioModificacion
from ShowRoom.EventoConsultora
where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
order by EventoConsultoraID desc

/*Validacion FaltanteAnunciado y ProductoFaltante*/
declare @ZonaID int
declare @CodigoRegion varchar(2)
declare @CodigoZona varchar(4)

select top 1 
@ZonaID = z.ZonaID, @CodigoRegion = r.Codigo, @CodigoZona = z.Codigo
from ods.Consultora c
inner join ods.Zona z on
	c.ZonaID = z.ZonaID
inner join ods.Region r on
	c.RegionID = r.RegionID
where c.Codigo = @CodigoConsultora

declare @tablaFaltante table (CUV varchar(6))

insert into @tablaFaltante
select 
	distinct ltrim(rtrim(CUV))
from dbo.ProductoFaltante nolock
where 
	CampaniaID = @CampaniaID and Zonaid = @ZonaID
UNION ALL
select 
	distinct ltrim(rtrim(fa.CodigoVenta)) AS CUV
from ods.FaltanteAnunciado fa (nolock)
inner join ods.Campania c (nolock) on 
	fa.CampaniaID = c.CampaniaID
where 
	c.Codigo = @CampaniaID 
	and (rtrim(fa.CodigoRegion) = @CodigoRegion or fa.CodigoRegion IS NULL) 
	and (rtrim(fa.CodigoZona) = @CodigoZona or fa.CodigoZona IS NULL)
/*Fin Validacion FaltanteAnunciado y ProductoFaltante*/

select
o.OfertaShowRoomID,o.CampaniaID,o.CUV,o.TipoOfertaSisID,o.ConfiguracionOfertaID,o.Descripcion,o.PrecioOferta,pc.PrecioCatalogo,o.Stock,
o.StockInicial,o.ImagenProducto,o.UnidadesPermitidas,o.FlagHabilitarProducto,o.DescripcionLegal,o.UsuarioRegistro,
o.FechaRegistro,o.UsuarioModificacion,o.FechaModificacion,o.ImagenMini,pc.MarcaID, pos.Orden, o.CodigoCategoria, o.TipNegocio,
pc.CodigoProducto, cat.Descripcion as DescripcionCategoria
from ShowRoom.OfertaShowRoom o
inner join ods.ProductoComercial pc on
	o.CUV = pc.CUV
	and o.CampaniaID = pc.CampaniaID
inner join ods.Campania c on
	o.CampaniaID = c.CampaniaID
inner join @tablaEventoConsultora ec on
	c.Codigo = ec.CampaniaID
inner join ShowRoom.Perfil p on
	ec.Segmento = p.PerfilDescripcion
	and ec.EventoID = p.EventoID
inner join ShowRoom.PerfilOfertaShowRoom pos on
	p.PerfilID = pos.PerfilID
	and c.Codigo = pos.CampaniaID
	and p.EventoID = pos.EventoID	
	and o.CUV = pos.CUV
left join ShowRoom.Categoria cat on
	ec.EventoID = cat.EventoID
	and o.CodigoCategoria = cat.Codigo
where 
	c.Codigo = @CampaniaID
	and ec.CodigoConsultora = @CodigoConsultora
	and o.FlagHabilitarProducto = 1
	and o.CUV not in (
		select CUV from @tablaFaltante
	)
order by pos.Orden

end
GO
/*end*/

USE BelcorpColombia
GO

ALTER procedure [ShowRoom].[GetShowRoomOfertasConsultora]
@CampaniaID int,
@CodigoConsultora varchar(20)
as
/*
ShowRoom.GetShowRoomOfertasConsultora 201705,'9900126709'
*/
begin

declare @tablaEventoConsultora table 
(
	EventoConsultoraID int,
	EventoID int,
	CampaniaID int,
	CodigoConsultora varchar(20),
	Segmento varchar(50),
	MostrarPopup bit,
	MostrarPopupVenta bit,
	FechaCreacion datetime,
	UsuarioCreacion varchar(20), 
	FechaModificacion datetime,
	UsuarioModificacion varchar(20)
)

insert into @tablaEventoConsultora
select top 1
EventoConsultoraID, EventoID, CampaniaID, CodigoConsultora, Segmento, MostrarPopup, MostrarPopupVenta,
FechaCreacion, UsuarioCreacion, FechaModificacion, UsuarioModificacion
from ShowRoom.EventoConsultora
where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
order by EventoConsultoraID desc

/*Validacion FaltanteAnunciado y ProductoFaltante*/
declare @ZonaID int
declare @CodigoRegion varchar(2)
declare @CodigoZona varchar(4)

select top 1 
@ZonaID = z.ZonaID, @CodigoRegion = r.Codigo, @CodigoZona = z.Codigo
from ods.Consultora c
inner join ods.Zona z on
	c.ZonaID = z.ZonaID
inner join ods.Region r on
	c.RegionID = r.RegionID
where c.Codigo = @CodigoConsultora

declare @tablaFaltante table (CUV varchar(6))

insert into @tablaFaltante
select 
	distinct ltrim(rtrim(CUV))
from dbo.ProductoFaltante nolock
where 
	CampaniaID = @CampaniaID and Zonaid = @ZonaID
UNION ALL
select 
	distinct ltrim(rtrim(fa.CodigoVenta)) AS CUV
from ods.FaltanteAnunciado fa (nolock)
inner join ods.Campania c (nolock) on 
	fa.CampaniaID = c.CampaniaID
where 
	c.Codigo = @CampaniaID 
	and (rtrim(fa.CodigoRegion) = @CodigoRegion or fa.CodigoRegion IS NULL) 
	and (rtrim(fa.CodigoZona) = @CodigoZona or fa.CodigoZona IS NULL)
/*Fin Validacion FaltanteAnunciado y ProductoFaltante*/

select
o.OfertaShowRoomID,o.CampaniaID,o.CUV,o.TipoOfertaSisID,o.ConfiguracionOfertaID,o.Descripcion,o.PrecioOferta,pc.PrecioCatalogo,o.Stock,
o.StockInicial,o.ImagenProducto,o.UnidadesPermitidas,o.FlagHabilitarProducto,o.DescripcionLegal,o.UsuarioRegistro,
o.FechaRegistro,o.UsuarioModificacion,o.FechaModificacion,o.ImagenMini,pc.MarcaID, pos.Orden, o.CodigoCategoria, o.TipNegocio,
pc.CodigoProducto, cat.Descripcion as DescripcionCategoria
from ShowRoom.OfertaShowRoom o
inner join ods.ProductoComercial pc on
	o.CUV = pc.CUV
	and o.CampaniaID = pc.CampaniaID
inner join ods.Campania c on
	o.CampaniaID = c.CampaniaID
inner join @tablaEventoConsultora ec on
	c.Codigo = ec.CampaniaID
inner join ShowRoom.Perfil p on
	ec.Segmento = p.PerfilDescripcion
	and ec.EventoID = p.EventoID
inner join ShowRoom.PerfilOfertaShowRoom pos on
	p.PerfilID = pos.PerfilID
	and c.Codigo = pos.CampaniaID
	and p.EventoID = pos.EventoID	
	and o.CUV = pos.CUV
left join ShowRoom.Categoria cat on
	ec.EventoID = cat.EventoID
	and o.CodigoCategoria = cat.Codigo
where 
	c.Codigo = @CampaniaID
	and ec.CodigoConsultora = @CodigoConsultora
	and o.FlagHabilitarProducto = 1
	and o.CUV not in (
		select CUV from @tablaFaltante
	)
order by pos.Orden

end
GO
/*end*/

USE BelcorpCostaRica
GO

ALTER procedure [ShowRoom].[GetShowRoomOfertasConsultora]
@CampaniaID int,
@CodigoConsultora varchar(20)
as
/*
ShowRoom.GetShowRoomOfertasConsultora 201705,'9900126709'
*/
begin

declare @tablaEventoConsultora table 
(
	EventoConsultoraID int,
	EventoID int,
	CampaniaID int,
	CodigoConsultora varchar(20),
	Segmento varchar(50),
	MostrarPopup bit,
	MostrarPopupVenta bit,
	FechaCreacion datetime,
	UsuarioCreacion varchar(20), 
	FechaModificacion datetime,
	UsuarioModificacion varchar(20)
)

insert into @tablaEventoConsultora
select top 1
EventoConsultoraID, EventoID, CampaniaID, CodigoConsultora, Segmento, MostrarPopup, MostrarPopupVenta,
FechaCreacion, UsuarioCreacion, FechaModificacion, UsuarioModificacion
from ShowRoom.EventoConsultora
where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
order by EventoConsultoraID desc

/*Validacion FaltanteAnunciado y ProductoFaltante*/
declare @ZonaID int
declare @CodigoRegion varchar(2)
declare @CodigoZona varchar(4)

select top 1 
@ZonaID = z.ZonaID, @CodigoRegion = r.Codigo, @CodigoZona = z.Codigo
from ods.Consultora c
inner join ods.Zona z on
	c.ZonaID = z.ZonaID
inner join ods.Region r on
	c.RegionID = r.RegionID
where c.Codigo = @CodigoConsultora

declare @tablaFaltante table (CUV varchar(6))

insert into @tablaFaltante
select 
	distinct ltrim(rtrim(CUV))
from dbo.ProductoFaltante nolock
where 
	CampaniaID = @CampaniaID and Zonaid = @ZonaID
UNION ALL
select 
	distinct ltrim(rtrim(fa.CodigoVenta)) AS CUV
from ods.FaltanteAnunciado fa (nolock)
inner join ods.Campania c (nolock) on 
	fa.CampaniaID = c.CampaniaID
where 
	c.Codigo = @CampaniaID 
	and (rtrim(fa.CodigoRegion) = @CodigoRegion or fa.CodigoRegion IS NULL) 
	and (rtrim(fa.CodigoZona) = @CodigoZona or fa.CodigoZona IS NULL)
/*Fin Validacion FaltanteAnunciado y ProductoFaltante*/

select
o.OfertaShowRoomID,o.CampaniaID,o.CUV,o.TipoOfertaSisID,o.ConfiguracionOfertaID,o.Descripcion,o.PrecioOferta,pc.PrecioCatalogo,o.Stock,
o.StockInicial,o.ImagenProducto,o.UnidadesPermitidas,o.FlagHabilitarProducto,o.DescripcionLegal,o.UsuarioRegistro,
o.FechaRegistro,o.UsuarioModificacion,o.FechaModificacion,o.ImagenMini,pc.MarcaID, pos.Orden, o.CodigoCategoria, o.TipNegocio,
pc.CodigoProducto, cat.Descripcion as DescripcionCategoria
from ShowRoom.OfertaShowRoom o
inner join ods.ProductoComercial pc on
	o.CUV = pc.CUV
	and o.CampaniaID = pc.CampaniaID
inner join ods.Campania c on
	o.CampaniaID = c.CampaniaID
inner join @tablaEventoConsultora ec on
	c.Codigo = ec.CampaniaID
inner join ShowRoom.Perfil p on
	ec.Segmento = p.PerfilDescripcion
	and ec.EventoID = p.EventoID
inner join ShowRoom.PerfilOfertaShowRoom pos on
	p.PerfilID = pos.PerfilID
	and c.Codigo = pos.CampaniaID
	and p.EventoID = pos.EventoID	
	and o.CUV = pos.CUV
left join ShowRoom.Categoria cat on
	ec.EventoID = cat.EventoID
	and o.CodigoCategoria = cat.Codigo
where 
	c.Codigo = @CampaniaID
	and ec.CodigoConsultora = @CodigoConsultora
	and o.FlagHabilitarProducto = 1
	and o.CUV not in (
		select CUV from @tablaFaltante
	)
order by pos.Orden

end
GO
/*end*/

USE BelcorpDominicana
GO

ALTER procedure [ShowRoom].[GetShowRoomOfertasConsultora]
@CampaniaID int,
@CodigoConsultora varchar(20)
as
/*
ShowRoom.GetShowRoomOfertasConsultora 201705,'9900126709'
*/
begin

declare @tablaEventoConsultora table 
(
	EventoConsultoraID int,
	EventoID int,
	CampaniaID int,
	CodigoConsultora varchar(20),
	Segmento varchar(50),
	MostrarPopup bit,
	MostrarPopupVenta bit,
	FechaCreacion datetime,
	UsuarioCreacion varchar(20), 
	FechaModificacion datetime,
	UsuarioModificacion varchar(20)
)

insert into @tablaEventoConsultora
select top 1
EventoConsultoraID, EventoID, CampaniaID, CodigoConsultora, Segmento, MostrarPopup, MostrarPopupVenta,
FechaCreacion, UsuarioCreacion, FechaModificacion, UsuarioModificacion
from ShowRoom.EventoConsultora
where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
order by EventoConsultoraID desc

/*Validacion FaltanteAnunciado y ProductoFaltante*/
declare @ZonaID int
declare @CodigoRegion varchar(2)
declare @CodigoZona varchar(4)

select top 1 
@ZonaID = z.ZonaID, @CodigoRegion = r.Codigo, @CodigoZona = z.Codigo
from ods.Consultora c
inner join ods.Zona z on
	c.ZonaID = z.ZonaID
inner join ods.Region r on
	c.RegionID = r.RegionID
where c.Codigo = @CodigoConsultora

declare @tablaFaltante table (CUV varchar(6))

insert into @tablaFaltante
select 
	distinct ltrim(rtrim(CUV))
from dbo.ProductoFaltante nolock
where 
	CampaniaID = @CampaniaID and Zonaid = @ZonaID
UNION ALL
select 
	distinct ltrim(rtrim(fa.CodigoVenta)) AS CUV
from ods.FaltanteAnunciado fa (nolock)
inner join ods.Campania c (nolock) on 
	fa.CampaniaID = c.CampaniaID
where 
	c.Codigo = @CampaniaID 
	and (rtrim(fa.CodigoRegion) = @CodigoRegion or fa.CodigoRegion IS NULL) 
	and (rtrim(fa.CodigoZona) = @CodigoZona or fa.CodigoZona IS NULL)
/*Fin Validacion FaltanteAnunciado y ProductoFaltante*/

select
o.OfertaShowRoomID,o.CampaniaID,o.CUV,o.TipoOfertaSisID,o.ConfiguracionOfertaID,o.Descripcion,o.PrecioOferta,pc.PrecioCatalogo,o.Stock,
o.StockInicial,o.ImagenProducto,o.UnidadesPermitidas,o.FlagHabilitarProducto,o.DescripcionLegal,o.UsuarioRegistro,
o.FechaRegistro,o.UsuarioModificacion,o.FechaModificacion,o.ImagenMini,pc.MarcaID, pos.Orden, o.CodigoCategoria, o.TipNegocio,
pc.CodigoProducto, cat.Descripcion as DescripcionCategoria
from ShowRoom.OfertaShowRoom o
inner join ods.ProductoComercial pc on
	o.CUV = pc.CUV
	and o.CampaniaID = pc.CampaniaID
inner join ods.Campania c on
	o.CampaniaID = c.CampaniaID
inner join @tablaEventoConsultora ec on
	c.Codigo = ec.CampaniaID
inner join ShowRoom.Perfil p on
	ec.Segmento = p.PerfilDescripcion
	and ec.EventoID = p.EventoID
inner join ShowRoom.PerfilOfertaShowRoom pos on
	p.PerfilID = pos.PerfilID
	and c.Codigo = pos.CampaniaID
	and p.EventoID = pos.EventoID	
	and o.CUV = pos.CUV
left join ShowRoom.Categoria cat on
	ec.EventoID = cat.EventoID
	and o.CodigoCategoria = cat.Codigo
where 
	c.Codigo = @CampaniaID
	and ec.CodigoConsultora = @CodigoConsultora
	and o.FlagHabilitarProducto = 1
	and o.CUV not in (
		select CUV from @tablaFaltante
	)
order by pos.Orden

end
GO
/*end*/

USE BelcorpEcuador
GO

ALTER procedure [ShowRoom].[GetShowRoomOfertasConsultora]
@CampaniaID int,
@CodigoConsultora varchar(20)
as
/*
ShowRoom.GetShowRoomOfertasConsultora 201705,'9900126709'
*/
begin

declare @tablaEventoConsultora table 
(
	EventoConsultoraID int,
	EventoID int,
	CampaniaID int,
	CodigoConsultora varchar(20),
	Segmento varchar(50),
	MostrarPopup bit,
	MostrarPopupVenta bit,
	FechaCreacion datetime,
	UsuarioCreacion varchar(20), 
	FechaModificacion datetime,
	UsuarioModificacion varchar(20)
)

insert into @tablaEventoConsultora
select top 1
EventoConsultoraID, EventoID, CampaniaID, CodigoConsultora, Segmento, MostrarPopup, MostrarPopupVenta,
FechaCreacion, UsuarioCreacion, FechaModificacion, UsuarioModificacion
from ShowRoom.EventoConsultora
where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
order by EventoConsultoraID desc

/*Validacion FaltanteAnunciado y ProductoFaltante*/
declare @ZonaID int
declare @CodigoRegion varchar(2)
declare @CodigoZona varchar(4)

select top 1 
@ZonaID = z.ZonaID, @CodigoRegion = r.Codigo, @CodigoZona = z.Codigo
from ods.Consultora c
inner join ods.Zona z on
	c.ZonaID = z.ZonaID
inner join ods.Region r on
	c.RegionID = r.RegionID
where c.Codigo = @CodigoConsultora

declare @tablaFaltante table (CUV varchar(6))

insert into @tablaFaltante
select 
	distinct ltrim(rtrim(CUV))
from dbo.ProductoFaltante nolock
where 
	CampaniaID = @CampaniaID and Zonaid = @ZonaID
UNION ALL
select 
	distinct ltrim(rtrim(fa.CodigoVenta)) AS CUV
from ods.FaltanteAnunciado fa (nolock)
inner join ods.Campania c (nolock) on 
	fa.CampaniaID = c.CampaniaID
where 
	c.Codigo = @CampaniaID 
	and (rtrim(fa.CodigoRegion) = @CodigoRegion or fa.CodigoRegion IS NULL) 
	and (rtrim(fa.CodigoZona) = @CodigoZona or fa.CodigoZona IS NULL)
/*Fin Validacion FaltanteAnunciado y ProductoFaltante*/

select
o.OfertaShowRoomID,o.CampaniaID,o.CUV,o.TipoOfertaSisID,o.ConfiguracionOfertaID,o.Descripcion,o.PrecioOferta,pc.PrecioCatalogo,o.Stock,
o.StockInicial,o.ImagenProducto,o.UnidadesPermitidas,o.FlagHabilitarProducto,o.DescripcionLegal,o.UsuarioRegistro,
o.FechaRegistro,o.UsuarioModificacion,o.FechaModificacion,o.ImagenMini,pc.MarcaID, pos.Orden, o.CodigoCategoria, o.TipNegocio,
pc.CodigoProducto, cat.Descripcion as DescripcionCategoria
from ShowRoom.OfertaShowRoom o
inner join ods.ProductoComercial pc on
	o.CUV = pc.CUV
	and o.CampaniaID = pc.CampaniaID
inner join ods.Campania c on
	o.CampaniaID = c.CampaniaID
inner join @tablaEventoConsultora ec on
	c.Codigo = ec.CampaniaID
inner join ShowRoom.Perfil p on
	ec.Segmento = p.PerfilDescripcion
	and ec.EventoID = p.EventoID
inner join ShowRoom.PerfilOfertaShowRoom pos on
	p.PerfilID = pos.PerfilID
	and c.Codigo = pos.CampaniaID
	and p.EventoID = pos.EventoID	
	and o.CUV = pos.CUV
left join ShowRoom.Categoria cat on
	ec.EventoID = cat.EventoID
	and o.CodigoCategoria = cat.Codigo
where 
	c.Codigo = @CampaniaID
	and ec.CodigoConsultora = @CodigoConsultora
	and o.FlagHabilitarProducto = 1
	and o.CUV not in (
		select CUV from @tablaFaltante
	)
order by pos.Orden

end
GO
/*end*/

USE BelcorpGuatemala
GO

ALTER procedure [ShowRoom].[GetShowRoomOfertasConsultora]
@CampaniaID int,
@CodigoConsultora varchar(20)
as
/*
ShowRoom.GetShowRoomOfertasConsultora 201705,'9900126709'
*/
begin

declare @tablaEventoConsultora table 
(
	EventoConsultoraID int,
	EventoID int,
	CampaniaID int,
	CodigoConsultora varchar(20),
	Segmento varchar(50),
	MostrarPopup bit,
	MostrarPopupVenta bit,
	FechaCreacion datetime,
	UsuarioCreacion varchar(20), 
	FechaModificacion datetime,
	UsuarioModificacion varchar(20)
)

insert into @tablaEventoConsultora
select top 1
EventoConsultoraID, EventoID, CampaniaID, CodigoConsultora, Segmento, MostrarPopup, MostrarPopupVenta,
FechaCreacion, UsuarioCreacion, FechaModificacion, UsuarioModificacion
from ShowRoom.EventoConsultora
where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
order by EventoConsultoraID desc

/*Validacion FaltanteAnunciado y ProductoFaltante*/
declare @ZonaID int
declare @CodigoRegion varchar(2)
declare @CodigoZona varchar(4)

select top 1 
@ZonaID = z.ZonaID, @CodigoRegion = r.Codigo, @CodigoZona = z.Codigo
from ods.Consultora c
inner join ods.Zona z on
	c.ZonaID = z.ZonaID
inner join ods.Region r on
	c.RegionID = r.RegionID
where c.Codigo = @CodigoConsultora

declare @tablaFaltante table (CUV varchar(6))

insert into @tablaFaltante
select 
	distinct ltrim(rtrim(CUV))
from dbo.ProductoFaltante nolock
where 
	CampaniaID = @CampaniaID and Zonaid = @ZonaID
UNION ALL
select 
	distinct ltrim(rtrim(fa.CodigoVenta)) AS CUV
from ods.FaltanteAnunciado fa (nolock)
inner join ods.Campania c (nolock) on 
	fa.CampaniaID = c.CampaniaID
where 
	c.Codigo = @CampaniaID 
	and (rtrim(fa.CodigoRegion) = @CodigoRegion or fa.CodigoRegion IS NULL) 
	and (rtrim(fa.CodigoZona) = @CodigoZona or fa.CodigoZona IS NULL)
/*Fin Validacion FaltanteAnunciado y ProductoFaltante*/

select
o.OfertaShowRoomID,o.CampaniaID,o.CUV,o.TipoOfertaSisID,o.ConfiguracionOfertaID,o.Descripcion,o.PrecioOferta,pc.PrecioCatalogo,o.Stock,
o.StockInicial,o.ImagenProducto,o.UnidadesPermitidas,o.FlagHabilitarProducto,o.DescripcionLegal,o.UsuarioRegistro,
o.FechaRegistro,o.UsuarioModificacion,o.FechaModificacion,o.ImagenMini,pc.MarcaID, pos.Orden, o.CodigoCategoria, o.TipNegocio,
pc.CodigoProducto, cat.Descripcion as DescripcionCategoria
from ShowRoom.OfertaShowRoom o
inner join ods.ProductoComercial pc on
	o.CUV = pc.CUV
	and o.CampaniaID = pc.CampaniaID
inner join ods.Campania c on
	o.CampaniaID = c.CampaniaID
inner join @tablaEventoConsultora ec on
	c.Codigo = ec.CampaniaID
inner join ShowRoom.Perfil p on
	ec.Segmento = p.PerfilDescripcion
	and ec.EventoID = p.EventoID
inner join ShowRoom.PerfilOfertaShowRoom pos on
	p.PerfilID = pos.PerfilID
	and c.Codigo = pos.CampaniaID
	and p.EventoID = pos.EventoID	
	and o.CUV = pos.CUV
left join ShowRoom.Categoria cat on
	ec.EventoID = cat.EventoID
	and o.CodigoCategoria = cat.Codigo
where 
	c.Codigo = @CampaniaID
	and ec.CodigoConsultora = @CodigoConsultora
	and o.FlagHabilitarProducto = 1
	and o.CUV not in (
		select CUV from @tablaFaltante
	)
order by pos.Orden

end
GO
/*end*/

USE BelcorpMexico
GO

ALTER procedure [ShowRoom].[GetShowRoomOfertasConsultora]
@CampaniaID int,
@CodigoConsultora varchar(20)
as
/*
ShowRoom.GetShowRoomOfertasConsultora 201705,'9900126709'
*/
begin

declare @tablaEventoConsultora table 
(
	EventoConsultoraID int,
	EventoID int,
	CampaniaID int,
	CodigoConsultora varchar(20),
	Segmento varchar(50),
	MostrarPopup bit,
	MostrarPopupVenta bit,
	FechaCreacion datetime,
	UsuarioCreacion varchar(20), 
	FechaModificacion datetime,
	UsuarioModificacion varchar(20)
)

insert into @tablaEventoConsultora
select top 1
EventoConsultoraID, EventoID, CampaniaID, CodigoConsultora, Segmento, MostrarPopup, MostrarPopupVenta,
FechaCreacion, UsuarioCreacion, FechaModificacion, UsuarioModificacion
from ShowRoom.EventoConsultora
where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
order by EventoConsultoraID desc

/*Validacion FaltanteAnunciado y ProductoFaltante*/
declare @ZonaID int
declare @CodigoRegion varchar(2)
declare @CodigoZona varchar(4)

select top 1 
@ZonaID = z.ZonaID, @CodigoRegion = r.Codigo, @CodigoZona = z.Codigo
from ods.Consultora c
inner join ods.Zona z on
	c.ZonaID = z.ZonaID
inner join ods.Region r on
	c.RegionID = r.RegionID
where c.Codigo = @CodigoConsultora

declare @tablaFaltante table (CUV varchar(6))

insert into @tablaFaltante
select 
	distinct ltrim(rtrim(CUV))
from dbo.ProductoFaltante nolock
where 
	CampaniaID = @CampaniaID and Zonaid = @ZonaID
UNION ALL
select 
	distinct ltrim(rtrim(fa.CodigoVenta)) AS CUV
from ods.FaltanteAnunciado fa (nolock)
inner join ods.Campania c (nolock) on 
	fa.CampaniaID = c.CampaniaID
where 
	c.Codigo = @CampaniaID 
	and (rtrim(fa.CodigoRegion) = @CodigoRegion or fa.CodigoRegion IS NULL) 
	and (rtrim(fa.CodigoZona) = @CodigoZona or fa.CodigoZona IS NULL)
/*Fin Validacion FaltanteAnunciado y ProductoFaltante*/

select
o.OfertaShowRoomID,o.CampaniaID,o.CUV,o.TipoOfertaSisID,o.ConfiguracionOfertaID,o.Descripcion,o.PrecioOferta,pc.PrecioCatalogo,o.Stock,
o.StockInicial,o.ImagenProducto,o.UnidadesPermitidas,o.FlagHabilitarProducto,o.DescripcionLegal,o.UsuarioRegistro,
o.FechaRegistro,o.UsuarioModificacion,o.FechaModificacion,o.ImagenMini,pc.MarcaID, pos.Orden, o.CodigoCategoria, o.TipNegocio,
pc.CodigoProducto, cat.Descripcion as DescripcionCategoria
from ShowRoom.OfertaShowRoom o
inner join ods.ProductoComercial pc on
	o.CUV = pc.CUV
	and o.CampaniaID = pc.CampaniaID
inner join ods.Campania c on
	o.CampaniaID = c.CampaniaID
inner join @tablaEventoConsultora ec on
	c.Codigo = ec.CampaniaID
inner join ShowRoom.Perfil p on
	ec.Segmento = p.PerfilDescripcion
	and ec.EventoID = p.EventoID
inner join ShowRoom.PerfilOfertaShowRoom pos on
	p.PerfilID = pos.PerfilID
	and c.Codigo = pos.CampaniaID
	and p.EventoID = pos.EventoID	
	and o.CUV = pos.CUV
left join ShowRoom.Categoria cat on
	ec.EventoID = cat.EventoID
	and o.CodigoCategoria = cat.Codigo
where 
	c.Codigo = @CampaniaID
	and ec.CodigoConsultora = @CodigoConsultora
	and o.FlagHabilitarProducto = 1
	and o.CUV not in (
		select CUV from @tablaFaltante
	)
order by pos.Orden

end
GO
/*end*/

USE BelcorpPanama
GO

ALTER procedure [ShowRoom].[GetShowRoomOfertasConsultora]
@CampaniaID int,
@CodigoConsultora varchar(20)
as
/*
ShowRoom.GetShowRoomOfertasConsultora 201705,'9900126709'
*/
begin

declare @tablaEventoConsultora table 
(
	EventoConsultoraID int,
	EventoID int,
	CampaniaID int,
	CodigoConsultora varchar(20),
	Segmento varchar(50),
	MostrarPopup bit,
	MostrarPopupVenta bit,
	FechaCreacion datetime,
	UsuarioCreacion varchar(20), 
	FechaModificacion datetime,
	UsuarioModificacion varchar(20)
)

insert into @tablaEventoConsultora
select top 1
EventoConsultoraID, EventoID, CampaniaID, CodigoConsultora, Segmento, MostrarPopup, MostrarPopupVenta,
FechaCreacion, UsuarioCreacion, FechaModificacion, UsuarioModificacion
from ShowRoom.EventoConsultora
where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
order by EventoConsultoraID desc

/*Validacion FaltanteAnunciado y ProductoFaltante*/
declare @ZonaID int
declare @CodigoRegion varchar(2)
declare @CodigoZona varchar(4)

select top 1 
@ZonaID = z.ZonaID, @CodigoRegion = r.Codigo, @CodigoZona = z.Codigo
from ods.Consultora c
inner join ods.Zona z on
	c.ZonaID = z.ZonaID
inner join ods.Region r on
	c.RegionID = r.RegionID
where c.Codigo = @CodigoConsultora

declare @tablaFaltante table (CUV varchar(6))

insert into @tablaFaltante
select 
	distinct ltrim(rtrim(CUV))
from dbo.ProductoFaltante nolock
where 
	CampaniaID = @CampaniaID and Zonaid = @ZonaID
UNION ALL
select 
	distinct ltrim(rtrim(fa.CodigoVenta)) AS CUV
from ods.FaltanteAnunciado fa (nolock)
inner join ods.Campania c (nolock) on 
	fa.CampaniaID = c.CampaniaID
where 
	c.Codigo = @CampaniaID 
	and (rtrim(fa.CodigoRegion) = @CodigoRegion or fa.CodigoRegion IS NULL) 
	and (rtrim(fa.CodigoZona) = @CodigoZona or fa.CodigoZona IS NULL)
/*Fin Validacion FaltanteAnunciado y ProductoFaltante*/

select
o.OfertaShowRoomID,o.CampaniaID,o.CUV,o.TipoOfertaSisID,o.ConfiguracionOfertaID,o.Descripcion,o.PrecioOferta,pc.PrecioCatalogo,o.Stock,
o.StockInicial,o.ImagenProducto,o.UnidadesPermitidas,o.FlagHabilitarProducto,o.DescripcionLegal,o.UsuarioRegistro,
o.FechaRegistro,o.UsuarioModificacion,o.FechaModificacion,o.ImagenMini,pc.MarcaID, pos.Orden, o.CodigoCategoria, o.TipNegocio,
pc.CodigoProducto, cat.Descripcion as DescripcionCategoria
from ShowRoom.OfertaShowRoom o
inner join ods.ProductoComercial pc on
	o.CUV = pc.CUV
	and o.CampaniaID = pc.CampaniaID
inner join ods.Campania c on
	o.CampaniaID = c.CampaniaID
inner join @tablaEventoConsultora ec on
	c.Codigo = ec.CampaniaID
inner join ShowRoom.Perfil p on
	ec.Segmento = p.PerfilDescripcion
	and ec.EventoID = p.EventoID
inner join ShowRoom.PerfilOfertaShowRoom pos on
	p.PerfilID = pos.PerfilID
	and c.Codigo = pos.CampaniaID
	and p.EventoID = pos.EventoID	
	and o.CUV = pos.CUV
left join ShowRoom.Categoria cat on
	ec.EventoID = cat.EventoID
	and o.CodigoCategoria = cat.Codigo
where 
	c.Codigo = @CampaniaID
	and ec.CodigoConsultora = @CodigoConsultora
	and o.FlagHabilitarProducto = 1
	and o.CUV not in (
		select CUV from @tablaFaltante
	)
order by pos.Orden

end
GO
/*end*/

USE BelcorpPeru
GO

ALTER procedure [ShowRoom].[GetShowRoomOfertasConsultora]
@CampaniaID int,
@CodigoConsultora varchar(20)
as
/*
ShowRoom.GetShowRoomOfertasConsultora 201705,'9900126709'
*/
begin

declare @tablaEventoConsultora table 
(
	EventoConsultoraID int,
	EventoID int,
	CampaniaID int,
	CodigoConsultora varchar(20),
	Segmento varchar(50),
	MostrarPopup bit,
	MostrarPopupVenta bit,
	FechaCreacion datetime,
	UsuarioCreacion varchar(20), 
	FechaModificacion datetime,
	UsuarioModificacion varchar(20)
)

insert into @tablaEventoConsultora
select top 1
EventoConsultoraID, EventoID, CampaniaID, CodigoConsultora, Segmento, MostrarPopup, MostrarPopupVenta,
FechaCreacion, UsuarioCreacion, FechaModificacion, UsuarioModificacion
from ShowRoom.EventoConsultora
where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
order by EventoConsultoraID desc

/*Validacion FaltanteAnunciado y ProductoFaltante*/
declare @ZonaID int
declare @CodigoRegion varchar(2)
declare @CodigoZona varchar(4)

select top 1 
@ZonaID = z.ZonaID, @CodigoRegion = r.Codigo, @CodigoZona = z.Codigo
from ods.Consultora c
inner join ods.Zona z on
	c.ZonaID = z.ZonaID
inner join ods.Region r on
	c.RegionID = r.RegionID
where c.Codigo = @CodigoConsultora

declare @tablaFaltante table (CUV varchar(6))

insert into @tablaFaltante
select 
	distinct ltrim(rtrim(CUV))
from dbo.ProductoFaltante nolock
where 
	CampaniaID = @CampaniaID and Zonaid = @ZonaID
UNION ALL
select 
	distinct ltrim(rtrim(fa.CodigoVenta)) AS CUV
from ods.FaltanteAnunciado fa (nolock)
inner join ods.Campania c (nolock) on 
	fa.CampaniaID = c.CampaniaID
where 
	c.Codigo = @CampaniaID 
	and (rtrim(fa.CodigoRegion) = @CodigoRegion or fa.CodigoRegion IS NULL) 
	and (rtrim(fa.CodigoZona) = @CodigoZona or fa.CodigoZona IS NULL)
/*Fin Validacion FaltanteAnunciado y ProductoFaltante*/

select
o.OfertaShowRoomID,o.CampaniaID,o.CUV,o.TipoOfertaSisID,o.ConfiguracionOfertaID,o.Descripcion,o.PrecioOferta,pc.PrecioCatalogo,o.Stock,
o.StockInicial,o.ImagenProducto,o.UnidadesPermitidas,o.FlagHabilitarProducto,o.DescripcionLegal,o.UsuarioRegistro,
o.FechaRegistro,o.UsuarioModificacion,o.FechaModificacion,o.ImagenMini,pc.MarcaID, pos.Orden, o.CodigoCategoria, o.TipNegocio,
pc.CodigoProducto, cat.Descripcion as DescripcionCategoria
from ShowRoom.OfertaShowRoom o
inner join ods.ProductoComercial pc on
	o.CUV = pc.CUV
	and o.CampaniaID = pc.CampaniaID
inner join ods.Campania c on
	o.CampaniaID = c.CampaniaID
inner join @tablaEventoConsultora ec on
	c.Codigo = ec.CampaniaID
inner join ShowRoom.Perfil p on
	ec.Segmento = p.PerfilDescripcion
	and ec.EventoID = p.EventoID
inner join ShowRoom.PerfilOfertaShowRoom pos on
	p.PerfilID = pos.PerfilID
	and c.Codigo = pos.CampaniaID
	and p.EventoID = pos.EventoID	
	and o.CUV = pos.CUV
left join ShowRoom.Categoria cat on
	ec.EventoID = cat.EventoID
	and o.CodigoCategoria = cat.Codigo
where 
	c.Codigo = @CampaniaID
	and ec.CodigoConsultora = @CodigoConsultora
	and o.FlagHabilitarProducto = 1
	and o.CUV not in (
		select CUV from @tablaFaltante
	)
order by pos.Orden

end
GO
/*end*/

USE BelcorpPuertoRico
GO

ALTER procedure [ShowRoom].[GetShowRoomOfertasConsultora]
@CampaniaID int,
@CodigoConsultora varchar(20)
as
/*
ShowRoom.GetShowRoomOfertasConsultora 201705,'9900126709'
*/
begin

declare @tablaEventoConsultora table 
(
	EventoConsultoraID int,
	EventoID int,
	CampaniaID int,
	CodigoConsultora varchar(20),
	Segmento varchar(50),
	MostrarPopup bit,
	MostrarPopupVenta bit,
	FechaCreacion datetime,
	UsuarioCreacion varchar(20), 
	FechaModificacion datetime,
	UsuarioModificacion varchar(20)
)

insert into @tablaEventoConsultora
select top 1
EventoConsultoraID, EventoID, CampaniaID, CodigoConsultora, Segmento, MostrarPopup, MostrarPopupVenta,
FechaCreacion, UsuarioCreacion, FechaModificacion, UsuarioModificacion
from ShowRoom.EventoConsultora
where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
order by EventoConsultoraID desc

/*Validacion FaltanteAnunciado y ProductoFaltante*/
declare @ZonaID int
declare @CodigoRegion varchar(2)
declare @CodigoZona varchar(4)

select top 1 
@ZonaID = z.ZonaID, @CodigoRegion = r.Codigo, @CodigoZona = z.Codigo
from ods.Consultora c
inner join ods.Zona z on
	c.ZonaID = z.ZonaID
inner join ods.Region r on
	c.RegionID = r.RegionID
where c.Codigo = @CodigoConsultora

declare @tablaFaltante table (CUV varchar(6))

insert into @tablaFaltante
select 
	distinct ltrim(rtrim(CUV))
from dbo.ProductoFaltante nolock
where 
	CampaniaID = @CampaniaID and Zonaid = @ZonaID
UNION ALL
select 
	distinct ltrim(rtrim(fa.CodigoVenta)) AS CUV
from ods.FaltanteAnunciado fa (nolock)
inner join ods.Campania c (nolock) on 
	fa.CampaniaID = c.CampaniaID
where 
	c.Codigo = @CampaniaID 
	and (rtrim(fa.CodigoRegion) = @CodigoRegion or fa.CodigoRegion IS NULL) 
	and (rtrim(fa.CodigoZona) = @CodigoZona or fa.CodigoZona IS NULL)
/*Fin Validacion FaltanteAnunciado y ProductoFaltante*/

select
o.OfertaShowRoomID,o.CampaniaID,o.CUV,o.TipoOfertaSisID,o.ConfiguracionOfertaID,o.Descripcion,o.PrecioOferta,pc.PrecioCatalogo,o.Stock,
o.StockInicial,o.ImagenProducto,o.UnidadesPermitidas,o.FlagHabilitarProducto,o.DescripcionLegal,o.UsuarioRegistro,
o.FechaRegistro,o.UsuarioModificacion,o.FechaModificacion,o.ImagenMini,pc.MarcaID, pos.Orden, o.CodigoCategoria, o.TipNegocio,
pc.CodigoProducto, cat.Descripcion as DescripcionCategoria
from ShowRoom.OfertaShowRoom o
inner join ods.ProductoComercial pc on
	o.CUV = pc.CUV
	and o.CampaniaID = pc.CampaniaID
inner join ods.Campania c on
	o.CampaniaID = c.CampaniaID
inner join @tablaEventoConsultora ec on
	c.Codigo = ec.CampaniaID
inner join ShowRoom.Perfil p on
	ec.Segmento = p.PerfilDescripcion
	and ec.EventoID = p.EventoID
inner join ShowRoom.PerfilOfertaShowRoom pos on
	p.PerfilID = pos.PerfilID
	and c.Codigo = pos.CampaniaID
	and p.EventoID = pos.EventoID	
	and o.CUV = pos.CUV
left join ShowRoom.Categoria cat on
	ec.EventoID = cat.EventoID
	and o.CodigoCategoria = cat.Codigo
where 
	c.Codigo = @CampaniaID
	and ec.CodigoConsultora = @CodigoConsultora
	and o.FlagHabilitarProducto = 1
	and o.CUV not in (
		select CUV from @tablaFaltante
	)
order by pos.Orden

end
GO
/*end*/

USE BelcorpSalvador
GO

ALTER procedure [ShowRoom].[GetShowRoomOfertasConsultora]
@CampaniaID int,
@CodigoConsultora varchar(20)
as
/*
ShowRoom.GetShowRoomOfertasConsultora 201705,'9900126709'
*/
begin

declare @tablaEventoConsultora table 
(
	EventoConsultoraID int,
	EventoID int,
	CampaniaID int,
	CodigoConsultora varchar(20),
	Segmento varchar(50),
	MostrarPopup bit,
	MostrarPopupVenta bit,
	FechaCreacion datetime,
	UsuarioCreacion varchar(20), 
	FechaModificacion datetime,
	UsuarioModificacion varchar(20)
)

insert into @tablaEventoConsultora
select top 1
EventoConsultoraID, EventoID, CampaniaID, CodigoConsultora, Segmento, MostrarPopup, MostrarPopupVenta,
FechaCreacion, UsuarioCreacion, FechaModificacion, UsuarioModificacion
from ShowRoom.EventoConsultora
where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
order by EventoConsultoraID desc

/*Validacion FaltanteAnunciado y ProductoFaltante*/
declare @ZonaID int
declare @CodigoRegion varchar(2)
declare @CodigoZona varchar(4)

select top 1 
@ZonaID = z.ZonaID, @CodigoRegion = r.Codigo, @CodigoZona = z.Codigo
from ods.Consultora c
inner join ods.Zona z on
	c.ZonaID = z.ZonaID
inner join ods.Region r on
	c.RegionID = r.RegionID
where c.Codigo = @CodigoConsultora

declare @tablaFaltante table (CUV varchar(6))

insert into @tablaFaltante
select 
	distinct ltrim(rtrim(CUV))
from dbo.ProductoFaltante nolock
where 
	CampaniaID = @CampaniaID and Zonaid = @ZonaID
UNION ALL
select 
	distinct ltrim(rtrim(fa.CodigoVenta)) AS CUV
from ods.FaltanteAnunciado fa (nolock)
inner join ods.Campania c (nolock) on 
	fa.CampaniaID = c.CampaniaID
where 
	c.Codigo = @CampaniaID 
	and (rtrim(fa.CodigoRegion) = @CodigoRegion or fa.CodigoRegion IS NULL) 
	and (rtrim(fa.CodigoZona) = @CodigoZona or fa.CodigoZona IS NULL)
/*Fin Validacion FaltanteAnunciado y ProductoFaltante*/

select
o.OfertaShowRoomID,o.CampaniaID,o.CUV,o.TipoOfertaSisID,o.ConfiguracionOfertaID,o.Descripcion,o.PrecioOferta,pc.PrecioCatalogo,o.Stock,
o.StockInicial,o.ImagenProducto,o.UnidadesPermitidas,o.FlagHabilitarProducto,o.DescripcionLegal,o.UsuarioRegistro,
o.FechaRegistro,o.UsuarioModificacion,o.FechaModificacion,o.ImagenMini,pc.MarcaID, pos.Orden, o.CodigoCategoria, o.TipNegocio,
pc.CodigoProducto, cat.Descripcion as DescripcionCategoria
from ShowRoom.OfertaShowRoom o
inner join ods.ProductoComercial pc on
	o.CUV = pc.CUV
	and o.CampaniaID = pc.CampaniaID
inner join ods.Campania c on
	o.CampaniaID = c.CampaniaID
inner join @tablaEventoConsultora ec on
	c.Codigo = ec.CampaniaID
inner join ShowRoom.Perfil p on
	ec.Segmento = p.PerfilDescripcion
	and ec.EventoID = p.EventoID
inner join ShowRoom.PerfilOfertaShowRoom pos on
	p.PerfilID = pos.PerfilID
	and c.Codigo = pos.CampaniaID
	and p.EventoID = pos.EventoID	
	and o.CUV = pos.CUV
left join ShowRoom.Categoria cat on
	ec.EventoID = cat.EventoID
	and o.CodigoCategoria = cat.Codigo
where 
	c.Codigo = @CampaniaID
	and ec.CodigoConsultora = @CodigoConsultora
	and o.FlagHabilitarProducto = 1
	and o.CUV not in (
		select CUV from @tablaFaltante
	)
order by pos.Orden

end
GO
/*end*/

USE BelcorpVenezuela
GO

ALTER procedure [ShowRoom].[GetShowRoomOfertasConsultora]
@CampaniaID int,
@CodigoConsultora varchar(20)
as
/*
ShowRoom.GetShowRoomOfertasConsultora 201705,'9900126709'
*/
begin

declare @tablaEventoConsultora table 
(
	EventoConsultoraID int,
	EventoID int,
	CampaniaID int,
	CodigoConsultora varchar(20),
	Segmento varchar(50),
	MostrarPopup bit,
	MostrarPopupVenta bit,
	FechaCreacion datetime,
	UsuarioCreacion varchar(20), 
	FechaModificacion datetime,
	UsuarioModificacion varchar(20)
)

insert into @tablaEventoConsultora
select top 1
EventoConsultoraID, EventoID, CampaniaID, CodigoConsultora, Segmento, MostrarPopup, MostrarPopupVenta,
FechaCreacion, UsuarioCreacion, FechaModificacion, UsuarioModificacion
from ShowRoom.EventoConsultora
where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
order by EventoConsultoraID desc

/*Validacion FaltanteAnunciado y ProductoFaltante*/
declare @ZonaID int
declare @CodigoRegion varchar(2)
declare @CodigoZona varchar(4)

select top 1 
@ZonaID = z.ZonaID, @CodigoRegion = r.Codigo, @CodigoZona = z.Codigo
from ods.Consultora c
inner join ods.Zona z on
	c.ZonaID = z.ZonaID
inner join ods.Region r on
	c.RegionID = r.RegionID
where c.Codigo = @CodigoConsultora

declare @tablaFaltante table (CUV varchar(6))

insert into @tablaFaltante
select 
	distinct ltrim(rtrim(CUV))
from dbo.ProductoFaltante nolock
where 
	CampaniaID = @CampaniaID and Zonaid = @ZonaID
UNION ALL
select 
	distinct ltrim(rtrim(fa.CodigoVenta)) AS CUV
from ods.FaltanteAnunciado fa (nolock)
inner join ods.Campania c (nolock) on 
	fa.CampaniaID = c.CampaniaID
where 
	c.Codigo = @CampaniaID 
	and (rtrim(fa.CodigoRegion) = @CodigoRegion or fa.CodigoRegion IS NULL) 
	and (rtrim(fa.CodigoZona) = @CodigoZona or fa.CodigoZona IS NULL)
/*Fin Validacion FaltanteAnunciado y ProductoFaltante*/

select
o.OfertaShowRoomID,o.CampaniaID,o.CUV,o.TipoOfertaSisID,o.ConfiguracionOfertaID,o.Descripcion,o.PrecioOferta,pc.PrecioCatalogo,o.Stock,
o.StockInicial,o.ImagenProducto,o.UnidadesPermitidas,o.FlagHabilitarProducto,o.DescripcionLegal,o.UsuarioRegistro,
o.FechaRegistro,o.UsuarioModificacion,o.FechaModificacion,o.ImagenMini,pc.MarcaID, pos.Orden, o.CodigoCategoria, o.TipNegocio,
pc.CodigoProducto, cat.Descripcion as DescripcionCategoria
from ShowRoom.OfertaShowRoom o
inner join ods.ProductoComercial pc on
	o.CUV = pc.CUV
	and o.CampaniaID = pc.CampaniaID
inner join ods.Campania c on
	o.CampaniaID = c.CampaniaID
inner join @tablaEventoConsultora ec on
	c.Codigo = ec.CampaniaID
inner join ShowRoom.Perfil p on
	ec.Segmento = p.PerfilDescripcion
	and ec.EventoID = p.EventoID
inner join ShowRoom.PerfilOfertaShowRoom pos on
	p.PerfilID = pos.PerfilID
	and c.Codigo = pos.CampaniaID
	and p.EventoID = pos.EventoID	
	and o.CUV = pos.CUV
left join ShowRoom.Categoria cat on
	ec.EventoID = cat.EventoID
	and o.CodigoCategoria = cat.Codigo
where 
	c.Codigo = @CampaniaID
	and ec.CodigoConsultora = @CodigoConsultora
	and o.FlagHabilitarProducto = 1
	and o.CUV not in (
		select CUV from @tablaFaltante
	)
order by pos.Orden

end



