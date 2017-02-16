USE BelcorpBolivia
go
alter procedure dbo.GetSolicitudesPedido_SB2
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
		Estado,  
		NumIteracion,  
		CodigoUbigeo,  
		FechaSolicitud,  
		FechaModificacion,
		isnull(FlagConsultora,0) as FlagConsultora,
		FlagMedio, 
		(select isnull(tld.Descripcion,'') from TablaLogicaDatos tld where tld.tablalogicaid = 85 AND tld.Codigo = flagmedio) as MContacto ,
		(select sum((Precio*Cantidad)) from SolicitudClienteDetalle where SolicitudClienteID = sc.SolicitudClienteID) as PrecioTotal,
		m.Descripcion as Marca,
		--'05:30:27' as SaldoHoras,
		case isnull(FlagConsultora,0) 
			when 1 then '00:00:00' 
			--else '5:30:27'
			else dbo.CaclSaldoHorasSolicitudPedido(FechaSolicitud)
		end SaldoHoras,
		isnull(PedidoWebID,0) as PedidoWebID
	from SolicitudCliente sc left join Marca m on sc.MarcaID = m.MarcaID
	where 
		ConsultoraID = @ConsultoraId 
		and
		( sc.Estado IS NULL or (LTRIM(RTRIM(sc.Estado)) IN ('A','R','C')))  
		--and ( sc.Estado IS NULL )	-- pendientes de aprobacaion
	
		AND 
		IIF(ISNULL(sc.MarcaID,0) = 0, @Campania, Campania) = Campania
		AND
		IIF(
			ISNULL(FlagConsultora,0) = 1,
			IIF(cast(sc.FechaSolicitud AS DATE) BETWEEN CAST(@FechaInicioFact AS DATE) AND CAST(@FechaFinFact AS DATE), 1, 0),
			IIF(sc.FechaSolicitud > DATEADD(DAY,-1,GETDATE()), 1, 0)
		) = 1
	ORDER BY 
		ISNULL(FlagConsultora,0) DESC,
		ISNULL(sc.MarcaID,0) ASC,
		FechaSolicitud ASC,
		PrecioTotal DESC;
END
go
/*end*/

USE BelcorpChile
go
alter procedure dbo.GetSolicitudesPedido_SB2
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
		Estado,  
		NumIteracion,  
		CodigoUbigeo,  
		FechaSolicitud,  
		FechaModificacion,
		isnull(FlagConsultora,0) as FlagConsultora,
		FlagMedio, 
		(select isnull(tld.Descripcion,'') from TablaLogicaDatos tld where tld.tablalogicaid = 85 AND tld.Codigo = flagmedio) as MContacto ,
		(select sum((Precio*Cantidad)) from SolicitudClienteDetalle where SolicitudClienteID = sc.SolicitudClienteID) as PrecioTotal,
		m.Descripcion as Marca,
		--'05:30:27' as SaldoHoras,
		case isnull(FlagConsultora,0) 
			when 1 then '00:00:00' 
			--else '5:30:27'
			else dbo.CaclSaldoHorasSolicitudPedido(FechaSolicitud)
		end SaldoHoras,
		isnull(PedidoWebID,0) as PedidoWebID
	from SolicitudCliente sc left join Marca m on sc.MarcaID = m.MarcaID
	where 
		ConsultoraID = @ConsultoraId 
		and
		( sc.Estado IS NULL or (LTRIM(RTRIM(sc.Estado)) IN ('A','R','C')))  
		--and ( sc.Estado IS NULL )	-- pendientes de aprobacaion
	
		AND 
		IIF(ISNULL(sc.MarcaID,0) = 0, @Campania, Campania) = Campania
		AND
		IIF(
			ISNULL(FlagConsultora,0) = 1,
			IIF(cast(sc.FechaSolicitud AS DATE) BETWEEN CAST(@FechaInicioFact AS DATE) AND CAST(@FechaFinFact AS DATE), 1, 0),
			IIF(sc.FechaSolicitud > DATEADD(DAY,-1,GETDATE()), 1, 0)
		) = 1
	ORDER BY 
		ISNULL(FlagConsultora,0) DESC,
		ISNULL(sc.MarcaID,0) ASC,
		FechaSolicitud ASC,
		PrecioTotal DESC;
