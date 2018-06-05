GO
USE BelcorpPeru
GO
GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EstrategiaTemporalActualizarSetDetalle') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.EstrategiaTemporalActualizarSetDetalle
GO
CREATE PROCEDURE EstrategiaTemporalActualizarSetDetalle
(
	@NroLote INT,
	@Pagina int
)
AS
BEGIN

SET @NroLote = ISNULL(@NroLote, 0)
IF @NroLote > 0
BEGIN
	delete from EstrategiaProductoTemporal where NumeroLote = @NroLote and Pagina = @Pagina

	insert into EstrategiaProductoTemporal
	(
			NumeroLote
			,Pagina
			,Campania
			,Cuv
			,CuvPadre
			,CodigoEstrategia
			,Grupo
			,CodigoSap
			,Cantidad
			,PrecioUnitario
			,PrecioValorizado
			,Orden
			,Digitable
			,FactorCuadre
			,Descripcion
			,IdMarca
	)
	select
		ET.NumeroLote
		,ET.pagina
		,ET.CampaniaId
		,CASE WHEN PMO.CodigoProducto = PM.CodigoProducto THEN PM.CUV ELSE PMO.CUV END
		,ET.CUV
		,PM.EstrategiaIDSicc
		,ISNULL(PMO.NUMEROGRUPO,0)
		,PMO.CodigoProducto
		,ISNULL(PMO.FactorRepeticion,1)
		,PMO.PrecioUnitario
		,PMO.PrecioValorizado
		,CASE WHEN PMO.CodigoProducto = PM.CodigoProducto THEN PM.NumeroLineaOferta ELSE PMO.NumeroLineaOferta END
		,PMO.IndicadorDigitable
		,CAST(ISNULL(PMO.CodigoFactorCuadre,1) AS INT)
		,PMO.DESCRIPCION
		,PMO.MarcaID
	from EstrategiaTemporal ET
		INNER JOIN ODS.ProductoComercial PM WITH (NOLOCK)
			ON PM.CUV = ET.CUV
			AND PM.AnoCampania = et.CampaniaID
		INNER JOIN ODS.ProductoComercial PMO WITH (NOLOCK)
			ON PM.EstrategiaIDSicc = PMO.EstrategiaIDSicc
			AND PM.AnoCampania =PMO.AnoCampania
			AND PM.CodigoOferta = PMO.CodigoOferta
	where ET.NumeroLote = @NroLote
		and ET.Pagina = @Pagina
	UPDATE ET
	SET ET.TieneVariedad = CASE WHEN EPT.CodigoEstrategia = '2001' OR EPT.CodigoEstrategia = '2003' THEN 1 ELSE 0 END
	, ET.CodigoEstrategia = EPT.CodigoEstrategia
	FROM EstrategiaTemporal ET
	INNER JOIN EstrategiaProductoTemporal EPT
	ON ET.NumeroLote = @NroLote
		and ET.Pagina = @Pagina
		AND EPT.NumeroLote = ET.NumeroLote
		AND EPT.Pagina = ET.Pagina
		and EPT.CuvPadre = ET.CUV

END
END
GO

GO
USE BelcorpMexico
GO
GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EstrategiaTemporalActualizarSetDetalle') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.EstrategiaTemporalActualizarSetDetalle
GO
CREATE PROCEDURE EstrategiaTemporalActualizarSetDetalle
(
	@NroLote INT,
	@Pagina int
)
AS
BEGIN

