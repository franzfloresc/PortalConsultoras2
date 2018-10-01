---------------------------------------------------------
-- PARA TODOS LOS PAISES (AGREGO @TipoEstrategia)
---------------------------------------------------------

USE BelcorpPeru
GO

ALTER PROCEDURE dbo.GetOfertasParaTiByTipoConfigurado
@CampaniaID int,
@TipoConfigurado int,
@TipoEstrategia int = 4
AS
BEGIN
	DECLARE @tablaResultado TABLE (
		Id int identity(1,1),
		CUV2 varchar(5), 
		DescripcionCUV2 varchar(250),
		Precio2 decimal(18,2),
		CodigoProducto varchar(20),
		OfertaUltimoMinuto int,
		LimiteVenta int
	)

	DECLARE @tablaCuvsOPT TABLE (CampaniaID int, CUV varchar(5), OfertaUltimoMinuto int, LimiteVenta int)
	DECLARE @EstrategiaCodigo VARCHAR(5)
	SET @EstrategiaCodigo = CASE @TipoEstrategia 
		WHEN 4 THEN 'OPT'
		WHEN 7 THEN 'ODD'
		WHEN 9 THEN 'LAN'
		WHEN 10 THEN 'OPM'
		WHEN 11 THEN 'PAD'
		ELSE 'OPT'
	END
	INSERT INTO @tablaCuvsOPT
		SELECT @CampaniaID, CUV, ISNULL(MAX(FlagUltMinuto),0), ISNULL(MAX(LimUnidades),99)
		FROM ods.OfertasPersonalizadas WHERE AnioCampanaVenta = @CampaniaID and TipoPersonalizacion= @EstrategiaCodigo
		GROUP BY CUV

	IF @TipoConfigurado=0
	BEGIN
		INSERT INTO @tablaResultado
		SELECT 
			t.CUV,
			COALESCE(e.DescripcionCUV2,pd.Descripcion,p.Descripcion),
			COALESCE(e.Precio2,p.PrecioUnitario),
			p.CodigoProducto,
			t.OfertaUltimoMinuto,
			t.LimiteVenta
		FROM @tablaCuvsOPT t
		INNER JOIN ods.ProductoComercial p on
			t.CampaniaID = p.AnoCampania
			and t.CUV = p.CUV
		LEFT JOIN Estrategia e on
			t.CampaniaID = e.CampaniaID
			and t.CUV = e.CUV2
		LEFT JOIN dbo.ProductoDescripcion pd on
				p.AnoCampania = pd.CampaniaID
				and p.CUV = pd.CUV
		WHERE 
			p.AnoCampania = @CampaniaID

		INSERT INTO @tablaResultado
		SELECT
			CUV,'',0,'',0,0
		FROM @tablaCuvsOPT WHERE CUV not in (
			SELECT CUV FROM ods.ProductoComercial WHERE AnoCampania = @CampaniaID
		)
	end

	else IF @TipoConfigurado = 1
	BEGIN
		INSERT INTO @tablaResultado
		SELECT
			t.CUV,
			COALESCE(e.DescripcionCUV2,pd.Descripcion,p.Descripcion),
			COALESCE(e.Precio2,p.PrecioUnitario),
			p.CodigoProducto,
			t.OfertaUltimoMinuto,
			t.LimiteVenta
		FROM @tablaCuvsOPT t
		INNER JOIN ods.ProductoComercial p on
			t.CampaniaID = p.AnoCampania
			and t.CUV = p.CUV
		INNER JOIN Estrategia e on
			t.CampaniaID = e.CampaniaID
			and t.CUV = e.CUV2
		LEFT JOIN dbo.ProductoDescripcion pd on
			p.AnoCampania = pd.CampaniaID
			and p.CUV = pd.CUV
		WHERE e.CampaniaID = @CampaniaID
	end

	else
	BEGIN
		INSERT INTO @tablaResultado
		SELECT
			t.CUV,
			COALESCE(e.DescripcionCUV2,pd.Descripcion,p.Descripcion),
			COALESCE(e.Precio2,p.PrecioUnitario),
			p.CodigoProducto,
			t.OfertaUltimoMinuto,
			t.LimiteVenta
		FROM @tablaCuvsOPT t
		INNER JOIN ods.ProductoComercial p on
			t.CampaniaID = p.AnoCampania
			and t.CUV = p.CUV
		LEFT JOIN Estrategia e on
			t.CampaniaID = e.CampaniaID
			and t.CUV = e.CUV2
		LEFT JOIN dbo.ProductoDescripcion pd on
			p.AnoCampania = pd.CampaniaID
			and p.CUV = pd.CUV
		WHERE 
			t.CampaniaID = @CampaniaID
			and e.CUV2 is null

		INSERT INTO @tablaResultado
		SELECT
			CUV,'',0,'',0,0
		FROM @tablaCuvsOPT WHERE CUV not in (
			SELECT CUV FROM ods.ProductoComercial WHERE AnoCampania = @CampaniaID
		)
	end

	SELECT * FROM @tablaResultado WHERE Id in (
		SELECT min(id) FROM @tablaResultado
		group by CUV2
	)
END
GO

USE BelcorpMexico
GO

ALTER PROCEDURE dbo.GetOfertasParaTiByTipoConfigurado
@CampaniaID int,
@TipoConfigurado int,
@TipoEstrategia int = 4
AS
BEGIN
	DECLARE @tablaResultado TABLE (
		Id int identity(1,1),
		CUV2 varchar(5), 
		DescripcionCUV2 varchar(250),
		Precio2 decimal(18,2),
		CodigoProducto varchar(20),
		OfertaUltimoMinuto int,
		LimiteVenta int
	)

	DECLARE @tablaCuvsOPT TABLE (CampaniaID int, CUV varchar(5), OfertaUltimoMinuto int, LimiteVenta int)
	DECLARE @EstrategiaCodigo VARCHAR(5)
	SET @EstrategiaCodigo = CASE @TipoEstrategia 
		WHEN 4 THEN 'OPT'
		WHEN 7 THEN 'ODD'
		WHEN 9 THEN 'LAN'
		WHEN 10 THEN 'OPM'
		WHEN 11 THEN 'PAD'
		ELSE 'OPT'
	END
	INSERT INTO @tablaCuvsOPT
		SELECT @CampaniaID, CUV, ISNULL(MAX(FlagUltMinuto),0), ISNULL(MAX(LimUnidades),99)
		FROM ods.OfertasPersonalizadas WHERE AnioCampanaVenta = @CampaniaID and TipoPersonalizacion= @EstrategiaCodigo
		GROUP BY CUV

	IF @TipoConfigurado=0
	BEGIN
		INSERT INTO @tablaResultado
		SELECT 
			t.CUV,
			COALESCE(e.DescripcionCUV2,pd.Descripcion,p.Descripcion),
			COALESCE(e.Precio2,p.PrecioUnitario),
			p.CodigoProducto,
			t.OfertaUltimoMinuto,
			t.LimiteVenta
		FROM @tablaCuvsOPT t
		INNER JOIN ods.ProductoComercial p on
			t.CampaniaID = p.AnoCampania
			and t.CUV = p.CUV
		LEFT JOIN Estrategia e on
			t.CampaniaID = e.CampaniaID
			and t.CUV = e.CUV2
		LEFT JOIN dbo.ProductoDescripcion pd on
				p.AnoCampania = pd.CampaniaID
				and p.CUV = pd.CUV
		WHERE 
			p.AnoCampania = @CampaniaID

		INSERT INTO @tablaResultado
		SELECT
			CUV,'',0,'',0,0
		FROM @tablaCuvsOPT WHERE CUV not in (
			SELECT CUV FROM ods.ProductoComercial WHERE AnoCampania = @CampaniaID
		)
	end

	else IF @TipoConfigurado = 1
	BEGIN
		INSERT INTO @tablaResultado
		SELECT
			t.CUV,
			COALESCE(e.DescripcionCUV2,pd.Descripcion,p.Descripcion),
			COALESCE(e.Precio2,p.PrecioUnitario),
			p.CodigoProducto,
			t.OfertaUltimoMinuto,
			t.LimiteVenta
		FROM @tablaCuvsOPT t
		INNER JOIN ods.ProductoComercial p on
			t.CampaniaID = p.AnoCampania
			and t.CUV = p.CUV
		INNER JOIN Estrategia e on
			t.CampaniaID = e.CampaniaID
			and t.CUV = e.CUV2
		LEFT JOIN dbo.ProductoDescripcion pd on
			p.AnoCampania = pd.CampaniaID
			and p.CUV = pd.CUV
		WHERE e.CampaniaID = @CampaniaID
	end

	else
	BEGIN
		INSERT INTO @tablaResultado
		SELECT
			t.CUV,
			COALESCE(e.DescripcionCUV2,pd.Descripcion,p.Descripcion),
			COALESCE(e.Precio2,p.PrecioUnitario),
			p.CodigoProducto,
			t.OfertaUltimoMinuto,
			t.LimiteVenta
		FROM @tablaCuvsOPT t
		INNER JOIN ods.ProductoComercial p on
			t.CampaniaID = p.AnoCampania
			and t.CUV = p.CUV
		LEFT JOIN Estrategia e on
			t.CampaniaID = e.CampaniaID
			and t.CUV = e.CUV2
		LEFT JOIN dbo.ProductoDescripcion pd on
			p.AnoCampania = pd.CampaniaID
			and p.CUV = pd.CUV
		WHERE 
			t.CampaniaID = @CampaniaID
			and e.CUV2 is null

		INSERT INTO @tablaResultado
		SELECT
			CUV,'',0,'',0,0
		FROM @tablaCuvsOPT WHERE CUV not in (
			SELECT CUV FROM ods.ProductoComercial WHERE AnoCampania = @CampaniaID
		)
	end

	SELECT * FROM @tablaResultado WHERE Id in (
		SELECT min(id) FROM @tablaResultado
		group by CUV2
	)
