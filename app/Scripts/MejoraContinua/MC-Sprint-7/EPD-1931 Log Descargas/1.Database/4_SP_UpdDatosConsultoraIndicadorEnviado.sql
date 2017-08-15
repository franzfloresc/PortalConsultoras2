USE BelcorpBolivia
go
alter procedure UpdDatosConsultoraIndicadorEnviado
	@NroLote int,
	@Estado tinyint,
	@Mensaje nvarchar(255),
	@MensajeExcepcion varchar(2000),
	@NombreArchivo varchar(100) = null,
	@NombreServer varchar(100) = null
as
begin
	DECLARE @FechaGeneral DATETIME = dbo.fnObtenerFechaHoraPais();

	if @Estado = 2
	begin
		UPDATE Usuario
		SET Modificado = 0
		WHERE codigoconsultora in (
			SELECT codigoconsultora
			FROM LogCargaConsultora
			WHERE NroLote = @NroLote
		)

		UPDATE ConsultoraGeo
		SET Enviado = 1
		WHERE
			Codigo IN (
				SELECT codigoconsultora
				FROM LogCargaConsultora
				WHERE NroLote = @NroLote
			)
			AND
			FuenteIngresoID = 1 AND Estado = 1;
	end

	UPDATE ConsultoraDescarga
	SET FechaFin = @FechaGeneral,
		Estado = @Estado,
		Mensaje = @Mensaje,
		MensajeExcepcion = @MensajeExcepcion,
		NombreArchivo = @NombreArchivo,
		NombreServer = @NombreServer
	WHERE NroLote = @NroLote;
end
go
/*end*/

USE BelcorpChile
go
alter procedure UpdDatosConsultoraIndicadorEnviado
	@NroLote int,
	@Estado tinyint,
	@Mensaje nvarchar(255),
	@MensajeExcepcion varchar(2000),
	@NombreArchivo varchar(100) = null,
	@NombreServer varchar(100) = null
as
begin
	DECLARE @FechaGeneral DATETIME = dbo.fnObtenerFechaHoraPais();

	if @Estado = 2
	begin
		UPDATE Usuario
		SET Modificado = 0
		WHERE codigoconsultora in (
			SELECT codigoconsultora
			FROM LogCargaConsultora
			WHERE NroLote = @NroLote
		)

		UPDATE ConsultoraGeo
		SET Enviado = 1
		WHERE
			Codigo IN (
				SELECT codigoconsultora
				FROM LogCargaConsultora
				WHERE NroLote = @NroLote
			)
			AND
			FuenteIngresoID = 1 AND Estado = 1;
	end

	UPDATE ConsultoraDescarga
	SET FechaFin = @FechaGeneral,
		Estado = @Estado,
		Mensaje = @Mensaje,
		MensajeExcepcion = @MensajeExcepcion,
		NombreArchivo = @NombreArchivo,
		NombreServer = @NombreServer
	WHERE NroLote = @NroLote;
end
go
/*end*/

USE BelcorpColombia
go
alter procedure UpdDatosConsultoraIndicadorEnviado
	@NroLote int,
	@Estado tinyint,
	@Mensaje nvarchar(255),
	@MensajeExcepcion varchar(2000),
	@NombreArchivo varchar(100) = null,
	@NombreServer varchar(100) = null
as
begin
	DECLARE @FechaGeneral DATETIME = dbo.fnObtenerFechaHoraPais();

	if @Estado = 2
	begin
		UPDATE Usuario
		SET Modificado = 0
		WHERE codigoconsultora in (
			SELECT codigoconsultora
			FROM LogCargaConsultora
			WHERE NroLote = @NroLote
		)

		UPDATE ConsultoraGeo
		SET Enviado = 1
		WHERE
			Codigo IN (
				SELECT codigoconsultora
				FROM LogCargaConsultora
				WHERE NroLote = @NroLote
			)
			AND
			FuenteIngresoID = 1 AND Estado = 1;
	end

	UPDATE ConsultoraDescarga
	SET FechaFin = @FechaGeneral,
		Estado = @Estado,
		Mensaje = @Mensaje,
		MensajeExcepcion = @MensajeExcepcion,
		NombreArchivo = @NombreArchivo,
		NombreServer = @NombreServer
	WHERE NroLote = @NroLote;
end
go
/*end*/

