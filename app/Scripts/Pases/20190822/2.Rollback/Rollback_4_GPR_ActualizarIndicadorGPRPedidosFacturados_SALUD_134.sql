USE BelcorpBolivia
GO
ALTER PROCEDURE GPR.ActualizarIndicadorGPRPedidosFacturados
	@ProcesoValidacionPedidoRechazadoId BIGINT
AS
BEGIN
	
DECLARE @FechaAyer DATETIME = dbo.fnObtenerFechaHoraPais() -1
DECLARE @FechaHoy DATETIME = dbo.fnObtenerFechaHoraPais()


	UPDATE	PW
	SET		PW.GPRSB = 0
	FROM	dbo.PedidoWeb AS PW WITH(NOLOCK)
	WHERE	    
	NOT EXISTS   (SELECT	LGPRV.PedidoID		
						FROM	GPR.LogGPRValidacion LGPRV
						INNER JOIN GPR.PedidoRechazado PR WITH(NOLOCK) ON LGPRV.CodigoConsultora = PR.CodigoConsultora 
						AND LGPRV.Campania = PR.Campania AND LGPRV.IdProcesoPedidoRechazado = PR.IdProcesoPedidoRechazado
						INNER JOIN GPR.MotivoRechazo MR WITH(NOLOCK) ON PR.MotivoRechazo = MR.Codigo AND MR.RequiereGestion = 1
						WHERE	LGPRV.ProcesoValidacionPedidoRechazadoId = @ProcesoValidacionPedidoRechazadoId AND PW.PedidoId =LGPRV.PedidoID
								AND PR.Procesado = 1) AND
								PW.IndicadorEnviado = 1 AND
	PW.FechaProceso between @FechaAyer AND @FechaHoy  
END
GO

USE BelcorpChile
GO
ALTER PROCEDURE GPR.ActualizarIndicadorGPRPedidosFacturados
	@ProcesoValidacionPedidoRechazadoId BIGINT
AS
BEGIN
	
DECLARE @FechaAyer DATETIME = dbo.fnObtenerFechaHoraPais() -1
DECLARE @FechaHoy DATETIME = dbo.fnObtenerFechaHoraPais()


	UPDATE	PW
	SET		PW.GPRSB = 0
	FROM	dbo.PedidoWeb AS PW WITH(NOLOCK)
	WHERE	    
	NOT EXISTS   (SELECT	LGPRV.PedidoID		
						FROM	GPR.LogGPRValidacion LGPRV
						INNER JOIN GPR.PedidoRechazado PR WITH(NOLOCK) ON LGPRV.CodigoConsultora = PR.CodigoConsultora 
						AND LGPRV.Campania = PR.Campania AND LGPRV.IdProcesoPedidoRechazado = PR.IdProcesoPedidoRechazado
						INNER JOIN GPR.MotivoRechazo MR WITH(NOLOCK) ON PR.MotivoRechazo = MR.Codigo AND MR.RequiereGestion = 1
						WHERE	LGPRV.ProcesoValidacionPedidoRechazadoId = @ProcesoValidacionPedidoRechazadoId AND PW.PedidoId =LGPRV.PedidoID
								AND PR.Procesado = 1) AND
								PW.IndicadorEnviado = 1 AND
	PW.FechaProceso between @FechaAyer AND @FechaHoy  
END
GO

USE BelcorpColombia
GO
ALTER PROCEDURE GPR.ActualizarIndicadorGPRPedidosFacturados
	@ProcesoValidacionPedidoRechazadoId BIGINT
AS
BEGIN
	
DECLARE @FechaAyer DATETIME = dbo.fnObtenerFechaHoraPais() -1
DECLARE @FechaHoy DATETIME = dbo.fnObtenerFechaHoraPais()


	UPDATE	PW
	SET		PW.GPRSB = 0
	FROM	dbo.PedidoWeb AS PW WITH(NOLOCK)
	WHERE	    
	NOT EXISTS   (SELECT	LGPRV.PedidoID		
						FROM	GPR.LogGPRValidacion LGPRV
						INNER JOIN GPR.PedidoRechazado PR WITH(NOLOCK) ON LGPRV.CodigoConsultora = PR.CodigoConsultora 
						AND LGPRV.Campania = PR.Campania AND LGPRV.IdProcesoPedidoRechazado = PR.IdProcesoPedidoRechazado
						INNER JOIN GPR.MotivoRechazo MR WITH(NOLOCK) ON PR.MotivoRechazo = MR.Codigo AND MR.RequiereGestion = 1
						WHERE	LGPRV.ProcesoValidacionPedidoRechazadoId = @ProcesoValidacionPedidoRechazadoId AND PW.PedidoId =LGPRV.PedidoID
								AND PR.Procesado = 1) AND
								PW.IndicadorEnviado = 1 AND
	PW.FechaProceso between @FechaAyer AND @FechaHoy  
