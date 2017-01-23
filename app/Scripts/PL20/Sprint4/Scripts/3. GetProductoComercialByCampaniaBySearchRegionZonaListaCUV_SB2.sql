

USE BelcorpBolivia
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetProductoComercialByCampaniaBySearchRegionZonaListaCUV_SB2'))
BEGIN
    DROP PROCEDURE dbo.GetProductoComercialByCampaniaBySearchRegionZonaListaCUV_SB2
END

GO

CREATE PROCEDURE [dbo].[GetProductoComercialByCampaniaBySearchRegionZonaListaCUV_SB2]
	@CampaniaID INT,
	--@RowCount INT,
	--@Criterio INT,
	--@CodigoDescripcion VARCHAR(100),
	@ListaCUV VARCHAR(MAX),
	@RegionID INT,
	@ZonaID INT,
	@CodigoRegion VARCHAR(10),
	@CodigoZona VARCHAR(10),
	@ValidarOPT BIT = 0
AS
/*
dbo.GetProductoComercialByCampaniaBySearchRegionZona_SB2 201618,1,1,'97010',2701,2161,'50','5052'
dbo.GetProductoComercialByCampaniaBySearchRegionZona_SB2 201618,1,1,'97010',2701,2161,'50','5052',1
*/
BEGIN

-- Depuramos las tallas y colores
EXEC DepurarTallaColorCUV @CampaniaID
EXEC DepurarTallaColorLiquidacion @CampaniaID

DECLARE @OfertaProductoTemp TABLE
(
	CampaniaID INT,
	CUV VARCHAR(6),
	Descripcion VARCHAR(250),
	ConfiguracionOfertaID INT,
	TipoOfertaSisID INT,
	PrecioOferta NUMERIC(12,2)
)

INSERT INTO @OfertaProductoTemp
SELECT 
	op.CampaniaID, op.CUV, op.Descripcion, 
	op.ConfiguracionOfertaID, op.TipoOfertaSisID, NULL
FROM OfertaProducto op
INNER JOIN ods.Campania c ON
	op.CampaniaID = c.CampaniaID
WHERE c.codigo = @CampaniaID

INSERT INTO @OfertaProductoTemp    
SELECT 
	op.CampaniaID, op.CUV, op.Descripcion, 
	op.ConfiguracionOfertaID, op.TipoOfertaSisID, NULL    
FROM ShowRoom.OfertaShowRoom op    
INNER JOIN ods.Campania c ON     
	op.CampaniaID = c.CampaniaID    
WHERE --op.flaghabilitarproducto = 1 and     
 c.codigo = @CampaniaID

DECLARE @ProductoFaltanteTemp TABLE (CUV VARCHAR(6))

INSERT INTO @ProductoFaltanteTemp
SELECT 
	DISTINCT LTRIM(RTRIM(CUV))
	FROM ProductoFaltante NOLOCK
WHERE 
	CampaniaID = @CampaniaID and Zonaid = @ZonaID
UNION ALL
SELECT 
	DISTINCT LTRIM(RTRIM(fa.CodigoVenta)) AS CUV
FROM ods.FaltanteAnunciado fa (NOLOCK)
INNER JOIN ods.Campania c (NOLOCK) ON 
	fa.CampaniaID = c.CampaniaID
WHERE 
	c.Codigo = @CampaniaID 
	AND (RTRIM(fa.CodigoRegion) = @CodigoRegion OR fa.CodigoRegion IS NULL) 
	AND (RTRIM(fa.CodigoZona) = @CodigoZona OR fa.CodigoZona IS NULL)

--Logica para Producto Sugerido
--declare @TieneSugerido int = 0
--if exists (	select 1 from dbo.ProductoSugerido 
--			where CampaniaID = @CampaniaID and CUV = @CodigoDescripcion and Estado = 1)
--BEGIN
--	set @TieneSugerido = 1
--END

DECLARE @tblSugerido TABLE (
	CUV VARCHAR(6),
	TieneSugerido INT DEFAULT 0
)

INSERT INTO @tblSugerido
SELECT CUV, 1 
FROM dbo.ProductoSugerido 
WHERE CampaniaID = @CampaniaID 
	AND CUV IN (SELECT splitdata FROM dbo.fnSplitString(@listaCuv,',')) 
	AND Estado = 1 

DECLARE @tablaCuvOPT TABLE (CUV VARCHAR(6))

IF (@ValidarOPT = 1)
BEGIN
	INSERT INTO @tablaCuvOPT
	SELECT DISTINCT CUV 
	FROM ods.OfertasPersonalizadas 
	WHERE AnioCampanaVenta = @CampaniaID 
	AND TipoPersonalizacion='OPT'
END
	
