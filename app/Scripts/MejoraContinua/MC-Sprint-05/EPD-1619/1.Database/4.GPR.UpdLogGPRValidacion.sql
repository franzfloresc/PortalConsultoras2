USE BelcorpPeru
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[UpdLogGPRValidacion]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].[UpdLogGPRValidacion]
GO

CREATE PROCEDURE GPR.UpdLogGPRValidacion
	@LogGPRValidacionId BIGINT,
	@Rechazado BIT,
	@ErrorValidacion VARCHAR(100),
	@ErrorProceso VARCHAR(100),
	@ErrorLog VARCHAR(2000)
AS
BEGIN

	DECLARE @Motivo VARCHAR(50),  @VALOR  VARCHAR(10)
	
	SELECT  
		@Motivo = COALESCE(@Motivo + '- ', '') + PR.CodigoRechazoSomosbelcorp ,
		@VALOR = IIF(PR.MOTIVORECHAZO = 'OCC-19', PR.VALOR, '')
	FROM gpr.pedidorechazado PR
		INNER JOIN GPR.LogGPRValidacion LGPRV ON PR.IdProcesoPedidoRechazado = LGPRV.IdProcesoPedidoRechazado 
		AND PR.CodigoConsultora = LGPRV.CodigoConsultora
	WHERE LGPRV.LogGPRValidacionID = @LogGPRValidacionId
	
	UPDATE GPR.LogGPRValidacion
	SET
		FechaFinValidacion = GETDATE(),
		Rechazado = @Rechazado,
		Valor = @VALOR,
		ErrorValidacion = @ErrorValidacion,
		ErrorProceso = @ErrorProceso,
		ErrorLog = @ErrorLog,
		MotivoRechazo = ISNULL(@Motivo, '')
	WHERE LogGPRValidacionId = @LogGPRValidacionId;
END

GO

USE BelcorpMexico
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[UpdLogGPRValidacion]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].[UpdLogGPRValidacion]
GO

CREATE PROCEDURE GPR.UpdLogGPRValidacion
	@LogGPRValidacionId BIGINT,
	@Rechazado BIT,
	@ErrorValidacion VARCHAR(100),
	@ErrorProceso VARCHAR(100),
	@ErrorLog VARCHAR(2000)
AS
BEGIN

	DECLARE @Motivo VARCHAR(50),  @VALOR  VARCHAR(10)
	
	SELECT  
		@Motivo = COALESCE(@Motivo + '- ', '') + PR.CodigoRechazoSomosbelcorp ,
		@VALOR = IIF(PR.MOTIVORECHAZO = 'OCC-19', PR.VALOR, '')
	FROM gpr.pedidorechazado PR
		INNER JOIN GPR.LogGPRValidacion LGPRV ON PR.IdProcesoPedidoRechazado = LGPRV.IdProcesoPedidoRechazado 
		AND PR.CodigoConsultora = LGPRV.CodigoConsultora
	WHERE LGPRV.LogGPRValidacionID = @LogGPRValidacionId
	
	UPDATE GPR.LogGPRValidacion
	SET
		FechaFinValidacion = GETDATE(),
		Rechazado = @Rechazado,
		Valor = @VALOR,
		ErrorValidacion = @ErrorValidacion,
		ErrorProceso = @ErrorProceso,
		ErrorLog = @ErrorLog,
		MotivoRechazo = ISNULL(@Motivo, '')
	WHERE LogGPRValidacionId = @LogGPRValidacionId;
END

GO

USE BelcorpColombia
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[UpdLogGPRValidacion]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].[UpdLogGPRValidacion]
GO

CREATE PROCEDURE GPR.UpdLogGPRValidacion
	@LogGPRValidacionId BIGINT,
	@Rechazado BIT,
	@ErrorValidacion VARCHAR(100),
	@ErrorProceso VARCHAR(100),
	@ErrorLog VARCHAR(2000)
