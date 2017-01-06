

USE BelcorpBolivia
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.ListarEstrategiasODD'))
BEGIN
    DROP PROCEDURE dbo.ListarEstrategiasODD
END

GO

CREATE PROCEDURE [dbo].[ListarEstrategiasODD]
(
	@CodCampania INT,
	@ConsultoraID INT
)
AS

--SET @CodCampania = 201616

SELECT TOP 1
	e.EstrategiaID,
	e.CUV2,
	e.DescripcionCUV2,
	--dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
	e.Precio,
	--dbo.ObtenerDescripcionEtiqueta(EtiquetaID2) EtiquetaDescripcion2,
	e.Precio2,
	--e.TextoLibre,
	--e.FlagEstrella,
	--e.ColorFondo,
	e.TipoEstrategiaID,
	e.ImagenURL AS FotoProducto01,
	te.ImagenEstrategia AS ImagenURL,
	e.LimiteVenta,    
	pc.MarcaID,
	--te.Orden as Orden1,
	--op.Orden as Orden2,
	pc.IndicadorMontoMinimo,
	pc.CodigoProducto,
	0 AS FlagNueva, -- R2621
	--dbo.fn_ObtenerTallaColorCuv_SB2(E.CUV2,@CampaniaID) as TipoTallaColor,
	6 AS TipoEstrategiaImagenMostrar	--Oferta del dia
	--, E.EtiquetaID		-- SB20-351
	--, E.EtiquetaID2		-- SB20-351
FROM TipoEstrategia te
INNER JOIN Estrategia e ON te.TipoEstrategiaID = e.TipoEstrategiaID
INNER JOIN ods.Campania ca ON e.CampaniaID = ca.Codigo
INNER JOIN ods.OfertasPersonalizadas op ON ca.Codigo = op.AnioCampanaVenta
	AND e.CUV2 = op.CUV 
	AND op.TipoPersonalizacion = 'ODD'
INNER JOIN ods.Consultora c ON op.CodConsultora = c.Codigo
INNER JOIN ods.ProductoComercial pc ON ca.CampaniaID = pc.CampaniaID 
	AND e.CUV2 = pc.CUV
WHERE
	e.Activo = 1
	AND te.FlagActivo = 1
	AND te.flagRecoPerfil = 1
	AND ca.Codigo = @CodCampania
	AND c.ConsultoraID = @ConsultoraID
	AND te.TipoEstrategiaID = 2007
	--AND e.Zona LIKE '%' + @ZonaID + '%'
	--AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
--ORDER BY te.Orden ASC, op.Orden
--ORDER BY CASE WHEN ISNULL(op.Orden,0) = 0 THEN te.Orden ELSE op.Orden END ASC

GO
/*end*/

USE BelcorpChile
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.ListarEstrategiasODD'))
BEGIN
    DROP PROCEDURE dbo.ListarEstrategiasODD
END

GO

CREATE PROCEDURE [dbo].[ListarEstrategiasODD]
(
	@CodCampania INT,
	@ConsultoraID INT
)
AS

--SET @CodCampania = 201616

SELECT TOP 1
	e.EstrategiaID,
	e.CUV2,
	e.DescripcionCUV2,
	--dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
	e.Precio,
	--dbo.ObtenerDescripcionEtiqueta(EtiquetaID2) EtiquetaDescripcion2,
	e.Precio2,
	--e.TextoLibre,
	--e.FlagEstrella,
	--e.ColorFondo,
	e.TipoEstrategiaID,
	e.ImagenURL AS FotoProducto01,
	te.ImagenEstrategia AS ImagenURL,
	e.LimiteVenta,    
	pc.MarcaID,
	--te.Orden as Orden1,
	--op.Orden as Orden2,
	pc.IndicadorMontoMinimo,
	pc.CodigoProducto,
	0 AS FlagNueva, -- R2621
	--dbo.fn_ObtenerTallaColorCuv_SB2(E.CUV2,@CampaniaID) as TipoTallaColor,
	6 AS TipoEstrategiaImagenMostrar	--Oferta del dia
	--, E.EtiquetaID		-- SB20-351
	--, E.EtiquetaID2		-- SB20-351
FROM TipoEstrategia te
INNER JOIN Estrategia e ON te.TipoEstrategiaID = e.TipoEstrategiaID
INNER JOIN ods.Campania ca ON e.CampaniaID = ca.Codigo
INNER JOIN ods.OfertasPersonalizadas op ON ca.Codigo = op.AnioCampanaVenta
	AND e.CUV2 = op.CUV 
	AND op.TipoPersonalizacion = 'ODD'
