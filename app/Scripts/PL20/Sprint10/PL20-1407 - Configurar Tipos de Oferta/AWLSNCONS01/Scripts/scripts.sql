USE BelcorpBolivia
go

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[TipoOferta]') AND (type = 'U') )
	DROP TABLE ShowRoom.TipoOferta
GO

create table ShowRoom.TipoOferta
(
TipoOfertaID int identity(1,1) primary key,
Codigo varchar(20),
Descripcion varchar(100),
Activo bit,
FechaCreacion datetime,
UsuarioCreacion varchar(50),
FechaModificacion datetime,
UsuarioModificacion varchar(50)
)

GO

insert into ShowRoom.TipoOferta(Codigo,Descripcion,Activo,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion)
values
('105','Oferta ShowRoom 1',1,getdate(),'ADMCONTENIDO',getdate(),'ADMCONTENIDO')

go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'PrecioValorizado') = 0
	EXEC sp_RENAME 'ShowRoom.OfertaShowRoom.PrecioOferta' , 'PrecioValorizado', 'COLUMN' 
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'PrecioOferta') = 0
	EXEC sp_RENAME 'ShowRoom.OfertaShowRoom.PrecioOferta2' , 'PrecioOferta', 'COLUMN' 
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'PrecioOferta2') = 1
	alter table ShowRoom.OfertaShowRoom drop column PrecioOferta2
go

alter procedure ShowRoom.GetProductosShowRoom
@CampaniaID int
as
/*
ShowRoom.GetProductosShowRoom 201706
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
	@ConfiguracionOfertaID as ConfiguracionOfertaID
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
ORDER BY OS.CUV desc

end

GO

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
	@PrecioOferta decimal(12,2)=0
)
AS
BEGIN
	INSERT INTO ShowRoom.OfertaShowRoom
	(
		CampaniaID, CUV, TipoOfertaSisID, ConfiguracionOfertaID, Descripcion, PrecioValorizado, Stock, StockInicial, ImagenProducto,
		Orden, UnidadesPermitidas, FlagHabilitarProducto, DescripcionLegal, UsuarioRegistro, FechaRegistro, ImagenMini, PrecioOferta
	)
	VALUES
	(
		@CampaniaID, @CUV, @TipoOfertaSisID, @ConfiguracionOfertaID, @Descripcion, @PrecioValorizado , 0, 0, @ImagenProducto, 
		@Orden, @UnidadesPermitidas, @FlagHabilitarProducto, @DescripcionLegal, @UsuarioRegistro, getdate(), @ImagenMini, @PrecioOferta
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
	@PrecioValorizado decimal(18,2),
	@ImagenMini varchar(150),
	@Incrementa int,
	@CantidadIncrementa int,
	@FlagAgotado int,
	@PrecioOferta decimal(18,2)=0
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
			PrecioOferta = @PrecioOferta
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
	[PrecioValorizado] [decimal](18, 2) NULL,
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
	PrecioValorizado = t.PrecioValorizado
FROM ShowRoom.OfertaShowRoom o
INNER JOIN ods.Campania c on 
	c.CampaniaID = o.CampaniaID
JOIN @StockPrecioOfertaShowRoom t ON 
	c.Codigo = t.CampaniaID
	AND o.CUV = t.CUV
	AND o.TipoOfertaSisID = t.TipoOfertaSisID

end

GO

alter procedure ShowRoom.GetShowRoomOfertasConsultora
@CampaniaID int,
@CodigoConsultora varchar(20)
as
/*
ShowRoom.GetShowRoomOfertasConsultora 201706,'0012954'
ShowRoom.GetShowRoomOfertasConsultora 201706,'1615995'
*/
begin

declare @EsConsultoraGenerica bit = 0
declare @ConsultoraGenerica varchar(50) = ''
select @ConsultoraGenerica = Codigo from TablaLogicaDatos where TablaLogicaDatosID = 10001

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

if exists (select 1 from ShowRoom.EventoConsultora where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora)
begin

insert into @tablaEventoConsultora
select top 1
EventoConsultoraID, EventoID, CampaniaID, CodigoConsultora, Segmento, MostrarPopup, MostrarPopupVenta,
FechaCreacion, UsuarioCreacion, FechaModificacion, UsuarioModificacion
from ShowRoom.EventoConsultora
where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
order by EventoConsultoraID desc

end
else
begin

set @EsConsultoraGenerica = 1

insert into @tablaEventoConsultora
select top 1
EventoConsultoraID, EventoID, CampaniaID, CodigoConsultora, Segmento, MostrarPopup, MostrarPopupVenta,
FechaCreacion, UsuarioCreacion, FechaModificacion, UsuarioModificacion
from ShowRoom.EventoConsultora
where CampaniaID = @CampaniaID and CodigoConsultora = @ConsultoraGenerica
order by EventoConsultoraID desc

end

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

if @EsConsultoraGenerica = 1
	set @CodigoConsultora = @ConsultoraGenerica

select
o.OfertaShowRoomID,o.CampaniaID,o.CUV,o.TipoOfertaSisID,o.ConfiguracionOfertaID,o.Descripcion,
o.PrecioValorizado,
COALESCE(o.PrecioOferta,pc.PrecioCatalogo) AS PrecioOferta,
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

go

ALTER procedure ShowRoom.GetShowRoomCompraPorCompra
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

ALTER PROCEDURE ShowRoom.GetShowRoomOfertaById
 @OfertaShowRoomID int
AS
/*
ShowRoom.GetShowRoomOfertaById 113
*/
BEGIN
 
 SET NOCOUNT ON;
  
	select 
		OfertaShowRoomID,CampaniaID,CUV,TipoOfertaSisID,ConfiguracionOfertaID,Descripcion,PrecioValorizado,Stock,
		StockInicial,ImagenProducto,UnidadesPermitidas,FlagHabilitarProducto,DescripcionLegal,UsuarioRegistro,FechaRegistro,
		UsuarioModificacion,FechaModificacion,ImagenMini,Orden,CodigoCategoria,TipNegocio,PrecioOferta
	from showroom.ofertashowroom
	where OfertaShowRoomID = @OfertaShowRoomID
 
END

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomOfertas]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomOfertas
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomTipoOferta
GO

create procedure ShowRoom.GetShowRoomTipoOferta
as
/*
ShowRoom.GetShowRoomTipoOferta
*/
begin

select 
TipoOfertaID,Codigo,Descripcion,Activo,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion
from ShowRoom.TipoOferta
order by Codigo

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[ExisteShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].ExisteShowRoomTipoOferta
GO

create procedure ShowRoom.ExisteShowRoomTipoOferta
@TipoOfertaID int,
@Codigo varchar(20),
@Descripcion varchar(100)
as
/*
ShowRoom.ExisteShowRoomTipoOferta 0,'106','Oferta ShowRoom 2'
*/
begin

declare @resultado int = 0
/*
Valores posibles:
0: Ok
1: Codigo Tipo de Oferta Existe
2: Descripcion de Tipo de Oferta Existe
*/

if @TipoOfertaID = 0
begin
	if exists (select 1 from ShowRoom.TipoOferta where Codigo = @Codigo)
	begin
		set @resultado = 1
	end
	else
	begin
		if exists (select 1 from ShowRoom.TipoOferta where Descripcion = @Descripcion)
		begin
			set @resultado = 2
		end
	end
end
else
begin
	declare @id int = 0

	if exists (select 1 from ShowRoom.TipoOferta where Codigo = @Codigo)
	begin		
		select @id = TipoOfertaID from ShowRoom.TipoOferta where Codigo = @Codigo

		if (@TipoOfertaID != @id and @id != 0)
			set @resultado = 1		
		else
		begin			
			select @id = TipoOfertaID from ShowRoom.TipoOferta where Descripcion = @Descripcion

			if (@TipoOfertaID != @id and @id != 0)
				set @resultado = 2
		end
	end
	else
	begin
		select @id = TipoOfertaID from ShowRoom.TipoOferta where Descripcion = @Descripcion

		if (@TipoOfertaID != @id and @id != 0)
			set @resultado = 2
	end
end

select @resultado

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[InsertShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].InsertShowRoomTipoOferta
GO

create procedure ShowRoom.InsertShowRoomTipoOferta
@Codigo varchar(20),
@Descripcion varchar(100),
@UsuarioCreacion varchar(50)
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

insert into ShowRoom.TipoOferta (Codigo,Descripcion,Activo,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion)
values (@Codigo,@Descripcion,1,@FechaGeneral,@UsuarioCreacion,@FechaGeneral,@UsuarioCreacion)

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[UpdateShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].UpdateShowRoomTipoOferta
GO

create procedure ShowRoom.UpdateShowRoomTipoOferta
@TipoOfertaID int,
@Codigo varchar(20),
@Descripcion varchar(100),
@UsuarioModificacion varchar(50)
as
/*
ShowRoom.UpdateShowRoomTipoOferta 1,'105','Oferta ShowRoom 1', 'ADMCONTENIDO'
*/
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

update ShowRoom.TipoOferta
set
	Codigo = @Codigo,
	Descripcion = @Descripcion,
	UsuarioModificacion = @UsuarioModificacion,
	FechaModificacion = @FechaGeneral
where
	TipoOfertaID = @TipoOfertaID

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[HabilitarShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].HabilitarShowRoomTipoOferta
GO

create procedure ShowRoom.HabilitarShowRoomTipoOferta
@TipoOfertaID int,
@Activo bit
as
/*
ShowRoom.HabilitarShowRoomTipoOferta 1,1
*/
begin

update ShowRoom.TipoOferta
set
	Activo = @Activo
where
	TipoOfertaID = @TipoOfertaID

end

go

alter procedure ShowRoom.GetShowRoomConsultora
@CampaniaID int,
@CodigoConsultora varchar(20)
as
/*
ShowRoom.GetShowRoomConsultora 201706,'0012954'
ShowRoom.GetShowRoomConsultora 201706,'1615995'
*/
begin

declare @EsConsultoraShowRoom int = 0

if exists (select 1 from ShowRoom.EventoConsultora where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora)
begin

select top 1
EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,MostrarPopup,
MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,
Suscripcion,Envio,CorreoEnvioAviso
from ShowRoom.EventoConsultora
where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
order by FechaCreacion desc

end
else
begin

declare @ConsultoraGenerica varchar(50) = ''
select @ConsultoraGenerica = Codigo from TablaLogicaDatos where TablaLogicaDatosID = 10001

select top 1
EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,1 as MostrarPopup,
1 as MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,
Suscripcion,Envio,CorreoEnvioAviso
from ShowRoom.EventoConsultora
where CampaniaID = @CampaniaID and CodigoConsultora = @ConsultoraGenerica
order by FechaCreacion desc

end

end

go

USE BelcorpChile
go

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[TipoOferta]') AND (type = 'U') )
	DROP TABLE ShowRoom.TipoOferta
GO

create table ShowRoom.TipoOferta
(
TipoOfertaID int identity(1,1) primary key,
Codigo varchar(20),
Descripcion varchar(100),
Activo bit,
FechaCreacion datetime,
UsuarioCreacion varchar(50),
FechaModificacion datetime,
UsuarioModificacion varchar(50)
)

GO

insert into ShowRoom.TipoOferta(Codigo,Descripcion,Activo,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion)
values
('105','Oferta ShowRoom 1',1,getdate(),'ADMCONTENIDO',getdate(),'ADMCONTENIDO')

go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'PrecioValorizado') = 0
	EXEC sp_RENAME 'ShowRoom.OfertaShowRoom.PrecioOferta' , 'PrecioValorizado', 'COLUMN' 
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'PrecioOferta') = 0
	EXEC sp_RENAME 'ShowRoom.OfertaShowRoom.PrecioOferta2' , 'PrecioOferta', 'COLUMN' 
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'PrecioOferta2') = 1
	alter table ShowRoom.OfertaShowRoom drop column PrecioOferta2
go

alter procedure ShowRoom.GetProductosShowRoom
@CampaniaID int
as
/*
ShowRoom.GetProductosShowRoom 201706
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
	@ConfiguracionOfertaID as ConfiguracionOfertaID
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
ORDER BY OS.CUV desc

end

GO

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
	@PrecioOferta decimal(12,2)=0
)
AS
BEGIN
	INSERT INTO ShowRoom.OfertaShowRoom
	(
		CampaniaID, CUV, TipoOfertaSisID, ConfiguracionOfertaID, Descripcion, PrecioValorizado, Stock, StockInicial, ImagenProducto,
		Orden, UnidadesPermitidas, FlagHabilitarProducto, DescripcionLegal, UsuarioRegistro, FechaRegistro, ImagenMini, PrecioOferta
	)
	VALUES
	(
		@CampaniaID, @CUV, @TipoOfertaSisID, @ConfiguracionOfertaID, @Descripcion, @PrecioValorizado , 0, 0, @ImagenProducto, 
		@Orden, @UnidadesPermitidas, @FlagHabilitarProducto, @DescripcionLegal, @UsuarioRegistro, getdate(), @ImagenMini, @PrecioOferta
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
	@PrecioValorizado decimal(18,2),
	@ImagenMini varchar(150),
	@Incrementa int,
	@CantidadIncrementa int,
	@FlagAgotado int,
	@PrecioOferta decimal(18,2)=0
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
			PrecioOferta = @PrecioOferta
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
	[PrecioValorizado] [decimal](18, 2) NULL,
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
	PrecioValorizado = t.PrecioValorizado
FROM ShowRoom.OfertaShowRoom o
INNER JOIN ods.Campania c on 
	c.CampaniaID = o.CampaniaID
JOIN @StockPrecioOfertaShowRoom t ON 
	c.Codigo = t.CampaniaID
	AND o.CUV = t.CUV
	AND o.TipoOfertaSisID = t.TipoOfertaSisID

end

GO

alter procedure ShowRoom.GetShowRoomOfertasConsultora
@CampaniaID int,
@CodigoConsultora varchar(20)
as
/*
ShowRoom.GetShowRoomOfertasConsultora 201706,'0012954'
ShowRoom.GetShowRoomOfertasConsultora 201706,'1615995'
*/
begin

declare @EsConsultoraGenerica bit = 0
declare @ConsultoraGenerica varchar(50) = ''
select @ConsultoraGenerica = Codigo from TablaLogicaDatos where TablaLogicaDatosID = 10001

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

if exists (select 1 from ShowRoom.EventoConsultora where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora)
begin

insert into @tablaEventoConsultora
select top 1
EventoConsultoraID, EventoID, CampaniaID, CodigoConsultora, Segmento, MostrarPopup, MostrarPopupVenta,
FechaCreacion, UsuarioCreacion, FechaModificacion, UsuarioModificacion
from ShowRoom.EventoConsultora
where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
order by EventoConsultoraID desc

end
else
begin

set @EsConsultoraGenerica = 1

insert into @tablaEventoConsultora
select top 1
EventoConsultoraID, EventoID, CampaniaID, CodigoConsultora, Segmento, MostrarPopup, MostrarPopupVenta,
FechaCreacion, UsuarioCreacion, FechaModificacion, UsuarioModificacion
from ShowRoom.EventoConsultora
where CampaniaID = @CampaniaID and CodigoConsultora = @ConsultoraGenerica
order by EventoConsultoraID desc

end

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

if @EsConsultoraGenerica = 1
	set @CodigoConsultora = @ConsultoraGenerica

select
o.OfertaShowRoomID,o.CampaniaID,o.CUV,o.TipoOfertaSisID,o.ConfiguracionOfertaID,o.Descripcion,
o.PrecioValorizado,
COALESCE(o.PrecioOferta,pc.PrecioCatalogo) AS PrecioOferta,
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

go

ALTER procedure ShowRoom.GetShowRoomCompraPorCompra
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

ALTER PROCEDURE ShowRoom.GetShowRoomOfertaById
 @OfertaShowRoomID int
AS
/*
ShowRoom.GetShowRoomOfertaById 113
*/
BEGIN
 
 SET NOCOUNT ON;
  
	select 
		OfertaShowRoomID,CampaniaID,CUV,TipoOfertaSisID,ConfiguracionOfertaID,Descripcion,PrecioValorizado,Stock,
		StockInicial,ImagenProducto,UnidadesPermitidas,FlagHabilitarProducto,DescripcionLegal,UsuarioRegistro,FechaRegistro,
		UsuarioModificacion,FechaModificacion,ImagenMini,Orden,CodigoCategoria,TipNegocio,PrecioOferta
	from showroom.ofertashowroom
	where OfertaShowRoomID = @OfertaShowRoomID
 
END

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomOfertas]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomOfertas
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomTipoOferta
GO

create procedure ShowRoom.GetShowRoomTipoOferta
as
/*
ShowRoom.GetShowRoomTipoOferta
*/
begin

select 
TipoOfertaID,Codigo,Descripcion,Activo,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion
from ShowRoom.TipoOferta
order by Codigo

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[ExisteShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].ExisteShowRoomTipoOferta
GO

create procedure ShowRoom.ExisteShowRoomTipoOferta
@TipoOfertaID int,
@Codigo varchar(20),
@Descripcion varchar(100)
as
/*
ShowRoom.ExisteShowRoomTipoOferta 0,'106','Oferta ShowRoom 2'
*/
begin

