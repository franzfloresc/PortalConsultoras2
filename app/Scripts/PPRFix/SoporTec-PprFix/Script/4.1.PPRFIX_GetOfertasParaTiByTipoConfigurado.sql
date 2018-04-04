GO
ALTER PROCEDURE [dbo].[GetOfertasParaTiByTipoConfigurado]
	@CampaniaID int,
	@TipoConfigurado int,
	@EstrategiaCodigo varchar(5) = '001',
	@Pagina int = 0, -- empieza en 1
	@CantCuv int = 100
AS
BEGIN

	--DECLARE @CampaniaID int = 201806,
	--@TipoConfigurado int = 2,
	--@EstrategiaCodigo varchar(5) = '007',
	--@Pagina int = 4, -- empieza en 1
	--@CantCuv int = 100

	if	@Pagina < 1
		set @Pagina = 1
		
	declare @CuvDesde int = (@Pagina - 1) * @CantCuv + 1
	declare @CuvHasta int = @Pagina * @CantCuv

	DECLARE @CampaniaIDChar CHAR(6) = convert(char(6), @CampaniaID)

	DECLARE @EstrategiaCodigoOds CHAR(3)
	SET @EstrategiaCodigoOds = CASE @EstrategiaCodigo 
		WHEN '001' THEN 'OPT'
		WHEN '009' THEN 'ODD'
		WHEN '005' THEN 'LAN'
		WHEN '007' THEN 'OPM'
		WHEN '008' THEN 'PAD'
		WHEN '010' THEN 'GND'
		WHEN '030' THEN 'SR'
		ELSE 'OPT'
	END;

	DECLARE @tablaCuvsOPT TABLE (
		CampaniaID int, 
		CUV varchar(5), 
		OfertaUltimoMinuto int, 
		LimiteVenta int
	)

	IF (@EstrategiaCodigo = '011')
		INSERT INTO @tablaCuvsOPT
			SELECT @CampaniaID, CUV, 0, 99 
			FROM ods.ProductoComercial 
			WHERE AnoCampania = @CampaniaID 
				AND CodigoTipoOferta = '126'
				AND FactorRepeticion = 1
			GROUP BY CUV
	ELSE
	BEGIN
		INSERT INTO @tablaCuvsOPT
		select @CampaniaID, m.CUV, m.OfertaUltimoMinuto, m.LimiteVenta
		from (
			SELECT ROW_NUMBER() over(order by  CUV desc) as ID,
			 CUV, ISNULL(MAX(FlagUltMinuto), 0) as OfertaUltimoMinuto, 
			 ISNULL(MAX(LimUnidades), 99) as LimiteVenta
			FROM ods.OfertasPersonalizadas 
			WHERE AnioCampanaVenta = @CampaniaIDChar
			AND TipoPersonalizacion = @EstrategiaCodigoOds
			GROUP BY CUV
		) m
		where m.ID between @CuvDesde and @CuvHasta
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
	SELECT @TipoEstrategiaId = TipoEstrategiaID 
	FROM TipoEstrategia WHERE Codigo = @EstrategiaCodigo

	IF @TipoConfigurado = 0
	BEGIN
		INSERT INTO @tablaResultado
		SELECT 
			t.CUV,
			COALESCE(mci.DescripcionComercial, e.DescripcionCUV2, pd.Descripcion,  p.Descripcion),
			COALESCE(e.Precio2,p.PrecioUnitario),
			p.CodigoProducto,
			t.OfertaUltimoMinuto,
			t.LimiteVenta,
			mci.Foto,
			p.IndicadorPreUni
		FROM @tablaCuvsOPT t
			INNER JOIN ods.ProductoComercial p on
				t.CampaniaID = p.AnoCampania
				and t.CUV = p.CUV
			LEFT JOIN Estrategia e on
				t.CampaniaID = e.CampaniaID
				and t.CUV = e.CUV2 
				and e.TipoEstrategiaID = @TipoEstrategiaId
			LEFT JOIN dbo.ProductoDescripcion pd on
				p.AnoCampania = pd.CampaniaID
				and p.CUV = pd.CUV
			LEFT JOIN MatrizComercial mc on
				p.CodigoProducto = mc.CodigoSAP
			LEFT JOIN MatrizComercialImagen mci on 
				mci.IdMatrizComercial = mc.IdMatrizComercial 
				and mci.NemoTecnico IS NOT NULL
		WHERE 
			p.AnoCampania = @CampaniaID
			
		INSERT INTO @tablaResultado
		SELECT
			CUV,'',0,'',0,0,'',0
		FROM @tablaCuvsOPT WHERE CUV not in (
			SELECT CUV FROM ods.ProductoComercial WHERE AnoCampania = @CampaniaID
		)
	END
	ELSE IF @TipoConfigurado = 1
	BEGIN
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
		INNER JOIN ods.ProductoComercial p on
			t.CampaniaID = p.AnoCampania
			and t.CUV = p.CUV
		INNER JOIN Estrategia e on
			t.CampaniaID = e.CampaniaID
			and t.CUV = e.CUV2 
			and e.TipoEstrategiaID = @TipoEstrategiaId
		LEFT JOIN dbo.ProductoDescripcion pd on
			p.AnoCampania = pd.CampaniaID
			and p.CUV = pd.CUV
		LEFT JOIN MatrizComercial mc on
			p.CodigoProducto = mc.CodigoSAP
		LEFT JOIN MatrizComercialImagen mci on 
			mci.IdMatrizComercial = mc.IdMatrizComercial 
			and mci.NemoTecnico IS NOT NULL
		WHERE e.CampaniaID = @CampaniaID
	END

	ELSE -- IF @TipoConfigurado = 2
	BEGIN
		
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

	END

	SELECT 
		Id,
		CUV2, 
		DescripcionCUV2,
		Precio2,
		CodigoProducto,
		OfertaUltimoMinuto,
		LimiteVenta,
		ImagenURL,
		PrecioPublico
	FROM @tablaResultado 
	WHERE Id in (
		SELECT min(id) 
		FROM @tablaResultado
		group by CUV2
	)

END
GO