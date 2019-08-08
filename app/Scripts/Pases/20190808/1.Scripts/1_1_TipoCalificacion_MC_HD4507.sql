USE [BelcorpBolivia];
GO
IF (OBJECT_ID(N'PK_TipoCalificacionID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.TipoCalificacion  
	DROP CONSTRAINT PK_TipoCalificacionID;
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
	CONSTRAINT PK_TipoCalificacionID PRIMARY KEY (TipoCalificacionID)
);
GO
USE [BelcorpChile];
GO
IF (OBJECT_ID(N'PK_TipoCalificacionID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.TipoCalificacion  
	DROP CONSTRAINT PK_TipoCalificacionID;
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
	CONSTRAINT PK_TipoCalificacionID PRIMARY KEY (TipoCalificacionID)
);
GO
USE [BelcorpColombia];
GO
IF (OBJECT_ID(N'PK_TipoCalificacionID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.TipoCalificacion  
	DROP CONSTRAINT PK_TipoCalificacionID;
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
	CONSTRAINT PK_TipoCalificacionID PRIMARY KEY (TipoCalificacionID)
);
GO
USE [BelcorpCostaRica];
GO
IF (OBJECT_ID(N'PK_TipoCalificacionID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.TipoCalificacion  
	DROP CONSTRAINT PK_TipoCalificacionID;
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
	CONSTRAINT PK_TipoCalificacionID PRIMARY KEY (TipoCalificacionID)
);
GO
USE [BelcorpDominicana];
GO
IF (OBJECT_ID(N'PK_TipoCalificacionID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.TipoCalificacion  
	DROP CONSTRAINT PK_TipoCalificacionID;
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
	CONSTRAINT PK_TipoCalificacionID PRIMARY KEY (TipoCalificacionID)
);
GO
USE [BelcorpEcuador];
GO
IF (OBJECT_ID(N'PK_TipoCalificacionID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.TipoCalificacion  
	DROP CONSTRAINT PK_TipoCalificacionID;
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
	CONSTRAINT PK_TipoCalificacionID PRIMARY KEY (TipoCalificacionID)
);
GO
USE [BelcorpGuatemala];
GO
IF (OBJECT_ID(N'PK_TipoCalificacionID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.TipoCalificacion  
	DROP CONSTRAINT PK_TipoCalificacionID;
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
	CONSTRAINT PK_TipoCalificacionID PRIMARY KEY (TipoCalificacionID)
);
GO
USE [BelcorpMexico];
GO
IF (OBJECT_ID(N'PK_TipoCalificacionID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.TipoCalificacion  
	DROP CONSTRAINT PK_TipoCalificacionID;
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
	CONSTRAINT PK_TipoCalificacionID PRIMARY KEY (TipoCalificacionID)
);
GO
USE [BelcorpPanama];
GO
IF (OBJECT_ID(N'PK_TipoCalificacionID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.TipoCalificacion  
	DROP CONSTRAINT PK_TipoCalificacionID;
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
	CONSTRAINT PK_TipoCalificacionID PRIMARY KEY (TipoCalificacionID)
);
GO
USE [BelcorpPeru];
GO
IF (OBJECT_ID(N'PK_TipoCalificacionID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.TipoCalificacion  
	DROP CONSTRAINT PK_TipoCalificacionID;
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
	CONSTRAINT PK_TipoCalificacionID PRIMARY KEY (TipoCalificacionID)
);
GO
USE [BelcorpPuertoRico];
GO
IF (OBJECT_ID(N'PK_TipoCalificacionID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.TipoCalificacion  
	DROP CONSTRAINT PK_TipoCalificacionID;
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
	CONSTRAINT PK_TipoCalificacionID PRIMARY KEY (TipoCalificacionID)
);
GO
USE [BelcorpSalvador];
GO
IF (OBJECT_ID(N'PK_TipoCalificacionID', 'PK') IS NOT NULL)
	ALTER TABLE chatbot.TipoCalificacion  
	DROP CONSTRAINT PK_TipoCalificacionID;
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
	CONSTRAINT PK_TipoCalificacionID PRIMARY KEY (TipoCalificacionID)
);
GO
