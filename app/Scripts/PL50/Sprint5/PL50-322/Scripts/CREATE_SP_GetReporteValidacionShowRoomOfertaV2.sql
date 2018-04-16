USE BelcorpBolivia
GO
 IF OBJECT_ID('dbo.GetReporteValidacionShowRoomOfertaV2', 'P') IS NOT NULL
	DROP PROC dbo.GetReporteValidacionShowRoomOfertaV2
GO
CREATE PROCEDURE dbo.GetReporteValidacionShowRoomOfertaV2
 @campania INT  
AS
SELECT Pais AS 'Pais',
	CampaniaID AS 'Campania',
	codigotipooferta AS 'CodigoTO',
	codigoproducto AS 'SAP',
	CUV2 AS 'CUV',
	DescripcionCUV2 AS 'Descripcion',
	Precio AS 'PrecioValorizado',
	Precio2 AS 'PrecioOferta',
	LimiteVenta AS 'UnidadesPermitidas',
	EsSubcampania AS 'EsSubCampania',
	Activo AS 'HabilitarOferta',
	FlagImagenCargada AS 'FlagImagenCargada',
	FlagImagenMINI AS 'FlagImagenMini'
 FROM (SELECT
	'Pais'='BO',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpBolivia.dbo.Estrategia e LEFT JOIN ODS_BO.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpBolivia.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='CL',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpChile.dbo.Estrategia e LEFT JOIN ODS_CL.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpChile.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='CO',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpColombia.dbo.Estrategia e LEFT JOIN ODS_CO.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpColombia.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='CR',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpCostaRica.dbo.Estrategia e LEFT JOIN ODS_CR.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpCostaRica.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='DO',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpDominicana.dbo.Estrategia e LEFT JOIN ODS_DO.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpDominicana.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='EC',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpEcuador.dbo.Estrategia e LEFT JOIN ODS_EC.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpEcuador.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='GT',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpGuatemala.dbo.Estrategia e LEFT JOIN ODS_GT.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpGuatemala.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='MX',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpMexico.dbo.Estrategia e LEFT JOIN ODS_MX.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpMexico.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='PA',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpPanama.dbo.Estrategia e LEFT JOIN ODS_PA.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpPanama.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='PE',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpPeru.dbo.Estrategia e LEFT JOIN ODS_PE.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpPeru.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='PR',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpPuertoRico.dbo.Estrategia e LEFT JOIN ODS_PR.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpPuertoRico.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='SV',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpSalvador.dbo.Estrategia e LEFT JOIN ODS_SV.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpSalvador.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='VE',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpVenezuela.dbo.Estrategia e LEFT JOIN ODS_VE.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpVenezuela.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania) AS T
ORDER BY 1,6
GO
USE BelcorpChile
GO
 IF OBJECT_ID('dbo.GetReporteValidacionShowRoomOfertaV2', 'P') IS NOT NULL
	DROP PROC dbo.GetReporteValidacionShowRoomOfertaV2
GO
CREATE PROCEDURE dbo.GetReporteValidacionShowRoomOfertaV2
 @campania INT  
AS
SELECT Pais AS 'Pais',
	CampaniaID AS 'Campania',
	codigotipooferta AS 'CodigoTO',
	codigoproducto AS 'SAP',
	CUV2 AS 'CUV',
	DescripcionCUV2 AS 'Descripcion',
	Precio AS 'PrecioValorizado',
	Precio2 AS 'PrecioOferta',
	LimiteVenta AS 'UnidadesPermitidas',
	EsSubcampania AS 'EsSubCampania',
	Activo AS 'HabilitarOferta',
	FlagImagenCargada AS 'FlagImagenCargada',
	FlagImagenMINI AS 'FlagImagenMini'
 FROM (SELECT
	'Pais'='BO',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpBolivia.dbo.Estrategia e LEFT JOIN ODS_BO.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpBolivia.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='CL',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpChile.dbo.Estrategia e LEFT JOIN ODS_CL.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpChile.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='CO',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpColombia.dbo.Estrategia e LEFT JOIN ODS_CO.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpColombia.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='CR',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpCostaRica.dbo.Estrategia e LEFT JOIN ODS_CR.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpCostaRica.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='DO',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpDominicana.dbo.Estrategia e LEFT JOIN ODS_DO.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpDominicana.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='EC',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpEcuador.dbo.Estrategia e LEFT JOIN ODS_EC.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpEcuador.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='GT',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpGuatemala.dbo.Estrategia e LEFT JOIN ODS_GT.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpGuatemala.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='MX',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpMexico.dbo.Estrategia e LEFT JOIN ODS_MX.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpMexico.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='PA',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpPanama.dbo.Estrategia e LEFT JOIN ODS_PA.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpPanama.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='PE',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpPeru.dbo.Estrategia e LEFT JOIN ODS_PE.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpPeru.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='PR',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpPuertoRico.dbo.Estrategia e LEFT JOIN ODS_PR.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpPuertoRico.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='SV',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpSalvador.dbo.Estrategia e LEFT JOIN ODS_SV.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpSalvador.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='VE',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpVenezuela.dbo.Estrategia e LEFT JOIN ODS_VE.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpVenezuela.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania) AS T
