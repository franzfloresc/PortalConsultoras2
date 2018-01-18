USE BelcorpPeru
GO

ALTER PROCEDURE [interfaces].[InsConsultoraFromLogPSOInsConsultora]
	@PSOInsConsultoraId BIGINT
AS
BEGIN
	INSERT INTO ods.Consultora(
		ConsultoraID,
		SeccionID,
		RegionID,
		ZonaID,
		TerritorioID,
		IdEstadoActividad,
		Codigo,
		PrimerNombre,
		SegundoNombre,
		PrimerApellido,
		SegundoApellido,
		NombreCompleto,
		AutorizaPedido,
		AnoCampanaIngreso,
		MontoMaximoPedido,
		MontoMinimoPedido,
		FechaIngreso,
		MontoSaldoActual,
		esConsultoraLider,
		Email,
		FechaNacimiento,
		Genero,
		EstadoCivil
	)
	SELECT
		ConsultoraID,
		SeccionID,
		RegionID,
		ZonaID,
		TerritorioID,
		IdEstadoActividad,
		Codigo,
		PrimerNombre,
		SegundoNombre,
		PrimerApellido,
		SegundoApellido,
		NombreCompleto,
		AutorizaPedido,
		AnoCampanaIngreso,
		MontoMaximoPedido,
		MontoMinimoPedido,
		FechaIngreso,
		MontoSaldoActual,
		EsConsultoraLider,
		Email,
		FechaNacimiento,
		Genero,
		EstadoCivil
	FROM interfaces.LogPSOInsConsultora
	WHERE PSOInsConsultoraId = @PSOInsConsultoraId AND ISNULL(Error,'') = '';
	
	INSERT INTO ods.Identificacion(
		ConsultoraID,
		Numero,
		DocumentoPrincipal,
		TipoDocumento
	)
	SELECT
		ConsultoraID,
		NumeroDocumento,
		DocumentoPrincipal,
		TipoDocumento
	FROM interfaces.LogPSOInsConsultora
	WHERE PSOInsConsultoraId = @PSOInsConsultoraId  AND ISNULL(Error,'') = '';

	update ods.EstadoRegistro
	set estado = 1;
END
GO

USE BelcorpMexico
GO

ALTER PROCEDURE [interfaces].[InsConsultoraFromLogPSOInsConsultora]
	@PSOInsConsultoraId BIGINT
AS
BEGIN
	INSERT INTO ods.Consultora(
		ConsultoraID,
		SeccionID,
		RegionID,
		ZonaID,
		TerritorioID,
		IdEstadoActividad,
		Codigo,
		PrimerNombre,
		SegundoNombre,
		PrimerApellido,
		SegundoApellido,
		NombreCompleto,
		AutorizaPedido,
		AnoCampanaIngreso,
		MontoMaximoPedido,
		MontoMinimoPedido,
		FechaIngreso,
		MontoSaldoActual,
		esConsultoraLider,
		Email,
		FechaNacimiento,
		Genero,
		EstadoCivil
	)
	SELECT
		ConsultoraID,
		SeccionID,
		RegionID,
		ZonaID,
		TerritorioID,
		IdEstadoActividad,
		Codigo,
		PrimerNombre,
		SegundoNombre,
		PrimerApellido,
		SegundoApellido,
		NombreCompleto,
		AutorizaPedido,
		AnoCampanaIngreso,
		MontoMaximoPedido,
		MontoMinimoPedido,
		FechaIngreso,
		MontoSaldoActual,
		EsConsultoraLider,
		Email,
		FechaNacimiento,
		Genero,
		EstadoCivil
	FROM interfaces.LogPSOInsConsultora
	WHERE PSOInsConsultoraId = @PSOInsConsultoraId AND ISNULL(Error,'') = '';
	
	INSERT INTO ods.Identificacion(
		ConsultoraID,
		Numero,
		DocumentoPrincipal,
		TipoDocumento
	)
	SELECT
		ConsultoraID,
		NumeroDocumento,
		DocumentoPrincipal,
		TipoDocumento
	FROM interfaces.LogPSOInsConsultora
	WHERE PSOInsConsultoraId = @PSOInsConsultoraId  AND ISNULL(Error,'') = '';

	update ods.EstadoRegistro
	set estado = 1;
