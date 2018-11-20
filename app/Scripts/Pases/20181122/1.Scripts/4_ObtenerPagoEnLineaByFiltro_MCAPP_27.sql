USE BelcorpPeru
GO

/* PROCEDURE ObtenerPagoEnLineaByFiltro */
IF (OBJECT_ID ( 'dbo.ObtenerPagoEnLineaByFiltro', 'P' ) IS NULL)
    EXEC('CREATE PROCEDURE dbo.ObtenerPagoEnLineaByFiltro AS SET NOCOUNT ON;')
GO

ALTER PROCEDURE [dbo].[ObtenerPagoEnLineaByFiltro] (
	@CampaniaID INT = 0,
	@RegionID INT = 0,
	@ZonaID INT = 0,
	@CodigoConsultora VARCHAR(20) = '',
	@Estado VARCHAR(10) = '',
	@PagoDesde DATE = '',
	@PagoHasta DATE = '',
	@ProcesoDesde DATETIME = '',
	@ProcesoHasta DATETIME = '')
AS
BEGIN

	SET @CampaniaID = ISNULL(@CampaniaID, 0)
	SET @RegionID = ISNULL(@RegionID, 0)
	SET @ZonaID = ISNULL(@ZonaID, 0)
	SET @CodigoConsultora = ISNULL(@CodigoConsultora, '')
	SET @Estado = ISNULL(@Estado, '')

	SELECT
		pl.CampaniaId AS CampaniaId
	   ,'SB VISA' AS NombreComercio
	   ,pl.IdUnicoTransaccion AS IdUnicoTransaccion
	   ,pl.PagoEnLineaResultadoLogId AS PagoEnLineaResultadoLogId
	   ,c.PrimerNombre AS PrimerNombre
	   ,c.SegundoNombre AS SegundoNombre
	   ,c.PrimerApellido AS PrimerApellido
	   ,c.SegundoApellido AS SegundoApellido
	   ,pl.FechaCreacion AS FechaCreacion
	   ,pl.CodigoConsultora AS CodigoConsultora
	   ,u.DocumentoIdentidad AS NumeroDocumento
	   ,'Internet' AS Canal
	   ,'' AS Ciclo
	   ,CONVERT(varchar(50), CONVERT(money, pl.ImporteAutorizado), 1) AS ImporteAutorizado
	   ,CONVERT(varchar(50), CONVERT(money, pl.MontoGastosAdministrativos), 1) AS MontoGastosAdministrativos
	   ,0 AS IVA
	   ,CONVERT(varchar(50), CONVERT(money, pl.MontoPago), 1) AS MontoPago
	   ,'' AS TicketId
	   ,r.Codigo AS CodigoRegion
	   ,z.Codigo AS CodigoZona
	   ,pl.OrigenTarjeta AS OrigenTarjeta
	   ,pl.NumeroTarjeta AS NumeroTarjeta
	   ,pl.NumeroOrdenTienda AS NumeroOrdenTienda
	   ,pl.CodigoError AS CodigoError
	   ,pl.MensajeError AS MensajeError
	   ,pl.FechaTransaccion AS FechaTransaccion
	   ,pl.Origen AS  Origen
	FROM PagoEnLineaResultadoLog pl
	INNER JOIN ods.Consultora c ON pl.ConsultoraID = c.ConsultoraID
	INNER JOIN ods.Region r ON c.RegionID = r.RegionID
	INNER JOIN ods.Zona z ON c.ZonaID = z.ZonaID
	LEFT JOIN usuario u ON u.CodigoUsuario = c.Codigo
	WHERE case when @CampaniaID = 0 then 1 when @CampaniaID = pl.CampaniaId then 1 else 0 end = 1
		AND CASE WHEN @RegionID = 0 THEN 1 WHEN @RegionID = r.RegionID THEN 1 ELSE 0 END = 1
		AND CASE WHEN @ZonaID = 0 THEN 1 WHEN @ZonaID = z.ZonaID THEN 1 ELSE 0 END = 1
		AND CASE WHEN @CodigoConsultora = '' THEN 1 WHEN @CodigoConsultora = c.Codigo THEN 1 ELSE 0 END = 1
		AND (@Estado = '' OR (@Estado = '0' AND pl.CodigoError = @Estado) OR (@Estado = '-1' AND pl.CodigoError != '0'))
		AND (convert(DATE,pl.FechaTransaccion) >= @PagoDesde AND convert(DATE,pl.FechaTransaccion) <= @PagoHasta)
		AND (pl.FechaCreacion >= @ProcesoDesde AND pl.FechaCreacion < @ProcesoHasta)	
	ORDER BY FechaCreacion DESC
END
GO

USE BelcorpMexico
GO

/* PROCEDURE ObtenerPagoEnLineaByFiltro */
IF (OBJECT_ID ( 'dbo.ObtenerPagoEnLineaByFiltro', 'P' ) IS NULL)
    EXEC('CREATE PROCEDURE dbo.ObtenerPagoEnLineaByFiltro AS SET NOCOUNT ON;')
GO

ALTER PROCEDURE [dbo].[ObtenerPagoEnLineaByFiltro] (
	@CampaniaID INT = 0,
	@RegionID INT = 0,
	@ZonaID INT = 0,
	@CodigoConsultora VARCHAR(20) = '',
	@Estado VARCHAR(10) = '',
	@PagoDesde DATE = '',
	@PagoHasta DATE = '',
	@ProcesoDesde DATETIME = '',
	@ProcesoHasta DATETIME = '')
