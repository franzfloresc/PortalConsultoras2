USE BelcorpBolivia
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.Evento') and SYSCOLUMNS.NAME = N'TieneSubCampania') = 0
	ALTER TABLE ShowRoom.Evento ADD TieneSubCampania bit
go

update ShowRoom.Evento set TieneSubCampania = 0 where TieneSubCampania is null

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'EsSubCampania') = 0
	ALTER TABLE ShowRoom.OfertaShowRoom ADD EsSubCampania bit
go

update ShowRoom.OfertaShowRoom set EsSubCampania = 0 where EsSubCampania is null

go

alter procedure ShowRoom.GetShowRoomEventoByCampaniaID
@CampaniaID int
as
/*
ShowRoom.GetShowRoomEventoByCampaniaID 201707
*/
begin

select
	EventoID,
	CampaniaID,
	Nombre,
	Imagen1,
	Imagen2,
	Descuento,
	FechaCreacion,
	UsuarioCreacion,
	FechaModificacion,
	UsuarioModificacion,
	TextoEstrategia,
	OfertaEstrategia,
	Tema,
	DiasAntes,
	DiasDespues,
	NumeroPerfiles,
	ImagenCabeceraProducto,
	ImagenVentaSetPopup,
	ImagenVentaTagLateral,
	ImagenPestaniaShowRoom,
	Estado,
	RutaShowRoomPopup,
	RutaShowRoomBannerLateral,
	ImagenPreventaDigital,
	isnull(TieneCategoria,0) as TieneCategoria,
	isnull(TieneCompraXcompra,0) as TieneCompraXcompra,
	isnull(TieneSubCampania,0) as TieneSubCampania
from ShowRoom.Evento
where CampaniaID = @CampaniaID

end

go

alter procedure ShowRoom.InsertShowRoomEvento
@EventoID int output,
@CampaniaID int,
@Nombre varchar(150),
@Tema varchar(150),
@DiasAntes int,
@DiasDespues int,
@NumeroPerfiles int,
@UsuarioCreacion varchar(20),
@TieneCategoria bit,
@TieneCompraXcompra bit,
@TieneSubCampania bit
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

insert into ShowRoom.Evento
(CampaniaID, Nombre, Tema, DiasAntes, DiasDespues, NumeroPerfiles, 
FechaCreacion, UsuarioCreacion, FechaModificacion, UsuarioModificacion, 
Estado, TieneCategoria, TieneCompraXcompra, TieneSubCampania)
values
(@CampaniaID, @Nombre, @Tema, @DiasAntes, @DiasDespues, @NumeroPerfiles,
@FechaGeneral, @UsuarioCreacion, @FechaGeneral, @UsuarioCreacion, 
1, @TieneCategoria, @TieneCompraXcompra, @TieneSubCampania)

set @EventoID = @@IDENTITY

end

go

alter procedure ShowRoom.UpdateShowRoomEvento
@EventoID int,
@CampaniaID int,
@Nombre varchar(150),
@Tema varchar(150),
@DiasAntes int,
@DiasDespues int,
@NumeroPerfiles int,
@UsuarioModificacion varchar(20),
@Estado int,
@TieneCategoria bit,
@TieneCompraXcompra bit,
@TieneSubCampania bit
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

update ShowRoom.Evento
set
	CampaniaID = @CampaniaID,
	Nombre = @Nombre,
	Tema = @Tema,
	DiasAntes = @DiasAntes,
	DiasDespues = @DiasDespues,	
	NumeroPerfiles = @NumeroPerfiles,
	FechaModificacion = @FechaGeneral,
	UsuarioModificacion = @UsuarioModificacion,
	Estado = @Estado,
	TieneCategoria = @TieneCategoria,
	TieneCompraXcompra = @TieneCompraXcompra,
	TieneSubCampania = @TieneSubCampania
where EventoID = @EventoID

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[UpdStockOfertaShowRoomMasivo]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].UpdStockOfertaShowRoomMasivo
GO

go

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
	[PrecioValorizado] [decimal](18, 2) NULL,
	[PrecioOferta] [decimal](18, 2) NULL,	
	[UnidadesPermitidas] [int] NULL,
	[Descripcion] [varchar](250) NULL,
	[CodigoCategoria] [varchar](100) NULL,
	[TipNegocio] [varchar](500) NULL,
	[EsSubCampania] [bit] NULL	
)
GO

create procedure ShowRoom.UpdStockOfertaShowRoomMasivo
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
	TipNegocio = t.TipNegocio,
	PrecioValorizado = t.PrecioValorizado,
	EsSubCampania = t.EsSubCampania
FROM ShowRoom.OfertaShowRoom o
INNER JOIN ods.Campania c on 
	c.CampaniaID = o.CampaniaID
JOIN @StockPrecioOfertaShowRoom t ON 
	c.Codigo = t.CampaniaID
	AND o.CUV = t.CUV
	AND o.TipoOfertaSisID = t.TipoOfertaSisID

end

go

alter procedure ShowRoom.GetShowRoomOfertasConsultora
@CampaniaID int,
@CodigoConsultora varchar(20)
as
/*
ShowRoom.GetShowRoomOfertasConsultora 201706,'0012954'
ShowRoom.GetShowRoomOfertasConsultora 201706,'1615995'
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
o.OfertaShowRoomID,o.CampaniaID,o.CUV,o.TipoOfertaSisID,o.ConfiguracionOfertaID,o.Descripcion,
o.PrecioValorizado,
COALESCE(o.PrecioOferta,pc.PrecioCatalogo) AS PrecioOferta,
o.Stock,
o.StockInicial,o.ImagenProducto,o.UnidadesPermitidas,o.FlagHabilitarProducto,o.DescripcionLegal,o.UsuarioRegistro,
o.FechaRegistro,o.UsuarioModificacion,o.FechaModificacion,o.ImagenMini,pc.MarcaID, pos.Orden, o.CodigoCategoria, o.TipNegocio,
pc.CodigoProducto, cat.Descripcion as DescripcionCategoria, o.EsSubCampania
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

go

alter procedure ShowRoom.GetProductosShowRoom
@CampaniaID int
as
/*
ShowRoom.GetProductosShowRoom 201707
*/
begin

declare @ConfiguracionOfertaID int = 0
select @ConfiguracionOfertaID=ConfiguracionOfertaID from ConfiguracionOferta where TipoOfertaSisID = 1707

select 
	ISNULL(OS.OfertaShowRoomID,0) OfertaShowRoomID,
	ROW_NUMBER() OVER (ORDER BY (SELECT 1)) as NroOrden,
	PC.CampaniaID,
	CA.Codigo as CodigoCampania,
	PC.CUV,
	PC.CodigoTipoOferta,
	ISNULL(OS.Descripcion,PC.Descripcion) as Descripcion,
	COALESCE(OS.PrecioValorizado,PC.PrecioValorizado) as PrecioValorizado,
	COALESCE(OS.PrecioOferta,PC.PrecioCatalogo) as PrecioOferta,
	ISNULL(OS.Stock,0) Stock,
	ISNULL(OS.StockInicial,0) StockInicial,
	ISNULL(OS.ImagenProducto,'') ImagenProducto,
	ISNULL(OS.UnidadesPermitidas,'') UnidadesPermitidas,
	ISNULL(OS.FlagHabilitarProducto,0) FlagHabilitarProducto,
	OS.Orden,
	PC.CodigoProducto,
	ISNULL(OS.DescripcionLegal,'') DescripcionLegal,
	ISNULL(OS.ImagenMini,'') ImagenMini,
	@ConfiguracionOfertaID as ConfiguracionOfertaID,
	ISNULL(OS.EsSubCampania,0) as EsSubCampania
FROM ods.ProductoComercial PC WITH (NOLOCK)
INNER JOIN ods.Campania CA WITH (NOLOCK) ON 
	CA.CampaniaID = PC.CampaniaID
LEFT JOIN ShowRoom.OfertaShowRoom OS WITH(NOLOCK) ON 
	OS.CUV = PC.CUV 
	AND OS.CampaniaID = PC.CampaniaID
WHERE 
	PC.CodigoTipoOferta in (
		select Codigo from ShowRoom.TipoOferta where Activo = 1
	)
	AND CA.Codigo = @CampaniaID
union all
select 
	ISNULL(OS.OfertaShowRoomID,0) OfertaShowRoomID,
	ROW_NUMBER() OVER (ORDER BY (SELECT 1)) as NroOrden,
	PC.CampaniaID,
	CA.Codigo as CodigoCampania,
	PC.CUV,
	PC.CodigoTipoOferta,
	ISNULL(OS.Descripcion,PC.Descripcion) as Descripcion,
	COALESCE(OS.PrecioValorizado,PC.PrecioValorizado) as PrecioValorizado,
	COALESCE(OS.PrecioOferta,PC.PrecioCatalogo) as PrecioOferta,
	ISNULL(OS.Stock,0) Stock,
	ISNULL(OS.StockInicial,0) StockInicial,
	ISNULL(OS.ImagenProducto,'') ImagenProducto,
	ISNULL(OS.UnidadesPermitidas,'') UnidadesPermitidas,
	ISNULL(OS.FlagHabilitarProducto,0) FlagHabilitarProducto,
	OS.Orden,
	PC.CodigoProducto,
	ISNULL(OS.DescripcionLegal,'') DescripcionLegal,
	ISNULL(OS.ImagenMini,'') ImagenMini,
	@ConfiguracionOfertaID as ConfiguracionOfertaID,
	ISNULL(OS.EsSubCampania,0) as EsSubCampania
FROM ods.ProductoComercial PC WITH (NOLOCK)
INNER JOIN ods.Campania CA WITH (NOLOCK) ON 
	CA.CampaniaID = PC.CampaniaID
INNER JOIN ShowRoom.OfertaShowRoom OS WITH(NOLOCK) ON 
	OS.CUV = PC.CUV 
	AND OS.CampaniaID = PC.CampaniaID
WHERE 
	PC.CodigoTipoOferta not in (
		select Codigo from ShowRoom.TipoOferta where Activo = 1
	)
	AND CA.Codigo = @CampaniaID
ORDER BY CUV desc

end

go

ALTER PROCEDURE ShowRoom.InsOfertaShowRoom
(	
	@CampaniaID int,
	@CUV varchar(20),
	@TipoOfertaSisID int,
	@ConfiguracionOfertaID int,
	@Descripcion varchar(250),
	@PrecioValorizado numeric(12,2),
	@ImagenProducto varchar(150),
	@Orden int,
	@UnidadesPermitidas int,
	@FlagHabilitarProducto int,
	@DescripcionLegal varchar(250),
	@UsuarioRegistro varchar(50),
	@ImagenMini varchar(150),
	@PrecioOferta decimal(12,2)=0,
	@EsSubCampania bit
)
AS
BEGIN
	INSERT INTO ShowRoom.OfertaShowRoom
	(
		CampaniaID, CUV, TipoOfertaSisID, ConfiguracionOfertaID, Descripcion, PrecioValorizado, Stock, StockInicial, ImagenProducto,
		Orden, UnidadesPermitidas, FlagHabilitarProducto, DescripcionLegal, UsuarioRegistro, FechaRegistro, ImagenMini, PrecioOferta,
		EsSubCampania
	)
	VALUES
	(
		@CampaniaID, @CUV, @TipoOfertaSisID, @ConfiguracionOfertaID, @Descripcion, @PrecioValorizado , 0, 0, @ImagenProducto, 
		@Orden, @UnidadesPermitidas, @FlagHabilitarProducto, @DescripcionLegal, @UsuarioRegistro, getdate(), @ImagenMini, @PrecioOferta,
		@EsSubCampania
	)
END

go

ALTER PROCEDURE ShowRoom.UpdOfertaShowRoom
(
	@TipoOfertaSisID int,
	@CampaniaID int,
	@CUV varchar(20),
	@Descripcion varchar(250),
	@ImagenProducto varchar(150),
	@UnidadesPermitidas int,
	@FlagHabilitarProducto int,
	@Orden int,
	@DescripcionLegal varchar(250),
	@UsuarioModificacion varchar(50),
	@PrecioValorizado decimal(18,2),
	@ImagenMini varchar(150),
	@Incrementa int,
	@CantidadIncrementa int,
	@FlagAgotado int,
	@PrecioOferta decimal(18,2)=0,
	@EsSubCampania bit
)
AS
BEGIN
	UPDATE ShowRoom.OfertaShowRoom
		SET Descripcion = @Descripcion,
			UnidadesPermitidas = @UnidadesPermitidas,
			FlagHabilitarProducto = @FlagHabilitarProducto,
			Orden = @Orden,
			ImagenProducto = @ImagenProducto,
			DescripcionLegal = @DescripcionLegal,
			UsuarioModificacion = @UsuarioModificacion,
			PrecioValorizado = @PrecioValorizado,
			FechaModificacion = getdate(),
			ImagenMini = @ImagenMini,
			Stock = (CASE WHEN @Incrementa = 0 AND @FlagAgotado = 0 THEN Stock + @CantidadIncrementa 
							WHEN @Incrementa = 1 AND @FlagAgotado = 0 THEN Stock - @CantidadIncrementa 
							WHEN @FlagAgotado = 1 THEN 0 END),
			StockInicial = (CASE WHEN @Incrementa = 0 THEN StockInicial + @CantidadIncrementa 
							ELSE StockInicial - @CantidadIncrementa END),
			PrecioOferta = @PrecioOferta,
			EsSubCampania = @EsSubCampania
	where 	
	CampaniaID = @CampaniaID
		AND CUV = @CUV
END

go

ALTER PROCEDURE [ShowRoom].[GetShowRoomPerfilOfertaCuvs]
@EventoID int,
@PerfilID int,
@CampaniaID int
as
/*
ShowRoom.GetShowRoomPerfilOfertaCuvs 1,1,201611
ShowRoom.GetShowRoomPerfilOfertaCuvs 6,47,201707
*/
begin

select 
	isnull(p.PerfilOfertaShowRoomID,0) as PerfilOfertaShowRoomID,
	isnull(p.EventoID,0) as EventoID,
	isnull(p.PerfilID,0) as PerfilID,
	c.Codigo as CampaniaID,
	o.CUV,
	isnull(p.Orden,9999) as Orden,
	o.EsSubCampania
from ShowRoom.OfertaShowRoom o
inner join ods.Campania c on
	o.CampaniaID = c.CampaniaID
left join ShowRoom.PerfilOfertaShowRoom p on
	p.CampaniaID = c.Codigo
	and o.CUV = p.CUV
	and p.PerfilID = @PerfilID
	and p.EventoID = @EventoID
where 
	c.Codigo = @CampaniaID
order by isnull(p.Orden,9999)

end

go

USE BelcorpChile
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.Evento') and SYSCOLUMNS.NAME = N'TieneSubCampania') = 0
	ALTER TABLE ShowRoom.Evento ADD TieneSubCampania bit
go

update ShowRoom.Evento set TieneSubCampania = 0 where TieneSubCampania is null

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'EsSubCampania') = 0
	ALTER TABLE ShowRoom.OfertaShowRoom ADD EsSubCampania bit
go

update ShowRoom.OfertaShowRoom set EsSubCampania = 0 where EsSubCampania is null

go

alter procedure ShowRoom.GetShowRoomEventoByCampaniaID
@CampaniaID int
as
/*
ShowRoom.GetShowRoomEventoByCampaniaID 201707
*/
begin

select
	EventoID,
	CampaniaID,
	Nombre,
	Imagen1,
	Imagen2,
	Descuento,
	FechaCreacion,
	UsuarioCreacion,
	FechaModificacion,
	UsuarioModificacion,
	TextoEstrategia,
	OfertaEstrategia,
	Tema,
	DiasAntes,
	DiasDespues,
	NumeroPerfiles,
	ImagenCabeceraProducto,
	ImagenVentaSetPopup,
	ImagenVentaTagLateral,
	ImagenPestaniaShowRoom,
	Estado,
	RutaShowRoomPopup,
	RutaShowRoomBannerLateral,
	ImagenPreventaDigital,
	isnull(TieneCategoria,0) as TieneCategoria,
	isnull(TieneCompraXcompra,0) as TieneCompraXcompra,
	isnull(TieneSubCampania,0) as TieneSubCampania
from ShowRoom.Evento
where CampaniaID = @CampaniaID

end

go

alter procedure ShowRoom.InsertShowRoomEvento
@EventoID int output,
@CampaniaID int,
@Nombre varchar(150),
@Tema varchar(150),
@DiasAntes int,
@DiasDespues int,
@NumeroPerfiles int,
@UsuarioCreacion varchar(20),
@TieneCategoria bit,
@TieneCompraXcompra bit,
@TieneSubCampania bit
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

insert into ShowRoom.Evento
(CampaniaID, Nombre, Tema, DiasAntes, DiasDespues, NumeroPerfiles, 
FechaCreacion, UsuarioCreacion, FechaModificacion, UsuarioModificacion, 
Estado, TieneCategoria, TieneCompraXcompra, TieneSubCampania)
values
(@CampaniaID, @Nombre, @Tema, @DiasAntes, @DiasDespues, @NumeroPerfiles,
@FechaGeneral, @UsuarioCreacion, @FechaGeneral, @UsuarioCreacion, 
1, @TieneCategoria, @TieneCompraXcompra, @TieneSubCampania)

set @EventoID = @@IDENTITY

end

go

alter procedure ShowRoom.UpdateShowRoomEvento
@EventoID int,
@CampaniaID int,
@Nombre varchar(150),
@Tema varchar(150),
@DiasAntes int,
@DiasDespues int,
@NumeroPerfiles int,
@UsuarioModificacion varchar(20),
@Estado int,
@TieneCategoria bit,
@TieneCompraXcompra bit,
@TieneSubCampania bit
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

update ShowRoom.Evento
set
	CampaniaID = @CampaniaID,
	Nombre = @Nombre,
	Tema = @Tema,
	DiasAntes = @DiasAntes,
	DiasDespues = @DiasDespues,	
	NumeroPerfiles = @NumeroPerfiles,
	FechaModificacion = @FechaGeneral,
	UsuarioModificacion = @UsuarioModificacion,
	Estado = @Estado,
	TieneCategoria = @TieneCategoria,
	TieneCompraXcompra = @TieneCompraXcompra,
	TieneSubCampania = @TieneSubCampania
where EventoID = @EventoID

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[UpdStockOfertaShowRoomMasivo]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].UpdStockOfertaShowRoomMasivo
GO

go

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
	[PrecioValorizado] [decimal](18, 2) NULL,
	[PrecioOferta] [decimal](18, 2) NULL,	
	[UnidadesPermitidas] [int] NULL,
	[Descripcion] [varchar](250) NULL,
	[CodigoCategoria] [varchar](100) NULL,
	[TipNegocio] [varchar](500) NULL,
	[EsSubCampania] [bit] NULL	
)
GO

create procedure ShowRoom.UpdStockOfertaShowRoomMasivo
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
	TipNegocio = t.TipNegocio,
	PrecioValorizado = t.PrecioValorizado,
	EsSubCampania = t.EsSubCampania
FROM ShowRoom.OfertaShowRoom o
INNER JOIN ods.Campania c on 
	c.CampaniaID = o.CampaniaID
JOIN @StockPrecioOfertaShowRoom t ON 
	c.Codigo = t.CampaniaID
	AND o.CUV = t.CUV
	AND o.TipoOfertaSisID = t.TipoOfertaSisID

end

go

alter procedure ShowRoom.GetShowRoomOfertasConsultora
@CampaniaID int,
@CodigoConsultora varchar(20)
as
/*
ShowRoom.GetShowRoomOfertasConsultora 201706,'0012954'
ShowRoom.GetShowRoomOfertasConsultora 201706,'1615995'
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
o.OfertaShowRoomID,o.CampaniaID,o.CUV,o.TipoOfertaSisID,o.ConfiguracionOfertaID,o.Descripcion,
o.PrecioValorizado,
COALESCE(o.PrecioOferta,pc.PrecioCatalogo) AS PrecioOferta,
o.Stock,
o.StockInicial,o.ImagenProducto,o.UnidadesPermitidas,o.FlagHabilitarProducto,o.DescripcionLegal,o.UsuarioRegistro,
o.FechaRegistro,o.UsuarioModificacion,o.FechaModificacion,o.ImagenMini,pc.MarcaID, pos.Orden, o.CodigoCategoria, o.TipNegocio,
pc.CodigoProducto, cat.Descripcion as DescripcionCategoria, o.EsSubCampania
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

go

alter procedure ShowRoom.GetProductosShowRoom
@CampaniaID int
as
/*
ShowRoom.GetProductosShowRoom 201707
*/
begin

declare @ConfiguracionOfertaID int = 0
select @ConfiguracionOfertaID=ConfiguracionOfertaID from ConfiguracionOferta where TipoOfertaSisID = 1707

select 
	ISNULL(OS.OfertaShowRoomID,0) OfertaShowRoomID,
	ROW_NUMBER() OVER (ORDER BY (SELECT 1)) as NroOrden,
	PC.CampaniaID,
	CA.Codigo as CodigoCampania,
	PC.CUV,
	PC.CodigoTipoOferta,
	ISNULL(OS.Descripcion,PC.Descripcion) as Descripcion,
	COALESCE(OS.PrecioValorizado,PC.PrecioValorizado) as PrecioValorizado,
	COALESCE(OS.PrecioOferta,PC.PrecioCatalogo) as PrecioOferta,
	ISNULL(OS.Stock,0) Stock,
	ISNULL(OS.StockInicial,0) StockInicial,
	ISNULL(OS.ImagenProducto,'') ImagenProducto,
	ISNULL(OS.UnidadesPermitidas,'') UnidadesPermitidas,
	ISNULL(OS.FlagHabilitarProducto,0) FlagHabilitarProducto,
	OS.Orden,
	PC.CodigoProducto,
	ISNULL(OS.DescripcionLegal,'') DescripcionLegal,
	ISNULL(OS.ImagenMini,'') ImagenMini,
	@ConfiguracionOfertaID as ConfiguracionOfertaID,
	ISNULL(OS.EsSubCampania,0) as EsSubCampania
FROM ods.ProductoComercial PC WITH (NOLOCK)
INNER JOIN ods.Campania CA WITH (NOLOCK) ON 
	CA.CampaniaID = PC.CampaniaID
LEFT JOIN ShowRoom.OfertaShowRoom OS WITH(NOLOCK) ON 
	OS.CUV = PC.CUV 
	AND OS.CampaniaID = PC.CampaniaID
WHERE 
	PC.CodigoTipoOferta in (
		select Codigo from ShowRoom.TipoOferta where Activo = 1
	)
	AND CA.Codigo = @CampaniaID
union all
select 
	ISNULL(OS.OfertaShowRoomID,0) OfertaShowRoomID,
	ROW_NUMBER() OVER (ORDER BY (SELECT 1)) as NroOrden,
	PC.CampaniaID,
	CA.Codigo as CodigoCampania,
	PC.CUV,
	PC.CodigoTipoOferta,
	ISNULL(OS.Descripcion,PC.Descripcion) as Descripcion,
	COALESCE(OS.PrecioValorizado,PC.PrecioValorizado) as PrecioValorizado,
	COALESCE(OS.PrecioOferta,PC.PrecioCatalogo) as PrecioOferta,
	ISNULL(OS.Stock,0) Stock,
	ISNULL(OS.StockInicial,0) StockInicial,
	ISNULL(OS.ImagenProducto,'') ImagenProducto,
	ISNULL(OS.UnidadesPermitidas,'') UnidadesPermitidas,
	ISNULL(OS.FlagHabilitarProducto,0) FlagHabilitarProducto,
	OS.Orden,
	PC.CodigoProducto,
	ISNULL(OS.DescripcionLegal,'') DescripcionLegal,
	ISNULL(OS.ImagenMini,'') ImagenMini,
	@ConfiguracionOfertaID as ConfiguracionOfertaID,
	ISNULL(OS.EsSubCampania,0) as EsSubCampania
