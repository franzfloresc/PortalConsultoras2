
ALTER PROCEDURE [dbo].[ObtenerEstrategiasOfertaParaMi_SB2] @CampaniaID INT
	,@CodigoConsultora VARCHAR(30) = ''
AS
/*
dbo.ObtenerEstrategiasOfertaParaMi_SB2 201807,''
*/
BEGIN
	IF ISNULL(@CodigoConsultora, '') = ''
	BEGIN
		SELECT TOP 1000 AnioCampanaVenta
			,CUV
		INTO #ofertas
		FROM ods.OfertasPersonalizadas WITH (NOLOCK)
		WHERE AnioCampanaVenta = @CampaniaID
			AND TipoPersonalizacion = 'OPM'
			AND FlagRevista = 0

		SELECT DISTINCT e.CUV2 AS CUV
			,e.DescripcionCUV2 AS NombreComercial
			,e.ImagenURL AS Imagen
			,e.Precio AS PrecioValorizado
			,e.Precio2 AS PrecioCatalogo
		FROM TipoEstrategia te WITH (NOLOCK)
		INNER JOIN Estrategia e WITH (NOLOCK) ON te.TipoEstrategiaId = e.TipoEstrategiaId
			AND te.Codigo = '007'
			AND te.FlagActivo = 1 and e.CodigoEstrategia <> '2003'
		INNER JOIN #ofertas op ON e.CampaniaId = op.AnioCampanaVenta
			AND e.CUV2 = op.CUV
		--INNER JOIN ods.OfertasPersonalizadas op ON e.CampaniaId = op.AnioCampanaVenta 
		--	AND e.CUV2 = op.CUV 
		--	AND op.TipoPersonalizacion = 'OPM' 
		--	AND op.FlagRevista = 0
		WHERE e.CampaniaId = @CampaniaID
			AND e.Activo = 1

		DROP TABLE #ofertas
	END
END