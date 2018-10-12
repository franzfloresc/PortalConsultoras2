USE BelcorpPeru
GO

GO
ALTER PROCEDURE [dbo].[GetCantidadOfertasParaTi]
@CampaniaID int,
@TipoConfigurado int,
@CodigoEstrategia varchar(4) = '001'
as
BEGIN

	declare @resultado int = 0

	declare @tablaCuvsOPT table (CampaniaID int, CUV varchar(5))

	DECLARE @EstrategiaCodigo VARCHAR(5)
	SET @EstrategiaCodigo = CASE @CodigoEstrategia 
		WHEN '001' THEN 'OPT'
		WHEN '009' THEN 'ODD'
		WHEN '020' THEN 'BS'
		WHEN '005' THEN 'LAN'
		WHEN '007' THEN 'OPM'
		WHEN '008' THEN 'PAD'
		WHEN '010' THEN 'GND'
		WHEN '030' THEN 'SR'
		ELSE 'OPT'
	END

	IF (@CodigoEstrategia = '011') -- Herramienta de Venta
	BEGIN
		INSERT INTO @tablaCuvsOPT
		SELECT @CampaniaID, CUV FROM ods.ProductoComercial 
		WHERE AnoCampania = @CampaniaID AND CodigoTipoOferta in ('126') 
			AND FactorRepeticion = 1
		GROUP BY CUV
	END
	ELSE
	BEGIN
		INSERT INTO @tablaCuvsOPT
		SELECT @CampaniaID, CUV FROM ods.OfertasPersonalizadas 
		WHERE AnioCampanaVenta = @CampaniaID and TipoPersonalizacion=@EstrategiaCodigo
		GROUP BY CUV
	END
	
	DECLARE @TipoEstrategiaId INT
	SET @TipoEstrategiaId = (SELECT TipoEstrategiaID FROM TipoEstrategia WHERE Codigo = @CodigoEstrategia)

	IF @TipoConfigurado=0
	BEGIN
		SET @resultado = (SELECT count(*) from @tablaCuvsOPT)
	END
	ELSE IF @TipoConfigurado = 1
	BEGIN
		SET @resultado = (SELECT count(*) from (SELECT t.CUV
		FROM @tablaCuvsOPT t 
		INNER JOIN Estrategia e ON 
			e.CampaniaID = t.CampaniaID 
			AND e.CUV2 = t.CUV
		WHERE e.CampaniaID = @CampaniaID 
			AND e.TipoEstrategiaID = @TipoEstrategiaId
		GROUP BY t.CUV) AS A)
	END
	ELSE
	BEGIN
		SET @resultado = (SELECT count(*)
		FROM @tablaCuvsOPT t 
		LEFT JOIN Estrategia e on t.CampaniaID = e.CampaniaID 
			AND t.CUV = e.CUV2 
			AND e.TipoEstrategiaID = @TipoEstrategiaId
		WHERE t.CampaniaID = @CampaniaID AND e.CUV2 is null)
	END

	SELECT @resultado

END
GO

USE BelcorpMexico
GO

GO
ALTER PROCEDURE [dbo].[GetCantidadOfertasParaTi]
@CampaniaID int,
@TipoConfigurado int,
@CodigoEstrategia varchar(4) = '001'
as
BEGIN

	declare @resultado int = 0

	declare @tablaCuvsOPT table (CampaniaID int, CUV varchar(5))

	DECLARE @EstrategiaCodigo VARCHAR(5)
	SET @EstrategiaCodigo = CASE @CodigoEstrategia 
		WHEN '001' THEN 'OPT'
		WHEN '009' THEN 'ODD'
		WHEN '020' THEN 'BS'
		WHEN '005' THEN 'LAN'
		WHEN '007' THEN 'OPM'
		WHEN '008' THEN 'PAD'
		WHEN '010' THEN 'GND'
		WHEN '030' THEN 'SR'
		ELSE 'OPT'
	END

	IF (@CodigoEstrategia = '011') -- Herramienta de Venta
	BEGIN
		INSERT INTO @tablaCuvsOPT
		SELECT @CampaniaID, CUV FROM ods.ProductoComercial 
		WHERE AnoCampania = @CampaniaID AND CodigoTipoOferta in ('126') 
			AND FactorRepeticion = 1
		GROUP BY CUV
	END
	ELSE
	BEGIN
		INSERT INTO @tablaCuvsOPT
		SELECT @CampaniaID, CUV FROM ods.OfertasPersonalizadas 
		WHERE AnioCampanaVenta = @CampaniaID and TipoPersonalizacion=@EstrategiaCodigo
		GROUP BY CUV
	END
	
	DECLARE @TipoEstrategiaId INT
	SET @TipoEstrategiaId = (SELECT TipoEstrategiaID FROM TipoEstrategia WHERE Codigo = @CodigoEstrategia)

	IF @TipoConfigurado=0
	BEGIN
		SET @resultado = (SELECT count(*) from @tablaCuvsOPT)
	END
	ELSE IF @TipoConfigurado = 1
	BEGIN
		SET @resultado = (SELECT count(*) from (SELECT t.CUV
		FROM @tablaCuvsOPT t 
		INNER JOIN Estrategia e ON 
			e.CampaniaID = t.CampaniaID 
			AND e.CUV2 = t.CUV
		WHERE e.CampaniaID = @CampaniaID 
			AND e.TipoEstrategiaID = @TipoEstrategiaId
		GROUP BY t.CUV) AS A)
	END
	ELSE
	BEGIN
		SET @resultado = (SELECT count(*)
		FROM @tablaCuvsOPT t 
		LEFT JOIN Estrategia e on t.CampaniaID = e.CampaniaID 
			AND t.CUV = e.CUV2 
			AND e.TipoEstrategiaID = @TipoEstrategiaId
		WHERE t.CampaniaID = @CampaniaID AND e.CUV2 is null)
	END

	SELECT @resultado

