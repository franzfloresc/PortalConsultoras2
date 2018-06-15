GO
USE BelcorpPeru
GO

GO
IF EXISTS (
	SELECT * FROM sys.objects
	WHERE object_id =
	OBJECT_ID(N'[dbo].[ObtenerCuvFaltante]')
	AND type in (N'FN',N'TF')
)
	DROP FUNCTION [dbo].[ObtenerCuvFaltante]
GO

CREATE FUNCTION dbo.ObtenerCuvFaltante(
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(30)
)
RETURNS @tablaCuvFaltante table (CUV varchar(6))
AS
BEGIN
	declare @CodigoRegion varchar(2) = null
	, @CodigoZona varchar(4) = null
	, @ZonaID int
	, @StrCampaniaID CHAR(6) = CONVERT(CHAR(6),@CampaniaID)

	SELECT
		@CodigoRegion = r.Codigo,
		@CodigoZona = z.Codigo,
		@ZonaID = c.ZonaID
	FROM ods.Consultora c with(nolock)
		INNER JOIN ods.Region r with(nolock) on r.RegionID = c.RegionID
		INNER JOIN ods.Zona z with(nolock) on z.ZonaID = c.ZonaID
	where c.Codigo = @CodigoConsultora
		insert into @tablaCuvFaltante
		select ltrim(rtrim(CUV))
		from dbo.ProductoFaltante with(nolock)
		where CampaniaID = @CampaniaID and Zonaid = @ZonaID
		group by CUV
		UNION ALL
		select  ltrim(rtrim(fa.CodigoVenta)) AS CUV
		from ods.FaltanteAnunciado fa with(nolock)
			inner join ods.Campania c  with(nolock) on
			fa.CampaniaID = c.CampaniaID
		where
			c.Codigo = @StrCampaniaID
			and (rtrim(fa.CodigoRegion) = @CodigoRegion or fa.CodigoRegion IS NULL)
			and (rtrim(fa.CodigoZona) = @CodigoZona or fa.CodigoZona IS NULL)
		group by fa.CodigoVenta;

		RETURN
END
GO

GO
USE BelcorpMexico
GO

GO
IF EXISTS (
	SELECT * FROM sys.objects
	WHERE object_id =
	OBJECT_ID(N'[dbo].[ObtenerCuvFaltante]')
	AND type in (N'FN',N'TF')
)
	DROP FUNCTION [dbo].[ObtenerCuvFaltante]
GO

CREATE FUNCTION dbo.ObtenerCuvFaltante(
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(30)
)
RETURNS @tablaCuvFaltante table (CUV varchar(6))
AS
BEGIN
	declare @CodigoRegion varchar(2) = null
	, @CodigoZona varchar(4) = null
	, @ZonaID int
	, @StrCampaniaID CHAR(6) = CONVERT(CHAR(6),@CampaniaID)

	SELECT
		@CodigoRegion = r.Codigo,
		@CodigoZona = z.Codigo,
		@ZonaID = c.ZonaID
	FROM ods.Consultora c with(nolock)
		INNER JOIN ods.Region r with(nolock) on r.RegionID = c.RegionID
		INNER JOIN ods.Zona z with(nolock) on z.ZonaID = c.ZonaID
	where c.Codigo = @CodigoConsultora
		insert into @tablaCuvFaltante
		select ltrim(rtrim(CUV))
		from dbo.ProductoFaltante with(nolock)
		where CampaniaID = @CampaniaID and Zonaid = @ZonaID
		group by CUV
		UNION ALL
		select  ltrim(rtrim(fa.CodigoVenta)) AS CUV
		from ods.FaltanteAnunciado fa with(nolock)
			inner join ods.Campania c  with(nolock) on
			fa.CampaniaID = c.CampaniaID
		where
			c.Codigo = @StrCampaniaID
			and (rtrim(fa.CodigoRegion) = @CodigoRegion or fa.CodigoRegion IS NULL)
			and (rtrim(fa.CodigoZona) = @CodigoZona or fa.CodigoZona IS NULL)
		group by fa.CodigoVenta;

		RETURN
