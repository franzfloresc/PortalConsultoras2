USE BelcorpPeru
GO

ALTER PROCEDURE UpdStockOfertaProducto
(
@TipoOfertaSisID int,
@CampaniaID int,
@CUV varchar(20),
@Stock int
)
AS
BEGIN

DECLARE @CUVPadre VARCHAR(10)
SET @CUVPadre = @CUV
-- Verificamos si el cuv a validar es una talla o color
IF EXISTS (SELECT 1 FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = @CUV)
BEGIN
SET @CUVPadre = (SELECT CUVPadre FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = @CUV)
END

UPDATE dbo.OfertaProducto
SET Stock -= @Stock
FROM dbo.OfertaProducto o
JOIN ods.campania c
on c.CampaniaID = o.CampaniaID
WHERE c.Codigo = @CampaniaID
AND o.CUV = @CUVPadre
AND o.TipoOfertaSisID = @TipoOfertaSisID
END
GO

USE BelcorpMexico
GO

ALTER PROCEDURE UpdStockOfertaProducto
(
@TipoOfertaSisID int,
@CampaniaID int,
@CUV varchar(20),
@Stock int
)
AS
BEGIN

DECLARE @CUVPadre VARCHAR(10)
SET @CUVPadre = @CUV
-- Verificamos si el cuv a validar es una talla o color
IF EXISTS (SELECT 1 FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = @CUV)
BEGIN
SET @CUVPadre = (SELECT CUVPadre FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = @CUV)
END

UPDATE dbo.OfertaProducto
SET Stock -= @Stock
FROM dbo.OfertaProducto o
JOIN ods.campania c
on c.CampaniaID = o.CampaniaID
WHERE c.Codigo = @CampaniaID
AND o.CUV = @CUVPadre
AND o.TipoOfertaSisID = @TipoOfertaSisID
END
GO

USE BelcorpColombia
GO

ALTER PROCEDURE UpdStockOfertaProducto
(
@TipoOfertaSisID int,
@CampaniaID int,
@CUV varchar(20),
@Stock int
)
AS
BEGIN

DECLARE @CUVPadre VARCHAR(10)
SET @CUVPadre = @CUV
-- Verificamos si el cuv a validar es una talla o color
IF EXISTS (SELECT 1 FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = @CUV)
BEGIN
SET @CUVPadre = (SELECT CUVPadre FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = @CUV)
END

UPDATE dbo.OfertaProducto
SET Stock -= @Stock
FROM dbo.OfertaProducto o
JOIN ods.campania c
on c.CampaniaID = o.CampaniaID
WHERE c.Codigo = @CampaniaID
AND o.CUV = @CUVPadre
AND o.TipoOfertaSisID = @TipoOfertaSisID
END
GO

USE BelcorpSalvador
GO

ALTER PROCEDURE UpdStockOfertaProducto
@TipoOfertaSisID int,
@CampaniaID int,
@CUV varchar(20),
@Stock int
AS
BEGIN

DECLARE @CUVPadre VARCHAR(10)
SET @CUVPadre = @CUV
-- Verificamos si el cuv a validar es una talla o color
-- IF EXISTS (SELECT 1 FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = @CUV)
-- BEGIN
-- 	SET @CUVPadre = (SELECT CUVPadre FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = @CUV)
-- END

UPDATE dbo.OfertaProducto
SET Stock -= @Stock
FROM dbo.OfertaProducto o
JOIN ods.campania c
on c.CampaniaID = o.CampaniaID
WHERE c.Codigo = @CampaniaID
AND o.CUV = @CUVPadre
AND o.TipoOfertaSisID = @TipoOfertaSisID
END
GO

USE BelcorpPuertoRico
GO

ALTER PROCEDURE UpdStockOfertaProducto
@TipoOfertaSisID int,
@CampaniaID int,
@CUV varchar(20),
@Stock int
AS
BEGIN

DECLARE @CUVPadre VARCHAR(10)
SET @CUVPadre = @CUV
-- Verificamos si el cuv a validar es una talla o color
-- IF EXISTS (SELECT 1 FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = @CUV)
-- BEGIN
-- 	SET @CUVPadre = (SELECT CUVPadre FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = @CUV)
-- END

UPDATE dbo.OfertaProducto
SET Stock -= @Stock
FROM dbo.OfertaProducto o
JOIN ods.campania c
on c.CampaniaID = o.CampaniaID
WHERE c.Codigo = @CampaniaID
AND o.CUV = @CUVPadre
AND o.TipoOfertaSisID = @TipoOfertaSisID
END
GO

USE BelcorpPanama
GO

ALTER PROCEDURE UpdStockOfertaProducto
@TipoOfertaSisID int,
@CampaniaID int,
@CUV varchar(20),
@Stock int
AS
BEGIN

DECLARE @CUVPadre VARCHAR(10)
SET @CUVPadre = @CUV
-- Verificamos si el cuv a validar es una talla o color
-- IF EXISTS (SELECT 1 FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = @CUV)
-- BEGIN
-- 	SET @CUVPadre = (SELECT CUVPadre FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = @CUV)
-- END

UPDATE dbo.OfertaProducto
SET Stock -= @Stock
FROM dbo.OfertaProducto o
JOIN ods.campania c
on c.CampaniaID = o.CampaniaID
WHERE c.Codigo = @CampaniaID
AND o.CUV = @CUVPadre
AND o.TipoOfertaSisID = @TipoOfertaSisID
END
GO

