
USE BelcorpBolivia
go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdPedidoWebIndicadorEnviado]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[UpdPedidoWebIndicadorEnviado]
GO

CREATE PROC [dbo].[UpdPedidoWebIndicadorEnviado]  -- en este SP se coloca el indicadorGPR = 1 
 @NroLote int,  
 @FirmarPedido bit,
 @Estado tinyint,  
 @Mensaje nvarchar(255),  
 @NombreArchivoCabecera varchar(100) = null,  
 @NombreArchivoDetalle varchar (100) = null,  
 @NombreServer varchar(100) = null  
as  
-- Actualiza estado de pedidos para descarga  
-- Actualiza el indicadorGPR  
DECLARE @FechaGeneral DATETIME
DECLARE @IndicadorGPRPais  BIT
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()   
SELECT @IndicadorGPRPais = ISNULL(PedidoRechazado,0) FROM Pais WHERE EstadoActivo = 1

if @FirmarPedido = 1  
 update dbo.PedidoWeb  
 set 
  IndicadorEnviado = 1,  
  GPRSB = CASE @IndicadorGPRPais WHEN 1 THEN 1 ELSE 0 END,
  FechaProceso = @FechaGeneral  
 from dbo.PedidoWeb p  
  join dbo.TempPedidoWebID pk  on p.CampaniaID = pk.CampaniaID and p.PedidoID = pk.PedidoID  
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

CREATE PROC [dbo].[UpdPedidoWebIndicadorEnviado]  -- en este SP se coloca el indicadorGPR = 1 
 @NroLote int,  
 @FirmarPedido bit,  
 @Estado tinyint,  
 @Mensaje nvarchar(255),  
 @NombreArchivoCabecera varchar(100) = null,  
 @NombreArchivoDetalle varchar (100) = null,  
 @NombreServer varchar(100) = null  
as  
-- Actualiza estado de pedidos para descarga  
-- Actualiza el indicadorGPR  
DECLARE @FechaGeneral DATETIME
DECLARE @IndicadorGPRPais  BIT
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()   
SELECT @IndicadorGPRPais = ISNULL(PedidoRechazado,0) FROM Pais WHERE EstadoActivo = 1

if @FirmarPedido = 1  
 update dbo.PedidoWeb  
 set 
  IndicadorEnviado = 1,  
  GPRSB = CASE @IndicadorGPRPais WHEN 1 THEN 1 ELSE 0 END,
  FechaProceso = @FechaGeneral  
 from dbo.PedidoWeb p  
  join dbo.TempPedidoWebID pk  on p.CampaniaID = pk.CampaniaID and p.PedidoID = pk.PedidoID  
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

CREATE PROC [dbo].[UpdPedidoWebIndicadorEnviado]  -- en este SP se coloca el indicadorGPR = 1 
 @NroLote int,  
 @FirmarPedido bit,  
 @Estado tinyint,  
 @Mensaje nvarchar(255),  
 @NombreArchivoCabecera varchar(100) = null,  
 @NombreArchivoDetalle varchar (100) = null,  
 @NombreServer varchar(100) = null  
as  
-- Actualiza estado de pedidos para descarga  
-- Actualiza el indicadorGPR  
DECLARE @FechaGeneral DATETIME   
DECLARE @IndicadorGPRPais  BIT       
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()   
SELECT @IndicadorGPRPais = ISNULL(PedidoRechazado,0) FROM Pais WHERE EstadoActivo = 1

if @FirmarPedido = 1  
 update dbo.PedidoWeb  
 set 
  IndicadorEnviado = 1,  
  GPRSB = CASE @IndicadorGPRPais WHEN 1 THEN 1 ELSE 0 END,
  FechaProceso = @FechaGeneral  
 from dbo.PedidoWeb p  
  join dbo.TempPedidoWebID pk  on p.CampaniaID = pk.CampaniaID and p.PedidoID = pk.PedidoID  
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

CREATE PROC [dbo].[UpdPedidoWebIndicadorEnviado]  -- en este SP se coloca el indicadorGPR = 1 
 @NroLote int,  
 @FirmarPedido bit,  
 @Estado tinyint,  
 @Mensaje nvarchar(255),  
 @NombreArchivoCabecera varchar(100) = null,  
 @NombreArchivoDetalle varchar (100) = null,  
 @NombreServer varchar(100) = null  
