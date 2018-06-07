GO
USE BelcorpPeru
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EstrategiaTemporalInsertarEstrategiaMasivo') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.EstrategiaTemporalInsertarEstrategiaMasivo
GO
CREATE PROCEDURE EstrategiaTemporalInsertarEstrategiaMasivo
(
	@NroLote int = 0,
	@NroLoteFinal int = 0 out
)
AS
BEGIN
BEGIN TRANSACTION

BEGIN TRY
	set @NroLoteFinal = 0
	set @NroLote = isnull(@NroLote, 0)
	DECLARE @FechaGeneral DATETIME
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

	-- Insertar EstrategiaProducto
	INSERT INTO EstrategiaProducto
	(
		 EstrategiaId
		, Campania
		, CUV
		, CUV2
		, CodigoEstrategia
		, Grupo
		, Orden
		, SAP
		, Cantidad
		, Precio
		, PrecioValorizado
		, Digitable
		, FactorCuadre
		, NombreProducto
		, IdMarca
	)
	SELECT
		0
		, Campania
		, Cuv
		, CuvPadre
		, CodigoEstrategia
		, Grupo
		, Orden
		, CodigoSap
		, Cantidad
		, PrecioUnitario
		, PrecioValorizado
		, Digitable
		, FactorCuadre
		, Descripcion
		, IdMarca
	FROM EstrategiaProductoTemporal
	where NumeroLote = @NroLote
	-- Insertar Estrategia
	INSERT INTO Estrategia
	(
		TipoEstrategiaID
		,CampaniaID
		,ImagenURL
		,LimiteVenta
		,DescripcionCUV2
		,CUV2
		,FlagCEP, FlagCEP2 ,TextoLibre ,FlagTextoLibre
		,CampaniaIDFin, NumeroPedido, Activo
		,FlagDescripcion, CUV
		, EtiquetaID, EtiquetaID2
		,Cantidad, FlagCantidad, Zona, Limite, Orden, ColorFondo

		,FlagEstrella, CodigoEstrategia, TieneVariedad
		,Precio, Precio2, PrecioPublico, Ganancia, Niveles
		,UsuarioCreacion, FechaCreacion, UsuarioModIFicacion, FechaModIFicacion
	)
	SELECT
		dbo.fnGetTipoEstrategiaId(CodigoTipoEstrategia) as TipoEstrategiaID
		,CampaniaId
		,FotoProducto01
		,LimiteVenta
		,Descripcion
		,CUV
		,0, 1,'',0
		,0, 0, 0
		,1, ''
		, 0, dbo.fnGetTipoEstrategiaId(CodigoTipoEstrategia) as EtiquetaID2
		,0, 0, '', NULL, 0 , ''
		,OfertaUltimoMinuto, CodigoEstrategia, TieneVariedad
		,PrecioTachado, PrecioOferta, PrecioPublico, Ganancia, Niveles
		,UsuarioCreacion,@FechaGeneral,UsuarioCreacion, @FechaGeneral
	FROM EstrategiaTemporal
	where NumeroLote = @NroLote

	-- Actualizar EstrategiaID
	UPDATE EP
	SET EP.EstrategiaID = E.EstrategiaID
	FROM EstrategiaProducto EP
		INNER JOIN  Estrategia E
			ON E.CampaniaId = EP.Campania
			AND E.CUV2 = EP.CUV2
		INNER JOIN TipoEstrategia te
			ON te.TipoEstrategiaID = E.TipoEstrategiaID
	WHERE EXISTS(SELECT ET.CampaniaId FROM EstrategiaTemporal ET  WHERE ET.CampaniaId = E.CampaniaId AND ET.NumeroLote = @NroLote and ET.CodigoTipoEstrategia = te.Codigo)
		AND ISNULL(EP.EstrategiaID, 0) = 0
	set @NroLoteFinal = @NroLote

	COMMIT TRANSACTION
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
END CATCH
END
GO


GO
USE BelcorpMexico
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EstrategiaTemporalInsertarEstrategiaMasivo') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.EstrategiaTemporalInsertarEstrategiaMasivo
GO
CREATE PROCEDURE EstrategiaTemporalInsertarEstrategiaMasivo
(
	@NroLote int = 0,
	@NroLoteFinal int = 0 out
)
AS
BEGIN
BEGIN TRANSACTION

