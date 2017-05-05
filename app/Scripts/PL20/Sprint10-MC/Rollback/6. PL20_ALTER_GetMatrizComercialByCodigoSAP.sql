USE BelcorpBolivia
GO

BEGIN
ALTER PROCEDURE GetMatrizComercialByCodigoSAP
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
			isnull(MC.FotoProducto01,'') FotoProducto01,
			isnull(MC.FotoProducto02,'') FotoProducto02,
			isnull(MC.FotoProducto03,'') FotoProducto03,
			isnull(MC.FotoProducto04,'') FotoProducto04,
			isnull(MC.FotoProducto05,'') FotoProducto05,
			isnull(MC.FotoProducto06,'') FotoProducto06,
			isnull(MC.FotoProducto07,'') FotoProducto07,
			isnull(MC.FotoProducto08,'') FotoProducto08,
			isnull(MC.FotoProducto09,'') FotoProducto09,
			isnull(MC.FotoProducto10,'') FotoProducto10
		FROM ODS.ProductoComercial PC WITH (NOLOCK)
		LEFT JOIN MatrizComercial MC WITH (NOLOCK) ON PC.CodigoProducto = MC.CodigoSAP
		WHERE CHARINDEX(case when @CodigoSAP = '' then PC.CodigoProducto else @CodigoSAP end, PC.CodigoProducto) > 0
	) t
	order by t.FotoProducto01
END
END
GO
/*end*/

USE BelcorpChile
GO

BEGIN
ALTER PROCEDURE GetMatrizComercialByCodigoSAP
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
			isnull(MC.FotoProducto01,'') FotoProducto01,
			isnull(MC.FotoProducto02,'') FotoProducto02,
			isnull(MC.FotoProducto03,'') FotoProducto03,
			isnull(MC.FotoProducto04,'') FotoProducto04,
			isnull(MC.FotoProducto05,'') FotoProducto05,
			isnull(MC.FotoProducto06,'') FotoProducto06,
			isnull(MC.FotoProducto07,'') FotoProducto07,
			isnull(MC.FotoProducto08,'') FotoProducto08,
			isnull(MC.FotoProducto09,'') FotoProducto09,
			isnull(MC.FotoProducto10,'') FotoProducto10
		FROM ODS.ProductoComercial PC WITH (NOLOCK)
		LEFT JOIN MatrizComercial MC WITH (NOLOCK) ON PC.CodigoProducto = MC.CodigoSAP
		WHERE CHARINDEX(case when @CodigoSAP = '' then PC.CodigoProducto else @CodigoSAP end, PC.CodigoProducto) > 0
	) t
	order by t.FotoProducto01
END
END
GO
/*end*/

USE BelcorpColombia
GO

BEGIN
ALTER PROCEDURE GetMatrizComercialByCodigoSAP
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
			isnull(MC.FotoProducto01,'') FotoProducto01,
			isnull(MC.FotoProducto02,'') FotoProducto02,
			isnull(MC.FotoProducto03,'') FotoProducto03,
			isnull(MC.FotoProducto04,'') FotoProducto04,
			isnull(MC.FotoProducto05,'') FotoProducto05,
			isnull(MC.FotoProducto06,'') FotoProducto06,
			isnull(MC.FotoProducto07,'') FotoProducto07,
			isnull(MC.FotoProducto08,'') FotoProducto08,
			isnull(MC.FotoProducto09,'') FotoProducto09,
			isnull(MC.FotoProducto10,'') FotoProducto10
		FROM ODS.ProductoComercial PC WITH (NOLOCK)
		LEFT JOIN MatrizComercial MC WITH (NOLOCK) ON PC.CodigoProducto = MC.CodigoSAP
		WHERE CHARINDEX(case when @CodigoSAP = '' then PC.CodigoProducto else @CodigoSAP end, PC.CodigoProducto) > 0
	) t
	order by t.FotoProducto01
END
END
GO
/*end*/

USE BelcorpCostaRica
GO

