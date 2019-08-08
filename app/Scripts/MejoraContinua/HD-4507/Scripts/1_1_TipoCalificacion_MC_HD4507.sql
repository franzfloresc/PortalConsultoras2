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
