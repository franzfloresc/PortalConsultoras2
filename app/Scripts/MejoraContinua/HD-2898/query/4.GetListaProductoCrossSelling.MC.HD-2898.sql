USE [BelcorpPeru]  
GO
ALTER PROCEDURE [dbo].[GetListaProductoCrossSelling] (@Table1 dbo.ListaOfertaFinalType READONLY)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @codConsultoraForzadas VARCHAR(9) = ''

	SELECT @codConsultoraForzadas = Codigo
	FROM TablaLogicaDatos WITH (NOLOCK)
	WHERE TablaLogicaDatosID = 10002

	DECLARE @CampaniaID INT
		,@CodigoConsultora VARCHAR(30)
		,@TipoProductoMostrar INT
		,@ZonaID INT
		,@CodigoRegion VARCHAR(8)
		,@CodigoZona VARCHAR(8)
		,@MontoMinPedido NUMERIC(15, 2)
		,@MontoTotal MONEY
		,@MontoEscala MONEY

	SELECT @CampaniaID = CampaniaID
		,@CodigoConsultora = CodigoConsultora
		,@ZonaID = ZonaID
		,@CodigoRegion = CodigoRegion
		,@CodigoZona = CodigoZona
		,@MontoMinPedido = MontoMinimo
		,@MontoTotal = MontoTotal
		,@MontoEscala = MontoEscala
	FROM @Table1

	IF (@MontoTotal > @MontoMinPedido)
		IF @MontoEscala > @MontoMinPedido
			SET @TipoProductoMostrar = 1
		ELSE
			SET @TipoProductoMostrar = 2
	ELSE
		SET @TipoProductoMostrar = 2

	-- PASO 1 (obtener cuvs del pedido)
	DECLARE @tablaCuvPedido TABLE (
		CUV VARCHAR(9)
		,CodigoSap VARCHAR(30)
		)

	INSERT INTO @tablaCuvPedido
	SELECT pc.CUV
		,pc.CodigoProducto
	FROM PedidoWebDetalle pd WITH (NOLOCK)
	INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON pd.CampaniaID = pc.AnoCampania
		AND pd.CUV = pc.CUV
		AND pc.IndicadorDigitable = 1
	INNER JOIN ods.Consultora c WITH (NOLOCK) ON pd.ConsultoraID = c.ConsultoraID
	WHERE pd.CampaniaID = @CampaniaID
		AND c.Codigo = @CodigoConsultora

	-- PASO 2 (obtener cuvs personalizados)
	DECLARE @TablaCross TABLE (
		CampaniaID INT
		,CUV VARCHAR(6)
		,CodigoSap VARCHAR(30)
		,PrecioCatalogo DECIMAL(15, 2)
		,CodVinculo INT
		,PPU DECIMAL(15, 2)
		,Orden INT
		,EsCross BIT
		,PrecioOk BIT
		,TipoMeta CHAR(2)
		,OrdenMeta INT
		,CUVPedido VARCHAR(6)
		,CUV2 VARCHAR(6)
		,MarcaID INT
		,CodCampania INT
		,EstaEnPedido BIT
		,CodConsultora VARCHAR(20)
		)

	INSERT INTO @TablaCross
	SELECT pc.CampaniaID
		,pc.CUV
		,pc.CodigoProducto
		,pc.PrecioCatalogo
		,op.CodVinculo
		,op.PPU
		,op.Orden
		,1
		,0
		,''
		,0
		,''
		,''
		,pc.MarcaID
		,pc.AnoCampania
		,0
		,op.CodConsultora
	FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
	INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON op.AnioCampanaVenta = pc.AnoCampania
		AND op.CUV = pc.CUV
		AND op.CodConsultora IN (
			@CodigoConsultora
			,@codConsultoraForzadas
			)
		AND op.TipoPersonalizacion = 'OF'
	WHERE op.AnioCampanaVenta = @CampaniaID
		AND pc.IndicadorDigitable = 1
		AND pc.EstrategiaIdSicc != '2003'

	-- PASO 3 (validar si hay cuvs personalizados)
	DECLARE @cantOfertas INT = 0
		,@codConsultoraGenerica VARCHAR(30) = ''

	SELECT @cantOfertas = COUNT(1)
	FROM @TablaCross
	WHERE CodConsultora != @codConsultoraForzadas

	IF ISNULL(@cantOfertas, 0) = 0
	BEGIN
		SELECT @codConsultoraGenerica = Codigo
		FROM TablaLogicaDatos
		WHERE TablaLogicaDatosID = 10001

		IF ISNULL(@codConsultoraGenerica, '') != ''
		BEGIN
			INSERT INTO @TablaCross
			SELECT pc.CampaniaID
				,pc.CUV
				,pc.CodigoProducto
				,pc.PrecioCatalogo
				,op.CodVinculo
				,op.PPU
				,op.Orden
				,1
				,0
				,''
				,0
				,''
				,''
				,pc.MarcaID
				,pc.AnoCampania
				,0
				,op.CodConsultora
			FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
			INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON op.AnioCampanaVenta = pc.AnoCampania
				AND op.CUV = pc.CUV
				AND op.CodConsultora = @codConsultoraGenerica
				AND op.TipoPersonalizacion = 'OF'
			WHERE op.AnioCampanaVenta = @CampaniaID
				AND pc.IndicadorDigitable = 1
				AND pc.EstrategiaIdSicc != '2003'
		END
	END

	-- PASO 4 (validar datos de las ofertas)
	UPDATE a
	SET a.EstaEnPedido = 1
		,a.CUVPedido = b.CUV
	FROM @TablaCross a
	INNER JOIN @TablaCuvPedido b ON a.CodigoSap = b.CodigoSap

	UPDATE a
	SET a.CUVPedido = b.CUVPedido
	FROM @TablaCross a
	INNER JOIN (
		SELECT CodVinculo
			,CUVPedido
		FROM @TablaCross
		WHERE EstaEnPedido = 1
		) b ON a.CodVinculo = b.CodVinculo
	WHERE a.EstaEnPedido = 0

	UPDATE a
	SET a.EsCross = 0
	FROM @TablaCross a
	INNER JOIN (
		SELECT CodVinculo
		FROM @TablaCross
		WHERE EstaEnPedido = 0
		GROUP BY CodVinculo
		HAVING COUNT(CUV) > 1
		) b ON a.CodVinculo = b.CodVinculo
	WHERE a.EstaEnPedido = 0

	UPDATE a
	SET a.PrecioOk = 1
	FROM @TablaCross a
	INNER JOIN (
		SELECT CUV
		FROM @TablaCross
		WHERE PrecioCatalogo <= PPU
		) b ON a.CUV = b.CUV
	WHERE a.EstaEnPedido = 0

	-- PASO 5 (validar GAP)
	DECLARE @GAP DECIMAL(15, 2)
		,@TipoMeta CHAR(2)

	IF (@TipoProductoMostrar = 1)
	BEGIN
		DECLARE @MontoHasta NUMERIC(15, 2)

		SELECT TOP 1 @MontoHasta = MontoHasta
			,@TipoMeta = PorDescuento
		FROM dbo.Fn_GetEscalaDescuentoZona(@CampaniaID,@CodigoRegion,@CodigoZona)
		WHERE MontoHasta >= ISNULL(@MontoEscala, 0)

		IF (@MontoHasta > @MontoMinPedido)
		BEGIN
			SELECT TOP 1 @TipoMeta = PorDescuento
			FROM dbo.Fn_GetEscalaDescuentoZona(@CampaniaID,@CodigoRegion,@CodigoZona)
			WHERE PorDescuento > @TipoMeta
		END

		SET @GAP = (@MontoHasta - @MontoTotal)
	END
	ELSE
	BEGIN
		IF (@MontoTotal > @MontoMinPedido)
			IF @MontoEscala > @MontoMinPedido
				SET @GAP = 0
			ELSE
				SET @GAP = (@MontoMinPedido - @MontoEscala)
		ELSE
			SET @GAP = (@MontoMinPedido - @MontoTotal)
	END

	--5.1 (actualizar TipoMeta)
	UPDATE a
	SET a.TipoMeta = (
			CASE 
				WHEN @TipoProductoMostrar = 1
					THEN @TipoMeta
				ELSE 'MM'
				END
			)
		,a.OrdenMeta = (
			CASE 
				WHEN @TipoProductoMostrar = 1
					THEN 2
				ELSE 1
				END
			)
	FROM @TablaCross a
	INNER JOIN (
		SELECT CUV
		FROM @TablaCross
		WHERE PrecioCatalogo >= @GAP
		) b ON a.CUV = b.CUV
	WHERE a.EstaEnPedido = 0

	--5.2 (actualizar GM)
	UPDATE a
	SET a.TipoMeta = 'GM'
		,a.OrdenMeta = 3
	FROM @TablaCross a
	INNER JOIN (
		SELECT CUV
		FROM @TablaCross
		WHERE PrecioCatalogo < @GAP
		) b ON a.CUV = b.CUV
	WHERE a.EstaEnPedido = 0

	--PASO 6 (validar cuvs faltantes)
	DECLARE @tablaCuvFaltante TABLE (CUV VARCHAR(6))

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
			)

	--  6.1 (eliminar cuv faltantes)
	DELETE
	FROM @TablaCross
	WHERE CUV IN (
			SELECT CUV
			FROM @tablaCuvFaltante
			)
		AND EstaEnPedido = 0

	-- PASO 7 (obtener ofertas productos)
	DECLARE @OfertaProductoTemp TABLE (
		CampaniaID INT
		,CUV VARCHAR(6)
		,ConfiguracionOfertaID INT
		,TipoOfertaSisID INT
		)

	INSERT INTO @OfertaProductoTemp
	SELECT op.CampaniaID
		,op.CUV
		,op.ConfiguracionOfertaID
		,op.TipoOfertaSisID
	FROM OfertaProducto op WITH (NOLOCK)
	INNER JOIN @TablaCross tc ON op.CampaniaID = tc.CodCampania
		AND op.CUV = tc.CUV
	WHERE tc.EstaEnPedido = 0

	-- PASO 8 (actualizar CUV2 desde ProductoComercial)
	UPDATE tc
	SET tc.CUV2 = pc.CUV
	FROM @TablaCross tc
	INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON tc.CampaniaID = pc.CampaniaID
		AND tc.CodigoSap = pc.CodigoProducto
		AND pc.IndicadorDigitable = 1
	WHERE tc.EstaEnPedido = 0

	-- PASO 9 (filtrar resultados)
	SELECT DISTINCT p.CUV
		,p.Descripcion AS Descripcion
		,(p.PrecioUnitario * p.FactorRepeticion) AS PrecioCatalogo
		,p.PrecioValorizado
		,p.MarcaID AS IdMarca
		,p.PaisID
		,p.AnoCampania AS CampaniaID
		,p.CodigoCatalago
		,p.CodigoProducto AS CodigoSap
		,p.IndicadorMontoMinimo
		,p.IndicadorOferta
		,0 AS EstaEnRevista
		,ISNULL(pcc.EsExpoOferta, 0) AS EsExpoOferta
		,ISNULL(pcc.CUVRevista, '') AS CUVRevista
		,m.Descripcion AS NombreMarca
		,'NO DISPONIBLE' AS DescripcionCategoria
		,'' AS CUVComplemento
		,'' AS DescripcionEstrategia
		,ISNULL(op.ConfiguracionOfertaID, 0) AS ConfiguracionOfertaID
		,ISNULL(op.TipoOfertaSisID, 0) AS TipoOfertaSisID
		,0 AS FlagNueva
		,0 AS TipoEstrategiaID
		,0 AS TieneSugerido
		,CASE 
			WHEN pl.CodigoSAP IS NULL
				THEN 0
			ELSE 1
			END AS TieneLanzamientoCatalogoPersonalizado
		,CASE 
			WHEN pcor.SAP IS NULL
				THEN 0
			ELSE 1
			END AS TieneOfertaRevista
		,ISNULL(pcor.Oferta, '') AS TipoOfertaRevista
		,
		--tc.CodigoSap,
		tc.Orden
		,1 AS TipoCross
		,tc.EsCross
		,tc.TipoMeta
		,tc.OrdenMeta
		,@GAP AS MontoMeta
		,tc.CodVinculo
		,tc.CUVPedido
		,tc.CUV2
	FROM @TablaCross tc
	INNER JOIN ods.ProductoComercial p WITH (NOLOCK) ON tc.CampaniaID = p.CampaniaID
		AND tc.CUV = p.CUV
		AND p.IndicadorDigitable = 1
	LEFT JOIN ProductoComercialConfiguracion pcc WITH (NOLOCK) ON p.AnoCampania = pcc.CampaniaID
		AND p.CUV = pcc.CUV
	LEFT JOIN @OfertaProductoTemp op ON op.CampaniaID = p.CampaniaID
		AND op.CUV = p.CUV
	LEFT JOIN ods.ProductosLanzamiento pl WITH (NOLOCK) ON p.CodigoProducto = pl.CodigoSAP
		AND p.AnoCampania = pl.Campania
	LEFT JOIN ProductoComercialOfertaRevista pcor WITH (NOLOCK) ON p.AnoCampania = pcor.Campania
		AND p.CUV = pcor.CUV
	LEFT JOIN Marca M WITH (NOLOCK) ON p.MarcaId = m.MarcaId
	WHERE --p.IndicadorDigitable = 1 
		--AND p.PrecioCatalogo >= ISNULL(@PrecioMinimo,0)
		--AND p.PrecioCatalogo >= ISNULL(@MontoFaltante,0)
		tc.EstaEnPedido = 0
	ORDER BY tc.OrdenMeta ASC
		,tc.EsCross DESC
		,tc.Orden ASC
END
GO

