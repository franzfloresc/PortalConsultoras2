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