
USE BelcorpPeru
GO


IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetListaLoginExterno'))
BEGIN
    DROP PROCEDURE dbo.GetListaLoginExterno
END
GO
