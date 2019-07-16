GO
USE BelcorpPeru
GO
IF (EXISTS (SELECT name FROM sys.schemas WHERE name = 'chatbot'))
DROP SCHEMA [chatbot]
GO
CREATE SCHEMA chatbot;

GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'TipoCalificacion'))
DROP TABLE [chatbot].[TipoCalificacion]
GO
create table chatbot.TipoCalificacion (
	TipoCalificacionID int not null identity(1,1),
	Valor varchar(50) not null,
	Abreviatura varchar(1) not null
	PRIMARY KEY (TipoCalificacionID)
);

GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Preguntas'))
DROP TABLE [chatbot].[Preguntas]
GO
create table chatbot.Preguntas (
	PreguntaID int not null identity(1,1),
	Descripcion varchar(300) not null
	PRIMARY KEY (PreguntaID)
);

GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Canal'))
DROP TABLE [chatbot].[Canal]
GO
create table chatbot.Canal (
	CanalID int not null identity(1,1),
	Descripcion varchar(70) not null,
	Tipo varchar(20) not null
	PRIMARY KEY (CanalID)
);

GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Calificaciones'))
DROP TABLE [chatbot].[Calificaciones]
GO
create table chatbot.Calificaciones (
	CalificacionID int not null identity(1,1),
	TipoCalificacionID int not null,
	Valor int not null,
	Descripcion varchar(50) not null,
	PRIMARY KEY (CalificacionID),
	FOREIGN KEY (TipoCalificacionID) REFERENCES chatbot.TipoCalificacion(TipoCalificacionID)
);

GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Resultados'))
DROP TABLE [chatbot].[Resultados]
GO
create table chatbot.Resultados (
	ResultadosID int not null identity(1,1),
	OperadorID varchar(50) not null,
	NombreOperador varchar(100) not null,
	CodigoConsultora varchar(25) not null,
	NombreConsultora varchar(150) not null,
	FechaInicio datetime not null,
	FechaFin datetime null,
	Campania varchar(10) null,
	Pais varchar(2) not null,
	ConversacionID varchar(50) not null,
	CanalID int not null
	PRIMARY KEY (ResultadosID),
	FOREIGN KEY (CanalID) REFERENCES chatbot.Canal(CanalID)
);

GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'DetalleResultados'))
DROP TABLE [chatbot].[DetalleResultados]
GO
create table chatbot.DetalleResultados (
	DetalleResultadoID int not null identity(1,1),
	ResultadosID int not null,
	PreguntaID int not null,
	CalificacionID int null,
	Cualitativo varchar(500) null,
	PRIMARY KEY (DetalleResultadoID),
	FOREIGN KEY (ResultadosID) REFERENCES chatbot.Resultados(ResultadosID),
	FOREIGN KEY (PreguntaID) REFERENCES chatbot.Preguntas(PreguntaID),
	FOREIGN KEY (CalificacionID) REFERENCES chatbot.Calificaciones(CalificacionID)
);

GO
USE BelcorpMexico
GO
IF (EXISTS (SELECT name FROM sys.schemas WHERE name = 'chatbot'))
DROP SCHEMA [chatbot]
GO
CREATE SCHEMA chatbot;

GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'TipoCalificacion'))
DROP TABLE [chatbot].[TipoCalificacion]
GO
create table chatbot.TipoCalificacion (
	TipoCalificacionID int not null identity(1,1),
	Valor varchar(50) not null,
	Abreviatura varchar(1) not null
	PRIMARY KEY (TipoCalificacionID)
);

GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Preguntas'))
DROP TABLE [chatbot].[Preguntas]
GO
create table chatbot.Preguntas (
	PreguntaID int not null identity(1,1),
	Descripcion varchar(300) not null
	PRIMARY KEY (PreguntaID)
);

GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Canal'))
DROP TABLE [chatbot].[Canal]
GO
create table chatbot.Canal (
	CanalID int not null identity(1,1),
	Descripcion varchar(70) not null,
	Tipo varchar(20) not null
	PRIMARY KEY (CanalID)
);

GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Calificaciones'))
DROP TABLE [chatbot].[Calificaciones]
GO
create table chatbot.Calificaciones (
	CalificacionID int not null identity(1,1),
	TipoCalificacionID int not null,
	Valor int not null,
	Descripcion varchar(50) not null,
	PRIMARY KEY (CalificacionID),
	FOREIGN KEY (TipoCalificacionID) REFERENCES chatbot.TipoCalificacion(TipoCalificacionID)
);

GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Resultados'))
DROP TABLE [chatbot].[Resultados]
GO
create table chatbot.Resultados (
	ResultadosID int not null identity(1,1),
	OperadorID varchar(50) not null,
	NombreOperador varchar(100) not null,
	CodigoConsultora varchar(25) not null,
	NombreConsultora varchar(150) not null,
	FechaInicio datetime not null,
	FechaFin datetime null,
	Campania varchar(10) null,
	Pais varchar(2) not null,
	ConversacionID varchar(50) not null,
	CanalID int not null
	PRIMARY KEY (ResultadosID),
	FOREIGN KEY (CanalID) REFERENCES chatbot.Canal(CanalID)
);

GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'DetalleResultados'))
DROP TABLE [chatbot].[DetalleResultados]
GO
create table chatbot.DetalleResultados (
	DetalleResultadoID int not null identity(1,1),
	ResultadosID int not null,
	PreguntaID int not null,
	CalificacionID int null,
	Cualitativo varchar(500) null,
	PRIMARY KEY (DetalleResultadoID),
	FOREIGN KEY (ResultadosID) REFERENCES chatbot.Resultados(ResultadosID),
	FOREIGN KEY (PreguntaID) REFERENCES chatbot.Preguntas(PreguntaID),
	FOREIGN KEY (CalificacionID) REFERENCES chatbot.Calificaciones(CalificacionID)
);

GO
USE BelcorpColombia
GO
IF (EXISTS (SELECT name FROM sys.schemas WHERE name = 'chatbot'))
DROP SCHEMA [chatbot]
GO
CREATE SCHEMA chatbot;

GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'TipoCalificacion'))
DROP TABLE [chatbot].[TipoCalificacion]
GO
create table chatbot.TipoCalificacion (
	TipoCalificacionID int not null identity(1,1),
	Valor varchar(50) not null,
	Abreviatura varchar(1) not null
	PRIMARY KEY (TipoCalificacionID)
);

GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Preguntas'))
DROP TABLE [chatbot].[Preguntas]
GO
create table chatbot.Preguntas (
	PreguntaID int not null identity(1,1),
	Descripcion varchar(300) not null
	PRIMARY KEY (PreguntaID)
);

GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Canal'))
DROP TABLE [chatbot].[Canal]
GO
create table chatbot.Canal (
	CanalID int not null identity(1,1),
	Descripcion varchar(70) not null,
	Tipo varchar(20) not null
	PRIMARY KEY (CanalID)
);

GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Calificaciones'))
DROP TABLE [chatbot].[Calificaciones]
GO
create table chatbot.Calificaciones (
	CalificacionID int not null identity(1,1),
	TipoCalificacionID int not null,
	Valor int not null,
	Descripcion varchar(50) not null,
	PRIMARY KEY (CalificacionID),
	FOREIGN KEY (TipoCalificacionID) REFERENCES chatbot.TipoCalificacion(TipoCalificacionID)
);

GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Resultados'))
DROP TABLE [chatbot].[Resultados]
GO
create table chatbot.Resultados (
	ResultadosID int not null identity(1,1),
	OperadorID varchar(50) not null,
	NombreOperador varchar(100) not null,
	CodigoConsultora varchar(25) not null,
	NombreConsultora varchar(150) not null,
	FechaInicio datetime not null,
	FechaFin datetime null,
	Campania varchar(10) null,
	Pais varchar(2) not null,
	ConversacionID varchar(50) not null,
	CanalID int not null
	PRIMARY KEY (ResultadosID),
	FOREIGN KEY (CanalID) REFERENCES chatbot.Canal(CanalID)
);

GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'DetalleResultados'))
DROP TABLE [chatbot].[DetalleResultados]
GO
create table chatbot.DetalleResultados (
	DetalleResultadoID int not null identity(1,1),
	ResultadosID int not null,
	PreguntaID int not null,
	CalificacionID int null,
	Cualitativo varchar(500) null,
	PRIMARY KEY (DetalleResultadoID),
	FOREIGN KEY (ResultadosID) REFERENCES chatbot.Resultados(ResultadosID),
	FOREIGN KEY (PreguntaID) REFERENCES chatbot.Preguntas(PreguntaID),
	FOREIGN KEY (CalificacionID) REFERENCES chatbot.Calificaciones(CalificacionID)
);

