GO
USE BelcorpBolivia
GO

ALTER PROCEDURE [dbo].[GetListaProductoOfertaFinalRegaloSorpresa] (@Table1 dbo.ListaOfertaFinalType READONLY)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @CampaniaID INT
		,@CodigoConsultora VARCHAR(30)
		,@ZonaID INT
		,@CodigoRegion VARCHAR(8)
		,@CodigoZona VARCHAR(8)
		,@MontoMinPedido NUMERIC(15, 2)
		,@MontoTotal MONEY
		,@MontoEscala MONEY
		,@Algoritmo VARCHAR(10);

	SELECT @CampaniaID = CampaniaID
		,@CodigoConsultora = CodigoConsultora
		,@ZonaID = ZonaID
		,@CodigoRegion = CodigoRegion
		,@CodigoZona = CodigoZona
		,@MontoMinPedido = MontoMinimo
		,@MontoTotal = MontoTotal
		,@MontoEscala = MontoEscala
		,@Algoritmo = Algoritmo
	FROM @Table1;

	-- PASO 1 (validar parametria)
	DECLARE @CumpleParametria BIT
		,@MontoFaltante DECIMAL(18, 2)
		,@PrecioMinimo DECIMAL(18, 2)
		,@TipoMeta CHAR(2)
		,@MontoMeta DECIMAL(18, 2)
		,@GapAgregar DECIMAL(18, 2);

	SET @CumpleParametria = 0;

	IF (@MontoTotal >= @MontoMinPedido)
	BEGIN
		SELECT TOP 1 @GapAgregar = ISNULL(PrecioMinimo, 0)
		FROM OfertaFinalParametria WITH (NOLOCK)
		WHERE Tipo LIKE 'RG%'
			AND @MontoTotal BETWEEN GapMinimo AND GapMaximo
			AND Algoritmo = @Algoritmo;

		IF (@GapAgregar >= 0)
		BEGIN
			SET @TipoMeta = 'RG';
			SET @PrecioMinimo = 0;

			DECLARE @ConsultoraId INT
				,@MontoMaxPedido DECIMAL(18, 2);

			SELECT @ConsultoraId = ConsultoraId
				,@MontoMaxPedido = ISNULL(MontoMaximoPedido, 0)
			FROM ods.Consultora WITH (NOLOCK)
			WHERE Codigo = @CodigoConsultora;

			IF (@MontoTotal <= @MontoMaxPedido)
			BEGIN
				SET @CumpleParametria = 1;

				SELECT @MontoMeta = ISNULL(MontoMeta,0)
				FROM OfertaFinalMontoMeta WITH (NOLOCK)
				WHERE CampaniaId = @CampaniaID
					AND ConsultoraId = @ConsultoraId;

				--IF (ISNULL(@MontoMeta, 0) = 0)
				--    EXECUTE InsertarOfertaFinalRegaloSorpresa @CampaniaID,
				--                                              @ConsultoraId,
				--                                              @MontoTotal,
				--                                              @Algoritmo,
				--                                              @MontoMeta OUTPUT;
				IF (@MontoMeta != 0)
				BEGIN
					IF (@MontoTotal >= @MontoMeta)
					BEGIN
						SET @TipoMeta = 'GM';

						SELECT TOP 1 @PrecioMinimo = ISNULL(PrecioMinimo,0)
						FROM OfertaFinalParametria WITH (NOLOCK)
						WHERE Tipo = 'GM'
							AND Algoritmo = @Algoritmo;

						IF (@PrecioMinimo >= 0)
							SET @CumpleParametria = 1;
						ELSE
							SET @CumpleParametria = 0;
					END;
				END;
				ELSE
					SET @CumpleParametria = 1;
			END;
			ELSE
				SET @CumpleParametria = 0;
		END;
	END;
	ELSE
	BEGIN
		SET @MontoFaltante = (@MontoMinPedido - @MontoTotal);

		IF (@MontoFaltante > 0)
		BEGIN
			SELECT TOP 1 @PrecioMinimo = PrecioMinimo
				,@CumpleParametria = 1
			FROM OfertaFinalParametria WITH (NOLOCK)
			WHERE Tipo = 'MM'
				AND @MontoFaltante BETWEEN GapMinimo AND GapMaximo
				AND Algoritmo = @Algoritmo;

			SET @TipoMeta = 'MM';
		END;
	END;

	IF (@CumpleParametria = 1)
	BEGIN
		DECLARE @tablaCuvFaltante TABLE (CUV VARCHAR(6));

		-- PASO 2 (cuv faltantes y anunciadoS)
		INSERT INTO @tablaCuvFaltante
		SELECT DISTINCT LTRIM(RTRIM(CUV))
		FROM dbo.ProductoFaltante WITH (NOLOCK)
		WHERE CampaniaID = @CampaniaID
			AND ZonaID = @ZonaID
		
		UNION ALL
		
		SELECT DISTINCT LTRIM(RTRIM(fa.CodigoVenta))
		FROM ods.FaltanteAnunciado fa WITH (NOLOCK)
		INNER JOIN ods.Campania c WITH (NOLOCK) ON fa.CampaniaID = c.CampaniaID
		WHERE c.Codigo = @CampaniaID
			AND (
				RTRIM(fa.CodigoRegion) = @CodigoRegion
				OR fa.CodigoRegion IS NULL
				)
			AND (
				RTRIM(fa.CodigoZona) = @CodigoZona
				OR fa.CodigoZona IS NULL
				);

		-- PASO 3 (cuv ya comprados)
		DECLARE @tablaCuvPedido TABLE (
			CUV VARCHAR(6)
			,CodigoSap VARCHAR(30)
			);

		INSERT INTO @tablaCuvPedido
		SELECT pc.CUV
			,pc.CodigoProducto
		FROM PedidoWebDetalle pd WITH (NOLOCK)
		INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON pd.CampaniaID = pc.AnoCampania
			AND pd.CUV = pc.CUV
			AND pc.IndicadorDigitable = 1
		--AND pc.CodigoCatalago IN (9,10,13, 24)
		INNER JOIN ods.Consultora c WITH (NOLOCK) ON pd.ConsultoraID = c.ConsultoraID
		WHERE pd.CampaniaID = @CampaniaID
			AND c.Codigo = @CodigoConsultora;

		-- PASO 4 (buscar ofertas para la consultora)
		DECLARE @tablaCodigosCuv TABLE (
			CUV VARCHAR(6)
			,CodigoSap VARCHAR(12)
			,CampaniaID INT
			,Orden INT
			);

		INSERT INTO @tablaCodigosCuv
		SELECT pc.CUV
			,pc.CodigoProducto
			,pc.CampaniaID
			,op.Orden
		FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
		INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON op.AnioCampanaVenta = pc.AnoCampania
			AND op.CUV = pc.CUV
			AND op.TipoPersonalizacion = 'SR'
			AND op.CodConsultora = @CodigoConsultora
		WHERE op.AnioCampanaVenta = @CampaniaId
			AND pc.CUV NOT IN (
				SELECT CUV
				FROM @tablaCuvFaltante
				)
			AND pc.CodigoProducto NOT IN (
				SELECT CodigoSap
				FROM @tablaCuvPedido
				);

		-- PASO 5 (si no hay ofertas para la consultora buscar por la generica)
		DECLARE @cantOfertas INT = 0
			,@consultoraGenerica VARCHAR(30) = '';

		SELECT @cantOfertas = COUNT(1)
		FROM @tablaCodigosCuv;

		IF ISNULL(@cantOfertas, 0) = 0
		BEGIN
			SELECT @consultoraGenerica = Codigo
			FROM TablaLogicaDatos
			WHERE TablaLogicaDatosID = 10001;

			IF ISNULL(@consultoraGenerica,'') != ''
			BEGIN
				INSERT INTO @tablaCodigosCuv
				SELECT pc.CUV
					,pc.CodigoProducto
					,pc.CampaniaID
					,op.Orden
				FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
				INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON op.AnioCampanaVenta = pc.AnoCampania
					AND op.CUV = pc.CUV
					AND op.TipoPersonalizacion = 'SR'
					AND op.CodConsultora = @consultoraGenerica
				WHERE op.AnioCampanaVenta = @CampaniaID
					AND pc.CUV NOT IN (
						SELECT CUV
						FROM @tablaCuvFaltante
						)
					AND pc.CodigoProducto NOT IN (
						SELECT CodigoSap
						FROM @tablaCuvPedido
						);
			END;
		END;

		DECLARE @OfertaProductoTemp TABLE (
			CampaniaID INT
			,CUV VARCHAR(6)
			,ConfiguracionOfertaID INT
			,TipoOfertaSisID INT
			);

		INSERT INTO @OfertaProductoTemp
		SELECT op.CampaniaID
			,op.CUV
			,op.ConfiguracionOfertaID
			,op.TipoOfertaSisID
		FROM OfertaProducto op WITH (NOLOCK)
		INNER JOIN @tablaCodigosCuv tc ON op.CampaniaID = tc.CampaniaID
			AND op.CUV = tc.CUV;

		IF (@TipoMeta = 'GM')
			SET @MontoFaltante = 0;

		-- PASO 6 (filtrar resultados)
		SELECT DISTINCT p.CUV
			,p.Descripcion AS Descripcion
			,(p.PrecioUnitario * p.FactorRepeticion) AS PrecioCatalogo
			,p.MarcaID AS IdMarca
			,p.PrecioValorizado
			,p.PaisID
			,p.AnoCampania AS CampaniaID
			,p.CodigoCatalago
			,p.CodigoProducto AS CodigoSap
			,p.IndicadorMontoMinimo
			,p.IndicadorOferta
			,0 AS EstaEnRevista
			,ISNULL(pcc.EsExpoOferta, 0) AS EsExpoOferta
			,ISNULL(pcc.CUVRevista, '') AS CUVRevista
			,M.Nombre AS NombreMarca
			,'NO DISPONIBLE' AS DescripcionCategoria
			,'' AS CUVComplemento
			,'' AS DescripcionEstrategia
			,ISNULL(op.ConfiguracionOfertaID, 0) AS ConfiguracionOfertaID
			,ISNULL(op.TipoOfertaSisID, 0) AS TipoOfertaSisID
			,0 AS FlagNueva
			,0 AS TipoEstrategiaID
			,0 AS TieneSugerido
			,CASE 
				WHEN pl.CodigoSap IS NULL
					THEN 0
				ELSE 1
				END AS TieneLanzamientoCatalogoPersonalizado
			,CASE 
				WHEN pcor.SAP IS NULL
					THEN 0
				ELSE 1
				END AS TieneOfertaRevista
			,ISNULL(pcor.Oferta, '') AS TipoOfertaRevista
			,tc.Orden
			,@TipoMeta AS TipoMeta
			,CASE @TipoMeta
				WHEN 'MM'
					THEN @MontoFaltante
				WHEN 'RG'
					THEN @MontoMeta
				WHEN 'GM'
					THEN @MontoMeta
				END AS MontoMeta
		FROM @tablaCodigosCuv tc
		INNER JOIN ods.ProductoComercial p WITH (NOLOCK) ON tc.CampaniaID = p.CampaniaID
			AND tc.CUV = p.CUV
		LEFT JOIN ProductoComercialConfiguracion pcc WITH (NOLOCK) ON p.AnoCampania = pcc.CampaniaID
			AND p.CUV = pcc.CUV
		LEFT JOIN @OfertaProductoTemp op ON op.CampaniaID = p.CampaniaID
			AND op.CUV = p.CUV
		LEFT JOIN ods.ProductosLanzamiento pl WITH (NOLOCK) ON p.CodigoProducto = pl.CodigoSap
			AND p.AnoCampania = pl.Campania
		LEFT JOIN ProductoComercialOfertaRevista pcor WITH (NOLOCK) ON p.AnoCampania = pcor.Campania
			AND p.CUV = pcor.CUV
		LEFT JOIN ods.Marca M WITH (NOLOCK) ON p.MarcaID = M.MarcaID
		WHERE p.IndicadorDigitable = 1
			AND p.PrecioCatalogo >= ISNULL(@PrecioMinimo, 0)
			AND PrecioCatalogo >= ISNULL(@MontoFaltante, 0)
		ORDER BY tc.Orden;
	END;
END;
GO

USE BelcorpChile
GO

