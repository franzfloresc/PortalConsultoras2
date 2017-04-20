USE BelcorpBolivia
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[GetMatrizComercialByCodigoSAP]
	@CodigoSAP varchar(50)
AS
BEGIN
	select *
	from (
		SELECT distinct
			isnull(MC.IdMatrizComercial,0)IdMatrizComercial,
			PC.CodigoProducto as CodigoSAP,
			PC.Descripcion as DescripcionOriginal,
			isnull(MC.Descripcion,'') Descripcion,
			PC.CUV as CUV,
			MC.FechaRegistro as FechaRegistro
		FROM ODS.ProductoComercial PC WITH (NOLOCK)
		LEFT JOIN MatrizComercial MC WITH (NOLOCK) ON PC.CodigoProducto = MC.CodigoSAP
		WHERE CHARINDEX(case when @CodigoSAP = '' then PC.CodigoProducto else @CodigoSAP end, PC.CodigoProducto) > 0
	) t
	order by t.FechaRegistro desc
END
GO
/*end*/

USE BelcorpChile
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[GetMatrizComercialByCodigoSAP]
	@CodigoSAP varchar(50)
AS
BEGIN
	select *
	from (
		SELECT distinct
			isnull(MC.IdMatrizComercial,0)IdMatrizComercial,
			PC.CodigoProducto as CodigoSAP,
			PC.Descripcion as DescripcionOriginal,
			isnull(MC.Descripcion,'') Descripcion,
			PC.CUV as CUV,
			MC.FechaRegistro as FechaRegistro
		FROM ODS.ProductoComercial PC WITH (NOLOCK)
		LEFT JOIN MatrizComercial MC WITH (NOLOCK) ON PC.CodigoProducto = MC.CodigoSAP
		WHERE CHARINDEX(case when @CodigoSAP = '' then PC.CodigoProducto else @CodigoSAP end, PC.CodigoProducto) > 0
	) t
	order by t.FechaRegistro desc
END
GO
/*end*/

USE BelcorpColombia
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[GetMatrizComercialByCodigoSAP]
	@CodigoSAP varchar(50)
AS
BEGIN
	select *
	from (
		SELECT distinct
			isnull(MC.IdMatrizComercial,0)IdMatrizComercial,
			PC.CodigoProducto as CodigoSAP,
			PC.Descripcion as DescripcionOriginal,
			isnull(MC.Descripcion,'') Descripcion,
			PC.CUV as CUV,
			MC.FechaRegistro as FechaRegistro
		FROM ODS.ProductoComercial PC WITH (NOLOCK)
		LEFT JOIN MatrizComercial MC WITH (NOLOCK) ON PC.CodigoProducto = MC.CodigoSAP
		WHERE CHARINDEX(case when @CodigoSAP = '' then PC.CodigoProducto else @CodigoSAP end, PC.CodigoProducto) > 0
	) t
	order by t.FechaRegistro desc
END
GO
/*end*/

USE BelcorpCostaRica
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[GetMatrizComercialByCodigoSAP]
	@CodigoSAP varchar(50)
AS
BEGIN
	select *
	from (
		SELECT distinct
			isnull(MC.IdMatrizComercial,0)IdMatrizComercial,
			PC.CodigoProducto as CodigoSAP,
			PC.Descripcion as DescripcionOriginal,
			isnull(MC.Descripcion,'') Descripcion,
			PC.CUV as CUV,
			MC.FechaRegistro as FechaRegistro
		FROM ODS.ProductoComercial PC WITH (NOLOCK)
		LEFT JOIN MatrizComercial MC WITH (NOLOCK) ON PC.CodigoProducto = MC.CodigoSAP
		WHERE CHARINDEX(case when @CodigoSAP = '' then PC.CodigoProducto else @CodigoSAP end, PC.CodigoProducto) > 0
	) t
	order by t.FechaRegistro desc
END
GO
/*end*/

USE BelcorpDominicana
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[GetMatrizComercialByCodigoSAP]
	@CodigoSAP varchar(50)
