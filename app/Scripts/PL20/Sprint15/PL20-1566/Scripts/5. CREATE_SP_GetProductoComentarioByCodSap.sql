
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
		ProdComentarioId, 
		CodigoSap, 
		CodigoGenerico, 
		CantAprobados, 
		CantRecomendados
		PromValorizado
	FROM ProductoComentario
	WHERE CodigoSap = @CodigoSap AND Estado = 1
END
GO