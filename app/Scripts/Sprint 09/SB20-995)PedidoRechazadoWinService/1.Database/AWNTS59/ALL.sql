USE BelcorpColombia
GO
IF NOT EXISTS(SELECT 1 FROM sys.schemas WHERE name = 'GPR')
BEGIN
	EXEC sp_executesql N'CREATE SCHEMA GPR';
END
GO
/*end*/

USE BelcorpMexico
GO
IF NOT EXISTS(SELECT 1 FROM sys.schemas WHERE name = 'GPR')
BEGIN
	EXEC sp_executesql N'CREATE SCHEMA GPR';
END
GO
/*end*/

USE BelcorpPeru
GO
IF NOT EXISTS(SELECT 1 FROM sys.schemas WHERE name = 'GPR')
BEGIN
	EXEC sp_executesql N'CREATE SCHEMA GPR';
END
GO
/*end*/

USE BelcorpColombia
GO
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME  = 'ProcesoPedidoRechazadoConfiguracion' AND TABLE_SCHEMA = 'GPR')
BEGIN
    DROP TABLE GPR.ProcesoPedidoRechazadoConfiguracion;
END
GO
CREATE TABLE GPR.ProcesoPedidoRechazadoConfiguracion(
	ProcesoPedidoRechazadoConfiguracionId INT PRIMARY KEY,
	CodigoProceso varchar(6) NULL,
	Activo bit NULL,
	RestriccionEjecucion bit NULL,
	HoraInicioRestriccion time(0) NULL,
	HoraFinRestriccion time(0) NULL,
	ProlServiceEndPoint varchar(200) NULL,
	EnvioCorreoTodo bit NULL,
	EnvioCorreoError bit NULL
);
GO
/*end*/

USE BelcorpMexico
GO
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME  = 'ProcesoPedidoRechazadoConfiguracion' AND TABLE_SCHEMA = 'GPR')
BEGIN
    DROP TABLE GPR.ProcesoPedidoRechazadoConfiguracion;
END
GO
CREATE TABLE GPR.ProcesoPedidoRechazadoConfiguracion(
	ProcesoPedidoRechazadoConfiguracionId INT PRIMARY KEY,
	CodigoProceso varchar(6) NULL,
	Activo bit NULL,
	RestriccionEjecucion bit NULL,
	HoraInicioRestriccion time(0) NULL,
	HoraFinRestriccion time(0) NULL,
	ProlServiceEndPoint varchar(200) NULL,
	EnvioCorreoTodo bit NULL,
	EnvioCorreoError bit NULL
);
GO
/*end*/

USE BelcorpPeru
GO
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME  = 'ProcesoPedidoRechazadoConfiguracion' AND TABLE_SCHEMA = 'GPR')
BEGIN
    DROP TABLE GPR.ProcesoPedidoRechazadoConfiguracion;
END
GO
CREATE TABLE GPR.ProcesoPedidoRechazadoConfiguracion(
	ProcesoPedidoRechazadoConfiguracionId INT PRIMARY KEY,
	CodigoProceso varchar(6) NULL,
	Activo bit NULL,
	RestriccionEjecucion bit NULL,
	HoraInicioRestriccion time(0) NULL,
	HoraFinRestriccion time(0) NULL,
	ProlServiceEndPoint varchar(200) NULL,
	EnvioCorreoTodo bit NULL,
	EnvioCorreoError bit NULL
);
GO
/*end*/

USE BelcorpColombia
GO
IF NOT EXISTS(SELECT 1 FROM GPR.ProcesoPedidoRechazadoConfiguracion WHERE CodigoProceso = 'VPR-01')
BEGIN
	INSERT GPR.ProcesoPedidoRechazadoConfiguracion(ProcesoPedidoRechazadoConfiguracionId,CodigoProceso,Activo,RestriccionEjecucion,HoraInicioRestriccion,HoraFinRestriccion,ProlServiceEndPoint,EnvioCorreoTodo,EnvioCorreoError)
	VALUES (1, 'VPR-01', 1, 1, '08:00:00', '20:00:00', 'http://qaielb-webprol-1875224445.us-east-1.elb.amazonaws.com/wsPROLSicc/ServiceStockSsic.asmx', 0, 0);
END
GO
/*end*/

USE BelcorpMexico
GO
IF NOT EXISTS(SELECT 1 FROM GPR.ProcesoPedidoRechazadoConfiguracion WHERE CodigoProceso = 'VPR-01')
BEGIN
	INSERT GPR.ProcesoPedidoRechazadoConfiguracion(ProcesoPedidoRechazadoConfiguracionId,CodigoProceso,Activo,RestriccionEjecucion,HoraInicioRestriccion,HoraFinRestriccion,ProlServiceEndPoint,EnvioCorreoTodo,EnvioCorreoError)
	VALUES (1, 'VPR-01', 1, 1, '08:00:00', '20:00:00', 'http://qaielb-webprol-1875224445.us-east-1.elb.amazonaws.com/wsPROLSicc/ServiceStockSsic.asmx', 0, 0);
END
GO
/*end*/

USE BelcorpPeru
GO
IF NOT EXISTS(SELECT 1 FROM GPR.ProcesoPedidoRechazadoConfiguracion WHERE CodigoProceso = 'VPR-01')
BEGIN
	INSERT GPR.ProcesoPedidoRechazadoConfiguracion(ProcesoPedidoRechazadoConfiguracionId,CodigoProceso,Activo,RestriccionEjecucion,HoraInicioRestriccion,HoraFinRestriccion,ProlServiceEndPoint,EnvioCorreoTodo,EnvioCorreoError)
	VALUES (1, 'VPR-01', 1, 1, '08:00:00', '20:00:00', 'http://qaielb-webprol-1875224445.us-east-1.elb.amazonaws.com/wsPROLSicc/ServiceStockSsic.asmx', 0, 0);
END
GO
/*end*/

USE BelcorpColombia
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetProcesoPedidoRechazadoConfiguracion' AND SPECIFIC_SCHEMA = 'GPR' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE GPR.GetProcesoPedidoRechazadoConfiguracion
END
GO
CREATE PROCEDURE GPR.GetProcesoPedidoRechazadoConfiguracion
	@CodigoProceso varchar(20)
AS
BEGIN
	SELECT TOP 1
		ProcesoPedidoRechazadoConfiguracionId,
		CodigoProceso,
		Activo,
		RestriccionEjecucion,
		HoraInicioRestriccion,
		HoraFinRestriccion,
		ProlServiceEndPoint,
		EnvioCorreoTodo,
		EnvioCorreoError
	FROM GPR.ProcesoPedidoRechazadoConfiguracion
	WHERE CodigoProceso = @CodigoProceso
END
GO
/*end*/

USE BelcorpMexico
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetProcesoPedidoRechazadoConfiguracion' AND SPECIFIC_SCHEMA = 'GPR' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE GPR.GetProcesoPedidoRechazadoConfiguracion
END
GO
CREATE PROCEDURE GPR.GetProcesoPedidoRechazadoConfiguracion
	@CodigoProceso varchar(20)
AS
BEGIN
	SELECT TOP 1
		ProcesoPedidoRechazadoConfiguracionId,
		CodigoProceso,
		Activo,
		RestriccionEjecucion,
		HoraInicioRestriccion,
		HoraFinRestriccion,
		ProlServiceEndPoint,
		EnvioCorreoTodo,
		EnvioCorreoError
	FROM GPR.ProcesoPedidoRechazadoConfiguracion
	WHERE CodigoProceso = @CodigoProceso
END
GO
/*end*/

USE BelcorpPeru
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetProcesoPedidoRechazadoConfiguracion' AND SPECIFIC_SCHEMA = 'GPR' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE GPR.GetProcesoPedidoRechazadoConfiguracion
END
GO
CREATE PROCEDURE GPR.GetProcesoPedidoRechazadoConfiguracion
	@CodigoProceso varchar(20)
AS
BEGIN
	SELECT TOP 1
		ProcesoPedidoRechazadoConfiguracionId,
		CodigoProceso,
		Activo,
		RestriccionEjecucion,
		HoraInicioRestriccion,
		HoraFinRestriccion,
		ProlServiceEndPoint,
		EnvioCorreoTodo,
		EnvioCorreoError
	FROM GPR.ProcesoPedidoRechazadoConfiguracion
	WHERE CodigoProceso = @CodigoProceso
END
GO
/*end*/

USE BelcorpColombia
GO
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME  = 'ProcesoValidacionPedidoRechazado' AND TABLE_SCHEMA = 'GPR')
BEGIN
    DROP TABLE GPR.ProcesoValidacionPedidoRechazado;
