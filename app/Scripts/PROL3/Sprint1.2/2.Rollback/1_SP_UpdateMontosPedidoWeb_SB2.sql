GO
alter procedure UpdateMontosPedidoWeb_SB2
	@CampaniaID int,
	@ConsultoraID int,
	@MontoAhorroCatalogo money,
	@MontoAhorroRevista money,
	@MontoDescuento money,
	@MontoEscala money
as
begin
	update PedidoWeb 
	set
		MontoAhorroCatalogo = @MontoAhorroCatalogo,
		MontoAhorroRevista = @MontoAhorroRevista,
		DescuentoProl = @MontoDescuento,
		MontoEscala = @MontoEscala
	where CampaniaID = @CampaniaID and ConsultoraID = @ConsultoraID;
end
GO