BEGIN TRY
	set @NroLoteFinal = 0
	set @NroLote = isnull(@NroLote, 0)
	DECLARE @FechaGeneral DATETIME
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

	-- Insertar EstrategiaProducto
	INSERT INTO EstrategiaProducto
	(
		 EstrategiaId
		, Campania
		, CUV
		, CUV2
		, CodigoEstrategia
		, Grupo
		, Orden
		, SAP
		, Cantidad
		, Precio
		, PrecioValorizado
		, Digitable
		, FactorCuadre
		, NombreProducto
		, IdMarca
	)
	SELECT
		0
		, Campania
		, Cuv
		, CuvPadre
		, CodigoEstrategia
		, Grupo
		, Orden
		, CodigoSap
		, Cantidad
		, PrecioUnitario
		, PrecioValorizado
		, Digitable
		, FactorCuadre
		, Descripcion
		, IdMarca
	FROM EstrategiaProductoTemporal
	where NumeroLote = @NroLote
	-- Insertar Estrategia
	INSERT INTO Estrategia
	(
		TipoEstrategiaID
		,CampaniaID
		,ImagenURL
		,LimiteVenta
		,DescripcionCUV2
		,CUV2
		,FlagCEP, FlagCEP2 ,TextoLibre ,FlagTextoLibre
		,CampaniaIDFin, NumeroPedido, Activo
		,FlagDescripcion, CUV
		, EtiquetaID, EtiquetaID2
		,Cantidad, FlagCantidad, Zona, Limite, Orden, ColorFondo

		,FlagEstrella, CodigoEstrategia, TieneVariedad
		,Precio, Precio2, PrecioPublico, Ganancia, Niveles
		,UsuarioCreacion, FechaCreacion, UsuarioModIFicacion, FechaModIFicacion
	)
	SELECT
		dbo.fnGetTipoEstrategiaId(CodigoTipoEstrategia) as TipoEstrategiaID
		,CampaniaId
		,FotoProducto01
		,LimiteVenta
		,Descripcion
		,CUV
		,0, 1,'',0
		,0, 0, 0
		,1, ''
		, 0, dbo.fnGetTipoEstrategiaId(CodigoTipoEstrategia) as EtiquetaID2
		,0, 0, '', NULL, 0 , ''
		,OfertaUltimoMinuto, CodigoEstrategia, TieneVariedad
		,PrecioTachado, PrecioOferta, PrecioPublico, Ganancia, Niveles
		,UsuarioCreacion,@FechaGeneral,UsuarioCreacion, @FechaGeneral
	FROM EstrategiaTemporal
	where NumeroLote = @NroLote

	-- Actualizar EstrategiaID
	UPDATE EP
	SET EP.EstrategiaID = E.EstrategiaID
	FROM EstrategiaProducto EP
		INNER JOIN  Estrategia E
			ON E.CampaniaId = EP.Campania
			AND E.CUV2 = EP.CUV2
		INNER JOIN TipoEstrategia te
			ON te.TipoEstrategiaID = E.TipoEstrategiaID
	WHERE EXISTS(SELECT ET.CampaniaId FROM EstrategiaTemporal ET  WHERE ET.CampaniaId = E.CampaniaId AND ET.NumeroLote = @NroLote and ET.CodigoTipoEstrategia = te.Codigo)
		AND ISNULL(EP.EstrategiaID, 0) = 0
	set @NroLoteFinal = @NroLote

	COMMIT TRANSACTION
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
END CATCH
END
GO


GO
USE BelcorpColombia
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EstrategiaTemporalInsertarEstrategiaMasivo') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.EstrategiaTemporalInsertarEstrategiaMasivo
GO
CREATE PROCEDURE EstrategiaTemporalInsertarEstrategiaMasivo
(
	@NroLote int = 0,
	@NroLoteFinal int = 0 out
)
AS
BEGIN
BEGIN TRANSACTION

BEGIN TRY
	set @NroLoteFinal = 0
	set @NroLote = isnull(@NroLote, 0)
	DECLARE @FechaGeneral DATETIME
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

	-- Insertar EstrategiaProducto
	INSERT INTO EstrategiaProducto
	(
		 EstrategiaId
		, Campania
		, CUV
		, CUV2
		, CodigoEstrategia
		, Grupo
		, Orden
		, SAP
		, Cantidad
		, Precio
		, PrecioValorizado
		, Digitable
		, FactorCuadre
		, NombreProducto
		, IdMarca
	)
	SELECT
		0
		, Campania
		, Cuv
		, CuvPadre
		, CodigoEstrategia
		, Grupo
		, Orden
		, CodigoSap
		, Cantidad
		, PrecioUnitario
		, PrecioValorizado
		, Digitable
		, FactorCuadre
		, Descripcion
		, IdMarca
	FROM EstrategiaProductoTemporal
	where NumeroLote = @NroLote
	-- Insertar Estrategia
	INSERT INTO Estrategia
	(
		TipoEstrategiaID
		,CampaniaID
		,ImagenURL
		,LimiteVenta
		,DescripcionCUV2
		,CUV2
		,FlagCEP, FlagCEP2 ,TextoLibre ,FlagTextoLibre
		,CampaniaIDFin, NumeroPedido, Activo
		,FlagDescripcion, CUV
		, EtiquetaID, EtiquetaID2
		,Cantidad, FlagCantidad, Zona, Limite, Orden, ColorFondo

		,FlagEstrella, CodigoEstrategia, TieneVariedad
		,Precio, Precio2, PrecioPublico, Ganancia, Niveles
		,UsuarioCreacion, FechaCreacion, UsuarioModIFicacion, FechaModIFicacion
	)
	SELECT
		dbo.fnGetTipoEstrategiaId(CodigoTipoEstrategia) as TipoEstrategiaID
		,CampaniaId
		,FotoProducto01
		,LimiteVenta
		,Descripcion
		,CUV
		,0, 1,'',0
		,0, 0, 0
		,1, ''
		, 0, dbo.fnGetTipoEstrategiaId(CodigoTipoEstrategia) as EtiquetaID2
		,0, 0, '', NULL, 0 , ''
		,OfertaUltimoMinuto, CodigoEstrategia, TieneVariedad
		,PrecioTachado, PrecioOferta, PrecioPublico, Ganancia, Niveles
		,UsuarioCreacion,@FechaGeneral,UsuarioCreacion, @FechaGeneral
	FROM EstrategiaTemporal
	where NumeroLote = @NroLote

	-- Actualizar EstrategiaID
	UPDATE EP
	SET EP.EstrategiaID = E.EstrategiaID
	FROM EstrategiaProducto EP
		INNER JOIN  Estrategia E
			ON E.CampaniaId = EP.Campania
			AND E.CUV2 = EP.CUV2
		INNER JOIN TipoEstrategia te
			ON te.TipoEstrategiaID = E.TipoEstrategiaID
	WHERE EXISTS(SELECT ET.CampaniaId FROM EstrategiaTemporal ET  WHERE ET.CampaniaId = E.CampaniaId AND ET.NumeroLote = @NroLote and ET.CodigoTipoEstrategia = te.Codigo)
		AND ISNULL(EP.EstrategiaID, 0) = 0
	set @NroLoteFinal = @NroLote

	COMMIT TRANSACTION
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
END CATCH
END
GO


