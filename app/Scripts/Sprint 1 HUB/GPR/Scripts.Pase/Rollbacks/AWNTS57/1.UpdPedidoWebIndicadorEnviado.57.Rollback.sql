
USE BelcorpBolivia
go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdPedidoWebIndicadorEnviado]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[UpdPedidoWebIndicadorEnviado]
GO

CREATE proc [dbo].[UpdPedidoWebIndicadorEnviado]
	@NroLote int,
	@FirmarPedido bit,
	@Estado tinyint,
	@Mensaje nvarchar(255),
	@NombreArchivoCabecera varchar(100) = null,
	@NombreArchivoDetalle varchar (100) = null,
	@NombreServer varchar(100) = null
as
-- Actualiza estado de pedidos para descarga

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais() 

if @FirmarPedido = 1
	update dbo.PedidoWeb
	set IndicadorEnviado = 1,
		FechaProceso = @FechaGeneral
	from dbo.PedidoWeb p
		join dbo.TempPedidoWebID pk
		on p.CampaniaID = pk.CampaniaID
			and p.PedidoID = pk.PedidoID
	where pk.NroLote = @NroLote

update dbo.PedidoDescarga
set Estado = @Estado,
	Mensaje = @Mensaje,
	FechaFin = @FechaGeneral,
	NombreArchivoCabecera = @NombreArchivoCabecera,
	NombreArchivoDetalle = @NombreArchivoDetalle,
	NombreServer = @NombreServer
where NroLote = @NroLote

delete dbo.TempPedidoWebID
where NroLote = @NroLote

delete from TmpCabeceraDD
delete from TmpDetalleDD


GO

USE BelcorpChile
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdPedidoWebIndicadorEnviado]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[UpdPedidoWebIndicadorEnviado]
GO
CREATE proc [dbo].[UpdPedidoWebIndicadorEnviado]
	@NroLote int,
	@FirmarPedido bit,
	@Estado tinyint,
	@Mensaje nvarchar(255),
	@NombreArchivoCabecera varchar(100) = null,
	@NombreArchivoDetalle varchar (100) = null,
	@NombreServer varchar(100) = null
as

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

-- Actualiza estado de pedidos para descarga
if @FirmarPedido = 1
	update dbo.PedidoWeb
	set IndicadorEnviado = 1,
		FechaProceso = @FechaGeneral
	from dbo.PedidoWeb p
		join dbo.TempPedidoWebID pk
		on p.CampaniaID = pk.CampaniaID
			and p.PedidoID = pk.PedidoID
	where pk.NroLote = @NroLote

update dbo.PedidoDescarga
set Estado = @Estado,
	Mensaje = @Mensaje,
	FechaFin = @FechaGeneral,
	NombreArchivoCabecera = @NombreArchivoCabecera,
	NombreArchivoDetalle = @NombreArchivoDetalle,
	NombreServer = @NombreServer
where NroLote = @NroLote

delete dbo.TempPedidoWebID
where NroLote = @NroLote


GO


USE BelcorpCostaRica
go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdPedidoWebIndicadorEnviado]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[UpdPedidoWebIndicadorEnviado]
GO
CREATE proc [dbo].[UpdPedidoWebIndicadorEnviado]
	@NroLote int,
	@FirmarPedido bit,
	@Estado tinyint,
	@Mensaje nvarchar(255),
	@NombreArchivoCabecera varchar(100) = null,
	@NombreArchivoDetalle varchar (100) = null,
	@NombreServer varchar(100) = null
as

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

-- Actualiza estado de pedidos para descarga
if @FirmarPedido = 1
	update dbo.PedidoWeb
	set IndicadorEnviado = 1,
		FechaProceso = @FechaGeneral
	from dbo.PedidoWeb p
		join dbo.TempPedidoWebID pk
		on p.CampaniaID = pk.CampaniaID
			and p.PedidoID = pk.PedidoID
	where pk.NroLote = @NroLote

update dbo.PedidoDescarga
set Estado = @Estado,
	Mensaje = @Mensaje,
	FechaFin = @FechaGeneral,
	NombreArchivoCabecera = @NombreArchivoCabecera,
	NombreArchivoDetalle = @NombreArchivoDetalle,
	NombreServer = @NombreServer
where NroLote = @NroLote

delete dbo.TempPedidoWebID
where NroLote = @NroLote



GO


USE BelcorpDominicana
go


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdPedidoWebIndicadorEnviado]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[UpdPedidoWebIndicadorEnviado]
GO

CREATE proc [dbo].[UpdPedidoWebIndicadorEnviado]
	@NroLote int,
	@FirmarPedido bit,
	@Estado tinyint,
	@Mensaje nvarchar(255),
	@NombreArchivoCabecera varchar(100) = null,
	@NombreArchivoDetalle varchar (100) = null,
	@NombreServer varchar(100) = null
