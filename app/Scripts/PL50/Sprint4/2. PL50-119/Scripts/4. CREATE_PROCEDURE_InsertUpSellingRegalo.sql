

USE BelcorpBolivia
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'InsertUpSellingRegalo')
BEGIN
	DROP PROCEDURE dbo.InsertUpSellingRegalo 
END
GO

CREATE PROCEDURE [dbo].[InsertUpSellingRegalo]
(
	@CampaniaId INT,
	@ConsultoraId INT,
	@MontoPedido DECIMAL(18,4),
	@GapMinimo DECIMAL(18,4),
	@GapMaximo DECIMAL(18,4),
	@GapAgregar DECIMAL(18,4),
	@MontoMeta DECIMAL(18,4),
	@CUV VARCHAR(6),
	@TipoRango VARCHAR(3),
	@MontoPedidoFinal DECIMAL(18,4),
	@UpSellingDetalleId INT
)
as
begin
	DECLARE @result INT, @stock INT
	SET @result = -1

	SELECT @stock = Stock FROM UpSellingDetalle WHERE UpSellingDetalleId = @UpSellingDetalleId

	IF (@stock > 0)
	BEGIN
		IF EXISTS (SELECT 1 FROM OfertaFinalMontoMeta WHERE CampaniaId = @CampaniaId AND ConsultoraId = @ConsultoraId)
		BEGIN
			UPDATE OfertaFinalMontoMeta 
			SET CUV = @CUV 
			WHERE CampaniaId = @CampaniaId 
			AND ConsultoraId = @ConsultoraId

			SET @result = 1
		END
		ELSE
		BEGIN
			INSERT INTO OfertaFinalMontoMeta 
			(
				CampaniaId,
				ConsultoraId,
				MontoPedido,
				GapMinimo,
				GapMaximo,
				GapAgregar,
				MontoMeta,
				CUV,
				TipoRango,
				MontoPedidoFinal
			)
			VALUES 
			(
				@CampaniaId,
				@ConsultoraId,
				@MontoPedido,
				@GapMinimo,
				@GapMaximo,
				@GapAgregar,
				@MontoMeta,
				@CUV,
				@TipoRango,
				@MontoPedidoFinal
			)

			SET @result = 1
		END
	END

	SELECT @result AS result
	
END
GO

USE BelcorpChile
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'InsertUpSellingRegalo')
BEGIN
	DROP PROCEDURE dbo.InsertUpSellingRegalo 
END
GO

CREATE PROCEDURE [dbo].[InsertUpSellingRegalo]
(
	@CampaniaId INT,
	@ConsultoraId INT,
	@MontoPedido DECIMAL(18,4),
	@GapMinimo DECIMAL(18,4),
	@GapMaximo DECIMAL(18,4),
	@GapAgregar DECIMAL(18,4),
	@MontoMeta DECIMAL(18,4),
	@CUV VARCHAR(6),
	@TipoRango VARCHAR(3),
	@MontoPedidoFinal DECIMAL(18,4),
	@UpSellingDetalleId INT
)
as
begin
	DECLARE @result INT, @stock INT
	SET @result = -1

	SELECT @stock = Stock FROM UpSellingDetalle WHERE UpSellingDetalleId = @UpSellingDetalleId

	IF (@stock > 0)
	BEGIN
		IF EXISTS (SELECT 1 FROM OfertaFinalMontoMeta WHERE CampaniaId = @CampaniaId AND ConsultoraId = @ConsultoraId)
		BEGIN
			UPDATE OfertaFinalMontoMeta 
			SET CUV = @CUV 
			WHERE CampaniaId = @CampaniaId 
			AND ConsultoraId = @ConsultoraId

			SET @result = 1
		END
		ELSE
		BEGIN
			INSERT INTO OfertaFinalMontoMeta 
			(
				CampaniaId,
				ConsultoraId,
				MontoPedido,
				GapMinimo,
				GapMaximo,
				GapAgregar,
				MontoMeta,
				CUV,
				TipoRango,
				MontoPedidoFinal
			)
			VALUES 
			(
				@CampaniaId,
				@ConsultoraId,
				@MontoPedido,
				@GapMinimo,
				@GapMaximo,
				@GapAgregar,
				@MontoMeta,
				@CUV,
				@TipoRango,
				@MontoPedidoFinal
			)

			SET @result = 1
		END
	END

	SELECT @result AS result
	