declare @resultado int = 0
/*
Valores posibles:
0: Ok
1: Codigo Tipo de Oferta Existe
2: Descripcion de Tipo de Oferta Existe
*/

if @TipoOfertaID = 0
begin
	if exists (select 1 from ShowRoom.TipoOferta where Codigo = @Codigo)
	begin
		set @resultado = 1
	end
	else
	begin
		if exists (select 1 from ShowRoom.TipoOferta where Descripcion = @Descripcion)
		begin
			set @resultado = 2
		end
	end
end
else
begin
	declare @id int = 0

	if exists (select 1 from ShowRoom.TipoOferta where Codigo = @Codigo)
	begin		
		select @id = TipoOfertaID from ShowRoom.TipoOferta where Codigo = @Codigo

		if (@TipoOfertaID != @id and @id != 0)
			set @resultado = 1		
		else
		begin			
			select @id = TipoOfertaID from ShowRoom.TipoOferta where Descripcion = @Descripcion

			if (@TipoOfertaID != @id and @id != 0)
				set @resultado = 2
		end
	end
	else
	begin
		select @id = TipoOfertaID from ShowRoom.TipoOferta where Descripcion = @Descripcion

		if (@TipoOfertaID != @id and @id != 0)
			set @resultado = 2
	end
end

select @resultado

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[InsertShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].InsertShowRoomTipoOferta
GO

create procedure ShowRoom.InsertShowRoomTipoOferta
@Codigo varchar(20),
@Descripcion varchar(100),
@UsuarioCreacion varchar(50)
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

insert into ShowRoom.TipoOferta (Codigo,Descripcion,Activo,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion)
values (@Codigo,@Descripcion,1,@FechaGeneral,@UsuarioCreacion,@FechaGeneral,@UsuarioCreacion)

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[UpdateShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].UpdateShowRoomTipoOferta
GO

create procedure ShowRoom.UpdateShowRoomTipoOferta
@TipoOfertaID int,
@Codigo varchar(20),
@Descripcion varchar(100),
@UsuarioModificacion varchar(50)
as
/*
ShowRoom.UpdateShowRoomTipoOferta 1,'105','Oferta ShowRoom 1', 'ADMCONTENIDO'
*/
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

update ShowRoom.TipoOferta
set
	Codigo = @Codigo,
	Descripcion = @Descripcion,
	UsuarioModificacion = @UsuarioModificacion,
	FechaModificacion = @FechaGeneral
where
	TipoOfertaID = @TipoOfertaID

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[HabilitarShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].HabilitarShowRoomTipoOferta
GO

create procedure ShowRoom.HabilitarShowRoomTipoOferta
@TipoOfertaID int,
@Activo bit
as
/*
ShowRoom.HabilitarShowRoomTipoOferta 1,1
*/
begin

update ShowRoom.TipoOferta
set
	Activo = @Activo
where
	TipoOfertaID = @TipoOfertaID

end

go

alter procedure ShowRoom.GetShowRoomConsultora
@CampaniaID int,
@CodigoConsultora varchar(20)
as
/*
ShowRoom.GetShowRoomConsultora 201706,'0012954'
ShowRoom.GetShowRoomConsultora 201706,'1615995'
*/
begin

declare @EsConsultoraShowRoom int = 0

if exists (select 1 from ShowRoom.EventoConsultora where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora)
begin

select top 1
EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,MostrarPopup,
MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,
Suscripcion,Envio,CorreoEnvioAviso
from ShowRoom.EventoConsultora
where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
order by FechaCreacion desc

end
else
begin

declare @ConsultoraGenerica varchar(50) = ''
select @ConsultoraGenerica = Codigo from TablaLogicaDatos where TablaLogicaDatosID = 10001

select top 1
EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,1 as MostrarPopup,
1 as MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,
Suscripcion,Envio,CorreoEnvioAviso
from ShowRoom.EventoConsultora
where CampaniaID = @CampaniaID and CodigoConsultora = @ConsultoraGenerica
order by FechaCreacion desc

end

end

go

USE BelcorpColombia
go

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[TipoOferta]') AND (type = 'U') )
	DROP TABLE ShowRoom.TipoOferta
GO

create table ShowRoom.TipoOferta
(
TipoOfertaID int identity(1,1) primary key,
Codigo varchar(20),
Descripcion varchar(100),
Activo bit,
FechaCreacion datetime,
UsuarioCreacion varchar(50),
FechaModificacion datetime,
UsuarioModificacion varchar(50)
)

GO

insert into ShowRoom.TipoOferta(Codigo,Descripcion,Activo,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion)
values
('105','Oferta ShowRoom 1',1,getdate(),'ADMCONTENIDO',getdate(),'ADMCONTENIDO')

go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'PrecioValorizado') = 0
	EXEC sp_RENAME 'ShowRoom.OfertaShowRoom.PrecioOferta' , 'PrecioValorizado', 'COLUMN' 
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'PrecioOferta') = 0
	EXEC sp_RENAME 'ShowRoom.OfertaShowRoom.PrecioOferta2' , 'PrecioOferta', 'COLUMN' 
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'PrecioOferta2') = 1
	alter table ShowRoom.OfertaShowRoom drop column PrecioOferta2
go

alter procedure ShowRoom.GetProductosShowRoom
@CampaniaID int
as
/*
ShowRoom.GetProductosShowRoom 201706
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
	@ConfiguracionOfertaID as ConfiguracionOfertaID
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
ORDER BY OS.CUV desc

end

GO

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
	@PrecioOferta decimal(12,2)=0
)
AS
BEGIN
	INSERT INTO ShowRoom.OfertaShowRoom
	(
		CampaniaID, CUV, TipoOfertaSisID, ConfiguracionOfertaID, Descripcion, PrecioValorizado, Stock, StockInicial, ImagenProducto,
		Orden, UnidadesPermitidas, FlagHabilitarProducto, DescripcionLegal, UsuarioRegistro, FechaRegistro, ImagenMini, PrecioOferta
	)
	VALUES
	(
		@CampaniaID, @CUV, @TipoOfertaSisID, @ConfiguracionOfertaID, @Descripcion, @PrecioValorizado , 0, 0, @ImagenProducto, 
		@Orden, @UnidadesPermitidas, @FlagHabilitarProducto, @DescripcionLegal, @UsuarioRegistro, getdate(), @ImagenMini, @PrecioOferta
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
	@PrecioValorizado decimal(18,2),
	@ImagenMini varchar(150),
	@Incrementa int,
	@CantidadIncrementa int,
	@FlagAgotado int,
	@PrecioOferta decimal(18,2)=0
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
			PrecioOferta = @PrecioOferta
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
	[PrecioValorizado] [decimal](18, 2) NULL,
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
	PrecioValorizado = t.PrecioValorizado
FROM ShowRoom.OfertaShowRoom o
INNER JOIN ods.Campania c on 
	c.CampaniaID = o.CampaniaID
JOIN @StockPrecioOfertaShowRoom t ON 
	c.Codigo = t.CampaniaID
	AND o.CUV = t.CUV
	AND o.TipoOfertaSisID = t.TipoOfertaSisID

end

GO

alter procedure ShowRoom.GetShowRoomOfertasConsultora
@CampaniaID int,
@CodigoConsultora varchar(20)
as
/*
ShowRoom.GetShowRoomOfertasConsultora 201706,'0012954'
ShowRoom.GetShowRoomOfertasConsultora 201706,'1615995'
*/
begin

declare @EsConsultoraGenerica bit = 0
declare @ConsultoraGenerica varchar(50) = ''
select @ConsultoraGenerica = Codigo from TablaLogicaDatos where TablaLogicaDatosID = 10001

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

if exists (select 1 from ShowRoom.EventoConsultora where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora)
begin

insert into @tablaEventoConsultora
select top 1
EventoConsultoraID, EventoID, CampaniaID, CodigoConsultora, Segmento, MostrarPopup, MostrarPopupVenta,
FechaCreacion, UsuarioCreacion, FechaModificacion, UsuarioModificacion
from ShowRoom.EventoConsultora
where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
order by EventoConsultoraID desc

end
else
begin

set @EsConsultoraGenerica = 1

insert into @tablaEventoConsultora
select top 1
EventoConsultoraID, EventoID, CampaniaID, CodigoConsultora, Segmento, MostrarPopup, MostrarPopupVenta,
FechaCreacion, UsuarioCreacion, FechaModificacion, UsuarioModificacion
from ShowRoom.EventoConsultora
where CampaniaID = @CampaniaID and CodigoConsultora = @ConsultoraGenerica
order by EventoConsultoraID desc

end

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

if @EsConsultoraGenerica = 1
	set @CodigoConsultora = @ConsultoraGenerica

select
o.OfertaShowRoomID,o.CampaniaID,o.CUV,o.TipoOfertaSisID,o.ConfiguracionOfertaID,o.Descripcion,
o.PrecioValorizado,
COALESCE(o.PrecioOferta,pc.PrecioCatalogo) AS PrecioOferta,
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

go

ALTER procedure ShowRoom.GetShowRoomCompraPorCompra
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

ALTER PROCEDURE ShowRoom.GetShowRoomOfertaById
 @OfertaShowRoomID int
AS
/*
ShowRoom.GetShowRoomOfertaById 113
*/
BEGIN
 
 SET NOCOUNT ON;
  
	select 
		OfertaShowRoomID,CampaniaID,CUV,TipoOfertaSisID,ConfiguracionOfertaID,Descripcion,PrecioValorizado,Stock,
		StockInicial,ImagenProducto,UnidadesPermitidas,FlagHabilitarProducto,DescripcionLegal,UsuarioRegistro,FechaRegistro,
		UsuarioModificacion,FechaModificacion,ImagenMini,Orden,CodigoCategoria,TipNegocio,PrecioOferta
	from showroom.ofertashowroom
	where OfertaShowRoomID = @OfertaShowRoomID
 
END

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomOfertas]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomOfertas
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomTipoOferta
GO

create procedure ShowRoom.GetShowRoomTipoOferta
as
/*
ShowRoom.GetShowRoomTipoOferta
*/
begin

select 
TipoOfertaID,Codigo,Descripcion,Activo,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion
from ShowRoom.TipoOferta
order by Codigo

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[ExisteShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].ExisteShowRoomTipoOferta
GO

create procedure ShowRoom.ExisteShowRoomTipoOferta
@TipoOfertaID int,
@Codigo varchar(20),
@Descripcion varchar(100)
as
/*
ShowRoom.ExisteShowRoomTipoOferta 0,'106','Oferta ShowRoom 2'
*/
begin

declare @resultado int = 0
/*
Valores posibles:
0: Ok
1: Codigo Tipo de Oferta Existe
2: Descripcion de Tipo de Oferta Existe
*/

if @TipoOfertaID = 0
begin
	if exists (select 1 from ShowRoom.TipoOferta where Codigo = @Codigo)
	begin
		set @resultado = 1
	end
	else
	begin
		if exists (select 1 from ShowRoom.TipoOferta where Descripcion = @Descripcion)
		begin
			set @resultado = 2
		end
	end
end
else
begin
	declare @id int = 0

	if exists (select 1 from ShowRoom.TipoOferta where Codigo = @Codigo)
	begin		
		select @id = TipoOfertaID from ShowRoom.TipoOferta where Codigo = @Codigo

		if (@TipoOfertaID != @id and @id != 0)
			set @resultado = 1		
		else
		begin			
			select @id = TipoOfertaID from ShowRoom.TipoOferta where Descripcion = @Descripcion

			if (@TipoOfertaID != @id and @id != 0)
				set @resultado = 2
		end
	end
	else
	begin
		select @id = TipoOfertaID from ShowRoom.TipoOferta where Descripcion = @Descripcion

		if (@TipoOfertaID != @id and @id != 0)
			set @resultado = 2
	end
end

select @resultado

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[InsertShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].InsertShowRoomTipoOferta
GO

create procedure ShowRoom.InsertShowRoomTipoOferta
@Codigo varchar(20),
@Descripcion varchar(100),
@UsuarioCreacion varchar(50)
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

insert into ShowRoom.TipoOferta (Codigo,Descripcion,Activo,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion)
values (@Codigo,@Descripcion,1,@FechaGeneral,@UsuarioCreacion,@FechaGeneral,@UsuarioCreacion)

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[UpdateShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].UpdateShowRoomTipoOferta
GO

create procedure ShowRoom.UpdateShowRoomTipoOferta
@TipoOfertaID int,
@Codigo varchar(20),
@Descripcion varchar(100),
@UsuarioModificacion varchar(50)
as
/*
ShowRoom.UpdateShowRoomTipoOferta 1,'105','Oferta ShowRoom 1', 'ADMCONTENIDO'
*/
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

update ShowRoom.TipoOferta
set
	Codigo = @Codigo,
	Descripcion = @Descripcion,
	UsuarioModificacion = @UsuarioModificacion,
	FechaModificacion = @FechaGeneral
where
	TipoOfertaID = @TipoOfertaID

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[HabilitarShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].HabilitarShowRoomTipoOferta
GO

create procedure ShowRoom.HabilitarShowRoomTipoOferta
@TipoOfertaID int,
@Activo bit
as
/*
ShowRoom.HabilitarShowRoomTipoOferta 1,1
*/
begin

update ShowRoom.TipoOferta
set
	Activo = @Activo
where
	TipoOfertaID = @TipoOfertaID

end

go

alter procedure ShowRoom.GetShowRoomConsultora
@CampaniaID int,
@CodigoConsultora varchar(20)
as
/*
ShowRoom.GetShowRoomConsultora 201706,'0012954'
ShowRoom.GetShowRoomConsultora 201706,'1615995'
*/
begin

declare @EsConsultoraShowRoom int = 0

if exists (select 1 from ShowRoom.EventoConsultora where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora)
begin

select top 1
EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,MostrarPopup,
MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,
Suscripcion,Envio,CorreoEnvioAviso
from ShowRoom.EventoConsultora
where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
order by FechaCreacion desc

end
else
begin

declare @ConsultoraGenerica varchar(50) = ''
select @ConsultoraGenerica = Codigo from TablaLogicaDatos where TablaLogicaDatosID = 10001

select top 1
EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,1 as MostrarPopup,
1 as MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,
Suscripcion,Envio,CorreoEnvioAviso
from ShowRoom.EventoConsultora
where CampaniaID = @CampaniaID and CodigoConsultora = @ConsultoraGenerica
order by FechaCreacion desc

end

end

go

USE BelcorpCostaRica
go

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[TipoOferta]') AND (type = 'U') )
	DROP TABLE ShowRoom.TipoOferta
GO

create table ShowRoom.TipoOferta
(
TipoOfertaID int identity(1,1) primary key,
Codigo varchar(20),
Descripcion varchar(100),
Activo bit,
FechaCreacion datetime,
UsuarioCreacion varchar(50),
FechaModificacion datetime,
UsuarioModificacion varchar(50)
)

GO

insert into ShowRoom.TipoOferta(Codigo,Descripcion,Activo,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion)
values
('105','Oferta ShowRoom 1',1,getdate(),'ADMCONTENIDO',getdate(),'ADMCONTENIDO')

go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'PrecioValorizado') = 0
	EXEC sp_RENAME 'ShowRoom.OfertaShowRoom.PrecioOferta' , 'PrecioValorizado', 'COLUMN' 
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'PrecioOferta') = 0
	EXEC sp_RENAME 'ShowRoom.OfertaShowRoom.PrecioOferta2' , 'PrecioOferta', 'COLUMN' 
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'PrecioOferta2') = 1
	alter table ShowRoom.OfertaShowRoom drop column PrecioOferta2
go

alter procedure ShowRoom.GetProductosShowRoom
@CampaniaID int
as
/*
ShowRoom.GetProductosShowRoom 201706
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
	@ConfiguracionOfertaID as ConfiguracionOfertaID
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
ORDER BY OS.CUV desc

end

GO

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
	@PrecioOferta decimal(12,2)=0
)
AS
BEGIN
	INSERT INTO ShowRoom.OfertaShowRoom
	(
		CampaniaID, CUV, TipoOfertaSisID, ConfiguracionOfertaID, Descripcion, PrecioValorizado, Stock, StockInicial, ImagenProducto,
		Orden, UnidadesPermitidas, FlagHabilitarProducto, DescripcionLegal, UsuarioRegistro, FechaRegistro, ImagenMini, PrecioOferta
	)
	VALUES
	(
		@CampaniaID, @CUV, @TipoOfertaSisID, @ConfiguracionOfertaID, @Descripcion, @PrecioValorizado , 0, 0, @ImagenProducto, 
		@Orden, @UnidadesPermitidas, @FlagHabilitarProducto, @DescripcionLegal, @UsuarioRegistro, getdate(), @ImagenMini, @PrecioOferta
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
	@PrecioValorizado decimal(18,2),
	@ImagenMini varchar(150),
	@Incrementa int,
	@CantidadIncrementa int,
	@FlagAgotado int,
	@PrecioOferta decimal(18,2)=0
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
			PrecioOferta = @PrecioOferta
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
	[PrecioValorizado] [decimal](18, 2) NULL,
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
	PrecioValorizado = t.PrecioValorizado
FROM ShowRoom.OfertaShowRoom o
INNER JOIN ods.Campania c on 
	c.CampaniaID = o.CampaniaID
JOIN @StockPrecioOfertaShowRoom t ON 
	c.Codigo = t.CampaniaID
	AND o.CUV = t.CUV
	AND o.TipoOfertaSisID = t.TipoOfertaSisID

end

GO

alter procedure ShowRoom.GetShowRoomOfertasConsultora
@CampaniaID int,
@CodigoConsultora varchar(20)
as
/*
ShowRoom.GetShowRoomOfertasConsultora 201706,'0012954'
ShowRoom.GetShowRoomOfertasConsultora 201706,'1615995'
*/
begin