END
GO

USE BelcorpColombia
GO

ALTER PROCEDURE [interfaces].[InsConsultoraFromLogPSOInsConsultora]
	@PSOInsConsultoraId BIGINT
AS
BEGIN
	INSERT INTO ods.Consultora(
		ConsultoraID,
		SeccionID,
		RegionID,
		ZonaID,
		TerritorioID,
		IdEstadoActividad,
		Codigo,
		PrimerNombre,
		SegundoNombre,
		PrimerApellido,
		SegundoApellido,
		NombreCompleto,
		AutorizaPedido,
		AnoCampanaIngreso,
		MontoMaximoPedido,
		MontoMinimoPedido,
		FechaIngreso,
		MontoSaldoActual,
		esConsultoraLider,
		Email,
		FechaNacimiento,
		Genero,
		EstadoCivil
	)
	SELECT
		ConsultoraID,
		SeccionID,
		RegionID,
		ZonaID,
		TerritorioID,
		IdEstadoActividad,
		Codigo,
		PrimerNombre,
		SegundoNombre,
		PrimerApellido,
		SegundoApellido,
		NombreCompleto,
		AutorizaPedido,
		AnoCampanaIngreso,
		MontoMaximoPedido,
		MontoMinimoPedido,
		FechaIngreso,
		MontoSaldoActual,
		EsConsultoraLider,
		Email,
		FechaNacimiento,
		Genero,
		EstadoCivil
	FROM interfaces.LogPSOInsConsultora
	WHERE PSOInsConsultoraId = @PSOInsConsultoraId AND ISNULL(Error,'') = '';
	
	INSERT INTO ods.Identificacion(
		ConsultoraID,
		Numero,
		DocumentoPrincipal,
		TipoDocumento
	)
	SELECT
		ConsultoraID,
		NumeroDocumento,
		DocumentoPrincipal,
		TipoDocumento
	FROM interfaces.LogPSOInsConsultora
	WHERE PSOInsConsultoraId = @PSOInsConsultoraId  AND ISNULL(Error,'') = '';

	update ods.EstadoRegistro
	set estado = 1;
END
GO

USE BelcorpVenezuela
GO

ALTER PROCEDURE [interfaces].[InsConsultoraFromLogPSOInsConsultora]
	@PSOInsConsultoraId BIGINT
AS
BEGIN
	INSERT INTO ods.Consultora(
		ConsultoraID,
		SeccionID,
		RegionID,
		ZonaID,
		TerritorioID,
		IdEstadoActividad,
		Codigo,
		PrimerNombre,
		SegundoNombre,
		PrimerApellido,
		SegundoApellido,
		NombreCompleto,
		AutorizaPedido,
		AnoCampanaIngreso,
		MontoMaximoPedido,
		MontoMinimoPedido,
		FechaIngreso,
		MontoSaldoActual,
		esConsultoraLider,
		Email,
		FechaNacimiento,
		Genero,
		EstadoCivil
	)
	SELECT
		ConsultoraID,
		SeccionID,
		RegionID,
		ZonaID,
		TerritorioID,
		IdEstadoActividad,
		Codigo,
		PrimerNombre,
		SegundoNombre,
		PrimerApellido,
		SegundoApellido,
		NombreCompleto,
		AutorizaPedido,
		AnoCampanaIngreso,
		MontoMaximoPedido,
		MontoMinimoPedido,
		FechaIngreso,
		MontoSaldoActual,
		EsConsultoraLider,
		Email,
		FechaNacimiento,
		Genero,
		EstadoCivil
	FROM interfaces.LogPSOInsConsultora
	WHERE PSOInsConsultoraId = @PSOInsConsultoraId AND ISNULL(Error,'') = '';
	
	INSERT INTO ods.Identificacion(
		ConsultoraID,
		Numero,
		DocumentoPrincipal,
		TipoDocumento
	)
	SELECT
		ConsultoraID,
		NumeroDocumento,
		DocumentoPrincipal,
		TipoDocumento
	FROM interfaces.LogPSOInsConsultora
	WHERE PSOInsConsultoraId = @PSOInsConsultoraId  AND ISNULL(Error,'') = '';

	update ods.EstadoRegistro
	set estado = 1;
