USE BelcorpPeru
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'interfaces.UpdLogCDRWeb') 
	AND type in (N'P', N'PC')
) 
DROP PROCEDURE interfaces.UpdLogCDRWeb
GO
CREATE PROCEDURE interfaces.UpdLogCDRWeb
	@LogCDRWebType interfaces.LogCDRWebType readonly
AS
BEGIN

	declare @hoy datetime = (SELECT dbo.fnObtenerFechaHoraPais());

	UPDATE interfaces.LogCDRWeb
	SET
		RespuestaSicc = T.RespuestaSicc,
		EstadoCDR = T.EstadoCDR,
		FechaAtencion = @hoy,
		ConsultoraSaldo = T.ConsultoraSaldo,
		ImporteCDR = T.ImporteCDR,
		Estado = T.Estado,
		ErrorProceso = T.ErrorProceso,
		ErrorLog = T.ErrorLog
	FROM interfaces.LogCDRWeb LCDRW
	INNER JOIN @LogCDRWebType T ON T.LogCDRWebId = LCDRW.LogCDRWebId;
	
	UPDATE dbo.CDRWeb
	SET
		Estado = T.EstadoCDR,
		FechaAtencion = @hoy,
		Importe = T.ImporteCDR
	FROM dbo.CDRWeb CDRW
	INNER JOIN @LogCDRWebType T ON T.CDRWebId = CDRW.CDRWebID AND T.ProcesoFallo = 0;
END
go

USE BelcorpMexico
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'interfaces.UpdLogCDRWeb') 
	AND type in (N'P', N'PC')
) 
DROP PROCEDURE interfaces.UpdLogCDRWeb
GO
CREATE PROCEDURE interfaces.UpdLogCDRWeb
	@LogCDRWebType interfaces.LogCDRWebType readonly
AS
BEGIN

	declare @hoy datetime = (SELECT dbo.fnObtenerFechaHoraPais());

	UPDATE interfaces.LogCDRWeb
	SET
		RespuestaSicc = T.RespuestaSicc,
		EstadoCDR = T.EstadoCDR,
		FechaAtencion = @hoy,
		ConsultoraSaldo = T.ConsultoraSaldo,
		ImporteCDR = T.ImporteCDR,
		Estado = T.Estado,
		ErrorProceso = T.ErrorProceso,
		ErrorLog = T.ErrorLog
	FROM interfaces.LogCDRWeb LCDRW
	INNER JOIN @LogCDRWebType T ON T.LogCDRWebId = LCDRW.LogCDRWebId;
	
	UPDATE dbo.CDRWeb
	SET
		Estado = T.EstadoCDR,
		FechaAtencion = @hoy,
		Importe = T.ImporteCDR
	FROM dbo.CDRWeb CDRW
	INNER JOIN @LogCDRWebType T ON T.CDRWebId = CDRW.CDRWebID AND T.ProcesoFallo = 0;
END
go

USE BelcorpColombia
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'interfaces.UpdLogCDRWeb') 
	AND type in (N'P', N'PC')
) 
DROP PROCEDURE interfaces.UpdLogCDRWeb
GO
CREATE PROCEDURE interfaces.UpdLogCDRWeb
	@LogCDRWebType interfaces.LogCDRWebType readonly
AS
BEGIN

	declare @hoy datetime = (SELECT dbo.fnObtenerFechaHoraPais());

	UPDATE interfaces.LogCDRWeb
	SET
		RespuestaSicc = T.RespuestaSicc,
		EstadoCDR = T.EstadoCDR,
		FechaAtencion = @hoy,
		ConsultoraSaldo = T.ConsultoraSaldo,
		ImporteCDR = T.ImporteCDR,
		Estado = T.Estado,
		ErrorProceso = T.ErrorProceso,
		ErrorLog = T.ErrorLog
	FROM interfaces.LogCDRWeb LCDRW
	INNER JOIN @LogCDRWebType T ON T.LogCDRWebId = LCDRW.LogCDRWebId;
	
	UPDATE dbo.CDRWeb
	SET
		Estado = T.EstadoCDR,
		FechaAtencion = @hoy,
		Importe = T.ImporteCDR
	FROM dbo.CDRWeb CDRW
	INNER JOIN @LogCDRWebType T ON T.CDRWebId = CDRW.CDRWebID AND T.ProcesoFallo = 0;
END
go

