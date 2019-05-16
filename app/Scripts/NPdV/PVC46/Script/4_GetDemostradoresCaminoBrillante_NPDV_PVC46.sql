USE BelcorpPeru
GO

ALTER PROC [dbo].[GetDemostradoresCaminoBrillante] (
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
	 PROD.CUV Cuv	
	,PROD.CodigoProducto AS CodigoProducto
	,PROD.Descripcion AS Descripcion
	,PROD.PrecioValorizado AS PrecioValorizado
	,PROD.PrecioCatalogo AS PrecioCatalogo
	,PROD.CUV AS CUV
	,0 AS EstrategiaID
	,'0' AS CodigoEstrategia
	,PROD.Descripcion AS DescripcionCUV
	,EST.DescripcionCUV2 AS DescripcionCortaCUV
	,ISNULL(MAR.MarcaID,0) AS MarcaID
	,ISNULL(MAR.Codigo,'00') AS CodigoMarca
	,MAR.Nombre AS DescripcionMarca
	,PROD.PrecioValorizado AS PrecioFinal
	,PROD.PrecioValorizado - PROD.PrecioCatalogo  AS Ganancia
	,EIM.NombreImagen AS FotoProductoSmall
	,EIM.NombreImagen AS FotoProductoMedium
	,0 AS TipoEstrategiaID
	,0 AS OrigenPedidoWebFicha

FROM ods.productocomercial AS PROD WITH (NOLOCK) LEFT JOIN dbo.Estrategia AS EST
	ON PROD.CUV = EST.CUV2 AND EST.CampaniaID = PROD.AnoCampania 
	LEFT JOIN ods.Marca MAR WITH (NOLOCK)
	ON MAR.MarcaID = PROD.MarcaID
	LEFT JOIN dbo.EstrategiaImagen AS EIM WITH (NOLOCK)
	ON EIM.CampaniaID = PROD.AnoCampania  AND EIM.CUV = PROD.CUV
WHERE PROD.AnoCampania = @AnoCampania
	and PROD.CodigoCatalago = 35 
	and PROD.NumeroPagina = @TipoOferta
	
END
GO

USE BelcorpMexico
GO

ALTER PROC [dbo].[GetDemostradoresCaminoBrillante] (
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
	 PROD.CUV Cuv	
	,PROD.CodigoProducto AS CodigoProducto
	,PROD.Descripcion AS Descripcion
	,PROD.PrecioValorizado AS PrecioValorizado
	,PROD.PrecioCatalogo AS PrecioCatalogo
	,PROD.CUV AS CUV
	,0 AS EstrategiaID
	,'0' AS CodigoEstrategia
	,PROD.Descripcion AS DescripcionCUV
	,EST.DescripcionCUV2 AS DescripcionCortaCUV
	,ISNULL(MAR.MarcaID,0) AS MarcaID
	,ISNULL(MAR.Codigo,'00') AS CodigoMarca
	,MAR.Nombre AS DescripcionMarca
	,PROD.PrecioValorizado AS PrecioFinal
	,PROD.PrecioValorizado - PROD.PrecioCatalogo  AS Ganancia
	,EIM.NombreImagen AS FotoProductoSmall
	,EIM.NombreImagen AS FotoProductoMedium
	,0 AS TipoEstrategiaID
	,0 AS OrigenPedidoWebFicha

FROM ods.productocomercial AS PROD WITH (NOLOCK) LEFT JOIN dbo.Estrategia AS EST
	ON PROD.CUV = EST.CUV2 AND EST.CampaniaID = PROD.AnoCampania 
	LEFT JOIN ods.Marca MAR WITH (NOLOCK)
	ON MAR.MarcaID = PROD.MarcaID
	LEFT JOIN dbo.EstrategiaImagen AS EIM WITH (NOLOCK)
	ON EIM.CampaniaID = PROD.AnoCampania  AND EIM.CUV = PROD.CUV
WHERE PROD.AnoCampania = @AnoCampania
	and PROD.CodigoCatalago = 35 
	and PROD.NumeroPagina = @TipoOferta
	
END
GO

USE BelcorpColombia
GO

ALTER PROC [dbo].[GetDemostradoresCaminoBrillante] (
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
	 PROD.CUV Cuv	
	,PROD.CodigoProducto AS CodigoProducto
	,PROD.Descripcion AS Descripcion
	,PROD.PrecioValorizado AS PrecioValorizado
	,PROD.PrecioCatalogo AS PrecioCatalogo
	,PROD.CUV AS CUV
	,0 AS EstrategiaID
	,'0' AS CodigoEstrategia
	,PROD.Descripcion AS DescripcionCUV
	,EST.DescripcionCUV2 AS DescripcionCortaCUV
	,ISNULL(MAR.MarcaID,0) AS MarcaID
	,ISNULL(MAR.Codigo,'00') AS CodigoMarca
	,MAR.Nombre AS DescripcionMarca
	,PROD.PrecioValorizado AS PrecioFinal
	,PROD.PrecioValorizado - PROD.PrecioCatalogo  AS Ganancia
	,EIM.NombreImagen AS FotoProductoSmall
	,EIM.NombreImagen AS FotoProductoMedium
	,0 AS TipoEstrategiaID
	,0 AS OrigenPedidoWebFicha

FROM ods.productocomercial AS PROD WITH (NOLOCK) LEFT JOIN dbo.Estrategia AS EST
	ON PROD.CUV = EST.CUV2 AND EST.CampaniaID = PROD.AnoCampania 
	LEFT JOIN ods.Marca MAR WITH (NOLOCK)
	ON MAR.MarcaID = PROD.MarcaID
	LEFT JOIN dbo.EstrategiaImagen AS EIM WITH (NOLOCK)
	ON EIM.CampaniaID = PROD.AnoCampania  AND EIM.CUV = PROD.CUV
WHERE PROD.AnoCampania = @AnoCampania
	and PROD.CodigoCatalago = 35 
	and PROD.NumeroPagina = @TipoOferta
	
END
GO

USE BelcorpSalvador
GO

ALTER PROC [dbo].[GetDemostradoresCaminoBrillante] (
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
	 PROD.CUV Cuv	
	,PROD.CodigoProducto AS CodigoProducto
	,PROD.Descripcion AS Descripcion
	,PROD.PrecioValorizado AS PrecioValorizado
	,PROD.PrecioCatalogo AS PrecioCatalogo
	,PROD.CUV AS CUV
	,0 AS EstrategiaID
	,'0' AS CodigoEstrategia
	,PROD.Descripcion AS DescripcionCUV
	,EST.DescripcionCUV2 AS DescripcionCortaCUV
	,ISNULL(MAR.MarcaID,0) AS MarcaID
	,ISNULL(MAR.Codigo,'00') AS CodigoMarca
	,MAR.Nombre AS DescripcionMarca
	,PROD.PrecioValorizado AS PrecioFinal
	,PROD.PrecioValorizado - PROD.PrecioCatalogo  AS Ganancia
	,EIM.NombreImagen AS FotoProductoSmall
	,EIM.NombreImagen AS FotoProductoMedium
	,0 AS TipoEstrategiaID
	,0 AS OrigenPedidoWebFicha

FROM ods.productocomercial AS PROD WITH (NOLOCK) LEFT JOIN dbo.Estrategia AS EST
	ON PROD.CUV = EST.CUV2 AND EST.CampaniaID = PROD.AnoCampania 
	LEFT JOIN ods.Marca MAR WITH (NOLOCK)
	ON MAR.MarcaID = PROD.MarcaID
	LEFT JOIN dbo.EstrategiaImagen AS EIM WITH (NOLOCK)
	ON EIM.CampaniaID = PROD.AnoCampania  AND EIM.CUV = PROD.CUV
WHERE PROD.AnoCampania = @AnoCampania
	and PROD.CodigoCatalago = 35 
	and PROD.NumeroPagina = @TipoOferta
	
END
GO

USE BelcorpPuertoRico
GO

ALTER PROC [dbo].[GetDemostradoresCaminoBrillante] (
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
	 PROD.CUV Cuv	
	,PROD.CodigoProducto AS CodigoProducto
	,PROD.Descripcion AS Descripcion
	,PROD.PrecioValorizado AS PrecioValorizado
	,PROD.PrecioCatalogo AS PrecioCatalogo
	,PROD.CUV AS CUV
	,0 AS EstrategiaID
	,'0' AS CodigoEstrategia
	,PROD.Descripcion AS DescripcionCUV
	,EST.DescripcionCUV2 AS DescripcionCortaCUV
	,ISNULL(MAR.MarcaID,0) AS MarcaID
	,ISNULL(MAR.Codigo,'00') AS CodigoMarca
	,MAR.Nombre AS DescripcionMarca
	,PROD.PrecioValorizado AS PrecioFinal
	,PROD.PrecioValorizado - PROD.PrecioCatalogo  AS Ganancia
	,EIM.NombreImagen AS FotoProductoSmall
	,EIM.NombreImagen AS FotoProductoMedium
	,0 AS TipoEstrategiaID
	,0 AS OrigenPedidoWebFicha

FROM ods.productocomercial AS PROD WITH (NOLOCK) LEFT JOIN dbo.Estrategia AS EST
	ON PROD.CUV = EST.CUV2 AND EST.CampaniaID = PROD.AnoCampania 
	LEFT JOIN ods.Marca MAR WITH (NOLOCK)
	ON MAR.MarcaID = PROD.MarcaID
	LEFT JOIN dbo.EstrategiaImagen AS EIM WITH (NOLOCK)
	ON EIM.CampaniaID = PROD.AnoCampania  AND EIM.CUV = PROD.CUV
WHERE PROD.AnoCampania = @AnoCampania
	and PROD.CodigoCatalago = 35 
	and PROD.NumeroPagina = @TipoOferta
	
END
GO

USE BelcorpPanama
GO

ALTER PROC [dbo].[GetDemostradoresCaminoBrillante] (
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
	 PROD.CUV Cuv	
	,PROD.CodigoProducto AS CodigoProducto
	,PROD.Descripcion AS Descripcion
	,PROD.PrecioValorizado AS PrecioValorizado
	,PROD.PrecioCatalogo AS PrecioCatalogo
	,PROD.CUV AS CUV
	,0 AS EstrategiaID
	,'0' AS CodigoEstrategia
	,PROD.Descripcion AS DescripcionCUV
	,EST.DescripcionCUV2 AS DescripcionCortaCUV
	,ISNULL(MAR.MarcaID,0) AS MarcaID
	,ISNULL(MAR.Codigo,'00') AS CodigoMarca
	,MAR.Nombre AS DescripcionMarca
	,PROD.PrecioValorizado AS PrecioFinal
	,PROD.PrecioValorizado - PROD.PrecioCatalogo  AS Ganancia
	,EIM.NombreImagen AS FotoProductoSmall
	,EIM.NombreImagen AS FotoProductoMedium
	,0 AS TipoEstrategiaID
	,0 AS OrigenPedidoWebFicha

FROM ods.productocomercial AS PROD WITH (NOLOCK) LEFT JOIN dbo.Estrategia AS EST
	ON PROD.CUV = EST.CUV2 AND EST.CampaniaID = PROD.AnoCampania 
	LEFT JOIN ods.Marca MAR WITH (NOLOCK)
	ON MAR.MarcaID = PROD.MarcaID
	LEFT JOIN dbo.EstrategiaImagen AS EIM WITH (NOLOCK)
	ON EIM.CampaniaID = PROD.AnoCampania  AND EIM.CUV = PROD.CUV
WHERE PROD.AnoCampania = @AnoCampania
	and PROD.CodigoCatalago = 35 
	and PROD.NumeroPagina = @TipoOferta
	
END
GO

USE BelcorpGuatemala
GO

ALTER PROC [dbo].[GetDemostradoresCaminoBrillante] (
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
	 PROD.CUV Cuv	
	,PROD.CodigoProducto AS CodigoProducto
	,PROD.Descripcion AS Descripcion
	,PROD.PrecioValorizado AS PrecioValorizado
	,PROD.PrecioCatalogo AS PrecioCatalogo
	,PROD.CUV AS CUV
	,0 AS EstrategiaID
	,'0' AS CodigoEstrategia
	,PROD.Descripcion AS DescripcionCUV
	,EST.DescripcionCUV2 AS DescripcionCortaCUV
	,ISNULL(MAR.MarcaID,0) AS MarcaID
	,ISNULL(MAR.Codigo,'00') AS CodigoMarca
	,MAR.Nombre AS DescripcionMarca
	,PROD.PrecioValorizado AS PrecioFinal
	,PROD.PrecioValorizado - PROD.PrecioCatalogo  AS Ganancia
	,EIM.NombreImagen AS FotoProductoSmall
	,EIM.NombreImagen AS FotoProductoMedium
	,0 AS TipoEstrategiaID
	,0 AS OrigenPedidoWebFicha

FROM ods.productocomercial AS PROD WITH (NOLOCK) LEFT JOIN dbo.Estrategia AS EST
	ON PROD.CUV = EST.CUV2 AND EST.CampaniaID = PROD.AnoCampania 
	LEFT JOIN ods.Marca MAR WITH (NOLOCK)
	ON MAR.MarcaID = PROD.MarcaID
	LEFT JOIN dbo.EstrategiaImagen AS EIM WITH (NOLOCK)
	ON EIM.CampaniaID = PROD.AnoCampania  AND EIM.CUV = PROD.CUV
WHERE PROD.AnoCampania = @AnoCampania
	and PROD.CodigoCatalago = 35 
	and PROD.NumeroPagina = @TipoOferta
	
END
GO

USE BelcorpEcuador
GO

ALTER PROC [dbo].[GetDemostradoresCaminoBrillante] (
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
	 PROD.CUV Cuv	
	,PROD.CodigoProducto AS CodigoProducto
	,PROD.Descripcion AS Descripcion
	,PROD.PrecioValorizado AS PrecioValorizado
	,PROD.PrecioCatalogo AS PrecioCatalogo
	,PROD.CUV AS CUV
	,0 AS EstrategiaID
	,'0' AS CodigoEstrategia
	,PROD.Descripcion AS DescripcionCUV
	,EST.DescripcionCUV2 AS DescripcionCortaCUV
	,ISNULL(MAR.MarcaID,0) AS MarcaID
	,ISNULL(MAR.Codigo,'00') AS CodigoMarca
	,MAR.Nombre AS DescripcionMarca
	,PROD.PrecioValorizado AS PrecioFinal
	,PROD.PrecioValorizado - PROD.PrecioCatalogo  AS Ganancia
	,EIM.NombreImagen AS FotoProductoSmall
	,EIM.NombreImagen AS FotoProductoMedium
	,0 AS TipoEstrategiaID
	,0 AS OrigenPedidoWebFicha

FROM ods.productocomercial AS PROD WITH (NOLOCK) LEFT JOIN dbo.Estrategia AS EST
	ON PROD.CUV = EST.CUV2 AND EST.CampaniaID = PROD.AnoCampania 
	LEFT JOIN ods.Marca MAR WITH (NOLOCK)
	ON MAR.MarcaID = PROD.MarcaID
	LEFT JOIN dbo.EstrategiaImagen AS EIM WITH (NOLOCK)
	ON EIM.CampaniaID = PROD.AnoCampania  AND EIM.CUV = PROD.CUV
WHERE PROD.AnoCampania = @AnoCampania
	and PROD.CodigoCatalago = 35 
	and PROD.NumeroPagina = @TipoOferta
	
END
GO

USE BelcorpDominicana
GO

ALTER PROC [dbo].[GetDemostradoresCaminoBrillante] (
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
	 PROD.CUV Cuv	
	,PROD.CodigoProducto AS CodigoProducto
	,PROD.Descripcion AS Descripcion
	,PROD.PrecioValorizado AS PrecioValorizado
	,PROD.PrecioCatalogo AS PrecioCatalogo
	,PROD.CUV AS CUV
	,0 AS EstrategiaID
	,'0' AS CodigoEstrategia
	,PROD.Descripcion AS DescripcionCUV
	,EST.DescripcionCUV2 AS DescripcionCortaCUV
	,ISNULL(MAR.MarcaID,0) AS MarcaID
	,ISNULL(MAR.Codigo,'00') AS CodigoMarca
	,MAR.Nombre AS DescripcionMarca
	,PROD.PrecioValorizado AS PrecioFinal
	,PROD.PrecioValorizado - PROD.PrecioCatalogo  AS Ganancia
	,EIM.NombreImagen AS FotoProductoSmall
	,EIM.NombreImagen AS FotoProductoMedium
	,0 AS TipoEstrategiaID
	,0 AS OrigenPedidoWebFicha

FROM ods.productocomercial AS PROD WITH (NOLOCK) LEFT JOIN dbo.Estrategia AS EST
	ON PROD.CUV = EST.CUV2 AND EST.CampaniaID = PROD.AnoCampania 
	LEFT JOIN ods.Marca MAR WITH (NOLOCK)
	ON MAR.MarcaID = PROD.MarcaID
	LEFT JOIN dbo.EstrategiaImagen AS EIM WITH (NOLOCK)
	ON EIM.CampaniaID = PROD.AnoCampania  AND EIM.CUV = PROD.CUV
WHERE PROD.AnoCampania = @AnoCampania
	and PROD.CodigoCatalago = 35 
	and PROD.NumeroPagina = @TipoOferta
	
END
GO

USE BelcorpCostaRica
GO

ALTER PROC [dbo].[GetDemostradoresCaminoBrillante] (
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
	 PROD.CUV Cuv	
	,PROD.CodigoProducto AS CodigoProducto
	,PROD.Descripcion AS Descripcion
	,PROD.PrecioValorizado AS PrecioValorizado
	,PROD.PrecioCatalogo AS PrecioCatalogo
	,PROD.CUV AS CUV
	,0 AS EstrategiaID
	,'0' AS CodigoEstrategia
	,PROD.Descripcion AS DescripcionCUV
	,EST.DescripcionCUV2 AS DescripcionCortaCUV
	,ISNULL(MAR.MarcaID,0) AS MarcaID
	,ISNULL(MAR.Codigo,'00') AS CodigoMarca
	,MAR.Nombre AS DescripcionMarca
	,PROD.PrecioValorizado AS PrecioFinal
	,PROD.PrecioValorizado - PROD.PrecioCatalogo  AS Ganancia
	,EIM.NombreImagen AS FotoProductoSmall
	,EIM.NombreImagen AS FotoProductoMedium
	,0 AS TipoEstrategiaID
	,0 AS OrigenPedidoWebFicha

FROM ods.productocomercial AS PROD WITH (NOLOCK) LEFT JOIN dbo.Estrategia AS EST
	ON PROD.CUV = EST.CUV2 AND EST.CampaniaID = PROD.AnoCampania 
	LEFT JOIN ods.Marca MAR WITH (NOLOCK)
	ON MAR.MarcaID = PROD.MarcaID
	LEFT JOIN dbo.EstrategiaImagen AS EIM WITH (NOLOCK)
	ON EIM.CampaniaID = PROD.AnoCampania  AND EIM.CUV = PROD.CUV
WHERE PROD.AnoCampania = @AnoCampania
	and PROD.CodigoCatalago = 35 
	and PROD.NumeroPagina = @TipoOferta
	
END
GO

USE BelcorpChile
GO

ALTER PROC [dbo].[GetDemostradoresCaminoBrillante] (
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
	 PROD.CUV Cuv	
	,PROD.CodigoProducto AS CodigoProducto
	,PROD.Descripcion AS Descripcion
	,PROD.PrecioValorizado AS PrecioValorizado
	,PROD.PrecioCatalogo AS PrecioCatalogo
	,PROD.CUV AS CUV
	,0 AS EstrategiaID
	,'0' AS CodigoEstrategia
	,PROD.Descripcion AS DescripcionCUV
	,EST.DescripcionCUV2 AS DescripcionCortaCUV
	,ISNULL(MAR.MarcaID,0) AS MarcaID
	,ISNULL(MAR.Codigo,'00') AS CodigoMarca
	,MAR.Nombre AS DescripcionMarca
	,PROD.PrecioValorizado AS PrecioFinal
	,PROD.PrecioValorizado - PROD.PrecioCatalogo  AS Ganancia
	,EIM.NombreImagen AS FotoProductoSmall
	,EIM.NombreImagen AS FotoProductoMedium
	,0 AS TipoEstrategiaID
	,0 AS OrigenPedidoWebFicha

FROM ods.productocomercial AS PROD WITH (NOLOCK) LEFT JOIN dbo.Estrategia AS EST
	ON PROD.CUV = EST.CUV2 AND EST.CampaniaID = PROD.AnoCampania 
	LEFT JOIN ods.Marca MAR WITH (NOLOCK)
	ON MAR.MarcaID = PROD.MarcaID
	LEFT JOIN dbo.EstrategiaImagen AS EIM WITH (NOLOCK)
	ON EIM.CampaniaID = PROD.AnoCampania  AND EIM.CUV = PROD.CUV
WHERE PROD.AnoCampania = @AnoCampania
	and PROD.CodigoCatalago = 35 
	and PROD.NumeroPagina = @TipoOferta
	
END
GO

USE BelcorpBolivia
GO

ALTER PROC [dbo].[GetDemostradoresCaminoBrillante] (
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
	 PROD.CUV Cuv	
	,PROD.CodigoProducto AS CodigoProducto
	,PROD.Descripcion AS Descripcion
	,PROD.PrecioValorizado AS PrecioValorizado
	,PROD.PrecioCatalogo AS PrecioCatalogo
	,PROD.CUV AS CUV
	,0 AS EstrategiaID
	,'0' AS CodigoEstrategia
	,PROD.Descripcion AS DescripcionCUV
	,EST.DescripcionCUV2 AS DescripcionCortaCUV
	,ISNULL(MAR.MarcaID,0) AS MarcaID
	,ISNULL(MAR.Codigo,'00') AS CodigoMarca
	,MAR.Nombre AS DescripcionMarca
	,PROD.PrecioValorizado AS PrecioFinal
	,PROD.PrecioValorizado - PROD.PrecioCatalogo  AS Ganancia
	,EIM.NombreImagen AS FotoProductoSmall
	,EIM.NombreImagen AS FotoProductoMedium
	,0 AS TipoEstrategiaID
	,0 AS OrigenPedidoWebFicha

FROM ods.productocomercial AS PROD WITH (NOLOCK) LEFT JOIN dbo.Estrategia AS EST
	ON PROD.CUV = EST.CUV2 AND EST.CampaniaID = PROD.AnoCampania 
	LEFT JOIN ods.Marca MAR WITH (NOLOCK)
	ON MAR.MarcaID = PROD.MarcaID
	LEFT JOIN dbo.EstrategiaImagen AS EIM WITH (NOLOCK)
	ON EIM.CampaniaID = PROD.AnoCampania  AND EIM.CUV = PROD.CUV
WHERE PROD.AnoCampania = @AnoCampania
	and PROD.CodigoCatalago = 35 
	and PROD.NumeroPagina = @TipoOferta
	
END
GO

