GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EstrategiaTemporalActualizarSetDetalle') AND type IN ( N'P', N'PC' ) ) 
	DROP PROCEDURE dbo.EstrategiaTemporalActualizarSetDetalle
GO

CREATE PROCEDURE EstrategiaTemporalActualizarSetDetalle
(
	@NroLote INT
)
AS
BEGIN

	delete from EstrategiaProductoTemporal where NumeroLote = @NroLote

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
	select 
		ET.NumeroLote
		,ET.CampaniaId
		,P.Cuv
		,ET.CUV
		,P.CODIGO_ESTRATEGIA
		,P.GRUPO
		,P.CODIGO_SAP
		,P.CANTIDAD
		,P.PRECIO_UNITARIO
		,P.PRECIO_VALORIZADO
		,P.ORDEN
		,P.DIGITABLE
		,P.FACTOR_CUADRE
		,P.DESCRIPCION
		,P.IDMARCA
	from 
	EstrategiaTemporal ET
		INNER JOIN ( 

			SELECT  
					PM.EstrategiaIDSicc CODIGO_ESTRATEGIA
					--,PMO.DES_ESTRATEGIA ESTRATEGIA
					,CASE WHEN PMO.CodigoProducto = PM.CodigoProducto THEN PM.CUV ELSE PMO.CUV END CUV
					,ISNULL(PMO.NUMEROGRUPO,0) GRUPO
					,PMO.CodigoProducto CODIGO_SAP
					,ISNULL(PMO.FactorRepeticion,1) CANTIDAD
					,(PMO.PrecioUnitario) PRECIO_UNITARIO
					,(PMO.PrecioValorizado) PRECIO_VALORIZADO
					,CASE WHEN PMO.CodigoProducto = PM.CodigoProducto THEN PM.NumeroLineaOferta ELSE PMO.NumeroLineaOferta END ORDEN
					,PMO.IndicadorDigitable DIGITABLE
					,PMO.CUV COD_VENTA_HIJO
					,CAST(ISNULL(PMO.CodigoFactorCuadre,1) AS INT) FACTOR_CUADRE
					,PMO.DESCRIPCION DESCRIPCION
					,PMO.MarcaID IDMARCA
					,PM.CUV CUV2
					,PMO.AnoCampania as CampaniaID
				FROM ODS.ProductoComercial PM WITH (NOLOCK) 
		
				INNER JOIN ODS.ProductoComercial PMO 
					ON PM.EstrategiaIDSicc = PMO.EstrategiaIDSicc 
					AND PM.AnoCampania =PMO.AnoCampania 
					AND PM.CodigoOferta = PMO.CodigoOferta

				--LEFT JOIN PRL_OFERTAS PO WITH (NOLOCK) 
				--	ON PO.COD_PERIODO = PM.COD_PERIODO 
				--	AND PO.COD_PERIODO = PMO.COD_PERIODO 
				--	AND PO.OID_ESTRATEGIA = PM.OID_ESTRATEGIA 
				--	AND PO.OID_ESTRATEGIA = PMO.OID_ESTRATEGIA
				--	AND PO.NUMERO_OFERTA = PM.NUMERO_OFERTA 
				--	AND PO.NUMERO_OFERTA = PMO.NUMERO_OFERTA 
				--	AND PO.NUMERO_GRUPO = PMO.NUMERO_GRUPO

				--WHERE PMO.AnoCampania = @CampaniaID 
					--AND PM.CUV = @CUV
			) p
			on p.CUV2 = ET.CUV
			and P.CampaniaID = ET.CampaniaId

	where ET.NumeroLote = @NroLote

END
GO