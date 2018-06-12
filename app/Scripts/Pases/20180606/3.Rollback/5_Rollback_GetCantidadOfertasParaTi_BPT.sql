GO
USE BelcorpPeru
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'GetCantidadOfertasParaTi') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.GetCantidadOfertasParaTi
GO
CREATE PROCEDURE [dbo].[GetCantidadOfertasParaTi]
	@CampaniaID int,
	@TipoConfigurado int,
	@CodigoEstrategia varchar(4) = '001'
as
BEGIN

	declare @resultado int = 0
	declare @tablaCuvsOPT table (CampaniaID int, CUV varchar(5))

	DECLARE @EstrategiaCodigo char(3)
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

	DECLARE @CampaniaIDChar CHAR(6) = convert(char(6), @CampaniaID)
	IF (@CodigoEstrategia = '011') -- Herramienta de Venta
	BEGIN
		INSERT INTO @tablaCuvsOPT
		SELECT @CampaniaID, CUV FROM ods.ProductoComercial
		WHERE AnoCampania = @CampaniaID
			AND CodigoTipoOferta in ('126')
			AND FactorRepeticion = 1
		GROUP BY CUV
	END
	ELSE
	BEGIN
		INSERT INTO @tablaCuvsOPT
		SELECT @CampaniaID, CUV
		FROM ods.OfertasPersonalizadas
		WHERE TipoPersonalizacion = @EstrategiaCodigo
		and AnioCampanaVenta = @CampaniaIDChar
		GROUP BY CUV
	END

	DECLARE @TipoEstrategiaId INT
	SET @TipoEstrategiaId = (SELECT TipoEstrategiaID FROM TipoEstrategia WHERE Codigo = @CodigoEstrategia)
	IF @TipoConfigurado=0
	BEGIN
		SET @resultado = (SELECT count(*) from @tablaCuvsOPT)
	END
	ELSE IF @TipoConfigurado = 1 -- lo que ya existe
	BEGIN
		SET @resultado = (
			SELECT count(*) from (SELECT t.CUV
			FROM @tablaCuvsOPT t
			INNER JOIN Estrategia e ON
				e.CampaniaID = t.CampaniaID
				AND e.CUV2 = t.CUV
			WHERE e.CampaniaID = @CampaniaID
				AND e.TipoEstrategiaID = @TipoEstrategiaId
			GROUP BY t.CUV
		) AS A)
	END
	ELSE -- IF @TipoConfigurado = 2 -- lo que falta
	BEGIN
		SET @resultado = (
			SELECT count(*)
			FROM @tablaCuvsOPT t
			LEFT JOIN Estrategia e on
				t.CampaniaID = e.CampaniaID
				AND t.CUV = e.CUV2
				AND e.TipoEstrategiaID = @TipoEstrategiaId
			WHERE t.CampaniaID = @CampaniaID
			AND e.CUV2 is null
		)
	END

	SELECT @resultado
END

GO

GO
USE BelcorpMexico
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'GetCantidadOfertasParaTi') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.GetCantidadOfertasParaTi
GO
CREATE PROCEDURE [dbo].[GetCantidadOfertasParaTi]
	@CampaniaID int,
	@TipoConfigurado int,
	@CodigoEstrategia varchar(4) = '001'