END
GO

USE BelcorpSalvador
GO

ALTER PROCEDURE [interfaces].[InsConsultoraFromLogPSOInsConsultora]
	@PSOInsConsultoraId BIGINT
AS
BEGIN
	INSERT INTO ods.Consultora(
		ConsultoraID,
		SeccionID,
		RegionID,
		ZonaID,
		TerritorioID,
		IdEstadoActividad,
		Codigo,
		PrimerNombre,
		SegundoNombre,
		PrimerApellido,
		SegundoApellido,
		NombreCompleto,
		AutorizaPedido,
		AnoCampanaIngreso,
		MontoMaximoPedido,
		MontoMinimoPedido,
		FechaIngreso,
		MontoSaldoActual,
		esConsultoraLider,
		Email,
		FechaNacimiento,
		Genero,
		EstadoCivil
	)
	SELECT
		ConsultoraID,
		SeccionID,
		RegionID,
		ZonaID,
		TerritorioID,
		IdEstadoActividad,
		Codigo,
		PrimerNombre,
		SegundoNombre,
		PrimerApellido,
		SegundoApellido,
		NombreCompleto,
		AutorizaPedido,
		AnoCampanaIngreso,
		MontoMaximoPedido,
		MontoMinimoPedido,
		FechaIngreso,
		MontoSaldoActual,
		EsConsultoraLider,
		Email,
		FechaNacimiento,
		Genero,
		EstadoCivil
	FROM interfaces.LogPSOInsConsultora
	WHERE PSOInsConsultoraId = @PSOInsConsultoraId AND ISNULL(Error,'') = '';
	
	INSERT INTO ods.Identificacion(
		ConsultoraID,
		Numero,
		DocumentoPrincipal,
		TipoDocumento
	)
	SELECT
		ConsultoraID,
		NumeroDocumento,
		DocumentoPrincipal,
		TipoDocumento
	FROM interfaces.LogPSOInsConsultora
	WHERE PSOInsConsultoraId = @PSOInsConsultoraId  AND ISNULL(Error,'') = '';

	update ods.EstadoRegistro
	set estado = 1;
END
GO

USE BelcorpPuertoRico
GO

ALTER PROCEDURE [interfaces].[InsConsultoraFromLogPSOInsConsultora]
	@PSOInsConsultoraId BIGINT
AS
BEGIN
	INSERT INTO ods.Consultora(
		ConsultoraID,
		SeccionID,
		RegionID,
		ZonaID,
		TerritorioID,
		IdEstadoActividad,
		Codigo,
		PrimerNombre,
		SegundoNombre,
		PrimerApellido,
		SegundoApellido,
		NombreCompleto,
		AutorizaPedido,
		AnoCampanaIngreso,
		MontoMaximoPedido,
		MontoMinimoPedido,
		FechaIngreso,
		MontoSaldoActual,
		esConsultoraLider,
		Email,
		FechaNacimiento,
		Genero,
		EstadoCivil
	)
	SELECT
		ConsultoraID,
		SeccionID,
		RegionID,
		ZonaID,
		TerritorioID,
		IdEstadoActividad,
		Codigo,
		PrimerNombre,
		SegundoNombre,
		PrimerApellido,
		SegundoApellido,
		NombreCompleto,
		AutorizaPedido,
		AnoCampanaIngreso,
		MontoMaximoPedido,
		MontoMinimoPedido,
		FechaIngreso,
		MontoSaldoActual,
		EsConsultoraLider,
		Email,
		FechaNacimiento,
		Genero,
		EstadoCivil
	FROM interfaces.LogPSOInsConsultora
	WHERE PSOInsConsultoraId = @PSOInsConsultoraId AND ISNULL(Error,'') = '';
	
	INSERT INTO ods.Identificacion(
		ConsultoraID,
		Numero,
		DocumentoPrincipal,
		TipoDocumento
	)
	SELECT
		ConsultoraID,
		NumeroDocumento,
		DocumentoPrincipal,
		TipoDocumento
	FROM interfaces.LogPSOInsConsultora
	WHERE PSOInsConsultoraId = @PSOInsConsultoraId  AND ISNULL(Error,'') = '';

	update ods.EstadoRegistro
	set estado = 1;