ORDER BY 1,6
GO
USE BelcorpColombia
GO
 IF OBJECT_ID('dbo.GetReporteValidacionShowRoomOfertaV2', 'P') IS NOT NULL
	DROP PROC dbo.GetReporteValidacionShowRoomOfertaV2
GO
CREATE PROCEDURE dbo.GetReporteValidacionShowRoomOfertaV2
 @campania INT  
AS
SELECT Pais AS 'Pais',
	CampaniaID AS 'Campania',
	codigotipooferta AS 'CodigoTO',
	codigoproducto AS 'SAP',
	CUV2 AS 'CUV',
	DescripcionCUV2 AS 'Descripcion',
	Precio AS 'PrecioValorizado',
	Precio2 AS 'PrecioOferta',
	LimiteVenta AS 'UnidadesPermitidas',
	EsSubcampania AS 'EsSubCampania',
	Activo AS 'HabilitarOferta',
	FlagImagenCargada AS 'FlagImagenCargada',
	FlagImagenMINI AS 'FlagImagenMini'
 FROM (SELECT
	'Pais'='BO',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpBolivia.dbo.Estrategia e LEFT JOIN ODS_BO.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpBolivia.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='CL',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpChile.dbo.Estrategia e LEFT JOIN ODS_CL.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpChile.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='CO',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpColombia.dbo.Estrategia e LEFT JOIN ODS_CO.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpColombia.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='CR',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpCostaRica.dbo.Estrategia e LEFT JOIN ODS_CR.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpCostaRica.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='DO',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpDominicana.dbo.Estrategia e LEFT JOIN ODS_DO.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpDominicana.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='EC',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpEcuador.dbo.Estrategia e LEFT JOIN ODS_EC.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpEcuador.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='GT',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpGuatemala.dbo.Estrategia e LEFT JOIN ODS_GT.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpGuatemala.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='MX',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpMexico.dbo.Estrategia e LEFT JOIN ODS_MX.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpMexico.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='PA',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpPanama.dbo.Estrategia e LEFT JOIN ODS_PA.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpPanama.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='PE',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpPeru.dbo.Estrategia e LEFT JOIN ODS_PE.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpPeru.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='PR',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpPuertoRico.dbo.Estrategia e LEFT JOIN ODS_PR.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpPuertoRico.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='SV',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpSalvador.dbo.Estrategia e LEFT JOIN ODS_SV.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpSalvador.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='VE',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpVenezuela.dbo.Estrategia e LEFT JOIN ODS_VE.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpVenezuela.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania) AS T
ORDER BY 1,6
GO
USE BelcorpCostaRica
GO
 IF OBJECT_ID('dbo.GetReporteValidacionShowRoomOfertaV2', 'P') IS NOT NULL
	DROP PROC dbo.GetReporteValidacionShowRoomOfertaV2
GO
CREATE PROCEDURE dbo.GetReporteValidacionShowRoomOfertaV2
 @campania INT  
