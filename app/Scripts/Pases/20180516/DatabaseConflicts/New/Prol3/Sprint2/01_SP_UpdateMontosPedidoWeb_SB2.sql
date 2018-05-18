GO
alter procedure UpdateMontosPedidoWeb_SB2
	@CampaniaID int,
	@ConsultoraID int,
	@MontoAhorroCatalogo money,
	@MontoAhorroRevista money,
	@MontoDescuento money,
	@MontoEscala money,
	@VersionProl tinyint = 0,
	@PedidoSapId bigint = 0
as
begin
	update PedidoWeb 
	set
		MontoAhorroCatalogo = @MontoAhorroCatalogo,
		MontoAhorroRevista = @MontoAhorroRevista,
		DescuentoProl = @MontoDescuento,
		MontoEscala = @MontoEscala,
		VersionProl = iif(@VersionProl = 0, VersionProl, @VersionProl),
		PedidoSapId = iif(@PedidoSapId = 0, PedidoSapId, @PedidoSapId)
	where CampaniaID = @CampaniaID and ConsultoraID = @ConsultoraID;
end
GO