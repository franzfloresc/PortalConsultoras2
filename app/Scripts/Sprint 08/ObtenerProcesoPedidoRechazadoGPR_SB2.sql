
CREATE PROCEDURE dbo.ObtenerProcesoPedidoRechazadoGPR_SB2
	@ConsultoraID bigint
	, @CampaniaID int
AS
/*
ObtenerPedidoRechazado_SB2 '000758833'
*/ 
BEGIN

	declare @IdProceso int
	declare @CodigoConsultora varchar(25)
	declare @fecha datetime

	select @fecha = FechaProceso, @CodigoConsultora = c.Codigo
	from pedidoweb p
		inner join ods.consultora c on c.ConsultoraID = p.ConsultoraID
	where IndicadorEnviado = 1
	and p.CampaniaID = @CampaniaID
	and p.ConsultoraID = @ConsultoraID
	
	select @IdProceso = IdProcesoPedidoRechazado
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
	,r.MotivoRechazo
	,r.Valor
	,r.RequiereGestion
	,r.Procesado
	from GPR.ProcesoPedidoRechazado p
		LEFT join GPR.PedidoRechazado r
			on r.IdProcesoPedidoRechazado = p.IdProcesoPedidoRechazado
				and RequiereGestion = 1
				and r.Campania = @CampaniaID 
				and r.CodigoConsultora = @CodigoConsultora
	where p.IdProcesoPedidoRechazado = @IdProceso 
	order by p.Fecha asc
	
end