GO
USE BelcorpSalvador
GO
IF (EXISTS (SELECT name FROM sys.schemas WHERE name = 'chatbot'))
DROP SCHEMA [chatbot]
GO
CREATE SCHEMA chatbot;

GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'TipoCalificacion'))
DROP TABLE [chatbot].[TipoCalificacion]
GO
create table chatbot.TipoCalificacion (
	TipoCalificacionID int not null identity(1,1),
	Valor varchar(50) not null,
	Abreviatura varchar(1) not null
	PRIMARY KEY (TipoCalificacionID)
);

GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Preguntas'))
DROP TABLE [chatbot].[Preguntas]
GO
create table chatbot.Preguntas (
	PreguntaID int not null identity(1,1),
	Descripcion varchar(300) not null
	PRIMARY KEY (PreguntaID)
);

GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Canal'))
DROP TABLE [chatbot].[Canal]
GO
create table chatbot.Canal (
	CanalID int not null identity(1,1),
	Descripcion varchar(70) not null,
	Tipo varchar(20) not null
	PRIMARY KEY (CanalID)
);

GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Calificaciones'))
DROP TABLE [chatbot].[Calificaciones]
GO
create table chatbot.Calificaciones (
	CalificacionID int not null identity(1,1),
	TipoCalificacionID int not null,
	Valor int not null,
	Descripcion varchar(50) not null,
	PRIMARY KEY (CalificacionID),
	FOREIGN KEY (TipoCalificacionID) REFERENCES chatbot.TipoCalificacion(TipoCalificacionID)
);

GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Resultados'))
DROP TABLE [chatbot].[Resultados]
GO
create table chatbot.Resultados (
	ResultadosID int not null identity(1,1),
	OperadorID varchar(50) not null,
	NombreOperador varchar(100) not null,
	CodigoConsultora varchar(25) not null,
	NombreConsultora varchar(150) not null,
	FechaInicio datetime not null,
	FechaFin datetime null,
	Campania varchar(10) null,
	Pais varchar(2) not null,
	ConversacionID varchar(50) not null,
	CanalID int not null
	PRIMARY KEY (ResultadosID),
	FOREIGN KEY (CanalID) REFERENCES chatbot.Canal(CanalID)
);

GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'DetalleResultados'))
DROP TABLE [chatbot].[DetalleResultados]
GO
create table chatbot.DetalleResultados (
	DetalleResultadoID int not null identity(1,1),
	ResultadosID int not null,
	PreguntaID int not null,
	CalificacionID int null,
	Cualitativo varchar(500) null,
	PRIMARY KEY (DetalleResultadoID),
	FOREIGN KEY (ResultadosID) REFERENCES chatbot.Resultados(ResultadosID),
	FOREIGN KEY (PreguntaID) REFERENCES chatbot.Preguntas(PreguntaID),
	FOREIGN KEY (CalificacionID) REFERENCES chatbot.Calificaciones(CalificacionID)
);

GO
USE BelcorpPuertoRico
GO
IF (EXISTS (SELECT name FROM sys.schemas WHERE name = 'chatbot'))
DROP SCHEMA [chatbot]
GO
CREATE SCHEMA chatbot;

GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'TipoCalificacion'))
DROP TABLE [chatbot].[TipoCalificacion]
GO
create table chatbot.TipoCalificacion (
	TipoCalificacionID int not null identity(1,1),
	Valor varchar(50) not null,
	Abreviatura varchar(1) not null
	PRIMARY KEY (TipoCalificacionID)
);

GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Preguntas'))
DROP TABLE [chatbot].[Preguntas]
GO
create table chatbot.Preguntas (
	PreguntaID int not null identity(1,1),
	Descripcion varchar(300) not null
	PRIMARY KEY (PreguntaID)
);

GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Canal'))
DROP TABLE [chatbot].[Canal]
GO
create table chatbot.Canal (
	CanalID int not null identity(1,1),
	Descripcion varchar(70) not null,
	Tipo varchar(20) not null
	PRIMARY KEY (CanalID)
);

GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Calificaciones'))
DROP TABLE [chatbot].[Calificaciones]
GO
create table chatbot.Calificaciones (
	CalificacionID int not null identity(1,1),
	TipoCalificacionID int not null,
	Valor int not null,
	Descripcion varchar(50) not null,
	PRIMARY KEY (CalificacionID),
	FOREIGN KEY (TipoCalificacionID) REFERENCES chatbot.TipoCalificacion(TipoCalificacionID)
);

GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Resultados'))
DROP TABLE [chatbot].[Resultados]
GO
create table chatbot.Resultados (
	ResultadosID int not null identity(1,1),
	OperadorID varchar(50) not null,
	NombreOperador varchar(100) not null,
	CodigoConsultora varchar(25) not null,
	NombreConsultora varchar(150) not null,
	FechaInicio datetime not null,
	FechaFin datetime null,
	Campania varchar(10) null,
	Pais varchar(2) not null,
	ConversacionID varchar(50) not null,
	CanalID int not null
	PRIMARY KEY (ResultadosID),
	FOREIGN KEY (CanalID) REFERENCES chatbot.Canal(CanalID)
);

GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'DetalleResultados'))
DROP TABLE [chatbot].[DetalleResultados]
GO
create table chatbot.DetalleResultados (
	DetalleResultadoID int not null identity(1,1),
	ResultadosID int not null,
	PreguntaID int not null,
	CalificacionID int null,
	Cualitativo varchar(500) null,
	PRIMARY KEY (DetalleResultadoID),
	FOREIGN KEY (ResultadosID) REFERENCES chatbot.Resultados(ResultadosID),
	FOREIGN KEY (PreguntaID) REFERENCES chatbot.Preguntas(PreguntaID),
	FOREIGN KEY (CalificacionID) REFERENCES chatbot.Calificaciones(CalificacionID)
);

GO
USE BelcorpPanama
GO
IF (EXISTS (SELECT name FROM sys.schemas WHERE name = 'chatbot'))
DROP SCHEMA [chatbot]
GO
CREATE SCHEMA chatbot;

GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'TipoCalificacion'))
DROP TABLE [chatbot].[TipoCalificacion]
GO
create table chatbot.TipoCalificacion (
	TipoCalificacionID int not null identity(1,1),
	Valor varchar(50) not null,
	Abreviatura varchar(1) not null
	PRIMARY KEY (TipoCalificacionID)
);

GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Preguntas'))
DROP TABLE [chatbot].[Preguntas]
GO
create table chatbot.Preguntas (
	PreguntaID int not null identity(1,1),
	Descripcion varchar(300) not null
	PRIMARY KEY (PreguntaID)
);

GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Canal'))
DROP TABLE [chatbot].[Canal]
GO
create table chatbot.Canal (
	CanalID int not null identity(1,1),
	Descripcion varchar(70) not null,
	Tipo varchar(20) not null
	PRIMARY KEY (CanalID)
);

GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Calificaciones'))
DROP TABLE [chatbot].[Calificaciones]
GO
create table chatbot.Calificaciones (
	CalificacionID int not null identity(1,1),
	TipoCalificacionID int not null,
	Valor int not null,
	Descripcion varchar(50) not null,
	PRIMARY KEY (CalificacionID),
	FOREIGN KEY (TipoCalificacionID) REFERENCES chatbot.TipoCalificacion(TipoCalificacionID)
);

GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Resultados'))
DROP TABLE [chatbot].[Resultados]
GO
create table chatbot.Resultados (
	ResultadosID int not null identity(1,1),
	OperadorID varchar(50) not null,
	NombreOperador varchar(100) not null,
	CodigoConsultora varchar(25) not null,
	NombreConsultora varchar(150) not null,
	FechaInicio datetime not null,
	FechaFin datetime null,
	Campania varchar(10) null,
	Pais varchar(2) not null,
	ConversacionID varchar(50) not null,
	CanalID int not null
	PRIMARY KEY (ResultadosID),
	FOREIGN KEY (CanalID) REFERENCES chatbot.Canal(CanalID)
);

GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'DetalleResultados'))
DROP TABLE [chatbot].[DetalleResultados]
GO
create table chatbot.DetalleResultados (
	DetalleResultadoID int not null identity(1,1),
	ResultadosID int not null,
	PreguntaID int not null,
	CalificacionID int null,
	Cualitativo varchar(500) null,
	PRIMARY KEY (DetalleResultadoID),
	FOREIGN KEY (ResultadosID) REFERENCES chatbot.Resultados(ResultadosID),
	FOREIGN KEY (PreguntaID) REFERENCES chatbot.Preguntas(PreguntaID),
	FOREIGN KEY (CalificacionID) REFERENCES chatbot.Calificaciones(CalificacionID)
);

