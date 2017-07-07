USE BelcorpBolivia
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetMisPedidosClienteOnline_SB2' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetMisPedidosClienteOnline_SB2
END
GO
CREATE PROCEDURE dbo.GetMisPedidosClienteOnline_SB2
	@ConsultoraId bigint,
	@Campania int
as
BEGIN
	declare @RegionID int, @ZonaID int;
	declare @FechaInicioFact datetime, @FechaFinFact datetime;

	select
		@RegionID = RegionID,
		@ZonaID = ZonaID
	from ods.Consultora
	where ConsultoraID = @ConsultoraId;

	select top 1 @FechaInicioFact = dateadd(day,1,FechaFinFacturacion)
	from ods.Campania c
	inner join ods.Cronograma cr on c.CampaniaID = cr.CampaniaID 
	where
		cr.RegionID = @RegionID and cr.ZonaID = @ZonaID
		and
		c.Codigo < @Campania
	order by c.CampaniaID desc;

	select top 1 @FechaFinFact = FechaFinFacturacion 
	from ods.Campania c
	inner join ods.Cronograma cr on c.CampaniaID = cr.CampaniaID 
	where 
		cr.RegionID = @RegionID and cr.ZonaID = @ZonaID
		and
		c.Codigo = @Campania;

	select
		SC.SolicitudClienteID,
		SC.MarcaID,
		SC.FlagConsultora,
		SC.NombreCompleto,
		M.Descripcion AS Marca,
		SC.FechaSolicitud,
		(
			SELECT SUM(Precio*Cantidad)
			FROM SolicitudClienteDetalle
			WHERE SolicitudClienteID = SC.SolicitudClienteID
		) AS PrecioTotal,
		LTRIM(RTRIM(SC.Estado)) AS Estado,
		SC.Telefono,
		SC.Direccion,
		SC.Email,
		IIF(SC.MarcaID = 0, '', SC.Mensaje) AS Mensaje
	FROM SolicitudCliente SC
	LEFT JOIN Marca M on SC.MarcaID = M.MarcaID
	WHERE
		SC.ConsultoraID = @ConsultoraId 
		AND
		LTRIM(RTRIM(SC.Estado)) IN ('A','C')
		AND
		CASE SC.MarcaID
			WHEN 0 THEN IIF(SC.Campania = @Campania, 1, 0)
			ELSE IIF(SC.FechaSolicitud BETWEEN @FechaInicioFact AND @FechaFinFact, 1, 0)
		END = 1	
	ORDER BY FechaModificacion DESC;
END
GO
/*end*/

USE BelcorpChile
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetMisPedidosClienteOnline_SB2' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetMisPedidosClienteOnline_SB2
END
GO
CREATE PROCEDURE dbo.GetMisPedidosClienteOnline_SB2
	@ConsultoraId bigint,
	@Campania int
as
BEGIN
	declare @RegionID int, @ZonaID int;
	declare @FechaInicioFact datetime, @FechaFinFact datetime;

	select
		@RegionID = RegionID,
		@ZonaID = ZonaID
	from ods.Consultora
	where ConsultoraID = @ConsultoraId;

	select top 1 @FechaInicioFact = dateadd(day,1,FechaFinFacturacion)
	from ods.Campania c
	inner join ods.Cronograma cr on c.CampaniaID = cr.CampaniaID 
	where
		cr.RegionID = @RegionID and cr.ZonaID = @ZonaID
		and
		c.Codigo < @Campania
	order by c.CampaniaID desc;

	select top 1 @FechaFinFact = FechaFinFacturacion 
	from ods.Campania c
	inner join ods.Cronograma cr on c.CampaniaID = cr.CampaniaID 
	where 
		cr.RegionID = @RegionID and cr.ZonaID = @ZonaID
		and
		c.Codigo = @Campania;

	select
		SC.SolicitudClienteID,
		SC.MarcaID,
		SC.FlagConsultora,
		SC.NombreCompleto,
		M.Descripcion AS Marca,
		SC.FechaSolicitud,
		(
			SELECT SUM(Precio*Cantidad)
			FROM SolicitudClienteDetalle
			WHERE SolicitudClienteID = SC.SolicitudClienteID
		) AS PrecioTotal,
		LTRIM(RTRIM(SC.Estado)) AS Estado,
		SC.Telefono,
		SC.Direccion,
		SC.Email,
		IIF(SC.MarcaID = 0, '', SC.Mensaje) AS Mensaje
	FROM SolicitudCliente SC
	LEFT JOIN Marca M on SC.MarcaID = M.MarcaID
	WHERE
		SC.ConsultoraID = @ConsultoraId 
		AND
		LTRIM(RTRIM(SC.Estado)) IN ('A','C')
		AND
		CASE SC.MarcaID
			WHEN 0 THEN IIF(SC.Campania = @Campania, 1, 0)
			ELSE IIF(SC.FechaSolicitud BETWEEN @FechaInicioFact AND @FechaFinFact, 1, 0)
		END = 1	
	ORDER BY FechaModificacion DESC;
