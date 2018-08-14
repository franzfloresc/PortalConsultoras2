USE BelcorpPeru_BPT
GO

ALTER PROCEDURE [dbo].[ObtenerEstrategiasOfertaParaTi_SB2] @CampaniaID INT
	,@CodigoConsultora VARCHAR(30) = ''
AS
/*  
    dbo.ObtenerEstrategiasOfertaParaTi_SB2 201806, ''  
  	dbo.ObtenerEstrategiasOfertaParaTi_SB2 201806, '000020885'  
  */
SET NOCOUNT ON

IF ISNULL(@CodigoConsultora, '') = ''
BEGIN
	SELECT DISTINCT e.CUV2 AS CUV
		,e.DescripcionCUV2 AS NombreComercial
		,e.ImagenURL AS Imagen
		,e.Precio AS PrecioValorizado
		,e.Precio2 AS PrecioCatalogo
		,te.TipoEstrategiaId AS TipoEstrategiaID
	FROM TipoEstrategia te WITH (NOLOCK)
	INNER JOIN Estrategia e WITH (NOLOCK) ON te.TipoEstrategiaID = e.TipoEstrategiaID
		AND te.Codigo = '001'
	INNER JOIN ods.OfertasPersonalizadasCuv op WITH (NOLOCK) ON e.CampaniaID = op.AnioCampanaVenta
		AND e.CUV2 = op.CUV
		AND op.TipoPersonalizacion = 'OPT'
	INNER JOIN ods.ProductoComercial PC WITH (NOLOCK) ON e.CampaniaID = pc.AnoCampania
		AND e.CUV2 = pc.CUV
	WHERE e.campaniaid = @CampaniaID
		AND e.Activo = 1
END
ELSE
BEGIN
	SELECT DISTINCT e.CUV2 AS CUV
		,e.DescripcionCUV2 AS NombreComercial
		,e.ImagenURL AS Imagen
		,e.Precio AS PrecioValorizado
		,e.Precio2 AS PrecioCatalogo
		,te.TipoEstrategiaId
	FROM TipoEstrategia te WITH (NOLOCK)
	INNER JOIN Estrategia e WITH (NOLOCK) ON te.TipoEstrategiaID = e.TipoEstrategiaID
		AND te.Codigo = '001'
	INNER JOIN ods.OfertasPersonalizadas op WITH (NOLOCK) ON e.CampaniaID = op.AnioCampanaVenta
		AND e.CUV2 = op.CUV
		AND op.CodConsultora = @CodigoConsultora
		AND op.TipoPersonalizacion = 'OPT'
	INNER JOIN ods.ProductoComercial pc WITH (NOLOCK) ON e.CampaniaID = pc.AnoCampania
		AND e.CUV2 = PC.CUV 
	WHERE e.CampaniaId = @CampaniaID
		AND e.Activo = 1
END