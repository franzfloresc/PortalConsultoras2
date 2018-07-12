USE BelcorpPeru
GO

IF exists(select 1 from sys.objects where type = 'P' and name = 'GetZonasOpcionesVerificacion')
BEGIN
	DROP PROC GetZonasOpcionesVerificacion
END
GO

CREATE PROC GetZonasOpcionesVerificacion
(
@RegionID int,
@ZonaID int
)
AS
BEGIN
	select 
		OlvideContrasenya,
		VerifAutenticidad,
		ActualizarDatos,
		CDR
	from [dbo].[ZonasOpcionesVerificacion]
	where RegionID = @RegionID AND ZonaID = @ZonaID;
END
GO

USE BelcorpMexico
GO

IF exists(select 1 from sys.objects where type = 'P' and name = 'GetZonasOpcionesVerificacion')
BEGIN
	DROP PROC GetZonasOpcionesVerificacion
END
GO

CREATE PROC GetZonasOpcionesVerificacion
(
@RegionID int,
@ZonaID int
)
AS
BEGIN
	select 
		OlvideContrasenya,
		VerifAutenticidad,
		ActualizarDatos,
		CDR
	from [dbo].[ZonasOpcionesVerificacion]
	where RegionID = @RegionID AND ZonaID = @ZonaID;
END
GO

USE BelcorpColombia
GO

IF exists(select 1 from sys.objects where type = 'P' and name = 'GetZonasOpcionesVerificacion')
BEGIN
	DROP PROC GetZonasOpcionesVerificacion
END
GO

CREATE PROC GetZonasOpcionesVerificacion
(
@RegionID int,
@ZonaID int
)
AS
BEGIN
	select 
		OlvideContrasenya,
		VerifAutenticidad,
		ActualizarDatos,
		CDR
	from [dbo].[ZonasOpcionesVerificacion]
	where RegionID = @RegionID AND ZonaID = @ZonaID;
END
GO

USE BelcorpSalvador
GO

IF exists(select 1 from sys.objects where type = 'P' and name = 'GetZonasOpcionesVerificacion')
BEGIN
	DROP PROC GetZonasOpcionesVerificacion
END
GO

CREATE PROC GetZonasOpcionesVerificacion
(
@RegionID int,
@ZonaID int
)
AS
BEGIN
	select 
		OlvideContrasenya,
		VerifAutenticidad,
		ActualizarDatos,
		CDR
	from [dbo].[ZonasOpcionesVerificacion]
	where RegionID = @RegionID AND ZonaID = @ZonaID;
END
GO

USE BelcorpPuertoRico
GO

IF exists(select 1 from sys.objects where type = 'P' and name = 'GetZonasOpcionesVerificacion')
BEGIN
	DROP PROC GetZonasOpcionesVerificacion
END
GO

CREATE PROC GetZonasOpcionesVerificacion
(
@RegionID int,
@ZonaID int
)
AS
BEGIN
	select 
		OlvideContrasenya,
		VerifAutenticidad,
		ActualizarDatos,
		CDR
	from [dbo].[ZonasOpcionesVerificacion]
	where RegionID = @RegionID AND ZonaID = @ZonaID;
END
GO

USE BelcorpPanama
GO

IF exists(select 1 from sys.objects where type = 'P' and name = 'GetZonasOpcionesVerificacion')
BEGIN
	DROP PROC GetZonasOpcionesVerificacion
END
GO

CREATE PROC GetZonasOpcionesVerificacion
(
@RegionID int,
@ZonaID int
)
AS
BEGIN
	select 
		OlvideContrasenya,
		VerifAutenticidad,
		ActualizarDatos,
		CDR
	from [dbo].[ZonasOpcionesVerificacion]
	where RegionID = @RegionID AND ZonaID = @ZonaID;
END
GO

USE BelcorpGuatemala
GO

IF exists(select 1 from sys.objects where type = 'P' and name = 'GetZonasOpcionesVerificacion')
BEGIN
	DROP PROC GetZonasOpcionesVerificacion
END
GO

CREATE PROC GetZonasOpcionesVerificacion
(
@RegionID int,
@ZonaID int
)
AS
BEGIN
	select 
		OlvideContrasenya,
		VerifAutenticidad,
		ActualizarDatos,
		CDR
	from [dbo].[ZonasOpcionesVerificacion]
	where RegionID = @RegionID AND ZonaID = @ZonaID;
END
GO

USE BelcorpEcuador
GO

IF exists(select 1 from sys.objects where type = 'P' and name = 'GetZonasOpcionesVerificacion')
BEGIN
	DROP PROC GetZonasOpcionesVerificacion
END
GO

CREATE PROC GetZonasOpcionesVerificacion
(
@RegionID int,
@ZonaID int
)
AS
BEGIN
	select 
		OlvideContrasenya,
		VerifAutenticidad,
		ActualizarDatos,
		CDR
	from [dbo].[ZonasOpcionesVerificacion]
	where RegionID = @RegionID AND ZonaID = @ZonaID;
END
GO

USE BelcorpDominicana
GO

IF exists(select 1 from sys.objects where type = 'P' and name = 'GetZonasOpcionesVerificacion')
BEGIN
	DROP PROC GetZonasOpcionesVerificacion
END
GO

CREATE PROC GetZonasOpcionesVerificacion
(
@RegionID int,
@ZonaID int
)
AS
BEGIN
	select 
		OlvideContrasenya,
		VerifAutenticidad,
		ActualizarDatos,
		CDR
	from [dbo].[ZonasOpcionesVerificacion]
	where RegionID = @RegionID AND ZonaID = @ZonaID;
END
GO

USE BelcorpCostaRica
GO

IF exists(select 1 from sys.objects where type = 'P' and name = 'GetZonasOpcionesVerificacion')
BEGIN
	DROP PROC GetZonasOpcionesVerificacion
END
GO

CREATE PROC GetZonasOpcionesVerificacion
(
@RegionID int,
@ZonaID int
)
AS
BEGIN
	select 
		OlvideContrasenya,
		VerifAutenticidad,
		ActualizarDatos,
		CDR
	from [dbo].[ZonasOpcionesVerificacion]
	where RegionID = @RegionID AND ZonaID = @ZonaID;
END
GO

USE BelcorpChile
GO

IF exists(select 1 from sys.objects where type = 'P' and name = 'GetZonasOpcionesVerificacion')
BEGIN
	DROP PROC GetZonasOpcionesVerificacion
END
GO

CREATE PROC GetZonasOpcionesVerificacion
(
@RegionID int,
@ZonaID int
)
AS
BEGIN
	select 
		OlvideContrasenya,
		VerifAutenticidad,
		ActualizarDatos,
		CDR
	from [dbo].[ZonasOpcionesVerificacion]
	where RegionID = @RegionID AND ZonaID = @ZonaID;
END
GO

USE BelcorpBolivia
GO

IF exists(select 1 from sys.objects where type = 'P' and name = 'GetZonasOpcionesVerificacion')
BEGIN
	DROP PROC GetZonasOpcionesVerificacion
END
GO

CREATE PROC GetZonasOpcionesVerificacion
(
@RegionID int,
@ZonaID int
)
AS
BEGIN
	select 
		OlvideContrasenya,
		VerifAutenticidad,
		ActualizarDatos,
		CDR
	from [dbo].[ZonasOpcionesVerificacion]
	where RegionID = @RegionID AND ZonaID = @ZonaID;
END
GO

