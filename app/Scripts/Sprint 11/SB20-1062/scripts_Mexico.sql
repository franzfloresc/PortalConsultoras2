USE [BelcorpMexico]
GO

ALTER procedure [ShowRoom].[GetProductosShowRoom]
@CampaniaID int
as
/*
ShowRoom.GetProductosShowRoom 201616
*/
begin

select 
	ISNULL(OS.OfertaShowRoomID,0) OfertaShowRoomID,
	0 as ConfiguracionOfertaID,
	ROW_NUMBER() OVER (ORDER BY (SELECT 1)) as NroOrden,
	PC.CampaniaID,
	CA.Codigo as CodigoCampania,
	PC.CUV,
	PC.CodigoTipoOferta,
	'' as TipoOferta,
	ISNULL(OS.Descripcion,PC.Descripcion) as Descripcion,
	COALESCE(OS.PrecioOferta,PC.PrecioCatalogo) as PrecioOferta,
	ISNULL(OS.Stock,0) Stock,
	ISNULL(OS.StockInicial,0) StockInicial,
	ISNULL(OS.ImagenProducto,'') ImagenProducto,
	ISNULL(OS.UnidadesPermitidas,'') UnidadesPermitidas,
	ISNULL(OS.FlagHabilitarProducto,0) FlagHabilitarProducto,
	OS.Orden,
	PC.CodigoProducto,
	ISNULL(OS.DescripcionLegal,'') DescripcionLegal,
	ISNULL(OS.ImagenMini,'') ImagenMini
FROM ods.ProductoComercial PC WITH (NOLOCK)
INNER JOIN ods.Campania CA WITH (NOLOCK) ON 
	CA.CampaniaID = PC.CampaniaID
LEFT JOIN ShowRoom.OfertaShowRoom OS WITH(NOLOCK) ON 
	OS.CUV = PC.CUV 
	AND OS.CampaniaID = PC.CampaniaID
WHERE 
	PC.CodigoAcceso = 'SH'
	AND CA.Codigo = @CampaniaID
ORDER BY OS.CUV desc

end

go

ALTER procedure [ShowRoom].[GetShowRoomOfertasConsultora]
@CampaniaID int,
@CodigoConsultora varchar(20)
as
/*
ShowRoom.GetShowRoomOfertasConsultora 201616,'000003735'
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
	FechaCreacion datetime,
	UsuarioCreacion varchar(20), 
	FechaModificacion datetime,
	UsuarioModificacion varchar(20)
)

insert into @tablaEventoConsultora
select top 1 * from ShowRoom.EventoConsultora
where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
order by EventoConsultoraID desc

select
o.OfertaShowRoomID,o.CampaniaID,o.CUV,o.TipoOfertaSisID,o.ConfiguracionOfertaID,o.Descripcion,o.PrecioOferta,pc.PrecioCatalogo,o.Stock,
o.StockInicial,o.ImagenProducto,o.UnidadesPermitidas,o.FlagHabilitarProducto,o.DescripcionLegal,o.UsuarioRegistro,
o.FechaRegistro,o.UsuarioModificacion,o.FechaModificacion,o.ImagenMini,pc.MarcaID
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
where 
	c.Codigo = @CampaniaID
	and ec.CodigoConsultora = @CodigoConsultora
	and o.FlagHabilitarProducto = 1
order by pos.Orden

end

go