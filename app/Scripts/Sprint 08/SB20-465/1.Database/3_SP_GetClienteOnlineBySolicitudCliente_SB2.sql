USE BelcorpBolivia
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetPedidoClienteOnlineBySolicitudClienteId_SB2' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetPedidoClienteOnlineBySolicitudClienteId_SB2
END
GO
CREATE PROCEDURE dbo.GetPedidoClienteOnlineBySolicitudClienteId_SB2
	@SolicitudClienteId bigint
as
BEGIN
	select
		SC.SolicitudClienteID,
		SC.ConsultoraID,
		SC.MarcaID,
		CASE SC.MarcaID
			WHEN 0 THEN Campania
			ELSE (
				SELECT TOP 1 C.Codigo
				FROM ods.Campania C
				INNER JOIN ods.Cronograma Cr ON C.CampaniaID = Cr.CampaniaID
				INNER JOIN ods.Consultora Co ON Cr.RegionID = Co.RegionID and Cr.ZonaID = Co.ZonaID
				WHERE
					Co.ConsultoraID = SC.ConsultoraID
					AND
					Cr.FechaFinFacturacion >= SC.FechaSolicitud
				ORDER BY c.CampaniaID ASC
			)
		END AS Campania,
		SC.FlagConsultora,
		SC.NombreCompleto,
		SC.FechaSolicitud,
		LTRIM(RTRIM(SC.Estado)) AS Estado,
		SC.Telefono,
		SC.Direccion,
		SC.Email,
		IIF(SC.MarcaID = 0, '', Mensaje) AS Mensaje
	FROM SolicitudCliente SC
	WHERE SC.SolicitudClienteId = @SolicitudClienteId ;
END
GO
/*end*/

USE BelcorpChile
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetPedidoClienteOnlineBySolicitudClienteId_SB2' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetPedidoClienteOnlineBySolicitudClienteId_SB2
END
GO
CREATE PROCEDURE dbo.GetPedidoClienteOnlineBySolicitudClienteId_SB2
	@SolicitudClienteId bigint
as
BEGIN
	select
		SC.SolicitudClienteID,
		SC.ConsultoraID,
		SC.MarcaID,
		CASE SC.MarcaID
			WHEN 0 THEN Campania
			ELSE (
				SELECT TOP 1 C.Codigo
				FROM ods.Campania C
				INNER JOIN ods.Cronograma Cr ON C.CampaniaID = Cr.CampaniaID
				INNER JOIN ods.Consultora Co ON Cr.RegionID = Co.RegionID and Cr.ZonaID = Co.ZonaID
				WHERE
					Co.ConsultoraID = SC.ConsultoraID
					AND
					Cr.FechaFinFacturacion >= SC.FechaSolicitud
				ORDER BY c.CampaniaID ASC
			)
		END AS Campania,
		SC.FlagConsultora,
		SC.NombreCompleto,
		SC.FechaSolicitud,
		LTRIM(RTRIM(SC.Estado)) AS Estado,
		SC.Telefono,
		SC.Direccion,
		SC.Email,
		IIF(SC.MarcaID = 0, '', Mensaje) AS Mensaje
	FROM SolicitudCliente SC
	WHERE SC.SolicitudClienteId = @SolicitudClienteId ;
END
GO
/*end*/

USE BelcorpCostaRica
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetPedidoClienteOnlineBySolicitudClienteId_SB2' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetPedidoClienteOnlineBySolicitudClienteId_SB2
END
GO
CREATE PROCEDURE dbo.GetPedidoClienteOnlineBySolicitudClienteId_SB2
	@SolicitudClienteId bigint
