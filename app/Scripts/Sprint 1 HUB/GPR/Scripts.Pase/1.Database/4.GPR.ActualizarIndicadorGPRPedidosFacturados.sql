
USE BelcorpBolivia
go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[ActualizarIndicadorGPRPedidosFacturados]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].[ActualizarIndicadorGPRPedidosFacturados]
GO

CREATE PROCEDURE GPR.ActualizarIndicadorGPRPedidosFacturados
	@ProcesoValidacionPedidoRechazadoId BIGINT
AS
BEGIN
	
DECLARE @FechaAyer DATETIME = dbo.fnObtenerFechaHoraPais() -1
DECLARE @FechaHoy DATETIME = dbo.fnObtenerFechaHoraPais()

	UPDATE	PW
	SET		PW.GPRSB = 0
	FROM	dbo.PedidoWeb AS PW WITH(NOLOCK)
	WHERE	PW.IndicadorEnviado = 1 AND
			PW.FechaProceso between @FechaAyer AND @FechaHoy AND 
			PW.PedidoId NOT IN (SELECT	LGPRV.PedidoID		
								FROM	GPR.LogGPRValidacion LGPRV
								INNER JOIN GPR.PedidoRechazado PR ON LGPRV.IdPedidoRechazado = PR.IdPedidoRechazado
								INNER JOIN GPR.MotivoRechazo MR WITH(NOLOCK) ON PR.MotivoRechazo = MR.Codigo AND MR.RequiereGestion = 1
								WHERE	LGPRV.ProcesoValidacionPedidoRechazadoId = @ProcesoValidacionPedidoRechazadoId
								AND PR.Procesado = 1)
END

GO

USE BelcorpChile
go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[ActualizarIndicadorGPRPedidosFacturados]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].[ActualizarIndicadorGPRPedidosFacturados]
GO

CREATE PROCEDURE GPR.ActualizarIndicadorGPRPedidosFacturados
	@ProcesoValidacionPedidoRechazadoId BIGINT
AS
BEGIN
	
DECLARE @FechaAyer DATETIME = dbo.fnObtenerFechaHoraPais() -1
DECLARE @FechaHoy DATETIME = dbo.fnObtenerFechaHoraPais()

	UPDATE	PW
	SET		PW.GPRSB = 0
	FROM	dbo.PedidoWeb AS PW WITH(NOLOCK)
	WHERE	PW.IndicadorEnviado = 1 AND
			PW.FechaProceso between @FechaAyer AND @FechaHoy AND 
			PW.PedidoId NOT IN (SELECT	LGPRV.PedidoID		
								FROM	GPR.LogGPRValidacion LGPRV
								INNER JOIN GPR.PedidoRechazado PR ON LGPRV.IdPedidoRechazado = PR.IdPedidoRechazado
								INNER JOIN GPR.MotivoRechazo MR WITH(NOLOCK) ON PR.MotivoRechazo = MR.Codigo AND MR.RequiereGestion = 1
								WHERE	LGPRV.ProcesoValidacionPedidoRechazadoId = @ProcesoValidacionPedidoRechazadoId
								AND PR.Procesado = 1)
END


GO

USE BelcorpCostaRica
go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[ActualizarIndicadorGPRPedidosFacturados]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].[ActualizarIndicadorGPRPedidosFacturados]
GO

CREATE PROCEDURE GPR.ActualizarIndicadorGPRPedidosFacturados
	@ProcesoValidacionPedidoRechazadoId BIGINT
AS
BEGIN
	
