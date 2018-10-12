USE belcorpBolivia
GO
IF (OBJECT_ID('dbo.InsertUpSellingRegalo', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.InsertUpSellingRegalo AS SET NOCOUNT ON;')
GO
alter PROCEDURE [dbo].[InsertUpSellingRegalo] (

	@CampaniaId INT

	,@ConsultoraId INT

	,@MontoPedido DECIMAL(18, 4)

	,@GapMinimo DECIMAL(18, 4)

	,@GapMaximo DECIMAL(18, 4)

	,@GapAgregar DECIMAL(18, 4)

	,@MontoMeta DECIMAL(18, 4)

	,@CUV VARCHAR(6)

	,@TipoRango VARCHAR(3)

	,@MontoPedidoFinal DECIMAL(18, 4)

	,@UpSellingDetalleId INT

	)

AS

BEGIN

	DECLARE @result INT

		,@stock INT



	SET @result = - 1



	SELECT @stock = Stock

	FROM UpSellingDetalle

	WHERE UpSellingDetalleId = @UpSellingDetalleId



	IF (@stock > 0)

	BEGIN

		IF EXISTS (

				SELECT 1

				FROM OfertaFinalMontoMeta

				WHERE CampaniaId = @CampaniaId

					AND ConsultoraId = @ConsultoraId

				)

		BEGIN

			UPDATE OfertaFinalMontoMeta

			SET CUV = @CUV,

				MontoPedidoFinal = @MontoPedidoFinal

			WHERE CampaniaId = @CampaniaId

				AND ConsultoraId = @ConsultoraId



			SET @result = 1

		END

		ELSE

		BEGIN

			INSERT INTO OfertaFinalMontoMeta (

				CampaniaId

				,ConsultoraId

				,MontoPedido

				,GapMinimo

				,GapMaximo

				,GapAgregar

				,MontoMeta

				,CUV

				,TipoRango

				,MontoPedidoFinal

				)

			VALUES (

				@CampaniaId

				,@ConsultoraId

				,@MontoPedido

				,@GapMinimo

				,@GapMaximo

				,@GapAgregar

				,@MontoMeta

				,@CUV

				,@TipoRango

				,@MontoPedidoFinal

				)



			SET @result = 1

		END

	END



	SELECT @result AS result

END
GO
USE belcorpChile
GO
IF (OBJECT_ID('dbo.InsertUpSellingRegalo', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.InsertUpSellingRegalo AS SET NOCOUNT ON;')
GO
alter PROCEDURE [dbo].[InsertUpSellingRegalo] (

	@CampaniaId INT

	,@ConsultoraId INT

	,@MontoPedido DECIMAL(18, 4)

	,@GapMinimo DECIMAL(18, 4)

	,@GapMaximo DECIMAL(18, 4)

	,@GapAgregar DECIMAL(18, 4)

	,@MontoMeta DECIMAL(18, 4)

	,@CUV VARCHAR(6)

	,@TipoRango VARCHAR(3)

	,@MontoPedidoFinal DECIMAL(18, 4)

	,@UpSellingDetalleId INT

	)

AS

BEGIN

	DECLARE @result INT

		,@stock INT



	SET @result = - 1



	SELECT @stock = Stock

	FROM UpSellingDetalle

	WHERE UpSellingDetalleId = @UpSellingDetalleId



	IF (@stock > 0)

	BEGIN

		IF EXISTS (

				SELECT 1

				FROM OfertaFinalMontoMeta

				WHERE CampaniaId = @CampaniaId

					AND ConsultoraId = @ConsultoraId

				)

		BEGIN

			UPDATE OfertaFinalMontoMeta

			SET CUV = @CUV,

				MontoPedidoFinal = @MontoPedidoFinal

			WHERE CampaniaId = @CampaniaId

				AND ConsultoraId = @ConsultoraId



			SET @result = 1

		END

		ELSE

		BEGIN

			INSERT INTO OfertaFinalMontoMeta (

				CampaniaId

				,ConsultoraId

				,MontoPedido

				,GapMinimo

				,GapMaximo

				,GapAgregar

				,MontoMeta

				,CUV

				,TipoRango

				,MontoPedidoFinal

				)

			VALUES (

				@CampaniaId

				,@ConsultoraId

				,@MontoPedido

				,@GapMinimo

				,@GapMaximo

				,@GapAgregar

				,@MontoMeta

				,@CUV

				,@TipoRango

				,@MontoPedidoFinal

				)



			SET @result = 1

		END

	END



	SELECT @result AS result

END
GO
USE belcorpColombia
GO
IF (OBJECT_ID('dbo.InsertUpSellingRegalo', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.InsertUpSellingRegalo AS SET NOCOUNT ON;')
GO
alter PROCEDURE [dbo].[InsertUpSellingRegalo] (

	@CampaniaId INT

	,@ConsultoraId INT

	,@MontoPedido DECIMAL(18, 4)

	,@GapMinimo DECIMAL(18, 4)

	,@GapMaximo DECIMAL(18, 4)

	,@GapAgregar DECIMAL(18, 4)

	,@MontoMeta DECIMAL(18, 4)

	,@CUV VARCHAR(6)

	,@TipoRango VARCHAR(3)

	,@MontoPedidoFinal DECIMAL(18, 4)

	,@UpSellingDetalleId INT

	)

AS

BEGIN

	DECLARE @result INT

		,@stock INT



	SET @result = - 1



	SELECT @stock = Stock

	FROM UpSellingDetalle

	WHERE UpSellingDetalleId = @UpSellingDetalleId



	IF (@stock > 0)

	BEGIN

		IF EXISTS (

				SELECT 1

				FROM OfertaFinalMontoMeta

				WHERE CampaniaId = @CampaniaId

					AND ConsultoraId = @ConsultoraId

				)

		BEGIN

			UPDATE OfertaFinalMontoMeta

			SET CUV = @CUV,

				MontoPedidoFinal = @MontoPedidoFinal

			WHERE CampaniaId = @CampaniaId

				AND ConsultoraId = @ConsultoraId



			SET @result = 1

		END

		ELSE

		BEGIN

			INSERT INTO OfertaFinalMontoMeta (

				CampaniaId

				,ConsultoraId

				,MontoPedido

				,GapMinimo

				,GapMaximo

				,GapAgregar

				,MontoMeta

				,CUV

				,TipoRango

				,MontoPedidoFinal

				)

			VALUES (

				@CampaniaId

				,@ConsultoraId

				,@MontoPedido

				,@GapMinimo

				,@GapMaximo

				,@GapAgregar

				,@MontoMeta

				,@CUV

				,@TipoRango

				,@MontoPedidoFinal

				)



			SET @result = 1

		END

	END



	SELECT @result AS result

END
GO
USE belcorpCostaRica
GO
IF (OBJECT_ID('dbo.InsertUpSellingRegalo', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.InsertUpSellingRegalo AS SET NOCOUNT ON;')
GO
alter PROCEDURE [dbo].[InsertUpSellingRegalo] (

	@CampaniaId INT

	,@ConsultoraId INT

	,@MontoPedido DECIMAL(18, 4)

	,@GapMinimo DECIMAL(18, 4)

	,@GapMaximo DECIMAL(18, 4)

	,@GapAgregar DECIMAL(18, 4)

	,@MontoMeta DECIMAL(18, 4)

	,@CUV VARCHAR(6)

	,@TipoRango VARCHAR(3)

	,@MontoPedidoFinal DECIMAL(18, 4)

	,@UpSellingDetalleId INT

	)

AS

BEGIN

	DECLARE @result INT

		,@stock INT



	SET @result = - 1



	SELECT @stock = Stock

	FROM UpSellingDetalle

	WHERE UpSellingDetalleId = @UpSellingDetalleId



	IF (@stock > 0)

	BEGIN

		IF EXISTS (

				SELECT 1

				FROM OfertaFinalMontoMeta

				WHERE CampaniaId = @CampaniaId

					AND ConsultoraId = @ConsultoraId

				)

		BEGIN

			UPDATE OfertaFinalMontoMeta

			SET CUV = @CUV,

				MontoPedidoFinal = @MontoPedidoFinal

			WHERE CampaniaId = @CampaniaId

				AND ConsultoraId = @ConsultoraId



			SET @result = 1

		END

		ELSE

		BEGIN

			INSERT INTO OfertaFinalMontoMeta (

				CampaniaId

				,ConsultoraId

				,MontoPedido

				,GapMinimo

				,GapMaximo

				,GapAgregar

				,MontoMeta

				,CUV

				,TipoRango

				,MontoPedidoFinal

				)

			VALUES (

				@CampaniaId

				,@ConsultoraId

				,@MontoPedido

				,@GapMinimo

				,@GapMaximo

				,@GapAgregar

				,@MontoMeta

				,@CUV

				,@TipoRango

				,@MontoPedidoFinal

				)



			SET @result = 1

		END

	END



	SELECT @result AS result

END
GO
USE belcorpDominicana
GO
IF (OBJECT_ID('dbo.InsertUpSellingRegalo', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.InsertUpSellingRegalo AS SET NOCOUNT ON;')
GO
alter PROCEDURE [dbo].[InsertUpSellingRegalo] (

	@CampaniaId INT

	,@ConsultoraId INT

	,@MontoPedido DECIMAL(18, 4)

	,@GapMinimo DECIMAL(18, 4)

	,@GapMaximo DECIMAL(18, 4)

	,@GapAgregar DECIMAL(18, 4)

	,@MontoMeta DECIMAL(18, 4)

	,@CUV VARCHAR(6)

	,@TipoRango VARCHAR(3)

	,@MontoPedidoFinal DECIMAL(18, 4)

	,@UpSellingDetalleId INT

	)

AS

BEGIN

	DECLARE @result INT

		,@stock INT



	SET @result = - 1



	SELECT @stock = Stock

	FROM UpSellingDetalle

	WHERE UpSellingDetalleId = @UpSellingDetalleId



	IF (@stock > 0)

	BEGIN

		IF EXISTS (

				SELECT 1

				FROM OfertaFinalMontoMeta

				WHERE CampaniaId = @CampaniaId

					AND ConsultoraId = @ConsultoraId

				)

		BEGIN

			UPDATE OfertaFinalMontoMeta

			SET CUV = @CUV,

				MontoPedidoFinal = @MontoPedidoFinal

			WHERE CampaniaId = @CampaniaId

				AND ConsultoraId = @ConsultoraId



			SET @result = 1

		END

		ELSE

		BEGIN

			INSERT INTO OfertaFinalMontoMeta (

				CampaniaId

				,ConsultoraId

				,MontoPedido

				,GapMinimo

				,GapMaximo

				,GapAgregar

				,MontoMeta

				,CUV

				,TipoRango

				,MontoPedidoFinal

				)

			VALUES (

				@CampaniaId

				,@ConsultoraId

				,@MontoPedido

				,@GapMinimo

				,@GapMaximo

				,@GapAgregar

				,@MontoMeta

				,@CUV

				,@TipoRango

				,@MontoPedidoFinal

				)



			SET @result = 1

		END

	END



	SELECT @result AS result

END
GO
USE belcorpEcuador
GO
IF (OBJECT_ID('dbo.InsertUpSellingRegalo', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.InsertUpSellingRegalo AS SET NOCOUNT ON;')
GO
alter PROCEDURE [dbo].[InsertUpSellingRegalo] (

	@CampaniaId INT

	,@ConsultoraId INT

	,@MontoPedido DECIMAL(18, 4)

	,@GapMinimo DECIMAL(18, 4)

	,@GapMaximo DECIMAL(18, 4)

	,@GapAgregar DECIMAL(18, 4)

	,@MontoMeta DECIMAL(18, 4)

	,@CUV VARCHAR(6)

	,@TipoRango VARCHAR(3)

	,@MontoPedidoFinal DECIMAL(18, 4)

	,@UpSellingDetalleId INT

	)

AS

BEGIN

	DECLARE @result INT

		,@stock INT



	SET @result = - 1



	SELECT @stock = Stock

	FROM UpSellingDetalle

	WHERE UpSellingDetalleId = @UpSellingDetalleId



	IF (@stock > 0)

	BEGIN

		IF EXISTS (

				SELECT 1

				FROM OfertaFinalMontoMeta

				WHERE CampaniaId = @CampaniaId

					AND ConsultoraId = @ConsultoraId

				)

		BEGIN

			UPDATE OfertaFinalMontoMeta

			SET CUV = @CUV,

				MontoPedidoFinal = @MontoPedidoFinal

			WHERE CampaniaId = @CampaniaId

				AND ConsultoraId = @ConsultoraId



			SET @result = 1

		END

		ELSE

		BEGIN

			INSERT INTO OfertaFinalMontoMeta (

				CampaniaId

				,ConsultoraId

				,MontoPedido

				,GapMinimo

				,GapMaximo

				,GapAgregar

				,MontoMeta

				,CUV

				,TipoRango

				,MontoPedidoFinal

				)

			VALUES (

				@CampaniaId

				,@ConsultoraId

				,@MontoPedido

				,@GapMinimo

				,@GapMaximo

				,@GapAgregar

				,@MontoMeta

				,@CUV

				,@TipoRango

				,@MontoPedidoFinal

				)



			SET @result = 1

		END

	END



	SELECT @result AS result

END
GO
USE belcorpGuatemala
GO
IF (OBJECT_ID('dbo.InsertUpSellingRegalo', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.InsertUpSellingRegalo AS SET NOCOUNT ON;')
GO
alter PROCEDURE [dbo].[InsertUpSellingRegalo] (

	@CampaniaId INT

	,@ConsultoraId INT

	,@MontoPedido DECIMAL(18, 4)

	,@GapMinimo DECIMAL(18, 4)

	,@GapMaximo DECIMAL(18, 4)

	,@GapAgregar DECIMAL(18, 4)

	,@MontoMeta DECIMAL(18, 4)

	,@CUV VARCHAR(6)

	,@TipoRango VARCHAR(3)

	,@MontoPedidoFinal DECIMAL(18, 4)

	,@UpSellingDetalleId INT

	)

AS

BEGIN

	DECLARE @result INT

		,@stock INT



	SET @result = - 1



	SELECT @stock = Stock

	FROM UpSellingDetalle

	WHERE UpSellingDetalleId = @UpSellingDetalleId



	IF (@stock > 0)

	BEGIN

		IF EXISTS (

				SELECT 1

				FROM OfertaFinalMontoMeta

				WHERE CampaniaId = @CampaniaId

					AND ConsultoraId = @ConsultoraId

				)

		BEGIN

			UPDATE OfertaFinalMontoMeta

			SET CUV = @CUV,

				MontoPedidoFinal = @MontoPedidoFinal

			WHERE CampaniaId = @CampaniaId

				AND ConsultoraId = @ConsultoraId



			SET @result = 1

		END

		ELSE

		BEGIN

			INSERT INTO OfertaFinalMontoMeta (

				CampaniaId

				,ConsultoraId

				,MontoPedido

				,GapMinimo

				,GapMaximo

				,GapAgregar

				,MontoMeta

				,CUV

				,TipoRango

				,MontoPedidoFinal

				)

			VALUES (

				@CampaniaId

				,@ConsultoraId

				,@MontoPedido

				,@GapMinimo

				,@GapMaximo

				,@GapAgregar

				,@MontoMeta

				,@CUV

				,@TipoRango

				,@MontoPedidoFinal

				)



			SET @result = 1

		END

	END



	SELECT @result AS result

END
GO
USE belcorpMexico
GO
IF (OBJECT_ID('dbo.InsertUpSellingRegalo', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.InsertUpSellingRegalo AS SET NOCOUNT ON;')
GO
alter PROCEDURE [dbo].[InsertUpSellingRegalo] (

	@CampaniaId INT

	,@ConsultoraId INT

	,@MontoPedido DECIMAL(18, 4)

	,@GapMinimo DECIMAL(18, 4)

	,@GapMaximo DECIMAL(18, 4)

	,@GapAgregar DECIMAL(18, 4)

	,@MontoMeta DECIMAL(18, 4)

	,@CUV VARCHAR(6)

	,@TipoRango VARCHAR(3)

	,@MontoPedidoFinal DECIMAL(18, 4)

	,@UpSellingDetalleId INT

	)

AS

BEGIN

	DECLARE @result INT

		,@stock INT



	SET @result = - 1



	SELECT @stock = Stock

	FROM UpSellingDetalle

	WHERE UpSellingDetalleId = @UpSellingDetalleId



	IF (@stock > 0)

	BEGIN

		IF EXISTS (

				SELECT 1

				FROM OfertaFinalMontoMeta

				WHERE CampaniaId = @CampaniaId

					AND ConsultoraId = @ConsultoraId

				)

		BEGIN

			UPDATE OfertaFinalMontoMeta

			SET CUV = @CUV,

				MontoPedidoFinal = @MontoPedidoFinal

			WHERE CampaniaId = @CampaniaId

				AND ConsultoraId = @ConsultoraId



			SET @result = 1

		END

		ELSE

		BEGIN

			INSERT INTO OfertaFinalMontoMeta (

				CampaniaId

				,ConsultoraId

				,MontoPedido

				,GapMinimo

				,GapMaximo

				,GapAgregar

				,MontoMeta

				,CUV

				,TipoRango

				,MontoPedidoFinal

				)

			VALUES (

				@CampaniaId

				,@ConsultoraId

				,@MontoPedido

				,@GapMinimo

				,@GapMaximo

				,@GapAgregar

				,@MontoMeta

				,@CUV

				,@TipoRango

				,@MontoPedidoFinal

				)



			SET @result = 1

		END

	END



	SELECT @result AS result

END
GO
USE belcorpPanama
GO
IF (OBJECT_ID('dbo.InsertUpSellingRegalo', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.InsertUpSellingRegalo AS SET NOCOUNT ON;')
GO
alter PROCEDURE [dbo].[InsertUpSellingRegalo] (

	@CampaniaId INT

	,@ConsultoraId INT

	,@MontoPedido DECIMAL(18, 4)

	,@GapMinimo DECIMAL(18, 4)

	,@GapMaximo DECIMAL(18, 4)

	,@GapAgregar DECIMAL(18, 4)

	,@MontoMeta DECIMAL(18, 4)

	,@CUV VARCHAR(6)

	,@TipoRango VARCHAR(3)

	,@MontoPedidoFinal DECIMAL(18, 4)

	,@UpSellingDetalleId INT

	)

AS

BEGIN

	DECLARE @result INT

		,@stock INT



	SET @result = - 1



	SELECT @stock = Stock

	FROM UpSellingDetalle

	WHERE UpSellingDetalleId = @UpSellingDetalleId



	IF (@stock > 0)

	BEGIN

		IF EXISTS (

				SELECT 1

				FROM OfertaFinalMontoMeta

				WHERE CampaniaId = @CampaniaId

					AND ConsultoraId = @ConsultoraId

				)

		BEGIN

			UPDATE OfertaFinalMontoMeta

			SET CUV = @CUV,

				MontoPedidoFinal = @MontoPedidoFinal

			WHERE CampaniaId = @CampaniaId

				AND ConsultoraId = @ConsultoraId



			SET @result = 1

		END

		ELSE

		BEGIN

			INSERT INTO OfertaFinalMontoMeta (

				CampaniaId

				,ConsultoraId

				,MontoPedido

				,GapMinimo

				,GapMaximo

				,GapAgregar

				,MontoMeta

				,CUV

				,TipoRango

				,MontoPedidoFinal

				)

			VALUES (

				@CampaniaId

				,@ConsultoraId

				,@MontoPedido

				,@GapMinimo

				,@GapMaximo

				,@GapAgregar

				,@MontoMeta

				,@CUV

				,@TipoRango

				,@MontoPedidoFinal

				)



			SET @result = 1

		END

	END



	SELECT @result AS result

END
GO
USE belcorpPeru
GO
IF (OBJECT_ID('dbo.InsertUpSellingRegalo', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.InsertUpSellingRegalo AS SET NOCOUNT ON;')
GO
alter PROCEDURE [dbo].[InsertUpSellingRegalo] (

	@CampaniaId INT

	,@ConsultoraId INT

	,@MontoPedido DECIMAL(18, 4)

	,@GapMinimo DECIMAL(18, 4)

	,@GapMaximo DECIMAL(18, 4)

	,@GapAgregar DECIMAL(18, 4)

	,@MontoMeta DECIMAL(18, 4)

	,@CUV VARCHAR(6)

	,@TipoRango VARCHAR(3)

	,@MontoPedidoFinal DECIMAL(18, 4)

	,@UpSellingDetalleId INT

	)

AS

BEGIN

	DECLARE @result INT

		,@stock INT



	SET @result = - 1



	SELECT @stock = Stock

	FROM UpSellingDetalle

	WHERE UpSellingDetalleId = @UpSellingDetalleId



	IF (@stock > 0)

	BEGIN

		IF EXISTS (

				SELECT 1

				FROM OfertaFinalMontoMeta

				WHERE CampaniaId = @CampaniaId

					AND ConsultoraId = @ConsultoraId

				)

		BEGIN

			UPDATE OfertaFinalMontoMeta

			SET CUV = @CUV,

				MontoPedidoFinal = @MontoPedidoFinal

			WHERE CampaniaId = @CampaniaId

				AND ConsultoraId = @ConsultoraId



			SET @result = 1

		END

		ELSE

		BEGIN

			INSERT INTO OfertaFinalMontoMeta (

				CampaniaId

				,ConsultoraId

				,MontoPedido

				,GapMinimo

				,GapMaximo

				,GapAgregar

				,MontoMeta

				,CUV

				,TipoRango

				,MontoPedidoFinal

				)

			VALUES (

				@CampaniaId

				,@ConsultoraId

				,@MontoPedido

				,@GapMinimo

				,@GapMaximo

				,@GapAgregar

				,@MontoMeta

				,@CUV

				,@TipoRango

				,@MontoPedidoFinal

				)



			SET @result = 1

		END

	END



	SELECT @result AS result

END
GO
USE belcorpPuertoRico
GO
IF (OBJECT_ID('dbo.InsertUpSellingRegalo', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.InsertUpSellingRegalo AS SET NOCOUNT ON;')
GO
alter PROCEDURE [dbo].[InsertUpSellingRegalo] (

	@CampaniaId INT

	,@ConsultoraId INT

	,@MontoPedido DECIMAL(18, 4)

	,@GapMinimo DECIMAL(18, 4)

	,@GapMaximo DECIMAL(18, 4)

	,@GapAgregar DECIMAL(18, 4)

	,@MontoMeta DECIMAL(18, 4)

	,@CUV VARCHAR(6)

	,@TipoRango VARCHAR(3)

	,@MontoPedidoFinal DECIMAL(18, 4)

	,@UpSellingDetalleId INT

	)

AS

BEGIN

	DECLARE @result INT

		,@stock INT



	SET @result = - 1



	SELECT @stock = Stock

	FROM UpSellingDetalle

	WHERE UpSellingDetalleId = @UpSellingDetalleId



	IF (@stock > 0)

	BEGIN

		IF EXISTS (

				SELECT 1

				FROM OfertaFinalMontoMeta

				WHERE CampaniaId = @CampaniaId

					AND ConsultoraId = @ConsultoraId

				)

		BEGIN

			UPDATE OfertaFinalMontoMeta

			SET CUV = @CUV,

				MontoPedidoFinal = @MontoPedidoFinal

			WHERE CampaniaId = @CampaniaId

				AND ConsultoraId = @ConsultoraId



			SET @result = 1

		END

		ELSE

		BEGIN

			INSERT INTO OfertaFinalMontoMeta (

				CampaniaId

				,ConsultoraId

				,MontoPedido

				,GapMinimo

				,GapMaximo

				,GapAgregar

				,MontoMeta

				,CUV

				,TipoRango

				,MontoPedidoFinal

				)

			VALUES (

				@CampaniaId

				,@ConsultoraId

				,@MontoPedido

				,@GapMinimo

				,@GapMaximo

				,@GapAgregar

				,@MontoMeta

				,@CUV

				,@TipoRango

				,@MontoPedidoFinal

				)



			SET @result = 1

		END

	END



	SELECT @result AS result

END
GO
USE belcorpSalvador
GO
IF (OBJECT_ID('dbo.InsertUpSellingRegalo', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.InsertUpSellingRegalo AS SET NOCOUNT ON;')
GO
alter PROCEDURE [dbo].[InsertUpSellingRegalo] (

	@CampaniaId INT

	,@ConsultoraId INT

	,@MontoPedido DECIMAL(18, 4)

	,@GapMinimo DECIMAL(18, 4)

	,@GapMaximo DECIMAL(18, 4)

	,@GapAgregar DECIMAL(18, 4)

	,@MontoMeta DECIMAL(18, 4)

	,@CUV VARCHAR(6)

	,@TipoRango VARCHAR(3)

	,@MontoPedidoFinal DECIMAL(18, 4)

	,@UpSellingDetalleId INT

	)

AS

BEGIN

	DECLARE @result INT

		,@stock INT



	SET @result = - 1



	SELECT @stock = Stock

	FROM UpSellingDetalle

	WHERE UpSellingDetalleId = @UpSellingDetalleId



	IF (@stock > 0)

	BEGIN

		IF EXISTS (

				SELECT 1

				FROM OfertaFinalMontoMeta

				WHERE CampaniaId = @CampaniaId

					AND ConsultoraId = @ConsultoraId

				)

		BEGIN

			UPDATE OfertaFinalMontoMeta

			SET CUV = @CUV,

				MontoPedidoFinal = @MontoPedidoFinal

			WHERE CampaniaId = @CampaniaId

				AND ConsultoraId = @ConsultoraId



			SET @result = 1

		END

		ELSE

		BEGIN

			INSERT INTO OfertaFinalMontoMeta (

				CampaniaId

				,ConsultoraId

				,MontoPedido

				,GapMinimo

				,GapMaximo

				,GapAgregar

				,MontoMeta

				,CUV

				,TipoRango

				,MontoPedidoFinal

				)

			VALUES (

				@CampaniaId

				,@ConsultoraId

				,@MontoPedido

				,@GapMinimo

				,@GapMaximo

				,@GapAgregar

				,@MontoMeta

				,@CUV

				,@TipoRango

				,@MontoPedidoFinal

				)



			SET @result = 1

		END

	END



	SELECT @result AS result

END
GO