SET @NroLote = ISNULL(@NroLote, 0)
IF @NroLote > 0
BEGIN
	delete from EstrategiaProductoTemporal where NumeroLote = @NroLote and Pagina = @Pagina

	insert into EstrategiaProductoTemporal
	(
			NumeroLote
			,Pagina
			,Campania
			,Cuv
			,CuvPadre
			,CodigoEstrategia
			,Grupo
			,CodigoSap
			,Cantidad
			,PrecioUnitario
			,PrecioValorizado
			,Orden
			,Digitable
			,FactorCuadre
			,Descripcion
			,IdMarca
	)
	select
		ET.NumeroLote
		,ET.pagina
		,ET.CampaniaId
		,CASE WHEN PMO.CodigoProducto = PM.CodigoProducto THEN PM.CUV ELSE PMO.CUV END
		,ET.CUV
		,PM.EstrategiaIDSicc
		,ISNULL(PMO.NUMEROGRUPO,0)
		,PMO.CodigoProducto
		,ISNULL(PMO.FactorRepeticion,1)
		,PMO.PrecioUnitario
		,PMO.PrecioValorizado
		,CASE WHEN PMO.CodigoProducto = PM.CodigoProducto THEN PM.NumeroLineaOferta ELSE PMO.NumeroLineaOferta END
		,PMO.IndicadorDigitable
		,CAST(ISNULL(PMO.CodigoFactorCuadre,1) AS INT)
		,PMO.DESCRIPCION
		,PMO.MarcaID
	from EstrategiaTemporal ET
		INNER JOIN ODS.ProductoComercial PM WITH (NOLOCK)
			ON PM.CUV = ET.CUV
			AND PM.AnoCampania = et.CampaniaID
		INNER JOIN ODS.ProductoComercial PMO WITH (NOLOCK)
			ON PM.EstrategiaIDSicc = PMO.EstrategiaIDSicc
			AND PM.AnoCampania =PMO.AnoCampania
			AND PM.CodigoOferta = PMO.CodigoOferta
	where ET.NumeroLote = @NroLote
		and ET.Pagina = @Pagina
	UPDATE ET
	SET ET.TieneVariedad = CASE WHEN EPT.CodigoEstrategia = '2001' OR EPT.CodigoEstrategia = '2003' THEN 1 ELSE 0 END
	, ET.CodigoEstrategia = EPT.CodigoEstrategia
	FROM EstrategiaTemporal ET
	INNER JOIN EstrategiaProductoTemporal EPT
	ON ET.NumeroLote = @NroLote
		and ET.Pagina = @Pagina
		AND EPT.NumeroLote = ET.NumeroLote
		AND EPT.Pagina = ET.Pagina
		and EPT.CuvPadre = ET.CUV

END
END
GO

GO
USE BelcorpColombia
GO
GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EstrategiaTemporalActualizarSetDetalle') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.EstrategiaTemporalActualizarSetDetalle
GO
CREATE PROCEDURE EstrategiaTemporalActualizarSetDetalle
(
	@NroLote INT,
	@Pagina int
)
AS
BEGIN

SET @NroLote = ISNULL(@NroLote, 0)
IF @NroLote > 0
BEGIN
	delete from EstrategiaProductoTemporal where NumeroLote = @NroLote and Pagina = @Pagina

	insert into EstrategiaProductoTemporal
	(
			NumeroLote
			,Pagina
			,Campania
			,Cuv
			,CuvPadre
			,CodigoEstrategia
			,Grupo
			,CodigoSap
			,Cantidad
			,PrecioUnitario
			,PrecioValorizado
			,Orden
			,Digitable
			,FactorCuadre
			,Descripcion
			,IdMarca
	)
	select
		ET.NumeroLote
		,ET.pagina
		,ET.CampaniaId
		,CASE WHEN PMO.CodigoProducto = PM.CodigoProducto THEN PM.CUV ELSE PMO.CUV END
		,ET.CUV
		,PM.EstrategiaIDSicc
		,ISNULL(PMO.NUMEROGRUPO,0)
		,PMO.CodigoProducto
		,ISNULL(PMO.FactorRepeticion,1)
		,PMO.PrecioUnitario
		,PMO.PrecioValorizado
		,CASE WHEN PMO.CodigoProducto = PM.CodigoProducto THEN PM.NumeroLineaOferta ELSE PMO.NumeroLineaOferta END
		,PMO.IndicadorDigitable
		,CAST(ISNULL(PMO.CodigoFactorCuadre,1) AS INT)
		,PMO.DESCRIPCION
		,PMO.MarcaID
	from EstrategiaTemporal ET
		INNER JOIN ODS.ProductoComercial PM WITH (NOLOCK)
			ON PM.CUV = ET.CUV
			AND PM.AnoCampania = et.CampaniaID
		INNER JOIN ODS.ProductoComercial PMO WITH (NOLOCK)
			ON PM.EstrategiaIDSicc = PMO.EstrategiaIDSicc
			AND PM.AnoCampania =PMO.AnoCampania
			AND PM.CodigoOferta = PMO.CodigoOferta
	where ET.NumeroLote = @NroLote
		and ET.Pagina = @Pagina
	UPDATE ET
	SET ET.TieneVariedad = CASE WHEN EPT.CodigoEstrategia = '2001' OR EPT.CodigoEstrategia = '2003' THEN 1 ELSE 0 END
	, ET.CodigoEstrategia = EPT.CodigoEstrategia
	FROM EstrategiaTemporal ET
	INNER JOIN EstrategiaProductoTemporal EPT
	ON ET.NumeroLote = @NroLote
		and ET.Pagina = @Pagina
		AND EPT.NumeroLote = ET.NumeroLote
		AND EPT.Pagina = ET.Pagina
		and EPT.CuvPadre = ET.CUV

