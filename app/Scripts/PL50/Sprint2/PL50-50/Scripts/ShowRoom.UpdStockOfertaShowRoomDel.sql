GO

IF (OBJECT_ID('ShowRoom.UpdStockOfertaShowRoomDel', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.UpdStockOfertaShowRoomDel AS SET NOCOUNT ON;')
GO
--
ALTER PROCEDURE ShowRoom.UpdStockOfertaShowRoomDel 
	@CampaniaID INT
	,@CUV VARCHAR(20)
	,@Stock INT
AS
BEGIN
	DECLARE @CUVPadre VARCHAR(10)

	SET @CUVPadre = @CUV

	UPDATE dbo.Estrategia
	SET Cantidad += @Stock
	FROM dbo.Estrategia e
	INNER JOIN ods.campania c ON  e.CampaniaID = c.Codigo
	INNER JOIN vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE c.Codigo = @CampaniaID
		AND e.CUV2 = @CUVPadre
END