END
GO
/*end*/

USE BelcorpCostaRica
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetMisPedidosClienteOnline_SB2' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetMisPedidosClienteOnline_SB2
END
GO
CREATE PROCEDURE dbo.GetMisPedidosClienteOnline_SB2
	@ConsultoraId bigint,
	@Campania int
as
BEGIN
	declare @RegionID int, @ZonaID int;
	declare @FechaInicioFact datetime, @FechaFinFact datetime;

	select
		@RegionID = RegionID,
		@ZonaID = ZonaID
	from ods.Consultora
	where ConsultoraID = @ConsultoraId;

	select top 1 @FechaInicioFact = dateadd(day,1,FechaFinFacturacion)
	from ods.Campania c
	inner join ods.Cronograma cr on c.CampaniaID = cr.CampaniaID 
	where
		cr.RegionID = @RegionID and cr.ZonaID = @ZonaID
		and
		c.Codigo < @Campania
	order by c.CampaniaID desc;

	select top 1 @FechaFinFact = FechaFinFacturacion 
	from ods.Campania c
	inner join ods.Cronograma cr on c.CampaniaID = cr.CampaniaID 
	where 
		cr.RegionID = @RegionID and cr.ZonaID = @ZonaID
		and
		c.Codigo = @Campania;

	select
		SC.SolicitudClienteID,
		SC.MarcaID,
		SC.FlagConsultora,
		SC.NombreCompleto,
		M.Descripcion AS Marca,
		SC.FechaSolicitud,
		(
			SELECT SUM(Precio*Cantidad)
			FROM SolicitudClienteDetalle
			WHERE SolicitudClienteID = SC.SolicitudClienteID
		) AS PrecioTotal,
		LTRIM(RTRIM(SC.Estado)) AS Estado,
		SC.Telefono,
		SC.Direccion,
		SC.Email,
		IIF(SC.MarcaID = 0, '', SC.Mensaje) AS Mensaje
	FROM SolicitudCliente SC
	LEFT JOIN Marca M on SC.MarcaID = M.MarcaID
	WHERE
		SC.ConsultoraID = @ConsultoraId 
		AND
		LTRIM(RTRIM(SC.Estado)) IN ('A','C')
		AND
		CASE SC.MarcaID
			WHEN 0 THEN IIF(SC.Campania = @Campania, 1, 0)
			ELSE IIF(SC.FechaSolicitud BETWEEN @FechaInicioFact AND @FechaFinFact, 1, 0)
		END = 1	
	ORDER BY FechaModificacion DESC;
END
GO
/*end*/

USE BelcorpDominicana
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetMisPedidosClienteOnline_SB2' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetMisPedidosClienteOnline_SB2
END
GO
CREATE PROCEDURE dbo.GetMisPedidosClienteOnline_SB2
	@ConsultoraId bigint,
	@Campania int
