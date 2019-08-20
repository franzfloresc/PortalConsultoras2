USE BelcorpBolivia
GO
IF OBJECT_ID('GPR.UpdProcesoValidacionPedidoRechazado') IS NOT NULL
	DROP PROCEDURE GPR.UpdProcesoValidacionPedidoRechazado
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

USE BelcorpChile
GO
IF OBJECT_ID('GPR.UpdProcesoValidacionPedidoRechazado') IS NOT NULL
	DROP PROCEDURE GPR.UpdProcesoValidacionPedidoRechazado
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

USE BelcorpColombia
GO
IF OBJECT_ID('GPR.UpdProcesoValidacionPedidoRechazado') IS NOT NULL
	DROP PROCEDURE GPR.UpdProcesoValidacionPedidoRechazado
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

USE BelcorpCostaRica
GO
IF OBJECT_ID('GPR.UpdProcesoValidacionPedidoRechazado') IS NOT NULL
	DROP PROCEDURE GPR.UpdProcesoValidacionPedidoRechazado
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

USE BelcorpDominicana
GO
IF OBJECT_ID('GPR.UpdProcesoValidacionPedidoRechazado') IS NOT NULL
	DROP PROCEDURE GPR.UpdProcesoValidacionPedidoRechazado
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

USE BelcorpEcuador
GO
IF OBJECT_ID('GPR.UpdProcesoValidacionPedidoRechazado') IS NOT NULL
	DROP PROCEDURE GPR.UpdProcesoValidacionPedidoRechazado
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

USE BelcorpGuatemala
GO
IF OBJECT_ID('GPR.UpdProcesoValidacionPedidoRechazado') IS NOT NULL
	DROP PROCEDURE GPR.UpdProcesoValidacionPedidoRechazado
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

USE BelcorpMexico
GO
IF OBJECT_ID('GPR.UpdProcesoValidacionPedidoRechazado') IS NOT NULL
	DROP PROCEDURE GPR.UpdProcesoValidacionPedidoRechazado
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

USE BelcorpPanama
GO
IF OBJECT_ID('GPR.UpdProcesoValidacionPedidoRechazado') IS NOT NULL
	DROP PROCEDURE GPR.UpdProcesoValidacionPedidoRechazado
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

USE BelcorpPeru
GO
IF OBJECT_ID('GPR.UpdProcesoValidacionPedidoRechazado') IS NOT NULL
	DROP PROCEDURE GPR.UpdProcesoValidacionPedidoRechazado
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

USE BelcorpPuertoRico
GO
IF OBJECT_ID('GPR.UpdProcesoValidacionPedidoRechazado') IS NOT NULL
	DROP PROCEDURE GPR.UpdProcesoValidacionPedidoRechazado
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

USE BelcorpSalvador
GO
IF OBJECT_ID('GPR.UpdProcesoValidacionPedidoRechazado') IS NOT NULL
	DROP PROCEDURE GPR.UpdProcesoValidacionPedidoRechazado
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