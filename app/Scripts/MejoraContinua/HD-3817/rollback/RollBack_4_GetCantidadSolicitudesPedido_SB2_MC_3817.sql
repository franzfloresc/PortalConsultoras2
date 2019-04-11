GO
USE BelcorpPeru
GO
ALTER  procedure dbo.GetCantidadSolicitudesPedido_SB2
	@ConsultoraId BIGINT,
	@Campania INT
AS
BEGIN
	DECLARE @RegionID INT, @ZonaID INT;
	DECLARE @FechaInicioFact DATETIME, @FechaFinFact DATETIME;
	DECLARE @HorasVence INT;

	SELECT @RegionID = RegionID, @ZonaID = ZonaID
	FROM ods.Consultora
	WHERE ConsultoraID = @ConsultoraId;

	SELECT TOP 1 @FechaInicioFact = FechaFinFacturacion
	FROM ods.Campania c
	INNER JOIN ods.Cronograma cc ON c.CampaniaID = cc.CampaniaID
	WHERE c.Codigo < @Campania AND RegionID = @RegionID AND ZonaID = @ZonaID
	ORDER BY c.CampaniaID DESC;

	SELECT TOP 1 @FechaFinFact = FechaFinFacturacion
	FROM ods.Campania c
	INNER JOIN ods.Cronograma cc ON c.CampaniaID = cc.CampaniaID
	WHERE c.Codigo = @Campania AND RegionID = @RegionID AND ZonaID = @ZonaID;

	SELECT @HorasVence = ISNULL(Codigo,24)
	from TablaLogicaDatos
	where TablaLogicaDatosId = 5603;

	SELECT ISNULL(COUNT(sc.SolicitudClienteID),0) AS cantidad
	FROM SolicitudCliente sc
	LEFT JOIN Marca m on sc.MarcaID = m.MarcaID
	WHERE
		ConsultoraID = @ConsultoraId AND sc.Estado IS NULL
		--AND ( sc.Estado IS NULL OR (LTRIM(RTRIM(sc.Estado)) IN ('A','R','C')))
		AND
		IIF(ISNULL(sc.MarcaID,0) = 0, @Campania, Campania) = Campania
		AND
		IIF(
			ISNULL(FlagConsultora,0) = 1,
			IIF(cast(sc.FechaSolicitud AS DATE) BETWEEN CAST(@FechaInicioFact AS DATE) AND CAST(@FechaFinFact AS DATE), 1, 0),
			IIF(sc.FechaSolicitud > DATEADD(HOUR,-@HorasVence,GETDATE()), 1, 0)
		) = 1;
END

GO
USE BelcorpMexico
GO
ALTER  procedure dbo.GetCantidadSolicitudesPedido_SB2
	@ConsultoraId BIGINT,
	@Campania INT
AS
BEGIN
	DECLARE @RegionID INT, @ZonaID INT;
	DECLARE @FechaInicioFact DATETIME, @FechaFinFact DATETIME;
	DECLARE @HorasVence INT;

	SELECT @RegionID = RegionID, @ZonaID = ZonaID
	FROM ods.Consultora
	WHERE ConsultoraID = @ConsultoraId;

	SELECT TOP 1 @FechaInicioFact = FechaFinFacturacion
	FROM ods.Campania c
	INNER JOIN ods.Cronograma cc ON c.CampaniaID = cc.CampaniaID
	WHERE c.Codigo < @Campania AND RegionID = @RegionID AND ZonaID = @ZonaID
	ORDER BY c.CampaniaID DESC;

	SELECT TOP 1 @FechaFinFact = FechaFinFacturacion
	FROM ods.Campania c
	INNER JOIN ods.Cronograma cc ON c.CampaniaID = cc.CampaniaID
	WHERE c.Codigo = @Campania AND RegionID = @RegionID AND ZonaID = @ZonaID;

	SELECT @HorasVence = ISNULL(Codigo,24)
	from TablaLogicaDatos
	where TablaLogicaDatosId = 5603;

	SELECT ISNULL(COUNT(sc.SolicitudClienteID),0) AS cantidad
	FROM SolicitudCliente sc
	LEFT JOIN Marca m on sc.MarcaID = m.MarcaID
	WHERE
		ConsultoraID = @ConsultoraId AND sc.Estado IS NULL
		--AND ( sc.Estado IS NULL OR (LTRIM(RTRIM(sc.Estado)) IN ('A','R','C')))
		AND
		IIF(ISNULL(sc.MarcaID,0) = 0, @Campania, Campania) = Campania
		AND
		IIF(
			ISNULL(FlagConsultora,0) = 1,
			IIF(cast(sc.FechaSolicitud AS DATE) BETWEEN CAST(@FechaInicioFact AS DATE) AND CAST(@FechaFinFact AS DATE), 1, 0),
			IIF(sc.FechaSolicitud > DATEADD(HOUR,-@HorasVence,GETDATE()), 1, 0)
		) = 1;
