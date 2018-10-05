GO
USE BelcorpPeru
GO

ALTER PROCEDURE [dbo].GetProductoComercialByDescripcionByFilter
(
 @CampaniaID INT
 ,@RowCount INT
 ,@CodigoDescripcion VARCHAR(100)
 ,@RegionID INT
 ,@ZonaID INT
 ,@CodigoRegion VARCHAR(10)
 ,@CodigoZona VARCHAR(10)
)
AS
/*
exec dbo.GetProductoComercialByDescripcionByFilter 201808,5,'kalos',2701,2161,'50','5052'
exec dbo.GetProductoComercialByCampaniaBySearchRegionZona_sb2 201808,5,2,'kalos',2701,2161,'50','5052'
*/
BEGIN

 DECLARE @_RowCount INT = @RowCount
 DECLARE @CampaniaIDVarchar varchar(8) = cast(@CampaniaID as varchar(8))

 /*Creacion de tablas Temporales*/
 DECLARE @OfertaProductoTemp TABLE
 (
  CampaniaID INT
  ,CUV VARCHAR(6)
  ,Descripcion VARCHAR(250)
  ,ConfiguracionOfertaID INT
  ,TipoOfertaSisID INT
  ,PrecioOferta NUMERIC(12, 2)
 )

 DECLARE @ProductoFaltanteTemp TABLE (CUV VARCHAR(6))
 /*Fin creacion de tablas Temporales*/

 -- Oferta Producto
 INSERT INTO @OfertaProductoTemp
 SELECT
  op.CampaniaID
  ,op.CUV
  ,op.Descripcion
  ,op.ConfiguracionOfertaID
  ,op.TipoOfertaSisID
  ,NULL
 FROM OfertaProducto op WITH (NOLOCK)
 INNER JOIN ods.Campania c WITH (NOLOCK)
  ON op.CampaniaID = c.CampaniaID
 WHERE c.codigo = @CampaniaIDVarchar

 -- Producto Faltante
 INSERT INTO @ProductoFaltanteTemp
 SELECT DISTINCT ltrim(rtrim(CUV))
 FROM dbo.ProductoFaltante WITH (NOLOCK)
 WHERE CampaniaID = @CampaniaID
  AND Zonaid = @ZonaID
 UNION ALL
 SELECT DISTINCT ltrim(rtrim(fa.CodigoVenta)) AS CUV
 FROM ods.FaltanteAnunciado fa WITH (NOLOCK)
 INNER JOIN ods.Campania c WITH (NOLOCK)
  ON fa.CampaniaID = c.CampaniaID
 WHERE c.Codigo = @CampaniaIDVarchar
  AND ( rtrim(fa.CodigoRegion) = @CodigoRegion OR fa.CodigoRegion IS NULL )
  AND ( rtrim(fa.CodigoZona) = @CodigoZona OR fa.CodigoZona IS NULL )

 -- Select final
 SELECT DISTINCT TOP (@_RowCount)
  p.CUV
  ,coalesce(est.descripcioncuv2, op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion) AS Descripcion
  ,coalesce(est.precio2, op.PrecioOferta, pd.PrecioProducto * pd.FactorRepeticion, p.PrecioUnitario * p.FactorRepeticion) AS PrecioCatalogo
  ,p.MarcaID
  ,0 AS EstaEnRevista
  ,CASE WHEN ISNULL(pf.CUV, 0) = 0 THEN 1 ELSE 0 END AS TieneStock
  ,pcc.EsExpoOferta
  ,pcc.CUVRevista
  ,'' AS CUVComplemento
  ,p.PaisID
  ,p.AnoCampania AS CampaniaID
  ,p.CodigoCatalago
  ,p.CodigoProducto
  ,p.IndicadorMontoMinimo
  ,M.Descripcion AS DescripcionMarca
  ,'NO DISPONIBLE' AS DescripcionCategoria
  ,TE.DescripcionEstrategia AS DescripcionEstrategia
  ,op.ConfiguracionOfertaID
  ,op.TipoOfertaSisID
  ,te.flagNueva
  ,te.TipoEstrategiaID
  ,P.IndicadorOferta
  --,case when isnull(ps.CUV, 0) = 0 then 0 else 1 end as TieneSugerido
  ,CASE WHEN ISNULL(ps.CUV, 0) = 0 THEN 0 ELSE
            CASE WHEN ISNULL(psp.MostrarAgotado, 0) = 0 THEN 1 ELSE
                CASE WHEN ISNULL(pf.CUV, 0) = 0 THEN 0 ELSE 1 END
            END
        END TieneSugerido
  ,CASE WHEN pcor.SAP IS NULL THEN 0 ELSE 1 END TieneOfertaRevista
  ,p.PrecioValorizado
  ,CASE WHEN pl.CodigoSAP IS NULL THEN 0 ELSE 1 END AS TieneLanzamientoCatalogoPersonalizado
  ,pcor.Oferta AS TipoOfertaRevista
  ,TE.Codigo AS TipoEstrategiaCodigo
  ,CASE WHEN (TE.MostrarImgOfertaIndependiente = 1 AND EST.EsOfertaIndependiente = 1) THEN 1 ELSE 0 END AS EsOfertaIndependiente
 FROM ods.ProductoComercial p WITH (NOLOCK)
 LEFT JOIN dbo.ProductoDescripcion pd WITH (NOLOCK)
  ON p.AnoCampania = pd.CampaniaID
  AND p.CUV = pd.CUV
 LEFT JOIN @ProductoFaltanteTemp pf
  ON p.CUV = pf.CUV
 LEFT JOIN ProductoComercialConfiguracion pcc WITH (NOLOCK)
  ON p.AnoCampania = pcc.CampaniaID
  AND p.CUV = pcc.CUV
 LEFT JOIN @OfertaProductoTemp op
  ON op.CampaniaID = P.CampaniaID
  AND op.CUV = P.CUV
 LEFT JOIN MatrizComercial mc WITH (NOLOCK)
  ON p.CodigoProducto = mc.CodigoSAP
 LEFT JOIN Estrategia EST WITH (NOLOCK)
  ON p.AnoCampania BETWEEN EST.CampaniaID AND CASE WHEN EST.CampaniaIDFin = 0 THEN EST.CampaniaID ELSE EST.CampaniaIDFin END
  AND (EST.CUV2 = p.CUV)
  AND EST.Activo = 1
 LEFT JOIN TipoEstrategia TE WITH (NOLOCK)
  ON TE.TipoEstrategiaID = EST.TipoEstrategiaID
 LEFT JOIN Marca M WITH (NOLOCK)
  ON p.MarcaId = M.MarcaId
 LEFT JOIN ods.ProductosLanzamiento pl WITH (NOLOCK)
  ON p.CodigoProducto = pl.CodigoSAP
  AND p.AnoCampania = pl.Campania
 LEFT JOIN ProductoComercialOfertaRevista pcor WITH (NOLOCK)
  ON p.AnoCampania = pcor.Campania
  AND p.CUV = pcor.CUV
 LEFT JOIN dbo.ProductoSugerido ps WITH (NOLOCK)
  ON p.AnoCampania = ps.CampaniaID
  AND p.CUV = ps.CUV
  AND ps.Estado = 1
 LEFT JOIN dbo.ProductoSugeridoPadre psp WITH (NOLOCK)
  ON p.AnoCampania = psp.CampaniaID AND p.CUV = psp.CUV
 WHERE p.AnoCampania = @CampaniaID
  AND p.IndicadorDigitable = 1
  AND CHARINDEX(@CodigoDescripcion, coalesce(est.descripcioncuv2, op.Descripcion, pd.Descripcion, p.Descripcion)) > 0
  AND NOT EXISTS (
   select ep.CUV
   from EstrategiaProducto ep WITH (NOLOCK)
   where ep.Campania = p.AnoCampania
    and ep.CUV = p.CUV
    and ep.CUV2 != p.CUV
    and NOT EXISTS (select tex.Codigo from TipoEstrategia tex where tex.TipoEstrategiaID = EST.TipoEstrategiaID and tex.Codigo = '011')
  )
END

GO
USE BelcorpMexico
GO

