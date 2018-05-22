ALTER procedure dbo.UpdValidacionAutomaticaPROLLog
(
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
	@MontoAhorroCatalogo money
)
AS
BEGIN
	IF @Estado = 99
	BEGIN
		UPDATE ValidacionAutomaticaPROLLog
		SET	NumeroItemsEnviados =  @NumeroItemsEnviados,
			Estado = @Estado,
			FechaHoraFin = dbo.fnObtenerFechaHoraPais(),
			Error = @Error,
			EsMontoMinino = @EsMontoMinimo
		WHERE ValAutomaticaPROLLogId = @ValAutomaticaPROLLogId
	END
	ELSE
	BEGIN
		UPDATE ValidacionAutomaticaPROLLog
		SET	NumeroItemsEnviados =  @NumeroItemsEnviados,
			Estado = @Estado,
			FechaHoraValidación = dbo.fnObtenerFechaHoraPais(),
			FechaHoraFin = dbo.fnObtenerFechaHoraPais(),
			EstadoPROL = @EstadoPROL,
			Observaciones = @Observaciones,
			EsMontoMinino = @EsMontoMinimo,
			MontoTotalProl = @MontoTotalProl,
			DescuentoProl = @DescuentoProl,
			MontoEscala = @MontoEscala,
			MontoAhorroRevista = @MontoAhorroRevista,
			MontoAhorroCatalogo = @MontoAhorroCatalogo
		WHERE ValAutomaticaPROLLogId = @ValAutomaticaPROLLogId
	END
END
