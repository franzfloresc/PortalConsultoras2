USE BelcorpPeru
GO

ALTER PROCEDURE ListarEstrategias

	@CampaniaID			INT,
	@TipoEstrategiaID	INT,
	@CUV				VARCHAR(20),
	@TieneImagen		INT,
	@Activo				INT

AS
BEGIN

/*
	EXEC ListarEstrategias 201411, 5, '0'
*/

	SET NOCOUNT ON

		SELECT
			e.EstrategiaID,
			e.Orden, 
			ROW_NUMBER() OVER (ORDER BY e.EstrategiaID ) ID, 
			e.Precio2, 
			e.NumeroPedido,
			e.CUV2, 
			e.DescripcionCUV2, 
			e.Activo, 
			e.LimiteVenta, 
			pc.CodigoProducto, 
			e.ImagenURL,
			e.EsOfertaIndependiente
		FROM 
			Estrategia e 
			INNER JOIN TipoEstrategia te ON e.TipoEstrategiaID = te.TipoEstrategiaID
			INNER JOIN ods.Campania c ON c.Codigo = e.CampaniaID
			INNER JOIN ods.ProductoComercial pc ON pc.CUV= e.CUV2 AND pc.CampaniaID = c.CampaniaID
		WHERE
				e.CampaniaID = @CampaniaID
			AND (e.TipoEstrategiaID = @TipoEstrategiaID OR 0 = @TipoEstrategiaID)
			AND (e.CUV2 = @CUV OR '0' = @CUV)
			AND (
					e.Activo = CAST(@Activo AS BIT) OR -1 = @Activo
				)
			AND (
					(CASE WHEN LEN(e.ImagenURL) = 0 THEN 0 
							WHEN LEN(e.ImagenURL) > 0 THEN 1 END) = @TieneImagen OR -1 = @TieneImagen
				)
	SET NOCOUNT OFF

END


GO

USE BelcorpMexico
GO

ALTER PROCEDURE ListarEstrategias

	@CampaniaID			INT,
	@TipoEstrategiaID	INT,
	@CUV				VARCHAR(20),
	@TieneImagen		INT,
	@Activo				INT

AS
BEGIN

/*
	EXEC ListarEstrategias 201411, 5, '0'
*/

	SET NOCOUNT ON

		SELECT
			e.EstrategiaID,
			e.Orden, 
			ROW_NUMBER() OVER (ORDER BY e.EstrategiaID ) ID, 
			e.Precio2, 
			e.NumeroPedido,
			e.CUV2, 
			e.DescripcionCUV2, 
			e.Activo, 
			e.LimiteVenta, 
			pc.CodigoProducto, 
			e.ImagenURL,
			e.EsOfertaIndependiente
		FROM 
			Estrategia e 
			INNER JOIN TipoEstrategia te ON e.TipoEstrategiaID = te.TipoEstrategiaID
			INNER JOIN ods.Campania c ON c.Codigo = e.CampaniaID
			INNER JOIN ods.ProductoComercial pc ON pc.CUV= e.CUV2 AND pc.CampaniaID = c.CampaniaID
		WHERE
				e.CampaniaID = @CampaniaID
			AND (e.TipoEstrategiaID = @TipoEstrategiaID OR 0 = @TipoEstrategiaID)
			AND (e.CUV2 = @CUV OR '0' = @CUV)
			AND (
					e.Activo = CAST(@Activo AS BIT) OR -1 = @Activo
				)
			AND (
					(CASE WHEN LEN(e.ImagenURL) = 0 THEN 0 
							WHEN LEN(e.ImagenURL) > 0 THEN 1 END) = @TieneImagen OR -1 = @TieneImagen
				)
	SET NOCOUNT OFF

END


GO

USE BelcorpColombia
GO

ALTER PROCEDURE ListarEstrategias

	@CampaniaID			INT,
	@TipoEstrategiaID	INT,
	@CUV				VARCHAR(20),
	@TieneImagen		INT,
	@Activo				INT

AS
BEGIN