AS
BEGIN

	DECLARE @Motivo VARCHAR(50),  @VALOR  VARCHAR(10)
	
	SELECT  
		@Motivo = COALESCE(@Motivo + '- ', '') + PR.CodigoRechazoSomosbelcorp ,
		@VALOR = IIF(PR.MOTIVORECHAZO = 'OCC-19', PR.VALOR, '')
	FROM gpr.pedidorechazado PR
		INNER JOIN GPR.LogGPRValidacion LGPRV ON PR.IdProcesoPedidoRechazado = LGPRV.IdProcesoPedidoRechazado 
		AND PR.CodigoConsultora = LGPRV.CodigoConsultora
	WHERE LGPRV.LogGPRValidacionID = @LogGPRValidacionId
	
	UPDATE GPR.LogGPRValidacion
	SET
		FechaFinValidacion = GETDATE(),
		Rechazado = @Rechazado,
		Valor = @VALOR,
		ErrorValidacion = @ErrorValidacion,
		ErrorProceso = @ErrorProceso,
		ErrorLog = @ErrorLog,
		MotivoRechazo = ISNULL(@Motivo, '')
	WHERE LogGPRValidacionId = @LogGPRValidacionId;
END

GO

USE BelcorpVenezuela
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[UpdLogGPRValidacion]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].[UpdLogGPRValidacion]
GO

CREATE PROCEDURE GPR.UpdLogGPRValidacion
	@LogGPRValidacionId BIGINT,
	@Rechazado BIT,
	@ErrorValidacion VARCHAR(100),
	@ErrorProceso VARCHAR(100),
	@ErrorLog VARCHAR(2000)
AS
BEGIN

	DECLARE @Motivo VARCHAR(50),  @VALOR  VARCHAR(10)
	
	SELECT  
		@Motivo = COALESCE(@Motivo + '- ', '') + PR.CodigoRechazoSomosbelcorp ,
		@VALOR = IIF(PR.MOTIVORECHAZO = 'OCC-19', PR.VALOR, '')
	FROM gpr.pedidorechazado PR
		INNER JOIN GPR.LogGPRValidacion LGPRV ON PR.IdProcesoPedidoRechazado = LGPRV.IdProcesoPedidoRechazado 
		AND PR.CodigoConsultora = LGPRV.CodigoConsultora
	WHERE LGPRV.LogGPRValidacionID = @LogGPRValidacionId
	
	UPDATE GPR.LogGPRValidacion
	SET
		FechaFinValidacion = GETDATE(),
		Rechazado = @Rechazado,
		Valor = @VALOR,
		ErrorValidacion = @ErrorValidacion,
		ErrorProceso = @ErrorProceso,
		ErrorLog = @ErrorLog,
		MotivoRechazo = ISNULL(@Motivo, '')
	WHERE LogGPRValidacionId = @LogGPRValidacionId;
END

GO

USE BelcorpSalvador
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[UpdLogGPRValidacion]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].[UpdLogGPRValidacion]
GO

CREATE PROCEDURE GPR.UpdLogGPRValidacion
	@LogGPRValidacionId BIGINT,
	@Rechazado BIT,
	@ErrorValidacion VARCHAR(100),
	@ErrorProceso VARCHAR(100),
	@ErrorLog VARCHAR(2000)
AS
BEGIN

	DECLARE @Motivo VARCHAR(50),  @VALOR  VARCHAR(10)
	
	SELECT  
		@Motivo = COALESCE(@Motivo + '- ', '') + PR.CodigoRechazoSomosbelcorp ,
		@VALOR = IIF(PR.MOTIVORECHAZO = 'OCC-19', PR.VALOR, '')
	FROM gpr.pedidorechazado PR
		INNER JOIN GPR.LogGPRValidacion LGPRV ON PR.IdProcesoPedidoRechazado = LGPRV.IdProcesoPedidoRechazado 
		AND PR.CodigoConsultora = LGPRV.CodigoConsultora
	WHERE LGPRV.LogGPRValidacionID = @LogGPRValidacionId
	
	UPDATE GPR.LogGPRValidacion
	SET
		FechaFinValidacion = GETDATE(),
		Rechazado = @Rechazado,
		Valor = @VALOR,
		ErrorValidacion = @ErrorValidacion,
		ErrorProceso = @ErrorProceso,
		ErrorLog = @ErrorLog,
		MotivoRechazo = ISNULL(@Motivo, '')
	WHERE LogGPRValidacionId = @LogGPRValidacionId;
END

GO

USE BelcorpPuertoRico
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[UpdLogGPRValidacion]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].[UpdLogGPRValidacion]
GO

