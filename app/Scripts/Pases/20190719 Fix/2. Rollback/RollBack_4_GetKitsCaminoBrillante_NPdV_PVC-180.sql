USE BelcorpPeru
GO

ALTER PROCEDURE [dbo].[GetKitsCaminoBrillante] (
@Periodo int,
@Campania int,
@CuvsStringList xml
)
As
BEGIN
DECLARE @CuvsKits AS TABLE (
Cuv varchar(20)
)
INSERT INTO @CuvsKits (Cuv)
SELECT
componente.value('(text())[1]','VARCHAR(20)') AS Cuv
FROM
@CuvsStringList.nodes('/ArrayOfString/string')AS TEMPTABLE(componente);
SELECT
KIT.Cuv AS CUV
,PROD.PrecioValorizado AS PrecioValorizado
,PROD.PrecioCatalogo AS PrecioCatalogo
,0 AS EstrategiaID --Validar si es Necesario
,'0' AS CodigoEstrategia --Validar si es Necesario
,COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, PROD.Descripcion) AS DescripcionCUV
,ISNULL(PROD.MarcaID,0) AS MarcaID
,MAR.Descripcion AS DescripcionMarca
,ik.NombreImagen AS FotoProductoSmall
,ik.NombreImagen AS FotoProductoMedium
,0 AS TipoEstrategiaID
,0 AS OrigenPedidoWebFicha
FROM @CuvsKits AS KIT
LEFT JOIN ods.productocomercial AS PROD WITH (NOLOCK) ON PROD.CUV = KIT.Cuv AND PROD.AnoCampania= @Campania
LEFT JOIN Marca MAR WITH (NOLOCK) ON MAR.MarcaID = PROD.MarcaID
LEFT JOIN EstrategiaImagenKit ik WITH (NOLOCK) on PROD.AnoCampania = ik.CampaniaID and PROD.CUV = ik.CUV
LEFT JOIN dbo.OfertaProducto OP WITH (NOLOCK) ON OP.CampaniaID = PROD.CampaniaID	AND OP.CUV = PROD.CUV
LEFT JOIN dbo.ProductoDescripcion PD WITH (NOLOCK) ON PROD.AnoCampania = PD.CampaniaID AND PROD.CUV = PD.CUV
LEFT JOIN dbo.MatrizComercial MC WITH (NOLOCK) ON PROD.CodigoProducto = MC.CodigoSAP
WHERE PROD.NumeroPagina IN (204, 205, 206, 207)
END
GO

USE BelcorpMexico
GO

ALTER PROCEDURE [dbo].[GetKitsCaminoBrillante] (
@Periodo int,
@Campania int,
@CuvsStringList xml
)
As
BEGIN
DECLARE @CuvsKits AS TABLE (
Cuv varchar(20)
)
INSERT INTO @CuvsKits (Cuv)
SELECT
componente.value('(text())[1]','VARCHAR(20)') AS Cuv
FROM
@CuvsStringList.nodes('/ArrayOfString/string')AS TEMPTABLE(componente);
SELECT
KIT.Cuv AS CUV
,PROD.PrecioValorizado AS PrecioValorizado
,PROD.PrecioCatalogo AS PrecioCatalogo
,0 AS EstrategiaID --Validar si es Necesario
,'0' AS CodigoEstrategia --Validar si es Necesario
,COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, PROD.Descripcion) AS DescripcionCUV
,ISNULL(PROD.MarcaID,0) AS MarcaID
,MAR.Descripcion AS DescripcionMarca
,ik.NombreImagen AS FotoProductoSmall
,ik.NombreImagen AS FotoProductoMedium
,0 AS TipoEstrategiaID
,0 AS OrigenPedidoWebFicha
FROM @CuvsKits AS KIT
LEFT JOIN ods.productocomercial AS PROD WITH (NOLOCK) ON PROD.CUV = KIT.Cuv AND PROD.AnoCampania= @Campania
LEFT JOIN Marca MAR WITH (NOLOCK) ON MAR.MarcaID = PROD.MarcaID
LEFT JOIN EstrategiaImagenKit ik WITH (NOLOCK) on PROD.AnoCampania = ik.CampaniaID and PROD.CUV = ik.CUV
LEFT JOIN dbo.OfertaProducto OP WITH (NOLOCK) ON OP.CampaniaID = PROD.CampaniaID	AND OP.CUV = PROD.CUV
LEFT JOIN dbo.ProductoDescripcion PD WITH (NOLOCK) ON PROD.AnoCampania = PD.CampaniaID AND PROD.CUV = PD.CUV
LEFT JOIN dbo.MatrizComercial MC WITH (NOLOCK) ON PROD.CodigoProducto = MC.CodigoSAP
WHERE PROD.NumeroPagina IN (204, 205, 206, 207)
END
GO

