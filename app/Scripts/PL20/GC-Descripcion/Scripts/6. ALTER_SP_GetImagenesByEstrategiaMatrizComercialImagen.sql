USE BelcorpBolivia
GO

ALTER PROCEDURE [dbo].[GetImagenesByEstrategiaMatrizComercialImagen]
(
	@EstrategiaID int,
	@CUV2 varchar(50),
	@TipoEstrategiaID INT = 0,
	@CampaniaID INT = 0,
	@NumeroPagina int,
	@Registros int
)
AS

SELECT 
    *,
	COUNT(*) OVER() AS TotalRegistros
	FROM
	(
		SELECT isnull(IdMatrizComercialImagen,0)IdMatrizComercialImagen,
			   mci.IdMatrizComercial,
			   isnull(mci.Foto,'') Foto,
			   mci.NemoTecnico,
			   mci.DescripcionComercial,
			   mci.FechaRegistro			   
		FROM dbo.Estrategia e
		INNER JOIN ods.productocomercial pc on e.cuv2 = pc.cuv
		INNER JOIN MatrizComercial mc ON mc.CodigoSAP = pc.CodigoProducto
		INNER JOIN ods.Campania c ON c.CampaniaID = pc.CampaniaID AND c.codigo = e.campaniaID
		INNER JOIN MatrizComercialImagen mci on mci.IdMatrizComercial = mc.IdMatrizComercial
		where 
		((@EstrategiaID = 0) OR (@EstrategiaID IS NULL) OR (e.EstrategiaID = @EstrategiaID))
		AND
		((@CUV2 = '')  OR (@CUV2 IS NULL) OR (e.CUV2 = @CUV2))
		AND
		((@CampaniaID = 0) OR (@CampaniaID IS NULL) OR (e.CampaniaID = @CampaniaID))
		AND
		((@TipoEstrategiaID = 0) OR (@TipoEstrategiaID IS NULL) OR (e.TipoEstrategiaID = @TipoEstrategiaID))
	) as T
	order by FechaRegistro desc
	OFFSET (@NumeroPagina-1)*@Registros ROWS
	FETCH NEXT @Registros ROWS ONLY;

	GO

USE BelcorpChile
GO

ALTER PROCEDURE [dbo].[GetImagenesByEstrategiaMatrizComercialImagen]
(
	@EstrategiaID int,
	@CUV2 varchar(50),
	@TipoEstrategiaID INT = 0,
	@CampaniaID INT = 0,
	@NumeroPagina int,
	@Registros int
)
AS

SELECT 
    *,
	COUNT(*) OVER() AS TotalRegistros
	FROM
	(
		SELECT isnull(IdMatrizComercialImagen,0)IdMatrizComercialImagen,
			   mci.IdMatrizComercial,
			   isnull(mci.Foto,'') Foto,
			   mci.NemoTecnico,
			   mci.DescripcionComercial,
			   mci.FechaRegistro			   
		FROM dbo.Estrategia e
		INNER JOIN ods.productocomercial pc on e.cuv2 = pc.cuv
		INNER JOIN MatrizComercial mc ON mc.CodigoSAP = pc.CodigoProducto
		INNER JOIN ods.Campania c ON c.CampaniaID = pc.CampaniaID AND c.codigo = e.campaniaID
		INNER JOIN MatrizComercialImagen mci on mci.IdMatrizComercial = mc.IdMatrizComercial
		where 
		((@EstrategiaID = 0) OR (@EstrategiaID IS NULL) OR (e.EstrategiaID = @EstrategiaID))
		AND
		((@CUV2 = '')  OR (@CUV2 IS NULL) OR (e.CUV2 = @CUV2))
		AND
		((@CampaniaID = 0) OR (@CampaniaID IS NULL) OR (e.CampaniaID = @CampaniaID))
		AND
		((@TipoEstrategiaID = 0) OR (@TipoEstrategiaID IS NULL) OR (e.TipoEstrategiaID = @TipoEstrategiaID))
	) as T
	order by FechaRegistro desc
	OFFSET (@NumeroPagina-1)*@Registros ROWS
	FETCH NEXT @Registros ROWS ONLY;

	GO

USE BelcorpColombia
GO

ALTER PROCEDURE [dbo].[GetImagenesByEstrategiaMatrizComercialImagen]
(
	@EstrategiaID int,
	@CUV2 varchar(50),
	@TipoEstrategiaID INT = 0,
	@CampaniaID INT = 0,
	@NumeroPagina int,
	@Registros int
)
AS

