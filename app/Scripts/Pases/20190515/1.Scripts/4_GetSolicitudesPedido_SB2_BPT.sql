

USE BelcorpBolivia
GO

ALTER PROCEDURE [dbo].[GetSolicitudesPedido_SB2] @ConsultoraId BIGINT
	,@Campania INT
AS
BEGIN
	DECLARE @RegionID INT
		,@ZonaID INT;
	DECLARE @FechaInicioFact DATETIME
		,@FechaFinFact DATETIME;

	SELECT @RegionID = RegionID
		,@ZonaID = ZonaID
	FROM ods.Consultora
	WHERE ConsultoraID = @ConsultoraId;

	SELECT TOP 1 @FechaInicioFact = FechaFinFacturacion
	FROM ods.Campania c
	INNER JOIN ods.Cronograma cc ON c.CampaniaID = cc.CampaniaID
	WHERE c.Codigo < @Campania
		AND RegionID = @RegionID
		AND ZonaID = @ZonaID
	ORDER BY c.CampaniaID DESC;

	SELECT TOP 1 @FechaFinFact = FechaFinFacturacion
	FROM ods.Campania c
	INNER JOIN ods.Cronograma cc ON c.CampaniaID = cc.CampaniaID
	WHERE c.Codigo = @Campania
		AND RegionID = @RegionID
		AND ZonaID = @ZonaID;

	SELECT SolicitudClienteID
		,sc.MarcaID
		,Campania
		,NombreCompleto
		,Telefono
		,Direccion
		,Email
		,Mensaje
		,Leido
		,ISNULL(Estado, '') AS Estado
		,NumIteracion
		,CodigoUbigeo
		,FechaSolicitud
		,FechaModificacion
		,ISNULL(FlagConsultora, 0) AS FlagConsultora
		,FlagMedio
		,(
			SELECT ISNULL(tld.Descripcion, '')
			FROM TablaLogicaDatos tld
			WHERE tld.tablalogicaid = 85
				AND tld.Codigo = flagmedio
			) AS MContacto
		,(
			SELECT SUM((Precio * Cantidad))
			FROM SolicitudClienteDetalle
			WHERE SolicitudClienteID = sc.SolicitudClienteID
			) AS PrecioTotal
		,m.Descripcion AS Marca
		,
		--case isnull(FlagConsultora,0)
		--	when 1 then '00:00:00'
		--	else dbo.CaclSaldoHorasSolicitudPedido(FechaSolicitud)
		--end SaldoHoras,
		ISNULL(PedidoWebID, 0) AS PedidoWebID
	FROM SolicitudCliente sc
	LEFT JOIN Marca m ON sc.MarcaID = m.MarcaID
	WHERE ConsultoraID = @ConsultoraId
		AND (
			sc.Estado IS NULL
			OR (
				LTRIM(RTRIM(sc.Estado)) IN ('A','R','C')
				)
			)
		--and ( sc.Estado IS NULL )	-- pendientes de aprobacaion
		AND IIF(ISNULL(sc.MarcaID, 0) = 0, @Campania, Campania) = Campania
		AND IIF(ISNULL(FlagConsultora, 0) = 1, 
			IIF(CAST(sc.FechaSolicitud AS DATE) 
				BETWEEN CAST(@FechaInicioFact AS DATE) AND CAST(@FechaFinFact AS DATE)
						,1
						,0), 1) = 1
	ORDER BY ISNULL(FlagConsultora, 0) DESC
		,ISNULL(sc.MarcaID, 0) ASC
		,FechaSolicitud ASC
		,PrecioTotal DESC;
END
GO

USE BelcorpChile
GO

ALTER PROCEDURE [dbo].[GetSolicitudesPedido_SB2] @ConsultoraId BIGINT
	,@Campania INT
