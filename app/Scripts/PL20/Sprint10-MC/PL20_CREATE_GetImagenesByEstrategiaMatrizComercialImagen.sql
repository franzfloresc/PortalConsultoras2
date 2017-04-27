USE BelcorpBolivia
GO


BEGIN
	CREATE PROCEDURE [dbo].[GetImagenesByEstrategiaMatrizComercialImagen]
(
	@EstrategiaID int,
	@NumeroPagina int,
	@Registros int
)
AS
BEGIN

SELECT 
    *,
	COUNT(*) OVER() AS TotalRegistros
	FROM
	(
		SELECT isnull(IdMatrizComercialImagen,0)IdMatrizComercialImagen,
			   mci.IdMatrizComercial,
			   isnull(mci.Foto,'') Foto,
			   mci.FechaRegistro			   
		FROM dbo.Estrategia e
		INNER JOIN ods.productocomercial pc on e.cuv2 = pc.cuv
		INNER JOIN MatrizComercial mc ON mc.CodigoSAP = pc.CodigoProducto
		INNER JOIN ods.Campania c ON c.CampaniaID = pc.CampaniaID AND c.codigo = e.campaniaID
		INNER JOIN MatrizComercialImagen mci on mci.IdMatrizComercial = mc.IdMatrizComercial
		where e.EstrategiaID = @EstrategiaID
	) as T
	order by FechaRegistro desc
	OFFSET (@NumeroPagina-1)*@Registros ROWS
	FETCH NEXT @Registros ROWS ONLY;

END
GO

/*end*/

USE BelcorpChile
GO

BEGIN
	CREATE PROCEDURE [dbo].[GetImagenesByEstrategiaMatrizComercialImagen]
(
	@EstrategiaID int,
	@NumeroPagina int,
	@Registros int
)
AS
BEGIN

SELECT 
    *,
	COUNT(*) OVER() AS TotalRegistros
	FROM
	(
		SELECT isnull(IdMatrizComercialImagen,0)IdMatrizComercialImagen,
			   mci.IdMatrizComercial,
			   isnull(mci.Foto,'') Foto,
			   mci.FechaRegistro			   
		FROM dbo.Estrategia e
		INNER JOIN ods.productocomercial pc on e.cuv2 = pc.cuv
		INNER JOIN MatrizComercial mc ON mc.CodigoSAP = pc.CodigoProducto
		INNER JOIN ods.Campania c ON c.CampaniaID = pc.CampaniaID AND c.codigo = e.campaniaID
		INNER JOIN MatrizComercialImagen mci on mci.IdMatrizComercial = mc.IdMatrizComercial
		where e.EstrategiaID = @EstrategiaID
	) as T
	order by FechaRegistro desc
	OFFSET (@NumeroPagina-1)*@Registros ROWS
	FETCH NEXT @Registros ROWS ONLY;

END
GO
/*end*/

USE BelcorpColombia
GO

BEGIN
	CREATE PROCEDURE [dbo].[GetImagenesByEstrategiaMatrizComercialImagen]
(
	@EstrategiaID int,
	@NumeroPagina int,
	@Registros int
)
AS
BEGIN

SELECT 
    *,
	COUNT(*) OVER() AS TotalRegistros
	FROM
	(
		SELECT isnull(IdMatrizComercialImagen,0)IdMatrizComercialImagen,
			   mci.IdMatrizComercial,
			   isnull(mci.Foto,'') Foto,
			   mci.FechaRegistro			   
		FROM dbo.Estrategia e
		INNER JOIN ods.productocomercial pc on e.cuv2 = pc.cuv
		INNER JOIN MatrizComercial mc ON mc.CodigoSAP = pc.CodigoProducto
		INNER JOIN ods.Campania c ON c.CampaniaID = pc.CampaniaID AND c.codigo = e.campaniaID
		INNER JOIN MatrizComercialImagen mci on mci.IdMatrizComercial = mc.IdMatrizComercial
		where e.EstrategiaID = @EstrategiaID
	) as T
	order by FechaRegistro desc
	OFFSET (@NumeroPagina-1)*@Registros ROWS
	FETCH NEXT @Registros ROWS ONLY;

END
GO
/*end*/

USE BelcorpCostaRica
GO

BEGIN
	CREATE PROCEDURE [dbo].[GetImagenesByEstrategiaMatrizComercialImagen]
