USE BelcorpBolivia
go

delete from dbo.TablaLogicaDatos where TablaLogicaID = 99
delete from dbo.TablaLogica where TablaLogicaID = 99

go

if not exists (select 1 from dbo.TablaLogica where TablaLogicaID = 99)
begin
	insert into dbo.TablaLogica(TablaLogicaID,Descripcion) values (99,'OrdenamientoShowRoom')
end

go

if not exists (select 1 from dbo.TablaLogicaDatos where TablaLogicaID = 99 and Codigo='01')
begin
	insert into dbo.TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) 
	values (9901,99,'01','Los más vendidos')
end

go

if not exists (select 1 from dbo.TablaLogicaDatos where TablaLogicaID = 99 and Codigo='02')
begin
	insert into dbo.TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) 
	values (9902,99,'02','Menor a mayor precio')
end

go

if not exists (select 1 from dbo.TablaLogicaDatos where TablaLogicaID = 99 and Codigo='03')
begin
	insert into dbo.TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) 
	values (9903,99,'03','Mayor a menor precio')
end

go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.Evento') and SYSCOLUMNS.NAME = N'TieneCategoria') = 0
	ALTER TABLE ShowRoom.Evento ADD TieneCategoria bit
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.Evento') and SYSCOLUMNS.NAME = N'TieneCompraXcompra') = 0
	ALTER TABLE ShowRoom.Evento ADD TieneCompraXcompra bit
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'CodigoCategoria') = 0
	ALTER TABLE ShowRoom.OfertaShowRoom ADD CodigoCategoria varchar(100)
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'TipNegocio') = 0
	ALTER TABLE ShowRoom.OfertaShowRoom ADD TipNegocio varchar(500)
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoomDetalle') and SYSCOLUMNS.NAME = N'MarcaProducto') = 0
	ALTER TABLE ShowRoom.OfertaShowRoomDetalle ADD MarcaProducto varchar(100)
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.EventoConsultora') and SYSCOLUMNS.NAME = N'MostrarPopupVenta') = 0
	ALTER TABLE ShowRoom.EventoConsultora ADD MostrarPopupVenta bit
go

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[Nivel]') AND (type = 'U') )
	DROP TABLE ShowRoom.Nivel
GO

create table ShowRoom.Nivel
(
	NivelId int identity(1,1) primary key,
	Codigo varchar(100),
	Descripcion varchar(100)
)

go

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[Personalizacion]') AND (type = 'U') )
	DROP TABLE ShowRoom.Personalizacion
GO

create table ShowRoom.Personalizacion
(
	PersonalizacionId int identity(1,1) primary key,
	TipoAplicacion varchar(20),
	Atributo varchar(100),
	TextoAyuda varchar(200),
	TipoAtributo varchar(20),
	TipoPersonalizacion varchar(20),
	Orden int,
	Estado bit
)

go

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[PersonalizacionNivel]') AND (type = 'U') )
	DROP TABLE ShowRoom.PersonalizacionNivel
GO

create table ShowRoom.PersonalizacionNivel
(
	PersonalizacionNivelId int identity(1,1) primary key,
	EventoID int,
	PersonalizacionId int,
	NivelId int,
	CategoriaId int,
	Valor varchar(200)
)

go

CREATE NONCLUSTERED INDEX IX_ShowRoomPersonalizacionNivel_EventoIdNivelId ON ShowRoom.PersonalizacionNivel (EventoID,NivelId);

go

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[Categoria]') AND (type = 'U') )
	DROP TABLE ShowRoom.Categoria
GO

create table ShowRoom.Categoria
(
	CategoriaId int identity(1,1) primary key,
	EventoID int,
	Codigo varchar(50),
	Descripcion varchar(200)
)

go

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[CompraPorCompra]') AND (type = 'U') )
	DROP TABLE ShowRoom.CompraPorCompra
GO

CREATE TABLE ShowRoom.CompraPorCompra
(
	CompraxCompraID int identity(1,1) primary key,
	EventoID int,
	CUV varchar(20),
	SAP varchar(12),
	Orden int,
	PrecioValorizado decimal(18,2),
	FechaCreacion datetime,
	UsuarioCreacion varchar(50),
	FechaModificacion datetime,
	UsuarioModificacion varchar(50)
)

GO

insert into ShowRoom.Nivel (Codigo,Descripcion) values ('PAIS','País')

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','PopupImagenIntriga','Popup Principal Intriga (615px x 409px)','IMAGEN','EVENTO',1,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','PopupImagenVenta','Popup Principal Venta (615px x 409px)','IMAGEN','EVENTO',2,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','BannerImagenIntriga','Visual Superior Intriga (1920px x 174px)','IMAGEN','EVENTO',3,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','BannerImagenVenta','Visual Superior Venta (1920px x 174px)','IMAGEN','EVENTO',4,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','UrlTerminosCondiciones','Link Terminos y Condiciones','TEXTO','EVENTO',5,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','TextoCondicionCompraCpc','Texto Condición de Compra por Compra','TEXTO','EVENTO',6,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','TextoDescripcionLegalCpc','Texto Descripción Legal Compra por Compra','TEXTO','EVENTO',7,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','IconoLluvia','Icono Lluvia Paginal Principal','IMAGEN','EVENTO',8,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','BannerEnvioCorreo','Imagen Envio Correo','IMAGEN','EVENTO',9,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','TextoEnvioCorreo','Texto mostrar Envio Correo','TEXTO','EVENTO',10,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','ImagenFondoProductPage','Imagen de Fondo del Product Page','IMAGEN','EVENTO',11,1)

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','TituloPrincipal','Título de la Categoria','TEXTO','CATEGORIA',12,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','ImagenPrincipal','Imagen a mostrar en la Categoria','IMAGEN','CATEGORIA',13,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','ColorFondo','Color de Fondo de la Categoria','TEXTO','CATEGORIA',14,1)

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','PopupImagenIntriga','Banner Marquesina Intriga (768px x 420px)','IMAGEN','EVENTO',1,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','PopupImagenVenta','Banner Marquesina Venta (768px x 420px)','IMAGEN','EVENTO',2,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','BannerImagenIntriga','Banner Superior Intriga (1024px x 60px)','IMAGEN','EVENTO',3,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','BannerImagenPaginaVenta','Banner Superior Pagina Venta (1024px x 60px)','IMAGEN','EVENTO',4,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','BannerImagenVenta','Banner Superior Venta Otras Paginas (1024px x 60px)','IMAGEN','EVENTO',5,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','UrlTerminosCondiciones','Link Terminos y Condiciones','TEXTO','EVENTO',6,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','TextoCondicionCompraCpc','Texto Condición de Compra','TEXTO','EVENTO',7,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','TextoDescripcionLegalCpc','Texto Descripción Legal Compra por Compra','TEXTO','EVENTO',8,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','ImagenFondoProductPage','Imagen de Fondo del Product Page','IMAGEN','EVENTO',9,1)

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','TituloPrincipal','Título de la Categoria','TEXTO','CATEGORIA',10,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','ColorFondo','Color de Fondo de la Categoria','TEXTO','CATEGORIA',11,1)

go

update ShowRoom.EventoConsultora set MostrarPopup = 1 where MostrarPopup is null
update ShowRoom.EventoConsultora set MostrarPopupVenta = 1 where MostrarPopupVenta is null

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomNivel]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomNivel
GO

create procedure ShowRoom.GetShowRoomNivel
as
/*
ShowRoom.GetShowRoomNivel
*/
begin

select
	NivelId,
	Codigo,
	Descripcion
from ShowRoom.Nivel

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomPersonalizacion]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomPersonalizacion
GO

create procedure ShowRoom.GetShowRoomPersonalizacion
as
/*
ShowRoom.GetShowRoomPersonalizacion
*/
begin

select
	PersonalizacionId,
	TipoAplicacion,
	Atributo,
	TextoAyuda,
	TipoAtributo,
	TipoPersonalizacion,
	Orden,
	Estado
from ShowRoom.Personalizacion

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomPersonalizacionNivel]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomPersonalizacionNivel
GO

create procedure ShowRoom.GetShowRoomPersonalizacionNivel
@EventoId int,
@NivelId int = 0,
@CategoriaId int = 0
as
/*
ShowRoom.GetShowRoomPersonalizacionNivel 5,1,0
ShowRoom.GetShowRoomPersonalizacionNivel 5,0,1
*/
begin

select 
	PersonalizacionNivelId,
	EventoID,
	PersonalizacionId,
	isnull(NivelId,0) as NivelId,
	isnull(CategoriaId,0) as CategoriaId,
	isnull(Valor,'') as Valor
from ShowRoom.PersonalizacionNivel
where
	EventoID = @EventoId
	and (@NivelId = 0 or NivelId = @NivelId)
	and (@CategoriaId = 0 or CategoriaId = @CategoriaId)

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[InsertShowRoomPersonalizacionNivel]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].InsertShowRoomPersonalizacionNivel
GO

create procedure ShowRoom.InsertShowRoomPersonalizacionNivel
@EventoID int,
@PersonalizacionId int,
@NivelId int,
@CategoriaId int = 0,
@Valor varchar(200)
as
begin

insert into ShowRoom.PersonalizacionNivel (EventoID, PersonalizacionId, NivelId, CategoriaId, Valor)
values (@EventoID, @PersonalizacionId, @NivelId, @CategoriaId, @Valor)

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[UpdateShowRoomPersonalizacionNivel]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].UpdateShowRoomPersonalizacionNivel
GO

create procedure ShowRoom.UpdateShowRoomPersonalizacionNivel
@PersonalizacionNivelId int,
@Valor varchar(200)
as
begin

update ShowRoom.PersonalizacionNivel
	set Valor = @Valor
where PersonalizacionNivelId = @PersonalizacionNivelId

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomCategorias]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomCategorias
GO

create procedure ShowRoom.GetShowRoomCategorias
@EventoId int
as
/*
ShowRoom.GetShowRoomCategorias 6
*/
begin

select
	CategoriaId,
	EventoID,
	Codigo,
	Descripcion
from ShowRoom.Categoria
where EventoID = @EventoId

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomCategoriaById]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomCategoriaById
GO

create procedure ShowRoom.GetShowRoomCategoriaById
@CategoriaId int
as
/*
ShowRoom.GetShowRoomCategoriaById 1
*/
begin

select
	CategoriaId,
	EventoID,
	Codigo,
	Descripcion
from ShowRoom.Categoria
where CategoriaId = @CategoriaId

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[UpdateShowRoomDescripcionCategoria]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].UpdateShowRoomDescripcionCategoria
GO

create procedure ShowRoom.UpdateShowRoomDescripcionCategoria
@CategoriaId int,
@Descripcion varchar(200)
as
begin

update ShowRoom.Categoria
set
	Descripcion = @Descripcion
where 
	CategoriaId = @CategoriaId

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[DeleteShowRoomCategoriaByEvento]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].DeleteShowRoomCategoriaByEvento
GO

create procedure ShowRoom.DeleteShowRoomCategoriaByEvento
@EventoId int
as
begin

delete from ShowRoom.PersonalizacionNivel where EventoID = @EventoId and NivelId = 0
delete from ShowRoom.Categoria where EventoId = @EventoID

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[InsertShowRoomCategoria]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].InsertShowRoomCategoria
GO

create procedure ShowRoom.InsertShowRoomCategoria
@EventoID int,
@Codigo varchar(50),
@Descripcion varchar(200)
as
begin

insert into ShowRoom.Categoria (EventoID, Codigo, Descripcion) values (@EventoID, @Codigo, @Descripcion)

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomCompraPorCompra]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomCompraPorCompra
GO

create procedure ShowRoom.GetShowRoomCompraPorCompra
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

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[UpdStockOfertaShowRoomMasivo]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].UpdStockOfertaShowRoomMasivo
GO

IF (SELECT COUNT(*) FROM sys.table_types WHERE name = 'StockPrecioOfertaShowRoomType') = 1
	drop type ShowRoom.StockPrecioOfertaShowRoomType

go

go

IF (SELECT COUNT(*) FROM sys.table_types WHERE name = 'StockPrecioOfertaShowRoomType') = 0  
  CREATE TYPE ShowRoom.StockPrecioOfertaShowRoomType AS TABLE ( 
	TipoOfertaSisID int, CampaniaID int, CUV varchar(20), Stock int, PrecioOferta decimal(18,2), UnidadesPermitidas int,
	Descripcion varchar(250), CodigoCategoria varchar(100), TipNegocio varchar(500)
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
	TipNegocio = t.TipNegocio
FROM ShowRoom.OfertaShowRoom o
INNER JOIN ods.Campania c on 
	c.CampaniaID = o.CampaniaID
JOIN @StockPrecioOfertaShowRoom t ON 
	c.Codigo = t.CampaniaID
	AND o.CUV = t.CUV
	AND o.TipoOfertaSisID = t.TipoOfertaSisID

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[InsertCargaMasivaOfertaDetalle]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].InsertCargaMasivaOfertaDetalle
GO

IF (SELECT COUNT(*) FROM sys.table_types WHERE name = 'OfertaShowRoomDetalleType') = 1
	drop type ShowRoom.OfertaShowRoomDetalleType

go

go

IF (SELECT COUNT(*) FROM sys.table_types WHERE name = 'OfertaShowRoomDetalleType') = 0 
CREATE TYPE ShowRoom.OfertaShowRoomDetalleType AS TABLE(
	CUV varchar(20) NULL,
	NombreProducto varchar(150) NULL,
	Descripcion1 varchar(150) NULL,
	Descripcion2 varchar(150) NULL,
	Descripcion3 varchar(150) NULL,
	Posicion int NULL,
	MarcaProducto varchar(100) NULL
)

go

create procedure ShowRoom.InsertCargaMasivaOfertaDetalle
@OfertaShowRoomDetalle ShowRoom.OfertaShowRoomDetalleType readonly,
@CampaniaID int,
@UsuarioCreacion varchar(50)
as
begin

begin tran

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

delete from ShowRoom.OfertaShowRoomDetalle
	where OfertaShowRoomDetalleID not in (select o.OfertaShowRoomDetalleID from ShowRoom.OfertaShowRoomDetalle o
	inner join @OfertaShowRoomDetalle t on
	o.CUV = t.CUV
	and o.Posicion = t.Posicion)

update ShowRoom.OfertaShowRoomDetalle
set NombreProducto = t.NombreProducto,
	Descripcion1 = t.Descripcion1,
	Descripcion2 = t.Descripcion2,
	Descripcion3 = t.Descripcion3,
	UsuarioModificacion = @UsuarioCreacion,
	MarcaProducto = t.MarcaProducto
from ShowRoom.OfertaShowRoomDetalle o
inner join @OfertaShowRoomDetalle t on	
	o.CUV = t.CUV
	and o.Posicion = t.Posicion
	--and o.NombreProducto = t.NombreProducto
where
	o.CampaniaID = @CampaniaID	

insert into ShowRoom.OfertaShowRoomDetalle
(CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,FechaCreacion,UsuarioCreacion,
FechaModificacion,UsuarioModificacion,Posicion,MarcaProducto)
select @CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,getdate(),@UsuarioCreacion,
getdate(),@UsuarioCreacion,Posicion,MarcaProducto
from @OfertaShowRoomDetalle
where 
	NombreProducto not in (select NombreProducto from ShowRoom.OfertaShowRoomDetalle o where o.CampaniaID = @CampaniaID
		and o.CUV = CUV)

end

commit tran

IF (@@ERROR <> 0) BEGIN
PRINT 'Error Inesperado!'
    ROLLBACK TRAN
END

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[InsertCargarProductoCpc]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].InsertCargarProductoCpc
GO

IF (SELECT COUNT(*) FROM sys.table_types WHERE name = 'OfertaShowRoomCompraPorCompraType') = 1
	drop type ShowRoom.OfertaShowRoomCompraPorCompraType

go

go

IF (SELECT COUNT(*) FROM sys.table_types WHERE name = 'OfertaShowRoomCompraPorCompraType') = 0  
  CREATE TYPE ShowRoom.OfertaShowRoomCompraPorCompraType AS TABLE ( 
	CUV varchar(20), SAP varchar(12), Orden int, PrecioValorizado decimal(18,2)
  )
GO

create procedure ShowRoom.InsertCargarProductoCpc
@OfertaShowRoomCompraPorCompra ShowRoom.OfertaShowRoomCompraPorCompraType readonly,
@EventoID int,
@UsuarioCreacion varchar(50)
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

declare @tablaCuv table ( CUV varchar(6))
insert into @tablaCuv
select distinct CUV from ShowRoom.CompraPorCompra where EventoID = @EventoID

update ShowRoom.CompraPorCompra
set 
	Orden = o.Orden,
	PrecioValorizado = o.PrecioValorizado,
	UsuarioModificacion = @UsuarioCreacion,
	FechaModificacion = @FechaGeneral
from ShowRoom.CompraPorCompra cpc
inner join @OfertaShowRoomCompraPorCompra o on
	cpc.CUV = o.CUV
	and cpc.SAP = o.SAP
where cpc.EventoID = @EventoID

insert into ShowRoom.CompraPorCompra (EventoID, CUV, SAP, Orden, PrecioValorizado, 
FechaCreacion, FechaModificacion, UsuarioCreacion, UsuarioModificacion)
select 
	@EventoID, CUV, SAP, Orden, PrecioValorizado, 
	@FechaGeneral, @FechaGeneral, @UsuarioCreacion, @UsuarioCreacion
from @OfertaShowRoomCompraPorCompra
where CUV not in (
	select CUV from @tablaCuv
)

end

go

ALTER procedure ShowRoom.InsertShowRoomEvento
@EventoID int output,
@CampaniaID int,
@Nombre varchar(150),
@Tema varchar(150),
@DiasAntes int,
@DiasDespues int,
@NumeroPerfiles int,
@UsuarioCreacion varchar(20),
@TieneCategoria bit,
@TieneCompraXcompra bit
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

insert into ShowRoom.Evento
(CampaniaID, Nombre, Tema, DiasAntes, DiasDespues, NumeroPerfiles, 
FechaCreacion, UsuarioCreacion, FechaModificacion, UsuarioModificacion, Estado, TieneCategoria, TieneCompraXcompra)
values
(@CampaniaID, @Nombre, @Tema, @DiasAntes, @DiasDespues, @NumeroPerfiles,
@FechaGeneral, @UsuarioCreacion, @FechaGeneral, @UsuarioCreacion, 1, @TieneCategoria, @TieneCompraXcompra)

set @EventoID = @@IDENTITY

end

GO

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
@TieneCompraXcompra bit
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
	TieneCompraXcompra = @TieneCompraXcompra
where EventoID = @EventoID

end

go

alter procedure ShowRoom.GetShowRoomEventoByCampaniaID
@CampaniaID int
as
/*
ShowRoom.GetShowRoomEventoByCampaniaID 201705
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
	isnull(TieneCompraXcompra,0) as TieneCompraXcompra
from ShowRoom.Evento
where CampaniaID = @CampaniaID

end

go

ALTER procedure ShowRoom.InsertShowRoomCargarMasivaConsultora
@EventoConsultora ShowRoom.EventoConsultoraType readonly
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

INSERT INTO ShowRoom.EventoConsultora(EventoID, CampaniaID, CodigoConsultora, Segmento, MostrarPopup,
MostrarPopupVenta, FechaCreacion, UsuarioCreacion, FechaModificacion, UsuarioModificacion)
SELECT DISTINCT EventoID, CampaniaID, CodigoConsultora, Segmento, 1,
1, @FechaGeneral, UsuarioCreacion, @FechaGeneral, UsuarioCreacion
FROM @EventoConsultora

end

go

ALTER procedure ShowRoom.GetShowRoomConsultora
@CampaniaID int,
@CodigoConsultora varchar(20)
as
/*
ShowRoom.GetShowRoomConsultora 201704,'0193037'
*/
begin

select top 1
EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,MostrarPopup,
MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion
from ShowRoom.EventoConsultora
where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
order by FechaCreacion desc

end

go

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

go

ALTER procedure ShowRoom.GetProductosShowRoomDetalle
@CampaniaID int,
@CUV varchar(5)
as
/*
ShowRoom.GetProductosShowRoomDetalle 201705,'96248'
ShowRoom.GetProductosShowRoomDetalle 201705,'99008'
*/
begin

select top 3
	OfertaShowRoomDetalleID,
	CampaniaID,
	CUV,
	isnull(NombreProducto,'') as NombreProducto,
	isnull(Descripcion1,'') as Descripcion1,
	isnull(Descripcion2,'') as Descripcion2,
	isnull(Descripcion3,'') as Descripcion3,
	isnull(Imagen,'') as Imagen,
	FechaCreacion,
	UsuarioCreacion,
	FechaModificacion,
	UsuarioModificacion,
	Posicion,
	MarcaProducto
from ShowRoom.OfertaShowRoomDetalle
where 
	CampaniaID = @CampaniaID
	and CUV = @CUV

end

go

ALTER procedure ShowRoom.InsOfertaShowRoomDetalle
@CampaniaID int,
@CUV varchar(5),
@NombreProducto varchar(100),
@Descripcion1 varchar(150),
@Descripcion2 varchar(150),
@Descripcion3 varchar(150),
@Imagen varchar(150),
@UsuarioCreacion varchar(50),
@MarcaProducto varchar(100)
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

declare @Posicion int = 0
select @Posicion = max(Posicion) from ShowRoom.OfertaShowRoomDetalle
where 
	CampaniaID = @CampaniaID
	and CUV = @CUV

insert into ShowRoom.OfertaShowRoomDetalle
(CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,
Imagen,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,Posicion,MarcaProducto)
values
(@CampaniaID,@CUV,@NombreProducto,@Descripcion1,@Descripcion2,@Descripcion3,
@Imagen,@FechaGeneral,@UsuarioCreacion,@FechaGeneral,@UsuarioCreacion,@Posicion+1,@MarcaProducto)

end

go

ALTER procedure ShowRoom.UpdOfertaShowRoomDetalle
@OfertaShowRoomDetalleID int,
@CampaniaID int,
@CUV varchar(5),
@NombreProducto varchar(100),
@Descripcion1 varchar(150),
@Descripcion2 varchar(150),
@Descripcion3 varchar(150),
@Imagen varchar(150),
@UsuarioModificacion varchar(50),
@MarcaProducto varchar(100)
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

update ShowRoom.OfertaShowRoomDetalle
set
	NombreProducto = @NombreProducto,
	Descripcion1 = @Descripcion1,
	Descripcion2 = @Descripcion2,
	Descripcion3 = @Descripcion3,
	Imagen = @Imagen,
	UsuarioModificacion = @UsuarioModificacion,
	FechaModificacion = @FechaGeneral,
	MarcaProducto = @MarcaProducto
where
	OfertaShowRoomDetalleID = @OfertaShowRoomDetalleID
	and CampaniaID = @CampaniaID
	and CUV = @CUV

end

go


ALTER PROCEDURE dbo.InsPedidoWebDetalleOferta_SB2
	@CampaniaID int,
	@ConsultoraID int,
	@MarcaID tinyint,
	@Cantidad int,
	@PrecioUnidad money,
	@CUV varchar(20),
	@ConfiguracionOfertaID INT,
	@TipoOfertaSisID INT,
	@PaisID int,
	@IPUsuario varchar(25) = null,
	@CodigoUsuarioCreacion varchar(25) = null,
	@OrigenPedidoWeb int = 0,
	@EsCompraPorCompra bit = 0
AS
BEGIN
DECLARE @PedidoDetalleID INT;
DECLARE @PedidoID  INT = 0;
DECLARE @OfertaWeb INT  = 1;
DECLARE @ExisteDet INT = 0;
DECLARE @Orden INT=0;

	EXEC [dbo].[InsPedidoWebOferta] @CampaniaID, @ConsultoraID , @PaisID, @IPUsuario, @CodigoUsuarioCreacion;

	if @TipoOfertaSisID = 1707
	begin
		set @OfertaWeb = 0
	end

	if @EsCompraPorCompra = 1
	begin
		set @OfertaWeb = 0
	end

	SELECT @PedidoID = PedidoID FROM dbo.PedidoWeb WHERE CampaniaID = @CampaniaID AND ConsultoraID = @ConsultoraID;

	SELECT @PedidoDetalleID = MAX(ISNULL(PedidoDetalleID,0))
		   , @Orden = max(ISNULL(OrdenPedidoWD,0))
		   FROM dbo.PedidoWebDetalle 
		   WHERE CampaniaID = @CampaniaID AND PedidoID = @PedidoID
	
	SET @PedidoDetalleID = ISNULL(@PedidoDetalleID, 0) + 1
	SET @Orden = ISNULL(@Orden, 0) + 1

	--SET @PedidoDetalleID =	(SELECT ISNULL(MAX(PedidoDetalleID),0) + 1 
	--							FROM	dbo.PedidoWebDetalle 
	--							WHERE	CampaniaID = @CampaniaID AND
	--									PedidoID = @PedidoID);

	/* Validar Al Agregar Nuevamente */
	set @ExisteDet = (select count(*) from PedidoWebDetalle 
						where CampaniaID = @CampaniaID 
							  AND PedidoID = @PedidoID
							  AND CUV = @CUV
							  AND ClienteID IS NULL);

	IF @ExisteDet = 0 
		BEGIN
			INSERT INTO dbo.PedidoWebDetalle 
			(
			 CampaniaID,
			 PedidoID,
			 PedidoDetalleID,
			 MarcaID,
			 ConsultoraID,
			 ClienteID,
			 Cantidad,
			 PrecioUnidad,
			 ImporteTotal,
			 CUV,
			 OfertaWeb, 
			 ModificaPedidoReservado,
			 ConfiguracionOfertaID,
			 TipoOfertaSisID,
			 CodigoUsuarioCreacion,
			 FechaCreacion,
			 OrdenPedidoWD,
			 OrigenPedidoWeb
			)

		VALUES (@CampaniaID,@PedidoID,@PedidoDetalleID,
				@MarcaID,@ConsultoraID,NULL,
				@Cantidad,@PrecioUnidad,@Cantidad*@PrecioUnidad,@CUV,@OfertaWeb,0, @ConfiguracionOfertaID, @TipoOfertaSisID,
				@CodigoUsuarioCreacion, dbo.fnObtenerFechaHoraPais(), @Orden, @OrigenPedidoWeb)
		END
	ELSE
		BEGIN
			UPDATE dbo.PedidoWebDetalle
				SET Cantidad += @Cantidad,
					ImporteTotal = ((Cantidad + @Cantidad) * @PrecioUnidad),
					CodigoUsuarioModificacion = @CodigoUsuarioCreacion,
					FechaModificacion = dbo.fnObtenerFechaHoraPais(),
					OrdenPedidoWD = @Orden,
					OrigenPedidoWeb = @OrigenPedidoWeb
			WHERE CampaniaID = @CampaniaID 
				  AND PedidoID = @PedidoID
				  AND CUV = @CUV
				  AND ClienteID IS NULL		
		END
END

GO

USE BelcorpChile
go

delete from dbo.TablaLogicaDatos where TablaLogicaID = 99
delete from dbo.TablaLogica where TablaLogicaID = 99

go

if not exists (select 1 from dbo.TablaLogica where TablaLogicaID = 99)
begin
	insert into dbo.TablaLogica(TablaLogicaID,Descripcion) values (99,'OrdenamientoShowRoom')
end

go

if not exists (select 1 from dbo.TablaLogicaDatos where TablaLogicaID = 99 and Codigo='01')
begin
	insert into dbo.TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) 
	values (9901,99,'01','Los más vendidos')
end

go

if not exists (select 1 from dbo.TablaLogicaDatos where TablaLogicaID = 99 and Codigo='02')
begin
	insert into dbo.TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) 
	values (9902,99,'02','Menor a mayor precio')
end

go

if not exists (select 1 from dbo.TablaLogicaDatos where TablaLogicaID = 99 and Codigo='03')
begin
	insert into dbo.TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) 
	values (9903,99,'03','Mayor a menor precio')
end

go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.Evento') and SYSCOLUMNS.NAME = N'TieneCategoria') = 0
	ALTER TABLE ShowRoom.Evento ADD TieneCategoria bit
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.Evento') and SYSCOLUMNS.NAME = N'TieneCompraXcompra') = 0
	ALTER TABLE ShowRoom.Evento ADD TieneCompraXcompra bit
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'CodigoCategoria') = 0
	ALTER TABLE ShowRoom.OfertaShowRoom ADD CodigoCategoria varchar(100)
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'TipNegocio') = 0
	ALTER TABLE ShowRoom.OfertaShowRoom ADD TipNegocio varchar(500)
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoomDetalle') and SYSCOLUMNS.NAME = N'MarcaProducto') = 0
	ALTER TABLE ShowRoom.OfertaShowRoomDetalle ADD MarcaProducto varchar(100)
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.EventoConsultora') and SYSCOLUMNS.NAME = N'MostrarPopupVenta') = 0
	ALTER TABLE ShowRoom.EventoConsultora ADD MostrarPopupVenta bit
go

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[Nivel]') AND (type = 'U') )
	DROP TABLE ShowRoom.Nivel
GO

create table ShowRoom.Nivel
(
	NivelId int identity(1,1) primary key,
	Codigo varchar(100),
	Descripcion varchar(100)
)

go

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[Personalizacion]') AND (type = 'U') )
	DROP TABLE ShowRoom.Personalizacion
GO

create table ShowRoom.Personalizacion
(
	PersonalizacionId int identity(1,1) primary key,
	TipoAplicacion varchar(20),
	Atributo varchar(100),
	TextoAyuda varchar(200),
	TipoAtributo varchar(20),
	TipoPersonalizacion varchar(20),
	Orden int,
	Estado bit
)

go

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[PersonalizacionNivel]') AND (type = 'U') )
	DROP TABLE ShowRoom.PersonalizacionNivel
GO

create table ShowRoom.PersonalizacionNivel
(
	PersonalizacionNivelId int identity(1,1) primary key,
	EventoID int,
	PersonalizacionId int,
	NivelId int,
	CategoriaId int,
	Valor varchar(200)
)

go

CREATE NONCLUSTERED INDEX IX_ShowRoomPersonalizacionNivel_EventoIdNivelId ON ShowRoom.PersonalizacionNivel (EventoID,NivelId);

go

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[Categoria]') AND (type = 'U') )
	DROP TABLE ShowRoom.Categoria
GO

create table ShowRoom.Categoria
(
	CategoriaId int identity(1,1) primary key,
	EventoID int,
	Codigo varchar(50),
	Descripcion varchar(200)
)

go

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[CompraPorCompra]') AND (type = 'U') )
	DROP TABLE ShowRoom.CompraPorCompra
GO

CREATE TABLE ShowRoom.CompraPorCompra
(
	CompraxCompraID int identity(1,1) primary key,
	EventoID int,
	CUV varchar(20),
	SAP varchar(12),
	Orden int,
	PrecioValorizado decimal(18,2),
	FechaCreacion datetime,
	UsuarioCreacion varchar(50),
	FechaModificacion datetime,
	UsuarioModificacion varchar(50)
)

GO

insert into ShowRoom.Nivel (Codigo,Descripcion) values ('PAIS','País')

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','PopupImagenIntriga','Popup Principal Intriga (615px x 409px)','IMAGEN','EVENTO',1,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','PopupImagenVenta','Popup Principal Venta (615px x 409px)','IMAGEN','EVENTO',2,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','BannerImagenIntriga','Visual Superior Intriga (1920px x 174px)','IMAGEN','EVENTO',3,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','BannerImagenVenta','Visual Superior Venta (1920px x 174px)','IMAGEN','EVENTO',4,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','UrlTerminosCondiciones','Link Terminos y Condiciones','TEXTO','EVENTO',5,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','TextoCondicionCompraCpc','Texto Condición de Compra por Compra','TEXTO','EVENTO',6,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','TextoDescripcionLegalCpc','Texto Descripción Legal Compra por Compra','TEXTO','EVENTO',7,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','IconoLluvia','Icono Lluvia Paginal Principal','IMAGEN','EVENTO',8,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','BannerEnvioCorreo','Imagen Envio Correo','IMAGEN','EVENTO',9,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','TextoEnvioCorreo','Texto mostrar Envio Correo','TEXTO','EVENTO',10,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','ImagenFondoProductPage','Imagen de Fondo del Product Page','IMAGEN','EVENTO',11,1)

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','TituloPrincipal','Título de la Categoria','TEXTO','CATEGORIA',12,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','ImagenPrincipal','Imagen a mostrar en la Categoria','IMAGEN','CATEGORIA',13,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','ColorFondo','Color de Fondo de la Categoria','TEXTO','CATEGORIA',14,1)

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','PopupImagenIntriga','Banner Marquesina Intriga (768px x 420px)','IMAGEN','EVENTO',1,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','PopupImagenVenta','Banner Marquesina Venta (768px x 420px)','IMAGEN','EVENTO',2,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','BannerImagenIntriga','Banner Superior Intriga (1024px x 60px)','IMAGEN','EVENTO',3,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','BannerImagenPaginaVenta','Banner Superior Pagina Venta (1024px x 60px)','IMAGEN','EVENTO',4,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','BannerImagenVenta','Banner Superior Venta Otras Paginas (1024px x 60px)','IMAGEN','EVENTO',5,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','UrlTerminosCondiciones','Link Terminos y Condiciones','TEXTO','EVENTO',6,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','TextoCondicionCompraCpc','Texto Condición de Compra','TEXTO','EVENTO',7,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','TextoDescripcionLegalCpc','Texto Descripción Legal Compra por Compra','TEXTO','EVENTO',8,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','ImagenFondoProductPage','Imagen de Fondo del Product Page','IMAGEN','EVENTO',9,1)

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','TituloPrincipal','Título de la Categoria','TEXTO','CATEGORIA',10,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','ColorFondo','Color de Fondo de la Categoria','TEXTO','CATEGORIA',11,1)

go

update ShowRoom.EventoConsultora set MostrarPopup = 1 where MostrarPopup is null
update ShowRoom.EventoConsultora set MostrarPopupVenta = 1 where MostrarPopupVenta is null

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomNivel]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomNivel
GO

create procedure ShowRoom.GetShowRoomNivel
as
/*
ShowRoom.GetShowRoomNivel
*/
begin

select
	NivelId,
	Codigo,
	Descripcion
from ShowRoom.Nivel

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomPersonalizacion]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomPersonalizacion
GO

create procedure ShowRoom.GetShowRoomPersonalizacion
as
/*
ShowRoom.GetShowRoomPersonalizacion
*/
begin

select
	PersonalizacionId,
	TipoAplicacion,
	Atributo,
	TextoAyuda,
	TipoAtributo,
	TipoPersonalizacion,
	Orden,
	Estado
from ShowRoom.Personalizacion

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomPersonalizacionNivel]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomPersonalizacionNivel
GO

create procedure ShowRoom.GetShowRoomPersonalizacionNivel
@EventoId int,
@NivelId int = 0,
@CategoriaId int = 0
as
/*
ShowRoom.GetShowRoomPersonalizacionNivel 2006,1,0
ShowRoom.GetShowRoomPersonalizacionNivel 2006,0,1
*/
begin

select 
	PersonalizacionNivelId,
	EventoID,
	PersonalizacionId,
	isnull(NivelId,0) as NivelId,
	isnull(CategoriaId,0) as CategoriaId,
	isnull(Valor,'') as Valor
from ShowRoom.PersonalizacionNivel
where
	EventoID = @EventoId
	and (@NivelId = 0 or NivelId = @NivelId)
	and (@CategoriaId = 0 or CategoriaId = @CategoriaId)

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[InsertShowRoomPersonalizacionNivel]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].InsertShowRoomPersonalizacionNivel
GO

create procedure ShowRoom.InsertShowRoomPersonalizacionNivel
@EventoID int,
@PersonalizacionId int,
@NivelId int,
@CategoriaId int = 0,
@Valor varchar(200)
as
begin

insert into ShowRoom.PersonalizacionNivel (EventoID, PersonalizacionId, NivelId, CategoriaId, Valor)
values (@EventoID, @PersonalizacionId, @NivelId, @CategoriaId, @Valor)

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[UpdateShowRoomPersonalizacionNivel]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].UpdateShowRoomPersonalizacionNivel
GO

create procedure ShowRoom.UpdateShowRoomPersonalizacionNivel
@PersonalizacionNivelId int,
@Valor varchar(200)
as
begin

update ShowRoom.PersonalizacionNivel
	set Valor = @Valor
where PersonalizacionNivelId = @PersonalizacionNivelId

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomCategorias]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomCategorias
GO

create procedure ShowRoom.GetShowRoomCategorias
@EventoId int
as
/*
ShowRoom.GetShowRoomCategorias 6
*/
begin

select
	CategoriaId,
	EventoID,
	Codigo,
	Descripcion
from ShowRoom.Categoria
where EventoID = @EventoId

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomCategoriaById]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomCategoriaById
GO

create procedure ShowRoom.GetShowRoomCategoriaById
@CategoriaId int
as
/*
ShowRoom.GetShowRoomCategoriaById 1
*/
begin

select
	CategoriaId,
	EventoID,
	Codigo,
	Descripcion
from ShowRoom.Categoria
where CategoriaId = @CategoriaId

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[UpdateShowRoomDescripcionCategoria]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].UpdateShowRoomDescripcionCategoria
GO

create procedure ShowRoom.UpdateShowRoomDescripcionCategoria
@CategoriaId int,
@Descripcion varchar(200)
as
begin

update ShowRoom.Categoria
set
	Descripcion = @Descripcion
where 
	CategoriaId = @CategoriaId

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[DeleteShowRoomCategoriaByEvento]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].DeleteShowRoomCategoriaByEvento
GO

create procedure ShowRoom.DeleteShowRoomCategoriaByEvento
@EventoId int
as
begin

delete from ShowRoom.PersonalizacionNivel where EventoID = @EventoId and NivelId = 0
delete from ShowRoom.Categoria where EventoId = @EventoID

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[InsertShowRoomCategoria]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].InsertShowRoomCategoria
GO

create procedure ShowRoom.InsertShowRoomCategoria
@EventoID int,
@Codigo varchar(50),
@Descripcion varchar(200)
as
begin

insert into ShowRoom.Categoria (EventoID, Codigo, Descripcion) values (@EventoID, @Codigo, @Descripcion)

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomCompraPorCompra]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomCompraPorCompra
GO

create procedure ShowRoom.GetShowRoomCompraPorCompra
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

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[UpdStockOfertaShowRoomMasivo]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].UpdStockOfertaShowRoomMasivo
GO

IF (SELECT COUNT(*) FROM sys.table_types WHERE name = 'StockPrecioOfertaShowRoomType') = 1
	drop type ShowRoom.StockPrecioOfertaShowRoomType

go

go

IF (SELECT COUNT(*) FROM sys.table_types WHERE name = 'StockPrecioOfertaShowRoomType') = 0  
  CREATE TYPE ShowRoom.StockPrecioOfertaShowRoomType AS TABLE ( 
	TipoOfertaSisID int, CampaniaID int, CUV varchar(20), Stock int, PrecioOferta decimal(18,2), UnidadesPermitidas int,
	Descripcion varchar(250), CodigoCategoria varchar(100), TipNegocio varchar(500)
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
	TipNegocio = t.TipNegocio
FROM ShowRoom.OfertaShowRoom o
INNER JOIN ods.Campania c on 
	c.CampaniaID = o.CampaniaID
JOIN @StockPrecioOfertaShowRoom t ON 
	c.Codigo = t.CampaniaID
	AND o.CUV = t.CUV
	AND o.TipoOfertaSisID = t.TipoOfertaSisID

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[InsertCargaMasivaOfertaDetalle]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].InsertCargaMasivaOfertaDetalle
GO

IF (SELECT COUNT(*) FROM sys.table_types WHERE name = 'OfertaShowRoomDetalleType') = 1
	drop type ShowRoom.OfertaShowRoomDetalleType

go

go

IF (SELECT COUNT(*) FROM sys.table_types WHERE name = 'OfertaShowRoomDetalleType') = 0 
CREATE TYPE ShowRoom.OfertaShowRoomDetalleType AS TABLE(
	CUV varchar(20) NULL,
	NombreProducto varchar(150) NULL,
	Descripcion1 varchar(150) NULL,
	Descripcion2 varchar(150) NULL,
	Descripcion3 varchar(150) NULL,
	Posicion int NULL,
	MarcaProducto varchar(100) NULL
)

go

create procedure ShowRoom.InsertCargaMasivaOfertaDetalle
@OfertaShowRoomDetalle ShowRoom.OfertaShowRoomDetalleType readonly,
@CampaniaID int,
@UsuarioCreacion varchar(50)
as
begin

begin tran

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

delete from ShowRoom.OfertaShowRoomDetalle
	where OfertaShowRoomDetalleID not in (select o.OfertaShowRoomDetalleID from ShowRoom.OfertaShowRoomDetalle o
	inner join @OfertaShowRoomDetalle t on
	o.CUV = t.CUV
	and o.Posicion = t.Posicion)

update ShowRoom.OfertaShowRoomDetalle
set NombreProducto = t.NombreProducto,
	Descripcion1 = t.Descripcion1,
	Descripcion2 = t.Descripcion2,
	Descripcion3 = t.Descripcion3,
	UsuarioModificacion = @UsuarioCreacion,
	MarcaProducto = t.MarcaProducto
from ShowRoom.OfertaShowRoomDetalle o
inner join @OfertaShowRoomDetalle t on	
	o.CUV = t.CUV
	and o.Posicion = t.Posicion
	--and o.NombreProducto = t.NombreProducto
where
	o.CampaniaID = @CampaniaID	

insert into ShowRoom.OfertaShowRoomDetalle
(CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,FechaCreacion,UsuarioCreacion,
FechaModificacion,UsuarioModificacion,Posicion,MarcaProducto)
select @CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,getdate(),@UsuarioCreacion,
getdate(),@UsuarioCreacion,Posicion,MarcaProducto
from @OfertaShowRoomDetalle
where 
	NombreProducto not in (select NombreProducto from ShowRoom.OfertaShowRoomDetalle o where o.CampaniaID = @CampaniaID
		and o.CUV = CUV)

end

commit tran

IF (@@ERROR <> 0) BEGIN
PRINT 'Error Inesperado!'
    ROLLBACK TRAN
END

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[InsertCargarProductoCpc]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].InsertCargarProductoCpc
GO

IF (SELECT COUNT(*) FROM sys.table_types WHERE name = 'OfertaShowRoomCompraPorCompraType') = 1
	drop type ShowRoom.OfertaShowRoomCompraPorCompraType

go

go

IF (SELECT COUNT(*) FROM sys.table_types WHERE name = 'OfertaShowRoomCompraPorCompraType') = 0  
  CREATE TYPE ShowRoom.OfertaShowRoomCompraPorCompraType AS TABLE ( 
	CUV varchar(20), SAP varchar(12), Orden int, PrecioValorizado decimal(18,2)
  )
GO

create procedure ShowRoom.InsertCargarProductoCpc
@OfertaShowRoomCompraPorCompra ShowRoom.OfertaShowRoomCompraPorCompraType readonly,
@EventoID int,
@UsuarioCreacion varchar(50)
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

declare @tablaCuv table ( CUV varchar(6))
insert into @tablaCuv
select distinct CUV from ShowRoom.CompraPorCompra where EventoID = @EventoID

update ShowRoom.CompraPorCompra
set 
	Orden = o.Orden,
	PrecioValorizado = o.PrecioValorizado,
	UsuarioModificacion = @UsuarioCreacion,
	FechaModificacion = @FechaGeneral
from ShowRoom.CompraPorCompra cpc
inner join @OfertaShowRoomCompraPorCompra o on
	cpc.CUV = o.CUV
	and cpc.SAP = o.SAP
where cpc.EventoID = @EventoID

insert into ShowRoom.CompraPorCompra (EventoID, CUV, SAP, Orden, PrecioValorizado, 
FechaCreacion, FechaModificacion, UsuarioCreacion, UsuarioModificacion)
select 
	@EventoID, CUV, SAP, Orden, PrecioValorizado, 
	@FechaGeneral, @FechaGeneral, @UsuarioCreacion, @UsuarioCreacion
from @OfertaShowRoomCompraPorCompra
where CUV not in (
	select CUV from @tablaCuv
)

end

go

ALTER procedure ShowRoom.InsertShowRoomEvento
@EventoID int output,
@CampaniaID int,
@Nombre varchar(150),
@Tema varchar(150),
@DiasAntes int,
@DiasDespues int,
@NumeroPerfiles int,
@UsuarioCreacion varchar(20),
@TieneCategoria bit,
@TieneCompraXcompra bit
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

insert into ShowRoom.Evento
(CampaniaID, Nombre, Tema, DiasAntes, DiasDespues, NumeroPerfiles, 
FechaCreacion, UsuarioCreacion, FechaModificacion, UsuarioModificacion, Estado, TieneCategoria, TieneCompraXcompra)
values
(@CampaniaID, @Nombre, @Tema, @DiasAntes, @DiasDespues, @NumeroPerfiles,
@FechaGeneral, @UsuarioCreacion, @FechaGeneral, @UsuarioCreacion, 1, @TieneCategoria, @TieneCompraXcompra)

set @EventoID = @@IDENTITY

end

GO

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
@TieneCompraXcompra bit
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
	TieneCompraXcompra = @TieneCompraXcompra
where EventoID = @EventoID

end

go

alter procedure ShowRoom.GetShowRoomEventoByCampaniaID
@CampaniaID int
as
/*
ShowRoom.GetShowRoomEventoByCampaniaID 201705
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
	isnull(TieneCompraXcompra,0) as TieneCompraXcompra
from ShowRoom.Evento
where CampaniaID = @CampaniaID

end

go

ALTER procedure ShowRoom.InsertShowRoomCargarMasivaConsultora
@EventoConsultora ShowRoom.EventoConsultoraType readonly
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

INSERT INTO ShowRoom.EventoConsultora(EventoID, CampaniaID, CodigoConsultora, Segmento, MostrarPopup,
MostrarPopupVenta, FechaCreacion, UsuarioCreacion, FechaModificacion, UsuarioModificacion)
SELECT DISTINCT EventoID, CampaniaID, CodigoConsultora, Segmento, 1,
1, @FechaGeneral, UsuarioCreacion, @FechaGeneral, UsuarioCreacion
FROM @EventoConsultora

end

go

ALTER procedure ShowRoom.GetShowRoomConsultora
@CampaniaID int,
@CodigoConsultora varchar(20)
as
/*
ShowRoom.GetShowRoomConsultora 201704,'0193037'
*/
begin

select top 1
EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,MostrarPopup,
MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion
from ShowRoom.EventoConsultora
where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
order by FechaCreacion desc

end

go

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

go

ALTER procedure ShowRoom.GetProductosShowRoomDetalle
@CampaniaID int,
@CUV varchar(5)
as
/*
ShowRoom.GetProductosShowRoomDetalle 201705,'96248'
ShowRoom.GetProductosShowRoomDetalle 201705,'99008'
*/
begin

select top 3
	OfertaShowRoomDetalleID,
	CampaniaID,
	CUV,
	isnull(NombreProducto,'') as NombreProducto,
	isnull(Descripcion1,'') as Descripcion1,
	isnull(Descripcion2,'') as Descripcion2,
	isnull(Descripcion3,'') as Descripcion3,
	isnull(Imagen,'') as Imagen,
	FechaCreacion,
	UsuarioCreacion,
	FechaModificacion,
	UsuarioModificacion,
	Posicion,
	MarcaProducto
from ShowRoom.OfertaShowRoomDetalle
where 
	CampaniaID = @CampaniaID
	and CUV = @CUV

end

go

ALTER procedure ShowRoom.InsOfertaShowRoomDetalle
@CampaniaID int,
@CUV varchar(5),
@NombreProducto varchar(100),
@Descripcion1 varchar(150),
@Descripcion2 varchar(150),
@Descripcion3 varchar(150),
@Imagen varchar(150),
@UsuarioCreacion varchar(50),
@MarcaProducto varchar(100)
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

declare @Posicion int = 0
select @Posicion = max(Posicion) from ShowRoom.OfertaShowRoomDetalle
where 
	CampaniaID = @CampaniaID
	and CUV = @CUV

insert into ShowRoom.OfertaShowRoomDetalle
(CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,
Imagen,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,Posicion,MarcaProducto)
values
(@CampaniaID,@CUV,@NombreProducto,@Descripcion1,@Descripcion2,@Descripcion3,
@Imagen,@FechaGeneral,@UsuarioCreacion,@FechaGeneral,@UsuarioCreacion,@Posicion+1,@MarcaProducto)

end

go

ALTER procedure ShowRoom.UpdOfertaShowRoomDetalle
@OfertaShowRoomDetalleID int,
@CampaniaID int,
@CUV varchar(5),
@NombreProducto varchar(100),
@Descripcion1 varchar(150),
@Descripcion2 varchar(150),
@Descripcion3 varchar(150),
@Imagen varchar(150),
@UsuarioModificacion varchar(50),
@MarcaProducto varchar(100)
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

update ShowRoom.OfertaShowRoomDetalle
set
	NombreProducto = @NombreProducto,
	Descripcion1 = @Descripcion1,
	Descripcion2 = @Descripcion2,
	Descripcion3 = @Descripcion3,
	Imagen = @Imagen,
	UsuarioModificacion = @UsuarioModificacion,
	FechaModificacion = @FechaGeneral,
	MarcaProducto = @MarcaProducto
where
	OfertaShowRoomDetalleID = @OfertaShowRoomDetalleID
	and CampaniaID = @CampaniaID
	and CUV = @CUV

end

go


ALTER PROCEDURE dbo.InsPedidoWebDetalleOferta_SB2
	@CampaniaID int,
	@ConsultoraID int,
	@MarcaID tinyint,
	@Cantidad int,
	@PrecioUnidad money,
	@CUV varchar(20),
	@ConfiguracionOfertaID INT,
	@TipoOfertaSisID INT,
	@PaisID int,
	@IPUsuario varchar(25) = null,
	@CodigoUsuarioCreacion varchar(25) = null,
	@OrigenPedidoWeb int = 0,
	@EsCompraPorCompra bit = 0
AS
BEGIN
DECLARE @PedidoDetalleID INT;
DECLARE @PedidoID  INT = 0;
DECLARE @OfertaWeb INT  = 1;
DECLARE @ExisteDet INT = 0;
DECLARE @Orden INT=0;

	EXEC [dbo].[InsPedidoWebOferta] @CampaniaID, @ConsultoraID , @PaisID, @IPUsuario, @CodigoUsuarioCreacion;

	if @TipoOfertaSisID = 1707
	begin
		set @OfertaWeb = 0
	end

	if @EsCompraPorCompra = 1
	begin
		set @OfertaWeb = 0
	end

	SELECT @PedidoID = PedidoID FROM dbo.PedidoWeb WHERE CampaniaID = @CampaniaID AND ConsultoraID = @ConsultoraID;

	SELECT @PedidoDetalleID = MAX(ISNULL(PedidoDetalleID,0))
		   , @Orden = max(ISNULL(OrdenPedidoWD,0))
		   FROM dbo.PedidoWebDetalle 
		   WHERE CampaniaID = @CampaniaID AND PedidoID = @PedidoID
	
	SET @PedidoDetalleID = ISNULL(@PedidoDetalleID, 0) + 1
	SET @Orden = ISNULL(@Orden, 0) + 1

	--SET @PedidoDetalleID =	(SELECT ISNULL(MAX(PedidoDetalleID),0) + 1 
	--							FROM	dbo.PedidoWebDetalle 
	--							WHERE	CampaniaID = @CampaniaID AND
	--									PedidoID = @PedidoID);

	/* Validar Al Agregar Nuevamente */
	set @ExisteDet = (select count(*) from PedidoWebDetalle 
						where CampaniaID = @CampaniaID 
							  AND PedidoID = @PedidoID
							  AND CUV = @CUV
							  AND ClienteID IS NULL);

	IF @ExisteDet = 0 
		BEGIN
			INSERT INTO dbo.PedidoWebDetalle 
			(
			 CampaniaID,
			 PedidoID,
			 PedidoDetalleID,
			 MarcaID,
			 ConsultoraID,
			 ClienteID,
			 Cantidad,
			 PrecioUnidad,
			 ImporteTotal,
			 CUV,
			 OfertaWeb, 
			 ModificaPedidoReservado,
			 ConfiguracionOfertaID,
			 TipoOfertaSisID,
			 CodigoUsuarioCreacion,
			 FechaCreacion,
			 OrdenPedidoWD,
			 OrigenPedidoWeb
			)

		VALUES (@CampaniaID,@PedidoID,@PedidoDetalleID,
				@MarcaID,@ConsultoraID,NULL,
				@Cantidad,@PrecioUnidad,@Cantidad*@PrecioUnidad,@CUV,@OfertaWeb,0, @ConfiguracionOfertaID, @TipoOfertaSisID,
				@CodigoUsuarioCreacion, dbo.fnObtenerFechaHoraPais(), @Orden, @OrigenPedidoWeb)
		END
	ELSE
		BEGIN
			UPDATE dbo.PedidoWebDetalle
				SET Cantidad += @Cantidad,
					ImporteTotal = ((Cantidad + @Cantidad) * @PrecioUnidad),
					CodigoUsuarioModificacion = @CodigoUsuarioCreacion,
					FechaModificacion = dbo.fnObtenerFechaHoraPais(),
					OrdenPedidoWD = @Orden,
					OrigenPedidoWeb = @OrigenPedidoWeb
			WHERE CampaniaID = @CampaniaID 
				  AND PedidoID = @PedidoID
				  AND CUV = @CUV
				  AND ClienteID IS NULL		
		END
END

GO

USE BelcorpColombia
go

delete from dbo.TablaLogicaDatos where TablaLogicaID = 99
delete from dbo.TablaLogica where TablaLogicaID = 99

go

if not exists (select 1 from dbo.TablaLogica where TablaLogicaID = 99)
begin
	insert into dbo.TablaLogica(TablaLogicaID,Descripcion) values (99,'OrdenamientoShowRoom')
end

go

if not exists (select 1 from dbo.TablaLogicaDatos where TablaLogicaID = 99 and Codigo='01')
begin
	insert into dbo.TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) 
	values (9901,99,'01','Los más vendidos')
end

go

if not exists (select 1 from dbo.TablaLogicaDatos where TablaLogicaID = 99 and Codigo='02')
begin
	insert into dbo.TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) 
	values (9902,99,'02','Menor a mayor precio')
end

go

if not exists (select 1 from dbo.TablaLogicaDatos where TablaLogicaID = 99 and Codigo='03')
begin
	insert into dbo.TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) 
	values (9903,99,'03','Mayor a menor precio')
end

go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.Evento') and SYSCOLUMNS.NAME = N'TieneCategoria') = 0
	ALTER TABLE ShowRoom.Evento ADD TieneCategoria bit
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.Evento') and SYSCOLUMNS.NAME = N'TieneCompraXcompra') = 0
	ALTER TABLE ShowRoom.Evento ADD TieneCompraXcompra bit
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'CodigoCategoria') = 0
	ALTER TABLE ShowRoom.OfertaShowRoom ADD CodigoCategoria varchar(100)
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'TipNegocio') = 0
	ALTER TABLE ShowRoom.OfertaShowRoom ADD TipNegocio varchar(500)
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoomDetalle') and SYSCOLUMNS.NAME = N'MarcaProducto') = 0
	ALTER TABLE ShowRoom.OfertaShowRoomDetalle ADD MarcaProducto varchar(100)
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.EventoConsultora') and SYSCOLUMNS.NAME = N'MostrarPopupVenta') = 0
	ALTER TABLE ShowRoom.EventoConsultora ADD MostrarPopupVenta bit
go

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[Nivel]') AND (type = 'U') )
	DROP TABLE ShowRoom.Nivel
GO

create table ShowRoom.Nivel
(
	NivelId int identity(1,1) primary key,
	Codigo varchar(100),
	Descripcion varchar(100)
)

go

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[Personalizacion]') AND (type = 'U') )
	DROP TABLE ShowRoom.Personalizacion
GO

create table ShowRoom.Personalizacion
(
	PersonalizacionId int identity(1,1) primary key,
	TipoAplicacion varchar(20),
	Atributo varchar(100),
	TextoAyuda varchar(200),
	TipoAtributo varchar(20),
	TipoPersonalizacion varchar(20),
	Orden int,
	Estado bit
)

go

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[PersonalizacionNivel]') AND (type = 'U') )
	DROP TABLE ShowRoom.PersonalizacionNivel
GO

create table ShowRoom.PersonalizacionNivel
(
	PersonalizacionNivelId int identity(1,1) primary key,
	EventoID int,
	PersonalizacionId int,
	NivelId int,
	CategoriaId int,
	Valor varchar(200)
)

go

CREATE NONCLUSTERED INDEX IX_ShowRoomPersonalizacionNivel_EventoIdNivelId ON ShowRoom.PersonalizacionNivel (EventoID,NivelId);

go

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[Categoria]') AND (type = 'U') )
	DROP TABLE ShowRoom.Categoria
GO

create table ShowRoom.Categoria
(
	CategoriaId int identity(1,1) primary key,
	EventoID int,
	Codigo varchar(50),
	Descripcion varchar(200)
)

go

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[CompraPorCompra]') AND (type = 'U') )
	DROP TABLE ShowRoom.CompraPorCompra
GO

CREATE TABLE ShowRoom.CompraPorCompra
(
	CompraxCompraID int identity(1,1) primary key,
	EventoID int,
	CUV varchar(20),
	SAP varchar(12),
	Orden int,
	PrecioValorizado decimal(18,2),
	FechaCreacion datetime,
	UsuarioCreacion varchar(50),
	FechaModificacion datetime,
	UsuarioModificacion varchar(50)
)

GO

insert into ShowRoom.Nivel (Codigo,Descripcion) values ('PAIS','País')

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','PopupImagenIntriga','Popup Principal Intriga (615px x 409px)','IMAGEN','EVENTO',1,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','PopupImagenVenta','Popup Principal Venta (615px x 409px)','IMAGEN','EVENTO',2,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','BannerImagenIntriga','Visual Superior Intriga (1920px x 174px)','IMAGEN','EVENTO',3,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','BannerImagenVenta','Visual Superior Venta (1920px x 174px)','IMAGEN','EVENTO',4,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','UrlTerminosCondiciones','Link Terminos y Condiciones','TEXTO','EVENTO',5,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','TextoCondicionCompraCpc','Texto Condición de Compra por Compra','TEXTO','EVENTO',6,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','TextoDescripcionLegalCpc','Texto Descripción Legal Compra por Compra','TEXTO','EVENTO',7,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','IconoLluvia','Icono Lluvia Paginal Principal','IMAGEN','EVENTO',8,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','BannerEnvioCorreo','Imagen Envio Correo','IMAGEN','EVENTO',9,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','TextoEnvioCorreo','Texto mostrar Envio Correo','TEXTO','EVENTO',10,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','ImagenFondoProductPage','Imagen de Fondo del Product Page','IMAGEN','EVENTO',11,1)

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','TituloPrincipal','Título de la Categoria','TEXTO','CATEGORIA',12,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','ImagenPrincipal','Imagen a mostrar en la Categoria','IMAGEN','CATEGORIA',13,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','ColorFondo','Color de Fondo de la Categoria','TEXTO','CATEGORIA',14,1)

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','PopupImagenIntriga','Banner Marquesina Intriga (768px x 420px)','IMAGEN','EVENTO',1,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','PopupImagenVenta','Banner Marquesina Venta (768px x 420px)','IMAGEN','EVENTO',2,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','BannerImagenIntriga','Banner Superior Intriga (1024px x 60px)','IMAGEN','EVENTO',3,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','BannerImagenPaginaVenta','Banner Superior Pagina Venta (1024px x 60px)','IMAGEN','EVENTO',4,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','BannerImagenVenta','Banner Superior Venta Otras Paginas (1024px x 60px)','IMAGEN','EVENTO',5,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','UrlTerminosCondiciones','Link Terminos y Condiciones','TEXTO','EVENTO',6,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','TextoCondicionCompraCpc','Texto Condición de Compra','TEXTO','EVENTO',7,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','TextoDescripcionLegalCpc','Texto Descripción Legal Compra por Compra','TEXTO','EVENTO',8,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','ImagenFondoProductPage','Imagen de Fondo del Product Page','IMAGEN','EVENTO',9,1)

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','TituloPrincipal','Título de la Categoria','TEXTO','CATEGORIA',10,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','ColorFondo','Color de Fondo de la Categoria','TEXTO','CATEGORIA',11,1)

go

update ShowRoom.EventoConsultora set MostrarPopup = 1 where MostrarPopup is null
update ShowRoom.EventoConsultora set MostrarPopupVenta = 1 where MostrarPopupVenta is null

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomNivel]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomNivel
GO

create procedure ShowRoom.GetShowRoomNivel
as
/*
ShowRoom.GetShowRoomNivel
*/
begin

select
	NivelId,
	Codigo,
	Descripcion
from ShowRoom.Nivel

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomPersonalizacion]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomPersonalizacion
GO

create procedure ShowRoom.GetShowRoomPersonalizacion
as
/*
ShowRoom.GetShowRoomPersonalizacion
*/
begin

select
	PersonalizacionId,
	TipoAplicacion,
	Atributo,
	TextoAyuda,
	TipoAtributo,
	TipoPersonalizacion,
	Orden,
	Estado
from ShowRoom.Personalizacion

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomPersonalizacionNivel]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomPersonalizacionNivel
GO

create procedure ShowRoom.GetShowRoomPersonalizacionNivel
@EventoId int,
@NivelId int = 0,
@CategoriaId int = 0
as
/*
ShowRoom.GetShowRoomPersonalizacionNivel 2006,1,0
ShowRoom.GetShowRoomPersonalizacionNivel 2006,0,1
*/
begin

select 
	PersonalizacionNivelId,
	EventoID,
	PersonalizacionId,
	isnull(NivelId,0) as NivelId,
	isnull(CategoriaId,0) as CategoriaId,
	isnull(Valor,'') as Valor
from ShowRoom.PersonalizacionNivel
where
	EventoID = @EventoId
	and (@NivelId = 0 or NivelId = @NivelId)
	and (@CategoriaId = 0 or CategoriaId = @CategoriaId)

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[InsertShowRoomPersonalizacionNivel]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].InsertShowRoomPersonalizacionNivel
GO

create procedure ShowRoom.InsertShowRoomPersonalizacionNivel
@EventoID int,
@PersonalizacionId int,
@NivelId int,
@CategoriaId int = 0,
@Valor varchar(200)
as
begin

insert into ShowRoom.PersonalizacionNivel (EventoID, PersonalizacionId, NivelId, CategoriaId, Valor)
values (@EventoID, @PersonalizacionId, @NivelId, @CategoriaId, @Valor)

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[UpdateShowRoomPersonalizacionNivel]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].UpdateShowRoomPersonalizacionNivel
GO

create procedure ShowRoom.UpdateShowRoomPersonalizacionNivel
@PersonalizacionNivelId int,
@Valor varchar(200)
as
begin

update ShowRoom.PersonalizacionNivel
	set Valor = @Valor
where PersonalizacionNivelId = @PersonalizacionNivelId

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomCategorias]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomCategorias
GO

create procedure ShowRoom.GetShowRoomCategorias
@EventoId int
as
/*
ShowRoom.GetShowRoomCategorias 6
*/
begin

select
	CategoriaId,
	EventoID,
	Codigo,
	Descripcion
from ShowRoom.Categoria
where EventoID = @EventoId

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomCategoriaById]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomCategoriaById
GO

create procedure ShowRoom.GetShowRoomCategoriaById
@CategoriaId int
as
/*
ShowRoom.GetShowRoomCategoriaById 1
*/
begin

select
	CategoriaId,
	EventoID,
	Codigo,
	Descripcion
from ShowRoom.Categoria
where CategoriaId = @CategoriaId

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[UpdateShowRoomDescripcionCategoria]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].UpdateShowRoomDescripcionCategoria
GO

create procedure ShowRoom.UpdateShowRoomDescripcionCategoria
@CategoriaId int,
@Descripcion varchar(200)
as
begin

update ShowRoom.Categoria
set
	Descripcion = @Descripcion
where 
	CategoriaId = @CategoriaId

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[DeleteShowRoomCategoriaByEvento]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].DeleteShowRoomCategoriaByEvento
GO

create procedure ShowRoom.DeleteShowRoomCategoriaByEvento
@EventoId int
as
begin

delete from ShowRoom.PersonalizacionNivel where EventoID = @EventoId and NivelId = 0
delete from ShowRoom.Categoria where EventoId = @EventoID

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[InsertShowRoomCategoria]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].InsertShowRoomCategoria
GO

create procedure ShowRoom.InsertShowRoomCategoria
@EventoID int,
@Codigo varchar(50),
@Descripcion varchar(200)
as
begin

insert into ShowRoom.Categoria (EventoID, Codigo, Descripcion) values (@EventoID, @Codigo, @Descripcion)

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomCompraPorCompra]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomCompraPorCompra
GO

create procedure ShowRoom.GetShowRoomCompraPorCompra
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

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[UpdStockOfertaShowRoomMasivo]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].UpdStockOfertaShowRoomMasivo
GO

IF (SELECT COUNT(*) FROM sys.table_types WHERE name = 'StockPrecioOfertaShowRoomType') = 1
	drop type ShowRoom.StockPrecioOfertaShowRoomType

go

go

IF (SELECT COUNT(*) FROM sys.table_types WHERE name = 'StockPrecioOfertaShowRoomType') = 0  
  CREATE TYPE ShowRoom.StockPrecioOfertaShowRoomType AS TABLE ( 
	TipoOfertaSisID int, CampaniaID int, CUV varchar(20), Stock int, PrecioOferta decimal(18,2), UnidadesPermitidas int,
	Descripcion varchar(250), CodigoCategoria varchar(100), TipNegocio varchar(500)
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
	TipNegocio = t.TipNegocio
FROM ShowRoom.OfertaShowRoom o
INNER JOIN ods.Campania c on 
	c.CampaniaID = o.CampaniaID
JOIN @StockPrecioOfertaShowRoom t ON 
	c.Codigo = t.CampaniaID
	AND o.CUV = t.CUV
	AND o.TipoOfertaSisID = t.TipoOfertaSisID

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[InsertCargaMasivaOfertaDetalle]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].InsertCargaMasivaOfertaDetalle
GO

IF (SELECT COUNT(*) FROM sys.table_types WHERE name = 'OfertaShowRoomDetalleType') = 1
	drop type ShowRoom.OfertaShowRoomDetalleType

go

go

IF (SELECT COUNT(*) FROM sys.table_types WHERE name = 'OfertaShowRoomDetalleType') = 0 
CREATE TYPE ShowRoom.OfertaShowRoomDetalleType AS TABLE(
	CUV varchar(20) NULL,
	NombreProducto varchar(150) NULL,
	Descripcion1 varchar(150) NULL,
	Descripcion2 varchar(150) NULL,
	Descripcion3 varchar(150) NULL,
	Posicion int NULL,
	MarcaProducto varchar(100) NULL
)

go

create procedure ShowRoom.InsertCargaMasivaOfertaDetalle
@OfertaShowRoomDetalle ShowRoom.OfertaShowRoomDetalleType readonly,
@CampaniaID int,
@UsuarioCreacion varchar(50)
as
begin

begin tran

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

delete from ShowRoom.OfertaShowRoomDetalle
	where OfertaShowRoomDetalleID not in (select o.OfertaShowRoomDetalleID from ShowRoom.OfertaShowRoomDetalle o
	inner join @OfertaShowRoomDetalle t on
	o.CUV = t.CUV
	and o.Posicion = t.Posicion)

update ShowRoom.OfertaShowRoomDetalle
set NombreProducto = t.NombreProducto,
	Descripcion1 = t.Descripcion1,
	Descripcion2 = t.Descripcion2,
	Descripcion3 = t.Descripcion3,
	UsuarioModificacion = @UsuarioCreacion,
	MarcaProducto = t.MarcaProducto
from ShowRoom.OfertaShowRoomDetalle o
inner join @OfertaShowRoomDetalle t on	
	o.CUV = t.CUV
	and o.Posicion = t.Posicion
	--and o.NombreProducto = t.NombreProducto
where
	o.CampaniaID = @CampaniaID	

insert into ShowRoom.OfertaShowRoomDetalle
(CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,FechaCreacion,UsuarioCreacion,
FechaModificacion,UsuarioModificacion,Posicion,MarcaProducto)
select @CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,getdate(),@UsuarioCreacion,
getdate(),@UsuarioCreacion,Posicion,MarcaProducto
from @OfertaShowRoomDetalle
where 
	NombreProducto not in (select NombreProducto from ShowRoom.OfertaShowRoomDetalle o where o.CampaniaID = @CampaniaID
		and o.CUV = CUV)

end

commit tran

IF (@@ERROR <> 0) BEGIN
PRINT 'Error Inesperado!'
    ROLLBACK TRAN
END

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[InsertCargarProductoCpc]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].InsertCargarProductoCpc
GO

IF (SELECT COUNT(*) FROM sys.table_types WHERE name = 'OfertaShowRoomCompraPorCompraType') = 1
	drop type ShowRoom.OfertaShowRoomCompraPorCompraType

go

go

IF (SELECT COUNT(*) FROM sys.table_types WHERE name = 'OfertaShowRoomCompraPorCompraType') = 0  
  CREATE TYPE ShowRoom.OfertaShowRoomCompraPorCompraType AS TABLE ( 
	CUV varchar(20), SAP varchar(12), Orden int, PrecioValorizado decimal(18,2)
  )
GO

create procedure ShowRoom.InsertCargarProductoCpc
@OfertaShowRoomCompraPorCompra ShowRoom.OfertaShowRoomCompraPorCompraType readonly,
@EventoID int,
@UsuarioCreacion varchar(50)
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

declare @tablaCuv table ( CUV varchar(6))
insert into @tablaCuv
select distinct CUV from ShowRoom.CompraPorCompra where EventoID = @EventoID

update ShowRoom.CompraPorCompra
set 
	Orden = o.Orden,
	PrecioValorizado = o.PrecioValorizado,
	UsuarioModificacion = @UsuarioCreacion,
	FechaModificacion = @FechaGeneral
from ShowRoom.CompraPorCompra cpc
inner join @OfertaShowRoomCompraPorCompra o on
	cpc.CUV = o.CUV
	and cpc.SAP = o.SAP
where cpc.EventoID = @EventoID

insert into ShowRoom.CompraPorCompra (EventoID, CUV, SAP, Orden, PrecioValorizado, 
FechaCreacion, FechaModificacion, UsuarioCreacion, UsuarioModificacion)
select 
	@EventoID, CUV, SAP, Orden, PrecioValorizado, 
	@FechaGeneral, @FechaGeneral, @UsuarioCreacion, @UsuarioCreacion
from @OfertaShowRoomCompraPorCompra
where CUV not in (
	select CUV from @tablaCuv
)

end

go

ALTER procedure ShowRoom.InsertShowRoomEvento
@EventoID int output,
@CampaniaID int,
@Nombre varchar(150),
@Tema varchar(150),
@DiasAntes int,
@DiasDespues int,
@NumeroPerfiles int,
@UsuarioCreacion varchar(20),
@TieneCategoria bit,
@TieneCompraXcompra bit
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

insert into ShowRoom.Evento
(CampaniaID, Nombre, Tema, DiasAntes, DiasDespues, NumeroPerfiles, 
FechaCreacion, UsuarioCreacion, FechaModificacion, UsuarioModificacion, Estado, TieneCategoria, TieneCompraXcompra)
values
(@CampaniaID, @Nombre, @Tema, @DiasAntes, @DiasDespues, @NumeroPerfiles,
@FechaGeneral, @UsuarioCreacion, @FechaGeneral, @UsuarioCreacion, 1, @TieneCategoria, @TieneCompraXcompra)

set @EventoID = @@IDENTITY

end

GO

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
@TieneCompraXcompra bit
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
	TieneCompraXcompra = @TieneCompraXcompra
where EventoID = @EventoID

end

go

alter procedure ShowRoom.GetShowRoomEventoByCampaniaID
@CampaniaID int
as
/*
ShowRoom.GetShowRoomEventoByCampaniaID 201705
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
	isnull(TieneCompraXcompra,0) as TieneCompraXcompra
from ShowRoom.Evento
where CampaniaID = @CampaniaID

end

go

ALTER procedure ShowRoom.InsertShowRoomCargarMasivaConsultora
@EventoConsultora ShowRoom.EventoConsultoraType readonly
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

INSERT INTO ShowRoom.EventoConsultora(EventoID, CampaniaID, CodigoConsultora, Segmento, MostrarPopup,
MostrarPopupVenta, FechaCreacion, UsuarioCreacion, FechaModificacion, UsuarioModificacion)
SELECT DISTINCT EventoID, CampaniaID, CodigoConsultora, Segmento, 1,
1, @FechaGeneral, UsuarioCreacion, @FechaGeneral, UsuarioCreacion
FROM @EventoConsultora

end

go

ALTER procedure ShowRoom.GetShowRoomConsultora
@CampaniaID int,
@CodigoConsultora varchar(20)
as
/*
ShowRoom.GetShowRoomConsultora 201704,'0193037'
*/
begin

select top 1
EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,MostrarPopup,
MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion
from ShowRoom.EventoConsultora
where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
order by FechaCreacion desc

end

go

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

go

ALTER procedure ShowRoom.GetProductosShowRoomDetalle
@CampaniaID int,
@CUV varchar(5)
as
/*
ShowRoom.GetProductosShowRoomDetalle 201705,'96248'
ShowRoom.GetProductosShowRoomDetalle 201705,'99008'
*/
begin

select top 3
	OfertaShowRoomDetalleID,
	CampaniaID,
	CUV,
	isnull(NombreProducto,'') as NombreProducto,
	isnull(Descripcion1,'') as Descripcion1,
	isnull(Descripcion2,'') as Descripcion2,
	isnull(Descripcion3,'') as Descripcion3,
	isnull(Imagen,'') as Imagen,
	FechaCreacion,
	UsuarioCreacion,
	FechaModificacion,
	UsuarioModificacion,
	Posicion,
	MarcaProducto
from ShowRoom.OfertaShowRoomDetalle
where 
	CampaniaID = @CampaniaID
	and CUV = @CUV

end

go

ALTER procedure ShowRoom.InsOfertaShowRoomDetalle
@CampaniaID int,
@CUV varchar(5),
@NombreProducto varchar(100),
@Descripcion1 varchar(150),
@Descripcion2 varchar(150),
@Descripcion3 varchar(150),
@Imagen varchar(150),
@UsuarioCreacion varchar(50),
@MarcaProducto varchar(100)
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

declare @Posicion int = 0
select @Posicion = max(Posicion) from ShowRoom.OfertaShowRoomDetalle
where 
	CampaniaID = @CampaniaID
	and CUV = @CUV

insert into ShowRoom.OfertaShowRoomDetalle
(CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,
Imagen,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,Posicion,MarcaProducto)
values
(@CampaniaID,@CUV,@NombreProducto,@Descripcion1,@Descripcion2,@Descripcion3,
@Imagen,@FechaGeneral,@UsuarioCreacion,@FechaGeneral,@UsuarioCreacion,@Posicion+1,@MarcaProducto)

end

go

ALTER procedure ShowRoom.UpdOfertaShowRoomDetalle
@OfertaShowRoomDetalleID int,
@CampaniaID int,
@CUV varchar(5),
@NombreProducto varchar(100),
@Descripcion1 varchar(150),
@Descripcion2 varchar(150),
@Descripcion3 varchar(150),
@Imagen varchar(150),
@UsuarioModificacion varchar(50),
@MarcaProducto varchar(100)
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

update ShowRoom.OfertaShowRoomDetalle
set
	NombreProducto = @NombreProducto,
	Descripcion1 = @Descripcion1,
	Descripcion2 = @Descripcion2,
	Descripcion3 = @Descripcion3,
	Imagen = @Imagen,
	UsuarioModificacion = @UsuarioModificacion,
	FechaModificacion = @FechaGeneral,
	MarcaProducto = @MarcaProducto
where
	OfertaShowRoomDetalleID = @OfertaShowRoomDetalleID
	and CampaniaID = @CampaniaID
	and CUV = @CUV

end

go


ALTER PROCEDURE dbo.InsPedidoWebDetalleOferta_SB2
	@CampaniaID int,
	@ConsultoraID int,
	@MarcaID tinyint,
	@Cantidad int,
	@PrecioUnidad money,
	@CUV varchar(20),
	@ConfiguracionOfertaID INT,
	@TipoOfertaSisID INT,
	@PaisID int,
	@IPUsuario varchar(25) = null,
	@CodigoUsuarioCreacion varchar(25) = null,
	@OrigenPedidoWeb int = 0,
	@EsCompraPorCompra bit = 0
AS
BEGIN
DECLARE @PedidoDetalleID INT;
DECLARE @PedidoID  INT = 0;
DECLARE @OfertaWeb INT  = 1;
DECLARE @ExisteDet INT = 0;
DECLARE @Orden INT=0;

	EXEC [dbo].[InsPedidoWebOferta] @CampaniaID, @ConsultoraID , @PaisID, @IPUsuario, @CodigoUsuarioCreacion;

	if @TipoOfertaSisID = 1707
	begin
		set @OfertaWeb = 0
	end

	if @EsCompraPorCompra = 1
	begin
		set @OfertaWeb = 0
	end

	SELECT @PedidoID = PedidoID FROM dbo.PedidoWeb WHERE CampaniaID = @CampaniaID AND ConsultoraID = @ConsultoraID;

	SELECT @PedidoDetalleID = MAX(ISNULL(PedidoDetalleID,0))
		   , @Orden = max(ISNULL(OrdenPedidoWD,0))
		   FROM dbo.PedidoWebDetalle 
		   WHERE CampaniaID = @CampaniaID AND PedidoID = @PedidoID
	
	SET @PedidoDetalleID = ISNULL(@PedidoDetalleID, 0) + 1
	SET @Orden = ISNULL(@Orden, 0) + 1

	--SET @PedidoDetalleID =	(SELECT ISNULL(MAX(PedidoDetalleID),0) + 1 
	--							FROM	dbo.PedidoWebDetalle 
	--							WHERE	CampaniaID = @CampaniaID AND
	--									PedidoID = @PedidoID);

	/* Validar Al Agregar Nuevamente */
	set @ExisteDet = (select count(*) from PedidoWebDetalle 
						where CampaniaID = @CampaniaID 
							  AND PedidoID = @PedidoID
							  AND CUV = @CUV
							  AND ClienteID IS NULL);

	IF @ExisteDet = 0 
		BEGIN
			INSERT INTO dbo.PedidoWebDetalle 
			(
			 CampaniaID,
			 PedidoID,
			 PedidoDetalleID,
			 MarcaID,
			 ConsultoraID,
			 ClienteID,
			 Cantidad,
			 PrecioUnidad,
			 ImporteTotal,
			 CUV,
			 OfertaWeb, 
			 ModificaPedidoReservado,
			 ConfiguracionOfertaID,
			 TipoOfertaSisID,
			 CodigoUsuarioCreacion,
			 FechaCreacion,
			 OrdenPedidoWD,
			 OrigenPedidoWeb
			)

		VALUES (@CampaniaID,@PedidoID,@PedidoDetalleID,
				@MarcaID,@ConsultoraID,NULL,
				@Cantidad,@PrecioUnidad,@Cantidad*@PrecioUnidad,@CUV,@OfertaWeb,0, @ConfiguracionOfertaID, @TipoOfertaSisID,
				@CodigoUsuarioCreacion, dbo.fnObtenerFechaHoraPais(), @Orden, @OrigenPedidoWeb)
		END
	ELSE
		BEGIN
			UPDATE dbo.PedidoWebDetalle
				SET Cantidad += @Cantidad,
					ImporteTotal = ((Cantidad + @Cantidad) * @PrecioUnidad),
					CodigoUsuarioModificacion = @CodigoUsuarioCreacion,
					FechaModificacion = dbo.fnObtenerFechaHoraPais(),
					OrdenPedidoWD = @Orden,
					OrigenPedidoWeb = @OrigenPedidoWeb
			WHERE CampaniaID = @CampaniaID 
				  AND PedidoID = @PedidoID
				  AND CUV = @CUV
				  AND ClienteID IS NULL		
		END
END

GO

USE BelcorpCostaRica
go

delete from dbo.TablaLogicaDatos where TablaLogicaID = 99
delete from dbo.TablaLogica where TablaLogicaID = 99

go

if not exists (select 1 from dbo.TablaLogica where TablaLogicaID = 99)
begin
	insert into dbo.TablaLogica(TablaLogicaID,Descripcion) values (99,'OrdenamientoShowRoom')
end

go

if not exists (select 1 from dbo.TablaLogicaDatos where TablaLogicaID = 99 and Codigo='01')
begin
	insert into dbo.TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) 
	values (9901,99,'01','Los más vendidos')
end

go

if not exists (select 1 from dbo.TablaLogicaDatos where TablaLogicaID = 99 and Codigo='02')
begin
	insert into dbo.TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) 
	values (9902,99,'02','Menor a mayor precio')
end

go

if not exists (select 1 from dbo.TablaLogicaDatos where TablaLogicaID = 99 and Codigo='03')
begin
	insert into dbo.TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) 
	values (9903,99,'03','Mayor a menor precio')
end

go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.Evento') and SYSCOLUMNS.NAME = N'TieneCategoria') = 0
	ALTER TABLE ShowRoom.Evento ADD TieneCategoria bit
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.Evento') and SYSCOLUMNS.NAME = N'TieneCompraXcompra') = 0
	ALTER TABLE ShowRoom.Evento ADD TieneCompraXcompra bit
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'CodigoCategoria') = 0
	ALTER TABLE ShowRoom.OfertaShowRoom ADD CodigoCategoria varchar(100)
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'TipNegocio') = 0
	ALTER TABLE ShowRoom.OfertaShowRoom ADD TipNegocio varchar(500)
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoomDetalle') and SYSCOLUMNS.NAME = N'MarcaProducto') = 0
	ALTER TABLE ShowRoom.OfertaShowRoomDetalle ADD MarcaProducto varchar(100)
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.EventoConsultora') and SYSCOLUMNS.NAME = N'MostrarPopupVenta') = 0
	ALTER TABLE ShowRoom.EventoConsultora ADD MostrarPopupVenta bit
go

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[Nivel]') AND (type = 'U') )
	DROP TABLE ShowRoom.Nivel
GO

create table ShowRoom.Nivel
(
	NivelId int identity(1,1) primary key,
	Codigo varchar(100),
	Descripcion varchar(100)
)

go

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[Personalizacion]') AND (type = 'U') )
	DROP TABLE ShowRoom.Personalizacion
GO

create table ShowRoom.Personalizacion
(
	PersonalizacionId int identity(1,1) primary key,
	TipoAplicacion varchar(20),
	Atributo varchar(100),
	TextoAyuda varchar(200),
	TipoAtributo varchar(20),
	TipoPersonalizacion varchar(20),
	Orden int,
	Estado bit
)

go

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[PersonalizacionNivel]') AND (type = 'U') )
	DROP TABLE ShowRoom.PersonalizacionNivel
GO

create table ShowRoom.PersonalizacionNivel
(
	PersonalizacionNivelId int identity(1,1) primary key,
	EventoID int,
	PersonalizacionId int,
	NivelId int,
	CategoriaId int,
	Valor varchar(200)
)

go

CREATE NONCLUSTERED INDEX IX_ShowRoomPersonalizacionNivel_EventoIdNivelId ON ShowRoom.PersonalizacionNivel (EventoID,NivelId);

go

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[Categoria]') AND (type = 'U') )
	DROP TABLE ShowRoom.Categoria
GO

create table ShowRoom.Categoria
(
	CategoriaId int identity(1,1) primary key,
	EventoID int,
	Codigo varchar(50),
	Descripcion varchar(200)
)

go

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[CompraPorCompra]') AND (type = 'U') )
	DROP TABLE ShowRoom.CompraPorCompra
GO

CREATE TABLE ShowRoom.CompraPorCompra
(
	CompraxCompraID int identity(1,1) primary key,
	EventoID int,
	CUV varchar(20),
	SAP varchar(12),
	Orden int,
	PrecioValorizado decimal(18,2),
	FechaCreacion datetime,
	UsuarioCreacion varchar(50),
	FechaModificacion datetime,
	UsuarioModificacion varchar(50)
)

GO

insert into ShowRoom.Nivel (Codigo,Descripcion) values ('PAIS','País')

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','PopupImagenIntriga','Popup Principal Intriga (615px x 409px)','IMAGEN','EVENTO',1,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','PopupImagenVenta','Popup Principal Venta (615px x 409px)','IMAGEN','EVENTO',2,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','BannerImagenIntriga','Visual Superior Intriga (1920px x 174px)','IMAGEN','EVENTO',3,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','BannerImagenVenta','Visual Superior Venta (1920px x 174px)','IMAGEN','EVENTO',4,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','UrlTerminosCondiciones','Link Terminos y Condiciones','TEXTO','EVENTO',5,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','TextoCondicionCompraCpc','Texto Condición de Compra por Compra','TEXTO','EVENTO',6,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','TextoDescripcionLegalCpc','Texto Descripción Legal Compra por Compra','TEXTO','EVENTO',7,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','IconoLluvia','Icono Lluvia Paginal Principal','IMAGEN','EVENTO',8,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','BannerEnvioCorreo','Imagen Envio Correo','IMAGEN','EVENTO',9,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','TextoEnvioCorreo','Texto mostrar Envio Correo','TEXTO','EVENTO',10,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','ImagenFondoProductPage','Imagen de Fondo del Product Page','IMAGEN','EVENTO',11,1)

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','TituloPrincipal','Título de la Categoria','TEXTO','CATEGORIA',12,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','ImagenPrincipal','Imagen a mostrar en la Categoria','IMAGEN','CATEGORIA',13,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','ColorFondo','Color de Fondo de la Categoria','TEXTO','CATEGORIA',14,1)

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','PopupImagenIntriga','Banner Marquesina Intriga (768px x 420px)','IMAGEN','EVENTO',1,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','PopupImagenVenta','Banner Marquesina Venta (768px x 420px)','IMAGEN','EVENTO',2,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','BannerImagenIntriga','Banner Superior Intriga (1024px x 60px)','IMAGEN','EVENTO',3,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','BannerImagenPaginaVenta','Banner Superior Pagina Venta (1024px x 60px)','IMAGEN','EVENTO',4,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','BannerImagenVenta','Banner Superior Venta Otras Paginas (1024px x 60px)','IMAGEN','EVENTO',5,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','UrlTerminosCondiciones','Link Terminos y Condiciones','TEXTO','EVENTO',6,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','TextoCondicionCompraCpc','Texto Condición de Compra','TEXTO','EVENTO',7,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','TextoDescripcionLegalCpc','Texto Descripción Legal Compra por Compra','TEXTO','EVENTO',8,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','ImagenFondoProductPage','Imagen de Fondo del Product Page','IMAGEN','EVENTO',9,1)

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','TituloPrincipal','Título de la Categoria','TEXTO','CATEGORIA',10,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','ColorFondo','Color de Fondo de la Categoria','TEXTO','CATEGORIA',11,1)

go

update ShowRoom.EventoConsultora set MostrarPopup = 1 where MostrarPopup is null
update ShowRoom.EventoConsultora set MostrarPopupVenta = 1 where MostrarPopupVenta is null

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomNivel]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomNivel
GO

create procedure ShowRoom.GetShowRoomNivel
as
/*
ShowRoom.GetShowRoomNivel
*/
begin

select
	NivelId,
	Codigo,
	Descripcion
from ShowRoom.Nivel

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomPersonalizacion]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomPersonalizacion
GO

create procedure ShowRoom.GetShowRoomPersonalizacion
as
/*
ShowRoom.GetShowRoomPersonalizacion
*/
begin

select
	PersonalizacionId,
	TipoAplicacion,
	Atributo,
	TextoAyuda,
	TipoAtributo,
	TipoPersonalizacion,
	Orden,
	Estado
from ShowRoom.Personalizacion

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomPersonalizacionNivel]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomPersonalizacionNivel
GO

create procedure ShowRoom.GetShowRoomPersonalizacionNivel
@EventoId int,
@NivelId int = 0,
@CategoriaId int = 0
as
/*
ShowRoom.GetShowRoomPersonalizacionNivel 2006,1,0
ShowRoom.GetShowRoomPersonalizacionNivel 2006,0,1
*/
begin

select 
	PersonalizacionNivelId,
	EventoID,
	PersonalizacionId,
	isnull(NivelId,0) as NivelId,
	isnull(CategoriaId,0) as CategoriaId,
	isnull(Valor,'') as Valor
from ShowRoom.PersonalizacionNivel
where
	EventoID = @EventoId
	and (@NivelId = 0 or NivelId = @NivelId)
	and (@CategoriaId = 0 or CategoriaId = @CategoriaId)

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[InsertShowRoomPersonalizacionNivel]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].InsertShowRoomPersonalizacionNivel
GO

create procedure ShowRoom.InsertShowRoomPersonalizacionNivel
@EventoID int,
@PersonalizacionId int,
@NivelId int,
@CategoriaId int = 0,
@Valor varchar(200)
as
begin

insert into ShowRoom.PersonalizacionNivel (EventoID, PersonalizacionId, NivelId, CategoriaId, Valor)
values (@EventoID, @PersonalizacionId, @NivelId, @CategoriaId, @Valor)

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[UpdateShowRoomPersonalizacionNivel]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].UpdateShowRoomPersonalizacionNivel
GO

create procedure ShowRoom.UpdateShowRoomPersonalizacionNivel
@PersonalizacionNivelId int,
@Valor varchar(200)
as
begin

update ShowRoom.PersonalizacionNivel
	set Valor = @Valor
where PersonalizacionNivelId = @PersonalizacionNivelId

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomCategorias]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomCategorias
GO

create procedure ShowRoom.GetShowRoomCategorias
@EventoId int
as
/*
ShowRoom.GetShowRoomCategorias 6
*/
begin

select
	CategoriaId,
	EventoID,
	Codigo,
	Descripcion
from ShowRoom.Categoria
where EventoID = @EventoId

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomCategoriaById]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomCategoriaById
GO

create procedure ShowRoom.GetShowRoomCategoriaById
@CategoriaId int
as
/*
ShowRoom.GetShowRoomCategoriaById 1
*/
begin

select
	CategoriaId,
	EventoID,
	Codigo,
	Descripcion
from ShowRoom.Categoria
where CategoriaId = @CategoriaId

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[UpdateShowRoomDescripcionCategoria]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].UpdateShowRoomDescripcionCategoria
GO

create procedure ShowRoom.UpdateShowRoomDescripcionCategoria
@CategoriaId int,
@Descripcion varchar(200)
as
begin

update ShowRoom.Categoria
set
	Descripcion = @Descripcion
where 
	CategoriaId = @CategoriaId

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[DeleteShowRoomCategoriaByEvento]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].DeleteShowRoomCategoriaByEvento
GO

create procedure ShowRoom.DeleteShowRoomCategoriaByEvento
@EventoId int
as
begin

delete from ShowRoom.PersonalizacionNivel where EventoID = @EventoId and NivelId = 0
delete from ShowRoom.Categoria where EventoId = @EventoID

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[InsertShowRoomCategoria]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].InsertShowRoomCategoria
GO

create procedure ShowRoom.InsertShowRoomCategoria
@EventoID int,
@Codigo varchar(50),
@Descripcion varchar(200)
as
begin

insert into ShowRoom.Categoria (EventoID, Codigo, Descripcion) values (@EventoID, @Codigo, @Descripcion)

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomCompraPorCompra]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomCompraPorCompra
GO

create procedure ShowRoom.GetShowRoomCompraPorCompra
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

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[UpdStockOfertaShowRoomMasivo]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].UpdStockOfertaShowRoomMasivo
GO

IF (SELECT COUNT(*) FROM sys.table_types WHERE name = 'StockPrecioOfertaShowRoomType') = 1
	drop type ShowRoom.StockPrecioOfertaShowRoomType

go

go

IF (SELECT COUNT(*) FROM sys.table_types WHERE name = 'StockPrecioOfertaShowRoomType') = 0  
  CREATE TYPE ShowRoom.StockPrecioOfertaShowRoomType AS TABLE ( 
	TipoOfertaSisID int, CampaniaID int, CUV varchar(20), Stock int, PrecioOferta decimal(18,2), UnidadesPermitidas int,
	Descripcion varchar(250), CodigoCategoria varchar(100), TipNegocio varchar(500)
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
	TipNegocio = t.TipNegocio
FROM ShowRoom.OfertaShowRoom o
INNER JOIN ods.Campania c on 
	c.CampaniaID = o.CampaniaID
JOIN @StockPrecioOfertaShowRoom t ON 
	c.Codigo = t.CampaniaID
	AND o.CUV = t.CUV
	AND o.TipoOfertaSisID = t.TipoOfertaSisID

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[InsertCargaMasivaOfertaDetalle]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].InsertCargaMasivaOfertaDetalle
GO

IF (SELECT COUNT(*) FROM sys.table_types WHERE name = 'OfertaShowRoomDetalleType') = 1
	drop type ShowRoom.OfertaShowRoomDetalleType

go

go

IF (SELECT COUNT(*) FROM sys.table_types WHERE name = 'OfertaShowRoomDetalleType') = 0 
CREATE TYPE ShowRoom.OfertaShowRoomDetalleType AS TABLE(
	CUV varchar(20) NULL,
	NombreProducto varchar(150) NULL,
	Descripcion1 varchar(150) NULL,
	Descripcion2 varchar(150) NULL,
	Descripcion3 varchar(150) NULL,
	Posicion int NULL,
	MarcaProducto varchar(100) NULL
)

go

create procedure ShowRoom.InsertCargaMasivaOfertaDetalle
@OfertaShowRoomDetalle ShowRoom.OfertaShowRoomDetalleType readonly,
@CampaniaID int,
@UsuarioCreacion varchar(50)
as
begin

begin tran

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

delete from ShowRoom.OfertaShowRoomDetalle
	where OfertaShowRoomDetalleID not in (select o.OfertaShowRoomDetalleID from ShowRoom.OfertaShowRoomDetalle o
	inner join @OfertaShowRoomDetalle t on
	o.CUV = t.CUV
	and o.Posicion = t.Posicion)

update ShowRoom.OfertaShowRoomDetalle
set NombreProducto = t.NombreProducto,
	Descripcion1 = t.Descripcion1,
	Descripcion2 = t.Descripcion2,
	Descripcion3 = t.Descripcion3,
	UsuarioModificacion = @UsuarioCreacion,
	MarcaProducto = t.MarcaProducto
from ShowRoom.OfertaShowRoomDetalle o
inner join @OfertaShowRoomDetalle t on	
	o.CUV = t.CUV
	and o.Posicion = t.Posicion
	--and o.NombreProducto = t.NombreProducto
where
	o.CampaniaID = @CampaniaID	

insert into ShowRoom.OfertaShowRoomDetalle
(CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,FechaCreacion,UsuarioCreacion,
FechaModificacion,UsuarioModificacion,Posicion,MarcaProducto)
select @CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,getdate(),@UsuarioCreacion,
getdate(),@UsuarioCreacion,Posicion,MarcaProducto
from @OfertaShowRoomDetalle
where 
	NombreProducto not in (select NombreProducto from ShowRoom.OfertaShowRoomDetalle o where o.CampaniaID = @CampaniaID
		and o.CUV = CUV)

end

commit tran

IF (@@ERROR <> 0) BEGIN
PRINT 'Error Inesperado!'
    ROLLBACK TRAN
END

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[InsertCargarProductoCpc]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].InsertCargarProductoCpc
GO

IF (SELECT COUNT(*) FROM sys.table_types WHERE name = 'OfertaShowRoomCompraPorCompraType') = 1
	drop type ShowRoom.OfertaShowRoomCompraPorCompraType

go

go

IF (SELECT COUNT(*) FROM sys.table_types WHERE name = 'OfertaShowRoomCompraPorCompraType') = 0  
  CREATE TYPE ShowRoom.OfertaShowRoomCompraPorCompraType AS TABLE ( 
	CUV varchar(20), SAP varchar(12), Orden int, PrecioValorizado decimal(18,2)
  )
GO

create procedure ShowRoom.InsertCargarProductoCpc
@OfertaShowRoomCompraPorCompra ShowRoom.OfertaShowRoomCompraPorCompraType readonly,
@EventoID int,
@UsuarioCreacion varchar(50)
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

declare @tablaCuv table ( CUV varchar(6))
insert into @tablaCuv
select distinct CUV from ShowRoom.CompraPorCompra where EventoID = @EventoID

update ShowRoom.CompraPorCompra
set 
	Orden = o.Orden,
	PrecioValorizado = o.PrecioValorizado,
	UsuarioModificacion = @UsuarioCreacion,
	FechaModificacion = @FechaGeneral
from ShowRoom.CompraPorCompra cpc
inner join @OfertaShowRoomCompraPorCompra o on
	cpc.CUV = o.CUV
	and cpc.SAP = o.SAP
where cpc.EventoID = @EventoID

insert into ShowRoom.CompraPorCompra (EventoID, CUV, SAP, Orden, PrecioValorizado, 
FechaCreacion, FechaModificacion, UsuarioCreacion, UsuarioModificacion)
select 
	@EventoID, CUV, SAP, Orden, PrecioValorizado, 
	@FechaGeneral, @FechaGeneral, @UsuarioCreacion, @UsuarioCreacion
from @OfertaShowRoomCompraPorCompra
where CUV not in (
	select CUV from @tablaCuv
)

end

go

ALTER procedure ShowRoom.InsertShowRoomEvento
@EventoID int output,
@CampaniaID int,
@Nombre varchar(150),
@Tema varchar(150),
@DiasAntes int,
@DiasDespues int,
@NumeroPerfiles int,
@UsuarioCreacion varchar(20),
@TieneCategoria bit,
@TieneCompraXcompra bit
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

insert into ShowRoom.Evento
(CampaniaID, Nombre, Tema, DiasAntes, DiasDespues, NumeroPerfiles, 
FechaCreacion, UsuarioCreacion, FechaModificacion, UsuarioModificacion, Estado, TieneCategoria, TieneCompraXcompra)
values
(@CampaniaID, @Nombre, @Tema, @DiasAntes, @DiasDespues, @NumeroPerfiles,
@FechaGeneral, @UsuarioCreacion, @FechaGeneral, @UsuarioCreacion, 1, @TieneCategoria, @TieneCompraXcompra)

set @EventoID = @@IDENTITY

end

GO

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
@TieneCompraXcompra bit
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
	TieneCompraXcompra = @TieneCompraXcompra
where EventoID = @EventoID

end

go

alter procedure ShowRoom.GetShowRoomEventoByCampaniaID
@CampaniaID int
as
/*
ShowRoom.GetShowRoomEventoByCampaniaID 201705
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
	isnull(TieneCompraXcompra,0) as TieneCompraXcompra
from ShowRoom.Evento
where CampaniaID = @CampaniaID

end

go

ALTER procedure ShowRoom.InsertShowRoomCargarMasivaConsultora
@EventoConsultora ShowRoom.EventoConsultoraType readonly
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

INSERT INTO ShowRoom.EventoConsultora(EventoID, CampaniaID, CodigoConsultora, Segmento, MostrarPopup,
MostrarPopupVenta, FechaCreacion, UsuarioCreacion, FechaModificacion, UsuarioModificacion)
SELECT DISTINCT EventoID, CampaniaID, CodigoConsultora, Segmento, 1,
1, @FechaGeneral, UsuarioCreacion, @FechaGeneral, UsuarioCreacion
FROM @EventoConsultora

end

go

ALTER procedure ShowRoom.GetShowRoomConsultora
@CampaniaID int,
@CodigoConsultora varchar(20)
as
/*
ShowRoom.GetShowRoomConsultora 201704,'0193037'
*/
begin

select top 1
EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,MostrarPopup,
MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion
from ShowRoom.EventoConsultora
where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
order by FechaCreacion desc

end

go

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

go

ALTER procedure ShowRoom.GetProductosShowRoomDetalle
@CampaniaID int,
@CUV varchar(5)
as
/*
ShowRoom.GetProductosShowRoomDetalle 201705,'96248'
ShowRoom.GetProductosShowRoomDetalle 201705,'99008'
*/
begin

select top 3
	OfertaShowRoomDetalleID,
	CampaniaID,
	CUV,
	isnull(NombreProducto,'') as NombreProducto,
	isnull(Descripcion1,'') as Descripcion1,
	isnull(Descripcion2,'') as Descripcion2,
	isnull(Descripcion3,'') as Descripcion3,
	isnull(Imagen,'') as Imagen,
	FechaCreacion,
	UsuarioCreacion,
	FechaModificacion,
	UsuarioModificacion,
	Posicion,
	MarcaProducto
from ShowRoom.OfertaShowRoomDetalle
where 
	CampaniaID = @CampaniaID
	and CUV = @CUV

end

go

ALTER procedure ShowRoom.InsOfertaShowRoomDetalle
@CampaniaID int,
@CUV varchar(5),
@NombreProducto varchar(100),
@Descripcion1 varchar(150),
@Descripcion2 varchar(150),
@Descripcion3 varchar(150),
@Imagen varchar(150),
@UsuarioCreacion varchar(50),
@MarcaProducto varchar(100)
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

declare @Posicion int = 0
select @Posicion = max(Posicion) from ShowRoom.OfertaShowRoomDetalle
where 
	CampaniaID = @CampaniaID
	and CUV = @CUV

insert into ShowRoom.OfertaShowRoomDetalle
(CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,
Imagen,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,Posicion,MarcaProducto)
values
(@CampaniaID,@CUV,@NombreProducto,@Descripcion1,@Descripcion2,@Descripcion3,
@Imagen,@FechaGeneral,@UsuarioCreacion,@FechaGeneral,@UsuarioCreacion,@Posicion+1,@MarcaProducto)

end

go

ALTER procedure ShowRoom.UpdOfertaShowRoomDetalle
@OfertaShowRoomDetalleID int,
@CampaniaID int,
@CUV varchar(5),
@NombreProducto varchar(100),
@Descripcion1 varchar(150),
@Descripcion2 varchar(150),
@Descripcion3 varchar(150),
@Imagen varchar(150),
@UsuarioModificacion varchar(50),
@MarcaProducto varchar(100)
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

update ShowRoom.OfertaShowRoomDetalle
set
	NombreProducto = @NombreProducto,
	Descripcion1 = @Descripcion1,
	Descripcion2 = @Descripcion2,
	Descripcion3 = @Descripcion3,
	Imagen = @Imagen,
	UsuarioModificacion = @UsuarioModificacion,
	FechaModificacion = @FechaGeneral,
	MarcaProducto = @MarcaProducto
where
	OfertaShowRoomDetalleID = @OfertaShowRoomDetalleID
	and CampaniaID = @CampaniaID
	and CUV = @CUV

end

go


ALTER PROCEDURE dbo.InsPedidoWebDetalleOferta_SB2
	@CampaniaID int,
	@ConsultoraID int,
	@MarcaID tinyint,
	@Cantidad int,
	@PrecioUnidad money,
	@CUV varchar(20),
	@ConfiguracionOfertaID INT,
	@TipoOfertaSisID INT,
	@PaisID int,
	@IPUsuario varchar(25) = null,
	@CodigoUsuarioCreacion varchar(25) = null,
	@OrigenPedidoWeb int = 0,
	@EsCompraPorCompra bit = 0
AS
BEGIN
DECLARE @PedidoDetalleID INT;
DECLARE @PedidoID  INT = 0;
DECLARE @OfertaWeb INT  = 1;
DECLARE @ExisteDet INT = 0;
DECLARE @Orden INT=0;

	EXEC [dbo].[InsPedidoWebOferta] @CampaniaID, @ConsultoraID , @PaisID, @IPUsuario, @CodigoUsuarioCreacion;

	if @TipoOfertaSisID = 1707
	begin
		set @OfertaWeb = 0
	end

	if @EsCompraPorCompra = 1
	begin
		set @OfertaWeb = 0
	end

	SELECT @PedidoID = PedidoID FROM dbo.PedidoWeb WHERE CampaniaID = @CampaniaID AND ConsultoraID = @ConsultoraID;

	SELECT @PedidoDetalleID = MAX(ISNULL(PedidoDetalleID,0))
		   , @Orden = max(ISNULL(OrdenPedidoWD,0))
		   FROM dbo.PedidoWebDetalle 
		   WHERE CampaniaID = @CampaniaID AND PedidoID = @PedidoID
	
	SET @PedidoDetalleID = ISNULL(@PedidoDetalleID, 0) + 1
	SET @Orden = ISNULL(@Orden, 0) + 1

	--SET @PedidoDetalleID =	(SELECT ISNULL(MAX(PedidoDetalleID),0) + 1 
	--							FROM	dbo.PedidoWebDetalle 
	--							WHERE	CampaniaID = @CampaniaID AND
	--									PedidoID = @PedidoID);

	/* Validar Al Agregar Nuevamente */
	set @ExisteDet = (select count(*) from PedidoWebDetalle 
						where CampaniaID = @CampaniaID 
							  AND PedidoID = @PedidoID
							  AND CUV = @CUV
							  AND ClienteID IS NULL);

	IF @ExisteDet = 0 
		BEGIN
			INSERT INTO dbo.PedidoWebDetalle 
			(
			 CampaniaID,
			 PedidoID,
			 PedidoDetalleID,
			 MarcaID,
			 ConsultoraID,
			 ClienteID,
			 Cantidad,
			 PrecioUnidad,
			 ImporteTotal,
			 CUV,
			 OfertaWeb, 
			 ModificaPedidoReservado,
			 ConfiguracionOfertaID,
			 TipoOfertaSisID,
			 CodigoUsuarioCreacion,
			 FechaCreacion,
			 OrdenPedidoWD,
			 OrigenPedidoWeb
			)

		VALUES (@CampaniaID,@PedidoID,@PedidoDetalleID,
				@MarcaID,@ConsultoraID,NULL,
				@Cantidad,@PrecioUnidad,@Cantidad*@PrecioUnidad,@CUV,@OfertaWeb,0, @ConfiguracionOfertaID, @TipoOfertaSisID,
				@CodigoUsuarioCreacion, dbo.fnObtenerFechaHoraPais(), @Orden, @OrigenPedidoWeb)
		END
	ELSE
		BEGIN
			UPDATE dbo.PedidoWebDetalle
				SET Cantidad += @Cantidad,
					ImporteTotal = ((Cantidad + @Cantidad) * @PrecioUnidad),
					CodigoUsuarioModificacion = @CodigoUsuarioCreacion,
					FechaModificacion = dbo.fnObtenerFechaHoraPais(),
					OrdenPedidoWD = @Orden,
					OrigenPedidoWeb = @OrigenPedidoWeb
			WHERE CampaniaID = @CampaniaID 
				  AND PedidoID = @PedidoID
				  AND CUV = @CUV
				  AND ClienteID IS NULL		
		END
END

GO

USE BelcorpDominicana
go

delete from dbo.TablaLogicaDatos where TablaLogicaID = 99
delete from dbo.TablaLogica where TablaLogicaID = 99

go

if not exists (select 1 from dbo.TablaLogica where TablaLogicaID = 99)
begin
	insert into dbo.TablaLogica(TablaLogicaID,Descripcion) values (99,'OrdenamientoShowRoom')
end

go

if not exists (select 1 from dbo.TablaLogicaDatos where TablaLogicaID = 99 and Codigo='01')
begin
	insert into dbo.TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) 
	values (9901,99,'01','Los más vendidos')
end

go

if not exists (select 1 from dbo.TablaLogicaDatos where TablaLogicaID = 99 and Codigo='02')
begin
	insert into dbo.TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) 
	values (9902,99,'02','Menor a mayor precio')
end

go

if not exists (select 1 from dbo.TablaLogicaDatos where TablaLogicaID = 99 and Codigo='03')
begin
	insert into dbo.TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) 
	values (9903,99,'03','Mayor a menor precio')
end

go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.Evento') and SYSCOLUMNS.NAME = N'TieneCategoria') = 0
	ALTER TABLE ShowRoom.Evento ADD TieneCategoria bit
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.Evento') and SYSCOLUMNS.NAME = N'TieneCompraXcompra') = 0
	ALTER TABLE ShowRoom.Evento ADD TieneCompraXcompra bit
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'CodigoCategoria') = 0
	ALTER TABLE ShowRoom.OfertaShowRoom ADD CodigoCategoria varchar(100)
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'TipNegocio') = 0
	ALTER TABLE ShowRoom.OfertaShowRoom ADD TipNegocio varchar(500)
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoomDetalle') and SYSCOLUMNS.NAME = N'MarcaProducto') = 0
	ALTER TABLE ShowRoom.OfertaShowRoomDetalle ADD MarcaProducto varchar(100)
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.EventoConsultora') and SYSCOLUMNS.NAME = N'MostrarPopupVenta') = 0
	ALTER TABLE ShowRoom.EventoConsultora ADD MostrarPopupVenta bit
go

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[Nivel]') AND (type = 'U') )
	DROP TABLE ShowRoom.Nivel
GO

create table ShowRoom.Nivel
(
	NivelId int identity(1,1) primary key,
	Codigo varchar(100),
	Descripcion varchar(100)
)

go

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[Personalizacion]') AND (type = 'U') )
	DROP TABLE ShowRoom.Personalizacion
GO

create table ShowRoom.Personalizacion
(
	PersonalizacionId int identity(1,1) primary key,
	TipoAplicacion varchar(20),
	Atributo varchar(100),
	TextoAyuda varchar(200),
	TipoAtributo varchar(20),
	TipoPersonalizacion varchar(20),
	Orden int,
	Estado bit
)

go

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[PersonalizacionNivel]') AND (type = 'U') )
	DROP TABLE ShowRoom.PersonalizacionNivel
GO

create table ShowRoom.PersonalizacionNivel
(
	PersonalizacionNivelId int identity(1,1) primary key,
	EventoID int,
	PersonalizacionId int,
	NivelId int,
	CategoriaId int,
	Valor varchar(200)
)

go

CREATE NONCLUSTERED INDEX IX_ShowRoomPersonalizacionNivel_EventoIdNivelId ON ShowRoom.PersonalizacionNivel (EventoID,NivelId);

go

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[Categoria]') AND (type = 'U') )
	DROP TABLE ShowRoom.Categoria
GO

create table ShowRoom.Categoria
(
	CategoriaId int identity(1,1) primary key,
	EventoID int,
	Codigo varchar(50),
	Descripcion varchar(200)
)

go

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[CompraPorCompra]') AND (type = 'U') )
	DROP TABLE ShowRoom.CompraPorCompra
GO

CREATE TABLE ShowRoom.CompraPorCompra
(
	CompraxCompraID int identity(1,1) primary key,
	EventoID int,
	CUV varchar(20),
	SAP varchar(12),
	Orden int,
	PrecioValorizado decimal(18,2),
	FechaCreacion datetime,
	UsuarioCreacion varchar(50),
	FechaModificacion datetime,
	UsuarioModificacion varchar(50)
)

GO

insert into ShowRoom.Nivel (Codigo,Descripcion) values ('PAIS','País')

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','PopupImagenIntriga','Popup Principal Intriga (615px x 409px)','IMAGEN','EVENTO',1,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','PopupImagenVenta','Popup Principal Venta (615px x 409px)','IMAGEN','EVENTO',2,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','BannerImagenIntriga','Visual Superior Intriga (1920px x 174px)','IMAGEN','EVENTO',3,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','BannerImagenVenta','Visual Superior Venta (1920px x 174px)','IMAGEN','EVENTO',4,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','UrlTerminosCondiciones','Link Terminos y Condiciones','TEXTO','EVENTO',5,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','TextoCondicionCompraCpc','Texto Condición de Compra por Compra','TEXTO','EVENTO',6,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','TextoDescripcionLegalCpc','Texto Descripción Legal Compra por Compra','TEXTO','EVENTO',7,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','IconoLluvia','Icono Lluvia Paginal Principal','IMAGEN','EVENTO',8,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','BannerEnvioCorreo','Imagen Envio Correo','IMAGEN','EVENTO',9,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','TextoEnvioCorreo','Texto mostrar Envio Correo','TEXTO','EVENTO',10,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','ImagenFondoProductPage','Imagen de Fondo del Product Page','IMAGEN','EVENTO',11,1)

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','TituloPrincipal','Título de la Categoria','TEXTO','CATEGORIA',12,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','ImagenPrincipal','Imagen a mostrar en la Categoria','IMAGEN','CATEGORIA',13,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','ColorFondo','Color de Fondo de la Categoria','TEXTO','CATEGORIA',14,1)

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','PopupImagenIntriga','Banner Marquesina Intriga (768px x 420px)','IMAGEN','EVENTO',1,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','PopupImagenVenta','Banner Marquesina Venta (768px x 420px)','IMAGEN','EVENTO',2,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','BannerImagenIntriga','Banner Superior Intriga (1024px x 60px)','IMAGEN','EVENTO',3,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','BannerImagenPaginaVenta','Banner Superior Pagina Venta (1024px x 60px)','IMAGEN','EVENTO',4,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','BannerImagenVenta','Banner Superior Venta Otras Paginas (1024px x 60px)','IMAGEN','EVENTO',5,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','UrlTerminosCondiciones','Link Terminos y Condiciones','TEXTO','EVENTO',6,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','TextoCondicionCompraCpc','Texto Condición de Compra','TEXTO','EVENTO',7,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','TextoDescripcionLegalCpc','Texto Descripción Legal Compra por Compra','TEXTO','EVENTO',8,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','ImagenFondoProductPage','Imagen de Fondo del Product Page','IMAGEN','EVENTO',9,1)

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','TituloPrincipal','Título de la Categoria','TEXTO','CATEGORIA',10,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','ColorFondo','Color de Fondo de la Categoria','TEXTO','CATEGORIA',11,1)

go

update ShowRoom.EventoConsultora set MostrarPopup = 1 where MostrarPopup is null
update ShowRoom.EventoConsultora set MostrarPopupVenta = 1 where MostrarPopupVenta is null

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomNivel]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomNivel
GO

create procedure ShowRoom.GetShowRoomNivel
as
/*
ShowRoom.GetShowRoomNivel
*/
begin

select
	NivelId,
	Codigo,
	Descripcion
from ShowRoom.Nivel

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomPersonalizacion]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomPersonalizacion
GO

create procedure ShowRoom.GetShowRoomPersonalizacion
as
/*
ShowRoom.GetShowRoomPersonalizacion
*/
begin

select
	PersonalizacionId,
	TipoAplicacion,
	Atributo,
	TextoAyuda,
	TipoAtributo,
	TipoPersonalizacion,
	Orden,
	Estado
from ShowRoom.Personalizacion

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomPersonalizacionNivel]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomPersonalizacionNivel
GO

create procedure ShowRoom.GetShowRoomPersonalizacionNivel
@EventoId int,
@NivelId int = 0,
@CategoriaId int = 0
as
/*
ShowRoom.GetShowRoomPersonalizacionNivel 2006,1,0
ShowRoom.GetShowRoomPersonalizacionNivel 2006,0,1
*/
begin

select 
	PersonalizacionNivelId,
	EventoID,
	PersonalizacionId,
	isnull(NivelId,0) as NivelId,
	isnull(CategoriaId,0) as CategoriaId,
	isnull(Valor,'') as Valor
from ShowRoom.PersonalizacionNivel
where
	EventoID = @EventoId
	and (@NivelId = 0 or NivelId = @NivelId)
	and (@CategoriaId = 0 or CategoriaId = @CategoriaId)

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[InsertShowRoomPersonalizacionNivel]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].InsertShowRoomPersonalizacionNivel
GO

create procedure ShowRoom.InsertShowRoomPersonalizacionNivel
@EventoID int,
@PersonalizacionId int,
@NivelId int,
@CategoriaId int = 0,
@Valor varchar(200)
as
begin

insert into ShowRoom.PersonalizacionNivel (EventoID, PersonalizacionId, NivelId, CategoriaId, Valor)
values (@EventoID, @PersonalizacionId, @NivelId, @CategoriaId, @Valor)

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[UpdateShowRoomPersonalizacionNivel]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].UpdateShowRoomPersonalizacionNivel
GO

create procedure ShowRoom.UpdateShowRoomPersonalizacionNivel
@PersonalizacionNivelId int,
@Valor varchar(200)
as
begin

update ShowRoom.PersonalizacionNivel
	set Valor = @Valor
where PersonalizacionNivelId = @PersonalizacionNivelId

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomCategorias]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomCategorias
GO

create procedure ShowRoom.GetShowRoomCategorias
@EventoId int
as
/*
ShowRoom.GetShowRoomCategorias 6
*/
begin

select
	CategoriaId,
	EventoID,
	Codigo,
	Descripcion
from ShowRoom.Categoria
where EventoID = @EventoId

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomCategoriaById]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomCategoriaById
GO

create procedure ShowRoom.GetShowRoomCategoriaById
@CategoriaId int
as
/*
ShowRoom.GetShowRoomCategoriaById 1
*/
begin

select
	CategoriaId,
	EventoID,
	Codigo,
	Descripcion
from ShowRoom.Categoria
where CategoriaId = @CategoriaId

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[UpdateShowRoomDescripcionCategoria]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].UpdateShowRoomDescripcionCategoria
GO

create procedure ShowRoom.UpdateShowRoomDescripcionCategoria
@CategoriaId int,
@Descripcion varchar(200)
as
begin

update ShowRoom.Categoria
set
	Descripcion = @Descripcion
where 
	CategoriaId = @CategoriaId

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[DeleteShowRoomCategoriaByEvento]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].DeleteShowRoomCategoriaByEvento
GO

create procedure ShowRoom.DeleteShowRoomCategoriaByEvento
@EventoId int
as
begin

delete from ShowRoom.PersonalizacionNivel where EventoID = @EventoId and NivelId = 0
delete from ShowRoom.Categoria where EventoId = @EventoID

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[InsertShowRoomCategoria]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].InsertShowRoomCategoria
GO

create procedure ShowRoom.InsertShowRoomCategoria
@EventoID int,
@Codigo varchar(50),
@Descripcion varchar(200)
as
begin

insert into ShowRoom.Categoria (EventoID, Codigo, Descripcion) values (@EventoID, @Codigo, @Descripcion)

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomCompraPorCompra]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomCompraPorCompra
GO

create procedure ShowRoom.GetShowRoomCompraPorCompra
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

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[UpdStockOfertaShowRoomMasivo]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].UpdStockOfertaShowRoomMasivo
GO

IF (SELECT COUNT(*) FROM sys.table_types WHERE name = 'StockPrecioOfertaShowRoomType') = 1
	drop type ShowRoom.StockPrecioOfertaShowRoomType

go

go

IF (SELECT COUNT(*) FROM sys.table_types WHERE name = 'StockPrecioOfertaShowRoomType') = 0  
  CREATE TYPE ShowRoom.StockPrecioOfertaShowRoomType AS TABLE ( 
	TipoOfertaSisID int, CampaniaID int, CUV varchar(20), Stock int, PrecioOferta decimal(18,2), UnidadesPermitidas int,
	Descripcion varchar(250), CodigoCategoria varchar(100), TipNegocio varchar(500)
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
	TipNegocio = t.TipNegocio
FROM ShowRoom.OfertaShowRoom o
INNER JOIN ods.Campania c on 
	c.CampaniaID = o.CampaniaID
JOIN @StockPrecioOfertaShowRoom t ON 
	c.Codigo = t.CampaniaID
	AND o.CUV = t.CUV
	AND o.TipoOfertaSisID = t.TipoOfertaSisID

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[InsertCargaMasivaOfertaDetalle]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].InsertCargaMasivaOfertaDetalle
GO

IF (SELECT COUNT(*) FROM sys.table_types WHERE name = 'OfertaShowRoomDetalleType') = 1
	drop type ShowRoom.OfertaShowRoomDetalleType

go

go

IF (SELECT COUNT(*) FROM sys.table_types WHERE name = 'OfertaShowRoomDetalleType') = 0 
CREATE TYPE ShowRoom.OfertaShowRoomDetalleType AS TABLE(
	CUV varchar(20) NULL,
	NombreProducto varchar(150) NULL,
	Descripcion1 varchar(150) NULL,
	Descripcion2 varchar(150) NULL,
	Descripcion3 varchar(150) NULL,
	Posicion int NULL,
	MarcaProducto varchar(100) NULL
)

go

create procedure ShowRoom.InsertCargaMasivaOfertaDetalle
@OfertaShowRoomDetalle ShowRoom.OfertaShowRoomDetalleType readonly,
@CampaniaID int,
@UsuarioCreacion varchar(50)
as
begin

begin tran

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

delete from ShowRoom.OfertaShowRoomDetalle
	where OfertaShowRoomDetalleID not in (select o.OfertaShowRoomDetalleID from ShowRoom.OfertaShowRoomDetalle o
	inner join @OfertaShowRoomDetalle t on
	o.CUV = t.CUV
	and o.Posicion = t.Posicion)

update ShowRoom.OfertaShowRoomDetalle
set NombreProducto = t.NombreProducto,
	Descripcion1 = t.Descripcion1,
	Descripcion2 = t.Descripcion2,
	Descripcion3 = t.Descripcion3,
	UsuarioModificacion = @UsuarioCreacion,
	MarcaProducto = t.MarcaProducto
from ShowRoom.OfertaShowRoomDetalle o
inner join @OfertaShowRoomDetalle t on	
	o.CUV = t.CUV
	and o.Posicion = t.Posicion
	--and o.NombreProducto = t.NombreProducto
where
	o.CampaniaID = @CampaniaID	

insert into ShowRoom.OfertaShowRoomDetalle
(CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,FechaCreacion,UsuarioCreacion,
FechaModificacion,UsuarioModificacion,Posicion,MarcaProducto)
select @CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,getdate(),@UsuarioCreacion,
getdate(),@UsuarioCreacion,Posicion,MarcaProducto
from @OfertaShowRoomDetalle
where 
	NombreProducto not in (select NombreProducto from ShowRoom.OfertaShowRoomDetalle o where o.CampaniaID = @CampaniaID
		and o.CUV = CUV)

end

commit tran

IF (@@ERROR <> 0) BEGIN
PRINT 'Error Inesperado!'
    ROLLBACK TRAN
END

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[InsertCargarProductoCpc]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].InsertCargarProductoCpc
GO

IF (SELECT COUNT(*) FROM sys.table_types WHERE name = 'OfertaShowRoomCompraPorCompraType') = 1
	drop type ShowRoom.OfertaShowRoomCompraPorCompraType

go

go

IF (SELECT COUNT(*) FROM sys.table_types WHERE name = 'OfertaShowRoomCompraPorCompraType') = 0  
  CREATE TYPE ShowRoom.OfertaShowRoomCompraPorCompraType AS TABLE ( 
	CUV varchar(20), SAP varchar(12), Orden int, PrecioValorizado decimal(18,2)
  )
GO

create procedure ShowRoom.InsertCargarProductoCpc
@OfertaShowRoomCompraPorCompra ShowRoom.OfertaShowRoomCompraPorCompraType readonly,
@EventoID int,
@UsuarioCreacion varchar(50)
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

declare @tablaCuv table ( CUV varchar(6))
insert into @tablaCuv
select distinct CUV from ShowRoom.CompraPorCompra where EventoID = @EventoID

update ShowRoom.CompraPorCompra
set 
	Orden = o.Orden,
	PrecioValorizado = o.PrecioValorizado,
	UsuarioModificacion = @UsuarioCreacion,
	FechaModificacion = @FechaGeneral
from ShowRoom.CompraPorCompra cpc
inner join @OfertaShowRoomCompraPorCompra o on
	cpc.CUV = o.CUV
	and cpc.SAP = o.SAP
where cpc.EventoID = @EventoID

insert into ShowRoom.CompraPorCompra (EventoID, CUV, SAP, Orden, PrecioValorizado, 
FechaCreacion, FechaModificacion, UsuarioCreacion, UsuarioModificacion)
select 
	@EventoID, CUV, SAP, Orden, PrecioValorizado, 
	@FechaGeneral, @FechaGeneral, @UsuarioCreacion, @UsuarioCreacion
from @OfertaShowRoomCompraPorCompra
where CUV not in (
	select CUV from @tablaCuv
)

end

go

ALTER procedure ShowRoom.InsertShowRoomEvento
@EventoID int output,
@CampaniaID int,
@Nombre varchar(150),
@Tema varchar(150),
@DiasAntes int,
@DiasDespues int,
@NumeroPerfiles int,
@UsuarioCreacion varchar(20),
@TieneCategoria bit,
@TieneCompraXcompra bit
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

insert into ShowRoom.Evento
(CampaniaID, Nombre, Tema, DiasAntes, DiasDespues, NumeroPerfiles, 
FechaCreacion, UsuarioCreacion, FechaModificacion, UsuarioModificacion, Estado, TieneCategoria, TieneCompraXcompra)
values
(@CampaniaID, @Nombre, @Tema, @DiasAntes, @DiasDespues, @NumeroPerfiles,
@FechaGeneral, @UsuarioCreacion, @FechaGeneral, @UsuarioCreacion, 1, @TieneCategoria, @TieneCompraXcompra)

set @EventoID = @@IDENTITY

end

GO

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
@TieneCompraXcompra bit
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
	TieneCompraXcompra = @TieneCompraXcompra
where EventoID = @EventoID

end

go

alter procedure ShowRoom.GetShowRoomEventoByCampaniaID
@CampaniaID int
as
/*
ShowRoom.GetShowRoomEventoByCampaniaID 201705
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
	isnull(TieneCompraXcompra,0) as TieneCompraXcompra
from ShowRoom.Evento
where CampaniaID = @CampaniaID

end

go

ALTER procedure ShowRoom.InsertShowRoomCargarMasivaConsultora
@EventoConsultora ShowRoom.EventoConsultoraType readonly
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

INSERT INTO ShowRoom.EventoConsultora(EventoID, CampaniaID, CodigoConsultora, Segmento, MostrarPopup,
MostrarPopupVenta, FechaCreacion, UsuarioCreacion, FechaModificacion, UsuarioModificacion)
SELECT DISTINCT EventoID, CampaniaID, CodigoConsultora, Segmento, 1,
1, @FechaGeneral, UsuarioCreacion, @FechaGeneral, UsuarioCreacion
FROM @EventoConsultora

end

go

ALTER procedure ShowRoom.GetShowRoomConsultora
@CampaniaID int,
@CodigoConsultora varchar(20)
as
/*
ShowRoom.GetShowRoomConsultora 201704,'0193037'
*/
begin

select top 1
EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,MostrarPopup,
MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion
from ShowRoom.EventoConsultora
where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
order by FechaCreacion desc

end

go

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

go

ALTER procedure ShowRoom.GetProductosShowRoomDetalle
@CampaniaID int,
@CUV varchar(5)
as
/*
ShowRoom.GetProductosShowRoomDetalle 201705,'96248'
ShowRoom.GetProductosShowRoomDetalle 201705,'99008'
*/
begin

select top 3
	OfertaShowRoomDetalleID,
	CampaniaID,
	CUV,
	isnull(NombreProducto,'') as NombreProducto,
	isnull(Descripcion1,'') as Descripcion1,
	isnull(Descripcion2,'') as Descripcion2,
	isnull(Descripcion3,'') as Descripcion3,
	isnull(Imagen,'') as Imagen,
	FechaCreacion,
	UsuarioCreacion,
	FechaModificacion,
	UsuarioModificacion,
	Posicion,
	MarcaProducto
from ShowRoom.OfertaShowRoomDetalle
where 
	CampaniaID = @CampaniaID
	and CUV = @CUV

end

go

ALTER procedure ShowRoom.InsOfertaShowRoomDetalle
@CampaniaID int,
@CUV varchar(5),
@NombreProducto varchar(100),
@Descripcion1 varchar(150),
@Descripcion2 varchar(150),
@Descripcion3 varchar(150),
@Imagen varchar(150),
@UsuarioCreacion varchar(50),
@MarcaProducto varchar(100)
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

declare @Posicion int = 0
select @Posicion = max(Posicion) from ShowRoom.OfertaShowRoomDetalle
where 
	CampaniaID = @CampaniaID
	and CUV = @CUV

insert into ShowRoom.OfertaShowRoomDetalle
(CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,
Imagen,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,Posicion,MarcaProducto)
values
(@CampaniaID,@CUV,@NombreProducto,@Descripcion1,@Descripcion2,@Descripcion3,
@Imagen,@FechaGeneral,@UsuarioCreacion,@FechaGeneral,@UsuarioCreacion,@Posicion+1,@MarcaProducto)

end

go

ALTER procedure ShowRoom.UpdOfertaShowRoomDetalle
@OfertaShowRoomDetalleID int,
@CampaniaID int,
@CUV varchar(5),
@NombreProducto varchar(100),
@Descripcion1 varchar(150),
@Descripcion2 varchar(150),
@Descripcion3 varchar(150),
@Imagen varchar(150),
@UsuarioModificacion varchar(50),
@MarcaProducto varchar(100)
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

update ShowRoom.OfertaShowRoomDetalle
set
	NombreProducto = @NombreProducto,
	Descripcion1 = @Descripcion1,
	Descripcion2 = @Descripcion2,
	Descripcion3 = @Descripcion3,
	Imagen = @Imagen,
	UsuarioModificacion = @UsuarioModificacion,
	FechaModificacion = @FechaGeneral,
	MarcaProducto = @MarcaProducto
where
	OfertaShowRoomDetalleID = @OfertaShowRoomDetalleID
	and CampaniaID = @CampaniaID
	and CUV = @CUV

end

go


ALTER PROCEDURE dbo.InsPedidoWebDetalleOferta_SB2
	@CampaniaID int,
	@ConsultoraID int,
	@MarcaID tinyint,
	@Cantidad int,
	@PrecioUnidad money,
	@CUV varchar(20),
	@ConfiguracionOfertaID INT,
	@TipoOfertaSisID INT,
	@PaisID int,
	@IPUsuario varchar(25) = null,
	@CodigoUsuarioCreacion varchar(25) = null,
	@OrigenPedidoWeb int = 0,
	@EsCompraPorCompra bit = 0
AS
BEGIN
DECLARE @PedidoDetalleID INT;
DECLARE @PedidoID  INT = 0;
DECLARE @OfertaWeb INT  = 1;
DECLARE @ExisteDet INT = 0;
DECLARE @Orden INT=0;

	EXEC [dbo].[InsPedidoWebOferta] @CampaniaID, @ConsultoraID , @PaisID, @IPUsuario, @CodigoUsuarioCreacion;

	if @TipoOfertaSisID = 1707
	begin
		set @OfertaWeb = 0
	end

	if @EsCompraPorCompra = 1
	begin
		set @OfertaWeb = 0
	end

	SELECT @PedidoID = PedidoID FROM dbo.PedidoWeb WHERE CampaniaID = @CampaniaID AND ConsultoraID = @ConsultoraID;

	SELECT @PedidoDetalleID = MAX(ISNULL(PedidoDetalleID,0))
		   , @Orden = max(ISNULL(OrdenPedidoWD,0))
		   FROM dbo.PedidoWebDetalle 
		   WHERE CampaniaID = @CampaniaID AND PedidoID = @PedidoID
	
	SET @PedidoDetalleID = ISNULL(@PedidoDetalleID, 0) + 1
	SET @Orden = ISNULL(@Orden, 0) + 1

	--SET @PedidoDetalleID =	(SELECT ISNULL(MAX(PedidoDetalleID),0) + 1 
	--							FROM	dbo.PedidoWebDetalle 
	--							WHERE	CampaniaID = @CampaniaID AND
	--									PedidoID = @PedidoID);

	/* Validar Al Agregar Nuevamente */
	set @ExisteDet = (select count(*) from PedidoWebDetalle 
						where CampaniaID = @CampaniaID 
							  AND PedidoID = @PedidoID
							  AND CUV = @CUV
							  AND ClienteID IS NULL);

	IF @ExisteDet = 0 
		BEGIN
			INSERT INTO dbo.PedidoWebDetalle 
			(
			 CampaniaID,
			 PedidoID,
			 PedidoDetalleID,
			 MarcaID,
			 ConsultoraID,
			 ClienteID,
			 Cantidad,
			 PrecioUnidad,
			 ImporteTotal,
			 CUV,
			 OfertaWeb, 
			 ModificaPedidoReservado,
			 ConfiguracionOfertaID,
			 TipoOfertaSisID,
			 CodigoUsuarioCreacion,
			 FechaCreacion,
			 OrdenPedidoWD,
			 OrigenPedidoWeb
			)

		VALUES (@CampaniaID,@PedidoID,@PedidoDetalleID,
				@MarcaID,@ConsultoraID,NULL,
				@Cantidad,@PrecioUnidad,@Cantidad*@PrecioUnidad,@CUV,@OfertaWeb,0, @ConfiguracionOfertaID, @TipoOfertaSisID,
				@CodigoUsuarioCreacion, dbo.fnObtenerFechaHoraPais(), @Orden, @OrigenPedidoWeb)
		END
	ELSE
		BEGIN
			UPDATE dbo.PedidoWebDetalle
				SET Cantidad += @Cantidad,
					ImporteTotal = ((Cantidad + @Cantidad) * @PrecioUnidad),
					CodigoUsuarioModificacion = @CodigoUsuarioCreacion,
					FechaModificacion = dbo.fnObtenerFechaHoraPais(),
					OrdenPedidoWD = @Orden,
					OrigenPedidoWeb = @OrigenPedidoWeb
			WHERE CampaniaID = @CampaniaID 
				  AND PedidoID = @PedidoID
				  AND CUV = @CUV
				  AND ClienteID IS NULL		
		END
END

GO

USE BelcorpEcuador
go

delete from dbo.TablaLogicaDatos where TablaLogicaID = 99
delete from dbo.TablaLogica where TablaLogicaID = 99

go

if not exists (select 1 from dbo.TablaLogica where TablaLogicaID = 99)
begin
	insert into dbo.TablaLogica(TablaLogicaID,Descripcion) values (99,'OrdenamientoShowRoom')
end

go

if not exists (select 1 from dbo.TablaLogicaDatos where TablaLogicaID = 99 and Codigo='01')
begin
	insert into dbo.TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) 
	values (9901,99,'01','Los más vendidos')
end

go

if not exists (select 1 from dbo.TablaLogicaDatos where TablaLogicaID = 99 and Codigo='02')
begin
	insert into dbo.TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) 
	values (9902,99,'02','Menor a mayor precio')
end

go

if not exists (select 1 from dbo.TablaLogicaDatos where TablaLogicaID = 99 and Codigo='03')
begin
	insert into dbo.TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) 
	values (9903,99,'03','Mayor a menor precio')
end

go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.Evento') and SYSCOLUMNS.NAME = N'TieneCategoria') = 0
	ALTER TABLE ShowRoom.Evento ADD TieneCategoria bit
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.Evento') and SYSCOLUMNS.NAME = N'TieneCompraXcompra') = 0
	ALTER TABLE ShowRoom.Evento ADD TieneCompraXcompra bit
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'CodigoCategoria') = 0
	ALTER TABLE ShowRoom.OfertaShowRoom ADD CodigoCategoria varchar(100)
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'TipNegocio') = 0
	ALTER TABLE ShowRoom.OfertaShowRoom ADD TipNegocio varchar(500)
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoomDetalle') and SYSCOLUMNS.NAME = N'MarcaProducto') = 0
	ALTER TABLE ShowRoom.OfertaShowRoomDetalle ADD MarcaProducto varchar(100)
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.EventoConsultora') and SYSCOLUMNS.NAME = N'MostrarPopupVenta') = 0
	ALTER TABLE ShowRoom.EventoConsultora ADD MostrarPopupVenta bit
go

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[Nivel]') AND (type = 'U') )
	DROP TABLE ShowRoom.Nivel
GO

create table ShowRoom.Nivel
(
	NivelId int identity(1,1) primary key,
	Codigo varchar(100),
	Descripcion varchar(100)
)

go

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[Personalizacion]') AND (type = 'U') )
	DROP TABLE ShowRoom.Personalizacion
GO

create table ShowRoom.Personalizacion
(
	PersonalizacionId int identity(1,1) primary key,
	TipoAplicacion varchar(20),
	Atributo varchar(100),
	TextoAyuda varchar(200),
	TipoAtributo varchar(20),
	TipoPersonalizacion varchar(20),
	Orden int,
	Estado bit
)

go

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[PersonalizacionNivel]') AND (type = 'U') )
	DROP TABLE ShowRoom.PersonalizacionNivel
GO

create table ShowRoom.PersonalizacionNivel
(
	PersonalizacionNivelId int identity(1,1) primary key,
	EventoID int,
	PersonalizacionId int,
	NivelId int,
	CategoriaId int,
	Valor varchar(200)
)

go

CREATE NONCLUSTERED INDEX IX_ShowRoomPersonalizacionNivel_EventoIdNivelId ON ShowRoom.PersonalizacionNivel (EventoID,NivelId);

go

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[Categoria]') AND (type = 'U') )
	DROP TABLE ShowRoom.Categoria
GO

create table ShowRoom.Categoria
(
	CategoriaId int identity(1,1) primary key,
	EventoID int,
	Codigo varchar(50),
	Descripcion varchar(200)
)

go

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[CompraPorCompra]') AND (type = 'U') )
	DROP TABLE ShowRoom.CompraPorCompra
GO

CREATE TABLE ShowRoom.CompraPorCompra
(
	CompraxCompraID int identity(1,1) primary key,
	EventoID int,
	CUV varchar(20),
	SAP varchar(12),
	Orden int,
	PrecioValorizado decimal(18,2),
	FechaCreacion datetime,
	UsuarioCreacion varchar(50),
	FechaModificacion datetime,
	UsuarioModificacion varchar(50)
)

GO

insert into ShowRoom.Nivel (Codigo,Descripcion) values ('PAIS','País')

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','PopupImagenIntriga','Popup Principal Intriga (615px x 409px)','IMAGEN','EVENTO',1,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','PopupImagenVenta','Popup Principal Venta (615px x 409px)','IMAGEN','EVENTO',2,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','BannerImagenIntriga','Visual Superior Intriga (1920px x 174px)','IMAGEN','EVENTO',3,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','BannerImagenVenta','Visual Superior Venta (1920px x 174px)','IMAGEN','EVENTO',4,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','UrlTerminosCondiciones','Link Terminos y Condiciones','TEXTO','EVENTO',5,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','TextoCondicionCompraCpc','Texto Condición de Compra por Compra','TEXTO','EVENTO',6,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','TextoDescripcionLegalCpc','Texto Descripción Legal Compra por Compra','TEXTO','EVENTO',7,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','IconoLluvia','Icono Lluvia Paginal Principal','IMAGEN','EVENTO',8,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','BannerEnvioCorreo','Imagen Envio Correo','IMAGEN','EVENTO',9,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','TextoEnvioCorreo','Texto mostrar Envio Correo','TEXTO','EVENTO',10,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','ImagenFondoProductPage','Imagen de Fondo del Product Page','IMAGEN','EVENTO',11,1)

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','TituloPrincipal','Título de la Categoria','TEXTO','CATEGORIA',12,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','ImagenPrincipal','Imagen a mostrar en la Categoria','IMAGEN','CATEGORIA',13,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','ColorFondo','Color de Fondo de la Categoria','TEXTO','CATEGORIA',14,1)

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','PopupImagenIntriga','Banner Marquesina Intriga (768px x 420px)','IMAGEN','EVENTO',1,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','PopupImagenVenta','Banner Marquesina Venta (768px x 420px)','IMAGEN','EVENTO',2,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','BannerImagenIntriga','Banner Superior Intriga (1024px x 60px)','IMAGEN','EVENTO',3,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','BannerImagenPaginaVenta','Banner Superior Pagina Venta (1024px x 60px)','IMAGEN','EVENTO',4,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','BannerImagenVenta','Banner Superior Venta Otras Paginas (1024px x 60px)','IMAGEN','EVENTO',5,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','UrlTerminosCondiciones','Link Terminos y Condiciones','TEXTO','EVENTO',6,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','TextoCondicionCompraCpc','Texto Condición de Compra','TEXTO','EVENTO',7,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','TextoDescripcionLegalCpc','Texto Descripción Legal Compra por Compra','TEXTO','EVENTO',8,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','ImagenFondoProductPage','Imagen de Fondo del Product Page','IMAGEN','EVENTO',9,1)

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','TituloPrincipal','Título de la Categoria','TEXTO','CATEGORIA',10,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','ColorFondo','Color de Fondo de la Categoria','TEXTO','CATEGORIA',11,1)

go

update ShowRoom.EventoConsultora set MostrarPopup = 1 where MostrarPopup is null
update ShowRoom.EventoConsultora set MostrarPopupVenta = 1 where MostrarPopupVenta is null

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomNivel]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomNivel
GO

create procedure ShowRoom.GetShowRoomNivel
as
/*
ShowRoom.GetShowRoomNivel
*/
begin

select
	NivelId,
	Codigo,
	Descripcion
from ShowRoom.Nivel

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomPersonalizacion]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomPersonalizacion
GO

create procedure ShowRoom.GetShowRoomPersonalizacion
as
/*
ShowRoom.GetShowRoomPersonalizacion
*/
begin

select
	PersonalizacionId,
	TipoAplicacion,
	Atributo,
	TextoAyuda,
	TipoAtributo,
	TipoPersonalizacion,
	Orden,
	Estado
from ShowRoom.Personalizacion

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomPersonalizacionNivel]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomPersonalizacionNivel
GO

create procedure ShowRoom.GetShowRoomPersonalizacionNivel
@EventoId int,
@NivelId int = 0,
@CategoriaId int = 0
as
/*
ShowRoom.GetShowRoomPersonalizacionNivel 2006,1,0
ShowRoom.GetShowRoomPersonalizacionNivel 2006,0,1
*/
begin

select 
	PersonalizacionNivelId,
	EventoID,
	PersonalizacionId,
	isnull(NivelId,0) as NivelId,
	isnull(CategoriaId,0) as CategoriaId,
	isnull(Valor,'') as Valor
from ShowRoom.PersonalizacionNivel
where
	EventoID = @EventoId
	and (@NivelId = 0 or NivelId = @NivelId)
	and (@CategoriaId = 0 or CategoriaId = @CategoriaId)

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[InsertShowRoomPersonalizacionNivel]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].InsertShowRoomPersonalizacionNivel
GO

create procedure ShowRoom.InsertShowRoomPersonalizacionNivel
@EventoID int,
@PersonalizacionId int,
@NivelId int,
@CategoriaId int = 0,
@Valor varchar(200)
as
begin

insert into ShowRoom.PersonalizacionNivel (EventoID, PersonalizacionId, NivelId, CategoriaId, Valor)
values (@EventoID, @PersonalizacionId, @NivelId, @CategoriaId, @Valor)

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[UpdateShowRoomPersonalizacionNivel]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].UpdateShowRoomPersonalizacionNivel
GO

create procedure ShowRoom.UpdateShowRoomPersonalizacionNivel
@PersonalizacionNivelId int,
@Valor varchar(200)
as
begin

update ShowRoom.PersonalizacionNivel
	set Valor = @Valor
where PersonalizacionNivelId = @PersonalizacionNivelId

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomCategorias]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomCategorias
GO

create procedure ShowRoom.GetShowRoomCategorias
@EventoId int
as
/*
ShowRoom.GetShowRoomCategorias 6
*/
begin

select
	CategoriaId,
	EventoID,
	Codigo,
	Descripcion
from ShowRoom.Categoria
where EventoID = @EventoId

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomCategoriaById]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomCategoriaById
GO

create procedure ShowRoom.GetShowRoomCategoriaById
@CategoriaId int
as
/*
ShowRoom.GetShowRoomCategoriaById 1
*/
begin

select
	CategoriaId,
	EventoID,
	Codigo,
	Descripcion
from ShowRoom.Categoria
where CategoriaId = @CategoriaId

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[UpdateShowRoomDescripcionCategoria]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].UpdateShowRoomDescripcionCategoria
GO

create procedure ShowRoom.UpdateShowRoomDescripcionCategoria
@CategoriaId int,
@Descripcion varchar(200)
as
begin

update ShowRoom.Categoria
set
	Descripcion = @Descripcion
where 
	CategoriaId = @CategoriaId

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[DeleteShowRoomCategoriaByEvento]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].DeleteShowRoomCategoriaByEvento
GO

create procedure ShowRoom.DeleteShowRoomCategoriaByEvento
@EventoId int
as
begin

delete from ShowRoom.PersonalizacionNivel where EventoID = @EventoId and NivelId = 0
delete from ShowRoom.Categoria where EventoId = @EventoID

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[InsertShowRoomCategoria]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].InsertShowRoomCategoria
GO

create procedure ShowRoom.InsertShowRoomCategoria
@EventoID int,
@Codigo varchar(50),
@Descripcion varchar(200)
as
begin

insert into ShowRoom.Categoria (EventoID, Codigo, Descripcion) values (@EventoID, @Codigo, @Descripcion)

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomCompraPorCompra]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomCompraPorCompra
GO

create procedure ShowRoom.GetShowRoomCompraPorCompra
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

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[UpdStockOfertaShowRoomMasivo]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].UpdStockOfertaShowRoomMasivo
GO

IF (SELECT COUNT(*) FROM sys.table_types WHERE name = 'StockPrecioOfertaShowRoomType') = 1
	drop type ShowRoom.StockPrecioOfertaShowRoomType

go

go

IF (SELECT COUNT(*) FROM sys.table_types WHERE name = 'StockPrecioOfertaShowRoomType') = 0  
  CREATE TYPE ShowRoom.StockPrecioOfertaShowRoomType AS TABLE ( 
	TipoOfertaSisID int, CampaniaID int, CUV varchar(20), Stock int, PrecioOferta decimal(18,2), UnidadesPermitidas int,
	Descripcion varchar(250), CodigoCategoria varchar(100), TipNegocio varchar(500)
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
	TipNegocio = t.TipNegocio
FROM ShowRoom.OfertaShowRoom o
INNER JOIN ods.Campania c on 
	c.CampaniaID = o.CampaniaID
JOIN @StockPrecioOfertaShowRoom t ON 
	c.Codigo = t.CampaniaID
	AND o.CUV = t.CUV
	AND o.TipoOfertaSisID = t.TipoOfertaSisID

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[InsertCargaMasivaOfertaDetalle]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].InsertCargaMasivaOfertaDetalle
GO

IF (SELECT COUNT(*) FROM sys.table_types WHERE name = 'OfertaShowRoomDetalleType') = 1
	drop type ShowRoom.OfertaShowRoomDetalleType

go

go

IF (SELECT COUNT(*) FROM sys.table_types WHERE name = 'OfertaShowRoomDetalleType') = 0 
CREATE TYPE ShowRoom.OfertaShowRoomDetalleType AS TABLE(
	CUV varchar(20) NULL,
	NombreProducto varchar(150) NULL,
	Descripcion1 varchar(150) NULL,
	Descripcion2 varchar(150) NULL,
	Descripcion3 varchar(150) NULL,
	Posicion int NULL,
	MarcaProducto varchar(100) NULL
)

go

create procedure ShowRoom.InsertCargaMasivaOfertaDetalle
@OfertaShowRoomDetalle ShowRoom.OfertaShowRoomDetalleType readonly,
@CampaniaID int,
@UsuarioCreacion varchar(50)
as
begin

begin tran

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

delete from ShowRoom.OfertaShowRoomDetalle
	where OfertaShowRoomDetalleID not in (select o.OfertaShowRoomDetalleID from ShowRoom.OfertaShowRoomDetalle o
	inner join @OfertaShowRoomDetalle t on
	o.CUV = t.CUV
	and o.Posicion = t.Posicion)

update ShowRoom.OfertaShowRoomDetalle
set NombreProducto = t.NombreProducto,
	Descripcion1 = t.Descripcion1,
	Descripcion2 = t.Descripcion2,
	Descripcion3 = t.Descripcion3,
	UsuarioModificacion = @UsuarioCreacion,
	MarcaProducto = t.MarcaProducto
from ShowRoom.OfertaShowRoomDetalle o
inner join @OfertaShowRoomDetalle t on	
	o.CUV = t.CUV
	and o.Posicion = t.Posicion
	--and o.NombreProducto = t.NombreProducto
where
	o.CampaniaID = @CampaniaID	

insert into ShowRoom.OfertaShowRoomDetalle
(CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,FechaCreacion,UsuarioCreacion,
FechaModificacion,UsuarioModificacion,Posicion,MarcaProducto)
select @CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,getdate(),@UsuarioCreacion,
getdate(),@UsuarioCreacion,Posicion,MarcaProducto
from @OfertaShowRoomDetalle
where 
	NombreProducto not in (select NombreProducto from ShowRoom.OfertaShowRoomDetalle o where o.CampaniaID = @CampaniaID
		and o.CUV = CUV)

end

commit tran

IF (@@ERROR <> 0) BEGIN
PRINT 'Error Inesperado!'
    ROLLBACK TRAN
END

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[InsertCargarProductoCpc]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].InsertCargarProductoCpc
GO

IF (SELECT COUNT(*) FROM sys.table_types WHERE name = 'OfertaShowRoomCompraPorCompraType') = 1
	drop type ShowRoom.OfertaShowRoomCompraPorCompraType

go

go

IF (SELECT COUNT(*) FROM sys.table_types WHERE name = 'OfertaShowRoomCompraPorCompraType') = 0  
  CREATE TYPE ShowRoom.OfertaShowRoomCompraPorCompraType AS TABLE ( 
	CUV varchar(20), SAP varchar(12), Orden int, PrecioValorizado decimal(18,2)
  )
GO

create procedure ShowRoom.InsertCargarProductoCpc
@OfertaShowRoomCompraPorCompra ShowRoom.OfertaShowRoomCompraPorCompraType readonly,
@EventoID int,
@UsuarioCreacion varchar(50)
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

declare @tablaCuv table ( CUV varchar(6))
insert into @tablaCuv
select distinct CUV from ShowRoom.CompraPorCompra where EventoID = @EventoID

update ShowRoom.CompraPorCompra
set 
	Orden = o.Orden,
	PrecioValorizado = o.PrecioValorizado,
	UsuarioModificacion = @UsuarioCreacion,
	FechaModificacion = @FechaGeneral
from ShowRoom.CompraPorCompra cpc
inner join @OfertaShowRoomCompraPorCompra o on
	cpc.CUV = o.CUV
	and cpc.SAP = o.SAP
where cpc.EventoID = @EventoID

insert into ShowRoom.CompraPorCompra (EventoID, CUV, SAP, Orden, PrecioValorizado, 
FechaCreacion, FechaModificacion, UsuarioCreacion, UsuarioModificacion)
select 
	@EventoID, CUV, SAP, Orden, PrecioValorizado, 
	@FechaGeneral, @FechaGeneral, @UsuarioCreacion, @UsuarioCreacion
from @OfertaShowRoomCompraPorCompra
where CUV not in (
	select CUV from @tablaCuv
)

end

go

ALTER procedure ShowRoom.InsertShowRoomEvento
@EventoID int output,
@CampaniaID int,
@Nombre varchar(150),
@Tema varchar(150),
@DiasAntes int,
@DiasDespues int,
@NumeroPerfiles int,
@UsuarioCreacion varchar(20),
@TieneCategoria bit,
@TieneCompraXcompra bit
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

insert into ShowRoom.Evento
(CampaniaID, Nombre, Tema, DiasAntes, DiasDespues, NumeroPerfiles, 
FechaCreacion, UsuarioCreacion, FechaModificacion, UsuarioModificacion, Estado, TieneCategoria, TieneCompraXcompra)
values
(@CampaniaID, @Nombre, @Tema, @DiasAntes, @DiasDespues, @NumeroPerfiles,
@FechaGeneral, @UsuarioCreacion, @FechaGeneral, @UsuarioCreacion, 1, @TieneCategoria, @TieneCompraXcompra)

set @EventoID = @@IDENTITY

end

GO

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
@TieneCompraXcompra bit
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
	TieneCompraXcompra = @TieneCompraXcompra
where EventoID = @EventoID

end

go

alter procedure ShowRoom.GetShowRoomEventoByCampaniaID
@CampaniaID int
as
/*
ShowRoom.GetShowRoomEventoByCampaniaID 201705
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
	isnull(TieneCompraXcompra,0) as TieneCompraXcompra
from ShowRoom.Evento
where CampaniaID = @CampaniaID

end

go

ALTER procedure ShowRoom.InsertShowRoomCargarMasivaConsultora
@EventoConsultora ShowRoom.EventoConsultoraType readonly
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

INSERT INTO ShowRoom.EventoConsultora(EventoID, CampaniaID, CodigoConsultora, Segmento, MostrarPopup,
MostrarPopupVenta, FechaCreacion, UsuarioCreacion, FechaModificacion, UsuarioModificacion)
SELECT DISTINCT EventoID, CampaniaID, CodigoConsultora, Segmento, 1,
1, @FechaGeneral, UsuarioCreacion, @FechaGeneral, UsuarioCreacion
FROM @EventoConsultora

end

go

ALTER procedure ShowRoom.GetShowRoomConsultora
@CampaniaID int,
@CodigoConsultora varchar(20)
as
/*
ShowRoom.GetShowRoomConsultora 201704,'0193037'
*/
begin

select top 1
EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,MostrarPopup,
MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion
from ShowRoom.EventoConsultora
where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
order by FechaCreacion desc

end

go

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

go

ALTER procedure ShowRoom.GetProductosShowRoomDetalle
@CampaniaID int,
@CUV varchar(5)
as
/*
ShowRoom.GetProductosShowRoomDetalle 201705,'96248'
ShowRoom.GetProductosShowRoomDetalle 201705,'99008'
*/
begin

select top 3
	OfertaShowRoomDetalleID,
	CampaniaID,
	CUV,
	isnull(NombreProducto,'') as NombreProducto,
	isnull(Descripcion1,'') as Descripcion1,
	isnull(Descripcion2,'') as Descripcion2,
	isnull(Descripcion3,'') as Descripcion3,
	isnull(Imagen,'') as Imagen,
	FechaCreacion,
	UsuarioCreacion,
	FechaModificacion,
	UsuarioModificacion,
	Posicion,
	MarcaProducto
from ShowRoom.OfertaShowRoomDetalle
where 
	CampaniaID = @CampaniaID
	and CUV = @CUV

end

go

ALTER procedure ShowRoom.InsOfertaShowRoomDetalle
@CampaniaID int,
@CUV varchar(5),
@NombreProducto varchar(100),
@Descripcion1 varchar(150),
@Descripcion2 varchar(150),
@Descripcion3 varchar(150),
@Imagen varchar(150),
@UsuarioCreacion varchar(50),
@MarcaProducto varchar(100)
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

declare @Posicion int = 0
select @Posicion = max(Posicion) from ShowRoom.OfertaShowRoomDetalle
where 
	CampaniaID = @CampaniaID
	and CUV = @CUV

insert into ShowRoom.OfertaShowRoomDetalle
(CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,
Imagen,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,Posicion,MarcaProducto)
values
(@CampaniaID,@CUV,@NombreProducto,@Descripcion1,@Descripcion2,@Descripcion3,
@Imagen,@FechaGeneral,@UsuarioCreacion,@FechaGeneral,@UsuarioCreacion,@Posicion+1,@MarcaProducto)

end

go

ALTER procedure ShowRoom.UpdOfertaShowRoomDetalle
@OfertaShowRoomDetalleID int,
@CampaniaID int,
@CUV varchar(5),
@NombreProducto varchar(100),
@Descripcion1 varchar(150),
@Descripcion2 varchar(150),
@Descripcion3 varchar(150),
@Imagen varchar(150),
@UsuarioModificacion varchar(50),
@MarcaProducto varchar(100)
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

update ShowRoom.OfertaShowRoomDetalle
set
	NombreProducto = @NombreProducto,
	Descripcion1 = @Descripcion1,
	Descripcion2 = @Descripcion2,
	Descripcion3 = @Descripcion3,
	Imagen = @Imagen,
	UsuarioModificacion = @UsuarioModificacion,
	FechaModificacion = @FechaGeneral,
	MarcaProducto = @MarcaProducto
where
	OfertaShowRoomDetalleID = @OfertaShowRoomDetalleID
	and CampaniaID = @CampaniaID
	and CUV = @CUV

end

go


ALTER PROCEDURE dbo.InsPedidoWebDetalleOferta_SB2
	@CampaniaID int,
	@ConsultoraID int,
	@MarcaID tinyint,
	@Cantidad int,
	@PrecioUnidad money,
	@CUV varchar(20),
	@ConfiguracionOfertaID INT,
	@TipoOfertaSisID INT,
	@PaisID int,
	@IPUsuario varchar(25) = null,
	@CodigoUsuarioCreacion varchar(25) = null,
	@OrigenPedidoWeb int = 0,
	@EsCompraPorCompra bit = 0
AS
BEGIN
DECLARE @PedidoDetalleID INT;
DECLARE @PedidoID  INT = 0;
DECLARE @OfertaWeb INT  = 1;
DECLARE @ExisteDet INT = 0;
DECLARE @Orden INT=0;

	EXEC [dbo].[InsPedidoWebOferta] @CampaniaID, @ConsultoraID , @PaisID, @IPUsuario, @CodigoUsuarioCreacion;

	if @TipoOfertaSisID = 1707
	begin
		set @OfertaWeb = 0
	end

	if @EsCompraPorCompra = 1
	begin
		set @OfertaWeb = 0
	end

	SELECT @PedidoID = PedidoID FROM dbo.PedidoWeb WHERE CampaniaID = @CampaniaID AND ConsultoraID = @ConsultoraID;

	SELECT @PedidoDetalleID = MAX(ISNULL(PedidoDetalleID,0))
		   , @Orden = max(ISNULL(OrdenPedidoWD,0))
		   FROM dbo.PedidoWebDetalle 
		   WHERE CampaniaID = @CampaniaID AND PedidoID = @PedidoID
	
	SET @PedidoDetalleID = ISNULL(@PedidoDetalleID, 0) + 1
	SET @Orden = ISNULL(@Orden, 0) + 1

	--SET @PedidoDetalleID =	(SELECT ISNULL(MAX(PedidoDetalleID),0) + 1 
	--							FROM	dbo.PedidoWebDetalle 
	--							WHERE	CampaniaID = @CampaniaID AND
	--									PedidoID = @PedidoID);

	/* Validar Al Agregar Nuevamente */
	set @ExisteDet = (select count(*) from PedidoWebDetalle 
						where CampaniaID = @CampaniaID 
							  AND PedidoID = @PedidoID
							  AND CUV = @CUV
							  AND ClienteID IS NULL);

	IF @ExisteDet = 0 
		BEGIN
			INSERT INTO dbo.PedidoWebDetalle 
			(
			 CampaniaID,
			 PedidoID,
			 PedidoDetalleID,
			 MarcaID,
			 ConsultoraID,
			 ClienteID,
			 Cantidad,
			 PrecioUnidad,
			 ImporteTotal,
			 CUV,
			 OfertaWeb, 
			 ModificaPedidoReservado,
			 ConfiguracionOfertaID,
			 TipoOfertaSisID,
			 CodigoUsuarioCreacion,
			 FechaCreacion,
			 OrdenPedidoWD,
			 OrigenPedidoWeb
			)

		VALUES (@CampaniaID,@PedidoID,@PedidoDetalleID,
				@MarcaID,@ConsultoraID,NULL,
				@Cantidad,@PrecioUnidad,@Cantidad*@PrecioUnidad,@CUV,@OfertaWeb,0, @ConfiguracionOfertaID, @TipoOfertaSisID,
				@CodigoUsuarioCreacion, dbo.fnObtenerFechaHoraPais(), @Orden, @OrigenPedidoWeb)
		END
	ELSE
		BEGIN
			UPDATE dbo.PedidoWebDetalle
				SET Cantidad += @Cantidad,
					ImporteTotal = ((Cantidad + @Cantidad) * @PrecioUnidad),
					CodigoUsuarioModificacion = @CodigoUsuarioCreacion,
					FechaModificacion = dbo.fnObtenerFechaHoraPais(),
					OrdenPedidoWD = @Orden,
					OrigenPedidoWeb = @OrigenPedidoWeb
			WHERE CampaniaID = @CampaniaID 
				  AND PedidoID = @PedidoID
				  AND CUV = @CUV
				  AND ClienteID IS NULL		
		END
END

GO

USE BelcorpGuatemala
go

delete from dbo.TablaLogicaDatos where TablaLogicaID = 99
delete from dbo.TablaLogica where TablaLogicaID = 99

go

if not exists (select 1 from dbo.TablaLogica where TablaLogicaID = 99)
begin
	insert into dbo.TablaLogica(TablaLogicaID,Descripcion) values (99,'OrdenamientoShowRoom')
end

go

if not exists (select 1 from dbo.TablaLogicaDatos where TablaLogicaID = 99 and Codigo='01')
begin
	insert into dbo.TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) 
	values (9901,99,'01','Los más vendidos')
end

go

if not exists (select 1 from dbo.TablaLogicaDatos where TablaLogicaID = 99 and Codigo='02')
begin
	insert into dbo.TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) 
	values (9902,99,'02','Menor a mayor precio')
end

go

if not exists (select 1 from dbo.TablaLogicaDatos where TablaLogicaID = 99 and Codigo='03')
begin
	insert into dbo.TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) 
	values (9903,99,'03','Mayor a menor precio')
end

go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.Evento') and SYSCOLUMNS.NAME = N'TieneCategoria') = 0
	ALTER TABLE ShowRoom.Evento ADD TieneCategoria bit
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.Evento') and SYSCOLUMNS.NAME = N'TieneCompraXcompra') = 0
	ALTER TABLE ShowRoom.Evento ADD TieneCompraXcompra bit
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'CodigoCategoria') = 0
	ALTER TABLE ShowRoom.OfertaShowRoom ADD CodigoCategoria varchar(100)
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'TipNegocio') = 0
	ALTER TABLE ShowRoom.OfertaShowRoom ADD TipNegocio varchar(500)
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoomDetalle') and SYSCOLUMNS.NAME = N'MarcaProducto') = 0
	ALTER TABLE ShowRoom.OfertaShowRoomDetalle ADD MarcaProducto varchar(100)
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.EventoConsultora') and SYSCOLUMNS.NAME = N'MostrarPopupVenta') = 0
	ALTER TABLE ShowRoom.EventoConsultora ADD MostrarPopupVenta bit
go

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[Nivel]') AND (type = 'U') )
	DROP TABLE ShowRoom.Nivel
GO

create table ShowRoom.Nivel
(
	NivelId int identity(1,1) primary key,
	Codigo varchar(100),
	Descripcion varchar(100)
)

go

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[Personalizacion]') AND (type = 'U') )
	DROP TABLE ShowRoom.Personalizacion
GO

create table ShowRoom.Personalizacion
(
	PersonalizacionId int identity(1,1) primary key,
	TipoAplicacion varchar(20),
	Atributo varchar(100),
	TextoAyuda varchar(200),
	TipoAtributo varchar(20),
	TipoPersonalizacion varchar(20),
	Orden int,
	Estado bit
)

go

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[PersonalizacionNivel]') AND (type = 'U') )
	DROP TABLE ShowRoom.PersonalizacionNivel
GO

create table ShowRoom.PersonalizacionNivel
(
	PersonalizacionNivelId int identity(1,1) primary key,
	EventoID int,
	PersonalizacionId int,
	NivelId int,
	CategoriaId int,
	Valor varchar(200)
)

go

CREATE NONCLUSTERED INDEX IX_ShowRoomPersonalizacionNivel_EventoIdNivelId ON ShowRoom.PersonalizacionNivel (EventoID,NivelId);

go

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[Categoria]') AND (type = 'U') )
	DROP TABLE ShowRoom.Categoria
GO

create table ShowRoom.Categoria
(
	CategoriaId int identity(1,1) primary key,
	EventoID int,
	Codigo varchar(50),
	Descripcion varchar(200)
)

go

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[CompraPorCompra]') AND (type = 'U') )
	DROP TABLE ShowRoom.CompraPorCompra
GO

CREATE TABLE ShowRoom.CompraPorCompra
(
	CompraxCompraID int identity(1,1) primary key,
	EventoID int,
	CUV varchar(20),
	SAP varchar(12),
	Orden int,
	PrecioValorizado decimal(18,2),
	FechaCreacion datetime,
	UsuarioCreacion varchar(50),
	FechaModificacion datetime,
	UsuarioModificacion varchar(50)
)

GO

insert into ShowRoom.Nivel (Codigo,Descripcion) values ('PAIS','País')

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','PopupImagenIntriga','Popup Principal Intriga (615px x 409px)','IMAGEN','EVENTO',1,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','PopupImagenVenta','Popup Principal Venta (615px x 409px)','IMAGEN','EVENTO',2,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','BannerImagenIntriga','Visual Superior Intriga (1920px x 174px)','IMAGEN','EVENTO',3,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','BannerImagenVenta','Visual Superior Venta (1920px x 174px)','IMAGEN','EVENTO',4,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','UrlTerminosCondiciones','Link Terminos y Condiciones','TEXTO','EVENTO',5,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','TextoCondicionCompraCpc','Texto Condición de Compra por Compra','TEXTO','EVENTO',6,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','TextoDescripcionLegalCpc','Texto Descripción Legal Compra por Compra','TEXTO','EVENTO',7,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','IconoLluvia','Icono Lluvia Paginal Principal','IMAGEN','EVENTO',8,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','BannerEnvioCorreo','Imagen Envio Correo','IMAGEN','EVENTO',9,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','TextoEnvioCorreo','Texto mostrar Envio Correo','TEXTO','EVENTO',10,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','ImagenFondoProductPage','Imagen de Fondo del Product Page','IMAGEN','EVENTO',11,1)

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','TituloPrincipal','Título de la Categoria','TEXTO','CATEGORIA',12,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','ImagenPrincipal','Imagen a mostrar en la Categoria','IMAGEN','CATEGORIA',13,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','ColorFondo','Color de Fondo de la Categoria','TEXTO','CATEGORIA',14,1)

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','PopupImagenIntriga','Banner Marquesina Intriga (768px x 420px)','IMAGEN','EVENTO',1,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','PopupImagenVenta','Banner Marquesina Venta (768px x 420px)','IMAGEN','EVENTO',2,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','BannerImagenIntriga','Banner Superior Intriga (1024px x 60px)','IMAGEN','EVENTO',3,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','BannerImagenPaginaVenta','Banner Superior Pagina Venta (1024px x 60px)','IMAGEN','EVENTO',4,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','BannerImagenVenta','Banner Superior Venta Otras Paginas (1024px x 60px)','IMAGEN','EVENTO',5,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','UrlTerminosCondiciones','Link Terminos y Condiciones','TEXTO','EVENTO',6,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','TextoCondicionCompraCpc','Texto Condición de Compra','TEXTO','EVENTO',7,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','TextoDescripcionLegalCpc','Texto Descripción Legal Compra por Compra','TEXTO','EVENTO',8,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','ImagenFondoProductPage','Imagen de Fondo del Product Page','IMAGEN','EVENTO',9,1)

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','TituloPrincipal','Título de la Categoria','TEXTO','CATEGORIA',10,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','ColorFondo','Color de Fondo de la Categoria','TEXTO','CATEGORIA',11,1)

go

update ShowRoom.EventoConsultora set MostrarPopup = 1 where MostrarPopup is null
update ShowRoom.EventoConsultora set MostrarPopupVenta = 1 where MostrarPopupVenta is null

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomNivel]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomNivel
GO

create procedure ShowRoom.GetShowRoomNivel
as
/*
ShowRoom.GetShowRoomNivel
*/
begin

select
	NivelId,
	Codigo,
	Descripcion
from ShowRoom.Nivel

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomPersonalizacion]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomPersonalizacion
GO

create procedure ShowRoom.GetShowRoomPersonalizacion
as
/*
ShowRoom.GetShowRoomPersonalizacion
*/
begin

select
	PersonalizacionId,
	TipoAplicacion,
	Atributo,
	TextoAyuda,
	TipoAtributo,
	TipoPersonalizacion,
	Orden,
	Estado
from ShowRoom.Personalizacion

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomPersonalizacionNivel]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomPersonalizacionNivel
GO

create procedure ShowRoom.GetShowRoomPersonalizacionNivel
@EventoId int,
@NivelId int = 0,
@CategoriaId int = 0
as
/*
ShowRoom.GetShowRoomPersonalizacionNivel 2006,1,0
ShowRoom.GetShowRoomPersonalizacionNivel 2006,0,1
*/
begin

select 
	PersonalizacionNivelId,
	EventoID,
	PersonalizacionId,
	isnull(NivelId,0) as NivelId,
	isnull(CategoriaId,0) as CategoriaId,
	isnull(Valor,'') as Valor
from ShowRoom.PersonalizacionNivel
where
	EventoID = @EventoId
	and (@NivelId = 0 or NivelId = @NivelId)
	and (@CategoriaId = 0 or CategoriaId = @CategoriaId)

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[InsertShowRoomPersonalizacionNivel]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].InsertShowRoomPersonalizacionNivel
GO

create procedure ShowRoom.InsertShowRoomPersonalizacionNivel
@EventoID int,
@PersonalizacionId int,
@NivelId int,
@CategoriaId int = 0,
@Valor varchar(200)
as
begin

insert into ShowRoom.PersonalizacionNivel (EventoID, PersonalizacionId, NivelId, CategoriaId, Valor)
values (@EventoID, @PersonalizacionId, @NivelId, @CategoriaId, @Valor)

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[UpdateShowRoomPersonalizacionNivel]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].UpdateShowRoomPersonalizacionNivel
GO

create procedure ShowRoom.UpdateShowRoomPersonalizacionNivel
@PersonalizacionNivelId int,
@Valor varchar(200)
as
begin

update ShowRoom.PersonalizacionNivel
	set Valor = @Valor
where PersonalizacionNivelId = @PersonalizacionNivelId

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomCategorias]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomCategorias
GO

create procedure ShowRoom.GetShowRoomCategorias
@EventoId int
as
/*
ShowRoom.GetShowRoomCategorias 6
*/
begin

select
	CategoriaId,
	EventoID,
	Codigo,
	Descripcion
from ShowRoom.Categoria
where EventoID = @EventoId

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomCategoriaById]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomCategoriaById
GO

create procedure ShowRoom.GetShowRoomCategoriaById
@CategoriaId int
as
/*
ShowRoom.GetShowRoomCategoriaById 1
*/
begin

select
	CategoriaId,
	EventoID,
	Codigo,
	Descripcion
from ShowRoom.Categoria
where CategoriaId = @CategoriaId

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[UpdateShowRoomDescripcionCategoria]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].UpdateShowRoomDescripcionCategoria
GO

create procedure ShowRoom.UpdateShowRoomDescripcionCategoria
@CategoriaId int,
@Descripcion varchar(200)
as
begin

update ShowRoom.Categoria
set
	Descripcion = @Descripcion
where 
	CategoriaId = @CategoriaId

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[DeleteShowRoomCategoriaByEvento]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].DeleteShowRoomCategoriaByEvento
GO

create procedure ShowRoom.DeleteShowRoomCategoriaByEvento
@EventoId int
as
begin

delete from ShowRoom.PersonalizacionNivel where EventoID = @EventoId and NivelId = 0
delete from ShowRoom.Categoria where EventoId = @EventoID

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[InsertShowRoomCategoria]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].InsertShowRoomCategoria
GO

create procedure ShowRoom.InsertShowRoomCategoria
@EventoID int,
@Codigo varchar(50),
@Descripcion varchar(200)
as
begin

insert into ShowRoom.Categoria (EventoID, Codigo, Descripcion) values (@EventoID, @Codigo, @Descripcion)

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomCompraPorCompra]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomCompraPorCompra
GO

create procedure ShowRoom.GetShowRoomCompraPorCompra
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

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[UpdStockOfertaShowRoomMasivo]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].UpdStockOfertaShowRoomMasivo
GO

IF (SELECT COUNT(*) FROM sys.table_types WHERE name = 'StockPrecioOfertaShowRoomType') = 1
	drop type ShowRoom.StockPrecioOfertaShowRoomType

go

go

IF (SELECT COUNT(*) FROM sys.table_types WHERE name = 'StockPrecioOfertaShowRoomType') = 0  
  CREATE TYPE ShowRoom.StockPrecioOfertaShowRoomType AS TABLE ( 
	TipoOfertaSisID int, CampaniaID int, CUV varchar(20), Stock int, PrecioOferta decimal(18,2), UnidadesPermitidas int,
	Descripcion varchar(250), CodigoCategoria varchar(100), TipNegocio varchar(500)
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
	TipNegocio = t.TipNegocio
FROM ShowRoom.OfertaShowRoom o
INNER JOIN ods.Campania c on 
	c.CampaniaID = o.CampaniaID
JOIN @StockPrecioOfertaShowRoom t ON 
	c.Codigo = t.CampaniaID
	AND o.CUV = t.CUV
	AND o.TipoOfertaSisID = t.TipoOfertaSisID

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[InsertCargaMasivaOfertaDetalle]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].InsertCargaMasivaOfertaDetalle
GO

IF (SELECT COUNT(*) FROM sys.table_types WHERE name = 'OfertaShowRoomDetalleType') = 1
	drop type ShowRoom.OfertaShowRoomDetalleType

go

go

IF (SELECT COUNT(*) FROM sys.table_types WHERE name = 'OfertaShowRoomDetalleType') = 0 
CREATE TYPE ShowRoom.OfertaShowRoomDetalleType AS TABLE(
	CUV varchar(20) NULL,
	NombreProducto varchar(150) NULL,
	Descripcion1 varchar(150) NULL,
	Descripcion2 varchar(150) NULL,
	Descripcion3 varchar(150) NULL,
	Posicion int NULL,
	MarcaProducto varchar(100) NULL
)

go

create procedure ShowRoom.InsertCargaMasivaOfertaDetalle
@OfertaShowRoomDetalle ShowRoom.OfertaShowRoomDetalleType readonly,
@CampaniaID int,
@UsuarioCreacion varchar(50)
as
begin

begin tran

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

delete from ShowRoom.OfertaShowRoomDetalle
	where OfertaShowRoomDetalleID not in (select o.OfertaShowRoomDetalleID from ShowRoom.OfertaShowRoomDetalle o
	inner join @OfertaShowRoomDetalle t on
	o.CUV = t.CUV
	and o.Posicion = t.Posicion)

update ShowRoom.OfertaShowRoomDetalle
set NombreProducto = t.NombreProducto,
	Descripcion1 = t.Descripcion1,
	Descripcion2 = t.Descripcion2,
	Descripcion3 = t.Descripcion3,
	UsuarioModificacion = @UsuarioCreacion,
	MarcaProducto = t.MarcaProducto
from ShowRoom.OfertaShowRoomDetalle o
inner join @OfertaShowRoomDetalle t on	
	o.CUV = t.CUV
	and o.Posicion = t.Posicion
	--and o.NombreProducto = t.NombreProducto
where
	o.CampaniaID = @CampaniaID	

insert into ShowRoom.OfertaShowRoomDetalle
(CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,FechaCreacion,UsuarioCreacion,
FechaModificacion,UsuarioModificacion,Posicion,MarcaProducto)
select @CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,getdate(),@UsuarioCreacion,
getdate(),@UsuarioCreacion,Posicion,MarcaProducto
from @OfertaShowRoomDetalle
where 
	NombreProducto not in (select NombreProducto from ShowRoom.OfertaShowRoomDetalle o where o.CampaniaID = @CampaniaID
		and o.CUV = CUV)

end

commit tran

IF (@@ERROR <> 0) BEGIN
PRINT 'Error Inesperado!'
    ROLLBACK TRAN
END

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[InsertCargarProductoCpc]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].InsertCargarProductoCpc
GO

IF (SELECT COUNT(*) FROM sys.table_types WHERE name = 'OfertaShowRoomCompraPorCompraType') = 1
	drop type ShowRoom.OfertaShowRoomCompraPorCompraType

go

go

IF (SELECT COUNT(*) FROM sys.table_types WHERE name = 'OfertaShowRoomCompraPorCompraType') = 0  
  CREATE TYPE ShowRoom.OfertaShowRoomCompraPorCompraType AS TABLE ( 
	CUV varchar(20), SAP varchar(12), Orden int, PrecioValorizado decimal(18,2)
  )
GO

create procedure ShowRoom.InsertCargarProductoCpc
@OfertaShowRoomCompraPorCompra ShowRoom.OfertaShowRoomCompraPorCompraType readonly,
@EventoID int,
@UsuarioCreacion varchar(50)
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

declare @tablaCuv table ( CUV varchar(6))
insert into @tablaCuv
select distinct CUV from ShowRoom.CompraPorCompra where EventoID = @EventoID

update ShowRoom.CompraPorCompra
set 
	Orden = o.Orden,
	PrecioValorizado = o.PrecioValorizado,
	UsuarioModificacion = @UsuarioCreacion,
	FechaModificacion = @FechaGeneral
from ShowRoom.CompraPorCompra cpc
inner join @OfertaShowRoomCompraPorCompra o on
	cpc.CUV = o.CUV
	and cpc.SAP = o.SAP
where cpc.EventoID = @EventoID

insert into ShowRoom.CompraPorCompra (EventoID, CUV, SAP, Orden, PrecioValorizado, 
FechaCreacion, FechaModificacion, UsuarioCreacion, UsuarioModificacion)
select 
	@EventoID, CUV, SAP, Orden, PrecioValorizado, 
	@FechaGeneral, @FechaGeneral, @UsuarioCreacion, @UsuarioCreacion
from @OfertaShowRoomCompraPorCompra
where CUV not in (
	select CUV from @tablaCuv
)

end

go

ALTER procedure ShowRoom.InsertShowRoomEvento
@EventoID int output,
@CampaniaID int,
@Nombre varchar(150),
@Tema varchar(150),
@DiasAntes int,
@DiasDespues int,
@NumeroPerfiles int,
@UsuarioCreacion varchar(20),
@TieneCategoria bit,
@TieneCompraXcompra bit
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

insert into ShowRoom.Evento
(CampaniaID, Nombre, Tema, DiasAntes, DiasDespues, NumeroPerfiles, 
FechaCreacion, UsuarioCreacion, FechaModificacion, UsuarioModificacion, Estado, TieneCategoria, TieneCompraXcompra)
values
(@CampaniaID, @Nombre, @Tema, @DiasAntes, @DiasDespues, @NumeroPerfiles,
@FechaGeneral, @UsuarioCreacion, @FechaGeneral, @UsuarioCreacion, 1, @TieneCategoria, @TieneCompraXcompra)

set @EventoID = @@IDENTITY

end

GO

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
@TieneCompraXcompra bit
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
	TieneCompraXcompra = @TieneCompraXcompra
where EventoID = @EventoID

end

go

alter procedure ShowRoom.GetShowRoomEventoByCampaniaID
@CampaniaID int
as
/*
ShowRoom.GetShowRoomEventoByCampaniaID 201705
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
	isnull(TieneCompraXcompra,0) as TieneCompraXcompra
from ShowRoom.Evento
where CampaniaID = @CampaniaID

end

go

ALTER procedure ShowRoom.InsertShowRoomCargarMasivaConsultora
@EventoConsultora ShowRoom.EventoConsultoraType readonly
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

INSERT INTO ShowRoom.EventoConsultora(EventoID, CampaniaID, CodigoConsultora, Segmento, MostrarPopup,
MostrarPopupVenta, FechaCreacion, UsuarioCreacion, FechaModificacion, UsuarioModificacion)
SELECT DISTINCT EventoID, CampaniaID, CodigoConsultora, Segmento, 1,
1, @FechaGeneral, UsuarioCreacion, @FechaGeneral, UsuarioCreacion
FROM @EventoConsultora

end

go

ALTER procedure ShowRoom.GetShowRoomConsultora
@CampaniaID int,
@CodigoConsultora varchar(20)
as
/*
ShowRoom.GetShowRoomConsultora 201704,'0193037'
*/
begin

select top 1
EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,MostrarPopup,
MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion
from ShowRoom.EventoConsultora
where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
order by FechaCreacion desc

end

go

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

go

ALTER procedure ShowRoom.GetProductosShowRoomDetalle
@CampaniaID int,
@CUV varchar(5)
as
/*
ShowRoom.GetProductosShowRoomDetalle 201705,'96248'
ShowRoom.GetProductosShowRoomDetalle 201705,'99008'
*/
begin

select top 3
	OfertaShowRoomDetalleID,
	CampaniaID,
	CUV,
	isnull(NombreProducto,'') as NombreProducto,
	isnull(Descripcion1,'') as Descripcion1,
	isnull(Descripcion2,'') as Descripcion2,
	isnull(Descripcion3,'') as Descripcion3,
	isnull(Imagen,'') as Imagen,
	FechaCreacion,
	UsuarioCreacion,
	FechaModificacion,
	UsuarioModificacion,
	Posicion,
	MarcaProducto
from ShowRoom.OfertaShowRoomDetalle
where 
	CampaniaID = @CampaniaID
	and CUV = @CUV

end

go

ALTER procedure ShowRoom.InsOfertaShowRoomDetalle
@CampaniaID int,
@CUV varchar(5),
@NombreProducto varchar(100),
@Descripcion1 varchar(150),
@Descripcion2 varchar(150),
@Descripcion3 varchar(150),
@Imagen varchar(150),
@UsuarioCreacion varchar(50),
@MarcaProducto varchar(100)
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

declare @Posicion int = 0
select @Posicion = max(Posicion) from ShowRoom.OfertaShowRoomDetalle
where 
	CampaniaID = @CampaniaID
	and CUV = @CUV

insert into ShowRoom.OfertaShowRoomDetalle
(CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,
Imagen,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,Posicion,MarcaProducto)
values
(@CampaniaID,@CUV,@NombreProducto,@Descripcion1,@Descripcion2,@Descripcion3,
@Imagen,@FechaGeneral,@UsuarioCreacion,@FechaGeneral,@UsuarioCreacion,@Posicion+1,@MarcaProducto)

end

go

ALTER procedure ShowRoom.UpdOfertaShowRoomDetalle
@OfertaShowRoomDetalleID int,
@CampaniaID int,
@CUV varchar(5),
@NombreProducto varchar(100),
@Descripcion1 varchar(150),
@Descripcion2 varchar(150),
@Descripcion3 varchar(150),
@Imagen varchar(150),
@UsuarioModificacion varchar(50),
@MarcaProducto varchar(100)
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

update ShowRoom.OfertaShowRoomDetalle
set
	NombreProducto = @NombreProducto,
	Descripcion1 = @Descripcion1,
	Descripcion2 = @Descripcion2,
	Descripcion3 = @Descripcion3,
	Imagen = @Imagen,
	UsuarioModificacion = @UsuarioModificacion,
	FechaModificacion = @FechaGeneral,
	MarcaProducto = @MarcaProducto
where
	OfertaShowRoomDetalleID = @OfertaShowRoomDetalleID
	and CampaniaID = @CampaniaID
	and CUV = @CUV

end

go


ALTER PROCEDURE dbo.InsPedidoWebDetalleOferta_SB2
	@CampaniaID int,
	@ConsultoraID int,
	@MarcaID tinyint,
	@Cantidad int,
	@PrecioUnidad money,
	@CUV varchar(20),
	@ConfiguracionOfertaID INT,
	@TipoOfertaSisID INT,
	@PaisID int,
	@IPUsuario varchar(25) = null,
	@CodigoUsuarioCreacion varchar(25) = null,
	@OrigenPedidoWeb int = 0,
	@EsCompraPorCompra bit = 0
AS
BEGIN
DECLARE @PedidoDetalleID INT;
DECLARE @PedidoID  INT = 0;
DECLARE @OfertaWeb INT  = 1;
DECLARE @ExisteDet INT = 0;
DECLARE @Orden INT=0;

	EXEC [dbo].[InsPedidoWebOferta] @CampaniaID, @ConsultoraID , @PaisID, @IPUsuario, @CodigoUsuarioCreacion;

	if @TipoOfertaSisID = 1707
	begin
		set @OfertaWeb = 0
	end

	if @EsCompraPorCompra = 1
	begin
		set @OfertaWeb = 0
	end

	SELECT @PedidoID = PedidoID FROM dbo.PedidoWeb WHERE CampaniaID = @CampaniaID AND ConsultoraID = @ConsultoraID;

	SELECT @PedidoDetalleID = MAX(ISNULL(PedidoDetalleID,0))
		   , @Orden = max(ISNULL(OrdenPedidoWD,0))
		   FROM dbo.PedidoWebDetalle 
		   WHERE CampaniaID = @CampaniaID AND PedidoID = @PedidoID
	
	SET @PedidoDetalleID = ISNULL(@PedidoDetalleID, 0) + 1
	SET @Orden = ISNULL(@Orden, 0) + 1

	--SET @PedidoDetalleID =	(SELECT ISNULL(MAX(PedidoDetalleID),0) + 1 
	--							FROM	dbo.PedidoWebDetalle 
	--							WHERE	CampaniaID = @CampaniaID AND
	--									PedidoID = @PedidoID);

	/* Validar Al Agregar Nuevamente */
	set @ExisteDet = (select count(*) from PedidoWebDetalle 
						where CampaniaID = @CampaniaID 
							  AND PedidoID = @PedidoID
							  AND CUV = @CUV
							  AND ClienteID IS NULL);

	IF @ExisteDet = 0 
		BEGIN
			INSERT INTO dbo.PedidoWebDetalle 
			(
			 CampaniaID,
			 PedidoID,
			 PedidoDetalleID,
			 MarcaID,
			 ConsultoraID,
			 ClienteID,
			 Cantidad,
			 PrecioUnidad,
			 ImporteTotal,
			 CUV,
			 OfertaWeb, 
			 ModificaPedidoReservado,
			 ConfiguracionOfertaID,
			 TipoOfertaSisID,
			 CodigoUsuarioCreacion,
			 FechaCreacion,
			 OrdenPedidoWD,
			 OrigenPedidoWeb
			)

		VALUES (@CampaniaID,@PedidoID,@PedidoDetalleID,
				@MarcaID,@ConsultoraID,NULL,
				@Cantidad,@PrecioUnidad,@Cantidad*@PrecioUnidad,@CUV,@OfertaWeb,0, @ConfiguracionOfertaID, @TipoOfertaSisID,
				@CodigoUsuarioCreacion, dbo.fnObtenerFechaHoraPais(), @Orden, @OrigenPedidoWeb)
		END
	ELSE
		BEGIN
			UPDATE dbo.PedidoWebDetalle
				SET Cantidad += @Cantidad,
					ImporteTotal = ((Cantidad + @Cantidad) * @PrecioUnidad),
					CodigoUsuarioModificacion = @CodigoUsuarioCreacion,
					FechaModificacion = dbo.fnObtenerFechaHoraPais(),
					OrdenPedidoWD = @Orden,
					OrigenPedidoWeb = @OrigenPedidoWeb
			WHERE CampaniaID = @CampaniaID 
				  AND PedidoID = @PedidoID
				  AND CUV = @CUV
				  AND ClienteID IS NULL		
		END
END

GO

USE BelcorpMexico
go

delete from dbo.TablaLogicaDatos where TablaLogicaID = 99
delete from dbo.TablaLogica where TablaLogicaID = 99

go

if not exists (select 1 from dbo.TablaLogica where TablaLogicaID = 99)
begin
	insert into dbo.TablaLogica(TablaLogicaID,Descripcion) values (99,'OrdenamientoShowRoom')
end

go

if not exists (select 1 from dbo.TablaLogicaDatos where TablaLogicaID = 99 and Codigo='01')
begin
	insert into dbo.TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) 
	values (9901,99,'01','Los más vendidos')
end

go

if not exists (select 1 from dbo.TablaLogicaDatos where TablaLogicaID = 99 and Codigo='02')
begin
	insert into dbo.TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) 
	values (9902,99,'02','Menor a mayor precio')
end

go

if not exists (select 1 from dbo.TablaLogicaDatos where TablaLogicaID = 99 and Codigo='03')
begin
	insert into dbo.TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) 
	values (9903,99,'03','Mayor a menor precio')
end

go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.Evento') and SYSCOLUMNS.NAME = N'TieneCategoria') = 0
	ALTER TABLE ShowRoom.Evento ADD TieneCategoria bit
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.Evento') and SYSCOLUMNS.NAME = N'TieneCompraXcompra') = 0
	ALTER TABLE ShowRoom.Evento ADD TieneCompraXcompra bit
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'CodigoCategoria') = 0
	ALTER TABLE ShowRoom.OfertaShowRoom ADD CodigoCategoria varchar(100)
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'TipNegocio') = 0
	ALTER TABLE ShowRoom.OfertaShowRoom ADD TipNegocio varchar(500)
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoomDetalle') and SYSCOLUMNS.NAME = N'MarcaProducto') = 0
	ALTER TABLE ShowRoom.OfertaShowRoomDetalle ADD MarcaProducto varchar(100)
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.EventoConsultora') and SYSCOLUMNS.NAME = N'MostrarPopupVenta') = 0
	ALTER TABLE ShowRoom.EventoConsultora ADD MostrarPopupVenta bit
go

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[Nivel]') AND (type = 'U') )
	DROP TABLE ShowRoom.Nivel
GO

create table ShowRoom.Nivel
(
	NivelId int identity(1,1) primary key,
	Codigo varchar(100),
	Descripcion varchar(100)
)

go

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[Personalizacion]') AND (type = 'U') )
	DROP TABLE ShowRoom.Personalizacion
GO

create table ShowRoom.Personalizacion
(
	PersonalizacionId int identity(1,1) primary key,
	TipoAplicacion varchar(20),
	Atributo varchar(100),
	TextoAyuda varchar(200),
	TipoAtributo varchar(20),
	TipoPersonalizacion varchar(20),
	Orden int,
	Estado bit
)

go

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[PersonalizacionNivel]') AND (type = 'U') )
	DROP TABLE ShowRoom.PersonalizacionNivel
GO

create table ShowRoom.PersonalizacionNivel
(
	PersonalizacionNivelId int identity(1,1) primary key,
	EventoID int,
	PersonalizacionId int,
	NivelId int,
	CategoriaId int,
	Valor varchar(200)
)

go

CREATE NONCLUSTERED INDEX IX_ShowRoomPersonalizacionNivel_EventoIdNivelId ON ShowRoom.PersonalizacionNivel (EventoID,NivelId);

go

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[Categoria]') AND (type = 'U') )
	DROP TABLE ShowRoom.Categoria
GO

create table ShowRoom.Categoria
(
	CategoriaId int identity(1,1) primary key,
	EventoID int,
	Codigo varchar(50),
	Descripcion varchar(200)
)

go

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[CompraPorCompra]') AND (type = 'U') )
	DROP TABLE ShowRoom.CompraPorCompra
GO

CREATE TABLE ShowRoom.CompraPorCompra
(
	CompraxCompraID int identity(1,1) primary key,
	EventoID int,
	CUV varchar(20),
	SAP varchar(12),
	Orden int,
	PrecioValorizado decimal(18,2),
	FechaCreacion datetime,
	UsuarioCreacion varchar(50),
	FechaModificacion datetime,
	UsuarioModificacion varchar(50)
)

GO

insert into ShowRoom.Nivel (Codigo,Descripcion) values ('PAIS','País')

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','PopupImagenIntriga','Popup Principal Intriga (615px x 409px)','IMAGEN','EVENTO',1,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','PopupImagenVenta','Popup Principal Venta (615px x 409px)','IMAGEN','EVENTO',2,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','BannerImagenIntriga','Visual Superior Intriga (1920px x 174px)','IMAGEN','EVENTO',3,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','BannerImagenVenta','Visual Superior Venta (1920px x 174px)','IMAGEN','EVENTO',4,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','UrlTerminosCondiciones','Link Terminos y Condiciones','TEXTO','EVENTO',5,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','TextoCondicionCompraCpc','Texto Condición de Compra por Compra','TEXTO','EVENTO',6,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','TextoDescripcionLegalCpc','Texto Descripción Legal Compra por Compra','TEXTO','EVENTO',7,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','IconoLluvia','Icono Lluvia Paginal Principal','IMAGEN','EVENTO',8,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','BannerEnvioCorreo','Imagen Envio Correo','IMAGEN','EVENTO',9,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','TextoEnvioCorreo','Texto mostrar Envio Correo','TEXTO','EVENTO',10,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','ImagenFondoProductPage','Imagen de Fondo del Product Page','IMAGEN','EVENTO',11,1)

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','TituloPrincipal','Título de la Categoria','TEXTO','CATEGORIA',12,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','ImagenPrincipal','Imagen a mostrar en la Categoria','IMAGEN','CATEGORIA',13,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','ColorFondo','Color de Fondo de la Categoria','TEXTO','CATEGORIA',14,1)

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','PopupImagenIntriga','Banner Marquesina Intriga (768px x 420px)','IMAGEN','EVENTO',1,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','PopupImagenVenta','Banner Marquesina Venta (768px x 420px)','IMAGEN','EVENTO',2,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','BannerImagenIntriga','Banner Superior Intriga (1024px x 60px)','IMAGEN','EVENTO',3,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','BannerImagenPaginaVenta','Banner Superior Pagina Venta (1024px x 60px)','IMAGEN','EVENTO',4,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','BannerImagenVenta','Banner Superior Venta Otras Paginas (1024px x 60px)','IMAGEN','EVENTO',5,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','UrlTerminosCondiciones','Link Terminos y Condiciones','TEXTO','EVENTO',6,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','TextoCondicionCompraCpc','Texto Condición de Compra','TEXTO','EVENTO',7,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','TextoDescripcionLegalCpc','Texto Descripción Legal Compra por Compra','TEXTO','EVENTO',8,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','ImagenFondoProductPage','Imagen de Fondo del Product Page','IMAGEN','EVENTO',9,1)

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','TituloPrincipal','Título de la Categoria','TEXTO','CATEGORIA',10,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','ColorFondo','Color de Fondo de la Categoria','TEXTO','CATEGORIA',11,1)

go

update ShowRoom.EventoConsultora set MostrarPopup = 1 where MostrarPopup is null
update ShowRoom.EventoConsultora set MostrarPopupVenta = 1 where MostrarPopupVenta is null

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomNivel]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomNivel
GO

create procedure ShowRoom.GetShowRoomNivel
as
/*
ShowRoom.GetShowRoomNivel
*/
begin

select
	NivelId,
	Codigo,
	Descripcion
from ShowRoom.Nivel

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomPersonalizacion]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomPersonalizacion
GO

create procedure ShowRoom.GetShowRoomPersonalizacion
as
/*
ShowRoom.GetShowRoomPersonalizacion
*/
begin

select
	PersonalizacionId,
	TipoAplicacion,
	Atributo,
	TextoAyuda,
	TipoAtributo,
	TipoPersonalizacion,
	Orden,
	Estado
from ShowRoom.Personalizacion

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomPersonalizacionNivel]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomPersonalizacionNivel
GO

create procedure ShowRoom.GetShowRoomPersonalizacionNivel
@EventoId int,
@NivelId int = 0,
@CategoriaId int = 0
as
/*
ShowRoom.GetShowRoomPersonalizacionNivel 2006,1,0
ShowRoom.GetShowRoomPersonalizacionNivel 2006,0,1
*/
begin

select 
	PersonalizacionNivelId,
	EventoID,
	PersonalizacionId,
	isnull(NivelId,0) as NivelId,
	isnull(CategoriaId,0) as CategoriaId,
	isnull(Valor,'') as Valor
from ShowRoom.PersonalizacionNivel
where
	EventoID = @EventoId
	and (@NivelId = 0 or NivelId = @NivelId)
	and (@CategoriaId = 0 or CategoriaId = @CategoriaId)

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[InsertShowRoomPersonalizacionNivel]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].InsertShowRoomPersonalizacionNivel
GO

create procedure ShowRoom.InsertShowRoomPersonalizacionNivel
@EventoID int,
@PersonalizacionId int,
@NivelId int,
@CategoriaId int = 0,
@Valor varchar(200)
as
begin

insert into ShowRoom.PersonalizacionNivel (EventoID, PersonalizacionId, NivelId, CategoriaId, Valor)
values (@EventoID, @PersonalizacionId, @NivelId, @CategoriaId, @Valor)

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[UpdateShowRoomPersonalizacionNivel]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].UpdateShowRoomPersonalizacionNivel
GO

create procedure ShowRoom.UpdateShowRoomPersonalizacionNivel
@PersonalizacionNivelId int,
@Valor varchar(200)
as
begin

update ShowRoom.PersonalizacionNivel
	set Valor = @Valor
where PersonalizacionNivelId = @PersonalizacionNivelId

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomCategorias]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomCategorias
GO

create procedure ShowRoom.GetShowRoomCategorias
@EventoId int
as
/*
ShowRoom.GetShowRoomCategorias 6
*/
begin

select
	CategoriaId,
	EventoID,
	Codigo,
	Descripcion
from ShowRoom.Categoria
where EventoID = @EventoId

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomCategoriaById]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomCategoriaById
GO

create procedure ShowRoom.GetShowRoomCategoriaById
@CategoriaId int
as
/*
ShowRoom.GetShowRoomCategoriaById 1
*/
begin

select
	CategoriaId,
	EventoID,
	Codigo,
	Descripcion
from ShowRoom.Categoria
where CategoriaId = @CategoriaId

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[UpdateShowRoomDescripcionCategoria]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].UpdateShowRoomDescripcionCategoria
GO

create procedure ShowRoom.UpdateShowRoomDescripcionCategoria
@CategoriaId int,
@Descripcion varchar(200)
as
begin

update ShowRoom.Categoria
set
	Descripcion = @Descripcion
where 
	CategoriaId = @CategoriaId

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[DeleteShowRoomCategoriaByEvento]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].DeleteShowRoomCategoriaByEvento
GO

create procedure ShowRoom.DeleteShowRoomCategoriaByEvento
@EventoId int
as
begin

delete from ShowRoom.PersonalizacionNivel where EventoID = @EventoId and NivelId = 0
delete from ShowRoom.Categoria where EventoId = @EventoID

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[InsertShowRoomCategoria]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].InsertShowRoomCategoria
GO

create procedure ShowRoom.InsertShowRoomCategoria
@EventoID int,
@Codigo varchar(50),
@Descripcion varchar(200)
as
begin

insert into ShowRoom.Categoria (EventoID, Codigo, Descripcion) values (@EventoID, @Codigo, @Descripcion)

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomCompraPorCompra]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomCompraPorCompra
GO

create procedure ShowRoom.GetShowRoomCompraPorCompra
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

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[UpdStockOfertaShowRoomMasivo]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].UpdStockOfertaShowRoomMasivo
GO

IF (SELECT COUNT(*) FROM sys.table_types WHERE name = 'StockPrecioOfertaShowRoomType') = 1
	drop type ShowRoom.StockPrecioOfertaShowRoomType

go

go

IF (SELECT COUNT(*) FROM sys.table_types WHERE name = 'StockPrecioOfertaShowRoomType') = 0  
  CREATE TYPE ShowRoom.StockPrecioOfertaShowRoomType AS TABLE ( 
	TipoOfertaSisID int, CampaniaID int, CUV varchar(20), Stock int, PrecioOferta decimal(18,2), UnidadesPermitidas int,
	Descripcion varchar(250), CodigoCategoria varchar(100), TipNegocio varchar(500)
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
	TipNegocio = t.TipNegocio
FROM ShowRoom.OfertaShowRoom o
INNER JOIN ods.Campania c on 
	c.CampaniaID = o.CampaniaID
JOIN @StockPrecioOfertaShowRoom t ON 
	c.Codigo = t.CampaniaID
	AND o.CUV = t.CUV
	AND o.TipoOfertaSisID = t.TipoOfertaSisID

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[InsertCargaMasivaOfertaDetalle]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].InsertCargaMasivaOfertaDetalle
GO

IF (SELECT COUNT(*) FROM sys.table_types WHERE name = 'OfertaShowRoomDetalleType') = 1
	drop type ShowRoom.OfertaShowRoomDetalleType

go

go

IF (SELECT COUNT(*) FROM sys.table_types WHERE name = 'OfertaShowRoomDetalleType') = 0 
CREATE TYPE ShowRoom.OfertaShowRoomDetalleType AS TABLE(
	CUV varchar(20) NULL,
	NombreProducto varchar(150) NULL,
	Descripcion1 varchar(150) NULL,
	Descripcion2 varchar(150) NULL,
	Descripcion3 varchar(150) NULL,
	Posicion int NULL,
	MarcaProducto varchar(100) NULL
)

go

create procedure ShowRoom.InsertCargaMasivaOfertaDetalle
@OfertaShowRoomDetalle ShowRoom.OfertaShowRoomDetalleType readonly,
@CampaniaID int,
@UsuarioCreacion varchar(50)
as
begin

begin tran

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

delete from ShowRoom.OfertaShowRoomDetalle
	where OfertaShowRoomDetalleID not in (select o.OfertaShowRoomDetalleID from ShowRoom.OfertaShowRoomDetalle o
	inner join @OfertaShowRoomDetalle t on
	o.CUV = t.CUV
	and o.Posicion = t.Posicion)

update ShowRoom.OfertaShowRoomDetalle
set NombreProducto = t.NombreProducto,
	Descripcion1 = t.Descripcion1,
	Descripcion2 = t.Descripcion2,
	Descripcion3 = t.Descripcion3,
	UsuarioModificacion = @UsuarioCreacion,
	MarcaProducto = t.MarcaProducto
from ShowRoom.OfertaShowRoomDetalle o
inner join @OfertaShowRoomDetalle t on	
	o.CUV = t.CUV
	and o.Posicion = t.Posicion
	--and o.NombreProducto = t.NombreProducto
where
	o.CampaniaID = @CampaniaID	

insert into ShowRoom.OfertaShowRoomDetalle
(CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,FechaCreacion,UsuarioCreacion,
FechaModificacion,UsuarioModificacion,Posicion,MarcaProducto)
select @CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,getdate(),@UsuarioCreacion,
getdate(),@UsuarioCreacion,Posicion,MarcaProducto
from @OfertaShowRoomDetalle
where 
	NombreProducto not in (select NombreProducto from ShowRoom.OfertaShowRoomDetalle o where o.CampaniaID = @CampaniaID
		and o.CUV = CUV)

end

commit tran

IF (@@ERROR <> 0) BEGIN
PRINT 'Error Inesperado!'
    ROLLBACK TRAN
END

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[InsertCargarProductoCpc]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].InsertCargarProductoCpc
GO

IF (SELECT COUNT(*) FROM sys.table_types WHERE name = 'OfertaShowRoomCompraPorCompraType') = 1
	drop type ShowRoom.OfertaShowRoomCompraPorCompraType

go

go

IF (SELECT COUNT(*) FROM sys.table_types WHERE name = 'OfertaShowRoomCompraPorCompraType') = 0  
  CREATE TYPE ShowRoom.OfertaShowRoomCompraPorCompraType AS TABLE ( 
	CUV varchar(20), SAP varchar(12), Orden int, PrecioValorizado decimal(18,2)
  )
GO

create procedure ShowRoom.InsertCargarProductoCpc
@OfertaShowRoomCompraPorCompra ShowRoom.OfertaShowRoomCompraPorCompraType readonly,
@EventoID int,
@UsuarioCreacion varchar(50)
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

declare @tablaCuv table ( CUV varchar(6))
insert into @tablaCuv
select distinct CUV from ShowRoom.CompraPorCompra where EventoID = @EventoID

update ShowRoom.CompraPorCompra
set 
	Orden = o.Orden,
	PrecioValorizado = o.PrecioValorizado,
	UsuarioModificacion = @UsuarioCreacion,
	FechaModificacion = @FechaGeneral
from ShowRoom.CompraPorCompra cpc
inner join @OfertaShowRoomCompraPorCompra o on
	cpc.CUV = o.CUV
	and cpc.SAP = o.SAP
where cpc.EventoID = @EventoID

insert into ShowRoom.CompraPorCompra (EventoID, CUV, SAP, Orden, PrecioValorizado, 
FechaCreacion, FechaModificacion, UsuarioCreacion, UsuarioModificacion)
select 
	@EventoID, CUV, SAP, Orden, PrecioValorizado, 
	@FechaGeneral, @FechaGeneral, @UsuarioCreacion, @UsuarioCreacion
from @OfertaShowRoomCompraPorCompra
where CUV not in (
	select CUV from @tablaCuv
)

end

go

ALTER procedure ShowRoom.InsertShowRoomEvento
@EventoID int output,
@CampaniaID int,
@Nombre varchar(150),
@Tema varchar(150),
@DiasAntes int,
@DiasDespues int,
@NumeroPerfiles int,
@UsuarioCreacion varchar(20),
@TieneCategoria bit,
@TieneCompraXcompra bit
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

insert into ShowRoom.Evento
(CampaniaID, Nombre, Tema, DiasAntes, DiasDespues, NumeroPerfiles, 
FechaCreacion, UsuarioCreacion, FechaModificacion, UsuarioModificacion, Estado, TieneCategoria, TieneCompraXcompra)
values
(@CampaniaID, @Nombre, @Tema, @DiasAntes, @DiasDespues, @NumeroPerfiles,
@FechaGeneral, @UsuarioCreacion, @FechaGeneral, @UsuarioCreacion, 1, @TieneCategoria, @TieneCompraXcompra)

set @EventoID = @@IDENTITY

end

GO

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
@TieneCompraXcompra bit
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
	TieneCompraXcompra = @TieneCompraXcompra
where EventoID = @EventoID

end

go

alter procedure ShowRoom.GetShowRoomEventoByCampaniaID
@CampaniaID int
as
/*
ShowRoom.GetShowRoomEventoByCampaniaID 201705
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
	isnull(TieneCompraXcompra,0) as TieneCompraXcompra
from ShowRoom.Evento
where CampaniaID = @CampaniaID

end

go

ALTER procedure ShowRoom.InsertShowRoomCargarMasivaConsultora
@EventoConsultora ShowRoom.EventoConsultoraType readonly
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

INSERT INTO ShowRoom.EventoConsultora(EventoID, CampaniaID, CodigoConsultora, Segmento, MostrarPopup,
MostrarPopupVenta, FechaCreacion, UsuarioCreacion, FechaModificacion, UsuarioModificacion)
SELECT DISTINCT EventoID, CampaniaID, CodigoConsultora, Segmento, 1,
1, @FechaGeneral, UsuarioCreacion, @FechaGeneral, UsuarioCreacion
FROM @EventoConsultora

end

go

ALTER procedure ShowRoom.GetShowRoomConsultora
@CampaniaID int,
@CodigoConsultora varchar(20)
as
/*
ShowRoom.GetShowRoomConsultora 201704,'0193037'
*/
begin

select top 1
EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,MostrarPopup,
MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion
from ShowRoom.EventoConsultora
where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
order by FechaCreacion desc

end

go

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

go

ALTER procedure ShowRoom.GetProductosShowRoomDetalle
@CampaniaID int,
@CUV varchar(5)
as
/*
ShowRoom.GetProductosShowRoomDetalle 201705,'96248'
ShowRoom.GetProductosShowRoomDetalle 201705,'99008'
*/
begin

select top 3
	OfertaShowRoomDetalleID,
	CampaniaID,
	CUV,
	isnull(NombreProducto,'') as NombreProducto,
	isnull(Descripcion1,'') as Descripcion1,
	isnull(Descripcion2,'') as Descripcion2,
	isnull(Descripcion3,'') as Descripcion3,
	isnull(Imagen,'') as Imagen,
	FechaCreacion,
	UsuarioCreacion,
	FechaModificacion,
	UsuarioModificacion,
	Posicion,
	MarcaProducto
from ShowRoom.OfertaShowRoomDetalle
where 
	CampaniaID = @CampaniaID
	and CUV = @CUV

end

go

ALTER procedure ShowRoom.InsOfertaShowRoomDetalle
@CampaniaID int,
@CUV varchar(5),
@NombreProducto varchar(100),
@Descripcion1 varchar(150),
@Descripcion2 varchar(150),
@Descripcion3 varchar(150),
@Imagen varchar(150),
@UsuarioCreacion varchar(50),
@MarcaProducto varchar(100)
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

declare @Posicion int = 0
select @Posicion = max(Posicion) from ShowRoom.OfertaShowRoomDetalle
where 
	CampaniaID = @CampaniaID
	and CUV = @CUV

insert into ShowRoom.OfertaShowRoomDetalle
(CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,
Imagen,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,Posicion,MarcaProducto)
values
(@CampaniaID,@CUV,@NombreProducto,@Descripcion1,@Descripcion2,@Descripcion3,
@Imagen,@FechaGeneral,@UsuarioCreacion,@FechaGeneral,@UsuarioCreacion,@Posicion+1,@MarcaProducto)

end

go

ALTER procedure ShowRoom.UpdOfertaShowRoomDetalle
@OfertaShowRoomDetalleID int,
@CampaniaID int,
@CUV varchar(5),
@NombreProducto varchar(100),
@Descripcion1 varchar(150),
@Descripcion2 varchar(150),
@Descripcion3 varchar(150),
@Imagen varchar(150),
@UsuarioModificacion varchar(50),
@MarcaProducto varchar(100)
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

update ShowRoom.OfertaShowRoomDetalle
set
	NombreProducto = @NombreProducto,
	Descripcion1 = @Descripcion1,
	Descripcion2 = @Descripcion2,
	Descripcion3 = @Descripcion3,
	Imagen = @Imagen,
	UsuarioModificacion = @UsuarioModificacion,
	FechaModificacion = @FechaGeneral,
	MarcaProducto = @MarcaProducto
where
	OfertaShowRoomDetalleID = @OfertaShowRoomDetalleID
	and CampaniaID = @CampaniaID
	and CUV = @CUV

end

go


ALTER PROCEDURE dbo.InsPedidoWebDetalleOferta_SB2
	@CampaniaID int,
	@ConsultoraID int,
	@MarcaID tinyint,
	@Cantidad int,
	@PrecioUnidad money,
	@CUV varchar(20),
	@ConfiguracionOfertaID INT,
	@TipoOfertaSisID INT,
	@PaisID int,
	@IPUsuario varchar(25) = null,
	@CodigoUsuarioCreacion varchar(25) = null,
	@OrigenPedidoWeb int = 0,
	@EsCompraPorCompra bit = 0
AS
BEGIN
DECLARE @PedidoDetalleID INT;
DECLARE @PedidoID  INT = 0;
DECLARE @OfertaWeb INT  = 1;
DECLARE @ExisteDet INT = 0;
DECLARE @Orden INT=0;

	EXEC [dbo].[InsPedidoWebOferta] @CampaniaID, @ConsultoraID , @PaisID, @IPUsuario, @CodigoUsuarioCreacion;

	if @TipoOfertaSisID = 1707
	begin
		set @OfertaWeb = 0
	end

	if @EsCompraPorCompra = 1
	begin
		set @OfertaWeb = 0
	end

	SELECT @PedidoID = PedidoID FROM dbo.PedidoWeb WHERE CampaniaID = @CampaniaID AND ConsultoraID = @ConsultoraID;

	SELECT @PedidoDetalleID = MAX(ISNULL(PedidoDetalleID,0))
		   , @Orden = max(ISNULL(OrdenPedidoWD,0))
		   FROM dbo.PedidoWebDetalle 
		   WHERE CampaniaID = @CampaniaID AND PedidoID = @PedidoID
	
	SET @PedidoDetalleID = ISNULL(@PedidoDetalleID, 0) + 1
	SET @Orden = ISNULL(@Orden, 0) + 1

	--SET @PedidoDetalleID =	(SELECT ISNULL(MAX(PedidoDetalleID),0) + 1 
	--							FROM	dbo.PedidoWebDetalle 
	--							WHERE	CampaniaID = @CampaniaID AND
	--									PedidoID = @PedidoID);

	/* Validar Al Agregar Nuevamente */
	set @ExisteDet = (select count(*) from PedidoWebDetalle 
						where CampaniaID = @CampaniaID 
							  AND PedidoID = @PedidoID
							  AND CUV = @CUV
							  AND ClienteID IS NULL);

	IF @ExisteDet = 0 
		BEGIN
			INSERT INTO dbo.PedidoWebDetalle 
			(
			 CampaniaID,
			 PedidoID,
			 PedidoDetalleID,
			 MarcaID,
			 ConsultoraID,
			 ClienteID,
			 Cantidad,
			 PrecioUnidad,
			 ImporteTotal,
			 CUV,
			 OfertaWeb, 
			 ModificaPedidoReservado,
			 ConfiguracionOfertaID,
			 TipoOfertaSisID,
			 CodigoUsuarioCreacion,
			 FechaCreacion,
			 OrdenPedidoWD,
			 OrigenPedidoWeb
			)

		VALUES (@CampaniaID,@PedidoID,@PedidoDetalleID,
				@MarcaID,@ConsultoraID,NULL,
				@Cantidad,@PrecioUnidad,@Cantidad*@PrecioUnidad,@CUV,@OfertaWeb,0, @ConfiguracionOfertaID, @TipoOfertaSisID,
				@CodigoUsuarioCreacion, dbo.fnObtenerFechaHoraPais(), @Orden, @OrigenPedidoWeb)
		END
	ELSE
		BEGIN
			UPDATE dbo.PedidoWebDetalle
				SET Cantidad += @Cantidad,
					ImporteTotal = ((Cantidad + @Cantidad) * @PrecioUnidad),
					CodigoUsuarioModificacion = @CodigoUsuarioCreacion,
					FechaModificacion = dbo.fnObtenerFechaHoraPais(),
					OrdenPedidoWD = @Orden,
					OrigenPedidoWeb = @OrigenPedidoWeb
			WHERE CampaniaID = @CampaniaID 
				  AND PedidoID = @PedidoID
				  AND CUV = @CUV
				  AND ClienteID IS NULL		
		END
END

GO

USE BelcorpPanama
go

delete from dbo.TablaLogicaDatos where TablaLogicaID = 99
delete from dbo.TablaLogica where TablaLogicaID = 99

go

if not exists (select 1 from dbo.TablaLogica where TablaLogicaID = 99)
begin
	insert into dbo.TablaLogica(TablaLogicaID,Descripcion) values (99,'OrdenamientoShowRoom')
end

go

if not exists (select 1 from dbo.TablaLogicaDatos where TablaLogicaID = 99 and Codigo='01')
begin
	insert into dbo.TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) 
	values (9901,99,'01','Los más vendidos')
end

go

if not exists (select 1 from dbo.TablaLogicaDatos where TablaLogicaID = 99 and Codigo='02')
begin
	insert into dbo.TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) 
	values (9902,99,'02','Menor a mayor precio')
end

go

if not exists (select 1 from dbo.TablaLogicaDatos where TablaLogicaID = 99 and Codigo='03')
begin
	insert into dbo.TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) 
	values (9903,99,'03','Mayor a menor precio')
end

go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.Evento') and SYSCOLUMNS.NAME = N'TieneCategoria') = 0
	ALTER TABLE ShowRoom.Evento ADD TieneCategoria bit
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.Evento') and SYSCOLUMNS.NAME = N'TieneCompraXcompra') = 0
	ALTER TABLE ShowRoom.Evento ADD TieneCompraXcompra bit
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'CodigoCategoria') = 0
	ALTER TABLE ShowRoom.OfertaShowRoom ADD CodigoCategoria varchar(100)
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'TipNegocio') = 0
	ALTER TABLE ShowRoom.OfertaShowRoom ADD TipNegocio varchar(500)
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoomDetalle') and SYSCOLUMNS.NAME = N'MarcaProducto') = 0
	ALTER TABLE ShowRoom.OfertaShowRoomDetalle ADD MarcaProducto varchar(100)
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.EventoConsultora') and SYSCOLUMNS.NAME = N'MostrarPopupVenta') = 0
	ALTER TABLE ShowRoom.EventoConsultora ADD MostrarPopupVenta bit
go

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[Nivel]') AND (type = 'U') )
	DROP TABLE ShowRoom.Nivel
GO

create table ShowRoom.Nivel
(
	NivelId int identity(1,1) primary key,
	Codigo varchar(100),
	Descripcion varchar(100)
)

go

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[Personalizacion]') AND (type = 'U') )
	DROP TABLE ShowRoom.Personalizacion
GO

create table ShowRoom.Personalizacion
(
	PersonalizacionId int identity(1,1) primary key,
	TipoAplicacion varchar(20),
	Atributo varchar(100),
	TextoAyuda varchar(200),
	TipoAtributo varchar(20),
	TipoPersonalizacion varchar(20),
	Orden int,
	Estado bit
)

go

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[PersonalizacionNivel]') AND (type = 'U') )
	DROP TABLE ShowRoom.PersonalizacionNivel
GO

create table ShowRoom.PersonalizacionNivel
(
	PersonalizacionNivelId int identity(1,1) primary key,
	EventoID int,
	PersonalizacionId int,
	NivelId int,
	CategoriaId int,
	Valor varchar(200)
)

go

CREATE NONCLUSTERED INDEX IX_ShowRoomPersonalizacionNivel_EventoIdNivelId ON ShowRoom.PersonalizacionNivel (EventoID,NivelId);

go

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[Categoria]') AND (type = 'U') )
	DROP TABLE ShowRoom.Categoria
GO

create table ShowRoom.Categoria
(
	CategoriaId int identity(1,1) primary key,
	EventoID int,
	Codigo varchar(50),
	Descripcion varchar(200)
)

go

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[CompraPorCompra]') AND (type = 'U') )
	DROP TABLE ShowRoom.CompraPorCompra
GO

CREATE TABLE ShowRoom.CompraPorCompra
(
	CompraxCompraID int identity(1,1) primary key,
	EventoID int,
	CUV varchar(20),
	SAP varchar(12),
	Orden int,
	PrecioValorizado decimal(18,2),
	FechaCreacion datetime,
	UsuarioCreacion varchar(50),
	FechaModificacion datetime,
	UsuarioModificacion varchar(50)
)

GO

insert into ShowRoom.Nivel (Codigo,Descripcion) values ('PAIS','País')

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','PopupImagenIntriga','Popup Principal Intriga (615px x 409px)','IMAGEN','EVENTO',1,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','PopupImagenVenta','Popup Principal Venta (615px x 409px)','IMAGEN','EVENTO',2,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','BannerImagenIntriga','Visual Superior Intriga (1920px x 174px)','IMAGEN','EVENTO',3,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','BannerImagenVenta','Visual Superior Venta (1920px x 174px)','IMAGEN','EVENTO',4,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','UrlTerminosCondiciones','Link Terminos y Condiciones','TEXTO','EVENTO',5,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','TextoCondicionCompraCpc','Texto Condición de Compra por Compra','TEXTO','EVENTO',6,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','TextoDescripcionLegalCpc','Texto Descripción Legal Compra por Compra','TEXTO','EVENTO',7,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','IconoLluvia','Icono Lluvia Paginal Principal','IMAGEN','EVENTO',8,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','BannerEnvioCorreo','Imagen Envio Correo','IMAGEN','EVENTO',9,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','TextoEnvioCorreo','Texto mostrar Envio Correo','TEXTO','EVENTO',10,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','ImagenFondoProductPage','Imagen de Fondo del Product Page','IMAGEN','EVENTO',11,1)

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','TituloPrincipal','Título de la Categoria','TEXTO','CATEGORIA',12,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','ImagenPrincipal','Imagen a mostrar en la Categoria','IMAGEN','CATEGORIA',13,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','ColorFondo','Color de Fondo de la Categoria','TEXTO','CATEGORIA',14,1)

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','PopupImagenIntriga','Banner Marquesina Intriga (768px x 420px)','IMAGEN','EVENTO',1,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','PopupImagenVenta','Banner Marquesina Venta (768px x 420px)','IMAGEN','EVENTO',2,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','BannerImagenIntriga','Banner Superior Intriga (1024px x 60px)','IMAGEN','EVENTO',3,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','BannerImagenPaginaVenta','Banner Superior Pagina Venta (1024px x 60px)','IMAGEN','EVENTO',4,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','BannerImagenVenta','Banner Superior Venta Otras Paginas (1024px x 60px)','IMAGEN','EVENTO',5,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','UrlTerminosCondiciones','Link Terminos y Condiciones','TEXTO','EVENTO',6,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','TextoCondicionCompraCpc','Texto Condición de Compra','TEXTO','EVENTO',7,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','TextoDescripcionLegalCpc','Texto Descripción Legal Compra por Compra','TEXTO','EVENTO',8,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','ImagenFondoProductPage','Imagen de Fondo del Product Page','IMAGEN','EVENTO',9,1)

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','TituloPrincipal','Título de la Categoria','TEXTO','CATEGORIA',10,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','ColorFondo','Color de Fondo de la Categoria','TEXTO','CATEGORIA',11,1)

go

update ShowRoom.EventoConsultora set MostrarPopup = 1 where MostrarPopup is null
update ShowRoom.EventoConsultora set MostrarPopupVenta = 1 where MostrarPopupVenta is null

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomNivel]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomNivel
GO

create procedure ShowRoom.GetShowRoomNivel
as
/*
ShowRoom.GetShowRoomNivel
*/
begin

select
	NivelId,
	Codigo,
	Descripcion
from ShowRoom.Nivel

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomPersonalizacion]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomPersonalizacion
GO

create procedure ShowRoom.GetShowRoomPersonalizacion
as
/*
ShowRoom.GetShowRoomPersonalizacion
*/
begin

select
	PersonalizacionId,
	TipoAplicacion,
	Atributo,
	TextoAyuda,
	TipoAtributo,
	TipoPersonalizacion,
	Orden,
	Estado
from ShowRoom.Personalizacion

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomPersonalizacionNivel]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomPersonalizacionNivel
GO

create procedure ShowRoom.GetShowRoomPersonalizacionNivel
@EventoId int,
@NivelId int = 0,
@CategoriaId int = 0
as
/*
ShowRoom.GetShowRoomPersonalizacionNivel 2006,1,0
ShowRoom.GetShowRoomPersonalizacionNivel 2006,0,1
*/
begin

select 
	PersonalizacionNivelId,
	EventoID,
	PersonalizacionId,
	isnull(NivelId,0) as NivelId,
	isnull(CategoriaId,0) as CategoriaId,
	isnull(Valor,'') as Valor
from ShowRoom.PersonalizacionNivel
where
	EventoID = @EventoId
	and (@NivelId = 0 or NivelId = @NivelId)
	and (@CategoriaId = 0 or CategoriaId = @CategoriaId)

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[InsertShowRoomPersonalizacionNivel]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].InsertShowRoomPersonalizacionNivel
GO

create procedure ShowRoom.InsertShowRoomPersonalizacionNivel
@EventoID int,
@PersonalizacionId int,
@NivelId int,
@CategoriaId int = 0,
@Valor varchar(200)
as
begin

insert into ShowRoom.PersonalizacionNivel (EventoID, PersonalizacionId, NivelId, CategoriaId, Valor)
values (@EventoID, @PersonalizacionId, @NivelId, @CategoriaId, @Valor)

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[UpdateShowRoomPersonalizacionNivel]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].UpdateShowRoomPersonalizacionNivel
GO

create procedure ShowRoom.UpdateShowRoomPersonalizacionNivel
@PersonalizacionNivelId int,
@Valor varchar(200)
as
begin

update ShowRoom.PersonalizacionNivel
	set Valor = @Valor
where PersonalizacionNivelId = @PersonalizacionNivelId

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomCategorias]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomCategorias
GO

create procedure ShowRoom.GetShowRoomCategorias
@EventoId int
as
/*
ShowRoom.GetShowRoomCategorias 6
*/
begin

select
	CategoriaId,
	EventoID,
	Codigo,
	Descripcion
from ShowRoom.Categoria
where EventoID = @EventoId

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomCategoriaById]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomCategoriaById
GO

create procedure ShowRoom.GetShowRoomCategoriaById
@CategoriaId int
as
/*
ShowRoom.GetShowRoomCategoriaById 1
*/
begin

select
	CategoriaId,
	EventoID,
	Codigo,
	Descripcion
from ShowRoom.Categoria
where CategoriaId = @CategoriaId

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[UpdateShowRoomDescripcionCategoria]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].UpdateShowRoomDescripcionCategoria
GO

create procedure ShowRoom.UpdateShowRoomDescripcionCategoria
@CategoriaId int,
@Descripcion varchar(200)
as
begin

update ShowRoom.Categoria
set
	Descripcion = @Descripcion
where 
	CategoriaId = @CategoriaId

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[DeleteShowRoomCategoriaByEvento]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].DeleteShowRoomCategoriaByEvento
GO

create procedure ShowRoom.DeleteShowRoomCategoriaByEvento
@EventoId int
as
begin

delete from ShowRoom.PersonalizacionNivel where EventoID = @EventoId and NivelId = 0
delete from ShowRoom.Categoria where EventoId = @EventoID

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[InsertShowRoomCategoria]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].InsertShowRoomCategoria
GO

create procedure ShowRoom.InsertShowRoomCategoria
@EventoID int,
@Codigo varchar(50),
@Descripcion varchar(200)
as
begin

insert into ShowRoom.Categoria (EventoID, Codigo, Descripcion) values (@EventoID, @Codigo, @Descripcion)

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomCompraPorCompra]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomCompraPorCompra
GO

create procedure ShowRoom.GetShowRoomCompraPorCompra
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

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[UpdStockOfertaShowRoomMasivo]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].UpdStockOfertaShowRoomMasivo
GO

IF (SELECT COUNT(*) FROM sys.table_types WHERE name = 'StockPrecioOfertaShowRoomType') = 1
	drop type ShowRoom.StockPrecioOfertaShowRoomType

go

go

IF (SELECT COUNT(*) FROM sys.table_types WHERE name = 'StockPrecioOfertaShowRoomType') = 0  
  CREATE TYPE ShowRoom.StockPrecioOfertaShowRoomType AS TABLE ( 
	TipoOfertaSisID int, CampaniaID int, CUV varchar(20), Stock int, PrecioOferta decimal(18,2), UnidadesPermitidas int,
	Descripcion varchar(250), CodigoCategoria varchar(100), TipNegocio varchar(500)
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
	TipNegocio = t.TipNegocio
FROM ShowRoom.OfertaShowRoom o
INNER JOIN ods.Campania c on 
	c.CampaniaID = o.CampaniaID
JOIN @StockPrecioOfertaShowRoom t ON 
	c.Codigo = t.CampaniaID
	AND o.CUV = t.CUV
	AND o.TipoOfertaSisID = t.TipoOfertaSisID

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[InsertCargaMasivaOfertaDetalle]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].InsertCargaMasivaOfertaDetalle
GO

IF (SELECT COUNT(*) FROM sys.table_types WHERE name = 'OfertaShowRoomDetalleType') = 1
	drop type ShowRoom.OfertaShowRoomDetalleType

go

go

IF (SELECT COUNT(*) FROM sys.table_types WHERE name = 'OfertaShowRoomDetalleType') = 0 
CREATE TYPE ShowRoom.OfertaShowRoomDetalleType AS TABLE(
	CUV varchar(20) NULL,
	NombreProducto varchar(150) NULL,
	Descripcion1 varchar(150) NULL,
	Descripcion2 varchar(150) NULL,
	Descripcion3 varchar(150) NULL,
	Posicion int NULL,
	MarcaProducto varchar(100) NULL
)

go

create procedure ShowRoom.InsertCargaMasivaOfertaDetalle
@OfertaShowRoomDetalle ShowRoom.OfertaShowRoomDetalleType readonly,
@CampaniaID int,
@UsuarioCreacion varchar(50)
as
begin

begin tran

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

delete from ShowRoom.OfertaShowRoomDetalle
	where OfertaShowRoomDetalleID not in (select o.OfertaShowRoomDetalleID from ShowRoom.OfertaShowRoomDetalle o
	inner join @OfertaShowRoomDetalle t on
	o.CUV = t.CUV
	and o.Posicion = t.Posicion)

update ShowRoom.OfertaShowRoomDetalle
set NombreProducto = t.NombreProducto,
	Descripcion1 = t.Descripcion1,
	Descripcion2 = t.Descripcion2,
	Descripcion3 = t.Descripcion3,
	UsuarioModificacion = @UsuarioCreacion,
	MarcaProducto = t.MarcaProducto
from ShowRoom.OfertaShowRoomDetalle o
inner join @OfertaShowRoomDetalle t on	
	o.CUV = t.CUV
	and o.Posicion = t.Posicion
	--and o.NombreProducto = t.NombreProducto
where
	o.CampaniaID = @CampaniaID	

insert into ShowRoom.OfertaShowRoomDetalle
(CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,FechaCreacion,UsuarioCreacion,
FechaModificacion,UsuarioModificacion,Posicion,MarcaProducto)
select @CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,getdate(),@UsuarioCreacion,
getdate(),@UsuarioCreacion,Posicion,MarcaProducto
from @OfertaShowRoomDetalle
where 
	NombreProducto not in (select NombreProducto from ShowRoom.OfertaShowRoomDetalle o where o.CampaniaID = @CampaniaID
		and o.CUV = CUV)

end

commit tran

IF (@@ERROR <> 0) BEGIN
PRINT 'Error Inesperado!'
    ROLLBACK TRAN
END

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[InsertCargarProductoCpc]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].InsertCargarProductoCpc
GO

IF (SELECT COUNT(*) FROM sys.table_types WHERE name = 'OfertaShowRoomCompraPorCompraType') = 1
	drop type ShowRoom.OfertaShowRoomCompraPorCompraType

go

go

IF (SELECT COUNT(*) FROM sys.table_types WHERE name = 'OfertaShowRoomCompraPorCompraType') = 0  
  CREATE TYPE ShowRoom.OfertaShowRoomCompraPorCompraType AS TABLE ( 
	CUV varchar(20), SAP varchar(12), Orden int, PrecioValorizado decimal(18,2)
  )
GO

create procedure ShowRoom.InsertCargarProductoCpc
@OfertaShowRoomCompraPorCompra ShowRoom.OfertaShowRoomCompraPorCompraType readonly,
@EventoID int,
@UsuarioCreacion varchar(50)
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

declare @tablaCuv table ( CUV varchar(6))
insert into @tablaCuv
select distinct CUV from ShowRoom.CompraPorCompra where EventoID = @EventoID

update ShowRoom.CompraPorCompra
set 
	Orden = o.Orden,
	PrecioValorizado = o.PrecioValorizado,
	UsuarioModificacion = @UsuarioCreacion,
	FechaModificacion = @FechaGeneral
from ShowRoom.CompraPorCompra cpc
inner join @OfertaShowRoomCompraPorCompra o on
	cpc.CUV = o.CUV
	and cpc.SAP = o.SAP
where cpc.EventoID = @EventoID

insert into ShowRoom.CompraPorCompra (EventoID, CUV, SAP, Orden, PrecioValorizado, 
FechaCreacion, FechaModificacion, UsuarioCreacion, UsuarioModificacion)
select 
	@EventoID, CUV, SAP, Orden, PrecioValorizado, 
	@FechaGeneral, @FechaGeneral, @UsuarioCreacion, @UsuarioCreacion
from @OfertaShowRoomCompraPorCompra
where CUV not in (
	select CUV from @tablaCuv
)

end

go

ALTER procedure ShowRoom.InsertShowRoomEvento
@EventoID int output,
@CampaniaID int,
@Nombre varchar(150),
@Tema varchar(150),
@DiasAntes int,
@DiasDespues int,
@NumeroPerfiles int,
@UsuarioCreacion varchar(20),
@TieneCategoria bit,
@TieneCompraXcompra bit
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

insert into ShowRoom.Evento
(CampaniaID, Nombre, Tema, DiasAntes, DiasDespues, NumeroPerfiles, 
FechaCreacion, UsuarioCreacion, FechaModificacion, UsuarioModificacion, Estado, TieneCategoria, TieneCompraXcompra)
values
(@CampaniaID, @Nombre, @Tema, @DiasAntes, @DiasDespues, @NumeroPerfiles,
@FechaGeneral, @UsuarioCreacion, @FechaGeneral, @UsuarioCreacion, 1, @TieneCategoria, @TieneCompraXcompra)

set @EventoID = @@IDENTITY

end

GO

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
@TieneCompraXcompra bit
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
	TieneCompraXcompra = @TieneCompraXcompra
where EventoID = @EventoID

end

go

alter procedure ShowRoom.GetShowRoomEventoByCampaniaID
@CampaniaID int
as
/*
ShowRoom.GetShowRoomEventoByCampaniaID 201705
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
	isnull(TieneCompraXcompra,0) as TieneCompraXcompra
from ShowRoom.Evento
where CampaniaID = @CampaniaID

end

go

ALTER procedure ShowRoom.InsertShowRoomCargarMasivaConsultora
@EventoConsultora ShowRoom.EventoConsultoraType readonly
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

INSERT INTO ShowRoom.EventoConsultora(EventoID, CampaniaID, CodigoConsultora, Segmento, MostrarPopup,
MostrarPopupVenta, FechaCreacion, UsuarioCreacion, FechaModificacion, UsuarioModificacion)
SELECT DISTINCT EventoID, CampaniaID, CodigoConsultora, Segmento, 1,
1, @FechaGeneral, UsuarioCreacion, @FechaGeneral, UsuarioCreacion
FROM @EventoConsultora

end

go

ALTER procedure ShowRoom.GetShowRoomConsultora
@CampaniaID int,
@CodigoConsultora varchar(20)
as
/*
ShowRoom.GetShowRoomConsultora 201704,'0193037'
*/
begin

select top 1
EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,MostrarPopup,
MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion
from ShowRoom.EventoConsultora
where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
order by FechaCreacion desc

end

go

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

go

ALTER procedure ShowRoom.GetProductosShowRoomDetalle
@CampaniaID int,
@CUV varchar(5)
as
/*
ShowRoom.GetProductosShowRoomDetalle 201705,'96248'
ShowRoom.GetProductosShowRoomDetalle 201705,'99008'
*/
begin

select top 3
	OfertaShowRoomDetalleID,
	CampaniaID,
	CUV,
	isnull(NombreProducto,'') as NombreProducto,
	isnull(Descripcion1,'') as Descripcion1,
	isnull(Descripcion2,'') as Descripcion2,
	isnull(Descripcion3,'') as Descripcion3,
	isnull(Imagen,'') as Imagen,
	FechaCreacion,
	UsuarioCreacion,
	FechaModificacion,
	UsuarioModificacion,
	Posicion,
	MarcaProducto
from ShowRoom.OfertaShowRoomDetalle
where 
	CampaniaID = @CampaniaID
	and CUV = @CUV

end

go

ALTER procedure ShowRoom.InsOfertaShowRoomDetalle
@CampaniaID int,
@CUV varchar(5),
@NombreProducto varchar(100),
@Descripcion1 varchar(150),
@Descripcion2 varchar(150),
@Descripcion3 varchar(150),
@Imagen varchar(150),
@UsuarioCreacion varchar(50),
@MarcaProducto varchar(100)
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

declare @Posicion int = 0
select @Posicion = max(Posicion) from ShowRoom.OfertaShowRoomDetalle
where 
	CampaniaID = @CampaniaID
	and CUV = @CUV

insert into ShowRoom.OfertaShowRoomDetalle
(CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,
Imagen,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,Posicion,MarcaProducto)
values
(@CampaniaID,@CUV,@NombreProducto,@Descripcion1,@Descripcion2,@Descripcion3,
@Imagen,@FechaGeneral,@UsuarioCreacion,@FechaGeneral,@UsuarioCreacion,@Posicion+1,@MarcaProducto)

end

go

ALTER procedure ShowRoom.UpdOfertaShowRoomDetalle
@OfertaShowRoomDetalleID int,
@CampaniaID int,
@CUV varchar(5),
@NombreProducto varchar(100),
@Descripcion1 varchar(150),
@Descripcion2 varchar(150),
@Descripcion3 varchar(150),
@Imagen varchar(150),
@UsuarioModificacion varchar(50),
@MarcaProducto varchar(100)
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

update ShowRoom.OfertaShowRoomDetalle
set
	NombreProducto = @NombreProducto,
	Descripcion1 = @Descripcion1,
	Descripcion2 = @Descripcion2,
	Descripcion3 = @Descripcion3,
	Imagen = @Imagen,
	UsuarioModificacion = @UsuarioModificacion,
	FechaModificacion = @FechaGeneral,
	MarcaProducto = @MarcaProducto
where
	OfertaShowRoomDetalleID = @OfertaShowRoomDetalleID
	and CampaniaID = @CampaniaID
	and CUV = @CUV

end

go


ALTER PROCEDURE dbo.InsPedidoWebDetalleOferta_SB2
	@CampaniaID int,
	@ConsultoraID int,
	@MarcaID tinyint,
	@Cantidad int,
	@PrecioUnidad money,
	@CUV varchar(20),
	@ConfiguracionOfertaID INT,
	@TipoOfertaSisID INT,
	@PaisID int,
	@IPUsuario varchar(25) = null,
	@CodigoUsuarioCreacion varchar(25) = null,
	@OrigenPedidoWeb int = 0,
	@EsCompraPorCompra bit = 0
AS
BEGIN
DECLARE @PedidoDetalleID INT;
DECLARE @PedidoID  INT = 0;
DECLARE @OfertaWeb INT  = 1;
DECLARE @ExisteDet INT = 0;
DECLARE @Orden INT=0;

	EXEC [dbo].[InsPedidoWebOferta] @CampaniaID, @ConsultoraID , @PaisID, @IPUsuario, @CodigoUsuarioCreacion;

	if @TipoOfertaSisID = 1707
	begin
		set @OfertaWeb = 0
	end

	if @EsCompraPorCompra = 1
	begin
		set @OfertaWeb = 0
	end

	SELECT @PedidoID = PedidoID FROM dbo.PedidoWeb WHERE CampaniaID = @CampaniaID AND ConsultoraID = @ConsultoraID;

	SELECT @PedidoDetalleID = MAX(ISNULL(PedidoDetalleID,0))
		   , @Orden = max(ISNULL(OrdenPedidoWD,0))
		   FROM dbo.PedidoWebDetalle 
		   WHERE CampaniaID = @CampaniaID AND PedidoID = @PedidoID
	
	SET @PedidoDetalleID = ISNULL(@PedidoDetalleID, 0) + 1
	SET @Orden = ISNULL(@Orden, 0) + 1

	--SET @PedidoDetalleID =	(SELECT ISNULL(MAX(PedidoDetalleID),0) + 1 
	--							FROM	dbo.PedidoWebDetalle 
	--							WHERE	CampaniaID = @CampaniaID AND
	--									PedidoID = @PedidoID);

	/* Validar Al Agregar Nuevamente */
	set @ExisteDet = (select count(*) from PedidoWebDetalle 
						where CampaniaID = @CampaniaID 
							  AND PedidoID = @PedidoID
							  AND CUV = @CUV
							  AND ClienteID IS NULL);

	IF @ExisteDet = 0 
		BEGIN
			INSERT INTO dbo.PedidoWebDetalle 
			(
			 CampaniaID,
			 PedidoID,
			 PedidoDetalleID,
			 MarcaID,
			 ConsultoraID,
			 ClienteID,
			 Cantidad,
			 PrecioUnidad,
			 ImporteTotal,
			 CUV,
			 OfertaWeb, 
			 ModificaPedidoReservado,
			 ConfiguracionOfertaID,
			 TipoOfertaSisID,
			 CodigoUsuarioCreacion,
			 FechaCreacion,
			 OrdenPedidoWD,
			 OrigenPedidoWeb
			)

		VALUES (@CampaniaID,@PedidoID,@PedidoDetalleID,
				@MarcaID,@ConsultoraID,NULL,
				@Cantidad,@PrecioUnidad,@Cantidad*@PrecioUnidad,@CUV,@OfertaWeb,0, @ConfiguracionOfertaID, @TipoOfertaSisID,
				@CodigoUsuarioCreacion, dbo.fnObtenerFechaHoraPais(), @Orden, @OrigenPedidoWeb)
		END
	ELSE
		BEGIN
			UPDATE dbo.PedidoWebDetalle
				SET Cantidad += @Cantidad,
					ImporteTotal = ((Cantidad + @Cantidad) * @PrecioUnidad),
					CodigoUsuarioModificacion = @CodigoUsuarioCreacion,
					FechaModificacion = dbo.fnObtenerFechaHoraPais(),
					OrdenPedidoWD = @Orden,
					OrigenPedidoWeb = @OrigenPedidoWeb
			WHERE CampaniaID = @CampaniaID 
				  AND PedidoID = @PedidoID
				  AND CUV = @CUV
				  AND ClienteID IS NULL		
		END
END

GO

USE BelcorpPeru
go

delete from dbo.TablaLogicaDatos where TablaLogicaID = 99
delete from dbo.TablaLogica where TablaLogicaID = 99

go

if not exists (select 1 from dbo.TablaLogica where TablaLogicaID = 99)
begin
	insert into dbo.TablaLogica(TablaLogicaID,Descripcion) values (99,'OrdenamientoShowRoom')
end

go

if not exists (select 1 from dbo.TablaLogicaDatos where TablaLogicaID = 99 and Codigo='01')
begin
	insert into dbo.TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) 
	values (9901,99,'01','Los más vendidos')
end

go

if not exists (select 1 from dbo.TablaLogicaDatos where TablaLogicaID = 99 and Codigo='02')
begin
	insert into dbo.TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) 
	values (9902,99,'02','Menor a mayor precio')
end

go

if not exists (select 1 from dbo.TablaLogicaDatos where TablaLogicaID = 99 and Codigo='03')
begin
	insert into dbo.TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) 
	values (9903,99,'03','Mayor a menor precio')
end

go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.Evento') and SYSCOLUMNS.NAME = N'TieneCategoria') = 0
	ALTER TABLE ShowRoom.Evento ADD TieneCategoria bit
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.Evento') and SYSCOLUMNS.NAME = N'TieneCompraXcompra') = 0
	ALTER TABLE ShowRoom.Evento ADD TieneCompraXcompra bit
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'CodigoCategoria') = 0
	ALTER TABLE ShowRoom.OfertaShowRoom ADD CodigoCategoria varchar(100)
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'TipNegocio') = 0
	ALTER TABLE ShowRoom.OfertaShowRoom ADD TipNegocio varchar(500)
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoomDetalle') and SYSCOLUMNS.NAME = N'MarcaProducto') = 0
	ALTER TABLE ShowRoom.OfertaShowRoomDetalle ADD MarcaProducto varchar(100)
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.EventoConsultora') and SYSCOLUMNS.NAME = N'MostrarPopupVenta') = 0
	ALTER TABLE ShowRoom.EventoConsultora ADD MostrarPopupVenta bit
go

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[Nivel]') AND (type = 'U') )
	DROP TABLE ShowRoom.Nivel
GO

create table ShowRoom.Nivel
(
	NivelId int identity(1,1) primary key,
	Codigo varchar(100),
	Descripcion varchar(100)
)

go

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[Personalizacion]') AND (type = 'U') )
	DROP TABLE ShowRoom.Personalizacion
GO

create table ShowRoom.Personalizacion
(
	PersonalizacionId int identity(1,1) primary key,
	TipoAplicacion varchar(20),
	Atributo varchar(100),
	TextoAyuda varchar(200),
	TipoAtributo varchar(20),
	TipoPersonalizacion varchar(20),
	Orden int,
	Estado bit
)

go

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[PersonalizacionNivel]') AND (type = 'U') )
	DROP TABLE ShowRoom.PersonalizacionNivel
GO

create table ShowRoom.PersonalizacionNivel
(
	PersonalizacionNivelId int identity(1,1) primary key,
	EventoID int,
	PersonalizacionId int,
	NivelId int,
	CategoriaId int,
	Valor varchar(200)
)

go

CREATE NONCLUSTERED INDEX IX_ShowRoomPersonalizacionNivel_EventoIdNivelId ON ShowRoom.PersonalizacionNivel (EventoID,NivelId);

go

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[Categoria]') AND (type = 'U') )
	DROP TABLE ShowRoom.Categoria
GO

create table ShowRoom.Categoria
(
	CategoriaId int identity(1,1) primary key,
	EventoID int,
	Codigo varchar(50),
	Descripcion varchar(200)
)

go

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[CompraPorCompra]') AND (type = 'U') )
	DROP TABLE ShowRoom.CompraPorCompra
GO

CREATE TABLE ShowRoom.CompraPorCompra
(
	CompraxCompraID int identity(1,1) primary key,
	EventoID int,
	CUV varchar(20),
	SAP varchar(12),
	Orden int,
	PrecioValorizado decimal(18,2),
	FechaCreacion datetime,
	UsuarioCreacion varchar(50),
	FechaModificacion datetime,
	UsuarioModificacion varchar(50)
)

GO

insert into ShowRoom.Nivel (Codigo,Descripcion) values ('PAIS','País')

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','PopupImagenIntriga','Popup Principal Intriga (615px x 409px)','IMAGEN','EVENTO',1,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','PopupImagenVenta','Popup Principal Venta (615px x 409px)','IMAGEN','EVENTO',2,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','BannerImagenIntriga','Visual Superior Intriga (1920px x 174px)','IMAGEN','EVENTO',3,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','BannerImagenVenta','Visual Superior Venta (1920px x 174px)','IMAGEN','EVENTO',4,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','UrlTerminosCondiciones','Link Terminos y Condiciones','TEXTO','EVENTO',5,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','TextoCondicionCompraCpc','Texto Condición de Compra por Compra','TEXTO','EVENTO',6,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','TextoDescripcionLegalCpc','Texto Descripción Legal Compra por Compra','TEXTO','EVENTO',7,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','IconoLluvia','Icono Lluvia Paginal Principal','IMAGEN','EVENTO',8,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','BannerEnvioCorreo','Imagen Envio Correo','IMAGEN','EVENTO',9,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','TextoEnvioCorreo','Texto mostrar Envio Correo','TEXTO','EVENTO',10,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','ImagenFondoProductPage','Imagen de Fondo del Product Page','IMAGEN','EVENTO',11,1)

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','TituloPrincipal','Título de la Categoria','TEXTO','CATEGORIA',12,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','ImagenPrincipal','Imagen a mostrar en la Categoria','IMAGEN','CATEGORIA',13,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','ColorFondo','Color de Fondo de la Categoria','TEXTO','CATEGORIA',14,1)

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','PopupImagenIntriga','Banner Marquesina Intriga (768px x 420px)','IMAGEN','EVENTO',1,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','PopupImagenVenta','Banner Marquesina Venta (768px x 420px)','IMAGEN','EVENTO',2,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','BannerImagenIntriga','Banner Superior Intriga (1024px x 60px)','IMAGEN','EVENTO',3,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','BannerImagenPaginaVenta','Banner Superior Pagina Venta (1024px x 60px)','IMAGEN','EVENTO',4,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','BannerImagenVenta','Banner Superior Venta Otras Paginas (1024px x 60px)','IMAGEN','EVENTO',5,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','UrlTerminosCondiciones','Link Terminos y Condiciones','TEXTO','EVENTO',6,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','TextoCondicionCompraCpc','Texto Condición de Compra','TEXTO','EVENTO',7,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','TextoDescripcionLegalCpc','Texto Descripción Legal Compra por Compra','TEXTO','EVENTO',8,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','ImagenFondoProductPage','Imagen de Fondo del Product Page','IMAGEN','EVENTO',9,1)

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','TituloPrincipal','Título de la Categoria','TEXTO','CATEGORIA',10,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','ColorFondo','Color de Fondo de la Categoria','TEXTO','CATEGORIA',11,1)

go

update ShowRoom.EventoConsultora set MostrarPopup = 1 where MostrarPopup is null
update ShowRoom.EventoConsultora set MostrarPopupVenta = 1 where MostrarPopupVenta is null

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomNivel]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomNivel
GO

create procedure ShowRoom.GetShowRoomNivel
as
/*
ShowRoom.GetShowRoomNivel
*/
begin

select
	NivelId,
	Codigo,
	Descripcion
from ShowRoom.Nivel

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomPersonalizacion]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomPersonalizacion
GO

create procedure ShowRoom.GetShowRoomPersonalizacion
as
/*
ShowRoom.GetShowRoomPersonalizacion
*/
begin

select
	PersonalizacionId,
	TipoAplicacion,
	Atributo,
	TextoAyuda,
	TipoAtributo,
	TipoPersonalizacion,
	Orden,
	Estado
from ShowRoom.Personalizacion

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomPersonalizacionNivel]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomPersonalizacionNivel
GO

create procedure ShowRoom.GetShowRoomPersonalizacionNivel
@EventoId int,
@NivelId int = 0,
@CategoriaId int = 0
as
/*
ShowRoom.GetShowRoomPersonalizacionNivel 2006,1,0
ShowRoom.GetShowRoomPersonalizacionNivel 2006,0,1
*/
begin

select 
	PersonalizacionNivelId,
	EventoID,
	PersonalizacionId,
	isnull(NivelId,0) as NivelId,
	isnull(CategoriaId,0) as CategoriaId,
	isnull(Valor,'') as Valor
from ShowRoom.PersonalizacionNivel
where
	EventoID = @EventoId
	and (@NivelId = 0 or NivelId = @NivelId)
	and (@CategoriaId = 0 or CategoriaId = @CategoriaId)

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[InsertShowRoomPersonalizacionNivel]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].InsertShowRoomPersonalizacionNivel
GO

create procedure ShowRoom.InsertShowRoomPersonalizacionNivel
@EventoID int,
@PersonalizacionId int,
@NivelId int,
@CategoriaId int = 0,
@Valor varchar(200)
as
begin

insert into ShowRoom.PersonalizacionNivel (EventoID, PersonalizacionId, NivelId, CategoriaId, Valor)
values (@EventoID, @PersonalizacionId, @NivelId, @CategoriaId, @Valor)

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[UpdateShowRoomPersonalizacionNivel]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].UpdateShowRoomPersonalizacionNivel
GO

create procedure ShowRoom.UpdateShowRoomPersonalizacionNivel
@PersonalizacionNivelId int,
@Valor varchar(200)
as
begin

update ShowRoom.PersonalizacionNivel
	set Valor = @Valor
where PersonalizacionNivelId = @PersonalizacionNivelId

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomCategorias]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomCategorias
GO

create procedure ShowRoom.GetShowRoomCategorias
@EventoId int
as
/*
ShowRoom.GetShowRoomCategorias 6
*/
begin

select
	CategoriaId,
	EventoID,
	Codigo,
	Descripcion
from ShowRoom.Categoria
where EventoID = @EventoId

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomCategoriaById]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomCategoriaById
GO

create procedure ShowRoom.GetShowRoomCategoriaById
@CategoriaId int
as
/*
ShowRoom.GetShowRoomCategoriaById 1
*/
begin

select
	CategoriaId,
	EventoID,
	Codigo,
	Descripcion
from ShowRoom.Categoria
where CategoriaId = @CategoriaId

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[UpdateShowRoomDescripcionCategoria]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].UpdateShowRoomDescripcionCategoria
GO

create procedure ShowRoom.UpdateShowRoomDescripcionCategoria
@CategoriaId int,
@Descripcion varchar(200)
as
begin

update ShowRoom.Categoria
set
	Descripcion = @Descripcion
where 
	CategoriaId = @CategoriaId

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[DeleteShowRoomCategoriaByEvento]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].DeleteShowRoomCategoriaByEvento
GO

create procedure ShowRoom.DeleteShowRoomCategoriaByEvento
@EventoId int
as
begin

delete from ShowRoom.PersonalizacionNivel where EventoID = @EventoId and NivelId = 0
delete from ShowRoom.Categoria where EventoId = @EventoID

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[InsertShowRoomCategoria]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].InsertShowRoomCategoria
GO

create procedure ShowRoom.InsertShowRoomCategoria
@EventoID int,
@Codigo varchar(50),
@Descripcion varchar(200)
as
begin

insert into ShowRoom.Categoria (EventoID, Codigo, Descripcion) values (@EventoID, @Codigo, @Descripcion)

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomCompraPorCompra]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomCompraPorCompra
GO

create procedure ShowRoom.GetShowRoomCompraPorCompra
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

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[UpdStockOfertaShowRoomMasivo]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].UpdStockOfertaShowRoomMasivo
GO

IF (SELECT COUNT(*) FROM sys.table_types WHERE name = 'StockPrecioOfertaShowRoomType') = 1
	drop type ShowRoom.StockPrecioOfertaShowRoomType

go

go

IF (SELECT COUNT(*) FROM sys.table_types WHERE name = 'StockPrecioOfertaShowRoomType') = 0  
  CREATE TYPE ShowRoom.StockPrecioOfertaShowRoomType AS TABLE ( 
	TipoOfertaSisID int, CampaniaID int, CUV varchar(20), Stock int, PrecioOferta decimal(18,2), UnidadesPermitidas int,
	Descripcion varchar(250), CodigoCategoria varchar(100), TipNegocio varchar(500)
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
	TipNegocio = t.TipNegocio
FROM ShowRoom.OfertaShowRoom o
INNER JOIN ods.Campania c on 
	c.CampaniaID = o.CampaniaID
JOIN @StockPrecioOfertaShowRoom t ON 
	c.Codigo = t.CampaniaID
	AND o.CUV = t.CUV
	AND o.TipoOfertaSisID = t.TipoOfertaSisID

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[InsertCargaMasivaOfertaDetalle]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].InsertCargaMasivaOfertaDetalle
GO

IF (SELECT COUNT(*) FROM sys.table_types WHERE name = 'OfertaShowRoomDetalleType') = 1
	drop type ShowRoom.OfertaShowRoomDetalleType

go

go

IF (SELECT COUNT(*) FROM sys.table_types WHERE name = 'OfertaShowRoomDetalleType') = 0 
CREATE TYPE ShowRoom.OfertaShowRoomDetalleType AS TABLE(
	CUV varchar(20) NULL,
	NombreProducto varchar(150) NULL,
	Descripcion1 varchar(150) NULL,
	Descripcion2 varchar(150) NULL,
	Descripcion3 varchar(150) NULL,
	Posicion int NULL,
	MarcaProducto varchar(100) NULL
)

go

create procedure ShowRoom.InsertCargaMasivaOfertaDetalle
@OfertaShowRoomDetalle ShowRoom.OfertaShowRoomDetalleType readonly,
@CampaniaID int,
@UsuarioCreacion varchar(50)
as
begin

begin tran

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

delete from ShowRoom.OfertaShowRoomDetalle
	where OfertaShowRoomDetalleID not in (select o.OfertaShowRoomDetalleID from ShowRoom.OfertaShowRoomDetalle o
	inner join @OfertaShowRoomDetalle t on
	o.CUV = t.CUV
	and o.Posicion = t.Posicion)

update ShowRoom.OfertaShowRoomDetalle
set NombreProducto = t.NombreProducto,
	Descripcion1 = t.Descripcion1,
	Descripcion2 = t.Descripcion2,
	Descripcion3 = t.Descripcion3,
	UsuarioModificacion = @UsuarioCreacion,
	MarcaProducto = t.MarcaProducto
from ShowRoom.OfertaShowRoomDetalle o
inner join @OfertaShowRoomDetalle t on	
	o.CUV = t.CUV
	and o.Posicion = t.Posicion
	--and o.NombreProducto = t.NombreProducto
where
	o.CampaniaID = @CampaniaID	

insert into ShowRoom.OfertaShowRoomDetalle
(CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,FechaCreacion,UsuarioCreacion,
FechaModificacion,UsuarioModificacion,Posicion,MarcaProducto)
select @CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,getdate(),@UsuarioCreacion,
getdate(),@UsuarioCreacion,Posicion,MarcaProducto
from @OfertaShowRoomDetalle
where 
	NombreProducto not in (select NombreProducto from ShowRoom.OfertaShowRoomDetalle o where o.CampaniaID = @CampaniaID
		and o.CUV = CUV)

end

commit tran

IF (@@ERROR <> 0) BEGIN
PRINT 'Error Inesperado!'
    ROLLBACK TRAN
END

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[InsertCargarProductoCpc]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].InsertCargarProductoCpc
GO

IF (SELECT COUNT(*) FROM sys.table_types WHERE name = 'OfertaShowRoomCompraPorCompraType') = 1
	drop type ShowRoom.OfertaShowRoomCompraPorCompraType

go

go

IF (SELECT COUNT(*) FROM sys.table_types WHERE name = 'OfertaShowRoomCompraPorCompraType') = 0  
  CREATE TYPE ShowRoom.OfertaShowRoomCompraPorCompraType AS TABLE ( 
	CUV varchar(20), SAP varchar(12), Orden int, PrecioValorizado decimal(18,2)
  )
GO

create procedure ShowRoom.InsertCargarProductoCpc
@OfertaShowRoomCompraPorCompra ShowRoom.OfertaShowRoomCompraPorCompraType readonly,
@EventoID int,
@UsuarioCreacion varchar(50)
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

declare @tablaCuv table ( CUV varchar(6))
insert into @tablaCuv
select distinct CUV from ShowRoom.CompraPorCompra where EventoID = @EventoID

update ShowRoom.CompraPorCompra
set 
	Orden = o.Orden,
	PrecioValorizado = o.PrecioValorizado,
	UsuarioModificacion = @UsuarioCreacion,
	FechaModificacion = @FechaGeneral
from ShowRoom.CompraPorCompra cpc
inner join @OfertaShowRoomCompraPorCompra o on
	cpc.CUV = o.CUV
	and cpc.SAP = o.SAP
where cpc.EventoID = @EventoID

insert into ShowRoom.CompraPorCompra (EventoID, CUV, SAP, Orden, PrecioValorizado, 
FechaCreacion, FechaModificacion, UsuarioCreacion, UsuarioModificacion)
select 
	@EventoID, CUV, SAP, Orden, PrecioValorizado, 
	@FechaGeneral, @FechaGeneral, @UsuarioCreacion, @UsuarioCreacion
from @OfertaShowRoomCompraPorCompra
where CUV not in (
	select CUV from @tablaCuv
)

end

go

ALTER procedure ShowRoom.InsertShowRoomEvento
@EventoID int output,
@CampaniaID int,
@Nombre varchar(150),
@Tema varchar(150),
@DiasAntes int,
@DiasDespues int,
@NumeroPerfiles int,
@UsuarioCreacion varchar(20),
@TieneCategoria bit,
@TieneCompraXcompra bit
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

insert into ShowRoom.Evento
(CampaniaID, Nombre, Tema, DiasAntes, DiasDespues, NumeroPerfiles, 
FechaCreacion, UsuarioCreacion, FechaModificacion, UsuarioModificacion, Estado, TieneCategoria, TieneCompraXcompra)
values
(@CampaniaID, @Nombre, @Tema, @DiasAntes, @DiasDespues, @NumeroPerfiles,
@FechaGeneral, @UsuarioCreacion, @FechaGeneral, @UsuarioCreacion, 1, @TieneCategoria, @TieneCompraXcompra)

set @EventoID = @@IDENTITY

end

GO

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
@TieneCompraXcompra bit
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
	TieneCompraXcompra = @TieneCompraXcompra
where EventoID = @EventoID

end

go

alter procedure ShowRoom.GetShowRoomEventoByCampaniaID
@CampaniaID int
as
/*
ShowRoom.GetShowRoomEventoByCampaniaID 201705
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
	isnull(TieneCompraXcompra,0) as TieneCompraXcompra
from ShowRoom.Evento
where CampaniaID = @CampaniaID

end

go

ALTER procedure ShowRoom.InsertShowRoomCargarMasivaConsultora
@EventoConsultora ShowRoom.EventoConsultoraType readonly
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

INSERT INTO ShowRoom.EventoConsultora(EventoID, CampaniaID, CodigoConsultora, Segmento, MostrarPopup,
MostrarPopupVenta, FechaCreacion, UsuarioCreacion, FechaModificacion, UsuarioModificacion)
SELECT DISTINCT EventoID, CampaniaID, CodigoConsultora, Segmento, 1,
1, @FechaGeneral, UsuarioCreacion, @FechaGeneral, UsuarioCreacion
FROM @EventoConsultora

end

go

ALTER procedure ShowRoom.GetShowRoomConsultora
@CampaniaID int,
@CodigoConsultora varchar(20)
as
/*
ShowRoom.GetShowRoomConsultora 201704,'0193037'
*/
begin

select top 1
EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,MostrarPopup,
MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion
from ShowRoom.EventoConsultora
where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
order by FechaCreacion desc

end

go

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

go

ALTER procedure ShowRoom.GetProductosShowRoomDetalle
@CampaniaID int,
@CUV varchar(5)
as
/*
ShowRoom.GetProductosShowRoomDetalle 201705,'96248'
ShowRoom.GetProductosShowRoomDetalle 201705,'99008'
*/
begin

select top 3
	OfertaShowRoomDetalleID,
	CampaniaID,
	CUV,
	isnull(NombreProducto,'') as NombreProducto,
	isnull(Descripcion1,'') as Descripcion1,
	isnull(Descripcion2,'') as Descripcion2,
	isnull(Descripcion3,'') as Descripcion3,
	isnull(Imagen,'') as Imagen,
	FechaCreacion,
	UsuarioCreacion,
	FechaModificacion,
	UsuarioModificacion,
	Posicion,
	MarcaProducto
from ShowRoom.OfertaShowRoomDetalle
where 
	CampaniaID = @CampaniaID
	and CUV = @CUV

end

go

ALTER procedure ShowRoom.InsOfertaShowRoomDetalle
@CampaniaID int,
@CUV varchar(5),
@NombreProducto varchar(100),
@Descripcion1 varchar(150),
@Descripcion2 varchar(150),
@Descripcion3 varchar(150),
@Imagen varchar(150),
@UsuarioCreacion varchar(50),
@MarcaProducto varchar(100)
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

declare @Posicion int = 0
select @Posicion = max(Posicion) from ShowRoom.OfertaShowRoomDetalle
where 
	CampaniaID = @CampaniaID
	and CUV = @CUV

insert into ShowRoom.OfertaShowRoomDetalle
(CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,
Imagen,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,Posicion,MarcaProducto)
values
(@CampaniaID,@CUV,@NombreProducto,@Descripcion1,@Descripcion2,@Descripcion3,
@Imagen,@FechaGeneral,@UsuarioCreacion,@FechaGeneral,@UsuarioCreacion,@Posicion+1,@MarcaProducto)

end

go

ALTER procedure ShowRoom.UpdOfertaShowRoomDetalle
@OfertaShowRoomDetalleID int,
@CampaniaID int,
@CUV varchar(5),
@NombreProducto varchar(100),
@Descripcion1 varchar(150),
@Descripcion2 varchar(150),
@Descripcion3 varchar(150),
@Imagen varchar(150),
@UsuarioModificacion varchar(50),
@MarcaProducto varchar(100)
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

update ShowRoom.OfertaShowRoomDetalle
set
	NombreProducto = @NombreProducto,
	Descripcion1 = @Descripcion1,
	Descripcion2 = @Descripcion2,
	Descripcion3 = @Descripcion3,
	Imagen = @Imagen,
	UsuarioModificacion = @UsuarioModificacion,
	FechaModificacion = @FechaGeneral,
	MarcaProducto = @MarcaProducto
where
	OfertaShowRoomDetalleID = @OfertaShowRoomDetalleID
	and CampaniaID = @CampaniaID
	and CUV = @CUV

end

go


ALTER PROCEDURE dbo.InsPedidoWebDetalleOferta_SB2
	@CampaniaID int,
	@ConsultoraID int,
	@MarcaID tinyint,
	@Cantidad int,
	@PrecioUnidad money,
	@CUV varchar(20),
	@ConfiguracionOfertaID INT,
	@TipoOfertaSisID INT,
	@PaisID int,
	@IPUsuario varchar(25) = null,
	@CodigoUsuarioCreacion varchar(25) = null,
	@OrigenPedidoWeb int = 0,
	@EsCompraPorCompra bit = 0
AS
BEGIN
DECLARE @PedidoDetalleID INT;
DECLARE @PedidoID  INT = 0;
DECLARE @OfertaWeb INT  = 1;
DECLARE @ExisteDet INT = 0;
DECLARE @Orden INT=0;

	EXEC [dbo].[InsPedidoWebOferta] @CampaniaID, @ConsultoraID , @PaisID, @IPUsuario, @CodigoUsuarioCreacion;

	if @TipoOfertaSisID = 1707
	begin
		set @OfertaWeb = 0
	end

	if @EsCompraPorCompra = 1
	begin
		set @OfertaWeb = 0
	end

	SELECT @PedidoID = PedidoID FROM dbo.PedidoWeb WHERE CampaniaID = @CampaniaID AND ConsultoraID = @ConsultoraID;

	SELECT @PedidoDetalleID = MAX(ISNULL(PedidoDetalleID,0))
		   , @Orden = max(ISNULL(OrdenPedidoWD,0))
		   FROM dbo.PedidoWebDetalle 
		   WHERE CampaniaID = @CampaniaID AND PedidoID = @PedidoID
	
	SET @PedidoDetalleID = ISNULL(@PedidoDetalleID, 0) + 1
	SET @Orden = ISNULL(@Orden, 0) + 1

	--SET @PedidoDetalleID =	(SELECT ISNULL(MAX(PedidoDetalleID),0) + 1 
	--							FROM	dbo.PedidoWebDetalle 
	--							WHERE	CampaniaID = @CampaniaID AND
	--									PedidoID = @PedidoID);

	/* Validar Al Agregar Nuevamente */
	set @ExisteDet = (select count(*) from PedidoWebDetalle 
						where CampaniaID = @CampaniaID 
							  AND PedidoID = @PedidoID
							  AND CUV = @CUV
							  AND ClienteID IS NULL);

	IF @ExisteDet = 0 
		BEGIN
			INSERT INTO dbo.PedidoWebDetalle 
			(
			 CampaniaID,
			 PedidoID,
			 PedidoDetalleID,
			 MarcaID,
			 ConsultoraID,
			 ClienteID,
			 Cantidad,
			 PrecioUnidad,
			 ImporteTotal,
			 CUV,
			 OfertaWeb, 
			 ModificaPedidoReservado,
			 ConfiguracionOfertaID,
			 TipoOfertaSisID,
			 CodigoUsuarioCreacion,
			 FechaCreacion,
			 OrdenPedidoWD,
			 OrigenPedidoWeb
			)

		VALUES (@CampaniaID,@PedidoID,@PedidoDetalleID,
				@MarcaID,@ConsultoraID,NULL,
				@Cantidad,@PrecioUnidad,@Cantidad*@PrecioUnidad,@CUV,@OfertaWeb,0, @ConfiguracionOfertaID, @TipoOfertaSisID,
				@CodigoUsuarioCreacion, dbo.fnObtenerFechaHoraPais(), @Orden, @OrigenPedidoWeb)
		END
	ELSE
		BEGIN
			UPDATE dbo.PedidoWebDetalle
				SET Cantidad += @Cantidad,
					ImporteTotal = ((Cantidad + @Cantidad) * @PrecioUnidad),
					CodigoUsuarioModificacion = @CodigoUsuarioCreacion,
					FechaModificacion = dbo.fnObtenerFechaHoraPais(),
					OrdenPedidoWD = @Orden,
					OrigenPedidoWeb = @OrigenPedidoWeb
			WHERE CampaniaID = @CampaniaID 
				  AND PedidoID = @PedidoID
				  AND CUV = @CUV
				  AND ClienteID IS NULL		
		END
END

GO

USE BelcorpPuertoRico
go

delete from dbo.TablaLogicaDatos where TablaLogicaID = 99
delete from dbo.TablaLogica where TablaLogicaID = 99

go

if not exists (select 1 from dbo.TablaLogica where TablaLogicaID = 99)
begin
	insert into dbo.TablaLogica(TablaLogicaID,Descripcion) values (99,'OrdenamientoShowRoom')
end

go

if not exists (select 1 from dbo.TablaLogicaDatos where TablaLogicaID = 99 and Codigo='01')
begin
	insert into dbo.TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) 
	values (9901,99,'01','Los más vendidos')
end

go

if not exists (select 1 from dbo.TablaLogicaDatos where TablaLogicaID = 99 and Codigo='02')
begin
	insert into dbo.TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) 
	values (9902,99,'02','Menor a mayor precio')
end

go

if not exists (select 1 from dbo.TablaLogicaDatos where TablaLogicaID = 99 and Codigo='03')
begin
	insert into dbo.TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) 
	values (9903,99,'03','Mayor a menor precio')
end

go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.Evento') and SYSCOLUMNS.NAME = N'TieneCategoria') = 0
	ALTER TABLE ShowRoom.Evento ADD TieneCategoria bit
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.Evento') and SYSCOLUMNS.NAME = N'TieneCompraXcompra') = 0
	ALTER TABLE ShowRoom.Evento ADD TieneCompraXcompra bit
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'CodigoCategoria') = 0
	ALTER TABLE ShowRoom.OfertaShowRoom ADD CodigoCategoria varchar(100)
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'TipNegocio') = 0
	ALTER TABLE ShowRoom.OfertaShowRoom ADD TipNegocio varchar(500)
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoomDetalle') and SYSCOLUMNS.NAME = N'MarcaProducto') = 0
	ALTER TABLE ShowRoom.OfertaShowRoomDetalle ADD MarcaProducto varchar(100)
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.EventoConsultora') and SYSCOLUMNS.NAME = N'MostrarPopupVenta') = 0
	ALTER TABLE ShowRoom.EventoConsultora ADD MostrarPopupVenta bit
go

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[Nivel]') AND (type = 'U') )
	DROP TABLE ShowRoom.Nivel
GO

create table ShowRoom.Nivel
(
	NivelId int identity(1,1) primary key,
	Codigo varchar(100),
	Descripcion varchar(100)
)

go

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[Personalizacion]') AND (type = 'U') )
	DROP TABLE ShowRoom.Personalizacion
GO

create table ShowRoom.Personalizacion
(
	PersonalizacionId int identity(1,1) primary key,
	TipoAplicacion varchar(20),
	Atributo varchar(100),
	TextoAyuda varchar(200),
	TipoAtributo varchar(20),
	TipoPersonalizacion varchar(20),
	Orden int,
	Estado bit
)

go

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[PersonalizacionNivel]') AND (type = 'U') )
	DROP TABLE ShowRoom.PersonalizacionNivel
GO

create table ShowRoom.PersonalizacionNivel
(
	PersonalizacionNivelId int identity(1,1) primary key,
	EventoID int,
	PersonalizacionId int,
	NivelId int,
	CategoriaId int,
	Valor varchar(200)
)

go

CREATE NONCLUSTERED INDEX IX_ShowRoomPersonalizacionNivel_EventoIdNivelId ON ShowRoom.PersonalizacionNivel (EventoID,NivelId);

go

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[Categoria]') AND (type = 'U') )
	DROP TABLE ShowRoom.Categoria
GO

create table ShowRoom.Categoria
(
	CategoriaId int identity(1,1) primary key,
	EventoID int,
	Codigo varchar(50),
	Descripcion varchar(200)
)

go

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[CompraPorCompra]') AND (type = 'U') )
	DROP TABLE ShowRoom.CompraPorCompra
GO

CREATE TABLE ShowRoom.CompraPorCompra
(
	CompraxCompraID int identity(1,1) primary key,
	EventoID int,
	CUV varchar(20),
	SAP varchar(12),
	Orden int,
	PrecioValorizado decimal(18,2),
	FechaCreacion datetime,
	UsuarioCreacion varchar(50),
	FechaModificacion datetime,
	UsuarioModificacion varchar(50)
)

GO

insert into ShowRoom.Nivel (Codigo,Descripcion) values ('PAIS','País')

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','PopupImagenIntriga','Popup Principal Intriga (615px x 409px)','IMAGEN','EVENTO',1,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','PopupImagenVenta','Popup Principal Venta (615px x 409px)','IMAGEN','EVENTO',2,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','BannerImagenIntriga','Visual Superior Intriga (1920px x 174px)','IMAGEN','EVENTO',3,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','BannerImagenVenta','Visual Superior Venta (1920px x 174px)','IMAGEN','EVENTO',4,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','UrlTerminosCondiciones','Link Terminos y Condiciones','TEXTO','EVENTO',5,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','TextoCondicionCompraCpc','Texto Condición de Compra por Compra','TEXTO','EVENTO',6,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','TextoDescripcionLegalCpc','Texto Descripción Legal Compra por Compra','TEXTO','EVENTO',7,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','IconoLluvia','Icono Lluvia Paginal Principal','IMAGEN','EVENTO',8,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','BannerEnvioCorreo','Imagen Envio Correo','IMAGEN','EVENTO',9,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','TextoEnvioCorreo','Texto mostrar Envio Correo','TEXTO','EVENTO',10,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','ImagenFondoProductPage','Imagen de Fondo del Product Page','IMAGEN','EVENTO',11,1)

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','TituloPrincipal','Título de la Categoria','TEXTO','CATEGORIA',12,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','ImagenPrincipal','Imagen a mostrar en la Categoria','IMAGEN','CATEGORIA',13,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','ColorFondo','Color de Fondo de la Categoria','TEXTO','CATEGORIA',14,1)

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','PopupImagenIntriga','Banner Marquesina Intriga (768px x 420px)','IMAGEN','EVENTO',1,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','PopupImagenVenta','Banner Marquesina Venta (768px x 420px)','IMAGEN','EVENTO',2,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','BannerImagenIntriga','Banner Superior Intriga (1024px x 60px)','IMAGEN','EVENTO',3,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','BannerImagenPaginaVenta','Banner Superior Pagina Venta (1024px x 60px)','IMAGEN','EVENTO',4,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','BannerImagenVenta','Banner Superior Venta Otras Paginas (1024px x 60px)','IMAGEN','EVENTO',5,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','UrlTerminosCondiciones','Link Terminos y Condiciones','TEXTO','EVENTO',6,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','TextoCondicionCompraCpc','Texto Condición de Compra','TEXTO','EVENTO',7,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','TextoDescripcionLegalCpc','Texto Descripción Legal Compra por Compra','TEXTO','EVENTO',8,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','ImagenFondoProductPage','Imagen de Fondo del Product Page','IMAGEN','EVENTO',9,1)

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','TituloPrincipal','Título de la Categoria','TEXTO','CATEGORIA',10,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','ColorFondo','Color de Fondo de la Categoria','TEXTO','CATEGORIA',11,1)

go

update ShowRoom.EventoConsultora set MostrarPopup = 1 where MostrarPopup is null
update ShowRoom.EventoConsultora set MostrarPopupVenta = 1 where MostrarPopupVenta is null

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomNivel]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomNivel
GO

create procedure ShowRoom.GetShowRoomNivel
as
/*
ShowRoom.GetShowRoomNivel
*/
begin

select
	NivelId,
	Codigo,
	Descripcion
from ShowRoom.Nivel

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomPersonalizacion]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomPersonalizacion
GO

create procedure ShowRoom.GetShowRoomPersonalizacion
as
/*
ShowRoom.GetShowRoomPersonalizacion
*/
begin

select
	PersonalizacionId,
	TipoAplicacion,
	Atributo,
	TextoAyuda,
	TipoAtributo,
	TipoPersonalizacion,
	Orden,
	Estado
from ShowRoom.Personalizacion

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomPersonalizacionNivel]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomPersonalizacionNivel
GO

create procedure ShowRoom.GetShowRoomPersonalizacionNivel
@EventoId int,
@NivelId int = 0,
@CategoriaId int = 0
as
/*
ShowRoom.GetShowRoomPersonalizacionNivel 2006,1,0
ShowRoom.GetShowRoomPersonalizacionNivel 2006,0,1
*/
begin

select 
	PersonalizacionNivelId,
	EventoID,
	PersonalizacionId,
	isnull(NivelId,0) as NivelId,
	isnull(CategoriaId,0) as CategoriaId,
	isnull(Valor,'') as Valor
from ShowRoom.PersonalizacionNivel
where
	EventoID = @EventoId
	and (@NivelId = 0 or NivelId = @NivelId)
	and (@CategoriaId = 0 or CategoriaId = @CategoriaId)

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[InsertShowRoomPersonalizacionNivel]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].InsertShowRoomPersonalizacionNivel
GO

create procedure ShowRoom.InsertShowRoomPersonalizacionNivel
@EventoID int,
@PersonalizacionId int,
@NivelId int,
@CategoriaId int = 0,
@Valor varchar(200)
as
begin

insert into ShowRoom.PersonalizacionNivel (EventoID, PersonalizacionId, NivelId, CategoriaId, Valor)
values (@EventoID, @PersonalizacionId, @NivelId, @CategoriaId, @Valor)

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[UpdateShowRoomPersonalizacionNivel]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].UpdateShowRoomPersonalizacionNivel
GO

create procedure ShowRoom.UpdateShowRoomPersonalizacionNivel
@PersonalizacionNivelId int,
@Valor varchar(200)
as
begin

update ShowRoom.PersonalizacionNivel
	set Valor = @Valor
where PersonalizacionNivelId = @PersonalizacionNivelId

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomCategorias]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomCategorias
GO

create procedure ShowRoom.GetShowRoomCategorias
@EventoId int
as
/*
ShowRoom.GetShowRoomCategorias 6
*/
begin

select
	CategoriaId,
	EventoID,
	Codigo,
	Descripcion
from ShowRoom.Categoria
where EventoID = @EventoId

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomCategoriaById]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomCategoriaById
GO

create procedure ShowRoom.GetShowRoomCategoriaById
@CategoriaId int
as
/*
ShowRoom.GetShowRoomCategoriaById 1
*/
begin

select
	CategoriaId,
	EventoID,
	Codigo,
	Descripcion
from ShowRoom.Categoria
where CategoriaId = @CategoriaId

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[UpdateShowRoomDescripcionCategoria]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].UpdateShowRoomDescripcionCategoria
GO

create procedure ShowRoom.UpdateShowRoomDescripcionCategoria
@CategoriaId int,
@Descripcion varchar(200)
as
begin

update ShowRoom.Categoria
set
	Descripcion = @Descripcion
where 
	CategoriaId = @CategoriaId

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[DeleteShowRoomCategoriaByEvento]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].DeleteShowRoomCategoriaByEvento
GO

create procedure ShowRoom.DeleteShowRoomCategoriaByEvento
@EventoId int
as
begin

delete from ShowRoom.PersonalizacionNivel where EventoID = @EventoId and NivelId = 0
delete from ShowRoom.Categoria where EventoId = @EventoID

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[InsertShowRoomCategoria]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].InsertShowRoomCategoria
GO

create procedure ShowRoom.InsertShowRoomCategoria
@EventoID int,
@Codigo varchar(50),
@Descripcion varchar(200)
as
begin

insert into ShowRoom.Categoria (EventoID, Codigo, Descripcion) values (@EventoID, @Codigo, @Descripcion)

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomCompraPorCompra]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomCompraPorCompra
GO

create procedure ShowRoom.GetShowRoomCompraPorCompra
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

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[UpdStockOfertaShowRoomMasivo]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].UpdStockOfertaShowRoomMasivo
GO

IF (SELECT COUNT(*) FROM sys.table_types WHERE name = 'StockPrecioOfertaShowRoomType') = 1
	drop type ShowRoom.StockPrecioOfertaShowRoomType

go

go

IF (SELECT COUNT(*) FROM sys.table_types WHERE name = 'StockPrecioOfertaShowRoomType') = 0  
  CREATE TYPE ShowRoom.StockPrecioOfertaShowRoomType AS TABLE ( 
	TipoOfertaSisID int, CampaniaID int, CUV varchar(20), Stock int, PrecioOferta decimal(18,2), UnidadesPermitidas int,
	Descripcion varchar(250), CodigoCategoria varchar(100), TipNegocio varchar(500)
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
	TipNegocio = t.TipNegocio
FROM ShowRoom.OfertaShowRoom o
INNER JOIN ods.Campania c on 
	c.CampaniaID = o.CampaniaID
JOIN @StockPrecioOfertaShowRoom t ON 
	c.Codigo = t.CampaniaID
	AND o.CUV = t.CUV
	AND o.TipoOfertaSisID = t.TipoOfertaSisID

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[InsertCargaMasivaOfertaDetalle]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].InsertCargaMasivaOfertaDetalle
GO

IF (SELECT COUNT(*) FROM sys.table_types WHERE name = 'OfertaShowRoomDetalleType') = 1
	drop type ShowRoom.OfertaShowRoomDetalleType

go

go

IF (SELECT COUNT(*) FROM sys.table_types WHERE name = 'OfertaShowRoomDetalleType') = 0 
CREATE TYPE ShowRoom.OfertaShowRoomDetalleType AS TABLE(
	CUV varchar(20) NULL,
	NombreProducto varchar(150) NULL,
	Descripcion1 varchar(150) NULL,
	Descripcion2 varchar(150) NULL,
	Descripcion3 varchar(150) NULL,
	Posicion int NULL,
	MarcaProducto varchar(100) NULL
)

go

create procedure ShowRoom.InsertCargaMasivaOfertaDetalle
@OfertaShowRoomDetalle ShowRoom.OfertaShowRoomDetalleType readonly,
@CampaniaID int,
@UsuarioCreacion varchar(50)
as
begin

begin tran

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

delete from ShowRoom.OfertaShowRoomDetalle
	where OfertaShowRoomDetalleID not in (select o.OfertaShowRoomDetalleID from ShowRoom.OfertaShowRoomDetalle o
	inner join @OfertaShowRoomDetalle t on
	o.CUV = t.CUV
	and o.Posicion = t.Posicion)

update ShowRoom.OfertaShowRoomDetalle
set NombreProducto = t.NombreProducto,
	Descripcion1 = t.Descripcion1,
	Descripcion2 = t.Descripcion2,
	Descripcion3 = t.Descripcion3,
	UsuarioModificacion = @UsuarioCreacion,
	MarcaProducto = t.MarcaProducto
from ShowRoom.OfertaShowRoomDetalle o
inner join @OfertaShowRoomDetalle t on	
	o.CUV = t.CUV
	and o.Posicion = t.Posicion
	--and o.NombreProducto = t.NombreProducto
where
	o.CampaniaID = @CampaniaID	

insert into ShowRoom.OfertaShowRoomDetalle
(CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,FechaCreacion,UsuarioCreacion,
FechaModificacion,UsuarioModificacion,Posicion,MarcaProducto)
select @CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,getdate(),@UsuarioCreacion,
getdate(),@UsuarioCreacion,Posicion,MarcaProducto
from @OfertaShowRoomDetalle
where 
	NombreProducto not in (select NombreProducto from ShowRoom.OfertaShowRoomDetalle o where o.CampaniaID = @CampaniaID
		and o.CUV = CUV)

end

commit tran

IF (@@ERROR <> 0) BEGIN
PRINT 'Error Inesperado!'
    ROLLBACK TRAN
END

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[InsertCargarProductoCpc]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].InsertCargarProductoCpc
GO

IF (SELECT COUNT(*) FROM sys.table_types WHERE name = 'OfertaShowRoomCompraPorCompraType') = 1
	drop type ShowRoom.OfertaShowRoomCompraPorCompraType

go

go

IF (SELECT COUNT(*) FROM sys.table_types WHERE name = 'OfertaShowRoomCompraPorCompraType') = 0  
  CREATE TYPE ShowRoom.OfertaShowRoomCompraPorCompraType AS TABLE ( 
	CUV varchar(20), SAP varchar(12), Orden int, PrecioValorizado decimal(18,2)
  )
GO

create procedure ShowRoom.InsertCargarProductoCpc
@OfertaShowRoomCompraPorCompra ShowRoom.OfertaShowRoomCompraPorCompraType readonly,
@EventoID int,
@UsuarioCreacion varchar(50)
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

declare @tablaCuv table ( CUV varchar(6))
insert into @tablaCuv
select distinct CUV from ShowRoom.CompraPorCompra where EventoID = @EventoID

update ShowRoom.CompraPorCompra
set 
	Orden = o.Orden,
	PrecioValorizado = o.PrecioValorizado,
	UsuarioModificacion = @UsuarioCreacion,
	FechaModificacion = @FechaGeneral
from ShowRoom.CompraPorCompra cpc
inner join @OfertaShowRoomCompraPorCompra o on
	cpc.CUV = o.CUV
	and cpc.SAP = o.SAP
where cpc.EventoID = @EventoID

insert into ShowRoom.CompraPorCompra (EventoID, CUV, SAP, Orden, PrecioValorizado, 
FechaCreacion, FechaModificacion, UsuarioCreacion, UsuarioModificacion)
select 
	@EventoID, CUV, SAP, Orden, PrecioValorizado, 
	@FechaGeneral, @FechaGeneral, @UsuarioCreacion, @UsuarioCreacion
from @OfertaShowRoomCompraPorCompra
where CUV not in (
	select CUV from @tablaCuv
)

end

go

ALTER procedure ShowRoom.InsertShowRoomEvento
@EventoID int output,
@CampaniaID int,
@Nombre varchar(150),
@Tema varchar(150),
@DiasAntes int,
@DiasDespues int,
@NumeroPerfiles int,
@UsuarioCreacion varchar(20),
@TieneCategoria bit,
@TieneCompraXcompra bit
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

insert into ShowRoom.Evento
(CampaniaID, Nombre, Tema, DiasAntes, DiasDespues, NumeroPerfiles, 
FechaCreacion, UsuarioCreacion, FechaModificacion, UsuarioModificacion, Estado, TieneCategoria, TieneCompraXcompra)
values
(@CampaniaID, @Nombre, @Tema, @DiasAntes, @DiasDespues, @NumeroPerfiles,
@FechaGeneral, @UsuarioCreacion, @FechaGeneral, @UsuarioCreacion, 1, @TieneCategoria, @TieneCompraXcompra)

set @EventoID = @@IDENTITY

end

GO

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
@TieneCompraXcompra bit
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
	TieneCompraXcompra = @TieneCompraXcompra
where EventoID = @EventoID

end

go

alter procedure ShowRoom.GetShowRoomEventoByCampaniaID
@CampaniaID int
as
/*
ShowRoom.GetShowRoomEventoByCampaniaID 201705
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
	isnull(TieneCompraXcompra,0) as TieneCompraXcompra
from ShowRoom.Evento
where CampaniaID = @CampaniaID

end

go

ALTER procedure ShowRoom.InsertShowRoomCargarMasivaConsultora
@EventoConsultora ShowRoom.EventoConsultoraType readonly
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

INSERT INTO ShowRoom.EventoConsultora(EventoID, CampaniaID, CodigoConsultora, Segmento, MostrarPopup,
MostrarPopupVenta, FechaCreacion, UsuarioCreacion, FechaModificacion, UsuarioModificacion)
SELECT DISTINCT EventoID, CampaniaID, CodigoConsultora, Segmento, 1,
1, @FechaGeneral, UsuarioCreacion, @FechaGeneral, UsuarioCreacion
FROM @EventoConsultora

end

go

ALTER procedure ShowRoom.GetShowRoomConsultora
@CampaniaID int,
@CodigoConsultora varchar(20)
as
/*
ShowRoom.GetShowRoomConsultora 201704,'0193037'
*/
begin

select top 1
EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,MostrarPopup,
MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion
from ShowRoom.EventoConsultora
where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
order by FechaCreacion desc

end

go

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

go

ALTER procedure ShowRoom.GetProductosShowRoomDetalle
@CampaniaID int,
@CUV varchar(5)
as
/*
ShowRoom.GetProductosShowRoomDetalle 201705,'96248'
ShowRoom.GetProductosShowRoomDetalle 201705,'99008'
*/
begin

select top 3
	OfertaShowRoomDetalleID,
	CampaniaID,
	CUV,
	isnull(NombreProducto,'') as NombreProducto,
	isnull(Descripcion1,'') as Descripcion1,
	isnull(Descripcion2,'') as Descripcion2,
	isnull(Descripcion3,'') as Descripcion3,
	isnull(Imagen,'') as Imagen,
	FechaCreacion,
	UsuarioCreacion,
	FechaModificacion,
	UsuarioModificacion,
	Posicion,
	MarcaProducto
from ShowRoom.OfertaShowRoomDetalle
where 
	CampaniaID = @CampaniaID
	and CUV = @CUV

end

go

ALTER procedure ShowRoom.InsOfertaShowRoomDetalle
@CampaniaID int,
@CUV varchar(5),
@NombreProducto varchar(100),
@Descripcion1 varchar(150),
@Descripcion2 varchar(150),
@Descripcion3 varchar(150),
@Imagen varchar(150),
@UsuarioCreacion varchar(50),
@MarcaProducto varchar(100)
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

declare @Posicion int = 0
select @Posicion = max(Posicion) from ShowRoom.OfertaShowRoomDetalle
where 
	CampaniaID = @CampaniaID
	and CUV = @CUV

insert into ShowRoom.OfertaShowRoomDetalle
(CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,
Imagen,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,Posicion,MarcaProducto)
values
(@CampaniaID,@CUV,@NombreProducto,@Descripcion1,@Descripcion2,@Descripcion3,
@Imagen,@FechaGeneral,@UsuarioCreacion,@FechaGeneral,@UsuarioCreacion,@Posicion+1,@MarcaProducto)

end

go

ALTER procedure ShowRoom.UpdOfertaShowRoomDetalle
@OfertaShowRoomDetalleID int,
@CampaniaID int,
@CUV varchar(5),
@NombreProducto varchar(100),
@Descripcion1 varchar(150),
@Descripcion2 varchar(150),
@Descripcion3 varchar(150),
@Imagen varchar(150),
@UsuarioModificacion varchar(50),
@MarcaProducto varchar(100)
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

update ShowRoom.OfertaShowRoomDetalle
set
	NombreProducto = @NombreProducto,
	Descripcion1 = @Descripcion1,
	Descripcion2 = @Descripcion2,
	Descripcion3 = @Descripcion3,
	Imagen = @Imagen,
	UsuarioModificacion = @UsuarioModificacion,
	FechaModificacion = @FechaGeneral,
	MarcaProducto = @MarcaProducto
where
	OfertaShowRoomDetalleID = @OfertaShowRoomDetalleID
	and CampaniaID = @CampaniaID
	and CUV = @CUV

end

go


ALTER PROCEDURE dbo.InsPedidoWebDetalleOferta_SB2
	@CampaniaID int,
	@ConsultoraID int,
	@MarcaID tinyint,
	@Cantidad int,
	@PrecioUnidad money,
	@CUV varchar(20),
	@ConfiguracionOfertaID INT,
	@TipoOfertaSisID INT,
	@PaisID int,
	@IPUsuario varchar(25) = null,
	@CodigoUsuarioCreacion varchar(25) = null,
	@OrigenPedidoWeb int = 0,
	@EsCompraPorCompra bit = 0
AS
BEGIN
DECLARE @PedidoDetalleID INT;
DECLARE @PedidoID  INT = 0;
DECLARE @OfertaWeb INT  = 1;
DECLARE @ExisteDet INT = 0;
DECLARE @Orden INT=0;

	EXEC [dbo].[InsPedidoWebOferta] @CampaniaID, @ConsultoraID , @PaisID, @IPUsuario, @CodigoUsuarioCreacion;

	if @TipoOfertaSisID = 1707
	begin
		set @OfertaWeb = 0
	end

	if @EsCompraPorCompra = 1
	begin
		set @OfertaWeb = 0
	end

	SELECT @PedidoID = PedidoID FROM dbo.PedidoWeb WHERE CampaniaID = @CampaniaID AND ConsultoraID = @ConsultoraID;

	SELECT @PedidoDetalleID = MAX(ISNULL(PedidoDetalleID,0))
		   , @Orden = max(ISNULL(OrdenPedidoWD,0))
		   FROM dbo.PedidoWebDetalle 
		   WHERE CampaniaID = @CampaniaID AND PedidoID = @PedidoID
	
	SET @PedidoDetalleID = ISNULL(@PedidoDetalleID, 0) + 1
	SET @Orden = ISNULL(@Orden, 0) + 1

	--SET @PedidoDetalleID =	(SELECT ISNULL(MAX(PedidoDetalleID),0) + 1 
	--							FROM	dbo.PedidoWebDetalle 
	--							WHERE	CampaniaID = @CampaniaID AND
	--									PedidoID = @PedidoID);

	/* Validar Al Agregar Nuevamente */
	set @ExisteDet = (select count(*) from PedidoWebDetalle 
						where CampaniaID = @CampaniaID 
							  AND PedidoID = @PedidoID
							  AND CUV = @CUV
							  AND ClienteID IS NULL);

	IF @ExisteDet = 0 
		BEGIN
			INSERT INTO dbo.PedidoWebDetalle 
			(
			 CampaniaID,
			 PedidoID,
			 PedidoDetalleID,
			 MarcaID,
			 ConsultoraID,
			 ClienteID,
			 Cantidad,
			 PrecioUnidad,
			 ImporteTotal,
			 CUV,
			 OfertaWeb, 
			 ModificaPedidoReservado,
			 ConfiguracionOfertaID,
			 TipoOfertaSisID,
			 CodigoUsuarioCreacion,
			 FechaCreacion,
			 OrdenPedidoWD,
			 OrigenPedidoWeb
			)

		VALUES (@CampaniaID,@PedidoID,@PedidoDetalleID,
				@MarcaID,@ConsultoraID,NULL,
				@Cantidad,@PrecioUnidad,@Cantidad*@PrecioUnidad,@CUV,@OfertaWeb,0, @ConfiguracionOfertaID, @TipoOfertaSisID,
				@CodigoUsuarioCreacion, dbo.fnObtenerFechaHoraPais(), @Orden, @OrigenPedidoWeb)
		END
	ELSE
		BEGIN
			UPDATE dbo.PedidoWebDetalle
				SET Cantidad += @Cantidad,
					ImporteTotal = ((Cantidad + @Cantidad) * @PrecioUnidad),
					CodigoUsuarioModificacion = @CodigoUsuarioCreacion,
					FechaModificacion = dbo.fnObtenerFechaHoraPais(),
					OrdenPedidoWD = @Orden,
					OrigenPedidoWeb = @OrigenPedidoWeb
			WHERE CampaniaID = @CampaniaID 
				  AND PedidoID = @PedidoID
				  AND CUV = @CUV
				  AND ClienteID IS NULL		
		END
END

GO

USE BelcorpSalvador
go

delete from dbo.TablaLogicaDatos where TablaLogicaID = 99
delete from dbo.TablaLogica where TablaLogicaID = 99

go

if not exists (select 1 from dbo.TablaLogica where TablaLogicaID = 99)
begin
	insert into dbo.TablaLogica(TablaLogicaID,Descripcion) values (99,'OrdenamientoShowRoom')
end

go

if not exists (select 1 from dbo.TablaLogicaDatos where TablaLogicaID = 99 and Codigo='01')
begin
	insert into dbo.TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) 
	values (9901,99,'01','Los más vendidos')
end

go

if not exists (select 1 from dbo.TablaLogicaDatos where TablaLogicaID = 99 and Codigo='02')
begin
	insert into dbo.TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) 
	values (9902,99,'02','Menor a mayor precio')
end

go

if not exists (select 1 from dbo.TablaLogicaDatos where TablaLogicaID = 99 and Codigo='03')
begin
	insert into dbo.TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) 
	values (9903,99,'03','Mayor a menor precio')
end

go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.Evento') and SYSCOLUMNS.NAME = N'TieneCategoria') = 0
	ALTER TABLE ShowRoom.Evento ADD TieneCategoria bit
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.Evento') and SYSCOLUMNS.NAME = N'TieneCompraXcompra') = 0
	ALTER TABLE ShowRoom.Evento ADD TieneCompraXcompra bit
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'CodigoCategoria') = 0
	ALTER TABLE ShowRoom.OfertaShowRoom ADD CodigoCategoria varchar(100)
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'TipNegocio') = 0
	ALTER TABLE ShowRoom.OfertaShowRoom ADD TipNegocio varchar(500)
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoomDetalle') and SYSCOLUMNS.NAME = N'MarcaProducto') = 0
	ALTER TABLE ShowRoom.OfertaShowRoomDetalle ADD MarcaProducto varchar(100)
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.EventoConsultora') and SYSCOLUMNS.NAME = N'MostrarPopupVenta') = 0
	ALTER TABLE ShowRoom.EventoConsultora ADD MostrarPopupVenta bit
go

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[Nivel]') AND (type = 'U') )
	DROP TABLE ShowRoom.Nivel
GO

create table ShowRoom.Nivel
(
	NivelId int identity(1,1) primary key,
	Codigo varchar(100),
	Descripcion varchar(100)
)

go

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[Personalizacion]') AND (type = 'U') )
	DROP TABLE ShowRoom.Personalizacion
GO

create table ShowRoom.Personalizacion
(
	PersonalizacionId int identity(1,1) primary key,
	TipoAplicacion varchar(20),
	Atributo varchar(100),
	TextoAyuda varchar(200),
	TipoAtributo varchar(20),
	TipoPersonalizacion varchar(20),
	Orden int,
	Estado bit
)

go

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[PersonalizacionNivel]') AND (type = 'U') )
	DROP TABLE ShowRoom.PersonalizacionNivel
GO

create table ShowRoom.PersonalizacionNivel
(
	PersonalizacionNivelId int identity(1,1) primary key,
	EventoID int,
	PersonalizacionId int,
	NivelId int,
	CategoriaId int,
	Valor varchar(200)
)

go

CREATE NONCLUSTERED INDEX IX_ShowRoomPersonalizacionNivel_EventoIdNivelId ON ShowRoom.PersonalizacionNivel (EventoID,NivelId);

go

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[Categoria]') AND (type = 'U') )
	DROP TABLE ShowRoom.Categoria
GO

create table ShowRoom.Categoria
(
	CategoriaId int identity(1,1) primary key,
	EventoID int,
	Codigo varchar(50),
	Descripcion varchar(200)
)

go

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[CompraPorCompra]') AND (type = 'U') )
	DROP TABLE ShowRoom.CompraPorCompra
GO

CREATE TABLE ShowRoom.CompraPorCompra
(
	CompraxCompraID int identity(1,1) primary key,
	EventoID int,
	CUV varchar(20),
	SAP varchar(12),
	Orden int,
	PrecioValorizado decimal(18,2),
	FechaCreacion datetime,
	UsuarioCreacion varchar(50),
	FechaModificacion datetime,
	UsuarioModificacion varchar(50)
)

GO

insert into ShowRoom.Nivel (Codigo,Descripcion) values ('PAIS','País')

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','PopupImagenIntriga','Popup Principal Intriga (615px x 409px)','IMAGEN','EVENTO',1,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','PopupImagenVenta','Popup Principal Venta (615px x 409px)','IMAGEN','EVENTO',2,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','BannerImagenIntriga','Visual Superior Intriga (1920px x 174px)','IMAGEN','EVENTO',3,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','BannerImagenVenta','Visual Superior Venta (1920px x 174px)','IMAGEN','EVENTO',4,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','UrlTerminosCondiciones','Link Terminos y Condiciones','TEXTO','EVENTO',5,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','TextoCondicionCompraCpc','Texto Condición de Compra por Compra','TEXTO','EVENTO',6,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','TextoDescripcionLegalCpc','Texto Descripción Legal Compra por Compra','TEXTO','EVENTO',7,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','IconoLluvia','Icono Lluvia Paginal Principal','IMAGEN','EVENTO',8,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','BannerEnvioCorreo','Imagen Envio Correo','IMAGEN','EVENTO',9,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','TextoEnvioCorreo','Texto mostrar Envio Correo','TEXTO','EVENTO',10,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','ImagenFondoProductPage','Imagen de Fondo del Product Page','IMAGEN','EVENTO',11,1)

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','TituloPrincipal','Título de la Categoria','TEXTO','CATEGORIA',12,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','ImagenPrincipal','Imagen a mostrar en la Categoria','IMAGEN','CATEGORIA',13,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','ColorFondo','Color de Fondo de la Categoria','TEXTO','CATEGORIA',14,1)

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','PopupImagenIntriga','Banner Marquesina Intriga (768px x 420px)','IMAGEN','EVENTO',1,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','PopupImagenVenta','Banner Marquesina Venta (768px x 420px)','IMAGEN','EVENTO',2,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','BannerImagenIntriga','Banner Superior Intriga (1024px x 60px)','IMAGEN','EVENTO',3,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','BannerImagenPaginaVenta','Banner Superior Pagina Venta (1024px x 60px)','IMAGEN','EVENTO',4,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','BannerImagenVenta','Banner Superior Venta Otras Paginas (1024px x 60px)','IMAGEN','EVENTO',5,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','UrlTerminosCondiciones','Link Terminos y Condiciones','TEXTO','EVENTO',6,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','TextoCondicionCompraCpc','Texto Condición de Compra','TEXTO','EVENTO',7,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','TextoDescripcionLegalCpc','Texto Descripción Legal Compra por Compra','TEXTO','EVENTO',8,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','ImagenFondoProductPage','Imagen de Fondo del Product Page','IMAGEN','EVENTO',9,1)

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','TituloPrincipal','Título de la Categoria','TEXTO','CATEGORIA',10,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','ColorFondo','Color de Fondo de la Categoria','TEXTO','CATEGORIA',11,1)

go

update ShowRoom.EventoConsultora set MostrarPopup = 1 where MostrarPopup is null
update ShowRoom.EventoConsultora set MostrarPopupVenta = 1 where MostrarPopupVenta is null

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomNivel]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomNivel
GO

create procedure ShowRoom.GetShowRoomNivel
as
/*
ShowRoom.GetShowRoomNivel
*/
begin

select
	NivelId,
	Codigo,
	Descripcion
from ShowRoom.Nivel

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomPersonalizacion]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomPersonalizacion
GO

create procedure ShowRoom.GetShowRoomPersonalizacion
as
/*
ShowRoom.GetShowRoomPersonalizacion
*/
begin

select
	PersonalizacionId,
	TipoAplicacion,
	Atributo,
	TextoAyuda,
	TipoAtributo,
	TipoPersonalizacion,
	Orden,
	Estado
from ShowRoom.Personalizacion

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomPersonalizacionNivel]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomPersonalizacionNivel
GO

create procedure ShowRoom.GetShowRoomPersonalizacionNivel
@EventoId int,
@NivelId int = 0,
@CategoriaId int = 0
as
/*
ShowRoom.GetShowRoomPersonalizacionNivel 2006,1,0
ShowRoom.GetShowRoomPersonalizacionNivel 2006,0,1
*/
begin

select 
	PersonalizacionNivelId,
	EventoID,
	PersonalizacionId,
	isnull(NivelId,0) as NivelId,
	isnull(CategoriaId,0) as CategoriaId,
	isnull(Valor,'') as Valor
from ShowRoom.PersonalizacionNivel
where
	EventoID = @EventoId
	and (@NivelId = 0 or NivelId = @NivelId)
	and (@CategoriaId = 0 or CategoriaId = @CategoriaId)

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[InsertShowRoomPersonalizacionNivel]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].InsertShowRoomPersonalizacionNivel
GO

create procedure ShowRoom.InsertShowRoomPersonalizacionNivel
@EventoID int,
@PersonalizacionId int,
@NivelId int,
@CategoriaId int = 0,
@Valor varchar(200)
as
begin

insert into ShowRoom.PersonalizacionNivel (EventoID, PersonalizacionId, NivelId, CategoriaId, Valor)
values (@EventoID, @PersonalizacionId, @NivelId, @CategoriaId, @Valor)

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[UpdateShowRoomPersonalizacionNivel]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].UpdateShowRoomPersonalizacionNivel
GO

create procedure ShowRoom.UpdateShowRoomPersonalizacionNivel
@PersonalizacionNivelId int,
@Valor varchar(200)
as
begin

update ShowRoom.PersonalizacionNivel
	set Valor = @Valor
where PersonalizacionNivelId = @PersonalizacionNivelId

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomCategorias]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomCategorias
GO

create procedure ShowRoom.GetShowRoomCategorias
@EventoId int
as
/*
ShowRoom.GetShowRoomCategorias 6
*/
begin

select
	CategoriaId,
	EventoID,
	Codigo,
	Descripcion
from ShowRoom.Categoria
where EventoID = @EventoId

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomCategoriaById]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomCategoriaById
GO

create procedure ShowRoom.GetShowRoomCategoriaById
@CategoriaId int
as
/*
ShowRoom.GetShowRoomCategoriaById 1
*/
begin

select
	CategoriaId,
	EventoID,
	Codigo,
	Descripcion
from ShowRoom.Categoria
where CategoriaId = @CategoriaId

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[UpdateShowRoomDescripcionCategoria]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].UpdateShowRoomDescripcionCategoria
GO

create procedure ShowRoom.UpdateShowRoomDescripcionCategoria
@CategoriaId int,
@Descripcion varchar(200)
as
begin

update ShowRoom.Categoria
set
	Descripcion = @Descripcion
where 
	CategoriaId = @CategoriaId

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[DeleteShowRoomCategoriaByEvento]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].DeleteShowRoomCategoriaByEvento
GO

create procedure ShowRoom.DeleteShowRoomCategoriaByEvento
@EventoId int
as
begin

delete from ShowRoom.PersonalizacionNivel where EventoID = @EventoId and NivelId = 0
delete from ShowRoom.Categoria where EventoId = @EventoID

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[InsertShowRoomCategoria]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].InsertShowRoomCategoria
GO

create procedure ShowRoom.InsertShowRoomCategoria
@EventoID int,
@Codigo varchar(50),
@Descripcion varchar(200)
as
begin

insert into ShowRoom.Categoria (EventoID, Codigo, Descripcion) values (@EventoID, @Codigo, @Descripcion)

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomCompraPorCompra]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomCompraPorCompra
GO

create procedure ShowRoom.GetShowRoomCompraPorCompra
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

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[UpdStockOfertaShowRoomMasivo]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].UpdStockOfertaShowRoomMasivo
GO

IF (SELECT COUNT(*) FROM sys.table_types WHERE name = 'StockPrecioOfertaShowRoomType') = 1
	drop type ShowRoom.StockPrecioOfertaShowRoomType

go

go

IF (SELECT COUNT(*) FROM sys.table_types WHERE name = 'StockPrecioOfertaShowRoomType') = 0  
  CREATE TYPE ShowRoom.StockPrecioOfertaShowRoomType AS TABLE ( 
	TipoOfertaSisID int, CampaniaID int, CUV varchar(20), Stock int, PrecioOferta decimal(18,2), UnidadesPermitidas int,
	Descripcion varchar(250), CodigoCategoria varchar(100), TipNegocio varchar(500)
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
	TipNegocio = t.TipNegocio
FROM ShowRoom.OfertaShowRoom o
INNER JOIN ods.Campania c on 
	c.CampaniaID = o.CampaniaID
JOIN @StockPrecioOfertaShowRoom t ON 
	c.Codigo = t.CampaniaID
	AND o.CUV = t.CUV
	AND o.TipoOfertaSisID = t.TipoOfertaSisID

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[InsertCargaMasivaOfertaDetalle]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].InsertCargaMasivaOfertaDetalle
GO

IF (SELECT COUNT(*) FROM sys.table_types WHERE name = 'OfertaShowRoomDetalleType') = 1
	drop type ShowRoom.OfertaShowRoomDetalleType

go

go

IF (SELECT COUNT(*) FROM sys.table_types WHERE name = 'OfertaShowRoomDetalleType') = 0 
CREATE TYPE ShowRoom.OfertaShowRoomDetalleType AS TABLE(
	CUV varchar(20) NULL,
	NombreProducto varchar(150) NULL,
	Descripcion1 varchar(150) NULL,
	Descripcion2 varchar(150) NULL,
	Descripcion3 varchar(150) NULL,
	Posicion int NULL,
	MarcaProducto varchar(100) NULL
)

go

create procedure ShowRoom.InsertCargaMasivaOfertaDetalle
@OfertaShowRoomDetalle ShowRoom.OfertaShowRoomDetalleType readonly,
@CampaniaID int,
@UsuarioCreacion varchar(50)
as
begin

begin tran

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

delete from ShowRoom.OfertaShowRoomDetalle
	where OfertaShowRoomDetalleID not in (select o.OfertaShowRoomDetalleID from ShowRoom.OfertaShowRoomDetalle o
	inner join @OfertaShowRoomDetalle t on
	o.CUV = t.CUV
	and o.Posicion = t.Posicion)

update ShowRoom.OfertaShowRoomDetalle
set NombreProducto = t.NombreProducto,
	Descripcion1 = t.Descripcion1,
	Descripcion2 = t.Descripcion2,
	Descripcion3 = t.Descripcion3,
	UsuarioModificacion = @UsuarioCreacion,
	MarcaProducto = t.MarcaProducto
from ShowRoom.OfertaShowRoomDetalle o
inner join @OfertaShowRoomDetalle t on	
	o.CUV = t.CUV
	and o.Posicion = t.Posicion
	--and o.NombreProducto = t.NombreProducto
where
	o.CampaniaID = @CampaniaID	

insert into ShowRoom.OfertaShowRoomDetalle
(CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,FechaCreacion,UsuarioCreacion,
FechaModificacion,UsuarioModificacion,Posicion,MarcaProducto)
select @CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,getdate(),@UsuarioCreacion,
getdate(),@UsuarioCreacion,Posicion,MarcaProducto
from @OfertaShowRoomDetalle
where 
	NombreProducto not in (select NombreProducto from ShowRoom.OfertaShowRoomDetalle o where o.CampaniaID = @CampaniaID
		and o.CUV = CUV)

end

commit tran

IF (@@ERROR <> 0) BEGIN
PRINT 'Error Inesperado!'
    ROLLBACK TRAN
END

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[InsertCargarProductoCpc]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].InsertCargarProductoCpc
GO

IF (SELECT COUNT(*) FROM sys.table_types WHERE name = 'OfertaShowRoomCompraPorCompraType') = 1
	drop type ShowRoom.OfertaShowRoomCompraPorCompraType

go

go

IF (SELECT COUNT(*) FROM sys.table_types WHERE name = 'OfertaShowRoomCompraPorCompraType') = 0  
  CREATE TYPE ShowRoom.OfertaShowRoomCompraPorCompraType AS TABLE ( 
	CUV varchar(20), SAP varchar(12), Orden int, PrecioValorizado decimal(18,2)
  )
GO

create procedure ShowRoom.InsertCargarProductoCpc
@OfertaShowRoomCompraPorCompra ShowRoom.OfertaShowRoomCompraPorCompraType readonly,
@EventoID int,
@UsuarioCreacion varchar(50)
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

declare @tablaCuv table ( CUV varchar(6))
insert into @tablaCuv
select distinct CUV from ShowRoom.CompraPorCompra where EventoID = @EventoID

update ShowRoom.CompraPorCompra
set 
	Orden = o.Orden,
	PrecioValorizado = o.PrecioValorizado,
	UsuarioModificacion = @UsuarioCreacion,
	FechaModificacion = @FechaGeneral
from ShowRoom.CompraPorCompra cpc
inner join @OfertaShowRoomCompraPorCompra o on
	cpc.CUV = o.CUV
	and cpc.SAP = o.SAP
where cpc.EventoID = @EventoID

insert into ShowRoom.CompraPorCompra (EventoID, CUV, SAP, Orden, PrecioValorizado, 
FechaCreacion, FechaModificacion, UsuarioCreacion, UsuarioModificacion)
select 
	@EventoID, CUV, SAP, Orden, PrecioValorizado, 
	@FechaGeneral, @FechaGeneral, @UsuarioCreacion, @UsuarioCreacion
from @OfertaShowRoomCompraPorCompra
where CUV not in (
	select CUV from @tablaCuv
)

end

go

ALTER procedure ShowRoom.InsertShowRoomEvento
@EventoID int output,
@CampaniaID int,
@Nombre varchar(150),
@Tema varchar(150),
@DiasAntes int,
@DiasDespues int,
@NumeroPerfiles int,
@UsuarioCreacion varchar(20),
@TieneCategoria bit,
@TieneCompraXcompra bit
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

insert into ShowRoom.Evento
(CampaniaID, Nombre, Tema, DiasAntes, DiasDespues, NumeroPerfiles, 
FechaCreacion, UsuarioCreacion, FechaModificacion, UsuarioModificacion, Estado, TieneCategoria, TieneCompraXcompra)
values
(@CampaniaID, @Nombre, @Tema, @DiasAntes, @DiasDespues, @NumeroPerfiles,
@FechaGeneral, @UsuarioCreacion, @FechaGeneral, @UsuarioCreacion, 1, @TieneCategoria, @TieneCompraXcompra)

set @EventoID = @@IDENTITY

end

GO

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
@TieneCompraXcompra bit
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
	TieneCompraXcompra = @TieneCompraXcompra
where EventoID = @EventoID

end

go

alter procedure ShowRoom.GetShowRoomEventoByCampaniaID
@CampaniaID int
as
/*
ShowRoom.GetShowRoomEventoByCampaniaID 201705
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
	isnull(TieneCompraXcompra,0) as TieneCompraXcompra
from ShowRoom.Evento
where CampaniaID = @CampaniaID

end

go

ALTER procedure ShowRoom.InsertShowRoomCargarMasivaConsultora
@EventoConsultora ShowRoom.EventoConsultoraType readonly
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

INSERT INTO ShowRoom.EventoConsultora(EventoID, CampaniaID, CodigoConsultora, Segmento, MostrarPopup,
MostrarPopupVenta, FechaCreacion, UsuarioCreacion, FechaModificacion, UsuarioModificacion)
SELECT DISTINCT EventoID, CampaniaID, CodigoConsultora, Segmento, 1,
1, @FechaGeneral, UsuarioCreacion, @FechaGeneral, UsuarioCreacion
FROM @EventoConsultora

end

go

ALTER procedure ShowRoom.GetShowRoomConsultora
@CampaniaID int,
@CodigoConsultora varchar(20)
as
/*
ShowRoom.GetShowRoomConsultora 201704,'0193037'
*/
begin

select top 1
EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,MostrarPopup,
MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion
from ShowRoom.EventoConsultora
where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
order by FechaCreacion desc

end

go

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

go

ALTER procedure ShowRoom.GetProductosShowRoomDetalle
@CampaniaID int,
@CUV varchar(5)
as
/*
ShowRoom.GetProductosShowRoomDetalle 201705,'96248'
ShowRoom.GetProductosShowRoomDetalle 201705,'99008'
*/
begin

select top 3
	OfertaShowRoomDetalleID,
	CampaniaID,
	CUV,
	isnull(NombreProducto,'') as NombreProducto,
	isnull(Descripcion1,'') as Descripcion1,
	isnull(Descripcion2,'') as Descripcion2,
	isnull(Descripcion3,'') as Descripcion3,
	isnull(Imagen,'') as Imagen,
	FechaCreacion,
	UsuarioCreacion,
	FechaModificacion,
	UsuarioModificacion,
	Posicion,
	MarcaProducto
from ShowRoom.OfertaShowRoomDetalle
where 
	CampaniaID = @CampaniaID
	and CUV = @CUV

end

go

ALTER procedure ShowRoom.InsOfertaShowRoomDetalle
@CampaniaID int,
@CUV varchar(5),
@NombreProducto varchar(100),
@Descripcion1 varchar(150),
@Descripcion2 varchar(150),
@Descripcion3 varchar(150),
@Imagen varchar(150),
@UsuarioCreacion varchar(50),
@MarcaProducto varchar(100)
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

declare @Posicion int = 0
select @Posicion = max(Posicion) from ShowRoom.OfertaShowRoomDetalle
where 
	CampaniaID = @CampaniaID
	and CUV = @CUV

insert into ShowRoom.OfertaShowRoomDetalle
(CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,
Imagen,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,Posicion,MarcaProducto)
values
(@CampaniaID,@CUV,@NombreProducto,@Descripcion1,@Descripcion2,@Descripcion3,
@Imagen,@FechaGeneral,@UsuarioCreacion,@FechaGeneral,@UsuarioCreacion,@Posicion+1,@MarcaProducto)

end

go

ALTER procedure ShowRoom.UpdOfertaShowRoomDetalle
@OfertaShowRoomDetalleID int,
@CampaniaID int,
@CUV varchar(5),
@NombreProducto varchar(100),
@Descripcion1 varchar(150),
@Descripcion2 varchar(150),
@Descripcion3 varchar(150),
@Imagen varchar(150),
@UsuarioModificacion varchar(50),
@MarcaProducto varchar(100)
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

update ShowRoom.OfertaShowRoomDetalle
set
	NombreProducto = @NombreProducto,
	Descripcion1 = @Descripcion1,
	Descripcion2 = @Descripcion2,
	Descripcion3 = @Descripcion3,
	Imagen = @Imagen,
	UsuarioModificacion = @UsuarioModificacion,
	FechaModificacion = @FechaGeneral,
	MarcaProducto = @MarcaProducto
where
	OfertaShowRoomDetalleID = @OfertaShowRoomDetalleID
	and CampaniaID = @CampaniaID
	and CUV = @CUV

end

go


ALTER PROCEDURE dbo.InsPedidoWebDetalleOferta_SB2
	@CampaniaID int,
	@ConsultoraID int,
	@MarcaID tinyint,
	@Cantidad int,
	@PrecioUnidad money,
	@CUV varchar(20),
	@ConfiguracionOfertaID INT,
	@TipoOfertaSisID INT,
	@PaisID int,
	@IPUsuario varchar(25) = null,
	@CodigoUsuarioCreacion varchar(25) = null,
	@OrigenPedidoWeb int = 0,
	@EsCompraPorCompra bit = 0
AS
BEGIN
DECLARE @PedidoDetalleID INT;
DECLARE @PedidoID  INT = 0;
DECLARE @OfertaWeb INT  = 1;
DECLARE @ExisteDet INT = 0;
DECLARE @Orden INT=0;

	EXEC [dbo].[InsPedidoWebOferta] @CampaniaID, @ConsultoraID , @PaisID, @IPUsuario, @CodigoUsuarioCreacion;

	if @TipoOfertaSisID = 1707
	begin
		set @OfertaWeb = 0
	end

	if @EsCompraPorCompra = 1
	begin
		set @OfertaWeb = 0
	end

	SELECT @PedidoID = PedidoID FROM dbo.PedidoWeb WHERE CampaniaID = @CampaniaID AND ConsultoraID = @ConsultoraID;

	SELECT @PedidoDetalleID = MAX(ISNULL(PedidoDetalleID,0))
		   , @Orden = max(ISNULL(OrdenPedidoWD,0))
		   FROM dbo.PedidoWebDetalle 
		   WHERE CampaniaID = @CampaniaID AND PedidoID = @PedidoID
	
	SET @PedidoDetalleID = ISNULL(@PedidoDetalleID, 0) + 1
	SET @Orden = ISNULL(@Orden, 0) + 1

	--SET @PedidoDetalleID =	(SELECT ISNULL(MAX(PedidoDetalleID),0) + 1 
	--							FROM	dbo.PedidoWebDetalle 
	--							WHERE	CampaniaID = @CampaniaID AND
	--									PedidoID = @PedidoID);

	/* Validar Al Agregar Nuevamente */
	set @ExisteDet = (select count(*) from PedidoWebDetalle 
						where CampaniaID = @CampaniaID 
							  AND PedidoID = @PedidoID
							  AND CUV = @CUV
							  AND ClienteID IS NULL);

	IF @ExisteDet = 0 
		BEGIN
			INSERT INTO dbo.PedidoWebDetalle 
			(
			 CampaniaID,
			 PedidoID,
			 PedidoDetalleID,
			 MarcaID,
			 ConsultoraID,
			 ClienteID,
			 Cantidad,
			 PrecioUnidad,
			 ImporteTotal,
			 CUV,
			 OfertaWeb, 
			 ModificaPedidoReservado,
			 ConfiguracionOfertaID,
			 TipoOfertaSisID,
			 CodigoUsuarioCreacion,
			 FechaCreacion,
			 OrdenPedidoWD,
			 OrigenPedidoWeb
			)

		VALUES (@CampaniaID,@PedidoID,@PedidoDetalleID,
				@MarcaID,@ConsultoraID,NULL,
				@Cantidad,@PrecioUnidad,@Cantidad*@PrecioUnidad,@CUV,@OfertaWeb,0, @ConfiguracionOfertaID, @TipoOfertaSisID,
				@CodigoUsuarioCreacion, dbo.fnObtenerFechaHoraPais(), @Orden, @OrigenPedidoWeb)
		END
	ELSE
		BEGIN
			UPDATE dbo.PedidoWebDetalle
				SET Cantidad += @Cantidad,
					ImporteTotal = ((Cantidad + @Cantidad) * @PrecioUnidad),
					CodigoUsuarioModificacion = @CodigoUsuarioCreacion,
					FechaModificacion = dbo.fnObtenerFechaHoraPais(),
					OrdenPedidoWD = @Orden,
					OrigenPedidoWeb = @OrigenPedidoWeb
			WHERE CampaniaID = @CampaniaID 
				  AND PedidoID = @PedidoID
				  AND CUV = @CUV
				  AND ClienteID IS NULL		
		END
END

GO

USE BelcorpVenezuela
go

delete from dbo.TablaLogicaDatos where TablaLogicaID = 99
delete from dbo.TablaLogica where TablaLogicaID = 99

go

if not exists (select 1 from dbo.TablaLogica where TablaLogicaID = 99)
begin
	insert into dbo.TablaLogica(TablaLogicaID,Descripcion) values (99,'OrdenamientoShowRoom')
end

go

if not exists (select 1 from dbo.TablaLogicaDatos where TablaLogicaID = 99 and Codigo='01')
begin
	insert into dbo.TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) 
	values (9901,99,'01','Los más vendidos')
end

go

if not exists (select 1 from dbo.TablaLogicaDatos where TablaLogicaID = 99 and Codigo='02')
begin
	insert into dbo.TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) 
	values (9902,99,'02','Menor a mayor precio')
end

go

if not exists (select 1 from dbo.TablaLogicaDatos where TablaLogicaID = 99 and Codigo='03')
begin
	insert into dbo.TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion) 
	values (9903,99,'03','Mayor a menor precio')
end

go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.Evento') and SYSCOLUMNS.NAME = N'TieneCategoria') = 0
	ALTER TABLE ShowRoom.Evento ADD TieneCategoria bit
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.Evento') and SYSCOLUMNS.NAME = N'TieneCompraXcompra') = 0
	ALTER TABLE ShowRoom.Evento ADD TieneCompraXcompra bit
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'CodigoCategoria') = 0
	ALTER TABLE ShowRoom.OfertaShowRoom ADD CodigoCategoria varchar(100)
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'TipNegocio') = 0
	ALTER TABLE ShowRoom.OfertaShowRoom ADD TipNegocio varchar(500)
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoomDetalle') and SYSCOLUMNS.NAME = N'MarcaProducto') = 0
	ALTER TABLE ShowRoom.OfertaShowRoomDetalle ADD MarcaProducto varchar(100)
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.EventoConsultora') and SYSCOLUMNS.NAME = N'MostrarPopupVenta') = 0
	ALTER TABLE ShowRoom.EventoConsultora ADD MostrarPopupVenta bit
go

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[Nivel]') AND (type = 'U') )
	DROP TABLE ShowRoom.Nivel
GO

create table ShowRoom.Nivel
(
	NivelId int identity(1,1) primary key,
	Codigo varchar(100),
	Descripcion varchar(100)
)

go

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[Personalizacion]') AND (type = 'U') )
	DROP TABLE ShowRoom.Personalizacion
GO

create table ShowRoom.Personalizacion
(
	PersonalizacionId int identity(1,1) primary key,
	TipoAplicacion varchar(20),
	Atributo varchar(100),
	TextoAyuda varchar(200),
	TipoAtributo varchar(20),
	TipoPersonalizacion varchar(20),
	Orden int,
	Estado bit
)

go

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[PersonalizacionNivel]') AND (type = 'U') )
	DROP TABLE ShowRoom.PersonalizacionNivel
GO

create table ShowRoom.PersonalizacionNivel
(
	PersonalizacionNivelId int identity(1,1) primary key,
	EventoID int,
	PersonalizacionId int,
	NivelId int,
	CategoriaId int,
	Valor varchar(200)
)

go

CREATE NONCLUSTERED INDEX IX_ShowRoomPersonalizacionNivel_EventoIdNivelId ON ShowRoom.PersonalizacionNivel (EventoID,NivelId);

go

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[Categoria]') AND (type = 'U') )
	DROP TABLE ShowRoom.Categoria
GO

create table ShowRoom.Categoria
(
	CategoriaId int identity(1,1) primary key,
	EventoID int,
	Codigo varchar(50),
	Descripcion varchar(200)
)

go

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[CompraPorCompra]') AND (type = 'U') )
	DROP TABLE ShowRoom.CompraPorCompra
GO

CREATE TABLE ShowRoom.CompraPorCompra
(
	CompraxCompraID int identity(1,1) primary key,
	EventoID int,
	CUV varchar(20),
	SAP varchar(12),
	Orden int,
	PrecioValorizado decimal(18,2),
	FechaCreacion datetime,
	UsuarioCreacion varchar(50),
	FechaModificacion datetime,
	UsuarioModificacion varchar(50)
)

GO

insert into ShowRoom.Nivel (Codigo,Descripcion) values ('PAIS','País')

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','PopupImagenIntriga','Popup Principal Intriga (615px x 409px)','IMAGEN','EVENTO',1,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','PopupImagenVenta','Popup Principal Venta (615px x 409px)','IMAGEN','EVENTO',2,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','BannerImagenIntriga','Visual Superior Intriga (1920px x 174px)','IMAGEN','EVENTO',3,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','BannerImagenVenta','Visual Superior Venta (1920px x 174px)','IMAGEN','EVENTO',4,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','UrlTerminosCondiciones','Link Terminos y Condiciones','TEXTO','EVENTO',5,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','TextoCondicionCompraCpc','Texto Condición de Compra por Compra','TEXTO','EVENTO',6,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','TextoDescripcionLegalCpc','Texto Descripción Legal Compra por Compra','TEXTO','EVENTO',7,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','IconoLluvia','Icono Lluvia Paginal Principal','IMAGEN','EVENTO',8,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','BannerEnvioCorreo','Imagen Envio Correo','IMAGEN','EVENTO',9,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','TextoEnvioCorreo','Texto mostrar Envio Correo','TEXTO','EVENTO',10,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','ImagenFondoProductPage','Imagen de Fondo del Product Page','IMAGEN','EVENTO',11,1)

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','TituloPrincipal','Título de la Categoria','TEXTO','CATEGORIA',12,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','ImagenPrincipal','Imagen a mostrar en la Categoria','IMAGEN','CATEGORIA',13,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Desktop','ColorFondo','Color de Fondo de la Categoria','TEXTO','CATEGORIA',14,1)

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','PopupImagenIntriga','Banner Marquesina Intriga (768px x 420px)','IMAGEN','EVENTO',1,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','PopupImagenVenta','Banner Marquesina Venta (768px x 420px)','IMAGEN','EVENTO',2,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','BannerImagenIntriga','Banner Superior Intriga (1024px x 60px)','IMAGEN','EVENTO',3,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','BannerImagenPaginaVenta','Banner Superior Pagina Venta (1024px x 60px)','IMAGEN','EVENTO',4,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','BannerImagenVenta','Banner Superior Venta Otras Paginas (1024px x 60px)','IMAGEN','EVENTO',5,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','UrlTerminosCondiciones','Link Terminos y Condiciones','TEXTO','EVENTO',6,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','TextoCondicionCompraCpc','Texto Condición de Compra','TEXTO','EVENTO',7,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','TextoDescripcionLegalCpc','Texto Descripción Legal Compra por Compra','TEXTO','EVENTO',8,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','ImagenFondoProductPage','Imagen de Fondo del Product Page','IMAGEN','EVENTO',9,1)

insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','TituloPrincipal','Título de la Categoria','TEXTO','CATEGORIA',10,1)
insert into ShowRoom.Personalizacion (TipoAplicacion,Atributo,TextoAyuda,TipoAtributo,TipoPersonalizacion,Orden,Estado)
values ('Mobile','ColorFondo','Color de Fondo de la Categoria','TEXTO','CATEGORIA',11,1)

go

update ShowRoom.EventoConsultora set MostrarPopup = 1 where MostrarPopup is null
update ShowRoom.EventoConsultora set MostrarPopupVenta = 1 where MostrarPopupVenta is null

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomNivel]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomNivel
GO

create procedure ShowRoom.GetShowRoomNivel
as
/*
ShowRoom.GetShowRoomNivel
*/
begin

select
	NivelId,
	Codigo,
	Descripcion
from ShowRoom.Nivel

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomPersonalizacion]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomPersonalizacion
GO

create procedure ShowRoom.GetShowRoomPersonalizacion
as
/*
ShowRoom.GetShowRoomPersonalizacion
*/
begin

select
	PersonalizacionId,
	TipoAplicacion,
	Atributo,
	TextoAyuda,
	TipoAtributo,
	TipoPersonalizacion,
	Orden,
	Estado
from ShowRoom.Personalizacion

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomPersonalizacionNivel]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomPersonalizacionNivel
GO

create procedure ShowRoom.GetShowRoomPersonalizacionNivel
@EventoId int,
@NivelId int = 0,
@CategoriaId int = 0
as
/*
ShowRoom.GetShowRoomPersonalizacionNivel 2006,1,0
ShowRoom.GetShowRoomPersonalizacionNivel 2006,0,1
*/
begin

select 
	PersonalizacionNivelId,
	EventoID,
	PersonalizacionId,
	isnull(NivelId,0) as NivelId,
	isnull(CategoriaId,0) as CategoriaId,
	isnull(Valor,'') as Valor
from ShowRoom.PersonalizacionNivel
where
	EventoID = @EventoId
	and (@NivelId = 0 or NivelId = @NivelId)
	and (@CategoriaId = 0 or CategoriaId = @CategoriaId)

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[InsertShowRoomPersonalizacionNivel]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].InsertShowRoomPersonalizacionNivel
GO

create procedure ShowRoom.InsertShowRoomPersonalizacionNivel
@EventoID int,
@PersonalizacionId int,
@NivelId int,
@CategoriaId int = 0,
@Valor varchar(200)
as
begin

insert into ShowRoom.PersonalizacionNivel (EventoID, PersonalizacionId, NivelId, CategoriaId, Valor)
values (@EventoID, @PersonalizacionId, @NivelId, @CategoriaId, @Valor)

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[UpdateShowRoomPersonalizacionNivel]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].UpdateShowRoomPersonalizacionNivel
GO

create procedure ShowRoom.UpdateShowRoomPersonalizacionNivel
@PersonalizacionNivelId int,
@Valor varchar(200)
as
begin

update ShowRoom.PersonalizacionNivel
	set Valor = @Valor
where PersonalizacionNivelId = @PersonalizacionNivelId

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomCategorias]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomCategorias
GO

create procedure ShowRoom.GetShowRoomCategorias
@EventoId int
as
/*
ShowRoom.GetShowRoomCategorias 6
*/
begin

select
	CategoriaId,
	EventoID,
	Codigo,
	Descripcion
from ShowRoom.Categoria
where EventoID = @EventoId

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomCategoriaById]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomCategoriaById
GO

create procedure ShowRoom.GetShowRoomCategoriaById
@CategoriaId int
as
/*
ShowRoom.GetShowRoomCategoriaById 1
*/
begin

select
	CategoriaId,
	EventoID,
	Codigo,
	Descripcion
from ShowRoom.Categoria
where CategoriaId = @CategoriaId

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[UpdateShowRoomDescripcionCategoria]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].UpdateShowRoomDescripcionCategoria
GO

create procedure ShowRoom.UpdateShowRoomDescripcionCategoria
@CategoriaId int,
@Descripcion varchar(200)
as
begin

update ShowRoom.Categoria
set
	Descripcion = @Descripcion
where 
	CategoriaId = @CategoriaId

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[DeleteShowRoomCategoriaByEvento]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].DeleteShowRoomCategoriaByEvento
GO

create procedure ShowRoom.DeleteShowRoomCategoriaByEvento
@EventoId int
as
begin

delete from ShowRoom.PersonalizacionNivel where EventoID = @EventoId and NivelId = 0
delete from ShowRoom.Categoria where EventoId = @EventoID

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[InsertShowRoomCategoria]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].InsertShowRoomCategoria
GO

create procedure ShowRoom.InsertShowRoomCategoria
@EventoID int,
@Codigo varchar(50),
@Descripcion varchar(200)
as
begin

insert into ShowRoom.Categoria (EventoID, Codigo, Descripcion) values (@EventoID, @Codigo, @Descripcion)

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomCompraPorCompra]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomCompraPorCompra
GO

create procedure ShowRoom.GetShowRoomCompraPorCompra
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

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[UpdStockOfertaShowRoomMasivo]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].UpdStockOfertaShowRoomMasivo
GO

IF (SELECT COUNT(*) FROM sys.table_types WHERE name = 'StockPrecioOfertaShowRoomType') = 1
	drop type ShowRoom.StockPrecioOfertaShowRoomType

go

go

IF (SELECT COUNT(*) FROM sys.table_types WHERE name = 'StockPrecioOfertaShowRoomType') = 0  
  CREATE TYPE ShowRoom.StockPrecioOfertaShowRoomType AS TABLE ( 
	TipoOfertaSisID int, CampaniaID int, CUV varchar(20), Stock int, PrecioOferta decimal(18,2), UnidadesPermitidas int,
	Descripcion varchar(250), CodigoCategoria varchar(100), TipNegocio varchar(500)
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
	TipNegocio = t.TipNegocio
FROM ShowRoom.OfertaShowRoom o
INNER JOIN ods.Campania c on 
	c.CampaniaID = o.CampaniaID
JOIN @StockPrecioOfertaShowRoom t ON 
	c.Codigo = t.CampaniaID
	AND o.CUV = t.CUV
	AND o.TipoOfertaSisID = t.TipoOfertaSisID

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[InsertCargaMasivaOfertaDetalle]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].InsertCargaMasivaOfertaDetalle
GO

IF (SELECT COUNT(*) FROM sys.table_types WHERE name = 'OfertaShowRoomDetalleType') = 1
	drop type ShowRoom.OfertaShowRoomDetalleType

go

go

IF (SELECT COUNT(*) FROM sys.table_types WHERE name = 'OfertaShowRoomDetalleType') = 0 
CREATE TYPE ShowRoom.OfertaShowRoomDetalleType AS TABLE(
	CUV varchar(20) NULL,
	NombreProducto varchar(150) NULL,
	Descripcion1 varchar(150) NULL,
	Descripcion2 varchar(150) NULL,
	Descripcion3 varchar(150) NULL,
	Posicion int NULL,
	MarcaProducto varchar(100) NULL
)

go

create procedure ShowRoom.InsertCargaMasivaOfertaDetalle
@OfertaShowRoomDetalle ShowRoom.OfertaShowRoomDetalleType readonly,
@CampaniaID int,
@UsuarioCreacion varchar(50)
as
begin

begin tran

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

delete from ShowRoom.OfertaShowRoomDetalle
	where OfertaShowRoomDetalleID not in (select o.OfertaShowRoomDetalleID from ShowRoom.OfertaShowRoomDetalle o
	inner join @OfertaShowRoomDetalle t on
	o.CUV = t.CUV
	and o.Posicion = t.Posicion)

update ShowRoom.OfertaShowRoomDetalle
set NombreProducto = t.NombreProducto,
	Descripcion1 = t.Descripcion1,
	Descripcion2 = t.Descripcion2,
	Descripcion3 = t.Descripcion3,
	UsuarioModificacion = @UsuarioCreacion,
	MarcaProducto = t.MarcaProducto
from ShowRoom.OfertaShowRoomDetalle o
inner join @OfertaShowRoomDetalle t on	
	o.CUV = t.CUV
	and o.Posicion = t.Posicion
	--and o.NombreProducto = t.NombreProducto
where
	o.CampaniaID = @CampaniaID	

insert into ShowRoom.OfertaShowRoomDetalle
(CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,FechaCreacion,UsuarioCreacion,
FechaModificacion,UsuarioModificacion,Posicion,MarcaProducto)
select @CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,getdate(),@UsuarioCreacion,
getdate(),@UsuarioCreacion,Posicion,MarcaProducto
from @OfertaShowRoomDetalle
where 
	NombreProducto not in (select NombreProducto from ShowRoom.OfertaShowRoomDetalle o where o.CampaniaID = @CampaniaID
		and o.CUV = CUV)

end

commit tran

IF (@@ERROR <> 0) BEGIN
PRINT 'Error Inesperado!'
    ROLLBACK TRAN
END

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[InsertCargarProductoCpc]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].InsertCargarProductoCpc
GO

IF (SELECT COUNT(*) FROM sys.table_types WHERE name = 'OfertaShowRoomCompraPorCompraType') = 1
	drop type ShowRoom.OfertaShowRoomCompraPorCompraType

go

go

IF (SELECT COUNT(*) FROM sys.table_types WHERE name = 'OfertaShowRoomCompraPorCompraType') = 0  
  CREATE TYPE ShowRoom.OfertaShowRoomCompraPorCompraType AS TABLE ( 
	CUV varchar(20), SAP varchar(12), Orden int, PrecioValorizado decimal(18,2)
  )
GO

create procedure ShowRoom.InsertCargarProductoCpc
@OfertaShowRoomCompraPorCompra ShowRoom.OfertaShowRoomCompraPorCompraType readonly,
@EventoID int,
@UsuarioCreacion varchar(50)
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

declare @tablaCuv table ( CUV varchar(6))
insert into @tablaCuv
select distinct CUV from ShowRoom.CompraPorCompra where EventoID = @EventoID

update ShowRoom.CompraPorCompra
set 
	Orden = o.Orden,
	PrecioValorizado = o.PrecioValorizado,
	UsuarioModificacion = @UsuarioCreacion,
	FechaModificacion = @FechaGeneral
from ShowRoom.CompraPorCompra cpc
inner join @OfertaShowRoomCompraPorCompra o on
	cpc.CUV = o.CUV
	and cpc.SAP = o.SAP
where cpc.EventoID = @EventoID

insert into ShowRoom.CompraPorCompra (EventoID, CUV, SAP, Orden, PrecioValorizado, 
FechaCreacion, FechaModificacion, UsuarioCreacion, UsuarioModificacion)
select 
	@EventoID, CUV, SAP, Orden, PrecioValorizado, 
	@FechaGeneral, @FechaGeneral, @UsuarioCreacion, @UsuarioCreacion
from @OfertaShowRoomCompraPorCompra
where CUV not in (
	select CUV from @tablaCuv
)

end

go

ALTER procedure ShowRoom.InsertShowRoomEvento
@EventoID int output,
@CampaniaID int,
@Nombre varchar(150),
@Tema varchar(150),
@DiasAntes int,
@DiasDespues int,
@NumeroPerfiles int,
@UsuarioCreacion varchar(20),
@TieneCategoria bit,
@TieneCompraXcompra bit
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

insert into ShowRoom.Evento
(CampaniaID, Nombre, Tema, DiasAntes, DiasDespues, NumeroPerfiles, 
FechaCreacion, UsuarioCreacion, FechaModificacion, UsuarioModificacion, Estado, TieneCategoria, TieneCompraXcompra)
values
(@CampaniaID, @Nombre, @Tema, @DiasAntes, @DiasDespues, @NumeroPerfiles,
@FechaGeneral, @UsuarioCreacion, @FechaGeneral, @UsuarioCreacion, 1, @TieneCategoria, @TieneCompraXcompra)

set @EventoID = @@IDENTITY

end

GO

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
@TieneCompraXcompra bit
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
	TieneCompraXcompra = @TieneCompraXcompra
where EventoID = @EventoID

end

go

alter procedure ShowRoom.GetShowRoomEventoByCampaniaID
@CampaniaID int
as
/*
ShowRoom.GetShowRoomEventoByCampaniaID 201705
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
	isnull(TieneCompraXcompra,0) as TieneCompraXcompra
from ShowRoom.Evento
where CampaniaID = @CampaniaID

end

go

ALTER procedure ShowRoom.InsertShowRoomCargarMasivaConsultora
@EventoConsultora ShowRoom.EventoConsultoraType readonly
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

INSERT INTO ShowRoom.EventoConsultora(EventoID, CampaniaID, CodigoConsultora, Segmento, MostrarPopup,
MostrarPopupVenta, FechaCreacion, UsuarioCreacion, FechaModificacion, UsuarioModificacion)
SELECT DISTINCT EventoID, CampaniaID, CodigoConsultora, Segmento, 1,
1, @FechaGeneral, UsuarioCreacion, @FechaGeneral, UsuarioCreacion
FROM @EventoConsultora

end

go

ALTER procedure ShowRoom.GetShowRoomConsultora
@CampaniaID int,
@CodigoConsultora varchar(20)
as
/*
ShowRoom.GetShowRoomConsultora 201704,'0193037'
*/
begin

select top 1
EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,MostrarPopup,
MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion
from ShowRoom.EventoConsultora
where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
order by FechaCreacion desc

end

go

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

go

ALTER procedure ShowRoom.GetProductosShowRoomDetalle
@CampaniaID int,
@CUV varchar(5)
as
/*
ShowRoom.GetProductosShowRoomDetalle 201705,'96248'
ShowRoom.GetProductosShowRoomDetalle 201705,'99008'
*/
begin

select top 3
	OfertaShowRoomDetalleID,
	CampaniaID,
	CUV,
	isnull(NombreProducto,'') as NombreProducto,
	isnull(Descripcion1,'') as Descripcion1,
	isnull(Descripcion2,'') as Descripcion2,
	isnull(Descripcion3,'') as Descripcion3,
	isnull(Imagen,'') as Imagen,
	FechaCreacion,
	UsuarioCreacion,
	FechaModificacion,
	UsuarioModificacion,
	Posicion,
	MarcaProducto
from ShowRoom.OfertaShowRoomDetalle
where 
	CampaniaID = @CampaniaID
	and CUV = @CUV

end

go

ALTER procedure ShowRoom.InsOfertaShowRoomDetalle
@CampaniaID int,
@CUV varchar(5),
@NombreProducto varchar(100),
@Descripcion1 varchar(150),
@Descripcion2 varchar(150),
@Descripcion3 varchar(150),
@Imagen varchar(150),
@UsuarioCreacion varchar(50),
@MarcaProducto varchar(100)
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

declare @Posicion int = 0
select @Posicion = max(Posicion) from ShowRoom.OfertaShowRoomDetalle
where 
	CampaniaID = @CampaniaID
	and CUV = @CUV

insert into ShowRoom.OfertaShowRoomDetalle
(CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,
Imagen,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,Posicion,MarcaProducto)
values
(@CampaniaID,@CUV,@NombreProducto,@Descripcion1,@Descripcion2,@Descripcion3,
@Imagen,@FechaGeneral,@UsuarioCreacion,@FechaGeneral,@UsuarioCreacion,@Posicion+1,@MarcaProducto)

end

go

ALTER procedure ShowRoom.UpdOfertaShowRoomDetalle
@OfertaShowRoomDetalleID int,
@CampaniaID int,
@CUV varchar(5),
@NombreProducto varchar(100),
@Descripcion1 varchar(150),
@Descripcion2 varchar(150),
@Descripcion3 varchar(150),
@Imagen varchar(150),
@UsuarioModificacion varchar(50),
@MarcaProducto varchar(100)
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

update ShowRoom.OfertaShowRoomDetalle
set
	NombreProducto = @NombreProducto,
	Descripcion1 = @Descripcion1,
	Descripcion2 = @Descripcion2,
	Descripcion3 = @Descripcion3,
	Imagen = @Imagen,
	UsuarioModificacion = @UsuarioModificacion,
	FechaModificacion = @FechaGeneral,
	MarcaProducto = @MarcaProducto
where
	OfertaShowRoomDetalleID = @OfertaShowRoomDetalleID
	and CampaniaID = @CampaniaID
	and CUV = @CUV

end

go


ALTER PROCEDURE dbo.InsPedidoWebDetalleOferta_SB2
	@CampaniaID int,
	@ConsultoraID int,
	@MarcaID tinyint,
	@Cantidad int,
	@PrecioUnidad money,
	@CUV varchar(20),
	@ConfiguracionOfertaID INT,
	@TipoOfertaSisID INT,
	@PaisID int,
	@IPUsuario varchar(25) = null,
	@CodigoUsuarioCreacion varchar(25) = null,
	@OrigenPedidoWeb int = 0,
	@EsCompraPorCompra bit = 0
AS
BEGIN
DECLARE @PedidoDetalleID INT;
DECLARE @PedidoID  INT = 0;
DECLARE @OfertaWeb INT  = 1;
DECLARE @ExisteDet INT = 0;
DECLARE @Orden INT=0;

	EXEC [dbo].[InsPedidoWebOferta] @CampaniaID, @ConsultoraID , @PaisID, @IPUsuario, @CodigoUsuarioCreacion;

	if @TipoOfertaSisID = 1707
	begin
		set @OfertaWeb = 0
	end

	if @EsCompraPorCompra = 1
	begin
		set @OfertaWeb = 0
	end

	SELECT @PedidoID = PedidoID FROM dbo.PedidoWeb WHERE CampaniaID = @CampaniaID AND ConsultoraID = @ConsultoraID;

	SELECT @PedidoDetalleID = MAX(ISNULL(PedidoDetalleID,0))
		   , @Orden = max(ISNULL(OrdenPedidoWD,0))
		   FROM dbo.PedidoWebDetalle 
		   WHERE CampaniaID = @CampaniaID AND PedidoID = @PedidoID
	
	SET @PedidoDetalleID = ISNULL(@PedidoDetalleID, 0) + 1
	SET @Orden = ISNULL(@Orden, 0) + 1

	--SET @PedidoDetalleID =	(SELECT ISNULL(MAX(PedidoDetalleID),0) + 1 
	--							FROM	dbo.PedidoWebDetalle 
	--							WHERE	CampaniaID = @CampaniaID AND
	--									PedidoID = @PedidoID);

	/* Validar Al Agregar Nuevamente */
	set @ExisteDet = (select count(*) from PedidoWebDetalle 
						where CampaniaID = @CampaniaID 
							  AND PedidoID = @PedidoID
							  AND CUV = @CUV
							  AND ClienteID IS NULL);

	IF @ExisteDet = 0 
		BEGIN
			INSERT INTO dbo.PedidoWebDetalle 
			(
			 CampaniaID,
			 PedidoID,
			 PedidoDetalleID,
			 MarcaID,
			 ConsultoraID,
			 ClienteID,
			 Cantidad,
			 PrecioUnidad,
			 ImporteTotal,
			 CUV,
			 OfertaWeb, 
			 ModificaPedidoReservado,
			 ConfiguracionOfertaID,
			 TipoOfertaSisID,
			 CodigoUsuarioCreacion,
			 FechaCreacion,
			 OrdenPedidoWD,
			 OrigenPedidoWeb
			)

		VALUES (@CampaniaID,@PedidoID,@PedidoDetalleID,
				@MarcaID,@ConsultoraID,NULL,
				@Cantidad,@PrecioUnidad,@Cantidad*@PrecioUnidad,@CUV,@OfertaWeb,0, @ConfiguracionOfertaID, @TipoOfertaSisID,
				@CodigoUsuarioCreacion, dbo.fnObtenerFechaHoraPais(), @Orden, @OrigenPedidoWeb)
		END
	ELSE
		BEGIN
			UPDATE dbo.PedidoWebDetalle
				SET Cantidad += @Cantidad,
					ImporteTotal = ((Cantidad + @Cantidad) * @PrecioUnidad),
					CodigoUsuarioModificacion = @CodigoUsuarioCreacion,
					FechaModificacion = dbo.fnObtenerFechaHoraPais(),
					OrdenPedidoWD = @Orden,
					OrigenPedidoWeb = @OrigenPedidoWeb
			WHERE CampaniaID = @CampaniaID 
				  AND PedidoID = @PedidoID
				  AND CUV = @CUV
				  AND ClienteID IS NULL		
		END
END

GO


