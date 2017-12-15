
USE BelcorpColombia
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'TieneCampaniaConsecutivas')
BEGIN
    DROP PROCEDURE dbo.TieneCampaniaConsecutivas
END
GO

USE BelcorpEcuador
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'TieneCampaniaConsecutivas')
BEGIN
    DROP PROCEDURE dbo.TieneCampaniaConsecutivas
END
GO