GO
USE BelcorpGuatemala
GO
IF (EXISTS (SELECT name FROM sys.schemas WHERE name = 'chatbot'))
DROP SCHEMA [chatbot]
GO
CREATE SCHEMA chatbot;

GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'TipoCalificacion'))
DROP TABLE [chatbot].[TipoCalificacion]
GO
create table chatbot.TipoCalificacion (
	TipoCalificacionID int not null identity(1,1),
	Valor varchar(50) not null,
	Abreviatura varchar(1) not null
	PRIMARY KEY (TipoCalificacionID)
);

GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Preguntas'))
DROP TABLE [chatbot].[Preguntas]
GO
create table chatbot.Preguntas (
	PreguntaID int not null identity(1,1),
	Descripcion varchar(300) not null
	PRIMARY KEY (PreguntaID)
);

GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Canal'))
DROP TABLE [chatbot].[Canal]
GO
create table chatbot.Canal (
	CanalID int not null identity(1,1),
	Descripcion varchar(70) not null,
	Tipo varchar(20) not null
	PRIMARY KEY (CanalID)
);

GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Calificaciones'))
DROP TABLE [chatbot].[Calificaciones]
GO
create table chatbot.Calificaciones (
	CalificacionID int not null identity(1,1),
	TipoCalificacionID int not null,
	Valor int not null,
	Descripcion varchar(50) not null,
	PRIMARY KEY (CalificacionID),
	FOREIGN KEY (TipoCalificacionID) REFERENCES chatbot.TipoCalificacion(TipoCalificacionID)
);

GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Resultados'))
DROP TABLE [chatbot].[Resultados]
GO
create table chatbot.Resultados (
	ResultadosID int not null identity(1,1),
	OperadorID varchar(50) not null,
	NombreOperador varchar(100) not null,
	CodigoConsultora varchar(25) not null,
	NombreConsultora varchar(150) not null,
	FechaInicio datetime not null,
	FechaFin datetime null,
	Campania varchar(10) null,
	Pais varchar(2) not null,
	ConversacionID varchar(50) not null,
	CanalID int not null
	PRIMARY KEY (ResultadosID),
	FOREIGN KEY (CanalID) REFERENCES chatbot.Canal(CanalID)
);

GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'DetalleResultados'))
DROP TABLE [chatbot].[DetalleResultados]
GO
create table chatbot.DetalleResultados (
	DetalleResultadoID int not null identity(1,1),
	ResultadosID int not null,
	PreguntaID int not null,
	CalificacionID int null,
	Cualitativo varchar(500) null,
	PRIMARY KEY (DetalleResultadoID),
	FOREIGN KEY (ResultadosID) REFERENCES chatbot.Resultados(ResultadosID),
	FOREIGN KEY (PreguntaID) REFERENCES chatbot.Preguntas(PreguntaID),
	FOREIGN KEY (CalificacionID) REFERENCES chatbot.Calificaciones(CalificacionID)
);

GO
USE BelcorpEcuador
GO
IF (EXISTS (SELECT name FROM sys.schemas WHERE name = 'chatbot'))
DROP SCHEMA [chatbot]
GO
CREATE SCHEMA chatbot;

GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'TipoCalificacion'))
DROP TABLE [chatbot].[TipoCalificacion]
GO
create table chatbot.TipoCalificacion (
	TipoCalificacionID int not null identity(1,1),
	Valor varchar(50) not null,
	Abreviatura varchar(1) not null
	PRIMARY KEY (TipoCalificacionID)
);

GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Preguntas'))
DROP TABLE [chatbot].[Preguntas]
GO
create table chatbot.Preguntas (
	PreguntaID int not null identity(1,1),
	Descripcion varchar(300) not null
	PRIMARY KEY (PreguntaID)
);

GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Canal'))
DROP TABLE [chatbot].[Canal]
GO
create table chatbot.Canal (
	CanalID int not null identity(1,1),
	Descripcion varchar(70) not null,
	Tipo varchar(20) not null
	PRIMARY KEY (CanalID)
);

GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Calificaciones'))
DROP TABLE [chatbot].[Calificaciones]
GO
create table chatbot.Calificaciones (
	CalificacionID int not null identity(1,1),
	TipoCalificacionID int not null,
	Valor int not null,
	Descripcion varchar(50) not null,
	PRIMARY KEY (CalificacionID),
	FOREIGN KEY (TipoCalificacionID) REFERENCES chatbot.TipoCalificacion(TipoCalificacionID)
);

GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Resultados'))
DROP TABLE [chatbot].[Resultados]
GO
create table chatbot.Resultados (
	ResultadosID int not null identity(1,1),
	OperadorID varchar(50) not null,
	NombreOperador varchar(100) not null,
	CodigoConsultora varchar(25) not null,
	NombreConsultora varchar(150) not null,
	FechaInicio datetime not null,
	FechaFin datetime null,
	Campania varchar(10) null,
	Pais varchar(2) not null,
	ConversacionID varchar(50) not null,
	CanalID int not null
	PRIMARY KEY (ResultadosID),
	FOREIGN KEY (CanalID) REFERENCES chatbot.Canal(CanalID)
);

GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'DetalleResultados'))
DROP TABLE [chatbot].[DetalleResultados]
GO
create table chatbot.DetalleResultados (
	DetalleResultadoID int not null identity(1,1),
	ResultadosID int not null,
	PreguntaID int not null,
	CalificacionID int null,
	Cualitativo varchar(500) null,
	PRIMARY KEY (DetalleResultadoID),
	FOREIGN KEY (ResultadosID) REFERENCES chatbot.Resultados(ResultadosID),
	FOREIGN KEY (PreguntaID) REFERENCES chatbot.Preguntas(PreguntaID),
	FOREIGN KEY (CalificacionID) REFERENCES chatbot.Calificaciones(CalificacionID)
);

GO
USE BelcorpDominicana
GO
IF (EXISTS (SELECT name FROM sys.schemas WHERE name = 'chatbot'))
DROP SCHEMA [chatbot]
GO
CREATE SCHEMA chatbot;

GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'TipoCalificacion'))
DROP TABLE [chatbot].[TipoCalificacion]
GO
create table chatbot.TipoCalificacion (
	TipoCalificacionID int not null identity(1,1),
	Valor varchar(50) not null,
	Abreviatura varchar(1) not null
	PRIMARY KEY (TipoCalificacionID)
);

GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Preguntas'))
DROP TABLE [chatbot].[Preguntas]
GO
create table chatbot.Preguntas (
	PreguntaID int not null identity(1,1),
	Descripcion varchar(300) not null
	PRIMARY KEY (PreguntaID)
);

GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Canal'))
DROP TABLE [chatbot].[Canal]
GO
create table chatbot.Canal (
	CanalID int not null identity(1,1),
	Descripcion varchar(70) not null,
	Tipo varchar(20) not null
	PRIMARY KEY (CanalID)
);

GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Calificaciones'))
DROP TABLE [chatbot].[Calificaciones]
GO
create table chatbot.Calificaciones (
	CalificacionID int not null identity(1,1),
	TipoCalificacionID int not null,
	Valor int not null,
	Descripcion varchar(50) not null,
	PRIMARY KEY (CalificacionID),
	FOREIGN KEY (TipoCalificacionID) REFERENCES chatbot.TipoCalificacion(TipoCalificacionID)
);

GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Resultados'))
DROP TABLE [chatbot].[Resultados]
GO
create table chatbot.Resultados (
	ResultadosID int not null identity(1,1),
	OperadorID varchar(50) not null,
	NombreOperador varchar(100) not null,
	CodigoConsultora varchar(25) not null,
	NombreConsultora varchar(150) not null,
	FechaInicio datetime not null,
	FechaFin datetime null,
	Campania varchar(10) null,
	Pais varchar(2) not null,
	ConversacionID varchar(50) not null,
	CanalID int not null
	PRIMARY KEY (ResultadosID),
	FOREIGN KEY (CanalID) REFERENCES chatbot.Canal(CanalID)
);

GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'DetalleResultados'))
DROP TABLE [chatbot].[DetalleResultados]
GO
create table chatbot.DetalleResultados (
	DetalleResultadoID int not null identity(1,1),
	ResultadosID int not null,
	PreguntaID int not null,
	CalificacionID int null,
	Cualitativo varchar(500) null,
	PRIMARY KEY (DetalleResultadoID),
	FOREIGN KEY (ResultadosID) REFERENCES chatbot.Resultados(ResultadosID),
	FOREIGN KEY (PreguntaID) REFERENCES chatbot.Preguntas(PreguntaID),
	FOREIGN KEY (CalificacionID) REFERENCES chatbot.Calificaciones(CalificacionID)
);

