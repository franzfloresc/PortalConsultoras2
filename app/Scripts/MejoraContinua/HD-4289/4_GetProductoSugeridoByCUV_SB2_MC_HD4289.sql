GO
USE [BelcorpBolivia]
GO
ALTER PROCEDURE dbo.GetProductoSugeridoByCUV_SB2
@CampaniaID INT,
@ConsultoraID INT,
@CUV VARCHAR(20),
@RegionID INT,
@ZonaID INT,
@CodigoRegion VARCHAR(10),
@CodigoZona VARCHAR(10)
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @Contador INT = 0,
			@Maximo INT = 0

	DECLARE @tablaSugerido TABLE
	(
		ID INT IDENTITY(1,1) NOT NULL,
		Orden INT NOT NULL,
		ImagenProducto VARCHAR(150) NULL,
		CUV VARCHAR(20) NOT NULL

		PRIMARY KEY (ID)
	)

	DECLARE @tablaCUV TABLE
	(
		CUV VARCHAR(20),
		Descripcion VARCHAR(100),
		PrecioCatalogo DECIMAL(18,2),
		MarcaID INT,
		EstaEnRevista INT,
		TieneStock INT,
		EsExpoOferta INT,
		CUVRevista VARCHAR(20),
		CUVComplemento VARCHAR(20),
		PaisID INT,
		CampaniaID VARCHAR(6),
		CodigoCatalago VARCHAR(6),
		CodigoProducto VARCHAR(12),
		IndicadorMontoMinimo INT,
		DescripcionMarca VARCHAR(20),
		DescripcionCategoria VARCHAR(20),
		DescripcionEstrategia VARCHAR(200),
		ConfiguracionOfertaID INT,
		TipoOfertaSisID INT,
		FlagNueva INT,
		EstrategiaID INT, --
		CodigoEstrategia Varchar(10), --
		TipoEstrategiaID INT,
		IndicadorOferta BIT,
		TieneSugerido INT,
		TieneOfertaRevista INT,
		PrecioValorizado DECIMAL(18,2),
		TieneLanzamientoCatalogoPersonalizado BIT,
		TipoOfertaRevista VARCHAR(20),
		TipoEstrategiaCodigo VARCHAR(100),
		EsOfertaIndependiente BIT,
		EstrategiaIDSicc INT
	)

	INSERT INTO @tablaSugerido
	(
		Orden,
		ImagenProducto,
		CUV
	)
	SELECT
		Orden,
		ImagenProducto,
		CUVSugerido
	FROM dbo.ProductoSugerido (NOLOCK)
	WHERE CampaniaID = CAST(@CampaniaID AS VARCHAR(6))
	AND charindex(','+@CodigoZona+',',','+ConfiguracionZona+',' )>0 --*/ HD-4289 /*--
	AND CUV = @CUV
	AND Estado = 1

	SELECT
		@Contador = 1,
		@Maximo = COUNT(1)
	FROM @tablaSugerido

	WHILE @Contador <= @Maximo
	BEGIN
		SELECT @CUV = CUV
		FROM @tablaSugerido
		WHERE ID = @Contador

		INSERT INTO @tablaCUV
		(
			CUV,
			Descripcion,
			PrecioCatalogo,
			MarcaID,
			EstaEnRevista,
			TieneStock,
			EsExpoOferta,
			CUVRevista,
			CUVComplemento,
			PaisID,
			CampaniaID,
			CodigoCatalago,
			CodigoProducto,
			IndicadorMontoMinimo,
			DescripcionMarca,
			DescripcionCategoria,
			DescripcionEstrategia,
			ConfiguracionOfertaID,
			TipoOfertaSisID,
			FlagNueva,
			EstrategiaID, --
			CodigoEstrategia, --
			TipoEstrategiaID,
			IndicadorOferta,
			TieneSugerido,
			TieneOfertaRevista,
			PrecioValorizado,
			TieneLanzamientoCatalogoPersonalizado,
			TipoOfertaRevista,
			TipoEstrategiaCodigo,
			EsOfertaIndependiente,
			EstrategiaIDSicc
		)
		EXEC dbo.GetProductoComercialByCuvByFilter @CampaniaID, 1, @CUV, @RegionID, @ZonaID, @CodigoRegion, @CodigoZona

		SET @Contador = @Contador + 1
	END

	SELECT
		t.CUV,
		t.Descripcion,
		t.PrecioCatalogo,
		t.MarcaID,
		t.EstaEnRevista,
		t.TieneStock,
		t.EsExpoOferta,
		t.CUVRevista,
		t.CUVComplemento,
		t.PaisID,
		t.CampaniaID,
		t.CodigoCatalago,
		t.CodigoProducto,
		t.IndicadorMontoMinimo,
		t.DescripcionMarca,
		t.DescripcionCategoria,
		t.DescripcionEstrategia,
		t.ConfiguracionOfertaID,
		t.TipoOfertaSisID,
		t.FlagNueva,
		t.TipoEstrategiaID,
		t.IndicadorOferta,
		ts.ImagenProducto as ImagenProductoSugerido
	FROM @tablaCUV t
	INNER JOIN @tablaSugerido ts
	ON t.CUV = ts.CUV
	WHERE t.TieneStock = 1
	ORDER BY ts.Orden

	SET NOCOUNT OFF
END
GO
USE [BelcorpChile]
GO
ALTER PROCEDURE dbo.GetProductoSugeridoByCUV_SB2
@CampaniaID INT,
@ConsultoraID INT,
@CUV VARCHAR(20),
@RegionID INT,
@ZonaID INT,
@CodigoRegion VARCHAR(10),
@CodigoZona VARCHAR(10)
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @Contador INT = 0,
			@Maximo INT = 0

	DECLARE @tablaSugerido TABLE
	(
		ID INT IDENTITY(1,1) NOT NULL,
		Orden INT NOT NULL,
		ImagenProducto VARCHAR(150) NULL,
		CUV VARCHAR(20) NOT NULL

		PRIMARY KEY (ID)
	)

	DECLARE @tablaCUV TABLE
	(
		CUV VARCHAR(20),
		Descripcion VARCHAR(100),
		PrecioCatalogo DECIMAL(18,2),
		MarcaID INT,
		EstaEnRevista INT,
		TieneStock INT,
		EsExpoOferta INT,
		CUVRevista VARCHAR(20),
		CUVComplemento VARCHAR(20),
		PaisID INT,
		CampaniaID VARCHAR(6),
		CodigoCatalago VARCHAR(6),
		CodigoProducto VARCHAR(12),
		IndicadorMontoMinimo INT,
		DescripcionMarca VARCHAR(20),
		DescripcionCategoria VARCHAR(20),
		DescripcionEstrategia VARCHAR(200),
		ConfiguracionOfertaID INT,
		TipoOfertaSisID INT,
		FlagNueva INT,
		EstrategiaID INT, --
		CodigoEstrategia Varchar(10), --
		TipoEstrategiaID INT,
		IndicadorOferta BIT,
		TieneSugerido INT,
		TieneOfertaRevista INT,
		PrecioValorizado DECIMAL(18,2),
		TieneLanzamientoCatalogoPersonalizado BIT,
		TipoOfertaRevista VARCHAR(20),
		TipoEstrategiaCodigo VARCHAR(100),
		EsOfertaIndependiente BIT,
		EstrategiaIDSicc INT
	)

	INSERT INTO @tablaSugerido
	(
		Orden,
		ImagenProducto,
		CUV
	)
	SELECT
		Orden,
		ImagenProducto,
		CUVSugerido
	FROM dbo.ProductoSugerido (NOLOCK)
	WHERE CampaniaID = CAST(@CampaniaID AS VARCHAR(6))
	AND charindex(','+@CodigoZona+',',','+ConfiguracionZona+',' )>0 --*/ HD-4289 /*--
	AND CUV = @CUV
	AND Estado = 1

	SELECT
		@Contador = 1,
		@Maximo = COUNT(1)
	FROM @tablaSugerido

	WHILE @Contador <= @Maximo
	BEGIN
		SELECT @CUV = CUV
		FROM @tablaSugerido
		WHERE ID = @Contador

		INSERT INTO @tablaCUV
		(
			CUV,
			Descripcion,
			PrecioCatalogo,
			MarcaID,
			EstaEnRevista,
			TieneStock,
			EsExpoOferta,
			CUVRevista,
			CUVComplemento,
			PaisID,
			CampaniaID,
			CodigoCatalago,
			CodigoProducto,
			IndicadorMontoMinimo,
			DescripcionMarca,
			DescripcionCategoria,
			DescripcionEstrategia,
			ConfiguracionOfertaID,
			TipoOfertaSisID,
			FlagNueva,
			EstrategiaID, --
			CodigoEstrategia, --
			TipoEstrategiaID,
			IndicadorOferta,
			TieneSugerido,
			TieneOfertaRevista,
			PrecioValorizado,
			TieneLanzamientoCatalogoPersonalizado,
			TipoOfertaRevista,
			TipoEstrategiaCodigo,
			EsOfertaIndependiente,
			EstrategiaIDSicc
		)
		EXEC dbo.GetProductoComercialByCuvByFilter @CampaniaID, 1, @CUV, @RegionID, @ZonaID, @CodigoRegion, @CodigoZona

		SET @Contador = @Contador + 1
	END

	SELECT
		t.CUV,
		t.Descripcion,
		t.PrecioCatalogo,
		t.MarcaID,
		t.EstaEnRevista,
		t.TieneStock,
		t.EsExpoOferta,
		t.CUVRevista,
		t.CUVComplemento,
		t.PaisID,
		t.CampaniaID,
		t.CodigoCatalago,
		t.CodigoProducto,
		t.IndicadorMontoMinimo,
		t.DescripcionMarca,
		t.DescripcionCategoria,
		t.DescripcionEstrategia,
		t.ConfiguracionOfertaID,
		t.TipoOfertaSisID,
		t.FlagNueva,
		t.TipoEstrategiaID,
		t.IndicadorOferta,
		ts.ImagenProducto as ImagenProductoSugerido
	FROM @tablaCUV t
	INNER JOIN @tablaSugerido ts
	ON t.CUV = ts.CUV
	WHERE t.TieneStock = 1
	ORDER BY ts.Orden

	SET NOCOUNT OFF
END
GO
USE [BelcorpColombia]
GO
ALTER PROCEDURE dbo.GetProductoSugeridoByCUV_SB2
@CampaniaID INT,
@ConsultoraID INT,
@CUV VARCHAR(20),
@RegionID INT,
@ZonaID INT,
@CodigoRegion VARCHAR(10),
@CodigoZona VARCHAR(10)
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @Contador INT = 0,
			@Maximo INT = 0

	DECLARE @tablaSugerido TABLE
	(
		ID INT IDENTITY(1,1) NOT NULL,
		Orden INT NOT NULL,
		ImagenProducto VARCHAR(150) NULL,
		CUV VARCHAR(20) NOT NULL

		PRIMARY KEY (ID)
	)

	DECLARE @tablaCUV TABLE
	(
		CUV VARCHAR(20),
		Descripcion VARCHAR(100),
		PrecioCatalogo DECIMAL(18,2),
		MarcaID INT,
		EstaEnRevista INT,
		TieneStock INT,
		EsExpoOferta INT,
		CUVRevista VARCHAR(20),
		CUVComplemento VARCHAR(20),
		PaisID INT,
		CampaniaID VARCHAR(6),
		CodigoCatalago VARCHAR(6),
		CodigoProducto VARCHAR(12),
		IndicadorMontoMinimo INT,
		DescripcionMarca VARCHAR(20),
		DescripcionCategoria VARCHAR(20),
		DescripcionEstrategia VARCHAR(200),
		ConfiguracionOfertaID INT,
		TipoOfertaSisID INT,
		FlagNueva INT,
		EstrategiaID INT, --
		CodigoEstrategia Varchar(10), --
		TipoEstrategiaID INT,
		IndicadorOferta BIT,
		TieneSugerido INT,
		TieneOfertaRevista INT,
		PrecioValorizado DECIMAL(18,2),
		TieneLanzamientoCatalogoPersonalizado BIT,
		TipoOfertaRevista VARCHAR(20),
		TipoEstrategiaCodigo VARCHAR(100),
		EsOfertaIndependiente BIT,
		EstrategiaIDSicc INT
	)

	INSERT INTO @tablaSugerido
	(
		Orden,
		ImagenProducto,
		CUV
	)
	SELECT
		Orden,
		ImagenProducto,
		CUVSugerido
	FROM dbo.ProductoSugerido (NOLOCK)
	WHERE CampaniaID = CAST(@CampaniaID AS VARCHAR(6))
	AND charindex(','+@CodigoZona+',',','+ConfiguracionZona+',' )>0 --*/ HD-4289 /*--
	AND CUV = @CUV
	AND Estado = 1

	SELECT
		@Contador = 1,
		@Maximo = COUNT(1)
	FROM @tablaSugerido

	WHILE @Contador <= @Maximo
	BEGIN
		SELECT @CUV = CUV
		FROM @tablaSugerido
		WHERE ID = @Contador

		INSERT INTO @tablaCUV
		(
			CUV,
			Descripcion,
			PrecioCatalogo,
			MarcaID,
			EstaEnRevista,
			TieneStock,
			EsExpoOferta,
			CUVRevista,
			CUVComplemento,
			PaisID,
			CampaniaID,
			CodigoCatalago,
			CodigoProducto,
			IndicadorMontoMinimo,
			DescripcionMarca,
			DescripcionCategoria,
			DescripcionEstrategia,
			ConfiguracionOfertaID,
			TipoOfertaSisID,
			FlagNueva,
			EstrategiaID, --
			CodigoEstrategia, --
			TipoEstrategiaID,
			IndicadorOferta,
			TieneSugerido,
			TieneOfertaRevista,
			PrecioValorizado,
			TieneLanzamientoCatalogoPersonalizado,
			TipoOfertaRevista,
			TipoEstrategiaCodigo,
			EsOfertaIndependiente,
			EstrategiaIDSicc
		)
		EXEC dbo.GetProductoComercialByCuvByFilter @CampaniaID, 1, @CUV, @RegionID, @ZonaID, @CodigoRegion, @CodigoZona

		SET @Contador = @Contador + 1
	END

	SELECT
		t.CUV,
		t.Descripcion,
		t.PrecioCatalogo,
		t.MarcaID,
		t.EstaEnRevista,
		t.TieneStock,
		t.EsExpoOferta,
		t.CUVRevista,
		t.CUVComplemento,
		t.PaisID,
		t.CampaniaID,
		t.CodigoCatalago,
		t.CodigoProducto,
		t.IndicadorMontoMinimo,
		t.DescripcionMarca,
		t.DescripcionCategoria,
		t.DescripcionEstrategia,
		t.ConfiguracionOfertaID,
		t.TipoOfertaSisID,
		t.FlagNueva,
		t.TipoEstrategiaID,
		t.IndicadorOferta,
		ts.ImagenProducto as ImagenProductoSugerido
	FROM @tablaCUV t
	INNER JOIN @tablaSugerido ts
	ON t.CUV = ts.CUV
	WHERE t.TieneStock = 1
	ORDER BY ts.Orden

	SET NOCOUNT OFF
END
GO
USE [BelcorpCostaRica]
GO
ALTER PROCEDURE dbo.GetProductoSugeridoByCUV_SB2
@CampaniaID INT,
@ConsultoraID INT,
@CUV VARCHAR(20),
@RegionID INT,
@ZonaID INT,
@CodigoRegion VARCHAR(10),
@CodigoZona VARCHAR(10)
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @Contador INT = 0,
			@Maximo INT = 0

	DECLARE @tablaSugerido TABLE
	(
		ID INT IDENTITY(1,1) NOT NULL,
		Orden INT NOT NULL,
		ImagenProducto VARCHAR(150) NULL,
		CUV VARCHAR(20) NOT NULL

		PRIMARY KEY (ID)
	)

	DECLARE @tablaCUV TABLE
	(
		CUV VARCHAR(20),
		Descripcion VARCHAR(100),
		PrecioCatalogo DECIMAL(18,2),
		MarcaID INT,
		EstaEnRevista INT,
		TieneStock INT,
		EsExpoOferta INT,
		CUVRevista VARCHAR(20),
		CUVComplemento VARCHAR(20),
		PaisID INT,
		CampaniaID VARCHAR(6),
		CodigoCatalago VARCHAR(6),
		CodigoProducto VARCHAR(12),
		IndicadorMontoMinimo INT,
		DescripcionMarca VARCHAR(20),
		DescripcionCategoria VARCHAR(20),
		DescripcionEstrategia VARCHAR(200),
		ConfiguracionOfertaID INT,
		TipoOfertaSisID INT,
		FlagNueva INT,
		EstrategiaID INT, --
		CodigoEstrategia Varchar(10), --
		TipoEstrategiaID INT,
		IndicadorOferta BIT,
		TieneSugerido INT,
		TieneOfertaRevista INT,
		PrecioValorizado DECIMAL(18,2),
		TieneLanzamientoCatalogoPersonalizado BIT,
		TipoOfertaRevista VARCHAR(20),
		TipoEstrategiaCodigo VARCHAR(100),
		EsOfertaIndependiente BIT,
		EstrategiaIDSicc INT
	)

	INSERT INTO @tablaSugerido
	(
		Orden,
		ImagenProducto,
		CUV
	)
	SELECT
		Orden,
		ImagenProducto,
		CUVSugerido
	FROM dbo.ProductoSugerido (NOLOCK)
	WHERE CampaniaID = CAST(@CampaniaID AS VARCHAR(6))
	AND charindex(','+@CodigoZona+',',','+ConfiguracionZona+',' )>0 --*/ HD-4289 /*--
	AND CUV = @CUV
	AND Estado = 1

	SELECT
		@Contador = 1,
		@Maximo = COUNT(1)
	FROM @tablaSugerido

	WHILE @Contador <= @Maximo
	BEGIN
		SELECT @CUV = CUV
		FROM @tablaSugerido
		WHERE ID = @Contador

		INSERT INTO @tablaCUV
		(
			CUV,
			Descripcion,
			PrecioCatalogo,
			MarcaID,
			EstaEnRevista,
			TieneStock,
			EsExpoOferta,
			CUVRevista,
			CUVComplemento,
			PaisID,
			CampaniaID,
			CodigoCatalago,
			CodigoProducto,
			IndicadorMontoMinimo,
			DescripcionMarca,
			DescripcionCategoria,
			DescripcionEstrategia,
			ConfiguracionOfertaID,
			TipoOfertaSisID,
			FlagNueva,
			EstrategiaID, --
			CodigoEstrategia, --
			TipoEstrategiaID,
			IndicadorOferta,
			TieneSugerido,
			TieneOfertaRevista,
			PrecioValorizado,
			TieneLanzamientoCatalogoPersonalizado,
			TipoOfertaRevista,
			TipoEstrategiaCodigo,
			EsOfertaIndependiente,
			EstrategiaIDSicc
		)
		EXEC dbo.GetProductoComercialByCuvByFilter @CampaniaID, 1, @CUV, @RegionID, @ZonaID, @CodigoRegion, @CodigoZona

		SET @Contador = @Contador + 1
	END

	SELECT
		t.CUV,
		t.Descripcion,
		t.PrecioCatalogo,
		t.MarcaID,
		t.EstaEnRevista,
		t.TieneStock,
		t.EsExpoOferta,
		t.CUVRevista,
		t.CUVComplemento,
		t.PaisID,
		t.CampaniaID,
		t.CodigoCatalago,
		t.CodigoProducto,
		t.IndicadorMontoMinimo,
		t.DescripcionMarca,
		t.DescripcionCategoria,
		t.DescripcionEstrategia,
		t.ConfiguracionOfertaID,
		t.TipoOfertaSisID,
		t.FlagNueva,
		t.TipoEstrategiaID,
		t.IndicadorOferta,
		ts.ImagenProducto as ImagenProductoSugerido
	FROM @tablaCUV t
	INNER JOIN @tablaSugerido ts
	ON t.CUV = ts.CUV
	WHERE t.TieneStock = 1
	ORDER BY ts.Orden

	SET NOCOUNT OFF
END
GO
USE [BelcorpDominicana]
GO
ALTER PROCEDURE dbo.GetProductoSugeridoByCUV_SB2
@CampaniaID INT,
@ConsultoraID INT,
@CUV VARCHAR(20),
@RegionID INT,
@ZonaID INT,
@CodigoRegion VARCHAR(10),
@CodigoZona VARCHAR(10)
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @Contador INT = 0,
			@Maximo INT = 0

	DECLARE @tablaSugerido TABLE
	(
		ID INT IDENTITY(1,1) NOT NULL,
		Orden INT NOT NULL,
		ImagenProducto VARCHAR(150) NULL,
		CUV VARCHAR(20) NOT NULL

		PRIMARY KEY (ID)
	)

	DECLARE @tablaCUV TABLE
	(
		CUV VARCHAR(20),
		Descripcion VARCHAR(100),
		PrecioCatalogo DECIMAL(18,2),
		MarcaID INT,
		EstaEnRevista INT,
		TieneStock INT,
		EsExpoOferta INT,
		CUVRevista VARCHAR(20),
		CUVComplemento VARCHAR(20),
		PaisID INT,
		CampaniaID VARCHAR(6),
		CodigoCatalago VARCHAR(6),
		CodigoProducto VARCHAR(12),
		IndicadorMontoMinimo INT,
		DescripcionMarca VARCHAR(20),
		DescripcionCategoria VARCHAR(20),
		DescripcionEstrategia VARCHAR(200),
		ConfiguracionOfertaID INT,
		TipoOfertaSisID INT,
		FlagNueva INT,
		EstrategiaID INT, --
		CodigoEstrategia Varchar(10), --
		TipoEstrategiaID INT,
		IndicadorOferta BIT,
		TieneSugerido INT,
		TieneOfertaRevista INT,
		PrecioValorizado DECIMAL(18,2),
		TieneLanzamientoCatalogoPersonalizado BIT,
		TipoOfertaRevista VARCHAR(20),
		TipoEstrategiaCodigo VARCHAR(100),
		EsOfertaIndependiente BIT,
		EstrategiaIDSicc INT
	)

	INSERT INTO @tablaSugerido
	(
		Orden,
		ImagenProducto,
		CUV
	)
	SELECT
		Orden,
		ImagenProducto,
		CUVSugerido
	FROM dbo.ProductoSugerido (NOLOCK)
	WHERE CampaniaID = CAST(@CampaniaID AS VARCHAR(6))
	AND charindex(','+@CodigoZona+',',','+ConfiguracionZona+',' )>0 --*/ HD-4289 /*--
	AND CUV = @CUV
	AND Estado = 1

	SELECT
		@Contador = 1,
		@Maximo = COUNT(1)
	FROM @tablaSugerido

	WHILE @Contador <= @Maximo
	BEGIN
		SELECT @CUV = CUV
		FROM @tablaSugerido
		WHERE ID = @Contador

		INSERT INTO @tablaCUV
		(
			CUV,
			Descripcion,
			PrecioCatalogo,
			MarcaID,
			EstaEnRevista,
			TieneStock,
			EsExpoOferta,
			CUVRevista,
			CUVComplemento,
			PaisID,
			CampaniaID,
			CodigoCatalago,
			CodigoProducto,
			IndicadorMontoMinimo,
			DescripcionMarca,
			DescripcionCategoria,
			DescripcionEstrategia,
			ConfiguracionOfertaID,
			TipoOfertaSisID,
			FlagNueva,
			EstrategiaID, --
			CodigoEstrategia, --
			TipoEstrategiaID,
			IndicadorOferta,
			TieneSugerido,
			TieneOfertaRevista,
			PrecioValorizado,
			TieneLanzamientoCatalogoPersonalizado,
			TipoOfertaRevista,
			TipoEstrategiaCodigo,
			EsOfertaIndependiente,
			EstrategiaIDSicc
		)
		EXEC dbo.GetProductoComercialByCuvByFilter @CampaniaID, 1, @CUV, @RegionID, @ZonaID, @CodigoRegion, @CodigoZona

		SET @Contador = @Contador + 1
	END

	SELECT
		t.CUV,
		t.Descripcion,
		t.PrecioCatalogo,
		t.MarcaID,
		t.EstaEnRevista,
		t.TieneStock,
		t.EsExpoOferta,
		t.CUVRevista,
		t.CUVComplemento,
		t.PaisID,
		t.CampaniaID,
		t.CodigoCatalago,
		t.CodigoProducto,
		t.IndicadorMontoMinimo,
		t.DescripcionMarca,
		t.DescripcionCategoria,
		t.DescripcionEstrategia,
		t.ConfiguracionOfertaID,
		t.TipoOfertaSisID,
		t.FlagNueva,
		t.TipoEstrategiaID,
		t.IndicadorOferta,
		ts.ImagenProducto as ImagenProductoSugerido
	FROM @tablaCUV t
	INNER JOIN @tablaSugerido ts
	ON t.CUV = ts.CUV
	WHERE t.TieneStock = 1
	ORDER BY ts.Orden

	SET NOCOUNT OFF
END
GO
USE [BelcorpEcuador]
GO
ALTER PROCEDURE dbo.GetProductoSugeridoByCUV_SB2
@CampaniaID INT,
@ConsultoraID INT,
@CUV VARCHAR(20),
@RegionID INT,
@ZonaID INT,
@CodigoRegion VARCHAR(10),
@CodigoZona VARCHAR(10)
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @Contador INT = 0,
			@Maximo INT = 0

	DECLARE @tablaSugerido TABLE
	(
		ID INT IDENTITY(1,1) NOT NULL,
		Orden INT NOT NULL,
		ImagenProducto VARCHAR(150) NULL,
		CUV VARCHAR(20) NOT NULL

		PRIMARY KEY (ID)
	)

	DECLARE @tablaCUV TABLE
	(
		CUV VARCHAR(20),
		Descripcion VARCHAR(100),
		PrecioCatalogo DECIMAL(18,2),
		MarcaID INT,
		EstaEnRevista INT,
		TieneStock INT,
		EsExpoOferta INT,
		CUVRevista VARCHAR(20),
		CUVComplemento VARCHAR(20),
		PaisID INT,
		CampaniaID VARCHAR(6),
		CodigoCatalago VARCHAR(6),
		CodigoProducto VARCHAR(12),
		IndicadorMontoMinimo INT,
		DescripcionMarca VARCHAR(20),
		DescripcionCategoria VARCHAR(20),
		DescripcionEstrategia VARCHAR(200),
		ConfiguracionOfertaID INT,
		TipoOfertaSisID INT,
		FlagNueva INT,
		EstrategiaID INT, --
		CodigoEstrategia Varchar(10), --
		TipoEstrategiaID INT,
		IndicadorOferta BIT,
		TieneSugerido INT,
		TieneOfertaRevista INT,
		PrecioValorizado DECIMAL(18,2),
		TieneLanzamientoCatalogoPersonalizado BIT,
		TipoOfertaRevista VARCHAR(20),
		TipoEstrategiaCodigo VARCHAR(100),
		EsOfertaIndependiente BIT,
		EstrategiaIDSicc INT
	)

	INSERT INTO @tablaSugerido
	(
		Orden,
		ImagenProducto,
		CUV
	)
	SELECT
		Orden,
		ImagenProducto,
		CUVSugerido
	FROM dbo.ProductoSugerido (NOLOCK)
	WHERE CampaniaID = CAST(@CampaniaID AS VARCHAR(6))
	AND charindex(','+@CodigoZona+',',','+ConfiguracionZona+',' )>0 --*/ HD-4289 /*--
	AND CUV = @CUV
	AND Estado = 1

	SELECT
		@Contador = 1,
		@Maximo = COUNT(1)
	FROM @tablaSugerido

	WHILE @Contador <= @Maximo
	BEGIN
		SELECT @CUV = CUV
		FROM @tablaSugerido
		WHERE ID = @Contador

		INSERT INTO @tablaCUV
		(
			CUV,
			Descripcion,
			PrecioCatalogo,
			MarcaID,
			EstaEnRevista,
			TieneStock,
			EsExpoOferta,
			CUVRevista,
			CUVComplemento,
			PaisID,
			CampaniaID,
			CodigoCatalago,
			CodigoProducto,
			IndicadorMontoMinimo,
			DescripcionMarca,
			DescripcionCategoria,
			DescripcionEstrategia,
			ConfiguracionOfertaID,
			TipoOfertaSisID,
			FlagNueva,
			EstrategiaID, --
			CodigoEstrategia, --
			TipoEstrategiaID,
			IndicadorOferta,
			TieneSugerido,
			TieneOfertaRevista,
			PrecioValorizado,
			TieneLanzamientoCatalogoPersonalizado,
			TipoOfertaRevista,
			TipoEstrategiaCodigo,
			EsOfertaIndependiente,
			EstrategiaIDSicc
		)
		EXEC dbo.GetProductoComercialByCuvByFilter @CampaniaID, 1, @CUV, @RegionID, @ZonaID, @CodigoRegion, @CodigoZona

		SET @Contador = @Contador + 1
	END

	SELECT
		t.CUV,
		t.Descripcion,
		t.PrecioCatalogo,
		t.MarcaID,
		t.EstaEnRevista,
		t.TieneStock,
		t.EsExpoOferta,
		t.CUVRevista,
		t.CUVComplemento,
		t.PaisID,
		t.CampaniaID,
		t.CodigoCatalago,
		t.CodigoProducto,
		t.IndicadorMontoMinimo,
		t.DescripcionMarca,
		t.DescripcionCategoria,
		t.DescripcionEstrategia,
		t.ConfiguracionOfertaID,
		t.TipoOfertaSisID,
		t.FlagNueva,
		t.TipoEstrategiaID,
		t.IndicadorOferta,
		ts.ImagenProducto as ImagenProductoSugerido
	FROM @tablaCUV t
	INNER JOIN @tablaSugerido ts
	ON t.CUV = ts.CUV
	WHERE t.TieneStock = 1
	ORDER BY ts.Orden

	SET NOCOUNT OFF
END
GO
USE [BelcorpGuatemala]
GO
ALTER PROCEDURE dbo.GetProductoSugeridoByCUV_SB2
@CampaniaID INT,
@ConsultoraID INT,
@CUV VARCHAR(20),
@RegionID INT,
@ZonaID INT,
@CodigoRegion VARCHAR(10),
@CodigoZona VARCHAR(10)
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @Contador INT = 0,
			@Maximo INT = 0

	DECLARE @tablaSugerido TABLE
	(
		ID INT IDENTITY(1,1) NOT NULL,
		Orden INT NOT NULL,
		ImagenProducto VARCHAR(150) NULL,
		CUV VARCHAR(20) NOT NULL

		PRIMARY KEY (ID)
	)

	DECLARE @tablaCUV TABLE
	(
		CUV VARCHAR(20),
		Descripcion VARCHAR(100),
		PrecioCatalogo DECIMAL(18,2),
		MarcaID INT,
		EstaEnRevista INT,
		TieneStock INT,
		EsExpoOferta INT,
		CUVRevista VARCHAR(20),
		CUVComplemento VARCHAR(20),
		PaisID INT,
		CampaniaID VARCHAR(6),
		CodigoCatalago VARCHAR(6),
		CodigoProducto VARCHAR(12),
		IndicadorMontoMinimo INT,
		DescripcionMarca VARCHAR(20),
		DescripcionCategoria VARCHAR(20),
		DescripcionEstrategia VARCHAR(200),
		ConfiguracionOfertaID INT,
		TipoOfertaSisID INT,
		FlagNueva INT,
		EstrategiaID INT, --
		CodigoEstrategia Varchar(10), --
		TipoEstrategiaID INT,
		IndicadorOferta BIT,
		TieneSugerido INT,
		TieneOfertaRevista INT,
		PrecioValorizado DECIMAL(18,2),
		TieneLanzamientoCatalogoPersonalizado BIT,
		TipoOfertaRevista VARCHAR(20),
		TipoEstrategiaCodigo VARCHAR(100),
		EsOfertaIndependiente BIT,
		EstrategiaIDSicc INT
	)

	INSERT INTO @tablaSugerido
	(
		Orden,
		ImagenProducto,
		CUV
	)
	SELECT
		Orden,
		ImagenProducto,
		CUVSugerido
	FROM dbo.ProductoSugerido (NOLOCK)
	WHERE CampaniaID = CAST(@CampaniaID AS VARCHAR(6))
	AND charindex(','+@CodigoZona+',',','+ConfiguracionZona+',' )>0 --*/ HD-4289 /*--
	AND CUV = @CUV
	AND Estado = 1

	SELECT
		@Contador = 1,
		@Maximo = COUNT(1)
	FROM @tablaSugerido

	WHILE @Contador <= @Maximo
	BEGIN
		SELECT @CUV = CUV
		FROM @tablaSugerido
		WHERE ID = @Contador

		INSERT INTO @tablaCUV
		(
			CUV,
			Descripcion,
			PrecioCatalogo,
			MarcaID,
			EstaEnRevista,
			TieneStock,
			EsExpoOferta,
			CUVRevista,
			CUVComplemento,
			PaisID,
			CampaniaID,
			CodigoCatalago,
			CodigoProducto,
			IndicadorMontoMinimo,
			DescripcionMarca,
			DescripcionCategoria,
			DescripcionEstrategia,
			ConfiguracionOfertaID,
			TipoOfertaSisID,
			FlagNueva,
			EstrategiaID, --
			CodigoEstrategia, --
			TipoEstrategiaID,
			IndicadorOferta,
			TieneSugerido,
			TieneOfertaRevista,
			PrecioValorizado,
			TieneLanzamientoCatalogoPersonalizado,
			TipoOfertaRevista,
			TipoEstrategiaCodigo,
			EsOfertaIndependiente,
			EstrategiaIDSicc
		)
		EXEC dbo.GetProductoComercialByCuvByFilter @CampaniaID, 1, @CUV, @RegionID, @ZonaID, @CodigoRegion, @CodigoZona

		SET @Contador = @Contador + 1
	END

	SELECT
		t.CUV,
		t.Descripcion,
		t.PrecioCatalogo,
		t.MarcaID,
		t.EstaEnRevista,
		t.TieneStock,
		t.EsExpoOferta,
		t.CUVRevista,
		t.CUVComplemento,
		t.PaisID,
		t.CampaniaID,
		t.CodigoCatalago,
		t.CodigoProducto,
		t.IndicadorMontoMinimo,
		t.DescripcionMarca,
		t.DescripcionCategoria,
		t.DescripcionEstrategia,
		t.ConfiguracionOfertaID,
		t.TipoOfertaSisID,
		t.FlagNueva,
		t.TipoEstrategiaID,
		t.IndicadorOferta,
		ts.ImagenProducto as ImagenProductoSugerido
	FROM @tablaCUV t
	INNER JOIN @tablaSugerido ts
	ON t.CUV = ts.CUV
	WHERE t.TieneStock = 1
	ORDER BY ts.Orden

	SET NOCOUNT OFF
END
GO
USE [BelcorpMexico]
GO
ALTER PROCEDURE dbo.GetProductoSugeridoByCUV_SB2
@CampaniaID INT,
@ConsultoraID INT,
@CUV VARCHAR(20),
@RegionID INT,
@ZonaID INT,
@CodigoRegion VARCHAR(10),
@CodigoZona VARCHAR(10)
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @Contador INT = 0,
			@Maximo INT = 0

	DECLARE @tablaSugerido TABLE
	(
		ID INT IDENTITY(1,1) NOT NULL,
		Orden INT NOT NULL,
		ImagenProducto VARCHAR(150) NULL,
		CUV VARCHAR(20) NOT NULL

		PRIMARY KEY (ID)
	)

	DECLARE @tablaCUV TABLE
	(
		CUV VARCHAR(20),
		Descripcion VARCHAR(100),
		PrecioCatalogo DECIMAL(18,2),
		MarcaID INT,
		EstaEnRevista INT,
		TieneStock INT,
		EsExpoOferta INT,
		CUVRevista VARCHAR(20),
		CUVComplemento VARCHAR(20),
		PaisID INT,
		CampaniaID VARCHAR(6),
		CodigoCatalago VARCHAR(6),
		CodigoProducto VARCHAR(12),
		IndicadorMontoMinimo INT,
		DescripcionMarca VARCHAR(20),
		DescripcionCategoria VARCHAR(20),
		DescripcionEstrategia VARCHAR(200),
		ConfiguracionOfertaID INT,
		TipoOfertaSisID INT,
		FlagNueva INT,
		EstrategiaID INT, --
		CodigoEstrategia Varchar(10), --
		TipoEstrategiaID INT,
		IndicadorOferta BIT,
		TieneSugerido INT,
		TieneOfertaRevista INT,
		PrecioValorizado DECIMAL(18,2),
		TieneLanzamientoCatalogoPersonalizado BIT,
		TipoOfertaRevista VARCHAR(20),
		TipoEstrategiaCodigo VARCHAR(100),
		EsOfertaIndependiente BIT,
		EstrategiaIDSicc INT
	)

	INSERT INTO @tablaSugerido
	(
		Orden,
		ImagenProducto,
		CUV
	)
	SELECT
		Orden,
		ImagenProducto,
		CUVSugerido
	FROM dbo.ProductoSugerido (NOLOCK)
	WHERE CampaniaID = CAST(@CampaniaID AS VARCHAR(6))
	AND charindex(','+@CodigoZona+',',','+ConfiguracionZona+',' )>0 --*/ HD-4289 /*--
	AND CUV = @CUV
	AND Estado = 1

	SELECT
		@Contador = 1,
		@Maximo = COUNT(1)
	FROM @tablaSugerido

	WHILE @Contador <= @Maximo
	BEGIN
		SELECT @CUV = CUV
		FROM @tablaSugerido
		WHERE ID = @Contador

		INSERT INTO @tablaCUV
		(
			CUV,
			Descripcion,
			PrecioCatalogo,
			MarcaID,
			EstaEnRevista,
			TieneStock,
			EsExpoOferta,
			CUVRevista,
			CUVComplemento,
			PaisID,
			CampaniaID,
			CodigoCatalago,
			CodigoProducto,
			IndicadorMontoMinimo,
			DescripcionMarca,
			DescripcionCategoria,
			DescripcionEstrategia,
			ConfiguracionOfertaID,
			TipoOfertaSisID,
			FlagNueva,
			EstrategiaID, --
			CodigoEstrategia, --
			TipoEstrategiaID,
			IndicadorOferta,
			TieneSugerido,
			TieneOfertaRevista,
			PrecioValorizado,
			TieneLanzamientoCatalogoPersonalizado,
			TipoOfertaRevista,
			TipoEstrategiaCodigo,
			EsOfertaIndependiente,
			EstrategiaIDSicc
		)
		EXEC dbo.GetProductoComercialByCuvByFilter @CampaniaID, 1, @CUV, @RegionID, @ZonaID, @CodigoRegion, @CodigoZona

		SET @Contador = @Contador + 1
	END

	SELECT
		t.CUV,
		t.Descripcion,
		t.PrecioCatalogo,
		t.MarcaID,
		t.EstaEnRevista,
		t.TieneStock,
		t.EsExpoOferta,
		t.CUVRevista,
		t.CUVComplemento,
		t.PaisID,
		t.CampaniaID,
		t.CodigoCatalago,
		t.CodigoProducto,
		t.IndicadorMontoMinimo,
		t.DescripcionMarca,
		t.DescripcionCategoria,
		t.DescripcionEstrategia,
		t.ConfiguracionOfertaID,
		t.TipoOfertaSisID,
		t.FlagNueva,
		t.TipoEstrategiaID,
		t.IndicadorOferta,
		ts.ImagenProducto as ImagenProductoSugerido
	FROM @tablaCUV t
	INNER JOIN @tablaSugerido ts
	ON t.CUV = ts.CUV
	WHERE t.TieneStock = 1
	ORDER BY ts.Orden

	SET NOCOUNT OFF
END
GO
USE [BelcorpPanama]
GO
ALTER PROCEDURE dbo.GetProductoSugeridoByCUV_SB2
@CampaniaID INT,
@ConsultoraID INT,
@CUV VARCHAR(20),
@RegionID INT,
@ZonaID INT,
@CodigoRegion VARCHAR(10),
@CodigoZona VARCHAR(10)
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @Contador INT = 0,
			@Maximo INT = 0

	DECLARE @tablaSugerido TABLE
	(
		ID INT IDENTITY(1,1) NOT NULL,
		Orden INT NOT NULL,
		ImagenProducto VARCHAR(150) NULL,
		CUV VARCHAR(20) NOT NULL

		PRIMARY KEY (ID)
	)

	DECLARE @tablaCUV TABLE
	(
		CUV VARCHAR(20),
		Descripcion VARCHAR(100),
		PrecioCatalogo DECIMAL(18,2),
		MarcaID INT,
		EstaEnRevista INT,
		TieneStock INT,
		EsExpoOferta INT,
		CUVRevista VARCHAR(20),
		CUVComplemento VARCHAR(20),
		PaisID INT,
		CampaniaID VARCHAR(6),
		CodigoCatalago VARCHAR(6),
		CodigoProducto VARCHAR(12),
		IndicadorMontoMinimo INT,
		DescripcionMarca VARCHAR(20),
		DescripcionCategoria VARCHAR(20),
		DescripcionEstrategia VARCHAR(200),
		ConfiguracionOfertaID INT,
		TipoOfertaSisID INT,
		FlagNueva INT,
		EstrategiaID INT, --
		CodigoEstrategia Varchar(10), --
		TipoEstrategiaID INT,
		IndicadorOferta BIT,
		TieneSugerido INT,
		TieneOfertaRevista INT,
		PrecioValorizado DECIMAL(18,2),
		TieneLanzamientoCatalogoPersonalizado BIT,
		TipoOfertaRevista VARCHAR(20),
		TipoEstrategiaCodigo VARCHAR(100),
		EsOfertaIndependiente BIT,
		EstrategiaIDSicc INT
	)

	INSERT INTO @tablaSugerido
	(
		Orden,
		ImagenProducto,
		CUV
	)
	SELECT
		Orden,
		ImagenProducto,
		CUVSugerido
	FROM dbo.ProductoSugerido (NOLOCK)
	WHERE CampaniaID = CAST(@CampaniaID AS VARCHAR(6))
	AND charindex(','+@CodigoZona+',',','+ConfiguracionZona+',' )>0 --*/ HD-4289 /*--
	AND CUV = @CUV
	AND Estado = 1

	SELECT
		@Contador = 1,
		@Maximo = COUNT(1)
	FROM @tablaSugerido

	WHILE @Contador <= @Maximo
	BEGIN
		SELECT @CUV = CUV
		FROM @tablaSugerido
		WHERE ID = @Contador

		INSERT INTO @tablaCUV
		(
			CUV,
			Descripcion,
			PrecioCatalogo,
			MarcaID,
			EstaEnRevista,
			TieneStock,
			EsExpoOferta,
			CUVRevista,
			CUVComplemento,
			PaisID,
			CampaniaID,
			CodigoCatalago,
			CodigoProducto,
			IndicadorMontoMinimo,
			DescripcionMarca,
			DescripcionCategoria,
			DescripcionEstrategia,
			ConfiguracionOfertaID,
			TipoOfertaSisID,
			FlagNueva,
			EstrategiaID, --
			CodigoEstrategia, --
			TipoEstrategiaID,
			IndicadorOferta,
			TieneSugerido,
			TieneOfertaRevista,
			PrecioValorizado,
			TieneLanzamientoCatalogoPersonalizado,
			TipoOfertaRevista,
			TipoEstrategiaCodigo,
			EsOfertaIndependiente,
			EstrategiaIDSicc
		)
		EXEC dbo.GetProductoComercialByCuvByFilter @CampaniaID, 1, @CUV, @RegionID, @ZonaID, @CodigoRegion, @CodigoZona

		SET @Contador = @Contador + 1
	END

	SELECT
		t.CUV,
		t.Descripcion,
		t.PrecioCatalogo,
		t.MarcaID,
		t.EstaEnRevista,
		t.TieneStock,
		t.EsExpoOferta,
		t.CUVRevista,
		t.CUVComplemento,
		t.PaisID,
		t.CampaniaID,
		t.CodigoCatalago,
		t.CodigoProducto,
		t.IndicadorMontoMinimo,
		t.DescripcionMarca,
		t.DescripcionCategoria,
		t.DescripcionEstrategia,
		t.ConfiguracionOfertaID,
		t.TipoOfertaSisID,
		t.FlagNueva,
		t.TipoEstrategiaID,
		t.IndicadorOferta,
		ts.ImagenProducto as ImagenProductoSugerido
	FROM @tablaCUV t
	INNER JOIN @tablaSugerido ts
	ON t.CUV = ts.CUV
	WHERE t.TieneStock = 1
	ORDER BY ts.Orden

	SET NOCOUNT OFF
END
GO
USE [BelcorpPeru]
GO
ALTER PROCEDURE dbo.GetProductoSugeridoByCUV_SB2
@CampaniaID INT,
@ConsultoraID INT,
@CUV VARCHAR(20),
@RegionID INT,
@ZonaID INT,
@CodigoRegion VARCHAR(10),
@CodigoZona VARCHAR(10)
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @Contador INT = 0,
			@Maximo INT = 0

	DECLARE @tablaSugerido TABLE
	(
		ID INT IDENTITY(1,1) NOT NULL,
		Orden INT NOT NULL,
		ImagenProducto VARCHAR(150) NULL,
		CUV VARCHAR(20) NOT NULL

		PRIMARY KEY (ID)
	)

	DECLARE @tablaCUV TABLE
	(
		CUV VARCHAR(20),
		Descripcion VARCHAR(100),
		PrecioCatalogo DECIMAL(18,2),
		MarcaID INT,
		EstaEnRevista INT,
		TieneStock INT,
		EsExpoOferta INT,
		CUVRevista VARCHAR(20),
		CUVComplemento VARCHAR(20),
		PaisID INT,
		CampaniaID VARCHAR(6),
		CodigoCatalago VARCHAR(6),
		CodigoProducto VARCHAR(12),
		IndicadorMontoMinimo INT,
		DescripcionMarca VARCHAR(20),
		DescripcionCategoria VARCHAR(20),
		DescripcionEstrategia VARCHAR(200),
		ConfiguracionOfertaID INT,
		TipoOfertaSisID INT,
		FlagNueva INT,
		EstrategiaID INT, --
		CodigoEstrategia Varchar(10), --
		TipoEstrategiaID INT,
		IndicadorOferta BIT,
		TieneSugerido INT,
		TieneOfertaRevista INT,
		PrecioValorizado DECIMAL(18,2),
		TieneLanzamientoCatalogoPersonalizado BIT,
		TipoOfertaRevista VARCHAR(20),
		TipoEstrategiaCodigo VARCHAR(100),
		EsOfertaIndependiente BIT,
		EstrategiaIDSicc INT
	)

	INSERT INTO @tablaSugerido
	(
		Orden,
		ImagenProducto,
		CUV
	)
	SELECT
		Orden,
		ImagenProducto,
		CUVSugerido
	FROM dbo.ProductoSugerido (NOLOCK)
	WHERE CampaniaID = CAST(@CampaniaID AS VARCHAR(6))
	AND charindex(','+@CodigoZona+',',','+ConfiguracionZona+',' )>0 --*/ HD-4289 /*--
	AND CUV = @CUV
	AND Estado = 1

	SELECT
		@Contador = 1,
		@Maximo = COUNT(1)
	FROM @tablaSugerido

	WHILE @Contador <= @Maximo
	BEGIN
		SELECT @CUV = CUV
		FROM @tablaSugerido
		WHERE ID = @Contador

		INSERT INTO @tablaCUV
		(
			CUV,
			Descripcion,
			PrecioCatalogo,
			MarcaID,
			EstaEnRevista,
			TieneStock,
			EsExpoOferta,
			CUVRevista,
			CUVComplemento,
			PaisID,
			CampaniaID,
			CodigoCatalago,
			CodigoProducto,
			IndicadorMontoMinimo,
			DescripcionMarca,
			DescripcionCategoria,
			DescripcionEstrategia,
			ConfiguracionOfertaID,
			TipoOfertaSisID,
			FlagNueva,
			EstrategiaID, --
			CodigoEstrategia, --
			TipoEstrategiaID,
			IndicadorOferta,
			TieneSugerido,
			TieneOfertaRevista,
			PrecioValorizado,
			TieneLanzamientoCatalogoPersonalizado,
			TipoOfertaRevista,
			TipoEstrategiaCodigo,
			EsOfertaIndependiente,
			EstrategiaIDSicc
		)
		EXEC dbo.GetProductoComercialByCuvByFilter @CampaniaID, 1, @CUV, @RegionID, @ZonaID, @CodigoRegion, @CodigoZona

		SET @Contador = @Contador + 1
	END

	SELECT
		t.CUV,
		t.Descripcion,
		t.PrecioCatalogo,
		t.MarcaID,
		t.EstaEnRevista,
		t.TieneStock,
		t.EsExpoOferta,
		t.CUVRevista,
		t.CUVComplemento,
		t.PaisID,
		t.CampaniaID,
		t.CodigoCatalago,
		t.CodigoProducto,
		t.IndicadorMontoMinimo,
		t.DescripcionMarca,
		t.DescripcionCategoria,
		t.DescripcionEstrategia,
		t.ConfiguracionOfertaID,
		t.TipoOfertaSisID,
		t.FlagNueva,
		t.TipoEstrategiaID,
		t.IndicadorOferta,
		ts.ImagenProducto as ImagenProductoSugerido
	FROM @tablaCUV t
	INNER JOIN @tablaSugerido ts
	ON t.CUV = ts.CUV
	WHERE t.TieneStock = 1
	ORDER BY ts.Orden

	SET NOCOUNT OFF
END
GO
USE [BelcorpPuertoRico]
GO
ALTER PROCEDURE dbo.GetProductoSugeridoByCUV_SB2
@CampaniaID INT,
@ConsultoraID INT,
@CUV VARCHAR(20),
@RegionID INT,
@ZonaID INT,
@CodigoRegion VARCHAR(10),
@CodigoZona VARCHAR(10)
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @Contador INT = 0,
			@Maximo INT = 0

	DECLARE @tablaSugerido TABLE
	(
		ID INT IDENTITY(1,1) NOT NULL,
		Orden INT NOT NULL,
		ImagenProducto VARCHAR(150) NULL,
		CUV VARCHAR(20) NOT NULL

		PRIMARY KEY (ID)
	)

	DECLARE @tablaCUV TABLE
	(
		CUV VARCHAR(20),
		Descripcion VARCHAR(100),
		PrecioCatalogo DECIMAL(18,2),
		MarcaID INT,
		EstaEnRevista INT,
		TieneStock INT,
		EsExpoOferta INT,
		CUVRevista VARCHAR(20),
		CUVComplemento VARCHAR(20),
		PaisID INT,
		CampaniaID VARCHAR(6),
		CodigoCatalago VARCHAR(6),
		CodigoProducto VARCHAR(12),
		IndicadorMontoMinimo INT,
		DescripcionMarca VARCHAR(20),
		DescripcionCategoria VARCHAR(20),
		DescripcionEstrategia VARCHAR(200),
		ConfiguracionOfertaID INT,
		TipoOfertaSisID INT,
		FlagNueva INT,
		EstrategiaID INT, --
		CodigoEstrategia Varchar(10), --
		TipoEstrategiaID INT,
		IndicadorOferta BIT,
		TieneSugerido INT,
		TieneOfertaRevista INT,
		PrecioValorizado DECIMAL(18,2),
		TieneLanzamientoCatalogoPersonalizado BIT,
		TipoOfertaRevista VARCHAR(20),
		TipoEstrategiaCodigo VARCHAR(100),
		EsOfertaIndependiente BIT,
		EstrategiaIDSicc INT
	)

	INSERT INTO @tablaSugerido
	(
		Orden,
		ImagenProducto,
		CUV
	)
	SELECT
		Orden,
		ImagenProducto,
		CUVSugerido
	FROM dbo.ProductoSugerido (NOLOCK)
	WHERE CampaniaID = CAST(@CampaniaID AS VARCHAR(6))
	AND charindex(','+@CodigoZona+',',','+ConfiguracionZona+',' )>0 --*/ HD-4289 /*--
	AND CUV = @CUV
	AND Estado = 1

	SELECT
		@Contador = 1,
		@Maximo = COUNT(1)
	FROM @tablaSugerido

	WHILE @Contador <= @Maximo
	BEGIN
		SELECT @CUV = CUV
		FROM @tablaSugerido
		WHERE ID = @Contador

		INSERT INTO @tablaCUV
		(
			CUV,
			Descripcion,
			PrecioCatalogo,
			MarcaID,
			EstaEnRevista,
			TieneStock,
			EsExpoOferta,
			CUVRevista,
			CUVComplemento,
			PaisID,
			CampaniaID,
			CodigoCatalago,
			CodigoProducto,
			IndicadorMontoMinimo,
			DescripcionMarca,
			DescripcionCategoria,
			DescripcionEstrategia,
			ConfiguracionOfertaID,
			TipoOfertaSisID,
			FlagNueva,
			EstrategiaID, --
			CodigoEstrategia, --
			TipoEstrategiaID,
			IndicadorOferta,
			TieneSugerido,
			TieneOfertaRevista,
			PrecioValorizado,
			TieneLanzamientoCatalogoPersonalizado,
			TipoOfertaRevista,
			TipoEstrategiaCodigo,
			EsOfertaIndependiente,
			EstrategiaIDSicc
		)
		EXEC dbo.GetProductoComercialByCuvByFilter @CampaniaID, 1, @CUV, @RegionID, @ZonaID, @CodigoRegion, @CodigoZona

		SET @Contador = @Contador + 1
	END

	SELECT
		t.CUV,
		t.Descripcion,
		t.PrecioCatalogo,
		t.MarcaID,
		t.EstaEnRevista,
		t.TieneStock,
		t.EsExpoOferta,
		t.CUVRevista,
		t.CUVComplemento,
		t.PaisID,
		t.CampaniaID,
		t.CodigoCatalago,
		t.CodigoProducto,
		t.IndicadorMontoMinimo,
		t.DescripcionMarca,
		t.DescripcionCategoria,
		t.DescripcionEstrategia,
		t.ConfiguracionOfertaID,
		t.TipoOfertaSisID,
		t.FlagNueva,
		t.TipoEstrategiaID,
		t.IndicadorOferta,
		ts.ImagenProducto as ImagenProductoSugerido
	FROM @tablaCUV t
	INNER JOIN @tablaSugerido ts
	ON t.CUV = ts.CUV
	WHERE t.TieneStock = 1
	ORDER BY ts.Orden

	SET NOCOUNT OFF
END
GO
USE [BelcorpSalvador]
GO
ALTER PROCEDURE dbo.GetProductoSugeridoByCUV_SB2
@CampaniaID INT,
@ConsultoraID INT,
@CUV VARCHAR(20),
@RegionID INT,
@ZonaID INT,
@CodigoRegion VARCHAR(10),
@CodigoZona VARCHAR(10)
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @Contador INT = 0,
			@Maximo INT = 0

	DECLARE @tablaSugerido TABLE
	(
		ID INT IDENTITY(1,1) NOT NULL,
		Orden INT NOT NULL,
		ImagenProducto VARCHAR(150) NULL,
		CUV VARCHAR(20) NOT NULL

		PRIMARY KEY (ID)
	)

	DECLARE @tablaCUV TABLE
	(
		CUV VARCHAR(20),
		Descripcion VARCHAR(100),
		PrecioCatalogo DECIMAL(18,2),
		MarcaID INT,
		EstaEnRevista INT,
		TieneStock INT,
		EsExpoOferta INT,
		CUVRevista VARCHAR(20),
		CUVComplemento VARCHAR(20),
		PaisID INT,
		CampaniaID VARCHAR(6),
		CodigoCatalago VARCHAR(6),
		CodigoProducto VARCHAR(12),
		IndicadorMontoMinimo INT,
		DescripcionMarca VARCHAR(20),
		DescripcionCategoria VARCHAR(20),
		DescripcionEstrategia VARCHAR(200),
		ConfiguracionOfertaID INT,
		TipoOfertaSisID INT,
		FlagNueva INT,
		EstrategiaID INT, --
		CodigoEstrategia Varchar(10), --
		TipoEstrategiaID INT,
		IndicadorOferta BIT,
		TieneSugerido INT,
		TieneOfertaRevista INT,
		PrecioValorizado DECIMAL(18,2),
		TieneLanzamientoCatalogoPersonalizado BIT,
		TipoOfertaRevista VARCHAR(20),
		TipoEstrategiaCodigo VARCHAR(100),
		EsOfertaIndependiente BIT,
		EstrategiaIDSicc INT
	)

	INSERT INTO @tablaSugerido
	(
		Orden,
		ImagenProducto,
		CUV
	)
	SELECT
		Orden,
		ImagenProducto,
		CUVSugerido
	FROM dbo.ProductoSugerido (NOLOCK)
	WHERE CampaniaID = CAST(@CampaniaID AS VARCHAR(6))
	AND charindex(','+@CodigoZona+',',','+ConfiguracionZona+',' )>0 --*/ HD-4289 /*--
	AND CUV = @CUV
	AND Estado = 1

	SELECT
		@Contador = 1,
		@Maximo = COUNT(1)
	FROM @tablaSugerido

	WHILE @Contador <= @Maximo
	BEGIN
		SELECT @CUV = CUV
		FROM @tablaSugerido
		WHERE ID = @Contador

		INSERT INTO @tablaCUV
		(
			CUV,
			Descripcion,
			PrecioCatalogo,
			MarcaID,
			EstaEnRevista,
			TieneStock,
			EsExpoOferta,
			CUVRevista,
			CUVComplemento,
			PaisID,
			CampaniaID,
			CodigoCatalago,
			CodigoProducto,
			IndicadorMontoMinimo,
			DescripcionMarca,
			DescripcionCategoria,
			DescripcionEstrategia,
			ConfiguracionOfertaID,
			TipoOfertaSisID,
			FlagNueva,
			EstrategiaID, --
			CodigoEstrategia, --
			TipoEstrategiaID,
			IndicadorOferta,
			TieneSugerido,
			TieneOfertaRevista,
			PrecioValorizado,
			TieneLanzamientoCatalogoPersonalizado,
			TipoOfertaRevista,
			TipoEstrategiaCodigo,
			EsOfertaIndependiente,
			EstrategiaIDSicc
		)
		EXEC dbo.GetProductoComercialByCuvByFilter @CampaniaID, 1, @CUV, @RegionID, @ZonaID, @CodigoRegion, @CodigoZona

		SET @Contador = @Contador + 1
	END

	SELECT
		t.CUV,
		t.Descripcion,
		t.PrecioCatalogo,
		t.MarcaID,
		t.EstaEnRevista,
		t.TieneStock,
		t.EsExpoOferta,
		t.CUVRevista,
		t.CUVComplemento,
		t.PaisID,
		t.CampaniaID,
		t.CodigoCatalago,
		t.CodigoProducto,
		t.IndicadorMontoMinimo,
		t.DescripcionMarca,
		t.DescripcionCategoria,
		t.DescripcionEstrategia,
		t.ConfiguracionOfertaID,
		t.TipoOfertaSisID,
		t.FlagNueva,
		t.TipoEstrategiaID,
		t.IndicadorOferta,
		ts.ImagenProducto as ImagenProductoSugerido
	FROM @tablaCUV t
	INNER JOIN @tablaSugerido ts
	ON t.CUV = ts.CUV
	WHERE t.TieneStock = 1
	ORDER BY ts.Orden

	SET NOCOUNT OFF
END