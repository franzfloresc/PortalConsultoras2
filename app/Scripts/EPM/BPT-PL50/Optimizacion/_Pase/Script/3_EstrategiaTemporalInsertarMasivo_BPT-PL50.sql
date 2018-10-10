GO
USE BelcorpPeru
GO
GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EstrategiaTemporalInsertarMasivo') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.EstrategiaTemporalInsertarMasivo
GO

CREATE PROCEDURE EstrategiaTemporalInsertarMasivo
(
	@CampaniaID int,
	@EstrategiaCodigo varchar(5) = '',
	@Pagina int,
	@CantidadCuv int,
	@NroLote int = 0,
	@NroLoteFinal int = 0 out
)
AS
-- EstrategiaTemporalInsertarMasivo 201801, '007', 1, 200
BEGIN
	DECLARE @tablaCuvsOPT TABLE (
		CampaniaID int,
		CUV varchar(10),
		OfertaUltimoMinuto int,
		LimiteVenta int
	)

	IF (@EstrategiaCodigo = '011')
	BEGIN
		INSERT INTO @tablaCuvsOPT
			SELECT @CampaniaID, CUV, 0, 99
			FROM ods.ProductoComercial
			WHERE AnoCampania = @CampaniaID
				AND CodigoTipoOferta = '126'
				AND FactorRepeticion = 1
			GROUP BY CUV
	END
	ELSE
	BEGIN
		if	@Pagina < 1
			set @Pagina = 1

		declare @CuvDesde int = (@Pagina - 1) * @CantidadCuv + 1
		declare @CuvHasta int = @Pagina * @CantidadCuv
		--DECLARE @CampaniaIDChar CHAR(6) = convert(char(6), @CampaniaID)
		DECLARE @EstrategiaCodigoOds varchar(10)
		set @EstrategiaCodigoOds = dbo.fnGetTipoPersonalizacion(@EstrategiaCodigo)
		if @EstrategiaCodigoOds <> ''
		begin
			INSERT INTO @tablaCuvsOPT
			select @CampaniaID, m.CUV, m.OfertaUltimoMinuto, m.LimiteVenta
			from (
				SELECT ROW_NUMBER() over(order by  CUV desc) as ID,
				 CUV, ISNULL(FlagUltMinuto, 0) as OfertaUltimoMinuto,
				 ISNULL(LimUnidades, 99) as LimiteVenta
				FROM ods.OfertasPersonalizadasCUV
				WHERE AnioCampanaVenta = @CampaniaID
				AND TipoPersonalizacion = @EstrategiaCodigoOds
			) m
			where m.ID between @CuvDesde and @CuvHasta
		end

	END
	DECLARE @tablaResultado TABLE (
		Id int identity(1,1),
		CUV2 varchar(5),
		DescripcionCUV2 varchar(250),
		Precio2 decimal(18,2),
		CodigoProducto varchar(20),
		OfertaUltimoMinuto int,
		LimiteVenta int,
		ImagenURL varchar(250),
		PrecioPublico decimal(18, 2)
	)

	DECLARE @TipoEstrategiaId INT = 0
	set @TipoEstrategiaId = dbo.fnGetTipoEstrategiaId(@EstrategiaCodigo)
	INSERT INTO @tablaResultado
	SELECT
		t.CUV,
		COALESCE(mci.DescripcionComercial, e.DescripcionCUV2, pd.Descripcion, p.Descripcion),
		COALESCE(e.Precio2,p.PrecioUnitario),
		p.CodigoProducto,
		t.OfertaUltimoMinuto,
		t.LimiteVenta,
		mci.Foto,
		p.IndicadorPreUni
	FROM @tablaCuvsOPT t
		INNER JOIN ods.ProductoComercial p
			on t.CampaniaID = p.AnoCampania
			and t.CUV = p.CUV
		LEFT JOIN Estrategia e
			on t.CampaniaID = e.CampaniaID
			and t.CUV = e.CUV2
			and e.TipoEstrategiaID = @TipoEstrategiaId
		LEFT JOIN dbo.ProductoDescripcion pd
			on p.AnoCampania = pd.CampaniaID
			and p.CUV = pd.CUV
		LEFT JOIN MatrizComercial mc
			on p.CodigoProducto = mc.CodigoSAP
		LEFT JOIN MatrizComercialImagen mci
			on mci.IdMatrizComercial = mc.IdMatrizComercial
			and mci.NemoTecnico IS NOT NULL
	WHERE
		t.CampaniaID = @CampaniaID
		and e.CUV2 is null

	if @NroLote <= 0
	begin
		SELECT @NroLote = isnull(max(NumeroLote),0)
		FROM EstrategiaTemporal
		if	@NroLote < 0
			set @NroLote = 1
		else
			SET @NroLote = @NroLote + 1
	end

	declare @FechaSistema datetime = dbo.fnObtenerFechaHoraPais()
	INSERT INTO EstrategiaTemporal
	(
		CampaniaId,
		NumeroLote,
		pagina,
		CodigoTipoEstrategia,
		CUV,
		Descripcion,
		PrecioOferta,
		CodigoSap,
		OfertaUltimoMinuto,
		LimiteVenta,
		FotoProducto01,
		PrecioPublico,
		FechaCreacion
	)
	SELECT
		@CampaniaID,
		@NroLote,
		@Pagina,
		@EstrategiaCodigo,
		CUV2,
		DescripcionCUV2,
		Precio2,
		CodigoProducto,
		OfertaUltimoMinuto,
		LimiteVenta,
		ImagenURL,
		PrecioPublico,
		@FechaSistema
	FROM @tablaResultado
	WHERE Id in (
		SELECT min(id)
		FROM @tablaResultado
		group by CUV2
	)

	set @NroLoteFinal = @NroLote
END
GO

GO
USE BelcorpMexico
GO
GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EstrategiaTemporalInsertarMasivo') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.EstrategiaTemporalInsertarMasivo
GO

