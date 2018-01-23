USE BelcorpPeru
GO

/****** CREACION TABLAS ******/
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

/****** INSERTANDO DATA *******/

/*** INSERT HORARIO CHAT EMTELCO ***/
DECLARE @HorarioId int = 0
insert into Horario(Codigo,Resumen,PrimerDiaSemana,HoraISO,HoraIncluyente)
values('ChatEmtelco','Lunes a Viernes: 08:00 a 20:00 y Sábados: 08:00 a 18:00',1,0,1)
SET @HorarioId = SCOPE_IDENTITY()
/*** INSERT HORARIO DETALLE CHAT EMTELCO ***/
insert into HorarioDetalle(HorarioId,DiaSemanaInicio,DiaSemanaFin,HoraInicio,HoraFin)
values 
	(@HorarioId,1,5,'08:00','20:00'),
	(@HorarioId,6,6,'08:00','18:00')
GO

/*** INSERT HORARIO BELCORP RESPONDE ***/
DECLARE @HorarioId int = 0
INSERT INTO Horario (Codigo, Resumen, PrimerDiaSemana, HoraISO, HoraIncluyente)
VALUES ('BelcorpResponde', 'Lunes a Viernes: 08:00 a 20:00 y Sábados: 08:00 a 18:00', 1, 0, 1)
SET @HorarioId = SCOPE_IDENTITY()
/*** INSERT HORARIO DETALLE BELCORP RESPONDE ***/
INSERT INTO HorarioDetalle (HorarioId, DiaSemanaInicio, DiaSemanaFin, HoraInicio, HoraFin)
VALUES (@HorarioId, 1, 5, '08:00:00.0000000', '20:00:00.0000000'),
	   (@HorarioId, 6, 6, '08:00:00.0000000', '18:00:00.0000000')
GO

USE BelcorpMexico
GO

/****** CREACION TABLAS ******/
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

/****** INSERTANDO DATA *******/

/*** INSERT HORARIO CHAT EMTELCO ***/
DECLARE @HorarioId int = 0
insert into Horario(Codigo,Resumen,PrimerDiaSemana,HoraISO,HoraIncluyente)
values('ChatEmtelco','Lunes a Viernes: 08:00 a 20:00 y Sábados: 08:00 a 18:00',1,0,1)
SET @HorarioId = SCOPE_IDENTITY()
/*** INSERT HORARIO DETALLE CHAT EMTELCO ***/
insert into HorarioDetalle(HorarioId,DiaSemanaInicio,DiaSemanaFin,HoraInicio,HoraFin)
values 
	(@HorarioId,1,5,'08:00','20:00'),
	(@HorarioId,6,6,'08:00','18:00')
GO

/*** INSERT HORARIO BELCORP RESPONDE ***/
DECLARE @HorarioId int = 0
INSERT INTO Horario (Codigo, Resumen, PrimerDiaSemana, HoraISO, HoraIncluyente)
VALUES ('BelcorpResponde', 'Lunes a Viernes: 08:00 a 20:00 y Sábados: 08:00 a 18:00', 1, 0, 1)
SET @HorarioId = SCOPE_IDENTITY()
/*** INSERT HORARIO DETALLE BELCORP RESPONDE ***/
INSERT INTO HorarioDetalle (HorarioId, DiaSemanaInicio, DiaSemanaFin, HoraInicio, HoraFin)
VALUES (@HorarioId, 1, 5, '08:00:00.0000000', '20:00:00.0000000'),
	   (@HorarioId, 6, 6, '08:00:00.0000000', '18:00:00.0000000')
GO

USE BelcorpColombia
GO

/****** CREACION TABLAS ******/
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

/****** INSERTANDO DATA *******/

/*** INSERT HORARIO CHAT EMTELCO ***/
DECLARE @HorarioId int = 0
insert into Horario(Codigo,Resumen,PrimerDiaSemana,HoraISO,HoraIncluyente)
values('ChatEmtelco','Lunes a Viernes: 08:00 a 20:00 y Sábados: 08:00 a 18:00',1,0,1)
SET @HorarioId = SCOPE_IDENTITY()
/*** INSERT HORARIO DETALLE CHAT EMTELCO ***/
insert into HorarioDetalle(HorarioId,DiaSemanaInicio,DiaSemanaFin,HoraInicio,HoraFin)
values 
	(@HorarioId,1,5,'08:00','20:00'),
	(@HorarioId,6,6,'08:00','18:00')
GO