ALTER PROCEDURE [dbo].[GetListaProductoOfertaFinalRegaloSorpresa] (@Table1 dbo.ListaOfertaFinalType READONLY)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @CampaniaID INT
		,@CodigoConsultora VARCHAR(30)
		,@ZonaID INT
		,@CodigoRegion VARCHAR(8)
		,@CodigoZona VARCHAR(8)
		,@MontoMinPedido NUMERIC(15, 2)
		,@MontoTotal MONEY
		,@MontoEscala MONEY
		,@Algoritmo VARCHAR(10);

	SELECT @CampaniaID = CampaniaID
		,@CodigoConsultora = CodigoConsultora
		,@ZonaID = ZonaID
		,@CodigoRegion = CodigoRegion
		,@CodigoZona = CodigoZona
		,@MontoMinPedido = MontoMinimo
		,@MontoTotal = MontoTotal
		,@MontoEscala = MontoEscala
		,@Algoritmo = Algoritmo
	FROM @Table1;

	-- PASO 1 (validar parametria)
	DECLARE @CumpleParametria BIT
		,@MontoFaltante DECIMAL(18, 2)
		,@PrecioMinimo DECIMAL(18, 2)
		,@TipoMeta CHAR(2)
		,@MontoMeta DECIMAL(18, 2)
		,@GapAgregar DECIMAL(18, 2);

	SET @CumpleParametria = 0;

	IF (@MontoTotal >= @MontoMinPedido)
	BEGIN
		SELECT TOP 1 @GapAgregar = ISNULL(PrecioMinimo, 0)
		FROM OfertaFinalParametria WITH (NOLOCK)
		WHERE Tipo LIKE 'RG%'
			AND @MontoTotal BETWEEN GapMinimo AND GapMaximo
			AND Algoritmo = @Algoritmo;

		IF (@GapAgregar >= 0)
		BEGIN
			SET @TipoMeta = 'RG';
			SET @PrecioMinimo = 0;

			DECLARE @ConsultoraId INT
				,@MontoMaxPedido DECIMAL(18, 2);

			SELECT @ConsultoraId = ConsultoraId
				,@MontoMaxPedido = ISNULL(MontoMaximoPedido, 0)
			FROM ods.Consultora WITH (NOLOCK)
			WHERE Codigo = @CodigoConsultora;

			IF (@MontoTotal <= @MontoMaxPedido)
			BEGIN
				SET @CumpleParametria = 1;

				SELECT @MontoMeta = ISNULL(MontoMeta,0)
				FROM OfertaFinalMontoMeta WITH (NOLOCK)
				WHERE CampaniaId = @CampaniaID
					AND ConsultoraId = @ConsultoraId;

				--IF (ISNULL(@MontoMeta, 0) = 0)
				--    EXECUTE InsertarOfertaFinalRegaloSorpresa @CampaniaID,
				--                                              @ConsultoraId,
				--                                              @MontoTotal,
				--                                              @Algoritmo,
				--                                              @MontoMeta OUTPUT;
				IF (@MontoMeta != 0)
				BEGIN
					IF (@MontoTotal >= @MontoMeta)
					BEGIN
						SET @TipoMeta = 'GM';

						SELECT TOP 1 @PrecioMinimo = ISNULL(PrecioMinimo,0)
						FROM OfertaFinalParametria WITH (NOLOCK)
						WHERE Tipo = 'GM'
							AND Algoritmo = @Algoritmo;

						IF (@PrecioMinimo >= 0)
							SET @CumpleParametria = 1;
						ELSE
							SET @CumpleParametria = 0;
					END;
				END;
				ELSE
					SET @CumpleParametria = 1;
			END;
			ELSE
				SET @CumpleParametria = 0;
		END;
	END;
	ELSE
	BEGIN
		SET @MontoFaltante = (@MontoMinPedido - @MontoTotal);

		IF (@MontoFaltante > 0)
		BEGIN
			SELECT TOP 1 @PrecioMinimo = PrecioMinimo
				,@CumpleParametria = 1
			FROM OfertaFinalParametria WITH (NOLOCK)
			WHERE Tipo = 'MM'
				AND @MontoFaltante BETWEEN GapMinimo AND GapMaximo
				AND Algoritmo = @Algoritmo;

			SET @TipoMeta = 'MM';
		END;
	END;

	IF (@CumpleParametria = 1)
	BEGIN
		DECLARE @tablaCuvFaltante TABLE (CUV VARCHAR(6));

		-- PASO 2 (cuv faltantes y anunciadoS)
		INSERT INTO @tablaCuvFaltante
		SELECT DISTINCT LTRIM(RTRIM(CUV))
		FROM dbo.ProductoFaltante WITH (NOLOCK)
		WHERE CampaniaID = @CampaniaID
			AND ZonaID = @ZonaID
		
		UNION ALL
		
		SELECT DISTINCT LTRIM(RTRIM(fa.CodigoVenta))
		FROM ods.FaltanteAnunciado fa WITH (NOLOCK)
		INNER JOIN ods.Campania c WITH (NOLOCK) ON fa.CampaniaID = c.CampaniaID
		WHERE c.Codigo = @CampaniaID
			AND (
				RTRIM(fa.CodigoRegion) = @CodigoRegion
				OR fa.CodigoRegion IS NULL
				)
			AND (
				RTRIM(fa.CodigoZona) = @CodigoZona
				OR fa.CodigoZona IS NULL
				);

		-- PASO 3 (cuv ya comprados)
		DECLARE @tablaCuvPedido TABLE (
			CUV VARCHAR(6)
			,CodigoSap VARCHAR(30)
			);

		INSERT INTO @tablaCuvPedido
		SELECT pc.CUV
			,pc.CodigoProducto
		FROM PedidoWebDetalle pd WITH (NOLOCK)
		INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON pd.CampaniaID = pc.AnoCampania
			AND pd.CUV = pc.CUV
			AND pc.IndicadorDigitable = 1
		--AND pc.CodigoCatalago IN (9,10,13, 24)
		INNER JOIN ods.Consultora c WITH (NOLOCK) ON pd.ConsultoraID = c.ConsultoraID
		WHERE pd.CampaniaID = @CampaniaID
			AND c.Codigo = @CodigoConsultora;

		-- PASO 4 (buscar ofertas para la consultora)
		DECLARE @tablaCodigosCuv TABLE (
			CUV VARCHAR(6)
			,CodigoSap VARCHAR(12)
			,CampaniaID INT
			,Orden INT
			);

		INSERT INTO @tablaCodigosCuv
		SELECT pc.CUV
			,pc.CodigoProducto
			,pc.CampaniaID
			,op.Orden
		FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
		INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON op.AnioCampanaVenta = pc.AnoCampania
			AND op.CUV = pc.CUV
			AND op.TipoPersonalizacion = 'SR'
			AND op.CodConsultora = @CodigoConsultora
		WHERE op.AnioCampanaVenta = @CampaniaId
			AND pc.CUV NOT IN (
				SELECT CUV
				FROM @tablaCuvFaltante
				)
			AND pc.CodigoProducto NOT IN (
				SELECT CodigoSap
				FROM @tablaCuvPedido
				);

		-- PASO 5 (si no hay ofertas para la consultora buscar por la generica)
		DECLARE @cantOfertas INT = 0
			,@consultoraGenerica VARCHAR(30) = '';

		SELECT @cantOfertas = COUNT(1)
		FROM @tablaCodigosCuv;

		IF ISNULL(@cantOfertas, 0) = 0
		BEGIN
			SELECT @consultoraGenerica = Codigo
			FROM TablaLogicaDatos
			WHERE TablaLogicaDatosID = 10001;

			IF ISNULL(@consultoraGenerica,'') != ''
			BEGIN
				INSERT INTO @tablaCodigosCuv
				SELECT pc.CUV
					,pc.CodigoProducto
					,pc.CampaniaID
					,op.Orden
				FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
				INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON op.AnioCampanaVenta = pc.AnoCampania
					AND op.CUV = pc.CUV
					AND op.TipoPersonalizacion = 'SR'
					AND op.CodConsultora = @consultoraGenerica
				WHERE op.AnioCampanaVenta = @CampaniaID
					AND pc.CUV NOT IN (
						SELECT CUV
						FROM @tablaCuvFaltante
						)
					AND pc.CodigoProducto NOT IN (
						SELECT CodigoSap
						FROM @tablaCuvPedido
						);
			END;
		END;

		DECLARE @OfertaProductoTemp TABLE (
			CampaniaID INT
			,CUV VARCHAR(6)
			,ConfiguracionOfertaID INT
			,TipoOfertaSisID INT
			);

		INSERT INTO @OfertaProductoTemp
		SELECT op.CampaniaID
			,op.CUV
			,op.ConfiguracionOfertaID
			,op.TipoOfertaSisID
		FROM OfertaProducto op WITH (NOLOCK)
		INNER JOIN @tablaCodigosCuv tc ON op.CampaniaID = tc.CampaniaID
			AND op.CUV = tc.CUV;

		IF (@TipoMeta = 'GM')
			SET @MontoFaltante = 0;

		-- PASO 6 (filtrar resultados)
		SELECT DISTINCT p.CUV
			,p.Descripcion AS Descripcion
			,(p.PrecioUnitario * p.FactorRepeticion) AS PrecioCatalogo
			,p.MarcaID AS IdMarca
			,p.PrecioValorizado
			,p.PaisID
			,p.AnoCampania AS CampaniaID
			,p.CodigoCatalago
			,p.CodigoProducto AS CodigoSap
			,p.IndicadorMontoMinimo
			,p.IndicadorOferta
			,0 AS EstaEnRevista
			,ISNULL(pcc.EsExpoOferta, 0) AS EsExpoOferta
			,ISNULL(pcc.CUVRevista, '') AS CUVRevista
			,M.Nombre AS NombreMarca
			,'NO DISPONIBLE' AS DescripcionCategoria
			,'' AS CUVComplemento
			,'' AS DescripcionEstrategia
			,ISNULL(op.ConfiguracionOfertaID, 0) AS ConfiguracionOfertaID
			,ISNULL(op.TipoOfertaSisID, 0) AS TipoOfertaSisID
			,0 AS FlagNueva
			,0 AS TipoEstrategiaID
			,0 AS TieneSugerido
			,CASE 
				WHEN pl.CodigoSap IS NULL
					THEN 0
				ELSE 1
				END AS TieneLanzamientoCatalogoPersonalizado
			,CASE 
				WHEN pcor.SAP IS NULL
					THEN 0
				ELSE 1
				END AS TieneOfertaRevista
			,ISNULL(pcor.Oferta, '') AS TipoOfertaRevista
			,tc.Orden
			,@TipoMeta AS TipoMeta
			,CASE @TipoMeta
				WHEN 'MM'
					THEN @MontoFaltante
				WHEN 'RG'
					THEN @MontoMeta
				WHEN 'GM'
					THEN @MontoMeta
				END AS MontoMeta
		FROM @tablaCodigosCuv tc
		INNER JOIN ods.ProductoComercial p WITH (NOLOCK) ON tc.CampaniaID = p.CampaniaID
			AND tc.CUV = p.CUV
		LEFT JOIN ProductoComercialConfiguracion pcc WITH (NOLOCK) ON p.AnoCampania = pcc.CampaniaID
			AND p.CUV = pcc.CUV
		LEFT JOIN @OfertaProductoTemp op ON op.CampaniaID = p.CampaniaID
			AND op.CUV = p.CUV
		LEFT JOIN ods.ProductosLanzamiento pl WITH (NOLOCK) ON p.CodigoProducto = pl.CodigoSap
			AND p.AnoCampania = pl.Campania
		LEFT JOIN ProductoComercialOfertaRevista pcor WITH (NOLOCK) ON p.AnoCampania = pcor.Campania
			AND p.CUV = pcor.CUV
		LEFT JOIN ods.Marca M WITH (NOLOCK) ON p.MarcaID = M.MarcaID
		WHERE p.IndicadorDigitable = 1
			AND p.PrecioCatalogo >= ISNULL(@PrecioMinimo, 0)
			AND PrecioCatalogo >= ISNULL(@MontoFaltante, 0)
		ORDER BY tc.Orden;
	END;
END;
GO

USE BelcorpColombia
GO

ALTER PROCEDURE [dbo].[GetListaProductoOfertaFinalRegaloSorpresa] (@Table1 dbo.ListaOfertaFinalType READONLY)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @CampaniaID INT
		,@CodigoConsultora VARCHAR(30)
		,@ZonaID INT
		,@CodigoRegion VARCHAR(8)
		,@CodigoZona VARCHAR(8)
		,@MontoMinPedido NUMERIC(15, 2)
		,@MontoTotal MONEY
		,@MontoEscala MONEY
		,@Algoritmo VARCHAR(10);

	SELECT @CampaniaID = CampaniaID
		,@CodigoConsultora = CodigoConsultora
		,@ZonaID = ZonaID
		,@CodigoRegion = CodigoRegion
		,@CodigoZona = CodigoZona
		,@MontoMinPedido = MontoMinimo
		,@MontoTotal = MontoTotal
		,@MontoEscala = MontoEscala
		,@Algoritmo = Algoritmo
	FROM @Table1;

	-- PASO 1 (validar parametria)
	DECLARE @CumpleParametria BIT
		,@MontoFaltante DECIMAL(18, 2)
		,@PrecioMinimo DECIMAL(18, 2)
		,@TipoMeta CHAR(2)
		,@MontoMeta DECIMAL(18, 2)
		,@GapAgregar DECIMAL(18, 2);

	SET @CumpleParametria = 0;

	IF (@MontoTotal >= @MontoMinPedido)
	BEGIN
		SELECT TOP 1 @GapAgregar = ISNULL(PrecioMinimo, 0)
		FROM OfertaFinalParametria WITH (NOLOCK)
		WHERE Tipo LIKE 'RG%'
			AND @MontoTotal BETWEEN GapMinimo AND GapMaximo
			AND Algoritmo = @Algoritmo;

		IF (@GapAgregar >= 0)
		BEGIN
			SET @TipoMeta = 'RG';
			SET @PrecioMinimo = 0;

			DECLARE @ConsultoraId INT
				,@MontoMaxPedido DECIMAL(18, 2);

			SELECT @ConsultoraId = ConsultoraId
				,@MontoMaxPedido = ISNULL(MontoMaximoPedido, 0)
			FROM ods.Consultora WITH (NOLOCK)
			WHERE Codigo = @CodigoConsultora;

			IF (@MontoTotal <= @MontoMaxPedido)
			BEGIN
				SET @CumpleParametria = 1;

				SELECT @MontoMeta = ISNULL(MontoMeta,0)
				FROM OfertaFinalMontoMeta WITH (NOLOCK)
				WHERE CampaniaId = @CampaniaID
					AND ConsultoraId = @ConsultoraId;

				--IF (ISNULL(@MontoMeta, 0) = 0)
				--    EXECUTE InsertarOfertaFinalRegaloSorpresa @CampaniaID,
				--                                              @ConsultoraId,
				--                                              @MontoTotal,
				--                                              @Algoritmo,
				--                                              @MontoMeta OUTPUT;
				IF (@MontoMeta != 0)
				BEGIN
					IF (@MontoTotal >= @MontoMeta)
					BEGIN
						SET @TipoMeta = 'GM';

						SELECT TOP 1 @PrecioMinimo = ISNULL(PrecioMinimo,0)
						FROM OfertaFinalParametria WITH (NOLOCK)
						WHERE Tipo = 'GM'
							AND Algoritmo = @Algoritmo;

						IF (@PrecioMinimo >= 0)
							SET @CumpleParametria = 1;
						ELSE
							SET @CumpleParametria = 0;
					END;
				END;
				ELSE
					SET @CumpleParametria = 1;
			END;
			ELSE
				SET @CumpleParametria = 0;
		END;
	END;
	ELSE
	BEGIN
		SET @MontoFaltante = (@MontoMinPedido - @MontoTotal);

		IF (@MontoFaltante > 0)
		BEGIN
			SELECT TOP 1 @PrecioMinimo = PrecioMinimo
				,@CumpleParametria = 1
			FROM OfertaFinalParametria WITH (NOLOCK)
			WHERE Tipo = 'MM'
				AND @MontoFaltante BETWEEN GapMinimo AND GapMaximo
				AND Algoritmo = @Algoritmo;

			SET @TipoMeta = 'MM';
		END;
	END;

	IF (@CumpleParametria = 1)
	BEGIN
		DECLARE @tablaCuvFaltante TABLE (CUV VARCHAR(6));

		-- PASO 2 (cuv faltantes y anunciadoS)
		INSERT INTO @tablaCuvFaltante
		SELECT DISTINCT LTRIM(RTRIM(CUV))
		FROM dbo.ProductoFaltante WITH (NOLOCK)
		WHERE CampaniaID = @CampaniaID
			AND ZonaID = @ZonaID
		
		UNION ALL
		
		SELECT DISTINCT LTRIM(RTRIM(fa.CodigoVenta))
		FROM ods.FaltanteAnunciado fa WITH (NOLOCK)
		INNER JOIN ods.Campania c WITH (NOLOCK) ON fa.CampaniaID = c.CampaniaID
		WHERE c.Codigo = @CampaniaID
			AND (
				RTRIM(fa.CodigoRegion) = @CodigoRegion
				OR fa.CodigoRegion IS NULL
				)
			AND (
				RTRIM(fa.CodigoZona) = @CodigoZona
				OR fa.CodigoZona IS NULL
				);

		-- PASO 3 (cuv ya comprados)
		DECLARE @tablaCuvPedido TABLE (
			CUV VARCHAR(6)
			,CodigoSap VARCHAR(30)
			);

		INSERT INTO @tablaCuvPedido
		SELECT pc.CUV
			,pc.CodigoProducto
		FROM PedidoWebDetalle pd WITH (NOLOCK)
		INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON pd.CampaniaID = pc.AnoCampania
			AND pd.CUV = pc.CUV
			AND pc.IndicadorDigitable = 1
		--AND pc.CodigoCatalago IN (9,10,13, 24)
		INNER JOIN ods.Consultora c WITH (NOLOCK) ON pd.ConsultoraID = c.ConsultoraID
		WHERE pd.CampaniaID = @CampaniaID
			AND c.Codigo = @CodigoConsultora;

		-- PASO 4 (buscar ofertas para la consultora)
		DECLARE @tablaCodigosCuv TABLE (
			CUV VARCHAR(6)
			,CodigoSap VARCHAR(12)
			,CampaniaID INT
			,Orden INT
			);

		INSERT INTO @tablaCodigosCuv
		SELECT pc.CUV
			,pc.CodigoProducto
			,pc.CampaniaID
			,op.Orden
		FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
		INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON op.AnioCampanaVenta = pc.AnoCampania
			AND op.CUV = pc.CUV
			AND op.TipoPersonalizacion = 'SR'
			AND op.CodConsultora = @CodigoConsultora
		WHERE op.AnioCampanaVenta = @CampaniaId
			AND pc.CUV NOT IN (
				SELECT CUV
				FROM @tablaCuvFaltante
				)
			AND pc.CodigoProducto NOT IN (
				SELECT CodigoSap
				FROM @tablaCuvPedido
				);

		-- PASO 5 (si no hay ofertas para la consultora buscar por la generica)
		DECLARE @cantOfertas INT = 0
			,@consultoraGenerica VARCHAR(30) = '';

		SELECT @cantOfertas = COUNT(1)
		FROM @tablaCodigosCuv;

		IF ISNULL(@cantOfertas, 0) = 0
		BEGIN
			SELECT @consultoraGenerica = Codigo
			FROM TablaLogicaDatos
			WHERE TablaLogicaDatosID = 10001;

			IF ISNULL(@consultoraGenerica,'') != ''
			BEGIN
				INSERT INTO @tablaCodigosCuv
				SELECT pc.CUV
					,pc.CodigoProducto
					,pc.CampaniaID
					,op.Orden
				FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
				INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON op.AnioCampanaVenta = pc.AnoCampania
					AND op.CUV = pc.CUV
					AND op.TipoPersonalizacion = 'SR'
					AND op.CodConsultora = @consultoraGenerica
				WHERE op.AnioCampanaVenta = @CampaniaID
					AND pc.CUV NOT IN (
						SELECT CUV
						FROM @tablaCuvFaltante
						)
					AND pc.CodigoProducto NOT IN (
						SELECT CodigoSap
						FROM @tablaCuvPedido
						);
			END;
		END;

		DECLARE @OfertaProductoTemp TABLE (
			CampaniaID INT
			,CUV VARCHAR(6)
			,ConfiguracionOfertaID INT
			,TipoOfertaSisID INT
			);

		INSERT INTO @OfertaProductoTemp
		SELECT op.CampaniaID
			,op.CUV
			,op.ConfiguracionOfertaID
			,op.TipoOfertaSisID
		FROM OfertaProducto op WITH (NOLOCK)
		INNER JOIN @tablaCodigosCuv tc ON op.CampaniaID = tc.CampaniaID
			AND op.CUV = tc.CUV;

		IF (@TipoMeta = 'GM')
			SET @MontoFaltante = 0;

		-- PASO 6 (filtrar resultados)
		SELECT DISTINCT p.CUV
			,p.Descripcion AS Descripcion
			,(p.PrecioUnitario * p.FactorRepeticion) AS PrecioCatalogo
			,p.MarcaID AS IdMarca
			,p.PrecioValorizado
			,p.PaisID
			,p.AnoCampania AS CampaniaID
			,p.CodigoCatalago
			,p.CodigoProducto AS CodigoSap
			,p.IndicadorMontoMinimo
			,p.IndicadorOferta
			,0 AS EstaEnRevista
			,ISNULL(pcc.EsExpoOferta, 0) AS EsExpoOferta
			,ISNULL(pcc.CUVRevista, '') AS CUVRevista
			,M.Nombre AS NombreMarca
			,'NO DISPONIBLE' AS DescripcionCategoria
			,'' AS CUVComplemento
			,'' AS DescripcionEstrategia
			,ISNULL(op.ConfiguracionOfertaID, 0) AS ConfiguracionOfertaID
			,ISNULL(op.TipoOfertaSisID, 0) AS TipoOfertaSisID
			,0 AS FlagNueva
			,0 AS TipoEstrategiaID
			,0 AS TieneSugerido
			,CASE 
				WHEN pl.CodigoSap IS NULL
					THEN 0
				ELSE 1
				END AS TieneLanzamientoCatalogoPersonalizado
			,CASE 
				WHEN pcor.SAP IS NULL
					THEN 0
				ELSE 1
				END AS TieneOfertaRevista
			,ISNULL(pcor.Oferta, '') AS TipoOfertaRevista
			,tc.Orden
			,@TipoMeta AS TipoMeta
			,CASE @TipoMeta
				WHEN 'MM'
					THEN @MontoFaltante
				WHEN 'RG'
					THEN @MontoMeta
				WHEN 'GM'
					THEN @MontoMeta
				END AS MontoMeta
		FROM @tablaCodigosCuv tc
		INNER JOIN ods.ProductoComercial p WITH (NOLOCK) ON tc.CampaniaID = p.CampaniaID
			AND tc.CUV = p.CUV
		LEFT JOIN ProductoComercialConfiguracion pcc WITH (NOLOCK) ON p.AnoCampania = pcc.CampaniaID
			AND p.CUV = pcc.CUV
		LEFT JOIN @OfertaProductoTemp op ON op.CampaniaID = p.CampaniaID
			AND op.CUV = p.CUV
		LEFT JOIN ods.ProductosLanzamiento pl WITH (NOLOCK) ON p.CodigoProducto = pl.CodigoSap
			AND p.AnoCampania = pl.Campania
		LEFT JOIN ProductoComercialOfertaRevista pcor WITH (NOLOCK) ON p.AnoCampania = pcor.Campania
			AND p.CUV = pcor.CUV
		LEFT JOIN ods.Marca M WITH (NOLOCK) ON p.MarcaID = M.MarcaID
		WHERE p.IndicadorDigitable = 1
			AND p.PrecioCatalogo >= ISNULL(@PrecioMinimo, 0)
			AND PrecioCatalogo >= ISNULL(@MontoFaltante, 0)
		ORDER BY tc.Orden;
	END;
END;
GO

