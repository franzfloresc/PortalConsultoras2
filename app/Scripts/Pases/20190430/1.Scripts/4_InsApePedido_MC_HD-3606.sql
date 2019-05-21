USE BelcorpPeru
GO
ALTER PROCEDURE [dbo].[InsApePedido]
AS
DECLARE @TempCambios TABLE (
	Codigo VARCHAR(20)
	,Campana INT
	,NroPedido VARCHAR(50)
	)

INSERT INTO @TempCambios
SELECT YT.Codigo
	,YT.Campana
	,YT.NroPedido
FROM YobelPedidoTemp YT
INNER JOIN ods.ApePedido A ON YT.NroPedido = A.NroPedido
	AND YT.Campana = A.Campana
	AND YT.Codigo = A.Codigo

UPDATE YobelPedidoTemp
SET Estado = 0
FROM YobelPedidoTemp T
INNER JOIN @TempCambios C ON T.NroPedido = C.NroPedido
	AND T.Campana = C.Campana
	AND T.Codigo = C.Codigo

INSERT INTO ods.ApePedido (
	[Campana]
	,[NroPedido]
	,[Codigo]
	,[AChequeo]
	,[FechaFact]
	,[Tiempo]
	,[ErrorEmbalaje]
	,[Inducido]
	,[IndFechaHora]
	,[Armado]
	,[Chequeado]
	,[CFechaHoraI]
	,[CFechaHoraF]
	,[EnDespacho]
	,[EnTransporte]
	,[DFechaHora]
	,[TipoPedido]
	,[CostoPedido]
	,[OrdenImpreso]
	,[FechaEntregado]
	,[NroCajas]
	,[IndEntregaEstimada]
	,[FecHoraEntregaEstimadaDesde]
	,[FecHoraEntregaEstimadaHasta]
	,[IndTipoInformacion]
	)
SELECT [Campana]
	,[NroPedido]
	,[Codigo]
	,[AChequeo]
	,[FechaFact]
	,[Tiempo]
	,[ErrorEmbalaje]
	,[Inducido]
	,[IndFechaHora]
	,[Armado]
	,[Chequeado]
	,[CFechaHoraI]
	,[CFechaHoraF]
	,[EnDespacho]
	,[EnTransporte]
	,[DFechaHora]
	,[TipoPedido]
	,[CostoPedido]
	,[OrdenImpreso]
	,[FechaEntregado]
	,[NroCajas]
	,[IndEntregaEstimada]
	,[FecHoraEntregaEstimadaDesde]
	,[FecHoraEntregaEstimadaHasta]
	,[IndTipoInformacion]
FROM YobelPedidoTemp
WHERE Estado = 1

UPDATE ods.ApePedido
SET [AChequeo] = T.[AChequeo]
	,[FechaFact] = T.[FechaFact]
	,[Tiempo] = T.[Tiempo]
	,[ErrorEmbalaje] = T.[ErrorEmbalaje]
	,[Inducido] = T.[Inducido]
	,[IndFechaHora] = T.[IndFechaHora]
	,[Armado] = T.[Armado]
	,[Chequeado] = T.[Chequeado]
	,[CFechaHoraI] = T.[CFechaHoraI]
	,[CFechaHoraF] = T.[CFechaHoraF]
	,[EnDespacho] = T.[EnDespacho]
	,[EnTransporte] = T.[EnTransporte]
	,[DFechaHora] = T.[DFechaHora]
	,[TipoPedido] = T.[TipoPedido]
	,[CostoPedido] = T.[CostoPedido]
	,[OrdenImpreso] = T.[OrdenImpreso]
	,[FechaEntregado] = T.[FechaEntregado]
	,[NroCajas] = T.[NroCajas]
	,[IndEntregaEstimada] = T.[IndEntregaEstimada]
	,[FecHoraEntregaEstimadaDesde] = T.[FecHoraEntregaEstimadaDesde]
	,[FecHoraEntregaEstimadaHasta] = T.[FecHoraEntregaEstimadaHasta]
	,[IndTipoInformacion] = T.[IndTipoInformacion]
FROM ods.ApePedido A
INNER JOIN YobelPedidoTemp T ON A.NroPedido = T.NroPedido
	AND A.Campana = T.Campana
	AND A.Codigo = T.Codigo
WHERE T.Estado = 0
GO