ALTER PROCEDURE [dbo].GetProductoComercialByDescripcionByFilter
(
 @CampaniaID INT
 ,@RowCount INT
 ,@CodigoDescripcion VARCHAR(100)
 ,@RegionID INT
 ,@ZonaID INT
 ,@CodigoRegion VARCHAR(10)
 ,@CodigoZona VARCHAR(10)
)
AS
/*
exec dbo.GetProductoComercialByDescripcionByFilter 201808,5,'kalos',2701,2161,'50','5052'
exec dbo.GetProductoComercialByCampaniaBySearchRegionZona_sb2 201808,5,2,'kalos',2701,2161,'50','5052'
*/
BEGIN

 DECLARE @_RowCount INT = @RowCount
 DECLARE @CampaniaIDVarchar varchar(8) = cast(@CampaniaID as varchar(8))

 /*Creacion de tablas Temporales*/
 DECLARE @OfertaProductoTemp TABLE
 (
  CampaniaID INT
  ,CUV VARCHAR(6)
  ,Descripcion VARCHAR(250)
  ,ConfiguracionOfertaID INT
  ,TipoOfertaSisID INT
  ,PrecioOferta NUMERIC(12, 2)
 )

 DECLARE @ProductoFaltanteTemp TABLE (CUV VARCHAR(6))
 /*Fin creacion de tablas Temporales*/

 -- Oferta Producto
 INSERT INTO @OfertaProductoTemp
 SELECT
  op.CampaniaID
  ,op.CUV
  ,op.Descripcion
  ,op.ConfiguracionOfertaID
  ,op.TipoOfertaSisID
  ,NULL
 FROM OfertaProducto op WITH (NOLOCK)
 INNER JOIN ods.Campania c WITH (NOLOCK)
  ON op.CampaniaID = c.CampaniaID
 WHERE c.codigo = @CampaniaIDVarchar

 -- Producto Faltante
 INSERT INTO @ProductoFaltanteTemp
 SELECT DISTINCT ltrim(rtrim(CUV))
 FROM dbo.ProductoFaltante WITH (NOLOCK)
 WHERE CampaniaID = @CampaniaID
  AND Zonaid = @ZonaID
 UNION ALL
 SELECT DISTINCT ltrim(rtrim(fa.CodigoVenta)) AS CUV
 FROM ods.FaltanteAnunciado fa WITH (NOLOCK)
 INNER JOIN ods.Campania c WITH (NOLOCK)
  ON fa.CampaniaID = c.CampaniaID
 WHERE c.Codigo = @CampaniaIDVarchar
  AND ( rtrim(fa.CodigoRegion) = @CodigoRegion OR fa.CodigoRegion IS NULL )
  AND ( rtrim(fa.CodigoZona) = @CodigoZona OR fa.CodigoZona IS NULL )

 -- Select final
 SELECT DISTINCT TOP (@_RowCount)
  p.CUV
  ,coalesce(est.descripcioncuv2, op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion) AS Descripcion
  ,coalesce(est.precio2, op.PrecioOferta, pd.PrecioProducto * pd.FactorRepeticion, p.PrecioUnitario * p.FactorRepeticion) AS PrecioCatalogo
  ,p.MarcaID
  ,0 AS EstaEnRevista
  ,CASE WHEN ISNULL(pf.CUV, 0) = 0 THEN 1 ELSE 0 END AS TieneStock
  ,pcc.EsExpoOferta
  ,pcc.CUVRevista
  ,'' AS CUVComplemento
  ,p.PaisID
  ,p.AnoCampania AS CampaniaID
  ,p.CodigoCatalago
  ,p.CodigoProducto
  ,p.IndicadorMontoMinimo
  ,M.Descripcion AS DescripcionMarca
  ,'NO DISPONIBLE' AS DescripcionCategoria
  ,TE.DescripcionEstrategia AS DescripcionEstrategia
  ,op.ConfiguracionOfertaID
  ,op.TipoOfertaSisID
  ,te.flagNueva
  ,te.TipoEstrategiaID
  ,P.IndicadorOferta
  --,case when isnull(ps.CUV, 0) = 0 then 0 else 1 end as TieneSugerido
  ,CASE WHEN ISNULL(ps.CUV, 0) = 0 THEN 0 ELSE
            CASE WHEN ISNULL(psp.MostrarAgotado, 0) = 0 THEN 1 ELSE
                CASE WHEN ISNULL(pf.CUV, 0) = 0 THEN 0 ELSE 1 END
            END
        END TieneSugerido
  ,CASE WHEN pcor.SAP IS NULL THEN 0 ELSE 1 END TieneOfertaRevista
  ,p.PrecioValorizado
  ,CASE WHEN pl.CodigoSAP IS NULL THEN 0 ELSE 1 END AS TieneLanzamientoCatalogoPersonalizado
  ,pcor.Oferta AS TipoOfertaRevista
  ,TE.Codigo AS TipoEstrategiaCodigo
  ,CASE WHEN (TE.MostrarImgOfertaIndependiente = 1 AND EST.EsOfertaIndependiente = 1) THEN 1 ELSE 0 END AS EsOfertaIndependiente
 FROM ods.ProductoComercial p WITH (NOLOCK)
 LEFT JOIN dbo.ProductoDescripcion pd WITH (NOLOCK)
  ON p.AnoCampania = pd.CampaniaID
  AND p.CUV = pd.CUV
 LEFT JOIN @ProductoFaltanteTemp pf
  ON p.CUV = pf.CUV
 LEFT JOIN ProductoComercialConfiguracion pcc WITH (NOLOCK)
  ON p.AnoCampania = pcc.CampaniaID
  AND p.CUV = pcc.CUV
 LEFT JOIN @OfertaProductoTemp op
  ON op.CampaniaID = P.CampaniaID
  AND op.CUV = P.CUV
 LEFT JOIN MatrizComercial mc WITH (NOLOCK)
  ON p.CodigoProducto = mc.CodigoSAP
 LEFT JOIN Estrategia EST WITH (NOLOCK)
  ON p.AnoCampania BETWEEN EST.CampaniaID AND CASE WHEN EST.CampaniaIDFin = 0 THEN EST.CampaniaID ELSE EST.CampaniaIDFin END
  AND (EST.CUV2 = p.CUV)
  AND EST.Activo = 1
 LEFT JOIN TipoEstrategia TE WITH (NOLOCK)
  ON TE.TipoEstrategiaID = EST.TipoEstrategiaID
 LEFT JOIN Marca M WITH (NOLOCK)
  ON p.MarcaId = M.MarcaId
 LEFT JOIN ods.ProductosLanzamiento pl WITH (NOLOCK)
  ON p.CodigoProducto = pl.CodigoSAP
  AND p.AnoCampania = pl.Campania
 LEFT JOIN ProductoComercialOfertaRevista pcor WITH (NOLOCK)
  ON p.AnoCampania = pcor.Campania
  AND p.CUV = pcor.CUV
 LEFT JOIN dbo.ProductoSugerido ps WITH (NOLOCK)
  ON p.AnoCampania = ps.CampaniaID
  AND p.CUV = ps.CUV
  AND ps.Estado = 1
 LEFT JOIN dbo.ProductoSugeridoPadre psp WITH (NOLOCK)
  ON p.AnoCampania = psp.CampaniaID AND p.CUV = psp.CUV
 WHERE p.AnoCampania = @CampaniaID
  AND p.IndicadorDigitable = 1
  AND CHARINDEX(@CodigoDescripcion, coalesce(est.descripcioncuv2, op.Descripcion, pd.Descripcion, p.Descripcion)) > 0
  AND NOT EXISTS (
   select ep.CUV
   from EstrategiaProducto ep WITH (NOLOCK)
   where ep.Campania = p.AnoCampania
    and ep.CUV = p.CUV
    and ep.CUV2 != p.CUV
    and NOT EXISTS (select tex.Codigo from TipoEstrategia tex where tex.TipoEstrategiaID = EST.TipoEstrategiaID and tex.Codigo = '011')
  )
END

GO
USE BelcorpColombia
GO

ALTER PROCEDURE [dbo].GetProductoComercialByDescripcionByFilter
(
 @CampaniaID INT
 ,@RowCount INT
 ,@CodigoDescripcion VARCHAR(100)
 ,@RegionID INT
 ,@ZonaID INT
 ,@CodigoRegion VARCHAR(10)
 ,@CodigoZona VARCHAR(10)
)
AS
/*
exec dbo.GetProductoComercialByDescripcionByFilter 201808,5,'kalos',2701,2161,'50','5052'
exec dbo.GetProductoComercialByCampaniaBySearchRegionZona_sb2 201808,5,2,'kalos',2701,2161,'50','5052'
*/
BEGIN

 DECLARE @_RowCount INT = @RowCount
 DECLARE @CampaniaIDVarchar varchar(8) = cast(@CampaniaID as varchar(8))

 /*Creacion de tablas Temporales*/
 DECLARE @OfertaProductoTemp TABLE
 (
  CampaniaID INT
  ,CUV VARCHAR(6)
  ,Descripcion VARCHAR(250)
  ,ConfiguracionOfertaID INT
  ,TipoOfertaSisID INT
  ,PrecioOferta NUMERIC(12, 2)
 )

 DECLARE @ProductoFaltanteTemp TABLE (CUV VARCHAR(6))
 /*Fin creacion de tablas Temporales*/

 -- Oferta Producto
 INSERT INTO @OfertaProductoTemp
 SELECT
  op.CampaniaID
  ,op.CUV
  ,op.Descripcion
  ,op.ConfiguracionOfertaID
  ,op.TipoOfertaSisID
  ,NULL
 FROM OfertaProducto op WITH (NOLOCK)
 INNER JOIN ods.Campania c WITH (NOLOCK)
  ON op.CampaniaID = c.CampaniaID
 WHERE c.codigo = @CampaniaIDVarchar

 -- Producto Faltante
 INSERT INTO @ProductoFaltanteTemp
 SELECT DISTINCT ltrim(rtrim(CUV))
 FROM dbo.ProductoFaltante WITH (NOLOCK)
 WHERE CampaniaID = @CampaniaID
  AND Zonaid = @ZonaID
 UNION ALL
 SELECT DISTINCT ltrim(rtrim(fa.CodigoVenta)) AS CUV
 FROM ods.FaltanteAnunciado fa WITH (NOLOCK)
 INNER JOIN ods.Campania c WITH (NOLOCK)
  ON fa.CampaniaID = c.CampaniaID
 WHERE c.Codigo = @CampaniaIDVarchar
  AND ( rtrim(fa.CodigoRegion) = @CodigoRegion OR fa.CodigoRegion IS NULL )
  AND ( rtrim(fa.CodigoZona) = @CodigoZona OR fa.CodigoZona IS NULL )

 -- Select final
 SELECT DISTINCT TOP (@_RowCount)
  p.CUV
  ,coalesce(est.descripcioncuv2, op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion) AS Descripcion
  ,coalesce(est.precio2, op.PrecioOferta, pd.PrecioProducto * pd.FactorRepeticion, p.PrecioUnitario * p.FactorRepeticion) AS PrecioCatalogo
  ,p.MarcaID
  ,0 AS EstaEnRevista
  ,CASE WHEN ISNULL(pf.CUV, 0) = 0 THEN 1 ELSE 0 END AS TieneStock
  ,pcc.EsExpoOferta
  ,pcc.CUVRevista
  ,'' AS CUVComplemento
  ,p.PaisID
  ,p.AnoCampania AS CampaniaID
  ,p.CodigoCatalago
  ,p.CodigoProducto
  ,p.IndicadorMontoMinimo
  ,M.Descripcion AS DescripcionMarca
  ,'NO DISPONIBLE' AS DescripcionCategoria
  ,TE.DescripcionEstrategia AS DescripcionEstrategia
  ,op.ConfiguracionOfertaID
  ,op.TipoOfertaSisID
  ,te.flagNueva
  ,te.TipoEstrategiaID
  ,P.IndicadorOferta
  --,case when isnull(ps.CUV, 0) = 0 then 0 else 1 end as TieneSugerido
  ,CASE WHEN ISNULL(ps.CUV, 0) = 0 THEN 0 ELSE
            CASE WHEN ISNULL(psp.MostrarAgotado, 0) = 0 THEN 1 ELSE
                CASE WHEN ISNULL(pf.CUV, 0) = 0 THEN 0 ELSE 1 END
            END
        END TieneSugerido
  ,CASE WHEN pcor.SAP IS NULL THEN 0 ELSE 1 END TieneOfertaRevista
  ,p.PrecioValorizado
  ,CASE WHEN pl.CodigoSAP IS NULL THEN 0 ELSE 1 END AS TieneLanzamientoCatalogoPersonalizado
  ,pcor.Oferta AS TipoOfertaRevista
  ,TE.Codigo AS TipoEstrategiaCodigo
  ,CASE WHEN (TE.MostrarImgOfertaIndependiente = 1 AND EST.EsOfertaIndependiente = 1) THEN 1 ELSE 0 END AS EsOfertaIndependiente
 FROM ods.ProductoComercial p WITH (NOLOCK)
 LEFT JOIN dbo.ProductoDescripcion pd WITH (NOLOCK)
  ON p.AnoCampania = pd.CampaniaID
  AND p.CUV = pd.CUV
 LEFT JOIN @ProductoFaltanteTemp pf
  ON p.CUV = pf.CUV
 LEFT JOIN ProductoComercialConfiguracion pcc WITH (NOLOCK)
  ON p.AnoCampania = pcc.CampaniaID
  AND p.CUV = pcc.CUV
 LEFT JOIN @OfertaProductoTemp op
  ON op.CampaniaID = P.CampaniaID
  AND op.CUV = P.CUV
 LEFT JOIN MatrizComercial mc WITH (NOLOCK)
  ON p.CodigoProducto = mc.CodigoSAP
 LEFT JOIN Estrategia EST WITH (NOLOCK)
  ON p.AnoCampania BETWEEN EST.CampaniaID AND CASE WHEN EST.CampaniaIDFin = 0 THEN EST.CampaniaID ELSE EST.CampaniaIDFin END
  AND (EST.CUV2 = p.CUV)
  AND EST.Activo = 1
 LEFT JOIN TipoEstrategia TE WITH (NOLOCK)
  ON TE.TipoEstrategiaID = EST.TipoEstrategiaID
 LEFT JOIN Marca M WITH (NOLOCK)
  ON p.MarcaId = M.MarcaId
 LEFT JOIN ods.ProductosLanzamiento pl WITH (NOLOCK)
  ON p.CodigoProducto = pl.CodigoSAP
  AND p.AnoCampania = pl.Campania
 LEFT JOIN ProductoComercialOfertaRevista pcor WITH (NOLOCK)
  ON p.AnoCampania = pcor.Campania
  AND p.CUV = pcor.CUV
 LEFT JOIN dbo.ProductoSugerido ps WITH (NOLOCK)
  ON p.AnoCampania = ps.CampaniaID
  AND p.CUV = ps.CUV
  AND ps.Estado = 1
 LEFT JOIN dbo.ProductoSugeridoPadre psp WITH (NOLOCK)
  ON p.AnoCampania = psp.CampaniaID AND p.CUV = psp.CUV
 WHERE p.AnoCampania = @CampaniaID
  AND p.IndicadorDigitable = 1
  AND CHARINDEX(@CodigoDescripcion, coalesce(est.descripcioncuv2, op.Descripcion, pd.Descripcion, p.Descripcion)) > 0
  AND NOT EXISTS (
   select ep.CUV
   from EstrategiaProducto ep WITH (NOLOCK)
   where ep.Campania = p.AnoCampania
    and ep.CUV = p.CUV
    and ep.CUV2 != p.CUV
    and NOT EXISTS (select tex.Codigo from TipoEstrategia tex where tex.TipoEstrategiaID = EST.TipoEstrategiaID and tex.Codigo = '011')
  )
