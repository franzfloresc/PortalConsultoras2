USE BelcorpBolivia
GO
ALTER PROCEDURE GetMatrizComercialByCodigoSAP
	@CodigoSAP varchar(50)
AS
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
GO
USE BelcorpCostaRica
GO
ALTER PROCEDURE GetMatrizComercialByCodigoSAP
	@CodigoSAP varchar(50)
AS
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
GO
USE BelcorpChile
GO
ALTER PROCEDURE GetMatrizComercialByCodigoSAP
	@CodigoSAP varchar(50)
AS
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
GO
USE BelcorpColombia
GO
ALTER PROCEDURE GetMatrizComercialByCodigoSAP
	@CodigoSAP varchar(50)
AS
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
GO
USE BelcorpDominicana
GO
ALTER PROCEDURE GetMatrizComercialByCodigoSAP
	@CodigoSAP varchar(50)
AS
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
GO
USE BelcorpEcuador
GO
ALTER PROCEDURE GetMatrizComercialByCodigoSAP
	@CodigoSAP varchar(50)
AS
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
GO
USE BelcorpGuatemala
GO
ALTER PROCEDURE GetMatrizComercialByCodigoSAP
	@CodigoSAP varchar(50)
AS
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
GO
USE BelcorpMexico
GO
ALTER PROCEDURE GetMatrizComercialByCodigoSAP
	@CodigoSAP varchar(50)
AS
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
GO
USE BelcorpPanama
GO
ALTER PROCEDURE GetMatrizComercialByCodigoSAP
	@CodigoSAP varchar(50)
AS
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
GO
USE BelcorpPeru
GO
ALTER PROCEDURE GetMatrizComercialByCodigoSAP
	@CodigoSAP varchar(50)
AS
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
GO
USE BelcorpPuertoRico
GO
ALTER PROCEDURE GetMatrizComercialByCodigoSAP
	@CodigoSAP varchar(50)
AS
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
GO
USE BelcorpSalvador
GO
ALTER PROCEDURE GetMatrizComercialByCodigoSAP
	@CodigoSAP varchar(50)
AS
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
GO
USE BelcorpVenezuela
GO
ALTER PROCEDURE GetMatrizComercialByCodigoSAP
	@CodigoSAP varchar(50)
AS
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
GO