USE BelcorpCostaRica
go
alter procedure UpdDatosConsultoraIndicadorEnviado
	@NroLote int,
	@Estado tinyint,
	@Mensaje nvarchar(255),
	@MensajeExcepcion varchar(2000),
	@NombreArchivo varchar(100) = null,
	@NombreServer varchar(100) = null
as
begin
	DECLARE @FechaGeneral DATETIME = dbo.fnObtenerFechaHoraPais();

	if @Estado = 2
	begin
		UPDATE Usuario
		SET Modificado = 0
		WHERE codigoconsultora in (
			SELECT codigoconsultora
			FROM LogCargaConsultora
			WHERE NroLote = @NroLote
		)

		UPDATE ConsultoraGeo
		SET Enviado = 1
		WHERE
			Codigo IN (
				SELECT codigoconsultora
				FROM LogCargaConsultora
				WHERE NroLote = @NroLote
			)
			AND
			FuenteIngresoID = 1 AND Estado = 1;
	end

	UPDATE ConsultoraDescarga
	SET FechaFin = @FechaGeneral,
		Estado = @Estado,
		Mensaje = @Mensaje,
		MensajeExcepcion = @MensajeExcepcion,
		NombreArchivo = @NombreArchivo,
		NombreServer = @NombreServer
	WHERE NroLote = @NroLote;
end
go
/*end*/

USE BelcorpDominicana
go
alter procedure UpdDatosConsultoraIndicadorEnviado
	@NroLote int,
	@Estado tinyint,
	@Mensaje nvarchar(255),
	@MensajeExcepcion varchar(2000),
	@NombreArchivo varchar(100) = null,
	@NombreServer varchar(100) = null
as
begin
	DECLARE @FechaGeneral DATETIME = dbo.fnObtenerFechaHoraPais();

	if @Estado = 2
	begin
		UPDATE Usuario
		SET Modificado = 0
		WHERE codigoconsultora in (
			SELECT codigoconsultora
			FROM LogCargaConsultora
			WHERE NroLote = @NroLote
		)

		UPDATE ConsultoraGeo
		SET Enviado = 1
		WHERE
			Codigo IN (
				SELECT codigoconsultora
				FROM LogCargaConsultora
				WHERE NroLote = @NroLote
			)
			AND
			FuenteIngresoID = 1 AND Estado = 1;
	end

	UPDATE ConsultoraDescarga
	SET FechaFin = @FechaGeneral,
		Estado = @Estado,
		Mensaje = @Mensaje,
		MensajeExcepcion = @MensajeExcepcion,
		NombreArchivo = @NombreArchivo,
		NombreServer = @NombreServer
	WHERE NroLote = @NroLote;
end
go
/*end*/

USE BelcorpEcuador
go
alter procedure UpdDatosConsultoraIndicadorEnviado
	@NroLote int,
	@Estado tinyint,
	@Mensaje nvarchar(255),
	@MensajeExcepcion varchar(2000),
	@NombreArchivo varchar(100) = null,
	@NombreServer varchar(100) = null
as
begin
	DECLARE @FechaGeneral DATETIME = dbo.fnObtenerFechaHoraPais();

	if @Estado = 2
	begin
		UPDATE Usuario
		SET Modificado = 0
		WHERE codigoconsultora in (
			SELECT codigoconsultora
			FROM LogCargaConsultora
			WHERE NroLote = @NroLote
		)

		UPDATE ConsultoraGeo
		SET Enviado = 1
		WHERE
			Codigo IN (
				SELECT codigoconsultora
				FROM LogCargaConsultora
				WHERE NroLote = @NroLote
			)
			AND
			FuenteIngresoID = 1 AND Estado = 1;
	end

	UPDATE ConsultoraDescarga
	SET FechaFin = @FechaGeneral,
		Estado = @Estado,
		Mensaje = @Mensaje,
		MensajeExcepcion = @MensajeExcepcion,
		NombreArchivo = @NombreArchivo,
		NombreServer = @NombreServer
	WHERE NroLote = @NroLote;
end
go
/*end*/

USE BelcorpGuatemala
go
alter procedure UpdDatosConsultoraIndicadorEnviado
	@NroLote int,
	@Estado tinyint,
	@Mensaje nvarchar(255),
	@MensajeExcepcion varchar(2000),
	@NombreArchivo varchar(100) = null,
	@NombreServer varchar(100) = null
