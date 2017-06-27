
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
	@CodigoSap VARCHAR(20),
	@CodigoGenerico VARCHAR(20)
)
AS

BEGIN

	DECLARE @ProdComentarioId INT 

	SELECT TOP 1 @ProdComentarioId = ProdComentarioId 
	FROM ProductoComentario WHERE CodigoSap = @CodigoSap AND Estado = 1

	IF (ISNULL(@ProdComentarioId,0) = 0)
	BEGIN
		INSERT INTO ProductoComentario
		(
			CodigoSap,
			CodigoGenerico,
			CantComentarios,
			CantAprobados,
			CantRecomendados,
			FechaRegistro,
			Estado
		)
		VALUES 
		(
			@CodigoSap,
			@CodigoGenerico,
			0,
			0,
			0,
			GETDATE(),
			1
		)

		SET @ProdComentarioId = @@Identity
	END

	SELECT @ProdComentarioId
	
END
GO
