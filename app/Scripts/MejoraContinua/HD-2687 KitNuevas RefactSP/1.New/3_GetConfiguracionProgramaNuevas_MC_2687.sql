GO
IF OBJECT_ID('dbo.GetConfiguracionProgramaNuevas') IS NOT NULL
BEGIN
	drop procedure dbo.GetConfiguracionProgramaNuevas
END
GO
CREATE PROCEDURE dbo.GetConfiguracionProgramaNuevas
	@Campania char(6),
	@CodigoConsultora varchar(25),
	@CodigoNivel varchar(2)
AS
BEGIN
	if @CodigoNivel = '01'
	begin
		select top 1
			CfPN.CodigoPrograma,
			CfPN.IndExigVent,
			CfPN.IndProgObli,
			CfPN.CUVKit
		from ods.ConfiguracionProgramaNuevas CfPN
		inner join ods.ConsultorasProgramaNuevas CoPN on CoPN.Campania = CfPN.CampanaCarga and CoPN.CodigoPrograma = CfPN.CodigoPrograma
		where CoPN.Campania = @Campania and CoPN.CodigoConsultora = @CodigoConsultora and CoPN.Participa = 1;
	end
	else
	begin
		select
			PPN.CodigoPrograma,
			'0' as IndExigVent,
			'1' as IndProgObli,
			PPN.CUV as CUVKit
		from ods.PremiosProgramaNuevas PPN
		inner join ods.ConsultorasProgramaNuevas CoPN on CoPN.Campania = PPN.AnoCampana and CoPN.CodigoPrograma = PPN.CodigoPrograma
		where
			CoPN.Campania = @Campania and CoPN.CodigoConsultora = @CodigoConsultora and CoPN.Participa = 1 and
			PPN.CodigoNivel = @CodigoNivel and PPN.PrecioUnitario > 0;
	end
END
GO