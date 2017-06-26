
USE BelcorpPeru
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.AprobarProductoComentarioDetalle'))
BEGIN
    DROP PROCEDURE dbo.AprobarProductoComentarioDetalle
END
GO

CREATE PROCEDURE AprobarProductoComentarioDetalle
(
	@ProdComentarioDetalleId INT
)
AS
BEGIN
	UPDATE ProductoComentarioDetalle SET Estado = 2, FechaAprobacion = GETDATE() 
	WHERE ProdComentarioDetalleId = @ProdComentarioDetalleId

	SELECT 1
END
GO