USE BelcorpCostaRica
GO

ALTER PROCEDURE [dbo].[GetListaProductoOfertaFinalRegaloSorpresa] (@Table1 dbo.ListaOfertaFinalType READONLY)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @CampaniaID INT
		,@CodigoConsultora VARCHAR(30)
		,@ZonaID INT
		,@CodigoRegion VARCHAR(8)
		,@CodigoZona VARCHAR(8)
		,@MontoMinPedido NUMERIC(15, 2)
		,@MontoTotal MONEY
		,@MontoEscala MONEY
		,@Algoritmo VARCHAR(10);

	SELECT @CampaniaID = CampaniaID
		,@CodigoConsultora = CodigoConsultora
		,@ZonaID = ZonaID
		,@CodigoRegion = CodigoRegion
		,@CodigoZona = CodigoZona
		,@MontoMinPedido = MontoMinimo
		,@MontoTotal = MontoTotal
		,@MontoEscala = MontoEscala
		,@Algoritmo = Algoritmo
	FROM @Table1;

	-- PASO 1 (validar parametria)
	DECLARE @CumpleParametria BIT
		,@MontoFaltante DECIMAL(18, 2)
		,@PrecioMinimo DECIMAL(18, 2)
		,@TipoMeta CHAR(2)
		,@MontoMeta DECIMAL(18, 2)
		,@GapAgregar DECIMAL(18, 2);

	SET @CumpleParametria = 0;

	IF (@MontoTotal >= @MontoMinPedido)
	BEGIN
		SELECT TOP 1 @GapAgregar = ISNULL(PrecioMinimo, 0)
		FROM OfertaFinalParametria WITH (NOLOCK)
		WHERE Tipo LIKE 'RG%'
			AND @MontoTotal BETWEEN GapMinimo AND GapMaximo
			AND Algoritmo = @Algoritmo;

		IF (@GapAgregar >= 0)
		BEGIN
			SET @TipoMeta = 'RG';
			SET @PrecioMinimo = 0;

			DECLARE @ConsultoraId INT
				,@MontoMaxPedido DECIMAL(18, 2);

			SELECT @ConsultoraId = ConsultoraId
				,@MontoMaxPedido = ISNULL(MontoMaximoPedido, 0)
			FROM ods.Consultora WITH (NOLOCK)
			WHERE Codigo = @CodigoConsultora;

			IF (@MontoTotal <= @MontoMaxPedido)
			BEGIN
				SET @CumpleParametria = 1;

				SELECT @MontoMeta = ISNULL(MontoMeta,0)
				FROM OfertaFinalMontoMeta WITH (NOLOCK)
				WHERE CampaniaId = @CampaniaID
					AND ConsultoraId = @ConsultoraId;

				--IF (ISNULL(@MontoMeta, 0) = 0)
				--    EXECUTE InsertarOfertaFinalRegaloSorpresa @CampaniaID,
				--                                              @ConsultoraId,
				--                                              @MontoTotal,
				--                                              @Algoritmo,
				--                                              @MontoMeta OUTPUT;
				IF (@MontoMeta != 0)
				BEGIN
					IF (@MontoTotal >= @MontoMeta)
					BEGIN
						SET @TipoMeta = 'GM';

						SELECT TOP 1 @PrecioMinimo = ISNULL(PrecioMinimo,0)
						FROM OfertaFinalParametria WITH (NOLOCK)
						WHERE Tipo = 'GM'
							AND Algoritmo = @Algoritmo;

						IF (@PrecioMinimo >= 0)
							SET @CumpleParametria = 1;
						ELSE
							SET @CumpleParametria = 0;
					END;
				END;
				ELSE
					SET @CumpleParametria = 1;
			END;
			ELSE
				SET @CumpleParametria = 0;
		END;
	END;
	ELSE
	BEGIN
		SET @MontoFaltante = (@MontoMinPedido - @MontoTotal);

		IF (@MontoFaltante > 0)
		BEGIN
			SELECT TOP 1 @PrecioMinimo = PrecioMinimo
				,@CumpleParametria = 1
			FROM OfertaFinalParametria WITH (NOLOCK)
			WHERE Tipo = 'MM'
				AND @MontoFaltante BETWEEN GapMinimo AND GapMaximo
				AND Algoritmo = @Algoritmo;

			SET @TipoMeta = 'MM';
		END;
	END;

	IF (@CumpleParametria = 1)
	BEGIN
		DECLARE @tablaCuvFaltante TABLE (CUV VARCHAR(6));

		-- PASO 2 (cuv faltantes y anunciadoS)
		INSERT INTO @tablaCuvFaltante
		SELECT DISTINCT LTRIM(RTRIM(CUV))
		FROM dbo.ProductoFaltante WITH (NOLOCK)
		WHERE CampaniaID = @CampaniaID
			AND ZonaID = @ZonaID
		
		UNION ALL
		
		SELECT DISTINCT LTRIM(RTRIM(fa.CodigoVenta))
		FROM ods.FaltanteAnunciado fa WITH (NOLOCK)
		INNER JOIN ods.Campania c WITH (NOLOCK) ON fa.CampaniaID = c.CampaniaID
		WHERE c.Codigo = @CampaniaID
			AND (
				RTRIM(fa.CodigoRegion) = @CodigoRegion
				OR fa.CodigoRegion IS NULL
				)
			AND (
				RTRIM(fa.CodigoZona) = @CodigoZona
				OR fa.CodigoZona IS NULL
				);

		-- PASO 3 (cuv ya comprados)
		DECLARE @tablaCuvPedido TABLE (
			CUV VARCHAR(6)
			,CodigoSap VARCHAR(30)
			);

		INSERT INTO @tablaCuvPedido
		SELECT pc.CUV
			,pc.CodigoProducto
		FROM PedidoWebDetalle pd WITH (NOLOCK)
		INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON pd.CampaniaID = pc.AnoCampania
			AND pd.CUV = pc.CUV
			AND pc.IndicadorDigitable = 1
		--AND pc.CodigoCatalago IN (9,10,13, 24)
		INNER JOIN ods.Consultora c WITH (NOLOCK) ON pd.ConsultoraID = c.ConsultoraID
		WHERE pd.CampaniaID = @CampaniaID
			AND c.Codigo = @CodigoConsultora;

		-- PASO 4 (buscar ofertas para la consultora)
		DECLARE @tablaCodigosCuv TABLE (
			CUV VARCHAR(6)
			,CodigoSap VARCHAR(12)
			,CampaniaID INT
			,Orden INT
			);

		INSERT INTO @tablaCodigosCuv
		SELECT pc.CUV
			,pc.CodigoProducto
			,pc.CampaniaID
			,op.Orden
		FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
		INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON op.AnioCampanaVenta = pc.AnoCampania
			AND op.CUV = pc.CUV
			AND op.TipoPersonalizacion = 'SR'
			AND op.CodConsultora = @CodigoConsultora
		WHERE op.AnioCampanaVenta = @CampaniaId
			AND pc.CUV NOT IN (
				SELECT CUV
				FROM @tablaCuvFaltante
				)
			AND pc.CodigoProducto NOT IN (
				SELECT CodigoSap
				FROM @tablaCuvPedido
				);

		-- PASO 5 (si no hay ofertas para la consultora buscar por la generica)
		DECLARE @cantOfertas INT = 0
			,@consultoraGenerica VARCHAR(30) = '';

		SELECT @cantOfertas = COUNT(1)
		FROM @tablaCodigosCuv;

		IF ISNULL(@cantOfertas, 0) = 0
		BEGIN
			SELECT @consultoraGenerica = Codigo
			FROM TablaLogicaDatos
			WHERE TablaLogicaDatosID = 10001;

			IF ISNULL(@consultoraGenerica,'') != ''
			BEGIN
				INSERT INTO @tablaCodigosCuv
				SELECT pc.CUV
					,pc.CodigoProducto
					,pc.CampaniaID
					,op.Orden
				FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
				INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON op.AnioCampanaVenta = pc.AnoCampania
					AND op.CUV = pc.CUV
					AND op.TipoPersonalizacion = 'SR'
					AND op.CodConsultora = @consultoraGenerica
				WHERE op.AnioCampanaVenta = @CampaniaID
					AND pc.CUV NOT IN (
						SELECT CUV
						FROM @tablaCuvFaltante
						)
					AND pc.CodigoProducto NOT IN (
						SELECT CodigoSap
						FROM @tablaCuvPedido
						);
			END;
		END;

		DECLARE @OfertaProductoTemp TABLE (
			CampaniaID INT
			,CUV VARCHAR(6)
			,ConfiguracionOfertaID INT
			,TipoOfertaSisID INT
			);

		INSERT INTO @OfertaProductoTemp
		SELECT op.CampaniaID
			,op.CUV
			,op.ConfiguracionOfertaID
			,op.TipoOfertaSisID
		FROM OfertaProducto op WITH (NOLOCK)
		INNER JOIN @tablaCodigosCuv tc ON op.CampaniaID = tc.CampaniaID
			AND op.CUV = tc.CUV;

		IF (@TipoMeta = 'GM')
			SET @MontoFaltante = 0;

		-- PASO 6 (filtrar resultados)
		SELECT DISTINCT p.CUV
			,p.Descripcion AS Descripcion
			,(p.PrecioUnitario * p.FactorRepeticion) AS PrecioCatalogo
			,p.MarcaID AS IdMarca
			,p.PrecioValorizado
			,p.PaisID
			,p.AnoCampania AS CampaniaID
			,p.CodigoCatalago
			,p.CodigoProducto AS CodigoSap
			,p.IndicadorMontoMinimo
			,p.IndicadorOferta
			,0 AS EstaEnRevista
			,ISNULL(pcc.EsExpoOferta, 0) AS EsExpoOferta
			,ISNULL(pcc.CUVRevista, '') AS CUVRevista
			,M.Nombre AS NombreMarca
			,'NO DISPONIBLE' AS DescripcionCategoria
			,'' AS CUVComplemento
			,'' AS DescripcionEstrategia
			,ISNULL(op.ConfiguracionOfertaID, 0) AS ConfiguracionOfertaID
			,ISNULL(op.TipoOfertaSisID, 0) AS TipoOfertaSisID
			,0 AS FlagNueva
			,0 AS TipoEstrategiaID
			,0 AS TieneSugerido
			,CASE 
				WHEN pl.CodigoSap IS NULL
					THEN 0
				ELSE 1
				END AS TieneLanzamientoCatalogoPersonalizado
			,CASE 
				WHEN pcor.SAP IS NULL
					THEN 0
				ELSE 1
				END AS TieneOfertaRevista
			,ISNULL(pcor.Oferta, '') AS TipoOfertaRevista
			,tc.Orden
			,@TipoMeta AS TipoMeta
			,CASE @TipoMeta
				WHEN 'MM'
					THEN @MontoFaltante
				WHEN 'RG'
					THEN @MontoMeta
				WHEN 'GM'
					THEN @MontoMeta
				END AS MontoMeta
		FROM @tablaCodigosCuv tc
		INNER JOIN ods.ProductoComercial p WITH (NOLOCK) ON tc.CampaniaID = p.CampaniaID
			AND tc.CUV = p.CUV
		LEFT JOIN ProductoComercialConfiguracion pcc WITH (NOLOCK) ON p.AnoCampania = pcc.CampaniaID
			AND p.CUV = pcc.CUV
		LEFT JOIN @OfertaProductoTemp op ON op.CampaniaID = p.CampaniaID
			AND op.CUV = p.CUV
		LEFT JOIN ods.ProductosLanzamiento pl WITH (NOLOCK) ON p.CodigoProducto = pl.CodigoSap
			AND p.AnoCampania = pl.Campania
		LEFT JOIN ProductoComercialOfertaRevista pcor WITH (NOLOCK) ON p.AnoCampania = pcor.Campania
			AND p.CUV = pcor.CUV
		LEFT JOIN ods.Marca M WITH (NOLOCK) ON p.MarcaID = M.MarcaID
		WHERE p.IndicadorDigitable = 1
			AND p.PrecioCatalogo >= ISNULL(@PrecioMinimo, 0)
			AND PrecioCatalogo >= ISNULL(@MontoFaltante, 0)
		ORDER BY tc.Orden;
	END;
END;
GO

USE BelcorpDominicana
GO

