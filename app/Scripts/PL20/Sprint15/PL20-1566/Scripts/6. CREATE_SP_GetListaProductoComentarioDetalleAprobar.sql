
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
	@Estado TINYINT,
	@Tipo TINYINT,
	@Codigo VARCHAR(20),
	@Limite INT = 0,
	@Cantidad INT = 10,
	@Ordenar TINYINT = 1
)
AS
BEGIN
	SELECT c.ProdComentarioId, d.ProdComentarioDetalleId, d.Valorizado, 
	d.Recomendado, d.Comentario, CAST(d.FechaRegistro AS DATE) AS FechaRegistro, 
	d.CodigoConsultora
	FROM ProductoComentario c 
	INNER JOIN ProductoComentarioDetalle d ON c.ProdComentarioId = d.ProdComentarioId
		AND d.Estado = @Estado
	WHERE 
		c.CodigoSap = CASE WHEN @Tipo = 1 THEN @Codigo ELSE '' END
		AND c.Estado = 1
	ORDER BY c.FechaRegistro
	OFFSET @Limite ROWS
	FETCH NEXT @Cantidad ROWS ONLY;
END
GO