END
GO

USE BelcorpColombia
GO

ALTER PROCEDURE dbo.GetOfertasParaTiByTipoConfigurado
@CampaniaID int,
@TipoConfigurado int,
@TipoEstrategia int = 4
AS
BEGIN
	DECLARE @tablaResultado TABLE (
		Id int identity(1,1),
		CUV2 varchar(5), 
		DescripcionCUV2 varchar(250),
		Precio2 decimal(18,2),
		CodigoProducto varchar(20),
		OfertaUltimoMinuto int,
		LimiteVenta int
	)

	DECLARE @tablaCuvsOPT TABLE (CampaniaID int, CUV varchar(5), OfertaUltimoMinuto int, LimiteVenta int)
	DECLARE @EstrategiaCodigo VARCHAR(5)
	SET @EstrategiaCodigo = CASE @TipoEstrategia 
		WHEN 4 THEN 'OPT'
		WHEN 7 THEN 'ODD'
		WHEN 9 THEN 'LAN'
		WHEN 10 THEN 'OPM'
		WHEN 11 THEN 'PAD'
		ELSE 'OPT'
	END
	INSERT INTO @tablaCuvsOPT
		SELECT @CampaniaID, CUV, ISNULL(MAX(FlagUltMinuto),0), ISNULL(MAX(LimUnidades),99)
		FROM ods.OfertasPersonalizadas WHERE AnioCampanaVenta = @CampaniaID and TipoPersonalizacion= @EstrategiaCodigo
		GROUP BY CUV

	IF @TipoConfigurado=0
	BEGIN
		INSERT INTO @tablaResultado
		SELECT 
			t.CUV,
			COALESCE(e.DescripcionCUV2,pd.Descripcion,p.Descripcion),
			COALESCE(e.Precio2,p.PrecioUnitario),
			p.CodigoProducto,
			t.OfertaUltimoMinuto,
			t.LimiteVenta
		FROM @tablaCuvsOPT t
		INNER JOIN ods.ProductoComercial p on
			t.CampaniaID = p.AnoCampania
			and t.CUV = p.CUV
		LEFT JOIN Estrategia e on
			t.CampaniaID = e.CampaniaID
			and t.CUV = e.CUV2
		LEFT JOIN dbo.ProductoDescripcion pd on
				p.AnoCampania = pd.CampaniaID
				and p.CUV = pd.CUV
		WHERE 
			p.AnoCampania = @CampaniaID

		INSERT INTO @tablaResultado
		SELECT
			CUV,'',0,'',0,0
		FROM @tablaCuvsOPT WHERE CUV not in (
			SELECT CUV FROM ods.ProductoComercial WHERE AnoCampania = @CampaniaID
		)
	end

	else IF @TipoConfigurado = 1
	BEGIN
		INSERT INTO @tablaResultado
		SELECT
			t.CUV,
			COALESCE(e.DescripcionCUV2,pd.Descripcion,p.Descripcion),
			COALESCE(e.Precio2,p.PrecioUnitario),
			p.CodigoProducto,
			t.OfertaUltimoMinuto,
			t.LimiteVenta
		FROM @tablaCuvsOPT t
		INNER JOIN ods.ProductoComercial p on
			t.CampaniaID = p.AnoCampania
			and t.CUV = p.CUV
		INNER JOIN Estrategia e on
			t.CampaniaID = e.CampaniaID
			and t.CUV = e.CUV2
		LEFT JOIN dbo.ProductoDescripcion pd on
			p.AnoCampania = pd.CampaniaID
			and p.CUV = pd.CUV
		WHERE e.CampaniaID = @CampaniaID
	end

	else
	BEGIN
		INSERT INTO @tablaResultado
		SELECT
			t.CUV,
			COALESCE(e.DescripcionCUV2,pd.Descripcion,p.Descripcion),
			COALESCE(e.Precio2,p.PrecioUnitario),
			p.CodigoProducto,
			t.OfertaUltimoMinuto,
			t.LimiteVenta
		FROM @tablaCuvsOPT t
		INNER JOIN ods.ProductoComercial p on
			t.CampaniaID = p.AnoCampania
			and t.CUV = p.CUV
		LEFT JOIN Estrategia e on
			t.CampaniaID = e.CampaniaID
			and t.CUV = e.CUV2
		LEFT JOIN dbo.ProductoDescripcion pd on
			p.AnoCampania = pd.CampaniaID
			and p.CUV = pd.CUV
		WHERE 
			t.CampaniaID = @CampaniaID
			and e.CUV2 is null

		INSERT INTO @tablaResultado
		SELECT
			CUV,'',0,'',0,0
		FROM @tablaCuvsOPT WHERE CUV not in (
			SELECT CUV FROM ods.ProductoComercial WHERE AnoCampania = @CampaniaID
		)
	end

	SELECT * FROM @tablaResultado WHERE Id in (
		SELECT min(id) FROM @tablaResultado
		group by CUV2
	)
END
GO

USE BelcorpVenezuela
GO

