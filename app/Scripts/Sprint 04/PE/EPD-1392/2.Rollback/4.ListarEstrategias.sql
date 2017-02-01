USE BelcorpPeru
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListarEstrategias]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ListarEstrategias]
GO

CREATE PROCEDURE ListarEstrategias
	@CampaniaID			INT,
	@TipoEstrategiaID	INT,
	@CUV				VARCHAR(20)
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
			e.ImagenURL
		FROM 
			Estrategia e 
			INNER JOIN TipoEstrategia te ON e.TipoEstrategiaID = te.TipoEstrategiaID
			INNER JOIN ods.Campania c ON c.Codigo = e.CampaniaID
			INNER JOIN ods.ProductoComercial pc ON pc.CUV= e.CUV2 AND pc.CampaniaID = c.CampaniaID
		WHERE
				e.CampaniaID = @CampaniaID
			AND (e.TipoEstrategiaID = @TipoEstrategiaID OR 0 = @TipoEstrategiaID)
			AND (e.CUV2 = @CUV OR '0' = @CUV)

	SET NOCOUNT OFF
END


GO

----------------------------------------------------------------------------------------------------------

USE BelcorpMexico
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListarEstrategias]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ListarEstrategias]
GO

CREATE PROCEDURE ListarEstrategias
	@CampaniaID			INT,
	@TipoEstrategiaID	INT,
	@CUV				VARCHAR(20)
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
			e.ImagenURL
		FROM 
			Estrategia e 
			INNER JOIN TipoEstrategia te ON e.TipoEstrategiaID = te.TipoEstrategiaID
			INNER JOIN ods.Campania c ON c.Codigo = e.CampaniaID
			INNER JOIN ods.ProductoComercial pc ON pc.CUV= e.CUV2 AND pc.CampaniaID = c.CampaniaID
		WHERE
				e.CampaniaID = @CampaniaID
			AND (e.TipoEstrategiaID = @TipoEstrategiaID OR 0 = @TipoEstrategiaID)
			AND (e.CUV2 = @CUV OR '0' = @CUV)

	SET NOCOUNT OFF
END


GO

----------------------------------------------------------------------------------------------------------

USE BelcorpColombia
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListarEstrategias]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ListarEstrategias]
GO

CREATE PROCEDURE ListarEstrategias
	@CampaniaID			INT,
	@TipoEstrategiaID	INT,
	@CUV				VARCHAR(20)
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
			e.ImagenURL
		FROM 
			Estrategia e 
			INNER JOIN TipoEstrategia te ON e.TipoEstrategiaID = te.TipoEstrategiaID
			INNER JOIN ods.Campania c ON c.Codigo = e.CampaniaID
			INNER JOIN ods.ProductoComercial pc ON pc.CUV= e.CUV2 AND pc.CampaniaID = c.CampaniaID
		WHERE
				e.CampaniaID = @CampaniaID
			AND (e.TipoEstrategiaID = @TipoEstrategiaID OR 0 = @TipoEstrategiaID)
			AND (e.CUV2 = @CUV OR '0' = @CUV)

	SET NOCOUNT OFF
END


GO

----------------------------------------------------------------------------------------------------------

USE BelcorpVenezuela
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListarEstrategias]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ListarEstrategias]
GO

CREATE PROCEDURE ListarEstrategias
	@CampaniaID			INT,
	@TipoEstrategiaID	INT,
	@CUV				VARCHAR(20)
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
			e.ImagenURL
		FROM 
			Estrategia e 
			INNER JOIN TipoEstrategia te ON e.TipoEstrategiaID = te.TipoEstrategiaID
			INNER JOIN ods.Campania c ON c.Codigo = e.CampaniaID
			INNER JOIN ods.ProductoComercial pc ON pc.CUV= e.CUV2 AND pc.CampaniaID = c.CampaniaID
		WHERE
				e.CampaniaID = @CampaniaID
			AND (e.TipoEstrategiaID = @TipoEstrategiaID OR 0 = @TipoEstrategiaID)
			AND (e.CUV2 = @CUV OR '0' = @CUV)

	SET NOCOUNT OFF
END


GO

----------------------------------------------------------------------------------------------------------

USE BelcorpSalvador
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListarEstrategias]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ListarEstrategias]
GO

