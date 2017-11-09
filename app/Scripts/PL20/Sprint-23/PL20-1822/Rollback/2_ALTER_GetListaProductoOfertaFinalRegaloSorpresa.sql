
USE BelcorpBolivia
GO


ALTER PROCEDURE [dbo].[GetListaProductoOfertaFinalRegaloSorpresa]
(
	@Table1 dbo.ListaOfertaFinalType READONLY
)
AS
BEGIN
	SET NOCOUNT ON;

	-- PASO 1 (obtener datos iniciales)
	DECLARE  @CampaniaID INT, @CodigoConsultora VARCHAR(30), 
		@ZonaID INT, @CodigoRegion VARCHAR(8), @CodigoZona VARCHAR(8), 
		@MontoMinPedido NUMERIC(15,2), @MontoTotal MONEY, @MontoEscala MONEY,
		@Algoritmo varchar(10)

	SELECT 
		@CampaniaID = CampaniaID,
		@CodigoConsultora = CodigoConsultora,
		@ZonaID = ZonaID, 
		@CodigoRegion = CodigoRegion, 
		@CodigoZona = CodigoZona,
		@MontoMinPedido = MontoMinimo,
		@MontoTotal = MontoTotal, 
		@MontoEscala = MontoEscala,
		@Algoritmo = Algoritmo 
	FROM @Table1

	-- PASO 2 (validar si cumple la parametria)
	Declare @CumpleParametria Bit, @MontoFaltante DECIMAL(18,2), @PrecioMinimo DECIMAL(18,2), 
		@TipoMeta CHAR(2), @MontoMeta decimal(18,2)

	Set @CumpleParametria = 0

	IF (@MontoTotal >= @MontoMinPedido)
	Begin		
		Print 'RANGO' 

		if exists(Select 1 From OfertaFinalParametria with (nolock) 
			Where Tipo = 'RG' And @MontoTotal >= GapMinimo And @MontoTotal <= GapMaximo And Algoritmo = @Algoritmo)
		begin
			Set @TipoMeta = 'RG'
			Set @PrecioMinimo = 0
			Set @CumpleParametria = 1

			Declare @ConsultoraId int
			Set @ConsultoraId = (Select ConsultoraId From ods.Consultora with (nolock) Where Codigo = @CodigoConsultora)
			Set @MontoMeta = (Select MontoMeta From OfertaFinalMontoMeta with (nolock) Where CampaniaId = @CampaniaId And ConsultoraId = @ConsultoraId)	

			if (isnull(@MontoMeta,0) = 0)
				Execute InsertarOfertaFinalRegaloSorpresa @CampaniaID,@ConsultoraId,@MontoTotal,@Algoritmo,@MontoMeta output

			if (@MontoTotal >= @MontoMeta and @MontoMeta != 0)
			begin
				Set @TipoMeta = 'GM'
				set @PrecioMinimo = (select top 1 PrecioMinimo From OfertaFinalParametria with (nolock) Where Tipo = 'GM' And Algoritmo = @Algoritmo)
				if (isnull(@PrecioMinimo,0) >= 0)
					Set @CumpleParametria = 1
				else
					Set @CumpleParametria = 0
			End		
		end												
	End
	Else
	Begin
		PRINT 'MM'
		SET @MontoFaltante = (@MontoMinPedido - @MontoTotal)

		IF (@MontoFaltante > 0)
		BEGIN
			SELECT TOP 1 @PrecioMinimo = PrecioMinimo,
				@CumpleParametria = 1
			FROM OfertaFinalParametria 
			WHERE Tipo = 'MM'
			AND GapMinimo <= @MontoFaltante AND GapMaximo >= @MontoFaltante
			AND Algoritmo = @Algoritmo

			SET @TipoMeta = 'MM'
		END
	END

	IF (@CumpleParametria = 1)
	BEGIN
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
		DECLARE @tablaCuvPedido TABLE 
		(
			CUV VARCHAR(6),
			CodigoSap VARCHAR(30)
		)

		INSERT INTO @tablaCuvPedido
		SELECT pc.CUV, pc.CodigoProducto
		FROM PedidoWebDetalle pd WITH(NOLOCK)
			INNER JOIN ods.ProductoComercial pc WITH(NOLOCK) ON pd.CampaniaID = pc.AnoCampania
				AND pd.CUV = pc.CUV
				AND pc.IndicadorDigitable = 1
				--AND pc.CodigoCatalago IN (9,10,13, 24)
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
			AND op.TipoPersonalizacion = 'SR'
		WHERE pc.AnoCampania = @CampaniaID
		AND pc.CUV NOT IN ( SELECT CUV FROM @tablaCuvFaltante )
		AND pc.CodigoProducto NOT IN ( SELECT CodigoSap FROM @tablaCuvPedido )
		
		-- en caso no hay registro de la consultora
		-- poner la consultora XXX XXX XXX
		declare @cantXXX int = 0, @codigoXXX varchar(30) = ''
		select @cantXXX = COUNT(1) from @tablaCodigosCuv
		set @cantXXX = IsNull(@cantXXX, 0)

		if	@cantXXX = 0
		begin
			select @codigoXXX = Codigo
			from TablaLogicaDatos where TablaLogicaDatosID = 10001
			
			set @codigoXXX = IsNull(@codigoXXX, '')

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
					AND op.TipoPersonalizacion = 'SR'
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
		
		IF (@TipoMeta = 'GM')
		BEGIN
			Set @MontoFaltante = 0
		END

		PRINT 'PM: ' + CAST(@PrecioMinimo AS VARCHAR)
		PRINT 'MF: ' + CAST(ISNULL(@MontoFaltante,0) AS VARCHAR)

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
			IsNull(pcc.EsExpoOferta,0) AS EsExpoOferta,
			IsNull(pcc.CUVRevista,'') AS CUVRevista,
			m.Descripcion AS NombreMarca, 
			'NO DISPONIBLE' AS DescripcionCategoria, 
			'' AS CUVComplemento,
			'' AS DescripcionEstrategia, 
			IsNull(op.ConfiguracionOfertaID,0) AS ConfiguracionOfertaID,
			IsNull(op.TipoOfertaSisID,0) AS TipoOfertaSisID,
			0 AS FlagNueva, 
			0 AS TipoEstrategiaID, 
			0 AS TieneSugerido,
			CASE WHEN pl.CodigoSAP IS NULL THEN 0 ELSE 1 END AS TieneLanzamientoCatalogoPersonalizado,		
			CASE WHEN pcor.SAP IS NULL THEN 0 ELSE 1 END AS TieneOfertaRevista,		
			IsNull(pcor.Oferta,'') AS TipoOfertaRevista,
			tc.Orden,
			@TipoMeta AS TipoMeta,
			Case @TipoMeta 
				When 'MM' Then @MontoFaltante 
				When 'RG' Then @MontoMeta 
				When 'GM' Then @MontoMeta
			End As MontoMeta
		FROM @tablaCodigosCuv tc  
		INNER JOIN ods.ProductoComercial p WITH(NOLOCK) ON tc.CampaniaID = p.CampaniaID AND tc.CUV = p.CUV
		LEFT JOIN ProductoComercialConfiguracion pcc WITH(NOLOCK) ON p.AnoCampania = pcc.CampaniaID AND p.CUV = pcc.CUV
		LEFT JOIN @OfertaProductoTemp op ON op.CampaniaID = p.CampaniaID AND op.CUV = p.CUV
		LEFT JOIN ods.ProductosLanzamiento pl WITH(NOLOCK) ON p.CodigoProducto = pl.CodigoSAP AND p.AnoCampania = pl.Campania
		LEFT JOIN ProductoComercialOfertaRevista pcor WITH(NOLOCK) ON p.AnoCampania = pcor.Campania AND p.CUV = pcor.CUV
		LEFT JOIN Marca M WITH(NOLOCK) ON p.MarcaId = m.MarcaId
		Where
			p.IndicadorDigitable = 1
			And (p.PrecioCatalogo >= IsNull(@PrecioMinimo,0)) And PrecioCatalogo >= IsNull(@MontoFaltante,0)
		ORDER BY tc.Orden

	END
END
GO

USE BelcorpChile
GO


ALTER PROCEDURE [dbo].[GetListaProductoOfertaFinalRegaloSorpresa]
(
	@Table1 dbo.ListaOfertaFinalType READONLY
)
AS
BEGIN
	SET NOCOUNT ON;

	-- PASO 1 (obtener datos iniciales)
	DECLARE  @CampaniaID INT, @CodigoConsultora VARCHAR(30), 
		@ZonaID INT, @CodigoRegion VARCHAR(8), @CodigoZona VARCHAR(8), 
		@MontoMinPedido NUMERIC(15,2), @MontoTotal MONEY, @MontoEscala MONEY,
		@Algoritmo varchar(10)

	SELECT 
		@CampaniaID = CampaniaID,
		@CodigoConsultora = CodigoConsultora,
		@ZonaID = ZonaID, 
		@CodigoRegion = CodigoRegion, 
		@CodigoZona = CodigoZona,
		@MontoMinPedido = MontoMinimo,
		@MontoTotal = MontoTotal, 
		@MontoEscala = MontoEscala,
		@Algoritmo = Algoritmo 
	FROM @Table1

	-- PASO 2 (validar si cumple la parametria)
	Declare @CumpleParametria Bit, @MontoFaltante DECIMAL(18,2), @PrecioMinimo DECIMAL(18,2), 
		@TipoMeta CHAR(2), @MontoMeta decimal(18,2)

	Set @CumpleParametria = 0

	IF (@MontoTotal >= @MontoMinPedido)
	Begin		
		Print 'RANGO' 

		if exists(Select 1 From OfertaFinalParametria with (nolock) 
			Where Tipo = 'RG' And @MontoTotal >= GapMinimo And @MontoTotal <= GapMaximo And Algoritmo = @Algoritmo)
		begin
			Set @TipoMeta = 'RG'
			Set @PrecioMinimo = 0
			Set @CumpleParametria = 1

			Declare @ConsultoraId int
			Set @ConsultoraId = (Select ConsultoraId From ods.Consultora with (nolock) Where Codigo = @CodigoConsultora)
			Set @MontoMeta = (Select MontoMeta From OfertaFinalMontoMeta with (nolock) Where CampaniaId = @CampaniaId And ConsultoraId = @ConsultoraId)	

			if (isnull(@MontoMeta,0) = 0)
				Execute InsertarOfertaFinalRegaloSorpresa @CampaniaID,@ConsultoraId,@MontoTotal,@Algoritmo,@MontoMeta output

			if (@MontoTotal >= @MontoMeta and @MontoMeta != 0)
			begin
				Set @TipoMeta = 'GM'
				set @PrecioMinimo = (select top 1 PrecioMinimo From OfertaFinalParametria with (nolock) Where Tipo = 'GM' And Algoritmo = @Algoritmo)
				if (isnull(@PrecioMinimo,0) >= 0)
					Set @CumpleParametria = 1
				else
					Set @CumpleParametria = 0
			End		
		end												
	End
	Else
	Begin
		PRINT 'MM'
		SET @MontoFaltante = (@MontoMinPedido - @MontoTotal)

		IF (@MontoFaltante > 0)
		BEGIN
			SELECT TOP 1 @PrecioMinimo = PrecioMinimo,
				@CumpleParametria = 1
			FROM OfertaFinalParametria 
			WHERE Tipo = 'MM'
			AND GapMinimo <= @MontoFaltante AND GapMaximo >= @MontoFaltante
			AND Algoritmo = @Algoritmo

			SET @TipoMeta = 'MM'
		END
	END

	IF (@CumpleParametria = 1)
	BEGIN
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
		DECLARE @tablaCuvPedido TABLE 
		(
			CUV VARCHAR(6),
			CodigoSap VARCHAR(30)
		)

		INSERT INTO @tablaCuvPedido
		SELECT pc.CUV, pc.CodigoProducto
		FROM PedidoWebDetalle pd WITH(NOLOCK)
			INNER JOIN ods.ProductoComercial pc WITH(NOLOCK) ON pd.CampaniaID = pc.AnoCampania
				AND pd.CUV = pc.CUV
				AND pc.IndicadorDigitable = 1
				--AND pc.CodigoCatalago IN (9,10,13, 24)
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
			AND op.TipoPersonalizacion = 'SR'
		WHERE pc.AnoCampania = @CampaniaID
		AND pc.CUV NOT IN ( SELECT CUV FROM @tablaCuvFaltante )
		AND pc.CodigoProducto NOT IN ( SELECT CodigoSap FROM @tablaCuvPedido )
		
		-- en caso no hay registro de la consultora
		-- poner la consultora XXX XXX XXX
		declare @cantXXX int = 0, @codigoXXX varchar(30) = ''
		select @cantXXX = COUNT(1) from @tablaCodigosCuv
		set @cantXXX = IsNull(@cantXXX, 0)

		if	@cantXXX = 0
		begin
			select @codigoXXX = Codigo
			from TablaLogicaDatos where TablaLogicaDatosID = 10001
			
			set @codigoXXX = IsNull(@codigoXXX, '')

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
					AND op.TipoPersonalizacion = 'SR'
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
		
		IF (@TipoMeta = 'GM')
		BEGIN
			Set @MontoFaltante = 0
		END

		PRINT 'PM: ' + CAST(@PrecioMinimo AS VARCHAR)
		PRINT 'MF: ' + CAST(ISNULL(@MontoFaltante,0) AS VARCHAR)

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
			IsNull(pcc.EsExpoOferta,0) AS EsExpoOferta,
			IsNull(pcc.CUVRevista,'') AS CUVRevista,
			m.Descripcion AS NombreMarca, 
			'NO DISPONIBLE' AS DescripcionCategoria, 
			'' AS CUVComplemento,
			'' AS DescripcionEstrategia, 
			IsNull(op.ConfiguracionOfertaID,0) AS ConfiguracionOfertaID,
			IsNull(op.TipoOfertaSisID,0) AS TipoOfertaSisID,
			0 AS FlagNueva, 
			0 AS TipoEstrategiaID, 
			0 AS TieneSugerido,
			CASE WHEN pl.CodigoSAP IS NULL THEN 0 ELSE 1 END AS TieneLanzamientoCatalogoPersonalizado,		
			CASE WHEN pcor.SAP IS NULL THEN 0 ELSE 1 END AS TieneOfertaRevista,		
			IsNull(pcor.Oferta,'') AS TipoOfertaRevista,
			tc.Orden,
			@TipoMeta AS TipoMeta,
			Case @TipoMeta 
				When 'MM' Then @MontoFaltante 
				When 'RG' Then @MontoMeta 
				When 'GM' Then @MontoMeta
			End As MontoMeta
		FROM @tablaCodigosCuv tc  
		INNER JOIN ods.ProductoComercial p WITH(NOLOCK) ON tc.CampaniaID = p.CampaniaID AND tc.CUV = p.CUV
		LEFT JOIN ProductoComercialConfiguracion pcc WITH(NOLOCK) ON p.AnoCampania = pcc.CampaniaID AND p.CUV = pcc.CUV
		LEFT JOIN @OfertaProductoTemp op ON op.CampaniaID = p.CampaniaID AND op.CUV = p.CUV
		LEFT JOIN ods.ProductosLanzamiento pl WITH(NOLOCK) ON p.CodigoProducto = pl.CodigoSAP AND p.AnoCampania = pl.Campania
		LEFT JOIN ProductoComercialOfertaRevista pcor WITH(NOLOCK) ON p.AnoCampania = pcor.Campania AND p.CUV = pcor.CUV
		LEFT JOIN Marca M WITH(NOLOCK) ON p.MarcaId = m.MarcaId
		Where
			p.IndicadorDigitable = 1
			And (p.PrecioCatalogo >= IsNull(@PrecioMinimo,0)) And PrecioCatalogo >= IsNull(@MontoFaltante,0)
		ORDER BY tc.Orden

	END