/*
	EXEC ListarEstrategias 201411, 5, '0'
*/

	SET NOCOUNT ON

		SELECT
			e.EstrategiaID,
			e.Orden, 
			ROW_NUMBER() OVER (ORDER BY e.EstrategiaID ) ID, 
			e.Precio2, 
			e.NumeroPedido,
			e.CUV2, 
			e.DescripcionCUV2, 
			e.Activo, 
			e.LimiteVenta, 
			pc.CodigoProducto, 
			e.ImagenURL,
			e.EsOfertaIndependiente
		FROM 
			Estrategia e 
			INNER JOIN TipoEstrategia te ON e.TipoEstrategiaID = te.TipoEstrategiaID
			INNER JOIN ods.Campania c ON c.Codigo = e.CampaniaID
			INNER JOIN ods.ProductoComercial pc ON pc.CUV= e.CUV2 AND pc.CampaniaID = c.CampaniaID
		WHERE
				e.CampaniaID = @CampaniaID
			AND (e.TipoEstrategiaID = @TipoEstrategiaID OR 0 = @TipoEstrategiaID)
			AND (e.CUV2 = @CUV OR '0' = @CUV)
			AND (
					e.Activo = CAST(@Activo AS BIT) OR -1 = @Activo
				)
			AND (
					(CASE WHEN LEN(e.ImagenURL) = 0 THEN 0 
							WHEN LEN(e.ImagenURL) > 0 THEN 1 END) = @TieneImagen OR -1 = @TieneImagen
				)
	SET NOCOUNT OFF

END


GO

USE BelcorpVenezuela
GO

ALTER PROCEDURE ListarEstrategias

	@CampaniaID			INT,
	@TipoEstrategiaID	INT,
	@CUV				VARCHAR(20),
	@TieneImagen		INT,
	@Activo				INT

AS
BEGIN

/*
	EXEC ListarEstrategias 201411, 5, '0'
*/

	SET NOCOUNT ON

		SELECT
			e.EstrategiaID,
			e.Orden, 
			ROW_NUMBER() OVER (ORDER BY e.EstrategiaID ) ID, 
			e.Precio2, 
			e.NumeroPedido,
			e.CUV2, 
			e.DescripcionCUV2, 
			e.Activo, 
			e.LimiteVenta, 
			pc.CodigoProducto, 
			e.ImagenURL,
			e.EsOfertaIndependiente
		FROM 
			Estrategia e 
			INNER JOIN TipoEstrategia te ON e.TipoEstrategiaID = te.TipoEstrategiaID
			INNER JOIN ods.Campania c ON c.Codigo = e.CampaniaID
			INNER JOIN ods.ProductoComercial pc ON pc.CUV= e.CUV2 AND pc.CampaniaID = c.CampaniaID
		WHERE
				e.CampaniaID = @CampaniaID
			AND (e.TipoEstrategiaID = @TipoEstrategiaID OR 0 = @TipoEstrategiaID)
			AND (e.CUV2 = @CUV OR '0' = @CUV)
			AND (
					e.Activo = CAST(@Activo AS BIT) OR -1 = @Activo
				)
			AND (
					(CASE WHEN LEN(e.ImagenURL) = 0 THEN 0 
							WHEN LEN(e.ImagenURL) > 0 THEN 1 END) = @TieneImagen OR -1 = @TieneImagen
				)
	SET NOCOUNT OFF

END


GO

USE BelcorpSalvador
GO

ALTER PROCEDURE ListarEstrategias

	@CampaniaID			INT,
	@TipoEstrategiaID	INT,
	@CUV				VARCHAR(20),
	@TieneImagen		INT,
	@Activo				INT

AS
BEGIN

