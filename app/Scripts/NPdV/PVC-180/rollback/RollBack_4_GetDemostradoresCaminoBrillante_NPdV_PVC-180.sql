USE BelcorpPeru
GO

ALTER PROCEDURE [dbo].[GetDemostradoresCaminoBrillante] (
@AnoCampania int,
@NivelCaminoBrillante int
)
AS
BEGIN
DECLARE @TipoOferta int;
SELECT @TipoOferta = CASE @NivelCaminoBrillante
WHEN 2 THEN 200
WHEN 3 THEN 201
WHEN 4 THEN 202
WHEN 5 THEN 203
WHEN 6 THEN 203
ELSE null
END;
SELECT
PROD.CodigoProducto AS CodigoProducto
,COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, PROD.Descripcion) AS Descripcion
,PROD.PrecioValorizado AS PrecioValorizado
,PROD.PrecioCatalogo AS PrecioCatalogo
,PROD.CUV AS CUV
,0 AS EstrategiaID
,'0' AS CodigoEstrategia
,COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, PROD.Descripcion) AS DescripcionCUV
,EST.DescripcionCUV2 AS DescripcionCortaCUV
,ISNULL(MAR.MarcaID,0) AS MarcaID
,ISNULL(MAR.Codigo,'00') AS CodigoMarca
,MAR.Nombre AS DescripcionMarca
,PROD.PrecioValorizado AS PrecioFinal
,PROD.PrecioValorizado - PROD.PrecioCatalogo AS Ganancia
,EIM.NombreImagen AS FotoProductoSmall
,EIM.NombreImagen AS FotoProductoMedium
,0 AS TipoEstrategiaID
,(CASE CodigoTipoOferta WHEN '085' THEN 1 WHEN '087' THEN 1 ELSE 0 END) AS EsCatalogo
FROM ods.productocomercial AS PROD WITH (NOLOCK) LEFT JOIN dbo.Estrategia AS EST
ON PROD.CUV = EST.CUV2 AND EST.CampaniaID = PROD.AnoCampania
LEFT JOIN ods.Marca MAR WITH (NOLOCK)
ON MAR.MarcaID = PROD.MarcaID
LEFT JOIN dbo.EstrategiaImagen AS EIM WITH (NOLOCK)
ON EIM.CampaniaID = PROD.AnoCampania AND EIM.CUV = PROD.CUV
LEFT JOIN dbo.OfertaProducto OP WITH (NOLOCK) ON OP.CampaniaID = PROD.CampaniaID	AND OP.CUV = PROD.CUV
LEFT JOIN dbo.ProductoDescripcion PD WITH (NOLOCK) ON PROD.AnoCampania = PD.CampaniaID AND PROD.CUV = PD.CUV
LEFT JOIN dbo.MatrizComercial MC WITH (NOLOCK) ON PROD.CodigoProducto = MC.CodigoSAP
WHERE PROD.AnoCampania = @AnoCampania
and PROD.CodigoCatalago = 35
and PROD.NumeroPagina = @TipoOferta
END
GO

USE BelcorpMexico
GO

