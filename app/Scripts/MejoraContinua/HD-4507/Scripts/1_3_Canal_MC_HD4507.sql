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