AS
BEGIN
	DECLARE @RegionID INT
		,@ZonaID INT;
	DECLARE @FechaInicioFact DATETIME
		,@FechaFinFact DATETIME;

	SELECT @RegionID = RegionID
		,@ZonaID = ZonaID
	FROM ods.Consultora
	WHERE ConsultoraID = @ConsultoraId;

	SELECT TOP 1 @FechaInicioFact = FechaFinFacturacion
	FROM ods.Campania c
	INNER JOIN ods.Cronograma cc ON c.CampaniaID = cc.CampaniaID
	WHERE c.Codigo < @Campania
		AND RegionID = @RegionID
		AND ZonaID = @ZonaID
	ORDER BY c.CampaniaID DESC;

	SELECT TOP 1 @FechaFinFact = FechaFinFacturacion
	FROM ods.Campania c
	INNER JOIN ods.Cronograma cc ON c.CampaniaID = cc.CampaniaID
	WHERE c.Codigo = @Campania
		AND RegionID = @RegionID
		AND ZonaID = @ZonaID;

	SELECT SolicitudClienteID
		,sc.MarcaID
		,Campania
		,NombreCompleto
		,Telefono
		,Direccion
		,Email
		,Mensaje
		,Leido
		,ISNULL(Estado, '') AS Estado
		,NumIteracion
		,CodigoUbigeo
		,FechaSolicitud
		,FechaModificacion
		,ISNULL(FlagConsultora, 0) AS FlagConsultora
		,FlagMedio
		,(
			SELECT ISNULL(tld.Descripcion, '')
			FROM TablaLogicaDatos tld
			WHERE tld.tablalogicaid = 85
				AND tld.Codigo = flagmedio
			) AS MContacto
		,(
			SELECT SUM((Precio * Cantidad))
			FROM SolicitudClienteDetalle
			WHERE SolicitudClienteID = sc.SolicitudClienteID
			) AS PrecioTotal
		,m.Descripcion AS Marca
		,
		--case isnull(FlagConsultora,0)
		--	when 1 then '00:00:00'
		--	else dbo.CaclSaldoHorasSolicitudPedido(FechaSolicitud)
		--end SaldoHoras,
		ISNULL(PedidoWebID, 0) AS PedidoWebID
	FROM SolicitudCliente sc
	LEFT JOIN Marca m ON sc.MarcaID = m.MarcaID
	WHERE ConsultoraID = @ConsultoraId
		AND (
			sc.Estado IS NULL
			OR (
				LTRIM(RTRIM(sc.Estado)) IN ('A','R','C')
				)
			)
		--and ( sc.Estado IS NULL )	-- pendientes de aprobacaion
		AND IIF(ISNULL(sc.MarcaID, 0) = 0, @Campania, Campania) = Campania
		AND IIF(ISNULL(FlagConsultora, 0) = 1, 
			IIF(CAST(sc.FechaSolicitud AS DATE) 
				BETWEEN CAST(@FechaInicioFact AS DATE) AND CAST(@FechaFinFact AS DATE)
						,1
						,0), 1) = 1
	ORDER BY ISNULL(FlagConsultora, 0) DESC
		,ISNULL(sc.MarcaID, 0) ASC
		,FechaSolicitud ASC
		,PrecioTotal DESC;
END
GO

USE BelcorpColombia
GO

ALTER PROCEDURE [dbo].[GetSolicitudesPedido_SB2] @ConsultoraId BIGINT
	,@Campania INT
AS
BEGIN
	DECLARE @RegionID INT
		,@ZonaID INT;
	DECLARE @FechaInicioFact DATETIME
		,@FechaFinFact DATETIME;

	SELECT @RegionID = RegionID
		,@ZonaID = ZonaID
	FROM ods.Consultora
	WHERE ConsultoraID = @ConsultoraId;

	SELECT TOP 1 @FechaInicioFact = FechaFinFacturacion
	FROM ods.Campania c
	INNER JOIN ods.Cronograma cc ON c.CampaniaID = cc.CampaniaID
	WHERE c.Codigo < @Campania
		AND RegionID = @RegionID
		AND ZonaID = @ZonaID
	ORDER BY c.CampaniaID DESC;

	SELECT TOP 1 @FechaFinFact = FechaFinFacturacion
	FROM ods.Campania c
	INNER JOIN ods.Cronograma cc ON c.CampaniaID = cc.CampaniaID
	WHERE c.Codigo = @Campania
		AND RegionID = @RegionID
		AND ZonaID = @ZonaID;

	SELECT SolicitudClienteID
		,sc.MarcaID
		,Campania
		,NombreCompleto
		,Telefono
		,Direccion
		,Email
		,Mensaje
		,Leido
		,ISNULL(Estado, '') AS Estado
		,NumIteracion
		,CodigoUbigeo
		,FechaSolicitud
		,FechaModificacion
		,ISNULL(FlagConsultora, 0) AS FlagConsultora
		,FlagMedio
		,(
			SELECT ISNULL(tld.Descripcion, '')
			FROM TablaLogicaDatos tld
			WHERE tld.tablalogicaid = 85
				AND tld.Codigo = flagmedio
			) AS MContacto
		,(
			SELECT SUM((Precio * Cantidad))
			FROM SolicitudClienteDetalle
			WHERE SolicitudClienteID = sc.SolicitudClienteID
			) AS PrecioTotal
		,m.Descripcion AS Marca
		,
		--case isnull(FlagConsultora,0)
		--	when 1 then '00:00:00'
		--	else dbo.CaclSaldoHorasSolicitudPedido(FechaSolicitud)
		--end SaldoHoras,
		ISNULL(PedidoWebID, 0) AS PedidoWebID
	FROM SolicitudCliente sc
	LEFT JOIN Marca m ON sc.MarcaID = m.MarcaID
	WHERE ConsultoraID = @ConsultoraId
		AND (
			sc.Estado IS NULL
			OR (
				LTRIM(RTRIM(sc.Estado)) IN ('A','R','C')
				)
			)
		--and ( sc.Estado IS NULL )	-- pendientes de aprobacaion
		AND IIF(ISNULL(sc.MarcaID, 0) = 0, @Campania, Campania) = Campania
		AND IIF(ISNULL(FlagConsultora, 0) = 1, 
			IIF(CAST(sc.FechaSolicitud AS DATE) 
				BETWEEN CAST(@FechaInicioFact AS DATE) AND CAST(@FechaFinFact AS DATE)
						,1
						,0), 1) = 1
	ORDER BY ISNULL(FlagConsultora, 0) DESC
		,ISNULL(sc.MarcaID, 0) ASC
		,FechaSolicitud ASC
		,PrecioTotal DESC;