END
go
/*end*/

USE BelcorpCostaRica
go
alter procedure dbo.GetSolicitudesPedido_SB2
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
		Estado,  
		NumIteracion,  
		CodigoUbigeo,  
		FechaSolicitud,  
		FechaModificacion,
		isnull(FlagConsultora,0) as FlagConsultora,
		FlagMedio, 
		(select isnull(tld.Descripcion,'') from TablaLogicaDatos tld where tld.tablalogicaid = 85 AND tld.Codigo = flagmedio) as MContacto ,
		(select sum((Precio*Cantidad)) from SolicitudClienteDetalle where SolicitudClienteID = sc.SolicitudClienteID) as PrecioTotal,
		m.Descripcion as Marca,
		--'05:30:27' as SaldoHoras,
		case isnull(FlagConsultora,0) 
			when 1 then '00:00:00' 
			--else '5:30:27'
			else dbo.CaclSaldoHorasSolicitudPedido(FechaSolicitud)
		end SaldoHoras,
		isnull(PedidoWebID,0) as PedidoWebID
	from SolicitudCliente sc left join Marca m on sc.MarcaID = m.MarcaID
	where 
		ConsultoraID = @ConsultoraId 
		and
		( sc.Estado IS NULL or (LTRIM(RTRIM(sc.Estado)) IN ('A','R','C')))  
		--and ( sc.Estado IS NULL )	-- pendientes de aprobacaion
	
		AND 
		IIF(ISNULL(sc.MarcaID,0) = 0, @Campania, Campania) = Campania
		AND
		IIF(
			ISNULL(FlagConsultora,0) = 1,
			IIF(cast(sc.FechaSolicitud AS DATE) BETWEEN CAST(@FechaInicioFact AS DATE) AND CAST(@FechaFinFact AS DATE), 1, 0),
			IIF(sc.FechaSolicitud > DATEADD(DAY,-1,GETDATE()), 1, 0)
		) = 1
	ORDER BY 
		ISNULL(FlagConsultora,0) DESC,
		ISNULL(sc.MarcaID,0) ASC,
		FechaSolicitud ASC,
		PrecioTotal DESC;
END
go
/*end*/

USE BelcorpDominicana
go
alter procedure dbo.GetSolicitudesPedido_SB2
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
		Estado,  
		NumIteracion,  
		CodigoUbigeo,  
		FechaSolicitud,  
		FechaModificacion,
		isnull(FlagConsultora,0) as FlagConsultora,
		FlagMedio, 
		(select isnull(tld.Descripcion,'') from TablaLogicaDatos tld where tld.tablalogicaid = 85 AND tld.Codigo = flagmedio) as MContacto ,
		(select sum((Precio*Cantidad)) from SolicitudClienteDetalle where SolicitudClienteID = sc.SolicitudClienteID) as PrecioTotal,
		m.Descripcion as Marca,
		--'05:30:27' as SaldoHoras,
		case isnull(FlagConsultora,0) 
			when 1 then '00:00:00' 
			--else '5:30:27'
			else dbo.CaclSaldoHorasSolicitudPedido(FechaSolicitud)
		end SaldoHoras,
		isnull(PedidoWebID,0) as PedidoWebID
	from SolicitudCliente sc left join Marca m on sc.MarcaID = m.MarcaID
	where 
		ConsultoraID = @ConsultoraId 
		and
		( sc.Estado IS NULL or (LTRIM(RTRIM(sc.Estado)) IN ('A','R','C')))  
		--and ( sc.Estado IS NULL )	-- pendientes de aprobacaion
	
		AND 
		IIF(ISNULL(sc.MarcaID,0) = 0, @Campania, Campania) = Campania
		AND
		IIF(
			ISNULL(FlagConsultora,0) = 1,
			IIF(cast(sc.FechaSolicitud AS DATE) BETWEEN CAST(@FechaInicioFact AS DATE) AND CAST(@FechaFinFact AS DATE), 1, 0),
			IIF(sc.FechaSolicitud > DATEADD(DAY,-1,GETDATE()), 1, 0)
		) = 1
	ORDER BY 
		ISNULL(FlagConsultora,0) DESC,
		ISNULL(sc.MarcaID,0) ASC,
		FechaSolicitud ASC,
		PrecioTotal DESC;