END
GO

USE BelcorpColombia
GO

GO
ALTER PROCEDURE [dbo].[GetCantidadOfertasParaTi]
@CampaniaID int,
@TipoConfigurado int,
@CodigoEstrategia varchar(4) = '001'
as
BEGIN

	declare @resultado int = 0

	declare @tablaCuvsOPT table (CampaniaID int, CUV varchar(5))

	DECLARE @EstrategiaCodigo VARCHAR(5)
	SET @EstrategiaCodigo = CASE @CodigoEstrategia 
		WHEN '001' THEN 'OPT'
		WHEN '009' THEN 'ODD'
		WHEN '020' THEN 'BS'
		WHEN '005' THEN 'LAN'
		WHEN '007' THEN 'OPM'
		WHEN '008' THEN 'PAD'
		WHEN '010' THEN 'GND'
		WHEN '030' THEN 'SR'
		ELSE 'OPT'
	END

	IF (@CodigoEstrategia = '011') -- Herramienta de Venta
	BEGIN
		INSERT INTO @tablaCuvsOPT
		SELECT @CampaniaID, CUV FROM ods.ProductoComercial 
		WHERE AnoCampania = @CampaniaID AND CodigoTipoOferta in ('126') 
			AND FactorRepeticion = 1
		GROUP BY CUV
	END
	ELSE
	BEGIN
		INSERT INTO @tablaCuvsOPT
		SELECT @CampaniaID, CUV FROM ods.OfertasPersonalizadas 
		WHERE AnioCampanaVenta = @CampaniaID and TipoPersonalizacion=@EstrategiaCodigo
		GROUP BY CUV
	END
	
	DECLARE @TipoEstrategiaId INT
	SET @TipoEstrategiaId = (SELECT TipoEstrategiaID FROM TipoEstrategia WHERE Codigo = @CodigoEstrategia)

	IF @TipoConfigurado=0
	BEGIN
		SET @resultado = (SELECT count(*) from @tablaCuvsOPT)
	END
	ELSE IF @TipoConfigurado = 1
	BEGIN
		SET @resultado = (SELECT count(*) from (SELECT t.CUV
		FROM @tablaCuvsOPT t 
		INNER JOIN Estrategia e ON 
			e.CampaniaID = t.CampaniaID 
			AND e.CUV2 = t.CUV
		WHERE e.CampaniaID = @CampaniaID 
			AND e.TipoEstrategiaID = @TipoEstrategiaId
		GROUP BY t.CUV) AS A)
	END
	ELSE
	BEGIN
		SET @resultado = (SELECT count(*)
		FROM @tablaCuvsOPT t 
		LEFT JOIN Estrategia e on t.CampaniaID = e.CampaniaID 
			AND t.CUV = e.CUV2 
			AND e.TipoEstrategiaID = @TipoEstrategiaId
		WHERE t.CampaniaID = @CampaniaID AND e.CUV2 is null)
	END

	SELECT @resultado

END
GO

USE BelcorpVenezuela
GO