INNER JOIN ods.Consultora c ON op.CodConsultora = c.Codigo
INNER JOIN ods.ProductoComercial pc ON ca.CampaniaID = pc.CampaniaID 
	AND e.CUV2 = pc.CUV
WHERE
	e.Activo = 1
	AND te.FlagActivo = 1
	AND te.flagRecoPerfil = 1
	AND ca.Codigo = @CodCampania
	AND c.ConsultoraID = @ConsultoraID
	AND te.TipoEstrategiaID = 2005
	--AND e.Zona LIKE '%' + @ZonaID + '%'
	--AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
--ORDER BY te.Orden ASC, op.Orden
--ORDER BY CASE WHEN ISNULL(op.Orden,0) = 0 THEN te.Orden ELSE op.Orden END ASC

GO
/*end*/


USE BelcorpCostaRica
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.ListarEstrategiasODD'))
BEGIN
    DROP PROCEDURE dbo.ListarEstrategiasODD
END

GO

CREATE PROCEDURE [dbo].[ListarEstrategiasODD]
(
	@CodCampania INT,
	@ConsultoraID INT
)
AS

--SET @CodCampania = 201616

SELECT TOP 1
	e.EstrategiaID,
	e.CUV2,
	e.DescripcionCUV2,
	--dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
	e.Precio,
	--dbo.ObtenerDescripcionEtiqueta(EtiquetaID2) EtiquetaDescripcion2,
	e.Precio2,
	--e.TextoLibre,
	--e.FlagEstrella,
	--e.ColorFondo,
	e.TipoEstrategiaID,
	e.ImagenURL AS FotoProducto01,
	te.ImagenEstrategia AS ImagenURL,
	e.LimiteVenta,    
	pc.MarcaID,
	--te.Orden as Orden1,
	--op.Orden as Orden2,
	pc.IndicadorMontoMinimo,
	pc.CodigoProducto,
	0 AS FlagNueva, -- R2621
	--dbo.fn_ObtenerTallaColorCuv_SB2(E.CUV2,@CampaniaID) as TipoTallaColor,
	6 AS TipoEstrategiaImagenMostrar	--Oferta del dia
	--, E.EtiquetaID		-- SB20-351
	--, E.EtiquetaID2		-- SB20-351
FROM TipoEstrategia te
INNER JOIN Estrategia e ON te.TipoEstrategiaID = e.TipoEstrategiaID
INNER JOIN ods.Campania ca ON e.CampaniaID = ca.Codigo
INNER JOIN ods.OfertasPersonalizadas op ON ca.Codigo = op.AnioCampanaVenta
	AND e.CUV2 = op.CUV 
	AND op.TipoPersonalizacion = 'ODD'
INNER JOIN ods.Consultora c ON op.CodConsultora = c.Codigo
INNER JOIN ods.ProductoComercial pc ON ca.CampaniaID = pc.CampaniaID 
	AND e.CUV2 = pc.CUV
WHERE
	e.Activo = 1
	AND te.FlagActivo = 1
	AND te.flagRecoPerfil = 1
	AND ca.Codigo = @CodCampania
	AND c.ConsultoraID = @ConsultoraID
	AND te.TipoEstrategiaID = 1007
	--AND e.Zona LIKE '%' + @ZonaID + '%'
	--AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
--ORDER BY te.Orden ASC, op.Orden
--ORDER BY CASE WHEN ISNULL(op.Orden,0) = 0 THEN te.Orden ELSE op.Orden END ASC

GO
/*end*/

USE BelcorpDominicana
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.ListarEstrategiasODD'))
BEGIN
    DROP PROCEDURE dbo.ListarEstrategiasODD
END

GO

CREATE PROCEDURE [dbo].[ListarEstrategiasODD]
(
	@CodCampania INT,
	@ConsultoraID INT
)
AS

--SET @CodCampania = 201616