as
BEGIN

	declare @resultado int = 0
	declare @tablaCuvsOPT table (CampaniaID int, CUV varchar(5))

	DECLARE @EstrategiaCodigo char(3)
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

	DECLARE @CampaniaIDChar CHAR(6) = convert(char(6), @CampaniaID)
	IF (@CodigoEstrategia = '011') -- Herramienta de Venta
	BEGIN
		INSERT INTO @tablaCuvsOPT
		SELECT @CampaniaID, CUV FROM ods.ProductoComercial
		WHERE AnoCampania = @CampaniaID
			AND CodigoTipoOferta in ('126')
			AND FactorRepeticion = 1
		GROUP BY CUV
	END
	ELSE
	BEGIN
		INSERT INTO @tablaCuvsOPT
		SELECT @CampaniaID, CUV
		FROM ods.OfertasPersonalizadas
		WHERE TipoPersonalizacion = @EstrategiaCodigo
		and AnioCampanaVenta = @CampaniaIDChar
		GROUP BY CUV
	END

	DECLARE @TipoEstrategiaId INT
	SET @TipoEstrategiaId = (SELECT TipoEstrategiaID FROM TipoEstrategia WHERE Codigo = @CodigoEstrategia)
	IF @TipoConfigurado=0
	BEGIN
		SET @resultado = (SELECT count(*) from @tablaCuvsOPT)
	END
	ELSE IF @TipoConfigurado = 1 -- lo que ya existe
	BEGIN
		SET @resultado = (
			SELECT count(*) from (SELECT t.CUV
			FROM @tablaCuvsOPT t
			INNER JOIN Estrategia e ON
				e.CampaniaID = t.CampaniaID
				AND e.CUV2 = t.CUV
			WHERE e.CampaniaID = @CampaniaID
				AND e.TipoEstrategiaID = @TipoEstrategiaId
			GROUP BY t.CUV
		) AS A)
	END
	ELSE -- IF @TipoConfigurado = 2 -- lo que falta
	BEGIN
		SET @resultado = (
			SELECT count(*)
			FROM @tablaCuvsOPT t
			LEFT JOIN Estrategia e on
				t.CampaniaID = e.CampaniaID
				AND t.CUV = e.CUV2
				AND e.TipoEstrategiaID = @TipoEstrategiaId
			WHERE t.CampaniaID = @CampaniaID
			AND e.CUV2 is null
		)
	END

	SELECT @resultado
END

GO

GO
USE BelcorpColombia
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'GetCantidadOfertasParaTi') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.GetCantidadOfertasParaTi
GO
CREATE PROCEDURE [dbo].[GetCantidadOfertasParaTi]
	@CampaniaID int,
	@TipoConfigurado int,
	@CodigoEstrategia varchar(4) = '001'
as
BEGIN

	declare @resultado int = 0
	declare @tablaCuvsOPT table (CampaniaID int, CUV varchar(5))

	DECLARE @EstrategiaCodigo char(3)
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

	DECLARE @CampaniaIDChar CHAR(6) = convert(char(6), @CampaniaID)
	IF (@CodigoEstrategia = '011') -- Herramienta de Venta
	BEGIN
		INSERT INTO @tablaCuvsOPT
		SELECT @CampaniaID, CUV FROM ods.ProductoComercial
		WHERE AnoCampania = @CampaniaID
			AND CodigoTipoOferta in ('126')
			AND FactorRepeticion = 1
		GROUP BY CUV
	END
	ELSE
	BEGIN
		INSERT INTO @tablaCuvsOPT
		SELECT @CampaniaID, CUV
		FROM ods.OfertasPersonalizadas
		WHERE TipoPersonalizacion = @EstrategiaCodigo
		and AnioCampanaVenta = @CampaniaIDChar
		GROUP BY CUV
	END

	DECLARE @TipoEstrategiaId INT
	SET @TipoEstrategiaId = (SELECT TipoEstrategiaID FROM TipoEstrategia WHERE Codigo = @CodigoEstrategia)
	IF @TipoConfigurado=0
	BEGIN
		SET @resultado = (SELECT count(*) from @tablaCuvsOPT)
	END
	ELSE IF @TipoConfigurado = 1 -- lo que ya existe
	BEGIN
		SET @resultado = (
			SELECT count(*) from (SELECT t.CUV
			FROM @tablaCuvsOPT t
			INNER JOIN Estrategia e ON
				e.CampaniaID = t.CampaniaID
				AND e.CUV2 = t.CUV
			WHERE e.CampaniaID = @CampaniaID
				AND e.TipoEstrategiaID = @TipoEstrategiaId
			GROUP BY t.CUV
		) AS A)
	END
	ELSE -- IF @TipoConfigurado = 2 -- lo que falta
	BEGIN
		SET @resultado = (
			SELECT count(*)
			FROM @tablaCuvsOPT t
			LEFT JOIN Estrategia e on
				t.CampaniaID = e.CampaniaID
				AND t.CUV = e.CUV2
				AND e.TipoEstrategiaID = @TipoEstrategiaId
			WHERE t.CampaniaID = @CampaniaID
			AND e.CUV2 is null
		)
	END

	SELECT @resultado
