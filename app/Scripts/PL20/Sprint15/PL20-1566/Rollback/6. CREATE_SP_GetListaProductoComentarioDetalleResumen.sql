
USE BelcorpPeru
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.GetListaProductoComentarioDetalleResumen'))
BEGIN
    DROP PROCEDURE dbo.GetListaProductoComentarioDetalleResumen
END
GO