ALTER PROCEDURE [dbo].[GetListaProductoOfertaFinalRegaloSorpresa] (@Table1 dbo.ListaOfertaFinalType READONLY)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @CampaniaID INT
		,@CodigoConsultora VARCHAR(30)
		,@ZonaID INT
		,@CodigoRegion VARCHAR(8)
		,@CodigoZona VARCHAR(8)
		,@MontoMinPedido NUMERIC(15, 2)
		,@MontoTotal MONEY
		,@MontoEscala MONEY
		,@Algoritmo VARCHAR(10);

	SELECT @CampaniaID = CampaniaID
		,@CodigoConsultora = CodigoConsultora
		,@ZonaID = ZonaID
		,@CodigoRegion = CodigoRegion
		,@CodigoZona = CodigoZona
		,@MontoMinPedido = MontoMinimo
		,@MontoTotal = MontoTotal
		,@MontoEscala = MontoEscala
		,@Algoritmo = Algoritmo
	FROM @Table1;

	-- PASO 1 (validar parametria)
	DECLARE @CumpleParametria BIT
		,@MontoFaltante DECIMAL(18, 2)
		,@PrecioMinimo DECIMAL(18, 2)
		,@TipoMeta CHAR(2)
		,@MontoMeta DECIMAL(18, 2)
		,@GapAgregar DECIMAL(18, 2);

	SET @CumpleParametria = 0;

	IF (@MontoTotal >= @MontoMinPedido)
	BEGIN
		SELECT TOP 1 @GapAgregar = ISNULL(PrecioMinimo, 0)
		FROM OfertaFinalParametria WITH (NOLOCK)
		WHERE Tipo LIKE 'RG%'
			AND @MontoTotal BETWEEN GapMinimo AND GapMaximo
			AND Algoritmo = @Algoritmo;

		IF (@GapAgregar >= 0)
		BEGIN
			SET @TipoMeta = 'RG';
			SET @PrecioMinimo = 0;

			DECLARE @ConsultoraId INT
				,@MontoMaxPedido DECIMAL(18, 2);

			SELECT @ConsultoraId = ConsultoraId
				,@MontoMaxPedido = ISNULL(MontoMaximoPedido, 0)
			FROM ods.Consultora WITH (NOLOCK)
			WHERE Codigo = @CodigoConsultora;

			IF (@MontoTotal <= @MontoMaxPedido)
			BEGIN
				SET @CumpleParametria = 1;

				SELECT @MontoMeta = ISNULL(MontoMeta,0)
				FROM OfertaFinalMontoMeta WITH (NOLOCK)
				WHERE CampaniaId = @CampaniaID
					AND ConsultoraId = @ConsultoraId;

				--IF (ISNULL(@MontoMeta, 0) = 0)
				--    EXECUTE InsertarOfertaFinalRegaloSorpresa @CampaniaID,
				--                                              @ConsultoraId,
				--                                              @MontoTotal,
				--                                              @Algoritmo,
				--                                              @MontoMeta OUTPUT;
				IF (@MontoMeta != 0)
				BEGIN
					IF (@MontoTotal >= @MontoMeta)
					BEGIN
						SET @TipoMeta = 'GM';

						SELECT TOP 1 @PrecioMinimo = ISNULL(PrecioMinimo,0)
						FROM OfertaFinalParametria WITH (NOLOCK)
						WHERE Tipo = 'GM'
							AND Algoritmo = @Algoritmo;

						IF (@PrecioMinimo >= 0)
							SET @CumpleParametria = 1;
						ELSE
							SET @CumpleParametria = 0;
					END;
				END;
				ELSE
					SET @CumpleParametria = 1;
			END;
			ELSE
				SET @CumpleParametria = 0;
		END;
	END;
	ELSE
	BEGIN
		SET @MontoFaltante = (@MontoMinPedido - @MontoTotal);

		IF (@MontoFaltante > 0)
		BEGIN
			SELECT TOP 1 @PrecioMinimo = PrecioMinimo
				,@CumpleParametria = 1
			FROM OfertaFinalParametria WITH (NOLOCK)
			WHERE Tipo = 'MM'
				AND @MontoFaltante BETWEEN GapMinimo AND GapMaximo
				AND Algoritmo = @Algoritmo;

			SET @TipoMeta = 'MM';
		END;
	END;

	IF (@CumpleParametria = 1)
	BEGIN
		DECLARE @tablaCuvFaltante TABLE (CUV VARCHAR(6));

		-- PASO 2 (cuv faltantes y anunciadoS)
		INSERT INTO @tablaCuvFaltante
		SELECT DISTINCT LTRIM(RTRIM(CUV))
		FROM dbo.ProductoFaltante WITH (NOLOCK)
		WHERE CampaniaID = @CampaniaID
			AND ZonaID = @ZonaID
		
		UNION ALL
		
		SELECT DISTINCT LTRIM(RTRIM(fa.CodigoVenta))
		FROM ods.FaltanteAnunciado fa WITH (NOLOCK)
		INNER JOIN ods.Campania c WITH (NOLOCK) ON fa.CampaniaID = c.CampaniaID
		WHERE c.Codigo = @CampaniaID
			AND (
				RTRIM(fa.CodigoRegion) = @CodigoRegion
				OR fa.CodigoRegion IS NULL
				)
			AND (
				RTRIM(fa.CodigoZona) = @CodigoZona
				OR fa.CodigoZona IS NULL
				);

		-- PASO 3 (cuv ya comprados)
		DECLARE @tablaCuvPedido TABLE (
			CUV VARCHAR(6)
			,CodigoSap VARCHAR(30)
			);

		INSERT INTO @tablaCuvPedido
		SELECT pc.CUV
			,pc.CodigoProducto
		FROM PedidoWebDetalle pd WITH (NOLOCK)
		INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON pd.CampaniaID = pc.AnoCampania
			AND pd.CUV = pc.CUV
			AND pc.IndicadorDigitable = 1
		--AND pc.CodigoCatalago IN (9,10,13, 24)
		INNER JOIN ods.Consultora c WITH (NOLOCK) ON pd.ConsultoraID = c.ConsultoraID
		WHERE pd.CampaniaID = @CampaniaID
			AND c.Codigo = @CodigoConsultora;

		-- PASO 4 (buscar ofertas para la consultora)
		DECLARE @tablaCodigosCuv TABLE (
			CUV VARCHAR(6)
			,CodigoSap VARCHAR(12)
			,CampaniaID INT
			,Orden INT
			);

		INSERT INTO @tablaCodigosCuv
		SELECT pc.CUV
			,pc.CodigoProducto
			,pc.CampaniaID
			,op.Orden
		FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
		INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON op.AnioCampanaVenta = pc.AnoCampania
			AND op.CUV = pc.CUV
			AND op.TipoPersonalizacion = 'SR'
			AND op.CodConsultora = @CodigoConsultora
		WHERE op.AnioCampanaVenta = @CampaniaId
			AND pc.CUV NOT IN (
				SELECT CUV
				FROM @tablaCuvFaltante
				)
			AND pc.CodigoProducto NOT IN (
				SELECT CodigoSap
				FROM @tablaCuvPedido
				);

		-- PASO 5 (si no hay ofertas para la consultora buscar por la generica)
		DECLARE @cantOfertas INT = 0
			,@consultoraGenerica VARCHAR(30) = '';

		SELECT @cantOfertas = COUNT(1)
		FROM @tablaCodigosCuv;

		IF ISNULL(@cantOfertas, 0) = 0
		BEGIN
			SELECT @consultoraGenerica = Codigo
			FROM TablaLogicaDatos
			WHERE TablaLogicaDatosID = 10001;

			IF ISNULL(@consultoraGenerica,'') != ''
			BEGIN
				INSERT INTO @tablaCodigosCuv
				SELECT pc.CUV
					,pc.CodigoProducto
					,pc.CampaniaID
					,op.Orden
				FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
				INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON op.AnioCampanaVenta = pc.AnoCampania
					AND op.CUV = pc.CUV
					AND op.TipoPersonalizacion = 'SR'
					AND op.CodConsultora = @consultoraGenerica
				WHERE op.AnioCampanaVenta = @CampaniaID
					AND pc.CUV NOT IN (
						SELECT CUV
						FROM @tablaCuvFaltante
						)
					AND pc.CodigoProducto NOT IN (
						SELECT CodigoSap
						FROM @tablaCuvPedido
						);
			END;
		END;

		DECLARE @OfertaProductoTemp TABLE (
			CampaniaID INT
			,CUV VARCHAR(6)
			,ConfiguracionOfertaID INT
			,TipoOfertaSisID INT
			);

		INSERT INTO @OfertaProductoTemp
		SELECT op.CampaniaID
			,op.CUV
			,op.ConfiguracionOfertaID
			,op.TipoOfertaSisID
		FROM OfertaProducto op WITH (NOLOCK)
		INNER JOIN @tablaCodigosCuv tc ON op.CampaniaID = tc.CampaniaID
			AND op.CUV = tc.CUV;

		IF (@TipoMeta = 'GM')
			SET @MontoFaltante = 0;

		-- PASO 6 (filtrar resultados)
		SELECT DISTINCT p.CUV
			,p.Descripcion AS Descripcion
			,(p.PrecioUnitario * p.FactorRepeticion) AS PrecioCatalogo
			,p.MarcaID AS IdMarca
			,p.PrecioValorizado
			,p.PaisID
			,p.AnoCampania AS CampaniaID
			,p.CodigoCatalago
			,p.CodigoProducto AS CodigoSap
			,p.IndicadorMontoMinimo
			,p.IndicadorOferta
			,0 AS EstaEnRevista
			,ISNULL(pcc.EsExpoOferta, 0) AS EsExpoOferta
			,ISNULL(pcc.CUVRevista, '') AS CUVRevista
			,M.Nombre AS NombreMarca
			,'NO DISPONIBLE' AS DescripcionCategoria
			,'' AS CUVComplemento
			,'' AS DescripcionEstrategia
			,ISNULL(op.ConfiguracionOfertaID, 0) AS ConfiguracionOfertaID
			,ISNULL(op.TipoOfertaSisID, 0) AS TipoOfertaSisID
			,0 AS FlagNueva
			,0 AS TipoEstrategiaID
			,0 AS TieneSugerido
			,CASE 
				WHEN pl.CodigoSap IS NULL
					THEN 0
				ELSE 1
				END AS TieneLanzamientoCatalogoPersonalizado
			,CASE 
				WHEN pcor.SAP IS NULL
					THEN 0
				ELSE 1
				END AS TieneOfertaRevista
			,ISNULL(pcor.Oferta, '') AS TipoOfertaRevista
			,tc.Orden
			,@TipoMeta AS TipoMeta
			,CASE @TipoMeta
				WHEN 'MM'
					THEN @MontoFaltante
				WHEN 'RG'
					THEN @MontoMeta
				WHEN 'GM'
					THEN @MontoMeta
				END AS MontoMeta
		FROM @tablaCodigosCuv tc
		INNER JOIN ods.ProductoComercial p WITH (NOLOCK) ON tc.CampaniaID = p.CampaniaID
			AND tc.CUV = p.CUV
		LEFT JOIN ProductoComercialConfiguracion pcc WITH (NOLOCK) ON p.AnoCampania = pcc.CampaniaID
			AND p.CUV = pcc.CUV
		LEFT JOIN @OfertaProductoTemp op ON op.CampaniaID = p.CampaniaID
			AND op.CUV = p.CUV
		LEFT JOIN ods.ProductosLanzamiento pl WITH (NOLOCK) ON p.CodigoProducto = pl.CodigoSap
			AND p.AnoCampania = pl.Campania
		LEFT JOIN ProductoComercialOfertaRevista pcor WITH (NOLOCK) ON p.AnoCampania = pcor.Campania
			AND p.CUV = pcor.CUV
		LEFT JOIN ods.Marca M WITH (NOLOCK) ON p.MarcaID = M.MarcaID
		WHERE p.IndicadorDigitable = 1
			AND p.PrecioCatalogo >= ISNULL(@PrecioMinimo, 0)
			AND PrecioCatalogo >= ISNULL(@MontoFaltante, 0)
		ORDER BY tc.Orden;
	END;
END;
GO

USE BelcorpEcuador
GO

ALTER PROCEDURE [dbo].[GetListaProductoOfertaFinalRegaloSorpresa] (@Table1 dbo.ListaOfertaFinalType READONLY)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @CampaniaID INT
		,@CodigoConsultora VARCHAR(30)
		,@ZonaID INT
		,@CodigoRegion VARCHAR(8)
		,@CodigoZona VARCHAR(8)
		,@MontoMinPedido NUMERIC(15, 2)
		,@MontoTotal MONEY
		,@MontoEscala MONEY
		,@Algoritmo VARCHAR(10);

	SELECT @CampaniaID = CampaniaID
		,@CodigoConsultora = CodigoConsultora
		,@ZonaID = ZonaID
		,@CodigoRegion = CodigoRegion
		,@CodigoZona = CodigoZona
		,@MontoMinPedido = MontoMinimo
		,@MontoTotal = MontoTotal
		,@MontoEscala = MontoEscala
		,@Algoritmo = Algoritmo
	FROM @Table1;

	-- PASO 1 (validar parametria)
	DECLARE @CumpleParametria BIT
		,@MontoFaltante DECIMAL(18, 2)
		,@PrecioMinimo DECIMAL(18, 2)
		,@TipoMeta CHAR(2)
		,@MontoMeta DECIMAL(18, 2)
		,@GapAgregar DECIMAL(18, 2);

	SET @CumpleParametria = 0;

	IF (@MontoTotal >= @MontoMinPedido)
	BEGIN
		SELECT TOP 1 @GapAgregar = ISNULL(PrecioMinimo, 0)
		FROM OfertaFinalParametria WITH (NOLOCK)
		WHERE Tipo LIKE 'RG%'
			AND @MontoTotal BETWEEN GapMinimo AND GapMaximo
			AND Algoritmo = @Algoritmo;

		IF (@GapAgregar >= 0)
		BEGIN
			SET @TipoMeta = 'RG';
			SET @PrecioMinimo = 0;

			DECLARE @ConsultoraId INT
				,@MontoMaxPedido DECIMAL(18, 2);

			SELECT @ConsultoraId = ConsultoraId
				,@MontoMaxPedido = ISNULL(MontoMaximoPedido, 0)
			FROM ods.Consultora WITH (NOLOCK)
			WHERE Codigo = @CodigoConsultora;

			IF (@MontoTotal <= @MontoMaxPedido)
			BEGIN
				SET @CumpleParametria = 1;

				SELECT @MontoMeta = ISNULL(MontoMeta,0)
				FROM OfertaFinalMontoMeta WITH (NOLOCK)
				WHERE CampaniaId = @CampaniaID
					AND ConsultoraId = @ConsultoraId;

				--IF (ISNULL(@MontoMeta, 0) = 0)
				--    EXECUTE InsertarOfertaFinalRegaloSorpresa @CampaniaID,
				--                                              @ConsultoraId,
				--                                              @MontoTotal,
				--                                              @Algoritmo,
				--                                              @MontoMeta OUTPUT;
				IF (@MontoMeta != 0)
				BEGIN
					IF (@MontoTotal >= @MontoMeta)
					BEGIN
						SET @TipoMeta = 'GM';

						SELECT TOP 1 @PrecioMinimo = ISNULL(PrecioMinimo,0)
						FROM OfertaFinalParametria WITH (NOLOCK)
						WHERE Tipo = 'GM'
							AND Algoritmo = @Algoritmo;

						IF (@PrecioMinimo >= 0)
							SET @CumpleParametria = 1;
						ELSE
							SET @CumpleParametria = 0;
					END;
				END;
				ELSE
					SET @CumpleParametria = 1;
			END;
			ELSE
				SET @CumpleParametria = 0;
		END;
	END;
	ELSE
	BEGIN
		SET @MontoFaltante = (@MontoMinPedido - @MontoTotal);

		IF (@MontoFaltante > 0)
		BEGIN
			SELECT TOP 1 @PrecioMinimo = PrecioMinimo
				,@CumpleParametria = 1
			FROM OfertaFinalParametria WITH (NOLOCK)
			WHERE Tipo = 'MM'
				AND @MontoFaltante BETWEEN GapMinimo AND GapMaximo
				AND Algoritmo = @Algoritmo;

			SET @TipoMeta = 'MM';
		END;
	END;

	IF (@CumpleParametria = 1)
	BEGIN
		DECLARE @tablaCuvFaltante TABLE (CUV VARCHAR(6));

		-- PASO 2 (cuv faltantes y anunciadoS)
		INSERT INTO @tablaCuvFaltante
		SELECT DISTINCT LTRIM(RTRIM(CUV))
		FROM dbo.ProductoFaltante WITH (NOLOCK)
		WHERE CampaniaID = @CampaniaID
			AND ZonaID = @ZonaID
		
		UNION ALL
		
		SELECT DISTINCT LTRIM(RTRIM(fa.CodigoVenta))
		FROM ods.FaltanteAnunciado fa WITH (NOLOCK)
		INNER JOIN ods.Campania c WITH (NOLOCK) ON fa.CampaniaID = c.CampaniaID
		WHERE c.Codigo = @CampaniaID
			AND (
				RTRIM(fa.CodigoRegion) = @CodigoRegion
				OR fa.CodigoRegion IS NULL
				)
			AND (
				RTRIM(fa.CodigoZona) = @CodigoZona
				OR fa.CodigoZona IS NULL
				);

		-- PASO 3 (cuv ya comprados)
		DECLARE @tablaCuvPedido TABLE (
			CUV VARCHAR(6)
			,CodigoSap VARCHAR(30)
			);

		INSERT INTO @tablaCuvPedido
		SELECT pc.CUV
			,pc.CodigoProducto
		FROM PedidoWebDetalle pd WITH (NOLOCK)
		INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON pd.CampaniaID = pc.AnoCampania
			AND pd.CUV = pc.CUV
			AND pc.IndicadorDigitable = 1
		--AND pc.CodigoCatalago IN (9,10,13, 24)
		INNER JOIN ods.Consultora c WITH (NOLOCK) ON pd.ConsultoraID = c.ConsultoraID
		WHERE pd.CampaniaID = @CampaniaID
			AND c.Codigo = @CodigoConsultora;

		-- PASO 4 (buscar ofertas para la consultora)
		DECLARE @tablaCodigosCuv TABLE (
			CUV VARCHAR(6)
			,CodigoSap VARCHAR(12)
			,CampaniaID INT
			,Orden INT
			);

		INSERT INTO @tablaCodigosCuv
		SELECT pc.CUV
			,pc.CodigoProducto
			,pc.CampaniaID
			,op.Orden
		FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
		INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON op.AnioCampanaVenta = pc.AnoCampania
			AND op.CUV = pc.CUV
			AND op.TipoPersonalizacion = 'SR'
			AND op.CodConsultora = @CodigoConsultora
		WHERE op.AnioCampanaVenta = @CampaniaId
			AND pc.CUV NOT IN (
				SELECT CUV
				FROM @tablaCuvFaltante
				)
			AND pc.CodigoProducto NOT IN (
				SELECT CodigoSap
				FROM @tablaCuvPedido
				);

		-- PASO 5 (si no hay ofertas para la consultora buscar por la generica)
		DECLARE @cantOfertas INT = 0
			,@consultoraGenerica VARCHAR(30) = '';

		SELECT @cantOfertas = COUNT(1)
		FROM @tablaCodigosCuv;

		IF ISNULL(@cantOfertas, 0) = 0
		BEGIN
			SELECT @consultoraGenerica = Codigo
			FROM TablaLogicaDatos
			WHERE TablaLogicaDatosID = 10001;

			IF ISNULL(@consultoraGenerica,'') != ''
			BEGIN
				INSERT INTO @tablaCodigosCuv
				SELECT pc.CUV
					,pc.CodigoProducto
					,pc.CampaniaID
					,op.Orden
				FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
				INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON op.AnioCampanaVenta = pc.AnoCampania
					AND op.CUV = pc.CUV
					AND op.TipoPersonalizacion = 'SR'
					AND op.CodConsultora = @consultoraGenerica
				WHERE op.AnioCampanaVenta = @CampaniaID
					AND pc.CUV NOT IN (
						SELECT CUV
						FROM @tablaCuvFaltante
						)
					AND pc.CodigoProducto NOT IN (
						SELECT CodigoSap
						FROM @tablaCuvPedido
						);
			END;
		END;

		DECLARE @OfertaProductoTemp TABLE (
			CampaniaID INT
			,CUV VARCHAR(6)
			,ConfiguracionOfertaID INT
			,TipoOfertaSisID INT
			);

		INSERT INTO @OfertaProductoTemp
		SELECT op.CampaniaID
			,op.CUV
			,op.ConfiguracionOfertaID
			,op.TipoOfertaSisID
		FROM OfertaProducto op WITH (NOLOCK)
		INNER JOIN @tablaCodigosCuv tc ON op.CampaniaID = tc.CampaniaID
			AND op.CUV = tc.CUV;

		IF (@TipoMeta = 'GM')
			SET @MontoFaltante = 0;

		-- PASO 6 (filtrar resultados)
		SELECT DISTINCT p.CUV
			,p.Descripcion AS Descripcion
			,(p.PrecioUnitario * p.FactorRepeticion) AS PrecioCatalogo
			,p.MarcaID AS IdMarca
			,p.PrecioValorizado
			,p.PaisID
			,p.AnoCampania AS CampaniaID
			,p.CodigoCatalago
			,p.CodigoProducto AS CodigoSap
			,p.IndicadorMontoMinimo
			,p.IndicadorOferta
			,0 AS EstaEnRevista
			,ISNULL(pcc.EsExpoOferta, 0) AS EsExpoOferta
			,ISNULL(pcc.CUVRevista, '') AS CUVRevista
			,M.Nombre AS NombreMarca
			,'NO DISPONIBLE' AS DescripcionCategoria
			,'' AS CUVComplemento
			,'' AS DescripcionEstrategia
			,ISNULL(op.ConfiguracionOfertaID, 0) AS ConfiguracionOfertaID
			,ISNULL(op.TipoOfertaSisID, 0) AS TipoOfertaSisID
			,0 AS FlagNueva
			,0 AS TipoEstrategiaID
			,0 AS TieneSugerido
			,CASE 
				WHEN pl.CodigoSap IS NULL
					THEN 0
				ELSE 1
				END AS TieneLanzamientoCatalogoPersonalizado
			,CASE 
				WHEN pcor.SAP IS NULL
					THEN 0
				ELSE 1
				END AS TieneOfertaRevista
			,ISNULL(pcor.Oferta, '') AS TipoOfertaRevista
			,tc.Orden
			,@TipoMeta AS TipoMeta
			,CASE @TipoMeta
				WHEN 'MM'
					THEN @MontoFaltante
				WHEN 'RG'
					THEN @MontoMeta
				WHEN 'GM'
					THEN @MontoMeta
				END AS MontoMeta
		FROM @tablaCodigosCuv tc
		INNER JOIN ods.ProductoComercial p WITH (NOLOCK) ON tc.CampaniaID = p.CampaniaID
			AND tc.CUV = p.CUV
		LEFT JOIN ProductoComercialConfiguracion pcc WITH (NOLOCK) ON p.AnoCampania = pcc.CampaniaID
			AND p.CUV = pcc.CUV
		LEFT JOIN @OfertaProductoTemp op ON op.CampaniaID = p.CampaniaID
			AND op.CUV = p.CUV
		LEFT JOIN ods.ProductosLanzamiento pl WITH (NOLOCK) ON p.CodigoProducto = pl.CodigoSap
			AND p.AnoCampania = pl.Campania
		LEFT JOIN ProductoComercialOfertaRevista pcor WITH (NOLOCK) ON p.AnoCampania = pcor.Campania
			AND p.CUV = pcor.CUV
		LEFT JOIN ods.Marca M WITH (NOLOCK) ON p.MarcaID = M.MarcaID
		WHERE p.IndicadorDigitable = 1
			AND p.PrecioCatalogo >= ISNULL(@PrecioMinimo, 0)
			AND PrecioCatalogo >= ISNULL(@MontoFaltante, 0)
		ORDER BY tc.Orden;
	END;
END;
GO