as  
-- Actualiza estado de pedidos para descarga  
-- Actualiza el indicadorGPR  
DECLARE @FechaGeneral DATETIME 
DECLARE @IndicadorGPRPais  BIT         
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()   
SELECT @IndicadorGPRPais = ISNULL(PedidoRechazado,0) FROM Pais WHERE EstadoActivo = 1

if @FirmarPedido = 1  
 update dbo.PedidoWeb  
 set 
  IndicadorEnviado = 1,  
  GPRSB = CASE @IndicadorGPRPais WHEN 1 THEN 1 ELSE 0 END,
  FechaProceso = @FechaGeneral  
 from dbo.PedidoWeb p  
  join dbo.TempPedidoWebID pk  on p.CampaniaID = pk.CampaniaID and p.PedidoID = pk.PedidoID  
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


USE BelcorpEcuador
go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdPedidoWebIndicadorEnviado]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[UpdPedidoWebIndicadorEnviado]
GO

CREATE PROC [dbo].[UpdPedidoWebIndicadorEnviado]  -- en este SP se coloca el indicadorGPR = 1 
 @NroLote int,  
 @FirmarPedido bit,  
 @Estado tinyint,  
 @Mensaje nvarchar(255),  
 @NombreArchivoCabecera varchar(100) = null,  
 @NombreArchivoDetalle varchar (100) = null,  
 @NombreServer varchar(100) = null  
as  
-- Actualiza estado de pedidos para descarga  
-- Actualiza el indicadorGPR  
DECLARE @FechaGeneral DATETIME   
DECLARE @IndicadorGPRPais  BIT           
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()   
SELECT @IndicadorGPRPais = ISNULL(PedidoRechazado,0) FROM Pais WHERE EstadoActivo = 1

if @FirmarPedido = 1  
 update dbo.PedidoWeb  
 set 
  IndicadorEnviado = 1,  
  GPRSB = CASE @IndicadorGPRPais WHEN 1 THEN 1 ELSE 0 END,
  FechaProceso = @FechaGeneral  
 from dbo.PedidoWeb p  
  join dbo.TempPedidoWebID pk  on p.CampaniaID = pk.CampaniaID and p.PedidoID = pk.PedidoID  
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

CREATE PROC [dbo].[UpdPedidoWebIndicadorEnviado]  -- en este SP se coloca el indicadorGPR = 1 
 @NroLote int,  
 @FirmarPedido bit,  
 @Estado tinyint,  
 @Mensaje nvarchar(255),  
 @NombreArchivoCabecera varchar(100) = null,  
 @NombreArchivoDetalle varchar (100) = null,  
 @NombreServer varchar(100) = null  
as  
-- Actualiza estado de pedidos para descarga  
-- Actualiza el indicadorGPR  
DECLARE @FechaGeneral DATETIME     
DECLARE @IndicadorGPRPais  BIT
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()   
SELECT @IndicadorGPRPais = ISNULL(PedidoRechazado,0) FROM Pais WHERE EstadoActivo = 1

if @FirmarPedido = 1  
 update dbo.PedidoWeb  
 set 
  IndicadorEnviado = 1,  
  GPRSB = CASE @IndicadorGPRPais WHEN 1 THEN 1 ELSE 0 END,
  FechaProceso = @FechaGeneral  
 from dbo.PedidoWeb p  
  join dbo.TempPedidoWebID pk  on p.CampaniaID = pk.CampaniaID and p.PedidoID = pk.PedidoID  
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

CREATE PROC [dbo].[UpdPedidoWebIndicadorEnviado]  -- en este SP se coloca el indicadorGPR = 1 
 @NroLote int,  
 @FirmarPedido bit,  
 @Estado tinyint,  
 @Mensaje nvarchar(255),  
 @NombreArchivoCabecera varchar(100) = null,  
 @NombreArchivoDetalle varchar (100) = null,  
 @NombreServer varchar(100) = null  
as  
-- Actualiza estado de pedidos para descarga  
-- Actualiza el indicadorGPR  
DECLARE @FechaGeneral DATETIME    
DECLARE @IndicadorGPRPais  BIT      
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()   
SELECT @IndicadorGPRPais = ISNULL(PedidoRechazado,0) FROM Pais WHERE EstadoActivo = 1