declare @EsConsultoraGenerica bit = 0
declare @ConsultoraGenerica varchar(50) = ''
select @ConsultoraGenerica = Codigo from TablaLogicaDatos where TablaLogicaDatosID = 10001

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

if exists (select 1 from ShowRoom.EventoConsultora where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora)
begin

insert into @tablaEventoConsultora
select top 1
EventoConsultoraID, EventoID, CampaniaID, CodigoConsultora, Segmento, MostrarPopup, MostrarPopupVenta,
FechaCreacion, UsuarioCreacion, FechaModificacion, UsuarioModificacion
from ShowRoom.EventoConsultora
where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
order by EventoConsultoraID desc

end
else
begin

set @EsConsultoraGenerica = 1

insert into @tablaEventoConsultora
select top 1
EventoConsultoraID, EventoID, CampaniaID, CodigoConsultora, Segmento, MostrarPopup, MostrarPopupVenta,
FechaCreacion, UsuarioCreacion, FechaModificacion, UsuarioModificacion
from ShowRoom.EventoConsultora
where CampaniaID = @CampaniaID and CodigoConsultora = @ConsultoraGenerica
order by EventoConsultoraID desc

end

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

if @EsConsultoraGenerica = 1
	set @CodigoConsultora = @ConsultoraGenerica

select
o.OfertaShowRoomID,o.CampaniaID,o.CUV,o.TipoOfertaSisID,o.ConfiguracionOfertaID,o.Descripcion,
o.PrecioValorizado,
COALESCE(o.PrecioOferta,pc.PrecioCatalogo) AS PrecioOferta,
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

go

ALTER procedure ShowRoom.GetShowRoomCompraPorCompra
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

ALTER PROCEDURE ShowRoom.GetShowRoomOfertaById
 @OfertaShowRoomID int
AS
/*
ShowRoom.GetShowRoomOfertaById 113
*/
BEGIN
 
 SET NOCOUNT ON;
  
	select 
		OfertaShowRoomID,CampaniaID,CUV,TipoOfertaSisID,ConfiguracionOfertaID,Descripcion,PrecioValorizado,Stock,
		StockInicial,ImagenProducto,UnidadesPermitidas,FlagHabilitarProducto,DescripcionLegal,UsuarioRegistro,FechaRegistro,
		UsuarioModificacion,FechaModificacion,ImagenMini,Orden,CodigoCategoria,TipNegocio,PrecioOferta
	from showroom.ofertashowroom
	where OfertaShowRoomID = @OfertaShowRoomID
 
END

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomOfertas]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomOfertas
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomTipoOferta
GO

create procedure ShowRoom.GetShowRoomTipoOferta
as
/*
ShowRoom.GetShowRoomTipoOferta
*/
begin

select 
TipoOfertaID,Codigo,Descripcion,Activo,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion
from ShowRoom.TipoOferta
order by Codigo

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[ExisteShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].ExisteShowRoomTipoOferta
GO

create procedure ShowRoom.ExisteShowRoomTipoOferta
@TipoOfertaID int,
@Codigo varchar(20),
@Descripcion varchar(100)
as
/*
ShowRoom.ExisteShowRoomTipoOferta 0,'106','Oferta ShowRoom 2'
*/
begin

declare @resultado int = 0
/*
Valores posibles:
0: Ok
1: Codigo Tipo de Oferta Existe
2: Descripcion de Tipo de Oferta Existe
*/

if @TipoOfertaID = 0
begin
	if exists (select 1 from ShowRoom.TipoOferta where Codigo = @Codigo)
	begin
		set @resultado = 1
	end
	else
	begin
		if exists (select 1 from ShowRoom.TipoOferta where Descripcion = @Descripcion)
		begin
			set @resultado = 2
		end
	end
end
else
begin
	declare @id int = 0

	if exists (select 1 from ShowRoom.TipoOferta where Codigo = @Codigo)
	begin		
		select @id = TipoOfertaID from ShowRoom.TipoOferta where Codigo = @Codigo

		if (@TipoOfertaID != @id and @id != 0)
			set @resultado = 1		
		else
		begin			
			select @id = TipoOfertaID from ShowRoom.TipoOferta where Descripcion = @Descripcion

			if (@TipoOfertaID != @id and @id != 0)
				set @resultado = 2
		end
	end
	else
	begin
		select @id = TipoOfertaID from ShowRoom.TipoOferta where Descripcion = @Descripcion

		if (@TipoOfertaID != @id and @id != 0)
			set @resultado = 2
	end
end

select @resultado

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[InsertShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].InsertShowRoomTipoOferta
GO

create procedure ShowRoom.InsertShowRoomTipoOferta
@Codigo varchar(20),
@Descripcion varchar(100),
@UsuarioCreacion varchar(50)
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

insert into ShowRoom.TipoOferta (Codigo,Descripcion,Activo,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion)
values (@Codigo,@Descripcion,1,@FechaGeneral,@UsuarioCreacion,@FechaGeneral,@UsuarioCreacion)

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[UpdateShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].UpdateShowRoomTipoOferta
GO

create procedure ShowRoom.UpdateShowRoomTipoOferta
@TipoOfertaID int,
@Codigo varchar(20),
@Descripcion varchar(100),
@UsuarioModificacion varchar(50)
as
/*
ShowRoom.UpdateShowRoomTipoOferta 1,'105','Oferta ShowRoom 1', 'ADMCONTENIDO'
*/
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

update ShowRoom.TipoOferta
set
	Codigo = @Codigo,
	Descripcion = @Descripcion,
	UsuarioModificacion = @UsuarioModificacion,
	FechaModificacion = @FechaGeneral
where
	TipoOfertaID = @TipoOfertaID

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[HabilitarShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].HabilitarShowRoomTipoOferta
GO

create procedure ShowRoom.HabilitarShowRoomTipoOferta
@TipoOfertaID int,
@Activo bit
as
/*
ShowRoom.HabilitarShowRoomTipoOferta 1,1
*/
begin

update ShowRoom.TipoOferta
set
	Activo = @Activo
where
	TipoOfertaID = @TipoOfertaID

end

go

alter procedure ShowRoom.GetShowRoomConsultora
@CampaniaID int,
@CodigoConsultora varchar(20)
as
/*
ShowRoom.GetShowRoomConsultora 201706,'0012954'
ShowRoom.GetShowRoomConsultora 201706,'1615995'
*/
begin

declare @EsConsultoraShowRoom int = 0

if exists (select 1 from ShowRoom.EventoConsultora where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora)
begin

select top 1
EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,MostrarPopup,
MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,
Suscripcion,Envio,CorreoEnvioAviso
from ShowRoom.EventoConsultora
where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
order by FechaCreacion desc

end
else
begin

declare @ConsultoraGenerica varchar(50) = ''
select @ConsultoraGenerica = Codigo from TablaLogicaDatos where TablaLogicaDatosID = 10001

select top 1
EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,1 as MostrarPopup,
1 as MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,
Suscripcion,Envio,CorreoEnvioAviso
from ShowRoom.EventoConsultora
where CampaniaID = @CampaniaID and CodigoConsultora = @ConsultoraGenerica
order by FechaCreacion desc

end

end

go

USE BelcorpDominicana
go

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[TipoOferta]') AND (type = 'U') )
	DROP TABLE ShowRoom.TipoOferta
GO

create table ShowRoom.TipoOferta
(
TipoOfertaID int identity(1,1) primary key,
Codigo varchar(20),
Descripcion varchar(100),
Activo bit,
FechaCreacion datetime,
UsuarioCreacion varchar(50),
FechaModificacion datetime,
UsuarioModificacion varchar(50)
)

GO

insert into ShowRoom.TipoOferta(Codigo,Descripcion,Activo,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion)
values
('105','Oferta ShowRoom 1',1,getdate(),'ADMCONTENIDO',getdate(),'ADMCONTENIDO')

go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'PrecioValorizado') = 0
	EXEC sp_RENAME 'ShowRoom.OfertaShowRoom.PrecioOferta' , 'PrecioValorizado', 'COLUMN' 
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'PrecioOferta') = 0
	EXEC sp_RENAME 'ShowRoom.OfertaShowRoom.PrecioOferta2' , 'PrecioOferta', 'COLUMN' 
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'PrecioOferta2') = 1
	alter table ShowRoom.OfertaShowRoom drop column PrecioOferta2
go

alter procedure ShowRoom.GetProductosShowRoom
@CampaniaID int
as
/*
ShowRoom.GetProductosShowRoom 201706
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
	@ConfiguracionOfertaID as ConfiguracionOfertaID
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
ORDER BY OS.CUV desc

end

GO

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
	@PrecioOferta decimal(12,2)=0
)
AS
BEGIN
	INSERT INTO ShowRoom.OfertaShowRoom
	(
		CampaniaID, CUV, TipoOfertaSisID, ConfiguracionOfertaID, Descripcion, PrecioValorizado, Stock, StockInicial, ImagenProducto,
		Orden, UnidadesPermitidas, FlagHabilitarProducto, DescripcionLegal, UsuarioRegistro, FechaRegistro, ImagenMini, PrecioOferta
	)
	VALUES
	(
		@CampaniaID, @CUV, @TipoOfertaSisID, @ConfiguracionOfertaID, @Descripcion, @PrecioValorizado , 0, 0, @ImagenProducto, 
		@Orden, @UnidadesPermitidas, @FlagHabilitarProducto, @DescripcionLegal, @UsuarioRegistro, getdate(), @ImagenMini, @PrecioOferta
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
	@PrecioValorizado decimal(18,2),
	@ImagenMini varchar(150),
	@Incrementa int,
	@CantidadIncrementa int,
	@FlagAgotado int,
	@PrecioOferta decimal(18,2)=0
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
			PrecioOferta = @PrecioOferta
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
	[PrecioValorizado] [decimal](18, 2) NULL,
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
	PrecioValorizado = t.PrecioValorizado
FROM ShowRoom.OfertaShowRoom o
INNER JOIN ods.Campania c on 
	c.CampaniaID = o.CampaniaID
JOIN @StockPrecioOfertaShowRoom t ON 
	c.Codigo = t.CampaniaID
	AND o.CUV = t.CUV
	AND o.TipoOfertaSisID = t.TipoOfertaSisID

end

GO

alter procedure ShowRoom.GetShowRoomOfertasConsultora
@CampaniaID int,
@CodigoConsultora varchar(20)
as
/*
ShowRoom.GetShowRoomOfertasConsultora 201706,'0012954'
ShowRoom.GetShowRoomOfertasConsultora 201706,'1615995'
*/
begin

declare @EsConsultoraGenerica bit = 0
declare @ConsultoraGenerica varchar(50) = ''
select @ConsultoraGenerica = Codigo from TablaLogicaDatos where TablaLogicaDatosID = 10001

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

if exists (select 1 from ShowRoom.EventoConsultora where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora)
begin

insert into @tablaEventoConsultora
select top 1
EventoConsultoraID, EventoID, CampaniaID, CodigoConsultora, Segmento, MostrarPopup, MostrarPopupVenta,
FechaCreacion, UsuarioCreacion, FechaModificacion, UsuarioModificacion
from ShowRoom.EventoConsultora
where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
order by EventoConsultoraID desc

end
else
begin

set @EsConsultoraGenerica = 1

insert into @tablaEventoConsultora
select top 1
EventoConsultoraID, EventoID, CampaniaID, CodigoConsultora, Segmento, MostrarPopup, MostrarPopupVenta,
FechaCreacion, UsuarioCreacion, FechaModificacion, UsuarioModificacion
from ShowRoom.EventoConsultora
where CampaniaID = @CampaniaID and CodigoConsultora = @ConsultoraGenerica
order by EventoConsultoraID desc

end

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

if @EsConsultoraGenerica = 1
	set @CodigoConsultora = @ConsultoraGenerica

select
o.OfertaShowRoomID,o.CampaniaID,o.CUV,o.TipoOfertaSisID,o.ConfiguracionOfertaID,o.Descripcion,
o.PrecioValorizado,
COALESCE(o.PrecioOferta,pc.PrecioCatalogo) AS PrecioOferta,
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

go

ALTER procedure ShowRoom.GetShowRoomCompraPorCompra
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

ALTER PROCEDURE ShowRoom.GetShowRoomOfertaById
 @OfertaShowRoomID int
AS
/*
ShowRoom.GetShowRoomOfertaById 113
*/
BEGIN
 
 SET NOCOUNT ON;
  
	select 
		OfertaShowRoomID,CampaniaID,CUV,TipoOfertaSisID,ConfiguracionOfertaID,Descripcion,PrecioValorizado,Stock,
		StockInicial,ImagenProducto,UnidadesPermitidas,FlagHabilitarProducto,DescripcionLegal,UsuarioRegistro,FechaRegistro,
		UsuarioModificacion,FechaModificacion,ImagenMini,Orden,CodigoCategoria,TipNegocio,PrecioOferta
	from showroom.ofertashowroom
	where OfertaShowRoomID = @OfertaShowRoomID
 
END

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomOfertas]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomOfertas
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomTipoOferta
GO

create procedure ShowRoom.GetShowRoomTipoOferta
as
/*
ShowRoom.GetShowRoomTipoOferta
*/
begin

select 
TipoOfertaID,Codigo,Descripcion,Activo,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion
from ShowRoom.TipoOferta
order by Codigo

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[ExisteShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].ExisteShowRoomTipoOferta
GO

create procedure ShowRoom.ExisteShowRoomTipoOferta
@TipoOfertaID int,
@Codigo varchar(20),
@Descripcion varchar(100)
as
/*
ShowRoom.ExisteShowRoomTipoOferta 0,'106','Oferta ShowRoom 2'
*/
begin

declare @resultado int = 0
/*
Valores posibles:
0: Ok
1: Codigo Tipo de Oferta Existe
2: Descripcion de Tipo de Oferta Existe
*/

if @TipoOfertaID = 0
begin
	if exists (select 1 from ShowRoom.TipoOferta where Codigo = @Codigo)
	begin
		set @resultado = 1
	end
	else
	begin
		if exists (select 1 from ShowRoom.TipoOferta where Descripcion = @Descripcion)
		begin
			set @resultado = 2
		end
	end
end
else
begin
	declare @id int = 0

	if exists (select 1 from ShowRoom.TipoOferta where Codigo = @Codigo)
	begin		
		select @id = TipoOfertaID from ShowRoom.TipoOferta where Codigo = @Codigo

		if (@TipoOfertaID != @id and @id != 0)
			set @resultado = 1		
		else
		begin			
			select @id = TipoOfertaID from ShowRoom.TipoOferta where Descripcion = @Descripcion

			if (@TipoOfertaID != @id and @id != 0)
				set @resultado = 2
		end
	end
	else
	begin
		select @id = TipoOfertaID from ShowRoom.TipoOferta where Descripcion = @Descripcion

		if (@TipoOfertaID != @id and @id != 0)
			set @resultado = 2
	end
end

select @resultado

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[InsertShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].InsertShowRoomTipoOferta
GO

create procedure ShowRoom.InsertShowRoomTipoOferta
@Codigo varchar(20),
@Descripcion varchar(100),
@UsuarioCreacion varchar(50)
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

insert into ShowRoom.TipoOferta (Codigo,Descripcion,Activo,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion)
values (@Codigo,@Descripcion,1,@FechaGeneral,@UsuarioCreacion,@FechaGeneral,@UsuarioCreacion)

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[UpdateShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].UpdateShowRoomTipoOferta
GO

create procedure ShowRoom.UpdateShowRoomTipoOferta
@TipoOfertaID int,
@Codigo varchar(20),
@Descripcion varchar(100),
@UsuarioModificacion varchar(50)
as
/*
ShowRoom.UpdateShowRoomTipoOferta 1,'105','Oferta ShowRoom 1', 'ADMCONTENIDO'
*/
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

update ShowRoom.TipoOferta
set
	Codigo = @Codigo,
	Descripcion = @Descripcion,
	UsuarioModificacion = @UsuarioModificacion,
	FechaModificacion = @FechaGeneral
where
	TipoOfertaID = @TipoOfertaID

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[HabilitarShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].HabilitarShowRoomTipoOferta
GO