ALTER PROCEDURE dbo.GetOfertasParaTiByTipoConfigurado
@CampaniaID int,
@TipoConfigurado int,
@TipoEstrategia int = 4
AS
BEGIN
	DECLARE @tablaResultado TABLE (
		Id int identity(1,1),
		CUV2 varchar(5), 
		DescripcionCUV2 varchar(250),
		Precio2 decimal(18,2),
		CodigoProducto varchar(20),
		OfertaUltimoMinuto int,
		LimiteVenta int
	)

	DECLARE @tablaCuvsOPT TABLE (CampaniaID int, CUV varchar(5), OfertaUltimoMinuto int, LimiteVenta int)
	DECLARE @EstrategiaCodigo VARCHAR(5)
	SET @EstrategiaCodigo = CASE @TipoEstrategia 
		WHEN 4 THEN 'OPT'
		WHEN 7 THEN 'ODD'
		WHEN 9 THEN 'LAN'
		WHEN 10 THEN 'OPM'
		WHEN 11 THEN 'PAD'
		ELSE 'OPT'
	END
	INSERT INTO @tablaCuvsOPT
		SELECT @CampaniaID, CUV, ISNULL(MAX(FlagUltMinuto),0), ISNULL(MAX(LimUnidades),99)
		FROM ods.OfertasPersonalizadas WHERE AnioCampanaVenta = @CampaniaID and TipoPersonalizacion= @EstrategiaCodigo
		GROUP BY CUV

	IF @TipoConfigurado=0
	BEGIN
		INSERT INTO @tablaResultado
		SELECT 
			t.CUV,
			COALESCE(e.DescripcionCUV2,pd.Descripcion,p.Descripcion),
			COALESCE(e.Precio2,p.PrecioUnitario),
			p.CodigoProducto,
			t.OfertaUltimoMinuto,
			t.LimiteVenta
		FROM @tablaCuvsOPT t
		INNER JOIN ods.ProductoComercial p on
			t.CampaniaID = p.AnoCampania
			and t.CUV = p.CUV
		LEFT JOIN Estrategia e on
			t.CampaniaID = e.CampaniaID
			and t.CUV = e.CUV2
		LEFT JOIN dbo.ProductoDescripcion pd on
				p.AnoCampania = pd.CampaniaID
				and p.CUV = pd.CUV
		WHERE 
			p.AnoCampania = @CampaniaID

		INSERT INTO @tablaResultado
		SELECT
			CUV,'',0,'',0,0
		FROM @tablaCuvsOPT WHERE CUV not in (
			SELECT CUV FROM ods.ProductoComercial WHERE AnoCampania = @CampaniaID
		)
	end

	else IF @TipoConfigurado = 1
	BEGIN
		INSERT INTO @tablaResultado
		SELECT
			t.CUV,
			COALESCE(e.DescripcionCUV2,pd.Descripcion,p.Descripcion),
			COALESCE(e.Precio2,p.PrecioUnitario),
			p.CodigoProducto,
			t.OfertaUltimoMinuto,
			t.LimiteVenta
		FROM @tablaCuvsOPT t
		INNER JOIN ods.ProductoComercial p on
			t.CampaniaID = p.AnoCampania
			and t.CUV = p.CUV
		INNER JOIN Estrategia e on
			t.CampaniaID = e.CampaniaID
			and t.CUV = e.CUV2
		LEFT JOIN dbo.ProductoDescripcion pd on
			p.AnoCampania = pd.CampaniaID
			and p.CUV = pd.CUV
		WHERE e.CampaniaID = @CampaniaID
	end

	else
	BEGIN
		INSERT INTO @tablaResultado
		SELECT
			t.CUV,
			COALESCE(e.DescripcionCUV2,pd.Descripcion,p.Descripcion),
			COALESCE(e.Precio2,p.PrecioUnitario),
			p.CodigoProducto,
			t.OfertaUltimoMinuto,
			t.LimiteVenta
		FROM @tablaCuvsOPT t
		INNER JOIN ods.ProductoComercial p on
			t.CampaniaID = p.AnoCampania
			and t.CUV = p.CUV
		LEFT JOIN Estrategia e on
			t.CampaniaID = e.CampaniaID
			and t.CUV = e.CUV2
		LEFT JOIN dbo.ProductoDescripcion pd on
			p.AnoCampania = pd.CampaniaID
			and p.CUV = pd.CUV
		WHERE 
			t.CampaniaID = @CampaniaID
			and e.CUV2 is null

		INSERT INTO @tablaResultado
		SELECT
			CUV,'',0,'',0,0
		FROM @tablaCuvsOPT WHERE CUV not in (
			SELECT CUV FROM ods.ProductoComercial WHERE AnoCampania = @CampaniaID
		)
	end

	SELECT * FROM @tablaResultado WHERE Id in (
		SELECT min(id) FROM @tablaResultado
		group by CUV2
	)
END
GO

USE BelcorpSalvador
GO

ALTER PROCEDURE dbo.GetOfertasParaTiByTipoConfigurado
@CampaniaID int,
@TipoConfigurado int,
@TipoEstrategia int = 4
AS
BEGIN
	DECLARE @tablaResultado TABLE (
		Id int identity(1,1),
		CUV2 varchar(5), 
		DescripcionCUV2 varchar(250),
		Precio2 decimal(18,2),
		CodigoProducto varchar(20),
		OfertaUltimoMinuto int,
		LimiteVenta int
	)

	DECLARE @tablaCuvsOPT TABLE (CampaniaID int, CUV varchar(5), OfertaUltimoMinuto int, LimiteVenta int)
	DECLARE @EstrategiaCodigo VARCHAR(5)
	SET @EstrategiaCodigo = CASE @TipoEstrategia 
		WHEN 4 THEN 'OPT'
		WHEN 7 THEN 'ODD'
		WHEN 9 THEN 'LAN'
		WHEN 10 THEN 'OPM'
		WHEN 11 THEN 'PAD'
		ELSE 'OPT'
	END
	INSERT INTO @tablaCuvsOPT
		SELECT @CampaniaID, CUV, ISNULL(MAX(FlagUltMinuto),0), ISNULL(MAX(LimUnidades),99)
		FROM ods.OfertasPersonalizadas WHERE AnioCampanaVenta = @CampaniaID and TipoPersonalizacion= @EstrategiaCodigo
		GROUP BY CUV

	IF @TipoConfigurado=0
	BEGIN
		INSERT INTO @tablaResultado
		SELECT 
			t.CUV,
			COALESCE(e.DescripcionCUV2,pd.Descripcion,p.Descripcion),
			COALESCE(e.Precio2,p.PrecioUnitario),
			p.CodigoProducto,
			t.OfertaUltimoMinuto,
			t.LimiteVenta
		FROM @tablaCuvsOPT t
		INNER JOIN ods.ProductoComercial p on
			t.CampaniaID = p.AnoCampania
			and t.CUV = p.CUV
		LEFT JOIN Estrategia e on
			t.CampaniaID = e.CampaniaID
			and t.CUV = e.CUV2
		LEFT JOIN dbo.ProductoDescripcion pd on
				p.AnoCampania = pd.CampaniaID
				and p.CUV = pd.CUV
		WHERE 
			p.AnoCampania = @CampaniaID

		INSERT INTO @tablaResultado
		SELECT
			CUV,'',0,'',0,0
		FROM @tablaCuvsOPT WHERE CUV not in (
			SELECT CUV FROM ods.ProductoComercial WHERE AnoCampania = @CampaniaID
		)
	end

	else IF @TipoConfigurado = 1
	BEGIN
		INSERT INTO @tablaResultado
		SELECT
			t.CUV,
			COALESCE(e.DescripcionCUV2,pd.Descripcion,p.Descripcion),
			COALESCE(e.Precio2,p.PrecioUnitario),
			p.CodigoProducto,
			t.OfertaUltimoMinuto,
			t.LimiteVenta
		FROM @tablaCuvsOPT t
		INNER JOIN ods.ProductoComercial p on
			t.CampaniaID = p.AnoCampania
			and t.CUV = p.CUV
		INNER JOIN Estrategia e on
			t.CampaniaID = e.CampaniaID
			and t.CUV = e.CUV2
		LEFT JOIN dbo.ProductoDescripcion pd on
			p.AnoCampania = pd.CampaniaID
			and p.CUV = pd.CUV
		WHERE e.CampaniaID = @CampaniaID
	end

	else
	BEGIN
		INSERT INTO @tablaResultado
		SELECT
			t.CUV,
			COALESCE(e.DescripcionCUV2,pd.Descripcion,p.Descripcion),
			COALESCE(e.Precio2,p.PrecioUnitario),
			p.CodigoProducto,
			t.OfertaUltimoMinuto,
			t.LimiteVenta
		FROM @tablaCuvsOPT t
		INNER JOIN ods.ProductoComercial p on
			t.CampaniaID = p.AnoCampania
			and t.CUV = p.CUV
		LEFT JOIN Estrategia e on
			t.CampaniaID = e.CampaniaID
			and t.CUV = e.CUV2
		LEFT JOIN dbo.ProductoDescripcion pd on
			p.AnoCampania = pd.CampaniaID
			and p.CUV = pd.CUV
		WHERE 
			t.CampaniaID = @CampaniaID
			and e.CUV2 is null

		INSERT INTO @tablaResultado
		SELECT
			CUV,'',0,'',0,0
		FROM @tablaCuvsOPT WHERE CUV not in (
			SELECT CUV FROM ods.ProductoComercial WHERE AnoCampania = @CampaniaID
		)
	end

	SELECT * FROM @tablaResultado WHERE Id in (
		SELECT min(id) FROM @tablaResultado
		group by CUV2
	)
