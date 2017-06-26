
USE BelcorpPeru
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
		WHERE object_id = OBJECT_ID(N'dbo.InsertProductoComentarioDetalle'))
BEGIN
    DROP PROCEDURE dbo.InsertProductoComentarioDetalle
END
GO

CREATE PROCEDURE dbo.InsertProductoComentarioDetalle
(
	@ProdComentarioId INT,
	@Valorizado TINYINT,
	@Recomendado BIT,
	@Comentario VARCHAR(400),
	@CodigoConsultora VARCHAR(20),
	@CampaniaID INT,
	@CodTipoOrigen INT
)
AS

BEGIN
	INSERT INTO ProductoComentarioDetalle
	(
		ProdComentarioId,
		Valorizado,
		Recomendado,
		Comentario,
		CodigoConsultora,
		CampaniaID,
		CodTipoOrigen,
		FechaRegistro,
		Estado
	)
	VALUES 
	(
		@ProdComentarioId,
		@Valorizado,
		@Recomendado,
		@Comentario,
		@CodigoConsultora,
		@CampaniaID,
		@CodTipoOrigen,
		GETDATE(),
		1
	)

	SELECT @@IDENTITY AS Id
END
GO