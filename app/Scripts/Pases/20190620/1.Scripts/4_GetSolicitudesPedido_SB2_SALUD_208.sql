USE BelcorpBolivia
GO
ALTER procedure dbo.GetSolicitudesPedido_SB2
-- exec GetSolicitudesPedido_SB2 17283, 201907
	@ConsultoraId bigint,
	@Campania int
as
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

	select
		SolicitudClienteID,
		sc.MarcaID,
		Campania,
		NombreCompleto,
		Telefono,
		Direccion,
		Email,
		Mensaje,
		Leido,
	    isnull(Estado,'') as Estado,
		NumIteracion,
		CodigoUbigeo,
		FechaSolicitud,
		FechaModificacion,
		--case
		--	when exists(SELECT 1 FROM dbo.Cliente a WHERE ConsultoraID = @ConsultoraId AND a.Nombre = sc.NombreCompleto AND a.Activo = 1) then 1
		--	else 0
		--end FlagConsultora,
		FlagMedio,
		(select isnull(tld.Descripcion,'') from TablaLogicaDatos tld where tld.tablalogicaid = 85 AND tld.Codigo = flagmedio) as MContacto ,
		(select sum((Precio*Cantidad)) from SolicitudClienteDetalle where SolicitudClienteID = sc.SolicitudClienteID) as PrecioTotal,
		m.Descripcion as Marca,
		--case isnull(FlagConsultora,0)
		--	when 1 then '00:00:00'
		--	else dbo.CaclSaldoHorasSolicitudPedido(FechaSolicitud)
		--end SaldoHoras,
		isnull(PedidoWebID,0) as PedidoWebID
	from SolicitudCliente sc left join Marca m on sc.MarcaID = m.MarcaID
	where
		ConsultoraID = @ConsultoraId
		AND
		( sc.Estado IS NULL or (LTRIM(RTRIM(sc.Estado)) IN ('A','R','C')))
		--and ( sc.Estado IS NULL )	-- pendientes de aprobacaion
		AND
		IIF(ISNULL(sc.MarcaID,0) = 0, @Campania, Campania) = Campania
		AND
		IIF(
			ISNULL(FlagConsultora,0) = 1,
			IIF(cast(sc.FechaSolicitud AS DATE) BETWEEN CAST(@FechaInicioFact AS DATE) AND CAST(@FechaFinFact AS DATE), 1, 0),
			1
		) = 1
	ORDER BY
		ISNULL(FlagConsultora,0) DESC,
		ISNULL(sc.MarcaID,0) ASC,
		FechaSolicitud ASC,
		PrecioTotal DESC;
END
GO

USE BelcorpChile
GO
ALTER procedure dbo.GetSolicitudesPedido_SB2
-- exec GetSolicitudesPedido_SB2 17283, 201907
	@ConsultoraId bigint,
	@Campania int
as
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

	select
		SolicitudClienteID,
		sc.MarcaID,
		Campania,
		NombreCompleto,
		Telefono,
		Direccion,
		Email,
		Mensaje,
		Leido,
	    isnull(Estado,'') as Estado,
		NumIteracion,
		CodigoUbigeo,
		FechaSolicitud,
		FechaModificacion,
		--case
		--	when exists(SELECT 1 FROM dbo.Cliente a WHERE ConsultoraID = @ConsultoraId AND a.Nombre = sc.NombreCompleto AND a.Activo = 1) then 1
		--	else 0
		--end FlagConsultora,
		FlagMedio,
		(select isnull(tld.Descripcion,'') from TablaLogicaDatos tld where tld.tablalogicaid = 85 AND tld.Codigo = flagmedio) as MContacto ,
		(select sum((Precio*Cantidad)) from SolicitudClienteDetalle where SolicitudClienteID = sc.SolicitudClienteID) as PrecioTotal,
		m.Descripcion as Marca,
		--case isnull(FlagConsultora,0)
		--	when 1 then '00:00:00'
		--	else dbo.CaclSaldoHorasSolicitudPedido(FechaSolicitud)
		--end SaldoHoras,
		isnull(PedidoWebID,0) as PedidoWebID
	from SolicitudCliente sc left join Marca m on sc.MarcaID = m.MarcaID
	where
		ConsultoraID = @ConsultoraId
		AND
		( sc.Estado IS NULL or (LTRIM(RTRIM(sc.Estado)) IN ('A','R','C')))
		--and ( sc.Estado IS NULL )	-- pendientes de aprobacaion
		AND
		IIF(ISNULL(sc.MarcaID,0) = 0, @Campania, Campania) = Campania
		AND
		IIF(
			ISNULL(FlagConsultora,0) = 1,
			IIF(cast(sc.FechaSolicitud AS DATE) BETWEEN CAST(@FechaInicioFact AS DATE) AND CAST(@FechaFinFact AS DATE), 1, 0),
			1
		) = 1
	ORDER BY
		ISNULL(FlagConsultora,0) DESC,
		ISNULL(sc.MarcaID,0) ASC,
		FechaSolicitud ASC,
		PrecioTotal DESC;
