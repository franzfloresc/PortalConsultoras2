USE BelcorpChile
go
alter procedure dbo.UpdPedidoWebIndicadorEnviado  -- en este SP se coloca el indicadorGPR = 1
	@NroLote int,
	@FirmarPedido bit,
	@Estado tinyint,
	@Mensaje nvarchar(255),
	@NombreArchivoCabecera varchar(100) = null,
	@NombreArchivoDetalle varchar (100) = null,
	@NombreServer varchar(100) = null
as
begin
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
end
go
/*end*/

USE BelcorpColombia
go
alter procedure dbo.UpdPedidoWebIndicadorEnviado  -- en este SP se coloca el indicadorGPR = 1
	@NroLote int,
	@FirmarPedido bit,
	@Estado tinyint,
	@Mensaje nvarchar(255),
	@NombreArchivoCabecera varchar(100) = null,
	@NombreArchivoDetalle varchar (100) = null,
	@NombreServer varchar(100) = null
as
begin
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
end
go
/*end*/

USE BelcorpCostaRica
go
alter procedure dbo.UpdPedidoWebIndicadorEnviado  -- en este SP se coloca el indicadorGPR = 1
	@NroLote int,
	@FirmarPedido bit,
	@Estado tinyint,
	@Mensaje nvarchar(255),
	@NombreArchivoCabecera varchar(100) = null,
	@NombreArchivoDetalle varchar (100) = null,
	@NombreServer varchar(100) = null
as
begin
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
end
go
/*end*/

USE BelcorpEcuador
go
alter procedure dbo.UpdPedidoWebIndicadorEnviado  -- en este SP se coloca el indicadorGPR = 1
	@NroLote int,
	@FirmarPedido bit,
	@Estado tinyint,
	@Mensaje nvarchar(255),
	@NombreArchivoCabecera varchar(100) = null,
	@NombreArchivoDetalle varchar (100) = null,
	@NombreServer varchar(100) = null
as
begin
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
end
go
/*end*/

USE BelcorpGuatemala
go
alter procedure dbo.UpdPedidoWebIndicadorEnviado  -- en este SP se coloca el indicadorGPR = 1
	@NroLote int,
	@FirmarPedido bit,
	@Estado tinyint,
	@Mensaje nvarchar(255),
	@NombreArchivoCabecera varchar(100) = null,
	@NombreArchivoDetalle varchar (100) = null,
	@NombreServer varchar(100) = null
as
begin
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
end
go
/*end*/

USE BelcorpPanama
go
alter procedure dbo.UpdPedidoWebIndicadorEnviado  -- en este SP se coloca el indicadorGPR = 1
	@NroLote int,
	@FirmarPedido bit,
	@Estado tinyint,
	@Mensaje nvarchar(255),
	@NombreArchivoCabecera varchar(100) = null,
	@NombreArchivoDetalle varchar (100) = null,
	@NombreServer varchar(100) = null
as
begin
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
end
go
/*end*/

USE BelcorpPeru
go
alter procedure dbo.UpdPedidoWebIndicadorEnviado  -- en este SP se coloca el indicadorGPR = 1
	@NroLote int,
	@FirmarPedido bit,
	@Estado tinyint,
	@Mensaje nvarchar(255),
	@NombreArchivoCabecera varchar(100) = null,
	@NombreArchivoDetalle varchar (100) = null,
	@NombreServer varchar(100) = null
as
begin
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
end
go
/*end*/

USE BelcorpSalvador
go
alter procedure dbo.UpdPedidoWebIndicadorEnviado  -- en este SP se coloca el indicadorGPR = 1
	@NroLote int,
	@FirmarPedido bit,
	@Estado tinyint,
	@Mensaje nvarchar(255),
	@NombreArchivoCabecera varchar(100) = null,
	@NombreArchivoDetalle varchar (100) = null,
	@NombreServer varchar(100) = null
as
begin
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
end
go
/*end*/

USE BelcorpVenezuela
go
alter procedure dbo.UpdPedidoWebIndicadorEnviado  -- en este SP se coloca el indicadorGPR = 1
	@NroLote int,
	@FirmarPedido bit,
	@Estado tinyint,
	@Mensaje nvarchar(255),
	@NombreArchivoCabecera varchar(100) = null,
	@NombreArchivoDetalle varchar (100) = null,
	@NombreServer varchar(100) = null
as
begin
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
end
go