CREATE PROCEDURE GPR.UpdLogGPRValidacion
	@LogGPRValidacionId BIGINT,
	@Rechazado BIT,
	@ErrorValidacion VARCHAR(100),
	@ErrorProceso VARCHAR(100),
	@ErrorLog VARCHAR(2000)
AS
BEGIN

	DECLARE @Motivo VARCHAR(50),  @VALOR  VARCHAR(10)
	
	SELECT  
		@Motivo = COALESCE(@Motivo + '- ', '') + PR.CodigoRechazoSomosbelcorp ,
		@VALOR = IIF(PR.MOTIVORECHAZO = 'OCC-19', PR.VALOR, '')
	FROM gpr.pedidorechazado PR
		INNER JOIN GPR.LogGPRValidacion LGPRV ON PR.IdProcesoPedidoRechazado = LGPRV.IdProcesoPedidoRechazado 
		AND PR.CodigoConsultora = LGPRV.CodigoConsultora
	WHERE LGPRV.LogGPRValidacionID = @LogGPRValidacionId
	
	UPDATE GPR.LogGPRValidacion
	SET
		FechaFinValidacion = GETDATE(),
		Rechazado = @Rechazado,
		Valor = @VALOR,
		ErrorValidacion = @ErrorValidacion,
		ErrorProceso = @ErrorProceso,
		ErrorLog = @ErrorLog,
		MotivoRechazo = ISNULL(@Motivo, '')
	WHERE LogGPRValidacionId = @LogGPRValidacionId;
END

GO

USE BelcorpPanama
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[UpdLogGPRValidacion]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].[UpdLogGPRValidacion]
GO

CREATE PROCEDURE GPR.UpdLogGPRValidacion
	@LogGPRValidacionId BIGINT,
	@Rechazado BIT,
	@ErrorValidacion VARCHAR(100),
	@ErrorProceso VARCHAR(100),
	@ErrorLog VARCHAR(2000)
AS
BEGIN

	DECLARE @Motivo VARCHAR(50),  @VALOR  VARCHAR(10)
	
	SELECT  
		@Motivo = COALESCE(@Motivo + '- ', '') + PR.CodigoRechazoSomosbelcorp ,
		@VALOR = IIF(PR.MOTIVORECHAZO = 'OCC-19', PR.VALOR, '')
	FROM gpr.pedidorechazado PR
		INNER JOIN GPR.LogGPRValidacion LGPRV ON PR.IdProcesoPedidoRechazado = LGPRV.IdProcesoPedidoRechazado 
		AND PR.CodigoConsultora = LGPRV.CodigoConsultora
	WHERE LGPRV.LogGPRValidacionID = @LogGPRValidacionId
	
	UPDATE GPR.LogGPRValidacion
	SET
		FechaFinValidacion = GETDATE(),
		Rechazado = @Rechazado,
		Valor = @VALOR,
		ErrorValidacion = @ErrorValidacion,
		ErrorProceso = @ErrorProceso,
		ErrorLog = @ErrorLog,
		MotivoRechazo = ISNULL(@Motivo, '')
	WHERE LogGPRValidacionId = @LogGPRValidacionId;
END

GO

USE BelcorpGuatemala
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[UpdLogGPRValidacion]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].[UpdLogGPRValidacion]
GO

CREATE PROCEDURE GPR.UpdLogGPRValidacion
	@LogGPRValidacionId BIGINT,
	@Rechazado BIT,
	@ErrorValidacion VARCHAR(100),
	@ErrorProceso VARCHAR(100),
	@ErrorLog VARCHAR(2000)
AS
BEGIN

	DECLARE @Motivo VARCHAR(50),  @VALOR  VARCHAR(10)
	
	SELECT  
		@Motivo = COALESCE(@Motivo + '- ', '') + PR.CodigoRechazoSomosbelcorp ,
		@VALOR = IIF(PR.MOTIVORECHAZO = 'OCC-19', PR.VALOR, '')
	FROM gpr.pedidorechazado PR
		INNER JOIN GPR.LogGPRValidacion LGPRV ON PR.IdProcesoPedidoRechazado = LGPRV.IdProcesoPedidoRechazado 
		AND PR.CodigoConsultora = LGPRV.CodigoConsultora
	WHERE LGPRV.LogGPRValidacionID = @LogGPRValidacionId
	
	UPDATE GPR.LogGPRValidacion
	SET
		FechaFinValidacion = GETDATE(),
		Rechazado = @Rechazado,
		Valor = @VALOR,
		ErrorValidacion = @ErrorValidacion,
		ErrorProceso = @ErrorProceso,
		ErrorLog = @ErrorLog,
		MotivoRechazo = ISNULL(@Motivo, '')
	WHERE LogGPRValidacionId = @LogGPRValidacionId;
