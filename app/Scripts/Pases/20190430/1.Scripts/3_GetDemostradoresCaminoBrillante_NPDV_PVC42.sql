USE BelcorpPeru
GO

If Exists(select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.GetDemostradoresCaminoBrillante'))
Begin
	DROP PROCEDURE [dbo].[GetDemostradoresCaminoBrillante]
end
GO
CREATE PROC [dbo].[GetDemostradoresCaminoBrillante] (
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
	PROD.CUV Cuv,	
	PROD.CodigoProducto AS CodigoProducto,
	PROD.Descripcion AS Descripcion
	,PROD.PrecioValorizado AS PrecioValorizado
	,PROD.PrecioCatalogo AS PrecioCatalogo
	,PROD.CUV AS CUV
	,0 AS EstrategiaID
	,'0' AS CodigoEstrategia
	,PROD.Descripcion AS DescripcionCUV
	,EST.DescripcionCUV2 AS DescripcionCortaCUV
	,ISNULL(PROD.MarcaID,0) AS MarcaID
	,MAR.Descripcion AS DescripcionMarca
	,PROD.PrecioValorizado AS PrecioFinal
	,PROD.PrecioValorizado - PROD.PrecioCatalogo  AS Ganancia
	,EIM.NombreImagen AS FotoProductoSmall
	,EIM.NombreImagen AS FotoProductoMedium
	,0 AS TipoEstrategiaID
	,0 AS OrigenPedidoWebFicha

FROM ods.productocomercial AS PROD WITH (NOLOCK) LEFT JOIN dbo.Estrategia AS EST
	ON PROD.CUV = EST.CUV2 AND EST.CampaniaID = PROD.AnoCampania 
	LEFT JOIN Marca MAR WITH (NOLOCK)
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

If Exists(select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.GetDemostradoresCaminoBrillante'))
Begin
	DROP PROCEDURE [dbo].[GetDemostradoresCaminoBrillante]
end
GO
CREATE PROC [dbo].[GetDemostradoresCaminoBrillante] (
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
	PROD.CUV Cuv,	
	PROD.CodigoProducto AS CodigoProducto,
	PROD.Descripcion AS Descripcion
	,PROD.PrecioValorizado AS PrecioValorizado
	,PROD.PrecioCatalogo AS PrecioCatalogo
	,PROD.CUV AS CUV
	,0 AS EstrategiaID
	,'0' AS CodigoEstrategia
	,PROD.Descripcion AS DescripcionCUV
	,EST.DescripcionCUV2 AS DescripcionCortaCUV
	,ISNULL(PROD.MarcaID,0) AS MarcaID
	,MAR.Descripcion AS DescripcionMarca
	,PROD.PrecioValorizado AS PrecioFinal
	,PROD.PrecioValorizado - PROD.PrecioCatalogo  AS Ganancia
	,EIM.NombreImagen AS FotoProductoSmall
	,EIM.NombreImagen AS FotoProductoMedium
	,0 AS TipoEstrategiaID
	,0 AS OrigenPedidoWebFicha

FROM ods.productocomercial AS PROD WITH (NOLOCK) LEFT JOIN dbo.Estrategia AS EST
	ON PROD.CUV = EST.CUV2 AND EST.CampaniaID = PROD.AnoCampania 
	LEFT JOIN Marca MAR WITH (NOLOCK)
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

If Exists(select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.GetDemostradoresCaminoBrillante'))
Begin
	DROP PROCEDURE [dbo].[GetDemostradoresCaminoBrillante]
end
GO
CREATE PROC [dbo].[GetDemostradoresCaminoBrillante] (
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
	PROD.CUV Cuv,	
	PROD.CodigoProducto AS CodigoProducto,
	PROD.Descripcion AS Descripcion
	,PROD.PrecioValorizado AS PrecioValorizado
	,PROD.PrecioCatalogo AS PrecioCatalogo
	,PROD.CUV AS CUV
	,0 AS EstrategiaID
	,'0' AS CodigoEstrategia
	,PROD.Descripcion AS DescripcionCUV
	,EST.DescripcionCUV2 AS DescripcionCortaCUV
	,ISNULL(PROD.MarcaID,0) AS MarcaID
	,MAR.Descripcion AS DescripcionMarca
	,PROD.PrecioValorizado AS PrecioFinal
	,PROD.PrecioValorizado - PROD.PrecioCatalogo  AS Ganancia
	,EIM.NombreImagen AS FotoProductoSmall
	,EIM.NombreImagen AS FotoProductoMedium
	,0 AS TipoEstrategiaID
	,0 AS OrigenPedidoWebFicha

FROM ods.productocomercial AS PROD WITH (NOLOCK) LEFT JOIN dbo.Estrategia AS EST
	ON PROD.CUV = EST.CUV2 AND EST.CampaniaID = PROD.AnoCampania 
	LEFT JOIN Marca MAR WITH (NOLOCK)
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

If Exists(select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.GetDemostradoresCaminoBrillante'))
Begin
	DROP PROCEDURE [dbo].[GetDemostradoresCaminoBrillante]
end
GO
CREATE PROC [dbo].[GetDemostradoresCaminoBrillante] (
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
	PROD.CUV Cuv,	
	PROD.CodigoProducto AS CodigoProducto,
	PROD.Descripcion AS Descripcion
	,PROD.PrecioValorizado AS PrecioValorizado
	,PROD.PrecioCatalogo AS PrecioCatalogo
	,PROD.CUV AS CUV
	,0 AS EstrategiaID
	,'0' AS CodigoEstrategia
	,PROD.Descripcion AS DescripcionCUV
	,EST.DescripcionCUV2 AS DescripcionCortaCUV
	,ISNULL(PROD.MarcaID,0) AS MarcaID
	,MAR.Descripcion AS DescripcionMarca
	,PROD.PrecioValorizado AS PrecioFinal
	,PROD.PrecioValorizado - PROD.PrecioCatalogo  AS Ganancia
	,EIM.NombreImagen AS FotoProductoSmall
	,EIM.NombreImagen AS FotoProductoMedium
	,0 AS TipoEstrategiaID
	,0 AS OrigenPedidoWebFicha

FROM ods.productocomercial AS PROD WITH (NOLOCK) LEFT JOIN dbo.Estrategia AS EST
	ON PROD.CUV = EST.CUV2 AND EST.CampaniaID = PROD.AnoCampania 
	LEFT JOIN Marca MAR WITH (NOLOCK)
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

If Exists(select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.GetDemostradoresCaminoBrillante'))
Begin
	DROP PROCEDURE [dbo].[GetDemostradoresCaminoBrillante]
end
GO
CREATE PROC [dbo].[GetDemostradoresCaminoBrillante] (
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
	PROD.CUV Cuv,	
	PROD.CodigoProducto AS CodigoProducto,
	PROD.Descripcion AS Descripcion
	,PROD.PrecioValorizado AS PrecioValorizado
	,PROD.PrecioCatalogo AS PrecioCatalogo
	,PROD.CUV AS CUV
	,0 AS EstrategiaID
	,'0' AS CodigoEstrategia
	,PROD.Descripcion AS DescripcionCUV
	,EST.DescripcionCUV2 AS DescripcionCortaCUV
	,ISNULL(PROD.MarcaID,0) AS MarcaID
	,MAR.Descripcion AS DescripcionMarca
	,PROD.PrecioValorizado AS PrecioFinal
	,PROD.PrecioValorizado - PROD.PrecioCatalogo  AS Ganancia
	,EIM.NombreImagen AS FotoProductoSmall
	,EIM.NombreImagen AS FotoProductoMedium
	,0 AS TipoEstrategiaID
	,0 AS OrigenPedidoWebFicha

FROM ods.productocomercial AS PROD WITH (NOLOCK) LEFT JOIN dbo.Estrategia AS EST
	ON PROD.CUV = EST.CUV2 AND EST.CampaniaID = PROD.AnoCampania 
	LEFT JOIN Marca MAR WITH (NOLOCK)
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

If Exists(select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.GetDemostradoresCaminoBrillante'))
Begin
	DROP PROCEDURE [dbo].[GetDemostradoresCaminoBrillante]
end
GO
CREATE PROC [dbo].[GetDemostradoresCaminoBrillante] (
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
	PROD.CUV Cuv,	
	PROD.CodigoProducto AS CodigoProducto,
	PROD.Descripcion AS Descripcion
	,PROD.PrecioValorizado AS PrecioValorizado
	,PROD.PrecioCatalogo AS PrecioCatalogo
	,PROD.CUV AS CUV
	,0 AS EstrategiaID
	,'0' AS CodigoEstrategia
	,PROD.Descripcion AS DescripcionCUV
	,EST.DescripcionCUV2 AS DescripcionCortaCUV
	,ISNULL(PROD.MarcaID,0) AS MarcaID
	,MAR.Descripcion AS DescripcionMarca
	,PROD.PrecioValorizado AS PrecioFinal
	,PROD.PrecioValorizado - PROD.PrecioCatalogo  AS Ganancia
	,EIM.NombreImagen AS FotoProductoSmall
	,EIM.NombreImagen AS FotoProductoMedium
	,0 AS TipoEstrategiaID
	,0 AS OrigenPedidoWebFicha

FROM ods.productocomercial AS PROD WITH (NOLOCK) LEFT JOIN dbo.Estrategia AS EST
	ON PROD.CUV = EST.CUV2 AND EST.CampaniaID = PROD.AnoCampania 
	LEFT JOIN Marca MAR WITH (NOLOCK)
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

If Exists(select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.GetDemostradoresCaminoBrillante'))
Begin
	DROP PROCEDURE [dbo].[GetDemostradoresCaminoBrillante]
end
GO
CREATE PROC [dbo].[GetDemostradoresCaminoBrillante] (
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
	PROD.CUV Cuv,	
	PROD.CodigoProducto AS CodigoProducto,
	PROD.Descripcion AS Descripcion
	,PROD.PrecioValorizado AS PrecioValorizado
	,PROD.PrecioCatalogo AS PrecioCatalogo
	,PROD.CUV AS CUV
	,0 AS EstrategiaID
	,'0' AS CodigoEstrategia
	,PROD.Descripcion AS DescripcionCUV
	,EST.DescripcionCUV2 AS DescripcionCortaCUV
	,ISNULL(PROD.MarcaID,0) AS MarcaID
	,MAR.Descripcion AS DescripcionMarca
	,PROD.PrecioValorizado AS PrecioFinal
	,PROD.PrecioValorizado - PROD.PrecioCatalogo  AS Ganancia
	,EIM.NombreImagen AS FotoProductoSmall
	,EIM.NombreImagen AS FotoProductoMedium
	,0 AS TipoEstrategiaID
	,0 AS OrigenPedidoWebFicha

FROM ods.productocomercial AS PROD WITH (NOLOCK) LEFT JOIN dbo.Estrategia AS EST
	ON PROD.CUV = EST.CUV2 AND EST.CampaniaID = PROD.AnoCampania 
	LEFT JOIN Marca MAR WITH (NOLOCK)
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

If Exists(select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.GetDemostradoresCaminoBrillante'))
Begin
	DROP PROCEDURE [dbo].[GetDemostradoresCaminoBrillante]
end
GO
CREATE PROC [dbo].[GetDemostradoresCaminoBrillante] (
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
	PROD.CUV Cuv,	
	PROD.CodigoProducto AS CodigoProducto,
	PROD.Descripcion AS Descripcion
	,PROD.PrecioValorizado AS PrecioValorizado
	,PROD.PrecioCatalogo AS PrecioCatalogo
	,PROD.CUV AS CUV
	,0 AS EstrategiaID
	,'0' AS CodigoEstrategia
	,PROD.Descripcion AS DescripcionCUV
	,EST.DescripcionCUV2 AS DescripcionCortaCUV
	,ISNULL(PROD.MarcaID,0) AS MarcaID
	,MAR.Descripcion AS DescripcionMarca
	,PROD.PrecioValorizado AS PrecioFinal
	,PROD.PrecioValorizado - PROD.PrecioCatalogo  AS Ganancia
	,EIM.NombreImagen AS FotoProductoSmall
	,EIM.NombreImagen AS FotoProductoMedium
	,0 AS TipoEstrategiaID
	,0 AS OrigenPedidoWebFicha

FROM ods.productocomercial AS PROD WITH (NOLOCK) LEFT JOIN dbo.Estrategia AS EST
	ON PROD.CUV = EST.CUV2 AND EST.CampaniaID = PROD.AnoCampania 
	LEFT JOIN Marca MAR WITH (NOLOCK)
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

If Exists(select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.GetDemostradoresCaminoBrillante'))
Begin
	DROP PROCEDURE [dbo].[GetDemostradoresCaminoBrillante]
end
GO
CREATE PROC [dbo].[GetDemostradoresCaminoBrillante] (
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
	PROD.CUV Cuv,	
	PROD.CodigoProducto AS CodigoProducto,
	PROD.Descripcion AS Descripcion
	,PROD.PrecioValorizado AS PrecioValorizado
	,PROD.PrecioCatalogo AS PrecioCatalogo
	,PROD.CUV AS CUV
	,0 AS EstrategiaID
	,'0' AS CodigoEstrategia
	,PROD.Descripcion AS DescripcionCUV
	,EST.DescripcionCUV2 AS DescripcionCortaCUV
	,ISNULL(PROD.MarcaID,0) AS MarcaID
	,MAR.Descripcion AS DescripcionMarca
	,PROD.PrecioValorizado AS PrecioFinal
	,PROD.PrecioValorizado - PROD.PrecioCatalogo  AS Ganancia
	,EIM.NombreImagen AS FotoProductoSmall
	,EIM.NombreImagen AS FotoProductoMedium
	,0 AS TipoEstrategiaID
	,0 AS OrigenPedidoWebFicha

FROM ods.productocomercial AS PROD WITH (NOLOCK) LEFT JOIN dbo.Estrategia AS EST
	ON PROD.CUV = EST.CUV2 AND EST.CampaniaID = PROD.AnoCampania 
	LEFT JOIN Marca MAR WITH (NOLOCK)
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

If Exists(select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.GetDemostradoresCaminoBrillante'))
Begin
	DROP PROCEDURE [dbo].[GetDemostradoresCaminoBrillante]
end
GO
CREATE PROC [dbo].[GetDemostradoresCaminoBrillante] (
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
	PROD.CUV Cuv,	
	PROD.CodigoProducto AS CodigoProducto,
	PROD.Descripcion AS Descripcion
	,PROD.PrecioValorizado AS PrecioValorizado
	,PROD.PrecioCatalogo AS PrecioCatalogo
	,PROD.CUV AS CUV
	,0 AS EstrategiaID
	,'0' AS CodigoEstrategia
	,PROD.Descripcion AS DescripcionCUV
	,EST.DescripcionCUV2 AS DescripcionCortaCUV
	,ISNULL(PROD.MarcaID,0) AS MarcaID
	,MAR.Descripcion AS DescripcionMarca
	,PROD.PrecioValorizado AS PrecioFinal
	,PROD.PrecioValorizado - PROD.PrecioCatalogo  AS Ganancia
	,EIM.NombreImagen AS FotoProductoSmall
	,EIM.NombreImagen AS FotoProductoMedium
	,0 AS TipoEstrategiaID
	,0 AS OrigenPedidoWebFicha

FROM ods.productocomercial AS PROD WITH (NOLOCK) LEFT JOIN dbo.Estrategia AS EST
	ON PROD.CUV = EST.CUV2 AND EST.CampaniaID = PROD.AnoCampania 
	LEFT JOIN Marca MAR WITH (NOLOCK)
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

If Exists(select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.GetDemostradoresCaminoBrillante'))
Begin
	DROP PROCEDURE [dbo].[GetDemostradoresCaminoBrillante]
end
GO
CREATE PROC [dbo].[GetDemostradoresCaminoBrillante] (
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
	PROD.CUV Cuv,	
	PROD.CodigoProducto AS CodigoProducto,
	PROD.Descripcion AS Descripcion
	,PROD.PrecioValorizado AS PrecioValorizado
	,PROD.PrecioCatalogo AS PrecioCatalogo
	,PROD.CUV AS CUV
	,0 AS EstrategiaID
	,'0' AS CodigoEstrategia
	,PROD.Descripcion AS DescripcionCUV
	,EST.DescripcionCUV2 AS DescripcionCortaCUV
	,ISNULL(PROD.MarcaID,0) AS MarcaID
	,MAR.Descripcion AS DescripcionMarca
	,PROD.PrecioValorizado AS PrecioFinal
	,PROD.PrecioValorizado - PROD.PrecioCatalogo  AS Ganancia
	,EIM.NombreImagen AS FotoProductoSmall
	,EIM.NombreImagen AS FotoProductoMedium
	,0 AS TipoEstrategiaID
	,0 AS OrigenPedidoWebFicha

FROM ods.productocomercial AS PROD WITH (NOLOCK) LEFT JOIN dbo.Estrategia AS EST
	ON PROD.CUV = EST.CUV2 AND EST.CampaniaID = PROD.AnoCampania 
	LEFT JOIN Marca MAR WITH (NOLOCK)
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

If Exists(select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.GetDemostradoresCaminoBrillante'))
Begin
	DROP PROCEDURE [dbo].[GetDemostradoresCaminoBrillante]
end
GO
CREATE PROC [dbo].[GetDemostradoresCaminoBrillante] (
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
	PROD.CUV Cuv,	
	PROD.CodigoProducto AS CodigoProducto,
	PROD.Descripcion AS Descripcion
	,PROD.PrecioValorizado AS PrecioValorizado
	,PROD.PrecioCatalogo AS PrecioCatalogo
	,PROD.CUV AS CUV
	,0 AS EstrategiaID
	,'0' AS CodigoEstrategia
	,PROD.Descripcion AS DescripcionCUV
	,EST.DescripcionCUV2 AS DescripcionCortaCUV
	,ISNULL(PROD.MarcaID,0) AS MarcaID
	,MAR.Descripcion AS DescripcionMarca
	,PROD.PrecioValorizado AS PrecioFinal
	,PROD.PrecioValorizado - PROD.PrecioCatalogo  AS Ganancia
	,EIM.NombreImagen AS FotoProductoSmall
	,EIM.NombreImagen AS FotoProductoMedium
	,0 AS TipoEstrategiaID
	,0 AS OrigenPedidoWebFicha

FROM ods.productocomercial AS PROD WITH (NOLOCK) LEFT JOIN dbo.Estrategia AS EST
	ON PROD.CUV = EST.CUV2 AND EST.CampaniaID = PROD.AnoCampania 
	LEFT JOIN Marca MAR WITH (NOLOCK)
	ON MAR.MarcaID = PROD.MarcaID
	LEFT JOIN dbo.EstrategiaImagen AS EIM WITH (NOLOCK)
	ON EIM.CampaniaID = PROD.AnoCampania  AND EIM.CUV = PROD.CUV
WHERE PROD.AnoCampania = @AnoCampania
	and PROD.CodigoCatalago = 35 
	and PROD.NumeroPagina = @TipoOferta
	
END
GO