create procedure ShowRoom.HabilitarShowRoomTipoOferta
@TipoOfertaID int,
@Activo bit
as
/*
ShowRoom.HabilitarShowRoomTipoOferta 1,1
*/
begin

update ShowRoom.TipoOferta
set
	Activo = @Activo
where
	TipoOfertaID = @TipoOfertaID

end

go

alter procedure ShowRoom.GetShowRoomConsultora
@CampaniaID int,
@CodigoConsultora varchar(20)
as
/*
ShowRoom.GetShowRoomConsultora 201706,'0012954'
ShowRoom.GetShowRoomConsultora 201706,'1615995'
*/
begin

declare @EsConsultoraShowRoom int = 0

if exists (select 1 from ShowRoom.EventoConsultora where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora)
begin

select top 1
EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,MostrarPopup,
MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,
Suscripcion,Envio,CorreoEnvioAviso
from ShowRoom.EventoConsultora
where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
order by FechaCreacion desc

end
else
begin

declare @ConsultoraGenerica varchar(50) = ''
select @ConsultoraGenerica = Codigo from TablaLogicaDatos where TablaLogicaDatosID = 10001

select top 1
EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,1 as MostrarPopup,
1 as MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,
Suscripcion,Envio,CorreoEnvioAviso
from ShowRoom.EventoConsultora
where CampaniaID = @CampaniaID and CodigoConsultora = @ConsultoraGenerica
order by FechaCreacion desc

end

end

go

USE BelcorpEcuador
go

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[TipoOferta]') AND (type = 'U') )
	DROP TABLE ShowRoom.TipoOferta
GO

create table ShowRoom.TipoOferta
(
TipoOfertaID int identity(1,1) primary key,
Codigo varchar(20),
Descripcion varchar(100),
Activo bit,
FechaCreacion datetime,
UsuarioCreacion varchar(50),
FechaModificacion datetime,
UsuarioModificacion varchar(50)
)

GO

insert into ShowRoom.TipoOferta(Codigo,Descripcion,Activo,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion)
values
('105','Oferta ShowRoom 1',1,getdate(),'ADMCONTENIDO',getdate(),'ADMCONTENIDO')

go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'PrecioValorizado') = 0
	EXEC sp_RENAME 'ShowRoom.OfertaShowRoom.PrecioOferta' , 'PrecioValorizado', 'COLUMN' 
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'PrecioOferta') = 0
	EXEC sp_RENAME 'ShowRoom.OfertaShowRoom.PrecioOferta2' , 'PrecioOferta', 'COLUMN' 
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'PrecioOferta2') = 1
	alter table ShowRoom.OfertaShowRoom drop column PrecioOferta2
go

alter procedure ShowRoom.GetProductosShowRoom
@CampaniaID int
as
/*
ShowRoom.GetProductosShowRoom 201706
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
	@ConfiguracionOfertaID as ConfiguracionOfertaID
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
ORDER BY OS.CUV desc

end

GO

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
	@PrecioOferta decimal(12,2)=0
)
AS
BEGIN
	INSERT INTO ShowRoom.OfertaShowRoom
	(
		CampaniaID, CUV, TipoOfertaSisID, ConfiguracionOfertaID, Descripcion, PrecioValorizado, Stock, StockInicial, ImagenProducto,
		Orden, UnidadesPermitidas, FlagHabilitarProducto, DescripcionLegal, UsuarioRegistro, FechaRegistro, ImagenMini, PrecioOferta
	)
	VALUES
	(
		@CampaniaID, @CUV, @TipoOfertaSisID, @ConfiguracionOfertaID, @Descripcion, @PrecioValorizado , 0, 0, @ImagenProducto, 
		@Orden, @UnidadesPermitidas, @FlagHabilitarProducto, @DescripcionLegal, @UsuarioRegistro, getdate(), @ImagenMini, @PrecioOferta
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
	@PrecioValorizado decimal(18,2),
	@ImagenMini varchar(150),
	@Incrementa int,
	@CantidadIncrementa int,
	@FlagAgotado int,
	@PrecioOferta decimal(18,2)=0
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
			PrecioOferta = @PrecioOferta
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
	[PrecioValorizado] [decimal](18, 2) NULL,
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
	PrecioValorizado = t.PrecioValorizado
FROM ShowRoom.OfertaShowRoom o
INNER JOIN ods.Campania c on 
	c.CampaniaID = o.CampaniaID
JOIN @StockPrecioOfertaShowRoom t ON 
	c.Codigo = t.CampaniaID
	AND o.CUV = t.CUV
	AND o.TipoOfertaSisID = t.TipoOfertaSisID

end

GO

alter procedure ShowRoom.GetShowRoomOfertasConsultora
@CampaniaID int,
@CodigoConsultora varchar(20)
as
/*
ShowRoom.GetShowRoomOfertasConsultora 201706,'0012954'
ShowRoom.GetShowRoomOfertasConsultora 201706,'1615995'
*/
begin

declare @EsConsultoraGenerica bit = 0
declare @ConsultoraGenerica varchar(50) = ''
select @ConsultoraGenerica = Codigo from TablaLogicaDatos where TablaLogicaDatosID = 10001

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

if exists (select 1 from ShowRoom.EventoConsultora where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora)
begin

insert into @tablaEventoConsultora
select top 1
EventoConsultoraID, EventoID, CampaniaID, CodigoConsultora, Segmento, MostrarPopup, MostrarPopupVenta,
FechaCreacion, UsuarioCreacion, FechaModificacion, UsuarioModificacion
from ShowRoom.EventoConsultora
where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
order by EventoConsultoraID desc

end
else
begin

set @EsConsultoraGenerica = 1

insert into @tablaEventoConsultora
select top 1
EventoConsultoraID, EventoID, CampaniaID, CodigoConsultora, Segmento, MostrarPopup, MostrarPopupVenta,
FechaCreacion, UsuarioCreacion, FechaModificacion, UsuarioModificacion
from ShowRoom.EventoConsultora
where CampaniaID = @CampaniaID and CodigoConsultora = @ConsultoraGenerica
order by EventoConsultoraID desc

end

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

if @EsConsultoraGenerica = 1
	set @CodigoConsultora = @ConsultoraGenerica

select
o.OfertaShowRoomID,o.CampaniaID,o.CUV,o.TipoOfertaSisID,o.ConfiguracionOfertaID,o.Descripcion,
o.PrecioValorizado,
COALESCE(o.PrecioOferta,pc.PrecioCatalogo) AS PrecioOferta,
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

go

ALTER procedure ShowRoom.GetShowRoomCompraPorCompra
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

ALTER PROCEDURE ShowRoom.GetShowRoomOfertaById
 @OfertaShowRoomID int
AS
/*
ShowRoom.GetShowRoomOfertaById 113
*/
BEGIN
 
 SET NOCOUNT ON;
  
	select 
		OfertaShowRoomID,CampaniaID,CUV,TipoOfertaSisID,ConfiguracionOfertaID,Descripcion,PrecioValorizado,Stock,
		StockInicial,ImagenProducto,UnidadesPermitidas,FlagHabilitarProducto,DescripcionLegal,UsuarioRegistro,FechaRegistro,
		UsuarioModificacion,FechaModificacion,ImagenMini,Orden,CodigoCategoria,TipNegocio,PrecioOferta
	from showroom.ofertashowroom
	where OfertaShowRoomID = @OfertaShowRoomID
 
END

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomOfertas]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomOfertas
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomTipoOferta
GO

create procedure ShowRoom.GetShowRoomTipoOferta
as
/*
ShowRoom.GetShowRoomTipoOferta
*/
begin

select 
TipoOfertaID,Codigo,Descripcion,Activo,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion
from ShowRoom.TipoOferta
order by Codigo

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[ExisteShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].ExisteShowRoomTipoOferta
GO

create procedure ShowRoom.ExisteShowRoomTipoOferta
@TipoOfertaID int,
@Codigo varchar(20),
@Descripcion varchar(100)
as
/*
ShowRoom.ExisteShowRoomTipoOferta 0,'106','Oferta ShowRoom 2'
*/
begin

declare @resultado int = 0
/*
Valores posibles:
0: Ok
1: Codigo Tipo de Oferta Existe
2: Descripcion de Tipo de Oferta Existe
*/

if @TipoOfertaID = 0
begin
	if exists (select 1 from ShowRoom.TipoOferta where Codigo = @Codigo)
	begin
		set @resultado = 1
	end
	else
	begin
		if exists (select 1 from ShowRoom.TipoOferta where Descripcion = @Descripcion)
		begin
			set @resultado = 2
		end
	end
end
else
begin
	declare @id int = 0

	if exists (select 1 from ShowRoom.TipoOferta where Codigo = @Codigo)
	begin		
		select @id = TipoOfertaID from ShowRoom.TipoOferta where Codigo = @Codigo

		if (@TipoOfertaID != @id and @id != 0)
			set @resultado = 1		
		else
		begin			
			select @id = TipoOfertaID from ShowRoom.TipoOferta where Descripcion = @Descripcion

			if (@TipoOfertaID != @id and @id != 0)
				set @resultado = 2
		end
	end
	else
	begin
		select @id = TipoOfertaID from ShowRoom.TipoOferta where Descripcion = @Descripcion

		if (@TipoOfertaID != @id and @id != 0)
			set @resultado = 2
	end
end

select @resultado

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[InsertShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].InsertShowRoomTipoOferta
GO

create procedure ShowRoom.InsertShowRoomTipoOferta
@Codigo varchar(20),
@Descripcion varchar(100),
@UsuarioCreacion varchar(50)
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

insert into ShowRoom.TipoOferta (Codigo,Descripcion,Activo,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion)
values (@Codigo,@Descripcion,1,@FechaGeneral,@UsuarioCreacion,@FechaGeneral,@UsuarioCreacion)

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[UpdateShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].UpdateShowRoomTipoOferta
GO

create procedure ShowRoom.UpdateShowRoomTipoOferta
@TipoOfertaID int,
@Codigo varchar(20),
@Descripcion varchar(100),
@UsuarioModificacion varchar(50)
as
/*
ShowRoom.UpdateShowRoomTipoOferta 1,'105','Oferta ShowRoom 1', 'ADMCONTENIDO'
*/
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

update ShowRoom.TipoOferta
set
	Codigo = @Codigo,
	Descripcion = @Descripcion,
	UsuarioModificacion = @UsuarioModificacion,
	FechaModificacion = @FechaGeneral
where
	TipoOfertaID = @TipoOfertaID

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[HabilitarShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].HabilitarShowRoomTipoOferta
GO

create procedure ShowRoom.HabilitarShowRoomTipoOferta
@TipoOfertaID int,
@Activo bit
as
/*
ShowRoom.HabilitarShowRoomTipoOferta 1,1
*/
begin

update ShowRoom.TipoOferta
set
	Activo = @Activo
where
	TipoOfertaID = @TipoOfertaID

end

go

alter procedure ShowRoom.GetShowRoomConsultora
@CampaniaID int,
@CodigoConsultora varchar(20)
as
/*
ShowRoom.GetShowRoomConsultora 201706,'0012954'
ShowRoom.GetShowRoomConsultora 201706,'1615995'
*/
begin

declare @EsConsultoraShowRoom int = 0

if exists (select 1 from ShowRoom.EventoConsultora where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora)
begin

select top 1
EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,MostrarPopup,
MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,
Suscripcion,Envio,CorreoEnvioAviso
from ShowRoom.EventoConsultora
where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
order by FechaCreacion desc

end
else
begin

declare @ConsultoraGenerica varchar(50) = ''
select @ConsultoraGenerica = Codigo from TablaLogicaDatos where TablaLogicaDatosID = 10001

select top 1
EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,1 as MostrarPopup,
1 as MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,
Suscripcion,Envio,CorreoEnvioAviso
from ShowRoom.EventoConsultora
where CampaniaID = @CampaniaID and CodigoConsultora = @ConsultoraGenerica
order by FechaCreacion desc

end

end

go

USE BelcorpGuatemala
go

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[TipoOferta]') AND (type = 'U') )
	DROP TABLE ShowRoom.TipoOferta
GO

create table ShowRoom.TipoOferta
(
TipoOfertaID int identity(1,1) primary key,
Codigo varchar(20),
Descripcion varchar(100),
Activo bit,
FechaCreacion datetime,
UsuarioCreacion varchar(50),
FechaModificacion datetime,
UsuarioModificacion varchar(50)
)

GO

insert into ShowRoom.TipoOferta(Codigo,Descripcion,Activo,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion)
values
('105','Oferta ShowRoom 1',1,getdate(),'ADMCONTENIDO',getdate(),'ADMCONTENIDO')

go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'PrecioValorizado') = 0
	EXEC sp_RENAME 'ShowRoom.OfertaShowRoom.PrecioOferta' , 'PrecioValorizado', 'COLUMN' 
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'PrecioOferta') = 0
	EXEC sp_RENAME 'ShowRoom.OfertaShowRoom.PrecioOferta2' , 'PrecioOferta', 'COLUMN' 
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'PrecioOferta2') = 1
	alter table ShowRoom.OfertaShowRoom drop column PrecioOferta2
go

alter procedure ShowRoom.GetProductosShowRoom
@CampaniaID int
as
/*
ShowRoom.GetProductosShowRoom 201706
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
	@ConfiguracionOfertaID as ConfiguracionOfertaID
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
ORDER BY OS.CUV desc

end

GO

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
	@PrecioOferta decimal(12,2)=0
)
AS
BEGIN
	INSERT INTO ShowRoom.OfertaShowRoom
	(
		CampaniaID, CUV, TipoOfertaSisID, ConfiguracionOfertaID, Descripcion, PrecioValorizado, Stock, StockInicial, ImagenProducto,
		Orden, UnidadesPermitidas, FlagHabilitarProducto, DescripcionLegal, UsuarioRegistro, FechaRegistro, ImagenMini, PrecioOferta
	)
	VALUES
	(
		@CampaniaID, @CUV, @TipoOfertaSisID, @ConfiguracionOfertaID, @Descripcion, @PrecioValorizado , 0, 0, @ImagenProducto, 
		@Orden, @UnidadesPermitidas, @FlagHabilitarProducto, @DescripcionLegal, @UsuarioRegistro, getdate(), @ImagenMini, @PrecioOferta
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
	@PrecioValorizado decimal(18,2),
	@ImagenMini varchar(150),
	@Incrementa int,
	@CantidadIncrementa int,
	@FlagAgotado int,
	@PrecioOferta decimal(18,2)=0
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
			PrecioOferta = @PrecioOferta
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
	[PrecioValorizado] [decimal](18, 2) NULL,
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
	PrecioValorizado = t.PrecioValorizado
FROM ShowRoom.OfertaShowRoom o
INNER JOIN ods.Campania c on 
	c.CampaniaID = o.CampaniaID
JOIN @StockPrecioOfertaShowRoom t ON 
	c.Codigo = t.CampaniaID
	AND o.CUV = t.CUV
	AND o.TipoOfertaSisID = t.TipoOfertaSisID

end

GO

alter procedure ShowRoom.GetShowRoomOfertasConsultora
@CampaniaID int,
@CodigoConsultora varchar(20)
as
/*
ShowRoom.GetShowRoomOfertasConsultora 201706,'0012954'
ShowRoom.GetShowRoomOfertasConsultora 201706,'1615995'
*/
begin

declare @EsConsultoraGenerica bit = 0
declare @ConsultoraGenerica varchar(50) = ''
select @ConsultoraGenerica = Codigo from TablaLogicaDatos where TablaLogicaDatosID = 10001

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

if exists (select 1 from ShowRoom.EventoConsultora where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora)
begin

insert into @tablaEventoConsultora
select top 1
EventoConsultoraID, EventoID, CampaniaID, CodigoConsultora, Segmento, MostrarPopup, MostrarPopupVenta,
FechaCreacion, UsuarioCreacion, FechaModificacion, UsuarioModificacion
from ShowRoom.EventoConsultora
where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
order by EventoConsultoraID desc

end
else
begin

set @EsConsultoraGenerica = 1

insert into @tablaEventoConsultora
select top 1
EventoConsultoraID, EventoID, CampaniaID, CodigoConsultora, Segmento, MostrarPopup, MostrarPopupVenta,
FechaCreacion, UsuarioCreacion, FechaModificacion, UsuarioModificacion
from ShowRoom.EventoConsultora
where CampaniaID = @CampaniaID and CodigoConsultora = @ConsultoraGenerica
order by EventoConsultoraID desc

end

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

if @EsConsultoraGenerica = 1
	set @CodigoConsultora = @ConsultoraGenerica

select
o.OfertaShowRoomID,o.CampaniaID,o.CUV,o.TipoOfertaSisID,o.ConfiguracionOfertaID,o.Descripcion,
o.PrecioValorizado,
COALESCE(o.PrecioOferta,pc.PrecioCatalogo) AS PrecioOferta,
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

go

ALTER procedure ShowRoom.GetShowRoomCompraPorCompra
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

ALTER PROCEDURE ShowRoom.GetShowRoomOfertaById
 @OfertaShowRoomID int