END
GO

USE BelcorpCostaRica
GO

ALTER PROCEDURE [dbo].[GetSolicitudesPedido_SB2] @ConsultoraId BIGINT
	,@Campania INT
AS
BEGIN
	DECLARE @RegionID INT
		,@ZonaID INT;
	DECLARE @FechaInicioFact DATETIME
		,@FechaFinFact DATETIME;

	SELECT @RegionID = RegionID
		,@ZonaID = ZonaID
	FROM ods.Consultora
	WHERE ConsultoraID = @ConsultoraId;

	SELECT TOP 1 @FechaInicioFact = FechaFinFacturacion
	FROM ods.Campania c
	INNER JOIN ods.Cronograma cc ON c.CampaniaID = cc.CampaniaID
	WHERE c.Codigo < @Campania
		AND RegionID = @RegionID
		AND ZonaID = @ZonaID
	ORDER BY c.CampaniaID DESC;

	SELECT TOP 1 @FechaFinFact = FechaFinFacturacion
	FROM ods.Campania c
	INNER JOIN ods.Cronograma cc ON c.CampaniaID = cc.CampaniaID
	WHERE c.Codigo = @Campania
		AND RegionID = @RegionID
		AND ZonaID = @ZonaID;

	SELECT SolicitudClienteID
		,sc.MarcaID
		,Campania
		,NombreCompleto
		,Telefono
		,Direccion
		,Email
		,Mensaje
		,Leido
		,ISNULL(Estado, '') AS Estado
		,NumIteracion
		,CodigoUbigeo
		,FechaSolicitud
		,FechaModificacion
		,ISNULL(FlagConsultora, 0) AS FlagConsultora
		,FlagMedio
		,(
			SELECT ISNULL(tld.Descripcion, '')
			FROM TablaLogicaDatos tld
			WHERE tld.tablalogicaid = 85
				AND tld.Codigo = flagmedio
			) AS MContacto
		,(
			SELECT SUM((Precio * Cantidad))
			FROM SolicitudClienteDetalle
			WHERE SolicitudClienteID = sc.SolicitudClienteID
			) AS PrecioTotal
		,m.Descripcion AS Marca
		,
		--case isnull(FlagConsultora,0)
		--	when 1 then '00:00:00'
		--	else dbo.CaclSaldoHorasSolicitudPedido(FechaSolicitud)
		--end SaldoHoras,
		ISNULL(PedidoWebID, 0) AS PedidoWebID
	FROM SolicitudCliente sc
	LEFT JOIN Marca m ON sc.MarcaID = m.MarcaID
	WHERE ConsultoraID = @ConsultoraId
		AND (
			sc.Estado IS NULL
			OR (
				LTRIM(RTRIM(sc.Estado)) IN ('A','R','C')
				)
			)
		--and ( sc.Estado IS NULL )	-- pendientes de aprobacaion
		AND IIF(ISNULL(sc.MarcaID, 0) = 0, @Campania, Campania) = Campania
		AND IIF(ISNULL(FlagConsultora, 0) = 1, 
			IIF(CAST(sc.FechaSolicitud AS DATE) 
				BETWEEN CAST(@FechaInicioFact AS DATE) AND CAST(@FechaFinFact AS DATE)
						,1
						,0), 1) = 1
	ORDER BY ISNULL(FlagConsultora, 0) DESC
		,ISNULL(sc.MarcaID, 0) ASC
		,FechaSolicitud ASC
		,PrecioTotal DESC;
END
GO

USE BelcorpDominicana
GO

ALTER PROCEDURE [dbo].[GetSolicitudesPedido_SB2] @ConsultoraId BIGINT
	,@Campania INT
