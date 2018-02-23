--todos iguales
GO
USE BelcorpPeru
GO

IF (OBJECT_ID('ShowRoom.UpdStockOfertaShowRoomUpd', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.UpdStockOfertaShowRoomUpd AS SET NOCOUNT ON;')
GO

--
ALTER PROCEDURE ShowRoom.UpdStockOfertaShowRoomUpd 
	@CampaniaID INT
	,@CUV VARCHAR(20)
	,@Stock INT
	,@Flag INT
AS
BEGIN
	DECLARE @CUVPadre VARCHAR(10)

	SET @CUVPadre = @CUV

	IF @Flag = 1
	BEGIN
		--- Si la cantidad ingresada es mayor a la anterior
		UPDATE dbo.Estrategia
		SET Cantidad += @Stock
		FROM dbo.Estrategia e
		INNER JOIN ods.campania c ON  e.CampaniaID = c.Codigo
		INNER JOIN vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
		WHERE c.Codigo = @CampaniaID
			AND e.CUV2 = @CUVPadre
	END
	ELSE
	BEGIN
		--- Si la cantidad anterior es mayor a la cantidad ingresada
		UPDATE dbo.Estrategia
		SET Cantidad -= @Stock
		FROM dbo.Estrategia e
		INNER JOIN ods.campania c ON  e.CampaniaID = c.Codigo
		INNER JOIN vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
		WHERE c.Codigo = @CampaniaID
			AND e.CUV2 = @CUVPadre
			
	END
END

GO

USE BelcorpMexico
GO

IF (OBJECT_ID('ShowRoom.UpdStockOfertaShowRoomUpd', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.UpdStockOfertaShowRoomUpd AS SET NOCOUNT ON;')
GO

--
ALTER PROCEDURE ShowRoom.UpdStockOfertaShowRoomUpd 
	@CampaniaID INT
	,@CUV VARCHAR(20)
	,@Stock INT
	,@Flag INT
AS
BEGIN
	DECLARE @CUVPadre VARCHAR(10)

	SET @CUVPadre = @CUV

	IF @Flag = 1
	BEGIN
		--- Si la cantidad ingresada es mayor a la anterior
		UPDATE dbo.Estrategia
		SET Cantidad += @Stock
		FROM dbo.Estrategia e
		INNER JOIN ods.campania c ON  e.CampaniaID = c.Codigo
		INNER JOIN vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
		WHERE c.Codigo = @CampaniaID
			AND e.CUV2 = @CUVPadre
	END
	ELSE
	BEGIN
		--- Si la cantidad anterior es mayor a la cantidad ingresada
		UPDATE dbo.Estrategia
		SET Cantidad -= @Stock
		FROM dbo.Estrategia e
		INNER JOIN ods.campania c ON  e.CampaniaID = c.Codigo
		INNER JOIN vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
		WHERE c.Codigo = @CampaniaID
			AND e.CUV2 = @CUVPadre
			
	END
END

GO

USE BelcorpColombia
GO

IF (OBJECT_ID('ShowRoom.UpdStockOfertaShowRoomUpd', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.UpdStockOfertaShowRoomUpd AS SET NOCOUNT ON;')
GO

--
ALTER PROCEDURE ShowRoom.UpdStockOfertaShowRoomUpd 
	@CampaniaID INT
	,@CUV VARCHAR(20)
	,@Stock INT
	,@Flag INT
AS
BEGIN
	DECLARE @CUVPadre VARCHAR(10)

	SET @CUVPadre = @CUV

	IF @Flag = 1
	BEGIN
		--- Si la cantidad ingresada es mayor a la anterior
		UPDATE dbo.Estrategia
		SET Cantidad += @Stock
		FROM dbo.Estrategia e
		INNER JOIN ods.campania c ON  e.CampaniaID = c.Codigo
		INNER JOIN vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
		WHERE c.Codigo = @CampaniaID
			AND e.CUV2 = @CUVPadre
	END
	ELSE
	BEGIN
		--- Si la cantidad anterior es mayor a la cantidad ingresada
		UPDATE dbo.Estrategia
		SET Cantidad -= @Stock
		FROM dbo.Estrategia e
		INNER JOIN ods.campania c ON  e.CampaniaID = c.Codigo
		INNER JOIN vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
		WHERE c.Codigo = @CampaniaID
			AND e.CUV2 = @CUVPadre
			
	END
END

GO

USE BelcorpVenezuela
GO

IF (OBJECT_ID('ShowRoom.UpdStockOfertaShowRoomUpd', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.UpdStockOfertaShowRoomUpd AS SET NOCOUNT ON;')
GO

--
ALTER PROCEDURE ShowRoom.UpdStockOfertaShowRoomUpd 
	@CampaniaID INT
	,@CUV VARCHAR(20)
	,@Stock INT
	,@Flag INT
AS
BEGIN
	DECLARE @CUVPadre VARCHAR(10)

	SET @CUVPadre = @CUV

	IF @Flag = 1
	BEGIN
		--- Si la cantidad ingresada es mayor a la anterior
		UPDATE dbo.Estrategia
		SET Cantidad += @Stock
		FROM dbo.Estrategia e
		INNER JOIN ods.campania c ON  e.CampaniaID = c.Codigo
		INNER JOIN vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
		WHERE c.Codigo = @CampaniaID
			AND e.CUV2 = @CUVPadre
	END
	ELSE
	BEGIN
		--- Si la cantidad anterior es mayor a la cantidad ingresada
		UPDATE dbo.Estrategia
		SET Cantidad -= @Stock
		FROM dbo.Estrategia e
		INNER JOIN ods.campania c ON  e.CampaniaID = c.Codigo
		INNER JOIN vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
		WHERE c.Codigo = @CampaniaID
			AND e.CUV2 = @CUVPadre
			
	END
END

GO

USE BelcorpSalvador
GO

IF (OBJECT_ID('ShowRoom.UpdStockOfertaShowRoomUpd', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.UpdStockOfertaShowRoomUpd AS SET NOCOUNT ON;')
GO

--
ALTER PROCEDURE ShowRoom.UpdStockOfertaShowRoomUpd 
	@CampaniaID INT
	,@CUV VARCHAR(20)
	,@Stock INT
	,@Flag INT
AS
BEGIN
	DECLARE @CUVPadre VARCHAR(10)

	SET @CUVPadre = @CUV

	IF @Flag = 1
	BEGIN
		--- Si la cantidad ingresada es mayor a la anterior
		UPDATE dbo.Estrategia
		SET Cantidad += @Stock
		FROM dbo.Estrategia e
		INNER JOIN ods.campania c ON  e.CampaniaID = c.Codigo
		INNER JOIN vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
		WHERE c.Codigo = @CampaniaID
			AND e.CUV2 = @CUVPadre
	END
	ELSE
	BEGIN
		--- Si la cantidad anterior es mayor a la cantidad ingresada
		UPDATE dbo.Estrategia
		SET Cantidad -= @Stock
		FROM dbo.Estrategia e
		INNER JOIN ods.campania c ON  e.CampaniaID = c.Codigo
		INNER JOIN vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
		WHERE c.Codigo = @CampaniaID
			AND e.CUV2 = @CUVPadre
			
	END
END

GO

USE BelcorpPuertoRico
GO

IF (OBJECT_ID('ShowRoom.UpdStockOfertaShowRoomUpd', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.UpdStockOfertaShowRoomUpd AS SET NOCOUNT ON;')
GO

--
ALTER PROCEDURE ShowRoom.UpdStockOfertaShowRoomUpd 
	@CampaniaID INT
	,@CUV VARCHAR(20)
	,@Stock INT
	,@Flag INT
AS
BEGIN
	DECLARE @CUVPadre VARCHAR(10)

	SET @CUVPadre = @CUV

	IF @Flag = 1
	BEGIN
		--- Si la cantidad ingresada es mayor a la anterior
		UPDATE dbo.Estrategia
		SET Cantidad += @Stock
		FROM dbo.Estrategia e
		INNER JOIN ods.campania c ON  e.CampaniaID = c.Codigo
		INNER JOIN vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
		WHERE c.Codigo = @CampaniaID
			AND e.CUV2 = @CUVPadre
	END
	ELSE
	BEGIN
		--- Si la cantidad anterior es mayor a la cantidad ingresada
		UPDATE dbo.Estrategia
		SET Cantidad -= @Stock
		FROM dbo.Estrategia e
		INNER JOIN ods.campania c ON  e.CampaniaID = c.Codigo
		INNER JOIN vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
		WHERE c.Codigo = @CampaniaID
			AND e.CUV2 = @CUVPadre
			
	END
END

GO

USE BelcorpPanama
GO

IF (OBJECT_ID('ShowRoom.UpdStockOfertaShowRoomUpd', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.UpdStockOfertaShowRoomUpd AS SET NOCOUNT ON;')
GO

--
ALTER PROCEDURE ShowRoom.UpdStockOfertaShowRoomUpd 
	@CampaniaID INT
	,@CUV VARCHAR(20)
	,@Stock INT
	,@Flag INT
AS
BEGIN
	DECLARE @CUVPadre VARCHAR(10)

	SET @CUVPadre = @CUV

	IF @Flag = 1
	BEGIN
		--- Si la cantidad ingresada es mayor a la anterior
		UPDATE dbo.Estrategia
		SET Cantidad += @Stock
		FROM dbo.Estrategia e
		INNER JOIN ods.campania c ON  e.CampaniaID = c.Codigo
		INNER JOIN vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
		WHERE c.Codigo = @CampaniaID
			AND e.CUV2 = @CUVPadre
	END
	ELSE
	BEGIN
		--- Si la cantidad anterior es mayor a la cantidad ingresada
		UPDATE dbo.Estrategia
		SET Cantidad -= @Stock
		FROM dbo.Estrategia e
		INNER JOIN ods.campania c ON  e.CampaniaID = c.Codigo
		INNER JOIN vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
		WHERE c.Codigo = @CampaniaID
			AND e.CUV2 = @CUVPadre
			
	END
END

GO

USE BelcorpGuatemala
GO

IF (OBJECT_ID('ShowRoom.UpdStockOfertaShowRoomUpd', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.UpdStockOfertaShowRoomUpd AS SET NOCOUNT ON;')
GO

--
ALTER PROCEDURE ShowRoom.UpdStockOfertaShowRoomUpd 
	@CampaniaID INT
	,@CUV VARCHAR(20)
	,@Stock INT
	,@Flag INT
AS
BEGIN
	DECLARE @CUVPadre VARCHAR(10)

	SET @CUVPadre = @CUV

	IF @Flag = 1
	BEGIN
		--- Si la cantidad ingresada es mayor a la anterior
		UPDATE dbo.Estrategia
		SET Cantidad += @Stock
		FROM dbo.Estrategia e
		INNER JOIN ods.campania c ON  e.CampaniaID = c.Codigo
		INNER JOIN vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
		WHERE c.Codigo = @CampaniaID
			AND e.CUV2 = @CUVPadre
	END
	ELSE
	BEGIN
		--- Si la cantidad anterior es mayor a la cantidad ingresada
		UPDATE dbo.Estrategia
		SET Cantidad -= @Stock
		FROM dbo.Estrategia e
		INNER JOIN ods.campania c ON  e.CampaniaID = c.Codigo
		INNER JOIN vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
		WHERE c.Codigo = @CampaniaID
			AND e.CUV2 = @CUVPadre
			
	END
END

GO

USE BelcorpEcuador
GO

IF (OBJECT_ID('ShowRoom.UpdStockOfertaShowRoomUpd', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.UpdStockOfertaShowRoomUpd AS SET NOCOUNT ON;')
GO

--
ALTER PROCEDURE ShowRoom.UpdStockOfertaShowRoomUpd 
	@CampaniaID INT
	,@CUV VARCHAR(20)
	,@Stock INT
	,@Flag INT
AS
BEGIN
	DECLARE @CUVPadre VARCHAR(10)

	SET @CUVPadre = @CUV

	IF @Flag = 1
	BEGIN
		--- Si la cantidad ingresada es mayor a la anterior
		UPDATE dbo.Estrategia
		SET Cantidad += @Stock
		FROM dbo.Estrategia e
		INNER JOIN ods.campania c ON  e.CampaniaID = c.Codigo
		INNER JOIN vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
		WHERE c.Codigo = @CampaniaID
			AND e.CUV2 = @CUVPadre
	END
	ELSE
	BEGIN
		--- Si la cantidad anterior es mayor a la cantidad ingresada
		UPDATE dbo.Estrategia
		SET Cantidad -= @Stock
		FROM dbo.Estrategia e
		INNER JOIN ods.campania c ON  e.CampaniaID = c.Codigo
		INNER JOIN vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
		WHERE c.Codigo = @CampaniaID
			AND e.CUV2 = @CUVPadre
			
	END
END

GO

USE BelcorpDominicana
GO

IF (OBJECT_ID('ShowRoom.UpdStockOfertaShowRoomUpd', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.UpdStockOfertaShowRoomUpd AS SET NOCOUNT ON;')
GO

--
ALTER PROCEDURE ShowRoom.UpdStockOfertaShowRoomUpd 
	@CampaniaID INT
	,@CUV VARCHAR(20)
	,@Stock INT
	,@Flag INT
AS
BEGIN
	DECLARE @CUVPadre VARCHAR(10)

	SET @CUVPadre = @CUV

	IF @Flag = 1
	BEGIN
		--- Si la cantidad ingresada es mayor a la anterior
		UPDATE dbo.Estrategia
		SET Cantidad += @Stock
		FROM dbo.Estrategia e
		INNER JOIN ods.campania c ON  e.CampaniaID = c.Codigo
		INNER JOIN vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
		WHERE c.Codigo = @CampaniaID
			AND e.CUV2 = @CUVPadre
	END
	ELSE
	BEGIN
		--- Si la cantidad anterior es mayor a la cantidad ingresada
		UPDATE dbo.Estrategia
		SET Cantidad -= @Stock
		FROM dbo.Estrategia e
		INNER JOIN ods.campania c ON  e.CampaniaID = c.Codigo
		INNER JOIN vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
		WHERE c.Codigo = @CampaniaID
			AND e.CUV2 = @CUVPadre
			
	END
END

GO

USE BelcorpCostaRica
GO

IF (OBJECT_ID('ShowRoom.UpdStockOfertaShowRoomUpd', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.UpdStockOfertaShowRoomUpd AS SET NOCOUNT ON;')
GO

--
ALTER PROCEDURE ShowRoom.UpdStockOfertaShowRoomUpd 
	@CampaniaID INT
	,@CUV VARCHAR(20)
	,@Stock INT
	,@Flag INT
AS
BEGIN
	DECLARE @CUVPadre VARCHAR(10)

	SET @CUVPadre = @CUV

	IF @Flag = 1
	BEGIN
		--- Si la cantidad ingresada es mayor a la anterior
		UPDATE dbo.Estrategia
		SET Cantidad += @Stock
		FROM dbo.Estrategia e
		INNER JOIN ods.campania c ON  e.CampaniaID = c.Codigo
		INNER JOIN vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
		WHERE c.Codigo = @CampaniaID
			AND e.CUV2 = @CUVPadre
	END
	ELSE
	BEGIN
		--- Si la cantidad anterior es mayor a la cantidad ingresada
		UPDATE dbo.Estrategia
		SET Cantidad -= @Stock
		FROM dbo.Estrategia e
		INNER JOIN ods.campania c ON  e.CampaniaID = c.Codigo
		INNER JOIN vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
		WHERE c.Codigo = @CampaniaID
			AND e.CUV2 = @CUVPadre
			
	END
END

GO

USE BelcorpChile
GO

IF (OBJECT_ID('ShowRoom.UpdStockOfertaShowRoomUpd', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.UpdStockOfertaShowRoomUpd AS SET NOCOUNT ON;')
GO

--
ALTER PROCEDURE ShowRoom.UpdStockOfertaShowRoomUpd 
	@CampaniaID INT
	,@CUV VARCHAR(20)
	,@Stock INT
	,@Flag INT
AS
BEGIN
	DECLARE @CUVPadre VARCHAR(10)

	SET @CUVPadre = @CUV

	IF @Flag = 1
	BEGIN
		--- Si la cantidad ingresada es mayor a la anterior
		UPDATE dbo.Estrategia
		SET Cantidad += @Stock
		FROM dbo.Estrategia e
		INNER JOIN ods.campania c ON  e.CampaniaID = c.Codigo
		INNER JOIN vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
		WHERE c.Codigo = @CampaniaID
			AND e.CUV2 = @CUVPadre
	END
	ELSE
	BEGIN
		--- Si la cantidad anterior es mayor a la cantidad ingresada
		UPDATE dbo.Estrategia
		SET Cantidad -= @Stock
		FROM dbo.Estrategia e
		INNER JOIN ods.campania c ON  e.CampaniaID = c.Codigo
		INNER JOIN vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
		WHERE c.Codigo = @CampaniaID
			AND e.CUV2 = @CUVPadre
			
	END
END

GO

USE BelcorpBolivia
GO

IF (OBJECT_ID('ShowRoom.UpdStockOfertaShowRoomUpd', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.UpdStockOfertaShowRoomUpd AS SET NOCOUNT ON;')
GO

--
ALTER PROCEDURE ShowRoom.UpdStockOfertaShowRoomUpd 
	@CampaniaID INT
	,@CUV VARCHAR(20)
	,@Stock INT
	,@Flag INT
AS
BEGIN
	DECLARE @CUVPadre VARCHAR(10)

	SET @CUVPadre = @CUV

	IF @Flag = 1
	BEGIN
		--- Si la cantidad ingresada es mayor a la anterior
		UPDATE dbo.Estrategia
		SET Cantidad += @Stock
		FROM dbo.Estrategia e
		INNER JOIN ods.campania c ON  e.CampaniaID = c.Codigo
		INNER JOIN vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
		WHERE c.Codigo = @CampaniaID
			AND e.CUV2 = @CUVPadre
	END
	ELSE
	BEGIN
		--- Si la cantidad anterior es mayor a la cantidad ingresada
		UPDATE dbo.Estrategia
		SET Cantidad -= @Stock
		FROM dbo.Estrategia e
		INNER JOIN ods.campania c ON  e.CampaniaID = c.Codigo
		INNER JOIN vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
		WHERE c.Codigo = @CampaniaID
			AND e.CUV2 = @CUVPadre
			
	END
END