SELECT 
    *,
	COUNT(*) OVER() AS TotalRegistros
	FROM
	(
		SELECT isnull(IdMatrizComercialImagen,0)IdMatrizComercialImagen,
			   mci.IdMatrizComercial,
			   isnull(mci.Foto,'') Foto,
			   mci.NemoTecnico,
			   mci.DescripcionComercial,
			   mci.FechaRegistro			   
		FROM dbo.Estrategia e
		INNER JOIN ods.productocomercial pc on e.cuv2 = pc.cuv
		INNER JOIN MatrizComercial mc ON mc.CodigoSAP = pc.CodigoProducto
		INNER JOIN ods.Campania c ON c.CampaniaID = pc.CampaniaID AND c.codigo = e.campaniaID
		INNER JOIN MatrizComercialImagen mci on mci.IdMatrizComercial = mc.IdMatrizComercial
		where 
		((@EstrategiaID = 0) OR (@EstrategiaID IS NULL) OR (e.EstrategiaID = @EstrategiaID))
		AND
		((@CUV2 = '')  OR (@CUV2 IS NULL) OR (e.CUV2 = @CUV2))
		AND
		((@CampaniaID = 0) OR (@CampaniaID IS NULL) OR (e.CampaniaID = @CampaniaID))
		AND
		((@TipoEstrategiaID = 0) OR (@TipoEstrategiaID IS NULL) OR (e.TipoEstrategiaID = @TipoEstrategiaID))
	) as T
	order by FechaRegistro desc
	OFFSET (@NumeroPagina-1)*@Registros ROWS
	FETCH NEXT @Registros ROWS ONLY;

	GO

USE BelcorpCostaRica
GO

ALTER PROCEDURE [dbo].[GetImagenesByEstrategiaMatrizComercialImagen]
(
	@EstrategiaID int,
	@CUV2 varchar(50),
	@TipoEstrategiaID INT = 0,
	@CampaniaID INT = 0,
	@NumeroPagina int,
	@Registros int
)
AS

SELECT 
    *,
	COUNT(*) OVER() AS TotalRegistros
	FROM
	(
		SELECT isnull(IdMatrizComercialImagen,0)IdMatrizComercialImagen,
			   mci.IdMatrizComercial,
			   isnull(mci.Foto,'') Foto,
			   mci.NemoTecnico,
			   mci.DescripcionComercial,
			   mci.FechaRegistro			   
		FROM dbo.Estrategia e
		INNER JOIN ods.productocomercial pc on e.cuv2 = pc.cuv
		INNER JOIN MatrizComercial mc ON mc.CodigoSAP = pc.CodigoProducto
		INNER JOIN ods.Campania c ON c.CampaniaID = pc.CampaniaID AND c.codigo = e.campaniaID
		INNER JOIN MatrizComercialImagen mci on mci.IdMatrizComercial = mc.IdMatrizComercial
		where 
		((@EstrategiaID = 0) OR (@EstrategiaID IS NULL) OR (e.EstrategiaID = @EstrategiaID))
		AND
		((@CUV2 = '')  OR (@CUV2 IS NULL) OR (e.CUV2 = @CUV2))
		AND
		((@CampaniaID = 0) OR (@CampaniaID IS NULL) OR (e.CampaniaID = @CampaniaID))
		AND
		((@TipoEstrategiaID = 0) OR (@TipoEstrategiaID IS NULL) OR (e.TipoEstrategiaID = @TipoEstrategiaID))
	) as T
	order by FechaRegistro desc
	OFFSET (@NumeroPagina-1)*@Registros ROWS
	FETCH NEXT @Registros ROWS ONLY;

	GO

USE BelcorpDominicana
GO

ALTER PROCEDURE [dbo].[GetImagenesByEstrategiaMatrizComercialImagen]
(
	@EstrategiaID int,
	@CUV2 varchar(50),
	@TipoEstrategiaID INT = 0,
	@CampaniaID INT = 0,
	@NumeroPagina int,
	@Registros int
)
AS