END
go
/*end*/

USE BelcorpEcuador
go
alter procedure dbo.GetSolicitudesPedido_SB2
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
		Estado,  
		NumIteracion,  
		CodigoUbigeo,  
		FechaSolicitud,  
		FechaModificacion,
		isnull(FlagConsultora,0) as FlagConsultora,
		FlagMedio, 
		(select isnull(tld.Descripcion,'') from TablaLogicaDatos tld where tld.tablalogicaid = 85 AND tld.Codigo = flagmedio) as MContacto ,
		(select sum((Precio*Cantidad)) from SolicitudClienteDetalle where SolicitudClienteID = sc.SolicitudClienteID) as PrecioTotal,
		m.Descripcion as Marca,
		--'05:30:27' as SaldoHoras,
		case isnull(FlagConsultora,0) 
			when 1 then '00:00:00' 
			--else '5:30:27'
			else dbo.CaclSaldoHorasSolicitudPedido(FechaSolicitud)
		end SaldoHoras,
		isnull(PedidoWebID,0) as PedidoWebID
	from SolicitudCliente sc left join Marca m on sc.MarcaID = m.MarcaID
	where 
		ConsultoraID = @ConsultoraId 
		and
		( sc.Estado IS NULL or (LTRIM(RTRIM(sc.Estado)) IN ('A','R','C')))  
		--and ( sc.Estado IS NULL )	-- pendientes de aprobacaion
	
		AND 
		IIF(ISNULL(sc.MarcaID,0) = 0, @Campania, Campania) = Campania
		AND
		IIF(
			ISNULL(FlagConsultora,0) = 1,
			IIF(cast(sc.FechaSolicitud AS DATE) BETWEEN CAST(@FechaInicioFact AS DATE) AND CAST(@FechaFinFact AS DATE), 1, 0),
			IIF(sc.FechaSolicitud > DATEADD(DAY,-1,GETDATE()), 1, 0)
		) = 1
	ORDER BY 
		ISNULL(FlagConsultora,0) DESC,
		ISNULL(sc.MarcaID,0) ASC,
		FechaSolicitud ASC,
		PrecioTotal DESC;
END
go
/*end*/

USE BelcorpGuatemala
go
alter procedure dbo.GetSolicitudesPedido_SB2
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
		Estado,  
		NumIteracion,  
		CodigoUbigeo,  
		FechaSolicitud,  
		FechaModificacion,
		isnull(FlagConsultora,0) as FlagConsultora,
		FlagMedio, 
		(select isnull(tld.Descripcion,'') from TablaLogicaDatos tld where tld.tablalogicaid = 85 AND tld.Codigo = flagmedio) as MContacto ,
		(select sum((Precio*Cantidad)) from SolicitudClienteDetalle where SolicitudClienteID = sc.SolicitudClienteID) as PrecioTotal,
		m.Descripcion as Marca,
		--'05:30:27' as SaldoHoras,
		case isnull(FlagConsultora,0) 
			when 1 then '00:00:00' 
			--else '5:30:27'
			else dbo.CaclSaldoHorasSolicitudPedido(FechaSolicitud)
		end SaldoHoras,
		isnull(PedidoWebID,0) as PedidoWebID
	from SolicitudCliente sc left join Marca m on sc.MarcaID = m.MarcaID
	where 
		ConsultoraID = @ConsultoraId 
		and
		( sc.Estado IS NULL or (LTRIM(RTRIM(sc.Estado)) IN ('A','R','C')))  
		--and ( sc.Estado IS NULL )	-- pendientes de aprobacaion
	
		AND 
		IIF(ISNULL(sc.MarcaID,0) = 0, @Campania, Campania) = Campania
		AND
		IIF(
			ISNULL(FlagConsultora,0) = 1,
			IIF(cast(sc.FechaSolicitud AS DATE) BETWEEN CAST(@FechaInicioFact AS DATE) AND CAST(@FechaFinFact AS DATE), 1, 0),
			IIF(sc.FechaSolicitud > DATEADD(DAY,-1,GETDATE()), 1, 0)
		) = 1
	ORDER BY 
		ISNULL(FlagConsultora,0) DESC,
		ISNULL(sc.MarcaID,0) ASC,
		FechaSolicitud ASC,
		PrecioTotal DESC;
