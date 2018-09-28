GO
USE BelcorpPeru
GO

GO
ALTER PROCEDURE [dbo].[OfertaFinalMontoMeta_Select]
(
	@UpsellingId INT
)
AS
SET NOCOUNT ON;

SELECT ofm.CampaniaId AS Campania
	,c.Codigo AS Codigo
	,ISNULL(c.PrimerNombre, '')
		+ ' ' + ISNULL(c.SegundoNombre, '')
		+ ' ' + ISNULL(c.PrimerApellido, '')
		+ ' ' + ISNULL(c.SegundoApellido, '') AS Nombre
	,ud.CUV AS CuvRegalo
	,ud.Nombre AS NombreRegalo
	,ofm.MontoPedido AS MontoInicial
	,GapMinimo AS RangoInicial
	,GapMaximo AS RangoFinal
	,GapAgregar AS MontoAgregar
	,ofm.MontoMeta
	,ofm.MontoPedidoFinal AS MontoGanador
	,ofm.FechaRegistro AS FechaRegistro
	,pw.ImporteTotal as ImporteReal
	--ofm.MontoPedido
FROM OfertaFinalMontoMeta ofm
	INNER JOIN Upselling up
		ON up.CodigoCampana = ofm.CampaniaId
	INNER JOIN UpsellingDetalle ud
		ON ud.Upsellingid = up.Upsellingid
		AND ofm.CUV = ud.CUV
	INNER JOIN ods.consultora c
		ON ofm.ConsultoraId = c.ConsultoraId
	INNER JOIN PedidoWeb pw WITH (NOLOCK)
		ON ofm.CampaniaId = pw.CampaniaId
		and ofm.ConsultoraId = pw.ConsultoraId
WHERE up.Upsellingid = @UpsellingId
ORDER BY ofm.FechaRegistro DESC
GO

GO
USE BelcorpMexico
GO

GO
ALTER PROCEDURE [dbo].[OfertaFinalMontoMeta_Select]
(
	@UpsellingId INT
)
AS
SET NOCOUNT ON;

SELECT ofm.CampaniaId AS Campania
	,c.Codigo AS Codigo
	,ISNULL(c.PrimerNombre, '')
		+ ' ' + ISNULL(c.SegundoNombre, '')
		+ ' ' + ISNULL(c.PrimerApellido, '')
		+ ' ' + ISNULL(c.SegundoApellido, '') AS Nombre
	,ud.CUV AS CuvRegalo
	,ud.Nombre AS NombreRegalo
	,ofm.MontoPedido AS MontoInicial
	,GapMinimo AS RangoInicial
	,GapMaximo AS RangoFinal
	,GapAgregar AS MontoAgregar
	,ofm.MontoMeta
	,ofm.MontoPedidoFinal AS MontoGanador
	,ofm.FechaRegistro AS FechaRegistro
	,pw.ImporteTotal as ImporteReal
	--ofm.MontoPedido
FROM OfertaFinalMontoMeta ofm
	INNER JOIN Upselling up
		ON up.CodigoCampana = ofm.CampaniaId
	INNER JOIN UpsellingDetalle ud
		ON ud.Upsellingid = up.Upsellingid
		AND ofm.CUV = ud.CUV
	INNER JOIN ods.consultora c
		ON ofm.ConsultoraId = c.ConsultoraId
	INNER JOIN PedidoWeb pw WITH (NOLOCK)
		ON ofm.CampaniaId = pw.CampaniaId
		and ofm.ConsultoraId = pw.ConsultoraId
WHERE up.Upsellingid = @UpsellingId
ORDER BY ofm.FechaRegistro DESC
GO

GO
USE BelcorpColombia
GO

GO
ALTER PROCEDURE [dbo].[OfertaFinalMontoMeta_Select]
(
	@UpsellingId INT
)
AS
SET NOCOUNT ON;

SELECT ofm.CampaniaId AS Campania
	,c.Codigo AS Codigo
	,ISNULL(c.PrimerNombre, '')
		+ ' ' + ISNULL(c.SegundoNombre, '')
		+ ' ' + ISNULL(c.PrimerApellido, '')
		+ ' ' + ISNULL(c.SegundoApellido, '') AS Nombre
	,ud.CUV AS CuvRegalo
	,ud.Nombre AS NombreRegalo
	,ofm.MontoPedido AS MontoInicial
	,GapMinimo AS RangoInicial
	,GapMaximo AS RangoFinal
	,GapAgregar AS MontoAgregar
	,ofm.MontoMeta
	,ofm.MontoPedidoFinal AS MontoGanador
	,ofm.FechaRegistro AS FechaRegistro
	,pw.ImporteTotal as ImporteReal
	--ofm.MontoPedido