END
GO

USE BelcorpColombia
GO
ALTER procedure dbo.GetSolicitudesPedido_SB2
-- exec GetSolicitudesPedido_SB2 17283, 201907
	@ConsultoraId bigint,
	@Campania int
as
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

	select
		SolicitudClienteID,
		sc.MarcaID,
		Campania,
		NombreCompleto,
		Telefono,
		Direccion,
		Email,
		Mensaje,
		Leido,
	    isnull(Estado,'') as Estado,
		NumIteracion,
		CodigoUbigeo,
		FechaSolicitud,
		FechaModificacion,
		--case
		--	when exists(SELECT 1 FROM dbo.Cliente a WHERE ConsultoraID = @ConsultoraId AND a.Nombre = sc.NombreCompleto AND a.Activo = 1) then 1
		--	else 0
		--end FlagConsultora,
		FlagMedio,
		(select isnull(tld.Descripcion,'') from TablaLogicaDatos tld where tld.tablalogicaid = 85 AND tld.Codigo = flagmedio) as MContacto ,
		(select sum((Precio*Cantidad)) from SolicitudClienteDetalle where SolicitudClienteID = sc.SolicitudClienteID) as PrecioTotal,
		m.Descripcion as Marca,
		--case isnull(FlagConsultora,0)
		--	when 1 then '00:00:00'
		--	else dbo.CaclSaldoHorasSolicitudPedido(FechaSolicitud)
		--end SaldoHoras,
		isnull(PedidoWebID,0) as PedidoWebID
	from SolicitudCliente sc left join Marca m on sc.MarcaID = m.MarcaID
	where
		ConsultoraID = @ConsultoraId
		AND
		( sc.Estado IS NULL or (LTRIM(RTRIM(sc.Estado)) IN ('A','R','C')))
		--and ( sc.Estado IS NULL )	-- pendientes de aprobacaion
		AND
		IIF(ISNULL(sc.MarcaID,0) = 0, @Campania, Campania) = Campania
		AND
		IIF(
			ISNULL(FlagConsultora,0) = 1,
			IIF(cast(sc.FechaSolicitud AS DATE) BETWEEN CAST(@FechaInicioFact AS DATE) AND CAST(@FechaFinFact AS DATE), 1, 0),
			1
		) = 1
	ORDER BY
		ISNULL(FlagConsultora,0) DESC,
		ISNULL(sc.MarcaID,0) ASC,
		FechaSolicitud ASC,
		PrecioTotal DESC;
END
GO

USE BelcorpCostaRica
GO
ALTER procedure dbo.GetSolicitudesPedido_SB2
-- exec GetSolicitudesPedido_SB2 17283, 201907
	@ConsultoraId bigint,
	@Campania int