SELECT 
    *,
	COUNT(*) OVER() AS TotalRegistros
	FROM
	(
		SELECT isnull(IdMatrizComercialImagen,0)IdMatrizComercialImagen,
			   mci.IdMatrizComercial,
			   isnull(mci.Foto,'') Foto,
			   mci.NemoTecnico,
			   mci.DescripcionComercial,
			   mci.FechaRegistro			   
		FROM dbo.Estrategia e
		INNER JOIN ods.productocomercial pc on e.cuv2 = pc.cuv
		INNER JOIN MatrizComercial mc ON mc.CodigoSAP = pc.CodigoProducto
		INNER JOIN ods.Campania c ON c.CampaniaID = pc.CampaniaID AND c.codigo = e.campaniaID
		INNER JOIN MatrizComercialImagen mci on mci.IdMatrizComercial = mc.IdMatrizComercial
		where 
		((@EstrategiaID = 0) OR (@EstrategiaID IS NULL) OR (e.EstrategiaID = @EstrategiaID))
		AND
		((@CUV2 = '')  OR (@CUV2 IS NULL) OR (e.CUV2 = @CUV2))
		AND
		((@CampaniaID = 0) OR (@CampaniaID IS NULL) OR (e.CampaniaID = @CampaniaID))
		AND
		((@TipoEstrategiaID = 0) OR (@TipoEstrategiaID IS NULL) OR (e.TipoEstrategiaID = @TipoEstrategiaID))
	) as T
	order by FechaRegistro desc
	OFFSET (@NumeroPagina-1)*@Registros ROWS
	FETCH NEXT @Registros ROWS ONLY;

	GO

USE BelcorpEcuador
GO

ALTER PROCEDURE [dbo].[GetImagenesByEstrategiaMatrizComercialImagen]
(
	@EstrategiaID int,
	@CUV2 varchar(50),
	@TipoEstrategiaID INT = 0,
	@CampaniaID INT = 0,
	@NumeroPagina int,
	@Registros int
)
AS

SELECT 
    *,
	COUNT(*) OVER() AS TotalRegistros
	FROM
	(
		SELECT isnull(IdMatrizComercialImagen,0)IdMatrizComercialImagen,
			   mci.IdMatrizComercial,
			   isnull(mci.Foto,'') Foto,
			   mci.NemoTecnico,
			   mci.DescripcionComercial,
			   mci.FechaRegistro			   
		FROM dbo.Estrategia e
		INNER JOIN ods.productocomercial pc on e.cuv2 = pc.cuv
		INNER JOIN MatrizComercial mc ON mc.CodigoSAP = pc.CodigoProducto
		INNER JOIN ods.Campania c ON c.CampaniaID = pc.CampaniaID AND c.codigo = e.campaniaID
		INNER JOIN MatrizComercialImagen mci on mci.IdMatrizComercial = mc.IdMatrizComercial
		where 
		((@EstrategiaID = 0) OR (@EstrategiaID IS NULL) OR (e.EstrategiaID = @EstrategiaID))
		AND
		((@CUV2 = '')  OR (@CUV2 IS NULL) OR (e.CUV2 = @CUV2))
		AND
		((@CampaniaID = 0) OR (@CampaniaID IS NULL) OR (e.CampaniaID = @CampaniaID))
		AND
		((@TipoEstrategiaID = 0) OR (@TipoEstrategiaID IS NULL) OR (e.TipoEstrategiaID = @TipoEstrategiaID))
	) as T
	order by FechaRegistro desc
	OFFSET (@NumeroPagina-1)*@Registros ROWS
	FETCH NEXT @Registros ROWS ONLY;

	GO

USE BelcorpGuatemala
GO

ALTER PROCEDURE [dbo].[GetImagenesByEstrategiaMatrizComercialImagen]
(
	@EstrategiaID int,
	@CUV2 varchar(50),
	@TipoEstrategiaID INT = 0,
	@CampaniaID INT = 0,
	@NumeroPagina int,
	@Registros int
)
AS