USE [BelcorpBolivia]
GO
ALTER PROCEDURE [dbo].[GetListaProductoCrossSelling] (@Table1 dbo.ListaOfertaFinalType READONLY)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @codConsultoraForzadas VARCHAR(9) = ''

	SELECT @codConsultoraForzadas = Codigo
	FROM TablaLogicaDatos WITH (NOLOCK)
	WHERE TablaLogicaDatosID = 10002

	DECLARE @CampaniaID INT
		,@CodigoConsultora VARCHAR(30)
		,@TipoProductoMostrar INT
		,@ZonaID INT
		,@CodigoRegion VARCHAR(8)
		,@CodigoZona VARCHAR(8)
		,@MontoMinPedido NUMERIC(15, 2)
		,@MontoTotal MONEY
		,@MontoEscala MONEY

	SELECT @CampaniaID = CampaniaID
		,@CodigoConsultora = CodigoConsultora
		,@ZonaID = ZonaID
		,@CodigoRegion = CodigoRegion
		,@CodigoZona = CodigoZona
		,@MontoMinPedido = MontoMinimo
		,@MontoTotal = MontoTotal
		,@MontoEscala = MontoEscala
	FROM @Table1

	IF (@MontoTotal > @MontoMinPedido)
		IF @MontoEscala > @MontoMinPedido
			SET @TipoProductoMostrar = 1
		ELSE
			SET @TipoProductoMostrar = 2
	ELSE
		SET @TipoProductoMostrar = 2

	-- PASO 1 (obtener cuvs del pedido)
	DECLARE @tablaCuvPedido TABLE (
		CUV VARCHAR(9)
		,CodigoSap VARCHAR(30)
		)

	INSERT INTO @tablaCuvPedido
	SELECT pc.CUV
		,pc.CodigoProducto
	FROM PedidoWebDetalle pd WITH (NOLOCK)
	INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON pd.CampaniaID = pc.AnoCampania
		AND pd.CUV = pc.CUV
		AND pc.IndicadorDigitable = 1
	INNER JOIN ods.Consultora c WITH (NOLOCK) ON pd.ConsultoraID = c.ConsultoraID
	WHERE pd.CampaniaID = @CampaniaID
		AND c.Codigo = @CodigoConsultora

	-- PASO 2 (obtener cuvs personalizados)
	DECLARE @TablaCross TABLE (
		CampaniaID INT
		,CUV VARCHAR(6)
		,CodigoSap VARCHAR(30)
		,PrecioCatalogo DECIMAL(15, 2)
		,CodVinculo INT
		,PPU DECIMAL(15, 2)
		,Orden INT
		,EsCross BIT
		,PrecioOk BIT
		,TipoMeta CHAR(2)
		,OrdenMeta INT
		,CUVPedido VARCHAR(6)
		,CUV2 VARCHAR(6)
		,MarcaID INT
		,CodCampania INT
		,EstaEnPedido BIT
		,CodConsultora VARCHAR(20)
		)

	INSERT INTO @TablaCross
	SELECT pc.CampaniaID
		,pc.CUV
		,pc.CodigoProducto
		,pc.PrecioCatalogo
		,op.CodVinculo
		,op.PPU
		,op.Orden
		,1
		,0
		,''
		,0
		,''
		,''
		,pc.MarcaID
		,pc.AnoCampania
		,0
		,op.CodConsultora
	FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
	INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON op.AnioCampanaVenta = pc.AnoCampania
		AND op.CUV = pc.CUV
		AND op.CodConsultora IN (
			@CodigoConsultora
			,@codConsultoraForzadas
			)
		AND op.TipoPersonalizacion = 'OF'
	WHERE op.AnioCampanaVenta = @CampaniaID
		AND pc.IndicadorDigitable = 1
		AND pc.EstrategiaIdSicc != '2003'

	-- PASO 3 (validar si hay cuvs personalizados)
	DECLARE @cantOfertas INT = 0
		,@codConsultoraGenerica VARCHAR(30) = ''

	SELECT @cantOfertas = COUNT(1)
	FROM @TablaCross
	WHERE CodConsultora != @codConsultoraForzadas

	IF ISNULL(@cantOfertas, 0) = 0
	BEGIN
		SELECT @codConsultoraGenerica = Codigo
		FROM TablaLogicaDatos
		WHERE TablaLogicaDatosID = 10001

		IF ISNULL(@codConsultoraGenerica, '') != ''
		BEGIN
			INSERT INTO @TablaCross
			SELECT pc.CampaniaID
				,pc.CUV
				,pc.CodigoProducto
				,pc.PrecioCatalogo
				,op.CodVinculo
				,op.PPU
				,op.Orden
				,1
				,0
				,''
				,0
				,''
				,''
				,pc.MarcaID
				,pc.AnoCampania
				,0
				,op.CodConsultora
			FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
			INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON op.AnioCampanaVenta = pc.AnoCampania
				AND op.CUV = pc.CUV
				AND op.CodConsultora = @codConsultoraGenerica
				AND op.TipoPersonalizacion = 'OF'
			WHERE op.AnioCampanaVenta = @CampaniaID
				AND pc.IndicadorDigitable = 1
				AND pc.EstrategiaIdSicc != '2003'
		END
	END

	-- PASO 4 (validar datos de las ofertas)
	UPDATE a
	SET a.EstaEnPedido = 1
		,a.CUVPedido = b.CUV
	FROM @TablaCross a
	INNER JOIN @TablaCuvPedido b ON a.CodigoSap = b.CodigoSap

	UPDATE a
	SET a.CUVPedido = b.CUVPedido
	FROM @TablaCross a
	INNER JOIN (
		SELECT CodVinculo
			,CUVPedido
		FROM @TablaCross
		WHERE EstaEnPedido = 1
		) b ON a.CodVinculo = b.CodVinculo
	WHERE a.EstaEnPedido = 0

	UPDATE a
	SET a.EsCross = 0
	FROM @TablaCross a
	INNER JOIN (
		SELECT CodVinculo
		FROM @TablaCross
		WHERE EstaEnPedido = 0
		GROUP BY CodVinculo
		HAVING COUNT(CUV) > 1
		) b ON a.CodVinculo = b.CodVinculo
	WHERE a.EstaEnPedido = 0

	UPDATE a
	SET a.PrecioOk = 1
	FROM @TablaCross a
	INNER JOIN (
		SELECT CUV
		FROM @TablaCross
		WHERE PrecioCatalogo <= PPU
		) b ON a.CUV = b.CUV
	WHERE a.EstaEnPedido = 0

	-- PASO 5 (validar GAP)
	DECLARE @GAP DECIMAL(15, 2)
		,@TipoMeta CHAR(2)

	IF (@TipoProductoMostrar = 1)
	BEGIN
		DECLARE @MontoHasta NUMERIC(15, 2)

		SELECT TOP 1 @MontoHasta = MontoHasta
			,@TipoMeta = PorDescuento
		FROM dbo.Fn_GetEscalaDescuentoZona(@CampaniaID,@CodigoRegion,@CodigoZona)
		WHERE MontoHasta >= ISNULL(@MontoEscala, 0)

		IF (@MontoHasta > @MontoMinPedido)
		BEGIN
			SELECT TOP 1 @TipoMeta = PorDescuento
			FROM dbo.Fn_GetEscalaDescuentoZona(@CampaniaID,@CodigoRegion,@CodigoZona)
			WHERE PorDescuento > @TipoMeta
		END

		SET @GAP = (@MontoHasta - @MontoTotal)
	END
	ELSE
	BEGIN
		IF (@MontoTotal > @MontoMinPedido)
			IF @MontoEscala > @MontoMinPedido
				SET @GAP = 0
			ELSE
				SET @GAP = (@MontoMinPedido - @MontoEscala)
		ELSE
			SET @GAP = (@MontoMinPedido - @MontoTotal)
	END

	--5.1 (actualizar TipoMeta)
	UPDATE a
	SET a.TipoMeta = (
			CASE 
				WHEN @TipoProductoMostrar = 1
					THEN @TipoMeta
				ELSE 'MM'
				END
			)
		,a.OrdenMeta = (
			CASE 
				WHEN @TipoProductoMostrar = 1
					THEN 2
				ELSE 1
				END
			)
	FROM @TablaCross a
	INNER JOIN (
		SELECT CUV
		FROM @TablaCross
		WHERE PrecioCatalogo >= @GAP
		) b ON a.CUV = b.CUV
	WHERE a.EstaEnPedido = 0

	--5.2 (actualizar GM)
	UPDATE a
	SET a.TipoMeta = 'GM'
		,a.OrdenMeta = 3
	FROM @TablaCross a
	INNER JOIN (
		SELECT CUV
		FROM @TablaCross
		WHERE PrecioCatalogo < @GAP
		) b ON a.CUV = b.CUV
	WHERE a.EstaEnPedido = 0

	--PASO 6 (validar cuvs faltantes)
	DECLARE @tablaCuvFaltante TABLE (CUV VARCHAR(6))

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
			)

	--  6.1 (eliminar cuv faltantes)
	DELETE
	FROM @TablaCross
	WHERE CUV IN (
			SELECT CUV
			FROM @tablaCuvFaltante
			)
		AND EstaEnPedido = 0

	-- PASO 7 (obtener ofertas productos)
	DECLARE @OfertaProductoTemp TABLE (
		CampaniaID INT
		,CUV VARCHAR(6)
		,ConfiguracionOfertaID INT
		,TipoOfertaSisID INT
		)

	INSERT INTO @OfertaProductoTemp
	SELECT op.CampaniaID
		,op.CUV
		,op.ConfiguracionOfertaID
		,op.TipoOfertaSisID
	FROM OfertaProducto op WITH (NOLOCK)
	INNER JOIN @TablaCross tc ON op.CampaniaID = tc.CodCampania
		AND op.CUV = tc.CUV
	WHERE tc.EstaEnPedido = 0

	-- PASO 8 (actualizar CUV2 desde ProductoComercial)
	UPDATE tc
	SET tc.CUV2 = pc.CUV
	FROM @TablaCross tc
	INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON tc.CampaniaID = pc.CampaniaID
		AND tc.CodigoSap = pc.CodigoProducto
		AND pc.IndicadorDigitable = 1
	WHERE tc.EstaEnPedido = 0

	-- PASO 9 (filtrar resultados)
	SELECT DISTINCT p.CUV
		,p.Descripcion AS Descripcion
		,(p.PrecioUnitario * p.FactorRepeticion) AS PrecioCatalogo
		,p.PrecioValorizado
		,p.MarcaID AS IdMarca
		,p.PaisID
		,p.AnoCampania AS CampaniaID
		,p.CodigoCatalago
		,p.CodigoProducto AS CodigoSap
		,p.IndicadorMontoMinimo
		,p.IndicadorOferta
		,0 AS EstaEnRevista
		,ISNULL(pcc.EsExpoOferta, 0) AS EsExpoOferta
		,ISNULL(pcc.CUVRevista, '') AS CUVRevista
		,m.Descripcion AS NombreMarca
		,'NO DISPONIBLE' AS DescripcionCategoria
		,'' AS CUVComplemento
		,'' AS DescripcionEstrategia
		,ISNULL(op.ConfiguracionOfertaID, 0) AS ConfiguracionOfertaID
		,ISNULL(op.TipoOfertaSisID, 0) AS TipoOfertaSisID
		,0 AS FlagNueva
		,0 AS TipoEstrategiaID
		,0 AS TieneSugerido
		,CASE 
			WHEN pl.CodigoSAP IS NULL
				THEN 0
			ELSE 1
			END AS TieneLanzamientoCatalogoPersonalizado
		,CASE 
			WHEN pcor.SAP IS NULL
				THEN 0
			ELSE 1
			END AS TieneOfertaRevista
		,ISNULL(pcor.Oferta, '') AS TipoOfertaRevista
		,
		--tc.CodigoSap,
		tc.Orden
		,1 AS TipoCross
		,tc.EsCross
		,tc.TipoMeta
		,tc.OrdenMeta
		,@GAP AS MontoMeta
		,tc.CodVinculo
		,tc.CUVPedido
		,tc.CUV2
	FROM @TablaCross tc
	INNER JOIN ods.ProductoComercial p WITH (NOLOCK) ON tc.CampaniaID = p.CampaniaID
		AND tc.CUV = p.CUV
		AND p.IndicadorDigitable = 1
	LEFT JOIN ProductoComercialConfiguracion pcc WITH (NOLOCK) ON p.AnoCampania = pcc.CampaniaID
		AND p.CUV = pcc.CUV
	LEFT JOIN @OfertaProductoTemp op ON op.CampaniaID = p.CampaniaID
		AND op.CUV = p.CUV
	LEFT JOIN ods.ProductosLanzamiento pl WITH (NOLOCK) ON p.CodigoProducto = pl.CodigoSAP
		AND p.AnoCampania = pl.Campania
	LEFT JOIN ProductoComercialOfertaRevista pcor WITH (NOLOCK) ON p.AnoCampania = pcor.Campania
		AND p.CUV = pcor.CUV
	LEFT JOIN Marca M WITH (NOLOCK) ON p.MarcaId = m.MarcaId
	WHERE --p.IndicadorDigitable = 1 
		--AND p.PrecioCatalogo >= ISNULL(@PrecioMinimo,0)
		--AND p.PrecioCatalogo >= ISNULL(@MontoFaltante,0)
		tc.EstaEnPedido = 0
	ORDER BY tc.OrdenMeta ASC
		,tc.EsCross DESC
		,tc.Orden ASC
END
GO

USE [BelcorpChile]
GO
ALTER PROCEDURE [dbo].[GetListaProductoCrossSelling] (@Table1 dbo.ListaOfertaFinalType READONLY)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @codConsultoraForzadas VARCHAR(9) = ''

	SELECT @codConsultoraForzadas = Codigo
	FROM TablaLogicaDatos WITH (NOLOCK)
	WHERE TablaLogicaDatosID = 10002

	DECLARE @CampaniaID INT
		,@CodigoConsultora VARCHAR(30)
		,@TipoProductoMostrar INT
		,@ZonaID INT
		,@CodigoRegion VARCHAR(8)
		,@CodigoZona VARCHAR(8)
		,@MontoMinPedido NUMERIC(15, 2)
		,@MontoTotal MONEY
		,@MontoEscala MONEY

	SELECT @CampaniaID = CampaniaID
		,@CodigoConsultora = CodigoConsultora
		,@ZonaID = ZonaID
		,@CodigoRegion = CodigoRegion
		,@CodigoZona = CodigoZona
		,@MontoMinPedido = MontoMinimo
		,@MontoTotal = MontoTotal
		,@MontoEscala = MontoEscala
	FROM @Table1

	IF (@MontoTotal > @MontoMinPedido)
		IF @MontoEscala > @MontoMinPedido
			SET @TipoProductoMostrar = 1
		ELSE
			SET @TipoProductoMostrar = 2
	ELSE
		SET @TipoProductoMostrar = 2

	-- PASO 1 (obtener cuvs del pedido)
	DECLARE @tablaCuvPedido TABLE (
		CUV VARCHAR(9)
		,CodigoSap VARCHAR(30)
		)

	INSERT INTO @tablaCuvPedido
	SELECT pc.CUV
		,pc.CodigoProducto
	FROM PedidoWebDetalle pd WITH (NOLOCK)
	INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON pd.CampaniaID = pc.AnoCampania
		AND pd.CUV = pc.CUV
		AND pc.IndicadorDigitable = 1
	INNER JOIN ods.Consultora c WITH (NOLOCK) ON pd.ConsultoraID = c.ConsultoraID
	WHERE pd.CampaniaID = @CampaniaID
		AND c.Codigo = @CodigoConsultora

	-- PASO 2 (obtener cuvs personalizados)
	DECLARE @TablaCross TABLE (
		CampaniaID INT
		,CUV VARCHAR(6)
		,CodigoSap VARCHAR(30)
		,PrecioCatalogo DECIMAL(15, 2)
		,CodVinculo INT
		,PPU DECIMAL(15, 2)
		,Orden INT
		,EsCross BIT
		,PrecioOk BIT
		,TipoMeta CHAR(2)
		,OrdenMeta INT
		,CUVPedido VARCHAR(6)
		,CUV2 VARCHAR(6)
		,MarcaID INT
		,CodCampania INT
		,EstaEnPedido BIT
		,CodConsultora VARCHAR(20)
		)

	INSERT INTO @TablaCross
	SELECT pc.CampaniaID
		,pc.CUV
		,pc.CodigoProducto
		,pc.PrecioCatalogo
		,op.CodVinculo
		,op.PPU
		,op.Orden
		,1
		,0
		,''
		,0
		,''
		,''
		,pc.MarcaID
		,pc.AnoCampania
		,0
		,op.CodConsultora
	FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
	INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON op.AnioCampanaVenta = pc.AnoCampania
		AND op.CUV = pc.CUV
		AND op.CodConsultora IN (
			@CodigoConsultora
			,@codConsultoraForzadas
			)
		AND op.TipoPersonalizacion = 'OF'
	WHERE op.AnioCampanaVenta = @CampaniaID
		AND pc.IndicadorDigitable = 1
		AND pc.EstrategiaIdSicc != '2003'

	-- PASO 3 (validar si hay cuvs personalizados)
	DECLARE @cantOfertas INT = 0
		,@codConsultoraGenerica VARCHAR(30) = ''

	SELECT @cantOfertas = COUNT(1)
	FROM @TablaCross
	WHERE CodConsultora != @codConsultoraForzadas

	IF ISNULL(@cantOfertas, 0) = 0
	BEGIN
		SELECT @codConsultoraGenerica = Codigo
		FROM TablaLogicaDatos
		WHERE TablaLogicaDatosID = 10001

		IF ISNULL(@codConsultoraGenerica, '') != ''
		BEGIN
			INSERT INTO @TablaCross
			SELECT pc.CampaniaID
				,pc.CUV
				,pc.CodigoProducto
				,pc.PrecioCatalogo
				,op.CodVinculo
				,op.PPU
				,op.Orden
				,1
				,0
				,''
				,0
				,''
				,''
				,pc.MarcaID
				,pc.AnoCampania
				,0
				,op.CodConsultora
			FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
			INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON op.AnioCampanaVenta = pc.AnoCampania
				AND op.CUV = pc.CUV
				AND op.CodConsultora = @codConsultoraGenerica
				AND op.TipoPersonalizacion = 'OF'
			WHERE op.AnioCampanaVenta = @CampaniaID
				AND pc.IndicadorDigitable = 1
				AND pc.EstrategiaIdSicc != '2003'
		END
	END

	-- PASO 4 (validar datos de las ofertas)
	UPDATE a
	SET a.EstaEnPedido = 1
		,a.CUVPedido = b.CUV
	FROM @TablaCross a
	INNER JOIN @TablaCuvPedido b ON a.CodigoSap = b.CodigoSap

	UPDATE a
	SET a.CUVPedido = b.CUVPedido
	FROM @TablaCross a
	INNER JOIN (
		SELECT CodVinculo
			,CUVPedido
		FROM @TablaCross
		WHERE EstaEnPedido = 1
		) b ON a.CodVinculo = b.CodVinculo
	WHERE a.EstaEnPedido = 0

	UPDATE a
	SET a.EsCross = 0
	FROM @TablaCross a
	INNER JOIN (
		SELECT CodVinculo
		FROM @TablaCross
		WHERE EstaEnPedido = 0
		GROUP BY CodVinculo
		HAVING COUNT(CUV) > 1
		) b ON a.CodVinculo = b.CodVinculo
	WHERE a.EstaEnPedido = 0

	UPDATE a
	SET a.PrecioOk = 1
	FROM @TablaCross a
	INNER JOIN (
		SELECT CUV
		FROM @TablaCross
		WHERE PrecioCatalogo <= PPU
		) b ON a.CUV = b.CUV
	WHERE a.EstaEnPedido = 0

	-- PASO 5 (validar GAP)
	DECLARE @GAP DECIMAL(15, 2)
		,@TipoMeta CHAR(2)

	IF (@TipoProductoMostrar = 1)
	BEGIN
		DECLARE @MontoHasta NUMERIC(15, 2)

		SELECT TOP 1 @MontoHasta = MontoHasta
			,@TipoMeta = PorDescuento
		FROM dbo.Fn_GetEscalaDescuentoZona(@CampaniaID,@CodigoRegion,@CodigoZona)
		WHERE MontoHasta >= ISNULL(@MontoEscala, 0)

		IF (@MontoHasta > @MontoMinPedido)
		BEGIN
			SELECT TOP 1 @TipoMeta = PorDescuento
			FROM dbo.Fn_GetEscalaDescuentoZona(@CampaniaID,@CodigoRegion,@CodigoZona)
			WHERE PorDescuento > @TipoMeta
		END

		SET @GAP = (@MontoHasta - @MontoTotal)
	END
	ELSE
	BEGIN
		IF (@MontoTotal > @MontoMinPedido)
			IF @MontoEscala > @MontoMinPedido
				SET @GAP = 0
			ELSE
				SET @GAP = (@MontoMinPedido - @MontoEscala)
		ELSE
			SET @GAP = (@MontoMinPedido - @MontoTotal)
	END

	--5.1 (actualizar TipoMeta)
	UPDATE a
	SET a.TipoMeta = (
			CASE 
				WHEN @TipoProductoMostrar = 1
					THEN @TipoMeta
				ELSE 'MM'
				END
			)
		,a.OrdenMeta = (
			CASE 
				WHEN @TipoProductoMostrar = 1
					THEN 2
				ELSE 1
				END
			)
	FROM @TablaCross a
	INNER JOIN (
		SELECT CUV
		FROM @TablaCross
		WHERE PrecioCatalogo >= @GAP
		) b ON a.CUV = b.CUV
	WHERE a.EstaEnPedido = 0

	--5.2 (actualizar GM)
	UPDATE a
	SET a.TipoMeta = 'GM'
		,a.OrdenMeta = 3
	FROM @TablaCross a
	INNER JOIN (
		SELECT CUV
		FROM @TablaCross
		WHERE PrecioCatalogo < @GAP
		) b ON a.CUV = b.CUV
	WHERE a.EstaEnPedido = 0

	--PASO 6 (validar cuvs faltantes)
	DECLARE @tablaCuvFaltante TABLE (CUV VARCHAR(6))

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
			)

	--  6.1 (eliminar cuv faltantes)
	DELETE
	FROM @TablaCross
	WHERE CUV IN (
			SELECT CUV
			FROM @tablaCuvFaltante
			)
		AND EstaEnPedido = 0

	-- PASO 7 (obtener ofertas productos)
	DECLARE @OfertaProductoTemp TABLE (
		CampaniaID INT
		,CUV VARCHAR(6)
		,ConfiguracionOfertaID INT
		,TipoOfertaSisID INT
		)

	INSERT INTO @OfertaProductoTemp
	SELECT op.CampaniaID
		,op.CUV
		,op.ConfiguracionOfertaID
		,op.TipoOfertaSisID
	FROM OfertaProducto op WITH (NOLOCK)
	INNER JOIN @TablaCross tc ON op.CampaniaID = tc.CodCampania
		AND op.CUV = tc.CUV
	WHERE tc.EstaEnPedido = 0

	-- PASO 8 (actualizar CUV2 desde ProductoComercial)
	UPDATE tc
	SET tc.CUV2 = pc.CUV
	FROM @TablaCross tc
	INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON tc.CampaniaID = pc.CampaniaID
		AND tc.CodigoSap = pc.CodigoProducto
		AND pc.IndicadorDigitable = 1
	WHERE tc.EstaEnPedido = 0

	-- PASO 9 (filtrar resultados)
	SELECT DISTINCT p.CUV
		,p.Descripcion AS Descripcion
		,(p.PrecioUnitario * p.FactorRepeticion) AS PrecioCatalogo
		,p.PrecioValorizado
		,p.MarcaID AS IdMarca
		,p.PaisID
		,p.AnoCampania AS CampaniaID
		,p.CodigoCatalago
		,p.CodigoProducto AS CodigoSap
		,p.IndicadorMontoMinimo
		,p.IndicadorOferta
		,0 AS EstaEnRevista
		,ISNULL(pcc.EsExpoOferta, 0) AS EsExpoOferta
		,ISNULL(pcc.CUVRevista, '') AS CUVRevista
		,m.Descripcion AS NombreMarca
		,'NO DISPONIBLE' AS DescripcionCategoria
		,'' AS CUVComplemento
		,'' AS DescripcionEstrategia
		,ISNULL(op.ConfiguracionOfertaID, 0) AS ConfiguracionOfertaID
		,ISNULL(op.TipoOfertaSisID, 0) AS TipoOfertaSisID
		,0 AS FlagNueva
		,0 AS TipoEstrategiaID
		,0 AS TieneSugerido
		,CASE 
			WHEN pl.CodigoSAP IS NULL
				THEN 0
			ELSE 1
			END AS TieneLanzamientoCatalogoPersonalizado
		,CASE 
			WHEN pcor.SAP IS NULL
				THEN 0
			ELSE 1
			END AS TieneOfertaRevista
		,ISNULL(pcor.Oferta, '') AS TipoOfertaRevista
		,
		--tc.CodigoSap,
		tc.Orden
		,1 AS TipoCross
		,tc.EsCross
		,tc.TipoMeta
		,tc.OrdenMeta
		,@GAP AS MontoMeta
		,tc.CodVinculo
		,tc.CUVPedido
		,tc.CUV2
	FROM @TablaCross tc
	INNER JOIN ods.ProductoComercial p WITH (NOLOCK) ON tc.CampaniaID = p.CampaniaID
		AND tc.CUV = p.CUV
		AND p.IndicadorDigitable = 1
	LEFT JOIN ProductoComercialConfiguracion pcc WITH (NOLOCK) ON p.AnoCampania = pcc.CampaniaID
		AND p.CUV = pcc.CUV
	LEFT JOIN @OfertaProductoTemp op ON op.CampaniaID = p.CampaniaID
		AND op.CUV = p.CUV
	LEFT JOIN ods.ProductosLanzamiento pl WITH (NOLOCK) ON p.CodigoProducto = pl.CodigoSAP
		AND p.AnoCampania = pl.Campania
	LEFT JOIN ProductoComercialOfertaRevista pcor WITH (NOLOCK) ON p.AnoCampania = pcor.Campania
		AND p.CUV = pcor.CUV
	LEFT JOIN Marca M WITH (NOLOCK) ON p.MarcaId = m.MarcaId
	WHERE --p.IndicadorDigitable = 1 
		--AND p.PrecioCatalogo >= ISNULL(@PrecioMinimo,0)
		--AND p.PrecioCatalogo >= ISNULL(@MontoFaltante,0)
		tc.EstaEnPedido = 0
	ORDER BY tc.OrdenMeta ASC
		,tc.EsCross DESC
		,tc.Orden ASC