END
GO
CREATE TABLE GPR.ProcesoValidacionPedidoRechazado(
	ProcesoValidacionPedidoRechazadoId BIGINT IDENTITY(1,1) PRIMARY KEY,
	CodigoProceso VARCHAR(6) NULL,
	FechaHoraInicio DATETIME NULL,
	FechaHoraFin DATETIME NULL,
	Estado INT NULL,
	ErrorProceso VARCHAR(100) NULL,
	ErrorLog varchar(2000) NULL
);
GO
/*end*/

USE BelcorpMexico
GO
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME  = 'ProcesoValidacionPedidoRechazado' AND TABLE_SCHEMA = 'GPR')
BEGIN
    DROP TABLE GPR.ProcesoValidacionPedidoRechazado;
END
GO
CREATE TABLE GPR.ProcesoValidacionPedidoRechazado(
	ProcesoValidacionPedidoRechazadoId BIGINT IDENTITY(1,1) PRIMARY KEY,
	CodigoProceso VARCHAR(6) NULL,
	FechaHoraInicio DATETIME NULL,
	FechaHoraFin DATETIME NULL,
	Estado INT NULL,
	ErrorProceso VARCHAR(100) NULL,
	ErrorLog varchar(2000) NULL
);
GO
/*end*/

USE BelcorpPeru
GO
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME  = 'ProcesoValidacionPedidoRechazado' AND TABLE_SCHEMA = 'GPR')
BEGIN
    DROP TABLE GPR.ProcesoValidacionPedidoRechazado;
END
GO
CREATE TABLE GPR.ProcesoValidacionPedidoRechazado(
	ProcesoValidacionPedidoRechazadoId BIGINT IDENTITY(1,1) PRIMARY KEY,
	CodigoProceso VARCHAR(6) NULL,
	FechaHoraInicio DATETIME NULL,
	FechaHoraFin DATETIME NULL,
	Estado INT NULL,
	ErrorProceso VARCHAR(100) NULL,
	ErrorLog varchar(2000) NULL
);
GO
/*end*/

USE BelcorpColombia
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetProcesoValidacionPedidoRechazado' AND SPECIFIC_SCHEMA = 'GPR' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE GPR.GetProcesoValidacionPedidoRechazado
END
GO
CREATE PROCEDURE GPR.GetProcesoValidacionPedidoRechazado
	@CodigoProceso varchar(20)
AS
BEGIN
	DECLARE @Activo bit;
	DECLARE @RestriccionEjecucion bit;
	DECLARE @HoraInicioRestriccion time;
	DECLARE @HoraFinRestriccion time;

	select
		@Activo = Activo,
		@RestriccionEjecucion = RestriccionEjecucion,
		@HoraInicioRestriccion = HoraInicioRestriccion,
		@HoraFinRestriccion = HoraFinRestriccion
	from GPR.ProcesoPedidoRechazadoConfiguracion
	where CodigoProceso = @CodigoProceso
	
	DECLARE @Valido int;
	IF ISNULL(@Activo,0) = 0
		SET @Valido = 0;
	ELSE IF ISNULL(@RestriccionEjecucion,0) = 0
		SET @Valido = 1;
	ELSE
	BEGIN
		DECLARE @HoraPais time = cast(dbo.fnObtenerFechaHoraPais() as time);
		IF (@HoraInicioRestriccion <= @HoraPais and @HoraPais <= @HoraFinRestriccion)
			SET @Valido = 1;
		ELSE
			SET @Valido = 0;
	END
	
	DECLARE @Estado int = NULL;
	IF (@Valido = 1)
	BEGIN
		select top 1 @Estado = Estado
		from GPR.ProcesoValidacionPedidoRechazado (nolock)
		where CodigoProceso = @CodigoProceso
		order by ProcesoValidacionPedidoRechazadoId desc;
	END
	ELSE
		set @Estado = -1;

	select ISNULL(@Estado,0) AS Estado;
END
GO
/*end*/

USE BelcorpMexico
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetProcesoValidacionPedidoRechazado' AND SPECIFIC_SCHEMA = 'GPR' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE GPR.GetProcesoValidacionPedidoRechazado
END
GO
CREATE PROCEDURE GPR.GetProcesoValidacionPedidoRechazado
	@CodigoProceso varchar(20)
AS
BEGIN
	DECLARE @Activo bit;
	DECLARE @RestriccionEjecucion bit;
	DECLARE @HoraInicioRestriccion time;
	DECLARE @HoraFinRestriccion time;

	select
		@Activo = Activo,
		@RestriccionEjecucion = RestriccionEjecucion,
		@HoraInicioRestriccion = HoraInicioRestriccion,
		@HoraFinRestriccion = HoraFinRestriccion
	from GPR.ProcesoPedidoRechazadoConfiguracion
	where CodigoProceso = @CodigoProceso
	
	DECLARE @Valido int;
	IF ISNULL(@Activo,0) = 0
		SET @Valido = 0;
	ELSE IF ISNULL(@RestriccionEjecucion,0) = 0
		SET @Valido = 1;
	ELSE
	BEGIN
		DECLARE @HoraPais time = cast(dbo.fnObtenerFechaHoraPais() as time);
		IF (@HoraInicioRestriccion <= @HoraPais and @HoraPais <= @HoraFinRestriccion)
			SET @Valido = 1;
		ELSE
			SET @Valido = 0;
	END
	
	DECLARE @Estado int = NULL;
	IF (@Valido = 1)
	BEGIN
		select top 1 @Estado = Estado
		from GPR.ProcesoValidacionPedidoRechazado (nolock)
		where CodigoProceso = @CodigoProceso
		order by ProcesoValidacionPedidoRechazadoId desc;
	END
	ELSE
		set @Estado = -1;

	select ISNULL(@Estado,0) AS Estado;
END
GO
/*end*/

USE BelcorpPeru
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetProcesoValidacionPedidoRechazado' AND SPECIFIC_SCHEMA = 'GPR' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE GPR.GetProcesoValidacionPedidoRechazado
END
GO
CREATE PROCEDURE GPR.GetProcesoValidacionPedidoRechazado
	@CodigoProceso varchar(20)
AS
BEGIN
	DECLARE @Activo bit;
	DECLARE @RestriccionEjecucion bit;
	DECLARE @HoraInicioRestriccion time;
	DECLARE @HoraFinRestriccion time;

	select
		@Activo = Activo,
		@RestriccionEjecucion = RestriccionEjecucion,
		@HoraInicioRestriccion = HoraInicioRestriccion,
		@HoraFinRestriccion = HoraFinRestriccion
	from GPR.ProcesoPedidoRechazadoConfiguracion
	where CodigoProceso = @CodigoProceso
	
	DECLARE @Valido int;
	IF ISNULL(@Activo,0) = 0
		SET @Valido = 0;
	ELSE IF ISNULL(@RestriccionEjecucion,0) = 0
		SET @Valido = 1;
	ELSE
	BEGIN
		DECLARE @HoraPais time = cast(dbo.fnObtenerFechaHoraPais() as time);
		IF (@HoraInicioRestriccion <= @HoraPais and @HoraPais <= @HoraFinRestriccion)
			SET @Valido = 1;
		ELSE
			SET @Valido = 0;
	END
	
	DECLARE @Estado int = NULL;
	IF (@Valido = 1)
	BEGIN
		select top 1 @Estado = Estado
		from GPR.ProcesoValidacionPedidoRechazado (nolock)
		where CodigoProceso = @CodigoProceso
		order by ProcesoValidacionPedidoRechazadoId desc;
	END
	ELSE
		set @Estado = -1;

	select ISNULL(@Estado,0) AS Estado;
END
GO
/*end*/

USE BelcorpColombia
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'InsProcesoValidacionPedidoRechazado' AND SPECIFIC_SCHEMA = 'GPR' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE GPR.InsProcesoValidacionPedidoRechazado
END
GO
CREATE PROCEDURE GPR.InsProcesoValidacionPedidoRechazado
	@CodigoProceso VARCHAR(6)
AS
BEGIN
	INSERT INTO GPR.ProcesoValidacionPedidoRechazado(CodigoProceso,FechaHoraInicio,Estado)
	VALUES(@CodigoProceso,getdate(),1);

	select SCOPE_IDENTITY();
END
GO
/*end*/

USE BelcorpMexico
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'InsProcesoValidacionPedidoRechazado' AND SPECIFIC_SCHEMA = 'GPR' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE GPR.InsProcesoValidacionPedidoRechazado
END
GO
CREATE PROCEDURE GPR.InsProcesoValidacionPedidoRechazado
	@CodigoProceso VARCHAR(6)
AS
BEGIN
	INSERT INTO GPR.ProcesoValidacionPedidoRechazado(CodigoProceso,FechaHoraInicio,Estado)
	VALUES(@CodigoProceso,getdate(),1);

	select SCOPE_IDENTITY();
