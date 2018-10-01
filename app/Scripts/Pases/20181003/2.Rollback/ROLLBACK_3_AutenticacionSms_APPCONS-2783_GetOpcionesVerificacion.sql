USE BelcorpPeru
GO

/* ALTER GetOpcionesVerificacion */
IF (OBJECT_ID ( 'dbo.GetOpcionesVerificacion', 'P' ) IS NULL)
    EXEC('CREATE PROCEDURE dbo.GetOpcionesVerificacion AS SET NOCOUNT ON;')
GO

-- GetOpcionesVerificacion 2
ALTER PROC GetOpcionesVerificacion
(
@OrigenID int
)
AS
BEGIN
	select 
		OrigenID,
		OrigenDescripcion,
		IsNull(OpcionEmail, 0) as OpcionEmail,
		IsNull(OpcionSms, 0) as OpcionSms,
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

/* ALTER GetOpcionesVerificacion */
IF (OBJECT_ID ( 'dbo.GetOpcionesVerificacion', 'P' ) IS NULL)
    EXEC('CREATE PROCEDURE dbo.GetOpcionesVerificacion AS SET NOCOUNT ON;')
GO
-- GetOpcionesVerificacion 2
ALTER PROC GetOpcionesVerificacion
(
@OrigenID int
)
AS
BEGIN
	select 
		OrigenID,
		OrigenDescripcion,
		IsNull(OpcionEmail, 0) as OpcionEmail,
		IsNull(OpcionSms, 0) as OpcionSms,
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

/* ALTER GetOpcionesVerificacion */
IF (OBJECT_ID ( 'dbo.GetOpcionesVerificacion', 'P' ) IS NULL)
    EXEC('CREATE PROCEDURE dbo.GetOpcionesVerificacion AS SET NOCOUNT ON;')
GO
-- GetOpcionesVerificacion 2
ALTER PROC GetOpcionesVerificacion
(
@OrigenID int
)
AS
BEGIN
	select 
		OrigenID,
		OrigenDescripcion,
		IsNull(OpcionEmail, 0) as OpcionEmail,
		IsNull(OpcionSms, 0) as OpcionSms,
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

/* ALTER GetOpcionesVerificacion */
IF (OBJECT_ID ( 'dbo.GetOpcionesVerificacion', 'P' ) IS NULL)
    EXEC('CREATE PROCEDURE dbo.GetOpcionesVerificacion AS SET NOCOUNT ON;')
GO
-- GetOpcionesVerificacion 2
CREATE PROC GetOpcionesVerificacion
(
@OrigenID int
)
AS
BEGIN
	select 
		OrigenID,
		OrigenDescripcion,
		IsNull(OpcionEmail, 0) as OpcionEmail,
		IsNull(OpcionSms, 0) as OpcionSms,
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

/* ALTER GetOpcionesVerificacion */
IF (OBJECT_ID ( 'dbo.GetOpcionesVerificacion', 'P' ) IS NULL)
    EXEC('CREATE PROCEDURE dbo.GetOpcionesVerificacion AS SET NOCOUNT ON;')
GO
-- GetOpcionesVerificacion 2
ALTER PROC GetOpcionesVerificacion
(
@OrigenID int
)
AS
BEGIN
	select 
		OrigenID,
		OrigenDescripcion,
		IsNull(OpcionEmail, 0) as OpcionEmail,
		IsNull(OpcionSms, 0) as OpcionSms,
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

/* ALTER GetOpcionesVerificacion */
IF (OBJECT_ID ( 'dbo.GetOpcionesVerificacion', 'P' ) IS NULL)
    EXEC('CREATE PROCEDURE dbo.GetOpcionesVerificacion AS SET NOCOUNT ON;')
GO
-- GetOpcionesVerificacion 2
ALTER PROC GetOpcionesVerificacion
(
@OrigenID int
)
AS
BEGIN
	select 
		OrigenID,
		OrigenDescripcion,
		IsNull(OpcionEmail, 0) as OpcionEmail,
		IsNull(OpcionSms, 0) as OpcionSms,
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