AS
BEGIN
	DECLARE @RegionID INT
		,@ZonaID INT;
	DECLARE @FechaInicioFact DATETIME
		,@FechaFinFact DATETIME;

	SELECT @RegionID = RegionID
		,@ZonaID = ZonaID
	FROM ods.Consultora
	WHERE ConsultoraID = @ConsultoraId;

	SELECT TOP 1 @FechaInicioFact = FechaFinFacturacion
	FROM ods.Campania c
	INNER JOIN ods.Cronograma cc ON c.CampaniaID = cc.CampaniaID
	WHERE c.Codigo < @Campania
		AND RegionID = @RegionID
		AND ZonaID = @ZonaID
	ORDER BY c.CampaniaID DESC;

	SELECT TOP 1 @FechaFinFact = FechaFinFacturacion
	FROM ods.Campania c
	INNER JOIN ods.Cronograma cc ON c.CampaniaID = cc.CampaniaID
	WHERE c.Codigo = @Campania
		AND RegionID = @RegionID
		AND ZonaID = @ZonaID;

	SELECT SolicitudClienteID
		,sc.MarcaID
		,Campania
		,NombreCompleto
		,Telefono
		,Direccion
		,Email
		,Mensaje
		,Leido
		,ISNULL(Estado, '') AS Estado
		,NumIteracion
		,CodigoUbigeo
		,FechaSolicitud
		,FechaModificacion
		,ISNULL(FlagConsultora, 0) AS FlagConsultora
		,FlagMedio
		,(
			SELECT ISNULL(tld.Descripcion, '')
			FROM TablaLogicaDatos tld
			WHERE tld.tablalogicaid = 85
				AND tld.Codigo = flagmedio
			) AS MContacto
		,(
			SELECT SUM((Precio * Cantidad))
			FROM SolicitudClienteDetalle
			WHERE SolicitudClienteID = sc.SolicitudClienteID
			) AS PrecioTotal
		,m.Descripcion AS Marca
		,
		--case isnull(FlagConsultora,0)
		--	when 1 then '00:00:00'
		--	else dbo.CaclSaldoHorasSolicitudPedido(FechaSolicitud)
		--end SaldoHoras,
		ISNULL(PedidoWebID, 0) AS PedidoWebID
	FROM SolicitudCliente sc
	LEFT JOIN Marca m ON sc.MarcaID = m.MarcaID
	WHERE ConsultoraID = @ConsultoraId
		AND (
			sc.Estado IS NULL
			OR (
				LTRIM(RTRIM(sc.Estado)) IN ('A','R','C')
				)
			)
		--and ( sc.Estado IS NULL )	-- pendientes de aprobacaion
		AND IIF(ISNULL(sc.MarcaID, 0) = 0, @Campania, Campania) = Campania
		AND IIF(ISNULL(FlagConsultora, 0) = 1, 
			IIF(CAST(sc.FechaSolicitud AS DATE) 
				BETWEEN CAST(@FechaInicioFact AS DATE) AND CAST(@FechaFinFact AS DATE)
						,1
						,0), 1) = 1
	ORDER BY ISNULL(FlagConsultora, 0) DESC
		,ISNULL(sc.MarcaID, 0) ASC
		,FechaSolicitud ASC
		,PrecioTotal DESC;
END
GO

USE BelcorpEcuador
GO

ALTER PROCEDURE [dbo].[GetSolicitudesPedido_SB2] @ConsultoraId BIGINT
	,@Campania INT
AS
BEGIN
	DECLARE @RegionID INT
		,@ZonaID INT;
	DECLARE @FechaInicioFact DATETIME
		,@FechaFinFact DATETIME;

	SELECT @RegionID = RegionID
		,@ZonaID = ZonaID
	FROM ods.Consultora
	WHERE ConsultoraID = @ConsultoraId;

	SELECT TOP 1 @FechaInicioFact = FechaFinFacturacion
	FROM ods.Campania c
	INNER JOIN ods.Cronograma cc ON c.CampaniaID = cc.CampaniaID
	WHERE c.Codigo < @Campania
		AND RegionID = @RegionID
		AND ZonaID = @ZonaID
	ORDER BY c.CampaniaID DESC;

	SELECT TOP 1 @FechaFinFact = FechaFinFacturacion
	FROM ods.Campania c
	INNER JOIN ods.Cronograma cc ON c.CampaniaID = cc.CampaniaID
	WHERE c.Codigo = @Campania
		AND RegionID = @RegionID
		AND ZonaID = @ZonaID;

	SELECT SolicitudClienteID
		,sc.MarcaID
		,Campania
		,NombreCompleto
		,Telefono
		,Direccion
		,Email
		,Mensaje
		,Leido
		,ISNULL(Estado, '') AS Estado
		,NumIteracion
		,CodigoUbigeo
		,FechaSolicitud
		,FechaModificacion
		,ISNULL(FlagConsultora, 0) AS FlagConsultora
		,FlagMedio
		,(
			SELECT ISNULL(tld.Descripcion, '')
			FROM TablaLogicaDatos tld
			WHERE tld.tablalogicaid = 85
				AND tld.Codigo = flagmedio
			) AS MContacto
		,(
			SELECT SUM((Precio * Cantidad))
			FROM SolicitudClienteDetalle
			WHERE SolicitudClienteID = sc.SolicitudClienteID
			) AS PrecioTotal
		,m.Descripcion AS Marca
		,
		--case isnull(FlagConsultora,0)
		--	when 1 then '00:00:00'
		--	else dbo.CaclSaldoHorasSolicitudPedido(FechaSolicitud)
		--end SaldoHoras,
		ISNULL(PedidoWebID, 0) AS PedidoWebID
	FROM SolicitudCliente sc
	LEFT JOIN Marca m ON sc.MarcaID = m.MarcaID
	WHERE ConsultoraID = @ConsultoraId
		AND (
			sc.Estado IS NULL
			OR (
				LTRIM(RTRIM(sc.Estado)) IN ('A','R','C')
				)
			)
		--and ( sc.Estado IS NULL )	-- pendientes de aprobacaion
		AND IIF(ISNULL(sc.MarcaID, 0) = 0, @Campania, Campania) = Campania
		AND IIF(ISNULL(FlagConsultora, 0) = 1, 
			IIF(CAST(sc.FechaSolicitud AS DATE) 
				BETWEEN CAST(@FechaInicioFact AS DATE) AND CAST(@FechaFinFact AS DATE)
						,1
						,0), 1) = 1
	ORDER BY ISNULL(FlagConsultora, 0) DESC
		,ISNULL(sc.MarcaID, 0) ASC
		,FechaSolicitud ASC
		,PrecioTotal DESC;