FROM ods.ProductoComercial PC WITH (NOLOCK)
INNER JOIN ods.Campania CA WITH (NOLOCK) ON 
	CA.CampaniaID = PC.CampaniaID
INNER JOIN ShowRoom.OfertaShowRoom OS WITH(NOLOCK) ON 
	OS.CUV = PC.CUV 
	AND OS.CampaniaID = PC.CampaniaID
WHERE 
	PC.CodigoTipoOferta not in (
		select Codigo from ShowRoom.TipoOferta where Activo = 1
	)
	AND CA.Codigo = @CampaniaID
ORDER BY CUV desc

end

go

ALTER PROCEDURE ShowRoom.InsOfertaShowRoom
(	
	@CampaniaID int,
	@CUV varchar(20),
	@TipoOfertaSisID int,
	@ConfiguracionOfertaID int,
	@Descripcion varchar(250),
	@PrecioValorizado numeric(12,2),
	@ImagenProducto varchar(150),
	@Orden int,
	@UnidadesPermitidas int,
	@FlagHabilitarProducto int,
	@DescripcionLegal varchar(250),
	@UsuarioRegistro varchar(50),
	@ImagenMini varchar(150),
	@PrecioOferta decimal(12,2)=0,
	@EsSubCampania bit
)
AS
BEGIN
	INSERT INTO ShowRoom.OfertaShowRoom
	(
		CampaniaID, CUV, TipoOfertaSisID, ConfiguracionOfertaID, Descripcion, PrecioValorizado, Stock, StockInicial, ImagenProducto,
		Orden, UnidadesPermitidas, FlagHabilitarProducto, DescripcionLegal, UsuarioRegistro, FechaRegistro, ImagenMini, PrecioOferta,
		EsSubCampania
	)
	VALUES
	(
		@CampaniaID, @CUV, @TipoOfertaSisID, @ConfiguracionOfertaID, @Descripcion, @PrecioValorizado , 0, 0, @ImagenProducto, 
		@Orden, @UnidadesPermitidas, @FlagHabilitarProducto, @DescripcionLegal, @UsuarioRegistro, getdate(), @ImagenMini, @PrecioOferta,
		@EsSubCampania
	)
END

go

ALTER PROCEDURE ShowRoom.UpdOfertaShowRoom
(
	@TipoOfertaSisID int,
	@CampaniaID int,
	@CUV varchar(20),
	@Descripcion varchar(250),
	@ImagenProducto varchar(150),
	@UnidadesPermitidas int,
	@FlagHabilitarProducto int,
	@Orden int,
	@DescripcionLegal varchar(250),
	@UsuarioModificacion varchar(50),
	@PrecioValorizado decimal(18,2),
	@ImagenMini varchar(150),
	@Incrementa int,
	@CantidadIncrementa int,
	@FlagAgotado int,
	@PrecioOferta decimal(18,2)=0,
	@EsSubCampania bit
)
AS
BEGIN
	UPDATE ShowRoom.OfertaShowRoom
		SET Descripcion = @Descripcion,
			UnidadesPermitidas = @UnidadesPermitidas,
			FlagHabilitarProducto = @FlagHabilitarProducto,
			Orden = @Orden,
			ImagenProducto = @ImagenProducto,
			DescripcionLegal = @DescripcionLegal,
			UsuarioModificacion = @UsuarioModificacion,
			PrecioValorizado = @PrecioValorizado,
			FechaModificacion = getdate(),
			ImagenMini = @ImagenMini,
			Stock = (CASE WHEN @Incrementa = 0 AND @FlagAgotado = 0 THEN Stock + @CantidadIncrementa 
							WHEN @Incrementa = 1 AND @FlagAgotado = 0 THEN Stock - @CantidadIncrementa 
							WHEN @FlagAgotado = 1 THEN 0 END),
			StockInicial = (CASE WHEN @Incrementa = 0 THEN StockInicial + @CantidadIncrementa 
							ELSE StockInicial - @CantidadIncrementa END),
			PrecioOferta = @PrecioOferta,
			EsSubCampania = @EsSubCampania
	where 	
	CampaniaID = @CampaniaID
		AND CUV = @CUV
END

go

ALTER PROCEDURE [ShowRoom].[GetShowRoomPerfilOfertaCuvs]
@EventoID int,
@PerfilID int,
@CampaniaID int
as
/*
ShowRoom.GetShowRoomPerfilOfertaCuvs 1,1,201611
ShowRoom.GetShowRoomPerfilOfertaCuvs 6,47,201707
*/
begin

select 
	isnull(p.PerfilOfertaShowRoomID,0) as PerfilOfertaShowRoomID,
	isnull(p.EventoID,0) as EventoID,
	isnull(p.PerfilID,0) as PerfilID,
	c.Codigo as CampaniaID,
	o.CUV,
	isnull(p.Orden,9999) as Orden,
	o.EsSubCampania
from ShowRoom.OfertaShowRoom o
inner join ods.Campania c on
	o.CampaniaID = c.CampaniaID
left join ShowRoom.PerfilOfertaShowRoom p on
	p.CampaniaID = c.Codigo
	and o.CUV = p.CUV
	and p.PerfilID = @PerfilID
	and p.EventoID = @EventoID
where 
	c.Codigo = @CampaniaID
order by isnull(p.Orden,9999)

end

go

USE BelcorpColombia
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.Evento') and SYSCOLUMNS.NAME = N'TieneSubCampania') = 0
	ALTER TABLE ShowRoom.Evento ADD TieneSubCampania bit
go

update ShowRoom.Evento set TieneSubCampania = 0 where TieneSubCampania is null

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'EsSubCampania') = 0
	ALTER TABLE ShowRoom.OfertaShowRoom ADD EsSubCampania bit
go

update ShowRoom.OfertaShowRoom set EsSubCampania = 0 where EsSubCampania is null

go

alter procedure ShowRoom.GetShowRoomEventoByCampaniaID
@CampaniaID int
as
/*
ShowRoom.GetShowRoomEventoByCampaniaID 201707
*/
begin

select
	EventoID,
	CampaniaID,
	Nombre,
	Imagen1,
	Imagen2,
	Descuento,
	FechaCreacion,
	UsuarioCreacion,
	FechaModificacion,
	UsuarioModificacion,
	TextoEstrategia,
	OfertaEstrategia,
	Tema,
	DiasAntes,
	DiasDespues,
	NumeroPerfiles,
	ImagenCabeceraProducto,
	ImagenVentaSetPopup,
	ImagenVentaTagLateral,
	ImagenPestaniaShowRoom,
	Estado,
	RutaShowRoomPopup,
	RutaShowRoomBannerLateral,
	ImagenPreventaDigital,
	isnull(TieneCategoria,0) as TieneCategoria,
	isnull(TieneCompraXcompra,0) as TieneCompraXcompra,
	isnull(TieneSubCampania,0) as TieneSubCampania
from ShowRoom.Evento
where CampaniaID = @CampaniaID

end

go

alter procedure ShowRoom.InsertShowRoomEvento
@EventoID int output,
@CampaniaID int,
@Nombre varchar(150),
@Tema varchar(150),
@DiasAntes int,
@DiasDespues int,
@NumeroPerfiles int,
@UsuarioCreacion varchar(20),
@TieneCategoria bit,
@TieneCompraXcompra bit,
@TieneSubCampania bit
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

insert into ShowRoom.Evento
(CampaniaID, Nombre, Tema, DiasAntes, DiasDespues, NumeroPerfiles, 
FechaCreacion, UsuarioCreacion, FechaModificacion, UsuarioModificacion, 
Estado, TieneCategoria, TieneCompraXcompra, TieneSubCampania)
values
(@CampaniaID, @Nombre, @Tema, @DiasAntes, @DiasDespues, @NumeroPerfiles,
@FechaGeneral, @UsuarioCreacion, @FechaGeneral, @UsuarioCreacion, 
1, @TieneCategoria, @TieneCompraXcompra, @TieneSubCampania)

set @EventoID = @@IDENTITY

end

go

alter procedure ShowRoom.UpdateShowRoomEvento
@EventoID int,
@CampaniaID int,
@Nombre varchar(150),
@Tema varchar(150),
@DiasAntes int,
@DiasDespues int,
@NumeroPerfiles int,
@UsuarioModificacion varchar(20),
@Estado int,
@TieneCategoria bit,
@TieneCompraXcompra bit,
@TieneSubCampania bit
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

update ShowRoom.Evento
set
	CampaniaID = @CampaniaID,
	Nombre = @Nombre,
	Tema = @Tema,
	DiasAntes = @DiasAntes,
	DiasDespues = @DiasDespues,	
	NumeroPerfiles = @NumeroPerfiles,
	FechaModificacion = @FechaGeneral,
	UsuarioModificacion = @UsuarioModificacion,
	Estado = @Estado,
	TieneCategoria = @TieneCategoria,
	TieneCompraXcompra = @TieneCompraXcompra,
	TieneSubCampania = @TieneSubCampania
where EventoID = @EventoID

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[UpdStockOfertaShowRoomMasivo]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].UpdStockOfertaShowRoomMasivo
GO

go

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
	[PrecioValorizado] [decimal](18, 2) NULL,
	[PrecioOferta] [decimal](18, 2) NULL,	
	[UnidadesPermitidas] [int] NULL,
	[Descripcion] [varchar](250) NULL,
	[CodigoCategoria] [varchar](100) NULL,
	[TipNegocio] [varchar](500) NULL,
	[EsSubCampania] [bit] NULL	
)
GO

create procedure ShowRoom.UpdStockOfertaShowRoomMasivo
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
	TipNegocio = t.TipNegocio,
	PrecioValorizado = t.PrecioValorizado,
	EsSubCampania = t.EsSubCampania
FROM ShowRoom.OfertaShowRoom o
INNER JOIN ods.Campania c on 
	c.CampaniaID = o.CampaniaID
JOIN @StockPrecioOfertaShowRoom t ON 
	c.Codigo = t.CampaniaID
	AND o.CUV = t.CUV
	AND o.TipoOfertaSisID = t.TipoOfertaSisID

end

go

alter procedure ShowRoom.GetShowRoomOfertasConsultora
@CampaniaID int,
@CodigoConsultora varchar(20)
as
/*
ShowRoom.GetShowRoomOfertasConsultora 201706,'0012954'
ShowRoom.GetShowRoomOfertasConsultora 201706,'1615995'
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
o.OfertaShowRoomID,o.CampaniaID,o.CUV,o.TipoOfertaSisID,o.ConfiguracionOfertaID,o.Descripcion,
o.PrecioValorizado,
COALESCE(o.PrecioOferta,pc.PrecioCatalogo) AS PrecioOferta,
o.Stock,
o.StockInicial,o.ImagenProducto,o.UnidadesPermitidas,o.FlagHabilitarProducto,o.DescripcionLegal,o.UsuarioRegistro,
o.FechaRegistro,o.UsuarioModificacion,o.FechaModificacion,o.ImagenMini,pc.MarcaID, pos.Orden, o.CodigoCategoria, o.TipNegocio,
pc.CodigoProducto, cat.Descripcion as DescripcionCategoria, o.EsSubCampania
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

go

alter procedure ShowRoom.GetProductosShowRoom
@CampaniaID int
as
/*
ShowRoom.GetProductosShowRoom 201707
*/
begin

declare @ConfiguracionOfertaID int = 0
select @ConfiguracionOfertaID=ConfiguracionOfertaID from ConfiguracionOferta where TipoOfertaSisID = 1707

select 
	ISNULL(OS.OfertaShowRoomID,0) OfertaShowRoomID,
	ROW_NUMBER() OVER (ORDER BY (SELECT 1)) as NroOrden,
	PC.CampaniaID,
	CA.Codigo as CodigoCampania,
	PC.CUV,
	PC.CodigoTipoOferta,
	ISNULL(OS.Descripcion,PC.Descripcion) as Descripcion,
	COALESCE(OS.PrecioValorizado,PC.PrecioValorizado) as PrecioValorizado,
	COALESCE(OS.PrecioOferta,PC.PrecioCatalogo) as PrecioOferta,
	ISNULL(OS.Stock,0) Stock,
	ISNULL(OS.StockInicial,0) StockInicial,
	ISNULL(OS.ImagenProducto,'') ImagenProducto,
	ISNULL(OS.UnidadesPermitidas,'') UnidadesPermitidas,
	ISNULL(OS.FlagHabilitarProducto,0) FlagHabilitarProducto,
	OS.Orden,
	PC.CodigoProducto,
	ISNULL(OS.DescripcionLegal,'') DescripcionLegal,
	ISNULL(OS.ImagenMini,'') ImagenMini,
	@ConfiguracionOfertaID as ConfiguracionOfertaID,
	ISNULL(OS.EsSubCampania,0) as EsSubCampania
FROM ods.ProductoComercial PC WITH (NOLOCK)
INNER JOIN ods.Campania CA WITH (NOLOCK) ON 
	CA.CampaniaID = PC.CampaniaID
LEFT JOIN ShowRoom.OfertaShowRoom OS WITH(NOLOCK) ON 
	OS.CUV = PC.CUV 
	AND OS.CampaniaID = PC.CampaniaID
WHERE 
	PC.CodigoTipoOferta in (
		select Codigo from ShowRoom.TipoOferta where Activo = 1
	)
	AND CA.Codigo = @CampaniaID
union all
select 
	ISNULL(OS.OfertaShowRoomID,0) OfertaShowRoomID,
	ROW_NUMBER() OVER (ORDER BY (SELECT 1)) as NroOrden,
	PC.CampaniaID,
	CA.Codigo as CodigoCampania,
	PC.CUV,
	PC.CodigoTipoOferta,
	ISNULL(OS.Descripcion,PC.Descripcion) as Descripcion,
	COALESCE(OS.PrecioValorizado,PC.PrecioValorizado) as PrecioValorizado,
	COALESCE(OS.PrecioOferta,PC.PrecioCatalogo) as PrecioOferta,
	ISNULL(OS.Stock,0) Stock,
	ISNULL(OS.StockInicial,0) StockInicial,
	ISNULL(OS.ImagenProducto,'') ImagenProducto,
	ISNULL(OS.UnidadesPermitidas,'') UnidadesPermitidas,
	ISNULL(OS.FlagHabilitarProducto,0) FlagHabilitarProducto,
	OS.Orden,
	PC.CodigoProducto,
	ISNULL(OS.DescripcionLegal,'') DescripcionLegal,
	ISNULL(OS.ImagenMini,'') ImagenMini,
	@ConfiguracionOfertaID as ConfiguracionOfertaID,
	ISNULL(OS.EsSubCampania,0) as EsSubCampania
FROM ods.ProductoComercial PC WITH (NOLOCK)
INNER JOIN ods.Campania CA WITH (NOLOCK) ON 
	CA.CampaniaID = PC.CampaniaID
INNER JOIN ShowRoom.OfertaShowRoom OS WITH(NOLOCK) ON 
	OS.CUV = PC.CUV 
	AND OS.CampaniaID = PC.CampaniaID
WHERE 
	PC.CodigoTipoOferta not in (
		select Codigo from ShowRoom.TipoOferta where Activo = 1
	)
	AND CA.Codigo = @CampaniaID
ORDER BY CUV desc

end

go

ALTER PROCEDURE ShowRoom.InsOfertaShowRoom
(	
	@CampaniaID int,
	@CUV varchar(20),
	@TipoOfertaSisID int,
	@ConfiguracionOfertaID int,
	@Descripcion varchar(250),
	@PrecioValorizado numeric(12,2),
	@ImagenProducto varchar(150),
	@Orden int,
	@UnidadesPermitidas int,
	@FlagHabilitarProducto int,
	@DescripcionLegal varchar(250),
	@UsuarioRegistro varchar(50),
	@ImagenMini varchar(150),
	@PrecioOferta decimal(12,2)=0,
	@EsSubCampania bit
)
AS
BEGIN
	INSERT INTO ShowRoom.OfertaShowRoom
	(
		CampaniaID, CUV, TipoOfertaSisID, ConfiguracionOfertaID, Descripcion, PrecioValorizado, Stock, StockInicial, ImagenProducto,
		Orden, UnidadesPermitidas, FlagHabilitarProducto, DescripcionLegal, UsuarioRegistro, FechaRegistro, ImagenMini, PrecioOferta,
		EsSubCampania
	)
	VALUES
	(
		@CampaniaID, @CUV, @TipoOfertaSisID, @ConfiguracionOfertaID, @Descripcion, @PrecioValorizado , 0, 0, @ImagenProducto, 
		@Orden, @UnidadesPermitidas, @FlagHabilitarProducto, @DescripcionLegal, @UsuarioRegistro, getdate(), @ImagenMini, @PrecioOferta,
		@EsSubCampania
	)
END

go

ALTER PROCEDURE ShowRoom.UpdOfertaShowRoom
(
	@TipoOfertaSisID int,
	@CampaniaID int,
	@CUV varchar(20),
	@Descripcion varchar(250),
	@ImagenProducto varchar(150),
	@UnidadesPermitidas int,
	@FlagHabilitarProducto int,
	@Orden int,
	@DescripcionLegal varchar(250),
	@UsuarioModificacion varchar(50),
	@PrecioValorizado decimal(18,2),
	@ImagenMini varchar(150),
	@Incrementa int,
	@CantidadIncrementa int,
	@FlagAgotado int,
	@PrecioOferta decimal(18,2)=0,
	@EsSubCampania bit
)
AS
BEGIN
	UPDATE ShowRoom.OfertaShowRoom
		SET Descripcion = @Descripcion,
			UnidadesPermitidas = @UnidadesPermitidas,
			FlagHabilitarProducto = @FlagHabilitarProducto,
			Orden = @Orden,
			ImagenProducto = @ImagenProducto,
			DescripcionLegal = @DescripcionLegal,
			UsuarioModificacion = @UsuarioModificacion,
			PrecioValorizado = @PrecioValorizado,
			FechaModificacion = getdate(),
			ImagenMini = @ImagenMini,
			Stock = (CASE WHEN @Incrementa = 0 AND @FlagAgotado = 0 THEN Stock + @CantidadIncrementa 
							WHEN @Incrementa = 1 AND @FlagAgotado = 0 THEN Stock - @CantidadIncrementa 
							WHEN @FlagAgotado = 1 THEN 0 END),
			StockInicial = (CASE WHEN @Incrementa = 0 THEN StockInicial + @CantidadIncrementa 
							ELSE StockInicial - @CantidadIncrementa END),
			PrecioOferta = @PrecioOferta,
			EsSubCampania = @EsSubCampania
	where 	
	CampaniaID = @CampaniaID
		AND CUV = @CUV
END

go

ALTER PROCEDURE [ShowRoom].[GetShowRoomPerfilOfertaCuvs]
@EventoID int,
@PerfilID int,
@CampaniaID int
as
/*
ShowRoom.GetShowRoomPerfilOfertaCuvs 1,1,201611
ShowRoom.GetShowRoomPerfilOfertaCuvs 6,47,201707
*/
begin

select 
	isnull(p.PerfilOfertaShowRoomID,0) as PerfilOfertaShowRoomID,
	isnull(p.EventoID,0) as EventoID,
	isnull(p.PerfilID,0) as PerfilID,
	c.Codigo as CampaniaID,
	o.CUV,
	isnull(p.Orden,9999) as Orden,
	o.EsSubCampania
from ShowRoom.OfertaShowRoom o
inner join ods.Campania c on
	o.CampaniaID = c.CampaniaID
left join ShowRoom.PerfilOfertaShowRoom p on
	p.CampaniaID = c.Codigo
	and o.CUV = p.CUV
	and p.PerfilID = @PerfilID
	and p.EventoID = @EventoID
where 
	c.Codigo = @CampaniaID
order by isnull(p.Orden,9999)

end

go

USE BelcorpCostaRica
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.Evento') and SYSCOLUMNS.NAME = N'TieneSubCampania') = 0
	ALTER TABLE ShowRoom.Evento ADD TieneSubCampania bit
go

update ShowRoom.Evento set TieneSubCampania = 0 where TieneSubCampania is null

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'EsSubCampania') = 0
	ALTER TABLE ShowRoom.OfertaShowRoom ADD EsSubCampania bit
go

update ShowRoom.OfertaShowRoom set EsSubCampania = 0 where EsSubCampania is null

go

alter procedure ShowRoom.GetShowRoomEventoByCampaniaID
@CampaniaID int
as
/*
ShowRoom.GetShowRoomEventoByCampaniaID 201707
*/
begin

select
	EventoID,
	CampaniaID,
	Nombre,
	Imagen1,
	Imagen2,
	Descuento,
	FechaCreacion,
	UsuarioCreacion,
	FechaModificacion,
	UsuarioModificacion,
	TextoEstrategia,
	OfertaEstrategia,
	Tema,
	DiasAntes,
	DiasDespues,
	NumeroPerfiles,
	ImagenCabeceraProducto,
	ImagenVentaSetPopup,
	ImagenVentaTagLateral,
	ImagenPestaniaShowRoom,
	Estado,
	RutaShowRoomPopup,
	RutaShowRoomBannerLateral,
	ImagenPreventaDigital,
	isnull(TieneCategoria,0) as TieneCategoria,
	isnull(TieneCompraXcompra,0) as TieneCompraXcompra,
	isnull(TieneSubCampania,0) as TieneSubCampania
from ShowRoom.Evento
where CampaniaID = @CampaniaID

end

go

alter procedure ShowRoom.InsertShowRoomEvento
@EventoID int output,
@CampaniaID int,
@Nombre varchar(150),
@Tema varchar(150),
@DiasAntes int,
@DiasDespues int,
@NumeroPerfiles int,
@UsuarioCreacion varchar(20),
@TieneCategoria bit,
@TieneCompraXcompra bit,
@TieneSubCampania bit
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

insert into ShowRoom.Evento
(CampaniaID, Nombre, Tema, DiasAntes, DiasDespues, NumeroPerfiles, 
FechaCreacion, UsuarioCreacion, FechaModificacion, UsuarioModificacion, 
Estado, TieneCategoria, TieneCompraXcompra, TieneSubCampania)
values
(@CampaniaID, @Nombre, @Tema, @DiasAntes, @DiasDespues, @NumeroPerfiles,
@FechaGeneral, @UsuarioCreacion, @FechaGeneral, @UsuarioCreacion, 
1, @TieneCategoria, @TieneCompraXcompra, @TieneSubCampania)

set @EventoID = @@IDENTITY

end

go

alter procedure ShowRoom.UpdateShowRoomEvento
@EventoID int,
@CampaniaID int,
@Nombre varchar(150),
@Tema varchar(150),
@DiasAntes int,
@DiasDespues int,
@NumeroPerfiles int,
@UsuarioModificacion varchar(20),
@Estado int,
@TieneCategoria bit,
@TieneCompraXcompra bit,
@TieneSubCampania bit
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

update ShowRoom.Evento
set
	CampaniaID = @CampaniaID,
	Nombre = @Nombre,
	Tema = @Tema,
	DiasAntes = @DiasAntes,
	DiasDespues = @DiasDespues,	
	NumeroPerfiles = @NumeroPerfiles,
	FechaModificacion = @FechaGeneral,
	UsuarioModificacion = @UsuarioModificacion,
	Estado = @Estado,
	TieneCategoria = @TieneCategoria,
	TieneCompraXcompra = @TieneCompraXcompra,
	TieneSubCampania = @TieneSubCampania
