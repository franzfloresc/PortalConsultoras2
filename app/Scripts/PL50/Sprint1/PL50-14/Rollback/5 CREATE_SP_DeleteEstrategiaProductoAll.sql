
USE BelcorpPeru_PL50
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'DeleteEstrategiaProductoAll')
BEGIN
    DROP PROCEDURE dbo.DeleteEstrategiaProductoAll 
END
GO