END
GO

USE BelcorpPuertoRico
GO

ALTER PROCEDURE dbo.GetOfertasParaTiByTipoConfigurado
@CampaniaID int,
@TipoConfigurado int,
@TipoEstrategia int = 4
AS
BEGIN
	DECLARE @tablaResultado TABLE (
		Id int identity(1,1),
		CUV2 varchar(5), 
		DescripcionCUV2 varchar(250),
		Precio2 decimal(18,2),
		CodigoProducto varchar(20),
		OfertaUltimoMinuto int,
		LimiteVenta int
	)

	DECLARE @tablaCuvsOPT TABLE (CampaniaID int, CUV varchar(5), OfertaUltimoMinuto int, LimiteVenta int)
	DECLARE @EstrategiaCodigo VARCHAR(5)
	SET @EstrategiaCodigo = CASE @TipoEstrategia 
		WHEN 4 THEN 'OPT'
		WHEN 7 THEN 'ODD'
		WHEN 9 THEN 'LAN'
		WHEN 10 THEN 'OPM'
		WHEN 11 THEN 'PAD'
		ELSE 'OPT'
	END
	INSERT INTO @tablaCuvsOPT
		SELECT @CampaniaID, CUV, ISNULL(MAX(FlagUltMinuto),0), ISNULL(MAX(LimUnidades),99)
		FROM ods.OfertasPersonalizadas WHERE AnioCampanaVenta = @CampaniaID and TipoPersonalizacion= @EstrategiaCodigo
		GROUP BY CUV

	IF @TipoConfigurado=0
	BEGIN
		INSERT INTO @tablaResultado
		SELECT 
			t.CUV,
			COALESCE(e.DescripcionCUV2,pd.Descripcion,p.Descripcion),
			COALESCE(e.Precio2,p.PrecioUnitario),
			p.CodigoProducto,
			t.OfertaUltimoMinuto,
			t.LimiteVenta
		FROM @tablaCuvsOPT t
		INNER JOIN ods.ProductoComercial p on
			t.CampaniaID = p.AnoCampania
			and t.CUV = p.CUV
		LEFT JOIN Estrategia e on
			t.CampaniaID = e.CampaniaID
			and t.CUV = e.CUV2
		LEFT JOIN dbo.ProductoDescripcion pd on
				p.AnoCampania = pd.CampaniaID
				and p.CUV = pd.CUV
		WHERE 
			p.AnoCampania = @CampaniaID

		INSERT INTO @tablaResultado
		SELECT
			CUV,'',0,'',0,0
		FROM @tablaCuvsOPT WHERE CUV not in (
			SELECT CUV FROM ods.ProductoComercial WHERE AnoCampania = @CampaniaID
		)
	end

	else IF @TipoConfigurado = 1
	BEGIN
		INSERT INTO @tablaResultado
		SELECT
			t.CUV,
			COALESCE(e.DescripcionCUV2,pd.Descripcion,p.Descripcion),
			COALESCE(e.Precio2,p.PrecioUnitario),
			p.CodigoProducto,
			t.OfertaUltimoMinuto,
			t.LimiteVenta
		FROM @tablaCuvsOPT t
		INNER JOIN ods.ProductoComercial p on
			t.CampaniaID = p.AnoCampania
			and t.CUV = p.CUV
		INNER JOIN Estrategia e on
			t.CampaniaID = e.CampaniaID
			and t.CUV = e.CUV2
		LEFT JOIN dbo.ProductoDescripcion pd on
			p.AnoCampania = pd.CampaniaID
			and p.CUV = pd.CUV
		WHERE e.CampaniaID = @CampaniaID
	end

	else
	BEGIN
		INSERT INTO @tablaResultado
		SELECT
			t.CUV,
			COALESCE(e.DescripcionCUV2,pd.Descripcion,p.Descripcion),
			COALESCE(e.Precio2,p.PrecioUnitario),
			p.CodigoProducto,
			t.OfertaUltimoMinuto,
			t.LimiteVenta
		FROM @tablaCuvsOPT t
		INNER JOIN ods.ProductoComercial p on
			t.CampaniaID = p.AnoCampania
			and t.CUV = p.CUV
		LEFT JOIN Estrategia e on
			t.CampaniaID = e.CampaniaID
			and t.CUV = e.CUV2
		LEFT JOIN dbo.ProductoDescripcion pd on
			p.AnoCampania = pd.CampaniaID
			and p.CUV = pd.CUV
		WHERE 
			t.CampaniaID = @CampaniaID
			and e.CUV2 is null

		INSERT INTO @tablaResultado
		SELECT
			CUV,'',0,'',0,0
		FROM @tablaCuvsOPT WHERE CUV not in (
			SELECT CUV FROM ods.ProductoComercial WHERE AnoCampania = @CampaniaID
		)
	end

	SELECT * FROM @tablaResultado WHERE Id in (
		SELECT min(id) FROM @tablaResultado
		group by CUV2
	)
END
GO

USE BelcorpPanama
GO