END
GO

GO
USE BelcorpColombia
GO

GO
IF EXISTS (
	SELECT * FROM sys.objects
	WHERE object_id =
	OBJECT_ID(N'[dbo].[ObtenerCuvFaltante]')
	AND type in (N'FN',N'TF')
)
	DROP FUNCTION [dbo].[ObtenerCuvFaltante]
GO

CREATE FUNCTION dbo.ObtenerCuvFaltante(
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(30)
)
RETURNS @tablaCuvFaltante table (CUV varchar(6))
AS
BEGIN
	declare @CodigoRegion varchar(2) = null
	, @CodigoZona varchar(4) = null
	, @ZonaID int
	, @StrCampaniaID CHAR(6) = CONVERT(CHAR(6),@CampaniaID)

	SELECT
		@CodigoRegion = r.Codigo,
		@CodigoZona = z.Codigo,
		@ZonaID = c.ZonaID
	FROM ods.Consultora c with(nolock)
		INNER JOIN ods.Region r with(nolock) on r.RegionID = c.RegionID
		INNER JOIN ods.Zona z with(nolock) on z.ZonaID = c.ZonaID
	where c.Codigo = @CodigoConsultora
		insert into @tablaCuvFaltante
		select ltrim(rtrim(CUV))
		from dbo.ProductoFaltante with(nolock)
		where CampaniaID = @CampaniaID and Zonaid = @ZonaID
		group by CUV
		UNION ALL
		select  ltrim(rtrim(fa.CodigoVenta)) AS CUV
		from ods.FaltanteAnunciado fa with(nolock)
			inner join ods.Campania c  with(nolock) on
			fa.CampaniaID = c.CampaniaID
		where
			c.Codigo = @StrCampaniaID
			and (rtrim(fa.CodigoRegion) = @CodigoRegion or fa.CodigoRegion IS NULL)
			and (rtrim(fa.CodigoZona) = @CodigoZona or fa.CodigoZona IS NULL)
		group by fa.CodigoVenta;

		RETURN
END
GO

GO
USE BelcorpSalvador
GO

GO
IF EXISTS (
	SELECT * FROM sys.objects
	WHERE object_id =
	OBJECT_ID(N'[dbo].[ObtenerCuvFaltante]')
	AND type in (N'FN',N'TF')
)
	DROP FUNCTION [dbo].[ObtenerCuvFaltante]
GO

CREATE FUNCTION dbo.ObtenerCuvFaltante(
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(30)
)
RETURNS @tablaCuvFaltante table (CUV varchar(6))
AS
BEGIN
	declare @CodigoRegion varchar(2) = null
	, @CodigoZona varchar(4) = null
	, @ZonaID int
	, @StrCampaniaID CHAR(6) = CONVERT(CHAR(6),@CampaniaID)

	SELECT
		@CodigoRegion = r.Codigo,
		@CodigoZona = z.Codigo,
		@ZonaID = c.ZonaID
	FROM ods.Consultora c with(nolock)
		INNER JOIN ods.Region r with(nolock) on r.RegionID = c.RegionID
		INNER JOIN ods.Zona z with(nolock) on z.ZonaID = c.ZonaID
	where c.Codigo = @CodigoConsultora
		insert into @tablaCuvFaltante
		select ltrim(rtrim(CUV))
		from dbo.ProductoFaltante with(nolock)
		where CampaniaID = @CampaniaID and Zonaid = @ZonaID
		group by CUV
		UNION ALL
		select  ltrim(rtrim(fa.CodigoVenta)) AS CUV
		from ods.FaltanteAnunciado fa with(nolock)
			inner join ods.Campania c  with(nolock) on
			fa.CampaniaID = c.CampaniaID
		where
			c.Codigo = @StrCampaniaID
			and (rtrim(fa.CodigoRegion) = @CodigoRegion or fa.CodigoRegion IS NULL)
			and (rtrim(fa.CodigoZona) = @CodigoZona or fa.CodigoZona IS NULL)
		group by fa.CodigoVenta;

		RETURN
