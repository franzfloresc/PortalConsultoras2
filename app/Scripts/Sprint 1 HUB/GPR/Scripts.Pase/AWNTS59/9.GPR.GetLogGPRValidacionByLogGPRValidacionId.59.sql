USE BelcorpColombia
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[GetLogGPRValidacionByLogGPRValidacionId]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].[GetLogGPRValidacionByLogGPRValidacionId]
GO

CREATE PROCEDURE GPR.GetLogGPRValidacionByLogGPRValidacionId
	@LogGPRValidacionId BIGINT
AS

BEGIN		

	SELECT
		LGPRV.LogGPRValidacionId,
		LGPRV.DescripcionRechazo,
		PR.Campania,
		LGPRV.ConsultoraID,
		LGPRV.CodigoUsuario,
		LGPRV.ZonaNuevoProl,
		LGPRV.PedidoID,
		LGPRV.SubTotal,
		LGPRV.Descuento,
		LGPRV.EstadoSimplificacionCUV,
		LGPRV.FechaFinValidacion,
		PR.MotivoRechazo,
		PR.Valor
	FROM GPR.LogGPRValidacion LGPRV
	INNER JOIN GPR.PedidoRechazado PR ON PR.IdPedidoRechazado = LGPRV.IdPedidoRechazado
	WHERE LogGPRValidacionId = @LogGPRValidacionId;

END

GO

----

USE BelcorpMexico
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[GetLogGPRValidacionByLogGPRValidacionId]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].[GetLogGPRValidacionByLogGPRValidacionId]
GO

CREATE PROCEDURE GPR.GetLogGPRValidacionByLogGPRValidacionId
	@LogGPRValidacionId BIGINT
AS

BEGIN		

	SELECT
		LGPRV.LogGPRValidacionId,
		LGPRV.DescripcionRechazo,
		PR.Campania,
		LGPRV.ConsultoraID,
		LGPRV.CodigoUsuario,
		LGPRV.ZonaNuevoProl,
		LGPRV.PedidoID,
		LGPRV.SubTotal,
		LGPRV.Descuento,
		LGPRV.EstadoSimplificacionCUV,
		LGPRV.FechaFinValidacion,
		PR.MotivoRechazo,
		PR.Valor
	FROM GPR.LogGPRValidacion LGPRV
	INNER JOIN GPR.PedidoRechazado PR ON PR.IdPedidoRechazado = LGPRV.IdPedidoRechazado
	WHERE LogGPRValidacionId = @LogGPRValidacionId;

END

GO

----

USE BelcorpPeru
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[GetLogGPRValidacionByLogGPRValidacionId]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].[GetLogGPRValidacionByLogGPRValidacionId]
GO

CREATE PROCEDURE GPR.GetLogGPRValidacionByLogGPRValidacionId
	@LogGPRValidacionId BIGINT
AS

BEGIN		

	SELECT
		LGPRV.LogGPRValidacionId,
		LGPRV.DescripcionRechazo,
		PR.Campania,
		LGPRV.ConsultoraID,
		LGPRV.CodigoUsuario,
		LGPRV.ZonaNuevoProl,
		LGPRV.PedidoID,
		LGPRV.SubTotal,
		LGPRV.Descuento,
		LGPRV.EstadoSimplificacionCUV,
		LGPRV.FechaFinValidacion,
		PR.MotivoRechazo,
		PR.Valor
	FROM GPR.LogGPRValidacion LGPRV
	INNER JOIN GPR.PedidoRechazado PR ON PR.IdPedidoRechazado = LGPRV.IdPedidoRechazado
	WHERE LogGPRValidacionId = @LogGPRValidacionId;

END

GO


