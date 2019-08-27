USE BelcorpBolivia
GO
ALTER PROCEDURE GPR.ActualizarIndicadorGPRPedidosRechazados
	@ProcesoValidacionPedidoRechazadoId BIGINT
AS
BEGIN

	/*GPR.Obtener la lista de pedidos no rechazados*/
	SELECT DISTINCT
		CONVERT(INT,PR.Campania) Campania,
		LGPRV.PedidoID
	INTO #ListaPedidoRechazado
	FROM GPR.LogGPRValidacion LGPRV
	INNER JOIN GPR.PedidoRechazado PR WITH(NOLOCK) ON LGPRV.CodigoConsultora = PR.CodigoConsultora 
		AND LGPRV.Campania = PR.Campania AND LGPRV.IdProcesoPedidoRechazado = PR.IdProcesoPedidoRechazado
	INNER JOIN
 GPR.MotivoRechazo MR WITH(NOLOCK) ON PR.MotivoRechazo = MR.Codigo AND MR.RequiereGestion = 1
	WHERE LGPRV.ProcesoValidacionPedidoRechazadoId = @ProcesoValidacionPedidoRechazadoId
		AND PR.Procesado = 1 AND PR.Rechazado = 1 
	
	/*GPR. Actualiza el estado, indicadores, estado y montos de los pedidos rechazados*/
	UPDATE	PW 
	SET		PW.IndicadorEnviado = 0, 
			PW.GPRSB = 2,
			PW.EstadoPedido = 201,
			PW.MontoTotalProl = 0,			
			PW.ValidacionAbierta = 0,
			PW.ModificaPedidoReservado = 0
	FROM	dbo.PedidoWeb AS PW WITH(NOLOCK)
	INNER JOIN #ListaPedidoRechazado PR ON PW.CampaniaID = PR.Campania AND PW.PedidoID = PR.PedidoID

	DROP TABLE #ListaPedidoRechazado
	
END
GO

USE BelcorpChile
GO
ALTER PROCEDURE GPR.ActualizarIndicadorGPRPedidosRechazados
	@ProcesoValidacionPedidoRechazadoId BIGINT
AS
BEGIN

	/*GPR.Obtener la lista de pedidos no rechazados*/
	SELECT DISTINCT
		CONVERT(INT,PR.Campania) Campania,
		LGPRV.PedidoID
	INTO #ListaPedidoRechazado
	FROM GPR.LogGPRValidacion LGPRV
	INNER JOIN GPR.PedidoRechazado PR WITH(NOLOCK) ON LGPRV.CodigoConsultora = PR.CodigoConsultora 
		AND LGPRV.Campania = PR.Campania AND LGPRV.IdProcesoPedidoRechazado = PR.IdProcesoPedidoRechazado
	INNER JOIN
 GPR.MotivoRechazo MR WITH(NOLOCK) ON PR.MotivoRechazo = MR.Codigo AND MR.RequiereGestion = 1
	WHERE LGPRV.ProcesoValidacionPedidoRechazadoId = @ProcesoValidacionPedidoRechazadoId
		AND PR.Procesado = 1 AND PR.Rechazado = 1 
	
	/*GPR. Actualiza el estado, indicadores, estado y montos de los pedidos rechazados*/
	UPDATE	PW 
	SET		PW.IndicadorEnviado = 0, 
			PW.GPRSB = 2,
			PW.EstadoPedido = 201,
			PW.MontoTotalProl = 0,			
			PW.ValidacionAbierta = 0,
			PW.ModificaPedidoReservado = 0
	FROM	dbo.PedidoWeb AS PW WITH(NOLOCK)
	INNER JOIN #ListaPedidoRechazado PR ON PW.CampaniaID = PR.Campania AND PW.PedidoID = PR.PedidoID

	DROP TABLE #ListaPedidoRechazado
	
END
GO

USE BelcorpColombia
GO
ALTER PROCEDURE GPR.ActualizarIndicadorGPRPedidosRechazados
	@ProcesoValidacionPedidoRechazadoId BIGINT
