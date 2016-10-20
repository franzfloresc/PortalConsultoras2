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