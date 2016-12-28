USE BelcorpChile
go

IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'ProcesoAutomaticoConfiguracion' AND TABLE_SCHEMA = 'interfaces')
BEGIN
    DROP TABLE interfaces.ProcesoAutomaticoConfiguracion
END
GO
CREATE TABLE interfaces.ProcesoAutomaticoConfiguracion(
	ProcesoAutomaticoConfiguracionId INT IDENTITY(1,1) PRIMARY KEY,
	CodigoProceso VARCHAR(9) NOT NULL,
	Activo BIT NOT NULL,
	RestriccionEjecucion BIT NOT NULL,
	HoraInicioRestriccion TIME(0) NULL,
	HoraFinRestriccion TIME(0) NULL,
	EnvioCorreoTodo BIT NOT NULL,
	EnvioCorreoError BIT NOT NULL,
	CreacionLog BIT NULL,
	ServiceEndPoint VARCHAR(200) NULL,
	CreacionAutomaticaConsultora BIT NULL
)
GO

IF NOT EXISTS(SELECT 1 FROM interfaces.ProcesoAutomaticoConfiguracion WHERE CodigoProceso = 'CDR-VALID')
BEGIN
	INSERT interfaces.ProcesoAutomaticoConfiguracion(CodigoProceso,Activo,RestriccionEjecucion,HoraInicioRestriccion,HoraFinRestriccion,EnvioCorreoTodo,EnvioCorreoError,ServiceEndPoint)
	VALUES ('CDR-VALID',1,1,'08:00:00','20:00:00',0,1,'')
END
GO
IF NOT EXISTS(SELECT 1 FROM interfaces.ProcesoAutomaticoConfiguracion WHERE CodigoProceso = 'CDR-EMAIL')
BEGIN
	INSERT interfaces.ProcesoAutomaticoConfiguracion(CodigoProceso,Activo,RestriccionEjecucion,HoraInicioRestriccion,HoraFinRestriccion,EnvioCorreoTodo,EnvioCorreoError,ServiceEndPoint)
	VALUES ('CDR-EMAIL',1,1,'08:00:00','20:00:00',0,0,NULL)
END
GO

IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetProcesoAutomaticoConfiguracionByCodigoProceso' AND SPECIFIC_SCHEMA = 'interfaces' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE interfaces.GetProcesoAutomaticoConfiguracionByCodigoProceso
END
GO
CREATE PROCEDURE interfaces.GetProcesoAutomaticoConfiguracionByCodigoProceso
	@CodigoProceso varchar(9)
AS
BEGIN
	SELECT TOP 1
		ProcesoAutomaticoConfiguracionId,
		CodigoProceso,
		CASE
			WHEN Activo = 0 THEN 0
			WHEN RestriccionEjecucion = 0 THEN 1
			WHEN CAST(dbo.fnObtenerFechaHoraPais() AS TIME) BETWEEN HoraInicioRestriccion AND HoraFinRestriccion THEN 1
			ELSE 0
		END AS PuedeEjecutarse,
		EnvioCorreoTodo,
		EnvioCorreoError,
		CreacionLog,
		ServiceEndPoint,
		CreacionAutomaticaConsultora
	FROM interfaces.ProcesoAutomaticoConfiguracion
	WHERE CodigoProceso = @CodigoProceso
END
GO

IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME  = 'ProcesoAutomatico' AND TABLE_SCHEMA = 'interfaces')
BEGIN
    DROP TABLE interfaces.ProcesoAutomatico
END
GO
CREATE TABLE interfaces.ProcesoAutomatico(
	ProcesoAutomaticoId BIGINT IDENTITY(1,1) PRIMARY KEY,
	CodigoProceso VARCHAR(9) NOT NULL,
	FechaHoraInicio DATETIME NOT NULL,
	FechaHoraFin DATETIME NULL,
	Estado TINYINT NOT NULL,
	ErrorProceso VARCHAR(1000) NULL,
	ErrorLog VARCHAR(2000) NULL
)
GO

IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetLastProcesoAutomaticoByCodigoProceso' AND SPECIFIC_SCHEMA = 'interfaces' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE interfaces.GetLastProcesoAutomaticoByCodigoProceso
END
GO
CREATE PROCEDURE interfaces.GetLastProcesoAutomaticoByCodigoProceso
	@CodigoProceso varchar(20)
AS
BEGIN
	SELECT TOP 1
		ProcesoAutomaticoId,
		CodigoProceso,
		Estado
	FROM interfaces.ProcesoAutomatico (NOLOCK)
	WHERE CodigoProceso = @CodigoProceso
	ORDER BY ProcesoAutomaticoId DESC
END
GO

IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'InsProcesoAutomatico' AND SPECIFIC_SCHEMA = 'interfaces' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE interfaces.InsProcesoAutomatico
END
GO
CREATE PROCEDURE interfaces.InsProcesoAutomatico
	@CodigoProceso VARCHAR(9)
AS
BEGIN
	INSERT INTO interfaces.ProcesoAutomatico(CodigoProceso,FechaHoraInicio,Estado)
	VALUES(@CodigoProceso,GETDATE(),1)

	SELECT SCOPE_IDENTITY()
END
GO

IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'UpdProcesoAutomatico' AND SPECIFIC_SCHEMA = 'interfaces' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE interfaces.UpdProcesoAutomatico
END
GO
CREATE PROCEDURE interfaces.UpdProcesoAutomatico
	@ProcesoAutomaticoId bigint,
	@Estado int,
	@ErrorProceso varchar(1000),
	@ErrorLog varchar(1500)
AS
BEGIN
	UPDATE interfaces.ProcesoAutomatico
	SET	
		Estado = @Estado,
		FechaHoraFin = GETDATE(),
		ErrorProceso = @ErrorProceso,
		ErrorLog = @ErrorLog
	WHERE ProcesoAutomaticoId = @ProcesoAutomaticoId
END
GO

IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME  = 'LogCDRWeb' AND TABLE_SCHEMA = 'interfaces')
BEGIN
    DROP TABLE interfaces.LogCDRWeb
END
GO
CREATE TABLE interfaces.LogCDRWeb(
	LogCDRWebId BIGINT IDENTITY(1,1) PRIMARY KEY,
	ProcesoAutomaticoId BIGINT NOT NULL,
	CDRWebId INT NOT NULL,
	CampaniaId VARCHAR(6) NOT NULL,
	PedidoId INT NULL,
	PedidoFacturadoId INT NULL,
	ConsultoraId BIGINT NOT NULL,
	CodigoConsultora VARCHAR(15) NOT NULL,
	CodigoRegion VARCHAR(2) NULL,
	CodigoZona VARCHAR(4) NULL,
	FechaRegistro DATETIME NOT NULL,
	FechaCulminado DATETIME NOT NULL,
	FechaAtencion DATETIME NULL,
	EstadoCDR INT NULL,
	ConsultoraSaldo DECIMAL(15,2) NULL,
	ImporteCDR DECIMAL(15,2) NULL,
	EnvioCorreo BIT NOT NULL,
	FechaEnvioCorreo DATETIME NULL,
	Visualizado BIT NOT NULL,
	Estado TINYINT NOT NULL,
	ErrorProceso VARCHAR(100) NULL,
	ErrorLog VARCHAR(2000) NULL
)
GO
ALTER TABLE interfaces.LogCDRWeb
ADD CONSTRAINT DF_LogCDRWeb_EnvioCorreo
DEFAULT 0 FOR EnvioCorreo
GO
ALTER TABLE interfaces.LogCDRWeb
ADD CONSTRAINT DF_LogCDRWeb_Visualizado
DEFAULT 0 FOR Visualizado
GO

IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetLogCDRWeb' AND SPECIFIC_SCHEMA = 'interfaces' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE interfaces.GetLogCDRWeb
END
GO
CREATE PROCEDURE interfaces.GetLogCDRWeb
	@ProcesoAutomaticoId BIGINT