GO
ALTER PROCEDURE [dbo].[GetCantidadOfertasParaTi]
@CampaniaID int,
@TipoConfigurado int,
@CodigoEstrategia varchar(4) = '001'
as
BEGIN

	declare @resultado int = 0

	declare @tablaCuvsOPT table (CampaniaID int, CUV varchar(5))

	DECLARE @EstrategiaCodigo VARCHAR(5)
	SET @EstrategiaCodigo = CASE @CodigoEstrategia 
		WHEN '001' THEN 'OPT'
		WHEN '009' THEN 'ODD'
		WHEN '020' THEN 'BS'
		WHEN '005' THEN 'LAN'
		WHEN '007' THEN 'OPM'
		WHEN '008' THEN 'PAD'
		WHEN '010' THEN 'GND'
		WHEN '030' THEN 'SR'
		ELSE 'OPT'
	END

	IF (@CodigoEstrategia = '011') -- Herramienta de Venta
	BEGIN
		INSERT INTO @tablaCuvsOPT
		SELECT @CampaniaID, CUV FROM ods.ProductoComercial 
		WHERE AnoCampania = @CampaniaID AND CodigoTipoOferta in ('126') 
			AND FactorRepeticion = 1
		GROUP BY CUV
	END
	ELSE
	BEGIN
		INSERT INTO @tablaCuvsOPT
		SELECT @CampaniaID, CUV FROM ods.OfertasPersonalizadas 
		WHERE AnioCampanaVenta = @CampaniaID and TipoPersonalizacion=@EstrategiaCodigo
		GROUP BY CUV
	END
	
	DECLARE @TipoEstrategiaId INT
	SET @TipoEstrategiaId = (SELECT TipoEstrategiaID FROM TipoEstrategia WHERE Codigo = @CodigoEstrategia)

	IF @TipoConfigurado=0
	BEGIN
		SET @resultado = (SELECT count(*) from @tablaCuvsOPT)
	END
	ELSE IF @TipoConfigurado = 1
	BEGIN
		SET @resultado = (SELECT count(*) from (SELECT t.CUV
		FROM @tablaCuvsOPT t 
		INNER JOIN Estrategia e ON 
			e.CampaniaID = t.CampaniaID 
			AND e.CUV2 = t.CUV
		WHERE e.CampaniaID = @CampaniaID 
			AND e.TipoEstrategiaID = @TipoEstrategiaId
		GROUP BY t.CUV) AS A)
	END
	ELSE
	BEGIN
		SET @resultado = (SELECT count(*)
		FROM @tablaCuvsOPT t 
		LEFT JOIN Estrategia e on t.CampaniaID = e.CampaniaID 
			AND t.CUV = e.CUV2 
			AND e.TipoEstrategiaID = @TipoEstrategiaId
		WHERE t.CampaniaID = @CampaniaID AND e.CUV2 is null)
	END

	SELECT @resultado

END
GO

USE BelcorpSalvador
GO

GO
ALTER PROCEDURE [dbo].[GetCantidadOfertasParaTi]
@CampaniaID int,
@TipoConfigurado int,
@CodigoEstrategia varchar(4) = '001'
as
BEGIN

	declare @resultado int = 0

	declare @tablaCuvsOPT table (CampaniaID int, CUV varchar(5))

	DECLARE @EstrategiaCodigo VARCHAR(5)
	SET @EstrategiaCodigo = CASE @CodigoEstrategia 
		WHEN '001' THEN 'OPT'
		WHEN '009' THEN 'ODD'
		WHEN '020' THEN 'BS'
		WHEN '005' THEN 'LAN'
		WHEN '007' THEN 'OPM'
		WHEN '008' THEN 'PAD'
		WHEN '010' THEN 'GND'
		WHEN '030' THEN 'SR'
		ELSE 'OPT'
	END

	IF (@CodigoEstrategia = '011') -- Herramienta de Venta
	BEGIN
		INSERT INTO @tablaCuvsOPT
		SELECT @CampaniaID, CUV FROM ods.ProductoComercial 
		WHERE AnoCampania = @CampaniaID AND CodigoTipoOferta in ('126') 
			AND FactorRepeticion = 1
		GROUP BY CUV
	END
	ELSE
	BEGIN
		INSERT INTO @tablaCuvsOPT
		SELECT @CampaniaID, CUV FROM ods.OfertasPersonalizadas 
		WHERE AnioCampanaVenta = @CampaniaID and TipoPersonalizacion=@EstrategiaCodigo
		GROUP BY CUV
	END
	
	DECLARE @TipoEstrategiaId INT
	SET @TipoEstrategiaId = (SELECT TipoEstrategiaID FROM TipoEstrategia WHERE Codigo = @CodigoEstrategia)

	IF @TipoConfigurado=0
	BEGIN
		SET @resultado = (SELECT count(*) from @tablaCuvsOPT)
	END
	ELSE IF @TipoConfigurado = 1
	BEGIN
		SET @resultado = (SELECT count(*) from (SELECT t.CUV
		FROM @tablaCuvsOPT t 
		INNER JOIN Estrategia e ON 
			e.CampaniaID = t.CampaniaID 
			AND e.CUV2 = t.CUV
		WHERE e.CampaniaID = @CampaniaID 
			AND e.TipoEstrategiaID = @TipoEstrategiaId
		GROUP BY t.CUV) AS A)
	END
	ELSE
	BEGIN
		SET @resultado = (SELECT count(*)
		FROM @tablaCuvsOPT t 
		LEFT JOIN Estrategia e on t.CampaniaID = e.CampaniaID 
			AND t.CUV = e.CUV2 
			AND e.TipoEstrategiaID = @TipoEstrategiaId
		WHERE t.CampaniaID = @CampaniaID AND e.CUV2 is null)
	END

	SELECT @resultado

