
GO
IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[GetOfertasPersonalizadasImagenes]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[GetOfertasPersonalizadasImagenes]
GO

/******CREADO POR: JORGE LEIVA DIAZ ******/
/******RESULTADO : OBTIENE LA LISTA DE PRODUCTOS SIN IMAGEN CONFIGURADA ******/
/******PARAMETROS: CAMPAÑA, TIPO CONFIGURADO, CODIGO ESTRATEGIA ******/

--EXEC [dbo].[GetOfertasPersonalizadasImagenes] 201814, 2, '007'
CREATE PROCEDURE [dbo].[GetOfertasPersonalizadasImagenes] (
	@CampaniaID int,
	@TipoConfigurado int,
	@CodigoEstrategia varchar(4) = '001'
	)
AS
BEGIN
	SET NOCOUNT OFF

	DECLARE @resultado int = 0
	DECLARE @tabla_resultado table (CampaniaID int, CUV2 varchar(100), DescripcionCUV2 varchar(800))
	DECLARE @tablaCuvsOPT table (CampaniaID int, CUV varchar(100), DescripcionCUV varchar(800))

	IF (@CodigoEstrategia = '011') -- Herramienta de Venta
	BEGIN
		INSERT INTO @tablaCuvsOPT
		SELECT @CampaniaID, CUV, '' FROM ods.ProductoComercial
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
		SELECT @CampaniaID, CUV, ''
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
			
		IF @TipoConfigurado = 2
		BEGIN
			INSERT INTO @tabla_resultado-- (campaniaID, CUV)
			SELECT
				t.CampaniaID,
				t.CUV,
				COALESCE(mci.DescripcionComercial, e.DescripcionCUV2, pd.Descripcion, p.Descripcion)
			FROM @tablaCuvsOPT t
				INNER JOIN ods.ProductoComercial p
					on t.CampaniaID = p.AnoCampania
					and t.CUV = p.CUV
				LEFT JOIN Estrategia e
					on t.CampaniaID = e.CampaniaID
					and t.CUV = e.CUV2
					and e.TipoEstrategiaID = @TipoEstrategiaId
				LEFT JOIN dbo.ProductoDescripcion pd
					on p.AnoCampania = pd.CampaniaID
					and p.CUV = pd.CUV
				LEFT JOIN MatrizComercial mc
					on p.CodigoProducto = mc.CodigoSAP
				LEFT JOIN MatrizComercialImagen mci
					on mci.IdMatrizComercial = mc.IdMatrizComercial
					and mci.NemoTecnico IS NOT NULL
			WHERE
				t.CampaniaID = @CampaniaID
				and e.CUV2 is null			
		END
	END

	SELECT  *
	FROM @tabla_resultado t
	LEFT JOIN [dbo].[EstrategiaImagen] ei
	ON t.campaniaID = ei.campaniaID AND t.cuv2 = ei.cuv
	WHERE (ei.campaniaID is null)
	ORDER BY Fecha DESC

	SET NOCOUNT ON
END