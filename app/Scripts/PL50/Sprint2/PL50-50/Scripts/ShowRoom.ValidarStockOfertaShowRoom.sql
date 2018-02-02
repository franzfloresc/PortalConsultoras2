
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