ALTER PROCEDURE [dbo].[GetDemostradoresCaminoBrillante] (
@AnoCampania int,
@NivelCaminoBrillante int
)
AS
BEGIN
DECLARE @TipoOferta int;
SELECT @TipoOferta = CASE @NivelCaminoBrillante
WHEN 2 THEN 200
WHEN 3 THEN 201
WHEN 4 THEN 202
WHEN 5 THEN 203
WHEN 6 THEN 203
ELSE null
END;
SELECT
PROD.CodigoProducto AS CodigoProducto
,COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, PROD.Descripcion) AS Descripcion
,PROD.PrecioValorizado AS PrecioValorizado
,PROD.PrecioCatalogo AS PrecioCatalogo
,PROD.CUV AS CUV
,0 AS EstrategiaID
,'0' AS CodigoEstrategia
,COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, PROD.Descripcion) AS DescripcionCUV
,EST.DescripcionCUV2 AS DescripcionCortaCUV
,ISNULL(MAR.MarcaID,0) AS MarcaID
,ISNULL(MAR.Codigo,'00') AS CodigoMarca
,MAR.Nombre AS DescripcionMarca
,PROD.PrecioValorizado AS PrecioFinal
,PROD.PrecioValorizado - PROD.PrecioCatalogo AS Ganancia
,EIM.NombreImagen AS FotoProductoSmall
,EIM.NombreImagen AS FotoProductoMedium
,0 AS TipoEstrategiaID
,(CASE CodigoTipoOferta WHEN '085' THEN 1 WHEN '087' THEN 1 ELSE 0 END) AS EsCatalogo
FROM ods.productocomercial AS PROD WITH (NOLOCK) LEFT JOIN dbo.Estrategia AS EST
ON PROD.CUV = EST.CUV2 AND EST.CampaniaID = PROD.AnoCampania
LEFT JOIN ods.Marca MAR WITH (NOLOCK)
ON MAR.MarcaID = PROD.MarcaID
LEFT JOIN dbo.EstrategiaImagen AS EIM WITH (NOLOCK)
ON EIM.CampaniaID = PROD.AnoCampania AND EIM.CUV = PROD.CUV
LEFT JOIN dbo.OfertaProducto OP WITH (NOLOCK) ON OP.CampaniaID = PROD.CampaniaID	AND OP.CUV = PROD.CUV
LEFT JOIN dbo.ProductoDescripcion PD WITH (NOLOCK) ON PROD.AnoCampania = PD.CampaniaID AND PROD.CUV = PD.CUV
LEFT JOIN dbo.MatrizComercial MC WITH (NOLOCK) ON PROD.CodigoProducto = MC.CodigoSAP
WHERE PROD.AnoCampania = @AnoCampania
and PROD.CodigoCatalago = 35
and PROD.NumeroPagina = @TipoOferta
END
GO

USE BelcorpColombia
GO

ALTER PROCEDURE [dbo].[GetDemostradoresCaminoBrillante] (
@AnoCampania int,
@NivelCaminoBrillante int
)
AS
BEGIN
DECLARE @TipoOferta int;
SELECT @TipoOferta = CASE @NivelCaminoBrillante
WHEN 2 THEN 200
WHEN 3 THEN 201
WHEN 4 THEN 202
WHEN 5 THEN 203
WHEN 6 THEN 203
ELSE null
END;
SELECT
PROD.CodigoProducto AS CodigoProducto
,COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, PROD.Descripcion) AS Descripcion
,PROD.PrecioValorizado AS PrecioValorizado
,PROD.PrecioCatalogo AS PrecioCatalogo
,PROD.CUV AS CUV
,0 AS EstrategiaID
,'0' AS CodigoEstrategia
,COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, PROD.Descripcion) AS DescripcionCUV
,EST.DescripcionCUV2 AS DescripcionCortaCUV
,ISNULL(MAR.MarcaID,0) AS MarcaID
,ISNULL(MAR.Codigo,'00') AS CodigoMarca
,MAR.Nombre AS DescripcionMarca
,PROD.PrecioValorizado AS PrecioFinal
,PROD.PrecioValorizado - PROD.PrecioCatalogo AS Ganancia
,EIM.NombreImagen AS FotoProductoSmall
,EIM.NombreImagen AS FotoProductoMedium
,0 AS TipoEstrategiaID
,(CASE CodigoTipoOferta WHEN '085' THEN 1 WHEN '087' THEN 1 ELSE 0 END) AS EsCatalogo
FROM ods.productocomercial AS PROD WITH (NOLOCK) LEFT JOIN dbo.Estrategia AS EST
ON PROD.CUV = EST.CUV2 AND EST.CampaniaID = PROD.AnoCampania
LEFT JOIN ods.Marca MAR WITH (NOLOCK)
ON MAR.MarcaID = PROD.MarcaID
LEFT JOIN dbo.EstrategiaImagen AS EIM WITH (NOLOCK)
ON EIM.CampaniaID = PROD.AnoCampania AND EIM.CUV = PROD.CUV
LEFT JOIN dbo.OfertaProducto OP WITH (NOLOCK) ON OP.CampaniaID = PROD.CampaniaID	AND OP.CUV = PROD.CUV
LEFT JOIN dbo.ProductoDescripcion PD WITH (NOLOCK) ON PROD.AnoCampania = PD.CampaniaID AND PROD.CUV = PD.CUV
LEFT JOIN dbo.MatrizComercial MC WITH (NOLOCK) ON PROD.CodigoProducto = MC.CodigoSAP
WHERE PROD.AnoCampania = @AnoCampania
and PROD.CodigoCatalago = 35
and PROD.NumeroPagina = @TipoOferta
END
GO

