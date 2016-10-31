go
if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('dbo.pais') and SYSCOLUMNS.NAME = N'PedidoRechazado') = 0
	ALTER TABLE dbo.pais ADD PedidoRechazado bit
go

IF EXISTS(
	SELECT *
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'EsPedidoRechazado_SB2' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'FUNCTION'
)
BEGIN
    DROP FUNCTION dbo.EsPedidoRechazado_SB2
END



GO
CREATE FUNCTION dbo.EsPedidoRechazado_SB2
(
	@ConsultoraID bigint
	,@CampaniaID int
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
	
	
	DECLARE @FechaGeneral DATETIME
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

	DECLARE @esRechazado INT = -1

	declare @fecha datetime
	declare @estado varchar(25)
	declare @CodigoConsultora varchar(25)
	declare @IdProceso int

	declare @IndicadorEnviado bit = 0  
	declare @fechaFin datetime
	
	Select @IndicadorEnviado  = IndicadorEnviado    
	From pedidoweb (nolock)  
	Where CampaniaID = @CampaniaID and consultoraid = @consultoraid    

	declare @indPais int = 0
	select @indPais = PedidoRechazado
	from pais where estadoActivo = 1				
	set @indPais = isnull(@indPais, 0)

	if @indPais = 0
		set @esRechazado = 2

	-- validar fecha ultimo dia
	DECLARE @ZonaID INT, @RegionID INT
	SELECT @ZonaID = ZonaID, @RegionID = RegionID
	FROM ods.consultora
	WHERE ConsultoraID = @ConsultoraID

	select @fechaFin = c.FechaInicioReFacturacion
	FROM [ods].[Cronograma] c (nolock)
	INNER JOIN [ods].[Campania] ca (nolock) ON c.CampaniaID = ca.CampaniaID
	WHERE c.ZonaID = @ZonaID AND c.RegionID = @RegionID  AND ca.Codigo = @CampaniaID

	if convert(date, @fechaFin) < convert(date, @FechaGeneral) -- si llego el ultimo dia de la ReFacturacion
	BEGIN
		SET @IndicadorEnviado = 0
		set @esRechazado = 2 -- continua con el proceso

	END

	If(@IndicadorEnviado = 1)
	BEGIN
				set @esRechazado = 2

				if @indPais = 1
				BEGIN
							
							set @esRechazado = 0
							SET @IdProceso = 0
															
							set @IdProceso = 0
							--if @esRechazado = 0
							--begin
		
								select @fecha = FechaReserva, @CodigoConsultora = c.Codigo
								from pedidoweb p
									inner join ods.consultora c on c.ConsultoraID = p.ConsultoraID
								where IndicadorEnviado = 1
								and p.CampaniaID = @CampaniaID
								and p.ConsultoraID = @ConsultoraID
	
								select @IdProceso = p.IdProcesoPedidoRechazado, @estado = P.Estado
								from GPR.ProcesoPedidoRechazado p
								where P.Fecha > @fecha
								order by p.Fecha asc

							--end

							if @IdProceso > 0
							begin
		
								SET @esRechazado = 2

								if @Estado = 'OK' OR @Estado = 'OK'
								begin
										declare @IdProcesox int = 0
										--set @IdProceso = 0
										select @IdProcesox = count(1)
										from GPR.ProcesoPedidoRechazado p
											inner join GPR.PedidoRechazado r
												on r.IdProcesoPedidoRechazado = p.IdProcesoPedidoRechazado
													and r.Rechazado = 1
													and r.Campania = @CampaniaID 
													and r.CodigoConsultora = @CodigoConsultora
										where p.IdProcesoPedidoRechazado = @IdProceso

										if @IdProcesox > 0
											SET @esRechazado = 1
								end
	
							end -- fin @IdProceso > 0


							if @esRechazado = 1 -- esta rechazado
							begin
					
								if convert(date, @fechaFin) < convert(date, @FechaGeneral) -- si llego el ultimo dia de la ReFacturacion
									set @esRechazado = 2 -- continua con el proceso
							end

				end -- fin 

	END


	INSERT @T(esRechazado, IndicadorEnviado)
	VALUES(@esRechazado, @IndicadorEnviado)
	RETURN
end 