as
BEGIN
	declare @RegionID int, @ZonaID int;
	declare @FechaInicioFact datetime, @FechaFinFact datetime;

	select
		@RegionID = RegionID,
		@ZonaID = ZonaID
	from ods.Consultora
	where ConsultoraID = @ConsultoraId;

	select top 1 @FechaInicioFact = dateadd(day,1,FechaFinFacturacion)
	from ods.Campania c
	inner join ods.Cronograma cr on c.CampaniaID = cr.CampaniaID 
	where
		cr.RegionID = @RegionID and cr.ZonaID = @ZonaID
		and
		c.Codigo < @Campania
	order by c.CampaniaID desc;

	select top 1 @FechaFinFact = FechaFinFacturacion 
	from ods.Campania c
	inner join ods.Cronograma cr on c.CampaniaID = cr.CampaniaID 
	where 
		cr.RegionID = @RegionID and cr.ZonaID = @ZonaID
		and
		c.Codigo = @Campania;

	select
		SC.SolicitudClienteID,
		SC.MarcaID,
		SC.FlagConsultora,
		SC.NombreCompleto,
		M.Descripcion AS Marca,
		SC.FechaSolicitud,
		(
			SELECT SUM(Precio*Cantidad)
			FROM SolicitudClienteDetalle
			WHERE SolicitudClienteID = SC.SolicitudClienteID
		) AS PrecioTotal,
		LTRIM(RTRIM(SC.Estado)) AS Estado,
		SC.Telefono,
		SC.Direccion,
		SC.Email,
		IIF(SC.MarcaID = 0, '', SC.Mensaje) AS Mensaje
	FROM SolicitudCliente SC
	LEFT JOIN Marca M on SC.MarcaID = M.MarcaID
	WHERE
		SC.ConsultoraID = @ConsultoraId 
		AND
		LTRIM(RTRIM(SC.Estado)) IN ('A','C')
		AND
		CASE SC.MarcaID
			WHEN 0 THEN IIF(SC.Campania = @Campania, 1, 0)
			ELSE IIF(SC.FechaSolicitud BETWEEN @FechaInicioFact AND @FechaFinFact, 1, 0)
		END = 1	
	ORDER BY FechaModificacion DESC;
END
GO
/*end*/

USE BelcorpEcuador
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetMisPedidosClienteOnline_SB2' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetMisPedidosClienteOnline_SB2
END
GO
CREATE PROCEDURE dbo.GetMisPedidosClienteOnline_SB2
	@ConsultoraId bigint,
	@Campania int
as
BEGIN
	declare @RegionID int, @ZonaID int;
	declare @FechaInicioFact datetime, @FechaFinFact datetime;

	select
		@RegionID = RegionID,
		@ZonaID = ZonaID
	from ods.Consultora
	where ConsultoraID = @ConsultoraId;

	select top 1 @FechaInicioFact = dateadd(day,1,FechaFinFacturacion)
	from ods.Campania c
	inner join ods.Cronograma cr on c.CampaniaID = cr.CampaniaID 
	where
		cr.RegionID = @RegionID and cr.ZonaID = @ZonaID
		and
		c.Codigo < @Campania
	order by c.CampaniaID desc;

	select top 1 @FechaFinFact = FechaFinFacturacion 
	from ods.Campania c
	inner join ods.Cronograma cr on c.CampaniaID = cr.CampaniaID 
	where 
		cr.RegionID = @RegionID and cr.ZonaID = @ZonaID
		and
		c.Codigo = @Campania;

	select
		SC.SolicitudClienteID,
		SC.MarcaID,
		SC.FlagConsultora,
		SC.NombreCompleto,
		M.Descripcion AS Marca,
		SC.FechaSolicitud,
		(
			SELECT SUM(Precio*Cantidad)
			FROM SolicitudClienteDetalle
			WHERE SolicitudClienteID = SC.SolicitudClienteID
		) AS PrecioTotal,
		LTRIM(RTRIM(SC.Estado)) AS Estado,
		SC.Telefono,
		SC.Direccion,
		SC.Email,
		IIF(SC.MarcaID = 0, '', SC.Mensaje) AS Mensaje
	FROM SolicitudCliente SC
	LEFT JOIN Marca M on SC.MarcaID = M.MarcaID
	WHERE
		SC.ConsultoraID = @ConsultoraId 
		AND
		LTRIM(RTRIM(SC.Estado)) IN ('A','C')
		AND
		CASE SC.MarcaID
			WHEN 0 THEN IIF(SC.Campania = @Campania, 1, 0)
			ELSE IIF(SC.FechaSolicitud BETWEEN @FechaInicioFact AND @FechaFinFact, 1, 0)
		END = 1	
	ORDER BY FechaModificacion DESC;