/*
	EXEC ListarEstrategias 201411, 5, '0'
*/

	SET NOCOUNT ON

		SELECT
			e.EstrategiaID,
			e.Orden, 
			ROW_NUMBER() OVER (ORDER BY e.EstrategiaID ) ID, 
			e.Precio2, 
			e.NumeroPedido,
			e.CUV2, 
			e.DescripcionCUV2, 
			e.Activo, 
			e.LimiteVenta, 
			pc.CodigoProducto, 
			e.ImagenURL,
			e.EsOfertaIndependiente
		FROM 
			Estrategia e 
			INNER JOIN TipoEstrategia te ON e.TipoEstrategiaID = te.TipoEstrategiaID
			INNER JOIN ods.Campania c ON c.Codigo = e.CampaniaID
			INNER JOIN ods.ProductoComercial pc ON pc.CUV= e.CUV2 AND pc.CampaniaID = c.CampaniaID
		WHERE
				e.CampaniaID = @CampaniaID
			AND (e.TipoEstrategiaID = @TipoEstrategiaID OR 0 = @TipoEstrategiaID)
			AND (e.CUV2 = @CUV OR '0' = @CUV)
			AND (
					e.Activo = CAST(@Activo AS BIT) OR -1 = @Activo
				)
			AND (
					(CASE WHEN LEN(e.ImagenURL) = 0 THEN 0 
							WHEN LEN(e.ImagenURL) > 0 THEN 1 END) = @TieneImagen OR -1 = @TieneImagen
				)
	SET NOCOUNT OFF

END


GO

USE BelcorpPuertoRico
GO

ALTER PROCEDURE ListarEstrategias

	@CampaniaID			INT,
	@TipoEstrategiaID	INT,
	@CUV				VARCHAR(20),
	@TieneImagen		INT,
	@Activo				INT

AS
BEGIN

/*
	EXEC ListarEstrategias 201411, 5, '0'
*/

	SET NOCOUNT ON

		SELECT
			e.EstrategiaID,
			e.Orden, 
			ROW_NUMBER() OVER (ORDER BY e.EstrategiaID ) ID, 
			e.Precio2, 
			e.NumeroPedido,
			e.CUV2, 
			e.DescripcionCUV2, 
			e.Activo, 
			e.LimiteVenta, 
			pc.CodigoProducto, 
			e.ImagenURL,
			e.EsOfertaIndependiente
		FROM 
			Estrategia e 
			INNER JOIN TipoEstrategia te ON e.TipoEstrategiaID = te.TipoEstrategiaID
			INNER JOIN ods.Campania c ON c.Codigo = e.CampaniaID
			INNER JOIN ods.ProductoComercial pc ON pc.CUV= e.CUV2 AND pc.CampaniaID = c.CampaniaID
		WHERE
				e.CampaniaID = @CampaniaID
			AND (e.TipoEstrategiaID = @TipoEstrategiaID OR 0 = @TipoEstrategiaID)
			AND (e.CUV2 = @CUV OR '0' = @CUV)
			AND (
					e.Activo = CAST(@Activo AS BIT) OR -1 = @Activo
				)
			AND (
					(CASE WHEN LEN(e.ImagenURL) = 0 THEN 0 
							WHEN LEN(e.ImagenURL) > 0 THEN 1 END) = @TieneImagen OR -1 = @TieneImagen
				)
	SET NOCOUNT OFF

END


GO

USE BelcorpPanama
GO

ALTER PROCEDURE ListarEstrategias

	@CampaniaID			INT,
	@TipoEstrategiaID	INT,
	@CUV				VARCHAR(20),
	@TieneImagen		INT,
	@Activo				INT

AS
BEGIN