GO
USE BelcorpSalvador
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EstrategiaTemporalInsertarEstrategiaMasivo') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.EstrategiaTemporalInsertarEstrategiaMasivo
GO
CREATE PROCEDURE EstrategiaTemporalInsertarEstrategiaMasivo
(
	@NroLote int = 0,
	@NroLoteFinal int = 0 out
)
AS
BEGIN
BEGIN TRANSACTION

BEGIN TRY
	set @NroLoteFinal = 0
	set @NroLote = isnull(@NroLote, 0)
	DECLARE @FechaGeneral DATETIME
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

	-- Insertar EstrategiaProducto
	INSERT INTO EstrategiaProducto
	(
		 EstrategiaId
		, Campania
		, CUV
		, CUV2
		, CodigoEstrategia
		, Grupo
		, Orden
		, SAP
		, Cantidad
		, Precio
		, PrecioValorizado
		, Digitable
		, FactorCuadre
		, NombreProducto
		, IdMarca
	)
	SELECT
		0
		, Campania
		, Cuv
		, CuvPadre
		, CodigoEstrategia
		, Grupo
		, Orden
		, CodigoSap
		, Cantidad
		, PrecioUnitario
		, PrecioValorizado
		, Digitable
		, FactorCuadre
		, Descripcion
		, IdMarca
	FROM EstrategiaProductoTemporal
	where NumeroLote = @NroLote
	-- Insertar Estrategia
	INSERT INTO Estrategia
	(
		TipoEstrategiaID
		,CampaniaID
		,ImagenURL
		,LimiteVenta
		,DescripcionCUV2
		,CUV2
		,FlagCEP, FlagCEP2 ,TextoLibre ,FlagTextoLibre
		,CampaniaIDFin, NumeroPedido, Activo
		,FlagDescripcion, CUV
		, EtiquetaID, EtiquetaID2
		,Cantidad, FlagCantidad, Zona, Limite, Orden, ColorFondo

		,FlagEstrella, CodigoEstrategia, TieneVariedad
		,Precio, Precio2, PrecioPublico, Ganancia, Niveles
		,UsuarioCreacion, FechaCreacion, UsuarioModIFicacion, FechaModIFicacion
	)
	SELECT
		dbo.fnGetTipoEstrategiaId(CodigoTipoEstrategia) as TipoEstrategiaID
		,CampaniaId
		,FotoProducto01
		,LimiteVenta
		,Descripcion
		,CUV
		,0, 1,'',0
		,0, 0, 0
		,1, ''
		, 0, dbo.fnGetTipoEstrategiaId(CodigoTipoEstrategia) as EtiquetaID2
		,0, 0, '', NULL, 0 , ''
		,OfertaUltimoMinuto, CodigoEstrategia, TieneVariedad
		,PrecioTachado, PrecioOferta, PrecioPublico, Ganancia, Niveles
		,UsuarioCreacion,@FechaGeneral,UsuarioCreacion, @FechaGeneral
	FROM EstrategiaTemporal
	where NumeroLote = @NroLote

	-- Actualizar EstrategiaID
	UPDATE EP
	SET EP.EstrategiaID = E.EstrategiaID
	FROM EstrategiaProducto EP
		INNER JOIN  Estrategia E
			ON E.CampaniaId = EP.Campania
			AND E.CUV2 = EP.CUV2
		INNER JOIN TipoEstrategia te
			ON te.TipoEstrategiaID = E.TipoEstrategiaID
	WHERE EXISTS(SELECT ET.CampaniaId FROM EstrategiaTemporal ET  WHERE ET.CampaniaId = E.CampaniaId AND ET.NumeroLote = @NroLote and ET.CodigoTipoEstrategia = te.Codigo)
		AND ISNULL(EP.EstrategiaID, 0) = 0
	set @NroLoteFinal = @NroLote

	COMMIT TRANSACTION
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
END CATCH
END
GO


GO
USE BelcorpPuertoRico
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EstrategiaTemporalInsertarEstrategiaMasivo') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.EstrategiaTemporalInsertarEstrategiaMasivo
GO
CREATE PROCEDURE EstrategiaTemporalInsertarEstrategiaMasivo
(
	@NroLote int = 0,
	@NroLoteFinal int = 0 out
)
AS
BEGIN
BEGIN TRANSACTION