END
GO
/*end*/

USE BelcorpPeru
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'InsProcesoValidacionPedidoRechazado' AND SPECIFIC_SCHEMA = 'GPR' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE GPR.InsProcesoValidacionPedidoRechazado
END
GO
CREATE PROCEDURE GPR.InsProcesoValidacionPedidoRechazado
	@CodigoProceso VARCHAR(6)
AS
BEGIN
	INSERT INTO GPR.ProcesoValidacionPedidoRechazado(CodigoProceso,FechaHoraInicio,Estado)
	VALUES(@CodigoProceso,getdate(),1);

	select SCOPE_IDENTITY();
END
GO
/*end*/

USE BelcorpColombia
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'UpdProcesoValidacionPedidoRechazado' AND SPECIFIC_SCHEMA = 'GPR' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE GPR.UpdProcesoValidacionPedidoRechazado
END
GO
CREATE PROCEDURE GPR.UpdProcesoValidacionPedidoRechazado
	@ProcesoValidacionPedidoRechazadoId bigint,
	@Estado int,
	@ErrorProceso varchar(100),
	@ErrorLog varchar(2000)
as
BEGIN
	UPDATE GPR.ProcesoValidacionPedidoRechazado
	SET	
		Estado = @Estado,
		FechaHoraFin = GETDATE(),
		ErrorProceso = @ErrorProceso,
		ErrorLog = @ErrorLog
	WHERE ProcesoValidacionPedidoRechazadoId = @ProcesoValidacionPedidoRechazadoId
END
GO
/*end*/

USE BelcorpMexico
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'UpdProcesoValidacionPedidoRechazado' AND SPECIFIC_SCHEMA = 'GPR' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE GPR.UpdProcesoValidacionPedidoRechazado
END
GO
CREATE PROCEDURE GPR.UpdProcesoValidacionPedidoRechazado
	@ProcesoValidacionPedidoRechazadoId bigint,
	@Estado int,
	@ErrorProceso varchar(100),
	@ErrorLog varchar(2000)
as
BEGIN
	UPDATE GPR.ProcesoValidacionPedidoRechazado
	SET	
		Estado = @Estado,
		FechaHoraFin = GETDATE(),
		ErrorProceso = @ErrorProceso,
		ErrorLog = @ErrorLog
	WHERE ProcesoValidacionPedidoRechazadoId = @ProcesoValidacionPedidoRechazadoId
END
GO
/*end*/

USE BelcorpPeru
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'UpdProcesoValidacionPedidoRechazado' AND SPECIFIC_SCHEMA = 'GPR' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE GPR.UpdProcesoValidacionPedidoRechazado
END
GO
CREATE PROCEDURE GPR.UpdProcesoValidacionPedidoRechazado
	@ProcesoValidacionPedidoRechazadoId bigint,
	@Estado int,
	@ErrorProceso varchar(100),
	@ErrorLog varchar(2000)
as
BEGIN
	UPDATE GPR.ProcesoValidacionPedidoRechazado
	SET	
		Estado = @Estado,
		FechaHoraFin = GETDATE(),
		ErrorProceso = @ErrorProceso,
		ErrorLog = @ErrorLog
	WHERE ProcesoValidacionPedidoRechazadoId = @ProcesoValidacionPedidoRechazadoId
END
GO
/*end*/

USE BelcorpColombia
GO
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME  = 'MotivoRechazo' AND TABLE_SCHEMA = 'GPR')
BEGIN
    DROP TABLE GPR.MotivoRechazo;
END
GO
CREATE TABLE GPR.MotivoRechazo
(
	IdMotivoRechazo INT IDENTITY(1,1) PRIMARY KEY,
	Codigo VARCHAR(6) NULL,
	Descripcion VARCHAR(100) NULL,
	RequiereGestion BIT NOT NULL,
	CodigoSomosBelcorp VARCHAR(8) NULL,
);
GO
/*end*/

USE BelcorpMexico
GO
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME  = 'MotivoRechazo' AND TABLE_SCHEMA = 'GPR')
BEGIN
    DROP TABLE GPR.MotivoRechazo;
END
GO
CREATE TABLE GPR.MotivoRechazo
(
	IdMotivoRechazo INT IDENTITY(1,1) PRIMARY KEY,
	Codigo VARCHAR(6) NULL,
	Descripcion VARCHAR(100) NULL,
	RequiereGestion BIT NOT NULL,
	CodigoSomosBelcorp VARCHAR(8) NULL,
);
GO
/*end*/

USE BelcorpPeru
GO
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME  = 'MotivoRechazo' AND TABLE_SCHEMA = 'GPR')
BEGIN
    DROP TABLE GPR.MotivoRechazo;
END
GO
CREATE TABLE GPR.MotivoRechazo
(
	IdMotivoRechazo INT IDENTITY(1,1) PRIMARY KEY,
	Codigo VARCHAR(6) NULL,
	Descripcion VARCHAR(100) NULL,
	RequiereGestion BIT NOT NULL,
	CodigoSomosBelcorp VARCHAR(8) NULL,
);
GO
/*end*/

USE BelcorpColombia
GO
DELETE FROM GPR.MotivoRechazo;
GO
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-1', 'TIPO DE SOLICITUD', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-2', 'DIRECCIONES CLIENTE', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-3', 'UNIDADES ADMINISTRATIVAS', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-4', 'TIPO DE DESPACHO', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-5', 'TIPO DE CAMBIO', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-6', 'CONSULTORA RETIRADA', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-7', 'SEGUNDO PEDIDO NO AUTORIZADO', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-8', 'BLOQUEO DEL CLIENTE', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-12', 'OC SIN PRODUCTOS', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-16', 'MONTO MINIMO', 1, 'minimo');
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-17', 'MONTO MAXIMO', 1, 'maximo');
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-19', 'DEUDA', 1, 'deuda');
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-20', 'CONSULTORA NO EXISTE', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-26', 'VALIDACION DE PROGRAMA DE NUEVAS', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-31', 'BLOQUEO POR CONTROL', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-33', 'VALIDACION DE NUEVAS Y REINGRESOS 2DO DIA', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-34', 'VALIDACION CODIGO CLIENTE CAMBIADO', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-36', 'TIPO DE DOCUMENTO INVALIDO', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-37', 'DOCUMENTO ILEGIBLE', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-40', 'RECARGO FLETE', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-46', 'CRONOGRAMA NO ESTA ABIERTO', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-51', 'MONTO INFERIOR', 1, 'minstock');
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-55', 'SCC EN GESTION O RECHAZADA', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-58', 'DESVIACION', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-60', 'ANUL. MODIFICACION DE UNIDADES', 0, NULL);
GO
/*end*/

USE BelcorpMexico
GO
DELETE FROM GPR.MotivoRechazo;
GO
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-1', 'TIPO DE SOLICITUD', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-2', 'DIRECCIONES CLIENTE', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-3', 'UNIDADES ADMINISTRATIVAS', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-4', 'TIPO DE DESPACHO', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-6', 'CLIENTE INACTIVO', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-7', 'SEGUNDO PEDIDO', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-8', 'BLOQUEO DEL CLIENTE', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-12', 'CABECERA SIN DETALLE', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-16', 'MONTO MINIMO', 1, 'minimo');
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-17', 'MONTO MAXIMO', 1, 'maximo');
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-18', 'REEMPLAZOS Y ANULADOS', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-19', 'ACTUALIZACION DE DEUDA', 1, 'deuda');
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-20', 'VALIDACION DE CODIGO DE CLIENTE INEXISTENTE', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-25', 'VALIDACION DE UNIADES MAXIMA POR PRODUCTO Y PEDIDO', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-26', 'VALIDACION DE PROGRAMA DE NUEVAS', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-31', 'VALIDACION DE BLOQUEO POR CONTROL 2', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-33', 'VALIDACION DE REGISTRADA EGRESADA TERCER DIA', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-34', 'VALIDACION CODIGO CLIENTE CAMBIADO', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-36', 'VALIDACION DE TIPO DE DOCUMENTO INVALIDO', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-37', 'VALIDACION RECHAZO OCR2', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-40', 'RECARGO FLETE', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-45', 'VALIDACIÓN DE ERROR EN CONFIGURACIÓN DE MATRIZ', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-46', 'RECHAZO POR FECHA DE FACTURACION', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-58', 'DESVIACION', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-60', 'ANUL. MODIFICACION DE UNIDADES', 0, NULL);
GO
/*end*/