END
GO

USE BelcorpCostaRica
GO
ALTER PROCEDURE GPR.ActualizarIndicadorGPRPedidosFacturados
	@ProcesoValidacionPedidoRechazadoId BIGINT
AS
BEGIN
	
DECLARE @FechaAyer DATETIME = dbo.fnObtenerFechaHoraPais() -1
DECLARE @FechaHoy DATETIME = dbo.fnObtenerFechaHoraPais()


	UPDATE	PW
	SET		PW.GPRSB = 0
	FROM	dbo.PedidoWeb AS PW WITH(NOLOCK)
	WHERE	    
	NOT EXISTS   (SELECT	LGPRV.PedidoID		
						FROM	GPR.LogGPRValidacion LGPRV
						INNER JOIN GPR.PedidoRechazado PR WITH(NOLOCK) ON LGPRV.CodigoConsultora = PR.CodigoConsultora 
						AND LGPRV.Campania = PR.Campania AND LGPRV.IdProcesoPedidoRechazado = PR.IdProcesoPedidoRechazado
						INNER JOIN GPR.MotivoRechazo MR WITH(NOLOCK) ON PR.MotivoRechazo = MR.Codigo AND MR.RequiereGestion = 1
						WHERE	LGPRV.ProcesoValidacionPedidoRechazadoId = @ProcesoValidacionPedidoRechazadoId AND PW.PedidoId =LGPRV.PedidoID
								AND PR.Procesado = 1) AND
								PW.IndicadorEnviado = 1 AND
	PW.FechaProceso between @FechaAyer AND @FechaHoy  
END
GO

USE BelcorpDominicana
GO
ALTER PROCEDURE GPR.ActualizarIndicadorGPRPedidosFacturados
	@ProcesoValidacionPedidoRechazadoId BIGINT
AS
BEGIN
	
DECLARE @FechaAyer DATETIME = dbo.fnObtenerFechaHoraPais() -1
DECLARE @FechaHoy DATETIME = dbo.fnObtenerFechaHoraPais()


	UPDATE	PW
	SET		PW.GPRSB = 0
	FROM	dbo.PedidoWeb AS PW WITH(NOLOCK)
	WHERE	    
	NOT EXISTS   (SELECT	LGPRV.PedidoID		
						FROM	GPR.LogGPRValidacion LGPRV
						INNER JOIN GPR.PedidoRechazado PR WITH(NOLOCK) ON LGPRV.CodigoConsultora = PR.CodigoConsultora 
						AND LGPRV.Campania = PR.Campania AND LGPRV.IdProcesoPedidoRechazado = PR.IdProcesoPedidoRechazado
						INNER JOIN GPR.MotivoRechazo MR WITH(NOLOCK) ON PR.MotivoRechazo = MR.Codigo AND MR.RequiereGestion = 1
						WHERE	LGPRV.ProcesoValidacionPedidoRechazadoId = @ProcesoValidacionPedidoRechazadoId AND PW.PedidoId =LGPRV.PedidoID
								AND PR.Procesado = 1) AND
								PW.IndicadorEnviado = 1 AND
	PW.FechaProceso between @FechaAyer AND @FechaHoy  
END
GO

USE BelcorpEcuador
GO
ALTER PROCEDURE GPR.ActualizarIndicadorGPRPedidosFacturados
	@ProcesoValidacionPedidoRechazadoId BIGINT
AS
BEGIN
	
DECLARE @FechaAyer DATETIME = dbo.fnObtenerFechaHoraPais() -1
DECLARE @FechaHoy DATETIME = dbo.fnObtenerFechaHoraPais()


	UPDATE	PW
	SET		PW.GPRSB = 0
	FROM	dbo.PedidoWeb AS PW WITH(NOLOCK)
	WHERE	    
	NOT EXISTS   (SELECT	LGPRV.PedidoID		
						FROM	GPR.LogGPRValidacion LGPRV
						INNER JOIN GPR.PedidoRechazado PR WITH(NOLOCK) ON LGPRV.CodigoConsultora = PR.CodigoConsultora 
						AND LGPRV.Campania = PR.Campania AND LGPRV.IdProcesoPedidoRechazado = PR.IdProcesoPedidoRechazado
						INNER JOIN GPR.MotivoRechazo MR WITH(NOLOCK) ON PR.MotivoRechazo = MR.Codigo AND MR.RequiereGestion = 1
						WHERE	LGPRV.ProcesoValidacionPedidoRechazadoId = @ProcesoValidacionPedidoRechazadoId AND PW.PedidoId =LGPRV.PedidoID
								AND PR.Procesado = 1) AND
								PW.IndicadorEnviado = 1 AND
	PW.FechaProceso between @FechaAyer AND @FechaHoy  