BEGIN TRY
	set @NroLoteFinal = 0
	set @NroLote = isnull(@NroLote, 0)
	DECLARE @FechaGeneral DATETIME
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

	-- Insertar EstrategiaProducto
	INSERT INTO EstrategiaProducto
	(
		 EstrategiaId
		, Campania
		, CUV
		, CUV2
		, CodigoEstrategia
		, Grupo
		, Orden
		, SAP
		, Cantidad
		, Precio
		, PrecioValorizado
		, Digitable
		, FactorCuadre
		, NombreProducto
		, IdMarca
	)
	SELECT
		0
		, Campania
		, Cuv
		, CuvPadre
		, CodigoEstrategia
		, Grupo
		, Orden
		, CodigoSap
		, Cantidad
		, PrecioUnitario
		, PrecioValorizado
		, Digitable
		, FactorCuadre
		, Descripcion
		, IdMarca
	FROM EstrategiaProductoTemporal
	where NumeroLote = @NroLote
	-- Insertar Estrategia
	INSERT INTO Estrategia
	(
		TipoEstrategiaID
		,CampaniaID
		,ImagenURL
		,LimiteVenta
		,DescripcionCUV2
		,CUV2
		,FlagCEP, FlagCEP2 ,TextoLibre ,FlagTextoLibre
		,CampaniaIDFin, NumeroPedido, Activo
		,FlagDescripcion, CUV
		, EtiquetaID, EtiquetaID2
		,Cantidad, FlagCantidad, Zona, Limite, Orden, ColorFondo

		,FlagEstrella, CodigoEstrategia, TieneVariedad
		,Precio, Precio2, PrecioPublico, Ganancia, Niveles
		,UsuarioCreacion, FechaCreacion, UsuarioModIFicacion, FechaModIFicacion
	)
	SELECT
		dbo.fnGetTipoEstrategiaId(CodigoTipoEstrategia) as TipoEstrategiaID
		,CampaniaId
		,FotoProducto01
		,LimiteVenta
		,Descripcion
		,CUV
		,0, 1,'',0
		,0, 0, 0
		,1, ''
		, 0, dbo.fnGetTipoEstrategiaId(CodigoTipoEstrategia) as EtiquetaID2
		,0, 0, '', NULL, 0 , ''
		,OfertaUltimoMinuto, CodigoEstrategia, TieneVariedad
		,PrecioTachado, PrecioOferta, PrecioPublico, Ganancia, Niveles
		,UsuarioCreacion,@FechaGeneral,UsuarioCreacion, @FechaGeneral
	FROM EstrategiaTemporal
	where NumeroLote = @NroLote

	-- Actualizar EstrategiaID
	UPDATE EP
	SET EP.EstrategiaID = E.EstrategiaID
	FROM EstrategiaProducto EP
		INNER JOIN  Estrategia E
			ON E.CampaniaId = EP.Campania
			AND E.CUV2 = EP.CUV2
		INNER JOIN TipoEstrategia te
			ON te.TipoEstrategiaID = E.TipoEstrategiaID
	WHERE EXISTS(SELECT ET.CampaniaId FROM EstrategiaTemporal ET  WHERE ET.CampaniaId = E.CampaniaId AND ET.NumeroLote = @NroLote and ET.CodigoTipoEstrategia = te.Codigo)
		AND ISNULL(EP.EstrategiaID, 0) = 0
	set @NroLoteFinal = @NroLote

	COMMIT TRANSACTION
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
END CATCH
END
GO


GO
USE BelcorpPanama
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EstrategiaTemporalInsertarEstrategiaMasivo') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.EstrategiaTemporalInsertarEstrategiaMasivo
GO
CREATE PROCEDURE EstrategiaTemporalInsertarEstrategiaMasivo
(
	@NroLote int = 0,
	@NroLoteFinal int = 0 out
)
AS
BEGIN
BEGIN TRANSACTION

BEGIN TRY
	set @NroLoteFinal = 0
	set @NroLote = isnull(@NroLote, 0)
	DECLARE @FechaGeneral DATETIME
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

	-- Insertar EstrategiaProducto
	INSERT INTO EstrategiaProducto
	(
		 EstrategiaId
		, Campania
		, CUV
		, CUV2
		, CodigoEstrategia
		, Grupo
		, Orden
		, SAP
		, Cantidad
		, Precio
		, PrecioValorizado
		, Digitable
		, FactorCuadre
		, NombreProducto
		, IdMarca
	)
	SELECT
		0
		, Campania
		, Cuv
		, CuvPadre
		, CodigoEstrategia
		, Grupo
		, Orden
		, CodigoSap
		, Cantidad
		, PrecioUnitario
		, PrecioValorizado
		, Digitable
		, FactorCuadre
		, Descripcion
		, IdMarca
	FROM EstrategiaProductoTemporal
	where NumeroLote = @NroLote
	-- Insertar Estrategia
	INSERT INTO Estrategia
	(
		TipoEstrategiaID
		,CampaniaID
		,ImagenURL
		,LimiteVenta
		,DescripcionCUV2
		,CUV2
		,FlagCEP, FlagCEP2 ,TextoLibre ,FlagTextoLibre
		,CampaniaIDFin, NumeroPedido, Activo
		,FlagDescripcion, CUV
		, EtiquetaID, EtiquetaID2
		,Cantidad, FlagCantidad, Zona, Limite, Orden, ColorFondo

		,FlagEstrella, CodigoEstrategia, TieneVariedad
		,Precio, Precio2, PrecioPublico, Ganancia, Niveles
		,UsuarioCreacion, FechaCreacion, UsuarioModIFicacion, FechaModIFicacion
	)
	SELECT
		dbo.fnGetTipoEstrategiaId(CodigoTipoEstrategia) as TipoEstrategiaID
		,CampaniaId
		,FotoProducto01
		,LimiteVenta
		,Descripcion
		,CUV
		,0, 1,'',0
		,0, 0, 0
		,1, ''
		, 0, dbo.fnGetTipoEstrategiaId(CodigoTipoEstrategia) as EtiquetaID2
		,0, 0, '', NULL, 0 , ''
		,OfertaUltimoMinuto, CodigoEstrategia, TieneVariedad
		,PrecioTachado, PrecioOferta, PrecioPublico, Ganancia, Niveles
		,UsuarioCreacion,@FechaGeneral,UsuarioCreacion, @FechaGeneral
	FROM EstrategiaTemporal
	where NumeroLote = @NroLote

	-- Actualizar EstrategiaID
	UPDATE EP
	SET EP.EstrategiaID = E.EstrategiaID
	FROM EstrategiaProducto EP
		INNER JOIN  Estrategia E
			ON E.CampaniaId = EP.Campania
			AND E.CUV2 = EP.CUV2
		INNER JOIN TipoEstrategia te
			ON te.TipoEstrategiaID = E.TipoEstrategiaID
	WHERE EXISTS(SELECT ET.CampaniaId FROM EstrategiaTemporal ET  WHERE ET.CampaniaId = E.CampaniaId AND ET.NumeroLote = @NroLote and ET.CodigoTipoEstrategia = te.Codigo)
		AND ISNULL(EP.EstrategiaID, 0) = 0
	set @NroLoteFinal = @NroLote

	COMMIT TRANSACTION
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
END CATCH
END
GO