where EventoID = @EventoID

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[UpdStockOfertaShowRoomMasivo]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].UpdStockOfertaShowRoomMasivo
GO

go

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
	[PrecioValorizado] [decimal](18, 2) NULL,
	[PrecioOferta] [decimal](18, 2) NULL,	
	[UnidadesPermitidas] [int] NULL,
	[Descripcion] [varchar](250) NULL,
	[CodigoCategoria] [varchar](100) NULL,
	[TipNegocio] [varchar](500) NULL,
	[EsSubCampania] [bit] NULL	
)
GO

create procedure ShowRoom.UpdStockOfertaShowRoomMasivo
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
	TipNegocio = t.TipNegocio,
	PrecioValorizado = t.PrecioValorizado,
	EsSubCampania = t.EsSubCampania
FROM ShowRoom.OfertaShowRoom o
INNER JOIN ods.Campania c on 
	c.CampaniaID = o.CampaniaID
JOIN @StockPrecioOfertaShowRoom t ON 
	c.Codigo = t.CampaniaID
	AND o.CUV = t.CUV
	AND o.TipoOfertaSisID = t.TipoOfertaSisID

end

go

alter procedure ShowRoom.GetShowRoomOfertasConsultora
@CampaniaID int,
@CodigoConsultora varchar(20)
as
/*
ShowRoom.GetShowRoomOfertasConsultora 201706,'0012954'
ShowRoom.GetShowRoomOfertasConsultora 201706,'1615995'
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
o.OfertaShowRoomID,o.CampaniaID,o.CUV,o.TipoOfertaSisID,o.ConfiguracionOfertaID,o.Descripcion,
o.PrecioValorizado,
COALESCE(o.PrecioOferta,pc.PrecioCatalogo) AS PrecioOferta,
o.Stock,
o.StockInicial,o.ImagenProducto,o.UnidadesPermitidas,o.FlagHabilitarProducto,o.DescripcionLegal,o.UsuarioRegistro,
o.FechaRegistro,o.UsuarioModificacion,o.FechaModificacion,o.ImagenMini,pc.MarcaID, pos.Orden, o.CodigoCategoria, o.TipNegocio,
pc.CodigoProducto, cat.Descripcion as DescripcionCategoria, o.EsSubCampania
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

go

alter procedure ShowRoom.GetProductosShowRoom
@CampaniaID int
as
/*
ShowRoom.GetProductosShowRoom 201707
*/
begin

declare @ConfiguracionOfertaID int = 0
select @ConfiguracionOfertaID=ConfiguracionOfertaID from ConfiguracionOferta where TipoOfertaSisID = 1707

select 
	ISNULL(OS.OfertaShowRoomID,0) OfertaShowRoomID,
	ROW_NUMBER() OVER (ORDER BY (SELECT 1)) as NroOrden,
	PC.CampaniaID,
	CA.Codigo as CodigoCampania,
	PC.CUV,
	PC.CodigoTipoOferta,
	ISNULL(OS.Descripcion,PC.Descripcion) as Descripcion,
	COALESCE(OS.PrecioValorizado,PC.PrecioValorizado) as PrecioValorizado,
	COALESCE(OS.PrecioOferta,PC.PrecioCatalogo) as PrecioOferta,
	ISNULL(OS.Stock,0) Stock,
	ISNULL(OS.StockInicial,0) StockInicial,
	ISNULL(OS.ImagenProducto,'') ImagenProducto,
	ISNULL(OS.UnidadesPermitidas,'') UnidadesPermitidas,
	ISNULL(OS.FlagHabilitarProducto,0) FlagHabilitarProducto,
	OS.Orden,
	PC.CodigoProducto,
	ISNULL(OS.DescripcionLegal,'') DescripcionLegal,
	ISNULL(OS.ImagenMini,'') ImagenMini,
	@ConfiguracionOfertaID as ConfiguracionOfertaID,
	ISNULL(OS.EsSubCampania,0) as EsSubCampania
FROM ods.ProductoComercial PC WITH (NOLOCK)
INNER JOIN ods.Campania CA WITH (NOLOCK) ON 
	CA.CampaniaID = PC.CampaniaID
LEFT JOIN ShowRoom.OfertaShowRoom OS WITH(NOLOCK) ON 
	OS.CUV = PC.CUV 
	AND OS.CampaniaID = PC.CampaniaID
WHERE 
	PC.CodigoTipoOferta in (
		select Codigo from ShowRoom.TipoOferta where Activo = 1
	)
	AND CA.Codigo = @CampaniaID
union all
select 
	ISNULL(OS.OfertaShowRoomID,0) OfertaShowRoomID,
	ROW_NUMBER() OVER (ORDER BY (SELECT 1)) as NroOrden,
	PC.CampaniaID,
	CA.Codigo as CodigoCampania,
	PC.CUV,
	PC.CodigoTipoOferta,
	ISNULL(OS.Descripcion,PC.Descripcion) as Descripcion,
	COALESCE(OS.PrecioValorizado,PC.PrecioValorizado) as PrecioValorizado,
	COALESCE(OS.PrecioOferta,PC.PrecioCatalogo) as PrecioOferta,
	ISNULL(OS.Stock,0) Stock,
	ISNULL(OS.StockInicial,0) StockInicial,
	ISNULL(OS.ImagenProducto,'') ImagenProducto,
	ISNULL(OS.UnidadesPermitidas,'') UnidadesPermitidas,
	ISNULL(OS.FlagHabilitarProducto,0) FlagHabilitarProducto,
	OS.Orden,
	PC.CodigoProducto,
	ISNULL(OS.DescripcionLegal,'') DescripcionLegal,
	ISNULL(OS.ImagenMini,'') ImagenMini,
	@ConfiguracionOfertaID as ConfiguracionOfertaID,
	ISNULL(OS.EsSubCampania,0) as EsSubCampania
FROM ods.ProductoComercial PC WITH (NOLOCK)
INNER JOIN ods.Campania CA WITH (NOLOCK) ON 
	CA.CampaniaID = PC.CampaniaID
INNER JOIN ShowRoom.OfertaShowRoom OS WITH(NOLOCK) ON 
	OS.CUV = PC.CUV 
	AND OS.CampaniaID = PC.CampaniaID
WHERE 
	PC.CodigoTipoOferta not in (
		select Codigo from ShowRoom.TipoOferta where Activo = 1
	)
	AND CA.Codigo = @CampaniaID
ORDER BY CUV desc

end

go

ALTER PROCEDURE ShowRoom.InsOfertaShowRoom
(	
	@CampaniaID int,
	@CUV varchar(20),
	@TipoOfertaSisID int,
	@ConfiguracionOfertaID int,
	@Descripcion varchar(250),
	@PrecioValorizado numeric(12,2),
	@ImagenProducto varchar(150),
	@Orden int,
	@UnidadesPermitidas int,
	@FlagHabilitarProducto int,
	@DescripcionLegal varchar(250),
	@UsuarioRegistro varchar(50),
	@ImagenMini varchar(150),
	@PrecioOferta decimal(12,2)=0,
	@EsSubCampania bit
)
AS
BEGIN
	INSERT INTO ShowRoom.OfertaShowRoom
	(
		CampaniaID, CUV, TipoOfertaSisID, ConfiguracionOfertaID, Descripcion, PrecioValorizado, Stock, StockInicial, ImagenProducto,
		Orden, UnidadesPermitidas, FlagHabilitarProducto, DescripcionLegal, UsuarioRegistro, FechaRegistro, ImagenMini, PrecioOferta,
		EsSubCampania
	)
	VALUES
	(
		@CampaniaID, @CUV, @TipoOfertaSisID, @ConfiguracionOfertaID, @Descripcion, @PrecioValorizado , 0, 0, @ImagenProducto, 
		@Orden, @UnidadesPermitidas, @FlagHabilitarProducto, @DescripcionLegal, @UsuarioRegistro, getdate(), @ImagenMini, @PrecioOferta,
		@EsSubCampania
	)
END

go

ALTER PROCEDURE ShowRoom.UpdOfertaShowRoom
(
	@TipoOfertaSisID int,
	@CampaniaID int,
	@CUV varchar(20),
	@Descripcion varchar(250),
	@ImagenProducto varchar(150),
	@UnidadesPermitidas int,
	@FlagHabilitarProducto int,
	@Orden int,
	@DescripcionLegal varchar(250),
	@UsuarioModificacion varchar(50),
	@PrecioValorizado decimal(18,2),
	@ImagenMini varchar(150),
	@Incrementa int,
	@CantidadIncrementa int,
	@FlagAgotado int,
	@PrecioOferta decimal(18,2)=0,
	@EsSubCampania bit
)
AS
BEGIN
	UPDATE ShowRoom.OfertaShowRoom
		SET Descripcion = @Descripcion,
			UnidadesPermitidas = @UnidadesPermitidas,
			FlagHabilitarProducto = @FlagHabilitarProducto,
			Orden = @Orden,
			ImagenProducto = @ImagenProducto,
			DescripcionLegal = @DescripcionLegal,
			UsuarioModificacion = @UsuarioModificacion,
			PrecioValorizado = @PrecioValorizado,
			FechaModificacion = getdate(),
			ImagenMini = @ImagenMini,
			Stock = (CASE WHEN @Incrementa = 0 AND @FlagAgotado = 0 THEN Stock + @CantidadIncrementa 
							WHEN @Incrementa = 1 AND @FlagAgotado = 0 THEN Stock - @CantidadIncrementa 
							WHEN @FlagAgotado = 1 THEN 0 END),
			StockInicial = (CASE WHEN @Incrementa = 0 THEN StockInicial + @CantidadIncrementa 
							ELSE StockInicial - @CantidadIncrementa END),
			PrecioOferta = @PrecioOferta,
			EsSubCampania = @EsSubCampania
	where 	
	CampaniaID = @CampaniaID
		AND CUV = @CUV
END

go

ALTER PROCEDURE [ShowRoom].[GetShowRoomPerfilOfertaCuvs]
@EventoID int,
@PerfilID int,
@CampaniaID int
as
/*
ShowRoom.GetShowRoomPerfilOfertaCuvs 1,1,201611
ShowRoom.GetShowRoomPerfilOfertaCuvs 6,47,201707
*/
begin

select 
	isnull(p.PerfilOfertaShowRoomID,0) as PerfilOfertaShowRoomID,
	isnull(p.EventoID,0) as EventoID,
	isnull(p.PerfilID,0) as PerfilID,
	c.Codigo as CampaniaID,
	o.CUV,
	isnull(p.Orden,9999) as Orden,
	o.EsSubCampania
from ShowRoom.OfertaShowRoom o
inner join ods.Campania c on
	o.CampaniaID = c.CampaniaID
left join ShowRoom.PerfilOfertaShowRoom p on
	p.CampaniaID = c.Codigo
	and o.CUV = p.CUV
	and p.PerfilID = @PerfilID
	and p.EventoID = @EventoID
where 
	c.Codigo = @CampaniaID
order by isnull(p.Orden,9999)

end

go

USE BelcorpDominicana
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.Evento') and SYSCOLUMNS.NAME = N'TieneSubCampania') = 0
	ALTER TABLE ShowRoom.Evento ADD TieneSubCampania bit
go

update ShowRoom.Evento set TieneSubCampania = 0 where TieneSubCampania is null

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'EsSubCampania') = 0
	ALTER TABLE ShowRoom.OfertaShowRoom ADD EsSubCampania bit
go

update ShowRoom.OfertaShowRoom set EsSubCampania = 0 where EsSubCampania is null

go

alter procedure ShowRoom.GetShowRoomEventoByCampaniaID
@CampaniaID int
as
/*
ShowRoom.GetShowRoomEventoByCampaniaID 201707
*/
begin

select
	EventoID,
	CampaniaID,
	Nombre,
	Imagen1,
	Imagen2,
	Descuento,
	FechaCreacion,
	UsuarioCreacion,
	FechaModificacion,
	UsuarioModificacion,
	TextoEstrategia,
	OfertaEstrategia,
	Tema,
	DiasAntes,
	DiasDespues,
	NumeroPerfiles,
	ImagenCabeceraProducto,
	ImagenVentaSetPopup,
	ImagenVentaTagLateral,
	ImagenPestaniaShowRoom,
	Estado,
	RutaShowRoomPopup,
	RutaShowRoomBannerLateral,
	ImagenPreventaDigital,
	isnull(TieneCategoria,0) as TieneCategoria,
	isnull(TieneCompraXcompra,0) as TieneCompraXcompra,
	isnull(TieneSubCampania,0) as TieneSubCampania
from ShowRoom.Evento
where CampaniaID = @CampaniaID

end

go

alter procedure ShowRoom.InsertShowRoomEvento
@EventoID int output,
@CampaniaID int,
@Nombre varchar(150),
@Tema varchar(150),
@DiasAntes int,
@DiasDespues int,
@NumeroPerfiles int,
@UsuarioCreacion varchar(20),
@TieneCategoria bit,
@TieneCompraXcompra bit,
@TieneSubCampania bit
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

insert into ShowRoom.Evento
(CampaniaID, Nombre, Tema, DiasAntes, DiasDespues, NumeroPerfiles, 
FechaCreacion, UsuarioCreacion, FechaModificacion, UsuarioModificacion, 
Estado, TieneCategoria, TieneCompraXcompra, TieneSubCampania)
values
(@CampaniaID, @Nombre, @Tema, @DiasAntes, @DiasDespues, @NumeroPerfiles,
@FechaGeneral, @UsuarioCreacion, @FechaGeneral, @UsuarioCreacion, 
1, @TieneCategoria, @TieneCompraXcompra, @TieneSubCampania)

set @EventoID = @@IDENTITY

end

go

alter procedure ShowRoom.UpdateShowRoomEvento
@EventoID int,
@CampaniaID int,
@Nombre varchar(150),
@Tema varchar(150),
@DiasAntes int,
@DiasDespues int,
@NumeroPerfiles int,
@UsuarioModificacion varchar(20),
@Estado int,
@TieneCategoria bit,
@TieneCompraXcompra bit,
@TieneSubCampania bit
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

update ShowRoom.Evento
set
	CampaniaID = @CampaniaID,
	Nombre = @Nombre,
	Tema = @Tema,
	DiasAntes = @DiasAntes,
	DiasDespues = @DiasDespues,	
	NumeroPerfiles = @NumeroPerfiles,
	FechaModificacion = @FechaGeneral,
	UsuarioModificacion = @UsuarioModificacion,
	Estado = @Estado,
	TieneCategoria = @TieneCategoria,
	TieneCompraXcompra = @TieneCompraXcompra,
	TieneSubCampania = @TieneSubCampania
where EventoID = @EventoID

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[UpdStockOfertaShowRoomMasivo]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].UpdStockOfertaShowRoomMasivo
GO

go

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
	[PrecioValorizado] [decimal](18, 2) NULL,
	[PrecioOferta] [decimal](18, 2) NULL,	
	[UnidadesPermitidas] [int] NULL,
	[Descripcion] [varchar](250) NULL,
	[CodigoCategoria] [varchar](100) NULL,
	[TipNegocio] [varchar](500) NULL,
	[EsSubCampania] [bit] NULL	
)
GO

create procedure ShowRoom.UpdStockOfertaShowRoomMasivo
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
	TipNegocio = t.TipNegocio,
	PrecioValorizado = t.PrecioValorizado,
	EsSubCampania = t.EsSubCampania
FROM ShowRoom.OfertaShowRoom o
INNER JOIN ods.Campania c on 
	c.CampaniaID = o.CampaniaID
JOIN @StockPrecioOfertaShowRoom t ON 
	c.Codigo = t.CampaniaID
	AND o.CUV = t.CUV
	AND o.TipoOfertaSisID = t.TipoOfertaSisID

end

go

alter procedure ShowRoom.GetShowRoomOfertasConsultora
@CampaniaID int,
@CodigoConsultora varchar(20)
as
/*
ShowRoom.GetShowRoomOfertasConsultora 201706,'0012954'
ShowRoom.GetShowRoomOfertasConsultora 201706,'1615995'
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
o.OfertaShowRoomID,o.CampaniaID,o.CUV,o.TipoOfertaSisID,o.ConfiguracionOfertaID,o.Descripcion,
o.PrecioValorizado,
COALESCE(o.PrecioOferta,pc.PrecioCatalogo) AS PrecioOferta,
o.Stock,
o.StockInicial,o.ImagenProducto,o.UnidadesPermitidas,o.FlagHabilitarProducto,o.DescripcionLegal,o.UsuarioRegistro,
o.FechaRegistro,o.UsuarioModificacion,o.FechaModificacion,o.ImagenMini,pc.MarcaID, pos.Orden, o.CodigoCategoria, o.TipNegocio,
pc.CodigoProducto, cat.Descripcion as DescripcionCategoria, o.EsSubCampania
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

go

alter procedure ShowRoom.GetProductosShowRoom
@CampaniaID int
as
/*
ShowRoom.GetProductosShowRoom 201707
*/
begin

declare @ConfiguracionOfertaID int = 0
select @ConfiguracionOfertaID=ConfiguracionOfertaID from ConfiguracionOferta where TipoOfertaSisID = 1707

select 
	ISNULL(OS.OfertaShowRoomID,0) OfertaShowRoomID,
	ROW_NUMBER() OVER (ORDER BY (SELECT 1)) as NroOrden,
	PC.CampaniaID,
	CA.Codigo as CodigoCampania,
	PC.CUV,
	PC.CodigoTipoOferta,
	ISNULL(OS.Descripcion,PC.Descripcion) as Descripcion,
	COALESCE(OS.PrecioValorizado,PC.PrecioValorizado) as PrecioValorizado,
	COALESCE(OS.PrecioOferta,PC.PrecioCatalogo) as PrecioOferta,
	ISNULL(OS.Stock,0) Stock,
	ISNULL(OS.StockInicial,0) StockInicial,
	ISNULL(OS.ImagenProducto,'') ImagenProducto,
	ISNULL(OS.UnidadesPermitidas,'') UnidadesPermitidas,
	ISNULL(OS.FlagHabilitarProducto,0) FlagHabilitarProducto,
	OS.Orden,
	PC.CodigoProducto,
	ISNULL(OS.DescripcionLegal,'') DescripcionLegal,
	ISNULL(OS.ImagenMini,'') ImagenMini,
	@ConfiguracionOfertaID as ConfiguracionOfertaID,
	ISNULL(OS.EsSubCampania,0) as EsSubCampania
FROM ods.ProductoComercial PC WITH (NOLOCK)
INNER JOIN ods.Campania CA WITH (NOLOCK) ON 
	CA.CampaniaID = PC.CampaniaID
LEFT JOIN ShowRoom.OfertaShowRoom OS WITH(NOLOCK) ON 
	OS.CUV = PC.CUV 
	AND OS.CampaniaID = PC.CampaniaID
WHERE 
	PC.CodigoTipoOferta in (
		select Codigo from ShowRoom.TipoOferta where Activo = 1
	)
	AND CA.Codigo = @CampaniaID
union all
select 
	ISNULL(OS.OfertaShowRoomID,0) OfertaShowRoomID,
	ROW_NUMBER() OVER (ORDER BY (SELECT 1)) as NroOrden,
	PC.CampaniaID,
	CA.Codigo as CodigoCampania,
	PC.CUV,
	PC.CodigoTipoOferta,
	ISNULL(OS.Descripcion,PC.Descripcion) as Descripcion,
	COALESCE(OS.PrecioValorizado,PC.PrecioValorizado) as PrecioValorizado,
	COALESCE(OS.PrecioOferta,PC.PrecioCatalogo) as PrecioOferta,
	ISNULL(OS.Stock,0) Stock,
	ISNULL(OS.StockInicial,0) StockInicial,
	ISNULL(OS.ImagenProducto,'') ImagenProducto,
	ISNULL(OS.UnidadesPermitidas,'') UnidadesPermitidas,
	ISNULL(OS.FlagHabilitarProducto,0) FlagHabilitarProducto,
	OS.Orden,
	PC.CodigoProducto,
	ISNULL(OS.DescripcionLegal,'') DescripcionLegal,
	ISNULL(OS.ImagenMini,'') ImagenMini,
	@ConfiguracionOfertaID as ConfiguracionOfertaID,
	ISNULL(OS.EsSubCampania,0) as EsSubCampania
FROM ods.ProductoComercial PC WITH (NOLOCK)
INNER JOIN ods.Campania CA WITH (NOLOCK) ON 
	CA.CampaniaID = PC.CampaniaID
INNER JOIN ShowRoom.OfertaShowRoom OS WITH(NOLOCK) ON 
	OS.CUV = PC.CUV 
	AND OS.CampaniaID = PC.CampaniaID
WHERE 
	PC.CodigoTipoOferta not in (
		select Codigo from ShowRoom.TipoOferta where Activo = 1
	)
	AND CA.Codigo = @CampaniaID
ORDER BY CUV desc

end

go

ALTER PROCEDURE ShowRoom.InsOfertaShowRoom
(	
	@CampaniaID int,
	@CUV varchar(20),
	@TipoOfertaSisID int,
	@ConfiguracionOfertaID int,
	@Descripcion varchar(250),
	@PrecioValorizado numeric(12,2),
	@ImagenProducto varchar(150),
	@Orden int,
	@UnidadesPermitidas int,
	@FlagHabilitarProducto int,
	@DescripcionLegal varchar(250),
	@UsuarioRegistro varchar(50),
	@ImagenMini varchar(150),
	@PrecioOferta decimal(12,2)=0,
	@EsSubCampania bit
)
AS
BEGIN
	INSERT INTO ShowRoom.OfertaShowRoom
	(
		CampaniaID, CUV, TipoOfertaSisID, ConfiguracionOfertaID, Descripcion, PrecioValorizado, Stock, StockInicial, ImagenProducto,
		Orden, UnidadesPermitidas, FlagHabilitarProducto, DescripcionLegal, UsuarioRegistro, FechaRegistro, ImagenMini, PrecioOferta,
		EsSubCampania
	)
	VALUES
	(
		@CampaniaID, @CUV, @TipoOfertaSisID, @ConfiguracionOfertaID, @Descripcion, @PrecioValorizado , 0, 0, @ImagenProducto, 
		@Orden, @UnidadesPermitidas, @FlagHabilitarProducto, @DescripcionLegal, @UsuarioRegistro, getdate(), @ImagenMini, @PrecioOferta,
		@EsSubCampania
	)
END

go

ALTER PROCEDURE ShowRoom.UpdOfertaShowRoom
(
	@TipoOfertaSisID int,
	@CampaniaID int,
	@CUV varchar(20),
	@Descripcion varchar(250),
	@ImagenProducto varchar(150),
	@UnidadesPermitidas int,
	@FlagHabilitarProducto int,
	@Orden int,
	@DescripcionLegal varchar(250),
	@UsuarioModificacion varchar(50),
	@PrecioValorizado decimal(18,2),
	@ImagenMini varchar(150),
	@Incrementa int,
	@CantidadIncrementa int,
	@FlagAgotado int,
	@PrecioOferta decimal(18,2)=0,
	@EsSubCampania bit
)
AS
BEGIN
	UPDATE ShowRoom.OfertaShowRoom
		SET Descripcion = @Descripcion,
			UnidadesPermitidas = @UnidadesPermitidas,
			FlagHabilitarProducto = @FlagHabilitarProducto,
			Orden = @Orden,
			ImagenProducto = @ImagenProducto,
			DescripcionLegal = @DescripcionLegal,
			UsuarioModificacion = @UsuarioModificacion,
			PrecioValorizado = @PrecioValorizado,
			FechaModificacion = getdate(),
			ImagenMini = @ImagenMini,
			Stock = (CASE WHEN @Incrementa = 0 AND @FlagAgotado = 0 THEN Stock + @CantidadIncrementa 
							WHEN @Incrementa = 1 AND @FlagAgotado = 0 THEN Stock - @CantidadIncrementa 
							WHEN @FlagAgotado = 1 THEN 0 END),
			StockInicial = (CASE WHEN @Incrementa = 0 THEN StockInicial + @CantidadIncrementa 
							ELSE StockInicial - @CantidadIncrementa END),
			PrecioOferta = @PrecioOferta,
			EsSubCampania = @EsSubCampania
	where 	
	CampaniaID = @CampaniaID
		AND CUV = @CUV