USE BelcorpGuatemala
GO

ALTER PROCEDURE [dbo].[GetListaProductoOfertaFinalRegaloSorpresa] (@Table1 dbo.ListaOfertaFinalType READONLY)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @CampaniaID INT
		,@CodigoConsultora VARCHAR(30)
		,@ZonaID INT
		,@CodigoRegion VARCHAR(8)
		,@CodigoZona VARCHAR(8)
		,@MontoMinPedido NUMERIC(15, 2)
		,@MontoTotal MONEY
		,@MontoEscala MONEY
		,@Algoritmo VARCHAR(10);

	SELECT @CampaniaID = CampaniaID
		,@CodigoConsultora = CodigoConsultora
		,@ZonaID = ZonaID
		,@CodigoRegion = CodigoRegion
		,@CodigoZona = CodigoZona
		,@MontoMinPedido = MontoMinimo
		,@MontoTotal = MontoTotal
		,@MontoEscala = MontoEscala
		,@Algoritmo = Algoritmo
	FROM @Table1;

	-- PASO 1 (validar parametria)
	DECLARE @CumpleParametria BIT
		,@MontoFaltante DECIMAL(18, 2)
		,@PrecioMinimo DECIMAL(18, 2)
		,@TipoMeta CHAR(2)
		,@MontoMeta DECIMAL(18, 2)
		,@GapAgregar DECIMAL(18, 2);

	SET @CumpleParametria = 0;

	IF (@MontoTotal >= @MontoMinPedido)
	BEGIN
		SELECT TOP 1 @GapAgregar = ISNULL(PrecioMinimo, 0)
		FROM OfertaFinalParametria WITH (NOLOCK)
		WHERE Tipo LIKE 'RG%'
			AND @MontoTotal BETWEEN GapMinimo AND GapMaximo
			AND Algoritmo = @Algoritmo;

		IF (@GapAgregar >= 0)
		BEGIN
			SET @TipoMeta = 'RG';
			SET @PrecioMinimo = 0;

			DECLARE @ConsultoraId INT
				,@MontoMaxPedido DECIMAL(18, 2);

			SELECT @ConsultoraId = ConsultoraId
				,@MontoMaxPedido = ISNULL(MontoMaximoPedido, 0)
			FROM ods.Consultora WITH (NOLOCK)
			WHERE Codigo = @CodigoConsultora;

			IF (@MontoTotal <= @MontoMaxPedido)
			BEGIN
				SET @CumpleParametria = 1;

				SELECT @MontoMeta = ISNULL(MontoMeta,0)
				FROM OfertaFinalMontoMeta WITH (NOLOCK)
				WHERE CampaniaId = @CampaniaID
					AND ConsultoraId = @ConsultoraId;

				--IF (ISNULL(@MontoMeta, 0) = 0)
				--    EXECUTE InsertarOfertaFinalRegaloSorpresa @CampaniaID,
				--                                              @ConsultoraId,
				--                                              @MontoTotal,
				--                                              @Algoritmo,
				--                                              @MontoMeta OUTPUT;
				IF (@MontoMeta != 0)
				BEGIN
					IF (@MontoTotal >= @MontoMeta)
					BEGIN
						SET @TipoMeta = 'GM';

						SELECT TOP 1 @PrecioMinimo = ISNULL(PrecioMinimo,0)
						FROM OfertaFinalParametria WITH (NOLOCK)
						WHERE Tipo = 'GM'
							AND Algoritmo = @Algoritmo;

						IF (@PrecioMinimo >= 0)
							SET @CumpleParametria = 1;
						ELSE
							SET @CumpleParametria = 0;
					END;
				END;
				ELSE
					SET @CumpleParametria = 1;
			END;
			ELSE
				SET @CumpleParametria = 0;
		END;
	END;
	ELSE
	BEGIN
		SET @MontoFaltante = (@MontoMinPedido - @MontoTotal);

		IF (@MontoFaltante > 0)
		BEGIN
			SELECT TOP 1 @PrecioMinimo = PrecioMinimo
				,@CumpleParametria = 1
			FROM OfertaFinalParametria WITH (NOLOCK)
			WHERE Tipo = 'MM'
				AND @MontoFaltante BETWEEN GapMinimo AND GapMaximo
				AND Algoritmo = @Algoritmo;

			SET @TipoMeta = 'MM';
		END;
	END;

	IF (@CumpleParametria = 1)
	BEGIN
		DECLARE @tablaCuvFaltante TABLE (CUV VARCHAR(6));

		-- PASO 2 (cuv faltantes y anunciadoS)
		INSERT INTO @tablaCuvFaltante
		SELECT DISTINCT LTRIM(RTRIM(CUV))
		FROM dbo.ProductoFaltante WITH (NOLOCK)
		WHERE CampaniaID = @CampaniaID
			AND ZonaID = @ZonaID
		
		UNION ALL
		
		SELECT DISTINCT LTRIM(RTRIM(fa.CodigoVenta))
		FROM ods.FaltanteAnunciado fa WITH (NOLOCK)
		INNER JOIN ods.Campania c WITH (NOLOCK) ON fa.CampaniaID = c.CampaniaID
		WHERE c.Codigo = @CampaniaID
			AND (
				RTRIM(fa.CodigoRegion) = @CodigoRegion
				OR fa.CodigoRegion IS NULL
				)
			AND (
				RTRIM(fa.CodigoZona) = @CodigoZona
				OR fa.CodigoZona IS NULL
				);

		-- PASO 3 (cuv ya comprados)
		DECLARE @tablaCuvPedido TABLE (
			CUV VARCHAR(6)
			,CodigoSap VARCHAR(30)
			);

		INSERT INTO @tablaCuvPedido
		SELECT pc.CUV
			,pc.CodigoProducto
		FROM PedidoWebDetalle pd WITH (NOLOCK)
		INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON pd.CampaniaID = pc.AnoCampania
			AND pd.CUV = pc.CUV
			AND pc.IndicadorDigitable = 1
		--AND pc.CodigoCatalago IN (9,10,13, 24)
		INNER JOIN ods.Consultora c WITH (NOLOCK) ON pd.ConsultoraID = c.ConsultoraID
		WHERE pd.CampaniaID = @CampaniaID
			AND c.Codigo = @CodigoConsultora;

		-- PASO 4 (buscar ofertas para la consultora)
		DECLARE @tablaCodigosCuv TABLE (
			CUV VARCHAR(6)
			,CodigoSap VARCHAR(12)
			,CampaniaID INT
			,Orden INT
			);

		INSERT INTO @tablaCodigosCuv
		SELECT pc.CUV
			,pc.CodigoProducto
			,pc.CampaniaID
			,op.Orden
		FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
		INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON op.AnioCampanaVenta = pc.AnoCampania
			AND op.CUV = pc.CUV
			AND op.TipoPersonalizacion = 'SR'
			AND op.CodConsultora = @CodigoConsultora
		WHERE op.AnioCampanaVenta = @CampaniaId
			AND pc.CUV NOT IN (
				SELECT CUV
				FROM @tablaCuvFaltante
				)
			AND pc.CodigoProducto NOT IN (
				SELECT CodigoSap
				FROM @tablaCuvPedido
				);

		-- PASO 5 (si no hay ofertas para la consultora buscar por la generica)
		DECLARE @cantOfertas INT = 0
			,@consultoraGenerica VARCHAR(30) = '';

		SELECT @cantOfertas = COUNT(1)
		FROM @tablaCodigosCuv;

		IF ISNULL(@cantOfertas, 0) = 0
		BEGIN
			SELECT @consultoraGenerica = Codigo
			FROM TablaLogicaDatos
			WHERE TablaLogicaDatosID = 10001;

			IF ISNULL(@consultoraGenerica,'') != ''
			BEGIN
				INSERT INTO @tablaCodigosCuv
				SELECT pc.CUV
					,pc.CodigoProducto
					,pc.CampaniaID
					,op.Orden
				FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
				INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON op.AnioCampanaVenta = pc.AnoCampania
					AND op.CUV = pc.CUV
					AND op.TipoPersonalizacion = 'SR'
					AND op.CodConsultora = @consultoraGenerica
				WHERE op.AnioCampanaVenta = @CampaniaID
					AND pc.CUV NOT IN (
						SELECT CUV
						FROM @tablaCuvFaltante
						)
					AND pc.CodigoProducto NOT IN (
						SELECT CodigoSap
						FROM @tablaCuvPedido
						);
			END;
		END;

		DECLARE @OfertaProductoTemp TABLE (
			CampaniaID INT
			,CUV VARCHAR(6)
			,ConfiguracionOfertaID INT
			,TipoOfertaSisID INT
			);

		INSERT INTO @OfertaProductoTemp
		SELECT op.CampaniaID
			,op.CUV
			,op.ConfiguracionOfertaID
			,op.TipoOfertaSisID
		FROM OfertaProducto op WITH (NOLOCK)
		INNER JOIN @tablaCodigosCuv tc ON op.CampaniaID = tc.CampaniaID
			AND op.CUV = tc.CUV;

		IF (@TipoMeta = 'GM')
			SET @MontoFaltante = 0;

		-- PASO 6 (filtrar resultados)
		SELECT DISTINCT p.CUV
			,p.Descripcion AS Descripcion
			,(p.PrecioUnitario * p.FactorRepeticion) AS PrecioCatalogo
			,p.MarcaID AS IdMarca
			,p.PrecioValorizado
			,p.PaisID
			,p.AnoCampania AS CampaniaID
			,p.CodigoCatalago
			,p.CodigoProducto AS CodigoSap
			,p.IndicadorMontoMinimo
			,p.IndicadorOferta
			,0 AS EstaEnRevista
			,ISNULL(pcc.EsExpoOferta, 0) AS EsExpoOferta
			,ISNULL(pcc.CUVRevista, '') AS CUVRevista
			,M.Nombre AS NombreMarca
			,'NO DISPONIBLE' AS DescripcionCategoria
			,'' AS CUVComplemento
			,'' AS DescripcionEstrategia
			,ISNULL(op.ConfiguracionOfertaID, 0) AS ConfiguracionOfertaID
			,ISNULL(op.TipoOfertaSisID, 0) AS TipoOfertaSisID
			,0 AS FlagNueva
			,0 AS TipoEstrategiaID
			,0 AS TieneSugerido
			,CASE 
				WHEN pl.CodigoSap IS NULL
					THEN 0
				ELSE 1
				END AS TieneLanzamientoCatalogoPersonalizado
			,CASE 
				WHEN pcor.SAP IS NULL
					THEN 0
				ELSE 1
				END AS TieneOfertaRevista
			,ISNULL(pcor.Oferta, '') AS TipoOfertaRevista
			,tc.Orden
			,@TipoMeta AS TipoMeta
			,CASE @TipoMeta
				WHEN 'MM'
					THEN @MontoFaltante
				WHEN 'RG'
					THEN @MontoMeta
				WHEN 'GM'
					THEN @MontoMeta
				END AS MontoMeta
		FROM @tablaCodigosCuv tc
		INNER JOIN ods.ProductoComercial p WITH (NOLOCK) ON tc.CampaniaID = p.CampaniaID
			AND tc.CUV = p.CUV
		LEFT JOIN ProductoComercialConfiguracion pcc WITH (NOLOCK) ON p.AnoCampania = pcc.CampaniaID
			AND p.CUV = pcc.CUV
		LEFT JOIN @OfertaProductoTemp op ON op.CampaniaID = p.CampaniaID
			AND op.CUV = p.CUV
		LEFT JOIN ods.ProductosLanzamiento pl WITH (NOLOCK) ON p.CodigoProducto = pl.CodigoSap
			AND p.AnoCampania = pl.Campania
		LEFT JOIN ProductoComercialOfertaRevista pcor WITH (NOLOCK) ON p.AnoCampania = pcor.Campania
			AND p.CUV = pcor.CUV
		LEFT JOIN ods.Marca M WITH (NOLOCK) ON p.MarcaID = M.MarcaID
		WHERE p.IndicadorDigitable = 1
			AND p.PrecioCatalogo >= ISNULL(@PrecioMinimo, 0)
			AND PrecioCatalogo >= ISNULL(@MontoFaltante, 0)
		ORDER BY tc.Orden;
	END;
END;
GO

USE BelcorpMexico
GO