ALTER PROCEDURE dbo.GetOfertasParaTiByTipoConfigurado
@CampaniaID int,
@TipoConfigurado int,
@TipoEstrategia int = 4
AS
BEGIN
	DECLARE @tablaResultado TABLE (
		Id int identity(1,1),
		CUV2 varchar(5), 
		DescripcionCUV2 varchar(250),
		Precio2 decimal(18,2),
		CodigoProducto varchar(20),
		OfertaUltimoMinuto int,
		LimiteVenta int
	)

	DECLARE @tablaCuvsOPT TABLE (CampaniaID int, CUV varchar(5), OfertaUltimoMinuto int, LimiteVenta int)
	DECLARE @EstrategiaCodigo VARCHAR(5)
	SET @EstrategiaCodigo = CASE @TipoEstrategia 
		WHEN 4 THEN 'OPT'
		WHEN 7 THEN 'ODD'
		WHEN 9 THEN 'LAN'
		WHEN 10 THEN 'OPM'
		WHEN 11 THEN 'PAD'
		ELSE 'OPT'
	END
	INSERT INTO @tablaCuvsOPT
		SELECT @CampaniaID, CUV, ISNULL(MAX(FlagUltMinuto),0), ISNULL(MAX(LimUnidades),99)
		FROM ods.OfertasPersonalizadas WHERE AnioCampanaVenta = @CampaniaID and TipoPersonalizacion= @EstrategiaCodigo
		GROUP BY CUV

	IF @TipoConfigurado=0
	BEGIN
		INSERT INTO @tablaResultado
		SELECT 
			t.CUV,
			COALESCE(e.DescripcionCUV2,pd.Descripcion,p.Descripcion),
			COALESCE(e.Precio2,p.PrecioUnitario),
			p.CodigoProducto,
			t.OfertaUltimoMinuto,
			t.LimiteVenta
		FROM @tablaCuvsOPT t
		INNER JOIN ods.ProductoComercial p on
			t.CampaniaID = p.AnoCampania
			and t.CUV = p.CUV
		LEFT JOIN Estrategia e on
			t.CampaniaID = e.CampaniaID
			and t.CUV = e.CUV2
		LEFT JOIN dbo.ProductoDescripcion pd on
				p.AnoCampania = pd.CampaniaID
				and p.CUV = pd.CUV
		WHERE 
			p.AnoCampania = @CampaniaID

		INSERT INTO @tablaResultado
		SELECT
			CUV,'',0,'',0,0
		FROM @tablaCuvsOPT WHERE CUV not in (
			SELECT CUV FROM ods.ProductoComercial WHERE AnoCampania = @CampaniaID
		)
	end

	else IF @TipoConfigurado = 1
	BEGIN
		INSERT INTO @tablaResultado
		SELECT
			t.CUV,
			COALESCE(e.DescripcionCUV2,pd.Descripcion,p.Descripcion),
			COALESCE(e.Precio2,p.PrecioUnitario),
			p.CodigoProducto,
			t.OfertaUltimoMinuto,
			t.LimiteVenta
		FROM @tablaCuvsOPT t
		INNER JOIN ods.ProductoComercial p on
			t.CampaniaID = p.AnoCampania
			and t.CUV = p.CUV
		INNER JOIN Estrategia e on
			t.CampaniaID = e.CampaniaID
			and t.CUV = e.CUV2
		LEFT JOIN dbo.ProductoDescripcion pd on
			p.AnoCampania = pd.CampaniaID
			and p.CUV = pd.CUV
		WHERE e.CampaniaID = @CampaniaID
	end

	else
	BEGIN
		INSERT INTO @tablaResultado
		SELECT
			t.CUV,
			COALESCE(e.DescripcionCUV2,pd.Descripcion,p.Descripcion),
			COALESCE(e.Precio2,p.PrecioUnitario),
			p.CodigoProducto,
			t.OfertaUltimoMinuto,
			t.LimiteVenta
		FROM @tablaCuvsOPT t
		INNER JOIN ods.ProductoComercial p on
			t.CampaniaID = p.AnoCampania
			and t.CUV = p.CUV
		LEFT JOIN Estrategia e on
			t.CampaniaID = e.CampaniaID
			and t.CUV = e.CUV2
		LEFT JOIN dbo.ProductoDescripcion pd on
			p.AnoCampania = pd.CampaniaID
			and p.CUV = pd.CUV
		WHERE 
			t.CampaniaID = @CampaniaID
			and e.CUV2 is null

		INSERT INTO @tablaResultado
		SELECT
			CUV,'',0,'',0,0
		FROM @tablaCuvsOPT WHERE CUV not in (
			SELECT CUV FROM ods.ProductoComercial WHERE AnoCampania = @CampaniaID
		)
	end

	SELECT * FROM @tablaResultado WHERE Id in (
		SELECT min(id) FROM @tablaResultado
		group by CUV2
	)
END
GO

USE BelcorpGuatemala
GO

ALTER PROCEDURE dbo.GetOfertasParaTiByTipoConfigurado
@CampaniaID int,
@TipoConfigurado int,
@TipoEstrategia int = 4
AS
BEGIN
	DECLARE @tablaResultado TABLE (
		Id int identity(1,1),
		CUV2 varchar(5), 
		DescripcionCUV2 varchar(250),
		Precio2 decimal(18,2),
		CodigoProducto varchar(20),
		OfertaUltimoMinuto int,
		LimiteVenta int
	)

	DECLARE @tablaCuvsOPT TABLE (CampaniaID int, CUV varchar(5), OfertaUltimoMinuto int, LimiteVenta int)
	DECLARE @EstrategiaCodigo VARCHAR(5)
	SET @EstrategiaCodigo = CASE @TipoEstrategia 
		WHEN 4 THEN 'OPT'
		WHEN 7 THEN 'ODD'
		WHEN 9 THEN 'LAN'
		WHEN 10 THEN 'OPM'
		WHEN 11 THEN 'PAD'
		ELSE 'OPT'
	END
	INSERT INTO @tablaCuvsOPT
		SELECT @CampaniaID, CUV, ISNULL(MAX(FlagUltMinuto),0), ISNULL(MAX(LimUnidades),99)
		FROM ods.OfertasPersonalizadas WHERE AnioCampanaVenta = @CampaniaID and TipoPersonalizacion= @EstrategiaCodigo
		GROUP BY CUV

	IF @TipoConfigurado=0
	BEGIN
		INSERT INTO @tablaResultado
		SELECT 
			t.CUV,
			COALESCE(e.DescripcionCUV2,pd.Descripcion,p.Descripcion),
			COALESCE(e.Precio2,p.PrecioUnitario),
			p.CodigoProducto,
			t.OfertaUltimoMinuto,
			t.LimiteVenta
		FROM @tablaCuvsOPT t
		INNER JOIN ods.ProductoComercial p on
			t.CampaniaID = p.AnoCampania
			and t.CUV = p.CUV
		LEFT JOIN Estrategia e on
			t.CampaniaID = e.CampaniaID
			and t.CUV = e.CUV2
		LEFT JOIN dbo.ProductoDescripcion pd on
				p.AnoCampania = pd.CampaniaID
				and p.CUV = pd.CUV
		WHERE 
			p.AnoCampania = @CampaniaID

		INSERT INTO @tablaResultado
		SELECT
			CUV,'',0,'',0,0
		FROM @tablaCuvsOPT WHERE CUV not in (
			SELECT CUV FROM ods.ProductoComercial WHERE AnoCampania = @CampaniaID
		)
	end

	else IF @TipoConfigurado = 1
	BEGIN
		INSERT INTO @tablaResultado
		SELECT
			t.CUV,
			COALESCE(e.DescripcionCUV2,pd.Descripcion,p.Descripcion),
			COALESCE(e.Precio2,p.PrecioUnitario),
			p.CodigoProducto,
			t.OfertaUltimoMinuto,
			t.LimiteVenta
		FROM @tablaCuvsOPT t
		INNER JOIN ods.ProductoComercial p on
			t.CampaniaID = p.AnoCampania
			and t.CUV = p.CUV
		INNER JOIN Estrategia e on
			t.CampaniaID = e.CampaniaID
			and t.CUV = e.CUV2
		LEFT JOIN dbo.ProductoDescripcion pd on
			p.AnoCampania = pd.CampaniaID
			and p.CUV = pd.CUV
		WHERE e.CampaniaID = @CampaniaID
	end

	else
	BEGIN
		INSERT INTO @tablaResultado
		SELECT
			t.CUV,
			COALESCE(e.DescripcionCUV2,pd.Descripcion,p.Descripcion),
			COALESCE(e.Precio2,p.PrecioUnitario),
			p.CodigoProducto,
			t.OfertaUltimoMinuto,
			t.LimiteVenta
		FROM @tablaCuvsOPT t
		INNER JOIN ods.ProductoComercial p on
			t.CampaniaID = p.AnoCampania
			and t.CUV = p.CUV
		LEFT JOIN Estrategia e on
			t.CampaniaID = e.CampaniaID
			and t.CUV = e.CUV2
		LEFT JOIN dbo.ProductoDescripcion pd on
			p.AnoCampania = pd.CampaniaID
			and p.CUV = pd.CUV
		WHERE 
			t.CampaniaID = @CampaniaID
			and e.CUV2 is null

		INSERT INTO @tablaResultado
		SELECT
			CUV,'',0,'',0,0
		FROM @tablaCuvsOPT WHERE CUV not in (
			SELECT CUV FROM ods.ProductoComercial WHERE AnoCampania = @CampaniaID
		)
	end

	SELECT * FROM @tablaResultado WHERE Id in (
		SELECT min(id) FROM @tablaResultado
		group by CUV2
	)
END
GO

USE BelcorpEcuador
GO