GO
USE BelcorpGuatemala
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EstrategiaTemporalInsertarEstrategiaMasivo') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.EstrategiaTemporalInsertarEstrategiaMasivo
GO
CREATE PROCEDURE EstrategiaTemporalInsertarEstrategiaMasivo
(
	@NroLote int = 0,
	@NroLoteFinal int = 0 out
)
AS
BEGIN
BEGIN TRANSACTION

BEGIN TRY
	set @NroLoteFinal = 0
	set @NroLote = isnull(@NroLote, 0)
	DECLARE @FechaGeneral DATETIME
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

	-- Insertar EstrategiaProducto
	INSERT INTO EstrategiaProducto
	(
		 EstrategiaId
		, Campania
		, CUV
		, CUV2
		, CodigoEstrategia
		, Grupo
		, Orden
		, SAP
		, Cantidad
		, Precio
		, PrecioValorizado
		, Digitable
		, FactorCuadre
		, NombreProducto
		, IdMarca
	)
	SELECT
		0
		, Campania
		, Cuv
		, CuvPadre
		, CodigoEstrategia
		, Grupo
		, Orden
		, CodigoSap
		, Cantidad
		, PrecioUnitario
		, PrecioValorizado
		, Digitable
		, FactorCuadre
		, Descripcion
		, IdMarca
	FROM EstrategiaProductoTemporal
	where NumeroLote = @NroLote
	-- Insertar Estrategia
	INSERT INTO Estrategia
	(
		TipoEstrategiaID
		,CampaniaID
		,ImagenURL
		,LimiteVenta
		,DescripcionCUV2
		,CUV2
		,FlagCEP, FlagCEP2 ,TextoLibre ,FlagTextoLibre
		,CampaniaIDFin, NumeroPedido, Activo
		,FlagDescripcion, CUV
		, EtiquetaID, EtiquetaID2
		,Cantidad, FlagCantidad, Zona, Limite, Orden, ColorFondo

		,FlagEstrella, CodigoEstrategia, TieneVariedad
		,Precio, Precio2, PrecioPublico, Ganancia, Niveles
		,UsuarioCreacion, FechaCreacion, UsuarioModIFicacion, FechaModIFicacion
	)
	SELECT
		dbo.fnGetTipoEstrategiaId(CodigoTipoEstrategia) as TipoEstrategiaID
		,CampaniaId
		,FotoProducto01
		,LimiteVenta
		,Descripcion
		,CUV
		,0, 1,'',0
		,0, 0, 0
		,1, ''
		, 0, dbo.fnGetTipoEstrategiaId(CodigoTipoEstrategia) as EtiquetaID2
		,0, 0, '', NULL, 0 , ''
		,OfertaUltimoMinuto, CodigoEstrategia, TieneVariedad
		,PrecioTachado, PrecioOferta, PrecioPublico, Ganancia, Niveles
		,UsuarioCreacion,@FechaGeneral,UsuarioCreacion, @FechaGeneral
	FROM EstrategiaTemporal
	where NumeroLote = @NroLote

	-- Actualizar EstrategiaID
	UPDATE EP
	SET EP.EstrategiaID = E.EstrategiaID
	FROM EstrategiaProducto EP
		INNER JOIN  Estrategia E
			ON E.CampaniaId = EP.Campania
			AND E.CUV2 = EP.CUV2
		INNER JOIN TipoEstrategia te
			ON te.TipoEstrategiaID = E.TipoEstrategiaID
	WHERE EXISTS(SELECT ET.CampaniaId FROM EstrategiaTemporal ET  WHERE ET.CampaniaId = E.CampaniaId AND ET.NumeroLote = @NroLote and ET.CodigoTipoEstrategia = te.Codigo)
		AND ISNULL(EP.EstrategiaID, 0) = 0
	set @NroLoteFinal = @NroLote

	COMMIT TRANSACTION
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
END CATCH
END
GO


GO
USE BelcorpEcuador
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EstrategiaTemporalInsertarEstrategiaMasivo') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.EstrategiaTemporalInsertarEstrategiaMasivo
GO
CREATE PROCEDURE EstrategiaTemporalInsertarEstrategiaMasivo
(
	@NroLote int = 0,
	@NroLoteFinal int = 0 out
)
AS
BEGIN
BEGIN TRANSACTION

