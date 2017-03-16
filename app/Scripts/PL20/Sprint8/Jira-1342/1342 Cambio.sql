
go

declare @idx int = 100, @idxx int = 0

if not exists (select 1 from dbo.TablaLogica where TablaLogicaID = @idx)
begin
		insert into TablaLogica(TablaLogicaID, Descripcion)
		values(@idx, 'Ofertas para ti por defecto')	
end 

if not exists (select 1 from dbo.TablaLogicaDatos where TablaLogicaDatosID = @idx * 100 + 1)
begin
	insert into TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion)
	values(@idx * 100 + 1, @idx, 'XXXXXXXXX', 'Ofertas para ti por defecto')
end

go
ALTER PROCEDURE [dbo].[GetListaProductoOfertaFinal]
(
	@Table1 dbo.ListaOfertaFinalType READONLY
)
AS

BEGIN

	SET NOCOUNT ON;

	-- PASO 1 (obtener datos iniciales)
	DECLARE  @CampaniaID INT, @CodigoConsultora VARCHAR(30), @TipoProductoMostrar INT,
		@ZonaID INT, @CodigoRegion VARCHAR(8), @CodigoZona VARCHAR(8), 
		@MontoMinPedido NUMERIC(15,2), @MontoTotal MONEY, @MontoEscala MONEY

	SELECT 
		@CampaniaID = CampaniaID,
		@CodigoConsultora = CodigoConsultora,
		@ZonaID = ZonaID, 
		@CodigoRegion = CodigoRegion, 
		@CodigoZona = CodigoZona,
		@MontoMinPedido = MontoMinimo,
		@MontoTotal = MontoTotal, 
		@MontoEscala = MontoEscala 
	FROM @Table1

	IF (@MontoTotal > @MontoMinPedido)
		SET @TipoProductoMostrar = 1
	ELSE
		SET @TipoProductoMostrar = 2

	-- PASO 2 (validar si cumple la parametria)
	DECLARE @CumpleParametria BIT = 0, @MontoFaltante DECIMAL(18,2), @PrecioMinimo DECIMAL(18,2), 
		@TipoMeta CHAR(2)

	IF (@TipoProductoMostrar = 1)	-- ESCALA
	BEGIN
		--PRINT 'ESCALA'
		DECLARE @MontoHasta NUMERIC(15,2)

		SELECT TOP 1 @MontoHasta = MontoHasta,
			@TipoMeta = PorDescuento
		FROM ods.EscalaDescuento 
		WHERE MontoHasta >= ISNULL(@MontoEscala,0)

		--PRINT @MontoHasta

		IF (ISNULL(@MontoHasta,0) > 0)
		BEGIN
				--PRINT 'AA'
				--IF (@MontoHasta > @MontoMinPedido)
				--BEGIN
				--	SELECT TOP 1
				--		@TipoMeta = PorDescuento
				--	FROM ods.EscalaDescuento 
				--	WHERE PorDescuento > @TipoMeta
				--END

				--PRINT @TipoMeta

				SET @MontoHasta = CEILING(@MontoHasta)
				SET @MontoFaltante = (@MontoHasta - @MontoEscala)

				--PRINT @MontoFaltante

				IF (@MontoFaltante > 0)
				BEGIN
					--PRINT 'BB'
					SELECT TOP 1 @PrecioMinimo = PrecioMinimo,
						@CumpleParametria = 1
					FROM OfertaFinalParametria 
					WHERE Tipo = 'E' + @TipoMeta
					AND GapMinimo <= @MontoFaltante AND GapMaximo >= @MontoFaltante
				END

				IF (@MontoHasta > @MontoMinPedido)
				BEGIN
					SELECT TOP 1
						@TipoMeta = PorDescuento
					FROM ods.EscalaDescuento 
					WHERE PorDescuento > @TipoMeta
				END

				--PRINT @CumpleParametria

				IF (ISNULL(@CumpleParametria,0) = 0)
				BEGIN
					--PRINT 'CC'
					SELECT TOP 1 @PrecioMinimo = PrecioMinimo,
						@CumpleParametria = 1
					FROM OfertaFinalParametria 
					WHERE Tipo = 'GM'

					SET @TipoMeta = 'GM'

					--PRINT @PrecioMinimo
					--PRINT @TipoMeta

					--IF (ISNULL(@CumpleParametria,0) = 1)
					--	SET @TipoMeta = 'GM'

					--PRINT @TipoMeta
				END

		END

		--PRINT 'Escala'
		--PRINT @MontoHasta
		--PRINT @MontoFaltante
		--PRINT @PrecioMinimo
		--PRINT @TipoMeta

	END
	ELSE	-- MONTO MIN

	BEGIN
		--PRINT 'MM'
		SET @MontoFaltante = (@MontoMinPedido - @MontoTotal)

		IF (@MontoFaltante > 0)
		BEGIN
			SELECT TOP 1 @PrecioMinimo = PrecioMinimo,
				@CumpleParametria = 1
			FROM OfertaFinalParametria 
			WHERE Tipo = 'MM'
			AND GapMinimo <= @MontoFaltante AND GapMaximo >= @MontoFaltante

			SET @TipoMeta = 'MM'

			--IF (ISNULL(@CumpleParametria,0) = 0)
			--	SET @TipoMeta = 'MM'
		END

		--PRINT 'Monto min'
		--PRINT @MontoFaltante
		--PRINT @PrecioMinimo
	END

	IF (@CumpleParametria = 1)
	BEGIN

		--PRINT 'DD'
		-- PASO 3 (obtener datos OF)
		DECLARE @tablaCuvFaltante TABLE (CUV VARCHAR(6))

		-- 3.1
		INSERT INTO @tablaCuvFaltante
		SELECT DISTINCT LTRIM(RTRIM(CUV))
		FROM dbo.ProductoFaltante WITH(NOLOCK)
		WHERE CampaniaID = @CampaniaID AND ZonaID = @ZonaID
		UNION ALL
		SELECT DISTINCT LTRIM(RTRIM(fa.CodigoVenta))
		from ods.FaltanteAnunciado fa  WITH(NOLOCK)
		INNER JOIN ods.Campania c  WITH(NOLOCK) ON fa.CampaniaID = c.CampaniaID
		WHERE c.Codigo = @CampaniaID
			AND (RTRIM(fa.CodigoRegion) = @CodigoRegion OR fa.CodigoRegion IS NULL)
			AND (RTRIM(fa.CodigoZona) = @CodigoZona OR fa.CodigoZona IS NULL)

		-- 3.2
		DECLARE @tablaCuvPedido TABLE (
			CUV VARCHAR(6),
			CodigoSap VARCHAR(30)
		)

		INSERT INTO @tablaCuvPedido
		SELECT pc.CUV, pc.CodigoProducto
		FROM PedidoWebDetalle pd WITH(NOLOCK)
			INNER JOIN ods.ProductoComercial pc WITH(NOLOCK) ON pd.CampaniaID = pc.AnoCampania
				AND pd.CUV = pc.CUV
				AND pc.IndicadorDigitable = 1
				AND pc.CodigoCatalago IN (9,10,13, 24)
			INNER JOIN ods.Consultora c WITH(NOLOCK) ON pd.ConsultoraID = c.ConsultoraID
		WHERE pd.CampaniaID = @CampaniaID 
		AND c.Codigo = @CodigoConsultora

		-- 3.3
		DECLARE @tablaCodigosCuv TABLE 
		(
			CUV VARCHAR(6), 
			CodigoSap VARCHAR(12), 
			CampaniaID INT,
			Orden INT
		)

		INSERT INTO @tablaCodigosCuv
		SELECT 
			pc.CUV, 
			pc.CodigoProducto, 
			pc.CampaniaID,
			op.Orden
		FROM ods.ProductoComercial pc WITH(NOLOCK)
		INNER JOIN ods.ofertaspersonalizadas op WITH(NOLOCK) ON pc.CUV = op.CUV 
			AND pc.AnoCampania = op.AnioCampanaVenta 
			AND op.CodConsultora = @CodigoConsultora
			AND op.TipoPersonalizacion = 'OF'
		WHERE pc.AnoCampania = @CampaniaID
			AND pc.CUV NOT IN ( SELECT CUV FROM @tablaCuvFaltante )
			--AND pc.CUV NOT IN (	SELECT CUV FROM @tablaCuvPedido )
			AND pc.CodigoProducto NOT IN ( SELECT CodigoSap FROM @tablaCuvPedido )
		
		-- en caso no hay registro de la consultora
		-- poner la consultora XXX XXX XXX
		declare @cantXXX int = 0, @codigoXXX varchar(30) = ''
		select @cantXXX = COUNT(1) from @tablaCodigosCuv
		set @cantXXX = isnull(@cantXXX, 0)

		if	@cantXXX = 0
		begin
			
			select @codigoXXX = Codigo
			from TablaLogicaDatos where TablaLogicaDatosID = 10001
			
			set @codigoXXX = ISNULL(@codigoXXX, '')

			if @codigoXXX <> ''
			begin

					INSERT INTO @tablaCodigosCuv
					SELECT 
						pc.CUV, 
						pc.CodigoProducto, 
						pc.CampaniaID,
						op.Orden
					FROM ods.ProductoComercial pc WITH(NOLOCK)
					INNER JOIN ods.ofertaspersonalizadas op WITH(NOLOCK) ON pc.CUV = op.CUV 
						AND pc.AnoCampania = op.AnioCampanaVenta 
						AND op.CodConsultora = @codigoXXX
						AND op.TipoPersonalizacion = 'OF'
					WHERE pc.AnoCampania = @CampaniaID
						AND pc.CUV NOT IN ( SELECT CUV FROM @tablaCuvFaltante )
						--AND pc.CUV NOT IN (	SELECT CUV FROM @tablaCuvPedido )
						AND pc.CodigoProducto NOT IN ( SELECT CodigoSap FROM @tablaCuvPedido )

			end

		end
		-- FIN XXX XXX XXX

		-- PASO 4 (oferta productos)
		DECLARE @OfertaProductoTemp TABLE
		(
			CampaniaID INT,
			CUV VARCHAR(6),
			ConfiguracionOfertaID INT,
			TipoOfertaSisID INT
		)

		INSERT INTO @OfertaProductoTemp
		SELECT op.CampaniaID, 
			op.CUV, 
			op.ConfiguracionOfertaID, 
			op.TipoOfertaSisID
		FROM OfertaProducto op WITH(NOLOCK)
		INNER JOIN @tablaCodigosCuv tc ON op.CampaniaID = tc.CampaniaID and op.CUV = tc.CUV

		--PRINT @TipoMeta
		--PRINT @PrecioMinimo
		--PRINT @MontoFaltante
		
		IF (@TipoMeta = 'GM')
		BEGIN
			SET @MontoFaltante = 0
		END

		-- PASO 5 (completar datos)
		SELECT DISTINCT
			p.CUV,
			p.Descripcion AS Descripcion,
			(p.PrecioUnitario * p.FactorRepeticion) AS PrecioCatalogo,
			p.MarcaId AS IdMarca,
			p.PrecioValorizado,
			p.PaisID,
			p.AnoCampania AS CampaniaID,
			p.CodigoCatalago,
			p.CodigoProducto AS CodigoSap,
			p.IndicadorMontoMinimo,
			p.IndicadorOferta,
			0 AS EstaEnRevista,
			ISNULL(pcc.EsExpoOferta,0) AS EsExpoOferta,
			ISNULL(pcc.CUVRevista,'') AS CUVRevista,
			m.Descripcion AS NombreMarca, 
			'NO DISPONIBLE' AS DescripcionCategoria, 
			'' AS CUVComplemento,
			'' AS DescripcionEstrategia, 
			ISNULL(op.ConfiguracionOfertaID,0) AS ConfiguracionOfertaID,
			ISNULL(op.TipoOfertaSisID,0) AS TipoOfertaSisID,
			0 AS FlagNueva, 
			0 AS TipoEstrategiaID, 
			0 AS TieneSugerido,
			CASE WHEN pl.CodigoSAP IS NULL THEN 0 ELSE 1 END AS TieneLanzamientoCatalogoPersonalizado,		
			CASE WHEN pcor.SAP IS NULL THEN 0 ELSE 1 END AS TieneOfertaRevista,		
			ISNULL(pcor.Oferta,'') AS TipoOfertaRevista,
			--tc.CodigoSap,
			tc.Orden,
			@TipoMeta AS TipoMeta,
			@MontoFaltante AS MontoMeta
		FROM @tablaCodigosCuv tc  
		INNER JOIN ods.ProductoComercial p WITH(NOLOCK) ON tc.CampaniaID = p.CampaniaID AND tc.CUV = p.CUV
		LEFT JOIN ProductoComercialConfiguracion pcc WITH(NOLOCK) ON p.AnoCampania = pcc.CampaniaID AND p.CUV = pcc.CUV
		LEFT JOIN @OfertaProductoTemp op ON op.CampaniaID = p.CampaniaID AND op.CUV = p.CUV
		LEFT JOIN ods.ProductosLanzamiento pl WITH(NOLOCK) ON p.CodigoProducto = pl.CodigoSAP AND p.AnoCampania = pl.Campania
		LEFT JOIN ProductoComercialOfertaRevista pcor WITH(NOLOCK) ON p.AnoCampania = pcor.Campania AND p.CUV = pcor.CUV
		LEFT JOIN Marca M WITH(NOLOCK) ON p.MarcaId = m.MarcaId
		WHERE  
			p.IndicadorDigitable = 1 
			AND (p.PrecioCatalogo >= ISNULL(@PrecioMinimo,0)) AND PrecioCatalogo >= ISNULL(@MontoFaltante,0)
		ORDER BY tc.Orden

	END
