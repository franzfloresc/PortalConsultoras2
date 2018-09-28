USE BelcorpPeru
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'EliminarEstrategia')
BEGIN
	DROP PROCEDURE dbo.EliminarEstrategia 
END
GO


CREATE PROCEDURE dbo.EliminarEstrategia  
 @EstrategiaID INT
AS  
BEGIN  
 SET NOCOUNT ON  
  DELETE FROM dbo.EstrategiaProducto WHERE EstrategiaID = @EstrategiaID
  DELETE FROM dbo.Estrategia WHERE EstrategiaID = @EstrategiaID
 SET NOCOUNT OFF  
END  

GO

USE BelcorpBolivia
GO


IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'EliminarEstrategia')
BEGIN
	DROP PROCEDURE dbo.EliminarEstrategia 
END
GO

CREATE PROCEDURE dbo.EliminarEstrategia  
 @EstrategiaID INT
AS  
BEGIN  
 SET NOCOUNT ON  
  DELETE FROM dbo.EstrategiaProducto WHERE EstrategiaID = @EstrategiaID
  DELETE FROM dbo.Estrategia WHERE EstrategiaID = @EstrategiaID
 SET NOCOUNT OFF  
END  

GO


USE BelcorpChile
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'EliminarEstrategia')
BEGIN
	DROP PROCEDURE dbo.EliminarEstrategia 
END
GO

CREATE PROCEDURE dbo.EliminarEstrategia  
 @EstrategiaID INT
AS  
BEGIN  
 SET NOCOUNT ON  
  DELETE FROM dbo.EstrategiaProducto WHERE EstrategiaID = @EstrategiaID
  DELETE FROM dbo.Estrategia WHERE EstrategiaID = @EstrategiaID
 SET NOCOUNT OFF  
END  

GO

USE BelcorpColombia
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'EliminarEstrategia')
BEGIN
	DROP PROCEDURE dbo.EliminarEstrategia 
END
GO

CREATE PROCEDURE dbo.EliminarEstrategia  
 @EstrategiaID INT
AS  
BEGIN  
 SET NOCOUNT ON  
  DELETE FROM dbo.EstrategiaProducto WHERE EstrategiaID = @EstrategiaID
  DELETE FROM dbo.Estrategia WHERE EstrategiaID = @EstrategiaID
 SET NOCOUNT OFF  
END  

GO


USE BelcorpCostaRica
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'EliminarEstrategia')
BEGIN
	DROP PROCEDURE dbo.EliminarEstrategia 
END
GO

CREATE PROCEDURE dbo.EliminarEstrategia  
 @EstrategiaID INT
AS  
BEGIN  
 SET NOCOUNT ON  
  DELETE FROM dbo.EstrategiaProducto WHERE EstrategiaID = @EstrategiaID
  DELETE FROM dbo.Estrategia WHERE EstrategiaID = @EstrategiaID
 SET NOCOUNT OFF  
END  

GO


USE BelcorpDominicana
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'EliminarEstrategia')
BEGIN
	DROP PROCEDURE dbo.EliminarEstrategia 
END
GO

CREATE PROCEDURE dbo.EliminarEstrategia  
 @EstrategiaID INT
AS  
BEGIN  
 SET NOCOUNT ON  
  DELETE FROM dbo.EstrategiaProducto WHERE EstrategiaID = @EstrategiaID
  DELETE FROM dbo.Estrategia WHERE EstrategiaID = @EstrategiaID
 SET NOCOUNT OFF  
END  

GO


USE BelcorpEcuador
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'EliminarEstrategia')
BEGIN
	DROP PROCEDURE dbo.EliminarEstrategia 
END
GO

CREATE PROCEDURE dbo.EliminarEstrategia  
 @EstrategiaID INT
AS  
BEGIN  
 SET NOCOUNT ON  
  DELETE FROM dbo.EstrategiaProducto WHERE EstrategiaID = @EstrategiaID
  DELETE FROM dbo.Estrategia WHERE EstrategiaID = @EstrategiaID
 SET NOCOUNT OFF  
END  

GO


USE BelcorpGuatemala
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'EliminarEstrategia')
BEGIN
	DROP PROCEDURE dbo.EliminarEstrategia 
END
GO


CREATE PROCEDURE dbo.EliminarEstrategia  
 @EstrategiaID INT
AS  
BEGIN  
 SET NOCOUNT ON  
  DELETE FROM dbo.EstrategiaProducto WHERE EstrategiaID = @EstrategiaID
  DELETE FROM dbo.Estrategia WHERE EstrategiaID = @EstrategiaID
 SET NOCOUNT OFF  
END  

GO


USE BelcorpMexico
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'EliminarEstrategia')
BEGIN
	DROP PROCEDURE dbo.EliminarEstrategia 
END
GO

CREATE PROCEDURE dbo.EliminarEstrategia  
 @EstrategiaID INT
AS  
BEGIN  
 SET NOCOUNT ON  
  DELETE FROM dbo.EstrategiaProducto WHERE EstrategiaID = @EstrategiaID
  DELETE FROM dbo.Estrategia WHERE EstrategiaID = @EstrategiaID
 SET NOCOUNT OFF  
END  

GO


USE BelcorpPanama
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'EliminarEstrategia')
BEGIN
	DROP PROCEDURE dbo.EliminarEstrategia 
END
GO

CREATE PROCEDURE dbo.EliminarEstrategia  
 @EstrategiaID INT
AS  
BEGIN  
 SET NOCOUNT ON  
  DELETE FROM dbo.EstrategiaProducto WHERE EstrategiaID = @EstrategiaID
  DELETE FROM dbo.Estrategia WHERE EstrategiaID = @EstrategiaID
 SET NOCOUNT OFF  
END  

GO


USE BelcorpPuertoRico
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'EliminarEstrategia')
BEGIN
	DROP PROCEDURE dbo.EliminarEstrategia 
END
GO


CREATE PROCEDURE dbo.EliminarEstrategia  
 @EstrategiaID INT
AS  
BEGIN  
 SET NOCOUNT ON  
  DELETE FROM dbo.EstrategiaProducto WHERE EstrategiaID = @EstrategiaID
  DELETE FROM dbo.Estrategia WHERE EstrategiaID = @EstrategiaID
 SET NOCOUNT OFF  
END  

GO


USE BelcorpSalvador
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'EliminarEstrategia')
BEGIN
	DROP PROCEDURE dbo.EliminarEstrategia 
END
GO


CREATE PROCEDURE dbo.EliminarEstrategia  
 @EstrategiaID INT
AS  
BEGIN  
 SET NOCOUNT ON  
  DELETE FROM dbo.EstrategiaProducto WHERE EstrategiaID = @EstrategiaID
  DELETE FROM dbo.Estrategia WHERE EstrategiaID = @EstrategiaID
 SET NOCOUNT OFF  
END  

GO


USE BelcorpVenezuela
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'EliminarEstrategia')
BEGIN
	DROP PROCEDURE dbo.EliminarEstrategia 
END
GO

CREATE PROCEDURE dbo.EliminarEstrategia  
 @EstrategiaID INT
AS  
BEGIN  
 SET NOCOUNT ON  
  DELETE FROM dbo.EstrategiaProducto WHERE EstrategiaID = @EstrategiaID
  DELETE FROM dbo.Estrategia WHERE EstrategiaID = @EstrategiaID
 SET NOCOUNT OFF  
END  

GO