END
GO

USE BelcorpPuertoRico
GO

GO
ALTER PROCEDURE [dbo].[GetCantidadOfertasParaTi]
@CampaniaID int,
@TipoConfigurado int,
@CodigoEstrategia varchar(4) = '001'
as
BEGIN

	declare @resultado int = 0

	declare @tablaCuvsOPT table (CampaniaID int, CUV varchar(5))

	DECLARE @EstrategiaCodigo VARCHAR(5)
	SET @EstrategiaCodigo = CASE @CodigoEstrategia 
		WHEN '001' THEN 'OPT'
		WHEN '009' THEN 'ODD'
		WHEN '020' THEN 'BS'
		WHEN '005' THEN 'LAN'
		WHEN '007' THEN 'OPM'
		WHEN '008' THEN 'PAD'
		WHEN '010' THEN 'GND'
		WHEN '030' THEN 'SR'
		ELSE 'OPT'
	END

	IF (@CodigoEstrategia = '011') -- Herramienta de Venta
	BEGIN
		INSERT INTO @tablaCuvsOPT
		SELECT @CampaniaID, CUV FROM ods.ProductoComercial 
		WHERE AnoCampania = @CampaniaID AND CodigoTipoOferta in ('126') 
			AND FactorRepeticion = 1
		GROUP BY CUV
	END
	ELSE
	BEGIN
		INSERT INTO @tablaCuvsOPT
		SELECT @CampaniaID, CUV FROM ods.OfertasPersonalizadas 
		WHERE AnioCampanaVenta = @CampaniaID and TipoPersonalizacion=@EstrategiaCodigo
		GROUP BY CUV
	END
	
	DECLARE @TipoEstrategiaId INT
	SET @TipoEstrategiaId = (SELECT TipoEstrategiaID FROM TipoEstrategia WHERE Codigo = @CodigoEstrategia)

	IF @TipoConfigurado=0
	BEGIN
		SET @resultado = (SELECT count(*) from @tablaCuvsOPT)
	END
	ELSE IF @TipoConfigurado = 1
	BEGIN
		SET @resultado = (SELECT count(*) from (SELECT t.CUV
		FROM @tablaCuvsOPT t 
		INNER JOIN Estrategia e ON 
			e.CampaniaID = t.CampaniaID 
			AND e.CUV2 = t.CUV
		WHERE e.CampaniaID = @CampaniaID 
			AND e.TipoEstrategiaID = @TipoEstrategiaId
		GROUP BY t.CUV) AS A)
	END
	ELSE
	BEGIN
		SET @resultado = (SELECT count(*)
		FROM @tablaCuvsOPT t 
		LEFT JOIN Estrategia e on t.CampaniaID = e.CampaniaID 
			AND t.CUV = e.CUV2 
			AND e.TipoEstrategiaID = @TipoEstrategiaId
		WHERE t.CampaniaID = @CampaniaID AND e.CUV2 is null)
	END

	SELECT @resultado

END
GO

USE BelcorpPanama
GO