END

GO

GO
USE BelcorpSalvador
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'GetCantidadOfertasParaTi') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.GetCantidadOfertasParaTi
GO
CREATE PROCEDURE [dbo].[GetCantidadOfertasParaTi]
	@CampaniaID int,
	@TipoConfigurado int,
	@CodigoEstrategia varchar(4) = '001'
as
BEGIN

	declare @resultado int = 0
	declare @tablaCuvsOPT table (CampaniaID int, CUV varchar(5))

	DECLARE @EstrategiaCodigo char(3)
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

	DECLARE @CampaniaIDChar CHAR(6) = convert(char(6), @CampaniaID)
	IF (@CodigoEstrategia = '011') -- Herramienta de Venta
	BEGIN
		INSERT INTO @tablaCuvsOPT
		SELECT @CampaniaID, CUV FROM ods.ProductoComercial
		WHERE AnoCampania = @CampaniaID
			AND CodigoTipoOferta in ('126')
			AND FactorRepeticion = 1
		GROUP BY CUV
	END
	ELSE
	BEGIN
		INSERT INTO @tablaCuvsOPT
		SELECT @CampaniaID, CUV
		FROM ods.OfertasPersonalizadas
		WHERE TipoPersonalizacion = @EstrategiaCodigo
		and AnioCampanaVenta = @CampaniaIDChar
		GROUP BY CUV
	END

	DECLARE @TipoEstrategiaId INT
	SET @TipoEstrategiaId = (SELECT TipoEstrategiaID FROM TipoEstrategia WHERE Codigo = @CodigoEstrategia)
	IF @TipoConfigurado=0
	BEGIN
		SET @resultado = (SELECT count(*) from @tablaCuvsOPT)
	END
	ELSE IF @TipoConfigurado = 1 -- lo que ya existe
	BEGIN
		SET @resultado = (
			SELECT count(*) from (SELECT t.CUV
			FROM @tablaCuvsOPT t
			INNER JOIN Estrategia e ON
				e.CampaniaID = t.CampaniaID
				AND e.CUV2 = t.CUV
			WHERE e.CampaniaID = @CampaniaID
				AND e.TipoEstrategiaID = @TipoEstrategiaId
			GROUP BY t.CUV
		) AS A)
	END
	ELSE -- IF @TipoConfigurado = 2 -- lo que falta
	BEGIN
		SET @resultado = (
			SELECT count(*)
			FROM @tablaCuvsOPT t
			LEFT JOIN Estrategia e on
				t.CampaniaID = e.CampaniaID
				AND t.CUV = e.CUV2
				AND e.TipoEstrategiaID = @TipoEstrategiaId
			WHERE t.CampaniaID = @CampaniaID
			AND e.CUV2 is null
		)
	END

	SELECT @resultado
END

GO

GO
USE BelcorpPuertoRico
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'GetCantidadOfertasParaTi') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.GetCantidadOfertasParaTi
GO
CREATE PROCEDURE [dbo].[GetCantidadOfertasParaTi]
	@CampaniaID int,
	@TipoConfigurado int,
	@CodigoEstrategia varchar(4) = '001'
