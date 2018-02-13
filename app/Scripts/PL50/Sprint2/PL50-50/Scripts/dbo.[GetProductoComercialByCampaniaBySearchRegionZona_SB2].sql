--todos iguales
USE BelcorpPeru
GO

GO

IF (OBJECT_ID('[dbo].[GetProductoComercialByCampaniaBySearchRegionZona_SB2]', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE [dbo].[GetProductoComercialByCampaniaBySearchRegionZona_SB2] AS SET NOCOUNT ON;')
GO

ALTER PROCEDURE [dbo].[GetProductoComercialByCampaniaBySearchRegionZona_SB2] @CampaniaID INT
	,@RowCount INT
	,@Criterio INT
	,@CodigoDescripcion VARCHAR(100)
	,@RegionID INT
	,@ZonaID INT
	,@CodigoRegion VARCHAR(10)
	,@CodigoZona VARCHAR(10)
	,@ValidarOPT BIT = 0
AS
/*
dbo.GetProductoComercialByCampaniaBySearchRegionZona_SB2 201618,1,1,'97010',2701,2161,'50','5052'
dbo.GetProductoComercialByCampaniaBySearchRegionZona_SB2 201618,1,1,'97010',2701,2161,'50','5052',1
*/
BEGIN
	-- Depuramos las tallas y colores
	EXEC DepurarTallaColorCUV @CampaniaID

	EXEC DepurarTallaColorLiquidacion @CampaniaID

	DECLARE @OfertaProductoTemp TABLE (
		CampaniaID INT
		,CUV VARCHAR(6)
		,Descripcion VARCHAR(250)
		,ConfiguracionOfertaID INT
		,TipoOfertaSisID INT
		,PrecioOferta NUMERIC(12, 2)
		)

	INSERT INTO @OfertaProductoTemp
	SELECT op.CampaniaID
		,op.CUV
		,op.Descripcion
		,op.ConfiguracionOfertaID
		,op.TipoOfertaSisID
		,NULL
	FROM OfertaProducto op WITH (NOLOCK)
	INNER JOIN ods.Campania c ON op.CampaniaID = c.CampaniaID
	WHERE c.codigo = @CampaniaID

	INSERT INTO @OfertaProductoTemp
	SELECT c.CampaniaID
		,e.CUV2 AS CUV
		,e.DescripcionCUV2 AS Descripcion
		,ves.ConfiguracionOfertaID
		,ves.TipoOfertaSisID
		,NULL
	FROM dbo.Estrategia e WITH (NOLOCK)
	INNER JOIN ods.Campania c ON e.CampaniaID = c.Codigo
	INNER JOIN vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE c.codigo = @CampaniaID

	DECLARE @ProductoFaltanteTemp TABLE (CUV VARCHAR(6))

	INSERT INTO @ProductoFaltanteTemp
	SELECT DISTINCT ltrim(rtrim(CUV))
	FROM dbo.ProductoFaltante NOLOCK
	WHERE CampaniaID = @CampaniaID
		AND Zonaid = @ZonaID
	
	UNION ALL
	
	SELECT DISTINCT ltrim(rtrim(fa.CodigoVenta)) AS CUV
	FROM ods.FaltanteAnunciado fa(NOLOCK)
	INNER JOIN ods.Campania c(NOLOCK) ON fa.CampaniaID = c.CampaniaID
	WHERE c.Codigo = @CampaniaID
		AND (
			rtrim(fa.CodigoRegion) = @CodigoRegion
			OR fa.CodigoRegion IS NULL
			)
		AND (
			rtrim(fa.CodigoZona) = @CodigoZona
			OR fa.CodigoZona IS NULL
			)

	--Logica para Producto Sugerido
	DECLARE @TieneSugerido INT = 0

	IF EXISTS (
			SELECT 1
			FROM dbo.ProductoSugerido
			WHERE CampaniaID = @CampaniaID
				AND CUV = @CodigoDescripcion
				AND Estado = 1
			)
	BEGIN
		SET @TieneSugerido = 1
	END

	DECLARE @tablaCuvOPT TABLE (CUV VARCHAR(6))

	IF (@Criterio = 1)
	BEGIN
		SELECT DISTINCT TOP (@RowCount) p.CUV
			,coalesce(EST.DescripcionCUV2 + ' ' + tcc.Descripcion, est.descripcioncuv2, op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion) AS Descripcion
			,coalesce(est.precio2, op.PrecioOferta, pd.PrecioProducto * pd.FactorRepeticion, p.PrecioUnitario * p.FactorRepeticion) AS PrecioCatalogo
			,p.MarcaID
			,0 AS EstaEnRevista
			,(
				CASE 
					WHEN ISNULL(pf.CUV, 0) = 0
						THEN 1
					WHEN ISNULL(pf.CUV, 0) > 0
						THEN 0
					END
				) AS TieneStock
			,ISNULL(pcc.EsExpoOferta, 0) AS EsExpoOferta
			,ISNULL(pcc.CUVRevista, '') AS CUVRevista
			,'' AS CUVComplemento
			,p.PaisID
			,p.AnoCampania AS CampaniaID
			,p.CodigoCatalago
			,p.CodigoProducto
			,p.IndicadorMontoMinimo
			,M.Descripcion AS DescripcionMarca
			,'NO DISPONIBLE' AS DescripcionCategoria
			,TE.DescripcionEstrategia AS DescripcionEstrategia
			,ISNULL(op.ConfiguracionOfertaID, 0) ConfiguracionOfertaID
			,CASE 
				WHEN EXISTS (
						SELECT 1
						FROM TallaColorLiquidacion
						WHERE CampaniaID = @CampaniaID
							AND CUV = p.CUV
						)
					THEN 1702
				WHEN EXISTS (
						SELECT 1
						FROM TallaColorCUV
						WHERE CampaniaID = @CampaniaID
							AND CUV = p.CUV
						)
					THEN (
							SELECT E.TipoEstrategiaID
							FROM Estrategia E
							INNER JOIN TALLACOLORCUV TCC ON E.CAMPANIAID = TCC.CAMPANIAID
								AND E.CUV2 = TCC.CUVPADRE
							WHERE TCC.CUV = p.CUV
								AND E.CAMPANIAID = @CampaniaID
							)
				ELSE ISNULL(op.TipoOfertaSisID, 0)
				END TipoOfertaSisID
			,ISNULL(te.flagNueva, 0) FlagNueva
			,ISNULL(te.TipoEstrategiaID, '') TipoEstrategiaID
			,P.IndicadorOferta
			,@TieneSugerido AS TieneSugerido
			,CASE 
				WHEN pcor.SAP IS NULL
					THEN 0
				ELSE 1
				END TieneOfertaRevista
			,p.PrecioValorizado
			,CASE 
				WHEN pl.CodigoSAP IS NULL
					THEN 0
				ELSE 1
				END AS TieneLanzamientoCatalogoPersonalizado
			,ISNULL(pcor.Oferta, '') AS TipoOfertaRevista
			,TE.Codigo AS TipoEstrategiaCodigo
			,CASE 
				WHEN (
						TE.MostrarImgOfertaIndependiente = 1
						AND EST.EsOfertaIndependiente = 1
						)
					THEN 1
				ELSE 0
				END AS EsOfertaIndependiente
		FROM ods.ProductoComercial p WITH (NOLOCK)
		LEFT JOIN dbo.ProductoDescripcion pd WITH (NOLOCK) ON p.AnoCampania = pd.CampaniaID
			AND p.CUV = pd.CUV
		LEFT JOIN @ProductoFaltanteTemp pf ON p.CUV = pf.CUV
		LEFT JOIN ProductoComercialConfiguracion pcc ON p.AnoCampania = pcc.CampaniaID
			AND p.CUV = pcc.CUV
		LEFT JOIN @OfertaProductoTemp op ON op.CampaniaID = P.CampaniaID
			AND op.CUV = P.CUV
		LEFT JOIN MatrizComercial mc WITH (NOLOCK) ON p.CodigoProducto = mc.CodigoSAP
		LEFT JOIN Estrategia EST WITH (NOLOCK) ON
			--EST.CampaniaID = p.AnoCampania
			(
				EST.CampaniaID = p.AnoCampania
				OR p.AnoCampania BETWEEN EST.CampaniaID
					AND EST.CampaniaIDFin
				)
			AND (
				EST.CUV2 = p.CUV
				OR EST.CUV2 = (
					SELECT CUVPadre
					FROM TallaColorCUV TCC
					WHERE TCC.CUV = p.CUV
					)
				)
			AND EST.Activo = 1
		LEFT JOIN dbo.TallaColorCUV tcc WITH (NOLOCK) ON tcc.CUV = p.CUV
			AND tcc.CampaniaID = p.AnoCampania
		LEFT JOIN TipoEstrategia TE WITH (NOLOCK) ON TE.TipoEstrategiaID = EST.TipoEstrategiaID
		LEFT JOIN Marca M WITH (NOLOCK) ON p.MarcaId = M.MarcaId
		LEFT JOIN ods.ProductosLanzamiento pl WITH (NOLOCK) ON p.CodigoProducto = pl.CodigoSAP
			AND p.AnoCampania = pl.Campania
		LEFT JOIN ProductoComercialOfertaRevista pcor WITH (NOLOCK) ON p.AnoCampania = pcor.Campania
			AND p.CUV = pcor.CUV
		WHERE p.AnoCampania = @CampaniaID
			AND p.IndicadorDigitable = 1
			AND CHARINDEX(@CodigoDescripcion, p.CUV) > 0
			AND p.CUV NOT IN (
				SELECT CUV
				FROM @tablaCuvOPT
				)
	END
	ELSE
	BEGIN
		SELECT DISTINCT TOP (@RowCount) p.CUV
			,coalesce(est.descripcioncuv2, op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion) AS Descripcion
			,coalesce(est.precio2, op.PrecioOferta, pd.PrecioProducto * pd.FactorRepeticion, p.PrecioUnitario * p.FactorRepeticion) AS PrecioCatalogo
			,p.MarcaID
			,0 AS EstaEnRevista
			,(
				CASE 
					WHEN ISNULL(pf.CUV, 0) = 0
						THEN 1
					WHEN ISNULL(pf.CUV, 0) > 0
						THEN 0
					END
				) AS TieneStock
			,ISNULL(pcc.EsExpoOferta, 0) AS EsExpoOferta
			,ISNULL(pcc.CUVRevista, '') AS CUVRevista
			,'' AS CUVComplemento
			,p.PaisID
			,p.AnoCampania AS CampaniaID
			,p.CodigoCatalago
			,p.CodigoProducto
			,p.IndicadorMontoMinimo
			,M.Descripcion AS DescripcionMarca
			,'NO DISPONIBLE' AS DescripcionCategoria
			,TE.DescripcionEstrategia AS DescripcionEstrategia
			,ISNULL(op.ConfiguracionOfertaID, 0) ConfiguracionOfertaID
			,CASE 
				WHEN EXISTS (
						SELECT 1
						FROM TallaColorLiquidacion
						WHERE CampaniaID = @CampaniaID
							AND CUV = p.CUV
						)
					THEN 1702
				WHEN EXISTS (
						SELECT 1
						FROM TallaColorCUV
						WHERE CampaniaID = @CampaniaID
							AND CUV = p.CUV
						)
					THEN (
							SELECT E.TipoEstrategiaID
							FROM Estrategia E
							INNER JOIN TALLACOLORCUV TCC ON E.CAMPANIAID = TCC.CAMPANIAID
								AND E.CUV2 = TCC.CUVPADRE
							WHERE TCC.CUV = p.CUV
								AND E.CAMPANIAID = @CampaniaID
							)
				ELSE ISNULL(op.TipoOfertaSisID, 0)
				END TipoOfertaSisID
			,ISNULL(te.flagNueva, 0) FlagNueva
			,ISNULL(te.TipoEstrategiaID, '') TipoEstrategiaID
			,P.IndicadorOferta
			,@TieneSugerido AS TieneSugerido
			,CASE 
				WHEN pcor.SAP IS NULL
					THEN 0
				ELSE 1
				END TieneOfertaRevista
			,p.PrecioValorizado
			,CASE 
				WHEN pl.CodigoSAP IS NULL
					THEN 0
				ELSE 1
				END AS TieneLanzamientoCatalogoPersonalizado
			,ISNULL(pcor.Oferta, '') AS TipoOfertaRevista
			,TE.Codigo AS TipoEstrategiaCodigo
			,CASE 
				WHEN (
						TE.MostrarImgOfertaIndependiente = 1
						AND EST.EsOfertaIndependiente = 1
						)
					THEN 1
				ELSE 0
				END AS EsOfertaIndependiente
		FROM ods.ProductoComercial p WITH (NOLOCK)
		LEFT JOIN dbo.ProductoDescripcion pd WITH (NOLOCK) ON p.AnoCampania = pd.CampaniaID
			AND p.CUV = pd.CUV
		LEFT JOIN @ProductoFaltanteTemp pf ON p.CUV = pf.CUV
		LEFT JOIN ProductoComercialConfiguracion pcc WITH (NOLOCK) ON p.AnoCampania = pcc.CampaniaID
			AND p.CUV = pcc.CUV
		LEFT JOIN @OfertaProductoTemp op ON op.CampaniaID = P.CampaniaID
			AND op.CUV = P.CUV
		LEFT JOIN MatrizComercial mc WITH (NOLOCK) ON p.CodigoProducto = mc.CodigoSAP
		LEFT JOIN Estrategia EST WITH (NOLOCK) ON
			--EST.CampaniaID = p.AnoCampania
			(
				EST.CampaniaID = p.AnoCampania
				OR p.AnoCampania BETWEEN EST.CampaniaID
					AND EST.CampaniaIDFin
				)
			AND (
				EST.CUV2 = p.CUV
				OR EST.CUV2 = (
					SELECT CUVPadre
					FROM TallaColorCUV TCC
					WHERE TCC.CUV = p.CUV
					)
				)
			AND EST.Activo = 1
		LEFT JOIN TipoEstrategia TE WITH (NOLOCK) ON TE.TipoEstrategiaID = EST.TipoEstrategiaID
		LEFT JOIN Marca M ON p.MarcaId = M.MarcaId
		LEFT JOIN ods.ProductosLanzamiento pl WITH (NOLOCK) ON p.CodigoProducto = pl.CodigoSAP
			AND p.AnoCampania = pl.Campania
		LEFT JOIN ProductoComercialOfertaRevista pcor WITH (NOLOCK) ON p.AnoCampania = pcor.Campania
			AND p.CUV = pcor.CUV
		WHERE p.AnoCampania = @CampaniaID
			AND p.IndicadorDigitable = 1
			AND CHARINDEX(@CodigoDescripcion, coalesce(op.Descripcion, pd.Descripcion, p.Descripcion)) > 0
			AND p.CUV NOT IN (
				SELECT CUV
				FROM @tablaCuvOPT
				)
	END
END

GO

USE BelcorpMexico
GO

GO

IF (OBJECT_ID('[dbo].[GetProductoComercialByCampaniaBySearchRegionZona_SB2]', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE [dbo].[GetProductoComercialByCampaniaBySearchRegionZona_SB2] AS SET NOCOUNT ON;')
GO

ALTER PROCEDURE [dbo].[GetProductoComercialByCampaniaBySearchRegionZona_SB2] @CampaniaID INT
	,@RowCount INT
	,@Criterio INT
	,@CodigoDescripcion VARCHAR(100)
	,@RegionID INT
	,@ZonaID INT
	,@CodigoRegion VARCHAR(10)
	,@CodigoZona VARCHAR(10)
	,@ValidarOPT BIT = 0
AS
/*
dbo.GetProductoComercialByCampaniaBySearchRegionZona_SB2 201618,1,1,'97010',2701,2161,'50','5052'
dbo.GetProductoComercialByCampaniaBySearchRegionZona_SB2 201618,1,1,'97010',2701,2161,'50','5052',1
*/
BEGIN
	-- Depuramos las tallas y colores
	EXEC DepurarTallaColorCUV @CampaniaID

	EXEC DepurarTallaColorLiquidacion @CampaniaID

	DECLARE @OfertaProductoTemp TABLE (
		CampaniaID INT
		,CUV VARCHAR(6)
		,Descripcion VARCHAR(250)
		,ConfiguracionOfertaID INT
		,TipoOfertaSisID INT
		,PrecioOferta NUMERIC(12, 2)
		)

	INSERT INTO @OfertaProductoTemp
	SELECT op.CampaniaID
		,op.CUV
		,op.Descripcion
		,op.ConfiguracionOfertaID
		,op.TipoOfertaSisID
		,NULL
	FROM OfertaProducto op WITH (NOLOCK)
	INNER JOIN ods.Campania c ON op.CampaniaID = c.CampaniaID
	WHERE c.codigo = @CampaniaID

	INSERT INTO @OfertaProductoTemp
	SELECT c.CampaniaID
		,e.CUV2 AS CUV
		,e.DescripcionCUV2 AS Descripcion
		,ves.ConfiguracionOfertaID
		,ves.TipoOfertaSisID
		,NULL
	FROM dbo.Estrategia e WITH (NOLOCK)
	INNER JOIN ods.Campania c ON e.CampaniaID = c.Codigo
	INNER JOIN vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE c.codigo = @CampaniaID

	DECLARE @ProductoFaltanteTemp TABLE (CUV VARCHAR(6))

	INSERT INTO @ProductoFaltanteTemp
	SELECT DISTINCT ltrim(rtrim(CUV))
	FROM dbo.ProductoFaltante NOLOCK
	WHERE CampaniaID = @CampaniaID
		AND Zonaid = @ZonaID
	
	UNION ALL
	
	SELECT DISTINCT ltrim(rtrim(fa.CodigoVenta)) AS CUV
	FROM ods.FaltanteAnunciado fa(NOLOCK)
	INNER JOIN ods.Campania c(NOLOCK) ON fa.CampaniaID = c.CampaniaID
	WHERE c.Codigo = @CampaniaID
		AND (
			rtrim(fa.CodigoRegion) = @CodigoRegion
			OR fa.CodigoRegion IS NULL
			)
		AND (
			rtrim(fa.CodigoZona) = @CodigoZona
			OR fa.CodigoZona IS NULL
			)

	--Logica para Producto Sugerido
	DECLARE @TieneSugerido INT = 0

	IF EXISTS (
			SELECT 1
			FROM dbo.ProductoSugerido
			WHERE CampaniaID = @CampaniaID
				AND CUV = @CodigoDescripcion
				AND Estado = 1
			)
	BEGIN
		SET @TieneSugerido = 1
	END

	DECLARE @tablaCuvOPT TABLE (CUV VARCHAR(6))

	IF (@Criterio = 1)
	BEGIN
		SELECT DISTINCT TOP (@RowCount) p.CUV
			,coalesce(EST.DescripcionCUV2 + ' ' + tcc.Descripcion, est.descripcioncuv2, op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion) AS Descripcion
			,coalesce(est.precio2, op.PrecioOferta, pd.PrecioProducto * pd.FactorRepeticion, p.PrecioUnitario * p.FactorRepeticion) AS PrecioCatalogo
			,p.MarcaID
			,0 AS EstaEnRevista
			,(
				CASE 
					WHEN ISNULL(pf.CUV, 0) = 0
						THEN 1
					WHEN ISNULL(pf.CUV, 0) > 0
						THEN 0
					END
				) AS TieneStock
			,ISNULL(pcc.EsExpoOferta, 0) AS EsExpoOferta
			,ISNULL(pcc.CUVRevista, '') AS CUVRevista
			,'' AS CUVComplemento
			,p.PaisID
			,p.AnoCampania AS CampaniaID
			,p.CodigoCatalago
			,p.CodigoProducto
			,p.IndicadorMontoMinimo
			,M.Descripcion AS DescripcionMarca
			,'NO DISPONIBLE' AS DescripcionCategoria
			,TE.DescripcionEstrategia AS DescripcionEstrategia
			,ISNULL(op.ConfiguracionOfertaID, 0) ConfiguracionOfertaID
			,CASE 
				WHEN EXISTS (
						SELECT 1
						FROM TallaColorLiquidacion
						WHERE CampaniaID = @CampaniaID
							AND CUV = p.CUV
						)
					THEN 1702
				WHEN EXISTS (
						SELECT 1
						FROM TallaColorCUV
						WHERE CampaniaID = @CampaniaID
							AND CUV = p.CUV
						)
					THEN (
							SELECT E.TipoEstrategiaID
							FROM Estrategia E
							INNER JOIN TALLACOLORCUV TCC ON E.CAMPANIAID = TCC.CAMPANIAID
								AND E.CUV2 = TCC.CUVPADRE
							WHERE TCC.CUV = p.CUV
								AND E.CAMPANIAID = @CampaniaID
							)
				ELSE ISNULL(op.TipoOfertaSisID, 0)
				END TipoOfertaSisID
			,ISNULL(te.flagNueva, 0) FlagNueva
			,ISNULL(te.TipoEstrategiaID, '') TipoEstrategiaID
			,P.IndicadorOferta
			,@TieneSugerido AS TieneSugerido
			,CASE 
				WHEN pcor.SAP IS NULL
					THEN 0
				ELSE 1
				END TieneOfertaRevista
			,p.PrecioValorizado
			,CASE 
				WHEN pl.CodigoSAP IS NULL
					THEN 0
				ELSE 1
				END AS TieneLanzamientoCatalogoPersonalizado
			,ISNULL(pcor.Oferta, '') AS TipoOfertaRevista
			,TE.Codigo AS TipoEstrategiaCodigo
			,CASE 
				WHEN (
						TE.MostrarImgOfertaIndependiente = 1
						AND EST.EsOfertaIndependiente = 1
						)
					THEN 1
				ELSE 0
				END AS EsOfertaIndependiente
		FROM ods.ProductoComercial p WITH (NOLOCK)
		LEFT JOIN dbo.ProductoDescripcion pd WITH (NOLOCK) ON p.AnoCampania = pd.CampaniaID
			AND p.CUV = pd.CUV
		LEFT JOIN @ProductoFaltanteTemp pf ON p.CUV = pf.CUV
		LEFT JOIN ProductoComercialConfiguracion pcc ON p.AnoCampania = pcc.CampaniaID
			AND p.CUV = pcc.CUV
		LEFT JOIN @OfertaProductoTemp op ON op.CampaniaID = P.CampaniaID
			AND op.CUV = P.CUV
		LEFT JOIN MatrizComercial mc WITH (NOLOCK) ON p.CodigoProducto = mc.CodigoSAP
		LEFT JOIN Estrategia EST WITH (NOLOCK) ON
			--EST.CampaniaID = p.AnoCampania
			(
				EST.CampaniaID = p.AnoCampania
				OR p.AnoCampania BETWEEN EST.CampaniaID
					AND EST.CampaniaIDFin
				)
			AND (
				EST.CUV2 = p.CUV
				OR EST.CUV2 = (
					SELECT CUVPadre
					FROM TallaColorCUV TCC
					WHERE TCC.CUV = p.CUV
					)
				)
			AND EST.Activo = 1
		LEFT JOIN dbo.TallaColorCUV tcc WITH (NOLOCK) ON tcc.CUV = p.CUV
			AND tcc.CampaniaID = p.AnoCampania
		LEFT JOIN TipoEstrategia TE WITH (NOLOCK) ON TE.TipoEstrategiaID = EST.TipoEstrategiaID
		LEFT JOIN Marca M WITH (NOLOCK) ON p.MarcaId = M.MarcaId
		LEFT JOIN ods.ProductosLanzamiento pl WITH (NOLOCK) ON p.CodigoProducto = pl.CodigoSAP
			AND p.AnoCampania = pl.Campania
		LEFT JOIN ProductoComercialOfertaRevista pcor WITH (NOLOCK) ON p.AnoCampania = pcor.Campania
			AND p.CUV = pcor.CUV
		WHERE p.AnoCampania = @CampaniaID
			AND p.IndicadorDigitable = 1
			AND CHARINDEX(@CodigoDescripcion, p.CUV) > 0
			AND p.CUV NOT IN (
				SELECT CUV
				FROM @tablaCuvOPT
				)
	END
	ELSE
	BEGIN
		SELECT DISTINCT TOP (@RowCount) p.CUV
			,coalesce(est.descripcioncuv2, op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion) AS Descripcion
			,coalesce(est.precio2, op.PrecioOferta, pd.PrecioProducto * pd.FactorRepeticion, p.PrecioUnitario * p.FactorRepeticion) AS PrecioCatalogo
			,p.MarcaID
			,0 AS EstaEnRevista
			,(
				CASE 
					WHEN ISNULL(pf.CUV, 0) = 0
						THEN 1
					WHEN ISNULL(pf.CUV, 0) > 0
						THEN 0
					END
				) AS TieneStock
			,ISNULL(pcc.EsExpoOferta, 0) AS EsExpoOferta
			,ISNULL(pcc.CUVRevista, '') AS CUVRevista
			,'' AS CUVComplemento
			,p.PaisID
			,p.AnoCampania AS CampaniaID
			,p.CodigoCatalago
			,p.CodigoProducto
			,p.IndicadorMontoMinimo
			,M.Descripcion AS DescripcionMarca
			,'NO DISPONIBLE' AS DescripcionCategoria
			,TE.DescripcionEstrategia AS DescripcionEstrategia
			,ISNULL(op.ConfiguracionOfertaID, 0) ConfiguracionOfertaID
			,CASE 
				WHEN EXISTS (
						SELECT 1
						FROM TallaColorLiquidacion
						WHERE CampaniaID = @CampaniaID
							AND CUV = p.CUV
						)
					THEN 1702
				WHEN EXISTS (
						SELECT 1
						FROM TallaColorCUV
						WHERE CampaniaID = @CampaniaID
							AND CUV = p.CUV
						)
					THEN (
							SELECT E.TipoEstrategiaID
							FROM Estrategia E
							INNER JOIN TALLACOLORCUV TCC ON E.CAMPANIAID = TCC.CAMPANIAID
								AND E.CUV2 = TCC.CUVPADRE
							WHERE TCC.CUV = p.CUV
								AND E.CAMPANIAID = @CampaniaID
							)
				ELSE ISNULL(op.TipoOfertaSisID, 0)
				END TipoOfertaSisID
			,ISNULL(te.flagNueva, 0) FlagNueva
			,ISNULL(te.TipoEstrategiaID, '') TipoEstrategiaID
			,P.IndicadorOferta
			,@TieneSugerido AS TieneSugerido
			,CASE 
				WHEN pcor.SAP IS NULL
					THEN 0
				ELSE 1
				END TieneOfertaRevista
			,p.PrecioValorizado
			,CASE 
				WHEN pl.CodigoSAP IS NULL
					THEN 0
				ELSE 1
				END AS TieneLanzamientoCatalogoPersonalizado
			,ISNULL(pcor.Oferta, '') AS TipoOfertaRevista
			,TE.Codigo AS TipoEstrategiaCodigo
			,CASE 
				WHEN (
						TE.MostrarImgOfertaIndependiente = 1
						AND EST.EsOfertaIndependiente = 1
						)
					THEN 1
				ELSE 0
				END AS EsOfertaIndependiente
		FROM ods.ProductoComercial p WITH (NOLOCK)
		LEFT JOIN dbo.ProductoDescripcion pd WITH (NOLOCK) ON p.AnoCampania = pd.CampaniaID
			AND p.CUV = pd.CUV
		LEFT JOIN @ProductoFaltanteTemp pf ON p.CUV = pf.CUV
		LEFT JOIN ProductoComercialConfiguracion pcc WITH (NOLOCK) ON p.AnoCampania = pcc.CampaniaID
			AND p.CUV = pcc.CUV
		LEFT JOIN @OfertaProductoTemp op ON op.CampaniaID = P.CampaniaID
			AND op.CUV = P.CUV
		LEFT JOIN MatrizComercial mc WITH (NOLOCK) ON p.CodigoProducto = mc.CodigoSAP
		LEFT JOIN Estrategia EST WITH (NOLOCK) ON
			--EST.CampaniaID = p.AnoCampania
			(
				EST.CampaniaID = p.AnoCampania
				OR p.AnoCampania BETWEEN EST.CampaniaID
					AND EST.CampaniaIDFin
				)
			AND (
				EST.CUV2 = p.CUV
				OR EST.CUV2 = (
					SELECT CUVPadre
					FROM TallaColorCUV TCC
					WHERE TCC.CUV = p.CUV
					)
				)
			AND EST.Activo = 1
		LEFT JOIN TipoEstrategia TE WITH (NOLOCK) ON TE.TipoEstrategiaID = EST.TipoEstrategiaID
		LEFT JOIN Marca M ON p.MarcaId = M.MarcaId
		LEFT JOIN ods.ProductosLanzamiento pl WITH (NOLOCK) ON p.CodigoProducto = pl.CodigoSAP
			AND p.AnoCampania = pl.Campania
		LEFT JOIN ProductoComercialOfertaRevista pcor WITH (NOLOCK) ON p.AnoCampania = pcor.Campania
			AND p.CUV = pcor.CUV
		WHERE p.AnoCampania = @CampaniaID
			AND p.IndicadorDigitable = 1
			AND CHARINDEX(@CodigoDescripcion, coalesce(op.Descripcion, pd.Descripcion, p.Descripcion)) > 0
			AND p.CUV NOT IN (
				SELECT CUV
				FROM @tablaCuvOPT
				)
	END
END

GO

USE BelcorpColombia
GO

GO

IF (OBJECT_ID('[dbo].[GetProductoComercialByCampaniaBySearchRegionZona_SB2]', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE [dbo].[GetProductoComercialByCampaniaBySearchRegionZona_SB2] AS SET NOCOUNT ON;')
GO

ALTER PROCEDURE [dbo].[GetProductoComercialByCampaniaBySearchRegionZona_SB2] @CampaniaID INT
	,@RowCount INT
	,@Criterio INT
	,@CodigoDescripcion VARCHAR(100)
	,@RegionID INT
	,@ZonaID INT
	,@CodigoRegion VARCHAR(10)
	,@CodigoZona VARCHAR(10)
	,@ValidarOPT BIT = 0
AS
/*
dbo.GetProductoComercialByCampaniaBySearchRegionZona_SB2 201618,1,1,'97010',2701,2161,'50','5052'
dbo.GetProductoComercialByCampaniaBySearchRegionZona_SB2 201618,1,1,'97010',2701,2161,'50','5052',1
*/
BEGIN
	-- Depuramos las tallas y colores
	EXEC DepurarTallaColorCUV @CampaniaID

	EXEC DepurarTallaColorLiquidacion @CampaniaID

	DECLARE @OfertaProductoTemp TABLE (
		CampaniaID INT
		,CUV VARCHAR(6)
		,Descripcion VARCHAR(250)
		,ConfiguracionOfertaID INT
		,TipoOfertaSisID INT
		,PrecioOferta NUMERIC(12, 2)
		)

	INSERT INTO @OfertaProductoTemp
	SELECT op.CampaniaID
		,op.CUV
		,op.Descripcion
		,op.ConfiguracionOfertaID
		,op.TipoOfertaSisID
		,NULL
	FROM OfertaProducto op WITH (NOLOCK)
	INNER JOIN ods.Campania c ON op.CampaniaID = c.CampaniaID
	WHERE c.codigo = @CampaniaID

	INSERT INTO @OfertaProductoTemp
	SELECT c.CampaniaID
		,e.CUV2 AS CUV
		,e.DescripcionCUV2 AS Descripcion
		,ves.ConfiguracionOfertaID
		,ves.TipoOfertaSisID
		,NULL
	FROM dbo.Estrategia e WITH (NOLOCK)
	INNER JOIN ods.Campania c ON e.CampaniaID = c.Codigo
	INNER JOIN vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE c.codigo = @CampaniaID

	DECLARE @ProductoFaltanteTemp TABLE (CUV VARCHAR(6))

	INSERT INTO @ProductoFaltanteTemp
	SELECT DISTINCT ltrim(rtrim(CUV))
	FROM dbo.ProductoFaltante NOLOCK
	WHERE CampaniaID = @CampaniaID
		AND Zonaid = @ZonaID
	
	UNION ALL
	
	SELECT DISTINCT ltrim(rtrim(fa.CodigoVenta)) AS CUV
	FROM ods.FaltanteAnunciado fa(NOLOCK)
	INNER JOIN ods.Campania c(NOLOCK) ON fa.CampaniaID = c.CampaniaID
	WHERE c.Codigo = @CampaniaID
		AND (
			rtrim(fa.CodigoRegion) = @CodigoRegion
			OR fa.CodigoRegion IS NULL
			)
		AND (
			rtrim(fa.CodigoZona) = @CodigoZona
			OR fa.CodigoZona IS NULL
			)

	--Logica para Producto Sugerido
	DECLARE @TieneSugerido INT = 0

	IF EXISTS (
			SELECT 1
			FROM dbo.ProductoSugerido
			WHERE CampaniaID = @CampaniaID
				AND CUV = @CodigoDescripcion
				AND Estado = 1
			)
	BEGIN
		SET @TieneSugerido = 1
	END

	DECLARE @tablaCuvOPT TABLE (CUV VARCHAR(6))

	IF (@Criterio = 1)
	BEGIN
		SELECT DISTINCT TOP (@RowCount) p.CUV
			,coalesce(EST.DescripcionCUV2 + ' ' + tcc.Descripcion, est.descripcioncuv2, op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion) AS Descripcion
			,coalesce(est.precio2, op.PrecioOferta, pd.PrecioProducto * pd.FactorRepeticion, p.PrecioUnitario * p.FactorRepeticion) AS PrecioCatalogo
			,p.MarcaID
			,0 AS EstaEnRevista
			,(
				CASE 
					WHEN ISNULL(pf.CUV, 0) = 0
						THEN 1
					WHEN ISNULL(pf.CUV, 0) > 0
						THEN 0
					END
				) AS TieneStock
			,ISNULL(pcc.EsExpoOferta, 0) AS EsExpoOferta
			,ISNULL(pcc.CUVRevista, '') AS CUVRevista
			,'' AS CUVComplemento
			,p.PaisID
			,p.AnoCampania AS CampaniaID
			,p.CodigoCatalago
			,p.CodigoProducto
			,p.IndicadorMontoMinimo
			,M.Descripcion AS DescripcionMarca
			,'NO DISPONIBLE' AS DescripcionCategoria
			,TE.DescripcionEstrategia AS DescripcionEstrategia
			,ISNULL(op.ConfiguracionOfertaID, 0) ConfiguracionOfertaID
			,CASE 
				WHEN EXISTS (
						SELECT 1
						FROM TallaColorLiquidacion
						WHERE CampaniaID = @CampaniaID
							AND CUV = p.CUV
						)
					THEN 1702
				WHEN EXISTS (
						SELECT 1
						FROM TallaColorCUV
						WHERE CampaniaID = @CampaniaID
							AND CUV = p.CUV
						)
					THEN (
							SELECT E.TipoEstrategiaID
							FROM Estrategia E
							INNER JOIN TALLACOLORCUV TCC ON E.CAMPANIAID = TCC.CAMPANIAID
								AND E.CUV2 = TCC.CUVPADRE
							WHERE TCC.CUV = p.CUV
								AND E.CAMPANIAID = @CampaniaID
							)
				ELSE ISNULL(op.TipoOfertaSisID, 0)
				END TipoOfertaSisID
			,ISNULL(te.flagNueva, 0) FlagNueva
			,ISNULL(te.TipoEstrategiaID, '') TipoEstrategiaID
			,P.IndicadorOferta
			,@TieneSugerido AS TieneSugerido
			,CASE 
				WHEN pcor.SAP IS NULL
					THEN 0
				ELSE 1
				END TieneOfertaRevista
			,p.PrecioValorizado
			,CASE 
				WHEN pl.CodigoSAP IS NULL
					THEN 0
				ELSE 1
				END AS TieneLanzamientoCatalogoPersonalizado
			,ISNULL(pcor.Oferta, '') AS TipoOfertaRevista
			,TE.Codigo AS TipoEstrategiaCodigo
			,CASE 
				WHEN (
						TE.MostrarImgOfertaIndependiente = 1
						AND EST.EsOfertaIndependiente = 1
						)
					THEN 1
				ELSE 0
				END AS EsOfertaIndependiente
		FROM ods.ProductoComercial p WITH (NOLOCK)
		LEFT JOIN dbo.ProductoDescripcion pd WITH (NOLOCK) ON p.AnoCampania = pd.CampaniaID
			AND p.CUV = pd.CUV
		LEFT JOIN @ProductoFaltanteTemp pf ON p.CUV = pf.CUV
		LEFT JOIN ProductoComercialConfiguracion pcc ON p.AnoCampania = pcc.CampaniaID
			AND p.CUV = pcc.CUV
		LEFT JOIN @OfertaProductoTemp op ON op.CampaniaID = P.CampaniaID
			AND op.CUV = P.CUV
		LEFT JOIN MatrizComercial mc WITH (NOLOCK) ON p.CodigoProducto = mc.CodigoSAP
		LEFT JOIN Estrategia EST WITH (NOLOCK) ON
			--EST.CampaniaID = p.AnoCampania
			(
				EST.CampaniaID = p.AnoCampania
				OR p.AnoCampania BETWEEN EST.CampaniaID
					AND EST.CampaniaIDFin
				)
			AND (
				EST.CUV2 = p.CUV
				OR EST.CUV2 = (
					SELECT CUVPadre
					FROM TallaColorCUV TCC
					WHERE TCC.CUV = p.CUV
					)
				)
			AND EST.Activo = 1
		LEFT JOIN dbo.TallaColorCUV tcc WITH (NOLOCK) ON tcc.CUV = p.CUV
			AND tcc.CampaniaID = p.AnoCampania
		LEFT JOIN TipoEstrategia TE WITH (NOLOCK) ON TE.TipoEstrategiaID = EST.TipoEstrategiaID
		LEFT JOIN Marca M WITH (NOLOCK) ON p.MarcaId = M.MarcaId
		LEFT JOIN ods.ProductosLanzamiento pl WITH (NOLOCK) ON p.CodigoProducto = pl.CodigoSAP
			AND p.AnoCampania = pl.Campania
		LEFT JOIN ProductoComercialOfertaRevista pcor WITH (NOLOCK) ON p.AnoCampania = pcor.Campania
			AND p.CUV = pcor.CUV
		WHERE p.AnoCampania = @CampaniaID
			AND p.IndicadorDigitable = 1
			AND CHARINDEX(@CodigoDescripcion, p.CUV) > 0
			AND p.CUV NOT IN (
				SELECT CUV
				FROM @tablaCuvOPT
				)
	END
	ELSE
	BEGIN
		SELECT DISTINCT TOP (@RowCount) p.CUV
			,coalesce(est.descripcioncuv2, op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion) AS Descripcion
			,coalesce(est.precio2, op.PrecioOferta, pd.PrecioProducto * pd.FactorRepeticion, p.PrecioUnitario * p.FactorRepeticion) AS PrecioCatalogo
			,p.MarcaID
			,0 AS EstaEnRevista
			,(
				CASE 
					WHEN ISNULL(pf.CUV, 0) = 0
						THEN 1
					WHEN ISNULL(pf.CUV, 0) > 0
						THEN 0
					END
				) AS TieneStock
			,ISNULL(pcc.EsExpoOferta, 0) AS EsExpoOferta
			,ISNULL(pcc.CUVRevista, '') AS CUVRevista
			,'' AS CUVComplemento
			,p.PaisID
			,p.AnoCampania AS CampaniaID
			,p.CodigoCatalago
			,p.CodigoProducto
			,p.IndicadorMontoMinimo
			,M.Descripcion AS DescripcionMarca
			,'NO DISPONIBLE' AS DescripcionCategoria
			,TE.DescripcionEstrategia AS DescripcionEstrategia
			,ISNULL(op.ConfiguracionOfertaID, 0) ConfiguracionOfertaID
			,CASE 
				WHEN EXISTS (
						SELECT 1
						FROM TallaColorLiquidacion
						WHERE CampaniaID = @CampaniaID
							AND CUV = p.CUV
						)
					THEN 1702
				WHEN EXISTS (
						SELECT 1
						FROM TallaColorCUV
						WHERE CampaniaID = @CampaniaID
							AND CUV = p.CUV
						)
					THEN (
							SELECT E.TipoEstrategiaID
							FROM Estrategia E
							INNER JOIN TALLACOLORCUV TCC ON E.CAMPANIAID = TCC.CAMPANIAID
								AND E.CUV2 = TCC.CUVPADRE
							WHERE TCC.CUV = p.CUV
								AND E.CAMPANIAID = @CampaniaID
							)
				ELSE ISNULL(op.TipoOfertaSisID, 0)
				END TipoOfertaSisID
			,ISNULL(te.flagNueva, 0) FlagNueva
			,ISNULL(te.TipoEstrategiaID, '') TipoEstrategiaID
			,P.IndicadorOferta
			,@TieneSugerido AS TieneSugerido
			,CASE 
				WHEN pcor.SAP IS NULL
					THEN 0
				ELSE 1
				END TieneOfertaRevista
			,p.PrecioValorizado
			,CASE 
				WHEN pl.CodigoSAP IS NULL
					THEN 0
				ELSE 1
				END AS TieneLanzamientoCatalogoPersonalizado
			,ISNULL(pcor.Oferta, '') AS TipoOfertaRevista
			,TE.Codigo AS TipoEstrategiaCodigo
			,CASE 
				WHEN (
						TE.MostrarImgOfertaIndependiente = 1
						AND EST.EsOfertaIndependiente = 1
						)
					THEN 1
				ELSE 0
				END AS EsOfertaIndependiente
		FROM ods.ProductoComercial p WITH (NOLOCK)
		LEFT JOIN dbo.ProductoDescripcion pd WITH (NOLOCK) ON p.AnoCampania = pd.CampaniaID
			AND p.CUV = pd.CUV
		LEFT JOIN @ProductoFaltanteTemp pf ON p.CUV = pf.CUV
		LEFT JOIN ProductoComercialConfiguracion pcc WITH (NOLOCK) ON p.AnoCampania = pcc.CampaniaID
			AND p.CUV = pcc.CUV
		LEFT JOIN @OfertaProductoTemp op ON op.CampaniaID = P.CampaniaID
			AND op.CUV = P.CUV
		LEFT JOIN MatrizComercial mc WITH (NOLOCK) ON p.CodigoProducto = mc.CodigoSAP
		LEFT JOIN Estrategia EST WITH (NOLOCK) ON
			--EST.CampaniaID = p.AnoCampania
			(
				EST.CampaniaID = p.AnoCampania
				OR p.AnoCampania BETWEEN EST.CampaniaID
					AND EST.CampaniaIDFin
				)
			AND (
				EST.CUV2 = p.CUV
				OR EST.CUV2 = (
					SELECT CUVPadre
					FROM TallaColorCUV TCC
					WHERE TCC.CUV = p.CUV
					)
				)
			AND EST.Activo = 1
		LEFT JOIN TipoEstrategia TE WITH (NOLOCK) ON TE.TipoEstrategiaID = EST.TipoEstrategiaID
		LEFT JOIN Marca M ON p.MarcaId = M.MarcaId
		LEFT JOIN ods.ProductosLanzamiento pl WITH (NOLOCK) ON p.CodigoProducto = pl.CodigoSAP
			AND p.AnoCampania = pl.Campania
		LEFT JOIN ProductoComercialOfertaRevista pcor WITH (NOLOCK) ON p.AnoCampania = pcor.Campania
			AND p.CUV = pcor.CUV
		WHERE p.AnoCampania = @CampaniaID
			AND p.IndicadorDigitable = 1
			AND CHARINDEX(@CodigoDescripcion, coalesce(op.Descripcion, pd.Descripcion, p.Descripcion)) > 0
			AND p.CUV NOT IN (
				SELECT CUV
				FROM @tablaCuvOPT
				)
	END
END

GO

USE BelcorpVenezuela
GO

GO

IF (OBJECT_ID('[dbo].[GetProductoComercialByCampaniaBySearchRegionZona_SB2]', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE [dbo].[GetProductoComercialByCampaniaBySearchRegionZona_SB2] AS SET NOCOUNT ON;')
GO

ALTER PROCEDURE [dbo].[GetProductoComercialByCampaniaBySearchRegionZona_SB2] @CampaniaID INT
	,@RowCount INT
	,@Criterio INT
	,@CodigoDescripcion VARCHAR(100)
	,@RegionID INT
	,@ZonaID INT
	,@CodigoRegion VARCHAR(10)
	,@CodigoZona VARCHAR(10)
	,@ValidarOPT BIT = 0
AS
/*
dbo.GetProductoComercialByCampaniaBySearchRegionZona_SB2 201618,1,1,'97010',2701,2161,'50','5052'
dbo.GetProductoComercialByCampaniaBySearchRegionZona_SB2 201618,1,1,'97010',2701,2161,'50','5052',1
*/
BEGIN
	-- Depuramos las tallas y colores
	EXEC DepurarTallaColorCUV @CampaniaID

	EXEC DepurarTallaColorLiquidacion @CampaniaID

	DECLARE @OfertaProductoTemp TABLE (
		CampaniaID INT
		,CUV VARCHAR(6)
		,Descripcion VARCHAR(250)
		,ConfiguracionOfertaID INT
		,TipoOfertaSisID INT
		,PrecioOferta NUMERIC(12, 2)
		)

	INSERT INTO @OfertaProductoTemp
	SELECT op.CampaniaID
		,op.CUV
		,op.Descripcion
		,op.ConfiguracionOfertaID
		,op.TipoOfertaSisID
		,NULL
	FROM OfertaProducto op WITH (NOLOCK)
	INNER JOIN ods.Campania c ON op.CampaniaID = c.CampaniaID
	WHERE c.codigo = @CampaniaID

	INSERT INTO @OfertaProductoTemp
	SELECT c.CampaniaID
		,e.CUV2 AS CUV
		,e.DescripcionCUV2 AS Descripcion
		,ves.ConfiguracionOfertaID
		,ves.TipoOfertaSisID
		,NULL
	FROM dbo.Estrategia e WITH (NOLOCK)
	INNER JOIN ods.Campania c ON e.CampaniaID = c.Codigo
	INNER JOIN vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE c.codigo = @CampaniaID

	DECLARE @ProductoFaltanteTemp TABLE (CUV VARCHAR(6))

	INSERT INTO @ProductoFaltanteTemp
	SELECT DISTINCT ltrim(rtrim(CUV))
	FROM dbo.ProductoFaltante NOLOCK
	WHERE CampaniaID = @CampaniaID
		AND Zonaid = @ZonaID
	
	UNION ALL
	
	SELECT DISTINCT ltrim(rtrim(fa.CodigoVenta)) AS CUV
	FROM ods.FaltanteAnunciado fa(NOLOCK)
	INNER JOIN ods.Campania c(NOLOCK) ON fa.CampaniaID = c.CampaniaID
	WHERE c.Codigo = @CampaniaID
		AND (
			rtrim(fa.CodigoRegion) = @CodigoRegion
			OR fa.CodigoRegion IS NULL
			)
		AND (
			rtrim(fa.CodigoZona) = @CodigoZona
			OR fa.CodigoZona IS NULL
			)

	--Logica para Producto Sugerido
	DECLARE @TieneSugerido INT = 0

	IF EXISTS (
			SELECT 1
			FROM dbo.ProductoSugerido
			WHERE CampaniaID = @CampaniaID
				AND CUV = @CodigoDescripcion
				AND Estado = 1
			)
	BEGIN
		SET @TieneSugerido = 1
	END

	DECLARE @tablaCuvOPT TABLE (CUV VARCHAR(6))

	IF (@Criterio = 1)
	BEGIN
		SELECT DISTINCT TOP (@RowCount) p.CUV
			,coalesce(EST.DescripcionCUV2 + ' ' + tcc.Descripcion, est.descripcioncuv2, op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion) AS Descripcion
			,coalesce(est.precio2, op.PrecioOferta, pd.PrecioProducto * pd.FactorRepeticion, p.PrecioUnitario * p.FactorRepeticion) AS PrecioCatalogo
			,p.MarcaID
			,0 AS EstaEnRevista
			,(
				CASE 
					WHEN ISNULL(pf.CUV, 0) = 0
						THEN 1
					WHEN ISNULL(pf.CUV, 0) > 0
						THEN 0
					END
				) AS TieneStock
			,ISNULL(pcc.EsExpoOferta, 0) AS EsExpoOferta
			,ISNULL(pcc.CUVRevista, '') AS CUVRevista
			,'' AS CUVComplemento
			,p.PaisID
			,p.AnoCampania AS CampaniaID
			,p.CodigoCatalago
			,p.CodigoProducto
			,p.IndicadorMontoMinimo
			,M.Descripcion AS DescripcionMarca
			,'NO DISPONIBLE' AS DescripcionCategoria
			,TE.DescripcionEstrategia AS DescripcionEstrategia
			,ISNULL(op.ConfiguracionOfertaID, 0) ConfiguracionOfertaID
			,CASE 
				WHEN EXISTS (
						SELECT 1
						FROM TallaColorLiquidacion
						WHERE CampaniaID = @CampaniaID
							AND CUV = p.CUV
						)
					THEN 1702
				WHEN EXISTS (
						SELECT 1
						FROM TallaColorCUV
						WHERE CampaniaID = @CampaniaID
							AND CUV = p.CUV
						)
					THEN (
							SELECT E.TipoEstrategiaID
							FROM Estrategia E
							INNER JOIN TALLACOLORCUV TCC ON E.CAMPANIAID = TCC.CAMPANIAID
								AND E.CUV2 = TCC.CUVPADRE
							WHERE TCC.CUV = p.CUV
								AND E.CAMPANIAID = @CampaniaID
							)
				ELSE ISNULL(op.TipoOfertaSisID, 0)
				END TipoOfertaSisID
			,ISNULL(te.flagNueva, 0) FlagNueva
			,ISNULL(te.TipoEstrategiaID, '') TipoEstrategiaID
			,P.IndicadorOferta
			,@TieneSugerido AS TieneSugerido
			,CASE 
				WHEN pcor.SAP IS NULL
					THEN 0
				ELSE 1
				END TieneOfertaRevista
			,p.PrecioValorizado
			,CASE 
				WHEN pl.CodigoSAP IS NULL
					THEN 0
				ELSE 1
				END AS TieneLanzamientoCatalogoPersonalizado
			,ISNULL(pcor.Oferta, '') AS TipoOfertaRevista
			,TE.Codigo AS TipoEstrategiaCodigo
			,CASE 
				WHEN (
						TE.MostrarImgOfertaIndependiente = 1
						AND EST.EsOfertaIndependiente = 1
						)
					THEN 1
				ELSE 0
				END AS EsOfertaIndependiente
		FROM ods.ProductoComercial p WITH (NOLOCK)
		LEFT JOIN dbo.ProductoDescripcion pd WITH (NOLOCK) ON p.AnoCampania = pd.CampaniaID
			AND p.CUV = pd.CUV
		LEFT JOIN @ProductoFaltanteTemp pf ON p.CUV = pf.CUV
		LEFT JOIN ProductoComercialConfiguracion pcc ON p.AnoCampania = pcc.CampaniaID
			AND p.CUV = pcc.CUV
		LEFT JOIN @OfertaProductoTemp op ON op.CampaniaID = P.CampaniaID
			AND op.CUV = P.CUV
		LEFT JOIN MatrizComercial mc WITH (NOLOCK) ON p.CodigoProducto = mc.CodigoSAP
		LEFT JOIN Estrategia EST WITH (NOLOCK) ON
			--EST.CampaniaID = p.AnoCampania
			(
				EST.CampaniaID = p.AnoCampania
				OR p.AnoCampania BETWEEN EST.CampaniaID
					AND EST.CampaniaIDFin
				)
			AND (
				EST.CUV2 = p.CUV
				OR EST.CUV2 = (
					SELECT CUVPadre
					FROM TallaColorCUV TCC
					WHERE TCC.CUV = p.CUV
					)
				)
			AND EST.Activo = 1
		LEFT JOIN dbo.TallaColorCUV tcc WITH (NOLOCK) ON tcc.CUV = p.CUV
			AND tcc.CampaniaID = p.AnoCampania
		LEFT JOIN TipoEstrategia TE WITH (NOLOCK) ON TE.TipoEstrategiaID = EST.TipoEstrategiaID
		LEFT JOIN Marca M WITH (NOLOCK) ON p.MarcaId = M.MarcaId
		LEFT JOIN ods.ProductosLanzamiento pl WITH (NOLOCK) ON p.CodigoProducto = pl.CodigoSAP
			AND p.AnoCampania = pl.Campania
		LEFT JOIN ProductoComercialOfertaRevista pcor WITH (NOLOCK) ON p.AnoCampania = pcor.Campania
			AND p.CUV = pcor.CUV
		WHERE p.AnoCampania = @CampaniaID
			AND p.IndicadorDigitable = 1
			AND CHARINDEX(@CodigoDescripcion, p.CUV) > 0
			AND p.CUV NOT IN (
				SELECT CUV
				FROM @tablaCuvOPT
				)
	END
	ELSE
	BEGIN
		SELECT DISTINCT TOP (@RowCount) p.CUV
			,coalesce(est.descripcioncuv2, op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion) AS Descripcion
			,coalesce(est.precio2, op.PrecioOferta, pd.PrecioProducto * pd.FactorRepeticion, p.PrecioUnitario * p.FactorRepeticion) AS PrecioCatalogo
			,p.MarcaID
			,0 AS EstaEnRevista
			,(
				CASE 
					WHEN ISNULL(pf.CUV, 0) = 0
						THEN 1
					WHEN ISNULL(pf.CUV, 0) > 0
						THEN 0
					END
				) AS TieneStock
			,ISNULL(pcc.EsExpoOferta, 0) AS EsExpoOferta
			,ISNULL(pcc.CUVRevista, '') AS CUVRevista
			,'' AS CUVComplemento
			,p.PaisID
			,p.AnoCampania AS CampaniaID
			,p.CodigoCatalago
			,p.CodigoProducto
			,p.IndicadorMontoMinimo
			,M.Descripcion AS DescripcionMarca
			,'NO DISPONIBLE' AS DescripcionCategoria
			,TE.DescripcionEstrategia AS DescripcionEstrategia
			,ISNULL(op.ConfiguracionOfertaID, 0) ConfiguracionOfertaID
			,CASE 
				WHEN EXISTS (
						SELECT 1
						FROM TallaColorLiquidacion
						WHERE CampaniaID = @CampaniaID
							AND CUV = p.CUV
						)
					THEN 1702
				WHEN EXISTS (
						SELECT 1
						FROM TallaColorCUV
						WHERE CampaniaID = @CampaniaID
							AND CUV = p.CUV
						)
					THEN (
							SELECT E.TipoEstrategiaID
							FROM Estrategia E
							INNER JOIN TALLACOLORCUV TCC ON E.CAMPANIAID = TCC.CAMPANIAID
								AND E.CUV2 = TCC.CUVPADRE
							WHERE TCC.CUV = p.CUV
								AND E.CAMPANIAID = @CampaniaID
							)
				ELSE ISNULL(op.TipoOfertaSisID, 0)
				END TipoOfertaSisID
			,ISNULL(te.flagNueva, 0) FlagNueva
			,ISNULL(te.TipoEstrategiaID, '') TipoEstrategiaID
			,P.IndicadorOferta
			,@TieneSugerido AS TieneSugerido
			,CASE 
				WHEN pcor.SAP IS NULL
					THEN 0
				ELSE 1
				END TieneOfertaRevista
			,p.PrecioValorizado
			,CASE 
				WHEN pl.CodigoSAP IS NULL
					THEN 0
				ELSE 1
				END AS TieneLanzamientoCatalogoPersonalizado
			,ISNULL(pcor.Oferta, '') AS TipoOfertaRevista
			,TE.Codigo AS TipoEstrategiaCodigo
			,CASE 
				WHEN (
						TE.MostrarImgOfertaIndependiente = 1
						AND EST.EsOfertaIndependiente = 1
						)
					THEN 1
				ELSE 0
				END AS EsOfertaIndependiente
		FROM ods.ProductoComercial p WITH (NOLOCK)
		LEFT JOIN dbo.ProductoDescripcion pd WITH (NOLOCK) ON p.AnoCampania = pd.CampaniaID
			AND p.CUV = pd.CUV
		LEFT JOIN @ProductoFaltanteTemp pf ON p.CUV = pf.CUV
		LEFT JOIN ProductoComercialConfiguracion pcc WITH (NOLOCK) ON p.AnoCampania = pcc.CampaniaID
			AND p.CUV = pcc.CUV
		LEFT JOIN @OfertaProductoTemp op ON op.CampaniaID = P.CampaniaID
			AND op.CUV = P.CUV
		LEFT JOIN MatrizComercial mc WITH (NOLOCK) ON p.CodigoProducto = mc.CodigoSAP
		LEFT JOIN Estrategia EST WITH (NOLOCK) ON
			--EST.CampaniaID = p.AnoCampania
			(
				EST.CampaniaID = p.AnoCampania
				OR p.AnoCampania BETWEEN EST.CampaniaID
					AND EST.CampaniaIDFin
				)
			AND (
				EST.CUV2 = p.CUV
				OR EST.CUV2 = (
					SELECT CUVPadre
					FROM TallaColorCUV TCC
					WHERE TCC.CUV = p.CUV
					)
				)
			AND EST.Activo = 1
		LEFT JOIN TipoEstrategia TE WITH (NOLOCK) ON TE.TipoEstrategiaID = EST.TipoEstrategiaID
		LEFT JOIN Marca M ON p.MarcaId = M.MarcaId
		LEFT JOIN ods.ProductosLanzamiento pl WITH (NOLOCK) ON p.CodigoProducto = pl.CodigoSAP
			AND p.AnoCampania = pl.Campania
		LEFT JOIN ProductoComercialOfertaRevista pcor WITH (NOLOCK) ON p.AnoCampania = pcor.Campania
			AND p.CUV = pcor.CUV
		WHERE p.AnoCampania = @CampaniaID
			AND p.IndicadorDigitable = 1
			AND CHARINDEX(@CodigoDescripcion, coalesce(op.Descripcion, pd.Descripcion, p.Descripcion)) > 0
			AND p.CUV NOT IN (
				SELECT CUV
				FROM @tablaCuvOPT
				)
	END
END

GO

USE BelcorpSalvador
GO

GO

IF (OBJECT_ID('[dbo].[GetProductoComercialByCampaniaBySearchRegionZona_SB2]', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE [dbo].[GetProductoComercialByCampaniaBySearchRegionZona_SB2] AS SET NOCOUNT ON;')
GO

ALTER PROCEDURE [dbo].[GetProductoComercialByCampaniaBySearchRegionZona_SB2] @CampaniaID INT
	,@RowCount INT
	,@Criterio INT
	,@CodigoDescripcion VARCHAR(100)
	,@RegionID INT
	,@ZonaID INT
	,@CodigoRegion VARCHAR(10)
	,@CodigoZona VARCHAR(10)
	,@ValidarOPT BIT = 0
AS
/*
dbo.GetProductoComercialByCampaniaBySearchRegionZona_SB2 201618,1,1,'97010',2701,2161,'50','5052'
dbo.GetProductoComercialByCampaniaBySearchRegionZona_SB2 201618,1,1,'97010',2701,2161,'50','5052',1
*/
BEGIN
	-- Depuramos las tallas y colores
	EXEC DepurarTallaColorCUV @CampaniaID

	EXEC DepurarTallaColorLiquidacion @CampaniaID

	DECLARE @OfertaProductoTemp TABLE (
		CampaniaID INT
		,CUV VARCHAR(6)
		,Descripcion VARCHAR(250)
		,ConfiguracionOfertaID INT
		,TipoOfertaSisID INT
		,PrecioOferta NUMERIC(12, 2)
		)

	INSERT INTO @OfertaProductoTemp
	SELECT op.CampaniaID
		,op.CUV
		,op.Descripcion
		,op.ConfiguracionOfertaID
		,op.TipoOfertaSisID
		,NULL
	FROM OfertaProducto op WITH (NOLOCK)
	INNER JOIN ods.Campania c ON op.CampaniaID = c.CampaniaID
	WHERE c.codigo = @CampaniaID

	INSERT INTO @OfertaProductoTemp
	SELECT c.CampaniaID
		,e.CUV2 AS CUV
		,e.DescripcionCUV2 AS Descripcion
		,ves.ConfiguracionOfertaID
		,ves.TipoOfertaSisID
		,NULL
	FROM dbo.Estrategia e WITH (NOLOCK)
	INNER JOIN ods.Campania c ON e.CampaniaID = c.Codigo
	INNER JOIN vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE c.codigo = @CampaniaID

	DECLARE @ProductoFaltanteTemp TABLE (CUV VARCHAR(6))

	INSERT INTO @ProductoFaltanteTemp
	SELECT DISTINCT ltrim(rtrim(CUV))
	FROM dbo.ProductoFaltante NOLOCK
	WHERE CampaniaID = @CampaniaID
		AND Zonaid = @ZonaID
	
	UNION ALL
	
	SELECT DISTINCT ltrim(rtrim(fa.CodigoVenta)) AS CUV
	FROM ods.FaltanteAnunciado fa(NOLOCK)
	INNER JOIN ods.Campania c(NOLOCK) ON fa.CampaniaID = c.CampaniaID
	WHERE c.Codigo = @CampaniaID
		AND (
			rtrim(fa.CodigoRegion) = @CodigoRegion
			OR fa.CodigoRegion IS NULL
			)
		AND (
			rtrim(fa.CodigoZona) = @CodigoZona
			OR fa.CodigoZona IS NULL
			)

	--Logica para Producto Sugerido
	DECLARE @TieneSugerido INT = 0

	IF EXISTS (
			SELECT 1
			FROM dbo.ProductoSugerido
			WHERE CampaniaID = @CampaniaID
				AND CUV = @CodigoDescripcion
				AND Estado = 1
			)
	BEGIN
		SET @TieneSugerido = 1
	END

	DECLARE @tablaCuvOPT TABLE (CUV VARCHAR(6))

	IF (@Criterio = 1)
	BEGIN
		SELECT DISTINCT TOP (@RowCount) p.CUV
			,coalesce(EST.DescripcionCUV2 + ' ' + tcc.Descripcion, est.descripcioncuv2, op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion) AS Descripcion
			,coalesce(est.precio2, op.PrecioOferta, pd.PrecioProducto * pd.FactorRepeticion, p.PrecioUnitario * p.FactorRepeticion) AS PrecioCatalogo
			,p.MarcaID
			,0 AS EstaEnRevista
			,(
				CASE 
					WHEN ISNULL(pf.CUV, 0) = 0
						THEN 1
					WHEN ISNULL(pf.CUV, 0) > 0
						THEN 0
					END
				) AS TieneStock
			,ISNULL(pcc.EsExpoOferta, 0) AS EsExpoOferta
			,ISNULL(pcc.CUVRevista, '') AS CUVRevista
			,'' AS CUVComplemento
			,p.PaisID
			,p.AnoCampania AS CampaniaID
			,p.CodigoCatalago
			,p.CodigoProducto
			,p.IndicadorMontoMinimo
			,M.Descripcion AS DescripcionMarca
			,'NO DISPONIBLE' AS DescripcionCategoria
			,TE.DescripcionEstrategia AS DescripcionEstrategia
			,ISNULL(op.ConfiguracionOfertaID, 0) ConfiguracionOfertaID
			,CASE 
				WHEN EXISTS (
						SELECT 1
						FROM TallaColorLiquidacion
						WHERE CampaniaID = @CampaniaID
							AND CUV = p.CUV
						)
					THEN 1702
				WHEN EXISTS (
						SELECT 1
						FROM TallaColorCUV
						WHERE CampaniaID = @CampaniaID
							AND CUV = p.CUV
						)
					THEN (
							SELECT E.TipoEstrategiaID
							FROM Estrategia E
							INNER JOIN TALLACOLORCUV TCC ON E.CAMPANIAID = TCC.CAMPANIAID
								AND E.CUV2 = TCC.CUVPADRE
							WHERE TCC.CUV = p.CUV
								AND E.CAMPANIAID = @CampaniaID
							)
				ELSE ISNULL(op.TipoOfertaSisID, 0)
				END TipoOfertaSisID
			,ISNULL(te.flagNueva, 0) FlagNueva
			,ISNULL(te.TipoEstrategiaID, '') TipoEstrategiaID
			,P.IndicadorOferta
			,@TieneSugerido AS TieneSugerido
			,CASE 
				WHEN pcor.SAP IS NULL
					THEN 0
				ELSE 1
				END TieneOfertaRevista
			,p.PrecioValorizado
			,CASE 
				WHEN pl.CodigoSAP IS NULL
					THEN 0
				ELSE 1
				END AS TieneLanzamientoCatalogoPersonalizado
			,ISNULL(pcor.Oferta, '') AS TipoOfertaRevista
			,TE.Codigo AS TipoEstrategiaCodigo
			,CASE 
				WHEN (
						TE.MostrarImgOfertaIndependiente = 1
						AND EST.EsOfertaIndependiente = 1
						)
					THEN 1
				ELSE 0
				END AS EsOfertaIndependiente
		FROM ods.ProductoComercial p WITH (NOLOCK)
		LEFT JOIN dbo.ProductoDescripcion pd WITH (NOLOCK) ON p.AnoCampania = pd.CampaniaID
			AND p.CUV = pd.CUV
		LEFT JOIN @ProductoFaltanteTemp pf ON p.CUV = pf.CUV
		LEFT JOIN ProductoComercialConfiguracion pcc ON p.AnoCampania = pcc.CampaniaID
			AND p.CUV = pcc.CUV
		LEFT JOIN @OfertaProductoTemp op ON op.CampaniaID = P.CampaniaID
			AND op.CUV = P.CUV
		LEFT JOIN MatrizComercial mc WITH (NOLOCK) ON p.CodigoProducto = mc.CodigoSAP
		LEFT JOIN Estrategia EST WITH (NOLOCK) ON
			--EST.CampaniaID = p.AnoCampania
			(
				EST.CampaniaID = p.AnoCampania
				OR p.AnoCampania BETWEEN EST.CampaniaID
					AND EST.CampaniaIDFin
				)
			AND (
				EST.CUV2 = p.CUV
				OR EST.CUV2 = (
					SELECT CUVPadre
					FROM TallaColorCUV TCC
					WHERE TCC.CUV = p.CUV
					)
				)
			AND EST.Activo = 1
		LEFT JOIN dbo.TallaColorCUV tcc WITH (NOLOCK) ON tcc.CUV = p.CUV
			AND tcc.CampaniaID = p.AnoCampania
		LEFT JOIN TipoEstrategia TE WITH (NOLOCK) ON TE.TipoEstrategiaID = EST.TipoEstrategiaID
		LEFT JOIN Marca M WITH (NOLOCK) ON p.MarcaId = M.MarcaId
		LEFT JOIN ods.ProductosLanzamiento pl WITH (NOLOCK) ON p.CodigoProducto = pl.CodigoSAP
			AND p.AnoCampania = pl.Campania
		LEFT JOIN ProductoComercialOfertaRevista pcor WITH (NOLOCK) ON p.AnoCampania = pcor.Campania
			AND p.CUV = pcor.CUV
		WHERE p.AnoCampania = @CampaniaID
			AND p.IndicadorDigitable = 1
			AND CHARINDEX(@CodigoDescripcion, p.CUV) > 0
			AND p.CUV NOT IN (
				SELECT CUV
				FROM @tablaCuvOPT
				)
	END
	ELSE
	BEGIN
		SELECT DISTINCT TOP (@RowCount) p.CUV
			,coalesce(est.descripcioncuv2, op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion) AS Descripcion
			,coalesce(est.precio2, op.PrecioOferta, pd.PrecioProducto * pd.FactorRepeticion, p.PrecioUnitario * p.FactorRepeticion) AS PrecioCatalogo
			,p.MarcaID
			,0 AS EstaEnRevista
			,(
				CASE 
					WHEN ISNULL(pf.CUV, 0) = 0
						THEN 1
					WHEN ISNULL(pf.CUV, 0) > 0
						THEN 0
					END
				) AS TieneStock
			,ISNULL(pcc.EsExpoOferta, 0) AS EsExpoOferta
			,ISNULL(pcc.CUVRevista, '') AS CUVRevista
			,'' AS CUVComplemento
			,p.PaisID
			,p.AnoCampania AS CampaniaID
			,p.CodigoCatalago
			,p.CodigoProducto
			,p.IndicadorMontoMinimo
			,M.Descripcion AS DescripcionMarca
			,'NO DISPONIBLE' AS DescripcionCategoria
			,TE.DescripcionEstrategia AS DescripcionEstrategia
			,ISNULL(op.ConfiguracionOfertaID, 0) ConfiguracionOfertaID
			,CASE 
				WHEN EXISTS (
						SELECT 1
						FROM TallaColorLiquidacion
						WHERE CampaniaID = @CampaniaID
							AND CUV = p.CUV
						)
					THEN 1702
				WHEN EXISTS (
						SELECT 1
						FROM TallaColorCUV
						WHERE CampaniaID = @CampaniaID
							AND CUV = p.CUV
						)
					THEN (
							SELECT E.TipoEstrategiaID
							FROM Estrategia E
							INNER JOIN TALLACOLORCUV TCC ON E.CAMPANIAID = TCC.CAMPANIAID
								AND E.CUV2 = TCC.CUVPADRE
							WHERE TCC.CUV = p.CUV
								AND E.CAMPANIAID = @CampaniaID
							)
				ELSE ISNULL(op.TipoOfertaSisID, 0)
				END TipoOfertaSisID
			,ISNULL(te.flagNueva, 0) FlagNueva
			,ISNULL(te.TipoEstrategiaID, '') TipoEstrategiaID
			,P.IndicadorOferta
			,@TieneSugerido AS TieneSugerido
			,CASE 
				WHEN pcor.SAP IS NULL
					THEN 0
				ELSE 1
				END TieneOfertaRevista
			,p.PrecioValorizado
			,CASE 
				WHEN pl.CodigoSAP IS NULL
					THEN 0
				ELSE 1
				END AS TieneLanzamientoCatalogoPersonalizado
			,ISNULL(pcor.Oferta, '') AS TipoOfertaRevista
			,TE.Codigo AS TipoEstrategiaCodigo
			,CASE 
				WHEN (
						TE.MostrarImgOfertaIndependiente = 1
						AND EST.EsOfertaIndependiente = 1
						)
					THEN 1
				ELSE 0
				END AS EsOfertaIndependiente
		FROM ods.ProductoComercial p WITH (NOLOCK)
		LEFT JOIN dbo.ProductoDescripcion pd WITH (NOLOCK) ON p.AnoCampania = pd.CampaniaID
			AND p.CUV = pd.CUV
		LEFT JOIN @ProductoFaltanteTemp pf ON p.CUV = pf.CUV
		LEFT JOIN ProductoComercialConfiguracion pcc WITH (NOLOCK) ON p.AnoCampania = pcc.CampaniaID
			AND p.CUV = pcc.CUV
		LEFT JOIN @OfertaProductoTemp op ON op.CampaniaID = P.CampaniaID
			AND op.CUV = P.CUV
		LEFT JOIN MatrizComercial mc WITH (NOLOCK) ON p.CodigoProducto = mc.CodigoSAP
		LEFT JOIN Estrategia EST WITH (NOLOCK) ON
			--EST.CampaniaID = p.AnoCampania
			(
				EST.CampaniaID = p.AnoCampania
				OR p.AnoCampania BETWEEN EST.CampaniaID
					AND EST.CampaniaIDFin
				)
			AND (
				EST.CUV2 = p.CUV
				OR EST.CUV2 = (
					SELECT CUVPadre
					FROM TallaColorCUV TCC
					WHERE TCC.CUV = p.CUV
					)
				)
			AND EST.Activo = 1
		LEFT JOIN TipoEstrategia TE WITH (NOLOCK) ON TE.TipoEstrategiaID = EST.TipoEstrategiaID
		LEFT JOIN Marca M ON p.MarcaId = M.MarcaId
		LEFT JOIN ods.ProductosLanzamiento pl WITH (NOLOCK) ON p.CodigoProducto = pl.CodigoSAP
			AND p.AnoCampania = pl.Campania
		LEFT JOIN ProductoComercialOfertaRevista pcor WITH (NOLOCK) ON p.AnoCampania = pcor.Campania
			AND p.CUV = pcor.CUV
		WHERE p.AnoCampania = @CampaniaID
			AND p.IndicadorDigitable = 1
			AND CHARINDEX(@CodigoDescripcion, coalesce(op.Descripcion, pd.Descripcion, p.Descripcion)) > 0
			AND p.CUV NOT IN (
				SELECT CUV
				FROM @tablaCuvOPT
				)
	END
END

GO

USE BelcorpPuertoRico
GO

GO

IF (OBJECT_ID('[dbo].[GetProductoComercialByCampaniaBySearchRegionZona_SB2]', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE [dbo].[GetProductoComercialByCampaniaBySearchRegionZona_SB2] AS SET NOCOUNT ON;')
GO

ALTER PROCEDURE [dbo].[GetProductoComercialByCampaniaBySearchRegionZona_SB2] @CampaniaID INT
	,@RowCount INT
	,@Criterio INT
	,@CodigoDescripcion VARCHAR(100)
	,@RegionID INT
	,@ZonaID INT
	,@CodigoRegion VARCHAR(10)
	,@CodigoZona VARCHAR(10)
	,@ValidarOPT BIT = 0
AS
/*
dbo.GetProductoComercialByCampaniaBySearchRegionZona_SB2 201618,1,1,'97010',2701,2161,'50','5052'
dbo.GetProductoComercialByCampaniaBySearchRegionZona_SB2 201618,1,1,'97010',2701,2161,'50','5052',1
*/
BEGIN
	-- Depuramos las tallas y colores
	EXEC DepurarTallaColorCUV @CampaniaID

	EXEC DepurarTallaColorLiquidacion @CampaniaID

	DECLARE @OfertaProductoTemp TABLE (
		CampaniaID INT
		,CUV VARCHAR(6)
		,Descripcion VARCHAR(250)
		,ConfiguracionOfertaID INT
		,TipoOfertaSisID INT
		,PrecioOferta NUMERIC(12, 2)
		)

	INSERT INTO @OfertaProductoTemp
	SELECT op.CampaniaID
		,op.CUV
		,op.Descripcion
		,op.ConfiguracionOfertaID
		,op.TipoOfertaSisID
		,NULL
	FROM OfertaProducto op WITH (NOLOCK)
	INNER JOIN ods.Campania c ON op.CampaniaID = c.CampaniaID
	WHERE c.codigo = @CampaniaID

	INSERT INTO @OfertaProductoTemp
	SELECT c.CampaniaID
		,e.CUV2 AS CUV
		,e.DescripcionCUV2 AS Descripcion
		,ves.ConfiguracionOfertaID
		,ves.TipoOfertaSisID
		,NULL
	FROM dbo.Estrategia e WITH (NOLOCK)
	INNER JOIN ods.Campania c ON e.CampaniaID = c.Codigo
	INNER JOIN vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE c.codigo = @CampaniaID

	DECLARE @ProductoFaltanteTemp TABLE (CUV VARCHAR(6))

	INSERT INTO @ProductoFaltanteTemp
	SELECT DISTINCT ltrim(rtrim(CUV))
	FROM dbo.ProductoFaltante NOLOCK
	WHERE CampaniaID = @CampaniaID
		AND Zonaid = @ZonaID
	
	UNION ALL
	
	SELECT DISTINCT ltrim(rtrim(fa.CodigoVenta)) AS CUV
	FROM ods.FaltanteAnunciado fa(NOLOCK)
	INNER JOIN ods.Campania c(NOLOCK) ON fa.CampaniaID = c.CampaniaID
	WHERE c.Codigo = @CampaniaID
		AND (
			rtrim(fa.CodigoRegion) = @CodigoRegion
			OR fa.CodigoRegion IS NULL
			)
		AND (
			rtrim(fa.CodigoZona) = @CodigoZona
			OR fa.CodigoZona IS NULL
			)

	--Logica para Producto Sugerido
	DECLARE @TieneSugerido INT = 0

	IF EXISTS (
			SELECT 1
			FROM dbo.ProductoSugerido
			WHERE CampaniaID = @CampaniaID
				AND CUV = @CodigoDescripcion
				AND Estado = 1
			)
	BEGIN
		SET @TieneSugerido = 1
	END

	DECLARE @tablaCuvOPT TABLE (CUV VARCHAR(6))

	IF (@Criterio = 1)
	BEGIN
		SELECT DISTINCT TOP (@RowCount) p.CUV
			,coalesce(EST.DescripcionCUV2 + ' ' + tcc.Descripcion, est.descripcioncuv2, op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion) AS Descripcion
			,coalesce(est.precio2, op.PrecioOferta, pd.PrecioProducto * pd.FactorRepeticion, p.PrecioUnitario * p.FactorRepeticion) AS PrecioCatalogo
			,p.MarcaID
			,0 AS EstaEnRevista
			,(
				CASE 
					WHEN ISNULL(pf.CUV, 0) = 0
						THEN 1
					WHEN ISNULL(pf.CUV, 0) > 0
						THEN 0
					END
				) AS TieneStock
			,ISNULL(pcc.EsExpoOferta, 0) AS EsExpoOferta
			,ISNULL(pcc.CUVRevista, '') AS CUVRevista
			,'' AS CUVComplemento
			,p.PaisID
			,p.AnoCampania AS CampaniaID
			,p.CodigoCatalago
			,p.CodigoProducto
			,p.IndicadorMontoMinimo
			,M.Descripcion AS DescripcionMarca
			,'NO DISPONIBLE' AS DescripcionCategoria
			,TE.DescripcionEstrategia AS DescripcionEstrategia
			,ISNULL(op.ConfiguracionOfertaID, 0) ConfiguracionOfertaID
			,CASE 
				WHEN EXISTS (
						SELECT 1
						FROM TallaColorLiquidacion
						WHERE CampaniaID = @CampaniaID
							AND CUV = p.CUV
						)
					THEN 1702
				WHEN EXISTS (
						SELECT 1
						FROM TallaColorCUV
						WHERE CampaniaID = @CampaniaID
							AND CUV = p.CUV
						)
					THEN (
							SELECT E.TipoEstrategiaID
							FROM Estrategia E
							INNER JOIN TALLACOLORCUV TCC ON E.CAMPANIAID = TCC.CAMPANIAID
								AND E.CUV2 = TCC.CUVPADRE
							WHERE TCC.CUV = p.CUV
								AND E.CAMPANIAID = @CampaniaID
							)
				ELSE ISNULL(op.TipoOfertaSisID, 0)
				END TipoOfertaSisID
			,ISNULL(te.flagNueva, 0) FlagNueva
			,ISNULL(te.TipoEstrategiaID, '') TipoEstrategiaID
			,P.IndicadorOferta
			,@TieneSugerido AS TieneSugerido
			,CASE 
				WHEN pcor.SAP IS NULL
					THEN 0
				ELSE 1
				END TieneOfertaRevista
			,p.PrecioValorizado
			,CASE 
				WHEN pl.CodigoSAP IS NULL
					THEN 0
				ELSE 1
				END AS TieneLanzamientoCatalogoPersonalizado
			,ISNULL(pcor.Oferta, '') AS TipoOfertaRevista
			,TE.Codigo AS TipoEstrategiaCodigo
			,CASE 
				WHEN (
						TE.MostrarImgOfertaIndependiente = 1
						AND EST.EsOfertaIndependiente = 1
						)
					THEN 1
				ELSE 0
				END AS EsOfertaIndependiente
		FROM ods.ProductoComercial p WITH (NOLOCK)
		LEFT JOIN dbo.ProductoDescripcion pd WITH (NOLOCK) ON p.AnoCampania = pd.CampaniaID
			AND p.CUV = pd.CUV
		LEFT JOIN @ProductoFaltanteTemp pf ON p.CUV = pf.CUV
		LEFT JOIN ProductoComercialConfiguracion pcc ON p.AnoCampania = pcc.CampaniaID
			AND p.CUV = pcc.CUV
		LEFT JOIN @OfertaProductoTemp op ON op.CampaniaID = P.CampaniaID
			AND op.CUV = P.CUV
		LEFT JOIN MatrizComercial mc WITH (NOLOCK) ON p.CodigoProducto = mc.CodigoSAP
		LEFT JOIN Estrategia EST WITH (NOLOCK) ON
			--EST.CampaniaID = p.AnoCampania
			(
				EST.CampaniaID = p.AnoCampania
				OR p.AnoCampania BETWEEN EST.CampaniaID
					AND EST.CampaniaIDFin
				)
			AND (
				EST.CUV2 = p.CUV
				OR EST.CUV2 = (
					SELECT CUVPadre
					FROM TallaColorCUV TCC
					WHERE TCC.CUV = p.CUV
					)
				)
			AND EST.Activo = 1
		LEFT JOIN dbo.TallaColorCUV tcc WITH (NOLOCK) ON tcc.CUV = p.CUV
			AND tcc.CampaniaID = p.AnoCampania
		LEFT JOIN TipoEstrategia TE WITH (NOLOCK) ON TE.TipoEstrategiaID = EST.TipoEstrategiaID
		LEFT JOIN Marca M WITH (NOLOCK) ON p.MarcaId = M.MarcaId
		LEFT JOIN ods.ProductosLanzamiento pl WITH (NOLOCK) ON p.CodigoProducto = pl.CodigoSAP
			AND p.AnoCampania = pl.Campania
		LEFT JOIN ProductoComercialOfertaRevista pcor WITH (NOLOCK) ON p.AnoCampania = pcor.Campania
			AND p.CUV = pcor.CUV
		WHERE p.AnoCampania = @CampaniaID
			AND p.IndicadorDigitable = 1
			AND CHARINDEX(@CodigoDescripcion, p.CUV) > 0
			AND p.CUV NOT IN (
				SELECT CUV
				FROM @tablaCuvOPT
				)
	END
	ELSE
	BEGIN
		SELECT DISTINCT TOP (@RowCount) p.CUV
			,coalesce(est.descripcioncuv2, op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion) AS Descripcion
			,coalesce(est.precio2, op.PrecioOferta, pd.PrecioProducto * pd.FactorRepeticion, p.PrecioUnitario * p.FactorRepeticion) AS PrecioCatalogo
			,p.MarcaID
			,0 AS EstaEnRevista
			,(
				CASE 
					WHEN ISNULL(pf.CUV, 0) = 0
						THEN 1
					WHEN ISNULL(pf.CUV, 0) > 0
						THEN 0
					END
				) AS TieneStock
			,ISNULL(pcc.EsExpoOferta, 0) AS EsExpoOferta
			,ISNULL(pcc.CUVRevista, '') AS CUVRevista
			,'' AS CUVComplemento
			,p.PaisID
			,p.AnoCampania AS CampaniaID
			,p.CodigoCatalago
			,p.CodigoProducto
			,p.IndicadorMontoMinimo
			,M.Descripcion AS DescripcionMarca
			,'NO DISPONIBLE' AS DescripcionCategoria
			,TE.DescripcionEstrategia AS DescripcionEstrategia
			,ISNULL(op.ConfiguracionOfertaID, 0) ConfiguracionOfertaID
			,CASE 
				WHEN EXISTS (
						SELECT 1
						FROM TallaColorLiquidacion
						WHERE CampaniaID = @CampaniaID
							AND CUV = p.CUV
						)
					THEN 1702
				WHEN EXISTS (
						SELECT 1
						FROM TallaColorCUV
						WHERE CampaniaID = @CampaniaID
							AND CUV = p.CUV
						)
					THEN (
							SELECT E.TipoEstrategiaID
							FROM Estrategia E
							INNER JOIN TALLACOLORCUV TCC ON E.CAMPANIAID = TCC.CAMPANIAID
								AND E.CUV2 = TCC.CUVPADRE
							WHERE TCC.CUV = p.CUV
								AND E.CAMPANIAID = @CampaniaID
							)
				ELSE ISNULL(op.TipoOfertaSisID, 0)
				END TipoOfertaSisID
			,ISNULL(te.flagNueva, 0) FlagNueva
			,ISNULL(te.TipoEstrategiaID, '') TipoEstrategiaID
			,P.IndicadorOferta
			,@TieneSugerido AS TieneSugerido
			,CASE 
				WHEN pcor.SAP IS NULL
					THEN 0
				ELSE 1
				END TieneOfertaRevista
			,p.PrecioValorizado
			,CASE 
				WHEN pl.CodigoSAP IS NULL
					THEN 0
				ELSE 1
				END AS TieneLanzamientoCatalogoPersonalizado
			,ISNULL(pcor.Oferta, '') AS TipoOfertaRevista
			,TE.Codigo AS TipoEstrategiaCodigo
			,CASE 
				WHEN (
						TE.MostrarImgOfertaIndependiente = 1
						AND EST.EsOfertaIndependiente = 1
						)
					THEN 1
				ELSE 0
				END AS EsOfertaIndependiente
		FROM ods.ProductoComercial p WITH (NOLOCK)
		LEFT JOIN dbo.ProductoDescripcion pd WITH (NOLOCK) ON p.AnoCampania = pd.CampaniaID
			AND p.CUV = pd.CUV
		LEFT JOIN @ProductoFaltanteTemp pf ON p.CUV = pf.CUV
		LEFT JOIN ProductoComercialConfiguracion pcc WITH (NOLOCK) ON p.AnoCampania = pcc.CampaniaID
			AND p.CUV = pcc.CUV
		LEFT JOIN @OfertaProductoTemp op ON op.CampaniaID = P.CampaniaID
			AND op.CUV = P.CUV
		LEFT JOIN MatrizComercial mc WITH (NOLOCK) ON p.CodigoProducto = mc.CodigoSAP
		LEFT JOIN Estrategia EST WITH (NOLOCK) ON
			--EST.CampaniaID = p.AnoCampania
			(
				EST.CampaniaID = p.AnoCampania
				OR p.AnoCampania BETWEEN EST.CampaniaID
					AND EST.CampaniaIDFin
				)
			AND (
				EST.CUV2 = p.CUV
				OR EST.CUV2 = (
					SELECT CUVPadre
					FROM TallaColorCUV TCC
					WHERE TCC.CUV = p.CUV
					)
				)
			AND EST.Activo = 1
		LEFT JOIN TipoEstrategia TE WITH (NOLOCK) ON TE.TipoEstrategiaID = EST.TipoEstrategiaID
		LEFT JOIN Marca M ON p.MarcaId = M.MarcaId
		LEFT JOIN ods.ProductosLanzamiento pl WITH (NOLOCK) ON p.CodigoProducto = pl.CodigoSAP
			AND p.AnoCampania = pl.Campania
		LEFT JOIN ProductoComercialOfertaRevista pcor WITH (NOLOCK) ON p.AnoCampania = pcor.Campania
			AND p.CUV = pcor.CUV
		WHERE p.AnoCampania = @CampaniaID
			AND p.IndicadorDigitable = 1
			AND CHARINDEX(@CodigoDescripcion, coalesce(op.Descripcion, pd.Descripcion, p.Descripcion)) > 0
			AND p.CUV NOT IN (
				SELECT CUV
				FROM @tablaCuvOPT
				)
	END
END

GO

USE BelcorpPanama
GO

GO

IF (OBJECT_ID('[dbo].[GetProductoComercialByCampaniaBySearchRegionZona_SB2]', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE [dbo].[GetProductoComercialByCampaniaBySearchRegionZona_SB2] AS SET NOCOUNT ON;')
GO

ALTER PROCEDURE [dbo].[GetProductoComercialByCampaniaBySearchRegionZona_SB2] @CampaniaID INT
	,@RowCount INT
	,@Criterio INT
	,@CodigoDescripcion VARCHAR(100)
	,@RegionID INT
	,@ZonaID INT
	,@CodigoRegion VARCHAR(10)
	,@CodigoZona VARCHAR(10)
	,@ValidarOPT BIT = 0
AS
/*
dbo.GetProductoComercialByCampaniaBySearchRegionZona_SB2 201618,1,1,'97010',2701,2161,'50','5052'
dbo.GetProductoComercialByCampaniaBySearchRegionZona_SB2 201618,1,1,'97010',2701,2161,'50','5052',1
*/
BEGIN
	-- Depuramos las tallas y colores
	EXEC DepurarTallaColorCUV @CampaniaID

	EXEC DepurarTallaColorLiquidacion @CampaniaID

	DECLARE @OfertaProductoTemp TABLE (
		CampaniaID INT
		,CUV VARCHAR(6)
		,Descripcion VARCHAR(250)
		,ConfiguracionOfertaID INT
		,TipoOfertaSisID INT
		,PrecioOferta NUMERIC(12, 2)
		)

	INSERT INTO @OfertaProductoTemp
	SELECT op.CampaniaID
		,op.CUV
		,op.Descripcion
		,op.ConfiguracionOfertaID
		,op.TipoOfertaSisID
		,NULL
	FROM OfertaProducto op WITH (NOLOCK)
	INNER JOIN ods.Campania c ON op.CampaniaID = c.CampaniaID
	WHERE c.codigo = @CampaniaID

	INSERT INTO @OfertaProductoTemp
	SELECT c.CampaniaID
		,e.CUV2 AS CUV
		,e.DescripcionCUV2 AS Descripcion
		,ves.ConfiguracionOfertaID
		,ves.TipoOfertaSisID
		,NULL
	FROM dbo.Estrategia e WITH (NOLOCK)
	INNER JOIN ods.Campania c ON e.CampaniaID = c.Codigo
	INNER JOIN vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE c.codigo = @CampaniaID

	DECLARE @ProductoFaltanteTemp TABLE (CUV VARCHAR(6))

	INSERT INTO @ProductoFaltanteTemp
	SELECT DISTINCT ltrim(rtrim(CUV))
	FROM dbo.ProductoFaltante NOLOCK
	WHERE CampaniaID = @CampaniaID
		AND Zonaid = @ZonaID
	
	UNION ALL
	
	SELECT DISTINCT ltrim(rtrim(fa.CodigoVenta)) AS CUV
	FROM ods.FaltanteAnunciado fa(NOLOCK)
	INNER JOIN ods.Campania c(NOLOCK) ON fa.CampaniaID = c.CampaniaID
	WHERE c.Codigo = @CampaniaID
		AND (
			rtrim(fa.CodigoRegion) = @CodigoRegion
			OR fa.CodigoRegion IS NULL
			)
		AND (
			rtrim(fa.CodigoZona) = @CodigoZona
			OR fa.CodigoZona IS NULL
			)

	--Logica para Producto Sugerido
	DECLARE @TieneSugerido INT = 0

	IF EXISTS (
			SELECT 1
			FROM dbo.ProductoSugerido
			WHERE CampaniaID = @CampaniaID
				AND CUV = @CodigoDescripcion
				AND Estado = 1
			)
	BEGIN
		SET @TieneSugerido = 1
	END

	DECLARE @tablaCuvOPT TABLE (CUV VARCHAR(6))

	IF (@Criterio = 1)
	BEGIN
		SELECT DISTINCT TOP (@RowCount) p.CUV
			,coalesce(EST.DescripcionCUV2 + ' ' + tcc.Descripcion, est.descripcioncuv2, op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion) AS Descripcion
			,coalesce(est.precio2, op.PrecioOferta, pd.PrecioProducto * pd.FactorRepeticion, p.PrecioUnitario * p.FactorRepeticion) AS PrecioCatalogo
			,p.MarcaID
			,0 AS EstaEnRevista
			,(
				CASE 
					WHEN ISNULL(pf.CUV, 0) = 0
						THEN 1
					WHEN ISNULL(pf.CUV, 0) > 0
						THEN 0
					END
				) AS TieneStock
			,ISNULL(pcc.EsExpoOferta, 0) AS EsExpoOferta
			,ISNULL(pcc.CUVRevista, '') AS CUVRevista
			,'' AS CUVComplemento
			,p.PaisID
			,p.AnoCampania AS CampaniaID
			,p.CodigoCatalago
			,p.CodigoProducto
			,p.IndicadorMontoMinimo
			,M.Descripcion AS DescripcionMarca
			,'NO DISPONIBLE' AS DescripcionCategoria
			,TE.DescripcionEstrategia AS DescripcionEstrategia
			,ISNULL(op.ConfiguracionOfertaID, 0) ConfiguracionOfertaID
			,CASE 
				WHEN EXISTS (
						SELECT 1
						FROM TallaColorLiquidacion
						WHERE CampaniaID = @CampaniaID
							AND CUV = p.CUV
						)
					THEN 1702
				WHEN EXISTS (
						SELECT 1
						FROM TallaColorCUV
						WHERE CampaniaID = @CampaniaID
							AND CUV = p.CUV
						)
					THEN (
							SELECT E.TipoEstrategiaID
							FROM Estrategia E
							INNER JOIN TALLACOLORCUV TCC ON E.CAMPANIAID = TCC.CAMPANIAID
								AND E.CUV2 = TCC.CUVPADRE
							WHERE TCC.CUV = p.CUV
								AND E.CAMPANIAID = @CampaniaID
							)
				ELSE ISNULL(op.TipoOfertaSisID, 0)
				END TipoOfertaSisID
			,ISNULL(te.flagNueva, 0) FlagNueva
			,ISNULL(te.TipoEstrategiaID, '') TipoEstrategiaID
			,P.IndicadorOferta
			,@TieneSugerido AS TieneSugerido
			,CASE 
				WHEN pcor.SAP IS NULL
					THEN 0
				ELSE 1
				END TieneOfertaRevista
			,p.PrecioValorizado
			,CASE 
				WHEN pl.CodigoSAP IS NULL
					THEN 0
				ELSE 1
				END AS TieneLanzamientoCatalogoPersonalizado
			,ISNULL(pcor.Oferta, '') AS TipoOfertaRevista
			,TE.Codigo AS TipoEstrategiaCodigo
			,CASE 
				WHEN (
						TE.MostrarImgOfertaIndependiente = 1
						AND EST.EsOfertaIndependiente = 1
						)
					THEN 1
				ELSE 0
				END AS EsOfertaIndependiente
		FROM ods.ProductoComercial p WITH (NOLOCK)
		LEFT JOIN dbo.ProductoDescripcion pd WITH (NOLOCK) ON p.AnoCampania = pd.CampaniaID
			AND p.CUV = pd.CUV
		LEFT JOIN @ProductoFaltanteTemp pf ON p.CUV = pf.CUV
		LEFT JOIN ProductoComercialConfiguracion pcc ON p.AnoCampania = pcc.CampaniaID
			AND p.CUV = pcc.CUV
		LEFT JOIN @OfertaProductoTemp op ON op.CampaniaID = P.CampaniaID
			AND op.CUV = P.CUV
		LEFT JOIN MatrizComercial mc WITH (NOLOCK) ON p.CodigoProducto = mc.CodigoSAP
		LEFT JOIN Estrategia EST WITH (NOLOCK) ON
			--EST.CampaniaID = p.AnoCampania
			(
				EST.CampaniaID = p.AnoCampania
				OR p.AnoCampania BETWEEN EST.CampaniaID
					AND EST.CampaniaIDFin
				)
			AND (
				EST.CUV2 = p.CUV
				OR EST.CUV2 = (
					SELECT CUVPadre
					FROM TallaColorCUV TCC
					WHERE TCC.CUV = p.CUV
					)
				)
			AND EST.Activo = 1
		LEFT JOIN dbo.TallaColorCUV tcc WITH (NOLOCK) ON tcc.CUV = p.CUV
			AND tcc.CampaniaID = p.AnoCampania
		LEFT JOIN TipoEstrategia TE WITH (NOLOCK) ON TE.TipoEstrategiaID = EST.TipoEstrategiaID
		LEFT JOIN Marca M WITH (NOLOCK) ON p.MarcaId = M.MarcaId
		LEFT JOIN ods.ProductosLanzamiento pl WITH (NOLOCK) ON p.CodigoProducto = pl.CodigoSAP
			AND p.AnoCampania = pl.Campania
		LEFT JOIN ProductoComercialOfertaRevista pcor WITH (NOLOCK) ON p.AnoCampania = pcor.Campania
			AND p.CUV = pcor.CUV
		WHERE p.AnoCampania = @CampaniaID
			AND p.IndicadorDigitable = 1
			AND CHARINDEX(@CodigoDescripcion, p.CUV) > 0
			AND p.CUV NOT IN (
				SELECT CUV
				FROM @tablaCuvOPT
				)
	END
	ELSE
	BEGIN
		SELECT DISTINCT TOP (@RowCount) p.CUV
			,coalesce(est.descripcioncuv2, op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion) AS Descripcion
			,coalesce(est.precio2, op.PrecioOferta, pd.PrecioProducto * pd.FactorRepeticion, p.PrecioUnitario * p.FactorRepeticion) AS PrecioCatalogo
			,p.MarcaID
			,0 AS EstaEnRevista
			,(
				CASE 
					WHEN ISNULL(pf.CUV, 0) = 0
						THEN 1
					WHEN ISNULL(pf.CUV, 0) > 0
						THEN 0
					END
				) AS TieneStock
			,ISNULL(pcc.EsExpoOferta, 0) AS EsExpoOferta
			,ISNULL(pcc.CUVRevista, '') AS CUVRevista
			,'' AS CUVComplemento
			,p.PaisID
			,p.AnoCampania AS CampaniaID
			,p.CodigoCatalago
			,p.CodigoProducto
			,p.IndicadorMontoMinimo
			,M.Descripcion AS DescripcionMarca
			,'NO DISPONIBLE' AS DescripcionCategoria
			,TE.DescripcionEstrategia AS DescripcionEstrategia
			,ISNULL(op.ConfiguracionOfertaID, 0) ConfiguracionOfertaID
			,CASE 
				WHEN EXISTS (
						SELECT 1
						FROM TallaColorLiquidacion
						WHERE CampaniaID = @CampaniaID
							AND CUV = p.CUV
						)
					THEN 1702
				WHEN EXISTS (
						SELECT 1
						FROM TallaColorCUV
						WHERE CampaniaID = @CampaniaID
							AND CUV = p.CUV
						)
					THEN (
							SELECT E.TipoEstrategiaID
							FROM Estrategia E
							INNER JOIN TALLACOLORCUV TCC ON E.CAMPANIAID = TCC.CAMPANIAID
								AND E.CUV2 = TCC.CUVPADRE
							WHERE TCC.CUV = p.CUV
								AND E.CAMPANIAID = @CampaniaID
							)
				ELSE ISNULL(op.TipoOfertaSisID, 0)
				END TipoOfertaSisID
			,ISNULL(te.flagNueva, 0) FlagNueva
			,ISNULL(te.TipoEstrategiaID, '') TipoEstrategiaID
			,P.IndicadorOferta
			,@TieneSugerido AS TieneSugerido
			,CASE 
				WHEN pcor.SAP IS NULL
					THEN 0
				ELSE 1
				END TieneOfertaRevista
			,p.PrecioValorizado
			,CASE 
				WHEN pl.CodigoSAP IS NULL
					THEN 0
				ELSE 1
				END AS TieneLanzamientoCatalogoPersonalizado
			,ISNULL(pcor.Oferta, '') AS TipoOfertaRevista
			,TE.Codigo AS TipoEstrategiaCodigo
			,CASE 
				WHEN (
						TE.MostrarImgOfertaIndependiente = 1
						AND EST.EsOfertaIndependiente = 1
						)
					THEN 1
				ELSE 0
				END AS EsOfertaIndependiente
		FROM ods.ProductoComercial p WITH (NOLOCK)
		LEFT JOIN dbo.ProductoDescripcion pd WITH (NOLOCK) ON p.AnoCampania = pd.CampaniaID
			AND p.CUV = pd.CUV
		LEFT JOIN @ProductoFaltanteTemp pf ON p.CUV = pf.CUV
		LEFT JOIN ProductoComercialConfiguracion pcc WITH (NOLOCK) ON p.AnoCampania = pcc.CampaniaID
			AND p.CUV = pcc.CUV
		LEFT JOIN @OfertaProductoTemp op ON op.CampaniaID = P.CampaniaID
			AND op.CUV = P.CUV
		LEFT JOIN MatrizComercial mc WITH (NOLOCK) ON p.CodigoProducto = mc.CodigoSAP
		LEFT JOIN Estrategia EST WITH (NOLOCK) ON
			--EST.CampaniaID = p.AnoCampania
			(
				EST.CampaniaID = p.AnoCampania
				OR p.AnoCampania BETWEEN EST.CampaniaID
					AND EST.CampaniaIDFin
				)
			AND (
				EST.CUV2 = p.CUV
				OR EST.CUV2 = (
					SELECT CUVPadre
					FROM TallaColorCUV TCC
					WHERE TCC.CUV = p.CUV
					)
				)
			AND EST.Activo = 1
		LEFT JOIN TipoEstrategia TE WITH (NOLOCK) ON TE.TipoEstrategiaID = EST.TipoEstrategiaID
		LEFT JOIN Marca M ON p.MarcaId = M.MarcaId
		LEFT JOIN ods.ProductosLanzamiento pl WITH (NOLOCK) ON p.CodigoProducto = pl.CodigoSAP
			AND p.AnoCampania = pl.Campania
		LEFT JOIN ProductoComercialOfertaRevista pcor WITH (NOLOCK) ON p.AnoCampania = pcor.Campania
			AND p.CUV = pcor.CUV
		WHERE p.AnoCampania = @CampaniaID
			AND p.IndicadorDigitable = 1
			AND CHARINDEX(@CodigoDescripcion, coalesce(op.Descripcion, pd.Descripcion, p.Descripcion)) > 0
			AND p.CUV NOT IN (
				SELECT CUV
				FROM @tablaCuvOPT
				)
	END
END

GO

USE BelcorpGuatemala
GO

GO

IF (OBJECT_ID('[dbo].[GetProductoComercialByCampaniaBySearchRegionZona_SB2]', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE [dbo].[GetProductoComercialByCampaniaBySearchRegionZona_SB2] AS SET NOCOUNT ON;')
GO

ALTER PROCEDURE [dbo].[GetProductoComercialByCampaniaBySearchRegionZona_SB2] @CampaniaID INT
	,@RowCount INT
	,@Criterio INT
	,@CodigoDescripcion VARCHAR(100)
	,@RegionID INT
	,@ZonaID INT
	,@CodigoRegion VARCHAR(10)
	,@CodigoZona VARCHAR(10)
	,@ValidarOPT BIT = 0
AS
/*
dbo.GetProductoComercialByCampaniaBySearchRegionZona_SB2 201618,1,1,'97010',2701,2161,'50','5052'
dbo.GetProductoComercialByCampaniaBySearchRegionZona_SB2 201618,1,1,'97010',2701,2161,'50','5052',1
*/
BEGIN
	-- Depuramos las tallas y colores
	EXEC DepurarTallaColorCUV @CampaniaID

	EXEC DepurarTallaColorLiquidacion @CampaniaID

	DECLARE @OfertaProductoTemp TABLE (
		CampaniaID INT
		,CUV VARCHAR(6)
		,Descripcion VARCHAR(250)
		,ConfiguracionOfertaID INT
		,TipoOfertaSisID INT
		,PrecioOferta NUMERIC(12, 2)
		)

	INSERT INTO @OfertaProductoTemp
	SELECT op.CampaniaID
		,op.CUV
		,op.Descripcion
		,op.ConfiguracionOfertaID
		,op.TipoOfertaSisID
		,NULL
	FROM OfertaProducto op WITH (NOLOCK)
	INNER JOIN ods.Campania c ON op.CampaniaID = c.CampaniaID
	WHERE c.codigo = @CampaniaID

	INSERT INTO @OfertaProductoTemp
	SELECT c.CampaniaID
		,e.CUV2 AS CUV
		,e.DescripcionCUV2 AS Descripcion
		,ves.ConfiguracionOfertaID
		,ves.TipoOfertaSisID
		,NULL
	FROM dbo.Estrategia e WITH (NOLOCK)
	INNER JOIN ods.Campania c ON e.CampaniaID = c.Codigo
	INNER JOIN vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE c.codigo = @CampaniaID

	DECLARE @ProductoFaltanteTemp TABLE (CUV VARCHAR(6))

	INSERT INTO @ProductoFaltanteTemp
	SELECT DISTINCT ltrim(rtrim(CUV))
	FROM dbo.ProductoFaltante NOLOCK
	WHERE CampaniaID = @CampaniaID
		AND Zonaid = @ZonaID
	
	UNION ALL
	
	SELECT DISTINCT ltrim(rtrim(fa.CodigoVenta)) AS CUV
	FROM ods.FaltanteAnunciado fa(NOLOCK)
	INNER JOIN ods.Campania c(NOLOCK) ON fa.CampaniaID = c.CampaniaID
	WHERE c.Codigo = @CampaniaID
		AND (
			rtrim(fa.CodigoRegion) = @CodigoRegion
			OR fa.CodigoRegion IS NULL
			)
		AND (
			rtrim(fa.CodigoZona) = @CodigoZona
			OR fa.CodigoZona IS NULL
			)

	--Logica para Producto Sugerido
	DECLARE @TieneSugerido INT = 0

	IF EXISTS (
			SELECT 1
			FROM dbo.ProductoSugerido
			WHERE CampaniaID = @CampaniaID
				AND CUV = @CodigoDescripcion
				AND Estado = 1
			)
	BEGIN
		SET @TieneSugerido = 1
	END

	DECLARE @tablaCuvOPT TABLE (CUV VARCHAR(6))

	IF (@Criterio = 1)
	BEGIN
		SELECT DISTINCT TOP (@RowCount) p.CUV
			,coalesce(EST.DescripcionCUV2 + ' ' + tcc.Descripcion, est.descripcioncuv2, op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion) AS Descripcion
			,coalesce(est.precio2, op.PrecioOferta, pd.PrecioProducto * pd.FactorRepeticion, p.PrecioUnitario * p.FactorRepeticion) AS PrecioCatalogo
			,p.MarcaID
			,0 AS EstaEnRevista
			,(
				CASE 
					WHEN ISNULL(pf.CUV, 0) = 0
						THEN 1
					WHEN ISNULL(pf.CUV, 0) > 0
						THEN 0
					END
				) AS TieneStock
			,ISNULL(pcc.EsExpoOferta, 0) AS EsExpoOferta
			,ISNULL(pcc.CUVRevista, '') AS CUVRevista
			,'' AS CUVComplemento
			,p.PaisID
			,p.AnoCampania AS CampaniaID
			,p.CodigoCatalago
			,p.CodigoProducto
			,p.IndicadorMontoMinimo
			,M.Descripcion AS DescripcionMarca
			,'NO DISPONIBLE' AS DescripcionCategoria
			,TE.DescripcionEstrategia AS DescripcionEstrategia
			,ISNULL(op.ConfiguracionOfertaID, 0) ConfiguracionOfertaID
			,CASE 
				WHEN EXISTS (
						SELECT 1
						FROM TallaColorLiquidacion
						WHERE CampaniaID = @CampaniaID
							AND CUV = p.CUV
						)
					THEN 1702
				WHEN EXISTS (
						SELECT 1
						FROM TallaColorCUV
						WHERE CampaniaID = @CampaniaID
							AND CUV = p.CUV
						)
					THEN (
							SELECT E.TipoEstrategiaID
							FROM Estrategia E
							INNER JOIN TALLACOLORCUV TCC ON E.CAMPANIAID = TCC.CAMPANIAID
								AND E.CUV2 = TCC.CUVPADRE
							WHERE TCC.CUV = p.CUV
								AND E.CAMPANIAID = @CampaniaID
							)
				ELSE ISNULL(op.TipoOfertaSisID, 0)
				END TipoOfertaSisID
			,ISNULL(te.flagNueva, 0) FlagNueva
			,ISNULL(te.TipoEstrategiaID, '') TipoEstrategiaID
			,P.IndicadorOferta
			,@TieneSugerido AS TieneSugerido
			,CASE 
				WHEN pcor.SAP IS NULL
					THEN 0
				ELSE 1
				END TieneOfertaRevista
			,p.PrecioValorizado
			,CASE 
				WHEN pl.CodigoSAP IS NULL
					THEN 0
				ELSE 1
				END AS TieneLanzamientoCatalogoPersonalizado
			,ISNULL(pcor.Oferta, '') AS TipoOfertaRevista
			,TE.Codigo AS TipoEstrategiaCodigo
			,CASE 
				WHEN (
						TE.MostrarImgOfertaIndependiente = 1
						AND EST.EsOfertaIndependiente = 1
						)
					THEN 1
				ELSE 0
				END AS EsOfertaIndependiente
		FROM ods.ProductoComercial p WITH (NOLOCK)
		LEFT JOIN dbo.ProductoDescripcion pd WITH (NOLOCK) ON p.AnoCampania = pd.CampaniaID
			AND p.CUV = pd.CUV
		LEFT JOIN @ProductoFaltanteTemp pf ON p.CUV = pf.CUV
		LEFT JOIN ProductoComercialConfiguracion pcc ON p.AnoCampania = pcc.CampaniaID
			AND p.CUV = pcc.CUV
		LEFT JOIN @OfertaProductoTemp op ON op.CampaniaID = P.CampaniaID
			AND op.CUV = P.CUV
		LEFT JOIN MatrizComercial mc WITH (NOLOCK) ON p.CodigoProducto = mc.CodigoSAP
		LEFT JOIN Estrategia EST WITH (NOLOCK) ON
			--EST.CampaniaID = p.AnoCampania
			(
				EST.CampaniaID = p.AnoCampania
				OR p.AnoCampania BETWEEN EST.CampaniaID
					AND EST.CampaniaIDFin
				)
			AND (
				EST.CUV2 = p.CUV
				OR EST.CUV2 = (
					SELECT CUVPadre
					FROM TallaColorCUV TCC
					WHERE TCC.CUV = p.CUV
					)
				)
			AND EST.Activo = 1
		LEFT JOIN dbo.TallaColorCUV tcc WITH (NOLOCK) ON tcc.CUV = p.CUV
			AND tcc.CampaniaID = p.AnoCampania
		LEFT JOIN TipoEstrategia TE WITH (NOLOCK) ON TE.TipoEstrategiaID = EST.TipoEstrategiaID
		LEFT JOIN Marca M WITH (NOLOCK) ON p.MarcaId = M.MarcaId
		LEFT JOIN ods.ProductosLanzamiento pl WITH (NOLOCK) ON p.CodigoProducto = pl.CodigoSAP
			AND p.AnoCampania = pl.Campania
		LEFT JOIN ProductoComercialOfertaRevista pcor WITH (NOLOCK) ON p.AnoCampania = pcor.Campania
			AND p.CUV = pcor.CUV
		WHERE p.AnoCampania = @CampaniaID
			AND p.IndicadorDigitable = 1
			AND CHARINDEX(@CodigoDescripcion, p.CUV) > 0
			AND p.CUV NOT IN (
				SELECT CUV
				FROM @tablaCuvOPT
				)
	END
	ELSE
	BEGIN
		SELECT DISTINCT TOP (@RowCount) p.CUV
			,coalesce(est.descripcioncuv2, op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion) AS Descripcion
			,coalesce(est.precio2, op.PrecioOferta, pd.PrecioProducto * pd.FactorRepeticion, p.PrecioUnitario * p.FactorRepeticion) AS PrecioCatalogo
			,p.MarcaID
			,0 AS EstaEnRevista
			,(
				CASE 
					WHEN ISNULL(pf.CUV, 0) = 0
						THEN 1
					WHEN ISNULL(pf.CUV, 0) > 0
						THEN 0
					END
				) AS TieneStock
			,ISNULL(pcc.EsExpoOferta, 0) AS EsExpoOferta
			,ISNULL(pcc.CUVRevista, '') AS CUVRevista
			,'' AS CUVComplemento
			,p.PaisID
			,p.AnoCampania AS CampaniaID
			,p.CodigoCatalago
			,p.CodigoProducto
			,p.IndicadorMontoMinimo
			,M.Descripcion AS DescripcionMarca
			,'NO DISPONIBLE' AS DescripcionCategoria
			,TE.DescripcionEstrategia AS DescripcionEstrategia
			,ISNULL(op.ConfiguracionOfertaID, 0) ConfiguracionOfertaID
			,CASE 
				WHEN EXISTS (
						SELECT 1
						FROM TallaColorLiquidacion
						WHERE CampaniaID = @CampaniaID
							AND CUV = p.CUV
						)
					THEN 1702
				WHEN EXISTS (
						SELECT 1
						FROM TallaColorCUV
						WHERE CampaniaID = @CampaniaID
							AND CUV = p.CUV
						)
					THEN (
							SELECT E.TipoEstrategiaID
							FROM Estrategia E
							INNER JOIN TALLACOLORCUV TCC ON E.CAMPANIAID = TCC.CAMPANIAID
								AND E.CUV2 = TCC.CUVPADRE
							WHERE TCC.CUV = p.CUV
								AND E.CAMPANIAID = @CampaniaID
							)
				ELSE ISNULL(op.TipoOfertaSisID, 0)
				END TipoOfertaSisID
			,ISNULL(te.flagNueva, 0) FlagNueva
			,ISNULL(te.TipoEstrategiaID, '') TipoEstrategiaID
			,P.IndicadorOferta
			,@TieneSugerido AS TieneSugerido
			,CASE 
				WHEN pcor.SAP IS NULL
					THEN 0
				ELSE 1
				END TieneOfertaRevista
			,p.PrecioValorizado
			,CASE 
				WHEN pl.CodigoSAP IS NULL
					THEN 0
				ELSE 1
				END AS TieneLanzamientoCatalogoPersonalizado
			,ISNULL(pcor.Oferta, '') AS TipoOfertaRevista
			,TE.Codigo AS TipoEstrategiaCodigo
			,CASE 
				WHEN (
						TE.MostrarImgOfertaIndependiente = 1
						AND EST.EsOfertaIndependiente = 1
						)
					THEN 1
				ELSE 0
				END AS EsOfertaIndependiente
		FROM ods.ProductoComercial p WITH (NOLOCK)
		LEFT JOIN dbo.ProductoDescripcion pd WITH (NOLOCK) ON p.AnoCampania = pd.CampaniaID
			AND p.CUV = pd.CUV
		LEFT JOIN @ProductoFaltanteTemp pf ON p.CUV = pf.CUV
		LEFT JOIN ProductoComercialConfiguracion pcc WITH (NOLOCK) ON p.AnoCampania = pcc.CampaniaID
			AND p.CUV = pcc.CUV
		LEFT JOIN @OfertaProductoTemp op ON op.CampaniaID = P.CampaniaID
			AND op.CUV = P.CUV
		LEFT JOIN MatrizComercial mc WITH (NOLOCK) ON p.CodigoProducto = mc.CodigoSAP
		LEFT JOIN Estrategia EST WITH (NOLOCK) ON
			--EST.CampaniaID = p.AnoCampania
			(
				EST.CampaniaID = p.AnoCampania
				OR p.AnoCampania BETWEEN EST.CampaniaID
					AND EST.CampaniaIDFin
				)
			AND (
				EST.CUV2 = p.CUV
				OR EST.CUV2 = (
					SELECT CUVPadre
					FROM TallaColorCUV TCC
					WHERE TCC.CUV = p.CUV
					)
				)
			AND EST.Activo = 1
		LEFT JOIN TipoEstrategia TE WITH (NOLOCK) ON TE.TipoEstrategiaID = EST.TipoEstrategiaID
		LEFT JOIN Marca M ON p.MarcaId = M.MarcaId
		LEFT JOIN ods.ProductosLanzamiento pl WITH (NOLOCK) ON p.CodigoProducto = pl.CodigoSAP
			AND p.AnoCampania = pl.Campania
		LEFT JOIN ProductoComercialOfertaRevista pcor WITH (NOLOCK) ON p.AnoCampania = pcor.Campania
			AND p.CUV = pcor.CUV
		WHERE p.AnoCampania = @CampaniaID
			AND p.IndicadorDigitable = 1
			AND CHARINDEX(@CodigoDescripcion, coalesce(op.Descripcion, pd.Descripcion, p.Descripcion)) > 0
			AND p.CUV NOT IN (
				SELECT CUV
				FROM @tablaCuvOPT
				)
	END
END

GO

USE BelcorpEcuador
GO

GO

IF (OBJECT_ID('[dbo].[GetProductoComercialByCampaniaBySearchRegionZona_SB2]', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE [dbo].[GetProductoComercialByCampaniaBySearchRegionZona_SB2] AS SET NOCOUNT ON;')
GO

ALTER PROCEDURE [dbo].[GetProductoComercialByCampaniaBySearchRegionZona_SB2] @CampaniaID INT
	,@RowCount INT
	,@Criterio INT
	,@CodigoDescripcion VARCHAR(100)
	,@RegionID INT
	,@ZonaID INT
	,@CodigoRegion VARCHAR(10)
	,@CodigoZona VARCHAR(10)
	,@ValidarOPT BIT = 0
AS
/*
dbo.GetProductoComercialByCampaniaBySearchRegionZona_SB2 201618,1,1,'97010',2701,2161,'50','5052'
dbo.GetProductoComercialByCampaniaBySearchRegionZona_SB2 201618,1,1,'97010',2701,2161,'50','5052',1
*/
BEGIN
	-- Depuramos las tallas y colores
	EXEC DepurarTallaColorCUV @CampaniaID

	EXEC DepurarTallaColorLiquidacion @CampaniaID

	DECLARE @OfertaProductoTemp TABLE (
		CampaniaID INT
		,CUV VARCHAR(6)
		,Descripcion VARCHAR(250)
		,ConfiguracionOfertaID INT
		,TipoOfertaSisID INT
		,PrecioOferta NUMERIC(12, 2)
		)

	INSERT INTO @OfertaProductoTemp
	SELECT op.CampaniaID
		,op.CUV
		,op.Descripcion
		,op.ConfiguracionOfertaID
		,op.TipoOfertaSisID
		,NULL
	FROM OfertaProducto op WITH (NOLOCK)
	INNER JOIN ods.Campania c ON op.CampaniaID = c.CampaniaID
	WHERE c.codigo = @CampaniaID

	INSERT INTO @OfertaProductoTemp
	SELECT c.CampaniaID
		,e.CUV2 AS CUV
		,e.DescripcionCUV2 AS Descripcion
		,ves.ConfiguracionOfertaID
		,ves.TipoOfertaSisID
		,NULL
	FROM dbo.Estrategia e WITH (NOLOCK)
	INNER JOIN ods.Campania c ON e.CampaniaID = c.Codigo
	INNER JOIN vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE c.codigo = @CampaniaID

	DECLARE @ProductoFaltanteTemp TABLE (CUV VARCHAR(6))

	INSERT INTO @ProductoFaltanteTemp
	SELECT DISTINCT ltrim(rtrim(CUV))
	FROM dbo.ProductoFaltante NOLOCK
	WHERE CampaniaID = @CampaniaID
		AND Zonaid = @ZonaID
	
	UNION ALL
	
	SELECT DISTINCT ltrim(rtrim(fa.CodigoVenta)) AS CUV
	FROM ods.FaltanteAnunciado fa(NOLOCK)
	INNER JOIN ods.Campania c(NOLOCK) ON fa.CampaniaID = c.CampaniaID
	WHERE c.Codigo = @CampaniaID
		AND (
			rtrim(fa.CodigoRegion) = @CodigoRegion
			OR fa.CodigoRegion IS NULL
			)
		AND (
			rtrim(fa.CodigoZona) = @CodigoZona
			OR fa.CodigoZona IS NULL
			)

	--Logica para Producto Sugerido
	DECLARE @TieneSugerido INT = 0

	IF EXISTS (
			SELECT 1
			FROM dbo.ProductoSugerido
			WHERE CampaniaID = @CampaniaID
				AND CUV = @CodigoDescripcion
				AND Estado = 1
			)
	BEGIN
		SET @TieneSugerido = 1
	END

	DECLARE @tablaCuvOPT TABLE (CUV VARCHAR(6))

	IF (@Criterio = 1)
	BEGIN
		SELECT DISTINCT TOP (@RowCount) p.CUV
			,coalesce(EST.DescripcionCUV2 + ' ' + tcc.Descripcion, est.descripcioncuv2, op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion) AS Descripcion
			,coalesce(est.precio2, op.PrecioOferta, pd.PrecioProducto * pd.FactorRepeticion, p.PrecioUnitario * p.FactorRepeticion) AS PrecioCatalogo
			,p.MarcaID
			,0 AS EstaEnRevista
			,(
				CASE 
					WHEN ISNULL(pf.CUV, 0) = 0
						THEN 1
					WHEN ISNULL(pf.CUV, 0) > 0
						THEN 0
					END
				) AS TieneStock
			,ISNULL(pcc.EsExpoOferta, 0) AS EsExpoOferta
			,ISNULL(pcc.CUVRevista, '') AS CUVRevista
			,'' AS CUVComplemento
			,p.PaisID
			,p.AnoCampania AS CampaniaID
			,p.CodigoCatalago
			,p.CodigoProducto
			,p.IndicadorMontoMinimo
			,M.Descripcion AS DescripcionMarca
			,'NO DISPONIBLE' AS DescripcionCategoria
			,TE.DescripcionEstrategia AS DescripcionEstrategia
			,ISNULL(op.ConfiguracionOfertaID, 0) ConfiguracionOfertaID
			,CASE 
				WHEN EXISTS (
						SELECT 1
						FROM TallaColorLiquidacion
						WHERE CampaniaID = @CampaniaID
							AND CUV = p.CUV
						)
					THEN 1702
				WHEN EXISTS (
						SELECT 1
						FROM TallaColorCUV
						WHERE CampaniaID = @CampaniaID
							AND CUV = p.CUV
						)
					THEN (
							SELECT E.TipoEstrategiaID
							FROM Estrategia E
							INNER JOIN TALLACOLORCUV TCC ON E.CAMPANIAID = TCC.CAMPANIAID
								AND E.CUV2 = TCC.CUVPADRE
							WHERE TCC.CUV = p.CUV
								AND E.CAMPANIAID = @CampaniaID
							)
				ELSE ISNULL(op.TipoOfertaSisID, 0)
				END TipoOfertaSisID
			,ISNULL(te.flagNueva, 0) FlagNueva
			,ISNULL(te.TipoEstrategiaID, '') TipoEstrategiaID
			,P.IndicadorOferta
			,@TieneSugerido AS TieneSugerido
			,CASE 
				WHEN pcor.SAP IS NULL
					THEN 0
				ELSE 1
				END TieneOfertaRevista
			,p.PrecioValorizado
			,CASE 
				WHEN pl.CodigoSAP IS NULL
					THEN 0
				ELSE 1
				END AS TieneLanzamientoCatalogoPersonalizado
			,ISNULL(pcor.Oferta, '') AS TipoOfertaRevista
			,TE.Codigo AS TipoEstrategiaCodigo
			,CASE 
				WHEN (
						TE.MostrarImgOfertaIndependiente = 1
						AND EST.EsOfertaIndependiente = 1
						)
					THEN 1
				ELSE 0
				END AS EsOfertaIndependiente
		FROM ods.ProductoComercial p WITH (NOLOCK)
		LEFT JOIN dbo.ProductoDescripcion pd WITH (NOLOCK) ON p.AnoCampania = pd.CampaniaID
			AND p.CUV = pd.CUV
		LEFT JOIN @ProductoFaltanteTemp pf ON p.CUV = pf.CUV
		LEFT JOIN ProductoComercialConfiguracion pcc ON p.AnoCampania = pcc.CampaniaID
			AND p.CUV = pcc.CUV
		LEFT JOIN @OfertaProductoTemp op ON op.CampaniaID = P.CampaniaID
			AND op.CUV = P.CUV
		LEFT JOIN MatrizComercial mc WITH (NOLOCK) ON p.CodigoProducto = mc.CodigoSAP
		LEFT JOIN Estrategia EST WITH (NOLOCK) ON
			--EST.CampaniaID = p.AnoCampania
			(
				EST.CampaniaID = p.AnoCampania
				OR p.AnoCampania BETWEEN EST.CampaniaID
					AND EST.CampaniaIDFin
				)
			AND (
				EST.CUV2 = p.CUV
				OR EST.CUV2 = (
					SELECT CUVPadre
					FROM TallaColorCUV TCC
					WHERE TCC.CUV = p.CUV
					)
				)
			AND EST.Activo = 1
		LEFT JOIN dbo.TallaColorCUV tcc WITH (NOLOCK) ON tcc.CUV = p.CUV
			AND tcc.CampaniaID = p.AnoCampania
		LEFT JOIN TipoEstrategia TE WITH (NOLOCK) ON TE.TipoEstrategiaID = EST.TipoEstrategiaID
		LEFT JOIN Marca M WITH (NOLOCK) ON p.MarcaId = M.MarcaId
		LEFT JOIN ods.ProductosLanzamiento pl WITH (NOLOCK) ON p.CodigoProducto = pl.CodigoSAP
			AND p.AnoCampania = pl.Campania
		LEFT JOIN ProductoComercialOfertaRevista pcor WITH (NOLOCK) ON p.AnoCampania = pcor.Campania
			AND p.CUV = pcor.CUV
		WHERE p.AnoCampania = @CampaniaID
			AND p.IndicadorDigitable = 1
			AND CHARINDEX(@CodigoDescripcion, p.CUV) > 0
			AND p.CUV NOT IN (
				SELECT CUV
				FROM @tablaCuvOPT
				)
	END
	ELSE
	BEGIN
		SELECT DISTINCT TOP (@RowCount) p.CUV
			,coalesce(est.descripcioncuv2, op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion) AS Descripcion
			,coalesce(est.precio2, op.PrecioOferta, pd.PrecioProducto * pd.FactorRepeticion, p.PrecioUnitario * p.FactorRepeticion) AS PrecioCatalogo
			,p.MarcaID
			,0 AS EstaEnRevista
			,(
				CASE 
					WHEN ISNULL(pf.CUV, 0) = 0
						THEN 1
					WHEN ISNULL(pf.CUV, 0) > 0
						THEN 0
					END
				) AS TieneStock
			,ISNULL(pcc.EsExpoOferta, 0) AS EsExpoOferta
			,ISNULL(pcc.CUVRevista, '') AS CUVRevista
			,'' AS CUVComplemento
			,p.PaisID
			,p.AnoCampania AS CampaniaID
			,p.CodigoCatalago
			,p.CodigoProducto
			,p.IndicadorMontoMinimo
			,M.Descripcion AS DescripcionMarca
			,'NO DISPONIBLE' AS DescripcionCategoria
			,TE.DescripcionEstrategia AS DescripcionEstrategia
			,ISNULL(op.ConfiguracionOfertaID, 0) ConfiguracionOfertaID
			,CASE 
				WHEN EXISTS (
						SELECT 1
						FROM TallaColorLiquidacion
						WHERE CampaniaID = @CampaniaID
							AND CUV = p.CUV
						)
					THEN 1702
				WHEN EXISTS (
						SELECT 1
						FROM TallaColorCUV
						WHERE CampaniaID = @CampaniaID
							AND CUV = p.CUV
						)
					THEN (
							SELECT E.TipoEstrategiaID
							FROM Estrategia E
							INNER JOIN TALLACOLORCUV TCC ON E.CAMPANIAID = TCC.CAMPANIAID
								AND E.CUV2 = TCC.CUVPADRE
							WHERE TCC.CUV = p.CUV
								AND E.CAMPANIAID = @CampaniaID
							)
				ELSE ISNULL(op.TipoOfertaSisID, 0)
				END TipoOfertaSisID
			,ISNULL(te.flagNueva, 0) FlagNueva
			,ISNULL(te.TipoEstrategiaID, '') TipoEstrategiaID
			,P.IndicadorOferta
			,@TieneSugerido AS TieneSugerido
			,CASE 
				WHEN pcor.SAP IS NULL
					THEN 0
				ELSE 1
				END TieneOfertaRevista
			,p.PrecioValorizado
			,CASE 
				WHEN pl.CodigoSAP IS NULL
					THEN 0
				ELSE 1
				END AS TieneLanzamientoCatalogoPersonalizado
			,ISNULL(pcor.Oferta, '') AS TipoOfertaRevista
			,TE.Codigo AS TipoEstrategiaCodigo
			,CASE 
				WHEN (
						TE.MostrarImgOfertaIndependiente = 1
						AND EST.EsOfertaIndependiente = 1
						)
					THEN 1
				ELSE 0
				END AS EsOfertaIndependiente
		FROM ods.ProductoComercial p WITH (NOLOCK)
		LEFT JOIN dbo.ProductoDescripcion pd WITH (NOLOCK) ON p.AnoCampania = pd.CampaniaID
			AND p.CUV = pd.CUV
		LEFT JOIN @ProductoFaltanteTemp pf ON p.CUV = pf.CUV
		LEFT JOIN ProductoComercialConfiguracion pcc WITH (NOLOCK) ON p.AnoCampania = pcc.CampaniaID
			AND p.CUV = pcc.CUV
		LEFT JOIN @OfertaProductoTemp op ON op.CampaniaID = P.CampaniaID
			AND op.CUV = P.CUV
		LEFT JOIN MatrizComercial mc WITH (NOLOCK) ON p.CodigoProducto = mc.CodigoSAP
		LEFT JOIN Estrategia EST WITH (NOLOCK) ON
			--EST.CampaniaID = p.AnoCampania
			(
				EST.CampaniaID = p.AnoCampania
				OR p.AnoCampania BETWEEN EST.CampaniaID
					AND EST.CampaniaIDFin
				)
			AND (
				EST.CUV2 = p.CUV
				OR EST.CUV2 = (
					SELECT CUVPadre
					FROM TallaColorCUV TCC
					WHERE TCC.CUV = p.CUV
					)
				)
			AND EST.Activo = 1
		LEFT JOIN TipoEstrategia TE WITH (NOLOCK) ON TE.TipoEstrategiaID = EST.TipoEstrategiaID
		LEFT JOIN Marca M ON p.MarcaId = M.MarcaId
		LEFT JOIN ods.ProductosLanzamiento pl WITH (NOLOCK) ON p.CodigoProducto = pl.CodigoSAP
			AND p.AnoCampania = pl.Campania
		LEFT JOIN ProductoComercialOfertaRevista pcor WITH (NOLOCK) ON p.AnoCampania = pcor.Campania
			AND p.CUV = pcor.CUV
		WHERE p.AnoCampania = @CampaniaID
			AND p.IndicadorDigitable = 1
			AND CHARINDEX(@CodigoDescripcion, coalesce(op.Descripcion, pd.Descripcion, p.Descripcion)) > 0
			AND p.CUV NOT IN (
				SELECT CUV
				FROM @tablaCuvOPT
				)
	END
END

GO

USE BelcorpDominicana
GO

GO

IF (OBJECT_ID('[dbo].[GetProductoComercialByCampaniaBySearchRegionZona_SB2]', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE [dbo].[GetProductoComercialByCampaniaBySearchRegionZona_SB2] AS SET NOCOUNT ON;')
GO

ALTER PROCEDURE [dbo].[GetProductoComercialByCampaniaBySearchRegionZona_SB2] @CampaniaID INT
	,@RowCount INT
	,@Criterio INT
	,@CodigoDescripcion VARCHAR(100)
	,@RegionID INT
	,@ZonaID INT
	,@CodigoRegion VARCHAR(10)
	,@CodigoZona VARCHAR(10)
	,@ValidarOPT BIT = 0
AS
/*
dbo.GetProductoComercialByCampaniaBySearchRegionZona_SB2 201618,1,1,'97010',2701,2161,'50','5052'
dbo.GetProductoComercialByCampaniaBySearchRegionZona_SB2 201618,1,1,'97010',2701,2161,'50','5052',1
*/
BEGIN
	-- Depuramos las tallas y colores
	EXEC DepurarTallaColorCUV @CampaniaID

	EXEC DepurarTallaColorLiquidacion @CampaniaID

	DECLARE @OfertaProductoTemp TABLE (
		CampaniaID INT
		,CUV VARCHAR(6)
		,Descripcion VARCHAR(250)
		,ConfiguracionOfertaID INT
		,TipoOfertaSisID INT
		,PrecioOferta NUMERIC(12, 2)
		)

	INSERT INTO @OfertaProductoTemp
	SELECT op.CampaniaID
		,op.CUV
		,op.Descripcion
		,op.ConfiguracionOfertaID
		,op.TipoOfertaSisID
		,NULL
	FROM OfertaProducto op WITH (NOLOCK)
	INNER JOIN ods.Campania c ON op.CampaniaID = c.CampaniaID
	WHERE c.codigo = @CampaniaID

	INSERT INTO @OfertaProductoTemp
	SELECT c.CampaniaID
		,e.CUV2 AS CUV
		,e.DescripcionCUV2 AS Descripcion
		,ves.ConfiguracionOfertaID
		,ves.TipoOfertaSisID
		,NULL
	FROM dbo.Estrategia e WITH (NOLOCK)
	INNER JOIN ods.Campania c ON e.CampaniaID = c.Codigo
	INNER JOIN vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE c.codigo = @CampaniaID

	DECLARE @ProductoFaltanteTemp TABLE (CUV VARCHAR(6))

	INSERT INTO @ProductoFaltanteTemp
	SELECT DISTINCT ltrim(rtrim(CUV))
	FROM dbo.ProductoFaltante NOLOCK
	WHERE CampaniaID = @CampaniaID
		AND Zonaid = @ZonaID
	
	UNION ALL
	
	SELECT DISTINCT ltrim(rtrim(fa.CodigoVenta)) AS CUV
	FROM ods.FaltanteAnunciado fa(NOLOCK)
	INNER JOIN ods.Campania c(NOLOCK) ON fa.CampaniaID = c.CampaniaID
	WHERE c.Codigo = @CampaniaID
		AND (
			rtrim(fa.CodigoRegion) = @CodigoRegion
			OR fa.CodigoRegion IS NULL
			)
		AND (
			rtrim(fa.CodigoZona) = @CodigoZona
			OR fa.CodigoZona IS NULL
			)

	--Logica para Producto Sugerido
	DECLARE @TieneSugerido INT = 0

	IF EXISTS (
			SELECT 1
			FROM dbo.ProductoSugerido
			WHERE CampaniaID = @CampaniaID
				AND CUV = @CodigoDescripcion
				AND Estado = 1
			)
	BEGIN
		SET @TieneSugerido = 1
	END

	DECLARE @tablaCuvOPT TABLE (CUV VARCHAR(6))

	IF (@Criterio = 1)
	BEGIN
		SELECT DISTINCT TOP (@RowCount) p.CUV
			,coalesce(EST.DescripcionCUV2 + ' ' + tcc.Descripcion, est.descripcioncuv2, op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion) AS Descripcion
			,coalesce(est.precio2, op.PrecioOferta, pd.PrecioProducto * pd.FactorRepeticion, p.PrecioUnitario * p.FactorRepeticion) AS PrecioCatalogo
			,p.MarcaID
			,0 AS EstaEnRevista
			,(
				CASE 
					WHEN ISNULL(pf.CUV, 0) = 0
						THEN 1
					WHEN ISNULL(pf.CUV, 0) > 0
						THEN 0
					END
				) AS TieneStock
			,ISNULL(pcc.EsExpoOferta, 0) AS EsExpoOferta
			,ISNULL(pcc.CUVRevista, '') AS CUVRevista
			,'' AS CUVComplemento
			,p.PaisID
			,p.AnoCampania AS CampaniaID
			,p.CodigoCatalago
			,p.CodigoProducto
			,p.IndicadorMontoMinimo
			,M.Descripcion AS DescripcionMarca
			,'NO DISPONIBLE' AS DescripcionCategoria
			,TE.DescripcionEstrategia AS DescripcionEstrategia
			,ISNULL(op.ConfiguracionOfertaID, 0) ConfiguracionOfertaID
			,CASE 
				WHEN EXISTS (
						SELECT 1
						FROM TallaColorLiquidacion
						WHERE CampaniaID = @CampaniaID
							AND CUV = p.CUV
						)
					THEN 1702
				WHEN EXISTS (
						SELECT 1
						FROM TallaColorCUV
						WHERE CampaniaID = @CampaniaID
							AND CUV = p.CUV
						)
					THEN (
							SELECT E.TipoEstrategiaID
							FROM Estrategia E
							INNER JOIN TALLACOLORCUV TCC ON E.CAMPANIAID = TCC.CAMPANIAID
								AND E.CUV2 = TCC.CUVPADRE
							WHERE TCC.CUV = p.CUV
								AND E.CAMPANIAID = @CampaniaID
							)
				ELSE ISNULL(op.TipoOfertaSisID, 0)
				END TipoOfertaSisID
			,ISNULL(te.flagNueva, 0) FlagNueva
			,ISNULL(te.TipoEstrategiaID, '') TipoEstrategiaID
			,P.IndicadorOferta
			,@TieneSugerido AS TieneSugerido
			,CASE 
				WHEN pcor.SAP IS NULL
					THEN 0
				ELSE 1
				END TieneOfertaRevista
			,p.PrecioValorizado
			,CASE 
				WHEN pl.CodigoSAP IS NULL
					THEN 0
				ELSE 1
				END AS TieneLanzamientoCatalogoPersonalizado
			,ISNULL(pcor.Oferta, '') AS TipoOfertaRevista
			,TE.Codigo AS TipoEstrategiaCodigo
			,CASE 
				WHEN (
						TE.MostrarImgOfertaIndependiente = 1
						AND EST.EsOfertaIndependiente = 1
						)
					THEN 1
				ELSE 0
				END AS EsOfertaIndependiente
		FROM ods.ProductoComercial p WITH (NOLOCK)
		LEFT JOIN dbo.ProductoDescripcion pd WITH (NOLOCK) ON p.AnoCampania = pd.CampaniaID
			AND p.CUV = pd.CUV
		LEFT JOIN @ProductoFaltanteTemp pf ON p.CUV = pf.CUV
		LEFT JOIN ProductoComercialConfiguracion pcc ON p.AnoCampania = pcc.CampaniaID
			AND p.CUV = pcc.CUV
		LEFT JOIN @OfertaProductoTemp op ON op.CampaniaID = P.CampaniaID
			AND op.CUV = P.CUV
		LEFT JOIN MatrizComercial mc WITH (NOLOCK) ON p.CodigoProducto = mc.CodigoSAP
		LEFT JOIN Estrategia EST WITH (NOLOCK) ON
			--EST.CampaniaID = p.AnoCampania
			(
				EST.CampaniaID = p.AnoCampania
				OR p.AnoCampania BETWEEN EST.CampaniaID
					AND EST.CampaniaIDFin
				)
			AND (
				EST.CUV2 = p.CUV
				OR EST.CUV2 = (
					SELECT CUVPadre
					FROM TallaColorCUV TCC
					WHERE TCC.CUV = p.CUV
					)
				)
			AND EST.Activo = 1
		LEFT JOIN dbo.TallaColorCUV tcc WITH (NOLOCK) ON tcc.CUV = p.CUV
			AND tcc.CampaniaID = p.AnoCampania
		LEFT JOIN TipoEstrategia TE WITH (NOLOCK) ON TE.TipoEstrategiaID = EST.TipoEstrategiaID
		LEFT JOIN Marca M WITH (NOLOCK) ON p.MarcaId = M.MarcaId
		LEFT JOIN ods.ProductosLanzamiento pl WITH (NOLOCK) ON p.CodigoProducto = pl.CodigoSAP
			AND p.AnoCampania = pl.Campania
		LEFT JOIN ProductoComercialOfertaRevista pcor WITH (NOLOCK) ON p.AnoCampania = pcor.Campania
			AND p.CUV = pcor.CUV
		WHERE p.AnoCampania = @CampaniaID
			AND p.IndicadorDigitable = 1
			AND CHARINDEX(@CodigoDescripcion, p.CUV) > 0
			AND p.CUV NOT IN (
				SELECT CUV
				FROM @tablaCuvOPT
				)
	END
	ELSE
	BEGIN
		SELECT DISTINCT TOP (@RowCount) p.CUV
			,coalesce(est.descripcioncuv2, op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion) AS Descripcion
			,coalesce(est.precio2, op.PrecioOferta, pd.PrecioProducto * pd.FactorRepeticion, p.PrecioUnitario * p.FactorRepeticion) AS PrecioCatalogo
			,p.MarcaID
			,0 AS EstaEnRevista
			,(
				CASE 
					WHEN ISNULL(pf.CUV, 0) = 0
						THEN 1
					WHEN ISNULL(pf.CUV, 0) > 0
						THEN 0
					END
				) AS TieneStock
			,ISNULL(pcc.EsExpoOferta, 0) AS EsExpoOferta
			,ISNULL(pcc.CUVRevista, '') AS CUVRevista
			,'' AS CUVComplemento
			,p.PaisID
			,p.AnoCampania AS CampaniaID
			,p.CodigoCatalago
			,p.CodigoProducto
			,p.IndicadorMontoMinimo
			,M.Descripcion AS DescripcionMarca
			,'NO DISPONIBLE' AS DescripcionCategoria
			,TE.DescripcionEstrategia AS DescripcionEstrategia
			,ISNULL(op.ConfiguracionOfertaID, 0) ConfiguracionOfertaID
			,CASE 
				WHEN EXISTS (
						SELECT 1
						FROM TallaColorLiquidacion
						WHERE CampaniaID = @CampaniaID
							AND CUV = p.CUV
						)
					THEN 1702
				WHEN EXISTS (
						SELECT 1
						FROM TallaColorCUV
						WHERE CampaniaID = @CampaniaID
							AND CUV = p.CUV
						)
					THEN (
							SELECT E.TipoEstrategiaID
							FROM Estrategia E
							INNER JOIN TALLACOLORCUV TCC ON E.CAMPANIAID = TCC.CAMPANIAID
								AND E.CUV2 = TCC.CUVPADRE
							WHERE TCC.CUV = p.CUV
								AND E.CAMPANIAID = @CampaniaID
							)
				ELSE ISNULL(op.TipoOfertaSisID, 0)
				END TipoOfertaSisID
			,ISNULL(te.flagNueva, 0) FlagNueva
			,ISNULL(te.TipoEstrategiaID, '') TipoEstrategiaID
			,P.IndicadorOferta
			,@TieneSugerido AS TieneSugerido
			,CASE 
				WHEN pcor.SAP IS NULL
					THEN 0
				ELSE 1
				END TieneOfertaRevista
			,p.PrecioValorizado
			,CASE 
				WHEN pl.CodigoSAP IS NULL
					THEN 0
				ELSE 1
				END AS TieneLanzamientoCatalogoPersonalizado
			,ISNULL(pcor.Oferta, '') AS TipoOfertaRevista
			,TE.Codigo AS TipoEstrategiaCodigo
			,CASE 
				WHEN (
						TE.MostrarImgOfertaIndependiente = 1
						AND EST.EsOfertaIndependiente = 1
						)
					THEN 1
				ELSE 0
				END AS EsOfertaIndependiente
		FROM ods.ProductoComercial p WITH (NOLOCK)
		LEFT JOIN dbo.ProductoDescripcion pd WITH (NOLOCK) ON p.AnoCampania = pd.CampaniaID
			AND p.CUV = pd.CUV
		LEFT JOIN @ProductoFaltanteTemp pf ON p.CUV = pf.CUV
		LEFT JOIN ProductoComercialConfiguracion pcc WITH (NOLOCK) ON p.AnoCampania = pcc.CampaniaID
			AND p.CUV = pcc.CUV
		LEFT JOIN @OfertaProductoTemp op ON op.CampaniaID = P.CampaniaID
			AND op.CUV = P.CUV
		LEFT JOIN MatrizComercial mc WITH (NOLOCK) ON p.CodigoProducto = mc.CodigoSAP
		LEFT JOIN Estrategia EST WITH (NOLOCK) ON
			--EST.CampaniaID = p.AnoCampania
			(
				EST.CampaniaID = p.AnoCampania
				OR p.AnoCampania BETWEEN EST.CampaniaID
					AND EST.CampaniaIDFin
				)
			AND (
				EST.CUV2 = p.CUV
				OR EST.CUV2 = (
					SELECT CUVPadre
					FROM TallaColorCUV TCC
					WHERE TCC.CUV = p.CUV
					)
				)
			AND EST.Activo = 1
		LEFT JOIN TipoEstrategia TE WITH (NOLOCK) ON TE.TipoEstrategiaID = EST.TipoEstrategiaID
		LEFT JOIN Marca M ON p.MarcaId = M.MarcaId
		LEFT JOIN ods.ProductosLanzamiento pl WITH (NOLOCK) ON p.CodigoProducto = pl.CodigoSAP
			AND p.AnoCampania = pl.Campania
		LEFT JOIN ProductoComercialOfertaRevista pcor WITH (NOLOCK) ON p.AnoCampania = pcor.Campania
			AND p.CUV = pcor.CUV
		WHERE p.AnoCampania = @CampaniaID
			AND p.IndicadorDigitable = 1
			AND CHARINDEX(@CodigoDescripcion, coalesce(op.Descripcion, pd.Descripcion, p.Descripcion)) > 0
			AND p.CUV NOT IN (
				SELECT CUV
				FROM @tablaCuvOPT
				)
	END
END

GO

USE BelcorpCostaRica
GO

GO

IF (OBJECT_ID('[dbo].[GetProductoComercialByCampaniaBySearchRegionZona_SB2]', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE [dbo].[GetProductoComercialByCampaniaBySearchRegionZona_SB2] AS SET NOCOUNT ON;')
GO

ALTER PROCEDURE [dbo].[GetProductoComercialByCampaniaBySearchRegionZona_SB2] @CampaniaID INT
	,@RowCount INT
	,@Criterio INT
	,@CodigoDescripcion VARCHAR(100)
	,@RegionID INT
	,@ZonaID INT
	,@CodigoRegion VARCHAR(10)
	,@CodigoZona VARCHAR(10)
	,@ValidarOPT BIT = 0
AS
/*
dbo.GetProductoComercialByCampaniaBySearchRegionZona_SB2 201618,1,1,'97010',2701,2161,'50','5052'
dbo.GetProductoComercialByCampaniaBySearchRegionZona_SB2 201618,1,1,'97010',2701,2161,'50','5052',1
*/
BEGIN
	-- Depuramos las tallas y colores
	EXEC DepurarTallaColorCUV @CampaniaID

	EXEC DepurarTallaColorLiquidacion @CampaniaID

	DECLARE @OfertaProductoTemp TABLE (
		CampaniaID INT
		,CUV VARCHAR(6)
		,Descripcion VARCHAR(250)
		,ConfiguracionOfertaID INT
		,TipoOfertaSisID INT
		,PrecioOferta NUMERIC(12, 2)
		)

	INSERT INTO @OfertaProductoTemp
	SELECT op.CampaniaID
		,op.CUV
		,op.Descripcion
		,op.ConfiguracionOfertaID
		,op.TipoOfertaSisID
		,NULL
	FROM OfertaProducto op WITH (NOLOCK)
	INNER JOIN ods.Campania c ON op.CampaniaID = c.CampaniaID
	WHERE c.codigo = @CampaniaID

	INSERT INTO @OfertaProductoTemp
	SELECT c.CampaniaID
		,e.CUV2 AS CUV
		,e.DescripcionCUV2 AS Descripcion
		,ves.ConfiguracionOfertaID
		,ves.TipoOfertaSisID
		,NULL
	FROM dbo.Estrategia e WITH (NOLOCK)
	INNER JOIN ods.Campania c ON e.CampaniaID = c.Codigo
	INNER JOIN vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE c.codigo = @CampaniaID

	DECLARE @ProductoFaltanteTemp TABLE (CUV VARCHAR(6))

	INSERT INTO @ProductoFaltanteTemp
	SELECT DISTINCT ltrim(rtrim(CUV))
	FROM dbo.ProductoFaltante NOLOCK
	WHERE CampaniaID = @CampaniaID
		AND Zonaid = @ZonaID
	
	UNION ALL
	
	SELECT DISTINCT ltrim(rtrim(fa.CodigoVenta)) AS CUV
	FROM ods.FaltanteAnunciado fa(NOLOCK)
	INNER JOIN ods.Campania c(NOLOCK) ON fa.CampaniaID = c.CampaniaID
	WHERE c.Codigo = @CampaniaID
		AND (
			rtrim(fa.CodigoRegion) = @CodigoRegion
			OR fa.CodigoRegion IS NULL
			)
		AND (
			rtrim(fa.CodigoZona) = @CodigoZona
			OR fa.CodigoZona IS NULL
			)

	--Logica para Producto Sugerido
	DECLARE @TieneSugerido INT = 0

	IF EXISTS (
			SELECT 1
			FROM dbo.ProductoSugerido
			WHERE CampaniaID = @CampaniaID
				AND CUV = @CodigoDescripcion
				AND Estado = 1
			)
	BEGIN
		SET @TieneSugerido = 1
	END

	DECLARE @tablaCuvOPT TABLE (CUV VARCHAR(6))

	IF (@Criterio = 1)
	BEGIN
		SELECT DISTINCT TOP (@RowCount) p.CUV
			,coalesce(EST.DescripcionCUV2 + ' ' + tcc.Descripcion, est.descripcioncuv2, op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion) AS Descripcion
			,coalesce(est.precio2, op.PrecioOferta, pd.PrecioProducto * pd.FactorRepeticion, p.PrecioUnitario * p.FactorRepeticion) AS PrecioCatalogo
			,p.MarcaID
			,0 AS EstaEnRevista
			,(
				CASE 
					WHEN ISNULL(pf.CUV, 0) = 0
						THEN 1
					WHEN ISNULL(pf.CUV, 0) > 0
						THEN 0
					END
				) AS TieneStock
			,ISNULL(pcc.EsExpoOferta, 0) AS EsExpoOferta
			,ISNULL(pcc.CUVRevista, '') AS CUVRevista
			,'' AS CUVComplemento
			,p.PaisID
			,p.AnoCampania AS CampaniaID
			,p.CodigoCatalago
			,p.CodigoProducto
			,p.IndicadorMontoMinimo
			,M.Descripcion AS DescripcionMarca
			,'NO DISPONIBLE' AS DescripcionCategoria
			,TE.DescripcionEstrategia AS DescripcionEstrategia
			,ISNULL(op.ConfiguracionOfertaID, 0) ConfiguracionOfertaID
			,CASE 
				WHEN EXISTS (
						SELECT 1
						FROM TallaColorLiquidacion
						WHERE CampaniaID = @CampaniaID
							AND CUV = p.CUV
						)
					THEN 1702
				WHEN EXISTS (
						SELECT 1
						FROM TallaColorCUV
						WHERE CampaniaID = @CampaniaID
							AND CUV = p.CUV
						)
					THEN (
							SELECT E.TipoEstrategiaID
							FROM Estrategia E
							INNER JOIN TALLACOLORCUV TCC ON E.CAMPANIAID = TCC.CAMPANIAID
								AND E.CUV2 = TCC.CUVPADRE
							WHERE TCC.CUV = p.CUV
								AND E.CAMPANIAID = @CampaniaID
							)
				ELSE ISNULL(op.TipoOfertaSisID, 0)
				END TipoOfertaSisID
			,ISNULL(te.flagNueva, 0) FlagNueva
			,ISNULL(te.TipoEstrategiaID, '') TipoEstrategiaID
			,P.IndicadorOferta
			,@TieneSugerido AS TieneSugerido
			,CASE 
				WHEN pcor.SAP IS NULL
					THEN 0
				ELSE 1
				END TieneOfertaRevista
			,p.PrecioValorizado
			,CASE 
				WHEN pl.CodigoSAP IS NULL
					THEN 0
				ELSE 1
				END AS TieneLanzamientoCatalogoPersonalizado
			,ISNULL(pcor.Oferta, '') AS TipoOfertaRevista
			,TE.Codigo AS TipoEstrategiaCodigo
			,CASE 
				WHEN (
						TE.MostrarImgOfertaIndependiente = 1
						AND EST.EsOfertaIndependiente = 1
						)
					THEN 1
				ELSE 0
				END AS EsOfertaIndependiente
		FROM ods.ProductoComercial p WITH (NOLOCK)
		LEFT JOIN dbo.ProductoDescripcion pd WITH (NOLOCK) ON p.AnoCampania = pd.CampaniaID
			AND p.CUV = pd.CUV
		LEFT JOIN @ProductoFaltanteTemp pf ON p.CUV = pf.CUV
		LEFT JOIN ProductoComercialConfiguracion pcc ON p.AnoCampania = pcc.CampaniaID
			AND p.CUV = pcc.CUV
		LEFT JOIN @OfertaProductoTemp op ON op.CampaniaID = P.CampaniaID
			AND op.CUV = P.CUV
		LEFT JOIN MatrizComercial mc WITH (NOLOCK) ON p.CodigoProducto = mc.CodigoSAP
		LEFT JOIN Estrategia EST WITH (NOLOCK) ON
			--EST.CampaniaID = p.AnoCampania
			(
				EST.CampaniaID = p.AnoCampania
				OR p.AnoCampania BETWEEN EST.CampaniaID
					AND EST.CampaniaIDFin
				)
			AND (
				EST.CUV2 = p.CUV
				OR EST.CUV2 = (
					SELECT CUVPadre
					FROM TallaColorCUV TCC
					WHERE TCC.CUV = p.CUV
					)
				)
			AND EST.Activo = 1
		LEFT JOIN dbo.TallaColorCUV tcc WITH (NOLOCK) ON tcc.CUV = p.CUV
			AND tcc.CampaniaID = p.AnoCampania
		LEFT JOIN TipoEstrategia TE WITH (NOLOCK) ON TE.TipoEstrategiaID = EST.TipoEstrategiaID
		LEFT JOIN Marca M WITH (NOLOCK) ON p.MarcaId = M.MarcaId
		LEFT JOIN ods.ProductosLanzamiento pl WITH (NOLOCK) ON p.CodigoProducto = pl.CodigoSAP
			AND p.AnoCampania = pl.Campania
		LEFT JOIN ProductoComercialOfertaRevista pcor WITH (NOLOCK) ON p.AnoCampania = pcor.Campania
			AND p.CUV = pcor.CUV
		WHERE p.AnoCampania = @CampaniaID
			AND p.IndicadorDigitable = 1
			AND CHARINDEX(@CodigoDescripcion, p.CUV) > 0
			AND p.CUV NOT IN (
				SELECT CUV
				FROM @tablaCuvOPT
				)
	END
	ELSE
	BEGIN
		SELECT DISTINCT TOP (@RowCount) p.CUV
			,coalesce(est.descripcioncuv2, op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion) AS Descripcion
			,coalesce(est.precio2, op.PrecioOferta, pd.PrecioProducto * pd.FactorRepeticion, p.PrecioUnitario * p.FactorRepeticion) AS PrecioCatalogo
			,p.MarcaID
			,0 AS EstaEnRevista
			,(
				CASE 
					WHEN ISNULL(pf.CUV, 0) = 0
						THEN 1
					WHEN ISNULL(pf.CUV, 0) > 0
						THEN 0
					END
				) AS TieneStock
			,ISNULL(pcc.EsExpoOferta, 0) AS EsExpoOferta
			,ISNULL(pcc.CUVRevista, '') AS CUVRevista
			,'' AS CUVComplemento
			,p.PaisID
			,p.AnoCampania AS CampaniaID
			,p.CodigoCatalago
			,p.CodigoProducto
			,p.IndicadorMontoMinimo
			,M.Descripcion AS DescripcionMarca
			,'NO DISPONIBLE' AS DescripcionCategoria
			,TE.DescripcionEstrategia AS DescripcionEstrategia
			,ISNULL(op.ConfiguracionOfertaID, 0) ConfiguracionOfertaID
			,CASE 
				WHEN EXISTS (
						SELECT 1
						FROM TallaColorLiquidacion
						WHERE CampaniaID = @CampaniaID
							AND CUV = p.CUV
						)
					THEN 1702
				WHEN EXISTS (
						SELECT 1
						FROM TallaColorCUV
						WHERE CampaniaID = @CampaniaID
							AND CUV = p.CUV
						)
					THEN (
							SELECT E.TipoEstrategiaID
							FROM Estrategia E
							INNER JOIN TALLACOLORCUV TCC ON E.CAMPANIAID = TCC.CAMPANIAID
								AND E.CUV2 = TCC.CUVPADRE
							WHERE TCC.CUV = p.CUV
								AND E.CAMPANIAID = @CampaniaID
							)
				ELSE ISNULL(op.TipoOfertaSisID, 0)
				END TipoOfertaSisID
			,ISNULL(te.flagNueva, 0) FlagNueva
			,ISNULL(te.TipoEstrategiaID, '') TipoEstrategiaID
			,P.IndicadorOferta
			,@TieneSugerido AS TieneSugerido
			,CASE 
				WHEN pcor.SAP IS NULL
					THEN 0
				ELSE 1
				END TieneOfertaRevista
			,p.PrecioValorizado
			,CASE 
				WHEN pl.CodigoSAP IS NULL
					THEN 0
				ELSE 1
				END AS TieneLanzamientoCatalogoPersonalizado
			,ISNULL(pcor.Oferta, '') AS TipoOfertaRevista
			,TE.Codigo AS TipoEstrategiaCodigo
			,CASE 
				WHEN (
						TE.MostrarImgOfertaIndependiente = 1
						AND EST.EsOfertaIndependiente = 1
						)
					THEN 1
				ELSE 0
				END AS EsOfertaIndependiente
		FROM ods.ProductoComercial p WITH (NOLOCK)
		LEFT JOIN dbo.ProductoDescripcion pd WITH (NOLOCK) ON p.AnoCampania = pd.CampaniaID
			AND p.CUV = pd.CUV
		LEFT JOIN @ProductoFaltanteTemp pf ON p.CUV = pf.CUV
		LEFT JOIN ProductoComercialConfiguracion pcc WITH (NOLOCK) ON p.AnoCampania = pcc.CampaniaID
			AND p.CUV = pcc.CUV
		LEFT JOIN @OfertaProductoTemp op ON op.CampaniaID = P.CampaniaID
			AND op.CUV = P.CUV
		LEFT JOIN MatrizComercial mc WITH (NOLOCK) ON p.CodigoProducto = mc.CodigoSAP
		LEFT JOIN Estrategia EST WITH (NOLOCK) ON
			--EST.CampaniaID = p.AnoCampania
			(
				EST.CampaniaID = p.AnoCampania
				OR p.AnoCampania BETWEEN EST.CampaniaID
					AND EST.CampaniaIDFin
				)
			AND (
				EST.CUV2 = p.CUV
				OR EST.CUV2 = (
					SELECT CUVPadre
					FROM TallaColorCUV TCC
					WHERE TCC.CUV = p.CUV
					)
				)
			AND EST.Activo = 1
		LEFT JOIN TipoEstrategia TE WITH (NOLOCK) ON TE.TipoEstrategiaID = EST.TipoEstrategiaID
		LEFT JOIN Marca M ON p.MarcaId = M.MarcaId
		LEFT JOIN ods.ProductosLanzamiento pl WITH (NOLOCK) ON p.CodigoProducto = pl.CodigoSAP
			AND p.AnoCampania = pl.Campania
		LEFT JOIN ProductoComercialOfertaRevista pcor WITH (NOLOCK) ON p.AnoCampania = pcor.Campania
			AND p.CUV = pcor.CUV
		WHERE p.AnoCampania = @CampaniaID
			AND p.IndicadorDigitable = 1
			AND CHARINDEX(@CodigoDescripcion, coalesce(op.Descripcion, pd.Descripcion, p.Descripcion)) > 0
			AND p.CUV NOT IN (
				SELECT CUV
				FROM @tablaCuvOPT
				)
	END
END

GO

USE BelcorpChile
GO

GO

IF (OBJECT_ID('[dbo].[GetProductoComercialByCampaniaBySearchRegionZona_SB2]', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE [dbo].[GetProductoComercialByCampaniaBySearchRegionZona_SB2] AS SET NOCOUNT ON;')
GO

ALTER PROCEDURE [dbo].[GetProductoComercialByCampaniaBySearchRegionZona_SB2] @CampaniaID INT
	,@RowCount INT
	,@Criterio INT
	,@CodigoDescripcion VARCHAR(100)
	,@RegionID INT
	,@ZonaID INT
	,@CodigoRegion VARCHAR(10)
	,@CodigoZona VARCHAR(10)
	,@ValidarOPT BIT = 0
AS
/*
dbo.GetProductoComercialByCampaniaBySearchRegionZona_SB2 201618,1,1,'97010',2701,2161,'50','5052'
dbo.GetProductoComercialByCampaniaBySearchRegionZona_SB2 201618,1,1,'97010',2701,2161,'50','5052',1
*/
BEGIN
	-- Depuramos las tallas y colores
	EXEC DepurarTallaColorCUV @CampaniaID

	EXEC DepurarTallaColorLiquidacion @CampaniaID

	DECLARE @OfertaProductoTemp TABLE (
		CampaniaID INT
		,CUV VARCHAR(6)
		,Descripcion VARCHAR(250)
		,ConfiguracionOfertaID INT
		,TipoOfertaSisID INT
		,PrecioOferta NUMERIC(12, 2)
		)

	INSERT INTO @OfertaProductoTemp
	SELECT op.CampaniaID
		,op.CUV
		,op.Descripcion
		,op.ConfiguracionOfertaID
		,op.TipoOfertaSisID
		,NULL
	FROM OfertaProducto op WITH (NOLOCK)
	INNER JOIN ods.Campania c ON op.CampaniaID = c.CampaniaID
	WHERE c.codigo = @CampaniaID

	INSERT INTO @OfertaProductoTemp
	SELECT c.CampaniaID
		,e.CUV2 AS CUV
		,e.DescripcionCUV2 AS Descripcion
		,ves.ConfiguracionOfertaID
		,ves.TipoOfertaSisID
		,NULL
	FROM dbo.Estrategia e WITH (NOLOCK)
	INNER JOIN ods.Campania c ON e.CampaniaID = c.Codigo
	INNER JOIN vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE c.codigo = @CampaniaID

	DECLARE @ProductoFaltanteTemp TABLE (CUV VARCHAR(6))

	INSERT INTO @ProductoFaltanteTemp
	SELECT DISTINCT ltrim(rtrim(CUV))
	FROM dbo.ProductoFaltante NOLOCK
	WHERE CampaniaID = @CampaniaID
		AND Zonaid = @ZonaID
	
	UNION ALL
	
	SELECT DISTINCT ltrim(rtrim(fa.CodigoVenta)) AS CUV
	FROM ods.FaltanteAnunciado fa(NOLOCK)
	INNER JOIN ods.Campania c(NOLOCK) ON fa.CampaniaID = c.CampaniaID
	WHERE c.Codigo = @CampaniaID
		AND (
			rtrim(fa.CodigoRegion) = @CodigoRegion
			OR fa.CodigoRegion IS NULL
			)
		AND (
			rtrim(fa.CodigoZona) = @CodigoZona
			OR fa.CodigoZona IS NULL
			)

	--Logica para Producto Sugerido
	DECLARE @TieneSugerido INT = 0

	IF EXISTS (
			SELECT 1
			FROM dbo.ProductoSugerido
			WHERE CampaniaID = @CampaniaID
				AND CUV = @CodigoDescripcion
				AND Estado = 1
			)
	BEGIN
		SET @TieneSugerido = 1
	END

	DECLARE @tablaCuvOPT TABLE (CUV VARCHAR(6))

	IF (@Criterio = 1)
	BEGIN
		SELECT DISTINCT TOP (@RowCount) p.CUV
			,coalesce(EST.DescripcionCUV2 + ' ' + tcc.Descripcion, est.descripcioncuv2, op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion) AS Descripcion
			,coalesce(est.precio2, op.PrecioOferta, pd.PrecioProducto * pd.FactorRepeticion, p.PrecioUnitario * p.FactorRepeticion) AS PrecioCatalogo
			,p.MarcaID
			,0 AS EstaEnRevista
			,(
				CASE 
					WHEN ISNULL(pf.CUV, 0) = 0
						THEN 1
					WHEN ISNULL(pf.CUV, 0) > 0
						THEN 0
					END
				) AS TieneStock
			,ISNULL(pcc.EsExpoOferta, 0) AS EsExpoOferta
			,ISNULL(pcc.CUVRevista, '') AS CUVRevista
			,'' AS CUVComplemento
			,p.PaisID
			,p.AnoCampania AS CampaniaID
			,p.CodigoCatalago
			,p.CodigoProducto
			,p.IndicadorMontoMinimo
			,M.Descripcion AS DescripcionMarca
			,'NO DISPONIBLE' AS DescripcionCategoria
			,TE.DescripcionEstrategia AS DescripcionEstrategia
			,ISNULL(op.ConfiguracionOfertaID, 0) ConfiguracionOfertaID
			,CASE 
				WHEN EXISTS (
						SELECT 1
						FROM TallaColorLiquidacion
						WHERE CampaniaID = @CampaniaID
							AND CUV = p.CUV
						)
					THEN 1702
				WHEN EXISTS (
						SELECT 1
						FROM TallaColorCUV
						WHERE CampaniaID = @CampaniaID
							AND CUV = p.CUV
						)
					THEN (
							SELECT E.TipoEstrategiaID
							FROM Estrategia E
							INNER JOIN TALLACOLORCUV TCC ON E.CAMPANIAID = TCC.CAMPANIAID
								AND E.CUV2 = TCC.CUVPADRE
							WHERE TCC.CUV = p.CUV
								AND E.CAMPANIAID = @CampaniaID
							)
				ELSE ISNULL(op.TipoOfertaSisID, 0)
				END TipoOfertaSisID
			,ISNULL(te.flagNueva, 0) FlagNueva
			,ISNULL(te.TipoEstrategiaID, '') TipoEstrategiaID
			,P.IndicadorOferta
			,@TieneSugerido AS TieneSugerido
			,CASE 
				WHEN pcor.SAP IS NULL
					THEN 0
				ELSE 1
				END TieneOfertaRevista
			,p.PrecioValorizado
			,CASE 
				WHEN pl.CodigoSAP IS NULL
					THEN 0
				ELSE 1
				END AS TieneLanzamientoCatalogoPersonalizado
			,ISNULL(pcor.Oferta, '') AS TipoOfertaRevista
			,TE.Codigo AS TipoEstrategiaCodigo
			,CASE 
				WHEN (
						TE.MostrarImgOfertaIndependiente = 1
						AND EST.EsOfertaIndependiente = 1
						)
					THEN 1
				ELSE 0
				END AS EsOfertaIndependiente
		FROM ods.ProductoComercial p WITH (NOLOCK)
		LEFT JOIN dbo.ProductoDescripcion pd WITH (NOLOCK) ON p.AnoCampania = pd.CampaniaID
			AND p.CUV = pd.CUV
		LEFT JOIN @ProductoFaltanteTemp pf ON p.CUV = pf.CUV
		LEFT JOIN ProductoComercialConfiguracion pcc ON p.AnoCampania = pcc.CampaniaID
			AND p.CUV = pcc.CUV
		LEFT JOIN @OfertaProductoTemp op ON op.CampaniaID = P.CampaniaID
			AND op.CUV = P.CUV
		LEFT JOIN MatrizComercial mc WITH (NOLOCK) ON p.CodigoProducto = mc.CodigoSAP
		LEFT JOIN Estrategia EST WITH (NOLOCK) ON
			--EST.CampaniaID = p.AnoCampania
			(
				EST.CampaniaID = p.AnoCampania
				OR p.AnoCampania BETWEEN EST.CampaniaID
					AND EST.CampaniaIDFin
				)
			AND (
				EST.CUV2 = p.CUV
				OR EST.CUV2 = (
					SELECT CUVPadre
					FROM TallaColorCUV TCC
					WHERE TCC.CUV = p.CUV
					)
				)
			AND EST.Activo = 1
		LEFT JOIN dbo.TallaColorCUV tcc WITH (NOLOCK) ON tcc.CUV = p.CUV
			AND tcc.CampaniaID = p.AnoCampania
		LEFT JOIN TipoEstrategia TE WITH (NOLOCK) ON TE.TipoEstrategiaID = EST.TipoEstrategiaID
		LEFT JOIN Marca M WITH (NOLOCK) ON p.MarcaId = M.MarcaId
		LEFT JOIN ods.ProductosLanzamiento pl WITH (NOLOCK) ON p.CodigoProducto = pl.CodigoSAP
			AND p.AnoCampania = pl.Campania
		LEFT JOIN ProductoComercialOfertaRevista pcor WITH (NOLOCK) ON p.AnoCampania = pcor.Campania
			AND p.CUV = pcor.CUV
		WHERE p.AnoCampania = @CampaniaID
			AND p.IndicadorDigitable = 1
			AND CHARINDEX(@CodigoDescripcion, p.CUV) > 0
			AND p.CUV NOT IN (
				SELECT CUV
				FROM @tablaCuvOPT
				)
	END
	ELSE
	BEGIN
		SELECT DISTINCT TOP (@RowCount) p.CUV
			,coalesce(est.descripcioncuv2, op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion) AS Descripcion
			,coalesce(est.precio2, op.PrecioOferta, pd.PrecioProducto * pd.FactorRepeticion, p.PrecioUnitario * p.FactorRepeticion) AS PrecioCatalogo
			,p.MarcaID
			,0 AS EstaEnRevista
			,(
				CASE 
					WHEN ISNULL(pf.CUV, 0) = 0
						THEN 1
					WHEN ISNULL(pf.CUV, 0) > 0
						THEN 0
					END
				) AS TieneStock
			,ISNULL(pcc.EsExpoOferta, 0) AS EsExpoOferta
			,ISNULL(pcc.CUVRevista, '') AS CUVRevista
			,'' AS CUVComplemento
			,p.PaisID
			,p.AnoCampania AS CampaniaID
			,p.CodigoCatalago
			,p.CodigoProducto
			,p.IndicadorMontoMinimo
			,M.Descripcion AS DescripcionMarca
			,'NO DISPONIBLE' AS DescripcionCategoria
			,TE.DescripcionEstrategia AS DescripcionEstrategia
			,ISNULL(op.ConfiguracionOfertaID, 0) ConfiguracionOfertaID
			,CASE 
				WHEN EXISTS (
						SELECT 1
						FROM TallaColorLiquidacion
						WHERE CampaniaID = @CampaniaID
							AND CUV = p.CUV
						)
					THEN 1702
				WHEN EXISTS (
						SELECT 1
						FROM TallaColorCUV
						WHERE CampaniaID = @CampaniaID
							AND CUV = p.CUV
						)
					THEN (
							SELECT E.TipoEstrategiaID
							FROM Estrategia E
							INNER JOIN TALLACOLORCUV TCC ON E.CAMPANIAID = TCC.CAMPANIAID
								AND E.CUV2 = TCC.CUVPADRE
							WHERE TCC.CUV = p.CUV
								AND E.CAMPANIAID = @CampaniaID
							)
				ELSE ISNULL(op.TipoOfertaSisID, 0)
				END TipoOfertaSisID
			,ISNULL(te.flagNueva, 0) FlagNueva
			,ISNULL(te.TipoEstrategiaID, '') TipoEstrategiaID
			,P.IndicadorOferta
			,@TieneSugerido AS TieneSugerido
			,CASE 
				WHEN pcor.SAP IS NULL
					THEN 0
				ELSE 1
				END TieneOfertaRevista
			,p.PrecioValorizado
			,CASE 
				WHEN pl.CodigoSAP IS NULL
					THEN 0
				ELSE 1
				END AS TieneLanzamientoCatalogoPersonalizado
			,ISNULL(pcor.Oferta, '') AS TipoOfertaRevista
			,TE.Codigo AS TipoEstrategiaCodigo
			,CASE 
				WHEN (
						TE.MostrarImgOfertaIndependiente = 1
						AND EST.EsOfertaIndependiente = 1
						)
					THEN 1
				ELSE 0
				END AS EsOfertaIndependiente
		FROM ods.ProductoComercial p WITH (NOLOCK)
		LEFT JOIN dbo.ProductoDescripcion pd WITH (NOLOCK) ON p.AnoCampania = pd.CampaniaID
			AND p.CUV = pd.CUV
		LEFT JOIN @ProductoFaltanteTemp pf ON p.CUV = pf.CUV
		LEFT JOIN ProductoComercialConfiguracion pcc WITH (NOLOCK) ON p.AnoCampania = pcc.CampaniaID
			AND p.CUV = pcc.CUV
		LEFT JOIN @OfertaProductoTemp op ON op.CampaniaID = P.CampaniaID
			AND op.CUV = P.CUV
		LEFT JOIN MatrizComercial mc WITH (NOLOCK) ON p.CodigoProducto = mc.CodigoSAP
		LEFT JOIN Estrategia EST WITH (NOLOCK) ON
			--EST.CampaniaID = p.AnoCampania
			(
				EST.CampaniaID = p.AnoCampania
				OR p.AnoCampania BETWEEN EST.CampaniaID
					AND EST.CampaniaIDFin
				)
			AND (
				EST.CUV2 = p.CUV
				OR EST.CUV2 = (
					SELECT CUVPadre
					FROM TallaColorCUV TCC
					WHERE TCC.CUV = p.CUV
					)
				)
			AND EST.Activo = 1
		LEFT JOIN TipoEstrategia TE WITH (NOLOCK) ON TE.TipoEstrategiaID = EST.TipoEstrategiaID
		LEFT JOIN Marca M ON p.MarcaId = M.MarcaId
		LEFT JOIN ods.ProductosLanzamiento pl WITH (NOLOCK) ON p.CodigoProducto = pl.CodigoSAP
			AND p.AnoCampania = pl.Campania
		LEFT JOIN ProductoComercialOfertaRevista pcor WITH (NOLOCK) ON p.AnoCampania = pcor.Campania
			AND p.CUV = pcor.CUV
		WHERE p.AnoCampania = @CampaniaID
			AND p.IndicadorDigitable = 1
			AND CHARINDEX(@CodigoDescripcion, coalesce(op.Descripcion, pd.Descripcion, p.Descripcion)) > 0
			AND p.CUV NOT IN (
				SELECT CUV
				FROM @tablaCuvOPT
				)
	END
END

GO

USE BelcorpBolivia
GO

GO

IF (OBJECT_ID('[dbo].[GetProductoComercialByCampaniaBySearchRegionZona_SB2]', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE [dbo].[GetProductoComercialByCampaniaBySearchRegionZona_SB2] AS SET NOCOUNT ON;')
GO

ALTER PROCEDURE [dbo].[GetProductoComercialByCampaniaBySearchRegionZona_SB2] @CampaniaID INT
	,@RowCount INT
	,@Criterio INT
	,@CodigoDescripcion VARCHAR(100)
	,@RegionID INT
	,@ZonaID INT
	,@CodigoRegion VARCHAR(10)
	,@CodigoZona VARCHAR(10)
	,@ValidarOPT BIT = 0
AS
/*
dbo.GetProductoComercialByCampaniaBySearchRegionZona_SB2 201618,1,1,'97010',2701,2161,'50','5052'
dbo.GetProductoComercialByCampaniaBySearchRegionZona_SB2 201618,1,1,'97010',2701,2161,'50','5052',1
*/
BEGIN
	-- Depuramos las tallas y colores
	EXEC DepurarTallaColorCUV @CampaniaID

	EXEC DepurarTallaColorLiquidacion @CampaniaID

	DECLARE @OfertaProductoTemp TABLE (
		CampaniaID INT
		,CUV VARCHAR(6)
		,Descripcion VARCHAR(250)
		,ConfiguracionOfertaID INT
		,TipoOfertaSisID INT
		,PrecioOferta NUMERIC(12, 2)
		)

	INSERT INTO @OfertaProductoTemp
	SELECT op.CampaniaID
		,op.CUV
		,op.Descripcion
		,op.ConfiguracionOfertaID
		,op.TipoOfertaSisID
		,NULL
	FROM OfertaProducto op WITH (NOLOCK)
	INNER JOIN ods.Campania c ON op.CampaniaID = c.CampaniaID
	WHERE c.codigo = @CampaniaID

	INSERT INTO @OfertaProductoTemp
	SELECT c.CampaniaID
		,e.CUV2 AS CUV
		,e.DescripcionCUV2 AS Descripcion
		,ves.ConfiguracionOfertaID
		,ves.TipoOfertaSisID
		,NULL
	FROM dbo.Estrategia e WITH (NOLOCK)
	INNER JOIN ods.Campania c ON e.CampaniaID = c.Codigo
	INNER JOIN vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE c.codigo = @CampaniaID

	DECLARE @ProductoFaltanteTemp TABLE (CUV VARCHAR(6))

	INSERT INTO @ProductoFaltanteTemp
	SELECT DISTINCT ltrim(rtrim(CUV))
	FROM dbo.ProductoFaltante NOLOCK
	WHERE CampaniaID = @CampaniaID
		AND Zonaid = @ZonaID
	
	UNION ALL
	
	SELECT DISTINCT ltrim(rtrim(fa.CodigoVenta)) AS CUV
	FROM ods.FaltanteAnunciado fa(NOLOCK)
	INNER JOIN ods.Campania c(NOLOCK) ON fa.CampaniaID = c.CampaniaID
	WHERE c.Codigo = @CampaniaID
		AND (
			rtrim(fa.CodigoRegion) = @CodigoRegion
			OR fa.CodigoRegion IS NULL
			)
		AND (
			rtrim(fa.CodigoZona) = @CodigoZona
			OR fa.CodigoZona IS NULL
			)

	--Logica para Producto Sugerido
	DECLARE @TieneSugerido INT = 0

	IF EXISTS (
			SELECT 1
			FROM dbo.ProductoSugerido
			WHERE CampaniaID = @CampaniaID
				AND CUV = @CodigoDescripcion
				AND Estado = 1
			)
	BEGIN
		SET @TieneSugerido = 1
	END

	DECLARE @tablaCuvOPT TABLE (CUV VARCHAR(6))

	IF (@Criterio = 1)
	BEGIN
		SELECT DISTINCT TOP (@RowCount) p.CUV
			,coalesce(EST.DescripcionCUV2 + ' ' + tcc.Descripcion, est.descripcioncuv2, op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion) AS Descripcion
			,coalesce(est.precio2, op.PrecioOferta, pd.PrecioProducto * pd.FactorRepeticion, p.PrecioUnitario * p.FactorRepeticion) AS PrecioCatalogo
			,p.MarcaID
			,0 AS EstaEnRevista
			,(
				CASE 
					WHEN ISNULL(pf.CUV, 0) = 0
						THEN 1
					WHEN ISNULL(pf.CUV, 0) > 0
						THEN 0
					END
				) AS TieneStock
			,ISNULL(pcc.EsExpoOferta, 0) AS EsExpoOferta
			,ISNULL(pcc.CUVRevista, '') AS CUVRevista
			,'' AS CUVComplemento
			,p.PaisID
			,p.AnoCampania AS CampaniaID
			,p.CodigoCatalago
			,p.CodigoProducto
			,p.IndicadorMontoMinimo
			,M.Descripcion AS DescripcionMarca
			,'NO DISPONIBLE' AS DescripcionCategoria
			,TE.DescripcionEstrategia AS DescripcionEstrategia
			,ISNULL(op.ConfiguracionOfertaID, 0) ConfiguracionOfertaID
			,CASE 
				WHEN EXISTS (
						SELECT 1
						FROM TallaColorLiquidacion
						WHERE CampaniaID = @CampaniaID
							AND CUV = p.CUV
						)
					THEN 1702
				WHEN EXISTS (
						SELECT 1
						FROM TallaColorCUV
						WHERE CampaniaID = @CampaniaID
							AND CUV = p.CUV
						)
					THEN (
							SELECT E.TipoEstrategiaID
							FROM Estrategia E
							INNER JOIN TALLACOLORCUV TCC ON E.CAMPANIAID = TCC.CAMPANIAID
								AND E.CUV2 = TCC.CUVPADRE
							WHERE TCC.CUV = p.CUV
								AND E.CAMPANIAID = @CampaniaID
							)
				ELSE ISNULL(op.TipoOfertaSisID, 0)
				END TipoOfertaSisID
			,ISNULL(te.flagNueva, 0) FlagNueva
			,ISNULL(te.TipoEstrategiaID, '') TipoEstrategiaID
			,P.IndicadorOferta
			,@TieneSugerido AS TieneSugerido
			,CASE 
				WHEN pcor.SAP IS NULL
					THEN 0
				ELSE 1
				END TieneOfertaRevista
			,p.PrecioValorizado
			,CASE 
				WHEN pl.CodigoSAP IS NULL
					THEN 0
				ELSE 1
				END AS TieneLanzamientoCatalogoPersonalizado
			,ISNULL(pcor.Oferta, '') AS TipoOfertaRevista
			,TE.Codigo AS TipoEstrategiaCodigo
			,CASE 
				WHEN (
						TE.MostrarImgOfertaIndependiente = 1
						AND EST.EsOfertaIndependiente = 1
						)
					THEN 1
				ELSE 0
				END AS EsOfertaIndependiente
		FROM ods.ProductoComercial p WITH (NOLOCK)
		LEFT JOIN dbo.ProductoDescripcion pd WITH (NOLOCK) ON p.AnoCampania = pd.CampaniaID
			AND p.CUV = pd.CUV
		LEFT JOIN @ProductoFaltanteTemp pf ON p.CUV = pf.CUV
		LEFT JOIN ProductoComercialConfiguracion pcc ON p.AnoCampania = pcc.CampaniaID
			AND p.CUV = pcc.CUV
		LEFT JOIN @OfertaProductoTemp op ON op.CampaniaID = P.CampaniaID
			AND op.CUV = P.CUV
		LEFT JOIN MatrizComercial mc WITH (NOLOCK) ON p.CodigoProducto = mc.CodigoSAP
		LEFT JOIN Estrategia EST WITH (NOLOCK) ON
			--EST.CampaniaID = p.AnoCampania
			(
				EST.CampaniaID = p.AnoCampania
				OR p.AnoCampania BETWEEN EST.CampaniaID
					AND EST.CampaniaIDFin
				)
			AND (
				EST.CUV2 = p.CUV
				OR EST.CUV2 = (
					SELECT CUVPadre
					FROM TallaColorCUV TCC
					WHERE TCC.CUV = p.CUV
					)
				)
			AND EST.Activo = 1
		LEFT JOIN dbo.TallaColorCUV tcc WITH (NOLOCK) ON tcc.CUV = p.CUV
			AND tcc.CampaniaID = p.AnoCampania
		LEFT JOIN TipoEstrategia TE WITH (NOLOCK) ON TE.TipoEstrategiaID = EST.TipoEstrategiaID
		LEFT JOIN Marca M WITH (NOLOCK) ON p.MarcaId = M.MarcaId
		LEFT JOIN ods.ProductosLanzamiento pl WITH (NOLOCK) ON p.CodigoProducto = pl.CodigoSAP
			AND p.AnoCampania = pl.Campania
		LEFT JOIN ProductoComercialOfertaRevista pcor WITH (NOLOCK) ON p.AnoCampania = pcor.Campania
			AND p.CUV = pcor.CUV
		WHERE p.AnoCampania = @CampaniaID
			AND p.IndicadorDigitable = 1
			AND CHARINDEX(@CodigoDescripcion, p.CUV) > 0
			AND p.CUV NOT IN (
				SELECT CUV
				FROM @tablaCuvOPT
				)
	END
	ELSE
	BEGIN
		SELECT DISTINCT TOP (@RowCount) p.CUV
			,coalesce(est.descripcioncuv2, op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion) AS Descripcion
			,coalesce(est.precio2, op.PrecioOferta, pd.PrecioProducto * pd.FactorRepeticion, p.PrecioUnitario * p.FactorRepeticion) AS PrecioCatalogo
			,p.MarcaID
			,0 AS EstaEnRevista
			,(
				CASE 
					WHEN ISNULL(pf.CUV, 0) = 0
						THEN 1
					WHEN ISNULL(pf.CUV, 0) > 0
						THEN 0
					END
				) AS TieneStock
			,ISNULL(pcc.EsExpoOferta, 0) AS EsExpoOferta
			,ISNULL(pcc.CUVRevista, '') AS CUVRevista
			,'' AS CUVComplemento
			,p.PaisID
			,p.AnoCampania AS CampaniaID
			,p.CodigoCatalago
			,p.CodigoProducto
			,p.IndicadorMontoMinimo
			,M.Descripcion AS DescripcionMarca
			,'NO DISPONIBLE' AS DescripcionCategoria
			,TE.DescripcionEstrategia AS DescripcionEstrategia
			,ISNULL(op.ConfiguracionOfertaID, 0) ConfiguracionOfertaID
			,CASE 
				WHEN EXISTS (
						SELECT 1
						FROM TallaColorLiquidacion
						WHERE CampaniaID = @CampaniaID
							AND CUV = p.CUV
						)
					THEN 1702
				WHEN EXISTS (
						SELECT 1
						FROM TallaColorCUV
						WHERE CampaniaID = @CampaniaID
							AND CUV = p.CUV
						)
					THEN (
							SELECT E.TipoEstrategiaID
							FROM Estrategia E
							INNER JOIN TALLACOLORCUV TCC ON E.CAMPANIAID = TCC.CAMPANIAID
								AND E.CUV2 = TCC.CUVPADRE
							WHERE TCC.CUV = p.CUV
								AND E.CAMPANIAID = @CampaniaID
							)
				ELSE ISNULL(op.TipoOfertaSisID, 0)
				END TipoOfertaSisID
			,ISNULL(te.flagNueva, 0) FlagNueva
			,ISNULL(te.TipoEstrategiaID, '') TipoEstrategiaID
			,P.IndicadorOferta
			,@TieneSugerido AS TieneSugerido
			,CASE 
				WHEN pcor.SAP IS NULL
					THEN 0
				ELSE 1
				END TieneOfertaRevista
			,p.PrecioValorizado
			,CASE 
				WHEN pl.CodigoSAP IS NULL
					THEN 0
				ELSE 1
				END AS TieneLanzamientoCatalogoPersonalizado
			,ISNULL(pcor.Oferta, '') AS TipoOfertaRevista
			,TE.Codigo AS TipoEstrategiaCodigo
			,CASE 
				WHEN (
						TE.MostrarImgOfertaIndependiente = 1
						AND EST.EsOfertaIndependiente = 1
						)
					THEN 1
				ELSE 0
				END AS EsOfertaIndependiente
		FROM ods.ProductoComercial p WITH (NOLOCK)
		LEFT JOIN dbo.ProductoDescripcion pd WITH (NOLOCK) ON p.AnoCampania = pd.CampaniaID
			AND p.CUV = pd.CUV
		LEFT JOIN @ProductoFaltanteTemp pf ON p.CUV = pf.CUV
		LEFT JOIN ProductoComercialConfiguracion pcc WITH (NOLOCK) ON p.AnoCampania = pcc.CampaniaID
			AND p.CUV = pcc.CUV
		LEFT JOIN @OfertaProductoTemp op ON op.CampaniaID = P.CampaniaID
			AND op.CUV = P.CUV
		LEFT JOIN MatrizComercial mc WITH (NOLOCK) ON p.CodigoProducto = mc.CodigoSAP
		LEFT JOIN Estrategia EST WITH (NOLOCK) ON
			--EST.CampaniaID = p.AnoCampania
			(
				EST.CampaniaID = p.AnoCampania
				OR p.AnoCampania BETWEEN EST.CampaniaID
					AND EST.CampaniaIDFin
				)
			AND (
				EST.CUV2 = p.CUV
				OR EST.CUV2 = (
					SELECT CUVPadre
					FROM TallaColorCUV TCC
					WHERE TCC.CUV = p.CUV
					)
				)
			AND EST.Activo = 1
		LEFT JOIN TipoEstrategia TE WITH (NOLOCK) ON TE.TipoEstrategiaID = EST.TipoEstrategiaID
		LEFT JOIN Marca M ON p.MarcaId = M.MarcaId
		LEFT JOIN ods.ProductosLanzamiento pl WITH (NOLOCK) ON p.CodigoProducto = pl.CodigoSAP
			AND p.AnoCampania = pl.Campania
		LEFT JOIN ProductoComercialOfertaRevista pcor WITH (NOLOCK) ON p.AnoCampania = pcor.Campania
			AND p.CUV = pcor.CUV
		WHERE p.AnoCampania = @CampaniaID
			AND p.IndicadorDigitable = 1
			AND CHARINDEX(@CodigoDescripcion, coalesce(op.Descripcion, pd.Descripcion, p.Descripcion)) > 0
			AND p.CUV NOT IN (
				SELECT CUV
				FROM @tablaCuvOPT
				)
	END
END