END
GO
/*end*/

USE BelcorpGuatemala
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetMisPedidosClienteOnline_SB2' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetMisPedidosClienteOnline_SB2
END
GO
CREATE PROCEDURE dbo.GetMisPedidosClienteOnline_SB2
	@ConsultoraId bigint,
	@Campania int
as
BEGIN
	declare @RegionID int, @ZonaID int;
	declare @FechaInicioFact datetime, @FechaFinFact datetime;

	select
		@RegionID = RegionID,
		@ZonaID = ZonaID
	from ods.Consultora
	where ConsultoraID = @ConsultoraId;

	select top 1 @FechaInicioFact = dateadd(day,1,FechaFinFacturacion)
	from ods.Campania c
	inner join ods.Cronograma cr on c.CampaniaID = cr.CampaniaID 
	where
		cr.RegionID = @RegionID and cr.ZonaID = @ZonaID
		and
		c.Codigo < @Campania
	order by c.CampaniaID desc;

	select top 1 @FechaFinFact = FechaFinFacturacion 
	from ods.Campania c
	inner join ods.Cronograma cr on c.CampaniaID = cr.CampaniaID 
	where 
		cr.RegionID = @RegionID and cr.ZonaID = @ZonaID
		and
		c.Codigo = @Campania;

	select
		SC.SolicitudClienteID,
		SC.MarcaID,
		SC.FlagConsultora,
		SC.NombreCompleto,
		M.Descripcion AS Marca,
		SC.FechaSolicitud,
		(
			SELECT SUM(Precio*Cantidad)
			FROM SolicitudClienteDetalle
			WHERE SolicitudClienteID = SC.SolicitudClienteID
		) AS PrecioTotal,
		LTRIM(RTRIM(SC.Estado)) AS Estado,
		SC.Telefono,
		SC.Direccion,
		SC.Email,
		IIF(SC.MarcaID = 0, '', SC.Mensaje) AS Mensaje
	FROM SolicitudCliente SC
	LEFT JOIN Marca M on SC.MarcaID = M.MarcaID
	WHERE
		SC.ConsultoraID = @ConsultoraId 
		AND
		LTRIM(RTRIM(SC.Estado)) IN ('A','C')
		AND
		CASE SC.MarcaID
			WHEN 0 THEN IIF(SC.Campania = @Campania, 1, 0)
			ELSE IIF(SC.FechaSolicitud BETWEEN @FechaInicioFact AND @FechaFinFact, 1, 0)
		END = 1	
	ORDER BY FechaModificacion DESC;
END
GO
/*end*/

USE BelcorpPanama
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetMisPedidosClienteOnline_SB2' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetMisPedidosClienteOnline_SB2
END
GO
CREATE PROCEDURE dbo.GetMisPedidosClienteOnline_SB2
	@ConsultoraId bigint,
	@Campania int