/*** INSERT HORARIO BELCORP RESPONDE ***/
DECLARE @HorarioId int = 0
INSERT INTO Horario (Codigo, Resumen, PrimerDiaSemana, HoraISO, HoraIncluyente)
VALUES ('BelcorpResponde', 'Lunes a Viernes: 08:00 a 20:00 y Sábados: 08:00 a 18:00', 1, 0, 1)
SET @HorarioId = SCOPE_IDENTITY()
/*** INSERT HORARIO DETALLE BELCORP RESPONDE ***/
INSERT INTO HorarioDetalle (HorarioId, DiaSemanaInicio, DiaSemanaFin, HoraInicio, HoraFin)
VALUES (@HorarioId, 1, 5, '08:00:00.0000000', '20:00:00.0000000'),
	   (@HorarioId, 6, 6, '08:00:00.0000000', '18:00:00.0000000')
GO

USE BelcorpVenezuela
GO

/****** CREACION TABLAS ******/
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

/****** INSERTANDO DATA *******/

/*** INSERT HORARIO CHAT EMTELCO ***/
DECLARE @HorarioId int = 0
insert into Horario(Codigo,Resumen,PrimerDiaSemana,HoraISO,HoraIncluyente)
values('ChatEmtelco','Lunes a Viernes: 08:00 a 20:00 y Sábados: 08:00 a 18:00',1,0,1)
SET @HorarioId = SCOPE_IDENTITY()
/*** INSERT HORARIO DETALLE CHAT EMTELCO ***/
insert into HorarioDetalle(HorarioId,DiaSemanaInicio,DiaSemanaFin,HoraInicio,HoraFin)
values 
	(@HorarioId,1,5,'08:00','20:00'),
	(@HorarioId,6,6,'08:00','18:00')
GO

/*** INSERT HORARIO BELCORP RESPONDE ***/
DECLARE @HorarioId int = 0
INSERT INTO Horario (Codigo, Resumen, PrimerDiaSemana, HoraISO, HoraIncluyente)
VALUES ('BelcorpResponde', 'Lunes a Viernes: 08:00 a 20:00 y Sábados: 08:00 a 18:00', 1, 0, 1)
SET @HorarioId = SCOPE_IDENTITY()
/*** INSERT HORARIO DETALLE BELCORP RESPONDE ***/
INSERT INTO HorarioDetalle (HorarioId, DiaSemanaInicio, DiaSemanaFin, HoraInicio, HoraFin)
VALUES (@HorarioId, 1, 5, '08:00:00.0000000', '20:00:00.0000000'),
	   (@HorarioId, 6, 6, '08:00:00.0000000', '18:00:00.0000000')
GO

USE BelcorpSalvador
GO

/****** CREACION TABLAS ******/
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

/****** INSERTANDO DATA *******/

/*** INSERT HORARIO CHAT EMTELCO ***/
DECLARE @HorarioId int = 0
insert into Horario(Codigo,Resumen,PrimerDiaSemana,HoraISO,HoraIncluyente)
values('ChatEmtelco','Lunes a Viernes: 08:00 a 20:00 y Sábados: 08:00 a 18:00',1,0,1)
SET @HorarioId = SCOPE_IDENTITY()
/*** INSERT HORARIO DETALLE CHAT EMTELCO ***/
insert into HorarioDetalle(HorarioId,DiaSemanaInicio,DiaSemanaFin,HoraInicio,HoraFin)
values 
	(@HorarioId,1,5,'08:00','20:00'),
	(@HorarioId,6,6,'08:00','18:00')
GO

/*** INSERT HORARIO BELCORP RESPONDE ***/
DECLARE @HorarioId int = 0
INSERT INTO Horario (Codigo, Resumen, PrimerDiaSemana, HoraISO, HoraIncluyente)
VALUES ('BelcorpResponde', 'Lunes a Viernes: 08:00 a 20:00 y Sábados: 08:00 a 18:00', 1, 0, 1)
SET @HorarioId = SCOPE_IDENTITY()
/*** INSERT HORARIO DETALLE BELCORP RESPONDE ***/
INSERT INTO HorarioDetalle (HorarioId, DiaSemanaInicio, DiaSemanaFin, HoraInicio, HoraFin)
VALUES (@HorarioId, 1, 5, '08:00:00.0000000', '20:00:00.0000000'),
	   (@HorarioId, 6, 6, '08:00:00.0000000', '18:00:00.0000000')
GO

USE BelcorpPuertoRico
GO

/****** CREACION TABLAS ******/
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

/****** INSERTANDO DATA *******/