BEGIN TRY
	set @NroLoteFinal = 0
	set @NroLote = isnull(@NroLote, 0)
	DECLARE @FechaGeneral DATETIME
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

	-- Insertar EstrategiaProducto
	INSERT INTO EstrategiaProducto
	(
		 EstrategiaId
		, Campania
		, CUV
		, CUV2
		, CodigoEstrategia
		, Grupo
		, Orden
		, SAP
		, Cantidad
		, Precio
		, PrecioValorizado
		, Digitable
		, FactorCuadre
		, NombreProducto
		, IdMarca
	)
	SELECT
		0
		, Campania
		, Cuv
		, CuvPadre
		, CodigoEstrategia
		, Grupo
		, Orden
		, CodigoSap
		, Cantidad
		, PrecioUnitario
		, PrecioValorizado
		, Digitable
		, FactorCuadre
		, Descripcion
		, IdMarca
	FROM EstrategiaProductoTemporal
	where NumeroLote = @NroLote
	-- Insertar Estrategia
	INSERT INTO Estrategia
	(
		TipoEstrategiaID
		,CampaniaID
		,ImagenURL
		,LimiteVenta
		,DescripcionCUV2
		,CUV2
		,FlagCEP, FlagCEP2 ,TextoLibre ,FlagTextoLibre
		,CampaniaIDFin, NumeroPedido, Activo
		,FlagDescripcion, CUV
		, EtiquetaID, EtiquetaID2
		,Cantidad, FlagCantidad, Zona, Limite, Orden, ColorFondo

		,FlagEstrella, CodigoEstrategia, TieneVariedad
		,Precio, Precio2, PrecioPublico, Ganancia, Niveles
		,UsuarioCreacion, FechaCreacion, UsuarioModIFicacion, FechaModIFicacion
	)
	SELECT
		dbo.fnGetTipoEstrategiaId(CodigoTipoEstrategia) as TipoEstrategiaID
		,CampaniaId
		,FotoProducto01
		,LimiteVenta
		,Descripcion
		,CUV
		,0, 1,'',0
		,0, 0, 0
		,1, ''
		, 0, dbo.fnGetTipoEstrategiaId(CodigoTipoEstrategia) as EtiquetaID2
		,0, 0, '', NULL, 0 , ''
		,OfertaUltimoMinuto, CodigoEstrategia, TieneVariedad
		,PrecioTachado, PrecioOferta, PrecioPublico, Ganancia, Niveles
		,UsuarioCreacion,@FechaGeneral,UsuarioCreacion, @FechaGeneral
	FROM EstrategiaTemporal
	where NumeroLote = @NroLote

	-- Actualizar EstrategiaID
	UPDATE EP
	SET EP.EstrategiaID = E.EstrategiaID
	FROM EstrategiaProducto EP
		INNER JOIN  Estrategia E
			ON E.CampaniaId = EP.Campania
			AND E.CUV2 = EP.CUV2
		INNER JOIN TipoEstrategia te
			ON te.TipoEstrategiaID = E.TipoEstrategiaID
	WHERE EXISTS(SELECT ET.CampaniaId FROM EstrategiaTemporal ET  WHERE ET.CampaniaId = E.CampaniaId AND ET.NumeroLote = @NroLote and ET.CodigoTipoEstrategia = te.Codigo)
		AND ISNULL(EP.EstrategiaID, 0) = 0
	set @NroLoteFinal = @NroLote

	COMMIT TRANSACTION
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
END CATCH
END
GO


GO
USE BelcorpDominicana
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EstrategiaTemporalInsertarEstrategiaMasivo') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.EstrategiaTemporalInsertarEstrategiaMasivo
GO
CREATE PROCEDURE EstrategiaTemporalInsertarEstrategiaMasivo
(
	@NroLote int = 0,
	@NroLoteFinal int = 0 out
)
AS
BEGIN
BEGIN TRANSACTION

BEGIN TRY
	set @NroLoteFinal = 0
	set @NroLote = isnull(@NroLote, 0)
	DECLARE @FechaGeneral DATETIME
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

	-- Insertar EstrategiaProducto
	INSERT INTO EstrategiaProducto
	(
		 EstrategiaId
		, Campania
		, CUV
		, CUV2
		, CodigoEstrategia
		, Grupo
		, Orden
		, SAP
		, Cantidad
		, Precio
		, PrecioValorizado
		, Digitable
		, FactorCuadre
		, NombreProducto
		, IdMarca
	)
	SELECT
		0
		, Campania
		, Cuv
		, CuvPadre
		, CodigoEstrategia
		, Grupo
		, Orden
		, CodigoSap
		, Cantidad
		, PrecioUnitario
		, PrecioValorizado
		, Digitable
		, FactorCuadre
		, Descripcion
		, IdMarca
	FROM EstrategiaProductoTemporal
	where NumeroLote = @NroLote
	-- Insertar Estrategia
	INSERT INTO Estrategia
	(
		TipoEstrategiaID
		,CampaniaID
		,ImagenURL
		,LimiteVenta
		,DescripcionCUV2
		,CUV2
		,FlagCEP, FlagCEP2 ,TextoLibre ,FlagTextoLibre
		,CampaniaIDFin, NumeroPedido, Activo
		,FlagDescripcion, CUV
		, EtiquetaID, EtiquetaID2
		,Cantidad, FlagCantidad, Zona, Limite, Orden, ColorFondo

		,FlagEstrella, CodigoEstrategia, TieneVariedad
		,Precio, Precio2, PrecioPublico, Ganancia, Niveles
		,UsuarioCreacion, FechaCreacion, UsuarioModIFicacion, FechaModIFicacion
	)
	SELECT
		dbo.fnGetTipoEstrategiaId(CodigoTipoEstrategia) as TipoEstrategiaID
		,CampaniaId
		,FotoProducto01
		,LimiteVenta
		,Descripcion
		,CUV
		,0, 1,'',0
		,0, 0, 0
		,1, ''
		, 0, dbo.fnGetTipoEstrategiaId(CodigoTipoEstrategia) as EtiquetaID2
		,0, 0, '', NULL, 0 , ''
		,OfertaUltimoMinuto, CodigoEstrategia, TieneVariedad
		,PrecioTachado, PrecioOferta, PrecioPublico, Ganancia, Niveles
		,UsuarioCreacion,@FechaGeneral,UsuarioCreacion, @FechaGeneral
	FROM EstrategiaTemporal
	where NumeroLote = @NroLote

	-- Actualizar EstrategiaID
	UPDATE EP
	SET EP.EstrategiaID = E.EstrategiaID
	FROM EstrategiaProducto EP
		INNER JOIN  Estrategia E
			ON E.CampaniaId = EP.Campania
			AND E.CUV2 = EP.CUV2
		INNER JOIN TipoEstrategia te
			ON te.TipoEstrategiaID = E.TipoEstrategiaID
	WHERE EXISTS(SELECT ET.CampaniaId FROM EstrategiaTemporal ET  WHERE ET.CampaniaId = E.CampaniaId AND ET.NumeroLote = @NroLote and ET.CodigoTipoEstrategia = te.Codigo)
		AND ISNULL(EP.EstrategiaID, 0) = 0
	set @NroLoteFinal = @NroLote

	COMMIT TRANSACTION
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
END CATCH
END
GO


