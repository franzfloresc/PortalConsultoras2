USE BelcorpCostaRica
go
alter procedure dbo.ESE_INT_OUT_DD_TRX_PEDIDO_FIRMAR_DD
	@intNroLote int,
	@bitFirmarPedido bit,
	@datFechaHoraPais datetime = null,
	@Estado tinyint,
	@Mensaje nvarchar(255),
	@NombreArchivoCabecera varchar(100) = null,
	@NombreArchivoDetalle varchar (100) = null,
	@NombreServer varchar(100) = null,
	@MensajeExcepcion varchar(2000) = null
as
begin
	set nocount on;

	DECLARE @FechaGeneral DATETIME = dbo.fnObtenerFechaHoraPais();

	if @bitFirmarPedido = 1
	begin
		update PedidoDD
		set
			IndicadorEnviado = 1,
			FechaEnvio = dbo.fnObtenerFechaHoraPais()
		from PedidoDD p
		inner join TempPedidoDDID pk on p.CampaniaID = pk.CampaniaID and p.PedidoID = pk.PedidoID
		where pk.NroLote = @intNroLote;	
	end

	if @Estado <> 99
	begin
		update PedidoDDDetalle
		set IndicadorEnviado = 1,
			FechaEnvio = dbo.fnObtenerFechaHoraPais()
		from PedidoDDDetalle p
		inner join TempPedidoDDDetID pk on
			p.CampaniaID = pk.CampaniaID and
			p.PedidoID = pk.PedidoID and
			p.PedidoDetalleID = pk.PedidoDetalleID
		where pk.NroLote = @intNroLote;
	end

	update dbo.PedidoDescarga
	set Estado = @Estado,
		Mensaje = @Mensaje,
		MensajeExcepcion = @MensajeExcepcion,
		FechaFin = @FechaGeneral,
		NombreArchivoCabecera = @NombreArchivoCabecera,
		NombreArchivoDetalle = @NombreArchivoDetalle,
		NombreServer = @NombreServer
	where NroLote = @intNroLote;

	delete TempPedidoDDID
	where NroLote = @intNroLote;

	delete TempPedidoDDDetID
	where NroLote = @intNroLote;
end
go
/*end*/

USE BelcorpGuatemala
go
alter procedure dbo.ESE_INT_OUT_DD_TRX_PEDIDO_FIRMAR_DD
	@intNroLote int,
	@bitFirmarPedido bit,
	@datFechaHoraPais datetime = null,
	@Estado tinyint,
	@Mensaje nvarchar(255),
	@NombreArchivoCabecera varchar(100) = null,
	@NombreArchivoDetalle varchar (100) = null,
	@NombreServer varchar(100) = null,
	@MensajeExcepcion varchar(2000) = null
as
begin
	set nocount on;

	DECLARE @FechaGeneral DATETIME = dbo.fnObtenerFechaHoraPais();

	if @bitFirmarPedido = 1
	begin
		update PedidoDD
		set
			IndicadorEnviado = 1,
			FechaEnvio = dbo.fnObtenerFechaHoraPais()
		from PedidoDD p
		inner join TempPedidoDDID pk on p.CampaniaID = pk.CampaniaID and p.PedidoID = pk.PedidoID
		where pk.NroLote = @intNroLote;	
	end

	if @Estado <> 99
	begin
		update PedidoDDDetalle
		set IndicadorEnviado = 1,
			FechaEnvio = dbo.fnObtenerFechaHoraPais()
		from PedidoDDDetalle p
		inner join TempPedidoDDDetID pk on
			p.CampaniaID = pk.CampaniaID and
			p.PedidoID = pk.PedidoID and
			p.PedidoDetalleID = pk.PedidoDetalleID
		where pk.NroLote = @intNroLote;
	end

	update dbo.PedidoDescarga
	set Estado = @Estado,
		Mensaje = @Mensaje,
		MensajeExcepcion = @MensajeExcepcion,
		FechaFin = @FechaGeneral,
		NombreArchivoCabecera = @NombreArchivoCabecera,
		NombreArchivoDetalle = @NombreArchivoDetalle,
		NombreServer = @NombreServer
	where NroLote = @intNroLote;

	delete TempPedidoDDID
	where NroLote = @intNroLote;

	delete TempPedidoDDDetID
	where NroLote = @intNroLote;
