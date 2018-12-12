ALTER PROCEDURE dbo.GetActivarPremioNuevas
@CodigoPrograma				varchar(10),
@CampaniaID					int, 
@CodigoNivel				varchar (10)
AS
BEGIN

	select 
		CodigoPrograma		,
		AnoCampana			,
		Nivel				,
		ActiveTooltip		,
		ActiveTooltipMonto	,
		Active				,
		FechaCreate			,
		isnull(IND_CUPO_ELEC, 0) AS IND_CUPO_ELEC
	from dbo.ActivarPremioNuevas  
	where codigoprograma= @CodigoPrograma 
		and anocampana= @CampaniaID 
		and (@CodigoNivel = '' or Nivel = @CodigoNivel)

END
