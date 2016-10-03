USE BelcorpBolivia
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'CancelarSolicitudCliente_SB2' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.CancelarSolicitudCliente_SB2
END
GO
CREATE PROCEDURE dbo.CancelarSolicitudCliente_SB2
	@SolicitudId bigint,
	@MotivoSolicitudId Int,
	@RazonMotivoSolicitud Varchar(500)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @CodigoUsuario varchar(20);
	SELECT TOP 1 @CodigoUsuario = U.CodigoUsuario
	FROM SolicitudCliente SC
	INNER JOIN ods.Consultora C ON C.ConsultoraID = SC.ConsultoraID
	INNER JOIN Usuario U ON U.CodigoConsultora = C.Codigo
	WHERE SC.SolicitudClienteID = @SolicitudId

	UPDATE SolicitudCliente
	SET
		Estado = 'C',
		UsuarioModificacion = @CodigoUsuario,
		FechaModificacion = GETDATE(),
		MotivoSolicitudId = NULLIF(@MotivoSolicitudId,0),
		RazonMotivoSolicitud = @RazonMotivoSolicitud 
	WHERE SOlicitudClienteId = @SolicitudId and Estado='A'
END
GO
/*end*/

USE BelcorpChile
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'CancelarSolicitudCliente_SB2' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.CancelarSolicitudCliente_SB2
END
GO
CREATE PROCEDURE dbo.CancelarSolicitudCliente_SB2
	@SolicitudId bigint,
	@MotivoSolicitudId Int,
	@RazonMotivoSolicitud Varchar(500)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @CodigoUsuario varchar(20);
	SELECT TOP 1 @CodigoUsuario = U.CodigoUsuario
	FROM SolicitudCliente SC
	INNER JOIN ods.Consultora C ON C.ConsultoraID = SC.ConsultoraID
	INNER JOIN Usuario U ON U.CodigoConsultora = C.Codigo
	WHERE SC.SolicitudClienteID = @SolicitudId

	UPDATE SolicitudCliente
	SET
		Estado = 'C',
		UsuarioModificacion = @CodigoUsuario,
		FechaModificacion = GETDATE(),
		MotivoSolicitudId = NULLIF(@MotivoSolicitudId,0),
		RazonMotivoSolicitud = @RazonMotivoSolicitud 
	WHERE SOlicitudClienteId = @SolicitudId and Estado='A'
END
GO
/*end*/

USE BelcorpCostaRica
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'CancelarSolicitudCliente_SB2' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.CancelarSolicitudCliente_SB2
END
GO
CREATE PROCEDURE dbo.CancelarSolicitudCliente_SB2
	@SolicitudId bigint,
	@MotivoSolicitudId Int,
	@RazonMotivoSolicitud Varchar(500)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @CodigoUsuario varchar(20);
	SELECT TOP 1 @CodigoUsuario = U.CodigoUsuario
	FROM SolicitudCliente SC
	INNER JOIN ods.Consultora C ON C.ConsultoraID = SC.ConsultoraID
	INNER JOIN Usuario U ON U.CodigoConsultora = C.Codigo
	WHERE SC.SolicitudClienteID = @SolicitudId

	UPDATE SolicitudCliente
	SET
		Estado = 'C',
		UsuarioModificacion = @CodigoUsuario,
		FechaModificacion = GETDATE(),
		MotivoSolicitudId = NULLIF(@MotivoSolicitudId,0),
		RazonMotivoSolicitud = @RazonMotivoSolicitud 
	WHERE SOlicitudClienteId = @SolicitudId and Estado='A'
END
GO
/*end*/

USE BelcorpDominicana
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'CancelarSolicitudCliente_SB2' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.CancelarSolicitudCliente_SB2
END
GO
CREATE PROCEDURE dbo.CancelarSolicitudCliente_SB2
	@SolicitudId bigint,
	@MotivoSolicitudId Int,
	@RazonMotivoSolicitud Varchar(500)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @CodigoUsuario varchar(20);
	SELECT TOP 1 @CodigoUsuario = U.CodigoUsuario
	FROM SolicitudCliente SC
	INNER JOIN ods.Consultora C ON C.ConsultoraID = SC.ConsultoraID
	INNER JOIN Usuario U ON U.CodigoConsultora = C.Codigo
	WHERE SC.SolicitudClienteID = @SolicitudId

	UPDATE SolicitudCliente
	SET
		Estado = 'C',
		UsuarioModificacion = @CodigoUsuario,
		FechaModificacion = GETDATE(),
		MotivoSolicitudId = NULLIF(@MotivoSolicitudId,0),
		RazonMotivoSolicitud = @RazonMotivoSolicitud 
	WHERE SOlicitudClienteId = @SolicitudId and Estado='A'
END
GO
/*end*/

