USE BelcorpBolivia
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

USE BelcorpChile
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

USE BelcorpCostaRica
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

USE BelcorpDominicana
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

USE BelcorpEcuador
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

USE BelcorpGuatemala
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

USE BelcorpPanama
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

USE BelcorpPuertoRico
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

USE BelcorpSalvador
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

USE BelcorpVenezuela
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