END
GO

USE BelcorpColombia
GO


ALTER PROCEDURE [dbo].[GetListaProductoOfertaFinalRegaloSorpresa]
(
	@Table1 dbo.ListaOfertaFinalType READONLY
)
AS
BEGIN
	SET NOCOUNT ON;

	-- PASO 1 (obtener datos iniciales)
	DECLARE  @CampaniaID INT, @CodigoConsultora VARCHAR(30), 
		@ZonaID INT, @CodigoRegion VARCHAR(8), @CodigoZona VARCHAR(8), 
		@MontoMinPedido NUMERIC(15,2), @MontoTotal MONEY, @MontoEscala MONEY,
		@Algoritmo varchar(10)

	SELECT 
		@CampaniaID = CampaniaID,
		@CodigoConsultora = CodigoConsultora,
		@ZonaID = ZonaID, 
		@CodigoRegion = CodigoRegion, 
		@CodigoZona = CodigoZona,
		@MontoMinPedido = MontoMinimo,
		@MontoTotal = MontoTotal, 
		@MontoEscala = MontoEscala,
		@Algoritmo = Algoritmo 
	FROM @Table1

	-- PASO 2 (validar si cumple la parametria)
	Declare @CumpleParametria Bit, @MontoFaltante DECIMAL(18,2), @PrecioMinimo DECIMAL(18,2), 
		@TipoMeta CHAR(2), @MontoMeta decimal(18,2)

	Set @CumpleParametria = 0

	IF (@MontoTotal >= @MontoMinPedido)
	Begin		
		Print 'RANGO' 

		if exists(Select 1 From OfertaFinalParametria with (nolock) 
			Where Tipo = 'RG' And @MontoTotal >= GapMinimo And @MontoTotal <= GapMaximo And Algoritmo = @Algoritmo)
		begin
			Set @TipoMeta = 'RG'
			Set @PrecioMinimo = 0
			Set @CumpleParametria = 1

			Declare @ConsultoraId int
			Set @ConsultoraId = (Select ConsultoraId From ods.Consultora with (nolock) Where Codigo = @CodigoConsultora)
			Set @MontoMeta = (Select MontoMeta From OfertaFinalMontoMeta with (nolock) Where CampaniaId = @CampaniaId And ConsultoraId = @ConsultoraId)	

			if (isnull(@MontoMeta,0) = 0)
				Execute InsertarOfertaFinalRegaloSorpresa @CampaniaID,@ConsultoraId,@MontoTotal,@Algoritmo,@MontoMeta output

			if (@MontoTotal >= @MontoMeta and @MontoMeta != 0)
			begin
				Set @TipoMeta = 'GM'
				set @PrecioMinimo = (select top 1 PrecioMinimo From OfertaFinalParametria with (nolock) Where Tipo = 'GM' And Algoritmo = @Algoritmo)
				if (isnull(@PrecioMinimo,0) >= 0)
					Set @CumpleParametria = 1
				else
					Set @CumpleParametria = 0
			End		
		end												
	End
	Else
	Begin
		PRINT 'MM'
		SET @MontoFaltante = (@MontoMinPedido - @MontoTotal)

		IF (@MontoFaltante > 0)
		BEGIN
			SELECT TOP 1 @PrecioMinimo = PrecioMinimo,
				@CumpleParametria = 1
			FROM OfertaFinalParametria 
			WHERE Tipo = 'MM'
			AND GapMinimo <= @MontoFaltante AND GapMaximo >= @MontoFaltante
			AND Algoritmo = @Algoritmo

			SET @TipoMeta = 'MM'
		END
	END

	IF (@CumpleParametria = 1)
	BEGIN
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
		DECLARE @tablaCuvPedido TABLE 
		(
			CUV VARCHAR(6),
			CodigoSap VARCHAR(30)
		)

		INSERT INTO @tablaCuvPedido
		SELECT pc.CUV, pc.CodigoProducto
		FROM PedidoWebDetalle pd WITH(NOLOCK)
			INNER JOIN ods.ProductoComercial pc WITH(NOLOCK) ON pd.CampaniaID = pc.AnoCampania
				AND pd.CUV = pc.CUV
				AND pc.IndicadorDigitable = 1
				--AND pc.CodigoCatalago IN (9,10,13, 24)
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
			AND op.TipoPersonalizacion = 'SR'
		WHERE pc.AnoCampania = @CampaniaID
		AND pc.CUV NOT IN ( SELECT CUV FROM @tablaCuvFaltante )
		AND pc.CodigoProducto NOT IN ( SELECT CodigoSap FROM @tablaCuvPedido )
		
		-- en caso no hay registro de la consultora
		-- poner la consultora XXX XXX XXX
		declare @cantXXX int = 0, @codigoXXX varchar(30) = ''
		select @cantXXX = COUNT(1) from @tablaCodigosCuv
		set @cantXXX = IsNull(@cantXXX, 0)

		if	@cantXXX = 0
		begin
			select @codigoXXX = Codigo
			from TablaLogicaDatos where TablaLogicaDatosID = 10001
			
			set @codigoXXX = IsNull(@codigoXXX, '')

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
					AND op.TipoPersonalizacion = 'SR'
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
		
		IF (@TipoMeta = 'GM')
		BEGIN
			Set @MontoFaltante = 0
		END

		PRINT 'PM: ' + CAST(@PrecioMinimo AS VARCHAR)
		PRINT 'MF: ' + CAST(ISNULL(@MontoFaltante,0) AS VARCHAR)

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
			IsNull(pcc.EsExpoOferta,0) AS EsExpoOferta,
			IsNull(pcc.CUVRevista,'') AS CUVRevista,
			m.Descripcion AS NombreMarca, 
			'NO DISPONIBLE' AS DescripcionCategoria, 
			'' AS CUVComplemento,
			'' AS DescripcionEstrategia, 
			IsNull(op.ConfiguracionOfertaID,0) AS ConfiguracionOfertaID,
			IsNull(op.TipoOfertaSisID,0) AS TipoOfertaSisID,
			0 AS FlagNueva, 
			0 AS TipoEstrategiaID, 
			0 AS TieneSugerido,
			CASE WHEN pl.CodigoSAP IS NULL THEN 0 ELSE 1 END AS TieneLanzamientoCatalogoPersonalizado,		
			CASE WHEN pcor.SAP IS NULL THEN 0 ELSE 1 END AS TieneOfertaRevista,		
			IsNull(pcor.Oferta,'') AS TipoOfertaRevista,
			tc.Orden,
			@TipoMeta AS TipoMeta,
			Case @TipoMeta 
				When 'MM' Then @MontoFaltante 
				When 'RG' Then @MontoMeta 
				When 'GM' Then @MontoMeta
			End As MontoMeta
		FROM @tablaCodigosCuv tc  
		INNER JOIN ods.ProductoComercial p WITH(NOLOCK) ON tc.CampaniaID = p.CampaniaID AND tc.CUV = p.CUV
		LEFT JOIN ProductoComercialConfiguracion pcc WITH(NOLOCK) ON p.AnoCampania = pcc.CampaniaID AND p.CUV = pcc.CUV
		LEFT JOIN @OfertaProductoTemp op ON op.CampaniaID = p.CampaniaID AND op.CUV = p.CUV
		LEFT JOIN ods.ProductosLanzamiento pl WITH(NOLOCK) ON p.CodigoProducto = pl.CodigoSAP AND p.AnoCampania = pl.Campania
		LEFT JOIN ProductoComercialOfertaRevista pcor WITH(NOLOCK) ON p.AnoCampania = pcor.Campania AND p.CUV = pcor.CUV
		LEFT JOIN Marca M WITH(NOLOCK) ON p.MarcaId = m.MarcaId
		Where
			p.IndicadorDigitable = 1
			And (p.PrecioCatalogo >= IsNull(@PrecioMinimo,0)) And PrecioCatalogo >= IsNull(@MontoFaltante,0)
		ORDER BY tc.Orden

	END
END
GO

USE BelcorpCostaRica
GO


