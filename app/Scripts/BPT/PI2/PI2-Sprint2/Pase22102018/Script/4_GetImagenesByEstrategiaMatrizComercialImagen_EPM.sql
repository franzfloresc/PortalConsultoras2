GO
USE BelcorpPeru
GO

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

IF(@Registros <> -1)
BEGIN
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
END
ELSE
BEGIN
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
END
go


GO
USE BelcorpMexico
GO

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

IF(@Registros <> -1)
BEGIN
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
END
ELSE
BEGIN
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
END
go


GO
USE BelcorpColombia
GO

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

IF(@Registros <> -1)
BEGIN
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
END
ELSE
BEGIN
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
END
go


GO
USE BelcorpSalvador
GO

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

IF(@Registros <> -1)
BEGIN
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
END
ELSE
BEGIN
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
END
go


GO
USE BelcorpPuertoRico
GO

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

IF(@Registros <> -1)
BEGIN
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
END
ELSE
BEGIN
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
END
go


GO
USE BelcorpPanama
GO

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

IF(@Registros <> -1)
BEGIN
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
END
ELSE
BEGIN
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
END
go


GO
USE BelcorpGuatemala
GO

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

IF(@Registros <> -1)
BEGIN
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
END
ELSE
BEGIN
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
END
go


GO
USE BelcorpEcuador
GO

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

IF(@Registros <> -1)
BEGIN
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
END
ELSE
BEGIN
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
END
go


GO
USE BelcorpDominicana
GO

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

IF(@Registros <> -1)
BEGIN
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
END
ELSE
BEGIN
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
END
go


GO
USE BelcorpCostaRica
GO

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

IF(@Registros <> -1)
BEGIN
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
END
ELSE
BEGIN
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
END
go


GO
USE BelcorpChile
GO

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

IF(@Registros <> -1)
BEGIN
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
END
ELSE
BEGIN
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
END
go


GO
USE BelcorpBolivia
GO

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

IF(@Registros <> -1)
BEGIN
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
END
ELSE
BEGIN
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
END
go


GO
