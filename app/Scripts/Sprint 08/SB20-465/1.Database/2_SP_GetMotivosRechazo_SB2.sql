USE BelcorpBolivia
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetMotivosRechazo_SB2' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetMotivosRechazo_SB2
END
GO
CREATE PROCEDURE dbo.GetMotivosRechazo_SB2
AS
BEGIN
	SELECT
		MotivoSolicitudID,
		Motivo,
		Tipo,
		Estado
	FROM MotivoSolicitud
	WHERE Tipo = 3 AND Estado = 1;
END
GO
/*end*/

USE BelcorpChile
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetMotivosRechazo_SB2' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetMotivosRechazo_SB2
END
GO
CREATE PROCEDURE dbo.GetMotivosRechazo_SB2
AS
BEGIN
	SELECT
		MotivoSolicitudID,
		Motivo,
		Tipo,
		Estado
	FROM MotivoSolicitud
	WHERE Tipo = 3 AND Estado = 1;
END
GO
/*end*/

USE BelcorpCostaRica
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetMotivosRechazo_SB2' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetMotivosRechazo_SB2
END
GO
CREATE PROCEDURE dbo.GetMotivosRechazo_SB2
AS
BEGIN
	SELECT
		MotivoSolicitudID,
		Motivo,
		Tipo,
		Estado
	FROM MotivoSolicitud
	WHERE Tipo = 3 AND Estado = 1;
END
GO
/*end*/

USE BelcorpDominicana
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetMotivosRechazo_SB2' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetMotivosRechazo_SB2
END
GO
CREATE PROCEDURE dbo.GetMotivosRechazo_SB2
AS
BEGIN
	SELECT
		MotivoSolicitudID,
		Motivo,
		Tipo,
		Estado
	FROM MotivoSolicitud
	WHERE Tipo = 3 AND Estado = 1;
END
GO
/*end*/

USE BelcorpEcuador
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetMotivosRechazo_SB2' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetMotivosRechazo_SB2
END
GO
CREATE PROCEDURE dbo.GetMotivosRechazo_SB2
AS
BEGIN
	SELECT
		MotivoSolicitudID,
		Motivo,
		Tipo,
		Estado
	FROM MotivoSolicitud
	WHERE Tipo = 3 AND Estado = 1;
END
GO
/*end*/

USE BelcorpGuatemala
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetMotivosRechazo_SB2' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetMotivosRechazo_SB2
END
GO
CREATE PROCEDURE dbo.GetMotivosRechazo_SB2
AS
BEGIN
	SELECT
		MotivoSolicitudID,
		Motivo,
		Tipo,
		Estado
	FROM MotivoSolicitud
	WHERE Tipo = 3 AND Estado = 1;
END
GO
/*end*/

USE BelcorpPanama
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetMotivosRechazo_SB2' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetMotivosRechazo_SB2
END
GO
CREATE PROCEDURE dbo.GetMotivosRechazo_SB2
AS
BEGIN
	SELECT
		MotivoSolicitudID,
		Motivo,
		Tipo,
		Estado
	FROM MotivoSolicitud
	WHERE Tipo = 3 AND Estado = 1;
END
GO
/*end*/

USE BelcorpPuertoRico
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetMotivosRechazo_SB2' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetMotivosRechazo_SB2
END
GO
CREATE PROCEDURE dbo.GetMotivosRechazo_SB2
AS
BEGIN
	SELECT
		MotivoSolicitudID,
		Motivo,
		Tipo,
		Estado
	FROM MotivoSolicitud
	WHERE Tipo = 3 AND Estado = 1;
END
GO
/*end*/

USE BelcorpSalvador
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetMotivosRechazo_SB2' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetMotivosRechazo_SB2
END
GO
CREATE PROCEDURE dbo.GetMotivosRechazo_SB2
AS
BEGIN
	SELECT
		MotivoSolicitudID,
		Motivo,
		Tipo,
		Estado
	FROM MotivoSolicitud
	WHERE Tipo = 3 AND Estado = 1;
END
GO
/*end*/

USE BelcorpVenezuela
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetMotivosRechazo_SB2' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetMotivosRechazo_SB2
END
GO
CREATE PROCEDURE dbo.GetMotivosRechazo_SB2
AS
BEGIN
	SELECT
		MotivoSolicitudID,
		Motivo,
		Tipo,
		Estado
	FROM MotivoSolicitud
	WHERE Tipo = 3 AND Estado = 1;
END
GO
/*end*/

USE BelcorpColombia
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetMotivosRechazo_SB2' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetMotivosRechazo_SB2
END
GO
CREATE PROCEDURE dbo.GetMotivosRechazo_SB2
AS
BEGIN
	SELECT
		MotivoSolicitudID,
		Motivo,
		Tipo,
		Estado
	FROM MotivoSolicitud
	WHERE Tipo = 3 AND Estado = 1;
END
GO
/*end*/

USE BelcorpMexico
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetMotivosRechazo_SB2' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetMotivosRechazo_SB2
END
GO
CREATE PROCEDURE dbo.GetMotivosRechazo_SB2
AS
BEGIN
	SELECT
		MotivoSolicitudID,
		Motivo,
		Tipo,
		Estado
	FROM MotivoSolicitud
	WHERE Tipo = 3 AND Estado = 1;
END
GO
/*end*/

USE BelcorpPeru
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetMotivosRechazo_SB2' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetMotivosRechazo_SB2
END
GO
CREATE PROCEDURE dbo.GetMotivosRechazo_SB2
AS
BEGIN
	SELECT
		MotivoSolicitudID,
		Motivo,
		Tipo,
		Estado
	FROM MotivoSolicitud
	WHERE Tipo = 3 AND Estado = 1;
END
GO