CREATE PROCEDURE EstrategiaTemporalInsertarMasivo
(
	@CampaniaID int,
	@EstrategiaCodigo varchar(5) = '',
	@Pagina int,
	@CantidadCuv int,
	@NroLote int = 0,
	@NroLoteFinal int = 0 out
)
AS
-- EstrategiaTemporalInsertarMasivo 201801, '007', 1, 200
BEGIN
	DECLARE @tablaCuvsOPT TABLE (
		CampaniaID int,
		CUV varchar(10),
		OfertaUltimoMinuto int,
		LimiteVenta int
	)

	IF (@EstrategiaCodigo = '011')
	BEGIN
		INSERT INTO @tablaCuvsOPT
			SELECT @CampaniaID, CUV, 0, 99
			FROM ods.ProductoComercial
			WHERE AnoCampania = @CampaniaID
				AND CodigoTipoOferta = '126'
				AND FactorRepeticion = 1
			GROUP BY CUV
	END
	ELSE
	BEGIN
		if	@Pagina < 1
			set @Pagina = 1

		declare @CuvDesde int = (@Pagina - 1) * @CantidadCuv + 1
		declare @CuvHasta int = @Pagina * @CantidadCuv
		--DECLARE @CampaniaIDChar CHAR(6) = convert(char(6), @CampaniaID)
		DECLARE @EstrategiaCodigoOds varchar(10)
		set @EstrategiaCodigoOds = dbo.fnGetTipoPersonalizacion(@EstrategiaCodigo)
		if @EstrategiaCodigoOds <> ''
		begin
			INSERT INTO @tablaCuvsOPT
			select @CampaniaID, m.CUV, m.OfertaUltimoMinuto, m.LimiteVenta
			from (
				SELECT ROW_NUMBER() over(order by  CUV desc) as ID,
				 CUV, ISNULL(FlagUltMinuto, 0) as OfertaUltimoMinuto,
				 ISNULL(LimUnidades, 99) as LimiteVenta
				FROM ods.OfertasPersonalizadasCUV
				WHERE AnioCampanaVenta = @CampaniaID
				AND TipoPersonalizacion = @EstrategiaCodigoOds
			) m
			where m.ID between @CuvDesde and @CuvHasta
		end

	END
	DECLARE @tablaResultado TABLE (
		Id int identity(1,1),
		CUV2 varchar(5),
		DescripcionCUV2 varchar(250),
		Precio2 decimal(18,2),
		CodigoProducto varchar(20),
		OfertaUltimoMinuto int,
		LimiteVenta int,
		ImagenURL varchar(250),
		PrecioPublico decimal(18, 2)
	)

	DECLARE @TipoEstrategiaId INT = 0
	set @TipoEstrategiaId = dbo.fnGetTipoEstrategiaId(@EstrategiaCodigo)
	INSERT INTO @tablaResultado
	SELECT
		t.CUV,
		COALESCE(mci.DescripcionComercial, e.DescripcionCUV2, pd.Descripcion, p.Descripcion),
		COALESCE(e.Precio2,p.PrecioUnitario),
		p.CodigoProducto,
		t.OfertaUltimoMinuto,
		t.LimiteVenta,
		mci.Foto,
		p.IndicadorPreUni
	FROM @tablaCuvsOPT t
		INNER JOIN ods.ProductoComercial p
			on t.CampaniaID = p.AnoCampania
			and t.CUV = p.CUV
		LEFT JOIN Estrategia e
			on t.CampaniaID = e.CampaniaID
			and t.CUV = e.CUV2
			and e.TipoEstrategiaID = @TipoEstrategiaId
		LEFT JOIN dbo.ProductoDescripcion pd
			on p.AnoCampania = pd.CampaniaID
			and p.CUV = pd.CUV
		LEFT JOIN MatrizComercial mc
			on p.CodigoProducto = mc.CodigoSAP
		LEFT JOIN MatrizComercialImagen mci
			on mci.IdMatrizComercial = mc.IdMatrizComercial
			and mci.NemoTecnico IS NOT NULL
	WHERE
		t.CampaniaID = @CampaniaID
		and e.CUV2 is null

	if @NroLote <= 0
	begin
		SELECT @NroLote = isnull(max(NumeroLote),0)
		FROM EstrategiaTemporal
		if	@NroLote < 0
			set @NroLote = 1
		else
			SET @NroLote = @NroLote + 1
	end

	declare @FechaSistema datetime = dbo.fnObtenerFechaHoraPais()
	INSERT INTO EstrategiaTemporal
	(
		CampaniaId,
		NumeroLote,
		pagina,
		CodigoTipoEstrategia,
		CUV,
		Descripcion,
		PrecioOferta,
		CodigoSap,
		OfertaUltimoMinuto,
		LimiteVenta,
		FotoProducto01,
		PrecioPublico,
		FechaCreacion
	)
	SELECT
		@CampaniaID,
		@NroLote,
		@Pagina,
		@EstrategiaCodigo,
		CUV2,
		DescripcionCUV2,
		Precio2,
		CodigoProducto,
		OfertaUltimoMinuto,
		LimiteVenta,
		ImagenURL,
		PrecioPublico,
		@FechaSistema
	FROM @tablaResultado
	WHERE Id in (
		SELECT min(id)
		FROM @tablaResultado
		group by CUV2
	)

	set @NroLoteFinal = @NroLote
END
GO

GO
USE BelcorpColombia
GO
GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EstrategiaTemporalInsertarMasivo') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.EstrategiaTemporalInsertarMasivo
GO

CREATE PROCEDURE EstrategiaTemporalInsertarMasivo
(
	@CampaniaID int,
	@EstrategiaCodigo varchar(5) = '',
	@Pagina int,
	@CantidadCuv int,
	@NroLote int = 0,
	@NroLoteFinal int = 0 out
)
AS
-- EstrategiaTemporalInsertarMasivo 201801, '007', 1, 200
BEGIN
	DECLARE @tablaCuvsOPT TABLE (
		CampaniaID int,
		CUV varchar(10),
		OfertaUltimoMinuto int,
		LimiteVenta int
	)

	IF (@EstrategiaCodigo = '011')
	BEGIN
		INSERT INTO @tablaCuvsOPT
			SELECT @CampaniaID, CUV, 0, 99
			FROM ods.ProductoComercial
			WHERE AnoCampania = @CampaniaID
				AND CodigoTipoOferta = '126'
				AND FactorRepeticion = 1
			GROUP BY CUV
	END
	ELSE
	BEGIN
		if	@Pagina < 1
			set @Pagina = 1

		declare @CuvDesde int = (@Pagina - 1) * @CantidadCuv + 1
		declare @CuvHasta int = @Pagina * @CantidadCuv
		--DECLARE @CampaniaIDChar CHAR(6) = convert(char(6), @CampaniaID)
		DECLARE @EstrategiaCodigoOds varchar(10)
		set @EstrategiaCodigoOds = dbo.fnGetTipoPersonalizacion(@EstrategiaCodigo)
		if @EstrategiaCodigoOds <> ''
		begin
			INSERT INTO @tablaCuvsOPT
			select @CampaniaID, m.CUV, m.OfertaUltimoMinuto, m.LimiteVenta
			from (
				SELECT ROW_NUMBER() over(order by  CUV desc) as ID,
				 CUV, ISNULL(FlagUltMinuto, 0) as OfertaUltimoMinuto,
				 ISNULL(LimUnidades, 99) as LimiteVenta
				FROM ods.OfertasPersonalizadasCUV
				WHERE AnioCampanaVenta = @CampaniaID
				AND TipoPersonalizacion = @EstrategiaCodigoOds
			) m
			where m.ID between @CuvDesde and @CuvHasta
		end

	END
	DECLARE @tablaResultado TABLE (
		Id int identity(1,1),
		CUV2 varchar(5),
		DescripcionCUV2 varchar(250),
		Precio2 decimal(18,2),
		CodigoProducto varchar(20),
		OfertaUltimoMinuto int,
		LimiteVenta int,
		ImagenURL varchar(250),
		PrecioPublico decimal(18, 2)
	)

	DECLARE @TipoEstrategiaId INT = 0
	set @TipoEstrategiaId = dbo.fnGetTipoEstrategiaId(@EstrategiaCodigo)
	INSERT INTO @tablaResultado
	SELECT
		t.CUV,
		COALESCE(mci.DescripcionComercial, e.DescripcionCUV2, pd.Descripcion, p.Descripcion),
		COALESCE(e.Precio2,p.PrecioUnitario),
		p.CodigoProducto,
		t.OfertaUltimoMinuto,
		t.LimiteVenta,
		mci.Foto,
		p.IndicadorPreUni
	FROM @tablaCuvsOPT t
		INNER JOIN ods.ProductoComercial p
			on t.CampaniaID = p.AnoCampania
			and t.CUV = p.CUV
		LEFT JOIN Estrategia e
			on t.CampaniaID = e.CampaniaID
			and t.CUV = e.CUV2
			and e.TipoEstrategiaID = @TipoEstrategiaId
		LEFT JOIN dbo.ProductoDescripcion pd
			on p.AnoCampania = pd.CampaniaID
			and p.CUV = pd.CUV
		LEFT JOIN MatrizComercial mc
			on p.CodigoProducto = mc.CodigoSAP
		LEFT JOIN MatrizComercialImagen mci
			on mci.IdMatrizComercial = mc.IdMatrizComercial
			and mci.NemoTecnico IS NOT NULL
	WHERE
		t.CampaniaID = @CampaniaID
		and e.CUV2 is null

	if @NroLote <= 0
	begin
		SELECT @NroLote = isnull(max(NumeroLote),0)
		FROM EstrategiaTemporal
		if	@NroLote < 0
			set @NroLote = 1
		else
			SET @NroLote = @NroLote + 1
	end

	declare @FechaSistema datetime = dbo.fnObtenerFechaHoraPais()
	INSERT INTO EstrategiaTemporal
	(
		CampaniaId,
		NumeroLote,
		pagina,
		CodigoTipoEstrategia,
		CUV,
		Descripcion,
		PrecioOferta,
		CodigoSap,
		OfertaUltimoMinuto,
		LimiteVenta,
		FotoProducto01,
		PrecioPublico,
		FechaCreacion
	)
	SELECT
		@CampaniaID,
		@NroLote,
		@Pagina,
		@EstrategiaCodigo,
		CUV2,
		DescripcionCUV2,
		Precio2,
		CodigoProducto,
		OfertaUltimoMinuto,
		LimiteVenta,
		ImagenURL,
		PrecioPublico,
		@FechaSistema
	FROM @tablaResultado
	WHERE Id in (
		SELECT min(id)
		FROM @tablaResultado
		group by CUV2
	)

	set @NroLoteFinal = @NroLote