SELECT TOP 1
	e.EstrategiaID,
	e.CUV2,
	e.DescripcionCUV2,
	--dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
	e.Precio,
	--dbo.ObtenerDescripcionEtiqueta(EtiquetaID2) EtiquetaDescripcion2,
	e.Precio2,
	--e.TextoLibre,
	--e.FlagEstrella,
	--e.ColorFondo,
	e.TipoEstrategiaID,
	e.ImagenURL AS FotoProducto01,
	te.ImagenEstrategia AS ImagenURL,
	e.LimiteVenta,    
	pc.MarcaID,
	--te.Orden as Orden1,
	--op.Orden as Orden2,
	pc.IndicadorMontoMinimo,
	pc.CodigoProducto,
	0 AS FlagNueva, -- R2621
	--dbo.fn_ObtenerTallaColorCuv_SB2(E.CUV2,@CampaniaID) as TipoTallaColor,
	6 AS TipoEstrategiaImagenMostrar	--Oferta del dia
	--, E.EtiquetaID		-- SB20-351
	--, E.EtiquetaID2		-- SB20-351
FROM TipoEstrategia te
INNER JOIN Estrategia e ON te.TipoEstrategiaID = e.TipoEstrategiaID
INNER JOIN ods.Campania ca ON e.CampaniaID = ca.Codigo
INNER JOIN ods.OfertasPersonalizadas op ON ca.Codigo = op.AnioCampanaVenta
	AND e.CUV2 = op.CUV 
	AND op.TipoPersonalizacion = 'ODD'
INNER JOIN ods.Consultora c ON op.CodConsultora = c.Codigo
INNER JOIN ods.ProductoComercial pc ON ca.CampaniaID = pc.CampaniaID 
	AND e.CUV2 = pc.CUV
WHERE
	e.Activo = 1
	AND te.FlagActivo = 1
	AND te.flagRecoPerfil = 1
	AND ca.Codigo = @CodCampania
	AND c.ConsultoraID = @ConsultoraID
	AND te.TipoEstrategiaID = 2005
	--AND e.Zona LIKE '%' + @ZonaID + '%'
	--AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
--ORDER BY te.Orden ASC, op.Orden
--ORDER BY CASE WHEN ISNULL(op.Orden,0) = 0 THEN te.Orden ELSE op.Orden END ASC

GO
/*end*/

USE BelcorpEcuador
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.ListarEstrategiasODD'))
BEGIN
    DROP PROCEDURE dbo.ListarEstrategiasODD
END

GO

CREATE PROCEDURE [dbo].[ListarEstrategiasODD]
(
	@CodCampania INT,
	@ConsultoraID INT
)
AS

--SET @CodCampania = 201616

SELECT TOP 1
	e.EstrategiaID,
	e.CUV2,
	e.DescripcionCUV2,
	--dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
	e.Precio,
	--dbo.ObtenerDescripcionEtiqueta(EtiquetaID2) EtiquetaDescripcion2,
	e.Precio2,
	--e.TextoLibre,
	--e.FlagEstrella,
	--e.ColorFondo,
	e.TipoEstrategiaID,
	e.ImagenURL AS FotoProducto01,
	te.ImagenEstrategia AS ImagenURL,
	e.LimiteVenta,    
	pc.MarcaID,
	--te.Orden as Orden1,
	--op.Orden as Orden2,
	pc.IndicadorMontoMinimo,
	pc.CodigoProducto,
	0 AS FlagNueva, -- R2621
	--dbo.fn_ObtenerTallaColorCuv_SB2(E.CUV2,@CampaniaID) as TipoTallaColor,
	6 AS TipoEstrategiaImagenMostrar	--Oferta del dia
	--, E.EtiquetaID		-- SB20-351
	--, E.EtiquetaID2		-- SB20-351
FROM TipoEstrategia te
INNER JOIN Estrategia e ON te.TipoEstrategiaID = e.TipoEstrategiaID
INNER JOIN ods.Campania ca ON e.CampaniaID = ca.Codigo
INNER JOIN ods.OfertasPersonalizadas op ON ca.Codigo = op.AnioCampanaVenta
	AND e.CUV2 = op.CUV 
	AND op.TipoPersonalizacion = 'ODD'
INNER JOIN ods.Consultora c ON op.CodConsultora = c.Codigo
INNER JOIN ods.ProductoComercial pc ON ca.CampaniaID = pc.CampaniaID 
	AND e.CUV2 = pc.CUV
WHERE
	e.Activo = 1
	AND te.FlagActivo = 1
	AND te.flagRecoPerfil = 1
	AND ca.Codigo = @CodCampania
	AND c.ConsultoraID = @ConsultoraID
	AND te.TipoEstrategiaID = 5
	--AND e.Zona LIKE '%' + @ZonaID + '%'
	--AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
--ORDER BY te.Orden ASC, op.Orden
--ORDER BY CASE WHEN ISNULL(op.Orden,0) = 0 THEN te.Orden ELSE op.Orden END ASC