END

GO
USE BelcorpSalvador
GO

ALTER PROCEDURE [dbo].GetProductoComercialByDescripcionByFilter
(
 @CampaniaID INT
 ,@RowCount INT
 ,@CodigoDescripcion VARCHAR(100)
 ,@RegionID INT
 ,@ZonaID INT
 ,@CodigoRegion VARCHAR(10)
 ,@CodigoZona VARCHAR(10)
)
AS
/*
exec dbo.GetProductoComercialByDescripcionByFilter 201808,5,'kalos',2701,2161,'50','5052'
exec dbo.GetProductoComercialByCampaniaBySearchRegionZona_sb2 201808,5,2,'kalos',2701,2161,'50','5052'
*/
BEGIN

 DECLARE @_RowCount INT = @RowCount
 DECLARE @CampaniaIDVarchar varchar(8) = cast(@CampaniaID as varchar(8))

 /*Creacion de tablas Temporales*/
 DECLARE @OfertaProductoTemp TABLE
 (
  CampaniaID INT
  ,CUV VARCHAR(6)
  ,Descripcion VARCHAR(250)
  ,ConfiguracionOfertaID INT
  ,TipoOfertaSisID INT
  ,PrecioOferta NUMERIC(12, 2)
 )

 DECLARE @ProductoFaltanteTemp TABLE (CUV VARCHAR(6))
 /*Fin creacion de tablas Temporales*/

 -- Oferta Producto
 INSERT INTO @OfertaProductoTemp
 SELECT
  op.CampaniaID
  ,op.CUV
  ,op.Descripcion
  ,op.ConfiguracionOfertaID
  ,op.TipoOfertaSisID
  ,NULL
 FROM OfertaProducto op WITH (NOLOCK)
 INNER JOIN ods.Campania c WITH (NOLOCK)
  ON op.CampaniaID = c.CampaniaID
 WHERE c.codigo = @CampaniaIDVarchar

 -- Producto Faltante
 INSERT INTO @ProductoFaltanteTemp
 SELECT DISTINCT ltrim(rtrim(CUV))
 FROM dbo.ProductoFaltante WITH (NOLOCK)
 WHERE CampaniaID = @CampaniaID
  AND Zonaid = @ZonaID
 UNION ALL
 SELECT DISTINCT ltrim(rtrim(fa.CodigoVenta)) AS CUV
 FROM ods.FaltanteAnunciado fa WITH (NOLOCK)
 INNER JOIN ods.Campania c WITH (NOLOCK)
  ON fa.CampaniaID = c.CampaniaID
 WHERE c.Codigo = @CampaniaIDVarchar
  AND ( rtrim(fa.CodigoRegion) = @CodigoRegion OR fa.CodigoRegion IS NULL )
  AND ( rtrim(fa.CodigoZona) = @CodigoZona OR fa.CodigoZona IS NULL )

 -- Select final
 SELECT DISTINCT TOP (@_RowCount)
  p.CUV
  ,coalesce(est.descripcioncuv2, op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion) AS Descripcion
  ,coalesce(est.precio2, op.PrecioOferta, pd.PrecioProducto * pd.FactorRepeticion, p.PrecioUnitario * p.FactorRepeticion) AS PrecioCatalogo
  ,p.MarcaID
  ,0 AS EstaEnRevista
  ,CASE WHEN ISNULL(pf.CUV, 0) = 0 THEN 1 ELSE 0 END AS TieneStock
  ,pcc.EsExpoOferta
  ,pcc.CUVRevista
  ,'' AS CUVComplemento
  ,p.PaisID
  ,p.AnoCampania AS CampaniaID
  ,p.CodigoCatalago
  ,p.CodigoProducto
  ,p.IndicadorMontoMinimo
  ,M.Descripcion AS DescripcionMarca
  ,'NO DISPONIBLE' AS DescripcionCategoria
  ,TE.DescripcionEstrategia AS DescripcionEstrategia
  ,op.ConfiguracionOfertaID
  ,op.TipoOfertaSisID
  ,te.flagNueva
  ,te.TipoEstrategiaID
  ,P.IndicadorOferta
  --,case when isnull(ps.CUV, 0) = 0 then 0 else 1 end as TieneSugerido
  ,CASE WHEN ISNULL(ps.CUV, 0) = 0 THEN 0 ELSE
            CASE WHEN ISNULL(psp.MostrarAgotado, 0) = 0 THEN 1 ELSE
                CASE WHEN ISNULL(pf.CUV, 0) = 0 THEN 0 ELSE 1 END
            END
        END TieneSugerido
  ,CASE WHEN pcor.SAP IS NULL THEN 0 ELSE 1 END TieneOfertaRevista
  ,p.PrecioValorizado
  ,CASE WHEN pl.CodigoSAP IS NULL THEN 0 ELSE 1 END AS TieneLanzamientoCatalogoPersonalizado
  ,pcor.Oferta AS TipoOfertaRevista
  ,TE.Codigo AS TipoEstrategiaCodigo
  ,CASE WHEN (TE.MostrarImgOfertaIndependiente = 1 AND EST.EsOfertaIndependiente = 1) THEN 1 ELSE 0 END AS EsOfertaIndependiente
 FROM ods.ProductoComercial p WITH (NOLOCK)
 LEFT JOIN dbo.ProductoDescripcion pd WITH (NOLOCK)
  ON p.AnoCampania = pd.CampaniaID
  AND p.CUV = pd.CUV
 LEFT JOIN @ProductoFaltanteTemp pf
  ON p.CUV = pf.CUV
 LEFT JOIN ProductoComercialConfiguracion pcc WITH (NOLOCK)
  ON p.AnoCampania = pcc.CampaniaID
  AND p.CUV = pcc.CUV
 LEFT JOIN @OfertaProductoTemp op
  ON op.CampaniaID = P.CampaniaID
  AND op.CUV = P.CUV
 LEFT JOIN MatrizComercial mc WITH (NOLOCK)
  ON p.CodigoProducto = mc.CodigoSAP
 LEFT JOIN Estrategia EST WITH (NOLOCK)
  ON p.AnoCampania BETWEEN EST.CampaniaID AND CASE WHEN EST.CampaniaIDFin = 0 THEN EST.CampaniaID ELSE EST.CampaniaIDFin END
  AND (EST.CUV2 = p.CUV)
  AND EST.Activo = 1
 LEFT JOIN TipoEstrategia TE WITH (NOLOCK)
  ON TE.TipoEstrategiaID = EST.TipoEstrategiaID
 LEFT JOIN Marca M WITH (NOLOCK)
  ON p.MarcaId = M.MarcaId
 LEFT JOIN ods.ProductosLanzamiento pl WITH (NOLOCK)
  ON p.CodigoProducto = pl.CodigoSAP
  AND p.AnoCampania = pl.Campania
 LEFT JOIN ProductoComercialOfertaRevista pcor WITH (NOLOCK)
  ON p.AnoCampania = pcor.Campania
  AND p.CUV = pcor.CUV
 LEFT JOIN dbo.ProductoSugerido ps WITH (NOLOCK)
  ON p.AnoCampania = ps.CampaniaID
  AND p.CUV = ps.CUV
  AND ps.Estado = 1
 LEFT JOIN dbo.ProductoSugeridoPadre psp WITH (NOLOCK)
  ON p.AnoCampania = psp.CampaniaID AND p.CUV = psp.CUV
 WHERE p.AnoCampania = @CampaniaID
  AND p.IndicadorDigitable = 1
  AND CHARINDEX(@CodigoDescripcion, coalesce(est.descripcioncuv2, op.Descripcion, pd.Descripcion, p.Descripcion)) > 0
  AND NOT EXISTS (
   select ep.CUV
   from EstrategiaProducto ep WITH (NOLOCK)
   where ep.Campania = p.AnoCampania
    and ep.CUV = p.CUV
    and ep.CUV2 != p.CUV
    and NOT EXISTS (select tex.Codigo from TipoEstrategia tex where tex.TipoEstrategiaID = EST.TipoEstrategiaID and tex.Codigo = '011')
  )
END

GO
USE BelcorpPuertoRico
GO