AS
BEGIN

	SET @CampaniaID = ISNULL(@CampaniaID, 0)
	SET @RegionID = ISNULL(@RegionID, 0)
	SET @ZonaID = ISNULL(@ZonaID, 0)
	SET @CodigoConsultora = ISNULL(@CodigoConsultora, '')
	SET @Estado = ISNULL(@Estado, '')

	SELECT
		pl.CampaniaId AS CampaniaId
	   ,'SB VISA' AS NombreComercio
	   ,pl.IdUnicoTransaccion AS IdUnicoTransaccion
	   ,pl.PagoEnLineaResultadoLogId AS PagoEnLineaResultadoLogId
	   ,c.PrimerNombre AS PrimerNombre
	   ,c.SegundoNombre AS SegundoNombre
	   ,c.PrimerApellido AS PrimerApellido
	   ,c.SegundoApellido AS SegundoApellido
	   ,pl.FechaCreacion AS FechaCreacion
	   ,pl.CodigoConsultora AS CodigoConsultora
	   ,u.DocumentoIdentidad AS NumeroDocumento
	   ,'Internet' AS Canal
	   ,'' AS Ciclo
	   ,CONVERT(varchar(50), CONVERT(money, pl.ImporteAutorizado), 1) AS ImporteAutorizado
	   ,CONVERT(varchar(50), CONVERT(money, pl.MontoGastosAdministrativos), 1) AS MontoGastosAdministrativos
	   ,0 AS IVA
	   ,CONVERT(varchar(50), CONVERT(money, pl.MontoPago), 1) AS MontoPago
	   ,'' AS TicketId
	   ,r.Codigo AS CodigoRegion
	   ,z.Codigo AS CodigoZona
	   ,pl.OrigenTarjeta AS OrigenTarjeta
	   ,pl.NumeroTarjeta AS NumeroTarjeta
	   ,pl.NumeroOrdenTienda AS NumeroOrdenTienda
	   ,pl.CodigoError AS CodigoError
	   ,pl.MensajeError AS MensajeError
	   ,pl.FechaTransaccion AS FechaTransaccion
	   ,pl.Origen AS  Origen
	FROM PagoEnLineaResultadoLog pl
	INNER JOIN ods.Consultora c ON pl.ConsultoraID = c.ConsultoraID
	INNER JOIN ods.Region r ON c.RegionID = r.RegionID
	INNER JOIN ods.Zona z ON c.ZonaID = z.ZonaID
	LEFT JOIN usuario u ON u.CodigoUsuario = c.Codigo
	WHERE case when @CampaniaID = 0 then 1 when @CampaniaID = pl.CampaniaId then 1 else 0 end = 1
		AND CASE WHEN @RegionID = 0 THEN 1 WHEN @RegionID = r.RegionID THEN 1 ELSE 0 END = 1
		AND CASE WHEN @ZonaID = 0 THEN 1 WHEN @ZonaID = z.ZonaID THEN 1 ELSE 0 END = 1
		AND CASE WHEN @CodigoConsultora = '' THEN 1 WHEN @CodigoConsultora = c.Codigo THEN 1 ELSE 0 END = 1
		AND (@Estado = '' OR (@Estado = '0' AND pl.CodigoError = @Estado) OR (@Estado = '-1' AND pl.CodigoError != '0'))
		AND (convert(DATE,pl.FechaTransaccion) >= @PagoDesde AND convert(DATE,pl.FechaTransaccion) <= @PagoHasta)
		AND (pl.FechaCreacion >= @ProcesoDesde AND pl.FechaCreacion < @ProcesoHasta)	
	ORDER BY FechaCreacion DESC
END
GO

USE BelcorpColombia
GO

/* PROCEDURE ObtenerPagoEnLineaByFiltro */
IF (OBJECT_ID ( 'dbo.ObtenerPagoEnLineaByFiltro', 'P' ) IS NULL)
    EXEC('CREATE PROCEDURE dbo.ObtenerPagoEnLineaByFiltro AS SET NOCOUNT ON;')
GO

ALTER PROCEDURE [dbo].[ObtenerPagoEnLineaByFiltro] (
	@CampaniaID INT = 0,
	@RegionID INT = 0,
	@ZonaID INT = 0,
	@CodigoConsultora VARCHAR(20) = '',
	@Estado VARCHAR(10) = '',
	@PagoDesde DATE = '',
	@PagoHasta DATE = '',
	@ProcesoDesde DATETIME = '',
	@ProcesoHasta DATETIME = '')
AS
BEGIN

	SET @CampaniaID = ISNULL(@CampaniaID, 0)
	SET @RegionID = ISNULL(@RegionID, 0)
	SET @ZonaID = ISNULL(@ZonaID, 0)
	SET @CodigoConsultora = ISNULL(@CodigoConsultora, '')
	SET @Estado = ISNULL(@Estado, '')

	SELECT
		pl.CampaniaId AS CampaniaId
	   ,'SB VISA' AS NombreComercio
	   ,pl.IdUnicoTransaccion AS IdUnicoTransaccion
	   ,pl.PagoEnLineaResultadoLogId AS PagoEnLineaResultadoLogId
	   ,c.PrimerNombre AS PrimerNombre
	   ,c.SegundoNombre AS SegundoNombre
	   ,c.PrimerApellido AS PrimerApellido
	   ,c.SegundoApellido AS SegundoApellido
	   ,pl.FechaCreacion AS FechaCreacion
	   ,pl.CodigoConsultora AS CodigoConsultora
	   ,u.DocumentoIdentidad AS NumeroDocumento
	   ,'Internet' AS Canal
	   ,'' AS Ciclo
	   ,CONVERT(varchar(50), CONVERT(money, pl.ImporteAutorizado), 1) AS ImporteAutorizado
	   ,CONVERT(varchar(50), CONVERT(money, pl.MontoGastosAdministrativos), 1) AS MontoGastosAdministrativos
	   ,0 AS IVA
	   ,CONVERT(varchar(50), CONVERT(money, pl.MontoPago), 1) AS MontoPago
	   ,'' AS TicketId
	   ,r.Codigo AS CodigoRegion
	   ,z.Codigo AS CodigoZona
	   ,pl.OrigenTarjeta AS OrigenTarjeta
	   ,pl.NumeroTarjeta AS NumeroTarjeta
	   ,pl.NumeroOrdenTienda AS NumeroOrdenTienda
	   ,pl.CodigoError AS CodigoError
	   ,pl.MensajeError AS MensajeError
	   ,pl.FechaTransaccion AS FechaTransaccion
	   ,pl.Origen AS  Origen
	FROM PagoEnLineaResultadoLog pl
	INNER JOIN ods.Consultora c ON pl.ConsultoraID = c.ConsultoraID
	INNER JOIN ods.Region r ON c.RegionID = r.RegionID
	INNER JOIN ods.Zona z ON c.ZonaID = z.ZonaID
	LEFT JOIN usuario u ON u.CodigoUsuario = c.Codigo
	WHERE case when @CampaniaID = 0 then 1 when @CampaniaID = pl.CampaniaId then 1 else 0 end = 1
		AND CASE WHEN @RegionID = 0 THEN 1 WHEN @RegionID = r.RegionID THEN 1 ELSE 0 END = 1
		AND CASE WHEN @ZonaID = 0 THEN 1 WHEN @ZonaID = z.ZonaID THEN 1 ELSE 0 END = 1
		AND CASE WHEN @CodigoConsultora = '' THEN 1 WHEN @CodigoConsultora = c.Codigo THEN 1 ELSE 0 END = 1
		AND (@Estado = '' OR (@Estado = '0' AND pl.CodigoError = @Estado) OR (@Estado = '-1' AND pl.CodigoError != '0'))
		AND (convert(DATE,pl.FechaTransaccion) >= @PagoDesde AND convert(DATE,pl.FechaTransaccion) <= @PagoHasta)
		AND (pl.FechaCreacion >= @ProcesoDesde AND pl.FechaCreacion < @ProcesoHasta)	
	ORDER BY FechaCreacion DESC
