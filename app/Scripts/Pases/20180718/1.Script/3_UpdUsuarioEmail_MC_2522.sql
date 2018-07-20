GO
USE BelcorpPeru
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES
	WHERE SPECIFIC_NAME = 'UpdUsuarioEmail' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.UpdUsuarioEmail
END
GO
CREATE PROCEDURE dbo.UpdUsuarioEmail
	@CodigoUsuario varchar(20),
	@Email varchar(50),
	@CampaniaActivacionEmail int
AS
BEGIN
	set nocount on;
	declare @FechaModificacion datetime = dbo.fnObtenerFechaHoraPais();

	update dbo.Usuario
	set
		EMail = @Email,
		EMailActivo = 1,
		CampaniaActivacionEmail = @CampaniaActivacionEmail,
		Modificado = 1,
		FechaModificacion = @FechaModificacion
	where CodigoUsuario = @CodigoUsuario;
END

GO
USE BelcorpMexico
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES
	WHERE SPECIFIC_NAME = 'UpdUsuarioEmail' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.UpdUsuarioEmail
END
GO
CREATE PROCEDURE dbo.UpdUsuarioEmail
	@CodigoUsuario varchar(20),
	@Email varchar(50),
	@CampaniaActivacionEmail int
AS
BEGIN
	set nocount on;
	declare @FechaModificacion datetime = dbo.fnObtenerFechaHoraPais();

	update dbo.Usuario
	set
		EMail = @Email,
		EMailActivo = 1,
		CampaniaActivacionEmail = @CampaniaActivacionEmail,
		Modificado = 1,
		FechaModificacion = @FechaModificacion
	where CodigoUsuario = @CodigoUsuario;
END

GO
USE BelcorpColombia
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES
	WHERE SPECIFIC_NAME = 'UpdUsuarioEmail' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.UpdUsuarioEmail
END
GO
CREATE PROCEDURE dbo.UpdUsuarioEmail
	@CodigoUsuario varchar(20),
	@Email varchar(50),
	@CampaniaActivacionEmail int
AS
BEGIN
	set nocount on;
	declare @FechaModificacion datetime = dbo.fnObtenerFechaHoraPais();

	update dbo.Usuario
	set
		EMail = @Email,
		EMailActivo = 1,
		CampaniaActivacionEmail = @CampaniaActivacionEmail,
		Modificado = 1,
		FechaModificacion = @FechaModificacion
	where CodigoUsuario = @CodigoUsuario;
END

GO
USE BelcorpSalvador
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES
	WHERE SPECIFIC_NAME = 'UpdUsuarioEmail' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.UpdUsuarioEmail
END
GO
CREATE PROCEDURE dbo.UpdUsuarioEmail
	@CodigoUsuario varchar(20),
	@Email varchar(50),
	@CampaniaActivacionEmail int
AS
BEGIN
	set nocount on;
	declare @FechaModificacion datetime = dbo.fnObtenerFechaHoraPais();

	update dbo.Usuario
	set
		EMail = @Email,
		EMailActivo = 1,
		CampaniaActivacionEmail = @CampaniaActivacionEmail,
		Modificado = 1,
		FechaModificacion = @FechaModificacion
	where CodigoUsuario = @CodigoUsuario;
END

GO
USE BelcorpPuertoRico
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES
	WHERE SPECIFIC_NAME = 'UpdUsuarioEmail' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.UpdUsuarioEmail
END
GO
CREATE PROCEDURE dbo.UpdUsuarioEmail
	@CodigoUsuario varchar(20),
	@Email varchar(50),
	@CampaniaActivacionEmail int
AS
BEGIN
	set nocount on;
	declare @FechaModificacion datetime = dbo.fnObtenerFechaHoraPais();

	update dbo.Usuario
	set
		EMail = @Email,
		EMailActivo = 1,
		CampaniaActivacionEmail = @CampaniaActivacionEmail,
		Modificado = 1,
		FechaModificacion = @FechaModificacion
	where CodigoUsuario = @CodigoUsuario;
END

GO
USE BelcorpPanama
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES
	WHERE SPECIFIC_NAME = 'UpdUsuarioEmail' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.UpdUsuarioEmail
END
GO
CREATE PROCEDURE dbo.UpdUsuarioEmail
	@CodigoUsuario varchar(20),
	@Email varchar(50),
	@CampaniaActivacionEmail int
AS
BEGIN
	set nocount on;
	declare @FechaModificacion datetime = dbo.fnObtenerFechaHoraPais();

	update dbo.Usuario
	set
		EMail = @Email,
		EMailActivo = 1,
		CampaniaActivacionEmail = @CampaniaActivacionEmail,
		Modificado = 1,
		FechaModificacion = @FechaModificacion
	where CodigoUsuario = @CodigoUsuario;
