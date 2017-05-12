USE BelcorpBolivia
GO
IF OBJECT_ID('ShowRoom.GetShowRoomConsultoraPersonalizada', 'P') IS NOT NULL
	DROP PROC ShowRoom.GetShowRoomConsultoraPersonalizada
GO
-- ShowRoom.GetShowRoomConsultoraPersonalizada 201705, '007817487'
CREATE PROCEDURE ShowRoom.[GetShowRoomConsultoraPersonalizada]
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(20)
AS
BEGIN

DECLARE @EventoId INT
DECLARE @FechaGeneral DATETIME
DECLARE @IsoPais VARCHAR(5)
DECLARE @Segmento VARCHAR(50)
SET @IsoPais = (select CodigoISO from Pais where EstadoActivo = 1) 
SET @Segmento = (SELECT CONCAT(@IsoPais, '_', @CampaniaID, '_Perfil01'))

IF EXISTS (SELECT 1 FROM  ods.ofertaspersonalizadas op WHERE op.CodConsultora= @CodigoConsultora AND op.AnioCampanaVenta= @CampaniaID 
AND op.TipoPersonalizacion= 'SR')
BEGIN
	--PRINT 'Existe en ofertas personalizadas'
	IF NOT EXISTS(SELECT 1 FROM showroom.eventoconsultora sc WHERE sc.CampaniaID= @CampaniaID AND sc.CodigoConsultora= @CodigoConsultora)
	BEGIN
		--PRINT 'NO Existe en showroom.eventoconsultora, inserta registro en eventoConsultora'

		--Insertar en ShowRoom.EventoConsultora EsGenerica = 0
		SET @EventoId = (SELECT TOP 1 EventoID FROM ShowRoom.Evento where CampaniaID = @CampaniaID)
		SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

		INSERT INTO ShowRoom.EventoConsultora(EventoID, CampaniaID, CodigoConsultora, Segmento, MostrarPopup, FechaCreacion, UsuarioCreacion, 
			FechaModificacion, UsuarioModificacion, MostrarPopupVenta, EsGenerica)
		VALUES (@EventoId, @CampaniaID, @CodigoConsultora, @Segmento, 1, @FechaGeneral, 'ADMCONTENIDO', @FechaGeneral, 'ADMCONTENIDO', 1, 0)
	END

	SELECT TOP 1 EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,MostrarPopup,
			MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,
			Suscripcion,Envio,CorreoEnvioAviso,EsGenerica
		FROM ShowRoom.EventoConsultora
		WHERE CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
		ORDER BY FechaCreacion DESC
END
ELSE
BEGIN
	--PRINT 'NO Existe en ofertas personalizadas'
	--Buscar el valor generico
	DECLARE @ConsultoraGenerica VARCHAR(50) = ''
	SELECT @ConsultoraGenerica = Codigo FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10001

	IF EXISTS(SELECT 1 FROM  ods.ofertaspersonalizadas op WHERE op.CodConsultora= @ConsultoraGenerica AND op.AnioCampanaVenta= @CampaniaID 
		AND op.TipoPersonalizacion= 'SR')
	BEGIN
		--PRINT 'Generico existe en ofertas personalizadas'
		IF NOT EXISTS(SELECT 1 FROM showroom.eventoconsultora sc WHERE sc.CampaniaID= @CampaniaID AND sc.CodigoConsultora= @ConsultoraGenerica)
		BEGIN
			--PRINT 'Generico NO existe en showroom.eventoconsultora, inserta registro en eventoConsultora'
			SET @EventoId = (SELECT TOP 1 EventoID FROM ShowRoom.Evento where CampaniaID = @CampaniaID)
			SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

			--insertar esGenerica = 1
			INSERT INTO ShowRoom.EventoConsultora(EventoID, CampaniaID, CodigoConsultora, Segmento, MostrarPopup, FechaCreacion, UsuarioCreacion, 
					FechaModificacion, UsuarioModificacion, MostrarPopupVenta, EsGenerica)
			VALUES (@EventoId, @CampaniaID, @CodigoConsultora, @Segmento, 1, @FechaGeneral, 'ADMCONTENIDO', @FechaGeneral, 'ADMCONTENIDO', 1, 1)
		END
	END

	--retornar el resultado usando el codigo generico
	SELECT TOP 1 EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,MostrarPopup,
		MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,
		Suscripcion,Envio,CorreoEnvioAviso,EsGenerica
	FROM ShowRoom.EventoConsultora
	WHERE CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
	ORDER BY FechaCreacion DESC
END
END

GO

USE BelcorpCostaRica
GO
IF OBJECT_ID('ShowRoom.GetShowRoomConsultoraPersonalizada', 'P') IS NOT NULL
	DROP PROC ShowRoom.GetShowRoomConsultoraPersonalizada
GO
-- ShowRoom.GetShowRoomConsultoraPersonalizada 201705, '007817487'
CREATE PROCEDURE ShowRoom.[GetShowRoomConsultoraPersonalizada]
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(20)
AS
BEGIN

DECLARE @EventoId INT
DECLARE @FechaGeneral DATETIME
DECLARE @IsoPais VARCHAR(5)
DECLARE @Segmento VARCHAR(50)
SET @IsoPais = (select CodigoISO from Pais where EstadoActivo = 1) 
SET @Segmento = (SELECT CONCAT(@IsoPais, '_', @CampaniaID, '_Perfil01'))

IF EXISTS (SELECT 1 FROM  ods.ofertaspersonalizadas op WHERE op.CodConsultora= @CodigoConsultora AND op.AnioCampanaVenta= @CampaniaID 
AND op.TipoPersonalizacion= 'SR')
BEGIN
	--PRINT 'Existe en ofertas personalizadas'
	IF NOT EXISTS(SELECT 1 FROM showroom.eventoconsultora sc WHERE sc.CampaniaID= @CampaniaID AND sc.CodigoConsultora= @CodigoConsultora)
	BEGIN
		--PRINT 'NO Existe en showroom.eventoconsultora, inserta registro en eventoConsultora'

		--Insertar en ShowRoom.EventoConsultora EsGenerica = 0
		SET @EventoId = (SELECT TOP 1 EventoID FROM ShowRoom.Evento where CampaniaID = @CampaniaID)
		SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

		INSERT INTO ShowRoom.EventoConsultora(EventoID, CampaniaID, CodigoConsultora, Segmento, MostrarPopup, FechaCreacion, UsuarioCreacion, 
			FechaModificacion, UsuarioModificacion, MostrarPopupVenta, EsGenerica)
		VALUES (@EventoId, @CampaniaID, @CodigoConsultora, @Segmento, 1, @FechaGeneral, 'ADMCONTENIDO', @FechaGeneral, 'ADMCONTENIDO', 1, 0)
	END

	SELECT TOP 1 EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,MostrarPopup,
			MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,
			Suscripcion,Envio,CorreoEnvioAviso,EsGenerica
		FROM ShowRoom.EventoConsultora
		WHERE CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
		ORDER BY FechaCreacion DESC