USE BelcorpEcuador
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'CancelarSolicitudCliente_SB2' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.CancelarSolicitudCliente_SB2
END
GO
CREATE PROCEDURE dbo.CancelarSolicitudCliente_SB2
	@SolicitudId bigint,
	@MotivoSolicitudId Int,
	@RazonMotivoSolicitud Varchar(500)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @CodigoUsuario varchar(20);
	SELECT TOP 1 @CodigoUsuario = U.CodigoUsuario
	FROM SolicitudCliente SC
	INNER JOIN ods.Consultora C ON C.ConsultoraID = SC.ConsultoraID
	INNER JOIN Usuario U ON U.CodigoConsultora = C.Codigo
	WHERE SC.SolicitudClienteID = @SolicitudId

	UPDATE SolicitudCliente
	SET
		Estado = 'C',
		UsuarioModificacion = @CodigoUsuario,
		FechaModificacion = GETDATE(),
		MotivoSolicitudId = NULLIF(@MotivoSolicitudId,0),
		RazonMotivoSolicitud = @RazonMotivoSolicitud 
	WHERE SOlicitudClienteId = @SolicitudId and Estado='A'
END
GO
/*end*/

USE BelcorpGuatemala
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'CancelarSolicitudCliente_SB2' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.CancelarSolicitudCliente_SB2
END
GO
CREATE PROCEDURE dbo.CancelarSolicitudCliente_SB2
	@SolicitudId bigint,
	@MotivoSolicitudId Int,
	@RazonMotivoSolicitud Varchar(500)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @CodigoUsuario varchar(20);
	SELECT TOP 1 @CodigoUsuario = U.CodigoUsuario
	FROM SolicitudCliente SC
	INNER JOIN ods.Consultora C ON C.ConsultoraID = SC.ConsultoraID
	INNER JOIN Usuario U ON U.CodigoConsultora = C.Codigo
	WHERE SC.SolicitudClienteID = @SolicitudId

	UPDATE SolicitudCliente
	SET
		Estado = 'C',
		UsuarioModificacion = @CodigoUsuario,
		FechaModificacion = GETDATE(),
		MotivoSolicitudId = NULLIF(@MotivoSolicitudId,0),
		RazonMotivoSolicitud = @RazonMotivoSolicitud 
	WHERE SOlicitudClienteId = @SolicitudId and Estado='A'
END
GO
/*end*/

USE BelcorpPanama
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'CancelarSolicitudCliente_SB2' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.CancelarSolicitudCliente_SB2
END
GO
CREATE PROCEDURE dbo.CancelarSolicitudCliente_SB2
	@SolicitudId bigint,
	@MotivoSolicitudId Int,
	@RazonMotivoSolicitud Varchar(500)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @CodigoUsuario varchar(20);
	SELECT TOP 1 @CodigoUsuario = U.CodigoUsuario
	FROM SolicitudCliente SC
	INNER JOIN ods.Consultora C ON C.ConsultoraID = SC.ConsultoraID
	INNER JOIN Usuario U ON U.CodigoConsultora = C.Codigo
	WHERE SC.SolicitudClienteID = @SolicitudId

	UPDATE SolicitudCliente
	SET
		Estado = 'C',
		UsuarioModificacion = @CodigoUsuario,
		FechaModificacion = GETDATE(),
		MotivoSolicitudId = NULLIF(@MotivoSolicitudId,0),
		RazonMotivoSolicitud = @RazonMotivoSolicitud 
	WHERE SOlicitudClienteId = @SolicitudId and Estado='A'
END
GO
/*end*/

USE BelcorpPuertoRico
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'CancelarSolicitudCliente_SB2' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.CancelarSolicitudCliente_SB2
END
GO
CREATE PROCEDURE dbo.CancelarSolicitudCliente_SB2
	@SolicitudId bigint,
	@MotivoSolicitudId Int,
	@RazonMotivoSolicitud Varchar(500)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @CodigoUsuario varchar(20);
	SELECT TOP 1 @CodigoUsuario = U.CodigoUsuario
	FROM SolicitudCliente SC
	INNER JOIN ods.Consultora C ON C.ConsultoraID = SC.ConsultoraID
	INNER JOIN Usuario U ON U.CodigoConsultora = C.Codigo
	WHERE SC.SolicitudClienteID = @SolicitudId

	UPDATE SolicitudCliente
	SET
		Estado = 'C',
		UsuarioModificacion = @CodigoUsuario,
		FechaModificacion = GETDATE(),
		MotivoSolicitudId = NULLIF(@MotivoSolicitudId,0),
		RazonMotivoSolicitud = @RazonMotivoSolicitud 
	WHERE SOlicitudClienteId = @SolicitudId and Estado='A'
END
GO
/*end*/

USE BelcorpSalvador
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'CancelarSolicitudCliente_SB2' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.CancelarSolicitudCliente_SB2
END
GO
CREATE PROCEDURE dbo.CancelarSolicitudCliente_SB2
	@SolicitudId bigint,
	@MotivoSolicitudId Int,
	@RazonMotivoSolicitud Varchar(500)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @CodigoUsuario varchar(20);
	SELECT TOP 1 @CodigoUsuario = U.CodigoUsuario
	FROM SolicitudCliente SC
	INNER JOIN ods.Consultora C ON C.ConsultoraID = SC.ConsultoraID
	INNER JOIN Usuario U ON U.CodigoConsultora = C.Codigo
	WHERE SC.SolicitudClienteID = @SolicitudId

	UPDATE SolicitudCliente
	SET
		Estado = 'C',
		UsuarioModificacion = @CodigoUsuario,
		FechaModificacion = GETDATE(),
		MotivoSolicitudId = NULLIF(@MotivoSolicitudId,0),
		RazonMotivoSolicitud = @RazonMotivoSolicitud 
	WHERE SOlicitudClienteId = @SolicitudId and Estado='A'
