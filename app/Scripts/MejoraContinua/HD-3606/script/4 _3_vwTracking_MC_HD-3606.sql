ALTER VIEW [dbo].[vwTracking]
AS
SELECT oZ.Codigo AS Zona
	,oS.Codigo AS Seccion
	,C.NombreCompleto AS Nombre
	,p.Campana
	,P.Consultora
	,CASE 
		WHEN P.Estado IS NULL
			THEN P.Fecha
		ELSE (
				CASE 
					WHEN P.Origen = 'WEB'
						AND P.Estado = 'F'
						THEN ISNULL((
									SELECT FechaRegistro
									FROM PedidoWeb WITH (NOLOCK)
									WHERE CampaniaId = p.Campana
										AND ConsultoraId = c.ConsultoraId
										AND IndicadorEnviado = 1
									), P.FechaSistema)
					ELSE P.FechaSistema
					END
				)
		END AS FechaDigitado
	,'SI' AS Digitado
	,CASE 
		WHEN P.Estado IS NULL
			THEN NULL
		ELSE A.FechaFact
		END AS Facturado
	,CASE 
		WHEN NOT A.Codigo IS NULL
			THEN CASE A.Inducido
					WHEN 'S'
						THEN A.IndFechaHora
					ELSE NULL
					END
		ELSE NULL
		END AS EnArmado
	,CASE 
		WHEN NOT A.Codigo IS NULL
			THEN CASE A.Chequeado
					WHEN 'S'
						THEN A.CFechaHoraF
					ELSE NULL
					END
		ELSE NULL
		END AS Chequeado
	,CASE 
		WHEN NOT A.Codigo IS NULL
			THEN CASE A.EnTransporte
					WHEN 'S'
						THEN A.DFechaHora
					ELSE NULL
					END
		ELSE NULL
		END AS Despachado
	,
	--A.FechaEntregado AS Recibido,
	ISNULL(dbo.fnObtenerStatusEntregaWT(A.NroPedido), A.FechaEntregado) AS Recibido
	,ISNULL(dbo.fnObtenerStatusEntregaWTDescripcion(A.NroPedido), '') AS StatusEntrega
	,A.NroPedido
	,PS.FechaEstimadaEntrega AS FechaEstimada
	,getdate() AS FechaEstimadaDesde
	,dateadd(hour,2,getdate()) AS FechaEstimadaHasta
	,P.Estado
	,P.Fecha AS FechaFact
FROM vwPedidosTotales P WITH (NOLOCK)
LEFT JOIN ods.ApePedido A WITH (NOLOCK) ON P.Campana = A.Campana
	AND P.Consultora = A.Codigo
	AND P.Fecha = A.FechaFact
	AND P.ESTADO = 'F'
INNER JOIN ods.Consultora C WITH (NOLOCK) ON P.Consultora = C.Codigo
INNER JOIN ods.Zona oZ WITH (NOLOCK) ON C.ZonaID = oZ.ZonaID
INNER JOIN ods.Seccion oS WITH (NOLOCK) ON C.SeccionID = oS.SeccionID
LEFT JOIN ods.PedidoSeguimiento PS ON A.Codigo = PS.CodigoConsultora
	AND A.NroPedido = PS.NumeroDocumentoPedido
	AND A.Campana = PS.AnoCampana
WHERE A.NroPedido IS NOT NULL
	OR P.NroPedido IS NULL
