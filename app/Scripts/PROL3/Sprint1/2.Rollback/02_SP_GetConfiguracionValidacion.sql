GO
ALTER PROC dbo.GetConfiguracionValidacion
	@CampaniaID	int
as
begin
	select CampaniaID,
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
		   HabilitarRestriccionHoraria
	from ConfiguracionValidacion
	where CampaniaID = @CampaniaID;
end
GO