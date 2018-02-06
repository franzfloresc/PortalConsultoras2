
USE BelcorpPeru_PL50
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'UpdateEstrategiaProducto')
BEGIN
    DROP PROCEDURE dbo.UpdateEstrategiaProducto 
END
GO