END
ELSE
BEGIN
	--PRINT 'NO Existe en ofertas personalizadas'
	--Buscar el valor generico
	DECLARE @ConsultoraGenerica VARCHAR(50) = ''
	SELECT @ConsultoraGenerica = Codigo FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10001

	IF EXISTS(SELECT 1 FROM  ods.ofertaspersonalizadas op WHERE op.CodConsultora= @ConsultoraGenerica AND op.AnioCampanaVenta= @CampaniaID 
		AND op.TipoPersonalizacion= 'SR')
	BEGIN
		--PRINT 'Generico existe en ofertas personalizadas'
		IF NOT EXISTS(SELECT 1 FROM showroom.eventoconsultora sc WHERE sc.CampaniaID= @CampaniaID AND sc.CodigoConsultora= @ConsultoraGenerica)
		BEGIN
			--PRINT 'Generico NO existe en showroom.eventoconsultora, inserta registro en eventoConsultora'
			SET @EventoId = (SELECT TOP 1 EventoID FROM ShowRoom.Evento where CampaniaID = @CampaniaID)
			SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

			--insertar esGenerica = 1
			INSERT INTO ShowRoom.EventoConsultora(EventoID, CampaniaID, CodigoConsultora, Segmento, MostrarPopup, FechaCreacion, UsuarioCreacion, 
					FechaModificacion, UsuarioModificacion, MostrarPopupVenta, EsGenerica)
			VALUES (@EventoId, @CampaniaID, @CodigoConsultora, @Segmento, 1, @FechaGeneral, 'ADMCONTENIDO', @FechaGeneral, 'ADMCONTENIDO', 1, 1)
		END
	END

	--retornar el resultado usando el codigo generico
	SELECT TOP 1 EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,MostrarPopup,
		MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,
		Suscripcion,Envio,CorreoEnvioAviso,EsGenerica
	FROM ShowRoom.EventoConsultora
	WHERE CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
	ORDER BY FechaCreacion DESC
END
END

GO

USE BelcorpChile
GO
IF OBJECT_ID('ShowRoom.GetShowRoomConsultoraPersonalizada', 'P') IS NOT NULL
	DROP PROC ShowRoom.GetShowRoomConsultoraPersonalizada
GO
-- ShowRoom.GetShowRoomConsultoraPersonalizada 201705, '007817487'
CREATE PROCEDURE ShowRoom.[GetShowRoomConsultoraPersonalizada]
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(20)
AS
BEGIN

DECLARE @EventoId INT
DECLARE @FechaGeneral DATETIME
DECLARE @IsoPais VARCHAR(5)
DECLARE @Segmento VARCHAR(50)
SET @IsoPais = (select CodigoISO from Pais where EstadoActivo = 1) 
SET @Segmento = (SELECT CONCAT(@IsoPais, '_', @CampaniaID, '_Perfil01'))

IF EXISTS (SELECT 1 FROM  ods.ofertaspersonalizadas op WHERE op.CodConsultora= @CodigoConsultora AND op.AnioCampanaVenta= @CampaniaID 
AND op.TipoPersonalizacion= 'SR')
BEGIN
	--PRINT 'Existe en ofertas personalizadas'
	IF NOT EXISTS(SELECT 1 FROM showroom.eventoconsultora sc WHERE sc.CampaniaID= @CampaniaID AND sc.CodigoConsultora= @CodigoConsultora)
	BEGIN
		--PRINT 'NO Existe en showroom.eventoconsultora, inserta registro en eventoConsultora'

		--Insertar en ShowRoom.EventoConsultora EsGenerica = 0
		SET @EventoId = (SELECT TOP 1 EventoID FROM ShowRoom.Evento where CampaniaID = @CampaniaID)
		SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

		INSERT INTO ShowRoom.EventoConsultora(EventoID, CampaniaID, CodigoConsultora, Segmento, MostrarPopup, FechaCreacion, UsuarioCreacion, 
			FechaModificacion, UsuarioModificacion, MostrarPopupVenta, EsGenerica)
		VALUES (@EventoId, @CampaniaID, @CodigoConsultora, @Segmento, 1, @FechaGeneral, 'ADMCONTENIDO', @FechaGeneral, 'ADMCONTENIDO', 1, 0)
	END

	SELECT TOP 1 EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,MostrarPopup,
			MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,
			Suscripcion,Envio,CorreoEnvioAviso,EsGenerica
		FROM ShowRoom.EventoConsultora
		WHERE CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
		ORDER BY FechaCreacion DESC
END
ELSE
BEGIN
	--PRINT 'NO Existe en ofertas personalizadas'
	--Buscar el valor generico
	DECLARE @ConsultoraGenerica VARCHAR(50) = ''
	SELECT @ConsultoraGenerica = Codigo FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10001

	IF EXISTS(SELECT 1 FROM  ods.ofertaspersonalizadas op WHERE op.CodConsultora= @ConsultoraGenerica AND op.AnioCampanaVenta= @CampaniaID 
		AND op.TipoPersonalizacion= 'SR')
	BEGIN
		--PRINT 'Generico existe en ofertas personalizadas'
		IF NOT EXISTS(SELECT 1 FROM showroom.eventoconsultora sc WHERE sc.CampaniaID= @CampaniaID AND sc.CodigoConsultora= @ConsultoraGenerica)
		BEGIN
			--PRINT 'Generico NO existe en showroom.eventoconsultora, inserta registro en eventoConsultora'
			SET @EventoId = (SELECT TOP 1 EventoID FROM ShowRoom.Evento where CampaniaID = @CampaniaID)
			SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

			--insertar esGenerica = 1
			INSERT INTO ShowRoom.EventoConsultora(EventoID, CampaniaID, CodigoConsultora, Segmento, MostrarPopup, FechaCreacion, UsuarioCreacion, 
					FechaModificacion, UsuarioModificacion, MostrarPopupVenta, EsGenerica)
			VALUES (@EventoId, @CampaniaID, @CodigoConsultora, @Segmento, 1, @FechaGeneral, 'ADMCONTENIDO', @FechaGeneral, 'ADMCONTENIDO', 1, 1)
		END
	END

	--retornar el resultado usando el codigo generico
	SELECT TOP 1 EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,MostrarPopup,
		MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,
		Suscripcion,Envio,CorreoEnvioAviso,EsGenerica
	FROM ShowRoom.EventoConsultora
	WHERE CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
	ORDER BY FechaCreacion DESC
END
END

GO

USE BelcorpColombia
GO
IF OBJECT_ID('ShowRoom.GetShowRoomConsultoraPersonalizada', 'P') IS NOT NULL
	DROP PROC ShowRoom.GetShowRoomConsultoraPersonalizada
GO
-- ShowRoom.GetShowRoomConsultoraPersonalizada 201705, '007817487'
CREATE PROCEDURE ShowRoom.[GetShowRoomConsultoraPersonalizada]
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(20)
AS
BEGIN

DECLARE @EventoId INT
DECLARE @FechaGeneral DATETIME
DECLARE @IsoPais VARCHAR(5)
DECLARE @Segmento VARCHAR(50)
SET @IsoPais = (select CodigoISO from Pais where EstadoActivo = 1) 
SET @Segmento = (SELECT CONCAT(@IsoPais, '_', @CampaniaID, '_Perfil01'))

