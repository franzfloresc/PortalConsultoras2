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
                 AND  TABLE_NAME = 'Preguntas'))
DROP TABLE [chatbot].[Preguntas]
GO
create table chatbot.Preguntas (
	PreguntaID int not null identity(1,1),
	Descripcion varchar(300) not null
	PRIMARY KEY (PreguntaID)
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
                 AND  TABLE_NAME = 'Preguntas'))
DROP TABLE [chatbot].[Preguntas]
GO
create table chatbot.Preguntas (
	PreguntaID int not null identity(1,1),
	Descripcion varchar(300) not null
	PRIMARY KEY (PreguntaID)
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
                 AND  TABLE_NAME = 'Preguntas'))
DROP TABLE [chatbot].[Preguntas]
GO
create table chatbot.Preguntas (
	PreguntaID int not null identity(1,1),
	Descripcion varchar(300) not null
	PRIMARY KEY (PreguntaID)
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
                 AND  TABLE_NAME = 'Preguntas'))
DROP TABLE [chatbot].[Preguntas]
GO
create table chatbot.Preguntas (
	PreguntaID int not null identity(1,1),
	Descripcion varchar(300) not null
	PRIMARY KEY (PreguntaID)
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
                 AND  TABLE_NAME = 'Preguntas'))
DROP TABLE [chatbot].[Preguntas]
GO
create table chatbot.Preguntas (
	PreguntaID int not null identity(1,1),
	Descripcion varchar(300) not null
	PRIMARY KEY (PreguntaID)
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
                 AND  TABLE_NAME = 'Preguntas'))
DROP TABLE [chatbot].[Preguntas]
GO
create table chatbot.Preguntas (
	PreguntaID int not null identity(1,1),
	Descripcion varchar(300) not null
	PRIMARY KEY (PreguntaID)
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
                 AND  TABLE_NAME = 'Preguntas'))
DROP TABLE [chatbot].[Preguntas]
GO
create table chatbot.Preguntas (
	PreguntaID int not null identity(1,1),
	Descripcion varchar(300) not null
	PRIMARY KEY (PreguntaID)
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
                 AND  TABLE_NAME = 'Preguntas'))
DROP TABLE [chatbot].[Preguntas]
GO
create table chatbot.Preguntas (
	PreguntaID int not null identity(1,1),
	Descripcion varchar(300) not null
	PRIMARY KEY (PreguntaID)
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
                 AND  TABLE_NAME = 'Preguntas'))
DROP TABLE [chatbot].[Preguntas]
GO
create table chatbot.Preguntas (
	PreguntaID int not null identity(1,1),
	Descripcion varchar(300) not null
	PRIMARY KEY (PreguntaID)
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
                 AND  TABLE_NAME = 'Preguntas'))
DROP TABLE [chatbot].[Preguntas]
GO
create table chatbot.Preguntas (
	PreguntaID int not null identity(1,1),
	Descripcion varchar(300) not null
	PRIMARY KEY (PreguntaID)
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
                 AND  TABLE_NAME = 'Preguntas'))
DROP TABLE [chatbot].[Preguntas]
GO
create table chatbot.Preguntas (
	PreguntaID int not null identity(1,1),
	Descripcion varchar(300) not null
	PRIMARY KEY (PreguntaID)
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
                 AND  TABLE_NAME = 'Preguntas'))
DROP TABLE [chatbot].[Preguntas]
GO
create table chatbot.Preguntas (
	PreguntaID int not null identity(1,1),
	Descripcion varchar(300) not null
	PRIMARY KEY (PreguntaID)
);

GO