END
GO

USE BelcorpColombia
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'InsertUpSellingRegalo')
BEGIN
	DROP PROCEDURE dbo.InsertUpSellingRegalo 
END
GO

CREATE PROCEDURE [dbo].[InsertUpSellingRegalo]
(
	@CampaniaId INT,
	@ConsultoraId INT,
	@MontoPedido DECIMAL(18,4),
	@GapMinimo DECIMAL(18,4),
	@GapMaximo DECIMAL(18,4),
	@GapAgregar DECIMAL(18,4),
	@MontoMeta DECIMAL(18,4),
	@CUV VARCHAR(6),
	@TipoRango VARCHAR(3),
	@MontoPedidoFinal DECIMAL(18,4),
	@UpSellingDetalleId INT
)
as
begin
	DECLARE @result INT, @stock INT
	SET @result = -1

	SELECT @stock = Stock FROM UpSellingDetalle WHERE UpSellingDetalleId = @UpSellingDetalleId

	IF (@stock > 0)
	BEGIN
		IF EXISTS (SELECT 1 FROM OfertaFinalMontoMeta WHERE CampaniaId = @CampaniaId AND ConsultoraId = @ConsultoraId)
		BEGIN
			UPDATE OfertaFinalMontoMeta 
			SET CUV = @CUV 
			WHERE CampaniaId = @CampaniaId 
			AND ConsultoraId = @ConsultoraId

			SET @result = 1
		END
		ELSE
		BEGIN
			INSERT INTO OfertaFinalMontoMeta 
			(
				CampaniaId,
				ConsultoraId,
				MontoPedido,
				GapMinimo,
				GapMaximo,
				GapAgregar,
				MontoMeta,
				CUV,
				TipoRango,
				MontoPedidoFinal
			)
			VALUES 
			(
				@CampaniaId,
				@ConsultoraId,
				@MontoPedido,
				@GapMinimo,
				@GapMaximo,
				@GapAgregar,
				@MontoMeta,
				@CUV,
				@TipoRango,
				@MontoPedidoFinal
			)

			SET @result = 1
		END
	END

	SELECT @result AS result
	
END
GO

USE BelcorpCostaRica
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'InsertUpSellingRegalo')
BEGIN
	DROP PROCEDURE dbo.InsertUpSellingRegalo 
END
GO

CREATE PROCEDURE [dbo].[InsertUpSellingRegalo]
(
	@CampaniaId INT,
	@ConsultoraId INT,
	@MontoPedido DECIMAL(18,4),
	@GapMinimo DECIMAL(18,4),
	@GapMaximo DECIMAL(18,4),
	@GapAgregar DECIMAL(18,4),
	@MontoMeta DECIMAL(18,4),
	@CUV VARCHAR(6),
	@TipoRango VARCHAR(3),
	@MontoPedidoFinal DECIMAL(18,4),
	@UpSellingDetalleId INT
)
as
begin
	DECLARE @result INT, @stock INT
	SET @result = -1

	SELECT @stock = Stock FROM UpSellingDetalle WHERE UpSellingDetalleId = @UpSellingDetalleId

	IF (@stock > 0)
	BEGIN
		IF EXISTS (SELECT 1 FROM OfertaFinalMontoMeta WHERE CampaniaId = @CampaniaId AND ConsultoraId = @ConsultoraId)
		BEGIN
			UPDATE OfertaFinalMontoMeta 
			SET CUV = @CUV 
			WHERE CampaniaId = @CampaniaId 
			AND ConsultoraId = @ConsultoraId

			SET @result = 1
		END
		ELSE
		BEGIN
			INSERT INTO OfertaFinalMontoMeta 
			(
				CampaniaId,
				ConsultoraId,
				MontoPedido,
				GapMinimo,
				GapMaximo,
				GapAgregar,
				MontoMeta,
				CUV,
				TipoRango,
				MontoPedidoFinal
			)
			VALUES 
			(
				@CampaniaId,
				@ConsultoraId,
				@MontoPedido,
				@GapMinimo,
				@GapMaximo,
				@GapAgregar,
				@MontoMeta,
				@CUV,
				@TipoRango,
				@MontoPedidoFinal
			)

			SET @result = 1
		END
	END

	SELECT @result AS result
	