END
GO

USE BelcorpGuatemala
GO

ALTER PROCEDURE [dbo].[GetSolicitudesPedido_SB2] @ConsultoraId BIGINT
	,@Campania INT
AS
BEGIN
	DECLARE @RegionID INT
		,@ZonaID INT;
	DECLARE @FechaInicioFact DATETIME
		,@FechaFinFact DATETIME;

	SELECT @RegionID = RegionID
		,@ZonaID = ZonaID
	FROM ods.Consultora
	WHERE ConsultoraID = @ConsultoraId;

	SELECT TOP 1 @FechaInicioFact = FechaFinFacturacion
	FROM ods.Campania c
	INNER JOIN ods.Cronograma cc ON c.CampaniaID = cc.CampaniaID
	WHERE c.Codigo < @Campania
		AND RegionID = @RegionID
		AND ZonaID = @ZonaID
	ORDER BY c.CampaniaID DESC;

	SELECT TOP 1 @FechaFinFact = FechaFinFacturacion
	FROM ods.Campania c
	INNER JOIN ods.Cronograma cc ON c.CampaniaID = cc.CampaniaID
	WHERE c.Codigo = @Campania
		AND RegionID = @RegionID
		AND ZonaID = @ZonaID;

	SELECT SolicitudClienteID
		,sc.MarcaID
		,Campania
		,NombreCompleto
		,Telefono
		,Direccion
		,Email
		,Mensaje
		,Leido
		,ISNULL(Estado, '') AS Estado
		,NumIteracion
		,CodigoUbigeo
		,FechaSolicitud
		,FechaModificacion
		,ISNULL(FlagConsultora, 0) AS FlagConsultora
		,FlagMedio
		,(
			SELECT ISNULL(tld.Descripcion, '')
			FROM TablaLogicaDatos tld
			WHERE tld.tablalogicaid = 85
				AND tld.Codigo = flagmedio
			) AS MContacto
		,(
			SELECT SUM((Precio * Cantidad))
			FROM SolicitudClienteDetalle
			WHERE SolicitudClienteID = sc.SolicitudClienteID
			) AS PrecioTotal
		,m.Descripcion AS Marca
		,
		--case isnull(FlagConsultora,0)
		--	when 1 then '00:00:00'
		--	else dbo.CaclSaldoHorasSolicitudPedido(FechaSolicitud)
		--end SaldoHoras,
		ISNULL(PedidoWebID, 0) AS PedidoWebID
	FROM SolicitudCliente sc
	LEFT JOIN Marca m ON sc.MarcaID = m.MarcaID
	WHERE ConsultoraID = @ConsultoraId
		AND (
			sc.Estado IS NULL
			OR (
				LTRIM(RTRIM(sc.Estado)) IN ('A','R','C')
				)
			)
		--and ( sc.Estado IS NULL )	-- pendientes de aprobacaion
		AND IIF(ISNULL(sc.MarcaID, 0) = 0, @Campania, Campania) = Campania
		AND IIF(ISNULL(FlagConsultora, 0) = 1, 
			IIF(CAST(sc.FechaSolicitud AS DATE) 
				BETWEEN CAST(@FechaInicioFact AS DATE) AND CAST(@FechaFinFact AS DATE)
						,1
						,0), 1) = 1
	ORDER BY ISNULL(FlagConsultora, 0) DESC
		,ISNULL(sc.MarcaID, 0) ASC
		,FechaSolicitud ASC
		,PrecioTotal DESC;
END
GO

USE BelcorpMexico
GO

ALTER PROCEDURE [dbo].[GetSolicitudesPedido_SB2] @ConsultoraId BIGINT
	,@Campania INT
