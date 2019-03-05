--GetTrackingByConsultoraCampaniaFecha '000758604',201901,'1808836983'
ALTER PROCEDURE [dbo].[GetTrackingByConsultoraCampaniaFecha_V2]
	--GetTrackingByConsultoraCampaniaFecha_V2 '040891803' ,'201903','1900998502' 
	(
	@CodigoConsultora AS VARCHAR(20)
	,@Campana AS VARCHAR(6)
	,@NroPedido AS VARCHAR(50)
	)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT s.ID AS Etapa
		,s.Situacion
		,CASE CONVERT(DATE, t.Fecha)
			WHEN '1900-01-01'
				THEN NULL
			ELSE t.Fecha
			END AS Fecha
		,CASE s.ID
			WHEN 6
				THEN ps.ValorTurno
			ELSE NULL
			END AS ValorTurno
	FROM (
		SELECT ROW_NUMBER() OVER (
				ORDER BY (
						SELECT 100
						)
				) Orden
			,Campana
			,Fecha
		FROM (
			SELECT Campana
				,NroPedido
				,isnull(FechaDigitado, '') AS FechaDigitado
				,isnull(Facturado, '') AS Facturado
				,isnull(EnArmado, '') AS EnArmado
				,isnull(Chequeado, '') AS Chequeado
				,isnull(Despachado, '') AS Despachado
				,CONVERT(DATETIME, FechaEstimada) AS FechaEstimada
				,isnull(Recibido, '') AS Recibido
				,isnull(FechaEstimadaDesde, '') AS FechaEstimadaDesde
				,isnull(FechaEstimadaHasta, '') AS FechaEstimadaHasta
			FROM vwTracking
			WHERE Consultora = @CodigoConsultora
				AND Campana = @Campana
				AND NroPedido = @NroPedido
			) p
		UNPIVOT(Fecha FOR p IN (
					FechaDigitado
					,Facturado
					,EnArmado
					,Chequeado
					,Despachado
					,FechaEstimada
					,Recibido
					,FechaEstimadaDesde
					,FechaEstimadaHasta
					)) AS unpvt
		) AS t
	LEFT JOIN vwSituacionPedido s ON t.Orden = s.ID
	LEFT JOIN ods.PedidoSeguimiento ps ON (
			t.Campana = ps.AnoCampana
			AND ps.CodigoConsultora = @CodigoConsultora
			)
	WHERE ps.NumeroDocumentoPedido = @NroPedido;

	SET NOCOUNT OFF;
END


