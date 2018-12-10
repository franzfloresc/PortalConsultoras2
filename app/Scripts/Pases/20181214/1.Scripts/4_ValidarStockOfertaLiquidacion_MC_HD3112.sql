USE BelcorpPeru
GO

ALTER PROCEDURE [dbo].[ValidarStockOfertaLiquidacion]
	@CampaniaID int,
	@CUV VARCHAR(20)
AS
BEGIN
	DECLARE @CUVPadre VARCHAR(10)
	SET @CUVPadre = @CUV
	SELECT isnull(StockInicial,0) - IsNull(Stock,0) Stock
	FROM OfertaProducto opr 
		inner join ods.Campania c on 
		opr.CampaniaID = c.CampaniaID
	WHERE c.codigo = @CampaniaID
			and opr.cuv = @CUVPadre
END
GO

USE BelcorpMexico
GO

ALTER PROCEDURE [dbo].[ValidarStockOfertaLiquidacion]
	@CampaniaID int,
	@CUV VARCHAR(20)
AS
BEGIN
	DECLARE @CUVPadre VARCHAR(10)
	SET @CUVPadre = @CUV
	SELECT isnull(StockInicial,0) - IsNull(Stock,0) Stock
	FROM OfertaProducto opr 
		inner join ods.Campania c on 
		opr.CampaniaID = c.CampaniaID
	WHERE c.codigo = @CampaniaID
			and opr.cuv = @CUVPadre
END
GO

USE BelcorpColombia
GO

ALTER PROCEDURE [dbo].[ValidarStockOfertaLiquidacion]
	@CampaniaID int,
	@CUV VARCHAR(20)
AS
BEGIN
	DECLARE @CUVPadre VARCHAR(10)
	SET @CUVPadre = @CUV
	SELECT isnull(StockInicial,0) - IsNull(Stock,0) Stock
	FROM OfertaProducto opr 
		inner join ods.Campania c on 
		opr.CampaniaID = c.CampaniaID
	WHERE c.codigo = @CampaniaID
			and opr.cuv = @CUVPadre
END
GO

USE BelcorpSalvador
GO

ALTER PROCEDURE [dbo].[ValidarStockOfertaLiquidacion]
	@CampaniaID int,
	@CUV VARCHAR(20)
AS
BEGIN
	DECLARE @CUVPadre VARCHAR(10)
	SET @CUVPadre = @CUV
	SELECT isnull(StockInicial,0) - IsNull(Stock,0) Stock
	FROM OfertaProducto opr 
		inner join ods.Campania c on 
		opr.CampaniaID = c.CampaniaID
	WHERE c.codigo = @CampaniaID
			and opr.cuv = @CUVPadre
END
GO

USE BelcorpPuertoRico
GO

ALTER PROCEDURE [dbo].[ValidarStockOfertaLiquidacion]
	@CampaniaID int,
	@CUV VARCHAR(20)
AS
BEGIN
	DECLARE @CUVPadre VARCHAR(10)
	SET @CUVPadre = @CUV
	SELECT isnull(StockInicial,0) - IsNull(Stock,0) Stock
	FROM OfertaProducto opr 
		inner join ods.Campania c on 
		opr.CampaniaID = c.CampaniaID
	WHERE c.codigo = @CampaniaID
			and opr.cuv = @CUVPadre
END
GO

USE BelcorpPanama
GO

ALTER PROCEDURE [dbo].[ValidarStockOfertaLiquidacion]
	@CampaniaID int,
	@CUV VARCHAR(20)
AS
BEGIN
	DECLARE @CUVPadre VARCHAR(10)
	SET @CUVPadre = @CUV
	SELECT isnull(StockInicial,0) - IsNull(Stock,0) Stock
	FROM OfertaProducto opr 
		inner join ods.Campania c on 
		opr.CampaniaID = c.CampaniaID
	WHERE c.codigo = @CampaniaID
			and opr.cuv = @CUVPadre
END
GO

USE BelcorpGuatemala
GO

ALTER PROCEDURE [dbo].[ValidarStockOfertaLiquidacion]
	@CampaniaID int,
	@CUV VARCHAR(20)
AS
BEGIN
	DECLARE @CUVPadre VARCHAR(10)
	SET @CUVPadre = @CUV
	SELECT isnull(StockInicial,0) - IsNull(Stock,0) Stock
	FROM OfertaProducto opr 
		inner join ods.Campania c on 
		opr.CampaniaID = c.CampaniaID
	WHERE c.codigo = @CampaniaID
			and opr.cuv = @CUVPadre
END
GO

USE BelcorpEcuador
GO

ALTER PROCEDURE [dbo].[ValidarStockOfertaLiquidacion]
	@CampaniaID int,
	@CUV VARCHAR(20)
AS
BEGIN
	DECLARE @CUVPadre VARCHAR(10)
	SET @CUVPadre = @CUV
	SELECT isnull(StockInicial,0) - IsNull(Stock,0) Stock
	FROM OfertaProducto opr 
		inner join ods.Campania c on 
		opr.CampaniaID = c.CampaniaID
	WHERE c.codigo = @CampaniaID
			and opr.cuv = @CUVPadre
END
GO

USE BelcorpDominicana
GO

ALTER PROCEDURE [dbo].[ValidarStockOfertaLiquidacion]
	@CampaniaID int,
	@CUV VARCHAR(20)
AS
BEGIN
	DECLARE @CUVPadre VARCHAR(10)
	SET @CUVPadre = @CUV
	SELECT isnull(StockInicial,0) - IsNull(Stock,0) Stock
	FROM OfertaProducto opr 
		inner join ods.Campania c on 
		opr.CampaniaID = c.CampaniaID
	WHERE c.codigo = @CampaniaID
			and opr.cuv = @CUVPadre
END
GO

USE BelcorpCostaRica
GO

ALTER PROCEDURE [dbo].[ValidarStockOfertaLiquidacion]
	@CampaniaID int,
	@CUV VARCHAR(20)
AS
BEGIN
	DECLARE @CUVPadre VARCHAR(10)
	SET @CUVPadre = @CUV
	SELECT isnull(StockInicial,0) - IsNull(Stock,0) Stock
	FROM OfertaProducto opr 
		inner join ods.Campania c on 
		opr.CampaniaID = c.CampaniaID
	WHERE c.codigo = @CampaniaID
			and opr.cuv = @CUVPadre
END
GO

USE BelcorpChile
GO

ALTER PROCEDURE [dbo].[ValidarStockOfertaLiquidacion]
	@CampaniaID int,
	@CUV VARCHAR(20)
AS
BEGIN
	DECLARE @CUVPadre VARCHAR(10)
	SET @CUVPadre = @CUV
	SELECT isnull(StockInicial,0) - IsNull(Stock,0) Stock
	FROM OfertaProducto opr 
		inner join ods.Campania c on 
		opr.CampaniaID = c.CampaniaID
	WHERE c.codigo = @CampaniaID
			and opr.cuv = @CUVPadre
END
GO

USE BelcorpBolivia
GO

ALTER PROCEDURE [dbo].[ValidarStockOfertaLiquidacion]
	@CampaniaID int,
	@CUV VARCHAR(20)
AS
BEGIN
	DECLARE @CUVPadre VARCHAR(10)
	SET @CUVPadre = @CUV
	SELECT isnull(StockInicial,0) - IsNull(Stock,0) Stock
	FROM OfertaProducto opr 
		inner join ods.Campania c on 
		opr.CampaniaID = c.CampaniaID
	WHERE c.codigo = @CampaniaID
			and opr.cuv = @CUVPadre
END
GO