END

GO
USE BelcorpColombia
GO
ALTER  procedure dbo.GetCantidadSolicitudesPedido_SB2
	@ConsultoraId BIGINT,
	@Campania INT
AS
BEGIN
	DECLARE @RegionID INT, @ZonaID INT;
	DECLARE @FechaInicioFact DATETIME, @FechaFinFact DATETIME;
	DECLARE @HorasVence INT;

	SELECT @RegionID = RegionID, @ZonaID = ZonaID
	FROM ods.Consultora
	WHERE ConsultoraID = @ConsultoraId;

	SELECT TOP 1 @FechaInicioFact = FechaFinFacturacion
	FROM ods.Campania c
	INNER JOIN ods.Cronograma cc ON c.CampaniaID = cc.CampaniaID
	WHERE c.Codigo < @Campania AND RegionID = @RegionID AND ZonaID = @ZonaID
	ORDER BY c.CampaniaID DESC;

	SELECT TOP 1 @FechaFinFact = FechaFinFacturacion
	FROM ods.Campania c
	INNER JOIN ods.Cronograma cc ON c.CampaniaID = cc.CampaniaID
	WHERE c.Codigo = @Campania AND RegionID = @RegionID AND ZonaID = @ZonaID;

	SELECT @HorasVence = ISNULL(Codigo,24)
	from TablaLogicaDatos
	where TablaLogicaDatosId = 5603;

	SELECT ISNULL(COUNT(sc.SolicitudClienteID),0) AS cantidad
	FROM SolicitudCliente sc
	LEFT JOIN Marca m on sc.MarcaID = m.MarcaID
	WHERE
		ConsultoraID = @ConsultoraId AND sc.Estado IS NULL
		--AND ( sc.Estado IS NULL OR (LTRIM(RTRIM(sc.Estado)) IN ('A','R','C')))
		AND
		IIF(ISNULL(sc.MarcaID,0) = 0, @Campania, Campania) = Campania
		AND
		IIF(
			ISNULL(FlagConsultora,0) = 1,
			IIF(cast(sc.FechaSolicitud AS DATE) BETWEEN CAST(@FechaInicioFact AS DATE) AND CAST(@FechaFinFact AS DATE), 1, 0),
			IIF(sc.FechaSolicitud > DATEADD(HOUR,-@HorasVence,GETDATE()), 1, 0)
		) = 1;
END

GO
USE BelcorpSalvador
GO
ALTER  procedure dbo.GetCantidadSolicitudesPedido_SB2
	@ConsultoraId BIGINT,
	@Campania INT
