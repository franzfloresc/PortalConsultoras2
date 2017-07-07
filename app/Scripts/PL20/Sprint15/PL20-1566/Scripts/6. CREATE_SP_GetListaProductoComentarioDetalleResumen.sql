
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
	@CodigoSap VARCHAR(20),
	@Limite INT = 0,
	@Cantidad INT = 10,
	@Ordenar TINYINT = 1
)
AS
BEGIN
	SELECT 
		c.ProdComentarioId, 
		d.ProdComentarioDetalleId, 
		d.Valorizado, 
		d.Recomendado, 
		d.Comentario, 
		CAST(d.FechaRegistro AS DATE) AS FechaRegistro, 
		ex.FotoPerfil AS URLFotoConsultora, 
		d.CodigoConsultora,
		RTRIM(co.PrimerNombre) + ' ' + RTRIM(co.PrimerApellido) AS NombreConsultora
	FROM ProductoComentario c 
	INNER JOIN ProductoComentarioDetalle d ON c.ProdComentarioId = d.ProdComentarioId
		AND d.Estado = 2
	INNER JOIN ods.Consultora co ON d.CodigoConsultora = co.Codigo
	INNER JOIN Usuario u ON co.Codigo = u.CodigoConsultora AND u.Activo = 1
	LEFT JOIN UsuarioExterno ex ON u.CodigoUsuario = ex.CodigoUsuario 
		AND ex.Proveedor = 'Facebook' 
		AND ex.Estado = 1
	WHERE c.CodigoSap = @CodigoSap AND c.Estado = 1
	ORDER BY 
		CASE WHEN @Ordenar = 1 THEN d.FechaRegistro END ASC,
		CASE WHEN @Ordenar = 2 THEN d.FechaRegistro END DESC
	OFFSET @Limite ROWS
	FETCH NEXT @Cantidad ROWS ONLY;
END
GO