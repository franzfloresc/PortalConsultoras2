USE BelcorpPeru
GO

IF (OBJECT_ID('ShowRoom.ValidarStockOfertaShowRoom', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.ValidarStockOfertaShowRoom AS SET NOCOUNT ON;')
GO

--
ALTER procedure ShowRoom.ValidarStockOfertaShowRoom
@CampaniaID int,
@CUV VARCHAR(20)
as
/*
ShowRoom.ValidarStockOfertaShowRoom 201607,'99001'
*/
begin

DECLARE @CUVPadre VARCHAR(10)
SET @CUVPadre = @CUV

SELECT isnull(Stock,0) Stock
FROM ShowRoom.OfertaShowRoom opr 
	inner join ods.Campania c on 
	opr.CampaniaID = c.CampaniaID
WHERE c.codigo = @CampaniaID
		and opr.cuv = @CUVPadre
		-- and opr.FlagHabilitarProducto = 1

end


GO

USE BelcorpMexico
GO

IF (OBJECT_ID('ShowRoom.ValidarStockOfertaShowRoom', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.ValidarStockOfertaShowRoom AS SET NOCOUNT ON;')
GO

--
ALTER procedure ShowRoom.ValidarStockOfertaShowRoom
@CampaniaID int,
@CUV VARCHAR(20)
as
/*
ShowRoom.ValidarStockOfertaShowRoom 201607,'99001'
*/
begin

DECLARE @CUVPadre VARCHAR(10)
SET @CUVPadre = @CUV

SELECT isnull(Stock,0) Stock
FROM ShowRoom.OfertaShowRoom opr 
	inner join ods.Campania c on 
	opr.CampaniaID = c.CampaniaID
WHERE c.codigo = @CampaniaID
		and opr.cuv = @CUVPadre
		-- and opr.FlagHabilitarProducto = 1

end


GO

USE BelcorpColombia
GO

IF (OBJECT_ID('ShowRoom.ValidarStockOfertaShowRoom', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.ValidarStockOfertaShowRoom AS SET NOCOUNT ON;')
GO

--
ALTER procedure ShowRoom.ValidarStockOfertaShowRoom
@CampaniaID int,
@CUV VARCHAR(20)
as
/*
ShowRoom.ValidarStockOfertaShowRoom 201607,'99001'
*/
begin

DECLARE @CUVPadre VARCHAR(10)
SET @CUVPadre = @CUV

SELECT isnull(Stock,0) Stock
FROM ShowRoom.OfertaShowRoom opr 
	inner join ods.Campania c on 
	opr.CampaniaID = c.CampaniaID
WHERE c.codigo = @CampaniaID
		and opr.cuv = @CUVPadre
		-- and opr.FlagHabilitarProducto = 1

end


GO

USE BelcorpVenezuela
GO

IF (OBJECT_ID('ShowRoom.ValidarStockOfertaShowRoom', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.ValidarStockOfertaShowRoom AS SET NOCOUNT ON;')
GO

--
ALTER procedure ShowRoom.ValidarStockOfertaShowRoom
@CampaniaID int,
@CUV VARCHAR(20)
as
/*
ShowRoom.ValidarStockOfertaShowRoom 201607,'99001'
*/
begin

DECLARE @CUVPadre VARCHAR(10)
SET @CUVPadre = @CUV

SELECT isnull(Stock,0) Stock
FROM ShowRoom.OfertaShowRoom opr 
	inner join ods.Campania c on 
	opr.CampaniaID = c.CampaniaID
WHERE c.codigo = @CampaniaID
		and opr.cuv = @CUVPadre
		-- and opr.FlagHabilitarProducto = 1

end


GO

USE BelcorpSalvador
GO

IF (OBJECT_ID('ShowRoom.ValidarStockOfertaShowRoom', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.ValidarStockOfertaShowRoom AS SET NOCOUNT ON;')
GO

--
ALTER procedure ShowRoom.ValidarStockOfertaShowRoom
@CampaniaID int,
@CUV VARCHAR(20)
as
/*
ShowRoom.ValidarStockOfertaShowRoom 201607,'99001'
*/
begin

DECLARE @CUVPadre VARCHAR(10)
SET @CUVPadre = @CUV

SELECT isnull(Stock,0) Stock
FROM ShowRoom.OfertaShowRoom opr 
	inner join ods.Campania c on 
	opr.CampaniaID = c.CampaniaID
WHERE c.codigo = @CampaniaID
		and opr.cuv = @CUVPadre
		-- and opr.FlagHabilitarProducto = 1

end


GO

USE BelcorpPuertoRico
GO

IF (OBJECT_ID('ShowRoom.ValidarStockOfertaShowRoom', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.ValidarStockOfertaShowRoom AS SET NOCOUNT ON;')
GO

--
ALTER procedure ShowRoom.ValidarStockOfertaShowRoom
@CampaniaID int,
@CUV VARCHAR(20)
as
/*
ShowRoom.ValidarStockOfertaShowRoom 201607,'99001'
*/
begin

DECLARE @CUVPadre VARCHAR(10)
SET @CUVPadre = @CUV

SELECT isnull(Stock,0) Stock
FROM ShowRoom.OfertaShowRoom opr 
	inner join ods.Campania c on 
	opr.CampaniaID = c.CampaniaID
WHERE c.codigo = @CampaniaID
		and opr.cuv = @CUVPadre
		-- and opr.FlagHabilitarProducto = 1

end


GO

USE BelcorpPanama
GO

IF (OBJECT_ID('ShowRoom.ValidarStockOfertaShowRoom', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.ValidarStockOfertaShowRoom AS SET NOCOUNT ON;')
GO

--
ALTER procedure ShowRoom.ValidarStockOfertaShowRoom
@CampaniaID int,
@CUV VARCHAR(20)
as
/*
ShowRoom.ValidarStockOfertaShowRoom 201607,'99001'
*/
begin

DECLARE @CUVPadre VARCHAR(10)
SET @CUVPadre = @CUV

SELECT isnull(Stock,0) Stock
FROM ShowRoom.OfertaShowRoom opr 
	inner join ods.Campania c on 
	opr.CampaniaID = c.CampaniaID
WHERE c.codigo = @CampaniaID
		and opr.cuv = @CUVPadre
		-- and opr.FlagHabilitarProducto = 1

end


GO

USE BelcorpGuatemala
GO

IF (OBJECT_ID('ShowRoom.ValidarStockOfertaShowRoom', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.ValidarStockOfertaShowRoom AS SET NOCOUNT ON;')
GO

--
ALTER procedure ShowRoom.ValidarStockOfertaShowRoom
@CampaniaID int,
@CUV VARCHAR(20)
as
/*
ShowRoom.ValidarStockOfertaShowRoom 201607,'99001'
*/
begin

DECLARE @CUVPadre VARCHAR(10)
SET @CUVPadre = @CUV

SELECT isnull(Stock,0) Stock
FROM ShowRoom.OfertaShowRoom opr 
	inner join ods.Campania c on 
	opr.CampaniaID = c.CampaniaID
WHERE c.codigo = @CampaniaID
		and opr.cuv = @CUVPadre
		-- and opr.FlagHabilitarProducto = 1

end


GO

USE BelcorpEcuador
GO

IF (OBJECT_ID('ShowRoom.ValidarStockOfertaShowRoom', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.ValidarStockOfertaShowRoom AS SET NOCOUNT ON;')
GO

--
ALTER procedure ShowRoom.ValidarStockOfertaShowRoom
@CampaniaID int,
@CUV VARCHAR(20)
as
/*
ShowRoom.ValidarStockOfertaShowRoom 201607,'99001'
*/
begin

DECLARE @CUVPadre VARCHAR(10)
SET @CUVPadre = @CUV

SELECT isnull(Stock,0) Stock
FROM ShowRoom.OfertaShowRoom opr 
	inner join ods.Campania c on 
	opr.CampaniaID = c.CampaniaID
WHERE c.codigo = @CampaniaID
		and opr.cuv = @CUVPadre
		-- and opr.FlagHabilitarProducto = 1

end


GO

USE BelcorpDominicana
GO

IF (OBJECT_ID('ShowRoom.ValidarStockOfertaShowRoom', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.ValidarStockOfertaShowRoom AS SET NOCOUNT ON;')
GO

--
ALTER procedure ShowRoom.ValidarStockOfertaShowRoom
@CampaniaID int,
@CUV VARCHAR(20)
as
/*
ShowRoom.ValidarStockOfertaShowRoom 201607,'99001'
*/
begin

DECLARE @CUVPadre VARCHAR(10)
SET @CUVPadre = @CUV

SELECT isnull(Stock,0) Stock
FROM ShowRoom.OfertaShowRoom opr 
	inner join ods.Campania c on 
	opr.CampaniaID = c.CampaniaID
WHERE c.codigo = @CampaniaID
		and opr.cuv = @CUVPadre
		-- and opr.FlagHabilitarProducto = 1

end


GO

USE BelcorpCostaRica
GO

IF (OBJECT_ID('ShowRoom.ValidarStockOfertaShowRoom', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.ValidarStockOfertaShowRoom AS SET NOCOUNT ON;')
GO

--
ALTER procedure ShowRoom.ValidarStockOfertaShowRoom
@CampaniaID int,
@CUV VARCHAR(20)
as
/*
ShowRoom.ValidarStockOfertaShowRoom 201607,'99001'
*/
begin

DECLARE @CUVPadre VARCHAR(10)
SET @CUVPadre = @CUV

SELECT isnull(Stock,0) Stock
FROM ShowRoom.OfertaShowRoom opr 
	inner join ods.Campania c on 
	opr.CampaniaID = c.CampaniaID
WHERE c.codigo = @CampaniaID
		and opr.cuv = @CUVPadre
		-- and opr.FlagHabilitarProducto = 1

end


GO

USE BelcorpChile
GO

IF (OBJECT_ID('ShowRoom.ValidarStockOfertaShowRoom', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.ValidarStockOfertaShowRoom AS SET NOCOUNT ON;')
GO

--
ALTER procedure ShowRoom.ValidarStockOfertaShowRoom
@CampaniaID int,
@CUV VARCHAR(20)
as
/*
ShowRoom.ValidarStockOfertaShowRoom 201607,'99001'
*/
begin

DECLARE @CUVPadre VARCHAR(10)
SET @CUVPadre = @CUV

SELECT isnull(Stock,0) Stock
FROM ShowRoom.OfertaShowRoom opr 
	inner join ods.Campania c on 
	opr.CampaniaID = c.CampaniaID
WHERE c.codigo = @CampaniaID
		and opr.cuv = @CUVPadre
		-- and opr.FlagHabilitarProducto = 1

end


GO

USE BelcorpBolivia
GO

IF (OBJECT_ID('ShowRoom.ValidarStockOfertaShowRoom', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.ValidarStockOfertaShowRoom AS SET NOCOUNT ON;')
GO

--
ALTER procedure ShowRoom.ValidarStockOfertaShowRoom
@CampaniaID int,
@CUV VARCHAR(20)
as
/*
ShowRoom.ValidarStockOfertaShowRoom 201607,'99001'
*/
begin

DECLARE @CUVPadre VARCHAR(10)
SET @CUVPadre = @CUV

SELECT isnull(Stock,0) Stock
FROM ShowRoom.OfertaShowRoom opr 
	inner join ods.Campania c on 
	opr.CampaniaID = c.CampaniaID
WHERE c.codigo = @CampaniaID
		and opr.cuv = @CUVPadre
		-- and opr.FlagHabilitarProducto = 1

end


GO

