USE BelcorpPeru
GO

IF (OBJECT_ID('ShowRoom.ValidarUnidadesPermitidasByCUVShowRoom', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.ValidarUnidadesPermitidasByCUVShowRoom AS SET NOCOUNT ON;')
GO

--
ALTER procedure ShowRoom.ValidarUnidadesPermitidasByCUVShowRoom
@CampaniaID INT,
@CUV VARCHAR(20)
as
/*
ShowRoom.ValidarUnidadesPermitidasByCUVShowRoom 201607,'99001'
*/
begin

DECLARE @UnidadesPermitidas INT, @CUVPadre VARCHAR(10) 
SET @CUVPadre = @CUV
-- Verificamos si el cuv a validar es una talla o color
IF EXISTS (SELECT 1 FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = @CUV)
BEGIN
	SET @CUVPadre = (SELECT CUVPadre FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = @CUV)
END

SELECT @UnidadesPermitidas = isnull(op.UnidadesPermitidas, 0)
FROM ShowRoom.OfertaShowRoom op 
inner join ods.campania ca ON ca.campaniaid = op.campaniaid
WHERE 
	op.tipoOfertaSisID = 1707
	AND op.CUV = @CUVPadre
	AND ca.Codigo = @CampaniaID

select isnull(@UnidadesPermitidas,0)

end


GO

USE BelcorpMexico
GO

IF (OBJECT_ID('ShowRoom.ValidarUnidadesPermitidasByCUVShowRoom', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.ValidarUnidadesPermitidasByCUVShowRoom AS SET NOCOUNT ON;')
GO

--
ALTER procedure ShowRoom.ValidarUnidadesPermitidasByCUVShowRoom
@CampaniaID INT,
@CUV VARCHAR(20)
as
/*
ShowRoom.ValidarUnidadesPermitidasByCUVShowRoom 201607,'99001'
*/
begin

DECLARE @UnidadesPermitidas INT, @CUVPadre VARCHAR(10) 
SET @CUVPadre = @CUV
-- Verificamos si el cuv a validar es una talla o color
IF EXISTS (SELECT 1 FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = @CUV)
BEGIN
	SET @CUVPadre = (SELECT CUVPadre FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = @CUV)
END

SELECT @UnidadesPermitidas = isnull(op.UnidadesPermitidas, 0)
FROM ShowRoom.OfertaShowRoom op 
inner join ods.campania ca ON ca.campaniaid = op.campaniaid
WHERE 
	op.tipoOfertaSisID = 1707
	AND op.CUV = @CUVPadre
	AND ca.Codigo = @CampaniaID

select isnull(@UnidadesPermitidas,0)

end


GO

USE BelcorpColombia
GO

IF (OBJECT_ID('ShowRoom.ValidarUnidadesPermitidasByCUVShowRoom', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.ValidarUnidadesPermitidasByCUVShowRoom AS SET NOCOUNT ON;')
GO

--
ALTER procedure ShowRoom.ValidarUnidadesPermitidasByCUVShowRoom
@CampaniaID INT,
@CUV VARCHAR(20)
as
/*
ShowRoom.ValidarUnidadesPermitidasByCUVShowRoom 201607,'99001'
*/
begin

DECLARE @UnidadesPermitidas INT, @CUVPadre VARCHAR(10) 
SET @CUVPadre = @CUV
-- Verificamos si el cuv a validar es una talla o color
IF EXISTS (SELECT 1 FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = @CUV)
BEGIN
	SET @CUVPadre = (SELECT CUVPadre FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = @CUV)
END

SELECT @UnidadesPermitidas = isnull(op.UnidadesPermitidas, 0)
FROM ShowRoom.OfertaShowRoom op 
inner join ods.campania ca ON ca.campaniaid = op.campaniaid
WHERE 
	op.tipoOfertaSisID = 1707
	AND op.CUV = @CUVPadre
	AND ca.Codigo = @CampaniaID

select isnull(@UnidadesPermitidas,0)

end


GO

USE BelcorpVenezuela
GO

IF (OBJECT_ID('ShowRoom.ValidarUnidadesPermitidasByCUVShowRoom', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.ValidarUnidadesPermitidasByCUVShowRoom AS SET NOCOUNT ON;')
GO

--
ALTER procedure ShowRoom.ValidarUnidadesPermitidasByCUVShowRoom
@CampaniaID INT,
@CUV VARCHAR(20)
as
/*
ShowRoom.ValidarUnidadesPermitidasByCUVShowRoom 201607,'99001'
*/
begin

DECLARE @UnidadesPermitidas INT, @CUVPadre VARCHAR(10) 
SET @CUVPadre = @CUV
-- Verificamos si el cuv a validar es una talla o color
IF EXISTS (SELECT 1 FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = @CUV)
BEGIN
	SET @CUVPadre = (SELECT CUVPadre FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = @CUV)
END

SELECT @UnidadesPermitidas = isnull(op.UnidadesPermitidas, 0)
FROM ShowRoom.OfertaShowRoom op 
inner join ods.campania ca ON ca.campaniaid = op.campaniaid
WHERE 
	op.tipoOfertaSisID = 1707
	AND op.CUV = @CUVPadre
	AND ca.Codigo = @CampaniaID

select isnull(@UnidadesPermitidas,0)

end


GO

USE BelcorpSalvador
GO

IF (OBJECT_ID('ShowRoom.ValidarUnidadesPermitidasByCUVShowRoom', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.ValidarUnidadesPermitidasByCUVShowRoom AS SET NOCOUNT ON;')
GO

--
ALTER procedure ShowRoom.ValidarUnidadesPermitidasByCUVShowRoom
@CampaniaID INT,
@CUV VARCHAR(20)
as
/*
ShowRoom.ValidarUnidadesPermitidasByCUVShowRoom 201607,'99001'
*/
begin

DECLARE @UnidadesPermitidas INT, @CUVPadre VARCHAR(10) 
SET @CUVPadre = @CUV
-- Verificamos si el cuv a validar es una talla o color
IF EXISTS (SELECT 1 FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = @CUV)
BEGIN
	SET @CUVPadre = (SELECT CUVPadre FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = @CUV)
END

SELECT @UnidadesPermitidas = isnull(op.UnidadesPermitidas, 0)
FROM ShowRoom.OfertaShowRoom op 
inner join ods.campania ca ON ca.campaniaid = op.campaniaid
WHERE 
	op.tipoOfertaSisID = 1707
	AND op.CUV = @CUVPadre
	AND ca.Codigo = @CampaniaID

select isnull(@UnidadesPermitidas,0)

end


GO

USE BelcorpPuertoRico
GO

IF (OBJECT_ID('ShowRoom.ValidarUnidadesPermitidasByCUVShowRoom', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.ValidarUnidadesPermitidasByCUVShowRoom AS SET NOCOUNT ON;')
GO

--
ALTER procedure ShowRoom.ValidarUnidadesPermitidasByCUVShowRoom
@CampaniaID INT,
@CUV VARCHAR(20)
as
/*
ShowRoom.ValidarUnidadesPermitidasByCUVShowRoom 201607,'99001'
*/
begin

DECLARE @UnidadesPermitidas INT, @CUVPadre VARCHAR(10) 
SET @CUVPadre = @CUV
-- Verificamos si el cuv a validar es una talla o color
IF EXISTS (SELECT 1 FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = @CUV)
BEGIN
	SET @CUVPadre = (SELECT CUVPadre FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = @CUV)
END

SELECT @UnidadesPermitidas = isnull(op.UnidadesPermitidas, 0)
FROM ShowRoom.OfertaShowRoom op 
inner join ods.campania ca ON ca.campaniaid = op.campaniaid
WHERE 
	op.tipoOfertaSisID = 1707
	AND op.CUV = @CUVPadre
	AND ca.Codigo = @CampaniaID

select isnull(@UnidadesPermitidas,0)

end


GO

USE BelcorpPanama
GO

IF (OBJECT_ID('ShowRoom.ValidarUnidadesPermitidasByCUVShowRoom', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.ValidarUnidadesPermitidasByCUVShowRoom AS SET NOCOUNT ON;')
GO

--
ALTER procedure ShowRoom.ValidarUnidadesPermitidasByCUVShowRoom
@CampaniaID INT,
@CUV VARCHAR(20)
as
/*
ShowRoom.ValidarUnidadesPermitidasByCUVShowRoom 201607,'99001'
*/
begin

DECLARE @UnidadesPermitidas INT, @CUVPadre VARCHAR(10) 
SET @CUVPadre = @CUV
-- Verificamos si el cuv a validar es una talla o color
IF EXISTS (SELECT 1 FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = @CUV)
BEGIN
	SET @CUVPadre = (SELECT CUVPadre FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = @CUV)
END

SELECT @UnidadesPermitidas = isnull(op.UnidadesPermitidas, 0)
FROM ShowRoom.OfertaShowRoom op 
inner join ods.campania ca ON ca.campaniaid = op.campaniaid
WHERE 
	op.tipoOfertaSisID = 1707
	AND op.CUV = @CUVPadre
	AND ca.Codigo = @CampaniaID

select isnull(@UnidadesPermitidas,0)

end


GO

USE BelcorpGuatemala
GO

IF (OBJECT_ID('ShowRoom.ValidarUnidadesPermitidasByCUVShowRoom', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.ValidarUnidadesPermitidasByCUVShowRoom AS SET NOCOUNT ON;')
GO

--
ALTER procedure ShowRoom.ValidarUnidadesPermitidasByCUVShowRoom
@CampaniaID INT,
@CUV VARCHAR(20)
as
/*
ShowRoom.ValidarUnidadesPermitidasByCUVShowRoom 201607,'99001'
*/
begin

DECLARE @UnidadesPermitidas INT, @CUVPadre VARCHAR(10) 
SET @CUVPadre = @CUV
-- Verificamos si el cuv a validar es una talla o color
IF EXISTS (SELECT 1 FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = @CUV)
BEGIN
	SET @CUVPadre = (SELECT CUVPadre FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = @CUV)
END

SELECT @UnidadesPermitidas = isnull(op.UnidadesPermitidas, 0)
FROM ShowRoom.OfertaShowRoom op 
inner join ods.campania ca ON ca.campaniaid = op.campaniaid
WHERE 
	op.tipoOfertaSisID = 1707
	AND op.CUV = @CUVPadre
	AND ca.Codigo = @CampaniaID

select isnull(@UnidadesPermitidas,0)

end


GO

USE BelcorpEcuador
GO

IF (OBJECT_ID('ShowRoom.ValidarUnidadesPermitidasByCUVShowRoom', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.ValidarUnidadesPermitidasByCUVShowRoom AS SET NOCOUNT ON;')
GO

--
ALTER procedure ShowRoom.ValidarUnidadesPermitidasByCUVShowRoom
@CampaniaID INT,
@CUV VARCHAR(20)
as
/*
ShowRoom.ValidarUnidadesPermitidasByCUVShowRoom 201607,'99001'
*/
begin

DECLARE @UnidadesPermitidas INT, @CUVPadre VARCHAR(10) 
SET @CUVPadre = @CUV
-- Verificamos si el cuv a validar es una talla o color
IF EXISTS (SELECT 1 FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = @CUV)
BEGIN
	SET @CUVPadre = (SELECT CUVPadre FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = @CUV)
END

SELECT @UnidadesPermitidas = isnull(op.UnidadesPermitidas, 0)
FROM ShowRoom.OfertaShowRoom op 
inner join ods.campania ca ON ca.campaniaid = op.campaniaid
WHERE 
	op.tipoOfertaSisID = 1707
	AND op.CUV = @CUVPadre
	AND ca.Codigo = @CampaniaID

select isnull(@UnidadesPermitidas,0)

end


GO

USE BelcorpDominicana
GO

IF (OBJECT_ID('ShowRoom.ValidarUnidadesPermitidasByCUVShowRoom', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.ValidarUnidadesPermitidasByCUVShowRoom AS SET NOCOUNT ON;')
GO

--
ALTER procedure ShowRoom.ValidarUnidadesPermitidasByCUVShowRoom
@CampaniaID INT,
@CUV VARCHAR(20)
as
/*
ShowRoom.ValidarUnidadesPermitidasByCUVShowRoom 201607,'99001'
*/
begin

DECLARE @UnidadesPermitidas INT, @CUVPadre VARCHAR(10) 
SET @CUVPadre = @CUV
-- Verificamos si el cuv a validar es una talla o color
IF EXISTS (SELECT 1 FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = @CUV)
BEGIN
	SET @CUVPadre = (SELECT CUVPadre FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = @CUV)
END

SELECT @UnidadesPermitidas = isnull(op.UnidadesPermitidas, 0)
FROM ShowRoom.OfertaShowRoom op 
inner join ods.campania ca ON ca.campaniaid = op.campaniaid
WHERE 
	op.tipoOfertaSisID = 1707
	AND op.CUV = @CUVPadre
	AND ca.Codigo = @CampaniaID

select isnull(@UnidadesPermitidas,0)

end


GO

USE BelcorpCostaRica
GO

IF (OBJECT_ID('ShowRoom.ValidarUnidadesPermitidasByCUVShowRoom', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.ValidarUnidadesPermitidasByCUVShowRoom AS SET NOCOUNT ON;')
GO

--
ALTER procedure ShowRoom.ValidarUnidadesPermitidasByCUVShowRoom
@CampaniaID INT,
@CUV VARCHAR(20)
as
/*
ShowRoom.ValidarUnidadesPermitidasByCUVShowRoom 201607,'99001'
*/
begin

DECLARE @UnidadesPermitidas INT, @CUVPadre VARCHAR(10) 
SET @CUVPadre = @CUV
-- Verificamos si el cuv a validar es una talla o color
IF EXISTS (SELECT 1 FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = @CUV)
BEGIN
	SET @CUVPadre = (SELECT CUVPadre FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = @CUV)
END

SELECT @UnidadesPermitidas = isnull(op.UnidadesPermitidas, 0)
FROM ShowRoom.OfertaShowRoom op 
inner join ods.campania ca ON ca.campaniaid = op.campaniaid
WHERE 
	op.tipoOfertaSisID = 1707
	AND op.CUV = @CUVPadre
	AND ca.Codigo = @CampaniaID

select isnull(@UnidadesPermitidas,0)

end


GO

USE BelcorpChile
GO

IF (OBJECT_ID('ShowRoom.ValidarUnidadesPermitidasByCUVShowRoom', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.ValidarUnidadesPermitidasByCUVShowRoom AS SET NOCOUNT ON;')
GO

--
ALTER procedure ShowRoom.ValidarUnidadesPermitidasByCUVShowRoom
@CampaniaID INT,
@CUV VARCHAR(20)
as
/*
ShowRoom.ValidarUnidadesPermitidasByCUVShowRoom 201607,'99001'
*/
begin

DECLARE @UnidadesPermitidas INT, @CUVPadre VARCHAR(10) 
SET @CUVPadre = @CUV
-- Verificamos si el cuv a validar es una talla o color
IF EXISTS (SELECT 1 FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = @CUV)
BEGIN
	SET @CUVPadre = (SELECT CUVPadre FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = @CUV)
END

SELECT @UnidadesPermitidas = isnull(op.UnidadesPermitidas, 0)
FROM ShowRoom.OfertaShowRoom op 
inner join ods.campania ca ON ca.campaniaid = op.campaniaid
WHERE 
	op.tipoOfertaSisID = 1707
	AND op.CUV = @CUVPadre
	AND ca.Codigo = @CampaniaID

select isnull(@UnidadesPermitidas,0)

end


GO

USE BelcorpBolivia
GO

IF (OBJECT_ID('ShowRoom.ValidarUnidadesPermitidasByCUVShowRoom', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.ValidarUnidadesPermitidasByCUVShowRoom AS SET NOCOUNT ON;')
GO

--
ALTER procedure ShowRoom.ValidarUnidadesPermitidasByCUVShowRoom
@CampaniaID INT,
@CUV VARCHAR(20)
as
/*
ShowRoom.ValidarUnidadesPermitidasByCUVShowRoom 201607,'99001'
*/
begin

DECLARE @UnidadesPermitidas INT, @CUVPadre VARCHAR(10) 
SET @CUVPadre = @CUV
-- Verificamos si el cuv a validar es una talla o color
IF EXISTS (SELECT 1 FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = @CUV)
BEGIN
	SET @CUVPadre = (SELECT CUVPadre FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = @CUV)
END

SELECT @UnidadesPermitidas = isnull(op.UnidadesPermitidas, 0)
FROM ShowRoom.OfertaShowRoom op 
inner join ods.campania ca ON ca.campaniaid = op.campaniaid
WHERE 
	op.tipoOfertaSisID = 1707
	AND op.CUV = @CUVPadre
	AND ca.Codigo = @CampaniaID

select isnull(@UnidadesPermitidas,0)

end


GO