if @FirmarPedido = 1  
 update dbo.PedidoWeb  
 set 
  IndicadorEnviado = 1,  
  GPRSB = CASE @IndicadorGPRPais WHEN 1 THEN 1 ELSE 0 END,
  FechaProceso = @FechaGeneral  
 from dbo.PedidoWeb p  
  join dbo.TempPedidoWebID pk  on p.CampaniaID = pk.CampaniaID and p.PedidoID = pk.PedidoID  
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

CREATE PROC [dbo].[UpdPedidoWebIndicadorEnviado]  -- en este SP se coloca el indicadorGPR = 1 
 @NroLote int,  
 @FirmarPedido bit,  
 @Estado tinyint,  
 @Mensaje nvarchar(255),  
 @NombreArchivoCabecera varchar(100) = null,  
 @NombreArchivoDetalle varchar (100) = null,  
 @NombreServer varchar(100) = null  
as  
-- Actualiza estado de pedidos para descarga  
-- Actualiza el indicadorGPR  
DECLARE @FechaGeneral DATETIME   
DECLARE @IndicadorGPRPais  BIT        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()   
SELECT @IndicadorGPRPais = ISNULL(PedidoRechazado,0) FROM Pais WHERE EstadoActivo = 1

if @FirmarPedido = 1  
 update dbo.PedidoWeb  
 set 
  IndicadorEnviado = 1,  
  GPRSB = CASE @IndicadorGPRPais WHEN 1 THEN 1 ELSE 0 END,
  FechaProceso = @FechaGeneral  
 from dbo.PedidoWeb p  
  join dbo.TempPedidoWebID pk  on p.CampaniaID = pk.CampaniaID and p.PedidoID = pk.PedidoID  
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

CREATE PROC [dbo].[UpdPedidoWebIndicadorEnviado]  -- en este SP se coloca el indicadorGPR = 1 
 @NroLote int,  
 @FirmarPedido bit,  
 @Estado tinyint,  
 @Mensaje nvarchar(255),  
 @NombreArchivoCabecera varchar(100) = null,  
 @NombreArchivoDetalle varchar (100) = null,  
 @NombreServer varchar(100) = null  
as  
-- Actualiza estado de pedidos para descarga  
-- Actualiza el indicadorGPR  
DECLARE @FechaGeneral DATETIME   
DECLARE @IndicadorGPRPais  BIT 
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()   
SELECT @IndicadorGPRPais = ISNULL(PedidoRechazado,0) FROM Pais WHERE EstadoActivo = 1

if @FirmarPedido = 1  
 update dbo.PedidoWeb  
 set 
  IndicadorEnviado = 1,  
  GPRSB = CASE @IndicadorGPRPais WHEN 1 THEN 1 ELSE 0 END,
  FechaProceso = @FechaGeneral  
 from dbo.PedidoWeb p  
  join dbo.TempPedidoWebID pk  on p.CampaniaID = pk.CampaniaID and p.PedidoID = pk.PedidoID  
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

CREATE PROC [dbo].[UpdPedidoWebIndicadorEnviado]  -- en este SP se coloca el indicadorGPR = 1 
 @NroLote int,  
 @FirmarPedido bit,  
 @Estado tinyint,  
 @Mensaje nvarchar(255),  
 @NombreArchivoCabecera varchar(100) = null,  
 @NombreArchivoDetalle varchar (100) = null,  
 @NombreServer varchar(100) = null  
as  
-- Actualiza estado de pedidos para descarga  
-- Actualiza el indicadorGPR  
DECLARE @FechaGeneral DATETIME 
DECLARE @IndicadorGPRPais  BIT          
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()   
SELECT @IndicadorGPRPais = ISNULL(PedidoRechazado,0) FROM Pais WHERE EstadoActivo = 1

if @FirmarPedido = 1  
 update dbo.PedidoWeb  
 set 
  IndicadorEnviado = 1,  
  GPRSB = CASE @IndicadorGPRPais WHEN 1 THEN 1 ELSE 0 END,
  FechaProceso = @FechaGeneral  
 from dbo.PedidoWeb p  
  join dbo.TempPedidoWebID pk  on p.CampaniaID = pk.CampaniaID and p.PedidoID = pk.PedidoID  
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

