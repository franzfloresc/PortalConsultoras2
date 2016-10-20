USE BelcorpBolivia
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

USE BelcorpChile
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

USE BelcorpCostaRica
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

USE BelcorpDominicana
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

USE BelcorpEcuador
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

USE BelcorpGuatemala
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

USE BelcorpPanama
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

USE BelcorpPuertoRico
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

USE BelcorpSalvador
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

USE BelcorpVenezuela
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