END
GO

GO
USE BelcorpSalvador
GO
GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EstrategiaTemporalInsertarMasivo') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.EstrategiaTemporalInsertarMasivo
GO

CREATE PROCEDURE EstrategiaTemporalInsertarMasivo
(
	@CampaniaID int,
	@EstrategiaCodigo varchar(5) = '',
	@Pagina int,
	@CantidadCuv int,
	@NroLote int = 0,
	@NroLoteFinal int = 0 out
)
AS
-- EstrategiaTemporalInsertarMasivo 201801, '007', 1, 200
BEGIN
	DECLARE @tablaCuvsOPT TABLE (
		CampaniaID int,
		CUV varchar(10),
		OfertaUltimoMinuto int,
		LimiteVenta int
	)

	IF (@EstrategiaCodigo = '011')
	BEGIN
		INSERT INTO @tablaCuvsOPT
			SELECT @CampaniaID, CUV, 0, 99
			FROM ods.ProductoComercial
			WHERE AnoCampania = @CampaniaID
				AND CodigoTipoOferta = '126'
				AND FactorRepeticion = 1
			GROUP BY CUV
	END
	ELSE
	BEGIN
		if	@Pagina < 1
			set @Pagina = 1

		declare @CuvDesde int = (@Pagina - 1) * @CantidadCuv + 1
		declare @CuvHasta int = @Pagina * @CantidadCuv
		--DECLARE @CampaniaIDChar CHAR(6) = convert(char(6), @CampaniaID)
		DECLARE @EstrategiaCodigoOds varchar(10)
		set @EstrategiaCodigoOds = dbo.fnGetTipoPersonalizacion(@EstrategiaCodigo)
		if @EstrategiaCodigoOds <> ''
		begin
			INSERT INTO @tablaCuvsOPT
			select @CampaniaID, m.CUV, m.OfertaUltimoMinuto, m.LimiteVenta
			from (
				SELECT ROW_NUMBER() over(order by  CUV desc) as ID,
				 CUV, ISNULL(FlagUltMinuto, 0) as OfertaUltimoMinuto,
				 ISNULL(LimUnidades, 99) as LimiteVenta
				FROM ods.OfertasPersonalizadasCUV
				WHERE AnioCampanaVenta = @CampaniaID
				AND TipoPersonalizacion = @EstrategiaCodigoOds
			) m
			where m.ID between @CuvDesde and @CuvHasta
		end

	END
	DECLARE @tablaResultado TABLE (
		Id int identity(1,1),
		CUV2 varchar(5),
		DescripcionCUV2 varchar(250),
		Precio2 decimal(18,2),
		CodigoProducto varchar(20),
		OfertaUltimoMinuto int,
		LimiteVenta int,
		ImagenURL varchar(250),
		PrecioPublico decimal(18, 2)
	)

	DECLARE @TipoEstrategiaId INT = 0
	set @TipoEstrategiaId = dbo.fnGetTipoEstrategiaId(@EstrategiaCodigo)
	INSERT INTO @tablaResultado
	SELECT
		t.CUV,
		COALESCE(mci.DescripcionComercial, e.DescripcionCUV2, pd.Descripcion, p.Descripcion),
		COALESCE(e.Precio2,p.PrecioUnitario),
		p.CodigoProducto,
		t.OfertaUltimoMinuto,
		t.LimiteVenta,
		mci.Foto,
		p.IndicadorPreUni
	FROM @tablaCuvsOPT t
		INNER JOIN ods.ProductoComercial p
			on t.CampaniaID = p.AnoCampania
			and t.CUV = p.CUV
		LEFT JOIN Estrategia e
			on t.CampaniaID = e.CampaniaID
			and t.CUV = e.CUV2
			and e.TipoEstrategiaID = @TipoEstrategiaId
		LEFT JOIN dbo.ProductoDescripcion pd
			on p.AnoCampania = pd.CampaniaID
			and p.CUV = pd.CUV
		LEFT JOIN MatrizComercial mc
			on p.CodigoProducto = mc.CodigoSAP
		LEFT JOIN MatrizComercialImagen mci
			on mci.IdMatrizComercial = mc.IdMatrizComercial
			and mci.NemoTecnico IS NOT NULL
	WHERE
		t.CampaniaID = @CampaniaID
		and e.CUV2 is null

	if @NroLote <= 0
	begin
		SELECT @NroLote = isnull(max(NumeroLote),0)
		FROM EstrategiaTemporal
		if	@NroLote < 0
			set @NroLote = 1
		else
			SET @NroLote = @NroLote + 1
	end

	declare @FechaSistema datetime = dbo.fnObtenerFechaHoraPais()
	INSERT INTO EstrategiaTemporal
	(
		CampaniaId,
		NumeroLote,
		pagina,
		CodigoTipoEstrategia,
		CUV,
		Descripcion,
		PrecioOferta,
		CodigoSap,
		OfertaUltimoMinuto,
		LimiteVenta,
		FotoProducto01,
		PrecioPublico,
		FechaCreacion
	)
	SELECT
		@CampaniaID,
		@NroLote,
		@Pagina,
		@EstrategiaCodigo,
		CUV2,
		DescripcionCUV2,
		Precio2,
		CodigoProducto,
		OfertaUltimoMinuto,
		LimiteVenta,
		ImagenURL,
		PrecioPublico,
		@FechaSistema
	FROM @tablaResultado
	WHERE Id in (
		SELECT min(id)
		FROM @tablaResultado
		group by CUV2
	)

	set @NroLoteFinal = @NroLote
END
GO

GO
USE BelcorpPuertoRico
GO
GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EstrategiaTemporalInsertarMasivo') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.EstrategiaTemporalInsertarMasivo
GO