------------------------------------------------------------------------------------------------

USE BelcorpColombia
go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdPedidoWebIndicadorEnviado]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[UpdPedidoWebIndicadorEnviado]
GO

CREATE PROC [dbo].[UpdPedidoWebIndicadorEnviado]  -- en este SP se coloca el indicadorGPR = 1 
 @NroLote int,  
 @FirmarPedido bit,  
 @Estado tinyint,  
 @Mensaje nvarchar(255),  
 @NombreArchivoCabecera varchar(100) = null,  
 @NombreArchivoDetalle varchar (100) = null,  
 @NombreServer varchar(100) = null  
as  
-- Actualiza estado de pedidos para descarga  
-- Actualiza el indicadorGPR  
DECLARE @FechaGeneral DATETIME   
DECLARE @IndicadorGPRPais  BIT       
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()   
SELECT @IndicadorGPRPais = ISNULL(PedidoRechazado,0) FROM Pais WHERE EstadoActivo = 1

if @FirmarPedido = 1  
 update dbo.PedidoWeb  
 set 
  IndicadorEnviado = 1,  
  GPRSB = CASE @IndicadorGPRPais WHEN 1 THEN 1 ELSE 0 END,
  FechaProceso = @FechaGeneral  
 from dbo.PedidoWeb p  
  join dbo.TempPedidoWebID pk  on p.CampaniaID = pk.CampaniaID and p.PedidoID = pk.PedidoID  
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

USE BelcorpMexico
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdPedidoWebIndicadorEnviado]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[UpdPedidoWebIndicadorEnviado]
GO

CREATE PROC [dbo].[UpdPedidoWebIndicadorEnviado]  -- en este SP se coloca el indicadorGPR = 1 
 @NroLote int,  
 @FirmarPedido bit,  
 @Estado tinyint,  
 @Mensaje nvarchar(255),  
 @NombreArchivoCabecera varchar(100) = null,  
 @NombreArchivoDetalle varchar (100) = null,  
 @NombreServer varchar(100) = null  
as  
-- Actualiza estado de pedidos para descarga  
-- Actualiza el indicadorGPR  
DECLARE @FechaGeneral DATETIME  
DECLARE @IndicadorGPRPais  BIT          
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()   
SELECT @IndicadorGPRPais = ISNULL(PedidoRechazado,0) FROM Pais WHERE EstadoActivo = 1

if @FirmarPedido = 1  
 update dbo.PedidoWeb  
 set 
  IndicadorEnviado = 1,  
  GPRSB = CASE @IndicadorGPRPais WHEN 1 THEN 1 ELSE 0 END,
  FechaProceso = @FechaGeneral  
 from dbo.PedidoWeb p  
  join dbo.TempPedidoWebID pk  on p.CampaniaID = pk.CampaniaID and p.PedidoID = pk.PedidoID  
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

USE BelcorpPeru
go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdPedidoWebIndicadorEnviado]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[UpdPedidoWebIndicadorEnviado]
GO

CREATE PROC [dbo].[UpdPedidoWebIndicadorEnviado]  -- en este SP se coloca el indicadorGPR = 1 
 @NroLote int,  
 @FirmarPedido bit,  
 @Estado tinyint,  
 @Mensaje nvarchar(255),  
 @NombreArchivoCabecera varchar(100) = null,  
 @NombreArchivoDetalle varchar (100) = null,  
 @NombreServer varchar(100) = null  
as  
-- Actualiza estado de pedidos para descarga  
-- Actualiza el indicadorGPR  
DECLARE @FechaGeneral DATETIME          
DECLARE @IndicadorGPRPais  BIT
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()   
SELECT @IndicadorGPRPais = ISNULL(PedidoRechazado,0) FROM Pais WHERE EstadoActivo = 1

if @FirmarPedido = 1  
 update dbo.PedidoWeb  
 set 
  IndicadorEnviado = 1,  
  GPRSB = CASE @IndicadorGPRPais WHEN 1 THEN 1 ELSE 0 END,
  FechaProceso = @FechaGeneral  
 from dbo.PedidoWeb p  
  join dbo.TempPedidoWebID pk  on p.CampaniaID = pk.CampaniaID and p.PedidoID = pk.PedidoID  
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