END

go

ALTER PROCEDURE [ShowRoom].[GetShowRoomPerfilOfertaCuvs]
@EventoID int,
@PerfilID int,
@CampaniaID int
as
/*
ShowRoom.GetShowRoomPerfilOfertaCuvs 1,1,201611
ShowRoom.GetShowRoomPerfilOfertaCuvs 6,47,201707
*/
begin

select 
	isnull(p.PerfilOfertaShowRoomID,0) as PerfilOfertaShowRoomID,
	isnull(p.EventoID,0) as EventoID,
	isnull(p.PerfilID,0) as PerfilID,
	c.Codigo as CampaniaID,
	o.CUV,
	isnull(p.Orden,9999) as Orden,
	o.EsSubCampania
from ShowRoom.OfertaShowRoom o
inner join ods.Campania c on
	o.CampaniaID = c.CampaniaID
left join ShowRoom.PerfilOfertaShowRoom p on
	p.CampaniaID = c.Codigo
	and o.CUV = p.CUV
	and p.PerfilID = @PerfilID
	and p.EventoID = @EventoID
where 
	c.Codigo = @CampaniaID
order by isnull(p.Orden,9999)

end

go

USE BelcorpEcuador
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.Evento') and SYSCOLUMNS.NAME = N'TieneSubCampania') = 0
	ALTER TABLE ShowRoom.Evento ADD TieneSubCampania bit
go

update ShowRoom.Evento set TieneSubCampania = 0 where TieneSubCampania is null

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'EsSubCampania') = 0
	ALTER TABLE ShowRoom.OfertaShowRoom ADD EsSubCampania bit
go

update ShowRoom.OfertaShowRoom set EsSubCampania = 0 where EsSubCampania is null

go

alter procedure ShowRoom.GetShowRoomEventoByCampaniaID
@CampaniaID int
as
/*
ShowRoom.GetShowRoomEventoByCampaniaID 201707
*/
begin

select
	EventoID,
	CampaniaID,
	Nombre,
	Imagen1,
	Imagen2,
	Descuento,
	FechaCreacion,
	UsuarioCreacion,
	FechaModificacion,
	UsuarioModificacion,
	TextoEstrategia,
	OfertaEstrategia,
	Tema,
	DiasAntes,
	DiasDespues,
	NumeroPerfiles,
	ImagenCabeceraProducto,
	ImagenVentaSetPopup,
	ImagenVentaTagLateral,
	ImagenPestaniaShowRoom,
	Estado,
	RutaShowRoomPopup,
	RutaShowRoomBannerLateral,
	ImagenPreventaDigital,
	isnull(TieneCategoria,0) as TieneCategoria,
	isnull(TieneCompraXcompra,0) as TieneCompraXcompra,
	isnull(TieneSubCampania,0) as TieneSubCampania
from ShowRoom.Evento
where CampaniaID = @CampaniaID

end

go

alter procedure ShowRoom.InsertShowRoomEvento
@EventoID int output,
@CampaniaID int,
@Nombre varchar(150),
@Tema varchar(150),
@DiasAntes int,
@DiasDespues int,
@NumeroPerfiles int,
@UsuarioCreacion varchar(20),
@TieneCategoria bit,
@TieneCompraXcompra bit,
@TieneSubCampania bit
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

insert into ShowRoom.Evento
(CampaniaID, Nombre, Tema, DiasAntes, DiasDespues, NumeroPerfiles, 
FechaCreacion, UsuarioCreacion, FechaModificacion, UsuarioModificacion, 
Estado, TieneCategoria, TieneCompraXcompra, TieneSubCampania)
values
(@CampaniaID, @Nombre, @Tema, @DiasAntes, @DiasDespues, @NumeroPerfiles,
@FechaGeneral, @UsuarioCreacion, @FechaGeneral, @UsuarioCreacion, 
1, @TieneCategoria, @TieneCompraXcompra, @TieneSubCampania)

set @EventoID = @@IDENTITY

end

go

alter procedure ShowRoom.UpdateShowRoomEvento
@EventoID int,
@CampaniaID int,
@Nombre varchar(150),
@Tema varchar(150),
@DiasAntes int,
@DiasDespues int,
@NumeroPerfiles int,
@UsuarioModificacion varchar(20),
@Estado int,
@TieneCategoria bit,
@TieneCompraXcompra bit,
@TieneSubCampania bit
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

update ShowRoom.Evento
set
	CampaniaID = @CampaniaID,
	Nombre = @Nombre,
	Tema = @Tema,
	DiasAntes = @DiasAntes,
	DiasDespues = @DiasDespues,	
	NumeroPerfiles = @NumeroPerfiles,
	FechaModificacion = @FechaGeneral,
	UsuarioModificacion = @UsuarioModificacion,
	Estado = @Estado,
	TieneCategoria = @TieneCategoria,
	TieneCompraXcompra = @TieneCompraXcompra,
	TieneSubCampania = @TieneSubCampania
where EventoID = @EventoID

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[UpdStockOfertaShowRoomMasivo]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].UpdStockOfertaShowRoomMasivo
GO

go

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
	[PrecioValorizado] [decimal](18, 2) NULL,
	[PrecioOferta] [decimal](18, 2) NULL,	
	[UnidadesPermitidas] [int] NULL,
	[Descripcion] [varchar](250) NULL,
	[CodigoCategoria] [varchar](100) NULL,
	[TipNegocio] [varchar](500) NULL,
	[EsSubCampania] [bit] NULL	
)
GO

create procedure ShowRoom.UpdStockOfertaShowRoomMasivo
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
	TipNegocio = t.TipNegocio,
	PrecioValorizado = t.PrecioValorizado,
	EsSubCampania = t.EsSubCampania
FROM ShowRoom.OfertaShowRoom o
INNER JOIN ods.Campania c on 
	c.CampaniaID = o.CampaniaID
JOIN @StockPrecioOfertaShowRoom t ON 
	c.Codigo = t.CampaniaID
	AND o.CUV = t.CUV
	AND o.TipoOfertaSisID = t.TipoOfertaSisID

end

go

alter procedure ShowRoom.GetShowRoomOfertasConsultora
@CampaniaID int,
@CodigoConsultora varchar(20)
as
/*
ShowRoom.GetShowRoomOfertasConsultora 201706,'0012954'
ShowRoom.GetShowRoomOfertasConsultora 201706,'1615995'
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
o.OfertaShowRoomID,o.CampaniaID,o.CUV,o.TipoOfertaSisID,o.ConfiguracionOfertaID,o.Descripcion,
o.PrecioValorizado,
COALESCE(o.PrecioOferta,pc.PrecioCatalogo) AS PrecioOferta,
o.Stock,
o.StockInicial,o.ImagenProducto,o.UnidadesPermitidas,o.FlagHabilitarProducto,o.DescripcionLegal,o.UsuarioRegistro,
o.FechaRegistro,o.UsuarioModificacion,o.FechaModificacion,o.ImagenMini,pc.MarcaID, pos.Orden, o.CodigoCategoria, o.TipNegocio,
pc.CodigoProducto, cat.Descripcion as DescripcionCategoria, o.EsSubCampania
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

go

alter procedure ShowRoom.GetProductosShowRoom
@CampaniaID int
as
/*
ShowRoom.GetProductosShowRoom 201707
*/
begin

declare @ConfiguracionOfertaID int = 0
select @ConfiguracionOfertaID=ConfiguracionOfertaID from ConfiguracionOferta where TipoOfertaSisID = 1707

select 
	ISNULL(OS.OfertaShowRoomID,0) OfertaShowRoomID,
	ROW_NUMBER() OVER (ORDER BY (SELECT 1)) as NroOrden,
	PC.CampaniaID,
	CA.Codigo as CodigoCampania,
	PC.CUV,
	PC.CodigoTipoOferta,
	ISNULL(OS.Descripcion,PC.Descripcion) as Descripcion,
	COALESCE(OS.PrecioValorizado,PC.PrecioValorizado) as PrecioValorizado,
	COALESCE(OS.PrecioOferta,PC.PrecioCatalogo) as PrecioOferta,
	ISNULL(OS.Stock,0) Stock,
	ISNULL(OS.StockInicial,0) StockInicial,
	ISNULL(OS.ImagenProducto,'') ImagenProducto,
	ISNULL(OS.UnidadesPermitidas,'') UnidadesPermitidas,
	ISNULL(OS.FlagHabilitarProducto,0) FlagHabilitarProducto,
	OS.Orden,
	PC.CodigoProducto,
	ISNULL(OS.DescripcionLegal,'') DescripcionLegal,
	ISNULL(OS.ImagenMini,'') ImagenMini,
	@ConfiguracionOfertaID as ConfiguracionOfertaID,
	ISNULL(OS.EsSubCampania,0) as EsSubCampania
FROM ods.ProductoComercial PC WITH (NOLOCK)
INNER JOIN ods.Campania CA WITH (NOLOCK) ON 
	CA.CampaniaID = PC.CampaniaID
LEFT JOIN ShowRoom.OfertaShowRoom OS WITH(NOLOCK) ON 
	OS.CUV = PC.CUV 
	AND OS.CampaniaID = PC.CampaniaID
WHERE 
	PC.CodigoTipoOferta in (
		select Codigo from ShowRoom.TipoOferta where Activo = 1
	)
	AND CA.Codigo = @CampaniaID
union all
select 
	ISNULL(OS.OfertaShowRoomID,0) OfertaShowRoomID,
	ROW_NUMBER() OVER (ORDER BY (SELECT 1)) as NroOrden,
	PC.CampaniaID,
	CA.Codigo as CodigoCampania,
	PC.CUV,
	PC.CodigoTipoOferta,
	ISNULL(OS.Descripcion,PC.Descripcion) as Descripcion,
	COALESCE(OS.PrecioValorizado,PC.PrecioValorizado) as PrecioValorizado,
	COALESCE(OS.PrecioOferta,PC.PrecioCatalogo) as PrecioOferta,
	ISNULL(OS.Stock,0) Stock,
	ISNULL(OS.StockInicial,0) StockInicial,
	ISNULL(OS.ImagenProducto,'') ImagenProducto,
	ISNULL(OS.UnidadesPermitidas,'') UnidadesPermitidas,
	ISNULL(OS.FlagHabilitarProducto,0) FlagHabilitarProducto,
	OS.Orden,
	PC.CodigoProducto,
	ISNULL(OS.DescripcionLegal,'') DescripcionLegal,
	ISNULL(OS.ImagenMini,'') ImagenMini,
	@ConfiguracionOfertaID as ConfiguracionOfertaID,
	ISNULL(OS.EsSubCampania,0) as EsSubCampania
FROM ods.ProductoComercial PC WITH (NOLOCK)
INNER JOIN ods.Campania CA WITH (NOLOCK) ON 
	CA.CampaniaID = PC.CampaniaID
INNER JOIN ShowRoom.OfertaShowRoom OS WITH(NOLOCK) ON 
	OS.CUV = PC.CUV 
	AND OS.CampaniaID = PC.CampaniaID
WHERE 
	PC.CodigoTipoOferta not in (
		select Codigo from ShowRoom.TipoOferta where Activo = 1
	)
	AND CA.Codigo = @CampaniaID
ORDER BY CUV desc

end

go

ALTER PROCEDURE ShowRoom.InsOfertaShowRoom
(	
	@CampaniaID int,
	@CUV varchar(20),
	@TipoOfertaSisID int,
	@ConfiguracionOfertaID int,
	@Descripcion varchar(250),
	@PrecioValorizado numeric(12,2),
	@ImagenProducto varchar(150),
	@Orden int,
	@UnidadesPermitidas int,
	@FlagHabilitarProducto int,
	@DescripcionLegal varchar(250),
	@UsuarioRegistro varchar(50),
	@ImagenMini varchar(150),
	@PrecioOferta decimal(12,2)=0,
	@EsSubCampania bit
)
AS
BEGIN
	INSERT INTO ShowRoom.OfertaShowRoom
	(
		CampaniaID, CUV, TipoOfertaSisID, ConfiguracionOfertaID, Descripcion, PrecioValorizado, Stock, StockInicial, ImagenProducto,
		Orden, UnidadesPermitidas, FlagHabilitarProducto, DescripcionLegal, UsuarioRegistro, FechaRegistro, ImagenMini, PrecioOferta,
		EsSubCampania
	)
	VALUES
	(
		@CampaniaID, @CUV, @TipoOfertaSisID, @ConfiguracionOfertaID, @Descripcion, @PrecioValorizado , 0, 0, @ImagenProducto, 
		@Orden, @UnidadesPermitidas, @FlagHabilitarProducto, @DescripcionLegal, @UsuarioRegistro, getdate(), @ImagenMini, @PrecioOferta,
		@EsSubCampania
	)
END

go

ALTER PROCEDURE ShowRoom.UpdOfertaShowRoom
(
	@TipoOfertaSisID int,
	@CampaniaID int,
	@CUV varchar(20),
	@Descripcion varchar(250),
	@ImagenProducto varchar(150),
	@UnidadesPermitidas int,
	@FlagHabilitarProducto int,
	@Orden int,
	@DescripcionLegal varchar(250),
	@UsuarioModificacion varchar(50),
	@PrecioValorizado decimal(18,2),
	@ImagenMini varchar(150),
	@Incrementa int,
	@CantidadIncrementa int,
	@FlagAgotado int,
	@PrecioOferta decimal(18,2)=0,
	@EsSubCampania bit
)
AS
BEGIN
	UPDATE ShowRoom.OfertaShowRoom
		SET Descripcion = @Descripcion,
			UnidadesPermitidas = @UnidadesPermitidas,
			FlagHabilitarProducto = @FlagHabilitarProducto,
			Orden = @Orden,
			ImagenProducto = @ImagenProducto,
			DescripcionLegal = @DescripcionLegal,
			UsuarioModificacion = @UsuarioModificacion,
			PrecioValorizado = @PrecioValorizado,
			FechaModificacion = getdate(),
			ImagenMini = @ImagenMini,
			Stock = (CASE WHEN @Incrementa = 0 AND @FlagAgotado = 0 THEN Stock + @CantidadIncrementa 
							WHEN @Incrementa = 1 AND @FlagAgotado = 0 THEN Stock - @CantidadIncrementa 
							WHEN @FlagAgotado = 1 THEN 0 END),
			StockInicial = (CASE WHEN @Incrementa = 0 THEN StockInicial + @CantidadIncrementa 
							ELSE StockInicial - @CantidadIncrementa END),
			PrecioOferta = @PrecioOferta,
			EsSubCampania = @EsSubCampania
	where 	
	CampaniaID = @CampaniaID
		AND CUV = @CUV
END

go

ALTER PROCEDURE [ShowRoom].[GetShowRoomPerfilOfertaCuvs]
@EventoID int,
@PerfilID int,
@CampaniaID int
as
/*
ShowRoom.GetShowRoomPerfilOfertaCuvs 1,1,201611
ShowRoom.GetShowRoomPerfilOfertaCuvs 6,47,201707
*/
begin

select 
	isnull(p.PerfilOfertaShowRoomID,0) as PerfilOfertaShowRoomID,
	isnull(p.EventoID,0) as EventoID,
	isnull(p.PerfilID,0) as PerfilID,
	c.Codigo as CampaniaID,
	o.CUV,
	isnull(p.Orden,9999) as Orden,
	o.EsSubCampania
from ShowRoom.OfertaShowRoom o
inner join ods.Campania c on
	o.CampaniaID = c.CampaniaID
left join ShowRoom.PerfilOfertaShowRoom p on
	p.CampaniaID = c.Codigo
	and o.CUV = p.CUV
	and p.PerfilID = @PerfilID
	and p.EventoID = @EventoID
where 
	c.Codigo = @CampaniaID
order by isnull(p.Orden,9999)

end

go

USE BelcorpGuatemala
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.Evento') and SYSCOLUMNS.NAME = N'TieneSubCampania') = 0
	ALTER TABLE ShowRoom.Evento ADD TieneSubCampania bit
go

update ShowRoom.Evento set TieneSubCampania = 0 where TieneSubCampania is null

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'EsSubCampania') = 0
	ALTER TABLE ShowRoom.OfertaShowRoom ADD EsSubCampania bit
go

update ShowRoom.OfertaShowRoom set EsSubCampania = 0 where EsSubCampania is null

go

alter procedure ShowRoom.GetShowRoomEventoByCampaniaID
@CampaniaID int
as
/*
ShowRoom.GetShowRoomEventoByCampaniaID 201707
*/
begin

select
	EventoID,
	CampaniaID,
	Nombre,
	Imagen1,
	Imagen2,
	Descuento,
	FechaCreacion,
	UsuarioCreacion,
	FechaModificacion,
	UsuarioModificacion,
	TextoEstrategia,
	OfertaEstrategia,
	Tema,
	DiasAntes,
	DiasDespues,
	NumeroPerfiles,
	ImagenCabeceraProducto,
	ImagenVentaSetPopup,
	ImagenVentaTagLateral,
	ImagenPestaniaShowRoom,
	Estado,
	RutaShowRoomPopup,
	RutaShowRoomBannerLateral,
	ImagenPreventaDigital,
	isnull(TieneCategoria,0) as TieneCategoria,
	isnull(TieneCompraXcompra,0) as TieneCompraXcompra,
	isnull(TieneSubCampania,0) as TieneSubCampania
from ShowRoom.Evento
where CampaniaID = @CampaniaID

end

go

alter procedure ShowRoom.InsertShowRoomEvento
@EventoID int output,
@CampaniaID int,
@Nombre varchar(150),
@Tema varchar(150),
@DiasAntes int,
@DiasDespues int,
@NumeroPerfiles int,
@UsuarioCreacion varchar(20),
@TieneCategoria bit,
@TieneCompraXcompra bit,
@TieneSubCampania bit
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

insert into ShowRoom.Evento
(CampaniaID, Nombre, Tema, DiasAntes, DiasDespues, NumeroPerfiles, 
FechaCreacion, UsuarioCreacion, FechaModificacion, UsuarioModificacion, 
Estado, TieneCategoria, TieneCompraXcompra, TieneSubCampania)
values
(@CampaniaID, @Nombre, @Tema, @DiasAntes, @DiasDespues, @NumeroPerfiles,
@FechaGeneral, @UsuarioCreacion, @FechaGeneral, @UsuarioCreacion, 
1, @TieneCategoria, @TieneCompraXcompra, @TieneSubCampania)

set @EventoID = @@IDENTITY

end

go

alter procedure ShowRoom.UpdateShowRoomEvento
@EventoID int,
@CampaniaID int,
@Nombre varchar(150),
@Tema varchar(150),
@DiasAntes int,
@DiasDespues int,
@NumeroPerfiles int,
@UsuarioModificacion varchar(20),
@Estado int,
@TieneCategoria bit,
@TieneCompraXcompra bit,
@TieneSubCampania bit
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

update ShowRoom.Evento
set
	CampaniaID = @CampaniaID,
	Nombre = @Nombre,
	Tema = @Tema,
	DiasAntes = @DiasAntes,
	DiasDespues = @DiasDespues,	
	NumeroPerfiles = @NumeroPerfiles,
	FechaModificacion = @FechaGeneral,
	UsuarioModificacion = @UsuarioModificacion,
	Estado = @Estado,
	TieneCategoria = @TieneCategoria,
	TieneCompraXcompra = @TieneCompraXcompra,
	TieneSubCampania = @TieneSubCampania
where EventoID = @EventoID

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[UpdStockOfertaShowRoomMasivo]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].UpdStockOfertaShowRoomMasivo
GO

go

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
	[PrecioValorizado] [decimal](18, 2) NULL,
	[PrecioOferta] [decimal](18, 2) NULL,	
	[UnidadesPermitidas] [int] NULL,
	[Descripcion] [varchar](250) NULL,
	[CodigoCategoria] [varchar](100) NULL,
	[TipNegocio] [varchar](500) NULL,
	[EsSubCampania] [bit] NULL	
)
GO

create procedure ShowRoom.UpdStockOfertaShowRoomMasivo
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
	TipNegocio = t.TipNegocio,
	PrecioValorizado = t.PrecioValorizado,
	EsSubCampania = t.EsSubCampania
FROM ShowRoom.OfertaShowRoom o
INNER JOIN ods.Campania c on 
	c.CampaniaID = o.CampaniaID
JOIN @StockPrecioOfertaShowRoom t ON 
	c.Codigo = t.CampaniaID
	AND o.CUV = t.CUV
	AND o.TipoOfertaSisID = t.TipoOfertaSisID

end

go

alter procedure ShowRoom.GetShowRoomOfertasConsultora
@CampaniaID int,
@CodigoConsultora varchar(20)
as
/*
ShowRoom.GetShowRoomOfertasConsultora 201706,'0012954'
ShowRoom.GetShowRoomOfertasConsultora 201706,'1615995'
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
o.OfertaShowRoomID,o.CampaniaID,o.CUV,o.TipoOfertaSisID,o.ConfiguracionOfertaID,o.Descripcion,
o.PrecioValorizado,
COALESCE(o.PrecioOferta,pc.PrecioCatalogo) AS PrecioOferta,
o.Stock,
o.StockInicial,o.ImagenProducto,o.UnidadesPermitidas,o.FlagHabilitarProducto,o.DescripcionLegal,o.UsuarioRegistro,
o.FechaRegistro,o.UsuarioModificacion,o.FechaModificacion,o.ImagenMini,pc.MarcaID, pos.Orden, o.CodigoCategoria, o.TipNegocio,
pc.CodigoProducto, cat.Descripcion as DescripcionCategoria, o.EsSubCampania
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

go

alter procedure ShowRoom.GetProductosShowRoom
@CampaniaID int
as
/*
ShowRoom.GetProductosShowRoom 201707
*/
begin

declare @ConfiguracionOfertaID int = 0
select @ConfiguracionOfertaID=ConfiguracionOfertaID from ConfiguracionOferta where TipoOfertaSisID = 1707

select 
	ISNULL(OS.OfertaShowRoomID,0) OfertaShowRoomID,
	ROW_NUMBER() OVER (ORDER BY (SELECT 1)) as NroOrden,
	PC.CampaniaID,
	CA.Codigo as CodigoCampania,
	PC.CUV,
	PC.CodigoTipoOferta,
	ISNULL(OS.Descripcion,PC.Descripcion) as Descripcion,
	COALESCE(OS.PrecioValorizado,PC.PrecioValorizado) as PrecioValorizado,
	COALESCE(OS.PrecioOferta,PC.PrecioCatalogo) as PrecioOferta,
	ISNULL(OS.Stock,0) Stock,
	ISNULL(OS.StockInicial,0) StockInicial,
	ISNULL(OS.ImagenProducto,'') ImagenProducto,
	ISNULL(OS.UnidadesPermitidas,'') UnidadesPermitidas,
	ISNULL(OS.FlagHabilitarProducto,0) FlagHabilitarProducto,
	OS.Orden,
	PC.CodigoProducto,
	ISNULL(OS.DescripcionLegal,'') DescripcionLegal,
	ISNULL(OS.ImagenMini,'') ImagenMini,
	@ConfiguracionOfertaID as ConfiguracionOfertaID,
	ISNULL(OS.EsSubCampania,0) as EsSubCampania
