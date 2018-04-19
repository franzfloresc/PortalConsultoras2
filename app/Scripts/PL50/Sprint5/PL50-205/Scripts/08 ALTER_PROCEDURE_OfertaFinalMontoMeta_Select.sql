

USE BelcorpBolivia
GO

ALTER PROCEDURE [dbo].[OfertaFinalMontoMeta_Select] (@UpsellingId int)
AS
	SET NOCOUNT ON;
	SELECT
		ofm.CampaniaId AS Campania,
		c.Codigo AS Codigo,
		ISNULL(c.PrimerNombre, '') + ' ' + ISNULL(c.SegundoNombre, '') + ' ' + ISNULL(c.PrimerApellido, '') + ' ' + ISNULL(c.SegundoApellido, '') AS Nombre,
		ud.CUV AS CuvRegalo,
		ud.Nombre AS NombreRegalo,
		ofm.MontoPedido AS MontoInicial,
		GapMinimo AS RangoInicial,
		GapMaximo AS RangoFinal,
		GapAgregar AS MontoAgregar,
		ofm.MontoMeta,
		ofm.MontoPedidoFinal AS MontoGanador,
		ofm.FechaRegistro AS FechaRegistro
		--ofm.MontoPedido
	FROM OfertaFinalMontoMeta ofm   
	INNER JOIN Upselling up ON up.CodigoCampana = ofm.CampaniaId
	INNER JOIN UpsellingDetalle ud ON ud.Upsellingid = up.Upsellingid
		AND ofm.CUV = ud.CUV
	INNER JOIN ods.consultora c ON ofm.ConsultoraId = c.ConsultoraId
	WHERE up.Upsellingid = @UpsellingId
	ORDER BY ofm.FechaRegistro DESC
GO

USE BelcorpChile
GO

ALTER PROCEDURE [dbo].[OfertaFinalMontoMeta_Select] (@UpsellingId int)
AS
	SET NOCOUNT ON;
	SELECT
		ofm.CampaniaId AS Campania,
		c.Codigo AS Codigo,
		ISNULL(c.PrimerNombre, '') + ' ' + ISNULL(c.SegundoNombre, '') + ' ' + ISNULL(c.PrimerApellido, '') + ' ' + ISNULL(c.SegundoApellido, '') AS Nombre,
		ud.CUV AS CuvRegalo,
		ud.Nombre AS NombreRegalo,
		ofm.MontoPedido AS MontoInicial,
		GapMinimo AS RangoInicial,
		GapMaximo AS RangoFinal,
		GapAgregar AS MontoAgregar,
		ofm.MontoMeta,
		ofm.MontoPedidoFinal AS MontoGanador,
		ofm.FechaRegistro AS FechaRegistro
		--ofm.MontoPedido
	FROM OfertaFinalMontoMeta ofm   
	INNER JOIN Upselling up ON up.CodigoCampana = ofm.CampaniaId
	INNER JOIN UpsellingDetalle ud ON ud.Upsellingid = up.Upsellingid
		AND ofm.CUV = ud.CUV
	INNER JOIN ods.consultora c ON ofm.ConsultoraId = c.ConsultoraId
	WHERE up.Upsellingid = @UpsellingId
	ORDER BY ofm.FechaRegistro DESC
GO

USE BelcorpColombia
GO

ALTER PROCEDURE [dbo].[OfertaFinalMontoMeta_Select] (@UpsellingId int)
AS
	SET NOCOUNT ON;
	SELECT
		ofm.CampaniaId AS Campania,
		c.Codigo AS Codigo,
		ISNULL(c.PrimerNombre, '') + ' ' + ISNULL(c.SegundoNombre, '') + ' ' + ISNULL(c.PrimerApellido, '') + ' ' + ISNULL(c.SegundoApellido, '') AS Nombre,
		ud.CUV AS CuvRegalo,
		ud.Nombre AS NombreRegalo,
		ofm.MontoPedido AS MontoInicial,
		GapMinimo AS RangoInicial,
		GapMaximo AS RangoFinal,
		GapAgregar AS MontoAgregar,
		ofm.MontoMeta,
		ofm.MontoPedidoFinal AS MontoGanador,
		ofm.FechaRegistro AS FechaRegistro
		--ofm.MontoPedido
	FROM OfertaFinalMontoMeta ofm   
	INNER JOIN Upselling up ON up.CodigoCampana = ofm.CampaniaId
	INNER JOIN UpsellingDetalle ud ON ud.Upsellingid = up.Upsellingid
		AND ofm.CUV = ud.CUV
	INNER JOIN ods.consultora c ON ofm.ConsultoraId = c.ConsultoraId
	WHERE up.Upsellingid = @UpsellingId
	ORDER BY ofm.FechaRegistro DESC