as
BEGIN
	select
		SC.SolicitudClienteID,
		SC.ConsultoraID,
		SC.MarcaID,
		CASE SC.MarcaID
			WHEN 0 THEN Campania
			ELSE (
				SELECT TOP 1 C.Codigo
				FROM ods.Campania C
				INNER JOIN ods.Cronograma Cr ON C.CampaniaID = Cr.CampaniaID
				INNER JOIN ods.Consultora Co ON Cr.RegionID = Co.RegionID and Cr.ZonaID = Co.ZonaID
				WHERE
					Co.ConsultoraID = SC.ConsultoraID
					AND
					Cr.FechaFinFacturacion >= SC.FechaSolicitud
				ORDER BY c.CampaniaID ASC
			)
		END AS Campania,
		SC.FlagConsultora,
		SC.NombreCompleto,
		SC.FechaSolicitud,
		LTRIM(RTRIM(SC.Estado)) AS Estado,
		SC.Telefono,
		SC.Direccion,
		SC.Email,
		IIF(SC.MarcaID = 0, '', Mensaje) AS Mensaje
	FROM SolicitudCliente SC
	WHERE SC.SolicitudClienteId = @SolicitudClienteId ;
END
GO
/*end*/

USE BelcorpDominicana
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetPedidoClienteOnlineBySolicitudClienteId_SB2' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetPedidoClienteOnlineBySolicitudClienteId_SB2
END
GO
CREATE PROCEDURE dbo.GetPedidoClienteOnlineBySolicitudClienteId_SB2
	@SolicitudClienteId bigint
as
BEGIN
	select
		SC.SolicitudClienteID,
		SC.ConsultoraID,
		SC.MarcaID,
		CASE SC.MarcaID
			WHEN 0 THEN Campania
			ELSE (
				SELECT TOP 1 C.Codigo
				FROM ods.Campania C
				INNER JOIN ods.Cronograma Cr ON C.CampaniaID = Cr.CampaniaID
				INNER JOIN ods.Consultora Co ON Cr.RegionID = Co.RegionID and Cr.ZonaID = Co.ZonaID
				WHERE
					Co.ConsultoraID = SC.ConsultoraID
					AND
					Cr.FechaFinFacturacion >= SC.FechaSolicitud
				ORDER BY c.CampaniaID ASC
			)
		END AS Campania,
		SC.FlagConsultora,
		SC.NombreCompleto,
		SC.FechaSolicitud,
		LTRIM(RTRIM(SC.Estado)) AS Estado,
		SC.Telefono,
		SC.Direccion,
		SC.Email,
		IIF(SC.MarcaID = 0, '', Mensaje) AS Mensaje
	FROM SolicitudCliente SC
	WHERE SC.SolicitudClienteId = @SolicitudClienteId ;
END
GO
/*end*/

USE BelcorpEcuador
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetPedidoClienteOnlineBySolicitudClienteId_SB2' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetPedidoClienteOnlineBySolicitudClienteId_SB2
END
GO
CREATE PROCEDURE dbo.GetPedidoClienteOnlineBySolicitudClienteId_SB2
	@SolicitudClienteId bigint
as
BEGIN
	select
		SC.SolicitudClienteID,
		SC.ConsultoraID,
		SC.MarcaID,
		CASE SC.MarcaID
			WHEN 0 THEN Campania
			ELSE (
				SELECT TOP 1 C.Codigo
				FROM ods.Campania C
				INNER JOIN ods.Cronograma Cr ON C.CampaniaID = Cr.CampaniaID
				INNER JOIN ods.Consultora Co ON Cr.RegionID = Co.RegionID and Cr.ZonaID = Co.ZonaID
				WHERE
					Co.ConsultoraID = SC.ConsultoraID
					AND
					Cr.FechaFinFacturacion >= SC.FechaSolicitud
				ORDER BY c.CampaniaID ASC
			)
		END AS Campania,
		SC.FlagConsultora,
		SC.NombreCompleto,
		SC.FechaSolicitud,
		LTRIM(RTRIM(SC.Estado)) AS Estado,
		SC.Telefono,
		SC.Direccion,
		SC.Email,
		IIF(SC.MarcaID = 0, '', Mensaje) AS Mensaje
	FROM SolicitudCliente SC
	WHERE SC.SolicitudClienteId = @SolicitudClienteId ;
END
GO
/*end*/

USE BelcorpGuatemala
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetPedidoClienteOnlineBySolicitudClienteId_SB2' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetPedidoClienteOnlineBySolicitudClienteId_SB2
END
GO
CREATE PROCEDURE dbo.GetPedidoClienteOnlineBySolicitudClienteId_SB2
	@SolicitudClienteId bigint
