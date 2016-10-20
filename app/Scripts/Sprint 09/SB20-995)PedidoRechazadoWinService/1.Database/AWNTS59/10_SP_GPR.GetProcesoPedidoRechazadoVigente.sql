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