USE BelcorpColombia
GO

ALTER PROCEDURE [dbo].[GetKitsCaminoBrillante] (
@Periodo int,
@Campania int,
@CuvsStringList xml
)
As
BEGIN
DECLARE @CuvsKits AS TABLE (
Cuv varchar(20)
)
INSERT INTO @CuvsKits (Cuv)
SELECT
componente.value('(text())[1]','VARCHAR(20)') AS Cuv
FROM
@CuvsStringList.nodes('/ArrayOfString/string')AS TEMPTABLE(componente);
SELECT
KIT.Cuv AS CUV
,PROD.PrecioValorizado AS PrecioValorizado
,PROD.PrecioCatalogo AS PrecioCatalogo
,0 AS EstrategiaID --Validar si es Necesario
,'0' AS CodigoEstrategia --Validar si es Necesario
,COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, PROD.Descripcion) AS DescripcionCUV
,ISNULL(PROD.MarcaID,0) AS MarcaID
,MAR.Descripcion AS DescripcionMarca
,ik.NombreImagen AS FotoProductoSmall
,ik.NombreImagen AS FotoProductoMedium
,0 AS TipoEstrategiaID
,0 AS OrigenPedidoWebFicha
FROM @CuvsKits AS KIT
LEFT JOIN ods.productocomercial AS PROD WITH (NOLOCK) ON PROD.CUV = KIT.Cuv AND PROD.AnoCampania= @Campania
LEFT JOIN Marca MAR WITH (NOLOCK) ON MAR.MarcaID = PROD.MarcaID
LEFT JOIN EstrategiaImagenKit ik WITH (NOLOCK) on PROD.AnoCampania = ik.CampaniaID and PROD.CUV = ik.CUV
LEFT JOIN dbo.OfertaProducto OP WITH (NOLOCK) ON OP.CampaniaID = PROD.CampaniaID	AND OP.CUV = PROD.CUV
LEFT JOIN dbo.ProductoDescripcion PD WITH (NOLOCK) ON PROD.AnoCampania = PD.CampaniaID AND PROD.CUV = PD.CUV
LEFT JOIN dbo.MatrizComercial MC WITH (NOLOCK) ON PROD.CodigoProducto = MC.CodigoSAP
WHERE PROD.NumeroPagina IN (204, 205, 206, 207)
END
GO

USE BelcorpSalvador
GO