END
GO

USE BelcorpSalvador
GO

/* PROCEDURE ObtenerPagoEnLineaByFiltro */
IF (OBJECT_ID ( 'dbo.ObtenerPagoEnLineaByFiltro', 'P' ) IS NULL)
    EXEC('CREATE PROCEDURE dbo.ObtenerPagoEnLineaByFiltro AS SET NOCOUNT ON;')
GO

ALTER PROCEDURE [dbo].[ObtenerPagoEnLineaByFiltro] (
	@CampaniaID INT = 0,
	@RegionID INT = 0,
	@ZonaID INT = 0,
	@CodigoConsultora VARCHAR(20) = '',
	@Estado VARCHAR(10) = '',
	@PagoDesde DATE = '',
	@PagoHasta DATE = '',
	@ProcesoDesde DATETIME = '',
	@ProcesoHasta DATETIME = '')
AS
BEGIN

	SET @CampaniaID = ISNULL(@CampaniaID, 0)
	SET @RegionID = ISNULL(@RegionID, 0)
	SET @ZonaID = ISNULL(@ZonaID, 0)
	SET @CodigoConsultora = ISNULL(@CodigoConsultora, '')
	SET @Estado = ISNULL(@Estado, '')

	SELECT
		pl.CampaniaId AS CampaniaId
	   ,'SB VISA' AS NombreComercio
	   ,pl.IdUnicoTransaccion AS IdUnicoTransaccion
	   ,pl.PagoEnLineaResultadoLogId AS PagoEnLineaResultadoLogId
	   ,c.PrimerNombre AS PrimerNombre
	   ,c.SegundoNombre AS SegundoNombre
	   ,c.PrimerApellido AS PrimerApellido
	   ,c.SegundoApellido AS SegundoApellido
	   ,pl.FechaCreacion AS FechaCreacion
	   ,pl.CodigoConsultora AS CodigoConsultora
	   ,u.DocumentoIdentidad AS NumeroDocumento
	   ,'Internet' AS Canal
	   ,'' AS Ciclo
	   ,CONVERT(varchar(50), CONVERT(money, pl.ImporteAutorizado), 1) AS ImporteAutorizado
	   ,CONVERT(varchar(50), CONVERT(money, pl.MontoGastosAdministrativos), 1) AS MontoGastosAdministrativos
	   ,0 AS IVA
	   ,CONVERT(varchar(50), CONVERT(money, pl.MontoPago), 1) AS MontoPago
	   ,'' AS TicketId
	   ,r.Codigo AS CodigoRegion
	   ,z.Codigo AS CodigoZona
	   ,pl.OrigenTarjeta AS OrigenTarjeta
	   ,pl.NumeroTarjeta AS NumeroTarjeta
	   ,pl.NumeroOrdenTienda AS NumeroOrdenTienda
	   ,pl.CodigoError AS CodigoError
	   ,pl.MensajeError AS MensajeError
	   ,pl.FechaTransaccion AS FechaTransaccion
	   ,pl.Origen AS  Origen
	FROM PagoEnLineaResultadoLog pl
	INNER JOIN ods.Consultora c ON pl.ConsultoraID = c.ConsultoraID
	INNER JOIN ods.Region r ON c.RegionID = r.RegionID
	INNER JOIN ods.Zona z ON c.ZonaID = z.ZonaID
	LEFT JOIN usuario u ON u.CodigoUsuario = c.Codigo
	WHERE case when @CampaniaID = 0 then 1 when @CampaniaID = pl.CampaniaId then 1 else 0 end = 1
		AND CASE WHEN @RegionID = 0 THEN 1 WHEN @RegionID = r.RegionID THEN 1 ELSE 0 END = 1
		AND CASE WHEN @ZonaID = 0 THEN 1 WHEN @ZonaID = z.ZonaID THEN 1 ELSE 0 END = 1
		AND CASE WHEN @CodigoConsultora = '' THEN 1 WHEN @CodigoConsultora = c.Codigo THEN 1 ELSE 0 END = 1
		AND (@Estado = '' OR (@Estado = '0' AND pl.CodigoError = @Estado) OR (@Estado = '-1' AND pl.CodigoError != '0'))
		AND (convert(DATE,pl.FechaTransaccion) >= @PagoDesde AND convert(DATE,pl.FechaTransaccion) <= @PagoHasta)
		AND (pl.FechaCreacion >= @ProcesoDesde AND pl.FechaCreacion < @ProcesoHasta)	
	ORDER BY FechaCreacion DESC
END
GO

USE BelcorpPuertoRico
GO

/* PROCEDURE ObtenerPagoEnLineaByFiltro */
IF (OBJECT_ID ( 'dbo.ObtenerPagoEnLineaByFiltro', 'P' ) IS NULL)
    EXEC('CREATE PROCEDURE dbo.ObtenerPagoEnLineaByFiltro AS SET NOCOUNT ON;')
GO

ALTER PROCEDURE [dbo].[ObtenerPagoEnLineaByFiltro] (
	@CampaniaID INT = 0,
	@RegionID INT = 0,
	@ZonaID INT = 0,
	@CodigoConsultora VARCHAR(20) = '',
	@Estado VARCHAR(10) = '',
	@PagoDesde DATE = '',
	@PagoHasta DATE = '',
	@ProcesoDesde DATETIME = '',
	@ProcesoHasta DATETIME = '')
