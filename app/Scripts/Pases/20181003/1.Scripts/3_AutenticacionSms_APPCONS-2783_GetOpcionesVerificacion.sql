USE BelcorpPeru
GO

/* GetOpcionesVerificacion */
IF (OBJECT_ID ( 'dbo.GetOpcionesVerificacion', 'P' ) IS NULL)
    EXEC('CREATE PROCEDURE dbo.GetOpcionesVerificacion AS SET NOCOUNT ON;')
GO

ALTER PROC [dbo].[GetOpcionesVerificacion] (
	@OrigenID int )
AS
BEGIN
	select 
		OrigenID,
		OrigenDescripcion,
		IsNull(OpcionEmail, 0) as OpcionEmail,
		IsNull(OpcionSms, 0) as OpcionSms,
		IsNull(IntentosSms, 0) as IntentosSms,
		IsNull(OpcionContrasena, 0) as OpcionContrasena,
		IsNull(OpcionChat, 0) as OpcionChat,		
		IsNull(OpcionBelcorpResponde, 0) as OpcionBelcorpResponde,
		IsNull(IncluyeFiltros, 0) as IncluyeFiltros,
		IsNull(TieneZonas, 0) as TieneZonas
	from [dbo].[OpcionesVerificacion]
	where OrigenID = @OrigenID
	And IsNull(Activo, 0) = 1
END
GO

USE BelcorpMexico
GO

/* GetOpcionesVerificacion */
IF (OBJECT_ID ( 'dbo.GetOpcionesVerificacion', 'P' ) IS NULL)
    EXEC('CREATE PROCEDURE dbo.GetOpcionesVerificacion AS SET NOCOUNT ON;')
GO

ALTER PROC [dbo].[GetOpcionesVerificacion] (
	@OrigenID int )
AS
BEGIN
	select 
		OrigenID,
		OrigenDescripcion,
		IsNull(OpcionEmail, 0) as OpcionEmail,
		IsNull(OpcionSms, 0) as OpcionSms,
		IsNull(IntentosSms, 0) as IntentosSms,
		IsNull(OpcionContrasena, 0) as OpcionContrasena,
		IsNull(OpcionChat, 0) as OpcionChat,		
		IsNull(OpcionBelcorpResponde, 0) as OpcionBelcorpResponde,
		IsNull(IncluyeFiltros, 0) as IncluyeFiltros,
		IsNull(TieneZonas, 0) as TieneZonas
	from [dbo].[OpcionesVerificacion]
	where OrigenID = @OrigenID
	And IsNull(Activo, 0) = 1
END
GO

USE BelcorpColombia
GO

/* GetOpcionesVerificacion */
IF (OBJECT_ID ( 'dbo.GetOpcionesVerificacion', 'P' ) IS NULL)
    EXEC('CREATE PROCEDURE dbo.GetOpcionesVerificacion AS SET NOCOUNT ON;')
GO

ALTER PROC [dbo].[GetOpcionesVerificacion] (
	@OrigenID int )
AS
BEGIN
	select 
		OrigenID,
		OrigenDescripcion,
		IsNull(OpcionEmail, 0) as OpcionEmail,
		IsNull(OpcionSms, 0) as OpcionSms,
		IsNull(IntentosSms, 0) as IntentosSms,
		IsNull(OpcionContrasena, 0) as OpcionContrasena,
		IsNull(OpcionChat, 0) as OpcionChat,		
		IsNull(OpcionBelcorpResponde, 0) as OpcionBelcorpResponde,
		IsNull(IncluyeFiltros, 0) as IncluyeFiltros,
		IsNull(TieneZonas, 0) as TieneZonas
	from [dbo].[OpcionesVerificacion]
	where OrigenID = @OrigenID
	And IsNull(Activo, 0) = 1
END
GO

USE BelcorpSalvador
GO

/* GetOpcionesVerificacion */
IF (OBJECT_ID ( 'dbo.GetOpcionesVerificacion', 'P' ) IS NULL)
    EXEC('CREATE PROCEDURE dbo.GetOpcionesVerificacion AS SET NOCOUNT ON;')
GO

ALTER PROC [dbo].[GetOpcionesVerificacion] (
	@OrigenID int )
AS
BEGIN
	select 
		OrigenID,
		OrigenDescripcion,
		IsNull(OpcionEmail, 0) as OpcionEmail,
		IsNull(OpcionSms, 0) as OpcionSms,
		IsNull(IntentosSms, 0) as IntentosSms,
		IsNull(OpcionContrasena, 0) as OpcionContrasena,
		IsNull(OpcionChat, 0) as OpcionChat,		
		IsNull(OpcionBelcorpResponde, 0) as OpcionBelcorpResponde,
		IsNull(IncluyeFiltros, 0) as IncluyeFiltros,
		IsNull(TieneZonas, 0) as TieneZonas
	from [dbo].[OpcionesVerificacion]
	where OrigenID = @OrigenID
	And IsNull(Activo, 0) = 1
