GO
delete from HorarioDetalle
where HorarioID in (
	select HorarioID
	from Horario
	where Codigo = 'ChatEmtelco'
);
GO
declare @HorarioId tinyint = isnull((select top 1 HorarioID from Horario where Codigo = 'ChatEmtelco'),0);
if @HorarioId <> 0
begin
	insert into HorarioDetalle(HorarioId,DiaSemanaInicio,DiaSemanaFin,HoraInicio,HoraFin)
	values
		(@HorarioId,1,5,'08:00','20:00'),
		(@HorarioId,6,6,'08:00','18:00')
end
GO