ALTER PROCEDURE [dbo].GetProductoComercialByDescripcionByFilter
(
 @CampaniaID INT
 ,@RowCount INT
 ,@CodigoDescripcion VARCHAR(100)
 ,@RegionID INT
 ,@ZonaID INT
 ,@CodigoRegion VARCHAR(10)
 ,@CodigoZona VARCHAR(10)
)
AS
/*
exec dbo.GetProductoComercialByDescripcionByFilter 201808,5,'kalos',2701,2161,'50','5052'
exec dbo.GetProductoComercialByCampaniaBySearchRegionZona_sb2 201808,5,2,'kalos',2701,2161,'50','5052'
*/
BEGIN

 DECLARE @_RowCount INT = @RowCount
 DECLARE @CampaniaIDVarchar varchar(8) = cast(@CampaniaID as varchar(8))

 /*Creacion de tablas Temporales*/
 DECLARE @OfertaProductoTemp TABLE
 (
  CampaniaID INT
  ,CUV VARCHAR(6)
  ,Descripcion VARCHAR(250)
  ,ConfiguracionOfertaID INT
  ,TipoOfertaSisID INT
  ,PrecioOferta NUMERIC(12, 2)
 )

 DECLARE @ProductoFaltanteTemp TABLE (CUV VARCHAR(6))
 /*Fin creacion de tablas Temporales*/

 -- Oferta Producto
 INSERT INTO @OfertaProductoTemp
 SELECT
  op.CampaniaID
  ,op.CUV
  ,op.Descripcion
  ,op.ConfiguracionOfertaID
  ,op.TipoOfertaSisID
  ,NULL
 FROM OfertaProducto op WITH (NOLOCK)
 INNER JOIN ods.Campania c WITH (NOLOCK)
  ON op.CampaniaID = c.CampaniaID
 WHERE c.codigo = @CampaniaIDVarchar

 -- Producto Faltante
 INSERT INTO @ProductoFaltanteTemp
 SELECT DISTINCT ltrim(rtrim(CUV))
 FROM dbo.ProductoFaltante WITH (NOLOCK)
 WHERE CampaniaID = @CampaniaID
  AND Zonaid = @ZonaID
 UNION ALL
 SELECT DISTINCT ltrim(rtrim(fa.CodigoVenta)) AS CUV
 FROM ods.FaltanteAnunciado fa WITH (NOLOCK)
 INNER JOIN ods.Campania c WITH (NOLOCK)
  ON fa.CampaniaID = c.CampaniaID
 WHERE c.Codigo = @CampaniaIDVarchar
  AND ( rtrim(fa.CodigoRegion) = @CodigoRegion OR fa.CodigoRegion IS NULL )
  AND ( rtrim(fa.CodigoZona) = @CodigoZona OR fa.CodigoZona IS NULL )

 -- Select final
 SELECT DISTINCT TOP (@_RowCount)
  p.CUV
  ,coalesce(est.descripcioncuv2, op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion) AS Descripcion
  ,coalesce(est.precio2, op.PrecioOferta, pd.PrecioProducto * pd.FactorRepeticion, p.PrecioUnitario * p.FactorRepeticion) AS PrecioCatalogo
  ,p.MarcaID
  ,0 AS EstaEnRevista
  ,CASE WHEN ISNULL(pf.CUV, 0) = 0 THEN 1 ELSE 0 END AS TieneStock
  ,pcc.EsExpoOferta
  ,pcc.CUVRevista
  ,'' AS CUVComplemento
  ,p.PaisID
  ,p.AnoCampania AS CampaniaID
  ,p.CodigoCatalago
  ,p.CodigoProducto
  ,p.IndicadorMontoMinimo
  ,M.Descripcion AS DescripcionMarca
  ,'NO DISPONIBLE' AS DescripcionCategoria
  ,TE.DescripcionEstrategia AS DescripcionEstrategia
  ,op.ConfiguracionOfertaID
  ,op.TipoOfertaSisID
  ,te.flagNueva
  ,te.TipoEstrategiaID
  ,P.IndicadorOferta
  --,case when isnull(ps.CUV, 0) = 0 then 0 else 1 end as TieneSugerido
  ,CASE WHEN ISNULL(ps.CUV, 0) = 0 THEN 0 ELSE
            CASE WHEN ISNULL(psp.MostrarAgotado, 0) = 0 THEN 1 ELSE
                CASE WHEN ISNULL(pf.CUV, 0) = 0 THEN 0 ELSE 1 END
            END
        END TieneSugerido
  ,CASE WHEN pcor.SAP IS NULL THEN 0 ELSE 1 END TieneOfertaRevista
  ,p.PrecioValorizado
  ,CASE WHEN pl.CodigoSAP IS NULL THEN 0 ELSE 1 END AS TieneLanzamientoCatalogoPersonalizado
  ,pcor.Oferta AS TipoOfertaRevista
  ,TE.Codigo AS TipoEstrategiaCodigo
  ,CASE WHEN (TE.MostrarImgOfertaIndependiente = 1 AND EST.EsOfertaIndependiente = 1) THEN 1 ELSE 0 END AS EsOfertaIndependiente
 FROM ods.ProductoComercial p WITH (NOLOCK)
 LEFT JOIN dbo.ProductoDescripcion pd WITH (NOLOCK)
  ON p.AnoCampania = pd.CampaniaID
  AND p.CUV = pd.CUV
 LEFT JOIN @ProductoFaltanteTemp pf
  ON p.CUV = pf.CUV
 LEFT JOIN ProductoComercialConfiguracion pcc WITH (NOLOCK)
  ON p.AnoCampania = pcc.CampaniaID
  AND p.CUV = pcc.CUV
 LEFT JOIN @OfertaProductoTemp op
  ON op.CampaniaID = P.CampaniaID
  AND op.CUV = P.CUV
 LEFT JOIN MatrizComercial mc WITH (NOLOCK)
  ON p.CodigoProducto = mc.CodigoSAP
 LEFT JOIN Estrategia EST WITH (NOLOCK)
  ON p.AnoCampania BETWEEN EST.CampaniaID AND CASE WHEN EST.CampaniaIDFin = 0 THEN EST.CampaniaID ELSE EST.CampaniaIDFin END
  AND (EST.CUV2 = p.CUV)
  AND EST.Activo = 1
 LEFT JOIN TipoEstrategia TE WITH (NOLOCK)
  ON TE.TipoEstrategiaID = EST.TipoEstrategiaID
 LEFT JOIN Marca M WITH (NOLOCK)
  ON p.MarcaId = M.MarcaId
 LEFT JOIN ods.ProductosLanzamiento pl WITH (NOLOCK)
  ON p.CodigoProducto = pl.CodigoSAP
  AND p.AnoCampania = pl.Campania
 LEFT JOIN ProductoComercialOfertaRevista pcor WITH (NOLOCK)
  ON p.AnoCampania = pcor.Campania
  AND p.CUV = pcor.CUV
 LEFT JOIN dbo.ProductoSugerido ps WITH (NOLOCK)
  ON p.AnoCampania = ps.CampaniaID
  AND p.CUV = ps.CUV
  AND ps.Estado = 1
 LEFT JOIN dbo.ProductoSugeridoPadre psp WITH (NOLOCK)
  ON p.AnoCampania = psp.CampaniaID AND p.CUV = psp.CUV
 WHERE p.AnoCampania = @CampaniaID
  AND p.IndicadorDigitable = 1
  AND CHARINDEX(@CodigoDescripcion, coalesce(est.descripcioncuv2, op.Descripcion, pd.Descripcion, p.Descripcion)) > 0
  AND NOT EXISTS (
   select ep.CUV
   from EstrategiaProducto ep WITH (NOLOCK)
   where ep.Campania = p.AnoCampania
    and ep.CUV = p.CUV
    and ep.CUV2 != p.CUV
    and NOT EXISTS (select tex.Codigo from TipoEstrategia tex where tex.TipoEstrategiaID = EST.TipoEstrategiaID and tex.Codigo = '011')
  )
END

GO
USE BelcorpPanama
GO

ALTER PROCEDURE [dbo].GetProductoComercialByDescripcionByFilter
(
 @CampaniaID INT
 ,@RowCount INT
 ,@CodigoDescripcion VARCHAR(100)
 ,@RegionID INT
 ,@ZonaID INT
 ,@CodigoRegion VARCHAR(10)
 ,@CodigoZona VARCHAR(10)
)
AS
/*
exec dbo.GetProductoComercialByDescripcionByFilter 201808,5,'kalos',2701,2161,'50','5052'
exec dbo.GetProductoComercialByCampaniaBySearchRegionZona_sb2 201808,5,2,'kalos',2701,2161,'50','5052'
*/
BEGIN

 DECLARE @_RowCount INT = @RowCount
 DECLARE @CampaniaIDVarchar varchar(8) = cast(@CampaniaID as varchar(8))

 /*Creacion de tablas Temporales*/
 DECLARE @OfertaProductoTemp TABLE
 (
  CampaniaID INT
  ,CUV VARCHAR(6)
  ,Descripcion VARCHAR(250)
  ,ConfiguracionOfertaID INT
  ,TipoOfertaSisID INT
  ,PrecioOferta NUMERIC(12, 2)
 )

 DECLARE @ProductoFaltanteTemp TABLE (CUV VARCHAR(6))
 /*Fin creacion de tablas Temporales*/

 -- Oferta Producto
 INSERT INTO @OfertaProductoTemp
 SELECT
  op.CampaniaID
  ,op.CUV
  ,op.Descripcion
  ,op.ConfiguracionOfertaID
  ,op.TipoOfertaSisID
  ,NULL
 FROM OfertaProducto op WITH (NOLOCK)
 INNER JOIN ods.Campania c WITH (NOLOCK)
  ON op.CampaniaID = c.CampaniaID
 WHERE c.codigo = @CampaniaIDVarchar

 -- Producto Faltante
 INSERT INTO @ProductoFaltanteTemp
 SELECT DISTINCT ltrim(rtrim(CUV))
 FROM dbo.ProductoFaltante WITH (NOLOCK)
 WHERE CampaniaID = @CampaniaID
  AND Zonaid = @ZonaID
 UNION ALL
 SELECT DISTINCT ltrim(rtrim(fa.CodigoVenta)) AS CUV
 FROM ods.FaltanteAnunciado fa WITH (NOLOCK)
 INNER JOIN ods.Campania c WITH (NOLOCK)
  ON fa.CampaniaID = c.CampaniaID
 WHERE c.Codigo = @CampaniaIDVarchar
  AND ( rtrim(fa.CodigoRegion) = @CodigoRegion OR fa.CodigoRegion IS NULL )
  AND ( rtrim(fa.CodigoZona) = @CodigoZona OR fa.CodigoZona IS NULL )

 -- Select final
 SELECT DISTINCT TOP (@_RowCount)
  p.CUV
  ,coalesce(est.descripcioncuv2, op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion) AS Descripcion
  ,coalesce(est.precio2, op.PrecioOferta, pd.PrecioProducto * pd.FactorRepeticion, p.PrecioUnitario * p.FactorRepeticion) AS PrecioCatalogo
  ,p.MarcaID
  ,0 AS EstaEnRevista
  ,CASE WHEN ISNULL(pf.CUV, 0) = 0 THEN 1 ELSE 0 END AS TieneStock
  ,pcc.EsExpoOferta
  ,pcc.CUVRevista
  ,'' AS CUVComplemento
  ,p.PaisID
  ,p.AnoCampania AS CampaniaID
  ,p.CodigoCatalago
  ,p.CodigoProducto
  ,p.IndicadorMontoMinimo
  ,M.Descripcion AS DescripcionMarca
  ,'NO DISPONIBLE' AS DescripcionCategoria
  ,TE.DescripcionEstrategia AS DescripcionEstrategia
  ,op.ConfiguracionOfertaID
  ,op.TipoOfertaSisID
  ,te.flagNueva
  ,te.TipoEstrategiaID
  ,P.IndicadorOferta
  --,case when isnull(ps.CUV, 0) = 0 then 0 else 1 end as TieneSugerido
  ,CASE WHEN ISNULL(ps.CUV, 0) = 0 THEN 0 ELSE
            CASE WHEN ISNULL(psp.MostrarAgotado, 0) = 0 THEN 1 ELSE
                CASE WHEN ISNULL(pf.CUV, 0) = 0 THEN 0 ELSE 1 END
            END
        END TieneSugerido
  ,CASE WHEN pcor.SAP IS NULL THEN 0 ELSE 1 END TieneOfertaRevista
  ,p.PrecioValorizado
  ,CASE WHEN pl.CodigoSAP IS NULL THEN 0 ELSE 1 END AS TieneLanzamientoCatalogoPersonalizado
  ,pcor.Oferta AS TipoOfertaRevista
  ,TE.Codigo AS TipoEstrategiaCodigo
  ,CASE WHEN (TE.MostrarImgOfertaIndependiente = 1 AND EST.EsOfertaIndependiente = 1) THEN 1 ELSE 0 END AS EsOfertaIndependiente
 FROM ods.ProductoComercial p WITH (NOLOCK)
 LEFT JOIN dbo.ProductoDescripcion pd WITH (NOLOCK)
  ON p.AnoCampania = pd.CampaniaID
  AND p.CUV = pd.CUV
 LEFT JOIN @ProductoFaltanteTemp pf
  ON p.CUV = pf.CUV
 LEFT JOIN ProductoComercialConfiguracion pcc WITH (NOLOCK)
  ON p.AnoCampania = pcc.CampaniaID
  AND p.CUV = pcc.CUV
 LEFT JOIN @OfertaProductoTemp op
  ON op.CampaniaID = P.CampaniaID
  AND op.CUV = P.CUV
 LEFT JOIN MatrizComercial mc WITH (NOLOCK)
  ON p.CodigoProducto = mc.CodigoSAP
 LEFT JOIN Estrategia EST WITH (NOLOCK)
  ON p.AnoCampania BETWEEN EST.CampaniaID AND CASE WHEN EST.CampaniaIDFin = 0 THEN EST.CampaniaID ELSE EST.CampaniaIDFin END
  AND (EST.CUV2 = p.CUV)
  AND EST.Activo = 1
 LEFT JOIN TipoEstrategia TE WITH (NOLOCK)
  ON TE.TipoEstrategiaID = EST.TipoEstrategiaID
 LEFT JOIN Marca M WITH (NOLOCK)
  ON p.MarcaId = M.MarcaId
 LEFT JOIN ods.ProductosLanzamiento pl WITH (NOLOCK)
  ON p.CodigoProducto = pl.CodigoSAP
  AND p.AnoCampania = pl.Campania
 LEFT JOIN ProductoComercialOfertaRevista pcor WITH (NOLOCK)
  ON p.AnoCampania = pcor.Campania
  AND p.CUV = pcor.CUV
 LEFT JOIN dbo.ProductoSugerido ps WITH (NOLOCK)
  ON p.AnoCampania = ps.CampaniaID
  AND p.CUV = ps.CUV
  AND ps.Estado = 1
 LEFT JOIN dbo.ProductoSugeridoPadre psp WITH (NOLOCK)
  ON p.AnoCampania = psp.CampaniaID AND p.CUV = psp.CUV
 WHERE p.AnoCampania = @CampaniaID
  AND p.IndicadorDigitable = 1
  AND CHARINDEX(@CodigoDescripcion, coalesce(est.descripcioncuv2, op.Descripcion, pd.Descripcion, p.Descripcion)) > 0
  AND NOT EXISTS (
   select ep.CUV
   from EstrategiaProducto ep WITH (NOLOCK)
   where ep.Campania = p.AnoCampania
    and ep.CUV = p.CUV
    and ep.CUV2 != p.CUV
    and NOT EXISTS (select tex.Codigo from TipoEstrategia tex where tex.TipoEstrategiaID = EST.TipoEstrategiaID and tex.Codigo = '011')
  )