GO

USE BelcorpCostaRica
GO

ALTER PROCEDURE [dbo].[OfertaFinalMontoMeta_Select] (@UpsellingId int)
AS
	SET NOCOUNT ON;
	SELECT
		ofm.CampaniaId AS Campania,
		c.Codigo AS Codigo,
		ISNULL(c.PrimerNombre, '') + ' ' + ISNULL(c.SegundoNombre, '') + ' ' + ISNULL(c.PrimerApellido, '') + ' ' + ISNULL(c.SegundoApellido, '') AS Nombre,
		ud.CUV AS CuvRegalo,
		ud.Nombre AS NombreRegalo,
		ofm.MontoPedido AS MontoInicial,
		GapMinimo AS RangoInicial,
		GapMaximo AS RangoFinal,
		GapAgregar AS MontoAgregar,
		ofm.MontoMeta,
		ofm.MontoPedidoFinal AS MontoGanador,
		ofm.FechaRegistro AS FechaRegistro
		--ofm.MontoPedido
	FROM OfertaFinalMontoMeta ofm   
	INNER JOIN Upselling up ON up.CodigoCampana = ofm.CampaniaId
	INNER JOIN UpsellingDetalle ud ON ud.Upsellingid = up.Upsellingid
		AND ofm.CUV = ud.CUV
	INNER JOIN ods.consultora c ON ofm.ConsultoraId = c.ConsultoraId
	WHERE up.Upsellingid = @UpsellingId
	ORDER BY ofm.FechaRegistro DESC
GO

USE BelcorpDominicana
GO

ALTER PROCEDURE [dbo].[OfertaFinalMontoMeta_Select] (@UpsellingId int)
AS
	SET NOCOUNT ON;
	SELECT
		ofm.CampaniaId AS Campania,
		c.Codigo AS Codigo,
		ISNULL(c.PrimerNombre, '') + ' ' + ISNULL(c.SegundoNombre, '') + ' ' + ISNULL(c.PrimerApellido, '') + ' ' + ISNULL(c.SegundoApellido, '') AS Nombre,
		ud.CUV AS CuvRegalo,
		ud.Nombre AS NombreRegalo,
		ofm.MontoPedido AS MontoInicial,
		GapMinimo AS RangoInicial,
		GapMaximo AS RangoFinal,
		GapAgregar AS MontoAgregar,
		ofm.MontoMeta,
		ofm.MontoPedidoFinal AS MontoGanador,
		ofm.FechaRegistro AS FechaRegistro
		--ofm.MontoPedido
	FROM OfertaFinalMontoMeta ofm   
	INNER JOIN Upselling up ON up.CodigoCampana = ofm.CampaniaId
	INNER JOIN UpsellingDetalle ud ON ud.Upsellingid = up.Upsellingid
		AND ofm.CUV = ud.CUV
	INNER JOIN ods.consultora c ON ofm.ConsultoraId = c.ConsultoraId
	WHERE up.Upsellingid = @UpsellingId
	ORDER BY ofm.FechaRegistro DESC
GO

USE BelcorpEcuador
GO

ALTER PROCEDURE [dbo].[OfertaFinalMontoMeta_Select] (@UpsellingId int)
AS
	SET NOCOUNT ON;
	SELECT
		ofm.CampaniaId AS Campania,
		c.Codigo AS Codigo,
		ISNULL(c.PrimerNombre, '') + ' ' + ISNULL(c.SegundoNombre, '') + ' ' + ISNULL(c.PrimerApellido, '') + ' ' + ISNULL(c.SegundoApellido, '') AS Nombre,
		ud.CUV AS CuvRegalo,
		ud.Nombre AS NombreRegalo,
		ofm.MontoPedido AS MontoInicial,
		GapMinimo AS RangoInicial,
		GapMaximo AS RangoFinal,
		GapAgregar AS MontoAgregar,
		ofm.MontoMeta,
		ofm.MontoPedidoFinal AS MontoGanador,
		ofm.FechaRegistro AS FechaRegistro
		--ofm.MontoPedido
	FROM OfertaFinalMontoMeta ofm   
	INNER JOIN Upselling up ON up.CodigoCampana = ofm.CampaniaId
	INNER JOIN UpsellingDetalle ud ON ud.Upsellingid = up.Upsellingid
		AND ofm.CUV = ud.CUV
	INNER JOIN ods.consultora c ON ofm.ConsultoraId = c.ConsultoraId
	WHERE up.Upsellingid = @UpsellingId
	ORDER BY ofm.FechaRegistro DESC