IF EXISTS (SELECT 1 FROM  ods.ofertaspersonalizadas op WHERE op.CodConsultora= @CodigoConsultora AND op.AnioCampanaVenta= @CampaniaID 
AND op.TipoPersonalizacion= 'SR')
BEGIN
	--PRINT 'Existe en ofertas personalizadas'
	IF NOT EXISTS(SELECT 1 FROM showroom.eventoconsultora sc WHERE sc.CampaniaID= @CampaniaID AND sc.CodigoConsultora= @CodigoConsultora)
	BEGIN
		--PRINT 'NO Existe en showroom.eventoconsultora, inserta registro en eventoConsultora'

		--Insertar en ShowRoom.EventoConsultora EsGenerica = 0
		SET @EventoId = (SELECT TOP 1 EventoID FROM ShowRoom.Evento where CampaniaID = @CampaniaID)
		SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

		INSERT INTO ShowRoom.EventoConsultora(EventoID, CampaniaID, CodigoConsultora, Segmento, MostrarPopup, FechaCreacion, UsuarioCreacion, 
			FechaModificacion, UsuarioModificacion, MostrarPopupVenta, EsGenerica)
		VALUES (@EventoId, @CampaniaID, @CodigoConsultora, @Segmento, 1, @FechaGeneral, 'ADMCONTENIDO', @FechaGeneral, 'ADMCONTENIDO', 1, 0)
	END

	SELECT TOP 1 EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,MostrarPopup,
			MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,
			Suscripcion,Envio,CorreoEnvioAviso,EsGenerica
		FROM ShowRoom.EventoConsultora
		WHERE CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
		ORDER BY FechaCreacion DESC
END
ELSE
BEGIN
	--PRINT 'NO Existe en ofertas personalizadas'
	--Buscar el valor generico
	DECLARE @ConsultoraGenerica VARCHAR(50) = ''
	SELECT @ConsultoraGenerica = Codigo FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10001

	IF EXISTS(SELECT 1 FROM  ods.ofertaspersonalizadas op WHERE op.CodConsultora= @ConsultoraGenerica AND op.AnioCampanaVenta= @CampaniaID 
		AND op.TipoPersonalizacion= 'SR')
	BEGIN
		--PRINT 'Generico existe en ofertas personalizadas'
		IF NOT EXISTS(SELECT 1 FROM showroom.eventoconsultora sc WHERE sc.CampaniaID= @CampaniaID AND sc.CodigoConsultora= @ConsultoraGenerica)
		BEGIN
			--PRINT 'Generico NO existe en showroom.eventoconsultora, inserta registro en eventoConsultora'
			SET @EventoId = (SELECT TOP 1 EventoID FROM ShowRoom.Evento where CampaniaID = @CampaniaID)
			SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

			--insertar esGenerica = 1
			INSERT INTO ShowRoom.EventoConsultora(EventoID, CampaniaID, CodigoConsultora, Segmento, MostrarPopup, FechaCreacion, UsuarioCreacion, 
					FechaModificacion, UsuarioModificacion, MostrarPopupVenta, EsGenerica)
			VALUES (@EventoId, @CampaniaID, @CodigoConsultora, @Segmento, 1, @FechaGeneral, 'ADMCONTENIDO', @FechaGeneral, 'ADMCONTENIDO', 1, 1)
		END
	END

	--retornar el resultado usando el codigo generico
	SELECT TOP 1 EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,MostrarPopup,
		MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,
		Suscripcion,Envio,CorreoEnvioAviso,EsGenerica
	FROM ShowRoom.EventoConsultora
	WHERE CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
	ORDER BY FechaCreacion DESC
END
END

GO

USE BelcorpDominicana
GO
IF OBJECT_ID('ShowRoom.GetShowRoomConsultoraPersonalizada', 'P') IS NOT NULL
	DROP PROC ShowRoom.GetShowRoomConsultoraPersonalizada
GO
-- ShowRoom.GetShowRoomConsultoraPersonalizada 201705, '007817487'
CREATE PROCEDURE ShowRoom.[GetShowRoomConsultoraPersonalizada]
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(20)
AS
BEGIN

DECLARE @EventoId INT
DECLARE @FechaGeneral DATETIME
DECLARE @IsoPais VARCHAR(5)
DECLARE @Segmento VARCHAR(50)
SET @IsoPais = (select CodigoISO from Pais where EstadoActivo = 1) 
SET @Segmento = (SELECT CONCAT(@IsoPais, '_', @CampaniaID, '_Perfil01'))

IF EXISTS (SELECT 1 FROM  ods.ofertaspersonalizadas op WHERE op.CodConsultora= @CodigoConsultora AND op.AnioCampanaVenta= @CampaniaID 
AND op.TipoPersonalizacion= 'SR')
BEGIN
	--PRINT 'Existe en ofertas personalizadas'
	IF NOT EXISTS(SELECT 1 FROM showroom.eventoconsultora sc WHERE sc.CampaniaID= @CampaniaID AND sc.CodigoConsultora= @CodigoConsultora)
	BEGIN
		--PRINT 'NO Existe en showroom.eventoconsultora, inserta registro en eventoConsultora'

		--Insertar en ShowRoom.EventoConsultora EsGenerica = 0
		SET @EventoId = (SELECT TOP 1 EventoID FROM ShowRoom.Evento where CampaniaID = @CampaniaID)
		SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

		INSERT INTO ShowRoom.EventoConsultora(EventoID, CampaniaID, CodigoConsultora, Segmento, MostrarPopup, FechaCreacion, UsuarioCreacion, 
			FechaModificacion, UsuarioModificacion, MostrarPopupVenta, EsGenerica)
		VALUES (@EventoId, @CampaniaID, @CodigoConsultora, @Segmento, 1, @FechaGeneral, 'ADMCONTENIDO', @FechaGeneral, 'ADMCONTENIDO', 1, 0)
	END

	SELECT TOP 1 EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,MostrarPopup,
			MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,
			Suscripcion,Envio,CorreoEnvioAviso,EsGenerica
		FROM ShowRoom.EventoConsultora
		WHERE CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
		ORDER BY FechaCreacion DESC
END
ELSE
BEGIN
	--PRINT 'NO Existe en ofertas personalizadas'
	--Buscar el valor generico
	DECLARE @ConsultoraGenerica VARCHAR(50) = ''
	SELECT @ConsultoraGenerica = Codigo FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10001

	IF EXISTS(SELECT 1 FROM  ods.ofertaspersonalizadas op WHERE op.CodConsultora= @ConsultoraGenerica AND op.AnioCampanaVenta= @CampaniaID 
		AND op.TipoPersonalizacion= 'SR')
	BEGIN
		--PRINT 'Generico existe en ofertas personalizadas'
		IF NOT EXISTS(SELECT 1 FROM showroom.eventoconsultora sc WHERE sc.CampaniaID= @CampaniaID AND sc.CodigoConsultora= @ConsultoraGenerica)
		BEGIN
			--PRINT 'Generico NO existe en showroom.eventoconsultora, inserta registro en eventoConsultora'
			SET @EventoId = (SELECT TOP 1 EventoID FROM ShowRoom.Evento where CampaniaID = @CampaniaID)
			SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

			--insertar esGenerica = 1
			INSERT INTO ShowRoom.EventoConsultora(EventoID, CampaniaID, CodigoConsultora, Segmento, MostrarPopup, FechaCreacion, UsuarioCreacion, 
					FechaModificacion, UsuarioModificacion, MostrarPopupVenta, EsGenerica)
			VALUES (@EventoId, @CampaniaID, @CodigoConsultora, @Segmento, 1, @FechaGeneral, 'ADMCONTENIDO', @FechaGeneral, 'ADMCONTENIDO', 1, 1)
		END
	END

	--retornar el resultado usando el codigo generico
	SELECT TOP 1 EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,MostrarPopup,
		MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,
		Suscripcion,Envio,CorreoEnvioAviso,EsGenerica
	FROM ShowRoom.EventoConsultora
	WHERE CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
	ORDER BY FechaCreacion DESC