AS
SELECT Pais AS 'Pais',
	CampaniaID AS 'Campania',
	codigotipooferta AS 'CodigoTO',
	codigoproducto AS 'SAP',
	CUV2 AS 'CUV',
	DescripcionCUV2 AS 'Descripcion',
	Precio AS 'PrecioValorizado',
	Precio2 AS 'PrecioOferta',
	LimiteVenta AS 'UnidadesPermitidas',
	EsSubcampania AS 'EsSubCampania',
	Activo AS 'HabilitarOferta',
	FlagImagenCargada AS 'FlagImagenCargada',
	FlagImagenMINI AS 'FlagImagenMini'
 FROM (SELECT
	'Pais'='BO',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpBolivia.dbo.Estrategia e LEFT JOIN ODS_BO.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpBolivia.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='CL',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpChile.dbo.Estrategia e LEFT JOIN ODS_CL.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpChile.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='CO',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpColombia.dbo.Estrategia e LEFT JOIN ODS_CO.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpColombia.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='CR',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpCostaRica.dbo.Estrategia e LEFT JOIN ODS_CR.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpCostaRica.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='DO',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpDominicana.dbo.Estrategia e LEFT JOIN ODS_DO.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpDominicana.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='EC',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpEcuador.dbo.Estrategia e LEFT JOIN ODS_EC.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpEcuador.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='GT',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpGuatemala.dbo.Estrategia e LEFT JOIN ODS_GT.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpGuatemala.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='MX',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpMexico.dbo.Estrategia e LEFT JOIN ODS_MX.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpMexico.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='PA',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpPanama.dbo.Estrategia e LEFT JOIN ODS_PA.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpPanama.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='PE',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpPeru.dbo.Estrategia e LEFT JOIN ODS_PE.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpPeru.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='PR',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpPuertoRico.dbo.Estrategia e LEFT JOIN ODS_PR.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpPuertoRico.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='SV',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpSalvador.dbo.Estrategia e LEFT JOIN ODS_SV.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpSalvador.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='VE',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpVenezuela.dbo.Estrategia e LEFT JOIN ODS_VE.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpVenezuela.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania) AS T
ORDER BY 1,6
GO
USE BelcorpDominicana
GO
 IF OBJECT_ID('dbo.GetReporteValidacionShowRoomOfertaV2', 'P') IS NOT NULL
	DROP PROC dbo.GetReporteValidacionShowRoomOfertaV2
GO
CREATE PROCEDURE dbo.GetReporteValidacionShowRoomOfertaV2
 @campania INT  
AS
SELECT Pais AS 'Pais',
	CampaniaID AS 'Campania',
	codigotipooferta AS 'CodigoTO',
	codigoproducto AS 'SAP',
	CUV2 AS 'CUV',
	DescripcionCUV2 AS 'Descripcion',
	Precio AS 'PrecioValorizado',
	Precio2 AS 'PrecioOferta',
	LimiteVenta AS 'UnidadesPermitidas',
	EsSubcampania AS 'EsSubCampania',
	Activo AS 'HabilitarOferta',
	FlagImagenCargada AS 'FlagImagenCargada',
	FlagImagenMINI AS 'FlagImagenMini'
 FROM (SELECT
	'Pais'='BO',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpBolivia.dbo.Estrategia e LEFT JOIN ODS_BO.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpBolivia.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='CL',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpChile.dbo.Estrategia e LEFT JOIN ODS_CL.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpChile.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='CO',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpColombia.dbo.Estrategia e LEFT JOIN ODS_CO.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpColombia.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='CR',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpCostaRica.dbo.Estrategia e LEFT JOIN ODS_CR.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpCostaRica.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='DO',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpDominicana.dbo.Estrategia e LEFT JOIN ODS_DO.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpDominicana.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='EC',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpEcuador.dbo.Estrategia e LEFT JOIN ODS_EC.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpEcuador.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='GT',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpGuatemala.dbo.Estrategia e LEFT JOIN ODS_GT.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpGuatemala.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='MX',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpMexico.dbo.Estrategia e LEFT JOIN ODS_MX.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpMexico.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='PA',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpPanama.dbo.Estrategia e LEFT JOIN ODS_PA.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpPanama.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='PE',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpPeru.dbo.Estrategia e LEFT JOIN ODS_PE.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpPeru.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='PR',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpPuertoRico.dbo.Estrategia e LEFT JOIN ODS_PR.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpPuertoRico.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='SV',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpSalvador.dbo.Estrategia e LEFT JOIN ODS_SV.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpSalvador.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='VE',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpVenezuela.dbo.Estrategia e LEFT JOIN ODS_VE.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpVenezuela.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania) AS T
