ALTER PROCEDURE InsValidacionAutomaticaPROL
AS
BEGIN
	declare @Estado int
	declare @ValAutomaticaPROLId bigint
	set @Estado = -1
	set @ValAutomaticaPROLId = 0

	select top 1 @Estado = Estado, @ValAutomaticaPROLId = ValAutomaticaPROLId
	from dbo.ValidacionAutomaticaPROL (nolock)
	where cast(FechaHoraInicio as date) = cast(dbo.fnObtenerFechaHoraPais() as date)
	order by ValAutomaticaPROLId desc

	IF(@Estado = 0)
	BEGIN
		UPDATE dbo.ValidacionAutomaticaPROL
		SET Estado = 1
		WHERE ValAutomaticaPROLId = @ValAutomaticaPROLId
	END

	SELECT @ValAutomaticaPROLId
END