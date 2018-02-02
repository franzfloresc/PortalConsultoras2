
GO

IF (OBJECT_ID('ShowRoom.UpdStockOfertaShowRoom', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.UpdStockOfertaShowRoom AS SET NOCOUNT ON;')
GO
--
ALTER PROCEDURE ShowRoom.UpdStockOfertaShowRoom 
--@TipoOfertaSisID INT
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
		--AND o.TipoOfertaSisID = @TipoOfertaSisID
END