DECLARE @FechaAyer DATETIME = dbo.fnObtenerFechaHoraPais() -1
DECLARE @FechaHoy DATETIME = dbo.fnObtenerFechaHoraPais()

	UPDATE	PW
	SET		PW.GPRSB = 0
	FROM	dbo.PedidoWeb AS PW WITH(NOLOCK)
	WHERE	PW.IndicadorEnviado = 1 AND
			PW.FechaProceso between @FechaAyer AND @FechaHoy AND 
			PW.PedidoId NOT IN (SELECT	LGPRV.PedidoID		
								FROM	GPR.LogGPRValidacion LGPRV
								INNER JOIN GPR.PedidoRechazado PR ON LGPRV.IdPedidoRechazado = PR.IdPedidoRechazado
								INNER JOIN GPR.MotivoRechazo MR WITH(NOLOCK) ON PR.MotivoRechazo = MR.Codigo AND MR.RequiereGestion = 1
								WHERE	LGPRV.ProcesoValidacionPedidoRechazadoId = @ProcesoValidacionPedidoRechazadoId
								AND PR.Procesado = 1)
END

GO


USE BelcorpDominicana
go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[ActualizarIndicadorGPRPedidosFacturados]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].[ActualizarIndicadorGPRPedidosFacturados]
GO

CREATE PROCEDURE GPR.ActualizarIndicadorGPRPedidosFacturados
	@ProcesoValidacionPedidoRechazadoId BIGINT
AS
BEGIN
	
DECLARE @FechaAyer DATETIME = dbo.fnObtenerFechaHoraPais() -1
DECLARE @FechaHoy DATETIME = dbo.fnObtenerFechaHoraPais()

	UPDATE	PW
	SET		PW.GPRSB = 0
	FROM	dbo.PedidoWeb AS PW WITH(NOLOCK)
	WHERE	PW.IndicadorEnviado = 1 AND
			PW.FechaProceso between @FechaAyer AND @FechaHoy AND 
			PW.PedidoId NOT IN (SELECT	LGPRV.PedidoID		
								FROM	GPR.LogGPRValidacion LGPRV
								INNER JOIN GPR.PedidoRechazado PR ON LGPRV.IdPedidoRechazado = PR.IdPedidoRechazado
								INNER JOIN GPR.MotivoRechazo MR WITH(NOLOCK) ON PR.MotivoRechazo = MR.Codigo AND MR.RequiereGestion = 1
								WHERE	LGPRV.ProcesoValidacionPedidoRechazadoId = @ProcesoValidacionPedidoRechazadoId
								AND PR.Procesado = 1)
END


GO


USE BelcorpEcuador
go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[ActualizarIndicadorGPRPedidosFacturados]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].[ActualizarIndicadorGPRPedidosFacturados]
GO

CREATE PROCEDURE GPR.ActualizarIndicadorGPRPedidosFacturados
	@ProcesoValidacionPedidoRechazadoId BIGINT
AS
BEGIN
	
DECLARE @FechaAyer DATETIME = dbo.fnObtenerFechaHoraPais() -1
DECLARE @FechaHoy DATETIME = dbo.fnObtenerFechaHoraPais()

	UPDATE	PW
	SET		PW.GPRSB = 0
	FROM	dbo.PedidoWeb AS PW WITH(NOLOCK)
	WHERE	PW.IndicadorEnviado = 1 AND
			PW.FechaProceso between @FechaAyer AND @FechaHoy AND 
			PW.PedidoId NOT IN (SELECT	LGPRV.PedidoID		
								FROM	GPR.LogGPRValidacion LGPRV
								INNER JOIN GPR.PedidoRechazado PR ON LGPRV.IdPedidoRechazado = PR.IdPedidoRechazado
								INNER JOIN GPR.MotivoRechazo MR WITH(NOLOCK) ON PR.MotivoRechazo = MR.Codigo AND MR.RequiereGestion = 1
								WHERE	LGPRV.ProcesoValidacionPedidoRechazadoId = @ProcesoValidacionPedidoRechazadoId
								AND PR.Procesado = 1)
END


GO


USE BelcorpGuatemala
go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[ActualizarIndicadorGPRPedidosFacturados]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].[ActualizarIndicadorGPRPedidosFacturados]
GO