GO
USE BelcorpCostaRica
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EstrategiaTemporalInsertarEstrategiaMasivo') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.EstrategiaTemporalInsertarEstrategiaMasivo
GO
CREATE PROCEDURE EstrategiaTemporalInsertarEstrategiaMasivo
(
	@NroLote int = 0,
	@NroLoteFinal int = 0 out
)
AS
BEGIN
BEGIN TRANSACTION

BEGIN TRY
	set @NroLoteFinal = 0
	set @NroLote = isnull(@NroLote, 0)
	DECLARE @FechaGeneral DATETIME
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

	-- Insertar EstrategiaProducto
	INSERT INTO EstrategiaProducto
	(
		 EstrategiaId
		, Campania
		, CUV
		, CUV2
		, CodigoEstrategia
		, Grupo
		, Orden
		, SAP
		, Cantidad
		, Precio
		, PrecioValorizado
		, Digitable
		, FactorCuadre
		, NombreProducto
		, IdMarca
	)
	SELECT
		0
		, Campania
		, Cuv
		, CuvPadre
		, CodigoEstrategia
		, Grupo
		, Orden
		, CodigoSap
		, Cantidad
		, PrecioUnitario
		, PrecioValorizado
		, Digitable
		, FactorCuadre
		, Descripcion
		, IdMarca
	FROM EstrategiaProductoTemporal
	where NumeroLote = @NroLote
	-- Insertar Estrategia
	INSERT INTO Estrategia
	(
		TipoEstrategiaID
		,CampaniaID
		,ImagenURL
		,LimiteVenta
		,DescripcionCUV2
		,CUV2
		,FlagCEP, FlagCEP2 ,TextoLibre ,FlagTextoLibre
		,CampaniaIDFin, NumeroPedido, Activo
		,FlagDescripcion, CUV
		, EtiquetaID, EtiquetaID2
		,Cantidad, FlagCantidad, Zona, Limite, Orden, ColorFondo

		,FlagEstrella, CodigoEstrategia, TieneVariedad
		,Precio, Precio2, PrecioPublico, Ganancia, Niveles
		,UsuarioCreacion, FechaCreacion, UsuarioModIFicacion, FechaModIFicacion
	)
	SELECT
		dbo.fnGetTipoEstrategiaId(CodigoTipoEstrategia) as TipoEstrategiaID
		,CampaniaId
		,FotoProducto01
		,LimiteVenta
		,Descripcion
		,CUV
		,0, 1,'',0
		,0, 0, 0
		,1, ''
		, 0, dbo.fnGetTipoEstrategiaId(CodigoTipoEstrategia) as EtiquetaID2
		,0, 0, '', NULL, 0 , ''
		,OfertaUltimoMinuto, CodigoEstrategia, TieneVariedad
		,PrecioTachado, PrecioOferta, PrecioPublico, Ganancia, Niveles
		,UsuarioCreacion,@FechaGeneral,UsuarioCreacion, @FechaGeneral
	FROM EstrategiaTemporal
	where NumeroLote = @NroLote

	-- Actualizar EstrategiaID
	UPDATE EP
	SET EP.EstrategiaID = E.EstrategiaID
	FROM EstrategiaProducto EP
		INNER JOIN  Estrategia E
			ON E.CampaniaId = EP.Campania
			AND E.CUV2 = EP.CUV2
		INNER JOIN TipoEstrategia te
			ON te.TipoEstrategiaID = E.TipoEstrategiaID
	WHERE EXISTS(SELECT ET.CampaniaId FROM EstrategiaTemporal ET  WHERE ET.CampaniaId = E.CampaniaId AND ET.NumeroLote = @NroLote and ET.CodigoTipoEstrategia = te.Codigo)
		AND ISNULL(EP.EstrategiaID, 0) = 0
	set @NroLoteFinal = @NroLote

	COMMIT TRANSACTION
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
END CATCH
END
GO


GO
USE BelcorpChile
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EstrategiaTemporalInsertarEstrategiaMasivo') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.EstrategiaTemporalInsertarEstrategiaMasivo
GO
CREATE PROCEDURE EstrategiaTemporalInsertarEstrategiaMasivo
(
	@NroLote int = 0,
	@NroLoteFinal int = 0 out
)
AS
BEGIN
BEGIN TRANSACTION

