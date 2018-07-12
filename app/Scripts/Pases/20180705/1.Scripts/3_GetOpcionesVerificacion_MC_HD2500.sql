USE BelcorpPeru
GO

IF exists(select 1 from sys.objects where type = 'P' and name = 'GetOpcionesVerificacion')
BEGIN
	DROP PROC GetOpcionesVerificacion
END
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

USE BelcorpMexico
GO

IF exists(select 1 from sys.objects where type = 'P' and name = 'GetOpcionesVerificacion')
BEGIN
	DROP PROC GetOpcionesVerificacion
END
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

USE BelcorpColombia
GO

IF exists(select 1 from sys.objects where type = 'P' and name = 'GetOpcionesVerificacion')
BEGIN
	DROP PROC GetOpcionesVerificacion
END
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

USE BelcorpSalvador
GO

IF exists(select 1 from sys.objects where type = 'P' and name = 'GetOpcionesVerificacion')
BEGIN
	DROP PROC GetOpcionesVerificacion
END
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

IF exists(select 1 from sys.objects where type = 'P' and name = 'GetOpcionesVerificacion')
BEGIN
	DROP PROC GetOpcionesVerificacion
END
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

USE BelcorpPanama
GO

IF exists(select 1 from sys.objects where type = 'P' and name = 'GetOpcionesVerificacion')
BEGIN
	DROP PROC GetOpcionesVerificacion
END
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

USE BelcorpGuatemala
GO

IF exists(select 1 from sys.objects where type = 'P' and name = 'GetOpcionesVerificacion')
BEGIN
	DROP PROC GetOpcionesVerificacion
END
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

USE BelcorpEcuador
GO

IF exists(select 1 from sys.objects where type = 'P' and name = 'GetOpcionesVerificacion')
BEGIN
	DROP PROC GetOpcionesVerificacion
END
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

USE BelcorpDominicana
GO

IF exists(select 1 from sys.objects where type = 'P' and name = 'GetOpcionesVerificacion')
BEGIN
	DROP PROC GetOpcionesVerificacion
END
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

USE BelcorpCostaRica
GO

IF exists(select 1 from sys.objects where type = 'P' and name = 'GetOpcionesVerificacion')
BEGIN
	DROP PROC GetOpcionesVerificacion
END
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

USE BelcorpChile
GO

IF exists(select 1 from sys.objects where type = 'P' and name = 'GetOpcionesVerificacion')
BEGIN
	DROP PROC GetOpcionesVerificacion
END
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

USE BelcorpBolivia
GO

IF exists(select 1 from sys.objects where type = 'P' and name = 'GetOpcionesVerificacion')
BEGIN
	DROP PROC GetOpcionesVerificacion
END
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