END
GO

USE [BelcorpColombia]
GO
ALTER PROCEDURE [dbo].[GetListaProductoCrossSelling] (@Table1 dbo.ListaOfertaFinalType READONLY)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @codConsultoraForzadas VARCHAR(9) = ''

	SELECT @codConsultoraForzadas = Codigo
	FROM TablaLogicaDatos WITH (NOLOCK)
	WHERE TablaLogicaDatosID = 10002

	DECLARE @CampaniaID INT
		,@CodigoConsultora VARCHAR(30)
		,@TipoProductoMostrar INT
		,@ZonaID INT
		,@CodigoRegion VARCHAR(8)
		,@CodigoZona VARCHAR(8)
		,@MontoMinPedido NUMERIC(15, 2)
		,@MontoTotal MONEY
		,@MontoEscala MONEY

	SELECT @CampaniaID = CampaniaID
		,@CodigoConsultora = CodigoConsultora
		,@ZonaID = ZonaID
		,@CodigoRegion = CodigoRegion
		,@CodigoZona = CodigoZona
		,@MontoMinPedido = MontoMinimo
		,@MontoTotal = MontoTotal
		,@MontoEscala = MontoEscala
	FROM @Table1

	IF (@MontoTotal > @MontoMinPedido)
		IF @MontoEscala > @MontoMinPedido
			SET @TipoProductoMostrar = 1
		ELSE
			SET @TipoProductoMostrar = 2
	ELSE
		SET @TipoProductoMostrar = 2

	-- PASO 1 (obtener cuvs del pedido)
	DECLARE @tablaCuvPedido TABLE (
		CUV VARCHAR(9)
		,CodigoSap VARCHAR(30)
		)

	INSERT INTO @tablaCuvPedido
	SELECT pc.CUV
		,pc.CodigoProducto
	FROM PedidoWebDetalle pd WITH (NOLOCK)
	INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON pd.CampaniaID = pc.AnoCampania
		AND pd.CUV = pc.CUV
		AND pc.IndicadorDigitable = 1
	INNER JOIN ods.Consultora c WITH (NOLOCK) ON pd.ConsultoraID = c.ConsultoraID
	WHERE pd.CampaniaID = @CampaniaID
		AND c.Codigo = @CodigoConsultora

	-- PASO 2 (obtener cuvs personalizados)
	DECLARE @TablaCross TABLE (
		CampaniaID INT
		,CUV VARCHAR(6)
		,CodigoSap VARCHAR(30)
		,PrecioCatalogo DECIMAL(15, 2)
		,CodVinculo INT
		,PPU DECIMAL(15, 2)
		,Orden INT
		,EsCross BIT
		,PrecioOk BIT
		,TipoMeta CHAR(2)
		,OrdenMeta INT
		,CUVPedido VARCHAR(6)
		,CUV2 VARCHAR(6)
		,MarcaID INT
		,CodCampania INT
		,EstaEnPedido BIT
		,CodConsultora VARCHAR(20)
		)

	INSERT INTO @TablaCross
	SELECT pc.CampaniaID
		,pc.CUV
		,pc.CodigoProducto
		,pc.PrecioCatalogo
		,op.CodVinculo
		,op.PPU
		,op.Orden
		,1
		,0
		,''
		,0
		,''
		,''
		,pc.MarcaID
		,pc.AnoCampania
		,0
		,op.CodConsultora
	FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
	INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON op.AnioCampanaVenta = pc.AnoCampania
		AND op.CUV = pc.CUV
		AND op.CodConsultora IN (
			@CodigoConsultora
			,@codConsultoraForzadas
			)
		AND op.TipoPersonalizacion = 'OF'
	WHERE op.AnioCampanaVenta = @CampaniaID
		AND pc.IndicadorDigitable = 1
		AND pc.EstrategiaIdSicc != '2003'

	-- PASO 3 (validar si hay cuvs personalizados)
	DECLARE @cantOfertas INT = 0
		,@codConsultoraGenerica VARCHAR(30) = ''

	SELECT @cantOfertas = COUNT(1)
	FROM @TablaCross
	WHERE CodConsultora != @codConsultoraForzadas

	IF ISNULL(@cantOfertas, 0) = 0
	BEGIN
		SELECT @codConsultoraGenerica = Codigo
		FROM TablaLogicaDatos
		WHERE TablaLogicaDatosID = 10001

		IF ISNULL(@codConsultoraGenerica, '') != ''
		BEGIN
			INSERT INTO @TablaCross
			SELECT pc.CampaniaID
				,pc.CUV
				,pc.CodigoProducto
				,pc.PrecioCatalogo
				,op.CodVinculo
				,op.PPU
				,op.Orden
				,1
				,0
				,''
				,0
				,''
				,''
				,pc.MarcaID
				,pc.AnoCampania
				,0
				,op.CodConsultora
			FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
			INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON op.AnioCampanaVenta = pc.AnoCampania
				AND op.CUV = pc.CUV
				AND op.CodConsultora = @codConsultoraGenerica
				AND op.TipoPersonalizacion = 'OF'
			WHERE op.AnioCampanaVenta = @CampaniaID
				AND pc.IndicadorDigitable = 1
				AND pc.EstrategiaIdSicc != '2003'
		END
	END

	-- PASO 4 (validar datos de las ofertas)
	UPDATE a
	SET a.EstaEnPedido = 1
		,a.CUVPedido = b.CUV
	FROM @TablaCross a
	INNER JOIN @TablaCuvPedido b ON a.CodigoSap = b.CodigoSap

	UPDATE a
	SET a.CUVPedido = b.CUVPedido
	FROM @TablaCross a
	INNER JOIN (
		SELECT CodVinculo
			,CUVPedido
		FROM @TablaCross
		WHERE EstaEnPedido = 1
		) b ON a.CodVinculo = b.CodVinculo
	WHERE a.EstaEnPedido = 0

	UPDATE a
	SET a.EsCross = 0
	FROM @TablaCross a
	INNER JOIN (
		SELECT CodVinculo
		FROM @TablaCross
		WHERE EstaEnPedido = 0
		GROUP BY CodVinculo
		HAVING COUNT(CUV) > 1
		) b ON a.CodVinculo = b.CodVinculo
	WHERE a.EstaEnPedido = 0

	UPDATE a
	SET a.PrecioOk = 1
	FROM @TablaCross a
	INNER JOIN (
		SELECT CUV
		FROM @TablaCross
		WHERE PrecioCatalogo <= PPU
		) b ON a.CUV = b.CUV
	WHERE a.EstaEnPedido = 0

	-- PASO 5 (validar GAP)
	DECLARE @GAP DECIMAL(15, 2)
		,@TipoMeta CHAR(2)

	IF (@TipoProductoMostrar = 1)
	BEGIN
		DECLARE @MontoHasta NUMERIC(15, 2)

		SELECT TOP 1 @MontoHasta = MontoHasta
			,@TipoMeta = PorDescuento
		FROM dbo.Fn_GetEscalaDescuentoZona(@CampaniaID,@CodigoRegion,@CodigoZona)
		WHERE MontoHasta >= ISNULL(@MontoEscala, 0)

		IF (@MontoHasta > @MontoMinPedido)
		BEGIN
			SELECT TOP 1 @TipoMeta = PorDescuento
			FROM dbo.Fn_GetEscalaDescuentoZona(@CampaniaID,@CodigoRegion,@CodigoZona)
			WHERE PorDescuento > @TipoMeta
		END

		SET @GAP = (@MontoHasta - @MontoTotal)
	END
	ELSE
	BEGIN
		IF (@MontoTotal > @MontoMinPedido)
			IF @MontoEscala > @MontoMinPedido
				SET @GAP = 0
			ELSE
				SET @GAP = (@MontoMinPedido - @MontoEscala)
		ELSE
			SET @GAP = (@MontoMinPedido - @MontoTotal)
	END

	--5.1 (actualizar TipoMeta)
	UPDATE a
	SET a.TipoMeta = (
			CASE 
				WHEN @TipoProductoMostrar = 1
					THEN @TipoMeta
				ELSE 'MM'
				END
			)
		,a.OrdenMeta = (
			CASE 
				WHEN @TipoProductoMostrar = 1
					THEN 2
				ELSE 1
				END
			)
	FROM @TablaCross a
	INNER JOIN (
		SELECT CUV
		FROM @TablaCross
		WHERE PrecioCatalogo >= @GAP
		) b ON a.CUV = b.CUV
	WHERE a.EstaEnPedido = 0

	--5.2 (actualizar GM)
	UPDATE a
	SET a.TipoMeta = 'GM'
		,a.OrdenMeta = 3
	FROM @TablaCross a
	INNER JOIN (
		SELECT CUV
		FROM @TablaCross
		WHERE PrecioCatalogo < @GAP
		) b ON a.CUV = b.CUV
	WHERE a.EstaEnPedido = 0

	--PASO 6 (validar cuvs faltantes)
	DECLARE @tablaCuvFaltante TABLE (CUV VARCHAR(6))

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
			)

	--  6.1 (eliminar cuv faltantes)
	DELETE
	FROM @TablaCross
	WHERE CUV IN (
			SELECT CUV
			FROM @tablaCuvFaltante
			)
		AND EstaEnPedido = 0

	-- PASO 7 (obtener ofertas productos)
	DECLARE @OfertaProductoTemp TABLE (
		CampaniaID INT
		,CUV VARCHAR(6)
		,ConfiguracionOfertaID INT
		,TipoOfertaSisID INT
		)

	INSERT INTO @OfertaProductoTemp
	SELECT op.CampaniaID
		,op.CUV
		,op.ConfiguracionOfertaID
		,op.TipoOfertaSisID
	FROM OfertaProducto op WITH (NOLOCK)
	INNER JOIN @TablaCross tc ON op.CampaniaID = tc.CodCampania
		AND op.CUV = tc.CUV
	WHERE tc.EstaEnPedido = 0

	-- PASO 8 (actualizar CUV2 desde ProductoComercial)
	UPDATE tc
	SET tc.CUV2 = pc.CUV
	FROM @TablaCross tc
	INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON tc.CampaniaID = pc.CampaniaID
		AND tc.CodigoSap = pc.CodigoProducto
		AND pc.IndicadorDigitable = 1
	WHERE tc.EstaEnPedido = 0

	-- PASO 9 (filtrar resultados)
	SELECT DISTINCT p.CUV
		,p.Descripcion AS Descripcion
		,(p.PrecioUnitario * p.FactorRepeticion) AS PrecioCatalogo
		,p.PrecioValorizado
		,p.MarcaID AS IdMarca
		,p.PaisID
		,p.AnoCampania AS CampaniaID
		,p.CodigoCatalago
		,p.CodigoProducto AS CodigoSap
		,p.IndicadorMontoMinimo
		,p.IndicadorOferta
		,0 AS EstaEnRevista
		,ISNULL(pcc.EsExpoOferta, 0) AS EsExpoOferta
		,ISNULL(pcc.CUVRevista, '') AS CUVRevista
		,m.Descripcion AS NombreMarca
		,'NO DISPONIBLE' AS DescripcionCategoria
		,'' AS CUVComplemento
		,'' AS DescripcionEstrategia
		,ISNULL(op.ConfiguracionOfertaID, 0) AS ConfiguracionOfertaID
		,ISNULL(op.TipoOfertaSisID, 0) AS TipoOfertaSisID
		,0 AS FlagNueva
		,0 AS TipoEstrategiaID
		,0 AS TieneSugerido
		,CASE 
			WHEN pl.CodigoSAP IS NULL
				THEN 0
			ELSE 1
			END AS TieneLanzamientoCatalogoPersonalizado
		,CASE 
			WHEN pcor.SAP IS NULL
				THEN 0
			ELSE 1
			END AS TieneOfertaRevista
		,ISNULL(pcor.Oferta, '') AS TipoOfertaRevista
		,
		--tc.CodigoSap,
		tc.Orden
		,1 AS TipoCross
		,tc.EsCross
		,tc.TipoMeta
		,tc.OrdenMeta
		,@GAP AS MontoMeta
		,tc.CodVinculo
		,tc.CUVPedido
		,tc.CUV2
	FROM @TablaCross tc
	INNER JOIN ods.ProductoComercial p WITH (NOLOCK) ON tc.CampaniaID = p.CampaniaID
		AND tc.CUV = p.CUV
		AND p.IndicadorDigitable = 1
	LEFT JOIN ProductoComercialConfiguracion pcc WITH (NOLOCK) ON p.AnoCampania = pcc.CampaniaID
		AND p.CUV = pcc.CUV
	LEFT JOIN @OfertaProductoTemp op ON op.CampaniaID = p.CampaniaID
		AND op.CUV = p.CUV
	LEFT JOIN ods.ProductosLanzamiento pl WITH (NOLOCK) ON p.CodigoProducto = pl.CodigoSAP
		AND p.AnoCampania = pl.Campania
	LEFT JOIN ProductoComercialOfertaRevista pcor WITH (NOLOCK) ON p.AnoCampania = pcor.Campania
		AND p.CUV = pcor.CUV
	LEFT JOIN Marca M WITH (NOLOCK) ON p.MarcaId = m.MarcaId
	WHERE --p.IndicadorDigitable = 1 
		--AND p.PrecioCatalogo >= ISNULL(@PrecioMinimo,0)
		--AND p.PrecioCatalogo >= ISNULL(@MontoFaltante,0)
		tc.EstaEnPedido = 0
	ORDER BY tc.OrdenMeta ASC
		,tc.EsCross DESC
		,tc.Orden ASC
END
GO