AS
/*
ShowRoom.GetShowRoomOfertaById 113
*/
BEGIN
 
 SET NOCOUNT ON;
  
	select 
		OfertaShowRoomID,CampaniaID,CUV,TipoOfertaSisID,ConfiguracionOfertaID,Descripcion,PrecioValorizado,Stock,
		StockInicial,ImagenProducto,UnidadesPermitidas,FlagHabilitarProducto,DescripcionLegal,UsuarioRegistro,FechaRegistro,
		UsuarioModificacion,FechaModificacion,ImagenMini,Orden,CodigoCategoria,TipNegocio,PrecioOferta
	from showroom.ofertashowroom
	where OfertaShowRoomID = @OfertaShowRoomID
 
END

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomOfertas]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomOfertas
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomTipoOferta
GO

create procedure ShowRoom.GetShowRoomTipoOferta
as
/*
ShowRoom.GetShowRoomTipoOferta
*/
begin

select 
TipoOfertaID,Codigo,Descripcion,Activo,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion
from ShowRoom.TipoOferta
order by Codigo

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[ExisteShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].ExisteShowRoomTipoOferta
GO

create procedure ShowRoom.ExisteShowRoomTipoOferta
@TipoOfertaID int,
@Codigo varchar(20),
@Descripcion varchar(100)
as
/*
ShowRoom.ExisteShowRoomTipoOferta 0,'106','Oferta ShowRoom 2'
*/
begin

declare @resultado int = 0
/*
Valores posibles:
0: Ok
1: Codigo Tipo de Oferta Existe
2: Descripcion de Tipo de Oferta Existe
*/

if @TipoOfertaID = 0
begin
	if exists (select 1 from ShowRoom.TipoOferta where Codigo = @Codigo)
	begin
		set @resultado = 1
	end
	else
	begin
		if exists (select 1 from ShowRoom.TipoOferta where Descripcion = @Descripcion)
		begin
			set @resultado = 2
		end
	end
end
else
begin
	declare @id int = 0

	if exists (select 1 from ShowRoom.TipoOferta where Codigo = @Codigo)
	begin		
		select @id = TipoOfertaID from ShowRoom.TipoOferta where Codigo = @Codigo

		if (@TipoOfertaID != @id and @id != 0)
			set @resultado = 1		
		else
		begin			
			select @id = TipoOfertaID from ShowRoom.TipoOferta where Descripcion = @Descripcion

			if (@TipoOfertaID != @id and @id != 0)
				set @resultado = 2
		end
	end
	else
	begin
		select @id = TipoOfertaID from ShowRoom.TipoOferta where Descripcion = @Descripcion

		if (@TipoOfertaID != @id and @id != 0)
			set @resultado = 2
	end
end

select @resultado

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[InsertShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].InsertShowRoomTipoOferta
GO

create procedure ShowRoom.InsertShowRoomTipoOferta
@Codigo varchar(20),
@Descripcion varchar(100),
@UsuarioCreacion varchar(50)
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

insert into ShowRoom.TipoOferta (Codigo,Descripcion,Activo,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion)
values (@Codigo,@Descripcion,1,@FechaGeneral,@UsuarioCreacion,@FechaGeneral,@UsuarioCreacion)

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[UpdateShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].UpdateShowRoomTipoOferta
GO

create procedure ShowRoom.UpdateShowRoomTipoOferta
@TipoOfertaID int,
@Codigo varchar(20),
@Descripcion varchar(100),
@UsuarioModificacion varchar(50)
as
/*
ShowRoom.UpdateShowRoomTipoOferta 1,'105','Oferta ShowRoom 1', 'ADMCONTENIDO'
*/
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

update ShowRoom.TipoOferta
set
	Codigo = @Codigo,
	Descripcion = @Descripcion,
	UsuarioModificacion = @UsuarioModificacion,
	FechaModificacion = @FechaGeneral
where
	TipoOfertaID = @TipoOfertaID

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[HabilitarShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].HabilitarShowRoomTipoOferta
GO

create procedure ShowRoom.HabilitarShowRoomTipoOferta
@TipoOfertaID int,
@Activo bit
as
/*
ShowRoom.HabilitarShowRoomTipoOferta 1,1
*/
begin

update ShowRoom.TipoOferta
set
	Activo = @Activo
where
	TipoOfertaID = @TipoOfertaID

end

go

alter procedure ShowRoom.GetShowRoomConsultora
@CampaniaID int,
@CodigoConsultora varchar(20)
as
/*
ShowRoom.GetShowRoomConsultora 201706,'0012954'
ShowRoom.GetShowRoomConsultora 201706,'1615995'
*/
begin

declare @EsConsultoraShowRoom int = 0

if exists (select 1 from ShowRoom.EventoConsultora where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora)
begin

select top 1
EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,MostrarPopup,
MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,
Suscripcion,Envio,CorreoEnvioAviso
from ShowRoom.EventoConsultora
where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
order by FechaCreacion desc

end
else
begin

declare @ConsultoraGenerica varchar(50) = ''
select @ConsultoraGenerica = Codigo from TablaLogicaDatos where TablaLogicaDatosID = 10001

select top 1
EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,1 as MostrarPopup,
1 as MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,
Suscripcion,Envio,CorreoEnvioAviso
from ShowRoom.EventoConsultora
where CampaniaID = @CampaniaID and CodigoConsultora = @ConsultoraGenerica
order by FechaCreacion desc

end

end

go

USE BelcorpMexico
go

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[TipoOferta]') AND (type = 'U') )
	DROP TABLE ShowRoom.TipoOferta
GO

create table ShowRoom.TipoOferta
(
TipoOfertaID int identity(1,1) primary key,
Codigo varchar(20),
Descripcion varchar(100),
Activo bit,
FechaCreacion datetime,
UsuarioCreacion varchar(50),
FechaModificacion datetime,
UsuarioModificacion varchar(50)
)

GO

insert into ShowRoom.TipoOferta(Codigo,Descripcion,Activo,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion)
values
('105','Oferta ShowRoom 1',1,getdate(),'ADMCONTENIDO',getdate(),'ADMCONTENIDO')

go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'PrecioValorizado') = 0
	EXEC sp_RENAME 'ShowRoom.OfertaShowRoom.PrecioOferta' , 'PrecioValorizado', 'COLUMN' 
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'PrecioOferta') = 0
	EXEC sp_RENAME 'ShowRoom.OfertaShowRoom.PrecioOferta2' , 'PrecioOferta', 'COLUMN' 
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'PrecioOferta2') = 1
	alter table ShowRoom.OfertaShowRoom drop column PrecioOferta2
go

alter procedure ShowRoom.GetProductosShowRoom
@CampaniaID int
as
/*
ShowRoom.GetProductosShowRoom 201706
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
	@ConfiguracionOfertaID as ConfiguracionOfertaID
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
ORDER BY OS.CUV desc

end

GO

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
	@PrecioOferta decimal(12,2)=0
)
AS
BEGIN
	INSERT INTO ShowRoom.OfertaShowRoom
	(
		CampaniaID, CUV, TipoOfertaSisID, ConfiguracionOfertaID, Descripcion, PrecioValorizado, Stock, StockInicial, ImagenProducto,
		Orden, UnidadesPermitidas, FlagHabilitarProducto, DescripcionLegal, UsuarioRegistro, FechaRegistro, ImagenMini, PrecioOferta
	)
	VALUES
	(
		@CampaniaID, @CUV, @TipoOfertaSisID, @ConfiguracionOfertaID, @Descripcion, @PrecioValorizado , 0, 0, @ImagenProducto, 
		@Orden, @UnidadesPermitidas, @FlagHabilitarProducto, @DescripcionLegal, @UsuarioRegistro, getdate(), @ImagenMini, @PrecioOferta
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
	@PrecioValorizado decimal(18,2),
	@ImagenMini varchar(150),
	@Incrementa int,
	@CantidadIncrementa int,
	@FlagAgotado int,
	@PrecioOferta decimal(18,2)=0
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
			PrecioOferta = @PrecioOferta
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
	[PrecioValorizado] [decimal](18, 2) NULL,
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
	PrecioValorizado = t.PrecioValorizado
FROM ShowRoom.OfertaShowRoom o
INNER JOIN ods.Campania c on 
	c.CampaniaID = o.CampaniaID
JOIN @StockPrecioOfertaShowRoom t ON 
	c.Codigo = t.CampaniaID
	AND o.CUV = t.CUV
	AND o.TipoOfertaSisID = t.TipoOfertaSisID

end

GO

alter procedure ShowRoom.GetShowRoomOfertasConsultora
@CampaniaID int,
@CodigoConsultora varchar(20)
as
/*
ShowRoom.GetShowRoomOfertasConsultora 201706,'0012954'
ShowRoom.GetShowRoomOfertasConsultora 201706,'1615995'
*/
begin

declare @EsConsultoraGenerica bit = 0
declare @ConsultoraGenerica varchar(50) = ''
select @ConsultoraGenerica = Codigo from TablaLogicaDatos where TablaLogicaDatosID = 10001

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

if exists (select 1 from ShowRoom.EventoConsultora where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora)
begin

insert into @tablaEventoConsultora
select top 1
EventoConsultoraID, EventoID, CampaniaID, CodigoConsultora, Segmento, MostrarPopup, MostrarPopupVenta,
FechaCreacion, UsuarioCreacion, FechaModificacion, UsuarioModificacion
from ShowRoom.EventoConsultora
where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
order by EventoConsultoraID desc

end
else
begin

set @EsConsultoraGenerica = 1

insert into @tablaEventoConsultora
select top 1
EventoConsultoraID, EventoID, CampaniaID, CodigoConsultora, Segmento, MostrarPopup, MostrarPopupVenta,
FechaCreacion, UsuarioCreacion, FechaModificacion, UsuarioModificacion
from ShowRoom.EventoConsultora
where CampaniaID = @CampaniaID and CodigoConsultora = @ConsultoraGenerica
order by EventoConsultoraID desc

end

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

if @EsConsultoraGenerica = 1
	set @CodigoConsultora = @ConsultoraGenerica

select
o.OfertaShowRoomID,o.CampaniaID,o.CUV,o.TipoOfertaSisID,o.ConfiguracionOfertaID,o.Descripcion,
o.PrecioValorizado,
COALESCE(o.PrecioOferta,pc.PrecioCatalogo) AS PrecioOferta,
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

go

ALTER procedure ShowRoom.GetShowRoomCompraPorCompra
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

ALTER PROCEDURE ShowRoom.GetShowRoomOfertaById
 @OfertaShowRoomID int
AS
/*
ShowRoom.GetShowRoomOfertaById 113
*/
BEGIN
 
 SET NOCOUNT ON;
  
	select 
		OfertaShowRoomID,CampaniaID,CUV,TipoOfertaSisID,ConfiguracionOfertaID,Descripcion,PrecioValorizado,Stock,
		StockInicial,ImagenProducto,UnidadesPermitidas,FlagHabilitarProducto,DescripcionLegal,UsuarioRegistro,FechaRegistro,
		UsuarioModificacion,FechaModificacion,ImagenMini,Orden,CodigoCategoria,TipNegocio,PrecioOferta
	from showroom.ofertashowroom
	where OfertaShowRoomID = @OfertaShowRoomID
 
END

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomOfertas]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomOfertas
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomTipoOferta
GO

create procedure ShowRoom.GetShowRoomTipoOferta
as
/*
ShowRoom.GetShowRoomTipoOferta
*/
begin

select 
TipoOfertaID,Codigo,Descripcion,Activo,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion
from ShowRoom.TipoOferta
order by Codigo

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[ExisteShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].ExisteShowRoomTipoOferta
GO

create procedure ShowRoom.ExisteShowRoomTipoOferta
@TipoOfertaID int,
@Codigo varchar(20),
@Descripcion varchar(100)
as
/*
ShowRoom.ExisteShowRoomTipoOferta 0,'106','Oferta ShowRoom 2'
*/
begin

declare @resultado int = 0
/*
Valores posibles:
0: Ok
1: Codigo Tipo de Oferta Existe
2: Descripcion de Tipo de Oferta Existe
*/

if @TipoOfertaID = 0
begin
	if exists (select 1 from ShowRoom.TipoOferta where Codigo = @Codigo)
	begin
		set @resultado = 1
	end
	else
	begin
		if exists (select 1 from ShowRoom.TipoOferta where Descripcion = @Descripcion)
		begin
			set @resultado = 2
		end
	end
end
else
begin
	declare @id int = 0

	if exists (select 1 from ShowRoom.TipoOferta where Codigo = @Codigo)
	begin		
		select @id = TipoOfertaID from ShowRoom.TipoOferta where Codigo = @Codigo

		if (@TipoOfertaID != @id and @id != 0)
			set @resultado = 1		
		else
		begin			
			select @id = TipoOfertaID from ShowRoom.TipoOferta where Descripcion = @Descripcion

			if (@TipoOfertaID != @id and @id != 0)
				set @resultado = 2
		end
	end
	else
	begin
		select @id = TipoOfertaID from ShowRoom.TipoOferta where Descripcion = @Descripcion

		if (@TipoOfertaID != @id and @id != 0)
			set @resultado = 2
	end
end

select @resultado

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[InsertShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].InsertShowRoomTipoOferta
GO

create procedure ShowRoom.InsertShowRoomTipoOferta
@Codigo varchar(20),
@Descripcion varchar(100),
@UsuarioCreacion varchar(50)
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

insert into ShowRoom.TipoOferta (Codigo,Descripcion,Activo,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion)
values (@Codigo,@Descripcion,1,@FechaGeneral,@UsuarioCreacion,@FechaGeneral,@UsuarioCreacion)

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[UpdateShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].UpdateShowRoomTipoOferta
GO

create procedure ShowRoom.UpdateShowRoomTipoOferta
@TipoOfertaID int,
@Codigo varchar(20),
@Descripcion varchar(100),
@UsuarioModificacion varchar(50)
as
/*
ShowRoom.UpdateShowRoomTipoOferta 1,'105','Oferta ShowRoom 1', 'ADMCONTENIDO'
*/
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

update ShowRoom.TipoOferta
set
	Codigo = @Codigo,
	Descripcion = @Descripcion,
	UsuarioModificacion = @UsuarioModificacion,
	FechaModificacion = @FechaGeneral
where
	TipoOfertaID = @TipoOfertaID

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[HabilitarShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].HabilitarShowRoomTipoOferta
GO

create procedure ShowRoom.HabilitarShowRoomTipoOferta
@TipoOfertaID int,
@Activo bit
as
/*
ShowRoom.HabilitarShowRoomTipoOferta 1,1
*/
begin

update ShowRoom.TipoOferta
set
	Activo = @Activo
where
	TipoOfertaID = @TipoOfertaID

end

go

alter procedure ShowRoom.GetShowRoomConsultora
@CampaniaID int,
@CodigoConsultora varchar(20)
as
/*
ShowRoom.GetShowRoomConsultora 201706,'0012954'
ShowRoom.GetShowRoomConsultora 201706,'1615995'
*/
begin

declare @EsConsultoraShowRoom int = 0

if exists (select 1 from ShowRoom.EventoConsultora where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora)
begin

select top 1
EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,MostrarPopup,
MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,
Suscripcion,Envio,CorreoEnvioAviso
from ShowRoom.EventoConsultora
where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
order by FechaCreacion desc

end
else
begin

declare @ConsultoraGenerica varchar(50) = ''
select @ConsultoraGenerica = Codigo from TablaLogicaDatos where TablaLogicaDatosID = 10001

select top 1
EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,1 as MostrarPopup,
1 as MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,
Suscripcion,Envio,CorreoEnvioAviso
from ShowRoom.EventoConsultora
where CampaniaID = @CampaniaID and CodigoConsultora = @ConsultoraGenerica
order by FechaCreacion desc

end

end

go

USE BelcorpPanama
go

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[TipoOferta]') AND (type = 'U') )
	DROP TABLE ShowRoom.TipoOferta
GO

create table ShowRoom.TipoOferta
(
TipoOfertaID int identity(1,1) primary key,
Codigo varchar(20),
Descripcion varchar(100),
Activo bit,
FechaCreacion datetime,
UsuarioCreacion varchar(50),
FechaModificacion datetime,
UsuarioModificacion varchar(50)
)

GO

insert into ShowRoom.TipoOferta(Codigo,Descripcion,Activo,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion)
values
('105','Oferta ShowRoom 1',1,getdate(),'ADMCONTENIDO',getdate(),'ADMCONTENIDO')

go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'PrecioValorizado') = 0
	EXEC sp_RENAME 'ShowRoom.OfertaShowRoom.PrecioOferta' , 'PrecioValorizado', 'COLUMN' 
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'PrecioOferta') = 0
	EXEC sp_RENAME 'ShowRoom.OfertaShowRoom.PrecioOferta2' , 'PrecioOferta', 'COLUMN' 
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'PrecioOferta2') = 1
	alter table ShowRoom.OfertaShowRoom drop column PrecioOferta2
go