as
BEGIN
	declare @RegionID int, @ZonaID int;
	declare @FechaInicioFact datetime, @FechaFinFact datetime;

	select
		@RegionID = RegionID,
		@ZonaID = ZonaID
	from ods.Consultora
	where ConsultoraID = @ConsultoraId;

	select top 1 @FechaInicioFact = dateadd(day,1,FechaFinFacturacion)
	from ods.Campania c
	inner join ods.Cronograma cr on c.CampaniaID = cr.CampaniaID 
	where
		cr.RegionID = @RegionID and cr.ZonaID = @ZonaID
		and
		c.Codigo < @Campania
	order by c.CampaniaID desc;

	select top 1 @FechaFinFact = FechaFinFacturacion 
	from ods.Campania c
	inner join ods.Cronograma cr on c.CampaniaID = cr.CampaniaID 
	where 
		cr.RegionID = @RegionID and cr.ZonaID = @ZonaID
		and
		c.Codigo = @Campania;

	select
		SC.SolicitudClienteID,
		SC.MarcaID,
		SC.FlagConsultora,
		SC.NombreCompleto,
		M.Descripcion AS Marca,
		SC.FechaSolicitud,
		(
			SELECT SUM(Precio*Cantidad)
			FROM SolicitudClienteDetalle
			WHERE SolicitudClienteID = SC.SolicitudClienteID
		) AS PrecioTotal,
		LTRIM(RTRIM(SC.Estado)) AS Estado,
		SC.Telefono,
		SC.Direccion,
		SC.Email,
		IIF(SC.MarcaID = 0, '', SC.Mensaje) AS Mensaje
	FROM SolicitudCliente SC
	LEFT JOIN Marca M on SC.MarcaID = M.MarcaID
	WHERE
		SC.ConsultoraID = @ConsultoraId 
		AND
		LTRIM(RTRIM(SC.Estado)) IN ('A','C')
		AND
		CASE SC.MarcaID
			WHEN 0 THEN IIF(SC.Campania = @Campania, 1, 0)
			ELSE IIF(SC.FechaSolicitud BETWEEN @FechaInicioFact AND @FechaFinFact, 1, 0)
		END = 1	
	ORDER BY FechaModificacion DESC;
END
GO
/*end*/

USE BelcorpPuertoRico
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetMisPedidosClienteOnline_SB2' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetMisPedidosClienteOnline_SB2
END
GO
CREATE PROCEDURE dbo.GetMisPedidosClienteOnline_SB2
	@ConsultoraId bigint,
	@Campania int
as
BEGIN
	declare @RegionID int, @ZonaID int;
	declare @FechaInicioFact datetime, @FechaFinFact datetime;

	select
		@RegionID = RegionID,
		@ZonaID = ZonaID
	from ods.Consultora
	where ConsultoraID = @ConsultoraId;

	select top 1 @FechaInicioFact = dateadd(day,1,FechaFinFacturacion)
	from ods.Campania c
	inner join ods.Cronograma cr on c.CampaniaID = cr.CampaniaID 
	where
		cr.RegionID = @RegionID and cr.ZonaID = @ZonaID
		and
		c.Codigo < @Campania
	order by c.CampaniaID desc;

	select top 1 @FechaFinFact = FechaFinFacturacion 
	from ods.Campania c
	inner join ods.Cronograma cr on c.CampaniaID = cr.CampaniaID 
	where 
		cr.RegionID = @RegionID and cr.ZonaID = @ZonaID
		and
		c.Codigo = @Campania;

	select
		SC.SolicitudClienteID,
		SC.MarcaID,
		SC.FlagConsultora,
		SC.NombreCompleto,
		M.Descripcion AS Marca,
		SC.FechaSolicitud,
		(
			SELECT SUM(Precio*Cantidad)
			FROM SolicitudClienteDetalle
			WHERE SolicitudClienteID = SC.SolicitudClienteID
		) AS PrecioTotal,
		LTRIM(RTRIM(SC.Estado)) AS Estado,
		SC.Telefono,
		SC.Direccion,
		SC.Email,
		IIF(SC.MarcaID = 0, '', SC.Mensaje) AS Mensaje
	FROM SolicitudCliente SC
	LEFT JOIN Marca M on SC.MarcaID = M.MarcaID
	WHERE
		SC.ConsultoraID = @ConsultoraId 
		AND
		LTRIM(RTRIM(SC.Estado)) IN ('A','C')
		AND
		CASE SC.MarcaID
			WHEN 0 THEN IIF(SC.Campania = @Campania, 1, 0)
			ELSE IIF(SC.FechaSolicitud BETWEEN @FechaInicioFact AND @FechaFinFact, 1, 0)
		END = 1	
	ORDER BY FechaModificacion DESC;
END
GO
/*end*/

USE BelcorpSalvador
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetMisPedidosClienteOnline_SB2' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetMisPedidosClienteOnline_SB2
END
GO
CREATE PROCEDURE dbo.GetMisPedidosClienteOnline_SB2
	@ConsultoraId bigint,
	@Campania int