ALTER PROCEDURE [dbo].[GetListaProductoOfertaFinalRegaloSorpresa] (@Table1 dbo.ListaOfertaFinalType READONLY)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @CampaniaID INT
		,@CodigoConsultora VARCHAR(30)
		,@ZonaID INT
		,@CodigoRegion VARCHAR(8)
		,@CodigoZona VARCHAR(8)
		,@MontoMinPedido NUMERIC(15, 2)
		,@MontoTotal MONEY
		,@MontoEscala MONEY
		,@Algoritmo VARCHAR(10);

	SELECT @CampaniaID = CampaniaID
		,@CodigoConsultora = CodigoConsultora
		,@ZonaID = ZonaID
		,@CodigoRegion = CodigoRegion
		,@CodigoZona = CodigoZona
		,@MontoMinPedido = MontoMinimo
		,@MontoTotal = MontoTotal
		,@MontoEscala = MontoEscala
		,@Algoritmo = Algoritmo
	FROM @Table1;

	-- PASO 1 (validar parametria)
	DECLARE @CumpleParametria BIT
		,@MontoFaltante DECIMAL(18, 2)
		,@PrecioMinimo DECIMAL(18, 2)
		,@TipoMeta CHAR(2)
		,@MontoMeta DECIMAL(18, 2)
		,@GapAgregar DECIMAL(18, 2);

	SET @CumpleParametria = 0;

	IF (@MontoTotal >= @MontoMinPedido)
	BEGIN
		SELECT TOP 1 @GapAgregar = ISNULL(PrecioMinimo, 0)
		FROM OfertaFinalParametria WITH (NOLOCK)
		WHERE Tipo LIKE 'RG%'
			AND @MontoTotal BETWEEN GapMinimo AND GapMaximo
			AND Algoritmo = @Algoritmo;

		IF (@GapAgregar >= 0)
		BEGIN
			SET @TipoMeta = 'RG';
			SET @PrecioMinimo = 0;

			DECLARE @ConsultoraId INT
				,@MontoMaxPedido DECIMAL(18, 2);

			SELECT @ConsultoraId = ConsultoraId
				,@MontoMaxPedido = ISNULL(MontoMaximoPedido, 0)
			FROM ods.Consultora WITH (NOLOCK)
			WHERE Codigo = @CodigoConsultora;

			IF (@MontoTotal <= @MontoMaxPedido)
			BEGIN
				SET @CumpleParametria = 1;

				SELECT @MontoMeta = ISNULL(MontoMeta,0)
				FROM OfertaFinalMontoMeta WITH (NOLOCK)
				WHERE CampaniaId = @CampaniaID
					AND ConsultoraId = @ConsultoraId;

				--IF (ISNULL(@MontoMeta, 0) = 0)
				--    EXECUTE InsertarOfertaFinalRegaloSorpresa @CampaniaID,
				--                                              @ConsultoraId,
				--                                              @MontoTotal,
				--                                              @Algoritmo,
				--                                              @MontoMeta OUTPUT;
				IF (@MontoMeta != 0)
				BEGIN
					IF (@MontoTotal >= @MontoMeta)
					BEGIN
						SET @TipoMeta = 'GM';

						SELECT TOP 1 @PrecioMinimo = ISNULL(PrecioMinimo,0)
						FROM OfertaFinalParametria WITH (NOLOCK)
						WHERE Tipo = 'GM'
							AND Algoritmo = @Algoritmo;

						IF (@PrecioMinimo >= 0)
							SET @CumpleParametria = 1;
						ELSE
							SET @CumpleParametria = 0;
					END;
				END;
				ELSE
					SET @CumpleParametria = 1;
			END;
			ELSE
				SET @CumpleParametria = 0;
		END;
	END;
	ELSE
	BEGIN
		SET @MontoFaltante = (@MontoMinPedido - @MontoTotal);

		IF (@MontoFaltante > 0)
		BEGIN
			SELECT TOP 1 @PrecioMinimo = PrecioMinimo
				,@CumpleParametria = 1
			FROM OfertaFinalParametria WITH (NOLOCK)
			WHERE Tipo = 'MM'
				AND @MontoFaltante BETWEEN GapMinimo AND GapMaximo
				AND Algoritmo = @Algoritmo;

			SET @TipoMeta = 'MM';
		END;
	END;

	IF (@CumpleParametria = 1)
	BEGIN
		DECLARE @tablaCuvFaltante TABLE (CUV VARCHAR(6));

		-- PASO 2 (cuv faltantes y anunciadoS)
		INSERT INTO @tablaCuvFaltante
		SELECT DISTINCT LTRIM(RTRIM(CUV))
		FROM dbo.ProductoFaltante WITH (NOLOCK)
		WHERE CampaniaID = @CampaniaID
			AND ZonaID = @ZonaID
		
		UNION ALL
		
		SELECT DISTINCT LTRIM(RTRIM(fa.CodigoVenta))
		FROM ods.FaltanteAnunciado fa WITH (NOLOCK)
		INNER JOIN ods.Campania c WITH (NOLOCK) ON fa.CampaniaID = c.CampaniaID
		WHERE c.Codigo = @CampaniaID
			AND (
				RTRIM(fa.CodigoRegion) = @CodigoRegion
				OR fa.CodigoRegion IS NULL
				)
			AND (
				RTRIM(fa.CodigoZona) = @CodigoZona
				OR fa.CodigoZona IS NULL
				);

		-- PASO 3 (cuv ya comprados)
		DECLARE @tablaCuvPedido TABLE (
			CUV VARCHAR(6)
			,CodigoSap VARCHAR(30)
			);

		INSERT INTO @tablaCuvPedido
		SELECT pc.CUV
			,pc.CodigoProducto
		FROM PedidoWebDetalle pd WITH (NOLOCK)
		INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON pd.CampaniaID = pc.AnoCampania
			AND pd.CUV = pc.CUV
			AND pc.IndicadorDigitable = 1
		--AND pc.CodigoCatalago IN (9,10,13, 24)
		INNER JOIN ods.Consultora c WITH (NOLOCK) ON pd.ConsultoraID = c.ConsultoraID
		WHERE pd.CampaniaID = @CampaniaID
			AND c.Codigo = @CodigoConsultora;

		-- PASO 4 (buscar ofertas para la consultora)
		DECLARE @tablaCodigosCuv TABLE (
			CUV VARCHAR(6)
			,CodigoSap VARCHAR(12)
			,CampaniaID INT
			,Orden INT
			);

		INSERT INTO @tablaCodigosCuv
		SELECT pc.CUV
			,pc.CodigoProducto
			,pc.CampaniaID
			,op.Orden
		FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
		INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON op.AnioCampanaVenta = pc.AnoCampania
			AND op.CUV = pc.CUV
			AND op.TipoPersonalizacion = 'SR'
			AND op.CodConsultora = @CodigoConsultora
		WHERE op.AnioCampanaVenta = @CampaniaId
			AND pc.CUV NOT IN (
				SELECT CUV
				FROM @tablaCuvFaltante
				)
			AND pc.CodigoProducto NOT IN (
				SELECT CodigoSap
				FROM @tablaCuvPedido
				);

		-- PASO 5 (si no hay ofertas para la consultora buscar por la generica)
		DECLARE @cantOfertas INT = 0
			,@consultoraGenerica VARCHAR(30) = '';

		SELECT @cantOfertas = COUNT(1)
		FROM @tablaCodigosCuv;

		IF ISNULL(@cantOfertas, 0) = 0
		BEGIN
			SELECT @consultoraGenerica = Codigo
			FROM TablaLogicaDatos
			WHERE TablaLogicaDatosID = 10001;

			IF ISNULL(@consultoraGenerica,'') != ''
			BEGIN
				INSERT INTO @tablaCodigosCuv
				SELECT pc.CUV
					,pc.CodigoProducto
					,pc.CampaniaID
					,op.Orden
				FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
				INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON op.AnioCampanaVenta = pc.AnoCampania
					AND op.CUV = pc.CUV
					AND op.TipoPersonalizacion = 'SR'
					AND op.CodConsultora = @consultoraGenerica
				WHERE op.AnioCampanaVenta = @CampaniaID
					AND pc.CUV NOT IN (
						SELECT CUV
						FROM @tablaCuvFaltante
						)
					AND pc.CodigoProducto NOT IN (
						SELECT CodigoSap
						FROM @tablaCuvPedido
						);
			END;
		END;

		DECLARE @OfertaProductoTemp TABLE (
			CampaniaID INT
			,CUV VARCHAR(6)
			,ConfiguracionOfertaID INT
			,TipoOfertaSisID INT
			);

		INSERT INTO @OfertaProductoTemp
		SELECT op.CampaniaID
			,op.CUV
			,op.ConfiguracionOfertaID
			,op.TipoOfertaSisID
		FROM OfertaProducto op WITH (NOLOCK)
		INNER JOIN @tablaCodigosCuv tc ON op.CampaniaID = tc.CampaniaID
			AND op.CUV = tc.CUV;

		IF (@TipoMeta = 'GM')
			SET @MontoFaltante = 0;

		-- PASO 6 (filtrar resultados)
		SELECT DISTINCT p.CUV
			,p.Descripcion AS Descripcion
			,(p.PrecioUnitario * p.FactorRepeticion) AS PrecioCatalogo
			,p.MarcaID AS IdMarca
			,p.PrecioValorizado
			,p.PaisID
			,p.AnoCampania AS CampaniaID
			,p.CodigoCatalago
			,p.CodigoProducto AS CodigoSap
			,p.IndicadorMontoMinimo
			,p.IndicadorOferta
			,0 AS EstaEnRevista
			,ISNULL(pcc.EsExpoOferta, 0) AS EsExpoOferta
			,ISNULL(pcc.CUVRevista, '') AS CUVRevista
			,M.Nombre AS NombreMarca
			,'NO DISPONIBLE' AS DescripcionCategoria
			,'' AS CUVComplemento
			,'' AS DescripcionEstrategia
			,ISNULL(op.ConfiguracionOfertaID, 0) AS ConfiguracionOfertaID
			,ISNULL(op.TipoOfertaSisID, 0) AS TipoOfertaSisID
			,0 AS FlagNueva
			,0 AS TipoEstrategiaID
			,0 AS TieneSugerido
			,CASE 
				WHEN pl.CodigoSap IS NULL
					THEN 0
				ELSE 1
				END AS TieneLanzamientoCatalogoPersonalizado
			,CASE 
				WHEN pcor.SAP IS NULL
					THEN 0
				ELSE 1
				END AS TieneOfertaRevista
			,ISNULL(pcor.Oferta, '') AS TipoOfertaRevista
			,tc.Orden
			,@TipoMeta AS TipoMeta
			,CASE @TipoMeta
				WHEN 'MM'
					THEN @MontoFaltante
				WHEN 'RG'
					THEN @MontoMeta
				WHEN 'GM'
					THEN @MontoMeta
				END AS MontoMeta
		FROM @tablaCodigosCuv tc
		INNER JOIN ods.ProductoComercial p WITH (NOLOCK) ON tc.CampaniaID = p.CampaniaID
			AND tc.CUV = p.CUV
		LEFT JOIN ProductoComercialConfiguracion pcc WITH (NOLOCK) ON p.AnoCampania = pcc.CampaniaID
			AND p.CUV = pcc.CUV
		LEFT JOIN @OfertaProductoTemp op ON op.CampaniaID = p.CampaniaID
			AND op.CUV = p.CUV
		LEFT JOIN ods.ProductosLanzamiento pl WITH (NOLOCK) ON p.CodigoProducto = pl.CodigoSap
			AND p.AnoCampania = pl.Campania
		LEFT JOIN ProductoComercialOfertaRevista pcor WITH (NOLOCK) ON p.AnoCampania = pcor.Campania
			AND p.CUV = pcor.CUV
		LEFT JOIN ods.Marca M WITH (NOLOCK) ON p.MarcaID = M.MarcaID
		WHERE p.IndicadorDigitable = 1
			AND p.PrecioCatalogo >= ISNULL(@PrecioMinimo, 0)
			AND PrecioCatalogo >= ISNULL(@MontoFaltante, 0)
		ORDER BY tc.Orden;
	END;
END;
GO

USE BelcorpPanama
GO

ALTER PROCEDURE [dbo].[GetListaProductoOfertaFinalRegaloSorpresa] (@Table1 dbo.ListaOfertaFinalType READONLY)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @CampaniaID INT
		,@CodigoConsultora VARCHAR(30)
		,@ZonaID INT
		,@CodigoRegion VARCHAR(8)
		,@CodigoZona VARCHAR(8)
		,@MontoMinPedido NUMERIC(15, 2)
		,@MontoTotal MONEY
		,@MontoEscala MONEY
		,@Algoritmo VARCHAR(10);

	SELECT @CampaniaID = CampaniaID
		,@CodigoConsultora = CodigoConsultora
		,@ZonaID = ZonaID
		,@CodigoRegion = CodigoRegion
		,@CodigoZona = CodigoZona
		,@MontoMinPedido = MontoMinimo
		,@MontoTotal = MontoTotal
		,@MontoEscala = MontoEscala
		,@Algoritmo = Algoritmo
	FROM @Table1;

	-- PASO 1 (validar parametria)
	DECLARE @CumpleParametria BIT
		,@MontoFaltante DECIMAL(18, 2)
		,@PrecioMinimo DECIMAL(18, 2)
		,@TipoMeta CHAR(2)
		,@MontoMeta DECIMAL(18, 2)
		,@GapAgregar DECIMAL(18, 2);

	SET @CumpleParametria = 0;

	IF (@MontoTotal >= @MontoMinPedido)
	BEGIN
		SELECT TOP 1 @GapAgregar = ISNULL(PrecioMinimo, 0)
		FROM OfertaFinalParametria WITH (NOLOCK)
		WHERE Tipo LIKE 'RG%'
			AND @MontoTotal BETWEEN GapMinimo AND GapMaximo
			AND Algoritmo = @Algoritmo;

		IF (@GapAgregar >= 0)
		BEGIN
			SET @TipoMeta = 'RG';
			SET @PrecioMinimo = 0;

			DECLARE @ConsultoraId INT
				,@MontoMaxPedido DECIMAL(18, 2);

			SELECT @ConsultoraId = ConsultoraId
				,@MontoMaxPedido = ISNULL(MontoMaximoPedido, 0)
			FROM ods.Consultora WITH (NOLOCK)
			WHERE Codigo = @CodigoConsultora;

			IF (@MontoTotal <= @MontoMaxPedido)
			BEGIN
				SET @CumpleParametria = 1;

				SELECT @MontoMeta = ISNULL(MontoMeta,0)
				FROM OfertaFinalMontoMeta WITH (NOLOCK)
				WHERE CampaniaId = @CampaniaID
					AND ConsultoraId = @ConsultoraId;

				--IF (ISNULL(@MontoMeta, 0) = 0)
				--    EXECUTE InsertarOfertaFinalRegaloSorpresa @CampaniaID,
				--                                              @ConsultoraId,
				--                                              @MontoTotal,
				--                                              @Algoritmo,
				--                                              @MontoMeta OUTPUT;
				IF (@MontoMeta != 0)
				BEGIN
					IF (@MontoTotal >= @MontoMeta)
					BEGIN
						SET @TipoMeta = 'GM';

						SELECT TOP 1 @PrecioMinimo = ISNULL(PrecioMinimo,0)
						FROM OfertaFinalParametria WITH (NOLOCK)
						WHERE Tipo = 'GM'
							AND Algoritmo = @Algoritmo;

						IF (@PrecioMinimo >= 0)
							SET @CumpleParametria = 1;
						ELSE
							SET @CumpleParametria = 0;
					END;
				END;
				ELSE
					SET @CumpleParametria = 1;
			END;
			ELSE
				SET @CumpleParametria = 0;
		END;
	END;
	ELSE
	BEGIN
		SET @MontoFaltante = (@MontoMinPedido - @MontoTotal);

		IF (@MontoFaltante > 0)
		BEGIN
			SELECT TOP 1 @PrecioMinimo = PrecioMinimo
				,@CumpleParametria = 1
			FROM OfertaFinalParametria WITH (NOLOCK)
			WHERE Tipo = 'MM'
				AND @MontoFaltante BETWEEN GapMinimo AND GapMaximo
				AND Algoritmo = @Algoritmo;

			SET @TipoMeta = 'MM';
		END;
	END;

	IF (@CumpleParametria = 1)
	BEGIN
		DECLARE @tablaCuvFaltante TABLE (CUV VARCHAR(6));

		-- PASO 2 (cuv faltantes y anunciadoS)
		INSERT INTO @tablaCuvFaltante
		SELECT DISTINCT LTRIM(RTRIM(CUV))
		FROM dbo.ProductoFaltante WITH (NOLOCK)
		WHERE CampaniaID = @CampaniaID
			AND ZonaID = @ZonaID
		
		UNION ALL
		
		SELECT DISTINCT LTRIM(RTRIM(fa.CodigoVenta))
		FROM ods.FaltanteAnunciado fa WITH (NOLOCK)
		INNER JOIN ods.Campania c WITH (NOLOCK) ON fa.CampaniaID = c.CampaniaID
		WHERE c.Codigo = @CampaniaID
			AND (
				RTRIM(fa.CodigoRegion) = @CodigoRegion
				OR fa.CodigoRegion IS NULL
				)
			AND (
				RTRIM(fa.CodigoZona) = @CodigoZona
				OR fa.CodigoZona IS NULL
				);

		-- PASO 3 (cuv ya comprados)
		DECLARE @tablaCuvPedido TABLE (
			CUV VARCHAR(6)
			,CodigoSap VARCHAR(30)
			);

		INSERT INTO @tablaCuvPedido
		SELECT pc.CUV
			,pc.CodigoProducto
		FROM PedidoWebDetalle pd WITH (NOLOCK)
		INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON pd.CampaniaID = pc.AnoCampania
			AND pd.CUV = pc.CUV
			AND pc.IndicadorDigitable = 1
		--AND pc.CodigoCatalago IN (9,10,13, 24)
		INNER JOIN ods.Consultora c WITH (NOLOCK) ON pd.ConsultoraID = c.ConsultoraID
		WHERE pd.CampaniaID = @CampaniaID
			AND c.Codigo = @CodigoConsultora;

		-- PASO 4 (buscar ofertas para la consultora)
		DECLARE @tablaCodigosCuv TABLE (
			CUV VARCHAR(6)
			,CodigoSap VARCHAR(12)
			,CampaniaID INT
			,Orden INT
			);

		INSERT INTO @tablaCodigosCuv
		SELECT pc.CUV
			,pc.CodigoProducto
			,pc.CampaniaID
			,op.Orden
		FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
		INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON op.AnioCampanaVenta = pc.AnoCampania
			AND op.CUV = pc.CUV
			AND op.TipoPersonalizacion = 'SR'
			AND op.CodConsultora = @CodigoConsultora
		WHERE op.AnioCampanaVenta = @CampaniaId
			AND pc.CUV NOT IN (
				SELECT CUV
				FROM @tablaCuvFaltante
				)
			AND pc.CodigoProducto NOT IN (
				SELECT CodigoSap
				FROM @tablaCuvPedido
				);

		-- PASO 5 (si no hay ofertas para la consultora buscar por la generica)
		DECLARE @cantOfertas INT = 0
			,@consultoraGenerica VARCHAR(30) = '';

		SELECT @cantOfertas = COUNT(1)
		FROM @tablaCodigosCuv;

		IF ISNULL(@cantOfertas, 0) = 0
		BEGIN
			SELECT @consultoraGenerica = Codigo
			FROM TablaLogicaDatos
			WHERE TablaLogicaDatosID = 10001;

			IF ISNULL(@consultoraGenerica,'') != ''
			BEGIN
				INSERT INTO @tablaCodigosCuv
				SELECT pc.CUV
					,pc.CodigoProducto
					,pc.CampaniaID
					,op.Orden
				FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
				INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON op.AnioCampanaVenta = pc.AnoCampania
					AND op.CUV = pc.CUV
					AND op.TipoPersonalizacion = 'SR'
					AND op.CodConsultora = @consultoraGenerica
				WHERE op.AnioCampanaVenta = @CampaniaID
					AND pc.CUV NOT IN (
						SELECT CUV
						FROM @tablaCuvFaltante
						)
					AND pc.CodigoProducto NOT IN (
						SELECT CodigoSap
						FROM @tablaCuvPedido
						);
			END;
		END;

		DECLARE @OfertaProductoTemp TABLE (
			CampaniaID INT
			,CUV VARCHAR(6)
			,ConfiguracionOfertaID INT
			,TipoOfertaSisID INT
			);

		INSERT INTO @OfertaProductoTemp
		SELECT op.CampaniaID
			,op.CUV
			,op.ConfiguracionOfertaID
			,op.TipoOfertaSisID
		FROM OfertaProducto op WITH (NOLOCK)
		INNER JOIN @tablaCodigosCuv tc ON op.CampaniaID = tc.CampaniaID
			AND op.CUV = tc.CUV;

		IF (@TipoMeta = 'GM')
			SET @MontoFaltante = 0;

		-- PASO 6 (filtrar resultados)
		SELECT DISTINCT p.CUV
			,p.Descripcion AS Descripcion
			,(p.PrecioUnitario * p.FactorRepeticion) AS PrecioCatalogo
			,p.MarcaID AS IdMarca
			,p.PrecioValorizado
			,p.PaisID
			,p.AnoCampania AS CampaniaID
			,p.CodigoCatalago
			,p.CodigoProducto AS CodigoSap
			,p.IndicadorMontoMinimo
			,p.IndicadorOferta
			,0 AS EstaEnRevista
			,ISNULL(pcc.EsExpoOferta, 0) AS EsExpoOferta
			,ISNULL(pcc.CUVRevista, '') AS CUVRevista
			,M.Nombre AS NombreMarca
			,'NO DISPONIBLE' AS DescripcionCategoria
			,'' AS CUVComplemento
			,'' AS DescripcionEstrategia
			,ISNULL(op.ConfiguracionOfertaID, 0) AS ConfiguracionOfertaID
			,ISNULL(op.TipoOfertaSisID, 0) AS TipoOfertaSisID
			,0 AS FlagNueva
			,0 AS TipoEstrategiaID
			,0 AS TieneSugerido
			,CASE 
				WHEN pl.CodigoSap IS NULL
					THEN 0
				ELSE 1
				END AS TieneLanzamientoCatalogoPersonalizado
			,CASE 
				WHEN pcor.SAP IS NULL
					THEN 0
				ELSE 1
				END AS TieneOfertaRevista
			,ISNULL(pcor.Oferta, '') AS TipoOfertaRevista
			,tc.Orden
			,@TipoMeta AS TipoMeta
			,CASE @TipoMeta
				WHEN 'MM'
					THEN @MontoFaltante
				WHEN 'RG'
					THEN @MontoMeta
				WHEN 'GM'
					THEN @MontoMeta
				END AS MontoMeta
		FROM @tablaCodigosCuv tc
		INNER JOIN ods.ProductoComercial p WITH (NOLOCK) ON tc.CampaniaID = p.CampaniaID
			AND tc.CUV = p.CUV
		LEFT JOIN ProductoComercialConfiguracion pcc WITH (NOLOCK) ON p.AnoCampania = pcc.CampaniaID
			AND p.CUV = pcc.CUV
		LEFT JOIN @OfertaProductoTemp op ON op.CampaniaID = p.CampaniaID
			AND op.CUV = p.CUV
		LEFT JOIN ods.ProductosLanzamiento pl WITH (NOLOCK) ON p.CodigoProducto = pl.CodigoSap
			AND p.AnoCampania = pl.Campania
		LEFT JOIN ProductoComercialOfertaRevista pcor WITH (NOLOCK) ON p.AnoCampania = pcor.Campania
			AND p.CUV = pcor.CUV
		LEFT JOIN ods.Marca M WITH (NOLOCK) ON p.MarcaID = M.MarcaID
		WHERE p.IndicadorDigitable = 1
			AND p.PrecioCatalogo >= ISNULL(@PrecioMinimo, 0)
			AND PrecioCatalogo >= ISNULL(@MontoFaltante, 0)
		ORDER BY tc.Orden;
	END;
END;
GO