END
END
GO

GO
USE BelcorpSalvador
GO
GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EstrategiaTemporalActualizarSetDetalle') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.EstrategiaTemporalActualizarSetDetalle
GO
CREATE PROCEDURE EstrategiaTemporalActualizarSetDetalle
(
	@NroLote INT,
	@Pagina int
)
AS
BEGIN

SET @NroLote = ISNULL(@NroLote, 0)
IF @NroLote > 0
BEGIN
	delete from EstrategiaProductoTemporal where NumeroLote = @NroLote and Pagina = @Pagina

	insert into EstrategiaProductoTemporal
	(
			NumeroLote
			,Pagina
			,Campania
			,Cuv
			,CuvPadre
			,CodigoEstrategia
			,Grupo
			,CodigoSap
			,Cantidad
			,PrecioUnitario
			,PrecioValorizado
			,Orden
			,Digitable
			,FactorCuadre
			,Descripcion
			,IdMarca
	)
	select
		ET.NumeroLote
		,ET.pagina
		,ET.CampaniaId
		,CASE WHEN PMO.CodigoProducto = PM.CodigoProducto THEN PM.CUV ELSE PMO.CUV END
		,ET.CUV
		,PM.EstrategiaIDSicc
		,ISNULL(PMO.NUMEROGRUPO,0)
		,PMO.CodigoProducto
		,ISNULL(PMO.FactorRepeticion,1)
		,PMO.PrecioUnitario
		,PMO.PrecioValorizado
		,CASE WHEN PMO.CodigoProducto = PM.CodigoProducto THEN PM.NumeroLineaOferta ELSE PMO.NumeroLineaOferta END
		,PMO.IndicadorDigitable
		,CAST(ISNULL(PMO.CodigoFactorCuadre,1) AS INT)
		,PMO.DESCRIPCION
		,PMO.MarcaID
	from EstrategiaTemporal ET
		INNER JOIN ODS.ProductoComercial PM WITH (NOLOCK)
			ON PM.CUV = ET.CUV
			AND PM.AnoCampania = et.CampaniaID
		INNER JOIN ODS.ProductoComercial PMO WITH (NOLOCK)
			ON PM.EstrategiaIDSicc = PMO.EstrategiaIDSicc
			AND PM.AnoCampania =PMO.AnoCampania
			AND PM.CodigoOferta = PMO.CodigoOferta
	where ET.NumeroLote = @NroLote
		and ET.Pagina = @Pagina
	UPDATE ET
	SET ET.TieneVariedad = CASE WHEN EPT.CodigoEstrategia = '2001' OR EPT.CodigoEstrategia = '2003' THEN 1 ELSE 0 END
	, ET.CodigoEstrategia = EPT.CodigoEstrategia
	FROM EstrategiaTemporal ET
	INNER JOIN EstrategiaProductoTemporal EPT
	ON ET.NumeroLote = @NroLote
		and ET.Pagina = @Pagina
		AND EPT.NumeroLote = ET.NumeroLote
		AND EPT.Pagina = ET.Pagina
		and EPT.CuvPadre = ET.CUV

END
END
GO

GO
USE BelcorpPuertoRico
GO
GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EstrategiaTemporalActualizarSetDetalle') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.EstrategiaTemporalActualizarSetDetalle
GO
CREATE PROCEDURE EstrategiaTemporalActualizarSetDetalle
(
	@NroLote INT,
	@Pagina int
)
AS
BEGIN