as
BEGIN
	declare @RegionID int, @ZonaID int;
	declare @FechaInicioFact datetime, @FechaFinFact datetime;

	select
		@RegionID = RegionID,
		@ZonaID = ZonaID
	from ods.Consultora
	where ConsultoraID = @ConsultoraId;

	select top 1 @FechaInicioFact = dateadd(day,1,FechaFinFacturacion)
	from ods.Campania c
	inner join ods.Cronograma cr on c.CampaniaID = cr.CampaniaID 
	where
		cr.RegionID = @RegionID and cr.ZonaID = @ZonaID
		and
		c.Codigo < @Campania
	order by c.CampaniaID desc;

	select top 1 @FechaFinFact = FechaFinFacturacion 
	from ods.Campania c
	inner join ods.Cronograma cr on c.CampaniaID = cr.CampaniaID 
	where 
		cr.RegionID = @RegionID and cr.ZonaID = @ZonaID
		and
		c.Codigo = @Campania;

	select
		SC.SolicitudClienteID,
		SC.MarcaID,
		SC.FlagConsultora,
		SC.NombreCompleto,
		M.Descripcion AS Marca,
		SC.FechaSolicitud,
		(
			SELECT SUM(Precio*Cantidad)
			FROM SolicitudClienteDetalle
			WHERE SolicitudClienteID = SC.SolicitudClienteID
		) AS PrecioTotal,
		LTRIM(RTRIM(SC.Estado)) AS Estado,
		SC.Telefono,
		SC.Direccion,
		SC.Email,
		IIF(SC.MarcaID = 0, '', SC.Mensaje) AS Mensaje
	FROM SolicitudCliente SC
	LEFT JOIN Marca M on SC.MarcaID = M.MarcaID
	WHERE
		SC.ConsultoraID = @ConsultoraId 
		AND
		LTRIM(RTRIM(SC.Estado)) IN ('A','C')
		AND
		CASE SC.MarcaID
			WHEN 0 THEN IIF(SC.Campania = @Campania, 1, 0)
			ELSE IIF(SC.FechaSolicitud BETWEEN @FechaInicioFact AND @FechaFinFact, 1, 0)
		END = 1	
	ORDER BY FechaModificacion DESC;
END
GO
/*end*/

USE BelcorpVenezuela
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetMisPedidosClienteOnline_SB2' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetMisPedidosClienteOnline_SB2
END
GO
CREATE PROCEDURE dbo.GetMisPedidosClienteOnline_SB2
	@ConsultoraId bigint,
	@Campania int
as
BEGIN
	declare @RegionID int, @ZonaID int;
	declare @FechaInicioFact datetime, @FechaFinFact datetime;

	select
		@RegionID = RegionID,
		@ZonaID = ZonaID
	from ods.Consultora
	where ConsultoraID = @ConsultoraId;

	select top 1 @FechaInicioFact = dateadd(day,1,FechaFinFacturacion)
	from ods.Campania c
	inner join ods.Cronograma cr on c.CampaniaID = cr.CampaniaID 
	where
		cr.RegionID = @RegionID and cr.ZonaID = @ZonaID
		and
		c.Codigo < @Campania
	order by c.CampaniaID desc;

	select top 1 @FechaFinFact = FechaFinFacturacion 
	from ods.Campania c
	inner join ods.Cronograma cr on c.CampaniaID = cr.CampaniaID 
	where 
		cr.RegionID = @RegionID and cr.ZonaID = @ZonaID
		and
		c.Codigo = @Campania;

	select
		SC.SolicitudClienteID,
		SC.MarcaID,
		SC.FlagConsultora,
		SC.NombreCompleto,
		M.Descripcion AS Marca,
		SC.FechaSolicitud,
		(
			SELECT SUM(Precio*Cantidad)
			FROM SolicitudClienteDetalle
			WHERE SolicitudClienteID = SC.SolicitudClienteID
		) AS PrecioTotal,
		LTRIM(RTRIM(SC.Estado)) AS Estado,
		SC.Telefono,
		SC.Direccion,
		SC.Email,
		IIF(SC.MarcaID = 0, '', SC.Mensaje) AS Mensaje
	FROM SolicitudCliente SC
	LEFT JOIN Marca M on SC.MarcaID = M.MarcaID
	WHERE
		SC.ConsultoraID = @ConsultoraId 
		AND
		LTRIM(RTRIM(SC.Estado)) IN ('A','C')
		AND
		CASE SC.MarcaID
			WHEN 0 THEN IIF(SC.Campania = @Campania, 1, 0)
			ELSE IIF(SC.FechaSolicitud BETWEEN @FechaInicioFact AND @FechaFinFact, 1, 0)
		END = 1	
	ORDER BY FechaModificacion DESC;