GO
USE BelcorpCostaRica
GO
IF (EXISTS (SELECT name FROM sys.schemas WHERE name = 'chatbot'))
DROP SCHEMA [chatbot]
GO
CREATE SCHEMA chatbot;

GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'TipoCalificacion'))
DROP TABLE [chatbot].[TipoCalificacion]
GO
create table chatbot.TipoCalificacion (
	TipoCalificacionID int not null identity(1,1),
	Valor varchar(50) not null,
	Abreviatura varchar(1) not null
	PRIMARY KEY (TipoCalificacionID)
);

GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Preguntas'))
DROP TABLE [chatbot].[Preguntas]
GO
create table chatbot.Preguntas (
	PreguntaID int not null identity(1,1),
	Descripcion varchar(300) not null
	PRIMARY KEY (PreguntaID)
);

GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Canal'))
DROP TABLE [chatbot].[Canal]
GO
create table chatbot.Canal (
	CanalID int not null identity(1,1),
	Descripcion varchar(70) not null,
	Tipo varchar(20) not null
	PRIMARY KEY (CanalID)
);

GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Calificaciones'))
DROP TABLE [chatbot].[Calificaciones]
GO
create table chatbot.Calificaciones (
	CalificacionID int not null identity(1,1),
	TipoCalificacionID int not null,
	Valor int not null,
	Descripcion varchar(50) not null,
	PRIMARY KEY (CalificacionID),
	FOREIGN KEY (TipoCalificacionID) REFERENCES chatbot.TipoCalificacion(TipoCalificacionID)
);

GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Resultados'))
DROP TABLE [chatbot].[Resultados]
GO
create table chatbot.Resultados (
	ResultadosID int not null identity(1,1),
	OperadorID varchar(50) not null,
	NombreOperador varchar(100) not null,
	CodigoConsultora varchar(25) not null,
	NombreConsultora varchar(150) not null,
	FechaInicio datetime not null,
	FechaFin datetime null,
	Campania varchar(10) null,
	Pais varchar(2) not null,
	ConversacionID varchar(50) not null,
	CanalID int not null
	PRIMARY KEY (ResultadosID),
	FOREIGN KEY (CanalID) REFERENCES chatbot.Canal(CanalID)
);

GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'DetalleResultados'))
DROP TABLE [chatbot].[DetalleResultados]
GO
create table chatbot.DetalleResultados (
	DetalleResultadoID int not null identity(1,1),
	ResultadosID int not null,
	PreguntaID int not null,
	CalificacionID int null,
	Cualitativo varchar(500) null,
	PRIMARY KEY (DetalleResultadoID),
	FOREIGN KEY (ResultadosID) REFERENCES chatbot.Resultados(ResultadosID),
	FOREIGN KEY (PreguntaID) REFERENCES chatbot.Preguntas(PreguntaID),
	FOREIGN KEY (CalificacionID) REFERENCES chatbot.Calificaciones(CalificacionID)
);

GO
USE BelcorpChile
GO
IF (EXISTS (SELECT name FROM sys.schemas WHERE name = 'chatbot'))
DROP SCHEMA [chatbot]
GO
CREATE SCHEMA chatbot;

GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'TipoCalificacion'))
DROP TABLE [chatbot].[TipoCalificacion]
GO
create table chatbot.TipoCalificacion (
	TipoCalificacionID int not null identity(1,1),
	Valor varchar(50) not null,
	Abreviatura varchar(1) not null
	PRIMARY KEY (TipoCalificacionID)
);

GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Preguntas'))
DROP TABLE [chatbot].[Preguntas]
GO
create table chatbot.Preguntas (
	PreguntaID int not null identity(1,1),
	Descripcion varchar(300) not null
	PRIMARY KEY (PreguntaID)
);

GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Canal'))
DROP TABLE [chatbot].[Canal]
GO
create table chatbot.Canal (
	CanalID int not null identity(1,1),
	Descripcion varchar(70) not null,
	Tipo varchar(20) not null
	PRIMARY KEY (CanalID)
);

GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Calificaciones'))
DROP TABLE [chatbot].[Calificaciones]
GO
create table chatbot.Calificaciones (
	CalificacionID int not null identity(1,1),
	TipoCalificacionID int not null,
	Valor int not null,
	Descripcion varchar(50) not null,
	PRIMARY KEY (CalificacionID),
	FOREIGN KEY (TipoCalificacionID) REFERENCES chatbot.TipoCalificacion(TipoCalificacionID)
);

GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Resultados'))
DROP TABLE [chatbot].[Resultados]
GO
create table chatbot.Resultados (
	ResultadosID int not null identity(1,1),
	OperadorID varchar(50) not null,
	NombreOperador varchar(100) not null,
	CodigoConsultora varchar(25) not null,
	NombreConsultora varchar(150) not null,
	FechaInicio datetime not null,
	FechaFin datetime null,
	Campania varchar(10) null,
	Pais varchar(2) not null,
	ConversacionID varchar(50) not null,
	CanalID int not null
	PRIMARY KEY (ResultadosID),
	FOREIGN KEY (CanalID) REFERENCES chatbot.Canal(CanalID)
);

GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'DetalleResultados'))
DROP TABLE [chatbot].[DetalleResultados]
GO
create table chatbot.DetalleResultados (
	DetalleResultadoID int not null identity(1,1),
	ResultadosID int not null,
	PreguntaID int not null,
	CalificacionID int null,
	Cualitativo varchar(500) null,
	PRIMARY KEY (DetalleResultadoID),
	FOREIGN KEY (ResultadosID) REFERENCES chatbot.Resultados(ResultadosID),
	FOREIGN KEY (PreguntaID) REFERENCES chatbot.Preguntas(PreguntaID),
	FOREIGN KEY (CalificacionID) REFERENCES chatbot.Calificaciones(CalificacionID)
);

GO
USE BelcorpBolivia
GO
IF (EXISTS (SELECT name FROM sys.schemas WHERE name = 'chatbot'))
DROP SCHEMA [chatbot]
GO
CREATE SCHEMA chatbot;

GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'TipoCalificacion'))
DROP TABLE [chatbot].[TipoCalificacion]
GO
create table chatbot.TipoCalificacion (
	TipoCalificacionID int not null identity(1,1),
	Valor varchar(50) not null,
	Abreviatura varchar(1) not null
	PRIMARY KEY (TipoCalificacionID)
);

GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Preguntas'))
DROP TABLE [chatbot].[Preguntas]
GO
create table chatbot.Preguntas (
	PreguntaID int not null identity(1,1),
	Descripcion varchar(300) not null
	PRIMARY KEY (PreguntaID)
);

GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Canal'))
DROP TABLE [chatbot].[Canal]
GO
create table chatbot.Canal (
	CanalID int not null identity(1,1),
	Descripcion varchar(70) not null,
	Tipo varchar(20) not null
	PRIMARY KEY (CanalID)
);

GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Calificaciones'))
DROP TABLE [chatbot].[Calificaciones]
GO
create table chatbot.Calificaciones (
	CalificacionID int not null identity(1,1),
	TipoCalificacionID int not null,
	Valor int not null,
	Descripcion varchar(50) not null,
	PRIMARY KEY (CalificacionID),
	FOREIGN KEY (TipoCalificacionID) REFERENCES chatbot.TipoCalificacion(TipoCalificacionID)
);

GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'Resultados'))
DROP TABLE [chatbot].[Resultados]
GO
create table chatbot.Resultados (
	ResultadosID int not null identity(1,1),
	OperadorID varchar(50) not null,
	NombreOperador varchar(100) not null,
	CodigoConsultora varchar(25) not null,
	NombreConsultora varchar(150) not null,
	FechaInicio datetime not null,
	FechaFin datetime null,
	Campania varchar(10) null,
	Pais varchar(2) not null,
	ConversacionID varchar(50) not null,
	CanalID int not null
	PRIMARY KEY (ResultadosID),
	FOREIGN KEY (CanalID) REFERENCES chatbot.Canal(CanalID)
);

GO
IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'chatbot'
                 AND  TABLE_NAME = 'DetalleResultados'))
DROP TABLE [chatbot].[DetalleResultados]
GO
create table chatbot.DetalleResultados (
	DetalleResultadoID int not null identity(1,1),
	ResultadosID int not null,
	PreguntaID int not null,
	CalificacionID int null,
	Cualitativo varchar(500) null,
	PRIMARY KEY (DetalleResultadoID),
	FOREIGN KEY (ResultadosID) REFERENCES chatbot.Resultados(ResultadosID),
	FOREIGN KEY (PreguntaID) REFERENCES chatbot.Preguntas(PreguntaID),
	FOREIGN KEY (CalificacionID) REFERENCES chatbot.Calificaciones(CalificacionID)
);

GO
