

USE BelcorpBolivia
GO

ALTER PROCEDURE [dbo].[InsValidacionAutomaticaPROLEnvioCorreo]
	@ValAutomaticaPROLId bigint
AS
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
		,c.PrimerNombre AS PrimerNombre
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
GO

USE BelcorpChile
GO

ALTER PROCEDURE [dbo].[InsValidacionAutomaticaPROLEnvioCorreo]
	@ValAutomaticaPROLId bigint
AS
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
		,c.PrimerNombre AS PrimerNombre
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
GO

USE BelcorpColombia
GO

ALTER PROCEDURE [dbo].[InsValidacionAutomaticaPROLEnvioCorreo]
	@ValAutomaticaPROLId bigint
AS
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
		,c.PrimerNombre AS PrimerNombre
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
GO

USE BelcorpCostaRica
GO

ALTER PROCEDURE [dbo].[InsValidacionAutomaticaPROLEnvioCorreo]
	@ValAutomaticaPROLId bigint
AS
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
		,c.PrimerNombre AS PrimerNombre
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
GO

USE BelcorpDominicana
GO

ALTER PROCEDURE [dbo].[InsValidacionAutomaticaPROLEnvioCorreo]
	@ValAutomaticaPROLId bigint
AS
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
		,c.PrimerNombre AS PrimerNombre
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
GO

USE BelcorpEcuador
GO

ALTER PROCEDURE [dbo].[InsValidacionAutomaticaPROLEnvioCorreo]
	@ValAutomaticaPROLId bigint
AS
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
		,c.PrimerNombre AS PrimerNombre
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
GO

USE BelcorpGuatemala
GO

ALTER PROCEDURE [dbo].[InsValidacionAutomaticaPROLEnvioCorreo]
	@ValAutomaticaPROLId bigint
AS
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
		,c.PrimerNombre AS PrimerNombre
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
GO

USE BelcorpMexico
GO
ALTER PROCEDURE [dbo].[InsValidacionAutomaticaPROLEnvioCorreo]
	@ValAutomaticaPROLId bigint
AS
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
		,c.PrimerNombre AS PrimerNombre
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
GO

USE BelcorpPanama
GO

ALTER PROCEDURE [dbo].[InsValidacionAutomaticaPROLEnvioCorreo]
	@ValAutomaticaPROLId bigint
AS
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
		,c.PrimerNombre AS PrimerNombre
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
GO

USE BelcorpPeru
GO

ALTER PROCEDURE [dbo].[InsValidacionAutomaticaPROLEnvioCorreo]
	@ValAutomaticaPROLId bigint
AS
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
		,c.PrimerNombre AS PrimerNombre
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
GO

USE BelcorpPuertoRico
GO

ALTER PROCEDURE [dbo].[InsValidacionAutomaticaPROLEnvioCorreo]
	@ValAutomaticaPROLId bigint
AS
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
		,c.PrimerNombre AS PrimerNombre
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
GO

USE BelcorpSalvador
GO

ALTER PROCEDURE [dbo].[InsValidacionAutomaticaPROLEnvioCorreo]
	@ValAutomaticaPROLId bigint
AS
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
		,c.PrimerNombre AS PrimerNombre
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
GO
