USE BelcorpBolivia
go
alter procedure dbo.GetCantidadSolicitudesPedido_SB2
	@ConsultoraId BIGINT,
	@Campania INT
AS    
BEGIN
	DECLARE @RegionID INT, @ZonaID INT;
	DECLARE @FechaInicioFact DATETIME, @FechaFinFact DATETIME;

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
			IIF(sc.FechaSolicitud > DATEADD(DAY,-1,GETDATE()), 1, 0)
		) = 1;
END
go
/*end*/

USE BelcorpChile
go
alter procedure dbo.GetCantidadSolicitudesPedido_SB2
	@ConsultoraId BIGINT,
	@Campania INT
AS    
BEGIN
	DECLARE @RegionID INT, @ZonaID INT;
	DECLARE @FechaInicioFact DATETIME, @FechaFinFact DATETIME;

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
			IIF(sc.FechaSolicitud > DATEADD(DAY,-1,GETDATE()), 1, 0)
		) = 1;
END
go
/*end*/

USE BelcorpCostaRica
go
alter procedure dbo.GetCantidadSolicitudesPedido_SB2
	@ConsultoraId BIGINT,
	@Campania INT
AS    
BEGIN
	DECLARE @RegionID INT, @ZonaID INT;
	DECLARE @FechaInicioFact DATETIME, @FechaFinFact DATETIME;

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
			IIF(sc.FechaSolicitud > DATEADD(DAY,-1,GETDATE()), 1, 0)
		) = 1;
END
go
/*end*/

USE BelcorpDominicana
go
alter procedure dbo.GetCantidadSolicitudesPedido_SB2
	@ConsultoraId BIGINT,
	@Campania INT
AS    
BEGIN
	DECLARE @RegionID INT, @ZonaID INT;
	DECLARE @FechaInicioFact DATETIME, @FechaFinFact DATETIME;

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
			IIF(sc.FechaSolicitud > DATEADD(DAY,-1,GETDATE()), 1, 0)
		) = 1;
END
go
/*end*/

USE BelcorpEcuador
go
alter procedure dbo.GetCantidadSolicitudesPedido_SB2
	@ConsultoraId BIGINT,
	@Campania INT
AS    
BEGIN
	DECLARE @RegionID INT, @ZonaID INT;
	DECLARE @FechaInicioFact DATETIME, @FechaFinFact DATETIME;

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
			IIF(sc.FechaSolicitud > DATEADD(DAY,-1,GETDATE()), 1, 0)
		) = 1;
END
go
/*end*/

USE BelcorpGuatemala
go
alter procedure dbo.GetCantidadSolicitudesPedido_SB2
	@ConsultoraId BIGINT,
	@Campania INT
AS    
BEGIN
	DECLARE @RegionID INT, @ZonaID INT;
	DECLARE @FechaInicioFact DATETIME, @FechaFinFact DATETIME;

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
			IIF(sc.FechaSolicitud > DATEADD(DAY,-1,GETDATE()), 1, 0)
		) = 1;
END
go
/*end*/

USE BelcorpPanama
go
alter procedure dbo.GetCantidadSolicitudesPedido_SB2
	@ConsultoraId BIGINT,
	@Campania INT
AS    
BEGIN
	DECLARE @RegionID INT, @ZonaID INT;
	DECLARE @FechaInicioFact DATETIME, @FechaFinFact DATETIME;

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
			IIF(sc.FechaSolicitud > DATEADD(DAY,-1,GETDATE()), 1, 0)
		) = 1;
END
go
/*end*/

USE BelcorpPuertoRico
go
alter procedure dbo.GetCantidadSolicitudesPedido_SB2
	@ConsultoraId BIGINT,
	@Campania INT
AS    
BEGIN
	DECLARE @RegionID INT, @ZonaID INT;
	DECLARE @FechaInicioFact DATETIME, @FechaFinFact DATETIME;

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
			IIF(sc.FechaSolicitud > DATEADD(DAY,-1,GETDATE()), 1, 0)
		) = 1;
END
go
/*end*/

USE BelcorpSalvador
go
alter procedure dbo.GetCantidadSolicitudesPedido_SB2
	@ConsultoraId BIGINT,
	@Campania INT
AS    
BEGIN
	DECLARE @RegionID INT, @ZonaID INT;
	DECLARE @FechaInicioFact DATETIME, @FechaFinFact DATETIME;

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
			IIF(sc.FechaSolicitud > DATEADD(DAY,-1,GETDATE()), 1, 0)
		) = 1;
END
go
/*end*/

USE BelcorpVenezuela
go
alter procedure dbo.GetCantidadSolicitudesPedido_SB2
	@ConsultoraId BIGINT,
	@Campania INT
AS    
BEGIN
	DECLARE @RegionID INT, @ZonaID INT;
	DECLARE @FechaInicioFact DATETIME, @FechaFinFact DATETIME;

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
			IIF(sc.FechaSolicitud > DATEADD(DAY,-1,GETDATE()), 1, 0)
		) = 1;
END
go
/*end*/

USE BelcorpColombia
go
alter procedure dbo.GetCantidadSolicitudesPedido_SB2
	@ConsultoraId BIGINT,
	@Campania INT
AS    
BEGIN
	DECLARE @RegionID INT, @ZonaID INT;
	DECLARE @FechaInicioFact DATETIME, @FechaFinFact DATETIME;

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
			IIF(sc.FechaSolicitud > DATEADD(DAY,-1,GETDATE()), 1, 0)
		) = 1;
END
go
/*end*/

USE BelcorpMexico
go
alter procedure dbo.GetCantidadSolicitudesPedido_SB2
	@ConsultoraId BIGINT,
	@Campania INT
AS    
BEGIN
	DECLARE @RegionID INT, @ZonaID INT;
	DECLARE @FechaInicioFact DATETIME, @FechaFinFact DATETIME;

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
			IIF(sc.FechaSolicitud > DATEADD(DAY,-1,GETDATE()), 1, 0)
		) = 1;
END
go
/*end*/

USE BelcorpPeru
go
alter procedure dbo.GetCantidadSolicitudesPedido_SB2
	@ConsultoraId BIGINT,
	@Campania INT
AS    
BEGIN
	DECLARE @RegionID INT, @ZonaID INT;
	DECLARE @FechaInicioFact DATETIME, @FechaFinFact DATETIME;

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
			IIF(sc.FechaSolicitud > DATEADD(DAY,-1,GETDATE()), 1, 0)
		) = 1;
END
go