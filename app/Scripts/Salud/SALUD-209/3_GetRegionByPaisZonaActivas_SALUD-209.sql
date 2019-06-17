USE BelcorpBolivia
GO
IF EXISTS (SELECT * FROM sys.procedures where name ='GetRegionByPaisZonaActivas' and SCHEMA_NAME([schema_id]) ='dbo')
	DROP PROCEDURE dbo.GetRegionByPaisZonaActivas
GO
CREATE PROCEDURE [dbo].[GetRegionByPaisZonaActivas]
AS
BEGIN
	SET NOCOUNT ON;

	select
		r.RegionID,
		r.PaisID,
		r.Codigo,
		r.Descripcion AS Nombre
	from ods.Region r
	where
		exists(select 1 from ods.Zona z where Z.RegionID = r.RegionID  and z.EstadoActivo = 1 and Z.Nombre != 'CERRADA') and
		r.EstadoActivo =1
END
GO

USE BelcorpChile
GO
IF EXISTS (SELECT * FROM sys.procedures where name ='GetRegionByPaisZonaActivas' and SCHEMA_NAME([schema_id]) ='dbo')
	DROP PROCEDURE dbo.GetRegionByPaisZonaActivas
GO
CREATE PROCEDURE [dbo].[GetRegionByPaisZonaActivas]
AS
BEGIN
	SET NOCOUNT ON;

	select
		r.RegionID,
		r.PaisID,
		r.Codigo,
		r.Descripcion AS Nombre
	from ods.Region r
	where
		exists(select 1 from ods.Zona z where Z.RegionID = r.RegionID  and z.EstadoActivo = 1 and Z.Nombre != 'CERRADA') and
		r.EstadoActivo =1
END
GO

USE BelcorpColombia
GO
IF EXISTS (SELECT * FROM sys.procedures where name ='GetRegionByPaisZonaActivas' and SCHEMA_NAME([schema_id]) ='dbo')
	DROP PROCEDURE dbo.GetRegionByPaisZonaActivas
GO
CREATE PROCEDURE [dbo].[GetRegionByPaisZonaActivas]
AS
BEGIN
	SET NOCOUNT ON;

	select
		r.RegionID,
		r.PaisID,
		r.Codigo,
		r.Descripcion AS Nombre
	from ods.Region r
	where
		exists(select 1 from ods.Zona z where Z.RegionID = r.RegionID  and z.EstadoActivo = 1 and Z.Nombre != 'CERRADA') and
		r.EstadoActivo =1
END
GO

USE BelcorpCostaRica
GO
IF EXISTS (SELECT * FROM sys.procedures where name ='GetRegionByPaisZonaActivas' and SCHEMA_NAME([schema_id]) ='dbo')
	DROP PROCEDURE dbo.GetRegionByPaisZonaActivas
GO
CREATE PROCEDURE [dbo].[GetRegionByPaisZonaActivas]
AS
BEGIN
	SET NOCOUNT ON;

	select
		r.RegionID,
		r.PaisID,
		r.Codigo,
		r.Descripcion AS Nombre
	from ods.Region r
	where
		exists(select 1 from ods.Zona z where Z.RegionID = r.RegionID  and z.EstadoActivo = 1 and Z.Nombre != 'CERRADA') and
		r.EstadoActivo =1
END
GO

USE BelcorpDominicana
GO
IF EXISTS (SELECT * FROM sys.procedures where name ='GetRegionByPaisZonaActivas' and SCHEMA_NAME([schema_id]) ='dbo')
	DROP PROCEDURE dbo.GetRegionByPaisZonaActivas
GO
CREATE PROCEDURE [dbo].[GetRegionByPaisZonaActivas]
AS
BEGIN
	SET NOCOUNT ON;

	select
		r.RegionID,
		r.PaisID,
		r.Codigo,
		r.Descripcion AS Nombre
	from ods.Region r
	where
		exists(select 1 from ods.Zona z where Z.RegionID = r.RegionID  and z.EstadoActivo = 1 and Z.Nombre != 'CERRADA') and
		r.EstadoActivo =1
END
GO

USE BelcorpEcuador
GO
IF EXISTS (SELECT * FROM sys.procedures where name ='GetRegionByPaisZonaActivas' and SCHEMA_NAME([schema_id]) ='dbo')
	DROP PROCEDURE dbo.GetRegionByPaisZonaActivas
GO
CREATE PROCEDURE [dbo].[GetRegionByPaisZonaActivas]
AS
BEGIN
	SET NOCOUNT ON;

	select
		r.RegionID,
		r.PaisID,
		r.Codigo,
		r.Descripcion AS Nombre
	from ods.Region r
	where
		exists(select 1 from ods.Zona z where Z.RegionID = r.RegionID  and z.EstadoActivo = 1 and Z.Nombre != 'CERRADA') and
		r.EstadoActivo =1
