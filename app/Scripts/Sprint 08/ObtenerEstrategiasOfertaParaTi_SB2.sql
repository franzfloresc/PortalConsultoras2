

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerEstrategiasOfertaParaTi_SB2]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ObtenerEstrategiasOfertaParaTi_SB2
GO

CREATE PROCEDURE [dbo].[ObtenerEstrategiasOfertaParaTi_SB2]
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(30) = ''
AS
/*
dbo.ObtenerEstrategiasOfertaParaTi_SB2 201612,''
*/
BEGIN

-- declare @CampaniaID INT = 201612
-- declare @CodigoConsultora VARCHAR(30) = ''

 SET @CodigoConsultora = ISNULL(@CodigoConsultora, '')

	SELECT distinct
		e.CUV2 as CUV,
		e.DescripcionCUV2 as NombreComercial,
		E.ImagenURL AS Imagen
	FROM Estrategia E
	INNER JOIN TipoEstrategia TE ON E.TipoEstrategiaID = TE.TipoEstrategiaID AND TE.FlagActivo = 1 AND TE.flagRecoPerfil = 1
	INNER JOIN ods.Campania ca ON CA.Codigo = e.campaniaid
	INNER JOIN ods.OfertasPersonalizadas op ON E.CUV2 = op.CUV and op.AnioCampanaVenta = CA.Codigo and op.TipoPersonalizacion = 'OPT'
	INNER JOIN ods.Consultora c ON op.CodConsultora = c.Codigo and ( c.codigo = @CodigoConsultora OR @CodigoConsultora = '')
	INNER JOIN ods.ProductoComercial PC ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
	WHERE
		E.Activo = 1		
		AND e.campaniaid = @CampaniaID
	--ORDER BY CASE WHEN ISNULL(op.Orden,0) = 0 THEN te.Orden ELSE op.Orden END ASC
	group by e.CUV2, e.DescripcionCUV2, E.ImagenURL

end