END

GO

USE BelcorpEcuador
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[UpdLogGPRValidacion]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].[UpdLogGPRValidacion]
GO

CREATE PROCEDURE GPR.UpdLogGPRValidacion
	@LogGPRValidacionId BIGINT,
	@Rechazado BIT,
	@ErrorValidacion VARCHAR(100),
	@ErrorProceso VARCHAR(100),
	@ErrorLog VARCHAR(2000)
AS
BEGIN

	DECLARE @Motivo VARCHAR(50),  @VALOR  VARCHAR(10)
	
	SELECT  
		@Motivo = COALESCE(@Motivo + '- ', '') + PR.CodigoRechazoSomosbelcorp ,
		@VALOR = IIF(PR.MOTIVORECHAZO = 'OCC-19', PR.VALOR, '')
	FROM gpr.pedidorechazado PR
		INNER JOIN GPR.LogGPRValidacion LGPRV ON PR.IdProcesoPedidoRechazado = LGPRV.IdProcesoPedidoRechazado 
		AND PR.CodigoConsultora = LGPRV.CodigoConsultora
	WHERE LGPRV.LogGPRValidacionID = @LogGPRValidacionId
	
	UPDATE GPR.LogGPRValidacion
	SET
		FechaFinValidacion = GETDATE(),
		Rechazado = @Rechazado,
		Valor = @VALOR,
		ErrorValidacion = @ErrorValidacion,
		ErrorProceso = @ErrorProceso,
		ErrorLog = @ErrorLog,
		MotivoRechazo = ISNULL(@Motivo, '')
	WHERE LogGPRValidacionId = @LogGPRValidacionId;
END

GO

USE BelcorpDominicana
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[UpdLogGPRValidacion]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].[UpdLogGPRValidacion]
GO

CREATE PROCEDURE GPR.UpdLogGPRValidacion
	@LogGPRValidacionId BIGINT,
	@Rechazado BIT,
	@ErrorValidacion VARCHAR(100),
	@ErrorProceso VARCHAR(100),
	@ErrorLog VARCHAR(2000)
AS
BEGIN

	DECLARE @Motivo VARCHAR(50),  @VALOR  VARCHAR(10)
	
	SELECT  
		@Motivo = COALESCE(@Motivo + '- ', '') + PR.CodigoRechazoSomosbelcorp ,
		@VALOR = IIF(PR.MOTIVORECHAZO = 'OCC-19', PR.VALOR, '')
	FROM gpr.pedidorechazado PR
		INNER JOIN GPR.LogGPRValidacion LGPRV ON PR.IdProcesoPedidoRechazado = LGPRV.IdProcesoPedidoRechazado 
		AND PR.CodigoConsultora = LGPRV.CodigoConsultora
	WHERE LGPRV.LogGPRValidacionID = @LogGPRValidacionId
	
	UPDATE GPR.LogGPRValidacion
	SET
		FechaFinValidacion = GETDATE(),
		Rechazado = @Rechazado,
		Valor = @VALOR,
		ErrorValidacion = @ErrorValidacion,
		ErrorProceso = @ErrorProceso,
		ErrorLog = @ErrorLog,
		MotivoRechazo = ISNULL(@Motivo, '')
	WHERE LogGPRValidacionId = @LogGPRValidacionId;
END

GO

USE BelcorpCostaRica
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[UpdLogGPRValidacion]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].[UpdLogGPRValidacion]
GO

CREATE PROCEDURE GPR.UpdLogGPRValidacion
	@LogGPRValidacionId BIGINT,
	@Rechazado BIT,
	@ErrorValidacion VARCHAR(100),
	@ErrorProceso VARCHAR(100),
	@ErrorLog VARCHAR(2000)