GO
ALTER PROCEDURE [dbo].[GetCantidadOfertasParaTi]
@CampaniaID int,
@TipoConfigurado int,
@CodigoEstrategia varchar(4) = '001'
as
BEGIN

	declare @resultado int = 0

	declare @tablaCuvsOPT table (CampaniaID int, CUV varchar(5))

	DECLARE @EstrategiaCodigo VARCHAR(5)
	SET @EstrategiaCodigo = CASE @CodigoEstrategia 
		WHEN '001' THEN 'OPT'
		WHEN '009' THEN 'ODD'
		WHEN '020' THEN 'BS'
		WHEN '005' THEN 'LAN'
		WHEN '007' THEN 'OPM'
		WHEN '008' THEN 'PAD'
		WHEN '010' THEN 'GND'
		WHEN '030' THEN 'SR'
		ELSE 'OPT'
	END

	IF (@CodigoEstrategia = '011') -- Herramienta de Venta
	BEGIN
		INSERT INTO @tablaCuvsOPT
		SELECT @CampaniaID, CUV FROM ods.ProductoComercial 
		WHERE AnoCampania = @CampaniaID AND CodigoTipoOferta in ('126') 
			AND FactorRepeticion = 1
		GROUP BY CUV
	END
	ELSE
	BEGIN
		INSERT INTO @tablaCuvsOPT
		SELECT @CampaniaID, CUV FROM ods.OfertasPersonalizadas 
		WHERE AnioCampanaVenta = @CampaniaID and TipoPersonalizacion=@EstrategiaCodigo
		GROUP BY CUV
	END
	
	DECLARE @TipoEstrategiaId INT
	SET @TipoEstrategiaId = (SELECT TipoEstrategiaID FROM TipoEstrategia WHERE Codigo = @CodigoEstrategia)

	IF @TipoConfigurado=0
	BEGIN
		SET @resultado = (SELECT count(*) from @tablaCuvsOPT)
	END
	ELSE IF @TipoConfigurado = 1
	BEGIN
		SET @resultado = (SELECT count(*) from (SELECT t.CUV
		FROM @tablaCuvsOPT t 
		INNER JOIN Estrategia e ON 
			e.CampaniaID = t.CampaniaID 
			AND e.CUV2 = t.CUV
		WHERE e.CampaniaID = @CampaniaID 
			AND e.TipoEstrategiaID = @TipoEstrategiaId
		GROUP BY t.CUV) AS A)
	END
	ELSE
	BEGIN
		SET @resultado = (SELECT count(*)
		FROM @tablaCuvsOPT t 
		LEFT JOIN Estrategia e on t.CampaniaID = e.CampaniaID 
			AND t.CUV = e.CUV2 
			AND e.TipoEstrategiaID = @TipoEstrategiaId
		WHERE t.CampaniaID = @CampaniaID AND e.CUV2 is null)
	END

	SELECT @resultado

END
GO

USE BelcorpGuatemala
GO

GO
ALTER PROCEDURE [dbo].[GetCantidadOfertasParaTi]
@CampaniaID int,
@TipoConfigurado int,
@CodigoEstrategia varchar(4) = '001'
as
BEGIN

	declare @resultado int = 0

	declare @tablaCuvsOPT table (CampaniaID int, CUV varchar(5))

	DECLARE @EstrategiaCodigo VARCHAR(5)
	SET @EstrategiaCodigo = CASE @CodigoEstrategia 
		WHEN '001' THEN 'OPT'
		WHEN '009' THEN 'ODD'
		WHEN '020' THEN 'BS'
		WHEN '005' THEN 'LAN'
		WHEN '007' THEN 'OPM'
		WHEN '008' THEN 'PAD'
		WHEN '010' THEN 'GND'
		WHEN '030' THEN 'SR'
		ELSE 'OPT'
	END

	IF (@CodigoEstrategia = '011') -- Herramienta de Venta
	BEGIN
		INSERT INTO @tablaCuvsOPT
		SELECT @CampaniaID, CUV FROM ods.ProductoComercial 
		WHERE AnoCampania = @CampaniaID AND CodigoTipoOferta in ('126') 
			AND FactorRepeticion = 1
		GROUP BY CUV
	END
	ELSE
	BEGIN
		INSERT INTO @tablaCuvsOPT
		SELECT @CampaniaID, CUV FROM ods.OfertasPersonalizadas 
		WHERE AnioCampanaVenta = @CampaniaID and TipoPersonalizacion=@EstrategiaCodigo
		GROUP BY CUV
	END
	
	DECLARE @TipoEstrategiaId INT
	SET @TipoEstrategiaId = (SELECT TipoEstrategiaID FROM TipoEstrategia WHERE Codigo = @CodigoEstrategia)

	IF @TipoConfigurado=0
	BEGIN
		SET @resultado = (SELECT count(*) from @tablaCuvsOPT)
	END
	ELSE IF @TipoConfigurado = 1
	BEGIN
		SET @resultado = (SELECT count(*) from (SELECT t.CUV
		FROM @tablaCuvsOPT t 
		INNER JOIN Estrategia e ON 
			e.CampaniaID = t.CampaniaID 
			AND e.CUV2 = t.CUV
		WHERE e.CampaniaID = @CampaniaID 
			AND e.TipoEstrategiaID = @TipoEstrategiaId
		GROUP BY t.CUV) AS A)
	END
	ELSE
	BEGIN
		SET @resultado = (SELECT count(*)
		FROM @tablaCuvsOPT t 
		LEFT JOIN Estrategia e on t.CampaniaID = e.CampaniaID 
			AND t.CUV = e.CUV2 
			AND e.TipoEstrategiaID = @TipoEstrategiaId
		WHERE t.CampaniaID = @CampaniaID AND e.CUV2 is null)
	END

	SELECT @resultado

END
GO

USE BelcorpEcuador
GO