END

GO
USE BelcorpGuatemala
GO

ALTER PROCEDURE [dbo].GetProductoComercialByDescripcionByFilter
(
 @CampaniaID INT
 ,@RowCount INT
 ,@CodigoDescripcion VARCHAR(100)
 ,@RegionID INT
 ,@ZonaID INT
 ,@CodigoRegion VARCHAR(10)
 ,@CodigoZona VARCHAR(10)
)
AS
/*
exec dbo.GetProductoComercialByDescripcionByFilter 201808,5,'kalos',2701,2161,'50','5052'
exec dbo.GetProductoComercialByCampaniaBySearchRegionZona_sb2 201808,5,2,'kalos',2701,2161,'50','5052'
*/
BEGIN

 DECLARE @_RowCount INT = @RowCount
 DECLARE @CampaniaIDVarchar varchar(8) = cast(@CampaniaID as varchar(8))

 /*Creacion de tablas Temporales*/
 DECLARE @OfertaProductoTemp TABLE
 (
  CampaniaID INT
  ,CUV VARCHAR(6)
  ,Descripcion VARCHAR(250)
  ,ConfiguracionOfertaID INT
  ,TipoOfertaSisID INT
  ,PrecioOferta NUMERIC(12, 2)
 )

 DECLARE @ProductoFaltanteTemp TABLE (CUV VARCHAR(6))
 /*Fin creacion de tablas Temporales*/

 -- Oferta Producto
 INSERT INTO @OfertaProductoTemp
 SELECT
  op.CampaniaID
  ,op.CUV
  ,op.Descripcion
  ,op.ConfiguracionOfertaID
  ,op.TipoOfertaSisID
  ,NULL
 FROM OfertaProducto op WITH (NOLOCK)
 INNER JOIN ods.Campania c WITH (NOLOCK)
  ON op.CampaniaID = c.CampaniaID
 WHERE c.codigo = @CampaniaIDVarchar

 -- Producto Faltante
 INSERT INTO @ProductoFaltanteTemp
 SELECT DISTINCT ltrim(rtrim(CUV))
 FROM dbo.ProductoFaltante WITH (NOLOCK)
 WHERE CampaniaID = @CampaniaID
  AND Zonaid = @ZonaID
 UNION ALL
 SELECT DISTINCT ltrim(rtrim(fa.CodigoVenta)) AS CUV
 FROM ods.FaltanteAnunciado fa WITH (NOLOCK)
 INNER JOIN ods.Campania c WITH (NOLOCK)
  ON fa.CampaniaID = c.CampaniaID
 WHERE c.Codigo = @CampaniaIDVarchar
  AND ( rtrim(fa.CodigoRegion) = @CodigoRegion OR fa.CodigoRegion IS NULL )
  AND ( rtrim(fa.CodigoZona) = @CodigoZona OR fa.CodigoZona IS NULL )

 -- Select final
 SELECT DISTINCT TOP (@_RowCount)
  p.CUV
  ,coalesce(est.descripcioncuv2, op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion) AS Descripcion
  ,coalesce(est.precio2, op.PrecioOferta, pd.PrecioProducto * pd.FactorRepeticion, p.PrecioUnitario * p.FactorRepeticion) AS PrecioCatalogo
  ,p.MarcaID
  ,0 AS EstaEnRevista
  ,CASE WHEN ISNULL(pf.CUV, 0) = 0 THEN 1 ELSE 0 END AS TieneStock
  ,pcc.EsExpoOferta
  ,pcc.CUVRevista
  ,'' AS CUVComplemento
  ,p.PaisID
  ,p.AnoCampania AS CampaniaID
  ,p.CodigoCatalago
  ,p.CodigoProducto
  ,p.IndicadorMontoMinimo
  ,M.Descripcion AS DescripcionMarca
  ,'NO DISPONIBLE' AS DescripcionCategoria
  ,TE.DescripcionEstrategia AS DescripcionEstrategia
  ,op.ConfiguracionOfertaID
  ,op.TipoOfertaSisID
  ,te.flagNueva
  ,te.TipoEstrategiaID
  ,P.IndicadorOferta
  --,case when isnull(ps.CUV, 0) = 0 then 0 else 1 end as TieneSugerido
  ,CASE WHEN ISNULL(ps.CUV, 0) = 0 THEN 0 ELSE
            CASE WHEN ISNULL(psp.MostrarAgotado, 0) = 0 THEN 1 ELSE
                CASE WHEN ISNULL(pf.CUV, 0) = 0 THEN 0 ELSE 1 END
            END
        END TieneSugerido
  ,CASE WHEN pcor.SAP IS NULL THEN 0 ELSE 1 END TieneOfertaRevista
  ,p.PrecioValorizado
  ,CASE WHEN pl.CodigoSAP IS NULL THEN 0 ELSE 1 END AS TieneLanzamientoCatalogoPersonalizado
  ,pcor.Oferta AS TipoOfertaRevista
  ,TE.Codigo AS TipoEstrategiaCodigo
  ,CASE WHEN (TE.MostrarImgOfertaIndependiente = 1 AND EST.EsOfertaIndependiente = 1) THEN 1 ELSE 0 END AS EsOfertaIndependiente
 FROM ods.ProductoComercial p WITH (NOLOCK)
 LEFT JOIN dbo.ProductoDescripcion pd WITH (NOLOCK)
  ON p.AnoCampania = pd.CampaniaID
  AND p.CUV = pd.CUV
 LEFT JOIN @ProductoFaltanteTemp pf
  ON p.CUV = pf.CUV
 LEFT JOIN ProductoComercialConfiguracion pcc WITH (NOLOCK)
  ON p.AnoCampania = pcc.CampaniaID
  AND p.CUV = pcc.CUV
 LEFT JOIN @OfertaProductoTemp op
  ON op.CampaniaID = P.CampaniaID
  AND op.CUV = P.CUV
 LEFT JOIN MatrizComercial mc WITH (NOLOCK)
  ON p.CodigoProducto = mc.CodigoSAP
 LEFT JOIN Estrategia EST WITH (NOLOCK)
  ON p.AnoCampania BETWEEN EST.CampaniaID AND CASE WHEN EST.CampaniaIDFin = 0 THEN EST.CampaniaID ELSE EST.CampaniaIDFin END
  AND (EST.CUV2 = p.CUV)
  AND EST.Activo = 1
 LEFT JOIN TipoEstrategia TE WITH (NOLOCK)
  ON TE.TipoEstrategiaID = EST.TipoEstrategiaID
 LEFT JOIN Marca M WITH (NOLOCK)
  ON p.MarcaId = M.MarcaId
 LEFT JOIN ods.ProductosLanzamiento pl WITH (NOLOCK)
  ON p.CodigoProducto = pl.CodigoSAP
  AND p.AnoCampania = pl.Campania
 LEFT JOIN ProductoComercialOfertaRevista pcor WITH (NOLOCK)
  ON p.AnoCampania = pcor.Campania
  AND p.CUV = pcor.CUV
 LEFT JOIN dbo.ProductoSugerido ps WITH (NOLOCK)
  ON p.AnoCampania = ps.CampaniaID
  AND p.CUV = ps.CUV
  AND ps.Estado = 1
 LEFT JOIN dbo.ProductoSugeridoPadre psp WITH (NOLOCK)
  ON p.AnoCampania = psp.CampaniaID AND p.CUV = psp.CUV
 WHERE p.AnoCampania = @CampaniaID
  AND p.IndicadorDigitable = 1
  AND CHARINDEX(@CodigoDescripcion, coalesce(est.descripcioncuv2, op.Descripcion, pd.Descripcion, p.Descripcion)) > 0
  AND NOT EXISTS (
   select ep.CUV
   from EstrategiaProducto ep WITH (NOLOCK)
   where ep.Campania = p.AnoCampania
    and ep.CUV = p.CUV
    and ep.CUV2 != p.CUV
    and NOT EXISTS (select tex.Codigo from TipoEstrategia tex where tex.TipoEstrategiaID = EST.TipoEstrategiaID and tex.Codigo = '011')
  )
END

GO
USE BelcorpEcuador
GO

