
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
	@ProdComentarioId INT,
	@ProdComentarioDetalleId BIGINT,
	@Estado TINYINT
)
AS
BEGIN
	UPDATE ProductoComentarioDetalle SET Estado = @Estado, FechaAprobacion = GETDATE() 
	WHERE ProdComentarioDetalleId = @ProdComentarioDetalleId

	DECLARE @aprobados INT, @recomendados INT, @promValorizado INT

	SELECT 
		@aprobados = COUNT(ProdComentarioDetalleId), 
		@recomendados = SUM(CAST(Recomendado AS TINYINT)), 
		@promValorizado = AVG(Valorizado) 
	FROM ProductoComentarioDetalle 
	WHERE ProdComentarioId = @ProdComentarioId AND Estado = 2
	GROUP BY ProdComentarioId

	UPDATE ProductoComentario
	SET CantAprobados = @aprobados,
		CantRecomendados = @recomendados,
		PromValorizado = @promValorizado
	WHERE ProdComentarioId = @ProdComentarioId

	SELECT 1
END
GO

GO