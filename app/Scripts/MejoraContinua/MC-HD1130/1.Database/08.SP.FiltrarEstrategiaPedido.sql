USE BelcorpPeru
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.FiltrarEstrategiaPedido'))
BEGIN
    DROP PROCEDURE dbo.FiltrarEstrategiaPedido
END
GO

CREATE PROCEDURE FiltrarEstrategiaPedido  
 @EstrategiaID INT,  
 @FlagNueva INT = 0  
AS  
BEGIN  
/*  
 FiltrarEstrategiaPedido 11164  
*/  
 SET NOCOUNT ON  
  
  /*R2621-LR - INI **/  
  DECLARE  @CampaniaID  INT  
  SELECT @CampaniaID  = E.CampaniaID  
  FROM Estrategia E  
   INNER JOIN TipoEstrategia TE ON E.TipoEstrategiaID = TE.TipoEstrategiaID  
   INNER JOIN ods.Campania CA ON E.CampaniaID = CA.Codigo  
  WHERE  
   EstrategiaID = @EstrategiaID  
  
  DECLARE @ActivacionProgramaNuevas SMALLINT  
  DECLARE @TablaLogicaID SMALLINT  
  DECLARE @ProgramaNuevoActivado INT   
  DECLARE @ProgramaCampaniaActivado INT  
  
  SET  @TablaLogicaID = 61  
  SET  @ActivacionProgramaNuevas = 6101  
  
  SELECT @ProgramaNuevoActivado = COUNT(TD.TablaLogicaID)  
  FROM TablaLogicaDatos  TD  
  WHERE TD.TablaLogicaID = @TablaLogicaID    
    AND TD.TablaLogicaDatosID = @ActivacionProgramaNuevas  
    AND CAST(TD.Codigo AS VARCHAR(10)) = 1  
  
  IF @ProgramaNuevoActivado  > 0   
  BEGIN  
   SELECT @ProgramaCampaniaActivado = COUNT(TD.TablaLogicaID)  
   FROM TablaLogicaDatos  TD  
   WHERE TD.TablaLogicaID = @TablaLogicaID    
     AND CAST(TD.Codigo AS VARCHAR(10)) <= @CampaniaID -- CGI(AHAA) - MODIFICACIÓN AL BUG BUG_2015000858  
  END      
  /*R2621-LR - FIN **/  
  SELECT  
   EstrategiaID,   
   CUV2,   
   DescripcionCUV2,   
   dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,   
   E.Precio,  
   dbo.ObtenerDescripcionEtiqueta(EtiquetaID2) EtiquetaDescripcion2,   
   Precio2,  
   TextoLibre,   
   FlagEstrella,   
   ColorFondo,  
   e.TipoEstrategiaID,  
   e.ImagenURL FotoProducto01,  
   te.ImagenEstrategia ImagenURL,  
   e.LimiteVenta,  
   pc.MarcaID,  
   dbo.FiltrarTallaColorCUV(CUV2, E.CampaniaID) TallaColor,  
   pc.IndicadorMontoMinimo,  
   O.TipoOferta,  
   M.Descripcion as DescripcionMarca, --R2469
   'NO DISPONIBLE' AS DescripcionCategoria,
   TE.DescripcionEstrategia AS DescripcionEstrategia,
   @FlagNueva  AS FlagNueva,
   E.EsOfertaIndependiente 
  FROM   
   Estrategia E  
   INNER JOIN TipoEstrategia TE ON E.TipoEstrategiaID = TE.TipoEstrategiaID  
   INNER JOIN ods.Campania CA ON E.CampaniaID = CA.Codigo  
   INNER JOIN ods.ProductoComercial PC ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2  
   LEFT JOIN Oferta O ON O.CODIGOOFERTA = PC.CodigoTipoOferta     
   --LEFT JOIN ODS.SAP_PRODUCTO PRO ON PC.CodigoProducto=PRO.CodigoSap
   --LEFT JOIN ODS.SAP_MARCA MAR ON MAR.Codigo = PRO.CodigoMarca
   --LEFT JOIN ODS.SAP_CATEGORIA CAT ON CAT.CodigoCategoria=PRO.CodigoCategoria
   LEFT JOIN Marca M on PC.MarcaId = M.MarcaId  
  WHERE  
   EstrategiaID = @EstrategiaID  
  
 SET NOCOUNT OFF  
  
END  




GO

USE BelcorpMexico
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.FiltrarEstrategiaPedido'))
BEGIN
    DROP PROCEDURE dbo.FiltrarEstrategiaPedido
END
GO

CREATE PROCEDURE FiltrarEstrategiaPedido  
 @EstrategiaID INT,  
 @FlagNueva INT = 0  
AS  
BEGIN  
/*  
 FiltrarEstrategiaPedido 11164  
*/  
 SET NOCOUNT ON  
  
  /*R2621-LR - INI **/  
  DECLARE  @CampaniaID  INT  
  SELECT @CampaniaID  = E.CampaniaID  
  FROM Estrategia E  
   INNER JOIN TipoEstrategia TE ON E.TipoEstrategiaID = TE.TipoEstrategiaID  
   INNER JOIN ods.Campania CA ON E.CampaniaID = CA.Codigo  
  WHERE  
   EstrategiaID = @EstrategiaID  
  
  DECLARE @ActivacionProgramaNuevas SMALLINT  
  DECLARE @TablaLogicaID SMALLINT  
  DECLARE @ProgramaNuevoActivado INT   
  DECLARE @ProgramaCampaniaActivado INT  
  
  SET  @TablaLogicaID = 61  
  SET  @ActivacionProgramaNuevas = 6101  
  
  SELECT @ProgramaNuevoActivado = COUNT(TD.TablaLogicaID)  
  FROM TablaLogicaDatos  TD  
  WHERE TD.TablaLogicaID = @TablaLogicaID    
    AND TD.TablaLogicaDatosID = @ActivacionProgramaNuevas  
    AND CAST(TD.Codigo AS VARCHAR(10)) = 1  
  
  IF @ProgramaNuevoActivado  > 0   
  BEGIN  
   SELECT @ProgramaCampaniaActivado = COUNT(TD.TablaLogicaID)  
   FROM TablaLogicaDatos  TD  
   WHERE TD.TablaLogicaID = @TablaLogicaID    
     AND CAST(TD.Codigo AS VARCHAR(10)) <= @CampaniaID -- CGI(AHAA) - MODIFICACIÓN AL BUG BUG_2015000858  
  END      
  /*R2621-LR - FIN **/  
  SELECT  
   EstrategiaID,   
   CUV2,   
   DescripcionCUV2,   
   dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,   
   E.Precio,  
   dbo.ObtenerDescripcionEtiqueta(EtiquetaID2) EtiquetaDescripcion2,   
   Precio2,  
   TextoLibre,   
   FlagEstrella,   
   ColorFondo,  
   e.TipoEstrategiaID,  
   e.ImagenURL FotoProducto01,  
   te.ImagenEstrategia ImagenURL,  
   e.LimiteVenta,  
   pc.MarcaID,  
   dbo.FiltrarTallaColorCUV(CUV2, E.CampaniaID) TallaColor,  
   pc.IndicadorMontoMinimo,  
   O.TipoOferta,  
   M.Descripcion as DescripcionMarca, --R2469
   'NO DISPONIBLE' AS DescripcionCategoria,
   TE.DescripcionEstrategia AS DescripcionEstrategia,
   @FlagNueva  AS FlagNueva,
   E.EsOfertaIndependiente 
  FROM   
   Estrategia E  
   INNER JOIN TipoEstrategia TE ON E.TipoEstrategiaID = TE.TipoEstrategiaID  
   INNER JOIN ods.Campania CA ON E.CampaniaID = CA.Codigo  
   INNER JOIN ods.ProductoComercial PC ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2  
   LEFT JOIN Oferta O ON O.CODIGOOFERTA = PC.CodigoTipoOferta     
   --LEFT JOIN ODS.SAP_PRODUCTO PRO ON PC.CodigoProducto=PRO.CodigoSap
   --LEFT JOIN ODS.SAP_MARCA MAR ON MAR.Codigo = PRO.CodigoMarca
   --LEFT JOIN ODS.SAP_CATEGORIA CAT ON CAT.CodigoCategoria=PRO.CodigoCategoria
   LEFT JOIN Marca M on PC.MarcaId = M.MarcaId  
  WHERE  
   EstrategiaID = @EstrategiaID  
  
 SET NOCOUNT OFF  
  
