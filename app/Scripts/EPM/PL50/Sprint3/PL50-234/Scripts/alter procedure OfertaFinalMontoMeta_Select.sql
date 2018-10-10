USE Belcorpmexico_pl50
GO

IF (OBJECT_ID('dbo.OfertaFinalMontoMeta_Select', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.OfertaFinalMontoMeta_Select AS SET NOCOUNT ON;')
GO


alter PROCEDURE [dbo].OfertaFinalMontoMeta_Select (@UpsellingId INT)
AS
SET NOCOUNT ON;

SELECT ofmm.CampaniaId AS Campania
	,c.Codigo AS Codigo
	,isnull(c.PrimerNombre, '') + ' ' + isnull(c.SegundoNombre, '') + ' ' + isnull(c.PrimerApellido, '') + ' ' + isnull(c.SegundoApellido, '') AS Nombre
	,u.CUV AS CuvRegalo
	,u.Nombre AS NombreRegalo
	,ofmm.MontoMeta AS MontoInicial
	,GapMinimo AS RangoInicial
	,GapMaximo AS RangoFinal
	,GapAgregar AS MontoAgregar
	,ofmm.MontoMeta
	,ofmm.MontoPedidoFinal AS MontoGanador
	,ofmm.FechaRegistro AS FechaRegistro
	,ofmm.MontoPedido
FROM OfertaFinalMontoMeta ofmm
INNER JOIN ods.consultora c ON ofmm.ConsultoraId = c.ConsultoraId
INNER JOIN UpsellingDetalle u ON u.Upsellingid = @UpsellingId
	AND u.CUV = ofmm.Cuv
ORDER BY ofmm.FechaRegistro DESC


go