(
	@EstrategiaID int,
	@NumeroPagina int,
	@Registros int
)
AS
BEGIN

SELECT 
    *,
	COUNT(*) OVER() AS TotalRegistros
	FROM
	(
		SELECT isnull(IdMatrizComercialImagen,0)IdMatrizComercialImagen,
			   mci.IdMatrizComercial,
			   isnull(mci.Foto,'') Foto,
			   mci.FechaRegistro			   
		FROM dbo.Estrategia e
		INNER JOIN ods.productocomercial pc on e.cuv2 = pc.cuv
		INNER JOIN MatrizComercial mc ON mc.CodigoSAP = pc.CodigoProducto
		INNER JOIN ods.Campania c ON c.CampaniaID = pc.CampaniaID AND c.codigo = e.campaniaID
		INNER JOIN MatrizComercialImagen mci on mci.IdMatrizComercial = mc.IdMatrizComercial
		where e.EstrategiaID = @EstrategiaID
	) as T
	order by FechaRegistro desc
	OFFSET (@NumeroPagina-1)*@Registros ROWS
	FETCH NEXT @Registros ROWS ONLY;

END
GO
/*end*/

USE BelcorpDominicana
GO

BEGIN
	CREATE PROCEDURE [dbo].[GetImagenesByEstrategiaMatrizComercialImagen]
(
	@EstrategiaID int,
	@NumeroPagina int,
	@Registros int
)
AS
BEGIN

SELECT 
    *,
	COUNT(*) OVER() AS TotalRegistros
	FROM
	(
		SELECT isnull(IdMatrizComercialImagen,0)IdMatrizComercialImagen,
			   mci.IdMatrizComercial,
			   isnull(mci.Foto,'') Foto,
			   mci.FechaRegistro			   
		FROM dbo.Estrategia e
		INNER JOIN ods.productocomercial pc on e.cuv2 = pc.cuv
		INNER JOIN MatrizComercial mc ON mc.CodigoSAP = pc.CodigoProducto
		INNER JOIN ods.Campania c ON c.CampaniaID = pc.CampaniaID AND c.codigo = e.campaniaID
		INNER JOIN MatrizComercialImagen mci on mci.IdMatrizComercial = mc.IdMatrizComercial
		where e.EstrategiaID = @EstrategiaID
	) as T
	order by FechaRegistro desc
	OFFSET (@NumeroPagina-1)*@Registros ROWS
	FETCH NEXT @Registros ROWS ONLY;

END
GO
/*end*/

USE BelcorpEcuador
GO

BEGIN
	CREATE PROCEDURE [dbo].[GetImagenesByEstrategiaMatrizComercialImagen]
(
	@EstrategiaID int,
	@NumeroPagina int,
	@Registros int
)
AS
BEGIN

SELECT 
    *,
	COUNT(*) OVER() AS TotalRegistros
	FROM
	(
		SELECT isnull(IdMatrizComercialImagen,0)IdMatrizComercialImagen,
			   mci.IdMatrizComercial,
			   isnull(mci.Foto,'') Foto,
			   mci.FechaRegistro			   
		FROM dbo.Estrategia e
		INNER JOIN ods.productocomercial pc on e.cuv2 = pc.cuv
		INNER JOIN MatrizComercial mc ON mc.CodigoSAP = pc.CodigoProducto
		INNER JOIN ods.Campania c ON c.CampaniaID = pc.CampaniaID AND c.codigo = e.campaniaID
		INNER JOIN MatrizComercialImagen mci on mci.IdMatrizComercial = mc.IdMatrizComercial
		where e.EstrategiaID = @EstrategiaID
	) as T
	order by FechaRegistro desc
	OFFSET (@NumeroPagina-1)*@Registros ROWS
	FETCH NEXT @Registros ROWS ONLY;

END
GO
/*end*/

USE BelcorpGuatemala
GO

BEGIN
	CREATE PROCEDURE [dbo].[GetImagenesByEstrategiaMatrizComercialImagen]
(
	@EstrategiaID int,
	@NumeroPagina int,
	@Registros int
)
AS
BEGIN