SELECT 
    *,
	COUNT(*) OVER() AS TotalRegistros
	FROM
	(
		SELECT isnull(IdMatrizComercialImagen,0)IdMatrizComercialImagen,
			   mci.IdMatrizComercial,
			   isnull(mci.Foto,'') Foto,
			   mci.NemoTecnico,
			   mci.DescripcionComercial,
			   mci.FechaRegistro			   
		FROM dbo.Estrategia e
		INNER JOIN ods.productocomercial pc on e.cuv2 = pc.cuv
		INNER JOIN MatrizComercial mc ON mc.CodigoSAP = pc.CodigoProducto
		INNER JOIN ods.Campania c ON c.CampaniaID = pc.CampaniaID AND c.codigo = e.campaniaID
		INNER JOIN MatrizComercialImagen mci on mci.IdMatrizComercial = mc.IdMatrizComercial
		where 
		((@EstrategiaID = 0) OR (@EstrategiaID IS NULL) OR (e.EstrategiaID = @EstrategiaID))
		AND
		((@CUV2 = '')  OR (@CUV2 IS NULL) OR (e.CUV2 = @CUV2))
		AND
		((@CampaniaID = 0) OR (@CampaniaID IS NULL) OR (e.CampaniaID = @CampaniaID))
		AND
		((@TipoEstrategiaID = 0) OR (@TipoEstrategiaID IS NULL) OR (e.TipoEstrategiaID = @TipoEstrategiaID))
	) as T
	order by FechaRegistro desc
	OFFSET (@NumeroPagina-1)*@Registros ROWS
	FETCH NEXT @Registros ROWS ONLY;

	GO

USE BelcorpMexico
GO

ALTER PROCEDURE [dbo].[GetImagenesByEstrategiaMatrizComercialImagen]
(
	@EstrategiaID int,
	@CUV2 varchar(50),
	@TipoEstrategiaID INT = 0,
	@CampaniaID INT = 0,
	@NumeroPagina int,
	@Registros int
)
AS

SELECT 
    *,
	COUNT(*) OVER() AS TotalRegistros
	FROM
	(
		SELECT isnull(IdMatrizComercialImagen,0)IdMatrizComercialImagen,
			   mci.IdMatrizComercial,
			   isnull(mci.Foto,'') Foto,
			   mci.NemoTecnico,
			   mci.DescripcionComercial,
			   mci.FechaRegistro			   
		FROM dbo.Estrategia e
		INNER JOIN ods.productocomercial pc on e.cuv2 = pc.cuv
		INNER JOIN MatrizComercial mc ON mc.CodigoSAP = pc.CodigoProducto
		INNER JOIN ods.Campania c ON c.CampaniaID = pc.CampaniaID AND c.codigo = e.campaniaID
		INNER JOIN MatrizComercialImagen mci on mci.IdMatrizComercial = mc.IdMatrizComercial
		where 
		((@EstrategiaID = 0) OR (@EstrategiaID IS NULL) OR (e.EstrategiaID = @EstrategiaID))
		AND
		((@CUV2 = '')  OR (@CUV2 IS NULL) OR (e.CUV2 = @CUV2))
		AND
		((@CampaniaID = 0) OR (@CampaniaID IS NULL) OR (e.CampaniaID = @CampaniaID))
		AND
		((@TipoEstrategiaID = 0) OR (@TipoEstrategiaID IS NULL) OR (e.TipoEstrategiaID = @TipoEstrategiaID))
	) as T
	order by FechaRegistro desc
	OFFSET (@NumeroPagina-1)*@Registros ROWS
	FETCH NEXT @Registros ROWS ONLY;

	GO

USE BelcorpPanama
GO

ALTER PROCEDURE [dbo].[GetImagenesByEstrategiaMatrizComercialImagen]
(
	@EstrategiaID int,
	@CUV2 varchar(50),
	@TipoEstrategiaID INT = 0,
	@CampaniaID INT = 0,
	@NumeroPagina int,
	@Registros int
)
AS

SELECT 
    *,
	COUNT(*) OVER() AS TotalRegistros
	FROM
	(
		SELECT isnull(IdMatrizComercialImagen,0)IdMatrizComercialImagen,
			   mci.IdMatrizComercial,
			   isnull(mci.Foto,'') Foto,
			   mci.NemoTecnico,
			   mci.DescripcionComercial,
			   mci.FechaRegistro			   
		FROM dbo.Estrategia e
		INNER JOIN ods.productocomercial pc on e.cuv2 = pc.cuv
		INNER JOIN MatrizComercial mc ON mc.CodigoSAP = pc.CodigoProducto
		INNER JOIN ods.Campania c ON c.CampaniaID = pc.CampaniaID AND c.codigo = e.campaniaID
		INNER JOIN MatrizComercialImagen mci on mci.IdMatrizComercial = mc.IdMatrizComercial
		where 
		((@EstrategiaID = 0) OR (@EstrategiaID IS NULL) OR (e.EstrategiaID = @EstrategiaID))
		AND
		((@CUV2 = '')  OR (@CUV2 IS NULL) OR (e.CUV2 = @CUV2))
		AND
		((@CampaniaID = 0) OR (@CampaniaID IS NULL) OR (e.CampaniaID = @CampaniaID))
		AND
		((@TipoEstrategiaID = 0) OR (@TipoEstrategiaID IS NULL) OR (e.TipoEstrategiaID = @TipoEstrategiaID))
	) as T
	order by FechaRegistro desc
	OFFSET (@NumeroPagina-1)*@Registros ROWS
	FETCH NEXT @Registros ROWS ONLY;

	GO

