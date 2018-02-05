
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