ALTER PROCEDURE [dbo].GetProductoComercialByDescripcionByFilter
(
 @CampaniaID INT
 ,@RowCount INT
 ,@CodigoDescripcion VARCHAR(100)
 ,@RegionID INT
 ,@ZonaID INT
 ,@CodigoRegion VARCHAR(10)
 ,@CodigoZona VARCHAR(10)
)
AS
/*
exec dbo.GetProductoComercialByDescripcionByFilter 201808,5,'kalos',2701,2161,'50','5052'
exec dbo.GetProductoComercialByCampaniaBySearchRegionZona_sb2 201808,5,2,'kalos',2701,2161,'50','5052'
*/
BEGIN

 DECLARE @_RowCount INT = @RowCount
 DECLARE @CampaniaIDVarchar varchar(8) = cast(@CampaniaID as varchar(8))

 /*Creacion de tablas Temporales*/
 DECLARE @OfertaProductoTemp TABLE
 (
  CampaniaID INT
  ,CUV VARCHAR(6)
  ,Descripcion VARCHAR(250)
  ,ConfiguracionOfertaID INT
  ,TipoOfertaSisID INT
  ,PrecioOferta NUMERIC(12, 2)
 )

 DECLARE @ProductoFaltanteTemp TABLE (CUV VARCHAR(6))
 /*Fin creacion de tablas Temporales*/

 -- Oferta Producto
 INSERT INTO @OfertaProductoTemp
 SELECT
  op.CampaniaID
  ,op.CUV
  ,op.Descripcion
  ,op.ConfiguracionOfertaID
  ,op.TipoOfertaSisID
  ,NULL
 FROM OfertaProducto op WITH (NOLOCK)
 INNER JOIN ods.Campania c WITH (NOLOCK)
  ON op.CampaniaID = c.CampaniaID
 WHERE c.codigo = @CampaniaIDVarchar

 -- Producto Faltante
 INSERT INTO @ProductoFaltanteTemp
 SELECT DISTINCT ltrim(rtrim(CUV))
 FROM dbo.ProductoFaltante WITH (NOLOCK)
 WHERE CampaniaID = @CampaniaID
  AND Zonaid = @ZonaID
 UNION ALL
 SELECT DISTINCT ltrim(rtrim(fa.CodigoVenta)) AS CUV
 FROM ods.FaltanteAnunciado fa WITH (NOLOCK)
 INNER JOIN ods.Campania c WITH (NOLOCK)
  ON fa.CampaniaID = c.CampaniaID
 WHERE c.Codigo = @CampaniaIDVarchar
  AND ( rtrim(fa.CodigoRegion) = @CodigoRegion OR fa.CodigoRegion IS NULL )
  AND ( rtrim(fa.CodigoZona) = @CodigoZona OR fa.CodigoZona IS NULL )

 -- Select final
 SELECT DISTINCT TOP (@_RowCount)
  p.CUV
  ,coalesce(est.descripcioncuv2, op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion) AS Descripcion
  ,coalesce(est.precio2, op.PrecioOferta, pd.PrecioProducto * pd.FactorRepeticion, p.PrecioUnitario * p.FactorRepeticion) AS PrecioCatalogo
  ,p.MarcaID
  ,0 AS EstaEnRevista
  ,CASE WHEN ISNULL(pf.CUV, 0) = 0 THEN 1 ELSE 0 END AS TieneStock
  ,pcc.EsExpoOferta
  ,pcc.CUVRevista
  ,'' AS CUVComplemento
  ,p.PaisID
  ,p.AnoCampania AS CampaniaID
  ,p.CodigoCatalago
  ,p.CodigoProducto
  ,p.IndicadorMontoMinimo
  ,M.Descripcion AS DescripcionMarca
  ,'NO DISPONIBLE' AS DescripcionCategoria
  ,TE.DescripcionEstrategia AS DescripcionEstrategia
  ,op.ConfiguracionOfertaID
  ,op.TipoOfertaSisID
  ,te.flagNueva
  ,te.TipoEstrategiaID
  ,P.IndicadorOferta
  --,case when isnull(ps.CUV, 0) = 0 then 0 else 1 end as TieneSugerido
  ,CASE WHEN ISNULL(ps.CUV, 0) = 0 THEN 0 ELSE
            CASE WHEN ISNULL(psp.MostrarAgotado, 0) = 0 THEN 1 ELSE
                CASE WHEN ISNULL(pf.CUV, 0) = 0 THEN 0 ELSE 1 END
            END
        END TieneSugerido
  ,CASE WHEN pcor.SAP IS NULL THEN 0 ELSE 1 END TieneOfertaRevista
  ,p.PrecioValorizado
  ,CASE WHEN pl.CodigoSAP IS NULL THEN 0 ELSE 1 END AS TieneLanzamientoCatalogoPersonalizado
  ,pcor.Oferta AS TipoOfertaRevista
  ,TE.Codigo AS TipoEstrategiaCodigo
  ,CASE WHEN (TE.MostrarImgOfertaIndependiente = 1 AND EST.EsOfertaIndependiente = 1) THEN 1 ELSE 0 END AS EsOfertaIndependiente
 FROM ods.ProductoComercial p WITH (NOLOCK)
 LEFT JOIN dbo.ProductoDescripcion pd WITH (NOLOCK)
  ON p.AnoCampania = pd.CampaniaID
  AND p.CUV = pd.CUV
 LEFT JOIN @ProductoFaltanteTemp pf
  ON p.CUV = pf.CUV
 LEFT JOIN ProductoComercialConfiguracion pcc WITH (NOLOCK)
  ON p.AnoCampania = pcc.CampaniaID
  AND p.CUV = pcc.CUV
 LEFT JOIN @OfertaProductoTemp op
  ON op.CampaniaID = P.CampaniaID
  AND op.CUV = P.CUV
 LEFT JOIN MatrizComercial mc WITH (NOLOCK)
  ON p.CodigoProducto = mc.CodigoSAP
 LEFT JOIN Estrategia EST WITH (NOLOCK)
  ON p.AnoCampania BETWEEN EST.CampaniaID AND CASE WHEN EST.CampaniaIDFin = 0 THEN EST.CampaniaID ELSE EST.CampaniaIDFin END
  AND (EST.CUV2 = p.CUV)
  AND EST.Activo = 1
 LEFT JOIN TipoEstrategia TE WITH (NOLOCK)
  ON TE.TipoEstrategiaID = EST.TipoEstrategiaID
 LEFT JOIN Marca M WITH (NOLOCK)
  ON p.MarcaId = M.MarcaId
 LEFT JOIN ods.ProductosLanzamiento pl WITH (NOLOCK)
  ON p.CodigoProducto = pl.CodigoSAP
  AND p.AnoCampania = pl.Campania
 LEFT JOIN ProductoComercialOfertaRevista pcor WITH (NOLOCK)
  ON p.AnoCampania = pcor.Campania
  AND p.CUV = pcor.CUV
 LEFT JOIN dbo.ProductoSugerido ps WITH (NOLOCK)
  ON p.AnoCampania = ps.CampaniaID
  AND p.CUV = ps.CUV
  AND ps.Estado = 1
 LEFT JOIN dbo.ProductoSugeridoPadre psp WITH (NOLOCK)
  ON p.AnoCampania = psp.CampaniaID AND p.CUV = psp.CUV
 WHERE p.AnoCampania = @CampaniaID
  AND p.IndicadorDigitable = 1
  AND CHARINDEX(@CodigoDescripcion, coalesce(est.descripcioncuv2, op.Descripcion, pd.Descripcion, p.Descripcion)) > 0
  AND NOT EXISTS (
   select ep.CUV
   from EstrategiaProducto ep WITH (NOLOCK)
   where ep.Campania = p.AnoCampania
    and ep.CUV = p.CUV
    and ep.CUV2 != p.CUV
    and NOT EXISTS (select tex.Codigo from TipoEstrategia tex where tex.TipoEstrategiaID = EST.TipoEstrategiaID and tex.Codigo = '011')
  )
END

GO
USE BelcorpDominicana
GO

ALTER PROCEDURE [dbo].GetProductoComercialByDescripcionByFilter
(
 @CampaniaID INT
 ,@RowCount INT
 ,@CodigoDescripcion VARCHAR(100)
 ,@RegionID INT
 ,@ZonaID INT
 ,@CodigoRegion VARCHAR(10)
 ,@CodigoZona VARCHAR(10)
)
AS
/*
exec dbo.GetProductoComercialByDescripcionByFilter 201808,5,'kalos',2701,2161,'50','5052'
exec dbo.GetProductoComercialByCampaniaBySearchRegionZona_sb2 201808,5,2,'kalos',2701,2161,'50','5052'
*/
BEGIN

 DECLARE @_RowCount INT = @RowCount
 DECLARE @CampaniaIDVarchar varchar(8) = cast(@CampaniaID as varchar(8))

 /*Creacion de tablas Temporales*/
 DECLARE @OfertaProductoTemp TABLE
 (
  CampaniaID INT
  ,CUV VARCHAR(6)
  ,Descripcion VARCHAR(250)
  ,ConfiguracionOfertaID INT
  ,TipoOfertaSisID INT
  ,PrecioOferta NUMERIC(12, 2)
 )

 DECLARE @ProductoFaltanteTemp TABLE (CUV VARCHAR(6))
 /*Fin creacion de tablas Temporales*/

 -- Oferta Producto
 INSERT INTO @OfertaProductoTemp
 SELECT
  op.CampaniaID
  ,op.CUV
  ,op.Descripcion
  ,op.ConfiguracionOfertaID
  ,op.TipoOfertaSisID
  ,NULL
 FROM OfertaProducto op WITH (NOLOCK)
 INNER JOIN ods.Campania c WITH (NOLOCK)
  ON op.CampaniaID = c.CampaniaID
 WHERE c.codigo = @CampaniaIDVarchar

 -- Producto Faltante
 INSERT INTO @ProductoFaltanteTemp
 SELECT DISTINCT ltrim(rtrim(CUV))
 FROM dbo.ProductoFaltante WITH (NOLOCK)
 WHERE CampaniaID = @CampaniaID
  AND Zonaid = @ZonaID
 UNION ALL
 SELECT DISTINCT ltrim(rtrim(fa.CodigoVenta)) AS CUV
 FROM ods.FaltanteAnunciado fa WITH (NOLOCK)
 INNER JOIN ods.Campania c WITH (NOLOCK)
  ON fa.CampaniaID = c.CampaniaID
 WHERE c.Codigo = @CampaniaIDVarchar
  AND ( rtrim(fa.CodigoRegion) = @CodigoRegion OR fa.CodigoRegion IS NULL )
  AND ( rtrim(fa.CodigoZona) = @CodigoZona OR fa.CodigoZona IS NULL )

 -- Select final
 SELECT DISTINCT TOP (@_RowCount)
  p.CUV
  ,coalesce(est.descripcioncuv2, op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion) AS Descripcion
  ,coalesce(est.precio2, op.PrecioOferta, pd.PrecioProducto * pd.FactorRepeticion, p.PrecioUnitario * p.FactorRepeticion) AS PrecioCatalogo
  ,p.MarcaID
  ,0 AS EstaEnRevista
  ,CASE WHEN ISNULL(pf.CUV, 0) = 0 THEN 1 ELSE 0 END AS TieneStock
  ,pcc.EsExpoOferta
  ,pcc.CUVRevista
  ,'' AS CUVComplemento
  ,p.PaisID
  ,p.AnoCampania AS CampaniaID
  ,p.CodigoCatalago
  ,p.CodigoProducto
  ,p.IndicadorMontoMinimo
  ,M.Descripcion AS DescripcionMarca
  ,'NO DISPONIBLE' AS DescripcionCategoria
  ,TE.DescripcionEstrategia AS DescripcionEstrategia
  ,op.ConfiguracionOfertaID
  ,op.TipoOfertaSisID
  ,te.flagNueva
  ,te.TipoEstrategiaID
  ,P.IndicadorOferta
  --,case when isnull(ps.CUV, 0) = 0 then 0 else 1 end as TieneSugerido
  ,CASE WHEN ISNULL(ps.CUV, 0) = 0 THEN 0 ELSE
            CASE WHEN ISNULL(psp.MostrarAgotado, 0) = 0 THEN 1 ELSE
                CASE WHEN ISNULL(pf.CUV, 0) = 0 THEN 0 ELSE 1 END
            END
        END TieneSugerido
  ,CASE WHEN pcor.SAP IS NULL THEN 0 ELSE 1 END TieneOfertaRevista
  ,p.PrecioValorizado
  ,CASE WHEN pl.CodigoSAP IS NULL THEN 0 ELSE 1 END AS TieneLanzamientoCatalogoPersonalizado
  ,pcor.Oferta AS TipoOfertaRevista
  ,TE.Codigo AS TipoEstrategiaCodigo
  ,CASE WHEN (TE.MostrarImgOfertaIndependiente = 1 AND EST.EsOfertaIndependiente = 1) THEN 1 ELSE 0 END AS EsOfertaIndependiente
 FROM ods.ProductoComercial p WITH (NOLOCK)
 LEFT JOIN dbo.ProductoDescripcion pd WITH (NOLOCK)
  ON p.AnoCampania = pd.CampaniaID
  AND p.CUV = pd.CUV
 LEFT JOIN @ProductoFaltanteTemp pf
  ON p.CUV = pf.CUV
 LEFT JOIN ProductoComercialConfiguracion pcc WITH (NOLOCK)
  ON p.AnoCampania = pcc.CampaniaID
  AND p.CUV = pcc.CUV
 LEFT JOIN @OfertaProductoTemp op
  ON op.CampaniaID = P.CampaniaID
  AND op.CUV = P.CUV
 LEFT JOIN MatrizComercial mc WITH (NOLOCK)
  ON p.CodigoProducto = mc.CodigoSAP
 LEFT JOIN Estrategia EST WITH (NOLOCK)
  ON p.AnoCampania BETWEEN EST.CampaniaID AND CASE WHEN EST.CampaniaIDFin = 0 THEN EST.CampaniaID ELSE EST.CampaniaIDFin END
  AND (EST.CUV2 = p.CUV)
  AND EST.Activo = 1
 LEFT JOIN TipoEstrategia TE WITH (NOLOCK)
  ON TE.TipoEstrategiaID = EST.TipoEstrategiaID
 LEFT JOIN Marca M WITH (NOLOCK)
  ON p.MarcaId = M.MarcaId
 LEFT JOIN ods.ProductosLanzamiento pl WITH (NOLOCK)
  ON p.CodigoProducto = pl.CodigoSAP
  AND p.AnoCampania = pl.Campania
 LEFT JOIN ProductoComercialOfertaRevista pcor WITH (NOLOCK)
  ON p.AnoCampania = pcor.Campania
  AND p.CUV = pcor.CUV
 LEFT JOIN dbo.ProductoSugerido ps WITH (NOLOCK)
  ON p.AnoCampania = ps.CampaniaID
  AND p.CUV = ps.CUV
  AND ps.Estado = 1
 LEFT JOIN dbo.ProductoSugeridoPadre psp WITH (NOLOCK)
  ON p.AnoCampania = psp.CampaniaID AND p.CUV = psp.CUV
 WHERE p.AnoCampania = @CampaniaID
  AND p.IndicadorDigitable = 1
  AND CHARINDEX(@CodigoDescripcion, coalesce(est.descripcioncuv2, op.Descripcion, pd.Descripcion, p.Descripcion)) > 0
  AND NOT EXISTS (
   select ep.CUV
   from EstrategiaProducto ep WITH (NOLOCK)
   where ep.Campania = p.AnoCampania
    and ep.CUV = p.CUV
    and ep.CUV2 != p.CUV
    and NOT EXISTS (select tex.Codigo from TipoEstrategia tex where tex.TipoEstrategiaID = EST.TipoEstrategiaID and tex.Codigo = '011')
  )
END

