USE BelcorpPeru
GO

/* ALTER GetVerificarCodigo */
IF (OBJECT_ID ( 'dbo.GetVerificarCodigo', 'P' ) IS NULL)
    EXEC('CREATE PROCEDURE dbo.GetVerificarCodigo AS SET NOCOUNT ON;')
GO

/* GetVerificarCodigo */
ALTER PROC [dbo].[GetVerificarCodigo] 
(
	@CodigoUsuario varchar(20),
	@OrigenID int,
	@CodigoIngresado varchar(8),
	@IdEstadoActividad int,
	@SoloValidar bit = 0
)
AS
BEGIN 
	DECLARE @Iguales bit = 0
	if exists(
	SELECT 
		1
	FROM [dbo].[CodigoGenerado]
	WHERE CodigoUsuario = @CodigoUsuario
	and OrigenID = @OrigenID
	and CodigoGenerado = Rtrim(@CodigoIngresado))
	Begin
		Update Usuario Set VerificacionEstadoActividad = @IdEstadoActividad where CodigoUsuario = @CodigoUsuario and @SoloValidar = 0
		set @Iguales = 1
	End
	select @Iguales as SonIguales
END
GO

USE BelcorpMexico
GO

/* ALTER GetVerificarCodigo */
IF (OBJECT_ID ( 'dbo.GetVerificarCodigo', 'P' ) IS NULL)
    EXEC('CREATE PROCEDURE dbo.GetVerificarCodigo AS SET NOCOUNT ON;')
GO

/* GetVerificarCodigo */
ALTER PROC [dbo].[GetVerificarCodigo] 
(
	@CodigoUsuario varchar(20),
	@OrigenID int,
	@CodigoIngresado varchar(8),
	@IdEstadoActividad int,
	@SoloValidar bit = 0
)
AS
BEGIN 
	DECLARE @Iguales bit = 0
	if exists(
	SELECT 
		1
	FROM [dbo].[CodigoGenerado]
	WHERE CodigoUsuario = @CodigoUsuario
	and OrigenID = @OrigenID
	and CodigoGenerado = Rtrim(@CodigoIngresado))
	Begin
		Update Usuario Set VerificacionEstadoActividad = @IdEstadoActividad where CodigoUsuario = @CodigoUsuario and @SoloValidar = 0
		set @Iguales = 1
	End
	select @Iguales as SonIguales
END
GO

USE BelcorpColombia
GO

/* ALTER GetVerificarCodigo */
IF (OBJECT_ID ( 'dbo.GetVerificarCodigo', 'P' ) IS NULL)
    EXEC('CREATE PROCEDURE dbo.GetVerificarCodigo AS SET NOCOUNT ON;')
GO

/* GetVerificarCodigo */
ALTER PROC [dbo].[GetVerificarCodigo] 
(
	@CodigoUsuario varchar(20),
	@OrigenID int,
	@CodigoIngresado varchar(8),
	@IdEstadoActividad int,
	@SoloValidar bit = 0
)
AS
BEGIN 
	DECLARE @Iguales bit = 0
	if exists(
	SELECT 
		1
	FROM [dbo].[CodigoGenerado]
	WHERE CodigoUsuario = @CodigoUsuario
	and OrigenID = @OrigenID
	and CodigoGenerado = Rtrim(@CodigoIngresado))
	Begin
		Update Usuario Set VerificacionEstadoActividad = @IdEstadoActividad where CodigoUsuario = @CodigoUsuario and @SoloValidar = 0
		set @Iguales = 1
	End
	select @Iguales as SonIguales
END
GO

USE BelcorpSalvador
GO

/* ALTER GetVerificarCodigo */
IF (OBJECT_ID ( 'dbo.GetVerificarCodigo', 'P' ) IS NULL)
    EXEC('CREATE PROCEDURE dbo.GetVerificarCodigo AS SET NOCOUNT ON;')
GO

/* GetVerificarCodigo */
ALTER PROC [dbo].[GetVerificarCodigo] 
(
	@CodigoUsuario varchar(20),
	@OrigenID int,
	@CodigoIngresado varchar(8),
	@IdEstadoActividad int,
	@SoloValidar bit = 0
)
AS
BEGIN 
	DECLARE @Iguales bit = 0
	if exists(
	SELECT 
		1
	FROM [dbo].[CodigoGenerado]
	WHERE CodigoUsuario = @CodigoUsuario
	and OrigenID = @OrigenID
	and CodigoGenerado = Rtrim(@CodigoIngresado))
	Begin
		Update Usuario Set VerificacionEstadoActividad = @IdEstadoActividad where CodigoUsuario = @CodigoUsuario and @SoloValidar = 0
		set @Iguales = 1
	End
	select @Iguales as SonIguales
END
GO