/* ALTER GetOpcionesVerificacion */
IF (OBJECT_ID ( 'dbo.GetOpcionesVerificacion', 'P' ) IS NULL)
    EXEC('CREATE PROCEDURE dbo.GetOpcionesVerificacion AS SET NOCOUNT ON;')
GO
-- GetOpcionesVerificacion 2
ALTER PROC GetOpcionesVerificacion
(
@OrigenID int
)
AS
BEGIN
	select 
		OrigenID,
		OrigenDescripcion,
		IsNull(OpcionEmail, 0) as OpcionEmail,
		IsNull(OpcionSms, 0) as OpcionSms,
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

/* ALTER GetOpcionesVerificacion */
IF (OBJECT_ID ( 'dbo.GetOpcionesVerificacion', 'P' ) IS NULL)
    EXEC('CREATE PROCEDURE dbo.GetOpcionesVerificacion AS SET NOCOUNT ON;')
GO
-- GetOpcionesVerificacion 2
ALTER PROC GetOpcionesVerificacion
(
@OrigenID int
)
AS
BEGIN
	select 
		OrigenID,
		OrigenDescripcion,
		IsNull(OpcionEmail, 0) as OpcionEmail,
		IsNull(OpcionSms, 0) as OpcionSms,
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

/* ALTER GetOpcionesVerificacion */
IF (OBJECT_ID ( 'dbo.GetOpcionesVerificacion', 'P' ) IS NULL)
    EXEC('CREATE PROCEDURE dbo.GetOpcionesVerificacion AS SET NOCOUNT ON;')
GO
-- GetOpcionesVerificacion 2
ALTER PROC GetOpcionesVerificacion
(
@OrigenID int
)
AS
BEGIN
	select 
		OrigenID,
		OrigenDescripcion,
		IsNull(OpcionEmail, 0) as OpcionEmail,
		IsNull(OpcionSms, 0) as OpcionSms,
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

/* ALTER GetOpcionesVerificacion */
IF (OBJECT_ID ( 'dbo.GetOpcionesVerificacion', 'P' ) IS NULL)
    EXEC('CREATE PROCEDURE dbo.GetOpcionesVerificacion AS SET NOCOUNT ON;')
GO
-- GetOpcionesVerificacion 2
ALTER PROC GetOpcionesVerificacion
(
@OrigenID int
)
AS
BEGIN
	select 
		OrigenID,
		OrigenDescripcion,
		IsNull(OpcionEmail, 0) as OpcionEmail,
		IsNull(OpcionSms, 0) as OpcionSms,
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

/* ALTER GetOpcionesVerificacion */
IF (OBJECT_ID ( 'dbo.GetOpcionesVerificacion', 'P' ) IS NULL)
    EXEC('CREATE PROCEDURE dbo.GetOpcionesVerificacion AS SET NOCOUNT ON;')
GO
-- GetOpcionesVerificacion 2
ALTER PROC GetOpcionesVerificacion
(
@OrigenID int
)
AS
BEGIN
	select 
		OrigenID,
		OrigenDescripcion,
		IsNull(OpcionEmail, 0) as OpcionEmail,
		IsNull(OpcionSms, 0) as OpcionSms,
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

/* ALTER GetOpcionesVerificacion */
IF (OBJECT_ID ( 'dbo.GetOpcionesVerificacion', 'P' ) IS NULL)
    EXEC('CREATE PROCEDURE dbo.GetOpcionesVerificacion AS SET NOCOUNT ON;')
GO
-- GetOpcionesVerificacion 2
ALTER PROC GetOpcionesVerificacion
(
@OrigenID int
)
AS
BEGIN
	select 
		OrigenID,
		OrigenDescripcion,
		IsNull(OpcionEmail, 0) as OpcionEmail,
		IsNull(OpcionSms, 0) as OpcionSms,
		IsNull(OpcionChat, 0) as OpcionChat,
		IsNull(OpcionBelcorpResponde, 0) as OpcionBelcorpResponde,
		IsNull(IncluyeFiltros, 0) as IncluyeFiltros,
		IsNull(TieneZonas, 0) as TieneZonas
	from [dbo].[OpcionesVerificacion]
	where OrigenID = @OrigenID
	And IsNull(Activo, 0) = 1
END
GO

