
USE BelcorpPeru
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.GetProductoComentarioByCodSap'))
BEGIN
    DROP PROCEDURE dbo.GetProductoComentarioByCodSap
END
GO

