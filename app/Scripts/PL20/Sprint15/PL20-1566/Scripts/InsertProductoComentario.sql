
USE BelcorpPeru
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.InsertProductoComentario'))
BEGIN
    DROP PROCEDURE dbo.InsertProductoComentario
END
GO

CREATE PROCEDURE dbo.InsertProductoComentario
(
	@CodigoSAP VARCHAR(20),
	@CodigoGenerico VARCHAR(20)
)
AS

BEGIN

	DECLARE @ProdComentarioId INT 

	SELECT TOP 1 @ProdComentarioId = ProdComentarioId 
	FROM ProductoComentario WHERE CodigoSAP = @CodigoSAP AND Estado = 1

	IF (ISNULL(@ProdComentarioId,0) = 0)
	BEGIN
		INSERT INTO ProductoComentario
		(
			CodigoSAP,
			CodigoGenerico,
			CantComentarios,
			CantAprobados,
			CantRecomendados,
			FechaRegistro,
			Estado
		)
		VALUES 
		(
			@CodigoSAP,
			@CodigoGenerico,
			0,
			0,
			0,
			GETDATE(),
			1
		)

		SELECT @ProdComentarioId = SCOPE_IDENTITY()
	END

	SELECT @ProdComentarioId
	
END
GO