AS
BEGIN
	DECLARE @RegionID INT, @ZonaID INT;
	DECLARE @FechaInicioFact DATETIME, @FechaFinFact DATETIME;
	DECLARE @HorasVence INT;

	SELECT @RegionID = RegionID, @ZonaID = ZonaID
	FROM ods.Consultora
	WHERE ConsultoraID = @ConsultoraId;

	SELECT TOP 1 @FechaInicioFact = FechaFinFacturacion
	FROM ods.Campania c
	INNER JOIN ods.Cronograma cc ON c.CampaniaID = cc.CampaniaID
	WHERE c.Codigo < @Campania AND RegionID = @RegionID AND ZonaID = @ZonaID
	ORDER BY c.CampaniaID DESC;

	SELECT TOP 1 @FechaFinFact = FechaFinFacturacion
	FROM ods.Campania c
	INNER JOIN ods.Cronograma cc ON c.CampaniaID = cc.CampaniaID
	WHERE c.Codigo = @Campania AND RegionID = @RegionID AND ZonaID = @ZonaID;

	SELECT @HorasVence = ISNULL(Codigo,24)
	from TablaLogicaDatos
	where TablaLogicaDatosId = 5603;

	SELECT ISNULL(COUNT(sc.SolicitudClienteID),0) AS cantidad
	FROM SolicitudCliente sc
	LEFT JOIN Marca m on sc.MarcaID = m.MarcaID
	WHERE
		ConsultoraID = @ConsultoraId AND sc.Estado IS NULL
		--AND ( sc.Estado IS NULL OR (LTRIM(RTRIM(sc.Estado)) IN ('A','R','C')))
		AND
		IIF(ISNULL(sc.MarcaID,0) = 0, @Campania, Campania) = Campania
		AND
		IIF(
			ISNULL(FlagConsultora,0) = 1,
			IIF(cast(sc.FechaSolicitud AS DATE) BETWEEN CAST(@FechaInicioFact AS DATE) AND CAST(@FechaFinFact AS DATE), 1, 0),
			IIF(sc.FechaSolicitud > DATEADD(HOUR,-@HorasVence,GETDATE()), 1, 0)
		) = 1;
END

GO
USE BelcorpPuertoRico
GO
ALTER  procedure dbo.GetCantidadSolicitudesPedido_SB2
	@ConsultoraId BIGINT,
	@Campania INT
AS
BEGIN
	DECLARE @RegionID INT, @ZonaID INT;
	DECLARE @FechaInicioFact DATETIME, @FechaFinFact DATETIME;
	DECLARE @HorasVence INT;

	SELECT @RegionID = RegionID, @ZonaID = ZonaID
	FROM ods.Consultora
	WHERE ConsultoraID = @ConsultoraId;

	SELECT TOP 1 @FechaInicioFact = FechaFinFacturacion
	FROM ods.Campania c
	INNER JOIN ods.Cronograma cc ON c.CampaniaID = cc.CampaniaID
	WHERE c.Codigo < @Campania AND RegionID = @RegionID AND ZonaID = @ZonaID
	ORDER BY c.CampaniaID DESC;

	SELECT TOP 1 @FechaFinFact = FechaFinFacturacion
	FROM ods.Campania c
	INNER JOIN ods.Cronograma cc ON c.CampaniaID = cc.CampaniaID
	WHERE c.Codigo = @Campania AND RegionID = @RegionID AND ZonaID = @ZonaID;

	SELECT @HorasVence = ISNULL(Codigo,24)
	from TablaLogicaDatos
	where TablaLogicaDatosId = 5603;

	SELECT ISNULL(COUNT(sc.SolicitudClienteID),0) AS cantidad
	FROM SolicitudCliente sc
	LEFT JOIN Marca m on sc.MarcaID = m.MarcaID
	WHERE
		ConsultoraID = @ConsultoraId AND sc.Estado IS NULL
		--AND ( sc.Estado IS NULL OR (LTRIM(RTRIM(sc.Estado)) IN ('A','R','C')))
		AND
		IIF(ISNULL(sc.MarcaID,0) = 0, @Campania, Campania) = Campania
		AND
		IIF(
			ISNULL(FlagConsultora,0) = 1,
			IIF(cast(sc.FechaSolicitud AS DATE) BETWEEN CAST(@FechaInicioFact AS DATE) AND CAST(@FechaFinFact AS DATE), 1, 0),
			IIF(sc.FechaSolicitud > DATEADD(HOUR,-@HorasVence,GETDATE()), 1, 0)
		) = 1;
END

GO
USE BelcorpPanama
GO
ALTER  procedure dbo.GetCantidadSolicitudesPedido_SB2
	@ConsultoraId BIGINT,
	@Campania INT