ALTER PROCEDURE [dbo].[GetKitsCaminoBrillante] (
@Periodo int,
@Campania int,
@CuvsStringList xml
)
As
BEGIN
DECLARE @CuvsKits AS TABLE (
Cuv varchar(20)
)
INSERT INTO @CuvsKits (Cuv)
SELECT
componente.value('(text())[1]','VARCHAR(20)') AS Cuv
FROM
@CuvsStringList.nodes('/ArrayOfString/string')AS TEMPTABLE(componente);
SELECT
KIT.Cuv AS CUV
,PROD.PrecioValorizado AS PrecioValorizado
,PROD.PrecioCatalogo AS PrecioCatalogo
,0 AS EstrategiaID --Validar si es Necesario
,'0' AS CodigoEstrategia --Validar si es Necesario
,COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, PROD.Descripcion) AS DescripcionCUV
,ISNULL(PROD.MarcaID,0) AS MarcaID
,MAR.Descripcion AS DescripcionMarca
,ik.NombreImagen AS FotoProductoSmall
,ik.NombreImagen AS FotoProductoMedium
,0 AS TipoEstrategiaID
,0 AS OrigenPedidoWebFicha
FROM @CuvsKits AS KIT
LEFT JOIN ods.productocomercial AS PROD WITH (NOLOCK) ON PROD.CUV = KIT.Cuv AND PROD.AnoCampania= @Campania
LEFT JOIN Marca MAR WITH (NOLOCK) ON MAR.MarcaID = PROD.MarcaID
LEFT JOIN EstrategiaImagenKit ik WITH (NOLOCK) on PROD.AnoCampania = ik.CampaniaID and PROD.CUV = ik.CUV
LEFT JOIN dbo.OfertaProducto OP WITH (NOLOCK) ON OP.CampaniaID = PROD.CampaniaID	AND OP.CUV = PROD.CUV
LEFT JOIN dbo.ProductoDescripcion PD WITH (NOLOCK) ON PROD.AnoCampania = PD.CampaniaID AND PROD.CUV = PD.CUV
LEFT JOIN dbo.MatrizComercial MC WITH (NOLOCK) ON PROD.CodigoProducto = MC.CodigoSAP
WHERE PROD.NumeroPagina IN (204, 205, 206, 207)
END
GO

USE BelcorpPuertoRico
GO

ALTER PROCEDURE [dbo].[GetKitsCaminoBrillante] (
@Periodo int,
@Campania int,
@CuvsStringList xml
)
As
BEGIN
DECLARE @CuvsKits AS TABLE (
Cuv varchar(20)
)
INSERT INTO @CuvsKits (Cuv)
SELECT
componente.value('(text())[1]','VARCHAR(20)') AS Cuv
FROM
@CuvsStringList.nodes('/ArrayOfString/string')AS TEMPTABLE(componente);
SELECT
KIT.Cuv AS CUV
,PROD.PrecioValorizado AS PrecioValorizado
,PROD.PrecioCatalogo AS PrecioCatalogo
,0 AS EstrategiaID --Validar si es Necesario
,'0' AS CodigoEstrategia --Validar si es Necesario
,COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, PROD.Descripcion) AS DescripcionCUV
,ISNULL(PROD.MarcaID,0) AS MarcaID
,MAR.Descripcion AS DescripcionMarca
,ik.NombreImagen AS FotoProductoSmall
,ik.NombreImagen AS FotoProductoMedium
,0 AS TipoEstrategiaID
,0 AS OrigenPedidoWebFicha
FROM @CuvsKits AS KIT
LEFT JOIN ods.productocomercial AS PROD WITH (NOLOCK) ON PROD.CUV = KIT.Cuv AND PROD.AnoCampania= @Campania
LEFT JOIN Marca MAR WITH (NOLOCK) ON MAR.MarcaID = PROD.MarcaID
LEFT JOIN EstrategiaImagenKit ik WITH (NOLOCK) on PROD.AnoCampania = ik.CampaniaID and PROD.CUV = ik.CUV
LEFT JOIN dbo.OfertaProducto OP WITH (NOLOCK) ON OP.CampaniaID = PROD.CampaniaID	AND OP.CUV = PROD.CUV
LEFT JOIN dbo.ProductoDescripcion PD WITH (NOLOCK) ON PROD.AnoCampania = PD.CampaniaID AND PROD.CUV = PD.CUV
LEFT JOIN dbo.MatrizComercial MC WITH (NOLOCK) ON PROD.CodigoProducto = MC.CodigoSAP
WHERE PROD.NumeroPagina IN (204, 205, 206, 207)
END
GO

USE BelcorpPanama
GO