alter procedure ShowRoom.GetProductosShowRoom
@CampaniaID int
as
/*
ShowRoom.GetProductosShowRoom 201706
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
	@ConfiguracionOfertaID as ConfiguracionOfertaID
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
ORDER BY OS.CUV desc

end

GO

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
	@PrecioOferta decimal(12,2)=0
)
AS
BEGIN
	INSERT INTO ShowRoom.OfertaShowRoom
	(
		CampaniaID, CUV, TipoOfertaSisID, ConfiguracionOfertaID, Descripcion, PrecioValorizado, Stock, StockInicial, ImagenProducto,
		Orden, UnidadesPermitidas, FlagHabilitarProducto, DescripcionLegal, UsuarioRegistro, FechaRegistro, ImagenMini, PrecioOferta
	)
	VALUES
	(
		@CampaniaID, @CUV, @TipoOfertaSisID, @ConfiguracionOfertaID, @Descripcion, @PrecioValorizado , 0, 0, @ImagenProducto, 
		@Orden, @UnidadesPermitidas, @FlagHabilitarProducto, @DescripcionLegal, @UsuarioRegistro, getdate(), @ImagenMini, @PrecioOferta
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
	@PrecioValorizado decimal(18,2),
	@ImagenMini varchar(150),
	@Incrementa int,
	@CantidadIncrementa int,
	@FlagAgotado int,
	@PrecioOferta decimal(18,2)=0
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
			PrecioOferta = @PrecioOferta
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
	[PrecioValorizado] [decimal](18, 2) NULL,
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
	PrecioValorizado = t.PrecioValorizado
FROM ShowRoom.OfertaShowRoom o
INNER JOIN ods.Campania c on 
	c.CampaniaID = o.CampaniaID
JOIN @StockPrecioOfertaShowRoom t ON 
	c.Codigo = t.CampaniaID
	AND o.CUV = t.CUV
	AND o.TipoOfertaSisID = t.TipoOfertaSisID

end

GO

alter procedure ShowRoom.GetShowRoomOfertasConsultora
@CampaniaID int,
@CodigoConsultora varchar(20)
as
/*
ShowRoom.GetShowRoomOfertasConsultora 201706,'0012954'
ShowRoom.GetShowRoomOfertasConsultora 201706,'1615995'
*/
begin

declare @EsConsultoraGenerica bit = 0
declare @ConsultoraGenerica varchar(50) = ''
select @ConsultoraGenerica = Codigo from TablaLogicaDatos where TablaLogicaDatosID = 10001

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

if exists (select 1 from ShowRoom.EventoConsultora where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora)
begin

insert into @tablaEventoConsultora
select top 1
EventoConsultoraID, EventoID, CampaniaID, CodigoConsultora, Segmento, MostrarPopup, MostrarPopupVenta,
FechaCreacion, UsuarioCreacion, FechaModificacion, UsuarioModificacion
from ShowRoom.EventoConsultora
where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
order by EventoConsultoraID desc

end
else
begin

set @EsConsultoraGenerica = 1

insert into @tablaEventoConsultora
select top 1
EventoConsultoraID, EventoID, CampaniaID, CodigoConsultora, Segmento, MostrarPopup, MostrarPopupVenta,
FechaCreacion, UsuarioCreacion, FechaModificacion, UsuarioModificacion
from ShowRoom.EventoConsultora
where CampaniaID = @CampaniaID and CodigoConsultora = @ConsultoraGenerica
order by EventoConsultoraID desc

end

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

if @EsConsultoraGenerica = 1
	set @CodigoConsultora = @ConsultoraGenerica

select
o.OfertaShowRoomID,o.CampaniaID,o.CUV,o.TipoOfertaSisID,o.ConfiguracionOfertaID,o.Descripcion,
o.PrecioValorizado,
COALESCE(o.PrecioOferta,pc.PrecioCatalogo) AS PrecioOferta,
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

go

ALTER procedure ShowRoom.GetShowRoomCompraPorCompra
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

ALTER PROCEDURE ShowRoom.GetShowRoomOfertaById
 @OfertaShowRoomID int
AS
/*
ShowRoom.GetShowRoomOfertaById 113
*/
BEGIN
 
 SET NOCOUNT ON;
  
	select 
		OfertaShowRoomID,CampaniaID,CUV,TipoOfertaSisID,ConfiguracionOfertaID,Descripcion,PrecioValorizado,Stock,
		StockInicial,ImagenProducto,UnidadesPermitidas,FlagHabilitarProducto,DescripcionLegal,UsuarioRegistro,FechaRegistro,
		UsuarioModificacion,FechaModificacion,ImagenMini,Orden,CodigoCategoria,TipNegocio,PrecioOferta
	from showroom.ofertashowroom
	where OfertaShowRoomID = @OfertaShowRoomID
 
END

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomOfertas]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomOfertas
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomTipoOferta
GO

create procedure ShowRoom.GetShowRoomTipoOferta
as
/*
ShowRoom.GetShowRoomTipoOferta
*/
begin

select 
TipoOfertaID,Codigo,Descripcion,Activo,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion
from ShowRoom.TipoOferta
order by Codigo

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[ExisteShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].ExisteShowRoomTipoOferta
GO

create procedure ShowRoom.ExisteShowRoomTipoOferta
@TipoOfertaID int,
@Codigo varchar(20),
@Descripcion varchar(100)
as
/*
ShowRoom.ExisteShowRoomTipoOferta 0,'106','Oferta ShowRoom 2'
*/
begin

declare @resultado int = 0
/*
Valores posibles:
0: Ok
1: Codigo Tipo de Oferta Existe
2: Descripcion de Tipo de Oferta Existe
*/

if @TipoOfertaID = 0
begin
	if exists (select 1 from ShowRoom.TipoOferta where Codigo = @Codigo)
	begin
		set @resultado = 1
	end
	else
	begin
		if exists (select 1 from ShowRoom.TipoOferta where Descripcion = @Descripcion)
		begin
			set @resultado = 2
		end
	end
end
else
begin
	declare @id int = 0

	if exists (select 1 from ShowRoom.TipoOferta where Codigo = @Codigo)
	begin		
		select @id = TipoOfertaID from ShowRoom.TipoOferta where Codigo = @Codigo

		if (@TipoOfertaID != @id and @id != 0)
			set @resultado = 1		
		else
		begin			
			select @id = TipoOfertaID from ShowRoom.TipoOferta where Descripcion = @Descripcion

			if (@TipoOfertaID != @id and @id != 0)
				set @resultado = 2
		end
	end
	else
	begin
		select @id = TipoOfertaID from ShowRoom.TipoOferta where Descripcion = @Descripcion

		if (@TipoOfertaID != @id and @id != 0)
			set @resultado = 2
	end
end

select @resultado

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[InsertShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].InsertShowRoomTipoOferta
GO

create procedure ShowRoom.InsertShowRoomTipoOferta
@Codigo varchar(20),
@Descripcion varchar(100),
@UsuarioCreacion varchar(50)
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

insert into ShowRoom.TipoOferta (Codigo,Descripcion,Activo,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion)
values (@Codigo,@Descripcion,1,@FechaGeneral,@UsuarioCreacion,@FechaGeneral,@UsuarioCreacion)

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[UpdateShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].UpdateShowRoomTipoOferta
GO

create procedure ShowRoom.UpdateShowRoomTipoOferta
@TipoOfertaID int,
@Codigo varchar(20),
@Descripcion varchar(100),
@UsuarioModificacion varchar(50)
as
/*
ShowRoom.UpdateShowRoomTipoOferta 1,'105','Oferta ShowRoom 1', 'ADMCONTENIDO'
*/
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

update ShowRoom.TipoOferta
set
	Codigo = @Codigo,
	Descripcion = @Descripcion,
	UsuarioModificacion = @UsuarioModificacion,
	FechaModificacion = @FechaGeneral
where
	TipoOfertaID = @TipoOfertaID

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[HabilitarShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].HabilitarShowRoomTipoOferta
GO

create procedure ShowRoom.HabilitarShowRoomTipoOferta
@TipoOfertaID int,
@Activo bit
as
/*
ShowRoom.HabilitarShowRoomTipoOferta 1,1
*/
begin

update ShowRoom.TipoOferta
set
	Activo = @Activo
where
	TipoOfertaID = @TipoOfertaID

end

go

alter procedure ShowRoom.GetShowRoomConsultora
@CampaniaID int,
@CodigoConsultora varchar(20)
as
/*
ShowRoom.GetShowRoomConsultora 201706,'0012954'
ShowRoom.GetShowRoomConsultora 201706,'1615995'
*/
begin

declare @EsConsultoraShowRoom int = 0

if exists (select 1 from ShowRoom.EventoConsultora where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora)
begin

select top 1
EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,MostrarPopup,
MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,
Suscripcion,Envio,CorreoEnvioAviso
from ShowRoom.EventoConsultora
where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
order by FechaCreacion desc

end
else
begin

declare @ConsultoraGenerica varchar(50) = ''
select @ConsultoraGenerica = Codigo from TablaLogicaDatos where TablaLogicaDatosID = 10001

select top 1
EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,1 as MostrarPopup,
1 as MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,
Suscripcion,Envio,CorreoEnvioAviso
from ShowRoom.EventoConsultora
where CampaniaID = @CampaniaID and CodigoConsultora = @ConsultoraGenerica
order by FechaCreacion desc

end

end

go

USE BelcorpPeru
go

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[TipoOferta]') AND (type = 'U') )
	DROP TABLE ShowRoom.TipoOferta
GO

create table ShowRoom.TipoOferta
(
TipoOfertaID int identity(1,1) primary key,
Codigo varchar(20),
Descripcion varchar(100),
Activo bit,
FechaCreacion datetime,
UsuarioCreacion varchar(50),
FechaModificacion datetime,
UsuarioModificacion varchar(50)
)

GO

insert into ShowRoom.TipoOferta(Codigo,Descripcion,Activo,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion)
values
('105','Oferta ShowRoom 1',1,getdate(),'ADMCONTENIDO',getdate(),'ADMCONTENIDO')

go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'PrecioValorizado') = 0
	EXEC sp_RENAME 'ShowRoom.OfertaShowRoom.PrecioOferta' , 'PrecioValorizado', 'COLUMN' 
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'PrecioOferta') = 0
	EXEC sp_RENAME 'ShowRoom.OfertaShowRoom.PrecioOferta2' , 'PrecioOferta', 'COLUMN' 
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'PrecioOferta2') = 1
	alter table ShowRoom.OfertaShowRoom drop column PrecioOferta2
go

alter procedure ShowRoom.GetProductosShowRoom
@CampaniaID int
as
/*
ShowRoom.GetProductosShowRoom 201706
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
	@ConfiguracionOfertaID as ConfiguracionOfertaID
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
ORDER BY OS.CUV desc

end

GO

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
	@PrecioOferta decimal(12,2)=0
)
AS
BEGIN
	INSERT INTO ShowRoom.OfertaShowRoom
	(
		CampaniaID, CUV, TipoOfertaSisID, ConfiguracionOfertaID, Descripcion, PrecioValorizado, Stock, StockInicial, ImagenProducto,
		Orden, UnidadesPermitidas, FlagHabilitarProducto, DescripcionLegal, UsuarioRegistro, FechaRegistro, ImagenMini, PrecioOferta
	)
	VALUES
	(
		@CampaniaID, @CUV, @TipoOfertaSisID, @ConfiguracionOfertaID, @Descripcion, @PrecioValorizado , 0, 0, @ImagenProducto, 
		@Orden, @UnidadesPermitidas, @FlagHabilitarProducto, @DescripcionLegal, @UsuarioRegistro, getdate(), @ImagenMini, @PrecioOferta
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
	@PrecioValorizado decimal(18,2),
	@ImagenMini varchar(150),
	@Incrementa int,
	@CantidadIncrementa int,
	@FlagAgotado int,
	@PrecioOferta decimal(18,2)=0
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
			PrecioOferta = @PrecioOferta
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
	[PrecioValorizado] [decimal](18, 2) NULL,
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
	PrecioValorizado = t.PrecioValorizado
FROM ShowRoom.OfertaShowRoom o
INNER JOIN ods.Campania c on 
	c.CampaniaID = o.CampaniaID
JOIN @StockPrecioOfertaShowRoom t ON 
	c.Codigo = t.CampaniaID
	AND o.CUV = t.CUV
	AND o.TipoOfertaSisID = t.TipoOfertaSisID

end

GO

alter procedure ShowRoom.GetShowRoomOfertasConsultora
@CampaniaID int,
@CodigoConsultora varchar(20)
as
/*
ShowRoom.GetShowRoomOfertasConsultora 201706,'0012954'
ShowRoom.GetShowRoomOfertasConsultora 201706,'1615995'
*/
begin

declare @EsConsultoraGenerica bit = 0
declare @ConsultoraGenerica varchar(50) = ''
select @ConsultoraGenerica = Codigo from TablaLogicaDatos where TablaLogicaDatosID = 10001

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

if exists (select 1 from ShowRoom.EventoConsultora where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora)
begin

insert into @tablaEventoConsultora
select top 1
EventoConsultoraID, EventoID, CampaniaID, CodigoConsultora, Segmento, MostrarPopup, MostrarPopupVenta,
FechaCreacion, UsuarioCreacion, FechaModificacion, UsuarioModificacion
from ShowRoom.EventoConsultora
where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
order by EventoConsultoraID desc

end
else
begin

set @EsConsultoraGenerica = 1

insert into @tablaEventoConsultora
select top 1
EventoConsultoraID, EventoID, CampaniaID, CodigoConsultora, Segmento, MostrarPopup, MostrarPopupVenta,
FechaCreacion, UsuarioCreacion, FechaModificacion, UsuarioModificacion
from ShowRoom.EventoConsultora
where CampaniaID = @CampaniaID and CodigoConsultora = @ConsultoraGenerica
order by EventoConsultoraID desc

end

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

if @EsConsultoraGenerica = 1
	set @CodigoConsultora = @ConsultoraGenerica

select
o.OfertaShowRoomID,o.CampaniaID,o.CUV,o.TipoOfertaSisID,o.ConfiguracionOfertaID,o.Descripcion,
o.PrecioValorizado,
COALESCE(o.PrecioOferta,pc.PrecioCatalogo) AS PrecioOferta,
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

go

ALTER procedure ShowRoom.GetShowRoomCompraPorCompra
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

ALTER PROCEDURE ShowRoom.GetShowRoomOfertaById
 @OfertaShowRoomID int
AS
/*
ShowRoom.GetShowRoomOfertaById 113
*/
BEGIN
 
 SET NOCOUNT ON;
  
	select 
		OfertaShowRoomID,CampaniaID,CUV,TipoOfertaSisID,ConfiguracionOfertaID,Descripcion,PrecioValorizado,Stock,
		StockInicial,ImagenProducto,UnidadesPermitidas,FlagHabilitarProducto,DescripcionLegal,UsuarioRegistro,FechaRegistro,
		UsuarioModificacion,FechaModificacion,ImagenMini,Orden,CodigoCategoria,TipNegocio,PrecioOferta
	from showroom.ofertashowroom
	where OfertaShowRoomID = @OfertaShowRoomID
 
END

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomOfertas]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomOfertas
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomTipoOferta
GO

create procedure ShowRoom.GetShowRoomTipoOferta
as
/*
ShowRoom.GetShowRoomTipoOferta
*/
begin

select 
TipoOfertaID,Codigo,Descripcion,Activo,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion
from ShowRoom.TipoOferta
order by Codigo

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[ExisteShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].ExisteShowRoomTipoOferta
GO

create procedure ShowRoom.ExisteShowRoomTipoOferta
@TipoOfertaID int,
@Codigo varchar(20),
@Descripcion varchar(100)
as
/*
ShowRoom.ExisteShowRoomTipoOferta 0,'106','Oferta ShowRoom 2'
*/
begin

declare @resultado int = 0
/*
Valores posibles:
0: Ok
1: Codigo Tipo de Oferta Existe
2: Descripcion de Tipo de Oferta Existe
*/

if @TipoOfertaID = 0
begin
	if exists (select 1 from ShowRoom.TipoOferta where Codigo = @Codigo)
	begin
		set @resultado = 1
	end
	else
	begin
		if exists (select 1 from ShowRoom.TipoOferta where Descripcion = @Descripcion)
		begin
			set @resultado = 2
		end
	end
end
else
begin
	declare @id int = 0

	if exists (select 1 from ShowRoom.TipoOferta where Codigo = @Codigo)
	begin		
		select @id = TipoOfertaID from ShowRoom.TipoOferta where Codigo = @Codigo

		if (@TipoOfertaID != @id and @id != 0)
			set @resultado = 1		
		else
		begin			
			select @id = TipoOfertaID from ShowRoom.TipoOferta where Descripcion = @Descripcion

			if (@TipoOfertaID != @id and @id != 0)
				set @resultado = 2
		end
	end
	else
	begin
		select @id = TipoOfertaID from ShowRoom.TipoOferta where Descripcion = @Descripcion

		if (@TipoOfertaID != @id and @id != 0)
			set @resultado = 2
	end
end