/*** INSERT HORARIO CHAT EMTELCO ***/
DECLARE @HorarioId int = 0
insert into Horario(Codigo,Resumen,PrimerDiaSemana,HoraISO,HoraIncluyente)
values('ChatEmtelco','Lunes a Viernes: 08:00 a 20:00 y Sábados: 08:00 a 18:00',1,0,1)
SET @HorarioId = SCOPE_IDENTITY()
/*** INSERT HORARIO DETALLE CHAT EMTELCO ***/
insert into HorarioDetalle(HorarioId,DiaSemanaInicio,DiaSemanaFin,HoraInicio,HoraFin)
values 
	(@HorarioId,1,5,'08:00','20:00'),
	(@HorarioId,6,6,'08:00','18:00')
GO

/*** INSERT HORARIO BELCORP RESPONDE ***/
DECLARE @HorarioId int = 0
INSERT INTO Horario (Codigo, Resumen, PrimerDiaSemana, HoraISO, HoraIncluyente)
VALUES ('BelcorpResponde', 'Lunes a Viernes: 08:00 a 20:00 y Sábados: 08:00 a 18:00', 1, 0, 1)
SET @HorarioId = SCOPE_IDENTITY()
/*** INSERT HORARIO DETALLE BELCORP RESPONDE ***/
INSERT INTO HorarioDetalle (HorarioId, DiaSemanaInicio, DiaSemanaFin, HoraInicio, HoraFin)
VALUES (@HorarioId, 1, 5, '08:00:00.0000000', '20:00:00.0000000'),
	   (@HorarioId, 6, 6, '08:00:00.0000000', '18:00:00.0000000')
GO

USE BelcorpPanama
GO

/****** CREACION TABLAS ******/
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

/****** INSERTANDO DATA *******/

/*** INSERT HORARIO CHAT EMTELCO ***/
DECLARE @HorarioId int = 0
insert into Horario(Codigo,Resumen,PrimerDiaSemana,HoraISO,HoraIncluyente)
values('ChatEmtelco','Lunes a Viernes: 08:00 a 20:00 y Sábados: 08:00 a 18:00',1,0,1)
SET @HorarioId = SCOPE_IDENTITY()
/*** INSERT HORARIO DETALLE CHAT EMTELCO ***/
insert into HorarioDetalle(HorarioId,DiaSemanaInicio,DiaSemanaFin,HoraInicio,HoraFin)
values 
	(@HorarioId,1,5,'08:00','20:00'),
	(@HorarioId,6,6,'08:00','18:00')
GO

/*** INSERT HORARIO BELCORP RESPONDE ***/
DECLARE @HorarioId int = 0
INSERT INTO Horario (Codigo, Resumen, PrimerDiaSemana, HoraISO, HoraIncluyente)
VALUES ('BelcorpResponde', 'Lunes a Viernes: 08:00 a 20:00 y Sábados: 08:00 a 18:00', 1, 0, 1)
SET @HorarioId = SCOPE_IDENTITY()
/*** INSERT HORARIO DETALLE BELCORP RESPONDE ***/
INSERT INTO HorarioDetalle (HorarioId, DiaSemanaInicio, DiaSemanaFin, HoraInicio, HoraFin)
VALUES (@HorarioId, 1, 5, '08:00:00.0000000', '20:00:00.0000000'),
	   (@HorarioId, 6, 6, '08:00:00.0000000', '18:00:00.0000000')
GO

USE BelcorpGuatemala
GO

/****** CREACION TABLAS ******/
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

/****** INSERTANDO DATA *******/

/*** INSERT HORARIO CHAT EMTELCO ***/
DECLARE @HorarioId int = 0
insert into Horario(Codigo,Resumen,PrimerDiaSemana,HoraISO,HoraIncluyente)
values('ChatEmtelco','Lunes a Viernes: 08:00 a 20:00 y Sábados: 08:00 a 18:00',1,0,1)
SET @HorarioId = SCOPE_IDENTITY()
/*** INSERT HORARIO DETALLE CHAT EMTELCO ***/
insert into HorarioDetalle(HorarioId,DiaSemanaInicio,DiaSemanaFin,HoraInicio,HoraFin)
values 
	(@HorarioId,1,5,'08:00','20:00'),
	(@HorarioId,6,6,'08:00','18:00')
GO

/*** INSERT HORARIO BELCORP RESPONDE ***/
DECLARE @HorarioId int = 0
INSERT INTO Horario (Codigo, Resumen, PrimerDiaSemana, HoraISO, HoraIncluyente)
VALUES ('BelcorpResponde', 'Lunes a Viernes: 08:00 a 20:00 y Sábados: 08:00 a 18:00', 1, 0, 1)
SET @HorarioId = SCOPE_IDENTITY()
/*** INSERT HORARIO DETALLE BELCORP RESPONDE ***/
INSERT INTO HorarioDetalle (HorarioId, DiaSemanaInicio, DiaSemanaFin, HoraInicio, HoraFin)
VALUES (@HorarioId, 1, 5, '08:00:00.0000000', '20:00:00.0000000'),
	   (@HorarioId, 6, 6, '08:00:00.0000000', '18:00:00.0000000')