ALTER PROCEDURE [dbo].[GetListaProductoOfertaFinalRegaloSorpresa]
(
	@Table1 dbo.ListaOfertaFinalType READONLY
)
AS
BEGIN
	SET NOCOUNT ON;

	-- PASO 1 (obtener datos iniciales)
	DECLARE  @CampaniaID INT, @CodigoConsultora VARCHAR(30), 
		@ZonaID INT, @CodigoRegion VARCHAR(8), @CodigoZona VARCHAR(8), 
		@MontoMinPedido NUMERIC(15,2), @MontoTotal MONEY, @MontoEscala MONEY,
		@Algoritmo varchar(10)

	SELECT 
		@CampaniaID = CampaniaID,
		@CodigoConsultora = CodigoConsultora,
		@ZonaID = ZonaID, 
		@CodigoRegion = CodigoRegion, 
		@CodigoZona = CodigoZona,
		@MontoMinPedido = MontoMinimo,
		@MontoTotal = MontoTotal, 
		@MontoEscala = MontoEscala,
		@Algoritmo = Algoritmo 
	FROM @Table1

	-- PASO 2 (validar si cumple la parametria)
	Declare @CumpleParametria Bit, @MontoFaltante DECIMAL(18,2), @PrecioMinimo DECIMAL(18,2), 
		@TipoMeta CHAR(2), @MontoMeta decimal(18,2)

	Set @CumpleParametria = 0

	IF (@MontoTotal >= @MontoMinPedido)
	Begin		
		Print 'RANGO' 

		if exists(Select 1 From OfertaFinalParametria with (nolock) 
			Where Tipo = 'RG' And @MontoTotal >= GapMinimo And @MontoTotal <= GapMaximo And Algoritmo = @Algoritmo)
		begin
			Set @TipoMeta = 'RG'
			Set @PrecioMinimo = 0
			Set @CumpleParametria = 1

			Declare @ConsultoraId int
			Set @ConsultoraId = (Select ConsultoraId From ods.Consultora with (nolock) Where Codigo = @CodigoConsultora)
			Set @MontoMeta = (Select MontoMeta From OfertaFinalMontoMeta with (nolock) Where CampaniaId = @CampaniaId And ConsultoraId = @ConsultoraId)	

			if (isnull(@MontoMeta,0) = 0)
				Execute InsertarOfertaFinalRegaloSorpresa @CampaniaID,@ConsultoraId,@MontoTotal,@Algoritmo,@MontoMeta output

			if (@MontoTotal >= @MontoMeta and @MontoMeta != 0)
			begin
				Set @TipoMeta = 'GM'
				set @PrecioMinimo = (select top 1 PrecioMinimo From OfertaFinalParametria with (nolock) Where Tipo = 'GM' And Algoritmo = @Algoritmo)
				if (isnull(@PrecioMinimo,0) >= 0)
					Set @CumpleParametria = 1
				else
					Set @CumpleParametria = 0
			End		
		end												
	End
	Else
	Begin
		PRINT 'MM'
		SET @MontoFaltante = (@MontoMinPedido - @MontoTotal)

		IF (@MontoFaltante > 0)
		BEGIN
			SELECT TOP 1 @PrecioMinimo = PrecioMinimo,
				@CumpleParametria = 1
			FROM OfertaFinalParametria 
			WHERE Tipo = 'MM'
			AND GapMinimo <= @MontoFaltante AND GapMaximo >= @MontoFaltante
			AND Algoritmo = @Algoritmo

			SET @TipoMeta = 'MM'
		END
	END

	IF (@CumpleParametria = 1)
	BEGIN
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
		DECLARE @tablaCuvPedido TABLE 
		(
			CUV VARCHAR(6),
			CodigoSap VARCHAR(30)
		)

		INSERT INTO @tablaCuvPedido
		SELECT pc.CUV, pc.CodigoProducto
		FROM PedidoWebDetalle pd WITH(NOLOCK)
			INNER JOIN ods.ProductoComercial pc WITH(NOLOCK) ON pd.CampaniaID = pc.AnoCampania
				AND pd.CUV = pc.CUV
				AND pc.IndicadorDigitable = 1
				--AND pc.CodigoCatalago IN (9,10,13, 24)
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
			AND op.TipoPersonalizacion = 'SR'
		WHERE pc.AnoCampania = @CampaniaID
		AND pc.CUV NOT IN ( SELECT CUV FROM @tablaCuvFaltante )
		AND pc.CodigoProducto NOT IN ( SELECT CodigoSap FROM @tablaCuvPedido )
		
		-- en caso no hay registro de la consultora
		-- poner la consultora XXX XXX XXX
		declare @cantXXX int = 0, @codigoXXX varchar(30) = ''
		select @cantXXX = COUNT(1) from @tablaCodigosCuv
		set @cantXXX = IsNull(@cantXXX, 0)

		if	@cantXXX = 0
		begin
			select @codigoXXX = Codigo
			from TablaLogicaDatos where TablaLogicaDatosID = 10001
			
			set @codigoXXX = IsNull(@codigoXXX, '')

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
					AND op.TipoPersonalizacion = 'SR'
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
		
		IF (@TipoMeta = 'GM')
		BEGIN
			Set @MontoFaltante = 0
		END

		PRINT 'PM: ' + CAST(@PrecioMinimo AS VARCHAR)
		PRINT 'MF: ' + CAST(ISNULL(@MontoFaltante,0) AS VARCHAR)

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
			IsNull(pcc.EsExpoOferta,0) AS EsExpoOferta,
			IsNull(pcc.CUVRevista,'') AS CUVRevista,
			m.Descripcion AS NombreMarca, 
			'NO DISPONIBLE' AS DescripcionCategoria, 
			'' AS CUVComplemento,
			'' AS DescripcionEstrategia, 
			IsNull(op.ConfiguracionOfertaID,0) AS ConfiguracionOfertaID,
			IsNull(op.TipoOfertaSisID,0) AS TipoOfertaSisID,
			0 AS FlagNueva, 
			0 AS TipoEstrategiaID, 
			0 AS TieneSugerido,
			CASE WHEN pl.CodigoSAP IS NULL THEN 0 ELSE 1 END AS TieneLanzamientoCatalogoPersonalizado,		
			CASE WHEN pcor.SAP IS NULL THEN 0 ELSE 1 END AS TieneOfertaRevista,		
			IsNull(pcor.Oferta,'') AS TipoOfertaRevista,
			tc.Orden,
			@TipoMeta AS TipoMeta,
			Case @TipoMeta 
				When 'MM' Then @MontoFaltante 
				When 'RG' Then @MontoMeta 
				When 'GM' Then @MontoMeta
			End As MontoMeta
		FROM @tablaCodigosCuv tc  
		INNER JOIN ods.ProductoComercial p WITH(NOLOCK) ON tc.CampaniaID = p.CampaniaID AND tc.CUV = p.CUV
		LEFT JOIN ProductoComercialConfiguracion pcc WITH(NOLOCK) ON p.AnoCampania = pcc.CampaniaID AND p.CUV = pcc.CUV
		LEFT JOIN @OfertaProductoTemp op ON op.CampaniaID = p.CampaniaID AND op.CUV = p.CUV
		LEFT JOIN ods.ProductosLanzamiento pl WITH(NOLOCK) ON p.CodigoProducto = pl.CodigoSAP AND p.AnoCampania = pl.Campania
		LEFT JOIN ProductoComercialOfertaRevista pcor WITH(NOLOCK) ON p.AnoCampania = pcor.Campania AND p.CUV = pcor.CUV
		LEFT JOIN Marca M WITH(NOLOCK) ON p.MarcaId = m.MarcaId
		Where
			p.IndicadorDigitable = 1
			And (p.PrecioCatalogo >= IsNull(@PrecioMinimo,0)) And PrecioCatalogo >= IsNull(@MontoFaltante,0)
		ORDER BY tc.Orden

	END
END
GO

USE BelcorpDominicana
GO


ALTER PROCEDURE [dbo].[GetListaProductoOfertaFinalRegaloSorpresa]
(
	@Table1 dbo.ListaOfertaFinalType READONLY
)
AS
BEGIN
	SET NOCOUNT ON;

	-- PASO 1 (obtener datos iniciales)
	DECLARE  @CampaniaID INT, @CodigoConsultora VARCHAR(30), 
		@ZonaID INT, @CodigoRegion VARCHAR(8), @CodigoZona VARCHAR(8), 
		@MontoMinPedido NUMERIC(15,2), @MontoTotal MONEY, @MontoEscala MONEY,
		@Algoritmo varchar(10)

	SELECT 
		@CampaniaID = CampaniaID,
		@CodigoConsultora = CodigoConsultora,
		@ZonaID = ZonaID, 
		@CodigoRegion = CodigoRegion, 
		@CodigoZona = CodigoZona,
		@MontoMinPedido = MontoMinimo,
		@MontoTotal = MontoTotal, 
		@MontoEscala = MontoEscala,
		@Algoritmo = Algoritmo 
	FROM @Table1

	-- PASO 2 (validar si cumple la parametria)
	Declare @CumpleParametria Bit, @MontoFaltante DECIMAL(18,2), @PrecioMinimo DECIMAL(18,2), 
		@TipoMeta CHAR(2), @MontoMeta decimal(18,2)

	Set @CumpleParametria = 0

	IF (@MontoTotal >= @MontoMinPedido)
	Begin		
		Print 'RANGO' 

		if exists(Select 1 From OfertaFinalParametria with (nolock) 
			Where Tipo = 'RG' And @MontoTotal >= GapMinimo And @MontoTotal <= GapMaximo And Algoritmo = @Algoritmo)
		begin
			Set @TipoMeta = 'RG'
			Set @PrecioMinimo = 0
			Set @CumpleParametria = 1

			Declare @ConsultoraId int
			Set @ConsultoraId = (Select ConsultoraId From ods.Consultora with (nolock) Where Codigo = @CodigoConsultora)
			Set @MontoMeta = (Select MontoMeta From OfertaFinalMontoMeta with (nolock) Where CampaniaId = @CampaniaId And ConsultoraId = @ConsultoraId)	

			if (isnull(@MontoMeta,0) = 0)
				Execute InsertarOfertaFinalRegaloSorpresa @CampaniaID,@ConsultoraId,@MontoTotal,@Algoritmo,@MontoMeta output

			if (@MontoTotal >= @MontoMeta and @MontoMeta != 0)
			begin
				Set @TipoMeta = 'GM'
				set @PrecioMinimo = (select top 1 PrecioMinimo From OfertaFinalParametria with (nolock) Where Tipo = 'GM' And Algoritmo = @Algoritmo)
				if (isnull(@PrecioMinimo,0) >= 0)
					Set @CumpleParametria = 1
				else
					Set @CumpleParametria = 0
			End		
		end												
	End
	Else
	Begin
		PRINT 'MM'
		SET @MontoFaltante = (@MontoMinPedido - @MontoTotal)

		IF (@MontoFaltante > 0)
		BEGIN
			SELECT TOP 1 @PrecioMinimo = PrecioMinimo,
				@CumpleParametria = 1
			FROM OfertaFinalParametria 
			WHERE Tipo = 'MM'
			AND GapMinimo <= @MontoFaltante AND GapMaximo >= @MontoFaltante
			AND Algoritmo = @Algoritmo

			SET @TipoMeta = 'MM'
		END
	END

	IF (@CumpleParametria = 1)
	BEGIN
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
		DECLARE @tablaCuvPedido TABLE 
		(
			CUV VARCHAR(6),
			CodigoSap VARCHAR(30)
		)

		INSERT INTO @tablaCuvPedido
		SELECT pc.CUV, pc.CodigoProducto
		FROM PedidoWebDetalle pd WITH(NOLOCK)
			INNER JOIN ods.ProductoComercial pc WITH(NOLOCK) ON pd.CampaniaID = pc.AnoCampania
				AND pd.CUV = pc.CUV
				AND pc.IndicadorDigitable = 1
				--AND pc.CodigoCatalago IN (9,10,13, 24)
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
			AND op.TipoPersonalizacion = 'SR'
		WHERE pc.AnoCampania = @CampaniaID
		AND pc.CUV NOT IN ( SELECT CUV FROM @tablaCuvFaltante )
		AND pc.CodigoProducto NOT IN ( SELECT CodigoSap FROM @tablaCuvPedido )
		
		-- en caso no hay registro de la consultora
		-- poner la consultora XXX XXX XXX
		declare @cantXXX int = 0, @codigoXXX varchar(30) = ''
		select @cantXXX = COUNT(1) from @tablaCodigosCuv
		set @cantXXX = IsNull(@cantXXX, 0)

		if	@cantXXX = 0
		begin
			select @codigoXXX = Codigo
			from TablaLogicaDatos where TablaLogicaDatosID = 10001
			
			set @codigoXXX = IsNull(@codigoXXX, '')

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
					AND op.TipoPersonalizacion = 'SR'
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
		
		IF (@TipoMeta = 'GM')
		BEGIN
			Set @MontoFaltante = 0
		END

		PRINT 'PM: ' + CAST(@PrecioMinimo AS VARCHAR)
		PRINT 'MF: ' + CAST(ISNULL(@MontoFaltante,0) AS VARCHAR)

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
			IsNull(pcc.EsExpoOferta,0) AS EsExpoOferta,
			IsNull(pcc.CUVRevista,'') AS CUVRevista,
			m.Descripcion AS NombreMarca, 
			'NO DISPONIBLE' AS DescripcionCategoria, 
			'' AS CUVComplemento,
			'' AS DescripcionEstrategia, 
			IsNull(op.ConfiguracionOfertaID,0) AS ConfiguracionOfertaID,
			IsNull(op.TipoOfertaSisID,0) AS TipoOfertaSisID,
			0 AS FlagNueva, 
			0 AS TipoEstrategiaID, 
			0 AS TieneSugerido,
			CASE WHEN pl.CodigoSAP IS NULL THEN 0 ELSE 1 END AS TieneLanzamientoCatalogoPersonalizado,		
			CASE WHEN pcor.SAP IS NULL THEN 0 ELSE 1 END AS TieneOfertaRevista,		
			IsNull(pcor.Oferta,'') AS TipoOfertaRevista,
			tc.Orden,
			@TipoMeta AS TipoMeta,
			Case @TipoMeta 
				When 'MM' Then @MontoFaltante 
				When 'RG' Then @MontoMeta 
				When 'GM' Then @MontoMeta
			End As MontoMeta
		FROM @tablaCodigosCuv tc  
		INNER JOIN ods.ProductoComercial p WITH(NOLOCK) ON tc.CampaniaID = p.CampaniaID AND tc.CUV = p.CUV
		LEFT JOIN ProductoComercialConfiguracion pcc WITH(NOLOCK) ON p.AnoCampania = pcc.CampaniaID AND p.CUV = pcc.CUV
		LEFT JOIN @OfertaProductoTemp op ON op.CampaniaID = p.CampaniaID AND op.CUV = p.CUV
		LEFT JOIN ods.ProductosLanzamiento pl WITH(NOLOCK) ON p.CodigoProducto = pl.CodigoSAP AND p.AnoCampania = pl.Campania
		LEFT JOIN ProductoComercialOfertaRevista pcor WITH(NOLOCK) ON p.AnoCampania = pcor.Campania AND p.CUV = pcor.CUV
		LEFT JOIN Marca M WITH(NOLOCK) ON p.MarcaId = m.MarcaId
		Where
			p.IndicadorDigitable = 1
			And (p.PrecioCatalogo >= IsNull(@PrecioMinimo,0)) And PrecioCatalogo >= IsNull(@MontoFaltante,0)
		ORDER BY tc.Orden

	END