FROM ods.ProductoComercial PC WITH (NOLOCK)
INNER JOIN ods.Campania CA WITH (NOLOCK) ON 
	CA.CampaniaID = PC.CampaniaID
LEFT JOIN ShowRoom.OfertaShowRoom OS WITH(NOLOCK) ON 
	OS.CUV = PC.CUV 
	AND OS.CampaniaID = PC.CampaniaID
WHERE 
	PC.CodigoTipoOferta in (
		select Codigo from ShowRoom.TipoOferta where Activo = 1
	)
	AND CA.Codigo = @CampaniaID
union all
select 
	ISNULL(OS.OfertaShowRoomID,0) OfertaShowRoomID,
	ROW_NUMBER() OVER (ORDER BY (SELECT 1)) as NroOrden,
	PC.CampaniaID,
	CA.Codigo as CodigoCampania,
	PC.CUV,
	PC.CodigoTipoOferta,
	ISNULL(OS.Descripcion,PC.Descripcion) as Descripcion,
	COALESCE(OS.PrecioValorizado,PC.PrecioValorizado) as PrecioValorizado,
	COALESCE(OS.PrecioOferta,PC.PrecioCatalogo) as PrecioOferta,
	ISNULL(OS.Stock,0) Stock,
	ISNULL(OS.StockInicial,0) StockInicial,
	ISNULL(OS.ImagenProducto,'') ImagenProducto,
	ISNULL(OS.UnidadesPermitidas,'') UnidadesPermitidas,
	ISNULL(OS.FlagHabilitarProducto,0) FlagHabilitarProducto,
	OS.Orden,
	PC.CodigoProducto,
	ISNULL(OS.DescripcionLegal,'') DescripcionLegal,
	ISNULL(OS.ImagenMini,'') ImagenMini,
	@ConfiguracionOfertaID as ConfiguracionOfertaID,
	ISNULL(OS.EsSubCampania,0) as EsSubCampania
FROM ods.ProductoComercial PC WITH (NOLOCK)
INNER JOIN ods.Campania CA WITH (NOLOCK) ON 
	CA.CampaniaID = PC.CampaniaID
INNER JOIN ShowRoom.OfertaShowRoom OS WITH(NOLOCK) ON 
	OS.CUV = PC.CUV 
	AND OS.CampaniaID = PC.CampaniaID
WHERE 
	PC.CodigoTipoOferta not in (
		select Codigo from ShowRoom.TipoOferta where Activo = 1
	)
	AND CA.Codigo = @CampaniaID
ORDER BY CUV desc

end

go

ALTER PROCEDURE ShowRoom.InsOfertaShowRoom
(	
	@CampaniaID int,
	@CUV varchar(20),
	@TipoOfertaSisID int,
	@ConfiguracionOfertaID int,
	@Descripcion varchar(250),
	@PrecioValorizado numeric(12,2),
	@ImagenProducto varchar(150),
	@Orden int,
	@UnidadesPermitidas int,
	@FlagHabilitarProducto int,
	@DescripcionLegal varchar(250),
	@UsuarioRegistro varchar(50),
	@ImagenMini varchar(150),
	@PrecioOferta decimal(12,2)=0,
	@EsSubCampania bit
)
AS
BEGIN
	INSERT INTO ShowRoom.OfertaShowRoom
	(
		CampaniaID, CUV, TipoOfertaSisID, ConfiguracionOfertaID, Descripcion, PrecioValorizado, Stock, StockInicial, ImagenProducto,
		Orden, UnidadesPermitidas, FlagHabilitarProducto, DescripcionLegal, UsuarioRegistro, FechaRegistro, ImagenMini, PrecioOferta,
		EsSubCampania
	)
	VALUES
	(
		@CampaniaID, @CUV, @TipoOfertaSisID, @ConfiguracionOfertaID, @Descripcion, @PrecioValorizado , 0, 0, @ImagenProducto, 
		@Orden, @UnidadesPermitidas, @FlagHabilitarProducto, @DescripcionLegal, @UsuarioRegistro, getdate(), @ImagenMini, @PrecioOferta,
		@EsSubCampania
	)
END

go

ALTER PROCEDURE ShowRoom.UpdOfertaShowRoom
(
	@TipoOfertaSisID int,
	@CampaniaID int,
	@CUV varchar(20),
	@Descripcion varchar(250),
	@ImagenProducto varchar(150),
	@UnidadesPermitidas int,
	@FlagHabilitarProducto int,
	@Orden int,
	@DescripcionLegal varchar(250),
	@UsuarioModificacion varchar(50),
	@PrecioValorizado decimal(18,2),
	@ImagenMini varchar(150),
	@Incrementa int,
	@CantidadIncrementa int,
	@FlagAgotado int,
	@PrecioOferta decimal(18,2)=0,
	@EsSubCampania bit
)
AS
BEGIN
	UPDATE ShowRoom.OfertaShowRoom
		SET Descripcion = @Descripcion,
			UnidadesPermitidas = @UnidadesPermitidas,
			FlagHabilitarProducto = @FlagHabilitarProducto,
			Orden = @Orden,
			ImagenProducto = @ImagenProducto,
			DescripcionLegal = @DescripcionLegal,
			UsuarioModificacion = @UsuarioModificacion,
			PrecioValorizado = @PrecioValorizado,
			FechaModificacion = getdate(),
			ImagenMini = @ImagenMini,
			Stock = (CASE WHEN @Incrementa = 0 AND @FlagAgotado = 0 THEN Stock + @CantidadIncrementa 
							WHEN @Incrementa = 1 AND @FlagAgotado = 0 THEN Stock - @CantidadIncrementa 
							WHEN @FlagAgotado = 1 THEN 0 END),
			StockInicial = (CASE WHEN @Incrementa = 0 THEN StockInicial + @CantidadIncrementa 
							ELSE StockInicial - @CantidadIncrementa END),
			PrecioOferta = @PrecioOferta,
			EsSubCampania = @EsSubCampania
	where 	
	CampaniaID = @CampaniaID
		AND CUV = @CUV
END

go

ALTER PROCEDURE [ShowRoom].[GetShowRoomPerfilOfertaCuvs]
@EventoID int,
@PerfilID int,
@CampaniaID int
as
/*
ShowRoom.GetShowRoomPerfilOfertaCuvs 1,1,201611
ShowRoom.GetShowRoomPerfilOfertaCuvs 6,47,201707
*/
begin

select 
	isnull(p.PerfilOfertaShowRoomID,0) as PerfilOfertaShowRoomID,
	isnull(p.EventoID,0) as EventoID,
	isnull(p.PerfilID,0) as PerfilID,
	c.Codigo as CampaniaID,
	o.CUV,
	isnull(p.Orden,9999) as Orden,
	o.EsSubCampania
from ShowRoom.OfertaShowRoom o
inner join ods.Campania c on
	o.CampaniaID = c.CampaniaID
left join ShowRoom.PerfilOfertaShowRoom p on
	p.CampaniaID = c.Codigo
	and o.CUV = p.CUV
	and p.PerfilID = @PerfilID
	and p.EventoID = @EventoID
where 
	c.Codigo = @CampaniaID
order by isnull(p.Orden,9999)

end

go

USE BelcorpMexico
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.Evento') and SYSCOLUMNS.NAME = N'TieneSubCampania') = 0
	ALTER TABLE ShowRoom.Evento ADD TieneSubCampania bit
go

update ShowRoom.Evento set TieneSubCampania = 0 where TieneSubCampania is null

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'EsSubCampania') = 0
	ALTER TABLE ShowRoom.OfertaShowRoom ADD EsSubCampania bit
go

update ShowRoom.OfertaShowRoom set EsSubCampania = 0 where EsSubCampania is null

go

alter procedure ShowRoom.GetShowRoomEventoByCampaniaID
@CampaniaID int
as
/*
ShowRoom.GetShowRoomEventoByCampaniaID 201707
*/
begin

select
	EventoID,
	CampaniaID,
	Nombre,
	Imagen1,
	Imagen2,
	Descuento,
	FechaCreacion,
	UsuarioCreacion,
	FechaModificacion,
	UsuarioModificacion,
	TextoEstrategia,
	OfertaEstrategia,
	Tema,
	DiasAntes,
	DiasDespues,
	NumeroPerfiles,
	ImagenCabeceraProducto,
	ImagenVentaSetPopup,
	ImagenVentaTagLateral,
	ImagenPestaniaShowRoom,
	Estado,
	RutaShowRoomPopup,
	RutaShowRoomBannerLateral,
	ImagenPreventaDigital,
	isnull(TieneCategoria,0) as TieneCategoria,
	isnull(TieneCompraXcompra,0) as TieneCompraXcompra,
	isnull(TieneSubCampania,0) as TieneSubCampania
from ShowRoom.Evento
where CampaniaID = @CampaniaID

end

go

alter procedure ShowRoom.InsertShowRoomEvento
@EventoID int output,
@CampaniaID int,
@Nombre varchar(150),
@Tema varchar(150),
@DiasAntes int,
@DiasDespues int,
@NumeroPerfiles int,
@UsuarioCreacion varchar(20),
@TieneCategoria bit,
@TieneCompraXcompra bit,
@TieneSubCampania bit
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

insert into ShowRoom.Evento
(CampaniaID, Nombre, Tema, DiasAntes, DiasDespues, NumeroPerfiles, 
FechaCreacion, UsuarioCreacion, FechaModificacion, UsuarioModificacion, 
Estado, TieneCategoria, TieneCompraXcompra, TieneSubCampania)
values
(@CampaniaID, @Nombre, @Tema, @DiasAntes, @DiasDespues, @NumeroPerfiles,
@FechaGeneral, @UsuarioCreacion, @FechaGeneral, @UsuarioCreacion, 
1, @TieneCategoria, @TieneCompraXcompra, @TieneSubCampania)

set @EventoID = @@IDENTITY

end

go

alter procedure ShowRoom.UpdateShowRoomEvento
@EventoID int,
@CampaniaID int,
@Nombre varchar(150),
@Tema varchar(150),
@DiasAntes int,
@DiasDespues int,
@NumeroPerfiles int,
@UsuarioModificacion varchar(20),
@Estado int,
@TieneCategoria bit,
@TieneCompraXcompra bit,
@TieneSubCampania bit
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

update ShowRoom.Evento
set
	CampaniaID = @CampaniaID,
	Nombre = @Nombre,
	Tema = @Tema,
	DiasAntes = @DiasAntes,
	DiasDespues = @DiasDespues,	
	NumeroPerfiles = @NumeroPerfiles,
	FechaModificacion = @FechaGeneral,
	UsuarioModificacion = @UsuarioModificacion,
	Estado = @Estado,
	TieneCategoria = @TieneCategoria,
	TieneCompraXcompra = @TieneCompraXcompra,
	TieneSubCampania = @TieneSubCampania
where EventoID = @EventoID

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[UpdStockOfertaShowRoomMasivo]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].UpdStockOfertaShowRoomMasivo
GO

go

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
	[PrecioValorizado] [decimal](18, 2) NULL,
	[PrecioOferta] [decimal](18, 2) NULL,	
	[UnidadesPermitidas] [int] NULL,
	[Descripcion] [varchar](250) NULL,
	[CodigoCategoria] [varchar](100) NULL,
	[TipNegocio] [varchar](500) NULL,
	[EsSubCampania] [bit] NULL	
)
GO

create procedure ShowRoom.UpdStockOfertaShowRoomMasivo
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
	TipNegocio = t.TipNegocio,
	PrecioValorizado = t.PrecioValorizado,
	EsSubCampania = t.EsSubCampania
FROM ShowRoom.OfertaShowRoom o
INNER JOIN ods.Campania c on 
	c.CampaniaID = o.CampaniaID
JOIN @StockPrecioOfertaShowRoom t ON 
	c.Codigo = t.CampaniaID
	AND o.CUV = t.CUV
	AND o.TipoOfertaSisID = t.TipoOfertaSisID

end

go

alter procedure ShowRoom.GetShowRoomOfertasConsultora
@CampaniaID int,
@CodigoConsultora varchar(20)
as
/*
ShowRoom.GetShowRoomOfertasConsultora 201706,'0012954'
ShowRoom.GetShowRoomOfertasConsultora 201706,'1615995'
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
o.OfertaShowRoomID,o.CampaniaID,o.CUV,o.TipoOfertaSisID,o.ConfiguracionOfertaID,o.Descripcion,
o.PrecioValorizado,
COALESCE(o.PrecioOferta,pc.PrecioCatalogo) AS PrecioOferta,
o.Stock,
o.StockInicial,o.ImagenProducto,o.UnidadesPermitidas,o.FlagHabilitarProducto,o.DescripcionLegal,o.UsuarioRegistro,
o.FechaRegistro,o.UsuarioModificacion,o.FechaModificacion,o.ImagenMini,pc.MarcaID, pos.Orden, o.CodigoCategoria, o.TipNegocio,
pc.CodigoProducto, cat.Descripcion as DescripcionCategoria, o.EsSubCampania
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

go

alter procedure ShowRoom.GetProductosShowRoom
@CampaniaID int
as
/*
ShowRoom.GetProductosShowRoom 201707
*/
begin

declare @ConfiguracionOfertaID int = 0
select @ConfiguracionOfertaID=ConfiguracionOfertaID from ConfiguracionOferta where TipoOfertaSisID = 1707

select 
	ISNULL(OS.OfertaShowRoomID,0) OfertaShowRoomID,
	ROW_NUMBER() OVER (ORDER BY (SELECT 1)) as NroOrden,
	PC.CampaniaID,
	CA.Codigo as CodigoCampania,
	PC.CUV,
	PC.CodigoTipoOferta,
	ISNULL(OS.Descripcion,PC.Descripcion) as Descripcion,
	COALESCE(OS.PrecioValorizado,PC.PrecioValorizado) as PrecioValorizado,
	COALESCE(OS.PrecioOferta,PC.PrecioCatalogo) as PrecioOferta,
	ISNULL(OS.Stock,0) Stock,
	ISNULL(OS.StockInicial,0) StockInicial,
	ISNULL(OS.ImagenProducto,'') ImagenProducto,
	ISNULL(OS.UnidadesPermitidas,'') UnidadesPermitidas,
	ISNULL(OS.FlagHabilitarProducto,0) FlagHabilitarProducto,
	OS.Orden,
	PC.CodigoProducto,
	ISNULL(OS.DescripcionLegal,'') DescripcionLegal,
	ISNULL(OS.ImagenMini,'') ImagenMini,
	@ConfiguracionOfertaID as ConfiguracionOfertaID,
	ISNULL(OS.EsSubCampania,0) as EsSubCampania
FROM ods.ProductoComercial PC WITH (NOLOCK)
INNER JOIN ods.Campania CA WITH (NOLOCK) ON 
	CA.CampaniaID = PC.CampaniaID
LEFT JOIN ShowRoom.OfertaShowRoom OS WITH(NOLOCK) ON 
	OS.CUV = PC.CUV 
	AND OS.CampaniaID = PC.CampaniaID
WHERE 
	PC.CodigoTipoOferta in (
		select Codigo from ShowRoom.TipoOferta where Activo = 1
	)
	AND CA.Codigo = @CampaniaID
union all
select 
	ISNULL(OS.OfertaShowRoomID,0) OfertaShowRoomID,
	ROW_NUMBER() OVER (ORDER BY (SELECT 1)) as NroOrden,
	PC.CampaniaID,
	CA.Codigo as CodigoCampania,
	PC.CUV,
	PC.CodigoTipoOferta,
	ISNULL(OS.Descripcion,PC.Descripcion) as Descripcion,
	COALESCE(OS.PrecioValorizado,PC.PrecioValorizado) as PrecioValorizado,
	COALESCE(OS.PrecioOferta,PC.PrecioCatalogo) as PrecioOferta,
	ISNULL(OS.Stock,0) Stock,
	ISNULL(OS.StockInicial,0) StockInicial,
	ISNULL(OS.ImagenProducto,'') ImagenProducto,
	ISNULL(OS.UnidadesPermitidas,'') UnidadesPermitidas,
	ISNULL(OS.FlagHabilitarProducto,0) FlagHabilitarProducto,
	OS.Orden,
	PC.CodigoProducto,
	ISNULL(OS.DescripcionLegal,'') DescripcionLegal,
	ISNULL(OS.ImagenMini,'') ImagenMini,
	@ConfiguracionOfertaID as ConfiguracionOfertaID,
	ISNULL(OS.EsSubCampania,0) as EsSubCampania
FROM ods.ProductoComercial PC WITH (NOLOCK)
INNER JOIN ods.Campania CA WITH (NOLOCK) ON 
	CA.CampaniaID = PC.CampaniaID
INNER JOIN ShowRoom.OfertaShowRoom OS WITH(NOLOCK) ON 
	OS.CUV = PC.CUV 
	AND OS.CampaniaID = PC.CampaniaID
WHERE 
	PC.CodigoTipoOferta not in (
		select Codigo from ShowRoom.TipoOferta where Activo = 1
	)
	AND CA.Codigo = @CampaniaID
ORDER BY CUV desc

end

go

ALTER PROCEDURE ShowRoom.InsOfertaShowRoom
(	
	@CampaniaID int,
	@CUV varchar(20),
	@TipoOfertaSisID int,
	@ConfiguracionOfertaID int,
	@Descripcion varchar(250),
	@PrecioValorizado numeric(12,2),
	@ImagenProducto varchar(150),
	@Orden int,
	@UnidadesPermitidas int,
	@FlagHabilitarProducto int,
	@DescripcionLegal varchar(250),
	@UsuarioRegistro varchar(50),
	@ImagenMini varchar(150),
	@PrecioOferta decimal(12,2)=0,
	@EsSubCampania bit
)
AS
BEGIN
	INSERT INTO ShowRoom.OfertaShowRoom
	(
		CampaniaID, CUV, TipoOfertaSisID, ConfiguracionOfertaID, Descripcion, PrecioValorizado, Stock, StockInicial, ImagenProducto,
		Orden, UnidadesPermitidas, FlagHabilitarProducto, DescripcionLegal, UsuarioRegistro, FechaRegistro, ImagenMini, PrecioOferta,
		EsSubCampania
	)
	VALUES
	(
		@CampaniaID, @CUV, @TipoOfertaSisID, @ConfiguracionOfertaID, @Descripcion, @PrecioValorizado , 0, 0, @ImagenProducto, 
		@Orden, @UnidadesPermitidas, @FlagHabilitarProducto, @DescripcionLegal, @UsuarioRegistro, getdate(), @ImagenMini, @PrecioOferta,
		@EsSubCampania
	)
END

go

ALTER PROCEDURE ShowRoom.UpdOfertaShowRoom
(
	@TipoOfertaSisID int,
	@CampaniaID int,
	@CUV varchar(20),
	@Descripcion varchar(250),
	@ImagenProducto varchar(150),
	@UnidadesPermitidas int,
	@FlagHabilitarProducto int,
	@Orden int,
	@DescripcionLegal varchar(250),
	@UsuarioModificacion varchar(50),
	@PrecioValorizado decimal(18,2),
	@ImagenMini varchar(150),
	@Incrementa int,
	@CantidadIncrementa int,
	@FlagAgotado int,
	@PrecioOferta decimal(18,2)=0,
	@EsSubCampania bit
)
AS
BEGIN
	UPDATE ShowRoom.OfertaShowRoom
		SET Descripcion = @Descripcion,
			UnidadesPermitidas = @UnidadesPermitidas,
			FlagHabilitarProducto = @FlagHabilitarProducto,
			Orden = @Orden,
			ImagenProducto = @ImagenProducto,
			DescripcionLegal = @DescripcionLegal,
			UsuarioModificacion = @UsuarioModificacion,
			PrecioValorizado = @PrecioValorizado,
			FechaModificacion = getdate(),
			ImagenMini = @ImagenMini,
			Stock = (CASE WHEN @Incrementa = 0 AND @FlagAgotado = 0 THEN Stock + @CantidadIncrementa 
							WHEN @Incrementa = 1 AND @FlagAgotado = 0 THEN Stock - @CantidadIncrementa 
							WHEN @FlagAgotado = 1 THEN 0 END),
			StockInicial = (CASE WHEN @Incrementa = 0 THEN StockInicial + @CantidadIncrementa 
							ELSE StockInicial - @CantidadIncrementa END),
			PrecioOferta = @PrecioOferta,
			EsSubCampania = @EsSubCampania
	where 	
	CampaniaID = @CampaniaID
		AND CUV = @CUV
END

go

ALTER PROCEDURE [ShowRoom].[GetShowRoomPerfilOfertaCuvs]
@EventoID int,
@PerfilID int,
@CampaniaID int
as
/*
ShowRoom.GetShowRoomPerfilOfertaCuvs 1,1,201611
ShowRoom.GetShowRoomPerfilOfertaCuvs 6,47,201707
*/
begin

select 
	isnull(p.PerfilOfertaShowRoomID,0) as PerfilOfertaShowRoomID,
	isnull(p.EventoID,0) as EventoID,
	isnull(p.PerfilID,0) as PerfilID,
	c.Codigo as CampaniaID,
	o.CUV,
	isnull(p.Orden,9999) as Orden,
	o.EsSubCampania
from ShowRoom.OfertaShowRoom o
inner join ods.Campania c on
	o.CampaniaID = c.CampaniaID
left join ShowRoom.PerfilOfertaShowRoom p on
	p.CampaniaID = c.Codigo
	and o.CUV = p.CUV
	and p.PerfilID = @PerfilID
	and p.EventoID = @EventoID
where 
	c.Codigo = @CampaniaID
order by isnull(p.Orden,9999)

end

go

USE BelcorpPanama
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.Evento') and SYSCOLUMNS.NAME = N'TieneSubCampania') = 0
	ALTER TABLE ShowRoom.Evento ADD TieneSubCampania bit
go

update ShowRoom.Evento set TieneSubCampania = 0 where TieneSubCampania is null

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'EsSubCampania') = 0
	ALTER TABLE ShowRoom.OfertaShowRoom ADD EsSubCampania bit
go

update ShowRoom.OfertaShowRoom set EsSubCampania = 0 where EsSubCampania is null

go

alter procedure ShowRoom.GetShowRoomEventoByCampaniaID
@CampaniaID int
as
/*
ShowRoom.GetShowRoomEventoByCampaniaID 201707
*/
begin

select
	EventoID,
	CampaniaID,
	Nombre,
	Imagen1,
	Imagen2,
	Descuento,
	FechaCreacion,
	UsuarioCreacion,
	FechaModificacion,
	UsuarioModificacion,
	TextoEstrategia,
	OfertaEstrategia,
	Tema,
	DiasAntes,
	DiasDespues,
	NumeroPerfiles,
	ImagenCabeceraProducto,
	ImagenVentaSetPopup,
	ImagenVentaTagLateral,
	ImagenPestaniaShowRoom,
	Estado,
	RutaShowRoomPopup,
	RutaShowRoomBannerLateral,
	ImagenPreventaDigital,
	isnull(TieneCategoria,0) as TieneCategoria,
	isnull(TieneCompraXcompra,0) as TieneCompraXcompra,
	isnull(TieneSubCampania,0) as TieneSubCampania
from ShowRoom.Evento
where CampaniaID = @CampaniaID

end

go

