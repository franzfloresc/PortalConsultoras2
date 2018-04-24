GO
USE BelcorpPeru
GO
IF (OBJECT_ID('dbo.UpdPedidoWebIndicadorEnviado', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.UpdPedidoWebIndicadorEnviado AS SET NOCOUNT ON;')
GO
ALTER procedure [dbo].[UpdPedidoWebIndicadorEnviado]  -- en este SP se coloca el indicadorGPR = 1
	@NroLote int,
	@FirmarPedido bit,
	@Estado tinyint,
	@Mensaje nvarchar(255),
	@MensajeExcepcion varchar(2000),
	@NombreArchivoCabecera varchar(100) = null,
	@NombreArchivoDetalle varchar (100) = null,
	@NombreServer varchar(100) = null
as
begin
	-- Actualiza estado de pedidos para descarga
	-- Actualiza el indicadorGPR
	DECLARE @FechaGeneral DATETIME = dbo.fnObtenerFechaHoraPais();
	DECLARE @IndicadorGPRPais BIT;
	SELECT @IndicadorGPRPais = ISNULL(PedidoRechazado,0) FROM Pais WHERE EstadoActivo = 1;

	if @FirmarPedido = 1
	begin
		update dbo.PedidoWeb
		set
			IndicadorEnviado = 1,
			GPRSB = CASE @IndicadorGPRPais WHEN 1 THEN 1 ELSE 0 END,
			FechaProceso = @FechaGeneral
		from dbo.PedidoWeb p
		join dbo.TempPedidoWebID pk  on p.CampaniaID = pk.CampaniaID and p.PedidoID = pk.PedidoID
		where pk.NroLote = @NroLote;
	End
	update dbo.PedidoDescarga
	set
		Estado = @Estado,
		Mensaje = @Mensaje,
		MensajeExcepcion = @MensajeExcepcion,
		FechaFin = @FechaGeneral,
		NombreArchivoCabecera = @NombreArchivoCabecera,
		NombreArchivoDetalle = @NombreArchivoDetalle,
		NombreServer = @NombreServer
	where NroLote = @NroLote;
	delete dbo.TempPedidoWebID
	where NroLote = @NroLote;
end


GO
USE BelcorpMexico
GO
IF (OBJECT_ID('dbo.UpdPedidoWebIndicadorEnviado', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.UpdPedidoWebIndicadorEnviado AS SET NOCOUNT ON;')
GO
ALTER procedure [dbo].[UpdPedidoWebIndicadorEnviado]  -- en este SP se coloca el indicadorGPR = 1
	@NroLote int,
	@FirmarPedido bit,
	@Estado tinyint,
	@Mensaje nvarchar(255),
	@MensajeExcepcion varchar(2000),
	@NombreArchivoCabecera varchar(100) = null,
	@NombreArchivoDetalle varchar (100) = null,
	@NombreServer varchar(100) = null
as
begin
	-- Actualiza estado de pedidos para descarga
	-- Actualiza el indicadorGPR
	DECLARE @FechaGeneral DATETIME = dbo.fnObtenerFechaHoraPais();
	DECLARE @IndicadorGPRPais BIT;
	SELECT @IndicadorGPRPais = ISNULL(PedidoRechazado,0) FROM Pais WHERE EstadoActivo = 1;

	if @FirmarPedido = 1
	begin
		update dbo.PedidoWeb
		set
			IndicadorEnviado = 1,
			GPRSB = CASE @IndicadorGPRPais WHEN 1 THEN 1 ELSE 0 END,
			FechaProceso = @FechaGeneral
		from dbo.PedidoWeb p
		join dbo.TempPedidoWebID pk  on p.CampaniaID = pk.CampaniaID and p.PedidoID = pk.PedidoID
		where pk.NroLote = @NroLote;
	End
	update dbo.PedidoDescarga
	set
		Estado = @Estado,
		Mensaje = @Mensaje,
		MensajeExcepcion = @MensajeExcepcion,
		FechaFin = @FechaGeneral,
		NombreArchivoCabecera = @NombreArchivoCabecera,
		NombreArchivoDetalle = @NombreArchivoDetalle,
		NombreServer = @NombreServer
	where NroLote = @NroLote;
	delete dbo.TempPedidoWebID
	where NroLote = @NroLote;
end


GO
USE BelcorpColombia
GO
IF (OBJECT_ID('dbo.UpdPedidoWebIndicadorEnviado', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.UpdPedidoWebIndicadorEnviado AS SET NOCOUNT ON;')
GO
ALTER procedure [dbo].[UpdPedidoWebIndicadorEnviado]  -- en este SP se coloca el indicadorGPR = 1
	@NroLote int,
	@FirmarPedido bit,
	@Estado tinyint,
	@Mensaje nvarchar(255),
	@MensajeExcepcion varchar(2000),
	@NombreArchivoCabecera varchar(100) = null,
	@NombreArchivoDetalle varchar (100) = null,
	@NombreServer varchar(100) = null
as
begin
	-- Actualiza estado de pedidos para descarga
	-- Actualiza el indicadorGPR
	DECLARE @FechaGeneral DATETIME = dbo.fnObtenerFechaHoraPais();
	DECLARE @IndicadorGPRPais BIT;
	SELECT @IndicadorGPRPais = ISNULL(PedidoRechazado,0) FROM Pais WHERE EstadoActivo = 1;

	if @FirmarPedido = 1
	begin
		update dbo.PedidoWeb
		set
			IndicadorEnviado = 1,
			GPRSB = CASE @IndicadorGPRPais WHEN 1 THEN 1 ELSE 0 END,
			FechaProceso = @FechaGeneral
		from dbo.PedidoWeb p
		join dbo.TempPedidoWebID pk  on p.CampaniaID = pk.CampaniaID and p.PedidoID = pk.PedidoID
		where pk.NroLote = @NroLote;
	End
	update dbo.PedidoDescarga
	set
		Estado = @Estado,
		Mensaje = @Mensaje,
		MensajeExcepcion = @MensajeExcepcion,
		FechaFin = @FechaGeneral,
		NombreArchivoCabecera = @NombreArchivoCabecera,
		NombreArchivoDetalle = @NombreArchivoDetalle,
		NombreServer = @NombreServer
	where NroLote = @NroLote;
	delete dbo.TempPedidoWebID
	where NroLote = @NroLote;
end


GO
USE BelcorpVenezuela
GO
IF (OBJECT_ID('dbo.UpdPedidoWebIndicadorEnviado', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.UpdPedidoWebIndicadorEnviado AS SET NOCOUNT ON;')
GO
ALTER procedure [dbo].[UpdPedidoWebIndicadorEnviado]  -- en este SP se coloca el indicadorGPR = 1
	@NroLote int,
	@FirmarPedido bit,
	@Estado tinyint,
	@Mensaje nvarchar(255),
	@MensajeExcepcion varchar(2000),
	@NombreArchivoCabecera varchar(100) = null,
	@NombreArchivoDetalle varchar (100) = null,
	@NombreServer varchar(100) = null
as
begin
	-- Actualiza estado de pedidos para descarga
	-- Actualiza el indicadorGPR
	DECLARE @FechaGeneral DATETIME = dbo.fnObtenerFechaHoraPais();
	DECLARE @IndicadorGPRPais BIT;
	SELECT @IndicadorGPRPais = ISNULL(PedidoRechazado,0) FROM Pais WHERE EstadoActivo = 1;

	if @FirmarPedido = 1
	begin
		update dbo.PedidoWeb
		set
			IndicadorEnviado = 1,
			GPRSB = CASE @IndicadorGPRPais WHEN 1 THEN 1 ELSE 0 END,
			FechaProceso = @FechaGeneral
		from dbo.PedidoWeb p
		join dbo.TempPedidoWebID pk  on p.CampaniaID = pk.CampaniaID and p.PedidoID = pk.PedidoID
		where pk.NroLote = @NroLote;
	End
	update dbo.PedidoDescarga
	set
		Estado = @Estado,
		Mensaje = @Mensaje,
		MensajeExcepcion = @MensajeExcepcion,
		FechaFin = @FechaGeneral,
		NombreArchivoCabecera = @NombreArchivoCabecera,
		NombreArchivoDetalle = @NombreArchivoDetalle,
		NombreServer = @NombreServer
	where NroLote = @NroLote;
	delete dbo.TempPedidoWebID
	where NroLote = @NroLote;
end


GO
USE BelcorpSalvador
GO
IF (OBJECT_ID('dbo.UpdPedidoWebIndicadorEnviado', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.UpdPedidoWebIndicadorEnviado AS SET NOCOUNT ON;')
GO
ALTER procedure [dbo].[UpdPedidoWebIndicadorEnviado]  -- en este SP se coloca el indicadorGPR = 1
	@NroLote int,
	@FirmarPedido bit,
	@Estado tinyint,
	@Mensaje nvarchar(255),
	@MensajeExcepcion varchar(2000),
	@NombreArchivoCabecera varchar(100) = null,
	@NombreArchivoDetalle varchar (100) = null,
	@NombreServer varchar(100) = null
as
begin
	-- Actualiza estado de pedidos para descarga
	-- Actualiza el indicadorGPR
	DECLARE @FechaGeneral DATETIME = dbo.fnObtenerFechaHoraPais();
	DECLARE @IndicadorGPRPais BIT;
	SELECT @IndicadorGPRPais = ISNULL(PedidoRechazado,0) FROM Pais WHERE EstadoActivo = 1;

	if @FirmarPedido = 1
	begin
		update dbo.PedidoWeb
		set
			IndicadorEnviado = 1,
			GPRSB = CASE @IndicadorGPRPais WHEN 1 THEN 1 ELSE 0 END,
			FechaProceso = @FechaGeneral
		from dbo.PedidoWeb p
		join dbo.TempPedidoWebID pk  on p.CampaniaID = pk.CampaniaID and p.PedidoID = pk.PedidoID
		where pk.NroLote = @NroLote;
	End
	update dbo.PedidoDescarga
	set
		Estado = @Estado,
		Mensaje = @Mensaje,
		MensajeExcepcion = @MensajeExcepcion,
		FechaFin = @FechaGeneral,
		NombreArchivoCabecera = @NombreArchivoCabecera,
		NombreArchivoDetalle = @NombreArchivoDetalle,
		NombreServer = @NombreServer
	where NroLote = @NroLote;
	delete dbo.TempPedidoWebID
	where NroLote = @NroLote;
end


GO
USE BelcorpPuertoRico
GO
IF (OBJECT_ID('dbo.UpdPedidoWebIndicadorEnviado', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.UpdPedidoWebIndicadorEnviado AS SET NOCOUNT ON;')
GO
ALTER procedure [dbo].[UpdPedidoWebIndicadorEnviado]  -- en este SP se coloca el indicadorGPR = 1
	@NroLote int,
	@FirmarPedido bit,
	@Estado tinyint,
	@Mensaje nvarchar(255),
	@MensajeExcepcion varchar(2000),
	@NombreArchivoCabecera varchar(100) = null,
	@NombreArchivoDetalle varchar (100) = null,
	@NombreServer varchar(100) = null
as
begin
	-- Actualiza estado de pedidos para descarga
	-- Actualiza el indicadorGPR
	DECLARE @FechaGeneral DATETIME = dbo.fnObtenerFechaHoraPais();
	DECLARE @IndicadorGPRPais BIT;
	SELECT @IndicadorGPRPais = ISNULL(PedidoRechazado,0) FROM Pais WHERE EstadoActivo = 1;

	if @FirmarPedido = 1
	begin
		update dbo.PedidoWeb
		set
			IndicadorEnviado = 1,
			GPRSB = CASE @IndicadorGPRPais WHEN 1 THEN 1 ELSE 0 END,
			FechaProceso = @FechaGeneral
		from dbo.PedidoWeb p
		join dbo.TempPedidoWebID pk  on p.CampaniaID = pk.CampaniaID and p.PedidoID = pk.PedidoID
		where pk.NroLote = @NroLote;
	End
	update dbo.PedidoDescarga
	set
		Estado = @Estado,
		Mensaje = @Mensaje,
		MensajeExcepcion = @MensajeExcepcion,
		FechaFin = @FechaGeneral,
		NombreArchivoCabecera = @NombreArchivoCabecera,
		NombreArchivoDetalle = @NombreArchivoDetalle,
		NombreServer = @NombreServer
	where NroLote = @NroLote;
	delete dbo.TempPedidoWebID
	where NroLote = @NroLote;
end


GO
USE BelcorpPanama
GO
IF (OBJECT_ID('dbo.UpdPedidoWebIndicadorEnviado', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.UpdPedidoWebIndicadorEnviado AS SET NOCOUNT ON;')
GO
ALTER procedure [dbo].[UpdPedidoWebIndicadorEnviado]  -- en este SP se coloca el indicadorGPR = 1
	@NroLote int,
	@FirmarPedido bit,
	@Estado tinyint,
	@Mensaje nvarchar(255),
	@MensajeExcepcion varchar(2000),
	@NombreArchivoCabecera varchar(100) = null,
	@NombreArchivoDetalle varchar (100) = null,
	@NombreServer varchar(100) = null
as
begin
	-- Actualiza estado de pedidos para descarga
	-- Actualiza el indicadorGPR
	DECLARE @FechaGeneral DATETIME = dbo.fnObtenerFechaHoraPais();
	DECLARE @IndicadorGPRPais BIT;
	SELECT @IndicadorGPRPais = ISNULL(PedidoRechazado,0) FROM Pais WHERE EstadoActivo = 1;

	if @FirmarPedido = 1
	begin
		update dbo.PedidoWeb
		set
			IndicadorEnviado = 1,
			GPRSB = CASE @IndicadorGPRPais WHEN 1 THEN 1 ELSE 0 END,
			FechaProceso = @FechaGeneral
		from dbo.PedidoWeb p
		join dbo.TempPedidoWebID pk  on p.CampaniaID = pk.CampaniaID and p.PedidoID = pk.PedidoID
		where pk.NroLote = @NroLote;
	End
	update dbo.PedidoDescarga
	set
		Estado = @Estado,
		Mensaje = @Mensaje,
		MensajeExcepcion = @MensajeExcepcion,
		FechaFin = @FechaGeneral,
		NombreArchivoCabecera = @NombreArchivoCabecera,
		NombreArchivoDetalle = @NombreArchivoDetalle,
		NombreServer = @NombreServer
	where NroLote = @NroLote;
	delete dbo.TempPedidoWebID
	where NroLote = @NroLote;
end


GO
USE BelcorpGuatemala
GO
IF (OBJECT_ID('dbo.UpdPedidoWebIndicadorEnviado', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.UpdPedidoWebIndicadorEnviado AS SET NOCOUNT ON;')
GO
ALTER procedure [dbo].[UpdPedidoWebIndicadorEnviado]  -- en este SP se coloca el indicadorGPR = 1
	@NroLote int,
	@FirmarPedido bit,
	@Estado tinyint,
	@Mensaje nvarchar(255),
	@MensajeExcepcion varchar(2000),
	@NombreArchivoCabecera varchar(100) = null,
	@NombreArchivoDetalle varchar (100) = null,
	@NombreServer varchar(100) = null
as
begin
	-- Actualiza estado de pedidos para descarga
	-- Actualiza el indicadorGPR
	DECLARE @FechaGeneral DATETIME = dbo.fnObtenerFechaHoraPais();
	DECLARE @IndicadorGPRPais BIT;
	SELECT @IndicadorGPRPais = ISNULL(PedidoRechazado,0) FROM Pais WHERE EstadoActivo = 1;

	if @FirmarPedido = 1
	begin
		update dbo.PedidoWeb
		set
			IndicadorEnviado = 1,
			GPRSB = CASE @IndicadorGPRPais WHEN 1 THEN 1 ELSE 0 END,
			FechaProceso = @FechaGeneral
		from dbo.PedidoWeb p
		join dbo.TempPedidoWebID pk  on p.CampaniaID = pk.CampaniaID and p.PedidoID = pk.PedidoID
		where pk.NroLote = @NroLote;
	End
	update dbo.PedidoDescarga
	set
		Estado = @Estado,
		Mensaje = @Mensaje,
		MensajeExcepcion = @MensajeExcepcion,
		FechaFin = @FechaGeneral,
		NombreArchivoCabecera = @NombreArchivoCabecera,
		NombreArchivoDetalle = @NombreArchivoDetalle,
		NombreServer = @NombreServer
	where NroLote = @NroLote;
	delete dbo.TempPedidoWebID
	where NroLote = @NroLote;
end


GO
USE BelcorpEcuador
GO
IF (OBJECT_ID('dbo.UpdPedidoWebIndicadorEnviado', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.UpdPedidoWebIndicadorEnviado AS SET NOCOUNT ON;')
GO
ALTER procedure [dbo].[UpdPedidoWebIndicadorEnviado]  -- en este SP se coloca el indicadorGPR = 1
	@NroLote int,
	@FirmarPedido bit,
	@Estado tinyint,
	@Mensaje nvarchar(255),
	@MensajeExcepcion varchar(2000),
	@NombreArchivoCabecera varchar(100) = null,
	@NombreArchivoDetalle varchar (100) = null,
	@NombreServer varchar(100) = null
as
begin
	-- Actualiza estado de pedidos para descarga
	-- Actualiza el indicadorGPR
	DECLARE @FechaGeneral DATETIME = dbo.fnObtenerFechaHoraPais();
	DECLARE @IndicadorGPRPais BIT;
	SELECT @IndicadorGPRPais = ISNULL(PedidoRechazado,0) FROM Pais WHERE EstadoActivo = 1;

	if @FirmarPedido = 1
	begin
		update dbo.PedidoWeb
		set
			IndicadorEnviado = 1,
			GPRSB = CASE @IndicadorGPRPais WHEN 1 THEN 1 ELSE 0 END,
			FechaProceso = @FechaGeneral
		from dbo.PedidoWeb p
		join dbo.TempPedidoWebID pk  on p.CampaniaID = pk.CampaniaID and p.PedidoID = pk.PedidoID
		where pk.NroLote = @NroLote;
	End
	update dbo.PedidoDescarga
	set
		Estado = @Estado,
		Mensaje = @Mensaje,
		MensajeExcepcion = @MensajeExcepcion,
		FechaFin = @FechaGeneral,
		NombreArchivoCabecera = @NombreArchivoCabecera,
		NombreArchivoDetalle = @NombreArchivoDetalle,
		NombreServer = @NombreServer
	where NroLote = @NroLote;
	delete dbo.TempPedidoWebID
	where NroLote = @NroLote;
end


GO
USE BelcorpDominicana
GO
IF (OBJECT_ID('dbo.UpdPedidoWebIndicadorEnviado', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.UpdPedidoWebIndicadorEnviado AS SET NOCOUNT ON;')
GO
ALTER procedure [dbo].[UpdPedidoWebIndicadorEnviado]  -- en este SP se coloca el indicadorGPR = 1
	@NroLote int,
	@FirmarPedido bit,
	@Estado tinyint,
	@Mensaje nvarchar(255),
	@MensajeExcepcion varchar(2000),
	@NombreArchivoCabecera varchar(100) = null,
	@NombreArchivoDetalle varchar (100) = null,
	@NombreServer varchar(100) = null
as
begin
	-- Actualiza estado de pedidos para descarga
	-- Actualiza el indicadorGPR
	DECLARE @FechaGeneral DATETIME = dbo.fnObtenerFechaHoraPais();
	DECLARE @IndicadorGPRPais BIT;
	SELECT @IndicadorGPRPais = ISNULL(PedidoRechazado,0) FROM Pais WHERE EstadoActivo = 1;

	if @FirmarPedido = 1
	begin
		update dbo.PedidoWeb
		set
			IndicadorEnviado = 1,
			GPRSB = CASE @IndicadorGPRPais WHEN 1 THEN 1 ELSE 0 END,
			FechaProceso = @FechaGeneral
		from dbo.PedidoWeb p
		join dbo.TempPedidoWebID pk  on p.CampaniaID = pk.CampaniaID and p.PedidoID = pk.PedidoID
		where pk.NroLote = @NroLote;
	End
	update dbo.PedidoDescarga
	set
		Estado = @Estado,
		Mensaje = @Mensaje,
		MensajeExcepcion = @MensajeExcepcion,
		FechaFin = @FechaGeneral,
		NombreArchivoCabecera = @NombreArchivoCabecera,
		NombreArchivoDetalle = @NombreArchivoDetalle,
		NombreServer = @NombreServer
	where NroLote = @NroLote;
	delete dbo.TempPedidoWebID
	where NroLote = @NroLote;
end


GO
USE BelcorpCostaRica
GO
IF (OBJECT_ID('dbo.UpdPedidoWebIndicadorEnviado', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.UpdPedidoWebIndicadorEnviado AS SET NOCOUNT ON;')
GO
ALTER procedure [dbo].[UpdPedidoWebIndicadorEnviado]  -- en este SP se coloca el indicadorGPR = 1
	@NroLote int,
	@FirmarPedido bit,
	@Estado tinyint,
	@Mensaje nvarchar(255),
	@MensajeExcepcion varchar(2000),
	@NombreArchivoCabecera varchar(100) = null,
	@NombreArchivoDetalle varchar (100) = null,
	@NombreServer varchar(100) = null
as
begin
	-- Actualiza estado de pedidos para descarga
	-- Actualiza el indicadorGPR
	DECLARE @FechaGeneral DATETIME = dbo.fnObtenerFechaHoraPais();
	DECLARE @IndicadorGPRPais BIT;
	SELECT @IndicadorGPRPais = ISNULL(PedidoRechazado,0) FROM Pais WHERE EstadoActivo = 1;

	if @FirmarPedido = 1
	begin
		update dbo.PedidoWeb
		set
			IndicadorEnviado = 1,
			GPRSB = CASE @IndicadorGPRPais WHEN 1 THEN 1 ELSE 0 END,
			FechaProceso = @FechaGeneral
		from dbo.PedidoWeb p
		join dbo.TempPedidoWebID pk  on p.CampaniaID = pk.CampaniaID and p.PedidoID = pk.PedidoID
		where pk.NroLote = @NroLote;
	End
	update dbo.PedidoDescarga
	set
		Estado = @Estado,
		Mensaje = @Mensaje,
		MensajeExcepcion = @MensajeExcepcion,
		FechaFin = @FechaGeneral,
		NombreArchivoCabecera = @NombreArchivoCabecera,
		NombreArchivoDetalle = @NombreArchivoDetalle,
		NombreServer = @NombreServer
	where NroLote = @NroLote;
	delete dbo.TempPedidoWebID
	where NroLote = @NroLote;
end


GO
USE BelcorpChile
GO
IF (OBJECT_ID('dbo.UpdPedidoWebIndicadorEnviado', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.UpdPedidoWebIndicadorEnviado AS SET NOCOUNT ON;')
GO
ALTER procedure [dbo].[UpdPedidoWebIndicadorEnviado]  -- en este SP se coloca el indicadorGPR = 1
	@NroLote int,
	@FirmarPedido bit,
	@Estado tinyint,
	@Mensaje nvarchar(255),
	@MensajeExcepcion varchar(2000),
	@NombreArchivoCabecera varchar(100) = null,
	@NombreArchivoDetalle varchar (100) = null,
	@NombreServer varchar(100) = null
as
begin
	-- Actualiza estado de pedidos para descarga
	-- Actualiza el indicadorGPR
	DECLARE @FechaGeneral DATETIME = dbo.fnObtenerFechaHoraPais();
	DECLARE @IndicadorGPRPais BIT;
	SELECT @IndicadorGPRPais = ISNULL(PedidoRechazado,0) FROM Pais WHERE EstadoActivo = 1;

	if @FirmarPedido = 1
	begin
		update dbo.PedidoWeb
		set
			IndicadorEnviado = 1,
			GPRSB = CASE @IndicadorGPRPais WHEN 1 THEN 1 ELSE 0 END,
			FechaProceso = @FechaGeneral
		from dbo.PedidoWeb p
		join dbo.TempPedidoWebID pk  on p.CampaniaID = pk.CampaniaID and p.PedidoID = pk.PedidoID
		where pk.NroLote = @NroLote;
	End
	update dbo.PedidoDescarga
	set
		Estado = @Estado,
		Mensaje = @Mensaje,
		MensajeExcepcion = @MensajeExcepcion,
		FechaFin = @FechaGeneral,
		NombreArchivoCabecera = @NombreArchivoCabecera,
		NombreArchivoDetalle = @NombreArchivoDetalle,
		NombreServer = @NombreServer
	where NroLote = @NroLote;
	delete dbo.TempPedidoWebID
	where NroLote = @NroLote;
end


GO
USE BelcorpBolivia
GO
IF (OBJECT_ID('dbo.UpdPedidoWebIndicadorEnviado', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.UpdPedidoWebIndicadorEnviado AS SET NOCOUNT ON;')
GO
ALTER procedure [dbo].[UpdPedidoWebIndicadorEnviado]  -- en este SP se coloca el indicadorGPR = 1
	@NroLote int,
	@FirmarPedido bit,
	@Estado tinyint,
	@Mensaje nvarchar(255),
	@MensajeExcepcion varchar(2000),
	@NombreArchivoCabecera varchar(100) = null,
	@NombreArchivoDetalle varchar (100) = null,
	@NombreServer varchar(100) = null
as
begin
	-- Actualiza estado de pedidos para descarga
	-- Actualiza el indicadorGPR
	DECLARE @FechaGeneral DATETIME = dbo.fnObtenerFechaHoraPais();
	DECLARE @IndicadorGPRPais BIT;
	SELECT @IndicadorGPRPais = ISNULL(PedidoRechazado,0) FROM Pais WHERE EstadoActivo = 1;

	if @FirmarPedido = 1
	begin
		update dbo.PedidoWeb
		set
			IndicadorEnviado = 1,
			GPRSB = CASE @IndicadorGPRPais WHEN 1 THEN 1 ELSE 0 END,
			FechaProceso = @FechaGeneral
		from dbo.PedidoWeb p
		join dbo.TempPedidoWebID pk  on p.CampaniaID = pk.CampaniaID and p.PedidoID = pk.PedidoID
		where pk.NroLote = @NroLote;
	End
	update dbo.PedidoDescarga
	set
		Estado = @Estado,
		Mensaje = @Mensaje,
		MensajeExcepcion = @MensajeExcepcion,
		FechaFin = @FechaGeneral,
		NombreArchivoCabecera = @NombreArchivoCabecera,
		NombreArchivoDetalle = @NombreArchivoDetalle,
		NombreServer = @NombreServer
	where NroLote = @NroLote;
	delete dbo.TempPedidoWebID
	where NroLote = @NroLote;
end


GO
