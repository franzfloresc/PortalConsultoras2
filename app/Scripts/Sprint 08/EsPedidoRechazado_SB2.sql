
GO
ALTER FUNCTION dbo.EsPedidoRechazado_SB2
(
	@ConsultoraID bigint
	,@CampaniaID int
	,@esRechazado int
)
RETURNS @T TABLE(
	esRechazado INT
	,IndicadorEnviado BIT
)
as 
/*
@esRechazado => -1: Sin enviar, 0: Proceso (sin respuesta), 1: Rechazado, 2: No Rechazado
*/
begin
	SET @esRechazado = -1

	declare @fecha datetime
	declare @estado varchar(25)
	declare @CodigoConsultora varchar(25)
	declare @IdProceso int

	declare @IndicadorEnviado bit = 0  
	declare @fechaFin datetime
	
	Select @IndicadorEnviado  = IndicadorEnviado    
	From pedidoweb (nolock)  
	Where CampaniaID = @CampaniaID and consultoraid = @consultoraid    

	If(@IndicadorEnviado = 1)
	BEGIN
				set @esRechazado = 0
		
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

					if @Estado = 'OK' OR @Estado = 'OK'
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


				if @esRechazado = 1 -- esta rechazado
				begin
					
					DECLARE @ZonaID INT, @RegionID INT
					SELECT @ZonaID = ZonaID, @RegionID = RegionID
					FROM ods.consultora
					WHERE ConsultoraID = @ConsultoraID

					select @fechaFin = c.FechaInicioReFacturacion
					FROM [ods].[Cronograma] c (nolock)
					INNER JOIN [ods].[Campania] ca (nolock) ON c.CampaniaID = ca.CampaniaID
					WHERE c.ZonaID = @ZonaID AND c.RegionID = @RegionID  AND ca.Codigo = @CampaniaID

					if convert(date, @fechaFin) < convert(date, getdate()) -- si llego el ultimo dia de la ReFacturacion
						set @esRechazado = 2 -- continua con el proceso
				end

	END


	INSERT @T(esRechazado, IndicadorEnviado)
	VALUES(@esRechazado, @IndicadorEnviado)
	RETURN
end 