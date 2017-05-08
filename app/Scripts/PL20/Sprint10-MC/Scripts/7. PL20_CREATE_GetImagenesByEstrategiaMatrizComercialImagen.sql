USE BelcorpBolivia
GO

IF OBJECT_ID('GetImagenesByEstrategiaMatrizComercialImagen', 'P') IS NOT NULL
DROP PROC GetImagenesByEstrategiaMatrizComercialImagen
GO

BEGIN
CREATE PROCEDURE [dbo].[GetImagenesByEstrategiaMatrizComercialImagen]
(
	@EstrategiaID int,
	@CUV2 varchar(50),
	@TipoEstrategiaID INT = 0,
	@CampaniaID INT = 0,
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

END
GO

/*end*/

USE BelcorpChile
GO

IF OBJECT_ID('GetImagenesByEstrategiaMatrizComercialImagen', 'P') IS NOT NULL
DROP PROC GetImagenesByEstrategiaMatrizComercialImagen
GO

BEGIN
CREATE PROCEDURE [dbo].[GetImagenesByEstrategiaMatrizComercialImagen]
(
	@EstrategiaID int,
	@CUV2 varchar(50),
	@TipoEstrategiaID INT = 0,
	@CampaniaID INT = 0,
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


END
GO
/*end*/

USE BelcorpColombia
GO

IF OBJECT_ID('GetImagenesByEstrategiaMatrizComercialImagen', 'P') IS NOT NULL
DROP PROC GetImagenesByEstrategiaMatrizComercialImagen
GO

BEGIN
	CREATE PROCEDURE [dbo].[GetImagenesByEstrategiaMatrizComercialImagen]
(
	@EstrategiaID int,
	@CUV2 varchar(50),
	@TipoEstrategiaID INT = 0,
	@CampaniaID INT = 0,
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

END
GO
/*end*/

USE BelcorpCostaRica
GO

IF OBJECT_ID('GetImagenesByEstrategiaMatrizComercialImagen', 'P') IS NOT NULL
DROP PROC GetImagenesByEstrategiaMatrizComercialImagen
GO

BEGIN
	CREATE PROCEDURE [dbo].[GetImagenesByEstrategiaMatrizComercialImagen]
(
	@EstrategiaID int,
	@CUV2 varchar(50),
	@TipoEstrategiaID INT = 0,
	@CampaniaID INT = 0,
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

END
GO
/*end*/

USE BelcorpDominicana
GO

IF OBJECT_ID('GetImagenesByEstrategiaMatrizComercialImagen', 'P') IS NOT NULL
DROP PROC GetImagenesByEstrategiaMatrizComercialImagen
GO

BEGIN
	CREATE PROCEDURE [dbo].[GetImagenesByEstrategiaMatrizComercialImagen]
(
	@EstrategiaID int,
	@CUV2 varchar(50),
	@TipoEstrategiaID INT = 0,
	@CampaniaID INT = 0,
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

END
GO
/*end*/

USE BelcorpEcuador
GO

IF OBJECT_ID('GetImagenesByEstrategiaMatrizComercialImagen', 'P') IS NOT NULL
DROP PROC GetImagenesByEstrategiaMatrizComercialImagen
GO

BEGIN
CREATE PROCEDURE [dbo].[GetImagenesByEstrategiaMatrizComercialImagen]
(
	@EstrategiaID int,
	@CUV2 varchar(50),
	@TipoEstrategiaID INT = 0,
	@CampaniaID INT = 0,
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
	
END
GO
/*end*/

USE BelcorpGuatemala
GO

IF OBJECT_ID('GetImagenesByEstrategiaMatrizComercialImagen', 'P') IS NOT NULL
DROP PROC GetImagenesByEstrategiaMatrizComercialImagen
GO

BEGIN
	CREATE PROCEDURE [dbo].[GetImagenesByEstrategiaMatrizComercialImagen]
(
	@EstrategiaID int,
	@CUV2 varchar(50),
	@TipoEstrategiaID INT = 0,
	@CampaniaID INT = 0,
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

END
GO
/*end*/

USE BelcorpMexico
GO

IF OBJECT_ID('GetImagenesByEstrategiaMatrizComercialImagen', 'P') IS NOT NULL
DROP PROC GetImagenesByEstrategiaMatrizComercialImagen
GO

BEGIN
CREATE PROCEDURE [dbo].[GetImagenesByEstrategiaMatrizComercialImagen]
(
	@EstrategiaID int,
	@CUV2 varchar(50),
	@TipoEstrategiaID INT = 0,
	@CampaniaID INT = 0,
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
	
END
GO
/*end*/

USE BelcorpPanama
GO

IF OBJECT_ID('GetImagenesByEstrategiaMatrizComercialImagen', 'P') IS NOT NULL
DROP PROC GetImagenesByEstrategiaMatrizComercialImagen
GO

BEGIN
	CREATE PROCEDURE [dbo].[GetImagenesByEstrategiaMatrizComercialImagen]
(
	@EstrategiaID int,
	@CUV2 varchar(50),
	@TipoEstrategiaID INT = 0,
	@CampaniaID INT = 0,
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

END
GO
/*end*/

USE BelcorpPeru
GO

IF OBJECT_ID('GetImagenesByEstrategiaMatrizComercialImagen', 'P') IS NOT NULL
DROP PROC GetImagenesByEstrategiaMatrizComercialImagen
GO

BEGIN
	CREATE PROCEDURE [dbo].[GetImagenesByEstrategiaMatrizComercialImagen]
(
	@EstrategiaID int,
	@CUV2 varchar(50),
	@TipoEstrategiaID INT = 0,
	@CampaniaID INT = 0,
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

END
GO
/*end*/

USE BelcorpPuertoRico
GO

IF OBJECT_ID('GetImagenesByEstrategiaMatrizComercialImagen', 'P') IS NOT NULL
DROP PROC GetImagenesByEstrategiaMatrizComercialImagen
GO

BEGIN
	CREATE PROCEDURE [dbo].[GetImagenesByEstrategiaMatrizComercialImagen]
(
	@EstrategiaID int,
	@CUV2 varchar(50),
	@TipoEstrategiaID INT = 0,
	@CampaniaID INT = 0,
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

END
GO
/*end*/

USE BelcorpSalvador
GO

IF OBJECT_ID('GetImagenesByEstrategiaMatrizComercialImagen', 'P') IS NOT NULL
DROP PROC GetImagenesByEstrategiaMatrizComercialImagen
GO

BEGIN
CREATE PROCEDURE [dbo].[GetImagenesByEstrategiaMatrizComercialImagen]
(
	@EstrategiaID int,
	@CUV2 varchar(50),
	@TipoEstrategiaID INT = 0,
	@CampaniaID INT = 0,
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
	
END
GO
/*end*/

USE BelcorpVenezuela
GO

IF OBJECT_ID('GetImagenesByEstrategiaMatrizComercialImagen', 'P') IS NOT NULL
DROP PROC GetImagenesByEstrategiaMatrizComercialImagen
GO

BEGIN
CREATE PROCEDURE [dbo].[GetImagenesByEstrategiaMatrizComercialImagen]
(
	@EstrategiaID int,
	@CUV2 varchar(50),
	@TipoEstrategiaID INT = 0,
	@CampaniaID INT = 0,
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

END	
END
GO











