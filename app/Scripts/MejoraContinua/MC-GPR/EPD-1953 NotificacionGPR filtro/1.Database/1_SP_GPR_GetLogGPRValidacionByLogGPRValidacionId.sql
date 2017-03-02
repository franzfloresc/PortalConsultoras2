USE BelcorpBolivia
go
ALTER PROCEDURE GPR.GetLogGPRValidacionByLogGPRValidacionId
	@ProcesoValidacionPedidoRechazadoID BIGINT,
	@ConsultoraID INT
AS
BEGIN
	SELECT
		LGPRV.LogGPRValidacionId,
		LGPRV.DescripcionRechazo,
		ISNULL(LGPRV.Campania, '201601') AS Campania, 
		LGPRV.ConsultoraID,
		LGPRV.CodigoUsuario,
		LGPRV.ZonaNuevoProl,
		LGPRV.PedidoID,
		LGPRV.SubTotal,
		LGPRV.Descuento,
		LGPRV.EstadoSimplificacionCUV,
		LGPRV.FechaFinValidacion,
		ISNULL(PR.MotivoRechazo, 'ERROR') AS MotivoRechazo,
		PR.Valor,
		LGPRV.ProcesoValidacionPedidoRechazadoID
	FROM GPR.LogGPRValidacion LGPRV	
	INNER JOIN GPR.PedidoRechazado PR ON LGPRV.IdProcesoPedidoRechazado = PR.IdProcesoPedidoRechazado AND PR.CodigoConsultora = LGPRV.CodigoConsultora
	WHERE LGPRV.ProcesoValidacionPedidoRechazadoID = @ProcesoValidacionPedidoRechazadoID AND LGPRV.ConsultoraID = @ConsultoraID;
END
go
/*end*/

USE BelcorpChile
go
ALTER PROCEDURE GPR.GetLogGPRValidacionByLogGPRValidacionId
	@ProcesoValidacionPedidoRechazadoID BIGINT,
	@ConsultoraID INT
AS
BEGIN
	SELECT
		LGPRV.LogGPRValidacionId,
		LGPRV.DescripcionRechazo,
		ISNULL(LGPRV.Campania, '201601') AS Campania, 
		LGPRV.ConsultoraID,
		LGPRV.CodigoUsuario,
		LGPRV.ZonaNuevoProl,
		LGPRV.PedidoID,
		LGPRV.SubTotal,
		LGPRV.Descuento,
		LGPRV.EstadoSimplificacionCUV,
		LGPRV.FechaFinValidacion,
		ISNULL(PR.MotivoRechazo, 'ERROR') AS MotivoRechazo,
		PR.Valor,
		LGPRV.ProcesoValidacionPedidoRechazadoID
	FROM GPR.LogGPRValidacion LGPRV	
	INNER JOIN GPR.PedidoRechazado PR ON LGPRV.IdProcesoPedidoRechazado = PR.IdProcesoPedidoRechazado AND PR.CodigoConsultora = LGPRV.CodigoConsultora
	WHERE LGPRV.ProcesoValidacionPedidoRechazadoID = @ProcesoValidacionPedidoRechazadoID AND LGPRV.ConsultoraID = @ConsultoraID;
END
go
/*end*/

USE BelcorpCostaRica
go
ALTER PROCEDURE GPR.GetLogGPRValidacionByLogGPRValidacionId
	@ProcesoValidacionPedidoRechazadoID BIGINT,
	@ConsultoraID INT
AS
BEGIN
	SELECT
		LGPRV.LogGPRValidacionId,
		LGPRV.DescripcionRechazo,
		ISNULL(LGPRV.Campania, '201601') AS Campania, 
		LGPRV.ConsultoraID,
		LGPRV.CodigoUsuario,
		LGPRV.ZonaNuevoProl,
		LGPRV.PedidoID,
		LGPRV.SubTotal,
		LGPRV.Descuento,
		LGPRV.EstadoSimplificacionCUV,
		LGPRV.FechaFinValidacion,
		ISNULL(PR.MotivoRechazo, 'ERROR') AS MotivoRechazo,
		PR.Valor,
		LGPRV.ProcesoValidacionPedidoRechazadoID
	FROM GPR.LogGPRValidacion LGPRV	
	INNER JOIN GPR.PedidoRechazado PR ON LGPRV.IdProcesoPedidoRechazado = PR.IdProcesoPedidoRechazado AND PR.CodigoConsultora = LGPRV.CodigoConsultora
	WHERE LGPRV.ProcesoValidacionPedidoRechazadoID = @ProcesoValidacionPedidoRechazadoID AND LGPRV.ConsultoraID = @ConsultoraID;
END
go
/*end*/

USE BelcorpDominicana
go
ALTER PROCEDURE GPR.GetLogGPRValidacionByLogGPRValidacionId
	@ProcesoValidacionPedidoRechazadoID BIGINT,
	@ConsultoraID INT
