GO
IF OBJECT_ID('dbo.UpdPedidoWebReserva') IS NOT NULL
BEGIN
	drop procedure dbo.UpdPedidoWebReserva
END
GO
create proc dbo.UpdPedidoWebReserva
	@CampaniaID int,
	@PedidoID int,
	@CodigoUsuarioModificacion varchar(25),
	@MontoTotalProl money,
	@EstimadoGanancia money,
	@EstadoPedido smallint
as
begin
	declare @FechaGeneral datetime = dbo.fnObtenerFechaHoraPais();
	declare @ModificaPedidoReservadoDetalle bit = iif(@EstadoPedido = 201, 0, 1);

	update PedidoWebDetalle
	set ModificaPedidoReservado = @ModificaPedidoReservadoDetalle
	where CampaniaID = @CampaniaID AND PedidoID = @PedidoID

	update PedidoWeb 
	set
		CodigoUsuarioModificacion = @CodigoUsuarioModificacion,
		FechaModificacion = @FechaGeneral,
		MontoTotalProl = @MontoTotalProl,
		EstimadoGanancia = @EstimadoGanancia,
		FechaReserva = @FechaGeneral,
		EstadoPedido = @EstadoPedido,
		ValidacionAbierta = 0,
		ModificaPedidoReservado = 0
	where CampaniaID = @CampaniaID AND PedidoID = @PedidoID;
end
GO