END
GO

USE BelcorpEcuador
GO


ALTER PROCEDURE [dbo].[GetListaProductoOfertaFinalRegaloSorpresa]
(
	@Table1 dbo.ListaOfertaFinalType READONLY
)
AS
BEGIN
	SET NOCOUNT ON;

	-- PASO 1 (obtener datos iniciales)
	DECLARE  @CampaniaID INT, @CodigoConsultora VARCHAR(30), 
		@ZonaID INT, @CodigoRegion VARCHAR(8), @CodigoZona VARCHAR(8), 
		@MontoMinPedido NUMERIC(15,2), @MontoTotal MONEY, @MontoEscala MONEY,
		@Algoritmo varchar(10)

	SELECT 
		@CampaniaID = CampaniaID,
		@CodigoConsultora = CodigoConsultora,
		@ZonaID = ZonaID, 
		@CodigoRegion = CodigoRegion, 
		@CodigoZona = CodigoZona,
		@MontoMinPedido = MontoMinimo,
		@MontoTotal = MontoTotal, 
		@MontoEscala = MontoEscala,
		@Algoritmo = Algoritmo 
	FROM @Table1

	-- PASO 2 (validar si cumple la parametria)
	Declare @CumpleParametria Bit, @MontoFaltante DECIMAL(18,2), @PrecioMinimo DECIMAL(18,2), 
		@TipoMeta CHAR(2), @MontoMeta decimal(18,2)

	Set @CumpleParametria = 0

	IF (@MontoTotal >= @MontoMinPedido)
	Begin		
		Print 'RANGO' 

		if exists(Select 1 From OfertaFinalParametria with (nolock) 
			Where Tipo = 'RG' And @MontoTotal >= GapMinimo And @MontoTotal <= GapMaximo And Algoritmo = @Algoritmo)
		begin
			Set @TipoMeta = 'RG'
			Set @PrecioMinimo = 0
			Set @CumpleParametria = 1

			Declare @ConsultoraId int
			Set @ConsultoraId = (Select ConsultoraId From ods.Consultora with (nolock) Where Codigo = @CodigoConsultora)
			Set @MontoMeta = (Select MontoMeta From OfertaFinalMontoMeta with (nolock) Where CampaniaId = @CampaniaId And ConsultoraId = @ConsultoraId)	

			if (isnull(@MontoMeta,0) = 0)
				Execute InsertarOfertaFinalRegaloSorpresa @CampaniaID,@ConsultoraId,@MontoTotal,@Algoritmo,@MontoMeta output

			if (@MontoTotal >= @MontoMeta and @MontoMeta != 0)
			begin
				Set @TipoMeta = 'GM'
				set @PrecioMinimo = (select top 1 PrecioMinimo From OfertaFinalParametria with (nolock) Where Tipo = 'GM' And Algoritmo = @Algoritmo)
				if (isnull(@PrecioMinimo,0) >= 0)
					Set @CumpleParametria = 1
				else
					Set @CumpleParametria = 0
			End		
		end												
	End
	Else
	Begin
		PRINT 'MM'
		SET @MontoFaltante = (@MontoMinPedido - @MontoTotal)

		IF (@MontoFaltante > 0)
		BEGIN
			SELECT TOP 1 @PrecioMinimo = PrecioMinimo,
				@CumpleParametria = 1
			FROM OfertaFinalParametria 
			WHERE Tipo = 'MM'
			AND GapMinimo <= @MontoFaltante AND GapMaximo >= @MontoFaltante
			AND Algoritmo = @Algoritmo

			SET @TipoMeta = 'MM'
		END
	END

	IF (@CumpleParametria = 1)
	BEGIN
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
		DECLARE @tablaCuvPedido TABLE 
		(
			CUV VARCHAR(6),
			CodigoSap VARCHAR(30)
		)

		INSERT INTO @tablaCuvPedido
		SELECT pc.CUV, pc.CodigoProducto
		FROM PedidoWebDetalle pd WITH(NOLOCK)
			INNER JOIN ods.ProductoComercial pc WITH(NOLOCK) ON pd.CampaniaID = pc.AnoCampania
				AND pd.CUV = pc.CUV
				AND pc.IndicadorDigitable = 1
				--AND pc.CodigoCatalago IN (9,10,13, 24)
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
			AND op.TipoPersonalizacion = 'SR'
		WHERE pc.AnoCampania = @CampaniaID
		AND pc.CUV NOT IN ( SELECT CUV FROM @tablaCuvFaltante )
		AND pc.CodigoProducto NOT IN ( SELECT CodigoSap FROM @tablaCuvPedido )
		
		-- en caso no hay registro de la consultora
		-- poner la consultora XXX XXX XXX
		declare @cantXXX int = 0, @codigoXXX varchar(30) = ''
		select @cantXXX = COUNT(1) from @tablaCodigosCuv
		set @cantXXX = IsNull(@cantXXX, 0)

		if	@cantXXX = 0
		begin
			select @codigoXXX = Codigo
			from TablaLogicaDatos where TablaLogicaDatosID = 10001
			
			set @codigoXXX = IsNull(@codigoXXX, '')

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
					AND op.TipoPersonalizacion = 'SR'
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
		
		IF (@TipoMeta = 'GM')
		BEGIN
			Set @MontoFaltante = 0
		END

		PRINT 'PM: ' + CAST(@PrecioMinimo AS VARCHAR)
		PRINT 'MF: ' + CAST(ISNULL(@MontoFaltante,0) AS VARCHAR)

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
			IsNull(pcc.EsExpoOferta,0) AS EsExpoOferta,
			IsNull(pcc.CUVRevista,'') AS CUVRevista,
			m.Descripcion AS NombreMarca, 
			'NO DISPONIBLE' AS DescripcionCategoria, 
			'' AS CUVComplemento,
			'' AS DescripcionEstrategia, 
			IsNull(op.ConfiguracionOfertaID,0) AS ConfiguracionOfertaID,
			IsNull(op.TipoOfertaSisID,0) AS TipoOfertaSisID,
			0 AS FlagNueva, 
			0 AS TipoEstrategiaID, 
			0 AS TieneSugerido,
			CASE WHEN pl.CodigoSAP IS NULL THEN 0 ELSE 1 END AS TieneLanzamientoCatalogoPersonalizado,		
			CASE WHEN pcor.SAP IS NULL THEN 0 ELSE 1 END AS TieneOfertaRevista,		
			IsNull(pcor.Oferta,'') AS TipoOfertaRevista,
			tc.Orden,
			@TipoMeta AS TipoMeta,
			Case @TipoMeta 
				When 'MM' Then @MontoFaltante 
				When 'RG' Then @MontoMeta 
				When 'GM' Then @MontoMeta
			End As MontoMeta
		FROM @tablaCodigosCuv tc  
		INNER JOIN ods.ProductoComercial p WITH(NOLOCK) ON tc.CampaniaID = p.CampaniaID AND tc.CUV = p.CUV
		LEFT JOIN ProductoComercialConfiguracion pcc WITH(NOLOCK) ON p.AnoCampania = pcc.CampaniaID AND p.CUV = pcc.CUV
		LEFT JOIN @OfertaProductoTemp op ON op.CampaniaID = p.CampaniaID AND op.CUV = p.CUV
		LEFT JOIN ods.ProductosLanzamiento pl WITH(NOLOCK) ON p.CodigoProducto = pl.CodigoSAP AND p.AnoCampania = pl.Campania
		LEFT JOIN ProductoComercialOfertaRevista pcor WITH(NOLOCK) ON p.AnoCampania = pcor.Campania AND p.CUV = pcor.CUV
		LEFT JOIN Marca M WITH(NOLOCK) ON p.MarcaId = m.MarcaId
		Where
			p.IndicadorDigitable = 1
			And (p.PrecioCatalogo >= IsNull(@PrecioMinimo,0)) And PrecioCatalogo >= IsNull(@MontoFaltante,0)
		ORDER BY tc.Orden

	END
END
GO

USE BelcorpGuatemala
GO


