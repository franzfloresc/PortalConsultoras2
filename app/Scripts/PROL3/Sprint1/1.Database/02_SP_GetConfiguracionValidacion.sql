GO
ALTER PROC dbo.GetConfiguracionValidacion
	@CampaniaID	int = 201301
as
begin
	select
		CampaniaID,
		PaisID,
		DiasAntes,
		HoraInicio,
		HoraFin,
		HoraInicioNoFacturable,
		HoraCierreNoFacturable,
		FlagNoValidados,
		ProcesoRegular,
		ProcesoDA,
		ProcesoDAPRD,
		HabilitarRestriccionHoraria,
		HorasDuracionRestriccion,
		CronogramaAutomatico,
		ContingenciaActivacionPROL,
		ValidacionAutomaticaPostActivacion,
		ValidacionInteractiva,
		MensajeValidacionInteractiva,
		TieneProl3
	from ConfiguracionValidacion
	where CampaniaID = @CampaniaID;
end
GO