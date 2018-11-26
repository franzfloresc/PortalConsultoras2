USE BelcorpPeru
GO

ALTER PROCEDURE ValidarStockOfertaLiquidacion
@CampaniaID int,
@CUV VARCHAR(20)
AS
BEGIN
DECLARE @CUVPadre VARCHAR(10)
SET @CUVPadre = @CUV
-- Verificamos si el cuv a validar es una talla o color
-- IF EXISTS (SELECT 1 FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = @CUV)
-- BEGIN
--	SET @CUVPadre = (SELECT CUVPadre FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = @CUV)
-- END
SELECT isnull(Stock,0) Stock
FROM OfertaProducto opr
inner join ods.Campania c on
opr.CampaniaID = c.CampaniaID
WHERE c.codigo = @CampaniaID
and opr.cuv = @CUVPadre
-- and opr.FlagHabilitarProducto = 1
END
GO

USE BelcorpMexico
GO

ALTER PROCEDURE ValidarStockOfertaLiquidacion
@CampaniaID int,
@CUV VARCHAR(20)
AS
BEGIN
DECLARE @CUVPadre VARCHAR(10)
SET @CUVPadre = @CUV
-- Verificamos si el cuv a validar es una talla o color
-- IF EXISTS (SELECT 1 FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = @CUV)
-- BEGIN
--	SET @CUVPadre = (SELECT CUVPadre FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = @CUV)
-- END
SELECT isnull(Stock,0) Stock
FROM OfertaProducto opr
inner join ods.Campania c on
opr.CampaniaID = c.CampaniaID
WHERE c.codigo = @CampaniaID
and opr.cuv = @CUVPadre
-- and opr.FlagHabilitarProducto = 1
END
GO

USE BelcorpColombia
GO

ALTER PROCEDURE ValidarStockOfertaLiquidacion
@CampaniaID int,
@CUV VARCHAR(20)
AS
BEGIN
DECLARE @CUVPadre VARCHAR(10)
SET @CUVPadre = @CUV
-- Verificamos si el cuv a validar es una talla o color
-- IF EXISTS (SELECT 1 FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = @CUV)
-- BEGIN
--	SET @CUVPadre = (SELECT CUVPadre FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = @CUV)
-- END
SELECT isnull(Stock,0) Stock
FROM OfertaProducto opr
inner join ods.Campania c on
opr.CampaniaID = c.CampaniaID
WHERE c.codigo = @CampaniaID
and opr.cuv = @CUVPadre
-- and opr.FlagHabilitarProducto = 1
END
GO

USE BelcorpSalvador
GO

ALTER PROCEDURE ValidarStockOfertaLiquidacion
@CampaniaID int,
@CUV VARCHAR(20)
AS
BEGIN
DECLARE @CUVPadre VARCHAR(10)
SET @CUVPadre = @CUV
-- Verificamos si el cuv a validar es una talla o color
-- IF EXISTS (SELECT 1 FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = @CUV)
-- BEGIN
--	SET @CUVPadre = (SELECT CUVPadre FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = @CUV)
-- END
SELECT isnull(Stock,0) Stock
FROM OfertaProducto opr
inner join ods.Campania c on
opr.CampaniaID = c.CampaniaID
WHERE c.codigo = @CampaniaID
and opr.cuv = @CUVPadre
-- and opr.FlagHabilitarProducto = 1
END
GO

USE BelcorpPuertoRico
GO

ALTER PROCEDURE ValidarStockOfertaLiquidacion
@CampaniaID int,
@CUV VARCHAR(20)
AS
BEGIN
DECLARE @CUVPadre VARCHAR(10)
SET @CUVPadre = @CUV
-- Verificamos si el cuv a validar es una talla o color
-- IF EXISTS (SELECT 1 FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = @CUV)
-- BEGIN
--	SET @CUVPadre = (SELECT CUVPadre FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = @CUV)
-- END
SELECT isnull(Stock,0) Stock
FROM OfertaProducto opr
inner join ods.Campania c on
opr.CampaniaID = c.CampaniaID
WHERE c.codigo = @CampaniaID
and opr.cuv = @CUVPadre
-- and opr.FlagHabilitarProducto = 1
END
GO

USE BelcorpPanama
GO

ALTER PROCEDURE ValidarStockOfertaLiquidacion
@CampaniaID int,
@CUV VARCHAR(20)
AS
BEGIN
DECLARE @CUVPadre VARCHAR(10)
SET @CUVPadre = @CUV
-- Verificamos si el cuv a validar es una talla o color
-- IF EXISTS (SELECT 1 FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = @CUV)
-- BEGIN
--	SET @CUVPadre = (SELECT CUVPadre FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = @CUV)
-- END
SELECT isnull(Stock,0) Stock
FROM OfertaProducto opr
inner join ods.Campania c on
opr.CampaniaID = c.CampaniaID
WHERE c.codigo = @CampaniaID
and opr.cuv = @CUVPadre
-- and opr.FlagHabilitarProducto = 1
END
GO