SET @NroLote = ISNULL(@NroLote, 0)
IF @NroLote > 0
BEGIN
	delete from EstrategiaProductoTemporal where NumeroLote = @NroLote and Pagina = @Pagina

	insert into EstrategiaProductoTemporal
	(
			NumeroLote
			,Pagina
			,Campania
			,Cuv
			,CuvPadre
			,CodigoEstrategia
			,Grupo
			,CodigoSap
			,Cantidad
			,PrecioUnitario
			,PrecioValorizado
			,Orden
			,Digitable
			,FactorCuadre
			,Descripcion
			,IdMarca
	)
	select
		ET.NumeroLote
		,ET.pagina
		,ET.CampaniaId
		,CASE WHEN PMO.CodigoProducto = PM.CodigoProducto THEN PM.CUV ELSE PMO.CUV END
		,ET.CUV
		,PM.EstrategiaIDSicc
		,ISNULL(PMO.NUMEROGRUPO,0)
		,PMO.CodigoProducto
		,ISNULL(PMO.FactorRepeticion,1)
		,PMO.PrecioUnitario
		,PMO.PrecioValorizado
		,CASE WHEN PMO.CodigoProducto = PM.CodigoProducto THEN PM.NumeroLineaOferta ELSE PMO.NumeroLineaOferta END
		,PMO.IndicadorDigitable
		,CAST(ISNULL(PMO.CodigoFactorCuadre,1) AS INT)
		,PMO.DESCRIPCION
		,PMO.MarcaID
	from EstrategiaTemporal ET
		INNER JOIN ODS.ProductoComercial PM WITH (NOLOCK)
			ON PM.CUV = ET.CUV
			AND PM.AnoCampania = et.CampaniaID
		INNER JOIN ODS.ProductoComercial PMO WITH (NOLOCK)
			ON PM.EstrategiaIDSicc = PMO.EstrategiaIDSicc
			AND PM.AnoCampania =PMO.AnoCampania
			AND PM.CodigoOferta = PMO.CodigoOferta
	where ET.NumeroLote = @NroLote
		and ET.Pagina = @Pagina
	UPDATE ET
	SET ET.TieneVariedad = CASE WHEN EPT.CodigoEstrategia = '2001' OR EPT.CodigoEstrategia = '2003' THEN 1 ELSE 0 END
	, ET.CodigoEstrategia = EPT.CodigoEstrategia
	FROM EstrategiaTemporal ET
	INNER JOIN EstrategiaProductoTemporal EPT
	ON ET.NumeroLote = @NroLote
		and ET.Pagina = @Pagina
		AND EPT.NumeroLote = ET.NumeroLote
		AND EPT.Pagina = ET.Pagina
		and EPT.CuvPadre = ET.CUV

END
END
GO

GO
USE BelcorpPanama
GO
GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EstrategiaTemporalActualizarSetDetalle') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.EstrategiaTemporalActualizarSetDetalle
GO
CREATE PROCEDURE EstrategiaTemporalActualizarSetDetalle
(
	@NroLote INT,
	@Pagina int
)
AS
BEGIN

SET @NroLote = ISNULL(@NroLote, 0)
IF @NroLote > 0
BEGIN
	delete from EstrategiaProductoTemporal where NumeroLote = @NroLote and Pagina = @Pagina

	insert into EstrategiaProductoTemporal
	(
			NumeroLote
			,Pagina
			,Campania
			,Cuv
			,CuvPadre
			,CodigoEstrategia
			,Grupo
			,CodigoSap
			,Cantidad
			,PrecioUnitario
			,PrecioValorizado
			,Orden
			,Digitable
			,FactorCuadre
			,Descripcion
			,IdMarca
	)
	select
		ET.NumeroLote
		,ET.pagina
		,ET.CampaniaId
		,CASE WHEN PMO.CodigoProducto = PM.CodigoProducto THEN PM.CUV ELSE PMO.CUV END
		,ET.CUV
		,PM.EstrategiaIDSicc
		,ISNULL(PMO.NUMEROGRUPO,0)
		,PMO.CodigoProducto
		,ISNULL(PMO.FactorRepeticion,1)
		,PMO.PrecioUnitario
		,PMO.PrecioValorizado
		,CASE WHEN PMO.CodigoProducto = PM.CodigoProducto THEN PM.NumeroLineaOferta ELSE PMO.NumeroLineaOferta END
		,PMO.IndicadorDigitable
		,CAST(ISNULL(PMO.CodigoFactorCuadre,1) AS INT)
		,PMO.DESCRIPCION
		,PMO.MarcaID
	from EstrategiaTemporal ET
		INNER JOIN ODS.ProductoComercial PM WITH (NOLOCK)
			ON PM.CUV = ET.CUV
			AND PM.AnoCampania = et.CampaniaID
		INNER JOIN ODS.ProductoComercial PMO WITH (NOLOCK)
			ON PM.EstrategiaIDSicc = PMO.EstrategiaIDSicc
			AND PM.AnoCampania =PMO.AnoCampania
			AND PM.CodigoOferta = PMO.CodigoOferta
	where ET.NumeroLote = @NroLote
		and ET.Pagina = @Pagina
	UPDATE ET
	SET ET.TieneVariedad = CASE WHEN EPT.CodigoEstrategia = '2001' OR EPT.CodigoEstrategia = '2003' THEN 1 ELSE 0 END
	, ET.CodigoEstrategia = EPT.CodigoEstrategia
	FROM EstrategiaTemporal ET
	INNER JOIN EstrategiaProductoTemporal EPT
	ON ET.NumeroLote = @NroLote
		and ET.Pagina = @Pagina
		AND EPT.NumeroLote = ET.NumeroLote
		AND EPT.Pagina = ET.Pagina
		and EPT.CuvPadre = ET.CUV

END
END
GO

