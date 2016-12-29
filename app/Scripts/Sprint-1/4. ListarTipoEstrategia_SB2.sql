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
   isnull(dbo.ObtenerDescripcionOferta(TipoEstrategiaID),'') DescripcionOferta,   
   Orden,   
   FlagActivo,   
   CodigoPrograma,
   isnull(dbo.ObtenerOfertaID(TipoEstrategiaID),'') OfertaID,  
   ImagenEstrategia,  
   FlagNueva,  
   FlagRecoPerfil,  
   FlagRecoProduc
   , ISNULL(FlagMostrarImg,0) AS FlagMostrarImg 		/* SB20-353 */
   , CASE TipoEstrategiaID
	WHEN 10 THEN 1
	WHEN 1009 THEN 2
	WHEN 2009 THEN 3
	WHEN 3009 THEN 4
	WHEN 3011 THEN 5
	WHEN 3012 THEN 6
	WHEN 3014 THEN 7
   END AS CodigoGeneral
  FROM   
   TipoEstrategia  
  WHERE  
   TipoEstrategiaID = @TipoEstrategiaID OR 0 = @TipoEstrategiaID  
  ORDER BY Orden, DescripcionEstrategia ASC  
 SET NOCOUNT OFF  
END 

GO