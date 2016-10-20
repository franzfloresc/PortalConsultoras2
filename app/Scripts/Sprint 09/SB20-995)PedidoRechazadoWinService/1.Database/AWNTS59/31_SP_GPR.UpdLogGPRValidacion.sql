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