END  




GO

USE BelcorpColombia
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.FiltrarEstrategiaPedido'))
BEGIN
    DROP PROCEDURE dbo.FiltrarEstrategiaPedido
END
GO

CREATE PROCEDURE FiltrarEstrategiaPedido  
 @EstrategiaID INT,  
 @FlagNueva INT = 0  
AS  
BEGIN  
/*  
 FiltrarEstrategiaPedido 11164  
*/  
 SET NOCOUNT ON  
  
  /*R2621-LR - INI **/  
  DECLARE  @CampaniaID  INT  
  SELECT @CampaniaID  = E.CampaniaID  
  FROM Estrategia E  
   INNER JOIN TipoEstrategia TE ON E.TipoEstrategiaID = TE.TipoEstrategiaID  
   INNER JOIN ods.Campania CA ON E.CampaniaID = CA.Codigo  
  WHERE  
   EstrategiaID = @EstrategiaID  
  
  DECLARE @ActivacionProgramaNuevas SMALLINT  
  DECLARE @TablaLogicaID SMALLINT  
  DECLARE @ProgramaNuevoActivado INT   
  DECLARE @ProgramaCampaniaActivado INT  
  
  SET  @TablaLogicaID = 61  
  SET  @ActivacionProgramaNuevas = 6101  
  
  SELECT @ProgramaNuevoActivado = COUNT(TD.TablaLogicaID)  
  FROM TablaLogicaDatos  TD  
  WHERE TD.TablaLogicaID = @TablaLogicaID    
    AND TD.TablaLogicaDatosID = @ActivacionProgramaNuevas  
    AND CAST(TD.Codigo AS VARCHAR(10)) = 1  
  
  IF @ProgramaNuevoActivado  > 0   
  BEGIN  
   SELECT @ProgramaCampaniaActivado = COUNT(TD.TablaLogicaID)  
   FROM TablaLogicaDatos  TD  
   WHERE TD.TablaLogicaID = @TablaLogicaID    
     AND CAST(TD.Codigo AS VARCHAR(10)) <= @CampaniaID -- CGI(AHAA) - MODIFICACIÓN AL BUG BUG_2015000858  
  END      
  /*R2621-LR - FIN **/  
  SELECT  
   EstrategiaID,   
   CUV2,   
   DescripcionCUV2,   
   dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,   
   E.Precio,  
   dbo.ObtenerDescripcionEtiqueta(EtiquetaID2) EtiquetaDescripcion2,   
   Precio2,  
   TextoLibre,   
   FlagEstrella,   
   ColorFondo,  
   e.TipoEstrategiaID,  
   e.ImagenURL FotoProducto01,  
   te.ImagenEstrategia ImagenURL,  
   e.LimiteVenta,  
   pc.MarcaID,  
   dbo.FiltrarTallaColorCUV(CUV2, E.CampaniaID) TallaColor,  
   pc.IndicadorMontoMinimo,  
   O.TipoOferta,  
   M.Descripcion as DescripcionMarca, --R2469
   'NO DISPONIBLE' AS DescripcionCategoria,
   TE.DescripcionEstrategia AS DescripcionEstrategia,
   @FlagNueva  AS FlagNueva,
   E.EsOfertaIndependiente 
  FROM   
   Estrategia E  
   INNER JOIN TipoEstrategia TE ON E.TipoEstrategiaID = TE.TipoEstrategiaID  
   INNER JOIN ods.Campania CA ON E.CampaniaID = CA.Codigo  
   INNER JOIN ods.ProductoComercial PC ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2  
   LEFT JOIN Oferta O ON O.CODIGOOFERTA = PC.CodigoTipoOferta     
   --LEFT JOIN ODS.SAP_PRODUCTO PRO ON PC.CodigoProducto=PRO.CodigoSap
   --LEFT JOIN ODS.SAP_MARCA MAR ON MAR.Codigo = PRO.CodigoMarca
   --LEFT JOIN ODS.SAP_CATEGORIA CAT ON CAT.CodigoCategoria=PRO.CodigoCategoria
   LEFT JOIN Marca M on PC.MarcaId = M.MarcaId  
  WHERE  
   EstrategiaID = @EstrategiaID  
  
 SET NOCOUNT OFF  
  
END  




GO

USE BelcorpVenezuela
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.FiltrarEstrategiaPedido'))
BEGIN
    DROP PROCEDURE dbo.FiltrarEstrategiaPedido
END
GO

CREATE PROCEDURE FiltrarEstrategiaPedido  
 @EstrategiaID INT,  
 @FlagNueva INT = 0  