END
END

GO

USE BelcorpEcuador
GO
IF OBJECT_ID('ShowRoom.GetShowRoomConsultoraPersonalizada', 'P') IS NOT NULL
	DROP PROC ShowRoom.GetShowRoomConsultoraPersonalizada
GO
-- ShowRoom.GetShowRoomConsultoraPersonalizada 201705, '007817487'
CREATE PROCEDURE ShowRoom.[GetShowRoomConsultoraPersonalizada]
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(20)
AS
BEGIN

DECLARE @EventoId INT
DECLARE @FechaGeneral DATETIME
DECLARE @IsoPais VARCHAR(5)
DECLARE @Segmento VARCHAR(50)
SET @IsoPais = (select CodigoISO from Pais where EstadoActivo = 1) 
SET @Segmento = (SELECT CONCAT(@IsoPais, '_', @CampaniaID, '_Perfil01'))

IF EXISTS (SELECT 1 FROM  ods.ofertaspersonalizadas op WHERE op.CodConsultora= @CodigoConsultora AND op.AnioCampanaVenta= @CampaniaID 
AND op.TipoPersonalizacion= 'SR')
BEGIN
	--PRINT 'Existe en ofertas personalizadas'
	IF NOT EXISTS(SELECT 1 FROM showroom.eventoconsultora sc WHERE sc.CampaniaID= @CampaniaID AND sc.CodigoConsultora= @CodigoConsultora)
	BEGIN
		--PRINT 'NO Existe en showroom.eventoconsultora, inserta registro en eventoConsultora'

		--Insertar en ShowRoom.EventoConsultora EsGenerica = 0
		SET @EventoId = (SELECT TOP 1 EventoID FROM ShowRoom.Evento where CampaniaID = @CampaniaID)
		SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

		INSERT INTO ShowRoom.EventoConsultora(EventoID, CampaniaID, CodigoConsultora, Segmento, MostrarPopup, FechaCreacion, UsuarioCreacion, 
			FechaModificacion, UsuarioModificacion, MostrarPopupVenta, EsGenerica)
		VALUES (@EventoId, @CampaniaID, @CodigoConsultora, @Segmento, 1, @FechaGeneral, 'ADMCONTENIDO', @FechaGeneral, 'ADMCONTENIDO', 1, 0)
	END

	SELECT TOP 1 EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,MostrarPopup,
			MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,
			Suscripcion,Envio,CorreoEnvioAviso,EsGenerica
		FROM ShowRoom.EventoConsultora
		WHERE CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
		ORDER BY FechaCreacion DESC
END
ELSE
BEGIN
	--PRINT 'NO Existe en ofertas personalizadas'
	--Buscar el valor generico
	DECLARE @ConsultoraGenerica VARCHAR(50) = ''
	SELECT @ConsultoraGenerica = Codigo FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10001

	IF EXISTS(SELECT 1 FROM  ods.ofertaspersonalizadas op WHERE op.CodConsultora= @ConsultoraGenerica AND op.AnioCampanaVenta= @CampaniaID 
		AND op.TipoPersonalizacion= 'SR')
	BEGIN
		--PRINT 'Generico existe en ofertas personalizadas'
		IF NOT EXISTS(SELECT 1 FROM showroom.eventoconsultora sc WHERE sc.CampaniaID= @CampaniaID AND sc.CodigoConsultora= @ConsultoraGenerica)
		BEGIN
			--PRINT 'Generico NO existe en showroom.eventoconsultora, inserta registro en eventoConsultora'
			SET @EventoId = (SELECT TOP 1 EventoID FROM ShowRoom.Evento where CampaniaID = @CampaniaID)
			SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

			--insertar esGenerica = 1
			INSERT INTO ShowRoom.EventoConsultora(EventoID, CampaniaID, CodigoConsultora, Segmento, MostrarPopup, FechaCreacion, UsuarioCreacion, 
					FechaModificacion, UsuarioModificacion, MostrarPopupVenta, EsGenerica)
			VALUES (@EventoId, @CampaniaID, @CodigoConsultora, @Segmento, 1, @FechaGeneral, 'ADMCONTENIDO', @FechaGeneral, 'ADMCONTENIDO', 1, 1)
		END
	END

	--retornar el resultado usando el codigo generico
	SELECT TOP 1 EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,MostrarPopup,
		MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,
		Suscripcion,Envio,CorreoEnvioAviso,EsGenerica
	FROM ShowRoom.EventoConsultora
	WHERE CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
	ORDER BY FechaCreacion DESC
END
END

GO

USE BelcorpGuatemala
GO
IF OBJECT_ID('ShowRoom.GetShowRoomConsultoraPersonalizada', 'P') IS NOT NULL
	DROP PROC ShowRoom.GetShowRoomConsultoraPersonalizada
GO
-- ShowRoom.GetShowRoomConsultoraPersonalizada 201705, '007817487'
CREATE PROCEDURE ShowRoom.[GetShowRoomConsultoraPersonalizada]
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(20)
AS
BEGIN

DECLARE @EventoId INT
DECLARE @FechaGeneral DATETIME
DECLARE @IsoPais VARCHAR(5)
DECLARE @Segmento VARCHAR(50)
SET @IsoPais = (select CodigoISO from Pais where EstadoActivo = 1) 
SET @Segmento = (SELECT CONCAT(@IsoPais, '_', @CampaniaID, '_Perfil01'))

IF EXISTS (SELECT 1 FROM  ods.ofertaspersonalizadas op WHERE op.CodConsultora= @CodigoConsultora AND op.AnioCampanaVenta= @CampaniaID 
AND op.TipoPersonalizacion= 'SR')
BEGIN
	--PRINT 'Existe en ofertas personalizadas'
	IF NOT EXISTS(SELECT 1 FROM showroom.eventoconsultora sc WHERE sc.CampaniaID= @CampaniaID AND sc.CodigoConsultora= @CodigoConsultora)
	BEGIN
		--PRINT 'NO Existe en showroom.eventoconsultora, inserta registro en eventoConsultora'

		--Insertar en ShowRoom.EventoConsultora EsGenerica = 0
		SET @EventoId = (SELECT TOP 1 EventoID FROM ShowRoom.Evento where CampaniaID = @CampaniaID)
		SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

		INSERT INTO ShowRoom.EventoConsultora(EventoID, CampaniaID, CodigoConsultora, Segmento, MostrarPopup, FechaCreacion, UsuarioCreacion, 
			FechaModificacion, UsuarioModificacion, MostrarPopupVenta, EsGenerica)
		VALUES (@EventoId, @CampaniaID, @CodigoConsultora, @Segmento, 1, @FechaGeneral, 'ADMCONTENIDO', @FechaGeneral, 'ADMCONTENIDO', 1, 0)
	END

	SELECT TOP 1 EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,MostrarPopup,
			MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,
			Suscripcion,Envio,CorreoEnvioAviso,EsGenerica
		FROM ShowRoom.EventoConsultora
		WHERE CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
		ORDER BY FechaCreacion DESC