USE BelcorpSalvador
GO

ALTER PROCEDURE [dbo].[GetDemostradoresCaminoBrillante] (
@AnoCampania int,
@NivelCaminoBrillante int
)
AS
BEGIN
DECLARE @TipoOferta int;
SELECT @TipoOferta = CASE @NivelCaminoBrillante
WHEN 2 THEN 200
WHEN 3 THEN 201
WHEN 4 THEN 202
WHEN 5 THEN 203
WHEN 6 THEN 203
ELSE null
END;
SELECT
PROD.CodigoProducto AS CodigoProducto
,COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, PROD.Descripcion) AS Descripcion
,PROD.PrecioValorizado AS PrecioValorizado
,PROD.PrecioCatalogo AS PrecioCatalogo
,PROD.CUV AS CUV
,0 AS EstrategiaID
,'0' AS CodigoEstrategia
,COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, PROD.Descripcion) AS DescripcionCUV
,EST.DescripcionCUV2 AS DescripcionCortaCUV
,ISNULL(MAR.MarcaID,0) AS MarcaID
,ISNULL(MAR.Codigo,'00') AS CodigoMarca
,MAR.Nombre AS DescripcionMarca
,PROD.PrecioValorizado AS PrecioFinal
,PROD.PrecioValorizado - PROD.PrecioCatalogo AS Ganancia
,EIM.NombreImagen AS FotoProductoSmall
,EIM.NombreImagen AS FotoProductoMedium
,0 AS TipoEstrategiaID
,(CASE CodigoTipoOferta WHEN '085' THEN 1 WHEN '087' THEN 1 ELSE 0 END) AS EsCatalogo
FROM ods.productocomercial AS PROD WITH (NOLOCK) LEFT JOIN dbo.Estrategia AS EST
ON PROD.CUV = EST.CUV2 AND EST.CampaniaID = PROD.AnoCampania
LEFT JOIN ods.Marca MAR WITH (NOLOCK)
ON MAR.MarcaID = PROD.MarcaID
LEFT JOIN dbo.EstrategiaImagen AS EIM WITH (NOLOCK)
ON EIM.CampaniaID = PROD.AnoCampania AND EIM.CUV = PROD.CUV
LEFT JOIN dbo.OfertaProducto OP WITH (NOLOCK) ON OP.CampaniaID = PROD.CampaniaID	AND OP.CUV = PROD.CUV
LEFT JOIN dbo.ProductoDescripcion PD WITH (NOLOCK) ON PROD.AnoCampania = PD.CampaniaID AND PROD.CUV = PD.CUV
LEFT JOIN dbo.MatrizComercial MC WITH (NOLOCK) ON PROD.CodigoProducto = MC.CodigoSAP
WHERE PROD.AnoCampania = @AnoCampania
and PROD.CodigoCatalago = 35
and PROD.NumeroPagina = @TipoOferta
END
GO

USE BelcorpPuertoRico
GO