AS  
BEGIN  
/*  
 FiltrarEstrategiaPedido 11164  
*/  
 SET NOCOUNT ON  
  
  /*R2621-LR - INI **/  
  DECLARE  @CampaniaID  INT  
  SELECT @CampaniaID  = E.CampaniaID  
  FROM Estrategia E  
   INNER JOIN TipoEstrategia TE ON E.TipoEstrategiaID = TE.TipoEstrategiaID  
   INNER JOIN ods.Campania CA ON E.CampaniaID = CA.Codigo  
  WHERE  
   EstrategiaID = @EstrategiaID  
  
  DECLARE @ActivacionProgramaNuevas SMALLINT  
  DECLARE @TablaLogicaID SMALLINT  
  DECLARE @ProgramaNuevoActivado INT   
  DECLARE @ProgramaCampaniaActivado INT  
  
  SET  @TablaLogicaID = 61  
  SET  @ActivacionProgramaNuevas = 6101  
  
  SELECT @ProgramaNuevoActivado = COUNT(TD.TablaLogicaID)  
  FROM TablaLogicaDatos  TD  
  WHERE TD.TablaLogicaID = @TablaLogicaID    
    AND TD.TablaLogicaDatosID = @ActivacionProgramaNuevas  
    AND CAST(TD.Codigo AS VARCHAR(10)) = 1  
  
  IF @ProgramaNuevoActivado  > 0   
  BEGIN  
   SELECT @ProgramaCampaniaActivado = COUNT(TD.TablaLogicaID)  
   FROM TablaLogicaDatos  TD  
   WHERE TD.TablaLogicaID = @TablaLogicaID    
     AND CAST(TD.Codigo AS VARCHAR(10)) <= @CampaniaID -- CGI(AHAA) - MODIFICACIÓN AL BUG BUG_2015000858  
  END      
  /*R2621-LR - FIN **/  
  SELECT  
   EstrategiaID,   
   CUV2,   
   DescripcionCUV2,   
   dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,   
   E.Precio,  
   dbo.ObtenerDescripcionEtiqueta(EtiquetaID2) EtiquetaDescripcion2,   
   Precio2,  
   TextoLibre,   
   FlagEstrella,   
   ColorFondo,  
   e.TipoEstrategiaID,  
   e.ImagenURL FotoProducto01,  
   te.ImagenEstrategia ImagenURL,  
   e.LimiteVenta,  
   pc.MarcaID,  
   dbo.FiltrarTallaColorCUV(CUV2, E.CampaniaID) TallaColor,  
   pc.IndicadorMontoMinimo,  
   O.TipoOferta,  
   M.Descripcion as DescripcionMarca, --R2469
   'NO DISPONIBLE' AS DescripcionCategoria,
   TE.DescripcionEstrategia AS DescripcionEstrategia,
   @FlagNueva  AS FlagNueva,
   E.EsOfertaIndependiente 
  FROM   
   Estrategia E  
   INNER JOIN TipoEstrategia TE ON E.TipoEstrategiaID = TE.TipoEstrategiaID  
   INNER JOIN ods.Campania CA ON E.CampaniaID = CA.Codigo  
   INNER JOIN ods.ProductoComercial PC ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2  
   LEFT JOIN Oferta O ON O.CODIGOOFERTA = PC.CodigoTipoOferta     
   --LEFT JOIN ODS.SAP_PRODUCTO PRO ON PC.CodigoProducto=PRO.CodigoSap
   --LEFT JOIN ODS.SAP_MARCA MAR ON MAR.Codigo = PRO.CodigoMarca
   --LEFT JOIN ODS.SAP_CATEGORIA CAT ON CAT.CodigoCategoria=PRO.CodigoCategoria
   LEFT JOIN Marca M on PC.MarcaId = M.MarcaId  
  WHERE  
   EstrategiaID = @EstrategiaID  
  
 SET NOCOUNT OFF  
  
END  




GO

USE BelcorpSalvador
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.FiltrarEstrategiaPedido'))
BEGIN
    DROP PROCEDURE dbo.FiltrarEstrategiaPedido
END
GO

CREATE PROCEDURE FiltrarEstrategiaPedido  
 @EstrategiaID INT,  
 @FlagNueva INT = 0  
AS  
BEGIN  
/*  
 FiltrarEstrategiaPedido 11164  
*/  
 SET NOCOUNT ON  
  
  /*R2621-LR - INI **/  
  DECLARE  @CampaniaID  INT  
  SELECT @CampaniaID  = E.CampaniaID  
  FROM Estrategia E  
   INNER JOIN TipoEstrategia TE ON E.TipoEstrategiaID = TE.TipoEstrategiaID  
   INNER JOIN ods.Campania CA ON E.CampaniaID = CA.Codigo  
  WHERE  
   EstrategiaID = @EstrategiaID  
  
  DECLARE @ActivacionProgramaNuevas SMALLINT  
  DECLARE @TablaLogicaID SMALLINT  
  DECLARE @ProgramaNuevoActivado INT   
  DECLARE @ProgramaCampaniaActivado INT  
  
  SET  @TablaLogicaID = 61  
  SET  @ActivacionProgramaNuevas = 6101  
  
  SELECT @ProgramaNuevoActivado = COUNT(TD.TablaLogicaID)  
  FROM TablaLogicaDatos  TD  
  WHERE TD.TablaLogicaID = @TablaLogicaID    
    AND TD.TablaLogicaDatosID = @ActivacionProgramaNuevas  
    AND CAST(TD.Codigo AS VARCHAR(10)) = 1  
  
  IF @ProgramaNuevoActivado  > 0   
  BEGIN  
   SELECT @ProgramaCampaniaActivado = COUNT(TD.TablaLogicaID)  
   FROM TablaLogicaDatos  TD  
   WHERE TD.TablaLogicaID = @TablaLogicaID    
     AND CAST(TD.Codigo AS VARCHAR(10)) <= @CampaniaID -- CGI(AHAA) - MODIFICACIÓN AL BUG BUG_2015000858  
  END      
  /*R2621-LR - FIN **/  
  SELECT  
   EstrategiaID,   
   CUV2,   
   DescripcionCUV2,   
   dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,   
   E.Precio,  
   dbo.ObtenerDescripcionEtiqueta(EtiquetaID2) EtiquetaDescripcion2,   
   Precio2,  
   TextoLibre,   
   FlagEstrella,   
   ColorFondo,  
   e.TipoEstrategiaID,  
   e.ImagenURL FotoProducto01,  
   te.ImagenEstrategia ImagenURL,  
   e.LimiteVenta,  
   pc.MarcaID,  
   dbo.FiltrarTallaColorCUV(CUV2, E.CampaniaID) TallaColor,  
   pc.IndicadorMontoMinimo,  
   O.TipoOferta,  
   M.Descripcion as DescripcionMarca, --R2469
   'NO DISPONIBLE' AS DescripcionCategoria,
   TE.DescripcionEstrategia AS DescripcionEstrategia,
   @FlagNueva  AS FlagNueva,
   E.EsOfertaIndependiente 
  FROM   
   Estrategia E  
   INNER JOIN TipoEstrategia TE ON E.TipoEstrategiaID = TE.TipoEstrategiaID  
   INNER JOIN ods.Campania CA ON E.CampaniaID = CA.Codigo  
   INNER JOIN ods.ProductoComercial PC ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2  
   LEFT JOIN Oferta O ON O.CODIGOOFERTA = PC.CodigoTipoOferta     
   --LEFT JOIN ODS.SAP_PRODUCTO PRO ON PC.CodigoProducto=PRO.CodigoSap
   --LEFT JOIN ODS.SAP_MARCA MAR ON MAR.Codigo = PRO.CodigoMarca
   --LEFT JOIN ODS.SAP_CATEGORIA CAT ON CAT.CodigoCategoria=PRO.CodigoCategoria
   LEFT JOIN Marca M on PC.MarcaId = M.MarcaId  
  WHERE  
   EstrategiaID = @EstrategiaID  
  
 SET NOCOUNT OFF  
  