USE [BelcorpCostaRica]
GO
ALTER PROCEDURE [dbo].[GetListaProductoCrossSelling] (@Table1 dbo.ListaOfertaFinalType READONLY)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @codConsultoraForzadas VARCHAR(9) = ''

	SELECT @codConsultoraForzadas = Codigo
	FROM TablaLogicaDatos WITH (NOLOCK)
	WHERE TablaLogicaDatosID = 10002

	DECLARE @CampaniaID INT
		,@CodigoConsultora VARCHAR(30)
		,@TipoProductoMostrar INT
		,@ZonaID INT
		,@CodigoRegion VARCHAR(8)
		,@CodigoZona VARCHAR(8)
		,@MontoMinPedido NUMERIC(15, 2)
		,@MontoTotal MONEY
		,@MontoEscala MONEY

	SELECT @CampaniaID = CampaniaID
		,@CodigoConsultora = CodigoConsultora
		,@ZonaID = ZonaID
		,@CodigoRegion = CodigoRegion
		,@CodigoZona = CodigoZona
		,@MontoMinPedido = MontoMinimo
		,@MontoTotal = MontoTotal
		,@MontoEscala = MontoEscala
	FROM @Table1

	IF (@MontoTotal > @MontoMinPedido)
		IF @MontoEscala > @MontoMinPedido
			SET @TipoProductoMostrar = 1
		ELSE
			SET @TipoProductoMostrar = 2
	ELSE
		SET @TipoProductoMostrar = 2

	-- PASO 1 (obtener cuvs del pedido)
	DECLARE @tablaCuvPedido TABLE (
		CUV VARCHAR(9)
		,CodigoSap VARCHAR(30)
		)

	INSERT INTO @tablaCuvPedido
	SELECT pc.CUV
		,pc.CodigoProducto
	FROM PedidoWebDetalle pd WITH (NOLOCK)
	INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON pd.CampaniaID = pc.AnoCampania
		AND pd.CUV = pc.CUV
		AND pc.IndicadorDigitable = 1
	INNER JOIN ods.Consultora c WITH (NOLOCK) ON pd.ConsultoraID = c.ConsultoraID
	WHERE pd.CampaniaID = @CampaniaID
		AND c.Codigo = @CodigoConsultora

	-- PASO 2 (obtener cuvs personalizados)
	DECLARE @TablaCross TABLE (
		CampaniaID INT
		,CUV VARCHAR(6)
		,CodigoSap VARCHAR(30)
		,PrecioCatalogo DECIMAL(15, 2)
		,CodVinculo INT
		,PPU DECIMAL(15, 2)
		,Orden INT
		,EsCross BIT
		,PrecioOk BIT
		,TipoMeta CHAR(2)
		,OrdenMeta INT
		,CUVPedido VARCHAR(6)
		,CUV2 VARCHAR(6)
		,MarcaID INT
		,CodCampania INT
		,EstaEnPedido BIT
		,CodConsultora VARCHAR(20)
		)

	INSERT INTO @TablaCross
	SELECT pc.CampaniaID
		,pc.CUV
		,pc.CodigoProducto
		,pc.PrecioCatalogo
		,op.CodVinculo
		,op.PPU
		,op.Orden
		,1
		,0
		,''
		,0
		,''
		,''
		,pc.MarcaID
		,pc.AnoCampania
		,0
		,op.CodConsultora
	FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
	INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON op.AnioCampanaVenta = pc.AnoCampania
		AND op.CUV = pc.CUV
		AND op.CodConsultora IN (
			@CodigoConsultora
			,@codConsultoraForzadas
			)
		AND op.TipoPersonalizacion = 'OF'
	WHERE op.AnioCampanaVenta = @CampaniaID
		AND pc.IndicadorDigitable = 1
		AND pc.EstrategiaIdSicc != '2003'

	-- PASO 3 (validar si hay cuvs personalizados)
	DECLARE @cantOfertas INT = 0
		,@codConsultoraGenerica VARCHAR(30) = ''

	SELECT @cantOfertas = COUNT(1)
	FROM @TablaCross
	WHERE CodConsultora != @codConsultoraForzadas

	IF ISNULL(@cantOfertas, 0) = 0
	BEGIN
		SELECT @codConsultoraGenerica = Codigo
		FROM TablaLogicaDatos
		WHERE TablaLogicaDatosID = 10001

		IF ISNULL(@codConsultoraGenerica, '') != ''
		BEGIN
			INSERT INTO @TablaCross
			SELECT pc.CampaniaID
				,pc.CUV
				,pc.CodigoProducto
				,pc.PrecioCatalogo
				,op.CodVinculo
				,op.PPU
				,op.Orden
				,1
				,0
				,''
				,0
				,''
				,''
				,pc.MarcaID
				,pc.AnoCampania
				,0
				,op.CodConsultora
			FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
			INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON op.AnioCampanaVenta = pc.AnoCampania
				AND op.CUV = pc.CUV
				AND op.CodConsultora = @codConsultoraGenerica
				AND op.TipoPersonalizacion = 'OF'
			WHERE op.AnioCampanaVenta = @CampaniaID
				AND pc.IndicadorDigitable = 1
				AND pc.EstrategiaIdSicc != '2003'
		END
	END

	-- PASO 4 (validar datos de las ofertas)
	UPDATE a
	SET a.EstaEnPedido = 1
		,a.CUVPedido = b.CUV
	FROM @TablaCross a
	INNER JOIN @TablaCuvPedido b ON a.CodigoSap = b.CodigoSap

	UPDATE a
	SET a.CUVPedido = b.CUVPedido
	FROM @TablaCross a
	INNER JOIN (
		SELECT CodVinculo
			,CUVPedido
		FROM @TablaCross
		WHERE EstaEnPedido = 1
		) b ON a.CodVinculo = b.CodVinculo
	WHERE a.EstaEnPedido = 0

	UPDATE a
	SET a.EsCross = 0
	FROM @TablaCross a
	INNER JOIN (
		SELECT CodVinculo
		FROM @TablaCross
		WHERE EstaEnPedido = 0
		GROUP BY CodVinculo
		HAVING COUNT(CUV) > 1
		) b ON a.CodVinculo = b.CodVinculo
	WHERE a.EstaEnPedido = 0

	UPDATE a
	SET a.PrecioOk = 1
	FROM @TablaCross a
	INNER JOIN (
		SELECT CUV
		FROM @TablaCross
		WHERE PrecioCatalogo <= PPU
		) b ON a.CUV = b.CUV
	WHERE a.EstaEnPedido = 0

	-- PASO 5 (validar GAP)
	DECLARE @GAP DECIMAL(15, 2)
		,@TipoMeta CHAR(2)

	IF (@TipoProductoMostrar = 1)
	BEGIN
		DECLARE @MontoHasta NUMERIC(15, 2)

		SELECT TOP 1 @MontoHasta = MontoHasta
			,@TipoMeta = PorDescuento
		FROM dbo.Fn_GetEscalaDescuentoZona(@CampaniaID,@CodigoRegion,@CodigoZona)
		WHERE MontoHasta >= ISNULL(@MontoEscala, 0)

		IF (@MontoHasta > @MontoMinPedido)
		BEGIN
			SELECT TOP 1 @TipoMeta = PorDescuento
			FROM dbo.Fn_GetEscalaDescuentoZona(@CampaniaID,@CodigoRegion,@CodigoZona)
			WHERE PorDescuento > @TipoMeta
		END

		SET @GAP = (@MontoHasta - @MontoTotal)
	END
	ELSE
	BEGIN
		IF (@MontoTotal > @MontoMinPedido)
			IF @MontoEscala > @MontoMinPedido
				SET @GAP = 0
			ELSE
				SET @GAP = (@MontoMinPedido - @MontoEscala)
		ELSE
			SET @GAP = (@MontoMinPedido - @MontoTotal)
	END

	--5.1 (actualizar TipoMeta)
	UPDATE a
	SET a.TipoMeta = (
			CASE 
				WHEN @TipoProductoMostrar = 1
					THEN @TipoMeta
				ELSE 'MM'
				END
			)
		,a.OrdenMeta = (
			CASE 
				WHEN @TipoProductoMostrar = 1
					THEN 2
				ELSE 1
				END
			)
	FROM @TablaCross a
	INNER JOIN (
		SELECT CUV
		FROM @TablaCross
		WHERE PrecioCatalogo >= @GAP
		) b ON a.CUV = b.CUV
	WHERE a.EstaEnPedido = 0

	--5.2 (actualizar GM)
	UPDATE a
	SET a.TipoMeta = 'GM'
		,a.OrdenMeta = 3
	FROM @TablaCross a
	INNER JOIN (
		SELECT CUV
		FROM @TablaCross
		WHERE PrecioCatalogo < @GAP
		) b ON a.CUV = b.CUV
	WHERE a.EstaEnPedido = 0

	--PASO 6 (validar cuvs faltantes)
	DECLARE @tablaCuvFaltante TABLE (CUV VARCHAR(6))

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
			)

	--  6.1 (eliminar cuv faltantes)
	DELETE
	FROM @TablaCross
	WHERE CUV IN (
			SELECT CUV
			FROM @tablaCuvFaltante
			)
		AND EstaEnPedido = 0

	-- PASO 7 (obtener ofertas productos)
	DECLARE @OfertaProductoTemp TABLE (
		CampaniaID INT
		,CUV VARCHAR(6)
		,ConfiguracionOfertaID INT
		,TipoOfertaSisID INT
		)

	INSERT INTO @OfertaProductoTemp
	SELECT op.CampaniaID
		,op.CUV
		,op.ConfiguracionOfertaID
		,op.TipoOfertaSisID
	FROM OfertaProducto op WITH (NOLOCK)
	INNER JOIN @TablaCross tc ON op.CampaniaID = tc.CodCampania
		AND op.CUV = tc.CUV
	WHERE tc.EstaEnPedido = 0

	-- PASO 8 (actualizar CUV2 desde ProductoComercial)
	UPDATE tc
	SET tc.CUV2 = pc.CUV
	FROM @TablaCross tc
	INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON tc.CampaniaID = pc.CampaniaID
		AND tc.CodigoSap = pc.CodigoProducto
		AND pc.IndicadorDigitable = 1
	WHERE tc.EstaEnPedido = 0

	-- PASO 9 (filtrar resultados)
	SELECT DISTINCT p.CUV
		,p.Descripcion AS Descripcion
		,(p.PrecioUnitario * p.FactorRepeticion) AS PrecioCatalogo
		,p.PrecioValorizado
		,p.MarcaID AS IdMarca
		,p.PaisID
		,p.AnoCampania AS CampaniaID
		,p.CodigoCatalago
		,p.CodigoProducto AS CodigoSap
		,p.IndicadorMontoMinimo
		,p.IndicadorOferta
		,0 AS EstaEnRevista
		,ISNULL(pcc.EsExpoOferta, 0) AS EsExpoOferta
		,ISNULL(pcc.CUVRevista, '') AS CUVRevista
		,m.Descripcion AS NombreMarca
		,'NO DISPONIBLE' AS DescripcionCategoria
		,'' AS CUVComplemento
		,'' AS DescripcionEstrategia
		,ISNULL(op.ConfiguracionOfertaID, 0) AS ConfiguracionOfertaID
		,ISNULL(op.TipoOfertaSisID, 0) AS TipoOfertaSisID
		,0 AS FlagNueva
		,0 AS TipoEstrategiaID
		,0 AS TieneSugerido
		,CASE 
			WHEN pl.CodigoSAP IS NULL
				THEN 0
			ELSE 1
			END AS TieneLanzamientoCatalogoPersonalizado
		,CASE 
			WHEN pcor.SAP IS NULL
				THEN 0
			ELSE 1
			END AS TieneOfertaRevista
		,ISNULL(pcor.Oferta, '') AS TipoOfertaRevista
		,
		--tc.CodigoSap,
		tc.Orden
		,1 AS TipoCross
		,tc.EsCross
		,tc.TipoMeta
		,tc.OrdenMeta
		,@GAP AS MontoMeta
		,tc.CodVinculo
		,tc.CUVPedido
		,tc.CUV2
	FROM @TablaCross tc
	INNER JOIN ods.ProductoComercial p WITH (NOLOCK) ON tc.CampaniaID = p.CampaniaID
		AND tc.CUV = p.CUV
		AND p.IndicadorDigitable = 1
	LEFT JOIN ProductoComercialConfiguracion pcc WITH (NOLOCK) ON p.AnoCampania = pcc.CampaniaID
		AND p.CUV = pcc.CUV
	LEFT JOIN @OfertaProductoTemp op ON op.CampaniaID = p.CampaniaID
		AND op.CUV = p.CUV
	LEFT JOIN ods.ProductosLanzamiento pl WITH (NOLOCK) ON p.CodigoProducto = pl.CodigoSAP
		AND p.AnoCampania = pl.Campania
	LEFT JOIN ProductoComercialOfertaRevista pcor WITH (NOLOCK) ON p.AnoCampania = pcor.Campania
		AND p.CUV = pcor.CUV
	LEFT JOIN Marca M WITH (NOLOCK) ON p.MarcaId = m.MarcaId
	WHERE --p.IndicadorDigitable = 1 
		--AND p.PrecioCatalogo >= ISNULL(@PrecioMinimo,0)
		--AND p.PrecioCatalogo >= ISNULL(@MontoFaltante,0)
		tc.EstaEnPedido = 0
	ORDER BY tc.OrdenMeta ASC
		,tc.EsCross DESC
		,tc.Orden ASC
END
GO

USE [BelcorpDominicana]
GO
ALTER PROCEDURE [dbo].[GetListaProductoCrossSelling] (@Table1 dbo.ListaOfertaFinalType READONLY)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @codConsultoraForzadas VARCHAR(9) = ''

	SELECT @codConsultoraForzadas = Codigo
	FROM TablaLogicaDatos WITH (NOLOCK)
	WHERE TablaLogicaDatosID = 10002

	DECLARE @CampaniaID INT
		,@CodigoConsultora VARCHAR(30)
		,@TipoProductoMostrar INT
		,@ZonaID INT
		,@CodigoRegion VARCHAR(8)
		,@CodigoZona VARCHAR(8)
		,@MontoMinPedido NUMERIC(15, 2)
		,@MontoTotal MONEY
		,@MontoEscala MONEY

	SELECT @CampaniaID = CampaniaID
		,@CodigoConsultora = CodigoConsultora
		,@ZonaID = ZonaID
		,@CodigoRegion = CodigoRegion
		,@CodigoZona = CodigoZona
		,@MontoMinPedido = MontoMinimo
		,@MontoTotal = MontoTotal
		,@MontoEscala = MontoEscala
	FROM @Table1

	IF (@MontoTotal > @MontoMinPedido)
		IF @MontoEscala > @MontoMinPedido
			SET @TipoProductoMostrar = 1
		ELSE
			SET @TipoProductoMostrar = 2
	ELSE
		SET @TipoProductoMostrar = 2

	-- PASO 1 (obtener cuvs del pedido)
	DECLARE @tablaCuvPedido TABLE (
		CUV VARCHAR(9)
		,CodigoSap VARCHAR(30)
		)

	INSERT INTO @tablaCuvPedido
	SELECT pc.CUV
		,pc.CodigoProducto
	FROM PedidoWebDetalle pd WITH (NOLOCK)
	INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON pd.CampaniaID = pc.AnoCampania
		AND pd.CUV = pc.CUV
		AND pc.IndicadorDigitable = 1
	INNER JOIN ods.Consultora c WITH (NOLOCK) ON pd.ConsultoraID = c.ConsultoraID
	WHERE pd.CampaniaID = @CampaniaID
		AND c.Codigo = @CodigoConsultora

	-- PASO 2 (obtener cuvs personalizados)
	DECLARE @TablaCross TABLE (
		CampaniaID INT
		,CUV VARCHAR(6)
		,CodigoSap VARCHAR(30)
		,PrecioCatalogo DECIMAL(15, 2)
		,CodVinculo INT
		,PPU DECIMAL(15, 2)
		,Orden INT
		,EsCross BIT
		,PrecioOk BIT
		,TipoMeta CHAR(2)
		,OrdenMeta INT
		,CUVPedido VARCHAR(6)
		,CUV2 VARCHAR(6)
		,MarcaID INT
		,CodCampania INT
		,EstaEnPedido BIT
		,CodConsultora VARCHAR(20)
		)

	INSERT INTO @TablaCross
	SELECT pc.CampaniaID
		,pc.CUV
		,pc.CodigoProducto
		,pc.PrecioCatalogo
		,op.CodVinculo
		,op.PPU
		,op.Orden
		,1
		,0
		,''
		,0
		,''
		,''
		,pc.MarcaID
		,pc.AnoCampania
		,0
		,op.CodConsultora
	FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
	INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON op.AnioCampanaVenta = pc.AnoCampania
		AND op.CUV = pc.CUV
		AND op.CodConsultora IN (
			@CodigoConsultora
			,@codConsultoraForzadas
			)
		AND op.TipoPersonalizacion = 'OF'
	WHERE op.AnioCampanaVenta = @CampaniaID
		AND pc.IndicadorDigitable = 1
		AND pc.EstrategiaIdSicc != '2003'

	-- PASO 3 (validar si hay cuvs personalizados)
	DECLARE @cantOfertas INT = 0
		,@codConsultoraGenerica VARCHAR(30) = ''

	SELECT @cantOfertas = COUNT(1)
	FROM @TablaCross
	WHERE CodConsultora != @codConsultoraForzadas

	IF ISNULL(@cantOfertas, 0) = 0
	BEGIN
		SELECT @codConsultoraGenerica = Codigo
		FROM TablaLogicaDatos
		WHERE TablaLogicaDatosID = 10001

		IF ISNULL(@codConsultoraGenerica, '') != ''
		BEGIN
			INSERT INTO @TablaCross
			SELECT pc.CampaniaID
				,pc.CUV
				,pc.CodigoProducto
				,pc.PrecioCatalogo
				,op.CodVinculo
				,op.PPU
				,op.Orden
				,1
				,0
				,''
				,0
				,''
				,''
				,pc.MarcaID
				,pc.AnoCampania
				,0
				,op.CodConsultora
			FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
			INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON op.AnioCampanaVenta = pc.AnoCampania
				AND op.CUV = pc.CUV
				AND op.CodConsultora = @codConsultoraGenerica
				AND op.TipoPersonalizacion = 'OF'
			WHERE op.AnioCampanaVenta = @CampaniaID
				AND pc.IndicadorDigitable = 1
				AND pc.EstrategiaIdSicc != '2003'
		END
	END

	-- PASO 4 (validar datos de las ofertas)
	UPDATE a
	SET a.EstaEnPedido = 1
		,a.CUVPedido = b.CUV
	FROM @TablaCross a
	INNER JOIN @TablaCuvPedido b ON a.CodigoSap = b.CodigoSap

	UPDATE a
	SET a.CUVPedido = b.CUVPedido
	FROM @TablaCross a
	INNER JOIN (
		SELECT CodVinculo
			,CUVPedido
		FROM @TablaCross
		WHERE EstaEnPedido = 1
		) b ON a.CodVinculo = b.CodVinculo
	WHERE a.EstaEnPedido = 0

	UPDATE a
	SET a.EsCross = 0
	FROM @TablaCross a
	INNER JOIN (
		SELECT CodVinculo
		FROM @TablaCross
		WHERE EstaEnPedido = 0
		GROUP BY CodVinculo
		HAVING COUNT(CUV) > 1
		) b ON a.CodVinculo = b.CodVinculo
	WHERE a.EstaEnPedido = 0

	UPDATE a
	SET a.PrecioOk = 1
	FROM @TablaCross a
	INNER JOIN (
		SELECT CUV
		FROM @TablaCross
		WHERE PrecioCatalogo <= PPU
		) b ON a.CUV = b.CUV
	WHERE a.EstaEnPedido = 0

	-- PASO 5 (validar GAP)
	DECLARE @GAP DECIMAL(15, 2)
		,@TipoMeta CHAR(2)

	IF (@TipoProductoMostrar = 1)
	BEGIN
		DECLARE @MontoHasta NUMERIC(15, 2)

		SELECT TOP 1 @MontoHasta = MontoHasta
			,@TipoMeta = PorDescuento
		FROM dbo.Fn_GetEscalaDescuentoZona(@CampaniaID,@CodigoRegion,@CodigoZona)
		WHERE MontoHasta >= ISNULL(@MontoEscala, 0)

		IF (@MontoHasta > @MontoMinPedido)
		BEGIN
			SELECT TOP 1 @TipoMeta = PorDescuento
			FROM dbo.Fn_GetEscalaDescuentoZona(@CampaniaID,@CodigoRegion,@CodigoZona)
			WHERE PorDescuento > @TipoMeta
		END

		SET @GAP = (@MontoHasta - @MontoTotal)
	END
	ELSE
	BEGIN
		IF (@MontoTotal > @MontoMinPedido)
			IF @MontoEscala > @MontoMinPedido
				SET @GAP = 0
			ELSE
				SET @GAP = (@MontoMinPedido - @MontoEscala)
		ELSE
			SET @GAP = (@MontoMinPedido - @MontoTotal)
	END

	--5.1 (actualizar TipoMeta)
	UPDATE a
	SET a.TipoMeta = (
			CASE 
				WHEN @TipoProductoMostrar = 1
					THEN @TipoMeta
				ELSE 'MM'
				END
			)
		,a.OrdenMeta = (
			CASE 
				WHEN @TipoProductoMostrar = 1
					THEN 2
				ELSE 1
				END
			)
	FROM @TablaCross a
	INNER JOIN (
		SELECT CUV
		FROM @TablaCross
		WHERE PrecioCatalogo >= @GAP
		) b ON a.CUV = b.CUV
	WHERE a.EstaEnPedido = 0

	--5.2 (actualizar GM)
	UPDATE a
	SET a.TipoMeta = 'GM'
		,a.OrdenMeta = 3
	FROM @TablaCross a
	INNER JOIN (
		SELECT CUV
		FROM @TablaCross
		WHERE PrecioCatalogo < @GAP
		) b ON a.CUV = b.CUV
	WHERE a.EstaEnPedido = 0

	--PASO 6 (validar cuvs faltantes)
	DECLARE @tablaCuvFaltante TABLE (CUV VARCHAR(6))

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
			)

	--  6.1 (eliminar cuv faltantes)
	DELETE
	FROM @TablaCross
	WHERE CUV IN (
			SELECT CUV
			FROM @tablaCuvFaltante
			)
		AND EstaEnPedido = 0

	-- PASO 7 (obtener ofertas productos)
	DECLARE @OfertaProductoTemp TABLE (
		CampaniaID INT
		,CUV VARCHAR(6)
		,ConfiguracionOfertaID INT
		,TipoOfertaSisID INT
		)

	INSERT INTO @OfertaProductoTemp
	SELECT op.CampaniaID
		,op.CUV
		,op.ConfiguracionOfertaID
		,op.TipoOfertaSisID
	FROM OfertaProducto op WITH (NOLOCK)
	INNER JOIN @TablaCross tc ON op.CampaniaID = tc.CodCampania
		AND op.CUV = tc.CUV
	WHERE tc.EstaEnPedido = 0

	-- PASO 8 (actualizar CUV2 desde ProductoComercial)
	UPDATE tc
	SET tc.CUV2 = pc.CUV
	FROM @TablaCross tc
	INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON tc.CampaniaID = pc.CampaniaID
		AND tc.CodigoSap = pc.CodigoProducto
		AND pc.IndicadorDigitable = 1
	WHERE tc.EstaEnPedido = 0

	-- PASO 9 (filtrar resultados)
	SELECT DISTINCT p.CUV
		,p.Descripcion AS Descripcion
		,(p.PrecioUnitario * p.FactorRepeticion) AS PrecioCatalogo
		,p.PrecioValorizado
		,p.MarcaID AS IdMarca
		,p.PaisID
		,p.AnoCampania AS CampaniaID
		,p.CodigoCatalago
		,p.CodigoProducto AS CodigoSap
		,p.IndicadorMontoMinimo
		,p.IndicadorOferta
		,0 AS EstaEnRevista
		,ISNULL(pcc.EsExpoOferta, 0) AS EsExpoOferta
		,ISNULL(pcc.CUVRevista, '') AS CUVRevista
		,m.Descripcion AS NombreMarca
		,'NO DISPONIBLE' AS DescripcionCategoria
		,'' AS CUVComplemento
		,'' AS DescripcionEstrategia
		,ISNULL(op.ConfiguracionOfertaID, 0) AS ConfiguracionOfertaID
		,ISNULL(op.TipoOfertaSisID, 0) AS TipoOfertaSisID
		,0 AS FlagNueva
		,0 AS TipoEstrategiaID
		,0 AS TieneSugerido
		,CASE 
			WHEN pl.CodigoSAP IS NULL
				THEN 0
			ELSE 1
			END AS TieneLanzamientoCatalogoPersonalizado
		,CASE 
			WHEN pcor.SAP IS NULL
				THEN 0
			ELSE 1
			END AS TieneOfertaRevista
		,ISNULL(pcor.Oferta, '') AS TipoOfertaRevista
		,
		--tc.CodigoSap,
		tc.Orden
		,1 AS TipoCross
		,tc.EsCross
		,tc.TipoMeta
		,tc.OrdenMeta
		,@GAP AS MontoMeta
		,tc.CodVinculo
		,tc.CUVPedido
		,tc.CUV2
	FROM @TablaCross tc
	INNER JOIN ods.ProductoComercial p WITH (NOLOCK) ON tc.CampaniaID = p.CampaniaID
		AND tc.CUV = p.CUV
		AND p.IndicadorDigitable = 1
	LEFT JOIN ProductoComercialConfiguracion pcc WITH (NOLOCK) ON p.AnoCampania = pcc.CampaniaID
		AND p.CUV = pcc.CUV
	LEFT JOIN @OfertaProductoTemp op ON op.CampaniaID = p.CampaniaID
		AND op.CUV = p.CUV
	LEFT JOIN ods.ProductosLanzamiento pl WITH (NOLOCK) ON p.CodigoProducto = pl.CodigoSAP
		AND p.AnoCampania = pl.Campania
	LEFT JOIN ProductoComercialOfertaRevista pcor WITH (NOLOCK) ON p.AnoCampania = pcor.Campania
		AND p.CUV = pcor.CUV
	LEFT JOIN Marca M WITH (NOLOCK) ON p.MarcaId = m.MarcaId
	WHERE --p.IndicadorDigitable = 1 
		--AND p.PrecioCatalogo >= ISNULL(@PrecioMinimo,0)
		--AND p.PrecioCatalogo >= ISNULL(@MontoFaltante,0)
		tc.EstaEnPedido = 0
	ORDER BY tc.OrdenMeta ASC
		,tc.EsCross DESC
		,tc.Orden ASC
