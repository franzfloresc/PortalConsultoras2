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