USE BelcorpPuertoRico
GO

/* ALTER GetVerificarCodigo */
IF (OBJECT_ID ( 'dbo.GetVerificarCodigo', 'P' ) IS NULL)
    EXEC('CREATE PROCEDURE dbo.GetVerificarCodigo AS SET NOCOUNT ON;')
GO

/* GetVerificarCodigo */
ALTER PROC [dbo].[GetVerificarCodigo] 
(
	@CodigoUsuario varchar(20),
	@OrigenID int,
	@CodigoIngresado varchar(8),
	@IdEstadoActividad int,
	@SoloValidar bit = 0
)
AS
BEGIN 
	DECLARE @Iguales bit = 0
	if exists(
	SELECT 
		1
	FROM [dbo].[CodigoGenerado]
	WHERE CodigoUsuario = @CodigoUsuario
	and OrigenID = @OrigenID
	and CodigoGenerado = Rtrim(@CodigoIngresado))
	Begin
		Update Usuario Set VerificacionEstadoActividad = @IdEstadoActividad where CodigoUsuario = @CodigoUsuario and @SoloValidar = 0
		set @Iguales = 1
	End
	select @Iguales as SonIguales
END
GO

USE BelcorpPanama
GO

/* ALTER GetVerificarCodigo */
IF (OBJECT_ID ( 'dbo.GetVerificarCodigo', 'P' ) IS NULL)
    EXEC('CREATE PROCEDURE dbo.GetVerificarCodigo AS SET NOCOUNT ON;')
GO

/* GetVerificarCodigo */
ALTER PROC [dbo].[GetVerificarCodigo] 
(
	@CodigoUsuario varchar(20),
	@OrigenID int,
	@CodigoIngresado varchar(8),
	@IdEstadoActividad int,
	@SoloValidar bit = 0
)
AS
BEGIN 
	DECLARE @Iguales bit = 0
	if exists(
	SELECT 
		1
	FROM [dbo].[CodigoGenerado]
	WHERE CodigoUsuario = @CodigoUsuario
	and OrigenID = @OrigenID
	and CodigoGenerado = Rtrim(@CodigoIngresado))
	Begin
		Update Usuario Set VerificacionEstadoActividad = @IdEstadoActividad where CodigoUsuario = @CodigoUsuario and @SoloValidar = 0
		set @Iguales = 1
	End
	select @Iguales as SonIguales
END
GO

USE BelcorpGuatemala
GO

/* ALTER GetVerificarCodigo */
IF (OBJECT_ID ( 'dbo.GetVerificarCodigo', 'P' ) IS NULL)
    EXEC('CREATE PROCEDURE dbo.GetVerificarCodigo AS SET NOCOUNT ON;')
GO

/* GetVerificarCodigo */
ALTER PROC [dbo].[GetVerificarCodigo] 
(
	@CodigoUsuario varchar(20),
	@OrigenID int,
	@CodigoIngresado varchar(8),
	@IdEstadoActividad int,
	@SoloValidar bit = 0
)
AS
BEGIN 
	DECLARE @Iguales bit = 0
	if exists(
	SELECT 
		1
	FROM [dbo].[CodigoGenerado]
	WHERE CodigoUsuario = @CodigoUsuario
	and OrigenID = @OrigenID
	and CodigoGenerado = Rtrim(@CodigoIngresado))
	Begin
		Update Usuario Set VerificacionEstadoActividad = @IdEstadoActividad where CodigoUsuario = @CodigoUsuario and @SoloValidar = 0
		set @Iguales = 1
	End
	select @Iguales as SonIguales
END
GO

USE BelcorpEcuador
GO

/* ALTER GetVerificarCodigo */
IF (OBJECT_ID ( 'dbo.GetVerificarCodigo', 'P' ) IS NULL)
    EXEC('CREATE PROCEDURE dbo.GetVerificarCodigo AS SET NOCOUNT ON;')
GO

/* GetVerificarCodigo */
ALTER PROC [dbo].[GetVerificarCodigo] 
(
	@CodigoUsuario varchar(20),
	@OrigenID int,
	@CodigoIngresado varchar(8),
	@IdEstadoActividad int,
	@SoloValidar bit = 0
)
AS
BEGIN 
	DECLARE @Iguales bit = 0
	if exists(
	SELECT 
		1
	FROM [dbo].[CodigoGenerado]
	WHERE CodigoUsuario = @CodigoUsuario
	and OrigenID = @OrigenID
	and CodigoGenerado = Rtrim(@CodigoIngresado))
	Begin
		Update Usuario Set VerificacionEstadoActividad = @IdEstadoActividad where CodigoUsuario = @CodigoUsuario and @SoloValidar = 0
		set @Iguales = 1
	End
	select @Iguales as SonIguales
END
GO