ALTER PROCEDURE [dbo].[GetKitsCaminoBrillante] (
@Periodo int,
@Campania int,
@CuvsStringList xml
)
As
BEGIN
DECLARE @CuvsKits AS TABLE (
Cuv varchar(20)
)
INSERT INTO @CuvsKits (Cuv)
SELECT
componente.value('(text())[1]','VARCHAR(20)') AS Cuv
FROM
@CuvsStringList.nodes('/ArrayOfString/string')AS TEMPTABLE(componente);
SELECT
KIT.Cuv AS CUV
,PROD.PrecioValorizado AS PrecioValorizado
,PROD.PrecioCatalogo AS PrecioCatalogo
,0 AS EstrategiaID --Validar si es Necesario
,'0' AS CodigoEstrategia --Validar si es Necesario
,COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, PROD.Descripcion) AS DescripcionCUV
,ISNULL(PROD.MarcaID,0) AS MarcaID
,MAR.Descripcion AS DescripcionMarca
,ik.NombreImagen AS FotoProductoSmall
,ik.NombreImagen AS FotoProductoMedium
,0 AS TipoEstrategiaID
,0 AS OrigenPedidoWebFicha
FROM @CuvsKits AS KIT
LEFT JOIN ods.productocomercial AS PROD WITH (NOLOCK) ON PROD.CUV = KIT.Cuv AND PROD.AnoCampania= @Campania
LEFT JOIN Marca MAR WITH (NOLOCK) ON MAR.MarcaID = PROD.MarcaID
LEFT JOIN EstrategiaImagenKit ik WITH (NOLOCK) on PROD.AnoCampania = ik.CampaniaID and PROD.CUV = ik.CUV
LEFT JOIN dbo.OfertaProducto OP WITH (NOLOCK) ON OP.CampaniaID = PROD.CampaniaID	AND OP.CUV = PROD.CUV
LEFT JOIN dbo.ProductoDescripcion PD WITH (NOLOCK) ON PROD.AnoCampania = PD.CampaniaID AND PROD.CUV = PD.CUV
LEFT JOIN dbo.MatrizComercial MC WITH (NOLOCK) ON PROD.CodigoProducto = MC.CodigoSAP
WHERE PROD.NumeroPagina IN (204, 205, 206, 207)
END
GO

USE BelcorpGuatemala
GO

ALTER PROCEDURE [dbo].[GetKitsCaminoBrillante] (
@Periodo int,
@Campania int,
@CuvsStringList xml
)
As
BEGIN
DECLARE @CuvsKits AS TABLE (
Cuv varchar(20)
)
INSERT INTO @CuvsKits (Cuv)
SELECT
componente.value('(text())[1]','VARCHAR(20)') AS Cuv
FROM
@CuvsStringList.nodes('/ArrayOfString/string')AS TEMPTABLE(componente);
SELECT
KIT.Cuv AS CUV
,PROD.PrecioValorizado AS PrecioValorizado
,PROD.PrecioCatalogo AS PrecioCatalogo
,0 AS EstrategiaID --Validar si es Necesario
,'0' AS CodigoEstrategia --Validar si es Necesario
,COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, PROD.Descripcion) AS DescripcionCUV
,ISNULL(PROD.MarcaID,0) AS MarcaID
,MAR.Descripcion AS DescripcionMarca
,ik.NombreImagen AS FotoProductoSmall
,ik.NombreImagen AS FotoProductoMedium
,0 AS TipoEstrategiaID
,0 AS OrigenPedidoWebFicha
FROM @CuvsKits AS KIT
LEFT JOIN ods.productocomercial AS PROD WITH (NOLOCK) ON PROD.CUV = KIT.Cuv AND PROD.AnoCampania= @Campania
LEFT JOIN Marca MAR WITH (NOLOCK) ON MAR.MarcaID = PROD.MarcaID
LEFT JOIN EstrategiaImagenKit ik WITH (NOLOCK) on PROD.AnoCampania = ik.CampaniaID and PROD.CUV = ik.CUV
LEFT JOIN dbo.OfertaProducto OP WITH (NOLOCK) ON OP.CampaniaID = PROD.CampaniaID	AND OP.CUV = PROD.CUV
LEFT JOIN dbo.ProductoDescripcion PD WITH (NOLOCK) ON PROD.AnoCampania = PD.CampaniaID AND PROD.CUV = PD.CUV
LEFT JOIN dbo.MatrizComercial MC WITH (NOLOCK) ON PROD.CodigoProducto = MC.CodigoSAP
WHERE PROD.NumeroPagina IN (204, 205, 206, 207)
END
GO