USE BelcorpSalvador
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'interfaces.UpdLogCDRWeb') 
	AND type in (N'P', N'PC')
) 
DROP PROCEDURE interfaces.UpdLogCDRWeb
GO
CREATE PROCEDURE interfaces.UpdLogCDRWeb
	@LogCDRWebType interfaces.LogCDRWebType readonly
AS
BEGIN

	declare @hoy datetime = (SELECT dbo.fnObtenerFechaHoraPais());

	UPDATE interfaces.LogCDRWeb
	SET
		RespuestaSicc = T.RespuestaSicc,
		EstadoCDR = T.EstadoCDR,
		FechaAtencion = @hoy,
		ConsultoraSaldo = T.ConsultoraSaldo,
		ImporteCDR = T.ImporteCDR,
		Estado = T.Estado,
		ErrorProceso = T.ErrorProceso,
		ErrorLog = T.ErrorLog
	FROM interfaces.LogCDRWeb LCDRW
	INNER JOIN @LogCDRWebType T ON T.LogCDRWebId = LCDRW.LogCDRWebId;
	
	UPDATE dbo.CDRWeb
	SET
		Estado = T.EstadoCDR,
		FechaAtencion = @hoy,
		Importe = T.ImporteCDR
	FROM dbo.CDRWeb CDRW
	INNER JOIN @LogCDRWebType T ON T.CDRWebId = CDRW.CDRWebID AND T.ProcesoFallo = 0;
END
go

USE BelcorpPuertoRico
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'interfaces.UpdLogCDRWeb') 
	AND type in (N'P', N'PC')
) 
DROP PROCEDURE interfaces.UpdLogCDRWeb
GO
CREATE PROCEDURE interfaces.UpdLogCDRWeb
	@LogCDRWebType interfaces.LogCDRWebType readonly
AS
BEGIN

	declare @hoy datetime = (SELECT dbo.fnObtenerFechaHoraPais());

	UPDATE interfaces.LogCDRWeb
	SET
		RespuestaSicc = T.RespuestaSicc,
		EstadoCDR = T.EstadoCDR,
		FechaAtencion = @hoy,
		ConsultoraSaldo = T.ConsultoraSaldo,
		ImporteCDR = T.ImporteCDR,
		Estado = T.Estado,
		ErrorProceso = T.ErrorProceso,
		ErrorLog = T.ErrorLog
	FROM interfaces.LogCDRWeb LCDRW
	INNER JOIN @LogCDRWebType T ON T.LogCDRWebId = LCDRW.LogCDRWebId;
	
	UPDATE dbo.CDRWeb
	SET
		Estado = T.EstadoCDR,
		FechaAtencion = @hoy,
		Importe = T.ImporteCDR
	FROM dbo.CDRWeb CDRW
	INNER JOIN @LogCDRWebType T ON T.CDRWebId = CDRW.CDRWebID AND T.ProcesoFallo = 0;
END
go

USE BelcorpPanama
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'interfaces.UpdLogCDRWeb') 
	AND type in (N'P', N'PC')
) 
DROP PROCEDURE interfaces.UpdLogCDRWeb
GO
CREATE PROCEDURE interfaces.UpdLogCDRWeb
	@LogCDRWebType interfaces.LogCDRWebType readonly
AS
BEGIN

	declare @hoy datetime = (SELECT dbo.fnObtenerFechaHoraPais());

	UPDATE interfaces.LogCDRWeb
	SET
		RespuestaSicc = T.RespuestaSicc,
		EstadoCDR = T.EstadoCDR,
		FechaAtencion = @hoy,
		ConsultoraSaldo = T.ConsultoraSaldo,
		ImporteCDR = T.ImporteCDR,
		Estado = T.Estado,
		ErrorProceso = T.ErrorProceso,
		ErrorLog = T.ErrorLog
	FROM interfaces.LogCDRWeb LCDRW
	INNER JOIN @LogCDRWebType T ON T.LogCDRWebId = LCDRW.LogCDRWebId;
	
	UPDATE dbo.CDRWeb
	SET
		Estado = T.EstadoCDR,
		FechaAtencion = @hoy,
		Importe = T.ImporteCDR
	FROM dbo.CDRWeb CDRW
	INNER JOIN @LogCDRWebType T ON T.CDRWebId = CDRW.CDRWebID AND T.ProcesoFallo = 0;
END
go