as
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

	select
		SolicitudClienteID,
		sc.MarcaID,
		Campania,
		NombreCompleto,
		Telefono,
		Direccion,
		Email,
		Mensaje,
		Leido,
	    isnull(Estado,'') as Estado,
		NumIteracion,
		CodigoUbigeo,
		FechaSolicitud,
		FechaModificacion,
		--case
		--	when exists(SELECT 1 FROM dbo.Cliente a WHERE ConsultoraID = @ConsultoraId AND a.Nombre = sc.NombreCompleto AND a.Activo = 1) then 1
		--	else 0
		--end FlagConsultora,
		FlagMedio,
		(select isnull(tld.Descripcion,'') from TablaLogicaDatos tld where tld.tablalogicaid = 85 AND tld.Codigo = flagmedio) as MContacto ,
		(select sum((Precio*Cantidad)) from SolicitudClienteDetalle where SolicitudClienteID = sc.SolicitudClienteID) as PrecioTotal,
		m.Descripcion as Marca,
		--case isnull(FlagConsultora,0)
		--	when 1 then '00:00:00'
		--	else dbo.CaclSaldoHorasSolicitudPedido(FechaSolicitud)
		--end SaldoHoras,
		isnull(PedidoWebID,0) as PedidoWebID
	from SolicitudCliente sc left join Marca m on sc.MarcaID = m.MarcaID
	where
		ConsultoraID = @ConsultoraId
		AND
		( sc.Estado IS NULL or (LTRIM(RTRIM(sc.Estado)) IN ('A','R','C')))
		--and ( sc.Estado IS NULL )	-- pendientes de aprobacaion
		AND
		IIF(ISNULL(sc.MarcaID,0) = 0, @Campania, Campania) = Campania
		AND
		IIF(
			ISNULL(FlagConsultora,0) = 1,
			IIF(cast(sc.FechaSolicitud AS DATE) BETWEEN CAST(@FechaInicioFact AS DATE) AND CAST(@FechaFinFact AS DATE), 1, 0),
			1
		) = 1
	ORDER BY
		ISNULL(FlagConsultora,0) DESC,
		ISNULL(sc.MarcaID,0) ASC,
		FechaSolicitud ASC,
		PrecioTotal DESC;
END
GO

USE BelcorpDominicana
GO
ALTER procedure dbo.GetSolicitudesPedido_SB2
-- exec GetSolicitudesPedido_SB2 17283, 201907
	@ConsultoraId bigint,
	@Campania int
as
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

	select
		SolicitudClienteID,
		sc.MarcaID,
		Campania,
		NombreCompleto,
		Telefono,
		Direccion,
		Email,
		Mensaje,
		Leido,
	    isnull(Estado,'') as Estado,
		NumIteracion,
		CodigoUbigeo,
		FechaSolicitud,
		FechaModificacion,
		--case
		--	when exists(SELECT 1 FROM dbo.Cliente a WHERE ConsultoraID = @ConsultoraId AND a.Nombre = sc.NombreCompleto AND a.Activo = 1) then 1
		--	else 0
		--end FlagConsultora,
		FlagMedio,
		(select isnull(tld.Descripcion,'') from TablaLogicaDatos tld where tld.tablalogicaid = 85 AND tld.Codigo = flagmedio) as MContacto ,
		(select sum((Precio*Cantidad)) from SolicitudClienteDetalle where SolicitudClienteID = sc.SolicitudClienteID) as PrecioTotal,
		m.Descripcion as Marca,
		--case isnull(FlagConsultora,0)
		--	when 1 then '00:00:00'
		--	else dbo.CaclSaldoHorasSolicitudPedido(FechaSolicitud)
		--end SaldoHoras,
		isnull(PedidoWebID,0) as PedidoWebID
	from SolicitudCliente sc left join Marca m on sc.MarcaID = m.MarcaID
	where
		ConsultoraID = @ConsultoraId
		AND
		( sc.Estado IS NULL or (LTRIM(RTRIM(sc.Estado)) IN ('A','R','C')))
		--and ( sc.Estado IS NULL )	-- pendientes de aprobacaion
		AND
		IIF(ISNULL(sc.MarcaID,0) = 0, @Campania, Campania) = Campania
		AND
		IIF(
			ISNULL(FlagConsultora,0) = 1,
			IIF(cast(sc.FechaSolicitud AS DATE) BETWEEN CAST(@FechaInicioFact AS DATE) AND CAST(@FechaFinFact AS DATE), 1, 0),
			1
		) = 1
	ORDER BY
		ISNULL(FlagConsultora,0) DESC,
		ISNULL(sc.MarcaID,0) ASC,
		FechaSolicitud ASC,
		PrecioTotal DESC;
END
GO

USE BelcorpEcuador
GO
ALTER procedure dbo.GetSolicitudesPedido_SB2
-- exec GetSolicitudesPedido_SB2 17283, 201907
	@ConsultoraId bigint,
	@Campania int
