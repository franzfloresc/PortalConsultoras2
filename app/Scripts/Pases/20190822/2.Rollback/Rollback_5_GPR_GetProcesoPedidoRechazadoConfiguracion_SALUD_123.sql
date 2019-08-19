USE BelcorpBolivia
GO
IF OBJECT_ID('GPR.GetProcesoPedidoRechazadoConfiguracion') IS NOT NULL
	DROP PROCEDURE GPR.GetProcesoPedidoRechazadoConfiguracion
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

USE BelcorpChile
GO
IF OBJECT_ID('GPR.GetProcesoPedidoRechazadoConfiguracion') IS NOT NULL
	DROP PROCEDURE GPR.GetProcesoPedidoRechazadoConfiguracion
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

USE BelcorpColombia
GO
IF OBJECT_ID('GPR.GetProcesoPedidoRechazadoConfiguracion') IS NOT NULL
	DROP PROCEDURE GPR.GetProcesoPedidoRechazadoConfiguracion
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

USE BelcorpCostaRica
GO
IF OBJECT_ID('GPR.GetProcesoPedidoRechazadoConfiguracion') IS NOT NULL
	DROP PROCEDURE GPR.GetProcesoPedidoRechazadoConfiguracion
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

USE BelcorpDominicana
GO
IF OBJECT_ID('GPR.GetProcesoPedidoRechazadoConfiguracion') IS NOT NULL
	DROP PROCEDURE GPR.GetProcesoPedidoRechazadoConfiguracion
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

USE BelcorpEcuador
GO
IF OBJECT_ID('GPR.GetProcesoPedidoRechazadoConfiguracion') IS NOT NULL
	DROP PROCEDURE GPR.GetProcesoPedidoRechazadoConfiguracion
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

USE BelcorpGuatemala
GO
IF OBJECT_ID('GPR.GetProcesoPedidoRechazadoConfiguracion') IS NOT NULL
	DROP PROCEDURE GPR.GetProcesoPedidoRechazadoConfiguracion
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

USE BelcorpMexico
GO
IF OBJECT_ID('GPR.GetProcesoPedidoRechazadoConfiguracion') IS NOT NULL
	DROP PROCEDURE GPR.GetProcesoPedidoRechazadoConfiguracion
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

USE BelcorpPanama
GO
IF OBJECT_ID('GPR.GetProcesoPedidoRechazadoConfiguracion') IS NOT NULL
	DROP PROCEDURE GPR.GetProcesoPedidoRechazadoConfiguracion
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

USE BelcorpPeru
GO
IF OBJECT_ID('GPR.GetProcesoPedidoRechazadoConfiguracion') IS NOT NULL
	DROP PROCEDURE GPR.GetProcesoPedidoRechazadoConfiguracion
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

USE BelcorpPuertoRico
GO
IF OBJECT_ID('GPR.GetProcesoPedidoRechazadoConfiguracion') IS NOT NULL
	DROP PROCEDURE GPR.GetProcesoPedidoRechazadoConfiguracion
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

USE BelcorpSalvador
GO
IF OBJECT_ID('GPR.GetProcesoPedidoRechazadoConfiguracion') IS NOT NULL
	DROP PROCEDURE GPR.GetProcesoPedidoRechazadoConfiguracion
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