
USE BelcorpBolivia
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

-----------------------------

USE BelcorpChile
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

-----------------------------

USE BelcorpCostaRica
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

-----------------------------

USE BelcorpDominicana
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

-----------------------------

USE BelcorpEcuador
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

-----------------------------
USE BelcorpGuatemala
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

-----------------------------

USE BelcorpPanama
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

-----------------------------

USE BelcorpPuertoRico
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

-----------------------------
USE BelcorpSalvador
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

-----------------------------

USE BelcorpVenezuela
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

-----------------------------