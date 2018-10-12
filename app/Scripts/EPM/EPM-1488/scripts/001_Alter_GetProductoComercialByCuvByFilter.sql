USE BelcorpPeru
GO
IF (OBJECT_ID ( 'dbo.GetProductoComercialByCuvByFilter', 'P' ) IS NULL)
EXEC('CREATE PROCEDURE dbo.GetProductoComercialByCuvByFilter AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE [dbo].GetProductoComercialByCuvByFilter
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
exec dbo.GetProductoComercialByCuvByFilter 201810,1,'11481',2009,2261,'91','9011'  
exec dbo.GetProductoComercialByCampaniaBySearchRegionZona_sb2 201808,1,1,'32072',2701,2161,'50','5052'  
*/  
BEGIN  
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
 DECLARE @ProductoSugeridoTemp TABLE (CUV varchar(6))  
 DECLARE @Producto TABLE  
 (  
  CUV varchar(50),  
  Descripcion varchar(250),  
  PrecioCatalogo numeric(12,2),  
  MarcaID int,  
  CUVProductoFaltante varchar(50),  
  EsExpoOferta bit,  
  CUVRevista varchar(20),  
  PaisID int,  
  CampaniaID int,  
  CodigoCatalago char(6),  
  CodigoProducto varchar(12),  
  IndicadorMontoMinimo int,  
  DescripcionMarca varchar(20),  
  ConfiguracionOfertaID int,  
  TipoOfertaSisID int,  
  IndicadorOferta bit,  
  SAPProductoComercialOfertaRevista varchar(50),  
  PrecioValorizado numeric(12,2),  
  CodigoSAPProductosLanzamiento bit,  
  TipoOfertaRevista varchar(20)  
 )  
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
 WHERE  
  c.codigo = @CampaniaID  
  and CHARINDEX(@CodigoDescripcion,op.CUV)>0  
  
 -- Producto Faltante  
 INSERT INTO @ProductoFaltanteTemp  
 SELECT DISTINCT  
  CUV  
 FROM dbo.ProductoFaltante WITH (NOLOCK)  
 WHERE  
  CampaniaID = @CampaniaID  
  AND Zonaid = @ZonaID  
  AND CHARINDEX(@CodigoDescripcion,CUV)>0  
 UNION ALL  
 SELECT DISTINCT  
  ltrim(rtrim(fa.CodigoVenta)) AS CUV  
 FROM ods.FaltanteAnunciado fa WITH (NOLOCK)  
 INNER JOIN ods.Campania c WITH (NOLOCK)  
  ON fa.CampaniaID = c.CampaniaID  
 WHERE c.Codigo = @CampaniaID  
  and CHARINDEX(@CodigoDescripcion,rtrim(fa.CodigoVenta))>0  
  AND ( rtrim(fa.CodigoRegion) = @CodigoRegion OR fa.CodigoRegion IS NULL )  
  AND ( rtrim(fa.CodigoZona) = @CodigoZona OR fa.CodigoZona IS NULL )  
  
 -- Producto Sugerido  
 insert into @ProductoSugeridoTemp  
 select CUV  
 from dbo.ProductoSugerido WITH (NOLOCK)  
 where  
  CampaniaID = @CampaniaID  
  and CHARINDEX(@CodigoDescripcion,CUV)>0  
  and Estado = 1  
  
 -- Producto Comercial  
 insert into @Producto  
 SELECT DISTINCT TOP (@RowCount)  
  p.CUV  
  ,coalesce(op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion) AS Descripcion  
  ,coalesce(op.PrecioOferta, pd.PrecioProducto * pd.FactorRepeticion, p.PrecioUnitario * p.FactorRepeticion) AS PrecioCatalogo  
  ,p.MarcaID  
  ,pf.CUV  
  ,pcc.EsExpoOferta  
  ,pcc.CUVRevista  
  ,p.PaisID  
  ,p.AnoCampania AS CampaniaID  
  ,p.CodigoCatalago  
  ,p.CodigoProducto  
  ,p.IndicadorMontoMinimo  
  ,M.Descripcion AS DescripcionMarca  
  ,op.ConfiguracionOfertaID  
  ,op.TipoOfertaSisID  
  ,P.IndicadorOferta  
  ,pcor.SAP  
  ,p.PrecioValorizado  
  ,pl.CodigoSAP  
  ,pcor.Oferta  
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
 LEFT JOIN Marca M WITH (NOLOCK)  
  ON p.MarcaId = M.MarcaId  
 LEFT JOIN ods.ProductosLanzamiento pl WITH (NOLOCK)  
  ON p.CodigoProducto = pl.CodigoSAP  
  AND p.AnoCampania = pl.Campania  
 LEFT JOIN ProductoComercialOfertaRevista pcor WITH (NOLOCK)  
  ON p.AnoCampania = pcor.Campania  
  AND p.CUV = pcor.CUV  
 WHERE  
  p.AnoCampania = @CampaniaID  
  AND p.IndicadorDigitable = 1  
  AND CHARINDEX(@CodigoDescripcion, p.CUV) > 0  
  
 -- Select final  
 select distinct top (@RowCount)  
  p.CUV,  
  coalesce(e.DescripcionCUV2, p.Descripcion) as Descripcion,  
  coalesce(e.Precio2, p.PrecioCatalogo) as PrecioCatalogo,  
  p.MarcaID,  
  0 AS EstaEnRevista,  
  case when isnull(p.CUVProductoFaltante,0) = 0 then 1 else 0 end as TieneStock,  
  p.EsExpoOferta as EsExpoOferta,  
  p.CUVRevista as CUVRevista,  
  '' AS CUVComplemento,  
  p.PaisID,  
  p.CampaniaID,  
  p.CodigoCatalago,  
  p.CodigoProducto,  
  p.IndicadorMontoMinimo,  
  p.DescripcionMarca,  
  'NO DISPONIBLE' AS DescripcionCategoria,  
  te.DescripcionEstrategia,  
  p.ConfiguracionOfertaID as ConfiguracionOfertaID,  
  p.TipoOfertaSisID as TipoOfertaSisID,  
  te.flagNueva as FlagNueva,  
  e.EstrategiaID as EstrategiaID,
  e.codigoEstrategia as CodigoEstrategia,
  te.TipoEstrategiaID as TipoEstrategiaID,  
  p.IndicadorOferta,  
  --case when pst.CUV is null then 0 else 1 end as TieneSugerido,  
  CASE WHEN ISNULL(pst.CUV, 0) = 0 THEN 0 ELSE  
            CASE WHEN ISNULL(psp.MostrarAgotado, 0) = 0 THEN 1 ELSE  
                CASE WHEN isnull(p.CUVProductoFaltante,0) = 0 THEN 0 ELSE 1 END  
            END  
        END TieneSugerido,  
  case when p.SAPProductoComercialOfertaRevista is null then 0 else 1 end as TieneOfertaRevista,  
  p.PrecioValorizado,  
  case when p.CodigoSAPProductosLanzamiento is null then 0 else 1 end as TieneLanzamientoCatalogoPersonalizado,  
  p.TipoOfertaRevista as TipoOfertaRevista,  
  te.Codigo as TipoEstrategiaCodigo,  
  case when te.MostrarImgOfertaIndependiente = 1 and e.EsOfertaIndependiente = 1 then 1 else 0 end as EsOfertaIndependiente  
 from @Producto p  
 left join Estrategia e WITH (NOLOCK)  
  on p.CampaniaID BETWEEN e.CampaniaID AND CASE WHEN e.CampaniaIDFin = 0 THEN e.CampaniaID ELSE e.CampaniaIDFin END  
  AND e.CUV2 = p.CUV  
  AND e.Activo = 1  
 left join TipoEstrategia te WITH (NOLOCK)  
  ON te.TipoEstrategiaID = e.TipoEstrategiaID  
  and te.FlagActivo = 1  
 LEFT JOIN @ProductoSugeridoTemp pst on  
  p.CUV = pst.CUV  
 LEFT JOIN ProductoSugeridoPadre psp WITH (NOLOCK) ON p.CUV = psp.CUV and p.CampaniaID = psp.CampaniaID  
 where NOT EXISTS (  
  select ep.CUV  
  from EstrategiaProducto ep WITH (NOLOCK)  
  where ep.Campania = p.CampaniaID  
   and ep.CUV = p.CUV  
   and ep.CUV2 != p.CUV  
   and NOT EXISTS (select tex.Codigo from TipoEstrategia tex where tex.TipoEstrategiaID = e.TipoEstrategiaID and tex.Codigo = '011')  
 )  
  
END  
GO

USE BelcorpMexico
GO

IF (OBJECT_ID ( 'dbo.GetProductoComercialByCuvByFilter', 'P' ) IS NULL)
EXEC('CREATE PROCEDURE dbo.GetProductoComercialByCuvByFilter AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE [dbo].GetProductoComercialByCuvByFilter
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
exec dbo.GetProductoComercialByCuvByFilter 201810,1,'11481',2009,2261,'91','9011'  
exec dbo.GetProductoComercialByCampaniaBySearchRegionZona_sb2 201808,1,1,'32072',2701,2161,'50','5052'  
*/  
BEGIN  
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
 DECLARE @ProductoSugeridoTemp TABLE (CUV varchar(6))  
 DECLARE @Producto TABLE  
 (  
  CUV varchar(50),  
  Descripcion varchar(250),  
  PrecioCatalogo numeric(12,2),  
  MarcaID int,  
  CUVProductoFaltante varchar(50),  
  EsExpoOferta bit,  
  CUVRevista varchar(20),  
  PaisID int,  
  CampaniaID int,  
  CodigoCatalago char(6),  
  CodigoProducto varchar(12),  
  IndicadorMontoMinimo int,  
  DescripcionMarca varchar(20),  
  ConfiguracionOfertaID int,  
  TipoOfertaSisID int,  
  IndicadorOferta bit,  
  SAPProductoComercialOfertaRevista varchar(50),  
  PrecioValorizado numeric(12,2),  
  CodigoSAPProductosLanzamiento bit,  
  TipoOfertaRevista varchar(20)  
 )  
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
 WHERE  
  c.codigo = @CampaniaID  
  and CHARINDEX(@CodigoDescripcion,op.CUV)>0  
  
 -- Producto Faltante  
 INSERT INTO @ProductoFaltanteTemp  
 SELECT DISTINCT  
  CUV  
 FROM dbo.ProductoFaltante WITH (NOLOCK)  
 WHERE  
  CampaniaID = @CampaniaID  
  AND Zonaid = @ZonaID  
  AND CHARINDEX(@CodigoDescripcion,CUV)>0  
 UNION ALL  
 SELECT DISTINCT  
  ltrim(rtrim(fa.CodigoVenta)) AS CUV  
 FROM ods.FaltanteAnunciado fa WITH (NOLOCK)  
 INNER JOIN ods.Campania c WITH (NOLOCK)  
  ON fa.CampaniaID = c.CampaniaID  
 WHERE c.Codigo = @CampaniaID  
  and CHARINDEX(@CodigoDescripcion,rtrim(fa.CodigoVenta))>0  
  AND ( rtrim(fa.CodigoRegion) = @CodigoRegion OR fa.CodigoRegion IS NULL )  
  AND ( rtrim(fa.CodigoZona) = @CodigoZona OR fa.CodigoZona IS NULL )  
  
 -- Producto Sugerido  
 insert into @ProductoSugeridoTemp  
 select CUV  
 from dbo.ProductoSugerido WITH (NOLOCK)  
 where  
  CampaniaID = @CampaniaID  
  and CHARINDEX(@CodigoDescripcion,CUV)>0  
  and Estado = 1  
  
 -- Producto Comercial  
 insert into @Producto  
 SELECT DISTINCT TOP (@RowCount)  
  p.CUV  
  ,coalesce(op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion) AS Descripcion  
  ,coalesce(op.PrecioOferta, pd.PrecioProducto * pd.FactorRepeticion, p.PrecioUnitario * p.FactorRepeticion) AS PrecioCatalogo  
  ,p.MarcaID  
  ,pf.CUV  
  ,pcc.EsExpoOferta  
  ,pcc.CUVRevista  
  ,p.PaisID  
  ,p.AnoCampania AS CampaniaID  
  ,p.CodigoCatalago  
  ,p.CodigoProducto  
  ,p.IndicadorMontoMinimo  
  ,M.Descripcion AS DescripcionMarca  
  ,op.ConfiguracionOfertaID  
  ,op.TipoOfertaSisID  
  ,P.IndicadorOferta  
  ,pcor.SAP  
  ,p.PrecioValorizado  
  ,pl.CodigoSAP  
  ,pcor.Oferta  
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
 LEFT JOIN Marca M WITH (NOLOCK)  
  ON p.MarcaId = M.MarcaId  
 LEFT JOIN ods.ProductosLanzamiento pl WITH (NOLOCK)  
  ON p.CodigoProducto = pl.CodigoSAP  
  AND p.AnoCampania = pl.Campania  
 LEFT JOIN ProductoComercialOfertaRevista pcor WITH (NOLOCK)  
  ON p.AnoCampania = pcor.Campania  
  AND p.CUV = pcor.CUV  
 WHERE  
  p.AnoCampania = @CampaniaID  
  AND p.IndicadorDigitable = 1  
  AND CHARINDEX(@CodigoDescripcion, p.CUV) > 0  
  
 -- Select final  
 select distinct top (@RowCount)  
  p.CUV,  
  coalesce(e.DescripcionCUV2, p.Descripcion) as Descripcion,  
  coalesce(e.Precio2, p.PrecioCatalogo) as PrecioCatalogo,  
  p.MarcaID,  
  0 AS EstaEnRevista,  
  case when isnull(p.CUVProductoFaltante,0) = 0 then 1 else 0 end as TieneStock,  
  p.EsExpoOferta as EsExpoOferta,  
  p.CUVRevista as CUVRevista,  
  '' AS CUVComplemento,  
  p.PaisID,  
  p.CampaniaID,  
  p.CodigoCatalago,  
  p.CodigoProducto,  
  p.IndicadorMontoMinimo,  
  p.DescripcionMarca,  
  'NO DISPONIBLE' AS DescripcionCategoria,  
  te.DescripcionEstrategia,  
  p.ConfiguracionOfertaID as ConfiguracionOfertaID,  
  p.TipoOfertaSisID as TipoOfertaSisID,  
  te.flagNueva as FlagNueva,  
  e.EstrategiaID as EstrategiaID,
  e.codigoEstrategia as CodigoEstrategia,
  te.TipoEstrategiaID as TipoEstrategiaID,  
  p.IndicadorOferta,  
  --case when pst.CUV is null then 0 else 1 end as TieneSugerido,  
  CASE WHEN ISNULL(pst.CUV, 0) = 0 THEN 0 ELSE  
            CASE WHEN ISNULL(psp.MostrarAgotado, 0) = 0 THEN 1 ELSE  
                CASE WHEN isnull(p.CUVProductoFaltante,0) = 0 THEN 0 ELSE 1 END  
            END  
        END TieneSugerido,  
  case when p.SAPProductoComercialOfertaRevista is null then 0 else 1 end as TieneOfertaRevista,  
  p.PrecioValorizado,  
  case when p.CodigoSAPProductosLanzamiento is null then 0 else 1 end as TieneLanzamientoCatalogoPersonalizado,  
  p.TipoOfertaRevista as TipoOfertaRevista,  
  te.Codigo as TipoEstrategiaCodigo,  
  case when te.MostrarImgOfertaIndependiente = 1 and e.EsOfertaIndependiente = 1 then 1 else 0 end as EsOfertaIndependiente  
 from @Producto p  
 left join Estrategia e WITH (NOLOCK)  
  on p.CampaniaID BETWEEN e.CampaniaID AND CASE WHEN e.CampaniaIDFin = 0 THEN e.CampaniaID ELSE e.CampaniaIDFin END  
  AND e.CUV2 = p.CUV  
  AND e.Activo = 1  
 left join TipoEstrategia te WITH (NOLOCK)  
  ON te.TipoEstrategiaID = e.TipoEstrategiaID  
  and te.FlagActivo = 1  
 LEFT JOIN @ProductoSugeridoTemp pst on  
  p.CUV = pst.CUV  
 LEFT JOIN ProductoSugeridoPadre psp WITH (NOLOCK) ON p.CUV = psp.CUV and p.CampaniaID = psp.CampaniaID  
 where NOT EXISTS (  
  select ep.CUV  
  from EstrategiaProducto ep WITH (NOLOCK)  
  where ep.Campania = p.CampaniaID  
   and ep.CUV = p.CUV  
   and ep.CUV2 != p.CUV  
   and NOT EXISTS (select tex.Codigo from TipoEstrategia tex where tex.TipoEstrategiaID = e.TipoEstrategiaID and tex.Codigo = '011')  
 )  
  
END  
GO

USE BelcorpColombia
GO

IF (OBJECT_ID ( 'dbo.GetProductoComercialByCuvByFilter', 'P' ) IS NULL)
EXEC('CREATE PROCEDURE dbo.GetProductoComercialByCuvByFilter AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE [dbo].GetProductoComercialByCuvByFilter
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
exec dbo.GetProductoComercialByCuvByFilter 201810,1,'11481',2009,2261,'91','9011'  
exec dbo.GetProductoComercialByCampaniaBySearchRegionZona_sb2 201808,1,1,'32072',2701,2161,'50','5052'  
*/  
BEGIN  
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
 DECLARE @ProductoSugeridoTemp TABLE (CUV varchar(6))  
 DECLARE @Producto TABLE  
 (  
  CUV varchar(50),  
  Descripcion varchar(250),  
  PrecioCatalogo numeric(12,2),  
  MarcaID int,  
  CUVProductoFaltante varchar(50),  
  EsExpoOferta bit,  
  CUVRevista varchar(20),  
  PaisID int,  
  CampaniaID int,  
  CodigoCatalago char(6),  
  CodigoProducto varchar(12),  
  IndicadorMontoMinimo int,  
  DescripcionMarca varchar(20),  
  ConfiguracionOfertaID int,  
  TipoOfertaSisID int,  
  IndicadorOferta bit,  
  SAPProductoComercialOfertaRevista varchar(50),  
  PrecioValorizado numeric(12,2),  
  CodigoSAPProductosLanzamiento bit,  
  TipoOfertaRevista varchar(20)  
 )  
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
 WHERE  
  c.codigo = @CampaniaID  
  and CHARINDEX(@CodigoDescripcion,op.CUV)>0  
  
 -- Producto Faltante  
 INSERT INTO @ProductoFaltanteTemp  
 SELECT DISTINCT  
  CUV  
 FROM dbo.ProductoFaltante WITH (NOLOCK)  
 WHERE  
  CampaniaID = @CampaniaID  
  AND Zonaid = @ZonaID  
  AND CHARINDEX(@CodigoDescripcion,CUV)>0  
 UNION ALL  
 SELECT DISTINCT  
  ltrim(rtrim(fa.CodigoVenta)) AS CUV  
 FROM ods.FaltanteAnunciado fa WITH (NOLOCK)  
 INNER JOIN ods.Campania c WITH (NOLOCK)  
  ON fa.CampaniaID = c.CampaniaID  
 WHERE c.Codigo = @CampaniaID  
  and CHARINDEX(@CodigoDescripcion,rtrim(fa.CodigoVenta))>0  
  AND ( rtrim(fa.CodigoRegion) = @CodigoRegion OR fa.CodigoRegion IS NULL )  
  AND ( rtrim(fa.CodigoZona) = @CodigoZona OR fa.CodigoZona IS NULL )  
  
 -- Producto Sugerido  
 insert into @ProductoSugeridoTemp  
 select CUV  
 from dbo.ProductoSugerido WITH (NOLOCK)  
 where  
  CampaniaID = @CampaniaID  
  and CHARINDEX(@CodigoDescripcion,CUV)>0  
  and Estado = 1  
  
 -- Producto Comercial  
 insert into @Producto  
 SELECT DISTINCT TOP (@RowCount)  
  p.CUV  
  ,coalesce(op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion) AS Descripcion  
  ,coalesce(op.PrecioOferta, pd.PrecioProducto * pd.FactorRepeticion, p.PrecioUnitario * p.FactorRepeticion) AS PrecioCatalogo  
  ,p.MarcaID  
  ,pf.CUV  
  ,pcc.EsExpoOferta  
  ,pcc.CUVRevista  
  ,p.PaisID  
  ,p.AnoCampania AS CampaniaID  
  ,p.CodigoCatalago  
  ,p.CodigoProducto  
  ,p.IndicadorMontoMinimo  
  ,M.Descripcion AS DescripcionMarca  
  ,op.ConfiguracionOfertaID  
  ,op.TipoOfertaSisID  
  ,P.IndicadorOferta  
  ,pcor.SAP  
  ,p.PrecioValorizado  
  ,pl.CodigoSAP  
  ,pcor.Oferta  
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
 LEFT JOIN Marca M WITH (NOLOCK)  
  ON p.MarcaId = M.MarcaId  
 LEFT JOIN ods.ProductosLanzamiento pl WITH (NOLOCK)  
  ON p.CodigoProducto = pl.CodigoSAP  
  AND p.AnoCampania = pl.Campania  
 LEFT JOIN ProductoComercialOfertaRevista pcor WITH (NOLOCK)  
  ON p.AnoCampania = pcor.Campania  
  AND p.CUV = pcor.CUV  
 WHERE  
  p.AnoCampania = @CampaniaID  
  AND p.IndicadorDigitable = 1  
  AND CHARINDEX(@CodigoDescripcion, p.CUV) > 0  
  
 -- Select final  
 select distinct top (@RowCount)  
  p.CUV,  
  coalesce(e.DescripcionCUV2, p.Descripcion) as Descripcion,  
  coalesce(e.Precio2, p.PrecioCatalogo) as PrecioCatalogo,  
  p.MarcaID,  
  0 AS EstaEnRevista,  
  case when isnull(p.CUVProductoFaltante,0) = 0 then 1 else 0 end as TieneStock,  
  p.EsExpoOferta as EsExpoOferta,  
  p.CUVRevista as CUVRevista,  
  '' AS CUVComplemento,  
  p.PaisID,  
  p.CampaniaID,  
  p.CodigoCatalago,  
  p.CodigoProducto,  
  p.IndicadorMontoMinimo,  
  p.DescripcionMarca,  
  'NO DISPONIBLE' AS DescripcionCategoria,  
  te.DescripcionEstrategia,  
  p.ConfiguracionOfertaID as ConfiguracionOfertaID,  
  p.TipoOfertaSisID as TipoOfertaSisID,  
  te.flagNueva as FlagNueva,  
  e.EstrategiaID as EstrategiaID,
  e.codigoEstrategia as CodigoEstrategia,
  te.TipoEstrategiaID as TipoEstrategiaID,  
  p.IndicadorOferta,  
  --case when pst.CUV is null then 0 else 1 end as TieneSugerido,  
  CASE WHEN ISNULL(pst.CUV, 0) = 0 THEN 0 ELSE  
            CASE WHEN ISNULL(psp.MostrarAgotado, 0) = 0 THEN 1 ELSE  
                CASE WHEN isnull(p.CUVProductoFaltante,0) = 0 THEN 0 ELSE 1 END  
            END  
        END TieneSugerido,  
  case when p.SAPProductoComercialOfertaRevista is null then 0 else 1 end as TieneOfertaRevista,  
  p.PrecioValorizado,  
  case when p.CodigoSAPProductosLanzamiento is null then 0 else 1 end as TieneLanzamientoCatalogoPersonalizado,  
  p.TipoOfertaRevista as TipoOfertaRevista,  
  te.Codigo as TipoEstrategiaCodigo,  
  case when te.MostrarImgOfertaIndependiente = 1 and e.EsOfertaIndependiente = 1 then 1 else 0 end as EsOfertaIndependiente  
 from @Producto p  
 left join Estrategia e WITH (NOLOCK)  
  on p.CampaniaID BETWEEN e.CampaniaID AND CASE WHEN e.CampaniaIDFin = 0 THEN e.CampaniaID ELSE e.CampaniaIDFin END  
  AND e.CUV2 = p.CUV  
  AND e.Activo = 1  
 left join TipoEstrategia te WITH (NOLOCK)  
  ON te.TipoEstrategiaID = e.TipoEstrategiaID  
  and te.FlagActivo = 1  
 LEFT JOIN @ProductoSugeridoTemp pst on  
  p.CUV = pst.CUV  
 LEFT JOIN ProductoSugeridoPadre psp WITH (NOLOCK) ON p.CUV = psp.CUV and p.CampaniaID = psp.CampaniaID  
 where NOT EXISTS (  
  select ep.CUV  
  from EstrategiaProducto ep WITH (NOLOCK)  
  where ep.Campania = p.CampaniaID  
   and ep.CUV = p.CUV  
   and ep.CUV2 != p.CUV  
   and NOT EXISTS (select tex.Codigo from TipoEstrategia tex where tex.TipoEstrategiaID = e.TipoEstrategiaID and tex.Codigo = '011')  
 )  
  
END  
GO

USE BelcorpSalvador
GO

IF (OBJECT_ID ( 'dbo.GetProductoComercialByCuvByFilter', 'P' ) IS NULL)
EXEC('CREATE PROCEDURE dbo.GetProductoComercialByCuvByFilter AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE [dbo].GetProductoComercialByCuvByFilter
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
exec dbo.GetProductoComercialByCuvByFilter 201810,1,'11481',2009,2261,'91','9011'  
exec dbo.GetProductoComercialByCampaniaBySearchRegionZona_sb2 201808,1,1,'32072',2701,2161,'50','5052'  
*/  
BEGIN  
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
 DECLARE @ProductoSugeridoTemp TABLE (CUV varchar(6))  
 DECLARE @Producto TABLE  
 (  
  CUV varchar(50),  
  Descripcion varchar(250),  
  PrecioCatalogo numeric(12,2),  
  MarcaID int,  
  CUVProductoFaltante varchar(50),  
  EsExpoOferta bit,  
  CUVRevista varchar(20),  
  PaisID int,  
  CampaniaID int,  
  CodigoCatalago char(6),  
  CodigoProducto varchar(12),  
  IndicadorMontoMinimo int,  
  DescripcionMarca varchar(20),  
  ConfiguracionOfertaID int,  
  TipoOfertaSisID int,  
  IndicadorOferta bit,  
  SAPProductoComercialOfertaRevista varchar(50),  
  PrecioValorizado numeric(12,2),  
  CodigoSAPProductosLanzamiento bit,  
  TipoOfertaRevista varchar(20)  
 )  
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
 WHERE  
  c.codigo = @CampaniaID  
  and CHARINDEX(@CodigoDescripcion,op.CUV)>0  
  
 -- Producto Faltante  
 INSERT INTO @ProductoFaltanteTemp  
 SELECT DISTINCT  
  CUV  
 FROM dbo.ProductoFaltante WITH (NOLOCK)  
 WHERE  
  CampaniaID = @CampaniaID  
  AND Zonaid = @ZonaID  
  AND CHARINDEX(@CodigoDescripcion,CUV)>0  
 UNION ALL  
 SELECT DISTINCT  
  ltrim(rtrim(fa.CodigoVenta)) AS CUV  
 FROM ods.FaltanteAnunciado fa WITH (NOLOCK)  
 INNER JOIN ods.Campania c WITH (NOLOCK)  
  ON fa.CampaniaID = c.CampaniaID  
 WHERE c.Codigo = @CampaniaID  
  and CHARINDEX(@CodigoDescripcion,rtrim(fa.CodigoVenta))>0  
  AND ( rtrim(fa.CodigoRegion) = @CodigoRegion OR fa.CodigoRegion IS NULL )  
  AND ( rtrim(fa.CodigoZona) = @CodigoZona OR fa.CodigoZona IS NULL )  
  
 -- Producto Sugerido  
 insert into @ProductoSugeridoTemp  
 select CUV  
 from dbo.ProductoSugerido WITH (NOLOCK)  
 where  
  CampaniaID = @CampaniaID  
  and CHARINDEX(@CodigoDescripcion,CUV)>0  
  and Estado = 1  
  
 -- Producto Comercial  
 insert into @Producto  
 SELECT DISTINCT TOP (@RowCount)  
  p.CUV  
  ,coalesce(op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion) AS Descripcion  
  ,coalesce(op.PrecioOferta, pd.PrecioProducto * pd.FactorRepeticion, p.PrecioUnitario * p.FactorRepeticion) AS PrecioCatalogo  
  ,p.MarcaID  
  ,pf.CUV  
  ,pcc.EsExpoOferta  
  ,pcc.CUVRevista  
  ,p.PaisID  
  ,p.AnoCampania AS CampaniaID  
  ,p.CodigoCatalago  
  ,p.CodigoProducto  
  ,p.IndicadorMontoMinimo  
  ,M.Descripcion AS DescripcionMarca  
  ,op.ConfiguracionOfertaID  
  ,op.TipoOfertaSisID  
  ,P.IndicadorOferta  
  ,pcor.SAP  
  ,p.PrecioValorizado  
  ,pl.CodigoSAP  
  ,pcor.Oferta  
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
 LEFT JOIN Marca M WITH (NOLOCK)  
  ON p.MarcaId = M.MarcaId  
 LEFT JOIN ods.ProductosLanzamiento pl WITH (NOLOCK)  
  ON p.CodigoProducto = pl.CodigoSAP  
  AND p.AnoCampania = pl.Campania  
 LEFT JOIN ProductoComercialOfertaRevista pcor WITH (NOLOCK)  
  ON p.AnoCampania = pcor.Campania  
  AND p.CUV = pcor.CUV  
 WHERE  
  p.AnoCampania = @CampaniaID  
  AND p.IndicadorDigitable = 1  
  AND CHARINDEX(@CodigoDescripcion, p.CUV) > 0  
  
 -- Select final  
 select distinct top (@RowCount)  
  p.CUV,  
  coalesce(e.DescripcionCUV2, p.Descripcion) as Descripcion,  
  coalesce(e.Precio2, p.PrecioCatalogo) as PrecioCatalogo,  
  p.MarcaID,  
  0 AS EstaEnRevista,  
  case when isnull(p.CUVProductoFaltante,0) = 0 then 1 else 0 end as TieneStock,  
  p.EsExpoOferta as EsExpoOferta,  
  p.CUVRevista as CUVRevista,  
  '' AS CUVComplemento,  
  p.PaisID,  
  p.CampaniaID,  
  p.CodigoCatalago,  
  p.CodigoProducto,  
  p.IndicadorMontoMinimo,  
  p.DescripcionMarca,  
  'NO DISPONIBLE' AS DescripcionCategoria,  
  te.DescripcionEstrategia,  
  p.ConfiguracionOfertaID as ConfiguracionOfertaID,  
  p.TipoOfertaSisID as TipoOfertaSisID,  
  te.flagNueva as FlagNueva,  
  e.EstrategiaID as EstrategiaID,
  e.codigoEstrategia as CodigoEstrategia,
  te.TipoEstrategiaID as TipoEstrategiaID,  
  p.IndicadorOferta,  
  --case when pst.CUV is null then 0 else 1 end as TieneSugerido,  
  CASE WHEN ISNULL(pst.CUV, 0) = 0 THEN 0 ELSE  
            CASE WHEN ISNULL(psp.MostrarAgotado, 0) = 0 THEN 1 ELSE  
                CASE WHEN isnull(p.CUVProductoFaltante,0) = 0 THEN 0 ELSE 1 END  
            END  
        END TieneSugerido,  
  case when p.SAPProductoComercialOfertaRevista is null then 0 else 1 end as TieneOfertaRevista,  
  p.PrecioValorizado,  
  case when p.CodigoSAPProductosLanzamiento is null then 0 else 1 end as TieneLanzamientoCatalogoPersonalizado,  
  p.TipoOfertaRevista as TipoOfertaRevista,  
  te.Codigo as TipoEstrategiaCodigo,  
  case when te.MostrarImgOfertaIndependiente = 1 and e.EsOfertaIndependiente = 1 then 1 else 0 end as EsOfertaIndependiente  
 from @Producto p  
 left join Estrategia e WITH (NOLOCK)  
  on p.CampaniaID BETWEEN e.CampaniaID AND CASE WHEN e.CampaniaIDFin = 0 THEN e.CampaniaID ELSE e.CampaniaIDFin END  
  AND e.CUV2 = p.CUV  
  AND e.Activo = 1  
 left join TipoEstrategia te WITH (NOLOCK)  
  ON te.TipoEstrategiaID = e.TipoEstrategiaID  
  and te.FlagActivo = 1  
 LEFT JOIN @ProductoSugeridoTemp pst on  
  p.CUV = pst.CUV  
 LEFT JOIN ProductoSugeridoPadre psp WITH (NOLOCK) ON p.CUV = psp.CUV and p.CampaniaID = psp.CampaniaID  
 where NOT EXISTS (  
  select ep.CUV  
  from EstrategiaProducto ep WITH (NOLOCK)  
  where ep.Campania = p.CampaniaID  
   and ep.CUV = p.CUV  
   and ep.CUV2 != p.CUV  
   and NOT EXISTS (select tex.Codigo from TipoEstrategia tex where tex.TipoEstrategiaID = e.TipoEstrategiaID and tex.Codigo = '011')  
 )  
  
END  
GO

USE BelcorpPuertoRico
GO

IF (OBJECT_ID ( 'dbo.GetProductoComercialByCuvByFilter', 'P' ) IS NULL)
EXEC('CREATE PROCEDURE dbo.GetProductoComercialByCuvByFilter AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE [dbo].GetProductoComercialByCuvByFilter
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
exec dbo.GetProductoComercialByCuvByFilter 201810,1,'11481',2009,2261,'91','9011'  
exec dbo.GetProductoComercialByCampaniaBySearchRegionZona_sb2 201808,1,1,'32072',2701,2161,'50','5052'  
*/  
BEGIN  
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
 DECLARE @ProductoSugeridoTemp TABLE (CUV varchar(6))  
 DECLARE @Producto TABLE  
 (  
  CUV varchar(50),  
  Descripcion varchar(250),  
  PrecioCatalogo numeric(12,2),  
  MarcaID int,  
  CUVProductoFaltante varchar(50),  
  EsExpoOferta bit,  
  CUVRevista varchar(20),  
  PaisID int,  
  CampaniaID int,  
  CodigoCatalago char(6),  
  CodigoProducto varchar(12),  
  IndicadorMontoMinimo int,  
  DescripcionMarca varchar(20),  
  ConfiguracionOfertaID int,  
  TipoOfertaSisID int,  
  IndicadorOferta bit,  
  SAPProductoComercialOfertaRevista varchar(50),  
  PrecioValorizado numeric(12,2),  
  CodigoSAPProductosLanzamiento bit,  
  TipoOfertaRevista varchar(20)  
 )  
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
 WHERE  
  c.codigo = @CampaniaID  
  and CHARINDEX(@CodigoDescripcion,op.CUV)>0  
  
 -- Producto Faltante  
 INSERT INTO @ProductoFaltanteTemp  
 SELECT DISTINCT  
  CUV  
 FROM dbo.ProductoFaltante WITH (NOLOCK)  
 WHERE  
  CampaniaID = @CampaniaID  
  AND Zonaid = @ZonaID  
  AND CHARINDEX(@CodigoDescripcion,CUV)>0  
 UNION ALL  
 SELECT DISTINCT  
  ltrim(rtrim(fa.CodigoVenta)) AS CUV  
 FROM ods.FaltanteAnunciado fa WITH (NOLOCK)  
 INNER JOIN ods.Campania c WITH (NOLOCK)  
  ON fa.CampaniaID = c.CampaniaID  
 WHERE c.Codigo = @CampaniaID  
  and CHARINDEX(@CodigoDescripcion,rtrim(fa.CodigoVenta))>0  
  AND ( rtrim(fa.CodigoRegion) = @CodigoRegion OR fa.CodigoRegion IS NULL )  
  AND ( rtrim(fa.CodigoZona) = @CodigoZona OR fa.CodigoZona IS NULL )  
  
 -- Producto Sugerido  
 insert into @ProductoSugeridoTemp  
 select CUV  
 from dbo.ProductoSugerido WITH (NOLOCK)  
 where  
  CampaniaID = @CampaniaID  
  and CHARINDEX(@CodigoDescripcion,CUV)>0  
  and Estado = 1  
  
 -- Producto Comercial  
 insert into @Producto  
 SELECT DISTINCT TOP (@RowCount)  
  p.CUV  
  ,coalesce(op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion) AS Descripcion  
  ,coalesce(op.PrecioOferta, pd.PrecioProducto * pd.FactorRepeticion, p.PrecioUnitario * p.FactorRepeticion) AS PrecioCatalogo  
  ,p.MarcaID  
  ,pf.CUV  
  ,pcc.EsExpoOferta  
  ,pcc.CUVRevista  
  ,p.PaisID  
  ,p.AnoCampania AS CampaniaID  
  ,p.CodigoCatalago  
  ,p.CodigoProducto  
  ,p.IndicadorMontoMinimo  
  ,M.Descripcion AS DescripcionMarca  
  ,op.ConfiguracionOfertaID  
  ,op.TipoOfertaSisID  
  ,P.IndicadorOferta  
  ,pcor.SAP  
  ,p.PrecioValorizado  
  ,pl.CodigoSAP  
  ,pcor.Oferta  
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
 LEFT JOIN Marca M WITH (NOLOCK)  
  ON p.MarcaId = M.MarcaId  
 LEFT JOIN ods.ProductosLanzamiento pl WITH (NOLOCK)  
  ON p.CodigoProducto = pl.CodigoSAP  
  AND p.AnoCampania = pl.Campania  
 LEFT JOIN ProductoComercialOfertaRevista pcor WITH (NOLOCK)  
  ON p.AnoCampania = pcor.Campania  
  AND p.CUV = pcor.CUV  
 WHERE  
  p.AnoCampania = @CampaniaID  
  AND p.IndicadorDigitable = 1  
  AND CHARINDEX(@CodigoDescripcion, p.CUV) > 0  
  
 -- Select final  
 select distinct top (@RowCount)  
  p.CUV,  
  coalesce(e.DescripcionCUV2, p.Descripcion) as Descripcion,  
  coalesce(e.Precio2, p.PrecioCatalogo) as PrecioCatalogo,  
  p.MarcaID,  
  0 AS EstaEnRevista,  
  case when isnull(p.CUVProductoFaltante,0) = 0 then 1 else 0 end as TieneStock,  
  p.EsExpoOferta as EsExpoOferta,  
  p.CUVRevista as CUVRevista,  
  '' AS CUVComplemento,  
  p.PaisID,  
  p.CampaniaID,  
  p.CodigoCatalago,  
  p.CodigoProducto,  
  p.IndicadorMontoMinimo,  
  p.DescripcionMarca,  
  'NO DISPONIBLE' AS DescripcionCategoria,  
  te.DescripcionEstrategia,  
  p.ConfiguracionOfertaID as ConfiguracionOfertaID,  
  p.TipoOfertaSisID as TipoOfertaSisID,  
  te.flagNueva as FlagNueva,  
  e.EstrategiaID as EstrategiaID,
  e.codigoEstrategia as CodigoEstrategia,
  te.TipoEstrategiaID as TipoEstrategiaID,  
  p.IndicadorOferta,  
  --case when pst.CUV is null then 0 else 1 end as TieneSugerido,  
  CASE WHEN ISNULL(pst.CUV, 0) = 0 THEN 0 ELSE  
            CASE WHEN ISNULL(psp.MostrarAgotado, 0) = 0 THEN 1 ELSE  
                CASE WHEN isnull(p.CUVProductoFaltante,0) = 0 THEN 0 ELSE 1 END  
            END  
        END TieneSugerido,  
  case when p.SAPProductoComercialOfertaRevista is null then 0 else 1 end as TieneOfertaRevista,  
  p.PrecioValorizado,  
  case when p.CodigoSAPProductosLanzamiento is null then 0 else 1 end as TieneLanzamientoCatalogoPersonalizado,  
  p.TipoOfertaRevista as TipoOfertaRevista,  
  te.Codigo as TipoEstrategiaCodigo,  
  case when te.MostrarImgOfertaIndependiente = 1 and e.EsOfertaIndependiente = 1 then 1 else 0 end as EsOfertaIndependiente  
 from @Producto p  
 left join Estrategia e WITH (NOLOCK)  
  on p.CampaniaID BETWEEN e.CampaniaID AND CASE WHEN e.CampaniaIDFin = 0 THEN e.CampaniaID ELSE e.CampaniaIDFin END  
  AND e.CUV2 = p.CUV  
  AND e.Activo = 1  
 left join TipoEstrategia te WITH (NOLOCK)  
  ON te.TipoEstrategiaID = e.TipoEstrategiaID  
  and te.FlagActivo = 1  
 LEFT JOIN @ProductoSugeridoTemp pst on  
  p.CUV = pst.CUV  
 LEFT JOIN ProductoSugeridoPadre psp WITH (NOLOCK) ON p.CUV = psp.CUV and p.CampaniaID = psp.CampaniaID  
 where NOT EXISTS (  
  select ep.CUV  
  from EstrategiaProducto ep WITH (NOLOCK)  
  where ep.Campania = p.CampaniaID  
   and ep.CUV = p.CUV  
   and ep.CUV2 != p.CUV  
   and NOT EXISTS (select tex.Codigo from TipoEstrategia tex where tex.TipoEstrategiaID = e.TipoEstrategiaID and tex.Codigo = '011')  
 )  
  
END  
GO

USE BelcorpPanama
GO

IF (OBJECT_ID ( 'dbo.GetProductoComercialByCuvByFilter', 'P' ) IS NULL)
EXEC('CREATE PROCEDURE dbo.GetProductoComercialByCuvByFilter AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE [dbo].GetProductoComercialByCuvByFilter
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
exec dbo.GetProductoComercialByCuvByFilter 201810,1,'11481',2009,2261,'91','9011'  
exec dbo.GetProductoComercialByCampaniaBySearchRegionZona_sb2 201808,1,1,'32072',2701,2161,'50','5052'  
*/  
BEGIN  
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
 DECLARE @ProductoSugeridoTemp TABLE (CUV varchar(6))  
 DECLARE @Producto TABLE  
 (  
  CUV varchar(50),  
  Descripcion varchar(250),  
  PrecioCatalogo numeric(12,2),  
  MarcaID int,  
  CUVProductoFaltante varchar(50),  
  EsExpoOferta bit,  
  CUVRevista varchar(20),  
  PaisID int,  
  CampaniaID int,  
  CodigoCatalago char(6),  
  CodigoProducto varchar(12),  
  IndicadorMontoMinimo int,  
  DescripcionMarca varchar(20),  
  ConfiguracionOfertaID int,  
  TipoOfertaSisID int,  
  IndicadorOferta bit,  
  SAPProductoComercialOfertaRevista varchar(50),  
  PrecioValorizado numeric(12,2),  
  CodigoSAPProductosLanzamiento bit,  
  TipoOfertaRevista varchar(20)  
 )  
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
 WHERE  
  c.codigo = @CampaniaID  
  and CHARINDEX(@CodigoDescripcion,op.CUV)>0  
  
 -- Producto Faltante  
 INSERT INTO @ProductoFaltanteTemp  
 SELECT DISTINCT  
  CUV  
 FROM dbo.ProductoFaltante WITH (NOLOCK)  
 WHERE  
  CampaniaID = @CampaniaID  
  AND Zonaid = @ZonaID  
  AND CHARINDEX(@CodigoDescripcion,CUV)>0  
 UNION ALL  
 SELECT DISTINCT  
  ltrim(rtrim(fa.CodigoVenta)) AS CUV  
 FROM ods.FaltanteAnunciado fa WITH (NOLOCK)  
 INNER JOIN ods.Campania c WITH (NOLOCK)  
  ON fa.CampaniaID = c.CampaniaID  
 WHERE c.Codigo = @CampaniaID  
  and CHARINDEX(@CodigoDescripcion,rtrim(fa.CodigoVenta))>0  
  AND ( rtrim(fa.CodigoRegion) = @CodigoRegion OR fa.CodigoRegion IS NULL )  
  AND ( rtrim(fa.CodigoZona) = @CodigoZona OR fa.CodigoZona IS NULL )  
  
 -- Producto Sugerido  
 insert into @ProductoSugeridoTemp  
 select CUV  
 from dbo.ProductoSugerido WITH (NOLOCK)  
 where  
  CampaniaID = @CampaniaID  
  and CHARINDEX(@CodigoDescripcion,CUV)>0  
  and Estado = 1  
  
 -- Producto Comercial  
 insert into @Producto  
 SELECT DISTINCT TOP (@RowCount)  
  p.CUV  
  ,coalesce(op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion) AS Descripcion  
  ,coalesce(op.PrecioOferta, pd.PrecioProducto * pd.FactorRepeticion, p.PrecioUnitario * p.FactorRepeticion) AS PrecioCatalogo  
  ,p.MarcaID  
  ,pf.CUV  
  ,pcc.EsExpoOferta  
  ,pcc.CUVRevista  
  ,p.PaisID  
  ,p.AnoCampania AS CampaniaID  
  ,p.CodigoCatalago  
  ,p.CodigoProducto  
  ,p.IndicadorMontoMinimo  
  ,M.Descripcion AS DescripcionMarca  
  ,op.ConfiguracionOfertaID  
  ,op.TipoOfertaSisID  
  ,P.IndicadorOferta  
  ,pcor.SAP  
  ,p.PrecioValorizado  
  ,pl.CodigoSAP  
  ,pcor.Oferta  
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
 LEFT JOIN Marca M WITH (NOLOCK)  
  ON p.MarcaId = M.MarcaId  
 LEFT JOIN ods.ProductosLanzamiento pl WITH (NOLOCK)  
  ON p.CodigoProducto = pl.CodigoSAP  
  AND p.AnoCampania = pl.Campania  
 LEFT JOIN ProductoComercialOfertaRevista pcor WITH (NOLOCK)  
  ON p.AnoCampania = pcor.Campania  
  AND p.CUV = pcor.CUV  
 WHERE  
  p.AnoCampania = @CampaniaID  
  AND p.IndicadorDigitable = 1  
  AND CHARINDEX(@CodigoDescripcion, p.CUV) > 0  
  
 -- Select final  
 select distinct top (@RowCount)  
  p.CUV,  
  coalesce(e.DescripcionCUV2, p.Descripcion) as Descripcion,  
  coalesce(e.Precio2, p.PrecioCatalogo) as PrecioCatalogo,  
  p.MarcaID,  
  0 AS EstaEnRevista,  
  case when isnull(p.CUVProductoFaltante,0) = 0 then 1 else 0 end as TieneStock,  
  p.EsExpoOferta as EsExpoOferta,  
  p.CUVRevista as CUVRevista,  
  '' AS CUVComplemento,  
  p.PaisID,  
  p.CampaniaID,  
  p.CodigoCatalago,  
  p.CodigoProducto,  
  p.IndicadorMontoMinimo,  
  p.DescripcionMarca,  
  'NO DISPONIBLE' AS DescripcionCategoria,  
  te.DescripcionEstrategia,  
  p.ConfiguracionOfertaID as ConfiguracionOfertaID,  
  p.TipoOfertaSisID as TipoOfertaSisID,  
  te.flagNueva as FlagNueva,  
  e.EstrategiaID as EstrategiaID,
  e.codigoEstrategia as CodigoEstrategia,
  te.TipoEstrategiaID as TipoEstrategiaID,  
  p.IndicadorOferta,  
  --case when pst.CUV is null then 0 else 1 end as TieneSugerido,  
  CASE WHEN ISNULL(pst.CUV, 0) = 0 THEN 0 ELSE  
            CASE WHEN ISNULL(psp.MostrarAgotado, 0) = 0 THEN 1 ELSE  
                CASE WHEN isnull(p.CUVProductoFaltante,0) = 0 THEN 0 ELSE 1 END  
            END  
        END TieneSugerido,  
  case when p.SAPProductoComercialOfertaRevista is null then 0 else 1 end as TieneOfertaRevista,  
  p.PrecioValorizado,  
  case when p.CodigoSAPProductosLanzamiento is null then 0 else 1 end as TieneLanzamientoCatalogoPersonalizado,  
  p.TipoOfertaRevista as TipoOfertaRevista,  
  te.Codigo as TipoEstrategiaCodigo,  
  case when te.MostrarImgOfertaIndependiente = 1 and e.EsOfertaIndependiente = 1 then 1 else 0 end as EsOfertaIndependiente  
 from @Producto p  
 left join Estrategia e WITH (NOLOCK)  
  on p.CampaniaID BETWEEN e.CampaniaID AND CASE WHEN e.CampaniaIDFin = 0 THEN e.CampaniaID ELSE e.CampaniaIDFin END  
  AND e.CUV2 = p.CUV  
  AND e.Activo = 1  
 left join TipoEstrategia te WITH (NOLOCK)  
  ON te.TipoEstrategiaID = e.TipoEstrategiaID  
  and te.FlagActivo = 1  
 LEFT JOIN @ProductoSugeridoTemp pst on  
  p.CUV = pst.CUV  
 LEFT JOIN ProductoSugeridoPadre psp WITH (NOLOCK) ON p.CUV = psp.CUV and p.CampaniaID = psp.CampaniaID  
 where NOT EXISTS (  
  select ep.CUV  
  from EstrategiaProducto ep WITH (NOLOCK)  
  where ep.Campania = p.CampaniaID  
   and ep.CUV = p.CUV  
   and ep.CUV2 != p.CUV  
   and NOT EXISTS (select tex.Codigo from TipoEstrategia tex where tex.TipoEstrategiaID = e.TipoEstrategiaID and tex.Codigo = '011')  
 )  
  
END  
GO

USE BelcorpGuatemala
GO

IF (OBJECT_ID ( 'dbo.GetProductoComercialByCuvByFilter', 'P' ) IS NULL)
EXEC('CREATE PROCEDURE dbo.GetProductoComercialByCuvByFilter AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE [dbo].GetProductoComercialByCuvByFilter
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
exec dbo.GetProductoComercialByCuvByFilter 201810,1,'11481',2009,2261,'91','9011'  
exec dbo.GetProductoComercialByCampaniaBySearchRegionZona_sb2 201808,1,1,'32072',2701,2161,'50','5052'  
*/  
BEGIN  
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
 DECLARE @ProductoSugeridoTemp TABLE (CUV varchar(6))  
 DECLARE @Producto TABLE  
 (  
  CUV varchar(50),  
  Descripcion varchar(250),  
  PrecioCatalogo numeric(12,2),  
  MarcaID int,  
  CUVProductoFaltante varchar(50),  
  EsExpoOferta bit,  
  CUVRevista varchar(20),  
  PaisID int,  
  CampaniaID int,  
  CodigoCatalago char(6),  
  CodigoProducto varchar(12),  
  IndicadorMontoMinimo int,  
  DescripcionMarca varchar(20),  
  ConfiguracionOfertaID int,  
  TipoOfertaSisID int,  
  IndicadorOferta bit,  
  SAPProductoComercialOfertaRevista varchar(50),  
  PrecioValorizado numeric(12,2),  
  CodigoSAPProductosLanzamiento bit,  
  TipoOfertaRevista varchar(20)  
 )  
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
 WHERE  
  c.codigo = @CampaniaID  
  and CHARINDEX(@CodigoDescripcion,op.CUV)>0  
  
 -- Producto Faltante  
 INSERT INTO @ProductoFaltanteTemp  
 SELECT DISTINCT  
  CUV  
 FROM dbo.ProductoFaltante WITH (NOLOCK)  
 WHERE  
  CampaniaID = @CampaniaID  
  AND Zonaid = @ZonaID  
  AND CHARINDEX(@CodigoDescripcion,CUV)>0  
 UNION ALL  
 SELECT DISTINCT  
  ltrim(rtrim(fa.CodigoVenta)) AS CUV  
 FROM ods.FaltanteAnunciado fa WITH (NOLOCK)  
 INNER JOIN ods.Campania c WITH (NOLOCK)  
  ON fa.CampaniaID = c.CampaniaID  
 WHERE c.Codigo = @CampaniaID  
  and CHARINDEX(@CodigoDescripcion,rtrim(fa.CodigoVenta))>0  
  AND ( rtrim(fa.CodigoRegion) = @CodigoRegion OR fa.CodigoRegion IS NULL )  
  AND ( rtrim(fa.CodigoZona) = @CodigoZona OR fa.CodigoZona IS NULL )  
  
 -- Producto Sugerido  
 insert into @ProductoSugeridoTemp  
 select CUV  
 from dbo.ProductoSugerido WITH (NOLOCK)  
 where  
  CampaniaID = @CampaniaID  
  and CHARINDEX(@CodigoDescripcion,CUV)>0  
  and Estado = 1  
  
 -- Producto Comercial  
 insert into @Producto  
 SELECT DISTINCT TOP (@RowCount)  
  p.CUV  
  ,coalesce(op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion) AS Descripcion  
  ,coalesce(op.PrecioOferta, pd.PrecioProducto * pd.FactorRepeticion, p.PrecioUnitario * p.FactorRepeticion) AS PrecioCatalogo  
  ,p.MarcaID  
  ,pf.CUV  
  ,pcc.EsExpoOferta  
  ,pcc.CUVRevista  
  ,p.PaisID  
  ,p.AnoCampania AS CampaniaID  
  ,p.CodigoCatalago  
  ,p.CodigoProducto  
  ,p.IndicadorMontoMinimo  
  ,M.Descripcion AS DescripcionMarca  
  ,op.ConfiguracionOfertaID  
  ,op.TipoOfertaSisID  
  ,P.IndicadorOferta  
  ,pcor.SAP  
  ,p.PrecioValorizado  
  ,pl.CodigoSAP  
  ,pcor.Oferta  
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
 LEFT JOIN Marca M WITH (NOLOCK)  
  ON p.MarcaId = M.MarcaId  
 LEFT JOIN ods.ProductosLanzamiento pl WITH (NOLOCK)  
  ON p.CodigoProducto = pl.CodigoSAP  
  AND p.AnoCampania = pl.Campania  
 LEFT JOIN ProductoComercialOfertaRevista pcor WITH (NOLOCK)  
  ON p.AnoCampania = pcor.Campania  
  AND p.CUV = pcor.CUV  
 WHERE  
  p.AnoCampania = @CampaniaID  
  AND p.IndicadorDigitable = 1  
  AND CHARINDEX(@CodigoDescripcion, p.CUV) > 0  
  
 -- Select final  
 select distinct top (@RowCount)  
  p.CUV,  
  coalesce(e.DescripcionCUV2, p.Descripcion) as Descripcion,  
  coalesce(e.Precio2, p.PrecioCatalogo) as PrecioCatalogo,  
  p.MarcaID,  
  0 AS EstaEnRevista,  
  case when isnull(p.CUVProductoFaltante,0) = 0 then 1 else 0 end as TieneStock,  
  p.EsExpoOferta as EsExpoOferta,  
  p.CUVRevista as CUVRevista,  
  '' AS CUVComplemento,  
  p.PaisID,  
  p.CampaniaID,  
  p.CodigoCatalago,  
  p.CodigoProducto,  
  p.IndicadorMontoMinimo,  
  p.DescripcionMarca,  
  'NO DISPONIBLE' AS DescripcionCategoria,  
  te.DescripcionEstrategia,  
  p.ConfiguracionOfertaID as ConfiguracionOfertaID,  
  p.TipoOfertaSisID as TipoOfertaSisID,  
  te.flagNueva as FlagNueva,  
  e.EstrategiaID as EstrategiaID,
  e.codigoEstrategia as CodigoEstrategia,
  te.TipoEstrategiaID as TipoEstrategiaID,  
  p.IndicadorOferta,  
  --case when pst.CUV is null then 0 else 1 end as TieneSugerido,  
  CASE WHEN ISNULL(pst.CUV, 0) = 0 THEN 0 ELSE  
            CASE WHEN ISNULL(psp.MostrarAgotado, 0) = 0 THEN 1 ELSE  
                CASE WHEN isnull(p.CUVProductoFaltante,0) = 0 THEN 0 ELSE 1 END  
            END  
        END TieneSugerido,  
  case when p.SAPProductoComercialOfertaRevista is null then 0 else 1 end as TieneOfertaRevista,  
  p.PrecioValorizado,  
  case when p.CodigoSAPProductosLanzamiento is null then 0 else 1 end as TieneLanzamientoCatalogoPersonalizado,  
  p.TipoOfertaRevista as TipoOfertaRevista,  
  te.Codigo as TipoEstrategiaCodigo,  
  case when te.MostrarImgOfertaIndependiente = 1 and e.EsOfertaIndependiente = 1 then 1 else 0 end as EsOfertaIndependiente  
 from @Producto p  
 left join Estrategia e WITH (NOLOCK)  
  on p.CampaniaID BETWEEN e.CampaniaID AND CASE WHEN e.CampaniaIDFin = 0 THEN e.CampaniaID ELSE e.CampaniaIDFin END  
  AND e.CUV2 = p.CUV  
  AND e.Activo = 1  
 left join TipoEstrategia te WITH (NOLOCK)  
  ON te.TipoEstrategiaID = e.TipoEstrategiaID  
  and te.FlagActivo = 1  
 LEFT JOIN @ProductoSugeridoTemp pst on  
  p.CUV = pst.CUV  
 LEFT JOIN ProductoSugeridoPadre psp WITH (NOLOCK) ON p.CUV = psp.CUV and p.CampaniaID = psp.CampaniaID  
 where NOT EXISTS (  
  select ep.CUV  
  from EstrategiaProducto ep WITH (NOLOCK)  
  where ep.Campania = p.CampaniaID  
   and ep.CUV = p.CUV  
   and ep.CUV2 != p.CUV  
   and NOT EXISTS (select tex.Codigo from TipoEstrategia tex where tex.TipoEstrategiaID = e.TipoEstrategiaID and tex.Codigo = '011')  
 )  
  
END  
GO

USE BelcorpEcuador
GO

IF (OBJECT_ID ( 'dbo.GetProductoComercialByCuvByFilter', 'P' ) IS NULL)
EXEC('CREATE PROCEDURE dbo.GetProductoComercialByCuvByFilter AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE [dbo].GetProductoComercialByCuvByFilter
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
exec dbo.GetProductoComercialByCuvByFilter 201810,1,'11481',2009,2261,'91','9011'  
exec dbo.GetProductoComercialByCampaniaBySearchRegionZona_sb2 201808,1,1,'32072',2701,2161,'50','5052'  
*/  
BEGIN  
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
 DECLARE @ProductoSugeridoTemp TABLE (CUV varchar(6))  
 DECLARE @Producto TABLE  
 (  
  CUV varchar(50),  
  Descripcion varchar(250),  
  PrecioCatalogo numeric(12,2),  
  MarcaID int,  
  CUVProductoFaltante varchar(50),  
  EsExpoOferta bit,  
  CUVRevista varchar(20),  
  PaisID int,  
  CampaniaID int,  
  CodigoCatalago char(6),  
  CodigoProducto varchar(12),  
  IndicadorMontoMinimo int,  
  DescripcionMarca varchar(20),  
  ConfiguracionOfertaID int,  
  TipoOfertaSisID int,  
  IndicadorOferta bit,  
  SAPProductoComercialOfertaRevista varchar(50),  
  PrecioValorizado numeric(12,2),  
  CodigoSAPProductosLanzamiento bit,  
  TipoOfertaRevista varchar(20)  
 )  
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
 WHERE  
  c.codigo = @CampaniaID  
  and CHARINDEX(@CodigoDescripcion,op.CUV)>0  
  
 -- Producto Faltante  
 INSERT INTO @ProductoFaltanteTemp  
 SELECT DISTINCT  
  CUV  
 FROM dbo.ProductoFaltante WITH (NOLOCK)  
 WHERE  
  CampaniaID = @CampaniaID  
  AND Zonaid = @ZonaID  
  AND CHARINDEX(@CodigoDescripcion,CUV)>0  
 UNION ALL  
 SELECT DISTINCT  
  ltrim(rtrim(fa.CodigoVenta)) AS CUV  
 FROM ods.FaltanteAnunciado fa WITH (NOLOCK)  
 INNER JOIN ods.Campania c WITH (NOLOCK)  
  ON fa.CampaniaID = c.CampaniaID  
 WHERE c.Codigo = @CampaniaID  
  and CHARINDEX(@CodigoDescripcion,rtrim(fa.CodigoVenta))>0  
  AND ( rtrim(fa.CodigoRegion) = @CodigoRegion OR fa.CodigoRegion IS NULL )  
  AND ( rtrim(fa.CodigoZona) = @CodigoZona OR fa.CodigoZona IS NULL )  
  
 -- Producto Sugerido  
 insert into @ProductoSugeridoTemp  
 select CUV  
 from dbo.ProductoSugerido WITH (NOLOCK)  
 where  
  CampaniaID = @CampaniaID  
  and CHARINDEX(@CodigoDescripcion,CUV)>0  
  and Estado = 1  
  
 -- Producto Comercial  
 insert into @Producto  
 SELECT DISTINCT TOP (@RowCount)  
  p.CUV  
  ,coalesce(op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion) AS Descripcion  
  ,coalesce(op.PrecioOferta, pd.PrecioProducto * pd.FactorRepeticion, p.PrecioUnitario * p.FactorRepeticion) AS PrecioCatalogo  
  ,p.MarcaID  
  ,pf.CUV  
  ,pcc.EsExpoOferta  
  ,pcc.CUVRevista  
  ,p.PaisID  
  ,p.AnoCampania AS CampaniaID  
  ,p.CodigoCatalago  
  ,p.CodigoProducto  
  ,p.IndicadorMontoMinimo  
  ,M.Descripcion AS DescripcionMarca  
  ,op.ConfiguracionOfertaID  
  ,op.TipoOfertaSisID  
  ,P.IndicadorOferta  
  ,pcor.SAP  
  ,p.PrecioValorizado  
  ,pl.CodigoSAP  
  ,pcor.Oferta  
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
 LEFT JOIN Marca M WITH (NOLOCK)  
  ON p.MarcaId = M.MarcaId  
 LEFT JOIN ods.ProductosLanzamiento pl WITH (NOLOCK)  
  ON p.CodigoProducto = pl.CodigoSAP  
  AND p.AnoCampania = pl.Campania  
 LEFT JOIN ProductoComercialOfertaRevista pcor WITH (NOLOCK)  
  ON p.AnoCampania = pcor.Campania  
  AND p.CUV = pcor.CUV  
 WHERE  
  p.AnoCampania = @CampaniaID  
  AND p.IndicadorDigitable = 1  
  AND CHARINDEX(@CodigoDescripcion, p.CUV) > 0  
  
 -- Select final  
 select distinct top (@RowCount)  
  p.CUV,  
  coalesce(e.DescripcionCUV2, p.Descripcion) as Descripcion,  
  coalesce(e.Precio2, p.PrecioCatalogo) as PrecioCatalogo,  
  p.MarcaID,  
  0 AS EstaEnRevista,  
  case when isnull(p.CUVProductoFaltante,0) = 0 then 1 else 0 end as TieneStock,  
  p.EsExpoOferta as EsExpoOferta,  
  p.CUVRevista as CUVRevista,  
  '' AS CUVComplemento,  
  p.PaisID,  
  p.CampaniaID,  
  p.CodigoCatalago,  
  p.CodigoProducto,  
  p.IndicadorMontoMinimo,  
  p.DescripcionMarca,  
  'NO DISPONIBLE' AS DescripcionCategoria,  
  te.DescripcionEstrategia,  
  p.ConfiguracionOfertaID as ConfiguracionOfertaID,  
  p.TipoOfertaSisID as TipoOfertaSisID,  
  te.flagNueva as FlagNueva,  
  e.EstrategiaID as EstrategiaID,
  e.codigoEstrategia as CodigoEstrategia,
  te.TipoEstrategiaID as TipoEstrategiaID,  
  p.IndicadorOferta,  
  --case when pst.CUV is null then 0 else 1 end as TieneSugerido,  
  CASE WHEN ISNULL(pst.CUV, 0) = 0 THEN 0 ELSE  
            CASE WHEN ISNULL(psp.MostrarAgotado, 0) = 0 THEN 1 ELSE  
                CASE WHEN isnull(p.CUVProductoFaltante,0) = 0 THEN 0 ELSE 1 END  
            END  
        END TieneSugerido,  
  case when p.SAPProductoComercialOfertaRevista is null then 0 else 1 end as TieneOfertaRevista,  
  p.PrecioValorizado,  
  case when p.CodigoSAPProductosLanzamiento is null then 0 else 1 end as TieneLanzamientoCatalogoPersonalizado,  
  p.TipoOfertaRevista as TipoOfertaRevista,  
  te.Codigo as TipoEstrategiaCodigo,  
  case when te.MostrarImgOfertaIndependiente = 1 and e.EsOfertaIndependiente = 1 then 1 else 0 end as EsOfertaIndependiente  
 from @Producto p  
 left join Estrategia e WITH (NOLOCK)  
  on p.CampaniaID BETWEEN e.CampaniaID AND CASE WHEN e.CampaniaIDFin = 0 THEN e.CampaniaID ELSE e.CampaniaIDFin END  
  AND e.CUV2 = p.CUV  
  AND e.Activo = 1  
 left join TipoEstrategia te WITH (NOLOCK)  
  ON te.TipoEstrategiaID = e.TipoEstrategiaID  
  and te.FlagActivo = 1  
 LEFT JOIN @ProductoSugeridoTemp pst on  
  p.CUV = pst.CUV  
 LEFT JOIN ProductoSugeridoPadre psp WITH (NOLOCK) ON p.CUV = psp.CUV and p.CampaniaID = psp.CampaniaID  
 where NOT EXISTS (  
  select ep.CUV  
  from EstrategiaProducto ep WITH (NOLOCK)  
  where ep.Campania = p.CampaniaID  
   and ep.CUV = p.CUV  
   and ep.CUV2 != p.CUV  
   and NOT EXISTS (select tex.Codigo from TipoEstrategia tex where tex.TipoEstrategiaID = e.TipoEstrategiaID and tex.Codigo = '011')  
 )  
  
END  
GO

USE BelcorpDominicana
GO

IF (OBJECT_ID ( 'dbo.GetProductoComercialByCuvByFilter', 'P' ) IS NULL)
EXEC('CREATE PROCEDURE dbo.GetProductoComercialByCuvByFilter AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE [dbo].GetProductoComercialByCuvByFilter
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
exec dbo.GetProductoComercialByCuvByFilter 201810,1,'11481',2009,2261,'91','9011'  
exec dbo.GetProductoComercialByCampaniaBySearchRegionZona_sb2 201808,1,1,'32072',2701,2161,'50','5052'  
*/  
BEGIN  
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
 DECLARE @ProductoSugeridoTemp TABLE (CUV varchar(6))  
 DECLARE @Producto TABLE  
 (  
  CUV varchar(50),  
  Descripcion varchar(250),  
  PrecioCatalogo numeric(12,2),  
  MarcaID int,  
  CUVProductoFaltante varchar(50),  
  EsExpoOferta bit,  
  CUVRevista varchar(20),  
  PaisID int,  
  CampaniaID int,  
  CodigoCatalago char(6),  
  CodigoProducto varchar(12),  
  IndicadorMontoMinimo int,  
  DescripcionMarca varchar(20),  
  ConfiguracionOfertaID int,  
  TipoOfertaSisID int,  
  IndicadorOferta bit,  
  SAPProductoComercialOfertaRevista varchar(50),  
  PrecioValorizado numeric(12,2),  
  CodigoSAPProductosLanzamiento bit,  
  TipoOfertaRevista varchar(20)  
 )  
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
 WHERE  
  c.codigo = @CampaniaID  
  and CHARINDEX(@CodigoDescripcion,op.CUV)>0  
  
 -- Producto Faltante  
 INSERT INTO @ProductoFaltanteTemp  
 SELECT DISTINCT  
  CUV  
 FROM dbo.ProductoFaltante WITH (NOLOCK)  
 WHERE  
  CampaniaID = @CampaniaID  
  AND Zonaid = @ZonaID  
  AND CHARINDEX(@CodigoDescripcion,CUV)>0  
 UNION ALL  
 SELECT DISTINCT  
  ltrim(rtrim(fa.CodigoVenta)) AS CUV  
 FROM ods.FaltanteAnunciado fa WITH (NOLOCK)  
 INNER JOIN ods.Campania c WITH (NOLOCK)  
  ON fa.CampaniaID = c.CampaniaID  
 WHERE c.Codigo = @CampaniaID  
  and CHARINDEX(@CodigoDescripcion,rtrim(fa.CodigoVenta))>0  
  AND ( rtrim(fa.CodigoRegion) = @CodigoRegion OR fa.CodigoRegion IS NULL )  
  AND ( rtrim(fa.CodigoZona) = @CodigoZona OR fa.CodigoZona IS NULL )  
  
 -- Producto Sugerido  
 insert into @ProductoSugeridoTemp  
 select CUV  
 from dbo.ProductoSugerido WITH (NOLOCK)  
 where  
  CampaniaID = @CampaniaID  
  and CHARINDEX(@CodigoDescripcion,CUV)>0  
  and Estado = 1  
  
 -- Producto Comercial  
 insert into @Producto  
 SELECT DISTINCT TOP (@RowCount)  
  p.CUV  
  ,coalesce(op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion) AS Descripcion  
  ,coalesce(op.PrecioOferta, pd.PrecioProducto * pd.FactorRepeticion, p.PrecioUnitario * p.FactorRepeticion) AS PrecioCatalogo  
  ,p.MarcaID  
  ,pf.CUV  
  ,pcc.EsExpoOferta  
  ,pcc.CUVRevista  
  ,p.PaisID  
  ,p.AnoCampania AS CampaniaID  
  ,p.CodigoCatalago  
  ,p.CodigoProducto  
  ,p.IndicadorMontoMinimo  
  ,M.Descripcion AS DescripcionMarca  
  ,op.ConfiguracionOfertaID  
  ,op.TipoOfertaSisID  
  ,P.IndicadorOferta  
  ,pcor.SAP  
  ,p.PrecioValorizado  
  ,pl.CodigoSAP  
  ,pcor.Oferta  
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
 LEFT JOIN Marca M WITH (NOLOCK)  
  ON p.MarcaId = M.MarcaId  
 LEFT JOIN ods.ProductosLanzamiento pl WITH (NOLOCK)  
  ON p.CodigoProducto = pl.CodigoSAP  
  AND p.AnoCampania = pl.Campania  
 LEFT JOIN ProductoComercialOfertaRevista pcor WITH (NOLOCK)  
  ON p.AnoCampania = pcor.Campania  
  AND p.CUV = pcor.CUV  
 WHERE  
  p.AnoCampania = @CampaniaID  
  AND p.IndicadorDigitable = 1  
  AND CHARINDEX(@CodigoDescripcion, p.CUV) > 0  
  
 -- Select final  
 select distinct top (@RowCount)  
  p.CUV,  
  coalesce(e.DescripcionCUV2, p.Descripcion) as Descripcion,  
  coalesce(e.Precio2, p.PrecioCatalogo) as PrecioCatalogo,  
  p.MarcaID,  
  0 AS EstaEnRevista,  
  case when isnull(p.CUVProductoFaltante,0) = 0 then 1 else 0 end as TieneStock,  
  p.EsExpoOferta as EsExpoOferta,  
  p.CUVRevista as CUVRevista,  
  '' AS CUVComplemento,  
  p.PaisID,  
  p.CampaniaID,  
  p.CodigoCatalago,  
  p.CodigoProducto,  
  p.IndicadorMontoMinimo,  
  p.DescripcionMarca,  
  'NO DISPONIBLE' AS DescripcionCategoria,  
  te.DescripcionEstrategia,  
  p.ConfiguracionOfertaID as ConfiguracionOfertaID,  
  p.TipoOfertaSisID as TipoOfertaSisID,  
  te.flagNueva as FlagNueva,  
  e.EstrategiaID as EstrategiaID,
  e.codigoEstrategia as CodigoEstrategia,
  te.TipoEstrategiaID as TipoEstrategiaID,  
  p.IndicadorOferta,  
  --case when pst.CUV is null then 0 else 1 end as TieneSugerido,  
  CASE WHEN ISNULL(pst.CUV, 0) = 0 THEN 0 ELSE  
            CASE WHEN ISNULL(psp.MostrarAgotado, 0) = 0 THEN 1 ELSE  
                CASE WHEN isnull(p.CUVProductoFaltante,0) = 0 THEN 0 ELSE 1 END  
            END  
        END TieneSugerido,  
  case when p.SAPProductoComercialOfertaRevista is null then 0 else 1 end as TieneOfertaRevista,  
  p.PrecioValorizado,  
  case when p.CodigoSAPProductosLanzamiento is null then 0 else 1 end as TieneLanzamientoCatalogoPersonalizado,  
  p.TipoOfertaRevista as TipoOfertaRevista,  
  te.Codigo as TipoEstrategiaCodigo,  
  case when te.MostrarImgOfertaIndependiente = 1 and e.EsOfertaIndependiente = 1 then 1 else 0 end as EsOfertaIndependiente  
 from @Producto p  
 left join Estrategia e WITH (NOLOCK)  
  on p.CampaniaID BETWEEN e.CampaniaID AND CASE WHEN e.CampaniaIDFin = 0 THEN e.CampaniaID ELSE e.CampaniaIDFin END  
  AND e.CUV2 = p.CUV  
  AND e.Activo = 1  
 left join TipoEstrategia te WITH (NOLOCK)  
  ON te.TipoEstrategiaID = e.TipoEstrategiaID  
  and te.FlagActivo = 1  
 LEFT JOIN @ProductoSugeridoTemp pst on  
  p.CUV = pst.CUV  
 LEFT JOIN ProductoSugeridoPadre psp WITH (NOLOCK) ON p.CUV = psp.CUV and p.CampaniaID = psp.CampaniaID  
 where NOT EXISTS (  
  select ep.CUV  
  from EstrategiaProducto ep WITH (NOLOCK)  
  where ep.Campania = p.CampaniaID  
   and ep.CUV = p.CUV  
   and ep.CUV2 != p.CUV  
   and NOT EXISTS (select tex.Codigo from TipoEstrategia tex where tex.TipoEstrategiaID = e.TipoEstrategiaID and tex.Codigo = '011')  
 )  
  
END  
GO

USE BelcorpCostaRica
GO

IF (OBJECT_ID ( 'dbo.GetProductoComercialByCuvByFilter', 'P' ) IS NULL)
EXEC('CREATE PROCEDURE dbo.GetProductoComercialByCuvByFilter AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE [dbo].GetProductoComercialByCuvByFilter
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
exec dbo.GetProductoComercialByCuvByFilter 201810,1,'11481',2009,2261,'91','9011'  
exec dbo.GetProductoComercialByCampaniaBySearchRegionZona_sb2 201808,1,1,'32072',2701,2161,'50','5052'  
*/  
BEGIN  
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
 DECLARE @ProductoSugeridoTemp TABLE (CUV varchar(6))  
 DECLARE @Producto TABLE  
 (  
  CUV varchar(50),  
  Descripcion varchar(250),  
  PrecioCatalogo numeric(12,2),  
  MarcaID int,  
  CUVProductoFaltante varchar(50),  
  EsExpoOferta bit,  
  CUVRevista varchar(20),  
  PaisID int,  
  CampaniaID int,  
  CodigoCatalago char(6),  
  CodigoProducto varchar(12),  
  IndicadorMontoMinimo int,  
  DescripcionMarca varchar(20),  
  ConfiguracionOfertaID int,  
  TipoOfertaSisID int,  
  IndicadorOferta bit,  
  SAPProductoComercialOfertaRevista varchar(50),  
  PrecioValorizado numeric(12,2),  
  CodigoSAPProductosLanzamiento bit,  
  TipoOfertaRevista varchar(20)  
 )  
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
 WHERE  
  c.codigo = @CampaniaID  
  and CHARINDEX(@CodigoDescripcion,op.CUV)>0  
  
 -- Producto Faltante  
 INSERT INTO @ProductoFaltanteTemp  
 SELECT DISTINCT  
  CUV  
 FROM dbo.ProductoFaltante WITH (NOLOCK)  
 WHERE  
  CampaniaID = @CampaniaID  
  AND Zonaid = @ZonaID  
  AND CHARINDEX(@CodigoDescripcion,CUV)>0  
 UNION ALL  
 SELECT DISTINCT  
  ltrim(rtrim(fa.CodigoVenta)) AS CUV  
 FROM ods.FaltanteAnunciado fa WITH (NOLOCK)  
 INNER JOIN ods.Campania c WITH (NOLOCK)  
  ON fa.CampaniaID = c.CampaniaID  
 WHERE c.Codigo = @CampaniaID  
  and CHARINDEX(@CodigoDescripcion,rtrim(fa.CodigoVenta))>0  
  AND ( rtrim(fa.CodigoRegion) = @CodigoRegion OR fa.CodigoRegion IS NULL )  
  AND ( rtrim(fa.CodigoZona) = @CodigoZona OR fa.CodigoZona IS NULL )  
  
 -- Producto Sugerido  
 insert into @ProductoSugeridoTemp  
 select CUV  
 from dbo.ProductoSugerido WITH (NOLOCK)  
 where  
  CampaniaID = @CampaniaID  
  and CHARINDEX(@CodigoDescripcion,CUV)>0  
  and Estado = 1  
  
 -- Producto Comercial  
 insert into @Producto  
 SELECT DISTINCT TOP (@RowCount)  
  p.CUV  
  ,coalesce(op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion) AS Descripcion  
  ,coalesce(op.PrecioOferta, pd.PrecioProducto * pd.FactorRepeticion, p.PrecioUnitario * p.FactorRepeticion) AS PrecioCatalogo  
  ,p.MarcaID  
  ,pf.CUV  
  ,pcc.EsExpoOferta  
  ,pcc.CUVRevista  
  ,p.PaisID  
  ,p.AnoCampania AS CampaniaID  
  ,p.CodigoCatalago  
  ,p.CodigoProducto  
  ,p.IndicadorMontoMinimo  
  ,M.Descripcion AS DescripcionMarca  
  ,op.ConfiguracionOfertaID  
  ,op.TipoOfertaSisID  
  ,P.IndicadorOferta  
  ,pcor.SAP  
  ,p.PrecioValorizado  
  ,pl.CodigoSAP  
  ,pcor.Oferta  
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
 LEFT JOIN Marca M WITH (NOLOCK)  
  ON p.MarcaId = M.MarcaId  
 LEFT JOIN ods.ProductosLanzamiento pl WITH (NOLOCK)  
  ON p.CodigoProducto = pl.CodigoSAP  
  AND p.AnoCampania = pl.Campania  
 LEFT JOIN ProductoComercialOfertaRevista pcor WITH (NOLOCK)  
  ON p.AnoCampania = pcor.Campania  
  AND p.CUV = pcor.CUV  
 WHERE  
  p.AnoCampania = @CampaniaID  
  AND p.IndicadorDigitable = 1  
  AND CHARINDEX(@CodigoDescripcion, p.CUV) > 0  
  
 -- Select final  
 select distinct top (@RowCount)  
  p.CUV,  
  coalesce(e.DescripcionCUV2, p.Descripcion) as Descripcion,  
  coalesce(e.Precio2, p.PrecioCatalogo) as PrecioCatalogo,  
  p.MarcaID,  
  0 AS EstaEnRevista,  
  case when isnull(p.CUVProductoFaltante,0) = 0 then 1 else 0 end as TieneStock,  
  p.EsExpoOferta as EsExpoOferta,  
  p.CUVRevista as CUVRevista,  
  '' AS CUVComplemento,  
  p.PaisID,  
  p.CampaniaID,  
  p.CodigoCatalago,  
  p.CodigoProducto,  
  p.IndicadorMontoMinimo,  
  p.DescripcionMarca,  
  'NO DISPONIBLE' AS DescripcionCategoria,  
  te.DescripcionEstrategia,  
  p.ConfiguracionOfertaID as ConfiguracionOfertaID,  
  p.TipoOfertaSisID as TipoOfertaSisID,  
  te.flagNueva as FlagNueva,  
  e.EstrategiaID as EstrategiaID,
  e.codigoEstrategia as CodigoEstrategia,
  te.TipoEstrategiaID as TipoEstrategiaID,  
  p.IndicadorOferta,  
  --case when pst.CUV is null then 0 else 1 end as TieneSugerido,  
  CASE WHEN ISNULL(pst.CUV, 0) = 0 THEN 0 ELSE  
            CASE WHEN ISNULL(psp.MostrarAgotado, 0) = 0 THEN 1 ELSE  
                CASE WHEN isnull(p.CUVProductoFaltante,0) = 0 THEN 0 ELSE 1 END  
            END  
        END TieneSugerido,  
  case when p.SAPProductoComercialOfertaRevista is null then 0 else 1 end as TieneOfertaRevista,  
  p.PrecioValorizado,  
  case when p.CodigoSAPProductosLanzamiento is null then 0 else 1 end as TieneLanzamientoCatalogoPersonalizado,  
  p.TipoOfertaRevista as TipoOfertaRevista,  
  te.Codigo as TipoEstrategiaCodigo,  
  case when te.MostrarImgOfertaIndependiente = 1 and e.EsOfertaIndependiente = 1 then 1 else 0 end as EsOfertaIndependiente  
 from @Producto p  
 left join Estrategia e WITH (NOLOCK)  
  on p.CampaniaID BETWEEN e.CampaniaID AND CASE WHEN e.CampaniaIDFin = 0 THEN e.CampaniaID ELSE e.CampaniaIDFin END  
  AND e.CUV2 = p.CUV  
  AND e.Activo = 1  
 left join TipoEstrategia te WITH (NOLOCK)  
  ON te.TipoEstrategiaID = e.TipoEstrategiaID  
  and te.FlagActivo = 1  
 LEFT JOIN @ProductoSugeridoTemp pst on  
  p.CUV = pst.CUV  
 LEFT JOIN ProductoSugeridoPadre psp WITH (NOLOCK) ON p.CUV = psp.CUV and p.CampaniaID = psp.CampaniaID  
 where NOT EXISTS (  
  select ep.CUV  
  from EstrategiaProducto ep WITH (NOLOCK)  
  where ep.Campania = p.CampaniaID  
   and ep.CUV = p.CUV  
   and ep.CUV2 != p.CUV  
   and NOT EXISTS (select tex.Codigo from TipoEstrategia tex where tex.TipoEstrategiaID = e.TipoEstrategiaID and tex.Codigo = '011')  
 )  
  
END  
GO

USE BelcorpChile
GO

IF (OBJECT_ID ( 'dbo.GetProductoComercialByCuvByFilter', 'P' ) IS NULL)
EXEC('CREATE PROCEDURE dbo.GetProductoComercialByCuvByFilter AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE [dbo].GetProductoComercialByCuvByFilter
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
exec dbo.GetProductoComercialByCuvByFilter 201810,1,'11481',2009,2261,'91','9011'  
exec dbo.GetProductoComercialByCampaniaBySearchRegionZona_sb2 201808,1,1,'32072',2701,2161,'50','5052'  
*/  
BEGIN  
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
 DECLARE @ProductoSugeridoTemp TABLE (CUV varchar(6))  
 DECLARE @Producto TABLE  
 (  
  CUV varchar(50),  
  Descripcion varchar(250),  
  PrecioCatalogo numeric(12,2),  
  MarcaID int,  
  CUVProductoFaltante varchar(50),  
  EsExpoOferta bit,  
  CUVRevista varchar(20),  
  PaisID int,  
  CampaniaID int,  
  CodigoCatalago char(6),  
  CodigoProducto varchar(12),  
  IndicadorMontoMinimo int,  
  DescripcionMarca varchar(20),  
  ConfiguracionOfertaID int,  
  TipoOfertaSisID int,  
  IndicadorOferta bit,  
  SAPProductoComercialOfertaRevista varchar(50),  
  PrecioValorizado numeric(12,2),  
  CodigoSAPProductosLanzamiento bit,  
  TipoOfertaRevista varchar(20)  
 )  
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
 WHERE  
  c.codigo = @CampaniaID  
  and CHARINDEX(@CodigoDescripcion,op.CUV)>0  
  
 -- Producto Faltante  
 INSERT INTO @ProductoFaltanteTemp  
 SELECT DISTINCT  
  CUV  
 FROM dbo.ProductoFaltante WITH (NOLOCK)  
 WHERE  
  CampaniaID = @CampaniaID  
  AND Zonaid = @ZonaID  
  AND CHARINDEX(@CodigoDescripcion,CUV)>0  
 UNION ALL  
 SELECT DISTINCT  
  ltrim(rtrim(fa.CodigoVenta)) AS CUV  
 FROM ods.FaltanteAnunciado fa WITH (NOLOCK)  
 INNER JOIN ods.Campania c WITH (NOLOCK)  
  ON fa.CampaniaID = c.CampaniaID  
 WHERE c.Codigo = @CampaniaID  
  and CHARINDEX(@CodigoDescripcion,rtrim(fa.CodigoVenta))>0  
  AND ( rtrim(fa.CodigoRegion) = @CodigoRegion OR fa.CodigoRegion IS NULL )  
  AND ( rtrim(fa.CodigoZona) = @CodigoZona OR fa.CodigoZona IS NULL )  
  
 -- Producto Sugerido  
 insert into @ProductoSugeridoTemp  
 select CUV  
 from dbo.ProductoSugerido WITH (NOLOCK)  
 where  
  CampaniaID = @CampaniaID  
  and CHARINDEX(@CodigoDescripcion,CUV)>0  
  and Estado = 1  
  
 -- Producto Comercial  
 insert into @Producto  
 SELECT DISTINCT TOP (@RowCount)  
  p.CUV  
  ,coalesce(op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion) AS Descripcion  
  ,coalesce(op.PrecioOferta, pd.PrecioProducto * pd.FactorRepeticion, p.PrecioUnitario * p.FactorRepeticion) AS PrecioCatalogo  
  ,p.MarcaID  
  ,pf.CUV  
  ,pcc.EsExpoOferta  
  ,pcc.CUVRevista  
  ,p.PaisID  
  ,p.AnoCampania AS CampaniaID  
  ,p.CodigoCatalago  
  ,p.CodigoProducto  
  ,p.IndicadorMontoMinimo  
  ,M.Descripcion AS DescripcionMarca  
  ,op.ConfiguracionOfertaID  
  ,op.TipoOfertaSisID  
  ,P.IndicadorOferta  
  ,pcor.SAP  
  ,p.PrecioValorizado  
  ,pl.CodigoSAP  
  ,pcor.Oferta  
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
 LEFT JOIN Marca M WITH (NOLOCK)  
  ON p.MarcaId = M.MarcaId  
 LEFT JOIN ods.ProductosLanzamiento pl WITH (NOLOCK)  
  ON p.CodigoProducto = pl.CodigoSAP  
  AND p.AnoCampania = pl.Campania  
 LEFT JOIN ProductoComercialOfertaRevista pcor WITH (NOLOCK)  
  ON p.AnoCampania = pcor.Campania  
  AND p.CUV = pcor.CUV  
 WHERE  
  p.AnoCampania = @CampaniaID  
  AND p.IndicadorDigitable = 1  
  AND CHARINDEX(@CodigoDescripcion, p.CUV) > 0  
  
 -- Select final  
 select distinct top (@RowCount)  
  p.CUV,  
  coalesce(e.DescripcionCUV2, p.Descripcion) as Descripcion,  
  coalesce(e.Precio2, p.PrecioCatalogo) as PrecioCatalogo,  
  p.MarcaID,  
  0 AS EstaEnRevista,  
  case when isnull(p.CUVProductoFaltante,0) = 0 then 1 else 0 end as TieneStock,  
  p.EsExpoOferta as EsExpoOferta,  
  p.CUVRevista as CUVRevista,  
  '' AS CUVComplemento,  
  p.PaisID,  
  p.CampaniaID,  
  p.CodigoCatalago,  
  p.CodigoProducto,  
  p.IndicadorMontoMinimo,  
  p.DescripcionMarca,  
  'NO DISPONIBLE' AS DescripcionCategoria,  
  te.DescripcionEstrategia,  
  p.ConfiguracionOfertaID as ConfiguracionOfertaID,  
  p.TipoOfertaSisID as TipoOfertaSisID,  
  te.flagNueva as FlagNueva,  
  e.EstrategiaID as EstrategiaID,
  e.codigoEstrategia as CodigoEstrategia,
  te.TipoEstrategiaID as TipoEstrategiaID,  
  p.IndicadorOferta,  
  --case when pst.CUV is null then 0 else 1 end as TieneSugerido,  
  CASE WHEN ISNULL(pst.CUV, 0) = 0 THEN 0 ELSE  
            CASE WHEN ISNULL(psp.MostrarAgotado, 0) = 0 THEN 1 ELSE  
                CASE WHEN isnull(p.CUVProductoFaltante,0) = 0 THEN 0 ELSE 1 END  
            END  
        END TieneSugerido,  
  case when p.SAPProductoComercialOfertaRevista is null then 0 else 1 end as TieneOfertaRevista,  
  p.PrecioValorizado,  
  case when p.CodigoSAPProductosLanzamiento is null then 0 else 1 end as TieneLanzamientoCatalogoPersonalizado,  
  p.TipoOfertaRevista as TipoOfertaRevista,  
  te.Codigo as TipoEstrategiaCodigo,  
  case when te.MostrarImgOfertaIndependiente = 1 and e.EsOfertaIndependiente = 1 then 1 else 0 end as EsOfertaIndependiente  
 from @Producto p  
 left join Estrategia e WITH (NOLOCK)  
  on p.CampaniaID BETWEEN e.CampaniaID AND CASE WHEN e.CampaniaIDFin = 0 THEN e.CampaniaID ELSE e.CampaniaIDFin END  
  AND e.CUV2 = p.CUV  
  AND e.Activo = 1  
 left join TipoEstrategia te WITH (NOLOCK)  
  ON te.TipoEstrategiaID = e.TipoEstrategiaID  
  and te.FlagActivo = 1  
 LEFT JOIN @ProductoSugeridoTemp pst on  
  p.CUV = pst.CUV  
 LEFT JOIN ProductoSugeridoPadre psp WITH (NOLOCK) ON p.CUV = psp.CUV and p.CampaniaID = psp.CampaniaID  
 where NOT EXISTS (  
  select ep.CUV  
  from EstrategiaProducto ep WITH (NOLOCK)  
  where ep.Campania = p.CampaniaID  
   and ep.CUV = p.CUV  
   and ep.CUV2 != p.CUV  
   and NOT EXISTS (select tex.Codigo from TipoEstrategia tex where tex.TipoEstrategiaID = e.TipoEstrategiaID and tex.Codigo = '011')  
 )  
  
END  
GO

USE BelcorpBolivia
GO

IF (OBJECT_ID ( 'dbo.GetProductoComercialByCuvByFilter', 'P' ) IS NULL)
EXEC('CREATE PROCEDURE dbo.GetProductoComercialByCuvByFilter AS SET NOCOUNT ON;')
GO
ALTER PROCEDURE [dbo].GetProductoComercialByCuvByFilter
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
exec dbo.GetProductoComercialByCuvByFilter 201810,1,'11481',2009,2261,'91','9011'  
exec dbo.GetProductoComercialByCampaniaBySearchRegionZona_sb2 201808,1,1,'32072',2701,2161,'50','5052'  
*/  
BEGIN  
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
 DECLARE @ProductoSugeridoTemp TABLE (CUV varchar(6))  
 DECLARE @Producto TABLE  
 (  
  CUV varchar(50),  
  Descripcion varchar(250),  
  PrecioCatalogo numeric(12,2),  
  MarcaID int,  
  CUVProductoFaltante varchar(50),  
  EsExpoOferta bit,  
  CUVRevista varchar(20),  
  PaisID int,  
  CampaniaID int,  
  CodigoCatalago char(6),  
  CodigoProducto varchar(12),  
  IndicadorMontoMinimo int,  
  DescripcionMarca varchar(20),  
  ConfiguracionOfertaID int,  
  TipoOfertaSisID int,  
  IndicadorOferta bit,  
  SAPProductoComercialOfertaRevista varchar(50),  
  PrecioValorizado numeric(12,2),  
  CodigoSAPProductosLanzamiento bit,  
  TipoOfertaRevista varchar(20)  
 )  
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
 WHERE  
  c.codigo = @CampaniaID  
  and CHARINDEX(@CodigoDescripcion,op.CUV)>0  
  
 -- Producto Faltante  
 INSERT INTO @ProductoFaltanteTemp  
 SELECT DISTINCT  
  CUV  
 FROM dbo.ProductoFaltante WITH (NOLOCK)  
 WHERE  
  CampaniaID = @CampaniaID  
  AND Zonaid = @ZonaID  
  AND CHARINDEX(@CodigoDescripcion,CUV)>0  
 UNION ALL  
 SELECT DISTINCT  
  ltrim(rtrim(fa.CodigoVenta)) AS CUV  
 FROM ods.FaltanteAnunciado fa WITH (NOLOCK)  
 INNER JOIN ods.Campania c WITH (NOLOCK)  
  ON fa.CampaniaID = c.CampaniaID  
 WHERE c.Codigo = @CampaniaID  
  and CHARINDEX(@CodigoDescripcion,rtrim(fa.CodigoVenta))>0  
  AND ( rtrim(fa.CodigoRegion) = @CodigoRegion OR fa.CodigoRegion IS NULL )  
  AND ( rtrim(fa.CodigoZona) = @CodigoZona OR fa.CodigoZona IS NULL )  
  
 -- Producto Sugerido  
 insert into @ProductoSugeridoTemp  
 select CUV  
 from dbo.ProductoSugerido WITH (NOLOCK)  
 where  
  CampaniaID = @CampaniaID  
  and CHARINDEX(@CodigoDescripcion,CUV)>0  
  and Estado = 1  
  
 -- Producto Comercial  
 insert into @Producto  
 SELECT DISTINCT TOP (@RowCount)  
  p.CUV  
  ,coalesce(op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion) AS Descripcion  
  ,coalesce(op.PrecioOferta, pd.PrecioProducto * pd.FactorRepeticion, p.PrecioUnitario * p.FactorRepeticion) AS PrecioCatalogo  
  ,p.MarcaID  
  ,pf.CUV  
  ,pcc.EsExpoOferta  
  ,pcc.CUVRevista  
  ,p.PaisID  
  ,p.AnoCampania AS CampaniaID  
  ,p.CodigoCatalago  
  ,p.CodigoProducto  
  ,p.IndicadorMontoMinimo  
  ,M.Descripcion AS DescripcionMarca  
  ,op.ConfiguracionOfertaID  
  ,op.TipoOfertaSisID  
  ,P.IndicadorOferta  
  ,pcor.SAP  
  ,p.PrecioValorizado  
  ,pl.CodigoSAP  
  ,pcor.Oferta  
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
 LEFT JOIN Marca M WITH (NOLOCK)  
  ON p.MarcaId = M.MarcaId  
 LEFT JOIN ods.ProductosLanzamiento pl WITH (NOLOCK)  
  ON p.CodigoProducto = pl.CodigoSAP  
  AND p.AnoCampania = pl.Campania  
 LEFT JOIN ProductoComercialOfertaRevista pcor WITH (NOLOCK)  
  ON p.AnoCampania = pcor.Campania  
  AND p.CUV = pcor.CUV  
 WHERE  
  p.AnoCampania = @CampaniaID  
  AND p.IndicadorDigitable = 1  
  AND CHARINDEX(@CodigoDescripcion, p.CUV) > 0  
  
 -- Select final  
 select distinct top (@RowCount)  
  p.CUV,  
  coalesce(e.DescripcionCUV2, p.Descripcion) as Descripcion,  
  coalesce(e.Precio2, p.PrecioCatalogo) as PrecioCatalogo,  
  p.MarcaID,  
  0 AS EstaEnRevista,  
  case when isnull(p.CUVProductoFaltante,0) = 0 then 1 else 0 end as TieneStock,  
  p.EsExpoOferta as EsExpoOferta,  
  p.CUVRevista as CUVRevista,  
  '' AS CUVComplemento,  
  p.PaisID,  
  p.CampaniaID,  
  p.CodigoCatalago,  
  p.CodigoProducto,  
  p.IndicadorMontoMinimo,  
  p.DescripcionMarca,  
  'NO DISPONIBLE' AS DescripcionCategoria,  
  te.DescripcionEstrategia,  
  p.ConfiguracionOfertaID as ConfiguracionOfertaID,  
  p.TipoOfertaSisID as TipoOfertaSisID,  
  te.flagNueva as FlagNueva,  
  e.EstrategiaID as EstrategiaID,
  e.codigoEstrategia as CodigoEstrategia,
  te.TipoEstrategiaID as TipoEstrategiaID,  
  p.IndicadorOferta,  
  --case when pst.CUV is null then 0 else 1 end as TieneSugerido,  
  CASE WHEN ISNULL(pst.CUV, 0) = 0 THEN 0 ELSE  
            CASE WHEN ISNULL(psp.MostrarAgotado, 0) = 0 THEN 1 ELSE  
                CASE WHEN isnull(p.CUVProductoFaltante,0) = 0 THEN 0 ELSE 1 END  
            END  
        END TieneSugerido,  
  case when p.SAPProductoComercialOfertaRevista is null then 0 else 1 end as TieneOfertaRevista,  
  p.PrecioValorizado,  
  case when p.CodigoSAPProductosLanzamiento is null then 0 else 1 end as TieneLanzamientoCatalogoPersonalizado,  
  p.TipoOfertaRevista as TipoOfertaRevista,  
  te.Codigo as TipoEstrategiaCodigo,  
  case when te.MostrarImgOfertaIndependiente = 1 and e.EsOfertaIndependiente = 1 then 1 else 0 end as EsOfertaIndependiente  
 from @Producto p  
 left join Estrategia e WITH (NOLOCK)  
  on p.CampaniaID BETWEEN e.CampaniaID AND CASE WHEN e.CampaniaIDFin = 0 THEN e.CampaniaID ELSE e.CampaniaIDFin END  
  AND e.CUV2 = p.CUV  
  AND e.Activo = 1  
 left join TipoEstrategia te WITH (NOLOCK)  
  ON te.TipoEstrategiaID = e.TipoEstrategiaID  
  and te.FlagActivo = 1  
 LEFT JOIN @ProductoSugeridoTemp pst on  
  p.CUV = pst.CUV  
 LEFT JOIN ProductoSugeridoPadre psp WITH (NOLOCK) ON p.CUV = psp.CUV and p.CampaniaID = psp.CampaniaID  
 where NOT EXISTS (  
  select ep.CUV  
  from EstrategiaProducto ep WITH (NOLOCK)  
  where ep.Campania = p.CampaniaID  
   and ep.CUV = p.CUV  
   and ep.CUV2 != p.CUV  
   and NOT EXISTS (select tex.Codigo from TipoEstrategia tex where tex.TipoEstrategiaID = e.TipoEstrategiaID and tex.Codigo = '011')  
 )  
  
END  
GO