CREATE PROCEDURE EstrategiaTemporalInsertarMasivo
(
	@CampaniaID int,
	@EstrategiaCodigo varchar(5) = '',
	@Pagina int,
	@CantidadCuv int,
	@NroLote int = 0,
	@NroLoteFinal int = 0 out
)
AS
-- EstrategiaTemporalInsertarMasivo 201801, '007', 1, 200
BEGIN
	DECLARE @tablaCuvsOPT TABLE (
		CampaniaID int,
		CUV varchar(10),
		OfertaUltimoMinuto int,
		LimiteVenta int
	)

	IF (@EstrategiaCodigo = '011')
	BEGIN
		INSERT INTO @tablaCuvsOPT
			SELECT @CampaniaID, CUV, 0, 99
			FROM ods.ProductoComercial
			WHERE AnoCampania = @CampaniaID
				AND CodigoTipoOferta = '126'
				AND FactorRepeticion = 1
			GROUP BY CUV
	END
	ELSE
	BEGIN
		if	@Pagina < 1
			set @Pagina = 1

		declare @CuvDesde int = (@Pagina - 1) * @CantidadCuv + 1
		declare @CuvHasta int = @Pagina * @CantidadCuv
		--DECLARE @CampaniaIDChar CHAR(6) = convert(char(6), @CampaniaID)
		DECLARE @EstrategiaCodigoOds varchar(10)
		set @EstrategiaCodigoOds = dbo.fnGetTipoPersonalizacion(@EstrategiaCodigo)
		if @EstrategiaCodigoOds <> ''
		begin
			INSERT INTO @tablaCuvsOPT
			select @CampaniaID, m.CUV, m.OfertaUltimoMinuto, m.LimiteVenta
			from (
				SELECT ROW_NUMBER() over(order by  CUV desc) as ID,
				 CUV, ISNULL(FlagUltMinuto, 0) as OfertaUltimoMinuto,
				 ISNULL(LimUnidades, 99) as LimiteVenta
				FROM ods.OfertasPersonalizadasCUV
				WHERE AnioCampanaVenta = @CampaniaID
				AND TipoPersonalizacion = @EstrategiaCodigoOds
			) m
			where m.ID between @CuvDesde and @CuvHasta
		end

	END
	DECLARE @tablaResultado TABLE (
		Id int identity(1,1),
		CUV2 varchar(5),
		DescripcionCUV2 varchar(250),
		Precio2 decimal(18,2),
		CodigoProducto varchar(20),
		OfertaUltimoMinuto int,
		LimiteVenta int,
		ImagenURL varchar(250),
		PrecioPublico decimal(18, 2)
	)

	DECLARE @TipoEstrategiaId INT = 0
	set @TipoEstrategiaId = dbo.fnGetTipoEstrategiaId(@EstrategiaCodigo)
	INSERT INTO @tablaResultado
	SELECT
		t.CUV,
		COALESCE(mci.DescripcionComercial, e.DescripcionCUV2, pd.Descripcion, p.Descripcion),
		COALESCE(e.Precio2,p.PrecioUnitario),
		p.CodigoProducto,
		t.OfertaUltimoMinuto,
		t.LimiteVenta,
		mci.Foto,
		p.IndicadorPreUni
	FROM @tablaCuvsOPT t
		INNER JOIN ods.ProductoComercial p
			on t.CampaniaID = p.AnoCampania
			and t.CUV = p.CUV
		LEFT JOIN Estrategia e
			on t.CampaniaID = e.CampaniaID
			and t.CUV = e.CUV2
			and e.TipoEstrategiaID = @TipoEstrategiaId
		LEFT JOIN dbo.ProductoDescripcion pd
			on p.AnoCampania = pd.CampaniaID
			and p.CUV = pd.CUV
		LEFT JOIN MatrizComercial mc
			on p.CodigoProducto = mc.CodigoSAP
		LEFT JOIN MatrizComercialImagen mci
			on mci.IdMatrizComercial = mc.IdMatrizComercial
			and mci.NemoTecnico IS NOT NULL
	WHERE
		t.CampaniaID = @CampaniaID
		and e.CUV2 is null

	if @NroLote <= 0
	begin
		SELECT @NroLote = isnull(max(NumeroLote),0)
		FROM EstrategiaTemporal
		if	@NroLote < 0
			set @NroLote = 1
		else
			SET @NroLote = @NroLote + 1
	end

	declare @FechaSistema datetime = dbo.fnObtenerFechaHoraPais()
	INSERT INTO EstrategiaTemporal
	(
		CampaniaId,
		NumeroLote,
		pagina,
		CodigoTipoEstrategia,
		CUV,
		Descripcion,
		PrecioOferta,
		CodigoSap,
		OfertaUltimoMinuto,
		LimiteVenta,
		FotoProducto01,
		PrecioPublico,
		FechaCreacion
	)
	SELECT
		@CampaniaID,
		@NroLote,
		@Pagina,
		@EstrategiaCodigo,
		CUV2,
		DescripcionCUV2,
		Precio2,
		CodigoProducto,
		OfertaUltimoMinuto,
		LimiteVenta,
		ImagenURL,
		PrecioPublico,
		@FechaSistema
	FROM @tablaResultado
	WHERE Id in (
		SELECT min(id)
		FROM @tablaResultado
		group by CUV2
	)

	set @NroLoteFinal = @NroLote
END
GO

GO
USE BelcorpPanama
GO
GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EstrategiaTemporalInsertarMasivo') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.EstrategiaTemporalInsertarMasivo
GO

CREATE PROCEDURE EstrategiaTemporalInsertarMasivo
(
	@CampaniaID int,
	@EstrategiaCodigo varchar(5) = '',
	@Pagina int,
	@CantidadCuv int,
	@NroLote int = 0,
	@NroLoteFinal int = 0 out
)
AS
-- EstrategiaTemporalInsertarMasivo 201801, '007', 1, 200
BEGIN
	DECLARE @tablaCuvsOPT TABLE (
		CampaniaID int,
		CUV varchar(10),
		OfertaUltimoMinuto int,
		LimiteVenta int
	)

	IF (@EstrategiaCodigo = '011')
	BEGIN
		INSERT INTO @tablaCuvsOPT
			SELECT @CampaniaID, CUV, 0, 99
			FROM ods.ProductoComercial
			WHERE AnoCampania = @CampaniaID
				AND CodigoTipoOferta = '126'
				AND FactorRepeticion = 1
			GROUP BY CUV
	END
	ELSE
	BEGIN
		if	@Pagina < 1
			set @Pagina = 1

		declare @CuvDesde int = (@Pagina - 1) * @CantidadCuv + 1
		declare @CuvHasta int = @Pagina * @CantidadCuv
		--DECLARE @CampaniaIDChar CHAR(6) = convert(char(6), @CampaniaID)
		DECLARE @EstrategiaCodigoOds varchar(10)
		set @EstrategiaCodigoOds = dbo.fnGetTipoPersonalizacion(@EstrategiaCodigo)
		if @EstrategiaCodigoOds <> ''
		begin
			INSERT INTO @tablaCuvsOPT
			select @CampaniaID, m.CUV, m.OfertaUltimoMinuto, m.LimiteVenta
			from (
				SELECT ROW_NUMBER() over(order by  CUV desc) as ID,
				 CUV, ISNULL(FlagUltMinuto, 0) as OfertaUltimoMinuto,
				 ISNULL(LimUnidades, 99) as LimiteVenta
				FROM ods.OfertasPersonalizadasCUV
				WHERE AnioCampanaVenta = @CampaniaID
				AND TipoPersonalizacion = @EstrategiaCodigoOds
			) m
			where m.ID between @CuvDesde and @CuvHasta
		end

	END
	DECLARE @tablaResultado TABLE (
		Id int identity(1,1),
		CUV2 varchar(5),
		DescripcionCUV2 varchar(250),
		Precio2 decimal(18,2),
		CodigoProducto varchar(20),
		OfertaUltimoMinuto int,
		LimiteVenta int,
		ImagenURL varchar(250),
		PrecioPublico decimal(18, 2)
	)

	DECLARE @TipoEstrategiaId INT = 0
	set @TipoEstrategiaId = dbo.fnGetTipoEstrategiaId(@EstrategiaCodigo)
	INSERT INTO @tablaResultado
	SELECT
		t.CUV,
		COALESCE(mci.DescripcionComercial, e.DescripcionCUV2, pd.Descripcion, p.Descripcion),
		COALESCE(e.Precio2,p.PrecioUnitario),
		p.CodigoProducto,
		t.OfertaUltimoMinuto,
		t.LimiteVenta,
		mci.Foto,
		p.IndicadorPreUni
	FROM @tablaCuvsOPT t
		INNER JOIN ods.ProductoComercial p
			on t.CampaniaID = p.AnoCampania
			and t.CUV = p.CUV
		LEFT JOIN Estrategia e
			on t.CampaniaID = e.CampaniaID
			and t.CUV = e.CUV2
			and e.TipoEstrategiaID = @TipoEstrategiaId
		LEFT JOIN dbo.ProductoDescripcion pd
			on p.AnoCampania = pd.CampaniaID
			and p.CUV = pd.CUV
		LEFT JOIN MatrizComercial mc
			on p.CodigoProducto = mc.CodigoSAP
		LEFT JOIN MatrizComercialImagen mci
			on mci.IdMatrizComercial = mc.IdMatrizComercial
			and mci.NemoTecnico IS NOT NULL
	WHERE
		t.CampaniaID = @CampaniaID
		and e.CUV2 is null

	if @NroLote <= 0
	begin
		SELECT @NroLote = isnull(max(NumeroLote),0)
		FROM EstrategiaTemporal
		if	@NroLote < 0
			set @NroLote = 1
		else
			SET @NroLote = @NroLote + 1
	end

	declare @FechaSistema datetime = dbo.fnObtenerFechaHoraPais()
	INSERT INTO EstrategiaTemporal
	(
		CampaniaId,
		NumeroLote,
		pagina,
		CodigoTipoEstrategia,
		CUV,
		Descripcion,
		PrecioOferta,
		CodigoSap,
		OfertaUltimoMinuto,
		LimiteVenta,
		FotoProducto01,
		PrecioPublico,
		FechaCreacion
	)
	SELECT
		@CampaniaID,
		@NroLote,
		@Pagina,
		@EstrategiaCodigo,
		CUV2,
		DescripcionCUV2,
		Precio2,
		CodigoProducto,
		OfertaUltimoMinuto,
		LimiteVenta,
		ImagenURL,
		PrecioPublico,
		@FechaSistema
	FROM @tablaResultado
	WHERE Id in (
		SELECT min(id)
		FROM @tablaResultado
		group by CUV2
	)

	set @NroLoteFinal = @NroLote
