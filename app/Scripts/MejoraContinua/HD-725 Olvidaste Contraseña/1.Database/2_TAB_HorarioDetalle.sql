USE BelcorpPeru
GO

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

USE BelcorpMexico
GO

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

USE BelcorpColombia
GO

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

USE BelcorpVenezuela
GO

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

USE BelcorpSalvador
GO

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

USE BelcorpPuertoRico
GO

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

USE BelcorpPanama
GO

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

USE BelcorpGuatemala
GO

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

USE BelcorpEcuador
GO

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

USE BelcorpDominicana
GO

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

USE BelcorpCostaRica
GO

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

USE BelcorpChile
GO

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

USE BelcorpBolivia
GO

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