as
BEGIN
	select
		SC.SolicitudClienteID,
		SC.ConsultoraID,
		SC.MarcaID,
		CASE SC.MarcaID
			WHEN 0 THEN Campania
			ELSE (
				SELECT TOP 1 C.Codigo
				FROM ods.Campania C
				INNER JOIN ods.Cronograma Cr ON C.CampaniaID = Cr.CampaniaID
				INNER JOIN ods.Consultora Co ON Cr.RegionID = Co.RegionID and Cr.ZonaID = Co.ZonaID
				WHERE
					Co.ConsultoraID = SC.ConsultoraID
					AND
					Cr.FechaFinFacturacion >= SC.FechaSolicitud
				ORDER BY c.CampaniaID ASC
			)
		END AS Campania,
		SC.FlagConsultora,
		SC.NombreCompleto,
		SC.FechaSolicitud,
		LTRIM(RTRIM(SC.Estado)) AS Estado,
		SC.Telefono,
		SC.Direccion,
		SC.Email,
		IIF(SC.MarcaID = 0, '', Mensaje) AS Mensaje
	FROM SolicitudCliente SC
	WHERE SC.SolicitudClienteId = @SolicitudClienteId ;
END
GO
/*end*/

USE BelcorpPanama
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetPedidoClienteOnlineBySolicitudClienteId_SB2' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetPedidoClienteOnlineBySolicitudClienteId_SB2
END
GO
CREATE PROCEDURE dbo.GetPedidoClienteOnlineBySolicitudClienteId_SB2
	@SolicitudClienteId bigint
as
BEGIN
	select
		SC.SolicitudClienteID,
		SC.ConsultoraID,
		SC.MarcaID,
		CASE SC.MarcaID
			WHEN 0 THEN Campania
			ELSE (
				SELECT TOP 1 C.Codigo
				FROM ods.Campania C
				INNER JOIN ods.Cronograma Cr ON C.CampaniaID = Cr.CampaniaID
				INNER JOIN ods.Consultora Co ON Cr.RegionID = Co.RegionID and Cr.ZonaID = Co.ZonaID
				WHERE
					Co.ConsultoraID = SC.ConsultoraID
					AND
					Cr.FechaFinFacturacion >= SC.FechaSolicitud
				ORDER BY c.CampaniaID ASC
			)
		END AS Campania,
		SC.FlagConsultora,
		SC.NombreCompleto,
		SC.FechaSolicitud,
		LTRIM(RTRIM(SC.Estado)) AS Estado,
		SC.Telefono,
		SC.Direccion,
		SC.Email,
		IIF(SC.MarcaID = 0, '', Mensaje) AS Mensaje
	FROM SolicitudCliente SC
	WHERE SC.SolicitudClienteId = @SolicitudClienteId ;
END
GO
/*end*/

USE BelcorpPuertoRico
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetPedidoClienteOnlineBySolicitudClienteId_SB2' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetPedidoClienteOnlineBySolicitudClienteId_SB2
END
GO
CREATE PROCEDURE dbo.GetPedidoClienteOnlineBySolicitudClienteId_SB2
	@SolicitudClienteId bigint
as
BEGIN
	select
		SC.SolicitudClienteID,
		SC.ConsultoraID,
		SC.MarcaID,
		CASE SC.MarcaID
			WHEN 0 THEN Campania
			ELSE (
				SELECT TOP 1 C.Codigo
				FROM ods.Campania C
				INNER JOIN ods.Cronograma Cr ON C.CampaniaID = Cr.CampaniaID
				INNER JOIN ods.Consultora Co ON Cr.RegionID = Co.RegionID and Cr.ZonaID = Co.ZonaID
				WHERE
					Co.ConsultoraID = SC.ConsultoraID
					AND
					Cr.FechaFinFacturacion >= SC.FechaSolicitud
				ORDER BY c.CampaniaID ASC
			)
		END AS Campania,
		SC.FlagConsultora,
		SC.NombreCompleto,
		SC.FechaSolicitud,
		LTRIM(RTRIM(SC.Estado)) AS Estado,
		SC.Telefono,
		SC.Direccion,
		SC.Email,
		IIF(SC.MarcaID = 0, '', Mensaje) AS Mensaje
	FROM SolicitudCliente SC
	WHERE SC.SolicitudClienteId = @SolicitudClienteId ;
