USE BelcorpPeru
GO

If Exists(select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.GetKitsCaminoBrillante'))
Begin
	DROP PROCEDURE [dbo].[GetKitsCaminoBrillante]
end
GO
CREATE PROC [dbo].[GetKitsCaminoBrillante] (
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
	,0 AS EstrategiaID  --Validar si es Necesario
	,'0' AS CodigoEstrategia --Validar si es Necesario
	,PROD.Descripcion AS DescripcionCUV
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
WHERE PROD.NumeroPagina IN (204, 205, 206, 207)
END
GO

USE BelcorpMexico
GO

If Exists(select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.GetKitsCaminoBrillante'))
Begin
	DROP PROCEDURE [dbo].[GetKitsCaminoBrillante]
end
GO
CREATE PROC [dbo].[GetKitsCaminoBrillante] (
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
	,0 AS EstrategiaID  --Validar si es Necesario
	,'0' AS CodigoEstrategia --Validar si es Necesario
	,PROD.Descripcion AS DescripcionCUV
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
WHERE PROD.NumeroPagina IN (204, 205, 206, 207)
END
GO

USE BelcorpColombia
GO

If Exists(select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.GetKitsCaminoBrillante'))
Begin
	DROP PROCEDURE [dbo].[GetKitsCaminoBrillante]
end
GO
CREATE PROC [dbo].[GetKitsCaminoBrillante] (
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
	,0 AS EstrategiaID  --Validar si es Necesario
	,'0' AS CodigoEstrategia --Validar si es Necesario
	,PROD.Descripcion AS DescripcionCUV
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
WHERE PROD.NumeroPagina IN (204, 205, 206, 207)
END
GO

USE BelcorpSalvador
GO

If Exists(select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.GetKitsCaminoBrillante'))
Begin
	DROP PROCEDURE [dbo].[GetKitsCaminoBrillante]
end
GO
CREATE PROC [dbo].[GetKitsCaminoBrillante] (
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
	,0 AS EstrategiaID  --Validar si es Necesario
	,'0' AS CodigoEstrategia --Validar si es Necesario
	,PROD.Descripcion AS DescripcionCUV
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
WHERE PROD.NumeroPagina IN (204, 205, 206, 207)
END
GO

USE BelcorpPuertoRico
GO

If Exists(select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.GetKitsCaminoBrillante'))
Begin
	DROP PROCEDURE [dbo].[GetKitsCaminoBrillante]
end
GO
CREATE PROC [dbo].[GetKitsCaminoBrillante] (
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
	,0 AS EstrategiaID  --Validar si es Necesario
	,'0' AS CodigoEstrategia --Validar si es Necesario
	,PROD.Descripcion AS DescripcionCUV
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
WHERE PROD.NumeroPagina IN (204, 205, 206, 207)
END
GO

USE BelcorpPanama
GO

If Exists(select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.GetKitsCaminoBrillante'))
Begin
	DROP PROCEDURE [dbo].[GetKitsCaminoBrillante]
end
GO
CREATE PROC [dbo].[GetKitsCaminoBrillante] (
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
	,0 AS EstrategiaID  --Validar si es Necesario
	,'0' AS CodigoEstrategia --Validar si es Necesario
	,PROD.Descripcion AS DescripcionCUV
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
WHERE PROD.NumeroPagina IN (204, 205, 206, 207)
END
GO

USE BelcorpGuatemala
GO

If Exists(select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.GetKitsCaminoBrillante'))
Begin
	DROP PROCEDURE [dbo].[GetKitsCaminoBrillante]
end
GO
CREATE PROC [dbo].[GetKitsCaminoBrillante] (
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
	,0 AS EstrategiaID  --Validar si es Necesario
	,'0' AS CodigoEstrategia --Validar si es Necesario
	,PROD.Descripcion AS DescripcionCUV
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
WHERE PROD.NumeroPagina IN (204, 205, 206, 207)
END
GO

USE BelcorpEcuador
GO

If Exists(select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.GetKitsCaminoBrillante'))
Begin
	DROP PROCEDURE [dbo].[GetKitsCaminoBrillante]
end
GO
CREATE PROC [dbo].[GetKitsCaminoBrillante] (
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
	,0 AS EstrategiaID  --Validar si es Necesario
	,'0' AS CodigoEstrategia --Validar si es Necesario
	,PROD.Descripcion AS DescripcionCUV
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
WHERE PROD.NumeroPagina IN (204, 205, 206, 207)
END
GO

USE BelcorpDominicana
GO

If Exists(select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.GetKitsCaminoBrillante'))
Begin
	DROP PROCEDURE [dbo].[GetKitsCaminoBrillante]
end
GO
CREATE PROC [dbo].[GetKitsCaminoBrillante] (
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
	,0 AS EstrategiaID  --Validar si es Necesario
	,'0' AS CodigoEstrategia --Validar si es Necesario
	,PROD.Descripcion AS DescripcionCUV
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
WHERE PROD.NumeroPagina IN (204, 205, 206, 207)
END
GO

USE BelcorpCostaRica
GO

If Exists(select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.GetKitsCaminoBrillante'))
Begin
	DROP PROCEDURE [dbo].[GetKitsCaminoBrillante]
end
GO
CREATE PROC [dbo].[GetKitsCaminoBrillante] (
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
	,0 AS EstrategiaID  --Validar si es Necesario
	,'0' AS CodigoEstrategia --Validar si es Necesario
	,PROD.Descripcion AS DescripcionCUV
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
WHERE PROD.NumeroPagina IN (204, 205, 206, 207)
END
GO

USE BelcorpChile
GO

If Exists(select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.GetKitsCaminoBrillante'))
Begin
	DROP PROCEDURE [dbo].[GetKitsCaminoBrillante]
end
GO
CREATE PROC [dbo].[GetKitsCaminoBrillante] (
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
	,0 AS EstrategiaID  --Validar si es Necesario
	,'0' AS CodigoEstrategia --Validar si es Necesario
	,PROD.Descripcion AS DescripcionCUV
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
WHERE PROD.NumeroPagina IN (204, 205, 206, 207)
END
GO

USE BelcorpBolivia
GO

If Exists(select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.GetKitsCaminoBrillante'))
Begin
	DROP PROCEDURE [dbo].[GetKitsCaminoBrillante]
end
GO
CREATE PROC [dbo].[GetKitsCaminoBrillante] (
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
	,0 AS EstrategiaID  --Validar si es Necesario
	,'0' AS CodigoEstrategia --Validar si es Necesario
	,PROD.Descripcion AS DescripcionCUV
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
WHERE PROD.NumeroPagina IN (204, 205, 206, 207)
END
GO