END
GO

USE BelcorpDominicana
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'InsertUpSellingRegalo')
BEGIN
	DROP PROCEDURE dbo.InsertUpSellingRegalo 
END
GO

CREATE PROCEDURE [dbo].[InsertUpSellingRegalo]
(
	@CampaniaId INT,
	@ConsultoraId INT,
	@MontoPedido DECIMAL(18,4),
	@GapMinimo DECIMAL(18,4),
	@GapMaximo DECIMAL(18,4),
	@GapAgregar DECIMAL(18,4),
	@MontoMeta DECIMAL(18,4),
	@CUV VARCHAR(6),
	@TipoRango VARCHAR(3),
	@MontoPedidoFinal DECIMAL(18,4),
	@UpSellingDetalleId INT
)
as
begin
	DECLARE @result INT, @stock INT
	SET @result = -1

	SELECT @stock = Stock FROM UpSellingDetalle WHERE UpSellingDetalleId = @UpSellingDetalleId

	IF (@stock > 0)
	BEGIN
		IF EXISTS (SELECT 1 FROM OfertaFinalMontoMeta WHERE CampaniaId = @CampaniaId AND ConsultoraId = @ConsultoraId)
		BEGIN
			UPDATE OfertaFinalMontoMeta 
			SET CUV = @CUV 
			WHERE CampaniaId = @CampaniaId 
			AND ConsultoraId = @ConsultoraId

			SET @result = 1
		END
		ELSE
		BEGIN
			INSERT INTO OfertaFinalMontoMeta 
			(
				CampaniaId,
				ConsultoraId,
				MontoPedido,
				GapMinimo,
				GapMaximo,
				GapAgregar,
				MontoMeta,
				CUV,
				TipoRango,
				MontoPedidoFinal
			)
			VALUES 
			(
				@CampaniaId,
				@ConsultoraId,
				@MontoPedido,
				@GapMinimo,
				@GapMaximo,
				@GapAgregar,
				@MontoMeta,
				@CUV,
				@TipoRango,
				@MontoPedidoFinal
			)

			SET @result = 1
		END
	END

	SELECT @result AS result
	
END
GO

USE BelcorpEcuador
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'InsertUpSellingRegalo')
BEGIN
	DROP PROCEDURE dbo.InsertUpSellingRegalo 
END
GO

CREATE PROCEDURE [dbo].[InsertUpSellingRegalo]
(
	@CampaniaId INT,
	@ConsultoraId INT,
	@MontoPedido DECIMAL(18,4),
	@GapMinimo DECIMAL(18,4),
	@GapMaximo DECIMAL(18,4),
	@GapAgregar DECIMAL(18,4),
	@MontoMeta DECIMAL(18,4),
	@CUV VARCHAR(6),
	@TipoRango VARCHAR(3),
	@MontoPedidoFinal DECIMAL(18,4),
	@UpSellingDetalleId INT
)
as
begin
	DECLARE @result INT, @stock INT
	SET @result = -1

	SELECT @stock = Stock FROM UpSellingDetalle WHERE UpSellingDetalleId = @UpSellingDetalleId

	IF (@stock > 0)
	BEGIN
		IF EXISTS (SELECT 1 FROM OfertaFinalMontoMeta WHERE CampaniaId = @CampaniaId AND ConsultoraId = @ConsultoraId)
		BEGIN
			UPDATE OfertaFinalMontoMeta 
			SET CUV = @CUV 
			WHERE CampaniaId = @CampaniaId 
			AND ConsultoraId = @ConsultoraId

			SET @result = 1
		END
		ELSE
		BEGIN
			INSERT INTO OfertaFinalMontoMeta 
			(
				CampaniaId,
				ConsultoraId,
				MontoPedido,
				GapMinimo,
				GapMaximo,
				GapAgregar,
				MontoMeta,
				CUV,
				TipoRango,
				MontoPedidoFinal
			)
			VALUES 
			(
				@CampaniaId,
				@ConsultoraId,
				@MontoPedido,
				@GapMinimo,
				@GapMaximo,
				@GapAgregar,
				@MontoMeta,
				@CUV,
				@TipoRango,
				@MontoPedidoFinal
			)

			SET @result = 1
		END
	END

	SELECT @result AS result
	
