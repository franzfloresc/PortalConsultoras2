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
	--@MontoDescuento money,
	--@MontoAhorroCatalogo money,
	--@MontoAhorroRevista money,
	--@MontoEscala money,
	@EstimadoGanancia money,
	@EstadoPedido smallint,
	@PedidoSapId bigint,
	@VersionProl tinyint
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
		--DescuentoProl = @MontoDescuento,
		--MontoAhorroCatalogo = @MontoAhorroCatalogo,
		--MontoAhorroRevista = @MontoAhorroRevista,
		--MontoEscala = @MontoEscala,
		EstimadoGanancia = @EstimadoGanancia,
		FechaReserva = @FechaGeneral,
		EstadoPedido = @EstadoPedido,
		ValidacionAbierta = 0,
		ModificaPedidoReservado = 0,
		PedidoSapId = iif(@PedidoSapId = 0, PedidoSapId, @PedidoSapId),
		VersionProl = @VersionProl
	where CampaniaID = @CampaniaID AND PedidoID = @PedidoID;
end
GO