END
GO

USE BelcorpGuatemala
GO
ALTER PROCEDURE GPR.ActualizarIndicadorGPRPedidosFacturados
	@ProcesoValidacionPedidoRechazadoId BIGINT
AS
BEGIN
	
DECLARE @FechaAyer DATETIME = dbo.fnObtenerFechaHoraPais() -1
DECLARE @FechaHoy DATETIME = dbo.fnObtenerFechaHoraPais()


	UPDATE	PW
	SET		PW.GPRSB = 0
	FROM	dbo.PedidoWeb AS PW WITH(NOLOCK)
	WHERE	    
	NOT EXISTS   (SELECT	LGPRV.PedidoID		
						FROM	GPR.LogGPRValidacion LGPRV
						INNER JOIN GPR.PedidoRechazado PR WITH(NOLOCK) ON LGPRV.CodigoConsultora = PR.CodigoConsultora 
						AND LGPRV.Campania = PR.Campania AND LGPRV.IdProcesoPedidoRechazado = PR.IdProcesoPedidoRechazado
						INNER JOIN GPR.MotivoRechazo MR WITH(NOLOCK) ON PR.MotivoRechazo = MR.Codigo AND MR.RequiereGestion = 1
						WHERE	LGPRV.ProcesoValidacionPedidoRechazadoId = @ProcesoValidacionPedidoRechazadoId AND PW.PedidoId =LGPRV.PedidoID
								AND PR.Procesado = 1) AND
								PW.IndicadorEnviado = 1 AND
	PW.FechaProceso between @FechaAyer AND @FechaHoy  
END
GO

USE BelcorpMexico
GO
ALTER PROCEDURE GPR.ActualizarIndicadorGPRPedidosFacturados
	@ProcesoValidacionPedidoRechazadoId BIGINT
AS
BEGIN
	
DECLARE @FechaAyer DATETIME = dbo.fnObtenerFechaHoraPais() -1
DECLARE @FechaHoy DATETIME = dbo.fnObtenerFechaHoraPais()


	UPDATE	PW
	SET		PW.GPRSB = 0
	FROM	dbo.PedidoWeb AS PW WITH(NOLOCK)
	WHERE	    
	NOT EXISTS   (SELECT	LGPRV.PedidoID		
						FROM	GPR.LogGPRValidacion LGPRV
						INNER JOIN GPR.PedidoRechazado PR WITH(NOLOCK) ON LGPRV.CodigoConsultora = PR.CodigoConsultora 
						AND LGPRV.Campania = PR.Campania AND LGPRV.IdProcesoPedidoRechazado = PR.IdProcesoPedidoRechazado
						INNER JOIN GPR.MotivoRechazo MR WITH(NOLOCK) ON PR.MotivoRechazo = MR.Codigo AND MR.RequiereGestion = 1
						WHERE	LGPRV.ProcesoValidacionPedidoRechazadoId = @ProcesoValidacionPedidoRechazadoId AND PW.PedidoId =LGPRV.PedidoID
								AND PR.Procesado = 1) AND
								PW.IndicadorEnviado = 1 AND
	PW.FechaProceso between @FechaAyer AND @FechaHoy  
END
GO

USE BelcorpPanama
GO
ALTER PROCEDURE GPR.ActualizarIndicadorGPRPedidosFacturados
	@ProcesoValidacionPedidoRechazadoId BIGINT
AS
BEGIN
	
DECLARE @FechaAyer DATETIME = dbo.fnObtenerFechaHoraPais() -1
DECLARE @FechaHoy DATETIME = dbo.fnObtenerFechaHoraPais()


	UPDATE	PW
	SET		PW.GPRSB = 0
	FROM	dbo.PedidoWeb AS PW WITH(NOLOCK)
	WHERE	    
	NOT EXISTS   (SELECT	LGPRV.PedidoID		
						FROM	GPR.LogGPRValidacion LGPRV
						INNER JOIN GPR.PedidoRechazado PR WITH(NOLOCK) ON LGPRV.CodigoConsultora = PR.CodigoConsultora 
						AND LGPRV.Campania = PR.Campania AND LGPRV.IdProcesoPedidoRechazado = PR.IdProcesoPedidoRechazado
						INNER JOIN GPR.MotivoRechazo MR WITH(NOLOCK) ON PR.MotivoRechazo = MR.Codigo AND MR.RequiereGestion = 1
						WHERE	LGPRV.ProcesoValidacionPedidoRechazadoId = @ProcesoValidacionPedidoRechazadoId AND PW.PedidoId =LGPRV.PedidoID
								AND PR.Procesado = 1) AND
								PW.IndicadorEnviado = 1 AND
	PW.FechaProceso between @FechaAyer AND @FechaHoy  
