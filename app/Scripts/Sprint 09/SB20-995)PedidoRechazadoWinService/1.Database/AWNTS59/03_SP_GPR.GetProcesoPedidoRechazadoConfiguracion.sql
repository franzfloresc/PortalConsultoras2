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