AS
BEGIN

	SET @CampaniaID = ISNULL(@CampaniaID, 0)
	SET @RegionID = ISNULL(@RegionID, 0)
	SET @ZonaID = ISNULL(@ZonaID, 0)
	SET @CodigoConsultora = ISNULL(@CodigoConsultora, '')
	SET @Estado = ISNULL(@Estado, '')

	SELECT
		pl.CampaniaId AS CampaniaId
	   ,'SB VISA' AS NombreComercio
	   ,pl.IdUnicoTransaccion AS IdUnicoTransaccion
	   ,pl.PagoEnLineaResultadoLogId AS PagoEnLineaResultadoLogId
	   ,c.PrimerNombre AS PrimerNombre
	   ,c.SegundoNombre AS SegundoNombre
	   ,c.PrimerApellido AS PrimerApellido
	   ,c.SegundoApellido AS SegundoApellido
	   ,pl.FechaCreacion AS FechaCreacion
	   ,pl.CodigoConsultora AS CodigoConsultora
	   ,u.DocumentoIdentidad AS NumeroDocumento
	   ,'Internet' AS Canal
	   ,'' AS Ciclo
	   ,CONVERT(varchar(50), CONVERT(money, pl.ImporteAutorizado), 1) AS ImporteAutorizado
	   ,CONVERT(varchar(50), CONVERT(money, pl.MontoGastosAdministrativos), 1) AS MontoGastosAdministrativos
	   ,0 AS IVA
	   ,CONVERT(varchar(50), CONVERT(money, pl.MontoPago), 1) AS MontoPago
	   ,'' AS TicketId
	   ,r.Codigo AS CodigoRegion
	   ,z.Codigo AS CodigoZona
	   ,pl.OrigenTarjeta AS OrigenTarjeta
	   ,pl.NumeroTarjeta AS NumeroTarjeta
	   ,pl.NumeroOrdenTienda AS NumeroOrdenTienda
	   ,pl.CodigoError AS CodigoError
	   ,pl.MensajeError AS MensajeError
	   ,pl.FechaTransaccion AS FechaTransaccion
	   ,pl.Origen AS  Origen
	FROM PagoEnLineaResultadoLog pl
	INNER JOIN ods.Consultora c ON pl.ConsultoraID = c.ConsultoraID
	INNER JOIN ods.Region r ON c.RegionID = r.RegionID
	INNER JOIN ods.Zona z ON c.ZonaID = z.ZonaID
	LEFT JOIN usuario u ON u.CodigoUsuario = c.Codigo
	WHERE case when @CampaniaID = 0 then 1 when @CampaniaID = pl.CampaniaId then 1 else 0 end = 1
		AND CASE WHEN @RegionID = 0 THEN 1 WHEN @RegionID = r.RegionID THEN 1 ELSE 0 END = 1
		AND CASE WHEN @ZonaID = 0 THEN 1 WHEN @ZonaID = z.ZonaID THEN 1 ELSE 0 END = 1
		AND CASE WHEN @CodigoConsultora = '' THEN 1 WHEN @CodigoConsultora = c.Codigo THEN 1 ELSE 0 END = 1
		AND (@Estado = '' OR (@Estado = '0' AND pl.CodigoError = @Estado) OR (@Estado = '-1' AND pl.CodigoError != '0'))
		AND (convert(DATE,pl.FechaTransaccion) >= @PagoDesde AND convert(DATE,pl.FechaTransaccion) <= @PagoHasta)
		AND (pl.FechaCreacion >= @ProcesoDesde AND pl.FechaCreacion < @ProcesoHasta)	
	ORDER BY FechaCreacion DESC
END
GO

USE BelcorpPanama
GO

/* PROCEDURE ObtenerPagoEnLineaByFiltro */
IF (OBJECT_ID ( 'dbo.ObtenerPagoEnLineaByFiltro', 'P' ) IS NULL)
    EXEC('CREATE PROCEDURE dbo.ObtenerPagoEnLineaByFiltro AS SET NOCOUNT ON;')
GO

ALTER PROCEDURE [dbo].[ObtenerPagoEnLineaByFiltro] (
	@CampaniaID INT = 0,
	@RegionID INT = 0,
	@ZonaID INT = 0,
	@CodigoConsultora VARCHAR(20) = '',
	@Estado VARCHAR(10) = '',
	@PagoDesde DATE = '',
	@PagoHasta DATE = '',
	@ProcesoDesde DATETIME = '',
	@ProcesoHasta DATETIME = '')
AS
BEGIN

	SET @CampaniaID = ISNULL(@CampaniaID, 0)
	SET @RegionID = ISNULL(@RegionID, 0)
	SET @ZonaID = ISNULL(@ZonaID, 0)
	SET @CodigoConsultora = ISNULL(@CodigoConsultora, '')
	SET @Estado = ISNULL(@Estado, '')

	SELECT
		pl.CampaniaId AS CampaniaId
	   ,'SB VISA' AS NombreComercio
	   ,pl.IdUnicoTransaccion AS IdUnicoTransaccion
	   ,pl.PagoEnLineaResultadoLogId AS PagoEnLineaResultadoLogId
	   ,c.PrimerNombre AS PrimerNombre
	   ,c.SegundoNombre AS SegundoNombre
	   ,c.PrimerApellido AS PrimerApellido
	   ,c.SegundoApellido AS SegundoApellido
	   ,pl.FechaCreacion AS FechaCreacion
	   ,pl.CodigoConsultora AS CodigoConsultora
	   ,u.DocumentoIdentidad AS NumeroDocumento
	   ,'Internet' AS Canal
	   ,'' AS Ciclo
	   ,CONVERT(varchar(50), CONVERT(money, pl.ImporteAutorizado), 1) AS ImporteAutorizado
	   ,CONVERT(varchar(50), CONVERT(money, pl.MontoGastosAdministrativos), 1) AS MontoGastosAdministrativos
	   ,0 AS IVA
	   ,CONVERT(varchar(50), CONVERT(money, pl.MontoPago), 1) AS MontoPago
	   ,'' AS TicketId
	   ,r.Codigo AS CodigoRegion
	   ,z.Codigo AS CodigoZona
	   ,pl.OrigenTarjeta AS OrigenTarjeta
	   ,pl.NumeroTarjeta AS NumeroTarjeta
	   ,pl.NumeroOrdenTienda AS NumeroOrdenTienda
	   ,pl.CodigoError AS CodigoError
	   ,pl.MensajeError AS MensajeError
	   ,pl.FechaTransaccion AS FechaTransaccion
	   ,pl.Origen AS  Origen
	FROM PagoEnLineaResultadoLog pl
	INNER JOIN ods.Consultora c ON pl.ConsultoraID = c.ConsultoraID
	INNER JOIN ods.Region r ON c.RegionID = r.RegionID
	INNER JOIN ods.Zona z ON c.ZonaID = z.ZonaID
	LEFT JOIN usuario u ON u.CodigoUsuario = c.Codigo
	WHERE case when @CampaniaID = 0 then 1 when @CampaniaID = pl.CampaniaId then 1 else 0 end = 1
		AND CASE WHEN @RegionID = 0 THEN 1 WHEN @RegionID = r.RegionID THEN 1 ELSE 0 END = 1
		AND CASE WHEN @ZonaID = 0 THEN 1 WHEN @ZonaID = z.ZonaID THEN 1 ELSE 0 END = 1
		AND CASE WHEN @CodigoConsultora = '' THEN 1 WHEN @CodigoConsultora = c.Codigo THEN 1 ELSE 0 END = 1
		AND (@Estado = '' OR (@Estado = '0' AND pl.CodigoError = @Estado) OR (@Estado = '-1' AND pl.CodigoError != '0'))
		AND (convert(DATE,pl.FechaTransaccion) >= @PagoDesde AND convert(DATE,pl.FechaTransaccion) <= @PagoHasta)
		AND (pl.FechaCreacion >= @ProcesoDesde AND pl.FechaCreacion < @ProcesoHasta)	
	ORDER BY FechaCreacion DESC