AS
BEGIN
	SELECT
		LGPRV.LogGPRValidacionId,
		LGPRV.DescripcionRechazo,
		ISNULL(LGPRV.Campania, '201601') AS Campania, 
		LGPRV.ConsultoraID,
		LGPRV.CodigoUsuario,
		LGPRV.ZonaNuevoProl,
		LGPRV.PedidoID,
		LGPRV.SubTotal,
		LGPRV.Descuento,
		LGPRV.EstadoSimplificacionCUV,
		LGPRV.FechaFinValidacion,
		ISNULL(PR.MotivoRechazo, 'ERROR') AS MotivoRechazo,
		PR.Valor,
		LGPRV.ProcesoValidacionPedidoRechazadoID
	FROM GPR.LogGPRValidacion LGPRV	
	INNER JOIN GPR.PedidoRechazado PR ON LGPRV.IdProcesoPedidoRechazado = PR.IdProcesoPedidoRechazado AND PR.CodigoConsultora = LGPRV.CodigoConsultora
	WHERE LGPRV.ProcesoValidacionPedidoRechazadoID = @ProcesoValidacionPedidoRechazadoID AND LGPRV.ConsultoraID = @ConsultoraID;
END
go
/*end*/

USE BelcorpEcuador
go
ALTER PROCEDURE GPR.GetLogGPRValidacionByLogGPRValidacionId
	@ProcesoValidacionPedidoRechazadoID BIGINT,
	@ConsultoraID INT
AS
BEGIN
	SELECT
		LGPRV.LogGPRValidacionId,
		LGPRV.DescripcionRechazo,
		ISNULL(LGPRV.Campania, '201601') AS Campania, 
		LGPRV.ConsultoraID,
		LGPRV.CodigoUsuario,
		LGPRV.ZonaNuevoProl,
		LGPRV.PedidoID,
		LGPRV.SubTotal,
		LGPRV.Descuento,
		LGPRV.EstadoSimplificacionCUV,
		LGPRV.FechaFinValidacion,
		ISNULL(PR.MotivoRechazo, 'ERROR') AS MotivoRechazo,
		PR.Valor,
		LGPRV.ProcesoValidacionPedidoRechazadoID
	FROM GPR.LogGPRValidacion LGPRV	
	INNER JOIN GPR.PedidoRechazado PR ON LGPRV.IdProcesoPedidoRechazado = PR.IdProcesoPedidoRechazado AND PR.CodigoConsultora = LGPRV.CodigoConsultora
	WHERE LGPRV.ProcesoValidacionPedidoRechazadoID = @ProcesoValidacionPedidoRechazadoID AND LGPRV.ConsultoraID = @ConsultoraID;
END
go
/*end*/

USE BelcorpGuatemala
go
ALTER PROCEDURE GPR.GetLogGPRValidacionByLogGPRValidacionId
	@ProcesoValidacionPedidoRechazadoID BIGINT,
	@ConsultoraID INT
AS
BEGIN
	SELECT
		LGPRV.LogGPRValidacionId,
		LGPRV.DescripcionRechazo,
		ISNULL(LGPRV.Campania, '201601') AS Campania, 
		LGPRV.ConsultoraID,
		LGPRV.CodigoUsuario,
		LGPRV.ZonaNuevoProl,
		LGPRV.PedidoID,
		LGPRV.SubTotal,
		LGPRV.Descuento,
		LGPRV.EstadoSimplificacionCUV,
		LGPRV.FechaFinValidacion,
		ISNULL(PR.MotivoRechazo, 'ERROR') AS MotivoRechazo,
		PR.Valor,
		LGPRV.ProcesoValidacionPedidoRechazadoID
	FROM GPR.LogGPRValidacion LGPRV	
	INNER JOIN GPR.PedidoRechazado PR ON LGPRV.IdProcesoPedidoRechazado = PR.IdProcesoPedidoRechazado AND PR.CodigoConsultora = LGPRV.CodigoConsultora
	WHERE LGPRV.ProcesoValidacionPedidoRechazadoID = @ProcesoValidacionPedidoRechazadoID AND LGPRV.ConsultoraID = @ConsultoraID;
END
go
/*end*/

USE BelcorpPanama
go
ALTER PROCEDURE GPR.GetLogGPRValidacionByLogGPRValidacionId
	@ProcesoValidacionPedidoRechazadoID BIGINT,
	@ConsultoraID INT