FROM OfertaFinalMontoMeta ofm
	INNER JOIN Upselling up
		ON up.CodigoCampana = ofm.CampaniaId
	INNER JOIN UpsellingDetalle ud
		ON ud.Upsellingid = up.Upsellingid
		AND ofm.CUV = ud.CUV
	INNER JOIN ods.consultora c
		ON ofm.ConsultoraId = c.ConsultoraId
	INNER JOIN PedidoWeb pw WITH (NOLOCK)
		ON ofm.CampaniaId = pw.CampaniaId
		and ofm.ConsultoraId = pw.ConsultoraId
WHERE up.Upsellingid = @UpsellingId
ORDER BY ofm.FechaRegistro DESC
GO

GO
USE BelcorpSalvador
GO

GO
ALTER PROCEDURE [dbo].[OfertaFinalMontoMeta_Select]
(
	@UpsellingId INT
)
AS
SET NOCOUNT ON;

SELECT ofm.CampaniaId AS Campania
	,c.Codigo AS Codigo
	,ISNULL(c.PrimerNombre, '')
		+ ' ' + ISNULL(c.SegundoNombre, '')
		+ ' ' + ISNULL(c.PrimerApellido, '')
		+ ' ' + ISNULL(c.SegundoApellido, '') AS Nombre
	,ud.CUV AS CuvRegalo
	,ud.Nombre AS NombreRegalo
	,ofm.MontoPedido AS MontoInicial
	,GapMinimo AS RangoInicial
	,GapMaximo AS RangoFinal
	,GapAgregar AS MontoAgregar
	,ofm.MontoMeta
	,ofm.MontoPedidoFinal AS MontoGanador
	,ofm.FechaRegistro AS FechaRegistro
	,pw.ImporteTotal as ImporteReal
	--ofm.MontoPedido
FROM OfertaFinalMontoMeta ofm
	INNER JOIN Upselling up
		ON up.CodigoCampana = ofm.CampaniaId
	INNER JOIN UpsellingDetalle ud
		ON ud.Upsellingid = up.Upsellingid
		AND ofm.CUV = ud.CUV
	INNER JOIN ods.consultora c
		ON ofm.ConsultoraId = c.ConsultoraId
	INNER JOIN PedidoWeb pw WITH (NOLOCK)
		ON ofm.CampaniaId = pw.CampaniaId
		and ofm.ConsultoraId = pw.ConsultoraId
WHERE up.Upsellingid = @UpsellingId
ORDER BY ofm.FechaRegistro DESC
GO

GO
USE BelcorpPuertoRico
GO

GO
ALTER PROCEDURE [dbo].[OfertaFinalMontoMeta_Select]
(
	@UpsellingId INT
)
AS
SET NOCOUNT ON;

SELECT ofm.CampaniaId AS Campania
	,c.Codigo AS Codigo
	,ISNULL(c.PrimerNombre, '')
		+ ' ' + ISNULL(c.SegundoNombre, '')
		+ ' ' + ISNULL(c.PrimerApellido, '')
		+ ' ' + ISNULL(c.SegundoApellido, '') AS Nombre
	,ud.CUV AS CuvRegalo
	,ud.Nombre AS NombreRegalo
	,ofm.MontoPedido AS MontoInicial
	,GapMinimo AS RangoInicial
	,GapMaximo AS RangoFinal
	,GapAgregar AS MontoAgregar
	,ofm.MontoMeta
	,ofm.MontoPedidoFinal AS MontoGanador
	,ofm.FechaRegistro AS FechaRegistro
	,pw.ImporteTotal as ImporteReal
	--ofm.MontoPedido
FROM OfertaFinalMontoMeta ofm
	INNER JOIN Upselling up
		ON up.CodigoCampana = ofm.CampaniaId
	INNER JOIN UpsellingDetalle ud
		ON ud.Upsellingid = up.Upsellingid
		AND ofm.CUV = ud.CUV
	INNER JOIN ods.consultora c
		ON ofm.ConsultoraId = c.ConsultoraId
	INNER JOIN PedidoWeb pw WITH (NOLOCK)
		ON ofm.CampaniaId = pw.CampaniaId
		and ofm.ConsultoraId = pw.ConsultoraId
