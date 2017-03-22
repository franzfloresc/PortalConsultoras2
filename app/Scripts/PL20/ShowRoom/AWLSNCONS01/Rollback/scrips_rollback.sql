USE BelcorpColombiaPL20
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.Evento') and SYSCOLUMNS.NAME = N'TieneCategoria') = 1
	ALTER TABLE ShowRoom.Evento drop column TieneCategoria
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.Evento') and SYSCOLUMNS.NAME = N'TieneCompraXcompra') = 1
	ALTER TABLE ShowRoom.Evento drop column TieneCompraXcompra
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'CodigoCategoria') = 1
	ALTER TABLE ShowRoom.OfertaShowRoom drop column CodigoCategoria
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoom') and SYSCOLUMNS.NAME = N'TipNegocio') = 1
	ALTER TABLE ShowRoom.OfertaShowRoom drop column TipNegocio
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.OfertaShowRoomDetalle') and SYSCOLUMNS.NAME = N'MarcaProducto') = 1
	ALTER TABLE ShowRoom.OfertaShowRoomDetalle drop column MarcaProducto
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('ShowRoom.EventoConsultora') and SYSCOLUMNS.NAME = N'MostrarPopupVenta') = 1
	ALTER TABLE ShowRoom.EventoConsultora drop column MostrarPopupVenta
go

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[Nivel]') AND (type = 'U') )
	DROP TABLE ShowRoom.Nivel
GO

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[Personalizacion]') AND (type = 'U') )
	DROP TABLE ShowRoom.Personalizacion
GO

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[PersonalizacionNivel]') AND (type = 'U') )
	DROP TABLE ShowRoom.PersonalizacionNivel
GO

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[Categoria]') AND (type = 'U') )
	DROP TABLE ShowRoom.Categoria
GO

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[CompraPorCompra]') AND (type = 'U') )
	DROP TABLE ShowRoom.CompraPorCompra
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomNivel]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomNivel
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomPersonalizacion]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomPersonalizacion
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomPersonalizacionNivel]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomPersonalizacionNivel
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[InsertShowRoomPersonalizacionNivel]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].InsertShowRoomPersonalizacionNivel
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[UpdateShowRoomPersonalizacionNivel]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].UpdateShowRoomPersonalizacionNivel
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomCategorias]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomCategorias
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomCategoriaById]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomCategoriaById
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[UpdateShowRoomDescripcionCategoria]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].UpdateShowRoomDescripcionCategoria
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[DeleteShowRoomCategoriaByEvento]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].DeleteShowRoomCategoriaByEvento
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[InsertShowRoomCategoria]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].InsertShowRoomCategoria
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[GetShowRoomCompraPorCompra]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].GetShowRoomCompraPorCompra
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ShowRoom].[UpdStockOfertaShowRoomMasivo]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [ShowRoom].UpdStockOfertaShowRoomMasivo
GO

IF (SELECT COUNT(*) FROM sys.table_types WHERE name = 'StockPrecioOfertaShowRoomType') = 1
	drop type ShowRoom.StockPrecioOfertaShowRoomType

go