ALTER PROCEDURE [dbo].[GetDemostradoresCaminoBrillante] (
@AnoCampania int,
@NivelCaminoBrillante int
)
AS
BEGIN
DECLARE @TipoOferta int;
SELECT @TipoOferta = CASE @NivelCaminoBrillante
WHEN 2 THEN 200
WHEN 3 THEN 201
WHEN 4 THEN 202
WHEN 5 THEN 203
WHEN 6 THEN 203
ELSE null
END;
SELECT
PROD.CodigoProducto AS CodigoProducto
,COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, PROD.Descripcion) AS Descripcion
,PROD.PrecioValorizado AS PrecioValorizado
,PROD.PrecioCatalogo AS PrecioCatalogo
,PROD.CUV AS CUV
,0 AS EstrategiaID
,'0' AS CodigoEstrategia
,COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, PROD.Descripcion) AS DescripcionCUV
,EST.DescripcionCUV2 AS DescripcionCortaCUV
,ISNULL(MAR.MarcaID,0) AS MarcaID
,ISNULL(MAR.Codigo,'00') AS CodigoMarca
,MAR.Nombre AS DescripcionMarca
,PROD.PrecioValorizado AS PrecioFinal
,PROD.PrecioValorizado - PROD.PrecioCatalogo AS Ganancia
,EIM.NombreImagen AS FotoProductoSmall
,EIM.NombreImagen AS FotoProductoMedium
,0 AS TipoEstrategiaID
,(CASE CodigoTipoOferta WHEN '085' THEN 1 WHEN '087' THEN 1 ELSE 0 END) AS EsCatalogo
FROM ods.productocomercial AS PROD WITH (NOLOCK) LEFT JOIN dbo.Estrategia AS EST
ON PROD.CUV = EST.CUV2 AND EST.CampaniaID = PROD.AnoCampania
LEFT JOIN ods.Marca MAR WITH (NOLOCK)
ON MAR.MarcaID = PROD.MarcaID
LEFT JOIN dbo.EstrategiaImagen AS EIM WITH (NOLOCK)
ON EIM.CampaniaID = PROD.AnoCampania AND EIM.CUV = PROD.CUV
LEFT JOIN dbo.OfertaProducto OP WITH (NOLOCK) ON OP.CampaniaID = PROD.CampaniaID	AND OP.CUV = PROD.CUV
LEFT JOIN dbo.ProductoDescripcion PD WITH (NOLOCK) ON PROD.AnoCampania = PD.CampaniaID AND PROD.CUV = PD.CUV
LEFT JOIN dbo.MatrizComercial MC WITH (NOLOCK) ON PROD.CodigoProducto = MC.CodigoSAP
WHERE PROD.AnoCampania = @AnoCampania
and PROD.CodigoCatalago = 35
and PROD.NumeroPagina = @TipoOferta
END
GO

USE BelcorpPanama
GO

ALTER PROCEDURE [dbo].[GetDemostradoresCaminoBrillante] (
@AnoCampania int,
@NivelCaminoBrillante int
)
AS
BEGIN
DECLARE @TipoOferta int;
SELECT @TipoOferta = CASE @NivelCaminoBrillante
WHEN 2 THEN 200
WHEN 3 THEN 201
WHEN 4 THEN 202
WHEN 5 THEN 203
WHEN 6 THEN 203
ELSE null
END;
SELECT
PROD.CodigoProducto AS CodigoProducto
,COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, PROD.Descripcion) AS Descripcion
,PROD.PrecioValorizado AS PrecioValorizado
,PROD.PrecioCatalogo AS PrecioCatalogo
,PROD.CUV AS CUV
,0 AS EstrategiaID
,'0' AS CodigoEstrategia
,COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, PROD.Descripcion) AS DescripcionCUV
,EST.DescripcionCUV2 AS DescripcionCortaCUV
,ISNULL(MAR.MarcaID,0) AS MarcaID
,ISNULL(MAR.Codigo,'00') AS CodigoMarca
,MAR.Nombre AS DescripcionMarca
,PROD.PrecioValorizado AS PrecioFinal
,PROD.PrecioValorizado - PROD.PrecioCatalogo AS Ganancia
,EIM.NombreImagen AS FotoProductoSmall
,EIM.NombreImagen AS FotoProductoMedium
,0 AS TipoEstrategiaID
,(CASE CodigoTipoOferta WHEN '085' THEN 1 WHEN '087' THEN 1 ELSE 0 END) AS EsCatalogo
FROM ods.productocomercial AS PROD WITH (NOLOCK) LEFT JOIN dbo.Estrategia AS EST
ON PROD.CUV = EST.CUV2 AND EST.CampaniaID = PROD.AnoCampania
LEFT JOIN ods.Marca MAR WITH (NOLOCK)
ON MAR.MarcaID = PROD.MarcaID
LEFT JOIN dbo.EstrategiaImagen AS EIM WITH (NOLOCK)
ON EIM.CampaniaID = PROD.AnoCampania AND EIM.CUV = PROD.CUV
LEFT JOIN dbo.OfertaProducto OP WITH (NOLOCK) ON OP.CampaniaID = PROD.CampaniaID	AND OP.CUV = PROD.CUV
LEFT JOIN dbo.ProductoDescripcion PD WITH (NOLOCK) ON PROD.AnoCampania = PD.CampaniaID AND PROD.CUV = PD.CUV
LEFT JOIN dbo.MatrizComercial MC WITH (NOLOCK) ON PROD.CodigoProducto = MC.CodigoSAP
WHERE PROD.AnoCampania = @AnoCampania
and PROD.CodigoCatalago = 35
and PROD.NumeroPagina = @TipoOferta
END
GO