WHERE up.Upsellingid = @UpsellingId
ORDER BY ofm.FechaRegistro DESC
GO

GO
USE BelcorpPanama
GO

GO
ALTER PROCEDURE [dbo].[OfertaFinalMontoMeta_Select]
(
	@UpsellingId INT
)
AS
SET NOCOUNT ON;

SELECT ofm.CampaniaId AS Campania
	,c.Codigo AS Codigo
	,ISNULL(c.PrimerNombre, '')
		+ ' ' + ISNULL(c.SegundoNombre, '')
		+ ' ' + ISNULL(c.PrimerApellido, '')
		+ ' ' + ISNULL(c.SegundoApellido, '') AS Nombre
	,ud.CUV AS CuvRegalo
	,ud.Nombre AS NombreRegalo
	,ofm.MontoPedido AS MontoInicial
	,GapMinimo AS RangoInicial
	,GapMaximo AS RangoFinal
	,GapAgregar AS MontoAgregar
	,ofm.MontoMeta
	,ofm.MontoPedidoFinal AS MontoGanador
	,ofm.FechaRegistro AS FechaRegistro
	,pw.ImporteTotal as ImporteReal
	--ofm.MontoPedido
FROM OfertaFinalMontoMeta ofm
	INNER JOIN Upselling up
		ON up.CodigoCampana = ofm.CampaniaId
	INNER JOIN UpsellingDetalle ud
		ON ud.Upsellingid = up.Upsellingid
		AND ofm.CUV = ud.CUV
	INNER JOIN ods.consultora c
		ON ofm.ConsultoraId = c.ConsultoraId
	INNER JOIN PedidoWeb pw WITH (NOLOCK)
		ON ofm.CampaniaId = pw.CampaniaId
		and ofm.ConsultoraId = pw.ConsultoraId
WHERE up.Upsellingid = @UpsellingId
ORDER BY ofm.FechaRegistro DESC
GO

GO
USE BelcorpGuatemala
GO

GO
ALTER PROCEDURE [dbo].[OfertaFinalMontoMeta_Select]
(
	@UpsellingId INT
)
AS
SET NOCOUNT ON;

SELECT ofm.CampaniaId AS Campania
	,c.Codigo AS Codigo
	,ISNULL(c.PrimerNombre, '')
		+ ' ' + ISNULL(c.SegundoNombre, '')
		+ ' ' + ISNULL(c.PrimerApellido, '')
		+ ' ' + ISNULL(c.SegundoApellido, '') AS Nombre
	,ud.CUV AS CuvRegalo
	,ud.Nombre AS NombreRegalo
	,ofm.MontoPedido AS MontoInicial
	,GapMinimo AS RangoInicial
	,GapMaximo AS RangoFinal
	,GapAgregar AS MontoAgregar
	,ofm.MontoMeta
	,ofm.MontoPedidoFinal AS MontoGanador
	,ofm.FechaRegistro AS FechaRegistro
	,pw.ImporteTotal as ImporteReal
	--ofm.MontoPedido
FROM OfertaFinalMontoMeta ofm
	INNER JOIN Upselling up
		ON up.CodigoCampana = ofm.CampaniaId
	INNER JOIN UpsellingDetalle ud
		ON ud.Upsellingid = up.Upsellingid
		AND ofm.CUV = ud.CUV
	INNER JOIN ods.consultora c
		ON ofm.ConsultoraId = c.ConsultoraId
	INNER JOIN PedidoWeb pw WITH (NOLOCK)
		ON ofm.CampaniaId = pw.CampaniaId
		and ofm.ConsultoraId = pw.ConsultoraId
WHERE up.Upsellingid = @UpsellingId
ORDER BY ofm.FechaRegistro DESC
GO

GO
USE BelcorpEcuador
GO

GO
ALTER PROCEDURE [dbo].[OfertaFinalMontoMeta_Select]
(
	@UpsellingId INT
)
AS
SET NOCOUNT ON;