CREATE PROCEDURE ListarEstrategias
	@CampaniaID			INT,
	@TipoEstrategiaID	INT,
	@CUV				VARCHAR(20)
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
			e.ImagenURL
		FROM 
			Estrategia e 
			INNER JOIN TipoEstrategia te ON e.TipoEstrategiaID = te.TipoEstrategiaID
			INNER JOIN ods.Campania c ON c.Codigo = e.CampaniaID
			INNER JOIN ods.ProductoComercial pc ON pc.CUV= e.CUV2 AND pc.CampaniaID = c.CampaniaID
		WHERE
				e.CampaniaID = @CampaniaID
			AND (e.TipoEstrategiaID = @TipoEstrategiaID OR 0 = @TipoEstrategiaID)
			AND (e.CUV2 = @CUV OR '0' = @CUV)

	SET NOCOUNT OFF
END


GO

----------------------------------------------------------------------------------------------------------

USE BelcorpPuertoRico
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListarEstrategias]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ListarEstrategias]
GO

CREATE PROCEDURE ListarEstrategias
	@CampaniaID			INT,
	@TipoEstrategiaID	INT,
	@CUV				VARCHAR(20)
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
			e.ImagenURL
		FROM 
			Estrategia e 
			INNER JOIN TipoEstrategia te ON e.TipoEstrategiaID = te.TipoEstrategiaID
			INNER JOIN ods.Campania c ON c.Codigo = e.CampaniaID
			INNER JOIN ods.ProductoComercial pc ON pc.CUV= e.CUV2 AND pc.CampaniaID = c.CampaniaID
		WHERE
				e.CampaniaID = @CampaniaID
			AND (e.TipoEstrategiaID = @TipoEstrategiaID OR 0 = @TipoEstrategiaID)
			AND (e.CUV2 = @CUV OR '0' = @CUV)

	SET NOCOUNT OFF
END


GO

----------------------------------------------------------------------------------------------------------

USE BelcorpPanama
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListarEstrategias]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ListarEstrategias]
GO

CREATE PROCEDURE ListarEstrategias
	@CampaniaID			INT,
	@TipoEstrategiaID	INT,
	@CUV				VARCHAR(20)
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
			e.ImagenURL
		FROM 
			Estrategia e 
			INNER JOIN TipoEstrategia te ON e.TipoEstrategiaID = te.TipoEstrategiaID
			INNER JOIN ods.Campania c ON c.Codigo = e.CampaniaID
			INNER JOIN ods.ProductoComercial pc ON pc.CUV= e.CUV2 AND pc.CampaniaID = c.CampaniaID
		WHERE
				e.CampaniaID = @CampaniaID
			AND (e.TipoEstrategiaID = @TipoEstrategiaID OR 0 = @TipoEstrategiaID)
			AND (e.CUV2 = @CUV OR '0' = @CUV)

	SET NOCOUNT OFF
END


GO

----------------------------------------------------------------------------------------------------------

USE BelcorpGuatemala
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListarEstrategias]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ListarEstrategias]
GO

CREATE PROCEDURE ListarEstrategias
	@CampaniaID			INT,
	@TipoEstrategiaID	INT,
	@CUV				VARCHAR(20)
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
			e.ImagenURL
		FROM 
			Estrategia e 
			INNER JOIN TipoEstrategia te ON e.TipoEstrategiaID = te.TipoEstrategiaID
			INNER JOIN ods.Campania c ON c.Codigo = e.CampaniaID
			INNER JOIN ods.ProductoComercial pc ON pc.CUV= e.CUV2 AND pc.CampaniaID = c.CampaniaID
		WHERE
				e.CampaniaID = @CampaniaID
			AND (e.TipoEstrategiaID = @TipoEstrategiaID OR 0 = @TipoEstrategiaID)
			AND (e.CUV2 = @CUV OR '0' = @CUV)

	SET NOCOUNT OFF
END


GO

----------------------------------------------------------------------------------------------------------

USE BelcorpEcuador
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListarEstrategias]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ListarEstrategias]
GO

CREATE PROCEDURE ListarEstrategias
	@CampaniaID			INT,
	@TipoEstrategiaID	INT,
	@CUV				VARCHAR(20)
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
			e.ImagenURL
		FROM 
			Estrategia e 
			INNER JOIN TipoEstrategia te ON e.TipoEstrategiaID = te.TipoEstrategiaID
			INNER JOIN ods.Campania c ON c.Codigo = e.CampaniaID
			INNER JOIN ods.ProductoComercial pc ON pc.CUV= e.CUV2 AND pc.CampaniaID = c.CampaniaID
		WHERE
				e.CampaniaID = @CampaniaID
			AND (e.TipoEstrategiaID = @TipoEstrategiaID OR 0 = @TipoEstrategiaID)
			AND (e.CUV2 = @CUV OR '0' = @CUV)

	SET NOCOUNT OFF
