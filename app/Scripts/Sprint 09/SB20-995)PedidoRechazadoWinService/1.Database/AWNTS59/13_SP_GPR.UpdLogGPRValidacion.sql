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