END
go
/*end*/

USE BelcorpPanama
go
alter procedure dbo.GetSolicitudesPedido_SB2
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
		Estado,  
		NumIteracion,  
		CodigoUbigeo,  
		FechaSolicitud,  
		FechaModificacion,
		isnull(FlagConsultora,0) as FlagConsultora,
		FlagMedio, 
		(select isnull(tld.Descripcion,'') from TablaLogicaDatos tld where tld.tablalogicaid = 85 AND tld.Codigo = flagmedio) as MContacto ,
		(select sum((Precio*Cantidad)) from SolicitudClienteDetalle where SolicitudClienteID = sc.SolicitudClienteID) as PrecioTotal,
		m.Descripcion as Marca,
		--'05:30:27' as SaldoHoras,
		case isnull(FlagConsultora,0) 
			when 1 then '00:00:00' 
			--else '5:30:27'
			else dbo.CaclSaldoHorasSolicitudPedido(FechaSolicitud)
		end SaldoHoras,
		isnull(PedidoWebID,0) as PedidoWebID
	from SolicitudCliente sc left join Marca m on sc.MarcaID = m.MarcaID
	where 
		ConsultoraID = @ConsultoraId 
		and
		( sc.Estado IS NULL or (LTRIM(RTRIM(sc.Estado)) IN ('A','R','C')))  
		--and ( sc.Estado IS NULL )	-- pendientes de aprobacaion
	
		AND 
		IIF(ISNULL(sc.MarcaID,0) = 0, @Campania, Campania) = Campania
		AND
		IIF(
			ISNULL(FlagConsultora,0) = 1,
			IIF(cast(sc.FechaSolicitud AS DATE) BETWEEN CAST(@FechaInicioFact AS DATE) AND CAST(@FechaFinFact AS DATE), 1, 0),
			IIF(sc.FechaSolicitud > DATEADD(DAY,-1,GETDATE()), 1, 0)
		) = 1
	ORDER BY 
		ISNULL(FlagConsultora,0) DESC,
		ISNULL(sc.MarcaID,0) ASC,
		FechaSolicitud ASC,
		PrecioTotal DESC;
END
go
/*end*/