END  




GO

USE BelcorpPuertoRico
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.FiltrarEstrategiaPedido'))
BEGIN
    DROP PROCEDURE dbo.FiltrarEstrategiaPedido
END
GO

CREATE PROCEDURE FiltrarEstrategiaPedido  
 @EstrategiaID INT,  
 @FlagNueva INT = 0  
AS  
BEGIN  
/*  
 FiltrarEstrategiaPedido 11164  
*/  
 SET NOCOUNT ON  
  
  /*R2621-LR - INI **/  
  DECLARE  @CampaniaID  INT  
  SELECT @CampaniaID  = E.CampaniaID  
  FROM Estrategia E  
   INNER JOIN TipoEstrategia TE ON E.TipoEstrategiaID = TE.TipoEstrategiaID  
   INNER JOIN ods.Campania CA ON E.CampaniaID = CA.Codigo  
  WHERE  
   EstrategiaID = @EstrategiaID  
  
  DECLARE @ActivacionProgramaNuevas SMALLINT  
  DECLARE @TablaLogicaID SMALLINT  
  DECLARE @ProgramaNuevoActivado INT   
  DECLARE @ProgramaCampaniaActivado INT  
  
  SET  @TablaLogicaID = 61  
  SET  @ActivacionProgramaNuevas = 6101  
  
  SELECT @ProgramaNuevoActivado = COUNT(TD.TablaLogicaID)  
  FROM TablaLogicaDatos  TD  
  WHERE TD.TablaLogicaID = @TablaLogicaID    
    AND TD.TablaLogicaDatosID = @ActivacionProgramaNuevas  
    AND CAST(TD.Codigo AS VARCHAR(10)) = 1  
  
  IF @ProgramaNuevoActivado  > 0   
  BEGIN  
   SELECT @ProgramaCampaniaActivado = COUNT(TD.TablaLogicaID)  
   FROM TablaLogicaDatos  TD  
   WHERE TD.TablaLogicaID = @TablaLogicaID    
     AND CAST(TD.Codigo AS VARCHAR(10)) <= @CampaniaID -- CGI(AHAA) - MODIFICACIÓN AL BUG BUG_2015000858  
  END      
  /*R2621-LR - FIN **/  
  SELECT  
   EstrategiaID,   
   CUV2,   
   DescripcionCUV2,   
   dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,   
   E.Precio,  
   dbo.ObtenerDescripcionEtiqueta(EtiquetaID2) EtiquetaDescripcion2,   
   Precio2,  
   TextoLibre,   
   FlagEstrella,   
   ColorFondo,  
   e.TipoEstrategiaID,  
   e.ImagenURL FotoProducto01,  
   te.ImagenEstrategia ImagenURL,  
   e.LimiteVenta,  
   pc.MarcaID,  
   dbo.FiltrarTallaColorCUV(CUV2, E.CampaniaID) TallaColor,  
   pc.IndicadorMontoMinimo,  
   O.TipoOferta,  
   M.Descripcion as DescripcionMarca, --R2469
   'NO DISPONIBLE' AS DescripcionCategoria,
   TE.DescripcionEstrategia AS DescripcionEstrategia,
   @FlagNueva  AS FlagNueva,
   E.EsOfertaIndependiente 
  FROM   
   Estrategia E  
   INNER JOIN TipoEstrategia TE ON E.TipoEstrategiaID = TE.TipoEstrategiaID  
   INNER JOIN ods.Campania CA ON E.CampaniaID = CA.Codigo  
   INNER JOIN ods.ProductoComercial PC ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2  
   LEFT JOIN Oferta O ON O.CODIGOOFERTA = PC.CodigoTipoOferta     
   --LEFT JOIN ODS.SAP_PRODUCTO PRO ON PC.CodigoProducto=PRO.CodigoSap
   --LEFT JOIN ODS.SAP_MARCA MAR ON MAR.Codigo = PRO.CodigoMarca
   --LEFT JOIN ODS.SAP_CATEGORIA CAT ON CAT.CodigoCategoria=PRO.CodigoCategoria
   LEFT JOIN Marca M on PC.MarcaId = M.MarcaId  
  WHERE  
   EstrategiaID = @EstrategiaID  
  
 SET NOCOUNT OFF  
  
END  




GO

USE BelcorpPanama
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.FiltrarEstrategiaPedido'))
BEGIN
    DROP PROCEDURE dbo.FiltrarEstrategiaPedido
END
GO

CREATE PROCEDURE FiltrarEstrategiaPedido  
 @EstrategiaID INT,  
 @FlagNueva INT = 0  