END
GO

GO
USE BelcorpPuertoRico
GO

GO
IF EXISTS (
	SELECT * FROM sys.objects
	WHERE object_id =
	OBJECT_ID(N'[dbo].[ObtenerCuvFaltante]')
	AND type in (N'FN',N'TF')
)
	DROP FUNCTION [dbo].[ObtenerCuvFaltante]
GO

CREATE FUNCTION dbo.ObtenerCuvFaltante(
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(30)
)
RETURNS @tablaCuvFaltante table (CUV varchar(6))
AS
BEGIN
	declare @CodigoRegion varchar(2) = null
	, @CodigoZona varchar(4) = null
	, @ZonaID int
	, @StrCampaniaID CHAR(6) = CONVERT(CHAR(6),@CampaniaID)

	SELECT
		@CodigoRegion = r.Codigo,
		@CodigoZona = z.Codigo,
		@ZonaID = c.ZonaID
	FROM ods.Consultora c with(nolock)
		INNER JOIN ods.Region r with(nolock) on r.RegionID = c.RegionID
		INNER JOIN ods.Zona z with(nolock) on z.ZonaID = c.ZonaID
	where c.Codigo = @CodigoConsultora
		insert into @tablaCuvFaltante
		select ltrim(rtrim(CUV))
		from dbo.ProductoFaltante with(nolock)
		where CampaniaID = @CampaniaID and Zonaid = @ZonaID
		group by CUV
		UNION ALL
		select  ltrim(rtrim(fa.CodigoVenta)) AS CUV
		from ods.FaltanteAnunciado fa with(nolock)
			inner join ods.Campania c  with(nolock) on
			fa.CampaniaID = c.CampaniaID
		where
			c.Codigo = @StrCampaniaID
			and (rtrim(fa.CodigoRegion) = @CodigoRegion or fa.CodigoRegion IS NULL)
			and (rtrim(fa.CodigoZona) = @CodigoZona or fa.CodigoZona IS NULL)
		group by fa.CodigoVenta;

		RETURN
END
GO

GO
USE BelcorpPanama
GO

GO
IF EXISTS (
	SELECT * FROM sys.objects
	WHERE object_id =
	OBJECT_ID(N'[dbo].[ObtenerCuvFaltante]')
	AND type in (N'FN',N'TF')
)
	DROP FUNCTION [dbo].[ObtenerCuvFaltante]
GO

CREATE FUNCTION dbo.ObtenerCuvFaltante(
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(30)
)
RETURNS @tablaCuvFaltante table (CUV varchar(6))
AS
BEGIN
	declare @CodigoRegion varchar(2) = null
	, @CodigoZona varchar(4) = null
	, @ZonaID int
	, @StrCampaniaID CHAR(6) = CONVERT(CHAR(6),@CampaniaID)

	SELECT
		@CodigoRegion = r.Codigo,
		@CodigoZona = z.Codigo,
		@ZonaID = c.ZonaID
	FROM ods.Consultora c with(nolock)
		INNER JOIN ods.Region r with(nolock) on r.RegionID = c.RegionID
		INNER JOIN ods.Zona z with(nolock) on z.ZonaID = c.ZonaID
	where c.Codigo = @CodigoConsultora
		insert into @tablaCuvFaltante
		select ltrim(rtrim(CUV))
		from dbo.ProductoFaltante with(nolock)
		where CampaniaID = @CampaniaID and Zonaid = @ZonaID
		group by CUV
		UNION ALL
		select  ltrim(rtrim(fa.CodigoVenta)) AS CUV
		from ods.FaltanteAnunciado fa with(nolock)
			inner join ods.Campania c  with(nolock) on
			fa.CampaniaID = c.CampaniaID
		where
			c.Codigo = @StrCampaniaID
			and (rtrim(fa.CodigoRegion) = @CodigoRegion or fa.CodigoRegion IS NULL)
			and (rtrim(fa.CodigoZona) = @CodigoZona or fa.CodigoZona IS NULL)
		group by fa.CodigoVenta;

		RETURN
