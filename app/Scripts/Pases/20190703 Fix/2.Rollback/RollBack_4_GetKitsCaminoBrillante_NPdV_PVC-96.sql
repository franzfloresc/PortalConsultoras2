USE BelcorpPeru_APP
GO

IF Exists(select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.GetKitsCaminoBrillante'))
	DROP PROCEDURE dbo.GetKitsCaminoBrillante
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
,0 AS EstrategiaID --Validar si es Necesario
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

USE BelcorpMexico_APP
GO

IF Exists(select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.GetKitsCaminoBrillante'))
	DROP PROCEDURE dbo.GetKitsCaminoBrillante
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
,0 AS EstrategiaID --Validar si es Necesario
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

USE BelcorpColombia_APP
GO

IF Exists(select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.GetKitsCaminoBrillante'))
	DROP PROCEDURE dbo.GetKitsCaminoBrillante
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
,0 AS EstrategiaID --Validar si es Necesario
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

USE BelcorpSalvador_APP
GO

IF Exists(select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.GetKitsCaminoBrillante'))
	DROP PROCEDURE dbo.GetKitsCaminoBrillante
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
,0 AS EstrategiaID --Validar si es Necesario
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

USE BelcorpPuertoRico_APP
GO

IF Exists(select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.GetKitsCaminoBrillante'))
	DROP PROCEDURE dbo.GetKitsCaminoBrillante
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
,0 AS EstrategiaID --Validar si es Necesario
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

USE BelcorpPanama_APP
GO

IF Exists(select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.GetKitsCaminoBrillante'))
	DROP PROCEDURE dbo.GetKitsCaminoBrillante
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
,0 AS EstrategiaID --Validar si es Necesario
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

USE BelcorpGuatemala_APP
GO

IF Exists(select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.GetKitsCaminoBrillante'))
	DROP PROCEDURE dbo.GetKitsCaminoBrillante
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
,0 AS EstrategiaID --Validar si es Necesario
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

USE BelcorpEcuador_APP
GO

IF Exists(select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.GetKitsCaminoBrillante'))
	DROP PROCEDURE dbo.GetKitsCaminoBrillante
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
,0 AS EstrategiaID --Validar si es Necesario
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

USE BelcorpDominicana_APP
GO

IF Exists(select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.GetKitsCaminoBrillante'))
	DROP PROCEDURE dbo.GetKitsCaminoBrillante
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
,0 AS EstrategiaID --Validar si es Necesario
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

USE BelcorpCostaRica_APP
GO

IF Exists(select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.GetKitsCaminoBrillante'))
	DROP PROCEDURE dbo.GetKitsCaminoBrillante
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
,0 AS EstrategiaID --Validar si es Necesario
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

USE BelcorpChile_APP
GO

IF Exists(select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.GetKitsCaminoBrillante'))
	DROP PROCEDURE dbo.GetKitsCaminoBrillante
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
,0 AS EstrategiaID --Validar si es Necesario
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

USE BelcorpBolivia_APP
GO

IF Exists(select 1 from SYSOBJECTS where type = 'P' and id = OBJECT_ID('dbo.GetKitsCaminoBrillante'))
	DROP PROCEDURE dbo.GetKitsCaminoBrillante
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
,0 AS EstrategiaID --Validar si es Necesario
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

