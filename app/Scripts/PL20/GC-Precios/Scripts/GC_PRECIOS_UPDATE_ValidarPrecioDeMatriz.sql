USE BelcorpBolivia
GO

CREATE PROCEDURE ValidarPreciosDeMatriz 
(
	@Campania INT,
	@CUV INT
)
AS
BEGIN

	DECLARE @Precio DECIMAL(6,2);
	DECLARE @Precio2 DECIMAL(6,2);

	SELECT @Precio = PRECIO_PACK FROM PRL_MATRIZ_TMP WHERE COD_VENTA = @CUV;
	SELECT @Precio2 = Precio2 FROM Estrategia WHERE CUV2 = @CUV;

	IF(@Precio <> @Precio2)
	BEGIN
		UPDATE Estrategia 
		SET Precio2 = @Precio
		WHERE CUV2 = @CUV;
	END
END
GO

USE BelcorpChile
GO

CREATE PROCEDURE ValidarPreciosDeMatriz 
(
	@Campania INT,
	@CUV INT
)
AS
BEGIN

	DECLARE @Precio DECIMAL(6,2);
	DECLARE @Precio2 DECIMAL(6,2);

	SELECT @Precio = PRECIO_PACK FROM PRL_MATRIZ_TMP WHERE COD_VENTA = @CUV;
	SELECT @Precio2 = Precio2 FROM Estrategia WHERE CUV2 = @CUV;

	IF(@Precio <> @Precio2)
	BEGIN
		UPDATE Estrategia 
		SET Precio2 = @Precio
		WHERE CUV2 = @CUV;
	END
END
GO

USE BelcorpColombia
GO

CREATE PROCEDURE ValidarPreciosDeMatriz 
(
	@Campania INT,
	@CUV INT
)
AS
BEGIN

	DECLARE @Precio DECIMAL(6,2);
	DECLARE @Precio2 DECIMAL(6,2);

	SELECT @Precio = PRECIO_PACK FROM PRL_MATRIZ_TMP WHERE COD_VENTA = @CUV;
	SELECT @Precio2 = Precio2 FROM Estrategia WHERE CUV2 = @CUV;

	IF(@Precio <> @Precio2)
	BEGIN
		UPDATE Estrategia 
		SET Precio2 = @Precio
		WHERE CUV2 = @CUV;
	END
END
GO

USE BelcorpCostaRica
GO

CREATE PROCEDURE ValidarPreciosDeMatriz 
(
	@Campania INT,
	@CUV INT
)
AS
BEGIN

	DECLARE @Precio DECIMAL(6,2);
	DECLARE @Precio2 DECIMAL(6,2);

	SELECT @Precio = PRECIO_PACK FROM PRL_MATRIZ_TMP WHERE COD_VENTA = @CUV;
	SELECT @Precio2 = Precio2 FROM Estrategia WHERE CUV2 = @CUV;

	IF(@Precio <> @Precio2)
	BEGIN
		UPDATE Estrategia 
		SET Precio2 = @Precio
		WHERE CUV2 = @CUV;
	END
END
GO

USE BelcorpDominicana
GO

CREATE PROCEDURE ValidarPreciosDeMatriz 
(
	@Campania INT,
	@CUV INT
)
AS
BEGIN

	DECLARE @Precio DECIMAL(6,2);
	DECLARE @Precio2 DECIMAL(6,2);

	SELECT @Precio = PRECIO_PACK FROM PRL_MATRIZ_TMP WHERE COD_VENTA = @CUV;
	SELECT @Precio2 = Precio2 FROM Estrategia WHERE CUV2 = @CUV;

	IF(@Precio <> @Precio2)
	BEGIN
		UPDATE Estrategia 
		SET Precio2 = @Precio
		WHERE CUV2 = @CUV;
	END
END
GO

USE BelcorpEcuador
GO

CREATE PROCEDURE ValidarPreciosDeMatriz 
(
	@Campania INT,
	@CUV INT
)
AS
BEGIN

	DECLARE @Precio DECIMAL(6,2);
	DECLARE @Precio2 DECIMAL(6,2);

	SELECT @Precio = PRECIO_PACK FROM PRL_MATRIZ_TMP WHERE COD_VENTA = @CUV;
	SELECT @Precio2 = Precio2 FROM Estrategia WHERE CUV2 = @CUV;

	IF(@Precio <> @Precio2)
	BEGIN
		UPDATE Estrategia 
		SET Precio2 = @Precio
		WHERE CUV2 = @CUV;
	END
END
GO

USE BelcorpGuatemala
GO

