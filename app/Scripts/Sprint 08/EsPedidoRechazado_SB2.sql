
GO
CREATE FUNCTION dbo.EsPedidoRechazado_SB2
(
	@ConsultoraID bigint
	,@CampaniaID int
	,@esRechazado int
)
RETURNS @T TABLE(
	esRechazado INT
)
as 
/*
@esRechazado => 0: Proceso (sin respuesta), 1: Rechazado, 2: No Rechazado
*/
begin
	SET @esRechazado = 0

	declare @fecha datetime
	declare @estado varchar(25)
	declare @CodigoConsultora varchar(25)
	declare @IdProceso int

	select @fecha = FechaProceso, @CodigoConsultora = c.Codigo
	from pedidoweb p
		inner join ods.consultora c on c.ConsultoraID = p.ConsultoraID
	where IndicadorEnviado = 1
	and p.CampaniaID = @CampaniaID
	and p.ConsultoraID = @ConsultoraID
	
	select @IdProceso = p.IdProcesoPedidoRechazado, @estado = P.Estado
	from GPR.ProcesoPedidoRechazado p
	where P.Fecha > @fecha
	order by p.Fecha asc

	if @IdProceso > 0
	begin
		
		SET @esRechazado = 2

		if @Estado = 'OK'
		begin
				select @IdProceso = count(1)
				from GPR.ProcesoPedidoRechazado p
					inner join GPR.PedidoRechazado r
						on r.IdProcesoPedidoRechazado = p.IdProcesoPedidoRechazado
							and r.RequiereGestion = 1
							and r.Campania = @CampaniaID 
							and r.CodigoConsultora = @CodigoConsultora
				where p.IdProcesoPedidoRechazado = @IdProceso

				if @IdProceso > 0
					SET @esRechazado = 1
		end
	
	end

	INSERT @T(esRechazado)
	VALUES(@esRechazado)
	RETURN
end 