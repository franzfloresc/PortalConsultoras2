USE BelcorpPeru_PL50
GO  

ALTER PROCEDURE [dbo].[ObtenerEstrategiasOfertaParaTi_SB2] @CampaniaID int,
@CodigoConsultora varchar(30) = ''
AS
  /*  
    dbo.ObtenerEstrategiasOfertaParaTi_SB2 201806, ''  
  	dbo.ObtenerEstrategiasOfertaParaTi_SB2 201806, '000020885'  
  */
  SET NOCOUNT ON
  SET @CodigoConsultora = ISNULL(@CodigoConsultora, '')

  IF @CodigoConsultora = ''
  BEGIN
    SELECT DISTINCT
      E.CUV2 AS CUV,
      E.DescripcionCUV2 AS NombreComercial,
      E.ImagenURL AS Imagen,
      E.Precio AS PrecioValorizado,
      E.Precio2 AS PrecioCatalogo
    FROM Estrategia E WITH (NOLOCK)
    INNER JOIN TipoEstrategia TE WITH (NOLOCK)
      ON E.TipoEstrategiaID = TE.TipoEstrategiaID
      AND TE.FlagActivo = 1
      AND TE.flagRecoPerfil = 1
    INNER JOIN ods.OfertasPersonalizadasCuv op WITH (NOLOCK)
      ON E.CampaniaID = op.AnioCampanaVenta
      AND E.CUV2 = op.CUV
      AND op.TipoPersonalizacion = 'OPT'
    INNER JOIN ods.ProductoComercial PC WITH (NOLOCK)
      ON PC.AnoCampania = E.CampaniaID
      AND PC.CUV = E.CUV2
    WHERE E.Activo = 1
    AND E.campaniaid = @CampaniaID
  END
  ELSE
  BEGIN
    SELECT DISTINCT
      E.CUV2 AS CUV,
      E.DescripcionCUV2 AS NombreComercial,
      E.ImagenURL AS Imagen,
      E.Precio AS PrecioValorizado,
      E.Precio2 AS PrecioCatalogo
    FROM Estrategia E WITH (NOLOCK)
    INNER JOIN TipoEstrategia TE WITH (NOLOCK)
      ON E.TipoEstrategiaID = TE.TipoEstrategiaID
      AND TE.FlagActivo = 1
      AND TE.flagRecoPerfil = 1
    INNER JOIN ods.OfertasPersonalizadas op WITH (NOLOCK)
      ON E.CampaniaID = op.AnioCampanaVenta
      AND E.CUV2 = op.CUV
      AND op.TipoPersonalizacion = 'OPT'
    INNER JOIN ods.ProductoComercial PC WITH (NOLOCK)
      ON PC.AnoCampania = E.CampaniaID
      AND PC.CUV = E.CUV2
    WHERE E.Activo = 1
    AND E.campaniaid = @CampaniaID
    AND op.CodConsultora = @CodigoConsultora
END