USE belcorpPeru_pl50
GO
IF (OBJECT_ID('dbo.OfertaFinalMontoMeta_Select', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.OfertaFinalMontoMeta_Select AS SET NOCOUNT ON;')
GO
alter PROCEDURE [dbo].[OfertaFinalMontoMeta_Select] (@UpsellingId INT)
AS
SET NOCOUNT ON;

SELECT ofm.CampaniaId AS Campania
	,c.Codigo AS Codigo
	,ISNULL(c.PrimerNombre, '') + ' ' + ISNULL(c.SegundoNombre, '') + ' ' + ISNULL(c.PrimerApellido, '') + ' ' + ISNULL(c.SegundoApellido, '') AS Nombre
	,ud.CUV AS CuvRegalo
	,ud.Nombre AS NombreRegalo
	,ofm.MontoPedido AS MontoInicial
	,GapMinimo AS RangoInicial
	,GapMaximo AS RangoFinal
	,GapAgregar AS MontoAgregar
	,ofm.MontoMeta
	,ofm.MontoPedidoFinal AS MontoGanador
	,ofm.FechaRegistro AS FechaRegistro
	, pw.ImporteTotal as ImporteReal
--ofm.MontoPedido
FROM OfertaFinalMontoMeta ofm
INNER JOIN Upselling up ON up.CodigoCampana = ofm.CampaniaId
INNER JOIN UpsellingDetalle ud ON ud.Upsellingid = up.Upsellingid
	AND ofm.CUV = ud.CUV
INNER JOIN ods.consultora c ON ofm.ConsultoraId = c.ConsultoraId
inner join PedidoWeb pw with (nolock) on ofm.CampaniaId = pw.CampaniaId and ofm.ConsultoraId = pw.ConsultoraId
WHERE up.Upsellingid = @UpsellingId
ORDER BY ofm.FechaRegistro DESC
GO