as
-- Actualiza estado de pedidos para descarga

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

if @FirmarPedido = 1
	update dbo.PedidoWeb
	set IndicadorEnviado = 1,
		FechaProceso = @FechaGeneral
	from dbo.PedidoWeb p
		join dbo.TempPedidoWebID pk
		on p.CampaniaID = pk.CampaniaID
			and p.PedidoID = pk.PedidoID
	where pk.NroLote = @NroLote

update dbo.PedidoDescarga
set Estado = @Estado,
	Mensaje = @Mensaje,
	FechaFin = @FechaGeneral,
	NombreArchivoCabecera = @NombreArchivoCabecera,
	NombreArchivoDetalle = @NombreArchivoDetalle,
	NombreServer = @NombreServer
where NroLote = @NroLote

delete dbo.TempPedidoWebID
where NroLote = @NroLote

delete from TmpCabeceraDD
delete from TmpDetalleDD

GO


GO


USE BelcorpEcuador
go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdPedidoWebIndicadorEnviado]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[UpdPedidoWebIndicadorEnviado]
GO

CREATE proc [dbo].[UpdPedidoWebIndicadorEnviado]
	@NroLote int,
	@FirmarPedido bit,
	@Estado tinyint,
	@Mensaje nvarchar(255),
	@NombreArchivoCabecera varchar(100) = null,
	@NombreArchivoDetalle varchar (100) = null,
	@NombreServer varchar(100) = null
as

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

-- Actualiza estado de pedidos para descarga
if @FirmarPedido = 1
	update dbo.PedidoWeb
	set IndicadorEnviado = 1,
		FechaProceso = @FechaGeneral
	from dbo.PedidoWeb p
		join dbo.TempPedidoWebID pk
		on p.CampaniaID = pk.CampaniaID
			and p.PedidoID = pk.PedidoID
	where pk.NroLote = @NroLote

update dbo.PedidoDescarga
set Estado = @Estado,
	Mensaje = @Mensaje,
	FechaFin = @FechaGeneral,
	NombreArchivoCabecera = @NombreArchivoCabecera,
	NombreArchivoDetalle = @NombreArchivoDetalle,
	NombreServer = @NombreServer
where NroLote = @NroLote

delete dbo.TempPedidoWebID
where NroLote = @NroLote



GO


USE BelcorpGuatemala
go


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdPedidoWebIndicadorEnviado]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[UpdPedidoWebIndicadorEnviado]
GO

CREATE proc [dbo].[UpdPedidoWebIndicadorEnviado]
	@NroLote int,
	@FirmarPedido bit,
	@Estado tinyint,
	@Mensaje nvarchar(255),
	@NombreArchivoCabecera varchar(100) = null,
	@NombreArchivoDetalle varchar (100) = null,
	@NombreServer varchar(100) = null
as

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

-- Actualiza estado de pedidos para descarga
if @FirmarPedido = 1
	update dbo.PedidoWeb
	set IndicadorEnviado = 1,
		FechaProceso = @FechaGeneral
	from dbo.PedidoWeb p
		join dbo.TempPedidoWebID pk
		on p.CampaniaID = pk.CampaniaID
			and p.PedidoID = pk.PedidoID
	where pk.NroLote = @NroLote

update dbo.PedidoDescarga
set Estado = @Estado,
	Mensaje = @Mensaje,
	FechaFin = @FechaGeneral,
	NombreArchivoCabecera = @NombreArchivoCabecera,
	NombreArchivoDetalle = @NombreArchivoDetalle,
	NombreServer = @NombreServer
where NroLote = @NroLote

delete dbo.TempPedidoWebID
where NroLote = @NroLote



GO


USE BelcorpPanama
go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdPedidoWebIndicadorEnviado]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[UpdPedidoWebIndicadorEnviado]
GO
CREATE proc [dbo].[UpdPedidoWebIndicadorEnviado]
	@NroLote int,
	@FirmarPedido bit,
	@Estado tinyint,
	@Mensaje nvarchar(255),
	@NombreArchivoCabecera varchar(100) = null,
	@NombreArchivoDetalle varchar (100) = null,
	@NombreServer varchar(100) = null
as

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais() 

-- Actualiza estado de pedidos para descarga
if @FirmarPedido = 1
	update dbo.PedidoWeb
	set IndicadorEnviado = 1,
		FechaProceso = @FechaGeneral
	from dbo.PedidoWeb p
		join dbo.TempPedidoWebID pk
		on p.CampaniaID = pk.CampaniaID
			and p.PedidoID = pk.PedidoID
	where pk.NroLote = @NroLote