END
ELSE
BEGIN
	--PRINT 'NO Existe en ofertas personalizadas'
	--Buscar el valor generico
	DECLARE @ConsultoraGenerica VARCHAR(50) = ''
	SELECT @ConsultoraGenerica = Codigo FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10001

	IF EXISTS(SELECT 1 FROM  ods.ofertaspersonalizadas op WHERE op.CodConsultora= @ConsultoraGenerica AND op.AnioCampanaVenta= @CampaniaID 
		AND op.TipoPersonalizacion= 'SR')
	BEGIN
		--PRINT 'Generico existe en ofertas personalizadas'
		IF NOT EXISTS(SELECT 1 FROM showroom.eventoconsultora sc WHERE sc.CampaniaID= @CampaniaID AND sc.CodigoConsultora= @ConsultoraGenerica)
		BEGIN
			--PRINT 'Generico NO existe en showroom.eventoconsultora, inserta registro en eventoConsultora'
			SET @EventoId = (SELECT TOP 1 EventoID FROM ShowRoom.Evento where CampaniaID = @CampaniaID)
			SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

			--insertar esGenerica = 1
			INSERT INTO ShowRoom.EventoConsultora(EventoID, CampaniaID, CodigoConsultora, Segmento, MostrarPopup, FechaCreacion, UsuarioCreacion, 
					FechaModificacion, UsuarioModificacion, MostrarPopupVenta, EsGenerica)
			VALUES (@EventoId, @CampaniaID, @CodigoConsultora, @Segmento, 1, @FechaGeneral, 'ADMCONTENIDO', @FechaGeneral, 'ADMCONTENIDO', 1, 1)
		END
	END

	--retornar el resultado usando el codigo generico
	SELECT TOP 1 EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,MostrarPopup,
		MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,
		Suscripcion,Envio,CorreoEnvioAviso,EsGenerica
	FROM ShowRoom.EventoConsultora
	WHERE CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
	ORDER BY FechaCreacion DESC
END
END

GO

USE BelcorpMexico
GO
IF OBJECT_ID('ShowRoom.GetShowRoomConsultoraPersonalizada', 'P') IS NOT NULL
	DROP PROC ShowRoom.GetShowRoomConsultoraPersonalizada
GO
-- ShowRoom.GetShowRoomConsultoraPersonalizada 201705, '007817487'
CREATE PROCEDURE ShowRoom.[GetShowRoomConsultoraPersonalizada]
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(20)
AS
BEGIN

DECLARE @EventoId INT
DECLARE @FechaGeneral DATETIME
DECLARE @IsoPais VARCHAR(5)
DECLARE @Segmento VARCHAR(50)
SET @IsoPais = (select CodigoISO from Pais where EstadoActivo = 1) 
SET @Segmento = (SELECT CONCAT(@IsoPais, '_', @CampaniaID, '_Perfil01'))

IF EXISTS (SELECT 1 FROM  ods.ofertaspersonalizadas op WHERE op.CodConsultora= @CodigoConsultora AND op.AnioCampanaVenta= @CampaniaID 
AND op.TipoPersonalizacion= 'SR')
BEGIN
	--PRINT 'Existe en ofertas personalizadas'
	IF NOT EXISTS(SELECT 1 FROM showroom.eventoconsultora sc WHERE sc.CampaniaID= @CampaniaID AND sc.CodigoConsultora= @CodigoConsultora)
	BEGIN
		--PRINT 'NO Existe en showroom.eventoconsultora, inserta registro en eventoConsultora'

		--Insertar en ShowRoom.EventoConsultora EsGenerica = 0
		SET @EventoId = (SELECT TOP 1 EventoID FROM ShowRoom.Evento where CampaniaID = @CampaniaID)
		SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

		INSERT INTO ShowRoom.EventoConsultora(EventoID, CampaniaID, CodigoConsultora, Segmento, MostrarPopup, FechaCreacion, UsuarioCreacion, 
			FechaModificacion, UsuarioModificacion, MostrarPopupVenta, EsGenerica)
		VALUES (@EventoId, @CampaniaID, @CodigoConsultora, @Segmento, 1, @FechaGeneral, 'ADMCONTENIDO', @FechaGeneral, 'ADMCONTENIDO', 1, 0)
	END

	SELECT TOP 1 EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,MostrarPopup,
			MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,
			Suscripcion,Envio,CorreoEnvioAviso,EsGenerica
		FROM ShowRoom.EventoConsultora
		WHERE CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
		ORDER BY FechaCreacion DESC
END
ELSE
BEGIN
	--PRINT 'NO Existe en ofertas personalizadas'
	--Buscar el valor generico
	DECLARE @ConsultoraGenerica VARCHAR(50) = ''
	SELECT @ConsultoraGenerica = Codigo FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10001

	IF EXISTS(SELECT 1 FROM  ods.ofertaspersonalizadas op WHERE op.CodConsultora= @ConsultoraGenerica AND op.AnioCampanaVenta= @CampaniaID 
		AND op.TipoPersonalizacion= 'SR')
	BEGIN
		--PRINT 'Generico existe en ofertas personalizadas'
		IF NOT EXISTS(SELECT 1 FROM showroom.eventoconsultora sc WHERE sc.CampaniaID= @CampaniaID AND sc.CodigoConsultora= @ConsultoraGenerica)
		BEGIN
			--PRINT 'Generico NO existe en showroom.eventoconsultora, inserta registro en eventoConsultora'
			SET @EventoId = (SELECT TOP 1 EventoID FROM ShowRoom.Evento where CampaniaID = @CampaniaID)
			SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

			--insertar esGenerica = 1
			INSERT INTO ShowRoom.EventoConsultora(EventoID, CampaniaID, CodigoConsultora, Segmento, MostrarPopup, FechaCreacion, UsuarioCreacion, 
					FechaModificacion, UsuarioModificacion, MostrarPopupVenta, EsGenerica)
			VALUES (@EventoId, @CampaniaID, @CodigoConsultora, @Segmento, 1, @FechaGeneral, 'ADMCONTENIDO', @FechaGeneral, 'ADMCONTENIDO', 1, 1)
		END
	END

	--retornar el resultado usando el codigo generico
	SELECT TOP 1 EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,MostrarPopup,
		MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,
		Suscripcion,Envio,CorreoEnvioAviso,EsGenerica
	FROM ShowRoom.EventoConsultora
	WHERE CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
	ORDER BY FechaCreacion DESC
END
END

GO

USE BelcorpPanama
GO
IF OBJECT_ID('ShowRoom.GetShowRoomConsultoraPersonalizada', 'P') IS NOT NULL
	DROP PROC ShowRoom.GetShowRoomConsultoraPersonalizada
GO
-- ShowRoom.GetShowRoomConsultoraPersonalizada 201705, '007817487'
CREATE PROCEDURE ShowRoom.[GetShowRoomConsultoraPersonalizada]
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(20)
AS
BEGIN

DECLARE @EventoId INT
DECLARE @FechaGeneral DATETIME
DECLARE @IsoPais VARCHAR(5)
DECLARE @Segmento VARCHAR(50)
SET @IsoPais = (select CodigoISO from Pais where EstadoActivo = 1) 
SET @Segmento = (SELECT CONCAT(@IsoPais, '_', @CampaniaID, '_Perfil01'))