ORDER BY 1,6
GO
USE BelcorpEcuador
GO
 IF OBJECT_ID('dbo.GetReporteValidacionShowRoomOfertaV2', 'P') IS NOT NULL
	DROP PROC dbo.GetReporteValidacionShowRoomOfertaV2
GO
CREATE PROCEDURE dbo.GetReporteValidacionShowRoomOfertaV2
 @campania INT  
AS
SELECT Pais AS 'Pais',
	CampaniaID AS 'Campania',
	codigotipooferta AS 'CodigoTO',
	codigoproducto AS 'SAP',
	CUV2 AS 'CUV',
	DescripcionCUV2 AS 'Descripcion',
	Precio AS 'PrecioValorizado',
	Precio2 AS 'PrecioOferta',
	LimiteVenta AS 'UnidadesPermitidas',
	EsSubcampania AS 'EsSubCampania',
	Activo AS 'HabilitarOferta',
	FlagImagenCargada AS 'FlagImagenCargada',
	FlagImagenMINI AS 'FlagImagenMini'
 FROM (SELECT
	'Pais'='BO',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpBolivia.dbo.Estrategia e LEFT JOIN ODS_BO.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpBolivia.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='CL',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpChile.dbo.Estrategia e LEFT JOIN ODS_CL.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpChile.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='CO',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpColombia.dbo.Estrategia e LEFT JOIN ODS_CO.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpColombia.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='CR',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpCostaRica.dbo.Estrategia e LEFT JOIN ODS_CR.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpCostaRica.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='DO',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpDominicana.dbo.Estrategia e LEFT JOIN ODS_DO.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpDominicana.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='EC',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpEcuador.dbo.Estrategia e LEFT JOIN ODS_EC.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpEcuador.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='GT',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpGuatemala.dbo.Estrategia e LEFT JOIN ODS_GT.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpGuatemala.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='MX',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpMexico.dbo.Estrategia e LEFT JOIN ODS_MX.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpMexico.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='PA',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpPanama.dbo.Estrategia e LEFT JOIN ODS_PA.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpPanama.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='PE',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpPeru.dbo.Estrategia e LEFT JOIN ODS_PE.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpPeru.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='PR',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpPuertoRico.dbo.Estrategia e LEFT JOIN ODS_PR.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpPuertoRico.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='SV',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpSalvador.dbo.Estrategia e LEFT JOIN ODS_SV.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpSalvador.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='VE',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpVenezuela.dbo.Estrategia e LEFT JOIN ODS_VE.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpVenezuela.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania) AS T
ORDER BY 1,6
GO
USE BelcorpGuatemala
GO
 IF OBJECT_ID('dbo.GetReporteValidacionShowRoomOfertaV2', 'P') IS NOT NULL
	DROP PROC dbo.GetReporteValidacionShowRoomOfertaV2
GO
CREATE PROCEDURE dbo.GetReporteValidacionShowRoomOfertaV2
 @campania INT  
AS
SELECT Pais AS 'Pais',
	CampaniaID AS 'Campania',
	codigotipooferta AS 'CodigoTO',
	codigoproducto AS 'SAP',
	CUV2 AS 'CUV',
	DescripcionCUV2 AS 'Descripcion',
	Precio AS 'PrecioValorizado',
	Precio2 AS 'PrecioOferta',
	LimiteVenta AS 'UnidadesPermitidas',
	EsSubcampania AS 'EsSubCampania',
	Activo AS 'HabilitarOferta',
	FlagImagenCargada AS 'FlagImagenCargada',
	FlagImagenMINI AS 'FlagImagenMini'
 FROM (SELECT
	'Pais'='BO',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpBolivia.dbo.Estrategia e LEFT JOIN ODS_BO.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpBolivia.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='CL',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpChile.dbo.Estrategia e LEFT JOIN ODS_CL.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpChile.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='CO',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpColombia.dbo.Estrategia e LEFT JOIN ODS_CO.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpColombia.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='CR',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpCostaRica.dbo.Estrategia e LEFT JOIN ODS_CR.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpCostaRica.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='DO',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpDominicana.dbo.Estrategia e LEFT JOIN ODS_DO.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpDominicana.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='EC',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpEcuador.dbo.Estrategia e LEFT JOIN ODS_EC.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpEcuador.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='GT',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpGuatemala.dbo.Estrategia e LEFT JOIN ODS_GT.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpGuatemala.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='MX',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpMexico.dbo.Estrategia e LEFT JOIN ODS_MX.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpMexico.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='PA',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpPanama.dbo.Estrategia e LEFT JOIN ODS_PA.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpPanama.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='PE',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpPeru.dbo.Estrategia e LEFT JOIN ODS_PE.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpPeru.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='PR',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpPuertoRico.dbo.Estrategia e LEFT JOIN ODS_PR.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpPuertoRico.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='SV',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpSalvador.dbo.Estrategia e LEFT JOIN ODS_SV.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpSalvador.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='VE',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpVenezuela.dbo.Estrategia e LEFT JOIN ODS_VE.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpVenezuela.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania) AS T
