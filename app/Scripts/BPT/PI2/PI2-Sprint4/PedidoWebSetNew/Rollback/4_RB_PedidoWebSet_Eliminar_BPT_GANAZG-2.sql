GO
USE BelcorpPeru
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

GO
USE BelcorpMexico
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

GO
USE BelcorpColombia
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

GO
USE BelcorpSalvador
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

GO
USE BelcorpPuertoRico
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

GO
USE BelcorpPanama
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

GO
USE BelcorpGuatemala
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

GO
USE BelcorpEcuador
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

GO
USE BelcorpDominicana
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

GO
USE BelcorpCostaRica
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

GO
USE BelcorpChile
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

GO
USE BelcorpBolivia
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

GO
