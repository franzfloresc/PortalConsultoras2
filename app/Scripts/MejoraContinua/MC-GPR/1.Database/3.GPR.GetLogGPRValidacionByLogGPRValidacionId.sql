USE BelcorpPeru
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[GetLogGPRValidacionByLogGPRValidacionId]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].[GetLogGPRValidacionByLogGPRValidacionId]
GO

CREATE PROCEDURE GPR.GetLogGPRValidacionByLogGPRValidacionId

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
	WHERE LGPRV.LogGPRValidacionId = @ProcesoValidacionPedidoRechazadoID AND LGPRV.ConsultoraID = @ConsultoraID;

END

GO

USE BelcorpMexico
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[GetLogGPRValidacionByLogGPRValidacionId]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].[GetLogGPRValidacionByLogGPRValidacionId]
GO

CREATE PROCEDURE GPR.GetLogGPRValidacionByLogGPRValidacionId

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
	WHERE LGPRV.LogGPRValidacionId = @ProcesoValidacionPedidoRechazadoID AND LGPRV.ConsultoraID = @ConsultoraID;

END

GO

USE BelcorpColombia
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[GetLogGPRValidacionByLogGPRValidacionId]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].[GetLogGPRValidacionByLogGPRValidacionId]
GO

CREATE PROCEDURE GPR.GetLogGPRValidacionByLogGPRValidacionId

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
	WHERE LGPRV.LogGPRValidacionId = @ProcesoValidacionPedidoRechazadoID AND LGPRV.ConsultoraID = @ConsultoraID;

END

GO

USE BelcorpVenezuela
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[GetLogGPRValidacionByLogGPRValidacionId]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].[GetLogGPRValidacionByLogGPRValidacionId]
GO

CREATE PROCEDURE GPR.GetLogGPRValidacionByLogGPRValidacionId

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
	WHERE LGPRV.LogGPRValidacionId = @ProcesoValidacionPedidoRechazadoID AND LGPRV.ConsultoraID = @ConsultoraID;

END

GO

USE BelcorpSalvador
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[GetLogGPRValidacionByLogGPRValidacionId]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].[GetLogGPRValidacionByLogGPRValidacionId]
GO

CREATE PROCEDURE GPR.GetLogGPRValidacionByLogGPRValidacionId

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
	WHERE LGPRV.LogGPRValidacionId = @ProcesoValidacionPedidoRechazadoID AND LGPRV.ConsultoraID = @ConsultoraID;

END

GO

USE BelcorpPuertoRico
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[GetLogGPRValidacionByLogGPRValidacionId]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].[GetLogGPRValidacionByLogGPRValidacionId]
GO

CREATE PROCEDURE GPR.GetLogGPRValidacionByLogGPRValidacionId

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
	WHERE LGPRV.LogGPRValidacionId = @ProcesoValidacionPedidoRechazadoID AND LGPRV.ConsultoraID = @ConsultoraID;

END

GO

USE BelcorpPanama
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[GetLogGPRValidacionByLogGPRValidacionId]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].[GetLogGPRValidacionByLogGPRValidacionId]
GO

CREATE PROCEDURE GPR.GetLogGPRValidacionByLogGPRValidacionId

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
	WHERE LGPRV.LogGPRValidacionId = @ProcesoValidacionPedidoRechazadoID AND LGPRV.ConsultoraID = @ConsultoraID;

END

GO

USE BelcorpGuatemala
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[GetLogGPRValidacionByLogGPRValidacionId]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].[GetLogGPRValidacionByLogGPRValidacionId]
GO

CREATE PROCEDURE GPR.GetLogGPRValidacionByLogGPRValidacionId

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
	WHERE LGPRV.LogGPRValidacionId = @ProcesoValidacionPedidoRechazadoID AND LGPRV.ConsultoraID = @ConsultoraID;

END

GO

USE BelcorpEcuador
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[GetLogGPRValidacionByLogGPRValidacionId]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].[GetLogGPRValidacionByLogGPRValidacionId]
GO

CREATE PROCEDURE GPR.GetLogGPRValidacionByLogGPRValidacionId

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
	WHERE LGPRV.LogGPRValidacionId = @ProcesoValidacionPedidoRechazadoID AND LGPRV.ConsultoraID = @ConsultoraID;

END

GO

USE BelcorpDominicana
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[GetLogGPRValidacionByLogGPRValidacionId]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].[GetLogGPRValidacionByLogGPRValidacionId]
GO

CREATE PROCEDURE GPR.GetLogGPRValidacionByLogGPRValidacionId

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
	WHERE LGPRV.LogGPRValidacionId = @ProcesoValidacionPedidoRechazadoID AND LGPRV.ConsultoraID = @ConsultoraID;

END

GO

USE BelcorpCostaRica
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[GetLogGPRValidacionByLogGPRValidacionId]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].[GetLogGPRValidacionByLogGPRValidacionId]
GO

CREATE PROCEDURE GPR.GetLogGPRValidacionByLogGPRValidacionId

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
	WHERE LGPRV.LogGPRValidacionId = @ProcesoValidacionPedidoRechazadoID AND LGPRV.ConsultoraID = @ConsultoraID;

END

GO

USE BelcorpChile
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[GetLogGPRValidacionByLogGPRValidacionId]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].[GetLogGPRValidacionByLogGPRValidacionId]
GO

CREATE PROCEDURE GPR.GetLogGPRValidacionByLogGPRValidacionId

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
	WHERE LGPRV.LogGPRValidacionId = @ProcesoValidacionPedidoRechazadoID AND LGPRV.ConsultoraID = @ConsultoraID;

END

GO

USE BelcorpBolivia
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[GetLogGPRValidacionByLogGPRValidacionId]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].[GetLogGPRValidacionByLogGPRValidacionId]
GO

CREATE PROCEDURE GPR.GetLogGPRValidacionByLogGPRValidacionId

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
	WHERE LGPRV.LogGPRValidacionId = @ProcesoValidacionPedidoRechazadoID AND LGPRV.ConsultoraID = @ConsultoraID;

END

GO