alter procedure ShowRoom.InsertShowRoomEvento
@EventoID int output,
@CampaniaID int,
@Nombre varchar(150),
@Tema varchar(150),
@DiasAntes int,
@DiasDespues int,
@NumeroPerfiles int,
@UsuarioCreacion varchar(20),
@TieneCategoria bit,
@TieneCompraXcompra bit,
@TieneSubCampania bit
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

insert into ShowRoom.Evento
(CampaniaID, Nombre, Tema, DiasAntes, DiasDespues, NumeroPerfiles, 
FechaCreacion, UsuarioCreacion, FechaModificacion, UsuarioModificacion, 
Estado, TieneCategoria, TieneCompraXcompra, TieneSubCampania)
values
(@CampaniaID, @Nombre, @Tema, @DiasAntes, @DiasDespues, @NumeroPerfiles,
@FechaGeneral, @UsuarioCreacion, @FechaGeneral, @UsuarioCreacion, 
1, @TieneCategoria, @TieneCompraXcompra, @TieneSubCampania)

set @EventoID = @@IDENTITY

end

go

alter procedure ShowRoom.UpdateShowRoomEvento
@EventoID int,
@CampaniaID int,
@Nombre varchar(150),
@Tema varchar(150),
@DiasAntes int,
@DiasDespues int,
@NumeroPerfiles int,
@UsuarioModificacion varchar(20),
@Estado int,
@TieneCategoria bit,
@TieneCompraXcompra bit,
@TieneSubCampania bit
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

update ShowRoom.Evento
set
	CampaniaID = @CampaniaID,
	Nombre = @Nombre,
	Tema = @Tema,
	DiasAntes = @DiasAntes,
	DiasDespues = @DiasDespues,	
	NumeroPerfiles = @NumeroPerfiles,
	FechaModificacion = @FechaGeneral,
	UsuarioModificacion = @UsuarioModificacion,
	Estado = @Estado,
	TieneCategoria = @TieneCategoria,
	TieneCompraXcompra = @TieneCompraXcompra,
	TieneSubCampania = @TieneSubCampania
where EventoID = @EventoID

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[UpdStockOfertaShowRoomMasivo]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].UpdStockOfertaShowRoomMasivo
GO

go

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
	[PrecioValorizado] [decimal](18, 2) NULL,
	[PrecioOferta] [decimal](18, 2) NULL,	
	[UnidadesPermitidas] [int] NULL,
	[Descripcion] [varchar](250) NULL,
	[CodigoCategoria] [varchar](100) NULL,
	[TipNegocio] [varchar](500) NULL,
	[EsSubCampania] [bit] NULL	
)
GO

create procedure ShowRoom.UpdStockOfertaShowRoomMasivo
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
	TipNegocio = t.TipNegocio,
	PrecioValorizado = t.PrecioValorizado,
	EsSubCampania = t.EsSubCampania
FROM ShowRoom.OfertaShowRoom o
INNER JOIN ods.Campania c on 
	c.CampaniaID = o.CampaniaID
JOIN @StockPrecioOfertaShowRoom t ON 
	c.Codigo = t.CampaniaID
	AND o.CUV = t.CUV
	AND o.TipoOfertaSisID = t.TipoOfertaSisID

end

go

alter procedure ShowRoom.GetShowRoomOfertasConsultora
@CampaniaID int,
@CodigoConsultora varchar(20)
as
/*
ShowRoom.GetShowRoomOfertasConsultora 201706,'0012954'
ShowRoom.GetShowRoomOfertasConsultora 201706,'1615995'
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
o.OfertaShowRoomID,o.CampaniaID,o.CUV,o.TipoOfertaSisID,o.ConfiguracionOfertaID,o.Descripcion,
o.PrecioValorizado,
COALESCE(o.PrecioOferta,pc.PrecioCatalogo) AS PrecioOferta,
o.Stock,
o.StockInicial,o.ImagenProducto,o.UnidadesPermitidas,o.FlagHabilitarProducto,o.DescripcionLegal,o.UsuarioRegistro,
o.FechaRegistro,o.UsuarioModificacion,o.FechaModificacion,o.ImagenMini,pc.MarcaID, pos.Orden, o.CodigoCategoria, o.TipNegocio,
pc.CodigoProducto, cat.Descripcion as DescripcionCategoria, o.EsSubCampania
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

go

alter procedure ShowRoom.GetProductosShowRoom
@CampaniaID int
as
/*
ShowRoom.GetProductosShowRoom 201707
*/
begin

declare @ConfiguracionOfertaID int = 0
select @ConfiguracionOfertaID=ConfiguracionOfertaID from ConfiguracionOferta where TipoOfertaSisID = 1707

select 
	ISNULL(OS.OfertaShowRoomID,0) OfertaShowRoomID,
	ROW_NUMBER() OVER (ORDER BY (SELECT 1)) as NroOrden,
	PC.CampaniaID,
	CA.Codigo as CodigoCampania,
	PC.CUV,
	PC.CodigoTipoOferta,
	ISNULL(OS.Descripcion,PC.Descripcion) as Descripcion,
	COALESCE(OS.PrecioValorizado,PC.PrecioValorizado) as PrecioValorizado,
	COALESCE(OS.PrecioOferta,PC.PrecioCatalogo) as PrecioOferta,
	ISNULL(OS.Stock,0) Stock,
	ISNULL(OS.StockInicial,0) StockInicial,
	ISNULL(OS.ImagenProducto,'') ImagenProducto,
	ISNULL(OS.UnidadesPermitidas,'') UnidadesPermitidas,
	ISNULL(OS.FlagHabilitarProducto,0) FlagHabilitarProducto,
	OS.Orden,
	PC.CodigoProducto,
	ISNULL(OS.DescripcionLegal,'') DescripcionLegal,
	ISNULL(OS.ImagenMini,'') ImagenMini,
	@ConfiguracionOfertaID as ConfiguracionOfertaID,
	ISNULL(OS.EsSubCampania,0) as EsSubCampania
FROM ods.ProductoComercial PC WITH (NOLOCK)
INNER JOIN ods.Campania CA WITH (NOLOCK) ON 
	CA.CampaniaID = PC.CampaniaID
LEFT JOIN ShowRoom.OfertaShowRoom OS WITH(NOLOCK) ON 
	OS.CUV = PC.CUV 
	AND OS.CampaniaID = PC.CampaniaID
WHERE 
	PC.CodigoTipoOferta in (
		select Codigo from ShowRoom.TipoOferta where Activo = 1
	)
	AND CA.Codigo = @CampaniaID
union all
select 
	ISNULL(OS.OfertaShowRoomID,0) OfertaShowRoomID,
	ROW_NUMBER() OVER (ORDER BY (SELECT 1)) as NroOrden,
	PC.CampaniaID,
	CA.Codigo as CodigoCampania,
	PC.CUV,
	PC.CodigoTipoOferta,
	ISNULL(OS.Descripcion,PC.Descripcion) as Descripcion,
	COALESCE(OS.PrecioValorizado,PC.PrecioValorizado) as PrecioValorizado,
	COALESCE(OS.PrecioOferta,PC.PrecioCatalogo) as PrecioOferta,
	ISNULL(OS.Stock,0) Stock,
	ISNULL(OS.StockInicial,0) StockInicial,
	ISNULL(OS.ImagenProducto,'') ImagenProducto,
	ISNULL(OS.UnidadesPermitidas,'') UnidadesPermitidas,
	ISNULL(OS.FlagHabilitarProducto,0) FlagHabilitarProducto,
	OS.Orden,
	PC.CodigoProducto,
	ISNULL(OS.DescripcionLegal,'') DescripcionLegal,
	ISNULL(OS.ImagenMini,'') ImagenMini,
	@ConfiguracionOfertaID as ConfiguracionOfertaID,
	ISNULL(OS.EsSubCampania,0) as EsSubCampania
FROM ods.ProductoComercial PC WITH (NOLOCK)
INNER JOIN ods.Campania CA WITH (NOLOCK) ON 
	CA.CampaniaID = PC.CampaniaID
INNER JOIN ShowRoom.OfertaShowRoom OS WITH(NOLOCK) ON 
	OS.CUV = PC.CUV 
	AND OS.CampaniaID = PC.CampaniaID
WHERE 
	PC.CodigoTipoOferta not in (
		select Codigo from ShowRoom.TipoOferta where Activo = 1
	)
	AND CA.Codigo = @CampaniaID
ORDER BY CUV desc

end

go

ALTER PROCEDURE ShowRoom.InsOfertaShowRoom
(	
	@CampaniaID int,
	@CUV varchar(20),
	@TipoOfertaSisID int,
	@ConfiguracionOfertaID int,
	@Descripcion varchar(250),
	@PrecioValorizado numeric(12,2),
	@ImagenProducto varchar(150),
	@Orden int,
	@UnidadesPermitidas int,
	@FlagHabilitarProducto int,
	@DescripcionLegal varchar(250),
	@UsuarioRegistro varchar(50),
	@ImagenMini varchar(150),
	@PrecioOferta decimal(12,2)=0,
	@EsSubCampania bit
)
AS
BEGIN
	INSERT INTO ShowRoom.OfertaShowRoom
	(
		CampaniaID, CUV, TipoOfertaSisID, ConfiguracionOfertaID, Descripcion, PrecioValorizado, Stock, StockInicial, ImagenProducto,
		Orden, UnidadesPermitidas, FlagHabilitarProducto, DescripcionLegal, UsuarioRegistro, FechaRegistro, ImagenMini, PrecioOferta,
		EsSubCampania
	)
	VALUES
	(
		@CampaniaID, @CUV, @TipoOfertaSisID, @ConfiguracionOfertaID, @Descripcion, @PrecioValorizado , 0, 0, @ImagenProducto, 
		@Orden, @UnidadesPermitidas, @FlagHabilitarProducto, @DescripcionLegal, @UsuarioRegistro, getdate(), @ImagenMini, @PrecioOferta,
		@EsSubCampania
	)
END

go

ALTER PROCEDURE ShowRoom.UpdOfertaShowRoom
(
	@TipoOfertaSisID int,
	@CampaniaID int,
	@CUV varchar(20),
	@Descripcion varchar(250),
	@ImagenProducto varchar(150),
	@UnidadesPermitidas int,
	@FlagHabilitarProducto int,
	@Orden int,
	@DescripcionLegal varchar(250),
	@UsuarioModificacion varchar(50),
	@PrecioValorizado decimal(18,2),
	@ImagenMini varchar(150),
	@Incrementa int,
	@CantidadIncrementa int,
	@FlagAgotado int,
	@PrecioOferta decimal(18,2)=0,
	@EsSubCampania bit
)
AS
BEGIN
	UPDATE ShowRoom.OfertaShowRoom
		SET Descripcion = @Descripcion,
			UnidadesPermitidas = @UnidadesPermitidas,
			FlagHabilitarProducto = @FlagHabilitarProducto,
			Orden = @Orden,
			ImagenProducto = @ImagenProducto,
			DescripcionLegal = @DescripcionLegal,
			UsuarioModificacion = @UsuarioModificacion,
			PrecioValorizado = @PrecioValorizado,
			FechaModificacion = getdate(),
			ImagenMini = @ImagenMini,
			Stock = (CASE WHEN @Incrementa = 0 AND @FlagAgotado = 0 THEN Stock + @CantidadIncrementa 
							WHEN @Incrementa = 1 AND @FlagAgotado = 0 THEN Stock - @CantidadIncrementa 
							WHEN @FlagAgotado = 1 THEN 0 END),
			StockInicial = (CASE WHEN @Incrementa = 0 THEN StockInicial + @CantidadIncrementa 
							ELSE StockInicial - @CantidadIncrementa END),
			PrecioOferta = @PrecioOferta,
			EsSubCampania = @EsSubCampania
	where 	
	CampaniaID = @CampaniaID
		AND CUV = @CUV
END

go

ALTER PROCEDURE [ShowRoom].[GetShowRoomPerfilOfertaCuvs]
@EventoID int,
@PerfilID int,
@CampaniaID int
as
/*
ShowRoom.GetShowRoomPerfilOfertaCuvs 1,1,201611
ShowRoom.GetShowRoomPerfilOfertaCuvs 6,47,201707
*/
begin

select 
	isnull(p.PerfilOfertaShowRoomID,0) as PerfilOfertaShowRoomID,
	isnull(p.EventoID,0) as EventoID,
	isnull(p.PerfilID,0) as PerfilID,
	c.Codigo as CampaniaID,
	o.CUV,
	isnull(p.Orden,9999) as Orden,
	o.EsSubCampania
from ShowRoom.OfertaShowRoom o
inner join ods.Campania c on
	o.CampaniaID = c.CampaniaID
left join ShowRoom.PerfilOfertaShowRoom p on
	p.CampaniaID = c.Codigo
	and o.CUV = p.CUV
	and p.PerfilID = @PerfilID
	and p.EventoID = @EventoID
where 
	c.Codigo = @CampaniaID
order by isnull(p.Orden,9999)

end

go

USE BelcorpPeru
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.Evento') and SYSCOLUMNS.NAME = N'TieneSubCampania') = 0
	ALTER TABLE ShowRoom.Evento ADD TieneSubCampania bit
go

update ShowRoom.Evento set TieneSubCampania = 0 where TieneSubCampania is null

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'EsSubCampania') = 0
	ALTER TABLE ShowRoom.OfertaShowRoom ADD EsSubCampania bit
go

update ShowRoom.OfertaShowRoom set EsSubCampania = 0 where EsSubCampania is null

go

alter procedure ShowRoom.GetShowRoomEventoByCampaniaID
@CampaniaID int
as
/*
ShowRoom.GetShowRoomEventoByCampaniaID 201707
*/
begin

select
	EventoID,
	CampaniaID,
	Nombre,
	Imagen1,
	Imagen2,
	Descuento,
	FechaCreacion,
	UsuarioCreacion,
	FechaModificacion,
	UsuarioModificacion,
	TextoEstrategia,
	OfertaEstrategia,
	Tema,
	DiasAntes,
	DiasDespues,
	NumeroPerfiles,
	ImagenCabeceraProducto,
	ImagenVentaSetPopup,
	ImagenVentaTagLateral,
	ImagenPestaniaShowRoom,
	Estado,
	RutaShowRoomPopup,
	RutaShowRoomBannerLateral,
	ImagenPreventaDigital,
	isnull(TieneCategoria,0) as TieneCategoria,
	isnull(TieneCompraXcompra,0) as TieneCompraXcompra,
	isnull(TieneSubCampania,0) as TieneSubCampania
from ShowRoom.Evento
where CampaniaID = @CampaniaID

end

go

alter procedure ShowRoom.InsertShowRoomEvento
@EventoID int output,
@CampaniaID int,
@Nombre varchar(150),
@Tema varchar(150),
@DiasAntes int,
@DiasDespues int,
@NumeroPerfiles int,
@UsuarioCreacion varchar(20),
@TieneCategoria bit,
@TieneCompraXcompra bit,
@TieneSubCampania bit
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

insert into ShowRoom.Evento
(CampaniaID, Nombre, Tema, DiasAntes, DiasDespues, NumeroPerfiles, 
FechaCreacion, UsuarioCreacion, FechaModificacion, UsuarioModificacion, 
Estado, TieneCategoria, TieneCompraXcompra, TieneSubCampania)
values
(@CampaniaID, @Nombre, @Tema, @DiasAntes, @DiasDespues, @NumeroPerfiles,
@FechaGeneral, @UsuarioCreacion, @FechaGeneral, @UsuarioCreacion, 
1, @TieneCategoria, @TieneCompraXcompra, @TieneSubCampania)

set @EventoID = @@IDENTITY

end

go

alter procedure ShowRoom.UpdateShowRoomEvento
@EventoID int,
@CampaniaID int,
@Nombre varchar(150),
@Tema varchar(150),
@DiasAntes int,
@DiasDespues int,
@NumeroPerfiles int,
@UsuarioModificacion varchar(20),
@Estado int,
@TieneCategoria bit,
@TieneCompraXcompra bit,
@TieneSubCampania bit
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

update ShowRoom.Evento
set
	CampaniaID = @CampaniaID,
	Nombre = @Nombre,
	Tema = @Tema,
	DiasAntes = @DiasAntes,
	DiasDespues = @DiasDespues,	
	NumeroPerfiles = @NumeroPerfiles,
	FechaModificacion = @FechaGeneral,
	UsuarioModificacion = @UsuarioModificacion,
	Estado = @Estado,
	TieneCategoria = @TieneCategoria,
	TieneCompraXcompra = @TieneCompraXcompra,
	TieneSubCampania = @TieneSubCampania
where EventoID = @EventoID

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[UpdStockOfertaShowRoomMasivo]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].UpdStockOfertaShowRoomMasivo
GO

go

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
	[PrecioValorizado] [decimal](18, 2) NULL,
	[PrecioOferta] [decimal](18, 2) NULL,	
	[UnidadesPermitidas] [int] NULL,
	[Descripcion] [varchar](250) NULL,
	[CodigoCategoria] [varchar](100) NULL,
	[TipNegocio] [varchar](500) NULL,
	[EsSubCampania] [bit] NULL	
)
GO

create procedure ShowRoom.UpdStockOfertaShowRoomMasivo
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
	TipNegocio = t.TipNegocio,
	PrecioValorizado = t.PrecioValorizado,
	EsSubCampania = t.EsSubCampania
FROM ShowRoom.OfertaShowRoom o
INNER JOIN ods.Campania c on 
	c.CampaniaID = o.CampaniaID
JOIN @StockPrecioOfertaShowRoom t ON 
	c.Codigo = t.CampaniaID
	AND o.CUV = t.CUV
	AND o.TipoOfertaSisID = t.TipoOfertaSisID

end

go

alter procedure ShowRoom.GetShowRoomOfertasConsultora
@CampaniaID int,
@CodigoConsultora varchar(20)
as
/*
ShowRoom.GetShowRoomOfertasConsultora 201706,'0012954'
ShowRoom.GetShowRoomOfertasConsultora 201706,'1615995'
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
o.OfertaShowRoomID,o.CampaniaID,o.CUV,o.TipoOfertaSisID,o.ConfiguracionOfertaID,o.Descripcion,
o.PrecioValorizado,
COALESCE(o.PrecioOferta,pc.PrecioCatalogo) AS PrecioOferta,
o.Stock,
o.StockInicial,o.ImagenProducto,o.UnidadesPermitidas,o.FlagHabilitarProducto,o.DescripcionLegal,o.UsuarioRegistro,
o.FechaRegistro,o.UsuarioModificacion,o.FechaModificacion,o.ImagenMini,pc.MarcaID, pos.Orden, o.CodigoCategoria, o.TipNegocio,
pc.CodigoProducto, cat.Descripcion as DescripcionCategoria, o.EsSubCampania
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

go

alter procedure ShowRoom.GetProductosShowRoom
@CampaniaID int
as
/*
ShowRoom.GetProductosShowRoom 201707
*/
begin

declare @ConfiguracionOfertaID int = 0
select @ConfiguracionOfertaID=ConfiguracionOfertaID from ConfiguracionOferta where TipoOfertaSisID = 1707

select 
	ISNULL(OS.OfertaShowRoomID,0) OfertaShowRoomID,
	ROW_NUMBER() OVER (ORDER BY (SELECT 1)) as NroOrden,
	PC.CampaniaID,
	CA.Codigo as CodigoCampania,
	PC.CUV,
	PC.CodigoTipoOferta,
	ISNULL(OS.Descripcion,PC.Descripcion) as Descripcion,
	COALESCE(OS.PrecioValorizado,PC.PrecioValorizado) as PrecioValorizado,
	COALESCE(OS.PrecioOferta,PC.PrecioCatalogo) as PrecioOferta,
	ISNULL(OS.Stock,0) Stock,
	ISNULL(OS.StockInicial,0) StockInicial,
	ISNULL(OS.ImagenProducto,'') ImagenProducto,
	ISNULL(OS.UnidadesPermitidas,'') UnidadesPermitidas,
	ISNULL(OS.FlagHabilitarProducto,0) FlagHabilitarProducto,
	OS.Orden,
	PC.CodigoProducto,
	ISNULL(OS.DescripcionLegal,'') DescripcionLegal,
	ISNULL(OS.ImagenMini,'') ImagenMini,
	@ConfiguracionOfertaID as ConfiguracionOfertaID,
	ISNULL(OS.EsSubCampania,0) as EsSubCampania
FROM ods.ProductoComercial PC WITH (NOLOCK)
INNER JOIN ods.Campania CA WITH (NOLOCK) ON 
	CA.CampaniaID = PC.CampaniaID
LEFT JOIN ShowRoom.OfertaShowRoom OS WITH(NOLOCK) ON 
	OS.CUV = PC.CUV 
	AND OS.CampaniaID = PC.CampaniaID
WHERE 
	PC.CodigoTipoOferta in (
		select Codigo from ShowRoom.TipoOferta where Activo = 1
	)
	AND CA.Codigo = @CampaniaID
union all
select 
	ISNULL(OS.OfertaShowRoomID,0) OfertaShowRoomID,
	ROW_NUMBER() OVER (ORDER BY (SELECT 1)) as NroOrden,
	PC.CampaniaID,
	CA.Codigo as CodigoCampania,
	PC.CUV,
	PC.CodigoTipoOferta,
	ISNULL(OS.Descripcion,PC.Descripcion) as Descripcion,
	COALESCE(OS.PrecioValorizado,PC.PrecioValorizado) as PrecioValorizado,
	COALESCE(OS.PrecioOferta,PC.PrecioCatalogo) as PrecioOferta,
	ISNULL(OS.Stock,0) Stock,
	ISNULL(OS.StockInicial,0) StockInicial,
	ISNULL(OS.ImagenProducto,'') ImagenProducto,
	ISNULL(OS.UnidadesPermitidas,'') UnidadesPermitidas,
	ISNULL(OS.FlagHabilitarProducto,0) FlagHabilitarProducto,
	OS.Orden,
	PC.CodigoProducto,
	ISNULL(OS.DescripcionLegal,'') DescripcionLegal,
	ISNULL(OS.ImagenMini,'') ImagenMini,
	@ConfiguracionOfertaID as ConfiguracionOfertaID,
	ISNULL(OS.EsSubCampania,0) as EsSubCampania
FROM ods.ProductoComercial PC WITH (NOLOCK)
INNER JOIN ods.Campania CA WITH (NOLOCK) ON 
	CA.CampaniaID = PC.CampaniaID
INNER JOIN ShowRoom.OfertaShowRoom OS WITH(NOLOCK) ON 
	OS.CUV = PC.CUV 
	AND OS.CampaniaID = PC.CampaniaID
WHERE 
	PC.CodigoTipoOferta not in (
		select Codigo from ShowRoom.TipoOferta where Activo = 1
	)
	AND CA.Codigo = @CampaniaID
ORDER BY CUV desc

end

go

ALTER PROCEDURE ShowRoom.InsOfertaShowRoom
(	
	@CampaniaID int,
	@CUV varchar(20),
	@TipoOfertaSisID int,
	@ConfiguracionOfertaID int,
	@Descripcion varchar(250),
	@PrecioValorizado numeric(12,2),
	@ImagenProducto varchar(150),
	@Orden int,
	@UnidadesPermitidas int,
	@FlagHabilitarProducto int,
	@DescripcionLegal varchar(250),
	@UsuarioRegistro varchar(50),
	@ImagenMini varchar(150),
	@PrecioOferta decimal(12,2)=0,
	@EsSubCampania bit
)
AS
BEGIN
	INSERT INTO ShowRoom.OfertaShowRoom
	(
		CampaniaID, CUV, TipoOfertaSisID, ConfiguracionOfertaID, Descripcion, PrecioValorizado, Stock, StockInicial, ImagenProducto,
		Orden, UnidadesPermitidas, FlagHabilitarProducto, DescripcionLegal, UsuarioRegistro, FechaRegistro, ImagenMini, PrecioOferta,
		EsSubCampania
	)
	VALUES
	(
		@CampaniaID, @CUV, @TipoOfertaSisID, @ConfiguracionOfertaID, @Descripcion, @PrecioValorizado , 0, 0, @ImagenProducto, 
		@Orden, @UnidadesPermitidas, @FlagHabilitarProducto, @DescripcionLegal, @UsuarioRegistro, getdate(), @ImagenMini, @PrecioOferta,
		@EsSubCampania
	)