END
GO

USE [BelcorpEcuador]
GO
ALTER PROCEDURE [dbo].[GetListaProductoCrossSelling] (@Table1 dbo.ListaOfertaFinalType READONLY)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @codConsultoraForzadas VARCHAR(9) = ''

	SELECT @codConsultoraForzadas = Codigo
	FROM TablaLogicaDatos WITH (NOLOCK)
	WHERE TablaLogicaDatosID = 10002

	DECLARE @CampaniaID INT
		,@CodigoConsultora VARCHAR(30)
		,@TipoProductoMostrar INT
		,@ZonaID INT
		,@CodigoRegion VARCHAR(8)
		,@CodigoZona VARCHAR(8)
		,@MontoMinPedido NUMERIC(15, 2)
		,@MontoTotal MONEY
		,@MontoEscala MONEY

	SELECT @CampaniaID = CampaniaID
		,@CodigoConsultora = CodigoConsultora
		,@ZonaID = ZonaID
		,@CodigoRegion = CodigoRegion
		,@CodigoZona = CodigoZona
		,@MontoMinPedido = MontoMinimo
		,@MontoTotal = MontoTotal
		,@MontoEscala = MontoEscala
	FROM @Table1

	IF (@MontoTotal > @MontoMinPedido)
		IF @MontoEscala > @MontoMinPedido
			SET @TipoProductoMostrar = 1
		ELSE
			SET @TipoProductoMostrar = 2
	ELSE
		SET @TipoProductoMostrar = 2

	-- PASO 1 (obtener cuvs del pedido)
	DECLARE @tablaCuvPedido TABLE (
		CUV VARCHAR(9)
		,CodigoSap VARCHAR(30)
		)

	INSERT INTO @tablaCuvPedido
	SELECT pc.CUV
		,pc.CodigoProducto
	FROM PedidoWebDetalle pd WITH (NOLOCK)
	INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON pd.CampaniaID = pc.AnoCampania
		AND pd.CUV = pc.CUV
		AND pc.IndicadorDigitable = 1
	INNER JOIN ods.Consultora c WITH (NOLOCK) ON pd.ConsultoraID = c.ConsultoraID
	WHERE pd.CampaniaID = @CampaniaID
		AND c.Codigo = @CodigoConsultora

	-- PASO 2 (obtener cuvs personalizados)
	DECLARE @TablaCross TABLE (
		CampaniaID INT
		,CUV VARCHAR(6)
		,CodigoSap VARCHAR(30)
		,PrecioCatalogo DECIMAL(15, 2)
		,CodVinculo INT
		,PPU DECIMAL(15, 2)
		,Orden INT
		,EsCross BIT
		,PrecioOk BIT
		,TipoMeta CHAR(2)
		,OrdenMeta INT
		,CUVPedido VARCHAR(6)
		,CUV2 VARCHAR(6)
		,MarcaID INT
		,CodCampania INT
		,EstaEnPedido BIT
		,CodConsultora VARCHAR(20)
		)

	INSERT INTO @TablaCross
	SELECT pc.CampaniaID
		,pc.CUV
		,pc.CodigoProducto
		,pc.PrecioCatalogo
		,op.CodVinculo
		,op.PPU
		,op.Orden
		,1
		,0
		,''
		,0
		,''
		,''
		,pc.MarcaID
		,pc.AnoCampania
		,0
		,op.CodConsultora
	FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
	INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON op.AnioCampanaVenta = pc.AnoCampania
		AND op.CUV = pc.CUV
		AND op.CodConsultora IN (
			@CodigoConsultora
			,@codConsultoraForzadas
			)
		AND op.TipoPersonalizacion = 'OF'
	WHERE op.AnioCampanaVenta = @CampaniaID
		AND pc.IndicadorDigitable = 1
		AND pc.EstrategiaIdSicc != '2003'

	-- PASO 3 (validar si hay cuvs personalizados)
	DECLARE @cantOfertas INT = 0
		,@codConsultoraGenerica VARCHAR(30) = ''

	SELECT @cantOfertas = COUNT(1)
	FROM @TablaCross
	WHERE CodConsultora != @codConsultoraForzadas

	IF ISNULL(@cantOfertas, 0) = 0
	BEGIN
		SELECT @codConsultoraGenerica = Codigo
		FROM TablaLogicaDatos
		WHERE TablaLogicaDatosID = 10001

		IF ISNULL(@codConsultoraGenerica, '') != ''
		BEGIN
			INSERT INTO @TablaCross
			SELECT pc.CampaniaID
				,pc.CUV
				,pc.CodigoProducto
				,pc.PrecioCatalogo
				,op.CodVinculo
				,op.PPU
				,op.Orden
				,1
				,0
				,''
				,0
				,''
				,''
				,pc.MarcaID
				,pc.AnoCampania
				,0
				,op.CodConsultora
			FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
			INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON op.AnioCampanaVenta = pc.AnoCampania
				AND op.CUV = pc.CUV
				AND op.CodConsultora = @codConsultoraGenerica
				AND op.TipoPersonalizacion = 'OF'
			WHERE op.AnioCampanaVenta = @CampaniaID
				AND pc.IndicadorDigitable = 1
				AND pc.EstrategiaIdSicc != '2003'
		END
	END

	-- PASO 4 (validar datos de las ofertas)
	UPDATE a
	SET a.EstaEnPedido = 1
		,a.CUVPedido = b.CUV
	FROM @TablaCross a
	INNER JOIN @TablaCuvPedido b ON a.CodigoSap = b.CodigoSap

	UPDATE a
	SET a.CUVPedido = b.CUVPedido
	FROM @TablaCross a
	INNER JOIN (
		SELECT CodVinculo
			,CUVPedido
		FROM @TablaCross
		WHERE EstaEnPedido = 1
		) b ON a.CodVinculo = b.CodVinculo
	WHERE a.EstaEnPedido = 0

	UPDATE a
	SET a.EsCross = 0
	FROM @TablaCross a
	INNER JOIN (
		SELECT CodVinculo
		FROM @TablaCross
		WHERE EstaEnPedido = 0
		GROUP BY CodVinculo
		HAVING COUNT(CUV) > 1
		) b ON a.CodVinculo = b.CodVinculo
	WHERE a.EstaEnPedido = 0

	UPDATE a
	SET a.PrecioOk = 1
	FROM @TablaCross a
	INNER JOIN (
		SELECT CUV
		FROM @TablaCross
		WHERE PrecioCatalogo <= PPU
		) b ON a.CUV = b.CUV
	WHERE a.EstaEnPedido = 0

	-- PASO 5 (validar GAP)
	DECLARE @GAP DECIMAL(15, 2)
		,@TipoMeta CHAR(2)

	IF (@TipoProductoMostrar = 1)
	BEGIN
		DECLARE @MontoHasta NUMERIC(15, 2)

		SELECT TOP 1 @MontoHasta = MontoHasta
			,@TipoMeta = PorDescuento
		FROM dbo.Fn_GetEscalaDescuentoZona(@CampaniaID,@CodigoRegion,@CodigoZona)
		WHERE MontoHasta >= ISNULL(@MontoEscala, 0)

		IF (@MontoHasta > @MontoMinPedido)
		BEGIN
			SELECT TOP 1 @TipoMeta = PorDescuento
			FROM dbo.Fn_GetEscalaDescuentoZona(@CampaniaID,@CodigoRegion,@CodigoZona)
			WHERE PorDescuento > @TipoMeta
		END

		SET @GAP = (@MontoHasta - @MontoTotal)
	END
	ELSE
	BEGIN
		IF (@MontoTotal > @MontoMinPedido)
			IF @MontoEscala > @MontoMinPedido
				SET @GAP = 0
			ELSE
				SET @GAP = (@MontoMinPedido - @MontoEscala)
		ELSE
			SET @GAP = (@MontoMinPedido - @MontoTotal)
	END

	--5.1 (actualizar TipoMeta)
	UPDATE a
	SET a.TipoMeta = (
			CASE 
				WHEN @TipoProductoMostrar = 1
					THEN @TipoMeta
				ELSE 'MM'
				END
			)
		,a.OrdenMeta = (
			CASE 
				WHEN @TipoProductoMostrar = 1
					THEN 2
				ELSE 1
				END
			)
	FROM @TablaCross a
	INNER JOIN (
		SELECT CUV
		FROM @TablaCross
		WHERE PrecioCatalogo >= @GAP
		) b ON a.CUV = b.CUV
	WHERE a.EstaEnPedido = 0

	--5.2 (actualizar GM)
	UPDATE a
	SET a.TipoMeta = 'GM'
		,a.OrdenMeta = 3
	FROM @TablaCross a
	INNER JOIN (
		SELECT CUV
		FROM @TablaCross
		WHERE PrecioCatalogo < @GAP
		) b ON a.CUV = b.CUV
	WHERE a.EstaEnPedido = 0

	--PASO 6 (validar cuvs faltantes)
	DECLARE @tablaCuvFaltante TABLE (CUV VARCHAR(6))

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
			)

	--  6.1 (eliminar cuv faltantes)
	DELETE
	FROM @TablaCross
	WHERE CUV IN (
			SELECT CUV
			FROM @tablaCuvFaltante
			)
		AND EstaEnPedido = 0

	-- PASO 7 (obtener ofertas productos)
	DECLARE @OfertaProductoTemp TABLE (
		CampaniaID INT
		,CUV VARCHAR(6)
		,ConfiguracionOfertaID INT
		,TipoOfertaSisID INT
		)

	INSERT INTO @OfertaProductoTemp
	SELECT op.CampaniaID
		,op.CUV
		,op.ConfiguracionOfertaID
		,op.TipoOfertaSisID
	FROM OfertaProducto op WITH (NOLOCK)
	INNER JOIN @TablaCross tc ON op.CampaniaID = tc.CodCampania
		AND op.CUV = tc.CUV
	WHERE tc.EstaEnPedido = 0

	-- PASO 8 (actualizar CUV2 desde ProductoComercial)
	UPDATE tc
	SET tc.CUV2 = pc.CUV
	FROM @TablaCross tc
	INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON tc.CampaniaID = pc.CampaniaID
		AND tc.CodigoSap = pc.CodigoProducto
		AND pc.IndicadorDigitable = 1
	WHERE tc.EstaEnPedido = 0

	-- PASO 9 (filtrar resultados)
	SELECT DISTINCT p.CUV
		,p.Descripcion AS Descripcion
		,(p.PrecioUnitario * p.FactorRepeticion) AS PrecioCatalogo
		,p.PrecioValorizado
		,p.MarcaID AS IdMarca
		,p.PaisID
		,p.AnoCampania AS CampaniaID
		,p.CodigoCatalago
		,p.CodigoProducto AS CodigoSap
		,p.IndicadorMontoMinimo
		,p.IndicadorOferta
		,0 AS EstaEnRevista
		,ISNULL(pcc.EsExpoOferta, 0) AS EsExpoOferta
		,ISNULL(pcc.CUVRevista, '') AS CUVRevista
		,m.Descripcion AS NombreMarca
		,'NO DISPONIBLE' AS DescripcionCategoria
		,'' AS CUVComplemento
		,'' AS DescripcionEstrategia
		,ISNULL(op.ConfiguracionOfertaID, 0) AS ConfiguracionOfertaID
		,ISNULL(op.TipoOfertaSisID, 0) AS TipoOfertaSisID
		,0 AS FlagNueva
		,0 AS TipoEstrategiaID
		,0 AS TieneSugerido
		,CASE 
			WHEN pl.CodigoSAP IS NULL
				THEN 0
			ELSE 1
			END AS TieneLanzamientoCatalogoPersonalizado
		,CASE 
			WHEN pcor.SAP IS NULL
				THEN 0
			ELSE 1
			END AS TieneOfertaRevista
		,ISNULL(pcor.Oferta, '') AS TipoOfertaRevista
		,
		--tc.CodigoSap,
		tc.Orden
		,1 AS TipoCross
		,tc.EsCross
		,tc.TipoMeta
		,tc.OrdenMeta
		,@GAP AS MontoMeta
		,tc.CodVinculo
		,tc.CUVPedido
		,tc.CUV2
	FROM @TablaCross tc
	INNER JOIN ods.ProductoComercial p WITH (NOLOCK) ON tc.CampaniaID = p.CampaniaID
		AND tc.CUV = p.CUV
		AND p.IndicadorDigitable = 1
	LEFT JOIN ProductoComercialConfiguracion pcc WITH (NOLOCK) ON p.AnoCampania = pcc.CampaniaID
		AND p.CUV = pcc.CUV
	LEFT JOIN @OfertaProductoTemp op ON op.CampaniaID = p.CampaniaID
		AND op.CUV = p.CUV
	LEFT JOIN ods.ProductosLanzamiento pl WITH (NOLOCK) ON p.CodigoProducto = pl.CodigoSAP
		AND p.AnoCampania = pl.Campania
	LEFT JOIN ProductoComercialOfertaRevista pcor WITH (NOLOCK) ON p.AnoCampania = pcor.Campania
		AND p.CUV = pcor.CUV
	LEFT JOIN Marca M WITH (NOLOCK) ON p.MarcaId = m.MarcaId
	WHERE --p.IndicadorDigitable = 1 
		--AND p.PrecioCatalogo >= ISNULL(@PrecioMinimo,0)
		--AND p.PrecioCatalogo >= ISNULL(@MontoFaltante,0)
		tc.EstaEnPedido = 0
	ORDER BY tc.OrdenMeta ASC
		,tc.EsCross DESC
		,tc.Orden ASC
END
GO