ALTER PROCEDURE [dbo].[GetListaProductoOfertaFinalRegaloSorpresa]
(
	@Table1 dbo.ListaOfertaFinalType READONLY
)
AS
BEGIN
	SET NOCOUNT ON;

	-- PASO 1 (obtener datos iniciales)
	DECLARE  @CampaniaID INT, @CodigoConsultora VARCHAR(30), 
		@ZonaID INT, @CodigoRegion VARCHAR(8), @CodigoZona VARCHAR(8), 
		@MontoMinPedido NUMERIC(15,2), @MontoTotal MONEY, @MontoEscala MONEY,
		@Algoritmo varchar(10)

	SELECT 
		@CampaniaID = CampaniaID,
		@CodigoConsultora = CodigoConsultora,
		@ZonaID = ZonaID, 
		@CodigoRegion = CodigoRegion, 
		@CodigoZona = CodigoZona,
		@MontoMinPedido = MontoMinimo,
		@MontoTotal = MontoTotal, 
		@MontoEscala = MontoEscala,
		@Algoritmo = Algoritmo 
	FROM @Table1

	-- PASO 2 (validar si cumple la parametria)
	Declare @CumpleParametria Bit, @MontoFaltante DECIMAL(18,2), @PrecioMinimo DECIMAL(18,2), 
		@TipoMeta CHAR(2), @MontoMeta decimal(18,2)

	Set @CumpleParametria = 0

	IF (@MontoTotal >= @MontoMinPedido)
	Begin		
		Print 'RANGO' 

		if exists(Select 1 From OfertaFinalParametria with (nolock) 
			Where Tipo = 'RG' And @MontoTotal >= GapMinimo And @MontoTotal <= GapMaximo And Algoritmo = @Algoritmo)
		begin
			Set @TipoMeta = 'RG'
			Set @PrecioMinimo = 0
			Set @CumpleParametria = 1

			Declare @ConsultoraId int
			Set @ConsultoraId = (Select ConsultoraId From ods.Consultora with (nolock) Where Codigo = @CodigoConsultora)
			Set @MontoMeta = (Select MontoMeta From OfertaFinalMontoMeta with (nolock) Where CampaniaId = @CampaniaId And ConsultoraId = @ConsultoraId)	

			if (isnull(@MontoMeta,0) = 0)
				Execute InsertarOfertaFinalRegaloSorpresa @CampaniaID,@ConsultoraId,@MontoTotal,@Algoritmo,@MontoMeta output

			if (@MontoTotal >= @MontoMeta and @MontoMeta != 0)
			begin
				Set @TipoMeta = 'GM'
				set @PrecioMinimo = (select top 1 PrecioMinimo From OfertaFinalParametria with (nolock) Where Tipo = 'GM' And Algoritmo = @Algoritmo)
				if (isnull(@PrecioMinimo,0) >= 0)
					Set @CumpleParametria = 1
				else
					Set @CumpleParametria = 0
			End		
		end												
	End
	Else
	Begin
		PRINT 'MM'
		SET @MontoFaltante = (@MontoMinPedido - @MontoTotal)

		IF (@MontoFaltante > 0)
		BEGIN
			SELECT TOP 1 @PrecioMinimo = PrecioMinimo,
				@CumpleParametria = 1
			FROM OfertaFinalParametria 
			WHERE Tipo = 'MM'
			AND GapMinimo <= @MontoFaltante AND GapMaximo >= @MontoFaltante
			AND Algoritmo = @Algoritmo

			SET @TipoMeta = 'MM'
		END
	END

	IF (@CumpleParametria = 1)
	BEGIN
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
		DECLARE @tablaCuvPedido TABLE 
		(
			CUV VARCHAR(6),
			CodigoSap VARCHAR(30)
		)

		INSERT INTO @tablaCuvPedido
		SELECT pc.CUV, pc.CodigoProducto
		FROM PedidoWebDetalle pd WITH(NOLOCK)
			INNER JOIN ods.ProductoComercial pc WITH(NOLOCK) ON pd.CampaniaID = pc.AnoCampania
				AND pd.CUV = pc.CUV
				AND pc.IndicadorDigitable = 1
				--AND pc.CodigoCatalago IN (9,10,13, 24)
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
			AND op.TipoPersonalizacion = 'SR'
		WHERE pc.AnoCampania = @CampaniaID
		AND pc.CUV NOT IN ( SELECT CUV FROM @tablaCuvFaltante )
		AND pc.CodigoProducto NOT IN ( SELECT CodigoSap FROM @tablaCuvPedido )
		
		-- en caso no hay registro de la consultora
		-- poner la consultora XXX XXX XXX
		declare @cantXXX int = 0, @codigoXXX varchar(30) = ''
		select @cantXXX = COUNT(1) from @tablaCodigosCuv
		set @cantXXX = IsNull(@cantXXX, 0)

		if	@cantXXX = 0
		begin
			select @codigoXXX = Codigo
			from TablaLogicaDatos where TablaLogicaDatosID = 10001
			
			set @codigoXXX = IsNull(@codigoXXX, '')

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
					AND op.TipoPersonalizacion = 'SR'
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
		
		IF (@TipoMeta = 'GM')
		BEGIN
			Set @MontoFaltante = 0
		END

		PRINT 'PM: ' + CAST(@PrecioMinimo AS VARCHAR)
		PRINT 'MF: ' + CAST(ISNULL(@MontoFaltante,0) AS VARCHAR)

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
			IsNull(pcc.EsExpoOferta,0) AS EsExpoOferta,
			IsNull(pcc.CUVRevista,'') AS CUVRevista,
			m.Descripcion AS NombreMarca, 
			'NO DISPONIBLE' AS DescripcionCategoria, 
			'' AS CUVComplemento,
			'' AS DescripcionEstrategia, 
			IsNull(op.ConfiguracionOfertaID,0) AS ConfiguracionOfertaID,
			IsNull(op.TipoOfertaSisID,0) AS TipoOfertaSisID,
			0 AS FlagNueva, 
			0 AS TipoEstrategiaID, 
			0 AS TieneSugerido,
			CASE WHEN pl.CodigoSAP IS NULL THEN 0 ELSE 1 END AS TieneLanzamientoCatalogoPersonalizado,		
			CASE WHEN pcor.SAP IS NULL THEN 0 ELSE 1 END AS TieneOfertaRevista,		
			IsNull(pcor.Oferta,'') AS TipoOfertaRevista,
			tc.Orden,
			@TipoMeta AS TipoMeta,
			Case @TipoMeta 
				When 'MM' Then @MontoFaltante 
				When 'RG' Then @MontoMeta 
				When 'GM' Then @MontoMeta
			End As MontoMeta
		FROM @tablaCodigosCuv tc  
		INNER JOIN ods.ProductoComercial p WITH(NOLOCK) ON tc.CampaniaID = p.CampaniaID AND tc.CUV = p.CUV
		LEFT JOIN ProductoComercialConfiguracion pcc WITH(NOLOCK) ON p.AnoCampania = pcc.CampaniaID AND p.CUV = pcc.CUV
		LEFT JOIN @OfertaProductoTemp op ON op.CampaniaID = p.CampaniaID AND op.CUV = p.CUV
		LEFT JOIN ods.ProductosLanzamiento pl WITH(NOLOCK) ON p.CodigoProducto = pl.CodigoSAP AND p.AnoCampania = pl.Campania
		LEFT JOIN ProductoComercialOfertaRevista pcor WITH(NOLOCK) ON p.AnoCampania = pcor.Campania AND p.CUV = pcor.CUV
		LEFT JOIN Marca M WITH(NOLOCK) ON p.MarcaId = m.MarcaId
		Where
			p.IndicadorDigitable = 1
			And (p.PrecioCatalogo >= IsNull(@PrecioMinimo,0)) And PrecioCatalogo >= IsNull(@MontoFaltante,0)
		ORDER BY tc.Orden

	END
END
GO

USE BelcorpMexico
GO


ALTER PROCEDURE [dbo].[GetListaProductoOfertaFinalRegaloSorpresa]
(
	@Table1 dbo.ListaOfertaFinalType READONLY
)
AS
BEGIN
	SET NOCOUNT ON;

	-- PASO 1 (obtener datos iniciales)
	DECLARE  @CampaniaID INT, @CodigoConsultora VARCHAR(30), 
		@ZonaID INT, @CodigoRegion VARCHAR(8), @CodigoZona VARCHAR(8), 
		@MontoMinPedido NUMERIC(15,2), @MontoTotal MONEY, @MontoEscala MONEY,
		@Algoritmo varchar(10)

	SELECT 
		@CampaniaID = CampaniaID,
		@CodigoConsultora = CodigoConsultora,
		@ZonaID = ZonaID, 
		@CodigoRegion = CodigoRegion, 
		@CodigoZona = CodigoZona,
		@MontoMinPedido = MontoMinimo,
		@MontoTotal = MontoTotal, 
		@MontoEscala = MontoEscala,
		@Algoritmo = Algoritmo 
	FROM @Table1

	-- PASO 2 (validar si cumple la parametria)
	Declare @CumpleParametria Bit, @MontoFaltante DECIMAL(18,2), @PrecioMinimo DECIMAL(18,2), 
		@TipoMeta CHAR(2), @MontoMeta decimal(18,2)

	Set @CumpleParametria = 0

	IF (@MontoTotal >= @MontoMinPedido)
	Begin		
		Print 'RANGO' 

		if exists(Select 1 From OfertaFinalParametria with (nolock) 
			Where Tipo = 'RG' And @MontoTotal >= GapMinimo And @MontoTotal <= GapMaximo And Algoritmo = @Algoritmo)
		begin
			Set @TipoMeta = 'RG'
			Set @PrecioMinimo = 0
			Set @CumpleParametria = 1

			Declare @ConsultoraId int
			Set @ConsultoraId = (Select ConsultoraId From ods.Consultora with (nolock) Where Codigo = @CodigoConsultora)
			Set @MontoMeta = (Select MontoMeta From OfertaFinalMontoMeta with (nolock) Where CampaniaId = @CampaniaId And ConsultoraId = @ConsultoraId)	

			if (isnull(@MontoMeta,0) = 0)
				Execute InsertarOfertaFinalRegaloSorpresa @CampaniaID,@ConsultoraId,@MontoTotal,@Algoritmo,@MontoMeta output

			if (@MontoTotal >= @MontoMeta and @MontoMeta != 0)
			begin
				Set @TipoMeta = 'GM'
				set @PrecioMinimo = (select top 1 PrecioMinimo From OfertaFinalParametria with (nolock) Where Tipo = 'GM' And Algoritmo = @Algoritmo)
				if (isnull(@PrecioMinimo,0) >= 0)
					Set @CumpleParametria = 1
				else
					Set @CumpleParametria = 0
			End		
		end												
	End
	Else
	Begin
		PRINT 'MM'
		SET @MontoFaltante = (@MontoMinPedido - @MontoTotal)

		IF (@MontoFaltante > 0)
		BEGIN
			SELECT TOP 1 @PrecioMinimo = PrecioMinimo,
				@CumpleParametria = 1
			FROM OfertaFinalParametria 
			WHERE Tipo = 'MM'
			AND GapMinimo <= @MontoFaltante AND GapMaximo >= @MontoFaltante
			AND Algoritmo = @Algoritmo

			SET @TipoMeta = 'MM'
		END
	END

	IF (@CumpleParametria = 1)
	BEGIN
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
		DECLARE @tablaCuvPedido TABLE 
		(
			CUV VARCHAR(6),
			CodigoSap VARCHAR(30)
		)

		INSERT INTO @tablaCuvPedido
		SELECT pc.CUV, pc.CodigoProducto
		FROM PedidoWebDetalle pd WITH(NOLOCK)
			INNER JOIN ods.ProductoComercial pc WITH(NOLOCK) ON pd.CampaniaID = pc.AnoCampania
				AND pd.CUV = pc.CUV
				AND pc.IndicadorDigitable = 1
				--AND pc.CodigoCatalago IN (9,10,13, 24)
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
			AND op.TipoPersonalizacion = 'SR'
		WHERE pc.AnoCampania = @CampaniaID
		AND pc.CUV NOT IN ( SELECT CUV FROM @tablaCuvFaltante )
		AND pc.CodigoProducto NOT IN ( SELECT CodigoSap FROM @tablaCuvPedido )
		
		-- en caso no hay registro de la consultora
		-- poner la consultora XXX XXX XXX
		declare @cantXXX int = 0, @codigoXXX varchar(30) = ''
		select @cantXXX = COUNT(1) from @tablaCodigosCuv
		set @cantXXX = IsNull(@cantXXX, 0)

		if	@cantXXX = 0
		begin
			select @codigoXXX = Codigo
			from TablaLogicaDatos where TablaLogicaDatosID = 10001
			
			set @codigoXXX = IsNull(@codigoXXX, '')

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
					AND op.TipoPersonalizacion = 'SR'
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
		
		IF (@TipoMeta = 'GM')
		BEGIN
			Set @MontoFaltante = 0
		END

		PRINT 'PM: ' + CAST(@PrecioMinimo AS VARCHAR)
		PRINT 'MF: ' + CAST(ISNULL(@MontoFaltante,0) AS VARCHAR)

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
			IsNull(pcc.EsExpoOferta,0) AS EsExpoOferta,
			IsNull(pcc.CUVRevista,'') AS CUVRevista,
			m.Descripcion AS NombreMarca, 
			'NO DISPONIBLE' AS DescripcionCategoria, 
			'' AS CUVComplemento,
			'' AS DescripcionEstrategia, 
			IsNull(op.ConfiguracionOfertaID,0) AS ConfiguracionOfertaID,
			IsNull(op.TipoOfertaSisID,0) AS TipoOfertaSisID,
			0 AS FlagNueva, 
			0 AS TipoEstrategiaID, 
			0 AS TieneSugerido,
			CASE WHEN pl.CodigoSAP IS NULL THEN 0 ELSE 1 END AS TieneLanzamientoCatalogoPersonalizado,		
			CASE WHEN pcor.SAP IS NULL THEN 0 ELSE 1 END AS TieneOfertaRevista,		
			IsNull(pcor.Oferta,'') AS TipoOfertaRevista,
			tc.Orden,
			@TipoMeta AS TipoMeta,
			Case @TipoMeta 
				When 'MM' Then @MontoFaltante 
				When 'RG' Then @MontoMeta 
				When 'GM' Then @MontoMeta
			End As MontoMeta
		FROM @tablaCodigosCuv tc  
		INNER JOIN ods.ProductoComercial p WITH(NOLOCK) ON tc.CampaniaID = p.CampaniaID AND tc.CUV = p.CUV
		LEFT JOIN ProductoComercialConfiguracion pcc WITH(NOLOCK) ON p.AnoCampania = pcc.CampaniaID AND p.CUV = pcc.CUV
		LEFT JOIN @OfertaProductoTemp op ON op.CampaniaID = p.CampaniaID AND op.CUV = p.CUV
		LEFT JOIN ods.ProductosLanzamiento pl WITH(NOLOCK) ON p.CodigoProducto = pl.CodigoSAP AND p.AnoCampania = pl.Campania
		LEFT JOIN ProductoComercialOfertaRevista pcor WITH(NOLOCK) ON p.AnoCampania = pcor.Campania AND p.CUV = pcor.CUV
		LEFT JOIN Marca M WITH(NOLOCK) ON p.MarcaId = m.MarcaId
		Where
			p.IndicadorDigitable = 1
			And (p.PrecioCatalogo >= IsNull(@PrecioMinimo,0)) And PrecioCatalogo >= IsNull(@MontoFaltante,0)
		ORDER BY tc.Orden

	END
END
GO

USE BelcorpPanama
GO