USE BelcorpGuatemala
GO

ALTER PROCEDURE [dbo].[GetDemostradoresCaminoBrillante] (
@AnoCampania int,
@NivelCaminoBrillante int
)
AS
BEGIN
DECLARE @TipoOferta int;
SELECT @TipoOferta = CASE @NivelCaminoBrillante
WHEN 2 THEN 200
WHEN 3 THEN 201
WHEN 4 THEN 202
WHEN 5 THEN 203
WHEN 6 THEN 203
ELSE null
END;
SELECT
PROD.CodigoProducto AS CodigoProducto
,COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, PROD.Descripcion) AS Descripcion
,PROD.PrecioValorizado AS PrecioValorizado
,PROD.PrecioCatalogo AS PrecioCatalogo
,PROD.CUV AS CUV
,0 AS EstrategiaID
,'0' AS CodigoEstrategia
,COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, PROD.Descripcion) AS DescripcionCUV
,EST.DescripcionCUV2 AS DescripcionCortaCUV
,ISNULL(MAR.MarcaID,0) AS MarcaID
,ISNULL(MAR.Codigo,'00') AS CodigoMarca
,MAR.Nombre AS DescripcionMarca
,PROD.PrecioValorizado AS PrecioFinal
,PROD.PrecioValorizado - PROD.PrecioCatalogo AS Ganancia
,EIM.NombreImagen AS FotoProductoSmall
,EIM.NombreImagen AS FotoProductoMedium
,0 AS TipoEstrategiaID
,(CASE CodigoTipoOferta WHEN '085' THEN 1 WHEN '087' THEN 1 ELSE 0 END) AS EsCatalogo
FROM ods.productocomercial AS PROD WITH (NOLOCK) LEFT JOIN dbo.Estrategia AS EST
ON PROD.CUV = EST.CUV2 AND EST.CampaniaID = PROD.AnoCampania
LEFT JOIN ods.Marca MAR WITH (NOLOCK)
ON MAR.MarcaID = PROD.MarcaID
LEFT JOIN dbo.EstrategiaImagen AS EIM WITH (NOLOCK)
ON EIM.CampaniaID = PROD.AnoCampania AND EIM.CUV = PROD.CUV
LEFT JOIN dbo.OfertaProducto OP WITH (NOLOCK) ON OP.CampaniaID = PROD.CampaniaID	AND OP.CUV = PROD.CUV
LEFT JOIN dbo.ProductoDescripcion PD WITH (NOLOCK) ON PROD.AnoCampania = PD.CampaniaID AND PROD.CUV = PD.CUV
LEFT JOIN dbo.MatrizComercial MC WITH (NOLOCK) ON PROD.CodigoProducto = MC.CodigoSAP
WHERE PROD.AnoCampania = @AnoCampania
and PROD.CodigoCatalago = 35
and PROD.NumeroPagina = @TipoOferta
END
GO

USE BelcorpEcuador
GO

