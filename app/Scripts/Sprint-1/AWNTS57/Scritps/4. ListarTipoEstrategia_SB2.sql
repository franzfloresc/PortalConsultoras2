

USE BelcorpBolivia
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
	when 1002 then 3
	when 2002 then 4
	when 2003 then 5
	when 2004 then 6
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

/*end*/

USE BelcorpChile
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
	when 1002 then 3
	when 2002 then 4
	when 2003 then 5
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

/*end*/

USE BelcorpCostaRica
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
	when 4 then 1
	when 1004 then 2
	when 1005 then 4
	when 1006 then 5
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

/*end*/

USE BelcorpDominicana
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
	when 1002 then 3
	when 2002 then 4
	when 2003 then 5
	when 2004 then 6
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

/*end*/

USE BelcorpEcuador
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
	when 3 then 5
	when 4 then 4
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

/*end*/

USE BelcorpGuatemala
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
	when 3 then 5
	when 4 then 4
	when 6 then 6
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

/*end*/

USE BelcorpPanama
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
	when 3 then 4
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

/*end*/

USE BelcorpPuertoRico
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
	when 3 then 5
	when 4 then 6
	when 5 then 4
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

/*end*/

USE BelcorpSalvador
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
	when 3 then 5
	when 4 then 4
	when 5 then 6
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

/*end*/

USE BelcorpVenezuela
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
	when 3 then 4
	when 4 then 3
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