AS
BEGIN
	INSERT INTO interfaces.LogCDRWeb(
		ProcesoAutomaticoId,
		CDRWebId,
		CampaniaId,
		PedidoId,
		PedidoFacturadoId,		
		ConsultoraId,
		CodigoConsultora,
		CodigoRegion,
		CodigoZona,
		FechaRegistro,
		FechaCulminado,
		Estado
	)
	SELECT
		@ProcesoAutomaticoId,
		CDRW.CDRWebID,
		CDRW.CampaniaID,
		CDRW.PedidoId,
		CDRW.PedidoNumero,
		CDRW.ConsultoraID,
		LEFT(C.Codigo,15),
		LEFT(R.Codigo,2),
		LEFT(Z.Codigo,4),
		CDRW.FechaRegistro,
		CDRW.FechaCulminado,
		1
	FROM CDRWeb CDRW
	INNER JOIN ods.Consultora C ON CDRW.ConsultoraID = C.ConsultoraID
	INNER JOIN ods.Region R ON R.RegionID = C.RegionID
	INNER JOIN ods.Zona Z ON Z.RegionID = C.RegionID AND Z.ZonaID = C.ZonaID
	WHERE CDRW.Estado = 2 --CULMINADOS
 
	SELECT		
		l.LogCDRWebId,
		l.ProcesoAutomaticoId,
		l.CDRWebId,
		l.CampaniaId,
		l.PedidoId,
		l.PedidoFacturadoId,
		l.CodigoConsultora,
		l.CodigoRegion,
		l.CodigoZona,
		l.FechaRegistro,
		l.FechaCulminado,
		isnull(u.Email,'') as Email,
		isnull(u.Nombre,u.Sobrenombre) as NombreCompleto
	FROM interfaces.LogCDRWeb l
	LEFT JOIN usuario u on
		l.CodigoConsultora = u.CodigoConsultora		
	WHERE l.ProcesoAutomaticoId = @ProcesoAutomaticoId
	
END
GO

IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = 'UpdLogCDRWeb' AND SPECIFIC_SCHEMA = 'interfaces' AND Routine_Type = 'PROCEDURE')
BEGIN
    DROP PROCEDURE interfaces.UpdLogCDRWeb
END
GO

IF TYPE_ID('interfaces.LogCDRWebType') IS NOT NULL
	DROP TYPE interfaces.LogCDRWebType
GO
CREATE TYPE interfaces.LogCDRWebType AS TABLE(
	LogCDRWebId BIGINT NOT NULL,
	CDRWebId INT NOT NULL,
	EstadoCDR INT NULL,
	ConsultoraSaldo DECIMAL(15,2) NULL,
	ImporteCDR DECIMAL(15,2) NULL,
	Estado TINYINT NOT NULL,
	ErrorProceso VARCHAR(100) NULL,
	ErrorLog VARCHAR(2000) NULL
)
GO

CREATE PROCEDURE interfaces.UpdLogCDRWeb
	@LogCDRWebType interfaces.LogCDRWebType readonly
AS
BEGIN
	DECLARE @hoy DATETIME = GETDATE()

	UPDATE interfaces.LogCDRWeb
	SET
		EstadoCDR = T.EstadoCDR,
		FechaAtencion = @hoy,
		ConsultoraSaldo = T.ConsultoraSaldo,
		ImporteCDR = T.ImporteCDR,
		Estado = T.Estado,
		ErrorProceso = T.ErrorProceso,
		ErrorLog = T.ErrorLog
	FROM interfaces.LogCDRWeb LCDRW
	INNER JOIN @LogCDRWebType T on T.LogCDRWebId = LCDRW.LogCDRWebId
	
	UPDATE dbo.CDRWeb
	SET
		Estado = T.EstadoCDR,
		FechaAtencion = @hoy,
		Importe = T.ImporteCDR
	FROM dbo.CDRWeb CDRW
	INNER JOIN @LogCDRWebType T on T.CDRWebId = CDRW.CDRWebID
END
GO

IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME  = 'LogCDRWebDetalle' AND TABLE_SCHEMA = 'interfaces')
BEGIN
    DROP TABLE interfaces.LogCDRWebDetalle