END
GO

USE BelcorpGuatemala
GO
IF EXISTS (SELECT * FROM sys.procedures where name ='GetRegionByPaisZonaActivas' and SCHEMA_NAME([schema_id]) ='dbo')
	DROP PROCEDURE dbo.GetRegionByPaisZonaActivas
GO
CREATE PROCEDURE [dbo].[GetRegionByPaisZonaActivas]
AS
BEGIN
	SET NOCOUNT ON;

	select
		r.RegionID,
		r.PaisID,
		r.Codigo,
		r.Descripcion AS Nombre
	from ods.Region r
	where
		exists(select 1 from ods.Zona z where Z.RegionID = r.RegionID  and z.EstadoActivo = 1 and Z.Nombre != 'CERRADA') and
		r.EstadoActivo =1
END
GO

USE BelcorpMexico
GO
IF EXISTS (SELECT * FROM sys.procedures where name ='GetRegionByPaisZonaActivas' and SCHEMA_NAME([schema_id]) ='dbo')
	DROP PROCEDURE dbo.GetRegionByPaisZonaActivas
GO
CREATE PROCEDURE [dbo].[GetRegionByPaisZonaActivas]
AS
BEGIN
	SET NOCOUNT ON;

	select
		r.RegionID,
		r.PaisID,
		r.Codigo,
		r.Descripcion AS Nombre
	from ods.Region r
	where
		exists(select 1 from ods.Zona z where Z.RegionID = r.RegionID  and z.EstadoActivo = 1 and Z.Nombre != 'CERRADA') and
		r.EstadoActivo =1
END
GO

USE BelcorpPanama
GO
IF EXISTS (SELECT * FROM sys.procedures where name ='GetRegionByPaisZonaActivas' and SCHEMA_NAME([schema_id]) ='dbo')
	DROP PROCEDURE dbo.GetRegionByPaisZonaActivas
GO
CREATE PROCEDURE [dbo].[GetRegionByPaisZonaActivas]
AS
BEGIN
	SET NOCOUNT ON;

	select
		r.RegionID,
		r.PaisID,
		r.Codigo,
		r.Descripcion AS Nombre
	from ods.Region r
	where
		exists(select 1 from ods.Zona z where Z.RegionID = r.RegionID  and z.EstadoActivo = 1 and Z.Nombre != 'CERRADA') and
		r.EstadoActivo =1
END
GO

USE BelcorpPeru
GO
IF EXISTS (SELECT * FROM sys.procedures where name ='GetRegionByPaisZonaActivas' and SCHEMA_NAME([schema_id]) ='dbo')
	DROP PROCEDURE dbo.GetRegionByPaisZonaActivas
GO
CREATE PROCEDURE [dbo].[GetRegionByPaisZonaActivas]
AS
BEGIN
	SET NOCOUNT ON;

	select
		r.RegionID,
		r.PaisID,
		r.Codigo,
		r.Descripcion AS Nombre
	from ods.Region r
	where
		exists(select 1 from ods.Zona z where Z.RegionID = r.RegionID  and z.EstadoActivo = 1 and Z.Nombre != 'CERRADA') and
		r.EstadoActivo =1
END
GO

USE BelcorpPuertoRico
GO
IF EXISTS (SELECT * FROM sys.procedures where name ='GetRegionByPaisZonaActivas' and SCHEMA_NAME([schema_id]) ='dbo')
	DROP PROCEDURE dbo.GetRegionByPaisZonaActivas
GO
CREATE PROCEDURE [dbo].[GetRegionByPaisZonaActivas]
AS
BEGIN
	SET NOCOUNT ON;

	select
		r.RegionID,
		r.PaisID,
		r.Codigo,
		r.Descripcion AS Nombre
	from ods.Region r
	where
		exists(select 1 from ods.Zona z where Z.RegionID = r.RegionID  and z.EstadoActivo = 1 and Z.Nombre != 'CERRADA') and
		r.EstadoActivo =1
END
GO

USE BelcorpSalvador
GO
IF EXISTS (SELECT * FROM sys.procedures where name ='GetRegionByPaisZonaActivas' and SCHEMA_NAME([schema_id]) ='dbo')
	DROP PROCEDURE dbo.GetRegionByPaisZonaActivas
GO
CREATE PROCEDURE [dbo].[GetRegionByPaisZonaActivas]
AS
BEGIN
	SET NOCOUNT ON;

	select
		r.RegionID,
		r.PaisID,
		r.Codigo,
		r.Descripcion AS Nombre
	from ods.Region r
	where
		exists(select 1 from ods.Zona z where Z.RegionID = r.RegionID  and z.EstadoActivo = 1 and Z.Nombre != 'CERRADA') and
		r.EstadoActivo =1
END
GO