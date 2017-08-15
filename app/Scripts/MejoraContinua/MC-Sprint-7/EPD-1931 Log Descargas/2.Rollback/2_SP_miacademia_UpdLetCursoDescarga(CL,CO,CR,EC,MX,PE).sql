USE BelcorpChile
go
alter procedure miacademia.UpdLetCursoDescarga
	@LetCursoDescargaId bigint,
	@Estado int,
	@ErrorProceso varchar(200),
	@ErrorLog varchar(200),
	@NombreArchivo varchar(100),
	@NombreServer varchar(100)
as
begin
	UPDATE miacademia.LetCursoDescarga
	SET	Estado = @Estado,
		FechaHoraFin = dbo.fnObtenerFechaHoraPais(),
		ErrorProceso = @ErrorProceso,
		ErrorLog = @ErrorLog,
		NombreArchivo = @NombreArchivo,
		NombreServer = @NombreServer
	WHERE LetCursoDescargaId = @LetCursoDescargaId;
end
go
/*end*/

USE BelcorpColombia
go
alter procedure miacademia.UpdLetCursoDescarga
	@LetCursoDescargaId bigint,
	@Estado int,
	@ErrorProceso varchar(200),
	@ErrorLog varchar(200),
	@NombreArchivo varchar(100),
	@NombreServer varchar(100)
as
begin
	UPDATE miacademia.LetCursoDescarga
	SET	Estado = @Estado,
		FechaHoraFin = dbo.fnObtenerFechaHoraPais(),
		ErrorProceso = @ErrorProceso,
		ErrorLog = @ErrorLog,
		NombreArchivo = @NombreArchivo,
		NombreServer = @NombreServer
	WHERE LetCursoDescargaId = @LetCursoDescargaId;
end
go
/*end*/

USE BelcorpCostaRica
go
alter procedure miacademia.UpdLetCursoDescarga
	@LetCursoDescargaId bigint,
	@Estado int,
	@ErrorProceso varchar(200),
	@ErrorLog varchar(200),
	@NombreArchivo varchar(100),
	@NombreServer varchar(100)
as
begin
	UPDATE miacademia.LetCursoDescarga
	SET	Estado = @Estado,
		FechaHoraFin = dbo.fnObtenerFechaHoraPais(),
		ErrorProceso = @ErrorProceso,
		ErrorLog = @ErrorLog,
		NombreArchivo = @NombreArchivo,
		NombreServer = @NombreServer
	WHERE LetCursoDescargaId = @LetCursoDescargaId;
end
go
/*end*/

USE BelcorpEcuador
go
alter procedure miacademia.UpdLetCursoDescarga
	@LetCursoDescargaId bigint,
	@Estado int,
	@ErrorProceso varchar(200),
	@ErrorLog varchar(200),
	@NombreArchivo varchar(100),
	@NombreServer varchar(100)
as
begin
	UPDATE miacademia.LetCursoDescarga
	SET	Estado = @Estado,
		FechaHoraFin = dbo.fnObtenerFechaHoraPais(),
		ErrorProceso = @ErrorProceso,
		ErrorLog = @ErrorLog,
		NombreArchivo = @NombreArchivo,
		NombreServer = @NombreServer
	WHERE LetCursoDescargaId = @LetCursoDescargaId;
end
go
/*end*/

USE BelcorpMexico
go
alter procedure miacademia.UpdLetCursoDescarga
	@LetCursoDescargaId bigint,
	@Estado int,
	@ErrorProceso varchar(200),
	@ErrorLog varchar(200),
	@NombreArchivo varchar(100),
	@NombreServer varchar(100)
as
begin
	UPDATE miacademia.LetCursoDescarga
	SET	Estado = @Estado,
		FechaHoraFin = dbo.fnObtenerFechaHoraPais(),
		ErrorProceso = @ErrorProceso,
		ErrorLog = @ErrorLog,
		NombreArchivo = @NombreArchivo,
		NombreServer = @NombreServer
	WHERE LetCursoDescargaId = @LetCursoDescargaId;
end
go
/*end*/

USE BelcorpPeru
go
alter procedure miacademia.UpdLetCursoDescarga
	@LetCursoDescargaId bigint,
	@Estado int,
	@ErrorProceso varchar(200),
	@ErrorLog varchar(200),
	@NombreArchivo varchar(100),
	@NombreServer varchar(100)
as
begin
	UPDATE miacademia.LetCursoDescarga
	SET	Estado = @Estado,
		FechaHoraFin = dbo.fnObtenerFechaHoraPais(),
		ErrorProceso = @ErrorProceso,
		ErrorLog = @ErrorLog,
		NombreArchivo = @NombreArchivo,
		NombreServer = @NombreServer
	WHERE LetCursoDescargaId = @LetCursoDescargaId;
end
go