AS  
BEGIN  
/*  
 FiltrarEstrategiaPedido 11164  
*/  
 SET NOCOUNT ON  
  
  /*R2621-LR - INI **/  
  DECLARE  @CampaniaID  INT  
  SELECT @CampaniaID  = E.CampaniaID  
  FROM Estrategia E  
   INNER JOIN TipoEstrategia TE ON E.TipoEstrategiaID = TE.TipoEstrategiaID  
   INNER JOIN ods.Campania CA ON E.CampaniaID = CA.Codigo  
  WHERE  
   EstrategiaID = @EstrategiaID  
  
  DECLARE @ActivacionProgramaNuevas SMALLINT  
  DECLARE @TablaLogicaID SMALLINT  
  DECLARE @ProgramaNuevoActivado INT   
  DECLARE @ProgramaCampaniaActivado INT  
  
  SET  @TablaLogicaID = 61  
  SET  @ActivacionProgramaNuevas = 6101  
  
  SELECT @ProgramaNuevoActivado = COUNT(TD.TablaLogicaID)  
  FROM TablaLogicaDatos  TD  
  WHERE TD.TablaLogicaID = @TablaLogicaID    
    AND TD.TablaLogicaDatosID = @ActivacionProgramaNuevas  
    AND CAST(TD.Codigo AS VARCHAR(10)) = 1  
  
  IF @ProgramaNuevoActivado  > 0   
  BEGIN  
   SELECT @ProgramaCampaniaActivado = COUNT(TD.TablaLogicaID)  
   FROM TablaLogicaDatos  TD  
   WHERE TD.TablaLogicaID = @TablaLogicaID    
     AND CAST(TD.Codigo AS VARCHAR(10)) <= @CampaniaID -- CGI(AHAA) - MODIFICACIÓN AL BUG BUG_2015000858  
  END      
  /*R2621-LR - FIN **/  
  SELECT  
   EstrategiaID,   
   CUV2,   
   DescripcionCUV2,   
   dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,   
   E.Precio,  
   dbo.ObtenerDescripcionEtiqueta(EtiquetaID2) EtiquetaDescripcion2,   
   Precio2,  
   TextoLibre,   
   FlagEstrella,   
   ColorFondo,  
   e.TipoEstrategiaID,  
   e.ImagenURL FotoProducto01,  
   te.ImagenEstrategia ImagenURL,  
   e.LimiteVenta,  
   pc.MarcaID,  
   dbo.FiltrarTallaColorCUV(CUV2, E.CampaniaID) TallaColor,  
   pc.IndicadorMontoMinimo,  
   O.TipoOferta,  
   M.Descripcion as DescripcionMarca, --R2469
   'NO DISPONIBLE' AS DescripcionCategoria,
   TE.DescripcionEstrategia AS DescripcionEstrategia,
   @FlagNueva  AS FlagNueva,
   E.EsOfertaIndependiente 
  FROM   
   Estrategia E  
   INNER JOIN TipoEstrategia TE ON E.TipoEstrategiaID = TE.TipoEstrategiaID  
   INNER JOIN ods.Campania CA ON E.CampaniaID = CA.Codigo  
   INNER JOIN ods.ProductoComercial PC ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2  
   LEFT JOIN Oferta O ON O.CODIGOOFERTA = PC.CodigoTipoOferta     
   --LEFT JOIN ODS.SAP_PRODUCTO PRO ON PC.CodigoProducto=PRO.CodigoSap
   --LEFT JOIN ODS.SAP_MARCA MAR ON MAR.Codigo = PRO.CodigoMarca
   --LEFT JOIN ODS.SAP_CATEGORIA CAT ON CAT.CodigoCategoria=PRO.CodigoCategoria
   LEFT JOIN Marca M on PC.MarcaId = M.MarcaId  
  WHERE  
   EstrategiaID = @EstrategiaID  
  
 SET NOCOUNT OFF  
  
END  




GO

USE BelcorpGuatemala
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.FiltrarEstrategiaPedido'))
BEGIN
    DROP PROCEDURE dbo.FiltrarEstrategiaPedido
END
GO

CREATE PROCEDURE FiltrarEstrategiaPedido  
 @EstrategiaID INT,  
 @FlagNueva INT = 0  
AS  
BEGIN  
/*  
 FiltrarEstrategiaPedido 11164  
*/  
 SET NOCOUNT ON  
  
  /*R2621-LR - INI **/  
  DECLARE  @CampaniaID  INT  
  SELECT @CampaniaID  = E.CampaniaID  
  FROM Estrategia E  
   INNER JOIN TipoEstrategia TE ON E.TipoEstrategiaID = TE.TipoEstrategiaID  
   INNER JOIN ods.Campania CA ON E.CampaniaID = CA.Codigo  
  WHERE  
   EstrategiaID = @EstrategiaID  
  
  DECLARE @ActivacionProgramaNuevas SMALLINT  
  DECLARE @TablaLogicaID SMALLINT  
  DECLARE @ProgramaNuevoActivado INT   
  DECLARE @ProgramaCampaniaActivado INT  
  
  SET  @TablaLogicaID = 61  
  SET  @ActivacionProgramaNuevas = 6101  
  
  SELECT @ProgramaNuevoActivado = COUNT(TD.TablaLogicaID)  
  FROM TablaLogicaDatos  TD  
  WHERE TD.TablaLogicaID = @TablaLogicaID    
    AND TD.TablaLogicaDatosID = @ActivacionProgramaNuevas  
    AND CAST(TD.Codigo AS VARCHAR(10)) = 1  
  
  IF @ProgramaNuevoActivado  > 0   
  BEGIN  
   SELECT @ProgramaCampaniaActivado = COUNT(TD.TablaLogicaID)  
   FROM TablaLogicaDatos  TD  
   WHERE TD.TablaLogicaID = @TablaLogicaID    
     AND CAST(TD.Codigo AS VARCHAR(10)) <= @CampaniaID -- CGI(AHAA) - MODIFICACIÓN AL BUG BUG_2015000858  
  END      
  /*R2621-LR - FIN **/  
  SELECT  
   EstrategiaID,   
   CUV2,   
   DescripcionCUV2,   
   dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,   
   E.Precio,  
   dbo.ObtenerDescripcionEtiqueta(EtiquetaID2) EtiquetaDescripcion2,   
   Precio2,  
   TextoLibre,   
   FlagEstrella,   
   ColorFondo,  
   e.TipoEstrategiaID,  
   e.ImagenURL FotoProducto01,  
   te.ImagenEstrategia ImagenURL,  
   e.LimiteVenta,  
   pc.MarcaID,  
   dbo.FiltrarTallaColorCUV(CUV2, E.CampaniaID) TallaColor,  
   pc.IndicadorMontoMinimo,  
   O.TipoOferta,  
   M.Descripcion as DescripcionMarca, --R2469
   'NO DISPONIBLE' AS DescripcionCategoria,
   TE.DescripcionEstrategia AS DescripcionEstrategia,
   @FlagNueva  AS FlagNueva,
   E.EsOfertaIndependiente 
  FROM   
   Estrategia E  
   INNER JOIN TipoEstrategia TE ON E.TipoEstrategiaID = TE.TipoEstrategiaID  
   INNER JOIN ods.Campania CA ON E.CampaniaID = CA.Codigo  
   INNER JOIN ods.ProductoComercial PC ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2  
   LEFT JOIN Oferta O ON O.CODIGOOFERTA = PC.CodigoTipoOferta     
   --LEFT JOIN ODS.SAP_PRODUCTO PRO ON PC.CodigoProducto=PRO.CodigoSap
   --LEFT JOIN ODS.SAP_MARCA MAR ON MAR.Codigo = PRO.CodigoMarca
   --LEFT JOIN ODS.SAP_CATEGORIA CAT ON CAT.CodigoCategoria=PRO.CodigoCategoria
   LEFT JOIN Marca M on PC.MarcaId = M.MarcaId  
  WHERE  
   EstrategiaID = @EstrategiaID  
  
 SET NOCOUNT OFF  
  
END  




GO

USE BelcorpEcuador
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.FiltrarEstrategiaPedido'))
BEGIN
    DROP PROCEDURE dbo.FiltrarEstrategiaPedido
END
GO

CREATE PROCEDURE FiltrarEstrategiaPedido  
 @EstrategiaID INT,  
 @FlagNueva INT = 0  