SELECT 
    *,
	COUNT(*) OVER() AS TotalRegistros
	FROM
	(
		SELECT isnull(IdMatrizComercialImagen,0)IdMatrizComercialImagen,
			   mci.IdMatrizComercial,
			   isnull(mci.Foto,'') Foto,
			   mci.FechaRegistro			   
		FROM dbo.Estrategia e
		INNER JOIN ods.productocomercial pc on e.cuv2 = pc.cuv
		INNER JOIN MatrizComercial mc ON mc.CodigoSAP = pc.CodigoProducto
		INNER JOIN ods.Campania c ON c.CampaniaID = pc.CampaniaID AND c.codigo = e.campaniaID
		INNER JOIN MatrizComercialImagen mci on mci.IdMatrizComercial = mc.IdMatrizComercial
		where e.EstrategiaID = @EstrategiaID
	) as T
	order by FechaRegistro desc
	OFFSET (@NumeroPagina-1)*@Registros ROWS
	FETCH NEXT @Registros ROWS ONLY;

END
GO
/*end*/

USE BelcorpMexico
GO

BEGIN
	CREATE PROCEDURE [dbo].[GetImagenesByEstrategiaMatrizComercialImagen]
(
	@EstrategiaID int,
	@NumeroPagina int,
	@Registros int
)
AS
BEGIN

SELECT 
    *,
	COUNT(*) OVER() AS TotalRegistros
	FROM
	(
		SELECT isnull(IdMatrizComercialImagen,0)IdMatrizComercialImagen,
			   mci.IdMatrizComercial,
			   isnull(mci.Foto,'') Foto,
			   mci.FechaRegistro			   
		FROM dbo.Estrategia e
		INNER JOIN ods.productocomercial pc on e.cuv2 = pc.cuv
		INNER JOIN MatrizComercial mc ON mc.CodigoSAP = pc.CodigoProducto
		INNER JOIN ods.Campania c ON c.CampaniaID = pc.CampaniaID AND c.codigo = e.campaniaID
		INNER JOIN MatrizComercialImagen mci on mci.IdMatrizComercial = mc.IdMatrizComercial
		where e.EstrategiaID = @EstrategiaID
	) as T
	order by FechaRegistro desc
	OFFSET (@NumeroPagina-1)*@Registros ROWS
	FETCH NEXT @Registros ROWS ONLY;

END
GO
/*end*/

USE BelcorpPanama
GO

BEGIN
	CREATE PROCEDURE [dbo].[GetImagenesByEstrategiaMatrizComercialImagen]
(
	@EstrategiaID int,
	@NumeroPagina int,
	@Registros int
)
AS
BEGIN

SELECT 
    *,
	COUNT(*) OVER() AS TotalRegistros
	FROM
	(
		SELECT isnull(IdMatrizComercialImagen,0)IdMatrizComercialImagen,
			   mci.IdMatrizComercial,
			   isnull(mci.Foto,'') Foto,
			   mci.FechaRegistro			   
		FROM dbo.Estrategia e
		INNER JOIN ods.productocomercial pc on e.cuv2 = pc.cuv
		INNER JOIN MatrizComercial mc ON mc.CodigoSAP = pc.CodigoProducto
		INNER JOIN ods.Campania c ON c.CampaniaID = pc.CampaniaID AND c.codigo = e.campaniaID
		INNER JOIN MatrizComercialImagen mci on mci.IdMatrizComercial = mc.IdMatrizComercial
		where e.EstrategiaID = @EstrategiaID
	) as T
	order by FechaRegistro desc
	OFFSET (@NumeroPagina-1)*@Registros ROWS
	FETCH NEXT @Registros ROWS ONLY;

END
GO
/*end*/

USE BelcorpPeru
GO

BEGIN
	CREATE PROCEDURE [dbo].[GetImagenesByEstrategiaMatrizComercialImagen]
(
	@EstrategiaID int,
	@NumeroPagina int,
	@Registros int
)
AS
BEGIN

SELECT 
    *,
	COUNT(*) OVER() AS TotalRegistros
	FROM
	(
		SELECT isnull(IdMatrizComercialImagen,0)IdMatrizComercialImagen,
			   mci.IdMatrizComercial,
			   isnull(mci.Foto,'') Foto,
			   mci.FechaRegistro			   
		FROM dbo.Estrategia e
		INNER JOIN ods.productocomercial pc on e.cuv2 = pc.cuv
		INNER JOIN MatrizComercial mc ON mc.CodigoSAP = pc.CodigoProducto
		INNER JOIN ods.Campania c ON c.CampaniaID = pc.CampaniaID AND c.codigo = e.campaniaID
		INNER JOIN MatrizComercialImagen mci on mci.IdMatrizComercial = mc.IdMatrizComercial
		where e.EstrategiaID = @EstrategiaID
	) as T
	order by FechaRegistro desc
	OFFSET (@NumeroPagina-1)*@Registros ROWS
	FETCH NEXT @Registros ROWS ONLY;