AS
BEGIN
	DECLARE @RegionID INT
		,@ZonaID INT;
	DECLARE @FechaInicioFact DATETIME
		,@FechaFinFact DATETIME;

	SELECT @RegionID = RegionID
		,@ZonaID = ZonaID
	FROM ods.Consultora
	WHERE ConsultoraID = @ConsultoraId;

	SELECT TOP 1 @FechaInicioFact = FechaFinFacturacion
	FROM ods.Campania c
	INNER JOIN ods.Cronograma cc ON c.CampaniaID = cc.CampaniaID
	WHERE c.Codigo < @Campania
		AND RegionID = @RegionID
		AND ZonaID = @ZonaID
	ORDER BY c.CampaniaID DESC;

	SELECT TOP 1 @FechaFinFact = FechaFinFacturacion
	FROM ods.Campania c
	INNER JOIN ods.Cronograma cc ON c.CampaniaID = cc.CampaniaID
	WHERE c.Codigo = @Campania
		AND RegionID = @RegionID
		AND ZonaID = @ZonaID;

	SELECT SolicitudClienteID
		,sc.MarcaID
		,Campania
		,NombreCompleto
		,Telefono
		,Direccion
		,Email
		,Mensaje
		,Leido
		,ISNULL(Estado, '') AS Estado
		,NumIteracion
		,CodigoUbigeo
		,FechaSolicitud
		,FechaModificacion
		,ISNULL(FlagConsultora, 0) AS FlagConsultora
		,FlagMedio
		,(
			SELECT ISNULL(tld.Descripcion, '')
			FROM TablaLogicaDatos tld
			WHERE tld.tablalogicaid = 85
				AND tld.Codigo = flagmedio
			) AS MContacto
		,(
			SELECT SUM((Precio * Cantidad))
			FROM SolicitudClienteDetalle
			WHERE SolicitudClienteID = sc.SolicitudClienteID
			) AS PrecioTotal
		,m.Descripcion AS Marca
		,
		--case isnull(FlagConsultora,0)
		--	when 1 then '00:00:00'
		--	else dbo.CaclSaldoHorasSolicitudPedido(FechaSolicitud)
		--end SaldoHoras,
		ISNULL(PedidoWebID, 0) AS PedidoWebID
	FROM SolicitudCliente sc
	LEFT JOIN Marca m ON sc.MarcaID = m.MarcaID
	WHERE ConsultoraID = @ConsultoraId
		AND (
			sc.Estado IS NULL
			OR (
				LTRIM(RTRIM(sc.Estado)) IN ('A','R','C')
				)
			)
		--and ( sc.Estado IS NULL )	-- pendientes de aprobacaion
		AND IIF(ISNULL(sc.MarcaID, 0) = 0, @Campania, Campania) = Campania
		AND IIF(ISNULL(FlagConsultora, 0) = 1, 
			IIF(CAST(sc.FechaSolicitud AS DATE) 
				BETWEEN CAST(@FechaInicioFact AS DATE) AND CAST(@FechaFinFact AS DATE)
						,1
						,0), 1) = 1
	ORDER BY ISNULL(FlagConsultora, 0) DESC
		,ISNULL(sc.MarcaID, 0) ASC
		,FechaSolicitud ASC
		,PrecioTotal DESC;
END
GO

USE BelcorpPanama
GO

ALTER PROCEDURE [dbo].[GetSolicitudesPedido_SB2] @ConsultoraId BIGINT
	,@Campania INT
AS
BEGIN
	DECLARE @RegionID INT
		,@ZonaID INT;
	DECLARE @FechaInicioFact DATETIME
		,@FechaFinFact DATETIME;

	SELECT @RegionID = RegionID
		,@ZonaID = ZonaID
	FROM ods.Consultora
	WHERE ConsultoraID = @ConsultoraId;

	SELECT TOP 1 @FechaInicioFact = FechaFinFacturacion
	FROM ods.Campania c
	INNER JOIN ods.Cronograma cc ON c.CampaniaID = cc.CampaniaID
	WHERE c.Codigo < @Campania
		AND RegionID = @RegionID
		AND ZonaID = @ZonaID
	ORDER BY c.CampaniaID DESC;

	SELECT TOP 1 @FechaFinFact = FechaFinFacturacion
	FROM ods.Campania c
	INNER JOIN ods.Cronograma cc ON c.CampaniaID = cc.CampaniaID
	WHERE c.Codigo = @Campania
		AND RegionID = @RegionID
		AND ZonaID = @ZonaID;

	SELECT SolicitudClienteID
		,sc.MarcaID
		,Campania
		,NombreCompleto
		,Telefono
		,Direccion
		,Email
		,Mensaje
		,Leido
		,ISNULL(Estado, '') AS Estado
		,NumIteracion
		,CodigoUbigeo
		,FechaSolicitud
		,FechaModificacion
		,ISNULL(FlagConsultora, 0) AS FlagConsultora
		,FlagMedio
		,(
			SELECT ISNULL(tld.Descripcion, '')
			FROM TablaLogicaDatos tld
			WHERE tld.tablalogicaid = 85
				AND tld.Codigo = flagmedio
			) AS MContacto
		,(
			SELECT SUM((Precio * Cantidad))
			FROM SolicitudClienteDetalle
			WHERE SolicitudClienteID = sc.SolicitudClienteID
			) AS PrecioTotal
		,m.Descripcion AS Marca
		,
		--case isnull(FlagConsultora,0)
		--	when 1 then '00:00:00'
		--	else dbo.CaclSaldoHorasSolicitudPedido(FechaSolicitud)
		--end SaldoHoras,
		ISNULL(PedidoWebID, 0) AS PedidoWebID
	FROM SolicitudCliente sc
	LEFT JOIN Marca m ON sc.MarcaID = m.MarcaID
	WHERE ConsultoraID = @ConsultoraId
		AND (
			sc.Estado IS NULL
			OR (
				LTRIM(RTRIM(sc.Estado)) IN ('A','R','C')
				)
			)
		--and ( sc.Estado IS NULL )	-- pendientes de aprobacaion
		AND IIF(ISNULL(sc.MarcaID, 0) = 0, @Campania, Campania) = Campania
		AND IIF(ISNULL(FlagConsultora, 0) = 1, 
			IIF(CAST(sc.FechaSolicitud AS DATE) 
				BETWEEN CAST(@FechaInicioFact AS DATE) AND CAST(@FechaFinFact AS DATE)
						,1
						,0), 1) = 1
	ORDER BY ISNULL(FlagConsultora, 0) DESC
		,ISNULL(sc.MarcaID, 0) ASC
		,FechaSolicitud ASC
		,PrecioTotal DESC;