ALTER PROCEDURE [dbo].[GetListaProductoOfertaFinalRegaloSorpresa]
(
	@Table1 dbo.ListaOfertaFinalType READONLY
)
AS
BEGIN
	SET NOCOUNT ON;

	-- PASO 1 (obtener datos iniciales)
	DECLARE  @CampaniaID INT, @CodigoConsultora VARCHAR(30), 
		@ZonaID INT, @CodigoRegion VARCHAR(8), @CodigoZona VARCHAR(8), 
		@MontoMinPedido NUMERIC(15,2), @MontoTotal MONEY, @MontoEscala MONEY,
		@Algoritmo varchar(10)

	SELECT 
		@CampaniaID = CampaniaID,
		@CodigoConsultora = CodigoConsultora,
		@ZonaID = ZonaID, 
		@CodigoRegion = CodigoRegion, 
		@CodigoZona = CodigoZona,
		@MontoMinPedido = MontoMinimo,
		@MontoTotal = MontoTotal, 
		@MontoEscala = MontoEscala,
		@Algoritmo = Algoritmo 
	FROM @Table1

	-- PASO 2 (validar si cumple la parametria)
	Declare @CumpleParametria Bit, @MontoFaltante DECIMAL(18,2), @PrecioMinimo DECIMAL(18,2), 
		@TipoMeta CHAR(2), @MontoMeta decimal(18,2)

	Set @CumpleParametria = 0

	IF (@MontoTotal >= @MontoMinPedido)
	Begin		
		Print 'RANGO' 

		if exists(Select 1 From OfertaFinalParametria with (nolock) 
			Where Tipo = 'RG' And @MontoTotal >= GapMinimo And @MontoTotal <= GapMaximo And Algoritmo = @Algoritmo)
		begin
			Set @TipoMeta = 'RG'
			Set @PrecioMinimo = 0
			Set @CumpleParametria = 1

			Declare @ConsultoraId int
			Set @ConsultoraId = (Select ConsultoraId From ods.Consultora with (nolock) Where Codigo = @CodigoConsultora)
			Set @MontoMeta = (Select MontoMeta From OfertaFinalMontoMeta with (nolock) Where CampaniaId = @CampaniaId And ConsultoraId = @ConsultoraId)	

			if (isnull(@MontoMeta,0) = 0)
				Execute InsertarOfertaFinalRegaloSorpresa @CampaniaID,@ConsultoraId,@MontoTotal,@Algoritmo,@MontoMeta output

			if (@MontoTotal >= @MontoMeta and @MontoMeta != 0)
			begin
				Set @TipoMeta = 'GM'
				set @PrecioMinimo = (select top 1 PrecioMinimo From OfertaFinalParametria with (nolock) Where Tipo = 'GM' And Algoritmo = @Algoritmo)
				if (isnull(@PrecioMinimo,0) >= 0)
					Set @CumpleParametria = 1
				else
					Set @CumpleParametria = 0
			End		
		end												
	End
	Else
	Begin
		PRINT 'MM'
		SET @MontoFaltante = (@MontoMinPedido - @MontoTotal)

		IF (@MontoFaltante > 0)
		BEGIN
			SELECT TOP 1 @PrecioMinimo = PrecioMinimo,
				@CumpleParametria = 1
			FROM OfertaFinalParametria 
			WHERE Tipo = 'MM'
			AND GapMinimo <= @MontoFaltante AND GapMaximo >= @MontoFaltante
			AND Algoritmo = @Algoritmo

			SET @TipoMeta = 'MM'
		END
	END

	IF (@CumpleParametria = 1)
	BEGIN
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
		DECLARE @tablaCuvPedido TABLE 
		(
			CUV VARCHAR(6),
			CodigoSap VARCHAR(30)
		)

		INSERT INTO @tablaCuvPedido
		SELECT pc.CUV, pc.CodigoProducto
		FROM PedidoWebDetalle pd WITH(NOLOCK)
			INNER JOIN ods.ProductoComercial pc WITH(NOLOCK) ON pd.CampaniaID = pc.AnoCampania
				AND pd.CUV = pc.CUV
				AND pc.IndicadorDigitable = 1
				--AND pc.CodigoCatalago IN (9,10,13, 24)
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
			AND op.TipoPersonalizacion = 'SR'
		WHERE pc.AnoCampania = @CampaniaID
		AND pc.CUV NOT IN ( SELECT CUV FROM @tablaCuvFaltante )
		AND pc.CodigoProducto NOT IN ( SELECT CodigoSap FROM @tablaCuvPedido )
		
		-- en caso no hay registro de la consultora
		-- poner la consultora XXX XXX XXX
		declare @cantXXX int = 0, @codigoXXX varchar(30) = ''
		select @cantXXX = COUNT(1) from @tablaCodigosCuv
		set @cantXXX = IsNull(@cantXXX, 0)

		if	@cantXXX = 0
		begin
			select @codigoXXX = Codigo
			from TablaLogicaDatos where TablaLogicaDatosID = 10001
			
			set @codigoXXX = IsNull(@codigoXXX, '')

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
					AND op.TipoPersonalizacion = 'SR'
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
		
		IF (@TipoMeta = 'GM')
		BEGIN
			Set @MontoFaltante = 0
		END

		PRINT 'PM: ' + CAST(@PrecioMinimo AS VARCHAR)
		PRINT 'MF: ' + CAST(ISNULL(@MontoFaltante,0) AS VARCHAR)

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
			IsNull(pcc.EsExpoOferta,0) AS EsExpoOferta,
			IsNull(pcc.CUVRevista,'') AS CUVRevista,
			m.Descripcion AS NombreMarca, 
			'NO DISPONIBLE' AS DescripcionCategoria, 
			'' AS CUVComplemento,
			'' AS DescripcionEstrategia, 
			IsNull(op.ConfiguracionOfertaID,0) AS ConfiguracionOfertaID,
			IsNull(op.TipoOfertaSisID,0) AS TipoOfertaSisID,
			0 AS FlagNueva, 
			0 AS TipoEstrategiaID, 
			0 AS TieneSugerido,
			CASE WHEN pl.CodigoSAP IS NULL THEN 0 ELSE 1 END AS TieneLanzamientoCatalogoPersonalizado,		
			CASE WHEN pcor.SAP IS NULL THEN 0 ELSE 1 END AS TieneOfertaRevista,		
			IsNull(pcor.Oferta,'') AS TipoOfertaRevista,
			tc.Orden,
			@TipoMeta AS TipoMeta,
			Case @TipoMeta 
				When 'MM' Then @MontoFaltante 
				When 'RG' Then @MontoMeta 
				When 'GM' Then @MontoMeta
			End As MontoMeta
		FROM @tablaCodigosCuv tc  
		INNER JOIN ods.ProductoComercial p WITH(NOLOCK) ON tc.CampaniaID = p.CampaniaID AND tc.CUV = p.CUV
		LEFT JOIN ProductoComercialConfiguracion pcc WITH(NOLOCK) ON p.AnoCampania = pcc.CampaniaID AND p.CUV = pcc.CUV
		LEFT JOIN @OfertaProductoTemp op ON op.CampaniaID = p.CampaniaID AND op.CUV = p.CUV
		LEFT JOIN ods.ProductosLanzamiento pl WITH(NOLOCK) ON p.CodigoProducto = pl.CodigoSAP AND p.AnoCampania = pl.Campania
		LEFT JOIN ProductoComercialOfertaRevista pcor WITH(NOLOCK) ON p.AnoCampania = pcor.Campania AND p.CUV = pcor.CUV
		LEFT JOIN Marca M WITH(NOLOCK) ON p.MarcaId = m.MarcaId
		Where
			p.IndicadorDigitable = 1
			And (p.PrecioCatalogo >= IsNull(@PrecioMinimo,0)) And PrecioCatalogo >= IsNull(@MontoFaltante,0)
		ORDER BY tc.Orden

	END
END
GO

USE BelcorpPeru
GO


ALTER PROCEDURE [dbo].[GetListaProductoOfertaFinalRegaloSorpresa]
(
	@Table1 dbo.ListaOfertaFinalType READONLY
)
AS
BEGIN
	SET NOCOUNT ON;

	-- PASO 1 (obtener datos iniciales)
	DECLARE  @CampaniaID INT, @CodigoConsultora VARCHAR(30), 
		@ZonaID INT, @CodigoRegion VARCHAR(8), @CodigoZona VARCHAR(8), 
		@MontoMinPedido NUMERIC(15,2), @MontoTotal MONEY, @MontoEscala MONEY,
		@Algoritmo varchar(10)

	SELECT 
		@CampaniaID = CampaniaID,
		@CodigoConsultora = CodigoConsultora,
		@ZonaID = ZonaID, 
		@CodigoRegion = CodigoRegion, 
		@CodigoZona = CodigoZona,
		@MontoMinPedido = MontoMinimo,
		@MontoTotal = MontoTotal, 
		@MontoEscala = MontoEscala,
		@Algoritmo = Algoritmo 
	FROM @Table1

	-- PASO 2 (validar si cumple la parametria)
	Declare @CumpleParametria Bit, @MontoFaltante DECIMAL(18,2), @PrecioMinimo DECIMAL(18,2), 
		@TipoMeta CHAR(2), @MontoMeta decimal(18,2)

	Set @CumpleParametria = 0

	IF (@MontoTotal >= @MontoMinPedido)
	Begin		
		Print 'RANGO' 

		if exists(Select 1 From OfertaFinalParametria with (nolock) 
			Where Tipo = 'RG' And @MontoTotal >= GapMinimo And @MontoTotal <= GapMaximo And Algoritmo = @Algoritmo)
		begin
			Set @TipoMeta = 'RG'
			Set @PrecioMinimo = 0
			Set @CumpleParametria = 1

			Declare @ConsultoraId int
			Set @ConsultoraId = (Select ConsultoraId From ods.Consultora with (nolock) Where Codigo = @CodigoConsultora)
			Set @MontoMeta = (Select MontoMeta From OfertaFinalMontoMeta with (nolock) Where CampaniaId = @CampaniaId And ConsultoraId = @ConsultoraId)	

			if (isnull(@MontoMeta,0) = 0)
				Execute InsertarOfertaFinalRegaloSorpresa @CampaniaID,@ConsultoraId,@MontoTotal,@Algoritmo,@MontoMeta output

			if (@MontoTotal >= @MontoMeta and @MontoMeta != 0)
			begin
				Set @TipoMeta = 'GM'
				set @PrecioMinimo = (select top 1 PrecioMinimo From OfertaFinalParametria with (nolock) Where Tipo = 'GM' And Algoritmo = @Algoritmo)
				if (isnull(@PrecioMinimo,0) >= 0)
					Set @CumpleParametria = 1
				else
					Set @CumpleParametria = 0
			End		
		end												
	End
	Else
	Begin
		PRINT 'MM'
		SET @MontoFaltante = (@MontoMinPedido - @MontoTotal)

		IF (@MontoFaltante > 0)
		BEGIN
			SELECT TOP 1 @PrecioMinimo = PrecioMinimo,
				@CumpleParametria = 1
			FROM OfertaFinalParametria 
			WHERE Tipo = 'MM'
			AND GapMinimo <= @MontoFaltante AND GapMaximo >= @MontoFaltante
			AND Algoritmo = @Algoritmo

			SET @TipoMeta = 'MM'
		END
	END

	IF (@CumpleParametria = 1)
	BEGIN
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
		DECLARE @tablaCuvPedido TABLE 
		(
			CUV VARCHAR(6),
			CodigoSap VARCHAR(30)
		)

		INSERT INTO @tablaCuvPedido
		SELECT pc.CUV, pc.CodigoProducto
		FROM PedidoWebDetalle pd WITH(NOLOCK)
			INNER JOIN ods.ProductoComercial pc WITH(NOLOCK) ON pd.CampaniaID = pc.AnoCampania
				AND pd.CUV = pc.CUV
				AND pc.IndicadorDigitable = 1
				--AND pc.CodigoCatalago IN (9,10,13, 24)
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
			AND op.TipoPersonalizacion = 'SR'
		WHERE pc.AnoCampania = @CampaniaID
		AND pc.CUV NOT IN ( SELECT CUV FROM @tablaCuvFaltante )
		AND pc.CodigoProducto NOT IN ( SELECT CodigoSap FROM @tablaCuvPedido )
		
		-- en caso no hay registro de la consultora
		-- poner la consultora XXX XXX XXX
		declare @cantXXX int = 0, @codigoXXX varchar(30) = ''
		select @cantXXX = COUNT(1) from @tablaCodigosCuv
		set @cantXXX = IsNull(@cantXXX, 0)

		if	@cantXXX = 0
		begin
			select @codigoXXX = Codigo
			from TablaLogicaDatos where TablaLogicaDatosID = 10001
			
			set @codigoXXX = IsNull(@codigoXXX, '')

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
					AND op.TipoPersonalizacion = 'SR'
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
		
		IF (@TipoMeta = 'GM')
		BEGIN
			Set @MontoFaltante = 0
		END

		PRINT 'PM: ' + CAST(@PrecioMinimo AS VARCHAR)
		PRINT 'MF: ' + CAST(ISNULL(@MontoFaltante,0) AS VARCHAR)

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
			IsNull(pcc.EsExpoOferta,0) AS EsExpoOferta,
			IsNull(pcc.CUVRevista,'') AS CUVRevista,
			m.Descripcion AS NombreMarca, 
			'NO DISPONIBLE' AS DescripcionCategoria, 
			'' AS CUVComplemento,
			'' AS DescripcionEstrategia, 
			IsNull(op.ConfiguracionOfertaID,0) AS ConfiguracionOfertaID,
			IsNull(op.TipoOfertaSisID,0) AS TipoOfertaSisID,
			0 AS FlagNueva, 
			0 AS TipoEstrategiaID, 
			0 AS TieneSugerido,
			CASE WHEN pl.CodigoSAP IS NULL THEN 0 ELSE 1 END AS TieneLanzamientoCatalogoPersonalizado,		
			CASE WHEN pcor.SAP IS NULL THEN 0 ELSE 1 END AS TieneOfertaRevista,		
			IsNull(pcor.Oferta,'') AS TipoOfertaRevista,
			tc.Orden,
			@TipoMeta AS TipoMeta,
			Case @TipoMeta 
				When 'MM' Then @MontoFaltante 
				When 'RG' Then @MontoMeta 
				When 'GM' Then @MontoMeta
			End As MontoMeta
		FROM @tablaCodigosCuv tc  
		INNER JOIN ods.ProductoComercial p WITH(NOLOCK) ON tc.CampaniaID = p.CampaniaID AND tc.CUV = p.CUV
		LEFT JOIN ProductoComercialConfiguracion pcc WITH(NOLOCK) ON p.AnoCampania = pcc.CampaniaID AND p.CUV = pcc.CUV
		LEFT JOIN @OfertaProductoTemp op ON op.CampaniaID = p.CampaniaID AND op.CUV = p.CUV
		LEFT JOIN ods.ProductosLanzamiento pl WITH(NOLOCK) ON p.CodigoProducto = pl.CodigoSAP AND p.AnoCampania = pl.Campania
		LEFT JOIN ProductoComercialOfertaRevista pcor WITH(NOLOCK) ON p.AnoCampania = pcor.Campania AND p.CUV = pcor.CUV
		LEFT JOIN Marca M WITH(NOLOCK) ON p.MarcaId = m.MarcaId
		Where
			p.IndicadorDigitable = 1
			And (p.PrecioCatalogo >= IsNull(@PrecioMinimo,0)) And PrecioCatalogo >= IsNull(@MontoFaltante,0)
		ORDER BY tc.Orden

	END
