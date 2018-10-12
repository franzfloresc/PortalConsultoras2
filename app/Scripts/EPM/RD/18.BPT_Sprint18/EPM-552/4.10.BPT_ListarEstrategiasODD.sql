GO
ALTER PROCEDURE [dbo].[ListarEstrategiasODD]
(
	@CodCampania INT
	,@CodConsultora VARCHAR(10)
	,@FechaInicioFact DATE
)
AS

DECLARE @cant INT = 0

SELECT @cant = count(1)
FROM TipoEstrategia te
INNER JOIN Estrategia e ON te.TipoEstrategiaID = e.TipoEstrategiaID
INNER JOIN ods.Campania ca ON e.CampaniaID = ca.Codigo
INNER JOIN ods.OfertasPersonalizadas op ON ca.Codigo = op.AnioCampanaVenta
	AND e.CUV2 = op.CUV
	AND op.TipoPersonalizacion = 'ODD'
INNER JOIN ods.Consultora c ON op.CodConsultora = c.Codigo
INNER JOIN ods.ProductoComercial pc ON ca.CampaniaID = pc.CampaniaID
	AND e.CUV2 = pc.CUV
WHERE e.Activo = 1
	AND te.FlagActivo = 1
	AND te.flagRecoPerfil = 1
	AND ca.Codigo = @CodCampania
	AND c.Codigo = @CodConsultora
	AND DATEDIFF(dd, GETDATE(), DATEADD(dd, op.DiaInicio, CAST(@FechaInicioFact AS DATE))) = 0
	AND TE.Codigo = '009'

IF @cant = 0
	SELECT @CodConsultora = Codigo
	FROM TablaLogicaDatos
	WHERE TablaLogicaDatosID = 10001

SELECT distinct
	 e.EstrategiaID
	,e.CodigoEstrategia
	,e.CUV2
	,e.DescripcionCUV2
	,e.Precio
	,e.Precio2
	,e.TipoEstrategiaID
	,e.ImagenURL AS FotoProducto01
	,te.ImagenEstrategia AS ImagenURL
	,e.LimiteVenta
	,e.TextoLibre
	,pc.MarcaID
	,m.Descripcion AS DescripcionMarca
	,pc.IndicadorMontoMinimo
	,pc.CodigoProducto
	,0 AS FlagNueva
	,6 AS TipoEstrategiaImagenMostrar
	,op.DiaInicio
	,op.Orden
	,te.DescripcionEstrategia AS DescripcionEstrategia
FROM TipoEstrategia te
INNER JOIN Estrategia e ON te.TipoEstrategiaID = e.TipoEstrategiaID
INNER JOIN ods.Campania ca ON e.CampaniaID = ca.Codigo
INNER JOIN ods.OfertasPersonalizadas op ON ca.Codigo = op.AnioCampanaVenta
	AND e.CUV2 = op.CUV
	AND op.TipoPersonalizacion = 'ODD'
--INNER JOIN ods.Consultora c ON op.CodConsultora = c.Codigo
INNER JOIN ods.ProductoComercial pc ON ca.CampaniaID = pc.CampaniaID
	AND e.CUV2 = pc.CUV
INNER JOIN Marca m ON m.MarcaId = pc.MarcaID
WHERE e.Activo = 1
	AND te.FlagActivo = 1
	AND te.flagRecoPerfil = 1
	AND ca.Codigo = @CodCampania
	AND op.CodConsultora = @CodConsultora
	AND DATEDIFF(dd, GETDATE(), DATEADD(dd, op.DiaInicio, CAST(@FechaInicioFact AS DATE))) = 0
	AND TE.Codigo = '009'

GO