GO
USE BelcorpCostaRica
GO

ALTER PROCEDURE [dbo].GetProductoComercialByDescripcionByFilter
(
 @CampaniaID INT
 ,@RowCount INT
 ,@CodigoDescripcion VARCHAR(100)
 ,@RegionID INT
 ,@ZonaID INT
 ,@CodigoRegion VARCHAR(10)
 ,@CodigoZona VARCHAR(10)
)
AS
/*
exec dbo.GetProductoComercialByDescripcionByFilter 201808,5,'kalos',2701,2161,'50','5052'
exec dbo.GetProductoComercialByCampaniaBySearchRegionZona_sb2 201808,5,2,'kalos',2701,2161,'50','5052'
*/
BEGIN

 DECLARE @_RowCount INT = @RowCount
 DECLARE @CampaniaIDVarchar varchar(8) = cast(@CampaniaID as varchar(8))

 /*Creacion de tablas Temporales*/
 DECLARE @OfertaProductoTemp TABLE
 (
  CampaniaID INT
  ,CUV VARCHAR(6)
  ,Descripcion VARCHAR(250)
  ,ConfiguracionOfertaID INT
  ,TipoOfertaSisID INT
  ,PrecioOferta NUMERIC(12, 2)
 )

 DECLARE @ProductoFaltanteTemp TABLE (CUV VARCHAR(6))
 /*Fin creacion de tablas Temporales*/

 -- Oferta Producto
 INSERT INTO @OfertaProductoTemp
 SELECT
  op.CampaniaID
  ,op.CUV
  ,op.Descripcion
  ,op.ConfiguracionOfertaID
  ,op.TipoOfertaSisID
  ,NULL
 FROM OfertaProducto op WITH (NOLOCK)
 INNER JOIN ods.Campania c WITH (NOLOCK)
  ON op.CampaniaID = c.CampaniaID
 WHERE c.codigo = @CampaniaIDVarchar

 -- Producto Faltante
 INSERT INTO @ProductoFaltanteTemp
 SELECT DISTINCT ltrim(rtrim(CUV))
 FROM dbo.ProductoFaltante WITH (NOLOCK)
 WHERE CampaniaID = @CampaniaID
  AND Zonaid = @ZonaID
 UNION ALL
 SELECT DISTINCT ltrim(rtrim(fa.CodigoVenta)) AS CUV
 FROM ods.FaltanteAnunciado fa WITH (NOLOCK)
 INNER JOIN ods.Campania c WITH (NOLOCK)
  ON fa.CampaniaID = c.CampaniaID
 WHERE c.Codigo = @CampaniaIDVarchar
  AND ( rtrim(fa.CodigoRegion) = @CodigoRegion OR fa.CodigoRegion IS NULL )
  AND ( rtrim(fa.CodigoZona) = @CodigoZona OR fa.CodigoZona IS NULL )

 -- Select final
 SELECT DISTINCT TOP (@_RowCount)
  p.CUV
  ,coalesce(est.descripcioncuv2, op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion) AS Descripcion
  ,coalesce(est.precio2, op.PrecioOferta, pd.PrecioProducto * pd.FactorRepeticion, p.PrecioUnitario * p.FactorRepeticion) AS PrecioCatalogo
  ,p.MarcaID
  ,0 AS EstaEnRevista
  ,CASE WHEN ISNULL(pf.CUV, 0) = 0 THEN 1 ELSE 0 END AS TieneStock
  ,pcc.EsExpoOferta
  ,pcc.CUVRevista
  ,'' AS CUVComplemento
  ,p.PaisID
  ,p.AnoCampania AS CampaniaID
  ,p.CodigoCatalago
  ,p.CodigoProducto
  ,p.IndicadorMontoMinimo
  ,M.Descripcion AS DescripcionMarca
  ,'NO DISPONIBLE' AS DescripcionCategoria
  ,TE.DescripcionEstrategia AS DescripcionEstrategia
  ,op.ConfiguracionOfertaID
  ,op.TipoOfertaSisID
  ,te.flagNueva
  ,te.TipoEstrategiaID
  ,P.IndicadorOferta
  --,case when isnull(ps.CUV, 0) = 0 then 0 else 1 end as TieneSugerido
  ,CASE WHEN ISNULL(ps.CUV, 0) = 0 THEN 0 ELSE
            CASE WHEN ISNULL(psp.MostrarAgotado, 0) = 0 THEN 1 ELSE
                CASE WHEN ISNULL(pf.CUV, 0) = 0 THEN 0 ELSE 1 END
            END
        END TieneSugerido
  ,CASE WHEN pcor.SAP IS NULL THEN 0 ELSE 1 END TieneOfertaRevista
  ,p.PrecioValorizado
  ,CASE WHEN pl.CodigoSAP IS NULL THEN 0 ELSE 1 END AS TieneLanzamientoCatalogoPersonalizado
  ,pcor.Oferta AS TipoOfertaRevista
  ,TE.Codigo AS TipoEstrategiaCodigo
  ,CASE WHEN (TE.MostrarImgOfertaIndependiente = 1 AND EST.EsOfertaIndependiente = 1) THEN 1 ELSE 0 END AS EsOfertaIndependiente
 FROM ods.ProductoComercial p WITH (NOLOCK)
 LEFT JOIN dbo.ProductoDescripcion pd WITH (NOLOCK)
  ON p.AnoCampania = pd.CampaniaID
  AND p.CUV = pd.CUV
 LEFT JOIN @ProductoFaltanteTemp pf
  ON p.CUV = pf.CUV
 LEFT JOIN ProductoComercialConfiguracion pcc WITH (NOLOCK)
  ON p.AnoCampania = pcc.CampaniaID
  AND p.CUV = pcc.CUV
 LEFT JOIN @OfertaProductoTemp op
  ON op.CampaniaID = P.CampaniaID
  AND op.CUV = P.CUV
 LEFT JOIN MatrizComercial mc WITH (NOLOCK)
  ON p.CodigoProducto = mc.CodigoSAP
 LEFT JOIN Estrategia EST WITH (NOLOCK)
  ON p.AnoCampania BETWEEN EST.CampaniaID AND CASE WHEN EST.CampaniaIDFin = 0 THEN EST.CampaniaID ELSE EST.CampaniaIDFin END
  AND (EST.CUV2 = p.CUV)
  AND EST.Activo = 1
 LEFT JOIN TipoEstrategia TE WITH (NOLOCK)
  ON TE.TipoEstrategiaID = EST.TipoEstrategiaID
 LEFT JOIN Marca M WITH (NOLOCK)
  ON p.MarcaId = M.MarcaId
 LEFT JOIN ods.ProductosLanzamiento pl WITH (NOLOCK)
  ON p.CodigoProducto = pl.CodigoSAP
  AND p.AnoCampania = pl.Campania
 LEFT JOIN ProductoComercialOfertaRevista pcor WITH (NOLOCK)
  ON p.AnoCampania = pcor.Campania
  AND p.CUV = pcor.CUV
 LEFT JOIN dbo.ProductoSugerido ps WITH (NOLOCK)
  ON p.AnoCampania = ps.CampaniaID
  AND p.CUV = ps.CUV
  AND ps.Estado = 1
 LEFT JOIN dbo.ProductoSugeridoPadre psp WITH (NOLOCK)
  ON p.AnoCampania = psp.CampaniaID AND p.CUV = psp.CUV
 WHERE p.AnoCampania = @CampaniaID
  AND p.IndicadorDigitable = 1
  AND CHARINDEX(@CodigoDescripcion, coalesce(est.descripcioncuv2, op.Descripcion, pd.Descripcion, p.Descripcion)) > 0
  AND NOT EXISTS (
   select ep.CUV
   from EstrategiaProducto ep WITH (NOLOCK)
   where ep.Campania = p.AnoCampania
    and ep.CUV = p.CUV
    and ep.CUV2 != p.CUV
    and NOT EXISTS (select tex.Codigo from TipoEstrategia tex where tex.TipoEstrategiaID = EST.TipoEstrategiaID and tex.Codigo = '011')
  )
END

GO
USE BelcorpChile
GO