USE BelcorpPuertoRico
go
alter procedure dbo.GetSolicitudesPedido_SB2
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
		Estado,  
		NumIteracion,  
		CodigoUbigeo,  
		FechaSolicitud,  
		FechaModificacion,
		isnull(FlagConsultora,0) as FlagConsultora,
		FlagMedio, 
		(select isnull(tld.Descripcion,'') from TablaLogicaDatos tld where tld.tablalogicaid = 85 AND tld.Codigo = flagmedio) as MContacto ,
		(select sum((Precio*Cantidad)) from SolicitudClienteDetalle where SolicitudClienteID = sc.SolicitudClienteID) as PrecioTotal,
		m.Descripcion as Marca,
		--'05:30:27' as SaldoHoras,
		case isnull(FlagConsultora,0) 
			when 1 then '00:00:00' 
			--else '5:30:27'
			else dbo.CaclSaldoHorasSolicitudPedido(FechaSolicitud)
		end SaldoHoras,
		isnull(PedidoWebID,0) as PedidoWebID
	from SolicitudCliente sc left join Marca m on sc.MarcaID = m.MarcaID
	where 
		ConsultoraID = @ConsultoraId 
		and
		( sc.Estado IS NULL or (LTRIM(RTRIM(sc.Estado)) IN ('A','R','C')))  
		--and ( sc.Estado IS NULL )	-- pendientes de aprobacaion
	
		AND 
		IIF(ISNULL(sc.MarcaID,0) = 0, @Campania, Campania) = Campania
		AND
		IIF(
			ISNULL(FlagConsultora,0) = 1,
			IIF(cast(sc.FechaSolicitud AS DATE) BETWEEN CAST(@FechaInicioFact AS DATE) AND CAST(@FechaFinFact AS DATE), 1, 0),
			IIF(sc.FechaSolicitud > DATEADD(DAY,-1,GETDATE()), 1, 0)
		) = 1
	ORDER BY 
		ISNULL(FlagConsultora,0) DESC,
		ISNULL(sc.MarcaID,0) ASC,
		FechaSolicitud ASC,
		PrecioTotal DESC;
END
go
/*end*/

USE BelcorpSalvador
go
alter procedure dbo.GetSolicitudesPedido_SB2
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
		Estado,  
		NumIteracion,  
		CodigoUbigeo,  
		FechaSolicitud,  
		FechaModificacion,
		isnull(FlagConsultora,0) as FlagConsultora,
		FlagMedio, 
		(select isnull(tld.Descripcion,'') from TablaLogicaDatos tld where tld.tablalogicaid = 85 AND tld.Codigo = flagmedio) as MContacto ,
		(select sum((Precio*Cantidad)) from SolicitudClienteDetalle where SolicitudClienteID = sc.SolicitudClienteID) as PrecioTotal,
		m.Descripcion as Marca,
		--'05:30:27' as SaldoHoras,
		case isnull(FlagConsultora,0) 
			when 1 then '00:00:00' 
			--else '5:30:27'
			else dbo.CaclSaldoHorasSolicitudPedido(FechaSolicitud)
		end SaldoHoras,
		isnull(PedidoWebID,0) as PedidoWebID
	from SolicitudCliente sc left join Marca m on sc.MarcaID = m.MarcaID
	where 
		ConsultoraID = @ConsultoraId 
		and
		( sc.Estado IS NULL or (LTRIM(RTRIM(sc.Estado)) IN ('A','R','C')))  
		--and ( sc.Estado IS NULL )	-- pendientes de aprobacaion
	
		AND 
		IIF(ISNULL(sc.MarcaID,0) = 0, @Campania, Campania) = Campania
		AND
		IIF(
			ISNULL(FlagConsultora,0) = 1,
			IIF(cast(sc.FechaSolicitud AS DATE) BETWEEN CAST(@FechaInicioFact AS DATE) AND CAST(@FechaFinFact AS DATE), 1, 0),
			IIF(sc.FechaSolicitud > DATEADD(DAY,-1,GETDATE()), 1, 0)
		) = 1
	ORDER BY 
		ISNULL(FlagConsultora,0) DESC,
		ISNULL(sc.MarcaID,0) ASC,
		FechaSolicitud ASC,
		PrecioTotal DESC;
END
go
/*end*/