USE [BelcorpGuatemala]
GO
ALTER PROCEDURE [dbo].[GetListaProductoCrossSelling] (@Table1 dbo.ListaOfertaFinalType READONLY)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @codConsultoraForzadas VARCHAR(9) = ''

	SELECT @codConsultoraForzadas = Codigo
	FROM TablaLogicaDatos WITH (NOLOCK)
	WHERE TablaLogicaDatosID = 10002

	DECLARE @CampaniaID INT
		,@CodigoConsultora VARCHAR(30)
		,@TipoProductoMostrar INT
		,@ZonaID INT
		,@CodigoRegion VARCHAR(8)
		,@CodigoZona VARCHAR(8)
		,@MontoMinPedido NUMERIC(15, 2)
		,@MontoTotal MONEY
		,@MontoEscala MONEY

	SELECT @CampaniaID = CampaniaID
		,@CodigoConsultora = CodigoConsultora
		,@ZonaID = ZonaID
		,@CodigoRegion = CodigoRegion
		,@CodigoZona = CodigoZona
		,@MontoMinPedido = MontoMinimo
		,@MontoTotal = MontoTotal
		,@MontoEscala = MontoEscala
	FROM @Table1

	IF (@MontoTotal > @MontoMinPedido)
		IF @MontoEscala > @MontoMinPedido
			SET @TipoProductoMostrar = 1
		ELSE
			SET @TipoProductoMostrar = 2
	ELSE
		SET @TipoProductoMostrar = 2

	-- PASO 1 (obtener cuvs del pedido)
	DECLARE @tablaCuvPedido TABLE (
		CUV VARCHAR(9)
		,CodigoSap VARCHAR(30)
		)

	INSERT INTO @tablaCuvPedido
	SELECT pc.CUV
		,pc.CodigoProducto
	FROM PedidoWebDetalle pd WITH (NOLOCK)
	INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON pd.CampaniaID = pc.AnoCampania
		AND pd.CUV = pc.CUV
		AND pc.IndicadorDigitable = 1
	INNER JOIN ods.Consultora c WITH (NOLOCK) ON pd.ConsultoraID = c.ConsultoraID
	WHERE pd.CampaniaID = @CampaniaID
		AND c.Codigo = @CodigoConsultora

	-- PASO 2 (obtener cuvs personalizados)
	DECLARE @TablaCross TABLE (
		CampaniaID INT
		,CUV VARCHAR(6)
		,CodigoSap VARCHAR(30)
		,PrecioCatalogo DECIMAL(15, 2)
		,CodVinculo INT
		,PPU DECIMAL(15, 2)
		,Orden INT
		,EsCross BIT
		,PrecioOk BIT
		,TipoMeta CHAR(2)
		,OrdenMeta INT
		,CUVPedido VARCHAR(6)
		,CUV2 VARCHAR(6)
		,MarcaID INT
		,CodCampania INT
		,EstaEnPedido BIT
		,CodConsultora VARCHAR(20)
		)

	INSERT INTO @TablaCross
	SELECT pc.CampaniaID
		,pc.CUV
		,pc.CodigoProducto
		,pc.PrecioCatalogo
		,op.CodVinculo
		,op.PPU
		,op.Orden
		,1
		,0
		,''
		,0
		,''
		,''
		,pc.MarcaID
		,pc.AnoCampania
		,0
		,op.CodConsultora
	FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
	INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON op.AnioCampanaVenta = pc.AnoCampania
		AND op.CUV = pc.CUV
		AND op.CodConsultora IN (
			@CodigoConsultora
			,@codConsultoraForzadas
			)
		AND op.TipoPersonalizacion = 'OF'
	WHERE op.AnioCampanaVenta = @CampaniaID
		AND pc.IndicadorDigitable = 1
		AND pc.EstrategiaIdSicc != '2003'

	-- PASO 3 (validar si hay cuvs personalizados)
	DECLARE @cantOfertas INT = 0
		,@codConsultoraGenerica VARCHAR(30) = ''

	SELECT @cantOfertas = COUNT(1)
	FROM @TablaCross
	WHERE CodConsultora != @codConsultoraForzadas

	IF ISNULL(@cantOfertas, 0) = 0
	BEGIN
		SELECT @codConsultoraGenerica = Codigo
		FROM TablaLogicaDatos
		WHERE TablaLogicaDatosID = 10001

		IF ISNULL(@codConsultoraGenerica, '') != ''
		BEGIN
			INSERT INTO @TablaCross
			SELECT pc.CampaniaID
				,pc.CUV
				,pc.CodigoProducto
				,pc.PrecioCatalogo
				,op.CodVinculo
				,op.PPU
				,op.Orden
				,1
				,0
				,''
				,0
				,''
				,''
				,pc.MarcaID
				,pc.AnoCampania
				,0
				,op.CodConsultora
			FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
			INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON op.AnioCampanaVenta = pc.AnoCampania
				AND op.CUV = pc.CUV
				AND op.CodConsultora = @codConsultoraGenerica
				AND op.TipoPersonalizacion = 'OF'
			WHERE op.AnioCampanaVenta = @CampaniaID
				AND pc.IndicadorDigitable = 1
				AND pc.EstrategiaIdSicc != '2003'
		END
	END

	-- PASO 4 (validar datos de las ofertas)
	UPDATE a
	SET a.EstaEnPedido = 1
		,a.CUVPedido = b.CUV
	FROM @TablaCross a
	INNER JOIN @TablaCuvPedido b ON a.CodigoSap = b.CodigoSap

	UPDATE a
	SET a.CUVPedido = b.CUVPedido
	FROM @TablaCross a
	INNER JOIN (
		SELECT CodVinculo
			,CUVPedido
		FROM @TablaCross
		WHERE EstaEnPedido = 1
		) b ON a.CodVinculo = b.CodVinculo
	WHERE a.EstaEnPedido = 0

	UPDATE a
	SET a.EsCross = 0
	FROM @TablaCross a
	INNER JOIN (
		SELECT CodVinculo
		FROM @TablaCross
		WHERE EstaEnPedido = 0
		GROUP BY CodVinculo
		HAVING COUNT(CUV) > 1
		) b ON a.CodVinculo = b.CodVinculo
	WHERE a.EstaEnPedido = 0

	UPDATE a
	SET a.PrecioOk = 1
	FROM @TablaCross a
	INNER JOIN (
		SELECT CUV
		FROM @TablaCross
		WHERE PrecioCatalogo <= PPU
		) b ON a.CUV = b.CUV
	WHERE a.EstaEnPedido = 0

	-- PASO 5 (validar GAP)
	DECLARE @GAP DECIMAL(15, 2)
		,@TipoMeta CHAR(2)

	IF (@TipoProductoMostrar = 1)
	BEGIN
		DECLARE @MontoHasta NUMERIC(15, 2)

		SELECT TOP 1 @MontoHasta = MontoHasta
			,@TipoMeta = PorDescuento
		FROM dbo.Fn_GetEscalaDescuentoZona(@CampaniaID,@CodigoRegion,@CodigoZona)
		WHERE MontoHasta >= ISNULL(@MontoEscala, 0)

		IF (@MontoHasta > @MontoMinPedido)
		BEGIN
			SELECT TOP 1 @TipoMeta = PorDescuento
			FROM dbo.Fn_GetEscalaDescuentoZona(@CampaniaID,@CodigoRegion,@CodigoZona)
			WHERE PorDescuento > @TipoMeta
		END

		SET @GAP = (@MontoHasta - @MontoTotal)
	END
	ELSE
	BEGIN
		IF (@MontoTotal > @MontoMinPedido)
			IF @MontoEscala > @MontoMinPedido
				SET @GAP = 0
			ELSE
				SET @GAP = (@MontoMinPedido - @MontoEscala)
		ELSE
			SET @GAP = (@MontoMinPedido - @MontoTotal)
	END

	--5.1 (actualizar TipoMeta)
	UPDATE a
	SET a.TipoMeta = (
			CASE 
				WHEN @TipoProductoMostrar = 1
					THEN @TipoMeta
				ELSE 'MM'
				END
			)
		,a.OrdenMeta = (
			CASE 
				WHEN @TipoProductoMostrar = 1
					THEN 2
				ELSE 1
				END
			)
	FROM @TablaCross a
	INNER JOIN (
		SELECT CUV
		FROM @TablaCross
		WHERE PrecioCatalogo >= @GAP
		) b ON a.CUV = b.CUV
	WHERE a.EstaEnPedido = 0

	--5.2 (actualizar GM)
	UPDATE a
	SET a.TipoMeta = 'GM'
		,a.OrdenMeta = 3
	FROM @TablaCross a
	INNER JOIN (
		SELECT CUV
		FROM @TablaCross
		WHERE PrecioCatalogo < @GAP
		) b ON a.CUV = b.CUV
	WHERE a.EstaEnPedido = 0

	--PASO 6 (validar cuvs faltantes)
	DECLARE @tablaCuvFaltante TABLE (CUV VARCHAR(6))

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
			)

	--  6.1 (eliminar cuv faltantes)
	DELETE
	FROM @TablaCross
	WHERE CUV IN (
			SELECT CUV
			FROM @tablaCuvFaltante
			)
		AND EstaEnPedido = 0

	-- PASO 7 (obtener ofertas productos)
	DECLARE @OfertaProductoTemp TABLE (
		CampaniaID INT
		,CUV VARCHAR(6)
		,ConfiguracionOfertaID INT
		,TipoOfertaSisID INT
		)

	INSERT INTO @OfertaProductoTemp
	SELECT op.CampaniaID
		,op.CUV
		,op.ConfiguracionOfertaID
		,op.TipoOfertaSisID
	FROM OfertaProducto op WITH (NOLOCK)
	INNER JOIN @TablaCross tc ON op.CampaniaID = tc.CodCampania
		AND op.CUV = tc.CUV
	WHERE tc.EstaEnPedido = 0

	-- PASO 8 (actualizar CUV2 desde ProductoComercial)
	UPDATE tc
	SET tc.CUV2 = pc.CUV
	FROM @TablaCross tc
	INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON tc.CampaniaID = pc.CampaniaID
		AND tc.CodigoSap = pc.CodigoProducto
		AND pc.IndicadorDigitable = 1
	WHERE tc.EstaEnPedido = 0

	-- PASO 9 (filtrar resultados)
	SELECT DISTINCT p.CUV
		,p.Descripcion AS Descripcion
		,(p.PrecioUnitario * p.FactorRepeticion) AS PrecioCatalogo
		,p.PrecioValorizado
		,p.MarcaID AS IdMarca
		,p.PaisID
		,p.AnoCampania AS CampaniaID
		,p.CodigoCatalago
		,p.CodigoProducto AS CodigoSap
		,p.IndicadorMontoMinimo
		,p.IndicadorOferta
		,0 AS EstaEnRevista
		,ISNULL(pcc.EsExpoOferta, 0) AS EsExpoOferta
		,ISNULL(pcc.CUVRevista, '') AS CUVRevista
		,m.Descripcion AS NombreMarca
		,'NO DISPONIBLE' AS DescripcionCategoria
		,'' AS CUVComplemento
		,'' AS DescripcionEstrategia
		,ISNULL(op.ConfiguracionOfertaID, 0) AS ConfiguracionOfertaID
		,ISNULL(op.TipoOfertaSisID, 0) AS TipoOfertaSisID
		,0 AS FlagNueva
		,0 AS TipoEstrategiaID
		,0 AS TieneSugerido
		,CASE 
			WHEN pl.CodigoSAP IS NULL
				THEN 0
			ELSE 1
			END AS TieneLanzamientoCatalogoPersonalizado
		,CASE 
			WHEN pcor.SAP IS NULL
				THEN 0
			ELSE 1
			END AS TieneOfertaRevista
		,ISNULL(pcor.Oferta, '') AS TipoOfertaRevista
		,
		--tc.CodigoSap,
		tc.Orden
		,1 AS TipoCross
		,tc.EsCross
		,tc.TipoMeta
		,tc.OrdenMeta
		,@GAP AS MontoMeta
		,tc.CodVinculo
		,tc.CUVPedido
		,tc.CUV2
	FROM @TablaCross tc
	INNER JOIN ods.ProductoComercial p WITH (NOLOCK) ON tc.CampaniaID = p.CampaniaID
		AND tc.CUV = p.CUV
		AND p.IndicadorDigitable = 1
	LEFT JOIN ProductoComercialConfiguracion pcc WITH (NOLOCK) ON p.AnoCampania = pcc.CampaniaID
		AND p.CUV = pcc.CUV
	LEFT JOIN @OfertaProductoTemp op ON op.CampaniaID = p.CampaniaID
		AND op.CUV = p.CUV
	LEFT JOIN ods.ProductosLanzamiento pl WITH (NOLOCK) ON p.CodigoProducto = pl.CodigoSAP
		AND p.AnoCampania = pl.Campania
	LEFT JOIN ProductoComercialOfertaRevista pcor WITH (NOLOCK) ON p.AnoCampania = pcor.Campania
		AND p.CUV = pcor.CUV
	LEFT JOIN Marca M WITH (NOLOCK) ON p.MarcaId = m.MarcaId
	WHERE --p.IndicadorDigitable = 1 
		--AND p.PrecioCatalogo >= ISNULL(@PrecioMinimo,0)
		--AND p.PrecioCatalogo >= ISNULL(@MontoFaltante,0)
		tc.EstaEnPedido = 0
	ORDER BY tc.OrdenMeta ASC
		,tc.EsCross DESC
		,tc.Orden ASC
END
GO

USE [BelcorpMexico]
GO
ALTER PROCEDURE [dbo].[GetListaProductoCrossSelling] (@Table1 dbo.ListaOfertaFinalType READONLY)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @codConsultoraForzadas VARCHAR(9) = ''

	SELECT @codConsultoraForzadas = Codigo
	FROM TablaLogicaDatos WITH (NOLOCK)
	WHERE TablaLogicaDatosID = 10002

	DECLARE @CampaniaID INT
		,@CodigoConsultora VARCHAR(30)
		,@TipoProductoMostrar INT
		,@ZonaID INT
		,@CodigoRegion VARCHAR(8)
		,@CodigoZona VARCHAR(8)
		,@MontoMinPedido NUMERIC(15, 2)
		,@MontoTotal MONEY
		,@MontoEscala MONEY

	SELECT @CampaniaID = CampaniaID
		,@CodigoConsultora = CodigoConsultora
		,@ZonaID = ZonaID
		,@CodigoRegion = CodigoRegion
		,@CodigoZona = CodigoZona
		,@MontoMinPedido = MontoMinimo
		,@MontoTotal = MontoTotal
		,@MontoEscala = MontoEscala
	FROM @Table1

	IF (@MontoTotal > @MontoMinPedido)
		IF @MontoEscala > @MontoMinPedido
			SET @TipoProductoMostrar = 1
		ELSE
			SET @TipoProductoMostrar = 2
	ELSE
		SET @TipoProductoMostrar = 2

	-- PASO 1 (obtener cuvs del pedido)
	DECLARE @tablaCuvPedido TABLE (
		CUV VARCHAR(9)
		,CodigoSap VARCHAR(30)
		)

	INSERT INTO @tablaCuvPedido
	SELECT pc.CUV
		,pc.CodigoProducto
	FROM PedidoWebDetalle pd WITH (NOLOCK)
	INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON pd.CampaniaID = pc.AnoCampania
		AND pd.CUV = pc.CUV
		AND pc.IndicadorDigitable = 1
	INNER JOIN ods.Consultora c WITH (NOLOCK) ON pd.ConsultoraID = c.ConsultoraID
	WHERE pd.CampaniaID = @CampaniaID
		AND c.Codigo = @CodigoConsultora

	-- PASO 2 (obtener cuvs personalizados)
	DECLARE @TablaCross TABLE (
		CampaniaID INT
		,CUV VARCHAR(6)
		,CodigoSap VARCHAR(30)
		,PrecioCatalogo DECIMAL(15, 2)
		,CodVinculo INT
		,PPU DECIMAL(15, 2)
		,Orden INT
		,EsCross BIT
		,PrecioOk BIT
		,TipoMeta CHAR(2)
		,OrdenMeta INT
		,CUVPedido VARCHAR(6)
		,CUV2 VARCHAR(6)
		,MarcaID INT
		,CodCampania INT
		,EstaEnPedido BIT
		,CodConsultora VARCHAR(20)
		)

	INSERT INTO @TablaCross
	SELECT pc.CampaniaID
		,pc.CUV
		,pc.CodigoProducto
		,pc.PrecioCatalogo
		,op.CodVinculo
		,op.PPU
		,op.Orden
		,1
		,0
		,''
		,0
		,''
		,''
		,pc.MarcaID
		,pc.AnoCampania
		,0
		,op.CodConsultora
	FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
	INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON op.AnioCampanaVenta = pc.AnoCampania
		AND op.CUV = pc.CUV
		AND op.CodConsultora IN (
			@CodigoConsultora
			,@codConsultoraForzadas
			)
		AND op.TipoPersonalizacion = 'OF'
	WHERE op.AnioCampanaVenta = @CampaniaID
		AND pc.IndicadorDigitable = 1
		AND pc.EstrategiaIdSicc != '2003'

	-- PASO 3 (validar si hay cuvs personalizados)
	DECLARE @cantOfertas INT = 0
		,@codConsultoraGenerica VARCHAR(30) = ''

	SELECT @cantOfertas = COUNT(1)
	FROM @TablaCross
	WHERE CodConsultora != @codConsultoraForzadas

	IF ISNULL(@cantOfertas, 0) = 0
	BEGIN
		SELECT @codConsultoraGenerica = Codigo
		FROM TablaLogicaDatos
		WHERE TablaLogicaDatosID = 10001

		IF ISNULL(@codConsultoraGenerica, '') != ''
		BEGIN
			INSERT INTO @TablaCross
			SELECT pc.CampaniaID
				,pc.CUV
				,pc.CodigoProducto
				,pc.PrecioCatalogo
				,op.CodVinculo
				,op.PPU
				,op.Orden
				,1
				,0
				,''
				,0
				,''
				,''
				,pc.MarcaID
				,pc.AnoCampania
				,0
				,op.CodConsultora
			FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
			INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON op.AnioCampanaVenta = pc.AnoCampania
				AND op.CUV = pc.CUV
				AND op.CodConsultora = @codConsultoraGenerica
				AND op.TipoPersonalizacion = 'OF'
			WHERE op.AnioCampanaVenta = @CampaniaID
				AND pc.IndicadorDigitable = 1
				AND pc.EstrategiaIdSicc != '2003'
		END
	END

	-- PASO 4 (validar datos de las ofertas)
	UPDATE a
	SET a.EstaEnPedido = 1
		,a.CUVPedido = b.CUV
	FROM @TablaCross a
	INNER JOIN @TablaCuvPedido b ON a.CodigoSap = b.CodigoSap

	UPDATE a
	SET a.CUVPedido = b.CUVPedido
	FROM @TablaCross a
	INNER JOIN (
		SELECT CodVinculo
			,CUVPedido
		FROM @TablaCross
		WHERE EstaEnPedido = 1
		) b ON a.CodVinculo = b.CodVinculo
	WHERE a.EstaEnPedido = 0

	UPDATE a
	SET a.EsCross = 0
	FROM @TablaCross a
	INNER JOIN (
		SELECT CodVinculo
		FROM @TablaCross
		WHERE EstaEnPedido = 0
		GROUP BY CodVinculo
		HAVING COUNT(CUV) > 1
		) b ON a.CodVinculo = b.CodVinculo
	WHERE a.EstaEnPedido = 0

	UPDATE a
	SET a.PrecioOk = 1
	FROM @TablaCross a
	INNER JOIN (
		SELECT CUV
		FROM @TablaCross
		WHERE PrecioCatalogo <= PPU
		) b ON a.CUV = b.CUV
	WHERE a.EstaEnPedido = 0

	-- PASO 5 (validar GAP)
	DECLARE @GAP DECIMAL(15, 2)
		,@TipoMeta CHAR(2)

	IF (@TipoProductoMostrar = 1)
	BEGIN
		DECLARE @MontoHasta NUMERIC(15, 2)

		SELECT TOP 1 @MontoHasta = MontoHasta
			,@TipoMeta = PorDescuento
		FROM dbo.Fn_GetEscalaDescuentoZona(@CampaniaID,@CodigoRegion,@CodigoZona)
		WHERE MontoHasta >= ISNULL(@MontoEscala, 0)

		IF (@MontoHasta > @MontoMinPedido)
		BEGIN
			SELECT TOP 1 @TipoMeta = PorDescuento
			FROM dbo.Fn_GetEscalaDescuentoZona(@CampaniaID,@CodigoRegion,@CodigoZona)
			WHERE PorDescuento > @TipoMeta
		END

		SET @GAP = (@MontoHasta - @MontoTotal)
	END
	ELSE
	BEGIN
		IF (@MontoTotal > @MontoMinPedido)
			IF @MontoEscala > @MontoMinPedido
				SET @GAP = 0
			ELSE
				SET @GAP = (@MontoMinPedido - @MontoEscala)
		ELSE
			SET @GAP = (@MontoMinPedido - @MontoTotal)
	END

	--5.1 (actualizar TipoMeta)
	UPDATE a
	SET a.TipoMeta = (
			CASE 
				WHEN @TipoProductoMostrar = 1
					THEN @TipoMeta
				ELSE 'MM'
				END
			)
		,a.OrdenMeta = (
			CASE 
				WHEN @TipoProductoMostrar = 1
					THEN 2
				ELSE 1
				END
			)
	FROM @TablaCross a
	INNER JOIN (
		SELECT CUV
		FROM @TablaCross
		WHERE PrecioCatalogo >= @GAP
		) b ON a.CUV = b.CUV
	WHERE a.EstaEnPedido = 0

	--5.2 (actualizar GM)
	UPDATE a
	SET a.TipoMeta = 'GM'
		,a.OrdenMeta = 3
	FROM @TablaCross a
	INNER JOIN (
		SELECT CUV
		FROM @TablaCross
		WHERE PrecioCatalogo < @GAP
		) b ON a.CUV = b.CUV
	WHERE a.EstaEnPedido = 0

	--PASO 6 (validar cuvs faltantes)
	DECLARE @tablaCuvFaltante TABLE (CUV VARCHAR(6))

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
			)

	--  6.1 (eliminar cuv faltantes)
	DELETE
	FROM @TablaCross
	WHERE CUV IN (
			SELECT CUV
			FROM @tablaCuvFaltante
			)
		AND EstaEnPedido = 0

	-- PASO 7 (obtener ofertas productos)
	DECLARE @OfertaProductoTemp TABLE (
		CampaniaID INT
		,CUV VARCHAR(6)
		,ConfiguracionOfertaID INT
		,TipoOfertaSisID INT
		)

	INSERT INTO @OfertaProductoTemp
	SELECT op.CampaniaID
		,op.CUV
		,op.ConfiguracionOfertaID
		,op.TipoOfertaSisID
	FROM OfertaProducto op WITH (NOLOCK)
	INNER JOIN @TablaCross tc ON op.CampaniaID = tc.CodCampania
		AND op.CUV = tc.CUV
	WHERE tc.EstaEnPedido = 0

	-- PASO 8 (actualizar CUV2 desde ProductoComercial)
	UPDATE tc
	SET tc.CUV2 = pc.CUV
	FROM @TablaCross tc
	INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON tc.CampaniaID = pc.CampaniaID
		AND tc.CodigoSap = pc.CodigoProducto
		AND pc.IndicadorDigitable = 1
	WHERE tc.EstaEnPedido = 0

	-- PASO 9 (filtrar resultados)
	SELECT DISTINCT p.CUV
		,p.Descripcion AS Descripcion
		,(p.PrecioUnitario * p.FactorRepeticion) AS PrecioCatalogo
		,p.PrecioValorizado
		,p.MarcaID AS IdMarca
		,p.PaisID
		,p.AnoCampania AS CampaniaID
		,p.CodigoCatalago
		,p.CodigoProducto AS CodigoSap
		,p.IndicadorMontoMinimo
		,p.IndicadorOferta
		,0 AS EstaEnRevista
		,ISNULL(pcc.EsExpoOferta, 0) AS EsExpoOferta
		,ISNULL(pcc.CUVRevista, '') AS CUVRevista
		,m.Descripcion AS NombreMarca
		,'NO DISPONIBLE' AS DescripcionCategoria
		,'' AS CUVComplemento
		,'' AS DescripcionEstrategia
		,ISNULL(op.ConfiguracionOfertaID, 0) AS ConfiguracionOfertaID
		,ISNULL(op.TipoOfertaSisID, 0) AS TipoOfertaSisID
		,0 AS FlagNueva
		,0 AS TipoEstrategiaID
		,0 AS TieneSugerido
		,CASE 
			WHEN pl.CodigoSAP IS NULL
				THEN 0
			ELSE 1
			END AS TieneLanzamientoCatalogoPersonalizado
		,CASE 
			WHEN pcor.SAP IS NULL
				THEN 0
			ELSE 1
			END AS TieneOfertaRevista
		,ISNULL(pcor.Oferta, '') AS TipoOfertaRevista
		,
		--tc.CodigoSap,
		tc.Orden
		,1 AS TipoCross
		,tc.EsCross
		,tc.TipoMeta
		,tc.OrdenMeta
		,@GAP AS MontoMeta
		,tc.CodVinculo
		,tc.CUVPedido
		,tc.CUV2
	FROM @TablaCross tc
	INNER JOIN ods.ProductoComercial p WITH (NOLOCK) ON tc.CampaniaID = p.CampaniaID
		AND tc.CUV = p.CUV
		AND p.IndicadorDigitable = 1
	LEFT JOIN ProductoComercialConfiguracion pcc WITH (NOLOCK) ON p.AnoCampania = pcc.CampaniaID
		AND p.CUV = pcc.CUV
	LEFT JOIN @OfertaProductoTemp op ON op.CampaniaID = p.CampaniaID
		AND op.CUV = p.CUV
	LEFT JOIN ods.ProductosLanzamiento pl WITH (NOLOCK) ON p.CodigoProducto = pl.CodigoSAP
		AND p.AnoCampania = pl.Campania
	LEFT JOIN ProductoComercialOfertaRevista pcor WITH (NOLOCK) ON p.AnoCampania = pcor.Campania
		AND p.CUV = pcor.CUV
	LEFT JOIN Marca M WITH (NOLOCK) ON p.MarcaId = m.MarcaId
	WHERE --p.IndicadorDigitable = 1 
		--AND p.PrecioCatalogo >= ISNULL(@PrecioMinimo,0)
		--AND p.PrecioCatalogo >= ISNULL(@MontoFaltante,0)
		tc.EstaEnPedido = 0
	ORDER BY tc.OrdenMeta ASC
		,tc.EsCross DESC
		,tc.Orden ASC
