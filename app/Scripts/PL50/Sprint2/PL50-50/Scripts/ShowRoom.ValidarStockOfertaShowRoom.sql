
GO
USE BelcorpPeru
GO

IF (OBJECT_ID('ShowRoom.ValidarStockOfertaShowRoom', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.ValidarStockOfertaShowRoom AS SET NOCOUNT ON;')
GO

--
ALTER PROCEDURE ShowRoom.ValidarStockOfertaShowRoom @CampaniaID INT
	,@CUV VARCHAR(20)
AS
/*
ShowRoom.ValidarStockOfertaShowRoom 201607,'99001'
*/
BEGIN
	SELECT isnull(Cantidad, 0) AS Stock
	FROM dbo.Estrategia e
	INNER JOIN ods.campania c ON e.CampaniaID = c.Codigo
	INNER JOIN vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE c.codigo = @CampaniaID
		AND e.cuv2 = @CUV
END

GO

USE BelcorpMexico
GO

IF (OBJECT_ID('ShowRoom.ValidarStockOfertaShowRoom', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.ValidarStockOfertaShowRoom AS SET NOCOUNT ON;')
GO

--
ALTER PROCEDURE ShowRoom.ValidarStockOfertaShowRoom @CampaniaID INT
	,@CUV VARCHAR(20)
AS
/*
ShowRoom.ValidarStockOfertaShowRoom 201607,'99001'
*/
BEGIN
	SELECT isnull(Cantidad, 0) AS Stock
	FROM dbo.Estrategia e
	INNER JOIN ods.campania c ON e.CampaniaID = c.Codigo
	INNER JOIN vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE c.codigo = @CampaniaID
		AND e.cuv2 = @CUV
END

GO

USE BelcorpColombia
GO

IF (OBJECT_ID('ShowRoom.ValidarStockOfertaShowRoom', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.ValidarStockOfertaShowRoom AS SET NOCOUNT ON;')
GO

--
ALTER PROCEDURE ShowRoom.ValidarStockOfertaShowRoom @CampaniaID INT
	,@CUV VARCHAR(20)
AS
/*
ShowRoom.ValidarStockOfertaShowRoom 201607,'99001'
*/
BEGIN
	SELECT isnull(Cantidad, 0) AS Stock
	FROM dbo.Estrategia e
	INNER JOIN ods.campania c ON e.CampaniaID = c.Codigo
	INNER JOIN vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE c.codigo = @CampaniaID
		AND e.cuv2 = @CUV
END

GO

USE BelcorpVenezuela
GO

IF (OBJECT_ID('ShowRoom.ValidarStockOfertaShowRoom', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.ValidarStockOfertaShowRoom AS SET NOCOUNT ON;')
GO

--
ALTER PROCEDURE ShowRoom.ValidarStockOfertaShowRoom @CampaniaID INT
	,@CUV VARCHAR(20)
AS
/*
ShowRoom.ValidarStockOfertaShowRoom 201607,'99001'
*/
BEGIN
	SELECT isnull(Cantidad, 0) AS Stock
	FROM dbo.Estrategia e
	INNER JOIN ods.campania c ON e.CampaniaID = c.Codigo
	INNER JOIN vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE c.codigo = @CampaniaID
		AND e.cuv2 = @CUV
END

GO

USE BelcorpSalvador
GO

IF (OBJECT_ID('ShowRoom.ValidarStockOfertaShowRoom', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.ValidarStockOfertaShowRoom AS SET NOCOUNT ON;')
GO

--
ALTER PROCEDURE ShowRoom.ValidarStockOfertaShowRoom @CampaniaID INT
	,@CUV VARCHAR(20)
AS
/*
ShowRoom.ValidarStockOfertaShowRoom 201607,'99001'
*/
BEGIN
	SELECT isnull(Cantidad, 0) AS Stock
	FROM dbo.Estrategia e
	INNER JOIN ods.campania c ON e.CampaniaID = c.Codigo
	INNER JOIN vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE c.codigo = @CampaniaID
		AND e.cuv2 = @CUV
END

GO

USE BelcorpPuertoRico
GO

IF (OBJECT_ID('ShowRoom.ValidarStockOfertaShowRoom', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.ValidarStockOfertaShowRoom AS SET NOCOUNT ON;')
GO

--
ALTER PROCEDURE ShowRoom.ValidarStockOfertaShowRoom @CampaniaID INT
	,@CUV VARCHAR(20)
AS
/*
ShowRoom.ValidarStockOfertaShowRoom 201607,'99001'
*/
BEGIN
	SELECT isnull(Cantidad, 0) AS Stock
	FROM dbo.Estrategia e
	INNER JOIN ods.campania c ON e.CampaniaID = c.Codigo
	INNER JOIN vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE c.codigo = @CampaniaID
		AND e.cuv2 = @CUV
END

GO

USE BelcorpPanama
GO

IF (OBJECT_ID('ShowRoom.ValidarStockOfertaShowRoom', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.ValidarStockOfertaShowRoom AS SET NOCOUNT ON;')
GO

--
ALTER PROCEDURE ShowRoom.ValidarStockOfertaShowRoom @CampaniaID INT
	,@CUV VARCHAR(20)
AS
/*
ShowRoom.ValidarStockOfertaShowRoom 201607,'99001'
*/
BEGIN
	SELECT isnull(Cantidad, 0) AS Stock
	FROM dbo.Estrategia e
	INNER JOIN ods.campania c ON e.CampaniaID = c.Codigo
	INNER JOIN vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE c.codigo = @CampaniaID
		AND e.cuv2 = @CUV
END

GO

USE BelcorpGuatemala
GO

IF (OBJECT_ID('ShowRoom.ValidarStockOfertaShowRoom', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.ValidarStockOfertaShowRoom AS SET NOCOUNT ON;')
GO

--
ALTER PROCEDURE ShowRoom.ValidarStockOfertaShowRoom @CampaniaID INT
	,@CUV VARCHAR(20)
AS
/*
ShowRoom.ValidarStockOfertaShowRoom 201607,'99001'
*/
BEGIN
	SELECT isnull(Cantidad, 0) AS Stock
	FROM dbo.Estrategia e
	INNER JOIN ods.campania c ON e.CampaniaID = c.Codigo
	INNER JOIN vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE c.codigo = @CampaniaID
		AND e.cuv2 = @CUV
END

GO

USE BelcorpEcuador
GO

IF (OBJECT_ID('ShowRoom.ValidarStockOfertaShowRoom', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.ValidarStockOfertaShowRoom AS SET NOCOUNT ON;')
GO

--
ALTER PROCEDURE ShowRoom.ValidarStockOfertaShowRoom @CampaniaID INT
	,@CUV VARCHAR(20)
AS
/*
ShowRoom.ValidarStockOfertaShowRoom 201607,'99001'
*/
BEGIN
	SELECT isnull(Cantidad, 0) AS Stock
	FROM dbo.Estrategia e
	INNER JOIN ods.campania c ON e.CampaniaID = c.Codigo
	INNER JOIN vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE c.codigo = @CampaniaID
		AND e.cuv2 = @CUV
END

GO

USE BelcorpDominicana
GO

IF (OBJECT_ID('ShowRoom.ValidarStockOfertaShowRoom', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.ValidarStockOfertaShowRoom AS SET NOCOUNT ON;')
GO

--
ALTER PROCEDURE ShowRoom.ValidarStockOfertaShowRoom @CampaniaID INT
	,@CUV VARCHAR(20)
AS
/*
ShowRoom.ValidarStockOfertaShowRoom 201607,'99001'
*/
BEGIN
	SELECT isnull(Cantidad, 0) AS Stock
	FROM dbo.Estrategia e
	INNER JOIN ods.campania c ON e.CampaniaID = c.Codigo
	INNER JOIN vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE c.codigo = @CampaniaID
		AND e.cuv2 = @CUV
END

GO

USE BelcorpCostaRica
GO

IF (OBJECT_ID('ShowRoom.ValidarStockOfertaShowRoom', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.ValidarStockOfertaShowRoom AS SET NOCOUNT ON;')
GO

--
ALTER PROCEDURE ShowRoom.ValidarStockOfertaShowRoom @CampaniaID INT
	,@CUV VARCHAR(20)
AS
/*
ShowRoom.ValidarStockOfertaShowRoom 201607,'99001'
*/
BEGIN
	SELECT isnull(Cantidad, 0) AS Stock
	FROM dbo.Estrategia e
	INNER JOIN ods.campania c ON e.CampaniaID = c.Codigo
	INNER JOIN vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE c.codigo = @CampaniaID
		AND e.cuv2 = @CUV
END

GO

USE BelcorpChile
GO

IF (OBJECT_ID('ShowRoom.ValidarStockOfertaShowRoom', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.ValidarStockOfertaShowRoom AS SET NOCOUNT ON;')
GO

--
ALTER PROCEDURE ShowRoom.ValidarStockOfertaShowRoom @CampaniaID INT
	,@CUV VARCHAR(20)
AS
/*
ShowRoom.ValidarStockOfertaShowRoom 201607,'99001'
*/
BEGIN
	SELECT isnull(Cantidad, 0) AS Stock
	FROM dbo.Estrategia e
	INNER JOIN ods.campania c ON e.CampaniaID = c.Codigo
	INNER JOIN vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE c.codigo = @CampaniaID
		AND e.cuv2 = @CUV
END

GO

USE BelcorpBolivia
GO

IF (OBJECT_ID('ShowRoom.ValidarStockOfertaShowRoom', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.ValidarStockOfertaShowRoom AS SET NOCOUNT ON;')
GO

--
ALTER PROCEDURE ShowRoom.ValidarStockOfertaShowRoom @CampaniaID INT
	,@CUV VARCHAR(20)
AS
/*
ShowRoom.ValidarStockOfertaShowRoom 201607,'99001'
*/
BEGIN
	SELECT isnull(Cantidad, 0) AS Stock
	FROM dbo.Estrategia e
	INNER JOIN ods.campania c ON e.CampaniaID = c.Codigo
	INNER JOIN vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE c.codigo = @CampaniaID
		AND e.cuv2 = @CUV
END

