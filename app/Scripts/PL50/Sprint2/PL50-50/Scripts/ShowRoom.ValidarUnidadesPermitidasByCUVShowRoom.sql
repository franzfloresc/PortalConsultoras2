
GO

IF (OBJECT_ID('ShowRoom.ValidarUnidadesPermitidasByCUVShowRoom', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.ValidarUnidadesPermitidasByCUVShowRoom AS SET NOCOUNT ON;')
GO

--
ALTER PROCEDURE ShowRoom.ValidarUnidadesPermitidasByCUVShowRoom @CampaniaID INT
	,@CUV VARCHAR(20)
AS
/*
ShowRoom.ValidarUnidadesPermitidasByCUVShowRoom 201607,'99001'
*/
BEGIN
	DECLARE @UnidadesPermitidas INT
		,@CUVPadre VARCHAR(10)

	SET @CUVPadre = @CUV

	-- Verificamos si el cuv a validar es una talla o color
	IF EXISTS (
			SELECT 1
			FROM TallaColorLiquidacion
			WHERE CampaniaID = @CampaniaID
				AND CUV = @CUV
			)
	BEGIN
		SET @CUVPadre = (
				SELECT CUVPadre
				FROM TallaColorLiquidacion
				WHERE CampaniaID = @CampaniaID
					AND CUV = @CUV
				)
	END

	SELECT @UnidadesPermitidas = isnull(e.LimiteVenta, 0)
	FROM dbo.Estrategia e
	INNER JOIN ods.campania c ON e.CampaniaID = c.Codigo
	INNER JOIN vwEstrategiaShowRoomEquivalencia ves ON e.TipoEstrategiaId = ves.TipoEstrategiaID
	WHERE c.codigo = @CampaniaID
		AND e.cuv2 = @CUVPadre

	SELECT isnull(@UnidadesPermitidas, 0)
END
