

USE BelcorpColombia
GO

ALTER PROCEDURE [dbo].[ListarTipoEstrategia_SB2]  
 @TipoEstrategiaID INT  
AS  
BEGIN  
/*  
 EXEC ListarTipoEstrategia_SB2 0  
*/  
 SET NOCOUNT ON  
  SELECT   
   TipoEstrategiaID,   
   DescripcionEstrategia,   
   ISNULL(dbo.ObtenerDescripcionOferta(TipoEstrategiaID),'') AS DescripcionOferta,   
   Orden,   
   FlagActivo,   
   ISNULL(CodigoPrograma,'') AS CodigoPrograma,
   ISNULL(dbo.ObtenerOfertaID(TipoEstrategiaID),'') AS OfertaID,  
   ImagenEstrategia,  
   FlagNueva,  
   FlagRecoPerfil,  
   FlagRecoProduc
   , ISNULL(FlagMostrarImg,0) AS FlagMostrarImg 		/* SB20-353 */
   , case TipoEstrategiaID
	when 1 then 1
	when 2 then 2
	when 3 then 3
	when 1003 then 4
	when 1004 then 5
	when 1005 then 6
	WHEN 3014 THEN 7
   end as CodigoGeneral
  FROM   
   TipoEstrategia  
  WHERE  
   TipoEstrategiaID = @TipoEstrategiaID OR 0 = @TipoEstrategiaID  
  ORDER BY Orden, DescripcionEstrategia ASC  
 SET NOCOUNT OFF  
END


GO

USE BelcorpMexico
GO

ALTER PROCEDURE [dbo].[ListarTipoEstrategia_SB2]  
 @TipoEstrategiaID INT  
AS  
BEGIN  
/*  
 EXEC ListarTipoEstrategia_SB2 0  
*/  
 SET NOCOUNT ON  
  SELECT   
   TipoEstrategiaID,   
   DescripcionEstrategia,   
   ISNULL(dbo.ObtenerDescripcionOferta(TipoEstrategiaID),'') AS DescripcionOferta,     
   Orden,   
   FlagActivo,   
   ISNULL(CodigoPrograma,'') AS CodigoPrograma,
   ISNULL(dbo.ObtenerOfertaID(TipoEstrategiaID),'') AS OfertaID,  
   ImagenEstrategia,  
   FlagNueva,  
   FlagRecoPerfil,  
   FlagRecoProduc
   , ISNULL(FlagMostrarImg,0) AS FlagMostrarImg 		/* SB20-353 */
   , case TipoEstrategiaID
	when 1 then 1
	when 2 then 2
	when 3 then 3
	when 1003 then 4
	when 1004 then 5
	WHEN 3014 THEN 7
   end as CodigoGeneral
  FROM   
   TipoEstrategia  
  WHERE  
   TipoEstrategiaID = @TipoEstrategiaID OR 0 = @TipoEstrategiaID  
  ORDER BY Orden, DescripcionEstrategia ASC  
 SET NOCOUNT OFF  
END 


GO

USE BelcorpPeru
GO

ALTER PROCEDURE [dbo].[ListarTipoEstrategia_SB2]  
 @TipoEstrategiaID INT  
AS  
BEGIN  
/*  
 EXEC ListarTipoEstrategia_SB2 0  
*/  
 SET NOCOUNT ON  
  SELECT   
   TipoEstrategiaID,   
   DescripcionEstrategia,   
   ISNULL(dbo.ObtenerDescripcionOferta(TipoEstrategiaID),'') AS DescripcionOferta,  
   Orden,   
   FlagActivo,   
   ISNULL(CodigoPrograma,'') AS CodigoPrograma,
   ISNULL(dbo.ObtenerOfertaID(TipoEstrategiaID),'') AS OfertaID,  
   ImagenEstrategia,  
   FlagNueva,  
   FlagRecoPerfil,  
   FlagRecoProduc
   , ISNULL(FlagMostrarImg,0) AS FlagMostrarImg 		/* SB20-353 */
   , case TipoEstrategiaID
	when 10 then 1
	when 1009 then 2
	when 2009 then 3
	when 3009 then 4
	when 3011 then 5
	when 3012 then 6
	WHEN 3014 THEN 7
   end as CodigoGeneral
  FROM   
   TipoEstrategia  
  WHERE  
   TipoEstrategiaID = @TipoEstrategiaID OR 0 = @TipoEstrategiaID  
  ORDER BY Orden, DescripcionEstrategia ASC  
 SET NOCOUNT OFF  
END 


GO