END

go

ALTER PROCEDURE ShowRoom.UpdOfertaShowRoom
(
	@TipoOfertaSisID int,
	@CampaniaID int,
	@CUV varchar(20),
	@Descripcion varchar(250),
	@ImagenProducto varchar(150),
	@UnidadesPermitidas int,
	@FlagHabilitarProducto int,
	@Orden int,
	@DescripcionLegal varchar(250),
	@UsuarioModificacion varchar(50),
	@PrecioValorizado decimal(18,2),
	@ImagenMini varchar(150),
	@Incrementa int,
	@CantidadIncrementa int,
	@FlagAgotado int,
	@PrecioOferta decimal(18,2)=0,
	@EsSubCampania bit
)
AS
BEGIN
	UPDATE ShowRoom.OfertaShowRoom
		SET Descripcion = @Descripcion,
			UnidadesPermitidas = @UnidadesPermitidas,
			FlagHabilitarProducto = @FlagHabilitarProducto,
			Orden = @Orden,
			ImagenProducto = @ImagenProducto,
			DescripcionLegal = @DescripcionLegal,
			UsuarioModificacion = @UsuarioModificacion,
			PrecioValorizado = @PrecioValorizado,
			FechaModificacion = getdate(),
			ImagenMini = @ImagenMini,
			Stock = (CASE WHEN @Incrementa = 0 AND @FlagAgotado = 0 THEN Stock + @CantidadIncrementa 
							WHEN @Incrementa = 1 AND @FlagAgotado = 0 THEN Stock - @CantidadIncrementa 
							WHEN @FlagAgotado = 1 THEN 0 END),
			StockInicial = (CASE WHEN @Incrementa = 0 THEN StockInicial + @CantidadIncrementa 
							ELSE StockInicial - @CantidadIncrementa END),
			PrecioOferta = @PrecioOferta,
			EsSubCampania = @EsSubCampania
	where 	
	CampaniaID = @CampaniaID
		AND CUV = @CUV
END

go

ALTER PROCEDURE [ShowRoom].[GetShowRoomPerfilOfertaCuvs]
@EventoID int,
@PerfilID int,
@CampaniaID int
as
/*
ShowRoom.GetShowRoomPerfilOfertaCuvs 1,1,201611
ShowRoom.GetShowRoomPerfilOfertaCuvs 6,47,201707
*/
begin

select 
	isnull(p.PerfilOfertaShowRoomID,0) as PerfilOfertaShowRoomID,
	isnull(p.EventoID,0) as EventoID,
	isnull(p.PerfilID,0) as PerfilID,
	c.Codigo as CampaniaID,
	o.CUV,
	isnull(p.Orden,9999) as Orden,
	o.EsSubCampania
from ShowRoom.OfertaShowRoom o
inner join ods.Campania c on
	o.CampaniaID = c.CampaniaID
left join ShowRoom.PerfilOfertaShowRoom p on
	p.CampaniaID = c.Codigo
	and o.CUV = p.CUV
	and p.PerfilID = @PerfilID
	and p.EventoID = @EventoID
where 
	c.Codigo = @CampaniaID
order by isnull(p.Orden,9999)

end

go

USE BelcorpPuertoRico
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.Evento') and SYSCOLUMNS.NAME = N'TieneSubCampania') = 0
	ALTER TABLE ShowRoom.Evento ADD TieneSubCampania bit
go

update ShowRoom.Evento set TieneSubCampania = 0 where TieneSubCampania is null

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'EsSubCampania') = 0
	ALTER TABLE ShowRoom.OfertaShowRoom ADD EsSubCampania bit
go

update ShowRoom.OfertaShowRoom set EsSubCampania = 0 where EsSubCampania is null

go

alter procedure ShowRoom.GetShowRoomEventoByCampaniaID
@CampaniaID int
as
/*
ShowRoom.GetShowRoomEventoByCampaniaID 201707
*/
begin

select
	EventoID,
	CampaniaID,
	Nombre,
	Imagen1,
	Imagen2,
	Descuento,
	FechaCreacion,
	UsuarioCreacion,
	FechaModificacion,
	UsuarioModificacion,
	TextoEstrategia,
	OfertaEstrategia,
	Tema,
	DiasAntes,
	DiasDespues,
	NumeroPerfiles,
	ImagenCabeceraProducto,
	ImagenVentaSetPopup,
	ImagenVentaTagLateral,
	ImagenPestaniaShowRoom,
	Estado,
	RutaShowRoomPopup,
	RutaShowRoomBannerLateral,
	ImagenPreventaDigital,
	isnull(TieneCategoria,0) as TieneCategoria,
	isnull(TieneCompraXcompra,0) as TieneCompraXcompra,
	isnull(TieneSubCampania,0) as TieneSubCampania
from ShowRoom.Evento
where CampaniaID = @CampaniaID

end

go

alter procedure ShowRoom.InsertShowRoomEvento
@EventoID int output,
@CampaniaID int,
@Nombre varchar(150),
@Tema varchar(150),
@DiasAntes int,
@DiasDespues int,
@NumeroPerfiles int,
@UsuarioCreacion varchar(20),
@TieneCategoria bit,
@TieneCompraXcompra bit,
@TieneSubCampania bit
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

insert into ShowRoom.Evento
(CampaniaID, Nombre, Tema, DiasAntes, DiasDespues, NumeroPerfiles, 
FechaCreacion, UsuarioCreacion, FechaModificacion, UsuarioModificacion, 
Estado, TieneCategoria, TieneCompraXcompra, TieneSubCampania)
values
(@CampaniaID, @Nombre, @Tema, @DiasAntes, @DiasDespues, @NumeroPerfiles,
@FechaGeneral, @UsuarioCreacion, @FechaGeneral, @UsuarioCreacion, 
1, @TieneCategoria, @TieneCompraXcompra, @TieneSubCampania)

set @EventoID = @@IDENTITY

end

go

alter procedure ShowRoom.UpdateShowRoomEvento
@EventoID int,
@CampaniaID int,
@Nombre varchar(150),
@Tema varchar(150),
@DiasAntes int,
@DiasDespues int,
@NumeroPerfiles int,
@UsuarioModificacion varchar(20),
@Estado int,
@TieneCategoria bit,
@TieneCompraXcompra bit,
@TieneSubCampania bit
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

update ShowRoom.Evento
set
	CampaniaID = @CampaniaID,
	Nombre = @Nombre,
	Tema = @Tema,
	DiasAntes = @DiasAntes,
	DiasDespues = @DiasDespues,	
	NumeroPerfiles = @NumeroPerfiles,
	FechaModificacion = @FechaGeneral,
	UsuarioModificacion = @UsuarioModificacion,
	Estado = @Estado,
	TieneCategoria = @TieneCategoria,
	TieneCompraXcompra = @TieneCompraXcompra,
	TieneSubCampania = @TieneSubCampania
where EventoID = @EventoID

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[UpdStockOfertaShowRoomMasivo]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].UpdStockOfertaShowRoomMasivo
GO

go

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
	[PrecioValorizado] [decimal](18, 2) NULL,
	[PrecioOferta] [decimal](18, 2) NULL,	
	[UnidadesPermitidas] [int] NULL,
	[Descripcion] [varchar](250) NULL,
	[CodigoCategoria] [varchar](100) NULL,
	[TipNegocio] [varchar](500) NULL,
	[EsSubCampania] [bit] NULL	
)
GO

create procedure ShowRoom.UpdStockOfertaShowRoomMasivo
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
	TipNegocio = t.TipNegocio,
	PrecioValorizado = t.PrecioValorizado,
	EsSubCampania = t.EsSubCampania
FROM ShowRoom.OfertaShowRoom o
INNER JOIN ods.Campania c on 
	c.CampaniaID = o.CampaniaID
JOIN @StockPrecioOfertaShowRoom t ON 
	c.Codigo = t.CampaniaID
	AND o.CUV = t.CUV
	AND o.TipoOfertaSisID = t.TipoOfertaSisID

end

go

alter procedure ShowRoom.GetShowRoomOfertasConsultora
@CampaniaID int,
@CodigoConsultora varchar(20)
as
/*
ShowRoom.GetShowRoomOfertasConsultora 201706,'0012954'
ShowRoom.GetShowRoomOfertasConsultora 201706,'1615995'
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
o.OfertaShowRoomID,o.CampaniaID,o.CUV,o.TipoOfertaSisID,o.ConfiguracionOfertaID,o.Descripcion,
o.PrecioValorizado,
COALESCE(o.PrecioOferta,pc.PrecioCatalogo) AS PrecioOferta,
o.Stock,
o.StockInicial,o.ImagenProducto,o.UnidadesPermitidas,o.FlagHabilitarProducto,o.DescripcionLegal,o.UsuarioRegistro,
o.FechaRegistro,o.UsuarioModificacion,o.FechaModificacion,o.ImagenMini,pc.MarcaID, pos.Orden, o.CodigoCategoria, o.TipNegocio,
pc.CodigoProducto, cat.Descripcion as DescripcionCategoria, o.EsSubCampania
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

go

alter procedure ShowRoom.GetProductosShowRoom
@CampaniaID int
as
/*
ShowRoom.GetProductosShowRoom 201707
*/
begin

declare @ConfiguracionOfertaID int = 0
select @ConfiguracionOfertaID=ConfiguracionOfertaID from ConfiguracionOferta where TipoOfertaSisID = 1707

select 
	ISNULL(OS.OfertaShowRoomID,0) OfertaShowRoomID,
	ROW_NUMBER() OVER (ORDER BY (SELECT 1)) as NroOrden,
	PC.CampaniaID,
	CA.Codigo as CodigoCampania,
	PC.CUV,
	PC.CodigoTipoOferta,
	ISNULL(OS.Descripcion,PC.Descripcion) as Descripcion,
	COALESCE(OS.PrecioValorizado,PC.PrecioValorizado) as PrecioValorizado,
	COALESCE(OS.PrecioOferta,PC.PrecioCatalogo) as PrecioOferta,
	ISNULL(OS.Stock,0) Stock,
	ISNULL(OS.StockInicial,0) StockInicial,
	ISNULL(OS.ImagenProducto,'') ImagenProducto,
	ISNULL(OS.UnidadesPermitidas,'') UnidadesPermitidas,
	ISNULL(OS.FlagHabilitarProducto,0) FlagHabilitarProducto,
	OS.Orden,
	PC.CodigoProducto,
	ISNULL(OS.DescripcionLegal,'') DescripcionLegal,
	ISNULL(OS.ImagenMini,'') ImagenMini,
	@ConfiguracionOfertaID as ConfiguracionOfertaID,
	ISNULL(OS.EsSubCampania,0) as EsSubCampania
FROM ods.ProductoComercial PC WITH (NOLOCK)
INNER JOIN ods.Campania CA WITH (NOLOCK) ON 
	CA.CampaniaID = PC.CampaniaID
LEFT JOIN ShowRoom.OfertaShowRoom OS WITH(NOLOCK) ON 
	OS.CUV = PC.CUV 
	AND OS.CampaniaID = PC.CampaniaID
WHERE 
	PC.CodigoTipoOferta in (
		select Codigo from ShowRoom.TipoOferta where Activo = 1
	)
	AND CA.Codigo = @CampaniaID
union all
select 
	ISNULL(OS.OfertaShowRoomID,0) OfertaShowRoomID,
	ROW_NUMBER() OVER (ORDER BY (SELECT 1)) as NroOrden,
	PC.CampaniaID,
	CA.Codigo as CodigoCampania,
	PC.CUV,
	PC.CodigoTipoOferta,
	ISNULL(OS.Descripcion,PC.Descripcion) as Descripcion,
	COALESCE(OS.PrecioValorizado,PC.PrecioValorizado) as PrecioValorizado,
	COALESCE(OS.PrecioOferta,PC.PrecioCatalogo) as PrecioOferta,
	ISNULL(OS.Stock,0) Stock,
	ISNULL(OS.StockInicial,0) StockInicial,
	ISNULL(OS.ImagenProducto,'') ImagenProducto,
	ISNULL(OS.UnidadesPermitidas,'') UnidadesPermitidas,
	ISNULL(OS.FlagHabilitarProducto,0) FlagHabilitarProducto,
	OS.Orden,
	PC.CodigoProducto,
	ISNULL(OS.DescripcionLegal,'') DescripcionLegal,
	ISNULL(OS.ImagenMini,'') ImagenMini,
	@ConfiguracionOfertaID as ConfiguracionOfertaID,
	ISNULL(OS.EsSubCampania,0) as EsSubCampania
FROM ods.ProductoComercial PC WITH (NOLOCK)
INNER JOIN ods.Campania CA WITH (NOLOCK) ON 
	CA.CampaniaID = PC.CampaniaID
INNER JOIN ShowRoom.OfertaShowRoom OS WITH(NOLOCK) ON 
	OS.CUV = PC.CUV 
	AND OS.CampaniaID = PC.CampaniaID
WHERE 
	PC.CodigoTipoOferta not in (
		select Codigo from ShowRoom.TipoOferta where Activo = 1
	)
	AND CA.Codigo = @CampaniaID
ORDER BY CUV desc

end

go

ALTER PROCEDURE ShowRoom.InsOfertaShowRoom
(	
	@CampaniaID int,
	@CUV varchar(20),
	@TipoOfertaSisID int,
	@ConfiguracionOfertaID int,
	@Descripcion varchar(250),
	@PrecioValorizado numeric(12,2),
	@ImagenProducto varchar(150),
	@Orden int,
	@UnidadesPermitidas int,
	@FlagHabilitarProducto int,
	@DescripcionLegal varchar(250),
	@UsuarioRegistro varchar(50),
	@ImagenMini varchar(150),
	@PrecioOferta decimal(12,2)=0,
	@EsSubCampania bit
)
AS
BEGIN
	INSERT INTO ShowRoom.OfertaShowRoom
	(
		CampaniaID, CUV, TipoOfertaSisID, ConfiguracionOfertaID, Descripcion, PrecioValorizado, Stock, StockInicial, ImagenProducto,
		Orden, UnidadesPermitidas, FlagHabilitarProducto, DescripcionLegal, UsuarioRegistro, FechaRegistro, ImagenMini, PrecioOferta,
		EsSubCampania
	)
	VALUES
	(
		@CampaniaID, @CUV, @TipoOfertaSisID, @ConfiguracionOfertaID, @Descripcion, @PrecioValorizado , 0, 0, @ImagenProducto, 
		@Orden, @UnidadesPermitidas, @FlagHabilitarProducto, @DescripcionLegal, @UsuarioRegistro, getdate(), @ImagenMini, @PrecioOferta,
		@EsSubCampania
	)
END

go

ALTER PROCEDURE ShowRoom.UpdOfertaShowRoom
(
	@TipoOfertaSisID int,
	@CampaniaID int,
	@CUV varchar(20),
	@Descripcion varchar(250),
	@ImagenProducto varchar(150),
	@UnidadesPermitidas int,
	@FlagHabilitarProducto int,
	@Orden int,
	@DescripcionLegal varchar(250),
	@UsuarioModificacion varchar(50),
	@PrecioValorizado decimal(18,2),
	@ImagenMini varchar(150),
	@Incrementa int,
	@CantidadIncrementa int,
	@FlagAgotado int,
	@PrecioOferta decimal(18,2)=0,
	@EsSubCampania bit
)
AS
BEGIN
	UPDATE ShowRoom.OfertaShowRoom
		SET Descripcion = @Descripcion,
			UnidadesPermitidas = @UnidadesPermitidas,
			FlagHabilitarProducto = @FlagHabilitarProducto,
			Orden = @Orden,
			ImagenProducto = @ImagenProducto,
			DescripcionLegal = @DescripcionLegal,
			UsuarioModificacion = @UsuarioModificacion,
			PrecioValorizado = @PrecioValorizado,
			FechaModificacion = getdate(),
			ImagenMini = @ImagenMini,
			Stock = (CASE WHEN @Incrementa = 0 AND @FlagAgotado = 0 THEN Stock + @CantidadIncrementa 
							WHEN @Incrementa = 1 AND @FlagAgotado = 0 THEN Stock - @CantidadIncrementa 
							WHEN @FlagAgotado = 1 THEN 0 END),
			StockInicial = (CASE WHEN @Incrementa = 0 THEN StockInicial + @CantidadIncrementa 
							ELSE StockInicial - @CantidadIncrementa END),
			PrecioOferta = @PrecioOferta,
			EsSubCampania = @EsSubCampania
	where 	
	CampaniaID = @CampaniaID
		AND CUV = @CUV
END

go

ALTER PROCEDURE [ShowRoom].[GetShowRoomPerfilOfertaCuvs]
@EventoID int,
@PerfilID int,
@CampaniaID int
as
/*
ShowRoom.GetShowRoomPerfilOfertaCuvs 1,1,201611
ShowRoom.GetShowRoomPerfilOfertaCuvs 6,47,201707
*/
begin

select 
	isnull(p.PerfilOfertaShowRoomID,0) as PerfilOfertaShowRoomID,
	isnull(p.EventoID,0) as EventoID,
	isnull(p.PerfilID,0) as PerfilID,
	c.Codigo as CampaniaID,
	o.CUV,
	isnull(p.Orden,9999) as Orden,
	o.EsSubCampania
from ShowRoom.OfertaShowRoom o
inner join ods.Campania c on
	o.CampaniaID = c.CampaniaID
left join ShowRoom.PerfilOfertaShowRoom p on
	p.CampaniaID = c.Codigo
	and o.CUV = p.CUV
	and p.PerfilID = @PerfilID
	and p.EventoID = @EventoID
where 
	c.Codigo = @CampaniaID
order by isnull(p.Orden,9999)

end

go

USE BelcorpSalvador
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.Evento') and SYSCOLUMNS.NAME = N'TieneSubCampania') = 0
	ALTER TABLE ShowRoom.Evento ADD TieneSubCampania bit
go

update ShowRoom.Evento set TieneSubCampania = 0 where TieneSubCampania is null

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'EsSubCampania') = 0
	ALTER TABLE ShowRoom.OfertaShowRoom ADD EsSubCampania bit
go

update ShowRoom.OfertaShowRoom set EsSubCampania = 0 where EsSubCampania is null

go

alter procedure ShowRoom.GetShowRoomEventoByCampaniaID
@CampaniaID int
as
/*
ShowRoom.GetShowRoomEventoByCampaniaID 201707
*/
begin

select
	EventoID,
	CampaniaID,
	Nombre,
	Imagen1,
	Imagen2,
	Descuento,
	FechaCreacion,
	UsuarioCreacion,
	FechaModificacion,
	UsuarioModificacion,
	TextoEstrategia,
	OfertaEstrategia,
	Tema,
	DiasAntes,
	DiasDespues,
	NumeroPerfiles,
	ImagenCabeceraProducto,
	ImagenVentaSetPopup,
	ImagenVentaTagLateral,
	ImagenPestaniaShowRoom,
	Estado,
	RutaShowRoomPopup,
	RutaShowRoomBannerLateral,
	ImagenPreventaDigital,
	isnull(TieneCategoria,0) as TieneCategoria,
	isnull(TieneCompraXcompra,0) as TieneCompraXcompra,
	isnull(TieneSubCampania,0) as TieneSubCampania
from ShowRoom.Evento
where CampaniaID = @CampaniaID

end

go

alter procedure ShowRoom.InsertShowRoomEvento
@EventoID int output,
@CampaniaID int,
@Nombre varchar(150),
@Tema varchar(150),
@DiasAntes int,
@DiasDespues int,
@NumeroPerfiles int,
@UsuarioCreacion varchar(20),
@TieneCategoria bit,
@TieneCompraXcompra bit,
@TieneSubCampania bit
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

insert into ShowRoom.Evento
(CampaniaID, Nombre, Tema, DiasAntes, DiasDespues, NumeroPerfiles, 
FechaCreacion, UsuarioCreacion, FechaModificacion, UsuarioModificacion, 
Estado, TieneCategoria, TieneCompraXcompra, TieneSubCampania)
values
(@CampaniaID, @Nombre, @Tema, @DiasAntes, @DiasDespues, @NumeroPerfiles,
@FechaGeneral, @UsuarioCreacion, @FechaGeneral, @UsuarioCreacion, 
1, @TieneCategoria, @TieneCompraXcompra, @TieneSubCampania)

set @EventoID = @@IDENTITY

end

go

alter procedure ShowRoom.UpdateShowRoomEvento
@EventoID int,
@CampaniaID int,
@Nombre varchar(150),
@Tema varchar(150),
@DiasAntes int,
@DiasDespues int,
@NumeroPerfiles int,
@UsuarioModificacion varchar(20),
@Estado int,
@TieneCategoria bit,
@TieneCompraXcompra bit,
@TieneSubCampania bit
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

update ShowRoom.Evento
set
	CampaniaID = @CampaniaID,
	Nombre = @Nombre,
	Tema = @Tema,
	DiasAntes = @DiasAntes,
	DiasDespues = @DiasDespues,	
	NumeroPerfiles = @NumeroPerfiles,
	FechaModificacion = @FechaGeneral,
	UsuarioModificacion = @UsuarioModificacion,
	Estado = @Estado,
	TieneCategoria = @TieneCategoria,
	TieneCompraXcompra = @TieneCompraXcompra,
	TieneSubCampania = @TieneSubCampania
where EventoID = @EventoID

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[UpdStockOfertaShowRoomMasivo]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].UpdStockOfertaShowRoomMasivo
GO

go

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
	[PrecioValorizado] [decimal](18, 2) NULL,
	[PrecioOferta] [decimal](18, 2) NULL,	
	[UnidadesPermitidas] [int] NULL,
	[Descripcion] [varchar](250) NULL,
	[CodigoCategoria] [varchar](100) NULL,
	[TipNegocio] [varchar](500) NULL,
	[EsSubCampania] [bit] NULL	
)
GO

create procedure ShowRoom.UpdStockOfertaShowRoomMasivo
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
	TipNegocio = t.TipNegocio,
	PrecioValorizado = t.PrecioValorizado,
	EsSubCampania = t.EsSubCampania
FROM ShowRoom.OfertaShowRoom o
INNER JOIN ods.Campania c on 
	c.CampaniaID = o.CampaniaID
JOIN @StockPrecioOfertaShowRoom t ON 
	c.Codigo = t.CampaniaID
	AND o.CUV = t.CUV
	AND o.TipoOfertaSisID = t.TipoOfertaSisID

end

go

alter procedure ShowRoom.GetShowRoomOfertasConsultora
@CampaniaID int,
@CodigoConsultora varchar(20)
as
/*
ShowRoom.GetShowRoomOfertasConsultora 201706,'0012954'
ShowRoom.GetShowRoomOfertasConsultora 201706,'1615995'
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
o.OfertaShowRoomID,o.CampaniaID,o.CUV,o.TipoOfertaSisID,o.ConfiguracionOfertaID,o.Descripcion,
o.PrecioValorizado,
COALESCE(o.PrecioOferta,pc.PrecioCatalogo) AS PrecioOferta,
o.Stock,
o.StockInicial,o.ImagenProducto,o.UnidadesPermitidas,o.FlagHabilitarProducto,o.DescripcionLegal,o.UsuarioRegistro,
o.FechaRegistro,o.UsuarioModificacion,o.FechaModificacion,o.ImagenMini,pc.MarcaID, pos.Orden, o.CodigoCategoria, o.TipNegocio,
pc.CodigoProducto, cat.Descripcion as DescripcionCategoria, o.EsSubCampania
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

go

alter procedure ShowRoom.GetProductosShowRoom
@CampaniaID int
as
/*
ShowRoom.GetProductosShowRoom 201707
*/
begin