as
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

	select
		SolicitudClienteID,
		sc.MarcaID,
		Campania,
		NombreCompleto,
		Telefono,
		Direccion,
		Email,
		Mensaje,
		Leido,
	    isnull(Estado,'') as Estado,
		NumIteracion,
		CodigoUbigeo,
		FechaSolicitud,
		FechaModificacion,
		--case
		--	when exists(SELECT 1 FROM dbo.Cliente a WHERE ConsultoraID = @ConsultoraId AND a.Nombre = sc.NombreCompleto AND a.Activo = 1) then 1
		--	else 0
		--end FlagConsultora,
		FlagMedio,
		(select isnull(tld.Descripcion,'') from TablaLogicaDatos tld where tld.tablalogicaid = 85 AND tld.Codigo = flagmedio) as MContacto ,
		(select sum((Precio*Cantidad)) from SolicitudClienteDetalle where SolicitudClienteID = sc.SolicitudClienteID) as PrecioTotal,
		m.Descripcion as Marca,
		--case isnull(FlagConsultora,0)
		--	when 1 then '00:00:00'
		--	else dbo.CaclSaldoHorasSolicitudPedido(FechaSolicitud)
		--end SaldoHoras,
		isnull(PedidoWebID,0) as PedidoWebID
	from SolicitudCliente sc left join Marca m on sc.MarcaID = m.MarcaID
	where
		ConsultoraID = @ConsultoraId
		AND
		( sc.Estado IS NULL or (LTRIM(RTRIM(sc.Estado)) IN ('A','R','C')))
		--and ( sc.Estado IS NULL )	-- pendientes de aprobacaion
		AND
		IIF(ISNULL(sc.MarcaID,0) = 0, @Campania, Campania) = Campania
		AND
		IIF(
			ISNULL(FlagConsultora,0) = 1,
			IIF(cast(sc.FechaSolicitud AS DATE) BETWEEN CAST(@FechaInicioFact AS DATE) AND CAST(@FechaFinFact AS DATE), 1, 0),
			1
		) = 1
	ORDER BY
		ISNULL(FlagConsultora,0) DESC,
		ISNULL(sc.MarcaID,0) ASC,
		FechaSolicitud ASC,
		PrecioTotal DESC;
END
GO

USE BelcorpGuatemala
GO
ALTER procedure dbo.GetSolicitudesPedido_SB2
-- exec GetSolicitudesPedido_SB2 17283, 201907
	@ConsultoraId bigint,
	@Campania int
as
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

	select
		SolicitudClienteID,
		sc.MarcaID,
		Campania,
		NombreCompleto,
		Telefono,
		Direccion,
		Email,
		Mensaje,
		Leido,
	    isnull(Estado,'') as Estado,
		NumIteracion,
		CodigoUbigeo,
		FechaSolicitud,
		FechaModificacion,
		--case
		--	when exists(SELECT 1 FROM dbo.Cliente a WHERE ConsultoraID = @ConsultoraId AND a.Nombre = sc.NombreCompleto AND a.Activo = 1) then 1
		--	else 0
		--end FlagConsultora,
		FlagMedio,
		(select isnull(tld.Descripcion,'') from TablaLogicaDatos tld where tld.tablalogicaid = 85 AND tld.Codigo = flagmedio) as MContacto ,
		(select sum((Precio*Cantidad)) from SolicitudClienteDetalle where SolicitudClienteID = sc.SolicitudClienteID) as PrecioTotal,
		m.Descripcion as Marca,
		--case isnull(FlagConsultora,0)
		--	when 1 then '00:00:00'
		--	else dbo.CaclSaldoHorasSolicitudPedido(FechaSolicitud)
		--end SaldoHoras,
		isnull(PedidoWebID,0) as PedidoWebID
	from SolicitudCliente sc left join Marca m on sc.MarcaID = m.MarcaID
	where
		ConsultoraID = @ConsultoraId
		AND
		( sc.Estado IS NULL or (LTRIM(RTRIM(sc.Estado)) IN ('A','R','C')))
		--and ( sc.Estado IS NULL )	-- pendientes de aprobacaion
		AND
		IIF(ISNULL(sc.MarcaID,0) = 0, @Campania, Campania) = Campania
		AND
		IIF(
			ISNULL(FlagConsultora,0) = 1,
			IIF(cast(sc.FechaSolicitud AS DATE) BETWEEN CAST(@FechaInicioFact AS DATE) AND CAST(@FechaFinFact AS DATE), 1, 0),
			1
		) = 1
	ORDER BY
		ISNULL(FlagConsultora,0) DESC,
		ISNULL(sc.MarcaID,0) ASC,
		FechaSolicitud ASC,
		PrecioTotal DESC;
