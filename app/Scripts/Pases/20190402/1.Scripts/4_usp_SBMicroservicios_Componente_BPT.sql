GO
USE BelcorpPeru
GO

GO
ALTER PROCEDURE [dbo].[usp_SBMicroservicios_Componente]
AS
BEGIN
	SET NOCOUNT ON;

	WITH cte_ProductoComercial(CAMPANIAID,CUV,CUV2,CODIGO_ESTRATEGIA,GRUPO,CODIGO_SAP)
	AS
	(
		SELECT
		PMO.AnoCampania AS CAMPANIAID
		,PMO.CUV AS CUV
		,PM.CUV AS CUV2
		,PM.EstrategiaIDSicc AS CODIGO_ESTRATEGIA
		,ISNULL(PMO.NUMEROGRUPO,0) AS GRUPO
		,PMO.CodigoProducto AS CODIGO_SAP
		FROM ods.ProductoComercial PM WITH (NOLOCK)
			INNER JOIN ods.ProductoComercial PMO
			ON PM.EstrategiaIDSicc = PMO.EstrategiaIDSicc
			AND PM.AnoCampania =PMO.AnoCampania
			AND PM.CodigoOferta = PMO.CodigoOferta
		GROUP BY
		PMO.AnoCampania
		,PMO.CUV
		,PM.CUV
		,PM.EstrategiaIDSicc
		,PMO.NUMEROGRUPO
		,PMO.CodigoProducto
	)
	SELECT
		 EPT.CUV2 AS CuvPadre
		,EPT.CAMPANIAID AS CampaniaId
		,EPT.CUV AS CUV
		,EPT.CODIGO_ESTRATEGIA AS CodigoEstrategia
		,EPT.Grupo
		,EPT.CODIGO_SAP AS CodigoSap
		,ISNULL(PCT.FactorRepeticion,1) AS Cantidad
		,PCT.PrecioUnitario AS PrecioUnitario
		,PCT.PrecioValorizado AS PrecioValorizado
		,PCT.NumeroLineaOferta AS Orden
		,PCT.IndicadorDigitable AS Digitable
		,CAST(ISNULL(PCT.CodigoFactorCuadre,1) AS INT) AS FactorCuadre
		,PCT.DESCRIPCION AS NombreProducto
		,PCT.MarcaID AS IdMarca
		,M.Descripcion AS NombreMarca
		,fb.Nombre
		,ga.DescripcionCorta
		,sl.DescripcionLarga
		,EPTM.NombreComercial AS NombreComercial
		,EPTM.Descripcion
		,EPTM.Volumen
		,EPTM.Imagen
		,EPTM.ImagenBulk
		,EPTM.NombreBulk
		,EPTM.CampaniaApp as CampaniaApp
		FROM cte_ProductoComercial EPT
		INNER JOIN  ods.ProductoComercial PCT ON EPT.CAMPANIAID = PCT.AnoCampania
			AND EPT.CUV = PCT.CUV
			AND EPT.CODIGO_ESTRATEGIA = PCT.EstrategiaIDSicc
		INNER JOIN dbo.Marca M ON M.MarcaID = PCT.MarcaID
		LEFT JOIN ods.SAP_PRODUCTO sp WITH (NOLOCK) ON PCT.CodigoProducto = sp.CodigoSap
		LEFT JOIN ods.SAP_LINEA sl WITH (NOLOCK) on sp.CodigoLinea = sl.Codigo
		LEFT JOIN ods.SAP_GRUPOARTICULO ga WITH (NOLOCK) on sp.CodigoGrupoArticuloSAP = ga.Codigo
		LEFT JOIN dbo.FiltroBuscadorGrupoArticulo fbga WITH (NOLOCK) on ga.Codigo = fbga.CodigoGrupoArticulo
		LEFT JOIN dbo.FiltroBuscador fb WITH (NOLOCK) on fbga.CodigoFiltroBuscador = fb.Codigo
		LEFT JOIN EstrategiaProductoTemporalMongoApp EPTM WITH (NOLOCK) on
        	PCT.AnoCampania = EPTM.Campania AND PCT.CodigoProducto = EPTM.CodigoSap
END

GO



GO
USE BelcorpMexico
GO

