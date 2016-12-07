
USE BelcorpColombia
go


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerProcesoPedidoRechazadoGPR_SB2]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ObtenerProcesoPedidoRechazadoGPR_SB2]
GO

CREATE PROCEDURE GPR.ObtenerProcesoPedidoRechazadoGPR_SB2 
	@ConsultoraID bigint
	, @CampaniaID int
AS
/*
ObtenerProcesoPedidoRechazadoGPR_SB2 1003436, 201616
*/ 
BEGIN

	declare @IdProceso int
	declare @CodigoConsultora varchar(25)
	declare @fecha datetime

	select @fecha = FechaProceso, @CodigoConsultora = c.Codigo
	from pedidoweb p
		inner join ods.consultora c on c.ConsultoraID = p.ConsultoraID
	where p.IndicadorEnviado = 0
	--AND p.EstadoPedido = 202
	and p.CampaniaID = @CampaniaID
	and p.ConsultoraID = @ConsultoraID
	
	select TOP 1 @IdProceso = IdProcesoPedidoRechazado
	from GPR.ProcesoPedidoRechazado p
	where P.Fecha > @fecha
	order by p.Fecha asc
	
	select 
	p.IdProcesoPedidoRechazado
	,p.Fecha
	,p.Estado
	,p.Mensaje
	,r.IdPedidoRechazado
	,r.Campania
	,r.CodigoConsultora
	,r.CodigoRechazoSomosBelcorp as MotivoRechazo
	,r.Valor
	,r.Procesado
	,r.Rechazado
	from GPR.ProcesoPedidoRechazado p
		LEFT join GPR.PedidoRechazado r
			on r.IdProcesoPedidoRechazado = p.IdProcesoPedidoRechazado
				--and r.Rechazado = 1
				and r.Campania = @CampaniaID 
				and r.CodigoConsultora = @CodigoConsultora
	where p.IdProcesoPedidoRechazado = @IdProceso
	order by p.Fecha asc
	
end

GO

USE BelcorpMexico
go


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerProcesoPedidoRechazadoGPR_SB2]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ObtenerProcesoPedidoRechazadoGPR_SB2]
GO

CREATE PROCEDURE dbo.ObtenerProcesoPedidoRechazadoGPR_SB2 
	@ConsultoraID bigint
	, @CampaniaID int
AS
/*
ObtenerProcesoPedidoRechazadoGPR_SB2 1003436, 201616
*/ 
BEGIN

	declare @IdProceso int
	declare @CodigoConsultora varchar(25)
	declare @fecha datetime

	select @fecha = FechaProceso, @CodigoConsultora = c.Codigo
	from pedidoweb p
		inner join ods.consultora c on c.ConsultoraID = p.ConsultoraID
	where p.IndicadorEnviado = 0
	--AND p.EstadoPedido = 202
	and p.CampaniaID = @CampaniaID
	and p.ConsultoraID = @ConsultoraID
	
	select TOP 1 @IdProceso = IdProcesoPedidoRechazado
	from GPR.ProcesoPedidoRechazado p
	where P.Fecha > @fecha
	order by p.Fecha asc
	
	select 
	p.IdProcesoPedidoRechazado
	,p.Fecha
	,p.Estado
	,p.Mensaje
	,r.IdPedidoRechazado
	,r.Campania
	,r.CodigoConsultora
	,r.CodigoRechazoSomosBelcorp as MotivoRechazo
	,r.Valor
	,r.Procesado
	,r.Rechazado
	from GPR.ProcesoPedidoRechazado p
		LEFT join GPR.PedidoRechazado r
			on r.IdProcesoPedidoRechazado = p.IdProcesoPedidoRechazado
				--and r.Rechazado = 1
				and r.Campania = @CampaniaID 
				and r.CodigoConsultora = @CodigoConsultora
	where p.IdProcesoPedidoRechazado = @IdProceso
	order by p.Fecha asc
	
end

GO

USE BelcorpPeru
go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ObtenerProcesoPedidoRechazadoGPR_SB2]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ObtenerProcesoPedidoRechazadoGPR_SB2]
GO

CREATE PROCEDURE dbo.ObtenerProcesoPedidoRechazadoGPR_SB2 
	@ConsultoraID bigint
	, @CampaniaID int
AS
/*
ObtenerProcesoPedidoRechazadoGPR_SB2 1003436, 201616
*/ 
BEGIN

	declare @IdProceso int
	declare @CodigoConsultora varchar(25)
	declare @fecha datetime

	select @fecha = FechaProceso, @CodigoConsultora = c.Codigo
	from pedidoweb p
		inner join ods.consultora c on c.ConsultoraID = p.ConsultoraID
	where p.IndicadorEnviado = 0
	--AND p.EstadoPedido = 202
	and p.CampaniaID = @CampaniaID
	and p.ConsultoraID = @ConsultoraID
	
	select TOP 1 @IdProceso = IdProcesoPedidoRechazado
	from GPR.ProcesoPedidoRechazado p
	where P.Fecha > @fecha
	order by p.Fecha asc
	
	select 
	p.IdProcesoPedidoRechazado
	,p.Fecha
	,p.Estado
	,p.Mensaje
	,r.IdPedidoRechazado
	,r.Campania
	,r.CodigoConsultora
	,r.CodigoRechazoSomosBelcorp as MotivoRechazo
	,r.Valor
	,r.Procesado
	,r.Rechazado
	from GPR.ProcesoPedidoRechazado p
		LEFT join GPR.PedidoRechazado r
			on r.IdProcesoPedidoRechazado = p.IdProcesoPedidoRechazado
				--and r.Rechazado = 1
				and r.Campania = @CampaniaID 
				and r.CodigoConsultora = @CodigoConsultora
	where p.IdProcesoPedidoRechazado = @IdProceso
	order by p.Fecha asc
	
end

GO

