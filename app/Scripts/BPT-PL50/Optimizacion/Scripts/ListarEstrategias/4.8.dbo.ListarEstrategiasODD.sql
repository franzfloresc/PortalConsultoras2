USE BelcorpPeru_PL50
GO
-- exec ListarEstrategiasODD 201807, '000685941','2018-05-07'
ALTER PROCEDURE dbo.ListarEstrategiasODD 
(
	 @CodCampania INT
	, @CodConsultora VARCHAR(10)
	, @FechaInicioFact DATE
)
AS
BEGIN
SET NOCOUNT ON

DECLARE @StrCampaniaID char(6) = CONVERT(char(6), @CodCampania)
DECLARE @EstrategiaCodigo varchar(100) = '009'

DECLARE @tablaCuvFaltante TABLE (
  CUV varchar(6)
)

DECLARE @OfertasPersonalizadas TABLE (
  Orden int,
  CUV char(6),
  TipoPersonalizacion char(3),
  FlagRevista int,
  AnioCampanaVenta int,
  DiaInicio INT
)

INSERT INTO @tablaCuvFaltante (CUV)
  SELECT
    CUV
  FROM dbo.ObtenerCuvFaltante (@CodCampania, @CodConsultora)

INSERT INTO @OfertasPersonalizadas
  SELECT
    ISNULL(Orden, 0),
    CUV,
    TipoPersonalizacion,
    FlagRevista,
    CONVERT(int, AnioCampanaVenta),
	DiaInicio
  FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
  WHERE op.CodConsultora = @CodConsultora
	  AND op.AnioCampanaVenta = @StrCampaniaID
	  AND op.TipoPersonalizacion = 'ODD'

IF NOT EXISTS (SELECT   CUV  FROM @OfertasPersonalizadas)
BEGIN
  DECLARE @codConsultoraDefault varchar(9)
  SELECT
    @codConsultoraDefault = Codigo
  FROM dbo.TablaLogicaDatos WITH (NOLOCK)
  WHERE TablaLogicaDatosID = 10001

  INSERT INTO @OfertasPersonalizadas
    SELECT
      ISNULL(Orden, 0),
      CUV,
      TipoPersonalizacion,
      FlagRevista,
      CONVERT(int, AnioCampanaVenta),
	  DiaInicio
    FROM ods.OfertasPersonalizadas op WITH (NOLOCK)
    WHERE op.CodConsultora = @codConsultoraDefault
		AND op.AnioCampanaVenta = @StrCampaniaID
		AND op.TipoPersonalizacion = 'ODD'
END

INSERT INTO @OfertasPersonalizadas(Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta)
	SELECT Orden, CUV, TipoPersonalizacion, FlagRevista, AnioCampanaVenta 
	FROM dbo.ListarEstrategiasForzadas(@CodCampania, @EstrategiaCodigo)

SELECT 
 e.EstrategiaID,
    e.CodigoEstrategia,
    e.CUV2,
    e.DescripcionCUV2,
    e.Precio,
    e.Precio2,
    e.TipoEstrategiaID,
    e.ImagenURL AS FotoProducto01,
    te.ImagenEstrategia AS ImagenURL,
    e.LimiteVenta,
    e.TextoLibre,
    pc.MarcaID,
    m.Descripcion AS DescripcionMarca,
    pc.IndicadorMontoMinimo,
    pc.CodigoProducto,
    0 AS FlagNueva,
    6 AS TipoEstrategiaImagenMostrar,
    op.DiaInicio,
    op.Orden,
    te.DescripcionEstrategia AS DescripcionEstrategia
FROM dbo.Estrategia E WITH (NOLOCK)
	  INNER JOIN @OfertasPersonalizadas op    ON E.CampaniaID = op.AnioCampanaVenta    AND E.CUV2 = op.CUV
	  INNER JOIN ods.ProductoComercial PC WITH (NOLOCK)    ON PC.CUV = E.CUV2    AND PC.AnoCampania = E.CampaniaID
	  INNER JOIN dbo.TipoEstrategia TE WITH (NOLOCK)    ON E.TipoEstrategiaID = TE.TipoEstrategiaID    AND TE.Codigo =@EstrategiaCodigo
	  LEFT JOIN dbo.Marca M WITH (NOLOCK)    ON M.MarcaId = PC.MarcaId
  WHERE E.Activo = 1
	  AND TE.FlagActivo = 1
	  AND TE.flagRecoPerfil = 1
	  AND NOT EXISTS (SELECT    CUV  FROM @tablaCuvFaltante TF  WHERE E.CUV2 = TF.CUV)
	   AND DATEDIFF(dd, GETDATE(), DATEADD(dd, op.DiaInicio, CAST(@FechaInicioFact AS date))) = 0
    ORDER BY 
		op.Orden ASC, EstrategiaID ASC
  SET NOCOUNT OFF
END