GO
/*end*/

USE BelcorpGuatemala
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.ListarEstrategiasODD'))
BEGIN
    DROP PROCEDURE dbo.ListarEstrategiasODD
END

GO

CREATE PROCEDURE [dbo].[ListarEstrategiasODD]
(
	@CodCampania INT,
	@ConsultoraID INT
)
AS

--SET @CodCampania = 201616

SELECT TOP 1
	e.EstrategiaID,
	e.CUV2,
	e.DescripcionCUV2,
	--dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
	e.Precio,
	--dbo.ObtenerDescripcionEtiqueta(EtiquetaID2) EtiquetaDescripcion2,
	e.Precio2,
	--e.TextoLibre,
	--e.FlagEstrella,
	--e.ColorFondo,
	e.TipoEstrategiaID,
	e.ImagenURL AS FotoProducto01,
	te.ImagenEstrategia AS ImagenURL,
	e.LimiteVenta,    
	pc.MarcaID,
	--te.Orden as Orden1,
	--op.Orden as Orden2,
	pc.IndicadorMontoMinimo,
	pc.CodigoProducto,
	0 AS FlagNueva, -- R2621
	--dbo.fn_ObtenerTallaColorCuv_SB2(E.CUV2,@CampaniaID) as TipoTallaColor,
	6 AS TipoEstrategiaImagenMostrar	--Oferta del dia
	--, E.EtiquetaID		-- SB20-351
	--, E.EtiquetaID2		-- SB20-351
FROM TipoEstrategia te
INNER JOIN Estrategia e ON te.TipoEstrategiaID = e.TipoEstrategiaID
INNER JOIN ods.Campania ca ON e.CampaniaID = ca.Codigo
INNER JOIN ods.OfertasPersonalizadas op ON ca.Codigo = op.AnioCampanaVenta
	AND e.CUV2 = op.CUV 
	AND op.TipoPersonalizacion = 'ODD'
INNER JOIN ods.Consultora c ON op.CodConsultora = c.Codigo
INNER JOIN ods.ProductoComercial pc ON ca.CampaniaID = pc.CampaniaID 
	AND e.CUV2 = pc.CUV
WHERE
	e.Activo = 1
	AND te.FlagActivo = 1
	AND te.flagRecoPerfil = 1
	AND ca.Codigo = @CodCampania
	AND c.ConsultoraID = @ConsultoraID
	AND te.TipoEstrategiaID = 7
	--AND e.Zona LIKE '%' + @ZonaID + '%'
	--AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
--ORDER BY te.Orden ASC, op.Orden
--ORDER BY CASE WHEN ISNULL(op.Orden,0) = 0 THEN te.Orden ELSE op.Orden END ASC

GO
/*end*/

USE BelcorpPanama
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.ListarEstrategiasODD'))
BEGIN
    DROP PROCEDURE dbo.ListarEstrategiasODD
END

GO

CREATE PROCEDURE [dbo].[ListarEstrategiasODD]
(
	@CodCampania INT,
	@ConsultoraID INT
)
AS

--SET @CodCampania = 201616

SELECT TOP 1
	e.EstrategiaID,
	e.CUV2,
	e.DescripcionCUV2,
	--dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
	e.Precio,
	--dbo.ObtenerDescripcionEtiqueta(EtiquetaID2) EtiquetaDescripcion2,
	e.Precio2,
	--e.TextoLibre,
	--e.FlagEstrella,
	--e.ColorFondo,
	e.TipoEstrategiaID,
	e.ImagenURL AS FotoProducto01,
	te.ImagenEstrategia AS ImagenURL,
	e.LimiteVenta,    
	pc.MarcaID,
	--te.Orden as Orden1,
	--op.Orden as Orden2,
	pc.IndicadorMontoMinimo,
	pc.CodigoProducto,
	0 AS FlagNueva, -- R2621
	--dbo.fn_ObtenerTallaColorCuv_SB2(E.CUV2,@CampaniaID) as TipoTallaColor,
	6 AS TipoEstrategiaImagenMostrar	--Oferta del dia
	--, E.EtiquetaID		-- SB20-351
	--, E.EtiquetaID2		-- SB20-351
FROM TipoEstrategia te
INNER JOIN Estrategia e ON te.TipoEstrategiaID = e.TipoEstrategiaID
INNER JOIN ods.Campania ca ON e.CampaniaID = ca.Codigo
INNER JOIN ods.OfertasPersonalizadas op ON ca.Codigo = op.AnioCampanaVenta
	AND e.CUV2 = op.CUV 
	AND op.TipoPersonalizacion = 'ODD'