as
BEGIN

	declare @resultado int = 0
	declare @tablaCuvsOPT table (CampaniaID int, CUV varchar(5))

	DECLARE @EstrategiaCodigo char(3)
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

	DECLARE @CampaniaIDChar CHAR(6) = convert(char(6), @CampaniaID)
	IF (@CodigoEstrategia = '011') -- Herramienta de Venta
	BEGIN
		INSERT INTO @tablaCuvsOPT
		SELECT @CampaniaID, CUV FROM ods.ProductoComercial
		WHERE AnoCampania = @CampaniaID
			AND CodigoTipoOferta in ('126')
			AND FactorRepeticion = 1
		GROUP BY CUV
	END
	ELSE
	BEGIN
		INSERT INTO @tablaCuvsOPT
		SELECT @CampaniaID, CUV
		FROM ods.OfertasPersonalizadas
		WHERE TipoPersonalizacion = @EstrategiaCodigo
		and AnioCampanaVenta = @CampaniaIDChar
		GROUP BY CUV
	END

	DECLARE @TipoEstrategiaId INT
	SET @TipoEstrategiaId = (SELECT TipoEstrategiaID FROM TipoEstrategia WHERE Codigo = @CodigoEstrategia)
	IF @TipoConfigurado=0
	BEGIN
		SET @resultado = (SELECT count(*) from @tablaCuvsOPT)
	END
	ELSE IF @TipoConfigurado = 1 -- lo que ya existe
	BEGIN
		SET @resultado = (
			SELECT count(*) from (SELECT t.CUV
			FROM @tablaCuvsOPT t
			INNER JOIN Estrategia e ON
				e.CampaniaID = t.CampaniaID
				AND e.CUV2 = t.CUV
			WHERE e.CampaniaID = @CampaniaID
				AND e.TipoEstrategiaID = @TipoEstrategiaId
			GROUP BY t.CUV
		) AS A)
	END
	ELSE -- IF @TipoConfigurado = 2 -- lo que falta
	BEGIN
		SET @resultado = (
			SELECT count(*)
			FROM @tablaCuvsOPT t
			LEFT JOIN Estrategia e on
				t.CampaniaID = e.CampaniaID
				AND t.CUV = e.CUV2
				AND e.TipoEstrategiaID = @TipoEstrategiaId
			WHERE t.CampaniaID = @CampaniaID
			AND e.CUV2 is null
		)
	END

	SELECT @resultado
END

GO

GO
USE BelcorpPanama
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'GetCantidadOfertasParaTi') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.GetCantidadOfertasParaTi
GO
CREATE PROCEDURE [dbo].[GetCantidadOfertasParaTi]
	@CampaniaID int,
	@TipoConfigurado int,
	@CodigoEstrategia varchar(4) = '001'
as
BEGIN

	declare @resultado int = 0
	declare @tablaCuvsOPT table (CampaniaID int, CUV varchar(5))

	DECLARE @EstrategiaCodigo char(3)
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

	DECLARE @CampaniaIDChar CHAR(6) = convert(char(6), @CampaniaID)
	IF (@CodigoEstrategia = '011') -- Herramienta de Venta
	BEGIN
		INSERT INTO @tablaCuvsOPT
		SELECT @CampaniaID, CUV FROM ods.ProductoComercial
		WHERE AnoCampania = @CampaniaID
			AND CodigoTipoOferta in ('126')
			AND FactorRepeticion = 1
		GROUP BY CUV
	END
	ELSE
	BEGIN
		INSERT INTO @tablaCuvsOPT
		SELECT @CampaniaID, CUV
		FROM ods.OfertasPersonalizadas
		WHERE TipoPersonalizacion = @EstrategiaCodigo
		and AnioCampanaVenta = @CampaniaIDChar
		GROUP BY CUV
	END

	DECLARE @TipoEstrategiaId INT
	SET @TipoEstrategiaId = (SELECT TipoEstrategiaID FROM TipoEstrategia WHERE Codigo = @CodigoEstrategia)
	IF @TipoConfigurado=0
	BEGIN
		SET @resultado = (SELECT count(*) from @tablaCuvsOPT)
	END
	ELSE IF @TipoConfigurado = 1 -- lo que ya existe
	BEGIN
		SET @resultado = (
			SELECT count(*) from (SELECT t.CUV
			FROM @tablaCuvsOPT t
			INNER JOIN Estrategia e ON
				e.CampaniaID = t.CampaniaID
				AND e.CUV2 = t.CUV
			WHERE e.CampaniaID = @CampaniaID
				AND e.TipoEstrategiaID = @TipoEstrategiaId
			GROUP BY t.CUV
		) AS A)
	END
	ELSE -- IF @TipoConfigurado = 2 -- lo que falta
	BEGIN
		SET @resultado = (
			SELECT count(*)
			FROM @tablaCuvsOPT t
			LEFT JOIN Estrategia e on
				t.CampaniaID = e.CampaniaID
				AND t.CUV = e.CUV2
				AND e.TipoEstrategiaID = @TipoEstrategiaId
			WHERE t.CampaniaID = @CampaniaID
			AND e.CUV2 is null
		)
	END

	SELECT @resultado