update dbo.PedidoDescarga
set Estado = @Estado,
	Mensaje = @Mensaje,
	FechaFin = @FechaGeneral,
	NombreArchivoCabecera = @NombreArchivoCabecera,
	NombreArchivoDetalle = @NombreArchivoDetalle,
	NombreServer = @NombreServer
where NroLote = @NroLote

delete dbo.TempPedidoWebID
where NroLote = @NroLote




GO


USE BelcorpPuertoRico
go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdPedidoWebIndicadorEnviado]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[UpdPedidoWebIndicadorEnviado]
GO
CREATE proc [dbo].[UpdPedidoWebIndicadorEnviado]
	@NroLote int,
	@FirmarPedido bit,
	@Estado tinyint,
	@Mensaje nvarchar(255),
	@NombreArchivoCabecera varchar(100) = null,
	@NombreArchivoDetalle varchar (100) = null,
	@NombreServer varchar(100) = null
as
-- Actualiza estado de pedidos para descarga

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

if @FirmarPedido = 1
	update dbo.PedidoWeb
	set IndicadorEnviado = 1,
		FechaProceso = @FechaGeneral
	from dbo.PedidoWeb p
		join dbo.TempPedidoWebID pk
		on p.CampaniaID = pk.CampaniaID
			and p.PedidoID = pk.PedidoID
	where pk.NroLote = @NroLote

update dbo.PedidoDescarga
set Estado = @Estado,
	Mensaje = @Mensaje,
	FechaFin = @FechaGeneral,
	NombreArchivoCabecera = @NombreArchivoCabecera,
	NombreArchivoDetalle = @NombreArchivoDetalle,
	NombreServer = @NombreServer
where NroLote = @NroLote

delete dbo.TempPedidoWebID
where NroLote = @NroLote

delete from TmpCabeceraDD
delete from TmpDetalleDD


GO

USE BelcorpSalvador
go


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdPedidoWebIndicadorEnviado]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[UpdPedidoWebIndicadorEnviado]
GO
CREATE proc [dbo].[UpdPedidoWebIndicadorEnviado]
	@NroLote int,
	@FirmarPedido bit,
	@Estado tinyint,
	@Mensaje nvarchar(255),
	@NombreArchivoCabecera varchar(100) = null,
	@NombreArchivoDetalle varchar (100) = null,
	@NombreServer varchar(100) = null
as

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

-- Actualiza estado de pedidos para descarga
if @FirmarPedido = 1
	update dbo.PedidoWeb
	set IndicadorEnviado = 1,
		FechaProceso = @FechaGeneral
	from dbo.PedidoWeb p
		join dbo.TempPedidoWebID pk
		on p.CampaniaID = pk.CampaniaID
			and p.PedidoID = pk.PedidoID
	where pk.NroLote = @NroLote

update dbo.PedidoDescarga
set Estado = @Estado,
	Mensaje = @Mensaje,
	FechaFin = @FechaGeneral,
	NombreArchivoCabecera = @NombreArchivoCabecera,
	NombreArchivoDetalle = @NombreArchivoDetalle,
	NombreServer = @NombreServer
where NroLote = @NroLote

delete dbo.TempPedidoWebID
where NroLote = @NroLote




GO


USE BelcorpVenezuela
go


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdPedidoWebIndicadorEnviado]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[UpdPedidoWebIndicadorEnviado]
GO
  
  CREATE proc [dbo].[UpdPedidoWebIndicadorEnviado]
	@NroLote int,
	@FirmarPedido bit,
	@Estado tinyint,
	@Mensaje nvarchar(255),
	@NombreArchivoCabecera varchar(100) = null,
	@NombreArchivoDetalle varchar (100) = null,
	@NombreServer varchar(100) = null
as
-- Actualiza estado de pedidos para descarga

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

if @FirmarPedido = 1
	update dbo.PedidoWeb
	set IndicadorEnviado = 1,
		FechaProceso = @FechaGeneral
	from dbo.PedidoWeb p
		join dbo.TempPedidoWebID pk
		on p.CampaniaID = pk.CampaniaID
			and p.PedidoID = pk.PedidoID
	where pk.NroLote = @NroLote

update dbo.PedidoDescarga
set Estado = @Estado,
	Mensaje = @Mensaje,
	FechaFin = @FechaGeneral,
	NombreArchivoCabecera = @NombreArchivoCabecera,
	NombreArchivoDetalle = @NombreArchivoDetalle,
	NombreServer = @NombreServer
where NroLote = @NroLote

delete dbo.TempPedidoWebID
where NroLote = @NroLote



GO