END
GO

USE BelcorpPanama
GO

ALTER PROCEDURE [interfaces].[InsConsultoraFromLogPSOInsConsultora]
	@PSOInsConsultoraId BIGINT
AS
BEGIN
	INSERT INTO ods.Consultora(
		ConsultoraID,
		SeccionID,
		RegionID,
		ZonaID,
		TerritorioID,
		IdEstadoActividad,
		Codigo,
		PrimerNombre,
		SegundoNombre,
		PrimerApellido,
		SegundoApellido,
		NombreCompleto,
		AutorizaPedido,
		AnoCampanaIngreso,
		MontoMaximoPedido,
		MontoMinimoPedido,
		FechaIngreso,
		MontoSaldoActual,
		esConsultoraLider,
		Email,
		FechaNacimiento,
		Genero,
		EstadoCivil
	)
	SELECT
		ConsultoraID,
		SeccionID,
		RegionID,
		ZonaID,
		TerritorioID,
		IdEstadoActividad,
		Codigo,
		PrimerNombre,
		SegundoNombre,
		PrimerApellido,
		SegundoApellido,
		NombreCompleto,
		AutorizaPedido,
		AnoCampanaIngreso,
		MontoMaximoPedido,
		MontoMinimoPedido,
		FechaIngreso,
		MontoSaldoActual,
		EsConsultoraLider,
		Email,
		FechaNacimiento,
		Genero,
		EstadoCivil
	FROM interfaces.LogPSOInsConsultora
	WHERE PSOInsConsultoraId = @PSOInsConsultoraId AND ISNULL(Error,'') = '';
	
	INSERT INTO ods.Identificacion(
		ConsultoraID,
		Numero,
		DocumentoPrincipal,
		TipoDocumento
	)
	SELECT
		ConsultoraID,
		NumeroDocumento,
		DocumentoPrincipal,
		TipoDocumento
	FROM interfaces.LogPSOInsConsultora
	WHERE PSOInsConsultoraId = @PSOInsConsultoraId  AND ISNULL(Error,'') = '';

	update ods.EstadoRegistro
	set estado = 1;
END
GO

USE BelcorpGuatemala
GO

ALTER PROCEDURE [interfaces].[InsConsultoraFromLogPSOInsConsultora]
	@PSOInsConsultoraId BIGINT
