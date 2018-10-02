GO
USE BelcorpPeru
GO
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
GO


GO
USE BelcorpMexico
GO
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
GO


GO
USE BelcorpColombia
GO
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
GO


GO
USE BelcorpSalvador
GO
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
GO


GO
USE BelcorpPuertoRico
GO
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
GO


GO
USE BelcorpPanama
GO
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
GO


GO
USE BelcorpGuatemala
GO
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
GO


GO
USE BelcorpEcuador
GO
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
GO


GO
USE BelcorpDominicana
GO
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
GO


GO
USE BelcorpCostaRica
GO
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
GO


GO
USE BelcorpChile
GO
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
GO


GO
USE BelcorpBolivia
GO
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
GO


GO
