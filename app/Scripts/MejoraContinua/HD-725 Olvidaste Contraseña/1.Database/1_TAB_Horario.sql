USE BelcorpPeru
GO

GO
IF OBJECT_ID('dbo.HorarioDetalle') IS NOT NULL
	DROP TABLE HorarioDetalle
GO
IF OBJECT_ID('dbo.Horario') IS NOT NULL
	DROP TABLE Horario
GO
CREATE TABLE Horario(
	HorarioId int not null identity(1,1),
	Codigo varchar(50) not null,
	Resumen varchar(100) not null,
	PrimerDiaSemana tinyint not null,
	HoraISO bit not null,
	HoraIncluyente bit not null,
	constraint PK_Horario primary key clustered(HorarioId asc)
);
GO

USE BelcorpMexico
GO

GO
IF OBJECT_ID('dbo.HorarioDetalle') IS NOT NULL
	DROP TABLE HorarioDetalle
GO
IF OBJECT_ID('dbo.Horario') IS NOT NULL
	DROP TABLE Horario
GO
CREATE TABLE Horario(
	HorarioId int not null identity(1,1),
	Codigo varchar(50) not null,
	Resumen varchar(100) not null,
	PrimerDiaSemana tinyint not null,
	HoraISO bit not null,
	HoraIncluyente bit not null,
	constraint PK_Horario primary key clustered(HorarioId asc)
);
GO

USE BelcorpColombia
GO

GO
IF OBJECT_ID('dbo.HorarioDetalle') IS NOT NULL
	DROP TABLE HorarioDetalle
GO
IF OBJECT_ID('dbo.Horario') IS NOT NULL
	DROP TABLE Horario
GO
CREATE TABLE Horario(
	HorarioId int not null identity(1,1),
	Codigo varchar(50) not null,
	Resumen varchar(100) not null,
	PrimerDiaSemana tinyint not null,
	HoraISO bit not null,
	HoraIncluyente bit not null,
	constraint PK_Horario primary key clustered(HorarioId asc)
);
GO

USE BelcorpVenezuela
GO

GO
IF OBJECT_ID('dbo.HorarioDetalle') IS NOT NULL
	DROP TABLE HorarioDetalle
GO
IF OBJECT_ID('dbo.Horario') IS NOT NULL
	DROP TABLE Horario
GO
CREATE TABLE Horario(
	HorarioId int not null identity(1,1),
	Codigo varchar(50) not null,
	Resumen varchar(100) not null,
	PrimerDiaSemana tinyint not null,
	HoraISO bit not null,
	HoraIncluyente bit not null,
	constraint PK_Horario primary key clustered(HorarioId asc)
);
GO

USE BelcorpSalvador
GO

GO
IF OBJECT_ID('dbo.HorarioDetalle') IS NOT NULL
	DROP TABLE HorarioDetalle
GO
IF OBJECT_ID('dbo.Horario') IS NOT NULL
	DROP TABLE Horario
GO
CREATE TABLE Horario(
	HorarioId int not null identity(1,1),
	Codigo varchar(50) not null,
	Resumen varchar(100) not null,
	PrimerDiaSemana tinyint not null,
	HoraISO bit not null,
	HoraIncluyente bit not null,
	constraint PK_Horario primary key clustered(HorarioId asc)
);
GO

USE BelcorpPuertoRico
GO

GO
IF OBJECT_ID('dbo.HorarioDetalle') IS NOT NULL
	DROP TABLE HorarioDetalle
GO
IF OBJECT_ID('dbo.Horario') IS NOT NULL
	DROP TABLE Horario
GO
CREATE TABLE Horario(
	HorarioId int not null identity(1,1),
	Codigo varchar(50) not null,
	Resumen varchar(100) not null,
	PrimerDiaSemana tinyint not null,
	HoraISO bit not null,
	HoraIncluyente bit not null,
	constraint PK_Horario primary key clustered(HorarioId asc)
);
GO

USE BelcorpPanama
GO

GO
IF OBJECT_ID('dbo.HorarioDetalle') IS NOT NULL
	DROP TABLE HorarioDetalle
GO
IF OBJECT_ID('dbo.Horario') IS NOT NULL
	DROP TABLE Horario