AS
BEGIN
	select *
	from (
		SELECT distinct
			isnull(MC.IdMatrizComercial,0)IdMatrizComercial,
			PC.CodigoProducto as CodigoSAP,
			PC.Descripcion as DescripcionOriginal,
			isnull(MC.Descripcion,'') Descripcion,
			PC.CUV as CUV,
			MC.FechaRegistro as FechaRegistro
		FROM ODS.ProductoComercial PC WITH (NOLOCK)
		LEFT JOIN MatrizComercial MC WITH (NOLOCK) ON PC.CodigoProducto = MC.CodigoSAP
		WHERE CHARINDEX(case when @CodigoSAP = '' then PC.CodigoProducto else @CodigoSAP end, PC.CodigoProducto) > 0
	) t
	order by t.FechaRegistro desc
END
GO
/*end*/

USE BelcorpEcuador
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[GetMatrizComercialByCodigoSAP]
	@CodigoSAP varchar(50)
AS
BEGIN
	select *
	from (
		SELECT distinct
			isnull(MC.IdMatrizComercial,0)IdMatrizComercial,
			PC.CodigoProducto as CodigoSAP,
			PC.Descripcion as DescripcionOriginal,
			isnull(MC.Descripcion,'') Descripcion,
			PC.CUV as CUV,
			MC.FechaRegistro as FechaRegistro
		FROM ODS.ProductoComercial PC WITH (NOLOCK)
		LEFT JOIN MatrizComercial MC WITH (NOLOCK) ON PC.CodigoProducto = MC.CodigoSAP
		WHERE CHARINDEX(case when @CodigoSAP = '' then PC.CodigoProducto else @CodigoSAP end, PC.CodigoProducto) > 0
	) t
	order by t.FechaRegistro desc
END
GO
/*end*/

USE BelcorpGuatemala
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[GetMatrizComercialByCodigoSAP]
	@CodigoSAP varchar(50)
AS
BEGIN
	select *
	from (
		SELECT distinct
			isnull(MC.IdMatrizComercial,0)IdMatrizComercial,
			PC.CodigoProducto as CodigoSAP,
			PC.Descripcion as DescripcionOriginal,
			isnull(MC.Descripcion,'') Descripcion,
			PC.CUV as CUV,
			MC.FechaRegistro as FechaRegistro
		FROM ODS.ProductoComercial PC WITH (NOLOCK)
		LEFT JOIN MatrizComercial MC WITH (NOLOCK) ON PC.CodigoProducto = MC.CodigoSAP
		WHERE CHARINDEX(case when @CodigoSAP = '' then PC.CodigoProducto else @CodigoSAP end, PC.CodigoProducto) > 0
	) t
	order by t.FechaRegistro desc
END
GO
/*end*/

USE BelcorpMexico
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[GetMatrizComercialByCodigoSAP]
	@CodigoSAP varchar(50)
AS
BEGIN
	select *
	from (
		SELECT distinct
			isnull(MC.IdMatrizComercial,0)IdMatrizComercial,
			PC.CodigoProducto as CodigoSAP,
			PC.Descripcion as DescripcionOriginal,
			isnull(MC.Descripcion,'') Descripcion,
			PC.CUV as CUV,
			MC.FechaRegistro as FechaRegistro
		FROM ODS.ProductoComercial PC WITH (NOLOCK)
		LEFT JOIN MatrizComercial MC WITH (NOLOCK) ON PC.CodigoProducto = MC.CodigoSAP
		WHERE CHARINDEX(case when @CodigoSAP = '' then PC.CodigoProducto else @CodigoSAP end, PC.CodigoProducto) > 0
	) t
	order by t.FechaRegistro desc
END
GO
/*end*/

USE BelcorpPanama
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[GetMatrizComercialByCodigoSAP]
	@CodigoSAP varchar(50)
AS
BEGIN
	select *
	from (
		SELECT distinct
			isnull(MC.IdMatrizComercial,0)IdMatrizComercial,
			PC.CodigoProducto as CodigoSAP,
			PC.Descripcion as DescripcionOriginal,
			isnull(MC.Descripcion,'') Descripcion,
			PC.CUV as CUV,
			MC.FechaRegistro as FechaRegistro
		FROM ODS.ProductoComercial PC WITH (NOLOCK)
		LEFT JOIN MatrizComercial MC WITH (NOLOCK) ON PC.CodigoProducto = MC.CodigoSAP
		WHERE CHARINDEX(case when @CodigoSAP = '' then PC.CodigoProducto else @CodigoSAP end, PC.CodigoProducto) > 0
	) t
	order by t.FechaRegistro desc