end
go
/*end*/

USE BelcorpMexico
go
alter procedure dbo.ESE_INT_OUT_DD_TRX_PEDIDO_FIRMAR_DD
	@intNroLote int,
	@bitFirmarPedido bit,
	@datFechaHoraPais datetime = null,
	@Estado tinyint,
	@Mensaje nvarchar(255),
	@NombreArchivoCabecera varchar(100) = null,
	@NombreArchivoDetalle varchar (100) = null,
	@NombreServer varchar(100) = null,
	@MensajeExcepcion varchar(2000) = null
as
begin
	set nocount on;

	DECLARE @FechaGeneral DATETIME = dbo.fnObtenerFechaHoraPais();

	if @bitFirmarPedido = 1
	begin
		update PedidoDD
		set
			IndicadorEnviado = 1,
			FechaEnvio = dbo.fnObtenerFechaHoraPais()
		from PedidoDD p
		inner join TempPedidoDDID pk on p.CampaniaID = pk.CampaniaID and p.PedidoID = pk.PedidoID
		where pk.NroLote = @intNroLote;	
	end

	if @Estado <> 99
	begin
		update PedidoDDDetalle
		set IndicadorEnviado = 1,
			FechaEnvio = dbo.fnObtenerFechaHoraPais()
		from PedidoDDDetalle p
		inner join TempPedidoDDDetID pk on
			p.CampaniaID = pk.CampaniaID and
			p.PedidoID = pk.PedidoID and
			p.PedidoDetalleID = pk.PedidoDetalleID
		where pk.NroLote = @intNroLote;
	end

	update dbo.PedidoDescarga
	set Estado = @Estado,
		Mensaje = @Mensaje,
		MensajeExcepcion = @MensajeExcepcion,
		FechaFin = @FechaGeneral,
		NombreArchivoCabecera = @NombreArchivoCabecera,
		NombreArchivoDetalle = @NombreArchivoDetalle,
		NombreServer = @NombreServer
	where NroLote = @intNroLote;

	delete TempPedidoDDID
	where NroLote = @intNroLote;

	delete TempPedidoDDDetID
	where NroLote = @intNroLote;
end
go
/*end*/

USE BelcorpSalvador
go
alter procedure dbo.ESE_INT_OUT_DD_TRX_PEDIDO_FIRMAR_DD
	@intNroLote int,
	@bitFirmarPedido bit,
	@datFechaHoraPais datetime = null,
	@Estado tinyint,
	@Mensaje nvarchar(255),
	@NombreArchivoCabecera varchar(100) = null,
	@NombreArchivoDetalle varchar (100) = null,
	@NombreServer varchar(100) = null,
	@MensajeExcepcion varchar(2000) = null
as
begin
	set nocount on;

	DECLARE @FechaGeneral DATETIME = dbo.fnObtenerFechaHoraPais();

	if @bitFirmarPedido = 1
	begin
		update PedidoDD
		set
			IndicadorEnviado = 1,
			FechaEnvio = dbo.fnObtenerFechaHoraPais()
		from PedidoDD p
		inner join TempPedidoDDID pk on p.CampaniaID = pk.CampaniaID and p.PedidoID = pk.PedidoID
		where pk.NroLote = @intNroLote;	
	end

	if @Estado <> 99
	begin
		update PedidoDDDetalle
		set IndicadorEnviado = 1,
			FechaEnvio = dbo.fnObtenerFechaHoraPais()
		from PedidoDDDetalle p
		inner join TempPedidoDDDetID pk on
			p.CampaniaID = pk.CampaniaID and
			p.PedidoID = pk.PedidoID and
			p.PedidoDetalleID = pk.PedidoDetalleID
		where pk.NroLote = @intNroLote;
	end

	update dbo.PedidoDescarga
	set Estado = @Estado,
		Mensaje = @Mensaje,
		MensajeExcepcion = @MensajeExcepcion,
		FechaFin = @FechaGeneral,
		NombreArchivoCabecera = @NombreArchivoCabecera,
		NombreArchivoDetalle = @NombreArchivoDetalle,
		NombreServer = @NombreServer
	where NroLote = @intNroLote;

	delete TempPedidoDDID
	where NroLote = @intNroLote;

	delete TempPedidoDDDetID
	where NroLote = @intNroLote;
end
go