GO
ALTER PROCEDURE [dbo].[GetCantidadOfertasParaTi]
@CampaniaID int,
@TipoConfigurado int,
@CodigoEstrategia varchar(4) = '001'
as
BEGIN

	declare @resultado int = 0

	declare @tablaCuvsOPT table (CampaniaID int, CUV varchar(5))

	DECLARE @EstrategiaCodigo VARCHAR(5)
	SET @EstrategiaCodigo = CASE @CodigoEstrategia 
		WHEN '001' THEN 'OPT'
		WHEN '009' THEN 'ODD'
		WHEN '020' THEN 'BS'
		WHEN '005' THEN 'LAN'
		WHEN '007' THEN 'OPM'
		WHEN '008' THEN 'PAD'
		WHEN '010' THEN 'GND'
		WHEN '030' THEN 'SR'
		ELSE 'OPT'
	END

	IF (@CodigoEstrategia = '011') -- Herramienta de Venta
	BEGIN
		INSERT INTO @tablaCuvsOPT
		SELECT @CampaniaID, CUV FROM ods.ProductoComercial 
		WHERE AnoCampania = @CampaniaID AND CodigoTipoOferta in ('126') 
			AND FactorRepeticion = 1
		GROUP BY CUV
	END
	ELSE
	BEGIN
		INSERT INTO @tablaCuvsOPT
		SELECT @CampaniaID, CUV FROM ods.OfertasPersonalizadas 
		WHERE AnioCampanaVenta = @CampaniaID and TipoPersonalizacion=@EstrategiaCodigo
		GROUP BY CUV
	END
	
	DECLARE @TipoEstrategiaId INT
	SET @TipoEstrategiaId = (SELECT TipoEstrategiaID FROM TipoEstrategia WHERE Codigo = @CodigoEstrategia)

	IF @TipoConfigurado=0
	BEGIN
		SET @resultado = (SELECT count(*) from @tablaCuvsOPT)
	END
	ELSE IF @TipoConfigurado = 1
	BEGIN
		SET @resultado = (SELECT count(*) from (SELECT t.CUV
		FROM @tablaCuvsOPT t 
		INNER JOIN Estrategia e ON 
			e.CampaniaID = t.CampaniaID 
			AND e.CUV2 = t.CUV
		WHERE e.CampaniaID = @CampaniaID 
			AND e.TipoEstrategiaID = @TipoEstrategiaId
		GROUP BY t.CUV) AS A)
	END
	ELSE
	BEGIN
		SET @resultado = (SELECT count(*)
		FROM @tablaCuvsOPT t 
		LEFT JOIN Estrategia e on t.CampaniaID = e.CampaniaID 
			AND t.CUV = e.CUV2 
			AND e.TipoEstrategiaID = @TipoEstrategiaId
		WHERE t.CampaniaID = @CampaniaID AND e.CUV2 is null)
	END

	SELECT @resultado

END
GO

USE BelcorpDominicana
GO

GO
ALTER PROCEDURE [dbo].[GetCantidadOfertasParaTi]
@CampaniaID int,
@TipoConfigurado int,
@CodigoEstrategia varchar(4) = '001'
as
BEGIN

	declare @resultado int = 0

	declare @tablaCuvsOPT table (CampaniaID int, CUV varchar(5))

	DECLARE @EstrategiaCodigo VARCHAR(5)
	SET @EstrategiaCodigo = CASE @CodigoEstrategia 
		WHEN '001' THEN 'OPT'
		WHEN '009' THEN 'ODD'
		WHEN '020' THEN 'BS'
		WHEN '005' THEN 'LAN'
		WHEN '007' THEN 'OPM'
		WHEN '008' THEN 'PAD'
		WHEN '010' THEN 'GND'
		WHEN '030' THEN 'SR'
		ELSE 'OPT'
	END

	IF (@CodigoEstrategia = '011') -- Herramienta de Venta
	BEGIN
		INSERT INTO @tablaCuvsOPT
		SELECT @CampaniaID, CUV FROM ods.ProductoComercial 
		WHERE AnoCampania = @CampaniaID AND CodigoTipoOferta in ('126') 
			AND FactorRepeticion = 1
		GROUP BY CUV
	END
	ELSE
	BEGIN
		INSERT INTO @tablaCuvsOPT
		SELECT @CampaniaID, CUV FROM ods.OfertasPersonalizadas 
		WHERE AnioCampanaVenta = @CampaniaID and TipoPersonalizacion=@EstrategiaCodigo
		GROUP BY CUV
	END
	
	DECLARE @TipoEstrategiaId INT
	SET @TipoEstrategiaId = (SELECT TipoEstrategiaID FROM TipoEstrategia WHERE Codigo = @CodigoEstrategia)

	IF @TipoConfigurado=0
	BEGIN
		SET @resultado = (SELECT count(*) from @tablaCuvsOPT)
	END
	ELSE IF @TipoConfigurado = 1
	BEGIN
		SET @resultado = (SELECT count(*) from (SELECT t.CUV
		FROM @tablaCuvsOPT t 
		INNER JOIN Estrategia e ON 
			e.CampaniaID = t.CampaniaID 
			AND e.CUV2 = t.CUV
		WHERE e.CampaniaID = @CampaniaID 
			AND e.TipoEstrategiaID = @TipoEstrategiaId
		GROUP BY t.CUV) AS A)
	END
	ELSE
	BEGIN
		SET @resultado = (SELECT count(*)
		FROM @tablaCuvsOPT t 
		LEFT JOIN Estrategia e on t.CampaniaID = e.CampaniaID 
			AND t.CUV = e.CUV2 
			AND e.TipoEstrategiaID = @TipoEstrategiaId
		WHERE t.CampaniaID = @CampaniaID AND e.CUV2 is null)
	END

	SELECT @resultado