BEGIN
ALTER PROCEDURE GetMatrizComercialByCodigoSAP
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
			isnull(MC.FotoProducto01,'') FotoProducto01,
			isnull(MC.FotoProducto02,'') FotoProducto02,
			isnull(MC.FotoProducto03,'') FotoProducto03,
			isnull(MC.FotoProducto04,'') FotoProducto04,
			isnull(MC.FotoProducto05,'') FotoProducto05,
			isnull(MC.FotoProducto06,'') FotoProducto06,
			isnull(MC.FotoProducto07,'') FotoProducto07,
			isnull(MC.FotoProducto08,'') FotoProducto08,
			isnull(MC.FotoProducto09,'') FotoProducto09,
			isnull(MC.FotoProducto10,'') FotoProducto10
		FROM ODS.ProductoComercial PC WITH (NOLOCK)
		LEFT JOIN MatrizComercial MC WITH (NOLOCK) ON PC.CodigoProducto = MC.CodigoSAP
		WHERE CHARINDEX(case when @CodigoSAP = '' then PC.CodigoProducto else @CodigoSAP end, PC.CodigoProducto) > 0
	) t
	order by t.FotoProducto01
END
END
GO
/*end*/

USE BelcorpDominicana
GO

BEGIN
ALTER PROCEDURE GetMatrizComercialByCodigoSAP
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
			isnull(MC.FotoProducto01,'') FotoProducto01,
			isnull(MC.FotoProducto02,'') FotoProducto02,
			isnull(MC.FotoProducto03,'') FotoProducto03,
			isnull(MC.FotoProducto04,'') FotoProducto04,
			isnull(MC.FotoProducto05,'') FotoProducto05,
			isnull(MC.FotoProducto06,'') FotoProducto06,
			isnull(MC.FotoProducto07,'') FotoProducto07,
			isnull(MC.FotoProducto08,'') FotoProducto08,
			isnull(MC.FotoProducto09,'') FotoProducto09,
			isnull(MC.FotoProducto10,'') FotoProducto10
		FROM ODS.ProductoComercial PC WITH (NOLOCK)
		LEFT JOIN MatrizComercial MC WITH (NOLOCK) ON PC.CodigoProducto = MC.CodigoSAP
		WHERE CHARINDEX(case when @CodigoSAP = '' then PC.CodigoProducto else @CodigoSAP end, PC.CodigoProducto) > 0
	) t
	order by t.FotoProducto01
END
END
GO
/*end*/

USE BelcorpEcuador
GO

BEGIN
ALTER PROCEDURE GetMatrizComercialByCodigoSAP
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
			isnull(MC.FotoProducto01,'') FotoProducto01,
			isnull(MC.FotoProducto02,'') FotoProducto02,
			isnull(MC.FotoProducto03,'') FotoProducto03,
			isnull(MC.FotoProducto04,'') FotoProducto04,
			isnull(MC.FotoProducto05,'') FotoProducto05,
			isnull(MC.FotoProducto06,'') FotoProducto06,
			isnull(MC.FotoProducto07,'') FotoProducto07,
			isnull(MC.FotoProducto08,'') FotoProducto08,
			isnull(MC.FotoProducto09,'') FotoProducto09,
			isnull(MC.FotoProducto10,'') FotoProducto10
		FROM ODS.ProductoComercial PC WITH (NOLOCK)
		LEFT JOIN MatrizComercial MC WITH (NOLOCK) ON PC.CodigoProducto = MC.CodigoSAP
		WHERE CHARINDEX(case when @CodigoSAP = '' then PC.CodigoProducto else @CodigoSAP end, PC.CodigoProducto) > 0
	) t
	order by t.FotoProducto01
END
END
GO
/*end*/

USE BelcorpGuatemala
GO