GO

USE BelcorpGuatemala
GO

ALTER PROCEDURE [dbo].[OfertaFinalMontoMeta_Select] (@UpsellingId int)
AS
	SET NOCOUNT ON;
	SELECT
		ofm.CampaniaId AS Campania,
		c.Codigo AS Codigo,
		ISNULL(c.PrimerNombre, '') + ' ' + ISNULL(c.SegundoNombre, '') + ' ' + ISNULL(c.PrimerApellido, '') + ' ' + ISNULL(c.SegundoApellido, '') AS Nombre,
		ud.CUV AS CuvRegalo,
		ud.Nombre AS NombreRegalo,
		ofm.MontoPedido AS MontoInicial,
		GapMinimo AS RangoInicial,
		GapMaximo AS RangoFinal,
		GapAgregar AS MontoAgregar,
		ofm.MontoMeta,
		ofm.MontoPedidoFinal AS MontoGanador,
		ofm.FechaRegistro AS FechaRegistro
		--ofm.MontoPedido
	FROM OfertaFinalMontoMeta ofm   
	INNER JOIN Upselling up ON up.CodigoCampana = ofm.CampaniaId
	INNER JOIN UpsellingDetalle ud ON ud.Upsellingid = up.Upsellingid
		AND ofm.CUV = ud.CUV
	INNER JOIN ods.consultora c ON ofm.ConsultoraId = c.ConsultoraId
	WHERE up.Upsellingid = @UpsellingId
	ORDER BY ofm.FechaRegistro DESC
GO

USE BelcorpMexico
GO

ALTER PROCEDURE [dbo].[OfertaFinalMontoMeta_Select] (@UpsellingId int)
AS
	SET NOCOUNT ON;
	SELECT
		ofm.CampaniaId AS Campania,
		c.Codigo AS Codigo,
		ISNULL(c.PrimerNombre, '') + ' ' + ISNULL(c.SegundoNombre, '') + ' ' + ISNULL(c.PrimerApellido, '') + ' ' + ISNULL(c.SegundoApellido, '') AS Nombre,
		ud.CUV AS CuvRegalo,
		ud.Nombre AS NombreRegalo,
		ofm.MontoPedido AS MontoInicial,
		GapMinimo AS RangoInicial,
		GapMaximo AS RangoFinal,
		GapAgregar AS MontoAgregar,
		ofm.MontoMeta,
		ofm.MontoPedidoFinal AS MontoGanador,
		ofm.FechaRegistro AS FechaRegistro
		--ofm.MontoPedido
	FROM OfertaFinalMontoMeta ofm   
	INNER JOIN Upselling up ON up.CodigoCampana = ofm.CampaniaId
	INNER JOIN UpsellingDetalle ud ON ud.Upsellingid = up.Upsellingid
		AND ofm.CUV = ud.CUV
	INNER JOIN ods.consultora c ON ofm.ConsultoraId = c.ConsultoraId
	WHERE up.Upsellingid = @UpsellingId
	ORDER BY ofm.FechaRegistro DESC
GO

USE BelcorpPanama
GO

ALTER PROCEDURE [dbo].[OfertaFinalMontoMeta_Select] (@UpsellingId int)
AS
	SET NOCOUNT ON;
	SELECT
		ofm.CampaniaId AS Campania,
		c.Codigo AS Codigo,
		ISNULL(c.PrimerNombre, '') + ' ' + ISNULL(c.SegundoNombre, '') + ' ' + ISNULL(c.PrimerApellido, '') + ' ' + ISNULL(c.SegundoApellido, '') AS Nombre,
		ud.CUV AS CuvRegalo,
		ud.Nombre AS NombreRegalo,
		ofm.MontoPedido AS MontoInicial,
		GapMinimo AS RangoInicial,
		GapMaximo AS RangoFinal,
		GapAgregar AS MontoAgregar,
		ofm.MontoMeta,
		ofm.MontoPedidoFinal AS MontoGanador,
		ofm.FechaRegistro AS FechaRegistro
		--ofm.MontoPedido
	FROM OfertaFinalMontoMeta ofm   
	INNER JOIN Upselling up ON up.CodigoCampana = ofm.CampaniaId
	INNER JOIN UpsellingDetalle ud ON ud.Upsellingid = up.Upsellingid
		AND ofm.CUV = ud.CUV
	INNER JOIN ods.consultora c ON ofm.ConsultoraId = c.ConsultoraId
	WHERE up.Upsellingid = @UpsellingId
	ORDER BY ofm.FechaRegistro DESC