USE BelcorpPeru
GO
DELETE FROM GPR.MotivoRechazo;
GO
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-1', 'VALIDACION TIPO DE SOLICITUD', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-2', 'VALIDACION DIRECCIONES CLIENTE', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-3', 'VALIDACION UNIDADES ADMINISTRATIVAS', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-4', 'VALIDACION DE TIPO DE DESPACHO', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-5', 'VALIDACION DE TIPO DE CAMBIO', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-6', 'VALIDACION DE CLIENTE INACTIVO', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-7', 'VALIDACION DE SEGUNDO PEDIDO', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-8', 'VALIDACION DE  BLOQUEO DEL CLIENTE', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-12', 'VALIDACION CABECERA SIN DETALLE', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-16', 'VALIDACION MONTO MINIMO', 1, 'minimo');
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-17', 'VALIDACION MONTO MAXIMO', 1, 'maximo');
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-19', 'VALIDACION DE ACTUALIZACION DE DEUDA', 1, 'deuda');
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-20', 'VALIDACION DE CODIGO DE CLIENTE INEXISTENTE', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-23', 'VALIDACION DE EXISTENCIA CRONOGRAMA ACTIVIDADES', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-26', 'VALIDACION DE PROGRAMA DE NUEVAS', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-33', 'VALIDACION DE NUEVAS SEGUNDO DIA', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-34', 'VALIDACION CODIGO CLIENTE CAMBIADO', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-36', 'VALIDACION DE TIPO DE DOCUMENTO INVALIDO', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-37', 'VALIDACION RECHAZO OCR2', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-39', 'VALIDACION DE SECUENCIACION DE ZONAS Y TERRITORIO', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-40', 'RECARGO FLETE', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-45', 'VALIDACIÓN DE ERROR EN CONFIGURACIÓN DE MATRIZ', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-46', 'RECHAZO POR FECHA DE FACTURACION', 0, NULL);
INSERT GPR.MotivoRechazo(Codigo, Descripcion, RequiereGestion, CodigoSomosBelcorp) VALUES ('OCC-51', 'VALIDACION MONTO MINIMO STOCK', 1, 'minstock');
GO
/*end*/

USE BelcorpColombia
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES
	WHERE SPECIFIC_NAME = 'GetProcesoPedidoRechazadoVigente' AND SPECIFIC_SCHEMA = 'GPR' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE GPR.GetProcesoPedidoRechazadoVigente
END
GO
CREATE PROCEDURE GPR.GetProcesoPedidoRechazadoVigente
AS
BEGIN
	DECLARE @hoy DATE = CAST(GETDATE() AS DATE);

	SELECT TOP 1
		IdProcesoPedidoRechazado,
		Fecha,
		Procesado
	FROM GPR.ProcesoPedidoRechazado
	WHERE CAST(Fecha AS DATE) = @hoy AND Estado = 'OK'
	ORDER BY IdProcesoPedidoRechazado DESC;
END
GO
/*end*/

USE BelcorpMexico
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES
	WHERE SPECIFIC_NAME = 'GetProcesoPedidoRechazadoVigente' AND SPECIFIC_SCHEMA = 'GPR' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE GPR.GetProcesoPedidoRechazadoVigente
END
GO
CREATE PROCEDURE GPR.GetProcesoPedidoRechazadoVigente
AS
BEGIN
	DECLARE @hoy DATE = CAST(GETDATE() AS DATE);

	SELECT TOP 1
		IdProcesoPedidoRechazado,
		Fecha,
		Procesado
	FROM GPR.ProcesoPedidoRechazado
	WHERE CAST(Fecha AS DATE) = @hoy AND Estado = 'OK'
	ORDER BY IdProcesoPedidoRechazado DESC;
END
GO
/*end*/

USE BelcorpPeru
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES
	WHERE SPECIFIC_NAME = 'GetProcesoPedidoRechazadoVigente' AND SPECIFIC_SCHEMA = 'GPR' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE GPR.GetProcesoPedidoRechazadoVigente
END
GO
CREATE PROCEDURE GPR.GetProcesoPedidoRechazadoVigente
AS
BEGIN
	DECLARE @hoy DATE = CAST(GETDATE() AS DATE);

	SELECT TOP 1
		IdProcesoPedidoRechazado,
		Fecha,
		Procesado
	FROM GPR.ProcesoPedidoRechazado
	WHERE CAST(Fecha AS DATE) = @hoy AND Estado = 'OK'
	ORDER BY IdProcesoPedidoRechazado DESC;
END
GO
/*end*/

USE BelcorpColombia
GO
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME  = 'LogGPRValidacion' AND TABLE_SCHEMA = 'GPR')
BEGIN
    DROP TABLE GPR.LogGPRValidacion;
END
GO
CREATE TABLE GPR.LogGPRValidacion(
	LogGPRValidacionId BIGINT IDENTITY(1,1) PRIMARY KEY,
	ProcesoValidacionPedidoRechazadoId BIGINT NOT NULL,
	IdPedidoRechazado BIGINT NOT NULL,
	DescripcionRechazo VARCHAR(200) NOT NULL,
	ConsultoraID BIGINT NULL,
	CodigoUsuario VARCHAR(20) NULL,
	NombreCompleto VARCHAR(80) NULL,
	Email VARCHAR(50) NULL,
	ZonaNuevoProl BIT NOT NULL,
	PedidoID INT NULL,
	SubTotal MONEY NULL,
	Descuento MONEY NULL,
	EstadoSimplificacionCUV BIT NULL,
	FechaFinValidacion DATETIME NULL,
	Rechazado BIT NOT NULL,
	Visualizado BIT NOT NULL,
	ErrorValidacion VARCHAR(100) NULL,
	ErrorProceso VARCHAR(100) NULL,
	ErrorLog VARCHAR(2000) NULL
);
GO
ALTER TABLE GPR.LogGPRValidacion 
ADD CONSTRAINT DF_LogGPRValidacion_Rechazado
DEFAULT 0 FOR Rechazado;
GO
ALTER TABLE GPR.LogGPRValidacion 
ADD CONSTRAINT DF_LogGPRValidacion_Visualizado
DEFAULT 0 FOR Visualizado;
GO
/*end*/

USE BelcorpMexico
GO
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME  = 'LogGPRValidacion' AND TABLE_SCHEMA = 'GPR')
BEGIN
    DROP TABLE GPR.LogGPRValidacion;
END
GO
CREATE TABLE GPR.LogGPRValidacion(
	LogGPRValidacionId BIGINT IDENTITY(1,1) PRIMARY KEY,
	ProcesoValidacionPedidoRechazadoId BIGINT NOT NULL,
	IdPedidoRechazado BIGINT NOT NULL,
	DescripcionRechazo VARCHAR(200) NOT NULL,
	ConsultoraID BIGINT NULL,
	CodigoUsuario VARCHAR(20) NULL,
	NombreCompleto VARCHAR(80) NULL,
	Email VARCHAR(50) NULL,
	ZonaNuevoProl BIT NOT NULL,
	PedidoID INT NULL,
	SubTotal MONEY NULL,
	Descuento MONEY NULL,
	EstadoSimplificacionCUV BIT NULL,
	FechaFinValidacion DATETIME NULL,
	Rechazado BIT NOT NULL,
	Visualizado BIT NOT NULL,
	ErrorValidacion VARCHAR(100) NULL,
	ErrorProceso VARCHAR(100) NULL,
	ErrorLog VARCHAR(2000) NULL
);
GO
ALTER TABLE GPR.LogGPRValidacion 
ADD CONSTRAINT DF_LogGPRValidacion_Rechazado
DEFAULT 0 FOR Rechazado;
GO
ALTER TABLE GPR.LogGPRValidacion 
ADD CONSTRAINT DF_LogGPRValidacion_Visualizado
DEFAULT 0 FOR Visualizado;
GO
/*end*/

USE BelcorpPeru
GO
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME  = 'LogGPRValidacion' AND TABLE_SCHEMA = 'GPR')
BEGIN
    DROP TABLE GPR.LogGPRValidacion;
END
GO
CREATE TABLE GPR.LogGPRValidacion(
	LogGPRValidacionId BIGINT IDENTITY(1,1) PRIMARY KEY,
	ProcesoValidacionPedidoRechazadoId BIGINT NOT NULL,
	IdPedidoRechazado BIGINT NOT NULL,
	DescripcionRechazo VARCHAR(200) NOT NULL,
	ConsultoraID BIGINT NULL,
	CodigoUsuario VARCHAR(20) NULL,
	NombreCompleto VARCHAR(80) NULL,
	Email VARCHAR(50) NULL,
	ZonaNuevoProl BIT NOT NULL,
	PedidoID INT NULL,
	SubTotal MONEY NULL,
	Descuento MONEY NULL,
	EstadoSimplificacionCUV BIT NULL,
	FechaFinValidacion DATETIME NULL,
	Rechazado BIT NOT NULL,
	Visualizado BIT NOT NULL,
	ErrorValidacion VARCHAR(100) NULL,
	ErrorProceso VARCHAR(100) NULL,
	ErrorLog VARCHAR(2000) NULL
);
GO
ALTER TABLE GPR.LogGPRValidacion 
ADD CONSTRAINT DF_LogGPRValidacion_Rechazado
DEFAULT 0 FOR Rechazado;
GO
ALTER TABLE GPR.LogGPRValidacion 
ADD CONSTRAINT DF_LogGPRValidacion_Visualizado
DEFAULT 0 FOR Visualizado;
GO
/*end*/

