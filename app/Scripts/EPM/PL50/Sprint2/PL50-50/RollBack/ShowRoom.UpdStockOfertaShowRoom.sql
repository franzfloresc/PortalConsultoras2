USE BelcorpPeru
GO

IF (OBJECT_ID('ShowRoom.UpdStockOfertaShowRoom', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.UpdStockOfertaShowRoom AS SET NOCOUNT ON;')
GO
--
ALTER procedure ShowRoom.UpdStockOfertaShowRoom
@TipoOfertaSisID int,
@CampaniaID int,
@CUV varchar(20),
@Stock int
as
begin

DECLARE @CUVPadre VARCHAR(10)
	SET @CUVPadre = @CUV

	UPDATE ShowRoom.OfertaShowRoom
			SET Stock -= @Stock
		FROM ShowRoom.OfertaShowRoom o
		INNER JOIN ods.campania c
			 on c.CampaniaID = o.CampaniaID
		WHERE 
			c.Codigo = @CampaniaID
			AND o.CUV = @CUVPadre
			AND o.TipoOfertaSisID = @TipoOfertaSisID

end


GO

USE BelcorpMexico
GO

IF (OBJECT_ID('ShowRoom.UpdStockOfertaShowRoom', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.UpdStockOfertaShowRoom AS SET NOCOUNT ON;')
GO
--
ALTER procedure ShowRoom.UpdStockOfertaShowRoom
@TipoOfertaSisID int,
@CampaniaID int,
@CUV varchar(20),
@Stock int
as
begin

DECLARE @CUVPadre VARCHAR(10)
	SET @CUVPadre = @CUV

	UPDATE ShowRoom.OfertaShowRoom
			SET Stock -= @Stock
		FROM ShowRoom.OfertaShowRoom o
		INNER JOIN ods.campania c
			 on c.CampaniaID = o.CampaniaID
		WHERE 
			c.Codigo = @CampaniaID
			AND o.CUV = @CUVPadre
			AND o.TipoOfertaSisID = @TipoOfertaSisID

end


GO

USE BelcorpColombia
GO

IF (OBJECT_ID('ShowRoom.UpdStockOfertaShowRoom', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.UpdStockOfertaShowRoom AS SET NOCOUNT ON;')
GO
--
ALTER procedure ShowRoom.UpdStockOfertaShowRoom
@TipoOfertaSisID int,
@CampaniaID int,
@CUV varchar(20),
@Stock int
as
begin

DECLARE @CUVPadre VARCHAR(10)
	SET @CUVPadre = @CUV

	UPDATE ShowRoom.OfertaShowRoom
			SET Stock -= @Stock
		FROM ShowRoom.OfertaShowRoom o
		INNER JOIN ods.campania c
			 on c.CampaniaID = o.CampaniaID
		WHERE 
			c.Codigo = @CampaniaID
			AND o.CUV = @CUVPadre
			AND o.TipoOfertaSisID = @TipoOfertaSisID

end


GO

USE BelcorpVenezuela
GO

IF (OBJECT_ID('ShowRoom.UpdStockOfertaShowRoom', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.UpdStockOfertaShowRoom AS SET NOCOUNT ON;')
GO
--
ALTER procedure ShowRoom.UpdStockOfertaShowRoom
@TipoOfertaSisID int,
@CampaniaID int,
@CUV varchar(20),
@Stock int
as
begin

DECLARE @CUVPadre VARCHAR(10)
	SET @CUVPadre = @CUV

	UPDATE ShowRoom.OfertaShowRoom
			SET Stock -= @Stock
		FROM ShowRoom.OfertaShowRoom o
		INNER JOIN ods.campania c
			 on c.CampaniaID = o.CampaniaID
		WHERE 
			c.Codigo = @CampaniaID
			AND o.CUV = @CUVPadre
			AND o.TipoOfertaSisID = @TipoOfertaSisID

end


GO

USE BelcorpSalvador
GO

IF (OBJECT_ID('ShowRoom.UpdStockOfertaShowRoom', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.UpdStockOfertaShowRoom AS SET NOCOUNT ON;')
GO
--
ALTER procedure ShowRoom.UpdStockOfertaShowRoom
@TipoOfertaSisID int,
@CampaniaID int,
@CUV varchar(20),
@Stock int
as
begin

DECLARE @CUVPadre VARCHAR(10)
	SET @CUVPadre = @CUV

	UPDATE ShowRoom.OfertaShowRoom
			SET Stock -= @Stock
		FROM ShowRoom.OfertaShowRoom o
		INNER JOIN ods.campania c
			 on c.CampaniaID = o.CampaniaID
		WHERE 
			c.Codigo = @CampaniaID
			AND o.CUV = @CUVPadre
			AND o.TipoOfertaSisID = @TipoOfertaSisID

end


GO

USE BelcorpPuertoRico
GO

IF (OBJECT_ID('ShowRoom.UpdStockOfertaShowRoom', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.UpdStockOfertaShowRoom AS SET NOCOUNT ON;')
GO
--
ALTER procedure ShowRoom.UpdStockOfertaShowRoom
@TipoOfertaSisID int,
@CampaniaID int,
@CUV varchar(20),
@Stock int
as
begin

DECLARE @CUVPadre VARCHAR(10)
	SET @CUVPadre = @CUV

	UPDATE ShowRoom.OfertaShowRoom
			SET Stock -= @Stock
		FROM ShowRoom.OfertaShowRoom o
		INNER JOIN ods.campania c
			 on c.CampaniaID = o.CampaniaID
		WHERE 
			c.Codigo = @CampaniaID
			AND o.CUV = @CUVPadre
			AND o.TipoOfertaSisID = @TipoOfertaSisID

end


GO

USE BelcorpPanama
GO

IF (OBJECT_ID('ShowRoom.UpdStockOfertaShowRoom', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.UpdStockOfertaShowRoom AS SET NOCOUNT ON;')
GO
--
ALTER procedure ShowRoom.UpdStockOfertaShowRoom
@TipoOfertaSisID int,
@CampaniaID int,
@CUV varchar(20),
@Stock int
as
begin

DECLARE @CUVPadre VARCHAR(10)
	SET @CUVPadre = @CUV

	UPDATE ShowRoom.OfertaShowRoom
			SET Stock -= @Stock
		FROM ShowRoom.OfertaShowRoom o
		INNER JOIN ods.campania c
			 on c.CampaniaID = o.CampaniaID
		WHERE 
			c.Codigo = @CampaniaID
			AND o.CUV = @CUVPadre
			AND o.TipoOfertaSisID = @TipoOfertaSisID

end


GO

USE BelcorpGuatemala
GO

IF (OBJECT_ID('ShowRoom.UpdStockOfertaShowRoom', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.UpdStockOfertaShowRoom AS SET NOCOUNT ON;')
GO
--
ALTER procedure ShowRoom.UpdStockOfertaShowRoom
@TipoOfertaSisID int,
@CampaniaID int,
@CUV varchar(20),
@Stock int
as
begin

DECLARE @CUVPadre VARCHAR(10)
	SET @CUVPadre = @CUV

	UPDATE ShowRoom.OfertaShowRoom
			SET Stock -= @Stock
		FROM ShowRoom.OfertaShowRoom o
		INNER JOIN ods.campania c
			 on c.CampaniaID = o.CampaniaID
		WHERE 
			c.Codigo = @CampaniaID
			AND o.CUV = @CUVPadre
			AND o.TipoOfertaSisID = @TipoOfertaSisID

end


GO

USE BelcorpEcuador
GO

IF (OBJECT_ID('ShowRoom.UpdStockOfertaShowRoom', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.UpdStockOfertaShowRoom AS SET NOCOUNT ON;')
GO
--
ALTER procedure ShowRoom.UpdStockOfertaShowRoom
@TipoOfertaSisID int,
@CampaniaID int,
@CUV varchar(20),
@Stock int
as
begin

DECLARE @CUVPadre VARCHAR(10)
	SET @CUVPadre = @CUV

	UPDATE ShowRoom.OfertaShowRoom
			SET Stock -= @Stock
		FROM ShowRoom.OfertaShowRoom o
		INNER JOIN ods.campania c
			 on c.CampaniaID = o.CampaniaID
		WHERE 
			c.Codigo = @CampaniaID
			AND o.CUV = @CUVPadre
			AND o.TipoOfertaSisID = @TipoOfertaSisID

end


GO

USE BelcorpDominicana
GO

IF (OBJECT_ID('ShowRoom.UpdStockOfertaShowRoom', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.UpdStockOfertaShowRoom AS SET NOCOUNT ON;')
GO
--
ALTER procedure ShowRoom.UpdStockOfertaShowRoom
@TipoOfertaSisID int,
@CampaniaID int,
@CUV varchar(20),
@Stock int
as
begin

DECLARE @CUVPadre VARCHAR(10)
	SET @CUVPadre = @CUV

	UPDATE ShowRoom.OfertaShowRoom
			SET Stock -= @Stock
		FROM ShowRoom.OfertaShowRoom o
		INNER JOIN ods.campania c
			 on c.CampaniaID = o.CampaniaID
		WHERE 
			c.Codigo = @CampaniaID
			AND o.CUV = @CUVPadre
			AND o.TipoOfertaSisID = @TipoOfertaSisID

end


GO

USE BelcorpCostaRica
GO

IF (OBJECT_ID('ShowRoom.UpdStockOfertaShowRoom', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.UpdStockOfertaShowRoom AS SET NOCOUNT ON;')
GO
--
ALTER procedure ShowRoom.UpdStockOfertaShowRoom
@TipoOfertaSisID int,
@CampaniaID int,
@CUV varchar(20),
@Stock int
as
begin

DECLARE @CUVPadre VARCHAR(10)
	SET @CUVPadre = @CUV

	UPDATE ShowRoom.OfertaShowRoom
			SET Stock -= @Stock
		FROM ShowRoom.OfertaShowRoom o
		INNER JOIN ods.campania c
			 on c.CampaniaID = o.CampaniaID
		WHERE 
			c.Codigo = @CampaniaID
			AND o.CUV = @CUVPadre
			AND o.TipoOfertaSisID = @TipoOfertaSisID

end


GO

USE BelcorpChile
GO

IF (OBJECT_ID('ShowRoom.UpdStockOfertaShowRoom', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.UpdStockOfertaShowRoom AS SET NOCOUNT ON;')
GO
--
ALTER procedure ShowRoom.UpdStockOfertaShowRoom
@TipoOfertaSisID int,
@CampaniaID int,
@CUV varchar(20),
@Stock int
as
begin

DECLARE @CUVPadre VARCHAR(10)
	SET @CUVPadre = @CUV

	UPDATE ShowRoom.OfertaShowRoom
			SET Stock -= @Stock
		FROM ShowRoom.OfertaShowRoom o
		INNER JOIN ods.campania c
			 on c.CampaniaID = o.CampaniaID
		WHERE 
			c.Codigo = @CampaniaID
			AND o.CUV = @CUVPadre
			AND o.TipoOfertaSisID = @TipoOfertaSisID

end


GO

USE BelcorpBolivia
GO

IF (OBJECT_ID('ShowRoom.UpdStockOfertaShowRoom', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.UpdStockOfertaShowRoom AS SET NOCOUNT ON;')
GO
--
ALTER procedure ShowRoom.UpdStockOfertaShowRoom
@TipoOfertaSisID int,
@CampaniaID int,
@CUV varchar(20),
@Stock int
as
begin

DECLARE @CUVPadre VARCHAR(10)
	SET @CUVPadre = @CUV

	UPDATE ShowRoom.OfertaShowRoom
			SET Stock -= @Stock
		FROM ShowRoom.OfertaShowRoom o
		INNER JOIN ods.campania c
			 on c.CampaniaID = o.CampaniaID
		WHERE 
			c.Codigo = @CampaniaID
			AND o.CUV = @CUVPadre
			AND o.TipoOfertaSisID = @TipoOfertaSisID

end


GO