AS
BEGIN

	/*GPR.Obtener la lista de pedidos no rechazados*/
	SELECT DISTINCT
		CONVERT(INT,PR.Campania) Campania,
		LGPRV.PedidoID
	INTO #ListaPedidoRechazado
	FROM GPR.LogGPRValidacion LGPRV
	INNER JOIN GPR.PedidoRechazado PR WITH(NOLOCK) ON LGPRV.CodigoConsultora = PR.CodigoConsultora 
		AND LGPRV.Campania = PR.Campania AND LGPRV.IdProcesoPedidoRechazado = PR.IdProcesoPedidoRechazado
	INNER JOIN
 GPR.MotivoRechazo MR WITH(NOLOCK) ON PR.MotivoRechazo = MR.Codigo AND MR.RequiereGestion = 1
	WHERE LGPRV.ProcesoValidacionPedidoRechazadoId = @ProcesoValidacionPedidoRechazadoId
		AND PR.Procesado = 1 AND PR.Rechazado = 1 
	
	/*GPR. Actualiza el estado, indicadores, estado y montos de los pedidos rechazados*/
	UPDATE	PW 
	SET		PW.IndicadorEnviado = 0, 
			PW.GPRSB = 2,
			PW.EstadoPedido = 201,
			PW.MontoTotalProl = 0,			
			PW.ValidacionAbierta = 0,
			PW.ModificaPedidoReservado = 0
	FROM	dbo.PedidoWeb AS PW WITH(NOLOCK)
	INNER JOIN #ListaPedidoRechazado PR ON PW.CampaniaID = PR.Campania AND PW.PedidoID = PR.PedidoID

	DROP TABLE #ListaPedidoRechazado
	
END
GO

USE BelcorpCostaRica
GO
ALTER PROCEDURE GPR.ActualizarIndicadorGPRPedidosRechazados
	@ProcesoValidacionPedidoRechazadoId BIGINT
AS
BEGIN

	/*GPR.Obtener la lista de pedidos no rechazados*/
	SELECT DISTINCT
		CONVERT(INT,PR.Campania) Campania,
		LGPRV.PedidoID
	INTO #ListaPedidoRechazado
	FROM GPR.LogGPRValidacion LGPRV
	INNER JOIN GPR.PedidoRechazado PR WITH(NOLOCK) ON LGPRV.CodigoConsultora = PR.CodigoConsultora 
		AND LGPRV.Campania = PR.Campania AND LGPRV.IdProcesoPedidoRechazado = PR.IdProcesoPedidoRechazado
	INNER JOIN
 GPR.MotivoRechazo MR WITH(NOLOCK) ON PR.MotivoRechazo = MR.Codigo AND MR.RequiereGestion = 1
	WHERE LGPRV.ProcesoValidacionPedidoRechazadoId = @ProcesoValidacionPedidoRechazadoId
		AND PR.Procesado = 1 AND PR.Rechazado = 1 
	
	/*GPR. Actualiza el estado, indicadores, estado y montos de los pedidos rechazados*/
	UPDATE	PW 
	SET		PW.IndicadorEnviado = 0, 
			PW.GPRSB = 2,
			PW.EstadoPedido = 201,
			PW.MontoTotalProl = 0,			
			PW.ValidacionAbierta = 0,
			PW.ModificaPedidoReservado = 0
	FROM	dbo.PedidoWeb AS PW WITH(NOLOCK)
	INNER JOIN #ListaPedidoRechazado PR ON PW.CampaniaID = PR.Campania AND PW.PedidoID = PR.PedidoID

	DROP TABLE #ListaPedidoRechazado
	
END
GO

USE BelcorpDominicana
GO
ALTER PROCEDURE GPR.ActualizarIndicadorGPRPedidosRechazados
	@ProcesoValidacionPedidoRechazadoId BIGINT
AS
BEGIN

	/*GPR.Obtener la lista de pedidos no rechazados*/
	SELECT DISTINCT
		CONVERT(INT,PR.Campania) Campania,
		LGPRV.PedidoID
	INTO #ListaPedidoRechazado
	FROM GPR.LogGPRValidacion LGPRV
	INNER JOIN GPR.PedidoRechazado PR WITH(NOLOCK) ON LGPRV.CodigoConsultora = PR.CodigoConsultora 
		AND LGPRV.Campania = PR.Campania AND LGPRV.IdProcesoPedidoRechazado = PR.IdProcesoPedidoRechazado
	INNER JOIN
 GPR.MotivoRechazo MR WITH(NOLOCK) ON PR.MotivoRechazo = MR.Codigo AND MR.RequiereGestion = 1
	WHERE LGPRV.ProcesoValidacionPedidoRechazadoId = @ProcesoValidacionPedidoRechazadoId
		AND PR.Procesado = 1 AND PR.Rechazado = 1 
	
	/*GPR. Actualiza el estado, indicadores, estado y montos de los pedidos rechazados*/
	UPDATE	PW 
	SET		PW.IndicadorEnviado = 0, 
			PW.GPRSB = 2,
			PW.EstadoPedido = 201,
			PW.MontoTotalProl = 0,			
			PW.ValidacionAbierta = 0,
			PW.ModificaPedidoReservado = 0
	FROM	dbo.PedidoWeb AS PW WITH(NOLOCK)
	INNER JOIN #ListaPedidoRechazado PR ON PW.CampaniaID = PR.Campania AND PW.PedidoID = PR.PedidoID

	DROP TABLE #ListaPedidoRechazado
	
