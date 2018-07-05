GO
ALTER PROCEDURE dbo.ObtenerProgramaNuevasXConsultora
	@CodigoConsultora VARCHAR(15),
	@CodigoCampania INT,
	@CodigoRegion VARCHAR(4),
	@CodigoZona VARCHAR(4)
AS
BEGIN
	set nocount on;

	delete from dbo.IncentivosConsultoraProgramaNuevas
	where CodigoConsultora = @CodigoConsultora;

	declare @CodigoNivel char(2) = isnull(
		(select
			case
				when ConsecutivoNueva between 1 and 6 THEN concat('0', ConsecutivoNueva + 1)
				when ConsecutivoNueva = 0 and IdEstadoActividad in (1,7) THEN '01'
			end
		from ods.Consultora (nolock)
		where Codigo = @CodigoConsultora),
		'00'
	);
	declare @CodigoPrograma varchar(15) = null;

	if @CodigoNivel = '01'
	begin		
		select @CodigoPrograma = CoPN.CodigoPrograma
		from ods.ConsultorasProgramaNuevas CoPN (nolock)
		inner join ods.ConfiguracionProgramaNuevas CfPN (nolock) on CfPN.CampanaCarga = CoPN.Campania and CfPN.CodigoPrograma = CoPN.CodigoPrograma
		where CoPN.Campania = @Campania and CoPN.CodigoConsultora = @CodigoConsultora and CoPN.Participa = 1;
	end
	else if @CodigoNivel between '02' and '06'
	begin
		select @CodigoPrograma = CodigoPrograma
		from (
			select top 1 CodigoPrograma, Participa
			from ods.ConsultorasProgramaNuevas CPN (nolock)
			where CodigoConsultora = @CodigoConsultora
			order by Campania desc
		) CTE_CONSULTORA_PARTICIPA
		where Participa = 1;
	end

	if @CodigoPrograma is not null
	begin
		insert into dbo.IncentivosConsultoraProgramaNuevas(CodigoConsultora, CodigoCampania, CodigoPrograma, CodigoNivel, TipoConcurso)
		select @CodigoConsultora, @CodigoCampania, @CodigoPrograma,	@CodigoNivel, 'P';
	end

	select
		CodigoConsultora,
		CodigoCampania AS CampaniaID,
		CodigoPrograma AS CodigoConcurso,
		CodigoNivel,
		TipoConcurso
	from dbo.IncentivosConsultoraProgramaNuevas
	where CodigoConsultora = @CodigoConsultora

	set nocount off;
END
GO