USE BelcorpPeru
GO

ALTER PROCEDURE [dbo].[GetListaProductoOfertaFinalRegaloSorpresa] (@Table1 dbo.ListaOfertaFinalType READONLY)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @CampaniaID INT
		,@CodigoConsultora VARCHAR(30)
		,@ZonaID INT
		,@CodigoRegion VARCHAR(8)
		,@CodigoZona VARCHAR(8)
		,@MontoMinPedido NUMERIC(15, 2)
		,@MontoTotal MONEY
		,@MontoEscala MONEY
		,@Algoritmo VARCHAR(10);

	SELECT @CampaniaID = CampaniaID
		,@CodigoConsultora = CodigoConsultora
		,@ZonaID = ZonaID
		,@CodigoRegion = CodigoRegion
		,@CodigoZona = CodigoZona
		,@MontoMinPedido = MontoMinimo
		,@MontoTotal = MontoTotal
		,@MontoEscala = MontoEscala
		,@Algoritmo = Algoritmo
	FROM @Table1;

	-- PASO 1 (validar parametria)
	DECLARE @CumpleParametria BIT
		,@MontoFaltante DECIMAL(18, 2)
		,@PrecioMinimo DECIMAL(18, 2)
		,@TipoMeta CHAR(2)
		,@MontoMeta DECIMAL(18, 2)
		,@GapAgregar DECIMAL(18, 2);

	SET @CumpleParametria = 0;

	IF (@MontoTotal >= @MontoMinPedido)
	BEGIN
		SELECT TOP 1 @GapAgregar = ISNULL(PrecioMinimo, 0)
		FROM OfertaFinalParametria WITH (NOLOCK)
		WHERE Tipo LIKE 'RG%'
			AND @MontoTotal BETWEEN GapMinimo AND GapMaximo
			AND Algoritmo = @Algoritmo;

		IF (@GapAgregar >= 0)
		BEGIN
			SET @TipoMeta = 'RG';
			SET @PrecioMinimo = 0;

			DECLARE @ConsultoraId INT
				,@MontoMaxPedido DECIMAL(18, 2);

			SELECT @ConsultoraId = ConsultoraId
				,@MontoMaxPedido = ISNULL(MontoMaximoPedido, 0)
			FROM ods.Consultora WITH (NOLOCK)
			WHERE Codigo = @CodigoConsultora;

			IF (@MontoTotal <= @MontoMaxPedido)
			BEGIN
				SET @CumpleParametria = 1;

				SELECT @MontoMeta = ISNULL(MontoMeta,0)
				FROM OfertaFinalMontoMeta WITH (NOLOCK)
				WHERE CampaniaId = @CampaniaID
					AND ConsultoraId = @ConsultoraId;

				--IF (ISNULL(@MontoMeta, 0) = 0)
				--    EXECUTE InsertarOfertaFinalRegaloSorpresa @CampaniaID,
				--                                              @ConsultoraId,
				--                                              @MontoTotal,
				--                                              @Algoritmo,
				--                                              @MontoMeta OUTPUT;
				IF (@MontoMeta != 0)
				BEGIN
					IF (@MontoTotal >= @MontoMeta)
					BEGIN
						SET @TipoMeta = 'GM';

						SELECT TOP 1 @PrecioMinimo = ISNULL(PrecioMinimo,0)
						FROM OfertaFinalParametria WITH (NOLOCK)
						WHERE Tipo = 'GM'
							AND Algoritmo = @Algoritmo;

						IF (@PrecioMinimo >= 0)
							SET @CumpleParametria = 1;
						ELSE
							SET @CumpleParametria = 0;
					END;
				END;
				ELSE
					SET @CumpleParametria = 1;
			END;
			ELSE
				SET @CumpleParametria = 0;
		END;
	END;
	ELSE
	BEGIN
		SET @MontoFaltante = (@MontoMinPedido - @MontoTotal);

		IF (@MontoFaltante > 0)
		BEGIN
			SELECT TOP 1 @PrecioMinimo = PrecioMinimo
				,@CumpleParametria = 1
			FROM OfertaFinalParametria WITH (NOLOCK)
			WHERE Tipo = 'MM'
				AND @MontoFaltante BETWEEN GapMinimo AND GapMaximo
				AND Algoritmo = @Algoritmo;

			SET @TipoMeta = 'MM';
		END;
	END;

	IF (@CumpleParametria = 1)
	BEGIN
		DECLARE @tablaCuvFaltante TABLE (CUV VARCHAR(6));

		-- PASO 2 (cuv faltantes y anunciadoS)
		INSERT INTO @tablaCuvFaltante
		SELECT DISTINCT LTRIM(RTRIM(CUV))
		FROM dbo.ProductoFaltante WITH (NOLOCK)
		WHERE CampaniaID = @CampaniaID
			AND ZonaID = @ZonaID
		
		UNION ALL
		
		SELECT DISTINCT LTRIM(RTRIM(fa.CodigoVenta))
		FROM ods.FaltanteAnunciado fa WITH (NOLOCK)
		INNER JOIN ods.Campania c WITH (NOLOCK) ON fa.CampaniaID = c.CampaniaID
		WHERE c.Codigo = @CampaniaID
			AND (
				RTRIM(fa.CodigoRegion) = @CodigoRegion
				OR fa.CodigoRegion IS NULL
				)
			AND (
				RTRIM(fa.CodigoZona) = @CodigoZona
				OR fa.CodigoZona IS NULL
				);

		-- PASO 3 (cuv ya comprados)
		DECLARE @tablaCuvPedido TABLE (
			CUV VARCHAR(6)
			,CodigoSap VARCHAR(30)
			);

		INSERT INTO @tablaCuvPedido
		SELECT pc.CUV
			,pc.CodigoProducto
		FROM PedidoWebDetalle pd WITH (NOLOCK)
		INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON pd.CampaniaID = pc.AnoCampania
			AND pd.CUV = pc.CUV
			AND pc.IndicadorDigitable = 1
		--AND pc.CodigoCatalago IN (9,10,13, 24)
		INNER JOIN ods.Consultora c WITH (NOLOCK) ON pd.ConsultoraID = c.ConsultoraID
		WHERE pd.CampaniaID = @CampaniaID
			AND c.Codigo = @CodigoConsultora;

		-- PASO 4 (buscar ofertas para la consultora)
		DECLARE @tablaCodigosCuv TABLE (
			CUV VARCHAR(6)
			,CodigoSap VARCHAR(12)
			,CampaniaID INT
			,Orden INT
			);

		INSERT INTO @tablaCodigosCuv
		SELECT pc.CUV
			,pc.CodigoProducto
			,pc.CampaniaID
			,op.Orden
		FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
		INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON op.AnioCampanaVenta = pc.AnoCampania
			AND op.CUV = pc.CUV
			AND op.TipoPersonalizacion = 'SR'
			AND op.CodConsultora = @CodigoConsultora
		WHERE op.AnioCampanaVenta = @CampaniaId
			AND pc.CUV NOT IN (
				SELECT CUV
				FROM @tablaCuvFaltante
				)
			AND pc.CodigoProducto NOT IN (
				SELECT CodigoSap
				FROM @tablaCuvPedido
				);

		-- PASO 5 (si no hay ofertas para la consultora buscar por la generica)
		DECLARE @cantOfertas INT = 0
			,@consultoraGenerica VARCHAR(30) = '';

		SELECT @cantOfertas = COUNT(1)
		FROM @tablaCodigosCuv;

		IF ISNULL(@cantOfertas, 0) = 0
		BEGIN
			SELECT @consultoraGenerica = Codigo
			FROM TablaLogicaDatos
			WHERE TablaLogicaDatosID = 10001;

			IF ISNULL(@consultoraGenerica,'') != ''
			BEGIN
				INSERT INTO @tablaCodigosCuv
				SELECT pc.CUV
					,pc.CodigoProducto
					,pc.CampaniaID
					,op.Orden
				FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
				INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON op.AnioCampanaVenta = pc.AnoCampania
					AND op.CUV = pc.CUV
					AND op.TipoPersonalizacion = 'SR'
					AND op.CodConsultora = @consultoraGenerica
				WHERE op.AnioCampanaVenta = @CampaniaID
					AND pc.CUV NOT IN (
						SELECT CUV
						FROM @tablaCuvFaltante
						)
					AND pc.CodigoProducto NOT IN (
						SELECT CodigoSap
						FROM @tablaCuvPedido
						);
			END;
		END;

		DECLARE @OfertaProductoTemp TABLE (
			CampaniaID INT
			,CUV VARCHAR(6)
			,ConfiguracionOfertaID INT
			,TipoOfertaSisID INT
			);

		INSERT INTO @OfertaProductoTemp
		SELECT op.CampaniaID
			,op.CUV
			,op.ConfiguracionOfertaID
			,op.TipoOfertaSisID
		FROM OfertaProducto op WITH (NOLOCK)
		INNER JOIN @tablaCodigosCuv tc ON op.CampaniaID = tc.CampaniaID
			AND op.CUV = tc.CUV;

		IF (@TipoMeta = 'GM')
			SET @MontoFaltante = 0;

		-- PASO 6 (filtrar resultados)
		SELECT DISTINCT p.CUV
			,p.Descripcion AS Descripcion
			,(p.PrecioUnitario * p.FactorRepeticion) AS PrecioCatalogo
			,p.MarcaID AS IdMarca
			,p.PrecioValorizado
			,p.PaisID
			,p.AnoCampania AS CampaniaID
			,p.CodigoCatalago
			,p.CodigoProducto AS CodigoSap
			,p.IndicadorMontoMinimo
			,p.IndicadorOferta
			,0 AS EstaEnRevista
			,ISNULL(pcc.EsExpoOferta, 0) AS EsExpoOferta
			,ISNULL(pcc.CUVRevista, '') AS CUVRevista
			,M.Nombre AS NombreMarca
			,'NO DISPONIBLE' AS DescripcionCategoria
			,'' AS CUVComplemento
			,'' AS DescripcionEstrategia
			,ISNULL(op.ConfiguracionOfertaID, 0) AS ConfiguracionOfertaID
			,ISNULL(op.TipoOfertaSisID, 0) AS TipoOfertaSisID
			,0 AS FlagNueva
			,0 AS TipoEstrategiaID
			,0 AS TieneSugerido
			,CASE 
				WHEN pl.CodigoSap IS NULL
					THEN 0
				ELSE 1
				END AS TieneLanzamientoCatalogoPersonalizado
			,CASE 
				WHEN pcor.SAP IS NULL
					THEN 0
				ELSE 1
				END AS TieneOfertaRevista
			,ISNULL(pcor.Oferta, '') AS TipoOfertaRevista
			,tc.Orden
			,@TipoMeta AS TipoMeta
			,CASE @TipoMeta
				WHEN 'MM'
					THEN @MontoFaltante
				WHEN 'RG'
					THEN @MontoMeta
				WHEN 'GM'
					THEN @MontoMeta
				END AS MontoMeta
		FROM @tablaCodigosCuv tc
		INNER JOIN ods.ProductoComercial p WITH (NOLOCK) ON tc.CampaniaID = p.CampaniaID
			AND tc.CUV = p.CUV
		LEFT JOIN ProductoComercialConfiguracion pcc WITH (NOLOCK) ON p.AnoCampania = pcc.CampaniaID
			AND p.CUV = pcc.CUV
		LEFT JOIN @OfertaProductoTemp op ON op.CampaniaID = p.CampaniaID
			AND op.CUV = p.CUV
		LEFT JOIN ods.ProductosLanzamiento pl WITH (NOLOCK) ON p.CodigoProducto = pl.CodigoSap
			AND p.AnoCampania = pl.Campania
		LEFT JOIN ProductoComercialOfertaRevista pcor WITH (NOLOCK) ON p.AnoCampania = pcor.Campania
			AND p.CUV = pcor.CUV
		LEFT JOIN ods.Marca M WITH (NOLOCK) ON p.MarcaID = M.MarcaID
		WHERE p.IndicadorDigitable = 1
			AND p.PrecioCatalogo >= ISNULL(@PrecioMinimo, 0)
			AND PrecioCatalogo >= ISNULL(@MontoFaltante, 0)
		ORDER BY tc.Orden;
	END;
END;
GO

USE BelcorpPuertoRico
GO