END
GO

USE BelcorpPuertoRico
GO

/* GetOpcionesVerificacion */
IF (OBJECT_ID ( 'dbo.GetOpcionesVerificacion', 'P' ) IS NULL)
    EXEC('CREATE PROCEDURE dbo.GetOpcionesVerificacion AS SET NOCOUNT ON;')
GO

ALTER PROC [dbo].[GetOpcionesVerificacion] (
	@OrigenID int )
AS
BEGIN
	select 
		OrigenID,
		OrigenDescripcion,
		IsNull(OpcionEmail, 0) as OpcionEmail,
		IsNull(OpcionSms, 0) as OpcionSms,
		IsNull(IntentosSms, 0) as IntentosSms,
		IsNull(OpcionContrasena, 0) as OpcionContrasena,
		IsNull(OpcionChat, 0) as OpcionChat,		
		IsNull(OpcionBelcorpResponde, 0) as OpcionBelcorpResponde,
		IsNull(IncluyeFiltros, 0) as IncluyeFiltros,
		IsNull(TieneZonas, 0) as TieneZonas
	from [dbo].[OpcionesVerificacion]
	where OrigenID = @OrigenID
	And IsNull(Activo, 0) = 1
END
GO

USE BelcorpPanama
GO

/* GetOpcionesVerificacion */
IF (OBJECT_ID ( 'dbo.GetOpcionesVerificacion', 'P' ) IS NULL)
    EXEC('CREATE PROCEDURE dbo.GetOpcionesVerificacion AS SET NOCOUNT ON;')
GO

ALTER PROC [dbo].[GetOpcionesVerificacion] (
	@OrigenID int )
AS
BEGIN
	select 
		OrigenID,
		OrigenDescripcion,
		IsNull(OpcionEmail, 0) as OpcionEmail,
		IsNull(OpcionSms, 0) as OpcionSms,
		IsNull(IntentosSms, 0) as IntentosSms,
		IsNull(OpcionContrasena, 0) as OpcionContrasena,
		IsNull(OpcionChat, 0) as OpcionChat,		
		IsNull(OpcionBelcorpResponde, 0) as OpcionBelcorpResponde,
		IsNull(IncluyeFiltros, 0) as IncluyeFiltros,
		IsNull(TieneZonas, 0) as TieneZonas
	from [dbo].[OpcionesVerificacion]
	where OrigenID = @OrigenID
	And IsNull(Activo, 0) = 1
END
GO

USE BelcorpGuatemala
GO

/* GetOpcionesVerificacion */
IF (OBJECT_ID ( 'dbo.GetOpcionesVerificacion', 'P' ) IS NULL)
    EXEC('CREATE PROCEDURE dbo.GetOpcionesVerificacion AS SET NOCOUNT ON;')
GO

ALTER PROC [dbo].[GetOpcionesVerificacion] (
	@OrigenID int )
AS
BEGIN
	select 
		OrigenID,
		OrigenDescripcion,
		IsNull(OpcionEmail, 0) as OpcionEmail,
		IsNull(OpcionSms, 0) as OpcionSms,
		IsNull(IntentosSms, 0) as IntentosSms,
		IsNull(OpcionContrasena, 0) as OpcionContrasena,
		IsNull(OpcionChat, 0) as OpcionChat,		
		IsNull(OpcionBelcorpResponde, 0) as OpcionBelcorpResponde,
		IsNull(IncluyeFiltros, 0) as IncluyeFiltros,
		IsNull(TieneZonas, 0) as TieneZonas
	from [dbo].[OpcionesVerificacion]
	where OrigenID = @OrigenID
	And IsNull(Activo, 0) = 1
END
GO

USE BelcorpEcuador
GO

/* GetOpcionesVerificacion */
IF (OBJECT_ID ( 'dbo.GetOpcionesVerificacion', 'P' ) IS NULL)
    EXEC('CREATE PROCEDURE dbo.GetOpcionesVerificacion AS SET NOCOUNT ON;')
GO

ALTER PROC [dbo].[GetOpcionesVerificacion] (
	@OrigenID int )
AS
BEGIN
	select 
		OrigenID,
		OrigenDescripcion,
		IsNull(OpcionEmail, 0) as OpcionEmail,
		IsNull(OpcionSms, 0) as OpcionSms,
		IsNull(IntentosSms, 0) as IntentosSms,
		IsNull(OpcionContrasena, 0) as OpcionContrasena,
		IsNull(OpcionChat, 0) as OpcionChat,		
		IsNull(OpcionBelcorpResponde, 0) as OpcionBelcorpResponde,
		IsNull(IncluyeFiltros, 0) as IncluyeFiltros,
		IsNull(TieneZonas, 0) as TieneZonas
	from [dbo].[OpcionesVerificacion]
	where OrigenID = @OrigenID
	And IsNull(Activo, 0) = 1
