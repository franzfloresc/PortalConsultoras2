USE BelcorpPeru
GO

ALTER PROCEDURE [dbo].[ListarTipoEstrategia_SB2]  
 @TipoEstrategiaID INT  
AS  
BEGIN  
SET NOCOUNT ON 

	DECLARE @CodigoTipoEstrategia INT
    SET @CodigoTipoEstrategia = (SELECT TOP 1 TipoEstrategiaID FROM TipoEstrategia WHERE DescripcionEstrategia= 'Los más vendidos')
  
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
		FlagRecoProduc, 
		ISNULL(FlagMostrarImg,0) AS FlagMostrarImg,
		case TipoEstrategiaID
		when 10 then 1
		when 1009 then 2
		when 2009 then 3
		when 3009 then 4
		when 3011 then 5
		when 3012 then 6
		when 3014 then 7
		when 3015 then 8
		when 3016 then 9
		when 3017 then 10
		when 3018 then 11
		WHEN @CodigoTipoEstrategia then 20
		end as CodigoGeneral,
		Codigo
		, MostrarImgOfertaIndependiente
		, ImagenOfertaIndependiente
	FROM TipoEstrategia  
	WHERE TipoEstrategiaID = @TipoEstrategiaID OR 0 = @TipoEstrategiaID  
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
  
  DECLARE @CodigoTipoEstrategia INT
  SET @CodigoTipoEstrategia = (SELECT TOP 1 TipoEstrategiaID FROM TipoEstrategia WHERE DescripcionEstrategia= 'Los más vendidos')
  
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
	WHEN @CodigoTipoEstrategia then 20
   end as CodigoGeneral
   , Codigo
	, MostrarImgOfertaIndependiente
	, ImagenOfertaIndependiente
  FROM   
   TipoEstrategia  
  WHERE  
   TipoEstrategiaID = @TipoEstrategiaID OR 0 = @TipoEstrategiaID  
  ORDER BY Orden, DescripcionEstrategia ASC  
 SET NOCOUNT OFF  
END 
GO

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
 
  DECLARE @CodigoTipoEstrategia INT
  SET @CodigoTipoEstrategia = (SELECT TOP 1 TipoEstrategiaID FROM TipoEstrategia WHERE DescripcionEstrategia= 'Los más vendidos')
  
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
	WHEN @CodigoTipoEstrategia then 20
   end as CodigoGeneral
   , Codigo
	, MostrarImgOfertaIndependiente
	, ImagenOfertaIndependiente
  FROM   
   TipoEstrategia  
  WHERE  
   TipoEstrategiaID = @TipoEstrategiaID OR 0 = @TipoEstrategiaID  
  ORDER BY Orden, DescripcionEstrategia ASC  
 SET NOCOUNT OFF  
END
GO

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

  DECLARE @CodigoTipoEstrategia INT
  SET @CodigoTipoEstrategia = (SELECT TOP 1 TipoEstrategiaID FROM TipoEstrategia WHERE DescripcionEstrategia= 'Los más vendidos')
  
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
	WHEN @CodigoTipoEstrategia then 20
	end as CodigoGeneral
	, Codigo
  FROM   
   TipoEstrategia  
  WHERE  
   TipoEstrategiaID = @TipoEstrategiaID OR 0 = @TipoEstrategiaID  
  ORDER BY Orden, DescripcionEstrategia ASC  
 SET NOCOUNT OFF  
END 
GO

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
  
  DECLARE @CodigoTipoEstrategia INT
  SET @CodigoTipoEstrategia = (SELECT TOP 1 TipoEstrategiaID FROM TipoEstrategia WHERE DescripcionEstrategia= 'Los más vendidos')
  
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
	WHEN @CodigoTipoEstrategia then 20
	end as CodigoGeneral
	, Codigo
	, MostrarImgOfertaIndependiente
	, ImagenOfertaIndependiente
  FROM   
   TipoEstrategia  
  WHERE  
   TipoEstrategiaID = @TipoEstrategiaID OR 0 = @TipoEstrategiaID  
  ORDER BY Orden, DescripcionEstrategia ASC  
 SET NOCOUNT OFF  
END 
GO

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
  
  DECLARE @CodigoTipoEstrategia INT
  SET @CodigoTipoEstrategia = (SELECT TOP 1 TipoEstrategiaID FROM TipoEstrategia WHERE DescripcionEstrategia= 'Los más vendidos')
  
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
	WHEN @CodigoTipoEstrategia then 20
	end as CodigoGeneral
	, Codigo
	, MostrarImgOfertaIndependiente
	, ImagenOfertaIndependiente
  FROM   
   TipoEstrategia  
  WHERE  
   TipoEstrategiaID = @TipoEstrategiaID OR 0 = @TipoEstrategiaID  
  ORDER BY Orden, DescripcionEstrategia ASC  
 SET NOCOUNT OFF  