USE BelcorpPeru
GO

ALTER PROCEDURE [dbo].[GetImagenesByEstrategiaMatrizComercialImagen]
(
	@EstrategiaID int,
	@CUV2 varchar(50),
	@TipoEstrategiaID INT = 0,
	@CampaniaID INT = 0,
	@NumeroPagina int,
	@Registros int
)
AS

SELECT 
    *,
	COUNT(*) OVER() AS TotalRegistros
	FROM
	(
		SELECT isnull(IdMatrizComercialImagen,0)IdMatrizComercialImagen,
			   mci.IdMatrizComercial,
			   isnull(mci.Foto,'') Foto,
			   mci.NemoTecnico,
			   mci.DescripcionComercial,
			   mci.FechaRegistro			   
		FROM dbo.Estrategia e
		INNER JOIN ods.productocomercial pc on e.cuv2 = pc.cuv
		INNER JOIN MatrizComercial mc ON mc.CodigoSAP = pc.CodigoProducto
		INNER JOIN ods.Campania c ON c.CampaniaID = pc.CampaniaID AND c.codigo = e.campaniaID
		INNER JOIN MatrizComercialImagen mci on mci.IdMatrizComercial = mc.IdMatrizComercial
		where 
		((@EstrategiaID = 0) OR (@EstrategiaID IS NULL) OR (e.EstrategiaID = @EstrategiaID))
		AND
		((@CUV2 = '')  OR (@CUV2 IS NULL) OR (e.CUV2 = @CUV2))
		AND
		((@CampaniaID = 0) OR (@CampaniaID IS NULL) OR (e.CampaniaID = @CampaniaID))
		AND
		((@TipoEstrategiaID = 0) OR (@TipoEstrategiaID IS NULL) OR (e.TipoEstrategiaID = @TipoEstrategiaID))
	) as T
	order by FechaRegistro desc
	OFFSET (@NumeroPagina-1)*@Registros ROWS
	FETCH NEXT @Registros ROWS ONLY;

	GO

USE BelcorpPuertoRico
GO

ALTER PROCEDURE [dbo].[GetImagenesByEstrategiaMatrizComercialImagen]
(
	@EstrategiaID int,
	@CUV2 varchar(50),
	@TipoEstrategiaID INT = 0,
	@CampaniaID INT = 0,
	@NumeroPagina int,
	@Registros int
)
AS

SELECT 
    *,
	COUNT(*) OVER() AS TotalRegistros
	FROM
	(
		SELECT isnull(IdMatrizComercialImagen,0)IdMatrizComercialImagen,
			   mci.IdMatrizComercial,
			   isnull(mci.Foto,'') Foto,
			   mci.NemoTecnico,
			   mci.DescripcionComercial,
			   mci.FechaRegistro			   
		FROM dbo.Estrategia e
		INNER JOIN ods.productocomercial pc on e.cuv2 = pc.cuv
		INNER JOIN MatrizComercial mc ON mc.CodigoSAP = pc.CodigoProducto
		INNER JOIN ods.Campania c ON c.CampaniaID = pc.CampaniaID AND c.codigo = e.campaniaID
		INNER JOIN MatrizComercialImagen mci on mci.IdMatrizComercial = mc.IdMatrizComercial
		where 
		((@EstrategiaID = 0) OR (@EstrategiaID IS NULL) OR (e.EstrategiaID = @EstrategiaID))
		AND
		((@CUV2 = '')  OR (@CUV2 IS NULL) OR (e.CUV2 = @CUV2))
		AND
		((@CampaniaID = 0) OR (@CampaniaID IS NULL) OR (e.CampaniaID = @CampaniaID))
		AND
		((@TipoEstrategiaID = 0) OR (@TipoEstrategiaID IS NULL) OR (e.TipoEstrategiaID = @TipoEstrategiaID))
	) as T
	order by FechaRegistro desc
	OFFSET (@NumeroPagina-1)*@Registros ROWS
	FETCH NEXT @Registros ROWS ONLY;

	GO

