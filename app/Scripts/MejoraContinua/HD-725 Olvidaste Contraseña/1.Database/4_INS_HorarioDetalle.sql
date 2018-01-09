USE BelcorpPeru
GO

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

USE BelcorpMexico
GO

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

USE BelcorpColombia
GO

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

USE BelcorpVenezuela
GO

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

USE BelcorpSalvador
GO

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

USE BelcorpPuertoRico
GO

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

USE BelcorpPanama
GO

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

USE BelcorpGuatemala
GO

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

USE BelcorpEcuador
GO

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

USE BelcorpDominicana
GO

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

USE BelcorpCostaRica
GO

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

USE BelcorpChile
GO

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

USE BelcorpBolivia
GO

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