ALTER PROCEDURE [dbo].GetProductoComercialByDescripcionByFilter
(
 @CampaniaID INT
 ,@RowCount INT
 ,@CodigoDescripcion VARCHAR(100)
 ,@RegionID INT
 ,@ZonaID INT
 ,@CodigoRegion VARCHAR(10)
 ,@CodigoZona VARCHAR(10)
)
AS
/*
exec dbo.GetProductoComercialByDescripcionByFilter 201808,5,'kalos',2701,2161,'50','5052'
exec dbo.GetProductoComercialByCampaniaBySearchRegionZona_sb2 201808,5,2,'kalos',2701,2161,'50','5052'
*/
BEGIN

 DECLARE @_RowCount INT = @RowCount
 DECLARE @CampaniaIDVarchar varchar(8) = cast(@CampaniaID as varchar(8))

 /*Creacion de tablas Temporales*/
 DECLARE @OfertaProductoTemp TABLE
 (
  CampaniaID INT
  ,CUV VARCHAR(6)
  ,Descripcion VARCHAR(250)
  ,ConfiguracionOfertaID INT
  ,TipoOfertaSisID INT
  ,PrecioOferta NUMERIC(12, 2)
 )

 DECLARE @ProductoFaltanteTemp TABLE (CUV VARCHAR(6))
 /*Fin creacion de tablas Temporales*/

 -- Oferta Producto
 INSERT INTO @OfertaProductoTemp
 SELECT
  op.CampaniaID
  ,op.CUV
  ,op.Descripcion
  ,op.ConfiguracionOfertaID
  ,op.TipoOfertaSisID
  ,NULL
 FROM OfertaProducto op WITH (NOLOCK)
 INNER JOIN ods.Campania c WITH (NOLOCK)
  ON op.CampaniaID = c.CampaniaID
 WHERE c.codigo = @CampaniaIDVarchar

 -- Producto Faltante
 INSERT INTO @ProductoFaltanteTemp
 SELECT DISTINCT ltrim(rtrim(CUV))
 FROM dbo.ProductoFaltante WITH (NOLOCK)
 WHERE CampaniaID = @CampaniaID
  AND Zonaid = @ZonaID
 UNION ALL
 SELECT DISTINCT ltrim(rtrim(fa.CodigoVenta)) AS CUV
 FROM ods.FaltanteAnunciado fa WITH (NOLOCK)
 INNER JOIN ods.Campania c WITH (NOLOCK)
  ON fa.CampaniaID = c.CampaniaID
 WHERE c.Codigo = @CampaniaIDVarchar
  AND ( rtrim(fa.CodigoRegion) = @CodigoRegion OR fa.CodigoRegion IS NULL )
  AND ( rtrim(fa.CodigoZona) = @CodigoZona OR fa.CodigoZona IS NULL )

 -- Select final
 SELECT DISTINCT TOP (@_RowCount)
  p.CUV
  ,coalesce(est.descripcioncuv2, op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion) AS Descripcion
  ,coalesce(est.precio2, op.PrecioOferta, pd.PrecioProducto * pd.FactorRepeticion, p.PrecioUnitario * p.FactorRepeticion) AS PrecioCatalogo
  ,p.MarcaID
  ,0 AS EstaEnRevista
  ,CASE WHEN ISNULL(pf.CUV, 0) = 0 THEN 1 ELSE 0 END AS TieneStock
  ,pcc.EsExpoOferta
  ,pcc.CUVRevista
  ,'' AS CUVComplemento
  ,p.PaisID
  ,p.AnoCampania AS CampaniaID
  ,p.CodigoCatalago
  ,p.CodigoProducto
  ,p.IndicadorMontoMinimo
  ,M.Descripcion AS DescripcionMarca
  ,'NO DISPONIBLE' AS DescripcionCategoria
  ,TE.DescripcionEstrategia AS DescripcionEstrategia
  ,op.ConfiguracionOfertaID
  ,op.TipoOfertaSisID
  ,te.flagNueva
  ,te.TipoEstrategiaID
  ,P.IndicadorOferta
  --,case when isnull(ps.CUV, 0) = 0 then 0 else 1 end as TieneSugerido
  ,CASE WHEN ISNULL(ps.CUV, 0) = 0 THEN 0 ELSE
            CASE WHEN ISNULL(psp.MostrarAgotado, 0) = 0 THEN 1 ELSE
                CASE WHEN ISNULL(pf.CUV, 0) = 0 THEN 0 ELSE 1 END
            END
        END TieneSugerido
  ,CASE WHEN pcor.SAP IS NULL THEN 0 ELSE 1 END TieneOfertaRevista
  ,p.PrecioValorizado
  ,CASE WHEN pl.CodigoSAP IS NULL THEN 0 ELSE 1 END AS TieneLanzamientoCatalogoPersonalizado
  ,pcor.Oferta AS TipoOfertaRevista
  ,TE.Codigo AS TipoEstrategiaCodigo
  ,CASE WHEN (TE.MostrarImgOfertaIndependiente = 1 AND EST.EsOfertaIndependiente = 1) THEN 1 ELSE 0 END AS EsOfertaIndependiente
 FROM ods.ProductoComercial p WITH (NOLOCK)
 LEFT JOIN dbo.ProductoDescripcion pd WITH (NOLOCK)
  ON p.AnoCampania = pd.CampaniaID
  AND p.CUV = pd.CUV
 LEFT JOIN @ProductoFaltanteTemp pf
  ON p.CUV = pf.CUV
 LEFT JOIN ProductoComercialConfiguracion pcc WITH (NOLOCK)
  ON p.AnoCampania = pcc.CampaniaID
  AND p.CUV = pcc.CUV
 LEFT JOIN @OfertaProductoTemp op
  ON op.CampaniaID = P.CampaniaID
  AND op.CUV = P.CUV
 LEFT JOIN MatrizComercial mc WITH (NOLOCK)
  ON p.CodigoProducto = mc.CodigoSAP
 LEFT JOIN Estrategia EST WITH (NOLOCK)
  ON p.AnoCampania BETWEEN EST.CampaniaID AND CASE WHEN EST.CampaniaIDFin = 0 THEN EST.CampaniaID ELSE EST.CampaniaIDFin END
  AND (EST.CUV2 = p.CUV)
  AND EST.Activo = 1
 LEFT JOIN TipoEstrategia TE WITH (NOLOCK)
  ON TE.TipoEstrategiaID = EST.TipoEstrategiaID
 LEFT JOIN Marca M WITH (NOLOCK)
  ON p.MarcaId = M.MarcaId
 LEFT JOIN ods.ProductosLanzamiento pl WITH (NOLOCK)
  ON p.CodigoProducto = pl.CodigoSAP
  AND p.AnoCampania = pl.Campania
 LEFT JOIN ProductoComercialOfertaRevista pcor WITH (NOLOCK)
  ON p.AnoCampania = pcor.Campania
  AND p.CUV = pcor.CUV
 LEFT JOIN dbo.ProductoSugerido ps WITH (NOLOCK)
  ON p.AnoCampania = ps.CampaniaID
  AND p.CUV = ps.CUV
  AND ps.Estado = 1
 LEFT JOIN dbo.ProductoSugeridoPadre psp WITH (NOLOCK)
  ON p.AnoCampania = psp.CampaniaID AND p.CUV = psp.CUV
 WHERE p.AnoCampania = @CampaniaID
  AND p.IndicadorDigitable = 1
  AND CHARINDEX(@CodigoDescripcion, coalesce(est.descripcioncuv2, op.Descripcion, pd.Descripcion, p.Descripcion)) > 0
  AND NOT EXISTS (
   select ep.CUV
   from EstrategiaProducto ep WITH (NOLOCK)
   where ep.Campania = p.AnoCampania
    and ep.CUV = p.CUV
    and ep.CUV2 != p.CUV
    and NOT EXISTS (select tex.Codigo from TipoEstrategia tex where tex.TipoEstrategiaID = EST.TipoEstrategiaID and tex.Codigo = '011')
  )
END

GO
USE BelcorpBolivia
GO

ALTER PROCEDURE [dbo].GetProductoComercialByDescripcionByFilter
(
 @CampaniaID INT
 ,@RowCount INT
 ,@CodigoDescripcion VARCHAR(100)
 ,@RegionID INT
 ,@ZonaID INT
 ,@CodigoRegion VARCHAR(10)
 ,@CodigoZona VARCHAR(10)
)
AS
/*
exec dbo.GetProductoComercialByDescripcionByFilter 201808,5,'kalos',2701,2161,'50','5052'
exec dbo.GetProductoComercialByCampaniaBySearchRegionZona_sb2 201808,5,2,'kalos',2701,2161,'50','5052'
*/
BEGIN

 DECLARE @_RowCount INT = @RowCount
 DECLARE @CampaniaIDVarchar varchar(8) = cast(@CampaniaID as varchar(8))

 /*Creacion de tablas Temporales*/
 DECLARE @OfertaProductoTemp TABLE
 (
  CampaniaID INT
  ,CUV VARCHAR(6)
  ,Descripcion VARCHAR(250)
  ,ConfiguracionOfertaID INT
  ,TipoOfertaSisID INT
  ,PrecioOferta NUMERIC(12, 2)
 )

 DECLARE @ProductoFaltanteTemp TABLE (CUV VARCHAR(6))
 /*Fin creacion de tablas Temporales*/

 -- Oferta Producto
 INSERT INTO @OfertaProductoTemp
 SELECT
  op.CampaniaID
  ,op.CUV
  ,op.Descripcion
  ,op.ConfiguracionOfertaID
  ,op.TipoOfertaSisID
  ,NULL
 FROM OfertaProducto op WITH (NOLOCK)
 INNER JOIN ods.Campania c WITH (NOLOCK)
  ON op.CampaniaID = c.CampaniaID
 WHERE c.codigo = @CampaniaIDVarchar

 -- Producto Faltante
 INSERT INTO @ProductoFaltanteTemp
 SELECT DISTINCT ltrim(rtrim(CUV))
 FROM dbo.ProductoFaltante WITH (NOLOCK)
 WHERE CampaniaID = @CampaniaID
  AND Zonaid = @ZonaID
 UNION ALL
 SELECT DISTINCT ltrim(rtrim(fa.CodigoVenta)) AS CUV
 FROM ods.FaltanteAnunciado fa WITH (NOLOCK)
 INNER JOIN ods.Campania c WITH (NOLOCK)
  ON fa.CampaniaID = c.CampaniaID
 WHERE c.Codigo = @CampaniaIDVarchar
  AND ( rtrim(fa.CodigoRegion) = @CodigoRegion OR fa.CodigoRegion IS NULL )
  AND ( rtrim(fa.CodigoZona) = @CodigoZona OR fa.CodigoZona IS NULL )

 -- Select final
 SELECT DISTINCT TOP (@_RowCount)
  p.CUV
  ,coalesce(est.descripcioncuv2, op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion) AS Descripcion
  ,coalesce(est.precio2, op.PrecioOferta, pd.PrecioProducto * pd.FactorRepeticion, p.PrecioUnitario * p.FactorRepeticion) AS PrecioCatalogo
  ,p.MarcaID
  ,0 AS EstaEnRevista
  ,CASE WHEN ISNULL(pf.CUV, 0) = 0 THEN 1 ELSE 0 END AS TieneStock
  ,pcc.EsExpoOferta
  ,pcc.CUVRevista
  ,'' AS CUVComplemento
  ,p.PaisID
  ,p.AnoCampania AS CampaniaID
  ,p.CodigoCatalago
  ,p.CodigoProducto
  ,p.IndicadorMontoMinimo
  ,M.Descripcion AS DescripcionMarca
  ,'NO DISPONIBLE' AS DescripcionCategoria
  ,TE.DescripcionEstrategia AS DescripcionEstrategia
  ,op.ConfiguracionOfertaID
  ,op.TipoOfertaSisID
  ,te.flagNueva
  ,te.TipoEstrategiaID
  ,P.IndicadorOferta
  --,case when isnull(ps.CUV, 0) = 0 then 0 else 1 end as TieneSugerido
  ,CASE WHEN ISNULL(ps.CUV, 0) = 0 THEN 0 ELSE
            CASE WHEN ISNULL(psp.MostrarAgotado, 0) = 0 THEN 1 ELSE
                CASE WHEN ISNULL(pf.CUV, 0) = 0 THEN 0 ELSE 1 END
            END
        END TieneSugerido
  ,CASE WHEN pcor.SAP IS NULL THEN 0 ELSE 1 END TieneOfertaRevista
  ,p.PrecioValorizado
  ,CASE WHEN pl.CodigoSAP IS NULL THEN 0 ELSE 1 END AS TieneLanzamientoCatalogoPersonalizado
  ,pcor.Oferta AS TipoOfertaRevista
  ,TE.Codigo AS TipoEstrategiaCodigo
  ,CASE WHEN (TE.MostrarImgOfertaIndependiente = 1 AND EST.EsOfertaIndependiente = 1) THEN 1 ELSE 0 END AS EsOfertaIndependiente
 FROM ods.ProductoComercial p WITH (NOLOCK)
 LEFT JOIN dbo.ProductoDescripcion pd WITH (NOLOCK)
  ON p.AnoCampania = pd.CampaniaID
  AND p.CUV = pd.CUV
 LEFT JOIN @ProductoFaltanteTemp pf
  ON p.CUV = pf.CUV
 LEFT JOIN ProductoComercialConfiguracion pcc WITH (NOLOCK)
  ON p.AnoCampania = pcc.CampaniaID
  AND p.CUV = pcc.CUV
 LEFT JOIN @OfertaProductoTemp op
  ON op.CampaniaID = P.CampaniaID
  AND op.CUV = P.CUV
 LEFT JOIN MatrizComercial mc WITH (NOLOCK)
  ON p.CodigoProducto = mc.CodigoSAP
 LEFT JOIN Estrategia EST WITH (NOLOCK)
  ON p.AnoCampania BETWEEN EST.CampaniaID AND CASE WHEN EST.CampaniaIDFin = 0 THEN EST.CampaniaID ELSE EST.CampaniaIDFin END
  AND (EST.CUV2 = p.CUV)
  AND EST.Activo = 1
 LEFT JOIN TipoEstrategia TE WITH (NOLOCK)
  ON TE.TipoEstrategiaID = EST.TipoEstrategiaID
 LEFT JOIN Marca M WITH (NOLOCK)
  ON p.MarcaId = M.MarcaId
 LEFT JOIN ods.ProductosLanzamiento pl WITH (NOLOCK)
  ON p.CodigoProducto = pl.CodigoSAP
  AND p.AnoCampania = pl.Campania
 LEFT JOIN ProductoComercialOfertaRevista pcor WITH (NOLOCK)
  ON p.AnoCampania = pcor.Campania
  AND p.CUV = pcor.CUV
 LEFT JOIN dbo.ProductoSugerido ps WITH (NOLOCK)
  ON p.AnoCampania = ps.CampaniaID
  AND p.CUV = ps.CUV
  AND ps.Estado = 1
 LEFT JOIN dbo.ProductoSugeridoPadre psp WITH (NOLOCK)
  ON p.AnoCampania = psp.CampaniaID AND p.CUV = psp.CUV
 WHERE p.AnoCampania = @CampaniaID
  AND p.IndicadorDigitable = 1
  AND CHARINDEX(@CodigoDescripcion, coalesce(est.descripcioncuv2, op.Descripcion, pd.Descripcion, p.Descripcion)) > 0
  AND NOT EXISTS (
   select ep.CUV
   from EstrategiaProducto ep WITH (NOLOCK)
   where ep.Campania = p.AnoCampania
    and ep.CUV = p.CUV
    and ep.CUV2 != p.CUV
    and NOT EXISTS (select tex.Codigo from TipoEstrategia tex where tex.TipoEstrategiaID = EST.TipoEstrategiaID and tex.Codigo = '011')
  )
END

GO