BEGIN
ALTER PROCEDURE GetMatrizComercialByCodigoSAP
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
			isnull(MC.FotoProducto01,'') FotoProducto01,
			isnull(MC.FotoProducto02,'') FotoProducto02,
			isnull(MC.FotoProducto03,'') FotoProducto03,
			isnull(MC.FotoProducto04,'') FotoProducto04,
			isnull(MC.FotoProducto05,'') FotoProducto05,
			isnull(MC.FotoProducto06,'') FotoProducto06,
			isnull(MC.FotoProducto07,'') FotoProducto07,
			isnull(MC.FotoProducto08,'') FotoProducto08,
			isnull(MC.FotoProducto09,'') FotoProducto09,
			isnull(MC.FotoProducto10,'') FotoProducto10
		FROM ODS.ProductoComercial PC WITH (NOLOCK)
		LEFT JOIN MatrizComercial MC WITH (NOLOCK) ON PC.CodigoProducto = MC.CodigoSAP
		WHERE CHARINDEX(case when @CodigoSAP = '' then PC.CodigoProducto else @CodigoSAP end, PC.CodigoProducto) > 0
	) t
	order by t.FotoProducto01
END
END
GO
/*end*/

USE BelcorpMexico
GO

BEGIN
ALTER PROCEDURE GetMatrizComercialByCodigoSAP
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
			isnull(MC.FotoProducto01,'') FotoProducto01,
			isnull(MC.FotoProducto02,'') FotoProducto02,
			isnull(MC.FotoProducto03,'') FotoProducto03,
			isnull(MC.FotoProducto04,'') FotoProducto04,
			isnull(MC.FotoProducto05,'') FotoProducto05,
			isnull(MC.FotoProducto06,'') FotoProducto06,
			isnull(MC.FotoProducto07,'') FotoProducto07,
			isnull(MC.FotoProducto08,'') FotoProducto08,
			isnull(MC.FotoProducto09,'') FotoProducto09,
			isnull(MC.FotoProducto10,'') FotoProducto10
		FROM ODS.ProductoComercial PC WITH (NOLOCK)
		LEFT JOIN MatrizComercial MC WITH (NOLOCK) ON PC.CodigoProducto = MC.CodigoSAP
		WHERE CHARINDEX(case when @CodigoSAP = '' then PC.CodigoProducto else @CodigoSAP end, PC.CodigoProducto) > 0
	) t
	order by t.FotoProducto01
END
END
GO
/*end*/

USE BelcorpPanama
GO

BEGIN
ALTER PROCEDURE GetMatrizComercialByCodigoSAP
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
			isnull(MC.FotoProducto01,'') FotoProducto01,
			isnull(MC.FotoProducto02,'') FotoProducto02,
			isnull(MC.FotoProducto03,'') FotoProducto03,
			isnull(MC.FotoProducto04,'') FotoProducto04,
			isnull(MC.FotoProducto05,'') FotoProducto05,
			isnull(MC.FotoProducto06,'') FotoProducto06,
			isnull(MC.FotoProducto07,'') FotoProducto07,
			isnull(MC.FotoProducto08,'') FotoProducto08,
			isnull(MC.FotoProducto09,'') FotoProducto09,
			isnull(MC.FotoProducto10,'') FotoProducto10
		FROM ODS.ProductoComercial PC WITH (NOLOCK)
		LEFT JOIN MatrizComercial MC WITH (NOLOCK) ON PC.CodigoProducto = MC.CodigoSAP
		WHERE CHARINDEX(case when @CodigoSAP = '' then PC.CodigoProducto else @CodigoSAP end, PC.CodigoProducto) > 0
	) t
	order by t.FotoProducto01
END
END
GO
/*end*/

USE BelcorpPeru
GO

BEGIN
ALTER PROCEDURE GetMatrizComercialByCodigoSAP
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
			isnull(MC.FotoProducto01,'') FotoProducto01,
			isnull(MC.FotoProducto02,'') FotoProducto02,
			isnull(MC.FotoProducto03,'') FotoProducto03,
			isnull(MC.FotoProducto04,'') FotoProducto04,
			isnull(MC.FotoProducto05,'') FotoProducto05,
			isnull(MC.FotoProducto06,'') FotoProducto06,
			isnull(MC.FotoProducto07,'') FotoProducto07,
			isnull(MC.FotoProducto08,'') FotoProducto08,
			isnull(MC.FotoProducto09,'') FotoProducto09,
			isnull(MC.FotoProducto10,'') FotoProducto10
		FROM ODS.ProductoComercial PC WITH (NOLOCK)
		LEFT JOIN MatrizComercial MC WITH (NOLOCK) ON PC.CodigoProducto = MC.CodigoSAP
		WHERE CHARINDEX(case when @CodigoSAP = '' then PC.CodigoProducto else @CodigoSAP end, PC.CodigoProducto) > 0
	) t
	order by t.FotoProducto01
