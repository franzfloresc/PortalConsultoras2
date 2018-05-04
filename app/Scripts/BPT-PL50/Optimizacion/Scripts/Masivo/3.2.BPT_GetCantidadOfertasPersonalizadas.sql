GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'GetCantidadOfertasPersonalizadas') AND type IN ( N'P', N'PC' ) ) 
	DROP PROCEDURE dbo.GetCantidadOfertasPersonalizadas
GO

CREATE PROCEDURE [dbo].[GetCantidadOfertasPersonalizadas]
	@CampaniaID int,
	@TipoConfigurado int,
	@CodigoEstrategia varchar(4) = '001'
as
-- GetCantidadOfertasPersonalizadas 201801, 1, '007'
BEGIN
	
	SET NOCOUNT OFF
	declare @resultado int = 0

	declare @tablaCuvsOPT table (CampaniaID int, CUV varchar(100))

	IF (@CodigoEstrategia = '011') -- Herramienta de Venta
	BEGIN
		INSERT INTO @tablaCuvsOPT
		SELECT @CampaniaID, CUV FROM ods.ProductoComercial 
		WHERE AnoCampania = @CampaniaID 
			AND CodigoTipoOferta in ('126') 
			AND FactorRepeticion = 1
		GROUP BY CUV
	END
	ELSE
	BEGIN
	
		DECLARE @CampaniaIDChar CHAR(6) = convert(char(6), @CampaniaID)

		DECLARE @EstrategiaCodigo char(3)
		SET @EstrategiaCodigo = convert(char(3), dbo.fnGetTipoPersonalizacion(@CodigoEstrategia))

		INSERT INTO @tablaCuvsOPT
		SELECT @CampaniaID, CUV 
		FROM ods.OfertasPersonalizadasCUV 
		WHERE TipoPersonalizacion = @EstrategiaCodigo 
		and AnioCampanaVenta = @CampaniaIDChar
	END
	

	IF @TipoConfigurado=0
	BEGIN
		SET @resultado = (SELECT count(0) from @tablaCuvsOPT)
	END
	ELSE
	BEGIN

			DECLARE @TipoEstrategiaId INT
			SET @TipoEstrategiaId = dbo.fnGetTipoEstrategiaId(@CodigoEstrategia)

			IF @TipoConfigurado = 1 -- lo que ya existe
			BEGIN
				SET @resultado = (
					SELECT count(0) from (SELECT t.CUV
					FROM @tablaCuvsOPT t 
					INNER JOIN Estrategia e ON 
						e.CampaniaID = t.CampaniaID 
						AND e.CUV2 = t.CUV
					WHERE e.CampaniaID = @CampaniaID 
						AND e.TipoEstrategiaID = @TipoEstrategiaId
					GROUP BY t.CUV
				) AS A)
			END
			ELSE -- IF @TipoConfigurado = 2 -- lo que falta
			BEGIN
				SET @resultado = (
					SELECT count(0)
					FROM @tablaCuvsOPT t 
					LEFT JOIN Estrategia e on 
						t.CampaniaID = e.CampaniaID 
						AND t.CUV = e.CUV2 
						AND e.TipoEstrategiaID = @TipoEstrategiaId
					WHERE t.CampaniaID = @CampaniaID 
					AND e.CUV2 is null
				)
			END
	END

	SELECT @resultado

	SET NOCOUNT ON
END