ORDER BY 1,6
GO
USE BelcorpMexico
GO
 IF OBJECT_ID('dbo.GetReporteValidacionShowRoomOfertaV2', 'P') IS NOT NULL
	DROP PROC dbo.GetReporteValidacionShowRoomOfertaV2
GO
CREATE PROCEDURE dbo.GetReporteValidacionShowRoomOfertaV2
 @campania INT  
AS
SELECT Pais AS 'Pais',
	CampaniaID AS 'Campania',
	codigotipooferta AS 'CodigoTO',
	codigoproducto AS 'SAP',
	CUV2 AS 'CUV',
	DescripcionCUV2 AS 'Descripcion',
	Precio AS 'PrecioValorizado',
	Precio2 AS 'PrecioOferta',
	LimiteVenta AS 'UnidadesPermitidas',
	EsSubcampania AS 'EsSubCampania',
	Activo AS 'HabilitarOferta',
	FlagImagenCargada AS 'FlagImagenCargada',
	FlagImagenMINI AS 'FlagImagenMini'
 FROM (SELECT
	'Pais'='BO',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpBolivia.dbo.Estrategia e LEFT JOIN ODS_BO.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpBolivia.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='CL',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpChile.dbo.Estrategia e LEFT JOIN ODS_CL.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpChile.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='CO',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpColombia.dbo.Estrategia e LEFT JOIN ODS_CO.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpColombia.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='CR',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpCostaRica.dbo.Estrategia e LEFT JOIN ODS_CR.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpCostaRica.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='DO',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpDominicana.dbo.Estrategia e LEFT JOIN ODS_DO.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpDominicana.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='EC',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpEcuador.dbo.Estrategia e LEFT JOIN ODS_EC.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpEcuador.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='GT',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpGuatemala.dbo.Estrategia e LEFT JOIN ODS_GT.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpGuatemala.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='MX',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpMexico.dbo.Estrategia e LEFT JOIN ODS_MX.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpMexico.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='PA',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpPanama.dbo.Estrategia e LEFT JOIN ODS_PA.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpPanama.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='PE',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpPeru.dbo.Estrategia e LEFT JOIN ODS_PE.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpPeru.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='PR',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpPuertoRico.dbo.Estrategia e LEFT JOIN ODS_PR.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpPuertoRico.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='SV',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpSalvador.dbo.Estrategia e LEFT JOIN ODS_SV.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpSalvador.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='VE',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpVenezuela.dbo.Estrategia e LEFT JOIN ODS_VE.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpVenezuela.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania) AS T
ORDER BY 1,6
GO
USE BelcorpPanama
GO
 IF OBJECT_ID('dbo.GetReporteValidacionShowRoomOfertaV2', 'P') IS NOT NULL
	DROP PROC dbo.GetReporteValidacionShowRoomOfertaV2
GO
CREATE PROCEDURE dbo.GetReporteValidacionShowRoomOfertaV2
 @campania INT  
