GO
USE BelcorpPeru
GO
go


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
END
go

GO
USE BelcorpMexico
GO
go


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
END
go

GO
USE BelcorpColombia
GO
go


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
END
go

GO
USE BelcorpSalvador
GO
go


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
END
go

GO
USE BelcorpPuertoRico
GO
go


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
END
go

GO
USE BelcorpPanama
GO
go


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
END
go

GO
USE BelcorpGuatemala
GO
go


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
END
go

GO
USE BelcorpEcuador
GO
go


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
END
go

GO
USE BelcorpDominicana
GO
go


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
END
go

GO
USE BelcorpCostaRica
GO
go


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
END
go

GO
USE BelcorpChile
GO
go


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
END
go

GO
USE BelcorpBolivia
GO
go


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
END
go

GO