END
GO

USE BelcorpMexico
GO
ALTER procedure dbo.GetSolicitudesPedido_SB2
-- exec GetSolicitudesPedido_SB2 17283, 201907
	@ConsultoraId bigint,
	@Campania int
as
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

	select
		SolicitudClienteID,
		sc.MarcaID,
		Campania,
		NombreCompleto,
		Telefono,
		Direccion,
		Email,
		Mensaje,
		Leido,
	    isnull(Estado,'') as Estado,
		NumIteracion,
		CodigoUbigeo,
		FechaSolicitud,
		FechaModificacion,
		--case
		--	when exists(SELECT 1 FROM dbo.Cliente a WHERE ConsultoraID = @ConsultoraId AND a.Nombre = sc.NombreCompleto AND a.Activo = 1) then 1
		--	else 0
		--end FlagConsultora,
		FlagMedio,
		(select isnull(tld.Descripcion,'') from TablaLogicaDatos tld where tld.tablalogicaid = 85 AND tld.Codigo = flagmedio) as MContacto ,
		(select sum((Precio*Cantidad)) from SolicitudClienteDetalle where SolicitudClienteID = sc.SolicitudClienteID) as PrecioTotal,
		m.Descripcion as Marca,
		--case isnull(FlagConsultora,0)
		--	when 1 then '00:00:00'
		--	else dbo.CaclSaldoHorasSolicitudPedido(FechaSolicitud)
		--end SaldoHoras,
		isnull(PedidoWebID,0) as PedidoWebID
	from SolicitudCliente sc left join Marca m on sc.MarcaID = m.MarcaID
	where
		ConsultoraID = @ConsultoraId
		AND
		( sc.Estado IS NULL or (LTRIM(RTRIM(sc.Estado)) IN ('A','R','C')))
		--and ( sc.Estado IS NULL )	-- pendientes de aprobacaion
		AND
		IIF(ISNULL(sc.MarcaID,0) = 0, @Campania, Campania) = Campania
		AND
		IIF(
			ISNULL(FlagConsultora,0) = 1,
			IIF(cast(sc.FechaSolicitud AS DATE) BETWEEN CAST(@FechaInicioFact AS DATE) AND CAST(@FechaFinFact AS DATE), 1, 0),
			1
		) = 1
	ORDER BY
		ISNULL(FlagConsultora,0) DESC,
		ISNULL(sc.MarcaID,0) ASC,
		FechaSolicitud ASC,
		PrecioTotal DESC;
END
GO

USE BelcorpPanama
GO
ALTER procedure dbo.GetSolicitudesPedido_SB2
-- exec GetSolicitudesPedido_SB2 17283, 201907
	@ConsultoraId bigint,
	@Campania int
as
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

	select
		SolicitudClienteID,
		sc.MarcaID,
		Campania,
		NombreCompleto,
		Telefono,
		Direccion,
		Email,
		Mensaje,
		Leido,
	    isnull(Estado,'') as Estado,
		NumIteracion,
		CodigoUbigeo,
		FechaSolicitud,
		FechaModificacion,
		--case
		--	when exists(SELECT 1 FROM dbo.Cliente a WHERE ConsultoraID = @ConsultoraId AND a.Nombre = sc.NombreCompleto AND a.Activo = 1) then 1
		--	else 0
		--end FlagConsultora,
		FlagMedio,
		(select isnull(tld.Descripcion,'') from TablaLogicaDatos tld where tld.tablalogicaid = 85 AND tld.Codigo = flagmedio) as MContacto ,
		(select sum((Precio*Cantidad)) from SolicitudClienteDetalle where SolicitudClienteID = sc.SolicitudClienteID) as PrecioTotal,
		m.Descripcion as Marca,
		--case isnull(FlagConsultora,0)
		--	when 1 then '00:00:00'
		--	else dbo.CaclSaldoHorasSolicitudPedido(FechaSolicitud)
		--end SaldoHoras,
		isnull(PedidoWebID,0) as PedidoWebID
	from SolicitudCliente sc left join Marca m on sc.MarcaID = m.MarcaID
	where
		ConsultoraID = @ConsultoraId
		AND
		( sc.Estado IS NULL or (LTRIM(RTRIM(sc.Estado)) IN ('A','R','C')))
		--and ( sc.Estado IS NULL )	-- pendientes de aprobacaion
		AND
		IIF(ISNULL(sc.MarcaID,0) = 0, @Campania, Campania) = Campania
		AND
		IIF(
			ISNULL(FlagConsultora,0) = 1,
			IIF(cast(sc.FechaSolicitud AS DATE) BETWEEN CAST(@FechaInicioFact AS DATE) AND CAST(@FechaFinFact AS DATE), 1, 0),
			1
		) = 1
	ORDER BY
		ISNULL(FlagConsultora,0) DESC,
		ISNULL(sc.MarcaID,0) ASC,
		FechaSolicitud ASC,
		PrecioTotal DESC;
