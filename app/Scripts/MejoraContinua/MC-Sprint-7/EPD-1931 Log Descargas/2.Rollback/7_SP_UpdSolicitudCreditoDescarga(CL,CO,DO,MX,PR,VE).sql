USE BelcorpChile
go
alter procedure dbo.UpdSolicitudCreditoDescarga
(
	@NumeroLote int,
	@Estado int,
	@Mensaje varchar(510),
	@NombreArchivoIns varchar(100),
	@NombreArchivoUpd varchar(100),
	@NombreServer varchar(100)
)
as
begin
	DECLARE @FechaGeneral DATETIME
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

	UPDATE dbo.SolicitudCreditoDescarga
	SET Estado = @Estado,
		Mensaje = @Mensaje,
		FechaFin = @FechaGeneral,
		NombreArchivoIns = @NombreArchivoIns,
		NombreArchivoUpd = @NombreArchivoUpd,
		NombreServer = @NombreServer
	WHERE NumeroLote = @NumeroLote
end
go
/*end*/

USE BelcorpColombia
go
alter procedure dbo.UpdSolicitudCreditoDescarga
(
	@NumeroLote int,
	@Estado int,
	@Mensaje varchar(510),
	@NombreArchivoIns varchar(100),
	@NombreArchivoUpd varchar(100),
	@NombreServer varchar(100)
)
as
begin
	DECLARE @FechaGeneral DATETIME
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

	UPDATE dbo.SolicitudCreditoDescarga
	SET Estado = @Estado,
		Mensaje = @Mensaje,
		FechaFin = @FechaGeneral,
		NombreArchivoIns = @NombreArchivoIns,
		NombreArchivoUpd = @NombreArchivoUpd,
		NombreServer = @NombreServer
	WHERE NumeroLote = @NumeroLote
end
go
/*end*/

USE BelcorpDominicana
go
alter procedure dbo.UpdSolicitudCreditoDescarga
(
	@NumeroLote int,
	@Estado int,
	@Mensaje varchar(510),
	@NombreArchivoIns varchar(100),
	@NombreArchivoUpd varchar(100),
	@NombreServer varchar(100)
)
as
begin
	DECLARE @FechaGeneral DATETIME
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

	UPDATE dbo.SolicitudCreditoDescarga
	SET Estado = @Estado,
		Mensaje = @Mensaje,
		FechaFin = @FechaGeneral,
		NombreArchivoIns = @NombreArchivoIns,
		NombreArchivoUpd = @NombreArchivoUpd,
		NombreServer = @NombreServer
	WHERE NumeroLote = @NumeroLote
end
go
/*end*/

USE BelcorpMexico
go
alter procedure dbo.UpdSolicitudCreditoDescarga
(
	@NumeroLote int,
	@Estado int,
	@Mensaje varchar(510),
	@NombreArchivoIns varchar(100),
	@NombreArchivoUpd varchar(100),
	@NombreServer varchar(100)
)
as
begin
	DECLARE @FechaGeneral DATETIME
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

	UPDATE dbo.SolicitudCreditoDescarga
	SET Estado = @Estado,
		Mensaje = @Mensaje,
		FechaFin = @FechaGeneral,
		NombreArchivoIns = @NombreArchivoIns,
		NombreArchivoUpd = @NombreArchivoUpd,
		NombreServer = @NombreServer
	WHERE NumeroLote = @NumeroLote
end
go
/*end*/

USE BelcorpPuertoRico
go
alter procedure dbo.UpdSolicitudCreditoDescarga
(
	@NumeroLote int,
	@Estado int,
	@Mensaje varchar(510),
	@NombreArchivoIns varchar(100),
	@NombreArchivoUpd varchar(100),
	@NombreServer varchar(100)
)
as
begin
	DECLARE @FechaGeneral DATETIME
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

	UPDATE dbo.SolicitudCreditoDescarga
	SET Estado = @Estado,
		Mensaje = @Mensaje,
		FechaFin = @FechaGeneral,
		NombreArchivoIns = @NombreArchivoIns,
		NombreArchivoUpd = @NombreArchivoUpd,
		NombreServer = @NombreServer
	WHERE NumeroLote = @NumeroLote
end
go
/*end*/

USE BelcorpVenezuela
go
alter procedure dbo.UpdSolicitudCreditoDescarga
(
	@NumeroLote int,
	@Estado int,
	@Mensaje varchar(510),
	@NombreArchivoIns varchar(100),
	@NombreArchivoUpd varchar(100),
	@NombreServer varchar(100)
)
as
begin
	DECLARE @FechaGeneral DATETIME
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

	UPDATE dbo.SolicitudCreditoDescarga
	SET Estado = @Estado,
		Mensaje = @Mensaje,
		FechaFin = @FechaGeneral,
		NombreArchivoIns = @NombreArchivoIns,
		NombreArchivoUpd = @NombreArchivoUpd,
		NombreServer = @NombreServer
	WHERE NumeroLote = @NumeroLote
end
go