USE BelcorpEcuador
GO

ALTER PROCEDURE [dbo].[GetKitsCaminoBrillante] (
@Periodo int,
@Campania int,
@CuvsStringList xml
)
As
BEGIN
DECLARE @CuvsKits AS TABLE (
Cuv varchar(20)
)
INSERT INTO @CuvsKits (Cuv)
SELECT
componente.value('(text())[1]','VARCHAR(20)') AS Cuv
FROM
@CuvsStringList.nodes('/ArrayOfString/string')AS TEMPTABLE(componente);
SELECT
KIT.Cuv AS CUV
,PROD.PrecioValorizado AS PrecioValorizado
,PROD.PrecioCatalogo AS PrecioCatalogo
,0 AS EstrategiaID --Validar si es Necesario
,'0' AS CodigoEstrategia --Validar si es Necesario
,COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, PROD.Descripcion) AS DescripcionCUV
,ISNULL(PROD.MarcaID,0) AS MarcaID
,MAR.Descripcion AS DescripcionMarca
,ik.NombreImagen AS FotoProductoSmall
,ik.NombreImagen AS FotoProductoMedium
,0 AS TipoEstrategiaID
,0 AS OrigenPedidoWebFicha
FROM @CuvsKits AS KIT
LEFT JOIN ods.productocomercial AS PROD WITH (NOLOCK) ON PROD.CUV = KIT.Cuv AND PROD.AnoCampania= @Campania
LEFT JOIN Marca MAR WITH (NOLOCK) ON MAR.MarcaID = PROD.MarcaID
LEFT JOIN EstrategiaImagenKit ik WITH (NOLOCK) on PROD.AnoCampania = ik.CampaniaID and PROD.CUV = ik.CUV
LEFT JOIN dbo.OfertaProducto OP WITH (NOLOCK) ON OP.CampaniaID = PROD.CampaniaID	AND OP.CUV = PROD.CUV
LEFT JOIN dbo.ProductoDescripcion PD WITH (NOLOCK) ON PROD.AnoCampania = PD.CampaniaID AND PROD.CUV = PD.CUV
LEFT JOIN dbo.MatrizComercial MC WITH (NOLOCK) ON PROD.CodigoProducto = MC.CodigoSAP
WHERE PROD.NumeroPagina IN (204, 205, 206, 207)
END
GO

USE BelcorpDominicana
GO

ALTER PROCEDURE [dbo].[GetKitsCaminoBrillante] (
@Periodo int,
@Campania int,
@CuvsStringList xml
)
As
BEGIN
DECLARE @CuvsKits AS TABLE (
Cuv varchar(20)
)
INSERT INTO @CuvsKits (Cuv)
SELECT
componente.value('(text())[1]','VARCHAR(20)') AS Cuv
FROM
@CuvsStringList.nodes('/ArrayOfString/string')AS TEMPTABLE(componente);
SELECT
KIT.Cuv AS CUV
,PROD.PrecioValorizado AS PrecioValorizado
,PROD.PrecioCatalogo AS PrecioCatalogo
,0 AS EstrategiaID --Validar si es Necesario
,'0' AS CodigoEstrategia --Validar si es Necesario
,COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, PROD.Descripcion) AS DescripcionCUV
,ISNULL(PROD.MarcaID,0) AS MarcaID
,MAR.Descripcion AS DescripcionMarca
,ik.NombreImagen AS FotoProductoSmall
,ik.NombreImagen AS FotoProductoMedium
,0 AS TipoEstrategiaID
,0 AS OrigenPedidoWebFicha
FROM @CuvsKits AS KIT
LEFT JOIN ods.productocomercial AS PROD WITH (NOLOCK) ON PROD.CUV = KIT.Cuv AND PROD.AnoCampania= @Campania
LEFT JOIN Marca MAR WITH (NOLOCK) ON MAR.MarcaID = PROD.MarcaID
LEFT JOIN EstrategiaImagenKit ik WITH (NOLOCK) on PROD.AnoCampania = ik.CampaniaID and PROD.CUV = ik.CUV
LEFT JOIN dbo.OfertaProducto OP WITH (NOLOCK) ON OP.CampaniaID = PROD.CampaniaID	AND OP.CUV = PROD.CUV
LEFT JOIN dbo.ProductoDescripcion PD WITH (NOLOCK) ON PROD.AnoCampania = PD.CampaniaID AND PROD.CUV = PD.CUV
LEFT JOIN dbo.MatrizComercial MC WITH (NOLOCK) ON PROD.CodigoProducto = MC.CodigoSAP
WHERE PROD.NumeroPagina IN (204, 205, 206, 207)
END
GO