as
begin
	DECLARE @FechaGeneral DATETIME = dbo.fnObtenerFechaHoraPais();

	if @Estado = 2
	begin
		UPDATE Usuario
		SET Modificado = 0
		WHERE codigoconsultora in (
			SELECT codigoconsultora
			FROM LogCargaConsultora
			WHERE NroLote = @NroLote
		)

		UPDATE ConsultoraGeo
		SET Enviado = 1
		WHERE
			Codigo IN (
				SELECT codigoconsultora
				FROM LogCargaConsultora
				WHERE NroLote = @NroLote
			)
			AND
			FuenteIngresoID = 1 AND Estado = 1;
	end

	UPDATE ConsultoraDescarga
	SET FechaFin = @FechaGeneral,
		Estado = @Estado,
		Mensaje = @Mensaje,
		MensajeExcepcion = @MensajeExcepcion,
		NombreArchivo = @NombreArchivo,
		NombreServer = @NombreServer
	WHERE NroLote = @NroLote;
end
go
/*end*/

USE BelcorpMexico
go
alter procedure UpdDatosConsultoraIndicadorEnviado
	@NroLote int,
	@Estado tinyint,
	@Mensaje nvarchar(255),
	@MensajeExcepcion varchar(2000),
	@NombreArchivo varchar(100) = null,
	@NombreServer varchar(100) = null
as
begin
	DECLARE @FechaGeneral DATETIME = dbo.fnObtenerFechaHoraPais();

	if @Estado = 2
	begin
		UPDATE Usuario
		SET Modificado = 0
		WHERE codigoconsultora in (
			SELECT codigoconsultora
			FROM LogCargaConsultora
			WHERE NroLote = @NroLote
		)

		UPDATE ConsultoraGeo
		SET Enviado = 1
		WHERE
			Codigo IN (
				SELECT codigoconsultora
				FROM LogCargaConsultora
				WHERE NroLote = @NroLote
			)
			AND
			FuenteIngresoID = 1 AND Estado = 1;
	end

	UPDATE ConsultoraDescarga
	SET FechaFin = @FechaGeneral,
		Estado = @Estado,
		Mensaje = @Mensaje,
		MensajeExcepcion = @MensajeExcepcion,
		NombreArchivo = @NombreArchivo,
		NombreServer = @NombreServer
	WHERE NroLote = @NroLote;
end
go
/*end*/

USE BelcorpPanama
go
alter procedure UpdDatosConsultoraIndicadorEnviado
	@NroLote int,
	@Estado tinyint,
	@Mensaje nvarchar(255),
	@MensajeExcepcion varchar(2000),
	@NombreArchivo varchar(100) = null,
	@NombreServer varchar(100) = null
as
begin
	DECLARE @FechaGeneral DATETIME = dbo.fnObtenerFechaHoraPais();

	if @Estado = 2
	begin
		UPDATE Usuario
		SET Modificado = 0
		WHERE codigoconsultora in (
			SELECT codigoconsultora
			FROM LogCargaConsultora
			WHERE NroLote = @NroLote
		)

		UPDATE ConsultoraGeo
		SET Enviado = 1
		WHERE
			Codigo IN (
				SELECT codigoconsultora
				FROM LogCargaConsultora
				WHERE NroLote = @NroLote
			)
			AND
			FuenteIngresoID = 1 AND Estado = 1;
	end

	UPDATE ConsultoraDescarga
	SET FechaFin = @FechaGeneral,
		Estado = @Estado,
		Mensaje = @Mensaje,
		MensajeExcepcion = @MensajeExcepcion,
		NombreArchivo = @NombreArchivo,
		NombreServer = @NombreServer
	WHERE NroLote = @NroLote;
end
go
/*end*/

USE BelcorpPeru
go
alter procedure UpdDatosConsultoraIndicadorEnviado
	@NroLote int,
	@Estado tinyint,
	@Mensaje nvarchar(255),
	@MensajeExcepcion varchar(2000),
	@NombreArchivo varchar(100) = null,
	@NombreServer varchar(100) = null
as
begin
	DECLARE @FechaGeneral DATETIME = dbo.fnObtenerFechaHoraPais();

	if @Estado = 2
	begin
		UPDATE Usuario
		SET Modificado = 0
		WHERE codigoconsultora in (
			SELECT codigoconsultora
			FROM LogCargaConsultora
			WHERE NroLote = @NroLote
		)

		UPDATE ConsultoraGeo
		SET Enviado = 1
		WHERE
			Codigo IN (
				SELECT codigoconsultora
				FROM LogCargaConsultora
				WHERE NroLote = @NroLote
			)
			AND
			FuenteIngresoID = 1 AND Estado = 1;
	end

	UPDATE ConsultoraDescarga
	SET FechaFin = @FechaGeneral,
		Estado = @Estado,
		Mensaje = @Mensaje,
		MensajeExcepcion = @MensajeExcepcion,
		NombreArchivo = @NombreArchivo,
		NombreServer = @NombreServer
	WHERE NroLote = @NroLote;