GO
ALTER PROCEDURE [dbo].[usp_SBMicroservicios_Componente]
AS
BEGIN
	SET NOCOUNT ON;

	WITH cte_ProductoComercial(CAMPANIAID,CUV,CUV2,CODIGO_ESTRATEGIA,GRUPO,CODIGO_SAP)
	AS
	(
		SELECT
		PMO.AnoCampania AS CAMPANIAID
		,PMO.CUV AS CUV
		,PM.CUV AS CUV2
		,PM.EstrategiaIDSicc AS CODIGO_ESTRATEGIA
		,ISNULL(PMO.NUMEROGRUPO,0) AS GRUPO
		,PMO.CodigoProducto AS CODIGO_SAP
		FROM ods.ProductoComercial PM WITH (NOLOCK)
			INNER JOIN ods.ProductoComercial PMO
			ON PM.EstrategiaIDSicc = PMO.EstrategiaIDSicc
			AND PM.AnoCampania =PMO.AnoCampania
			AND PM.CodigoOferta = PMO.CodigoOferta
		GROUP BY
		PMO.AnoCampania
		,PMO.CUV
		,PM.CUV
		,PM.EstrategiaIDSicc
		,PMO.NUMEROGRUPO
		,PMO.CodigoProducto
	)
	SELECT
		 EPT.CUV2 AS CuvPadre
		,EPT.CAMPANIAID AS CampaniaId
		,EPT.CUV AS CUV
		,EPT.CODIGO_ESTRATEGIA AS CodigoEstrategia
		,EPT.Grupo
		,EPT.CODIGO_SAP AS CodigoSap
		,ISNULL(PCT.FactorRepeticion,1) AS Cantidad
		,PCT.PrecioUnitario AS PrecioUnitario
		,PCT.PrecioValorizado AS PrecioValorizado
		,PCT.NumeroLineaOferta AS Orden
		,PCT.IndicadorDigitable AS Digitable
		,CAST(ISNULL(PCT.CodigoFactorCuadre,1) AS INT) AS FactorCuadre
		,PCT.DESCRIPCION AS NombreProducto
		,PCT.MarcaID AS IdMarca
		,M.Descripcion AS NombreMarca
		,fb.Nombre
		,ga.DescripcionCorta
		,sl.DescripcionLarga
		,EPTM.NombreComercial AS NombreComercial
		,EPTM.Descripcion
		,EPTM.Volumen
		,EPTM.Imagen
		,EPTM.ImagenBulk
		,EPTM.NombreBulk
		,EPTM.CampaniaApp as CampaniaApp
		FROM cte_ProductoComercial EPT
		INNER JOIN  ods.ProductoComercial PCT ON EPT.CAMPANIAID = PCT.AnoCampania
			AND EPT.CUV = PCT.CUV
			AND EPT.CODIGO_ESTRATEGIA = PCT.EstrategiaIDSicc
		INNER JOIN dbo.Marca M ON M.MarcaID = PCT.MarcaID
		LEFT JOIN ods.SAP_PRODUCTO sp WITH (NOLOCK) ON PCT.CodigoProducto = sp.CodigoSap
		LEFT JOIN ods.SAP_LINEA sl WITH (NOLOCK) on sp.CodigoLinea = sl.Codigo
		LEFT JOIN ods.SAP_GRUPOARTICULO ga WITH (NOLOCK) on sp.CodigoGrupoArticuloSAP = ga.Codigo
		LEFT JOIN dbo.FiltroBuscadorGrupoArticulo fbga WITH (NOLOCK) on ga.Codigo = fbga.CodigoGrupoArticulo
		LEFT JOIN dbo.FiltroBuscador fb WITH (NOLOCK) on fbga.CodigoFiltroBuscador = fb.Codigo
		LEFT JOIN EstrategiaProductoTemporalMongoApp EPTM WITH (NOLOCK) on
        	PCT.AnoCampania = EPTM.Campania AND PCT.CodigoProducto = EPTM.CodigoSap
END

GO



GO
USE BelcorpColombia
GO

GO
ALTER PROCEDURE [dbo].[usp_SBMicroservicios_Componente]
AS
BEGIN
	SET NOCOUNT ON;

	WITH cte_ProductoComercial(CAMPANIAID,CUV,CUV2,CODIGO_ESTRATEGIA,GRUPO,CODIGO_SAP)
	AS
	(
		SELECT
		PMO.AnoCampania AS CAMPANIAID
		,PMO.CUV AS CUV
		,PM.CUV AS CUV2
		,PM.EstrategiaIDSicc AS CODIGO_ESTRATEGIA
		,ISNULL(PMO.NUMEROGRUPO,0) AS GRUPO
		,PMO.CodigoProducto AS CODIGO_SAP
		FROM ods.ProductoComercial PM WITH (NOLOCK)
			INNER JOIN ods.ProductoComercial PMO
			ON PM.EstrategiaIDSicc = PMO.EstrategiaIDSicc
			AND PM.AnoCampania =PMO.AnoCampania
			AND PM.CodigoOferta = PMO.CodigoOferta
		GROUP BY
		PMO.AnoCampania
		,PMO.CUV
		,PM.CUV
		,PM.EstrategiaIDSicc
		,PMO.NUMEROGRUPO
		,PMO.CodigoProducto
	)
	SELECT
		 EPT.CUV2 AS CuvPadre
		,EPT.CAMPANIAID AS CampaniaId
		,EPT.CUV AS CUV
		,EPT.CODIGO_ESTRATEGIA AS CodigoEstrategia
		,EPT.Grupo
		,EPT.CODIGO_SAP AS CodigoSap
		,ISNULL(PCT.FactorRepeticion,1) AS Cantidad
		,PCT.PrecioUnitario AS PrecioUnitario
		,PCT.PrecioValorizado AS PrecioValorizado
		,PCT.NumeroLineaOferta AS Orden
		,PCT.IndicadorDigitable AS Digitable
		,CAST(ISNULL(PCT.CodigoFactorCuadre,1) AS INT) AS FactorCuadre
		,PCT.DESCRIPCION AS NombreProducto
		,PCT.MarcaID AS IdMarca
		,M.Descripcion AS NombreMarca
		,fb.Nombre
		,ga.DescripcionCorta
		,sl.DescripcionLarga
		,EPTM.NombreComercial AS NombreComercial
		,EPTM.Descripcion
		,EPTM.Volumen
		,EPTM.Imagen
		,EPTM.ImagenBulk
		,EPTM.NombreBulk
		,EPTM.CampaniaApp as CampaniaApp
		FROM cte_ProductoComercial EPT
		INNER JOIN  ods.ProductoComercial PCT ON EPT.CAMPANIAID = PCT.AnoCampania
			AND EPT.CUV = PCT.CUV
			AND EPT.CODIGO_ESTRATEGIA = PCT.EstrategiaIDSicc
		INNER JOIN dbo.Marca M ON M.MarcaID = PCT.MarcaID
		LEFT JOIN ods.SAP_PRODUCTO sp WITH (NOLOCK) ON PCT.CodigoProducto = sp.CodigoSap
		LEFT JOIN ods.SAP_LINEA sl WITH (NOLOCK) on sp.CodigoLinea = sl.Codigo
		LEFT JOIN ods.SAP_GRUPOARTICULO ga WITH (NOLOCK) on sp.CodigoGrupoArticuloSAP = ga.Codigo
		LEFT JOIN dbo.FiltroBuscadorGrupoArticulo fbga WITH (NOLOCK) on ga.Codigo = fbga.CodigoGrupoArticulo
		LEFT JOIN dbo.FiltroBuscador fb WITH (NOLOCK) on fbga.CodigoFiltroBuscador = fb.Codigo
		LEFT JOIN EstrategiaProductoTemporalMongoApp EPTM WITH (NOLOCK) on
        	PCT.AnoCampania = EPTM.Campania AND PCT.CodigoProducto = EPTM.CodigoSap