AS  
BEGIN  
/*  
 FiltrarEstrategiaPedido 11164  
*/  
 SET NOCOUNT ON  
  
  /*R2621-LR - INI **/  
  DECLARE  @CampaniaID  INT  
  SELECT @CampaniaID  = E.CampaniaID  
  FROM Estrategia E  
   INNER JOIN TipoEstrategia TE ON E.TipoEstrategiaID = TE.TipoEstrategiaID  
   INNER JOIN ods.Campania CA ON E.CampaniaID = CA.Codigo  
  WHERE  
   EstrategiaID = @EstrategiaID  
  
  DECLARE @ActivacionProgramaNuevas SMALLINT  
  DECLARE @TablaLogicaID SMALLINT  
  DECLARE @ProgramaNuevoActivado INT   
  DECLARE @ProgramaCampaniaActivado INT  
  
  SET  @TablaLogicaID = 61  
  SET  @ActivacionProgramaNuevas = 6101  
  
  SELECT @ProgramaNuevoActivado = COUNT(TD.TablaLogicaID)  
  FROM TablaLogicaDatos  TD  
  WHERE TD.TablaLogicaID = @TablaLogicaID    
    AND TD.TablaLogicaDatosID = @ActivacionProgramaNuevas  
    AND CAST(TD.Codigo AS VARCHAR(10)) = 1  
  
  IF @ProgramaNuevoActivado  > 0   
  BEGIN  
   SELECT @ProgramaCampaniaActivado = COUNT(TD.TablaLogicaID)  
   FROM TablaLogicaDatos  TD  
   WHERE TD.TablaLogicaID = @TablaLogicaID    
     AND CAST(TD.Codigo AS VARCHAR(10)) <= @CampaniaID -- CGI(AHAA) - MODIFICACIÓN AL BUG BUG_2015000858  
  END      
  /*R2621-LR - FIN **/  
  SELECT  
   EstrategiaID,   
   CUV2,   
   DescripcionCUV2,   
   dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,   
   E.Precio,  
   dbo.ObtenerDescripcionEtiqueta(EtiquetaID2) EtiquetaDescripcion2,   
   Precio2,  
   TextoLibre,   
   FlagEstrella,   
   ColorFondo,  
   e.TipoEstrategiaID,  
   e.ImagenURL FotoProducto01,  
   te.ImagenEstrategia ImagenURL,  
   e.LimiteVenta,  
   pc.MarcaID,  
   dbo.FiltrarTallaColorCUV(CUV2, E.CampaniaID) TallaColor,  
   pc.IndicadorMontoMinimo,  
   O.TipoOferta,  
   M.Descripcion as DescripcionMarca, --R2469
   'NO DISPONIBLE' AS DescripcionCategoria,
   TE.DescripcionEstrategia AS DescripcionEstrategia,
   @FlagNueva  AS FlagNueva,
   E.EsOfertaIndependiente 
  FROM   
   Estrategia E  
   INNER JOIN TipoEstrategia TE ON E.TipoEstrategiaID = TE.TipoEstrategiaID  
   INNER JOIN ods.Campania CA ON E.CampaniaID = CA.Codigo  
   INNER JOIN ods.ProductoComercial PC ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2  
   LEFT JOIN Oferta O ON O.CODIGOOFERTA = PC.CodigoTipoOferta     
   --LEFT JOIN ODS.SAP_PRODUCTO PRO ON PC.CodigoProducto=PRO.CodigoSap
   --LEFT JOIN ODS.SAP_MARCA MAR ON MAR.Codigo = PRO.CodigoMarca
   --LEFT JOIN ODS.SAP_CATEGORIA CAT ON CAT.CodigoCategoria=PRO.CodigoCategoria
   LEFT JOIN Marca M on PC.MarcaId = M.MarcaId  
  WHERE  
   EstrategiaID = @EstrategiaID  
  
 SET NOCOUNT OFF  
  
END  




GO

USE BelcorpDominicana
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.FiltrarEstrategiaPedido'))
BEGIN
    DROP PROCEDURE dbo.FiltrarEstrategiaPedido
END
GO

CREATE PROCEDURE FiltrarEstrategiaPedido  
 @EstrategiaID INT,  
 @FlagNueva INT = 0  
AS  
BEGIN  
/*  
 FiltrarEstrategiaPedido 11164  
*/  
 SET NOCOUNT ON  
  
  /*R2621-LR - INI **/  
  DECLARE  @CampaniaID  INT  
  SELECT @CampaniaID  = E.CampaniaID  
  FROM Estrategia E  
   INNER JOIN TipoEstrategia TE ON E.TipoEstrategiaID = TE.TipoEstrategiaID  
   INNER JOIN ods.Campania CA ON E.CampaniaID = CA.Codigo  
  WHERE  
   EstrategiaID = @EstrategiaID  
  
  DECLARE @ActivacionProgramaNuevas SMALLINT  
  DECLARE @TablaLogicaID SMALLINT  
  DECLARE @ProgramaNuevoActivado INT   
  DECLARE @ProgramaCampaniaActivado INT  
  
  SET  @TablaLogicaID = 61  
  SET  @ActivacionProgramaNuevas = 6101  
  
  SELECT @ProgramaNuevoActivado = COUNT(TD.TablaLogicaID)  
  FROM TablaLogicaDatos  TD  
  WHERE TD.TablaLogicaID = @TablaLogicaID    
    AND TD.TablaLogicaDatosID = @ActivacionProgramaNuevas  
    AND CAST(TD.Codigo AS VARCHAR(10)) = 1  
  
  IF @ProgramaNuevoActivado  > 0   
  BEGIN  
   SELECT @ProgramaCampaniaActivado = COUNT(TD.TablaLogicaID)  
   FROM TablaLogicaDatos  TD  
   WHERE TD.TablaLogicaID = @TablaLogicaID    
     AND CAST(TD.Codigo AS VARCHAR(10)) <= @CampaniaID -- CGI(AHAA) - MODIFICACIÓN AL BUG BUG_2015000858  
  END      
  /*R2621-LR - FIN **/  
  SELECT  
   EstrategiaID,   
   CUV2,   
   DescripcionCUV2,   
   dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,   
   E.Precio,  
   dbo.ObtenerDescripcionEtiqueta(EtiquetaID2) EtiquetaDescripcion2,   
   Precio2,  
   TextoLibre,   
   FlagEstrella,   
   ColorFondo,  
   e.TipoEstrategiaID,  
   e.ImagenURL FotoProducto01,  
   te.ImagenEstrategia ImagenURL,  
   e.LimiteVenta,  
   pc.MarcaID,  
   dbo.FiltrarTallaColorCUV(CUV2, E.CampaniaID) TallaColor,  
   pc.IndicadorMontoMinimo,  
   O.TipoOferta,  
   M.Descripcion as DescripcionMarca, --R2469
   'NO DISPONIBLE' AS DescripcionCategoria,
   TE.DescripcionEstrategia AS DescripcionEstrategia,
   @FlagNueva  AS FlagNueva,
   E.EsOfertaIndependiente 
  FROM   
   Estrategia E  
   INNER JOIN TipoEstrategia TE ON E.TipoEstrategiaID = TE.TipoEstrategiaID  
   INNER JOIN ods.Campania CA ON E.CampaniaID = CA.Codigo  
   INNER JOIN ods.ProductoComercial PC ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2  
   LEFT JOIN Oferta O ON O.CODIGOOFERTA = PC.CodigoTipoOferta     
   --LEFT JOIN ODS.SAP_PRODUCTO PRO ON PC.CodigoProducto=PRO.CodigoSap
   --LEFT JOIN ODS.SAP_MARCA MAR ON MAR.Codigo = PRO.CodigoMarca
   --LEFT JOIN ODS.SAP_CATEGORIA CAT ON CAT.CodigoCategoria=PRO.CodigoCategoria
   LEFT JOIN Marca M on PC.MarcaId = M.MarcaId  
  WHERE  
   EstrategiaID = @EstrategiaID  
  
 SET NOCOUNT OFF  
  
