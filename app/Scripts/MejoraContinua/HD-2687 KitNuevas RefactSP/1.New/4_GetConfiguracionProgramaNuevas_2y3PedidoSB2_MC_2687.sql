GO
ALTER PROCEDURE dbo.GetConfiguracionProgramaNuevas_2y3PedidoSB2
	@Campania char(6),
	@CodigoConsultora varchar(25),
	@CodigoNivel varchar(2)
AS
BEGIN
	select
		CodigoPrograma,
		CUV as CUVKit
	from ods.PremiosProgramaNuevas PPN
	inner join ods.ConsultorasProgramaNuevas CoPN on CoPN.Campania = PPN.Campania and CoPN.CodigoPrograma = PPN.CodigoPrograma
	where
		CoPN.Campania = @Campania and CoPN.CodigoConsultora = @CodigoConsultora and CoPN.Participa = 1 and
		PPN.CodigoNivel = @CodigoNivel and PPN.PrecioUnitario > 0;
END
GO