END
GO

GO
USE BelcorpGuatemala
GO

GO
IF EXISTS (
	SELECT * FROM sys.objects
	WHERE object_id =
	OBJECT_ID(N'[dbo].[ObtenerCuvFaltante]')
	AND type in (N'FN',N'TF')
)
	DROP FUNCTION [dbo].[ObtenerCuvFaltante]
GO

CREATE FUNCTION dbo.ObtenerCuvFaltante(
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(30)
)
RETURNS @tablaCuvFaltante table (CUV varchar(6))
AS
BEGIN
	declare @CodigoRegion varchar(2) = null
	, @CodigoZona varchar(4) = null
	, @ZonaID int
	, @StrCampaniaID CHAR(6) = CONVERT(CHAR(6),@CampaniaID)

	SELECT
		@CodigoRegion = r.Codigo,
		@CodigoZona = z.Codigo,
		@ZonaID = c.ZonaID
	FROM ods.Consultora c with(nolock)
		INNER JOIN ods.Region r with(nolock) on r.RegionID = c.RegionID
		INNER JOIN ods.Zona z with(nolock) on z.ZonaID = c.ZonaID
	where c.Codigo = @CodigoConsultora
		insert into @tablaCuvFaltante
		select ltrim(rtrim(CUV))
		from dbo.ProductoFaltante with(nolock)
		where CampaniaID = @CampaniaID and Zonaid = @ZonaID
		group by CUV
		UNION ALL
		select  ltrim(rtrim(fa.CodigoVenta)) AS CUV
		from ods.FaltanteAnunciado fa with(nolock)
			inner join ods.Campania c  with(nolock) on
			fa.CampaniaID = c.CampaniaID
		where
			c.Codigo = @StrCampaniaID
			and (rtrim(fa.CodigoRegion) = @CodigoRegion or fa.CodigoRegion IS NULL)
			and (rtrim(fa.CodigoZona) = @CodigoZona or fa.CodigoZona IS NULL)
		group by fa.CodigoVenta;

		RETURN
END
GO

GO
USE BelcorpEcuador
GO

GO
IF EXISTS (
	SELECT * FROM sys.objects
	WHERE object_id =
	OBJECT_ID(N'[dbo].[ObtenerCuvFaltante]')
	AND type in (N'FN',N'TF')
)
	DROP FUNCTION [dbo].[ObtenerCuvFaltante]
GO

CREATE FUNCTION dbo.ObtenerCuvFaltante(
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(30)
)
RETURNS @tablaCuvFaltante table (CUV varchar(6))
AS
BEGIN
	declare @CodigoRegion varchar(2) = null
	, @CodigoZona varchar(4) = null
	, @ZonaID int
	, @StrCampaniaID CHAR(6) = CONVERT(CHAR(6),@CampaniaID)

	SELECT
		@CodigoRegion = r.Codigo,
		@CodigoZona = z.Codigo,
		@ZonaID = c.ZonaID
	FROM ods.Consultora c with(nolock)
		INNER JOIN ods.Region r with(nolock) on r.RegionID = c.RegionID
		INNER JOIN ods.Zona z with(nolock) on z.ZonaID = c.ZonaID
	where c.Codigo = @CodigoConsultora
		insert into @tablaCuvFaltante
		select ltrim(rtrim(CUV))
		from dbo.ProductoFaltante with(nolock)
		where CampaniaID = @CampaniaID and Zonaid = @ZonaID
		group by CUV
		UNION ALL
		select  ltrim(rtrim(fa.CodigoVenta)) AS CUV
		from ods.FaltanteAnunciado fa with(nolock)
			inner join ods.Campania c  with(nolock) on
			fa.CampaniaID = c.CampaniaID
		where
			c.Codigo = @StrCampaniaID
			and (rtrim(fa.CodigoRegion) = @CodigoRegion or fa.CodigoRegion IS NULL)
			and (rtrim(fa.CodigoZona) = @CodigoZona or fa.CodigoZona IS NULL)
		group by fa.CodigoVenta;

		RETURN