END  




GO

USE BelcorpCostaRica
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.FiltrarEstrategiaPedido'))
BEGIN
    DROP PROCEDURE dbo.FiltrarEstrategiaPedido
END
GO

CREATE PROCEDURE FiltrarEstrategiaPedido  
 @EstrategiaID INT,  
 @FlagNueva INT = 0  
AS  
BEGIN  
/*  
 FiltrarEstrategiaPedido 11164  
*/  
 SET NOCOUNT ON  
  
  /*R2621-LR - INI **/  
  DECLARE  @CampaniaID  INT  
  SELECT @CampaniaID  = E.CampaniaID  
  FROM Estrategia E  
   INNER JOIN TipoEstrategia TE ON E.TipoEstrategiaID = TE.TipoEstrategiaID  
   INNER JOIN ods.Campania CA ON E.CampaniaID = CA.Codigo  
  WHERE  
   EstrategiaID = @EstrategiaID  
  
  DECLARE @ActivacionProgramaNuevas SMALLINT  
  DECLARE @TablaLogicaID SMALLINT  
  DECLARE @ProgramaNuevoActivado INT   
  DECLARE @ProgramaCampaniaActivado INT  
  
  SET  @TablaLogicaID = 61  
  SET  @ActivacionProgramaNuevas = 6101  
  
  SELECT @ProgramaNuevoActivado = COUNT(TD.TablaLogicaID)  
  FROM TablaLogicaDatos  TD  
  WHERE TD.TablaLogicaID = @TablaLogicaID    
    AND TD.TablaLogicaDatosID = @ActivacionProgramaNuevas  
    AND CAST(TD.Codigo AS VARCHAR(10)) = 1  
  
  IF @ProgramaNuevoActivado  > 0   
  BEGIN  
   SELECT @ProgramaCampaniaActivado = COUNT(TD.TablaLogicaID)  
   FROM TablaLogicaDatos  TD  
   WHERE TD.TablaLogicaID = @TablaLogicaID    
     AND CAST(TD.Codigo AS VARCHAR(10)) <= @CampaniaID -- CGI(AHAA) - MODIFICACIÓN AL BUG BUG_2015000858  
  END      
  /*R2621-LR - FIN **/  
  SELECT  
   EstrategiaID,   
   CUV2,   
   DescripcionCUV2,   
   dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,   
   E.Precio,  
   dbo.ObtenerDescripcionEtiqueta(EtiquetaID2) EtiquetaDescripcion2,   
   Precio2,  
   TextoLibre,   
   FlagEstrella,   
   ColorFondo,  
   e.TipoEstrategiaID,  
   e.ImagenURL FotoProducto01,  
   te.ImagenEstrategia ImagenURL,  
   e.LimiteVenta,  
   pc.MarcaID,  
   dbo.FiltrarTallaColorCUV(CUV2, E.CampaniaID) TallaColor,  
   pc.IndicadorMontoMinimo,  
   O.TipoOferta,  
   M.Descripcion as DescripcionMarca, --R2469
   'NO DISPONIBLE' AS DescripcionCategoria,
   TE.DescripcionEstrategia AS DescripcionEstrategia,
   @FlagNueva  AS FlagNueva,
   E.EsOfertaIndependiente 
  FROM   
   Estrategia E  
   INNER JOIN TipoEstrategia TE ON E.TipoEstrategiaID = TE.TipoEstrategiaID  
   INNER JOIN ods.Campania CA ON E.CampaniaID = CA.Codigo  
   INNER JOIN ods.ProductoComercial PC ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2  
   LEFT JOIN Oferta O ON O.CODIGOOFERTA = PC.CodigoTipoOferta     
   --LEFT JOIN ODS.SAP_PRODUCTO PRO ON PC.CodigoProducto=PRO.CodigoSap
   --LEFT JOIN ODS.SAP_MARCA MAR ON MAR.Codigo = PRO.CodigoMarca
   --LEFT JOIN ODS.SAP_CATEGORIA CAT ON CAT.CodigoCategoria=PRO.CodigoCategoria
   LEFT JOIN Marca M on PC.MarcaId = M.MarcaId  
  WHERE  
   EstrategiaID = @EstrategiaID  
  
 SET NOCOUNT OFF  
  
END  




GO

USE BelcorpChile
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.FiltrarEstrategiaPedido'))
BEGIN
    DROP PROCEDURE dbo.FiltrarEstrategiaPedido
END
GO

CREATE PROCEDURE FiltrarEstrategiaPedido  
 @EstrategiaID INT,  
 @FlagNueva INT = 0  
