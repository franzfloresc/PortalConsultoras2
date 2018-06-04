  USE BelcorpPeru_PL50
  GO
ALTER PROCEDURE dbo.GetImagenOfertaPersonalizadaOF_SB2   
(  
 @CampaniaID int,  
 @CUV varchar(20)  
)  
AS  
/*  
GetImagenOfertaPersonalizadaOF_SB2 201613,'00724'  
*/  
BEGIN  
  
SET NOCOUNT ON;  
  
declare @resultado varchar(200) = ''  
  
SELECT top 1  
@resultado = isnull(DescripcionCUV2,'') + '|' + isnull(ImagenURL,'')  
FROM dbo.Estrategia e   
INNER JOIN ods.OfertasPersonalizadas op ON e.CUV2 = op.CUV AND e.CampaniaID = op.AnioCampanaVenta and op.TipoPersonalizacion = 'OF'  
WHERE e.CampaniaID = @CampaniaID AND e.CUV2 = @CUV  
  
  
select @resultado as DescripcionImagenURL  
  
END  
  