USE BelcorpColombia
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES
	WHERE SPECIFIC_NAME = 'GetPedidosRechazadosGestionablesByIdProcesoPedidoRechazado' AND SPECIFIC_SCHEMA = 'GPR' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE GPR.GetPedidosRechazadosGestionablesByIdProcesoPedidoRechazado
END
GO
CREATE PROCEDURE GPR.GetPedidosRechazadosGestionablesByIdProcesoPedidoRechazado
	@IdProcesoPedidoRechazado BIGINT,
	@ProcesoValidacionPedidoRechazadoId BIGINT,
	@PaisISO VARCHAR(2)
AS
BEGIN
	INSERT INTO GPR.LogGPRValidacion(
		ProcesoValidacionPedidoRechazadoId,
		IdPedidoRechazado,
		DescripcionRechazo,
		ConsultoraID,
		CodigoUsuario,
		NombreCompleto,
		Email,
		ZonaNuevoProl,
		PedidoID,
		SubTotal,
		Descuento,
		EstadoSimplificacionCUV
	)
	SELECT
		@ProcesoValidacionPedidoRechazadoId,
		PR.IdPedidoRechazado,
		MR.Descripcion,
		C.ConsultoraID,
		U.CodigoUsuario,
		U.Nombre,
		U.EMail,
		ISNULL((
			SELECT TOP 1 1
			FROM ConfiguracionValidacionNuevoPROL CVNP WITH(NOLOCK)
			WHERE CVNP.ZonaId = C.ZonaId
		),0),
		PW.PedidoID,
		PW.ImporteTotal,
		PW.DescuentoProl,
		ISNULL((
			SELECT TOP 1 EstadoSimplificacionCUV
			FROM Pais
			WHERE CodigoISO = @PaisISO
		), 0)
	FROM GPR.PedidoRechazado PR
	INNER JOIN GPR.MotivoRechazo MR WITH(NOLOCK) ON PR.MotivoRechazo = MR.Codigo AND MR.RequiereGestion = 1
	LEFT JOIN ods.Consultora C WITH(NOLOCK) ON C.Codigo =  PR.CodigoConsultora
	LEFT JOIN Usuario U WITH(NOLOCK) ON U.CodigoConsultora =  PR.CodigoConsultora
	LEFT JOIN PedidoWeb PW WITH(NOLOCK) ON PW.CampaniaID = PR.Campania AND PW.ConsultoraID = C.ConsultoraID
	WHERE PR.IdProcesoPedidoRechazado = @IdProcesoPedidoRechazado AND PR.Procesado = 0;
		
	SELECT
		LGPRV.LogGPRValidacionId,
		LGPRV.IdPedidoRechazado,
		LGPRV.DescripcionRechazo, --Temp
		PR.Campania,
		LGPRV.ConsultoraID,
		PR.CodigoConsultora,
		LGPRV.CodigoUsuario,
		LGPRV.NombreCompleto, --Temp
		LGPRV.Email,
		LGPRV.ZonaNuevoProl,
		LGPRV.PedidoID,
		LGPRV.SubTotal, --Temp
		LGPRV.Descuento, --Temp
		LGPRV.EstadoSimplificacionCUV, --Temp
		MR.CodigoSomosBelcorp AS CodigoRechazoSomosBelcorp
	FROM GPR.LogGPRValidacion LGPRV
	INNER JOIN GPR.PedidoRechazado PR ON LGPRV.IdPedidoRechazado = PR.IdPedidoRechazado
	INNER JOIN GPR.MotivoRechazo MR WITH(NOLOCK) ON PR.MotivoRechazo = MR.Codigo AND MR.RequiereGestion = 1
	WHERE LGPRV.ProcesoValidacionPedidoRechazadoId = @ProcesoValidacionPedidoRechazadoId;
END
GO
/*end*/

USE BelcorpMexico
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES
	WHERE SPECIFIC_NAME = 'GetPedidosRechazadosGestionablesByIdProcesoPedidoRechazado' AND SPECIFIC_SCHEMA = 'GPR' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE GPR.GetPedidosRechazadosGestionablesByIdProcesoPedidoRechazado
END
GO
CREATE PROCEDURE GPR.GetPedidosRechazadosGestionablesByIdProcesoPedidoRechazado
	@IdProcesoPedidoRechazado BIGINT,
	@ProcesoValidacionPedidoRechazadoId BIGINT,
	@PaisISO VARCHAR(2)
AS
BEGIN
	INSERT INTO GPR.LogGPRValidacion(
		ProcesoValidacionPedidoRechazadoId,
		IdPedidoRechazado,
		DescripcionRechazo,
		ConsultoraID,
		CodigoUsuario,
		NombreCompleto,
		Email,
		ZonaNuevoProl,
		PedidoID,
		SubTotal,
		Descuento,
		EstadoSimplificacionCUV
	)
	SELECT
		@ProcesoValidacionPedidoRechazadoId,
		PR.IdPedidoRechazado,
		MR.Descripcion,
		C.ConsultoraID,
		U.CodigoUsuario,
		U.Nombre,
		U.EMail,
		ISNULL((
			SELECT TOP 1 1
			FROM ConfiguracionValidacionNuevoPROL CVNP WITH(NOLOCK)
			WHERE CVNP.ZonaId = C.ZonaId
		),0),
		PW.PedidoID,
		PW.ImporteTotal,
		PW.DescuentoProl,
		ISNULL((
			SELECT TOP 1 EstadoSimplificacionCUV
			FROM Pais
			WHERE CodigoISO = @PaisISO
		), 0)
	FROM GPR.PedidoRechazado PR
	INNER JOIN GPR.MotivoRechazo MR WITH(NOLOCK) ON PR.MotivoRechazo = MR.Codigo AND MR.RequiereGestion = 1
	LEFT JOIN ods.Consultora C WITH(NOLOCK) ON C.Codigo =  PR.CodigoConsultora
	LEFT JOIN Usuario U WITH(NOLOCK) ON U.CodigoConsultora =  PR.CodigoConsultora
	LEFT JOIN PedidoWeb PW WITH(NOLOCK) ON PW.CampaniaID = PR.Campania AND PW.ConsultoraID = C.ConsultoraID
	WHERE PR.IdProcesoPedidoRechazado = @IdProcesoPedidoRechazado AND PR.Procesado = 0;
		
	SELECT
		LGPRV.LogGPRValidacionId,
		LGPRV.IdPedidoRechazado,
		LGPRV.DescripcionRechazo, --Temp
		PR.Campania,
		LGPRV.ConsultoraID,
		PR.CodigoConsultora,
		LGPRV.CodigoUsuario,
		LGPRV.NombreCompleto, --Temp
		LGPRV.Email,
		LGPRV.ZonaNuevoProl,
		LGPRV.PedidoID,
		LGPRV.SubTotal, --Temp
		LGPRV.Descuento, --Temp
		LGPRV.EstadoSimplificacionCUV, --Temp
		MR.CodigoSomosBelcorp AS CodigoRechazoSomosBelcorp
	FROM GPR.LogGPRValidacion LGPRV
	INNER JOIN GPR.PedidoRechazado PR ON LGPRV.IdPedidoRechazado = PR.IdPedidoRechazado
	INNER JOIN GPR.MotivoRechazo MR WITH(NOLOCK) ON PR.MotivoRechazo = MR.Codigo AND MR.RequiereGestion = 1
	WHERE LGPRV.ProcesoValidacionPedidoRechazadoId = @ProcesoValidacionPedidoRechazadoId;
END
GO
/*end*/

USE BelcorpPeru
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES
	WHERE SPECIFIC_NAME = 'GetPedidosRechazadosGestionablesByIdProcesoPedidoRechazado' AND SPECIFIC_SCHEMA = 'GPR' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE GPR.GetPedidosRechazadosGestionablesByIdProcesoPedidoRechazado
END
GO
CREATE PROCEDURE GPR.GetPedidosRechazadosGestionablesByIdProcesoPedidoRechazado
	@IdProcesoPedidoRechazado BIGINT,
	@ProcesoValidacionPedidoRechazadoId BIGINT,
	@PaisISO VARCHAR(2)