END
GO

USE BelcorpGuatemala
GO

/* PROCEDURE ObtenerPagoEnLineaByFiltro */
IF (OBJECT_ID ( 'dbo.ObtenerPagoEnLineaByFiltro', 'P' ) IS NULL)
    EXEC('CREATE PROCEDURE dbo.ObtenerPagoEnLineaByFiltro AS SET NOCOUNT ON;')
GO

ALTER PROCEDURE [dbo].[ObtenerPagoEnLineaByFiltro] (
	@CampaniaID INT = 0,
	@RegionID INT = 0,
	@ZonaID INT = 0,
	@CodigoConsultora VARCHAR(20) = '',
	@Estado VARCHAR(10) = '',
	@PagoDesde DATE = '',
	@PagoHasta DATE = '',
	@ProcesoDesde DATETIME = '',
	@ProcesoHasta DATETIME = '')
AS
BEGIN

	SET @CampaniaID = ISNULL(@CampaniaID, 0)
	SET @RegionID = ISNULL(@RegionID, 0)
	SET @ZonaID = ISNULL(@ZonaID, 0)
	SET @CodigoConsultora = ISNULL(@CodigoConsultora, '')
	SET @Estado = ISNULL(@Estado, '')

	SELECT
		pl.CampaniaId AS CampaniaId
	   ,'SB VISA' AS NombreComercio
	   ,pl.IdUnicoTransaccion AS IdUnicoTransaccion
	   ,pl.PagoEnLineaResultadoLogId AS PagoEnLineaResultadoLogId
	   ,c.PrimerNombre AS PrimerNombre
	   ,c.SegundoNombre AS SegundoNombre
	   ,c.PrimerApellido AS PrimerApellido
	   ,c.SegundoApellido AS SegundoApellido
	   ,pl.FechaCreacion AS FechaCreacion
	   ,pl.CodigoConsultora AS CodigoConsultora
	   ,u.DocumentoIdentidad AS NumeroDocumento
	   ,'Internet' AS Canal
	   ,'' AS Ciclo
	   ,CONVERT(varchar(50), CONVERT(money, pl.ImporteAutorizado), 1) AS ImporteAutorizado
	   ,CONVERT(varchar(50), CONVERT(money, pl.MontoGastosAdministrativos), 1) AS MontoGastosAdministrativos
	   ,0 AS IVA
	   ,CONVERT(varchar(50), CONVERT(money, pl.MontoPago), 1) AS MontoPago
	   ,'' AS TicketId
	   ,r.Codigo AS CodigoRegion
	   ,z.Codigo AS CodigoZona
	   ,pl.OrigenTarjeta AS OrigenTarjeta
	   ,pl.NumeroTarjeta AS NumeroTarjeta
	   ,pl.NumeroOrdenTienda AS NumeroOrdenTienda
	   ,pl.CodigoError AS CodigoError
	   ,pl.MensajeError AS MensajeError
	   ,pl.FechaTransaccion AS FechaTransaccion
	   ,pl.Origen AS  Origen
	FROM PagoEnLineaResultadoLog pl
	INNER JOIN ods.Consultora c ON pl.ConsultoraID = c.ConsultoraID
	INNER JOIN ods.Region r ON c.RegionID = r.RegionID
	INNER JOIN ods.Zona z ON c.ZonaID = z.ZonaID
	LEFT JOIN usuario u ON u.CodigoUsuario = c.Codigo
	WHERE case when @CampaniaID = 0 then 1 when @CampaniaID = pl.CampaniaId then 1 else 0 end = 1
		AND CASE WHEN @RegionID = 0 THEN 1 WHEN @RegionID = r.RegionID THEN 1 ELSE 0 END = 1
		AND CASE WHEN @ZonaID = 0 THEN 1 WHEN @ZonaID = z.ZonaID THEN 1 ELSE 0 END = 1
		AND CASE WHEN @CodigoConsultora = '' THEN 1 WHEN @CodigoConsultora = c.Codigo THEN 1 ELSE 0 END = 1
		AND (@Estado = '' OR (@Estado = '0' AND pl.CodigoError = @Estado) OR (@Estado = '-1' AND pl.CodigoError != '0'))
		AND (convert(DATE,pl.FechaTransaccion) >= @PagoDesde AND convert(DATE,pl.FechaTransaccion) <= @PagoHasta)
		AND (pl.FechaCreacion >= @ProcesoDesde AND pl.FechaCreacion < @ProcesoHasta)	
	ORDER BY FechaCreacion DESC
END
GO

USE BelcorpEcuador
GO

/* PROCEDURE ObtenerPagoEnLineaByFiltro */
IF (OBJECT_ID ( 'dbo.ObtenerPagoEnLineaByFiltro', 'P' ) IS NULL)
    EXEC('CREATE PROCEDURE dbo.ObtenerPagoEnLineaByFiltro AS SET NOCOUNT ON;')
GO

ALTER PROCEDURE [dbo].[ObtenerPagoEnLineaByFiltro] (
	@CampaniaID INT = 0,
	@RegionID INT = 0,
	@ZonaID INT = 0,
	@CodigoConsultora VARCHAR(20) = '',
	@Estado VARCHAR(10) = '',
	@PagoDesde DATE = '',
	@PagoHasta DATE = '',
	@ProcesoDesde DATETIME = '',
	@ProcesoHasta DATETIME = '')