GO
USE BelcorpGuatemala
GO
GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EstrategiaTemporalActualizarSetDetalle') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.EstrategiaTemporalActualizarSetDetalle
GO
CREATE PROCEDURE EstrategiaTemporalActualizarSetDetalle
(
	@NroLote INT,
	@Pagina int
)
AS
BEGIN

SET @NroLote = ISNULL(@NroLote, 0)
IF @NroLote > 0
BEGIN
	delete from EstrategiaProductoTemporal where NumeroLote = @NroLote and Pagina = @Pagina

	insert into EstrategiaProductoTemporal
	(
			NumeroLote
			,Pagina
			,Campania
			,Cuv
			,CuvPadre
			,CodigoEstrategia
			,Grupo
			,CodigoSap
			,Cantidad
			,PrecioUnitario
			,PrecioValorizado
			,Orden
			,Digitable
			,FactorCuadre
			,Descripcion
			,IdMarca
	)
	select
		ET.NumeroLote
		,ET.pagina
		,ET.CampaniaId
		,CASE WHEN PMO.CodigoProducto = PM.CodigoProducto THEN PM.CUV ELSE PMO.CUV END
		,ET.CUV
		,PM.EstrategiaIDSicc
		,ISNULL(PMO.NUMEROGRUPO,0)
		,PMO.CodigoProducto
		,ISNULL(PMO.FactorRepeticion,1)
		,PMO.PrecioUnitario
		,PMO.PrecioValorizado
		,CASE WHEN PMO.CodigoProducto = PM.CodigoProducto THEN PM.NumeroLineaOferta ELSE PMO.NumeroLineaOferta END
		,PMO.IndicadorDigitable
		,CAST(ISNULL(PMO.CodigoFactorCuadre,1) AS INT)
		,PMO.DESCRIPCION
		,PMO.MarcaID
	from EstrategiaTemporal ET
		INNER JOIN ODS.ProductoComercial PM WITH (NOLOCK)
			ON PM.CUV = ET.CUV
			AND PM.AnoCampania = et.CampaniaID
		INNER JOIN ODS.ProductoComercial PMO WITH (NOLOCK)
			ON PM.EstrategiaIDSicc = PMO.EstrategiaIDSicc
			AND PM.AnoCampania =PMO.AnoCampania
			AND PM.CodigoOferta = PMO.CodigoOferta
	where ET.NumeroLote = @NroLote
		and ET.Pagina = @Pagina
	UPDATE ET
	SET ET.TieneVariedad = CASE WHEN EPT.CodigoEstrategia = '2001' OR EPT.CodigoEstrategia = '2003' THEN 1 ELSE 0 END
	, ET.CodigoEstrategia = EPT.CodigoEstrategia
	FROM EstrategiaTemporal ET
	INNER JOIN EstrategiaProductoTemporal EPT
	ON ET.NumeroLote = @NroLote
		and ET.Pagina = @Pagina
		AND EPT.NumeroLote = ET.NumeroLote
		AND EPT.Pagina = ET.Pagina
		and EPT.CuvPadre = ET.CUV

END
END
GO

GO
USE BelcorpEcuador
GO
GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EstrategiaTemporalActualizarSetDetalle') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.EstrategiaTemporalActualizarSetDetalle
GO
CREATE PROCEDURE EstrategiaTemporalActualizarSetDetalle
(
	@NroLote INT,
	@Pagina int
)
AS
BEGIN