END
GO

USE BelcorpPeru
GO
ALTER PROCEDURE GPR.ActualizarIndicadorGPRPedidosFacturados
	@ProcesoValidacionPedidoRechazadoId BIGINT
AS
BEGIN
	
DECLARE @FechaAyer DATETIME = dbo.fnObtenerFechaHoraPais() -1
DECLARE @FechaHoy DATETIME = dbo.fnObtenerFechaHoraPais()


	UPDATE	PW
	SET		PW.GPRSB = 0
	FROM	dbo.PedidoWeb AS PW WITH(NOLOCK)
	WHERE	    
	NOT EXISTS   (SELECT	LGPRV.PedidoID		
						FROM	GPR.LogGPRValidacion LGPRV
						INNER JOIN GPR.PedidoRechazado PR WITH(NOLOCK) ON LGPRV.CodigoConsultora = PR.CodigoConsultora 
						AND LGPRV.Campania = PR.Campania AND LGPRV.IdProcesoPedidoRechazado = PR.IdProcesoPedidoRechazado
						INNER JOIN GPR.MotivoRechazo MR WITH(NOLOCK) ON PR.MotivoRechazo = MR.Codigo AND MR.RequiereGestion = 1
						WHERE	LGPRV.ProcesoValidacionPedidoRechazadoId = @ProcesoValidacionPedidoRechazadoId AND PW.PedidoId =LGPRV.PedidoID
								AND PR.Procesado = 1) AND
								PW.IndicadorEnviado = 1 AND
	PW.FechaProceso between @FechaAyer AND @FechaHoy  
END
GO

USE BelcorpPuertoRico
GO
ALTER PROCEDURE GPR.ActualizarIndicadorGPRPedidosFacturados
	@ProcesoValidacionPedidoRechazadoId BIGINT
AS
BEGIN
	
DECLARE @FechaAyer DATETIME = dbo.fnObtenerFechaHoraPais() -1
DECLARE @FechaHoy DATETIME = dbo.fnObtenerFechaHoraPais()


	UPDATE	PW
	SET		PW.GPRSB = 0
	FROM	dbo.PedidoWeb AS PW WITH(NOLOCK)
	WHERE	    
	NOT EXISTS   (SELECT	LGPRV.PedidoID		
						FROM	GPR.LogGPRValidacion LGPRV
						INNER JOIN GPR.PedidoRechazado PR WITH(NOLOCK) ON LGPRV.CodigoConsultora = PR.CodigoConsultora 
						AND LGPRV.Campania = PR.Campania AND LGPRV.IdProcesoPedidoRechazado = PR.IdProcesoPedidoRechazado
						INNER JOIN GPR.MotivoRechazo MR WITH(NOLOCK) ON PR.MotivoRechazo = MR.Codigo AND MR.RequiereGestion = 1
						WHERE	LGPRV.ProcesoValidacionPedidoRechazadoId = @ProcesoValidacionPedidoRechazadoId AND PW.PedidoId =LGPRV.PedidoID
								AND PR.Procesado = 1) AND
								PW.IndicadorEnviado = 1 AND
	PW.FechaProceso between @FechaAyer AND @FechaHoy  
END
GO

USE BelcorpSalvador
GO
ALTER PROCEDURE GPR.ActualizarIndicadorGPRPedidosFacturados
	@ProcesoValidacionPedidoRechazadoId BIGINT
AS
BEGIN
	
DECLARE @FechaAyer DATETIME = dbo.fnObtenerFechaHoraPais() -1
DECLARE @FechaHoy DATETIME = dbo.fnObtenerFechaHoraPais()


	UPDATE	PW
	SET		PW.GPRSB = 0
	FROM	dbo.PedidoWeb AS PW WITH(NOLOCK)
	WHERE	    
	NOT EXISTS   (SELECT	LGPRV.PedidoID		
						FROM	GPR.LogGPRValidacion LGPRV
						INNER JOIN GPR.PedidoRechazado PR WITH(NOLOCK) ON LGPRV.CodigoConsultora = PR.CodigoConsultora 
						AND LGPRV.Campania = PR.Campania AND LGPRV.IdProcesoPedidoRechazado = PR.IdProcesoPedidoRechazado
						INNER JOIN GPR.MotivoRechazo MR WITH(NOLOCK) ON PR.MotivoRechazo = MR.Codigo AND MR.RequiereGestion = 1
						WHERE	LGPRV.ProcesoValidacionPedidoRechazadoId = @ProcesoValidacionPedidoRechazadoId AND PW.PedidoId =LGPRV.PedidoID
								AND PR.Procesado = 1) AND
								PW.IndicadorEnviado = 1 AND
	PW.FechaProceso between @FechaAyer AND @FechaHoy  
END
GO