USE BelcorpSalvador
GO

ALTER PROCEDURE [dbo].[GetImagenesByEstrategiaMatrizComercialImagen]
(
	@EstrategiaID int,
	@CUV2 varchar(50),
	@TipoEstrategiaID INT = 0,
	@CampaniaID INT = 0,
	@NumeroPagina int,
	@Registros int
)
AS

SELECT 
    *,
	COUNT(*) OVER() AS TotalRegistros
	FROM
	(
		SELECT isnull(IdMatrizComercialImagen,0)IdMatrizComercialImagen,
			   mci.IdMatrizComercial,
			   isnull(mci.Foto,'') Foto,
			   mci.NemoTecnico,
			   mci.DescripcionComercial,
			   mci.FechaRegistro			   
		FROM dbo.Estrategia e
		INNER JOIN ods.productocomercial pc on e.cuv2 = pc.cuv
		INNER JOIN MatrizComercial mc ON mc.CodigoSAP = pc.CodigoProducto
		INNER JOIN ods.Campania c ON c.CampaniaID = pc.CampaniaID AND c.codigo = e.campaniaID
		INNER JOIN MatrizComercialImagen mci on mci.IdMatrizComercial = mc.IdMatrizComercial
		where 
		((@EstrategiaID = 0) OR (@EstrategiaID IS NULL) OR (e.EstrategiaID = @EstrategiaID))
		AND
		((@CUV2 = '')  OR (@CUV2 IS NULL) OR (e.CUV2 = @CUV2))
		AND
		((@CampaniaID = 0) OR (@CampaniaID IS NULL) OR (e.CampaniaID = @CampaniaID))
		AND
		((@TipoEstrategiaID = 0) OR (@TipoEstrategiaID IS NULL) OR (e.TipoEstrategiaID = @TipoEstrategiaID))
	) as T
	order by FechaRegistro desc
	OFFSET (@NumeroPagina-1)*@Registros ROWS
	FETCH NEXT @Registros ROWS ONLY;

	GO

USE BelcorpVenezuela
GO

ALTER PROCEDURE [dbo].[GetImagenesByEstrategiaMatrizComercialImagen]
(
	@EstrategiaID int,
	@CUV2 varchar(50),
	@TipoEstrategiaID INT = 0,
	@CampaniaID INT = 0,
	@NumeroPagina int,
	@Registros int
)
AS

SELECT 
    *,
	COUNT(*) OVER() AS TotalRegistros
	FROM
	(
		SELECT isnull(IdMatrizComercialImagen,0)IdMatrizComercialImagen,
			   mci.IdMatrizComercial,
			   isnull(mci.Foto,'') Foto,
			   mci.NemoTecnico,
			   mci.DescripcionComercial,
			   mci.FechaRegistro			   
		FROM dbo.Estrategia e
		INNER JOIN ods.productocomercial pc on e.cuv2 = pc.cuv
		INNER JOIN MatrizComercial mc ON mc.CodigoSAP = pc.CodigoProducto
		INNER JOIN ods.Campania c ON c.CampaniaID = pc.CampaniaID AND c.codigo = e.campaniaID
		INNER JOIN MatrizComercialImagen mci on mci.IdMatrizComercial = mc.IdMatrizComercial
		where 
		((@EstrategiaID = 0) OR (@EstrategiaID IS NULL) OR (e.EstrategiaID = @EstrategiaID))
		AND
		((@CUV2 = '')  OR (@CUV2 IS NULL) OR (e.CUV2 = @CUV2))
		AND
		((@CampaniaID = 0) OR (@CampaniaID IS NULL) OR (e.CampaniaID = @CampaniaID))
		AND
		((@TipoEstrategiaID = 0) OR (@TipoEstrategiaID IS NULL) OR (e.TipoEstrategiaID = @TipoEstrategiaID))
	) as T
	order by FechaRegistro desc
	OFFSET (@NumeroPagina-1)*@Registros ROWS
	FETCH NEXT @Registros ROWS ONLY;

	GO






