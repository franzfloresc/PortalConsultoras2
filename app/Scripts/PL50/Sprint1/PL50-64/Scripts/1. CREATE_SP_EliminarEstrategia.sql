USE BelcorpPeru_PL50
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