ALTER PROCEDURE [dbo].[GetDemostradoresCaminoBrillante] (
@AnoCampania int,
@NivelCaminoBrillante int
)
AS
BEGIN
DECLARE @TipoOferta int;
SELECT @TipoOferta = CASE @NivelCaminoBrillante
WHEN 2 THEN 200
WHEN 3 THEN 201
WHEN 4 THEN 202
WHEN 5 THEN 203
WHEN 6 THEN 203
ELSE null
END;
SELECT
PROD.CodigoProducto AS CodigoProducto
,COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, PROD.Descripcion) AS Descripcion
,PROD.PrecioValorizado AS PrecioValorizado
,PROD.PrecioCatalogo AS PrecioCatalogo
,PROD.CUV AS CUV
,0 AS EstrategiaID
,'0' AS CodigoEstrategia
,COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, PROD.Descripcion) AS DescripcionCUV
,EST.DescripcionCUV2 AS DescripcionCortaCUV
,ISNULL(MAR.MarcaID,0) AS MarcaID
,ISNULL(MAR.Codigo,'00') AS CodigoMarca
,MAR.Nombre AS DescripcionMarca
,PROD.PrecioValorizado AS PrecioFinal
,PROD.PrecioValorizado - PROD.PrecioCatalogo AS Ganancia
,EIM.NombreImagen AS FotoProductoSmall
,EIM.NombreImagen AS FotoProductoMedium
,0 AS TipoEstrategiaID
,(CASE CodigoTipoOferta WHEN '085' THEN 1 WHEN '087' THEN 1 ELSE 0 END) AS EsCatalogo
FROM ods.productocomercial AS PROD WITH (NOLOCK) LEFT JOIN dbo.Estrategia AS EST
ON PROD.CUV = EST.CUV2 AND EST.CampaniaID = PROD.AnoCampania
LEFT JOIN ods.Marca MAR WITH (NOLOCK)
ON MAR.MarcaID = PROD.MarcaID
LEFT JOIN dbo.EstrategiaImagen AS EIM WITH (NOLOCK)
ON EIM.CampaniaID = PROD.AnoCampania AND EIM.CUV = PROD.CUV
LEFT JOIN dbo.OfertaProducto OP WITH (NOLOCK) ON OP.CampaniaID = PROD.CampaniaID	AND OP.CUV = PROD.CUV
LEFT JOIN dbo.ProductoDescripcion PD WITH (NOLOCK) ON PROD.AnoCampania = PD.CampaniaID AND PROD.CUV = PD.CUV
LEFT JOIN dbo.MatrizComercial MC WITH (NOLOCK) ON PROD.CodigoProducto = MC.CodigoSAP
WHERE PROD.AnoCampania = @AnoCampania
and PROD.CodigoCatalago = 35
and PROD.NumeroPagina = @TipoOferta
END
GO

USE BelcorpDominicana
GO

ALTER PROCEDURE [dbo].[GetDemostradoresCaminoBrillante] (
@AnoCampania int,
@NivelCaminoBrillante int
)
AS
BEGIN
DECLARE @TipoOferta int;
SELECT @TipoOferta = CASE @NivelCaminoBrillante
WHEN 2 THEN 200
WHEN 3 THEN 201
WHEN 4 THEN 202
WHEN 5 THEN 203
WHEN 6 THEN 203
ELSE null
END;
SELECT
PROD.CodigoProducto AS CodigoProducto
,COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, PROD.Descripcion) AS Descripcion
,PROD.PrecioValorizado AS PrecioValorizado
,PROD.PrecioCatalogo AS PrecioCatalogo
,PROD.CUV AS CUV
,0 AS EstrategiaID
,'0' AS CodigoEstrategia
,COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, PROD.Descripcion) AS DescripcionCUV
,EST.DescripcionCUV2 AS DescripcionCortaCUV
,ISNULL(MAR.MarcaID,0) AS MarcaID
,ISNULL(MAR.Codigo,'00') AS CodigoMarca
,MAR.Nombre AS DescripcionMarca
,PROD.PrecioValorizado AS PrecioFinal
,PROD.PrecioValorizado - PROD.PrecioCatalogo AS Ganancia
,EIM.NombreImagen AS FotoProductoSmall
,EIM.NombreImagen AS FotoProductoMedium
,0 AS TipoEstrategiaID
,(CASE CodigoTipoOferta WHEN '085' THEN 1 WHEN '087' THEN 1 ELSE 0 END) AS EsCatalogo
FROM ods.productocomercial AS PROD WITH (NOLOCK) LEFT JOIN dbo.Estrategia AS EST
ON PROD.CUV = EST.CUV2 AND EST.CampaniaID = PROD.AnoCampania
LEFT JOIN ods.Marca MAR WITH (NOLOCK)
ON MAR.MarcaID = PROD.MarcaID
LEFT JOIN dbo.EstrategiaImagen AS EIM WITH (NOLOCK)
ON EIM.CampaniaID = PROD.AnoCampania AND EIM.CUV = PROD.CUV
LEFT JOIN dbo.OfertaProducto OP WITH (NOLOCK) ON OP.CampaniaID = PROD.CampaniaID	AND OP.CUV = PROD.CUV
LEFT JOIN dbo.ProductoDescripcion PD WITH (NOLOCK) ON PROD.AnoCampania = PD.CampaniaID AND PROD.CUV = PD.CUV
LEFT JOIN dbo.MatrizComercial MC WITH (NOLOCK) ON PROD.CodigoProducto = MC.CodigoSAP
WHERE PROD.AnoCampania = @AnoCampania
and PROD.CodigoCatalago = 35
and PROD.NumeroPagina = @TipoOferta
END
GO