GO

USE BelcorpEcuador
GO

/****** CREACION TABLAS ******/
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

/****** INSERTANDO DATA *******/

/*** INSERT HORARIO CHAT EMTELCO ***/
DECLARE @HorarioId int = 0
insert into Horario(Codigo,Resumen,PrimerDiaSemana,HoraISO,HoraIncluyente)
values('ChatEmtelco','Lunes a Viernes: 08:00 a 20:00 y Sábados: 08:00 a 18:00',1,0,1)
SET @HorarioId = SCOPE_IDENTITY()
/*** INSERT HORARIO DETALLE CHAT EMTELCO ***/
insert into HorarioDetalle(HorarioId,DiaSemanaInicio,DiaSemanaFin,HoraInicio,HoraFin)
values 
	(@HorarioId,1,5,'08:00','20:00'),
	(@HorarioId,6,6,'08:00','18:00')
GO

/*** INSERT HORARIO BELCORP RESPONDE ***/
DECLARE @HorarioId int = 0
INSERT INTO Horario (Codigo, Resumen, PrimerDiaSemana, HoraISO, HoraIncluyente)
VALUES ('BelcorpResponde', 'Lunes a Viernes: 08:00 a 20:00 y Sábados: 08:00 a 18:00', 1, 0, 1)
SET @HorarioId = SCOPE_IDENTITY()
/*** INSERT HORARIO DETALLE BELCORP RESPONDE ***/
INSERT INTO HorarioDetalle (HorarioId, DiaSemanaInicio, DiaSemanaFin, HoraInicio, HoraFin)
VALUES (@HorarioId, 1, 5, '08:00:00.0000000', '20:00:00.0000000'),
	   (@HorarioId, 6, 6, '08:00:00.0000000', '18:00:00.0000000')
GO

USE BelcorpDominicana
GO

/****** CREACION TABLAS ******/
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

/****** INSERTANDO DATA *******/

/*** INSERT HORARIO CHAT EMTELCO ***/
DECLARE @HorarioId int = 0
insert into Horario(Codigo,Resumen,PrimerDiaSemana,HoraISO,HoraIncluyente)
values('ChatEmtelco','Lunes a Viernes: 08:00 a 20:00 y Sábados: 08:00 a 18:00',1,0,1)
SET @HorarioId = SCOPE_IDENTITY()
/*** INSERT HORARIO DETALLE CHAT EMTELCO ***/
insert into HorarioDetalle(HorarioId,DiaSemanaInicio,DiaSemanaFin,HoraInicio,HoraFin)
values 
	(@HorarioId,1,5,'08:00','20:00'),
	(@HorarioId,6,6,'08:00','18:00')
GO

/*** INSERT HORARIO BELCORP RESPONDE ***/
DECLARE @HorarioId int = 0
INSERT INTO Horario (Codigo, Resumen, PrimerDiaSemana, HoraISO, HoraIncluyente)
VALUES ('BelcorpResponde', 'Lunes a Viernes: 08:00 a 20:00 y Sábados: 08:00 a 18:00', 1, 0, 1)
SET @HorarioId = SCOPE_IDENTITY()
/*** INSERT HORARIO DETALLE BELCORP RESPONDE ***/
INSERT INTO HorarioDetalle (HorarioId, DiaSemanaInicio, DiaSemanaFin, HoraInicio, HoraFin)
VALUES (@HorarioId, 1, 5, '08:00:00.0000000', '20:00:00.0000000'),
	   (@HorarioId, 6, 6, '08:00:00.0000000', '18:00:00.0000000')
GO

USE BelcorpCostaRica
GO

/****** CREACION TABLAS ******/
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

/****** INSERTANDO DATA *******/

/*** INSERT HORARIO CHAT EMTELCO ***/
DECLARE @HorarioId int = 0
insert into Horario(Codigo,Resumen,PrimerDiaSemana,HoraISO,HoraIncluyente)
values('ChatEmtelco','Lunes a Viernes: 08:00 a 20:00 y Sábados: 08:00 a 18:00',1,0,1)
SET @HorarioId = SCOPE_IDENTITY()
/*** INSERT HORARIO DETALLE CHAT EMTELCO ***/
insert into HorarioDetalle(HorarioId,DiaSemanaInicio,DiaSemanaFin,HoraInicio,HoraFin)
values 
	(@HorarioId,1,5,'08:00','20:00'),
	(@HorarioId,6,6,'08:00','18:00')
