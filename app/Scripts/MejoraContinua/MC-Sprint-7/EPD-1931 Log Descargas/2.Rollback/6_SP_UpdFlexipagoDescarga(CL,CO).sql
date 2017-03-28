USE BelcorpChile
go
alter procedure dbo.UpdFlexipagoDescarga
(
	@NumeroLote int,
	@Estado int,
	@Mensaje varchar(510),
	@NombreArchivoConsuFlex varchar(100),
	@NombreServer varchar(100)
)
as
begin
	DECLARE @FechaGeneral DATETIME
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

	UPDATE dbo.FlexipagoInsDesDescarga
	SET Estado = @Estado,
		Mensaje = @Mensaje,
		FechaFin = @FechaGeneral,
		NombreArchivoConsuFlex = @NombreArchivoConsuFlex,
		NombreServer = @NombreServer
	WHERE NumeroLote = @NumeroLote
end
go
/*end*/

USE BelcorpColombia
go
alter procedure dbo.UpdFlexipagoDescarga
(
	@NumeroLote int,
	@Estado int,
	@Mensaje varchar(510),
	@NombreArchivoConsuFlex varchar(100),
	@NombreServer varchar(100)
)
as
begin
	DECLARE @FechaGeneral DATETIME
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

	UPDATE dbo.FlexipagoInsDesDescarga
	SET Estado = @Estado,
		Mensaje = @Mensaje,
		FechaFin = @FechaGeneral,
		NombreArchivoConsuFlex = @NombreArchivoConsuFlex,
		NombreServer = @NombreServer
	WHERE NumeroLote = @NumeroLote
end
go