USE BelcorpBolivia
alter procedure UpdDatosConsultoraIndicadorEnviado
	@NroLote int,
	@Estado tinyint,
	@Mensaje nvarchar(255),
	@NombreArchivo varchar(100) = null,
	@NombreServer varchar(100) = null
as
begin
	DECLARE @FechaGeneral DATETIME
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

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
		NombreArchivo = @NombreArchivo,
		NombreServer = @NombreServer
	WHERE NroLote = @NroLote;
end
go
/*end*/

USE BelcorpChile
alter procedure UpdDatosConsultoraIndicadorEnviado
	@NroLote int,
	@Estado tinyint,
	@Mensaje nvarchar(255),
	@NombreArchivo varchar(100) = null,
	@NombreServer varchar(100) = null
as
begin
	DECLARE @FechaGeneral DATETIME
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

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
		NombreArchivo = @NombreArchivo,
		NombreServer = @NombreServer
	WHERE NroLote = @NroLote;
end
go
/*end*/

USE BelcorpColombia
alter procedure UpdDatosConsultoraIndicadorEnviado
	@NroLote int,
	@Estado tinyint,
	@Mensaje nvarchar(255),
	@NombreArchivo varchar(100) = null,
	@NombreServer varchar(100) = null
as
begin
	DECLARE @FechaGeneral DATETIME
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

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
		NombreArchivo = @NombreArchivo,
		NombreServer = @NombreServer
	WHERE NroLote = @NroLote;
end
go
/*end*/

USE BelcorpCostaRica
alter procedure UpdDatosConsultoraIndicadorEnviado
	@NroLote int,
	@Estado tinyint,
	@Mensaje nvarchar(255),
	@NombreArchivo varchar(100) = null,
	@NombreServer varchar(100) = null
as
begin
	DECLARE @FechaGeneral DATETIME
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

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
		NombreArchivo = @NombreArchivo,
		NombreServer = @NombreServer
	WHERE NroLote = @NroLote;
end
go
/*end*/

USE BelcorpDominicana
alter procedure UpdDatosConsultoraIndicadorEnviado
	@NroLote int,
	@Estado tinyint,
	@Mensaje nvarchar(255),
	@NombreArchivo varchar(100) = null,
	@NombreServer varchar(100) = null
as
begin
	DECLARE @FechaGeneral DATETIME
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

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
		NombreArchivo = @NombreArchivo,
		NombreServer = @NombreServer
	WHERE NroLote = @NroLote;
end
go
/*end*/

USE BelcorpEcuador
alter procedure UpdDatosConsultoraIndicadorEnviado
	@NroLote int,
	@Estado tinyint,
	@Mensaje nvarchar(255),
	@NombreArchivo varchar(100) = null,
	@NombreServer varchar(100) = null
as
begin
	DECLARE @FechaGeneral DATETIME
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

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
		NombreArchivo = @NombreArchivo,
		NombreServer = @NombreServer
	WHERE NroLote = @NroLote;
end
go
/*end*/

USE BelcorpGuatemala
alter procedure UpdDatosConsultoraIndicadorEnviado
	@NroLote int,
	@Estado tinyint,
	@Mensaje nvarchar(255),
	@NombreArchivo varchar(100) = null,
	@NombreServer varchar(100) = null
as
begin
	DECLARE @FechaGeneral DATETIME
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

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
		NombreArchivo = @NombreArchivo,
		NombreServer = @NombreServer
	WHERE NroLote = @NroLote;
end
go
/*end*/

USE BelcorpMexico
alter procedure UpdDatosConsultoraIndicadorEnviado
	@NroLote int,
	@Estado tinyint,
	@Mensaje nvarchar(255),
	@NombreArchivo varchar(100) = null,
	@NombreServer varchar(100) = null
as
begin
	DECLARE @FechaGeneral DATETIME
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

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
		NombreArchivo = @NombreArchivo,
		NombreServer = @NombreServer
	WHERE NroLote = @NroLote;
end
go
/*end*/

USE BelcorpPanama
alter procedure UpdDatosConsultoraIndicadorEnviado
	@NroLote int,
	@Estado tinyint,
	@Mensaje nvarchar(255),
	@NombreArchivo varchar(100) = null,
	@NombreServer varchar(100) = null
as
begin
	DECLARE @FechaGeneral DATETIME
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

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
		NombreArchivo = @NombreArchivo,
		NombreServer = @NombreServer
	WHERE NroLote = @NroLote;
end
go
/*end*/

USE BelcorpPeru
alter procedure UpdDatosConsultoraIndicadorEnviado
	@NroLote int,
	@Estado tinyint,
	@Mensaje nvarchar(255),
	@NombreArchivo varchar(100) = null,
	@NombreServer varchar(100) = null
as
begin
	DECLARE @FechaGeneral DATETIME
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

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
		NombreArchivo = @NombreArchivo,
		NombreServer = @NombreServer
	WHERE NroLote = @NroLote;
end
go
/*end*/

USE BelcorpPuertoRico
alter procedure UpdDatosConsultoraIndicadorEnviado
	@NroLote int,
	@Estado tinyint,
	@Mensaje nvarchar(255),
	@NombreArchivo varchar(100) = null,
	@NombreServer varchar(100) = null
as
begin
	DECLARE @FechaGeneral DATETIME
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

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
		NombreArchivo = @NombreArchivo,
		NombreServer = @NombreServer
	WHERE NroLote = @NroLote;
end
go
/*end*/

USE BelcorpSalvador
alter procedure UpdDatosConsultoraIndicadorEnviado
	@NroLote int,
	@Estado tinyint,
	@Mensaje nvarchar(255),
	@NombreArchivo varchar(100) = null,
	@NombreServer varchar(100) = null
as
begin
	DECLARE @FechaGeneral DATETIME
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

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
		NombreArchivo = @NombreArchivo,
		NombreServer = @NombreServer
	WHERE NroLote = @NroLote;
end
go
/*end*/

USE BelcorpVenezuela
alter procedure UpdDatosConsultoraIndicadorEnviado
	@NroLote int,
	@Estado tinyint,
	@Mensaje nvarchar(255),
	@NombreArchivo varchar(100) = null,
	@NombreServer varchar(100) = null
as
begin
	DECLARE @FechaGeneral DATETIME
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

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
		NombreArchivo = @NombreArchivo,
		NombreServer = @NombreServer
	WHERE NroLote = @NroLote;
end
go