AS
BEGIN
	SELECT
		LGPRV.LogGPRValidacionId,
		LGPRV.DescripcionRechazo,
		ISNULL(LGPRV.Campania, '201601') AS Campania, 
		LGPRV.ConsultoraID,
		LGPRV.CodigoUsuario,
		LGPRV.ZonaNuevoProl,
		LGPRV.PedidoID,
		LGPRV.SubTotal,
		LGPRV.Descuento,
		LGPRV.EstadoSimplificacionCUV,
		LGPRV.FechaFinValidacion,
		ISNULL(PR.MotivoRechazo, 'ERROR') AS MotivoRechazo,
		PR.Valor,
		LGPRV.ProcesoValidacionPedidoRechazadoID
	FROM GPR.LogGPRValidacion LGPRV	
	INNER JOIN GPR.PedidoRechazado PR ON LGPRV.IdProcesoPedidoRechazado = PR.IdProcesoPedidoRechazado AND PR.CodigoConsultora = LGPRV.CodigoConsultora
	WHERE LGPRV.ProcesoValidacionPedidoRechazadoID = @ProcesoValidacionPedidoRechazadoID AND LGPRV.ConsultoraID = @ConsultoraID;
END
go
/*end*/

USE BelcorpPuertoRico
go
ALTER PROCEDURE GPR.GetLogGPRValidacionByLogGPRValidacionId
	@ProcesoValidacionPedidoRechazadoID BIGINT,
	@ConsultoraID INT
AS
BEGIN
	SELECT
		LGPRV.LogGPRValidacionId,
		LGPRV.DescripcionRechazo,
		ISNULL(LGPRV.Campania, '201601') AS Campania, 
		LGPRV.ConsultoraID,
		LGPRV.CodigoUsuario,
		LGPRV.ZonaNuevoProl,
		LGPRV.PedidoID,
		LGPRV.SubTotal,
		LGPRV.Descuento,
		LGPRV.EstadoSimplificacionCUV,
		LGPRV.FechaFinValidacion,
		ISNULL(PR.MotivoRechazo, 'ERROR') AS MotivoRechazo,
		PR.Valor,
		LGPRV.ProcesoValidacionPedidoRechazadoID
	FROM GPR.LogGPRValidacion LGPRV	
	INNER JOIN GPR.PedidoRechazado PR ON LGPRV.IdProcesoPedidoRechazado = PR.IdProcesoPedidoRechazado AND PR.CodigoConsultora = LGPRV.CodigoConsultora
	WHERE LGPRV.ProcesoValidacionPedidoRechazadoID = @ProcesoValidacionPedidoRechazadoID AND LGPRV.ConsultoraID = @ConsultoraID;
END
go
/*end*/

USE BelcorpSalvador
go
ALTER PROCEDURE GPR.GetLogGPRValidacionByLogGPRValidacionId
	@ProcesoValidacionPedidoRechazadoID BIGINT,
	@ConsultoraID INT
AS
BEGIN
	SELECT
		LGPRV.LogGPRValidacionId,
		LGPRV.DescripcionRechazo,
		ISNULL(LGPRV.Campania, '201601') AS Campania, 
		LGPRV.ConsultoraID,
		LGPRV.CodigoUsuario,
		LGPRV.ZonaNuevoProl,
		LGPRV.PedidoID,
		LGPRV.SubTotal,
		LGPRV.Descuento,
		LGPRV.EstadoSimplificacionCUV,
		LGPRV.FechaFinValidacion,
		ISNULL(PR.MotivoRechazo, 'ERROR') AS MotivoRechazo,
		PR.Valor,
		LGPRV.ProcesoValidacionPedidoRechazadoID
	FROM GPR.LogGPRValidacion LGPRV	
	INNER JOIN GPR.PedidoRechazado PR ON LGPRV.IdProcesoPedidoRechazado = PR.IdProcesoPedidoRechazado AND PR.CodigoConsultora = LGPRV.CodigoConsultora
	WHERE LGPRV.ProcesoValidacionPedidoRechazadoID = @ProcesoValidacionPedidoRechazadoID AND LGPRV.ConsultoraID = @ConsultoraID;
END
go
/*end*/

USE BelcorpVenezuela
go
ALTER PROCEDURE GPR.GetLogGPRValidacionByLogGPRValidacionId
	@ProcesoValidacionPedidoRechazadoID BIGINT,
	@ConsultoraID INT
AS
BEGIN
	SELECT
		LGPRV.LogGPRValidacionId,
		LGPRV.DescripcionRechazo,
		ISNULL(LGPRV.Campania, '201601') AS Campania, 
		LGPRV.ConsultoraID,
		LGPRV.CodigoUsuario,
		LGPRV.ZonaNuevoProl,
		LGPRV.PedidoID,
		LGPRV.SubTotal,
		LGPRV.Descuento,
		LGPRV.EstadoSimplificacionCUV,
		LGPRV.FechaFinValidacion,
		ISNULL(PR.MotivoRechazo, 'ERROR') AS MotivoRechazo,
		PR.Valor,
		LGPRV.ProcesoValidacionPedidoRechazadoID
	FROM GPR.LogGPRValidacion LGPRV	
	INNER JOIN GPR.PedidoRechazado PR ON LGPRV.IdProcesoPedidoRechazado = PR.IdProcesoPedidoRechazado AND PR.CodigoConsultora = LGPRV.CodigoConsultora
	WHERE LGPRV.ProcesoValidacionPedidoRechazadoID = @ProcesoValidacionPedidoRechazadoID AND LGPRV.ConsultoraID = @ConsultoraID;
