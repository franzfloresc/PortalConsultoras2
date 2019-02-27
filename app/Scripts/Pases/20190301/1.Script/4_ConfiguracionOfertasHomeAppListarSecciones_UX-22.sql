USE BelcorpPeru
GO

GO

IF (OBJECT_ID ( 'dbo.ConfiguracionOfertasHomeAppListarSecciones', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.ConfiguracionOfertasHomeAppListarSecciones AS SET NOCOUNT ON;')
GO

alter PROCEDURE ConfiguracionOfertasHomeAppListarSecciones
 @CampaniaId INT  
AS  
BEGIN  
	SET NOCOUNT ON;  

	 DECLARE @TablaConfOfertaHomeAPP TABLE (  
	  CampaniaID INT,  
	  ConfiguracionPaisID INT ,
	   ConfiguracionOfertasHomeAppID  INT 
	 )  

	 INSERT INTO @TablaConfOfertaHomeAPP (CampaniaID,ConfiguracionPaisID,ConfiguracionOfertasHomeAppID)  
	 SELECT MAX(O.CampaniaID), O.ConfiguracionPaisID , OA.ConfiguracionOfertasHomeAppID   
	 FROM ConfiguracionOfertasHome O  WITH(NOLOCK)  
	 INNER JOIN ConfiguracionOfertasHomeApp OA
	 ON O.ConfiguracionOfertasHomeID = OA.ConfiguracionOfertasHomeID
	 WHERE O.CampaniaID <= @CampaniaId and ISNULL(O.CampaniaID, 0) > 0  
	 GROUP BY  O.ConfiguracionPaisID , OA.ConfiguracionOfertasHomeAppID 
    
	 SELECT 
	 OA.AppTitulo ,
	 OA.AppOrden,
	 OA.AppBannerInformativo,
	 OA.AppColorFondo,
	 OA.AppColorTexto,
	 OA.AppCantidadProductos,
	 C.Codigo
	 FROM ConfiguracionOfertasHomeApp OA WITH (NOLOCK)
	 INNER JOIN @TablaConfOfertaHomeAPP OC ON   
	 OA.ConfiguracionOfertasHomeAppID = OC.ConfiguracionOfertasHomeAppID  
	 LEFT JOIN ConfiguracionPais C ON   
	  C.ConfiguracionPaisID = OC.ConfiguracionPaisID  
	 WHERE OA.AppActivo = 1
END
GO

USE BelcorpMexico
GO

GO

IF (OBJECT_ID ( 'dbo.ConfiguracionOfertasHomeAppListarSecciones', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.ConfiguracionOfertasHomeAppListarSecciones AS SET NOCOUNT ON;')
GO

alter PROCEDURE ConfiguracionOfertasHomeAppListarSecciones
 @CampaniaId INT  
AS  
BEGIN  
	SET NOCOUNT ON;  

	 DECLARE @TablaConfOfertaHomeAPP TABLE (  
	  CampaniaID INT,  
	  ConfiguracionPaisID INT ,
	   ConfiguracionOfertasHomeAppID  INT 
	 )  

	 INSERT INTO @TablaConfOfertaHomeAPP (CampaniaID,ConfiguracionPaisID,ConfiguracionOfertasHomeAppID)  
	 SELECT MAX(O.CampaniaID), O.ConfiguracionPaisID , OA.ConfiguracionOfertasHomeAppID   
	 FROM ConfiguracionOfertasHome O  WITH(NOLOCK)  
	 INNER JOIN ConfiguracionOfertasHomeApp OA
	 ON O.ConfiguracionOfertasHomeID = OA.ConfiguracionOfertasHomeID
	 WHERE O.CampaniaID <= @CampaniaId and ISNULL(O.CampaniaID, 0) > 0  
	 GROUP BY  O.ConfiguracionPaisID , OA.ConfiguracionOfertasHomeAppID 
    
	 SELECT 
	 OA.AppTitulo ,
	 OA.AppOrden,
	 OA.AppBannerInformativo,
	 OA.AppColorFondo,
	 OA.AppColorTexto,
	 OA.AppCantidadProductos,
	 C.Codigo
	 FROM ConfiguracionOfertasHomeApp OA WITH (NOLOCK)
	 INNER JOIN @TablaConfOfertaHomeAPP OC ON   
	 OA.ConfiguracionOfertasHomeAppID = OC.ConfiguracionOfertasHomeAppID  
	 LEFT JOIN ConfiguracionPais C ON   
	  C.ConfiguracionPaisID = OC.ConfiguracionPaisID  
	 WHERE OA.AppActivo = 1
END
GO

USE BelcorpColombia
GO

GO

IF (OBJECT_ID ( 'dbo.ConfiguracionOfertasHomeAppListarSecciones', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.ConfiguracionOfertasHomeAppListarSecciones AS SET NOCOUNT ON;')
GO

alter PROCEDURE ConfiguracionOfertasHomeAppListarSecciones
 @CampaniaId INT  
AS  
BEGIN  
	SET NOCOUNT ON;  

	 DECLARE @TablaConfOfertaHomeAPP TABLE (  
	  CampaniaID INT,  
	  ConfiguracionPaisID INT ,
	   ConfiguracionOfertasHomeAppID  INT 
	 )  

	 INSERT INTO @TablaConfOfertaHomeAPP (CampaniaID,ConfiguracionPaisID,ConfiguracionOfertasHomeAppID)  
	 SELECT MAX(O.CampaniaID), O.ConfiguracionPaisID , OA.ConfiguracionOfertasHomeAppID   
	 FROM ConfiguracionOfertasHome O  WITH(NOLOCK)  
	 INNER JOIN ConfiguracionOfertasHomeApp OA
	 ON O.ConfiguracionOfertasHomeID = OA.ConfiguracionOfertasHomeID
	 WHERE O.CampaniaID <= @CampaniaId and ISNULL(O.CampaniaID, 0) > 0  
	 GROUP BY  O.ConfiguracionPaisID , OA.ConfiguracionOfertasHomeAppID 
    
	 SELECT 
	 OA.AppTitulo ,
	 OA.AppOrden,
	 OA.AppBannerInformativo,
	 OA.AppColorFondo,
	 OA.AppColorTexto,
	 OA.AppCantidadProductos,
	 C.Codigo
	 FROM ConfiguracionOfertasHomeApp OA WITH (NOLOCK)
	 INNER JOIN @TablaConfOfertaHomeAPP OC ON   
	 OA.ConfiguracionOfertasHomeAppID = OC.ConfiguracionOfertasHomeAppID  
	 LEFT JOIN ConfiguracionPais C ON   
	  C.ConfiguracionPaisID = OC.ConfiguracionPaisID  
	 WHERE OA.AppActivo = 1
END
GO

USE BelcorpSalvador
GO

GO

IF (OBJECT_ID ( 'dbo.ConfiguracionOfertasHomeAppListarSecciones', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.ConfiguracionOfertasHomeAppListarSecciones AS SET NOCOUNT ON;')
GO

alter PROCEDURE ConfiguracionOfertasHomeAppListarSecciones
 @CampaniaId INT  
AS  
BEGIN  
	SET NOCOUNT ON;  

	 DECLARE @TablaConfOfertaHomeAPP TABLE (  
	  CampaniaID INT,  
	  ConfiguracionPaisID INT ,
	   ConfiguracionOfertasHomeAppID  INT 
	 )  

	 INSERT INTO @TablaConfOfertaHomeAPP (CampaniaID,ConfiguracionPaisID,ConfiguracionOfertasHomeAppID)  
	 SELECT MAX(O.CampaniaID), O.ConfiguracionPaisID , OA.ConfiguracionOfertasHomeAppID   
	 FROM ConfiguracionOfertasHome O  WITH(NOLOCK)  
	 INNER JOIN ConfiguracionOfertasHomeApp OA
	 ON O.ConfiguracionOfertasHomeID = OA.ConfiguracionOfertasHomeID
	 WHERE O.CampaniaID <= @CampaniaId and ISNULL(O.CampaniaID, 0) > 0  
	 GROUP BY  O.ConfiguracionPaisID , OA.ConfiguracionOfertasHomeAppID 
    
	 SELECT 
	 OA.AppTitulo ,
	 OA.AppOrden,
	 OA.AppBannerInformativo,
	 OA.AppColorFondo,
	 OA.AppColorTexto,
	 OA.AppCantidadProductos,
	 C.Codigo
	 FROM ConfiguracionOfertasHomeApp OA WITH (NOLOCK)
	 INNER JOIN @TablaConfOfertaHomeAPP OC ON   
	 OA.ConfiguracionOfertasHomeAppID = OC.ConfiguracionOfertasHomeAppID  
	 LEFT JOIN ConfiguracionPais C ON   
	  C.ConfiguracionPaisID = OC.ConfiguracionPaisID  
	 WHERE OA.AppActivo = 1
END
GO

USE BelcorpPuertoRico
GO

GO

IF (OBJECT_ID ( 'dbo.ConfiguracionOfertasHomeAppListarSecciones', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.ConfiguracionOfertasHomeAppListarSecciones AS SET NOCOUNT ON;')
GO

alter PROCEDURE ConfiguracionOfertasHomeAppListarSecciones
 @CampaniaId INT  
AS  
BEGIN  
	SET NOCOUNT ON;  

	 DECLARE @TablaConfOfertaHomeAPP TABLE (  
	  CampaniaID INT,  
	  ConfiguracionPaisID INT ,
	   ConfiguracionOfertasHomeAppID  INT 
	 )  

	 INSERT INTO @TablaConfOfertaHomeAPP (CampaniaID,ConfiguracionPaisID,ConfiguracionOfertasHomeAppID)  
	 SELECT MAX(O.CampaniaID), O.ConfiguracionPaisID , OA.ConfiguracionOfertasHomeAppID   
	 FROM ConfiguracionOfertasHome O  WITH(NOLOCK)  
	 INNER JOIN ConfiguracionOfertasHomeApp OA
	 ON O.ConfiguracionOfertasHomeID = OA.ConfiguracionOfertasHomeID
	 WHERE O.CampaniaID <= @CampaniaId and ISNULL(O.CampaniaID, 0) > 0  
	 GROUP BY  O.ConfiguracionPaisID , OA.ConfiguracionOfertasHomeAppID 
    
	 SELECT 
	 OA.AppTitulo ,
	 OA.AppOrden,
	 OA.AppBannerInformativo,
	 OA.AppColorFondo,
	 OA.AppColorTexto,
	 OA.AppCantidadProductos,
	 C.Codigo
	 FROM ConfiguracionOfertasHomeApp OA WITH (NOLOCK)
	 INNER JOIN @TablaConfOfertaHomeAPP OC ON   
	 OA.ConfiguracionOfertasHomeAppID = OC.ConfiguracionOfertasHomeAppID  
	 LEFT JOIN ConfiguracionPais C ON   
	  C.ConfiguracionPaisID = OC.ConfiguracionPaisID  
	 WHERE OA.AppActivo = 1
END
GO

USE BelcorpPanama
GO

GO

IF (OBJECT_ID ( 'dbo.ConfiguracionOfertasHomeAppListarSecciones', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.ConfiguracionOfertasHomeAppListarSecciones AS SET NOCOUNT ON;')
GO

alter PROCEDURE ConfiguracionOfertasHomeAppListarSecciones
 @CampaniaId INT  
AS  
BEGIN  
	SET NOCOUNT ON;  

	 DECLARE @TablaConfOfertaHomeAPP TABLE (  
	  CampaniaID INT,  
	  ConfiguracionPaisID INT ,
	   ConfiguracionOfertasHomeAppID  INT 
	 )  

	 INSERT INTO @TablaConfOfertaHomeAPP (CampaniaID,ConfiguracionPaisID,ConfiguracionOfertasHomeAppID)  
	 SELECT MAX(O.CampaniaID), O.ConfiguracionPaisID , OA.ConfiguracionOfertasHomeAppID   
	 FROM ConfiguracionOfertasHome O  WITH(NOLOCK)  
	 INNER JOIN ConfiguracionOfertasHomeApp OA
	 ON O.ConfiguracionOfertasHomeID = OA.ConfiguracionOfertasHomeID
	 WHERE O.CampaniaID <= @CampaniaId and ISNULL(O.CampaniaID, 0) > 0  
	 GROUP BY  O.ConfiguracionPaisID , OA.ConfiguracionOfertasHomeAppID 
    
	 SELECT 
	 OA.AppTitulo ,
	 OA.AppOrden,
	 OA.AppBannerInformativo,
	 OA.AppColorFondo,
	 OA.AppColorTexto,
	 OA.AppCantidadProductos,
	 C.Codigo
	 FROM ConfiguracionOfertasHomeApp OA WITH (NOLOCK)
	 INNER JOIN @TablaConfOfertaHomeAPP OC ON   
	 OA.ConfiguracionOfertasHomeAppID = OC.ConfiguracionOfertasHomeAppID  
	 LEFT JOIN ConfiguracionPais C ON   
	  C.ConfiguracionPaisID = OC.ConfiguracionPaisID  
	 WHERE OA.AppActivo = 1
END
GO

USE BelcorpGuatemala
GO

GO

IF (OBJECT_ID ( 'dbo.ConfiguracionOfertasHomeAppListarSecciones', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.ConfiguracionOfertasHomeAppListarSecciones AS SET NOCOUNT ON;')
GO

alter PROCEDURE ConfiguracionOfertasHomeAppListarSecciones
 @CampaniaId INT  
AS  
BEGIN  
	SET NOCOUNT ON;  

	 DECLARE @TablaConfOfertaHomeAPP TABLE (  
	  CampaniaID INT,  
	  ConfiguracionPaisID INT ,
	   ConfiguracionOfertasHomeAppID  INT 
	 )  

	 INSERT INTO @TablaConfOfertaHomeAPP (CampaniaID,ConfiguracionPaisID,ConfiguracionOfertasHomeAppID)  
	 SELECT MAX(O.CampaniaID), O.ConfiguracionPaisID , OA.ConfiguracionOfertasHomeAppID   
	 FROM ConfiguracionOfertasHome O  WITH(NOLOCK)  
	 INNER JOIN ConfiguracionOfertasHomeApp OA
	 ON O.ConfiguracionOfertasHomeID = OA.ConfiguracionOfertasHomeID
	 WHERE O.CampaniaID <= @CampaniaId and ISNULL(O.CampaniaID, 0) > 0  
	 GROUP BY  O.ConfiguracionPaisID , OA.ConfiguracionOfertasHomeAppID 
    
	 SELECT 
	 OA.AppTitulo ,
	 OA.AppOrden,
	 OA.AppBannerInformativo,
	 OA.AppColorFondo,
	 OA.AppColorTexto,
	 OA.AppCantidadProductos,
	 C.Codigo
	 FROM ConfiguracionOfertasHomeApp OA WITH (NOLOCK)
	 INNER JOIN @TablaConfOfertaHomeAPP OC ON   
	 OA.ConfiguracionOfertasHomeAppID = OC.ConfiguracionOfertasHomeAppID  
	 LEFT JOIN ConfiguracionPais C ON   
	  C.ConfiguracionPaisID = OC.ConfiguracionPaisID  
	 WHERE OA.AppActivo = 1
END
GO

USE BelcorpEcuador
GO

GO

IF (OBJECT_ID ( 'dbo.ConfiguracionOfertasHomeAppListarSecciones', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.ConfiguracionOfertasHomeAppListarSecciones AS SET NOCOUNT ON;')
GO

alter PROCEDURE ConfiguracionOfertasHomeAppListarSecciones
 @CampaniaId INT  
AS  
BEGIN  
	SET NOCOUNT ON;  

	 DECLARE @TablaConfOfertaHomeAPP TABLE (  
	  CampaniaID INT,  
	  ConfiguracionPaisID INT ,
	   ConfiguracionOfertasHomeAppID  INT 
	 )  

	 INSERT INTO @TablaConfOfertaHomeAPP (CampaniaID,ConfiguracionPaisID,ConfiguracionOfertasHomeAppID)  
	 SELECT MAX(O.CampaniaID), O.ConfiguracionPaisID , OA.ConfiguracionOfertasHomeAppID   
	 FROM ConfiguracionOfertasHome O  WITH(NOLOCK)  
	 INNER JOIN ConfiguracionOfertasHomeApp OA
	 ON O.ConfiguracionOfertasHomeID = OA.ConfiguracionOfertasHomeID
	 WHERE O.CampaniaID <= @CampaniaId and ISNULL(O.CampaniaID, 0) > 0  
	 GROUP BY  O.ConfiguracionPaisID , OA.ConfiguracionOfertasHomeAppID 
    
	 SELECT 
	 OA.AppTitulo ,
	 OA.AppOrden,
	 OA.AppBannerInformativo,
	 OA.AppColorFondo,
	 OA.AppColorTexto,
	 OA.AppCantidadProductos,
	 C.Codigo
	 FROM ConfiguracionOfertasHomeApp OA WITH (NOLOCK)
	 INNER JOIN @TablaConfOfertaHomeAPP OC ON   
	 OA.ConfiguracionOfertasHomeAppID = OC.ConfiguracionOfertasHomeAppID  
	 LEFT JOIN ConfiguracionPais C ON   
	  C.ConfiguracionPaisID = OC.ConfiguracionPaisID  
	 WHERE OA.AppActivo = 1
END
GO

USE BelcorpDominicana
GO

GO

IF (OBJECT_ID ( 'dbo.ConfiguracionOfertasHomeAppListarSecciones', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.ConfiguracionOfertasHomeAppListarSecciones AS SET NOCOUNT ON;')
GO

alter PROCEDURE ConfiguracionOfertasHomeAppListarSecciones
 @CampaniaId INT  
AS  
BEGIN  
	SET NOCOUNT ON;  

	 DECLARE @TablaConfOfertaHomeAPP TABLE (  
	  CampaniaID INT,  
	  ConfiguracionPaisID INT ,
	   ConfiguracionOfertasHomeAppID  INT 
	 )  

	 INSERT INTO @TablaConfOfertaHomeAPP (CampaniaID,ConfiguracionPaisID,ConfiguracionOfertasHomeAppID)  
	 SELECT MAX(O.CampaniaID), O.ConfiguracionPaisID , OA.ConfiguracionOfertasHomeAppID   
	 FROM ConfiguracionOfertasHome O  WITH(NOLOCK)  
	 INNER JOIN ConfiguracionOfertasHomeApp OA
	 ON O.ConfiguracionOfertasHomeID = OA.ConfiguracionOfertasHomeID
	 WHERE O.CampaniaID <= @CampaniaId and ISNULL(O.CampaniaID, 0) > 0  
	 GROUP BY  O.ConfiguracionPaisID , OA.ConfiguracionOfertasHomeAppID 
    
	 SELECT 
	 OA.AppTitulo ,
	 OA.AppOrden,
	 OA.AppBannerInformativo,
	 OA.AppColorFondo,
	 OA.AppColorTexto,
	 OA.AppCantidadProductos,
	 C.Codigo
	 FROM ConfiguracionOfertasHomeApp OA WITH (NOLOCK)
	 INNER JOIN @TablaConfOfertaHomeAPP OC ON   
	 OA.ConfiguracionOfertasHomeAppID = OC.ConfiguracionOfertasHomeAppID  
	 LEFT JOIN ConfiguracionPais C ON   
	  C.ConfiguracionPaisID = OC.ConfiguracionPaisID  
	 WHERE OA.AppActivo = 1
END
GO

USE BelcorpCostaRica
GO

GO

IF (OBJECT_ID ( 'dbo.ConfiguracionOfertasHomeAppListarSecciones', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.ConfiguracionOfertasHomeAppListarSecciones AS SET NOCOUNT ON;')
GO

alter PROCEDURE ConfiguracionOfertasHomeAppListarSecciones
 @CampaniaId INT  
AS  
BEGIN  
	SET NOCOUNT ON;  

	 DECLARE @TablaConfOfertaHomeAPP TABLE (  
	  CampaniaID INT,  
	  ConfiguracionPaisID INT ,
	   ConfiguracionOfertasHomeAppID  INT 
	 )  

	 INSERT INTO @TablaConfOfertaHomeAPP (CampaniaID,ConfiguracionPaisID,ConfiguracionOfertasHomeAppID)  
	 SELECT MAX(O.CampaniaID), O.ConfiguracionPaisID , OA.ConfiguracionOfertasHomeAppID   
	 FROM ConfiguracionOfertasHome O  WITH(NOLOCK)  
	 INNER JOIN ConfiguracionOfertasHomeApp OA
	 ON O.ConfiguracionOfertasHomeID = OA.ConfiguracionOfertasHomeID
	 WHERE O.CampaniaID <= @CampaniaId and ISNULL(O.CampaniaID, 0) > 0  
	 GROUP BY  O.ConfiguracionPaisID , OA.ConfiguracionOfertasHomeAppID 
    
	 SELECT 
	 OA.AppTitulo ,
	 OA.AppOrden,
	 OA.AppBannerInformativo,
	 OA.AppColorFondo,
	 OA.AppColorTexto,
	 OA.AppCantidadProductos,
	 C.Codigo
	 FROM ConfiguracionOfertasHomeApp OA WITH (NOLOCK)
	 INNER JOIN @TablaConfOfertaHomeAPP OC ON   
	 OA.ConfiguracionOfertasHomeAppID = OC.ConfiguracionOfertasHomeAppID  
	 LEFT JOIN ConfiguracionPais C ON   
	  C.ConfiguracionPaisID = OC.ConfiguracionPaisID  
	 WHERE OA.AppActivo = 1
END
GO

USE BelcorpChile
GO

GO

IF (OBJECT_ID ( 'dbo.ConfiguracionOfertasHomeAppListarSecciones', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.ConfiguracionOfertasHomeAppListarSecciones AS SET NOCOUNT ON;')
GO

alter PROCEDURE ConfiguracionOfertasHomeAppListarSecciones
 @CampaniaId INT  
AS  
BEGIN  
	SET NOCOUNT ON;  

	 DECLARE @TablaConfOfertaHomeAPP TABLE (  
	  CampaniaID INT,  
	  ConfiguracionPaisID INT ,
	   ConfiguracionOfertasHomeAppID  INT 
	 )  

	 INSERT INTO @TablaConfOfertaHomeAPP (CampaniaID,ConfiguracionPaisID,ConfiguracionOfertasHomeAppID)  
	 SELECT MAX(O.CampaniaID), O.ConfiguracionPaisID , OA.ConfiguracionOfertasHomeAppID   
	 FROM ConfiguracionOfertasHome O  WITH(NOLOCK)  
	 INNER JOIN ConfiguracionOfertasHomeApp OA
	 ON O.ConfiguracionOfertasHomeID = OA.ConfiguracionOfertasHomeID
	 WHERE O.CampaniaID <= @CampaniaId and ISNULL(O.CampaniaID, 0) > 0  
	 GROUP BY  O.ConfiguracionPaisID , OA.ConfiguracionOfertasHomeAppID 
    
	 SELECT 
	 OA.AppTitulo ,
	 OA.AppOrden,
	 OA.AppBannerInformativo,
	 OA.AppColorFondo,
	 OA.AppColorTexto,
	 OA.AppCantidadProductos,
	 C.Codigo
	 FROM ConfiguracionOfertasHomeApp OA WITH (NOLOCK)
	 INNER JOIN @TablaConfOfertaHomeAPP OC ON   
	 OA.ConfiguracionOfertasHomeAppID = OC.ConfiguracionOfertasHomeAppID  
	 LEFT JOIN ConfiguracionPais C ON   
	  C.ConfiguracionPaisID = OC.ConfiguracionPaisID  
	 WHERE OA.AppActivo = 1
END
GO

USE BelcorpBolivia
GO

GO

IF (OBJECT_ID ( 'dbo.ConfiguracionOfertasHomeAppListarSecciones', 'P' ) IS NULL)
	EXEC('CREATE PROCEDURE dbo.ConfiguracionOfertasHomeAppListarSecciones AS SET NOCOUNT ON;')
GO

alter PROCEDURE ConfiguracionOfertasHomeAppListarSecciones
 @CampaniaId INT  
AS  
BEGIN  
	SET NOCOUNT ON;  

	 DECLARE @TablaConfOfertaHomeAPP TABLE (  
	  CampaniaID INT,  
	  ConfiguracionPaisID INT ,
	   ConfiguracionOfertasHomeAppID  INT 
	 )  

	 INSERT INTO @TablaConfOfertaHomeAPP (CampaniaID,ConfiguracionPaisID,ConfiguracionOfertasHomeAppID)  
	 SELECT MAX(O.CampaniaID), O.ConfiguracionPaisID , OA.ConfiguracionOfertasHomeAppID   
	 FROM ConfiguracionOfertasHome O  WITH(NOLOCK)  
	 INNER JOIN ConfiguracionOfertasHomeApp OA
	 ON O.ConfiguracionOfertasHomeID = OA.ConfiguracionOfertasHomeID
	 WHERE O.CampaniaID <= @CampaniaId and ISNULL(O.CampaniaID, 0) > 0  
	 GROUP BY  O.ConfiguracionPaisID , OA.ConfiguracionOfertasHomeAppID 
    
	 SELECT 
	 OA.AppTitulo ,
	 OA.AppOrden,
	 OA.AppBannerInformativo,
	 OA.AppColorFondo,
	 OA.AppColorTexto,
	 OA.AppCantidadProductos,
	 C.Codigo
	 FROM ConfiguracionOfertasHomeApp OA WITH (NOLOCK)
	 INNER JOIN @TablaConfOfertaHomeAPP OC ON   
	 OA.ConfiguracionOfertasHomeAppID = OC.ConfiguracionOfertasHomeAppID  
	 LEFT JOIN ConfiguracionPais C ON   
	  C.ConfiguracionPaisID = OC.ConfiguracionPaisID  
	 WHERE OA.AppActivo = 1
END
GO