END

GO



GO
USE BelcorpSalvador
GO

GO
ALTER PROCEDURE [dbo].[usp_SBMicroservicios_Componente]
AS
BEGIN
	SET NOCOUNT ON;

	WITH cte_ProductoComercial(CAMPANIAID,CUV,CUV2,CODIGO_ESTRATEGIA,GRUPO,CODIGO_SAP)
	AS
	(
		SELECT
		PMO.AnoCampania AS CAMPANIAID
		,PMO.CUV AS CUV
		,PM.CUV AS CUV2
		,PM.EstrategiaIDSicc AS CODIGO_ESTRATEGIA
		,ISNULL(PMO.NUMEROGRUPO,0) AS GRUPO
		,PMO.CodigoProducto AS CODIGO_SAP
		FROM ods.ProductoComercial PM WITH (NOLOCK)
			INNER JOIN ods.ProductoComercial PMO
			ON PM.EstrategiaIDSicc = PMO.EstrategiaIDSicc
			AND PM.AnoCampania =PMO.AnoCampania
			AND PM.CodigoOferta = PMO.CodigoOferta
		GROUP BY
		PMO.AnoCampania
		,PMO.CUV
		,PM.CUV
		,PM.EstrategiaIDSicc
		,PMO.NUMEROGRUPO
		,PMO.CodigoProducto
	)
	SELECT
		 EPT.CUV2 AS CuvPadre
		,EPT.CAMPANIAID AS CampaniaId
		,EPT.CUV AS CUV
		,EPT.CODIGO_ESTRATEGIA AS CodigoEstrategia
		,EPT.Grupo
		,EPT.CODIGO_SAP AS CodigoSap
		,ISNULL(PCT.FactorRepeticion,1) AS Cantidad
		,PCT.PrecioUnitario AS PrecioUnitario
		,PCT.PrecioValorizado AS PrecioValorizado
		,PCT.NumeroLineaOferta AS Orden
		,PCT.IndicadorDigitable AS Digitable
		,CAST(ISNULL(PCT.CodigoFactorCuadre,1) AS INT) AS FactorCuadre
		,PCT.DESCRIPCION AS NombreProducto
		,PCT.MarcaID AS IdMarca
		,M.Descripcion AS NombreMarca
		,fb.Nombre
		,ga.DescripcionCorta
		,sl.DescripcionLarga
		,EPTM.NombreComercial AS NombreComercial
		,EPTM.Descripcion
		,EPTM.Volumen
		,EPTM.Imagen
		,EPTM.ImagenBulk
		,EPTM.NombreBulk
		,EPTM.CampaniaApp as CampaniaApp
		FROM cte_ProductoComercial EPT
		INNER JOIN  ods.ProductoComercial PCT ON EPT.CAMPANIAID = PCT.AnoCampania
			AND EPT.CUV = PCT.CUV
			AND EPT.CODIGO_ESTRATEGIA = PCT.EstrategiaIDSicc
		INNER JOIN dbo.Marca M ON M.MarcaID = PCT.MarcaID
		LEFT JOIN ods.SAP_PRODUCTO sp WITH (NOLOCK) ON PCT.CodigoProducto = sp.CodigoSap
		LEFT JOIN ods.SAP_LINEA sl WITH (NOLOCK) on sp.CodigoLinea = sl.Codigo
		LEFT JOIN ods.SAP_GRUPOARTICULO ga WITH (NOLOCK) on sp.CodigoGrupoArticuloSAP = ga.Codigo
		LEFT JOIN dbo.FiltroBuscadorGrupoArticulo fbga WITH (NOLOCK) on ga.Codigo = fbga.CodigoGrupoArticulo
		LEFT JOIN dbo.FiltroBuscador fb WITH (NOLOCK) on fbga.CodigoFiltroBuscador = fb.Codigo
		LEFT JOIN EstrategiaProductoTemporalMongoApp EPTM WITH (NOLOCK) on
        	PCT.AnoCampania = EPTM.Campania AND PCT.CodigoProducto = EPTM.CodigoSap
END

GO



GO
USE BelcorpPuertoRico
GO

