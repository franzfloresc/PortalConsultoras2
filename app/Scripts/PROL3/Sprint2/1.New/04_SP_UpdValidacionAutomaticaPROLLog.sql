ALTER procedure dbo.UpdValidacionAutomaticaPROLLog
	@ValAutomaticaPROLLogId bigint,
	@NumeroItemsEnviados int,
	@Estado int,
	@EstadoPROL varchar(2),
	@Observaciones varchar(500),
	@Error varchar(3000),
	@EsMontoMinimo bit,
	@MontoTotalProl money,
	@DescuentoProl money,
	@MontoEscala money,
	@MontoAhorroRevista money,
	@MontoAhorroCatalogo money,
	@EsDeuda bit = 0,
	@MontoDeuda money = 0
AS
BEGIN
	declare @fechaHora datetime = dbo.fnObtenerFechaHoraPais();

	update ValidacionAutomaticaPROLLog
	set
		NumeroItemsEnviados =  @NumeroItemsEnviados,
		Estado = @Estado,
		FechaHoraValidación = iif(isnull(@EstadoPROL, '') <> '', @fechaHora, null),
		FechaHoraFin = @fechaHora,
		Error = @Error,
		EstadoPROL = @EstadoPROL,
		Observaciones = @Observaciones,
		EsMontoMinino = @EsMontoMinimo,
		EsDeuda = @EsDeuda,
		MontoTotalProl = @MontoTotalProl,
		DescuentoProl = @DescuentoProl,
		MontoEscala = @MontoEscala,
		MontoAhorroRevista = @MontoAhorroRevista,
		MontoAhorroCatalogo = @MontoAhorroCatalogo,
		MontoDeuda = @MontoDeuda
	where ValAutomaticaPROLLogId = @ValAutomaticaPROLLogId;
END