AS
BEGIN
	INSERT INTO GPR.LogGPRValidacion(
		ProcesoValidacionPedidoRechazadoId,
		IdPedidoRechazado,
		DescripcionRechazo,
		ConsultoraID,
		CodigoUsuario,
		NombreCompleto,
		Email,
		ZonaNuevoProl,
		PedidoID,
		SubTotal,
		Descuento,
		EstadoSimplificacionCUV
	)
	SELECT
		@ProcesoValidacionPedidoRechazadoId,
		PR.IdPedidoRechazado,
		MR.Descripcion,
		C.ConsultoraID,
		U.CodigoUsuario,
		U.Nombre,
		U.EMail,
		ISNULL((
			SELECT TOP 1 1
			FROM ConfiguracionValidacionNuevoPROL CVNP WITH(NOLOCK)
			WHERE CVNP.ZonaId = C.ZonaId
		),0),
		PW.PedidoID,
		PW.ImporteTotal,
		PW.DescuentoProl,
		ISNULL((
			SELECT TOP 1 EstadoSimplificacionCUV
			FROM Pais
			WHERE CodigoISO = @PaisISO
		), 0)
	FROM GPR.PedidoRechazado PR
	INNER JOIN GPR.MotivoRechazo MR WITH(NOLOCK) ON PR.MotivoRechazo = MR.Codigo AND MR.RequiereGestion = 1
	LEFT JOIN ods.Consultora C WITH(NOLOCK) ON C.Codigo =  PR.CodigoConsultora
	LEFT JOIN Usuario U WITH(NOLOCK) ON U.CodigoConsultora =  PR.CodigoConsultora
	LEFT JOIN PedidoWeb PW WITH(NOLOCK) ON PW.CampaniaID = PR.Campania AND PW.ConsultoraID = C.ConsultoraID
	WHERE PR.IdProcesoPedidoRechazado = @IdProcesoPedidoRechazado AND PR.Procesado = 0;
		
	SELECT
		LGPRV.LogGPRValidacionId,
		LGPRV.IdPedidoRechazado,
		LGPRV.DescripcionRechazo, --Temp
		PR.Campania,
		LGPRV.ConsultoraID,
		PR.CodigoConsultora,
		LGPRV.CodigoUsuario,
		LGPRV.NombreCompleto, --Temp
		LGPRV.Email,
		LGPRV.ZonaNuevoProl,
		LGPRV.PedidoID,
		LGPRV.SubTotal, --Temp
		LGPRV.Descuento, --Temp
		LGPRV.EstadoSimplificacionCUV, --Temp
		MR.CodigoSomosBelcorp AS CodigoRechazoSomosBelcorp
	FROM GPR.LogGPRValidacion LGPRV
	INNER JOIN GPR.PedidoRechazado PR ON LGPRV.IdPedidoRechazado = PR.IdPedidoRechazado
	INNER JOIN GPR.MotivoRechazo MR WITH(NOLOCK) ON PR.MotivoRechazo = MR.Codigo AND MR.RequiereGestion = 1
	WHERE LGPRV.ProcesoValidacionPedidoRechazadoId = @ProcesoValidacionPedidoRechazadoId;
END
GO
/*end*/

USE BelcorpColombia
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES
	WHERE SPECIFIC_NAME = 'UpdLogGPRValidacion' AND SPECIFIC_SCHEMA = 'GPR' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE GPR.UpdLogGPRValidacion
END
GO
CREATE PROCEDURE GPR.UpdLogGPRValidacion
	@LogGPRValidacionId BIGINT,
	@Rechazado BIT,
	@ErrorValidacion VARCHAR(100),
	@ErrorProceso VARCHAR(100),
	@ErrorLog VARCHAR(2000)
AS
BEGIN
	UPDATE GPR.LogGPRValidacion
	SET
		FechaFinValidacion = GETDATE(),
		Rechazado = @Rechazado,
		ErrorValidacion = @ErrorValidacion,
		ErrorProceso = @ErrorProceso,
		ErrorLog = @ErrorLog
	WHERE LogGPRValidacionId = @LogGPRValidacionId;
END
GO
/*end*/

USE BelcorpMexico
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES
	WHERE SPECIFIC_NAME = 'UpdLogGPRValidacion' AND SPECIFIC_SCHEMA = 'GPR' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE GPR.UpdLogGPRValidacion
END
GO
CREATE PROCEDURE GPR.UpdLogGPRValidacion
	@LogGPRValidacionId BIGINT,
	@Rechazado BIT,
	@ErrorValidacion VARCHAR(100),
	@ErrorProceso VARCHAR(100),
	@ErrorLog VARCHAR(2000)
AS
BEGIN
	UPDATE GPR.LogGPRValidacion
	SET
		FechaFinValidacion = GETDATE(),
		Rechazado = @Rechazado,
		ErrorValidacion = @ErrorValidacion,
		ErrorProceso = @ErrorProceso,
		ErrorLog = @ErrorLog
	WHERE LogGPRValidacionId = @LogGPRValidacionId;
END
GO
/*end*/

USE BelcorpPeru
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES
	WHERE SPECIFIC_NAME = 'UpdLogGPRValidacion' AND SPECIFIC_SCHEMA = 'GPR' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE GPR.UpdLogGPRValidacion
END
GO
CREATE PROCEDURE GPR.UpdLogGPRValidacion
	@LogGPRValidacionId BIGINT,
	@Rechazado BIT,
	@ErrorValidacion VARCHAR(100),
	@ErrorProceso VARCHAR(100),
	@ErrorLog VARCHAR(2000)
AS
BEGIN
	UPDATE GPR.LogGPRValidacion
	SET
		FechaFinValidacion = GETDATE(),
		Rechazado = @Rechazado,
		ErrorValidacion = @ErrorValidacion,
		ErrorProceso = @ErrorProceso,
		ErrorLog = @ErrorLog
	WHERE LogGPRValidacionId = @LogGPRValidacionId;
END
GO
/*end*/

USE BelcorpColombia
GO
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME  = 'LogGPRValidacionDetalle' AND TABLE_SCHEMA = 'GPR')
BEGIN
    DROP TABLE GPR.LogGPRValidacionDetalle;
END
GO
CREATE TABLE GPR.LogGPRValidacionDetalle(
	LogGPRValidacionDetalleId BIGINT IDENTITY(1,1) PRIMARY KEY,
	LogGPRValidacionId BIGINT NOT NULL,
	PedidoDetalleID SMALLINT NOT NULL,
	CUV VARCHAR(20) NOT NULL,
	Descripcion VARCHAR(200) NOT NULL,
	Cantidad INT NOT NULL,
	PrecioUnidad MONEY NOT NULL,
	ImporteTotal MONEY NOT NULL,
	IndicadorOferta INT NOT NULL,
	ConfiguracionOfertaID INT NULL
);
GO
/*end*/

USE BelcorpMexico
GO
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME  = 'LogGPRValidacionDetalle' AND TABLE_SCHEMA = 'GPR')
BEGIN
    DROP TABLE GPR.LogGPRValidacionDetalle;
END
GO
CREATE TABLE GPR.LogGPRValidacionDetalle(
	LogGPRValidacionDetalleId BIGINT IDENTITY(1,1) PRIMARY KEY,
	LogGPRValidacionId BIGINT NOT NULL,
	PedidoDetalleID SMALLINT NOT NULL,
	CUV VARCHAR(20) NOT NULL,
	Descripcion VARCHAR(200) NOT NULL,
	Cantidad INT NOT NULL,
	PrecioUnidad MONEY NOT NULL,
	ImporteTotal MONEY NOT NULL,
	IndicadorOferta INT NOT NULL,
	ConfiguracionOfertaID INT NULL
);
GO
/*end*/

USE BelcorpPeru
GO
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME  = 'LogGPRValidacionDetalle' AND TABLE_SCHEMA = 'GPR')
BEGIN
    DROP TABLE GPR.LogGPRValidacionDetalle;
END
GO
CREATE TABLE GPR.LogGPRValidacionDetalle(
	LogGPRValidacionDetalleId BIGINT IDENTITY(1,1) PRIMARY KEY,
	LogGPRValidacionId BIGINT NOT NULL,
	PedidoDetalleID SMALLINT NOT NULL,
	CUV VARCHAR(20) NOT NULL,
	Descripcion VARCHAR(200) NOT NULL,
	Cantidad INT NOT NULL,
	PrecioUnidad MONEY NOT NULL,
	ImporteTotal MONEY NOT NULL,
	IndicadorOferta INT NOT NULL,
	ConfiguracionOfertaID INT NULL
);
GO
/*end*/

USE BelcorpColombia
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES
	WHERE SPECIFIC_NAME = 'InsLogGPRValidacionDetalleByLogGPRValidacionId' AND SPECIFIC_SCHEMA = 'GPR' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE GPR.InsLogGPRValidacionDetalleByLogGPRValidacionId
