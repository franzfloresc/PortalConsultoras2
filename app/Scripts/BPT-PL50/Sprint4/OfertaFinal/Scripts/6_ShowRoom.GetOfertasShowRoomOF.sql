USE BelcorpPeru_BPT
GO

ALTER PROCEDURE [ShowRoom].[GetOfertasShowRoomOF] @CampaniaID INT
AS
/*
ShowRoom.GetOfertasShowRoomOF 201811
*/
BEGIN
	DECLARE @tablaFaltante TABLE (CUV VARCHAR(6))
	DECLARE @CategoriaApoyada BIT

	SELECT @CategoriaApoyada = CategoriaApoyada
	FROM UpSelling (NOLOCK)
	WHERE CodigoCampana = @CampaniaID

	INSERT INTO @tablaFaltante
	SELECT DISTINCT LTRIM(RTRIM(CUV))
	FROM dbo.ProductoFaltante (NOLOCK)
	WHERE CampaniaID = @CampaniaID
	
	UNION ALL
	
	SELECT DISTINCT LTRIM(RTRIM(fa.CodigoVenta))
	FROM ods.FaltanteAnunciado fa (NOLOCK)
	INNER JOIN ods.Campania c (NOLOCK) ON fa.CampaniaID = c.CampaniaID
	WHERE c.Codigo = @CampaniaID

	IF (@CategoriaApoyada = '1')
	BEGIN
		SELECT DISTINCT e.CUV2 AS CUV
			,e.DescripcionCUV2 AS NombreComercial
			,e.precio AS PrecioValorizado
			,COALESCE(e.precio2, pc.PrecioCatalogo) AS PrecioCatalogo
			,e.ImagenURL AS Imagen
			,s.CodigoMarca
			,s.CodigoCategoria
			,e.TipoEstrategiaId AS TipoEstrategiaID
		FROM TipoEstrategia te (NOLOCK)
		INNER JOIN Estrategia e (NOLOCK) ON te.TipoEstrategiaid = e.TipoEstrategiaId
			AND te.Codigo = '030'
		--INNER JOIN ods.Campania c(NOLOCK) ON e.CampaniaId = c.Codigo
		INNER JOIN ods.Productocomercial pc(NOLOCK) ON e.CampaniaId = pc.AnoCampania
			AND e.CUV2 = pc.CUV
		INNER JOIN Estrategiaproducto ep (NOLOCK) ON e.EstrategiaId = ep.EstrategiaId
		INNER JOIN ods.Marca m (NOLOCK) ON ep.IdMarca = m.MarcaId
		INNER JOIN ods.SAP_PRODUCTO s (NOLOCK) ON ep.SAP = s.CodigoSAP
		INNER JOIN Upselling_Marca_Categoria umc ON m.MarcaId = umc.MarcaID
			AND s.CodigoCategoria = umc.CategoriaID
		WHERE e.Campaniaid = @CampaniaID
			AND e.Activo = 1
			AND e.EsSubCampania = 0
	END
	ELSE
	BEGIN
		SELECT e.CUV2 AS CUV
			,e.DescripcionCUV2 AS NombreComercial
			,e.precio AS PrecioValorizado
			,COALESCE(e.precio2, pc.PrecioCatalogo) AS PrecioCatalogo
			,e.ImagenURL AS Imagen
			,s.CodigoMarca
			,s.CodigoCategoria
			,e.TipoEstrategiaId
		FROM TipoEstrategia te (NOLOCK)
		INNER JOIN Estrategia e (NOLOCK) ON te.TipoEstrategiaid = e.TipoEstrategiaId
			AND te.Codigo = '030'
		--INNER JOIN ods.Campania c(NOLOCK) ON e.CampaniaId = c.Codigo
		INNER JOIN ods.ProductoComercial pc (NOLOCK) ON e.CampaniaId = pc.AnoCampania
			AND e.CUV2 = pc.CUV
		INNER JOIN ods.SAP_PRODUCTO s (NOLOCK) ON pc.CodigoProducto = s.CodigoSAP
		WHERE e.CampaniaId = @CampaniaID
			AND e.Activo = 1
			AND e.EsSubCampania = 0
	END
END;