END
GO

USE BelcorpEcuador
GO
ALTER PROCEDURE GPR.ActualizarIndicadorGPRPedidosRechazados
	@ProcesoValidacionPedidoRechazadoId BIGINT
AS
BEGIN

	/*GPR.Obtener la lista de pedidos no rechazados*/
	SELECT DISTINCT
		CONVERT(INT,PR.Campania) Campania,
		LGPRV.PedidoID
	INTO #ListaPedidoRechazado
	FROM GPR.LogGPRValidacion LGPRV
	INNER JOIN GPR.PedidoRechazado PR WITH(NOLOCK) ON LGPRV.CodigoConsultora = PR.CodigoConsultora 
		AND LGPRV.Campania = PR.Campania AND LGPRV.IdProcesoPedidoRechazado = PR.IdProcesoPedidoRechazado
	INNER JOIN
 GPR.MotivoRechazo MR WITH(NOLOCK) ON PR.MotivoRechazo = MR.Codigo AND MR.RequiereGestion = 1
	WHERE LGPRV.ProcesoValidacionPedidoRechazadoId = @ProcesoValidacionPedidoRechazadoId
		AND PR.Procesado = 1 AND PR.Rechazado = 1 
	
	/*GPR. Actualiza el estado, indicadores, estado y montos de los pedidos rechazados*/
	UPDATE	PW 
	SET		PW.IndicadorEnviado = 0, 
			PW.GPRSB = 2,
			PW.EstadoPedido = 201,
			PW.MontoTotalProl = 0,			
			PW.ValidacionAbierta = 0,
			PW.ModificaPedidoReservado = 0
	FROM	dbo.PedidoWeb AS PW WITH(NOLOCK)
	INNER JOIN #ListaPedidoRechazado PR ON PW.CampaniaID = PR.Campania AND PW.PedidoID = PR.PedidoID

	DROP TABLE #ListaPedidoRechazado
	
END
GO

USE BelcorpGuatemala
GO
ALTER PROCEDURE GPR.ActualizarIndicadorGPRPedidosRechazados
	@ProcesoValidacionPedidoRechazadoId BIGINT
AS
BEGIN

	/*GPR.Obtener la lista de pedidos no rechazados*/
	SELECT DISTINCT
		CONVERT(INT,PR.Campania) Campania,
		LGPRV.PedidoID
	INTO #ListaPedidoRechazado
	FROM GPR.LogGPRValidacion LGPRV
	INNER JOIN GPR.PedidoRechazado PR WITH(NOLOCK) ON LGPRV.CodigoConsultora = PR.CodigoConsultora 
		AND LGPRV.Campania = PR.Campania AND LGPRV.IdProcesoPedidoRechazado = PR.IdProcesoPedidoRechazado
	INNER JOIN
 GPR.MotivoRechazo MR WITH(NOLOCK) ON PR.MotivoRechazo = MR.Codigo AND MR.RequiereGestion = 1
	WHERE LGPRV.ProcesoValidacionPedidoRechazadoId = @ProcesoValidacionPedidoRechazadoId
		AND PR.Procesado = 1 AND PR.Rechazado = 1 
	
	/*GPR. Actualiza el estado, indicadores, estado y montos de los pedidos rechazados*/
	UPDATE	PW 
	SET		PW.IndicadorEnviado = 0, 
			PW.GPRSB = 2,
			PW.EstadoPedido = 201,
			PW.MontoTotalProl = 0,			
			PW.ValidacionAbierta = 0,
			PW.ModificaPedidoReservado = 0
	FROM	dbo.PedidoWeb AS PW WITH(NOLOCK)
	INNER JOIN #ListaPedidoRechazado PR ON PW.CampaniaID = PR.Campania AND PW.PedidoID = PR.PedidoID

	DROP TABLE #ListaPedidoRechazado
	
END
GO

USE BelcorpMexico
GO
ALTER PROCEDURE GPR.ActualizarIndicadorGPRPedidosRechazados
	@ProcesoValidacionPedidoRechazadoId BIGINT