GO
ALTER PROCEDURE [dbo].[usp_SBMicroservicios_Componente]
AS
BEGIN
	SET NOCOUNT ON;

	WITH cte_ProductoComercial(CAMPANIAID,CUV,CUV2,CODIGO_ESTRATEGIA,GRUPO,CODIGO_SAP)
	AS
	(
		SELECT
		PMO.AnoCampania AS CAMPANIAID
		,PMO.CUV AS CUV
		,PM.CUV AS CUV2
		,PM.EstrategiaIDSicc AS CODIGO_ESTRATEGIA
		,ISNULL(PMO.NUMEROGRUPO,0) AS GRUPO
		,PMO.CodigoProducto AS CODIGO_SAP
		FROM ods.ProductoComercial PM WITH (NOLOCK)
			INNER JOIN ods.ProductoComercial PMO
			ON PM.EstrategiaIDSicc = PMO.EstrategiaIDSicc
			AND PM.AnoCampania =PMO.AnoCampania
			AND PM.CodigoOferta = PMO.CodigoOferta
		GROUP BY
		PMO.AnoCampania
		,PMO.CUV
		,PM.CUV
		,PM.EstrategiaIDSicc
		,PMO.NUMEROGRUPO
		,PMO.CodigoProducto
	)
	SELECT
		 EPT.CUV2 AS CuvPadre
		,EPT.CAMPANIAID AS CampaniaId
		,EPT.CUV AS CUV
		,EPT.CODIGO_ESTRATEGIA AS CodigoEstrategia
		,EPT.Grupo
		,EPT.CODIGO_SAP AS CodigoSap
		,ISNULL(PCT.FactorRepeticion,1) AS Cantidad
		,PCT.PrecioUnitario AS PrecioUnitario
		,PCT.PrecioValorizado AS PrecioValorizado
		,PCT.NumeroLineaOferta AS Orden
		,PCT.IndicadorDigitable AS Digitable
		,CAST(ISNULL(PCT.CodigoFactorCuadre,1) AS INT) AS FactorCuadre
		,PCT.DESCRIPCION AS NombreProducto
		,PCT.MarcaID AS IdMarca
		,M.Descripcion AS NombreMarca
		,fb.Nombre
		,ga.DescripcionCorta
		,sl.DescripcionLarga
		,EPTM.NombreComercial AS NombreComercial
		,EPTM.Descripcion
		,EPTM.Volumen
		,EPTM.Imagen
		,EPTM.ImagenBulk
		,EPTM.NombreBulk
		,EPTM.CampaniaApp as CampaniaApp
		FROM cte_ProductoComercial EPT
		INNER JOIN  ods.ProductoComercial PCT ON EPT.CAMPANIAID = PCT.AnoCampania
			AND EPT.CUV = PCT.CUV
			AND EPT.CODIGO_ESTRATEGIA = PCT.EstrategiaIDSicc
		INNER JOIN dbo.Marca M ON M.MarcaID = PCT.MarcaID
		LEFT JOIN ods.SAP_PRODUCTO sp WITH (NOLOCK) ON PCT.CodigoProducto = sp.CodigoSap
		LEFT JOIN ods.SAP_LINEA sl WITH (NOLOCK) on sp.CodigoLinea = sl.Codigo
		LEFT JOIN ods.SAP_GRUPOARTICULO ga WITH (NOLOCK) on sp.CodigoGrupoArticuloSAP = ga.Codigo
		LEFT JOIN dbo.FiltroBuscadorGrupoArticulo fbga WITH (NOLOCK) on ga.Codigo = fbga.CodigoGrupoArticulo
		LEFT JOIN dbo.FiltroBuscador fb WITH (NOLOCK) on fbga.CodigoFiltroBuscador = fb.Codigo
		LEFT JOIN EstrategiaProductoTemporalMongoApp EPTM WITH (NOLOCK) on
        	PCT.AnoCampania = EPTM.Campania AND PCT.CodigoProducto = EPTM.CodigoSap
END

GO



GO
USE BelcorpPanama
GO

GO
ALTER PROCEDURE [dbo].[usp_SBMicroservicios_Componente]
AS
BEGIN
	SET NOCOUNT ON;

	WITH cte_ProductoComercial(CAMPANIAID,CUV,CUV2,CODIGO_ESTRATEGIA,GRUPO,CODIGO_SAP)
	AS
	(
		SELECT
		PMO.AnoCampania AS CAMPANIAID
		,PMO.CUV AS CUV
		,PM.CUV AS CUV2
		,PM.EstrategiaIDSicc AS CODIGO_ESTRATEGIA
		,ISNULL(PMO.NUMEROGRUPO,0) AS GRUPO
		,PMO.CodigoProducto AS CODIGO_SAP
		FROM ods.ProductoComercial PM WITH (NOLOCK)
			INNER JOIN ods.ProductoComercial PMO
			ON PM.EstrategiaIDSicc = PMO.EstrategiaIDSicc
			AND PM.AnoCampania =PMO.AnoCampania
			AND PM.CodigoOferta = PMO.CodigoOferta
		GROUP BY
		PMO.AnoCampania
		,PMO.CUV
		,PM.CUV
		,PM.EstrategiaIDSicc
		,PMO.NUMEROGRUPO
		,PMO.CodigoProducto
	)
	SELECT
		 EPT.CUV2 AS CuvPadre
		,EPT.CAMPANIAID AS CampaniaId
		,EPT.CUV AS CUV
		,EPT.CODIGO_ESTRATEGIA AS CodigoEstrategia
		,EPT.Grupo
		,EPT.CODIGO_SAP AS CodigoSap
		,ISNULL(PCT.FactorRepeticion,1) AS Cantidad
		,PCT.PrecioUnitario AS PrecioUnitario
		,PCT.PrecioValorizado AS PrecioValorizado
		,PCT.NumeroLineaOferta AS Orden
		,PCT.IndicadorDigitable AS Digitable
		,CAST(ISNULL(PCT.CodigoFactorCuadre,1) AS INT) AS FactorCuadre
		,PCT.DESCRIPCION AS NombreProducto
		,PCT.MarcaID AS IdMarca
		,M.Descripcion AS NombreMarca
		,fb.Nombre
		,ga.DescripcionCorta
		,sl.DescripcionLarga
		,EPTM.NombreComercial AS NombreComercial
		,EPTM.Descripcion
		,EPTM.Volumen
		,EPTM.Imagen
		,EPTM.ImagenBulk
		,EPTM.NombreBulk
		,EPTM.CampaniaApp as CampaniaApp
		FROM cte_ProductoComercial EPT
		INNER JOIN  ods.ProductoComercial PCT ON EPT.CAMPANIAID = PCT.AnoCampania
			AND EPT.CUV = PCT.CUV
			AND EPT.CODIGO_ESTRATEGIA = PCT.EstrategiaIDSicc
		INNER JOIN dbo.Marca M ON M.MarcaID = PCT.MarcaID
		LEFT JOIN ods.SAP_PRODUCTO sp WITH (NOLOCK) ON PCT.CodigoProducto = sp.CodigoSap
		LEFT JOIN ods.SAP_LINEA sl WITH (NOLOCK) on sp.CodigoLinea = sl.Codigo
		LEFT JOIN ods.SAP_GRUPOARTICULO ga WITH (NOLOCK) on sp.CodigoGrupoArticuloSAP = ga.Codigo
		LEFT JOIN dbo.FiltroBuscadorGrupoArticulo fbga WITH (NOLOCK) on ga.Codigo = fbga.CodigoGrupoArticulo
		LEFT JOIN dbo.FiltroBuscador fb WITH (NOLOCK) on fbga.CodigoFiltroBuscador = fb.Codigo
		LEFT JOIN EstrategiaProductoTemporalMongoApp EPTM WITH (NOLOCK) on
        	PCT.AnoCampania = EPTM.Campania AND PCT.CodigoProducto = EPTM.CodigoSap