AS
BEGIN

	SET @CampaniaID = ISNULL(@CampaniaID, 0)
	SET @RegionID = ISNULL(@RegionID, 0)
	SET @ZonaID = ISNULL(@ZonaID, 0)
	SET @CodigoConsultora = ISNULL(@CodigoConsultora, '')
	SET @Estado = ISNULL(@Estado, '')

	SELECT
		pl.CampaniaId AS CampaniaId
	   ,'SB VISA' AS NombreComercio
	   ,pl.IdUnicoTransaccion AS IdUnicoTransaccion
	   ,pl.PagoEnLineaResultadoLogId AS PagoEnLineaResultadoLogId
	   ,c.PrimerNombre AS PrimerNombre
	   ,c.SegundoNombre AS SegundoNombre
	   ,c.PrimerApellido AS PrimerApellido
	   ,c.SegundoApellido AS SegundoApellido
	   ,pl.FechaCreacion AS FechaCreacion
	   ,pl.CodigoConsultora AS CodigoConsultora
	   ,u.DocumentoIdentidad AS NumeroDocumento
	   ,'Internet' AS Canal
	   ,'' AS Ciclo
	   ,CONVERT(varchar(50), CONVERT(money, pl.ImporteAutorizado), 1) AS ImporteAutorizado
	   ,CONVERT(varchar(50), CONVERT(money, pl.MontoGastosAdministrativos), 1) AS MontoGastosAdministrativos
	   ,0 AS IVA
	   ,CONVERT(varchar(50), CONVERT(money, pl.MontoPago), 1) AS MontoPago
	   ,'' AS TicketId
	   ,r.Codigo AS CodigoRegion
	   ,z.Codigo AS CodigoZona
	   ,pl.OrigenTarjeta AS OrigenTarjeta
	   ,pl.NumeroTarjeta AS NumeroTarjeta
	   ,pl.NumeroOrdenTienda AS NumeroOrdenTienda
	   ,pl.CodigoError AS CodigoError
	   ,pl.MensajeError AS MensajeError
	   ,pl.FechaTransaccion AS FechaTransaccion
	   ,pl.Origen AS  Origen
	FROM PagoEnLineaResultadoLog pl
	INNER JOIN ods.Consultora c ON pl.ConsultoraID = c.ConsultoraID
	INNER JOIN ods.Region r ON c.RegionID = r.RegionID
	INNER JOIN ods.Zona z ON c.ZonaID = z.ZonaID
	LEFT JOIN usuario u ON u.CodigoUsuario = c.Codigo
	WHERE case when @CampaniaID = 0 then 1 when @CampaniaID = pl.CampaniaId then 1 else 0 end = 1
		AND CASE WHEN @RegionID = 0 THEN 1 WHEN @RegionID = r.RegionID THEN 1 ELSE 0 END = 1
		AND CASE WHEN @ZonaID = 0 THEN 1 WHEN @ZonaID = z.ZonaID THEN 1 ELSE 0 END = 1
		AND CASE WHEN @CodigoConsultora = '' THEN 1 WHEN @CodigoConsultora = c.Codigo THEN 1 ELSE 0 END = 1
		AND (@Estado = '' OR (@Estado = '0' AND pl.CodigoError = @Estado) OR (@Estado = '-1' AND pl.CodigoError != '0'))
		AND (convert(DATE,pl.FechaTransaccion) >= @PagoDesde AND convert(DATE,pl.FechaTransaccion) <= @PagoHasta)
		AND (pl.FechaCreacion >= @ProcesoDesde AND pl.FechaCreacion < @ProcesoHasta)	
	ORDER BY FechaCreacion DESC
END
GO

USE BelcorpDominicana
GO

/* PROCEDURE ObtenerPagoEnLineaByFiltro */
IF (OBJECT_ID ( 'dbo.ObtenerPagoEnLineaByFiltro', 'P' ) IS NULL)
    EXEC('CREATE PROCEDURE dbo.ObtenerPagoEnLineaByFiltro AS SET NOCOUNT ON;')
GO

ALTER PROCEDURE [dbo].[ObtenerPagoEnLineaByFiltro] (
	@CampaniaID INT = 0,
	@RegionID INT = 0,
	@ZonaID INT = 0,
	@CodigoConsultora VARCHAR(20) = '',
	@Estado VARCHAR(10) = '',
	@PagoDesde DATE = '',
	@PagoHasta DATE = '',
	@ProcesoDesde DATETIME = '',
	@ProcesoHasta DATETIME = '')
AS
BEGIN

	SET @CampaniaID = ISNULL(@CampaniaID, 0)
	SET @RegionID = ISNULL(@RegionID, 0)
	SET @ZonaID = ISNULL(@ZonaID, 0)
	SET @CodigoConsultora = ISNULL(@CodigoConsultora, '')
	SET @Estado = ISNULL(@Estado, '')

	SELECT
		pl.CampaniaId AS CampaniaId
	   ,'SB VISA' AS NombreComercio
	   ,pl.IdUnicoTransaccion AS IdUnicoTransaccion
	   ,pl.PagoEnLineaResultadoLogId AS PagoEnLineaResultadoLogId
	   ,c.PrimerNombre AS PrimerNombre
	   ,c.SegundoNombre AS SegundoNombre
	   ,c.PrimerApellido AS PrimerApellido
	   ,c.SegundoApellido AS SegundoApellido
	   ,pl.FechaCreacion AS FechaCreacion
	   ,pl.CodigoConsultora AS CodigoConsultora
	   ,u.DocumentoIdentidad AS NumeroDocumento
	   ,'Internet' AS Canal
	   ,'' AS Ciclo
	   ,CONVERT(varchar(50), CONVERT(money, pl.ImporteAutorizado), 1) AS ImporteAutorizado
	   ,CONVERT(varchar(50), CONVERT(money, pl.MontoGastosAdministrativos), 1) AS MontoGastosAdministrativos
	   ,0 AS IVA
	   ,CONVERT(varchar(50), CONVERT(money, pl.MontoPago), 1) AS MontoPago
	   ,'' AS TicketId
	   ,r.Codigo AS CodigoRegion
	   ,z.Codigo AS CodigoZona
	   ,pl.OrigenTarjeta AS OrigenTarjeta
	   ,pl.NumeroTarjeta AS NumeroTarjeta
	   ,pl.NumeroOrdenTienda AS NumeroOrdenTienda
	   ,pl.CodigoError AS CodigoError
	   ,pl.MensajeError AS MensajeError
	   ,pl.FechaTransaccion AS FechaTransaccion
	   ,pl.Origen AS  Origen
	FROM PagoEnLineaResultadoLog pl
	INNER JOIN ods.Consultora c ON pl.ConsultoraID = c.ConsultoraID
	INNER JOIN ods.Region r ON c.RegionID = r.RegionID
	INNER JOIN ods.Zona z ON c.ZonaID = z.ZonaID
	LEFT JOIN usuario u ON u.CodigoUsuario = c.Codigo
	WHERE case when @CampaniaID = 0 then 1 when @CampaniaID = pl.CampaniaId then 1 else 0 end = 1
		AND CASE WHEN @RegionID = 0 THEN 1 WHEN @RegionID = r.RegionID THEN 1 ELSE 0 END = 1
		AND CASE WHEN @ZonaID = 0 THEN 1 WHEN @ZonaID = z.ZonaID THEN 1 ELSE 0 END = 1
		AND CASE WHEN @CodigoConsultora = '' THEN 1 WHEN @CodigoConsultora = c.Codigo THEN 1 ELSE 0 END = 1
		AND (@Estado = '' OR (@Estado = '0' AND pl.CodigoError = @Estado) OR (@Estado = '-1' AND pl.CodigoError != '0'))
		AND (convert(DATE,pl.FechaTransaccion) >= @PagoDesde AND convert(DATE,pl.FechaTransaccion) <= @PagoHasta)
		AND (pl.FechaCreacion >= @ProcesoDesde AND pl.FechaCreacion < @ProcesoHasta)	
	ORDER BY FechaCreacion DESC