END
GO
CREATE TABLE interfaces.LogCDRWebDetalle(
	LogCDRWebDetalleId BIGINT IDENTITY(1,1) PRIMARY KEY,
	LogCDRWebId BIGINT NOT NULL,
	CDRWebDetalleId INT NOT NULL,	
	CodigoOperacionCDR VARCHAR(10) NOT NULL,
	CodigoMotivoCDR VARCHAR(10) NOT NULL,
	CUV VARCHAR(10) NOT NULL,
	Cantidad INT NOT NULL,
	PedidoId INT NULL,
	CUV2 VARCHAR(10) NULL,
	Cantidad2 INT NULL,
	EstadoCDR INT NULL,
	CodigoRechazo VARCHAR(10) NULL,
	DescripcionRechazo VARCHAR(100) NULL,
	ObservacionRechazo VARCHAR(100) NULL
)
GO

IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetLogCDRWebDetalle' AND SPECIFIC_SCHEMA = 'interfaces' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE interfaces.GetLogCDRWebDetalle
END
GO
CREATE PROCEDURE interfaces.GetLogCDRWebDetalle
	@LogCDRWebId BIGINT
AS
BEGIN
	INSERT INTO interfaces.LogCDRWebDetalle(
		LogCDRWebId,
		CDRWebDetalleId,
		CodigoOperacionCDR,
		CodigoMotivoCDR,
		CUV,
		Cantidad,
		PedidoId,
		CUV2,
		Cantidad2--,
		--PrecioUnitario2
	)
	SELECT
		@LogCDRWebId,
		CDRWD.CDRWebDetalleID,
		CDRWD.CodigoOperacion,
		CDRWD.CodigoReclamo,
		CDRWD.CUV,
		CDRWD.Cantidad,
		LCDRW.PedidoId,
		CDRWD.CUV2,
		CDRWD.Cantidad2
	FROM LogCDRWeb LCDRW
	INNER JOIN CDRWebDetalle CDRWD ON CDRWD.CDRWebID = LCDRW.CDRWebId
	WHERE LCDRW.LogCDRWebId = @LogCDRWebId AND CDRWD.Eliminado = 0	
	
	--SELECT
	--	LogCDRWebDetalleId,
	--	CDRWebDetalleId,
	--	LogCDRWebId,
	--	PedidoId,
	--	CodigoOperacionCDR,
	--	CodigoMotivoCDR,
	--	CUV,
	--	Cantidad,
	--	CUV2,
	--	Cantidad2
	--FROM interfaces.LogCDRWebDetalle
	--WHERE LogCDRWebId = @LogCDRWebId
	
	SELECT 
		cd.LogCDRWebDetalleId,
		cd.CDRWebDetalleID,
		cd.LogCDRWebId,
		cd.PedidoId
		,c.CDRWebId as CDRWebID
		,cd.CodigoOperacionCDR
		,cd.CodigoMotivoCDR
		,cd.CUV
		,cd.Cantidad
		,isnull(cd.CUV2,'') as CUV2
		,cd.Cantidad2 as Cantidad2
		,cd.EstadoCDR
		,cd.CodigoRechazo
		,cd.ObservacionRechazo	
		,pc.Descripcion as NombreProducto
		,isnull(pc2.Descripcion,'') as NombreProducto2
		,(pwd.PrecioUnidad * pwd.FactorRepeticion * cd.Cantidad) as Precio
		,isnull((pc2.PrecioCatalogo * pc2.FactorRepeticion * cd.Cantidad2),0) as Precio2		
	FROM interfaces.LogCDRWeb c		
	INNER JOIN interfaces.LogCDRWebDetalle cd on
		c.LogCDRWebID = cd.LogCDRWebID
	INNER JOIN ods.Campania ca on
		c.CampaniaId = ca.Codigo
	INNER JOIN ods.ProductoComercial pc on
		cd.CUV = pc.CUV
		and pc.AnoCampania = c.CampaniaId
	LEFT JOIN ods.ProductoComercial pc2 on
		cd.CUV2 = pc2.CUV
		and pc2.AnoCampania = c.CampaniaId
	INNER JOIN ods.PedidoDetalle pwd on
		pwd.CUV = cd.CUV
		and pwd.PedidoId = cd.PedidoId
	WHERE		 
		c.LogCDRWebID = @LogCDRWebID	