IF (SELECT COUNT(*) FROM sys.table_types WHERE name = 'StockPrecioOfertaShowRoomType') = 0  
  CREATE TYPE ShowRoom.StockPrecioOfertaShowRoomType AS TABLE ( 
	TipoOfertaSisID int, CampaniaID int, CUV varchar(20), Stock int, PrecioOferta decimal(18,2), UnidadesPermitidas int
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
	UnidadesPermitidas = t.UnidadesPermitidas
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

IF (SELECT COUNT(*) FROM sys.table_types WHERE name = 'OfertaShowRoomDetalleType') = 0 
CREATE TYPE ShowRoom.OfertaShowRoomDetalleType AS TABLE(
	CUV varchar(20) NULL,
	NombreSet varchar(250) NULL,
	NombreProducto varchar(150) NULL,
	Descripcion1 varchar(150) NULL,
	Descripcion2 varchar(150) NULL,
	Descripcion3 varchar(150) NULL,
	Posicion int NULL
)

go

create procedure ShowRoom.InsertCargaMasivaOfertaDetalle
@OfertaShowRoomDetalle ShowRoom.OfertaShowRoomDetalleType readonly,
@CampaniaID int,
@UsuarioCreacion varchar(50)
as
begin

begin tran

declare @tablaSets table (CUV varchar(20), NombreSet varchar(250))

insert into @tablaSets
select distinct CUV, NombreSet from @OfertaShowRoomDetalle

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
	UsuarioModificacion = @UsuarioCreacion
from ShowRoom.OfertaShowRoomDetalle o
inner join @OfertaShowRoomDetalle t on	
	o.CUV = t.CUV
	and o.Posicion = t.Posicion
	--and o.NombreProducto = t.NombreProducto
where
	o.CampaniaID = @CampaniaID	

insert into ShowRoom.OfertaShowRoomDetalle
(CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,Posicion)
select @CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,getdate(),@UsuarioCreacion,getdate(),@UsuarioCreacion,Posicion
from @OfertaShowRoomDetalle
where 
	NombreProducto not in (select NombreProducto from ShowRoom.OfertaShowRoomDetalle o where o.CampaniaID = @CampaniaID
		and o.CUV = CUV)

update ShowRoom.OfertaShowRoom
set Descripcion = t.NombreSet
from ShowRoom.OfertaShowRoom o
inner join ods.Campania c on
	c.CampaniaID = o.CampaniaID
inner join @tablaSets t on
	o.CUV = t.CUV
where 
	c.Codigo = @CampaniaID
end

commit tran

IF (@@ERROR <> 0) BEGIN
PRINT 'Error Inesperado!'
    ROLLBACK TRAN
END

go

alter procedure [ShowRoom].[InsertShowRoomEvento]
@EventoID int output,
@CampaniaID int,
@Nombre varchar(150),
@Tema varchar(150),
@DiasAntes int,
@DiasDespues int,
@NumeroPerfiles int,
@RutaShowRoomPopup varchar(500),
@RutaShowRoomBannerLateral varchar(500),
@UsuarioCreacion varchar(20)
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

insert into ShowRoom.Evento
(CampaniaID, Nombre, Tema, DiasAntes, DiasDespues, NumeroPerfiles, RutaShowRoomPopup, RutaShowRoomBannerLateral, 
FechaCreacion, UsuarioCreacion, FechaModificacion, UsuarioModificacion, Estado)
values
(@CampaniaID, @Nombre, @Tema, @DiasAntes, @DiasDespues, @NumeroPerfiles, @RutaShowRoomPopup, @RutaShowRoomBannerLateral, 
@FechaGeneral, @UsuarioCreacion, @FechaGeneral, @UsuarioCreacion, 1)

set @EventoID = @@IDENTITY

end

go

alter procedure [ShowRoom].[UpdateShowRoomEvento]
@EventoID int,
@CampaniaID int,
@Nombre varchar(150),
@Tema varchar(150),
@DiasAntes int,
@DiasDespues int,
@NumeroPerfiles int,
@RutaShowRoomPopup varchar(500),
@RutaShowRoomBannerLateral varchar(500),
@UsuarioModificacion varchar(20),
@Estado int
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
	RutaShowRoomPopup = @RutaShowRoomPopup,
	RutaShowRoomBannerLateral = @RutaShowRoomBannerLateral,
	FechaModificacion = @FechaGeneral,
	UsuarioModificacion = @UsuarioModificacion,
	Estado = @Estado
where EventoID = @EventoID

end

go

alter procedure ShowRoom.GetShowRoomEventoByCampaniaID
@CampaniaID int
as
/*
ShowRoom.GetShowRoomEventoByCampaniaID 201608
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
	ImagenPreventaDigital
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
FechaCreacion, UsuarioCreacion, FechaModificacion, UsuarioModificacion)
SELECT DISTINCT EventoID, CampaniaID, CodigoConsultora, Segmento, 1,
@FechaGeneral, UsuarioCreacion, @FechaGeneral, UsuarioCreacion
FROM @EventoConsultora

end

go

ALTER procedure ShowRoom.GetShowRoomConsultora
@CampaniaID int,
@CodigoConsultora varchar(20)
as
/*
ShowRoom.GetShowRoomConsultora 201607,'0193037'
*/
begin

select top 1
EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,MostrarPopup,
FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion
from ShowRoom.EventoConsultora
where CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora

end

go

ALTER procedure ShowRoom.GetShowRoomOfertasConsultora
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
o.FechaRegistro,o.UsuarioModificacion,o.FechaModificacion,o.ImagenMini,pc.MarcaID, pos.Orden
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

ALTER procedure ShowRoom.GetProductosShowRoomDetalle
@CampaniaID int,
@CUV varchar(5)
as
/*
ShowRoom.GetProductosShowRoomDetalle 201611,'99009'
ShowRoom.GetProductosShowRoomDetalle 201611,'99008'
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
	UsuarioModificacion
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
@UsuarioCreacion varchar(50)
as
begin

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

insert into ShowRoom.OfertaShowRoomDetalle
(CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,
Imagen,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion)
values
(@CampaniaID,@CUV,@NombreProducto,@Descripcion1,@Descripcion2,@Descripcion3,
@Imagen,@FechaGeneral,@UsuarioCreacion,@FechaGeneral,@UsuarioCreacion)

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
@UsuarioModificacion varchar(50)
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
	UsuarioModificacion = @UsuarioModificacion
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
	@OrigenPedidoWeb int = 0
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

--USE BelcorpMexico
--go

--USE BelcorpPeru
--go