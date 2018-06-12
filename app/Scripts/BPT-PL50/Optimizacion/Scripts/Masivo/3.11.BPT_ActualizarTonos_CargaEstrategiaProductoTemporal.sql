
GO

PRINT DB_NAME()
IF EXISTS(	SELECT * 
			FROM SYS.OBJECTS SO
			WHERE SO.NAME = 'ActualizarTonos_CargaEstrategiaProductoTemporal'
			AND SO.[TYPE] = 'P')
BEGIN
	PRINT 'Eliminando Procedure : ActualizarTonos_CargaEstrategiaProductoTemporal'
	DROP PROCEDURE ActualizarTonos_CargaEstrategiaProductoTemporal
END
GO

CREATE PROCEDURE ActualizarTonos_CargaEstrategiaProductoTemporal(
@CampaniaActual INT = 0,
@CampaniaSiguiente INT = 0
)
AS
BEGIN
	IF @CampaniaActual = 0
	BEGIN
		SET @CampaniaActual = dbo.fnGetCampaniaActualPais();
		--PRINT @CampaniaActual;
	END

	IF @CampaniaSiguiente = 0
	BEGIN
		SET @CampaniaSiguiente = dbo.fnGetCampaniaSiguiente(@CampaniaActual);
		--PRINT @CampaniaSiguiente;
	END

	DECLARE @NumeroLote INT
	SET @NumeroLote = FORMAT(GETDATE() , 'yyMMddHHmm');
	--PRINT @NumeroLote;

	insert into EstrategiaProductoTemporal
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
		Estrategia ET
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
						FROM ODS.ProductoComercial PM WITH (NOLOCK) 
						INNER JOIN ODS.ProductoComercial PMO 
							ON PM.EstrategiaIDSicc = PMO.EstrategiaIDSicc 
							AND PM.AnoCampania =PMO.AnoCampania 
							AND PM.CodigoOferta = PMO.CodigoOferta
							AND PM.AnoCampania IN (@CampaniaActual,@CampaniaSiguiente)
							AND PMO.AnoCampania IN (@CampaniaActual,@CampaniaSiguiente)
							) p
				ON p.CUV2 = ET.CUV2
				AND P.CampaniaID = ET.CampaniaId
				AND ET.CampaniaID IN (@CampaniaActual,@CampaniaSiguiente)
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
END
GO