SET @NroLote = ISNULL(@NroLote, 0)
IF @NroLote > 0
BEGIN
	delete from EstrategiaProductoTemporal where NumeroLote = @NroLote and Pagina = @Pagina

	insert into EstrategiaProductoTemporal
	(
			NumeroLote
			,Pagina
			,Campania
			,Cuv
			,CuvPadre
			,CodigoEstrategia
			,Grupo
			,CodigoSap
			,Cantidad
			,PrecioUnitario
			,PrecioValorizado
			,Orden
			,Digitable
			,FactorCuadre
			,Descripcion
			,IdMarca
	)
	select
		ET.NumeroLote
		,ET.pagina
		,ET.CampaniaId
		,CASE WHEN PMO.CodigoProducto = PM.CodigoProducto THEN PM.CUV ELSE PMO.CUV END
		,ET.CUV
		,PM.EstrategiaIDSicc
		,ISNULL(PMO.NUMEROGRUPO,0)
		,PMO.CodigoProducto
		,ISNULL(PMO.FactorRepeticion,1)
		,PMO.PrecioUnitario
		,PMO.PrecioValorizado
		,CASE WHEN PMO.CodigoProducto = PM.CodigoProducto THEN PM.NumeroLineaOferta ELSE PMO.NumeroLineaOferta END
		,PMO.IndicadorDigitable
		,CAST(ISNULL(PMO.CodigoFactorCuadre,1) AS INT)
		,PMO.DESCRIPCION
		,PMO.MarcaID
	from EstrategiaTemporal ET
		INNER JOIN ODS.ProductoComercial PM WITH (NOLOCK)
			ON PM.CUV = ET.CUV
			AND PM.AnoCampania = et.CampaniaID
		INNER JOIN ODS.ProductoComercial PMO WITH (NOLOCK)
			ON PM.EstrategiaIDSicc = PMO.EstrategiaIDSicc
			AND PM.AnoCampania =PMO.AnoCampania
			AND PM.CodigoOferta = PMO.CodigoOferta
	where ET.NumeroLote = @NroLote
		and ET.Pagina = @Pagina
	UPDATE ET
	SET ET.TieneVariedad = CASE WHEN EPT.CodigoEstrategia = '2001' OR EPT.CodigoEstrategia = '2003' THEN 1 ELSE 0 END
	, ET.CodigoEstrategia = EPT.CodigoEstrategia
	FROM EstrategiaTemporal ET
	INNER JOIN EstrategiaProductoTemporal EPT
	ON ET.NumeroLote = @NroLote
		and ET.Pagina = @Pagina
		AND EPT.NumeroLote = ET.NumeroLote
		AND EPT.Pagina = ET.Pagina
		and EPT.CuvPadre = ET.CUV

END
END
GO

GO
USE BelcorpDominicana
GO
GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EstrategiaTemporalActualizarSetDetalle') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.EstrategiaTemporalActualizarSetDetalle
GO
CREATE PROCEDURE EstrategiaTemporalActualizarSetDetalle
(
	@NroLote INT,
	@Pagina int
)
AS
BEGIN

SET @NroLote = ISNULL(@NroLote, 0)
IF @NroLote > 0
BEGIN
	delete from EstrategiaProductoTemporal where NumeroLote = @NroLote and Pagina = @Pagina

	insert into EstrategiaProductoTemporal
	(
			NumeroLote
			,Pagina
			,Campania
			,Cuv
			,CuvPadre
			,CodigoEstrategia
			,Grupo
			,CodigoSap
			,Cantidad
			,PrecioUnitario
			,PrecioValorizado
			,Orden
			,Digitable
			,FactorCuadre
			,Descripcion
			,IdMarca
	)
	select
		ET.NumeroLote
		,ET.pagina
		,ET.CampaniaId
		,CASE WHEN PMO.CodigoProducto = PM.CodigoProducto THEN PM.CUV ELSE PMO.CUV END
		,ET.CUV
		,PM.EstrategiaIDSicc
		,ISNULL(PMO.NUMEROGRUPO,0)
		,PMO.CodigoProducto
		,ISNULL(PMO.FactorRepeticion,1)
		,PMO.PrecioUnitario
		,PMO.PrecioValorizado
		,CASE WHEN PMO.CodigoProducto = PM.CodigoProducto THEN PM.NumeroLineaOferta ELSE PMO.NumeroLineaOferta END
		,PMO.IndicadorDigitable
		,CAST(ISNULL(PMO.CodigoFactorCuadre,1) AS INT)
		,PMO.DESCRIPCION
		,PMO.MarcaID
	from EstrategiaTemporal ET
		INNER JOIN ODS.ProductoComercial PM WITH (NOLOCK)
			ON PM.CUV = ET.CUV
			AND PM.AnoCampania = et.CampaniaID
		INNER JOIN ODS.ProductoComercial PMO WITH (NOLOCK)
			ON PM.EstrategiaIDSicc = PMO.EstrategiaIDSicc
			AND PM.AnoCampania =PMO.AnoCampania
			AND PM.CodigoOferta = PMO.CodigoOferta
	where ET.NumeroLote = @NroLote
		and ET.Pagina = @Pagina
	UPDATE ET
	SET ET.TieneVariedad = CASE WHEN EPT.CodigoEstrategia = '2001' OR EPT.CodigoEstrategia = '2003' THEN 1 ELSE 0 END
	, ET.CodigoEstrategia = EPT.CodigoEstrategia
	FROM EstrategiaTemporal ET
	INNER JOIN EstrategiaProductoTemporal EPT
	ON ET.NumeroLote = @NroLote
		and ET.Pagina = @Pagina
		AND EPT.NumeroLote = ET.NumeroLote
		AND EPT.Pagina = ET.Pagina
		and EPT.CuvPadre = ET.CUV

END
END
GO