END

GO



GO
USE BelcorpGuatemala
GO

GO
ALTER PROCEDURE [dbo].[usp_SBMicroservicios_Componente]
AS
BEGIN
	SET NOCOUNT ON;

	WITH cte_ProductoComercial(CAMPANIAID,CUV,CUV2,CODIGO_ESTRATEGIA,GRUPO,CODIGO_SAP)
	AS
	(
		SELECT
		PMO.AnoCampania AS CAMPANIAID
		,PMO.CUV AS CUV
		,PM.CUV AS CUV2
		,PM.EstrategiaIDSicc AS CODIGO_ESTRATEGIA
		,ISNULL(PMO.NUMEROGRUPO,0) AS GRUPO
		,PMO.CodigoProducto AS CODIGO_SAP
		FROM ods.ProductoComercial PM WITH (NOLOCK)
			INNER JOIN ods.ProductoComercial PMO
			ON PM.EstrategiaIDSicc = PMO.EstrategiaIDSicc
			AND PM.AnoCampania =PMO.AnoCampania
			AND PM.CodigoOferta = PMO.CodigoOferta
		GROUP BY
		PMO.AnoCampania
		,PMO.CUV
		,PM.CUV
		,PM.EstrategiaIDSicc
		,PMO.NUMEROGRUPO
		,PMO.CodigoProducto
	)
	SELECT
		 EPT.CUV2 AS CuvPadre
		,EPT.CAMPANIAID AS CampaniaId
		,EPT.CUV AS CUV
		,EPT.CODIGO_ESTRATEGIA AS CodigoEstrategia
		,EPT.Grupo
		,EPT.CODIGO_SAP AS CodigoSap
		,ISNULL(PCT.FactorRepeticion,1) AS Cantidad
		,PCT.PrecioUnitario AS PrecioUnitario
		,PCT.PrecioValorizado AS PrecioValorizado
		,PCT.NumeroLineaOferta AS Orden
		,PCT.IndicadorDigitable AS Digitable
		,CAST(ISNULL(PCT.CodigoFactorCuadre,1) AS INT) AS FactorCuadre
		,PCT.DESCRIPCION AS NombreProducto
		,PCT.MarcaID AS IdMarca
		,M.Descripcion AS NombreMarca
		,fb.Nombre
		,ga.DescripcionCorta
		,sl.DescripcionLarga
		,EPTM.NombreComercial AS NombreComercial
		,EPTM.Descripcion
		,EPTM.Volumen
		,EPTM.Imagen
		,EPTM.ImagenBulk
		,EPTM.NombreBulk
		,EPTM.CampaniaApp as CampaniaApp
		FROM cte_ProductoComercial EPT
		INNER JOIN  ods.ProductoComercial PCT ON EPT.CAMPANIAID = PCT.AnoCampania
			AND EPT.CUV = PCT.CUV
			AND EPT.CODIGO_ESTRATEGIA = PCT.EstrategiaIDSicc
		INNER JOIN dbo.Marca M ON M.MarcaID = PCT.MarcaID
		LEFT JOIN ods.SAP_PRODUCTO sp WITH (NOLOCK) ON PCT.CodigoProducto = sp.CodigoSap
		LEFT JOIN ods.SAP_LINEA sl WITH (NOLOCK) on sp.CodigoLinea = sl.Codigo
		LEFT JOIN ods.SAP_GRUPOARTICULO ga WITH (NOLOCK) on sp.CodigoGrupoArticuloSAP = ga.Codigo
		LEFT JOIN dbo.FiltroBuscadorGrupoArticulo fbga WITH (NOLOCK) on ga.Codigo = fbga.CodigoGrupoArticulo
		LEFT JOIN dbo.FiltroBuscador fb WITH (NOLOCK) on fbga.CodigoFiltroBuscador = fb.Codigo
		LEFT JOIN EstrategiaProductoTemporalMongoApp EPTM WITH (NOLOCK) on
        	PCT.AnoCampania = EPTM.Campania AND PCT.CodigoProducto = EPTM.CodigoSap
END

GO



GO
USE BelcorpEcuador
GO

