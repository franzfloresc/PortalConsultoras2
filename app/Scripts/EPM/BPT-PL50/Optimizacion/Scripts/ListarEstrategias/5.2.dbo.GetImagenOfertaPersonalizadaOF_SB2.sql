USE belcorpPeru_PL50
GO
/*
	Exec GetImagenOfertaPersonalizadaOF_SB2 201807,'33923'  
*/
ALTER PROCEDURE dbo.GetImagenOfertaPersonalizadaOF_SB2   
(  
 @CampaniaID int,  
 @CUV varchar(20)  
)  
AS  
BEGIN
  SET NOCOUNT ON
  SELECT
    ISNULL(DescripcionCUV2, '') + '|' + ISNULL(ImagenURL, '') AS DescripcionImagenURL
  FROM dbo.Estrategia e
	 INNER JOIN ods.OfertasPersonalizadasCUV op ON e.CUV2 = op.CUV
		AND e.CampaniaID = op.AnioCampanaVenta
		AND op.TipoPersonalizacion = 'OF'
  WHERE e.CampaniaID = @CampaniaID
		AND e.CUV2 = @CUV
END
  