
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

	EXEC [interfaces].[InsConsultoraToRevistaDigital] @PSOInsConsultoraId

	update ods.EstadoRegistro
	set estado = 1;

	
END