END
GO
/*end*/

USE BelcorpVenezuela
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'CancelarSolicitudCliente_SB2' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.CancelarSolicitudCliente_SB2
END
GO
CREATE PROCEDURE dbo.CancelarSolicitudCliente_SB2
	@SolicitudId bigint,
	@MotivoSolicitudId Int,
	@RazonMotivoSolicitud Varchar(500)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @CodigoUsuario varchar(20);
	SELECT TOP 1 @CodigoUsuario = U.CodigoUsuario
	FROM SolicitudCliente SC
	INNER JOIN ods.Consultora C ON C.ConsultoraID = SC.ConsultoraID
	INNER JOIN Usuario U ON U.CodigoConsultora = C.Codigo
	WHERE SC.SolicitudClienteID = @SolicitudId

	UPDATE SolicitudCliente
	SET
		Estado = 'C',
		UsuarioModificacion = @CodigoUsuario,
		FechaModificacion = GETDATE(),
		MotivoSolicitudId = NULLIF(@MotivoSolicitudId,0),
		RazonMotivoSolicitud = @RazonMotivoSolicitud 
	WHERE SOlicitudClienteId = @SolicitudId and Estado='A'
END
GO
/*end*/

USE BelcorpColombia
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'CancelarSolicitudCliente_SB2' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.CancelarSolicitudCliente_SB2
END
GO
CREATE PROCEDURE dbo.CancelarSolicitudCliente_SB2
	@SolicitudId bigint,
	@MotivoSolicitudId Int,
	@RazonMotivoSolicitud Varchar(500)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @CodigoUsuario varchar(20);
	SELECT TOP 1 @CodigoUsuario = U.CodigoUsuario
	FROM SolicitudCliente SC
	INNER JOIN ods.Consultora C ON C.ConsultoraID = SC.ConsultoraID
	INNER JOIN Usuario U ON U.CodigoConsultora = C.Codigo
	WHERE SC.SolicitudClienteID = @SolicitudId

	UPDATE SolicitudCliente
	SET
		Estado = 'C',
		UsuarioModificacion = @CodigoUsuario,
		FechaModificacion = GETDATE(),
		MotivoSolicitudId = NULLIF(@MotivoSolicitudId,0),
		RazonMotivoSolicitud = @RazonMotivoSolicitud 
	WHERE SOlicitudClienteId = @SolicitudId and Estado='A'
END
GO
/*end*/

USE BelcorpMexico
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'CancelarSolicitudCliente_SB2' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.CancelarSolicitudCliente_SB2
END
GO
CREATE PROCEDURE dbo.CancelarSolicitudCliente_SB2
	@SolicitudId bigint,
	@MotivoSolicitudId Int,
	@RazonMotivoSolicitud Varchar(500)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @CodigoUsuario varchar(20);
	SELECT TOP 1 @CodigoUsuario = U.CodigoUsuario
	FROM SolicitudCliente SC
	INNER JOIN ods.Consultora C ON C.ConsultoraID = SC.ConsultoraID
	INNER JOIN Usuario U ON U.CodigoConsultora = C.Codigo
	WHERE SC.SolicitudClienteID = @SolicitudId

	UPDATE SolicitudCliente
	SET
		Estado = 'C',
		UsuarioModificacion = @CodigoUsuario,
		FechaModificacion = GETDATE(),
		MotivoSolicitudId = NULLIF(@MotivoSolicitudId,0),
		RazonMotivoSolicitud = @RazonMotivoSolicitud 
	WHERE SOlicitudClienteId = @SolicitudId and Estado='A'
END
GO
/*end*/

USE BelcorpPeru
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'CancelarSolicitudCliente_SB2' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.CancelarSolicitudCliente_SB2
END
GO
CREATE PROCEDURE dbo.CancelarSolicitudCliente_SB2
	@SolicitudId bigint,
	@MotivoSolicitudId Int,
	@RazonMotivoSolicitud Varchar(500)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @CodigoUsuario varchar(20);
	SELECT TOP 1 @CodigoUsuario = U.CodigoUsuario
	FROM SolicitudCliente SC
	INNER JOIN ods.Consultora C ON C.ConsultoraID = SC.ConsultoraID
	INNER JOIN Usuario U ON U.CodigoConsultora = C.Codigo
	WHERE SC.SolicitudClienteID = @SolicitudId

	UPDATE SolicitudCliente
	SET
		Estado = 'C',
		UsuarioModificacion = @CodigoUsuario,
		FechaModificacion = GETDATE(),
		MotivoSolicitudId = NULLIF(@MotivoSolicitudId,0),
		RazonMotivoSolicitud = @RazonMotivoSolicitud 
	WHERE SOlicitudClienteId = @SolicitudId and Estado='A'
END
GO