USE BelcorpBolivia
go

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[TipoOferta]') AND (type = 'U') )
	DROP TABLE ShowRoom.TipoOferta
GO

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'PrecioOferta') = 1
	EXEC sp_RENAME 'ShowRoom.OfertaShowRoom.PrecioOferta' , 'PrecioOferta2', 'COLUMN' 
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'PrecioValorizado') = 1
	EXEC sp_RENAME 'ShowRoom.OfertaShowRoom.PrecioValorizado' , 'PrecioOferta', 'COLUMN' 
go

ALTER procedure ShowRoom.GetProductosShowRoom
@TipoOfertaSisID int,
@CampaniaID int,
@CodigoOferta varchar(8)
as
/*
ShowRoom.GetProductosShowRoom 1707,201706,'105'
*/
begin

select 
	ISNULL(OS.OfertaShowRoomID,0) OfertaShowRoomID,
	ISNULL(CO.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
	ROW_NUMBER() OVER (ORDER BY (SELECT 1)) as NroOrden,
	PC.CampaniaID,
	CA.Codigo as CodigoCampania,
	PC.CUV,
	PC.CodigoTipoOferta,
	CO.Descripcion as TipoOferta,
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
INNER JOIN ConfiguracionOferta CO ON 
	CO.CodigoOferta = PC.CodigoTipoOferta
LEFT JOIN ShowRoom.OfertaShowRoom OS WITH(NOLOCK) ON 
	OS.CUV = PC.CUV 
	AND OS.CampaniaID = PC.CampaniaID
WHERE 
	PC.CodigoTipoOferta = @CodigoOferta
	AND CA.Codigo = @CampaniaID
ORDER BY CO.Descripcion, OS.CUV desc

end

go

ALTER PROCEDURE ShowRoom.InsOfertaShowRoom
(	
	@CampaniaID int,
	@CUV varchar(20),
	@TipoOfertaSisID int,
	@ConfiguracionOfertaID int,
	@Descripcion varchar(250),
	@PrecioOferta numeric(12,2),
	@ImagenProducto varchar(150),
	@Orden int,
	@UnidadesPermitidas int,
	@FlagHabilitarProducto int,
	@DescripcionLegal varchar(250),
	@UsuarioRegistro varchar(50),
	@ImagenMini varchar(150),
	@PrecioOferta2 decimal(12,2)=0
)
AS
BEGIN
	INSERT INTO ShowRoom.OfertaShowRoom
	(
		CampaniaID, CUV, TipoOfertaSisID, ConfiguracionOfertaID, Descripcion, PrecioOferta, Stock, StockInicial, ImagenProducto,
		Orden, UnidadesPermitidas, FlagHabilitarProducto, DescripcionLegal, UsuarioRegistro, FechaRegistro, ImagenMini, PrecioOferta2
	)
	VALUES
	(
		@CampaniaID, @CUV, @TipoOfertaSisID, @ConfiguracionOfertaID, @Descripcion, @PrecioOferta, 0, 0, @ImagenProducto, 
		@Orden, @UnidadesPermitidas, @FlagHabilitarProducto, @DescripcionLegal, @UsuarioRegistro, getdate(), @ImagenMini, @PrecioOferta2
	)
END

GO

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
	@PrecioOferta decimal(18,2),
	@ImagenMini varchar(150),
	@Incrementa int,
	@CantidadIncrementa int,
	@FlagAgotado int,
	@PrecioOferta2 decimal(18,2)=0
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
			PrecioOferta = @PrecioOferta,
			FechaModificacion = getdate(),
			ImagenMini = @ImagenMini,
			Stock = (CASE WHEN @Incrementa = 0 AND @FlagAgotado = 0 THEN Stock + @CantidadIncrementa 
							WHEN @Incrementa = 1 AND @FlagAgotado = 0 THEN Stock - @CantidadIncrementa 
							WHEN @FlagAgotado = 1 THEN 0 END),
			StockInicial = (CASE WHEN @Incrementa = 0 THEN StockInicial + @CantidadIncrementa 
							ELSE StockInicial - @CantidadIncrementa END),
			PrecioOferta2 = @PrecioOferta2
	where 
		CampaniaID = @CampaniaID
		AND CUV = @CUV
END

GO

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
	[PrecioOferta] [decimal](18, 2) NULL,
	[UnidadesPermitidas] [int] NULL,
	[Descripcion] [varchar](250) NULL,
	[CodigoCategoria] [varchar](100) NULL,
	[TipNegocio] [varchar](500) NULL
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
	UnidadesPermitidas = t.UnidadesPermitidas,
	Descripcion = t.Descripcion,
	CodigoCategoria = t.CodigoCategoria,
	TipNegocio = t.TipNegocio,
	PrecioOferta2 = t.PrecioOferta2
FROM ShowRoom.OfertaShowRoom o
INNER JOIN ods.Campania c on 
	c.CampaniaID = o.CampaniaID
JOIN @StockPrecioOfertaShowRoom t ON 
	c.Codigo = t.CampaniaID
	AND o.CUV = t.CUV
	AND o.TipoOfertaSisID = t.TipoOfertaSisID

end

GO

ALTER procedure ShowRoom.GetShowRoomOfertasConsultora
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
o.OfertaShowRoomID,o.CampaniaID,o.CUV,o.TipoOfertaSisID,o.ConfiguracionOfertaID,o.Descripcion,
o.PrecioOferta  AS PrecioOferta,
COALESCE(o.PrecioOferta2,pc.PrecioCatalogo) AS PrecioCatalogo,
o.Stock,
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

ALTER procedure [ShowRoom].[GetShowRoomCompraPorCompra]
(
@EventoID int,
@CampaniaID int
)
as
/*
ShowRoom.GetShowRoomCompraPorCompra 5,201705
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
	pc.PrecioCatalogo as PrecioCatalogo,
	MarcaID as MarcaID,
	Orden,
	SAP as CodigoProducto,
	cpc.PrecioValorizado as PrecioOferta	
from [ShowRoom].[CompraPorCompra] cpc 
inner join [ShowRoom].[Evento] e on cpc.EventoID = e.EventoID
inner join [ods].[Campania] c on e.CampaniaID = c.Codigo
inner join [ods].[ProductoComercial] pc on (c.CampaniaID = pc.CampaniaID and cpc.CUV = pc.CUV and cpc.SAP = pc.CodigoProducto)
where cpc.CUV not in (select distinct Cuv from @Productos_Faltantes_tmp)
and cpc.EventoID = @EventoID
end

go

ALTER PROCEDURE [ShowRoom].[GetShowRoomOfertaById] -- Alter the SP Always
 @OfertaShowRoomID int
AS
BEGIN
 
 SET NOCOUNT ON;
  
	select OfertaShowRoomID, CampaniaID, CUV, TipoOfertaSisID, ConfiguracionOfertaID, Descripcion,
	PrecioOferta, Stock, StockInicial, ImagenProducto, UnidadesPermitidas, FlagHabilitarProducto,
	DescripcionLegal, UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion,
	ImagenMini,Orden
	from showroom.ofertashowroom
	where OfertaShowRoomID = @OfertaShowRoomID
 
END

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomTipoOferta
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[ExisteShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].ExisteShowRoomTipoOferta
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[InsertShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].InsertShowRoomTipoOferta
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[UpdateShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].UpdateShowRoomTipoOferta
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[HabilitarShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].HabilitarShowRoomTipoOferta
GO

USE BelcorpChile
go

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[TipoOferta]') AND (type = 'U') )
	DROP TABLE ShowRoom.TipoOferta
GO

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'PrecioOferta') = 1
	EXEC sp_RENAME 'ShowRoom.OfertaShowRoom.PrecioOferta' , 'PrecioOferta2', 'COLUMN' 
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'PrecioValorizado') = 1
	EXEC sp_RENAME 'ShowRoom.OfertaShowRoom.PrecioValorizado' , 'PrecioOferta', 'COLUMN' 
go

ALTER procedure ShowRoom.GetProductosShowRoom
@TipoOfertaSisID int,
@CampaniaID int,
@CodigoOferta varchar(8)
as
/*
ShowRoom.GetProductosShowRoom 1707,201706,'105'
*/
begin

select 
	ISNULL(OS.OfertaShowRoomID,0) OfertaShowRoomID,
	ISNULL(CO.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
	ROW_NUMBER() OVER (ORDER BY (SELECT 1)) as NroOrden,
	PC.CampaniaID,
	CA.Codigo as CodigoCampania,
	PC.CUV,
	PC.CodigoTipoOferta,
	CO.Descripcion as TipoOferta,
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
INNER JOIN ConfiguracionOferta CO ON 
	CO.CodigoOferta = PC.CodigoTipoOferta
LEFT JOIN ShowRoom.OfertaShowRoom OS WITH(NOLOCK) ON 
	OS.CUV = PC.CUV 
	AND OS.CampaniaID = PC.CampaniaID
WHERE 
	PC.CodigoTipoOferta = @CodigoOferta
	AND CA.Codigo = @CampaniaID
ORDER BY CO.Descripcion, OS.CUV desc

end

go

ALTER PROCEDURE ShowRoom.InsOfertaShowRoom
(	
	@CampaniaID int,
	@CUV varchar(20),
	@TipoOfertaSisID int,
	@ConfiguracionOfertaID int,
	@Descripcion varchar(250),
	@PrecioOferta numeric(12,2),
	@ImagenProducto varchar(150),
	@Orden int,
	@UnidadesPermitidas int,
	@FlagHabilitarProducto int,
	@DescripcionLegal varchar(250),
	@UsuarioRegistro varchar(50),
	@ImagenMini varchar(150),
	@PrecioOferta2 decimal(12,2)=0
)
AS
BEGIN
	INSERT INTO ShowRoom.OfertaShowRoom
	(
		CampaniaID, CUV, TipoOfertaSisID, ConfiguracionOfertaID, Descripcion, PrecioOferta, Stock, StockInicial, ImagenProducto,
		Orden, UnidadesPermitidas, FlagHabilitarProducto, DescripcionLegal, UsuarioRegistro, FechaRegistro, ImagenMini, PrecioOferta2
	)
	VALUES
	(
		@CampaniaID, @CUV, @TipoOfertaSisID, @ConfiguracionOfertaID, @Descripcion, @PrecioOferta, 0, 0, @ImagenProducto, 
		@Orden, @UnidadesPermitidas, @FlagHabilitarProducto, @DescripcionLegal, @UsuarioRegistro, getdate(), @ImagenMini, @PrecioOferta2
	)
END

GO

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
	@PrecioOferta decimal(18,2),
	@ImagenMini varchar(150),
	@Incrementa int,
	@CantidadIncrementa int,
	@FlagAgotado int,
	@PrecioOferta2 decimal(18,2)=0
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
			PrecioOferta = @PrecioOferta,
			FechaModificacion = getdate(),
			ImagenMini = @ImagenMini,
			Stock = (CASE WHEN @Incrementa = 0 AND @FlagAgotado = 0 THEN Stock + @CantidadIncrementa 
							WHEN @Incrementa = 1 AND @FlagAgotado = 0 THEN Stock - @CantidadIncrementa 
							WHEN @FlagAgotado = 1 THEN 0 END),
			StockInicial = (CASE WHEN @Incrementa = 0 THEN StockInicial + @CantidadIncrementa 
							ELSE StockInicial - @CantidadIncrementa END),
			PrecioOferta2 = @PrecioOferta2
	where 
		CampaniaID = @CampaniaID
		AND CUV = @CUV
END

GO

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
	[PrecioOferta] [decimal](18, 2) NULL,
	[UnidadesPermitidas] [int] NULL,
	[Descripcion] [varchar](250) NULL,
	[CodigoCategoria] [varchar](100) NULL,
	[TipNegocio] [varchar](500) NULL
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
	UnidadesPermitidas = t.UnidadesPermitidas,
	Descripcion = t.Descripcion,
	CodigoCategoria = t.CodigoCategoria,
	TipNegocio = t.TipNegocio,
	PrecioOferta2 = t.PrecioOferta2
FROM ShowRoom.OfertaShowRoom o
INNER JOIN ods.Campania c on 
	c.CampaniaID = o.CampaniaID
JOIN @StockPrecioOfertaShowRoom t ON 
	c.Codigo = t.CampaniaID
	AND o.CUV = t.CUV
	AND o.TipoOfertaSisID = t.TipoOfertaSisID

end

GO

ALTER procedure ShowRoom.GetShowRoomOfertasConsultora
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
o.OfertaShowRoomID,o.CampaniaID,o.CUV,o.TipoOfertaSisID,o.ConfiguracionOfertaID,o.Descripcion,
o.PrecioOferta  AS PrecioOferta,
COALESCE(o.PrecioOferta2,pc.PrecioCatalogo) AS PrecioCatalogo,
o.Stock,
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

ALTER procedure [ShowRoom].[GetShowRoomCompraPorCompra]
(
@EventoID int,
@CampaniaID int
)
as
/*
ShowRoom.GetShowRoomCompraPorCompra 5,201705
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
	pc.PrecioCatalogo as PrecioCatalogo,
	MarcaID as MarcaID,
	Orden,
	SAP as CodigoProducto,
	cpc.PrecioValorizado as PrecioOferta	
from [ShowRoom].[CompraPorCompra] cpc 
inner join [ShowRoom].[Evento] e on cpc.EventoID = e.EventoID
inner join [ods].[Campania] c on e.CampaniaID = c.Codigo
inner join [ods].[ProductoComercial] pc on (c.CampaniaID = pc.CampaniaID and cpc.CUV = pc.CUV and cpc.SAP = pc.CodigoProducto)
where cpc.CUV not in (select distinct Cuv from @Productos_Faltantes_tmp)
and cpc.EventoID = @EventoID
end

go

ALTER PROCEDURE [ShowRoom].[GetShowRoomOfertaById] -- Alter the SP Always
 @OfertaShowRoomID int
AS
BEGIN
 
 SET NOCOUNT ON;
  
	select OfertaShowRoomID, CampaniaID, CUV, TipoOfertaSisID, ConfiguracionOfertaID, Descripcion,
	PrecioOferta, Stock, StockInicial, ImagenProducto, UnidadesPermitidas, FlagHabilitarProducto,
	DescripcionLegal, UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion,
	ImagenMini,Orden
	from showroom.ofertashowroom
	where OfertaShowRoomID = @OfertaShowRoomID
 
END

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomTipoOferta
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[ExisteShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].ExisteShowRoomTipoOferta
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[InsertShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].InsertShowRoomTipoOferta
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[UpdateShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].UpdateShowRoomTipoOferta
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[HabilitarShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].HabilitarShowRoomTipoOferta
GO

USE BelcorpColombia
go

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[TipoOferta]') AND (type = 'U') )
	DROP TABLE ShowRoom.TipoOferta
GO

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'PrecioOferta') = 1
	EXEC sp_RENAME 'ShowRoom.OfertaShowRoom.PrecioOferta' , 'PrecioOferta2', 'COLUMN' 
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'PrecioValorizado') = 1
	EXEC sp_RENAME 'ShowRoom.OfertaShowRoom.PrecioValorizado' , 'PrecioOferta', 'COLUMN' 
go

ALTER procedure ShowRoom.GetProductosShowRoom
@TipoOfertaSisID int,
@CampaniaID int,
@CodigoOferta varchar(8)
as
/*
ShowRoom.GetProductosShowRoom 1707,201706,'105'
*/
begin

select 
	ISNULL(OS.OfertaShowRoomID,0) OfertaShowRoomID,
	ISNULL(CO.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
	ROW_NUMBER() OVER (ORDER BY (SELECT 1)) as NroOrden,
	PC.CampaniaID,
	CA.Codigo as CodigoCampania,
	PC.CUV,
	PC.CodigoTipoOferta,
	CO.Descripcion as TipoOferta,
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
INNER JOIN ConfiguracionOferta CO ON 
	CO.CodigoOferta = PC.CodigoTipoOferta
LEFT JOIN ShowRoom.OfertaShowRoom OS WITH(NOLOCK) ON 
	OS.CUV = PC.CUV 
	AND OS.CampaniaID = PC.CampaniaID
WHERE 
	PC.CodigoTipoOferta = @CodigoOferta
	AND CA.Codigo = @CampaniaID
ORDER BY CO.Descripcion, OS.CUV desc

end

go

ALTER PROCEDURE ShowRoom.InsOfertaShowRoom
(	
	@CampaniaID int,
	@CUV varchar(20),
	@TipoOfertaSisID int,
	@ConfiguracionOfertaID int,
	@Descripcion varchar(250),
	@PrecioOferta numeric(12,2),
	@ImagenProducto varchar(150),
	@Orden int,
	@UnidadesPermitidas int,
	@FlagHabilitarProducto int,
	@DescripcionLegal varchar(250),
	@UsuarioRegistro varchar(50),
	@ImagenMini varchar(150),
	@PrecioOferta2 decimal(12,2)=0
)
AS
BEGIN
	INSERT INTO ShowRoom.OfertaShowRoom
	(
		CampaniaID, CUV, TipoOfertaSisID, ConfiguracionOfertaID, Descripcion, PrecioOferta, Stock, StockInicial, ImagenProducto,
		Orden, UnidadesPermitidas, FlagHabilitarProducto, DescripcionLegal, UsuarioRegistro, FechaRegistro, ImagenMini, PrecioOferta2
	)
	VALUES
	(
		@CampaniaID, @CUV, @TipoOfertaSisID, @ConfiguracionOfertaID, @Descripcion, @PrecioOferta, 0, 0, @ImagenProducto, 
		@Orden, @UnidadesPermitidas, @FlagHabilitarProducto, @DescripcionLegal, @UsuarioRegistro, getdate(), @ImagenMini, @PrecioOferta2
	)
END

GO

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
	@PrecioOferta decimal(18,2),
	@ImagenMini varchar(150),
	@Incrementa int,
	@CantidadIncrementa int,
	@FlagAgotado int,
	@PrecioOferta2 decimal(18,2)=0
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
			PrecioOferta = @PrecioOferta,
			FechaModificacion = getdate(),
			ImagenMini = @ImagenMini,
			Stock = (CASE WHEN @Incrementa = 0 AND @FlagAgotado = 0 THEN Stock + @CantidadIncrementa 
							WHEN @Incrementa = 1 AND @FlagAgotado = 0 THEN Stock - @CantidadIncrementa 
							WHEN @FlagAgotado = 1 THEN 0 END),
			StockInicial = (CASE WHEN @Incrementa = 0 THEN StockInicial + @CantidadIncrementa 
							ELSE StockInicial - @CantidadIncrementa END),
			PrecioOferta2 = @PrecioOferta2
	where 
		CampaniaID = @CampaniaID
		AND CUV = @CUV
END

GO

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
	[PrecioOferta] [decimal](18, 2) NULL,
	[UnidadesPermitidas] [int] NULL,
	[Descripcion] [varchar](250) NULL,
	[CodigoCategoria] [varchar](100) NULL,
	[TipNegocio] [varchar](500) NULL
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
	UnidadesPermitidas = t.UnidadesPermitidas,
	Descripcion = t.Descripcion,
	CodigoCategoria = t.CodigoCategoria,
	TipNegocio = t.TipNegocio,
	PrecioOferta2 = t.PrecioOferta2
FROM ShowRoom.OfertaShowRoom o
INNER JOIN ods.Campania c on 
	c.CampaniaID = o.CampaniaID
JOIN @StockPrecioOfertaShowRoom t ON 
	c.Codigo = t.CampaniaID
	AND o.CUV = t.CUV
	AND o.TipoOfertaSisID = t.TipoOfertaSisID

end

GO

ALTER procedure ShowRoom.GetShowRoomOfertasConsultora
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
o.OfertaShowRoomID,o.CampaniaID,o.CUV,o.TipoOfertaSisID,o.ConfiguracionOfertaID,o.Descripcion,
o.PrecioOferta  AS PrecioOferta,
COALESCE(o.PrecioOferta2,pc.PrecioCatalogo) AS PrecioCatalogo,
o.Stock,
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

ALTER procedure [ShowRoom].[GetShowRoomCompraPorCompra]
(
@EventoID int,
@CampaniaID int
)
as
/*
ShowRoom.GetShowRoomCompraPorCompra 5,201705
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
	pc.PrecioCatalogo as PrecioCatalogo,
	MarcaID as MarcaID,
	Orden,
	SAP as CodigoProducto,
	cpc.PrecioValorizado as PrecioOferta	
from [ShowRoom].[CompraPorCompra] cpc 
inner join [ShowRoom].[Evento] e on cpc.EventoID = e.EventoID
inner join [ods].[Campania] c on e.CampaniaID = c.Codigo
inner join [ods].[ProductoComercial] pc on (c.CampaniaID = pc.CampaniaID and cpc.CUV = pc.CUV and cpc.SAP = pc.CodigoProducto)
where cpc.CUV not in (select distinct Cuv from @Productos_Faltantes_tmp)
and cpc.EventoID = @EventoID
end

go

ALTER PROCEDURE [ShowRoom].[GetShowRoomOfertaById] -- Alter the SP Always
 @OfertaShowRoomID int
AS
BEGIN
 
 SET NOCOUNT ON;
  
	select OfertaShowRoomID, CampaniaID, CUV, TipoOfertaSisID, ConfiguracionOfertaID, Descripcion,
	PrecioOferta, Stock, StockInicial, ImagenProducto, UnidadesPermitidas, FlagHabilitarProducto,
	DescripcionLegal, UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion,
	ImagenMini,Orden
	from showroom.ofertashowroom
	where OfertaShowRoomID = @OfertaShowRoomID
 
END

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomTipoOferta
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[ExisteShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].ExisteShowRoomTipoOferta
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[InsertShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].InsertShowRoomTipoOferta
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[UpdateShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].UpdateShowRoomTipoOferta
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[HabilitarShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].HabilitarShowRoomTipoOferta
GO

USE BelcorpCostaRica
go

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[TipoOferta]') AND (type = 'U') )
	DROP TABLE ShowRoom.TipoOferta
GO

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'PrecioOferta') = 1
	EXEC sp_RENAME 'ShowRoom.OfertaShowRoom.PrecioOferta' , 'PrecioOferta2', 'COLUMN' 
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'PrecioValorizado') = 1
	EXEC sp_RENAME 'ShowRoom.OfertaShowRoom.PrecioValorizado' , 'PrecioOferta', 'COLUMN' 
go

ALTER procedure ShowRoom.GetProductosShowRoom
@TipoOfertaSisID int,
@CampaniaID int,
@CodigoOferta varchar(8)
as
/*
ShowRoom.GetProductosShowRoom 1707,201706,'105'
*/
begin

select 
	ISNULL(OS.OfertaShowRoomID,0) OfertaShowRoomID,
	ISNULL(CO.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
	ROW_NUMBER() OVER (ORDER BY (SELECT 1)) as NroOrden,
	PC.CampaniaID,
	CA.Codigo as CodigoCampania,
	PC.CUV,
	PC.CodigoTipoOferta,
	CO.Descripcion as TipoOferta,
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
INNER JOIN ConfiguracionOferta CO ON 
	CO.CodigoOferta = PC.CodigoTipoOferta
LEFT JOIN ShowRoom.OfertaShowRoom OS WITH(NOLOCK) ON 
	OS.CUV = PC.CUV 
	AND OS.CampaniaID = PC.CampaniaID
WHERE 
	PC.CodigoTipoOferta = @CodigoOferta
	AND CA.Codigo = @CampaniaID
ORDER BY CO.Descripcion, OS.CUV desc

end

go

ALTER PROCEDURE ShowRoom.InsOfertaShowRoom
(	
	@CampaniaID int,
	@CUV varchar(20),
	@TipoOfertaSisID int,
	@ConfiguracionOfertaID int,
	@Descripcion varchar(250),
	@PrecioOferta numeric(12,2),
	@ImagenProducto varchar(150),
	@Orden int,
	@UnidadesPermitidas int,
	@FlagHabilitarProducto int,
	@DescripcionLegal varchar(250),
	@UsuarioRegistro varchar(50),
	@ImagenMini varchar(150),
	@PrecioOferta2 decimal(12,2)=0
)
AS
BEGIN
	INSERT INTO ShowRoom.OfertaShowRoom
	(
		CampaniaID, CUV, TipoOfertaSisID, ConfiguracionOfertaID, Descripcion, PrecioOferta, Stock, StockInicial, ImagenProducto,
		Orden, UnidadesPermitidas, FlagHabilitarProducto, DescripcionLegal, UsuarioRegistro, FechaRegistro, ImagenMini, PrecioOferta2
	)
	VALUES
	(
		@CampaniaID, @CUV, @TipoOfertaSisID, @ConfiguracionOfertaID, @Descripcion, @PrecioOferta, 0, 0, @ImagenProducto, 
		@Orden, @UnidadesPermitidas, @FlagHabilitarProducto, @DescripcionLegal, @UsuarioRegistro, getdate(), @ImagenMini, @PrecioOferta2
	)
END

GO

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
	@PrecioOferta decimal(18,2),
	@ImagenMini varchar(150),
	@Incrementa int,
	@CantidadIncrementa int,
	@FlagAgotado int,
	@PrecioOferta2 decimal(18,2)=0
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
			PrecioOferta = @PrecioOferta,
			FechaModificacion = getdate(),
			ImagenMini = @ImagenMini,
			Stock = (CASE WHEN @Incrementa = 0 AND @FlagAgotado = 0 THEN Stock + @CantidadIncrementa 
							WHEN @Incrementa = 1 AND @FlagAgotado = 0 THEN Stock - @CantidadIncrementa 
							WHEN @FlagAgotado = 1 THEN 0 END),
			StockInicial = (CASE WHEN @Incrementa = 0 THEN StockInicial + @CantidadIncrementa 
							ELSE StockInicial - @CantidadIncrementa END),
			PrecioOferta2 = @PrecioOferta2
	where 
		CampaniaID = @CampaniaID
		AND CUV = @CUV
END

GO

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
	[PrecioOferta] [decimal](18, 2) NULL,
	[UnidadesPermitidas] [int] NULL,
	[Descripcion] [varchar](250) NULL,
	[CodigoCategoria] [varchar](100) NULL,
	[TipNegocio] [varchar](500) NULL
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
	UnidadesPermitidas = t.UnidadesPermitidas,
	Descripcion = t.Descripcion,
	CodigoCategoria = t.CodigoCategoria,
	TipNegocio = t.TipNegocio,
	PrecioOferta2 = t.PrecioOferta2
FROM ShowRoom.OfertaShowRoom o
INNER JOIN ods.Campania c on 
	c.CampaniaID = o.CampaniaID
JOIN @StockPrecioOfertaShowRoom t ON 
	c.Codigo = t.CampaniaID
	AND o.CUV = t.CUV
	AND o.TipoOfertaSisID = t.TipoOfertaSisID

end

GO

ALTER procedure ShowRoom.GetShowRoomOfertasConsultora
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
o.OfertaShowRoomID,o.CampaniaID,o.CUV,o.TipoOfertaSisID,o.ConfiguracionOfertaID,o.Descripcion,
o.PrecioOferta  AS PrecioOferta,
COALESCE(o.PrecioOferta2,pc.PrecioCatalogo) AS PrecioCatalogo,
o.Stock,
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

ALTER procedure [ShowRoom].[GetShowRoomCompraPorCompra]
(
@EventoID int,
@CampaniaID int
)
as
/*
ShowRoom.GetShowRoomCompraPorCompra 5,201705
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
	pc.PrecioCatalogo as PrecioCatalogo,
	MarcaID as MarcaID,
	Orden,
	SAP as CodigoProducto,
	cpc.PrecioValorizado as PrecioOferta	
from [ShowRoom].[CompraPorCompra] cpc 
inner join [ShowRoom].[Evento] e on cpc.EventoID = e.EventoID
inner join [ods].[Campania] c on e.CampaniaID = c.Codigo
inner join [ods].[ProductoComercial] pc on (c.CampaniaID = pc.CampaniaID and cpc.CUV = pc.CUV and cpc.SAP = pc.CodigoProducto)
where cpc.CUV not in (select distinct Cuv from @Productos_Faltantes_tmp)
and cpc.EventoID = @EventoID
end

go

ALTER PROCEDURE [ShowRoom].[GetShowRoomOfertaById] -- Alter the SP Always
 @OfertaShowRoomID int
AS
BEGIN
 
 SET NOCOUNT ON;
  
	select OfertaShowRoomID, CampaniaID, CUV, TipoOfertaSisID, ConfiguracionOfertaID, Descripcion,
	PrecioOferta, Stock, StockInicial, ImagenProducto, UnidadesPermitidas, FlagHabilitarProducto,
	DescripcionLegal, UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion,
	ImagenMini,Orden
	from showroom.ofertashowroom
	where OfertaShowRoomID = @OfertaShowRoomID
 
END

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomTipoOferta
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[ExisteShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].ExisteShowRoomTipoOferta
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[InsertShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].InsertShowRoomTipoOferta
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[UpdateShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].UpdateShowRoomTipoOferta
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[HabilitarShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].HabilitarShowRoomTipoOferta
GO

USE BelcorpDominicana
go

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[TipoOferta]') AND (type = 'U') )
	DROP TABLE ShowRoom.TipoOferta
GO

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'PrecioOferta') = 1
	EXEC sp_RENAME 'ShowRoom.OfertaShowRoom.PrecioOferta' , 'PrecioOferta2', 'COLUMN' 
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'PrecioValorizado') = 1
	EXEC sp_RENAME 'ShowRoom.OfertaShowRoom.PrecioValorizado' , 'PrecioOferta', 'COLUMN' 
go

ALTER procedure ShowRoom.GetProductosShowRoom
@TipoOfertaSisID int,
@CampaniaID int,
@CodigoOferta varchar(8)
as
/*
ShowRoom.GetProductosShowRoom 1707,201706,'105'
*/
begin

select 
	ISNULL(OS.OfertaShowRoomID,0) OfertaShowRoomID,
	ISNULL(CO.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
	ROW_NUMBER() OVER (ORDER BY (SELECT 1)) as NroOrden,
	PC.CampaniaID,
	CA.Codigo as CodigoCampania,
	PC.CUV,
	PC.CodigoTipoOferta,
	CO.Descripcion as TipoOferta,
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
INNER JOIN ConfiguracionOferta CO ON 
	CO.CodigoOferta = PC.CodigoTipoOferta
LEFT JOIN ShowRoom.OfertaShowRoom OS WITH(NOLOCK) ON 
	OS.CUV = PC.CUV 
	AND OS.CampaniaID = PC.CampaniaID
WHERE 
	PC.CodigoTipoOferta = @CodigoOferta
	AND CA.Codigo = @CampaniaID
ORDER BY CO.Descripcion, OS.CUV desc

end

go

ALTER PROCEDURE ShowRoom.InsOfertaShowRoom
(	
	@CampaniaID int,
	@CUV varchar(20),
	@TipoOfertaSisID int,
	@ConfiguracionOfertaID int,
	@Descripcion varchar(250),
	@PrecioOferta numeric(12,2),
	@ImagenProducto varchar(150),
	@Orden int,
	@UnidadesPermitidas int,
	@FlagHabilitarProducto int,
	@DescripcionLegal varchar(250),
	@UsuarioRegistro varchar(50),
	@ImagenMini varchar(150),
	@PrecioOferta2 decimal(12,2)=0
)
AS
BEGIN
	INSERT INTO ShowRoom.OfertaShowRoom
	(
		CampaniaID, CUV, TipoOfertaSisID, ConfiguracionOfertaID, Descripcion, PrecioOferta, Stock, StockInicial, ImagenProducto,
		Orden, UnidadesPermitidas, FlagHabilitarProducto, DescripcionLegal, UsuarioRegistro, FechaRegistro, ImagenMini, PrecioOferta2
	)
	VALUES
	(
		@CampaniaID, @CUV, @TipoOfertaSisID, @ConfiguracionOfertaID, @Descripcion, @PrecioOferta, 0, 0, @ImagenProducto, 
		@Orden, @UnidadesPermitidas, @FlagHabilitarProducto, @DescripcionLegal, @UsuarioRegistro, getdate(), @ImagenMini, @PrecioOferta2
	)
END

GO

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
	@PrecioOferta decimal(18,2),
	@ImagenMini varchar(150),
	@Incrementa int,
	@CantidadIncrementa int,
	@FlagAgotado int,
	@PrecioOferta2 decimal(18,2)=0
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
			PrecioOferta = @PrecioOferta,
			FechaModificacion = getdate(),
			ImagenMini = @ImagenMini,
			Stock = (CASE WHEN @Incrementa = 0 AND @FlagAgotado = 0 THEN Stock + @CantidadIncrementa 
							WHEN @Incrementa = 1 AND @FlagAgotado = 0 THEN Stock - @CantidadIncrementa 
							WHEN @FlagAgotado = 1 THEN 0 END),
			StockInicial = (CASE WHEN @Incrementa = 0 THEN StockInicial + @CantidadIncrementa 
							ELSE StockInicial - @CantidadIncrementa END),
			PrecioOferta2 = @PrecioOferta2
	where 
		CampaniaID = @CampaniaID
		AND CUV = @CUV
END

GO

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
	[PrecioOferta] [decimal](18, 2) NULL,
	[UnidadesPermitidas] [int] NULL,
	[Descripcion] [varchar](250) NULL,
	[CodigoCategoria] [varchar](100) NULL,
	[TipNegocio] [varchar](500) NULL
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
	UnidadesPermitidas = t.UnidadesPermitidas,
	Descripcion = t.Descripcion,
	CodigoCategoria = t.CodigoCategoria,
	TipNegocio = t.TipNegocio,
	PrecioOferta2 = t.PrecioOferta2
FROM ShowRoom.OfertaShowRoom o
INNER JOIN ods.Campania c on 
	c.CampaniaID = o.CampaniaID
JOIN @StockPrecioOfertaShowRoom t ON 
	c.Codigo = t.CampaniaID
	AND o.CUV = t.CUV
	AND o.TipoOfertaSisID = t.TipoOfertaSisID

end

GO

ALTER procedure ShowRoom.GetShowRoomOfertasConsultora
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
o.OfertaShowRoomID,o.CampaniaID,o.CUV,o.TipoOfertaSisID,o.ConfiguracionOfertaID,o.Descripcion,
o.PrecioOferta  AS PrecioOferta,
COALESCE(o.PrecioOferta2,pc.PrecioCatalogo) AS PrecioCatalogo,
o.Stock,
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

ALTER procedure [ShowRoom].[GetShowRoomCompraPorCompra]
(
@EventoID int,
@CampaniaID int
)
as
/*
ShowRoom.GetShowRoomCompraPorCompra 5,201705
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
	pc.PrecioCatalogo as PrecioCatalogo,
	MarcaID as MarcaID,
	Orden,
	SAP as CodigoProducto,
	cpc.PrecioValorizado as PrecioOferta	
from [ShowRoom].[CompraPorCompra] cpc 
inner join [ShowRoom].[Evento] e on cpc.EventoID = e.EventoID
inner join [ods].[Campania] c on e.CampaniaID = c.Codigo
inner join [ods].[ProductoComercial] pc on (c.CampaniaID = pc.CampaniaID and cpc.CUV = pc.CUV and cpc.SAP = pc.CodigoProducto)
where cpc.CUV not in (select distinct Cuv from @Productos_Faltantes_tmp)
and cpc.EventoID = @EventoID
end

go

ALTER PROCEDURE [ShowRoom].[GetShowRoomOfertaById] -- Alter the SP Always
 @OfertaShowRoomID int
AS
BEGIN
 
 SET NOCOUNT ON;
  
	select OfertaShowRoomID, CampaniaID, CUV, TipoOfertaSisID, ConfiguracionOfertaID, Descripcion,
	PrecioOferta, Stock, StockInicial, ImagenProducto, UnidadesPermitidas, FlagHabilitarProducto,
	DescripcionLegal, UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion,
	ImagenMini,Orden
	from showroom.ofertashowroom
	where OfertaShowRoomID = @OfertaShowRoomID
 
END

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomTipoOferta
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[ExisteShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].ExisteShowRoomTipoOferta
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[InsertShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].InsertShowRoomTipoOferta
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[UpdateShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].UpdateShowRoomTipoOferta
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[HabilitarShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].HabilitarShowRoomTipoOferta
GO

USE BelcorpEcuador
go

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[TipoOferta]') AND (type = 'U') )
	DROP TABLE ShowRoom.TipoOferta
GO

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'PrecioOferta') = 1
	EXEC sp_RENAME 'ShowRoom.OfertaShowRoom.PrecioOferta' , 'PrecioOferta2', 'COLUMN' 
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'PrecioValorizado') = 1
	EXEC sp_RENAME 'ShowRoom.OfertaShowRoom.PrecioValorizado' , 'PrecioOferta', 'COLUMN' 
go

ALTER procedure ShowRoom.GetProductosShowRoom
@TipoOfertaSisID int,
@CampaniaID int,
@CodigoOferta varchar(8)
as
/*
ShowRoom.GetProductosShowRoom 1707,201706,'105'
*/
begin

select 
	ISNULL(OS.OfertaShowRoomID,0) OfertaShowRoomID,
	ISNULL(CO.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
	ROW_NUMBER() OVER (ORDER BY (SELECT 1)) as NroOrden,
	PC.CampaniaID,
	CA.Codigo as CodigoCampania,
	PC.CUV,
	PC.CodigoTipoOferta,
	CO.Descripcion as TipoOferta,
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
INNER JOIN ConfiguracionOferta CO ON 
	CO.CodigoOferta = PC.CodigoTipoOferta
LEFT JOIN ShowRoom.OfertaShowRoom OS WITH(NOLOCK) ON 
	OS.CUV = PC.CUV 
	AND OS.CampaniaID = PC.CampaniaID
WHERE 
	PC.CodigoTipoOferta = @CodigoOferta
	AND CA.Codigo = @CampaniaID
ORDER BY CO.Descripcion, OS.CUV desc

end

go

ALTER PROCEDURE ShowRoom.InsOfertaShowRoom
(	
	@CampaniaID int,
	@CUV varchar(20),
	@TipoOfertaSisID int,
	@ConfiguracionOfertaID int,
	@Descripcion varchar(250),
	@PrecioOferta numeric(12,2),
	@ImagenProducto varchar(150),
	@Orden int,
	@UnidadesPermitidas int,
	@FlagHabilitarProducto int,
	@DescripcionLegal varchar(250),
	@UsuarioRegistro varchar(50),
	@ImagenMini varchar(150),
	@PrecioOferta2 decimal(12,2)=0
)
AS
BEGIN
	INSERT INTO ShowRoom.OfertaShowRoom
	(
		CampaniaID, CUV, TipoOfertaSisID, ConfiguracionOfertaID, Descripcion, PrecioOferta, Stock, StockInicial, ImagenProducto,
		Orden, UnidadesPermitidas, FlagHabilitarProducto, DescripcionLegal, UsuarioRegistro, FechaRegistro, ImagenMini, PrecioOferta2
	)
	VALUES
	(
		@CampaniaID, @CUV, @TipoOfertaSisID, @ConfiguracionOfertaID, @Descripcion, @PrecioOferta, 0, 0, @ImagenProducto, 
		@Orden, @UnidadesPermitidas, @FlagHabilitarProducto, @DescripcionLegal, @UsuarioRegistro, getdate(), @ImagenMini, @PrecioOferta2
	)
END

GO

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
	@PrecioOferta decimal(18,2),
	@ImagenMini varchar(150),
	@Incrementa int,
	@CantidadIncrementa int,
	@FlagAgotado int,
	@PrecioOferta2 decimal(18,2)=0
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
			PrecioOferta = @PrecioOferta,
			FechaModificacion = getdate(),
			ImagenMini = @ImagenMini,
			Stock = (CASE WHEN @Incrementa = 0 AND @FlagAgotado = 0 THEN Stock + @CantidadIncrementa 
							WHEN @Incrementa = 1 AND @FlagAgotado = 0 THEN Stock - @CantidadIncrementa 
							WHEN @FlagAgotado = 1 THEN 0 END),
			StockInicial = (CASE WHEN @Incrementa = 0 THEN StockInicial + @CantidadIncrementa 
							ELSE StockInicial - @CantidadIncrementa END),
			PrecioOferta2 = @PrecioOferta2
	where 
		CampaniaID = @CampaniaID
		AND CUV = @CUV
END

GO

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
	[PrecioOferta] [decimal](18, 2) NULL,
	[UnidadesPermitidas] [int] NULL,
	[Descripcion] [varchar](250) NULL,
	[CodigoCategoria] [varchar](100) NULL,
	[TipNegocio] [varchar](500) NULL
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
	UnidadesPermitidas = t.UnidadesPermitidas,
	Descripcion = t.Descripcion,
	CodigoCategoria = t.CodigoCategoria,
	TipNegocio = t.TipNegocio,
	PrecioOferta2 = t.PrecioOferta2
FROM ShowRoom.OfertaShowRoom o
INNER JOIN ods.Campania c on 
	c.CampaniaID = o.CampaniaID
JOIN @StockPrecioOfertaShowRoom t ON 
	c.Codigo = t.CampaniaID
	AND o.CUV = t.CUV
	AND o.TipoOfertaSisID = t.TipoOfertaSisID

end

GO

ALTER procedure ShowRoom.GetShowRoomOfertasConsultora
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
o.OfertaShowRoomID,o.CampaniaID,o.CUV,o.TipoOfertaSisID,o.ConfiguracionOfertaID,o.Descripcion,
o.PrecioOferta  AS PrecioOferta,
COALESCE(o.PrecioOferta2,pc.PrecioCatalogo) AS PrecioCatalogo,
o.Stock,
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

ALTER procedure [ShowRoom].[GetShowRoomCompraPorCompra]
(
@EventoID int,
@CampaniaID int
)
as
/*
ShowRoom.GetShowRoomCompraPorCompra 5,201705
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
	pc.PrecioCatalogo as PrecioCatalogo,
	MarcaID as MarcaID,
	Orden,
	SAP as CodigoProducto,
	cpc.PrecioValorizado as PrecioOferta	
from [ShowRoom].[CompraPorCompra] cpc 
inner join [ShowRoom].[Evento] e on cpc.EventoID = e.EventoID
inner join [ods].[Campania] c on e.CampaniaID = c.Codigo
inner join [ods].[ProductoComercial] pc on (c.CampaniaID = pc.CampaniaID and cpc.CUV = pc.CUV and cpc.SAP = pc.CodigoProducto)
where cpc.CUV not in (select distinct Cuv from @Productos_Faltantes_tmp)
and cpc.EventoID = @EventoID
end

go

ALTER PROCEDURE [ShowRoom].[GetShowRoomOfertaById] -- Alter the SP Always
 @OfertaShowRoomID int
AS
BEGIN
 
 SET NOCOUNT ON;
  
	select OfertaShowRoomID, CampaniaID, CUV, TipoOfertaSisID, ConfiguracionOfertaID, Descripcion,
	PrecioOferta, Stock, StockInicial, ImagenProducto, UnidadesPermitidas, FlagHabilitarProducto,
	DescripcionLegal, UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion,
	ImagenMini,Orden
	from showroom.ofertashowroom
	where OfertaShowRoomID = @OfertaShowRoomID
 
END

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomTipoOferta
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[ExisteShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].ExisteShowRoomTipoOferta
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[InsertShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].InsertShowRoomTipoOferta
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[UpdateShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].UpdateShowRoomTipoOferta
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[HabilitarShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].HabilitarShowRoomTipoOferta
GO

USE BelcorpGuatemala
go

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[TipoOferta]') AND (type = 'U') )
	DROP TABLE ShowRoom.TipoOferta
GO

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'PrecioOferta') = 1
	EXEC sp_RENAME 'ShowRoom.OfertaShowRoom.PrecioOferta' , 'PrecioOferta2', 'COLUMN' 
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'PrecioValorizado') = 1
	EXEC sp_RENAME 'ShowRoom.OfertaShowRoom.PrecioValorizado' , 'PrecioOferta', 'COLUMN' 
go

ALTER procedure ShowRoom.GetProductosShowRoom
@TipoOfertaSisID int,
@CampaniaID int,
@CodigoOferta varchar(8)
as
/*
ShowRoom.GetProductosShowRoom 1707,201706,'105'
*/
begin

select 
	ISNULL(OS.OfertaShowRoomID,0) OfertaShowRoomID,
	ISNULL(CO.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
	ROW_NUMBER() OVER (ORDER BY (SELECT 1)) as NroOrden,
	PC.CampaniaID,
	CA.Codigo as CodigoCampania,
	PC.CUV,
	PC.CodigoTipoOferta,
	CO.Descripcion as TipoOferta,
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
INNER JOIN ConfiguracionOferta CO ON 
	CO.CodigoOferta = PC.CodigoTipoOferta
LEFT JOIN ShowRoom.OfertaShowRoom OS WITH(NOLOCK) ON 
	OS.CUV = PC.CUV 
	AND OS.CampaniaID = PC.CampaniaID
WHERE 
	PC.CodigoTipoOferta = @CodigoOferta
	AND CA.Codigo = @CampaniaID
ORDER BY CO.Descripcion, OS.CUV desc

end

go

ALTER PROCEDURE ShowRoom.InsOfertaShowRoom
(	
	@CampaniaID int,
	@CUV varchar(20),
	@TipoOfertaSisID int,
	@ConfiguracionOfertaID int,
	@Descripcion varchar(250),
	@PrecioOferta numeric(12,2),
	@ImagenProducto varchar(150),
	@Orden int,
	@UnidadesPermitidas int,
	@FlagHabilitarProducto int,
	@DescripcionLegal varchar(250),
	@UsuarioRegistro varchar(50),
	@ImagenMini varchar(150),
	@PrecioOferta2 decimal(12,2)=0
)
AS
BEGIN
	INSERT INTO ShowRoom.OfertaShowRoom
	(
		CampaniaID, CUV, TipoOfertaSisID, ConfiguracionOfertaID, Descripcion, PrecioOferta, Stock, StockInicial, ImagenProducto,
		Orden, UnidadesPermitidas, FlagHabilitarProducto, DescripcionLegal, UsuarioRegistro, FechaRegistro, ImagenMini, PrecioOferta2
	)
	VALUES
	(
		@CampaniaID, @CUV, @TipoOfertaSisID, @ConfiguracionOfertaID, @Descripcion, @PrecioOferta, 0, 0, @ImagenProducto, 
		@Orden, @UnidadesPermitidas, @FlagHabilitarProducto, @DescripcionLegal, @UsuarioRegistro, getdate(), @ImagenMini, @PrecioOferta2
	)
END

GO

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
	@PrecioOferta decimal(18,2),
	@ImagenMini varchar(150),
	@Incrementa int,
	@CantidadIncrementa int,
	@FlagAgotado int,
	@PrecioOferta2 decimal(18,2)=0
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
			PrecioOferta = @PrecioOferta,
			FechaModificacion = getdate(),
			ImagenMini = @ImagenMini,
			Stock = (CASE WHEN @Incrementa = 0 AND @FlagAgotado = 0 THEN Stock + @CantidadIncrementa 
							WHEN @Incrementa = 1 AND @FlagAgotado = 0 THEN Stock - @CantidadIncrementa 
							WHEN @FlagAgotado = 1 THEN 0 END),
			StockInicial = (CASE WHEN @Incrementa = 0 THEN StockInicial + @CantidadIncrementa 
							ELSE StockInicial - @CantidadIncrementa END),
			PrecioOferta2 = @PrecioOferta2
	where 
		CampaniaID = @CampaniaID
		AND CUV = @CUV
END

GO

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
	[PrecioOferta] [decimal](18, 2) NULL,
	[UnidadesPermitidas] [int] NULL,
	[Descripcion] [varchar](250) NULL,
	[CodigoCategoria] [varchar](100) NULL,
	[TipNegocio] [varchar](500) NULL
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
	UnidadesPermitidas = t.UnidadesPermitidas,
	Descripcion = t.Descripcion,
	CodigoCategoria = t.CodigoCategoria,
	TipNegocio = t.TipNegocio,
	PrecioOferta2 = t.PrecioOferta2
FROM ShowRoom.OfertaShowRoom o
INNER JOIN ods.Campania c on 
	c.CampaniaID = o.CampaniaID
JOIN @StockPrecioOfertaShowRoom t ON 
	c.Codigo = t.CampaniaID
	AND o.CUV = t.CUV
	AND o.TipoOfertaSisID = t.TipoOfertaSisID

end

GO

ALTER procedure ShowRoom.GetShowRoomOfertasConsultora
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
o.OfertaShowRoomID,o.CampaniaID,o.CUV,o.TipoOfertaSisID,o.ConfiguracionOfertaID,o.Descripcion,
o.PrecioOferta  AS PrecioOferta,
COALESCE(o.PrecioOferta2,pc.PrecioCatalogo) AS PrecioCatalogo,
o.Stock,
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

ALTER procedure [ShowRoom].[GetShowRoomCompraPorCompra]
(
@EventoID int,
@CampaniaID int
)
as
/*
ShowRoom.GetShowRoomCompraPorCompra 5,201705
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
	pc.PrecioCatalogo as PrecioCatalogo,
	MarcaID as MarcaID,
	Orden,
	SAP as CodigoProducto,
	cpc.PrecioValorizado as PrecioOferta	
from [ShowRoom].[CompraPorCompra] cpc 
inner join [ShowRoom].[Evento] e on cpc.EventoID = e.EventoID
inner join [ods].[Campania] c on e.CampaniaID = c.Codigo
inner join [ods].[ProductoComercial] pc on (c.CampaniaID = pc.CampaniaID and cpc.CUV = pc.CUV and cpc.SAP = pc.CodigoProducto)
where cpc.CUV not in (select distinct Cuv from @Productos_Faltantes_tmp)
and cpc.EventoID = @EventoID
end

go

ALTER PROCEDURE [ShowRoom].[GetShowRoomOfertaById] -- Alter the SP Always
 @OfertaShowRoomID int
AS
BEGIN
 
 SET NOCOUNT ON;
  
	select OfertaShowRoomID, CampaniaID, CUV, TipoOfertaSisID, ConfiguracionOfertaID, Descripcion,
	PrecioOferta, Stock, StockInicial, ImagenProducto, UnidadesPermitidas, FlagHabilitarProducto,
	DescripcionLegal, UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion,
	ImagenMini,Orden
	from showroom.ofertashowroom
	where OfertaShowRoomID = @OfertaShowRoomID
 
END

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomTipoOferta
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[ExisteShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].ExisteShowRoomTipoOferta
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[InsertShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].InsertShowRoomTipoOferta
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[UpdateShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].UpdateShowRoomTipoOferta
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[HabilitarShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].HabilitarShowRoomTipoOferta
GO

USE BelcorpMexico
go

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[TipoOferta]') AND (type = 'U') )
	DROP TABLE ShowRoom.TipoOferta
GO

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'PrecioOferta') = 1
	EXEC sp_RENAME 'ShowRoom.OfertaShowRoom.PrecioOferta' , 'PrecioOferta2', 'COLUMN' 
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'PrecioValorizado') = 1
	EXEC sp_RENAME 'ShowRoom.OfertaShowRoom.PrecioValorizado' , 'PrecioOferta', 'COLUMN' 
go

ALTER procedure ShowRoom.GetProductosShowRoom
@TipoOfertaSisID int,
@CampaniaID int,
@CodigoOferta varchar(8)
as
/*
ShowRoom.GetProductosShowRoom 1707,201706,'105'
*/
begin

select 
	ISNULL(OS.OfertaShowRoomID,0) OfertaShowRoomID,
	ISNULL(CO.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
	ROW_NUMBER() OVER (ORDER BY (SELECT 1)) as NroOrden,
	PC.CampaniaID,
	CA.Codigo as CodigoCampania,
	PC.CUV,
	PC.CodigoTipoOferta,
	CO.Descripcion as TipoOferta,
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
INNER JOIN ConfiguracionOferta CO ON 
	CO.CodigoOferta = PC.CodigoTipoOferta
LEFT JOIN ShowRoom.OfertaShowRoom OS WITH(NOLOCK) ON 
	OS.CUV = PC.CUV 
	AND OS.CampaniaID = PC.CampaniaID
WHERE 
	PC.CodigoTipoOferta = @CodigoOferta
	AND CA.Codigo = @CampaniaID
ORDER BY CO.Descripcion, OS.CUV desc

end

go

ALTER PROCEDURE ShowRoom.InsOfertaShowRoom
(	
	@CampaniaID int,
	@CUV varchar(20),
	@TipoOfertaSisID int,
	@ConfiguracionOfertaID int,
	@Descripcion varchar(250),
	@PrecioOferta numeric(12,2),
	@ImagenProducto varchar(150),
	@Orden int,
	@UnidadesPermitidas int,
	@FlagHabilitarProducto int,
	@DescripcionLegal varchar(250),
	@UsuarioRegistro varchar(50),
	@ImagenMini varchar(150),
	@PrecioOferta2 decimal(12,2)=0
)
AS
BEGIN
	INSERT INTO ShowRoom.OfertaShowRoom
	(
		CampaniaID, CUV, TipoOfertaSisID, ConfiguracionOfertaID, Descripcion, PrecioOferta, Stock, StockInicial, ImagenProducto,
		Orden, UnidadesPermitidas, FlagHabilitarProducto, DescripcionLegal, UsuarioRegistro, FechaRegistro, ImagenMini, PrecioOferta2
	)
	VALUES
	(
		@CampaniaID, @CUV, @TipoOfertaSisID, @ConfiguracionOfertaID, @Descripcion, @PrecioOferta, 0, 0, @ImagenProducto, 
		@Orden, @UnidadesPermitidas, @FlagHabilitarProducto, @DescripcionLegal, @UsuarioRegistro, getdate(), @ImagenMini, @PrecioOferta2
	)
END

GO

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
	@PrecioOferta decimal(18,2),
	@ImagenMini varchar(150),
	@Incrementa int,
	@CantidadIncrementa int,
	@FlagAgotado int,
	@PrecioOferta2 decimal(18,2)=0
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
			PrecioOferta = @PrecioOferta,
			FechaModificacion = getdate(),
			ImagenMini = @ImagenMini,
			Stock = (CASE WHEN @Incrementa = 0 AND @FlagAgotado = 0 THEN Stock + @CantidadIncrementa 
							WHEN @Incrementa = 1 AND @FlagAgotado = 0 THEN Stock - @CantidadIncrementa 
							WHEN @FlagAgotado = 1 THEN 0 END),
			StockInicial = (CASE WHEN @Incrementa = 0 THEN StockInicial + @CantidadIncrementa 
							ELSE StockInicial - @CantidadIncrementa END),
			PrecioOferta2 = @PrecioOferta2
	where 
		CampaniaID = @CampaniaID
		AND CUV = @CUV
END

GO

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
	[PrecioOferta] [decimal](18, 2) NULL,
	[UnidadesPermitidas] [int] NULL,
	[Descripcion] [varchar](250) NULL,
	[CodigoCategoria] [varchar](100) NULL,
	[TipNegocio] [varchar](500) NULL
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
	UnidadesPermitidas = t.UnidadesPermitidas,
	Descripcion = t.Descripcion,
	CodigoCategoria = t.CodigoCategoria,
	TipNegocio = t.TipNegocio,
	PrecioOferta2 = t.PrecioOferta2
FROM ShowRoom.OfertaShowRoom o
INNER JOIN ods.Campania c on 
	c.CampaniaID = o.CampaniaID
JOIN @StockPrecioOfertaShowRoom t ON 
	c.Codigo = t.CampaniaID
	AND o.CUV = t.CUV
	AND o.TipoOfertaSisID = t.TipoOfertaSisID

end

GO

ALTER procedure ShowRoom.GetShowRoomOfertasConsultora
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
o.OfertaShowRoomID,o.CampaniaID,o.CUV,o.TipoOfertaSisID,o.ConfiguracionOfertaID,o.Descripcion,
o.PrecioOferta  AS PrecioOferta,
COALESCE(o.PrecioOferta2,pc.PrecioCatalogo) AS PrecioCatalogo,
o.Stock,
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

ALTER procedure [ShowRoom].[GetShowRoomCompraPorCompra]
(
@EventoID int,
@CampaniaID int
)
as
/*
ShowRoom.GetShowRoomCompraPorCompra 5,201705
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
	pc.PrecioCatalogo as PrecioCatalogo,
	MarcaID as MarcaID,
	Orden,
	SAP as CodigoProducto,
	cpc.PrecioValorizado as PrecioOferta	
from [ShowRoom].[CompraPorCompra] cpc 
inner join [ShowRoom].[Evento] e on cpc.EventoID = e.EventoID
inner join [ods].[Campania] c on e.CampaniaID = c.Codigo
inner join [ods].[ProductoComercial] pc on (c.CampaniaID = pc.CampaniaID and cpc.CUV = pc.CUV and cpc.SAP = pc.CodigoProducto)
where cpc.CUV not in (select distinct Cuv from @Productos_Faltantes_tmp)
and cpc.EventoID = @EventoID
end

go

ALTER PROCEDURE [ShowRoom].[GetShowRoomOfertaById] -- Alter the SP Always
 @OfertaShowRoomID int
AS
BEGIN
 
 SET NOCOUNT ON;
  
	select OfertaShowRoomID, CampaniaID, CUV, TipoOfertaSisID, ConfiguracionOfertaID, Descripcion,
	PrecioOferta, Stock, StockInicial, ImagenProducto, UnidadesPermitidas, FlagHabilitarProducto,
	DescripcionLegal, UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion,
	ImagenMini,Orden
	from showroom.ofertashowroom
	where OfertaShowRoomID = @OfertaShowRoomID
 
END

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomTipoOferta
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[ExisteShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].ExisteShowRoomTipoOferta
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[InsertShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].InsertShowRoomTipoOferta
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[UpdateShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].UpdateShowRoomTipoOferta
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[HabilitarShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].HabilitarShowRoomTipoOferta
GO

USE BelcorpPanama
go

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[TipoOferta]') AND (type = 'U') )
	DROP TABLE ShowRoom.TipoOferta
GO

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'PrecioOferta') = 1
	EXEC sp_RENAME 'ShowRoom.OfertaShowRoom.PrecioOferta' , 'PrecioOferta2', 'COLUMN' 
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'PrecioValorizado') = 1
	EXEC sp_RENAME 'ShowRoom.OfertaShowRoom.PrecioValorizado' , 'PrecioOferta', 'COLUMN' 
go

ALTER procedure ShowRoom.GetProductosShowRoom
@TipoOfertaSisID int,
@CampaniaID int,
@CodigoOferta varchar(8)
as
/*
ShowRoom.GetProductosShowRoom 1707,201706,'105'
*/
begin

select 
	ISNULL(OS.OfertaShowRoomID,0) OfertaShowRoomID,
	ISNULL(CO.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
	ROW_NUMBER() OVER (ORDER BY (SELECT 1)) as NroOrden,
	PC.CampaniaID,
	CA.Codigo as CodigoCampania,
	PC.CUV,
	PC.CodigoTipoOferta,
	CO.Descripcion as TipoOferta,
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
INNER JOIN ConfiguracionOferta CO ON 
	CO.CodigoOferta = PC.CodigoTipoOferta
LEFT JOIN ShowRoom.OfertaShowRoom OS WITH(NOLOCK) ON 
	OS.CUV = PC.CUV 
	AND OS.CampaniaID = PC.CampaniaID
WHERE 
	PC.CodigoTipoOferta = @CodigoOferta
	AND CA.Codigo = @CampaniaID
ORDER BY CO.Descripcion, OS.CUV desc

end

go

ALTER PROCEDURE ShowRoom.InsOfertaShowRoom
(	
	@CampaniaID int,
	@CUV varchar(20),
	@TipoOfertaSisID int,
	@ConfiguracionOfertaID int,
	@Descripcion varchar(250),
	@PrecioOferta numeric(12,2),
	@ImagenProducto varchar(150),
	@Orden int,
	@UnidadesPermitidas int,
	@FlagHabilitarProducto int,
	@DescripcionLegal varchar(250),
	@UsuarioRegistro varchar(50),
	@ImagenMini varchar(150),
	@PrecioOferta2 decimal(12,2)=0
)
AS
BEGIN
	INSERT INTO ShowRoom.OfertaShowRoom
	(
		CampaniaID, CUV, TipoOfertaSisID, ConfiguracionOfertaID, Descripcion, PrecioOferta, Stock, StockInicial, ImagenProducto,
		Orden, UnidadesPermitidas, FlagHabilitarProducto, DescripcionLegal, UsuarioRegistro, FechaRegistro, ImagenMini, PrecioOferta2
	)
	VALUES
	(
		@CampaniaID, @CUV, @TipoOfertaSisID, @ConfiguracionOfertaID, @Descripcion, @PrecioOferta, 0, 0, @ImagenProducto, 
		@Orden, @UnidadesPermitidas, @FlagHabilitarProducto, @DescripcionLegal, @UsuarioRegistro, getdate(), @ImagenMini, @PrecioOferta2
	)
END

GO

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
	@PrecioOferta decimal(18,2),
	@ImagenMini varchar(150),
	@Incrementa int,
	@CantidadIncrementa int,
	@FlagAgotado int,
	@PrecioOferta2 decimal(18,2)=0
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
			PrecioOferta = @PrecioOferta,
			FechaModificacion = getdate(),
			ImagenMini = @ImagenMini,
			Stock = (CASE WHEN @Incrementa = 0 AND @FlagAgotado = 0 THEN Stock + @CantidadIncrementa 
							WHEN @Incrementa = 1 AND @FlagAgotado = 0 THEN Stock - @CantidadIncrementa 
							WHEN @FlagAgotado = 1 THEN 0 END),
			StockInicial = (CASE WHEN @Incrementa = 0 THEN StockInicial + @CantidadIncrementa 
							ELSE StockInicial - @CantidadIncrementa END),
			PrecioOferta2 = @PrecioOferta2
	where 
		CampaniaID = @CampaniaID
		AND CUV = @CUV
END

GO

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
	[PrecioOferta] [decimal](18, 2) NULL,
	[UnidadesPermitidas] [int] NULL,
	[Descripcion] [varchar](250) NULL,
	[CodigoCategoria] [varchar](100) NULL,
	[TipNegocio] [varchar](500) NULL
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
	UnidadesPermitidas = t.UnidadesPermitidas,
	Descripcion = t.Descripcion,
	CodigoCategoria = t.CodigoCategoria,
	TipNegocio = t.TipNegocio,
	PrecioOferta2 = t.PrecioOferta2
FROM ShowRoom.OfertaShowRoom o
INNER JOIN ods.Campania c on 
	c.CampaniaID = o.CampaniaID
JOIN @StockPrecioOfertaShowRoom t ON 
	c.Codigo = t.CampaniaID
	AND o.CUV = t.CUV
	AND o.TipoOfertaSisID = t.TipoOfertaSisID

end

GO

ALTER procedure ShowRoom.GetShowRoomOfertasConsultora
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
o.OfertaShowRoomID,o.CampaniaID,o.CUV,o.TipoOfertaSisID,o.ConfiguracionOfertaID,o.Descripcion,
o.PrecioOferta  AS PrecioOferta,
COALESCE(o.PrecioOferta2,pc.PrecioCatalogo) AS PrecioCatalogo,
o.Stock,
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

ALTER procedure [ShowRoom].[GetShowRoomCompraPorCompra]
(
@EventoID int,
@CampaniaID int
)
as
/*
ShowRoom.GetShowRoomCompraPorCompra 5,201705
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
	pc.PrecioCatalogo as PrecioCatalogo,
	MarcaID as MarcaID,
	Orden,
	SAP as CodigoProducto,
	cpc.PrecioValorizado as PrecioOferta	
from [ShowRoom].[CompraPorCompra] cpc 
inner join [ShowRoom].[Evento] e on cpc.EventoID = e.EventoID
inner join [ods].[Campania] c on e.CampaniaID = c.Codigo
inner join [ods].[ProductoComercial] pc on (c.CampaniaID = pc.CampaniaID and cpc.CUV = pc.CUV and cpc.SAP = pc.CodigoProducto)
where cpc.CUV not in (select distinct Cuv from @Productos_Faltantes_tmp)
and cpc.EventoID = @EventoID
end

go

ALTER PROCEDURE [ShowRoom].[GetShowRoomOfertaById] -- Alter the SP Always
 @OfertaShowRoomID int
AS
BEGIN
 
 SET NOCOUNT ON;
  
	select OfertaShowRoomID, CampaniaID, CUV, TipoOfertaSisID, ConfiguracionOfertaID, Descripcion,
	PrecioOferta, Stock, StockInicial, ImagenProducto, UnidadesPermitidas, FlagHabilitarProducto,
	DescripcionLegal, UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion,
	ImagenMini,Orden
	from showroom.ofertashowroom
	where OfertaShowRoomID = @OfertaShowRoomID
 
END

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomTipoOferta
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[ExisteShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].ExisteShowRoomTipoOferta
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[InsertShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].InsertShowRoomTipoOferta
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[UpdateShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].UpdateShowRoomTipoOferta
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[HabilitarShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].HabilitarShowRoomTipoOferta
GO

USE BelcorpPeru
go

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[TipoOferta]') AND (type = 'U') )
	DROP TABLE ShowRoom.TipoOferta
GO

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'PrecioOferta') = 1
	EXEC sp_RENAME 'ShowRoom.OfertaShowRoom.PrecioOferta' , 'PrecioOferta2', 'COLUMN' 
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'PrecioValorizado') = 1
	EXEC sp_RENAME 'ShowRoom.OfertaShowRoom.PrecioValorizado' , 'PrecioOferta', 'COLUMN' 
go

ALTER procedure ShowRoom.GetProductosShowRoom
@TipoOfertaSisID int,
@CampaniaID int,
@CodigoOferta varchar(8)
as
/*
ShowRoom.GetProductosShowRoom 1707,201706,'105'
*/
begin

select 
	ISNULL(OS.OfertaShowRoomID,0) OfertaShowRoomID,
	ISNULL(CO.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
	ROW_NUMBER() OVER (ORDER BY (SELECT 1)) as NroOrden,
	PC.CampaniaID,
	CA.Codigo as CodigoCampania,
	PC.CUV,
	PC.CodigoTipoOferta,
	CO.Descripcion as TipoOferta,
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
INNER JOIN ConfiguracionOferta CO ON 
	CO.CodigoOferta = PC.CodigoTipoOferta
LEFT JOIN ShowRoom.OfertaShowRoom OS WITH(NOLOCK) ON 
	OS.CUV = PC.CUV 
	AND OS.CampaniaID = PC.CampaniaID
WHERE 
	PC.CodigoTipoOferta = @CodigoOferta
	AND CA.Codigo = @CampaniaID
ORDER BY CO.Descripcion, OS.CUV desc

end

go

ALTER PROCEDURE ShowRoom.InsOfertaShowRoom
(	
	@CampaniaID int,
	@CUV varchar(20),
	@TipoOfertaSisID int,
	@ConfiguracionOfertaID int,
	@Descripcion varchar(250),
	@PrecioOferta numeric(12,2),
	@ImagenProducto varchar(150),
	@Orden int,
	@UnidadesPermitidas int,
	@FlagHabilitarProducto int,
	@DescripcionLegal varchar(250),
	@UsuarioRegistro varchar(50),
	@ImagenMini varchar(150),
	@PrecioOferta2 decimal(12,2)=0
)
AS
BEGIN
	INSERT INTO ShowRoom.OfertaShowRoom
	(
		CampaniaID, CUV, TipoOfertaSisID, ConfiguracionOfertaID, Descripcion, PrecioOferta, Stock, StockInicial, ImagenProducto,
		Orden, UnidadesPermitidas, FlagHabilitarProducto, DescripcionLegal, UsuarioRegistro, FechaRegistro, ImagenMini, PrecioOferta2
	)
	VALUES
	(
		@CampaniaID, @CUV, @TipoOfertaSisID, @ConfiguracionOfertaID, @Descripcion, @PrecioOferta, 0, 0, @ImagenProducto, 
		@Orden, @UnidadesPermitidas, @FlagHabilitarProducto, @DescripcionLegal, @UsuarioRegistro, getdate(), @ImagenMini, @PrecioOferta2
	)
END

GO

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
	@PrecioOferta decimal(18,2),
	@ImagenMini varchar(150),
	@Incrementa int,
	@CantidadIncrementa int,
	@FlagAgotado int,
	@PrecioOferta2 decimal(18,2)=0
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
			PrecioOferta = @PrecioOferta,
			FechaModificacion = getdate(),
			ImagenMini = @ImagenMini,
			Stock = (CASE WHEN @Incrementa = 0 AND @FlagAgotado = 0 THEN Stock + @CantidadIncrementa 
							WHEN @Incrementa = 1 AND @FlagAgotado = 0 THEN Stock - @CantidadIncrementa 
							WHEN @FlagAgotado = 1 THEN 0 END),
			StockInicial = (CASE WHEN @Incrementa = 0 THEN StockInicial + @CantidadIncrementa 
							ELSE StockInicial - @CantidadIncrementa END),
			PrecioOferta2 = @PrecioOferta2
	where 
		CampaniaID = @CampaniaID
		AND CUV = @CUV
END

GO

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
	[PrecioOferta] [decimal](18, 2) NULL,
	[UnidadesPermitidas] [int] NULL,
	[Descripcion] [varchar](250) NULL,
	[CodigoCategoria] [varchar](100) NULL,
	[TipNegocio] [varchar](500) NULL
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
	UnidadesPermitidas = t.UnidadesPermitidas,
	Descripcion = t.Descripcion,
	CodigoCategoria = t.CodigoCategoria,
	TipNegocio = t.TipNegocio,
	PrecioOferta2 = t.PrecioOferta2
FROM ShowRoom.OfertaShowRoom o
INNER JOIN ods.Campania c on 
	c.CampaniaID = o.CampaniaID
JOIN @StockPrecioOfertaShowRoom t ON 
	c.Codigo = t.CampaniaID
	AND o.CUV = t.CUV
	AND o.TipoOfertaSisID = t.TipoOfertaSisID

end

GO

ALTER procedure ShowRoom.GetShowRoomOfertasConsultora
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
o.OfertaShowRoomID,o.CampaniaID,o.CUV,o.TipoOfertaSisID,o.ConfiguracionOfertaID,o.Descripcion,
o.PrecioOferta  AS PrecioOferta,
COALESCE(o.PrecioOferta2,pc.PrecioCatalogo) AS PrecioCatalogo,
o.Stock,
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

ALTER procedure [ShowRoom].[GetShowRoomCompraPorCompra]
(
@EventoID int,
@CampaniaID int
)
as
/*
ShowRoom.GetShowRoomCompraPorCompra 5,201705
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
	pc.PrecioCatalogo as PrecioCatalogo,
	MarcaID as MarcaID,
	Orden,
	SAP as CodigoProducto,
	cpc.PrecioValorizado as PrecioOferta	
from [ShowRoom].[CompraPorCompra] cpc 
inner join [ShowRoom].[Evento] e on cpc.EventoID = e.EventoID
inner join [ods].[Campania] c on e.CampaniaID = c.Codigo
inner join [ods].[ProductoComercial] pc on (c.CampaniaID = pc.CampaniaID and cpc.CUV = pc.CUV and cpc.SAP = pc.CodigoProducto)
where cpc.CUV not in (select distinct Cuv from @Productos_Faltantes_tmp)
and cpc.EventoID = @EventoID
end

go

ALTER PROCEDURE [ShowRoom].[GetShowRoomOfertaById] -- Alter the SP Always
 @OfertaShowRoomID int
AS
BEGIN
 
 SET NOCOUNT ON;
  
	select OfertaShowRoomID, CampaniaID, CUV, TipoOfertaSisID, ConfiguracionOfertaID, Descripcion,
	PrecioOferta, Stock, StockInicial, ImagenProducto, UnidadesPermitidas, FlagHabilitarProducto,
	DescripcionLegal, UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion,
	ImagenMini,Orden
	from showroom.ofertashowroom
	where OfertaShowRoomID = @OfertaShowRoomID
 
END

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomTipoOferta
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[ExisteShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].ExisteShowRoomTipoOferta
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[InsertShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].InsertShowRoomTipoOferta
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[UpdateShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].UpdateShowRoomTipoOferta
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[HabilitarShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].HabilitarShowRoomTipoOferta
GO

USE BelcorpPuertoRico
go

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[TipoOferta]') AND (type = 'U') )
	DROP TABLE ShowRoom.TipoOferta
GO

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'PrecioOferta') = 1
	EXEC sp_RENAME 'ShowRoom.OfertaShowRoom.PrecioOferta' , 'PrecioOferta2', 'COLUMN' 
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'PrecioValorizado') = 1
	EXEC sp_RENAME 'ShowRoom.OfertaShowRoom.PrecioValorizado' , 'PrecioOferta', 'COLUMN' 
go

ALTER procedure ShowRoom.GetProductosShowRoom
@TipoOfertaSisID int,
@CampaniaID int,
@CodigoOferta varchar(8)
as
/*
ShowRoom.GetProductosShowRoom 1707,201706,'105'
*/
begin

select 
	ISNULL(OS.OfertaShowRoomID,0) OfertaShowRoomID,
	ISNULL(CO.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
	ROW_NUMBER() OVER (ORDER BY (SELECT 1)) as NroOrden,
	PC.CampaniaID,
	CA.Codigo as CodigoCampania,
	PC.CUV,
	PC.CodigoTipoOferta,
	CO.Descripcion as TipoOferta,
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
INNER JOIN ConfiguracionOferta CO ON 
	CO.CodigoOferta = PC.CodigoTipoOferta
LEFT JOIN ShowRoom.OfertaShowRoom OS WITH(NOLOCK) ON 
	OS.CUV = PC.CUV 
	AND OS.CampaniaID = PC.CampaniaID
WHERE 
	PC.CodigoTipoOferta = @CodigoOferta
	AND CA.Codigo = @CampaniaID
ORDER BY CO.Descripcion, OS.CUV desc

end

go

ALTER PROCEDURE ShowRoom.InsOfertaShowRoom
(	
	@CampaniaID int,
	@CUV varchar(20),
	@TipoOfertaSisID int,
	@ConfiguracionOfertaID int,
	@Descripcion varchar(250),
	@PrecioOferta numeric(12,2),
	@ImagenProducto varchar(150),
	@Orden int,
	@UnidadesPermitidas int,
	@FlagHabilitarProducto int,
	@DescripcionLegal varchar(250),
	@UsuarioRegistro varchar(50),
	@ImagenMini varchar(150),
	@PrecioOferta2 decimal(12,2)=0
)
AS
BEGIN
	INSERT INTO ShowRoom.OfertaShowRoom
	(
		CampaniaID, CUV, TipoOfertaSisID, ConfiguracionOfertaID, Descripcion, PrecioOferta, Stock, StockInicial, ImagenProducto,
		Orden, UnidadesPermitidas, FlagHabilitarProducto, DescripcionLegal, UsuarioRegistro, FechaRegistro, ImagenMini, PrecioOferta2
	)
	VALUES
	(
		@CampaniaID, @CUV, @TipoOfertaSisID, @ConfiguracionOfertaID, @Descripcion, @PrecioOferta, 0, 0, @ImagenProducto, 
		@Orden, @UnidadesPermitidas, @FlagHabilitarProducto, @DescripcionLegal, @UsuarioRegistro, getdate(), @ImagenMini, @PrecioOferta2
	)
END

GO

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
	@PrecioOferta decimal(18,2),
	@ImagenMini varchar(150),
	@Incrementa int,
	@CantidadIncrementa int,
	@FlagAgotado int,
	@PrecioOferta2 decimal(18,2)=0
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
			PrecioOferta = @PrecioOferta,
			FechaModificacion = getdate(),
			ImagenMini = @ImagenMini,
			Stock = (CASE WHEN @Incrementa = 0 AND @FlagAgotado = 0 THEN Stock + @CantidadIncrementa 
							WHEN @Incrementa = 1 AND @FlagAgotado = 0 THEN Stock - @CantidadIncrementa 
							WHEN @FlagAgotado = 1 THEN 0 END),
			StockInicial = (CASE WHEN @Incrementa = 0 THEN StockInicial + @CantidadIncrementa 
							ELSE StockInicial - @CantidadIncrementa END),
			PrecioOferta2 = @PrecioOferta2
	where 
		CampaniaID = @CampaniaID
		AND CUV = @CUV
END

GO

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
	[PrecioOferta] [decimal](18, 2) NULL,
	[UnidadesPermitidas] [int] NULL,
	[Descripcion] [varchar](250) NULL,
	[CodigoCategoria] [varchar](100) NULL,
	[TipNegocio] [varchar](500) NULL
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
	UnidadesPermitidas = t.UnidadesPermitidas,
	Descripcion = t.Descripcion,
	CodigoCategoria = t.CodigoCategoria,
	TipNegocio = t.TipNegocio,
	PrecioOferta2 = t.PrecioOferta2
FROM ShowRoom.OfertaShowRoom o
INNER JOIN ods.Campania c on 
	c.CampaniaID = o.CampaniaID
JOIN @StockPrecioOfertaShowRoom t ON 
	c.Codigo = t.CampaniaID
	AND o.CUV = t.CUV
	AND o.TipoOfertaSisID = t.TipoOfertaSisID

end

GO

ALTER procedure ShowRoom.GetShowRoomOfertasConsultora
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
o.OfertaShowRoomID,o.CampaniaID,o.CUV,o.TipoOfertaSisID,o.ConfiguracionOfertaID,o.Descripcion,
o.PrecioOferta  AS PrecioOferta,
COALESCE(o.PrecioOferta2,pc.PrecioCatalogo) AS PrecioCatalogo,
o.Stock,
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

ALTER procedure [ShowRoom].[GetShowRoomCompraPorCompra]
(
@EventoID int,
@CampaniaID int
)
as
/*
ShowRoom.GetShowRoomCompraPorCompra 5,201705
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
	pc.PrecioCatalogo as PrecioCatalogo,
	MarcaID as MarcaID,
	Orden,
	SAP as CodigoProducto,
	cpc.PrecioValorizado as PrecioOferta	
from [ShowRoom].[CompraPorCompra] cpc 
inner join [ShowRoom].[Evento] e on cpc.EventoID = e.EventoID
inner join [ods].[Campania] c on e.CampaniaID = c.Codigo
inner join [ods].[ProductoComercial] pc on (c.CampaniaID = pc.CampaniaID and cpc.CUV = pc.CUV and cpc.SAP = pc.CodigoProducto)
where cpc.CUV not in (select distinct Cuv from @Productos_Faltantes_tmp)
and cpc.EventoID = @EventoID
end

go

ALTER PROCEDURE [ShowRoom].[GetShowRoomOfertaById] -- Alter the SP Always
 @OfertaShowRoomID int
AS
BEGIN
 
 SET NOCOUNT ON;
  
	select OfertaShowRoomID, CampaniaID, CUV, TipoOfertaSisID, ConfiguracionOfertaID, Descripcion,
	PrecioOferta, Stock, StockInicial, ImagenProducto, UnidadesPermitidas, FlagHabilitarProducto,
	DescripcionLegal, UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion,
	ImagenMini,Orden
	from showroom.ofertashowroom
	where OfertaShowRoomID = @OfertaShowRoomID
 
END

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomTipoOferta
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[ExisteShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].ExisteShowRoomTipoOferta
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[InsertShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].InsertShowRoomTipoOferta
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[UpdateShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].UpdateShowRoomTipoOferta
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[HabilitarShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].HabilitarShowRoomTipoOferta
GO

USE BelcorpSalvador
go

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[TipoOferta]') AND (type = 'U') )
	DROP TABLE ShowRoom.TipoOferta
GO

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'PrecioOferta') = 1
	EXEC sp_RENAME 'ShowRoom.OfertaShowRoom.PrecioOferta' , 'PrecioOferta2', 'COLUMN' 
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'PrecioValorizado') = 1
	EXEC sp_RENAME 'ShowRoom.OfertaShowRoom.PrecioValorizado' , 'PrecioOferta', 'COLUMN' 
go

ALTER procedure ShowRoom.GetProductosShowRoom
@TipoOfertaSisID int,
@CampaniaID int,
@CodigoOferta varchar(8)
as
/*
ShowRoom.GetProductosShowRoom 1707,201706,'105'
*/
begin

select 
	ISNULL(OS.OfertaShowRoomID,0) OfertaShowRoomID,
	ISNULL(CO.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
	ROW_NUMBER() OVER (ORDER BY (SELECT 1)) as NroOrden,
	PC.CampaniaID,
	CA.Codigo as CodigoCampania,
	PC.CUV,
	PC.CodigoTipoOferta,
	CO.Descripcion as TipoOferta,
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
INNER JOIN ConfiguracionOferta CO ON 
	CO.CodigoOferta = PC.CodigoTipoOferta
LEFT JOIN ShowRoom.OfertaShowRoom OS WITH(NOLOCK) ON 
	OS.CUV = PC.CUV 
	AND OS.CampaniaID = PC.CampaniaID
WHERE 
	PC.CodigoTipoOferta = @CodigoOferta
	AND CA.Codigo = @CampaniaID
ORDER BY CO.Descripcion, OS.CUV desc

end

go

ALTER PROCEDURE ShowRoom.InsOfertaShowRoom
(	
	@CampaniaID int,
	@CUV varchar(20),
	@TipoOfertaSisID int,
	@ConfiguracionOfertaID int,
	@Descripcion varchar(250),
	@PrecioOferta numeric(12,2),
	@ImagenProducto varchar(150),
	@Orden int,
	@UnidadesPermitidas int,
	@FlagHabilitarProducto int,
	@DescripcionLegal varchar(250),
	@UsuarioRegistro varchar(50),
	@ImagenMini varchar(150),
	@PrecioOferta2 decimal(12,2)=0
)
AS
BEGIN
	INSERT INTO ShowRoom.OfertaShowRoom
	(
		CampaniaID, CUV, TipoOfertaSisID, ConfiguracionOfertaID, Descripcion, PrecioOferta, Stock, StockInicial, ImagenProducto,
		Orden, UnidadesPermitidas, FlagHabilitarProducto, DescripcionLegal, UsuarioRegistro, FechaRegistro, ImagenMini, PrecioOferta2
	)
	VALUES
	(
		@CampaniaID, @CUV, @TipoOfertaSisID, @ConfiguracionOfertaID, @Descripcion, @PrecioOferta, 0, 0, @ImagenProducto, 
		@Orden, @UnidadesPermitidas, @FlagHabilitarProducto, @DescripcionLegal, @UsuarioRegistro, getdate(), @ImagenMini, @PrecioOferta2
	)
END

GO

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
	@PrecioOferta decimal(18,2),
	@ImagenMini varchar(150),
	@Incrementa int,
	@CantidadIncrementa int,
	@FlagAgotado int,
	@PrecioOferta2 decimal(18,2)=0
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
			PrecioOferta = @PrecioOferta,
			FechaModificacion = getdate(),
			ImagenMini = @ImagenMini,
			Stock = (CASE WHEN @Incrementa = 0 AND @FlagAgotado = 0 THEN Stock + @CantidadIncrementa 
							WHEN @Incrementa = 1 AND @FlagAgotado = 0 THEN Stock - @CantidadIncrementa 
							WHEN @FlagAgotado = 1 THEN 0 END),
			StockInicial = (CASE WHEN @Incrementa = 0 THEN StockInicial + @CantidadIncrementa 
							ELSE StockInicial - @CantidadIncrementa END),
			PrecioOferta2 = @PrecioOferta2
	where 
		CampaniaID = @CampaniaID
		AND CUV = @CUV
END

GO

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
	[PrecioOferta] [decimal](18, 2) NULL,
	[UnidadesPermitidas] [int] NULL,
	[Descripcion] [varchar](250) NULL,
	[CodigoCategoria] [varchar](100) NULL,
	[TipNegocio] [varchar](500) NULL
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
	UnidadesPermitidas = t.UnidadesPermitidas,
	Descripcion = t.Descripcion,
	CodigoCategoria = t.CodigoCategoria,
	TipNegocio = t.TipNegocio,
	PrecioOferta2 = t.PrecioOferta2
FROM ShowRoom.OfertaShowRoom o
INNER JOIN ods.Campania c on 
	c.CampaniaID = o.CampaniaID
JOIN @StockPrecioOfertaShowRoom t ON 
	c.Codigo = t.CampaniaID
	AND o.CUV = t.CUV
	AND o.TipoOfertaSisID = t.TipoOfertaSisID

end

GO

ALTER procedure ShowRoom.GetShowRoomOfertasConsultora
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
o.OfertaShowRoomID,o.CampaniaID,o.CUV,o.TipoOfertaSisID,o.ConfiguracionOfertaID,o.Descripcion,
o.PrecioOferta  AS PrecioOferta,
COALESCE(o.PrecioOferta2,pc.PrecioCatalogo) AS PrecioCatalogo,
o.Stock,
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

ALTER procedure [ShowRoom].[GetShowRoomCompraPorCompra]
(
@EventoID int,
@CampaniaID int
)
as
/*
ShowRoom.GetShowRoomCompraPorCompra 5,201705
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
	pc.PrecioCatalogo as PrecioCatalogo,
	MarcaID as MarcaID,
	Orden,
	SAP as CodigoProducto,
	cpc.PrecioValorizado as PrecioOferta	
from [ShowRoom].[CompraPorCompra] cpc 
inner join [ShowRoom].[Evento] e on cpc.EventoID = e.EventoID
inner join [ods].[Campania] c on e.CampaniaID = c.Codigo
inner join [ods].[ProductoComercial] pc on (c.CampaniaID = pc.CampaniaID and cpc.CUV = pc.CUV and cpc.SAP = pc.CodigoProducto)
where cpc.CUV not in (select distinct Cuv from @Productos_Faltantes_tmp)
and cpc.EventoID = @EventoID
end

go

ALTER PROCEDURE [ShowRoom].[GetShowRoomOfertaById] -- Alter the SP Always
 @OfertaShowRoomID int
AS
BEGIN
 
 SET NOCOUNT ON;
  
	select OfertaShowRoomID, CampaniaID, CUV, TipoOfertaSisID, ConfiguracionOfertaID, Descripcion,
	PrecioOferta, Stock, StockInicial, ImagenProducto, UnidadesPermitidas, FlagHabilitarProducto,
	DescripcionLegal, UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion,
	ImagenMini,Orden
	from showroom.ofertashowroom
	where OfertaShowRoomID = @OfertaShowRoomID
 
END

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomTipoOferta
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[ExisteShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].ExisteShowRoomTipoOferta
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[InsertShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].InsertShowRoomTipoOferta
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[UpdateShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].UpdateShowRoomTipoOferta
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[HabilitarShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].HabilitarShowRoomTipoOferta
GO

USE BelcorpVenezuela
go

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[TipoOferta]') AND (type = 'U') )
	DROP TABLE ShowRoom.TipoOferta
GO

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'PrecioOferta') = 1
	EXEC sp_RENAME 'ShowRoom.OfertaShowRoom.PrecioOferta' , 'PrecioOferta2', 'COLUMN' 
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'PrecioValorizado') = 1
	EXEC sp_RENAME 'ShowRoom.OfertaShowRoom.PrecioValorizado' , 'PrecioOferta', 'COLUMN' 
go

ALTER procedure ShowRoom.GetProductosShowRoom
@TipoOfertaSisID int,
@CampaniaID int,
@CodigoOferta varchar(8)
as
/*
ShowRoom.GetProductosShowRoom 1707,201706,'105'
*/
begin

select 
	ISNULL(OS.OfertaShowRoomID,0) OfertaShowRoomID,
	ISNULL(CO.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
	ROW_NUMBER() OVER (ORDER BY (SELECT 1)) as NroOrden,
	PC.CampaniaID,
	CA.Codigo as CodigoCampania,
	PC.CUV,
	PC.CodigoTipoOferta,
	CO.Descripcion as TipoOferta,
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
INNER JOIN ConfiguracionOferta CO ON 
	CO.CodigoOferta = PC.CodigoTipoOferta
LEFT JOIN ShowRoom.OfertaShowRoom OS WITH(NOLOCK) ON 
	OS.CUV = PC.CUV 
	AND OS.CampaniaID = PC.CampaniaID
WHERE 
	PC.CodigoTipoOferta = @CodigoOferta
	AND CA.Codigo = @CampaniaID
ORDER BY CO.Descripcion, OS.CUV desc

end

go

ALTER PROCEDURE ShowRoom.InsOfertaShowRoom
(	
	@CampaniaID int,
	@CUV varchar(20),
	@TipoOfertaSisID int,
	@ConfiguracionOfertaID int,
	@Descripcion varchar(250),
	@PrecioOferta numeric(12,2),
	@ImagenProducto varchar(150),
	@Orden int,
	@UnidadesPermitidas int,
	@FlagHabilitarProducto int,
	@DescripcionLegal varchar(250),
	@UsuarioRegistro varchar(50),
	@ImagenMini varchar(150),
	@PrecioOferta2 decimal(12,2)=0
)
AS
BEGIN
	INSERT INTO ShowRoom.OfertaShowRoom
	(
		CampaniaID, CUV, TipoOfertaSisID, ConfiguracionOfertaID, Descripcion, PrecioOferta, Stock, StockInicial, ImagenProducto,
		Orden, UnidadesPermitidas, FlagHabilitarProducto, DescripcionLegal, UsuarioRegistro, FechaRegistro, ImagenMini, PrecioOferta2
	)
	VALUES
	(
		@CampaniaID, @CUV, @TipoOfertaSisID, @ConfiguracionOfertaID, @Descripcion, @PrecioOferta, 0, 0, @ImagenProducto, 
		@Orden, @UnidadesPermitidas, @FlagHabilitarProducto, @DescripcionLegal, @UsuarioRegistro, getdate(), @ImagenMini, @PrecioOferta2
	)
END

GO

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
	@PrecioOferta decimal(18,2),
	@ImagenMini varchar(150),
	@Incrementa int,
	@CantidadIncrementa int,
	@FlagAgotado int,
	@PrecioOferta2 decimal(18,2)=0
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
			PrecioOferta = @PrecioOferta,
			FechaModificacion = getdate(),
			ImagenMini = @ImagenMini,
			Stock = (CASE WHEN @Incrementa = 0 AND @FlagAgotado = 0 THEN Stock + @CantidadIncrementa 
							WHEN @Incrementa = 1 AND @FlagAgotado = 0 THEN Stock - @CantidadIncrementa 
							WHEN @FlagAgotado = 1 THEN 0 END),
			StockInicial = (CASE WHEN @Incrementa = 0 THEN StockInicial + @CantidadIncrementa 
							ELSE StockInicial - @CantidadIncrementa END),
			PrecioOferta2 = @PrecioOferta2
	where 
		CampaniaID = @CampaniaID
		AND CUV = @CUV
END

GO

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
	[PrecioOferta] [decimal](18, 2) NULL,
	[UnidadesPermitidas] [int] NULL,
	[Descripcion] [varchar](250) NULL,
	[CodigoCategoria] [varchar](100) NULL,
	[TipNegocio] [varchar](500) NULL
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
	UnidadesPermitidas = t.UnidadesPermitidas,
	Descripcion = t.Descripcion,
	CodigoCategoria = t.CodigoCategoria,
	TipNegocio = t.TipNegocio,
	PrecioOferta2 = t.PrecioOferta2
FROM ShowRoom.OfertaShowRoom o
INNER JOIN ods.Campania c on 
	c.CampaniaID = o.CampaniaID
JOIN @StockPrecioOfertaShowRoom t ON 
	c.Codigo = t.CampaniaID
	AND o.CUV = t.CUV
	AND o.TipoOfertaSisID = t.TipoOfertaSisID

end

GO

ALTER procedure ShowRoom.GetShowRoomOfertasConsultora
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
o.OfertaShowRoomID,o.CampaniaID,o.CUV,o.TipoOfertaSisID,o.ConfiguracionOfertaID,o.Descripcion,
o.PrecioOferta  AS PrecioOferta,
COALESCE(o.PrecioOferta2,pc.PrecioCatalogo) AS PrecioCatalogo,
o.Stock,
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

ALTER procedure [ShowRoom].[GetShowRoomCompraPorCompra]
(
@EventoID int,
@CampaniaID int
)
as
/*
ShowRoom.GetShowRoomCompraPorCompra 5,201705
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
	pc.PrecioCatalogo as PrecioCatalogo,
	MarcaID as MarcaID,
	Orden,
	SAP as CodigoProducto,
	cpc.PrecioValorizado as PrecioOferta	
from [ShowRoom].[CompraPorCompra] cpc 
inner join [ShowRoom].[Evento] e on cpc.EventoID = e.EventoID
inner join [ods].[Campania] c on e.CampaniaID = c.Codigo
inner join [ods].[ProductoComercial] pc on (c.CampaniaID = pc.CampaniaID and cpc.CUV = pc.CUV and cpc.SAP = pc.CodigoProducto)
where cpc.CUV not in (select distinct Cuv from @Productos_Faltantes_tmp)
and cpc.EventoID = @EventoID
end

go

ALTER PROCEDURE [ShowRoom].[GetShowRoomOfertaById] -- Alter the SP Always
 @OfertaShowRoomID int
AS
BEGIN
 
 SET NOCOUNT ON;
  
	select OfertaShowRoomID, CampaniaID, CUV, TipoOfertaSisID, ConfiguracionOfertaID, Descripcion,
	PrecioOferta, Stock, StockInicial, ImagenProducto, UnidadesPermitidas, FlagHabilitarProducto,
	DescripcionLegal, UsuarioRegistro, FechaRegistro, UsuarioModificacion, FechaModificacion,
	ImagenMini,Orden
	from showroom.ofertashowroom
	where OfertaShowRoomID = @OfertaShowRoomID
 
END

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomTipoOferta
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[ExisteShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].ExisteShowRoomTipoOferta
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[InsertShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].InsertShowRoomTipoOferta
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[UpdateShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].UpdateShowRoomTipoOferta
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[HabilitarShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].HabilitarShowRoomTipoOferta
GO