/*
	EXEC ListarEstrategias 201411, 5, '0'
*/

	SET NOCOUNT ON

		SELECT
			e.EstrategiaID,
			e.Orden, 
			ROW_NUMBER() OVER (ORDER BY e.EstrategiaID ) ID, 
			e.Precio2, 
			e.NumeroPedido,
			e.CUV2, 
			e.DescripcionCUV2, 
			e.Activo, 
			e.LimiteVenta, 
			pc.CodigoProducto, 
			e.ImagenURL,
			e.EsOfertaIndependiente
		FROM 
			Estrategia e 
			INNER JOIN TipoEstrategia te ON e.TipoEstrategiaID = te.TipoEstrategiaID
			INNER JOIN ods.Campania c ON c.Codigo = e.CampaniaID
			INNER JOIN ods.ProductoComercial pc ON pc.CUV= e.CUV2 AND pc.CampaniaID = c.CampaniaID
		WHERE
				e.CampaniaID = @CampaniaID
			AND (e.TipoEstrategiaID = @TipoEstrategiaID OR 0 = @TipoEstrategiaID)
			AND (e.CUV2 = @CUV OR '0' = @CUV)
			AND (
					e.Activo = CAST(@Activo AS BIT) OR -1 = @Activo
				)
			AND (
					(CASE WHEN LEN(e.ImagenURL) = 0 THEN 0 
							WHEN LEN(e.ImagenURL) > 0 THEN 1 END) = @TieneImagen OR -1 = @TieneImagen
				)
	SET NOCOUNT OFF

END


GO

USE BelcorpGuatemala
GO

ALTER PROCEDURE ListarEstrategias

	@CampaniaID			INT,
	@TipoEstrategiaID	INT,
	@CUV				VARCHAR(20),
	@TieneImagen		INT,
	@Activo				INT

AS
BEGIN

/*
	EXEC ListarEstrategias 201411, 5, '0'
*/

	SET NOCOUNT ON

		SELECT
			e.EstrategiaID,
			e.Orden, 
			ROW_NUMBER() OVER (ORDER BY e.EstrategiaID ) ID, 
			e.Precio2, 
			e.NumeroPedido,
			e.CUV2, 
			e.DescripcionCUV2, 
			e.Activo, 
			e.LimiteVenta, 
			pc.CodigoProducto, 
			e.ImagenURL,
			e.EsOfertaIndependiente
		FROM 
			Estrategia e 
			INNER JOIN TipoEstrategia te ON e.TipoEstrategiaID = te.TipoEstrategiaID
			INNER JOIN ods.Campania c ON c.Codigo = e.CampaniaID
			INNER JOIN ods.ProductoComercial pc ON pc.CUV= e.CUV2 AND pc.CampaniaID = c.CampaniaID
		WHERE
				e.CampaniaID = @CampaniaID
			AND (e.TipoEstrategiaID = @TipoEstrategiaID OR 0 = @TipoEstrategiaID)
			AND (e.CUV2 = @CUV OR '0' = @CUV)
			AND (
					e.Activo = CAST(@Activo AS BIT) OR -1 = @Activo
				)
			AND (
					(CASE WHEN LEN(e.ImagenURL) = 0 THEN 0 
							WHEN LEN(e.ImagenURL) > 0 THEN 1 END) = @TieneImagen OR -1 = @TieneImagen
				)
	SET NOCOUNT OFF

END


GO

USE BelcorpEcuador
GO

ALTER PROCEDURE ListarEstrategias

	@CampaniaID			INT,
	@TipoEstrategiaID	INT,
	@CUV				VARCHAR(20),
	@TieneImagen		INT,
	@Activo				INT

AS
BEGIN

/*
	EXEC ListarEstrategias 201411, 5, '0'
*/

	SET NOCOUNT ON

		SELECT
			e.EstrategiaID,
			e.Orden, 
			ROW_NUMBER() OVER (ORDER BY e.EstrategiaID ) ID, 
			e.Precio2, 
			e.NumeroPedido,
			e.CUV2, 
			e.DescripcionCUV2, 
			e.Activo, 
			e.LimiteVenta, 
			pc.CodigoProducto, 
			e.ImagenURL,
			e.EsOfertaIndependiente
		FROM 
			Estrategia e 
			INNER JOIN TipoEstrategia te ON e.TipoEstrategiaID = te.TipoEstrategiaID
			INNER JOIN ods.Campania c ON c.Codigo = e.CampaniaID
			INNER JOIN ods.ProductoComercial pc ON pc.CUV= e.CUV2 AND pc.CampaniaID = c.CampaniaID
		WHERE
				e.CampaniaID = @CampaniaID
			AND (e.TipoEstrategiaID = @TipoEstrategiaID OR 0 = @TipoEstrategiaID)
			AND (e.CUV2 = @CUV OR '0' = @CUV)
			AND (
					e.Activo = CAST(@Activo AS BIT) OR -1 = @Activo
				)
			AND (
					(CASE WHEN LEN(e.ImagenURL) = 0 THEN 0 
							WHEN LEN(e.ImagenURL) > 0 THEN 1 END) = @TieneImagen OR -1 = @TieneImagen
				)
	SET NOCOUNT OFF