END
GO

GO
USE BelcorpGuatemala
GO
GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EstrategiaTemporalInsertarMasivo') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.EstrategiaTemporalInsertarMasivo
GO

CREATE PROCEDURE EstrategiaTemporalInsertarMasivo
(
	@CampaniaID int,
	@EstrategiaCodigo varchar(5) = '',
	@Pagina int,
	@CantidadCuv int,
	@NroLote int = 0,
	@NroLoteFinal int = 0 out
)
AS
-- EstrategiaTemporalInsertarMasivo 201801, '007', 1, 200
BEGIN
	DECLARE @tablaCuvsOPT TABLE (
		CampaniaID int,
		CUV varchar(10),
		OfertaUltimoMinuto int,
		LimiteVenta int
	)

	IF (@EstrategiaCodigo = '011')
	BEGIN
		INSERT INTO @tablaCuvsOPT
			SELECT @CampaniaID, CUV, 0, 99
			FROM ods.ProductoComercial
			WHERE AnoCampania = @CampaniaID
				AND CodigoTipoOferta = '126'
				AND FactorRepeticion = 1
			GROUP BY CUV
	END
	ELSE
	BEGIN
		if	@Pagina < 1
			set @Pagina = 1

		declare @CuvDesde int = (@Pagina - 1) * @CantidadCuv + 1
		declare @CuvHasta int = @Pagina * @CantidadCuv
		--DECLARE @CampaniaIDChar CHAR(6) = convert(char(6), @CampaniaID)
		DECLARE @EstrategiaCodigoOds varchar(10)
		set @EstrategiaCodigoOds = dbo.fnGetTipoPersonalizacion(@EstrategiaCodigo)
		if @EstrategiaCodigoOds <> ''
		begin
			INSERT INTO @tablaCuvsOPT
			select @CampaniaID, m.CUV, m.OfertaUltimoMinuto, m.LimiteVenta
			from (
				SELECT ROW_NUMBER() over(order by  CUV desc) as ID,
				 CUV, ISNULL(FlagUltMinuto, 0) as OfertaUltimoMinuto,
				 ISNULL(LimUnidades, 99) as LimiteVenta
				FROM ods.OfertasPersonalizadasCUV
				WHERE AnioCampanaVenta = @CampaniaID
				AND TipoPersonalizacion = @EstrategiaCodigoOds
			) m
			where m.ID between @CuvDesde and @CuvHasta
		end

	END
	DECLARE @tablaResultado TABLE (
		Id int identity(1,1),
		CUV2 varchar(5),
		DescripcionCUV2 varchar(250),
		Precio2 decimal(18,2),
		CodigoProducto varchar(20),
		OfertaUltimoMinuto int,
		LimiteVenta int,
		ImagenURL varchar(250),
		PrecioPublico decimal(18, 2)
	)

	DECLARE @TipoEstrategiaId INT = 0
	set @TipoEstrategiaId = dbo.fnGetTipoEstrategiaId(@EstrategiaCodigo)
	INSERT INTO @tablaResultado
	SELECT
		t.CUV,
		COALESCE(mci.DescripcionComercial, e.DescripcionCUV2, pd.Descripcion, p.Descripcion),
		COALESCE(e.Precio2,p.PrecioUnitario),
		p.CodigoProducto,
		t.OfertaUltimoMinuto,
		t.LimiteVenta,
		mci.Foto,
		p.IndicadorPreUni
	FROM @tablaCuvsOPT t
		INNER JOIN ods.ProductoComercial p
			on t.CampaniaID = p.AnoCampania
			and t.CUV = p.CUV
		LEFT JOIN Estrategia e
			on t.CampaniaID = e.CampaniaID
			and t.CUV = e.CUV2
			and e.TipoEstrategiaID = @TipoEstrategiaId
		LEFT JOIN dbo.ProductoDescripcion pd
			on p.AnoCampania = pd.CampaniaID
			and p.CUV = pd.CUV
		LEFT JOIN MatrizComercial mc
			on p.CodigoProducto = mc.CodigoSAP
		LEFT JOIN MatrizComercialImagen mci
			on mci.IdMatrizComercial = mc.IdMatrizComercial
			and mci.NemoTecnico IS NOT NULL
	WHERE
		t.CampaniaID = @CampaniaID
		and e.CUV2 is null

	if @NroLote <= 0
	begin
		SELECT @NroLote = isnull(max(NumeroLote),0)
		FROM EstrategiaTemporal
		if	@NroLote < 0
			set @NroLote = 1
		else
			SET @NroLote = @NroLote + 1
	end

	declare @FechaSistema datetime = dbo.fnObtenerFechaHoraPais()
	INSERT INTO EstrategiaTemporal
	(
		CampaniaId,
		NumeroLote,
		pagina,
		CodigoTipoEstrategia,
		CUV,
		Descripcion,
		PrecioOferta,
		CodigoSap,
		OfertaUltimoMinuto,
		LimiteVenta,
		FotoProducto01,
		PrecioPublico,
		FechaCreacion
	)
	SELECT
		@CampaniaID,
		@NroLote,
		@Pagina,
		@EstrategiaCodigo,
		CUV2,
		DescripcionCUV2,
		Precio2,
		CodigoProducto,
		OfertaUltimoMinuto,
		LimiteVenta,
		ImagenURL,
		PrecioPublico,
		@FechaSistema
	FROM @tablaResultado
	WHERE Id in (
		SELECT min(id)
		FROM @tablaResultado
		group by CUV2
	)

	set @NroLoteFinal = @NroLote
END
GO

GO
USE BelcorpEcuador
GO
GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EstrategiaTemporalInsertarMasivo') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.EstrategiaTemporalInsertarMasivo
GO