CREATE PROCEDURE ValidarPreciosDeMatriz 
(
	@Campania INT,
	@CUV INT
)
AS
BEGIN

	DECLARE @Precio DECIMAL(6,2);
	DECLARE @Precio2 DECIMAL(6,2);

	SELECT @Precio = PRECIO_PACK FROM PRL_MATRIZ_TMP WHERE COD_VENTA = @CUV;
	SELECT @Precio2 = Precio2 FROM Estrategia WHERE CUV2 = @CUV;

	IF(@Precio <> @Precio2)
	BEGIN
		UPDATE Estrategia 
		SET Precio2 = @Precio
		WHERE CUV2 = @CUV;
	END
END
GO

USE BelcorpMexico
GO

CREATE PROCEDURE ValidarPreciosDeMatriz 
(
	@Campania INT,
	@CUV INT
)
AS
BEGIN

	DECLARE @Precio DECIMAL(6,2);
	DECLARE @Precio2 DECIMAL(6,2);

	SELECT @Precio = PRECIO_PACK FROM PRL_MATRIZ_TMP WHERE COD_VENTA = @CUV;
	SELECT @Precio2 = Precio2 FROM Estrategia WHERE CUV2 = @CUV;

	IF(@Precio <> @Precio2)
	BEGIN
		UPDATE Estrategia 
		SET Precio2 = @Precio
		WHERE CUV2 = @CUV;
	END
END
GO

USE BelcorpPanama
GO

CREATE PROCEDURE ValidarPreciosDeMatriz 
(
	@Campania INT,
	@CUV INT
)
AS
BEGIN

	DECLARE @Precio DECIMAL(6,2);
	DECLARE @Precio2 DECIMAL(6,2);

	SELECT @Precio = PRECIO_PACK FROM PRL_MATRIZ_TMP WHERE COD_VENTA = @CUV;
	SELECT @Precio2 = Precio2 FROM Estrategia WHERE CUV2 = @CUV;

	IF(@Precio <> @Precio2)
	BEGIN
		UPDATE Estrategia 
		SET Precio2 = @Precio
		WHERE CUV2 = @CUV;
	END
END
GO

USE BelcorpPeru
GO

CREATE PROCEDURE ValidarPreciosDeMatriz 
(
	@Campania INT,
	@CUV INT
)
AS
BEGIN

	DECLARE @Precio DECIMAL(6,2);
	DECLARE @Precio2 DECIMAL(6,2);

	SELECT @Precio = PRECIO_PACK FROM PRL_MATRIZ_TMP WHERE COD_VENTA = @CUV;
	SELECT @Precio2 = Precio2 FROM Estrategia WHERE CUV2 = @CUV;

	IF(@Precio <> @Precio2)
	BEGIN
		UPDATE Estrategia 
		SET Precio2 = @Precio
		WHERE CUV2 = @CUV;
	END
END
GO

USE BelcorpPuertoRico
GO

CREATE PROCEDURE ValidarPreciosDeMatriz 
(
	@Campania INT,
	@CUV INT
)
AS
BEGIN

	DECLARE @Precio DECIMAL(6,2);
	DECLARE @Precio2 DECIMAL(6,2);

	SELECT @Precio = PRECIO_PACK FROM PRL_MATRIZ_TMP WHERE COD_VENTA = @CUV;
	SELECT @Precio2 = Precio2 FROM Estrategia WHERE CUV2 = @CUV;

	IF(@Precio <> @Precio2)
	BEGIN
		UPDATE Estrategia 
		SET Precio2 = @Precio
		WHERE CUV2 = @CUV;
	END
END
GO

USE BelcorpSalvador
GO

CREATE PROCEDURE ValidarPreciosDeMatriz 
(
	@Campania INT,
	@CUV INT
)
AS
BEGIN

	DECLARE @Precio DECIMAL(6,2);
	DECLARE @Precio2 DECIMAL(6,2);

	SELECT @Precio = PRECIO_PACK FROM PRL_MATRIZ_TMP WHERE COD_VENTA = @CUV;
	SELECT @Precio2 = Precio2 FROM Estrategia WHERE CUV2 = @CUV;

	IF(@Precio <> @Precio2)
	BEGIN
		UPDATE Estrategia 
		SET Precio2 = @Precio
		WHERE CUV2 = @CUV;
	END
END
GO

USE BelcorpVenezuela
GO

CREATE PROCEDURE ValidarPreciosDeMatriz 
(
	@Campania INT,
	@CUV INT
)
AS
BEGIN

	DECLARE @Precio DECIMAL(6,2);
	DECLARE @Precio2 DECIMAL(6,2);

	SELECT @Precio = PRECIO_PACK FROM PRL_MATRIZ_TMP WHERE COD_VENTA = @CUV;
	SELECT @Precio2 = Precio2 FROM Estrategia WHERE CUV2 = @CUV;

	IF(@Precio <> @Precio2)
	BEGIN
		UPDATE Estrategia 
		SET Precio2 = @Precio
		WHERE CUV2 = @CUV;
	END
END
GO