AS
BEGIN

	/*GPR.Obtener la lista de pedidos no rechazados*/
	SELECT DISTINCT
		CONVERT(INT,PR.Campania) Campania,
		LGPRV.PedidoID
	INTO #ListaPedidoRechazado
	FROM GPR.LogGPRValidacion LGPRV
	INNER JOIN GPR.PedidoRechazado PR WITH(NOLOCK) ON LGPRV.CodigoConsultora = PR.CodigoConsultora 
		AND LGPRV.Campania = PR.Campania AND LGPRV.IdProcesoPedidoRechazado = PR.IdProcesoPedidoRechazado
	INNER JOIN
 GPR.MotivoRechazo MR WITH(NOLOCK) ON PR.MotivoRechazo = MR.Codigo AND MR.RequiereGestion = 1
	WHERE LGPRV.ProcesoValidacionPedidoRechazadoId = @ProcesoValidacionPedidoRechazadoId
		AND PR.Procesado = 1 AND PR.Rechazado = 1 
	
	/*GPR. Actualiza el estado, indicadores, estado y montos de los pedidos rechazados*/
	UPDATE	PW 
	SET		PW.IndicadorEnviado = 0, 
			PW.GPRSB = 2,
			PW.EstadoPedido = 201,
			PW.MontoTotalProl = 0,			
			PW.ValidacionAbierta = 0,
			PW.ModificaPedidoReservado = 0
	FROM	dbo.PedidoWeb AS PW WITH(NOLOCK)
	INNER JOIN #ListaPedidoRechazado PR ON PW.CampaniaID = PR.Campania AND PW.PedidoID = PR.PedidoID

	DROP TABLE #ListaPedidoRechazado
	
END
GO

USE BelcorpPanama
GO
ALTER PROCEDURE GPR.ActualizarIndicadorGPRPedidosRechazados
	@ProcesoValidacionPedidoRechazadoId BIGINT
AS
BEGIN

	/*GPR.Obtener la lista de pedidos no rechazados*/
	SELECT DISTINCT
		CONVERT(INT,PR.Campania) Campania,
		LGPRV.PedidoID
	INTO #ListaPedidoRechazado
	FROM GPR.LogGPRValidacion LGPRV
	INNER JOIN GPR.PedidoRechazado PR WITH(NOLOCK) ON LGPRV.CodigoConsultora = PR.CodigoConsultora 
		AND LGPRV.Campania = PR.Campania AND LGPRV.IdProcesoPedidoRechazado = PR.IdProcesoPedidoRechazado
	INNER JOIN
 GPR.MotivoRechazo MR WITH(NOLOCK) ON PR.MotivoRechazo = MR.Codigo AND MR.RequiereGestion = 1
	WHERE LGPRV.ProcesoValidacionPedidoRechazadoId = @ProcesoValidacionPedidoRechazadoId
		AND PR.Procesado = 1 AND PR.Rechazado = 1 
	
	/*GPR. Actualiza el estado, indicadores, estado y montos de los pedidos rechazados*/
	UPDATE	PW 
	SET		PW.IndicadorEnviado = 0, 
			PW.GPRSB = 2,
			PW.EstadoPedido = 201,
			PW.MontoTotalProl = 0,			
			PW.ValidacionAbierta = 0,
			PW.ModificaPedidoReservado = 0
	FROM	dbo.PedidoWeb AS PW WITH(NOLOCK)
	INNER JOIN #ListaPedidoRechazado PR ON PW.CampaniaID = PR.Campania AND PW.PedidoID = PR.PedidoID

	DROP TABLE #ListaPedidoRechazado
	
END
GO

USE BelcorpPeru
GO
ALTER PROCEDURE GPR.ActualizarIndicadorGPRPedidosRechazados
	@ProcesoValidacionPedidoRechazadoId BIGINT
AS
BEGIN

	/*GPR.Obtener la lista de pedidos no rechazados*/
	SELECT DISTINCT
		CONVERT(INT,PR.Campania) Campania,
		LGPRV.PedidoID
	INTO #ListaPedidoRechazado
	FROM GPR.LogGPRValidacion LGPRV
	INNER JOIN GPR.PedidoRechazado PR WITH(NOLOCK) ON LGPRV.CodigoConsultora = PR.CodigoConsultora 
		AND LGPRV.Campania = PR.Campania AND LGPRV.IdProcesoPedidoRechazado = PR.IdProcesoPedidoRechazado
	INNER JOIN
 GPR.MotivoRechazo MR WITH(NOLOCK) ON PR.MotivoRechazo = MR.Codigo AND MR.RequiereGestion = 1
	WHERE LGPRV.ProcesoValidacionPedidoRechazadoId = @ProcesoValidacionPedidoRechazadoId
		AND PR.Procesado = 1 AND PR.Rechazado = 1 
	
	/*GPR. Actualiza el estado, indicadores, estado y montos de los pedidos rechazados*/
	UPDATE	PW 
	SET		PW.IndicadorEnviado = 0, 
			PW.GPRSB = 2,
			PW.EstadoPedido = 201,
			PW.MontoTotalProl = 0,			
			PW.ValidacionAbierta = 0,
			PW.ModificaPedidoReservado = 0
	FROM	dbo.PedidoWeb AS PW WITH(NOLOCK)
	INNER JOIN #ListaPedidoRechazado PR ON PW.CampaniaID = PR.Campania AND PW.PedidoID = PR.PedidoID

	DROP TABLE #ListaPedidoRechazado
	