END
GO

USE BelcorpDominicana
GO

/* GetOpcionesVerificacion */
IF (OBJECT_ID ( 'dbo.GetOpcionesVerificacion', 'P' ) IS NULL)
    EXEC('CREATE PROCEDURE dbo.GetOpcionesVerificacion AS SET NOCOUNT ON;')
GO

ALTER PROC [dbo].[GetOpcionesVerificacion] (
	@OrigenID int )
AS
BEGIN
	select 
		OrigenID,
		OrigenDescripcion,
		IsNull(OpcionEmail, 0) as OpcionEmail,
		IsNull(OpcionSms, 0) as OpcionSms,
		IsNull(IntentosSms, 0) as IntentosSms,
		IsNull(OpcionContrasena, 0) as OpcionContrasena,
		IsNull(OpcionChat, 0) as OpcionChat,		
		IsNull(OpcionBelcorpResponde, 0) as OpcionBelcorpResponde,
		IsNull(IncluyeFiltros, 0) as IncluyeFiltros,
		IsNull(TieneZonas, 0) as TieneZonas
	from [dbo].[OpcionesVerificacion]
	where OrigenID = @OrigenID
	And IsNull(Activo, 0) = 1
END
GO

USE BelcorpCostaRica
GO

/* GetOpcionesVerificacion */
IF (OBJECT_ID ( 'dbo.GetOpcionesVerificacion', 'P' ) IS NULL)
    EXEC('CREATE PROCEDURE dbo.GetOpcionesVerificacion AS SET NOCOUNT ON;')
GO

ALTER PROC [dbo].[GetOpcionesVerificacion] (
	@OrigenID int )
AS
BEGIN
	select 
		OrigenID,
		OrigenDescripcion,
		IsNull(OpcionEmail, 0) as OpcionEmail,
		IsNull(OpcionSms, 0) as OpcionSms,
		IsNull(IntentosSms, 0) as IntentosSms,
		IsNull(OpcionContrasena, 0) as OpcionContrasena,
		IsNull(OpcionChat, 0) as OpcionChat,		
		IsNull(OpcionBelcorpResponde, 0) as OpcionBelcorpResponde,
		IsNull(IncluyeFiltros, 0) as IncluyeFiltros,
		IsNull(TieneZonas, 0) as TieneZonas
	from [dbo].[OpcionesVerificacion]
	where OrigenID = @OrigenID
	And IsNull(Activo, 0) = 1
END
GO

USE BelcorpChile
GO

/* GetOpcionesVerificacion */
IF (OBJECT_ID ( 'dbo.GetOpcionesVerificacion', 'P' ) IS NULL)
    EXEC('CREATE PROCEDURE dbo.GetOpcionesVerificacion AS SET NOCOUNT ON;')
GO

ALTER PROC [dbo].[GetOpcionesVerificacion] (
	@OrigenID int )
AS
BEGIN
	select 
		OrigenID,
		OrigenDescripcion,
		IsNull(OpcionEmail, 0) as OpcionEmail,
		IsNull(OpcionSms, 0) as OpcionSms,
		IsNull(IntentosSms, 0) as IntentosSms,
		IsNull(OpcionContrasena, 0) as OpcionContrasena,
		IsNull(OpcionChat, 0) as OpcionChat,		
		IsNull(OpcionBelcorpResponde, 0) as OpcionBelcorpResponde,
		IsNull(IncluyeFiltros, 0) as IncluyeFiltros,
		IsNull(TieneZonas, 0) as TieneZonas
	from [dbo].[OpcionesVerificacion]
	where OrigenID = @OrigenID
	And IsNull(Activo, 0) = 1
END
GO

USE BelcorpBolivia
GO

/* GetOpcionesVerificacion */
IF (OBJECT_ID ( 'dbo.GetOpcionesVerificacion', 'P' ) IS NULL)
    EXEC('CREATE PROCEDURE dbo.GetOpcionesVerificacion AS SET NOCOUNT ON;')
GO

ALTER PROC [dbo].[GetOpcionesVerificacion] (
	@OrigenID int )
AS
BEGIN
	select 
		OrigenID,
		OrigenDescripcion,
		IsNull(OpcionEmail, 0) as OpcionEmail,
		IsNull(OpcionSms, 0) as OpcionSms,
		IsNull(IntentosSms, 0) as IntentosSms,
		IsNull(OpcionContrasena, 0) as OpcionContrasena,
		IsNull(OpcionChat, 0) as OpcionChat,		
		IsNull(OpcionBelcorpResponde, 0) as OpcionBelcorpResponde,
		IsNull(IncluyeFiltros, 0) as IncluyeFiltros,
		IsNull(TieneZonas, 0) as TieneZonas
	from [dbo].[OpcionesVerificacion]
	where OrigenID = @OrigenID
	And IsNull(Activo, 0) = 1
END
GO