END
GO
/*end*/

USE BelcorpSalvador
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetPedidoClienteOnlineBySolicitudClienteId_SB2' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetPedidoClienteOnlineBySolicitudClienteId_SB2
END
GO
CREATE PROCEDURE dbo.GetPedidoClienteOnlineBySolicitudClienteId_SB2
	@SolicitudClienteId bigint
as
BEGIN
	select
		SC.SolicitudClienteID,
		SC.ConsultoraID,
		SC.MarcaID,
		CASE SC.MarcaID
			WHEN 0 THEN Campania
			ELSE (
				SELECT TOP 1 C.Codigo
				FROM ods.Campania C
				INNER JOIN ods.Cronograma Cr ON C.CampaniaID = Cr.CampaniaID
				INNER JOIN ods.Consultora Co ON Cr.RegionID = Co.RegionID and Cr.ZonaID = Co.ZonaID
				WHERE
					Co.ConsultoraID = SC.ConsultoraID
					AND
					Cr.FechaFinFacturacion >= SC.FechaSolicitud
				ORDER BY c.CampaniaID ASC
			)
		END AS Campania,
		SC.FlagConsultora,
		SC.NombreCompleto,
		SC.FechaSolicitud,
		LTRIM(RTRIM(SC.Estado)) AS Estado,
		SC.Telefono,
		SC.Direccion,
		SC.Email,
		IIF(SC.MarcaID = 0, '', Mensaje) AS Mensaje
	FROM SolicitudCliente SC
	WHERE SC.SolicitudClienteId = @SolicitudClienteId ;
END
GO
/*end*/

USE BelcorpVenezuela
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetPedidoClienteOnlineBySolicitudClienteId_SB2' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetPedidoClienteOnlineBySolicitudClienteId_SB2
END
GO
CREATE PROCEDURE dbo.GetPedidoClienteOnlineBySolicitudClienteId_SB2
	@SolicitudClienteId bigint
as
BEGIN
	select
		SC.SolicitudClienteID,
		SC.ConsultoraID,
		SC.MarcaID,
		CASE SC.MarcaID
			WHEN 0 THEN Campania
			ELSE (
				SELECT TOP 1 C.Codigo
				FROM ods.Campania C
				INNER JOIN ods.Cronograma Cr ON C.CampaniaID = Cr.CampaniaID
				INNER JOIN ods.Consultora Co ON Cr.RegionID = Co.RegionID and Cr.ZonaID = Co.ZonaID
				WHERE
					Co.ConsultoraID = SC.ConsultoraID
					AND
					Cr.FechaFinFacturacion >= SC.FechaSolicitud
				ORDER BY c.CampaniaID ASC
			)
		END AS Campania,
		SC.FlagConsultora,
		SC.NombreCompleto,
		SC.FechaSolicitud,
		LTRIM(RTRIM(SC.Estado)) AS Estado,
		SC.Telefono,
		SC.Direccion,
		SC.Email,
		IIF(SC.MarcaID = 0, '', Mensaje) AS Mensaje
	FROM SolicitudCliente SC
	WHERE SC.SolicitudClienteId = @SolicitudClienteId ;
END
GO
/*end*/

USE BelcorpColombia
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetPedidoClienteOnlineBySolicitudClienteId_SB2' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetPedidoClienteOnlineBySolicitudClienteId_SB2
END
GO
CREATE PROCEDURE dbo.GetPedidoClienteOnlineBySolicitudClienteId_SB2
	@SolicitudClienteId bigint