END
GO
/*end*/

USE BelcorpPuertoRico
GO

BEGIN
	CREATE PROCEDURE [dbo].[GetImagenesByEstrategiaMatrizComercialImagen]
(
	@EstrategiaID int,
	@NumeroPagina int,
	@Registros int
)
AS
BEGIN

SELECT 
    *,
	COUNT(*) OVER() AS TotalRegistros
	FROM
	(
		SELECT isnull(IdMatrizComercialImagen,0)IdMatrizComercialImagen,
			   mci.IdMatrizComercial,
			   isnull(mci.Foto,'') Foto,
			   mci.FechaRegistro			   
		FROM dbo.Estrategia e
		INNER JOIN ods.productocomercial pc on e.cuv2 = pc.cuv
		INNER JOIN MatrizComercial mc ON mc.CodigoSAP = pc.CodigoProducto
		INNER JOIN ods.Campania c ON c.CampaniaID = pc.CampaniaID AND c.codigo = e.campaniaID
		INNER JOIN MatrizComercialImagen mci on mci.IdMatrizComercial = mc.IdMatrizComercial
		where e.EstrategiaID = @EstrategiaID
	) as T
	order by FechaRegistro desc
	OFFSET (@NumeroPagina-1)*@Registros ROWS
	FETCH NEXT @Registros ROWS ONLY;

END
GO
/*end*/

USE BelcorpSalvador
GO

BEGIN
	CREATE PROCEDURE [dbo].[GetImagenesByEstrategiaMatrizComercialImagen]
(
	@EstrategiaID int,
	@NumeroPagina int,
	@Registros int
)
AS
BEGIN

SELECT 
    *,
	COUNT(*) OVER() AS TotalRegistros
	FROM
	(
		SELECT isnull(IdMatrizComercialImagen,0)IdMatrizComercialImagen,
			   mci.IdMatrizComercial,
			   isnull(mci.Foto,'') Foto,
			   mci.FechaRegistro			   
		FROM dbo.Estrategia e
		INNER JOIN ods.productocomercial pc on e.cuv2 = pc.cuv
		INNER JOIN MatrizComercial mc ON mc.CodigoSAP = pc.CodigoProducto
		INNER JOIN ods.Campania c ON c.CampaniaID = pc.CampaniaID AND c.codigo = e.campaniaID
		INNER JOIN MatrizComercialImagen mci on mci.IdMatrizComercial = mc.IdMatrizComercial
		where e.EstrategiaID = @EstrategiaID
	) as T
	order by FechaRegistro desc
	OFFSET (@NumeroPagina-1)*@Registros ROWS
	FETCH NEXT @Registros ROWS ONLY;

END
GO
/*end*/

USE BelcorpVenezuela
GO

BEGIN
	CREATE PROCEDURE [dbo].[GetImagenesByEstrategiaMatrizComercialImagen]
(
	@EstrategiaID int,
	@NumeroPagina int,
	@Registros int
)
AS
BEGIN

SELECT 
    *,
	COUNT(*) OVER() AS TotalRegistros
	FROM
	(
		SELECT isnull(IdMatrizComercialImagen,0)IdMatrizComercialImagen,
			   mci.IdMatrizComercial,
			   isnull(mci.Foto,'') Foto,
			   mci.FechaRegistro			   
		FROM dbo.Estrategia e
		INNER JOIN ods.productocomercial pc on e.cuv2 = pc.cuv
		INNER JOIN MatrizComercial mc ON mc.CodigoSAP = pc.CodigoProducto
		INNER JOIN ods.Campania c ON c.CampaniaID = pc.CampaniaID AND c.codigo = e.campaniaID
		INNER JOIN MatrizComercialImagen mci on mci.IdMatrizComercial = mc.IdMatrizComercial
		where e.EstrategiaID = @EstrategiaID
	) as T
	order by FechaRegistro desc
	OFFSET (@NumeroPagina-1)*@Registros ROWS
	FETCH NEXT @Registros ROWS ONLY;

END
GO











