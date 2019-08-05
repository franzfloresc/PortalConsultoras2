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