GO
USE BelcorpCostaRica
GO
GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EstrategiaTemporalActualizarSetDetalle') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.EstrategiaTemporalActualizarSetDetalle
GO
CREATE PROCEDURE EstrategiaTemporalActualizarSetDetalle
(
	@NroLote INT,
	@Pagina int
)
AS
BEGIN

SET @NroLote = ISNULL(@NroLote, 0)
IF @NroLote > 0
BEGIN
	delete from EstrategiaProductoTemporal where NumeroLote = @NroLote and Pagina = @Pagina

	insert into EstrategiaProductoTemporal
	(
			NumeroLote
			,Pagina
			,Campania
			,Cuv
			,CuvPadre
			,CodigoEstrategia
			,Grupo
			,CodigoSap
			,Cantidad
			,PrecioUnitario
			,PrecioValorizado
			,Orden
			,Digitable
			,FactorCuadre
			,Descripcion
			,IdMarca
	)
	select
		ET.NumeroLote
		,ET.pagina
		,ET.CampaniaId
		,CASE WHEN PMO.CodigoProducto = PM.CodigoProducto THEN PM.CUV ELSE PMO.CUV END
		,ET.CUV
		,PM.EstrategiaIDSicc
		,ISNULL(PMO.NUMEROGRUPO,0)
		,PMO.CodigoProducto
		,ISNULL(PMO.FactorRepeticion,1)
		,PMO.PrecioUnitario
		,PMO.PrecioValorizado
		,CASE WHEN PMO.CodigoProducto = PM.CodigoProducto THEN PM.NumeroLineaOferta ELSE PMO.NumeroLineaOferta END
		,PMO.IndicadorDigitable
		,CAST(ISNULL(PMO.CodigoFactorCuadre,1) AS INT)
		,PMO.DESCRIPCION
		,PMO.MarcaID
	from EstrategiaTemporal ET
		INNER JOIN ODS.ProductoComercial PM WITH (NOLOCK)
			ON PM.CUV = ET.CUV
			AND PM.AnoCampania = et.CampaniaID
		INNER JOIN ODS.ProductoComercial PMO WITH (NOLOCK)
			ON PM.EstrategiaIDSicc = PMO.EstrategiaIDSicc
			AND PM.AnoCampania =PMO.AnoCampania
			AND PM.CodigoOferta = PMO.CodigoOferta
	where ET.NumeroLote = @NroLote
		and ET.Pagina = @Pagina
	UPDATE ET
	SET ET.TieneVariedad = CASE WHEN EPT.CodigoEstrategia = '2001' OR EPT.CodigoEstrategia = '2003' THEN 1 ELSE 0 END
	, ET.CodigoEstrategia = EPT.CodigoEstrategia
	FROM EstrategiaTemporal ET
	INNER JOIN EstrategiaProductoTemporal EPT
	ON ET.NumeroLote = @NroLote
		and ET.Pagina = @Pagina
		AND EPT.NumeroLote = ET.NumeroLote
		AND EPT.Pagina = ET.Pagina
		and EPT.CuvPadre = ET.CUV

END
END
GO

GO
USE BelcorpChile
GO
GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EstrategiaTemporalActualizarSetDetalle') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.EstrategiaTemporalActualizarSetDetalle
GO
CREATE PROCEDURE EstrategiaTemporalActualizarSetDetalle
(
	@NroLote INT,
	@Pagina int
)
AS
BEGIN

