
USE BelcorpChile
GO

ALTER PROCEDURE [dbo].[GetObtenerOfertaFinalRegaloSorpresa]
    @CampaniaId INT,
    @ConsultoraId INT
AS
BEGIN
    SELECT ofe.CampaniaId,
           ofe.ConsultoraId,
           ofe.MontoPedido,
           ofe.GapMinimo,
           ofe.GapMaximo,
           ofe.GapAgregar,
           ofe.MontoMeta,
           ofe.Cuv,
           ofe.TipoRango,
           pc.Descripcion,
           prd.RegaloDescripcion,
           prd.RegaloImagenUrl
    FROM dbo.OfertaFinalMontoMeta ofe WITH (NOLOCK)
        INNER JOIN ProductoDescripcion prd WITH (NOLOCK)
            ON ofe.CampaniaId = prd.CampaniaID
               AND ofe.Cuv = prd.CUV
        INNER JOIN ods.ProductoComercial pc WITH (NOLOCK)
            ON pc.Cuv = ofe.Cuv
               AND pc.AnoCampania = ofe.CampaniaId
    WHERE ofe.CampaniaId = @CampaniaId
          AND ofe.ConsultoraId = @ConsultoraId;
END;

