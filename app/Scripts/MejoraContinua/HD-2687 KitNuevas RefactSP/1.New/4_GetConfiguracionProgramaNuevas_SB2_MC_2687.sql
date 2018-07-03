GO
ALTER PROCEDURE dbo.GetConfiguracionProgramaNuevas_SB2
	@Campania char(6),
	@CodigoConsultora varchar(25)
AS
BEGIN
	select top 1
		CfPN.CodigoPrograma,
		CfPN.CampaniaInicio,
		CfPN.CampaniaFin,
		CfPN.IndExigVent,
		CfPN.IndProgObli,
		CfPN.CuponKit,
		CfPN.CUVKit
	from ods.ConfiguracionProgramaNuevas CfPN
	inner join ods.ConsultorasProgramaNuevas CoPN on CoPN.Campania = CfPN.CampanaCarga and CoPN.CodigoPrograma = CfPN.CodigoPrograma
	where CoPN.Campania = @Campania and CoPN.CodigoConsultora = @CodigoConsultora and CoPN.Participa = 1;
END
GO