END
GO

USE BelcorpPeru
GO

ALTER PROCEDURE [dbo].[GetSolicitudesPedido_SB2] @ConsultoraId BIGINT
	,@Campania INT
AS
BEGIN
	DECLARE @RegionID INT
		,@ZonaID INT;
	DECLARE @FechaInicioFact DATETIME
		,@FechaFinFact DATETIME;

	SELECT @RegionID = RegionID
		,@ZonaID = ZonaID
	FROM ods.Consultora
	WHERE ConsultoraID = @ConsultoraId;

	SELECT TOP 1 @FechaInicioFact = FechaFinFacturacion
	FROM ods.Campania c
	INNER JOIN ods.Cronograma cc ON c.CampaniaID = cc.CampaniaID
	WHERE c.Codigo < @Campania
		AND RegionID = @RegionID
		AND ZonaID = @ZonaID
	ORDER BY c.CampaniaID DESC;

	SELECT TOP 1 @FechaFinFact = FechaFinFacturacion
	FROM ods.Campania c
	INNER JOIN ods.Cronograma cc ON c.CampaniaID = cc.CampaniaID
	WHERE c.Codigo = @Campania
		AND RegionID = @RegionID
		AND ZonaID = @ZonaID;

	SELECT SolicitudClienteID
		,sc.MarcaID
		,Campania
		,NombreCompleto
		,Telefono
		,Direccion
		,Email
		,Mensaje
		,Leido
		,ISNULL(Estado, '') AS Estado
		,NumIteracion
		,CodigoUbigeo
		,FechaSolicitud
		,FechaModificacion
		,ISNULL(FlagConsultora, 0) AS FlagConsultora
		,FlagMedio
		,(
			SELECT ISNULL(tld.Descripcion, '')
			FROM TablaLogicaDatos tld
			WHERE tld.tablalogicaid = 85
				AND tld.Codigo = flagmedio
			) AS MContacto
		,(
			SELECT SUM((Precio * Cantidad))
			FROM SolicitudClienteDetalle
			WHERE SolicitudClienteID = sc.SolicitudClienteID
			) AS PrecioTotal
		,m.Descripcion AS Marca
		,
		--case isnull(FlagConsultora,0)
		--	when 1 then '00:00:00'
		--	else dbo.CaclSaldoHorasSolicitudPedido(FechaSolicitud)
		--end SaldoHoras,
		ISNULL(PedidoWebID, 0) AS PedidoWebID
	FROM SolicitudCliente sc
	LEFT JOIN Marca m ON sc.MarcaID = m.MarcaID
	WHERE ConsultoraID = @ConsultoraId
		AND (
			sc.Estado IS NULL
			OR (
				LTRIM(RTRIM(sc.Estado)) IN ('A','R','C')
				)
			)
		--and ( sc.Estado IS NULL )	-- pendientes de aprobacaion
		AND IIF(ISNULL(sc.MarcaID, 0) = 0, @Campania, Campania) = Campania
		AND IIF(ISNULL(FlagConsultora, 0) = 1, 
			IIF(CAST(sc.FechaSolicitud AS DATE) 
				BETWEEN CAST(@FechaInicioFact AS DATE) AND CAST(@FechaFinFact AS DATE)
						,1
						,0), 1) = 1
	ORDER BY ISNULL(FlagConsultora, 0) DESC
		,ISNULL(sc.MarcaID, 0) ASC
		,FechaSolicitud ASC
		,PrecioTotal DESC;
END
GO

USE BelcorpPuertoRico
GO

ALTER PROCEDURE [dbo].[GetSolicitudesPedido_SB2] @ConsultoraId BIGINT
	,@Campania INT
