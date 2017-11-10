
USE BelcorpBolivia
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
GO

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
GO

USE BelcorpColombia
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
GO

USE BelcorpCostaRica
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
GO


USE BelcorpDominicana
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
GO

USE BelcorpEcuador
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
GO

USE BelcorpGuatemala
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
GO

USE BelcorpMexico
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
GO

USE BelcorpPanama
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
GO

USE BelcorpPeru
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
GO

USE BelcorpPuertoRico
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
GO

USE BelcorpSalvador
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
GO

USE BelcorpVenezuela
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
GO