GO
ALTER PROCEDURE [dbo].[usp_SBMicroservicios_Componente]
AS
BEGIN
	SET NOCOUNT ON;

	WITH cte_ProductoComercial(CAMPANIAID,CUV,CUV2,CODIGO_ESTRATEGIA,GRUPO,CODIGO_SAP)
	AS
	(
		SELECT
		PMO.AnoCampania AS CAMPANIAID
		,PMO.CUV AS CUV
		,PM.CUV AS CUV2
		,PM.EstrategiaIDSicc AS CODIGO_ESTRATEGIA
		,ISNULL(PMO.NUMEROGRUPO,0) AS GRUPO
		,PMO.CodigoProducto AS CODIGO_SAP
		FROM ods.ProductoComercial PM WITH (NOLOCK)
			INNER JOIN ods.ProductoComercial PMO
			ON PM.EstrategiaIDSicc = PMO.EstrategiaIDSicc
			AND PM.AnoCampania =PMO.AnoCampania
			AND PM.CodigoOferta = PMO.CodigoOferta
		GROUP BY
		PMO.AnoCampania
		,PMO.CUV
		,PM.CUV
		,PM.EstrategiaIDSicc
		,PMO.NUMEROGRUPO
		,PMO.CodigoProducto
	)
	SELECT
		 EPT.CUV2 AS CuvPadre
		,EPT.CAMPANIAID AS CampaniaId
		,EPT.CUV AS CUV
		,EPT.CODIGO_ESTRATEGIA AS CodigoEstrategia
		,EPT.Grupo
		,EPT.CODIGO_SAP AS CodigoSap
		,ISNULL(PCT.FactorRepeticion,1) AS Cantidad
		,PCT.PrecioUnitario AS PrecioUnitario
		,PCT.PrecioValorizado AS PrecioValorizado
		,PCT.NumeroLineaOferta AS Orden
		,PCT.IndicadorDigitable AS Digitable
		,CAST(ISNULL(PCT.CodigoFactorCuadre,1) AS INT) AS FactorCuadre
		,PCT.DESCRIPCION AS NombreProducto
		,PCT.MarcaID AS IdMarca
		,M.Descripcion AS NombreMarca
		,fb.Nombre
		,ga.DescripcionCorta
		,sl.DescripcionLarga
		,EPTM.NombreComercial AS NombreComercial
		,EPTM.Descripcion
		,EPTM.Volumen
		,EPTM.Imagen
		,EPTM.ImagenBulk
		,EPTM.NombreBulk
		,EPTM.CampaniaApp as CampaniaApp
		FROM cte_ProductoComercial EPT
		INNER JOIN  ods.ProductoComercial PCT ON EPT.CAMPANIAID = PCT.AnoCampania
			AND EPT.CUV = PCT.CUV
			AND EPT.CODIGO_ESTRATEGIA = PCT.EstrategiaIDSicc
		INNER JOIN dbo.Marca M ON M.MarcaID = PCT.MarcaID
		LEFT JOIN ods.SAP_PRODUCTO sp WITH (NOLOCK) ON PCT.CodigoProducto = sp.CodigoSap
		LEFT JOIN ods.SAP_LINEA sl WITH (NOLOCK) on sp.CodigoLinea = sl.Codigo
		LEFT JOIN ods.SAP_GRUPOARTICULO ga WITH (NOLOCK) on sp.CodigoGrupoArticuloSAP = ga.Codigo
		LEFT JOIN dbo.FiltroBuscadorGrupoArticulo fbga WITH (NOLOCK) on ga.Codigo = fbga.CodigoGrupoArticulo
		LEFT JOIN dbo.FiltroBuscador fb WITH (NOLOCK) on fbga.CodigoFiltroBuscador = fb.Codigo
		LEFT JOIN EstrategiaProductoTemporalMongoApp EPTM WITH (NOLOCK) on
        	PCT.AnoCampania = EPTM.Campania AND PCT.CodigoProducto = EPTM.CodigoSap
END

GO



GO
USE BelcorpDominicana
GO

GO
ALTER PROCEDURE [dbo].[usp_SBMicroservicios_Componente]
AS
BEGIN
	SET NOCOUNT ON;

	WITH cte_ProductoComercial(CAMPANIAID,CUV,CUV2,CODIGO_ESTRATEGIA,GRUPO,CODIGO_SAP)
	AS
	(
		SELECT
		PMO.AnoCampania AS CAMPANIAID
		,PMO.CUV AS CUV
		,PM.CUV AS CUV2
		,PM.EstrategiaIDSicc AS CODIGO_ESTRATEGIA
		,ISNULL(PMO.NUMEROGRUPO,0) AS GRUPO
		,PMO.CodigoProducto AS CODIGO_SAP
		FROM ods.ProductoComercial PM WITH (NOLOCK)
			INNER JOIN ods.ProductoComercial PMO
			ON PM.EstrategiaIDSicc = PMO.EstrategiaIDSicc
			AND PM.AnoCampania =PMO.AnoCampania
			AND PM.CodigoOferta = PMO.CodigoOferta
		GROUP BY
		PMO.AnoCampania
		,PMO.CUV
		,PM.CUV
		,PM.EstrategiaIDSicc
		,PMO.NUMEROGRUPO
		,PMO.CodigoProducto
	)
	SELECT
		 EPT.CUV2 AS CuvPadre
		,EPT.CAMPANIAID AS CampaniaId
		,EPT.CUV AS CUV
		,EPT.CODIGO_ESTRATEGIA AS CodigoEstrategia
		,EPT.Grupo
		,EPT.CODIGO_SAP AS CodigoSap
		,ISNULL(PCT.FactorRepeticion,1) AS Cantidad
		,PCT.PrecioUnitario AS PrecioUnitario
		,PCT.PrecioValorizado AS PrecioValorizado
		,PCT.NumeroLineaOferta AS Orden
		,PCT.IndicadorDigitable AS Digitable
		,CAST(ISNULL(PCT.CodigoFactorCuadre,1) AS INT) AS FactorCuadre
		,PCT.DESCRIPCION AS NombreProducto
		,PCT.MarcaID AS IdMarca
		,M.Descripcion AS NombreMarca
		,fb.Nombre
		,ga.DescripcionCorta
		,sl.DescripcionLarga
		,EPTM.NombreComercial AS NombreComercial
		,EPTM.Descripcion
		,EPTM.Volumen
		,EPTM.Imagen
		,EPTM.ImagenBulk
		,EPTM.NombreBulk
		,EPTM.CampaniaApp as CampaniaApp
		FROM cte_ProductoComercial EPT
		INNER JOIN  ods.ProductoComercial PCT ON EPT.CAMPANIAID = PCT.AnoCampania
			AND EPT.CUV = PCT.CUV
			AND EPT.CODIGO_ESTRATEGIA = PCT.EstrategiaIDSicc
		INNER JOIN dbo.Marca M ON M.MarcaID = PCT.MarcaID
		LEFT JOIN ods.SAP_PRODUCTO sp WITH (NOLOCK) ON PCT.CodigoProducto = sp.CodigoSap
		LEFT JOIN ods.SAP_LINEA sl WITH (NOLOCK) on sp.CodigoLinea = sl.Codigo
		LEFT JOIN ods.SAP_GRUPOARTICULO ga WITH (NOLOCK) on sp.CodigoGrupoArticuloSAP = ga.Codigo
		LEFT JOIN dbo.FiltroBuscadorGrupoArticulo fbga WITH (NOLOCK) on ga.Codigo = fbga.CodigoGrupoArticulo
		LEFT JOIN dbo.FiltroBuscador fb WITH (NOLOCK) on fbga.CodigoFiltroBuscador = fb.Codigo
		LEFT JOIN EstrategiaProductoTemporalMongoApp EPTM WITH (NOLOCK) on
        	PCT.AnoCampania = EPTM.Campania AND PCT.CodigoProducto = EPTM.CodigoSap