BEGIN TRY
	set @NroLoteFinal = 0
	set @NroLote = isnull(@NroLote, 0)
	DECLARE @FechaGeneral DATETIME
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

	-- Insertar EstrategiaProducto
	INSERT INTO EstrategiaProducto
	(
		 EstrategiaId
		, Campania
		, CUV
		, CUV2
		, CodigoEstrategia
		, Grupo
		, Orden
		, SAP
		, Cantidad
		, Precio
		, PrecioValorizado
		, Digitable
		, FactorCuadre
		, NombreProducto
		, IdMarca
	)
	SELECT
		0
		, Campania
		, Cuv
		, CuvPadre
		, CodigoEstrategia
		, Grupo
		, Orden
		, CodigoSap
		, Cantidad
		, PrecioUnitario
		, PrecioValorizado
		, Digitable
		, FactorCuadre
		, Descripcion
		, IdMarca
	FROM EstrategiaProductoTemporal
	where NumeroLote = @NroLote
	-- Insertar Estrategia
	INSERT INTO Estrategia
	(
		TipoEstrategiaID
		,CampaniaID
		,ImagenURL
		,LimiteVenta
		,DescripcionCUV2
		,CUV2
		,FlagCEP, FlagCEP2 ,TextoLibre ,FlagTextoLibre
		,CampaniaIDFin, NumeroPedido, Activo
		,FlagDescripcion, CUV
		, EtiquetaID, EtiquetaID2
		,Cantidad, FlagCantidad, Zona, Limite, Orden, ColorFondo

		,FlagEstrella, CodigoEstrategia, TieneVariedad
		,Precio, Precio2, PrecioPublico, Ganancia, Niveles
		,UsuarioCreacion, FechaCreacion, UsuarioModIFicacion, FechaModIFicacion
	)
	SELECT
		dbo.fnGetTipoEstrategiaId(CodigoTipoEstrategia) as TipoEstrategiaID
		,CampaniaId
		,FotoProducto01
		,LimiteVenta
		,Descripcion
		,CUV
		,0, 1,'',0
		,0, 0, 0
		,1, ''
		, 0, dbo.fnGetTipoEstrategiaId(CodigoTipoEstrategia) as EtiquetaID2
		,0, 0, '', NULL, 0 , ''
		,OfertaUltimoMinuto, CodigoEstrategia, TieneVariedad
		,PrecioTachado, PrecioOferta, PrecioPublico, Ganancia, Niveles
		,UsuarioCreacion,@FechaGeneral,UsuarioCreacion, @FechaGeneral
	FROM EstrategiaTemporal
	where NumeroLote = @NroLote

	-- Actualizar EstrategiaID
	UPDATE EP
	SET EP.EstrategiaID = E.EstrategiaID
	FROM EstrategiaProducto EP
		INNER JOIN  Estrategia E
			ON E.CampaniaId = EP.Campania
			AND E.CUV2 = EP.CUV2
		INNER JOIN TipoEstrategia te
			ON te.TipoEstrategiaID = E.TipoEstrategiaID
	WHERE EXISTS(SELECT ET.CampaniaId FROM EstrategiaTemporal ET  WHERE ET.CampaniaId = E.CampaniaId AND ET.NumeroLote = @NroLote and ET.CodigoTipoEstrategia = te.Codigo)
		AND ISNULL(EP.EstrategiaID, 0) = 0
	set @NroLoteFinal = @NroLote

	COMMIT TRANSACTION
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
END CATCH
END
GO


GO
USE BelcorpBolivia
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EstrategiaTemporalInsertarEstrategiaMasivo') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.EstrategiaTemporalInsertarEstrategiaMasivo
GO
CREATE PROCEDURE EstrategiaTemporalInsertarEstrategiaMasivo
(
	@NroLote int = 0,
	@NroLoteFinal int = 0 out
)
AS
BEGIN
BEGIN TRANSACTION

BEGIN TRY
	set @NroLoteFinal = 0
	set @NroLote = isnull(@NroLote, 0)
	DECLARE @FechaGeneral DATETIME
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

	-- Insertar EstrategiaProducto
	INSERT INTO EstrategiaProducto
	(
		 EstrategiaId
		, Campania
		, CUV
		, CUV2
		, CodigoEstrategia
		, Grupo
		, Orden
		, SAP
		, Cantidad
		, Precio
		, PrecioValorizado
		, Digitable
		, FactorCuadre
		, NombreProducto
		, IdMarca
	)
	SELECT
		0
		, Campania
		, Cuv
		, CuvPadre
		, CodigoEstrategia
		, Grupo
		, Orden
		, CodigoSap
		, Cantidad
		, PrecioUnitario
		, PrecioValorizado
		, Digitable
		, FactorCuadre
		, Descripcion
		, IdMarca
	FROM EstrategiaProductoTemporal
	where NumeroLote = @NroLote
	-- Insertar Estrategia
	INSERT INTO Estrategia
	(
		TipoEstrategiaID
		,CampaniaID
		,ImagenURL
		,LimiteVenta
		,DescripcionCUV2
		,CUV2
		,FlagCEP, FlagCEP2 ,TextoLibre ,FlagTextoLibre
		,CampaniaIDFin, NumeroPedido, Activo
		,FlagDescripcion, CUV
		, EtiquetaID, EtiquetaID2
		,Cantidad, FlagCantidad, Zona, Limite, Orden, ColorFondo

		,FlagEstrella, CodigoEstrategia, TieneVariedad
		,Precio, Precio2, PrecioPublico, Ganancia, Niveles
		,UsuarioCreacion, FechaCreacion, UsuarioModIFicacion, FechaModIFicacion
	)
	SELECT
		dbo.fnGetTipoEstrategiaId(CodigoTipoEstrategia) as TipoEstrategiaID
		,CampaniaId
		,FotoProducto01
		,LimiteVenta
		,Descripcion
		,CUV
		,0, 1,'',0
		,0, 0, 0
		,1, ''
		, 0, dbo.fnGetTipoEstrategiaId(CodigoTipoEstrategia) as EtiquetaID2
		,0, 0, '', NULL, 0 , ''
		,OfertaUltimoMinuto, CodigoEstrategia, TieneVariedad
		,PrecioTachado, PrecioOferta, PrecioPublico, Ganancia, Niveles
		,UsuarioCreacion,@FechaGeneral,UsuarioCreacion, @FechaGeneral
	FROM EstrategiaTemporal
	where NumeroLote = @NroLote

	-- Actualizar EstrategiaID
	UPDATE EP
	SET EP.EstrategiaID = E.EstrategiaID
	FROM EstrategiaProducto EP
		INNER JOIN  Estrategia E
			ON E.CampaniaId = EP.Campania
			AND E.CUV2 = EP.CUV2
		INNER JOIN TipoEstrategia te
			ON te.TipoEstrategiaID = E.TipoEstrategiaID
	WHERE EXISTS(SELECT ET.CampaniaId FROM EstrategiaTemporal ET  WHERE ET.CampaniaId = E.CampaniaId AND ET.NumeroLote = @NroLote and ET.CodigoTipoEstrategia = te.Codigo)
		AND ISNULL(EP.EstrategiaID, 0) = 0
	set @NroLoteFinal = @NroLote

	COMMIT TRANSACTION
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
END CATCH
END
GO


GO