END
END
GO
/*end*/

USE BelcorpPuertoRico
GO

BEGIN
ALTER PROCEDURE GetMatrizComercialByCodigoSAP
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
			isnull(MC.FotoProducto01,'') FotoProducto01,
			isnull(MC.FotoProducto02,'') FotoProducto02,
			isnull(MC.FotoProducto03,'') FotoProducto03,
			isnull(MC.FotoProducto04,'') FotoProducto04,
			isnull(MC.FotoProducto05,'') FotoProducto05,
			isnull(MC.FotoProducto06,'') FotoProducto06,
			isnull(MC.FotoProducto07,'') FotoProducto07,
			isnull(MC.FotoProducto08,'') FotoProducto08,
			isnull(MC.FotoProducto09,'') FotoProducto09,
			isnull(MC.FotoProducto10,'') FotoProducto10
		FROM ODS.ProductoComercial PC WITH (NOLOCK)
		LEFT JOIN MatrizComercial MC WITH (NOLOCK) ON PC.CodigoProducto = MC.CodigoSAP
		WHERE CHARINDEX(case when @CodigoSAP = '' then PC.CodigoProducto else @CodigoSAP end, PC.CodigoProducto) > 0
	) t
	order by t.FotoProducto01
END
END
GO
/*end*/

USE BelcorpSalvador
GO

BEGIN
ALTER PROCEDURE GetMatrizComercialByCodigoSAP
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
			isnull(MC.FotoProducto01,'') FotoProducto01,
			isnull(MC.FotoProducto02,'') FotoProducto02,
			isnull(MC.FotoProducto03,'') FotoProducto03,
			isnull(MC.FotoProducto04,'') FotoProducto04,
			isnull(MC.FotoProducto05,'') FotoProducto05,
			isnull(MC.FotoProducto06,'') FotoProducto06,
			isnull(MC.FotoProducto07,'') FotoProducto07,
			isnull(MC.FotoProducto08,'') FotoProducto08,
			isnull(MC.FotoProducto09,'') FotoProducto09,
			isnull(MC.FotoProducto10,'') FotoProducto10
		FROM ODS.ProductoComercial PC WITH (NOLOCK)
		LEFT JOIN MatrizComercial MC WITH (NOLOCK) ON PC.CodigoProducto = MC.CodigoSAP
		WHERE CHARINDEX(case when @CodigoSAP = '' then PC.CodigoProducto else @CodigoSAP end, PC.CodigoProducto) > 0
	) t
	order by t.FotoProducto01
END
END
GO
/*end*/

USE BelcorpVenezuela
GO

BEGIN
ALTER PROCEDURE GetMatrizComercialByCodigoSAP
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
			isnull(MC.FotoProducto01,'') FotoProducto01,
			isnull(MC.FotoProducto02,'') FotoProducto02,
			isnull(MC.FotoProducto03,'') FotoProducto03,
			isnull(MC.FotoProducto04,'') FotoProducto04,
			isnull(MC.FotoProducto05,'') FotoProducto05,
			isnull(MC.FotoProducto06,'') FotoProducto06,
			isnull(MC.FotoProducto07,'') FotoProducto07,
			isnull(MC.FotoProducto08,'') FotoProducto08,
			isnull(MC.FotoProducto09,'') FotoProducto09,
			isnull(MC.FotoProducto10,'') FotoProducto10
		FROM ODS.ProductoComercial PC WITH (NOLOCK)
		LEFT JOIN MatrizComercial MC WITH (NOLOCK) ON PC.CodigoProducto = MC.CodigoSAP
		WHERE CHARINDEX(case when @CodigoSAP = '' then PC.CodigoProducto else @CodigoSAP end, PC.CodigoProducto) > 0
	) t
	order by t.FotoProducto01
END
END
GO

