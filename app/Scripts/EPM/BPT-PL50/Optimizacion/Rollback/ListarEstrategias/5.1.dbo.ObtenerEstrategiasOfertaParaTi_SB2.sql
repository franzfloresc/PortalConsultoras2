USE BelcorpPeru_PL50
GO  
ALTER PROCEDURE [dbo].[ObtenerEstrategiasOfertaParaTi_SB2]   
 @CampaniaID INT,  
 @CodigoConsultora VARCHAR(30) = ''  
AS  
/*  
dbo.ObtenerEstrategiasOfertaParaTi_SB2 201701,''  
*/  
BEGIN  
  
 SET @CodigoConsultora = ISNULL(@CodigoConsultora, '')  
  
 IF @CodigoConsultora = ''  
 BEGIN  
  SELECT distinct  
   e.CUV2 as CUV,  
   e.DescripcionCUV2 as NombreComercial,  
   e.ImagenURL AS Imagen,  
   e.Precio AS PrecioValorizado,  
   e.Precio2 AS PrecioCatalogo  
  FROM Estrategia E  WITH(NOLOCK)  
  INNER JOIN TipoEstrategia TE WITH(NOLOCK) ON E.TipoEstrategiaID = TE.TipoEstrategiaID AND TE.FlagActivo = 1 AND TE.flagRecoPerfil = 1  
  INNER JOIN ods.Campania ca WITH(NOLOCK) ON CA.Codigo = e.campaniaid  
  INNER JOIN ods.OfertasPersonalizadas op WITH(NOLOCK) ON CA.Codigo = op.AnioCampanaVenta and E.CUV2 = op.CUV and op.TipoPersonalizacion = 'OPT'  
  INNER JOIN ods.ProductoComercial PC WITH(NOLOCK) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2  
  WHERE  
   E.Activo = 1 AND E.campaniaid = @CampaniaID  
  group by e.CUV2, e.DescripcionCUV2, e.ImagenURL, e.Precio, e.Precio2  
 END  
 ELSE  
 BEGIN  
  SELECT distinct  
   e.CUV2 as CUV,  
   e.DescripcionCUV2 as NombreComercial,  
   e.ImagenURL AS Imagen,  
   e.Precio AS PrecioValorizado,  
   e.Precio2 AS PrecioCatalogo  
  FROM Estrategia E  WITH(NOLOCK)  
  INNER JOIN TipoEstrategia TE WITH(NOLOCK) ON E.TipoEstrategiaID = TE.TipoEstrategiaID AND TE.FlagActivo = 1 AND TE.flagRecoPerfil = 1  
  INNER JOIN ods.Campania ca WITH(NOLOCK) ON CA.Codigo = e.campaniaid  
  INNER JOIN ods.OfertasPersonalizadas op WITH(NOLOCK) ON CA.Codigo = op.AnioCampanaVenta and E.CUV2 = op.CUV and op.TipoPersonalizacion = 'OPT'  
  INNER JOIN ods.ProductoComercial PC WITH(NOLOCK) ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2  
  WHERE  
   E.Activo = 1 AND E.campaniaid = @CampaniaID  
   --AND (@CodigoConsultora = '' OR op.CodConsultora = @CodigoConsultora)  
   AND op.CodConsultora = @CodigoConsultora  
  group by e.CUV2, e.DescripcionCUV2, e.ImagenURL, e.Precio, e.Precio2  
 END  
end  
  
  