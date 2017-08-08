GO
use BelcorpChile_Plan20
go
if exists(select 1 from sysobjects where name = 'ObtenerEstrategiasShowRoom_SB2' and xtype = 'p')
drop procedure ObtenerEstrategiasShoRoom_SB2
go
CREATE PROCEDURE dbo.ObtenerEstrategiasShowRoom_SB2
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(30) = ''
AS
/*
dbo.ObtenerEstrategiasOfertaParaTi_SB2 201701,''
*/
BEGIN

	SET @CodigoConsultora = ISNULL(@CodigoConsultora, '')

	SELECT  distinct top 1
		e.CUV2 as CUV,
		e.DescripcionCUV2 as NombreComercial,
		e.ImagenURL AS Imagen,
		e.Precio AS PrecioValorizado,
		e.Precio2 AS PrecioCatalogo
	FROM Estrategia E  WITH(NOLOCK)
	INNER JOIN TipoEstrategia TE WITH(NOLOCK) ON E.TipoEstrategiaID = TE.TipoEstrategiaID AND TE.FlagActivo = 1 AND TE.flagRecoPerfil = 1
	INNER JOIN ods.Campania ca WITH(NOLOCK) ON CA.Codigo = e.campaniaid
	INNER JOIN ods.OfertasPersonalizadas op WITH(NOLOCK) ON E.CUV2 = op.CUV and op.AnioCampanaVenta = CA.Codigo and op.TipoPersonalizacion = 'SR'
	INNER JOIN ods.ProductoComercial PC WITH(NOLOCK) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2
	WHERE
		E.Activo = 1 AND E.campaniaid = @CampaniaID
		
	group by e.CUV2, e.DescripcionCUV2, e.ImagenURL, e.Precio, e.Precio2

end

GO