end
go
/*end*/

USE BelcorpPuertoRico
go
alter procedure UpdDatosConsultoraIndicadorEnviado
	@NroLote int,
	@Estado tinyint,
	@Mensaje nvarchar(255),
	@MensajeExcepcion varchar(2000),
	@NombreArchivo varchar(100) = null,
	@NombreServer varchar(100) = null
as
begin
	DECLARE @FechaGeneral DATETIME = dbo.fnObtenerFechaHoraPais();

	if @Estado = 2
	begin
		UPDATE Usuario
		SET Modificado = 0
		WHERE codigoconsultora in (
			SELECT codigoconsultora
			FROM LogCargaConsultora
			WHERE NroLote = @NroLote
		)

		UPDATE ConsultoraGeo
		SET Enviado = 1
		WHERE
			Codigo IN (
				SELECT codigoconsultora
				FROM LogCargaConsultora
				WHERE NroLote = @NroLote
			)
			AND
			FuenteIngresoID = 1 AND Estado = 1;
	end

	UPDATE ConsultoraDescarga
	SET FechaFin = @FechaGeneral,
		Estado = @Estado,
		Mensaje = @Mensaje,
		MensajeExcepcion = @MensajeExcepcion,
		NombreArchivo = @NombreArchivo,
		NombreServer = @NombreServer
	WHERE NroLote = @NroLote;
end
go
/*end*/

USE BelcorpSalvador
go
alter procedure UpdDatosConsultoraIndicadorEnviado
	@NroLote int,
	@Estado tinyint,
	@Mensaje nvarchar(255),
	@MensajeExcepcion varchar(2000),
	@NombreArchivo varchar(100) = null,
	@NombreServer varchar(100) = null
as
begin
	DECLARE @FechaGeneral DATETIME = dbo.fnObtenerFechaHoraPais();

	if @Estado = 2
	begin
		UPDATE Usuario
		SET Modificado = 0
		WHERE codigoconsultora in (
			SELECT codigoconsultora
			FROM LogCargaConsultora
			WHERE NroLote = @NroLote
		)

		UPDATE ConsultoraGeo
		SET Enviado = 1
		WHERE
			Codigo IN (
				SELECT codigoconsultora
				FROM LogCargaConsultora
				WHERE NroLote = @NroLote
			)
			AND
			FuenteIngresoID = 1 AND Estado = 1;
	end

	UPDATE ConsultoraDescarga
	SET FechaFin = @FechaGeneral,
		Estado = @Estado,
		Mensaje = @Mensaje,
		MensajeExcepcion = @MensajeExcepcion,
		NombreArchivo = @NombreArchivo,
		NombreServer = @NombreServer
	WHERE NroLote = @NroLote;
end
go
/*end*/

USE BelcorpVenezuela
go
alter procedure UpdDatosConsultoraIndicadorEnviado
	@NroLote int,
	@Estado tinyint,
	@Mensaje nvarchar(255),
	@MensajeExcepcion varchar(2000),
	@NombreArchivo varchar(100) = null,
	@NombreServer varchar(100) = null
as
begin
	DECLARE @FechaGeneral DATETIME = dbo.fnObtenerFechaHoraPais();

	if @Estado = 2
	begin
		UPDATE Usuario
		SET Modificado = 0
		WHERE codigoconsultora in (
			SELECT codigoconsultora
			FROM LogCargaConsultora
			WHERE NroLote = @NroLote
		)

		UPDATE ConsultoraGeo
		SET Enviado = 1
		WHERE
			Codigo IN (
				SELECT codigoconsultora
				FROM LogCargaConsultora
				WHERE NroLote = @NroLote
			)
			AND
			FuenteIngresoID = 1 AND Estado = 1;
	end

	UPDATE ConsultoraDescarga
	SET FechaFin = @FechaGeneral,
		Estado = @Estado,
		Mensaje = @Mensaje,
		MensajeExcepcion = @MensajeExcepcion,
		NombreArchivo = @NombreArchivo,
		NombreServer = @NombreServer
	WHERE NroLote = @NroLote;
end
go