END
GO

USE BelcorpCostaRica
GO

GO
ALTER PROCEDURE [dbo].[GetCantidadOfertasParaTi]
@CampaniaID int,
@TipoConfigurado int,
@CodigoEstrategia varchar(4) = '001'
as
BEGIN

	declare @resultado int = 0

	declare @tablaCuvsOPT table (CampaniaID int, CUV varchar(5))

	DECLARE @EstrategiaCodigo VARCHAR(5)
	SET @EstrategiaCodigo = CASE @CodigoEstrategia 
		WHEN '001' THEN 'OPT'
		WHEN '009' THEN 'ODD'
		WHEN '020' THEN 'BS'
		WHEN '005' THEN 'LAN'
		WHEN '007' THEN 'OPM'
		WHEN '008' THEN 'PAD'
		WHEN '010' THEN 'GND'
		WHEN '030' THEN 'SR'
		ELSE 'OPT'
	END

	IF (@CodigoEstrategia = '011') -- Herramienta de Venta
	BEGIN
		INSERT INTO @tablaCuvsOPT
		SELECT @CampaniaID, CUV FROM ods.ProductoComercial 
		WHERE AnoCampania = @CampaniaID AND CodigoTipoOferta in ('126') 
			AND FactorRepeticion = 1
		GROUP BY CUV
	END
	ELSE
	BEGIN
		INSERT INTO @tablaCuvsOPT
		SELECT @CampaniaID, CUV FROM ods.OfertasPersonalizadas 
		WHERE AnioCampanaVenta = @CampaniaID and TipoPersonalizacion=@EstrategiaCodigo
		GROUP BY CUV
	END
	
	DECLARE @TipoEstrategiaId INT
	SET @TipoEstrategiaId = (SELECT TipoEstrategiaID FROM TipoEstrategia WHERE Codigo = @CodigoEstrategia)

	IF @TipoConfigurado=0
	BEGIN
		SET @resultado = (SELECT count(*) from @tablaCuvsOPT)
	END
	ELSE IF @TipoConfigurado = 1
	BEGIN
		SET @resultado = (SELECT count(*) from (SELECT t.CUV
		FROM @tablaCuvsOPT t 
		INNER JOIN Estrategia e ON 
			e.CampaniaID = t.CampaniaID 
			AND e.CUV2 = t.CUV
		WHERE e.CampaniaID = @CampaniaID 
			AND e.TipoEstrategiaID = @TipoEstrategiaId
		GROUP BY t.CUV) AS A)
	END
	ELSE
	BEGIN
		SET @resultado = (SELECT count(*)
		FROM @tablaCuvsOPT t 
		LEFT JOIN Estrategia e on t.CampaniaID = e.CampaniaID 
			AND t.CUV = e.CUV2 
			AND e.TipoEstrategiaID = @TipoEstrategiaId
		WHERE t.CampaniaID = @CampaniaID AND e.CUV2 is null)
	END

	SELECT @resultado

END
GO

USE BelcorpChile
GO