IF EXISTS (SELECT 1 FROM  ods.ofertaspersonalizadas op WHERE op.CodConsultora= @CodigoConsultora AND op.AnioCampanaVenta= @CampaniaID 
AND op.TipoPersonalizacion= 'SR')
BEGIN
	--PRINT 'Existe en ofertas personalizadas'
	IF NOT EXISTS(SELECT 1 FROM showroom.eventoconsultora sc WHERE sc.CampaniaID= @CampaniaID AND sc.CodigoConsultora= @CodigoConsultora)
	BEGIN
		--PRINT 'NO Existe en showroom.eventoconsultora, inserta registro en eventoConsultora'

		--Insertar en ShowRoom.EventoConsultora EsGenerica = 0
		SET @EventoId = (SELECT TOP 1 EventoID FROM ShowRoom.Evento where CampaniaID = @CampaniaID)
		SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

		INSERT INTO ShowRoom.EventoConsultora(EventoID, CampaniaID, CodigoConsultora, Segmento, MostrarPopup, FechaCreacion, UsuarioCreacion, 
			FechaModificacion, UsuarioModificacion, MostrarPopupVenta, EsGenerica)
		VALUES (@EventoId, @CampaniaID, @CodigoConsultora, @Segmento, 1, @FechaGeneral, 'ADMCONTENIDO', @FechaGeneral, 'ADMCONTENIDO', 1, 0)
	END

	SELECT TOP 1 EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,MostrarPopup,
			MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,
			Suscripcion,Envio,CorreoEnvioAviso,EsGenerica
		FROM ShowRoom.EventoConsultora
		WHERE CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
		ORDER BY FechaCreacion DESC
END
ELSE
BEGIN
	--PRINT 'NO Existe en ofertas personalizadas'
	--Buscar el valor generico
	DECLARE @ConsultoraGenerica VARCHAR(50) = ''
	SELECT @ConsultoraGenerica = Codigo FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10001

	IF EXISTS(SELECT 1 FROM  ods.ofertaspersonalizadas op WHERE op.CodConsultora= @ConsultoraGenerica AND op.AnioCampanaVenta= @CampaniaID 
		AND op.TipoPersonalizacion= 'SR')
	BEGIN
		--PRINT 'Generico existe en ofertas personalizadas'
		IF NOT EXISTS(SELECT 1 FROM showroom.eventoconsultora sc WHERE sc.CampaniaID= @CampaniaID AND sc.CodigoConsultora= @ConsultoraGenerica)
		BEGIN
			--PRINT 'Generico NO existe en showroom.eventoconsultora, inserta registro en eventoConsultora'
			SET @EventoId = (SELECT TOP 1 EventoID FROM ShowRoom.Evento where CampaniaID = @CampaniaID)
			SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

			--insertar esGenerica = 1
			INSERT INTO ShowRoom.EventoConsultora(EventoID, CampaniaID, CodigoConsultora, Segmento, MostrarPopup, FechaCreacion, UsuarioCreacion, 
					FechaModificacion, UsuarioModificacion, MostrarPopupVenta, EsGenerica)
			VALUES (@EventoId, @CampaniaID, @CodigoConsultora, @Segmento, 1, @FechaGeneral, 'ADMCONTENIDO', @FechaGeneral, 'ADMCONTENIDO', 1, 1)
		END
	END

	--retornar el resultado usando el codigo generico
	SELECT TOP 1 EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,MostrarPopup,
		MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,
		Suscripcion,Envio,CorreoEnvioAviso,EsGenerica
	FROM ShowRoom.EventoConsultora
	WHERE CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
	ORDER BY FechaCreacion DESC
END
END

GO

USE BelcorpPeru
GO
IF OBJECT_ID('ShowRoom.GetShowRoomConsultoraPersonalizada', 'P') IS NOT NULL
	DROP PROC ShowRoom.GetShowRoomConsultoraPersonalizada
GO
-- ShowRoom.GetShowRoomConsultoraPersonalizada 201705, '007817487'
CREATE PROCEDURE ShowRoom.[GetShowRoomConsultoraPersonalizada]
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(20)
AS
BEGIN

DECLARE @EventoId INT
DECLARE @FechaGeneral DATETIME
DECLARE @IsoPais VARCHAR(5)
DECLARE @Segmento VARCHAR(50)
SET @IsoPais = (select CodigoISO from Pais where EstadoActivo = 1) 
SET @Segmento = (SELECT CONCAT(@IsoPais, '_', @CampaniaID, '_Perfil01'))

IF EXISTS (SELECT 1 FROM  ods.ofertaspersonalizadas op WHERE op.CodConsultora= @CodigoConsultora AND op.AnioCampanaVenta= @CampaniaID 
AND op.TipoPersonalizacion= 'SR')
BEGIN
	--PRINT 'Existe en ofertas personalizadas'
	IF NOT EXISTS(SELECT 1 FROM showroom.eventoconsultora sc WHERE sc.CampaniaID= @CampaniaID AND sc.CodigoConsultora= @CodigoConsultora)
	BEGIN
		--PRINT 'NO Existe en showroom.eventoconsultora, inserta registro en eventoConsultora'

		--Insertar en ShowRoom.EventoConsultora EsGenerica = 0
		SET @EventoId = (SELECT TOP 1 EventoID FROM ShowRoom.Evento where CampaniaID = @CampaniaID)
		SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

		INSERT INTO ShowRoom.EventoConsultora(EventoID, CampaniaID, CodigoConsultora, Segmento, MostrarPopup, FechaCreacion, UsuarioCreacion, 
			FechaModificacion, UsuarioModificacion, MostrarPopupVenta, EsGenerica)
		VALUES (@EventoId, @CampaniaID, @CodigoConsultora, @Segmento, 1, @FechaGeneral, 'ADMCONTENIDO', @FechaGeneral, 'ADMCONTENIDO', 1, 0)
	END

	SELECT TOP 1 EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,MostrarPopup,
			MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,
			Suscripcion,Envio,CorreoEnvioAviso,EsGenerica
		FROM ShowRoom.EventoConsultora
		WHERE CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
		ORDER BY FechaCreacion DESC
END
ELSE
BEGIN
	--PRINT 'NO Existe en ofertas personalizadas'
	--Buscar el valor generico
	DECLARE @ConsultoraGenerica VARCHAR(50) = ''
	SELECT @ConsultoraGenerica = Codigo FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10001

	IF EXISTS(SELECT 1 FROM  ods.ofertaspersonalizadas op WHERE op.CodConsultora= @ConsultoraGenerica AND op.AnioCampanaVenta= @CampaniaID 
		AND op.TipoPersonalizacion= 'SR')
	BEGIN
		--PRINT 'Generico existe en ofertas personalizadas'
		IF NOT EXISTS(SELECT 1 FROM showroom.eventoconsultora sc WHERE sc.CampaniaID= @CampaniaID AND sc.CodigoConsultora= @ConsultoraGenerica)
		BEGIN
			--PRINT 'Generico NO existe en showroom.eventoconsultora, inserta registro en eventoConsultora'
			SET @EventoId = (SELECT TOP 1 EventoID FROM ShowRoom.Evento where CampaniaID = @CampaniaID)
			SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

			--insertar esGenerica = 1
			INSERT INTO ShowRoom.EventoConsultora(EventoID, CampaniaID, CodigoConsultora, Segmento, MostrarPopup, FechaCreacion, UsuarioCreacion, 
					FechaModificacion, UsuarioModificacion, MostrarPopupVenta, EsGenerica)
			VALUES (@EventoId, @CampaniaID, @CodigoConsultora, @Segmento, 1, @FechaGeneral, 'ADMCONTENIDO', @FechaGeneral, 'ADMCONTENIDO', 1, 1)
		END
	END

	--retornar el resultado usando el codigo generico
	SELECT TOP 1 EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,MostrarPopup,
		MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,
		Suscripcion,Envio,CorreoEnvioAviso,EsGenerica
	FROM ShowRoom.EventoConsultora
	WHERE CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
	ORDER BY FechaCreacion DESC