USE BelcorpGuatemala
GO

ALTER PROCEDURE UpdStockOfertaProducto
@TipoOfertaSisID int,
@CampaniaID int,
@CUV varchar(20),
@Stock int
AS
BEGIN

DECLARE @CUVPadre VARCHAR(10)
SET @CUVPadre = @CUV
-- Verificamos si el cuv a validar es una talla o color
-- IF EXISTS (SELECT 1 FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = @CUV)
-- BEGIN
-- 	SET @CUVPadre = (SELECT CUVPadre FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = @CUV)
-- END

UPDATE dbo.OfertaProducto
SET Stock -= @Stock
FROM dbo.OfertaProducto o
JOIN ods.campania c
on c.CampaniaID = o.CampaniaID
WHERE c.Codigo = @CampaniaID
AND o.CUV = @CUVPadre
AND o.TipoOfertaSisID = @TipoOfertaSisID
END
GO

USE BelcorpEcuador
GO

ALTER PROCEDURE UpdStockOfertaProducto
@TipoOfertaSisID int,
@CampaniaID int,
@CUV varchar(20),
@Stock int
AS
BEGIN

DECLARE @CUVPadre VARCHAR(10)
SET @CUVPadre = @CUV
-- Verificamos si el cuv a validar es una talla o color
-- IF EXISTS (SELECT 1 FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = @CUV)
-- BEGIN
-- 	SET @CUVPadre = (SELECT CUVPadre FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = @CUV)
-- END

UPDATE dbo.OfertaProducto
SET Stock -= @Stock
FROM dbo.OfertaProducto o
JOIN ods.campania c
on c.CampaniaID = o.CampaniaID
WHERE c.Codigo = @CampaniaID
AND o.CUV = @CUVPadre
AND o.TipoOfertaSisID = @TipoOfertaSisID
END
GO

USE BelcorpDominicana
GO

ALTER PROCEDURE UpdStockOfertaProducto
@TipoOfertaSisID int,
@CampaniaID int,
@CUV varchar(20),
@Stock int
AS
BEGIN

DECLARE @CUVPadre VARCHAR(10)
SET @CUVPadre = @CUV
-- Verificamos si el cuv a validar es una talla o color
-- IF EXISTS (SELECT 1 FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = @CUV)
-- BEGIN
-- 	SET @CUVPadre = (SELECT CUVPadre FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = @CUV)
-- END

UPDATE dbo.OfertaProducto
SET Stock -= @Stock
FROM dbo.OfertaProducto o
JOIN ods.campania c
on c.CampaniaID = o.CampaniaID
WHERE c.Codigo = @CampaniaID
AND o.CUV = @CUVPadre
AND o.TipoOfertaSisID = @TipoOfertaSisID
END
GO

USE BelcorpCostaRica
GO

ALTER PROCEDURE UpdStockOfertaProducto
@TipoOfertaSisID int,
@CampaniaID int,
@CUV varchar(20),
@Stock int
AS
BEGIN

DECLARE @CUVPadre VARCHAR(10)
SET @CUVPadre = @CUV
-- Verificamos si el cuv a validar es una talla o color
-- IF EXISTS (SELECT 1 FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = @CUV)
-- BEGIN
-- 	SET @CUVPadre = (SELECT CUVPadre FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = @CUV)
-- END

UPDATE dbo.OfertaProducto
SET Stock -= @Stock
FROM dbo.OfertaProducto o
JOIN ods.campania c
on c.CampaniaID = o.CampaniaID
WHERE c.Codigo = @CampaniaID
AND o.CUV = @CUVPadre
AND o.TipoOfertaSisID = @TipoOfertaSisID
END
GO

USE BelcorpChile
GO

ALTER PROCEDURE UpdStockOfertaProducto
@TipoOfertaSisID int,
@CampaniaID int,
@CUV varchar(20),
@Stock int
AS
BEGIN

DECLARE @CUVPadre VARCHAR(10)
SET @CUVPadre = @CUV
-- Verificamos si el cuv a validar es una talla o color
-- IF EXISTS (SELECT 1 FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = @CUV)
-- BEGIN
-- 	SET @CUVPadre = (SELECT CUVPadre FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = @CUV)
-- END

UPDATE dbo.OfertaProducto
SET Stock -= @Stock
FROM dbo.OfertaProducto o
JOIN ods.campania c
on c.CampaniaID = o.CampaniaID
WHERE c.Codigo = @CampaniaID
AND o.CUV = @CUVPadre
AND o.TipoOfertaSisID = @TipoOfertaSisID
END
GO

USE BelcorpBolivia
GO

ALTER PROCEDURE UpdStockOfertaProducto
@TipoOfertaSisID int,
@CampaniaID int,
@CUV varchar(20),
@Stock int
AS
BEGIN

DECLARE @CUVPadre VARCHAR(10)
SET @CUVPadre = @CUV
-- Verificamos si el cuv a validar es una talla o color
-- IF EXISTS (SELECT 1 FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = @CUV)
-- BEGIN
-- 	SET @CUVPadre = (SELECT CUVPadre FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = @CUV)
-- END

UPDATE dbo.OfertaProducto
SET Stock -= @Stock
FROM dbo.OfertaProducto o
JOIN ods.campania c
on c.CampaniaID = o.CampaniaID
WHERE c.Codigo = @CampaniaID
AND o.CUV = @CUVPadre
AND o.TipoOfertaSisID = @TipoOfertaSisID
END
GO