USE BelcorpGuatemala
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'interfaces.UpdLogCDRWeb') 
	AND type in (N'P', N'PC')
) 
DROP PROCEDURE interfaces.UpdLogCDRWeb
GO
CREATE PROCEDURE interfaces.UpdLogCDRWeb
	@LogCDRWebType interfaces.LogCDRWebType readonly
AS
BEGIN

	declare @hoy datetime = (SELECT dbo.fnObtenerFechaHoraPais());

	UPDATE interfaces.LogCDRWeb
	SET
		RespuestaSicc = T.RespuestaSicc,
		EstadoCDR = T.EstadoCDR,
		FechaAtencion = @hoy,
		ConsultoraSaldo = T.ConsultoraSaldo,
		ImporteCDR = T.ImporteCDR,
		Estado = T.Estado,
		ErrorProceso = T.ErrorProceso,
		ErrorLog = T.ErrorLog
	FROM interfaces.LogCDRWeb LCDRW
	INNER JOIN @LogCDRWebType T ON T.LogCDRWebId = LCDRW.LogCDRWebId;
	
	UPDATE dbo.CDRWeb
	SET
		Estado = T.EstadoCDR,
		FechaAtencion = @hoy,
		Importe = T.ImporteCDR
	FROM dbo.CDRWeb CDRW
	INNER JOIN @LogCDRWebType T ON T.CDRWebId = CDRW.CDRWebID AND T.ProcesoFallo = 0;
END
go

USE BelcorpEcuador
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'interfaces.UpdLogCDRWeb') 
	AND type in (N'P', N'PC')
) 
DROP PROCEDURE interfaces.UpdLogCDRWeb
GO
CREATE PROCEDURE interfaces.UpdLogCDRWeb
	@LogCDRWebType interfaces.LogCDRWebType readonly
AS
BEGIN

	declare @hoy datetime = (SELECT dbo.fnObtenerFechaHoraPais());

	UPDATE interfaces.LogCDRWeb
	SET
		RespuestaSicc = T.RespuestaSicc,
		EstadoCDR = T.EstadoCDR,
		FechaAtencion = @hoy,
		ConsultoraSaldo = T.ConsultoraSaldo,
		ImporteCDR = T.ImporteCDR,
		Estado = T.Estado,
		ErrorProceso = T.ErrorProceso,
		ErrorLog = T.ErrorLog
	FROM interfaces.LogCDRWeb LCDRW
	INNER JOIN @LogCDRWebType T ON T.LogCDRWebId = LCDRW.LogCDRWebId;
	
	UPDATE dbo.CDRWeb
	SET
		Estado = T.EstadoCDR,
		FechaAtencion = @hoy,
		Importe = T.ImporteCDR
	FROM dbo.CDRWeb CDRW
	INNER JOIN @LogCDRWebType T ON T.CDRWebId = CDRW.CDRWebID AND T.ProcesoFallo = 0;
END
go

USE BelcorpDominicana
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'interfaces.UpdLogCDRWeb') 
	AND type in (N'P', N'PC')
) 
DROP PROCEDURE interfaces.UpdLogCDRWeb
GO
CREATE PROCEDURE interfaces.UpdLogCDRWeb
	@LogCDRWebType interfaces.LogCDRWebType readonly
AS
BEGIN

	declare @hoy datetime = (SELECT dbo.fnObtenerFechaHoraPais());

	UPDATE interfaces.LogCDRWeb
	SET
		RespuestaSicc = T.RespuestaSicc,
		EstadoCDR = T.EstadoCDR,
		FechaAtencion = @hoy,
		ConsultoraSaldo = T.ConsultoraSaldo,
		ImporteCDR = T.ImporteCDR,
		Estado = T.Estado,
		ErrorProceso = T.ErrorProceso,
		ErrorLog = T.ErrorLog
	FROM interfaces.LogCDRWeb LCDRW
	INNER JOIN @LogCDRWebType T ON T.LogCDRWebId = LCDRW.LogCDRWebId;
	
	UPDATE dbo.CDRWeb
	SET
		Estado = T.EstadoCDR,
		FechaAtencion = @hoy,
		Importe = T.ImporteCDR
	FROM dbo.CDRWeb CDRW
	INNER JOIN @LogCDRWebType T ON T.CDRWebId = CDRW.CDRWebID AND T.ProcesoFallo = 0;
END
go

