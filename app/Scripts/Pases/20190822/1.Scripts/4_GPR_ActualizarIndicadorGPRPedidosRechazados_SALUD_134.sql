USE BelcorpBolivia
GO
ALTER PROCEDURE GPR.ActualizarIndicadorGPRPedidosRechazados
	@Campania int,
	@PedidoId int
AS
BEGIN
	update dbo.PedidoWeb
	set
		IndicadorEnviado = 0, 
		GPRSB = 2,
		EstadoPedido = 201,
		MontoTotalProl = 0,			
		ValidacionAbierta = 0,
		ModificaPedidoReservado = 0
	where CampaniaId = @Campania and PedidoId = @PedidoId;
END
GO

USE BelcorpChile
GO
ALTER PROCEDURE GPR.ActualizarIndicadorGPRPedidosRechazados
	@Campania int,
	@PedidoId int
AS
BEGIN
	update dbo.PedidoWeb
	set
		IndicadorEnviado = 0, 
		GPRSB = 2,
		EstadoPedido = 201,
		MontoTotalProl = 0,			
		ValidacionAbierta = 0,
		ModificaPedidoReservado = 0
	where CampaniaId = @Campania and PedidoId = @PedidoId;
END
GO

USE BelcorpColombia
GO
ALTER PROCEDURE GPR.ActualizarIndicadorGPRPedidosRechazados
	@Campania int,
	@PedidoId int
AS
BEGIN
	update dbo.PedidoWeb
	set
		IndicadorEnviado = 0, 
		GPRSB = 2,
		EstadoPedido = 201,
		MontoTotalProl = 0,			
		ValidacionAbierta = 0,
		ModificaPedidoReservado = 0
	where CampaniaId = @Campania and PedidoId = @PedidoId;
END
GO

USE BelcorpCostaRica
GO
ALTER PROCEDURE GPR.ActualizarIndicadorGPRPedidosRechazados
	@Campania int,
	@PedidoId int
AS
BEGIN
	update dbo.PedidoWeb
	set
		IndicadorEnviado = 0, 
		GPRSB = 2,
		EstadoPedido = 201,
		MontoTotalProl = 0,			
		ValidacionAbierta = 0,
		ModificaPedidoReservado = 0
	where CampaniaId = @Campania and PedidoId = @PedidoId;
END
GO

USE BelcorpDominicana
GO
ALTER PROCEDURE GPR.ActualizarIndicadorGPRPedidosRechazados
	@Campania int,
	@PedidoId int
AS
BEGIN
	update dbo.PedidoWeb
	set
		IndicadorEnviado = 0, 
		GPRSB = 2,
		EstadoPedido = 201,
		MontoTotalProl = 0,			
		ValidacionAbierta = 0,
		ModificaPedidoReservado = 0
	where CampaniaId = @Campania and PedidoId = @PedidoId;
END
GO

USE BelcorpEcuador
GO
ALTER PROCEDURE GPR.ActualizarIndicadorGPRPedidosRechazados
	@Campania int,
	@PedidoId int
AS
BEGIN
	update dbo.PedidoWeb
	set
		IndicadorEnviado = 0, 
		GPRSB = 2,
		EstadoPedido = 201,
		MontoTotalProl = 0,			
		ValidacionAbierta = 0,
		ModificaPedidoReservado = 0
	where CampaniaId = @Campania and PedidoId = @PedidoId;
END
GO

USE BelcorpGuatemala
GO
ALTER PROCEDURE GPR.ActualizarIndicadorGPRPedidosRechazados
	@Campania int,
	@PedidoId int
AS
BEGIN
	update dbo.PedidoWeb
	set
		IndicadorEnviado = 0, 
		GPRSB = 2,
		EstadoPedido = 201,
		MontoTotalProl = 0,			
		ValidacionAbierta = 0,
		ModificaPedidoReservado = 0
	where CampaniaId = @Campania and PedidoId = @PedidoId;
END
GO

USE BelcorpMexico
GO
ALTER PROCEDURE GPR.ActualizarIndicadorGPRPedidosRechazados
	@Campania int,
	@PedidoId int
AS
BEGIN
	update dbo.PedidoWeb
	set
		IndicadorEnviado = 0, 
		GPRSB = 2,
		EstadoPedido = 201,
		MontoTotalProl = 0,			
		ValidacionAbierta = 0,
		ModificaPedidoReservado = 0
	where CampaniaId = @Campania and PedidoId = @PedidoId;
END
GO

USE BelcorpPanama
GO
ALTER PROCEDURE GPR.ActualizarIndicadorGPRPedidosRechazados
	@Campania int,
	@PedidoId int
AS
BEGIN
	update dbo.PedidoWeb
	set
		IndicadorEnviado = 0, 
		GPRSB = 2,
		EstadoPedido = 201,
		MontoTotalProl = 0,			
		ValidacionAbierta = 0,
		ModificaPedidoReservado = 0
	where CampaniaId = @Campania and PedidoId = @PedidoId;
END
GO

USE BelcorpPeru
GO
ALTER PROCEDURE GPR.ActualizarIndicadorGPRPedidosRechazados
	@Campania int,
	@PedidoId int
AS
BEGIN
	update dbo.PedidoWeb
	set
		IndicadorEnviado = 0, 
		GPRSB = 2,
		EstadoPedido = 201,
		MontoTotalProl = 0,			
		ValidacionAbierta = 0,
		ModificaPedidoReservado = 0
	where CampaniaId = @Campania and PedidoId = @PedidoId;
END
GO

USE BelcorpPuertoRico
GO
ALTER PROCEDURE GPR.ActualizarIndicadorGPRPedidosRechazados
	@Campania int,
	@PedidoId int
AS
BEGIN
	update dbo.PedidoWeb
	set
		IndicadorEnviado = 0, 
		GPRSB = 2,
		EstadoPedido = 201,
		MontoTotalProl = 0,			
		ValidacionAbierta = 0,
		ModificaPedidoReservado = 0
	where CampaniaId = @Campania and PedidoId = @PedidoId;
END
GO

USE BelcorpSalvador
GO
ALTER PROCEDURE GPR.ActualizarIndicadorGPRPedidosRechazados
	@Campania int,
	@PedidoId int
AS
BEGIN
	update dbo.PedidoWeb
	set
		IndicadorEnviado = 0, 
		GPRSB = 2,
		EstadoPedido = 201,
		MontoTotalProl = 0,			
		ValidacionAbierta = 0,
		ModificaPedidoReservado = 0
	where CampaniaId = @Campania and PedidoId = @PedidoId;
END
GO