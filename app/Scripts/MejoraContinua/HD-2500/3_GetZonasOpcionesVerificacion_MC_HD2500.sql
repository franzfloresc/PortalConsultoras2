USE BelcorpPeru
GO

IF exists(select 1 from sys.objects where type = 'P' and name = 'GetZonasOpcionesVerificacion')
BEGIN
	DROP PROC GetZonasOpcionesVerificacion
END
GO
-- GetZonasOpcionesVerificacion 2
CREATE PROC GetZonasOpcionesVerificacion
(
@OrigenID int
)
AS
BEGIN
	select 
		ZonaID,
		OrigenID
	from [dbo].[ZonasOpcionesVerificacion]
	where OrigenID = @OrigenID
	And IsNull(Activo, 0) = 1
END
GO

USE BelcorpMexico
GO

IF exists(select 1 from sys.objects where type = 'P' and name = 'GetZonasOpcionesVerificacion')
BEGIN
	DROP PROC GetZonasOpcionesVerificacion
END
GO
-- GetZonasOpcionesVerificacion 2
CREATE PROC GetZonasOpcionesVerificacion
(
@OrigenID int
)
AS
BEGIN
	select 
		ZonaID,
		OrigenID
	from [dbo].[ZonasOpcionesVerificacion]
	where OrigenID = @OrigenID
	And IsNull(Activo, 0) = 1
END
GO

USE BelcorpColombia
GO

IF exists(select 1 from sys.objects where type = 'P' and name = 'GetZonasOpcionesVerificacion')
BEGIN
	DROP PROC GetZonasOpcionesVerificacion
END
GO
-- GetZonasOpcionesVerificacion 2
CREATE PROC GetZonasOpcionesVerificacion
(
@OrigenID int
)
AS
BEGIN
	select 
		ZonaID,
		OrigenID
	from [dbo].[ZonasOpcionesVerificacion]
	where OrigenID = @OrigenID
	And IsNull(Activo, 0) = 1
END
GO

USE BelcorpSalvador
GO

IF exists(select 1 from sys.objects where type = 'P' and name = 'GetZonasOpcionesVerificacion')
BEGIN
	DROP PROC GetZonasOpcionesVerificacion
END
GO
-- GetZonasOpcionesVerificacion 2
CREATE PROC GetZonasOpcionesVerificacion
(
@OrigenID int
)
AS
BEGIN
	select 
		ZonaID,
		OrigenID
	from [dbo].[ZonasOpcionesVerificacion]
	where OrigenID = @OrigenID
	And IsNull(Activo, 0) = 1
END
GO

USE BelcorpPuertoRico
GO

IF exists(select 1 from sys.objects where type = 'P' and name = 'GetZonasOpcionesVerificacion')
BEGIN
	DROP PROC GetZonasOpcionesVerificacion
END
GO
-- GetZonasOpcionesVerificacion 2
CREATE PROC GetZonasOpcionesVerificacion
(
@OrigenID int
)
AS
BEGIN
	select 
		ZonaID,
		OrigenID
	from [dbo].[ZonasOpcionesVerificacion]
	where OrigenID = @OrigenID
	And IsNull(Activo, 0) = 1
END
GO

USE BelcorpPanama
GO

IF exists(select 1 from sys.objects where type = 'P' and name = 'GetZonasOpcionesVerificacion')
BEGIN
	DROP PROC GetZonasOpcionesVerificacion
END
GO
-- GetZonasOpcionesVerificacion 2
CREATE PROC GetZonasOpcionesVerificacion
(
@OrigenID int
)
AS
BEGIN
	select 
		ZonaID,
		OrigenID
	from [dbo].[ZonasOpcionesVerificacion]
	where OrigenID = @OrigenID
	And IsNull(Activo, 0) = 1
END
GO

USE BelcorpGuatemala
GO

IF exists(select 1 from sys.objects where type = 'P' and name = 'GetZonasOpcionesVerificacion')
BEGIN
	DROP PROC GetZonasOpcionesVerificacion
END
GO
-- GetZonasOpcionesVerificacion 2
CREATE PROC GetZonasOpcionesVerificacion
(
@OrigenID int
)
AS
BEGIN
	select 
		ZonaID,
		OrigenID
	from [dbo].[ZonasOpcionesVerificacion]
	where OrigenID = @OrigenID
	And IsNull(Activo, 0) = 1
END
GO

USE BelcorpEcuador
GO

IF exists(select 1 from sys.objects where type = 'P' and name = 'GetZonasOpcionesVerificacion')
BEGIN
	DROP PROC GetZonasOpcionesVerificacion
END
GO
-- GetZonasOpcionesVerificacion 2
CREATE PROC GetZonasOpcionesVerificacion
(
@OrigenID int
)
AS
BEGIN
	select 
		ZonaID,
		OrigenID
	from [dbo].[ZonasOpcionesVerificacion]
	where OrigenID = @OrigenID
	And IsNull(Activo, 0) = 1
END
GO

USE BelcorpDominicana
GO

IF exists(select 1 from sys.objects where type = 'P' and name = 'GetZonasOpcionesVerificacion')
BEGIN
	DROP PROC GetZonasOpcionesVerificacion
END
GO
-- GetZonasOpcionesVerificacion 2
CREATE PROC GetZonasOpcionesVerificacion
(
@OrigenID int
)
AS
BEGIN
	select 
		ZonaID,
		OrigenID
	from [dbo].[ZonasOpcionesVerificacion]
	where OrigenID = @OrigenID
	And IsNull(Activo, 0) = 1
END
GO

USE BelcorpCostaRica
GO

IF exists(select 1 from sys.objects where type = 'P' and name = 'GetZonasOpcionesVerificacion')
BEGIN
	DROP PROC GetZonasOpcionesVerificacion
END
GO
-- GetZonasOpcionesVerificacion 2
CREATE PROC GetZonasOpcionesVerificacion
(
@OrigenID int
)
AS
BEGIN
	select 
		ZonaID,
		OrigenID
	from [dbo].[ZonasOpcionesVerificacion]
	where OrigenID = @OrigenID
	And IsNull(Activo, 0) = 1
END
GO

USE BelcorpChile
GO

IF exists(select 1 from sys.objects where type = 'P' and name = 'GetZonasOpcionesVerificacion')
BEGIN
	DROP PROC GetZonasOpcionesVerificacion
END
GO
-- GetZonasOpcionesVerificacion 2
CREATE PROC GetZonasOpcionesVerificacion
(
@OrigenID int
)
AS
BEGIN
	select 
		ZonaID,
		OrigenID
	from [dbo].[ZonasOpcionesVerificacion]
	where OrigenID = @OrigenID
	And IsNull(Activo, 0) = 1
END
GO

USE BelcorpBolivia
GO

IF exists(select 1 from sys.objects where type = 'P' and name = 'GetZonasOpcionesVerificacion')
BEGIN
	DROP PROC GetZonasOpcionesVerificacion
END
GO
-- GetZonasOpcionesVerificacion 2
CREATE PROC GetZonasOpcionesVerificacion
(
@OrigenID int
)
AS
BEGIN
	select 
		ZonaID,
		OrigenID
	from [dbo].[ZonasOpcionesVerificacion]
	where OrigenID = @OrigenID
	And IsNull(Activo, 0) = 1
END
GO