AS
BEGIN
	DECLARE @RegionID INT, @ZonaID INT;
	DECLARE @FechaInicioFact DATETIME, @FechaFinFact DATETIME;
	DECLARE @HorasVence INT;

	SELECT @RegionID = RegionID, @ZonaID = ZonaID
	FROM ods.Consultora
	WHERE ConsultoraID = @ConsultoraId;

	SELECT TOP 1 @FechaInicioFact = FechaFinFacturacion
	FROM ods.Campania c
	INNER JOIN ods.Cronograma cc ON c.CampaniaID = cc.CampaniaID
	WHERE c.Codigo < @Campania AND RegionID = @RegionID AND ZonaID = @ZonaID
	ORDER BY c.CampaniaID DESC;

	SELECT TOP 1 @FechaFinFact = FechaFinFacturacion
	FROM ods.Campania c
	INNER JOIN ods.Cronograma cc ON c.CampaniaID = cc.CampaniaID
	WHERE c.Codigo = @Campania AND RegionID = @RegionID AND ZonaID = @ZonaID;

	SELECT @HorasVence = ISNULL(Codigo,24)
	from TablaLogicaDatos
	where TablaLogicaDatosId = 5603;

	SELECT ISNULL(COUNT(sc.SolicitudClienteID),0) AS cantidad
	FROM SolicitudCliente sc
	LEFT JOIN Marca m on sc.MarcaID = m.MarcaID
	WHERE
		ConsultoraID = @ConsultoraId AND sc.Estado IS NULL
		--AND ( sc.Estado IS NULL OR (LTRIM(RTRIM(sc.Estado)) IN ('A','R','C')))
		AND
		IIF(ISNULL(sc.MarcaID,0) = 0, @Campania, Campania) = Campania
		AND
		IIF(
			ISNULL(FlagConsultora,0) = 1,
			IIF(cast(sc.FechaSolicitud AS DATE) BETWEEN CAST(@FechaInicioFact AS DATE) AND CAST(@FechaFinFact AS DATE), 1, 0),
			IIF(sc.FechaSolicitud > DATEADD(HOUR,-@HorasVence,GETDATE()), 1, 0)
		) = 1;
END

GO
USE BelcorpGuatemala
GO
ALTER  procedure dbo.GetCantidadSolicitudesPedido_SB2
	@ConsultoraId BIGINT,
	@Campania INT
AS
BEGIN
	DECLARE @RegionID INT, @ZonaID INT;
	DECLARE @FechaInicioFact DATETIME, @FechaFinFact DATETIME;
	DECLARE @HorasVence INT;

	SELECT @RegionID = RegionID, @ZonaID = ZonaID
	FROM ods.Consultora
	WHERE ConsultoraID = @ConsultoraId;

	SELECT TOP 1 @FechaInicioFact = FechaFinFacturacion
	FROM ods.Campania c
	INNER JOIN ods.Cronograma cc ON c.CampaniaID = cc.CampaniaID
	WHERE c.Codigo < @Campania AND RegionID = @RegionID AND ZonaID = @ZonaID
	ORDER BY c.CampaniaID DESC;

	SELECT TOP 1 @FechaFinFact = FechaFinFacturacion
	FROM ods.Campania c
	INNER JOIN ods.Cronograma cc ON c.CampaniaID = cc.CampaniaID
	WHERE c.Codigo = @Campania AND RegionID = @RegionID AND ZonaID = @ZonaID;

	SELECT @HorasVence = ISNULL(Codigo,24)
	from TablaLogicaDatos
	where TablaLogicaDatosId = 5603;

	SELECT ISNULL(COUNT(sc.SolicitudClienteID),0) AS cantidad
	FROM SolicitudCliente sc
	LEFT JOIN Marca m on sc.MarcaID = m.MarcaID
	WHERE
		ConsultoraID = @ConsultoraId AND sc.Estado IS NULL
		--AND ( sc.Estado IS NULL OR (LTRIM(RTRIM(sc.Estado)) IN ('A','R','C')))
		AND
		IIF(ISNULL(sc.MarcaID,0) = 0, @Campania, Campania) = Campania
		AND
		IIF(
			ISNULL(FlagConsultora,0) = 1,
			IIF(cast(sc.FechaSolicitud AS DATE) BETWEEN CAST(@FechaInicioFact AS DATE) AND CAST(@FechaFinFact AS DATE), 1, 0),
			IIF(sc.FechaSolicitud > DATEADD(HOUR,-@HorasVence,GETDATE()), 1, 0)
		) = 1;