END

GO
USE BelcorpGuatemala
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES
	WHERE SPECIFIC_NAME = 'UpdUsuarioEmail' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.UpdUsuarioEmail
END
GO
CREATE PROCEDURE dbo.UpdUsuarioEmail
	@CodigoUsuario varchar(20),
	@Email varchar(50),
	@CampaniaActivacionEmail int
AS
BEGIN
	set nocount on;
	declare @FechaModificacion datetime = dbo.fnObtenerFechaHoraPais();

	update dbo.Usuario
	set
		EMail = @Email,
		EMailActivo = 1,
		CampaniaActivacionEmail = @CampaniaActivacionEmail,
		Modificado = 1,
		FechaModificacion = @FechaModificacion
	where CodigoUsuario = @CodigoUsuario;
END

GO
USE BelcorpEcuador
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES
	WHERE SPECIFIC_NAME = 'UpdUsuarioEmail' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.UpdUsuarioEmail
END
GO
CREATE PROCEDURE dbo.UpdUsuarioEmail
	@CodigoUsuario varchar(20),
	@Email varchar(50),
	@CampaniaActivacionEmail int
AS
BEGIN
	set nocount on;
	declare @FechaModificacion datetime = dbo.fnObtenerFechaHoraPais();

	update dbo.Usuario
	set
		EMail = @Email,
		EMailActivo = 1,
		CampaniaActivacionEmail = @CampaniaActivacionEmail,
		Modificado = 1,
		FechaModificacion = @FechaModificacion
	where CodigoUsuario = @CodigoUsuario;
END

GO
USE BelcorpDominicana
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES
	WHERE SPECIFIC_NAME = 'UpdUsuarioEmail' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.UpdUsuarioEmail
END
GO
CREATE PROCEDURE dbo.UpdUsuarioEmail
	@CodigoUsuario varchar(20),
	@Email varchar(50),
	@CampaniaActivacionEmail int
AS
BEGIN
	set nocount on;
	declare @FechaModificacion datetime = dbo.fnObtenerFechaHoraPais();

	update dbo.Usuario
	set
		EMail = @Email,
		EMailActivo = 1,
		CampaniaActivacionEmail = @CampaniaActivacionEmail,
		Modificado = 1,
		FechaModificacion = @FechaModificacion
	where CodigoUsuario = @CodigoUsuario;
END

GO
USE BelcorpCostaRica
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES
	WHERE SPECIFIC_NAME = 'UpdUsuarioEmail' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.UpdUsuarioEmail
END
GO
CREATE PROCEDURE dbo.UpdUsuarioEmail
	@CodigoUsuario varchar(20),
	@Email varchar(50),
	@CampaniaActivacionEmail int
AS
BEGIN
	set nocount on;
	declare @FechaModificacion datetime = dbo.fnObtenerFechaHoraPais();

	update dbo.Usuario
	set
		EMail = @Email,
		EMailActivo = 1,
		CampaniaActivacionEmail = @CampaniaActivacionEmail,
		Modificado = 1,
		FechaModificacion = @FechaModificacion
	where CodigoUsuario = @CodigoUsuario;
END

GO
USE BelcorpChile
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES
	WHERE SPECIFIC_NAME = 'UpdUsuarioEmail' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.UpdUsuarioEmail
END
GO
CREATE PROCEDURE dbo.UpdUsuarioEmail
	@CodigoUsuario varchar(20),
	@Email varchar(50),
	@CampaniaActivacionEmail int
AS
BEGIN
	set nocount on;
	declare @FechaModificacion datetime = dbo.fnObtenerFechaHoraPais();

	update dbo.Usuario
	set
		EMail = @Email,
		EMailActivo = 1,
		CampaniaActivacionEmail = @CampaniaActivacionEmail,
		Modificado = 1,
		FechaModificacion = @FechaModificacion
	where CodigoUsuario = @CodigoUsuario;
END

GO
USE BelcorpBolivia
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES
	WHERE SPECIFIC_NAME = 'UpdUsuarioEmail' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.UpdUsuarioEmail
END
GO
CREATE PROCEDURE dbo.UpdUsuarioEmail
	@CodigoUsuario varchar(20),
	@Email varchar(50),
	@CampaniaActivacionEmail int
AS
BEGIN
	set nocount on;
	declare @FechaModificacion datetime = dbo.fnObtenerFechaHoraPais();

	update dbo.Usuario
	set
		EMail = @Email,
		EMailActivo = 1,
		CampaniaActivacionEmail = @CampaniaActivacionEmail,
		Modificado = 1,
		FechaModificacion = @FechaModificacion
	where CodigoUsuario = @CodigoUsuario;
END

GO
