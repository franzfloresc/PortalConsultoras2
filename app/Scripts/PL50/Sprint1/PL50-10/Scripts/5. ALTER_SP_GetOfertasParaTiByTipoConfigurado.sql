USE [BelcorpPeru_PL50]
GO
/****** Object:  StoredProcedure [dbo].[GetOfertasParaTiByTipoConfigurado]    Script Date: 17/01/2018 14:40:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[GetOfertasParaTiByTipoConfigurado]
	@CampaniaID int,
	@TipoConfigurado int,
	@EstrategiaCodigo varchar(5) = '001'
AS
BEGIN
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

	DECLARE @tablaCuvsOPT TABLE (CampaniaID int, CUV varchar(5), OfertaUltimoMinuto int, LimiteVenta int)
	DECLARE @EstrategiaCodigoOds VARCHAR(5)
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

	INSERT INTO @tablaCuvsOPT
		SELECT @CampaniaID, CUV, ISNULL(MAX(FlagUltMinuto),0), ISNULL(MAX(LimUnidades),99)
		FROM ods.OfertasPersonalizadas WHERE AnioCampanaVenta = @CampaniaID and TipoPersonalizacion= @EstrategiaCodigoOds
		GROUP BY CUV;
	
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
			LEFT JOIN dbo.ProductoDescripcion pd on
				p.AnoCampania = pd.CampaniaID
				and p.CUV = pd.CUV
			LEFT JOIN MatrizComercial mc on
				p.CodigoProducto = mc.CodigoSAP
			LEFT JOIN MatrizComercialImagen mci on 
				mci.IdMatrizComercial = mc.IdMatrizComercial AND 
				mci.NemoTecnico IS NOT NULL
		WHERE 
			p.AnoCampania = @CampaniaID
			
		INSERT INTO @tablaResultado
		SELECT TOP 5
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
		LEFT JOIN dbo.ProductoDescripcion pd on
			p.AnoCampania = pd.CampaniaID
			and p.CUV = pd.CUV
		LEFT JOIN MatrizComercial mc on
			p.CodigoProducto = mc.CodigoSAP
		LEFT JOIN MatrizComercialImagen mci on 
			mci.IdMatrizComercial = mc.IdMatrizComercial and 
			mci.NemoTecnico IS NOT NULL
		WHERE e.CampaniaID = @CampaniaID
	END

	ELSE
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
		LEFT JOIN Estrategia e on
			t.CampaniaID = e.CampaniaID
			and t.CUV = e.CUV2
		LEFT JOIN dbo.ProductoDescripcion pd on
			p.AnoCampania = pd.CampaniaID
			and p.CUV = pd.CUV
		LEFT JOIN MatrizComercial mc on
			p.CodigoProducto = mc.CodigoSAP
		LEFT JOIN MatrizComercialImagen mci on 
			mci.IdMatrizComercial = mc.IdMatrizComercial and 
			mci.NemoTecnico IS NOT NULL
		WHERE 
			t.CampaniaID = @CampaniaID
			and e.CUV2 is null
	END
	SELECT TOP 5 * FROM @tablaResultado WHERE Id in (
		SELECT min(id) FROM @tablaResultado
		group by CUV2
	)
END