END
GO

USE BelcorpPeru
GO
ALTER procedure dbo.GetSolicitudesPedido_SB2
-- exec GetSolicitudesPedido_SB2 17283, 201907
	@ConsultoraId bigint,
	@Campania int
as
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

	select
		SolicitudClienteID,
		sc.MarcaID,
		Campania,
		NombreCompleto,
		Telefono,
		Direccion,
		Email,
		Mensaje,
		Leido,
	    isnull(Estado,'') as Estado,
		NumIteracion,
		CodigoUbigeo,
		FechaSolicitud,
		FechaModificacion,
		--case
		--	when exists(SELECT 1 FROM dbo.Cliente a WHERE ConsultoraID = @ConsultoraId AND a.Nombre = sc.NombreCompleto AND a.Activo = 1) then 1
		--	else 0
		--end FlagConsultora,
		FlagMedio,
		(select isnull(tld.Descripcion,'') from TablaLogicaDatos tld where tld.tablalogicaid = 85 AND tld.Codigo = flagmedio) as MContacto ,
		(select sum((Precio*Cantidad)) from SolicitudClienteDetalle where SolicitudClienteID = sc.SolicitudClienteID) as PrecioTotal,
		m.Descripcion as Marca,
		--case isnull(FlagConsultora,0)
		--	when 1 then '00:00:00'
		--	else dbo.CaclSaldoHorasSolicitudPedido(FechaSolicitud)
		--end SaldoHoras,
		isnull(PedidoWebID,0) as PedidoWebID
	from SolicitudCliente sc left join Marca m on sc.MarcaID = m.MarcaID
	where
		ConsultoraID = @ConsultoraId
		AND
		( sc.Estado IS NULL or (LTRIM(RTRIM(sc.Estado)) IN ('A','R','C')))
		--and ( sc.Estado IS NULL )	-- pendientes de aprobacaion
		AND
		IIF(ISNULL(sc.MarcaID,0) = 0, @Campania, Campania) = Campania
		AND
		IIF(
			ISNULL(FlagConsultora,0) = 1,
			IIF(cast(sc.FechaSolicitud AS DATE) BETWEEN CAST(@FechaInicioFact AS DATE) AND CAST(@FechaFinFact AS DATE), 1, 0),
			1
		) = 1
	ORDER BY
		ISNULL(FlagConsultora,0) DESC,
		ISNULL(sc.MarcaID,0) ASC,
		FechaSolicitud ASC,
		PrecioTotal DESC;
END
GO

USE BelcorpPuertoRico
GO
ALTER procedure dbo.GetSolicitudesPedido_SB2
-- exec GetSolicitudesPedido_SB2 17283, 201907
	@ConsultoraId bigint,
	@Campania int
