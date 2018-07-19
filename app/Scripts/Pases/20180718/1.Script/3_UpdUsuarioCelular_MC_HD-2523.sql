USE BelcorpPeru
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.UpdUsuarioCelular') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.UpdUsuarioCelular
GO

CREATE PROCEDURE dbo.UpdUsuarioCelular
	@CodigoUsuario varchar(20),
	@Celular varchar(20)
AS
BEGIN
	SET NOCOUNT ON;
	declare @FechaModificacion datetime = dbo.fnObtenerFechaHoraPais();
	update dbo.Usuario
	set
		Celular = @Celular,
		Modificado = 1,
		FechaModificacion = @FechaModificacion
	where CodigoUsuario = @CodigoUsuario;
END


GO
USE BelcorpMexico
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.UpdUsuarioCelular') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.UpdUsuarioCelular
GO

CREATE PROCEDURE dbo.UpdUsuarioCelular
	@CodigoUsuario varchar(20),
	@Celular varchar(20)
AS
BEGIN
	SET NOCOUNT ON;
	declare @FechaModificacion datetime = dbo.fnObtenerFechaHoraPais();
	update dbo.Usuario
	set
		Celular = @Celular,
		Modificado = 1,
		FechaModificacion = @FechaModificacion
	where CodigoUsuario = @CodigoUsuario;
END


GO
USE BelcorpColombia
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.UpdUsuarioCelular') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.UpdUsuarioCelular
GO

CREATE PROCEDURE dbo.UpdUsuarioCelular
	@CodigoUsuario varchar(20),
	@Celular varchar(20)
AS
BEGIN
	SET NOCOUNT ON;
	declare @FechaModificacion datetime = dbo.fnObtenerFechaHoraPais();
	update dbo.Usuario
	set
		Celular = @Celular,
		Modificado = 1,
		FechaModificacion = @FechaModificacion
	where CodigoUsuario = @CodigoUsuario;
END


GO
USE BelcorpSalvador
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.UpdUsuarioCelular') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.UpdUsuarioCelular
GO

CREATE PROCEDURE dbo.UpdUsuarioCelular
	@CodigoUsuario varchar(20),
	@Celular varchar(20)
AS
BEGIN
	SET NOCOUNT ON;
	declare @FechaModificacion datetime = dbo.fnObtenerFechaHoraPais();
	update dbo.Usuario
	set
		Celular = @Celular,
		Modificado = 1,
		FechaModificacion = @FechaModificacion
	where CodigoUsuario = @CodigoUsuario;
END


GO
USE BelcorpPuertoRico
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.UpdUsuarioCelular') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.UpdUsuarioCelular
GO

CREATE PROCEDURE dbo.UpdUsuarioCelular
	@CodigoUsuario varchar(20),
	@Celular varchar(20)
AS
BEGIN
	SET NOCOUNT ON;
	declare @FechaModificacion datetime = dbo.fnObtenerFechaHoraPais();
	update dbo.Usuario
	set
		Celular = @Celular,
		Modificado = 1,
		FechaModificacion = @FechaModificacion
	where CodigoUsuario = @CodigoUsuario;
END


GO
USE BelcorpPanama
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.UpdUsuarioCelular') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.UpdUsuarioCelular
GO

CREATE PROCEDURE dbo.UpdUsuarioCelular
	@CodigoUsuario varchar(20),
	@Celular varchar(20)
AS
BEGIN
	SET NOCOUNT ON;
	declare @FechaModificacion datetime = dbo.fnObtenerFechaHoraPais();
	update dbo.Usuario
	set
		Celular = @Celular,
		Modificado = 1,
		FechaModificacion = @FechaModificacion
	where CodigoUsuario = @CodigoUsuario;
END


GO
USE BelcorpGuatemala
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.UpdUsuarioCelular') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.UpdUsuarioCelular
GO

CREATE PROCEDURE dbo.UpdUsuarioCelular
	@CodigoUsuario varchar(20),
	@Celular varchar(20)
AS
BEGIN
	SET NOCOUNT ON;
	declare @FechaModificacion datetime = dbo.fnObtenerFechaHoraPais();
	update dbo.Usuario
	set
		Celular = @Celular,
		Modificado = 1,
		FechaModificacion = @FechaModificacion
	where CodigoUsuario = @CodigoUsuario;
END


GO
USE BelcorpEcuador
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.UpdUsuarioCelular') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.UpdUsuarioCelular
GO

CREATE PROCEDURE dbo.UpdUsuarioCelular
	@CodigoUsuario varchar(20),
	@Celular varchar(20)
AS
BEGIN
	SET NOCOUNT ON;
	declare @FechaModificacion datetime = dbo.fnObtenerFechaHoraPais();
	update dbo.Usuario
	set
		Celular = @Celular,
		Modificado = 1,
		FechaModificacion = @FechaModificacion
	where CodigoUsuario = @CodigoUsuario;
END


GO
USE BelcorpDominicana
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.UpdUsuarioCelular') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.UpdUsuarioCelular
GO

CREATE PROCEDURE dbo.UpdUsuarioCelular
	@CodigoUsuario varchar(20),
	@Celular varchar(20)
AS
BEGIN
	SET NOCOUNT ON;
	declare @FechaModificacion datetime = dbo.fnObtenerFechaHoraPais();
	update dbo.Usuario
	set
		Celular = @Celular,
		Modificado = 1,
		FechaModificacion = @FechaModificacion
	where CodigoUsuario = @CodigoUsuario;
END


GO
USE BelcorpCostaRica
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.UpdUsuarioCelular') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.UpdUsuarioCelular
GO

CREATE PROCEDURE dbo.UpdUsuarioCelular
	@CodigoUsuario varchar(20),
	@Celular varchar(20)
AS
BEGIN
	SET NOCOUNT ON;
	declare @FechaModificacion datetime = dbo.fnObtenerFechaHoraPais();
	update dbo.Usuario
	set
		Celular = @Celular,
		Modificado = 1,
		FechaModificacion = @FechaModificacion
	where CodigoUsuario = @CodigoUsuario;
END


GO
USE BelcorpChile
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.UpdUsuarioCelular') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.UpdUsuarioCelular
GO

CREATE PROCEDURE dbo.UpdUsuarioCelular
	@CodigoUsuario varchar(20),
	@Celular varchar(20)
AS
BEGIN
	SET NOCOUNT ON;
	declare @FechaModificacion datetime = dbo.fnObtenerFechaHoraPais();
	update dbo.Usuario
	set
		Celular = @Celular,
		Modificado = 1,
		FechaModificacion = @FechaModificacion
	where CodigoUsuario = @CodigoUsuario;
END


GO
USE BelcorpBolivia
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.UpdUsuarioCelular') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.UpdUsuarioCelular
GO

CREATE PROCEDURE dbo.UpdUsuarioCelular
	@CodigoUsuario varchar(20),
	@Celular varchar(20)
AS
BEGIN
	SET NOCOUNT ON;
	declare @FechaModificacion datetime = dbo.fnObtenerFechaHoraPais();
	update dbo.Usuario
	set
		Celular = @Celular,
		Modificado = 1,
		FechaModificacion = @FechaModificacion
	where CodigoUsuario = @CodigoUsuario;
END


GO