END
GO

USE BelcorpGuatemala
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'InsertUpSellingRegalo')
BEGIN
	DROP PROCEDURE dbo.InsertUpSellingRegalo 
END
GO

CREATE PROCEDURE [dbo].[InsertUpSellingRegalo]
(
	@CampaniaId INT,
	@ConsultoraId INT,
	@MontoPedido DECIMAL(18,4),
	@GapMinimo DECIMAL(18,4),
	@GapMaximo DECIMAL(18,4),
	@GapAgregar DECIMAL(18,4),
	@MontoMeta DECIMAL(18,4),
	@CUV VARCHAR(6),
	@TipoRango VARCHAR(3),
	@MontoPedidoFinal DECIMAL(18,4),
	@UpSellingDetalleId INT
)
as
begin
	DECLARE @result INT, @stock INT
	SET @result = -1

	SELECT @stock = Stock FROM UpSellingDetalle WHERE UpSellingDetalleId = @UpSellingDetalleId

	IF (@stock > 0)
	BEGIN
		IF EXISTS (SELECT 1 FROM OfertaFinalMontoMeta WHERE CampaniaId = @CampaniaId AND ConsultoraId = @ConsultoraId)
		BEGIN
			UPDATE OfertaFinalMontoMeta 
			SET CUV = @CUV 
			WHERE CampaniaId = @CampaniaId 
			AND ConsultoraId = @ConsultoraId

			SET @result = 1
		END
		ELSE
		BEGIN
			INSERT INTO OfertaFinalMontoMeta 
			(
				CampaniaId,
				ConsultoraId,
				MontoPedido,
				GapMinimo,
				GapMaximo,
				GapAgregar,
				MontoMeta,
				CUV,
				TipoRango,
				MontoPedidoFinal
			)
			VALUES 
			(
				@CampaniaId,
				@ConsultoraId,
				@MontoPedido,
				@GapMinimo,
				@GapMaximo,
				@GapAgregar,
				@MontoMeta,
				@CUV,
				@TipoRango,
				@MontoPedidoFinal
			)

			SET @result = 1
		END
	END

	SELECT @result AS result
	
END
GO

USE BelcorpMexico
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'InsertUpSellingRegalo')
BEGIN
	DROP PROCEDURE dbo.InsertUpSellingRegalo 
END
GO

CREATE PROCEDURE [dbo].[InsertUpSellingRegalo]
(
	@CampaniaId INT,
	@ConsultoraId INT,
	@MontoPedido DECIMAL(18,4),
	@GapMinimo DECIMAL(18,4),
	@GapMaximo DECIMAL(18,4),
	@GapAgregar DECIMAL(18,4),
	@MontoMeta DECIMAL(18,4),
	@CUV VARCHAR(6),
	@TipoRango VARCHAR(3),
	@MontoPedidoFinal DECIMAL(18,4),
	@UpSellingDetalleId INT
)
as
begin
	DECLARE @result INT, @stock INT
	SET @result = -1

	SELECT @stock = Stock FROM UpSellingDetalle WHERE UpSellingDetalleId = @UpSellingDetalleId

	IF (@stock > 0)
	BEGIN
		IF EXISTS (SELECT 1 FROM OfertaFinalMontoMeta WHERE CampaniaId = @CampaniaId AND ConsultoraId = @ConsultoraId)
		BEGIN
			UPDATE OfertaFinalMontoMeta 
			SET CUV = @CUV 
			WHERE CampaniaId = @CampaniaId 
			AND ConsultoraId = @ConsultoraId

			SET @result = 1
		END
		ELSE
		BEGIN
			INSERT INTO OfertaFinalMontoMeta 
			(
				CampaniaId,
				ConsultoraId,
				MontoPedido,
				GapMinimo,
				GapMaximo,
				GapAgregar,
				MontoMeta,
				CUV,
				TipoRango,
				MontoPedidoFinal
			)
			VALUES 
			(
				@CampaniaId,
				@ConsultoraId,
				@MontoPedido,
				@GapMinimo,
				@GapMaximo,
				@GapAgregar,
				@MontoMeta,
				@CUV,
				@TipoRango,
				@MontoPedidoFinal
			)

			SET @result = 1
		END
	END

	SELECT @result AS result
	
END
GO