AS
SELECT Pais AS 'Pais',
	CampaniaID AS 'Campania',
	codigotipooferta AS 'CodigoTO',
	codigoproducto AS 'SAP',
	CUV2 AS 'CUV',
	DescripcionCUV2 AS 'Descripcion',
	Precio AS 'PrecioValorizado',
	Precio2 AS 'PrecioOferta',
	LimiteVenta AS 'UnidadesPermitidas',
	EsSubcampania AS 'EsSubCampania',
	Activo AS 'HabilitarOferta',
	FlagImagenCargada AS 'FlagImagenCargada',
	FlagImagenMINI AS 'FlagImagenMini'
 FROM (SELECT
	'Pais'='BO',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpBolivia.dbo.Estrategia e LEFT JOIN ODS_BO.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpBolivia.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='CL',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpChile.dbo.Estrategia e LEFT JOIN ODS_CL.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpChile.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='CO',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpColombia.dbo.Estrategia e LEFT JOIN ODS_CO.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpColombia.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='CR',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpCostaRica.dbo.Estrategia e LEFT JOIN ODS_CR.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpCostaRica.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='DO',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpDominicana.dbo.Estrategia e LEFT JOIN ODS_DO.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpDominicana.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='EC',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpEcuador.dbo.Estrategia e LEFT JOIN ODS_EC.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpEcuador.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='GT',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpGuatemala.dbo.Estrategia e LEFT JOIN ODS_GT.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpGuatemala.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='MX',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpMexico.dbo.Estrategia e LEFT JOIN ODS_MX.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpMexico.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='PA',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpPanama.dbo.Estrategia e LEFT JOIN ODS_PA.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpPanama.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='PE',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpPeru.dbo.Estrategia e LEFT JOIN ODS_PE.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpPeru.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='PR',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpPuertoRico.dbo.Estrategia e LEFT JOIN ODS_PR.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpPuertoRico.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='SV',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpSalvador.dbo.Estrategia e LEFT JOIN ODS_SV.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpSalvador.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='VE',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpVenezuela.dbo.Estrategia e LEFT JOIN ODS_VE.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpVenezuela.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania) AS T
ORDER BY 1,6
GO
USE BelcorpPeru
GO
 IF OBJECT_ID('dbo.GetReporteValidacionShowRoomOfertaV2', 'P') IS NOT NULL
	DROP PROC dbo.GetReporteValidacionShowRoomOfertaV2
GO
CREATE PROCEDURE dbo.GetReporteValidacionShowRoomOfertaV2
 @campania INT  
AS
SELECT Pais AS 'Pais',
	CampaniaID AS 'Campania',
	codigotipooferta AS 'CodigoTO',
	codigoproducto AS 'SAP',
	CUV2 AS 'CUV',
	DescripcionCUV2 AS 'Descripcion',
	Precio AS 'PrecioValorizado',
	Precio2 AS 'PrecioOferta',
	LimiteVenta AS 'UnidadesPermitidas',
	EsSubcampania AS 'EsSubCampania',
	Activo AS 'HabilitarOferta',
	FlagImagenCargada AS 'FlagImagenCargada',
	FlagImagenMINI AS 'FlagImagenMini'
 FROM (SELECT
	'Pais'='BO',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpBolivia.dbo.Estrategia e LEFT JOIN ODS_BO.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpBolivia.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='CL',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpChile.dbo.Estrategia e LEFT JOIN ODS_CL.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpChile.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='CO',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpColombia.dbo.Estrategia e LEFT JOIN ODS_CO.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpColombia.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='CR',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpCostaRica.dbo.Estrategia e LEFT JOIN ODS_CR.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpCostaRica.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='DO',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpDominicana.dbo.Estrategia e LEFT JOIN ODS_DO.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpDominicana.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='EC',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpEcuador.dbo.Estrategia e LEFT JOIN ODS_EC.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpEcuador.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='GT',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpGuatemala.dbo.Estrategia e LEFT JOIN ODS_GT.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpGuatemala.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='MX',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpMexico.dbo.Estrategia e LEFT JOIN ODS_MX.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpMexico.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='PA',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpPanama.dbo.Estrategia e LEFT JOIN ODS_PA.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpPanama.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='PE',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpPeru.dbo.Estrategia e LEFT JOIN ODS_PE.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpPeru.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='PR',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpPuertoRico.dbo.Estrategia e LEFT JOIN ODS_PR.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpPuertoRico.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='SV',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpSalvador.dbo.Estrategia e LEFT JOIN ODS_SV.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpSalvador.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='VE',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpVenezuela.dbo.Estrategia e LEFT JOIN ODS_VE.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpVenezuela.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania) AS T