END

GO
USE BelcorpEcuador
GO
ALTER  procedure dbo.GetCantidadSolicitudesPedido_SB2
	@ConsultoraId BIGINT,
	@Campania INT
AS
BEGIN
	DECLARE @RegionID INT, @ZonaID INT;
	DECLARE @FechaInicioFact DATETIME, @FechaFinFact DATETIME;
	DECLARE @HorasVence INT;

	SELECT @RegionID = RegionID, @ZonaID = ZonaID
	FROM ods.Consultora
	WHERE ConsultoraID = @ConsultoraId;

	SELECT TOP 1 @FechaInicioFact = FechaFinFacturacion
	FROM ods.Campania c
	INNER JOIN ods.Cronograma cc ON c.CampaniaID = cc.CampaniaID
	WHERE c.Codigo < @Campania AND RegionID = @RegionID AND ZonaID = @ZonaID
	ORDER BY c.CampaniaID DESC;

	SELECT TOP 1 @FechaFinFact = FechaFinFacturacion
	FROM ods.Campania c
	INNER JOIN ods.Cronograma cc ON c.CampaniaID = cc.CampaniaID
	WHERE c.Codigo = @Campania AND RegionID = @RegionID AND ZonaID = @ZonaID;

	SELECT @HorasVence = ISNULL(Codigo,24)
	from TablaLogicaDatos
	where TablaLogicaDatosId = 5603;

	SELECT ISNULL(COUNT(sc.SolicitudClienteID),0) AS cantidad
	FROM SolicitudCliente sc
	LEFT JOIN Marca m on sc.MarcaID = m.MarcaID
	WHERE
		ConsultoraID = @ConsultoraId AND sc.Estado IS NULL
		--AND ( sc.Estado IS NULL OR (LTRIM(RTRIM(sc.Estado)) IN ('A','R','C')))
		AND
		IIF(ISNULL(sc.MarcaID,0) = 0, @Campania, Campania) = Campania
		AND
		IIF(
			ISNULL(FlagConsultora,0) = 1,
			IIF(cast(sc.FechaSolicitud AS DATE) BETWEEN CAST(@FechaInicioFact AS DATE) AND CAST(@FechaFinFact AS DATE), 1, 0),
			IIF(sc.FechaSolicitud > DATEADD(HOUR,-@HorasVence,GETDATE()), 1, 0)
		) = 1;
END

GO
USE BelcorpDominicana
GO
ALTER  procedure dbo.GetCantidadSolicitudesPedido_SB2
	@ConsultoraId BIGINT,
	@Campania INT
AS
BEGIN
	DECLARE @RegionID INT, @ZonaID INT;
	DECLARE @FechaInicioFact DATETIME, @FechaFinFact DATETIME;
	DECLARE @HorasVence INT;

	SELECT @RegionID = RegionID, @ZonaID = ZonaID
	FROM ods.Consultora
	WHERE ConsultoraID = @ConsultoraId;

	SELECT TOP 1 @FechaInicioFact = FechaFinFacturacion
	FROM ods.Campania c
	INNER JOIN ods.Cronograma cc ON c.CampaniaID = cc.CampaniaID
	WHERE c.Codigo < @Campania AND RegionID = @RegionID AND ZonaID = @ZonaID
	ORDER BY c.CampaniaID DESC;

	SELECT TOP 1 @FechaFinFact = FechaFinFacturacion
	FROM ods.Campania c
	INNER JOIN ods.Cronograma cc ON c.CampaniaID = cc.CampaniaID
	WHERE c.Codigo = @Campania AND RegionID = @RegionID AND ZonaID = @ZonaID;

	SELECT @HorasVence = ISNULL(Codigo,24)
	from TablaLogicaDatos
	where TablaLogicaDatosId = 5603;

	SELECT ISNULL(COUNT(sc.SolicitudClienteID),0) AS cantidad
	FROM SolicitudCliente sc
	LEFT JOIN Marca m on sc.MarcaID = m.MarcaID
	WHERE
		ConsultoraID = @ConsultoraId AND sc.Estado IS NULL
		--AND ( sc.Estado IS NULL OR (LTRIM(RTRIM(sc.Estado)) IN ('A','R','C')))
		AND
		IIF(ISNULL(sc.MarcaID,0) = 0, @Campania, Campania) = Campania
		AND
		IIF(
			ISNULL(FlagConsultora,0) = 1,
			IIF(cast(sc.FechaSolicitud AS DATE) BETWEEN CAST(@FechaInicioFact AS DATE) AND CAST(@FechaFinFact AS DATE), 1, 0),
			IIF(sc.FechaSolicitud > DATEADD(HOUR,-@HorasVence,GETDATE()), 1, 0)
		) = 1;
