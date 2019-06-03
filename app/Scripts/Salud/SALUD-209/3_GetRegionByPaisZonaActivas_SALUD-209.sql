USE BelcorpPeru
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[PROCEDURE]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetRegionByPaisZonaActivas]
GO

CREATE PROCEDURE [dbo].[GetRegionByPaisZonaActivas] 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
select r.RegionID, r.PaisID, r.Codigo, r.Descripcion AS  Nombre

from ods.Region r
where exists(
  select 1 from ods.Zona z where Z.RegionID = r.RegionID  and z.EstadoActivo =1 and Z.Nombre != 'CERRADA' 
)
and r.EstadoActivo =1
END
GO

USE BelcorpMexico
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[PROCEDURE]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetRegionByPaisZonaActivas]
GO

CREATE PROCEDURE [dbo].[GetRegionByPaisZonaActivas] 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
select r.RegionID, r.PaisID, r.Codigo, r.Descripcion AS  Nombre

from ods.Region r
where exists(
  select 1 from ods.Zona z where Z.RegionID = r.RegionID  and z.EstadoActivo =1 and Z.Nombre != 'CERRADA' 
)
and r.EstadoActivo =1
END
GO

USE BelcorpColombia
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[PROCEDURE]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetRegionByPaisZonaActivas]
GO

CREATE PROCEDURE [dbo].[GetRegionByPaisZonaActivas] 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
select r.RegionID, r.PaisID, r.Codigo, r.Descripcion AS  Nombre

from ods.Region r
where exists(
  select 1 from ods.Zona z where Z.RegionID = r.RegionID  and z.EstadoActivo =1 and Z.Nombre != 'CERRADA' 
)
and r.EstadoActivo =1
END
GO

USE BelcorpSalvador
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[PROCEDURE]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetRegionByPaisZonaActivas]
GO

CREATE PROCEDURE [dbo].[GetRegionByPaisZonaActivas] 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
select r.RegionID, r.PaisID, r.Codigo, r.Descripcion AS  Nombre

from ods.Region r
where exists(
  select 1 from ods.Zona z where Z.RegionID = r.RegionID  and z.EstadoActivo =1 and Z.Nombre != 'CERRADA' 
)
and r.EstadoActivo =1
END
GO

USE BelcorpPuertoRico
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[PROCEDURE]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetRegionByPaisZonaActivas]
GO

CREATE PROCEDURE [dbo].[GetRegionByPaisZonaActivas] 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
select r.RegionID, r.PaisID, r.Codigo, r.Descripcion AS  Nombre

from ods.Region r
where exists(
  select 1 from ods.Zona z where Z.RegionID = r.RegionID  and z.EstadoActivo =1 and Z.Nombre != 'CERRADA' 
)
and r.EstadoActivo =1
END
GO

USE BelcorpPanama
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[PROCEDURE]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetRegionByPaisZonaActivas]
GO

CREATE PROCEDURE [dbo].[GetRegionByPaisZonaActivas] 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
select r.RegionID, r.PaisID, r.Codigo, r.Descripcion AS  Nombre

from ods.Region r
where exists(
  select 1 from ods.Zona z where Z.RegionID = r.RegionID  and z.EstadoActivo =1 and Z.Nombre != 'CERRADA' 
)
and r.EstadoActivo =1
END
GO

USE BelcorpGuatemala
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[PROCEDURE]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetRegionByPaisZonaActivas]
GO

CREATE PROCEDURE [dbo].[GetRegionByPaisZonaActivas] 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
select r.RegionID, r.PaisID, r.Codigo, r.Descripcion AS  Nombre

from ods.Region r
where exists(
  select 1 from ods.Zona z where Z.RegionID = r.RegionID  and z.EstadoActivo =1 and Z.Nombre != 'CERRADA' 
)
and r.EstadoActivo =1
END
GO

USE BelcorpEcuador
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[PROCEDURE]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetRegionByPaisZonaActivas]
GO

CREATE PROCEDURE [dbo].[GetRegionByPaisZonaActivas] 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
select r.RegionID, r.PaisID, r.Codigo, r.Descripcion AS  Nombre

from ods.Region r
where exists(
  select 1 from ods.Zona z where Z.RegionID = r.RegionID  and z.EstadoActivo =1 and Z.Nombre != 'CERRADA' 
)
and r.EstadoActivo =1
END
GO

USE BelcorpDominicana
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[PROCEDURE]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetRegionByPaisZonaActivas]
GO

CREATE PROCEDURE [dbo].[GetRegionByPaisZonaActivas] 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
select r.RegionID, r.PaisID, r.Codigo, r.Descripcion AS  Nombre

from ods.Region r
where exists(
  select 1 from ods.Zona z where Z.RegionID = r.RegionID  and z.EstadoActivo =1 and Z.Nombre != 'CERRADA' 
)
and r.EstadoActivo =1
END
GO

USE BelcorpCostaRica
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[PROCEDURE]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetRegionByPaisZonaActivas]
GO

CREATE PROCEDURE [dbo].[GetRegionByPaisZonaActivas] 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
select r.RegionID, r.PaisID, r.Codigo, r.Descripcion AS  Nombre

from ods.Region r
where exists(
  select 1 from ods.Zona z where Z.RegionID = r.RegionID  and z.EstadoActivo =1 and Z.Nombre != 'CERRADA' 
)
and r.EstadoActivo =1
END
GO

USE BelcorpChile
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[PROCEDURE]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetRegionByPaisZonaActivas]
GO

CREATE PROCEDURE [dbo].[GetRegionByPaisZonaActivas] 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
select r.RegionID, r.PaisID, r.Codigo, r.Descripcion AS  Nombre

from ods.Region r
where exists(
  select 1 from ods.Zona z where Z.RegionID = r.RegionID  and z.EstadoActivo =1 and Z.Nombre != 'CERRADA' 
)
and r.EstadoActivo =1
END
GO

USE BelcorpBolivia
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[PROCEDURE]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetRegionByPaisZonaActivas]
GO

CREATE PROCEDURE [dbo].[GetRegionByPaisZonaActivas] 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
select r.RegionID, r.PaisID, r.Codigo, r.Descripcion AS  Nombre

from ods.Region r
where exists(
  select 1 from ods.Zona z where Z.RegionID = r.RegionID  and z.EstadoActivo =1 and Z.Nombre != 'CERRADA' 
)
and r.EstadoActivo =1
END
GO