--IF(@Criterio = 1)
--BEGIN
	SELECT 
		DISTINCT 
		--TOP (@RowCount) 
		p.CUV,
		COALESCE(EST.DescripcionCUV2 + ' '+ tcc.Descripcion, 
		est.descripcioncuv2, 
		op.Descripcion, 
		mc.Descripcion, 
		pd.Descripcion, 
		p.Descripcion) AS Descripcion,
		COALESCE(est.precio2, op.PrecioOferta, pd.PrecioProducto*pd.FactorRepeticion ,p.PrecioUnitario*p.FactorRepeticion) AS PrecioCatalogo,
		p.MarcaID,
		0 AS EstaEnRevista,
		(CASE WHEN ISNULL(pf.CUV,0) = 0 THEN 1 WHEN ISNULL(pf.CUV,0) > 0 THEN 0 END) AS TieneStock,
		ISNULL(pcc.EsExpoOferta,0) AS EsExpoOferta,
		ISNULL(pcc.CUVRevista,'') AS CUVRevista,
		'' AS CUVComplemento,
		p.PaisID,
		p.AnoCampania AS CampaniaID,
		p.CodigoCatalago,
		p.CodigoProducto,
		p.IndicadorMontoMinimo,
		M.Descripcion AS DescripcionMarca,
		'NO DISPONIBLE' AS DescripcionCategoria,
		TE.DescripcionEstrategia AS DescripcionEstrategia,
		ISNULL(op.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		CASE
			WHEN EXISTS(SELECT 1 FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = p.CUV) THEN 1702
			WHEN EXISTS(SELECT 1 FROM TallaColorCUV WHERE CampaniaID = @CampaniaID AND CUV = p.CUV) THEN
				(
					SELECT E.TipoEstrategiaID FROM Estrategia E
					INNER JOIN TALLACOLORCUV TCC ON E.CAMPANIAID = TCC.CAMPANIAID AND E.CUV2 = TCC.CUVPADRE
					WHERE TCC.CUV = p.CUV AND E.CAMPANIAID=@CampaniaID
				)
			ELSE ISNULL(op.TipoOfertaSisID,0) END TipoOfertaSisID,
		ISNULL(te.flagNueva, 0) FlagNueva,
		ISNULL(te.TipoEstrategiaID, '') TipoEstrategiaID,
		P.IndicadorOferta,
		--@TieneSugerido AS TieneSugerido,
		ISNULL(ts.TieneSugerido,0) AS TieneSugerido,
		CASE
			WHEN pcor.SAP IS NULL THEN 0
			ELSE 1 
		END AS TieneOfertaRevista,		
		p.PrecioValorizado,
		CASE 
			WHEN pl.CodigoSAP IS NULL THEN 0
			ELSE 1 
		END AS TieneLanzamientoCatalogoPersonalizado,		
		ISNULL(pcor.Oferta,'') AS TipoOfertaRevista
	FROM ods.ProductoComercial p
	LEFT JOIN dbo.ProductoDescripcion pd ON 
		p.AnoCampania = pd.CampaniaID 
		AND p.CUV = pd.CUV
	LEFT JOIN @ProductoFaltanteTemp pf ON 
		p.CUV = pf.CUV
	LEFT JOIN ProductoComercialConfiguracion pcc ON 
		p.AnoCampania = pcc.CampaniaID 
		AND p.CUV = pcc.CUV
	LEFT JOIN @OfertaProductoTemp op ON 
		op.CampaniaID = P.CampaniaID 
		AND op.CUV = P.CUV
	LEFT JOIN MatrizComercial mc ON 
		p.CodigoProducto = mc.CodigoSAP
	LEFT JOIN Estrategia EST ON 
		--EST.CampaniaID = p.AnoCampania
		(EST.CampaniaID = p.AnoCampania OR p.AnoCampania BETWEEN EST.CampaniaID AND EST.CampaniaIDFin)
		AND (EST.CUV2 = p.CUV OR EST.CUV2 = (SELECT CUVPadre FROM TallaColorCUV TCC WHERE TCC.CUV = p.CUV)) 
		AND EST.Activo = 1 
	LEFT JOIN dbo.TallaColorCUV tcc 
		ON tcc.CUV = p.CUV 
		AND tcc.CampaniaID = p.AnoCampania
	LEFT JOIN TipoEstrategia TE ON 
		TE.TipoEstrategiaID = EST.TipoEstrategiaID
	LEFT JOIN Marca M ON 
		p.MarcaId = M.MarcaId
	LEFT JOIN ods.ProductosLanzamiento pl ON
		p.CodigoProducto = pl.CodigoSAP
		AND p.AnoCampania = pl.Campania
	LEFT JOIN ProductoComercialOfertaRevista pcor ON 
		p.AnoCampania = pcor.Campania 
		AND p.CUV = pcor.CUV
	LEFT JOIN @tblSugerido ts ON p.CUV = ts.CUV
	WHERE 
		p.AnoCampania = @CampaniaID 
		AND p.IndicadorDigitable = 1
		--AND CHARINDEX(@CodigoDescripcion,p.CUV)>0
		AND p.CUV IN (SELECT splitdata FROM dbo.fnSplitString(@listaCuv,','))
		AND p.CUV NOT IN (SELECT CUV FROM @tablaCuvOPT)
--END

END

GO
/*end*/

USE BelcorpChile
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetProductoComercialByCampaniaBySearchRegionZonaListaCUV_SB2'))
BEGIN
    DROP PROCEDURE dbo.GetProductoComercialByCampaniaBySearchRegionZonaListaCUV_SB2
END

GO

CREATE PROCEDURE [dbo].[GetProductoComercialByCampaniaBySearchRegionZonaListaCUV_SB2]
	@CampaniaID INT,
	--@RowCount INT,
	--@Criterio INT,
	--@CodigoDescripcion VARCHAR(100),
	@ListaCUV VARCHAR(MAX),
	@RegionID INT,
	@ZonaID INT,
	@CodigoRegion VARCHAR(10),
	@CodigoZona VARCHAR(10),
	@ValidarOPT BIT = 0
AS
/*
dbo.GetProductoComercialByCampaniaBySearchRegionZona_SB2 201618,1,1,'97010',2701,2161,'50','5052'
dbo.GetProductoComercialByCampaniaBySearchRegionZona_SB2 201618,1,1,'97010',2701,2161,'50','5052',1
*/
BEGIN

-- Depuramos las tallas y colores
EXEC DepurarTallaColorCUV @CampaniaID
EXEC DepurarTallaColorLiquidacion @CampaniaID

DECLARE @OfertaProductoTemp TABLE
(
	CampaniaID INT,
	CUV VARCHAR(6),
	Descripcion VARCHAR(250),
	ConfiguracionOfertaID INT,
	TipoOfertaSisID INT,
	PrecioOferta NUMERIC(12,2)
)

INSERT INTO @OfertaProductoTemp
SELECT 
	op.CampaniaID, op.CUV, op.Descripcion, 
	op.ConfiguracionOfertaID, op.TipoOfertaSisID, NULL
FROM OfertaProducto op
INNER JOIN ods.Campania c ON
	op.CampaniaID = c.CampaniaID
WHERE c.codigo = @CampaniaID

INSERT INTO @OfertaProductoTemp    
SELECT 
	op.CampaniaID, op.CUV, op.Descripcion, 
	op.ConfiguracionOfertaID, op.TipoOfertaSisID, NULL    
FROM ShowRoom.OfertaShowRoom op    
INNER JOIN ods.Campania c ON     
	op.CampaniaID = c.CampaniaID    
WHERE --op.flaghabilitarproducto = 1 and     
 c.codigo = @CampaniaID

DECLARE @ProductoFaltanteTemp TABLE (CUV VARCHAR(6))

INSERT INTO @ProductoFaltanteTemp
SELECT 
	DISTINCT LTRIM(RTRIM(CUV))
	FROM ProductoFaltante NOLOCK
WHERE 
	CampaniaID = @CampaniaID and Zonaid = @ZonaID
UNION ALL
SELECT 
	DISTINCT LTRIM(RTRIM(fa.CodigoVenta)) AS CUV
FROM ods.FaltanteAnunciado fa (NOLOCK)
INNER JOIN ods.Campania c (NOLOCK) ON 
	fa.CampaniaID = c.CampaniaID
WHERE 
	c.Codigo = @CampaniaID 
	AND (RTRIM(fa.CodigoRegion) = @CodigoRegion OR fa.CodigoRegion IS NULL) 
	AND (RTRIM(fa.CodigoZona) = @CodigoZona OR fa.CodigoZona IS NULL)

--Logica para Producto Sugerido
--declare @TieneSugerido int = 0
--if exists (	select 1 from dbo.ProductoSugerido 
--			where CampaniaID = @CampaniaID and CUV = @CodigoDescripcion and Estado = 1)
--BEGIN
--	set @TieneSugerido = 1
--END

DECLARE @tblSugerido TABLE (
	CUV VARCHAR(6),
	TieneSugerido INT DEFAULT 0
)

INSERT INTO @tblSugerido
SELECT CUV, 1 
FROM dbo.ProductoSugerido 
WHERE CampaniaID = @CampaniaID 
	AND CUV IN (SELECT splitdata FROM dbo.fnSplitString(@listaCuv,',')) 
	AND Estado = 1 

DECLARE @tablaCuvOPT TABLE (CUV VARCHAR(6))

IF (@ValidarOPT = 1)
BEGIN
	INSERT INTO @tablaCuvOPT
	SELECT DISTINCT CUV 
	FROM ods.OfertasPersonalizadas 
	WHERE AnioCampanaVenta = @CampaniaID 
	AND TipoPersonalizacion='OPT'
END
	
--IF(@Criterio = 1)
--BEGIN
	SELECT 
		DISTINCT 
		--TOP (@RowCount) 
		p.CUV,
		COALESCE(EST.DescripcionCUV2 + ' '+ tcc.Descripcion, 
		est.descripcioncuv2, 
		op.Descripcion, 
		mc.Descripcion, 
		pd.Descripcion, 
		p.Descripcion) AS Descripcion,
		COALESCE(est.precio2, op.PrecioOferta, pd.PrecioProducto*pd.FactorRepeticion ,p.PrecioUnitario*p.FactorRepeticion) AS PrecioCatalogo,
		p.MarcaID,
		0 AS EstaEnRevista,
		(CASE WHEN ISNULL(pf.CUV,0) = 0 THEN 1 WHEN ISNULL(pf.CUV,0) > 0 THEN 0 END) AS TieneStock,
		ISNULL(pcc.EsExpoOferta,0) AS EsExpoOferta,
		ISNULL(pcc.CUVRevista,'') AS CUVRevista,
		'' AS CUVComplemento,
		p.PaisID,
		p.AnoCampania AS CampaniaID,
		p.CodigoCatalago,
		p.CodigoProducto,
		p.IndicadorMontoMinimo,
		M.Descripcion AS DescripcionMarca,
		'NO DISPONIBLE' AS DescripcionCategoria,
		TE.DescripcionEstrategia AS DescripcionEstrategia,
		ISNULL(op.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		CASE
			WHEN EXISTS(SELECT 1 FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = p.CUV) THEN 1702
			WHEN EXISTS(SELECT 1 FROM TallaColorCUV WHERE CampaniaID = @CampaniaID AND CUV = p.CUV) THEN
				(
					SELECT E.TipoEstrategiaID FROM Estrategia E
					INNER JOIN TALLACOLORCUV TCC ON E.CAMPANIAID = TCC.CAMPANIAID AND E.CUV2 = TCC.CUVPADRE
					WHERE TCC.CUV = p.CUV AND E.CAMPANIAID=@CampaniaID
				)
			ELSE ISNULL(op.TipoOfertaSisID,0) END TipoOfertaSisID,
		ISNULL(te.flagNueva, 0) FlagNueva,
		ISNULL(te.TipoEstrategiaID, '') TipoEstrategiaID,
		P.IndicadorOferta,
		--@TieneSugerido AS TieneSugerido,
		ISNULL(ts.TieneSugerido,0) AS TieneSugerido,
		CASE
			WHEN pcor.SAP IS NULL THEN 0
			ELSE 1 
		END AS TieneOfertaRevista,		
		p.PrecioValorizado,
		CASE 
			WHEN pl.CodigoSAP IS NULL THEN 0
			ELSE 1 
		END AS TieneLanzamientoCatalogoPersonalizado,		
		ISNULL(pcor.Oferta,'') AS TipoOfertaRevista
	FROM ods.ProductoComercial p
	LEFT JOIN dbo.ProductoDescripcion pd ON 
		p.AnoCampania = pd.CampaniaID 
		AND p.CUV = pd.CUV
	LEFT JOIN @ProductoFaltanteTemp pf ON 
		p.CUV = pf.CUV
	LEFT JOIN ProductoComercialConfiguracion pcc ON 
		p.AnoCampania = pcc.CampaniaID 
		AND p.CUV = pcc.CUV
	LEFT JOIN @OfertaProductoTemp op ON 
		op.CampaniaID = P.CampaniaID 
		AND op.CUV = P.CUV
	LEFT JOIN MatrizComercial mc ON 
		p.CodigoProducto = mc.CodigoSAP
	LEFT JOIN Estrategia EST ON 
		--EST.CampaniaID = p.AnoCampania
		(EST.CampaniaID = p.AnoCampania OR p.AnoCampania BETWEEN EST.CampaniaID AND EST.CampaniaIDFin)
		AND (EST.CUV2 = p.CUV OR EST.CUV2 = (SELECT CUVPadre FROM TallaColorCUV TCC WHERE TCC.CUV = p.CUV)) 
		AND EST.Activo = 1 
	LEFT JOIN dbo.TallaColorCUV tcc 
		ON tcc.CUV = p.CUV 
		AND tcc.CampaniaID = p.AnoCampania
	LEFT JOIN TipoEstrategia TE ON 
		TE.TipoEstrategiaID = EST.TipoEstrategiaID
	LEFT JOIN Marca M ON 
		p.MarcaId = M.MarcaId
	LEFT JOIN ods.ProductosLanzamiento pl ON
		p.CodigoProducto = pl.CodigoSAP
		AND p.AnoCampania = pl.Campania
	LEFT JOIN ProductoComercialOfertaRevista pcor ON 
		p.AnoCampania = pcor.Campania 
		AND p.CUV = pcor.CUV
	LEFT JOIN @tblSugerido ts ON p.CUV = ts.CUV
	WHERE 
		p.AnoCampania = @CampaniaID 
		AND p.IndicadorDigitable = 1
		--AND CHARINDEX(@CodigoDescripcion,p.CUV)>0
		AND p.CUV IN (SELECT splitdata FROM dbo.fnSplitString(@listaCuv,','))
		AND p.CUV NOT IN (SELECT CUV FROM @tablaCuvOPT)
--END

END

GO
/*end*/

USE BelcorpColombia
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetProductoComercialByCampaniaBySearchRegionZonaListaCUV_SB2'))
BEGIN
    DROP PROCEDURE dbo.GetProductoComercialByCampaniaBySearchRegionZonaListaCUV_SB2
END

GO

CREATE PROCEDURE [dbo].[GetProductoComercialByCampaniaBySearchRegionZonaListaCUV_SB2]
	@CampaniaID INT,
	--@RowCount INT,
	--@Criterio INT,
	--@CodigoDescripcion VARCHAR(100),
	@ListaCUV VARCHAR(MAX),
	@RegionID INT,
	@ZonaID INT,
	@CodigoRegion VARCHAR(10),
	@CodigoZona VARCHAR(10),
	@ValidarOPT BIT = 0
AS
/*
dbo.GetProductoComercialByCampaniaBySearchRegionZona_SB2 201618,1,1,'97010',2701,2161,'50','5052'
dbo.GetProductoComercialByCampaniaBySearchRegionZona_SB2 201618,1,1,'97010',2701,2161,'50','5052',1
*/
BEGIN

-- Depuramos las tallas y colores
EXEC DepurarTallaColorCUV @CampaniaID
EXEC DepurarTallaColorLiquidacion @CampaniaID

DECLARE @OfertaProductoTemp TABLE
(
	CampaniaID INT,
	CUV VARCHAR(6),
	Descripcion VARCHAR(250),
	ConfiguracionOfertaID INT,
	TipoOfertaSisID INT,
	PrecioOferta NUMERIC(12,2)
)

INSERT INTO @OfertaProductoTemp
SELECT 
	op.CampaniaID, op.CUV, op.Descripcion, 
	op.ConfiguracionOfertaID, op.TipoOfertaSisID, NULL
FROM OfertaProducto op
INNER JOIN ods.Campania c ON
	op.CampaniaID = c.CampaniaID
WHERE c.codigo = @CampaniaID

INSERT INTO @OfertaProductoTemp    
SELECT 
	op.CampaniaID, op.CUV, op.Descripcion, 
	op.ConfiguracionOfertaID, op.TipoOfertaSisID, NULL    
FROM ShowRoom.OfertaShowRoom op    
INNER JOIN ods.Campania c ON     
	op.CampaniaID = c.CampaniaID    
WHERE --op.flaghabilitarproducto = 1 and     
 c.codigo = @CampaniaID

DECLARE @ProductoFaltanteTemp TABLE (CUV VARCHAR(6))

INSERT INTO @ProductoFaltanteTemp
SELECT 
	DISTINCT LTRIM(RTRIM(CUV))
	FROM ProductoFaltante NOLOCK
WHERE 
	CampaniaID = @CampaniaID and Zonaid = @ZonaID
UNION ALL
SELECT 
	DISTINCT LTRIM(RTRIM(fa.CodigoVenta)) AS CUV
FROM ods.FaltanteAnunciado fa (NOLOCK)
INNER JOIN ods.Campania c (NOLOCK) ON 
	fa.CampaniaID = c.CampaniaID
WHERE 
	c.Codigo = @CampaniaID 
	AND (RTRIM(fa.CodigoRegion) = @CodigoRegion OR fa.CodigoRegion IS NULL) 
	AND (RTRIM(fa.CodigoZona) = @CodigoZona OR fa.CodigoZona IS NULL)

--Logica para Producto Sugerido
--declare @TieneSugerido int = 0
--if exists (	select 1 from dbo.ProductoSugerido 
--			where CampaniaID = @CampaniaID and CUV = @CodigoDescripcion and Estado = 1)
--BEGIN
--	set @TieneSugerido = 1
--END

DECLARE @tblSugerido TABLE (
	CUV VARCHAR(6),
	TieneSugerido INT DEFAULT 0
)

INSERT INTO @tblSugerido
SELECT CUV, 1 
FROM dbo.ProductoSugerido 
WHERE CampaniaID = @CampaniaID 
	AND CUV IN (SELECT splitdata FROM dbo.fnSplitString(@listaCuv,',')) 
	AND Estado = 1 

DECLARE @tablaCuvOPT TABLE (CUV VARCHAR(6))

IF (@ValidarOPT = 1)
BEGIN
	INSERT INTO @tablaCuvOPT
	SELECT DISTINCT CUV 
	FROM ods.OfertasPersonalizadas 
	WHERE AnioCampanaVenta = @CampaniaID 
	AND TipoPersonalizacion='OPT'
END
	
--IF(@Criterio = 1)
--BEGIN
	SELECT 
		DISTINCT 
		--TOP (@RowCount) 
		p.CUV,
		COALESCE(EST.DescripcionCUV2 + ' '+ tcc.Descripcion, 
		est.descripcioncuv2, 
		op.Descripcion, 
		mc.Descripcion, 
		pd.Descripcion, 
		p.Descripcion) AS Descripcion,
		COALESCE(est.precio2, op.PrecioOferta, pd.PrecioProducto*pd.FactorRepeticion ,p.PrecioUnitario*p.FactorRepeticion) AS PrecioCatalogo,
		p.MarcaID,
		0 AS EstaEnRevista,
		(CASE WHEN ISNULL(pf.CUV,0) = 0 THEN 1 WHEN ISNULL(pf.CUV,0) > 0 THEN 0 END) AS TieneStock,
		ISNULL(pcc.EsExpoOferta,0) AS EsExpoOferta,
		ISNULL(pcc.CUVRevista,'') AS CUVRevista,
		'' AS CUVComplemento,
		p.PaisID,
		p.AnoCampania AS CampaniaID,
		p.CodigoCatalago,
		p.CodigoProducto,
		p.IndicadorMontoMinimo,
		M.Descripcion AS DescripcionMarca,
		'NO DISPONIBLE' AS DescripcionCategoria,
		TE.DescripcionEstrategia AS DescripcionEstrategia,
		ISNULL(op.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		CASE
			WHEN EXISTS(SELECT 1 FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = p.CUV) THEN 1702
			WHEN EXISTS(SELECT 1 FROM TallaColorCUV WHERE CampaniaID = @CampaniaID AND CUV = p.CUV) THEN
				(
					SELECT E.TipoEstrategiaID FROM Estrategia E
					INNER JOIN TALLACOLORCUV TCC ON E.CAMPANIAID = TCC.CAMPANIAID AND E.CUV2 = TCC.CUVPADRE
					WHERE TCC.CUV = p.CUV AND E.CAMPANIAID=@CampaniaID
				)
			ELSE ISNULL(op.TipoOfertaSisID,0) END TipoOfertaSisID,
		ISNULL(te.flagNueva, 0) FlagNueva,
		ISNULL(te.TipoEstrategiaID, '') TipoEstrategiaID,
		P.IndicadorOferta,
		--@TieneSugerido AS TieneSugerido,
		ISNULL(ts.TieneSugerido,0) AS TieneSugerido,
		CASE
			WHEN pcor.SAP IS NULL THEN 0
			ELSE 1 
		END AS TieneOfertaRevista,		
		p.PrecioValorizado,
		CASE 
			WHEN pl.CodigoSAP IS NULL THEN 0
			ELSE 1 
		END AS TieneLanzamientoCatalogoPersonalizado,		
		ISNULL(pcor.Oferta,'') AS TipoOfertaRevista
	FROM ods.ProductoComercial p
	LEFT JOIN dbo.ProductoDescripcion pd ON 
		p.AnoCampania = pd.CampaniaID 
		AND p.CUV = pd.CUV
	LEFT JOIN @ProductoFaltanteTemp pf ON 
		p.CUV = pf.CUV
	LEFT JOIN ProductoComercialConfiguracion pcc ON 
		p.AnoCampania = pcc.CampaniaID 
		AND p.CUV = pcc.CUV
	LEFT JOIN @OfertaProductoTemp op ON 
		op.CampaniaID = P.CampaniaID 
		AND op.CUV = P.CUV
	LEFT JOIN MatrizComercial mc ON 
		p.CodigoProducto = mc.CodigoSAP
	LEFT JOIN Estrategia EST ON 
		--EST.CampaniaID = p.AnoCampania
		(EST.CampaniaID = p.AnoCampania OR p.AnoCampania BETWEEN EST.CampaniaID AND EST.CampaniaIDFin)
		AND (EST.CUV2 = p.CUV OR EST.CUV2 = (SELECT CUVPadre FROM TallaColorCUV TCC WHERE TCC.CUV = p.CUV)) 
		AND EST.Activo = 1 
	LEFT JOIN dbo.TallaColorCUV tcc 
		ON tcc.CUV = p.CUV 
		AND tcc.CampaniaID = p.AnoCampania
	LEFT JOIN TipoEstrategia TE ON 
		TE.TipoEstrategiaID = EST.TipoEstrategiaID
	LEFT JOIN Marca M ON 
		p.MarcaId = M.MarcaId
	LEFT JOIN ods.ProductosLanzamiento pl ON
		p.CodigoProducto = pl.CodigoSAP
		AND p.AnoCampania = pl.Campania
	LEFT JOIN ProductoComercialOfertaRevista pcor ON 
		p.AnoCampania = pcor.Campania 
		AND p.CUV = pcor.CUV
	LEFT JOIN @tblSugerido ts ON p.CUV = ts.CUV
	WHERE 
		p.AnoCampania = @CampaniaID 
		AND p.IndicadorDigitable = 1
		--AND CHARINDEX(@CodigoDescripcion,p.CUV)>0
		AND p.CUV IN (SELECT splitdata FROM dbo.fnSplitString(@listaCuv,','))
		AND p.CUV NOT IN (SELECT CUV FROM @tablaCuvOPT)
--END

END

GO
/*end*/

USE BelcorpCostaRica
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetProductoComercialByCampaniaBySearchRegionZonaListaCUV_SB2'))
BEGIN
    DROP PROCEDURE dbo.GetProductoComercialByCampaniaBySearchRegionZonaListaCUV_SB2
END

GO

CREATE PROCEDURE [dbo].[GetProductoComercialByCampaniaBySearchRegionZonaListaCUV_SB2]
	@CampaniaID INT,
	--@RowCount INT,
	--@Criterio INT,
	--@CodigoDescripcion VARCHAR(100),
	@ListaCUV VARCHAR(MAX),
	@RegionID INT,
	@ZonaID INT,
	@CodigoRegion VARCHAR(10),
	@CodigoZona VARCHAR(10),
	@ValidarOPT BIT = 0
AS
/*
dbo.GetProductoComercialByCampaniaBySearchRegionZona_SB2 201618,1,1,'97010',2701,2161,'50','5052'
dbo.GetProductoComercialByCampaniaBySearchRegionZona_SB2 201618,1,1,'97010',2701,2161,'50','5052',1
*/
BEGIN

-- Depuramos las tallas y colores
EXEC DepurarTallaColorCUV @CampaniaID
EXEC DepurarTallaColorLiquidacion @CampaniaID

DECLARE @OfertaProductoTemp TABLE
(
	CampaniaID INT,
	CUV VARCHAR(6),
	Descripcion VARCHAR(250),
	ConfiguracionOfertaID INT,
	TipoOfertaSisID INT,
	PrecioOferta NUMERIC(12,2)
)

INSERT INTO @OfertaProductoTemp
SELECT 
	op.CampaniaID, op.CUV, op.Descripcion, 
	op.ConfiguracionOfertaID, op.TipoOfertaSisID, NULL
FROM OfertaProducto op
INNER JOIN ods.Campania c ON
	op.CampaniaID = c.CampaniaID
WHERE c.codigo = @CampaniaID

INSERT INTO @OfertaProductoTemp    
SELECT 
	op.CampaniaID, op.CUV, op.Descripcion, 
	op.ConfiguracionOfertaID, op.TipoOfertaSisID, NULL    
FROM ShowRoom.OfertaShowRoom op    
INNER JOIN ods.Campania c ON     
	op.CampaniaID = c.CampaniaID    
WHERE --op.flaghabilitarproducto = 1 and     
 c.codigo = @CampaniaID

DECLARE @ProductoFaltanteTemp TABLE (CUV VARCHAR(6))

INSERT INTO @ProductoFaltanteTemp
SELECT 
	DISTINCT LTRIM(RTRIM(CUV))
	FROM ProductoFaltante NOLOCK
WHERE 
	CampaniaID = @CampaniaID and Zonaid = @ZonaID
UNION ALL
SELECT 
	DISTINCT LTRIM(RTRIM(fa.CodigoVenta)) AS CUV
FROM ods.FaltanteAnunciado fa (NOLOCK)
INNER JOIN ods.Campania c (NOLOCK) ON 
	fa.CampaniaID = c.CampaniaID
WHERE 
	c.Codigo = @CampaniaID 
	AND (RTRIM(fa.CodigoRegion) = @CodigoRegion OR fa.CodigoRegion IS NULL) 
	AND (RTRIM(fa.CodigoZona) = @CodigoZona OR fa.CodigoZona IS NULL)

--Logica para Producto Sugerido
--declare @TieneSugerido int = 0
--if exists (	select 1 from dbo.ProductoSugerido 
--			where CampaniaID = @CampaniaID and CUV = @CodigoDescripcion and Estado = 1)
--BEGIN
--	set @TieneSugerido = 1
--END

DECLARE @tblSugerido TABLE (
	CUV VARCHAR(6),
	TieneSugerido INT DEFAULT 0
)

INSERT INTO @tblSugerido
SELECT CUV, 1 
FROM dbo.ProductoSugerido 
WHERE CampaniaID = @CampaniaID 
	AND CUV IN (SELECT splitdata FROM dbo.fnSplitString(@listaCuv,',')) 
	AND Estado = 1 

DECLARE @tablaCuvOPT TABLE (CUV VARCHAR(6))

IF (@ValidarOPT = 1)
BEGIN
	INSERT INTO @tablaCuvOPT
	SELECT DISTINCT CUV 
	FROM ods.OfertasPersonalizadas 
	WHERE AnioCampanaVenta = @CampaniaID 
	AND TipoPersonalizacion='OPT'
END
	
--IF(@Criterio = 1)
--BEGIN
	SELECT 
		DISTINCT 
		--TOP (@RowCount) 
		p.CUV,
		COALESCE(EST.DescripcionCUV2 + ' '+ tcc.Descripcion, 
		est.descripcioncuv2, 
		op.Descripcion, 
		mc.Descripcion, 
		pd.Descripcion, 
		p.Descripcion) AS Descripcion,
		COALESCE(est.precio2, op.PrecioOferta, pd.PrecioProducto*pd.FactorRepeticion ,p.PrecioUnitario*p.FactorRepeticion) AS PrecioCatalogo,
		p.MarcaID,
		0 AS EstaEnRevista,
		(CASE WHEN ISNULL(pf.CUV,0) = 0 THEN 1 WHEN ISNULL(pf.CUV,0) > 0 THEN 0 END) AS TieneStock,
		ISNULL(pcc.EsExpoOferta,0) AS EsExpoOferta,
		ISNULL(pcc.CUVRevista,'') AS CUVRevista,
		'' AS CUVComplemento,
		p.PaisID,
		p.AnoCampania AS CampaniaID,
		p.CodigoCatalago,
		p.CodigoProducto,
		p.IndicadorMontoMinimo,
		M.Descripcion AS DescripcionMarca,
		'NO DISPONIBLE' AS DescripcionCategoria,
		TE.DescripcionEstrategia AS DescripcionEstrategia,
		ISNULL(op.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		CASE
			WHEN EXISTS(SELECT 1 FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = p.CUV) THEN 1702
			WHEN EXISTS(SELECT 1 FROM TallaColorCUV WHERE CampaniaID = @CampaniaID AND CUV = p.CUV) THEN
				(
					SELECT E.TipoEstrategiaID FROM Estrategia E
					INNER JOIN TALLACOLORCUV TCC ON E.CAMPANIAID = TCC.CAMPANIAID AND E.CUV2 = TCC.CUVPADRE
					WHERE TCC.CUV = p.CUV AND E.CAMPANIAID=@CampaniaID
				)
			ELSE ISNULL(op.TipoOfertaSisID,0) END TipoOfertaSisID,
		ISNULL(te.flagNueva, 0) FlagNueva,
		ISNULL(te.TipoEstrategiaID, '') TipoEstrategiaID,
		P.IndicadorOferta,
		--@TieneSugerido AS TieneSugerido,
		ISNULL(ts.TieneSugerido,0) AS TieneSugerido,
		CASE
			WHEN pcor.SAP IS NULL THEN 0
			ELSE 1 
		END AS TieneOfertaRevista,		
		p.PrecioValorizado,
		CASE 
			WHEN pl.CodigoSAP IS NULL THEN 0
			ELSE 1 
		END AS TieneLanzamientoCatalogoPersonalizado,		
		ISNULL(pcor.Oferta,'') AS TipoOfertaRevista
	FROM ods.ProductoComercial p
	LEFT JOIN dbo.ProductoDescripcion pd ON 
		p.AnoCampania = pd.CampaniaID 
		AND p.CUV = pd.CUV
	LEFT JOIN @ProductoFaltanteTemp pf ON 
		p.CUV = pf.CUV
	LEFT JOIN ProductoComercialConfiguracion pcc ON 
		p.AnoCampania = pcc.CampaniaID 
		AND p.CUV = pcc.CUV
	LEFT JOIN @OfertaProductoTemp op ON 
		op.CampaniaID = P.CampaniaID 
		AND op.CUV = P.CUV
	LEFT JOIN MatrizComercial mc ON 
		p.CodigoProducto = mc.CodigoSAP
	LEFT JOIN Estrategia EST ON 
		--EST.CampaniaID = p.AnoCampania
		(EST.CampaniaID = p.AnoCampania OR p.AnoCampania BETWEEN EST.CampaniaID AND EST.CampaniaIDFin)
		AND (EST.CUV2 = p.CUV OR EST.CUV2 = (SELECT CUVPadre FROM TallaColorCUV TCC WHERE TCC.CUV = p.CUV)) 
		AND EST.Activo = 1 
	LEFT JOIN dbo.TallaColorCUV tcc 
		ON tcc.CUV = p.CUV 
		AND tcc.CampaniaID = p.AnoCampania
	LEFT JOIN TipoEstrategia TE ON 
		TE.TipoEstrategiaID = EST.TipoEstrategiaID
	LEFT JOIN Marca M ON 
		p.MarcaId = M.MarcaId
	LEFT JOIN ods.ProductosLanzamiento pl ON
		p.CodigoProducto = pl.CodigoSAP
		AND p.AnoCampania = pl.Campania
	LEFT JOIN ProductoComercialOfertaRevista pcor ON 
		p.AnoCampania = pcor.Campania 
		AND p.CUV = pcor.CUV
	LEFT JOIN @tblSugerido ts ON p.CUV = ts.CUV
	WHERE 
		p.AnoCampania = @CampaniaID 
		AND p.IndicadorDigitable = 1
		--AND CHARINDEX(@CodigoDescripcion,p.CUV)>0
		AND p.CUV IN (SELECT splitdata FROM dbo.fnSplitString(@listaCuv,','))
		AND p.CUV NOT IN (SELECT CUV FROM @tablaCuvOPT)
--END

END

GO
/*end*/

USE BelcorpDominicana
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetProductoComercialByCampaniaBySearchRegionZonaListaCUV_SB2'))
BEGIN
    DROP PROCEDURE dbo.GetProductoComercialByCampaniaBySearchRegionZonaListaCUV_SB2
END

GO

CREATE PROCEDURE [dbo].[GetProductoComercialByCampaniaBySearchRegionZonaListaCUV_SB2]
	@CampaniaID INT,
	--@RowCount INT,
	--@Criterio INT,
	--@CodigoDescripcion VARCHAR(100),
	@ListaCUV VARCHAR(MAX),
	@RegionID INT,
	@ZonaID INT,
	@CodigoRegion VARCHAR(10),
	@CodigoZona VARCHAR(10),
	@ValidarOPT BIT = 0
AS
/*
dbo.GetProductoComercialByCampaniaBySearchRegionZona_SB2 201618,1,1,'97010',2701,2161,'50','5052'
dbo.GetProductoComercialByCampaniaBySearchRegionZona_SB2 201618,1,1,'97010',2701,2161,'50','5052',1
*/
BEGIN

-- Depuramos las tallas y colores
EXEC DepurarTallaColorCUV @CampaniaID
EXEC DepurarTallaColorLiquidacion @CampaniaID

DECLARE @OfertaProductoTemp TABLE
(
	CampaniaID INT,
	CUV VARCHAR(6),
	Descripcion VARCHAR(250),
	ConfiguracionOfertaID INT,
	TipoOfertaSisID INT,
	PrecioOferta NUMERIC(12,2)
)

INSERT INTO @OfertaProductoTemp
SELECT 
	op.CampaniaID, op.CUV, op.Descripcion, 
	op.ConfiguracionOfertaID, op.TipoOfertaSisID, NULL
FROM OfertaProducto op
INNER JOIN ods.Campania c ON
	op.CampaniaID = c.CampaniaID
WHERE c.codigo = @CampaniaID

INSERT INTO @OfertaProductoTemp    
SELECT 
	op.CampaniaID, op.CUV, op.Descripcion, 
	op.ConfiguracionOfertaID, op.TipoOfertaSisID, NULL    
FROM ShowRoom.OfertaShowRoom op    
INNER JOIN ods.Campania c ON     
	op.CampaniaID = c.CampaniaID    
WHERE --op.flaghabilitarproducto = 1 and     
 c.codigo = @CampaniaID

DECLARE @ProductoFaltanteTemp TABLE (CUV VARCHAR(6))

INSERT INTO @ProductoFaltanteTemp
SELECT 
	DISTINCT LTRIM(RTRIM(CUV))
	FROM ProductoFaltante NOLOCK
WHERE 
	CampaniaID = @CampaniaID and Zonaid = @ZonaID
UNION ALL
SELECT 
	DISTINCT LTRIM(RTRIM(fa.CodigoVenta)) AS CUV
FROM ods.FaltanteAnunciado fa (NOLOCK)
INNER JOIN ods.Campania c (NOLOCK) ON 
	fa.CampaniaID = c.CampaniaID
WHERE 
	c.Codigo = @CampaniaID 
	AND (RTRIM(fa.CodigoRegion) = @CodigoRegion OR fa.CodigoRegion IS NULL) 
	AND (RTRIM(fa.CodigoZona) = @CodigoZona OR fa.CodigoZona IS NULL)

--Logica para Producto Sugerido
--declare @TieneSugerido int = 0
--if exists (	select 1 from dbo.ProductoSugerido 
--			where CampaniaID = @CampaniaID and CUV = @CodigoDescripcion and Estado = 1)
--BEGIN
--	set @TieneSugerido = 1
--END

DECLARE @tblSugerido TABLE (
	CUV VARCHAR(6),
	TieneSugerido INT DEFAULT 0
)

INSERT INTO @tblSugerido
SELECT CUV, 1 
FROM dbo.ProductoSugerido 
WHERE CampaniaID = @CampaniaID 
	AND CUV IN (SELECT splitdata FROM dbo.fnSplitString(@listaCuv,',')) 
	AND Estado = 1 

DECLARE @tablaCuvOPT TABLE (CUV VARCHAR(6))

IF (@ValidarOPT = 1)
BEGIN
	INSERT INTO @tablaCuvOPT
	SELECT DISTINCT CUV 
	FROM ods.OfertasPersonalizadas 
	WHERE AnioCampanaVenta = @CampaniaID 
	AND TipoPersonalizacion='OPT'
END
	
--IF(@Criterio = 1)
--BEGIN
	SELECT 
		DISTINCT 
		--TOP (@RowCount) 
		p.CUV,
		COALESCE(EST.DescripcionCUV2 + ' '+ tcc.Descripcion, 
		est.descripcioncuv2, 
		op.Descripcion, 
		mc.Descripcion, 
		pd.Descripcion, 
		p.Descripcion) AS Descripcion,
		COALESCE(est.precio2, op.PrecioOferta, pd.PrecioProducto*pd.FactorRepeticion ,p.PrecioUnitario*p.FactorRepeticion) AS PrecioCatalogo,
		p.MarcaID,
		0 AS EstaEnRevista,
		(CASE WHEN ISNULL(pf.CUV,0) = 0 THEN 1 WHEN ISNULL(pf.CUV,0) > 0 THEN 0 END) AS TieneStock,
		ISNULL(pcc.EsExpoOferta,0) AS EsExpoOferta,
		ISNULL(pcc.CUVRevista,'') AS CUVRevista,
		'' AS CUVComplemento,
		p.PaisID,
		p.AnoCampania AS CampaniaID,
		p.CodigoCatalago,
		p.CodigoProducto,
		p.IndicadorMontoMinimo,
		M.Descripcion AS DescripcionMarca,
		'NO DISPONIBLE' AS DescripcionCategoria,
		TE.DescripcionEstrategia AS DescripcionEstrategia,
		ISNULL(op.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		CASE
			WHEN EXISTS(SELECT 1 FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = p.CUV) THEN 1702
			WHEN EXISTS(SELECT 1 FROM TallaColorCUV WHERE CampaniaID = @CampaniaID AND CUV = p.CUV) THEN
				(
					SELECT E.TipoEstrategiaID FROM Estrategia E
					INNER JOIN TALLACOLORCUV TCC ON E.CAMPANIAID = TCC.CAMPANIAID AND E.CUV2 = TCC.CUVPADRE
					WHERE TCC.CUV = p.CUV AND E.CAMPANIAID=@CampaniaID
				)
			ELSE ISNULL(op.TipoOfertaSisID,0) END TipoOfertaSisID,
		ISNULL(te.flagNueva, 0) FlagNueva,
		ISNULL(te.TipoEstrategiaID, '') TipoEstrategiaID,
		P.IndicadorOferta,
		--@TieneSugerido AS TieneSugerido,
		ISNULL(ts.TieneSugerido,0) AS TieneSugerido,
		CASE
			WHEN pcor.SAP IS NULL THEN 0
			ELSE 1 
		END AS TieneOfertaRevista,		
		p.PrecioValorizado,
		CASE 
			WHEN pl.CodigoSAP IS NULL THEN 0
			ELSE 1 
		END AS TieneLanzamientoCatalogoPersonalizado,		
		ISNULL(pcor.Oferta,'') AS TipoOfertaRevista
	FROM ods.ProductoComercial p
	LEFT JOIN dbo.ProductoDescripcion pd ON 
		p.AnoCampania = pd.CampaniaID 
		AND p.CUV = pd.CUV
	LEFT JOIN @ProductoFaltanteTemp pf ON 
		p.CUV = pf.CUV
	LEFT JOIN ProductoComercialConfiguracion pcc ON 
		p.AnoCampania = pcc.CampaniaID 
		AND p.CUV = pcc.CUV
	LEFT JOIN @OfertaProductoTemp op ON 
		op.CampaniaID = P.CampaniaID 
		AND op.CUV = P.CUV
	LEFT JOIN MatrizComercial mc ON 
		p.CodigoProducto = mc.CodigoSAP
	LEFT JOIN Estrategia EST ON 
		--EST.CampaniaID = p.AnoCampania
		(EST.CampaniaID = p.AnoCampania OR p.AnoCampania BETWEEN EST.CampaniaID AND EST.CampaniaIDFin)
		AND (EST.CUV2 = p.CUV OR EST.CUV2 = (SELECT CUVPadre FROM TallaColorCUV TCC WHERE TCC.CUV = p.CUV)) 
		AND EST.Activo = 1 
	LEFT JOIN dbo.TallaColorCUV tcc 
		ON tcc.CUV = p.CUV 
		AND tcc.CampaniaID = p.AnoCampania
	LEFT JOIN TipoEstrategia TE ON 
		TE.TipoEstrategiaID = EST.TipoEstrategiaID
	LEFT JOIN Marca M ON 
		p.MarcaId = M.MarcaId
	LEFT JOIN ods.ProductosLanzamiento pl ON
		p.CodigoProducto = pl.CodigoSAP
		AND p.AnoCampania = pl.Campania
	LEFT JOIN ProductoComercialOfertaRevista pcor ON 
		p.AnoCampania = pcor.Campania 
		AND p.CUV = pcor.CUV
	LEFT JOIN @tblSugerido ts ON p.CUV = ts.CUV
	WHERE 
		p.AnoCampania = @CampaniaID 
		AND p.IndicadorDigitable = 1
		--AND CHARINDEX(@CodigoDescripcion,p.CUV)>0
		AND p.CUV IN (SELECT splitdata FROM dbo.fnSplitString(@listaCuv,','))
		AND p.CUV NOT IN (SELECT CUV FROM @tablaCuvOPT)
--END

END

GO
/*end*/

USE BelcorpEcuador
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetProductoComercialByCampaniaBySearchRegionZonaListaCUV_SB2'))
BEGIN
    DROP PROCEDURE dbo.GetProductoComercialByCampaniaBySearchRegionZonaListaCUV_SB2
END

GO

CREATE PROCEDURE [dbo].[GetProductoComercialByCampaniaBySearchRegionZonaListaCUV_SB2]
	@CampaniaID INT,
	--@RowCount INT,
	--@Criterio INT,
	--@CodigoDescripcion VARCHAR(100),
	@ListaCUV VARCHAR(MAX),
	@RegionID INT,
	@ZonaID INT,
	@CodigoRegion VARCHAR(10),
	@CodigoZona VARCHAR(10),
	@ValidarOPT BIT = 0
AS
/*
dbo.GetProductoComercialByCampaniaBySearchRegionZona_SB2 201618,1,1,'97010',2701,2161,'50','5052'
dbo.GetProductoComercialByCampaniaBySearchRegionZona_SB2 201618,1,1,'97010',2701,2161,'50','5052',1
*/
BEGIN

-- Depuramos las tallas y colores
EXEC DepurarTallaColorCUV @CampaniaID
EXEC DepurarTallaColorLiquidacion @CampaniaID

DECLARE @OfertaProductoTemp TABLE
(
	CampaniaID INT,
	CUV VARCHAR(6),
	Descripcion VARCHAR(250),
	ConfiguracionOfertaID INT,
	TipoOfertaSisID INT,
	PrecioOferta NUMERIC(12,2)
)

INSERT INTO @OfertaProductoTemp
SELECT 
	op.CampaniaID, op.CUV, op.Descripcion, 
	op.ConfiguracionOfertaID, op.TipoOfertaSisID, NULL
FROM OfertaProducto op
INNER JOIN ods.Campania c ON
	op.CampaniaID = c.CampaniaID
WHERE c.codigo = @CampaniaID

INSERT INTO @OfertaProductoTemp    
SELECT 
	op.CampaniaID, op.CUV, op.Descripcion, 
	op.ConfiguracionOfertaID, op.TipoOfertaSisID, NULL    
FROM ShowRoom.OfertaShowRoom op    
INNER JOIN ods.Campania c ON     
	op.CampaniaID = c.CampaniaID    
WHERE --op.flaghabilitarproducto = 1 and     
 c.codigo = @CampaniaID

DECLARE @ProductoFaltanteTemp TABLE (CUV VARCHAR(6))

INSERT INTO @ProductoFaltanteTemp
SELECT 
	DISTINCT LTRIM(RTRIM(CUV))
	FROM ProductoFaltante NOLOCK
WHERE 
	CampaniaID = @CampaniaID and Zonaid = @ZonaID
UNION ALL
SELECT 
	DISTINCT LTRIM(RTRIM(fa.CodigoVenta)) AS CUV
FROM ods.FaltanteAnunciado fa (NOLOCK)
INNER JOIN ods.Campania c (NOLOCK) ON 
	fa.CampaniaID = c.CampaniaID
WHERE 
	c.Codigo = @CampaniaID 
	AND (RTRIM(fa.CodigoRegion) = @CodigoRegion OR fa.CodigoRegion IS NULL) 
	AND (RTRIM(fa.CodigoZona) = @CodigoZona OR fa.CodigoZona IS NULL)

--Logica para Producto Sugerido
--declare @TieneSugerido int = 0
--if exists (	select 1 from dbo.ProductoSugerido 
--			where CampaniaID = @CampaniaID and CUV = @CodigoDescripcion and Estado = 1)
--BEGIN
--	set @TieneSugerido = 1
--END

DECLARE @tblSugerido TABLE (
	CUV VARCHAR(6),
	TieneSugerido INT DEFAULT 0
)

INSERT INTO @tblSugerido
SELECT CUV, 1 
FROM dbo.ProductoSugerido 
WHERE CampaniaID = @CampaniaID 
	AND CUV IN (SELECT splitdata FROM dbo.fnSplitString(@listaCuv,',')) 
	AND Estado = 1 

DECLARE @tablaCuvOPT TABLE (CUV VARCHAR(6))

IF (@ValidarOPT = 1)
BEGIN
	INSERT INTO @tablaCuvOPT
	SELECT DISTINCT CUV 
	FROM ods.OfertasPersonalizadas 
	WHERE AnioCampanaVenta = @CampaniaID 
	AND TipoPersonalizacion='OPT'
END
	
--IF(@Criterio = 1)
--BEGIN
	SELECT 
		DISTINCT 
		--TOP (@RowCount) 
		p.CUV,
		COALESCE(EST.DescripcionCUV2 + ' '+ tcc.Descripcion, 
		est.descripcioncuv2, 
		op.Descripcion, 
		mc.Descripcion, 
		pd.Descripcion, 
		p.Descripcion) AS Descripcion,
		COALESCE(est.precio2, op.PrecioOferta, pd.PrecioProducto*pd.FactorRepeticion ,p.PrecioUnitario*p.FactorRepeticion) AS PrecioCatalogo,
		p.MarcaID,
		0 AS EstaEnRevista,
		(CASE WHEN ISNULL(pf.CUV,0) = 0 THEN 1 WHEN ISNULL(pf.CUV,0) > 0 THEN 0 END) AS TieneStock,
		ISNULL(pcc.EsExpoOferta,0) AS EsExpoOferta,
		ISNULL(pcc.CUVRevista,'') AS CUVRevista,
		'' AS CUVComplemento,
		p.PaisID,
		p.AnoCampania AS CampaniaID,
		p.CodigoCatalago,
		p.CodigoProducto,
		p.IndicadorMontoMinimo,
		M.Descripcion AS DescripcionMarca,
		'NO DISPONIBLE' AS DescripcionCategoria,
		TE.DescripcionEstrategia AS DescripcionEstrategia,
		ISNULL(op.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		CASE
			WHEN EXISTS(SELECT 1 FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = p.CUV) THEN 1702
			WHEN EXISTS(SELECT 1 FROM TallaColorCUV WHERE CampaniaID = @CampaniaID AND CUV = p.CUV) THEN
				(
					SELECT E.TipoEstrategiaID FROM Estrategia E
					INNER JOIN TALLACOLORCUV TCC ON E.CAMPANIAID = TCC.CAMPANIAID AND E.CUV2 = TCC.CUVPADRE
					WHERE TCC.CUV = p.CUV AND E.CAMPANIAID=@CampaniaID
				)
			ELSE ISNULL(op.TipoOfertaSisID,0) END TipoOfertaSisID,
		ISNULL(te.flagNueva, 0) FlagNueva,
		ISNULL(te.TipoEstrategiaID, '') TipoEstrategiaID,
		P.IndicadorOferta,
		--@TieneSugerido AS TieneSugerido,
		ISNULL(ts.TieneSugerido,0) AS TieneSugerido,
		CASE
			WHEN pcor.SAP IS NULL THEN 0
			ELSE 1 
		END AS TieneOfertaRevista,		
		p.PrecioValorizado,
		CASE 
			WHEN pl.CodigoSAP IS NULL THEN 0
			ELSE 1 
		END AS TieneLanzamientoCatalogoPersonalizado,		
		ISNULL(pcor.Oferta,'') AS TipoOfertaRevista
	FROM ods.ProductoComercial p
	LEFT JOIN dbo.ProductoDescripcion pd ON 
		p.AnoCampania = pd.CampaniaID 
		AND p.CUV = pd.CUV
	LEFT JOIN @ProductoFaltanteTemp pf ON 
		p.CUV = pf.CUV
	LEFT JOIN ProductoComercialConfiguracion pcc ON 
		p.AnoCampania = pcc.CampaniaID 
		AND p.CUV = pcc.CUV
	LEFT JOIN @OfertaProductoTemp op ON 
		op.CampaniaID = P.CampaniaID 
		AND op.CUV = P.CUV
	LEFT JOIN MatrizComercial mc ON 
		p.CodigoProducto = mc.CodigoSAP
	LEFT JOIN Estrategia EST ON 
		--EST.CampaniaID = p.AnoCampania
		(EST.CampaniaID = p.AnoCampania OR p.AnoCampania BETWEEN EST.CampaniaID AND EST.CampaniaIDFin)
		AND (EST.CUV2 = p.CUV OR EST.CUV2 = (SELECT CUVPadre FROM TallaColorCUV TCC WHERE TCC.CUV = p.CUV)) 
		AND EST.Activo = 1 
	LEFT JOIN dbo.TallaColorCUV tcc 
		ON tcc.CUV = p.CUV 
		AND tcc.CampaniaID = p.AnoCampania
	LEFT JOIN TipoEstrategia TE ON 
		TE.TipoEstrategiaID = EST.TipoEstrategiaID
	LEFT JOIN Marca M ON 
		p.MarcaId = M.MarcaId
	LEFT JOIN ods.ProductosLanzamiento pl ON
		p.CodigoProducto = pl.CodigoSAP
		AND p.AnoCampania = pl.Campania
	LEFT JOIN ProductoComercialOfertaRevista pcor ON 
		p.AnoCampania = pcor.Campania 
		AND p.CUV = pcor.CUV
	LEFT JOIN @tblSugerido ts ON p.CUV = ts.CUV
	WHERE 
		p.AnoCampania = @CampaniaID 
		AND p.IndicadorDigitable = 1
		--AND CHARINDEX(@CodigoDescripcion,p.CUV)>0
		AND p.CUV IN (SELECT splitdata FROM dbo.fnSplitString(@listaCuv,','))
		AND p.CUV NOT IN (SELECT CUV FROM @tablaCuvOPT)
--END

END

GO
/*end*/

USE BelcorpGuatemala
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetProductoComercialByCampaniaBySearchRegionZonaListaCUV_SB2'))
BEGIN
    DROP PROCEDURE dbo.GetProductoComercialByCampaniaBySearchRegionZonaListaCUV_SB2
END

GO

CREATE PROCEDURE [dbo].[GetProductoComercialByCampaniaBySearchRegionZonaListaCUV_SB2]
	@CampaniaID INT,
	--@RowCount INT,
	--@Criterio INT,
	--@CodigoDescripcion VARCHAR(100),
	@ListaCUV VARCHAR(MAX),
	@RegionID INT,
	@ZonaID INT,
	@CodigoRegion VARCHAR(10),
	@CodigoZona VARCHAR(10),
	@ValidarOPT BIT = 0
AS
/*
dbo.GetProductoComercialByCampaniaBySearchRegionZona_SB2 201618,1,1,'97010',2701,2161,'50','5052'
dbo.GetProductoComercialByCampaniaBySearchRegionZona_SB2 201618,1,1,'97010',2701,2161,'50','5052',1
*/
BEGIN

-- Depuramos las tallas y colores
EXEC DepurarTallaColorCUV @CampaniaID
EXEC DepurarTallaColorLiquidacion @CampaniaID

DECLARE @OfertaProductoTemp TABLE
(
	CampaniaID INT,
	CUV VARCHAR(6),
	Descripcion VARCHAR(250),
	ConfiguracionOfertaID INT,
	TipoOfertaSisID INT,
	PrecioOferta NUMERIC(12,2)
)

INSERT INTO @OfertaProductoTemp
SELECT 
	op.CampaniaID, op.CUV, op.Descripcion, 
	op.ConfiguracionOfertaID, op.TipoOfertaSisID, NULL
FROM OfertaProducto op
INNER JOIN ods.Campania c ON
	op.CampaniaID = c.CampaniaID
WHERE c.codigo = @CampaniaID

INSERT INTO @OfertaProductoTemp    
SELECT 
	op.CampaniaID, op.CUV, op.Descripcion, 
	op.ConfiguracionOfertaID, op.TipoOfertaSisID, NULL    
FROM ShowRoom.OfertaShowRoom op    
INNER JOIN ods.Campania c ON     
	op.CampaniaID = c.CampaniaID    
WHERE --op.flaghabilitarproducto = 1 and     
 c.codigo = @CampaniaID

DECLARE @ProductoFaltanteTemp TABLE (CUV VARCHAR(6))

INSERT INTO @ProductoFaltanteTemp
SELECT 
	DISTINCT LTRIM(RTRIM(CUV))
	FROM ProductoFaltante NOLOCK
WHERE 
	CampaniaID = @CampaniaID and Zonaid = @ZonaID
UNION ALL
SELECT 
	DISTINCT LTRIM(RTRIM(fa.CodigoVenta)) AS CUV
FROM ods.FaltanteAnunciado fa (NOLOCK)
INNER JOIN ods.Campania c (NOLOCK) ON 
	fa.CampaniaID = c.CampaniaID
WHERE 
	c.Codigo = @CampaniaID 
	AND (RTRIM(fa.CodigoRegion) = @CodigoRegion OR fa.CodigoRegion IS NULL) 
	AND (RTRIM(fa.CodigoZona) = @CodigoZona OR fa.CodigoZona IS NULL)

--Logica para Producto Sugerido
--declare @TieneSugerido int = 0
--if exists (	select 1 from dbo.ProductoSugerido 
--			where CampaniaID = @CampaniaID and CUV = @CodigoDescripcion and Estado = 1)
--BEGIN
--	set @TieneSugerido = 1
--END

DECLARE @tblSugerido TABLE (
	CUV VARCHAR(6),
	TieneSugerido INT DEFAULT 0
)

INSERT INTO @tblSugerido
SELECT CUV, 1 
FROM dbo.ProductoSugerido 
WHERE CampaniaID = @CampaniaID 
	AND CUV IN (SELECT splitdata FROM dbo.fnSplitString(@listaCuv,',')) 
	AND Estado = 1 

DECLARE @tablaCuvOPT TABLE (CUV VARCHAR(6))

IF (@ValidarOPT = 1)
BEGIN
	INSERT INTO @tablaCuvOPT
	SELECT DISTINCT CUV 
	FROM ods.OfertasPersonalizadas 
	WHERE AnioCampanaVenta = @CampaniaID 
	AND TipoPersonalizacion='OPT'
END
	
--IF(@Criterio = 1)
--BEGIN
	SELECT 
		DISTINCT 
		--TOP (@RowCount) 
		p.CUV,
		COALESCE(EST.DescripcionCUV2 + ' '+ tcc.Descripcion, 
		est.descripcioncuv2, 
		op.Descripcion, 
		mc.Descripcion, 
		pd.Descripcion, 
		p.Descripcion) AS Descripcion,
		COALESCE(est.precio2, op.PrecioOferta, pd.PrecioProducto*pd.FactorRepeticion ,p.PrecioUnitario*p.FactorRepeticion) AS PrecioCatalogo,
		p.MarcaID,
		0 AS EstaEnRevista,
		(CASE WHEN ISNULL(pf.CUV,0) = 0 THEN 1 WHEN ISNULL(pf.CUV,0) > 0 THEN 0 END) AS TieneStock,
		ISNULL(pcc.EsExpoOferta,0) AS EsExpoOferta,
		ISNULL(pcc.CUVRevista,'') AS CUVRevista,
		'' AS CUVComplemento,
		p.PaisID,
		p.AnoCampania AS CampaniaID,
		p.CodigoCatalago,
		p.CodigoProducto,
		p.IndicadorMontoMinimo,
		M.Descripcion AS DescripcionMarca,
		'NO DISPONIBLE' AS DescripcionCategoria,
		TE.DescripcionEstrategia AS DescripcionEstrategia,
		ISNULL(op.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		CASE
			WHEN EXISTS(SELECT 1 FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = p.CUV) THEN 1702
			WHEN EXISTS(SELECT 1 FROM TallaColorCUV WHERE CampaniaID = @CampaniaID AND CUV = p.CUV) THEN
				(
					SELECT E.TipoEstrategiaID FROM Estrategia E
					INNER JOIN TALLACOLORCUV TCC ON E.CAMPANIAID = TCC.CAMPANIAID AND E.CUV2 = TCC.CUVPADRE
					WHERE TCC.CUV = p.CUV AND E.CAMPANIAID=@CampaniaID
				)
			ELSE ISNULL(op.TipoOfertaSisID,0) END TipoOfertaSisID,
		ISNULL(te.flagNueva, 0) FlagNueva,
		ISNULL(te.TipoEstrategiaID, '') TipoEstrategiaID,
		P.IndicadorOferta,
		--@TieneSugerido AS TieneSugerido,
		ISNULL(ts.TieneSugerido,0) AS TieneSugerido,
		CASE
			WHEN pcor.SAP IS NULL THEN 0
			ELSE 1 
		END AS TieneOfertaRevista,		
		p.PrecioValorizado,
		CASE 
			WHEN pl.CodigoSAP IS NULL THEN 0
			ELSE 1 
		END AS TieneLanzamientoCatalogoPersonalizado,		
		ISNULL(pcor.Oferta,'') AS TipoOfertaRevista
	FROM ods.ProductoComercial p
	LEFT JOIN dbo.ProductoDescripcion pd ON 
		p.AnoCampania = pd.CampaniaID 
		AND p.CUV = pd.CUV
	LEFT JOIN @ProductoFaltanteTemp pf ON 
		p.CUV = pf.CUV
	LEFT JOIN ProductoComercialConfiguracion pcc ON 
		p.AnoCampania = pcc.CampaniaID 
		AND p.CUV = pcc.CUV
	LEFT JOIN @OfertaProductoTemp op ON 
		op.CampaniaID = P.CampaniaID 
		AND op.CUV = P.CUV
	LEFT JOIN MatrizComercial mc ON 
		p.CodigoProducto = mc.CodigoSAP
	LEFT JOIN Estrategia EST ON 
		--EST.CampaniaID = p.AnoCampania
		(EST.CampaniaID = p.AnoCampania OR p.AnoCampania BETWEEN EST.CampaniaID AND EST.CampaniaIDFin)
		AND (EST.CUV2 = p.CUV OR EST.CUV2 = (SELECT CUVPadre FROM TallaColorCUV TCC WHERE TCC.CUV = p.CUV)) 
		AND EST.Activo = 1 
	LEFT JOIN dbo.TallaColorCUV tcc 
		ON tcc.CUV = p.CUV 
		AND tcc.CampaniaID = p.AnoCampania
	LEFT JOIN TipoEstrategia TE ON 
		TE.TipoEstrategiaID = EST.TipoEstrategiaID
	LEFT JOIN Marca M ON 
		p.MarcaId = M.MarcaId
	LEFT JOIN ods.ProductosLanzamiento pl ON
		p.CodigoProducto = pl.CodigoSAP
		AND p.AnoCampania = pl.Campania
	LEFT JOIN ProductoComercialOfertaRevista pcor ON 
		p.AnoCampania = pcor.Campania 
		AND p.CUV = pcor.CUV
	LEFT JOIN @tblSugerido ts ON p.CUV = ts.CUV
	WHERE 
		p.AnoCampania = @CampaniaID 
		AND p.IndicadorDigitable = 1
		--AND CHARINDEX(@CodigoDescripcion,p.CUV)>0
		AND p.CUV IN (SELECT splitdata FROM dbo.fnSplitString(@listaCuv,','))
		AND p.CUV NOT IN (SELECT CUV FROM @tablaCuvOPT)
--END

END

GO
/*end*/

USE BelcorpMexico
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetProductoComercialByCampaniaBySearchRegionZonaListaCUV_SB2'))
BEGIN
    DROP PROCEDURE dbo.GetProductoComercialByCampaniaBySearchRegionZonaListaCUV_SB2
END

GO

CREATE PROCEDURE [dbo].[GetProductoComercialByCampaniaBySearchRegionZonaListaCUV_SB2]
	@CampaniaID INT,
	--@RowCount INT,
	--@Criterio INT,
	--@CodigoDescripcion VARCHAR(100),
	@ListaCUV VARCHAR(MAX),
	@RegionID INT,
	@ZonaID INT,
	@CodigoRegion VARCHAR(10),
	@CodigoZona VARCHAR(10),
	@ValidarOPT BIT = 0
AS
/*
dbo.GetProductoComercialByCampaniaBySearchRegionZona_SB2 201618,1,1,'97010',2701,2161,'50','5052'
dbo.GetProductoComercialByCampaniaBySearchRegionZona_SB2 201618,1,1,'97010',2701,2161,'50','5052',1
*/
BEGIN

-- Depuramos las tallas y colores
EXEC DepurarTallaColorCUV @CampaniaID
EXEC DepurarTallaColorLiquidacion @CampaniaID

DECLARE @OfertaProductoTemp TABLE
(
	CampaniaID INT,
	CUV VARCHAR(6),
	Descripcion VARCHAR(250),
	ConfiguracionOfertaID INT,
	TipoOfertaSisID INT,
	PrecioOferta NUMERIC(12,2)
)

INSERT INTO @OfertaProductoTemp
SELECT 
	op.CampaniaID, op.CUV, op.Descripcion, 
	op.ConfiguracionOfertaID, op.TipoOfertaSisID, NULL
FROM OfertaProducto op
INNER JOIN ods.Campania c ON
	op.CampaniaID = c.CampaniaID
WHERE c.codigo = @CampaniaID

INSERT INTO @OfertaProductoTemp    
SELECT 
	op.CampaniaID, op.CUV, op.Descripcion, 
	op.ConfiguracionOfertaID, op.TipoOfertaSisID, NULL    
FROM ShowRoom.OfertaShowRoom op    
INNER JOIN ods.Campania c ON     
	op.CampaniaID = c.CampaniaID    
WHERE --op.flaghabilitarproducto = 1 and     
 c.codigo = @CampaniaID

DECLARE @ProductoFaltanteTemp TABLE (CUV VARCHAR(6))

INSERT INTO @ProductoFaltanteTemp
SELECT 
	DISTINCT LTRIM(RTRIM(CUV))
	FROM ProductoFaltante NOLOCK
WHERE 
	CampaniaID = @CampaniaID and Zonaid = @ZonaID
UNION ALL
SELECT 
	DISTINCT LTRIM(RTRIM(fa.CodigoVenta)) AS CUV
FROM ods.FaltanteAnunciado fa (NOLOCK)
INNER JOIN ods.Campania c (NOLOCK) ON 
	fa.CampaniaID = c.CampaniaID
WHERE 
	c.Codigo = @CampaniaID 
	AND (RTRIM(fa.CodigoRegion) = @CodigoRegion OR fa.CodigoRegion IS NULL) 
	AND (RTRIM(fa.CodigoZona) = @CodigoZona OR fa.CodigoZona IS NULL)

--Logica para Producto Sugerido
--declare @TieneSugerido int = 0
--if exists (	select 1 from dbo.ProductoSugerido 
--			where CampaniaID = @CampaniaID and CUV = @CodigoDescripcion and Estado = 1)
--BEGIN
--	set @TieneSugerido = 1
--END

DECLARE @tblSugerido TABLE (
	CUV VARCHAR(6),
	TieneSugerido INT DEFAULT 0
)

INSERT INTO @tblSugerido
SELECT CUV, 1 
FROM dbo.ProductoSugerido 
WHERE CampaniaID = @CampaniaID 
	AND CUV IN (SELECT splitdata FROM dbo.fnSplitString(@listaCuv,',')) 
	AND Estado = 1 

DECLARE @tablaCuvOPT TABLE (CUV VARCHAR(6))

IF (@ValidarOPT = 1)
BEGIN
	INSERT INTO @tablaCuvOPT
	SELECT DISTINCT CUV 
	FROM ods.OfertasPersonalizadas 
	WHERE AnioCampanaVenta = @CampaniaID 
	AND TipoPersonalizacion='OPT'
END
	
--IF(@Criterio = 1)
--BEGIN
	SELECT 
		DISTINCT 
		--TOP (@RowCount) 
		p.CUV,
		COALESCE(EST.DescripcionCUV2 + ' '+ tcc.Descripcion, 
		est.descripcioncuv2, 
		op.Descripcion, 
		mc.Descripcion, 
		pd.Descripcion, 
		p.Descripcion) AS Descripcion,
		COALESCE(est.precio2, op.PrecioOferta, pd.PrecioProducto*pd.FactorRepeticion ,p.PrecioUnitario*p.FactorRepeticion) AS PrecioCatalogo,
		p.MarcaID,
		0 AS EstaEnRevista,
		(CASE WHEN ISNULL(pf.CUV,0) = 0 THEN 1 WHEN ISNULL(pf.CUV,0) > 0 THEN 0 END) AS TieneStock,
		ISNULL(pcc.EsExpoOferta,0) AS EsExpoOferta,
		ISNULL(pcc.CUVRevista,'') AS CUVRevista,
		'' AS CUVComplemento,
		p.PaisID,
		p.AnoCampania AS CampaniaID,
		p.CodigoCatalago,
		p.CodigoProducto,
		p.IndicadorMontoMinimo,
		M.Descripcion AS DescripcionMarca,
		'NO DISPONIBLE' AS DescripcionCategoria,
		TE.DescripcionEstrategia AS DescripcionEstrategia,
		ISNULL(op.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		CASE
			WHEN EXISTS(SELECT 1 FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = p.CUV) THEN 1702
			WHEN EXISTS(SELECT 1 FROM TallaColorCUV WHERE CampaniaID = @CampaniaID AND CUV = p.CUV) THEN
				(
					SELECT E.TipoEstrategiaID FROM Estrategia E
					INNER JOIN TALLACOLORCUV TCC ON E.CAMPANIAID = TCC.CAMPANIAID AND E.CUV2 = TCC.CUVPADRE
					WHERE TCC.CUV = p.CUV AND E.CAMPANIAID=@CampaniaID
				)
			ELSE ISNULL(op.TipoOfertaSisID,0) END TipoOfertaSisID,
		ISNULL(te.flagNueva, 0) FlagNueva,
		ISNULL(te.TipoEstrategiaID, '') TipoEstrategiaID,
		P.IndicadorOferta,
		--@TieneSugerido AS TieneSugerido,
		ISNULL(ts.TieneSugerido,0) AS TieneSugerido,
		CASE
			WHEN pcor.SAP IS NULL THEN 0
			ELSE 1 
		END AS TieneOfertaRevista,		
		p.PrecioValorizado,
		CASE 
			WHEN pl.CodigoSAP IS NULL THEN 0
			ELSE 1 
		END AS TieneLanzamientoCatalogoPersonalizado,		
		ISNULL(pcor.Oferta,'') AS TipoOfertaRevista
	FROM ods.ProductoComercial p
	LEFT JOIN dbo.ProductoDescripcion pd ON 
		p.AnoCampania = pd.CampaniaID 
		AND p.CUV = pd.CUV
	LEFT JOIN @ProductoFaltanteTemp pf ON 
		p.CUV = pf.CUV
	LEFT JOIN ProductoComercialConfiguracion pcc ON 
		p.AnoCampania = pcc.CampaniaID 
		AND p.CUV = pcc.CUV
	LEFT JOIN @OfertaProductoTemp op ON 
		op.CampaniaID = P.CampaniaID 
		AND op.CUV = P.CUV
	LEFT JOIN MatrizComercial mc ON 
		p.CodigoProducto = mc.CodigoSAP
	LEFT JOIN Estrategia EST ON 
		--EST.CampaniaID = p.AnoCampania
		(EST.CampaniaID = p.AnoCampania OR p.AnoCampania BETWEEN EST.CampaniaID AND EST.CampaniaIDFin)
		AND (EST.CUV2 = p.CUV OR EST.CUV2 = (SELECT CUVPadre FROM TallaColorCUV TCC WHERE TCC.CUV = p.CUV)) 
		AND EST.Activo = 1 
	LEFT JOIN dbo.TallaColorCUV tcc 
		ON tcc.CUV = p.CUV 
		AND tcc.CampaniaID = p.AnoCampania
	LEFT JOIN TipoEstrategia TE ON 
		TE.TipoEstrategiaID = EST.TipoEstrategiaID
	LEFT JOIN Marca M ON 
		p.MarcaId = M.MarcaId
	LEFT JOIN ods.ProductosLanzamiento pl ON
		p.CodigoProducto = pl.CodigoSAP
		AND p.AnoCampania = pl.Campania
	LEFT JOIN ProductoComercialOfertaRevista pcor ON 
		p.AnoCampania = pcor.Campania 
		AND p.CUV = pcor.CUV
	LEFT JOIN @tblSugerido ts ON p.CUV = ts.CUV
	WHERE 
		p.AnoCampania = @CampaniaID 
		AND p.IndicadorDigitable = 1
		--AND CHARINDEX(@CodigoDescripcion,p.CUV)>0
		AND p.CUV IN (SELECT splitdata FROM dbo.fnSplitString(@listaCuv,','))
		AND p.CUV NOT IN (SELECT CUV FROM @tablaCuvOPT)
--END

END

GO
/*end*/

USE BelcorpPanama
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetProductoComercialByCampaniaBySearchRegionZonaListaCUV_SB2'))
BEGIN
    DROP PROCEDURE dbo.GetProductoComercialByCampaniaBySearchRegionZonaListaCUV_SB2
END

GO

CREATE PROCEDURE [dbo].[GetProductoComercialByCampaniaBySearchRegionZonaListaCUV_SB2]
	@CampaniaID INT,
	--@RowCount INT,
	--@Criterio INT,
	--@CodigoDescripcion VARCHAR(100),
	@ListaCUV VARCHAR(MAX),
	@RegionID INT,
	@ZonaID INT,
	@CodigoRegion VARCHAR(10),
	@CodigoZona VARCHAR(10),
	@ValidarOPT BIT = 0
AS
/*
dbo.GetProductoComercialByCampaniaBySearchRegionZona_SB2 201618,1,1,'97010',2701,2161,'50','5052'
dbo.GetProductoComercialByCampaniaBySearchRegionZona_SB2 201618,1,1,'97010',2701,2161,'50','5052',1
*/
BEGIN

-- Depuramos las tallas y colores
EXEC DepurarTallaColorCUV @CampaniaID
EXEC DepurarTallaColorLiquidacion @CampaniaID

DECLARE @OfertaProductoTemp TABLE
(
	CampaniaID INT,
	CUV VARCHAR(6),
	Descripcion VARCHAR(250),
	ConfiguracionOfertaID INT,
	TipoOfertaSisID INT,
	PrecioOferta NUMERIC(12,2)
)

INSERT INTO @OfertaProductoTemp
SELECT 
	op.CampaniaID, op.CUV, op.Descripcion, 
	op.ConfiguracionOfertaID, op.TipoOfertaSisID, NULL
FROM OfertaProducto op
INNER JOIN ods.Campania c ON
	op.CampaniaID = c.CampaniaID
WHERE c.codigo = @CampaniaID

INSERT INTO @OfertaProductoTemp    
SELECT 
	op.CampaniaID, op.CUV, op.Descripcion, 
	op.ConfiguracionOfertaID, op.TipoOfertaSisID, NULL    
FROM ShowRoom.OfertaShowRoom op    
INNER JOIN ods.Campania c ON     
	op.CampaniaID = c.CampaniaID    
WHERE --op.flaghabilitarproducto = 1 and     
 c.codigo = @CampaniaID

DECLARE @ProductoFaltanteTemp TABLE (CUV VARCHAR(6))

INSERT INTO @ProductoFaltanteTemp
SELECT 
	DISTINCT LTRIM(RTRIM(CUV))
	FROM ProductoFaltante NOLOCK
WHERE 
	CampaniaID = @CampaniaID and Zonaid = @ZonaID
UNION ALL
SELECT 
	DISTINCT LTRIM(RTRIM(fa.CodigoVenta)) AS CUV
FROM ods.FaltanteAnunciado fa (NOLOCK)
INNER JOIN ods.Campania c (NOLOCK) ON 
	fa.CampaniaID = c.CampaniaID
WHERE 
	c.Codigo = @CampaniaID 
	AND (RTRIM(fa.CodigoRegion) = @CodigoRegion OR fa.CodigoRegion IS NULL) 
	AND (RTRIM(fa.CodigoZona) = @CodigoZona OR fa.CodigoZona IS NULL)

--Logica para Producto Sugerido
--declare @TieneSugerido int = 0
--if exists (	select 1 from dbo.ProductoSugerido 
--			where CampaniaID = @CampaniaID and CUV = @CodigoDescripcion and Estado = 1)
--BEGIN
--	set @TieneSugerido = 1
--END

DECLARE @tblSugerido TABLE (
	CUV VARCHAR(6),
	TieneSugerido INT DEFAULT 0
)

INSERT INTO @tblSugerido
SELECT CUV, 1 
FROM dbo.ProductoSugerido 
WHERE CampaniaID = @CampaniaID 
	AND CUV IN (SELECT splitdata FROM dbo.fnSplitString(@listaCuv,',')) 
	AND Estado = 1 

DECLARE @tablaCuvOPT TABLE (CUV VARCHAR(6))

IF (@ValidarOPT = 1)
BEGIN
	INSERT INTO @tablaCuvOPT
	SELECT DISTINCT CUV 
	FROM ods.OfertasPersonalizadas 
	WHERE AnioCampanaVenta = @CampaniaID 
	AND TipoPersonalizacion='OPT'
END
	
--IF(@Criterio = 1)
--BEGIN
	SELECT 
		DISTINCT 
		--TOP (@RowCount) 
		p.CUV,
		COALESCE(EST.DescripcionCUV2 + ' '+ tcc.Descripcion, 
		est.descripcioncuv2, 
		op.Descripcion, 
		mc.Descripcion, 
		pd.Descripcion, 
		p.Descripcion) AS Descripcion,
		COALESCE(est.precio2, op.PrecioOferta, pd.PrecioProducto*pd.FactorRepeticion ,p.PrecioUnitario*p.FactorRepeticion) AS PrecioCatalogo,
		p.MarcaID,
		0 AS EstaEnRevista,
		(CASE WHEN ISNULL(pf.CUV,0) = 0 THEN 1 WHEN ISNULL(pf.CUV,0) > 0 THEN 0 END) AS TieneStock,
		ISNULL(pcc.EsExpoOferta,0) AS EsExpoOferta,
		ISNULL(pcc.CUVRevista,'') AS CUVRevista,
		'' AS CUVComplemento,
		p.PaisID,
		p.AnoCampania AS CampaniaID,
		p.CodigoCatalago,
		p.CodigoProducto,
		p.IndicadorMontoMinimo,
		M.Descripcion AS DescripcionMarca,
		'NO DISPONIBLE' AS DescripcionCategoria,
		TE.DescripcionEstrategia AS DescripcionEstrategia,
		ISNULL(op.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		CASE
			WHEN EXISTS(SELECT 1 FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = p.CUV) THEN 1702
			WHEN EXISTS(SELECT 1 FROM TallaColorCUV WHERE CampaniaID = @CampaniaID AND CUV = p.CUV) THEN
				(
					SELECT E.TipoEstrategiaID FROM Estrategia E
					INNER JOIN TALLACOLORCUV TCC ON E.CAMPANIAID = TCC.CAMPANIAID AND E.CUV2 = TCC.CUVPADRE
					WHERE TCC.CUV = p.CUV AND E.CAMPANIAID=@CampaniaID
				)
			ELSE ISNULL(op.TipoOfertaSisID,0) END TipoOfertaSisID,
		ISNULL(te.flagNueva, 0) FlagNueva,
		ISNULL(te.TipoEstrategiaID, '') TipoEstrategiaID,
		P.IndicadorOferta,
		--@TieneSugerido AS TieneSugerido,
		ISNULL(ts.TieneSugerido,0) AS TieneSugerido,
		CASE
			WHEN pcor.SAP IS NULL THEN 0
			ELSE 1 
		END AS TieneOfertaRevista,		
		p.PrecioValorizado,
		CASE 
			WHEN pl.CodigoSAP IS NULL THEN 0
			ELSE 1 
		END AS TieneLanzamientoCatalogoPersonalizado,		
		ISNULL(pcor.Oferta,'') AS TipoOfertaRevista
	FROM ods.ProductoComercial p
	LEFT JOIN dbo.ProductoDescripcion pd ON 
		p.AnoCampania = pd.CampaniaID 
		AND p.CUV = pd.CUV
	LEFT JOIN @ProductoFaltanteTemp pf ON 
		p.CUV = pf.CUV
	LEFT JOIN ProductoComercialConfiguracion pcc ON 
		p.AnoCampania = pcc.CampaniaID 
		AND p.CUV = pcc.CUV
	LEFT JOIN @OfertaProductoTemp op ON 
		op.CampaniaID = P.CampaniaID 
		AND op.CUV = P.CUV
	LEFT JOIN MatrizComercial mc ON 
		p.CodigoProducto = mc.CodigoSAP
	LEFT JOIN Estrategia EST ON 
		--EST.CampaniaID = p.AnoCampania
		(EST.CampaniaID = p.AnoCampania OR p.AnoCampania BETWEEN EST.CampaniaID AND EST.CampaniaIDFin)
		AND (EST.CUV2 = p.CUV OR EST.CUV2 = (SELECT CUVPadre FROM TallaColorCUV TCC WHERE TCC.CUV = p.CUV)) 
		AND EST.Activo = 1 
	LEFT JOIN dbo.TallaColorCUV tcc 
		ON tcc.CUV = p.CUV 
		AND tcc.CampaniaID = p.AnoCampania
	LEFT JOIN TipoEstrategia TE ON 
		TE.TipoEstrategiaID = EST.TipoEstrategiaID
	LEFT JOIN Marca M ON 
		p.MarcaId = M.MarcaId
	LEFT JOIN ods.ProductosLanzamiento pl ON
		p.CodigoProducto = pl.CodigoSAP
		AND p.AnoCampania = pl.Campania
	LEFT JOIN ProductoComercialOfertaRevista pcor ON 
		p.AnoCampania = pcor.Campania 
		AND p.CUV = pcor.CUV
	LEFT JOIN @tblSugerido ts ON p.CUV = ts.CUV
	WHERE 
		p.AnoCampania = @CampaniaID 
		AND p.IndicadorDigitable = 1
		--AND CHARINDEX(@CodigoDescripcion,p.CUV)>0
		AND p.CUV IN (SELECT splitdata FROM dbo.fnSplitString(@listaCuv,','))
		AND p.CUV NOT IN (SELECT CUV FROM @tablaCuvOPT)
--END

END

GO
/*end*/

USE BelcorpPeru
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetProductoComercialByCampaniaBySearchRegionZonaListaCUV_SB2'))
BEGIN
    DROP PROCEDURE dbo.GetProductoComercialByCampaniaBySearchRegionZonaListaCUV_SB2
END

GO

CREATE PROCEDURE [dbo].[GetProductoComercialByCampaniaBySearchRegionZonaListaCUV_SB2]
	@CampaniaID INT,
	--@RowCount INT,
	--@Criterio INT,
	--@CodigoDescripcion VARCHAR(100),
	@ListaCUV VARCHAR(MAX),
	@RegionID INT,
	@ZonaID INT,
	@CodigoRegion VARCHAR(10),
	@CodigoZona VARCHAR(10),
	@ValidarOPT BIT = 0
AS
/*
dbo.GetProductoComercialByCampaniaBySearchRegionZona_SB2 201618,1,1,'97010',2701,2161,'50','5052'
dbo.GetProductoComercialByCampaniaBySearchRegionZona_SB2 201618,1,1,'97010',2701,2161,'50','5052',1
*/
BEGIN

-- Depuramos las tallas y colores
EXEC DepurarTallaColorCUV @CampaniaID
EXEC DepurarTallaColorLiquidacion @CampaniaID

DECLARE @OfertaProductoTemp TABLE
(
	CampaniaID INT,
	CUV VARCHAR(6),
	Descripcion VARCHAR(250),
	ConfiguracionOfertaID INT,
	TipoOfertaSisID INT,
	PrecioOferta NUMERIC(12,2)
)

INSERT INTO @OfertaProductoTemp
SELECT 
	op.CampaniaID, op.CUV, op.Descripcion, 
	op.ConfiguracionOfertaID, op.TipoOfertaSisID, NULL
FROM OfertaProducto op
INNER JOIN ods.Campania c ON
	op.CampaniaID = c.CampaniaID
WHERE c.codigo = @CampaniaID

INSERT INTO @OfertaProductoTemp    
SELECT 
	op.CampaniaID, op.CUV, op.Descripcion, 
	op.ConfiguracionOfertaID, op.TipoOfertaSisID, NULL    
FROM ShowRoom.OfertaShowRoom op    
INNER JOIN ods.Campania c ON     
	op.CampaniaID = c.CampaniaID    
WHERE --op.flaghabilitarproducto = 1 and     
 c.codigo = @CampaniaID

DECLARE @ProductoFaltanteTemp TABLE (CUV VARCHAR(6))

INSERT INTO @ProductoFaltanteTemp
SELECT 
	DISTINCT LTRIM(RTRIM(CUV))
	FROM ProductoFaltante NOLOCK
WHERE 
	CampaniaID = @CampaniaID and Zonaid = @ZonaID
UNION ALL
SELECT 
	DISTINCT LTRIM(RTRIM(fa.CodigoVenta)) AS CUV
FROM ods.FaltanteAnunciado fa (NOLOCK)
INNER JOIN ods.Campania c (NOLOCK) ON 
	fa.CampaniaID = c.CampaniaID
WHERE 
	c.Codigo = @CampaniaID 
	AND (RTRIM(fa.CodigoRegion) = @CodigoRegion OR fa.CodigoRegion IS NULL) 
	AND (RTRIM(fa.CodigoZona) = @CodigoZona OR fa.CodigoZona IS NULL)

--Logica para Producto Sugerido
--declare @TieneSugerido int = 0
--if exists (	select 1 from dbo.ProductoSugerido 
--			where CampaniaID = @CampaniaID and CUV = @CodigoDescripcion and Estado = 1)
--BEGIN
--	set @TieneSugerido = 1
--END

DECLARE @tblSugerido TABLE (
	CUV VARCHAR(6),
	TieneSugerido INT DEFAULT 0
)

INSERT INTO @tblSugerido
SELECT CUV, 1 
FROM dbo.ProductoSugerido 
WHERE CampaniaID = @CampaniaID 
	AND CUV IN (SELECT splitdata FROM dbo.fnSplitString(@listaCuv,',')) 
	AND Estado = 1 

DECLARE @tablaCuvOPT TABLE (CUV VARCHAR(6))

IF (@ValidarOPT = 1)
BEGIN
	INSERT INTO @tablaCuvOPT
	SELECT DISTINCT CUV 
	FROM ods.OfertasPersonalizadas 
	WHERE AnioCampanaVenta = @CampaniaID 
	AND TipoPersonalizacion='OPT'
END
	
--IF(@Criterio = 1)
--BEGIN
	SELECT 
		DISTINCT 
		--TOP (@RowCount) 
		p.CUV,
		COALESCE(EST.DescripcionCUV2 + ' '+ tcc.Descripcion, 
		est.descripcioncuv2, 
		op.Descripcion, 
		mc.Descripcion, 
		pd.Descripcion, 
		p.Descripcion) AS Descripcion,
		COALESCE(est.precio2, op.PrecioOferta, pd.PrecioProducto*pd.FactorRepeticion ,p.PrecioUnitario*p.FactorRepeticion) AS PrecioCatalogo,
		p.MarcaID,
		0 AS EstaEnRevista,
		(CASE WHEN ISNULL(pf.CUV,0) = 0 THEN 1 WHEN ISNULL(pf.CUV,0) > 0 THEN 0 END) AS TieneStock,
		ISNULL(pcc.EsExpoOferta,0) AS EsExpoOferta,
		ISNULL(pcc.CUVRevista,'') AS CUVRevista,
		'' AS CUVComplemento,
		p.PaisID,
		p.AnoCampania AS CampaniaID,
		p.CodigoCatalago,
		p.CodigoProducto,
		p.IndicadorMontoMinimo,
		M.Descripcion AS DescripcionMarca,
		'NO DISPONIBLE' AS DescripcionCategoria,
		TE.DescripcionEstrategia AS DescripcionEstrategia,
		ISNULL(op.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		CASE
			WHEN EXISTS(SELECT 1 FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = p.CUV) THEN 1702
			WHEN EXISTS(SELECT 1 FROM TallaColorCUV WHERE CampaniaID = @CampaniaID AND CUV = p.CUV) THEN
				(
					SELECT E.TipoEstrategiaID FROM Estrategia E
					INNER JOIN TALLACOLORCUV TCC ON E.CAMPANIAID = TCC.CAMPANIAID AND E.CUV2 = TCC.CUVPADRE
					WHERE TCC.CUV = p.CUV AND E.CAMPANIAID=@CampaniaID
				)
			ELSE ISNULL(op.TipoOfertaSisID,0) END TipoOfertaSisID,
		ISNULL(te.flagNueva, 0) FlagNueva,
		ISNULL(te.TipoEstrategiaID, '') TipoEstrategiaID,
		P.IndicadorOferta,
		--@TieneSugerido AS TieneSugerido,
		ISNULL(ts.TieneSugerido,0) AS TieneSugerido,
		CASE
			WHEN pcor.SAP IS NULL THEN 0
			ELSE 1 
		END AS TieneOfertaRevista,		
		p.PrecioValorizado,
		CASE 
			WHEN pl.CodigoSAP IS NULL THEN 0
			ELSE 1 
		END AS TieneLanzamientoCatalogoPersonalizado,		
		ISNULL(pcor.Oferta,'') AS TipoOfertaRevista
	FROM ods.ProductoComercial p
	LEFT JOIN dbo.ProductoDescripcion pd ON 
		p.AnoCampania = pd.CampaniaID 
		AND p.CUV = pd.CUV
	LEFT JOIN @ProductoFaltanteTemp pf ON 
		p.CUV = pf.CUV
	LEFT JOIN ProductoComercialConfiguracion pcc ON 
		p.AnoCampania = pcc.CampaniaID 
		AND p.CUV = pcc.CUV
	LEFT JOIN @OfertaProductoTemp op ON 
		op.CampaniaID = P.CampaniaID 
		AND op.CUV = P.CUV
	LEFT JOIN MatrizComercial mc ON 
		p.CodigoProducto = mc.CodigoSAP
	LEFT JOIN Estrategia EST ON 
		--EST.CampaniaID = p.AnoCampania
		(EST.CampaniaID = p.AnoCampania OR p.AnoCampania BETWEEN EST.CampaniaID AND EST.CampaniaIDFin)
		AND (EST.CUV2 = p.CUV OR EST.CUV2 = (SELECT CUVPadre FROM TallaColorCUV TCC WHERE TCC.CUV = p.CUV)) 
		AND EST.Activo = 1 
	LEFT JOIN dbo.TallaColorCUV tcc 
		ON tcc.CUV = p.CUV 
		AND tcc.CampaniaID = p.AnoCampania
	LEFT JOIN TipoEstrategia TE ON 
		TE.TipoEstrategiaID = EST.TipoEstrategiaID
	LEFT JOIN Marca M ON 
		p.MarcaId = M.MarcaId
	LEFT JOIN ods.ProductosLanzamiento pl ON
		p.CodigoProducto = pl.CodigoSAP
		AND p.AnoCampania = pl.Campania
	LEFT JOIN ProductoComercialOfertaRevista pcor ON 
		p.AnoCampania = pcor.Campania 
		AND p.CUV = pcor.CUV
	LEFT JOIN @tblSugerido ts ON p.CUV = ts.CUV
	WHERE 
		p.AnoCampania = @CampaniaID 
		AND p.IndicadorDigitable = 1
		--AND CHARINDEX(@CodigoDescripcion,p.CUV)>0
		AND p.CUV IN (SELECT splitdata FROM dbo.fnSplitString(@listaCuv,','))
		AND p.CUV NOT IN (SELECT CUV FROM @tablaCuvOPT)
--END

END

GO
/*end*/

USE BelcorpPuertoRico
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetProductoComercialByCampaniaBySearchRegionZonaListaCUV_SB2'))
BEGIN
    DROP PROCEDURE dbo.GetProductoComercialByCampaniaBySearchRegionZonaListaCUV_SB2
END

GO

CREATE PROCEDURE [dbo].[GetProductoComercialByCampaniaBySearchRegionZonaListaCUV_SB2]
	@CampaniaID INT,
	--@RowCount INT,
	--@Criterio INT,
	--@CodigoDescripcion VARCHAR(100),
	@ListaCUV VARCHAR(MAX),
	@RegionID INT,
	@ZonaID INT,
	@CodigoRegion VARCHAR(10),
	@CodigoZona VARCHAR(10),
	@ValidarOPT BIT = 0
AS
/*
dbo.GetProductoComercialByCampaniaBySearchRegionZona_SB2 201618,1,1,'97010',2701,2161,'50','5052'
dbo.GetProductoComercialByCampaniaBySearchRegionZona_SB2 201618,1,1,'97010',2701,2161,'50','5052',1
*/
BEGIN

-- Depuramos las tallas y colores
EXEC DepurarTallaColorCUV @CampaniaID
EXEC DepurarTallaColorLiquidacion @CampaniaID

DECLARE @OfertaProductoTemp TABLE
(
	CampaniaID INT,
	CUV VARCHAR(6),
	Descripcion VARCHAR(250),
	ConfiguracionOfertaID INT,
	TipoOfertaSisID INT,
	PrecioOferta NUMERIC(12,2)
)

INSERT INTO @OfertaProductoTemp
SELECT 
	op.CampaniaID, op.CUV, op.Descripcion, 
	op.ConfiguracionOfertaID, op.TipoOfertaSisID, NULL
FROM OfertaProducto op
INNER JOIN ods.Campania c ON
	op.CampaniaID = c.CampaniaID
WHERE c.codigo = @CampaniaID

INSERT INTO @OfertaProductoTemp    
SELECT 
	op.CampaniaID, op.CUV, op.Descripcion, 
	op.ConfiguracionOfertaID, op.TipoOfertaSisID, NULL    
FROM ShowRoom.OfertaShowRoom op    
INNER JOIN ods.Campania c ON     
	op.CampaniaID = c.CampaniaID    
WHERE --op.flaghabilitarproducto = 1 and     
 c.codigo = @CampaniaID

DECLARE @ProductoFaltanteTemp TABLE (CUV VARCHAR(6))

INSERT INTO @ProductoFaltanteTemp
SELECT 
	DISTINCT LTRIM(RTRIM(CUV))
	FROM ProductoFaltante NOLOCK
WHERE 
	CampaniaID = @CampaniaID and Zonaid = @ZonaID
UNION ALL
SELECT 
	DISTINCT LTRIM(RTRIM(fa.CodigoVenta)) AS CUV
FROM ods.FaltanteAnunciado fa (NOLOCK)
INNER JOIN ods.Campania c (NOLOCK) ON 
	fa.CampaniaID = c.CampaniaID
WHERE 
	c.Codigo = @CampaniaID 
	AND (RTRIM(fa.CodigoRegion) = @CodigoRegion OR fa.CodigoRegion IS NULL) 
	AND (RTRIM(fa.CodigoZona) = @CodigoZona OR fa.CodigoZona IS NULL)

--Logica para Producto Sugerido
--declare @TieneSugerido int = 0
--if exists (	select 1 from dbo.ProductoSugerido 
--			where CampaniaID = @CampaniaID and CUV = @CodigoDescripcion and Estado = 1)
--BEGIN
--	set @TieneSugerido = 1
--END

DECLARE @tblSugerido TABLE (
	CUV VARCHAR(6),
	TieneSugerido INT DEFAULT 0
)

INSERT INTO @tblSugerido
SELECT CUV, 1 
FROM dbo.ProductoSugerido 
WHERE CampaniaID = @CampaniaID 
	AND CUV IN (SELECT splitdata FROM dbo.fnSplitString(@listaCuv,',')) 
	AND Estado = 1 

DECLARE @tablaCuvOPT TABLE (CUV VARCHAR(6))

IF (@ValidarOPT = 1)
BEGIN
	INSERT INTO @tablaCuvOPT
	SELECT DISTINCT CUV 
	FROM ods.OfertasPersonalizadas 
	WHERE AnioCampanaVenta = @CampaniaID 
	AND TipoPersonalizacion='OPT'
END
	
--IF(@Criterio = 1)
--BEGIN
	SELECT 
		DISTINCT 
		--TOP (@RowCount) 
		p.CUV,
		COALESCE(EST.DescripcionCUV2 + ' '+ tcc.Descripcion, 
		est.descripcioncuv2, 
		op.Descripcion, 
		mc.Descripcion, 
		pd.Descripcion, 
		p.Descripcion) AS Descripcion,
		COALESCE(est.precio2, op.PrecioOferta, pd.PrecioProducto*pd.FactorRepeticion ,p.PrecioUnitario*p.FactorRepeticion) AS PrecioCatalogo,
		p.MarcaID,
		0 AS EstaEnRevista,
		(CASE WHEN ISNULL(pf.CUV,0) = 0 THEN 1 WHEN ISNULL(pf.CUV,0) > 0 THEN 0 END) AS TieneStock,
		ISNULL(pcc.EsExpoOferta,0) AS EsExpoOferta,
		ISNULL(pcc.CUVRevista,'') AS CUVRevista,
		'' AS CUVComplemento,
		p.PaisID,
		p.AnoCampania AS CampaniaID,
		p.CodigoCatalago,
		p.CodigoProducto,
		p.IndicadorMontoMinimo,
		M.Descripcion AS DescripcionMarca,
		'NO DISPONIBLE' AS DescripcionCategoria,
		TE.DescripcionEstrategia AS DescripcionEstrategia,
		ISNULL(op.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		CASE
			WHEN EXISTS(SELECT 1 FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = p.CUV) THEN 1702
			WHEN EXISTS(SELECT 1 FROM TallaColorCUV WHERE CampaniaID = @CampaniaID AND CUV = p.CUV) THEN
				(
					SELECT E.TipoEstrategiaID FROM Estrategia E
					INNER JOIN TALLACOLORCUV TCC ON E.CAMPANIAID = TCC.CAMPANIAID AND E.CUV2 = TCC.CUVPADRE
					WHERE TCC.CUV = p.CUV AND E.CAMPANIAID=@CampaniaID
				)
			ELSE ISNULL(op.TipoOfertaSisID,0) END TipoOfertaSisID,
		ISNULL(te.flagNueva, 0) FlagNueva,
		ISNULL(te.TipoEstrategiaID, '') TipoEstrategiaID,
		P.IndicadorOferta,
		--@TieneSugerido AS TieneSugerido,
		ISNULL(ts.TieneSugerido,0) AS TieneSugerido,
		CASE
			WHEN pcor.SAP IS NULL THEN 0
			ELSE 1 
		END AS TieneOfertaRevista,		
		p.PrecioValorizado,
		CASE 
			WHEN pl.CodigoSAP IS NULL THEN 0
			ELSE 1 
		END AS TieneLanzamientoCatalogoPersonalizado,		
		ISNULL(pcor.Oferta,'') AS TipoOfertaRevista
	FROM ods.ProductoComercial p
	LEFT JOIN dbo.ProductoDescripcion pd ON 
		p.AnoCampania = pd.CampaniaID 
		AND p.CUV = pd.CUV
	LEFT JOIN @ProductoFaltanteTemp pf ON 
		p.CUV = pf.CUV
	LEFT JOIN ProductoComercialConfiguracion pcc ON 
		p.AnoCampania = pcc.CampaniaID 
		AND p.CUV = pcc.CUV
	LEFT JOIN @OfertaProductoTemp op ON 
		op.CampaniaID = P.CampaniaID 
		AND op.CUV = P.CUV
	LEFT JOIN MatrizComercial mc ON 
		p.CodigoProducto = mc.CodigoSAP
	LEFT JOIN Estrategia EST ON 
		--EST.CampaniaID = p.AnoCampania
		(EST.CampaniaID = p.AnoCampania OR p.AnoCampania BETWEEN EST.CampaniaID AND EST.CampaniaIDFin)
		AND (EST.CUV2 = p.CUV OR EST.CUV2 = (SELECT CUVPadre FROM TallaColorCUV TCC WHERE TCC.CUV = p.CUV)) 
		AND EST.Activo = 1 
	LEFT JOIN dbo.TallaColorCUV tcc 
		ON tcc.CUV = p.CUV 
		AND tcc.CampaniaID = p.AnoCampania
	LEFT JOIN TipoEstrategia TE ON 
		TE.TipoEstrategiaID = EST.TipoEstrategiaID
	LEFT JOIN Marca M ON 
		p.MarcaId = M.MarcaId
	LEFT JOIN ods.ProductosLanzamiento pl ON
		p.CodigoProducto = pl.CodigoSAP
		AND p.AnoCampania = pl.Campania
	LEFT JOIN ProductoComercialOfertaRevista pcor ON 
		p.AnoCampania = pcor.Campania 
		AND p.CUV = pcor.CUV
	LEFT JOIN @tblSugerido ts ON p.CUV = ts.CUV
	WHERE 
		p.AnoCampania = @CampaniaID 
		AND p.IndicadorDigitable = 1
		--AND CHARINDEX(@CodigoDescripcion,p.CUV)>0
		AND p.CUV IN (SELECT splitdata FROM dbo.fnSplitString(@listaCuv,','))
		AND p.CUV NOT IN (SELECT CUV FROM @tablaCuvOPT)
--END

END

GO
/*end*/

USE BelcorpSalvador
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetProductoComercialByCampaniaBySearchRegionZonaListaCUV_SB2'))
BEGIN
    DROP PROCEDURE dbo.GetProductoComercialByCampaniaBySearchRegionZonaListaCUV_SB2
END

GO

CREATE PROCEDURE [dbo].[GetProductoComercialByCampaniaBySearchRegionZonaListaCUV_SB2]
	@CampaniaID INT,
	--@RowCount INT,
	--@Criterio INT,
	--@CodigoDescripcion VARCHAR(100),
	@ListaCUV VARCHAR(MAX),
	@RegionID INT,
	@ZonaID INT,
	@CodigoRegion VARCHAR(10),
	@CodigoZona VARCHAR(10),
	@ValidarOPT BIT = 0
AS
/*
dbo.GetProductoComercialByCampaniaBySearchRegionZona_SB2 201618,1,1,'97010',2701,2161,'50','5052'
dbo.GetProductoComercialByCampaniaBySearchRegionZona_SB2 201618,1,1,'97010',2701,2161,'50','5052',1
*/
BEGIN

-- Depuramos las tallas y colores
EXEC DepurarTallaColorCUV @CampaniaID
EXEC DepurarTallaColorLiquidacion @CampaniaID

DECLARE @OfertaProductoTemp TABLE
(
	CampaniaID INT,
	CUV VARCHAR(6),
	Descripcion VARCHAR(250),
	ConfiguracionOfertaID INT,
	TipoOfertaSisID INT,
	PrecioOferta NUMERIC(12,2)
)

INSERT INTO @OfertaProductoTemp
SELECT 
	op.CampaniaID, op.CUV, op.Descripcion, 
	op.ConfiguracionOfertaID, op.TipoOfertaSisID, NULL
FROM OfertaProducto op
INNER JOIN ods.Campania c ON
	op.CampaniaID = c.CampaniaID
WHERE c.codigo = @CampaniaID

INSERT INTO @OfertaProductoTemp    
SELECT 
	op.CampaniaID, op.CUV, op.Descripcion, 
	op.ConfiguracionOfertaID, op.TipoOfertaSisID, NULL    
FROM ShowRoom.OfertaShowRoom op    
INNER JOIN ods.Campania c ON     
	op.CampaniaID = c.CampaniaID    
WHERE --op.flaghabilitarproducto = 1 and     
 c.codigo = @CampaniaID

DECLARE @ProductoFaltanteTemp TABLE (CUV VARCHAR(6))

INSERT INTO @ProductoFaltanteTemp
SELECT 
	DISTINCT LTRIM(RTRIM(CUV))
	FROM ProductoFaltante NOLOCK
WHERE 
	CampaniaID = @CampaniaID and Zonaid = @ZonaID
UNION ALL
SELECT 
	DISTINCT LTRIM(RTRIM(fa.CodigoVenta)) AS CUV
FROM ods.FaltanteAnunciado fa (NOLOCK)
INNER JOIN ods.Campania c (NOLOCK) ON 
	fa.CampaniaID = c.CampaniaID
WHERE 
	c.Codigo = @CampaniaID 
	AND (RTRIM(fa.CodigoRegion) = @CodigoRegion OR fa.CodigoRegion IS NULL) 
	AND (RTRIM(fa.CodigoZona) = @CodigoZona OR fa.CodigoZona IS NULL)

--Logica para Producto Sugerido
--declare @TieneSugerido int = 0
--if exists (	select 1 from dbo.ProductoSugerido 
--			where CampaniaID = @CampaniaID and CUV = @CodigoDescripcion and Estado = 1)
--BEGIN
--	set @TieneSugerido = 1
--END

DECLARE @tblSugerido TABLE (
	CUV VARCHAR(6),
	TieneSugerido INT DEFAULT 0
)

INSERT INTO @tblSugerido
SELECT CUV, 1 
FROM dbo.ProductoSugerido 
WHERE CampaniaID = @CampaniaID 
	AND CUV IN (SELECT splitdata FROM dbo.fnSplitString(@listaCuv,',')) 
	AND Estado = 1 

DECLARE @tablaCuvOPT TABLE (CUV VARCHAR(6))

IF (@ValidarOPT = 1)
BEGIN
	INSERT INTO @tablaCuvOPT
	SELECT DISTINCT CUV 
	FROM ods.OfertasPersonalizadas 
	WHERE AnioCampanaVenta = @CampaniaID 
	AND TipoPersonalizacion='OPT'
END
	
--IF(@Criterio = 1)
--BEGIN
	SELECT 
		DISTINCT 
		--TOP (@RowCount) 
		p.CUV,
		COALESCE(EST.DescripcionCUV2 + ' '+ tcc.Descripcion, 
		est.descripcioncuv2, 
		op.Descripcion, 
		mc.Descripcion, 
		pd.Descripcion, 
		p.Descripcion) AS Descripcion,
		COALESCE(est.precio2, op.PrecioOferta, pd.PrecioProducto*pd.FactorRepeticion ,p.PrecioUnitario*p.FactorRepeticion) AS PrecioCatalogo,
		p.MarcaID,
		0 AS EstaEnRevista,
		(CASE WHEN ISNULL(pf.CUV,0) = 0 THEN 1 WHEN ISNULL(pf.CUV,0) > 0 THEN 0 END) AS TieneStock,
		ISNULL(pcc.EsExpoOferta,0) AS EsExpoOferta,
		ISNULL(pcc.CUVRevista,'') AS CUVRevista,
		'' AS CUVComplemento,
		p.PaisID,
		p.AnoCampania AS CampaniaID,
		p.CodigoCatalago,
		p.CodigoProducto,
		p.IndicadorMontoMinimo,
		M.Descripcion AS DescripcionMarca,
		'NO DISPONIBLE' AS DescripcionCategoria,
		TE.DescripcionEstrategia AS DescripcionEstrategia,
		ISNULL(op.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		CASE
			WHEN EXISTS(SELECT 1 FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = p.CUV) THEN 1702
			WHEN EXISTS(SELECT 1 FROM TallaColorCUV WHERE CampaniaID = @CampaniaID AND CUV = p.CUV) THEN
				(
					SELECT E.TipoEstrategiaID FROM Estrategia E
					INNER JOIN TALLACOLORCUV TCC ON E.CAMPANIAID = TCC.CAMPANIAID AND E.CUV2 = TCC.CUVPADRE
					WHERE TCC.CUV = p.CUV AND E.CAMPANIAID=@CampaniaID
				)
			ELSE ISNULL(op.TipoOfertaSisID,0) END TipoOfertaSisID,
		ISNULL(te.flagNueva, 0) FlagNueva,
		ISNULL(te.TipoEstrategiaID, '') TipoEstrategiaID,
		P.IndicadorOferta,
		--@TieneSugerido AS TieneSugerido,
		ISNULL(ts.TieneSugerido,0) AS TieneSugerido,
		CASE
			WHEN pcor.SAP IS NULL THEN 0
			ELSE 1 
		END AS TieneOfertaRevista,		
		p.PrecioValorizado,
		CASE 
			WHEN pl.CodigoSAP IS NULL THEN 0
			ELSE 1 
		END AS TieneLanzamientoCatalogoPersonalizado,		
		ISNULL(pcor.Oferta,'') AS TipoOfertaRevista
	FROM ods.ProductoComercial p
	LEFT JOIN dbo.ProductoDescripcion pd ON 
		p.AnoCampania = pd.CampaniaID 
		AND p.CUV = pd.CUV
	LEFT JOIN @ProductoFaltanteTemp pf ON 
		p.CUV = pf.CUV
	LEFT JOIN ProductoComercialConfiguracion pcc ON 
		p.AnoCampania = pcc.CampaniaID 
		AND p.CUV = pcc.CUV
	LEFT JOIN @OfertaProductoTemp op ON 
		op.CampaniaID = P.CampaniaID 
		AND op.CUV = P.CUV
	LEFT JOIN MatrizComercial mc ON 
		p.CodigoProducto = mc.CodigoSAP
	LEFT JOIN Estrategia EST ON 
		--EST.CampaniaID = p.AnoCampania
		(EST.CampaniaID = p.AnoCampania OR p.AnoCampania BETWEEN EST.CampaniaID AND EST.CampaniaIDFin)
		AND (EST.CUV2 = p.CUV OR EST.CUV2 = (SELECT CUVPadre FROM TallaColorCUV TCC WHERE TCC.CUV = p.CUV)) 
		AND EST.Activo = 1 
	LEFT JOIN dbo.TallaColorCUV tcc 
		ON tcc.CUV = p.CUV 
		AND tcc.CampaniaID = p.AnoCampania
	LEFT JOIN TipoEstrategia TE ON 
		TE.TipoEstrategiaID = EST.TipoEstrategiaID
	LEFT JOIN Marca M ON 
		p.MarcaId = M.MarcaId
	LEFT JOIN ods.ProductosLanzamiento pl ON
		p.CodigoProducto = pl.CodigoSAP
		AND p.AnoCampania = pl.Campania
	LEFT JOIN ProductoComercialOfertaRevista pcor ON 
		p.AnoCampania = pcor.Campania 
		AND p.CUV = pcor.CUV
	LEFT JOIN @tblSugerido ts ON p.CUV = ts.CUV
	WHERE 
		p.AnoCampania = @CampaniaID 
		AND p.IndicadorDigitable = 1
		--AND CHARINDEX(@CodigoDescripcion,p.CUV)>0
		AND p.CUV IN (SELECT splitdata FROM dbo.fnSplitString(@listaCuv,','))
		AND p.CUV NOT IN (SELECT CUV FROM @tablaCuvOPT)
--END

END

GO
/*end*/

USE BelcorpVenezuela
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetProductoComercialByCampaniaBySearchRegionZonaListaCUV_SB2'))
BEGIN
    DROP PROCEDURE dbo.GetProductoComercialByCampaniaBySearchRegionZonaListaCUV_SB2
END

GO

CREATE PROCEDURE [dbo].[GetProductoComercialByCampaniaBySearchRegionZonaListaCUV_SB2]
	@CampaniaID INT,
	--@RowCount INT,
	--@Criterio INT,
	--@CodigoDescripcion VARCHAR(100),
	@ListaCUV VARCHAR(MAX),
	@RegionID INT,
	@ZonaID INT,
	@CodigoRegion VARCHAR(10),
	@CodigoZona VARCHAR(10),
	@ValidarOPT BIT = 0
AS
/*
dbo.GetProductoComercialByCampaniaBySearchRegionZona_SB2 201618,1,1,'97010',2701,2161,'50','5052'
dbo.GetProductoComercialByCampaniaBySearchRegionZona_SB2 201618,1,1,'97010',2701,2161,'50','5052',1
*/
BEGIN

-- Depuramos las tallas y colores
EXEC DepurarTallaColorCUV @CampaniaID
EXEC DepurarTallaColorLiquidacion @CampaniaID

DECLARE @OfertaProductoTemp TABLE
(
	CampaniaID INT,
	CUV VARCHAR(6),
	Descripcion VARCHAR(250),
	ConfiguracionOfertaID INT,
	TipoOfertaSisID INT,
	PrecioOferta NUMERIC(12,2)
)

INSERT INTO @OfertaProductoTemp
SELECT 
	op.CampaniaID, op.CUV, op.Descripcion, 
	op.ConfiguracionOfertaID, op.TipoOfertaSisID, NULL
FROM OfertaProducto op
INNER JOIN ods.Campania c ON
	op.CampaniaID = c.CampaniaID
WHERE c.codigo = @CampaniaID

INSERT INTO @OfertaProductoTemp    
SELECT 
	op.CampaniaID, op.CUV, op.Descripcion, 
	op.ConfiguracionOfertaID, op.TipoOfertaSisID, NULL    
FROM ShowRoom.OfertaShowRoom op    
INNER JOIN ods.Campania c ON     
	op.CampaniaID = c.CampaniaID    
WHERE --op.flaghabilitarproducto = 1 and     
 c.codigo = @CampaniaID

DECLARE @ProductoFaltanteTemp TABLE (CUV VARCHAR(6))

INSERT INTO @ProductoFaltanteTemp
SELECT 
	DISTINCT LTRIM(RTRIM(CUV))
	FROM ProductoFaltante NOLOCK
WHERE 
	CampaniaID = @CampaniaID and Zonaid = @ZonaID
UNION ALL
SELECT 
	DISTINCT LTRIM(RTRIM(fa.CodigoVenta)) AS CUV
FROM ods.FaltanteAnunciado fa (NOLOCK)
INNER JOIN ods.Campania c (NOLOCK) ON 
	fa.CampaniaID = c.CampaniaID
WHERE 
	c.Codigo = @CampaniaID 
	AND (RTRIM(fa.CodigoRegion) = @CodigoRegion OR fa.CodigoRegion IS NULL) 
	AND (RTRIM(fa.CodigoZona) = @CodigoZona OR fa.CodigoZona IS NULL)

--Logica para Producto Sugerido
--declare @TieneSugerido int = 0
--if exists (	select 1 from dbo.ProductoSugerido 
--			where CampaniaID = @CampaniaID and CUV = @CodigoDescripcion and Estado = 1)
--BEGIN
--	set @TieneSugerido = 1
--END

DECLARE @tblSugerido TABLE (
	CUV VARCHAR(6),
	TieneSugerido INT DEFAULT 0
)

INSERT INTO @tblSugerido
SELECT CUV, 1 
FROM dbo.ProductoSugerido 
WHERE CampaniaID = @CampaniaID 
	AND CUV IN (SELECT splitdata FROM dbo.fnSplitString(@listaCuv,',')) 
	AND Estado = 1 

DECLARE @tablaCuvOPT TABLE (CUV VARCHAR(6))

IF (@ValidarOPT = 1)
BEGIN
	INSERT INTO @tablaCuvOPT
	SELECT DISTINCT CUV 
	FROM ods.OfertasPersonalizadas 
	WHERE AnioCampanaVenta = @CampaniaID 
	AND TipoPersonalizacion='OPT'
END
	
--IF(@Criterio = 1)
--BEGIN
	SELECT 
		DISTINCT 
		--TOP (@RowCount) 
		p.CUV,
		COALESCE(EST.DescripcionCUV2 + ' '+ tcc.Descripcion, 
		est.descripcioncuv2, 
		op.Descripcion, 
		mc.Descripcion, 
		pd.Descripcion, 
		p.Descripcion) AS Descripcion,
		COALESCE(est.precio2, op.PrecioOferta, pd.PrecioProducto*pd.FactorRepeticion ,p.PrecioUnitario*p.FactorRepeticion) AS PrecioCatalogo,
		p.MarcaID,
		0 AS EstaEnRevista,
		(CASE WHEN ISNULL(pf.CUV,0) = 0 THEN 1 WHEN ISNULL(pf.CUV,0) > 0 THEN 0 END) AS TieneStock,
		ISNULL(pcc.EsExpoOferta,0) AS EsExpoOferta,
		ISNULL(pcc.CUVRevista,'') AS CUVRevista,
		'' AS CUVComplemento,
		p.PaisID,
		p.AnoCampania AS CampaniaID,
		p.CodigoCatalago,
		p.CodigoProducto,
		p.IndicadorMontoMinimo,
		M.Descripcion AS DescripcionMarca,
		'NO DISPONIBLE' AS DescripcionCategoria,
		TE.DescripcionEstrategia AS DescripcionEstrategia,
		ISNULL(op.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		CASE
			WHEN EXISTS(SELECT 1 FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = p.CUV) THEN 1702
			WHEN EXISTS(SELECT 1 FROM TallaColorCUV WHERE CampaniaID = @CampaniaID AND CUV = p.CUV) THEN
				(
					SELECT E.TipoEstrategiaID FROM Estrategia E
					INNER JOIN TALLACOLORCUV TCC ON E.CAMPANIAID = TCC.CAMPANIAID AND E.CUV2 = TCC.CUVPADRE
					WHERE TCC.CUV = p.CUV AND E.CAMPANIAID=@CampaniaID
				)
			ELSE ISNULL(op.TipoOfertaSisID,0) END TipoOfertaSisID,
		ISNULL(te.flagNueva, 0) FlagNueva,
		ISNULL(te.TipoEstrategiaID, '') TipoEstrategiaID,
		P.IndicadorOferta,
		--@TieneSugerido AS TieneSugerido,
		ISNULL(ts.TieneSugerido,0) AS TieneSugerido,
		CASE
			WHEN pcor.SAP IS NULL THEN 0
			ELSE 1 
		END AS TieneOfertaRevista,		
		p.PrecioValorizado,
		CASE 
			WHEN pl.CodigoSAP IS NULL THEN 0
			ELSE 1 
		END AS TieneLanzamientoCatalogoPersonalizado,		
		ISNULL(pcor.Oferta,'') AS TipoOfertaRevista
	FROM ods.ProductoComercial p
	LEFT JOIN dbo.ProductoDescripcion pd ON 
		p.AnoCampania = pd.CampaniaID 
		AND p.CUV = pd.CUV
	LEFT JOIN @ProductoFaltanteTemp pf ON 
		p.CUV = pf.CUV
	LEFT JOIN ProductoComercialConfiguracion pcc ON 
		p.AnoCampania = pcc.CampaniaID 
		AND p.CUV = pcc.CUV
	LEFT JOIN @OfertaProductoTemp op ON 
		op.CampaniaID = P.CampaniaID 
		AND op.CUV = P.CUV
	LEFT JOIN MatrizComercial mc ON 
		p.CodigoProducto = mc.CodigoSAP
	LEFT JOIN Estrategia EST ON 
		--EST.CampaniaID = p.AnoCampania
		(EST.CampaniaID = p.AnoCampania OR p.AnoCampania BETWEEN EST.CampaniaID AND EST.CampaniaIDFin)
		AND (EST.CUV2 = p.CUV OR EST.CUV2 = (SELECT CUVPadre FROM TallaColorCUV TCC WHERE TCC.CUV = p.CUV)) 
		AND EST.Activo = 1 
	LEFT JOIN dbo.TallaColorCUV tcc 
		ON tcc.CUV = p.CUV 
		AND tcc.CampaniaID = p.AnoCampania
	LEFT JOIN TipoEstrategia TE ON 
		TE.TipoEstrategiaID = EST.TipoEstrategiaID
	LEFT JOIN Marca M ON 
		p.MarcaId = M.MarcaId
	LEFT JOIN ods.ProductosLanzamiento pl ON
		p.CodigoProducto = pl.CodigoSAP
		AND p.AnoCampania = pl.Campania
	LEFT JOIN ProductoComercialOfertaRevista pcor ON 
		p.AnoCampania = pcor.Campania 
		AND p.CUV = pcor.CUV
	LEFT JOIN @tblSugerido ts ON p.CUV = ts.CUV
	WHERE 
		p.AnoCampania = @CampaniaID 
		AND p.IndicadorDigitable = 1
		--AND CHARINDEX(@CodigoDescripcion,p.CUV)>0
		AND p.CUV IN (SELECT splitdata FROM dbo.fnSplitString(@listaCuv,','))
		AND p.CUV NOT IN (SELECT CUV FROM @tablaCuvOPT)
--END

END

GO