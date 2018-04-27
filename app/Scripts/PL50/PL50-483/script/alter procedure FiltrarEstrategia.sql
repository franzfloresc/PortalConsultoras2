USE belcorpperu_pl50
GO

ALTER PROCEDURE dbo.FiltrarEstrategia @EstrategiaID INT = 0
	,@CUV2 VARCHAR(50)
	,@TipoEstrategiaID INT = 0
	,@CampaniaID INT
	,@AgregarEnMatriz BIT = 0
	,@UsuarioRegistro VARCHAR(50) = ''
AS
BEGIN
	IF (@AgregarEnMatriz = 1)
	BEGIN
		DECLARE @CodigoSAP VARCHAR(50)
			,@DescripcionOriginal VARCHAR(250)

		SELECT @CodigoSAP = pc.CodigoProducto
			,@DescripcionOriginal = pc.Descripcion
		FROM dbo.Estrategia e
		INNER JOIN ods.productocomercial pc ON e.cuv2 = pc.cuv
		INNER JOIN ods.Campania c ON c.CampaniaID = pc.CampaniaID
			AND c.codigo = e.campaniaID
		WHERE e.EstrategiaID = @EstrategiaID
			--AND e.CUV2 = @CUV2
			AND e.CampaniaID = @CampaniaID

		IF (
				(@CodigoSAP IS NOT NULL)
				AND (
					NOT EXISTS (
						SELECT IdMatrizComercial
						FROM dbo.MatrizComercial
						WHERE CodigoSAP = @CodigoSAP
						)
					)
				)
		BEGIN
			INSERT INTO MatrizComercial (
				CodigoSAP
				,DescripcionOriginal
				,Descripcion
				,UsuarioRegistro
				,FechaRegistro
				)
			VALUES (
				@CodigoSAP
				,@DescripcionOriginal
				,NULL
				,@UsuarioRegistro
				,GETDATE()
				)
		END
	END

	SELECT EstrategiaID
		,TipoEstrategiaID
		,e.CampaniaID
		,CampaniaIDFin
		,NumeroPedido
		,e.Activo
		,ImagenURL
		,LimiteVenta
		,DescripcionCUV2
		,FlagDescripcion
		,e.CUV
		,EtiquetaID
		,Precio
		,FlagCEP
		,CUV2
		,EtiquetaID2
		,Precio2
		,FlagCEP2
		,TextoLibre
		,FlagTextoLibre
		,Cantidad
		,FlagCantidad
		,Zona
		,Orden
		,ISNULL(e.ColorFondo, '') ColorFondo
		,ISNULL(e.FlagEstrella, 0) FlagEstrella
		,mc.CodigoSAP
		,mc.IdMatrizComercial
		,e.EsOfertaIndependiente
		,e.PrecioPublico
		,e.Ganancia
		,e.ImagenMiniaturaURL
		,e.EsSubCampania
		,e.Niveles
	FROM dbo.Estrategia e
	INNER JOIN ods.productocomercial pc ON e.cuv2 = pc.cuv
	INNER JOIN MatrizComercial mc ON mc.CodigoSAP = pc.CodigoProducto
	INNER JOIN ods.Campania c ON c.CampaniaID = pc.CampaniaID
		AND c.codigo = e.campaniaID
	WHERE (
			(@EstrategiaID = 0)
			OR (@EstrategiaID IS NULL)
			OR (e.EstrategiaID = @EstrategiaID)
			)
		AND (
			(@CUV2 = '')
			OR (@CUV2 IS NULL)
			OR (e.CUV2 = @CUV2)
			)
		AND (
			(@CampaniaID = 0)
			OR (@CampaniaID IS NULL)
			OR (e.CampaniaID = @CampaniaID)
			)
		AND (
			(@TipoEstrategiaID = 0)
			OR (@TipoEstrategiaID IS NULL)
			OR (e.TipoEstrategiaID = @TipoEstrategiaID)
			);
END
