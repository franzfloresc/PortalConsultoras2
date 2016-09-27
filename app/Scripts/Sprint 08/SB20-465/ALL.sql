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
---------------------------------------------------------------------------------------------------------------
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetMotivosRechazo_SB2' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetMotivosRechazo_SB2
END
GO
CREATE PROCEDURE dbo.GetMotivosRechazo_SB2
AS
BEGIN
	SELECT
		MotivoSolicitudID,
		Motivo,
		Tipo,
		Estado
	FROM MotivoSolicitud
	WHERE Tipo = 3 AND Estado = 1;
END
GO
---------------------------------------------------------------------------------------------------------------
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
---------------------------------------------------------------------------------------------------------------
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'CancelarSolicitudCliente_SB2' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.CancelarSolicitudCliente_SB2
END
GO
CREATE PROCEDURE dbo.CancelarSolicitudCliente_SB2
	@SolicitudId bigint,
	@MotivoSolicitudId Int,
	@RazonMotivoSolicitud Varchar(500)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @CodigoUsuario varchar(20);
	SELECT TOP 1 @CodigoUsuario = U.CodigoUsuario
	FROM SolicitudCliente SC
	INNER JOIN ods.Consultora C ON C.ConsultoraID = SC.ConsultoraID
	INNER JOIN Usuario U ON U.CodigoConsultora = C.Codigo
	WHERE SC.SolicitudClienteID = @SolicitudId

	UPDATE SolicitudCliente
	SET
		Estado = 'C',
		UsuarioModificacion = @CodigoUsuario,
		FechaModificacion = GETDATE(),
		MotivoSolicitudId = NULLIF(@MotivoSolicitudId,0),
		RazonMotivoSolicitud = @RazonMotivoSolicitud 
	WHERE SOlicitudClienteId = @SolicitudId and Estado='A'
END
GO