END
GO

USE BelcorpCostaRica
GO

/* PROCEDURE ObtenerPagoEnLineaByFiltro */
IF (OBJECT_ID ( 'dbo.ObtenerPagoEnLineaByFiltro', 'P' ) IS NULL)
    EXEC('CREATE PROCEDURE dbo.ObtenerPagoEnLineaByFiltro AS SET NOCOUNT ON;')
GO

ALTER PROCEDURE [dbo].[ObtenerPagoEnLineaByFiltro] (
	@CampaniaID INT = 0,
	@RegionID INT = 0,
	@ZonaID INT = 0,
	@CodigoConsultora VARCHAR(20) = '',
	@Estado VARCHAR(10) = '',
	@PagoDesde DATE = '',
	@PagoHasta DATE = '',
	@ProcesoDesde DATETIME = '',
	@ProcesoHasta DATETIME = '')
AS
BEGIN

	SET @CampaniaID = ISNULL(@CampaniaID, 0)
	SET @RegionID = ISNULL(@RegionID, 0)
	SET @ZonaID = ISNULL(@ZonaID, 0)
	SET @CodigoConsultora = ISNULL(@CodigoConsultora, '')
	SET @Estado = ISNULL(@Estado, '')

	SELECT
		pl.CampaniaId AS CampaniaId
	   ,'SB VISA' AS NombreComercio
	   ,pl.IdUnicoTransaccion AS IdUnicoTransaccion
	   ,pl.PagoEnLineaResultadoLogId AS PagoEnLineaResultadoLogId
	   ,c.PrimerNombre AS PrimerNombre
	   ,c.SegundoNombre AS SegundoNombre
	   ,c.PrimerApellido AS PrimerApellido
	   ,c.SegundoApellido AS SegundoApellido
	   ,pl.FechaCreacion AS FechaCreacion
	   ,pl.CodigoConsultora AS CodigoConsultora
	   ,u.DocumentoIdentidad AS NumeroDocumento
	   ,'Internet' AS Canal
	   ,'' AS Ciclo
	   ,CONVERT(varchar(50), CONVERT(money, pl.ImporteAutorizado), 1) AS ImporteAutorizado
	   ,CONVERT(varchar(50), CONVERT(money, pl.MontoGastosAdministrativos), 1) AS MontoGastosAdministrativos
	   ,0 AS IVA
	   ,CONVERT(varchar(50), CONVERT(money, pl.MontoPago), 1) AS MontoPago
	   ,'' AS TicketId
	   ,r.Codigo AS CodigoRegion
	   ,z.Codigo AS CodigoZona
	   ,pl.OrigenTarjeta AS OrigenTarjeta
	   ,pl.NumeroTarjeta AS NumeroTarjeta
	   ,pl.NumeroOrdenTienda AS NumeroOrdenTienda
	   ,pl.CodigoError AS CodigoError
	   ,pl.MensajeError AS MensajeError
	   ,pl.FechaTransaccion AS FechaTransaccion
	   ,pl.Origen AS  Origen
	FROM PagoEnLineaResultadoLog pl
	INNER JOIN ods.Consultora c ON pl.ConsultoraID = c.ConsultoraID
	INNER JOIN ods.Region r ON c.RegionID = r.RegionID
	INNER JOIN ods.Zona z ON c.ZonaID = z.ZonaID
	LEFT JOIN usuario u ON u.CodigoUsuario = c.Codigo
	WHERE case when @CampaniaID = 0 then 1 when @CampaniaID = pl.CampaniaId then 1 else 0 end = 1
		AND CASE WHEN @RegionID = 0 THEN 1 WHEN @RegionID = r.RegionID THEN 1 ELSE 0 END = 1
		AND CASE WHEN @ZonaID = 0 THEN 1 WHEN @ZonaID = z.ZonaID THEN 1 ELSE 0 END = 1
		AND CASE WHEN @CodigoConsultora = '' THEN 1 WHEN @CodigoConsultora = c.Codigo THEN 1 ELSE 0 END = 1
		AND (@Estado = '' OR (@Estado = '0' AND pl.CodigoError = @Estado) OR (@Estado = '-1' AND pl.CodigoError != '0'))
		AND (convert(DATE,pl.FechaTransaccion) >= @PagoDesde AND convert(DATE,pl.FechaTransaccion) <= @PagoHasta)
		AND (pl.FechaCreacion >= @ProcesoDesde AND pl.FechaCreacion < @ProcesoHasta)	
	ORDER BY FechaCreacion DESC
END
GO

USE BelcorpChile
GO

/* PROCEDURE ObtenerPagoEnLineaByFiltro */
IF (OBJECT_ID ( 'dbo.ObtenerPagoEnLineaByFiltro', 'P' ) IS NULL)
    EXEC('CREATE PROCEDURE dbo.ObtenerPagoEnLineaByFiltro AS SET NOCOUNT ON;')
GO

ALTER PROCEDURE [dbo].[ObtenerPagoEnLineaByFiltro] (
	@CampaniaID INT = 0,
	@RegionID INT = 0,
	@ZonaID INT = 0,
	@CodigoConsultora VARCHAR(20) = '',
	@Estado VARCHAR(10) = '',
	@PagoDesde DATE = '',
	@PagoHasta DATE = '',
	@ProcesoDesde DATETIME = '',
	@ProcesoHasta DATETIME = '')