USE BelcorpCostaRica
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'interfaces.UpdLogCDRWeb') 
	AND type in (N'P', N'PC')
) 
DROP PROCEDURE interfaces.UpdLogCDRWeb
GO
CREATE PROCEDURE interfaces.UpdLogCDRWeb
	@LogCDRWebType interfaces.LogCDRWebType readonly
AS
BEGIN

	declare @hoy datetime = (SELECT dbo.fnObtenerFechaHoraPais());

	UPDATE interfaces.LogCDRWeb
	SET
		RespuestaSicc = T.RespuestaSicc,
		EstadoCDR = T.EstadoCDR,
		FechaAtencion = @hoy,
		ConsultoraSaldo = T.ConsultoraSaldo,
		ImporteCDR = T.ImporteCDR,
		Estado = T.Estado,
		ErrorProceso = T.ErrorProceso,
		ErrorLog = T.ErrorLog
	FROM interfaces.LogCDRWeb LCDRW
	INNER JOIN @LogCDRWebType T ON T.LogCDRWebId = LCDRW.LogCDRWebId;
	
	UPDATE dbo.CDRWeb
	SET
		Estado = T.EstadoCDR,
		FechaAtencion = @hoy,
		Importe = T.ImporteCDR
	FROM dbo.CDRWeb CDRW
	INNER JOIN @LogCDRWebType T ON T.CDRWebId = CDRW.CDRWebID AND T.ProcesoFallo = 0;
END
go

USE BelcorpChile
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'interfaces.UpdLogCDRWeb') 
	AND type in (N'P', N'PC')
) 
DROP PROCEDURE interfaces.UpdLogCDRWeb
GO
CREATE PROCEDURE interfaces.UpdLogCDRWeb
	@LogCDRWebType interfaces.LogCDRWebType readonly
AS
BEGIN

	declare @hoy datetime = (SELECT dbo.fnObtenerFechaHoraPais());

	UPDATE interfaces.LogCDRWeb
	SET
		RespuestaSicc = T.RespuestaSicc,
		EstadoCDR = T.EstadoCDR,
		FechaAtencion = @hoy,
		ConsultoraSaldo = T.ConsultoraSaldo,
		ImporteCDR = T.ImporteCDR,
		Estado = T.Estado,
		ErrorProceso = T.ErrorProceso,
		ErrorLog = T.ErrorLog
	FROM interfaces.LogCDRWeb LCDRW
	INNER JOIN @LogCDRWebType T ON T.LogCDRWebId = LCDRW.LogCDRWebId;
	
	UPDATE dbo.CDRWeb
	SET
		Estado = T.EstadoCDR,
		FechaAtencion = @hoy,
		Importe = T.ImporteCDR
	FROM dbo.CDRWeb CDRW
	INNER JOIN @LogCDRWebType T ON T.CDRWebId = CDRW.CDRWebID AND T.ProcesoFallo = 0;
END
go

USE BelcorpBolivia
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'interfaces.UpdLogCDRWeb') 
	AND type in (N'P', N'PC')
) 
DROP PROCEDURE interfaces.UpdLogCDRWeb
GO
CREATE PROCEDURE interfaces.UpdLogCDRWeb
	@LogCDRWebType interfaces.LogCDRWebType readonly
AS
BEGIN

	declare @hoy datetime = (SELECT dbo.fnObtenerFechaHoraPais());

	UPDATE interfaces.LogCDRWeb
	SET
		RespuestaSicc = T.RespuestaSicc,
		EstadoCDR = T.EstadoCDR,
		FechaAtencion = @hoy,
		ConsultoraSaldo = T.ConsultoraSaldo,
		ImporteCDR = T.ImporteCDR,
		Estado = T.Estado,
		ErrorProceso = T.ErrorProceso,
		ErrorLog = T.ErrorLog
	FROM interfaces.LogCDRWeb LCDRW
	INNER JOIN @LogCDRWebType T ON T.LogCDRWebId = LCDRW.LogCDRWebId;
	
	UPDATE dbo.CDRWeb
	SET
		Estado = T.EstadoCDR,
		FechaAtencion = @hoy,
		Importe = T.ImporteCDR
	FROM dbo.CDRWeb CDRW
	INNER JOIN @LogCDRWebType T ON T.CDRWebId = CDRW.CDRWebID AND T.ProcesoFallo = 0;
END
go