GO
CREATE TABLE Horario(
	HorarioId int not null identity(1,1),
	Codigo varchar(50) not null,
	Resumen varchar(100) not null,
	PrimerDiaSemana tinyint not null,
	HoraISO bit not null,
	HoraIncluyente bit not null,
	constraint PK_Horario primary key clustered(HorarioId asc)
);
GO

USE BelcorpGuatemala
GO

GO
IF OBJECT_ID('dbo.HorarioDetalle') IS NOT NULL
	DROP TABLE HorarioDetalle
GO
IF OBJECT_ID('dbo.Horario') IS NOT NULL
	DROP TABLE Horario
GO
CREATE TABLE Horario(
	HorarioId int not null identity(1,1),
	Codigo varchar(50) not null,
	Resumen varchar(100) not null,
	PrimerDiaSemana tinyint not null,
	HoraISO bit not null,
	HoraIncluyente bit not null,
	constraint PK_Horario primary key clustered(HorarioId asc)
);
GO

USE BelcorpEcuador
GO

GO
IF OBJECT_ID('dbo.HorarioDetalle') IS NOT NULL
	DROP TABLE HorarioDetalle
GO
IF OBJECT_ID('dbo.Horario') IS NOT NULL
	DROP TABLE Horario
GO
CREATE TABLE Horario(
	HorarioId int not null identity(1,1),
	Codigo varchar(50) not null,
	Resumen varchar(100) not null,
	PrimerDiaSemana tinyint not null,
	HoraISO bit not null,
	HoraIncluyente bit not null,
	constraint PK_Horario primary key clustered(HorarioId asc)
);
GO

USE BelcorpDominicana
GO

GO
IF OBJECT_ID('dbo.HorarioDetalle') IS NOT NULL
	DROP TABLE HorarioDetalle
GO
IF OBJECT_ID('dbo.Horario') IS NOT NULL
	DROP TABLE Horario
GO
CREATE TABLE Horario(
	HorarioId int not null identity(1,1),
	Codigo varchar(50) not null,
	Resumen varchar(100) not null,
	PrimerDiaSemana tinyint not null,
	HoraISO bit not null,
	HoraIncluyente bit not null,
	constraint PK_Horario primary key clustered(HorarioId asc)
);
GO

USE BelcorpCostaRica
GO

GO
IF OBJECT_ID('dbo.HorarioDetalle') IS NOT NULL
	DROP TABLE HorarioDetalle
GO
IF OBJECT_ID('dbo.Horario') IS NOT NULL
	DROP TABLE Horario
GO
CREATE TABLE Horario(
	HorarioId int not null identity(1,1),
	Codigo varchar(50) not null,
	Resumen varchar(100) not null,
	PrimerDiaSemana tinyint not null,
	HoraISO bit not null,
	HoraIncluyente bit not null,
	constraint PK_Horario primary key clustered(HorarioId asc)
);
GO

USE BelcorpChile
GO

GO
IF OBJECT_ID('dbo.HorarioDetalle') IS NOT NULL
	DROP TABLE HorarioDetalle
GO
IF OBJECT_ID('dbo.Horario') IS NOT NULL
	DROP TABLE Horario
GO
CREATE TABLE Horario(
	HorarioId int not null identity(1,1),
	Codigo varchar(50) not null,
	Resumen varchar(100) not null,
	PrimerDiaSemana tinyint not null,
	HoraISO bit not null,
	HoraIncluyente bit not null,
	constraint PK_Horario primary key clustered(HorarioId asc)
);
GO

USE BelcorpBolivia
GO

GO
IF OBJECT_ID('dbo.HorarioDetalle') IS NOT NULL
	DROP TABLE HorarioDetalle
GO
IF OBJECT_ID('dbo.Horario') IS NOT NULL
	DROP TABLE Horario
GO
CREATE TABLE Horario(
	HorarioId int not null identity(1,1),
	Codigo varchar(50) not null,
	Resumen varchar(100) not null,
	PrimerDiaSemana tinyint not null,
	HoraISO bit not null,
	HoraIncluyente bit not null,
	constraint PK_Horario primary key clustered(HorarioId asc)
);
GO