END


GO

----------------------------------------------------------------------------------------------------------

USE BelcorpDominicana
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListarEstrategias]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ListarEstrategias]
GO

CREATE PROCEDURE ListarEstrategias
	@CampaniaID			INT,
	@TipoEstrategiaID	INT,
	@CUV				VARCHAR(20)
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
			e.ImagenURL
		FROM 
			Estrategia e 
			INNER JOIN TipoEstrategia te ON e.TipoEstrategiaID = te.TipoEstrategiaID
			INNER JOIN ods.Campania c ON c.Codigo = e.CampaniaID
			INNER JOIN ods.ProductoComercial pc ON pc.CUV= e.CUV2 AND pc.CampaniaID = c.CampaniaID
		WHERE
				e.CampaniaID = @CampaniaID
			AND (e.TipoEstrategiaID = @TipoEstrategiaID OR 0 = @TipoEstrategiaID)
			AND (e.CUV2 = @CUV OR '0' = @CUV)

	SET NOCOUNT OFF
END


GO

----------------------------------------------------------------------------------------------------------

USE BelcorpCostaRica
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListarEstrategias]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ListarEstrategias]
GO

CREATE PROCEDURE ListarEstrategias
	@CampaniaID			INT,
	@TipoEstrategiaID	INT,
	@CUV				VARCHAR(20)
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
			e.ImagenURL
		FROM 
			Estrategia e 
			INNER JOIN TipoEstrategia te ON e.TipoEstrategiaID = te.TipoEstrategiaID
			INNER JOIN ods.Campania c ON c.Codigo = e.CampaniaID
			INNER JOIN ods.ProductoComercial pc ON pc.CUV= e.CUV2 AND pc.CampaniaID = c.CampaniaID
		WHERE
				e.CampaniaID = @CampaniaID
			AND (e.TipoEstrategiaID = @TipoEstrategiaID OR 0 = @TipoEstrategiaID)
			AND (e.CUV2 = @CUV OR '0' = @CUV)

	SET NOCOUNT OFF
END


GO

----------------------------------------------------------------------------------------------------------

USE BelcorpChile
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListarEstrategias]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ListarEstrategias]
GO

CREATE PROCEDURE ListarEstrategias
	@CampaniaID			INT,
	@TipoEstrategiaID	INT,
	@CUV				VARCHAR(20)
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
			e.ImagenURL
		FROM 
			Estrategia e 
			INNER JOIN TipoEstrategia te ON e.TipoEstrategiaID = te.TipoEstrategiaID
			INNER JOIN ods.Campania c ON c.Codigo = e.CampaniaID
			INNER JOIN ods.ProductoComercial pc ON pc.CUV= e.CUV2 AND pc.CampaniaID = c.CampaniaID
		WHERE
				e.CampaniaID = @CampaniaID
			AND (e.TipoEstrategiaID = @TipoEstrategiaID OR 0 = @TipoEstrategiaID)
			AND (e.CUV2 = @CUV OR '0' = @CUV)

	SET NOCOUNT OFF
END


GO

----------------------------------------------------------------------------------------------------------

USE BelcorpBolivia
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListarEstrategias]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ListarEstrategias]
GO

CREATE PROCEDURE ListarEstrategias
	@CampaniaID			INT,
	@TipoEstrategiaID	INT,
	@CUV				VARCHAR(20)
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
			e.ImagenURL
		FROM 
			Estrategia e 
			INNER JOIN TipoEstrategia te ON e.TipoEstrategiaID = te.TipoEstrategiaID
			INNER JOIN ods.Campania c ON c.Codigo = e.CampaniaID
			INNER JOIN ods.ProductoComercial pc ON pc.CUV= e.CUV2 AND pc.CampaniaID = c.CampaniaID
		WHERE
				e.CampaniaID = @CampaniaID
			AND (e.TipoEstrategiaID = @TipoEstrategiaID OR 0 = @TipoEstrategiaID)
			AND (e.CUV2 = @CUV OR '0' = @CUV)

	SET NOCOUNT OFF
END


GO

----------------------------------------------------------------------------------------------------------