END


GO

USE BelcorpDominicana
GO

ALTER PROCEDURE ListarEstrategias

	@CampaniaID			INT,
	@TipoEstrategiaID	INT,
	@CUV				VARCHAR(20),
	@TieneImagen		INT,
	@Activo				INT

AS
BEGIN

/*
	EXEC ListarEstrategias 201411, 5, '0'
*/

	SET NOCOUNT ON

		SELECT
			e.EstrategiaID,
			e.Orden, 
			ROW_NUMBER() OVER (ORDER BY e.EstrategiaID ) ID, 
			e.Precio2, 
			e.NumeroPedido,
			e.CUV2, 
			e.DescripcionCUV2, 
			e.Activo, 
			e.LimiteVenta, 
			pc.CodigoProducto, 
			e.ImagenURL,
			e.EsOfertaIndependiente
		FROM 
			Estrategia e 
			INNER JOIN TipoEstrategia te ON e.TipoEstrategiaID = te.TipoEstrategiaID
			INNER JOIN ods.Campania c ON c.Codigo = e.CampaniaID
			INNER JOIN ods.ProductoComercial pc ON pc.CUV= e.CUV2 AND pc.CampaniaID = c.CampaniaID
		WHERE
				e.CampaniaID = @CampaniaID
			AND (e.TipoEstrategiaID = @TipoEstrategiaID OR 0 = @TipoEstrategiaID)
			AND (e.CUV2 = @CUV OR '0' = @CUV)
			AND (
					e.Activo = CAST(@Activo AS BIT) OR -1 = @Activo
				)
			AND (
					(CASE WHEN LEN(e.ImagenURL) = 0 THEN 0 
							WHEN LEN(e.ImagenURL) > 0 THEN 1 END) = @TieneImagen OR -1 = @TieneImagen
				)
	SET NOCOUNT OFF

END


GO

USE BelcorpCostaRica
GO

ALTER PROCEDURE ListarEstrategias

	@CampaniaID			INT,
	@TipoEstrategiaID	INT,
	@CUV				VARCHAR(20),
	@TieneImagen		INT,
	@Activo				INT

AS
BEGIN

/*
	EXEC ListarEstrategias 201411, 5, '0'
*/

	SET NOCOUNT ON

		SELECT
			e.EstrategiaID,
			e.Orden, 
			ROW_NUMBER() OVER (ORDER BY e.EstrategiaID ) ID, 
			e.Precio2, 
			e.NumeroPedido,
			e.CUV2, 
			e.DescripcionCUV2, 
			e.Activo, 
			e.LimiteVenta, 
			pc.CodigoProducto, 
			e.ImagenURL,
			e.EsOfertaIndependiente
		FROM 
			Estrategia e 
			INNER JOIN TipoEstrategia te ON e.TipoEstrategiaID = te.TipoEstrategiaID
			INNER JOIN ods.Campania c ON c.Codigo = e.CampaniaID
			INNER JOIN ods.ProductoComercial pc ON pc.CUV= e.CUV2 AND pc.CampaniaID = c.CampaniaID
		WHERE
				e.CampaniaID = @CampaniaID
			AND (e.TipoEstrategiaID = @TipoEstrategiaID OR 0 = @TipoEstrategiaID)
			AND (e.CUV2 = @CUV OR '0' = @CUV)
			AND (
					e.Activo = CAST(@Activo AS BIT) OR -1 = @Activo
				)
			AND (
					(CASE WHEN LEN(e.ImagenURL) = 0 THEN 0 
							WHEN LEN(e.ImagenURL) > 0 THEN 1 END) = @TieneImagen OR -1 = @TieneImagen
				)
	SET NOCOUNT OFF