GO

USE BelcorpPeru
GO

ALTER PROCEDURE [dbo].[OfertaFinalMontoMeta_Select] (@UpsellingId int)
AS
	SET NOCOUNT ON;
	SELECT
		ofm.CampaniaId AS Campania,
		c.Codigo AS Codigo,
		ISNULL(c.PrimerNombre, '') + ' ' + ISNULL(c.SegundoNombre, '') + ' ' + ISNULL(c.PrimerApellido, '') + ' ' + ISNULL(c.SegundoApellido, '') AS Nombre,
		ud.CUV AS CuvRegalo,
		ud.Nombre AS NombreRegalo,
		ofm.MontoPedido AS MontoInicial,
		GapMinimo AS RangoInicial,
		GapMaximo AS RangoFinal,
		GapAgregar AS MontoAgregar,
		ofm.MontoMeta,
		ofm.MontoPedidoFinal AS MontoGanador,
		ofm.FechaRegistro AS FechaRegistro
		--ofm.MontoPedido
	FROM OfertaFinalMontoMeta ofm   
	INNER JOIN Upselling up ON up.CodigoCampana = ofm.CampaniaId
	INNER JOIN UpsellingDetalle ud ON ud.Upsellingid = up.Upsellingid
		AND ofm.CUV = ud.CUV
	INNER JOIN ods.consultora c ON ofm.ConsultoraId = c.ConsultoraId
	WHERE up.Upsellingid = @UpsellingId
	ORDER BY ofm.FechaRegistro DESC
GO

USE BelcorpPuertoRico
GO


ALTER PROCEDURE [dbo].[OfertaFinalMontoMeta_Select] (@UpsellingId int)
AS
	SET NOCOUNT ON;
	SELECT
		ofm.CampaniaId AS Campania,
		c.Codigo AS Codigo,
		ISNULL(c.PrimerNombre, '') + ' ' + ISNULL(c.SegundoNombre, '') + ' ' + ISNULL(c.PrimerApellido, '') + ' ' + ISNULL(c.SegundoApellido, '') AS Nombre,
		ud.CUV AS CuvRegalo,
		ud.Nombre AS NombreRegalo,
		ofm.MontoPedido AS MontoInicial,
		GapMinimo AS RangoInicial,
		GapMaximo AS RangoFinal,
		GapAgregar AS MontoAgregar,
		ofm.MontoMeta,
		ofm.MontoPedidoFinal AS MontoGanador,
		ofm.FechaRegistro AS FechaRegistro
		--ofm.MontoPedido
	FROM OfertaFinalMontoMeta ofm   
	INNER JOIN Upselling up ON up.CodigoCampana = ofm.CampaniaId
	INNER JOIN UpsellingDetalle ud ON ud.Upsellingid = up.Upsellingid
		AND ofm.CUV = ud.CUV
	INNER JOIN ods.consultora c ON ofm.ConsultoraId = c.ConsultoraId
	WHERE up.Upsellingid = @UpsellingId
	ORDER BY ofm.FechaRegistro DESC
GO

USE BelcorpSalvador
GO

ALTER PROCEDURE [dbo].[OfertaFinalMontoMeta_Select] (@UpsellingId int)
AS
	SET NOCOUNT ON;
	SELECT
		ofm.CampaniaId AS Campania,
		c.Codigo AS Codigo,
		ISNULL(c.PrimerNombre, '') + ' ' + ISNULL(c.SegundoNombre, '') + ' ' + ISNULL(c.PrimerApellido, '') + ' ' + ISNULL(c.SegundoApellido, '') AS Nombre,
		ud.CUV AS CuvRegalo,
		ud.Nombre AS NombreRegalo,
		ofm.MontoPedido AS MontoInicial,
		GapMinimo AS RangoInicial,
		GapMaximo AS RangoFinal,
		GapAgregar AS MontoAgregar,
		ofm.MontoMeta,
		ofm.MontoPedidoFinal AS MontoGanador,
		ofm.FechaRegistro AS FechaRegistro
		--ofm.MontoPedido
	FROM OfertaFinalMontoMeta ofm   
	INNER JOIN Upselling up ON up.CodigoCampana = ofm.CampaniaId
	INNER JOIN UpsellingDetalle ud ON ud.Upsellingid = up.Upsellingid
		AND ofm.CUV = ud.CUV
	INNER JOIN ods.consultora c ON ofm.ConsultoraId = c.ConsultoraId
	WHERE up.Upsellingid = @UpsellingId
	ORDER BY ofm.FechaRegistro DESC
GO