END
GO

USE BelcorpPuertoRico
GO


ALTER PROCEDURE [dbo].[GetListaProductoOfertaFinalRegaloSorpresa]
(
	@Table1 dbo.ListaOfertaFinalType READONLY
)
AS
BEGIN
	SET NOCOUNT ON;

	-- PASO 1 (obtener datos iniciales)
	DECLARE  @CampaniaID INT, @CodigoConsultora VARCHAR(30), 
		@ZonaID INT, @CodigoRegion VARCHAR(8), @CodigoZona VARCHAR(8), 
		@MontoMinPedido NUMERIC(15,2), @MontoTotal MONEY, @MontoEscala MONEY,
		@Algoritmo varchar(10)

	SELECT 
		@CampaniaID = CampaniaID,
		@CodigoConsultora = CodigoConsultora,
		@ZonaID = ZonaID, 
		@CodigoRegion = CodigoRegion, 
		@CodigoZona = CodigoZona,
		@MontoMinPedido = MontoMinimo,
		@MontoTotal = MontoTotal, 
		@MontoEscala = MontoEscala,
		@Algoritmo = Algoritmo 
	FROM @Table1

	-- PASO 2 (validar si cumple la parametria)
	Declare @CumpleParametria Bit, @MontoFaltante DECIMAL(18,2), @PrecioMinimo DECIMAL(18,2), 
		@TipoMeta CHAR(2), @MontoMeta decimal(18,2)

	Set @CumpleParametria = 0

	IF (@MontoTotal >= @MontoMinPedido)
	Begin		
		Print 'RANGO' 

		if exists(Select 1 From OfertaFinalParametria with (nolock) 
			Where Tipo = 'RG' And @MontoTotal >= GapMinimo And @MontoTotal <= GapMaximo And Algoritmo = @Algoritmo)
		begin
			Set @TipoMeta = 'RG'
			Set @PrecioMinimo = 0
			Set @CumpleParametria = 1

			Declare @ConsultoraId int
			Set @ConsultoraId = (Select ConsultoraId From ods.Consultora with (nolock) Where Codigo = @CodigoConsultora)
			Set @MontoMeta = (Select MontoMeta From OfertaFinalMontoMeta with (nolock) Where CampaniaId = @CampaniaId And ConsultoraId = @ConsultoraId)	

			if (isnull(@MontoMeta,0) = 0)
				Execute InsertarOfertaFinalRegaloSorpresa @CampaniaID,@ConsultoraId,@MontoTotal,@Algoritmo,@MontoMeta output

			if (@MontoTotal >= @MontoMeta and @MontoMeta != 0)
			begin
				Set @TipoMeta = 'GM'
				set @PrecioMinimo = (select top 1 PrecioMinimo From OfertaFinalParametria with (nolock) Where Tipo = 'GM' And Algoritmo = @Algoritmo)
				if (isnull(@PrecioMinimo,0) >= 0)
					Set @CumpleParametria = 1
				else
					Set @CumpleParametria = 0
			End		
		end												
	End
	Else
	Begin
		PRINT 'MM'
		SET @MontoFaltante = (@MontoMinPedido - @MontoTotal)

		IF (@MontoFaltante > 0)
		BEGIN
			SELECT TOP 1 @PrecioMinimo = PrecioMinimo,
				@CumpleParametria = 1
			FROM OfertaFinalParametria 
			WHERE Tipo = 'MM'
			AND GapMinimo <= @MontoFaltante AND GapMaximo >= @MontoFaltante
			AND Algoritmo = @Algoritmo

			SET @TipoMeta = 'MM'
		END
	END

	IF (@CumpleParametria = 1)
	BEGIN
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
		DECLARE @tablaCuvPedido TABLE 
		(
			CUV VARCHAR(6),
			CodigoSap VARCHAR(30)
		)

		INSERT INTO @tablaCuvPedido
		SELECT pc.CUV, pc.CodigoProducto
		FROM PedidoWebDetalle pd WITH(NOLOCK)
			INNER JOIN ods.ProductoComercial pc WITH(NOLOCK) ON pd.CampaniaID = pc.AnoCampania
				AND pd.CUV = pc.CUV
				AND pc.IndicadorDigitable = 1
				--AND pc.CodigoCatalago IN (9,10,13, 24)
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
			AND op.TipoPersonalizacion = 'SR'
		WHERE pc.AnoCampania = @CampaniaID
		AND pc.CUV NOT IN ( SELECT CUV FROM @tablaCuvFaltante )
		AND pc.CodigoProducto NOT IN ( SELECT CodigoSap FROM @tablaCuvPedido )
		
		-- en caso no hay registro de la consultora
		-- poner la consultora XXX XXX XXX
		declare @cantXXX int = 0, @codigoXXX varchar(30) = ''
		select @cantXXX = COUNT(1) from @tablaCodigosCuv
		set @cantXXX = IsNull(@cantXXX, 0)

		if	@cantXXX = 0
		begin
			select @codigoXXX = Codigo
			from TablaLogicaDatos where TablaLogicaDatosID = 10001
			
			set @codigoXXX = IsNull(@codigoXXX, '')

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
					AND op.TipoPersonalizacion = 'SR'
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
		
		IF (@TipoMeta = 'GM')
		BEGIN
			Set @MontoFaltante = 0
		END

		PRINT 'PM: ' + CAST(@PrecioMinimo AS VARCHAR)
		PRINT 'MF: ' + CAST(ISNULL(@MontoFaltante,0) AS VARCHAR)

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
			IsNull(pcc.EsExpoOferta,0) AS EsExpoOferta,
			IsNull(pcc.CUVRevista,'') AS CUVRevista,
			m.Descripcion AS NombreMarca, 
			'NO DISPONIBLE' AS DescripcionCategoria, 
			'' AS CUVComplemento,
			'' AS DescripcionEstrategia, 
			IsNull(op.ConfiguracionOfertaID,0) AS ConfiguracionOfertaID,
			IsNull(op.TipoOfertaSisID,0) AS TipoOfertaSisID,
			0 AS FlagNueva, 
			0 AS TipoEstrategiaID, 
			0 AS TieneSugerido,
			CASE WHEN pl.CodigoSAP IS NULL THEN 0 ELSE 1 END AS TieneLanzamientoCatalogoPersonalizado,		
			CASE WHEN pcor.SAP IS NULL THEN 0 ELSE 1 END AS TieneOfertaRevista,		
			IsNull(pcor.Oferta,'') AS TipoOfertaRevista,
			tc.Orden,
			@TipoMeta AS TipoMeta,
			Case @TipoMeta 
				When 'MM' Then @MontoFaltante 
				When 'RG' Then @MontoMeta 
				When 'GM' Then @MontoMeta
			End As MontoMeta
		FROM @tablaCodigosCuv tc  
		INNER JOIN ods.ProductoComercial p WITH(NOLOCK) ON tc.CampaniaID = p.CampaniaID AND tc.CUV = p.CUV
		LEFT JOIN ProductoComercialConfiguracion pcc WITH(NOLOCK) ON p.AnoCampania = pcc.CampaniaID AND p.CUV = pcc.CUV
		LEFT JOIN @OfertaProductoTemp op ON op.CampaniaID = p.CampaniaID AND op.CUV = p.CUV
		LEFT JOIN ods.ProductosLanzamiento pl WITH(NOLOCK) ON p.CodigoProducto = pl.CodigoSAP AND p.AnoCampania = pl.Campania
		LEFT JOIN ProductoComercialOfertaRevista pcor WITH(NOLOCK) ON p.AnoCampania = pcor.Campania AND p.CUV = pcor.CUV
		LEFT JOIN Marca M WITH(NOLOCK) ON p.MarcaId = m.MarcaId
		Where
			p.IndicadorDigitable = 1
			And (p.PrecioCatalogo >= IsNull(@PrecioMinimo,0)) And PrecioCatalogo >= IsNull(@MontoFaltante,0)
		ORDER BY tc.Orden

	END
END
GO

USE BelcorpSalvador
GO