SELECT ofm.CampaniaId AS Campania
	,c.Codigo AS Codigo
	,ISNULL(c.PrimerNombre, '')
		+ ' ' + ISNULL(c.SegundoNombre, '')
		+ ' ' + ISNULL(c.PrimerApellido, '')
		+ ' ' + ISNULL(c.SegundoApellido, '') AS Nombre
	,ud.CUV AS CuvRegalo
	,ud.Nombre AS NombreRegalo
	,ofm.MontoPedido AS MontoInicial
	,GapMinimo AS RangoInicial
	,GapMaximo AS RangoFinal
	,GapAgregar AS MontoAgregar
	,ofm.MontoMeta
	,ofm.MontoPedidoFinal AS MontoGanador
	,ofm.FechaRegistro AS FechaRegistro
	,pw.ImporteTotal as ImporteReal
	--ofm.MontoPedido
FROM OfertaFinalMontoMeta ofm
	INNER JOIN Upselling up
		ON up.CodigoCampana = ofm.CampaniaId
	INNER JOIN UpsellingDetalle ud
		ON ud.Upsellingid = up.Upsellingid
		AND ofm.CUV = ud.CUV
	INNER JOIN ods.consultora c
		ON ofm.ConsultoraId = c.ConsultoraId
	INNER JOIN PedidoWeb pw WITH (NOLOCK)
		ON ofm.CampaniaId = pw.CampaniaId
		and ofm.ConsultoraId = pw.ConsultoraId
WHERE up.Upsellingid = @UpsellingId
ORDER BY ofm.FechaRegistro DESC
GO

GO
USE BelcorpDominicana
GO

GO
ALTER PROCEDURE [dbo].[OfertaFinalMontoMeta_Select]
(
	@UpsellingId INT
)
AS
SET NOCOUNT ON;

SELECT ofm.CampaniaId AS Campania
	,c.Codigo AS Codigo
	,ISNULL(c.PrimerNombre, '')
		+ ' ' + ISNULL(c.SegundoNombre, '')
		+ ' ' + ISNULL(c.PrimerApellido, '')
		+ ' ' + ISNULL(c.SegundoApellido, '') AS Nombre
	,ud.CUV AS CuvRegalo
	,ud.Nombre AS NombreRegalo
	,ofm.MontoPedido AS MontoInicial
	,GapMinimo AS RangoInicial
	,GapMaximo AS RangoFinal
	,GapAgregar AS MontoAgregar
	,ofm.MontoMeta
	,ofm.MontoPedidoFinal AS MontoGanador
	,ofm.FechaRegistro AS FechaRegistro
	,pw.ImporteTotal as ImporteReal
	--ofm.MontoPedido
FROM OfertaFinalMontoMeta ofm
	INNER JOIN Upselling up
		ON up.CodigoCampana = ofm.CampaniaId
	INNER JOIN UpsellingDetalle ud
		ON ud.Upsellingid = up.Upsellingid
		AND ofm.CUV = ud.CUV
	INNER JOIN ods.consultora c
		ON ofm.ConsultoraId = c.ConsultoraId
	INNER JOIN PedidoWeb pw WITH (NOLOCK)
		ON ofm.CampaniaId = pw.CampaniaId
		and ofm.ConsultoraId = pw.ConsultoraId
WHERE up.Upsellingid = @UpsellingId
ORDER BY ofm.FechaRegistro DESC
GO

GO
USE BelcorpCostaRica
GO

GO
ALTER PROCEDURE [dbo].[OfertaFinalMontoMeta_Select]
(
	@UpsellingId INT
)
AS
SET NOCOUNT ON;

SELECT ofm.CampaniaId AS Campania
	,c.Codigo AS Codigo
	,ISNULL(c.PrimerNombre, '')
		+ ' ' + ISNULL(c.SegundoNombre, '')
		+ ' ' + ISNULL(c.PrimerApellido, '')
		+ ' ' + ISNULL(c.SegundoApellido, '') AS Nombre
	,ud.CUV AS CuvRegalo
	,ud.Nombre AS NombreRegalo
	,ofm.MontoPedido AS MontoInicial
	,GapMinimo AS RangoInicial
	,GapMaximo AS RangoFinal
	,GapAgregar AS MontoAgregar
	,ofm.MontoMeta
	,ofm.MontoPedidoFinal AS MontoGanador
	,ofm.FechaRegistro AS FechaRegistro
	,pw.ImporteTotal as ImporteReal
	--ofm.MontoPedido