END
GO

GO
USE BelcorpDominicana
GO

GO
IF EXISTS (
	SELECT * FROM sys.objects
	WHERE object_id =
	OBJECT_ID(N'[dbo].[ObtenerCuvFaltante]')
	AND type in (N'FN',N'TF')
)
	DROP FUNCTION [dbo].[ObtenerCuvFaltante]
GO

CREATE FUNCTION dbo.ObtenerCuvFaltante(
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(30)
)
RETURNS @tablaCuvFaltante table (CUV varchar(6))
AS
BEGIN
	declare @CodigoRegion varchar(2) = null
	, @CodigoZona varchar(4) = null
	, @ZonaID int
	, @StrCampaniaID CHAR(6) = CONVERT(CHAR(6),@CampaniaID)

	SELECT
		@CodigoRegion = r.Codigo,
		@CodigoZona = z.Codigo,
		@ZonaID = c.ZonaID
	FROM ods.Consultora c with(nolock)
		INNER JOIN ods.Region r with(nolock) on r.RegionID = c.RegionID
		INNER JOIN ods.Zona z with(nolock) on z.ZonaID = c.ZonaID
	where c.Codigo = @CodigoConsultora
		insert into @tablaCuvFaltante
		select ltrim(rtrim(CUV))
		from dbo.ProductoFaltante with(nolock)
		where CampaniaID = @CampaniaID and Zonaid = @ZonaID
		group by CUV
		UNION ALL
		select  ltrim(rtrim(fa.CodigoVenta)) AS CUV
		from ods.FaltanteAnunciado fa with(nolock)
			inner join ods.Campania c  with(nolock) on
			fa.CampaniaID = c.CampaniaID
		where
			c.Codigo = @StrCampaniaID
			and (rtrim(fa.CodigoRegion) = @CodigoRegion or fa.CodigoRegion IS NULL)
			and (rtrim(fa.CodigoZona) = @CodigoZona or fa.CodigoZona IS NULL)
		group by fa.CodigoVenta;

		RETURN
END
GO

GO
USE BelcorpCostaRica
GO

GO
IF EXISTS (
	SELECT * FROM sys.objects
	WHERE object_id =
	OBJECT_ID(N'[dbo].[ObtenerCuvFaltante]')
	AND type in (N'FN',N'TF')
)
	DROP FUNCTION [dbo].[ObtenerCuvFaltante]
GO

CREATE FUNCTION dbo.ObtenerCuvFaltante(
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(30)
)
RETURNS @tablaCuvFaltante table (CUV varchar(6))
AS
BEGIN
	declare @CodigoRegion varchar(2) = null
	, @CodigoZona varchar(4) = null
	, @ZonaID int
	, @StrCampaniaID CHAR(6) = CONVERT(CHAR(6),@CampaniaID)

	SELECT
		@CodigoRegion = r.Codigo,
		@CodigoZona = z.Codigo,
		@ZonaID = c.ZonaID
	FROM ods.Consultora c with(nolock)
		INNER JOIN ods.Region r with(nolock) on r.RegionID = c.RegionID
		INNER JOIN ods.Zona z with(nolock) on z.ZonaID = c.ZonaID
	where c.Codigo = @CodigoConsultora
		insert into @tablaCuvFaltante
		select ltrim(rtrim(CUV))
		from dbo.ProductoFaltante with(nolock)
		where CampaniaID = @CampaniaID and Zonaid = @ZonaID
		group by CUV
		UNION ALL
		select  ltrim(rtrim(fa.CodigoVenta)) AS CUV
		from ods.FaltanteAnunciado fa with(nolock)
			inner join ods.Campania c  with(nolock) on
			fa.CampaniaID = c.CampaniaID
		where
			c.Codigo = @StrCampaniaID
			and (rtrim(fa.CodigoRegion) = @CodigoRegion or fa.CodigoRegion IS NULL)
			and (rtrim(fa.CodigoZona) = @CodigoZona or fa.CodigoZona IS NULL)
		group by fa.CodigoVenta;

		RETURN