END


GO
ALTER PROCEDURE [dbo].[GetListaProductoCrossSelling]
(
	@Table1 dbo.ListaOfertaFinalType READONLY
)
AS

BEGIN

	SET NOCOUNT ON;

	-- PASO 1 (obtener datos iniciales)
	DECLARE  @CampaniaID INT, @CodigoConsultora VARCHAR(30), @TipoProductoMostrar INT,
		@ZonaID INT, @CodigoRegion VARCHAR(8), @CodigoZona VARCHAR(8), 
		@MontoMinPedido NUMERIC(15,2), @MontoTotal MONEY, @MontoEscala MONEY

	SELECT 
		@CampaniaID = CampaniaID,
		@CodigoConsultora = CodigoConsultora,
		@ZonaID = ZonaID, 
		@CodigoRegion = CodigoRegion, 
		@CodigoZona = CodigoZona,
		@MontoMinPedido = MontoMinimo,
		@MontoTotal = MontoTotal, 
		@MontoEscala = MontoEscala 
	FROM @Table1

	IF (@MontoTotal > @MontoMinPedido)
		SET @TipoProductoMostrar = 1
	ELSE
		SET @TipoProductoMostrar = 2

	DECLARE @tablaCuvPedido TABLE (
		CUV VARCHAR(9),
		CodigoSap VARCHAR(30)
	)


	-- PASO 2 (obtener lista cuv pedido)
	INSERT INTO @tablaCuvPedido
	SELECT pc.CUV, pc.CodigoProducto
	FROM PedidoWebDetalle pd WITH(NOLOCK)
	INNER JOIN ods.ProductoComercial pc WITH(NOLOCK) ON pd.CampaniaID = pc.AnoCampania
		AND pd.CUV = pc.CUV
		AND pc.IndicadorDigitable = 1
		AND pc.CodigoCatalago IN (9,10,13, 24)
	INNER JOIN ods.Consultora c WITH(NOLOCK) ON pd.ConsultoraID = c.ConsultoraID
	WHERE pd.CampaniaID = @CampaniaID AND c.Codigo = @CodigoConsultora

	--SELECT * FROM @tablaCuvPedido


	-- PASO 3 (excluir lista OF con lista cuv pedido)
	DECLARE @TablaCross TABLE (
		CampaniaID INT,
		CUV VARCHAR(6),
		CodigoSap VARCHAR(30),
		PrecioCatalogo DECIMAL(15,2),
		CodVinculo INT,	
		PPU DECIMAL(15,2),
		Orden INT,
		EsCross BIT,
		PrecioOk BIT,
		TipoMeta CHAR(2),
		CUVPedido VARCHAR(6),
		CUV2 VARCHAR(6),
		MarcaID INT,
		CodCampania INT,
		EstaEnPedido BIT
	)

	INSERT INTO @TablaCross
	SELECT pc.CampaniaID, pc.CUV, pc.CodigoProducto,
	pc.PrecioCatalogo, op.CodVinculo, op.PPU,
	op.Orden, 1, 0, 
	'','','',
	pc.MarcaID, pc.AnoCampania, 0
	FROM ods.OfertasPersonalizadas op WITH(NOLOCK)
	INNER JOIN ods.ProductoComercial pc WITH(NOLOCK) 
		ON op.AnioCampanaVenta = pc.AnoCampania 
		AND op.CUV = pc.CUV
		AND pc.IndicadorDigitable = 1
	WHERE op.AnioCampanaVenta = @CampaniaID 
	AND op.TipoPersonalizacion = 'OF'
	AND op.CodConsultora = @CodigoConsultora
	--AND pc.CodigoProducto NOT IN (
	--	SELECT CodigoSap FROM @TablaCuvPedido
	--)

	--SELECT * FROM @TablaCross

	
		-- en caso no hay registro de la consultora
		-- poner la consultora XXX XXX XXX
		declare @cantXXX int = 0, @codigoXXX varchar(30) = ''
		select @cantXXX = COUNT(1) from @TablaCross
		set @cantXXX = isnull(@cantXXX, 0)

		if	@cantXXX = 0
		begin
			
			select @codigoXXX = Codigo
			from TablaLogicaDatos where TablaLogicaDatosID = 10001
			
			set @codigoXXX = ISNULL(@codigoXXX, '')

			if @codigoXXX <> ''
			begin
						INSERT INTO @TablaCross
						SELECT pc.CampaniaID, pc.CUV, pc.CodigoProducto,
						pc.PrecioCatalogo, op.CodVinculo, op.PPU,
						op.Orden, 1, 0, 
						'','','',
						pc.MarcaID, pc.AnoCampania, 0
						FROM ods.OfertasPersonalizadas op WITH(NOLOCK)
						INNER JOIN ods.ProductoComercial pc WITH(NOLOCK) 
							ON op.AnioCampanaVenta = pc.AnoCampania 
							AND op.CUV = pc.CUV
							AND pc.IndicadorDigitable = 1
						WHERE op.AnioCampanaVenta = @CampaniaID 
						AND op.TipoPersonalizacion = 'OF'
						AND op.CodConsultora = @codigoXXX
			end

		end
		-- FIN XXX XXX XXX

	-- 3.1
	UPDATE a SET a.EstaEnPedido = 1, a.CUVPedido = b.CUV
	FROM @TablaCross a
	INNER JOIN @TablaCuvPedido b ON --a.CUV = b.CUV OR 
		a.CodigoSap = b.CodigoSap

	-- 3.2
	UPDATE a SET a.CUVPedido = b.CUVPedido
	FROM @TablaCross a
	INNER JOIN (
		SELECT CodVinculo, CUVPedido FROM @TablaCross WHERE EstaEnPedido = 1
	) b ON a.CodVinculo = b.CodVinculo
	WHERE a.EstaEnPedido = 0

	--SELECT * FROM @TablaCross

	
	-- PASO 4 (validar si es cross o no cross)
	UPDATE a SET a.EsCross = 0
	FROM @TablaCross a
	INNER JOIN (
		SELECT CodVinculo FROM @TablaCross WHERE EstaEnPedido = 0
		GROUP BY CodVinculo HAVING COUNT(CUV) > 1
	) b ON a.CodVinculo = b.CodVinculo
	WHERE a.EstaEnPedido = 0

	--SELECT * FROM @TablaCross
	
	UPDATE a SET a.PrecioOk = 1
	FROM @TablaCross a
	INNER JOIN (
		SELECT CUV FROM @TablaCross 
		WHERE PrecioCatalogo <= PPU
	) b ON a.CUV = b.CUV
	WHERE a.EstaEnPedido = 0

	--DELETE FROM @TablaCross WHERE PrecioOK = 0

	--SELECT * FROM @TablaCross


	-- PASO 5 (validar GAP)
	DECLARE @GAP DECIMAL(15,2), @TipoMeta CHAR(2)

	IF (@TipoProductoMostrar = 1)	-- Escala
	BEGIN
		DECLARE @MontoHasta NUMERIC(15,2)
		--SET @GAP = (@MontoEscala - @MontoTotal)

		SELECT TOP 1 @MontoHasta = MontoHasta,
			@TipoMeta = PorDescuento
		FROM ods.EscalaDescuento 
		WHERE MontoHasta >= ISNULL(@MontoEscala,0)

		IF (@MontoHasta > @MontoMinPedido)
		BEGIN
			SELECT TOP 1
				@TipoMeta = PorDescuento
			FROM ods.EscalaDescuento 
			WHERE PorDescuento > @TipoMeta
		END

		SET @GAP = (@MontoHasta - @MontoTotal)
	
