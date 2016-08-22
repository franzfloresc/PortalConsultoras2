CREATE PROCEDURE dbo.GetImagenOfertaPersonalizadaOF 
(
	@CampaniaID int,
	@CUV varchar(20)
)
AS
BEGIN

SET NOCOUNT ON;

SELECT 
ImagenURL
FROM dbo.Estrategia e 
INNER JOIN ods.OfertasPersonalizadas op ON e.CUV2 = op.CUV AND op.TipoPersonalizacion = 'OF'
WHERE e.CampaniaID = @CampaniaID AND e.CUV2 = @CUV

END
GO