USE BelcorpVenezuela
go
alter procedure dbo.GetSolicitudesPedido_SB2
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
		Estado,  
		NumIteracion,  
		CodigoUbigeo,  
		FechaSolicitud,  
		FechaModificacion,
		isnull(FlagConsultora,0) as FlagConsultora,
		FlagMedio, 
		(select isnull(tld.Descripcion,'') from TablaLogicaDatos tld where tld.tablalogicaid = 85 AND tld.Codigo = flagmedio) as MContacto ,
		(select sum((Precio*Cantidad)) from SolicitudClienteDetalle where SolicitudClienteID = sc.SolicitudClienteID) as PrecioTotal,
		m.Descripcion as Marca,
		--'05:30:27' as SaldoHoras,
		case isnull(FlagConsultora,0) 
			when 1 then '00:00:00' 
			--else '5:30:27'
			else dbo.CaclSaldoHorasSolicitudPedido(FechaSolicitud)
		end SaldoHoras,
		isnull(PedidoWebID,0) as PedidoWebID
	from SolicitudCliente sc left join Marca m on sc.MarcaID = m.MarcaID
	where 
		ConsultoraID = @ConsultoraId 
		and
		( sc.Estado IS NULL or (LTRIM(RTRIM(sc.Estado)) IN ('A','R','C')))  
		--and ( sc.Estado IS NULL )	-- pendientes de aprobacaion
	
		AND 
		IIF(ISNULL(sc.MarcaID,0) = 0, @Campania, Campania) = Campania
		AND
		IIF(
			ISNULL(FlagConsultora,0) = 1,
			IIF(cast(sc.FechaSolicitud AS DATE) BETWEEN CAST(@FechaInicioFact AS DATE) AND CAST(@FechaFinFact AS DATE), 1, 0),
			IIF(sc.FechaSolicitud > DATEADD(DAY,-1,GETDATE()), 1, 0)
		) = 1
	ORDER BY 
		ISNULL(FlagConsultora,0) DESC,
		ISNULL(sc.MarcaID,0) ASC,
		FechaSolicitud ASC,
		PrecioTotal DESC;
END
go
/*end*/

USE BelcorpColombia
go
alter procedure dbo.GetSolicitudesPedido_SB2
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
		Estado,  
		NumIteracion,  
		CodigoUbigeo,  
		FechaSolicitud,  
		FechaModificacion,
		isnull(FlagConsultora,0) as FlagConsultora,
		FlagMedio, 
		(select isnull(tld.Descripcion,'') from TablaLogicaDatos tld where tld.tablalogicaid = 85 AND tld.Codigo = flagmedio) as MContacto ,
		(select sum((Precio*Cantidad)) from SolicitudClienteDetalle where SolicitudClienteID = sc.SolicitudClienteID) as PrecioTotal,
		m.Descripcion as Marca,
		--'05:30:27' as SaldoHoras,
		case isnull(FlagConsultora,0) 
			when 1 then '00:00:00' 
			--else '5:30:27'
			else dbo.CaclSaldoHorasSolicitudPedido(FechaSolicitud)
		end SaldoHoras,
		isnull(PedidoWebID,0) as PedidoWebID
	from SolicitudCliente sc left join Marca m on sc.MarcaID = m.MarcaID
	where 
		ConsultoraID = @ConsultoraId 
		and
		( sc.Estado IS NULL or (LTRIM(RTRIM(sc.Estado)) IN ('A','R','C')))  
		--and ( sc.Estado IS NULL )	-- pendientes de aprobacaion
	
		AND 
		IIF(ISNULL(sc.MarcaID,0) = 0, @Campania, Campania) = Campania
		AND
		IIF(
			ISNULL(FlagConsultora,0) = 1,
			IIF(cast(sc.FechaSolicitud AS DATE) BETWEEN CAST(@FechaInicioFact AS DATE) AND CAST(@FechaFinFact AS DATE), 1, 0),
			IIF(sc.FechaSolicitud > DATEADD(DAY,-1,GETDATE()), 1, 0)
		) = 1
	ORDER BY 
		ISNULL(FlagConsultora,0) DESC,
		ISNULL(sc.MarcaID,0) ASC,
		FechaSolicitud ASC,
		PrecioTotal DESC;
END
go
/*end*/