END
GO
/*end*/

USE BelcorpColombia
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetMisPedidosClienteOnline_SB2' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetMisPedidosClienteOnline_SB2
END
GO
CREATE PROCEDURE dbo.GetMisPedidosClienteOnline_SB2
	@ConsultoraId bigint,
	@Campania int
as
BEGIN
	declare @RegionID int, @ZonaID int;
	declare @FechaInicioFact datetime, @FechaFinFact datetime;

	select
		@RegionID = RegionID,
		@ZonaID = ZonaID
	from ods.Consultora
	where ConsultoraID = @ConsultoraId;

	select top 1 @FechaInicioFact = dateadd(day,1,FechaFinFacturacion)
	from ods.Campania c
	inner join ods.Cronograma cr on c.CampaniaID = cr.CampaniaID 
	where
		cr.RegionID = @RegionID and cr.ZonaID = @ZonaID
		and
		c.Codigo < @Campania
	order by c.CampaniaID desc;

	select top 1 @FechaFinFact = FechaFinFacturacion 
	from ods.Campania c
	inner join ods.Cronograma cr on c.CampaniaID = cr.CampaniaID 
	where 
		cr.RegionID = @RegionID and cr.ZonaID = @ZonaID
		and
		c.Codigo = @Campania;

	select
		SC.SolicitudClienteID,
		SC.MarcaID,
		SC.FlagConsultora,
		SC.NombreCompleto,
		M.Descripcion AS Marca,
		SC.FechaSolicitud,
		(
			SELECT SUM(Precio*Cantidad)
			FROM SolicitudClienteDetalle
			WHERE SolicitudClienteID = SC.SolicitudClienteID
		) AS PrecioTotal,
		LTRIM(RTRIM(SC.Estado)) AS Estado,
		SC.Telefono,
		SC.Direccion,
		SC.Email,
		IIF(SC.MarcaID = 0, '', SC.Mensaje) AS Mensaje
	FROM SolicitudCliente SC
	LEFT JOIN Marca M on SC.MarcaID = M.MarcaID
	WHERE
		SC.ConsultoraID = @ConsultoraId 
		AND
		LTRIM(RTRIM(SC.Estado)) IN ('A','C')
		AND
		CASE SC.MarcaID
			WHEN 0 THEN IIF(SC.Campania = @Campania, 1, 0)
			ELSE IIF(SC.FechaSolicitud BETWEEN @FechaInicioFact AND @FechaFinFact, 1, 0)
		END = 1	
	ORDER BY FechaModificacion DESC;
END
GO
/*end*/

USE BelcorpMexico
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetMisPedidosClienteOnline_SB2' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetMisPedidosClienteOnline_SB2
END
GO
CREATE PROCEDURE dbo.GetMisPedidosClienteOnline_SB2
	@ConsultoraId bigint,
	@Campania int