END
GO

USE [BelcorpPanama]
GO
ALTER PROCEDURE [dbo].[GetListaProductoCrossSelling] (@Table1 dbo.ListaOfertaFinalType READONLY)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @codConsultoraForzadas VARCHAR(9) = ''

	SELECT @codConsultoraForzadas = Codigo
	FROM TablaLogicaDatos WITH (NOLOCK)
	WHERE TablaLogicaDatosID = 10002

	DECLARE @CampaniaID INT
		,@CodigoConsultora VARCHAR(30)
		,@TipoProductoMostrar INT
		,@ZonaID INT
		,@CodigoRegion VARCHAR(8)
		,@CodigoZona VARCHAR(8)
		,@MontoMinPedido NUMERIC(15, 2)
		,@MontoTotal MONEY
		,@MontoEscala MONEY

	SELECT @CampaniaID = CampaniaID
		,@CodigoConsultora = CodigoConsultora
		,@ZonaID = ZonaID
		,@CodigoRegion = CodigoRegion
		,@CodigoZona = CodigoZona
		,@MontoMinPedido = MontoMinimo
		,@MontoTotal = MontoTotal
		,@MontoEscala = MontoEscala
	FROM @Table1

	IF (@MontoTotal > @MontoMinPedido)
		IF @MontoEscala > @MontoMinPedido
			SET @TipoProductoMostrar = 1
		ELSE
			SET @TipoProductoMostrar = 2
	ELSE
		SET @TipoProductoMostrar = 2

	-- PASO 1 (obtener cuvs del pedido)
	DECLARE @tablaCuvPedido TABLE (
		CUV VARCHAR(9)
		,CodigoSap VARCHAR(30)
		)

	INSERT INTO @tablaCuvPedido
	SELECT pc.CUV
		,pc.CodigoProducto
	FROM PedidoWebDetalle pd WITH (NOLOCK)
	INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON pd.CampaniaID = pc.AnoCampania
		AND pd.CUV = pc.CUV
		AND pc.IndicadorDigitable = 1
	INNER JOIN ods.Consultora c WITH (NOLOCK) ON pd.ConsultoraID = c.ConsultoraID
	WHERE pd.CampaniaID = @CampaniaID
		AND c.Codigo = @CodigoConsultora

	-- PASO 2 (obtener cuvs personalizados)
	DECLARE @TablaCross TABLE (
		CampaniaID INT
		,CUV VARCHAR(6)
		,CodigoSap VARCHAR(30)
		,PrecioCatalogo DECIMAL(15, 2)
		,CodVinculo INT
		,PPU DECIMAL(15, 2)
		,Orden INT
		,EsCross BIT
		,PrecioOk BIT
		,TipoMeta CHAR(2)
		,OrdenMeta INT
		,CUVPedido VARCHAR(6)
		,CUV2 VARCHAR(6)
		,MarcaID INT
		,CodCampania INT
		,EstaEnPedido BIT
		,CodConsultora VARCHAR(20)
		)

	INSERT INTO @TablaCross
	SELECT pc.CampaniaID
		,pc.CUV
		,pc.CodigoProducto
		,pc.PrecioCatalogo
		,op.CodVinculo
		,op.PPU
		,op.Orden
		,1
		,0
		,''
		,0
		,''
		,''
		,pc.MarcaID
		,pc.AnoCampania
		,0
		,op.CodConsultora
	FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
	INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON op.AnioCampanaVenta = pc.AnoCampania
		AND op.CUV = pc.CUV
		AND op.CodConsultora IN (
			@CodigoConsultora
			,@codConsultoraForzadas
			)
		AND op.TipoPersonalizacion = 'OF'
	WHERE op.AnioCampanaVenta = @CampaniaID
		AND pc.IndicadorDigitable = 1
		AND pc.EstrategiaIdSicc != '2003'

	-- PASO 3 (validar si hay cuvs personalizados)
	DECLARE @cantOfertas INT = 0
		,@codConsultoraGenerica VARCHAR(30) = ''

	SELECT @cantOfertas = COUNT(1)
	FROM @TablaCross
	WHERE CodConsultora != @codConsultoraForzadas

	IF ISNULL(@cantOfertas, 0) = 0
	BEGIN
		SELECT @codConsultoraGenerica = Codigo
		FROM TablaLogicaDatos
		WHERE TablaLogicaDatosID = 10001

		IF ISNULL(@codConsultoraGenerica, '') != ''
		BEGIN
			INSERT INTO @TablaCross
			SELECT pc.CampaniaID
				,pc.CUV
				,pc.CodigoProducto
				,pc.PrecioCatalogo
				,op.CodVinculo
				,op.PPU
				,op.Orden
				,1
				,0
				,''
				,0
				,''
				,''
				,pc.MarcaID
				,pc.AnoCampania
				,0
				,op.CodConsultora
			FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
			INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON op.AnioCampanaVenta = pc.AnoCampania
				AND op.CUV = pc.CUV
				AND op.CodConsultora = @codConsultoraGenerica
				AND op.TipoPersonalizacion = 'OF'
			WHERE op.AnioCampanaVenta = @CampaniaID
				AND pc.IndicadorDigitable = 1
				AND pc.EstrategiaIdSicc != '2003'
		END
	END

	-- PASO 4 (validar datos de las ofertas)
	UPDATE a
	SET a.EstaEnPedido = 1
		,a.CUVPedido = b.CUV
	FROM @TablaCross a
	INNER JOIN @TablaCuvPedido b ON a.CodigoSap = b.CodigoSap

	UPDATE a
	SET a.CUVPedido = b.CUVPedido
	FROM @TablaCross a
	INNER JOIN (
		SELECT CodVinculo
			,CUVPedido
		FROM @TablaCross
		WHERE EstaEnPedido = 1
		) b ON a.CodVinculo = b.CodVinculo
	WHERE a.EstaEnPedido = 0

	UPDATE a
	SET a.EsCross = 0
	FROM @TablaCross a
	INNER JOIN (
		SELECT CodVinculo
		FROM @TablaCross
		WHERE EstaEnPedido = 0
		GROUP BY CodVinculo
		HAVING COUNT(CUV) > 1
		) b ON a.CodVinculo = b.CodVinculo
	WHERE a.EstaEnPedido = 0

	UPDATE a
	SET a.PrecioOk = 1
	FROM @TablaCross a
	INNER JOIN (
		SELECT CUV
		FROM @TablaCross
		WHERE PrecioCatalogo <= PPU
		) b ON a.CUV = b.CUV
	WHERE a.EstaEnPedido = 0

	-- PASO 5 (validar GAP)
	DECLARE @GAP DECIMAL(15, 2)
		,@TipoMeta CHAR(2)

	IF (@TipoProductoMostrar = 1)
	BEGIN
		DECLARE @MontoHasta NUMERIC(15, 2)

		SELECT TOP 1 @MontoHasta = MontoHasta
			,@TipoMeta = PorDescuento
		FROM dbo.Fn_GetEscalaDescuentoZona(@CampaniaID,@CodigoRegion,@CodigoZona)
		WHERE MontoHasta >= ISNULL(@MontoEscala, 0)

		IF (@MontoHasta > @MontoMinPedido)
		BEGIN
			SELECT TOP 1 @TipoMeta = PorDescuento
			FROM dbo.Fn_GetEscalaDescuentoZona(@CampaniaID,@CodigoRegion,@CodigoZona)
			WHERE PorDescuento > @TipoMeta
		END

		SET @GAP = (@MontoHasta - @MontoTotal)
	END
	ELSE
	BEGIN
		IF (@MontoTotal > @MontoMinPedido)
			IF @MontoEscala > @MontoMinPedido
				SET @GAP = 0
			ELSE
				SET @GAP = (@MontoMinPedido - @MontoEscala)
		ELSE
			SET @GAP = (@MontoMinPedido - @MontoTotal)
	END

	--5.1 (actualizar TipoMeta)
	UPDATE a
	SET a.TipoMeta = (
			CASE 
				WHEN @TipoProductoMostrar = 1
					THEN @TipoMeta
				ELSE 'MM'
				END
			)
		,a.OrdenMeta = (
			CASE 
				WHEN @TipoProductoMostrar = 1
					THEN 2
				ELSE 1
				END
			)
	FROM @TablaCross a
	INNER JOIN (
		SELECT CUV
		FROM @TablaCross
		WHERE PrecioCatalogo >= @GAP
		) b ON a.CUV = b.CUV
	WHERE a.EstaEnPedido = 0

	--5.2 (actualizar GM)
	UPDATE a
	SET a.TipoMeta = 'GM'
		,a.OrdenMeta = 3
	FROM @TablaCross a
	INNER JOIN (
		SELECT CUV
		FROM @TablaCross
		WHERE PrecioCatalogo < @GAP
		) b ON a.CUV = b.CUV
	WHERE a.EstaEnPedido = 0

	--PASO 6 (validar cuvs faltantes)
	DECLARE @tablaCuvFaltante TABLE (CUV VARCHAR(6))

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
			)

	--  6.1 (eliminar cuv faltantes)
	DELETE
	FROM @TablaCross
	WHERE CUV IN (
			SELECT CUV
			FROM @tablaCuvFaltante
			)
		AND EstaEnPedido = 0

	-- PASO 7 (obtener ofertas productos)
	DECLARE @OfertaProductoTemp TABLE (
		CampaniaID INT
		,CUV VARCHAR(6)
		,ConfiguracionOfertaID INT
		,TipoOfertaSisID INT
		)

	INSERT INTO @OfertaProductoTemp
	SELECT op.CampaniaID
		,op.CUV
		,op.ConfiguracionOfertaID
		,op.TipoOfertaSisID
	FROM OfertaProducto op WITH (NOLOCK)
	INNER JOIN @TablaCross tc ON op.CampaniaID = tc.CodCampania
		AND op.CUV = tc.CUV
	WHERE tc.EstaEnPedido = 0

	-- PASO 8 (actualizar CUV2 desde ProductoComercial)
	UPDATE tc
	SET tc.CUV2 = pc.CUV
	FROM @TablaCross tc
	INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON tc.CampaniaID = pc.CampaniaID
		AND tc.CodigoSap = pc.CodigoProducto
		AND pc.IndicadorDigitable = 1
	WHERE tc.EstaEnPedido = 0

	-- PASO 9 (filtrar resultados)
	SELECT DISTINCT p.CUV
		,p.Descripcion AS Descripcion
		,(p.PrecioUnitario * p.FactorRepeticion) AS PrecioCatalogo
		,p.PrecioValorizado
		,p.MarcaID AS IdMarca
		,p.PaisID
		,p.AnoCampania AS CampaniaID
		,p.CodigoCatalago
		,p.CodigoProducto AS CodigoSap
		,p.IndicadorMontoMinimo
		,p.IndicadorOferta
		,0 AS EstaEnRevista
		,ISNULL(pcc.EsExpoOferta, 0) AS EsExpoOferta
		,ISNULL(pcc.CUVRevista, '') AS CUVRevista
		,m.Descripcion AS NombreMarca
		,'NO DISPONIBLE' AS DescripcionCategoria
		,'' AS CUVComplemento
		,'' AS DescripcionEstrategia
		,ISNULL(op.ConfiguracionOfertaID, 0) AS ConfiguracionOfertaID
		,ISNULL(op.TipoOfertaSisID, 0) AS TipoOfertaSisID
		,0 AS FlagNueva
		,0 AS TipoEstrategiaID
		,0 AS TieneSugerido
		,CASE 
			WHEN pl.CodigoSAP IS NULL
				THEN 0
			ELSE 1
			END AS TieneLanzamientoCatalogoPersonalizado
		,CASE 
			WHEN pcor.SAP IS NULL
				THEN 0
			ELSE 1
			END AS TieneOfertaRevista
		,ISNULL(pcor.Oferta, '') AS TipoOfertaRevista
		,
		--tc.CodigoSap,
		tc.Orden
		,1 AS TipoCross
		,tc.EsCross
		,tc.TipoMeta
		,tc.OrdenMeta
		,@GAP AS MontoMeta
		,tc.CodVinculo
		,tc.CUVPedido
		,tc.CUV2
	FROM @TablaCross tc
	INNER JOIN ods.ProductoComercial p WITH (NOLOCK) ON tc.CampaniaID = p.CampaniaID
		AND tc.CUV = p.CUV
		AND p.IndicadorDigitable = 1
	LEFT JOIN ProductoComercialConfiguracion pcc WITH (NOLOCK) ON p.AnoCampania = pcc.CampaniaID
		AND p.CUV = pcc.CUV
	LEFT JOIN @OfertaProductoTemp op ON op.CampaniaID = p.CampaniaID
		AND op.CUV = p.CUV
	LEFT JOIN ods.ProductosLanzamiento pl WITH (NOLOCK) ON p.CodigoProducto = pl.CodigoSAP
		AND p.AnoCampania = pl.Campania
	LEFT JOIN ProductoComercialOfertaRevista pcor WITH (NOLOCK) ON p.AnoCampania = pcor.Campania
		AND p.CUV = pcor.CUV
	LEFT JOIN Marca M WITH (NOLOCK) ON p.MarcaId = m.MarcaId
	WHERE --p.IndicadorDigitable = 1 
		--AND p.PrecioCatalogo >= ISNULL(@PrecioMinimo,0)
		--AND p.PrecioCatalogo >= ISNULL(@MontoFaltante,0)
		tc.EstaEnPedido = 0
	ORDER BY tc.OrdenMeta ASC
		,tc.EsCross DESC
		,tc.Orden ASC
END
GO