select @resultado

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[InsertShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].InsertShowRoomTipoOferta
GO

create procedure ShowRoom.InsertShowRoomTipoOferta
@Codigo varchar(20),
@Descripcion varchar(100),
@UsuarioCreacion varchar(50)
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

insert into ShowRoom.TipoOferta (Codigo,Descripcion,Activo,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion)
values (@Codigo,@Descripcion,1,@FechaGeneral,@UsuarioCreacion,@FechaGeneral,@UsuarioCreacion)

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[UpdateShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].UpdateShowRoomTipoOferta
GO

create procedure ShowRoom.UpdateShowRoomTipoOferta
@TipoOfertaID int,
@Codigo varchar(20),
@Descripcion varchar(100),
@UsuarioModificacion varchar(50)
as
/*
ShowRoom.UpdateShowRoomTipoOferta 1,'105','Oferta ShowRoom 1', 'ADMCONTENIDO'
*/
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

update ShowRoom.TipoOferta
set
	Codigo = @Codigo,
	Descripcion = @Descripcion,
	UsuarioModificacion = @UsuarioModificacion,
	FechaModificacion = @FechaGeneral
where
	TipoOfertaID = @TipoOfertaID

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[HabilitarShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].HabilitarShowRoomTipoOferta
GO

create procedure ShowRoom.HabilitarShowRoomTipoOferta
@TipoOfertaID int,
@Activo bit
as
/*
ShowRoom.HabilitarShowRoomTipoOferta 1,1
*/
begin

update ShowRoom.TipoOferta
set
	Activo = @Activo
where
	TipoOfertaID = @TipoOfertaID

end

go

alter procedure ShowRoom.GetShowRoomConsultora
@CampaniaID int,
@CodigoConsultora varchar(20)
as
/*
ShowRoom.GetShowRoomConsultora 201706,'0012954'
ShowRoom.GetShowRoomConsultora 201706,'1615995'
*/
begin

declare @EsConsultoraShowRoom int = 0

if exists (select 1 from ShowRoom.EventoConsultora where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora)
begin

select top 1
EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,MostrarPopup,
MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,
Suscripcion,Envio,CorreoEnvioAviso
from ShowRoom.EventoConsultora
where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
order by FechaCreacion desc

end
else
begin

declare @ConsultoraGenerica varchar(50) = ''
select @ConsultoraGenerica = Codigo from TablaLogicaDatos where TablaLogicaDatosID = 10001

select top 1
EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,1 as MostrarPopup,
1 as MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,
Suscripcion,Envio,CorreoEnvioAviso
from ShowRoom.EventoConsultora
where CampaniaID = @CampaniaID and CodigoConsultora = @ConsultoraGenerica
order by FechaCreacion desc

end

end

go

USE BelcorpPuertoRico
go

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[TipoOferta]') AND (type = 'U') )
	DROP TABLE ShowRoom.TipoOferta
GO

create table ShowRoom.TipoOferta
(
TipoOfertaID int identity(1,1) primary key,
Codigo varchar(20),
Descripcion varchar(100),
Activo bit,
FechaCreacion datetime,
UsuarioCreacion varchar(50),
FechaModificacion datetime,
UsuarioModificacion varchar(50)
)

GO

insert into ShowRoom.TipoOferta(Codigo,Descripcion,Activo,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion)
values
('105','Oferta ShowRoom 1',1,getdate(),'ADMCONTENIDO',getdate(),'ADMCONTENIDO')

go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'PrecioValorizado') = 0
	EXEC sp_RENAME 'ShowRoom.OfertaShowRoom.PrecioOferta' , 'PrecioValorizado', 'COLUMN' 
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'PrecioOferta') = 0
	EXEC sp_RENAME 'ShowRoom.OfertaShowRoom.PrecioOferta2' , 'PrecioOferta', 'COLUMN' 
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'PrecioOferta2') = 1
	alter table ShowRoom.OfertaShowRoom drop column PrecioOferta2
go

alter procedure ShowRoom.GetProductosShowRoom
@CampaniaID int
as
/*
ShowRoom.GetProductosShowRoom 201706
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
	@ConfiguracionOfertaID as ConfiguracionOfertaID
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
ORDER BY OS.CUV desc

end

GO

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
	@PrecioOferta decimal(12,2)=0
)
AS
BEGIN
	INSERT INTO ShowRoom.OfertaShowRoom
	(
		CampaniaID, CUV, TipoOfertaSisID, ConfiguracionOfertaID, Descripcion, PrecioValorizado, Stock, StockInicial, ImagenProducto,
		Orden, UnidadesPermitidas, FlagHabilitarProducto, DescripcionLegal, UsuarioRegistro, FechaRegistro, ImagenMini, PrecioOferta
	)
	VALUES
	(
		@CampaniaID, @CUV, @TipoOfertaSisID, @ConfiguracionOfertaID, @Descripcion, @PrecioValorizado , 0, 0, @ImagenProducto, 
		@Orden, @UnidadesPermitidas, @FlagHabilitarProducto, @DescripcionLegal, @UsuarioRegistro, getdate(), @ImagenMini, @PrecioOferta
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
	@PrecioValorizado decimal(18,2),
	@ImagenMini varchar(150),
	@Incrementa int,
	@CantidadIncrementa int,
	@FlagAgotado int,
	@PrecioOferta decimal(18,2)=0
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
			PrecioOferta = @PrecioOferta
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
	[PrecioValorizado] [decimal](18, 2) NULL,
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
	PrecioValorizado = t.PrecioValorizado
FROM ShowRoom.OfertaShowRoom o
INNER JOIN ods.Campania c on 
	c.CampaniaID = o.CampaniaID
JOIN @StockPrecioOfertaShowRoom t ON 
	c.Codigo = t.CampaniaID
	AND o.CUV = t.CUV
	AND o.TipoOfertaSisID = t.TipoOfertaSisID

end

GO

alter procedure ShowRoom.GetShowRoomOfertasConsultora
@CampaniaID int,
@CodigoConsultora varchar(20)
as
/*
ShowRoom.GetShowRoomOfertasConsultora 201706,'0012954'
ShowRoom.GetShowRoomOfertasConsultora 201706,'1615995'
*/
begin

declare @EsConsultoraGenerica bit = 0
declare @ConsultoraGenerica varchar(50) = ''
select @ConsultoraGenerica = Codigo from TablaLogicaDatos where TablaLogicaDatosID = 10001

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

if exists (select 1 from ShowRoom.EventoConsultora where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora)
begin

insert into @tablaEventoConsultora
select top 1
EventoConsultoraID, EventoID, CampaniaID, CodigoConsultora, Segmento, MostrarPopup, MostrarPopupVenta,
FechaCreacion, UsuarioCreacion, FechaModificacion, UsuarioModificacion
from ShowRoom.EventoConsultora
where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
order by EventoConsultoraID desc

end
else
begin

set @EsConsultoraGenerica = 1

insert into @tablaEventoConsultora
select top 1
EventoConsultoraID, EventoID, CampaniaID, CodigoConsultora, Segmento, MostrarPopup, MostrarPopupVenta,
FechaCreacion, UsuarioCreacion, FechaModificacion, UsuarioModificacion
from ShowRoom.EventoConsultora
where CampaniaID = @CampaniaID and CodigoConsultora = @ConsultoraGenerica
order by EventoConsultoraID desc

end

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

if @EsConsultoraGenerica = 1
	set @CodigoConsultora = @ConsultoraGenerica

select
o.OfertaShowRoomID,o.CampaniaID,o.CUV,o.TipoOfertaSisID,o.ConfiguracionOfertaID,o.Descripcion,
o.PrecioValorizado,
COALESCE(o.PrecioOferta,pc.PrecioCatalogo) AS PrecioOferta,
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

go

ALTER procedure ShowRoom.GetShowRoomCompraPorCompra
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

ALTER PROCEDURE ShowRoom.GetShowRoomOfertaById
 @OfertaShowRoomID int
AS
/*
ShowRoom.GetShowRoomOfertaById 113
*/
BEGIN
 
 SET NOCOUNT ON;
  
	select 
		OfertaShowRoomID,CampaniaID,CUV,TipoOfertaSisID,ConfiguracionOfertaID,Descripcion,PrecioValorizado,Stock,
		StockInicial,ImagenProducto,UnidadesPermitidas,FlagHabilitarProducto,DescripcionLegal,UsuarioRegistro,FechaRegistro,
		UsuarioModificacion,FechaModificacion,ImagenMini,Orden,CodigoCategoria,TipNegocio,PrecioOferta
	from showroom.ofertashowroom
	where OfertaShowRoomID = @OfertaShowRoomID
 
END

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomOfertas]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomOfertas
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomTipoOferta
GO

create procedure ShowRoom.GetShowRoomTipoOferta
as
/*
ShowRoom.GetShowRoomTipoOferta
*/
begin

select 
TipoOfertaID,Codigo,Descripcion,Activo,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion
from ShowRoom.TipoOferta
order by Codigo

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[ExisteShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].ExisteShowRoomTipoOferta
GO

create procedure ShowRoom.ExisteShowRoomTipoOferta
@TipoOfertaID int,
@Codigo varchar(20),
@Descripcion varchar(100)
as
/*
ShowRoom.ExisteShowRoomTipoOferta 0,'106','Oferta ShowRoom 2'
*/
begin

declare @resultado int = 0
/*
Valores posibles:
0: Ok
1: Codigo Tipo de Oferta Existe
2: Descripcion de Tipo de Oferta Existe
*/

if @TipoOfertaID = 0
begin
	if exists (select 1 from ShowRoom.TipoOferta where Codigo = @Codigo)
	begin
		set @resultado = 1
	end
	else
	begin
		if exists (select 1 from ShowRoom.TipoOferta where Descripcion = @Descripcion)
		begin
			set @resultado = 2
		end
	end
end
else
begin
	declare @id int = 0

	if exists (select 1 from ShowRoom.TipoOferta where Codigo = @Codigo)
	begin		
		select @id = TipoOfertaID from ShowRoom.TipoOferta where Codigo = @Codigo

		if (@TipoOfertaID != @id and @id != 0)
			set @resultado = 1		
		else
		begin			
			select @id = TipoOfertaID from ShowRoom.TipoOferta where Descripcion = @Descripcion

			if (@TipoOfertaID != @id and @id != 0)
				set @resultado = 2
		end
	end
	else
	begin
		select @id = TipoOfertaID from ShowRoom.TipoOferta where Descripcion = @Descripcion

		if (@TipoOfertaID != @id and @id != 0)
			set @resultado = 2
	end
end

select @resultado

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[InsertShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].InsertShowRoomTipoOferta
GO

create procedure ShowRoom.InsertShowRoomTipoOferta
@Codigo varchar(20),
@Descripcion varchar(100),
@UsuarioCreacion varchar(50)
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

insert into ShowRoom.TipoOferta (Codigo,Descripcion,Activo,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion)
values (@Codigo,@Descripcion,1,@FechaGeneral,@UsuarioCreacion,@FechaGeneral,@UsuarioCreacion)

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[UpdateShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].UpdateShowRoomTipoOferta
GO

create procedure ShowRoom.UpdateShowRoomTipoOferta
@TipoOfertaID int,
@Codigo varchar(20),
@Descripcion varchar(100),
@UsuarioModificacion varchar(50)
as
/*
ShowRoom.UpdateShowRoomTipoOferta 1,'105','Oferta ShowRoom 1', 'ADMCONTENIDO'
*/
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

update ShowRoom.TipoOferta
set
	Codigo = @Codigo,
	Descripcion = @Descripcion,
	UsuarioModificacion = @UsuarioModificacion,
	FechaModificacion = @FechaGeneral
where
	TipoOfertaID = @TipoOfertaID

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[HabilitarShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].HabilitarShowRoomTipoOferta
GO

create procedure ShowRoom.HabilitarShowRoomTipoOferta
@TipoOfertaID int,
@Activo bit
as
/*
ShowRoom.HabilitarShowRoomTipoOferta 1,1
*/
begin

update ShowRoom.TipoOferta
set
	Activo = @Activo
where
	TipoOfertaID = @TipoOfertaID

end

go

alter procedure ShowRoom.GetShowRoomConsultora
@CampaniaID int,
@CodigoConsultora varchar(20)
as
/*
ShowRoom.GetShowRoomConsultora 201706,'0012954'
ShowRoom.GetShowRoomConsultora 201706,'1615995'
*/
begin

declare @EsConsultoraShowRoom int = 0

if exists (select 1 from ShowRoom.EventoConsultora where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora)
begin

select top 1
EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,MostrarPopup,
MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,
Suscripcion,Envio,CorreoEnvioAviso
from ShowRoom.EventoConsultora
where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
order by FechaCreacion desc

end
else
begin

declare @ConsultoraGenerica varchar(50) = ''
select @ConsultoraGenerica = Codigo from TablaLogicaDatos where TablaLogicaDatosID = 10001

select top 1
EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,1 as MostrarPopup,
1 as MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,
Suscripcion,Envio,CorreoEnvioAviso
from ShowRoom.EventoConsultora
where CampaniaID = @CampaniaID and CodigoConsultora = @ConsultoraGenerica
order by FechaCreacion desc

end

end

go

USE BelcorpSalvador
go

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[TipoOferta]') AND (type = 'U') )
	DROP TABLE ShowRoom.TipoOferta
GO

create table ShowRoom.TipoOferta
(
TipoOfertaID int identity(1,1) primary key,
Codigo varchar(20),
Descripcion varchar(100),
Activo bit,
FechaCreacion datetime,
UsuarioCreacion varchar(50),
FechaModificacion datetime,
UsuarioModificacion varchar(50)
)

GO

insert into ShowRoom.TipoOferta(Codigo,Descripcion,Activo,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion)
values
('105','Oferta ShowRoom 1',1,getdate(),'ADMCONTENIDO',getdate(),'ADMCONTENIDO')

go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'PrecioValorizado') = 0
	EXEC sp_RENAME 'ShowRoom.OfertaShowRoom.PrecioOferta' , 'PrecioValorizado', 'COLUMN' 
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'PrecioOferta') = 0
	EXEC sp_RENAME 'ShowRoom.OfertaShowRoom.PrecioOferta2' , 'PrecioOferta', 'COLUMN' 
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'PrecioOferta2') = 1
	alter table ShowRoom.OfertaShowRoom drop column PrecioOferta2
go

alter procedure ShowRoom.GetProductosShowRoom
@CampaniaID int
as
/*
ShowRoom.GetProductosShowRoom 201706
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
	@ConfiguracionOfertaID as ConfiguracionOfertaID
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
ORDER BY OS.CUV desc

end

GO

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
	@PrecioOferta decimal(12,2)=0
)
AS
BEGIN
	INSERT INTO ShowRoom.OfertaShowRoom
	(
		CampaniaID, CUV, TipoOfertaSisID, ConfiguracionOfertaID, Descripcion, PrecioValorizado, Stock, StockInicial, ImagenProducto,
		Orden, UnidadesPermitidas, FlagHabilitarProducto, DescripcionLegal, UsuarioRegistro, FechaRegistro, ImagenMini, PrecioOferta
	)
	VALUES
	(
		@CampaniaID, @CUV, @TipoOfertaSisID, @ConfiguracionOfertaID, @Descripcion, @PrecioValorizado , 0, 0, @ImagenProducto, 
		@Orden, @UnidadesPermitidas, @FlagHabilitarProducto, @DescripcionLegal, @UsuarioRegistro, getdate(), @ImagenMini, @PrecioOferta
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
	@PrecioValorizado decimal(18,2),
	@ImagenMini varchar(150),
	@Incrementa int,
	@CantidadIncrementa int,
	@FlagAgotado int,
	@PrecioOferta decimal(18,2)=0
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
			PrecioOferta = @PrecioOferta
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
	[PrecioValorizado] [decimal](18, 2) NULL,
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
	PrecioValorizado = t.PrecioValorizado
FROM ShowRoom.OfertaShowRoom o
INNER JOIN ods.Campania c on 
	c.CampaniaID = o.CampaniaID
JOIN @StockPrecioOfertaShowRoom t ON 
	c.Codigo = t.CampaniaID
	AND o.CUV = t.CUV
	AND o.TipoOfertaSisID = t.TipoOfertaSisID

end

GO

alter procedure ShowRoom.GetShowRoomOfertasConsultora
@CampaniaID int,
@CodigoConsultora varchar(20)
as
/*
ShowRoom.GetShowRoomOfertasConsultora 201706,'0012954'
ShowRoom.GetShowRoomOfertasConsultora 201706,'1615995'
*/
begin

declare @EsConsultoraGenerica bit = 0
declare @ConsultoraGenerica varchar(50) = ''
select @ConsultoraGenerica = Codigo from TablaLogicaDatos where TablaLogicaDatosID = 10001

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

if exists (select 1 from ShowRoom.EventoConsultora where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora)
begin

insert into @tablaEventoConsultora
select top 1
EventoConsultoraID, EventoID, CampaniaID, CodigoConsultora, Segmento, MostrarPopup, MostrarPopupVenta,
FechaCreacion, UsuarioCreacion, FechaModificacion, UsuarioModificacion
from ShowRoom.EventoConsultora
where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
order by EventoConsultoraID desc