USE BelcorpCostaRica
GO

ALTER PROCEDURE [dbo].[GetKitsCaminoBrillante] (
@Periodo int,
@Campania int,
@CuvsStringList xml
)
As
BEGIN
DECLARE @CuvsKits AS TABLE (
Cuv varchar(20)
)
INSERT INTO @CuvsKits (Cuv)
SELECT
componente.value('(text())[1]','VARCHAR(20)') AS Cuv
FROM
@CuvsStringList.nodes('/ArrayOfString/string')AS TEMPTABLE(componente);
SELECT
KIT.Cuv AS CUV
,PROD.PrecioValorizado AS PrecioValorizado
,PROD.PrecioCatalogo AS PrecioCatalogo
,0 AS EstrategiaID --Validar si es Necesario
,'0' AS CodigoEstrategia --Validar si es Necesario
,COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, PROD.Descripcion) AS DescripcionCUV
,ISNULL(PROD.MarcaID,0) AS MarcaID
,MAR.Descripcion AS DescripcionMarca
,ik.NombreImagen AS FotoProductoSmall
,ik.NombreImagen AS FotoProductoMedium
,0 AS TipoEstrategiaID
,0 AS OrigenPedidoWebFicha
FROM @CuvsKits AS KIT
LEFT JOIN ods.productocomercial AS PROD WITH (NOLOCK) ON PROD.CUV = KIT.Cuv AND PROD.AnoCampania= @Campania
LEFT JOIN Marca MAR WITH (NOLOCK) ON MAR.MarcaID = PROD.MarcaID
LEFT JOIN EstrategiaImagenKit ik WITH (NOLOCK) on PROD.AnoCampania = ik.CampaniaID and PROD.CUV = ik.CUV
LEFT JOIN dbo.OfertaProducto OP WITH (NOLOCK) ON OP.CampaniaID = PROD.CampaniaID	AND OP.CUV = PROD.CUV
LEFT JOIN dbo.ProductoDescripcion PD WITH (NOLOCK) ON PROD.AnoCampania = PD.CampaniaID AND PROD.CUV = PD.CUV
LEFT JOIN dbo.MatrizComercial MC WITH (NOLOCK) ON PROD.CodigoProducto = MC.CodigoSAP
WHERE PROD.NumeroPagina IN (204, 205, 206, 207)
END
GO

USE BelcorpChile
GO

