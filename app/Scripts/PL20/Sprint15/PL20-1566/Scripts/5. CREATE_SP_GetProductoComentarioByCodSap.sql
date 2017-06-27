
USE BelcorpPeru
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.GetProductoComentarioByCodSap'))
BEGIN
    DROP PROCEDURE dbo.GetProductoComentarioByCodSap
END
GO

CREATE PROCEDURE GetProductoComentarioByCodSap
(
	@CodigoSap VARCHAR(20)
)
AS
BEGIN
	SELECT 
		c.ProdComentarioId, 
		c.CodigoSap, 
		c.CodigoGenerico, 
		c.CantComentarios, 
		c.CantAprobados, 
		c.CantRecomendados,
		d.Valorizado AS UltValorizado,
		d.Recomendado AS UltRecomendado,
		d.Comentario AS UltComentario
	FROM ProductoComentario c
	LEFT JOIN ProductoComentarioDetalle d ON c.ProdComentarioId = d.ProdComentarioId 
		AND d.ProdComentarioDetalleId = (
		SELECT TOP 1 ProdComentarioDetalleId 
		FROM ProductoComentarioDetalle 
		WHERE ProdComentarioId = c.ProdComentarioId
		AND Estado = 2
		ORDER BY FechaRegistro DESC
	)
	WHERE c.CodigoSap = @CodigoSap AND c.Estado = 1
END
GO