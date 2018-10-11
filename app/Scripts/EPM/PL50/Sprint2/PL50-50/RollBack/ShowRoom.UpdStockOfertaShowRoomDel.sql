USE BelcorpPeru
GO

IF (OBJECT_ID('ShowRoom.UpdStockOfertaShowRoomDel', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.UpdStockOfertaShowRoomDel AS SET NOCOUNT ON;')
GO
--
ALTER PROCEDURE ShowRoom.UpdStockOfertaShowRoomDel
	@TipoOfertaSisID int,
	@CampaniaID int,
	@CUV varchar(20),
	@Stock int
AS
BEGIN
	DECLARE @CUVPadre VARCHAR(10)
	SET @CUVPadre = @CUV

	UPDATE ShowRoom.OfertaShowRoom
			SET Stock += @Stock
		FROM ShowRoom.OfertaShowRoom o
		INNER JOIN ods.campania c
			 on c.CampaniaID = o.CampaniaID
		WHERE 
			c.Codigo = @CampaniaID
			AND o.CUV = @CUVPadre
			AND o.TipoOfertaSisID = @TipoOfertaSisID
END


GO

USE BelcorpMexico
GO

IF (OBJECT_ID('ShowRoom.UpdStockOfertaShowRoomDel', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.UpdStockOfertaShowRoomDel AS SET NOCOUNT ON;')
GO
--
ALTER PROCEDURE ShowRoom.UpdStockOfertaShowRoomDel
	@TipoOfertaSisID int,
	@CampaniaID int,
	@CUV varchar(20),
	@Stock int
AS
BEGIN
	DECLARE @CUVPadre VARCHAR(10)
	SET @CUVPadre = @CUV

	UPDATE ShowRoom.OfertaShowRoom
			SET Stock += @Stock
		FROM ShowRoom.OfertaShowRoom o
		INNER JOIN ods.campania c
			 on c.CampaniaID = o.CampaniaID
		WHERE 
			c.Codigo = @CampaniaID
			AND o.CUV = @CUVPadre
			AND o.TipoOfertaSisID = @TipoOfertaSisID
END


GO

USE BelcorpColombia
GO

IF (OBJECT_ID('ShowRoom.UpdStockOfertaShowRoomDel', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.UpdStockOfertaShowRoomDel AS SET NOCOUNT ON;')
GO
--
ALTER PROCEDURE ShowRoom.UpdStockOfertaShowRoomDel
	@TipoOfertaSisID int,
	@CampaniaID int,
	@CUV varchar(20),
	@Stock int
AS
BEGIN
	DECLARE @CUVPadre VARCHAR(10)
	SET @CUVPadre = @CUV

	UPDATE ShowRoom.OfertaShowRoom
			SET Stock += @Stock
		FROM ShowRoom.OfertaShowRoom o
		INNER JOIN ods.campania c
			 on c.CampaniaID = o.CampaniaID
		WHERE 
			c.Codigo = @CampaniaID
			AND o.CUV = @CUVPadre
			AND o.TipoOfertaSisID = @TipoOfertaSisID
END


GO

USE BelcorpVenezuela
GO

IF (OBJECT_ID('ShowRoom.UpdStockOfertaShowRoomDel', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.UpdStockOfertaShowRoomDel AS SET NOCOUNT ON;')
GO
--
ALTER PROCEDURE ShowRoom.UpdStockOfertaShowRoomDel
	@TipoOfertaSisID int,
	@CampaniaID int,
	@CUV varchar(20),
	@Stock int
AS
BEGIN
	DECLARE @CUVPadre VARCHAR(10)
	SET @CUVPadre = @CUV

	UPDATE ShowRoom.OfertaShowRoom
			SET Stock += @Stock
		FROM ShowRoom.OfertaShowRoom o
		INNER JOIN ods.campania c
			 on c.CampaniaID = o.CampaniaID
		WHERE 
			c.Codigo = @CampaniaID
			AND o.CUV = @CUVPadre
			AND o.TipoOfertaSisID = @TipoOfertaSisID
END


GO

USE BelcorpSalvador
GO

IF (OBJECT_ID('ShowRoom.UpdStockOfertaShowRoomDel', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.UpdStockOfertaShowRoomDel AS SET NOCOUNT ON;')
GO
--
ALTER PROCEDURE ShowRoom.UpdStockOfertaShowRoomDel
	@TipoOfertaSisID int,
	@CampaniaID int,
	@CUV varchar(20),
	@Stock int
AS
BEGIN
	DECLARE @CUVPadre VARCHAR(10)
	SET @CUVPadre = @CUV

	UPDATE ShowRoom.OfertaShowRoom
			SET Stock += @Stock
		FROM ShowRoom.OfertaShowRoom o
		INNER JOIN ods.campania c
			 on c.CampaniaID = o.CampaniaID
		WHERE 
			c.Codigo = @CampaniaID
			AND o.CUV = @CUVPadre
			AND o.TipoOfertaSisID = @TipoOfertaSisID
END


GO

USE BelcorpPuertoRico
GO

IF (OBJECT_ID('ShowRoom.UpdStockOfertaShowRoomDel', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.UpdStockOfertaShowRoomDel AS SET NOCOUNT ON;')
GO
--
ALTER PROCEDURE ShowRoom.UpdStockOfertaShowRoomDel
	@TipoOfertaSisID int,
	@CampaniaID int,
	@CUV varchar(20),
	@Stock int
AS
BEGIN
	DECLARE @CUVPadre VARCHAR(10)
	SET @CUVPadre = @CUV

	UPDATE ShowRoom.OfertaShowRoom
			SET Stock += @Stock
		FROM ShowRoom.OfertaShowRoom o
		INNER JOIN ods.campania c
			 on c.CampaniaID = o.CampaniaID
		WHERE 
			c.Codigo = @CampaniaID
			AND o.CUV = @CUVPadre
			AND o.TipoOfertaSisID = @TipoOfertaSisID
END


GO

USE BelcorpPanama
GO

IF (OBJECT_ID('ShowRoom.UpdStockOfertaShowRoomDel', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.UpdStockOfertaShowRoomDel AS SET NOCOUNT ON;')
GO
--
ALTER PROCEDURE ShowRoom.UpdStockOfertaShowRoomDel
	@TipoOfertaSisID int,
	@CampaniaID int,
	@CUV varchar(20),
	@Stock int
AS
BEGIN
	DECLARE @CUVPadre VARCHAR(10)
	SET @CUVPadre = @CUV

	UPDATE ShowRoom.OfertaShowRoom
			SET Stock += @Stock
		FROM ShowRoom.OfertaShowRoom o
		INNER JOIN ods.campania c
			 on c.CampaniaID = o.CampaniaID
		WHERE 
			c.Codigo = @CampaniaID
			AND o.CUV = @CUVPadre
			AND o.TipoOfertaSisID = @TipoOfertaSisID
END


GO

USE BelcorpGuatemala
GO

IF (OBJECT_ID('ShowRoom.UpdStockOfertaShowRoomDel', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.UpdStockOfertaShowRoomDel AS SET NOCOUNT ON;')
GO
--
ALTER PROCEDURE ShowRoom.UpdStockOfertaShowRoomDel
	@TipoOfertaSisID int,
	@CampaniaID int,
	@CUV varchar(20),
	@Stock int
AS
BEGIN
	DECLARE @CUVPadre VARCHAR(10)
	SET @CUVPadre = @CUV

	UPDATE ShowRoom.OfertaShowRoom
			SET Stock += @Stock
		FROM ShowRoom.OfertaShowRoom o
		INNER JOIN ods.campania c
			 on c.CampaniaID = o.CampaniaID
		WHERE 
			c.Codigo = @CampaniaID
			AND o.CUV = @CUVPadre
			AND o.TipoOfertaSisID = @TipoOfertaSisID
END


GO

USE BelcorpEcuador
GO

IF (OBJECT_ID('ShowRoom.UpdStockOfertaShowRoomDel', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.UpdStockOfertaShowRoomDel AS SET NOCOUNT ON;')
GO
--
ALTER PROCEDURE ShowRoom.UpdStockOfertaShowRoomDel
	@TipoOfertaSisID int,
	@CampaniaID int,
	@CUV varchar(20),
	@Stock int
AS
BEGIN
	DECLARE @CUVPadre VARCHAR(10)
	SET @CUVPadre = @CUV

	UPDATE ShowRoom.OfertaShowRoom
			SET Stock += @Stock
		FROM ShowRoom.OfertaShowRoom o
		INNER JOIN ods.campania c
			 on c.CampaniaID = o.CampaniaID
		WHERE 
			c.Codigo = @CampaniaID
			AND o.CUV = @CUVPadre
			AND o.TipoOfertaSisID = @TipoOfertaSisID
END


GO

USE BelcorpDominicana
GO

IF (OBJECT_ID('ShowRoom.UpdStockOfertaShowRoomDel', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.UpdStockOfertaShowRoomDel AS SET NOCOUNT ON;')
GO
--
ALTER PROCEDURE ShowRoom.UpdStockOfertaShowRoomDel
	@TipoOfertaSisID int,
	@CampaniaID int,
	@CUV varchar(20),
	@Stock int
AS
BEGIN
	DECLARE @CUVPadre VARCHAR(10)
	SET @CUVPadre = @CUV

	UPDATE ShowRoom.OfertaShowRoom
			SET Stock += @Stock
		FROM ShowRoom.OfertaShowRoom o
		INNER JOIN ods.campania c
			 on c.CampaniaID = o.CampaniaID
		WHERE 
			c.Codigo = @CampaniaID
			AND o.CUV = @CUVPadre
			AND o.TipoOfertaSisID = @TipoOfertaSisID
END


GO

USE BelcorpCostaRica
GO

IF (OBJECT_ID('ShowRoom.UpdStockOfertaShowRoomDel', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.UpdStockOfertaShowRoomDel AS SET NOCOUNT ON;')
GO
--
ALTER PROCEDURE ShowRoom.UpdStockOfertaShowRoomDel
	@TipoOfertaSisID int,
	@CampaniaID int,
	@CUV varchar(20),
	@Stock int
AS
BEGIN
	DECLARE @CUVPadre VARCHAR(10)
	SET @CUVPadre = @CUV

	UPDATE ShowRoom.OfertaShowRoom
			SET Stock += @Stock
		FROM ShowRoom.OfertaShowRoom o
		INNER JOIN ods.campania c
			 on c.CampaniaID = o.CampaniaID
		WHERE 
			c.Codigo = @CampaniaID
			AND o.CUV = @CUVPadre
			AND o.TipoOfertaSisID = @TipoOfertaSisID
END


GO

USE BelcorpChile
GO

IF (OBJECT_ID('ShowRoom.UpdStockOfertaShowRoomDel', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.UpdStockOfertaShowRoomDel AS SET NOCOUNT ON;')
GO
--
ALTER PROCEDURE ShowRoom.UpdStockOfertaShowRoomDel
	@TipoOfertaSisID int,
	@CampaniaID int,
	@CUV varchar(20),
	@Stock int
AS
BEGIN
	DECLARE @CUVPadre VARCHAR(10)
	SET @CUVPadre = @CUV

	UPDATE ShowRoom.OfertaShowRoom
			SET Stock += @Stock
		FROM ShowRoom.OfertaShowRoom o
		INNER JOIN ods.campania c
			 on c.CampaniaID = o.CampaniaID
		WHERE 
			c.Codigo = @CampaniaID
			AND o.CUV = @CUVPadre
			AND o.TipoOfertaSisID = @TipoOfertaSisID
END


GO

USE BelcorpBolivia
GO

IF (OBJECT_ID('ShowRoom.UpdStockOfertaShowRoomDel', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.UpdStockOfertaShowRoomDel AS SET NOCOUNT ON;')
GO
--
ALTER PROCEDURE ShowRoom.UpdStockOfertaShowRoomDel
	@TipoOfertaSisID int,
	@CampaniaID int,
	@CUV varchar(20),
	@Stock int
AS
BEGIN
	DECLARE @CUVPadre VARCHAR(10)
	SET @CUVPadre = @CUV

	UPDATE ShowRoom.OfertaShowRoom
			SET Stock += @Stock
		FROM ShowRoom.OfertaShowRoom o
		INNER JOIN ods.campania c
			 on c.CampaniaID = o.CampaniaID
		WHERE 
			c.Codigo = @CampaniaID
			AND o.CUV = @CUVPadre
			AND o.TipoOfertaSisID = @TipoOfertaSisID
END


GO