END


GO

USE BelcorpChile
GO

ALTER PROCEDURE ListarEstrategias

	@CampaniaID			INT,
	@TipoEstrategiaID	INT,
	@CUV				VARCHAR(20),
	@TieneImagen		INT,
	@Activo				INT

AS
BEGIN

/*
	EXEC ListarEstrategias 201411, 5, '0'
*/

	SET NOCOUNT ON

		SELECT
			e.EstrategiaID,
			e.Orden, 
			ROW_NUMBER() OVER (ORDER BY e.EstrategiaID ) ID, 
			e.Precio2, 
			e.NumeroPedido,
			e.CUV2, 
			e.DescripcionCUV2, 
			e.Activo, 
			e.LimiteVenta, 
			pc.CodigoProducto, 
			e.ImagenURL,
			e.EsOfertaIndependiente
		FROM 
			Estrategia e 
			INNER JOIN TipoEstrategia te ON e.TipoEstrategiaID = te.TipoEstrategiaID
			INNER JOIN ods.Campania c ON c.Codigo = e.CampaniaID
			INNER JOIN ods.ProductoComercial pc ON pc.CUV= e.CUV2 AND pc.CampaniaID = c.CampaniaID
		WHERE
				e.CampaniaID = @CampaniaID
			AND (e.TipoEstrategiaID = @TipoEstrategiaID OR 0 = @TipoEstrategiaID)
			AND (e.CUV2 = @CUV OR '0' = @CUV)
			AND (
					e.Activo = CAST(@Activo AS BIT) OR -1 = @Activo
				)
			AND (
					(CASE WHEN LEN(e.ImagenURL) = 0 THEN 0 
							WHEN LEN(e.ImagenURL) > 0 THEN 1 END) = @TieneImagen OR -1 = @TieneImagen
				)
	SET NOCOUNT OFF

END


GO

USE BelcorpBolivia
GO

ALTER PROCEDURE ListarEstrategias

	@CampaniaID			INT,
	@TipoEstrategiaID	INT,
	@CUV				VARCHAR(20),
	@TieneImagen		INT,
	@Activo				INT

AS
BEGIN

/*
	EXEC ListarEstrategias 201411, 5, '0'
*/

	SET NOCOUNT ON

		SELECT
			e.EstrategiaID,
			e.Orden, 
			ROW_NUMBER() OVER (ORDER BY e.EstrategiaID ) ID, 
			e.Precio2, 
			e.NumeroPedido,
			e.CUV2, 
			e.DescripcionCUV2, 
			e.Activo, 
			e.LimiteVenta, 
			pc.CodigoProducto, 
			e.ImagenURL,
			e.EsOfertaIndependiente
		FROM 
			Estrategia e 
			INNER JOIN TipoEstrategia te ON e.TipoEstrategiaID = te.TipoEstrategiaID
			INNER JOIN ods.Campania c ON c.Codigo = e.CampaniaID
			INNER JOIN ods.ProductoComercial pc ON pc.CUV= e.CUV2 AND pc.CampaniaID = c.CampaniaID
		WHERE
				e.CampaniaID = @CampaniaID
			AND (e.TipoEstrategiaID = @TipoEstrategiaID OR 0 = @TipoEstrategiaID)
			AND (e.CUV2 = @CUV OR '0' = @CUV)
			AND (
					e.Activo = CAST(@Activo AS BIT) OR -1 = @Activo
				)
			AND (
					(CASE WHEN LEN(e.ImagenURL) = 0 THEN 0 
							WHEN LEN(e.ImagenURL) > 0 THEN 1 END) = @TieneImagen OR -1 = @TieneImagen
				)
	SET NOCOUNT OFF

END


GO