AS
BEGIN

	SET @CampaniaID = ISNULL(@CampaniaID, 0)
	SET @RegionID = ISNULL(@RegionID, 0)
	SET @ZonaID = ISNULL(@ZonaID, 0)
	SET @CodigoConsultora = ISNULL(@CodigoConsultora, '')
	SET @Estado = ISNULL(@Estado, '')

	SELECT
		pl.CampaniaId AS CampaniaId
	   ,'SB VISA' AS NombreComercio
	   ,pl.IdUnicoTransaccion AS IdUnicoTransaccion
	   ,pl.PagoEnLineaResultadoLogId AS PagoEnLineaResultadoLogId
	   ,c.PrimerNombre AS PrimerNombre
	   ,c.SegundoNombre AS SegundoNombre
	   ,c.PrimerApellido AS PrimerApellido
	   ,c.SegundoApellido AS SegundoApellido
	   ,pl.FechaCreacion AS FechaCreacion
	   ,pl.CodigoConsultora AS CodigoConsultora
	   ,u.DocumentoIdentidad AS NumeroDocumento
	   ,'Internet' AS Canal
	   ,'' AS Ciclo
	   ,CONVERT(varchar(50), CONVERT(money, pl.ImporteAutorizado), 1) AS ImporteAutorizado
	   ,CONVERT(varchar(50), CONVERT(money, pl.MontoGastosAdministrativos), 1) AS MontoGastosAdministrativos
	   ,0 AS IVA
	   ,CONVERT(varchar(50), CONVERT(money, pl.MontoPago), 1) AS MontoPago
	   ,'' AS TicketId
	   ,r.Codigo AS CodigoRegion
	   ,z.Codigo AS CodigoZona
	   ,pl.OrigenTarjeta AS OrigenTarjeta
	   ,pl.NumeroTarjeta AS NumeroTarjeta
	   ,pl.NumeroOrdenTienda AS NumeroOrdenTienda
	   ,pl.CodigoError AS CodigoError
	   ,pl.MensajeError AS MensajeError
	   ,pl.FechaTransaccion AS FechaTransaccion
	   ,pl.Origen AS  Origen
	FROM PagoEnLineaResultadoLog pl
	INNER JOIN ods.Consultora c ON pl.ConsultoraID = c.ConsultoraID
	INNER JOIN ods.Region r ON c.RegionID = r.RegionID
	INNER JOIN ods.Zona z ON c.ZonaID = z.ZonaID
	LEFT JOIN usuario u ON u.CodigoUsuario = c.Codigo
	WHERE case when @CampaniaID = 0 then 1 when @CampaniaID = pl.CampaniaId then 1 else 0 end = 1
		AND CASE WHEN @RegionID = 0 THEN 1 WHEN @RegionID = r.RegionID THEN 1 ELSE 0 END = 1
		AND CASE WHEN @ZonaID = 0 THEN 1 WHEN @ZonaID = z.ZonaID THEN 1 ELSE 0 END = 1
		AND CASE WHEN @CodigoConsultora = '' THEN 1 WHEN @CodigoConsultora = c.Codigo THEN 1 ELSE 0 END = 1
		AND (@Estado = '' OR (@Estado = '0' AND pl.CodigoError = @Estado) OR (@Estado = '-1' AND pl.CodigoError != '0'))
		AND (convert(DATE,pl.FechaTransaccion) >= @PagoDesde AND convert(DATE,pl.FechaTransaccion) <= @PagoHasta)
		AND (pl.FechaCreacion >= @ProcesoDesde AND pl.FechaCreacion < @ProcesoHasta)	
	ORDER BY FechaCreacion DESC
END
GO

USE BelcorpBolivia
GO

/* PROCEDURE ObtenerPagoEnLineaByFiltro */
IF (OBJECT_ID ( 'dbo.ObtenerPagoEnLineaByFiltro', 'P' ) IS NULL)
    EXEC('CREATE PROCEDURE dbo.ObtenerPagoEnLineaByFiltro AS SET NOCOUNT ON;')
GO

ALTER PROCEDURE [dbo].[ObtenerPagoEnLineaByFiltro] (
	@CampaniaID INT = 0,
	@RegionID INT = 0,
	@ZonaID INT = 0,
	@CodigoConsultora VARCHAR(20) = '',
	@Estado VARCHAR(10) = '',
	@PagoDesde DATE = '',
	@PagoHasta DATE = '',
	@ProcesoDesde DATETIME = '',
	@ProcesoHasta DATETIME = '')
AS
BEGIN

	SET @CampaniaID = ISNULL(@CampaniaID, 0)
	SET @RegionID = ISNULL(@RegionID, 0)
	SET @ZonaID = ISNULL(@ZonaID, 0)
	SET @CodigoConsultora = ISNULL(@CodigoConsultora, '')
	SET @Estado = ISNULL(@Estado, '')

	SELECT
		pl.CampaniaId AS CampaniaId
	   ,'SB VISA' AS NombreComercio
	   ,pl.IdUnicoTransaccion AS IdUnicoTransaccion
	   ,pl.PagoEnLineaResultadoLogId AS PagoEnLineaResultadoLogId
	   ,c.PrimerNombre AS PrimerNombre
	   ,c.SegundoNombre AS SegundoNombre
	   ,c.PrimerApellido AS PrimerApellido
	   ,c.SegundoApellido AS SegundoApellido
	   ,pl.FechaCreacion AS FechaCreacion
	   ,pl.CodigoConsultora AS CodigoConsultora
	   ,u.DocumentoIdentidad AS NumeroDocumento
	   ,'Internet' AS Canal
	   ,'' AS Ciclo
	   ,CONVERT(varchar(50), CONVERT(money, pl.ImporteAutorizado), 1) AS ImporteAutorizado
	   ,CONVERT(varchar(50), CONVERT(money, pl.MontoGastosAdministrativos), 1) AS MontoGastosAdministrativos
	   ,0 AS IVA
	   ,CONVERT(varchar(50), CONVERT(money, pl.MontoPago), 1) AS MontoPago
	   ,'' AS TicketId
	   ,r.Codigo AS CodigoRegion
	   ,z.Codigo AS CodigoZona
	   ,pl.OrigenTarjeta AS OrigenTarjeta
	   ,pl.NumeroTarjeta AS NumeroTarjeta
	   ,pl.NumeroOrdenTienda AS NumeroOrdenTienda
	   ,pl.CodigoError AS CodigoError
	   ,pl.MensajeError AS MensajeError
	   ,pl.FechaTransaccion AS FechaTransaccion
	   ,pl.Origen AS  Origen
	FROM PagoEnLineaResultadoLog pl
	INNER JOIN ods.Consultora c ON pl.ConsultoraID = c.ConsultoraID
	INNER JOIN ods.Region r ON c.RegionID = r.RegionID
	INNER JOIN ods.Zona z ON c.ZonaID = z.ZonaID
	LEFT JOIN usuario u ON u.CodigoUsuario = c.Codigo
	WHERE case when @CampaniaID = 0 then 1 when @CampaniaID = pl.CampaniaId then 1 else 0 end = 1
		AND CASE WHEN @RegionID = 0 THEN 1 WHEN @RegionID = r.RegionID THEN 1 ELSE 0 END = 1
		AND CASE WHEN @ZonaID = 0 THEN 1 WHEN @ZonaID = z.ZonaID THEN 1 ELSE 0 END = 1
		AND CASE WHEN @CodigoConsultora = '' THEN 1 WHEN @CodigoConsultora = c.Codigo THEN 1 ELSE 0 END = 1
		AND (@Estado = '' OR (@Estado = '0' AND pl.CodigoError = @Estado) OR (@Estado = '-1' AND pl.CodigoError != '0'))
		AND (convert(DATE,pl.FechaTransaccion) >= @PagoDesde AND convert(DATE,pl.FechaTransaccion) <= @PagoHasta)
		AND (pl.FechaCreacion >= @ProcesoDesde AND pl.FechaCreacion < @ProcesoHasta)	
	ORDER BY FechaCreacion DESC
END
GO