END

GO



GO
USE BelcorpCostaRica
GO

GO
ALTER PROCEDURE [dbo].[usp_SBMicroservicios_Componente]
AS
BEGIN
	SET NOCOUNT ON;

	WITH cte_ProductoComercial(CAMPANIAID,CUV,CUV2,CODIGO_ESTRATEGIA,GRUPO,CODIGO_SAP)
	AS
	(
		SELECT
		PMO.AnoCampania AS CAMPANIAID
		,PMO.CUV AS CUV
		,PM.CUV AS CUV2
		,PM.EstrategiaIDSicc AS CODIGO_ESTRATEGIA
		,ISNULL(PMO.NUMEROGRUPO,0) AS GRUPO
		,PMO.CodigoProducto AS CODIGO_SAP
		FROM ods.ProductoComercial PM WITH (NOLOCK)
			INNER JOIN ods.ProductoComercial PMO
			ON PM.EstrategiaIDSicc = PMO.EstrategiaIDSicc
			AND PM.AnoCampania =PMO.AnoCampania
			AND PM.CodigoOferta = PMO.CodigoOferta
		GROUP BY
		PMO.AnoCampania
		,PMO.CUV
		,PM.CUV
		,PM.EstrategiaIDSicc
		,PMO.NUMEROGRUPO
		,PMO.CodigoProducto
	)
	SELECT
		 EPT.CUV2 AS CuvPadre
		,EPT.CAMPANIAID AS CampaniaId
		,EPT.CUV AS CUV
		,EPT.CODIGO_ESTRATEGIA AS CodigoEstrategia
		,EPT.Grupo
		,EPT.CODIGO_SAP AS CodigoSap
		,ISNULL(PCT.FactorRepeticion,1) AS Cantidad
		,PCT.PrecioUnitario AS PrecioUnitario
		,PCT.PrecioValorizado AS PrecioValorizado
		,PCT.NumeroLineaOferta AS Orden
		,PCT.IndicadorDigitable AS Digitable
		,CAST(ISNULL(PCT.CodigoFactorCuadre,1) AS INT) AS FactorCuadre
		,PCT.DESCRIPCION AS NombreProducto
		,PCT.MarcaID AS IdMarca
		,M.Descripcion AS NombreMarca
		,fb.Nombre
		,ga.DescripcionCorta
		,sl.DescripcionLarga
		,EPTM.NombreComercial AS NombreComercial
		,EPTM.Descripcion
		,EPTM.Volumen
		,EPTM.Imagen
		,EPTM.ImagenBulk
		,EPTM.NombreBulk
		,EPTM.CampaniaApp as CampaniaApp
		FROM cte_ProductoComercial EPT
		INNER JOIN  ods.ProductoComercial PCT ON EPT.CAMPANIAID = PCT.AnoCampania
			AND EPT.CUV = PCT.CUV
			AND EPT.CODIGO_ESTRATEGIA = PCT.EstrategiaIDSicc
		INNER JOIN dbo.Marca M ON M.MarcaID = PCT.MarcaID
		LEFT JOIN ods.SAP_PRODUCTO sp WITH (NOLOCK) ON PCT.CodigoProducto = sp.CodigoSap
		LEFT JOIN ods.SAP_LINEA sl WITH (NOLOCK) on sp.CodigoLinea = sl.Codigo
		LEFT JOIN ods.SAP_GRUPOARTICULO ga WITH (NOLOCK) on sp.CodigoGrupoArticuloSAP = ga.Codigo
		LEFT JOIN dbo.FiltroBuscadorGrupoArticulo fbga WITH (NOLOCK) on ga.Codigo = fbga.CodigoGrupoArticulo
		LEFT JOIN dbo.FiltroBuscador fb WITH (NOLOCK) on fbga.CodigoFiltroBuscador = fb.Codigo
		LEFT JOIN EstrategiaProductoTemporalMongoApp EPTM WITH (NOLOCK) on
        	PCT.AnoCampania = EPTM.Campania AND PCT.CodigoProducto = EPTM.CodigoSap
END

GO



GO
USE BelcorpChile
GO