END
GO
CREATE PROCEDURE GPR.InsLogGPRValidacionDetalleByLogGPRValidacionId
	@LogGPRValidacionId BIGINT
AS
BEGIN
	INSERT INTO GPR.LogGPRValidacionDetalle(
		LogGPRValidacionId,
		PedidoDetalleID,
		CUV,
		Descripcion,
		Cantidad,
		PrecioUnidad,
		ImporteTotal,
		IndicadorOferta,
		ConfiguracionOfertaID
	)
	SELECT
		@LogGPRValidacionId,
		PWD.PedidoDetalleID,
		PWD.CUV,
		COALESCE(OP.Descripcion, MC.Descripcion, pd.Descripcion, pc.Descripcion),
		PWD.Cantidad,
		PWD.PrecioUnidad,
		PWD.ImporteTotal,
		ISNULL(PC.IndicadorOferta,0),
		PWD.ConfiguracionOfertaID
	FROM GPR.LogGPRValidacion LGRPV WITH(NOLOCK)
	INNER JOIN GPR.PedidoRechazado PR WITH(NOLOCK) ON PR.IdPedidoRechazado = LGRPV.IdPedidoRechazado
	INNER JOIN PedidoWebDetalle PWD WITH(NOLOCK) ON PWD.CampaniaID = PR.Campania AND PWD.PedidoID = LGRPV.PedidoID
	INNER JOIN ods.ProductoComercial PC WITH(NOLOCK) ON PWD.CampaniaID = PC.AnoCampania AND PWD.CUV = PC.CUV
	LEFT JOIN dbo.ProductoDescripcion PD WITH(NOLOCK) ON PWD.CampaniaID = PD.CampaniaID AND PWD.CUV = PD.CUV
	LEFT HASH JOIN OfertaProducto OP WITH(NOLOCK) ON PWD.CampaniaID = OP.CampaniaID AND PWD.CUV = OP.CUV
	LEFT JOIN MatrizComercial MC WITH(NOLOCK) ON PC.CodigoProducto = MC.CodigoSAP
	WHERE LGRPV.LogGPRValidacionId = @LogGPRValidacionId;
END
GO
/*end*/

USE BelcorpMexico
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES
	WHERE SPECIFIC_NAME = 'InsLogGPRValidacionDetalleByLogGPRValidacionId' AND SPECIFIC_SCHEMA = 'GPR' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE GPR.InsLogGPRValidacionDetalleByLogGPRValidacionId
END
GO
CREATE PROCEDURE GPR.InsLogGPRValidacionDetalleByLogGPRValidacionId
	@LogGPRValidacionId BIGINT
AS
BEGIN
	INSERT INTO GPR.LogGPRValidacionDetalle(
		LogGPRValidacionId,
		PedidoDetalleID,
		CUV,
		Descripcion,
		Cantidad,
		PrecioUnidad,
		ImporteTotal,
		IndicadorOferta,
		ConfiguracionOfertaID
	)
	SELECT
		@LogGPRValidacionId,
		PWD.PedidoDetalleID,
		PWD.CUV,
		COALESCE(OP.Descripcion, MC.Descripcion, pd.Descripcion, pc.Descripcion),
		PWD.Cantidad,
		PWD.PrecioUnidad,
		PWD.ImporteTotal,
		ISNULL(PC.IndicadorOferta,0),
		PWD.ConfiguracionOfertaID
	FROM GPR.LogGPRValidacion LGRPV WITH(NOLOCK)
	INNER JOIN GPR.PedidoRechazado PR WITH(NOLOCK) ON PR.IdPedidoRechazado = LGRPV.IdPedidoRechazado
	INNER JOIN PedidoWebDetalle PWD WITH(NOLOCK) ON PWD.CampaniaID = PR.Campania AND PWD.PedidoID = LGRPV.PedidoID
	INNER JOIN ods.ProductoComercial PC WITH(NOLOCK) ON PWD.CampaniaID = PC.AnoCampania AND PWD.CUV = PC.CUV
	LEFT JOIN dbo.ProductoDescripcion PD WITH(NOLOCK) ON PWD.CampaniaID = PD.CampaniaID AND PWD.CUV = PD.CUV
	LEFT HASH JOIN OfertaProducto OP WITH(NOLOCK) ON PWD.CampaniaID = OP.CampaniaID AND PWD.CUV = OP.CUV
	LEFT JOIN MatrizComercial MC WITH(NOLOCK) ON PC.CodigoProducto = MC.CodigoSAP
	WHERE LGRPV.LogGPRValidacionId = @LogGPRValidacionId;
END
GO
/*end*/

USE BelcorpPeru
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES
	WHERE SPECIFIC_NAME = 'InsLogGPRValidacionDetalleByLogGPRValidacionId' AND SPECIFIC_SCHEMA = 'GPR' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE GPR.InsLogGPRValidacionDetalleByLogGPRValidacionId
END
GO
CREATE PROCEDURE GPR.InsLogGPRValidacionDetalleByLogGPRValidacionId
	@LogGPRValidacionId BIGINT
AS
BEGIN
	INSERT INTO GPR.LogGPRValidacionDetalle(
		LogGPRValidacionId,
		PedidoDetalleID,
		CUV,
		Descripcion,
		Cantidad,
		PrecioUnidad,
		ImporteTotal,
		IndicadorOferta,
		ConfiguracionOfertaID
	)
	SELECT
		@LogGPRValidacionId,
		PWD.PedidoDetalleID,
		PWD.CUV,
		COALESCE(OP.Descripcion, MC.Descripcion, pd.Descripcion, pc.Descripcion),
		PWD.Cantidad,
		PWD.PrecioUnidad,
		PWD.ImporteTotal,
		ISNULL(PC.IndicadorOferta,0),
		PWD.ConfiguracionOfertaID
	FROM GPR.LogGPRValidacion LGRPV WITH(NOLOCK)
	INNER JOIN GPR.PedidoRechazado PR WITH(NOLOCK) ON PR.IdPedidoRechazado = LGRPV.IdPedidoRechazado
	INNER JOIN PedidoWebDetalle PWD WITH(NOLOCK) ON PWD.CampaniaID = PR.Campania AND PWD.PedidoID = LGRPV.PedidoID
	INNER JOIN ods.ProductoComercial PC WITH(NOLOCK) ON PWD.CampaniaID = PC.AnoCampania AND PWD.CUV = PC.CUV
	LEFT JOIN dbo.ProductoDescripcion PD WITH(NOLOCK) ON PWD.CampaniaID = PD.CampaniaID AND PWD.CUV = PD.CUV
	LEFT HASH JOIN OfertaProducto OP WITH(NOLOCK) ON PWD.CampaniaID = OP.CampaniaID AND PWD.CUV = OP.CUV
	LEFT JOIN MatrizComercial MC WITH(NOLOCK) ON PC.CodigoProducto = MC.CodigoSAP
	WHERE LGRPV.LogGPRValidacionId = @LogGPRValidacionId;
END
GO
/*end*/

USE BelcorpColombia
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES
	WHERE SPECIFIC_NAME = 'UpdPedidoRechazado' AND SPECIFIC_SCHEMA = 'GPR' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE GPR.UpdPedidoRechazado
END
GO
CREATE PROCEDURE GPR.UpdPedidoRechazado
	@IdPedidoRechazado BIGINT,
	@Rechazado BIT,
	@CodigoRechazoSomosBelcorp VARCHAR(8)
AS
BEGIN
	UPDATE GPR.PedidoRechazado
	SET
		Procesado = 1,
		Rechazado = @Rechazado,
		CodigoRechazoSomosBelcorp = @CodigoRechazoSomosBelcorp
	WHERE IdPedidoRechazado = @IdPedidoRechazado;
END
GO
/*end*/

USE BelcorpMexico
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES
	WHERE SPECIFIC_NAME = 'UpdPedidoRechazado' AND SPECIFIC_SCHEMA = 'GPR' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE GPR.UpdPedidoRechazado
END
GO
CREATE PROCEDURE GPR.UpdPedidoRechazado
	@IdPedidoRechazado BIGINT,
	@Rechazado BIT,
	@CodigoRechazoSomosBelcorp VARCHAR(8)
AS
BEGIN
	UPDATE GPR.PedidoRechazado
	SET
		Procesado = 1,
		Rechazado = @Rechazado,
		CodigoRechazoSomosBelcorp = @CodigoRechazoSomosBelcorp
	WHERE IdPedidoRechazado = @IdPedidoRechazado;
END
GO
/*end*/