ALTER PROCEDURE dbo.GetOfertasParaTiByTipoConfigurado
@CampaniaID int,
@TipoConfigurado int,
@TipoEstrategia int = 4
AS
BEGIN
	DECLARE @tablaResultado TABLE (
		Id int identity(1,1),
		CUV2 varchar(5), 
		DescripcionCUV2 varchar(250),
		Precio2 decimal(18,2),
		CodigoProducto varchar(20),
		OfertaUltimoMinuto int,
		LimiteVenta int
	)

	DECLARE @tablaCuvsOPT TABLE (CampaniaID int, CUV varchar(5), OfertaUltimoMinuto int, LimiteVenta int)
	DECLARE @EstrategiaCodigo VARCHAR(5)
	SET @EstrategiaCodigo = CASE @TipoEstrategia 
		WHEN 4 THEN 'OPT'
		WHEN 7 THEN 'ODD'
		WHEN 9 THEN 'LAN'
		WHEN 10 THEN 'OPM'
		WHEN 11 THEN 'PAD'
		ELSE 'OPT'
	END
	INSERT INTO @tablaCuvsOPT
		SELECT @CampaniaID, CUV, ISNULL(MAX(FlagUltMinuto),0), ISNULL(MAX(LimUnidades),99)
		FROM ods.OfertasPersonalizadas WHERE AnioCampanaVenta = @CampaniaID and TipoPersonalizacion= @EstrategiaCodigo
		GROUP BY CUV

	IF @TipoConfigurado=0
	BEGIN
		INSERT INTO @tablaResultado
		SELECT 
			t.CUV,
			COALESCE(e.DescripcionCUV2,pd.Descripcion,p.Descripcion),
			COALESCE(e.Precio2,p.PrecioUnitario),
			p.CodigoProducto,
			t.OfertaUltimoMinuto,
			t.LimiteVenta
		FROM @tablaCuvsOPT t
		INNER JOIN ods.ProductoComercial p on
			t.CampaniaID = p.AnoCampania
			and t.CUV = p.CUV
		LEFT JOIN Estrategia e on
			t.CampaniaID = e.CampaniaID
			and t.CUV = e.CUV2
		LEFT JOIN dbo.ProductoDescripcion pd on
				p.AnoCampania = pd.CampaniaID
				and p.CUV = pd.CUV
		WHERE 
			p.AnoCampania = @CampaniaID

		INSERT INTO @tablaResultado
		SELECT
			CUV,'',0,'',0,0
		FROM @tablaCuvsOPT WHERE CUV not in (
			SELECT CUV FROM ods.ProductoComercial WHERE AnoCampania = @CampaniaID
		)
	end

	else IF @TipoConfigurado = 1
	BEGIN
		INSERT INTO @tablaResultado
		SELECT
			t.CUV,
			COALESCE(e.DescripcionCUV2,pd.Descripcion,p.Descripcion),
			COALESCE(e.Precio2,p.PrecioUnitario),
			p.CodigoProducto,
			t.OfertaUltimoMinuto,
			t.LimiteVenta
		FROM @tablaCuvsOPT t
		INNER JOIN ods.ProductoComercial p on
			t.CampaniaID = p.AnoCampania
			and t.CUV = p.CUV
		INNER JOIN Estrategia e on
			t.CampaniaID = e.CampaniaID
			and t.CUV = e.CUV2
		LEFT JOIN dbo.ProductoDescripcion pd on
			p.AnoCampania = pd.CampaniaID
			and p.CUV = pd.CUV
		WHERE e.CampaniaID = @CampaniaID
	end

	else
	BEGIN
		INSERT INTO @tablaResultado
		SELECT
			t.CUV,
			COALESCE(e.DescripcionCUV2,pd.Descripcion,p.Descripcion),
			COALESCE(e.Precio2,p.PrecioUnitario),
			p.CodigoProducto,
			t.OfertaUltimoMinuto,
			t.LimiteVenta
		FROM @tablaCuvsOPT t
		INNER JOIN ods.ProductoComercial p on
			t.CampaniaID = p.AnoCampania
			and t.CUV = p.CUV
		LEFT JOIN Estrategia e on
			t.CampaniaID = e.CampaniaID
			and t.CUV = e.CUV2
		LEFT JOIN dbo.ProductoDescripcion pd on
			p.AnoCampania = pd.CampaniaID
			and p.CUV = pd.CUV
		WHERE 
			t.CampaniaID = @CampaniaID
			and e.CUV2 is null

		INSERT INTO @tablaResultado
		SELECT
			CUV,'',0,'',0,0
		FROM @tablaCuvsOPT WHERE CUV not in (
			SELECT CUV FROM ods.ProductoComercial WHERE AnoCampania = @CampaniaID
		)
	end

	SELECT * FROM @tablaResultado WHERE Id in (
		SELECT min(id) FROM @tablaResultado
		group by CUV2
	)
END
GO

USE BelcorpDominicana
GO

ALTER PROCEDURE dbo.GetOfertasParaTiByTipoConfigurado
@CampaniaID int,
@TipoConfigurado int,
@TipoEstrategia int = 4
AS
BEGIN
	DECLARE @tablaResultado TABLE (
		Id int identity(1,1),
		CUV2 varchar(5), 
		DescripcionCUV2 varchar(250),
		Precio2 decimal(18,2),
		CodigoProducto varchar(20),
		OfertaUltimoMinuto int,
		LimiteVenta int
	)

	DECLARE @tablaCuvsOPT TABLE (CampaniaID int, CUV varchar(5), OfertaUltimoMinuto int, LimiteVenta int)
	DECLARE @EstrategiaCodigo VARCHAR(5)
	SET @EstrategiaCodigo = CASE @TipoEstrategia 
		WHEN 4 THEN 'OPT'
		WHEN 7 THEN 'ODD'
		WHEN 9 THEN 'LAN'
		WHEN 10 THEN 'OPM'
		WHEN 11 THEN 'PAD'
		ELSE 'OPT'
	END
	INSERT INTO @tablaCuvsOPT
		SELECT @CampaniaID, CUV, ISNULL(MAX(FlagUltMinuto),0), ISNULL(MAX(LimUnidades),99)
		FROM ods.OfertasPersonalizadas WHERE AnioCampanaVenta = @CampaniaID and TipoPersonalizacion= @EstrategiaCodigo
		GROUP BY CUV

	IF @TipoConfigurado=0
	BEGIN
		INSERT INTO @tablaResultado
		SELECT 
			t.CUV,
			COALESCE(e.DescripcionCUV2,pd.Descripcion,p.Descripcion),
			COALESCE(e.Precio2,p.PrecioUnitario),
			p.CodigoProducto,
			t.OfertaUltimoMinuto,
			t.LimiteVenta
		FROM @tablaCuvsOPT t
		INNER JOIN ods.ProductoComercial p on
			t.CampaniaID = p.AnoCampania
			and t.CUV = p.CUV
		LEFT JOIN Estrategia e on
			t.CampaniaID = e.CampaniaID
			and t.CUV = e.CUV2
		LEFT JOIN dbo.ProductoDescripcion pd on
				p.AnoCampania = pd.CampaniaID
				and p.CUV = pd.CUV
		WHERE 
			p.AnoCampania = @CampaniaID

		INSERT INTO @tablaResultado
		SELECT
			CUV,'',0,'',0,0
		FROM @tablaCuvsOPT WHERE CUV not in (
			SELECT CUV FROM ods.ProductoComercial WHERE AnoCampania = @CampaniaID
		)
	end

	else IF @TipoConfigurado = 1
	BEGIN
		INSERT INTO @tablaResultado
		SELECT
			t.CUV,
			COALESCE(e.DescripcionCUV2,pd.Descripcion,p.Descripcion),
			COALESCE(e.Precio2,p.PrecioUnitario),
			p.CodigoProducto,
			t.OfertaUltimoMinuto,
			t.LimiteVenta
		FROM @tablaCuvsOPT t
		INNER JOIN ods.ProductoComercial p on
			t.CampaniaID = p.AnoCampania
			and t.CUV = p.CUV
		INNER JOIN Estrategia e on
			t.CampaniaID = e.CampaniaID
			and t.CUV = e.CUV2
		LEFT JOIN dbo.ProductoDescripcion pd on
			p.AnoCampania = pd.CampaniaID
			and p.CUV = pd.CUV
		WHERE e.CampaniaID = @CampaniaID
	end

	else
	BEGIN
		INSERT INTO @tablaResultado
		SELECT
			t.CUV,
			COALESCE(e.DescripcionCUV2,pd.Descripcion,p.Descripcion),
			COALESCE(e.Precio2,p.PrecioUnitario),
			p.CodigoProducto,
			t.OfertaUltimoMinuto,
			t.LimiteVenta
		FROM @tablaCuvsOPT t
		INNER JOIN ods.ProductoComercial p on
			t.CampaniaID = p.AnoCampania
			and t.CUV = p.CUV
		LEFT JOIN Estrategia e on
			t.CampaniaID = e.CampaniaID
			and t.CUV = e.CUV2
		LEFT JOIN dbo.ProductoDescripcion pd on
			p.AnoCampania = pd.CampaniaID
			and p.CUV = pd.CUV
		WHERE 
			t.CampaniaID = @CampaniaID
			and e.CUV2 is null

		INSERT INTO @tablaResultado
		SELECT
			CUV,'',0,'',0,0
		FROM @tablaCuvsOPT WHERE CUV not in (
			SELECT CUV FROM ods.ProductoComercial WHERE AnoCampania = @CampaniaID
		)
	end

	SELECT * FROM @tablaResultado WHERE Id in (
		SELECT min(id) FROM @tablaResultado
		group by CUV2
	)
