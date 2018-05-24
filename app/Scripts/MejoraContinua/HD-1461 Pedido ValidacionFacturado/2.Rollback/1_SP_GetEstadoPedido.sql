GO
alter procedure GetEstadoPedido
	@CampaniaID int,
	@ConsultoraID bigint
as
select
	EstadoPedido,
	ModificaPedidoReservado,
	ValidacionAbierta,
	GPRSB as IndicadorGPRSB
from PedidoWeb
where CampaniaID = @CampaniaID AND ConsultoraID = @ConsultoraID;
GO