AS
BEGIN
	INSERT INTO ods.Consultora(
		ConsultoraID,
		SeccionID,
		RegionID,
		ZonaID,
		TerritorioID,
		IdEstadoActividad,
		Codigo,
		PrimerNombre,
		SegundoNombre,
		PrimerApellido,
		SegundoApellido,
		NombreCompleto,
		AutorizaPedido,
		AnoCampanaIngreso,
		MontoMaximoPedido,
		MontoMinimoPedido,
		FechaIngreso,
		MontoSaldoActual,
		esConsultoraLider,
		Email,
		FechaNacimiento,
		Genero,
		EstadoCivil
	)
	SELECT
		ConsultoraID,
		SeccionID,
		RegionID,
		ZonaID,
		TerritorioID,
		IdEstadoActividad,
		Codigo,
		PrimerNombre,
		SegundoNombre,
		PrimerApellido,
		SegundoApellido,
		NombreCompleto,
		AutorizaPedido,
		AnoCampanaIngreso,
		MontoMaximoPedido,
		MontoMinimoPedido,
		FechaIngreso,
		MontoSaldoActual,
		EsConsultoraLider,
		Email,
		FechaNacimiento,
		Genero,
		EstadoCivil
	FROM interfaces.LogPSOInsConsultora
	WHERE PSOInsConsultoraId = @PSOInsConsultoraId AND ISNULL(Error,'') = '';
	
	INSERT INTO ods.Identificacion(
		ConsultoraID,
		Numero,
		DocumentoPrincipal,
		TipoDocumento
	)
	SELECT
		ConsultoraID,
		NumeroDocumento,
		DocumentoPrincipal,
		TipoDocumento
	FROM interfaces.LogPSOInsConsultora
	WHERE PSOInsConsultoraId = @PSOInsConsultoraId  AND ISNULL(Error,'') = '';

	update ods.EstadoRegistro
	set estado = 1;
END
GO

USE BelcorpEcuador
GO

ALTER PROCEDURE [interfaces].[InsConsultoraFromLogPSOInsConsultora]
	@PSOInsConsultoraId BIGINT
AS
BEGIN
	INSERT INTO ods.Consultora(
		ConsultoraID,
		SeccionID,
		RegionID,
		ZonaID,
		TerritorioID,
		IdEstadoActividad,
		Codigo,
		PrimerNombre,
		SegundoNombre,
		PrimerApellido,
		SegundoApellido,
		NombreCompleto,
		AutorizaPedido,
		AnoCampanaIngreso,
		MontoMaximoPedido,
		MontoMinimoPedido,
		FechaIngreso,
		MontoSaldoActual,
		esConsultoraLider,
		Email,
		FechaNacimiento,
		Genero,
		EstadoCivil
	)
	SELECT
		ConsultoraID,
		SeccionID,
		RegionID,
		ZonaID,
		TerritorioID,
		IdEstadoActividad,
		Codigo,
		PrimerNombre,
		SegundoNombre,
		PrimerApellido,
		SegundoApellido,
		NombreCompleto,
		AutorizaPedido,
		AnoCampanaIngreso,
		MontoMaximoPedido,
		MontoMinimoPedido,
		FechaIngreso,
		MontoSaldoActual,
		EsConsultoraLider,
		Email,
		FechaNacimiento,
		Genero,
		EstadoCivil
	FROM interfaces.LogPSOInsConsultora
	WHERE PSOInsConsultoraId = @PSOInsConsultoraId AND ISNULL(Error,'') = '';
	
	INSERT INTO ods.Identificacion(
		ConsultoraID,
		Numero,
		DocumentoPrincipal,
		TipoDocumento
	)
	SELECT
		ConsultoraID,
		NumeroDocumento,
		DocumentoPrincipal,
		TipoDocumento
	FROM interfaces.LogPSOInsConsultora
	WHERE PSOInsConsultoraId = @PSOInsConsultoraId  AND ISNULL(Error,'') = '';

	update ods.EstadoRegistro
	set estado = 1;
END
GO

USE BelcorpDominicana
GO

ALTER PROCEDURE [interfaces].[InsConsultoraFromLogPSOInsConsultora]
	@PSOInsConsultoraId BIGINT
