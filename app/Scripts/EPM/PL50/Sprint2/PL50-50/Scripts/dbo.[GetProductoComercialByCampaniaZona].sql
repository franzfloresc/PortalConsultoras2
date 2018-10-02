--todos iguales
GO

USE BelcorpPeru
GO

IF (OBJECT_ID('[dbo].[GetProductoComercialByCampaniaZona]', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE [dbo].[GetProductoComercialByCampaniaZona] AS SET NOCOUNT ON;')
GO

ALTER PROCEDURE GetProductoComercialByCampaniaZona @CampaniaID INT
	,@RegionID INT
	,@ZonaID INT
	,@CodigoRegion VARCHAR(10)
	,@CodigoZona VARCHAR(10)
	,@RowCount INT
	,@Criterio INT
	,@TextoBusqueda VARCHAR(100)
AS
BEGIN
	--INI: Lista de Ofertas
	DECLARE @OfertaProductoTemp TABLE (
		CampaniaID INT
		,CUV VARCHAR(6)
		,Descripcion VARCHAR(250)
		,ConfiguracionOfertaID INT
		,TipoOfertaSisID INT
		,ImagenProducto VARCHAR(250)
		);

	INSERT INTO @OfertaProductoTemp
	SELECT op.CampaniaID
		,op.CUV
		,op.Descripcion
		,op.ConfiguracionOfertaID
		,op.TipoOfertaSisID
		,op.ImagenProducto
	FROM OfertaProducto op WITH (NOLOCK)
	INNER JOIN ods.Campania c ON op.CampaniaID = c.CampaniaID
	WHERE c.codigo = @CampaniaID
	
	UNION ALL
	
	SELECT c.CampaniaID
		,e.CUV2 as CUV
		,e.DescripcionCUV2 as Descripcion
		,ves.ConfiguracionOfertaID
		,ves.TipoOfertaSisID
		,e.ImagenURL as ImagenProducto
	FROM dbo.Estrategia e WITH (NOLOCK)
	INNER JOIN ods.Campania c ON e.CampaniaID = c.Codigo
	INNER JOIN vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE c.codigo = @CampaniaID;
	--FIN: Lista de Ofertas

	--INI: Lista de Productos Faltantes
	DECLARE @ProductoFaltanteTemp TABLE (CUV VARCHAR(6))

	INSERT INTO @ProductoFaltanteTemp
	SELECT DISTINCT ltrim(rtrim(CUV))
	FROM dbo.ProductoFaltante WITH (NOLOCK)
	WHERE CampaniaID = @CampaniaID
		AND Zonaid = @ZonaID
	
	UNION ALL
	
	SELECT DISTINCT ltrim(rtrim(fa.CodigoVenta)) AS CUV
	FROM ods.FaltanteAnunciado fa WITH (NOLOCK)
	INNER JOIN ods.Campania c WITH (NOLOCK) ON fa.CampaniaID = c.CampaniaID
	WHERE c.Codigo = @CampaniaID
		AND (
			fa.CodigoRegion IS NULL
			OR rtrim(fa.CodigoRegion) = @CodigoRegion
			)
		AND (
			fa.CodigoZona IS NULL
			OR rtrim(fa.CodigoZona) = @CodigoZona
			)

	--FIN: Lista de Productos Faltantes
	SELECT DISTINCT TOP (@RowCount) p.CUV
		,p.CodigoProducto AS CodigoSAP
		,coalesce(est.descripcioncuv2, op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion) AS Descripcion
		,coalesce(est.precio2, pd.PrecioProducto * pd.FactorRepeticion, p.PrecioUnitario * p.FactorRepeticion) AS PrecioCatalogo
		,iif(isnull(pf.CUV, 0) = 0, 1, 0) AS TieneStock
		,isnull(pcc.EsExpoOferta, 0) AS EsExpoOferta
		,isnull(pcc.CUVRevista, '') AS CUVRevista
		,p.IndicadorMontoMinimo
		,M.Descripcion AS DescripcionMarca
		,TE.DescripcionEstrategia AS DescripcionEstrategia
		,isnull(op.ConfiguracionOfertaID, 0) ConfiguracionOfertaID
		,isnull(op.TipoOfertaSisID, 0) TipoOfertaSisID
		,isnull(te.flagNueva, 0) FlagNueva
		,isnull(te.TipoEstrategiaID, '') TipoEstrategiaID
		,iif(PS.ProductoSugeridoID IS NULL, 0, 1) AS TieneSugerido
		,isnull(Cat.Descripcion, '') AS CatalogoDescripcion
		,coalesce(op.ImagenProducto, est.ImagenURL, PS2.ImagenProducto) AS ImagenOferta
		,coalesce(mc.FotoProducto01, mc.FotoProducto02, mc.FotoProducto03, mc.FotoProducto04, mc.FotoProducto05, mc.FotoProducto06, mc.FotoProducto07, mc.FotoProducto08, mc.FotoProducto09, mc.FotoProducto10) AS ImagenProducto
		,coalesce(est.descripcioncuv2, op.Descripcion) AS DescripcionOferta
		,coalesce(mc.Descripcion, pd.Descripcion, p.Descripcion) AS DescripcionProducto
	FROM ods.ProductoComercial p
	LEFT JOIN Marca M ON p.MarcaId = M.MarcaId
	LEFT JOIN dbo.ProductoDescripcion pd ON p.AnoCampania = pd.CampaniaID
		AND p.CUV = pd.CUV
	LEFT JOIN @ProductoFaltanteTemp pf ON p.CUV = pf.CUV
	LEFT JOIN ProductoComercialConfiguracion pcc ON p.AnoCampania = pcc.CampaniaID
		AND p.CUV = pcc.CUV
	LEFT JOIN @OfertaProductoTemp op ON op.CampaniaID = P.CampaniaID
		AND op.CUV = P.CUV
	LEFT JOIN MatrizComercial mc ON p.CodigoProducto = mc.CodigoSAP
	LEFT JOIN Estrategia EST ON (
			p.AnoCampania BETWEEN EST.CampaniaID
				AND isnull(EST.CampaniaIDFin, EST.CampaniaID)
			)
		AND EST.CUV2 = p.CUV
		AND EST.Activo = 1
	LEFT JOIN TipoEstrategia TE ON TE.TipoEstrategiaID = EST.TipoEstrategiaID
	LEFT JOIN ProductoSugerido PS ON PS.CampaniaID = p.AnoCampania
		AND PS.CUV = P.CUV
		AND PS.Estado = 1
	LEFT JOIN ProductoSugerido PS2 ON PS2.CampaniaID = p.AnoCampania
		AND PS2.CUVSugerido = P.CUV
		AND PS.Estado = 1
	LEFT JOIN ods.Catalogo Cat WITH (NOLOCK) ON p.CodigoCatalago = Cat.CodigoCatalogo
	WHERE p.AnoCampania = @CampaniaID
		AND p.IndicadorDigitable = 1
		AND CHARINDEX(@TextoBusqueda, iif(@Criterio = 1, p.CUV, coalesce(est.descripcioncuv2, op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion))) > 0;
END

GO

USE BelcorpMexico
GO

IF (OBJECT_ID('[dbo].[GetProductoComercialByCampaniaZona]', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE [dbo].[GetProductoComercialByCampaniaZona] AS SET NOCOUNT ON;')
GO

ALTER PROCEDURE GetProductoComercialByCampaniaZona @CampaniaID INT
	,@RegionID INT
	,@ZonaID INT
	,@CodigoRegion VARCHAR(10)
	,@CodigoZona VARCHAR(10)
	,@RowCount INT
	,@Criterio INT
	,@TextoBusqueda VARCHAR(100)
AS
BEGIN
	--INI: Lista de Ofertas
	DECLARE @OfertaProductoTemp TABLE (
		CampaniaID INT
		,CUV VARCHAR(6)
		,Descripcion VARCHAR(250)
		,ConfiguracionOfertaID INT
		,TipoOfertaSisID INT
		,ImagenProducto VARCHAR(250)
		);

	INSERT INTO @OfertaProductoTemp
	SELECT op.CampaniaID
		,op.CUV
		,op.Descripcion
		,op.ConfiguracionOfertaID
		,op.TipoOfertaSisID
		,op.ImagenProducto
	FROM OfertaProducto op WITH (NOLOCK)
	INNER JOIN ods.Campania c ON op.CampaniaID = c.CampaniaID
	WHERE c.codigo = @CampaniaID
	
	UNION ALL
	
	SELECT c.CampaniaID
		,e.CUV2 as CUV
		,e.DescripcionCUV2 as Descripcion
		,ves.ConfiguracionOfertaID
		,ves.TipoOfertaSisID
		,e.ImagenURL as ImagenProducto
	FROM dbo.Estrategia e WITH (NOLOCK)
	INNER JOIN ods.Campania c ON e.CampaniaID = c.Codigo
	INNER JOIN vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE c.codigo = @CampaniaID;
	--FIN: Lista de Ofertas

	--INI: Lista de Productos Faltantes
	DECLARE @ProductoFaltanteTemp TABLE (CUV VARCHAR(6))

	INSERT INTO @ProductoFaltanteTemp
	SELECT DISTINCT ltrim(rtrim(CUV))
	FROM dbo.ProductoFaltante WITH (NOLOCK)
	WHERE CampaniaID = @CampaniaID
		AND Zonaid = @ZonaID
	
	UNION ALL
	
	SELECT DISTINCT ltrim(rtrim(fa.CodigoVenta)) AS CUV
	FROM ods.FaltanteAnunciado fa WITH (NOLOCK)
	INNER JOIN ods.Campania c WITH (NOLOCK) ON fa.CampaniaID = c.CampaniaID
	WHERE c.Codigo = @CampaniaID
		AND (
			fa.CodigoRegion IS NULL
			OR rtrim(fa.CodigoRegion) = @CodigoRegion
			)
		AND (
			fa.CodigoZona IS NULL
			OR rtrim(fa.CodigoZona) = @CodigoZona
			)

	--FIN: Lista de Productos Faltantes
	SELECT DISTINCT TOP (@RowCount) p.CUV
		,p.CodigoProducto AS CodigoSAP
		,coalesce(est.descripcioncuv2, op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion) AS Descripcion
		,coalesce(est.precio2, pd.PrecioProducto * pd.FactorRepeticion, p.PrecioUnitario * p.FactorRepeticion) AS PrecioCatalogo
		,iif(isnull(pf.CUV, 0) = 0, 1, 0) AS TieneStock
		,isnull(pcc.EsExpoOferta, 0) AS EsExpoOferta
		,isnull(pcc.CUVRevista, '') AS CUVRevista
		,p.IndicadorMontoMinimo
		,M.Descripcion AS DescripcionMarca
		,TE.DescripcionEstrategia AS DescripcionEstrategia
		,isnull(op.ConfiguracionOfertaID, 0) ConfiguracionOfertaID
		,isnull(op.TipoOfertaSisID, 0) TipoOfertaSisID
		,isnull(te.flagNueva, 0) FlagNueva
		,isnull(te.TipoEstrategiaID, '') TipoEstrategiaID
		,iif(PS.ProductoSugeridoID IS NULL, 0, 1) AS TieneSugerido
		,isnull(Cat.Descripcion, '') AS CatalogoDescripcion
		,coalesce(op.ImagenProducto, est.ImagenURL, PS2.ImagenProducto) AS ImagenOferta
		,coalesce(mc.FotoProducto01, mc.FotoProducto02, mc.FotoProducto03, mc.FotoProducto04, mc.FotoProducto05, mc.FotoProducto06, mc.FotoProducto07, mc.FotoProducto08, mc.FotoProducto09, mc.FotoProducto10) AS ImagenProducto
		,coalesce(est.descripcioncuv2, op.Descripcion) AS DescripcionOferta
		,coalesce(mc.Descripcion, pd.Descripcion, p.Descripcion) AS DescripcionProducto
	FROM ods.ProductoComercial p
	LEFT JOIN Marca M ON p.MarcaId = M.MarcaId
	LEFT JOIN dbo.ProductoDescripcion pd ON p.AnoCampania = pd.CampaniaID
		AND p.CUV = pd.CUV
	LEFT JOIN @ProductoFaltanteTemp pf ON p.CUV = pf.CUV
	LEFT JOIN ProductoComercialConfiguracion pcc ON p.AnoCampania = pcc.CampaniaID
		AND p.CUV = pcc.CUV
	LEFT JOIN @OfertaProductoTemp op ON op.CampaniaID = P.CampaniaID
		AND op.CUV = P.CUV
	LEFT JOIN MatrizComercial mc ON p.CodigoProducto = mc.CodigoSAP
	LEFT JOIN Estrategia EST ON (
			p.AnoCampania BETWEEN EST.CampaniaID
				AND isnull(EST.CampaniaIDFin, EST.CampaniaID)
			)
		AND EST.CUV2 = p.CUV
		AND EST.Activo = 1
	LEFT JOIN TipoEstrategia TE ON TE.TipoEstrategiaID = EST.TipoEstrategiaID
	LEFT JOIN ProductoSugerido PS ON PS.CampaniaID = p.AnoCampania
		AND PS.CUV = P.CUV
		AND PS.Estado = 1
	LEFT JOIN ProductoSugerido PS2 ON PS2.CampaniaID = p.AnoCampania
		AND PS2.CUVSugerido = P.CUV
		AND PS.Estado = 1
	LEFT JOIN ods.Catalogo Cat WITH (NOLOCK) ON p.CodigoCatalago = Cat.CodigoCatalogo
	WHERE p.AnoCampania = @CampaniaID
		AND p.IndicadorDigitable = 1
		AND CHARINDEX(@TextoBusqueda, iif(@Criterio = 1, p.CUV, coalesce(est.descripcioncuv2, op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion))) > 0;
END

GO

USE BelcorpColombia
GO

IF (OBJECT_ID('[dbo].[GetProductoComercialByCampaniaZona]', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE [dbo].[GetProductoComercialByCampaniaZona] AS SET NOCOUNT ON;')
GO

ALTER PROCEDURE GetProductoComercialByCampaniaZona @CampaniaID INT
	,@RegionID INT
	,@ZonaID INT
	,@CodigoRegion VARCHAR(10)
	,@CodigoZona VARCHAR(10)
	,@RowCount INT
	,@Criterio INT
	,@TextoBusqueda VARCHAR(100)
AS
BEGIN
	--INI: Lista de Ofertas
	DECLARE @OfertaProductoTemp TABLE (
		CampaniaID INT
		,CUV VARCHAR(6)
		,Descripcion VARCHAR(250)
		,ConfiguracionOfertaID INT
		,TipoOfertaSisID INT
		,ImagenProducto VARCHAR(250)
		);

	INSERT INTO @OfertaProductoTemp
	SELECT op.CampaniaID
		,op.CUV
		,op.Descripcion
		,op.ConfiguracionOfertaID
		,op.TipoOfertaSisID
		,op.ImagenProducto
	FROM OfertaProducto op WITH (NOLOCK)
	INNER JOIN ods.Campania c ON op.CampaniaID = c.CampaniaID
	WHERE c.codigo = @CampaniaID
	
	UNION ALL
	
	SELECT c.CampaniaID
		,e.CUV2 as CUV
		,e.DescripcionCUV2 as Descripcion
		,ves.ConfiguracionOfertaID
		,ves.TipoOfertaSisID
		,e.ImagenURL as ImagenProducto
	FROM dbo.Estrategia e WITH (NOLOCK)
	INNER JOIN ods.Campania c ON e.CampaniaID = c.Codigo
	INNER JOIN vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE c.codigo = @CampaniaID;
	--FIN: Lista de Ofertas

	--INI: Lista de Productos Faltantes
	DECLARE @ProductoFaltanteTemp TABLE (CUV VARCHAR(6))

	INSERT INTO @ProductoFaltanteTemp
	SELECT DISTINCT ltrim(rtrim(CUV))
	FROM dbo.ProductoFaltante WITH (NOLOCK)
	WHERE CampaniaID = @CampaniaID
		AND Zonaid = @ZonaID
	
	UNION ALL
	
	SELECT DISTINCT ltrim(rtrim(fa.CodigoVenta)) AS CUV
	FROM ods.FaltanteAnunciado fa WITH (NOLOCK)
	INNER JOIN ods.Campania c WITH (NOLOCK) ON fa.CampaniaID = c.CampaniaID
	WHERE c.Codigo = @CampaniaID
		AND (
			fa.CodigoRegion IS NULL
			OR rtrim(fa.CodigoRegion) = @CodigoRegion
			)
		AND (
			fa.CodigoZona IS NULL
			OR rtrim(fa.CodigoZona) = @CodigoZona
			)

	--FIN: Lista de Productos Faltantes
	SELECT DISTINCT TOP (@RowCount) p.CUV
		,p.CodigoProducto AS CodigoSAP
		,coalesce(est.descripcioncuv2, op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion) AS Descripcion
		,coalesce(est.precio2, pd.PrecioProducto * pd.FactorRepeticion, p.PrecioUnitario * p.FactorRepeticion) AS PrecioCatalogo
		,iif(isnull(pf.CUV, 0) = 0, 1, 0) AS TieneStock
		,isnull(pcc.EsExpoOferta, 0) AS EsExpoOferta
		,isnull(pcc.CUVRevista, '') AS CUVRevista
		,p.IndicadorMontoMinimo
		,M.Descripcion AS DescripcionMarca
		,TE.DescripcionEstrategia AS DescripcionEstrategia
		,isnull(op.ConfiguracionOfertaID, 0) ConfiguracionOfertaID
		,isnull(op.TipoOfertaSisID, 0) TipoOfertaSisID
		,isnull(te.flagNueva, 0) FlagNueva
		,isnull(te.TipoEstrategiaID, '') TipoEstrategiaID
		,iif(PS.ProductoSugeridoID IS NULL, 0, 1) AS TieneSugerido
		,isnull(Cat.Descripcion, '') AS CatalogoDescripcion
		,coalesce(op.ImagenProducto, est.ImagenURL, PS2.ImagenProducto) AS ImagenOferta
		,coalesce(mc.FotoProducto01, mc.FotoProducto02, mc.FotoProducto03, mc.FotoProducto04, mc.FotoProducto05, mc.FotoProducto06, mc.FotoProducto07, mc.FotoProducto08, mc.FotoProducto09, mc.FotoProducto10) AS ImagenProducto
		,coalesce(est.descripcioncuv2, op.Descripcion) AS DescripcionOferta
		,coalesce(mc.Descripcion, pd.Descripcion, p.Descripcion) AS DescripcionProducto
	FROM ods.ProductoComercial p
	LEFT JOIN Marca M ON p.MarcaId = M.MarcaId
	LEFT JOIN dbo.ProductoDescripcion pd ON p.AnoCampania = pd.CampaniaID
		AND p.CUV = pd.CUV
	LEFT JOIN @ProductoFaltanteTemp pf ON p.CUV = pf.CUV
	LEFT JOIN ProductoComercialConfiguracion pcc ON p.AnoCampania = pcc.CampaniaID
		AND p.CUV = pcc.CUV
	LEFT JOIN @OfertaProductoTemp op ON op.CampaniaID = P.CampaniaID
		AND op.CUV = P.CUV
	LEFT JOIN MatrizComercial mc ON p.CodigoProducto = mc.CodigoSAP
	LEFT JOIN Estrategia EST ON (
			p.AnoCampania BETWEEN EST.CampaniaID
				AND isnull(EST.CampaniaIDFin, EST.CampaniaID)
			)
		AND EST.CUV2 = p.CUV
		AND EST.Activo = 1
	LEFT JOIN TipoEstrategia TE ON TE.TipoEstrategiaID = EST.TipoEstrategiaID
	LEFT JOIN ProductoSugerido PS ON PS.CampaniaID = p.AnoCampania
		AND PS.CUV = P.CUV
		AND PS.Estado = 1
	LEFT JOIN ProductoSugerido PS2 ON PS2.CampaniaID = p.AnoCampania
		AND PS2.CUVSugerido = P.CUV
		AND PS.Estado = 1
	LEFT JOIN ods.Catalogo Cat WITH (NOLOCK) ON p.CodigoCatalago = Cat.CodigoCatalogo
	WHERE p.AnoCampania = @CampaniaID
		AND p.IndicadorDigitable = 1
		AND CHARINDEX(@TextoBusqueda, iif(@Criterio = 1, p.CUV, coalesce(est.descripcioncuv2, op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion))) > 0;
END

GO

USE BelcorpVenezuela
GO

IF (OBJECT_ID('[dbo].[GetProductoComercialByCampaniaZona]', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE [dbo].[GetProductoComercialByCampaniaZona] AS SET NOCOUNT ON;')
GO

ALTER PROCEDURE GetProductoComercialByCampaniaZona @CampaniaID INT
	,@RegionID INT
	,@ZonaID INT
	,@CodigoRegion VARCHAR(10)
	,@CodigoZona VARCHAR(10)
	,@RowCount INT
	,@Criterio INT
	,@TextoBusqueda VARCHAR(100)
AS
BEGIN
	--INI: Lista de Ofertas
	DECLARE @OfertaProductoTemp TABLE (
		CampaniaID INT
		,CUV VARCHAR(6)
		,Descripcion VARCHAR(250)
		,ConfiguracionOfertaID INT
		,TipoOfertaSisID INT
		,ImagenProducto VARCHAR(250)
		);

	INSERT INTO @OfertaProductoTemp
	SELECT op.CampaniaID
		,op.CUV
		,op.Descripcion
		,op.ConfiguracionOfertaID
		,op.TipoOfertaSisID
		,op.ImagenProducto
	FROM OfertaProducto op WITH (NOLOCK)
	INNER JOIN ods.Campania c ON op.CampaniaID = c.CampaniaID
	WHERE c.codigo = @CampaniaID
	
	UNION ALL
	
	SELECT c.CampaniaID
		,e.CUV2 as CUV
		,e.DescripcionCUV2 as Descripcion
		,ves.ConfiguracionOfertaID
		,ves.TipoOfertaSisID
		,e.ImagenURL as ImagenProducto
	FROM dbo.Estrategia e WITH (NOLOCK)
	INNER JOIN ods.Campania c ON e.CampaniaID = c.Codigo
	INNER JOIN vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE c.codigo = @CampaniaID;
	--FIN: Lista de Ofertas

	--INI: Lista de Productos Faltantes
	DECLARE @ProductoFaltanteTemp TABLE (CUV VARCHAR(6))

	INSERT INTO @ProductoFaltanteTemp
	SELECT DISTINCT ltrim(rtrim(CUV))
	FROM dbo.ProductoFaltante WITH (NOLOCK)
	WHERE CampaniaID = @CampaniaID
		AND Zonaid = @ZonaID
	
	UNION ALL
	
	SELECT DISTINCT ltrim(rtrim(fa.CodigoVenta)) AS CUV
	FROM ods.FaltanteAnunciado fa WITH (NOLOCK)
	INNER JOIN ods.Campania c WITH (NOLOCK) ON fa.CampaniaID = c.CampaniaID
	WHERE c.Codigo = @CampaniaID
		AND (
			fa.CodigoRegion IS NULL
			OR rtrim(fa.CodigoRegion) = @CodigoRegion
			)
		AND (
			fa.CodigoZona IS NULL
			OR rtrim(fa.CodigoZona) = @CodigoZona
			)

	--FIN: Lista de Productos Faltantes
	SELECT DISTINCT TOP (@RowCount) p.CUV
		,p.CodigoProducto AS CodigoSAP
		,coalesce(est.descripcioncuv2, op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion) AS Descripcion
		,coalesce(est.precio2, pd.PrecioProducto * pd.FactorRepeticion, p.PrecioUnitario * p.FactorRepeticion) AS PrecioCatalogo
		,iif(isnull(pf.CUV, 0) = 0, 1, 0) AS TieneStock
		,isnull(pcc.EsExpoOferta, 0) AS EsExpoOferta
		,isnull(pcc.CUVRevista, '') AS CUVRevista
		,p.IndicadorMontoMinimo
		,M.Descripcion AS DescripcionMarca
		,TE.DescripcionEstrategia AS DescripcionEstrategia
		,isnull(op.ConfiguracionOfertaID, 0) ConfiguracionOfertaID
		,isnull(op.TipoOfertaSisID, 0) TipoOfertaSisID
		,isnull(te.flagNueva, 0) FlagNueva
		,isnull(te.TipoEstrategiaID, '') TipoEstrategiaID
		,iif(PS.ProductoSugeridoID IS NULL, 0, 1) AS TieneSugerido
		,isnull(Cat.Descripcion, '') AS CatalogoDescripcion
		,coalesce(op.ImagenProducto, est.ImagenURL, PS2.ImagenProducto) AS ImagenOferta
		,coalesce(mc.FotoProducto01, mc.FotoProducto02, mc.FotoProducto03, mc.FotoProducto04, mc.FotoProducto05, mc.FotoProducto06, mc.FotoProducto07, mc.FotoProducto08, mc.FotoProducto09, mc.FotoProducto10) AS ImagenProducto
		,coalesce(est.descripcioncuv2, op.Descripcion) AS DescripcionOferta
		,coalesce(mc.Descripcion, pd.Descripcion, p.Descripcion) AS DescripcionProducto
	FROM ods.ProductoComercial p
	LEFT JOIN Marca M ON p.MarcaId = M.MarcaId
	LEFT JOIN dbo.ProductoDescripcion pd ON p.AnoCampania = pd.CampaniaID
		AND p.CUV = pd.CUV
	LEFT JOIN @ProductoFaltanteTemp pf ON p.CUV = pf.CUV
	LEFT JOIN ProductoComercialConfiguracion pcc ON p.AnoCampania = pcc.CampaniaID
		AND p.CUV = pcc.CUV
	LEFT JOIN @OfertaProductoTemp op ON op.CampaniaID = P.CampaniaID
		AND op.CUV = P.CUV
	LEFT JOIN MatrizComercial mc ON p.CodigoProducto = mc.CodigoSAP
	LEFT JOIN Estrategia EST ON (
			p.AnoCampania BETWEEN EST.CampaniaID
				AND isnull(EST.CampaniaIDFin, EST.CampaniaID)
			)
		AND EST.CUV2 = p.CUV
		AND EST.Activo = 1
	LEFT JOIN TipoEstrategia TE ON TE.TipoEstrategiaID = EST.TipoEstrategiaID
	LEFT JOIN ProductoSugerido PS ON PS.CampaniaID = p.AnoCampania
		AND PS.CUV = P.CUV
		AND PS.Estado = 1
	LEFT JOIN ProductoSugerido PS2 ON PS2.CampaniaID = p.AnoCampania
		AND PS2.CUVSugerido = P.CUV
		AND PS.Estado = 1
	LEFT JOIN ods.Catalogo Cat WITH (NOLOCK) ON p.CodigoCatalago = Cat.CodigoCatalogo
	WHERE p.AnoCampania = @CampaniaID
		AND p.IndicadorDigitable = 1
		AND CHARINDEX(@TextoBusqueda, iif(@Criterio = 1, p.CUV, coalesce(est.descripcioncuv2, op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion))) > 0;
END

GO

USE BelcorpSalvador
GO

IF (OBJECT_ID('[dbo].[GetProductoComercialByCampaniaZona]', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE [dbo].[GetProductoComercialByCampaniaZona] AS SET NOCOUNT ON;')
GO

ALTER PROCEDURE GetProductoComercialByCampaniaZona @CampaniaID INT
	,@RegionID INT
	,@ZonaID INT
	,@CodigoRegion VARCHAR(10)
	,@CodigoZona VARCHAR(10)
	,@RowCount INT
	,@Criterio INT
	,@TextoBusqueda VARCHAR(100)
AS
BEGIN
	--INI: Lista de Ofertas
	DECLARE @OfertaProductoTemp TABLE (
		CampaniaID INT
		,CUV VARCHAR(6)
		,Descripcion VARCHAR(250)
		,ConfiguracionOfertaID INT
		,TipoOfertaSisID INT
		,ImagenProducto VARCHAR(250)
		);

	INSERT INTO @OfertaProductoTemp
	SELECT op.CampaniaID
		,op.CUV
		,op.Descripcion
		,op.ConfiguracionOfertaID
		,op.TipoOfertaSisID
		,op.ImagenProducto
	FROM OfertaProducto op WITH (NOLOCK)
	INNER JOIN ods.Campania c ON op.CampaniaID = c.CampaniaID
	WHERE c.codigo = @CampaniaID
	
	UNION ALL
	
	SELECT c.CampaniaID
		,e.CUV2 as CUV
		,e.DescripcionCUV2 as Descripcion
		,ves.ConfiguracionOfertaID
		,ves.TipoOfertaSisID
		,e.ImagenURL as ImagenProducto
	FROM dbo.Estrategia e WITH (NOLOCK)
	INNER JOIN ods.Campania c ON e.CampaniaID = c.Codigo
	INNER JOIN vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE c.codigo = @CampaniaID;
	--FIN: Lista de Ofertas

	--INI: Lista de Productos Faltantes
	DECLARE @ProductoFaltanteTemp TABLE (CUV VARCHAR(6))

	INSERT INTO @ProductoFaltanteTemp
	SELECT DISTINCT ltrim(rtrim(CUV))
	FROM dbo.ProductoFaltante WITH (NOLOCK)
	WHERE CampaniaID = @CampaniaID
		AND Zonaid = @ZonaID
	
	UNION ALL
	
	SELECT DISTINCT ltrim(rtrim(fa.CodigoVenta)) AS CUV
	FROM ods.FaltanteAnunciado fa WITH (NOLOCK)
	INNER JOIN ods.Campania c WITH (NOLOCK) ON fa.CampaniaID = c.CampaniaID
	WHERE c.Codigo = @CampaniaID
		AND (
			fa.CodigoRegion IS NULL
			OR rtrim(fa.CodigoRegion) = @CodigoRegion
			)
		AND (
			fa.CodigoZona IS NULL
			OR rtrim(fa.CodigoZona) = @CodigoZona
			)

	--FIN: Lista de Productos Faltantes
	SELECT DISTINCT TOP (@RowCount) p.CUV
		,p.CodigoProducto AS CodigoSAP
		,coalesce(est.descripcioncuv2, op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion) AS Descripcion
		,coalesce(est.precio2, pd.PrecioProducto * pd.FactorRepeticion, p.PrecioUnitario * p.FactorRepeticion) AS PrecioCatalogo
		,iif(isnull(pf.CUV, 0) = 0, 1, 0) AS TieneStock
		,isnull(pcc.EsExpoOferta, 0) AS EsExpoOferta
		,isnull(pcc.CUVRevista, '') AS CUVRevista
		,p.IndicadorMontoMinimo
		,M.Descripcion AS DescripcionMarca
		,TE.DescripcionEstrategia AS DescripcionEstrategia
		,isnull(op.ConfiguracionOfertaID, 0) ConfiguracionOfertaID
		,isnull(op.TipoOfertaSisID, 0) TipoOfertaSisID
		,isnull(te.flagNueva, 0) FlagNueva
		,isnull(te.TipoEstrategiaID, '') TipoEstrategiaID
		,iif(PS.ProductoSugeridoID IS NULL, 0, 1) AS TieneSugerido
		,isnull(Cat.Descripcion, '') AS CatalogoDescripcion
		,coalesce(op.ImagenProducto, est.ImagenURL, PS2.ImagenProducto) AS ImagenOferta
		,coalesce(mc.FotoProducto01, mc.FotoProducto02, mc.FotoProducto03, mc.FotoProducto04, mc.FotoProducto05, mc.FotoProducto06, mc.FotoProducto07, mc.FotoProducto08, mc.FotoProducto09, mc.FotoProducto10) AS ImagenProducto
		,coalesce(est.descripcioncuv2, op.Descripcion) AS DescripcionOferta
		,coalesce(mc.Descripcion, pd.Descripcion, p.Descripcion) AS DescripcionProducto
	FROM ods.ProductoComercial p
	LEFT JOIN Marca M ON p.MarcaId = M.MarcaId
	LEFT JOIN dbo.ProductoDescripcion pd ON p.AnoCampania = pd.CampaniaID
		AND p.CUV = pd.CUV
	LEFT JOIN @ProductoFaltanteTemp pf ON p.CUV = pf.CUV
	LEFT JOIN ProductoComercialConfiguracion pcc ON p.AnoCampania = pcc.CampaniaID
		AND p.CUV = pcc.CUV
	LEFT JOIN @OfertaProductoTemp op ON op.CampaniaID = P.CampaniaID
		AND op.CUV = P.CUV
	LEFT JOIN MatrizComercial mc ON p.CodigoProducto = mc.CodigoSAP
	LEFT JOIN Estrategia EST ON (
			p.AnoCampania BETWEEN EST.CampaniaID
				AND isnull(EST.CampaniaIDFin, EST.CampaniaID)
			)
		AND EST.CUV2 = p.CUV
		AND EST.Activo = 1
	LEFT JOIN TipoEstrategia TE ON TE.TipoEstrategiaID = EST.TipoEstrategiaID
	LEFT JOIN ProductoSugerido PS ON PS.CampaniaID = p.AnoCampania
		AND PS.CUV = P.CUV
		AND PS.Estado = 1
	LEFT JOIN ProductoSugerido PS2 ON PS2.CampaniaID = p.AnoCampania
		AND PS2.CUVSugerido = P.CUV
		AND PS.Estado = 1
	LEFT JOIN ods.Catalogo Cat WITH (NOLOCK) ON p.CodigoCatalago = Cat.CodigoCatalogo
	WHERE p.AnoCampania = @CampaniaID
		AND p.IndicadorDigitable = 1
		AND CHARINDEX(@TextoBusqueda, iif(@Criterio = 1, p.CUV, coalesce(est.descripcioncuv2, op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion))) > 0;
END

GO

USE BelcorpPuertoRico
GO

IF (OBJECT_ID('[dbo].[GetProductoComercialByCampaniaZona]', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE [dbo].[GetProductoComercialByCampaniaZona] AS SET NOCOUNT ON;')
GO

ALTER PROCEDURE GetProductoComercialByCampaniaZona @CampaniaID INT
	,@RegionID INT
	,@ZonaID INT
	,@CodigoRegion VARCHAR(10)
	,@CodigoZona VARCHAR(10)
	,@RowCount INT
	,@Criterio INT
	,@TextoBusqueda VARCHAR(100)
AS
BEGIN
	--INI: Lista de Ofertas
	DECLARE @OfertaProductoTemp TABLE (
		CampaniaID INT
		,CUV VARCHAR(6)
		,Descripcion VARCHAR(250)
		,ConfiguracionOfertaID INT
		,TipoOfertaSisID INT
		,ImagenProducto VARCHAR(250)
		);

	INSERT INTO @OfertaProductoTemp
	SELECT op.CampaniaID
		,op.CUV
		,op.Descripcion
		,op.ConfiguracionOfertaID
		,op.TipoOfertaSisID
		,op.ImagenProducto
	FROM OfertaProducto op WITH (NOLOCK)
	INNER JOIN ods.Campania c ON op.CampaniaID = c.CampaniaID
	WHERE c.codigo = @CampaniaID
	
	UNION ALL
	
	SELECT c.CampaniaID
		,e.CUV2 as CUV
		,e.DescripcionCUV2 as Descripcion
		,ves.ConfiguracionOfertaID
		,ves.TipoOfertaSisID
		,e.ImagenURL as ImagenProducto
	FROM dbo.Estrategia e WITH (NOLOCK)
	INNER JOIN ods.Campania c ON e.CampaniaID = c.Codigo
	INNER JOIN vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE c.codigo = @CampaniaID;
	--FIN: Lista de Ofertas

	--INI: Lista de Productos Faltantes
	DECLARE @ProductoFaltanteTemp TABLE (CUV VARCHAR(6))

	INSERT INTO @ProductoFaltanteTemp
	SELECT DISTINCT ltrim(rtrim(CUV))
	FROM dbo.ProductoFaltante WITH (NOLOCK)
	WHERE CampaniaID = @CampaniaID
		AND Zonaid = @ZonaID
	
	UNION ALL
	
	SELECT DISTINCT ltrim(rtrim(fa.CodigoVenta)) AS CUV
	FROM ods.FaltanteAnunciado fa WITH (NOLOCK)
	INNER JOIN ods.Campania c WITH (NOLOCK) ON fa.CampaniaID = c.CampaniaID
	WHERE c.Codigo = @CampaniaID
		AND (
			fa.CodigoRegion IS NULL
			OR rtrim(fa.CodigoRegion) = @CodigoRegion
			)
		AND (
			fa.CodigoZona IS NULL
			OR rtrim(fa.CodigoZona) = @CodigoZona
			)

	--FIN: Lista de Productos Faltantes
	SELECT DISTINCT TOP (@RowCount) p.CUV
		,p.CodigoProducto AS CodigoSAP
		,coalesce(est.descripcioncuv2, op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion) AS Descripcion
		,coalesce(est.precio2, pd.PrecioProducto * pd.FactorRepeticion, p.PrecioUnitario * p.FactorRepeticion) AS PrecioCatalogo
		,iif(isnull(pf.CUV, 0) = 0, 1, 0) AS TieneStock
		,isnull(pcc.EsExpoOferta, 0) AS EsExpoOferta
		,isnull(pcc.CUVRevista, '') AS CUVRevista
		,p.IndicadorMontoMinimo
		,M.Descripcion AS DescripcionMarca
		,TE.DescripcionEstrategia AS DescripcionEstrategia
		,isnull(op.ConfiguracionOfertaID, 0) ConfiguracionOfertaID
		,isnull(op.TipoOfertaSisID, 0) TipoOfertaSisID
		,isnull(te.flagNueva, 0) FlagNueva
		,isnull(te.TipoEstrategiaID, '') TipoEstrategiaID
		,iif(PS.ProductoSugeridoID IS NULL, 0, 1) AS TieneSugerido
		,isnull(Cat.Descripcion, '') AS CatalogoDescripcion
		,coalesce(op.ImagenProducto, est.ImagenURL, PS2.ImagenProducto) AS ImagenOferta
		,coalesce(mc.FotoProducto01, mc.FotoProducto02, mc.FotoProducto03, mc.FotoProducto04, mc.FotoProducto05, mc.FotoProducto06, mc.FotoProducto07, mc.FotoProducto08, mc.FotoProducto09, mc.FotoProducto10) AS ImagenProducto
		,coalesce(est.descripcioncuv2, op.Descripcion) AS DescripcionOferta
		,coalesce(mc.Descripcion, pd.Descripcion, p.Descripcion) AS DescripcionProducto
	FROM ods.ProductoComercial p
	LEFT JOIN Marca M ON p.MarcaId = M.MarcaId
	LEFT JOIN dbo.ProductoDescripcion pd ON p.AnoCampania = pd.CampaniaID
		AND p.CUV = pd.CUV
	LEFT JOIN @ProductoFaltanteTemp pf ON p.CUV = pf.CUV
	LEFT JOIN ProductoComercialConfiguracion pcc ON p.AnoCampania = pcc.CampaniaID
		AND p.CUV = pcc.CUV
	LEFT JOIN @OfertaProductoTemp op ON op.CampaniaID = P.CampaniaID
		AND op.CUV = P.CUV
	LEFT JOIN MatrizComercial mc ON p.CodigoProducto = mc.CodigoSAP
	LEFT JOIN Estrategia EST ON (
			p.AnoCampania BETWEEN EST.CampaniaID
				AND isnull(EST.CampaniaIDFin, EST.CampaniaID)
			)
		AND EST.CUV2 = p.CUV
		AND EST.Activo = 1
	LEFT JOIN TipoEstrategia TE ON TE.TipoEstrategiaID = EST.TipoEstrategiaID
	LEFT JOIN ProductoSugerido PS ON PS.CampaniaID = p.AnoCampania
		AND PS.CUV = P.CUV
		AND PS.Estado = 1
	LEFT JOIN ProductoSugerido PS2 ON PS2.CampaniaID = p.AnoCampania
		AND PS2.CUVSugerido = P.CUV
		AND PS.Estado = 1
	LEFT JOIN ods.Catalogo Cat WITH (NOLOCK) ON p.CodigoCatalago = Cat.CodigoCatalogo
	WHERE p.AnoCampania = @CampaniaID
		AND p.IndicadorDigitable = 1
		AND CHARINDEX(@TextoBusqueda, iif(@Criterio = 1, p.CUV, coalesce(est.descripcioncuv2, op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion))) > 0;
END

GO

USE BelcorpPanama
GO

IF (OBJECT_ID('[dbo].[GetProductoComercialByCampaniaZona]', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE [dbo].[GetProductoComercialByCampaniaZona] AS SET NOCOUNT ON;')
GO

ALTER PROCEDURE GetProductoComercialByCampaniaZona @CampaniaID INT
	,@RegionID INT
	,@ZonaID INT
	,@CodigoRegion VARCHAR(10)
	,@CodigoZona VARCHAR(10)
	,@RowCount INT
	,@Criterio INT
	,@TextoBusqueda VARCHAR(100)
AS
BEGIN
	--INI: Lista de Ofertas
	DECLARE @OfertaProductoTemp TABLE (
		CampaniaID INT
		,CUV VARCHAR(6)
		,Descripcion VARCHAR(250)
		,ConfiguracionOfertaID INT
		,TipoOfertaSisID INT
		,ImagenProducto VARCHAR(250)
		);

	INSERT INTO @OfertaProductoTemp
	SELECT op.CampaniaID
		,op.CUV
		,op.Descripcion
		,op.ConfiguracionOfertaID
		,op.TipoOfertaSisID
		,op.ImagenProducto
	FROM OfertaProducto op WITH (NOLOCK)
	INNER JOIN ods.Campania c ON op.CampaniaID = c.CampaniaID
	WHERE c.codigo = @CampaniaID
	
	UNION ALL
	
	SELECT c.CampaniaID
		,e.CUV2 as CUV
		,e.DescripcionCUV2 as Descripcion
		,ves.ConfiguracionOfertaID
		,ves.TipoOfertaSisID
		,e.ImagenURL as ImagenProducto
	FROM dbo.Estrategia e WITH (NOLOCK)
	INNER JOIN ods.Campania c ON e.CampaniaID = c.Codigo
	INNER JOIN vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE c.codigo = @CampaniaID;
	--FIN: Lista de Ofertas

	--INI: Lista de Productos Faltantes
	DECLARE @ProductoFaltanteTemp TABLE (CUV VARCHAR(6))

	INSERT INTO @ProductoFaltanteTemp
	SELECT DISTINCT ltrim(rtrim(CUV))
	FROM dbo.ProductoFaltante WITH (NOLOCK)
	WHERE CampaniaID = @CampaniaID
		AND Zonaid = @ZonaID
	
	UNION ALL
	
	SELECT DISTINCT ltrim(rtrim(fa.CodigoVenta)) AS CUV
	FROM ods.FaltanteAnunciado fa WITH (NOLOCK)
	INNER JOIN ods.Campania c WITH (NOLOCK) ON fa.CampaniaID = c.CampaniaID
	WHERE c.Codigo = @CampaniaID
		AND (
			fa.CodigoRegion IS NULL
			OR rtrim(fa.CodigoRegion) = @CodigoRegion
			)
		AND (
			fa.CodigoZona IS NULL
			OR rtrim(fa.CodigoZona) = @CodigoZona
			)

	--FIN: Lista de Productos Faltantes
	SELECT DISTINCT TOP (@RowCount) p.CUV
		,p.CodigoProducto AS CodigoSAP
		,coalesce(est.descripcioncuv2, op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion) AS Descripcion
		,coalesce(est.precio2, pd.PrecioProducto * pd.FactorRepeticion, p.PrecioUnitario * p.FactorRepeticion) AS PrecioCatalogo
		,iif(isnull(pf.CUV, 0) = 0, 1, 0) AS TieneStock
		,isnull(pcc.EsExpoOferta, 0) AS EsExpoOferta
		,isnull(pcc.CUVRevista, '') AS CUVRevista
		,p.IndicadorMontoMinimo
		,M.Descripcion AS DescripcionMarca
		,TE.DescripcionEstrategia AS DescripcionEstrategia
		,isnull(op.ConfiguracionOfertaID, 0) ConfiguracionOfertaID
		,isnull(op.TipoOfertaSisID, 0) TipoOfertaSisID
		,isnull(te.flagNueva, 0) FlagNueva
		,isnull(te.TipoEstrategiaID, '') TipoEstrategiaID
		,iif(PS.ProductoSugeridoID IS NULL, 0, 1) AS TieneSugerido
		,isnull(Cat.Descripcion, '') AS CatalogoDescripcion
		,coalesce(op.ImagenProducto, est.ImagenURL, PS2.ImagenProducto) AS ImagenOferta
		,coalesce(mc.FotoProducto01, mc.FotoProducto02, mc.FotoProducto03, mc.FotoProducto04, mc.FotoProducto05, mc.FotoProducto06, mc.FotoProducto07, mc.FotoProducto08, mc.FotoProducto09, mc.FotoProducto10) AS ImagenProducto
		,coalesce(est.descripcioncuv2, op.Descripcion) AS DescripcionOferta
		,coalesce(mc.Descripcion, pd.Descripcion, p.Descripcion) AS DescripcionProducto
	FROM ods.ProductoComercial p
	LEFT JOIN Marca M ON p.MarcaId = M.MarcaId
	LEFT JOIN dbo.ProductoDescripcion pd ON p.AnoCampania = pd.CampaniaID
		AND p.CUV = pd.CUV
	LEFT JOIN @ProductoFaltanteTemp pf ON p.CUV = pf.CUV
	LEFT JOIN ProductoComercialConfiguracion pcc ON p.AnoCampania = pcc.CampaniaID
		AND p.CUV = pcc.CUV
	LEFT JOIN @OfertaProductoTemp op ON op.CampaniaID = P.CampaniaID
		AND op.CUV = P.CUV
	LEFT JOIN MatrizComercial mc ON p.CodigoProducto = mc.CodigoSAP
	LEFT JOIN Estrategia EST ON (
			p.AnoCampania BETWEEN EST.CampaniaID
				AND isnull(EST.CampaniaIDFin, EST.CampaniaID)
			)
		AND EST.CUV2 = p.CUV
		AND EST.Activo = 1
	LEFT JOIN TipoEstrategia TE ON TE.TipoEstrategiaID = EST.TipoEstrategiaID
	LEFT JOIN ProductoSugerido PS ON PS.CampaniaID = p.AnoCampania
		AND PS.CUV = P.CUV
		AND PS.Estado = 1
	LEFT JOIN ProductoSugerido PS2 ON PS2.CampaniaID = p.AnoCampania
		AND PS2.CUVSugerido = P.CUV
		AND PS.Estado = 1
	LEFT JOIN ods.Catalogo Cat WITH (NOLOCK) ON p.CodigoCatalago = Cat.CodigoCatalogo
	WHERE p.AnoCampania = @CampaniaID
		AND p.IndicadorDigitable = 1
		AND CHARINDEX(@TextoBusqueda, iif(@Criterio = 1, p.CUV, coalesce(est.descripcioncuv2, op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion))) > 0;
END

GO

USE BelcorpGuatemala
GO

IF (OBJECT_ID('[dbo].[GetProductoComercialByCampaniaZona]', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE [dbo].[GetProductoComercialByCampaniaZona] AS SET NOCOUNT ON;')
GO

ALTER PROCEDURE GetProductoComercialByCampaniaZona @CampaniaID INT
	,@RegionID INT
	,@ZonaID INT
	,@CodigoRegion VARCHAR(10)
	,@CodigoZona VARCHAR(10)
	,@RowCount INT
	,@Criterio INT
	,@TextoBusqueda VARCHAR(100)
AS
BEGIN
	--INI: Lista de Ofertas
	DECLARE @OfertaProductoTemp TABLE (
		CampaniaID INT
		,CUV VARCHAR(6)
		,Descripcion VARCHAR(250)
		,ConfiguracionOfertaID INT
		,TipoOfertaSisID INT
		,ImagenProducto VARCHAR(250)
		);

	INSERT INTO @OfertaProductoTemp
	SELECT op.CampaniaID
		,op.CUV
		,op.Descripcion
		,op.ConfiguracionOfertaID
		,op.TipoOfertaSisID
		,op.ImagenProducto
	FROM OfertaProducto op WITH (NOLOCK)
	INNER JOIN ods.Campania c ON op.CampaniaID = c.CampaniaID
	WHERE c.codigo = @CampaniaID
	
	UNION ALL
	
	SELECT c.CampaniaID
		,e.CUV2 as CUV
		,e.DescripcionCUV2 as Descripcion
		,ves.ConfiguracionOfertaID
		,ves.TipoOfertaSisID
		,e.ImagenURL as ImagenProducto
	FROM dbo.Estrategia e WITH (NOLOCK)
	INNER JOIN ods.Campania c ON e.CampaniaID = c.Codigo
	INNER JOIN vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE c.codigo = @CampaniaID;
	--FIN: Lista de Ofertas

	--INI: Lista de Productos Faltantes
	DECLARE @ProductoFaltanteTemp TABLE (CUV VARCHAR(6))

	INSERT INTO @ProductoFaltanteTemp
	SELECT DISTINCT ltrim(rtrim(CUV))
	FROM dbo.ProductoFaltante WITH (NOLOCK)
	WHERE CampaniaID = @CampaniaID
		AND Zonaid = @ZonaID
	
	UNION ALL
	
	SELECT DISTINCT ltrim(rtrim(fa.CodigoVenta)) AS CUV
	FROM ods.FaltanteAnunciado fa WITH (NOLOCK)
	INNER JOIN ods.Campania c WITH (NOLOCK) ON fa.CampaniaID = c.CampaniaID
	WHERE c.Codigo = @CampaniaID
		AND (
			fa.CodigoRegion IS NULL
			OR rtrim(fa.CodigoRegion) = @CodigoRegion
			)
		AND (
			fa.CodigoZona IS NULL
			OR rtrim(fa.CodigoZona) = @CodigoZona
			)

	--FIN: Lista de Productos Faltantes
	SELECT DISTINCT TOP (@RowCount) p.CUV
		,p.CodigoProducto AS CodigoSAP
		,coalesce(est.descripcioncuv2, op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion) AS Descripcion
		,coalesce(est.precio2, pd.PrecioProducto * pd.FactorRepeticion, p.PrecioUnitario * p.FactorRepeticion) AS PrecioCatalogo
		,iif(isnull(pf.CUV, 0) = 0, 1, 0) AS TieneStock
		,isnull(pcc.EsExpoOferta, 0) AS EsExpoOferta
		,isnull(pcc.CUVRevista, '') AS CUVRevista
		,p.IndicadorMontoMinimo
		,M.Descripcion AS DescripcionMarca
		,TE.DescripcionEstrategia AS DescripcionEstrategia
		,isnull(op.ConfiguracionOfertaID, 0) ConfiguracionOfertaID
		,isnull(op.TipoOfertaSisID, 0) TipoOfertaSisID
		,isnull(te.flagNueva, 0) FlagNueva
		,isnull(te.TipoEstrategiaID, '') TipoEstrategiaID
		,iif(PS.ProductoSugeridoID IS NULL, 0, 1) AS TieneSugerido
		,isnull(Cat.Descripcion, '') AS CatalogoDescripcion
		,coalesce(op.ImagenProducto, est.ImagenURL, PS2.ImagenProducto) AS ImagenOferta
		,coalesce(mc.FotoProducto01, mc.FotoProducto02, mc.FotoProducto03, mc.FotoProducto04, mc.FotoProducto05, mc.FotoProducto06, mc.FotoProducto07, mc.FotoProducto08, mc.FotoProducto09, mc.FotoProducto10) AS ImagenProducto
		,coalesce(est.descripcioncuv2, op.Descripcion) AS DescripcionOferta
		,coalesce(mc.Descripcion, pd.Descripcion, p.Descripcion) AS DescripcionProducto
	FROM ods.ProductoComercial p
	LEFT JOIN Marca M ON p.MarcaId = M.MarcaId
	LEFT JOIN dbo.ProductoDescripcion pd ON p.AnoCampania = pd.CampaniaID
		AND p.CUV = pd.CUV
	LEFT JOIN @ProductoFaltanteTemp pf ON p.CUV = pf.CUV
	LEFT JOIN ProductoComercialConfiguracion pcc ON p.AnoCampania = pcc.CampaniaID
		AND p.CUV = pcc.CUV
	LEFT JOIN @OfertaProductoTemp op ON op.CampaniaID = P.CampaniaID
		AND op.CUV = P.CUV
	LEFT JOIN MatrizComercial mc ON p.CodigoProducto = mc.CodigoSAP
	LEFT JOIN Estrategia EST ON (
			p.AnoCampania BETWEEN EST.CampaniaID
				AND isnull(EST.CampaniaIDFin, EST.CampaniaID)
			)
		AND EST.CUV2 = p.CUV
		AND EST.Activo = 1
	LEFT JOIN TipoEstrategia TE ON TE.TipoEstrategiaID = EST.TipoEstrategiaID
	LEFT JOIN ProductoSugerido PS ON PS.CampaniaID = p.AnoCampania
		AND PS.CUV = P.CUV
		AND PS.Estado = 1
	LEFT JOIN ProductoSugerido PS2 ON PS2.CampaniaID = p.AnoCampania
		AND PS2.CUVSugerido = P.CUV
		AND PS.Estado = 1
	LEFT JOIN ods.Catalogo Cat WITH (NOLOCK) ON p.CodigoCatalago = Cat.CodigoCatalogo
	WHERE p.AnoCampania = @CampaniaID
		AND p.IndicadorDigitable = 1
		AND CHARINDEX(@TextoBusqueda, iif(@Criterio = 1, p.CUV, coalesce(est.descripcioncuv2, op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion))) > 0;
END

GO

USE BelcorpEcuador
GO

IF (OBJECT_ID('[dbo].[GetProductoComercialByCampaniaZona]', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE [dbo].[GetProductoComercialByCampaniaZona] AS SET NOCOUNT ON;')
GO

ALTER PROCEDURE GetProductoComercialByCampaniaZona @CampaniaID INT
	,@RegionID INT
	,@ZonaID INT
	,@CodigoRegion VARCHAR(10)
	,@CodigoZona VARCHAR(10)
	,@RowCount INT
	,@Criterio INT
	,@TextoBusqueda VARCHAR(100)
AS
BEGIN
	--INI: Lista de Ofertas
	DECLARE @OfertaProductoTemp TABLE (
		CampaniaID INT
		,CUV VARCHAR(6)
		,Descripcion VARCHAR(250)
		,ConfiguracionOfertaID INT
		,TipoOfertaSisID INT
		,ImagenProducto VARCHAR(250)
		);

	INSERT INTO @OfertaProductoTemp
	SELECT op.CampaniaID
		,op.CUV
		,op.Descripcion
		,op.ConfiguracionOfertaID
		,op.TipoOfertaSisID
		,op.ImagenProducto
	FROM OfertaProducto op WITH (NOLOCK)
	INNER JOIN ods.Campania c ON op.CampaniaID = c.CampaniaID
	WHERE c.codigo = @CampaniaID
	
	UNION ALL
	
	SELECT c.CampaniaID
		,e.CUV2 as CUV
		,e.DescripcionCUV2 as Descripcion
		,ves.ConfiguracionOfertaID
		,ves.TipoOfertaSisID
		,e.ImagenURL as ImagenProducto
	FROM dbo.Estrategia e WITH (NOLOCK)
	INNER JOIN ods.Campania c ON e.CampaniaID = c.Codigo
	INNER JOIN vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE c.codigo = @CampaniaID;
	--FIN: Lista de Ofertas

	--INI: Lista de Productos Faltantes
	DECLARE @ProductoFaltanteTemp TABLE (CUV VARCHAR(6))

	INSERT INTO @ProductoFaltanteTemp
	SELECT DISTINCT ltrim(rtrim(CUV))
	FROM dbo.ProductoFaltante WITH (NOLOCK)
	WHERE CampaniaID = @CampaniaID
		AND Zonaid = @ZonaID
	
	UNION ALL
	
	SELECT DISTINCT ltrim(rtrim(fa.CodigoVenta)) AS CUV
	FROM ods.FaltanteAnunciado fa WITH (NOLOCK)
	INNER JOIN ods.Campania c WITH (NOLOCK) ON fa.CampaniaID = c.CampaniaID
	WHERE c.Codigo = @CampaniaID
		AND (
			fa.CodigoRegion IS NULL
			OR rtrim(fa.CodigoRegion) = @CodigoRegion
			)
		AND (
			fa.CodigoZona IS NULL
			OR rtrim(fa.CodigoZona) = @CodigoZona
			)

	--FIN: Lista de Productos Faltantes
	SELECT DISTINCT TOP (@RowCount) p.CUV
		,p.CodigoProducto AS CodigoSAP
		,coalesce(est.descripcioncuv2, op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion) AS Descripcion
		,coalesce(est.precio2, pd.PrecioProducto * pd.FactorRepeticion, p.PrecioUnitario * p.FactorRepeticion) AS PrecioCatalogo
		,iif(isnull(pf.CUV, 0) = 0, 1, 0) AS TieneStock
		,isnull(pcc.EsExpoOferta, 0) AS EsExpoOferta
		,isnull(pcc.CUVRevista, '') AS CUVRevista
		,p.IndicadorMontoMinimo
		,M.Descripcion AS DescripcionMarca
		,TE.DescripcionEstrategia AS DescripcionEstrategia
		,isnull(op.ConfiguracionOfertaID, 0) ConfiguracionOfertaID
		,isnull(op.TipoOfertaSisID, 0) TipoOfertaSisID
		,isnull(te.flagNueva, 0) FlagNueva
		,isnull(te.TipoEstrategiaID, '') TipoEstrategiaID
		,iif(PS.ProductoSugeridoID IS NULL, 0, 1) AS TieneSugerido
		,isnull(Cat.Descripcion, '') AS CatalogoDescripcion
		,coalesce(op.ImagenProducto, est.ImagenURL, PS2.ImagenProducto) AS ImagenOferta
		,coalesce(mc.FotoProducto01, mc.FotoProducto02, mc.FotoProducto03, mc.FotoProducto04, mc.FotoProducto05, mc.FotoProducto06, mc.FotoProducto07, mc.FotoProducto08, mc.FotoProducto09, mc.FotoProducto10) AS ImagenProducto
		,coalesce(est.descripcioncuv2, op.Descripcion) AS DescripcionOferta
		,coalesce(mc.Descripcion, pd.Descripcion, p.Descripcion) AS DescripcionProducto
	FROM ods.ProductoComercial p
	LEFT JOIN Marca M ON p.MarcaId = M.MarcaId
	LEFT JOIN dbo.ProductoDescripcion pd ON p.AnoCampania = pd.CampaniaID
		AND p.CUV = pd.CUV
	LEFT JOIN @ProductoFaltanteTemp pf ON p.CUV = pf.CUV
	LEFT JOIN ProductoComercialConfiguracion pcc ON p.AnoCampania = pcc.CampaniaID
		AND p.CUV = pcc.CUV
	LEFT JOIN @OfertaProductoTemp op ON op.CampaniaID = P.CampaniaID
		AND op.CUV = P.CUV
	LEFT JOIN MatrizComercial mc ON p.CodigoProducto = mc.CodigoSAP
	LEFT JOIN Estrategia EST ON (
			p.AnoCampania BETWEEN EST.CampaniaID
				AND isnull(EST.CampaniaIDFin, EST.CampaniaID)
			)
		AND EST.CUV2 = p.CUV
		AND EST.Activo = 1
	LEFT JOIN TipoEstrategia TE ON TE.TipoEstrategiaID = EST.TipoEstrategiaID
	LEFT JOIN ProductoSugerido PS ON PS.CampaniaID = p.AnoCampania
		AND PS.CUV = P.CUV
		AND PS.Estado = 1
	LEFT JOIN ProductoSugerido PS2 ON PS2.CampaniaID = p.AnoCampania
		AND PS2.CUVSugerido = P.CUV
		AND PS.Estado = 1
	LEFT JOIN ods.Catalogo Cat WITH (NOLOCK) ON p.CodigoCatalago = Cat.CodigoCatalogo
	WHERE p.AnoCampania = @CampaniaID
		AND p.IndicadorDigitable = 1
		AND CHARINDEX(@TextoBusqueda, iif(@Criterio = 1, p.CUV, coalesce(est.descripcioncuv2, op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion))) > 0;
END

GO

USE BelcorpDominicana
GO

IF (OBJECT_ID('[dbo].[GetProductoComercialByCampaniaZona]', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE [dbo].[GetProductoComercialByCampaniaZona] AS SET NOCOUNT ON;')
GO

ALTER PROCEDURE GetProductoComercialByCampaniaZona @CampaniaID INT
	,@RegionID INT
	,@ZonaID INT
	,@CodigoRegion VARCHAR(10)
	,@CodigoZona VARCHAR(10)
	,@RowCount INT
	,@Criterio INT
	,@TextoBusqueda VARCHAR(100)
AS
BEGIN
	--INI: Lista de Ofertas
	DECLARE @OfertaProductoTemp TABLE (
		CampaniaID INT
		,CUV VARCHAR(6)
		,Descripcion VARCHAR(250)
		,ConfiguracionOfertaID INT
		,TipoOfertaSisID INT
		,ImagenProducto VARCHAR(250)
		);

	INSERT INTO @OfertaProductoTemp
	SELECT op.CampaniaID
		,op.CUV
		,op.Descripcion
		,op.ConfiguracionOfertaID
		,op.TipoOfertaSisID
		,op.ImagenProducto
	FROM OfertaProducto op WITH (NOLOCK)
	INNER JOIN ods.Campania c ON op.CampaniaID = c.CampaniaID
	WHERE c.codigo = @CampaniaID
	
	UNION ALL
	
	SELECT c.CampaniaID
		,e.CUV2 as CUV
		,e.DescripcionCUV2 as Descripcion
		,ves.ConfiguracionOfertaID
		,ves.TipoOfertaSisID
		,e.ImagenURL as ImagenProducto
	FROM dbo.Estrategia e WITH (NOLOCK)
	INNER JOIN ods.Campania c ON e.CampaniaID = c.Codigo
	INNER JOIN vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE c.codigo = @CampaniaID;
	--FIN: Lista de Ofertas

	--INI: Lista de Productos Faltantes
	DECLARE @ProductoFaltanteTemp TABLE (CUV VARCHAR(6))

	INSERT INTO @ProductoFaltanteTemp
	SELECT DISTINCT ltrim(rtrim(CUV))
	FROM dbo.ProductoFaltante WITH (NOLOCK)
	WHERE CampaniaID = @CampaniaID
		AND Zonaid = @ZonaID
	
	UNION ALL
	
	SELECT DISTINCT ltrim(rtrim(fa.CodigoVenta)) AS CUV
	FROM ods.FaltanteAnunciado fa WITH (NOLOCK)
	INNER JOIN ods.Campania c WITH (NOLOCK) ON fa.CampaniaID = c.CampaniaID
	WHERE c.Codigo = @CampaniaID
		AND (
			fa.CodigoRegion IS NULL
			OR rtrim(fa.CodigoRegion) = @CodigoRegion
			)
		AND (
			fa.CodigoZona IS NULL
			OR rtrim(fa.CodigoZona) = @CodigoZona
			)

	--FIN: Lista de Productos Faltantes
	SELECT DISTINCT TOP (@RowCount) p.CUV
		,p.CodigoProducto AS CodigoSAP
		,coalesce(est.descripcioncuv2, op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion) AS Descripcion
		,coalesce(est.precio2, pd.PrecioProducto * pd.FactorRepeticion, p.PrecioUnitario * p.FactorRepeticion) AS PrecioCatalogo
		,iif(isnull(pf.CUV, 0) = 0, 1, 0) AS TieneStock
		,isnull(pcc.EsExpoOferta, 0) AS EsExpoOferta
		,isnull(pcc.CUVRevista, '') AS CUVRevista
		,p.IndicadorMontoMinimo
		,M.Descripcion AS DescripcionMarca
		,TE.DescripcionEstrategia AS DescripcionEstrategia
		,isnull(op.ConfiguracionOfertaID, 0) ConfiguracionOfertaID
		,isnull(op.TipoOfertaSisID, 0) TipoOfertaSisID
		,isnull(te.flagNueva, 0) FlagNueva
		,isnull(te.TipoEstrategiaID, '') TipoEstrategiaID
		,iif(PS.ProductoSugeridoID IS NULL, 0, 1) AS TieneSugerido
		,isnull(Cat.Descripcion, '') AS CatalogoDescripcion
		,coalesce(op.ImagenProducto, est.ImagenURL, PS2.ImagenProducto) AS ImagenOferta
		,coalesce(mc.FotoProducto01, mc.FotoProducto02, mc.FotoProducto03, mc.FotoProducto04, mc.FotoProducto05, mc.FotoProducto06, mc.FotoProducto07, mc.FotoProducto08, mc.FotoProducto09, mc.FotoProducto10) AS ImagenProducto
		,coalesce(est.descripcioncuv2, op.Descripcion) AS DescripcionOferta
		,coalesce(mc.Descripcion, pd.Descripcion, p.Descripcion) AS DescripcionProducto
	FROM ods.ProductoComercial p
	LEFT JOIN Marca M ON p.MarcaId = M.MarcaId
	LEFT JOIN dbo.ProductoDescripcion pd ON p.AnoCampania = pd.CampaniaID
		AND p.CUV = pd.CUV
	LEFT JOIN @ProductoFaltanteTemp pf ON p.CUV = pf.CUV
	LEFT JOIN ProductoComercialConfiguracion pcc ON p.AnoCampania = pcc.CampaniaID
		AND p.CUV = pcc.CUV
	LEFT JOIN @OfertaProductoTemp op ON op.CampaniaID = P.CampaniaID
		AND op.CUV = P.CUV
	LEFT JOIN MatrizComercial mc ON p.CodigoProducto = mc.CodigoSAP
	LEFT JOIN Estrategia EST ON (
			p.AnoCampania BETWEEN EST.CampaniaID
				AND isnull(EST.CampaniaIDFin, EST.CampaniaID)
			)
		AND EST.CUV2 = p.CUV
		AND EST.Activo = 1
	LEFT JOIN TipoEstrategia TE ON TE.TipoEstrategiaID = EST.TipoEstrategiaID
	LEFT JOIN ProductoSugerido PS ON PS.CampaniaID = p.AnoCampania
		AND PS.CUV = P.CUV
		AND PS.Estado = 1
	LEFT JOIN ProductoSugerido PS2 ON PS2.CampaniaID = p.AnoCampania
		AND PS2.CUVSugerido = P.CUV
		AND PS.Estado = 1
	LEFT JOIN ods.Catalogo Cat WITH (NOLOCK) ON p.CodigoCatalago = Cat.CodigoCatalogo
	WHERE p.AnoCampania = @CampaniaID
		AND p.IndicadorDigitable = 1
		AND CHARINDEX(@TextoBusqueda, iif(@Criterio = 1, p.CUV, coalesce(est.descripcioncuv2, op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion))) > 0;
END

GO

USE BelcorpCostaRica
GO

IF (OBJECT_ID('[dbo].[GetProductoComercialByCampaniaZona]', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE [dbo].[GetProductoComercialByCampaniaZona] AS SET NOCOUNT ON;')
GO

ALTER PROCEDURE GetProductoComercialByCampaniaZona @CampaniaID INT
	,@RegionID INT
	,@ZonaID INT
	,@CodigoRegion VARCHAR(10)
	,@CodigoZona VARCHAR(10)
	,@RowCount INT
	,@Criterio INT
	,@TextoBusqueda VARCHAR(100)
AS
BEGIN
	--INI: Lista de Ofertas
	DECLARE @OfertaProductoTemp TABLE (
		CampaniaID INT
		,CUV VARCHAR(6)
		,Descripcion VARCHAR(250)
		,ConfiguracionOfertaID INT
		,TipoOfertaSisID INT
		,ImagenProducto VARCHAR(250)
		);

	INSERT INTO @OfertaProductoTemp
	SELECT op.CampaniaID
		,op.CUV
		,op.Descripcion
		,op.ConfiguracionOfertaID
		,op.TipoOfertaSisID
		,op.ImagenProducto
	FROM OfertaProducto op WITH (NOLOCK)
	INNER JOIN ods.Campania c ON op.CampaniaID = c.CampaniaID
	WHERE c.codigo = @CampaniaID
	
	UNION ALL
	
	SELECT c.CampaniaID
		,e.CUV2 as CUV
		,e.DescripcionCUV2 as Descripcion
		,ves.ConfiguracionOfertaID
		,ves.TipoOfertaSisID
		,e.ImagenURL as ImagenProducto
	FROM dbo.Estrategia e WITH (NOLOCK)
	INNER JOIN ods.Campania c ON e.CampaniaID = c.Codigo
	INNER JOIN vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE c.codigo = @CampaniaID;
	--FIN: Lista de Ofertas

	--INI: Lista de Productos Faltantes
	DECLARE @ProductoFaltanteTemp TABLE (CUV VARCHAR(6))

	INSERT INTO @ProductoFaltanteTemp
	SELECT DISTINCT ltrim(rtrim(CUV))
	FROM dbo.ProductoFaltante WITH (NOLOCK)
	WHERE CampaniaID = @CampaniaID
		AND Zonaid = @ZonaID
	
	UNION ALL
	
	SELECT DISTINCT ltrim(rtrim(fa.CodigoVenta)) AS CUV
	FROM ods.FaltanteAnunciado fa WITH (NOLOCK)
	INNER JOIN ods.Campania c WITH (NOLOCK) ON fa.CampaniaID = c.CampaniaID
	WHERE c.Codigo = @CampaniaID
		AND (
			fa.CodigoRegion IS NULL
			OR rtrim(fa.CodigoRegion) = @CodigoRegion
			)
		AND (
			fa.CodigoZona IS NULL
			OR rtrim(fa.CodigoZona) = @CodigoZona
			)

	--FIN: Lista de Productos Faltantes
	SELECT DISTINCT TOP (@RowCount) p.CUV
		,p.CodigoProducto AS CodigoSAP
		,coalesce(est.descripcioncuv2, op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion) AS Descripcion
		,coalesce(est.precio2, pd.PrecioProducto * pd.FactorRepeticion, p.PrecioUnitario * p.FactorRepeticion) AS PrecioCatalogo
		,iif(isnull(pf.CUV, 0) = 0, 1, 0) AS TieneStock
		,isnull(pcc.EsExpoOferta, 0) AS EsExpoOferta
		,isnull(pcc.CUVRevista, '') AS CUVRevista
		,p.IndicadorMontoMinimo
		,M.Descripcion AS DescripcionMarca
		,TE.DescripcionEstrategia AS DescripcionEstrategia
		,isnull(op.ConfiguracionOfertaID, 0) ConfiguracionOfertaID
		,isnull(op.TipoOfertaSisID, 0) TipoOfertaSisID
		,isnull(te.flagNueva, 0) FlagNueva
		,isnull(te.TipoEstrategiaID, '') TipoEstrategiaID
		,iif(PS.ProductoSugeridoID IS NULL, 0, 1) AS TieneSugerido
		,isnull(Cat.Descripcion, '') AS CatalogoDescripcion
		,coalesce(op.ImagenProducto, est.ImagenURL, PS2.ImagenProducto) AS ImagenOferta
		,coalesce(mc.FotoProducto01, mc.FotoProducto02, mc.FotoProducto03, mc.FotoProducto04, mc.FotoProducto05, mc.FotoProducto06, mc.FotoProducto07, mc.FotoProducto08, mc.FotoProducto09, mc.FotoProducto10) AS ImagenProducto
		,coalesce(est.descripcioncuv2, op.Descripcion) AS DescripcionOferta
		,coalesce(mc.Descripcion, pd.Descripcion, p.Descripcion) AS DescripcionProducto
	FROM ods.ProductoComercial p
	LEFT JOIN Marca M ON p.MarcaId = M.MarcaId
	LEFT JOIN dbo.ProductoDescripcion pd ON p.AnoCampania = pd.CampaniaID
		AND p.CUV = pd.CUV
	LEFT JOIN @ProductoFaltanteTemp pf ON p.CUV = pf.CUV
	LEFT JOIN ProductoComercialConfiguracion pcc ON p.AnoCampania = pcc.CampaniaID
		AND p.CUV = pcc.CUV
	LEFT JOIN @OfertaProductoTemp op ON op.CampaniaID = P.CampaniaID
		AND op.CUV = P.CUV
	LEFT JOIN MatrizComercial mc ON p.CodigoProducto = mc.CodigoSAP
	LEFT JOIN Estrategia EST ON (
			p.AnoCampania BETWEEN EST.CampaniaID
				AND isnull(EST.CampaniaIDFin, EST.CampaniaID)
			)
		AND EST.CUV2 = p.CUV
		AND EST.Activo = 1
	LEFT JOIN TipoEstrategia TE ON TE.TipoEstrategiaID = EST.TipoEstrategiaID
	LEFT JOIN ProductoSugerido PS ON PS.CampaniaID = p.AnoCampania
		AND PS.CUV = P.CUV
		AND PS.Estado = 1
	LEFT JOIN ProductoSugerido PS2 ON PS2.CampaniaID = p.AnoCampania
		AND PS2.CUVSugerido = P.CUV
		AND PS.Estado = 1
	LEFT JOIN ods.Catalogo Cat WITH (NOLOCK) ON p.CodigoCatalago = Cat.CodigoCatalogo
	WHERE p.AnoCampania = @CampaniaID
		AND p.IndicadorDigitable = 1
		AND CHARINDEX(@TextoBusqueda, iif(@Criterio = 1, p.CUV, coalesce(est.descripcioncuv2, op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion))) > 0;
END

GO

USE BelcorpChile
GO

IF (OBJECT_ID('[dbo].[GetProductoComercialByCampaniaZona]', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE [dbo].[GetProductoComercialByCampaniaZona] AS SET NOCOUNT ON;')
GO

ALTER PROCEDURE GetProductoComercialByCampaniaZona @CampaniaID INT
	,@RegionID INT
	,@ZonaID INT
	,@CodigoRegion VARCHAR(10)
	,@CodigoZona VARCHAR(10)
	,@RowCount INT
	,@Criterio INT
	,@TextoBusqueda VARCHAR(100)
AS
BEGIN
	--INI: Lista de Ofertas
	DECLARE @OfertaProductoTemp TABLE (
		CampaniaID INT
		,CUV VARCHAR(6)
		,Descripcion VARCHAR(250)
		,ConfiguracionOfertaID INT
		,TipoOfertaSisID INT
		,ImagenProducto VARCHAR(250)
		);

	INSERT INTO @OfertaProductoTemp
	SELECT op.CampaniaID
		,op.CUV
		,op.Descripcion
		,op.ConfiguracionOfertaID
		,op.TipoOfertaSisID
		,op.ImagenProducto
	FROM OfertaProducto op WITH (NOLOCK)
	INNER JOIN ods.Campania c ON op.CampaniaID = c.CampaniaID
	WHERE c.codigo = @CampaniaID
	
	UNION ALL
	
	SELECT c.CampaniaID
		,e.CUV2 as CUV
		,e.DescripcionCUV2 as Descripcion
		,ves.ConfiguracionOfertaID
		,ves.TipoOfertaSisID
		,e.ImagenURL as ImagenProducto
	FROM dbo.Estrategia e WITH (NOLOCK)
	INNER JOIN ods.Campania c ON e.CampaniaID = c.Codigo
	INNER JOIN vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE c.codigo = @CampaniaID;
	--FIN: Lista de Ofertas

	--INI: Lista de Productos Faltantes
	DECLARE @ProductoFaltanteTemp TABLE (CUV VARCHAR(6))

	INSERT INTO @ProductoFaltanteTemp
	SELECT DISTINCT ltrim(rtrim(CUV))
	FROM dbo.ProductoFaltante WITH (NOLOCK)
	WHERE CampaniaID = @CampaniaID
		AND Zonaid = @ZonaID
	
	UNION ALL
	
	SELECT DISTINCT ltrim(rtrim(fa.CodigoVenta)) AS CUV
	FROM ods.FaltanteAnunciado fa WITH (NOLOCK)
	INNER JOIN ods.Campania c WITH (NOLOCK) ON fa.CampaniaID = c.CampaniaID
	WHERE c.Codigo = @CampaniaID
		AND (
			fa.CodigoRegion IS NULL
			OR rtrim(fa.CodigoRegion) = @CodigoRegion
			)
		AND (
			fa.CodigoZona IS NULL
			OR rtrim(fa.CodigoZona) = @CodigoZona
			)

	--FIN: Lista de Productos Faltantes
	SELECT DISTINCT TOP (@RowCount) p.CUV
		,p.CodigoProducto AS CodigoSAP
		,coalesce(est.descripcioncuv2, op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion) AS Descripcion
		,coalesce(est.precio2, pd.PrecioProducto * pd.FactorRepeticion, p.PrecioUnitario * p.FactorRepeticion) AS PrecioCatalogo
		,iif(isnull(pf.CUV, 0) = 0, 1, 0) AS TieneStock
		,isnull(pcc.EsExpoOferta, 0) AS EsExpoOferta
		,isnull(pcc.CUVRevista, '') AS CUVRevista
		,p.IndicadorMontoMinimo
		,M.Descripcion AS DescripcionMarca
		,TE.DescripcionEstrategia AS DescripcionEstrategia
		,isnull(op.ConfiguracionOfertaID, 0) ConfiguracionOfertaID
		,isnull(op.TipoOfertaSisID, 0) TipoOfertaSisID
		,isnull(te.flagNueva, 0) FlagNueva
		,isnull(te.TipoEstrategiaID, '') TipoEstrategiaID
		,iif(PS.ProductoSugeridoID IS NULL, 0, 1) AS TieneSugerido
		,isnull(Cat.Descripcion, '') AS CatalogoDescripcion
		,coalesce(op.ImagenProducto, est.ImagenURL, PS2.ImagenProducto) AS ImagenOferta
		,coalesce(mc.FotoProducto01, mc.FotoProducto02, mc.FotoProducto03, mc.FotoProducto04, mc.FotoProducto05, mc.FotoProducto06, mc.FotoProducto07, mc.FotoProducto08, mc.FotoProducto09, mc.FotoProducto10) AS ImagenProducto
		,coalesce(est.descripcioncuv2, op.Descripcion) AS DescripcionOferta
		,coalesce(mc.Descripcion, pd.Descripcion, p.Descripcion) AS DescripcionProducto
	FROM ods.ProductoComercial p
	LEFT JOIN Marca M ON p.MarcaId = M.MarcaId
	LEFT JOIN dbo.ProductoDescripcion pd ON p.AnoCampania = pd.CampaniaID
		AND p.CUV = pd.CUV
	LEFT JOIN @ProductoFaltanteTemp pf ON p.CUV = pf.CUV
	LEFT JOIN ProductoComercialConfiguracion pcc ON p.AnoCampania = pcc.CampaniaID
		AND p.CUV = pcc.CUV
	LEFT JOIN @OfertaProductoTemp op ON op.CampaniaID = P.CampaniaID
		AND op.CUV = P.CUV
	LEFT JOIN MatrizComercial mc ON p.CodigoProducto = mc.CodigoSAP
	LEFT JOIN Estrategia EST ON (
			p.AnoCampania BETWEEN EST.CampaniaID
				AND isnull(EST.CampaniaIDFin, EST.CampaniaID)
			)
		AND EST.CUV2 = p.CUV
		AND EST.Activo = 1
	LEFT JOIN TipoEstrategia TE ON TE.TipoEstrategiaID = EST.TipoEstrategiaID
	LEFT JOIN ProductoSugerido PS ON PS.CampaniaID = p.AnoCampania
		AND PS.CUV = P.CUV
		AND PS.Estado = 1
	LEFT JOIN ProductoSugerido PS2 ON PS2.CampaniaID = p.AnoCampania
		AND PS2.CUVSugerido = P.CUV
		AND PS.Estado = 1
	LEFT JOIN ods.Catalogo Cat WITH (NOLOCK) ON p.CodigoCatalago = Cat.CodigoCatalogo
	WHERE p.AnoCampania = @CampaniaID
		AND p.IndicadorDigitable = 1
		AND CHARINDEX(@TextoBusqueda, iif(@Criterio = 1, p.CUV, coalesce(est.descripcioncuv2, op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion))) > 0;
END

GO

USE BelcorpBolivia
GO

IF (OBJECT_ID('[dbo].[GetProductoComercialByCampaniaZona]', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE [dbo].[GetProductoComercialByCampaniaZona] AS SET NOCOUNT ON;')
GO

ALTER PROCEDURE GetProductoComercialByCampaniaZona @CampaniaID INT
	,@RegionID INT
	,@ZonaID INT
	,@CodigoRegion VARCHAR(10)
	,@CodigoZona VARCHAR(10)
	,@RowCount INT
	,@Criterio INT
	,@TextoBusqueda VARCHAR(100)
AS
BEGIN
	--INI: Lista de Ofertas
	DECLARE @OfertaProductoTemp TABLE (
		CampaniaID INT
		,CUV VARCHAR(6)
		,Descripcion VARCHAR(250)
		,ConfiguracionOfertaID INT
		,TipoOfertaSisID INT
		,ImagenProducto VARCHAR(250)
		);

	INSERT INTO @OfertaProductoTemp
	SELECT op.CampaniaID
		,op.CUV
		,op.Descripcion
		,op.ConfiguracionOfertaID
		,op.TipoOfertaSisID
		,op.ImagenProducto
	FROM OfertaProducto op WITH (NOLOCK)
	INNER JOIN ods.Campania c ON op.CampaniaID = c.CampaniaID
	WHERE c.codigo = @CampaniaID
	
	UNION ALL
	
	SELECT c.CampaniaID
		,e.CUV2 as CUV
		,e.DescripcionCUV2 as Descripcion
		,ves.ConfiguracionOfertaID
		,ves.TipoOfertaSisID
		,e.ImagenURL as ImagenProducto
	FROM dbo.Estrategia e WITH (NOLOCK)
	INNER JOIN ods.Campania c ON e.CampaniaID = c.Codigo
	INNER JOIN vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE c.codigo = @CampaniaID;
	--FIN: Lista de Ofertas

	--INI: Lista de Productos Faltantes
	DECLARE @ProductoFaltanteTemp TABLE (CUV VARCHAR(6))

	INSERT INTO @ProductoFaltanteTemp
	SELECT DISTINCT ltrim(rtrim(CUV))
	FROM dbo.ProductoFaltante WITH (NOLOCK)
	WHERE CampaniaID = @CampaniaID
		AND Zonaid = @ZonaID
	
	UNION ALL
	
	SELECT DISTINCT ltrim(rtrim(fa.CodigoVenta)) AS CUV
	FROM ods.FaltanteAnunciado fa WITH (NOLOCK)
	INNER JOIN ods.Campania c WITH (NOLOCK) ON fa.CampaniaID = c.CampaniaID
	WHERE c.Codigo = @CampaniaID
		AND (
			fa.CodigoRegion IS NULL
			OR rtrim(fa.CodigoRegion) = @CodigoRegion
			)
		AND (
			fa.CodigoZona IS NULL
			OR rtrim(fa.CodigoZona) = @CodigoZona
			)

	--FIN: Lista de Productos Faltantes
	SELECT DISTINCT TOP (@RowCount) p.CUV
		,p.CodigoProducto AS CodigoSAP
		,coalesce(est.descripcioncuv2, op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion) AS Descripcion
		,coalesce(est.precio2, pd.PrecioProducto * pd.FactorRepeticion, p.PrecioUnitario * p.FactorRepeticion) AS PrecioCatalogo
		,iif(isnull(pf.CUV, 0) = 0, 1, 0) AS TieneStock
		,isnull(pcc.EsExpoOferta, 0) AS EsExpoOferta
		,isnull(pcc.CUVRevista, '') AS CUVRevista
		,p.IndicadorMontoMinimo
		,M.Descripcion AS DescripcionMarca
		,TE.DescripcionEstrategia AS DescripcionEstrategia
		,isnull(op.ConfiguracionOfertaID, 0) ConfiguracionOfertaID
		,isnull(op.TipoOfertaSisID, 0) TipoOfertaSisID
		,isnull(te.flagNueva, 0) FlagNueva
		,isnull(te.TipoEstrategiaID, '') TipoEstrategiaID
		,iif(PS.ProductoSugeridoID IS NULL, 0, 1) AS TieneSugerido
		,isnull(Cat.Descripcion, '') AS CatalogoDescripcion
		,coalesce(op.ImagenProducto, est.ImagenURL, PS2.ImagenProducto) AS ImagenOferta
		,coalesce(mc.FotoProducto01, mc.FotoProducto02, mc.FotoProducto03, mc.FotoProducto04, mc.FotoProducto05, mc.FotoProducto06, mc.FotoProducto07, mc.FotoProducto08, mc.FotoProducto09, mc.FotoProducto10) AS ImagenProducto
		,coalesce(est.descripcioncuv2, op.Descripcion) AS DescripcionOferta
		,coalesce(mc.Descripcion, pd.Descripcion, p.Descripcion) AS DescripcionProducto
	FROM ods.ProductoComercial p
	LEFT JOIN Marca M ON p.MarcaId = M.MarcaId
	LEFT JOIN dbo.ProductoDescripcion pd ON p.AnoCampania = pd.CampaniaID
		AND p.CUV = pd.CUV
	LEFT JOIN @ProductoFaltanteTemp pf ON p.CUV = pf.CUV
	LEFT JOIN ProductoComercialConfiguracion pcc ON p.AnoCampania = pcc.CampaniaID
		AND p.CUV = pcc.CUV
	LEFT JOIN @OfertaProductoTemp op ON op.CampaniaID = P.CampaniaID
		AND op.CUV = P.CUV
	LEFT JOIN MatrizComercial mc ON p.CodigoProducto = mc.CodigoSAP
	LEFT JOIN Estrategia EST ON (
			p.AnoCampania BETWEEN EST.CampaniaID
				AND isnull(EST.CampaniaIDFin, EST.CampaniaID)
			)
		AND EST.CUV2 = p.CUV
		AND EST.Activo = 1
	LEFT JOIN TipoEstrategia TE ON TE.TipoEstrategiaID = EST.TipoEstrategiaID
	LEFT JOIN ProductoSugerido PS ON PS.CampaniaID = p.AnoCampania
		AND PS.CUV = P.CUV
		AND PS.Estado = 1
	LEFT JOIN ProductoSugerido PS2 ON PS2.CampaniaID = p.AnoCampania
		AND PS2.CUVSugerido = P.CUV
		AND PS.Estado = 1
	LEFT JOIN ods.Catalogo Cat WITH (NOLOCK) ON p.CodigoCatalago = Cat.CodigoCatalogo
	WHERE p.AnoCampania = @CampaniaID
		AND p.IndicadorDigitable = 1
		AND CHARINDEX(@TextoBusqueda, iif(@Criterio = 1, p.CUV, coalesce(est.descripcioncuv2, op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion))) > 0;
END