INNER JOIN ods.Consultora c ON op.CodConsultora = c.Codigo
INNER JOIN ods.ProductoComercial pc ON ca.CampaniaID = pc.CampaniaID 
	AND e.CUV2 = pc.CUV
WHERE
	e.Activo = 1
	AND te.FlagActivo = 1
	AND te.flagRecoPerfil = 1
	AND ca.Codigo = @CodCampania
	AND c.ConsultoraID = @ConsultoraID
	AND te.TipoEstrategiaID = 1004
	--AND e.Zona LIKE '%' + @ZonaID + '%'
	--AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
--ORDER BY te.Orden ASC, op.Orden
--ORDER BY CASE WHEN ISNULL(op.Orden,0) = 0 THEN te.Orden ELSE op.Orden END ASC

GO
/*end*/

USE BelcorpPuertoRico
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.ListarEstrategiasODD'))
BEGIN
    DROP PROCEDURE dbo.ListarEstrategiasODD
END

GO

CREATE PROCEDURE [dbo].[ListarEstrategiasODD]
(
	@CodCampania INT,
	@ConsultoraID INT
)
AS

--SET @CodCampania = 201616

SELECT TOP 1
	e.EstrategiaID,
	e.CUV2,
	e.DescripcionCUV2,
	--dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
	e.Precio,
	--dbo.ObtenerDescripcionEtiqueta(EtiquetaID2) EtiquetaDescripcion2,
	e.Precio2,
	--e.TextoLibre,
	--e.FlagEstrella,
	--e.ColorFondo,
	e.TipoEstrategiaID,
	e.ImagenURL AS FotoProducto01,
	te.ImagenEstrategia AS ImagenURL,
	e.LimiteVenta,    
	pc.MarcaID,
	--te.Orden as Orden1,
	--op.Orden as Orden2,
	pc.IndicadorMontoMinimo,
	pc.CodigoProducto,
	0 AS FlagNueva, -- R2621
	--dbo.fn_ObtenerTallaColorCuv_SB2(E.CUV2,@CampaniaID) as TipoTallaColor,
	6 AS TipoEstrategiaImagenMostrar	--Oferta del dia
	--, E.EtiquetaID		-- SB20-351
	--, E.EtiquetaID2		-- SB20-351
FROM TipoEstrategia te
INNER JOIN Estrategia e ON te.TipoEstrategiaID = e.TipoEstrategiaID
INNER JOIN ods.Campania ca ON e.CampaniaID = ca.Codigo
INNER JOIN ods.OfertasPersonalizadas op ON ca.Codigo = op.AnioCampanaVenta
	AND e.CUV2 = op.CUV 
	AND op.TipoPersonalizacion = 'ODD'
INNER JOIN ods.Consultora c ON op.CodConsultora = c.Codigo
INNER JOIN ods.ProductoComercial pc ON ca.CampaniaID = pc.CampaniaID 
	AND e.CUV2 = pc.CUV
WHERE
	e.Activo = 1
	AND te.FlagActivo = 1
	AND te.flagRecoPerfil = 1
	AND ca.Codigo = @CodCampania
	AND c.ConsultoraID = @ConsultoraID
	AND te.TipoEstrategiaID = 6
	--AND e.Zona LIKE '%' + @ZonaID + '%'
	--AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
--ORDER BY te.Orden ASC, op.Orden
--ORDER BY CASE WHEN ISNULL(op.Orden,0) = 0 THEN te.Orden ELSE op.Orden END ASC

GO
/*end*/

USE BelcorpSalvador
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.ListarEstrategiasODD'))
BEGIN
    DROP PROCEDURE dbo.ListarEstrategiasODD
END

GO

CREATE PROCEDURE [dbo].[ListarEstrategiasODD]
(
	@CodCampania INT,
	@ConsultoraID INT
)
AS

--SET @CodCampania = 201616