ORDER BY 1,6
GO
USE BelcorpPuertoRico
GO
 IF OBJECT_ID('dbo.GetReporteValidacionShowRoomOfertaV2', 'P') IS NOT NULL
	DROP PROC dbo.GetReporteValidacionShowRoomOfertaV2
GO
CREATE PROCEDURE dbo.GetReporteValidacionShowRoomOfertaV2
 @campania INT  
AS
SELECT Pais AS 'Pais',
	CampaniaID AS 'Campania',
	codigotipooferta AS 'CodigoTO',
	codigoproducto AS 'SAP',
	CUV2 AS 'CUV',
	DescripcionCUV2 AS 'Descripcion',
	Precio AS 'PrecioValorizado',
	Precio2 AS 'PrecioOferta',
	LimiteVenta AS 'UnidadesPermitidas',
	EsSubcampania AS 'EsSubCampania',
	Activo AS 'HabilitarOferta',
	FlagImagenCargada AS 'FlagImagenCargada',
	FlagImagenMINI AS 'FlagImagenMini'
 FROM (SELECT
	'Pais'='BO',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpBolivia.dbo.Estrategia e LEFT JOIN ODS_BO.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpBolivia.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='CL',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpChile.dbo.Estrategia e LEFT JOIN ODS_CL.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpChile.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='CO',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpColombia.dbo.Estrategia e LEFT JOIN ODS_CO.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpColombia.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='CR',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpCostaRica.dbo.Estrategia e LEFT JOIN ODS_CR.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpCostaRica.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='DO',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpDominicana.dbo.Estrategia e LEFT JOIN ODS_DO.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpDominicana.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='EC',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpEcuador.dbo.Estrategia e LEFT JOIN ODS_EC.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpEcuador.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='GT',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpGuatemala.dbo.Estrategia e LEFT JOIN ODS_GT.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpGuatemala.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='MX',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpMexico.dbo.Estrategia e LEFT JOIN ODS_MX.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpMexico.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='PA',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpPanama.dbo.Estrategia e LEFT JOIN ODS_PA.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpPanama.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='PE',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpPeru.dbo.Estrategia e LEFT JOIN ODS_PE.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpPeru.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='PR',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpPuertoRico.dbo.Estrategia e LEFT JOIN ODS_PR.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpPuertoRico.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='SV',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpSalvador.dbo.Estrategia e LEFT JOIN ODS_SV.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpSalvador.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='VE',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpVenezuela.dbo.Estrategia e LEFT JOIN ODS_VE.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpVenezuela.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania) AS T
ORDER BY 1,6
GO
USE BelcorpSalvador
GO
 IF OBJECT_ID('dbo.GetReporteValidacionShowRoomOfertaV2', 'P') IS NOT NULL
	DROP PROC dbo.GetReporteValidacionShowRoomOfertaV2
GO
CREATE PROCEDURE dbo.GetReporteValidacionShowRoomOfertaV2
 @campania INT  
AS
SELECT Pais AS 'Pais',
	CampaniaID AS 'Campania',
	codigotipooferta AS 'CodigoTO',
	codigoproducto AS 'SAP',
	CUV2 AS 'CUV',
	DescripcionCUV2 AS 'Descripcion',
	Precio AS 'PrecioValorizado',
	Precio2 AS 'PrecioOferta',
	LimiteVenta AS 'UnidadesPermitidas',
	EsSubcampania AS 'EsSubCampania',
	Activo AS 'HabilitarOferta',
	FlagImagenCargada AS 'FlagImagenCargada',
	FlagImagenMINI AS 'FlagImagenMini'
 FROM (SELECT
	'Pais'='BO',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpBolivia.dbo.Estrategia e LEFT JOIN ODS_BO.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpBolivia.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='CL',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpChile.dbo.Estrategia e LEFT JOIN ODS_CL.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpChile.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='CO',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpColombia.dbo.Estrategia e LEFT JOIN ODS_CO.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpColombia.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='CR',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpCostaRica.dbo.Estrategia e LEFT JOIN ODS_CR.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpCostaRica.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='DO',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpDominicana.dbo.Estrategia e LEFT JOIN ODS_DO.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpDominicana.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='EC',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpEcuador.dbo.Estrategia e LEFT JOIN ODS_EC.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpEcuador.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='GT',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpGuatemala.dbo.Estrategia e LEFT JOIN ODS_GT.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpGuatemala.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='MX',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpMexico.dbo.Estrategia e LEFT JOIN ODS_MX.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpMexico.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='PA',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpPanama.dbo.Estrategia e LEFT JOIN ODS_PA.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpPanama.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='PE',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpPeru.dbo.Estrategia e LEFT JOIN ODS_PE.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpPeru.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='PR',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpPuertoRico.dbo.Estrategia e LEFT JOIN ODS_PR.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpPuertoRico.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='SV',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpSalvador.dbo.Estrategia e LEFT JOIN ODS_SV.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpSalvador.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='VE',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpVenezuela.dbo.Estrategia e LEFT JOIN ODS_VE.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpVenezuela.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania) AS T
