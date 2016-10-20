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