END

GO
USE BelcorpCostaRica
GO
ALTER  procedure dbo.GetCantidadSolicitudesPedido_SB2
	@ConsultoraId BIGINT,
	@Campania INT
AS
BEGIN
	DECLARE @RegionID INT, @ZonaID INT;
	DECLARE @FechaInicioFact DATETIME, @FechaFinFact DATETIME;
	DECLARE @HorasVence INT;

	SELECT @RegionID = RegionID, @ZonaID = ZonaID
	FROM ods.Consultora
	WHERE ConsultoraID = @ConsultoraId;

	SELECT TOP 1 @FechaInicioFact = FechaFinFacturacion
	FROM ods.Campania c
	INNER JOIN ods.Cronograma cc ON c.CampaniaID = cc.CampaniaID
	WHERE c.Codigo < @Campania AND RegionID = @RegionID AND ZonaID = @ZonaID
	ORDER BY c.CampaniaID DESC;

	SELECT TOP 1 @FechaFinFact = FechaFinFacturacion
	FROM ods.Campania c
	INNER JOIN ods.Cronograma cc ON c.CampaniaID = cc.CampaniaID
	WHERE c.Codigo = @Campania AND RegionID = @RegionID AND ZonaID = @ZonaID;

	SELECT @HorasVence = ISNULL(Codigo,24)
	from TablaLogicaDatos
	where TablaLogicaDatosId = 5603;

	SELECT ISNULL(COUNT(sc.SolicitudClienteID),0) AS cantidad
	FROM SolicitudCliente sc
	LEFT JOIN Marca m on sc.MarcaID = m.MarcaID
	WHERE
		ConsultoraID = @ConsultoraId AND sc.Estado IS NULL
		--AND ( sc.Estado IS NULL OR (LTRIM(RTRIM(sc.Estado)) IN ('A','R','C')))
		AND
		IIF(ISNULL(sc.MarcaID,0) = 0, @Campania, Campania) = Campania
		AND
		IIF(
			ISNULL(FlagConsultora,0) = 1,
			IIF(cast(sc.FechaSolicitud AS DATE) BETWEEN CAST(@FechaInicioFact AS DATE) AND CAST(@FechaFinFact AS DATE), 1, 0),
			IIF(sc.FechaSolicitud > DATEADD(HOUR,-@HorasVence,GETDATE()), 1, 0)
		) = 1;
END

GO
USE BelcorpChile
GO
ALTER  procedure dbo.GetCantidadSolicitudesPedido_SB2
	@ConsultoraId BIGINT,
	@Campania INT