ORDER BY 1,6
GO
USE BelcorpVenezuela
GO
 IF OBJECT_ID('dbo.GetReporteValidacionShowRoomOfertaV2', 'P') IS NOT NULL
	DROP PROC dbo.GetReporteValidacionShowRoomOfertaV2
GO
CREATE PROCEDURE dbo.GetReporteValidacionShowRoomOfertaV2
 @campania INT  
AS
SELECT Pais AS 'Pais',
	CampaniaID AS 'Campania',
	codigotipooferta AS 'CodigoTO',
	codigoproducto AS 'SAP',
	CUV2 AS 'CUV',
	DescripcionCUV2 AS 'Descripcion',
	Precio AS 'PrecioValorizado',
	Precio2 AS 'PrecioOferta',
	LimiteVenta AS 'UnidadesPermitidas',
	EsSubcampania AS 'EsSubCampania',
	Activo AS 'HabilitarOferta',
	FlagImagenCargada AS 'FlagImagenCargada',
	FlagImagenMINI AS 'FlagImagenMini'
 FROM (SELECT
	'Pais'='BO',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpBolivia.dbo.Estrategia e LEFT JOIN ODS_BO.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpBolivia.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='CL',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpChile.dbo.Estrategia e LEFT JOIN ODS_CL.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpChile.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='CO',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpColombia.dbo.Estrategia e LEFT JOIN ODS_CO.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpColombia.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='CR',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpCostaRica.dbo.Estrategia e LEFT JOIN ODS_CR.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpCostaRica.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='DO',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpDominicana.dbo.Estrategia e LEFT JOIN ODS_DO.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpDominicana.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='EC',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpEcuador.dbo.Estrategia e LEFT JOIN ODS_EC.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpEcuador.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='GT',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpGuatemala.dbo.Estrategia e LEFT JOIN ODS_GT.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpGuatemala.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='MX',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpMexico.dbo.Estrategia e LEFT JOIN ODS_MX.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpMexico.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='PA',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpPanama.dbo.Estrategia e LEFT JOIN ODS_PA.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpPanama.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='PE',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpPeru.dbo.Estrategia e LEFT JOIN ODS_PE.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpPeru.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='PR',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpPuertoRico.dbo.Estrategia e LEFT JOIN ODS_PR.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpPuertoRico.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='SV',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpSalvador.dbo.Estrategia e LEFT JOIN ODS_SV.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpSalvador.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania
UNION ALL
SELECT
	'Pais'='VE',
	e.CampaniaID,
	pc.codigotipooferta,
	pc.codigoproducto,
	e.CUV2,
	e.DescripcionCUV2,
	e.Precio,
	e.Precio2,
	e.LimiteVenta,
	'EsSubcampania'=ISNULL(e.EsSubCampania,0),
	Activo,
	'FlagImagenCargada'=(IIF(LEN(e.ImagenURL)>1, 1, 0)),
	'FlagImagenMINI'=(IIF(LEN(e.ImagenMiniaturaURL)>1, 1, 0))
FROM BelcorpVenezuela.dbo.Estrategia e LEFT JOIN ODS_VE.dbo.ProductoComercial pc ON pc.CUV=e.CUV2 AND  pc.AnoCampania=e.CampaniaID
INNER JOIN BelcorpVenezuela.dbo.vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
WHERE e.CampaniaID=@Campania) AS T
ORDER BY 1,6
GO