AS
BEGIN

	DECLARE @Motivo VARCHAR(50),  @VALOR  VARCHAR(10)
	
	SELECT  
		@Motivo = COALESCE(@Motivo + '- ', '') + PR.CodigoRechazoSomosbelcorp ,
		@VALOR = IIF(PR.MOTIVORECHAZO = 'OCC-19', PR.VALOR, '')
	FROM gpr.pedidorechazado PR
		INNER JOIN GPR.LogGPRValidacion LGPRV ON PR.IdProcesoPedidoRechazado = LGPRV.IdProcesoPedidoRechazado 
		AND PR.CodigoConsultora = LGPRV.CodigoConsultora
	WHERE LGPRV.LogGPRValidacionID = @LogGPRValidacionId
	
	UPDATE GPR.LogGPRValidacion
	SET
		FechaFinValidacion = GETDATE(),
		Rechazado = @Rechazado,
		Valor = @VALOR,
		ErrorValidacion = @ErrorValidacion,
		ErrorProceso = @ErrorProceso,
		ErrorLog = @ErrorLog,
		MotivoRechazo = ISNULL(@Motivo, '')
	WHERE LogGPRValidacionId = @LogGPRValidacionId;
END

GO

USE BelcorpChile
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[UpdLogGPRValidacion]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].[UpdLogGPRValidacion]
GO

CREATE PROCEDURE GPR.UpdLogGPRValidacion
	@LogGPRValidacionId BIGINT,
	@Rechazado BIT,
	@ErrorValidacion VARCHAR(100),
	@ErrorProceso VARCHAR(100),
	@ErrorLog VARCHAR(2000)
AS
BEGIN

	DECLARE @Motivo VARCHAR(50),  @VALOR  VARCHAR(10)
	
	SELECT  
		@Motivo = COALESCE(@Motivo + '- ', '') + PR.CodigoRechazoSomosbelcorp ,
		@VALOR = IIF(PR.MOTIVORECHAZO = 'OCC-19', PR.VALOR, '')
	FROM gpr.pedidorechazado PR
		INNER JOIN GPR.LogGPRValidacion LGPRV ON PR.IdProcesoPedidoRechazado = LGPRV.IdProcesoPedidoRechazado 
		AND PR.CodigoConsultora = LGPRV.CodigoConsultora
	WHERE LGPRV.LogGPRValidacionID = @LogGPRValidacionId
	
	UPDATE GPR.LogGPRValidacion
	SET
		FechaFinValidacion = GETDATE(),
		Rechazado = @Rechazado,
		Valor = @VALOR,
		ErrorValidacion = @ErrorValidacion,
		ErrorProceso = @ErrorProceso,
		ErrorLog = @ErrorLog,
		MotivoRechazo = ISNULL(@Motivo, '')
	WHERE LogGPRValidacionId = @LogGPRValidacionId;
END

GO

USE BelcorpBolivia
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GPR].[UpdLogGPRValidacion]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [GPR].[UpdLogGPRValidacion]
GO

CREATE PROCEDURE GPR.UpdLogGPRValidacion
	@LogGPRValidacionId BIGINT,
	@Rechazado BIT,
	@ErrorValidacion VARCHAR(100),
	@ErrorProceso VARCHAR(100),
	@ErrorLog VARCHAR(2000)
AS
BEGIN

	DECLARE @Motivo VARCHAR(50),  @VALOR  VARCHAR(10)
	
	SELECT  
		@Motivo = COALESCE(@Motivo + '- ', '') + PR.CodigoRechazoSomosbelcorp ,
		@VALOR = IIF(PR.MOTIVORECHAZO = 'OCC-19', PR.VALOR, '')
	FROM gpr.pedidorechazado PR
		INNER JOIN GPR.LogGPRValidacion LGPRV ON PR.IdProcesoPedidoRechazado = LGPRV.IdProcesoPedidoRechazado 
		AND PR.CodigoConsultora = LGPRV.CodigoConsultora
	WHERE LGPRV.LogGPRValidacionID = @LogGPRValidacionId
	
	UPDATE GPR.LogGPRValidacion
	SET
		FechaFinValidacion = GETDATE(),
		Rechazado = @Rechazado,
		Valor = @VALOR,
		ErrorValidacion = @ErrorValidacion,
		ErrorProceso = @ErrorProceso,
		ErrorLog = @ErrorLog,
		MotivoRechazo = ISNULL(@Motivo, '')
	WHERE LogGPRValidacionId = @LogGPRValidacionId;
END

GO