END

GO

IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = 'UpdLogCDRWebDetalle' AND SPECIFIC_SCHEMA = 'interfaces' AND Routine_Type = 'PROCEDURE')
BEGIN
    DROP PROCEDURE interfaces.UpdLogCDRWebDetalle
END
GO

IF TYPE_ID('interfaces.LogCDRWebDetalleType') IS NOT NULL
	DROP TYPE interfaces.LogCDRWebDetalleType
GO
CREATE TYPE interfaces.LogCDRWebDetalleType AS TABLE(
	LogCDRWebDetalleId BIGINT NOT NULL,
	CDRWebDetalleId INT NOT NULL,
	EstadoCDR INT NOT NULL,
	CodigoRechazo VARCHAR(10) NULL,
	--DescripcionRechazo VARCHAR(100) NULL,
	ObservacionRechazo VARCHAR(100) NULL
)
GO

CREATE PROCEDURE interfaces.UpdLogCDRWebDetalle
	@LogCDRWebDetalleType interfaces.LogCDRWebDetalleType readonly
AS
BEGIN
	UPDATE interfaces.LogCDRWebDetalle
	SET
		EstadoCDR = T.EstadoCDR,
		CodigoRechazo = T.CodigoRechazo,
		DescripcionRechazo = MRCDR.DescripcionRechazo,
		ObservacionRechazo = T.ObservacionRechazo
	FROM interfaces.LogCDRWebDetalle LCDRWD
	INNER JOIN @LogCDRWebDetalleType T ON T.LogCDRWebDetalleId = LCDRWD.LogCDRWebDetalleId
	LEFT JOIN ods.MotivoRechazoCDR MRCDR ON MRCDR.CodigoRechazo = T.CodigoRechazo
	
	UPDATE dbo.CDRWebDetalle
	SET
		Estado = T.EstadoCDR,
		MotivoRechazo = T.CodigoRechazo,
		Observacion = T.ObservacionRechazo
	FROM dbo.CDRWebDetalle CDRWD
	INNER JOIN @LogCDRWebDetalleType T ON T.CDRWebDetalleId = CDRWD.CDRWebDetalleID
END
GO

IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME  = 'LogEmailCDRWeb' AND TABLE_SCHEMA = 'interfaces')
BEGIN
    DROP TABLE interfaces.LogEmailCDRWeb
END
GO

CREATE TABLE interfaces.LogEmailCDRWeb(
	LogEmailCDRWebId BIGINT IDENTITY(1,1) PRIMARY KEY,
	ProcesoAutomaticoId BIGINT NOT NULL,
	LogCDRWebId BIGINT NOT NULL,
	NombreUsuario VARCHAR(80) NOT NULL,
	Email VARCHAR(50) NOT NULL,
	Estado TINYINT NOT NULL,
	ErrorProceso VARCHAR(100) NULL,
	ErrorLog VARCHAR(2000) NULL
)

GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES
	WHERE SPECIFIC_NAME = 'GetLogEmailCDRWeb' AND SPECIFIC_SCHEMA = 'interfaces' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE interfaces.GetLogEmailCDRWeb
END
GO
CREATE PROCEDURE interfaces.GetLogEmailCDRWeb
	@ProcesoAutomaticoId BIGINT,
	@DiasValidos INT