FROM OfertaFinalMontoMeta ofm
	INNER JOIN Upselling up
		ON up.CodigoCampana = ofm.CampaniaId
	INNER JOIN UpsellingDetalle ud
		ON ud.Upsellingid = up.Upsellingid
		AND ofm.CUV = ud.CUV
	INNER JOIN ods.consultora c
		ON ofm.ConsultoraId = c.ConsultoraId
	INNER JOIN PedidoWeb pw WITH (NOLOCK)
		ON ofm.CampaniaId = pw.CampaniaId
		and ofm.ConsultoraId = pw.ConsultoraId
WHERE up.Upsellingid = @UpsellingId
ORDER BY ofm.FechaRegistro DESC
GO

GO
USE BelcorpChile
GO

GO
ALTER PROCEDURE [dbo].[OfertaFinalMontoMeta_Select]
(
	@UpsellingId INT
)
AS
SET NOCOUNT ON;

SELECT ofm.CampaniaId AS Campania
	,c.Codigo AS Codigo
	,ISNULL(c.PrimerNombre, '')
		+ ' ' + ISNULL(c.SegundoNombre, '')
		+ ' ' + ISNULL(c.PrimerApellido, '')
		+ ' ' + ISNULL(c.SegundoApellido, '') AS Nombre
	,ud.CUV AS CuvRegalo
	,ud.Nombre AS NombreRegalo
	,ofm.MontoPedido AS MontoInicial
	,GapMinimo AS RangoInicial
	,GapMaximo AS RangoFinal
	,GapAgregar AS MontoAgregar
	,ofm.MontoMeta
	,ofm.MontoPedidoFinal AS MontoGanador
	,ofm.FechaRegistro AS FechaRegistro
	,pw.ImporteTotal as ImporteReal
	--ofm.MontoPedido
FROM OfertaFinalMontoMeta ofm
	INNER JOIN Upselling up
		ON up.CodigoCampana = ofm.CampaniaId
	INNER JOIN UpsellingDetalle ud
		ON ud.Upsellingid = up.Upsellingid
		AND ofm.CUV = ud.CUV
	INNER JOIN ods.consultora c
		ON ofm.ConsultoraId = c.ConsultoraId
	INNER JOIN PedidoWeb pw WITH (NOLOCK)
		ON ofm.CampaniaId = pw.CampaniaId
		and ofm.ConsultoraId = pw.ConsultoraId
WHERE up.Upsellingid = @UpsellingId
ORDER BY ofm.FechaRegistro DESC
GO

GO
USE BelcorpBolivia
GO

GO
ALTER PROCEDURE [dbo].[OfertaFinalMontoMeta_Select]
(
	@UpsellingId INT
)
AS
SET NOCOUNT ON;

SELECT ofm.CampaniaId AS Campania
	,c.Codigo AS Codigo
	,ISNULL(c.PrimerNombre, '')
		+ ' ' + ISNULL(c.SegundoNombre, '')
		+ ' ' + ISNULL(c.PrimerApellido, '')
		+ ' ' + ISNULL(c.SegundoApellido, '') AS Nombre
	,ud.CUV AS CuvRegalo
	,ud.Nombre AS NombreRegalo
	,ofm.MontoPedido AS MontoInicial
	,GapMinimo AS RangoInicial
	,GapMaximo AS RangoFinal
	,GapAgregar AS MontoAgregar
	,ofm.MontoMeta
	,ofm.MontoPedidoFinal AS MontoGanador
	,ofm.FechaRegistro AS FechaRegistro
	,pw.ImporteTotal as ImporteReal
	--ofm.MontoPedido
FROM OfertaFinalMontoMeta ofm
	INNER JOIN Upselling up
		ON up.CodigoCampana = ofm.CampaniaId
	INNER JOIN UpsellingDetalle ud
		ON ud.Upsellingid = up.Upsellingid
		AND ofm.CUV = ud.CUV
	INNER JOIN ods.consultora c
		ON ofm.ConsultoraId = c.ConsultoraId
	INNER JOIN PedidoWeb pw WITH (NOLOCK)
		ON ofm.CampaniaId = pw.CampaniaId
		and ofm.ConsultoraId = pw.ConsultoraId
WHERE up.Upsellingid = @UpsellingId
ORDER BY ofm.FechaRegistro DESC
GO

GO