END
GO

GO
USE BelcorpChile
GO

GO
IF EXISTS (
	SELECT * FROM sys.objects
	WHERE object_id =
	OBJECT_ID(N'[dbo].[ObtenerCuvFaltante]')
	AND type in (N'FN',N'TF')
)
	DROP FUNCTION [dbo].[ObtenerCuvFaltante]
GO

CREATE FUNCTION dbo.ObtenerCuvFaltante(
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(30)
)
RETURNS @tablaCuvFaltante table (CUV varchar(6))
AS
BEGIN
	declare @CodigoRegion varchar(2) = null
	, @CodigoZona varchar(4) = null
	, @ZonaID int
	, @StrCampaniaID CHAR(6) = CONVERT(CHAR(6),@CampaniaID)

	SELECT
		@CodigoRegion = r.Codigo,
		@CodigoZona = z.Codigo,
		@ZonaID = c.ZonaID
	FROM ods.Consultora c with(nolock)
		INNER JOIN ods.Region r with(nolock) on r.RegionID = c.RegionID
		INNER JOIN ods.Zona z with(nolock) on z.ZonaID = c.ZonaID
	where c.Codigo = @CodigoConsultora
		insert into @tablaCuvFaltante
		select ltrim(rtrim(CUV))
		from dbo.ProductoFaltante with(nolock)
		where CampaniaID = @CampaniaID and Zonaid = @ZonaID
		group by CUV
		UNION ALL
		select  ltrim(rtrim(fa.CodigoVenta)) AS CUV
		from ods.FaltanteAnunciado fa with(nolock)
			inner join ods.Campania c  with(nolock) on
			fa.CampaniaID = c.CampaniaID
		where
			c.Codigo = @StrCampaniaID
			and (rtrim(fa.CodigoRegion) = @CodigoRegion or fa.CodigoRegion IS NULL)
			and (rtrim(fa.CodigoZona) = @CodigoZona or fa.CodigoZona IS NULL)
		group by fa.CodigoVenta;

		RETURN
END
GO

GO
USE BelcorpBolivia
GO

GO
IF EXISTS (
	SELECT * FROM sys.objects
	WHERE object_id =
	OBJECT_ID(N'[dbo].[ObtenerCuvFaltante]')
	AND type in (N'FN',N'TF')
)
	DROP FUNCTION [dbo].[ObtenerCuvFaltante]
GO

CREATE FUNCTION dbo.ObtenerCuvFaltante(
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(30)
)
RETURNS @tablaCuvFaltante table (CUV varchar(6))
AS
BEGIN
	declare @CodigoRegion varchar(2) = null
	, @CodigoZona varchar(4) = null
	, @ZonaID int
	, @StrCampaniaID CHAR(6) = CONVERT(CHAR(6),@CampaniaID)

	SELECT
		@CodigoRegion = r.Codigo,
		@CodigoZona = z.Codigo,
		@ZonaID = c.ZonaID
	FROM ods.Consultora c with(nolock)
		INNER JOIN ods.Region r with(nolock) on r.RegionID = c.RegionID
		INNER JOIN ods.Zona z with(nolock) on z.ZonaID = c.ZonaID
	where c.Codigo = @CodigoConsultora
		insert into @tablaCuvFaltante
		select ltrim(rtrim(CUV))
		from dbo.ProductoFaltante with(nolock)
		where CampaniaID = @CampaniaID and Zonaid = @ZonaID
		group by CUV
		UNION ALL
		select  ltrim(rtrim(fa.CodigoVenta)) AS CUV
		from ods.FaltanteAnunciado fa with(nolock)
			inner join ods.Campania c  with(nolock) on
			fa.CampaniaID = c.CampaniaID
		where
			c.Codigo = @StrCampaniaID
			and (rtrim(fa.CodigoRegion) = @CodigoRegion or fa.CodigoRegion IS NULL)
			and (rtrim(fa.CodigoZona) = @CodigoZona or fa.CodigoZona IS NULL)
		group by fa.CodigoVenta;

		RETURN
END
GO

GO