USE [BelcorpPuertoRico]
GO
ALTER PROCEDURE [dbo].[GetListaProductoCrossSelling] (@Table1 dbo.ListaOfertaFinalType READONLY)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @codConsultoraForzadas VARCHAR(9) = ''

	SELECT @codConsultoraForzadas = Codigo
	FROM TablaLogicaDatos WITH (NOLOCK)
	WHERE TablaLogicaDatosID = 10002

	DECLARE @CampaniaID INT
		,@CodigoConsultora VARCHAR(30)
		,@TipoProductoMostrar INT
		,@ZonaID INT
		,@CodigoRegion VARCHAR(8)
		,@CodigoZona VARCHAR(8)
		,@MontoMinPedido NUMERIC(15, 2)
		,@MontoTotal MONEY
		,@MontoEscala MONEY

	SELECT @CampaniaID = CampaniaID
		,@CodigoConsultora = CodigoConsultora
		,@ZonaID = ZonaID
		,@CodigoRegion = CodigoRegion
		,@CodigoZona = CodigoZona
		,@MontoMinPedido = MontoMinimo
		,@MontoTotal = MontoTotal
		,@MontoEscala = MontoEscala
	FROM @Table1

	IF (@MontoTotal > @MontoMinPedido)
		IF @MontoEscala > @MontoMinPedido
			SET @TipoProductoMostrar = 1
		ELSE
			SET @TipoProductoMostrar = 2
	ELSE
		SET @TipoProductoMostrar = 2

	-- PASO 1 (obtener cuvs del pedido)
	DECLARE @tablaCuvPedido TABLE (
		CUV VARCHAR(9)
		,CodigoSap VARCHAR(30)
		)

	INSERT INTO @tablaCuvPedido
	SELECT pc.CUV
		,pc.CodigoProducto
	FROM PedidoWebDetalle pd WITH (NOLOCK)
	INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON pd.CampaniaID = pc.AnoCampania
		AND pd.CUV = pc.CUV
		AND pc.IndicadorDigitable = 1
	INNER JOIN ods.Consultora c WITH (NOLOCK) ON pd.ConsultoraID = c.ConsultoraID
	WHERE pd.CampaniaID = @CampaniaID
		AND c.Codigo = @CodigoConsultora

	-- PASO 2 (obtener cuvs personalizados)
	DECLARE @TablaCross TABLE (
		CampaniaID INT
		,CUV VARCHAR(6)
		,CodigoSap VARCHAR(30)
		,PrecioCatalogo DECIMAL(15, 2)
		,CodVinculo INT
		,PPU DECIMAL(15, 2)
		,Orden INT
		,EsCross BIT
		,PrecioOk BIT
		,TipoMeta CHAR(2)
		,OrdenMeta INT
		,CUVPedido VARCHAR(6)
		,CUV2 VARCHAR(6)
		,MarcaID INT
		,CodCampania INT
		,EstaEnPedido BIT
		,CodConsultora VARCHAR(20)
		)

	INSERT INTO @TablaCross
	SELECT pc.CampaniaID
		,pc.CUV
		,pc.CodigoProducto
		,pc.PrecioCatalogo
		,op.CodVinculo
		,op.PPU
		,op.Orden
		,1
		,0
		,''
		,0
		,''
		,''
		,pc.MarcaID
		,pc.AnoCampania
		,0
		,op.CodConsultora
	FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
	INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON op.AnioCampanaVenta = pc.AnoCampania
		AND op.CUV = pc.CUV
		AND op.CodConsultora IN (
			@CodigoConsultora
			,@codConsultoraForzadas
			)
		AND op.TipoPersonalizacion = 'OF'
	WHERE op.AnioCampanaVenta = @CampaniaID
		AND pc.IndicadorDigitable = 1
		AND pc.EstrategiaIdSicc != '2003'

	-- PASO 3 (validar si hay cuvs personalizados)
	DECLARE @cantOfertas INT = 0
		,@codConsultoraGenerica VARCHAR(30) = ''

	SELECT @cantOfertas = COUNT(1)
	FROM @TablaCross
	WHERE CodConsultora != @codConsultoraForzadas

	IF ISNULL(@cantOfertas, 0) = 0
	BEGIN
		SELECT @codConsultoraGenerica = Codigo
		FROM TablaLogicaDatos
		WHERE TablaLogicaDatosID = 10001

		IF ISNULL(@codConsultoraGenerica, '') != ''
		BEGIN
			INSERT INTO @TablaCross
			SELECT pc.CampaniaID
				,pc.CUV
				,pc.CodigoProducto
				,pc.PrecioCatalogo
				,op.CodVinculo
				,op.PPU
				,op.Orden
				,1
				,0
				,''
				,0
				,''
				,''
				,pc.MarcaID
				,pc.AnoCampania
				,0
				,op.CodConsultora
			FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
			INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON op.AnioCampanaVenta = pc.AnoCampania
				AND op.CUV = pc.CUV
				AND op.CodConsultora = @codConsultoraGenerica
				AND op.TipoPersonalizacion = 'OF'
			WHERE op.AnioCampanaVenta = @CampaniaID
				AND pc.IndicadorDigitable = 1
				AND pc.EstrategiaIdSicc != '2003'
		END
	END

	-- PASO 4 (validar datos de las ofertas)
	UPDATE a
	SET a.EstaEnPedido = 1
		,a.CUVPedido = b.CUV
	FROM @TablaCross a
	INNER JOIN @TablaCuvPedido b ON a.CodigoSap = b.CodigoSap

	UPDATE a
	SET a.CUVPedido = b.CUVPedido
	FROM @TablaCross a
	INNER JOIN (
		SELECT CodVinculo
			,CUVPedido
		FROM @TablaCross
		WHERE EstaEnPedido = 1
		) b ON a.CodVinculo = b.CodVinculo
	WHERE a.EstaEnPedido = 0

	UPDATE a
	SET a.EsCross = 0
	FROM @TablaCross a
	INNER JOIN (
		SELECT CodVinculo
		FROM @TablaCross
		WHERE EstaEnPedido = 0
		GROUP BY CodVinculo
		HAVING COUNT(CUV) > 1
		) b ON a.CodVinculo = b.CodVinculo
	WHERE a.EstaEnPedido = 0

	UPDATE a
	SET a.PrecioOk = 1
	FROM @TablaCross a
	INNER JOIN (
		SELECT CUV
		FROM @TablaCross
		WHERE PrecioCatalogo <= PPU
		) b ON a.CUV = b.CUV
	WHERE a.EstaEnPedido = 0

	-- PASO 5 (validar GAP)
	DECLARE @GAP DECIMAL(15, 2)
		,@TipoMeta CHAR(2)

	IF (@TipoProductoMostrar = 1)
	BEGIN
		DECLARE @MontoHasta NUMERIC(15, 2)

		SELECT TOP 1 @MontoHasta = MontoHasta
			,@TipoMeta = PorDescuento
		FROM dbo.Fn_GetEscalaDescuentoZona(@CampaniaID,@CodigoRegion,@CodigoZona)
		WHERE MontoHasta >= ISNULL(@MontoEscala, 0)

		IF (@MontoHasta > @MontoMinPedido)
		BEGIN
			SELECT TOP 1 @TipoMeta = PorDescuento
			FROM dbo.Fn_GetEscalaDescuentoZona(@CampaniaID,@CodigoRegion,@CodigoZona)
			WHERE PorDescuento > @TipoMeta
		END

		SET @GAP = (@MontoHasta - @MontoTotal)
	END
	ELSE
	BEGIN
		IF (@MontoTotal > @MontoMinPedido)
			IF @MontoEscala > @MontoMinPedido
				SET @GAP = 0
			ELSE
				SET @GAP = (@MontoMinPedido - @MontoEscala)
		ELSE
			SET @GAP = (@MontoMinPedido - @MontoTotal)
	END

	--5.1 (actualizar TipoMeta)
	UPDATE a
	SET a.TipoMeta = (
			CASE 
				WHEN @TipoProductoMostrar = 1
					THEN @TipoMeta
				ELSE 'MM'
				END
			)
		,a.OrdenMeta = (
			CASE 
				WHEN @TipoProductoMostrar = 1
					THEN 2
				ELSE 1
				END
			)
	FROM @TablaCross a
	INNER JOIN (
		SELECT CUV
		FROM @TablaCross
		WHERE PrecioCatalogo >= @GAP
		) b ON a.CUV = b.CUV
	WHERE a.EstaEnPedido = 0

	--5.2 (actualizar GM)
	UPDATE a
	SET a.TipoMeta = 'GM'
		,a.OrdenMeta = 3
	FROM @TablaCross a
	INNER JOIN (
		SELECT CUV
		FROM @TablaCross
		WHERE PrecioCatalogo < @GAP
		) b ON a.CUV = b.CUV
	WHERE a.EstaEnPedido = 0

	--PASO 6 (validar cuvs faltantes)
	DECLARE @tablaCuvFaltante TABLE (CUV VARCHAR(6))

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
			)

	--  6.1 (eliminar cuv faltantes)
	DELETE
	FROM @TablaCross
	WHERE CUV IN (
			SELECT CUV
			FROM @tablaCuvFaltante
			)
		AND EstaEnPedido = 0

	-- PASO 7 (obtener ofertas productos)
	DECLARE @OfertaProductoTemp TABLE (
		CampaniaID INT
		,CUV VARCHAR(6)
		,ConfiguracionOfertaID INT
		,TipoOfertaSisID INT
		)

	INSERT INTO @OfertaProductoTemp
	SELECT op.CampaniaID
		,op.CUV
		,op.ConfiguracionOfertaID
		,op.TipoOfertaSisID
	FROM OfertaProducto op WITH (NOLOCK)
	INNER JOIN @TablaCross tc ON op.CampaniaID = tc.CodCampania
		AND op.CUV = tc.CUV
	WHERE tc.EstaEnPedido = 0

	-- PASO 8 (actualizar CUV2 desde ProductoComercial)
	UPDATE tc
	SET tc.CUV2 = pc.CUV
	FROM @TablaCross tc
	INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON tc.CampaniaID = pc.CampaniaID
		AND tc.CodigoSap = pc.CodigoProducto
		AND pc.IndicadorDigitable = 1
	WHERE tc.EstaEnPedido = 0

	-- PASO 9 (filtrar resultados)
	SELECT DISTINCT p.CUV
		,p.Descripcion AS Descripcion
		,(p.PrecioUnitario * p.FactorRepeticion) AS PrecioCatalogo
		,p.PrecioValorizado
		,p.MarcaID AS IdMarca
		,p.PaisID
		,p.AnoCampania AS CampaniaID
		,p.CodigoCatalago
		,p.CodigoProducto AS CodigoSap
		,p.IndicadorMontoMinimo
		,p.IndicadorOferta
		,0 AS EstaEnRevista
		,ISNULL(pcc.EsExpoOferta, 0) AS EsExpoOferta
		,ISNULL(pcc.CUVRevista, '') AS CUVRevista
		,m.Descripcion AS NombreMarca
		,'NO DISPONIBLE' AS DescripcionCategoria
		,'' AS CUVComplemento
		,'' AS DescripcionEstrategia
		,ISNULL(op.ConfiguracionOfertaID, 0) AS ConfiguracionOfertaID
		,ISNULL(op.TipoOfertaSisID, 0) AS TipoOfertaSisID
		,0 AS FlagNueva
		,0 AS TipoEstrategiaID
		,0 AS TieneSugerido
		,CASE 
			WHEN pl.CodigoSAP IS NULL
				THEN 0
			ELSE 1
			END AS TieneLanzamientoCatalogoPersonalizado
		,CASE 
			WHEN pcor.SAP IS NULL
				THEN 0
			ELSE 1
			END AS TieneOfertaRevista
		,ISNULL(pcor.Oferta, '') AS TipoOfertaRevista
		,
		--tc.CodigoSap,
		tc.Orden
		,1 AS TipoCross
		,tc.EsCross
		,tc.TipoMeta
		,tc.OrdenMeta
		,@GAP AS MontoMeta
		,tc.CodVinculo
		,tc.CUVPedido
		,tc.CUV2
	FROM @TablaCross tc
	INNER JOIN ods.ProductoComercial p WITH (NOLOCK) ON tc.CampaniaID = p.CampaniaID
		AND tc.CUV = p.CUV
		AND p.IndicadorDigitable = 1
	LEFT JOIN ProductoComercialConfiguracion pcc WITH (NOLOCK) ON p.AnoCampania = pcc.CampaniaID
		AND p.CUV = pcc.CUV
	LEFT JOIN @OfertaProductoTemp op ON op.CampaniaID = p.CampaniaID
		AND op.CUV = p.CUV
	LEFT JOIN ods.ProductosLanzamiento pl WITH (NOLOCK) ON p.CodigoProducto = pl.CodigoSAP
		AND p.AnoCampania = pl.Campania
	LEFT JOIN ProductoComercialOfertaRevista pcor WITH (NOLOCK) ON p.AnoCampania = pcor.Campania
		AND p.CUV = pcor.CUV
	LEFT JOIN Marca M WITH (NOLOCK) ON p.MarcaId = m.MarcaId
	WHERE --p.IndicadorDigitable = 1 
		--AND p.PrecioCatalogo >= ISNULL(@PrecioMinimo,0)
		--AND p.PrecioCatalogo >= ISNULL(@MontoFaltante,0)
		tc.EstaEnPedido = 0
	ORDER BY tc.OrdenMeta ASC
		,tc.EsCross DESC
		,tc.Orden ASC
END
GO

USE [BelcorpSalvador]
GO
ALTER PROCEDURE [dbo].[GetListaProductoCrossSelling] (@Table1 dbo.ListaOfertaFinalType READONLY)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @codConsultoraForzadas VARCHAR(9) = ''

	SELECT @codConsultoraForzadas = Codigo
	FROM TablaLogicaDatos WITH (NOLOCK)
	WHERE TablaLogicaDatosID = 10002

	DECLARE @CampaniaID INT
		,@CodigoConsultora VARCHAR(30)
		,@TipoProductoMostrar INT
		,@ZonaID INT
		,@CodigoRegion VARCHAR(8)
		,@CodigoZona VARCHAR(8)
		,@MontoMinPedido NUMERIC(15, 2)
		,@MontoTotal MONEY
		,@MontoEscala MONEY

	SELECT @CampaniaID = CampaniaID
		,@CodigoConsultora = CodigoConsultora
		,@ZonaID = ZonaID
		,@CodigoRegion = CodigoRegion
		,@CodigoZona = CodigoZona
		,@MontoMinPedido = MontoMinimo
		,@MontoTotal = MontoTotal
		,@MontoEscala = MontoEscala
	FROM @Table1

	IF (@MontoTotal > @MontoMinPedido)
		IF @MontoEscala > @MontoMinPedido
			SET @TipoProductoMostrar = 1
		ELSE
			SET @TipoProductoMostrar = 2
	ELSE
		SET @TipoProductoMostrar = 2

	-- PASO 1 (obtener cuvs del pedido)
	DECLARE @tablaCuvPedido TABLE (
		CUV VARCHAR(9)
		,CodigoSap VARCHAR(30)
		)

	INSERT INTO @tablaCuvPedido
	SELECT pc.CUV
		,pc.CodigoProducto
	FROM PedidoWebDetalle pd WITH (NOLOCK)
	INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON pd.CampaniaID = pc.AnoCampania
		AND pd.CUV = pc.CUV
		AND pc.IndicadorDigitable = 1
	INNER JOIN ods.Consultora c WITH (NOLOCK) ON pd.ConsultoraID = c.ConsultoraID
	WHERE pd.CampaniaID = @CampaniaID
		AND c.Codigo = @CodigoConsultora

	-- PASO 2 (obtener cuvs personalizados)
	DECLARE @TablaCross TABLE (
		CampaniaID INT
		,CUV VARCHAR(6)
		,CodigoSap VARCHAR(30)
		,PrecioCatalogo DECIMAL(15, 2)
		,CodVinculo INT
		,PPU DECIMAL(15, 2)
		,Orden INT
		,EsCross BIT
		,PrecioOk BIT
		,TipoMeta CHAR(2)
		,OrdenMeta INT
		,CUVPedido VARCHAR(6)
		,CUV2 VARCHAR(6)
		,MarcaID INT
		,CodCampania INT
		,EstaEnPedido BIT
		,CodConsultora VARCHAR(20)
		)

	INSERT INTO @TablaCross
	SELECT pc.CampaniaID
		,pc.CUV
		,pc.CodigoProducto
		,pc.PrecioCatalogo
		,op.CodVinculo
		,op.PPU
		,op.Orden
		,1
		,0
		,''
		,0
		,''
		,''
		,pc.MarcaID
		,pc.AnoCampania
		,0
		,op.CodConsultora
	FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
	INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON op.AnioCampanaVenta = pc.AnoCampania
		AND op.CUV = pc.CUV
		AND op.CodConsultora IN (
			@CodigoConsultora
			,@codConsultoraForzadas
			)
		AND op.TipoPersonalizacion = 'OF'
	WHERE op.AnioCampanaVenta = @CampaniaID
		AND pc.IndicadorDigitable = 1
		AND pc.EstrategiaIdSicc != '2003'

	-- PASO 3 (validar si hay cuvs personalizados)
	DECLARE @cantOfertas INT = 0
		,@codConsultoraGenerica VARCHAR(30) = ''

	SELECT @cantOfertas = COUNT(1)
	FROM @TablaCross
	WHERE CodConsultora != @codConsultoraForzadas

	IF ISNULL(@cantOfertas, 0) = 0
	BEGIN
		SELECT @codConsultoraGenerica = Codigo
		FROM TablaLogicaDatos
		WHERE TablaLogicaDatosID = 10001

		IF ISNULL(@codConsultoraGenerica, '') != ''
		BEGIN
			INSERT INTO @TablaCross
			SELECT pc.CampaniaID
				,pc.CUV
				,pc.CodigoProducto
				,pc.PrecioCatalogo
				,op.CodVinculo
				,op.PPU
				,op.Orden
				,1
				,0
				,''
				,0
				,''
				,''
				,pc.MarcaID
				,pc.AnoCampania
				,0
				,op.CodConsultora
			FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
			INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON op.AnioCampanaVenta = pc.AnoCampania
				AND op.CUV = pc.CUV
				AND op.CodConsultora = @codConsultoraGenerica
				AND op.TipoPersonalizacion = 'OF'
			WHERE op.AnioCampanaVenta = @CampaniaID
				AND pc.IndicadorDigitable = 1
				AND pc.EstrategiaIdSicc != '2003'
		END
	END

	-- PASO 4 (validar datos de las ofertas)
	UPDATE a
	SET a.EstaEnPedido = 1
		,a.CUVPedido = b.CUV
	FROM @TablaCross a
	INNER JOIN @TablaCuvPedido b ON a.CodigoSap = b.CodigoSap

	UPDATE a
	SET a.CUVPedido = b.CUVPedido
	FROM @TablaCross a
	INNER JOIN (
		SELECT CodVinculo
			,CUVPedido
		FROM @TablaCross
		WHERE EstaEnPedido = 1
		) b ON a.CodVinculo = b.CodVinculo
	WHERE a.EstaEnPedido = 0

	UPDATE a
	SET a.EsCross = 0
	FROM @TablaCross a
	INNER JOIN (
		SELECT CodVinculo
		FROM @TablaCross
		WHERE EstaEnPedido = 0
		GROUP BY CodVinculo
		HAVING COUNT(CUV) > 1
		) b ON a.CodVinculo = b.CodVinculo
	WHERE a.EstaEnPedido = 0

	UPDATE a
	SET a.PrecioOk = 1
	FROM @TablaCross a
	INNER JOIN (
		SELECT CUV
		FROM @TablaCross
		WHERE PrecioCatalogo <= PPU
		) b ON a.CUV = b.CUV
	WHERE a.EstaEnPedido = 0

	-- PASO 5 (validar GAP)
	DECLARE @GAP DECIMAL(15, 2)
		,@TipoMeta CHAR(2)

	IF (@TipoProductoMostrar = 1)
	BEGIN
		DECLARE @MontoHasta NUMERIC(15, 2)

		SELECT TOP 1 @MontoHasta = MontoHasta
			,@TipoMeta = PorDescuento
		FROM dbo.Fn_GetEscalaDescuentoZona(@CampaniaID,@CodigoRegion,@CodigoZona)
		WHERE MontoHasta >= ISNULL(@MontoEscala, 0)

		IF (@MontoHasta > @MontoMinPedido)
		BEGIN
			SELECT TOP 1 @TipoMeta = PorDescuento
			FROM dbo.Fn_GetEscalaDescuentoZona(@CampaniaID,@CodigoRegion,@CodigoZona)
			WHERE PorDescuento > @TipoMeta
		END

		SET @GAP = (@MontoHasta - @MontoTotal)
	END
	ELSE
	BEGIN
		IF (@MontoTotal > @MontoMinPedido)
			IF @MontoEscala > @MontoMinPedido
				SET @GAP = 0
			ELSE
				SET @GAP = (@MontoMinPedido - @MontoEscala)
		ELSE
			SET @GAP = (@MontoMinPedido - @MontoTotal)
	END

	--5.1 (actualizar TipoMeta)
	UPDATE a
	SET a.TipoMeta = (
			CASE 
				WHEN @TipoProductoMostrar = 1
					THEN @TipoMeta
				ELSE 'MM'
				END
			)
		,a.OrdenMeta = (
			CASE 
				WHEN @TipoProductoMostrar = 1
					THEN 2
				ELSE 1
				END
			)
	FROM @TablaCross a
	INNER JOIN (
		SELECT CUV
		FROM @TablaCross
		WHERE PrecioCatalogo >= @GAP
		) b ON a.CUV = b.CUV
	WHERE a.EstaEnPedido = 0

	--5.2 (actualizar GM)
	UPDATE a
	SET a.TipoMeta = 'GM'
		,a.OrdenMeta = 3
	FROM @TablaCross a
	INNER JOIN (
		SELECT CUV
		FROM @TablaCross
		WHERE PrecioCatalogo < @GAP
		) b ON a.CUV = b.CUV
	WHERE a.EstaEnPedido = 0

	--PASO 6 (validar cuvs faltantes)
	DECLARE @tablaCuvFaltante TABLE (CUV VARCHAR(6))

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
			)

	--  6.1 (eliminar cuv faltantes)
	DELETE
	FROM @TablaCross
	WHERE CUV IN (
			SELECT CUV
			FROM @tablaCuvFaltante
			)
		AND EstaEnPedido = 0

	-- PASO 7 (obtener ofertas productos)
	DECLARE @OfertaProductoTemp TABLE (
		CampaniaID INT
		,CUV VARCHAR(6)
		,ConfiguracionOfertaID INT
		,TipoOfertaSisID INT
		)

	INSERT INTO @OfertaProductoTemp
	SELECT op.CampaniaID
		,op.CUV
		,op.ConfiguracionOfertaID
		,op.TipoOfertaSisID
	FROM OfertaProducto op WITH (NOLOCK)
	INNER JOIN @TablaCross tc ON op.CampaniaID = tc.CodCampania
		AND op.CUV = tc.CUV
	WHERE tc.EstaEnPedido = 0

	-- PASO 8 (actualizar CUV2 desde ProductoComercial)
	UPDATE tc
	SET tc.CUV2 = pc.CUV
	FROM @TablaCross tc
	INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON tc.CampaniaID = pc.CampaniaID
		AND tc.CodigoSap = pc.CodigoProducto
		AND pc.IndicadorDigitable = 1
	WHERE tc.EstaEnPedido = 0

	-- PASO 9 (filtrar resultados)
	SELECT DISTINCT p.CUV
		,p.Descripcion AS Descripcion
		,(p.PrecioUnitario * p.FactorRepeticion) AS PrecioCatalogo
		,p.PrecioValorizado
		,p.MarcaID AS IdMarca
		,p.PaisID
		,p.AnoCampania AS CampaniaID
		,p.CodigoCatalago
		,p.CodigoProducto AS CodigoSap
		,p.IndicadorMontoMinimo
		,p.IndicadorOferta
		,0 AS EstaEnRevista
		,ISNULL(pcc.EsExpoOferta, 0) AS EsExpoOferta
		,ISNULL(pcc.CUVRevista, '') AS CUVRevista
		,m.Descripcion AS NombreMarca
		,'NO DISPONIBLE' AS DescripcionCategoria
		,'' AS CUVComplemento
		,'' AS DescripcionEstrategia
		,ISNULL(op.ConfiguracionOfertaID, 0) AS ConfiguracionOfertaID
		,ISNULL(op.TipoOfertaSisID, 0) AS TipoOfertaSisID
		,0 AS FlagNueva
		,0 AS TipoEstrategiaID
		,0 AS TieneSugerido
		,CASE 
			WHEN pl.CodigoSAP IS NULL
				THEN 0
			ELSE 1
			END AS TieneLanzamientoCatalogoPersonalizado
		,CASE 
			WHEN pcor.SAP IS NULL
				THEN 0
			ELSE 1
			END AS TieneOfertaRevista
		,ISNULL(pcor.Oferta, '') AS TipoOfertaRevista
		,
		--tc.CodigoSap,
		tc.Orden
		,1 AS TipoCross
		,tc.EsCross
		,tc.TipoMeta
		,tc.OrdenMeta
		,@GAP AS MontoMeta
		,tc.CodVinculo
		,tc.CUVPedido
		,tc.CUV2
	FROM @TablaCross tc
	INNER JOIN ods.ProductoComercial p WITH (NOLOCK) ON tc.CampaniaID = p.CampaniaID
		AND tc.CUV = p.CUV
		AND p.IndicadorDigitable = 1
	LEFT JOIN ProductoComercialConfiguracion pcc WITH (NOLOCK) ON p.AnoCampania = pcc.CampaniaID
		AND p.CUV = pcc.CUV
	LEFT JOIN @OfertaProductoTemp op ON op.CampaniaID = p.CampaniaID
		AND op.CUV = p.CUV
	LEFT JOIN ods.ProductosLanzamiento pl WITH (NOLOCK) ON p.CodigoProducto = pl.CodigoSAP
		AND p.AnoCampania = pl.Campania
	LEFT JOIN ProductoComercialOfertaRevista pcor WITH (NOLOCK) ON p.AnoCampania = pcor.Campania
		AND p.CUV = pcor.CUV
	LEFT JOIN Marca M WITH (NOLOCK) ON p.MarcaId = m.MarcaId
	WHERE --p.IndicadorDigitable = 1 
		--AND p.PrecioCatalogo >= ISNULL(@PrecioMinimo,0)
		--AND p.PrecioCatalogo >= ISNULL(@MontoFaltante,0)
		tc.EstaEnPedido = 0
	ORDER BY tc.OrdenMeta ASC
		,tc.EsCross DESC
		,tc.Orden ASC
END
GO




