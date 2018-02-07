USE BelcorpPeru
GO

-- check exists SP
IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'EliminarEstrategia')
BEGIN
    PRINT 'Stored Procedure Exists'
  
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

-- check exists SP
IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'EliminarEstrategia')
BEGIN
    PRINT 'Stored Procedure Exists'
  
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

-- check exists SP
IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'EliminarEstrategia')
BEGIN
    PRINT 'Stored Procedure Exists'
  
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

-- check exists SP
IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'EliminarEstrategia')
BEGIN
    PRINT 'Stored Procedure Exists'
  
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

-- check exists SP
IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'EliminarEstrategia')
BEGIN
    PRINT 'Stored Procedure Exists'
  
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

-- check exists SP
IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'EliminarEstrategia')
BEGIN
    PRINT 'Stored Procedure Exists'
  
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

-- check exists SP
IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'EliminarEstrategia')
BEGIN
    PRINT 'Stored Procedure Exists'
  
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

-- check exists SP
IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'EliminarEstrategia')
BEGIN
    PRINT 'Stored Procedure Exists'
  
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

-- check exists SP
IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'EliminarEstrategia')
BEGIN
    PRINT 'Stored Procedure Exists'
  
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

-- check exists SP
IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'EliminarEstrategia')
BEGIN
    PRINT 'Stored Procedure Exists'
  
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

-- check exists SP
IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'EliminarEstrategia')
BEGIN
    PRINT 'Stored Procedure Exists'
  
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

-- check exists SP
IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'EliminarEstrategia')
BEGIN
    PRINT 'Stored Procedure Exists'
  
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

-- check exists SP
IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'EliminarEstrategia')
BEGIN
    PRINT 'Stored Procedure Exists'
  
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