END
GO

USE BelcorpPuertoRico
GO
ALTER PROCEDURE GPR.ActualizarIndicadorGPRPedidosRechazados
	@ProcesoValidacionPedidoRechazadoId BIGINT
AS
BEGIN

	/*GPR.Obtener la lista de pedidos no rechazados*/
	SELECT DISTINCT
		CONVERT(INT,PR.Campania) Campania,
		LGPRV.PedidoID
	INTO #ListaPedidoRechazado
	FROM GPR.LogGPRValidacion LGPRV
	INNER JOIN GPR.PedidoRechazado PR WITH(NOLOCK) ON LGPRV.CodigoConsultora = PR.CodigoConsultora 
		AND LGPRV.Campania = PR.Campania AND LGPRV.IdProcesoPedidoRechazado = PR.IdProcesoPedidoRechazado
	INNER JOIN
 GPR.MotivoRechazo MR WITH(NOLOCK) ON PR.MotivoRechazo = MR.Codigo AND MR.RequiereGestion = 1
	WHERE LGPRV.ProcesoValidacionPedidoRechazadoId = @ProcesoValidacionPedidoRechazadoId
		AND PR.Procesado = 1 AND PR.Rechazado = 1 
	
	/*GPR. Actualiza el estado, indicadores, estado y montos de los pedidos rechazados*/
	UPDATE	PW 
	SET		PW.IndicadorEnviado = 0, 
			PW.GPRSB = 2,
			PW.EstadoPedido = 201,
			PW.MontoTotalProl = 0,			
			PW.ValidacionAbierta = 0,
			PW.ModificaPedidoReservado = 0
	FROM	dbo.PedidoWeb AS PW WITH(NOLOCK)
	INNER JOIN #ListaPedidoRechazado PR ON PW.CampaniaID = PR.Campania AND PW.PedidoID = PR.PedidoID

	DROP TABLE #ListaPedidoRechazado
	
END
GO

USE BelcorpSalvador
GO
ALTER PROCEDURE GPR.ActualizarIndicadorGPRPedidosRechazados
	@ProcesoValidacionPedidoRechazadoId BIGINT
AS
BEGIN

	/*GPR.Obtener la lista de pedidos no rechazados*/
	SELECT DISTINCT
		CONVERT(INT,PR.Campania) Campania,
		LGPRV.PedidoID
	INTO #ListaPedidoRechazado
	FROM GPR.LogGPRValidacion LGPRV
	INNER JOIN GPR.PedidoRechazado PR WITH(NOLOCK) ON LGPRV.CodigoConsultora = PR.CodigoConsultora 
		AND LGPRV.Campania = PR.Campania AND LGPRV.IdProcesoPedidoRechazado = PR.IdProcesoPedidoRechazado
	INNER JOIN
 GPR.MotivoRechazo MR WITH(NOLOCK) ON PR.MotivoRechazo = MR.Codigo AND MR.RequiereGestion = 1
	WHERE LGPRV.ProcesoValidacionPedidoRechazadoId = @ProcesoValidacionPedidoRechazadoId
		AND PR.Procesado = 1 AND PR.Rechazado = 1 
	
	/*GPR. Actualiza el estado, indicadores, estado y montos de los pedidos rechazados*/
	UPDATE	PW 
	SET		PW.IndicadorEnviado = 0, 
			PW.GPRSB = 2,
			PW.EstadoPedido = 201,
			PW.MontoTotalProl = 0,			
			PW.ValidacionAbierta = 0,
			PW.ModificaPedidoReservado = 0
	FROM	dbo.PedidoWeb AS PW WITH(NOLOCK)
	INNER JOIN #ListaPedidoRechazado PR ON PW.CampaniaID = PR.Campania AND PW.PedidoID = PR.PedidoID

	DROP TABLE #ListaPedidoRechazado
	
END
GO