ALTER PROCEDURE [dbo].[GetListaProductoOfertaFinalRegaloSorpresa] (@Table1 dbo.ListaOfertaFinalType READONLY)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @CampaniaID INT
		,@CodigoConsultora VARCHAR(30)
		,@ZonaID INT
		,@CodigoRegion VARCHAR(8)
		,@CodigoZona VARCHAR(8)
		,@MontoMinPedido NUMERIC(15, 2)
		,@MontoTotal MONEY
		,@MontoEscala MONEY
		,@Algoritmo VARCHAR(10);

	SELECT @CampaniaID = CampaniaID
		,@CodigoConsultora = CodigoConsultora
		,@ZonaID = ZonaID
		,@CodigoRegion = CodigoRegion
		,@CodigoZona = CodigoZona
		,@MontoMinPedido = MontoMinimo
		,@MontoTotal = MontoTotal
		,@MontoEscala = MontoEscala
		,@Algoritmo = Algoritmo
	FROM @Table1;

	-- PASO 1 (validar parametria)
	DECLARE @CumpleParametria BIT
		,@MontoFaltante DECIMAL(18, 2)
		,@PrecioMinimo DECIMAL(18, 2)
		,@TipoMeta CHAR(2)
		,@MontoMeta DECIMAL(18, 2)
		,@GapAgregar DECIMAL(18, 2);

	SET @CumpleParametria = 0;

	IF (@MontoTotal >= @MontoMinPedido)
	BEGIN
		SELECT TOP 1 @GapAgregar = ISNULL(PrecioMinimo, 0)
		FROM OfertaFinalParametria WITH (NOLOCK)
		WHERE Tipo LIKE 'RG%'
			AND @MontoTotal BETWEEN GapMinimo AND GapMaximo
			AND Algoritmo = @Algoritmo;

		IF (@GapAgregar >= 0)
		BEGIN
			SET @TipoMeta = 'RG';
			SET @PrecioMinimo = 0;

			DECLARE @ConsultoraId INT
				,@MontoMaxPedido DECIMAL(18, 2);

			SELECT @ConsultoraId = ConsultoraId
				,@MontoMaxPedido = ISNULL(MontoMaximoPedido, 0)
			FROM ods.Consultora WITH (NOLOCK)
			WHERE Codigo = @CodigoConsultora;

			IF (@MontoTotal <= @MontoMaxPedido)
			BEGIN
				SET @CumpleParametria = 1;

				SELECT @MontoMeta = ISNULL(MontoMeta,0)
				FROM OfertaFinalMontoMeta WITH (NOLOCK)
				WHERE CampaniaId = @CampaniaID
					AND ConsultoraId = @ConsultoraId;

				--IF (ISNULL(@MontoMeta, 0) = 0)
				--    EXECUTE InsertarOfertaFinalRegaloSorpresa @CampaniaID,
				--                                              @ConsultoraId,
				--                                              @MontoTotal,
				--                                              @Algoritmo,
				--                                              @MontoMeta OUTPUT;
				IF (@MontoMeta != 0)
				BEGIN
					IF (@MontoTotal >= @MontoMeta)
					BEGIN
						SET @TipoMeta = 'GM';

						SELECT TOP 1 @PrecioMinimo = ISNULL(PrecioMinimo,0)
						FROM OfertaFinalParametria WITH (NOLOCK)
						WHERE Tipo = 'GM'
							AND Algoritmo = @Algoritmo;

						IF (@PrecioMinimo >= 0)
							SET @CumpleParametria = 1;
						ELSE
							SET @CumpleParametria = 0;
					END;
				END;
				ELSE
					SET @CumpleParametria = 1;
			END;
			ELSE
				SET @CumpleParametria = 0;
		END;
	END;
	ELSE
	BEGIN
		SET @MontoFaltante = (@MontoMinPedido - @MontoTotal);

		IF (@MontoFaltante > 0)
		BEGIN
			SELECT TOP 1 @PrecioMinimo = PrecioMinimo
				,@CumpleParametria = 1
			FROM OfertaFinalParametria WITH (NOLOCK)
			WHERE Tipo = 'MM'
				AND @MontoFaltante BETWEEN GapMinimo AND GapMaximo
				AND Algoritmo = @Algoritmo;

			SET @TipoMeta = 'MM';
		END;
	END;

	IF (@CumpleParametria = 1)
	BEGIN
		DECLARE @tablaCuvFaltante TABLE (CUV VARCHAR(6));

		-- PASO 2 (cuv faltantes y anunciadoS)
		INSERT INTO @tablaCuvFaltante
		SELECT DISTINCT LTRIM(RTRIM(CUV))
		FROM dbo.ProductoFaltante WITH (NOLOCK)
		WHERE CampaniaID = @CampaniaID
			AND ZonaID = @ZonaID
		
		UNION ALL
		
		SELECT DISTINCT LTRIM(RTRIM(fa.CodigoVenta))
		FROM ods.FaltanteAnunciado fa WITH (NOLOCK)
		INNER JOIN ods.Campania c WITH (NOLOCK) ON fa.CampaniaID = c.CampaniaID
		WHERE c.Codigo = @CampaniaID
			AND (
				RTRIM(fa.CodigoRegion) = @CodigoRegion
				OR fa.CodigoRegion IS NULL
				)
			AND (
				RTRIM(fa.CodigoZona) = @CodigoZona
				OR fa.CodigoZona IS NULL
				);

		-- PASO 3 (cuv ya comprados)
		DECLARE @tablaCuvPedido TABLE (
			CUV VARCHAR(6)
			,CodigoSap VARCHAR(30)
			);

		INSERT INTO @tablaCuvPedido
		SELECT pc.CUV
			,pc.CodigoProducto
		FROM PedidoWebDetalle pd WITH (NOLOCK)
		INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON pd.CampaniaID = pc.AnoCampania
			AND pd.CUV = pc.CUV
			AND pc.IndicadorDigitable = 1
		--AND pc.CodigoCatalago IN (9,10,13, 24)
		INNER JOIN ods.Consultora c WITH (NOLOCK) ON pd.ConsultoraID = c.ConsultoraID
		WHERE pd.CampaniaID = @CampaniaID
			AND c.Codigo = @CodigoConsultora;

		-- PASO 4 (buscar ofertas para la consultora)
		DECLARE @tablaCodigosCuv TABLE (
			CUV VARCHAR(6)
			,CodigoSap VARCHAR(12)
			,CampaniaID INT
			,Orden INT
			);

		INSERT INTO @tablaCodigosCuv
		SELECT pc.CUV
			,pc.CodigoProducto
			,pc.CampaniaID
			,op.Orden
		FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
		INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON op.AnioCampanaVenta = pc.AnoCampania
			AND op.CUV = pc.CUV
			AND op.TipoPersonalizacion = 'SR'
			AND op.CodConsultora = @CodigoConsultora
		WHERE op.AnioCampanaVenta = @CampaniaId
			AND pc.CUV NOT IN (
				SELECT CUV
				FROM @tablaCuvFaltante
				)
			AND pc.CodigoProducto NOT IN (
				SELECT CodigoSap
				FROM @tablaCuvPedido
				);

		-- PASO 5 (si no hay ofertas para la consultora buscar por la generica)
		DECLARE @cantOfertas INT = 0
			,@consultoraGenerica VARCHAR(30) = '';

		SELECT @cantOfertas = COUNT(1)
		FROM @tablaCodigosCuv;

		IF ISNULL(@cantOfertas, 0) = 0
		BEGIN
			SELECT @consultoraGenerica = Codigo
			FROM TablaLogicaDatos
			WHERE TablaLogicaDatosID = 10001;

			IF ISNULL(@consultoraGenerica,'') != ''
			BEGIN
				INSERT INTO @tablaCodigosCuv
				SELECT pc.CUV
					,pc.CodigoProducto
					,pc.CampaniaID
					,op.Orden
				FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
				INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON op.AnioCampanaVenta = pc.AnoCampania
					AND op.CUV = pc.CUV
					AND op.TipoPersonalizacion = 'SR'
					AND op.CodConsultora = @consultoraGenerica
				WHERE op.AnioCampanaVenta = @CampaniaID
					AND pc.CUV NOT IN (
						SELECT CUV
						FROM @tablaCuvFaltante
						)
					AND pc.CodigoProducto NOT IN (
						SELECT CodigoSap
						FROM @tablaCuvPedido
						);
			END;
		END;

		DECLARE @OfertaProductoTemp TABLE (
			CampaniaID INT
			,CUV VARCHAR(6)
			,ConfiguracionOfertaID INT
			,TipoOfertaSisID INT
			);

		INSERT INTO @OfertaProductoTemp
		SELECT op.CampaniaID
			,op.CUV
			,op.ConfiguracionOfertaID
			,op.TipoOfertaSisID
		FROM OfertaProducto op WITH (NOLOCK)
		INNER JOIN @tablaCodigosCuv tc ON op.CampaniaID = tc.CampaniaID
			AND op.CUV = tc.CUV;

		IF (@TipoMeta = 'GM')
			SET @MontoFaltante = 0;

		-- PASO 6 (filtrar resultados)
		SELECT DISTINCT p.CUV
			,p.Descripcion AS Descripcion
			,(p.PrecioUnitario * p.FactorRepeticion) AS PrecioCatalogo
			,p.MarcaID AS IdMarca
			,p.PrecioValorizado
			,p.PaisID
			,p.AnoCampania AS CampaniaID
			,p.CodigoCatalago
			,p.CodigoProducto AS CodigoSap
			,p.IndicadorMontoMinimo
			,p.IndicadorOferta
			,0 AS EstaEnRevista
			,ISNULL(pcc.EsExpoOferta, 0) AS EsExpoOferta
			,ISNULL(pcc.CUVRevista, '') AS CUVRevista
			,M.Nombre AS NombreMarca
			,'NO DISPONIBLE' AS DescripcionCategoria
			,'' AS CUVComplemento
			,'' AS DescripcionEstrategia
			,ISNULL(op.ConfiguracionOfertaID, 0) AS ConfiguracionOfertaID
			,ISNULL(op.TipoOfertaSisID, 0) AS TipoOfertaSisID
			,0 AS FlagNueva
			,0 AS TipoEstrategiaID
			,0 AS TieneSugerido
			,CASE 
				WHEN pl.CodigoSap IS NULL
					THEN 0
				ELSE 1
				END AS TieneLanzamientoCatalogoPersonalizado
			,CASE 
				WHEN pcor.SAP IS NULL
					THEN 0
				ELSE 1
				END AS TieneOfertaRevista
			,ISNULL(pcor.Oferta, '') AS TipoOfertaRevista
			,tc.Orden
			,@TipoMeta AS TipoMeta
			,CASE @TipoMeta
				WHEN 'MM'
					THEN @MontoFaltante
				WHEN 'RG'
					THEN @MontoMeta
				WHEN 'GM'
					THEN @MontoMeta
				END AS MontoMeta
		FROM @tablaCodigosCuv tc
		INNER JOIN ods.ProductoComercial p WITH (NOLOCK) ON tc.CampaniaID = p.CampaniaID
			AND tc.CUV = p.CUV
		LEFT JOIN ProductoComercialConfiguracion pcc WITH (NOLOCK) ON p.AnoCampania = pcc.CampaniaID
			AND p.CUV = pcc.CUV
		LEFT JOIN @OfertaProductoTemp op ON op.CampaniaID = p.CampaniaID
			AND op.CUV = p.CUV
		LEFT JOIN ods.ProductosLanzamiento pl WITH (NOLOCK) ON p.CodigoProducto = pl.CodigoSap
			AND p.AnoCampania = pl.Campania
		LEFT JOIN ProductoComercialOfertaRevista pcor WITH (NOLOCK) ON p.AnoCampania = pcor.Campania
			AND p.CUV = pcor.CUV
		LEFT JOIN ods.Marca M WITH (NOLOCK) ON p.MarcaID = M.MarcaID
		WHERE p.IndicadorDigitable = 1
			AND p.PrecioCatalogo >= ISNULL(@PrecioMinimo, 0)
			AND PrecioCatalogo >= ISNULL(@MontoFaltante, 0)
		ORDER BY tc.Orden;
	END;
END;
GO

USE BelcorpSalvador
GO

ALTER PROCEDURE [dbo].[GetListaProductoOfertaFinalRegaloSorpresa] (@Table1 dbo.ListaOfertaFinalType READONLY)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @CampaniaID INT
		,@CodigoConsultora VARCHAR(30)
		,@ZonaID INT
		,@CodigoRegion VARCHAR(8)
		,@CodigoZona VARCHAR(8)
		,@MontoMinPedido NUMERIC(15, 2)
		,@MontoTotal MONEY
		,@MontoEscala MONEY
		,@Algoritmo VARCHAR(10);

	SELECT @CampaniaID = CampaniaID
		,@CodigoConsultora = CodigoConsultora
		,@ZonaID = ZonaID
		,@CodigoRegion = CodigoRegion
		,@CodigoZona = CodigoZona
		,@MontoMinPedido = MontoMinimo
		,@MontoTotal = MontoTotal
		,@MontoEscala = MontoEscala
		,@Algoritmo = Algoritmo
	FROM @Table1;

	-- PASO 1 (validar parametria)
	DECLARE @CumpleParametria BIT
		,@MontoFaltante DECIMAL(18, 2)
		,@PrecioMinimo DECIMAL(18, 2)
		,@TipoMeta CHAR(2)
		,@MontoMeta DECIMAL(18, 2)
		,@GapAgregar DECIMAL(18, 2);

	SET @CumpleParametria = 0;

	IF (@MontoTotal >= @MontoMinPedido)
	BEGIN
		SELECT TOP 1 @GapAgregar = ISNULL(PrecioMinimo, 0)
		FROM OfertaFinalParametria WITH (NOLOCK)
		WHERE Tipo LIKE 'RG%'
			AND @MontoTotal BETWEEN GapMinimo AND GapMaximo
			AND Algoritmo = @Algoritmo;

		IF (@GapAgregar >= 0)
		BEGIN
			SET @TipoMeta = 'RG';
			SET @PrecioMinimo = 0;

			DECLARE @ConsultoraId INT
				,@MontoMaxPedido DECIMAL(18, 2);

			SELECT @ConsultoraId = ConsultoraId
				,@MontoMaxPedido = ISNULL(MontoMaximoPedido, 0)
			FROM ods.Consultora WITH (NOLOCK)
			WHERE Codigo = @CodigoConsultora;

			IF (@MontoTotal <= @MontoMaxPedido)
			BEGIN
				SET @CumpleParametria = 1;

				SELECT @MontoMeta = ISNULL(MontoMeta,0)
				FROM OfertaFinalMontoMeta WITH (NOLOCK)
				WHERE CampaniaId = @CampaniaID
					AND ConsultoraId = @ConsultoraId;

				--IF (ISNULL(@MontoMeta, 0) = 0)
				--    EXECUTE InsertarOfertaFinalRegaloSorpresa @CampaniaID,
				--                                              @ConsultoraId,
				--                                              @MontoTotal,
				--                                              @Algoritmo,
				--                                              @MontoMeta OUTPUT;
				IF (@MontoMeta != 0)
				BEGIN
					IF (@MontoTotal >= @MontoMeta)
					BEGIN
						SET @TipoMeta = 'GM';

						SELECT TOP 1 @PrecioMinimo = ISNULL(PrecioMinimo,0)
						FROM OfertaFinalParametria WITH (NOLOCK)
						WHERE Tipo = 'GM'
							AND Algoritmo = @Algoritmo;

						IF (@PrecioMinimo >= 0)
							SET @CumpleParametria = 1;
						ELSE
							SET @CumpleParametria = 0;
					END;
				END;
				ELSE
					SET @CumpleParametria = 1;
			END;
			ELSE
				SET @CumpleParametria = 0;
		END;
	END;
	ELSE
	BEGIN
		SET @MontoFaltante = (@MontoMinPedido - @MontoTotal);

		IF (@MontoFaltante > 0)
		BEGIN
			SELECT TOP 1 @PrecioMinimo = PrecioMinimo
				,@CumpleParametria = 1
			FROM OfertaFinalParametria WITH (NOLOCK)
			WHERE Tipo = 'MM'
				AND @MontoFaltante BETWEEN GapMinimo AND GapMaximo
				AND Algoritmo = @Algoritmo;

			SET @TipoMeta = 'MM';
		END;
	END;

	IF (@CumpleParametria = 1)
	BEGIN
		DECLARE @tablaCuvFaltante TABLE (CUV VARCHAR(6));

		-- PASO 2 (cuv faltantes y anunciadoS)
		INSERT INTO @tablaCuvFaltante
		SELECT DISTINCT LTRIM(RTRIM(CUV))
		FROM dbo.ProductoFaltante WITH (NOLOCK)
		WHERE CampaniaID = @CampaniaID
			AND ZonaID = @ZonaID
		
		UNION ALL
		
		SELECT DISTINCT LTRIM(RTRIM(fa.CodigoVenta))
		FROM ods.FaltanteAnunciado fa WITH (NOLOCK)
		INNER JOIN ods.Campania c WITH (NOLOCK) ON fa.CampaniaID = c.CampaniaID
		WHERE c.Codigo = @CampaniaID
			AND (
				RTRIM(fa.CodigoRegion) = @CodigoRegion
				OR fa.CodigoRegion IS NULL
				)
			AND (
				RTRIM(fa.CodigoZona) = @CodigoZona
				OR fa.CodigoZona IS NULL
				);

		-- PASO 3 (cuv ya comprados)
		DECLARE @tablaCuvPedido TABLE (
			CUV VARCHAR(6)
			,CodigoSap VARCHAR(30)
			);

		INSERT INTO @tablaCuvPedido
		SELECT pc.CUV
			,pc.CodigoProducto
		FROM PedidoWebDetalle pd WITH (NOLOCK)
		INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON pd.CampaniaID = pc.AnoCampania
			AND pd.CUV = pc.CUV
			AND pc.IndicadorDigitable = 1
		--AND pc.CodigoCatalago IN (9,10,13, 24)
		INNER JOIN ods.Consultora c WITH (NOLOCK) ON pd.ConsultoraID = c.ConsultoraID
		WHERE pd.CampaniaID = @CampaniaID
			AND c.Codigo = @CodigoConsultora;

		-- PASO 4 (buscar ofertas para la consultora)
		DECLARE @tablaCodigosCuv TABLE (
			CUV VARCHAR(6)
			,CodigoSap VARCHAR(12)
			,CampaniaID INT
			,Orden INT
			);

		INSERT INTO @tablaCodigosCuv
		SELECT pc.CUV
			,pc.CodigoProducto
			,pc.CampaniaID
			,op.Orden
		FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
		INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON op.AnioCampanaVenta = pc.AnoCampania
			AND op.CUV = pc.CUV
			AND op.TipoPersonalizacion = 'SR'
			AND op.CodConsultora = @CodigoConsultora
		WHERE op.AnioCampanaVenta = @CampaniaId
			AND pc.CUV NOT IN (
				SELECT CUV
				FROM @tablaCuvFaltante
				)
			AND pc.CodigoProducto NOT IN (
				SELECT CodigoSap
				FROM @tablaCuvPedido
				);

		-- PASO 5 (si no hay ofertas para la consultora buscar por la generica)
		DECLARE @cantOfertas INT = 0
			,@consultoraGenerica VARCHAR(30) = '';

		SELECT @cantOfertas = COUNT(1)
		FROM @tablaCodigosCuv;

		IF ISNULL(@cantOfertas, 0) = 0
		BEGIN
			SELECT @consultoraGenerica = Codigo
			FROM TablaLogicaDatos
			WHERE TablaLogicaDatosID = 10001;

			IF ISNULL(@consultoraGenerica,'') != ''
			BEGIN
				INSERT INTO @tablaCodigosCuv
				SELECT pc.CUV
					,pc.CodigoProducto
					,pc.CampaniaID
					,op.Orden
				FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
				INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON op.AnioCampanaVenta = pc.AnoCampania
					AND op.CUV = pc.CUV
					AND op.TipoPersonalizacion = 'SR'
					AND op.CodConsultora = @consultoraGenerica
				WHERE op.AnioCampanaVenta = @CampaniaID
					AND pc.CUV NOT IN (
						SELECT CUV
						FROM @tablaCuvFaltante
						)
					AND pc.CodigoProducto NOT IN (
						SELECT CodigoSap
						FROM @tablaCuvPedido
						);
			END;
		END;

		DECLARE @OfertaProductoTemp TABLE (
			CampaniaID INT
			,CUV VARCHAR(6)
			,ConfiguracionOfertaID INT
			,TipoOfertaSisID INT
			);

		INSERT INTO @OfertaProductoTemp
		SELECT op.CampaniaID
			,op.CUV
			,op.ConfiguracionOfertaID
			,op.TipoOfertaSisID
		FROM OfertaProducto op WITH (NOLOCK)
		INNER JOIN @tablaCodigosCuv tc ON op.CampaniaID = tc.CampaniaID
			AND op.CUV = tc.CUV;

		IF (@TipoMeta = 'GM')
			SET @MontoFaltante = 0;

		-- PASO 6 (filtrar resultados)
		SELECT DISTINCT p.CUV
			,p.Descripcion AS Descripcion
			,(p.PrecioUnitario * p.FactorRepeticion) AS PrecioCatalogo
			,p.MarcaID AS IdMarca
			,p.PrecioValorizado
			,p.PaisID
			,p.AnoCampania AS CampaniaID
			,p.CodigoCatalago
			,p.CodigoProducto AS CodigoSap
			,p.IndicadorMontoMinimo
			,p.IndicadorOferta
			,0 AS EstaEnRevista
			,ISNULL(pcc.EsExpoOferta, 0) AS EsExpoOferta
			,ISNULL(pcc.CUVRevista, '') AS CUVRevista
			,M.Nombre AS NombreMarca
			,'NO DISPONIBLE' AS DescripcionCategoria
			,'' AS CUVComplemento
			,'' AS DescripcionEstrategia
			,ISNULL(op.ConfiguracionOfertaID, 0) AS ConfiguracionOfertaID
			,ISNULL(op.TipoOfertaSisID, 0) AS TipoOfertaSisID
			,0 AS FlagNueva
			,0 AS TipoEstrategiaID
			,0 AS TieneSugerido
			,CASE 
				WHEN pl.CodigoSap IS NULL
					THEN 0
				ELSE 1
				END AS TieneLanzamientoCatalogoPersonalizado
			,CASE 
				WHEN pcor.SAP IS NULL
					THEN 0
				ELSE 1
				END AS TieneOfertaRevista
			,ISNULL(pcor.Oferta, '') AS TipoOfertaRevista
			,tc.Orden
			,@TipoMeta AS TipoMeta
			,CASE @TipoMeta
				WHEN 'MM'
					THEN @MontoFaltante
				WHEN 'RG'
					THEN @MontoMeta
				WHEN 'GM'
					THEN @MontoMeta
				END AS MontoMeta
		FROM @tablaCodigosCuv tc
		INNER JOIN ods.ProductoComercial p WITH (NOLOCK) ON tc.CampaniaID = p.CampaniaID
			AND tc.CUV = p.CUV
		LEFT JOIN ProductoComercialConfiguracion pcc WITH (NOLOCK) ON p.AnoCampania = pcc.CampaniaID
			AND p.CUV = pcc.CUV
		LEFT JOIN @OfertaProductoTemp op ON op.CampaniaID = p.CampaniaID
			AND op.CUV = p.CUV
		LEFT JOIN ods.ProductosLanzamiento pl WITH (NOLOCK) ON p.CodigoProducto = pl.CodigoSap
			AND p.AnoCampania = pl.Campania
		LEFT JOIN ProductoComercialOfertaRevista pcor WITH (NOLOCK) ON p.AnoCampania = pcor.Campania
			AND p.CUV = pcor.CUV
		LEFT JOIN ods.Marca M WITH (NOLOCK) ON p.MarcaID = M.MarcaID
		WHERE p.IndicadorDigitable = 1
			AND p.PrecioCatalogo >= ISNULL(@PrecioMinimo, 0)
			AND PrecioCatalogo >= ISNULL(@MontoFaltante, 0)
		ORDER BY tc.Orden;
	END;
END;
GO