CREATE PROCEDURE GPR.ActualizarIndicadorGPRPedidosFacturados
	@ProcesoValidacionPedidoRechazadoId BIGINT
AS
BEGIN
	
DECLARE @FechaAyer DATETIME = dbo.fnObtenerFechaHoraPais() -1
DECLARE @FechaHoy DATETIME = dbo.fnObtenerFechaHoraPais()

	UPDATE	PW
	SET		PW.GPRSB = 0
	FROM	dbo.PedidoWeb AS PW WITH(NOLOCK)
	WHERE	PW.IndicadorEnviado = 1 AND
			PW.FechaProceso between @FechaAyer AND @FechaHoy AND 
			PW.PedidoId NOT IN (SELECT	LGPRV.PedidoID		
								FROM	GPR.LogGPRValidacion LGPRV
								INNER JOIN GPR.PedidoRechazado PR ON LGPRV.IdPedidoRechazado = PR.IdPedidoRechazado
								INNER JOIN GPR.MotivoRechazo MR WITH(NOLOCK) ON PR.MotivoRechazo = MR.Codigo AND MR.RequiereGestion = 1
								WHERE	LGPRV.ProcesoValidacionPedidoRechazadoId = @ProcesoValidacionPedidoRechazadoId
								AND PR.Procesado = 1)
END

GO

USE BelcorpPanama
go


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[ActualizarIndicadorGPRPedidosFacturados]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].[ActualizarIndicadorGPRPedidosFacturados]
GO

CREATE PROCEDURE GPR.ActualizarIndicadorGPRPedidosFacturados
	@ProcesoValidacionPedidoRechazadoId BIGINT
AS
BEGIN
	
DECLARE @FechaAyer DATETIME = dbo.fnObtenerFechaHoraPais() -1
DECLARE @FechaHoy DATETIME = dbo.fnObtenerFechaHoraPais()

	UPDATE	PW
	SET		PW.GPRSB = 0
	FROM	dbo.PedidoWeb AS PW WITH(NOLOCK)
	WHERE	PW.IndicadorEnviado = 1 AND
			PW.FechaProceso between @FechaAyer AND @FechaHoy AND 
			PW.PedidoId NOT IN (SELECT	LGPRV.PedidoID		
								FROM	GPR.LogGPRValidacion LGPRV
								INNER JOIN GPR.PedidoRechazado PR ON LGPRV.IdPedidoRechazado = PR.IdPedidoRechazado
								INNER JOIN GPR.MotivoRechazo MR WITH(NOLOCK) ON PR.MotivoRechazo = MR.Codigo AND MR.RequiereGestion = 1
								WHERE	LGPRV.ProcesoValidacionPedidoRechazadoId = @ProcesoValidacionPedidoRechazadoId
								AND PR.Procesado = 1)
END


GO


USE BelcorpPuertoRico
go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[ActualizarIndicadorGPRPedidosFacturados]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].[ActualizarIndicadorGPRPedidosFacturados]
GO

CREATE PROCEDURE GPR.ActualizarIndicadorGPRPedidosFacturados
	@ProcesoValidacionPedidoRechazadoId BIGINT
AS
BEGIN
	
DECLARE @FechaAyer DATETIME = dbo.fnObtenerFechaHoraPais() -1
DECLARE @FechaHoy DATETIME = dbo.fnObtenerFechaHoraPais()

	UPDATE	PW
	SET		PW.GPRSB = 0
	FROM	dbo.PedidoWeb AS PW WITH(NOLOCK)
	WHERE	PW.IndicadorEnviado = 1 AND
			PW.FechaProceso between @FechaAyer AND @FechaHoy AND 
			PW.PedidoId NOT IN (SELECT	LGPRV.PedidoID		
								FROM	GPR.LogGPRValidacion LGPRV
								INNER JOIN GPR.PedidoRechazado PR ON LGPRV.IdPedidoRechazado = PR.IdPedidoRechazado
								INNER JOIN GPR.MotivoRechazo MR WITH(NOLOCK) ON PR.MotivoRechazo = MR.Codigo AND MR.RequiereGestion = 1
								WHERE	LGPRV.ProcesoValidacionPedidoRechazadoId = @ProcesoValidacionPedidoRechazadoId
								AND PR.Procesado = 1)