CREATE PROCEDURE EstrategiaTemporalInsertarMasivo
(
	@CampaniaID int,
	@EstrategiaCodigo varchar(5) = '',
	@Pagina int,
	@CantidadCuv int,
	@NroLote int = 0,
	@NroLoteFinal int = 0 out
)
AS
-- EstrategiaTemporalInsertarMasivo 201801, '007', 1, 200
BEGIN
	DECLARE @tablaCuvsOPT TABLE (
		CampaniaID int,
		CUV varchar(10),
		OfertaUltimoMinuto int,
		LimiteVenta int
	)

	IF (@EstrategiaCodigo = '011')
	BEGIN
		INSERT INTO @tablaCuvsOPT
			SELECT @CampaniaID, CUV, 0, 99
			FROM ods.ProductoComercial
			WHERE AnoCampania = @CampaniaID
				AND CodigoTipoOferta = '126'
				AND FactorRepeticion = 1
			GROUP BY CUV
	END
	ELSE
	BEGIN
		if	@Pagina < 1
			set @Pagina = 1

		declare @CuvDesde int = (@Pagina - 1) * @CantidadCuv + 1
		declare @CuvHasta int = @Pagina * @CantidadCuv
		--DECLARE @CampaniaIDChar CHAR(6) = convert(char(6), @CampaniaID)
		DECLARE @EstrategiaCodigoOds varchar(10)
		set @EstrategiaCodigoOds = dbo.fnGetTipoPersonalizacion(@EstrategiaCodigo)
		if @EstrategiaCodigoOds <> ''
		begin
			INSERT INTO @tablaCuvsOPT
			select @CampaniaID, m.CUV, m.OfertaUltimoMinuto, m.LimiteVenta
			from (
				SELECT ROW_NUMBER() over(order by  CUV desc) as ID,
				 CUV, ISNULL(FlagUltMinuto, 0) as OfertaUltimoMinuto,
				 ISNULL(LimUnidades, 99) as LimiteVenta
				FROM ods.OfertasPersonalizadasCUV
				WHERE AnioCampanaVenta = @CampaniaID
				AND TipoPersonalizacion = @EstrategiaCodigoOds
			) m
			where m.ID between @CuvDesde and @CuvHasta
		end

	END
	DECLARE @tablaResultado TABLE (
		Id int identity(1,1),
		CUV2 varchar(5),
		DescripcionCUV2 varchar(250),
		Precio2 decimal(18,2),
		CodigoProducto varchar(20),
		OfertaUltimoMinuto int,
		LimiteVenta int,
		ImagenURL varchar(250),
		PrecioPublico decimal(18, 2)
	)

	DECLARE @TipoEstrategiaId INT = 0
	set @TipoEstrategiaId = dbo.fnGetTipoEstrategiaId(@EstrategiaCodigo)
	INSERT INTO @tablaResultado
	SELECT
		t.CUV,
		COALESCE(mci.DescripcionComercial, e.DescripcionCUV2, pd.Descripcion, p.Descripcion),
		COALESCE(e.Precio2,p.PrecioUnitario),
		p.CodigoProducto,
		t.OfertaUltimoMinuto,
		t.LimiteVenta,
		mci.Foto,
		p.IndicadorPreUni
	FROM @tablaCuvsOPT t
		INNER JOIN ods.ProductoComercial p
			on t.CampaniaID = p.AnoCampania
			and t.CUV = p.CUV
		LEFT JOIN Estrategia e
			on t.CampaniaID = e.CampaniaID
			and t.CUV = e.CUV2
			and e.TipoEstrategiaID = @TipoEstrategiaId
		LEFT JOIN dbo.ProductoDescripcion pd
			on p.AnoCampania = pd.CampaniaID
			and p.CUV = pd.CUV
		LEFT JOIN MatrizComercial mc
			on p.CodigoProducto = mc.CodigoSAP
		LEFT JOIN MatrizComercialImagen mci
			on mci.IdMatrizComercial = mc.IdMatrizComercial
			and mci.NemoTecnico IS NOT NULL
	WHERE
		t.CampaniaID = @CampaniaID
		and e.CUV2 is null

	if @NroLote <= 0
	begin
		SELECT @NroLote = isnull(max(NumeroLote),0)
		FROM EstrategiaTemporal
		if	@NroLote < 0
			set @NroLote = 1
		else
			SET @NroLote = @NroLote + 1
	end

	declare @FechaSistema datetime = dbo.fnObtenerFechaHoraPais()
	INSERT INTO EstrategiaTemporal
	(
		CampaniaId,
		NumeroLote,
		pagina,
		CodigoTipoEstrategia,
		CUV,
		Descripcion,
		PrecioOferta,
		CodigoSap,
		OfertaUltimoMinuto,
		LimiteVenta,
		FotoProducto01,
		PrecioPublico,
		FechaCreacion
	)
	SELECT
		@CampaniaID,
		@NroLote,
		@Pagina,
		@EstrategiaCodigo,
		CUV2,
		DescripcionCUV2,
		Precio2,
		CodigoProducto,
		OfertaUltimoMinuto,
		LimiteVenta,
		ImagenURL,
		PrecioPublico,
		@FechaSistema
	FROM @tablaResultado
	WHERE Id in (
		SELECT min(id)
		FROM @tablaResultado
		group by CUV2
	)

	set @NroLoteFinal = @NroLote
END
GO

GO
USE BelcorpDominicana
GO
GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EstrategiaTemporalInsertarMasivo') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.EstrategiaTemporalInsertarMasivo
GO

CREATE PROCEDURE EstrategiaTemporalInsertarMasivo
(
	@CampaniaID int,
	@EstrategiaCodigo varchar(5) = '',
	@Pagina int,
	@CantidadCuv int,
	@NroLote int = 0,
	@NroLoteFinal int = 0 out
)
AS
-- EstrategiaTemporalInsertarMasivo 201801, '007', 1, 200
BEGIN
	DECLARE @tablaCuvsOPT TABLE (
		CampaniaID int,
		CUV varchar(10),
		OfertaUltimoMinuto int,
		LimiteVenta int
	)

	IF (@EstrategiaCodigo = '011')
	BEGIN
		INSERT INTO @tablaCuvsOPT
			SELECT @CampaniaID, CUV, 0, 99
			FROM ods.ProductoComercial
			WHERE AnoCampania = @CampaniaID
				AND CodigoTipoOferta = '126'
				AND FactorRepeticion = 1
			GROUP BY CUV
	END
	ELSE
	BEGIN
		if	@Pagina < 1
			set @Pagina = 1

		declare @CuvDesde int = (@Pagina - 1) * @CantidadCuv + 1
		declare @CuvHasta int = @Pagina * @CantidadCuv
		--DECLARE @CampaniaIDChar CHAR(6) = convert(char(6), @CampaniaID)
		DECLARE @EstrategiaCodigoOds varchar(10)
		set @EstrategiaCodigoOds = dbo.fnGetTipoPersonalizacion(@EstrategiaCodigo)
		if @EstrategiaCodigoOds <> ''
		begin
			INSERT INTO @tablaCuvsOPT
			select @CampaniaID, m.CUV, m.OfertaUltimoMinuto, m.LimiteVenta
			from (
				SELECT ROW_NUMBER() over(order by  CUV desc) as ID,
				 CUV, ISNULL(FlagUltMinuto, 0) as OfertaUltimoMinuto,
				 ISNULL(LimUnidades, 99) as LimiteVenta
				FROM ods.OfertasPersonalizadasCUV
				WHERE AnioCampanaVenta = @CampaniaID
				AND TipoPersonalizacion = @EstrategiaCodigoOds
			) m
			where m.ID between @CuvDesde and @CuvHasta
		end

	END
	DECLARE @tablaResultado TABLE (
		Id int identity(1,1),
		CUV2 varchar(5),
		DescripcionCUV2 varchar(250),
		Precio2 decimal(18,2),
		CodigoProducto varchar(20),
		OfertaUltimoMinuto int,
		LimiteVenta int,
		ImagenURL varchar(250),
		PrecioPublico decimal(18, 2)
	)

	DECLARE @TipoEstrategiaId INT = 0
	set @TipoEstrategiaId = dbo.fnGetTipoEstrategiaId(@EstrategiaCodigo)
	INSERT INTO @tablaResultado
	SELECT
		t.CUV,
		COALESCE(mci.DescripcionComercial, e.DescripcionCUV2, pd.Descripcion, p.Descripcion),
		COALESCE(e.Precio2,p.PrecioUnitario),
		p.CodigoProducto,
		t.OfertaUltimoMinuto,
		t.LimiteVenta,
		mci.Foto,
		p.IndicadorPreUni
	FROM @tablaCuvsOPT t
		INNER JOIN ods.ProductoComercial p
			on t.CampaniaID = p.AnoCampania
			and t.CUV = p.CUV
		LEFT JOIN Estrategia e
			on t.CampaniaID = e.CampaniaID
			and t.CUV = e.CUV2
			and e.TipoEstrategiaID = @TipoEstrategiaId
		LEFT JOIN dbo.ProductoDescripcion pd
			on p.AnoCampania = pd.CampaniaID
			and p.CUV = pd.CUV
		LEFT JOIN MatrizComercial mc
			on p.CodigoProducto = mc.CodigoSAP
		LEFT JOIN MatrizComercialImagen mci
			on mci.IdMatrizComercial = mc.IdMatrizComercial
			and mci.NemoTecnico IS NOT NULL
	WHERE
		t.CampaniaID = @CampaniaID
		and e.CUV2 is null

	if @NroLote <= 0
	begin
		SELECT @NroLote = isnull(max(NumeroLote),0)
		FROM EstrategiaTemporal
		if	@NroLote < 0
			set @NroLote = 1
		else
			SET @NroLote = @NroLote + 1
	end

	declare @FechaSistema datetime = dbo.fnObtenerFechaHoraPais()
	INSERT INTO EstrategiaTemporal
	(
		CampaniaId,
		NumeroLote,
		pagina,
		CodigoTipoEstrategia,
		CUV,
		Descripcion,
		PrecioOferta,
		CodigoSap,
		OfertaUltimoMinuto,
		LimiteVenta,
		FotoProducto01,
		PrecioPublico,
		FechaCreacion
	)
	SELECT
		@CampaniaID,
		@NroLote,
		@Pagina,
		@EstrategiaCodigo,
		CUV2,
		DescripcionCUV2,
		Precio2,
		CodigoProducto,
		OfertaUltimoMinuto,
		LimiteVenta,
		ImagenURL,
		PrecioPublico,
		@FechaSistema
	FROM @tablaResultado
	WHERE Id in (
		SELECT min(id)
		FROM @tablaResultado
		group by CUV2
	)

	set @NroLoteFinal = @NroLote