END

GO

GO
USE BelcorpGuatemala
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'GetCantidadOfertasParaTi') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.GetCantidadOfertasParaTi
GO
CREATE PROCEDURE [dbo].[GetCantidadOfertasParaTi]
	@CampaniaID int,
	@TipoConfigurado int,
	@CodigoEstrategia varchar(4) = '001'
as
BEGIN

	declare @resultado int = 0
	declare @tablaCuvsOPT table (CampaniaID int, CUV varchar(5))

	DECLARE @EstrategiaCodigo char(3)
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

	DECLARE @CampaniaIDChar CHAR(6) = convert(char(6), @CampaniaID)
	IF (@CodigoEstrategia = '011') -- Herramienta de Venta
	BEGIN
		INSERT INTO @tablaCuvsOPT
		SELECT @CampaniaID, CUV FROM ods.ProductoComercial
		WHERE AnoCampania = @CampaniaID
			AND CodigoTipoOferta in ('126')
			AND FactorRepeticion = 1
		GROUP BY CUV
	END
	ELSE
	BEGIN
		INSERT INTO @tablaCuvsOPT
		SELECT @CampaniaID, CUV
		FROM ods.OfertasPersonalizadas
		WHERE TipoPersonalizacion = @EstrategiaCodigo
		and AnioCampanaVenta = @CampaniaIDChar
		GROUP BY CUV
	END

	DECLARE @TipoEstrategiaId INT
	SET @TipoEstrategiaId = (SELECT TipoEstrategiaID FROM TipoEstrategia WHERE Codigo = @CodigoEstrategia)
	IF @TipoConfigurado=0
	BEGIN
		SET @resultado = (SELECT count(*) from @tablaCuvsOPT)
	END
	ELSE IF @TipoConfigurado = 1 -- lo que ya existe
	BEGIN
		SET @resultado = (
			SELECT count(*) from (SELECT t.CUV
			FROM @tablaCuvsOPT t
			INNER JOIN Estrategia e ON
				e.CampaniaID = t.CampaniaID
				AND e.CUV2 = t.CUV
			WHERE e.CampaniaID = @CampaniaID
				AND e.TipoEstrategiaID = @TipoEstrategiaId
			GROUP BY t.CUV
		) AS A)
	END
	ELSE -- IF @TipoConfigurado = 2 -- lo que falta
	BEGIN
		SET @resultado = (
			SELECT count(*)
			FROM @tablaCuvsOPT t
			LEFT JOIN Estrategia e on
				t.CampaniaID = e.CampaniaID
				AND t.CUV = e.CUV2
				AND e.TipoEstrategiaID = @TipoEstrategiaId
			WHERE t.CampaniaID = @CampaniaID
			AND e.CUV2 is null
		)
	END

	SELECT @resultado
END

GO

GO
USE BelcorpEcuador
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'GetCantidadOfertasParaTi') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.GetCantidadOfertasParaTi
GO
CREATE PROCEDURE [dbo].[GetCantidadOfertasParaTi]
	@CampaniaID int,
	@TipoConfigurado int,
	@CodigoEstrategia varchar(4) = '001'