end
else
begin

set @EsConsultoraGenerica = 1

insert into @tablaEventoConsultora
select top 1
EventoConsultoraID, EventoID, CampaniaID, CodigoConsultora, Segmento, MostrarPopup, MostrarPopupVenta,
FechaCreacion, UsuarioCreacion, FechaModificacion, UsuarioModificacion
from ShowRoom.EventoConsultora
where CampaniaID = @CampaniaID and CodigoConsultora = @ConsultoraGenerica
order by EventoConsultoraID desc

end

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

if @EsConsultoraGenerica = 1
	set @CodigoConsultora = @ConsultoraGenerica

select
o.OfertaShowRoomID,o.CampaniaID,o.CUV,o.TipoOfertaSisID,o.ConfiguracionOfertaID,o.Descripcion,
o.PrecioValorizado,
COALESCE(o.PrecioOferta,pc.PrecioCatalogo) AS PrecioOferta,
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

go

ALTER procedure ShowRoom.GetShowRoomCompraPorCompra
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

ALTER PROCEDURE ShowRoom.GetShowRoomOfertaById
 @OfertaShowRoomID int
AS
/*
ShowRoom.GetShowRoomOfertaById 113
*/
BEGIN
 
 SET NOCOUNT ON;
  
	select 
		OfertaShowRoomID,CampaniaID,CUV,TipoOfertaSisID,ConfiguracionOfertaID,Descripcion,PrecioValorizado,Stock,
		StockInicial,ImagenProducto,UnidadesPermitidas,FlagHabilitarProducto,DescripcionLegal,UsuarioRegistro,FechaRegistro,
		UsuarioModificacion,FechaModificacion,ImagenMini,Orden,CodigoCategoria,TipNegocio,PrecioOferta
	from showroom.ofertashowroom
	where OfertaShowRoomID = @OfertaShowRoomID
 
END

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomOfertas]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomOfertas
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomTipoOferta
GO

create procedure ShowRoom.GetShowRoomTipoOferta
as
/*
ShowRoom.GetShowRoomTipoOferta
*/
begin

select 
TipoOfertaID,Codigo,Descripcion,Activo,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion
from ShowRoom.TipoOferta
order by Codigo

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[ExisteShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].ExisteShowRoomTipoOferta
GO

create procedure ShowRoom.ExisteShowRoomTipoOferta
@TipoOfertaID int,
@Codigo varchar(20),
@Descripcion varchar(100)
as
/*
ShowRoom.ExisteShowRoomTipoOferta 0,'106','Oferta ShowRoom 2'
*/
begin

declare @resultado int = 0
/*
Valores posibles:
0: Ok
1: Codigo Tipo de Oferta Existe
2: Descripcion de Tipo de Oferta Existe
*/

if @TipoOfertaID = 0
begin
	if exists (select 1 from ShowRoom.TipoOferta where Codigo = @Codigo)
	begin
		set @resultado = 1
	end
	else
	begin
		if exists (select 1 from ShowRoom.TipoOferta where Descripcion = @Descripcion)
		begin
			set @resultado = 2
		end
	end
end
else
begin
	declare @id int = 0

	if exists (select 1 from ShowRoom.TipoOferta where Codigo = @Codigo)
	begin		
		select @id = TipoOfertaID from ShowRoom.TipoOferta where Codigo = @Codigo

		if (@TipoOfertaID != @id and @id != 0)
			set @resultado = 1		
		else
		begin			
			select @id = TipoOfertaID from ShowRoom.TipoOferta where Descripcion = @Descripcion

			if (@TipoOfertaID != @id and @id != 0)
				set @resultado = 2
		end
	end
	else
	begin
		select @id = TipoOfertaID from ShowRoom.TipoOferta where Descripcion = @Descripcion

		if (@TipoOfertaID != @id and @id != 0)
			set @resultado = 2
	end
end

select @resultado

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[InsertShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].InsertShowRoomTipoOferta
GO

create procedure ShowRoom.InsertShowRoomTipoOferta
@Codigo varchar(20),
@Descripcion varchar(100),
@UsuarioCreacion varchar(50)
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

insert into ShowRoom.TipoOferta (Codigo,Descripcion,Activo,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion)
values (@Codigo,@Descripcion,1,@FechaGeneral,@UsuarioCreacion,@FechaGeneral,@UsuarioCreacion)

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[UpdateShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].UpdateShowRoomTipoOferta
GO

create procedure ShowRoom.UpdateShowRoomTipoOferta
@TipoOfertaID int,
@Codigo varchar(20),
@Descripcion varchar(100),
@UsuarioModificacion varchar(50)
as
/*
ShowRoom.UpdateShowRoomTipoOferta 1,'105','Oferta ShowRoom 1', 'ADMCONTENIDO'
*/
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

update ShowRoom.TipoOferta
set
	Codigo = @Codigo,
	Descripcion = @Descripcion,
	UsuarioModificacion = @UsuarioModificacion,
	FechaModificacion = @FechaGeneral
where
	TipoOfertaID = @TipoOfertaID

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[HabilitarShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].HabilitarShowRoomTipoOferta
GO

create procedure ShowRoom.HabilitarShowRoomTipoOferta
@TipoOfertaID int,
@Activo bit
as
/*
ShowRoom.HabilitarShowRoomTipoOferta 1,1
*/
begin

update ShowRoom.TipoOferta
set
	Activo = @Activo
where
	TipoOfertaID = @TipoOfertaID

end

go

alter procedure ShowRoom.GetShowRoomConsultora
@CampaniaID int,
@CodigoConsultora varchar(20)
as
/*
ShowRoom.GetShowRoomConsultora 201706,'0012954'
ShowRoom.GetShowRoomConsultora 201706,'1615995'
*/
begin

declare @EsConsultoraShowRoom int = 0

if exists (select 1 from ShowRoom.EventoConsultora where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora)
begin

select top 1
EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,MostrarPopup,
MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,
Suscripcion,Envio,CorreoEnvioAviso
from ShowRoom.EventoConsultora
where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
order by FechaCreacion desc

end
else
begin

declare @ConsultoraGenerica varchar(50) = ''
select @ConsultoraGenerica = Codigo from TablaLogicaDatos where TablaLogicaDatosID = 10001

select top 1
EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,1 as MostrarPopup,
1 as MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,
Suscripcion,Envio,CorreoEnvioAviso
from ShowRoom.EventoConsultora
where CampaniaID = @CampaniaID and CodigoConsultora = @ConsultoraGenerica
order by FechaCreacion desc

end

end

go

USE BelcorpVenezuela
go

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[TipoOferta]') AND (type = 'U') )
	DROP TABLE ShowRoom.TipoOferta
GO

create table ShowRoom.TipoOferta
(
TipoOfertaID int identity(1,1) primary key,
Codigo varchar(20),
Descripcion varchar(100),
Activo bit,
FechaCreacion datetime,
UsuarioCreacion varchar(50),
FechaModificacion datetime,
UsuarioModificacion varchar(50)
)

GO

insert into ShowRoom.TipoOferta(Codigo,Descripcion,Activo,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion)
values
('105','Oferta ShowRoom 1',1,getdate(),'ADMCONTENIDO',getdate(),'ADMCONTENIDO')

go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'PrecioValorizado') = 0
	EXEC sp_RENAME 'ShowRoom.OfertaShowRoom.PrecioOferta' , 'PrecioValorizado', 'COLUMN' 
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'PrecioOferta') = 0
	EXEC sp_RENAME 'ShowRoom.OfertaShowRoom.PrecioOferta2' , 'PrecioOferta', 'COLUMN' 
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'PrecioOferta2') = 1
	alter table ShowRoom.OfertaShowRoom drop column PrecioOferta2
go

alter procedure ShowRoom.GetProductosShowRoom
@CampaniaID int
as
/*
ShowRoom.GetProductosShowRoom 201706
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
	@ConfiguracionOfertaID as ConfiguracionOfertaID
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
ORDER BY OS.CUV desc

end

GO

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
	@PrecioOferta decimal(12,2)=0
)
AS
BEGIN
	INSERT INTO ShowRoom.OfertaShowRoom
	(
		CampaniaID, CUV, TipoOfertaSisID, ConfiguracionOfertaID, Descripcion, PrecioValorizado, Stock, StockInicial, ImagenProducto,
		Orden, UnidadesPermitidas, FlagHabilitarProducto, DescripcionLegal, UsuarioRegistro, FechaRegistro, ImagenMini, PrecioOferta
	)
	VALUES
	(
		@CampaniaID, @CUV, @TipoOfertaSisID, @ConfiguracionOfertaID, @Descripcion, @PrecioValorizado , 0, 0, @ImagenProducto, 
		@Orden, @UnidadesPermitidas, @FlagHabilitarProducto, @DescripcionLegal, @UsuarioRegistro, getdate(), @ImagenMini, @PrecioOferta
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
	@PrecioValorizado decimal(18,2),
	@ImagenMini varchar(150),
	@Incrementa int,
	@CantidadIncrementa int,
	@FlagAgotado int,
	@PrecioOferta decimal(18,2)=0
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
			PrecioOferta = @PrecioOferta
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
	[PrecioValorizado] [decimal](18, 2) NULL,
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
	PrecioValorizado = t.PrecioValorizado
FROM ShowRoom.OfertaShowRoom o
INNER JOIN ods.Campania c on 
	c.CampaniaID = o.CampaniaID
JOIN @StockPrecioOfertaShowRoom t ON 
	c.Codigo = t.CampaniaID
	AND o.CUV = t.CUV
	AND o.TipoOfertaSisID = t.TipoOfertaSisID

end

GO

alter procedure ShowRoom.GetShowRoomOfertasConsultora
@CampaniaID int,
@CodigoConsultora varchar(20)
as
/*
ShowRoom.GetShowRoomOfertasConsultora 201706,'0012954'
ShowRoom.GetShowRoomOfertasConsultora 201706,'1615995'
*/
begin

declare @EsConsultoraGenerica bit = 0
declare @ConsultoraGenerica varchar(50) = ''
select @ConsultoraGenerica = Codigo from TablaLogicaDatos where TablaLogicaDatosID = 10001

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

if exists (select 1 from ShowRoom.EventoConsultora where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora)
begin

insert into @tablaEventoConsultora
select top 1
EventoConsultoraID, EventoID, CampaniaID, CodigoConsultora, Segmento, MostrarPopup, MostrarPopupVenta,
FechaCreacion, UsuarioCreacion, FechaModificacion, UsuarioModificacion
from ShowRoom.EventoConsultora
where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
order by EventoConsultoraID desc

end
else
begin

set @EsConsultoraGenerica = 1

insert into @tablaEventoConsultora
select top 1
EventoConsultoraID, EventoID, CampaniaID, CodigoConsultora, Segmento, MostrarPopup, MostrarPopupVenta,
FechaCreacion, UsuarioCreacion, FechaModificacion, UsuarioModificacion
from ShowRoom.EventoConsultora
where CampaniaID = @CampaniaID and CodigoConsultora = @ConsultoraGenerica
order by EventoConsultoraID desc

end

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

if @EsConsultoraGenerica = 1
	set @CodigoConsultora = @ConsultoraGenerica

select
o.OfertaShowRoomID,o.CampaniaID,o.CUV,o.TipoOfertaSisID,o.ConfiguracionOfertaID,o.Descripcion,
o.PrecioValorizado,
COALESCE(o.PrecioOferta,pc.PrecioCatalogo) AS PrecioOferta,
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

go

ALTER procedure ShowRoom.GetShowRoomCompraPorCompra
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

ALTER PROCEDURE ShowRoom.GetShowRoomOfertaById
 @OfertaShowRoomID int
AS
/*
ShowRoom.GetShowRoomOfertaById 113
*/
BEGIN
 
 SET NOCOUNT ON;
  
	select 
		OfertaShowRoomID,CampaniaID,CUV,TipoOfertaSisID,ConfiguracionOfertaID,Descripcion,PrecioValorizado,Stock,
		StockInicial,ImagenProducto,UnidadesPermitidas,FlagHabilitarProducto,DescripcionLegal,UsuarioRegistro,FechaRegistro,
		UsuarioModificacion,FechaModificacion,ImagenMini,Orden,CodigoCategoria,TipNegocio,PrecioOferta
	from showroom.ofertashowroom
	where OfertaShowRoomID = @OfertaShowRoomID
 
END

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomOfertas]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomOfertas
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomTipoOferta
GO

create procedure ShowRoom.GetShowRoomTipoOferta
as
/*
ShowRoom.GetShowRoomTipoOferta
*/
begin

select 
TipoOfertaID,Codigo,Descripcion,Activo,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion
from ShowRoom.TipoOferta
order by Codigo

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[ExisteShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].ExisteShowRoomTipoOferta
GO

create procedure ShowRoom.ExisteShowRoomTipoOferta
@TipoOfertaID int,
@Codigo varchar(20),
@Descripcion varchar(100)
as
/*
ShowRoom.ExisteShowRoomTipoOferta 0,'106','Oferta ShowRoom 2'
*/
begin

declare @resultado int = 0
/*
Valores posibles:
0: Ok
1: Codigo Tipo de Oferta Existe
2: Descripcion de Tipo de Oferta Existe
*/

if @TipoOfertaID = 0
begin
	if exists (select 1 from ShowRoom.TipoOferta where Codigo = @Codigo)
	begin
		set @resultado = 1
	end
	else
	begin
		if exists (select 1 from ShowRoom.TipoOferta where Descripcion = @Descripcion)
		begin
			set @resultado = 2
		end
	end
end
else
begin
	declare @id int = 0

	if exists (select 1 from ShowRoom.TipoOferta where Codigo = @Codigo)
	begin		
		select @id = TipoOfertaID from ShowRoom.TipoOferta where Codigo = @Codigo

		if (@TipoOfertaID != @id and @id != 0)
			set @resultado = 1		
		else
		begin			
			select @id = TipoOfertaID from ShowRoom.TipoOferta where Descripcion = @Descripcion

			if (@TipoOfertaID != @id and @id != 0)
				set @resultado = 2
		end
	end
	else
	begin
		select @id = TipoOfertaID from ShowRoom.TipoOferta where Descripcion = @Descripcion

		if (@TipoOfertaID != @id and @id != 0)
			set @resultado = 2
	end
end

select @resultado

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[InsertShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].InsertShowRoomTipoOferta
GO

create procedure ShowRoom.InsertShowRoomTipoOferta
@Codigo varchar(20),
@Descripcion varchar(100),
@UsuarioCreacion varchar(50)
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

insert into ShowRoom.TipoOferta (Codigo,Descripcion,Activo,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion)
values (@Codigo,@Descripcion,1,@FechaGeneral,@UsuarioCreacion,@FechaGeneral,@UsuarioCreacion)

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[UpdateShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].UpdateShowRoomTipoOferta
GO

create procedure ShowRoom.UpdateShowRoomTipoOferta
@TipoOfertaID int,
@Codigo varchar(20),
@Descripcion varchar(100),
@UsuarioModificacion varchar(50)
as
/*
ShowRoom.UpdateShowRoomTipoOferta 1,'105','Oferta ShowRoom 1', 'ADMCONTENIDO'
*/
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

update ShowRoom.TipoOferta
set
	Codigo = @Codigo,
	Descripcion = @Descripcion,
	UsuarioModificacion = @UsuarioModificacion,
	FechaModificacion = @FechaGeneral
where
	TipoOfertaID = @TipoOfertaID

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[HabilitarShowRoomTipoOferta]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].HabilitarShowRoomTipoOferta
GO

create procedure ShowRoom.HabilitarShowRoomTipoOferta
@TipoOfertaID int,
@Activo bit
as
/*
ShowRoom.HabilitarShowRoomTipoOferta 1,1
*/
begin

update ShowRoom.TipoOferta
set
	Activo = @Activo
where
	TipoOfertaID = @TipoOfertaID

end

go

alter procedure ShowRoom.GetShowRoomConsultora
@CampaniaID int,
@CodigoConsultora varchar(20)
as
/*
ShowRoom.GetShowRoomConsultora 201706,'0012954'
ShowRoom.GetShowRoomConsultora 201706,'1615995'
*/
begin

declare @EsConsultoraShowRoom int = 0

if exists (select 1 from ShowRoom.EventoConsultora where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora)
begin

select top 1
EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,MostrarPopup,
MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,
Suscripcion,Envio,CorreoEnvioAviso
from ShowRoom.EventoConsultora
where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
order by FechaCreacion desc

end
else
begin

declare @ConsultoraGenerica varchar(50) = ''
select @ConsultoraGenerica = Codigo from TablaLogicaDatos where TablaLogicaDatosID = 10001

select top 1
EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,1 as MostrarPopup,
1 as MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,
Suscripcion,Envio,CorreoEnvioAviso
from ShowRoom.EventoConsultora
where CampaniaID = @CampaniaID and CodigoConsultora = @ConsultoraGenerica
order by FechaCreacion desc

end

end

go