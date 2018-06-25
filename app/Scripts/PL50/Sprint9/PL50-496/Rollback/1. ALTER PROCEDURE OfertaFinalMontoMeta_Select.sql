
USE BelcorpBolivia
GO

IF (OBJECT_ID('dbo.OfertaFinalMontoMeta_Select', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.OfertaFinalMontoMeta_Select AS SET NOCOUNT ON;')
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

IF (OBJECT_ID('dbo.OfertaFinalMontoMeta_Select', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.OfertaFinalMontoMeta_Select AS SET NOCOUNT ON;')
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

IF (OBJECT_ID('dbo.OfertaFinalMontoMeta_Select', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.OfertaFinalMontoMeta_Select AS SET NOCOUNT ON;')
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

IF (OBJECT_ID('dbo.OfertaFinalMontoMeta_Select', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.OfertaFinalMontoMeta_Select AS SET NOCOUNT ON;')
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

IF (OBJECT_ID('dbo.OfertaFinalMontoMeta_Select', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.OfertaFinalMontoMeta_Select AS SET NOCOUNT ON;')
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

IF (OBJECT_ID('dbo.OfertaFinalMontoMeta_Select', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.OfertaFinalMontoMeta_Select AS SET NOCOUNT ON;')
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

IF (OBJECT_ID('dbo.OfertaFinalMontoMeta_Select', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.OfertaFinalMontoMeta_Select AS SET NOCOUNT ON;')
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

IF (OBJECT_ID('dbo.OfertaFinalMontoMeta_Select', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.OfertaFinalMontoMeta_Select AS SET NOCOUNT ON;')
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

IF (OBJECT_ID('dbo.OfertaFinalMontoMeta_Select', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.OfertaFinalMontoMeta_Select AS SET NOCOUNT ON;')
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

IF (OBJECT_ID('dbo.OfertaFinalMontoMeta_Select', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.OfertaFinalMontoMeta_Select AS SET NOCOUNT ON;')
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

IF (OBJECT_ID('dbo.OfertaFinalMontoMeta_Select', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.OfertaFinalMontoMeta_Select AS SET NOCOUNT ON;')
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

IF (OBJECT_ID('dbo.OfertaFinalMontoMeta_Select', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE dbo.OfertaFinalMontoMeta_Select AS SET NOCOUNT ON;')
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
