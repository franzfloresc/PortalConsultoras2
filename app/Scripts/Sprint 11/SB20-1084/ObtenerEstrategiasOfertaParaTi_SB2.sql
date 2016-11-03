ALTER PROCEDURE [dbo].ObtenerEstrategiasOfertaParaTi_SB2
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(30) = ''
AS
/*
dbo.ObtenerEstrategiasOfertaParaTi_SB2 201616,''
*/
BEGIN

 SET @CodigoConsultora = ISNULL(@CodigoConsultora, '')

	SELECT distinct
		e.CUV2 as CUV,
		e.DescripcionCUV2 as NombreComercial,
		e.ImagenURL AS Imagen,
		e.Precio AS PrecioValorizado,
		e.Precio2 AS PrecioCatalogo
	FROM Estrategia E
	INNER JOIN TipoEstrategia TE ON E.TipoEstrategiaID = TE.TipoEstrategiaID AND TE.FlagActivo = 1 AND TE.flagRecoPerfil = 1
	INNER JOIN ods.Campania ca ON CA.Codigo = e.campaniaid
	INNER JOIN ods.OfertasPersonalizadas op ON E.CUV2 = op.CUV and op.AnioCampanaVenta = CA.Codigo and op.TipoPersonalizacion = 'OPT'
	INNER JOIN ods.Consultora c ON op.CodConsultora = c.Codigo and ( c.codigo = @CodigoConsultora OR @CodigoConsultora = '')
	INNER JOIN ods.ProductoComercial PC ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
	WHERE
		E.Activo = 1		
		AND e.campaniaid = @CampaniaID
	group by e.CUV2, e.DescripcionCUV2, e.ImagenURL, e.Precio, e.Precio2

end
GO