END

GO

USE BelcorpSalvador
go


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[ActualizarIndicadorGPRPedidosFacturados]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].[ActualizarIndicadorGPRPedidosFacturados]
GO

CREATE PROCEDURE GPR.ActualizarIndicadorGPRPedidosFacturados
	@ProcesoValidacionPedidoRechazadoId BIGINT
AS
BEGIN
	
DECLARE @FechaAyer DATETIME = dbo.fnObtenerFechaHoraPais() -1
DECLARE @FechaHoy DATETIME = dbo.fnObtenerFechaHoraPais()

	UPDATE	PW
	SET		PW.GPRSB = 0
	FROM	dbo.PedidoWeb AS PW WITH(NOLOCK)
	WHERE	PW.IndicadorEnviado = 1 AND
			PW.FechaProceso between @FechaAyer AND @FechaHoy AND 
			PW.PedidoId NOT IN (SELECT	LGPRV.PedidoID		
								FROM	GPR.LogGPRValidacion LGPRV
								INNER JOIN GPR.PedidoRechazado PR ON LGPRV.IdPedidoRechazado = PR.IdPedidoRechazado
								INNER JOIN GPR.MotivoRechazo MR WITH(NOLOCK) ON PR.MotivoRechazo = MR.Codigo AND MR.RequiereGestion = 1
								WHERE	LGPRV.ProcesoValidacionPedidoRechazadoId = @ProcesoValidacionPedidoRechazadoId
								AND PR.Procesado = 1)
END


GO


USE BelcorpVenezuela
go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[ActualizarIndicadorGPRPedidosFacturados]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].[ActualizarIndicadorGPRPedidosFacturados]
GO

CREATE PROCEDURE GPR.ActualizarIndicadorGPRPedidosFacturados
	@ProcesoValidacionPedidoRechazadoId BIGINT
AS
BEGIN
	
DECLARE @FechaAyer DATETIME = dbo.fnObtenerFechaHoraPais() -1
DECLARE @FechaHoy DATETIME = dbo.fnObtenerFechaHoraPais()

	UPDATE	PW
	SET		PW.GPRSB = 0
	FROM	dbo.PedidoWeb AS PW WITH(NOLOCK)
	WHERE	PW.IndicadorEnviado = 1 AND
			PW.FechaProceso between @FechaAyer AND @FechaHoy AND 
			PW.PedidoId NOT IN (SELECT	LGPRV.PedidoID		
								FROM	GPR.LogGPRValidacion LGPRV
								INNER JOIN GPR.PedidoRechazado PR ON LGPRV.IdPedidoRechazado = PR.IdPedidoRechazado
								INNER JOIN GPR.MotivoRechazo MR WITH(NOLOCK) ON PR.MotivoRechazo = MR.Codigo AND MR.RequiereGestion = 1
								WHERE	LGPRV.ProcesoValidacionPedidoRechazadoId = @ProcesoValidacionPedidoRechazadoId
								AND PR.Procesado = 1)
END


GO

------------------------------------------------------------------------------------------------------------------------

USE BelcorpColombia
go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[ActualizarIndicadorGPRPedidosFacturados]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].[ActualizarIndicadorGPRPedidosFacturados]
GO

CREATE PROCEDURE GPR.ActualizarIndicadorGPRPedidosFacturados
	@ProcesoValidacionPedidoRechazadoId BIGINT
AS
BEGIN
	