END
END

GO

USE BelcorpPuertoRico
GO
IF OBJECT_ID('ShowRoom.GetShowRoomConsultoraPersonalizada', 'P') IS NOT NULL
	DROP PROC ShowRoom.GetShowRoomConsultoraPersonalizada
GO
-- ShowRoom.GetShowRoomConsultoraPersonalizada 201705, '007817487'
CREATE PROCEDURE ShowRoom.[GetShowRoomConsultoraPersonalizada]
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(20)
AS
BEGIN

DECLARE @EventoId INT
DECLARE @FechaGeneral DATETIME
DECLARE @IsoPais VARCHAR(5)
DECLARE @Segmento VARCHAR(50)
SET @IsoPais = (select CodigoISO from Pais where EstadoActivo = 1) 
SET @Segmento = (SELECT CONCAT(@IsoPais, '_', @CampaniaID, '_Perfil01'))

IF EXISTS (SELECT 1 FROM  ods.ofertaspersonalizadas op WHERE op.CodConsultora= @CodigoConsultora AND op.AnioCampanaVenta= @CampaniaID 
AND op.TipoPersonalizacion= 'SR')
BEGIN
	--PRINT 'Existe en ofertas personalizadas'
	IF NOT EXISTS(SELECT 1 FROM showroom.eventoconsultora sc WHERE sc.CampaniaID= @CampaniaID AND sc.CodigoConsultora= @CodigoConsultora)
	BEGIN
		--PRINT 'NO Existe en showroom.eventoconsultora, inserta registro en eventoConsultora'

		--Insertar en ShowRoom.EventoConsultora EsGenerica = 0
		SET @EventoId = (SELECT TOP 1 EventoID FROM ShowRoom.Evento where CampaniaID = @CampaniaID)
		SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

		INSERT INTO ShowRoom.EventoConsultora(EventoID, CampaniaID, CodigoConsultora, Segmento, MostrarPopup, FechaCreacion, UsuarioCreacion, 
			FechaModificacion, UsuarioModificacion, MostrarPopupVenta, EsGenerica)
		VALUES (@EventoId, @CampaniaID, @CodigoConsultora, @Segmento, 1, @FechaGeneral, 'ADMCONTENIDO', @FechaGeneral, 'ADMCONTENIDO', 1, 0)
	END

	SELECT TOP 1 EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,MostrarPopup,
			MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,
			Suscripcion,Envio,CorreoEnvioAviso,EsGenerica
		FROM ShowRoom.EventoConsultora
		WHERE CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
		ORDER BY FechaCreacion DESC
END
ELSE
BEGIN
	--PRINT 'NO Existe en ofertas personalizadas'
	--Buscar el valor generico
	DECLARE @ConsultoraGenerica VARCHAR(50) = ''
	SELECT @ConsultoraGenerica = Codigo FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10001

	IF EXISTS(SELECT 1 FROM  ods.ofertaspersonalizadas op WHERE op.CodConsultora= @ConsultoraGenerica AND op.AnioCampanaVenta= @CampaniaID 
		AND op.TipoPersonalizacion= 'SR')
	BEGIN
		--PRINT 'Generico existe en ofertas personalizadas'
		IF NOT EXISTS(SELECT 1 FROM showroom.eventoconsultora sc WHERE sc.CampaniaID= @CampaniaID AND sc.CodigoConsultora= @ConsultoraGenerica)
		BEGIN
			--PRINT 'Generico NO existe en showroom.eventoconsultora, inserta registro en eventoConsultora'
			SET @EventoId = (SELECT TOP 1 EventoID FROM ShowRoom.Evento where CampaniaID = @CampaniaID)
			SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

			--insertar esGenerica = 1
			INSERT INTO ShowRoom.EventoConsultora(EventoID, CampaniaID, CodigoConsultora, Segmento, MostrarPopup, FechaCreacion, UsuarioCreacion, 
					FechaModificacion, UsuarioModificacion, MostrarPopupVenta, EsGenerica)
			VALUES (@EventoId, @CampaniaID, @CodigoConsultora, @Segmento, 1, @FechaGeneral, 'ADMCONTENIDO', @FechaGeneral, 'ADMCONTENIDO', 1, 1)
		END
	END

	--retornar el resultado usando el codigo generico
	SELECT TOP 1 EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,MostrarPopup,
		MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,
		Suscripcion,Envio,CorreoEnvioAviso,EsGenerica
	FROM ShowRoom.EventoConsultora
	WHERE CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
	ORDER BY FechaCreacion DESC
END
END

GO

USE BelcorpSalvador
GO
IF OBJECT_ID('ShowRoom.GetShowRoomConsultoraPersonalizada', 'P') IS NOT NULL
	DROP PROC ShowRoom.GetShowRoomConsultoraPersonalizada
GO
-- ShowRoom.GetShowRoomConsultoraPersonalizada 201705, '007817487'
CREATE PROCEDURE ShowRoom.[GetShowRoomConsultoraPersonalizada]
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(20)
AS
BEGIN

DECLARE @EventoId INT
DECLARE @FechaGeneral DATETIME
DECLARE @IsoPais VARCHAR(5)
DECLARE @Segmento VARCHAR(50)
SET @IsoPais = (select CodigoISO from Pais where EstadoActivo = 1) 
SET @Segmento = (SELECT CONCAT(@IsoPais, '_', @CampaniaID, '_Perfil01'))

IF EXISTS (SELECT 1 FROM  ods.ofertaspersonalizadas op WHERE op.CodConsultora= @CodigoConsultora AND op.AnioCampanaVenta= @CampaniaID 
AND op.TipoPersonalizacion= 'SR')
BEGIN
	--PRINT 'Existe en ofertas personalizadas'
	IF NOT EXISTS(SELECT 1 FROM showroom.eventoconsultora sc WHERE sc.CampaniaID= @CampaniaID AND sc.CodigoConsultora= @CodigoConsultora)
	BEGIN
		--PRINT 'NO Existe en showroom.eventoconsultora, inserta registro en eventoConsultora'

		--Insertar en ShowRoom.EventoConsultora EsGenerica = 0
		SET @EventoId = (SELECT TOP 1 EventoID FROM ShowRoom.Evento where CampaniaID = @CampaniaID)
		SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

		INSERT INTO ShowRoom.EventoConsultora(EventoID, CampaniaID, CodigoConsultora, Segmento, MostrarPopup, FechaCreacion, UsuarioCreacion, 
			FechaModificacion, UsuarioModificacion, MostrarPopupVenta, EsGenerica)
		VALUES (@EventoId, @CampaniaID, @CodigoConsultora, @Segmento, 1, @FechaGeneral, 'ADMCONTENIDO', @FechaGeneral, 'ADMCONTENIDO', 1, 0)
	END

	SELECT TOP 1 EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,MostrarPopup,
			MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,
			Suscripcion,Envio,CorreoEnvioAviso,EsGenerica
		FROM ShowRoom.EventoConsultora
		WHERE CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
		ORDER BY FechaCreacion DESC
