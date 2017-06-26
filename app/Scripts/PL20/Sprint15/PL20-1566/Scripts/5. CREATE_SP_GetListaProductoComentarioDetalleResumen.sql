
USE BelcorpPeru
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.GetListaProductoComentarioDetalleResumen'))
BEGIN
    DROP PROCEDURE dbo.GetListaProductoComentarioDetalleResumen
END
GO

CREATE PROCEDURE GetListaProductoComentarioDetalleResumen
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
	ex.FotoPerfil AS URLFotoConsultora, d.CodigoConsultora, 
	RTRIM(co.PrimerNombre) + ' ' + RTRIM(co.PrimerApellido) AS NombreConsultora
	FROM ProductoComentario c 
	INNER JOIN ProductoComentarioDetalle d ON c.ProdComentarioId = d.ProdComentarioId
		AND d.Estado = 2
	INNER JOIN ods.Consultora co ON d.CodigoConsultora = co.Codigo
	INNER JOIN Usuario u ON co.Codigo = u.CodigoConsultora AND u.Activo = 1
	LEFT JOIN UsuarioExterno ex ON u.CodigoUsuario = ex.CodigoUsuario 
		AND ex.Proveedor = 'Facebook' 
		AND ex.Estado = 1
	WHERE c.CodigoSAP = @CodigoSAP AND c.Estado = 1
	ORDER BY FechaRegistro
	OFFSET @SkipRows ROWS
	FETCH NEXT @TakeRows ROWS ONLY;
END
GO