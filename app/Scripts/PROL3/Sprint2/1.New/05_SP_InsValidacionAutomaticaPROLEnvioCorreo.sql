ALTER PROCEDURE InsValidacionAutomaticaPROLEnvioCorreo
	@ValAutomaticaPROLId bigint
AS
/*
InsValidacionAutomaticaPROLEnvioCorreo 11096
InsValidacionAutomaticaPROLEnvioCorreo 11457
*/
begin
	UPDATE ValidacionAutomaticaPROL
	SET
		EnvioCorreo = 1,
		FechaHoraInicioEnvio = dbo.fnObtenerFechaHoraPais()
	WHERE ValAutomaticaPROLId = @ValAutomaticaPROLId;

	select
		va.ValAutomaticaPROLLogId,
		va.CampaniaId,
		va.PedidoId,
		va.ConsultoraId,
		va.Codigo,
		va.EstadoPROL,
		va.Observaciones,		
		va.FechaFacturacion,
		va.EsMontoMinino,
		va.EsDeuda,
		va.FacturaHoy,
		isnull(va.MontoTotalProl,0) AS MontoTotalProl,
		va.DescuentoProl,
		va.MontoEscala,
		va.MontoAhorroCatalogo,
		va.MontoAhorroRevista,
		va.MontoMaximoPedido,
		va.MontoMinimoPedido,
		va.MontoDeuda,
		va.Zona,
		u.EMail,
		u.Nombre,
		u.CodigoUsuario,
		u.EMailActivo,
		r.Codigo as Region,
		s.Codigo as Seccion,
		s.ZonaID as ZonaId,
		coalesce(iif(u.Sobrenombre='',null,u.Sobrenombre),c.PrimerNombre) as NombreConsultoraCorreo
	from ValidacionAutomaticaPROLLog va with(nolock)
	inner join Usuario u with(nolock) on va.Codigo = u.CodigoConsultora
	inner join ods.consultora c with(nolock) on va.ConsultoraId = c.ConsultoraID
	inner join ods.Region r with(nolock) on c.RegionID = r.RegionID
	inner join ods.Seccion s with(nolock) on c.SeccionID = s.SeccionID
	where
		ValAutomaticaPROLId = @ValAutomaticaPROLId and EstadoPROL <> ''
		and
		u.EMail != '';
end