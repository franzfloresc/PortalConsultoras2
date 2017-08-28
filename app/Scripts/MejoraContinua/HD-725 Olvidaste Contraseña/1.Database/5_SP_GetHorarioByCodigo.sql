GO
IF EXISTS(
	SELECT 1
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_NAME = 'GetHorarioByCodigo' AND SPECIFIC_SCHEMA = 'dbo' AND Routine_Type = 'PROCEDURE'
)
BEGIN
    DROP PROCEDURE dbo.GetHorarioByCodigo
END
GO
CREATE PROCEDURE dbo.GetHorarioByCodigo
	@Codigo varchar(12)
AS
BEGIN
	select top 1
		HorarioId,
		Codigo,
		Resumen,
		PrimerDiaSemana,
		HoraISO,
		HoraIncluyente
	from Horario
	where Codigo = @Codigo;
END
GO