USE BelcorpPanama
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'InsertUpSellingRegalo')
BEGIN
	DROP PROCEDURE dbo.InsertUpSellingRegalo 
END
GO

CREATE PROCEDURE [dbo].[InsertUpSellingRegalo]
(
	@CampaniaId INT,
	@ConsultoraId INT,
	@MontoPedido DECIMAL(18,4),
	@GapMinimo DECIMAL(18,4),
	@GapMaximo DECIMAL(18,4),
	@GapAgregar DECIMAL(18,4),
	@MontoMeta DECIMAL(18,4),
	@CUV VARCHAR(6),
	@TipoRango VARCHAR(3),
	@MontoPedidoFinal DECIMAL(18,4),
	@UpSellingDetalleId INT
)
as
begin
	DECLARE @result INT, @stock INT
	SET @result = -1

	SELECT @stock = Stock FROM UpSellingDetalle WHERE UpSellingDetalleId = @UpSellingDetalleId

	IF (@stock > 0)
	BEGIN
		IF EXISTS (SELECT 1 FROM OfertaFinalMontoMeta WHERE CampaniaId = @CampaniaId AND ConsultoraId = @ConsultoraId)
		BEGIN
			UPDATE OfertaFinalMontoMeta 
			SET CUV = @CUV 
			WHERE CampaniaId = @CampaniaId 
			AND ConsultoraId = @ConsultoraId

			SET @result = 1
		END
		ELSE
		BEGIN
			INSERT INTO OfertaFinalMontoMeta 
			(
				CampaniaId,
				ConsultoraId,
				MontoPedido,
				GapMinimo,
				GapMaximo,
				GapAgregar,
				MontoMeta,
				CUV,
				TipoRango,
				MontoPedidoFinal
			)
			VALUES 
			(
				@CampaniaId,
				@ConsultoraId,
				@MontoPedido,
				@GapMinimo,
				@GapMaximo,
				@GapAgregar,
				@MontoMeta,
				@CUV,
				@TipoRango,
				@MontoPedidoFinal
			)

			SET @result = 1
		END
	END

	SELECT @result AS result
	
END
GO

USE BelcorpPeru
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'InsertUpSellingRegalo')
BEGIN
	DROP PROCEDURE dbo.InsertUpSellingRegalo 
END
GO

CREATE PROCEDURE [dbo].[InsertUpSellingRegalo]
(
	@CampaniaId INT,
	@ConsultoraId INT,
	@MontoPedido DECIMAL(18,4),
	@GapMinimo DECIMAL(18,4),
	@GapMaximo DECIMAL(18,4),
	@GapAgregar DECIMAL(18,4),
	@MontoMeta DECIMAL(18,4),
	@CUV VARCHAR(6),
	@TipoRango VARCHAR(3),
	@MontoPedidoFinal DECIMAL(18,4),
	@UpSellingDetalleId INT
)
as
begin
	DECLARE @result INT, @stock INT
	SET @result = -1

	SELECT @stock = Stock FROM UpSellingDetalle WHERE UpSellingDetalleId = @UpSellingDetalleId

	IF (@stock > 0)
	BEGIN
		IF EXISTS (SELECT 1 FROM OfertaFinalMontoMeta WHERE CampaniaId = @CampaniaId AND ConsultoraId = @ConsultoraId)
		BEGIN
			UPDATE OfertaFinalMontoMeta 
			SET CUV = @CUV 
			WHERE CampaniaId = @CampaniaId 
			AND ConsultoraId = @ConsultoraId

			SET @result = 1
		END
		ELSE
		BEGIN
			INSERT INTO OfertaFinalMontoMeta 
			(
				CampaniaId,
				ConsultoraId,
				MontoPedido,
				GapMinimo,
				GapMaximo,
				GapAgregar,
				MontoMeta,
				CUV,
				TipoRango,
				MontoPedidoFinal
			)
			VALUES 
			(
				@CampaniaId,
				@ConsultoraId,
				@MontoPedido,
				@GapMinimo,
				@GapMaximo,
				@GapAgregar,
				@MontoMeta,
				@CUV,
				@TipoRango,
				@MontoPedidoFinal
			)

			SET @result = 1
		END
	END

	SELECT @result AS result
	
END
GO