as
BEGIN

	declare @resultado int = 0
	declare @tablaCuvsOPT table (CampaniaID int, CUV varchar(5))

	DECLARE @EstrategiaCodigo char(3)
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

	DECLARE @CampaniaIDChar CHAR(6) = convert(char(6), @CampaniaID)
	IF (@CodigoEstrategia = '011') -- Herramienta de Venta
	BEGIN
		INSERT INTO @tablaCuvsOPT
		SELECT @CampaniaID, CUV FROM ods.ProductoComercial
		WHERE AnoCampania = @CampaniaID
			AND CodigoTipoOferta in ('126')
			AND FactorRepeticion = 1
		GROUP BY CUV
	END
	ELSE
	BEGIN
		INSERT INTO @tablaCuvsOPT
		SELECT @CampaniaID, CUV
		FROM ods.OfertasPersonalizadas
		WHERE TipoPersonalizacion = @EstrategiaCodigo
		and AnioCampanaVenta = @CampaniaIDChar
		GROUP BY CUV
	END

	DECLARE @TipoEstrategiaId INT
	SET @TipoEstrategiaId = (SELECT TipoEstrategiaID FROM TipoEstrategia WHERE Codigo = @CodigoEstrategia)
	IF @TipoConfigurado=0
	BEGIN
		SET @resultado = (SELECT count(*) from @tablaCuvsOPT)
	END
	ELSE IF @TipoConfigurado = 1 -- lo que ya existe
	BEGIN
		SET @resultado = (
			SELECT count(*) from (SELECT t.CUV
			FROM @tablaCuvsOPT t
			INNER JOIN Estrategia e ON
				e.CampaniaID = t.CampaniaID
				AND e.CUV2 = t.CUV
			WHERE e.CampaniaID = @CampaniaID
				AND e.TipoEstrategiaID = @TipoEstrategiaId
			GROUP BY t.CUV
		) AS A)
	END
	ELSE -- IF @TipoConfigurado = 2 -- lo que falta
	BEGIN
		SET @resultado = (
			SELECT count(*)
			FROM @tablaCuvsOPT t
			LEFT JOIN Estrategia e on
				t.CampaniaID = e.CampaniaID
				AND t.CUV = e.CUV2
				AND e.TipoEstrategiaID = @TipoEstrategiaId
			WHERE t.CampaniaID = @CampaniaID
			AND e.CUV2 is null
		)
	END

	SELECT @resultado
END

GO

GO
USE BelcorpDominicana
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'GetCantidadOfertasParaTi') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.GetCantidadOfertasParaTi
GO
CREATE PROCEDURE [dbo].[GetCantidadOfertasParaTi]
	@CampaniaID int,
	@TipoConfigurado int,
	@CodigoEstrategia varchar(4) = '001'
as
BEGIN

	declare @resultado int = 0
	declare @tablaCuvsOPT table (CampaniaID int, CUV varchar(5))

	DECLARE @EstrategiaCodigo char(3)
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

	DECLARE @CampaniaIDChar CHAR(6) = convert(char(6), @CampaniaID)
	IF (@CodigoEstrategia = '011') -- Herramienta de Venta
	BEGIN
		INSERT INTO @tablaCuvsOPT
		SELECT @CampaniaID, CUV FROM ods.ProductoComercial
		WHERE AnoCampania = @CampaniaID
			AND CodigoTipoOferta in ('126')
			AND FactorRepeticion = 1
		GROUP BY CUV
	END
	ELSE
	BEGIN
		INSERT INTO @tablaCuvsOPT
		SELECT @CampaniaID, CUV
		FROM ods.OfertasPersonalizadas
		WHERE TipoPersonalizacion = @EstrategiaCodigo
		and AnioCampanaVenta = @CampaniaIDChar
		GROUP BY CUV
	END

	DECLARE @TipoEstrategiaId INT
	SET @TipoEstrategiaId = (SELECT TipoEstrategiaID FROM TipoEstrategia WHERE Codigo = @CodigoEstrategia)
	IF @TipoConfigurado=0
	BEGIN
		SET @resultado = (SELECT count(*) from @tablaCuvsOPT)
	END
	ELSE IF @TipoConfigurado = 1 -- lo que ya existe
	BEGIN
		SET @resultado = (
			SELECT count(*) from (SELECT t.CUV
			FROM @tablaCuvsOPT t
			INNER JOIN Estrategia e ON
				e.CampaniaID = t.CampaniaID
				AND e.CUV2 = t.CUV
			WHERE e.CampaniaID = @CampaniaID
				AND e.TipoEstrategiaID = @TipoEstrategiaId
			GROUP BY t.CUV
		) AS A)
	END
	ELSE -- IF @TipoConfigurado = 2 -- lo que falta
	BEGIN
		SET @resultado = (
			SELECT count(*)
			FROM @tablaCuvsOPT t
			LEFT JOIN Estrategia e on
				t.CampaniaID = e.CampaniaID
				AND t.CUV = e.CUV2
				AND e.TipoEstrategiaID = @TipoEstrategiaId
			WHERE t.CampaniaID = @CampaniaID
			AND e.CUV2 is null
		)
	END

	SELECT @resultado