DECLARE @FechaAyer DATETIME = dbo.fnObtenerFechaHoraPais() -1
DECLARE @FechaHoy DATETIME = dbo.fnObtenerFechaHoraPais()

	UPDATE	PW
	SET		PW.GPRSB = 0
	FROM	dbo.PedidoWeb AS PW WITH(NOLOCK)
	WHERE	PW.IndicadorEnviado = 1 AND
			PW.FechaProceso between @FechaAyer AND @FechaHoy AND 
			PW.PedidoId NOT IN (SELECT	LGPRV.PedidoID		
								FROM	GPR.LogGPRValidacion LGPRV
								INNER JOIN GPR.PedidoRechazado PR ON LGPRV.IdPedidoRechazado = PR.IdPedidoRechazado
								INNER JOIN GPR.MotivoRechazo MR WITH(NOLOCK) ON PR.MotivoRechazo = MR.Codigo AND MR.RequiereGestion = 1
								WHERE	LGPRV.ProcesoValidacionPedidoRechazadoId = @ProcesoValidacionPedidoRechazadoId
								AND PR.Procesado = 1)
END

GO

USE BelcorpMexico
go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[ActualizarIndicadorGPRPedidosFacturados]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].[ActualizarIndicadorGPRPedidosFacturados]
GO

CREATE PROCEDURE GPR.ActualizarIndicadorGPRPedidosFacturados
	@ProcesoValidacionPedidoRechazadoId BIGINT
AS
BEGIN
	
DECLARE @FechaAyer DATETIME = dbo.fnObtenerFechaHoraPais() -1
DECLARE @FechaHoy DATETIME = dbo.fnObtenerFechaHoraPais()

	UPDATE	PW
	SET		PW.GPRSB = 0
	FROM	dbo.PedidoWeb AS PW WITH(NOLOCK)
	WHERE	PW.IndicadorEnviado = 1 AND
			PW.FechaProceso between @FechaAyer AND @FechaHoy AND 
			PW.PedidoId NOT IN (SELECT	LGPRV.PedidoID		
								FROM	GPR.LogGPRValidacion LGPRV
								INNER JOIN GPR.PedidoRechazado PR ON LGPRV.IdPedidoRechazado = PR.IdPedidoRechazado
								INNER JOIN GPR.MotivoRechazo MR WITH(NOLOCK) ON PR.MotivoRechazo = MR.Codigo AND MR.RequiereGestion = 1
								WHERE	LGPRV.ProcesoValidacionPedidoRechazadoId = @ProcesoValidacionPedidoRechazadoId
								AND PR.Procesado = 1)
END


GO

USE BelcorpPeru
go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[ActualizarIndicadorGPRPedidosFacturados]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].[ActualizarIndicadorGPRPedidosFacturados]
GO

CREATE PROCEDURE GPR.ActualizarIndicadorGPRPedidosFacturados
	@ProcesoValidacionPedidoRechazadoId BIGINT
AS
BEGIN
	
DECLARE @FechaAyer DATETIME = dbo.fnObtenerFechaHoraPais() -1
DECLARE @FechaHoy DATETIME = dbo.fnObtenerFechaHoraPais()

	UPDATE	PW
	SET		PW.GPRSB = 0
	FROM	dbo.PedidoWeb AS PW WITH(NOLOCK)
	WHERE	PW.IndicadorEnviado = 1 AND
			PW.FechaProceso between @FechaAyer AND @FechaHoy AND 
			PW.PedidoId NOT IN (SELECT	LGPRV.PedidoID		
								FROM	GPR.LogGPRValidacion LGPRV
								INNER JOIN GPR.PedidoRechazado PR ON LGPRV.IdPedidoRechazado = PR.IdPedidoRechazado
								INNER JOIN GPR.MotivoRechazo MR WITH(NOLOCK) ON PR.MotivoRechazo = MR.Codigo AND MR.RequiereGestion = 1
								WHERE	LGPRV.ProcesoValidacionPedidoRechazadoId = @ProcesoValidacionPedidoRechazadoId
								AND PR.Procesado = 1)
END

GO