USE BelcorpMexico
go
alter procedure dbo.GetSolicitudesPedido_SB2
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
		Estado,  
		NumIteracion,  
		CodigoUbigeo,  
		FechaSolicitud,  
		FechaModificacion,
		isnull(FlagConsultora,0) as FlagConsultora,
		FlagMedio, 
		(select isnull(tld.Descripcion,'') from TablaLogicaDatos tld where tld.tablalogicaid = 85 AND tld.Codigo = flagmedio) as MContacto ,
		(select sum((Precio*Cantidad)) from SolicitudClienteDetalle where SolicitudClienteID = sc.SolicitudClienteID) as PrecioTotal,
		m.Descripcion as Marca,
		--'05:30:27' as SaldoHoras,
		case isnull(FlagConsultora,0) 
			when 1 then '00:00:00' 
			--else '5:30:27'
			else dbo.CaclSaldoHorasSolicitudPedido(FechaSolicitud)
		end SaldoHoras,
		isnull(PedidoWebID,0) as PedidoWebID
	from SolicitudCliente sc left join Marca m on sc.MarcaID = m.MarcaID
	where 
		ConsultoraID = @ConsultoraId 
		and
		( sc.Estado IS NULL or (LTRIM(RTRIM(sc.Estado)) IN ('A','R','C')))  
		--and ( sc.Estado IS NULL )	-- pendientes de aprobacaion
	
		AND 
		IIF(ISNULL(sc.MarcaID,0) = 0, @Campania, Campania) = Campania
		AND
		IIF(
			ISNULL(FlagConsultora,0) = 1,
			IIF(cast(sc.FechaSolicitud AS DATE) BETWEEN CAST(@FechaInicioFact AS DATE) AND CAST(@FechaFinFact AS DATE), 1, 0),
			IIF(sc.FechaSolicitud > DATEADD(DAY,-1,GETDATE()), 1, 0)
		) = 1
	ORDER BY 
		ISNULL(FlagConsultora,0) DESC,
		ISNULL(sc.MarcaID,0) ASC,
		FechaSolicitud ASC,
		PrecioTotal DESC;
END
go
/*end*/

USE BelcorpPeru
go
alter procedure dbo.GetSolicitudesPedido_SB2
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
		Estado,  
		NumIteracion,  
		CodigoUbigeo,  
		FechaSolicitud,  
		FechaModificacion,
		isnull(FlagConsultora,0) as FlagConsultora,
		FlagMedio, 
		(select isnull(tld.Descripcion,'') from TablaLogicaDatos tld where tld.tablalogicaid = 85 AND tld.Codigo = flagmedio) as MContacto ,
		(select sum((Precio*Cantidad)) from SolicitudClienteDetalle where SolicitudClienteID = sc.SolicitudClienteID) as PrecioTotal,
		m.Descripcion as Marca,
		--'05:30:27' as SaldoHoras,
		case isnull(FlagConsultora,0) 
			when 1 then '00:00:00' 
			--else '5:30:27'
			else dbo.CaclSaldoHorasSolicitudPedido(FechaSolicitud)
		end SaldoHoras,
		isnull(PedidoWebID,0) as PedidoWebID
	from SolicitudCliente sc left join Marca m on sc.MarcaID = m.MarcaID
	where 
		ConsultoraID = @ConsultoraId 
		and
		( sc.Estado IS NULL or (LTRIM(RTRIM(sc.Estado)) IN ('A','R','C')))  
		--and ( sc.Estado IS NULL )	-- pendientes de aprobacaion
	
		AND 
		IIF(ISNULL(sc.MarcaID,0) = 0, @Campania, Campania) = Campania
		AND
		IIF(
			ISNULL(FlagConsultora,0) = 1,
			IIF(cast(sc.FechaSolicitud AS DATE) BETWEEN CAST(@FechaInicioFact AS DATE) AND CAST(@FechaFinFact AS DATE), 1, 0),
			IIF(sc.FechaSolicitud > DATEADD(DAY,-1,GETDATE()), 1, 0)
		) = 1
	ORDER BY 
		ISNULL(FlagConsultora,0) DESC,
		ISNULL(sc.MarcaID,0) ASC,
		FechaSolicitud ASC,
		PrecioTotal DESC;
END
go