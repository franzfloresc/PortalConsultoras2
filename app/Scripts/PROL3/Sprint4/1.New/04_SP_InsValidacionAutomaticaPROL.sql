ALTER PROCEDURE InsValidacionAutomaticaPROL
	@VersionProl tinyint = 2
AS
BEGIN
	declare @Estado int = -1;
	declare @ValAutomaticaPROLId bigint = 0;
	declare @fechaHoy date = cast(dbo.fnObtenerFechaHoraPais() as date);

	select top 1
		@Estado = Estado,
		@ValAutomaticaPROLId = ValAutomaticaPROLId
	from dbo.ValidacionAutomaticaPROL (nolock)
	where cast(FechaHoraInicio as date) = @fechaHoy
	order by ValAutomaticaPROLId desc;

	IF(@Estado = 0)
	BEGIN
		UPDATE dbo.ValidacionAutomaticaPROL
		SET
			VersionProl = @VersionProl,
			Estado = 1
		WHERE ValAutomaticaPROLId = @ValAutomaticaPROLId
	END

	SELECT @ValAutomaticaPROLId
END