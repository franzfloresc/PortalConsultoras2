--EXEC ActualizarTonos_CargaEstrategiaProductoTemporal
--GO
ALTER PROCEDURE ActualizarTonos_CargaEstrategiaProductoTemporal
AS
BEGIN
	DECLARE @CampaniaActual INT
	DECLARE @CampaniaSiguiente INT
	DECLARE @CampaniaSubSiguiente INT
	DECLARE @NumeroLote INT


	SET @CampaniaActual = dbo.fnGetCampaniaActualPais();
	SET @CampaniaSiguiente = dbo.fnGetCampaniaSiguiente(@CampaniaActual);
	SET @CampaniaSubSiguiente = dbo.fnGetCampaniaSiguiente(@CampaniaSiguiente);
	SET @NumeroLote = FORMAT(GETDATE() , 'yyMMddHHmm');

	CREATE TABLE #Estrategia(
		NumeroLote			INT
		,CampaniaId			INT
		,CUV2				VARCHAR(6)
	)

	INSERT INTO #Estrategia
	select
	NumeroLote = @NumeroLote
	,CampaniaId = ET.CampaniaId
	,CUV2 = ET.CUV2
	FROM
	Estrategia ET
	WHERE ET.CampaniaID IN (@CampaniaActual,@CampaniaSiguiente,@CampaniaSubSiguiente)

	CREATE TABLE #ODS_PRODUCTO_COMERCIAL(
		EstrategiaIDSicc	INT
		,CodigoProducto		varchar(12)
		,CUV				VARCHAR(50)
		,NUMEROGRUPO		INT
		,FactorRepeticion	INT
		,PrecioUnitario		NUMERIC(12,2)
		,PrecioValorizado	NUMERIC(12,2)
		,NumeroLineaOferta	INT
		,CodigoFactorCuadre	INT
		,DESCRIPCION		VARCHAR(500)
		,MarcaID			INT
		,AnoCampania		INT
		,CodigoOferta		INT
	)

	INSERT INTO #ODS_PRODUCTO_COMERCIAL
	SELECT
	PM.EstrategiaIDSicc
	,PM.CodigoProducto
	,PM.CUV
	,ISNULL(PM.NUMEROGRUPO,0)
	,ISNULL(PM.FactorRepeticion,1)
	,PM.PrecioUnitario
	,PM.PrecioValorizado
	,PM.NumeroLineaOferta
	,CAST(ISNULL(PM.CodigoFactorCuadre,1) AS INT)
	,PM.DESCRIPCION
	,PM.MarcaID
	,PM.AnoCampania
	,PM.CodigoOferta
	FROM ODS.ProductoComercial PM WITH (NOLOCK)
	WHERE PM.AnoCampania IN (@CampaniaActual,@CampaniaSiguiente,@CampaniaSubSiguiente)

	INSERT INTO EstrategiaProductoTemporal
	(
		NumeroLote
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
	SELECT
	NumeroLote
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
	FROM(
		select
			NumeroLote = @NumeroLote
			,Campania = ET.CampaniaId
			,Cuv = P.Cuv
			,CuvPadre = ET.CUV2
			,CodigoEstrategia = P.CODIGO_ESTRATEGIA
			,P.GRUPO
			,CodigoSap = P.CODIGO_SAP
			,P.CANTIDAD
			,PrecioUnitario = P.PRECIO_UNITARIO
			,PrecioValorizado = P.PRECIO_VALORIZADO
			,P.ORDEN
			,P.DIGITABLE
			,FactorCuadre = P.FACTOR_CUADRE
			,P.DESCRIPCION
			,P.IDMARCA
		from
		#Estrategia ET
			INNER JOIN	(SELECT
						CODIGO_ESTRATEGIA = PM.EstrategiaIDSicc
						,CUV = CASE WHEN PMO.CodigoProducto = PM.CodigoProducto THEN PM.CUV ELSE PMO.CUV END
						,GRUPO = ISNULL(PMO.NUMEROGRUPO,0)
						,CODIGO_SAP = PMO.CodigoProducto
						,CANTIDAD = ISNULL(PMO.FactorRepeticion,1)
						,PRECIO_UNITARIO = (PMO.PrecioUnitario)
						,PRECIO_VALORIZADO = (PMO.PrecioValorizado)
						,ORDEN = CASE WHEN PMO.CodigoProducto = PM.CodigoProducto THEN PM.NumeroLineaOferta ELSE PMO.NumeroLineaOferta END
						,DIGITABLE = CASE WHEN PM.EstrategiaIDSicc IN ('2001', '2003') THEN 1 ELSE 0 END
						,COD_VENTA_HIJO = PMO.CUV
						,FACTOR_CUADRE = CAST(ISNULL(PMO.CodigoFactorCuadre,1) AS INT)
						,DESCRIPCION = PMO.DESCRIPCION
						,IDMARCA = PMO.MarcaID
						,CUV2 = PM.CUV
						,CAMPANIAID = PMO.AnoCampania
						FROM #ODS_PRODUCTO_COMERCIAL PM WITH (NOLOCK)
						INNER JOIN #ODS_PRODUCTO_COMERCIAL PMO
							ON PM.EstrategiaIDSicc = PMO.EstrategiaIDSicc
							AND PM.AnoCampania =PMO.AnoCampania
							AND PM.CodigoOferta = PMO.CodigoOferta
							) p
				ON p.CUV2 = ET.CUV2
				AND P.CampaniaID = ET.CampaniaId
		) TMP
	GROUP BY
	NumeroLote
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

	DROP TABLE #Estrategia

	DROP TABLE #ODS_PRODUCTO_COMERCIAL
END

GO