SET @NroLote = ISNULL(@NroLote, 0)
IF @NroLote > 0
BEGIN
	delete from EstrategiaProductoTemporal where NumeroLote = @NroLote and Pagina = @Pagina

	insert into EstrategiaProductoTemporal
	(
			NumeroLote
			,Pagina
			,Campania
			,Cuv
			,CuvPadre
			,CodigoEstrategia
			,Grupo
			,CodigoSap
			,Cantidad
			,PrecioUnitario
			,PrecioValorizado
			,Orden
			,Digitable
			,FactorCuadre
			,Descripcion
			,IdMarca
	)
	select
		ET.NumeroLote
		,ET.pagina
		,ET.CampaniaId
		,CASE WHEN PMO.CodigoProducto = PM.CodigoProducto THEN PM.CUV ELSE PMO.CUV END
		,ET.CUV
		,PM.EstrategiaIDSicc
		,ISNULL(PMO.NUMEROGRUPO,0)
		,PMO.CodigoProducto
		,ISNULL(PMO.FactorRepeticion,1)
		,PMO.PrecioUnitario
		,PMO.PrecioValorizado
		,CASE WHEN PMO.CodigoProducto = PM.CodigoProducto THEN PM.NumeroLineaOferta ELSE PMO.NumeroLineaOferta END
		,PMO.IndicadorDigitable
		,CAST(ISNULL(PMO.CodigoFactorCuadre,1) AS INT)
		,PMO.DESCRIPCION
		,PMO.MarcaID
	from EstrategiaTemporal ET
		INNER JOIN ODS.ProductoComercial PM WITH (NOLOCK)
			ON PM.CUV = ET.CUV
			AND PM.AnoCampania = et.CampaniaID
		INNER JOIN ODS.ProductoComercial PMO WITH (NOLOCK)
			ON PM.EstrategiaIDSicc = PMO.EstrategiaIDSicc
			AND PM.AnoCampania =PMO.AnoCampania
			AND PM.CodigoOferta = PMO.CodigoOferta
	where ET.NumeroLote = @NroLote
		and ET.Pagina = @Pagina
	UPDATE ET
	SET ET.TieneVariedad = CASE WHEN EPT.CodigoEstrategia = '2001' OR EPT.CodigoEstrategia = '2003' THEN 1 ELSE 0 END
	, ET.CodigoEstrategia = EPT.CodigoEstrategia
	FROM EstrategiaTemporal ET
	INNER JOIN EstrategiaProductoTemporal EPT
	ON ET.NumeroLote = @NroLote
		and ET.Pagina = @Pagina
		AND EPT.NumeroLote = ET.NumeroLote
		AND EPT.Pagina = ET.Pagina
		and EPT.CuvPadre = ET.CUV

END
END
GO

GO
USE BelcorpBolivia
GO
GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EstrategiaTemporalActualizarSetDetalle') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.EstrategiaTemporalActualizarSetDetalle
GO
CREATE PROCEDURE EstrategiaTemporalActualizarSetDetalle
(
	@NroLote INT,
	@Pagina int
)
AS
BEGIN

SET @NroLote = ISNULL(@NroLote, 0)
IF @NroLote > 0
BEGIN
	delete from EstrategiaProductoTemporal where NumeroLote = @NroLote and Pagina = @Pagina

	insert into EstrategiaProductoTemporal
	(
			NumeroLote
			,Pagina
			,Campania
			,Cuv
			,CuvPadre
			,CodigoEstrategia
			,Grupo
			,CodigoSap
			,Cantidad
			,PrecioUnitario
			,PrecioValorizado
			,Orden
			,Digitable
			,FactorCuadre
			,Descripcion
			,IdMarca
	)
	select
		ET.NumeroLote
		,ET.pagina
		,ET.CampaniaId
		,CASE WHEN PMO.CodigoProducto = PM.CodigoProducto THEN PM.CUV ELSE PMO.CUV END
		,ET.CUV
		,PM.EstrategiaIDSicc
		,ISNULL(PMO.NUMEROGRUPO,0)
		,PMO.CodigoProducto
		,ISNULL(PMO.FactorRepeticion,1)
		,PMO.PrecioUnitario
		,PMO.PrecioValorizado
		,CASE WHEN PMO.CodigoProducto = PM.CodigoProducto THEN PM.NumeroLineaOferta ELSE PMO.NumeroLineaOferta END
		,PMO.IndicadorDigitable
		,CAST(ISNULL(PMO.CodigoFactorCuadre,1) AS INT)
		,PMO.DESCRIPCION
		,PMO.MarcaID
	from EstrategiaTemporal ET
		INNER JOIN ODS.ProductoComercial PM WITH (NOLOCK)
			ON PM.CUV = ET.CUV
			AND PM.AnoCampania = et.CampaniaID
		INNER JOIN ODS.ProductoComercial PMO WITH (NOLOCK)
			ON PM.EstrategiaIDSicc = PMO.EstrategiaIDSicc
			AND PM.AnoCampania =PMO.AnoCampania
			AND PM.CodigoOferta = PMO.CodigoOferta
	where ET.NumeroLote = @NroLote
		and ET.Pagina = @Pagina
	UPDATE ET
	SET ET.TieneVariedad = CASE WHEN EPT.CodigoEstrategia = '2001' OR EPT.CodigoEstrategia = '2003' THEN 1 ELSE 0 END
	, ET.CodigoEstrategia = EPT.CodigoEstrategia
	FROM EstrategiaTemporal ET
	INNER JOIN EstrategiaProductoTemporal EPT
	ON ET.NumeroLote = @NroLote
		and ET.Pagina = @Pagina
		AND EPT.NumeroLote = ET.NumeroLote
		AND EPT.Pagina = ET.Pagina
		and EPT.CuvPadre = ET.CUV

END
END
GO

GO