as
BEGIN
	declare @RegionID int, @ZonaID int;
	declare @FechaInicioFact datetime, @FechaFinFact datetime;

	select
		@RegionID = RegionID,
		@ZonaID = ZonaID
	from ods.Consultora
	where ConsultoraID = @ConsultoraId;

	select top 1 @FechaInicioFact = dateadd(day,1,FechaFinFacturacion)
	from ods.Campania c
	inner join ods.Cronograma cr on c.CampaniaID = cr.CampaniaID 
	where
		cr.RegionID = @RegionID and cr.ZonaID = @ZonaID
		and
		c.Codigo < @Campania
	order by c.CampaniaID desc;

	select top 1 @FechaFinFact = FechaFinFacturacion 
	from ods.Campania c
	inner join ods.Cronograma cr on c.CampaniaID = cr.CampaniaID 
	where 
		cr.RegionID = @RegionID and cr.ZonaID = @ZonaID
		and
		c.Codigo = @Campania;

	select
		SC.SolicitudClienteID,
		SC.MarcaID,
		SC.FlagConsultora,
		SC.NombreCompleto,
		M.Descripcion AS Marca,
		SC.FechaSolicitud,
		(
			SELECT SUM(Precio*Cantidad)
			FROM SolicitudClienteDetalle
			WHERE SolicitudClienteID = SC.SolicitudClienteID
		) AS PrecioTotal,
		LTRIM(RTRIM(SC.Estado)) AS Estado,
		SC.Telefono,
		SC.Direccion,
		SC.Email,
		IIF(SC.MarcaID = 0, '', SC.Mensaje) AS Mensaje
	FROM SolicitudCliente SC
	LEFT JOIN Marca M on SC.MarcaID = M.MarcaID
	WHERE
		SC.ConsultoraID = @ConsultoraId 
		AND
		LTRIM(RTRIM(SC.Estado)) IN ('A','C')
		AND
		CASE SC.MarcaID
			WHEN 0 THEN IIF(SC.Campania = @Campania, 1, 0)
			ELSE IIF(SC.FechaSolicitud BETWEEN @FechaInicioFact AND @FechaFinFact, 1, 0)
		END = 1	
	ORDER BY FechaModificacion DESC;
END
GO
/*end*/

USE BelcorpPeru
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetMisPedidosClienteOnline_SB2' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetMisPedidosClienteOnline_SB2
END
GO
CREATE PROCEDURE dbo.GetMisPedidosClienteOnline_SB2
	@ConsultoraId bigint,
	@Campania int
as
BEGIN
	declare @RegionID int, @ZonaID int;
	declare @FechaInicioFact datetime, @FechaFinFact datetime;

	select
		@RegionID = RegionID,
		@ZonaID = ZonaID
	from ods.Consultora
	where ConsultoraID = @ConsultoraId;

	select top 1 @FechaInicioFact = dateadd(day,1,FechaFinFacturacion)
	from ods.Campania c
	inner join ods.Cronograma cr on c.CampaniaID = cr.CampaniaID 
	where
		cr.RegionID = @RegionID and cr.ZonaID = @ZonaID
		and
		c.Codigo < @Campania
	order by c.CampaniaID desc;

	select top 1 @FechaFinFact = FechaFinFacturacion 
	from ods.Campania c
	inner join ods.Cronograma cr on c.CampaniaID = cr.CampaniaID 
	where 
		cr.RegionID = @RegionID and cr.ZonaID = @ZonaID
		and
		c.Codigo = @Campania;

	select
		SC.SolicitudClienteID,
		SC.MarcaID,
		SC.FlagConsultora,
		SC.NombreCompleto,
		M.Descripcion AS Marca,
		SC.FechaSolicitud,
		(
			SELECT SUM(Precio*Cantidad)
			FROM SolicitudClienteDetalle
			WHERE SolicitudClienteID = SC.SolicitudClienteID
		) AS PrecioTotal,
		LTRIM(RTRIM(SC.Estado)) AS Estado,
		SC.Telefono,
		SC.Direccion,
		SC.Email,
		IIF(SC.MarcaID = 0, '', SC.Mensaje) AS Mensaje
	FROM SolicitudCliente SC
	LEFT JOIN Marca M on SC.MarcaID = M.MarcaID
	WHERE
		SC.ConsultoraID = @ConsultoraId 
		AND
		LTRIM(RTRIM(SC.Estado)) IN ('A','C')
		AND
		CASE SC.MarcaID
			WHEN 0 THEN IIF(SC.Campania = @Campania, 1, 0)
			ELSE IIF(SC.FechaSolicitud BETWEEN @FechaInicioFact AND @FechaFinFact, 1, 0)
		END = 1	
	ORDER BY FechaModificacion DESC;
END
GO