AS
BEGIN
	DECLARE @RegionID INT, @ZonaID INT;
	DECLARE @FechaInicioFact DATETIME, @FechaFinFact DATETIME;
	DECLARE @HorasVence INT;

	SELECT @RegionID = RegionID, @ZonaID = ZonaID
	FROM ods.Consultora
	WHERE ConsultoraID = @ConsultoraId;

	SELECT TOP 1 @FechaInicioFact = FechaFinFacturacion
	FROM ods.Campania c
	INNER JOIN ods.Cronograma cc ON c.CampaniaID = cc.CampaniaID
	WHERE c.Codigo < @Campania AND RegionID = @RegionID AND ZonaID = @ZonaID
	ORDER BY c.CampaniaID DESC;

	SELECT TOP 1 @FechaFinFact = FechaFinFacturacion
	FROM ods.Campania c
	INNER JOIN ods.Cronograma cc ON c.CampaniaID = cc.CampaniaID
	WHERE c.Codigo = @Campania AND RegionID = @RegionID AND ZonaID = @ZonaID;

	SELECT @HorasVence = ISNULL(Codigo,24)
	from TablaLogicaDatos
	where TablaLogicaDatosId = 5603;

	SELECT ISNULL(COUNT(sc.SolicitudClienteID),0) AS cantidad
	FROM SolicitudCliente sc
	LEFT JOIN Marca m on sc.MarcaID = m.MarcaID
	WHERE
		ConsultoraID = @ConsultoraId AND sc.Estado IS NULL
		--AND ( sc.Estado IS NULL OR (LTRIM(RTRIM(sc.Estado)) IN ('A','R','C')))
		AND
		IIF(ISNULL(sc.MarcaID,0) = 0, @Campania, Campania) = Campania
		AND
		IIF(
			ISNULL(FlagConsultora,0) = 1,
			IIF(cast(sc.FechaSolicitud AS DATE) BETWEEN CAST(@FechaInicioFact AS DATE) AND CAST(@FechaFinFact AS DATE), 1, 0),
			IIF(sc.FechaSolicitud > DATEADD(HOUR,-@HorasVence,GETDATE()), 1, 0)
		) = 1;
END

GO
USE BelcorpBolivia
GO
ALTER  procedure dbo.GetCantidadSolicitudesPedido_SB2
	@ConsultoraId BIGINT,
	@Campania INT
AS
BEGIN
	DECLARE @RegionID INT, @ZonaID INT;
	DECLARE @FechaInicioFact DATETIME, @FechaFinFact DATETIME;
	DECLARE @HorasVence INT;

	SELECT @RegionID = RegionID, @ZonaID = ZonaID
	FROM ods.Consultora
	WHERE ConsultoraID = @ConsultoraId;

	SELECT TOP 1 @FechaInicioFact = FechaFinFacturacion
	FROM ods.Campania c
	INNER JOIN ods.Cronograma cc ON c.CampaniaID = cc.CampaniaID
	WHERE c.Codigo < @Campania AND RegionID = @RegionID AND ZonaID = @ZonaID
	ORDER BY c.CampaniaID DESC;

	SELECT TOP 1 @FechaFinFact = FechaFinFacturacion
	FROM ods.Campania c
	INNER JOIN ods.Cronograma cc ON c.CampaniaID = cc.CampaniaID
	WHERE c.Codigo = @Campania AND RegionID = @RegionID AND ZonaID = @ZonaID;

	SELECT @HorasVence = ISNULL(Codigo,24)
	from TablaLogicaDatos
	where TablaLogicaDatosId = 5603;

	SELECT ISNULL(COUNT(sc.SolicitudClienteID),0) AS cantidad
	FROM SolicitudCliente sc
	LEFT JOIN Marca m on sc.MarcaID = m.MarcaID
	WHERE
		ConsultoraID = @ConsultoraId AND sc.Estado IS NULL
		--AND ( sc.Estado IS NULL OR (LTRIM(RTRIM(sc.Estado)) IN ('A','R','C')))
		AND
		IIF(ISNULL(sc.MarcaID,0) = 0, @Campania, Campania) = Campania
		AND
		IIF(
			ISNULL(FlagConsultora,0) = 1,
			IIF(cast(sc.FechaSolicitud AS DATE) BETWEEN CAST(@FechaInicioFact AS DATE) AND CAST(@FechaFinFact AS DATE), 1, 0),
			IIF(sc.FechaSolicitud > DATEADD(HOUR,-@HorasVence,GETDATE()), 1, 0)
		) = 1;
END

GO