AS  
BEGIN  
/*  
 FiltrarEstrategiaPedido 11164  
*/  
 SET NOCOUNT ON  
  
  /*R2621-LR - INI **/  
  DECLARE  @CampaniaID  INT  
  SELECT @CampaniaID  = E.CampaniaID  
  FROM Estrategia E  
   INNER JOIN TipoEstrategia TE ON E.TipoEstrategiaID = TE.TipoEstrategiaID  
   INNER JOIN ods.Campania CA ON E.CampaniaID = CA.Codigo  
  WHERE  
   EstrategiaID = @EstrategiaID  
  
  DECLARE @ActivacionProgramaNuevas SMALLINT  
  DECLARE @TablaLogicaID SMALLINT  
  DECLARE @ProgramaNuevoActivado INT   
  DECLARE @ProgramaCampaniaActivado INT  
  
  SET  @TablaLogicaID = 61  
  SET  @ActivacionProgramaNuevas = 6101  
  
  SELECT @ProgramaNuevoActivado = COUNT(TD.TablaLogicaID)  
  FROM TablaLogicaDatos  TD  
  WHERE TD.TablaLogicaID = @TablaLogicaID    
    AND TD.TablaLogicaDatosID = @ActivacionProgramaNuevas  
    AND CAST(TD.Codigo AS VARCHAR(10)) = 1  
  
  IF @ProgramaNuevoActivado  > 0   
  BEGIN  
   SELECT @ProgramaCampaniaActivado = COUNT(TD.TablaLogicaID)  
   FROM TablaLogicaDatos  TD  
   WHERE TD.TablaLogicaID = @TablaLogicaID    
     AND CAST(TD.Codigo AS VARCHAR(10)) <= @CampaniaID -- CGI(AHAA) - MODIFICACIÓN AL BUG BUG_2015000858  
  END      
  /*R2621-LR - FIN **/  
  SELECT  
   EstrategiaID,   
   CUV2,   
   DescripcionCUV2,   
   dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,   
   E.Precio,  
   dbo.ObtenerDescripcionEtiqueta(EtiquetaID2) EtiquetaDescripcion2,   
   Precio2,  
   TextoLibre,   
   FlagEstrella,   
   ColorFondo,  
   e.TipoEstrategiaID,  
   e.ImagenURL FotoProducto01,  
   te.ImagenEstrategia ImagenURL,  
   e.LimiteVenta,  
   pc.MarcaID,  
   dbo.FiltrarTallaColorCUV(CUV2, E.CampaniaID) TallaColor,  
   pc.IndicadorMontoMinimo,  
   O.TipoOferta,  
   M.Descripcion as DescripcionMarca, --R2469
   'NO DISPONIBLE' AS DescripcionCategoria,
   TE.DescripcionEstrategia AS DescripcionEstrategia,
   @FlagNueva  AS FlagNueva,
   E.EsOfertaIndependiente 
  FROM   
   Estrategia E  
   INNER JOIN TipoEstrategia TE ON E.TipoEstrategiaID = TE.TipoEstrategiaID  
   INNER JOIN ods.Campania CA ON E.CampaniaID = CA.Codigo  
   INNER JOIN ods.ProductoComercial PC ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2  
   LEFT JOIN Oferta O ON O.CODIGOOFERTA = PC.CodigoTipoOferta     
   --LEFT JOIN ODS.SAP_PRODUCTO PRO ON PC.CodigoProducto=PRO.CodigoSap
   --LEFT JOIN ODS.SAP_MARCA MAR ON MAR.Codigo = PRO.CodigoMarca
   --LEFT JOIN ODS.SAP_CATEGORIA CAT ON CAT.CodigoCategoria=PRO.CodigoCategoria
   LEFT JOIN Marca M on PC.MarcaId = M.MarcaId  
  WHERE  
   EstrategiaID = @EstrategiaID  
  
 SET NOCOUNT OFF  
  
END  




GO

USE BelcorpBolivia
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.FiltrarEstrategiaPedido'))
BEGIN
    DROP PROCEDURE dbo.FiltrarEstrategiaPedido
END
GO

CREATE PROCEDURE FiltrarEstrategiaPedido  
 @EstrategiaID INT,  
 @FlagNueva INT = 0  
AS  
BEGIN  
/*  
 FiltrarEstrategiaPedido 11164  
*/  
 SET NOCOUNT ON  
  
  /*R2621-LR - INI **/  
  DECLARE  @CampaniaID  INT  
  SELECT @CampaniaID  = E.CampaniaID  
  FROM Estrategia E  
   INNER JOIN TipoEstrategia TE ON E.TipoEstrategiaID = TE.TipoEstrategiaID  
   INNER JOIN ods.Campania CA ON E.CampaniaID = CA.Codigo  
  WHERE  
   EstrategiaID = @EstrategiaID  
  
  DECLARE @ActivacionProgramaNuevas SMALLINT  
  DECLARE @TablaLogicaID SMALLINT  
  DECLARE @ProgramaNuevoActivado INT   
  DECLARE @ProgramaCampaniaActivado INT  
  
  SET  @TablaLogicaID = 61  
  SET  @ActivacionProgramaNuevas = 6101  
  
  SELECT @ProgramaNuevoActivado = COUNT(TD.TablaLogicaID)  
  FROM TablaLogicaDatos  TD  
  WHERE TD.TablaLogicaID = @TablaLogicaID    
    AND TD.TablaLogicaDatosID = @ActivacionProgramaNuevas  
    AND CAST(TD.Codigo AS VARCHAR(10)) = 1  
  
  IF @ProgramaNuevoActivado  > 0   
  BEGIN  
   SELECT @ProgramaCampaniaActivado = COUNT(TD.TablaLogicaID)  
   FROM TablaLogicaDatos  TD  
   WHERE TD.TablaLogicaID = @TablaLogicaID    
     AND CAST(TD.Codigo AS VARCHAR(10)) <= @CampaniaID -- CGI(AHAA) - MODIFICACIÓN AL BUG BUG_2015000858  
  END      
  /*R2621-LR - FIN **/  
  SELECT  
   EstrategiaID,   
   CUV2,   
   DescripcionCUV2,   
   dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,   
   E.Precio,  
   dbo.ObtenerDescripcionEtiqueta(EtiquetaID2) EtiquetaDescripcion2,   
   Precio2,  
   TextoLibre,   
   FlagEstrella,   
   ColorFondo,  
   e.TipoEstrategiaID,  
   e.ImagenURL FotoProducto01,  
   te.ImagenEstrategia ImagenURL,  
   e.LimiteVenta,  
   pc.MarcaID,  
   dbo.FiltrarTallaColorCUV(CUV2, E.CampaniaID) TallaColor,  
   pc.IndicadorMontoMinimo,  
   O.TipoOferta,  
   M.Descripcion as DescripcionMarca, --R2469
   'NO DISPONIBLE' AS DescripcionCategoria,
   TE.DescripcionEstrategia AS DescripcionEstrategia,
   @FlagNueva  AS FlagNueva,
   E.EsOfertaIndependiente 
  FROM   
   Estrategia E  
   INNER JOIN TipoEstrategia TE ON E.TipoEstrategiaID = TE.TipoEstrategiaID  
   INNER JOIN ods.Campania CA ON E.CampaniaID = CA.Codigo  
   INNER JOIN ods.ProductoComercial PC ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2  
   LEFT JOIN Oferta O ON O.CODIGOOFERTA = PC.CodigoTipoOferta     
   --LEFT JOIN ODS.SAP_PRODUCTO PRO ON PC.CodigoProducto=PRO.CodigoSap
   --LEFT JOIN ODS.SAP_MARCA MAR ON MAR.Codigo = PRO.CodigoMarca
   --LEFT JOIN ODS.SAP_CATEGORIA CAT ON CAT.CodigoCategoria=PRO.CodigoCategoria
   LEFT JOIN Marca M on PC.MarcaId = M.MarcaId  
  WHERE  
   EstrategiaID = @EstrategiaID  
  
 SET NOCOUNT OFF  
  
END  




GO

