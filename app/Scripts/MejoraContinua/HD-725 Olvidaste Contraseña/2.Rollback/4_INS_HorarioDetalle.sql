GO
delete from HorarioDetalle
where HorarioID in (
	select HorarioID
	from Horario
	where Codigo = 'ChatEmtelco'
);
GO