END
GO

USE BelcorpCostaRica
GO

ALTER PROCEDURE dbo.GetOfertasParaTiByTipoConfigurado
@CampaniaID int,
@TipoConfigurado int,
@TipoEstrategia int = 4
AS
BEGIN
	DECLARE @tablaResultado TABLE (
		Id int identity(1,1),
		CUV2 varchar(5), 
		DescripcionCUV2 varchar(250),
		Precio2 decimal(18,2),
		CodigoProducto varchar(20),
		OfertaUltimoMinuto int,
		LimiteVenta int
	)

	DECLARE @tablaCuvsOPT TABLE (CampaniaID int, CUV varchar(5), OfertaUltimoMinuto int, LimiteVenta int)
	DECLARE @EstrategiaCodigo VARCHAR(5)
	SET @EstrategiaCodigo = CASE @TipoEstrategia 
		WHEN 4 THEN 'OPT'
		WHEN 7 THEN 'ODD'
		WHEN 9 THEN 'LAN'
		WHEN 10 THEN 'OPM'
		WHEN 11 THEN 'PAD'
		ELSE 'OPT'
	END
	INSERT INTO @tablaCuvsOPT
		SELECT @CampaniaID, CUV, ISNULL(MAX(FlagUltMinuto),0), ISNULL(MAX(LimUnidades),99)
		FROM ods.OfertasPersonalizadas WHERE AnioCampanaVenta = @CampaniaID and TipoPersonalizacion= @EstrategiaCodigo
		GROUP BY CUV

	IF @TipoConfigurado=0
	BEGIN
		INSERT INTO @tablaResultado
		SELECT 
			t.CUV,
			COALESCE(e.DescripcionCUV2,pd.Descripcion,p.Descripcion),
			COALESCE(e.Precio2,p.PrecioUnitario),
			p.CodigoProducto,
			t.OfertaUltimoMinuto,
			t.LimiteVenta
		FROM @tablaCuvsOPT t
		INNER JOIN ods.ProductoComercial p on
			t.CampaniaID = p.AnoCampania
			and t.CUV = p.CUV
		LEFT JOIN Estrategia e on
			t.CampaniaID = e.CampaniaID
			and t.CUV = e.CUV2
		LEFT JOIN dbo.ProductoDescripcion pd on
				p.AnoCampania = pd.CampaniaID
				and p.CUV = pd.CUV
		WHERE 
			p.AnoCampania = @CampaniaID

		INSERT INTO @tablaResultado
		SELECT
			CUV,'',0,'',0,0
		FROM @tablaCuvsOPT WHERE CUV not in (
			SELECT CUV FROM ods.ProductoComercial WHERE AnoCampania = @CampaniaID
		)
	end

	else IF @TipoConfigurado = 1
	BEGIN
		INSERT INTO @tablaResultado
		SELECT
			t.CUV,
			COALESCE(e.DescripcionCUV2,pd.Descripcion,p.Descripcion),
			COALESCE(e.Precio2,p.PrecioUnitario),
			p.CodigoProducto,
			t.OfertaUltimoMinuto,
			t.LimiteVenta
		FROM @tablaCuvsOPT t
		INNER JOIN ods.ProductoComercial p on
			t.CampaniaID = p.AnoCampania
			and t.CUV = p.CUV
		INNER JOIN Estrategia e on
			t.CampaniaID = e.CampaniaID
			and t.CUV = e.CUV2
		LEFT JOIN dbo.ProductoDescripcion pd on
			p.AnoCampania = pd.CampaniaID
			and p.CUV = pd.CUV
		WHERE e.CampaniaID = @CampaniaID
	end

	else
	BEGIN
		INSERT INTO @tablaResultado
		SELECT
			t.CUV,
			COALESCE(e.DescripcionCUV2,pd.Descripcion,p.Descripcion),
			COALESCE(e.Precio2,p.PrecioUnitario),
			p.CodigoProducto,
			t.OfertaUltimoMinuto,
			t.LimiteVenta
		FROM @tablaCuvsOPT t
		INNER JOIN ods.ProductoComercial p on
			t.CampaniaID = p.AnoCampania
			and t.CUV = p.CUV
		LEFT JOIN Estrategia e on
			t.CampaniaID = e.CampaniaID
			and t.CUV = e.CUV2
		LEFT JOIN dbo.ProductoDescripcion pd on
			p.AnoCampania = pd.CampaniaID
			and p.CUV = pd.CUV
		WHERE 
			t.CampaniaID = @CampaniaID
			and e.CUV2 is null

		INSERT INTO @tablaResultado
		SELECT
			CUV,'',0,'',0,0
		FROM @tablaCuvsOPT WHERE CUV not in (
			SELECT CUV FROM ods.ProductoComercial WHERE AnoCampania = @CampaniaID
		)
	end

	SELECT * FROM @tablaResultado WHERE Id in (
		SELECT min(id) FROM @tablaResultado
		group by CUV2
	)
END
GO

USE BelcorpChile
GO