USE BelcorpDominicana
GO

/* ALTER GetVerificarCodigo */
IF (OBJECT_ID ( 'dbo.GetVerificarCodigo', 'P' ) IS NULL)
    EXEC('CREATE PROCEDURE dbo.GetVerificarCodigo AS SET NOCOUNT ON;')
GO

/* GetVerificarCodigo */
ALTER PROC [dbo].[GetVerificarCodigo] 
(
	@CodigoUsuario varchar(20),
	@OrigenID int,
	@CodigoIngresado varchar(8),
	@IdEstadoActividad int,
	@SoloValidar bit = 0
)
AS
BEGIN 
	DECLARE @Iguales bit = 0
	if exists(
	SELECT 
		1
	FROM [dbo].[CodigoGenerado]
	WHERE CodigoUsuario = @CodigoUsuario
	and OrigenID = @OrigenID
	and CodigoGenerado = Rtrim(@CodigoIngresado))
	Begin
		Update Usuario Set VerificacionEstadoActividad = @IdEstadoActividad where CodigoUsuario = @CodigoUsuario and @SoloValidar = 0
		set @Iguales = 1
	End
	select @Iguales as SonIguales
END
GO

USE BelcorpCostaRica
GO

/* ALTER GetVerificarCodigo */
IF (OBJECT_ID ( 'dbo.GetVerificarCodigo', 'P' ) IS NULL)
    EXEC('CREATE PROCEDURE dbo.GetVerificarCodigo AS SET NOCOUNT ON;')
GO

/* GetVerificarCodigo */
ALTER PROC [dbo].[GetVerificarCodigo] 
(
	@CodigoUsuario varchar(20),
	@OrigenID int,
	@CodigoIngresado varchar(8),
	@IdEstadoActividad int,
	@SoloValidar bit = 0
)
AS
BEGIN 
	DECLARE @Iguales bit = 0
	if exists(
	SELECT 
		1
	FROM [dbo].[CodigoGenerado]
	WHERE CodigoUsuario = @CodigoUsuario
	and OrigenID = @OrigenID
	and CodigoGenerado = Rtrim(@CodigoIngresado))
	Begin
		Update Usuario Set VerificacionEstadoActividad = @IdEstadoActividad where CodigoUsuario = @CodigoUsuario and @SoloValidar = 0
		set @Iguales = 1
	End
	select @Iguales as SonIguales
END
GO

USE BelcorpChile
GO

/* ALTER GetVerificarCodigo */
IF (OBJECT_ID ( 'dbo.GetVerificarCodigo', 'P' ) IS NULL)
    EXEC('CREATE PROCEDURE dbo.GetVerificarCodigo AS SET NOCOUNT ON;')
GO

/* GetVerificarCodigo */
ALTER PROC [dbo].[GetVerificarCodigo] 
(
	@CodigoUsuario varchar(20),
	@OrigenID int,
	@CodigoIngresado varchar(8),
	@IdEstadoActividad int,
	@SoloValidar bit = 0
)
AS
BEGIN 
	DECLARE @Iguales bit = 0
	if exists(
	SELECT 
		1
	FROM [dbo].[CodigoGenerado]
	WHERE CodigoUsuario = @CodigoUsuario
	and OrigenID = @OrigenID
	and CodigoGenerado = Rtrim(@CodigoIngresado))
	Begin
		Update Usuario Set VerificacionEstadoActividad = @IdEstadoActividad where CodigoUsuario = @CodigoUsuario and @SoloValidar = 0
		set @Iguales = 1
	End
	select @Iguales as SonIguales
END
GO

USE BelcorpBolivia
GO

/* ALTER GetVerificarCodigo */
IF (OBJECT_ID ( 'dbo.GetVerificarCodigo', 'P' ) IS NULL)
    EXEC('CREATE PROCEDURE dbo.GetVerificarCodigo AS SET NOCOUNT ON;')
GO

/* GetVerificarCodigo */
ALTER PROC [dbo].[GetVerificarCodigo] 
(
	@CodigoUsuario varchar(20),
	@OrigenID int,
	@CodigoIngresado varchar(8),
	@IdEstadoActividad int,
	@SoloValidar bit = 0
)
AS
BEGIN 
	DECLARE @Iguales bit = 0
	if exists(
	SELECT 
		1
	FROM [dbo].[CodigoGenerado]
	WHERE CodigoUsuario = @CodigoUsuario
	and OrigenID = @OrigenID
	and CodigoGenerado = Rtrim(@CodigoIngresado))
	Begin
		Update Usuario Set VerificacionEstadoActividad = @IdEstadoActividad where CodigoUsuario = @CodigoUsuario and @SoloValidar = 0
		set @Iguales = 1
	End
	select @Iguales as SonIguales
END
GO