USE BelcorpCostaRica
GO

ALTER PROCEDURE [dbo].[GetDemostradoresCaminoBrillante] (
@AnoCampania int,
@NivelCaminoBrillante int
)
AS
BEGIN
DECLARE @TipoOferta int;
SELECT @TipoOferta = CASE @NivelCaminoBrillante
WHEN 2 THEN 200
WHEN 3 THEN 201
WHEN 4 THEN 202
WHEN 5 THEN 203
WHEN 6 THEN 203
ELSE null
END;
SELECT
PROD.CodigoProducto AS CodigoProducto
,COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, PROD.Descripcion) AS Descripcion
,PROD.PrecioValorizado AS PrecioValorizado
,PROD.PrecioCatalogo AS PrecioCatalogo
,PROD.CUV AS CUV
,0 AS EstrategiaID
,'0' AS CodigoEstrategia
,COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, PROD.Descripcion) AS DescripcionCUV
,EST.DescripcionCUV2 AS DescripcionCortaCUV
,ISNULL(MAR.MarcaID,0) AS MarcaID
,ISNULL(MAR.Codigo,'00') AS CodigoMarca
,MAR.Nombre AS DescripcionMarca
,PROD.PrecioValorizado AS PrecioFinal
,PROD.PrecioValorizado - PROD.PrecioCatalogo AS Ganancia
,EIM.NombreImagen AS FotoProductoSmall
,EIM.NombreImagen AS FotoProductoMedium
,0 AS TipoEstrategiaID
,(CASE CodigoTipoOferta WHEN '085' THEN 1 WHEN '087' THEN 1 ELSE 0 END) AS EsCatalogo
FROM ods.productocomercial AS PROD WITH (NOLOCK) LEFT JOIN dbo.Estrategia AS EST
ON PROD.CUV = EST.CUV2 AND EST.CampaniaID = PROD.AnoCampania
LEFT JOIN ods.Marca MAR WITH (NOLOCK)
ON MAR.MarcaID = PROD.MarcaID
LEFT JOIN dbo.EstrategiaImagen AS EIM WITH (NOLOCK)
ON EIM.CampaniaID = PROD.AnoCampania AND EIM.CUV = PROD.CUV
LEFT JOIN dbo.OfertaProducto OP WITH (NOLOCK) ON OP.CampaniaID = PROD.CampaniaID	AND OP.CUV = PROD.CUV
LEFT JOIN dbo.ProductoDescripcion PD WITH (NOLOCK) ON PROD.AnoCampania = PD.CampaniaID AND PROD.CUV = PD.CUV
LEFT JOIN dbo.MatrizComercial MC WITH (NOLOCK) ON PROD.CodigoProducto = MC.CodigoSAP
WHERE PROD.AnoCampania = @AnoCampania
and PROD.CodigoCatalago = 35
and PROD.NumeroPagina = @TipoOferta
END
GO

USE BelcorpChile
GO

ALTER PROCEDURE [dbo].[GetDemostradoresCaminoBrillante] (
@AnoCampania int,
@NivelCaminoBrillante int
)
AS
BEGIN
DECLARE @TipoOferta int;
SELECT @TipoOferta = CASE @NivelCaminoBrillante
WHEN 2 THEN 200
WHEN 3 THEN 201
WHEN 4 THEN 202
WHEN 5 THEN 203
WHEN 6 THEN 203
ELSE null
END;
SELECT
PROD.CodigoProducto AS CodigoProducto
,COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, PROD.Descripcion) AS Descripcion
,PROD.PrecioValorizado AS PrecioValorizado
,PROD.PrecioCatalogo AS PrecioCatalogo
,PROD.CUV AS CUV
,0 AS EstrategiaID
,'0' AS CodigoEstrategia
,COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, PROD.Descripcion) AS DescripcionCUV
,EST.DescripcionCUV2 AS DescripcionCortaCUV
,ISNULL(MAR.MarcaID,0) AS MarcaID
,ISNULL(MAR.Codigo,'00') AS CodigoMarca
,MAR.Nombre AS DescripcionMarca
,PROD.PrecioValorizado AS PrecioFinal
,PROD.PrecioValorizado - PROD.PrecioCatalogo AS Ganancia
,EIM.NombreImagen AS FotoProductoSmall
,EIM.NombreImagen AS FotoProductoMedium
,0 AS TipoEstrategiaID
,(CASE CodigoTipoOferta WHEN '085' THEN 1 WHEN '087' THEN 1 ELSE 0 END) AS EsCatalogo
FROM ods.productocomercial AS PROD WITH (NOLOCK) LEFT JOIN dbo.Estrategia AS EST
ON PROD.CUV = EST.CUV2 AND EST.CampaniaID = PROD.AnoCampania
LEFT JOIN ods.Marca MAR WITH (NOLOCK)
ON MAR.MarcaID = PROD.MarcaID
LEFT JOIN dbo.EstrategiaImagen AS EIM WITH (NOLOCK)
ON EIM.CampaniaID = PROD.AnoCampania AND EIM.CUV = PROD.CUV
LEFT JOIN dbo.OfertaProducto OP WITH (NOLOCK) ON OP.CampaniaID = PROD.CampaniaID	AND OP.CUV = PROD.CUV
LEFT JOIN dbo.ProductoDescripcion PD WITH (NOLOCK) ON PROD.AnoCampania = PD.CampaniaID AND PROD.CUV = PD.CUV
LEFT JOIN dbo.MatrizComercial MC WITH (NOLOCK) ON PROD.CodigoProducto = MC.CodigoSAP
WHERE PROD.AnoCampania = @AnoCampania
and PROD.CodigoCatalago = 35
and PROD.NumeroPagina = @TipoOferta
END
GO