SELECT TOP 1
	e.EstrategiaID,
	e.CUV2,
	e.DescripcionCUV2,
	--dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
	e.Precio,
	--dbo.ObtenerDescripcionEtiqueta(EtiquetaID2) EtiquetaDescripcion2,
	e.Precio2,
	--e.TextoLibre,
	--e.FlagEstrella,
	--e.ColorFondo,
	e.TipoEstrategiaID,
	e.ImagenURL AS FotoProducto01,
	te.ImagenEstrategia AS ImagenURL,
	e.LimiteVenta,    
	pc.MarcaID,
	--te.Orden as Orden1,
	--op.Orden as Orden2,
	pc.IndicadorMontoMinimo,
	pc.CodigoProducto,
	0 AS FlagNueva, -- R2621
	--dbo.fn_ObtenerTallaColorCuv_SB2(E.CUV2,@CampaniaID) as TipoTallaColor,
	6 AS TipoEstrategiaImagenMostrar	--Oferta del dia
	--, E.EtiquetaID		-- SB20-351
	--, E.EtiquetaID2		-- SB20-351
FROM TipoEstrategia te
INNER JOIN Estrategia e ON te.TipoEstrategiaID = e.TipoEstrategiaID
INNER JOIN ods.Campania ca ON e.CampaniaID = ca.Codigo
INNER JOIN ods.OfertasPersonalizadas op ON ca.Codigo = op.AnioCampanaVenta
	AND e.CUV2 = op.CUV 
	AND op.TipoPersonalizacion = 'ODD'
INNER JOIN ods.Consultora c ON op.CodConsultora = c.Codigo
INNER JOIN ods.ProductoComercial pc ON ca.CampaniaID = pc.CampaniaID 
	AND e.CUV2 = pc.CUV
WHERE
	e.Activo = 1
	AND te.FlagActivo = 1
	AND te.flagRecoPerfil = 1
	AND ca.Codigo = @CodCampania
	AND c.ConsultoraID = @ConsultoraID
	AND te.TipoEstrategiaID = 6
	--AND e.Zona LIKE '%' + @ZonaID + '%'
	--AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
--ORDER BY te.Orden ASC, op.Orden
--ORDER BY CASE WHEN ISNULL(op.Orden,0) = 0 THEN te.Orden ELSE op.Orden END ASC

GO
/*end*/

USE BelcorpVenezuela
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.ListarEstrategiasODD'))
BEGIN
    DROP PROCEDURE dbo.ListarEstrategiasODD
END

GO

CREATE PROCEDURE [dbo].[ListarEstrategiasODD]
(
	@CodCampania INT,
	@ConsultoraID INT
)
AS

--SET @CodCampania = 201616

SELECT TOP 1
	e.EstrategiaID,
	e.CUV2,
	e.DescripcionCUV2,
	--dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,
	e.Precio,
	--dbo.ObtenerDescripcionEtiqueta(EtiquetaID2) EtiquetaDescripcion2,
	e.Precio2,
	--e.TextoLibre,
	--e.FlagEstrella,
	--e.ColorFondo,
	e.TipoEstrategiaID,
	e.ImagenURL AS FotoProducto01,
	te.ImagenEstrategia AS ImagenURL,
	e.LimiteVenta,    
	pc.MarcaID,
	--te.Orden as Orden1,
	--op.Orden as Orden2,
	pc.IndicadorMontoMinimo,
	pc.CodigoProducto,
	0 AS FlagNueva, -- R2621
	--dbo.fn_ObtenerTallaColorCuv_SB2(E.CUV2,@CampaniaID) as TipoTallaColor,
	6 AS TipoEstrategiaImagenMostrar	--Oferta del dia
	--, E.EtiquetaID		-- SB20-351
	--, E.EtiquetaID2		-- SB20-351
FROM TipoEstrategia te
INNER JOIN Estrategia e ON te.TipoEstrategiaID = e.TipoEstrategiaID
INNER JOIN ods.Campania ca ON e.CampaniaID = ca.Codigo
INNER JOIN ods.OfertasPersonalizadas op ON ca.Codigo = op.AnioCampanaVenta
	AND e.CUV2 = op.CUV 
	AND op.TipoPersonalizacion = 'ODD'
INNER JOIN ods.Consultora c ON op.CodConsultora = c.Codigo
INNER JOIN ods.ProductoComercial pc ON ca.CampaniaID = pc.CampaniaID 
	AND e.CUV2 = pc.CUV
WHERE
	e.Activo = 1
	AND te.FlagActivo = 1
	AND te.flagRecoPerfil = 1
	AND ca.Codigo = @CodCampania
	AND c.ConsultoraID = @ConsultoraID
	AND te.TipoEstrategiaID = 5
	--AND e.Zona LIKE '%' + @ZonaID + '%'
	--AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
--ORDER BY te.Orden ASC, op.Orden
--ORDER BY CASE WHEN ISNULL(op.Orden,0) = 0 THEN te.Orden ELSE op.Orden END ASC

GO