END
	ELSE
	BEGIN
		SET @GAP = (@MontoMinPedido - @MontoTotal)
	END

	--PRINT @MontoMinPedido
	--PRINT @MontoTotal
	--PRINT @GAP

	UPDATE a SET a.TipoMeta = CASE WHEN @TipoProductoMostrar = 1 THEN @TipoMeta ELSE 'MM' END
	FROM @TablaCross a
	INNER JOIN (
	
	SELECT CUV FROM @TablaCross 
		WHERE PrecioCatalogo >= @GAP
	) b ON a.CUV = b.CUV
	WHERE a.EstaEnPedido = 0

	UPDATE a SET a.TipoMeta = 'GM' 
	FROM @TablaCross a
	INNER JOIN (
		SELECT CUV FROM @TablaCross 
		WHERE PrecioCatalogo < @GAP
	) b ON a.CUV = b.CUV
	WHERE a.EstaEnPedido = 0

	--SELECT * FROM @TablaCross


	--PASO 6 (validar fantantes)
	DECLARE @tablaCuvFaltante TABLE (CUV VARCHAR(6))

	INSERT INTO @tablaCuvFaltante
	SELECT DISTINCT LTRIM(RTRIM(CUV))
	FROM dbo.ProductoFaltante WITH(NOLOCK)
	WHERE CampaniaID = @CampaniaID AND ZonaID = @ZonaID

	UNION ALL

	SELECT DISTINCT LTRIM(RTRIM(fa.CodigoVenta))
	from ods.FaltanteAnunciado fa  WITH(NOLOCK)
	INNER JOIN ods.Campania c  WITH(NOLOCK) ON fa.CampaniaID = c.CampaniaID
	WHERE c.Codigo = @CampaniaID

		AND (RTRIM(fa.CodigoRegion) = @CodigoRegion OR fa.CodigoRegion IS NULL)
		AND (RTRIM(fa.CodigoZona) = @CodigoZona OR fa.CodigoZona IS NULL)

	--  6.1 (eliminar cuv faltantes)
	DELETE FROM @TablaCross WHERE CUV IN (SELECT CUV FROM @tablaCuvFaltante) AND EstaEnPedido = 0

	--SELECT * FROM @TablaCross


	-- PASO 7 (oferta productos)
	DECLARE @OfertaProductoTemp TABLE
	(
		CampaniaID INT,
		CUV VARCHAR(6),
		ConfiguracionOfertaID INT,
		TipoOfertaSisID INT
	)

	INSERT INTO @OfertaProductoTemp
	SELECT op.CampaniaID, 
		op.CUV, 
		op.ConfiguracionOfertaID, 
		op.TipoOfertaSisID
	FROM OfertaProducto op WITH(NOLOCK)
	INNER JOIN @TablaCross tc ON op.CampaniaID = tc.CodCampania and op.CUV = tc.CUV
	WHERE tc.EstaEnPedido = 0

	
	-- PASO 8 (actualizar cuv2 app catalogo)
	UPDATE tc SET tc.CUV2 = pc.CUV
	FROM @TablaCross tc
	INNER JOIN ods.ProductoComercial pc WITH(NOLOCK) ON tc.CampaniaID = pc.CampaniaID AND tc.CodigoSap = pc.CodigoProducto 
		AND pc.CodigoCatalago = (
			CASE tc.MarcaID 
			WHEN 1 THEN 9 
			WHEN 2 THEN 13 
			WHEN 3 THEN 10 
			ELSE 0 END) 
		AND pc.IndicadorDigitable = 1
	WHERE tc.EstaEnPedido = 0

	--SELECT * FROM @TablaCross


	-- PASO 9 (completar datos)
	SELECT DISTINCT
		p.CUV,
		p.Descripcion AS Descripcion,
		(p.PrecioUnitario * p.FactorRepeticion) AS PrecioCatalogo,
		p.PrecioValorizado,
		p.MarcaID AS IdMarca,
		p.PaisID,
		p.AnoCampania AS CampaniaID,
		p.CodigoCatalago,
		p.CodigoProducto AS CodigoSap,
		p.IndicadorMontoMinimo,
		p.IndicadorOferta,
		0 AS EstaEnRevista,
		ISNULL(pcc.EsExpoOferta,0) AS EsExpoOferta,
		ISNULL(pcc.CUVRevista,'') AS CUVRevista,
		m.Descripcion AS NombreMarca, 
		'NO DISPONIBLE' AS DescripcionCategoria, 
		'' AS CUVComplemento,
		'' AS DescripcionEstrategia, 
		ISNULL(op.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		ISNULL(op.TipoOfertaSisID,0) AS TipoOfertaSisID,
		0 AS FlagNueva, 
		0 AS TipoEstrategiaID, 
		0 AS TieneSugerido,
		CASE WHEN pl.CodigoSAP IS NULL THEN 0 ELSE 1 END AS TieneLanzamientoCatalogoPersonalizado,		
		CASE WHEN pcor.SAP IS NULL THEN 0 ELSE 1 END AS TieneOfertaRevista,		
		ISNULL(pcor.Oferta,'') AS TipoOfertaRevista,
		--tc.CodigoSap,
		tc.Orden,
		1 AS TipoCross,
		tc.EsCross,
		tc.TipoMeta,
		@GAP AS MontoMeta,
		tc.CodVinculo,
		tc.CUVPedido,
		tc.CUV2
	FROM @TablaCross tc  
	INNER JOIN ods.ProductoComercial p WITH(NOLOCK) ON tc.CampaniaID = p.CampaniaID 
		AND tc.CUV = p.CUV 
		AND p.IndicadorDigitable = 1
	LEFT JOIN ProductoComercialConfiguracion pcc WITH(NOLOCK) ON p.AnoCampania = pcc.CampaniaID 
		AND p.CUV = pcc.CUV
	LEFT JOIN @OfertaProductoTemp op ON op.CampaniaID = p.CampaniaID 
		AND op.CUV = p.CUV
	LEFT JOIN ods.ProductosLanzamiento pl WITH(NOLOCK) ON p.CodigoProducto = pl.CodigoSAP 
		AND p.AnoCampania = pl.Campania
	LEFT JOIN ProductoComercialOfertaRevista pcor WITH(NOLOCK) ON p.AnoCampania = pcor.Campania 
		AND p.CUV = pcor.CUV
	LEFT JOIN Marca M WITH(NOLOCK) ON p.MarcaId = m.MarcaId
	WHERE  
		--p.IndicadorDigitable = 1 
		--AND (p.PrecioCatalogo >= ISNULL(@PrecioMinimo,0)) --AND PrecioCatalogo >= ISNULL(@MontoFaltante,0))
		tc.EstaEnPedido = 0
	ORDER BY tc.EsCross DESC, tc.Orden ASC

	
END



