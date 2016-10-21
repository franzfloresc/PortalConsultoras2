IF EXISTS(
	SELECT *
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'ObtenerProcesoPedidoRechazadoGPR_SB2' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.ObtenerProcesoPedidoRechazadoGPR_SB2
END

GO

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
	,r.CodigoRechazoSomosBelcorp as MotivoRechazo
	,r.Valor
	,r.Procesado
	,r.Rechazado
	from GPR.ProcesoPedidoRechazado p
		LEFT join GPR.PedidoRechazado r
			on r.IdProcesoPedidoRechazado = p.IdProcesoPedidoRechazado
				and r.Campania = @CampaniaID 
				and r.CodigoConsultora = @CodigoConsultora
	where p.IdProcesoPedidoRechazado = @IdProceso 
	order by p.Fecha asc
	
end