ALTER PROCEDURE dbo.GetOfertasParaTiByTipoConfigurado
@CampaniaID int,
@TipoConfigurado int,
@TipoEstrategia int = 4
AS
BEGIN
	DECLARE @tablaResultado TABLE (
		Id int identity(1,1),
		CUV2 varchar(5), 
		DescripcionCUV2 varchar(250),
		Precio2 decimal(18,2),
		CodigoProducto varchar(20),
		OfertaUltimoMinuto int,
		LimiteVenta int
	)

	DECLARE @tablaCuvsOPT TABLE (CampaniaID int, CUV varchar(5), OfertaUltimoMinuto int, LimiteVenta int)
	DECLARE @EstrategiaCodigo VARCHAR(5)
	SET @EstrategiaCodigo = CASE @TipoEstrategia 
		WHEN 4 THEN 'OPT'
		WHEN 7 THEN 'ODD'
		WHEN 9 THEN 'LAN'
		WHEN 10 THEN 'OPM'
		WHEN 11 THEN 'PAD'
		ELSE 'OPT'
	END
	INSERT INTO @tablaCuvsOPT
		SELECT @CampaniaID, CUV, ISNULL(MAX(FlagUltMinuto),0), ISNULL(MAX(LimUnidades),99)
		FROM ods.OfertasPersonalizadas WHERE AnioCampanaVenta = @CampaniaID and TipoPersonalizacion= @EstrategiaCodigo
		GROUP BY CUV

	IF @TipoConfigurado=0
	BEGIN
		INSERT INTO @tablaResultado
		SELECT 
			t.CUV,
			COALESCE(e.DescripcionCUV2,pd.Descripcion,p.Descripcion),
			COALESCE(e.Precio2,p.PrecioUnitario),
			p.CodigoProducto,
			t.OfertaUltimoMinuto,
			t.LimiteVenta
		FROM @tablaCuvsOPT t
		INNER JOIN ods.ProductoComercial p on
			t.CampaniaID = p.AnoCampania
			and t.CUV = p.CUV
		LEFT JOIN Estrategia e on
			t.CampaniaID = e.CampaniaID
			and t.CUV = e.CUV2
		LEFT JOIN dbo.ProductoDescripcion pd on
				p.AnoCampania = pd.CampaniaID
				and p.CUV = pd.CUV
		WHERE 
			p.AnoCampania = @CampaniaID

		INSERT INTO @tablaResultado
		SELECT
			CUV,'',0,'',0,0
		FROM @tablaCuvsOPT WHERE CUV not in (
			SELECT CUV FROM ods.ProductoComercial WHERE AnoCampania = @CampaniaID
		)
	end

	else IF @TipoConfigurado = 1
	BEGIN
		INSERT INTO @tablaResultado
		SELECT
			t.CUV,
			COALESCE(e.DescripcionCUV2,pd.Descripcion,p.Descripcion),
			COALESCE(e.Precio2,p.PrecioUnitario),
			p.CodigoProducto,
			t.OfertaUltimoMinuto,
			t.LimiteVenta
		FROM @tablaCuvsOPT t
		INNER JOIN ods.ProductoComercial p on
			t.CampaniaID = p.AnoCampania
			and t.CUV = p.CUV
		INNER JOIN Estrategia e on
			t.CampaniaID = e.CampaniaID
			and t.CUV = e.CUV2
		LEFT JOIN dbo.ProductoDescripcion pd on
			p.AnoCampania = pd.CampaniaID
			and p.CUV = pd.CUV
		WHERE e.CampaniaID = @CampaniaID
	end

	else
	BEGIN
		INSERT INTO @tablaResultado
		SELECT
			t.CUV,
			COALESCE(e.DescripcionCUV2,pd.Descripcion,p.Descripcion),
			COALESCE(e.Precio2,p.PrecioUnitario),
			p.CodigoProducto,
			t.OfertaUltimoMinuto,
			t.LimiteVenta
		FROM @tablaCuvsOPT t
		INNER JOIN ods.ProductoComercial p on
			t.CampaniaID = p.AnoCampania
			and t.CUV = p.CUV
		LEFT JOIN Estrategia e on
			t.CampaniaID = e.CampaniaID
			and t.CUV = e.CUV2
		LEFT JOIN dbo.ProductoDescripcion pd on
			p.AnoCampania = pd.CampaniaID
			and p.CUV = pd.CUV
		WHERE 
			t.CampaniaID = @CampaniaID
			and e.CUV2 is null

		INSERT INTO @tablaResultado
		SELECT
			CUV,'',0,'',0,0
		FROM @tablaCuvsOPT WHERE CUV not in (
			SELECT CUV FROM ods.ProductoComercial WHERE AnoCampania = @CampaniaID
		)
	end

	SELECT * FROM @tablaResultado WHERE Id in (
		SELECT min(id) FROM @tablaResultado
		group by CUV2
	)
END
GO

USE BelcorpBolivia
GO

ALTER PROCEDURE dbo.GetOfertasParaTiByTipoConfigurado
@CampaniaID int,
@TipoConfigurado int,
@TipoEstrategia int = 4
AS
BEGIN
	DECLARE @tablaResultado TABLE (
		Id int identity(1,1),
		CUV2 varchar(5), 
		DescripcionCUV2 varchar(250),
		Precio2 decimal(18,2),
		CodigoProducto varchar(20),
		OfertaUltimoMinuto int,
		LimiteVenta int
	)

	DECLARE @tablaCuvsOPT TABLE (CampaniaID int, CUV varchar(5), OfertaUltimoMinuto int, LimiteVenta int)
	DECLARE @EstrategiaCodigo VARCHAR(5)
	SET @EstrategiaCodigo = CASE @TipoEstrategia 
		WHEN 4 THEN 'OPT'
		WHEN 7 THEN 'ODD'
		WHEN 9 THEN 'LAN'
		WHEN 10 THEN 'OPM'
		WHEN 11 THEN 'PAD'
		ELSE 'OPT'
	END
	INSERT INTO @tablaCuvsOPT
		SELECT @CampaniaID, CUV, ISNULL(MAX(FlagUltMinuto),0), ISNULL(MAX(LimUnidades),99)
		FROM ods.OfertasPersonalizadas WHERE AnioCampanaVenta = @CampaniaID and TipoPersonalizacion= @EstrategiaCodigo
		GROUP BY CUV

	IF @TipoConfigurado=0
	BEGIN
		INSERT INTO @tablaResultado
		SELECT 
			t.CUV,
			COALESCE(e.DescripcionCUV2,pd.Descripcion,p.Descripcion),
			COALESCE(e.Precio2,p.PrecioUnitario),
			p.CodigoProducto,
			t.OfertaUltimoMinuto,
			t.LimiteVenta
		FROM @tablaCuvsOPT t
		INNER JOIN ods.ProductoComercial p on
			t.CampaniaID = p.AnoCampania
			and t.CUV = p.CUV
		LEFT JOIN Estrategia e on
			t.CampaniaID = e.CampaniaID
			and t.CUV = e.CUV2
		LEFT JOIN dbo.ProductoDescripcion pd on
				p.AnoCampania = pd.CampaniaID
				and p.CUV = pd.CUV
		WHERE 
			p.AnoCampania = @CampaniaID

		INSERT INTO @tablaResultado
		SELECT
			CUV,'',0,'',0,0
		FROM @tablaCuvsOPT WHERE CUV not in (
			SELECT CUV FROM ods.ProductoComercial WHERE AnoCampania = @CampaniaID
		)
	end

	else IF @TipoConfigurado = 1
	BEGIN
		INSERT INTO @tablaResultado
		SELECT
			t.CUV,
			COALESCE(e.DescripcionCUV2,pd.Descripcion,p.Descripcion),
			COALESCE(e.Precio2,p.PrecioUnitario),
			p.CodigoProducto,
			t.OfertaUltimoMinuto,
			t.LimiteVenta
		FROM @tablaCuvsOPT t
		INNER JOIN ods.ProductoComercial p on
			t.CampaniaID = p.AnoCampania
			and t.CUV = p.CUV
		INNER JOIN Estrategia e on
			t.CampaniaID = e.CampaniaID
			and t.CUV = e.CUV2
		LEFT JOIN dbo.ProductoDescripcion pd on
			p.AnoCampania = pd.CampaniaID
			and p.CUV = pd.CUV
		WHERE e.CampaniaID = @CampaniaID
	end

	else
	BEGIN
		INSERT INTO @tablaResultado
		SELECT
			t.CUV,
			COALESCE(e.DescripcionCUV2,pd.Descripcion,p.Descripcion),
			COALESCE(e.Precio2,p.PrecioUnitario),
			p.CodigoProducto,
			t.OfertaUltimoMinuto,
			t.LimiteVenta
		FROM @tablaCuvsOPT t
		INNER JOIN ods.ProductoComercial p on
			t.CampaniaID = p.AnoCampania
			and t.CUV = p.CUV
		LEFT JOIN Estrategia e on
			t.CampaniaID = e.CampaniaID
			and t.CUV = e.CUV2
		LEFT JOIN dbo.ProductoDescripcion pd on
			p.AnoCampania = pd.CampaniaID
			and p.CUV = pd.CUV
		WHERE 
			t.CampaniaID = @CampaniaID
			and e.CUV2 is null

		INSERT INTO @tablaResultado
		SELECT
			CUV,'',0,'',0,0
		FROM @tablaCuvsOPT WHERE CUV not in (
			SELECT CUV FROM ods.ProductoComercial WHERE AnoCampania = @CampaniaID
		)
	end

	SELECT * FROM @tablaResultado WHERE Id in (
		SELECT min(id) FROM @tablaResultado
		group by CUV2
	)
END
GO