declare @ConfiguracionOfertaID int = 0
select @ConfiguracionOfertaID=ConfiguracionOfertaID from ConfiguracionOferta where TipoOfertaSisID = 1707

select 
	ISNULL(OS.OfertaShowRoomID,0) OfertaShowRoomID,
	ROW_NUMBER() OVER (ORDER BY (SELECT 1)) as NroOrden,
	PC.CampaniaID,
	CA.Codigo as CodigoCampania,
	PC.CUV,
	PC.CodigoTipoOferta,
	ISNULL(OS.Descripcion,PC.Descripcion) as Descripcion,
	COALESCE(OS.PrecioValorizado,PC.PrecioValorizado) as PrecioValorizado,
	COALESCE(OS.PrecioOferta,PC.PrecioCatalogo) as PrecioOferta,
	ISNULL(OS.Stock,0) Stock,
	ISNULL(OS.StockInicial,0) StockInicial,
	ISNULL(OS.ImagenProducto,'') ImagenProducto,
	ISNULL(OS.UnidadesPermitidas,'') UnidadesPermitidas,
	ISNULL(OS.FlagHabilitarProducto,0) FlagHabilitarProducto,
	OS.Orden,
	PC.CodigoProducto,
	ISNULL(OS.DescripcionLegal,'') DescripcionLegal,
	ISNULL(OS.ImagenMini,'') ImagenMini,
	@ConfiguracionOfertaID as ConfiguracionOfertaID,
	ISNULL(OS.EsSubCampania,0) as EsSubCampania
FROM ods.ProductoComercial PC WITH (NOLOCK)
INNER JOIN ods.Campania CA WITH (NOLOCK) ON 
	CA.CampaniaID = PC.CampaniaID
LEFT JOIN ShowRoom.OfertaShowRoom OS WITH(NOLOCK) ON 
	OS.CUV = PC.CUV 
	AND OS.CampaniaID = PC.CampaniaID
WHERE 
	PC.CodigoTipoOferta in (
		select Codigo from ShowRoom.TipoOferta where Activo = 1
	)
	AND CA.Codigo = @CampaniaID
union all
select 
	ISNULL(OS.OfertaShowRoomID,0) OfertaShowRoomID,
	ROW_NUMBER() OVER (ORDER BY (SELECT 1)) as NroOrden,
	PC.CampaniaID,
	CA.Codigo as CodigoCampania,
	PC.CUV,
	PC.CodigoTipoOferta,
	ISNULL(OS.Descripcion,PC.Descripcion) as Descripcion,
	COALESCE(OS.PrecioValorizado,PC.PrecioValorizado) as PrecioValorizado,
	COALESCE(OS.PrecioOferta,PC.PrecioCatalogo) as PrecioOferta,
	ISNULL(OS.Stock,0) Stock,
	ISNULL(OS.StockInicial,0) StockInicial,
	ISNULL(OS.ImagenProducto,'') ImagenProducto,
	ISNULL(OS.UnidadesPermitidas,'') UnidadesPermitidas,
	ISNULL(OS.FlagHabilitarProducto,0) FlagHabilitarProducto,
	OS.Orden,
	PC.CodigoProducto,
	ISNULL(OS.DescripcionLegal,'') DescripcionLegal,
	ISNULL(OS.ImagenMini,'') ImagenMini,
	@ConfiguracionOfertaID as ConfiguracionOfertaID,
	ISNULL(OS.EsSubCampania,0) as EsSubCampania
FROM ods.ProductoComercial PC WITH (NOLOCK)
INNER JOIN ods.Campania CA WITH (NOLOCK) ON 
	CA.CampaniaID = PC.CampaniaID
INNER JOIN ShowRoom.OfertaShowRoom OS WITH(NOLOCK) ON 
	OS.CUV = PC.CUV 
	AND OS.CampaniaID = PC.CampaniaID
WHERE 
	PC.CodigoTipoOferta not in (
		select Codigo from ShowRoom.TipoOferta where Activo = 1
	)
	AND CA.Codigo = @CampaniaID
ORDER BY CUV desc

end

go

ALTER PROCEDURE ShowRoom.InsOfertaShowRoom
(	
	@CampaniaID int,
	@CUV varchar(20),
	@TipoOfertaSisID int,
	@ConfiguracionOfertaID int,
	@Descripcion varchar(250),
	@PrecioValorizado numeric(12,2),
	@ImagenProducto varchar(150),
	@Orden int,
	@UnidadesPermitidas int,
	@FlagHabilitarProducto int,
	@DescripcionLegal varchar(250),
	@UsuarioRegistro varchar(50),
	@ImagenMini varchar(150),
	@PrecioOferta decimal(12,2)=0,
	@EsSubCampania bit
)
AS
BEGIN
	INSERT INTO ShowRoom.OfertaShowRoom
	(
		CampaniaID, CUV, TipoOfertaSisID, ConfiguracionOfertaID, Descripcion, PrecioValorizado, Stock, StockInicial, ImagenProducto,
		Orden, UnidadesPermitidas, FlagHabilitarProducto, DescripcionLegal, UsuarioRegistro, FechaRegistro, ImagenMini, PrecioOferta,
		EsSubCampania
	)
	VALUES
	(
		@CampaniaID, @CUV, @TipoOfertaSisID, @ConfiguracionOfertaID, @Descripcion, @PrecioValorizado , 0, 0, @ImagenProducto, 
		@Orden, @UnidadesPermitidas, @FlagHabilitarProducto, @DescripcionLegal, @UsuarioRegistro, getdate(), @ImagenMini, @PrecioOferta,
		@EsSubCampania
	)
END

go

ALTER PROCEDURE ShowRoom.UpdOfertaShowRoom
(
	@TipoOfertaSisID int,
	@CampaniaID int,
	@CUV varchar(20),
	@Descripcion varchar(250),
	@ImagenProducto varchar(150),
	@UnidadesPermitidas int,
	@FlagHabilitarProducto int,
	@Orden int,
	@DescripcionLegal varchar(250),
	@UsuarioModificacion varchar(50),
	@PrecioValorizado decimal(18,2),
	@ImagenMini varchar(150),
	@Incrementa int,
	@CantidadIncrementa int,
	@FlagAgotado int,
	@PrecioOferta decimal(18,2)=0,
	@EsSubCampania bit
)
AS
BEGIN
	UPDATE ShowRoom.OfertaShowRoom
		SET Descripcion = @Descripcion,
			UnidadesPermitidas = @UnidadesPermitidas,
			FlagHabilitarProducto = @FlagHabilitarProducto,
			Orden = @Orden,
			ImagenProducto = @ImagenProducto,
			DescripcionLegal = @DescripcionLegal,
			UsuarioModificacion = @UsuarioModificacion,
			PrecioValorizado = @PrecioValorizado,
			FechaModificacion = getdate(),
			ImagenMini = @ImagenMini,
			Stock = (CASE WHEN @Incrementa = 0 AND @FlagAgotado = 0 THEN Stock + @CantidadIncrementa 
							WHEN @Incrementa = 1 AND @FlagAgotado = 0 THEN Stock - @CantidadIncrementa 
							WHEN @FlagAgotado = 1 THEN 0 END),
			StockInicial = (CASE WHEN @Incrementa = 0 THEN StockInicial + @CantidadIncrementa 
							ELSE StockInicial - @CantidadIncrementa END),
			PrecioOferta = @PrecioOferta,
			EsSubCampania = @EsSubCampania
	where 	
	CampaniaID = @CampaniaID
		AND CUV = @CUV
END

go

ALTER PROCEDURE [ShowRoom].[GetShowRoomPerfilOfertaCuvs]
@EventoID int,
@PerfilID int,
@CampaniaID int
as
/*
ShowRoom.GetShowRoomPerfilOfertaCuvs 1,1,201611
ShowRoom.GetShowRoomPerfilOfertaCuvs 6,47,201707
*/
begin

select 
	isnull(p.PerfilOfertaShowRoomID,0) as PerfilOfertaShowRoomID,
	isnull(p.EventoID,0) as EventoID,
	isnull(p.PerfilID,0) as PerfilID,
	c.Codigo as CampaniaID,
	o.CUV,
	isnull(p.Orden,9999) as Orden,
	o.EsSubCampania
from ShowRoom.OfertaShowRoom o
inner join ods.Campania c on
	o.CampaniaID = c.CampaniaID
left join ShowRoom.PerfilOfertaShowRoom p on
	p.CampaniaID = c.Codigo
	and o.CUV = p.CUV
	and p.PerfilID = @PerfilID
	and p.EventoID = @EventoID
where 
	c.Codigo = @CampaniaID
order by isnull(p.Orden,9999)

end

go

USE BelcorpVenezuela
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.Evento') and SYSCOLUMNS.NAME = N'TieneSubCampania') = 0
	ALTER TABLE ShowRoom.Evento ADD TieneSubCampania bit
go

update ShowRoom.Evento set TieneSubCampania = 0 where TieneSubCampania is null

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'EsSubCampania') = 0
	ALTER TABLE ShowRoom.OfertaShowRoom ADD EsSubCampania bit
go

update ShowRoom.OfertaShowRoom set EsSubCampania = 0 where EsSubCampania is null

go

alter procedure ShowRoom.GetShowRoomEventoByCampaniaID
@CampaniaID int
as
/*
ShowRoom.GetShowRoomEventoByCampaniaID 201707
*/
begin

select
	EventoID,
	CampaniaID,
	Nombre,
	Imagen1,
	Imagen2,
	Descuento,
	FechaCreacion,
	UsuarioCreacion,
	FechaModificacion,
	UsuarioModificacion,
	TextoEstrategia,
	OfertaEstrategia,
	Tema,
	DiasAntes,
	DiasDespues,
	NumeroPerfiles,
	ImagenCabeceraProducto,
	ImagenVentaSetPopup,
	ImagenVentaTagLateral,
	ImagenPestaniaShowRoom,
	Estado,
	RutaShowRoomPopup,
	RutaShowRoomBannerLateral,
	ImagenPreventaDigital,
	isnull(TieneCategoria,0) as TieneCategoria,
	isnull(TieneCompraXcompra,0) as TieneCompraXcompra,
	isnull(TieneSubCampania,0) as TieneSubCampania
from ShowRoom.Evento
where CampaniaID = @CampaniaID

end

go

alter procedure ShowRoom.InsertShowRoomEvento
@EventoID int output,
@CampaniaID int,
@Nombre varchar(150),
@Tema varchar(150),
@DiasAntes int,
@DiasDespues int,
@NumeroPerfiles int,
@UsuarioCreacion varchar(20),
@TieneCategoria bit,
@TieneCompraXcompra bit,
@TieneSubCampania bit
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

insert into ShowRoom.Evento
(CampaniaID, Nombre, Tema, DiasAntes, DiasDespues, NumeroPerfiles, 
FechaCreacion, UsuarioCreacion, FechaModificacion, UsuarioModificacion, 
Estado, TieneCategoria, TieneCompraXcompra, TieneSubCampania)
values
(@CampaniaID, @Nombre, @Tema, @DiasAntes, @DiasDespues, @NumeroPerfiles,
@FechaGeneral, @UsuarioCreacion, @FechaGeneral, @UsuarioCreacion, 
1, @TieneCategoria, @TieneCompraXcompra, @TieneSubCampania)

set @EventoID = @@IDENTITY

end

go

alter procedure ShowRoom.UpdateShowRoomEvento
@EventoID int,
@CampaniaID int,
@Nombre varchar(150),
@Tema varchar(150),
@DiasAntes int,
@DiasDespues int,
@NumeroPerfiles int,
@UsuarioModificacion varchar(20),
@Estado int,
@TieneCategoria bit,
@TieneCompraXcompra bit,
@TieneSubCampania bit
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

update ShowRoom.Evento
set
	CampaniaID = @CampaniaID,
	Nombre = @Nombre,
	Tema = @Tema,
	DiasAntes = @DiasAntes,
	DiasDespues = @DiasDespues,	
	NumeroPerfiles = @NumeroPerfiles,
	FechaModificacion = @FechaGeneral,
	UsuarioModificacion = @UsuarioModificacion,
	Estado = @Estado,
	TieneCategoria = @TieneCategoria,
	TieneCompraXcompra = @TieneCompraXcompra,
	TieneSubCampania = @TieneSubCampania
where EventoID = @EventoID

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[UpdStockOfertaShowRoomMasivo]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].UpdStockOfertaShowRoomMasivo
GO

go

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
	[PrecioValorizado] [decimal](18, 2) NULL,
	[PrecioOferta] [decimal](18, 2) NULL,	
	[UnidadesPermitidas] [int] NULL,
	[Descripcion] [varchar](250) NULL,
	[CodigoCategoria] [varchar](100) NULL,
	[TipNegocio] [varchar](500) NULL,
	[EsSubCampania] [bit] NULL	
)
GO

create procedure ShowRoom.UpdStockOfertaShowRoomMasivo
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
	TipNegocio = t.TipNegocio,
	PrecioValorizado = t.PrecioValorizado,
	EsSubCampania = t.EsSubCampania
FROM ShowRoom.OfertaShowRoom o
INNER JOIN ods.Campania c on 
	c.CampaniaID = o.CampaniaID
JOIN @StockPrecioOfertaShowRoom t ON 
	c.Codigo = t.CampaniaID
	AND o.CUV = t.CUV
	AND o.TipoOfertaSisID = t.TipoOfertaSisID

end

go

alter procedure ShowRoom.GetShowRoomOfertasConsultora
@CampaniaID int,
@CodigoConsultora varchar(20)
as
/*
ShowRoom.GetShowRoomOfertasConsultora 201706,'0012954'
ShowRoom.GetShowRoomOfertasConsultora 201706,'1615995'
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
o.OfertaShowRoomID,o.CampaniaID,o.CUV,o.TipoOfertaSisID,o.ConfiguracionOfertaID,o.Descripcion,
o.PrecioValorizado,
COALESCE(o.PrecioOferta,pc.PrecioCatalogo) AS PrecioOferta,
o.Stock,
o.StockInicial,o.ImagenProducto,o.UnidadesPermitidas,o.FlagHabilitarProducto,o.DescripcionLegal,o.UsuarioRegistro,
o.FechaRegistro,o.UsuarioModificacion,o.FechaModificacion,o.ImagenMini,pc.MarcaID, pos.Orden, o.CodigoCategoria, o.TipNegocio,
pc.CodigoProducto, cat.Descripcion as DescripcionCategoria, o.EsSubCampania
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

go

alter procedure ShowRoom.GetProductosShowRoom
@CampaniaID int
as
/*
ShowRoom.GetProductosShowRoom 201707
*/
begin

declare @ConfiguracionOfertaID int = 0
select @ConfiguracionOfertaID=ConfiguracionOfertaID from ConfiguracionOferta where TipoOfertaSisID = 1707

select 
	ISNULL(OS.OfertaShowRoomID,0) OfertaShowRoomID,
	ROW_NUMBER() OVER (ORDER BY (SELECT 1)) as NroOrden,
	PC.CampaniaID,
	CA.Codigo as CodigoCampania,
	PC.CUV,
	PC.CodigoTipoOferta,
	ISNULL(OS.Descripcion,PC.Descripcion) as Descripcion,
	COALESCE(OS.PrecioValorizado,PC.PrecioValorizado) as PrecioValorizado,
	COALESCE(OS.PrecioOferta,PC.PrecioCatalogo) as PrecioOferta,
	ISNULL(OS.Stock,0) Stock,
	ISNULL(OS.StockInicial,0) StockInicial,
	ISNULL(OS.ImagenProducto,'') ImagenProducto,
	ISNULL(OS.UnidadesPermitidas,'') UnidadesPermitidas,
	ISNULL(OS.FlagHabilitarProducto,0) FlagHabilitarProducto,
	OS.Orden,
	PC.CodigoProducto,
	ISNULL(OS.DescripcionLegal,'') DescripcionLegal,
	ISNULL(OS.ImagenMini,'') ImagenMini,
	@ConfiguracionOfertaID as ConfiguracionOfertaID,
	ISNULL(OS.EsSubCampania,0) as EsSubCampania
FROM ods.ProductoComercial PC WITH (NOLOCK)
INNER JOIN ods.Campania CA WITH (NOLOCK) ON 
	CA.CampaniaID = PC.CampaniaID
LEFT JOIN ShowRoom.OfertaShowRoom OS WITH(NOLOCK) ON 
	OS.CUV = PC.CUV 
	AND OS.CampaniaID = PC.CampaniaID
WHERE 
	PC.CodigoTipoOferta in (
		select Codigo from ShowRoom.TipoOferta where Activo = 1
	)
	AND CA.Codigo = @CampaniaID
union all
select 
	ISNULL(OS.OfertaShowRoomID,0) OfertaShowRoomID,
	ROW_NUMBER() OVER (ORDER BY (SELECT 1)) as NroOrden,
	PC.CampaniaID,
	CA.Codigo as CodigoCampania,
	PC.CUV,
	PC.CodigoTipoOferta,
	ISNULL(OS.Descripcion,PC.Descripcion) as Descripcion,
	COALESCE(OS.PrecioValorizado,PC.PrecioValorizado) as PrecioValorizado,
	COALESCE(OS.PrecioOferta,PC.PrecioCatalogo) as PrecioOferta,
	ISNULL(OS.Stock,0) Stock,
	ISNULL(OS.StockInicial,0) StockInicial,
	ISNULL(OS.ImagenProducto,'') ImagenProducto,
	ISNULL(OS.UnidadesPermitidas,'') UnidadesPermitidas,
	ISNULL(OS.FlagHabilitarProducto,0) FlagHabilitarProducto,
	OS.Orden,
	PC.CodigoProducto,
	ISNULL(OS.DescripcionLegal,'') DescripcionLegal,
	ISNULL(OS.ImagenMini,'') ImagenMini,
	@ConfiguracionOfertaID as ConfiguracionOfertaID,
	ISNULL(OS.EsSubCampania,0) as EsSubCampania
FROM ods.ProductoComercial PC WITH (NOLOCK)
INNER JOIN ods.Campania CA WITH (NOLOCK) ON 
	CA.CampaniaID = PC.CampaniaID
INNER JOIN ShowRoom.OfertaShowRoom OS WITH(NOLOCK) ON 
	OS.CUV = PC.CUV 
	AND OS.CampaniaID = PC.CampaniaID
WHERE 
	PC.CodigoTipoOferta not in (
		select Codigo from ShowRoom.TipoOferta where Activo = 1
	)
	AND CA.Codigo = @CampaniaID
ORDER BY CUV desc

end

go

ALTER PROCEDURE ShowRoom.InsOfertaShowRoom
(	
	@CampaniaID int,
	@CUV varchar(20),
	@TipoOfertaSisID int,
	@ConfiguracionOfertaID int,
	@Descripcion varchar(250),
	@PrecioValorizado numeric(12,2),
	@ImagenProducto varchar(150),
	@Orden int,
	@UnidadesPermitidas int,
	@FlagHabilitarProducto int,
	@DescripcionLegal varchar(250),
	@UsuarioRegistro varchar(50),
	@ImagenMini varchar(150),
	@PrecioOferta decimal(12,2)=0,
	@EsSubCampania bit
)
AS
BEGIN
	INSERT INTO ShowRoom.OfertaShowRoom
	(
		CampaniaID, CUV, TipoOfertaSisID, ConfiguracionOfertaID, Descripcion, PrecioValorizado, Stock, StockInicial, ImagenProducto,
		Orden, UnidadesPermitidas, FlagHabilitarProducto, DescripcionLegal, UsuarioRegistro, FechaRegistro, ImagenMini, PrecioOferta,
		EsSubCampania
	)
	VALUES
	(
		@CampaniaID, @CUV, @TipoOfertaSisID, @ConfiguracionOfertaID, @Descripcion, @PrecioValorizado , 0, 0, @ImagenProducto, 
		@Orden, @UnidadesPermitidas, @FlagHabilitarProducto, @DescripcionLegal, @UsuarioRegistro, getdate(), @ImagenMini, @PrecioOferta,
		@EsSubCampania
	)
END

go

ALTER PROCEDURE ShowRoom.UpdOfertaShowRoom
(
	@TipoOfertaSisID int,
	@CampaniaID int,
	@CUV varchar(20),
	@Descripcion varchar(250),
	@ImagenProducto varchar(150),
	@UnidadesPermitidas int,
	@FlagHabilitarProducto int,
	@Orden int,
	@DescripcionLegal varchar(250),
	@UsuarioModificacion varchar(50),
	@PrecioValorizado decimal(18,2),
	@ImagenMini varchar(150),
	@Incrementa int,
	@CantidadIncrementa int,
	@FlagAgotado int,
	@PrecioOferta decimal(18,2)=0,
	@EsSubCampania bit
)
AS
BEGIN
	UPDATE ShowRoom.OfertaShowRoom
		SET Descripcion = @Descripcion,
			UnidadesPermitidas = @UnidadesPermitidas,
			FlagHabilitarProducto = @FlagHabilitarProducto,
			Orden = @Orden,
			ImagenProducto = @ImagenProducto,
			DescripcionLegal = @DescripcionLegal,
			UsuarioModificacion = @UsuarioModificacion,
			PrecioValorizado = @PrecioValorizado,
			FechaModificacion = getdate(),
			ImagenMini = @ImagenMini,
			Stock = (CASE WHEN @Incrementa = 0 AND @FlagAgotado = 0 THEN Stock + @CantidadIncrementa 
							WHEN @Incrementa = 1 AND @FlagAgotado = 0 THEN Stock - @CantidadIncrementa 
							WHEN @FlagAgotado = 1 THEN 0 END),
			StockInicial = (CASE WHEN @Incrementa = 0 THEN StockInicial + @CantidadIncrementa 
							ELSE StockInicial - @CantidadIncrementa END),
			PrecioOferta = @PrecioOferta,
			EsSubCampania = @EsSubCampania
	where 	
	CampaniaID = @CampaniaID
		AND CUV = @CUV
END

go

ALTER PROCEDURE [ShowRoom].[GetShowRoomPerfilOfertaCuvs]
@EventoID int,
@PerfilID int,
@CampaniaID int
as
/*
ShowRoom.GetShowRoomPerfilOfertaCuvs 1,1,201611
ShowRoom.GetShowRoomPerfilOfertaCuvs 6,47,201707
*/
begin

select 
	isnull(p.PerfilOfertaShowRoomID,0) as PerfilOfertaShowRoomID,
	isnull(p.EventoID,0) as EventoID,
	isnull(p.PerfilID,0) as PerfilID,
	c.Codigo as CampaniaID,
	o.CUV,
	isnull(p.Orden,9999) as Orden,
	o.EsSubCampania
from ShowRoom.OfertaShowRoom o
inner join ods.Campania c on
	o.CampaniaID = c.CampaniaID
left join ShowRoom.PerfilOfertaShowRoom p on
	p.CampaniaID = c.Codigo
	and o.CUV = p.CUV
	and p.PerfilID = @PerfilID
	and p.EventoID = @EventoID
where 
	c.Codigo = @CampaniaID
order by isnull(p.Orden,9999)

end

go