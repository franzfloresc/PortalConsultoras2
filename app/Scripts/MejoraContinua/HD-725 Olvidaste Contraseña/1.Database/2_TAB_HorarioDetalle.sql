GO
IF OBJECT_ID('dbo.HorarioDetalle') IS NOT NULL
	DROP TABLE HorarioDetalle
GO
CREATE TABLE HorarioDetalle(
	HorarioDetalleId int not null identity(1,1),
	HorarioId int not null,
	DiaSemanaInicio tinyint not null,
	DiaSemanaFin tinyint not null,
	HoraInicio time not null,
	HoraFin time not null,
	constraint PK_HorarioDetalle primary key clustered(HorarioDetalleId asc),
	constraint FK_HorarioDetalle_HorarioId foreign key (HorarioId) references Horario(HorarioId) on delete cascade
);
GO