END
go
/*end*/

USE BelcorpColombia
go
ALTER PROCEDURE GPR.GetLogGPRValidacionByLogGPRValidacionId
	@ProcesoValidacionPedidoRechazadoID BIGINT,
	@ConsultoraID INT
AS
BEGIN
	SELECT
		LGPRV.LogGPRValidacionId,
		LGPRV.DescripcionRechazo,
		ISNULL(LGPRV.Campania, '201601') AS Campania, 
		LGPRV.ConsultoraID,
		LGPRV.CodigoUsuario,
		LGPRV.ZonaNuevoProl,
		LGPRV.PedidoID,
		LGPRV.SubTotal,
		LGPRV.Descuento,
		LGPRV.EstadoSimplificacionCUV,
		LGPRV.FechaFinValidacion,
		ISNULL(PR.MotivoRechazo, 'ERROR') AS MotivoRechazo,
		PR.Valor,
		LGPRV.ProcesoValidacionPedidoRechazadoID
	FROM GPR.LogGPRValidacion LGPRV	
	INNER JOIN GPR.PedidoRechazado PR ON LGPRV.IdProcesoPedidoRechazado = PR.IdProcesoPedidoRechazado AND PR.CodigoConsultora = LGPRV.CodigoConsultora
	WHERE LGPRV.ProcesoValidacionPedidoRechazadoID = @ProcesoValidacionPedidoRechazadoID AND LGPRV.ConsultoraID = @ConsultoraID;
END
go
/*end*/

USE BelcorpMexico
go
ALTER PROCEDURE GPR.GetLogGPRValidacionByLogGPRValidacionId
	@ProcesoValidacionPedidoRechazadoID BIGINT,
	@ConsultoraID INT
AS
BEGIN
	SELECT
		LGPRV.LogGPRValidacionId,
		LGPRV.DescripcionRechazo,
		ISNULL(LGPRV.Campania, '201601') AS Campania, 
		LGPRV.ConsultoraID,
		LGPRV.CodigoUsuario,
		LGPRV.ZonaNuevoProl,
		LGPRV.PedidoID,
		LGPRV.SubTotal,
		LGPRV.Descuento,
		LGPRV.EstadoSimplificacionCUV,
		LGPRV.FechaFinValidacion,
		ISNULL(PR.MotivoRechazo, 'ERROR') AS MotivoRechazo,
		PR.Valor,
		LGPRV.ProcesoValidacionPedidoRechazadoID
	FROM GPR.LogGPRValidacion LGPRV	
	INNER JOIN GPR.PedidoRechazado PR ON LGPRV.IdProcesoPedidoRechazado = PR.IdProcesoPedidoRechazado AND PR.CodigoConsultora = LGPRV.CodigoConsultora
	WHERE LGPRV.ProcesoValidacionPedidoRechazadoID = @ProcesoValidacionPedidoRechazadoID AND LGPRV.ConsultoraID = @ConsultoraID;
END
go
/*end*/

USE BelcorpPeru
go
ALTER PROCEDURE GPR.GetLogGPRValidacionByLogGPRValidacionId
	@ProcesoValidacionPedidoRechazadoID BIGINT,
	@ConsultoraID INT
AS
BEGIN
	SELECT
		LGPRV.LogGPRValidacionId,
		LGPRV.DescripcionRechazo,
		ISNULL(LGPRV.Campania, '201601') AS Campania, 
		LGPRV.ConsultoraID,
		LGPRV.CodigoUsuario,
		LGPRV.ZonaNuevoProl,
		LGPRV.PedidoID,
		LGPRV.SubTotal,
		LGPRV.Descuento,
		LGPRV.EstadoSimplificacionCUV,
		LGPRV.FechaFinValidacion,
		ISNULL(PR.MotivoRechazo, 'ERROR') AS MotivoRechazo,
		PR.Valor,
		LGPRV.ProcesoValidacionPedidoRechazadoID
	FROM GPR.LogGPRValidacion LGPRV	
	INNER JOIN GPR.PedidoRechazado PR ON LGPRV.IdProcesoPedidoRechazado = PR.IdProcesoPedidoRechazado AND PR.CodigoConsultora = LGPRV.CodigoConsultora
	WHERE LGPRV.ProcesoValidacionPedidoRechazadoID = @ProcesoValidacionPedidoRechazadoID AND LGPRV.ConsultoraID = @ConsultoraID;
END
go