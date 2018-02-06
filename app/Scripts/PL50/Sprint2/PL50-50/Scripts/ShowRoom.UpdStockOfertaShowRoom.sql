
GO

USE BelcorpPeru
GO

IF (OBJECT_ID('ShowRoom.UpdStockOfertaShowRoom', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.UpdStockOfertaShowRoom AS SET NOCOUNT ON;')
GO
--
ALTER PROCEDURE ShowRoom.UpdStockOfertaShowRoom 
	@CampaniaID INT
	,@CUV VARCHAR(20)
	,@Stock INT
AS
BEGIN
	DECLARE @CUVPadre VARCHAR(10)

	SET @CUVPadre = @CUV

	UPDATE dbo.Estrategia
	SET Cantidad -= @Stock
	FROM dbo.Estrategia e
	INNER JOIN ods.campania c ON  e.CampaniaID = c.Codigo
	INNER JOIN vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE c.Codigo = @CampaniaID
		AND e.CUV2 = @CUVPadre
END

USE BelcorpMexico
GO

IF (OBJECT_ID('ShowRoom.UpdStockOfertaShowRoom', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.UpdStockOfertaShowRoom AS SET NOCOUNT ON;')
GO
--
ALTER PROCEDURE ShowRoom.UpdStockOfertaShowRoom 
	@CampaniaID INT
	,@CUV VARCHAR(20)
	,@Stock INT
AS
BEGIN
	DECLARE @CUVPadre VARCHAR(10)

	SET @CUVPadre = @CUV

	UPDATE dbo.Estrategia
	SET Cantidad -= @Stock
	FROM dbo.Estrategia e
	INNER JOIN ods.campania c ON  e.CampaniaID = c.Codigo
	INNER JOIN vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE c.Codigo = @CampaniaID
		AND e.CUV2 = @CUVPadre
END

USE BelcorpColombia
GO

IF (OBJECT_ID('ShowRoom.UpdStockOfertaShowRoom', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.UpdStockOfertaShowRoom AS SET NOCOUNT ON;')
GO
--
ALTER PROCEDURE ShowRoom.UpdStockOfertaShowRoom 
	@CampaniaID INT
	,@CUV VARCHAR(20)
	,@Stock INT
AS
BEGIN
	DECLARE @CUVPadre VARCHAR(10)

	SET @CUVPadre = @CUV

	UPDATE dbo.Estrategia
	SET Cantidad -= @Stock
	FROM dbo.Estrategia e
	INNER JOIN ods.campania c ON  e.CampaniaID = c.Codigo
	INNER JOIN vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE c.Codigo = @CampaniaID
		AND e.CUV2 = @CUVPadre
END

USE BelcorpVenezuela
GO

IF (OBJECT_ID('ShowRoom.UpdStockOfertaShowRoom', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.UpdStockOfertaShowRoom AS SET NOCOUNT ON;')
GO
--
ALTER PROCEDURE ShowRoom.UpdStockOfertaShowRoom 
	@CampaniaID INT
	,@CUV VARCHAR(20)
	,@Stock INT
AS
BEGIN
	DECLARE @CUVPadre VARCHAR(10)

	SET @CUVPadre = @CUV

	UPDATE dbo.Estrategia
	SET Cantidad -= @Stock
	FROM dbo.Estrategia e
	INNER JOIN ods.campania c ON  e.CampaniaID = c.Codigo
	INNER JOIN vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE c.Codigo = @CampaniaID
		AND e.CUV2 = @CUVPadre
END

USE BelcorpSalvador
GO

IF (OBJECT_ID('ShowRoom.UpdStockOfertaShowRoom', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.UpdStockOfertaShowRoom AS SET NOCOUNT ON;')
GO
--
ALTER PROCEDURE ShowRoom.UpdStockOfertaShowRoom 
	@CampaniaID INT
	,@CUV VARCHAR(20)
	,@Stock INT
AS
BEGIN
	DECLARE @CUVPadre VARCHAR(10)

	SET @CUVPadre = @CUV

	UPDATE dbo.Estrategia
	SET Cantidad -= @Stock
	FROM dbo.Estrategia e
	INNER JOIN ods.campania c ON  e.CampaniaID = c.Codigo
	INNER JOIN vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE c.Codigo = @CampaniaID
		AND e.CUV2 = @CUVPadre
END

USE BelcorpPuertoRico
GO

IF (OBJECT_ID('ShowRoom.UpdStockOfertaShowRoom', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.UpdStockOfertaShowRoom AS SET NOCOUNT ON;')
GO
--
ALTER PROCEDURE ShowRoom.UpdStockOfertaShowRoom 
	@CampaniaID INT
	,@CUV VARCHAR(20)
	,@Stock INT
AS
BEGIN
	DECLARE @CUVPadre VARCHAR(10)

	SET @CUVPadre = @CUV

	UPDATE dbo.Estrategia
	SET Cantidad -= @Stock
	FROM dbo.Estrategia e
	INNER JOIN ods.campania c ON  e.CampaniaID = c.Codigo
	INNER JOIN vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE c.Codigo = @CampaniaID
		AND e.CUV2 = @CUVPadre
END

USE BelcorpPanama
GO

IF (OBJECT_ID('ShowRoom.UpdStockOfertaShowRoom', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.UpdStockOfertaShowRoom AS SET NOCOUNT ON;')
GO
--
ALTER PROCEDURE ShowRoom.UpdStockOfertaShowRoom 
	@CampaniaID INT
	,@CUV VARCHAR(20)
	,@Stock INT
AS
BEGIN
	DECLARE @CUVPadre VARCHAR(10)

	SET @CUVPadre = @CUV

	UPDATE dbo.Estrategia
	SET Cantidad -= @Stock
	FROM dbo.Estrategia e
	INNER JOIN ods.campania c ON  e.CampaniaID = c.Codigo
	INNER JOIN vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE c.Codigo = @CampaniaID
		AND e.CUV2 = @CUVPadre
END

USE BelcorpGuatemala
GO

IF (OBJECT_ID('ShowRoom.UpdStockOfertaShowRoom', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.UpdStockOfertaShowRoom AS SET NOCOUNT ON;')
GO
--
ALTER PROCEDURE ShowRoom.UpdStockOfertaShowRoom 
	@CampaniaID INT
	,@CUV VARCHAR(20)
	,@Stock INT
AS
BEGIN
	DECLARE @CUVPadre VARCHAR(10)

	SET @CUVPadre = @CUV

	UPDATE dbo.Estrategia
	SET Cantidad -= @Stock
	FROM dbo.Estrategia e
	INNER JOIN ods.campania c ON  e.CampaniaID = c.Codigo
	INNER JOIN vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE c.Codigo = @CampaniaID
		AND e.CUV2 = @CUVPadre
END

USE BelcorpEcuador
GO

IF (OBJECT_ID('ShowRoom.UpdStockOfertaShowRoom', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.UpdStockOfertaShowRoom AS SET NOCOUNT ON;')
GO
--
ALTER PROCEDURE ShowRoom.UpdStockOfertaShowRoom 
	@CampaniaID INT
	,@CUV VARCHAR(20)
	,@Stock INT
AS
BEGIN
	DECLARE @CUVPadre VARCHAR(10)

	SET @CUVPadre = @CUV

	UPDATE dbo.Estrategia
	SET Cantidad -= @Stock
	FROM dbo.Estrategia e
	INNER JOIN ods.campania c ON  e.CampaniaID = c.Codigo
	INNER JOIN vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE c.Codigo = @CampaniaID
		AND e.CUV2 = @CUVPadre
END

USE BelcorpDominicana
GO

IF (OBJECT_ID('ShowRoom.UpdStockOfertaShowRoom', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.UpdStockOfertaShowRoom AS SET NOCOUNT ON;')
GO
--
ALTER PROCEDURE ShowRoom.UpdStockOfertaShowRoom 
	@CampaniaID INT
	,@CUV VARCHAR(20)
	,@Stock INT
AS
BEGIN
	DECLARE @CUVPadre VARCHAR(10)

	SET @CUVPadre = @CUV

	UPDATE dbo.Estrategia
	SET Cantidad -= @Stock
	FROM dbo.Estrategia e
	INNER JOIN ods.campania c ON  e.CampaniaID = c.Codigo
	INNER JOIN vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE c.Codigo = @CampaniaID
		AND e.CUV2 = @CUVPadre
END

USE BelcorpCostaRica
GO

IF (OBJECT_ID('ShowRoom.UpdStockOfertaShowRoom', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.UpdStockOfertaShowRoom AS SET NOCOUNT ON;')
GO
--
ALTER PROCEDURE ShowRoom.UpdStockOfertaShowRoom 
	@CampaniaID INT
	,@CUV VARCHAR(20)
	,@Stock INT
AS
BEGIN
	DECLARE @CUVPadre VARCHAR(10)

	SET @CUVPadre = @CUV

	UPDATE dbo.Estrategia
	SET Cantidad -= @Stock
	FROM dbo.Estrategia e
	INNER JOIN ods.campania c ON  e.CampaniaID = c.Codigo
	INNER JOIN vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE c.Codigo = @CampaniaID
		AND e.CUV2 = @CUVPadre
END

USE BelcorpChile
GO

IF (OBJECT_ID('ShowRoom.UpdStockOfertaShowRoom', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.UpdStockOfertaShowRoom AS SET NOCOUNT ON;')
GO
--
ALTER PROCEDURE ShowRoom.UpdStockOfertaShowRoom 
	@CampaniaID INT
	,@CUV VARCHAR(20)
	,@Stock INT
AS
BEGIN
	DECLARE @CUVPadre VARCHAR(10)

	SET @CUVPadre = @CUV

	UPDATE dbo.Estrategia
	SET Cantidad -= @Stock
	FROM dbo.Estrategia e
	INNER JOIN ods.campania c ON  e.CampaniaID = c.Codigo
	INNER JOIN vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE c.Codigo = @CampaniaID
		AND e.CUV2 = @CUVPadre
END

USE BelcorpBolivia
GO

IF (OBJECT_ID('ShowRoom.UpdStockOfertaShowRoom', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.UpdStockOfertaShowRoom AS SET NOCOUNT ON;')
GO
--
ALTER PROCEDURE ShowRoom.UpdStockOfertaShowRoom 
	@CampaniaID INT
	,@CUV VARCHAR(20)
	,@Stock INT
AS
BEGIN
	DECLARE @CUVPadre VARCHAR(10)

	SET @CUVPadre = @CUV

	UPDATE dbo.Estrategia
	SET Cantidad -= @Stock
	FROM dbo.Estrategia e
	INNER JOIN ods.campania c ON  e.CampaniaID = c.Codigo
	INNER JOIN vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE c.Codigo = @CampaniaID
		AND e.CUV2 = @CUVPadre
END