as
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

	select
		SolicitudClienteID,
		sc.MarcaID,
		Campania,
		NombreCompleto,
		Telefono,
		Direccion,
		Email,
		Mensaje,
		Leido,
	    isnull(Estado,'') as Estado,
		NumIteracion,
		CodigoUbigeo,
		FechaSolicitud,
		FechaModificacion,
		--case
		--	when exists(SELECT 1 FROM dbo.Cliente a WHERE ConsultoraID = @ConsultoraId AND a.Nombre = sc.NombreCompleto AND a.Activo = 1) then 1
		--	else 0
		--end FlagConsultora,
		FlagMedio,
		(select isnull(tld.Descripcion,'') from TablaLogicaDatos tld where tld.tablalogicaid = 85 AND tld.Codigo = flagmedio) as MContacto ,
		(select sum((Precio*Cantidad)) from SolicitudClienteDetalle where SolicitudClienteID = sc.SolicitudClienteID) as PrecioTotal,
		m.Descripcion as Marca,
		--case isnull(FlagConsultora,0)
		--	when 1 then '00:00:00'
		--	else dbo.CaclSaldoHorasSolicitudPedido(FechaSolicitud)
		--end SaldoHoras,
		isnull(PedidoWebID,0) as PedidoWebID
	from SolicitudCliente sc left join Marca m on sc.MarcaID = m.MarcaID
	where
		ConsultoraID = @ConsultoraId
		AND
		( sc.Estado IS NULL or (LTRIM(RTRIM(sc.Estado)) IN ('A','R','C')))
		--and ( sc.Estado IS NULL )	-- pendientes de aprobacaion
		AND
		IIF(ISNULL(sc.MarcaID,0) = 0, @Campania, Campania) = Campania
		AND
		IIF(
			ISNULL(FlagConsultora,0) = 1,
			IIF(cast(sc.FechaSolicitud AS DATE) BETWEEN CAST(@FechaInicioFact AS DATE) AND CAST(@FechaFinFact AS DATE), 1, 0),
			1
		) = 1
	ORDER BY
		ISNULL(FlagConsultora,0) DESC,
		ISNULL(sc.MarcaID,0) ASC,
		FechaSolicitud ASC,
		PrecioTotal DESC;
END
GO

USE BelcorpSalvador
GO
ALTER procedure dbo.GetSolicitudesPedido_SB2
-- exec GetSolicitudesPedido_SB2 17283, 201907
	@ConsultoraId bigint,
	@Campania int
as
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

	select
		SolicitudClienteID,
		sc.MarcaID,
		Campania,
		NombreCompleto,
		Telefono,
		Direccion,
		Email,
		Mensaje,
		Leido,
	    isnull(Estado,'') as Estado,
		NumIteracion,
		CodigoUbigeo,
		FechaSolicitud,
		FechaModificacion,
		--case
		--	when exists(SELECT 1 FROM dbo.Cliente a WHERE ConsultoraID = @ConsultoraId AND a.Nombre = sc.NombreCompleto AND a.Activo = 1) then 1
		--	else 0
		--end FlagConsultora,
		FlagMedio,
		(select isnull(tld.Descripcion,'') from TablaLogicaDatos tld where tld.tablalogicaid = 85 AND tld.Codigo = flagmedio) as MContacto ,
		(select sum((Precio*Cantidad)) from SolicitudClienteDetalle where SolicitudClienteID = sc.SolicitudClienteID) as PrecioTotal,
		m.Descripcion as Marca,
		--case isnull(FlagConsultora,0)
		--	when 1 then '00:00:00'
		--	else dbo.CaclSaldoHorasSolicitudPedido(FechaSolicitud)
		--end SaldoHoras,
		isnull(PedidoWebID,0) as PedidoWebID
	from SolicitudCliente sc left join Marca m on sc.MarcaID = m.MarcaID
	where
		ConsultoraID = @ConsultoraId
		AND
		( sc.Estado IS NULL or (LTRIM(RTRIM(sc.Estado)) IN ('A','R','C')))
		--and ( sc.Estado IS NULL )	-- pendientes de aprobacaion
		AND
		IIF(ISNULL(sc.MarcaID,0) = 0, @Campania, Campania) = Campania
		AND
		IIF(
			ISNULL(FlagConsultora,0) = 1,
			IIF(cast(sc.FechaSolicitud AS DATE) BETWEEN CAST(@FechaInicioFact AS DATE) AND CAST(@FechaFinFact AS DATE), 1, 0),
			1
		) = 1
	ORDER BY
		ISNULL(FlagConsultora,0) DESC,
		ISNULL(sc.MarcaID,0) ASC,
		FechaSolicitud ASC,
		PrecioTotal DESC;
END
GO