GO
ALTER PROCEDURE [dbo].[GetCantidadOfertasParaTi]
@CampaniaID int,
@TipoConfigurado int,
@CodigoEstrategia varchar(4) = '001'
as
BEGIN

	declare @resultado int = 0

	declare @tablaCuvsOPT table (CampaniaID int, CUV varchar(5))

	DECLARE @EstrategiaCodigo VARCHAR(5)
	SET @EstrategiaCodigo = CASE @CodigoEstrategia 
		WHEN '001' THEN 'OPT'
		WHEN '009' THEN 'ODD'
		WHEN '020' THEN 'BS'
		WHEN '005' THEN 'LAN'
		WHEN '007' THEN 'OPM'
		WHEN '008' THEN 'PAD'
		WHEN '010' THEN 'GND'
		WHEN '030' THEN 'SR'
		ELSE 'OPT'
	END

	IF (@CodigoEstrategia = '011') -- Herramienta de Venta
	BEGIN
		INSERT INTO @tablaCuvsOPT
		SELECT @CampaniaID, CUV FROM ods.ProductoComercial 
		WHERE AnoCampania = @CampaniaID AND CodigoTipoOferta in ('126') 
			AND FactorRepeticion = 1
		GROUP BY CUV
	END
	ELSE
	BEGIN
		INSERT INTO @tablaCuvsOPT
		SELECT @CampaniaID, CUV FROM ods.OfertasPersonalizadas 
		WHERE AnioCampanaVenta = @CampaniaID and TipoPersonalizacion=@EstrategiaCodigo
		GROUP BY CUV
	END
	
	DECLARE @TipoEstrategiaId INT
	SET @TipoEstrategiaId = (SELECT TipoEstrategiaID FROM TipoEstrategia WHERE Codigo = @CodigoEstrategia)

	IF @TipoConfigurado=0
	BEGIN
		SET @resultado = (SELECT count(*) from @tablaCuvsOPT)
	END
	ELSE IF @TipoConfigurado = 1
	BEGIN
		SET @resultado = (SELECT count(*) from (SELECT t.CUV
		FROM @tablaCuvsOPT t 
		INNER JOIN Estrategia e ON 
			e.CampaniaID = t.CampaniaID 
			AND e.CUV2 = t.CUV
		WHERE e.CampaniaID = @CampaniaID 
			AND e.TipoEstrategiaID = @TipoEstrategiaId
		GROUP BY t.CUV) AS A)
	END
	ELSE
	BEGIN
		SET @resultado = (SELECT count(*)
		FROM @tablaCuvsOPT t 
		LEFT JOIN Estrategia e on t.CampaniaID = e.CampaniaID 
			AND t.CUV = e.CUV2 
			AND e.TipoEstrategiaID = @TipoEstrategiaId
		WHERE t.CampaniaID = @CampaniaID AND e.CUV2 is null)
	END

	SELECT @resultado

END
GO

USE BelcorpBolivia
GO

GO
ALTER PROCEDURE [dbo].[GetCantidadOfertasParaTi]
@CampaniaID int,
@TipoConfigurado int,
@CodigoEstrategia varchar(4) = '001'
as
BEGIN

	declare @resultado int = 0

	declare @tablaCuvsOPT table (CampaniaID int, CUV varchar(5))

	DECLARE @EstrategiaCodigo VARCHAR(5)
	SET @EstrategiaCodigo = CASE @CodigoEstrategia 
		WHEN '001' THEN 'OPT'
		WHEN '009' THEN 'ODD'
		WHEN '020' THEN 'BS'
		WHEN '005' THEN 'LAN'
		WHEN '007' THEN 'OPM'
		WHEN '008' THEN 'PAD'
		WHEN '010' THEN 'GND'
		WHEN '030' THEN 'SR'
		ELSE 'OPT'
	END

	IF (@CodigoEstrategia = '011') -- Herramienta de Venta
	BEGIN
		INSERT INTO @tablaCuvsOPT
		SELECT @CampaniaID, CUV FROM ods.ProductoComercial 
		WHERE AnoCampania = @CampaniaID AND CodigoTipoOferta in ('126') 
			AND FactorRepeticion = 1
		GROUP BY CUV
	END
	ELSE
	BEGIN
		INSERT INTO @tablaCuvsOPT
		SELECT @CampaniaID, CUV FROM ods.OfertasPersonalizadas 
		WHERE AnioCampanaVenta = @CampaniaID and TipoPersonalizacion=@EstrategiaCodigo
		GROUP BY CUV
	END
	
	DECLARE @TipoEstrategiaId INT
	SET @TipoEstrategiaId = (SELECT TipoEstrategiaID FROM TipoEstrategia WHERE Codigo = @CodigoEstrategia)

	IF @TipoConfigurado=0
	BEGIN
		SET @resultado = (SELECT count(*) from @tablaCuvsOPT)
	END
	ELSE IF @TipoConfigurado = 1
	BEGIN
		SET @resultado = (SELECT count(*) from (SELECT t.CUV
		FROM @tablaCuvsOPT t 
		INNER JOIN Estrategia e ON 
			e.CampaniaID = t.CampaniaID 
			AND e.CUV2 = t.CUV
		WHERE e.CampaniaID = @CampaniaID 
			AND e.TipoEstrategiaID = @TipoEstrategiaId
		GROUP BY t.CUV) AS A)
	END
	ELSE
	BEGIN
		SET @resultado = (SELECT count(*)
		FROM @tablaCuvsOPT t 
		LEFT JOIN Estrategia e on t.CampaniaID = e.CampaniaID 
			AND t.CUV = e.CUV2 
			AND e.TipoEstrategiaID = @TipoEstrategiaId
		WHERE t.CampaniaID = @CampaniaID AND e.CUV2 is null)
	END

	SELECT @resultado

END
GO