USE BelcorpBolivia
GO

ALTER PROCEDURE [dbo].[GetDemostradoresCaminoBrillante] (
@AnoCampania int,
@NivelCaminoBrillante int
)
AS
BEGIN
DECLARE @TipoOferta int;
SELECT @TipoOferta = CASE @NivelCaminoBrillante
WHEN 2 THEN 200
WHEN 3 THEN 201
WHEN 4 THEN 202
WHEN 5 THEN 203
WHEN 6 THEN 203
ELSE null
END;
SELECT
PROD.CodigoProducto AS CodigoProducto
,COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, PROD.Descripcion) AS Descripcion
,PROD.PrecioValorizado AS PrecioValorizado
,PROD.PrecioCatalogo AS PrecioCatalogo
,PROD.CUV AS CUV
,0 AS EstrategiaID
,'0' AS CodigoEstrategia
,COALESCE(MC.Descripcion, OP.Descripcion, PD.Descripcion, PROD.Descripcion) AS DescripcionCUV
,EST.DescripcionCUV2 AS DescripcionCortaCUV
,ISNULL(MAR.MarcaID,0) AS MarcaID
,ISNULL(MAR.Codigo,'00') AS CodigoMarca
,MAR.Nombre AS DescripcionMarca
,PROD.PrecioValorizado AS PrecioFinal
,PROD.PrecioValorizado - PROD.PrecioCatalogo AS Ganancia
,EIM.NombreImagen AS FotoProductoSmall
,EIM.NombreImagen AS FotoProductoMedium
,0 AS TipoEstrategiaID
,(CASE CodigoTipoOferta WHEN '085' THEN 1 WHEN '087' THEN 1 ELSE 0 END) AS EsCatalogo
FROM ods.productocomercial AS PROD WITH (NOLOCK) LEFT JOIN dbo.Estrategia AS EST
ON PROD.CUV = EST.CUV2 AND EST.CampaniaID = PROD.AnoCampania
LEFT JOIN ods.Marca MAR WITH (NOLOCK)
ON MAR.MarcaID = PROD.MarcaID
LEFT JOIN dbo.EstrategiaImagen AS EIM WITH (NOLOCK)
ON EIM.CampaniaID = PROD.AnoCampania AND EIM.CUV = PROD.CUV
LEFT JOIN dbo.OfertaProducto OP WITH (NOLOCK) ON OP.CampaniaID = PROD.CampaniaID	AND OP.CUV = PROD.CUV
LEFT JOIN dbo.ProductoDescripcion PD WITH (NOLOCK) ON PROD.AnoCampania = PD.CampaniaID AND PROD.CUV = PD.CUV
LEFT JOIN dbo.MatrizComercial MC WITH (NOLOCK) ON PROD.CodigoProducto = MC.CodigoSAP
WHERE PROD.AnoCampania = @AnoCampania
and PROD.CodigoCatalago = 35
and PROD.NumeroPagina = @TipoOferta
END
GO

