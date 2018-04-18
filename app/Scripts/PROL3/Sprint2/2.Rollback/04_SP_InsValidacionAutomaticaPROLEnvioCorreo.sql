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

	declare @tablaValidacionAutomaticaPROLLog table
	(	ValAutomaticaPROLLogId bigint primary key,
		CampaniaId int,
		PedidoId int,
		ConsultoraId bigint,
		Codigo varchar(20),
		EstadoPROL varchar(2),
		Observaciones varchar(500),
		FechaFacturacion date,
		EsMontoMinino bit,
		FacturaHoy bit,
		MontoTotalProl money,
		DescuentoProl money,
		MontoEscala money,
		MontoAhorroCatalogo money,
		MontoAhorroRevista money,
		MontoMaximoPedido money,
		MontoMinimoPedido money,
		Zona varchar(6)
	)

	insert into @tablaValidacionAutomaticaPROLLog
	select ValAutomaticaPROLLogId,
		CampaniaId,
		PedidoId,
		ConsultoraId,
		Codigo,
		EstadoPROL,
		Observaciones,		
		FechaFacturacion,
		EsMontoMinino,
		FacturaHoy,
		isnull(MontoTotalProl,0),
		DescuentoProl,
		MontoEscala,
		MontoAhorroCatalogo,
		MontoAhorroRevista,
		MontoMaximoPedido,
		MontoMinimoPedido,
		Zona
	from ValidacionAutomaticaPROLLog with(nolock)
	where 
		ValAutomaticaPROLId = @ValAutomaticaPROLId and EstadoPROL <> ''

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
		va.FacturaHoy,
		va.MontoTotalProl,
		va.DescuentoProl,
		va.MontoEscala,
		va.MontoAhorroCatalogo,
		va.MontoAhorroRevista,
		va.MontoMaximoPedido,
		va.MontoMinimoPedido,
		va.Zona,
		u.EMail,
		u.Nombre,
		u.CodigoUsuario,
		u.EMailActivo,
		r.Codigo as Region,
		s.Codigo as Seccion,
		s.ZonaID as ZonaId,
		coalesce(iif(u.Sobrenombre='',null,u.Sobrenombre),c.PrimerNombre) as NombreConsultoraCorreo
	from @tablaValidacionAutomaticaPROLLog va
	inner join Usuario u with(nolock) on 
		va.Codigo = u.CodigoConsultora 
		--and isnull(u.EMail,'') != ''
	inner join ods.consultora c with(nolock) on
		va.ConsultoraId = c.ConsultoraID
	inner join ods.Region r with(nolock) on
		c.RegionID = r.RegionID
	inner join ods.Seccion s with(nolock) on
		c.SeccionID = s.SeccionID
	where isnull(u.EMail,'') != ''		
end