ALTER PROCEDURE [dbo].[GetKitsCaminoBrillante] (
@Periodo int,
@Campania int,
@CuvsStringList xml
)
As
BEGIN
DECLARE @CuvsKits AS TABLE (
Cuv varchar(20)
)
INSERT INTO @CuvsKits (Cuv)
SELECT
componente.value('(text())[1]','VARCHAR(20)') AS Cuv
FROM
@CuvsStringList.nodes('/ArrayOfString/string')AS TEMPTABLE(componente);
SELECT
KIT.Cuv AS CUV
,PROD.PrecioValorizado AS PrecioValorizado
,PROD.PrecioCatalogo AS PrecioCatalogo
,0 AS EstrategiaID --Validar si es Necesario
,'0' AS CodigoEstrategia --Validar si es Necesario
,COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, PROD.Descripcion) AS DescripcionCUV
,ISNULL(PROD.MarcaID,0) AS MarcaID
,MAR.Descripcion AS DescripcionMarca
,ik.NombreImagen AS FotoProductoSmall
,ik.NombreImagen AS FotoProductoMedium
,0 AS TipoEstrategiaID
,0 AS OrigenPedidoWebFicha
FROM @CuvsKits AS KIT
LEFT JOIN ods.productocomercial AS PROD WITH (NOLOCK) ON PROD.CUV = KIT.Cuv AND PROD.AnoCampania= @Campania
LEFT JOIN Marca MAR WITH (NOLOCK) ON MAR.MarcaID = PROD.MarcaID
LEFT JOIN EstrategiaImagenKit ik WITH (NOLOCK) on PROD.AnoCampania = ik.CampaniaID and PROD.CUV = ik.CUV
LEFT JOIN dbo.OfertaProducto OP WITH (NOLOCK) ON OP.CampaniaID = PROD.CampaniaID	AND OP.CUV = PROD.CUV
LEFT JOIN dbo.ProductoDescripcion PD WITH (NOLOCK) ON PROD.AnoCampania = PD.CampaniaID AND PROD.CUV = PD.CUV
LEFT JOIN dbo.MatrizComercial MC WITH (NOLOCK) ON PROD.CodigoProducto = MC.CodigoSAP
WHERE PROD.NumeroPagina IN (204, 205, 206, 207)
END
GO

USE BelcorpBolivia
GO

ALTER PROCEDURE [dbo].[GetKitsCaminoBrillante] (
@Periodo int,
@Campania int,
@CuvsStringList xml
)
As
BEGIN
DECLARE @CuvsKits AS TABLE (
Cuv varchar(20)
)
INSERT INTO @CuvsKits (Cuv)
SELECT
componente.value('(text())[1]','VARCHAR(20)') AS Cuv
FROM
@CuvsStringList.nodes('/ArrayOfString/string')AS TEMPTABLE(componente);
SELECT
KIT.Cuv AS CUV
,PROD.PrecioValorizado AS PrecioValorizado
,PROD.PrecioCatalogo AS PrecioCatalogo
,0 AS EstrategiaID --Validar si es Necesario
,'0' AS CodigoEstrategia --Validar si es Necesario
,COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, PROD.Descripcion) AS DescripcionCUV
,ISNULL(PROD.MarcaID,0) AS MarcaID
,MAR.Descripcion AS DescripcionMarca
,ik.NombreImagen AS FotoProductoSmall
,ik.NombreImagen AS FotoProductoMedium
,0 AS TipoEstrategiaID
,0 AS OrigenPedidoWebFicha
FROM @CuvsKits AS KIT
LEFT JOIN ods.productocomercial AS PROD WITH (NOLOCK) ON PROD.CUV = KIT.Cuv AND PROD.AnoCampania= @Campania
LEFT JOIN Marca MAR WITH (NOLOCK) ON MAR.MarcaID = PROD.MarcaID
LEFT JOIN EstrategiaImagenKit ik WITH (NOLOCK) on PROD.AnoCampania = ik.CampaniaID and PROD.CUV = ik.CUV
LEFT JOIN dbo.OfertaProducto OP WITH (NOLOCK) ON OP.CampaniaID = PROD.CampaniaID	AND OP.CUV = PROD.CUV
LEFT JOIN dbo.ProductoDescripcion PD WITH (NOLOCK) ON PROD.AnoCampania = PD.CampaniaID AND PROD.CUV = PD.CUV
LEFT JOIN dbo.MatrizComercial MC WITH (NOLOCK) ON PROD.CodigoProducto = MC.CodigoSAP
WHERE PROD.NumeroPagina IN (204, 205, 206, 207)
END
GO