GO
ALTER PROCEDURE [dbo].[usp_SBMicroservicios_Componente]
AS
BEGIN
	SET NOCOUNT ON;

	WITH cte_ProductoComercial(CAMPANIAID,CUV,CUV2,CODIGO_ESTRATEGIA,GRUPO,CODIGO_SAP)
	AS
	(
		SELECT
		PMO.AnoCampania AS CAMPANIAID
		,PMO.CUV AS CUV
		,PM.CUV AS CUV2
		,PM.EstrategiaIDSicc AS CODIGO_ESTRATEGIA
		,ISNULL(PMO.NUMEROGRUPO,0) AS GRUPO
		,PMO.CodigoProducto AS CODIGO_SAP
		FROM ods.ProductoComercial PM WITH (NOLOCK)
			INNER JOIN ods.ProductoComercial PMO
			ON PM.EstrategiaIDSicc = PMO.EstrategiaIDSicc
			AND PM.AnoCampania =PMO.AnoCampania
			AND PM.CodigoOferta = PMO.CodigoOferta
		GROUP BY
		PMO.AnoCampania
		,PMO.CUV
		,PM.CUV
		,PM.EstrategiaIDSicc
		,PMO.NUMEROGRUPO
		,PMO.CodigoProducto
	)
	SELECT
		 EPT.CUV2 AS CuvPadre
		,EPT.CAMPANIAID AS CampaniaId
		,EPT.CUV AS CUV
		,EPT.CODIGO_ESTRATEGIA AS CodigoEstrategia
		,EPT.Grupo
		,EPT.CODIGO_SAP AS CodigoSap
		,ISNULL(PCT.FactorRepeticion,1) AS Cantidad
		,PCT.PrecioUnitario AS PrecioUnitario
		,PCT.PrecioValorizado AS PrecioValorizado
		,PCT.NumeroLineaOferta AS Orden
		,PCT.IndicadorDigitable AS Digitable
		,CAST(ISNULL(PCT.CodigoFactorCuadre,1) AS INT) AS FactorCuadre
		,PCT.DESCRIPCION AS NombreProducto
		,PCT.MarcaID AS IdMarca
		,M.Descripcion AS NombreMarca
		,fb.Nombre
		,ga.DescripcionCorta
		,sl.DescripcionLarga
		,EPTM.NombreComercial AS NombreComercial
		,EPTM.Descripcion
		,EPTM.Volumen
		,EPTM.Imagen
		,EPTM.ImagenBulk
		,EPTM.NombreBulk
		,EPTM.CampaniaApp as CampaniaApp
		FROM cte_ProductoComercial EPT
		INNER JOIN  ods.ProductoComercial PCT ON EPT.CAMPANIAID = PCT.AnoCampania
			AND EPT.CUV = PCT.CUV
			AND EPT.CODIGO_ESTRATEGIA = PCT.EstrategiaIDSicc
		INNER JOIN dbo.Marca M ON M.MarcaID = PCT.MarcaID
		LEFT JOIN ods.SAP_PRODUCTO sp WITH (NOLOCK) ON PCT.CodigoProducto = sp.CodigoSap
		LEFT JOIN ods.SAP_LINEA sl WITH (NOLOCK) on sp.CodigoLinea = sl.Codigo
		LEFT JOIN ods.SAP_GRUPOARTICULO ga WITH (NOLOCK) on sp.CodigoGrupoArticuloSAP = ga.Codigo
		LEFT JOIN dbo.FiltroBuscadorGrupoArticulo fbga WITH (NOLOCK) on ga.Codigo = fbga.CodigoGrupoArticulo
		LEFT JOIN dbo.FiltroBuscador fb WITH (NOLOCK) on fbga.CodigoFiltroBuscador = fb.Codigo
		LEFT JOIN EstrategiaProductoTemporalMongoApp EPTM WITH (NOLOCK) on
        	PCT.AnoCampania = EPTM.Campania AND PCT.CodigoProducto = EPTM.CodigoSap
END

GO



GO
USE BelcorpBolivia
GO

GO
ALTER PROCEDURE [dbo].[usp_SBMicroservicios_Componente]
AS
BEGIN
	SET NOCOUNT ON;

	WITH cte_ProductoComercial(CAMPANIAID,CUV,CUV2,CODIGO_ESTRATEGIA,GRUPO,CODIGO_SAP)
	AS
	(
		SELECT
		PMO.AnoCampania AS CAMPANIAID
		,PMO.CUV AS CUV
		,PM.CUV AS CUV2
		,PM.EstrategiaIDSicc AS CODIGO_ESTRATEGIA
		,ISNULL(PMO.NUMEROGRUPO,0) AS GRUPO
		,PMO.CodigoProducto AS CODIGO_SAP
		FROM ods.ProductoComercial PM WITH (NOLOCK)
			INNER JOIN ods.ProductoComercial PMO
			ON PM.EstrategiaIDSicc = PMO.EstrategiaIDSicc
			AND PM.AnoCampania =PMO.AnoCampania
			AND PM.CodigoOferta = PMO.CodigoOferta
		GROUP BY
		PMO.AnoCampania
		,PMO.CUV
		,PM.CUV
		,PM.EstrategiaIDSicc
		,PMO.NUMEROGRUPO
		,PMO.CodigoProducto
	)
	SELECT
		 EPT.CUV2 AS CuvPadre
		,EPT.CAMPANIAID AS CampaniaId
		,EPT.CUV AS CUV
		,EPT.CODIGO_ESTRATEGIA AS CodigoEstrategia
		,EPT.Grupo
		,EPT.CODIGO_SAP AS CodigoSap
		,ISNULL(PCT.FactorRepeticion,1) AS Cantidad
		,PCT.PrecioUnitario AS PrecioUnitario
		,PCT.PrecioValorizado AS PrecioValorizado
		,PCT.NumeroLineaOferta AS Orden
		,PCT.IndicadorDigitable AS Digitable
		,CAST(ISNULL(PCT.CodigoFactorCuadre,1) AS INT) AS FactorCuadre
		,PCT.DESCRIPCION AS NombreProducto
		,PCT.MarcaID AS IdMarca
		,M.Descripcion AS NombreMarca
		,fb.Nombre
		,ga.DescripcionCorta
		,sl.DescripcionLarga
		,EPTM.NombreComercial AS NombreComercial
		,EPTM.Descripcion
		,EPTM.Volumen
		,EPTM.Imagen
		,EPTM.ImagenBulk
		,EPTM.NombreBulk
		,EPTM.CampaniaApp as CampaniaApp
		FROM cte_ProductoComercial EPT
		INNER JOIN  ods.ProductoComercial PCT ON EPT.CAMPANIAID = PCT.AnoCampania
			AND EPT.CUV = PCT.CUV
			AND EPT.CODIGO_ESTRATEGIA = PCT.EstrategiaIDSicc
		INNER JOIN dbo.Marca M ON M.MarcaID = PCT.MarcaID
		LEFT JOIN ods.SAP_PRODUCTO sp WITH (NOLOCK) ON PCT.CodigoProducto = sp.CodigoSap
		LEFT JOIN ods.SAP_LINEA sl WITH (NOLOCK) on sp.CodigoLinea = sl.Codigo
		LEFT JOIN ods.SAP_GRUPOARTICULO ga WITH (NOLOCK) on sp.CodigoGrupoArticuloSAP = ga.Codigo
		LEFT JOIN dbo.FiltroBuscadorGrupoArticulo fbga WITH (NOLOCK) on ga.Codigo = fbga.CodigoGrupoArticulo
		LEFT JOIN dbo.FiltroBuscador fb WITH (NOLOCK) on fbga.CodigoFiltroBuscador = fb.Codigo
		LEFT JOIN EstrategiaProductoTemporalMongoApp EPTM WITH (NOLOCK) on
        	PCT.AnoCampania = EPTM.Campania AND PCT.CodigoProducto = EPTM.CodigoSap
END

GO



GO