USE BelcorpGuatemala
GO

ALTER PROCEDURE ValidarStockOfertaLiquidacion
@CampaniaID int,
@CUV VARCHAR(20)
AS
BEGIN
DECLARE @CUVPadre VARCHAR(10)
SET @CUVPadre = @CUV
-- Verificamos si el cuv a validar es una talla o color
-- IF EXISTS (SELECT 1 FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = @CUV)
-- BEGIN
--	SET @CUVPadre = (SELECT CUVPadre FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = @CUV)
-- END
SELECT isnull(Stock,0) Stock
FROM OfertaProducto opr
inner join ods.Campania c on
opr.CampaniaID = c.CampaniaID
WHERE c.codigo = @CampaniaID
and opr.cuv = @CUVPadre
-- and opr.FlagHabilitarProducto = 1
END
GO

USE BelcorpEcuador
GO

ALTER PROCEDURE ValidarStockOfertaLiquidacion
@CampaniaID int,
@CUV VARCHAR(20)
AS
BEGIN
DECLARE @CUVPadre VARCHAR(10)
SET @CUVPadre = @CUV
-- Verificamos si el cuv a validar es una talla o color
-- IF EXISTS (SELECT 1 FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = @CUV)
-- BEGIN
--	SET @CUVPadre = (SELECT CUVPadre FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = @CUV)
-- END
SELECT isnull(Stock,0) Stock
FROM OfertaProducto opr
inner join ods.Campania c on
opr.CampaniaID = c.CampaniaID
WHERE c.codigo = @CampaniaID
and opr.cuv = @CUVPadre
-- and opr.FlagHabilitarProducto = 1
END
GO

USE BelcorpDominicana
GO

ALTER PROCEDURE ValidarStockOfertaLiquidacion
@CampaniaID int,
@CUV VARCHAR(20)
AS
BEGIN
DECLARE @CUVPadre VARCHAR(10)
SET @CUVPadre = @CUV
-- Verificamos si el cuv a validar es una talla o color
-- IF EXISTS (SELECT 1 FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = @CUV)
-- BEGIN
--	SET @CUVPadre = (SELECT CUVPadre FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = @CUV)
-- END
SELECT isnull(Stock,0) Stock
FROM OfertaProducto opr
inner join ods.Campania c on
opr.CampaniaID = c.CampaniaID
WHERE c.codigo = @CampaniaID
and opr.cuv = @CUVPadre
-- and opr.FlagHabilitarProducto = 1
END
GO

USE BelcorpCostaRica
GO

ALTER PROCEDURE ValidarStockOfertaLiquidacion
@CampaniaID int,
@CUV VARCHAR(20)
AS
BEGIN
DECLARE @CUVPadre VARCHAR(10)
SET @CUVPadre = @CUV
-- Verificamos si el cuv a validar es una talla o color
-- IF EXISTS (SELECT 1 FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = @CUV)
-- BEGIN
--	SET @CUVPadre = (SELECT CUVPadre FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = @CUV)
-- END
SELECT isnull(Stock,0) Stock
FROM OfertaProducto opr
inner join ods.Campania c on
opr.CampaniaID = c.CampaniaID
WHERE c.codigo = @CampaniaID
and opr.cuv = @CUVPadre
-- and opr.FlagHabilitarProducto = 1
END
GO

USE BelcorpChile
GO

ALTER PROCEDURE ValidarStockOfertaLiquidacion
@CampaniaID int,
@CUV VARCHAR(20)
AS
BEGIN
DECLARE @CUVPadre VARCHAR(10)
SET @CUVPadre = @CUV
-- Verificamos si el cuv a validar es una talla o color
-- IF EXISTS (SELECT 1 FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = @CUV)
-- BEGIN
--	SET @CUVPadre = (SELECT CUVPadre FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = @CUV)
-- END
SELECT isnull(Stock,0) Stock
FROM OfertaProducto opr
inner join ods.Campania c on
opr.CampaniaID = c.CampaniaID
WHERE c.codigo = @CampaniaID
and opr.cuv = @CUVPadre
-- and opr.FlagHabilitarProducto = 1
END
GO

USE BelcorpBolivia
GO

ALTER PROCEDURE ValidarStockOfertaLiquidacion
@CampaniaID int,
@CUV VARCHAR(20)
AS
BEGIN
DECLARE @CUVPadre VARCHAR(10)
SET @CUVPadre = @CUV
-- Verificamos si el cuv a validar es una talla o color
-- IF EXISTS (SELECT 1 FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = @CUV)
-- BEGIN
--	SET @CUVPadre = (SELECT CUVPadre FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = @CUV)
-- END
SELECT isnull(Stock,0) Stock
FROM OfertaProducto opr
inner join ods.Campania c on
opr.CampaniaID = c.CampaniaID
WHERE c.codigo = @CampaniaID
and opr.cuv = @CUVPadre
-- and opr.FlagHabilitarProducto = 1
END
GO