ALTER PROCEDURE [dbo].[GetListaProductoOfertaFinalRegaloSorpresa]
(
	@Table1 dbo.ListaOfertaFinalType READONLY
)
AS
BEGIN
	SET NOCOUNT ON;

	-- PASO 1 (obtener datos iniciales)
	DECLARE  @CampaniaID INT, @CodigoConsultora VARCHAR(30), 
		@ZonaID INT, @CodigoRegion VARCHAR(8), @CodigoZona VARCHAR(8), 
		@MontoMinPedido NUMERIC(15,2), @MontoTotal MONEY, @MontoEscala MONEY,
		@Algoritmo varchar(10)

	SELECT 
		@CampaniaID = CampaniaID,
		@CodigoConsultora = CodigoConsultora,
		@ZonaID = ZonaID, 
		@CodigoRegion = CodigoRegion, 
		@CodigoZona = CodigoZona,
		@MontoMinPedido = MontoMinimo,
		@MontoTotal = MontoTotal, 
		@MontoEscala = MontoEscala,
		@Algoritmo = Algoritmo 
	FROM @Table1

	-- PASO 2 (validar si cumple la parametria)
	Declare @CumpleParametria Bit, @MontoFaltante DECIMAL(18,2), @PrecioMinimo DECIMAL(18,2), 
		@TipoMeta CHAR(2), @MontoMeta decimal(18,2)

	Set @CumpleParametria = 0

	IF (@MontoTotal >= @MontoMinPedido)
	Begin		
		Print 'RANGO' 

		if exists(Select 1 From OfertaFinalParametria with (nolock) 
			Where Tipo = 'RG' And @MontoTotal >= GapMinimo And @MontoTotal <= GapMaximo And Algoritmo = @Algoritmo)
		begin
			Set @TipoMeta = 'RG'
			Set @PrecioMinimo = 0
			Set @CumpleParametria = 1

			Declare @ConsultoraId int
			Set @ConsultoraId = (Select ConsultoraId From ods.Consultora with (nolock) Where Codigo = @CodigoConsultora)
			Set @MontoMeta = (Select MontoMeta From OfertaFinalMontoMeta with (nolock) Where CampaniaId = @CampaniaId And ConsultoraId = @ConsultoraId)	

			if (isnull(@MontoMeta,0) = 0)
				Execute InsertarOfertaFinalRegaloSorpresa @CampaniaID,@ConsultoraId,@MontoTotal,@Algoritmo,@MontoMeta output

			if (@MontoTotal >= @MontoMeta and @MontoMeta != 0)
			begin
				Set @TipoMeta = 'GM'
				set @PrecioMinimo = (select top 1 PrecioMinimo From OfertaFinalParametria with (nolock) Where Tipo = 'GM' And Algoritmo = @Algoritmo)
				if (isnull(@PrecioMinimo,0) >= 0)
					Set @CumpleParametria = 1
				else
					Set @CumpleParametria = 0
			End		
		end												
	End
	Else
	Begin
		PRINT 'MM'
		SET @MontoFaltante = (@MontoMinPedido - @MontoTotal)

		IF (@MontoFaltante > 0)
		BEGIN
			SELECT TOP 1 @PrecioMinimo = PrecioMinimo,
				@CumpleParametria = 1
			FROM OfertaFinalParametria 
			WHERE Tipo = 'MM'
			AND GapMinimo <= @MontoFaltante AND GapMaximo >= @MontoFaltante
			AND Algoritmo = @Algoritmo

			SET @TipoMeta = 'MM'
		END
	END

	IF (@CumpleParametria = 1)
	BEGIN
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
		DECLARE @tablaCuvPedido TABLE 
		(
			CUV VARCHAR(6),
			CodigoSap VARCHAR(30)
		)

		INSERT INTO @tablaCuvPedido
		SELECT pc.CUV, pc.CodigoProducto
		FROM PedidoWebDetalle pd WITH(NOLOCK)
			INNER JOIN ods.ProductoComercial pc WITH(NOLOCK) ON pd.CampaniaID = pc.AnoCampania
				AND pd.CUV = pc.CUV
				AND pc.IndicadorDigitable = 1
				--AND pc.CodigoCatalago IN (9,10,13, 24)
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
			AND op.TipoPersonalizacion = 'SR'
		WHERE pc.AnoCampania = @CampaniaID
		AND pc.CUV NOT IN ( SELECT CUV FROM @tablaCuvFaltante )
		AND pc.CodigoProducto NOT IN ( SELECT CodigoSap FROM @tablaCuvPedido )
		
		-- en caso no hay registro de la consultora
		-- poner la consultora XXX XXX XXX
		declare @cantXXX int = 0, @codigoXXX varchar(30) = ''
		select @cantXXX = COUNT(1) from @tablaCodigosCuv
		set @cantXXX = IsNull(@cantXXX, 0)

		if	@cantXXX = 0
		begin
			select @codigoXXX = Codigo
			from TablaLogicaDatos where TablaLogicaDatosID = 10001
			
			set @codigoXXX = IsNull(@codigoXXX, '')

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
					AND op.TipoPersonalizacion = 'SR'
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
		
		IF (@TipoMeta = 'GM')
		BEGIN
			Set @MontoFaltante = 0
		END

		PRINT 'PM: ' + CAST(@PrecioMinimo AS VARCHAR)
		PRINT 'MF: ' + CAST(ISNULL(@MontoFaltante,0) AS VARCHAR)

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
			IsNull(pcc.EsExpoOferta,0) AS EsExpoOferta,
			IsNull(pcc.CUVRevista,'') AS CUVRevista,
			m.Descripcion AS NombreMarca, 
			'NO DISPONIBLE' AS DescripcionCategoria, 
			'' AS CUVComplemento,
			'' AS DescripcionEstrategia, 
			IsNull(op.ConfiguracionOfertaID,0) AS ConfiguracionOfertaID,
			IsNull(op.TipoOfertaSisID,0) AS TipoOfertaSisID,
			0 AS FlagNueva, 
			0 AS TipoEstrategiaID, 
			0 AS TieneSugerido,
			CASE WHEN pl.CodigoSAP IS NULL THEN 0 ELSE 1 END AS TieneLanzamientoCatalogoPersonalizado,		
			CASE WHEN pcor.SAP IS NULL THEN 0 ELSE 1 END AS TieneOfertaRevista,		
			IsNull(pcor.Oferta,'') AS TipoOfertaRevista,
			tc.Orden,
			@TipoMeta AS TipoMeta,
			Case @TipoMeta 
				When 'MM' Then @MontoFaltante 
				When 'RG' Then @MontoMeta 
				When 'GM' Then @MontoMeta
			End As MontoMeta
		FROM @tablaCodigosCuv tc  
		INNER JOIN ods.ProductoComercial p WITH(NOLOCK) ON tc.CampaniaID = p.CampaniaID AND tc.CUV = p.CUV
		LEFT JOIN ProductoComercialConfiguracion pcc WITH(NOLOCK) ON p.AnoCampania = pcc.CampaniaID AND p.CUV = pcc.CUV
		LEFT JOIN @OfertaProductoTemp op ON op.CampaniaID = p.CampaniaID AND op.CUV = p.CUV
		LEFT JOIN ods.ProductosLanzamiento pl WITH(NOLOCK) ON p.CodigoProducto = pl.CodigoSAP AND p.AnoCampania = pl.Campania
		LEFT JOIN ProductoComercialOfertaRevista pcor WITH(NOLOCK) ON p.AnoCampania = pcor.Campania AND p.CUV = pcor.CUV
		LEFT JOIN Marca M WITH(NOLOCK) ON p.MarcaId = m.MarcaId
		Where
			p.IndicadorDigitable = 1
			And (p.PrecioCatalogo >= IsNull(@PrecioMinimo,0)) And PrecioCatalogo >= IsNull(@MontoFaltante,0)
		ORDER BY tc.Orden

	END
END
GO

USE BelcorpVenezuela
GO


ALTER PROCEDURE [dbo].[GetListaProductoOfertaFinalRegaloSorpresa]
(
	@Table1 dbo.ListaOfertaFinalType READONLY
)
AS
BEGIN
	SET NOCOUNT ON;

	-- PASO 1 (obtener datos iniciales)
	DECLARE  @CampaniaID INT, @CodigoConsultora VARCHAR(30), 
		@ZonaID INT, @CodigoRegion VARCHAR(8), @CodigoZona VARCHAR(8), 
		@MontoMinPedido NUMERIC(15,2), @MontoTotal MONEY, @MontoEscala MONEY,
		@Algoritmo varchar(10)

	SELECT 
		@CampaniaID = CampaniaID,
		@CodigoConsultora = CodigoConsultora,
		@ZonaID = ZonaID, 
		@CodigoRegion = CodigoRegion, 
		@CodigoZona = CodigoZona,
		@MontoMinPedido = MontoMinimo,
		@MontoTotal = MontoTotal, 
		@MontoEscala = MontoEscala,
		@Algoritmo = Algoritmo 
	FROM @Table1

	-- PASO 2 (validar si cumple la parametria)
	Declare @CumpleParametria Bit, @MontoFaltante DECIMAL(18,2), @PrecioMinimo DECIMAL(18,2), 
		@TipoMeta CHAR(2), @MontoMeta decimal(18,2)

	Set @CumpleParametria = 0

	IF (@MontoTotal >= @MontoMinPedido)
	Begin		
		Print 'RANGO' 

		if exists(Select 1 From OfertaFinalParametria with (nolock) 
			Where Tipo = 'RG' And @MontoTotal >= GapMinimo And @MontoTotal <= GapMaximo And Algoritmo = @Algoritmo)
		begin
			Set @TipoMeta = 'RG'
			Set @PrecioMinimo = 0
			Set @CumpleParametria = 1

			Declare @ConsultoraId int
			Set @ConsultoraId = (Select ConsultoraId From ods.Consultora with (nolock) Where Codigo = @CodigoConsultora)
			Set @MontoMeta = (Select MontoMeta From OfertaFinalMontoMeta with (nolock) Where CampaniaId = @CampaniaId And ConsultoraId = @ConsultoraId)	

			if (isnull(@MontoMeta,0) = 0)
				Execute InsertarOfertaFinalRegaloSorpresa @CampaniaID,@ConsultoraId,@MontoTotal,@Algoritmo,@MontoMeta output

			if (@MontoTotal >= @MontoMeta and @MontoMeta != 0)
			begin
				Set @TipoMeta = 'GM'
				set @PrecioMinimo = (select top 1 PrecioMinimo From OfertaFinalParametria with (nolock) Where Tipo = 'GM' And Algoritmo = @Algoritmo)
				if (isnull(@PrecioMinimo,0) >= 0)
					Set @CumpleParametria = 1
				else
					Set @CumpleParametria = 0
			End		
		end												
	End
	Else
	Begin
		PRINT 'MM'
		SET @MontoFaltante = (@MontoMinPedido - @MontoTotal)

		IF (@MontoFaltante > 0)
		BEGIN
			SELECT TOP 1 @PrecioMinimo = PrecioMinimo,
				@CumpleParametria = 1
			FROM OfertaFinalParametria 
			WHERE Tipo = 'MM'
			AND GapMinimo <= @MontoFaltante AND GapMaximo >= @MontoFaltante
			AND Algoritmo = @Algoritmo

			SET @TipoMeta = 'MM'
		END
	END

	IF (@CumpleParametria = 1)
	BEGIN
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
		DECLARE @tablaCuvPedido TABLE 
		(
			CUV VARCHAR(6),
			CodigoSap VARCHAR(30)
		)

		INSERT INTO @tablaCuvPedido
		SELECT pc.CUV, pc.CodigoProducto
		FROM PedidoWebDetalle pd WITH(NOLOCK)
			INNER JOIN ods.ProductoComercial pc WITH(NOLOCK) ON pd.CampaniaID = pc.AnoCampania
				AND pd.CUV = pc.CUV
				AND pc.IndicadorDigitable = 1
				--AND pc.CodigoCatalago IN (9,10,13, 24)
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
			AND op.TipoPersonalizacion = 'SR'
		WHERE pc.AnoCampania = @CampaniaID
		AND pc.CUV NOT IN ( SELECT CUV FROM @tablaCuvFaltante )
		AND pc.CodigoProducto NOT IN ( SELECT CodigoSap FROM @tablaCuvPedido )
		
		-- en caso no hay registro de la consultora
		-- poner la consultora XXX XXX XXX
		declare @cantXXX int = 0, @codigoXXX varchar(30) = ''
		select @cantXXX = COUNT(1) from @tablaCodigosCuv
		set @cantXXX = IsNull(@cantXXX, 0)

		if	@cantXXX = 0
		begin
			select @codigoXXX = Codigo
			from TablaLogicaDatos where TablaLogicaDatosID = 10001
			
			set @codigoXXX = IsNull(@codigoXXX, '')

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
					AND op.TipoPersonalizacion = 'SR'
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
		
		IF (@TipoMeta = 'GM')
		BEGIN
			Set @MontoFaltante = 0
		END

		PRINT 'PM: ' + CAST(@PrecioMinimo AS VARCHAR)
		PRINT 'MF: ' + CAST(ISNULL(@MontoFaltante,0) AS VARCHAR)

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
			IsNull(pcc.EsExpoOferta,0) AS EsExpoOferta,
			IsNull(pcc.CUVRevista,'') AS CUVRevista,
			m.Descripcion AS NombreMarca, 
			'NO DISPONIBLE' AS DescripcionCategoria, 
			'' AS CUVComplemento,
			'' AS DescripcionEstrategia, 
			IsNull(op.ConfiguracionOfertaID,0) AS ConfiguracionOfertaID,
			IsNull(op.TipoOfertaSisID,0) AS TipoOfertaSisID,
			0 AS FlagNueva, 
			0 AS TipoEstrategiaID, 
			0 AS TieneSugerido,
			CASE WHEN pl.CodigoSAP IS NULL THEN 0 ELSE 1 END AS TieneLanzamientoCatalogoPersonalizado,		
			CASE WHEN pcor.SAP IS NULL THEN 0 ELSE 1 END AS TieneOfertaRevista,		
			IsNull(pcor.Oferta,'') AS TipoOfertaRevista,
			tc.Orden,
			@TipoMeta AS TipoMeta,
			Case @TipoMeta 
				When 'MM' Then @MontoFaltante 
				When 'RG' Then @MontoMeta 
				When 'GM' Then @MontoMeta
			End As MontoMeta
		FROM @tablaCodigosCuv tc  
		INNER JOIN ods.ProductoComercial p WITH(NOLOCK) ON tc.CampaniaID = p.CampaniaID AND tc.CUV = p.CUV
		LEFT JOIN ProductoComercialConfiguracion pcc WITH(NOLOCK) ON p.AnoCampania = pcc.CampaniaID AND p.CUV = pcc.CUV
		LEFT JOIN @OfertaProductoTemp op ON op.CampaniaID = p.CampaniaID AND op.CUV = p.CUV
		LEFT JOIN ods.ProductosLanzamiento pl WITH(NOLOCK) ON p.CodigoProducto = pl.CodigoSAP AND p.AnoCampania = pl.Campania
		LEFT JOIN ProductoComercialOfertaRevista pcor WITH(NOLOCK) ON p.AnoCampania = pcor.Campania AND p.CUV = pcor.CUV
		LEFT JOIN Marca M WITH(NOLOCK) ON p.MarcaId = m.MarcaId
		Where
			p.IndicadorDigitable = 1
			And (p.PrecioCatalogo >= IsNull(@PrecioMinimo,0)) And PrecioCatalogo >= IsNull(@MontoFaltante,0)
		ORDER BY tc.Orden

	END
END
GO