END
GO
/*end*/

USE BelcorpPeru
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[GetMatrizComercialByCodigoSAP]
	@CodigoSAP varchar(50)
AS
BEGIN
	select *
	from (
		SELECT distinct
			isnull(MC.IdMatrizComercial,0)IdMatrizComercial,
			PC.CodigoProducto as CodigoSAP,
			PC.Descripcion as DescripcionOriginal,
			isnull(MC.Descripcion,'') Descripcion,
			PC.CUV as CUV,
			MC.FechaRegistro as FechaRegistro
		FROM ODS.ProductoComercial PC WITH (NOLOCK)
		LEFT JOIN MatrizComercial MC WITH (NOLOCK) ON PC.CodigoProducto = MC.CodigoSAP
		WHERE CHARINDEX(case when @CodigoSAP = '' then PC.CodigoProducto else @CodigoSAP end, PC.CodigoProducto) > 0
	) t
	order by t.FechaRegistro desc
END
GO
/*end*/

USE BelcorpPuertoRico
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[GetMatrizComercialByCodigoSAP]
	@CodigoSAP varchar(50)
AS
BEGIN
	select *
	from (
		SELECT distinct
			isnull(MC.IdMatrizComercial,0)IdMatrizComercial,
			PC.CodigoProducto as CodigoSAP,
			PC.Descripcion as DescripcionOriginal,
			isnull(MC.Descripcion,'') Descripcion,
			PC.CUV as CUV,
			MC.FechaRegistro as FechaRegistro
		FROM ODS.ProductoComercial PC WITH (NOLOCK)
		LEFT JOIN MatrizComercial MC WITH (NOLOCK) ON PC.CodigoProducto = MC.CodigoSAP
		WHERE CHARINDEX(case when @CodigoSAP = '' then PC.CodigoProducto else @CodigoSAP end, PC.CodigoProducto) > 0
	) t
	order by t.FechaRegistro desc
END
GO
/*end*/

USE BelcorpSalvador
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[GetMatrizComercialByCodigoSAP]
	@CodigoSAP varchar(50)
AS
BEGIN
	select *
	from (
		SELECT distinct
			isnull(MC.IdMatrizComercial,0)IdMatrizComercial,
			PC.CodigoProducto as CodigoSAP,
			PC.Descripcion as DescripcionOriginal,
			isnull(MC.Descripcion,'') Descripcion,
			PC.CUV as CUV,
			MC.FechaRegistro as FechaRegistro
		FROM ODS.ProductoComercial PC WITH (NOLOCK)
		LEFT JOIN MatrizComercial MC WITH (NOLOCK) ON PC.CodigoProducto = MC.CodigoSAP
		WHERE CHARINDEX(case when @CodigoSAP = '' then PC.CodigoProducto else @CodigoSAP end, PC.CodigoProducto) > 0
	) t
	order by t.FechaRegistro desc
END
GO
/*end*/

USE BelcorpVenezuela
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[GetMatrizComercialByCodigoSAP]
	@CodigoSAP varchar(50)
AS
BEGIN
	select *
	from (
		SELECT distinct
			isnull(MC.IdMatrizComercial,0)IdMatrizComercial,
			PC.CodigoProducto as CodigoSAP,
			PC.Descripcion as DescripcionOriginal,
			isnull(MC.Descripcion,'') Descripcion,
			PC.CUV as CUV,
			MC.FechaRegistro as FechaRegistro
		FROM ODS.ProductoComercial PC WITH (NOLOCK)
		LEFT JOIN MatrizComercial MC WITH (NOLOCK) ON PC.CodigoProducto = MC.CodigoSAP
		WHERE CHARINDEX(case when @CodigoSAP = '' then PC.CodigoProducto else @CodigoSAP end, PC.CodigoProducto) > 0
	) t
	order by t.FechaRegistro desc
END
GO

