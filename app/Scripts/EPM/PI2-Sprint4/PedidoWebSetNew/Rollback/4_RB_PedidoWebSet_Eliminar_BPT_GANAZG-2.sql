USE [BelcorpCostaRica_BPT]
GO

ALTER PROCEDURE [dbo].[PedidoWebSet_Eliminar] @SetId INT
AS
BEGIN
	BEGIN TRAN

	BEGIN TRY
		DELETE
		FROM PedidoWebSetDetalle
		WHERE SetId = @SetId

		DELETE
		FROM PedidoWebSet
		WHERE SetId = @setID

		COMMIT
	END TRY

	BEGIN CATCH
		ROLLBACK
	END CATCH
END
