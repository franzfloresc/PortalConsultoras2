USE BelcorpPeru
GO
ALTER PROCEDURE [dbo].[GetTrackingByConsultoraCampaniaFecha]
(
@CodigoConsultora AS VARCHAR(20),
@Campana AS VARCHAR(6),
--@Fecha AS DATETIME
@NroPedido AS VARCHAR(50)
)
AS
BEGIN
SET NOCOUNT ON;
SELECT DISTINCT
S.ID AS Etapa,
S.Situacion,
CASE WHEN S.ID=1 THEN T.FechaDigitado ELSE
CASE WHEN S.ID=2 THEN T.Facturado ELSE
CASE WHEN S.ID=3 THEN T.EnArmado ELSE
CASE WHEN S.ID=4 THEN T.Chequeado ELSE
CASE WHEN S.ID=5 THEN T.Despachado ELSE
CASE WHEN S.ID=6 THEN T.FechaEstimada ELSE
CASE WHEN S.ID=7 THEN
CASE WHEN NOT T.Despachado IS NULL
THEN T.Recibido ELSE NULL END ELSE NULL
END
END
END
END
END
END
END AS Fecha,
CASE WHEN S.ID = 6 THEN ps.ValorTurno ELSE NULL END ValorTurno
FROM vwSituacionPedido S, vwTracking T
LEFT JOIN ods.PedidoSeguimiento ps on T.Campana = ps.AnoCampana and T.Consultora = ps.CodigoConsultora
WHERE T.Consultora = @CodigoConsultora AND
T.Campana = @Campana AND
--CONVERT(varchar(8),T.FechaDigitado,112) = CONVERT(varchar(8),@Fecha,112) and S.ID in (1,2,3,5,6,7)
T.NroPedido = @NroPedido AND 
S.ID IN (1,2,3,5,6,7)
END
GO