END

GO

GO
USE BelcorpCostaRica
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'GetCantidadOfertasParaTi') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.GetCantidadOfertasParaTi
GO
CREATE PROCEDURE [dbo].[GetCantidadOfertasParaTi]
	@CampaniaID int,
	@TipoConfigurado int,
	@CodigoEstrategia varchar(4) = '001'
as
BEGIN

	declare @resultado int = 0
	declare @tablaCuvsOPT table (CampaniaID int, CUV varchar(5))

	DECLARE @EstrategiaCodigo char(3)
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

	DECLARE @CampaniaIDChar CHAR(6) = convert(char(6), @CampaniaID)
	IF (@CodigoEstrategia = '011') -- Herramienta de Venta
	BEGIN
		INSERT INTO @tablaCuvsOPT
		SELECT @CampaniaID, CUV FROM ods.ProductoComercial
		WHERE AnoCampania = @CampaniaID
			AND CodigoTipoOferta in ('126')
			AND FactorRepeticion = 1
		GROUP BY CUV
	END
	ELSE
	BEGIN
		INSERT INTO @tablaCuvsOPT
		SELECT @CampaniaID, CUV
		FROM ods.OfertasPersonalizadas
		WHERE TipoPersonalizacion = @EstrategiaCodigo
		and AnioCampanaVenta = @CampaniaIDChar
		GROUP BY CUV
	END

	DECLARE @TipoEstrategiaId INT
	SET @TipoEstrategiaId = (SELECT TipoEstrategiaID FROM TipoEstrategia WHERE Codigo = @CodigoEstrategia)
	IF @TipoConfigurado=0
	BEGIN
		SET @resultado = (SELECT count(*) from @tablaCuvsOPT)
	END
	ELSE IF @TipoConfigurado = 1 -- lo que ya existe
	BEGIN
		SET @resultado = (
			SELECT count(*) from (SELECT t.CUV
			FROM @tablaCuvsOPT t
			INNER JOIN Estrategia e ON
				e.CampaniaID = t.CampaniaID
				AND e.CUV2 = t.CUV
			WHERE e.CampaniaID = @CampaniaID
				AND e.TipoEstrategiaID = @TipoEstrategiaId
			GROUP BY t.CUV
		) AS A)
	END
	ELSE -- IF @TipoConfigurado = 2 -- lo que falta
	BEGIN
		SET @resultado = (
			SELECT count(*)
			FROM @tablaCuvsOPT t
			LEFT JOIN Estrategia e on
				t.CampaniaID = e.CampaniaID
				AND t.CUV = e.CUV2
				AND e.TipoEstrategiaID = @TipoEstrategiaId
			WHERE t.CampaniaID = @CampaniaID
			AND e.CUV2 is null
		)
	END

	SELECT @resultado
END

GO

GO
USE BelcorpChile
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'GetCantidadOfertasParaTi') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.GetCantidadOfertasParaTi
GO
CREATE PROCEDURE [dbo].[GetCantidadOfertasParaTi]
	@CampaniaID int,
	@TipoConfigurado int,
	@CodigoEstrategia varchar(4) = '001'
