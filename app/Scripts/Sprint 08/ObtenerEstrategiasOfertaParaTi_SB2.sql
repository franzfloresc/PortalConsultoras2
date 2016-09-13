

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerEstrategiasOfertaParaTi_SB2]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ObtenerEstrategiasOfertaParaTi_SB2
GO

CREATE PROCEDURE [dbo].[ObtenerEstrategiasOfertaParaTi_SB2]
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(30)
AS
/*
dbo.ObtenerEstrategiasOfertaParaTi_SB2 201614,'000758833'
*/
BEGIN

-- declare @CampaniaID INT = 201613
-- declare @CodigoConsultora VARCHAR(30) = '000758833'

	SELECT
		EstrategiaID,
		CUV2 as CUV,
		DescripcionCUV2 as NombreComercial,
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
		e.Precio as PrecioCatalogo,
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID2) EtiquetaDescripcion2,
		Precio2,
		TextoLibre,
		FlagEstrella,
		ColorFondo,
		e.TipoEstrategiaID,
		e.ImagenURL as Imagen,
		--te.ImagenEstrategia ImagenURL,
		e.LimiteVenta,    
		pc.MarcaID,
		te.Orden Orden1,
		op.Orden Orden2,
		pc.IndicadorMontoMinimo,
		pc.CodigoProducto,
		0 AS FlagNueva, 
		3 as TipoEstrategiaImagenMostrar	--Oferta para Ti
		, E.EtiquetaID		
		, E.EtiquetaID2	
		, c.codigo as CodigoConsultora
	FROM Estrategia E
	INNER JOIN TipoEstrategia TE ON E.TipoEstrategiaID = TE.TipoEstrategiaID AND TE.FlagActivo = 1 AND TE.flagRecoPerfil = 1
	INNER JOIN ods.Campania ca ON CA.Codigo = e.campaniaid
	INNER JOIN ods.OfertasPersonalizadas op ON E.CUV2 = op.CUV and op.AnioCampanaVenta = CA.Codigo and op.TipoPersonalizacion = 'OPT'
	INNER JOIN ods.Consultora c ON op.CodConsultora = c.Codigo and c.codigo = @CodigoConsultora
	INNER JOIN ods.ProductoComercial PC ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
	WHERE
		E.Activo = 1		
		AND ca.Codigo = @CampaniaID
	ORDER BY CASE WHEN ISNULL(op.Orden,0) = 0 THEN te.Orden ELSE op.Orden END ASC

end