END 
GO

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
 
  DECLARE @CodigoTipoEstrategia INT
  SET @CodigoTipoEstrategia = (SELECT TOP 1 TipoEstrategiaID FROM TipoEstrategia WHERE DescripcionEstrategia= 'Los más vendidos')
  
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
	WHEN @CodigoTipoEstrategia then 20
	end as CodigoGeneral
	, Codigo
	, MostrarImgOfertaIndependiente
	, ImagenOfertaIndependiente
  FROM   
   TipoEstrategia  
  WHERE  
   TipoEstrategiaID = @TipoEstrategiaID OR 0 = @TipoEstrategiaID  
  ORDER BY Orden, DescripcionEstrategia ASC  
 SET NOCOUNT OFF  
END 
GO

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
  
  DECLARE @CodigoTipoEstrategia INT
  SET @CodigoTipoEstrategia = (SELECT TOP 1 TipoEstrategiaID FROM TipoEstrategia WHERE DescripcionEstrategia= 'Los más vendidos')
  
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
	WHEN @CodigoTipoEstrategia then 20
	end as CodigoGeneral
	, Codigo
	, MostrarImgOfertaIndependiente
	, ImagenOfertaIndependiente
  FROM   
   TipoEstrategia  
  WHERE  
   TipoEstrategiaID = @TipoEstrategiaID OR 0 = @TipoEstrategiaID  
  ORDER BY Orden, DescripcionEstrategia ASC  
 SET NOCOUNT OFF  
END 
GO

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
  
  DECLARE @CodigoTipoEstrategia INT
  SET @CodigoTipoEstrategia = (SELECT TOP 1 TipoEstrategiaID FROM TipoEstrategia WHERE DescripcionEstrategia= 'Los más vendidos')
  
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
	WHEN @CodigoTipoEstrategia then 20
	end as CodigoGeneral
	, Codigo
	, MostrarImgOfertaIndependiente
	, ImagenOfertaIndependiente
  FROM   
   TipoEstrategia  
  WHERE  
   TipoEstrategiaID = @TipoEstrategiaID OR 0 = @TipoEstrategiaID  
  ORDER BY Orden, DescripcionEstrategia ASC  
 SET NOCOUNT OFF  
END 
GO

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
  
  DECLARE @CodigoTipoEstrategia INT
  SET @CodigoTipoEstrategia = (SELECT TOP 1 TipoEstrategiaID FROM TipoEstrategia WHERE DescripcionEstrategia= 'Los más vendidos')
  
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
	WHEN @CodigoTipoEstrategia then 20
	end as CodigoGeneral
   , Codigo
	, MostrarImgOfertaIndependiente
	, ImagenOfertaIndependiente
  FROM   
   TipoEstrategia  
  WHERE  
   TipoEstrategiaID = @TipoEstrategiaID OR 0 = @TipoEstrategiaID  
  ORDER BY Orden, DescripcionEstrategia ASC  
 SET NOCOUNT OFF  
END 
GO

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
  
  DECLARE @CodigoTipoEstrategia INT
  SET @CodigoTipoEstrategia = (SELECT TOP 1 TipoEstrategiaID FROM TipoEstrategia WHERE DescripcionEstrategia= 'Los más vendidos')
  
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
	WHEN @CodigoTipoEstrategia then 20
	end as CodigoGeneral
	, Codigo
	, MostrarImgOfertaIndependiente
	, ImagenOfertaIndependiente
  FROM   
   TipoEstrategia  
  WHERE  
   TipoEstrategiaID = @TipoEstrategiaID OR 0 = @TipoEstrategiaID  
  ORDER BY Orden, DescripcionEstrategia ASC  
 SET NOCOUNT OFF  
END
GO

USE BelcorpChile
GO

ALTER PROCEDURE [dbo].[ListarTipoEstrategia_SB2]  
 @TipoEstrategiaID INT  
AS  
BEGIN  
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
		when 3014 THEN 7
		when 3015 then 8
		when 3016 then 9
		when 3018 then 10
		when 3019 then 11
		end as CodigoGeneral
		, Codigo
	   , MostrarImgOfertaIndependiente
	   , ImagenOfertaIndependiente
	FROM TipoEstrategia  
	WHERE TipoEstrategiaID = @TipoEstrategiaID OR 0 = @TipoEstrategiaID  
	ORDER BY Orden, DescripcionEstrategia ASC  
SET NOCOUNT OFF  
END 
GO

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
 
  DECLARE @CodigoTipoEstrategia INT
  SET @CodigoTipoEstrategia = (SELECT TOP 1 TipoEstrategiaID FROM TipoEstrategia WHERE DescripcionEstrategia= 'Los más vendidos')

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
	WHEN @CodigoTipoEstrategia then 20
   end as CodigoGeneral
   , Codigo
   , MostrarImgOfertaIndependiente
   , ImagenOfertaIndependiente
  FROM   
   TipoEstrategia  
  WHERE  
   TipoEstrategiaID = @TipoEstrategiaID OR 0 = @TipoEstrategiaID  
  ORDER BY Orden, DescripcionEstrategia ASC  
 SET NOCOUNT OFF  
END 
GO