AS
BEGIN
	INSERT INTO ods.Consultora(
		ConsultoraID,
		SeccionID,
		RegionID,
		ZonaID,
		TerritorioID,
		IdEstadoActividad,
		Codigo,
		PrimerNombre,
		SegundoNombre,
		PrimerApellido,
		SegundoApellido,
		NombreCompleto,
		AutorizaPedido,
		AnoCampanaIngreso,
		MontoMaximoPedido,
		MontoMinimoPedido,
		FechaIngreso,
		MontoSaldoActual,
		esConsultoraLider,
		Email,
		FechaNacimiento,
		Genero,
		EstadoCivil
	)
	SELECT
		ConsultoraID,
		SeccionID,
		RegionID,
		ZonaID,
		TerritorioID,
		IdEstadoActividad,
		Codigo,
		PrimerNombre,
		SegundoNombre,
		PrimerApellido,
		SegundoApellido,
		NombreCompleto,
		AutorizaPedido,
		AnoCampanaIngreso,
		MontoMaximoPedido,
		MontoMinimoPedido,
		FechaIngreso,
		MontoSaldoActual,
		EsConsultoraLider,
		Email,
		FechaNacimiento,
		Genero,
		EstadoCivil
	FROM interfaces.LogPSOInsConsultora
	WHERE PSOInsConsultoraId = @PSOInsConsultoraId AND ISNULL(Error,'') = '';
	
	INSERT INTO ods.Identificacion(
		ConsultoraID,
		Numero,
		DocumentoPrincipal,
		TipoDocumento
	)
	SELECT
		ConsultoraID,
		NumeroDocumento,
		DocumentoPrincipal,
		TipoDocumento
	FROM interfaces.LogPSOInsConsultora
	WHERE PSOInsConsultoraId = @PSOInsConsultoraId  AND ISNULL(Error,'') = '';

	update ods.EstadoRegistro
	set estado = 1;
END
GO

USE BelcorpCostaRica
GO

ALTER PROCEDURE [interfaces].[InsConsultoraFromLogPSOInsConsultora]
	@PSOInsConsultoraId BIGINT
AS
BEGIN
	INSERT INTO ods.Consultora(
		ConsultoraID,
		SeccionID,
		RegionID,
		ZonaID,
		TerritorioID,
		IdEstadoActividad,
		Codigo,
		PrimerNombre,
		SegundoNombre,
		PrimerApellido,
		SegundoApellido,
		NombreCompleto,
		AutorizaPedido,
		AnoCampanaIngreso,
		MontoMaximoPedido,
		MontoMinimoPedido,
		FechaIngreso,
		MontoSaldoActual,
		esConsultoraLider,
		Email,
		FechaNacimiento,
		Genero,
		EstadoCivil
	)
	SELECT
		ConsultoraID,
		SeccionID,
		RegionID,
		ZonaID,
		TerritorioID,
		IdEstadoActividad,
		Codigo,
		PrimerNombre,
		SegundoNombre,
		PrimerApellido,
		SegundoApellido,
		NombreCompleto,
		AutorizaPedido,
		AnoCampanaIngreso,
		MontoMaximoPedido,
		MontoMinimoPedido,
		FechaIngreso,
		MontoSaldoActual,
		EsConsultoraLider,
		Email,
		FechaNacimiento,
		Genero,
		EstadoCivil
	FROM interfaces.LogPSOInsConsultora
	WHERE PSOInsConsultoraId = @PSOInsConsultoraId AND ISNULL(Error,'') = '';
	
	INSERT INTO ods.Identificacion(
		ConsultoraID,
		Numero,
		DocumentoPrincipal,
		TipoDocumento
	)
	SELECT
		ConsultoraID,
		NumeroDocumento,
		DocumentoPrincipal,
		TipoDocumento
	FROM interfaces.LogPSOInsConsultora
	WHERE PSOInsConsultoraId = @PSOInsConsultoraId  AND ISNULL(Error,'') = '';

	update ods.EstadoRegistro
	set estado = 1;
END
GO

USE BelcorpChile
GO

ALTER PROCEDURE [interfaces].[InsConsultoraFromLogPSOInsConsultora]
	@PSOInsConsultoraId BIGINT