END
ELSE
BEGIN
	--PRINT 'NO Existe en ofertas personalizadas'
	--Buscar el valor generico
	DECLARE @ConsultoraGenerica VARCHAR(50) = ''
	SELECT @ConsultoraGenerica = Codigo FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10001

	IF EXISTS(SELECT 1 FROM  ods.ofertaspersonalizadas op WHERE op.CodConsultora= @ConsultoraGenerica AND op.AnioCampanaVenta= @CampaniaID 
		AND op.TipoPersonalizacion= 'SR')
	BEGIN
		--PRINT 'Generico existe en ofertas personalizadas'
		IF NOT EXISTS(SELECT 1 FROM showroom.eventoconsultora sc WHERE sc.CampaniaID= @CampaniaID AND sc.CodigoConsultora= @ConsultoraGenerica)
		BEGIN
			--PRINT 'Generico NO existe en showroom.eventoconsultora, inserta registro en eventoConsultora'
			SET @EventoId = (SELECT TOP 1 EventoID FROM ShowRoom.Evento where CampaniaID = @CampaniaID)
			SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

			--insertar esGenerica = 1
			INSERT INTO ShowRoom.EventoConsultora(EventoID, CampaniaID, CodigoConsultora, Segmento, MostrarPopup, FechaCreacion, UsuarioCreacion, 
					FechaModificacion, UsuarioModificacion, MostrarPopupVenta, EsGenerica)
			VALUES (@EventoId, @CampaniaID, @CodigoConsultora, @Segmento, 1, @FechaGeneral, 'ADMCONTENIDO', @FechaGeneral, 'ADMCONTENIDO', 1, 1)
		END
	END

	--retornar el resultado usando el codigo generico
	SELECT TOP 1 EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,MostrarPopup,
		MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,
		Suscripcion,Envio,CorreoEnvioAviso,EsGenerica
	FROM ShowRoom.EventoConsultora
	WHERE CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
	ORDER BY FechaCreacion DESC
END
END

GO

USE BelcorpVenezuela
GO
IF OBJECT_ID('ShowRoom.GetShowRoomConsultoraPersonalizada', 'P') IS NOT NULL
	DROP PROC ShowRoom.GetShowRoomConsultoraPersonalizada
GO
-- ShowRoom.GetShowRoomConsultoraPersonalizada 201705, '007817487'
CREATE PROCEDURE ShowRoom.[GetShowRoomConsultoraPersonalizada]
	@CampaniaID INT,
	@CodigoConsultora VARCHAR(20)
AS
BEGIN

DECLARE @EventoId INT
DECLARE @FechaGeneral DATETIME
DECLARE @IsoPais VARCHAR(5)
DECLARE @Segmento VARCHAR(50)
SET @IsoPais = (select CodigoISO from Pais where EstadoActivo = 1) 
SET @Segmento = (SELECT CONCAT(@IsoPais, '_', @CampaniaID, '_Perfil01'))

IF EXISTS (SELECT 1 FROM  ods.ofertaspersonalizadas op WHERE op.CodConsultora= @CodigoConsultora AND op.AnioCampanaVenta= @CampaniaID 
AND op.TipoPersonalizacion= 'SR')
BEGIN
	--PRINT 'Existe en ofertas personalizadas'
	IF NOT EXISTS(SELECT 1 FROM showroom.eventoconsultora sc WHERE sc.CampaniaID= @CampaniaID AND sc.CodigoConsultora= @CodigoConsultora)
	BEGIN
		--PRINT 'NO Existe en showroom.eventoconsultora, inserta registro en eventoConsultora'

		--Insertar en ShowRoom.EventoConsultora EsGenerica = 0
		SET @EventoId = (SELECT TOP 1 EventoID FROM ShowRoom.Evento where CampaniaID = @CampaniaID)
		SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

		INSERT INTO ShowRoom.EventoConsultora(EventoID, CampaniaID, CodigoConsultora, Segmento, MostrarPopup, FechaCreacion, UsuarioCreacion, 
			FechaModificacion, UsuarioModificacion, MostrarPopupVenta, EsGenerica)
		VALUES (@EventoId, @CampaniaID, @CodigoConsultora, @Segmento, 1, @FechaGeneral, 'ADMCONTENIDO', @FechaGeneral, 'ADMCONTENIDO', 1, 0)
	END

	SELECT TOP 1 EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,MostrarPopup,
			MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,
			Suscripcion,Envio,CorreoEnvioAviso,EsGenerica
		FROM ShowRoom.EventoConsultora
		WHERE CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
		ORDER BY FechaCreacion DESC
END
ELSE
BEGIN
	--PRINT 'NO Existe en ofertas personalizadas'
	--Buscar el valor generico
	DECLARE @ConsultoraGenerica VARCHAR(50) = ''
	SELECT @ConsultoraGenerica = Codigo FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 10001

	IF EXISTS(SELECT 1 FROM  ods.ofertaspersonalizadas op WHERE op.CodConsultora= @ConsultoraGenerica AND op.AnioCampanaVenta= @CampaniaID 
		AND op.TipoPersonalizacion= 'SR')
	BEGIN
		--PRINT 'Generico existe en ofertas personalizadas'
		IF NOT EXISTS(SELECT 1 FROM showroom.eventoconsultora sc WHERE sc.CampaniaID= @CampaniaID AND sc.CodigoConsultora= @ConsultoraGenerica)
		BEGIN
			--PRINT 'Generico NO existe en showroom.eventoconsultora, inserta registro en eventoConsultora'
			SET @EventoId = (SELECT TOP 1 EventoID FROM ShowRoom.Evento where CampaniaID = @CampaniaID)
			SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

			--insertar esGenerica = 1
			INSERT INTO ShowRoom.EventoConsultora(EventoID, CampaniaID, CodigoConsultora, Segmento, MostrarPopup, FechaCreacion, UsuarioCreacion, 
					FechaModificacion, UsuarioModificacion, MostrarPopupVenta, EsGenerica)
			VALUES (@EventoId, @CampaniaID, @CodigoConsultora, @Segmento, 1, @FechaGeneral, 'ADMCONTENIDO', @FechaGeneral, 'ADMCONTENIDO', 1, 1)
		END
	END

	--retornar el resultado usando el codigo generico
	SELECT TOP 1 EventoConsultoraID,EventoID,CampaniaID,CodigoConsultora,Segmento,MostrarPopup,
		MostrarPopupVenta,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,
		Suscripcion,Envio,CorreoEnvioAviso,EsGenerica
	FROM ShowRoom.EventoConsultora
	WHERE CampaniaID = @CampaniaID and CodigoConsultora = @CodigoConsultora
	ORDER BY FechaCreacion DESC
END
END

GO

