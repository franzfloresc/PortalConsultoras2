
USE BelcorpPeru
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.GetUltimoProductoComentarioByCodSap'))
BEGIN
    DROP PROCEDURE dbo.GetUltimoProductoComentarioByCodSap
END
GO

CREATE PROCEDURE GetUltimoProductoComentarioByCodSap
(
	@CodigoSap VARCHAR(20)
)
AS
BEGIN
	DECLARE @ProdComentarioId INT

	SELECT @ProdComentarioId = ProdComentarioId FROM ProductoComentario WHERE CodigoSap = @CodigoSap AND Estado = 1

	SELECT TOP 1
		d.ProdComentarioDetalleId,
		d.Valorizado,
		d.Recomendado,
		d.Comentario,
		RTRIM(co.PrimerNombre) + ' ' + RTRIM(co.PrimerApellido) AS NombreConsultora
	FROM ProductoComentarioDetalle d 
	INNER JOIN ods.Consultora co ON d.CodigoConsultora = co.Codigo
	WHERE d.ProdComentarioId = @ProdComentarioId AND d.Estado = 2
	ORDER BY d.Valorizado DESC
END
GO
