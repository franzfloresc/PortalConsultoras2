
USE BelcorpPeru
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.GetListaProductoComentarioDetalleAprobar'))
BEGIN
    DROP PROCEDURE dbo.GetListaProductoComentarioDetalleAprobar
END
GO

CREATE PROCEDURE GetListaProductoComentarioDetalleAprobar
(
	@CodigoSAP VARCHAR(20),
	@SkipRows INT = 0,
	@TakeRows INT = 30,
	@SortRows TINYINT = 1
)
AS
BEGIN
	SELECT c.ProdComentarioId, d.ProdComentarioDetalleId, d.Valorizado, 
	d.Recomendado, d.Comentario, CAST(d.FechaRegistro AS DATE) AS FechaRegistro, 
	d.CodigoConsultora
	FROM ProductoComentario c 
	INNER JOIN ProductoComentarioDetalle d ON c.ProdComentarioId = d.ProdComentarioId
		AND d.Estado = 1
	WHERE c.CodigoSAP = @CodigoSAP AND c.Estado = 1
	ORDER BY c.FechaRegistro
	OFFSET @SkipRows ROWS
	FETCH NEXT @TakeRows ROWS ONLY;
END
GO