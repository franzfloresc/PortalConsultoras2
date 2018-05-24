USE BelcorpBolivia
GO
alter procedure GetEstadoPedido
	@CampaniaID int,
	@ConsultoraID bigint
as
select
	EstadoPedido,
	ModificaPedidoReservado,
	ValidacionAbierta,
	GPRSB as IndicadorGPRSB,
	IndicadorEnviado
from PedidoWeb
where CampaniaID = @CampaniaID AND ConsultoraID = @ConsultoraID;
GO
/*end*/

USE BelcorpChile
GO
alter procedure GetEstadoPedido
	@CampaniaID int,
	@ConsultoraID bigint
as
select
	EstadoPedido,
	ModificaPedidoReservado,
	ValidacionAbierta,
	GPRSB as IndicadorGPRSB,
	IndicadorEnviado
from PedidoWeb
where CampaniaID = @CampaniaID AND ConsultoraID = @ConsultoraID;
GO
/*end*/

USE BelcorpColombia
GO
alter procedure GetEstadoPedido
	@CampaniaID int,
	@ConsultoraID bigint
as
select
	EstadoPedido,
	ModificaPedidoReservado,
	ValidacionAbierta,
	GPRSB as IndicadorGPRSB,
	IndicadorEnviado
from PedidoWeb
where CampaniaID = @CampaniaID AND ConsultoraID = @ConsultoraID;
GO
/*end*/

USE BelcorpCostaRica
GO
alter procedure GetEstadoPedido
	@CampaniaID int,
	@ConsultoraID bigint
as
select
	EstadoPedido,
	ModificaPedidoReservado,
	ValidacionAbierta,
	GPRSB as IndicadorGPRSB,
	IndicadorEnviado
from PedidoWeb
where CampaniaID = @CampaniaID AND ConsultoraID = @ConsultoraID;
GO
/*end*/

USE BelcorpDominicana
GO
alter procedure GetEstadoPedido
	@CampaniaID int,
	@ConsultoraID bigint
as
select
	EstadoPedido,
	ModificaPedidoReservado,
	ValidacionAbierta,
	GPRSB as IndicadorGPRSB,
	IndicadorEnviado
from PedidoWeb
where CampaniaID = @CampaniaID AND ConsultoraID = @ConsultoraID;
GO
/*end*/

USE BelcorpEcuador
GO
alter procedure GetEstadoPedido
	@CampaniaID int,
	@ConsultoraID bigint
as
select
	EstadoPedido,
	ModificaPedidoReservado,
	ValidacionAbierta,
	GPRSB as IndicadorGPRSB,
	IndicadorEnviado
from PedidoWeb
where CampaniaID = @CampaniaID AND ConsultoraID = @ConsultoraID;
GO
/*end*/

USE BelcorpGuatemala
GO
alter procedure GetEstadoPedido
	@CampaniaID int,
	@ConsultoraID bigint
as
select
	EstadoPedido,
	ModificaPedidoReservado,
	ValidacionAbierta,
	GPRSB as IndicadorGPRSB,
	IndicadorEnviado
from PedidoWeb
where CampaniaID = @CampaniaID AND ConsultoraID = @ConsultoraID;
GO
/*end*/

USE BelcorpMexico
GO
alter procedure GetEstadoPedido
	@CampaniaID int,
	@ConsultoraID bigint
as
select
	EstadoPedido,
	ModificaPedidoReservado,
	ValidacionAbierta,
	GPRSB as IndicadorGPRSB,
	IndicadorEnviado
from PedidoWeb
where CampaniaID = @CampaniaID AND ConsultoraID = @ConsultoraID;
GO
/*end*/

USE BelcorpPanama
GO
alter procedure GetEstadoPedido
	@CampaniaID int,
	@ConsultoraID bigint
as
select
	EstadoPedido,
	ModificaPedidoReservado,
	ValidacionAbierta,
	GPRSB as IndicadorGPRSB,
	IndicadorEnviado
from PedidoWeb
where CampaniaID = @CampaniaID AND ConsultoraID = @ConsultoraID;
GO
/*end*/

USE BelcorpPeru
GO
alter procedure GetEstadoPedido
	@CampaniaID int,
	@ConsultoraID bigint
as
select
	EstadoPedido,
	ModificaPedidoReservado,
	ValidacionAbierta,
	GPRSB as IndicadorGPRSB,
	IndicadorEnviado
from PedidoWeb
where CampaniaID = @CampaniaID AND ConsultoraID = @ConsultoraID;
GO
/*end*/

USE BelcorpPuertoRico
GO
alter procedure GetEstadoPedido
	@CampaniaID int,
	@ConsultoraID bigint
as
select
	EstadoPedido,
	ModificaPedidoReservado,
	ValidacionAbierta,
	GPRSB as IndicadorGPRSB,
	IndicadorEnviado
from PedidoWeb
where CampaniaID = @CampaniaID AND ConsultoraID = @ConsultoraID;
GO
/*end*/

USE BelcorpSalvador
GO
alter procedure GetEstadoPedido
	@CampaniaID int,
	@ConsultoraID bigint
as
select
	EstadoPedido,
	ModificaPedidoReservado,
	ValidacionAbierta,
	GPRSB as IndicadorGPRSB,
	IndicadorEnviado
from PedidoWeb
where CampaniaID = @CampaniaID AND ConsultoraID = @ConsultoraID;
GO
/*end*/

USE BelcorpVenezuela
GO
alter procedure GetEstadoPedido
	@CampaniaID int,
	@ConsultoraID bigint
as
select
	EstadoPedido,
	ModificaPedidoReservado,
	ValidacionAbierta,
	GPRSB as IndicadorGPRSB,
	IndicadorEnviado
from PedidoWeb
where CampaniaID = @CampaniaID AND ConsultoraID = @ConsultoraID;
GO