USE BelcorpPuertoRico
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'InsertUpSellingRegalo')
BEGIN
	DROP PROCEDURE dbo.InsertUpSellingRegalo 
END
GO

CREATE PROCEDURE [dbo].[InsertUpSellingRegalo]
(
	@CampaniaId INT,
	@ConsultoraId INT,
	@MontoPedido DECIMAL(18,4),
	@GapMinimo DECIMAL(18,4),
	@GapMaximo DECIMAL(18,4),
	@GapAgregar DECIMAL(18,4),
	@MontoMeta DECIMAL(18,4),
	@CUV VARCHAR(6),
	@TipoRango VARCHAR(3),
	@MontoPedidoFinal DECIMAL(18,4),
	@UpSellingDetalleId INT
)
as
begin
	DECLARE @result INT, @stock INT
	SET @result = -1

	SELECT @stock = Stock FROM UpSellingDetalle WHERE UpSellingDetalleId = @UpSellingDetalleId

	IF (@stock > 0)
	BEGIN
		IF EXISTS (SELECT 1 FROM OfertaFinalMontoMeta WHERE CampaniaId = @CampaniaId AND ConsultoraId = @ConsultoraId)
		BEGIN
			UPDATE OfertaFinalMontoMeta 
			SET CUV = @CUV 
			WHERE CampaniaId = @CampaniaId 
			AND ConsultoraId = @ConsultoraId

			SET @result = 1
		END
		ELSE
		BEGIN
			INSERT INTO OfertaFinalMontoMeta 
			(
				CampaniaId,
				ConsultoraId,
				MontoPedido,
				GapMinimo,
				GapMaximo,
				GapAgregar,
				MontoMeta,
				CUV,
				TipoRango,
				MontoPedidoFinal
			)
			VALUES 
			(
				@CampaniaId,
				@ConsultoraId,
				@MontoPedido,
				@GapMinimo,
				@GapMaximo,
				@GapAgregar,
				@MontoMeta,
				@CUV,
				@TipoRango,
				@MontoPedidoFinal
			)

			SET @result = 1
		END
	END

	SELECT @result AS result
	
END
GO

USE BelcorpSalvador
GO

IF EXISTS(SELECT 1 FROM sys.procedures 
          WHERE Name = 'InsertUpSellingRegalo')
BEGIN
	DROP PROCEDURE dbo.InsertUpSellingRegalo 
END
GO

CREATE PROCEDURE [dbo].[InsertUpSellingRegalo]
(
	@CampaniaId INT,
	@ConsultoraId INT,
	@MontoPedido DECIMAL(18,4),
	@GapMinimo DECIMAL(18,4),
	@GapMaximo DECIMAL(18,4),
	@GapAgregar DECIMAL(18,4),
	@MontoMeta DECIMAL(18,4),
	@CUV VARCHAR(6),
	@TipoRango VARCHAR(3),
	@MontoPedidoFinal DECIMAL(18,4),
	@UpSellingDetalleId INT
)
as
begin
	DECLARE @result INT, @stock INT
	SET @result = -1

	SELECT @stock = Stock FROM UpSellingDetalle WHERE UpSellingDetalleId = @UpSellingDetalleId

	IF (@stock > 0)
	BEGIN
		IF EXISTS (SELECT 1 FROM OfertaFinalMontoMeta WHERE CampaniaId = @CampaniaId AND ConsultoraId = @ConsultoraId)
		BEGIN
			UPDATE OfertaFinalMontoMeta 
			SET CUV = @CUV 
			WHERE CampaniaId = @CampaniaId 
			AND ConsultoraId = @ConsultoraId

			SET @result = 1
		END
		ELSE
		BEGIN
			INSERT INTO OfertaFinalMontoMeta 
			(
				CampaniaId,
				ConsultoraId,
				MontoPedido,
				GapMinimo,
				GapMaximo,
				GapAgregar,
				MontoMeta,
				CUV,
				TipoRango,
				MontoPedidoFinal
			)
			VALUES 
			(
				@CampaniaId,
				@ConsultoraId,
				@MontoPedido,
				@GapMinimo,
				@GapMaximo,
				@GapAgregar,
				@MontoMeta,
				@CUV,
				@TipoRango,
				@MontoPedidoFinal
			)

			SET @result = 1
		END
	END

	SELECT @result AS result
	
END
GO