AS
BEGIN
	DECLARE @RegionID INT
		,@ZonaID INT;
	DECLARE @FechaInicioFact DATETIME
		,@FechaFinFact DATETIME;

	SELECT @RegionID = RegionID
		,@ZonaID = ZonaID
	FROM ods.Consultora
	WHERE ConsultoraID = @ConsultoraId;

	SELECT TOP 1 @FechaInicioFact = FechaFinFacturacion
	FROM ods.Campania c
	INNER JOIN ods.Cronograma cc ON c.CampaniaID = cc.CampaniaID
	WHERE c.Codigo < @Campania
		AND RegionID = @RegionID
		AND ZonaID = @ZonaID
	ORDER BY c.CampaniaID DESC;

	SELECT TOP 1 @FechaFinFact = FechaFinFacturacion
	FROM ods.Campania c
	INNER JOIN ods.Cronograma cc ON c.CampaniaID = cc.CampaniaID
	WHERE c.Codigo = @Campania
		AND RegionID = @RegionID
		AND ZonaID = @ZonaID;

	SELECT SolicitudClienteID
		,sc.MarcaID
		,Campania
		,NombreCompleto
		,Telefono
		,Direccion
		,Email
		,Mensaje
		,Leido
		,ISNULL(Estado, '') AS Estado
		,NumIteracion
		,CodigoUbigeo
		,FechaSolicitud
		,FechaModificacion
		,ISNULL(FlagConsultora, 0) AS FlagConsultora
		,FlagMedio
		,(
			SELECT ISNULL(tld.Descripcion, '')
			FROM TablaLogicaDatos tld
			WHERE tld.tablalogicaid = 85
				AND tld.Codigo = flagmedio
			) AS MContacto
		,(
			SELECT SUM((Precio * Cantidad))
			FROM SolicitudClienteDetalle
			WHERE SolicitudClienteID = sc.SolicitudClienteID
			) AS PrecioTotal
		,m.Descripcion AS Marca
		,
		--case isnull(FlagConsultora,0)
		--	when 1 then '00:00:00'
		--	else dbo.CaclSaldoHorasSolicitudPedido(FechaSolicitud)
		--end SaldoHoras,
		ISNULL(PedidoWebID, 0) AS PedidoWebID
	FROM SolicitudCliente sc
	LEFT JOIN Marca m ON sc.MarcaID = m.MarcaID
	WHERE ConsultoraID = @ConsultoraId
		AND (
			sc.Estado IS NULL
			OR (
				LTRIM(RTRIM(sc.Estado)) IN ('A','R','C')
				)
			)
		--and ( sc.Estado IS NULL )	-- pendientes de aprobacaion
		AND IIF(ISNULL(sc.MarcaID, 0) = 0, @Campania, Campania) = Campania
		AND IIF(ISNULL(FlagConsultora, 0) = 1, 
			IIF(CAST(sc.FechaSolicitud AS DATE) 
				BETWEEN CAST(@FechaInicioFact AS DATE) AND CAST(@FechaFinFact AS DATE)
						,1
						,0), 1) = 1
	ORDER BY ISNULL(FlagConsultora, 0) DESC
		,ISNULL(sc.MarcaID, 0) ASC
		,FechaSolicitud ASC
		,PrecioTotal DESC;
END
GO

USE BelcorpSalvador
GO

ALTER PROCEDURE [dbo].[GetSolicitudesPedido_SB2] @ConsultoraId BIGINT
	,@Campania INT
AS
BEGIN
	DECLARE @RegionID INT
		,@ZonaID INT;
	DECLARE @FechaInicioFact DATETIME
		,@FechaFinFact DATETIME;

	SELECT @RegionID = RegionID
		,@ZonaID = ZonaID
	FROM ods.Consultora
	WHERE ConsultoraID = @ConsultoraId;

	SELECT TOP 1 @FechaInicioFact = FechaFinFacturacion
	FROM ods.Campania c
	INNER JOIN ods.Cronograma cc ON c.CampaniaID = cc.CampaniaID
	WHERE c.Codigo < @Campania
		AND RegionID = @RegionID
		AND ZonaID = @ZonaID
	ORDER BY c.CampaniaID DESC;

	SELECT TOP 1 @FechaFinFact = FechaFinFacturacion
	FROM ods.Campania c
	INNER JOIN ods.Cronograma cc ON c.CampaniaID = cc.CampaniaID
	WHERE c.Codigo = @Campania
		AND RegionID = @RegionID
		AND ZonaID = @ZonaID;

	SELECT SolicitudClienteID
		,sc.MarcaID
		,Campania
		,NombreCompleto
		,Telefono
		,Direccion
		,Email
		,Mensaje
		,Leido
		,ISNULL(Estado, '') AS Estado
		,NumIteracion
		,CodigoUbigeo
		,FechaSolicitud
		,FechaModificacion
		,ISNULL(FlagConsultora, 0) AS FlagConsultora
		,FlagMedio
		,(
			SELECT ISNULL(tld.Descripcion, '')
			FROM TablaLogicaDatos tld
			WHERE tld.tablalogicaid = 85
				AND tld.Codigo = flagmedio
			) AS MContacto
		,(
			SELECT SUM((Precio * Cantidad))
			FROM SolicitudClienteDetalle
			WHERE SolicitudClienteID = sc.SolicitudClienteID
			) AS PrecioTotal
		,m.Descripcion AS Marca
		,
		--case isnull(FlagConsultora,0)
		--	when 1 then '00:00:00'
		--	else dbo.CaclSaldoHorasSolicitudPedido(FechaSolicitud)
		--end SaldoHoras,
		ISNULL(PedidoWebID, 0) AS PedidoWebID
	FROM SolicitudCliente sc
	LEFT JOIN Marca m ON sc.MarcaID = m.MarcaID
	WHERE ConsultoraID = @ConsultoraId
		AND (
			sc.Estado IS NULL
			OR (
				LTRIM(RTRIM(sc.Estado)) IN ('A','R','C')
				)
			)
		--and ( sc.Estado IS NULL )	-- pendientes de aprobacaion
		AND IIF(ISNULL(sc.MarcaID, 0) = 0, @Campania, Campania) = Campania
		AND IIF(ISNULL(FlagConsultora, 0) = 1, 
			IIF(CAST(sc.FechaSolicitud AS DATE) 
				BETWEEN CAST(@FechaInicioFact AS DATE) AND CAST(@FechaFinFact AS DATE)
						,1
						,0), 1) = 1
	ORDER BY ISNULL(FlagConsultora, 0) DESC
		,ISNULL(sc.MarcaID, 0) ASC
		,FechaSolicitud ASC
		,PrecioTotal DESC;
END
GO