as
BEGIN
	select
		SC.SolicitudClienteID,
		SC.ConsultoraID,
		SC.MarcaID,
		CASE SC.MarcaID
			WHEN 0 THEN Campania
			ELSE (
				SELECT TOP 1 C.Codigo
				FROM ods.Campania C
				INNER JOIN ods.Cronograma Cr ON C.CampaniaID = Cr.CampaniaID
				INNER JOIN ods.Consultora Co ON Cr.RegionID = Co.RegionID and Cr.ZonaID = Co.ZonaID
				WHERE
					Co.ConsultoraID = SC.ConsultoraID
					AND
					Cr.FechaFinFacturacion >= SC.FechaSolicitud
				ORDER BY c.CampaniaID ASC
			)
		END AS Campania,
		SC.FlagConsultora,
		SC.NombreCompleto,
		SC.FechaSolicitud,
		LTRIM(RTRIM(SC.Estado)) AS Estado,
		SC.Telefono,
		SC.Direccion,
		SC.Email,
		IIF(SC.MarcaID = 0, '', Mensaje) AS Mensaje
	FROM SolicitudCliente SC
	WHERE SC.SolicitudClienteId = @SolicitudClienteId ;
END
GO
/*end*/

USE BelcorpMexico
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetPedidoClienteOnlineBySolicitudClienteId_SB2' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetPedidoClienteOnlineBySolicitudClienteId_SB2
END
GO
CREATE PROCEDURE dbo.GetPedidoClienteOnlineBySolicitudClienteId_SB2
	@SolicitudClienteId bigint
as
BEGIN
	select
		SC.SolicitudClienteID,
		SC.ConsultoraID,
		SC.MarcaID,
		CASE SC.MarcaID
			WHEN 0 THEN Campania
			ELSE (
				SELECT TOP 1 C.Codigo
				FROM ods.Campania C
				INNER JOIN ods.Cronograma Cr ON C.CampaniaID = Cr.CampaniaID
				INNER JOIN ods.Consultora Co ON Cr.RegionID = Co.RegionID and Cr.ZonaID = Co.ZonaID
				WHERE
					Co.ConsultoraID = SC.ConsultoraID
					AND
					Cr.FechaFinFacturacion >= SC.FechaSolicitud
				ORDER BY c.CampaniaID ASC
			)
		END AS Campania,
		SC.FlagConsultora,
		SC.NombreCompleto,
		SC.FechaSolicitud,
		LTRIM(RTRIM(SC.Estado)) AS Estado,
		SC.Telefono,
		SC.Direccion,
		SC.Email,
		IIF(SC.MarcaID = 0, '', Mensaje) AS Mensaje
	FROM SolicitudCliente SC
	WHERE SC.SolicitudClienteId = @SolicitudClienteId ;
END
GO
/*end*/

USE BelcorpPeru
GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetPedidoClienteOnlineBySolicitudClienteId_SB2' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetPedidoClienteOnlineBySolicitudClienteId_SB2
END
GO
CREATE PROCEDURE dbo.GetPedidoClienteOnlineBySolicitudClienteId_SB2
	@SolicitudClienteId bigint
as
BEGIN
	select
		SC.SolicitudClienteID,
		SC.ConsultoraID,
		SC.MarcaID,
		CASE SC.MarcaID
			WHEN 0 THEN Campania
			ELSE (
				SELECT TOP 1 C.Codigo
				FROM ods.Campania C
				INNER JOIN ods.Cronograma Cr ON C.CampaniaID = Cr.CampaniaID
				INNER JOIN ods.Consultora Co ON Cr.RegionID = Co.RegionID and Cr.ZonaID = Co.ZonaID
				WHERE
					Co.ConsultoraID = SC.ConsultoraID
					AND
					Cr.FechaFinFacturacion >= SC.FechaSolicitud
				ORDER BY c.CampaniaID ASC
			)
		END AS Campania,
		SC.FlagConsultora,
		SC.NombreCompleto,
		SC.FechaSolicitud,
		LTRIM(RTRIM(SC.Estado)) AS Estado,
		SC.Telefono,
		SC.Direccion,
		SC.Email,
		IIF(SC.MarcaID = 0, '', Mensaje) AS Mensaje
	FROM SolicitudCliente SC
	WHERE SC.SolicitudClienteId = @SolicitudClienteId ;
END
GO