as
BEGIN

	declare @resultado int = 0
	declare @tablaCuvsOPT table (CampaniaID int, CUV varchar(5))

	DECLARE @EstrategiaCodigo char(3)
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

	DECLARE @CampaniaIDChar CHAR(6) = convert(char(6), @CampaniaID)
	IF (@CodigoEstrategia = '011') -- Herramienta de Venta
	BEGIN
		INSERT INTO @tablaCuvsOPT
		SELECT @CampaniaID, CUV FROM ods.ProductoComercial
		WHERE AnoCampania = @CampaniaID
			AND CodigoTipoOferta in ('126')
			AND FactorRepeticion = 1
		GROUP BY CUV
	END
	ELSE
	BEGIN
		INSERT INTO @tablaCuvsOPT
		SELECT @CampaniaID, CUV
		FROM ods.OfertasPersonalizadas
		WHERE TipoPersonalizacion = @EstrategiaCodigo
		and AnioCampanaVenta = @CampaniaIDChar
		GROUP BY CUV
	END

	DECLARE @TipoEstrategiaId INT
	SET @TipoEstrategiaId = (SELECT TipoEstrategiaID FROM TipoEstrategia WHERE Codigo = @CodigoEstrategia)
	IF @TipoConfigurado=0
	BEGIN
		SET @resultado = (SELECT count(*) from @tablaCuvsOPT)
	END
	ELSE IF @TipoConfigurado = 1 -- lo que ya existe
	BEGIN
		SET @resultado = (
			SELECT count(*) from (SELECT t.CUV
			FROM @tablaCuvsOPT t
			INNER JOIN Estrategia e ON
				e.CampaniaID = t.CampaniaID
				AND e.CUV2 = t.CUV
			WHERE e.CampaniaID = @CampaniaID
				AND e.TipoEstrategiaID = @TipoEstrategiaId
			GROUP BY t.CUV
		) AS A)
	END
	ELSE -- IF @TipoConfigurado = 2 -- lo que falta
	BEGIN
		SET @resultado = (
			SELECT count(*)
			FROM @tablaCuvsOPT t
			LEFT JOIN Estrategia e on
				t.CampaniaID = e.CampaniaID
				AND t.CUV = e.CUV2
				AND e.TipoEstrategiaID = @TipoEstrategiaId
			WHERE t.CampaniaID = @CampaniaID
			AND e.CUV2 is null
		)
	END

	SELECT @resultado
END

GO

GO
USE BelcorpBolivia
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'GetCantidadOfertasParaTi') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.GetCantidadOfertasParaTi
GO
CREATE PROCEDURE [dbo].[GetCantidadOfertasParaTi]
	@CampaniaID int,
	@TipoConfigurado int,
	@CodigoEstrategia varchar(4) = '001'
as
BEGIN

	declare @resultado int = 0
	declare @tablaCuvsOPT table (CampaniaID int, CUV varchar(5))

	DECLARE @EstrategiaCodigo char(3)
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

	DECLARE @CampaniaIDChar CHAR(6) = convert(char(6), @CampaniaID)
	IF (@CodigoEstrategia = '011') -- Herramienta de Venta
	BEGIN
		INSERT INTO @tablaCuvsOPT
		SELECT @CampaniaID, CUV FROM ods.ProductoComercial
		WHERE AnoCampania = @CampaniaID
			AND CodigoTipoOferta in ('126')
			AND FactorRepeticion = 1
		GROUP BY CUV
	END
	ELSE
	BEGIN
		INSERT INTO @tablaCuvsOPT
		SELECT @CampaniaID, CUV
		FROM ods.OfertasPersonalizadas
		WHERE TipoPersonalizacion = @EstrategiaCodigo
		and AnioCampanaVenta = @CampaniaIDChar
		GROUP BY CUV
	END

	DECLARE @TipoEstrategiaId INT
	SET @TipoEstrategiaId = (SELECT TipoEstrategiaID FROM TipoEstrategia WHERE Codigo = @CodigoEstrategia)
	IF @TipoConfigurado=0
	BEGIN
		SET @resultado = (SELECT count(*) from @tablaCuvsOPT)
	END
	ELSE IF @TipoConfigurado = 1 -- lo que ya existe
	BEGIN
		SET @resultado = (
			SELECT count(*) from (SELECT t.CUV
			FROM @tablaCuvsOPT t
			INNER JOIN Estrategia e ON
				e.CampaniaID = t.CampaniaID
				AND e.CUV2 = t.CUV
			WHERE e.CampaniaID = @CampaniaID
				AND e.TipoEstrategiaID = @TipoEstrategiaId
			GROUP BY t.CUV
		) AS A)
	END
	ELSE -- IF @TipoConfigurado = 2 -- lo que falta
	BEGIN
		SET @resultado = (
			SELECT count(*)
			FROM @tablaCuvsOPT t
			LEFT JOIN Estrategia e on
				t.CampaniaID = e.CampaniaID
				AND t.CUV = e.CUV2
				AND e.TipoEstrategiaID = @TipoEstrategiaId
			WHERE t.CampaniaID = @CampaniaID
			AND e.CUV2 is null
		)
	END

	SELECT @resultado
END

GO

GO