END
GO

GO
USE BelcorpCostaRica
GO
GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EstrategiaTemporalInsertarMasivo') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.EstrategiaTemporalInsertarMasivo
GO

CREATE PROCEDURE EstrategiaTemporalInsertarMasivo
(
	@CampaniaID int,
	@EstrategiaCodigo varchar(5) = '',
	@Pagina int,
	@CantidadCuv int,
	@NroLote int = 0,
	@NroLoteFinal int = 0 out
)
AS
-- EstrategiaTemporalInsertarMasivo 201801, '007', 1, 200
BEGIN
	DECLARE @tablaCuvsOPT TABLE (
		CampaniaID int,
		CUV varchar(10),
		OfertaUltimoMinuto int,
		LimiteVenta int
	)

	IF (@EstrategiaCodigo = '011')
	BEGIN
		INSERT INTO @tablaCuvsOPT
			SELECT @CampaniaID, CUV, 0, 99
			FROM ods.ProductoComercial
			WHERE AnoCampania = @CampaniaID
				AND CodigoTipoOferta = '126'
				AND FactorRepeticion = 1
			GROUP BY CUV
	END
	ELSE
	BEGIN
		if	@Pagina < 1
			set @Pagina = 1

		declare @CuvDesde int = (@Pagina - 1) * @CantidadCuv + 1
		declare @CuvHasta int = @Pagina * @CantidadCuv
		--DECLARE @CampaniaIDChar CHAR(6) = convert(char(6), @CampaniaID)
		DECLARE @EstrategiaCodigoOds varchar(10)
		set @EstrategiaCodigoOds = dbo.fnGetTipoPersonalizacion(@EstrategiaCodigo)
		if @EstrategiaCodigoOds <> ''
		begin
			INSERT INTO @tablaCuvsOPT
			select @CampaniaID, m.CUV, m.OfertaUltimoMinuto, m.LimiteVenta
			from (
				SELECT ROW_NUMBER() over(order by  CUV desc) as ID,
				 CUV, ISNULL(FlagUltMinuto, 0) as OfertaUltimoMinuto,
				 ISNULL(LimUnidades, 99) as LimiteVenta
				FROM ods.OfertasPersonalizadasCUV
				WHERE AnioCampanaVenta = @CampaniaID
				AND TipoPersonalizacion = @EstrategiaCodigoOds
			) m
			where m.ID between @CuvDesde and @CuvHasta
		end

	END
	DECLARE @tablaResultado TABLE (
		Id int identity(1,1),
		CUV2 varchar(5),
		DescripcionCUV2 varchar(250),
		Precio2 decimal(18,2),
		CodigoProducto varchar(20),
		OfertaUltimoMinuto int,
		LimiteVenta int,
		ImagenURL varchar(250),
		PrecioPublico decimal(18, 2)
	)

	DECLARE @TipoEstrategiaId INT = 0
	set @TipoEstrategiaId = dbo.fnGetTipoEstrategiaId(@EstrategiaCodigo)
	INSERT INTO @tablaResultado
	SELECT
		t.CUV,
		COALESCE(mci.DescripcionComercial, e.DescripcionCUV2, pd.Descripcion, p.Descripcion),
		COALESCE(e.Precio2,p.PrecioUnitario),
		p.CodigoProducto,
		t.OfertaUltimoMinuto,
		t.LimiteVenta,
		mci.Foto,
		p.IndicadorPreUni
	FROM @tablaCuvsOPT t
		INNER JOIN ods.ProductoComercial p
			on t.CampaniaID = p.AnoCampania
			and t.CUV = p.CUV
		LEFT JOIN Estrategia e
			on t.CampaniaID = e.CampaniaID
			and t.CUV = e.CUV2
			and e.TipoEstrategiaID = @TipoEstrategiaId
		LEFT JOIN dbo.ProductoDescripcion pd
			on p.AnoCampania = pd.CampaniaID
			and p.CUV = pd.CUV
		LEFT JOIN MatrizComercial mc
			on p.CodigoProducto = mc.CodigoSAP
		LEFT JOIN MatrizComercialImagen mci
			on mci.IdMatrizComercial = mc.IdMatrizComercial
			and mci.NemoTecnico IS NOT NULL
	WHERE
		t.CampaniaID = @CampaniaID
		and e.CUV2 is null

	if @NroLote <= 0
	begin
		SELECT @NroLote = isnull(max(NumeroLote),0)
		FROM EstrategiaTemporal
		if	@NroLote < 0
			set @NroLote = 1
		else
			SET @NroLote = @NroLote + 1
	end

	declare @FechaSistema datetime = dbo.fnObtenerFechaHoraPais()
	INSERT INTO EstrategiaTemporal
	(
		CampaniaId,
		NumeroLote,
		pagina,
		CodigoTipoEstrategia,
		CUV,
		Descripcion,
		PrecioOferta,
		CodigoSap,
		OfertaUltimoMinuto,
		LimiteVenta,
		FotoProducto01,
		PrecioPublico,
		FechaCreacion
	)
	SELECT
		@CampaniaID,
		@NroLote,
		@Pagina,
		@EstrategiaCodigo,
		CUV2,
		DescripcionCUV2,
		Precio2,
		CodigoProducto,
		OfertaUltimoMinuto,
		LimiteVenta,
		ImagenURL,
		PrecioPublico,
		@FechaSistema
	FROM @tablaResultado
	WHERE Id in (
		SELECT min(id)
		FROM @tablaResultado
		group by CUV2
	)

	set @NroLoteFinal = @NroLote
END
GO

GO
USE BelcorpChile
GO
GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EstrategiaTemporalInsertarMasivo') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.EstrategiaTemporalInsertarMasivo
GO

