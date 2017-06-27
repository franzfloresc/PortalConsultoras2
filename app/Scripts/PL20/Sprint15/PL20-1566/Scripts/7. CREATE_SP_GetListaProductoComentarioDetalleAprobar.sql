
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
	@CampaniaId INT,
	@Limite INT = 0,
	@Cantidad INT = 10,
	@Ordenar TINYINT = 1
)
AS
BEGIN

	DECLARE @CodigoSap VARCHAR(20), @CodigoGenerico VARCHAR(20)
	IF (@Tipo = 1)
	BEGIN
		SELECT TOP 1 @CodigoGenerico = RTRIM(CodigoGenerico) FROM ods.SAP_PRODUCTO WHERE CodigoSap = @Codigo
		SET @CodigoSap = @Codigo
	END
	ELSE
	BEGIN
		SELECT TOP 1 
			@CodigoSap = CodigoSap, 
			@CodigoGenerico = RTRIM(CodigoGenerico) 
		FROM ods.ProductoComercial pc 
		INNER JOIN ods.SAP_PRODUCTO sp ON pc.AnoCampania = @CampaniaId 
			AND pc.CodigoProducto = sp.CodigoSap
			AND pc.EstadoActivo = 1
		WHERE pc.CUV = @Codigo
	END

	SELECT c.ProdComentarioId, 
		d.ProdComentarioDetalleId, 
		d.Valorizado, 
		d.Comentario, 
		CAST(d.FechaRegistro AS DATE) AS FechaRegistro, 
		d.CodigoConsultora, 
		d.Estado
	FROM ProductoComentario c 
	INNER JOIN ProductoComentarioDetalle d ON c.ProdComentarioId = d.ProdComentarioId
		AND d.Estado = @Estado
	WHERE c.CodigoSap = @CodigoSap 
		AND c.CodigoGenerico = CASE WHEN @Tipo = 1 THEN c.CodigoGenerico ELSE @CodigoGenerico END
		AND c.Estado = 1
	ORDER BY c.FechaRegistro
	OFFSET @Limite ROWS
	FETCH NEXT @Cantidad ROWS ONLY;
END
GO