AS
BEGIN
	INSERT INTO ods.Consultora(
		ConsultoraID,
		SeccionID,
		RegionID,
		ZonaID,
		TerritorioID,
		IdEstadoActividad,
		Codigo,
		PrimerNombre,
		SegundoNombre,
		PrimerApellido,
		SegundoApellido,
		NombreCompleto,
		AutorizaPedido,
		AnoCampanaIngreso,
		MontoMaximoPedido,
		MontoMinimoPedido,
		FechaIngreso,
		MontoSaldoActual,
		esConsultoraLider,
		Email,
		FechaNacimiento,
		Genero,
		EstadoCivil
	)
	SELECT
		ConsultoraID,
		SeccionID,
		RegionID,
		ZonaID,
		TerritorioID,
		IdEstadoActividad,
		Codigo,
		PrimerNombre,
		SegundoNombre,
		PrimerApellido,
		SegundoApellido,
		NombreCompleto,
		AutorizaPedido,
		AnoCampanaIngreso,
		MontoMaximoPedido,
		MontoMinimoPedido,
		FechaIngreso,
		MontoSaldoActual,
		EsConsultoraLider,
		Email,
		FechaNacimiento,
		Genero,
		EstadoCivil
	FROM interfaces.LogPSOInsConsultora
	WHERE PSOInsConsultoraId = @PSOInsConsultoraId AND ISNULL(Error,'') = '';
	
	INSERT INTO ods.Identificacion(
		ConsultoraID,
		Numero,
		DocumentoPrincipal,
		TipoDocumento
	)
	SELECT
		ConsultoraID,
		NumeroDocumento,
		DocumentoPrincipal,
		TipoDocumento
	FROM interfaces.LogPSOInsConsultora
	WHERE PSOInsConsultoraId = @PSOInsConsultoraId  AND ISNULL(Error,'') = '';

	update ods.EstadoRegistro
	set estado = 1;
END
GO

USE BelcorpBolivia
GO

ALTER PROCEDURE [interfaces].[InsConsultoraFromLogPSOInsConsultora]
	@PSOInsConsultoraId BIGINT
AS
BEGIN
	INSERT INTO ods.Consultora(
		ConsultoraID,
		SeccionID,
		RegionID,
		ZonaID,
		TerritorioID,
		IdEstadoActividad,
		Codigo,
		PrimerNombre,
		SegundoNombre,
		PrimerApellido,
		SegundoApellido,
		NombreCompleto,
		AutorizaPedido,
		AnoCampanaIngreso,
		MontoMaximoPedido,
		MontoMinimoPedido,
		FechaIngreso,
		MontoSaldoActual,
		esConsultoraLider,
		Email,
		FechaNacimiento,
		Genero,
		EstadoCivil
	)
	SELECT
		ConsultoraID,
		SeccionID,
		RegionID,
		ZonaID,
		TerritorioID,
		IdEstadoActividad,
		Codigo,
		PrimerNombre,
		SegundoNombre,
		PrimerApellido,
		SegundoApellido,
		NombreCompleto,
		AutorizaPedido,
		AnoCampanaIngreso,
		MontoMaximoPedido,
		MontoMinimoPedido,
		FechaIngreso,
		MontoSaldoActual,
		EsConsultoraLider,
		Email,
		FechaNacimiento,
		Genero,
		EstadoCivil
	FROM interfaces.LogPSOInsConsultora
	WHERE PSOInsConsultoraId = @PSOInsConsultoraId AND ISNULL(Error,'') = '';
	
	INSERT INTO ods.Identificacion(
		ConsultoraID,
		Numero,
		DocumentoPrincipal,
		TipoDocumento
	)
	SELECT
		ConsultoraID,
		NumeroDocumento,
		DocumentoPrincipal,
		TipoDocumento
	FROM interfaces.LogPSOInsConsultora
	WHERE PSOInsConsultoraId = @PSOInsConsultoraId  AND ISNULL(Error,'') = '';

	update ods.EstadoRegistro
	set estado = 1;
END
GO

