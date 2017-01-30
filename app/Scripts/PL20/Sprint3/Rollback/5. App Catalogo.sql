
USE [AppCatalogo]
GO

IF OBJECT_ID(N'dbo.fnSplitString') IS NOT NULL
BEGIN
    DROP FUNCTION dbo.fnSplitString
END

GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE object_id = OBJECT_ID(N'dbo.GetProductoCatalogoByListaCUV'))
BEGIN
    DROP PROCEDURE dbo.GetProductoCatalogoByListaCUV
END

GO