GO

/*** INSERT HORARIO BELCORP RESPONDE ***/
DECLARE @HorarioId int = 0
INSERT INTO Horario (Codigo, Resumen, PrimerDiaSemana, HoraISO, HoraIncluyente)
VALUES ('BelcorpResponde', 'Lunes a Viernes: 08:00 a 20:00 y Sábados: 08:00 a 18:00', 1, 0, 1)
SET @HorarioId = SCOPE_IDENTITY()
/*** INSERT HORARIO DETALLE BELCORP RESPONDE ***/
INSERT INTO HorarioDetalle (HorarioId, DiaSemanaInicio, DiaSemanaFin, HoraInicio, HoraFin)
VALUES (@HorarioId, 1, 5, '08:00:00.0000000', '20:00:00.0000000'),
	   (@HorarioId, 6, 6, '08:00:00.0000000', '18:00:00.0000000')
GO

USE BelcorpChile
GO

/****** CREACION TABLAS ******/
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

/****** INSERTANDO DATA *******/

/*** INSERT HORARIO CHAT EMTELCO ***/
DECLARE @HorarioId int = 0
insert into Horario(Codigo,Resumen,PrimerDiaSemana,HoraISO,HoraIncluyente)
values('ChatEmtelco','Lunes a Viernes: 08:00 a 20:00 y Sábados: 08:00 a 18:00',1,0,1)
SET @HorarioId = SCOPE_IDENTITY()
/*** INSERT HORARIO DETALLE CHAT EMTELCO ***/
insert into HorarioDetalle(HorarioId,DiaSemanaInicio,DiaSemanaFin,HoraInicio,HoraFin)
values 
	(@HorarioId,1,5,'08:00','20:00'),
	(@HorarioId,6,6,'08:00','18:00')
GO

/*** INSERT HORARIO BELCORP RESPONDE ***/
DECLARE @HorarioId int = 0
INSERT INTO Horario (Codigo, Resumen, PrimerDiaSemana, HoraISO, HoraIncluyente)
VALUES ('BelcorpResponde', 'Lunes a Viernes: 08:00 a 20:00 y Sábados: 08:00 a 18:00', 1, 0, 1)
SET @HorarioId = SCOPE_IDENTITY()
/*** INSERT HORARIO DETALLE BELCORP RESPONDE ***/
INSERT INTO HorarioDetalle (HorarioId, DiaSemanaInicio, DiaSemanaFin, HoraInicio, HoraFin)
VALUES (@HorarioId, 1, 5, '08:00:00.0000000', '20:00:00.0000000'),
	   (@HorarioId, 6, 6, '08:00:00.0000000', '18:00:00.0000000')
GO

USE BelcorpBolivia
GO

/****** CREACION TABLAS ******/
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

/****** INSERTANDO DATA *******/

/*** INSERT HORARIO CHAT EMTELCO ***/
DECLARE @HorarioId int = 0
insert into Horario(Codigo,Resumen,PrimerDiaSemana,HoraISO,HoraIncluyente)
values('ChatEmtelco','Lunes a Viernes: 08:00 a 20:00 y Sábados: 08:00 a 18:00',1,0,1)
SET @HorarioId = SCOPE_IDENTITY()
/*** INSERT HORARIO DETALLE CHAT EMTELCO ***/
insert into HorarioDetalle(HorarioId,DiaSemanaInicio,DiaSemanaFin,HoraInicio,HoraFin)
values 
	(@HorarioId,1,5,'08:00','20:00'),
	(@HorarioId,6,6,'08:00','18:00')
GO

/*** INSERT HORARIO BELCORP RESPONDE ***/
DECLARE @HorarioId int = 0
INSERT INTO Horario (Codigo, Resumen, PrimerDiaSemana, HoraISO, HoraIncluyente)
VALUES ('BelcorpResponde', 'Lunes a Viernes: 08:00 a 20:00 y Sábados: 08:00 a 18:00', 1, 0, 1)
SET @HorarioId = SCOPE_IDENTITY()
/*** INSERT HORARIO DETALLE BELCORP RESPONDE ***/
INSERT INTO HorarioDetalle (HorarioId, DiaSemanaInicio, DiaSemanaFin, HoraInicio, HoraFin)
VALUES (@HorarioId, 1, 5, '08:00:00.0000000', '20:00:00.0000000'),
	   (@HorarioId, 6, 6, '08:00:00.0000000', '18:00:00.0000000')
GO