AS
BEGIN
	INSERT INTO interfaces.LogEmailCDRWeb(
		ProcesoAutomaticoId,
		LogCDRWebId,
		NombreUsuario,
		Email,
		Estado
	)
	SELECT
		@ProcesoAutomaticoId,
		LCDRW.LogCDRWebId,
		CASE ISNULL(U.Sobrenombre,'')
			WHEN '' THEN ISNULL(U.Nombre,'')
			ELSE U.Sobrenombre
		END,
		U.Email,
		1
	FROM interfaces.LogCDRWeb LCDRW
	INNER JOIN Usuario U ON 
		LCDRW.CodigoConsultora = U.CodigoConsultora
		AND
		U.EmailActivo = 0 AND ISNULL(U.Email,'') <> ''
	WHERE LCDRW.EnvioCorreo = 0 AND LCDRW.FechaAtencion > DATEADD(DAY,-@DiasValidos,GETDATE())
 
	SELECT
		LECDRW.LogEmailCDRWebId,
		LECDRW.ProcesoAutomaticoId,
		LECDRW.NombreUsuario,
		LECDRW.Email,
		LCDRW.LogCDRWebId,
		LCDRW.CDRWebId,
		LCDRW.CampaniaId,
		LCDRW.PedidoFacturadoId,
		LCDRW.CodigoConsultora,
		LCDRW.FechaRegistro,
		LCDRW.FechaCulminado,
		LCDRW.FechaAtencion
	FROM interfaces.LogEmailCDRWeb LECDRW
	INNER JOIN interfaces.LogCDRWeb LCDRW ON LECDRW.LogCDRWebId = LCDRW.LogCDRWebId
	WHERE LECDRW.ProcesoAutomaticoId = @ProcesoAutomaticoId
END
GO

IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = 'UpdLogEmailCDRWeb' AND SPECIFIC_SCHEMA = 'interfaces' AND Routine_Type = 'PROCEDURE')
BEGIN
    DROP PROCEDURE interfaces.UpdLogEmailCDRWeb
END
GO

IF TYPE_ID('interfaces.LogEmailCDRWebType') IS NOT NULL
	DROP TYPE interfaces.LogEmailCDRWebType
GO
CREATE TYPE interfaces.LogEmailCDRWebType AS TABLE(
	LogEmailCDRWebId BIGINT NOT NULL,
	LogCDRWebId BIGINT NOT NULL,
	EnvioCorreo BIT NOT NULL,
	Estado TINYINT NOT NULL,
	ErrorProceso VARCHAR(100) NULL,
	ErrorLog VARCHAR(2000) NULL
)

GO

CREATE PROCEDURE interfaces.UpdLogEmailCDRWeb
	@LogEmailCDRWebType interfaces.LogEmailCDRWebType readonly
AS
BEGIN
	UPDATE interfaces.LogEmailCDRWeb
	SET
		Estado = T.Estado,
		ErrorProceso = T.ErrorProceso,
		ErrorLog = T.ErrorLog
	FROM interfaces.LogEmailCDRWeb LECDRW
	INNER JOIN @LogEmailCDRWebType T on T.LogEmailCDRWebId = LECDRW.LogEmailCDRWebId
	
	UPDATE interfaces.LogCDRWeb
	SET
		EnvioCorreo = T.EnvioCorreo,
		FechaEnvioCorreo = GETDATE()
	FROM interfaces.LogCDRWeb LCDRW
	INNER JOIN @LogEmailCDRWebType T on T.LogCDRWebId = LCDRW.LogCDRWebId
END
GO

IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES
	WHERE SPECIFIC_NAME = 'GetLogCDRWebDetalleByLogCDRWebId' AND SPECIFIC_SCHEMA = 'interfaces' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE interfaces.GetLogCDRWebDetalleByLogCDRWebId
END
GO
CREATE PROCEDURE interfaces.GetLogCDRWebDetalleByLogCDRWebId
	@LogCDRWebId BIGINT
AS
BEGIN		
	SELECT
		LogCDRWebDetalleId,
		LogCDRWebId,
		CDRWebDetalleId,
		CodigoOperacionCDR,
		CodigoMotivoCDR,
		CUV,
		Cantidad,
		'' AS NombreProducto,
		0 AS Precio,
		CUV2,
		Cantidad2,
		'' AS NombreProducto2,
		0 AS Precio2,
		EstadoCDR,
		CodigoRechazo,
		DescripcionRechazo,
		ObservacionRechazo,
		'' AS DescripcionSolucion
	FROM interfaces.LogCDRWebDetalle
	WHERE LogCDRWebId = @LogCDRWebId
END
GO