CREATE PROCEDURE EstrategiaTemporalInsertarMasivo
(
	@CampaniaID int,
	@EstrategiaCodigo varchar(5) = '',
	@Pagina int,
	@CantidadCuv int,
	@NroLote int = 0,
	@NroLoteFinal int = 0 out
)
AS
-- EstrategiaTemporalInsertarMasivo 201801, '007', 1, 200
BEGIN
	DECLARE @tablaCuvsOPT TABLE (
		CampaniaID int,
		CUV varchar(10),
		OfertaUltimoMinuto int,
		LimiteVenta int
	)

	IF (@EstrategiaCodigo = '011')
	BEGIN
		INSERT INTO @tablaCuvsOPT
			SELECT @CampaniaID, CUV, 0, 99
			FROM ods.ProductoComercial
			WHERE AnoCampania = @CampaniaID
				AND CodigoTipoOferta = '126'
				AND FactorRepeticion = 1
			GROUP BY CUV
	END
	ELSE
	BEGIN
		if	@Pagina < 1
			set @Pagina = 1

		declare @CuvDesde int = (@Pagina - 1) * @CantidadCuv + 1
		declare @CuvHasta int = @Pagina * @CantidadCuv
		--DECLARE @CampaniaIDChar CHAR(6) = convert(char(6), @CampaniaID)
		DECLARE @EstrategiaCodigoOds varchar(10)
		set @EstrategiaCodigoOds = dbo.fnGetTipoPersonalizacion(@EstrategiaCodigo)
		if @EstrategiaCodigoOds <> ''
		begin
			INSERT INTO @tablaCuvsOPT
			select @CampaniaID, m.CUV, m.OfertaUltimoMinuto, m.LimiteVenta
			from (
				SELECT ROW_NUMBER() over(order by  CUV desc) as ID,
				 CUV, ISNULL(FlagUltMinuto, 0) as OfertaUltimoMinuto,
				 ISNULL(LimUnidades, 99) as LimiteVenta
				FROM ods.OfertasPersonalizadasCUV
				WHERE AnioCampanaVenta = @CampaniaID
				AND TipoPersonalizacion = @EstrategiaCodigoOds
			) m
			where m.ID between @CuvDesde and @CuvHasta
		end

	END
	DECLARE @tablaResultado TABLE (
		Id int identity(1,1),
		CUV2 varchar(5),
		DescripcionCUV2 varchar(250),
		Precio2 decimal(18,2),
		CodigoProducto varchar(20),
		OfertaUltimoMinuto int,
		LimiteVenta int,
		ImagenURL varchar(250),
		PrecioPublico decimal(18, 2)
	)

	DECLARE @TipoEstrategiaId INT = 0
	set @TipoEstrategiaId = dbo.fnGetTipoEstrategiaId(@EstrategiaCodigo)
	INSERT INTO @tablaResultado
	SELECT
		t.CUV,
		COALESCE(mci.DescripcionComercial, e.DescripcionCUV2, pd.Descripcion, p.Descripcion),
		COALESCE(e.Precio2,p.PrecioUnitario),
		p.CodigoProducto,
		t.OfertaUltimoMinuto,
		t.LimiteVenta,
		mci.Foto,
		p.IndicadorPreUni
	FROM @tablaCuvsOPT t
		INNER JOIN ods.ProductoComercial p
			on t.CampaniaID = p.AnoCampania
			and t.CUV = p.CUV
		LEFT JOIN Estrategia e
			on t.CampaniaID = e.CampaniaID
			and t.CUV = e.CUV2
			and e.TipoEstrategiaID = @TipoEstrategiaId
		LEFT JOIN dbo.ProductoDescripcion pd
			on p.AnoCampania = pd.CampaniaID
			and p.CUV = pd.CUV
		LEFT JOIN MatrizComercial mc
			on p.CodigoProducto = mc.CodigoSAP
		LEFT JOIN MatrizComercialImagen mci
			on mci.IdMatrizComercial = mc.IdMatrizComercial
			and mci.NemoTecnico IS NOT NULL
	WHERE
		t.CampaniaID = @CampaniaID
		and e.CUV2 is null

	if @NroLote <= 0
	begin
		SELECT @NroLote = isnull(max(NumeroLote),0)
		FROM EstrategiaTemporal
		if	@NroLote < 0
			set @NroLote = 1
		else
			SET @NroLote = @NroLote + 1
	end

	declare @FechaSistema datetime = dbo.fnObtenerFechaHoraPais()
	INSERT INTO EstrategiaTemporal
	(
		CampaniaId,
		NumeroLote,
		pagina,
		CodigoTipoEstrategia,
		CUV,
		Descripcion,
		PrecioOferta,
		CodigoSap,
		OfertaUltimoMinuto,
		LimiteVenta,
		FotoProducto01,
		PrecioPublico,
		FechaCreacion
	)
	SELECT
		@CampaniaID,
		@NroLote,
		@Pagina,
		@EstrategiaCodigo,
		CUV2,
		DescripcionCUV2,
		Precio2,
		CodigoProducto,
		OfertaUltimoMinuto,
		LimiteVenta,
		ImagenURL,
		PrecioPublico,
		@FechaSistema
	FROM @tablaResultado
	WHERE Id in (
		SELECT min(id)
		FROM @tablaResultado
		group by CUV2
	)

	set @NroLoteFinal = @NroLote
END
GO

GO
USE BelcorpBolivia
GO
GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EstrategiaTemporalInsertarMasivo') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.EstrategiaTemporalInsertarMasivo
GO

CREATE PROCEDURE EstrategiaTemporalInsertarMasivo
(
	@CampaniaID int,
	@EstrategiaCodigo varchar(5) = '',
	@Pagina int,
	@CantidadCuv int,
	@NroLote int = 0,
	@NroLoteFinal int = 0 out
)
AS
-- EstrategiaTemporalInsertarMasivo 201801, '007', 1, 200
BEGIN
	DECLARE @tablaCuvsOPT TABLE (
		CampaniaID int,
		CUV varchar(10),
		OfertaUltimoMinuto int,
		LimiteVenta int
	)

	IF (@EstrategiaCodigo = '011')
	BEGIN
		INSERT INTO @tablaCuvsOPT
			SELECT @CampaniaID, CUV, 0, 99
			FROM ods.ProductoComercial
			WHERE AnoCampania = @CampaniaID
				AND CodigoTipoOferta = '126'
				AND FactorRepeticion = 1
			GROUP BY CUV
	END
	ELSE
	BEGIN
		if	@Pagina < 1
			set @Pagina = 1

		declare @CuvDesde int = (@Pagina - 1) * @CantidadCuv + 1
		declare @CuvHasta int = @Pagina * @CantidadCuv
		--DECLARE @CampaniaIDChar CHAR(6) = convert(char(6), @CampaniaID)
		DECLARE @EstrategiaCodigoOds varchar(10)
		set @EstrategiaCodigoOds = dbo.fnGetTipoPersonalizacion(@EstrategiaCodigo)
		if @EstrategiaCodigoOds <> ''
		begin
			INSERT INTO @tablaCuvsOPT
			select @CampaniaID, m.CUV, m.OfertaUltimoMinuto, m.LimiteVenta
			from (
				SELECT ROW_NUMBER() over(order by  CUV desc) as ID,
				 CUV, ISNULL(FlagUltMinuto, 0) as OfertaUltimoMinuto,
				 ISNULL(LimUnidades, 99) as LimiteVenta
				FROM ods.OfertasPersonalizadasCUV
				WHERE AnioCampanaVenta = @CampaniaID
				AND TipoPersonalizacion = @EstrategiaCodigoOds
			) m
			where m.ID between @CuvDesde and @CuvHasta
		end

	END
	DECLARE @tablaResultado TABLE (
		Id int identity(1,1),
		CUV2 varchar(5),
		DescripcionCUV2 varchar(250),
		Precio2 decimal(18,2),
		CodigoProducto varchar(20),
		OfertaUltimoMinuto int,
		LimiteVenta int,
		ImagenURL varchar(250),
		PrecioPublico decimal(18, 2)
	)

	DECLARE @TipoEstrategiaId INT = 0
	set @TipoEstrategiaId = dbo.fnGetTipoEstrategiaId(@EstrategiaCodigo)
	INSERT INTO @tablaResultado
	SELECT
		t.CUV,
		COALESCE(mci.DescripcionComercial, e.DescripcionCUV2, pd.Descripcion, p.Descripcion),
		COALESCE(e.Precio2,p.PrecioUnitario),
		p.CodigoProducto,
		t.OfertaUltimoMinuto,
		t.LimiteVenta,
		mci.Foto,
		p.IndicadorPreUni
	FROM @tablaCuvsOPT t
		INNER JOIN ods.ProductoComercial p
			on t.CampaniaID = p.AnoCampania
			and t.CUV = p.CUV
		LEFT JOIN Estrategia e
			on t.CampaniaID = e.CampaniaID
			and t.CUV = e.CUV2
			and e.TipoEstrategiaID = @TipoEstrategiaId
		LEFT JOIN dbo.ProductoDescripcion pd
			on p.AnoCampania = pd.CampaniaID
			and p.CUV = pd.CUV
		LEFT JOIN MatrizComercial mc
			on p.CodigoProducto = mc.CodigoSAP
		LEFT JOIN MatrizComercialImagen mci
			on mci.IdMatrizComercial = mc.IdMatrizComercial
			and mci.NemoTecnico IS NOT NULL
	WHERE
		t.CampaniaID = @CampaniaID
		and e.CUV2 is null

	if @NroLote <= 0
	begin
		SELECT @NroLote = isnull(max(NumeroLote),0)
		FROM EstrategiaTemporal
		if	@NroLote < 0
			set @NroLote = 1
		else
			SET @NroLote = @NroLote + 1
	end

	declare @FechaSistema datetime = dbo.fnObtenerFechaHoraPais()
	INSERT INTO EstrategiaTemporal
	(
		CampaniaId,
		NumeroLote,
		pagina,
		CodigoTipoEstrategia,
		CUV,
		Descripcion,
		PrecioOferta,
		CodigoSap,
		OfertaUltimoMinuto,
		LimiteVenta,
		FotoProducto01,
		PrecioPublico,
		FechaCreacion
	)
	SELECT
		@CampaniaID,
		@NroLote,
		@Pagina,
		@EstrategiaCodigo,
		CUV2,
		DescripcionCUV2,
		Precio2,
		CodigoProducto,
		OfertaUltimoMinuto,
		LimiteVenta,
		ImagenURL,
		PrecioPublico,
		@FechaSistema
	FROM @tablaResultado
	WHERE Id in (
		SELECT min(id)
		FROM @tablaResultado
		group by CUV2
	)

	set @NroLoteFinal = @NroLote
END
GO

GO