USE BelcorpPeru
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES
	WHERE SPECIFIC_NAME = 'UpdPedidoRechazado' AND SPECIFIC_SCHEMA = 'GPR' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE GPR.UpdPedidoRechazado
END
GO
CREATE PROCEDURE GPR.UpdPedidoRechazado
	@IdPedidoRechazado BIGINT,
	@Rechazado BIT,
	@CodigoRechazoSomosBelcorp VARCHAR(8)
AS
BEGIN
	UPDATE GPR.PedidoRechazado
	SET
		Procesado = 1,
		Rechazado = @Rechazado,
		CodigoRechazoSomosBelcorp = @CodigoRechazoSomosBelcorp
	WHERE IdPedidoRechazado = @IdPedidoRechazado;
END
GO
/*end*/

USE BelcorpColombia
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES
	WHERE SPECIFIC_NAME = 'UpdProcesoPedidoRechazado' AND SPECIFIC_SCHEMA = 'GPR' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE GPR.UpdProcesoPedidoRechazado
END
GO
CREATE PROCEDURE GPR.UpdProcesoPedidoRechazado
	@IdProcesoPedidoRechazado BIGINT
AS
BEGIN
	UPDATE GPR.ProcesoPedidoRechazado
	SET Procesado = 1
	WHERE IdProcesoPedidoRechazado = @IdProcesoPedidoRechazado;
END
GO
/*end*/

USE BelcorpMexico
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES
	WHERE SPECIFIC_NAME = 'UpdProcesoPedidoRechazado' AND SPECIFIC_SCHEMA = 'GPR' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE GPR.UpdProcesoPedidoRechazado
END
GO
CREATE PROCEDURE GPR.UpdProcesoPedidoRechazado
	@IdProcesoPedidoRechazado BIGINT
AS
BEGIN
	UPDATE GPR.ProcesoPedidoRechazado
	SET Procesado = 1
	WHERE IdProcesoPedidoRechazado = @IdProcesoPedidoRechazado;
END
GO
/*end*/

USE BelcorpPeru
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES
	WHERE SPECIFIC_NAME = 'UpdProcesoPedidoRechazado' AND SPECIFIC_SCHEMA = 'GPR' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE GPR.UpdProcesoPedidoRechazado
END
GO
CREATE PROCEDURE GPR.UpdProcesoPedidoRechazado
	@IdProcesoPedidoRechazado BIGINT
AS
BEGIN
	UPDATE GPR.ProcesoPedidoRechazado
	SET Procesado = 1
	WHERE IdProcesoPedidoRechazado = @IdProcesoPedidoRechazado;
END
GO
/*end*/

USE BelcorpColombia
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES
	WHERE SPECIFIC_NAME = 'GetLogGPRValidacionByLogGPRValidacionId' AND SPECIFIC_SCHEMA = 'GPR' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE GPR.GetLogGPRValidacionByLogGPRValidacionId
END
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
		LGPRV.FechaFinValidacion
	FROM GPR.LogGPRValidacion LGPRV
	INNER JOIN GPR.PedidoRechazado PR ON PR.IdPedidoRechazado = LGPRV.IdPedidoRechazado
	WHERE LogGPRValidacionId = @LogGPRValidacionId;
END
GO
/*end*/

USE BelcorpMexico
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES
	WHERE SPECIFIC_NAME = 'GetLogGPRValidacionByLogGPRValidacionId' AND SPECIFIC_SCHEMA = 'GPR' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE GPR.GetLogGPRValidacionByLogGPRValidacionId
END
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
		LGPRV.FechaFinValidacion
	FROM GPR.LogGPRValidacion LGPRV
	INNER JOIN GPR.PedidoRechazado PR ON PR.IdPedidoRechazado = LGPRV.IdPedidoRechazado
	WHERE LogGPRValidacionId = @LogGPRValidacionId;
END
GO
/*end*/

USE BelcorpPeru
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES
	WHERE SPECIFIC_NAME = 'GetLogGPRValidacionByLogGPRValidacionId' AND SPECIFIC_SCHEMA = 'GPR' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE GPR.GetLogGPRValidacionByLogGPRValidacionId
END
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
		LGPRV.FechaFinValidacion
	FROM GPR.LogGPRValidacion LGPRV
	INNER JOIN GPR.PedidoRechazado PR ON PR.IdPedidoRechazado = LGPRV.IdPedidoRechazado
	WHERE LogGPRValidacionId = @LogGPRValidacionId;
END
GO
/*end*/

USE BelcorpColombia
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES
	WHERE SPECIFIC_NAME = 'GetLogGPRValidacionDetalleByLogGPRValidacionId' AND SPECIFIC_SCHEMA = 'GPR' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE GPR.GetLogGPRValidacionDetalleByLogGPRValidacionId
END
GO
CREATE PROCEDURE GPR.GetLogGPRValidacionDetalleByLogGPRValidacionId
	@LogGPRValidacionId BIGINT
AS
BEGIN		
	SELECT
		LogGPRValidacionDetalleId,
		LogGPRValidacionId,
		PedidoDetalleID,
		CUV,
		Descripcion,
		Cantidad,
		PrecioUnidad,
		ImporteTotal,
		IndicadorOferta
	FROM GPR.LogGPRValidacionDetalle
	WHERE LogGPRValidacionId = @LogGPRValidacionId;
END
GO
/*end*/

USE BelcorpMexico
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES
	WHERE SPECIFIC_NAME = 'GetLogGPRValidacionDetalleByLogGPRValidacionId' AND SPECIFIC_SCHEMA = 'GPR' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE GPR.GetLogGPRValidacionDetalleByLogGPRValidacionId
END
GO
CREATE PROCEDURE GPR.GetLogGPRValidacionDetalleByLogGPRValidacionId
	@LogGPRValidacionId BIGINT
AS
BEGIN		
	SELECT
		LogGPRValidacionDetalleId,
		LogGPRValidacionId,
		PedidoDetalleID,
		CUV,
		Descripcion,
		Cantidad,
		PrecioUnidad,
		ImporteTotal,
		IndicadorOferta
	FROM GPR.LogGPRValidacionDetalle
	WHERE LogGPRValidacionId = @LogGPRValidacionId;
END
GO
/*end*/

USE BelcorpPeru
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES
	WHERE SPECIFIC_NAME = 'GetLogGPRValidacionDetalleByLogGPRValidacionId' AND SPECIFIC_SCHEMA = 'GPR' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE GPR.GetLogGPRValidacionDetalleByLogGPRValidacionId
END
GO
CREATE PROCEDURE GPR.GetLogGPRValidacionDetalleByLogGPRValidacionId
	@LogGPRValidacionId BIGINT
AS
BEGIN		
	SELECT
		LogGPRValidacionDetalleId,
		LogGPRValidacionId,
		PedidoDetalleID,
		CUV,
		Descripcion,
		Cantidad,
		PrecioUnidad,
		ImporteTotal,
		IndicadorOferta
	FROM GPR.LogGPRValidacionDetalle
	WHERE LogGPRValidacionId = @LogGPRValidacionId;
END
GO
/*end*/

USE BelcorpColombia
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES
	WHERE SPECIFIC_NAME = 'UpdLogGPRValidacionVisualizado' AND SPECIFIC_SCHEMA = 'GPR' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE GPR.UpdLogGPRValidacionVisualizado
END
GO
CREATE PROCEDURE GPR.UpdLogGPRValidacionVisualizado
	@LogGPRValidacionId BIGINT
AS
BEGIN
	UPDATE GPR.LogGPRValidacion
	SET Visualizado = 1
	WHERE LogGPRValidacionId = @LogGPRValidacionId;
END
GO
/*end*/

USE BelcorpMexico
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES
	WHERE SPECIFIC_NAME = 'UpdLogGPRValidacionVisualizado' AND SPECIFIC_SCHEMA = 'GPR' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE GPR.UpdLogGPRValidacionVisualizado
END
GO
CREATE PROCEDURE GPR.UpdLogGPRValidacionVisualizado
	@LogGPRValidacionId BIGINT
AS
BEGIN
	UPDATE GPR.LogGPRValidacion
	SET Visualizado = 1
	WHERE LogGPRValidacionId = @LogGPRValidacionId;
END
GO
/*end*/

USE BelcorpPeru
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES
	WHERE SPECIFIC_NAME = 'UpdLogGPRValidacionVisualizado' AND SPECIFIC_SCHEMA = 'GPR' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE GPR.UpdLogGPRValidacionVisualizado
END
GO
CREATE PROCEDURE GPR.UpdLogGPRValidacionVisualizado
	@LogGPRValidacionId BIGINT
AS
BEGIN
	UPDATE GPR.LogGPRValidacion
	SET Visualizado = 1
	WHERE LogGPRValidacionId = @LogGPRValidacionId;
END
GO