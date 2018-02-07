
USE BelcorpPeru_PL50
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'DeleteEstrategiaProducto')
BEGIN
    DROP PROCEDURE dbo.DeleteEstrategiaProducto 
END
GO