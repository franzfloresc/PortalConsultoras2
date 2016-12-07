
USE BelcorpColombia
go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[ActualizarIndicadorGPRPedidosRechazados]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].[ActualizarIndicadorGPRPedidosRechazados]
GO

CREATE PROCEDURE GPR.ActualizarIndicadorGPRPedidosRechazados
	@ProcesoValidacionPedidoRechazadoId BIGINT
AS
BEGIN

	/*GPR.Obtener la lista de pedidos no rechazados*/
	SELECT DISTINCT
		PR.Campania,
		LGPRV.PedidoID
	INTO #ListaPedidoRechazado
	FROM GPR.LogGPRValidacion LGPRV
	INNER JOIN GPR.PedidoRechazado PR WITH(NOLOCK) ON LGPRV.IdPedidoRechazado = PR.IdPedidoRechazado
	INNER JOIN GPR.MotivoRechazo MR WITH(NOLOCK) ON PR.MotivoRechazo = MR.Codigo AND MR.RequiereGestion = 1
	WHERE LGPRV.ProcesoValidacionPedidoRechazadoId = @ProcesoValidacionPedidoRechazadoId
		AND PR.Procesado = 1 AND PR.Rechazado = 1 
	
	/*GPR. Actualiza el estado, indicadores, estado y montos de los pedidos rechazados*/
	UPDATE	PW 
	SET		PW.IndicadorEnviado = 0, 
			PW.GPRSB = 2,
			PW.EstadoPedido = 201,
			PW.MontoTotalProl = 0,
			PW.DescuentoProl = 0,
			PW.ValidacionAbierta = 0,
			PW.ModificaPedidoReservado = 0
	FROM	dbo.PedidoWeb AS PW WITH(NOLOCK)
	INNER JOIN #ListaPedidoRechazado PR ON PW.CampaniaID = PR.Campania AND PW.PedidoID = PR.PedidoID

	DROP TABLE #ListaPedidoRechazado
	
END

GO



USE BelcorpPeru
go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[ActualizarIndicadorGPRPedidosRechazados]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].[ActualizarIndicadorGPRPedidosRechazados]
GO

CREATE PROCEDURE GPR.ActualizarIndicadorGPRPedidosRechazados
	@ProcesoValidacionPedidoRechazadoId BIGINT
AS
BEGIN

	/*GPR.Obtener la lista de pedidos no rechazados*/
	SELECT DISTINCT
		PR.Campania,
		LGPRV.PedidoID
	INTO #ListaPedidoRechazado
	FROM GPR.LogGPRValidacion LGPRV
	INNER JOIN GPR.PedidoRechazado PR WITH(NOLOCK) ON LGPRV.IdPedidoRechazado = PR.IdPedidoRechazado
	INNER JOIN GPR.MotivoRechazo MR WITH(NOLOCK) ON PR.MotivoRechazo = MR.Codigo AND MR.RequiereGestion = 1
	WHERE LGPRV.ProcesoValidacionPedidoRechazadoId = @ProcesoValidacionPedidoRechazadoId
		AND PR.Procesado = 1 AND PR.Rechazado = 1 
	
	/*GPR. Actualiza el estado, indicadores, estado y montos de los pedidos rechazados*/
	UPDATE	PW 
	SET		PW.IndicadorEnviado = 0, 
			PW.GPRSB = 2,
			PW.EstadoPedido = 201,
			PW.MontoTotalProl = 0,
			PW.DescuentoProl = 0,
			PW.ValidacionAbierta = 0,
			PW.ModificaPedidoReservado = 0
	FROM	dbo.PedidoWeb AS PW WITH(NOLOCK)
	INNER JOIN #ListaPedidoRechazado PR ON PW.CampaniaID = PR.Campania AND PW.PedidoID = PR.PedidoID

	DROP TABLE #ListaPedidoRechazado
	
END

GO



USE BelcorpMexico
go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[ActualizarIndicadorGPRPedidosRechazados]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].[ActualizarIndicadorGPRPedidosRechazados]
GO

CREATE PROCEDURE GPR.ActualizarIndicadorGPRPedidosRechazados
	@ProcesoValidacionPedidoRechazadoId BIGINT
AS
BEGIN

	/*GPR.Obtener la lista de pedidos no rechazados*/
	SELECT DISTINCT
		PR.Campania,
		LGPRV.PedidoID
	INTO #ListaPedidoRechazado
	FROM GPR.LogGPRValidacion LGPRV
	INNER JOIN GPR.PedidoRechazado PR WITH(NOLOCK) ON LGPRV.IdPedidoRechazado = PR.IdPedidoRechazado
	INNER JOIN GPR.MotivoRechazo MR WITH(NOLOCK) ON PR.MotivoRechazo = MR.Codigo AND MR.RequiereGestion = 1
	WHERE LGPRV.ProcesoValidacionPedidoRechazadoId = @ProcesoValidacionPedidoRechazadoId
		AND PR.Procesado = 1 AND PR.Rechazado = 1 
	
	/*GPR. Actualiza el estado, indicadores, estado y montos de los pedidos rechazados*/
	UPDATE	PW 
	SET		PW.IndicadorEnviado = 0, 
			PW.GPRSB = 2,
			PW.EstadoPedido = 201,
			PW.MontoTotalProl = 0,
			PW.DescuentoProl = 0,
			PW.ValidacionAbierta = 0,
			PW.ModificaPedidoReservado = 0
	FROM	dbo.PedidoWeb AS PW WITH(NOLOCK)
	INNER JOIN #ListaPedidoRechazado PR ON PW.CampaniaID = PR.Campania AND PW.PedidoID = PR.PedidoID

	DROP TABLE #ListaPedidoRechazado
	
END

GO

